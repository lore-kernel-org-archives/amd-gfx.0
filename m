Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F002C11F65
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 14:21:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 404046142B
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 14:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404046142B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jcornwall.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 079C889FA6;
	Wed, 30 Jun 2021 14:21:11 +0000 (UTC)
X-Greylist: delayed 309 seconds by postgrey-1.36 at gabe;
 Wed, 30 Jun 2021 14:21:10 UTC
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09CF889FA6
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 14:21:10 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 8198158055F;
 Wed, 30 Jun 2021 10:15:58 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute4.internal (MEProxy); Wed, 30 Jun 2021 10:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jcornwall.com;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm2; bh=AO+2CERg9AWZKunCXyXMPxXmFXk9
 JGM+3fV2AFrxi5o=; b=sXmogJBGu5cad2wSBFQkHJjoTj/m1vHcTm9lvyWS4noE
 Na0G0obQ6wvrVtQRq7dR7Xg3asljGLvdu81yjn5eAyWeWbGymELuTyaPDzgz6ohY
 wq9PDW5zhOnptU7Bz3q4zJYs8/RlykmBQP7bXm6zxmtfn7pyoT4dn1nihjztEoCa
 QEXrh0/jgEWZEYAO3HLNEiETKACv9n1XTeOvrfK9clQkAoquemNCWtoRDEZfXoNI
 LMvj/0ARGwSJjQDzgQVEoIAg41E1S9Aj+BmGotCjPRSEbI+Dv1dmeORDoo18KVz8
 I3ZxDbxk70mnskGNetuCebO7nGnrSC+w83x+UbNVXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=AO+2CE
 Rg9AWZKunCXyXMPxXmFXk9JGM+3fV2AFrxi5o=; b=NjKK8INEgapX742F5bdsxa
 v05vVl5elOWHHldrQtEAgxoVnd3w3TZxaYn9q3XiD6aFCgNFD/jWQT0WfAPTChOP
 0reVBvpRmoKWRpxUcFEARD7kPkqY6fWCgdBnH2W+w8id8UChtygnArpS+TfMbO2y
 aLqaIdMKbhXwVpy95ffNsxrvHjzTY681i4pjX2CekECTX7sddD04M16t74DcddHV
 BpgA2JQ7HhKzY2BEyZtrIdNglJ9S8KRpkYisrkMjcr/4QuNw4TiyZzHySlAYm17g
 Sx3nFtVtX12UPuPNEw1lAaBxwDNMkD/duNHBNbPj2QtcotTpfrk5qJZfDYr4ucPQ
 ==
X-ME-Sender: <xms:nnzcYOCCTkgpyj_gBZO8uuB2U_EfEzuVqlM574lCS1FjO8DXbv7FEg>
 <xme:nnzcYIgVeYHs52vFHr0HedkovAIclqDXJm7Y9j0BTCutranzEk7bD4ZAHAxJVVXjs
 Y2Oi_hVbbwyIpQcYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeivddgjeegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdflrgih
 ucevohhrnhifrghllhdfuceojhgrhiesjhgtohhrnhifrghllhdrtghomheqnecuggftrf
 grthhtvghrnhepieehjeejveeugeeuieegfeefkeeggffgvedugeejgfeivdeuheehgeeh
 jeehhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epjhgrhiesjhgtohhrnhifrghllhdrtghomh
X-ME-Proxy: <xmx:nnzcYBmzpqos5zqScbuzDKj4GzTMNoUhtOnwkrhd2O8sKgKTEC3TFw>
 <xmx:nnzcYMwj0nts9mO0l2Ttyf7m_L6_n9AoUgoTxb5gRu0qxU4Nca9FpA>
 <xmx:nnzcYDRK9qjuuLEqmR52ByfyMmeqCLH8X_z_7ZltvhYE6vlefNXBmA>
 <xmx:nnzcYILRE4N3n6KI3Uwjxegv2dRSTBZliNykthIgp8DiIB66MLFv4w>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 0BC6851C0060; Wed, 30 Jun 2021 10:15:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-530-gd0c265785f-fm-20210616.002-gd0c26578
Mime-Version: 1.0
Message-Id: <d2bc37bd-d30e-4321-b50e-eecc95acce1c@www.fastmail.com>
In-Reply-To: <20210630101012.2006307-1-YuBiao.Wang@amd.com>
References: <20210630101012.2006307-1-YuBiao.Wang@amd.com>
Date: Wed, 30 Jun 2021 09:15:37 -0500
From: "Jay Cornwall" <jay@jcornwall.com>
To: "YuBiao Wang" <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org
Subject: =?UTF-8?Q?Re:_[PATCH_1/1]_drm/amdgpu:_Read_clock_counter_via_MMIO_to_red?=
 =?UTF-8?Q?uce_delay_(v4)?=
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jun 30, 2021, at 05:10, YuBiao Wang wrote:
> [Why]
> GPU timing counters are read via KIQ under sriov, which will introduce
> a delay.
> 
> [How]
> It could be directly read by MMIO.
> 
> v2: Add additional check to prevent carryover issue.
> v3: Only check for carryover for once to prevent performance issue.
> v4: Add comments of the rough frequency where carryover happens.
> 
> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
> Acked-by: Horace Chen <horace.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c 
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index ff7e9f49040e..9355494002a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -7609,7 +7609,7 @@ static int gfx_v10_0_soft_reset(void *handle)
>  
>  static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
>  {
> -	uint64_t clock;
> +	uint64_t clock, clock_lo, clock_hi, hi_check;
>  
>  	amdgpu_gfx_off_ctrl(adev, false);

This clock can be read with gfxoff enabled.

>  	mutex_lock(&adev->gfx.gpu_clock_mutex);

Is the mutex relevant with this clock? It doesn't snapshot like RLC.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
