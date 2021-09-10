Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532D1C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 07:20:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1304A60EE7
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 07:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1304A60EE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91AC76E105;
	Mon, 13 Sep 2021 07:20:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 03D3A6EA5E;
 Fri, 10 Sep 2021 18:24:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C95BC6D;
 Fri, 10 Sep 2021 11:24:47 -0700 (PDT)
Received: from [10.57.15.112] (unknown [10.57.15.112])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2AD13F5A1;
 Fri, 10 Sep 2021 11:24:46 -0700 (PDT)
Subject: Re: [PATCH] drm/ttm: add a WARN_ON in ttm_set_driver_manager when
 array bounds (v2)
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, christian.koenig@amd.com,
 xinhui.pan@amd.com, alexander.deucher@amd.com
Cc: Leslie Shi <Yuliang.Shi@amd.com>
References: <20210910100922.12097-1-guchun.chen@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <868cab56-607b-bcc8-e358-b2475315f862@arm.com>
Date: Fri, 10 Sep 2021 19:24:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210910100922.12097-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 13 Sep 2021 07:20:07 +0000
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

On 2021-09-10 11:09, Guchun Chen wrote:
> Vendor will define their own memory types on top of TTM_PL_PRIV,
> but call ttm_set_driver_manager directly without checking mem_type
> value when setting up memory manager. So add such check to aware
> the case when array bounds.
> 
> v2: lower check level to WARN_ON
> 
> Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>   include/drm/ttm/ttm_device.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/drm/ttm/ttm_device.h b/include/drm/ttm/ttm_device.h
> index 07d722950d5b..aa79953c807c 100644
> --- a/include/drm/ttm/ttm_device.h
> +++ b/include/drm/ttm/ttm_device.h
> @@ -291,6 +291,7 @@ ttm_manager_type(struct ttm_device *bdev, int mem_type)
>   static inline void ttm_set_driver_manager(struct ttm_device *bdev, int type,
>   					  struct ttm_resource_manager *manager)
>   {
> +	WARN_ON(type >= TTM_NUM_MEM_TYPES);

Nit: I know nothing about this code, but from the context alone it would 
seem sensible to do

	if (WARN_ON(type >= TTM_NUM_MEM_TYPES))
		return;

to avoid making the subsequent assignment when we *know* it's invalid 
and likely to corrupt memory.

Robin.

>   	bdev->man_drv[type] = manager;
>   }
>   
> 
