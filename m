Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A41606A32C
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=tylorstech.com header.i=@tylorstech.com header.a=rsa-sha256 header.s=x header.b=1fih5ECV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5D0A112B41;
	Fri, 20 Nov 2026 14:56:57 +0000 (UTC)
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Fri, 20 Nov 2026 02:57:56 UTC
Received: from mail-108-mta63.mxroute.com (mail-108-mta63.mxroute.com
 [136.175.108.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FB0610E05E
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 02:57:56 +0000 (UTC)
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta63.mxroute.com (ZoneMTA) with ESMTPSA id 1a1f6def3f1000d084.003
 for <amd-gfx@lists.freedesktop.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Fri, 20 Nov 2026 02:52:49 +0000
X-Zone-Loop: 8e16c03d0985bbf15fc989fa19da764e20219be4f797
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=tylorstech.com; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:Subject:References:Cc:To:MIME-Version:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID; bh=msYeIQlcLBBah1ScNLjcrzC4Z7h2py1hSnX94ae5ztU=; b=1fih5E
 CVYF0iI3fiNq76L3wCq5alYWwCu9aEv7YdZr2Gbwn1WDQXDXZm5S5ieHT27fSt8c7QplB/Et39Vfr
 Pbv+j3n8EEHDinI5kme6ZB2TEFtKzdr4bCI9OIXRpTVvldQ0qKS1mUrKrW38xO59pE0bjS6yoaz0M
 KSDHmBHSK0MbUJMFGiunmYYGs35mUvRilNjleH0je3GNbNiut2/Tjlgfq4JIf1tlRSAkSavxCvqQy
 aEgEa0S+fkUMBkG8BtIggUt5evk1FzIcj0EX5Iltj/r1BHhfxl8nvtafzbgJqt7zLZuaoZ955APou
 pJOIwaLDEBEWsCpkMxVqCrvn/l8g==;
Message-ID: <088fad53-fb61-4513-80da-d0067da5c217@tylorstech.com>
Date: Thu, 19 Nov 2026 20:52:39 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: regressions@leemhuis.info
Cc: alexander-zorn@gmx.net, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev
References: <3b5586d0-b973-4984-9fbc-43c9ab960d76@leemhuis.info>
Subject: Re: [REGRESSION] Black screen after splash with Linux 7.0 on MSI
 Creator A16 AI+ (AMD Strix Point + NVIDIA)
Content-Language: en-US
From: Tylor Pater <tylor@tylorstech.com>
In-Reply-To: <3b5586d0-b973-4984-9fbc-43c9ab960d76@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: tylor@tylorstech.com
X-Mailman-Approved-At: Fri, 20 Nov 2026 14:56:16 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

I'm seeing what looks like the same issue on an ASUS ProArt P16 (Strix 
Point 890M + RTX 5060, Samsung ATNA60HR07-0 OLED eDP panel). Panel 
frozen on the boot splash on every boot with 7.3.4/7.3.5; 6.18.60 works. 
System is otherwise up (SSH, compositor running)...

On the failing kernel eDP-1 replay_state is 48 and psr_state is 0; on 
6.18 replay_state is 0 and psr_state is 6. Booting 7.3.5 with 
amdgpu.dcdebugmask=0x400 (disable Panel Replay only) fixes it and the 
driver falls back to PSR. DMCUB firmware is 0x09005700 on both.

Might be worth trying amdgpu.dcdebugmask=0x400 on the MSI to see if it's 
the same Replay issue?

Full details, logs and dtn_log dumps: 
https://gitlab.freedesktop.org/drm/amd/-/work_items/6174

And I saw this issue across multiple distros as well.

Thanks,
Tylor Pater

