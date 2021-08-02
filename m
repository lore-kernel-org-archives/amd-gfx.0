Return-Path: <SRS0=SMOw=MZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43A1C432BE
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 13:40:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E9D960FA0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 13:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8E9D960FA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A54336E332;
	Mon,  2 Aug 2021 13:40:15 +0000 (UTC)
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 716076E400;
 Mon,  2 Aug 2021 10:42:20 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 06300379; Mon,  2 Aug 2021 12:42:18 +0200 (CEST)
Date: Mon, 2 Aug 2021 12:42:17 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
 linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
 Brijesh Singh <brijesh.singh@amd.com>, Andi Kleen <ak@linux.intel.com>,
 Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 05/11] x86/sev: Replace occurrences of sev_active() with
 prot_guest_has()
Message-ID: <YQfMCXN0z+LhNBdN@8bytes.org>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <fa4cdba858e5cb20da2bcd31acf6959ae391bded.1627424774.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa4cdba858e5cb20da2bcd31acf6959ae391bded.1627424774.git.thomas.lendacky@amd.com>
X-Mailman-Approved-At: Mon, 02 Aug 2021 13:40:13 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 27, 2021 at 05:26:08PM -0500, Tom Lendacky wrote:
> Replace occurrences of sev_active() with the more generic prot_guest_has()
> using PATTR_GUEST_MEM_ENCRYPT, except for in arch/x86/mm/mem_encrypt*.c
> where PATTR_SEV will be used. If future support is added for other memory
> encryption technologies, the use of PATTR_GUEST_MEM_ENCRYPT can be
> updated, as required, to use PATTR_SEV.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

Reviewed-by: Joerg Roedel <jroedel@suse.de>
