Return-Path: <SRS0=+Fjx=BT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C73C433E0
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Aug 2020 23:59:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD7A2206A1
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Aug 2020 23:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7A2206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D2C26E33D;
	Sun,  9 Aug 2020 23:59:04 +0000 (UTC)
X-Greylist: delayed 1909 seconds by postgrey-1.36 at gabe;
 Sat, 08 Aug 2020 14:13:52 UTC
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
 by gabe.freedesktop.org (Postfix) with ESMTP id 22DE16E219
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Aug 2020 14:13:52 +0000 (UTC)
Received: from uucp (helo=alpha)
 by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
 id 1k4P6k-0004vB-00; Sat, 08 Aug 2020 15:41:58 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
 id 19B0AC0C98; Sat,  8 Aug 2020 15:41:47 +0200 (CEST)
Date: Sat, 8 Aug 2020 15:41:47 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH] gpu/drm: Remove TTM_PL_FLAG_WC of VRAM to fix
 writecombine issue for Loongson64
Message-ID: <20200808134147.GA5772@alpha.franken.de>
References: <1596871502-3432-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1596871502-3432-1-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailman-Approved-At: Sun, 09 Aug 2020 23:59:03 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: linux-mips@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Alex Deucher <alexander.deucher@amd.com>, Huacai Chen <chenhc@lemote.com>,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Aug 08, 2020 at 03:25:02PM +0800, Tiezhu Yang wrote:
> Loongson processors have a writecombine issue that maybe failed to
> write back framebuffer used with ATI Radeon or AMD GPU at times,
> after commit 8a08e50cee66 ("drm: Permit video-buffers writecombine
> mapping for MIPS"), there exists some errors such as blurred screen
> and lockup, and so on.
> 
> Remove the flag TTM_PL_FLAG_WC of VRAM to fix writecombine issue for
> Loongson64 to work well with ATI Radeon or AMD GPU, and it has no any
> influence on the other platforms.

well it's not my call to take or reject this patch, but I already
indicated it might be better to disable writecombine on the CPU
detection side (or do you have other devices where writecombining
works ?). Something like below will disbale it for all loongson64 CPUs.
If you now find out where it works and where it doesn't, you can even
reduce it to the required minium of affected CPUs.

Thomas.


diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index def1659fe262..cdd87009e931 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -2043,7 +2043,6 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 			set_isa(c, MIPS_CPU_ISA_M64R2);
 			break;
 		}
-		c->writecombine = _CACHE_UNCACHED_ACCELERATED;
 		c->ases |= (MIPS_ASE_LOONGSON_MMI | MIPS_ASE_LOONGSON_EXT |
 				MIPS_ASE_LOONGSON_EXT2);
 		break;
@@ -2073,7 +2072,6 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 		 * register, we correct it here.
 		 */
 		c->options |= MIPS_CPU_FTLB | MIPS_CPU_TLBINV | MIPS_CPU_LDPTE;
-		c->writecombine = _CACHE_UNCACHED_ACCELERATED;
 		c->ases |= (MIPS_ASE_LOONGSON_MMI | MIPS_ASE_LOONGSON_CAM |
 			MIPS_ASE_LOONGSON_EXT | MIPS_ASE_LOONGSON_EXT2);
 		c->ases &= ~MIPS_ASE_VZ; /* VZ of Loongson-3A2000/3000 is incomplete */
@@ -2084,7 +2082,6 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 		set_elf_platform(cpu, "loongson3a");
 		set_isa(c, MIPS_CPU_ISA_M64R2);
 		decode_cpucfg(c);
-		c->writecombine = _CACHE_UNCACHED_ACCELERATED;
 		break;
 	default:
 		panic("Unknown Loongson Processor ID!");

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
