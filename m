Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBA9C38A2D
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Oct 2022 09:31:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5781610E2FA;
	Tue, 25 Oct 2022 09:31:01 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F014A10E2F5
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 09:30:56 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id q9so11115129ejd.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 02:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7MMc0plmxUX3qlQ8UsvGqe5KxwjObkNgnyXGsg1NJ88=;
 b=DhV7BGASma19V3rcWFsGhUhpY7TBIAui4VC4dQQvaxCWfqeIrr8jEzcd5PzJcqGtkk
 RQ/EkCvdQgzC6lC1/i8Uibqn2k+s2E7ph96rOopEaubjtGBzY9T4puoQQZXCsgWSEVLs
 0Jv4CECzd1mXXxutmuWtzQZPYiMxKfZ52DJG0m+9AJMgImzfyAVtAHYMMf1vwI9YU1EN
 k+kPhB3uCAxWCOBKhhBx7m7ou6+/TiUPADagF2fVqfAZKHnAbBf/t8cLxfByZkU7oYNW
 TqA0op8o36kZuOO97geSG9L3jsgiGKEernwEJphyAKp6PB45rw3H0LQzIQRwdw9w2aW8
 MVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7MMc0plmxUX3qlQ8UsvGqe5KxwjObkNgnyXGsg1NJ88=;
 b=tBOWamhVCMoaLw8+XRYoM1Fl8FLFy894N0Me99bxmMsunym5hAT+FLvQi54kKkEwey
 3Gtnp2IOOGVORjdNVl1H3AscYAYlogIW5TBhZlr9mKNNMMlaB/pvzb7RYo86C7QJWtPv
 ftmqdQAJfGWIYCO1af1q5vnfVX7uL+S/ODUquyQPr3gUN8nxdc5A4OJJmXwURbiiREM9
 +TkL4oJkDKcezrMPGIKEsL8Us5LJEAVb0fKNROrKQftyLaIYnGXqTfPz66hnK0C3otN7
 sc+8jSfZ7bTHU6vTus4ZPl0cMJL3vKAY9Ed+6w3Pu10GDAkgBNOO8YA+/uCN6kdbdlsB
 2XNA==
X-Gm-Message-State: ACrzQf2F1BfMRf0zRIXY8BVYnWLbYRk0/QUfsCqsP/g/n7rHkgpmk1s/
 NBVQCQslcyTnuqgwYM7ERAa8ne6gXNo=
X-Google-Smtp-Source: AMsMyM5hFq/jOgJD19wblkY/pK8cyP1WKHw6TDCvncgPaIYeLnyeR0SEAkbYOYoNOegVBHHe5h/jxA==
X-Received: by 2002:a17:907:3f27:b0:78d:ad42:f733 with SMTP id
 hq39-20020a1709073f2700b0078dad42f733mr32376735ejc.320.1666690255420; 
 Tue, 25 Oct 2022 02:30:55 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea229.dip0.t-ipconnect.de. [91.14.162.41])
 by smtp.gmail.com with ESMTPSA id
 r21-20020a170906365500b0078d9c2c8250sm1085781ejb.84.2022.10.25.02.30.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Oct 2022 02:30:54 -0700 (PDT)
Message-ID: <23e34f67-8de2-aee6-72ff-2a1caabc4be3@gmail.com>
Date: Tue, 25 Oct 2022 11:30:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Disable GPU reset on SRIOV before remove pci.
Content-Language: en-US
To: Gavin Wan <Gavin.Wan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221024202124.8592-1-Gavin.Wan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20221024202124.8592-1-Gavin.Wan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 24.10.22 um 22:21 schrieb Gavin Wan:
>    The change of the commit f5c7e7797060 ("Adjust removal control
>    flow for smu v13_0_2") brought a bug on SRIOV envrionment. It
>    caused unloading amdgpu failed on Guest VM. The reason is that
>    the VF FLR was requested while unloading amdgpu driver, but the
>    VF FLR of SRIOV sequence is wrong while removing PCI device.
>
>    Fixes: f5c7e7797060 ("drm/amdgpu: Adjust removal control flow
>           for smu v13_0_2")

The Fixes line should look like a Signed-off-by or Acked-by line.

>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>
> Change-Id: I1ff8dcbffd85d7f3d8267d660fd8292423d2f70f

The lines with : are noted in chronological order.

E.g. in this case that should be:

Signed-off-by: ....
Fixes: ...
Acked-by: ...
...



> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 16f6a313335e..ab0c856c13b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2187,7 +2187,8 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>   		pm_runtime_forbid(dev->dev);
>   	}
>   
> -	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 2)) {
> +	if ((adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 2)) &&

Please drop the extra () as long as you don't want to explicitly have an 
assignment inside an "if", "for" or "while".

Regards,
Christian.

> +			!amdgpu_sriov_vf(adev)) {
>   		bool need_to_reset_gpu = false;
>   
>   		if (adev->gmc.xgmi.num_physical_nodes > 1) {

