Return-Path: <SRS0=/R8T=KZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF77AC47092
	for <amd-gfx@archiver.kernel.org>; Sun, 30 May 2021 16:54:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA0A608FE
	for <amd-gfx@archiver.kernel.org>; Sun, 30 May 2021 16:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA0A608FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FB826E154;
	Sun, 30 May 2021 16:54:04 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EF8B6E154
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 May 2021 16:54:03 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id j10so10662397edw.8
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 May 2021 09:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=DqbsSn5/05loTcx0VmlqjgMxnSkec4ILpYTLV4Foqi4=;
 b=uDN9cktkZ8qCXdZraUYx3W8BDVR0YMxjBo0xI1szYahmpMOOr1OoVl14r5ygxYtLdH
 tOZPd3VV/yJf1kGX8PZk2fnGue2xZeT75SdgtQXVn1EEJkyKjbPBrZPXEjT3zmWBx4wY
 /YfqGpMT7TocQAtTrlqSr8mQLZBVTzYtKzuz0wEy2nuyvOEVLZp0ycQqxgDRt7ajIRWh
 fkGxYCVEgGV+8VPYtYNkMYIDBSEyYf7UkINn5nWRz+5mL+bhSPZFdyw++YQMKJlqzw/i
 d7hjIqwqvOo88jHZ4sMlBQx67SX88FQY46hoTddtFJwsdkc/g13GmEKmHMLP0A0or/7W
 f7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=DqbsSn5/05loTcx0VmlqjgMxnSkec4ILpYTLV4Foqi4=;
 b=DX6vkZKMHsjSps4ligCl+LrxYqPIWz+mloK49LtfnmIo/0mmp2eexhU9ZHEtAJ3c0Z
 r/e3LOl7N7bQINF4sZqmc2HpKp5X/cPfv6l3IwBEmnJmK9z4o8FWtizoXTN+wUsaPLWH
 yt6ojkq3PEuFsu50PgXhNwVPjKtDeYYVje88uzVBlgahlxMKD6+Yj81r401QxVZRR8Bi
 n5M+FeHWgUBd+wGFM6sWwtz6WqzZLVi+l+URxLfg4FNSY3NfWYKXi0TEttTSyxPi+qOo
 hgSu1q1WyoFxJ3E1Ar0R79xSv/rcH3BVrK2Q2czeKwd3DWac4m3JTOKCQxVl+TYSa0l3
 CQ/w==
X-Gm-Message-State: AOAM53236z2RxdwZa2eo2h/gTr0vDlm7LakqP1RTGP5hsrOsmCoH9bGa
 qSdXl0OJE7wZpwL8r1idRQOfC+vclso=
X-Google-Smtp-Source: ABdhPJyt18O0xuanBE25C6KInVxPw+/KMfF7HPrrWx/rya/sckDzprjDBwHfhHoK3Lnux5cWI1TTgw==
X-Received: by 2002:a05:6402:3c1:: with SMTP id
 t1mr5925290edw.270.1622393642086; 
 Sun, 30 May 2021 09:54:02 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:7459:84a8:a215:bca8?
 ([2a02:908:1252:fb60:7459:84a8:a215:bca8])
 by smtp.gmail.com with ESMTPSA id cd8sm5160668ejb.46.2021.05.30.09.54.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 May 2021 09:54:01 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/amdgpu: Fix a bug on flag table_freed
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210529225101.459466-1-jinhuieric.huang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <a048b42a-71c6-97c5-0e15-44cb3f3847a2@gmail.com>
Date: Sun, 30 May 2021 18:54:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210529225101.459466-1-jinhuieric.huang@amd.com>
Content-Language: en-US
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 30.05.21 um 00:51 schrieb Eric Huang:
> table_freed will be always true when mapping a memory with size
> bigger than 2MB. The problem is page table's entries are always
> existed, but existing mapping depends on page talbe's bo, so
> using a check of page table's bo existed will resolve the issue.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 0dee2e8797c7..95b94c95adac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1582,9 +1582,11 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
>   			 * completely covered by the range and so potentially still in use.
>   			 */
>   			while (cursor.pfn < frag_start) {
> +				/* Make sure previous mapping existed */
> +				if (cursor.entry->base.bo)
> +					params->table_freed = true;

In general this is the correct approach, but I would push that decision 
into the amdgpu_vm_free_pts() function.

>   				amdgpu_vm_free_pts(adev, params->vm, &cursor);

So that we have here something like

params->table_freed |= amdgpu_vm_free_pts(..);


Regards,
Christian.

>   				amdgpu_vm_pt_next(adev, &cursor);
> -				params->table_freed = true;
>   			}
>   
>   		} else if (frag >= shift) {

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
