Return-Path: <SRS0=oKuu=25=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F67AC33CA1
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 12:52:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33C5B206F0
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 12:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kkXhkWIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C5B206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFA0D6E20C;
	Wed,  8 Jan 2020 12:52:24 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770049.outbound.protection.outlook.com [40.107.77.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F28DA6E20C
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2020 12:52:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isi5M08djo4ZuDoYMJILvTZ+3nCRvMWYwAWw8oJpFB++Rx3QVNCvWI//Zr29BqjmmJ2BdzMpZ4rqBOXMUvP3polM4z0puzMrAGDn2JTimw+ns4IkHyzWl4GnEESWbacgG7VjY6OE8OJoa4Dkjf/qFwZEtnuhbf+6Aq9JO8oEUP+lPQIx8K+D8SHFxOn8m6KWd1x6vE07YzQcsaH5IRt0DdRbrBBexvI6YLsaSkpckIVUYa6UHHiyCH0mjjcZN5xJ5OQoUtFQD4mgFg2f1/2yHXCzovxJO0Jqis/zi0GxVmSQS3Wf4a8oPaYAKBn9czQwDQcTAXmGkF9RZdAMyDugKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLvyMEITySy66pjUodZ9Xo0tRe4D1izSoKiA86ijujg=;
 b=TqX7d0szZi+fWuVsPNK2eIcY2O8ho7q8Wzit4iqFYzv1SD+3q1mDtRhWX2Mp8my8b9gSnkW/55BchqyhT900E9Cmsgr/4acCSCiNJs0wtQYV73j5rmfSQK37QjNauhuWrr9qtR96qxb4GSDe4lYSxbIMw1aTvz3GPj/MDYln4Xv29kxnhYNgeR+TwQVqff+u9/VQAI1Y4MIAQz7SD/y+pARKVkWdu7kpVePmqw0s/7RYLfKu6mSM5aeu4uYT2mD5oDcE8ZOxT9r5evJYx20Lrca+Lk9jqMJAIyQYcsxlphhE01VJlVt5MISiZOpeaxHYSD7EXewMZ5YhrEs1qJdt7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLvyMEITySy66pjUodZ9Xo0tRe4D1izSoKiA86ijujg=;
 b=kkXhkWIBZJ0A9cTsvbKk7YQsi5VzToG61Yf654Ntf1ELX7vUAqtiJeJH5aTJZw4HeZZ9IpLG3Bh3gPXOIiUyknGJCl/4U/zqwf00zeSn4zRp/sJOQFIOmDcSLFl5i6wIS8py4r6BFksGYRBmfMlALcNxMxd7EESzZ8+y0JCuaKA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1305.namprd12.prod.outlook.com (10.168.237.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Wed, 8 Jan 2020 12:52:21 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89%2]) with mapi id 15.20.2602.017; Wed, 8 Jan 2020
 12:52:21 +0000
Subject: Re: [PATCH] drm/amdgpu: fix modprobe failure of the 2nd GPU when
 GDDR6 training enabled
To: Tianci Yin <tianci.yin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200108123648.7422-1-tianci.yin@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <ba1754a0-7230-5df7-cfb3-7b0d7c892c47@amd.com>
Date: Wed, 8 Jan 2020 13:52:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200108123648.7422-1-tianci.yin@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0022.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::35) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR06CA0022.eurprd06.prod.outlook.com (2603:10a6:208:ab::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12 via Frontend Transport; Wed, 8 Jan 2020 12:52:18 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0e9471fe-5cdf-4d62-2b46-08d794399985
X-MS-TrafficTypeDiagnostic: DM5PR12MB1305:|DM5PR12MB1305:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13051B0D2343125767AB30CA833E0@DM5PR12MB1305.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02760F0D1C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(189003)(199004)(2616005)(66946007)(66556008)(66476007)(31696002)(52116002)(478600001)(186003)(4326008)(16526019)(86362001)(5660300002)(6666004)(54906003)(81156014)(316002)(81166006)(8676002)(6486002)(31686004)(8936002)(36756003)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1305;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B0TJpfnUdYxNpJCFMVoqHY+M8RJV73Czq8qECyHCvV5a+do4tnGaMJ5kaE3loNKPImR5yth5ifPipIHVwaws0HZnF6xQ9ooE3AN9dZLfDm/Zqo9GwpM9wd24pnWYcz6MJ6+9pjYYSzMs8OcZhkHS8hPeZEodpeAqXF5Ak8KfWYw/FMMuKOHzB65HpdluiqGUDJocCSWPlrqt2LejgxtFE9on8QalBfcoG5XfoIYuoIM1MH48WTBdAlv6Krb4Y33gj/W+D0tA89yXSrgxV2t/8Uh+WV1FN8kICVJJkNExJG3L8+asH+W68EVJIEGfcOSIQJ9FI+/wUN+QjHnBhVsx1AKbvEgt3JvtXv7rY2miQtsPBenl6X+Lmiv+wQ12IkniWTkeAwcAhBdSLFXh/IQuRcOfmURJ6CI5iiubsZKb4thb8OYTLy8sJul71DyQPyhp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9471fe-5cdf-4d62-2b46-08d794399985
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2020 12:52:20.9780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWudUfdn61E2W2O6wTrIlfSL26tVHvnMPk5q6CzPdTZehaIplITifp+bXPLNrgnT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1305
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
Cc: Long Gang <Gang.Long@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.01.20 um 13:36 schrieb Tianci Yin:
> From: "Tianci.Yin" <tianci.yin@amd.com>
>
> [why]
> In dual GPUs scenario, stolen_size is assigned to zero on the 2nd GPU,
> then the bottom region of VRAM was allocated as GTT, unfortunately
> a small region of bottom VRAM was encroached by UMC firmware during
> GDDR6 BIST training, this cause pagefault.

What I'm missing here is why is the stolen size zero on the 2nd GPU?

Maybe we need to read the stolen size after posting the GPU instead?

Regards,
Christian.

>
> [how]
> Forcing stolen_size to 3MB, then the bottom region of VRAM was
> allocated as stolen memory, GTT corruption avoid.
> The stolen memory of the 2nd GPU will be free in late_init phase,
> no memory wasted.
>
> Change-Id: Icd0ad7de41333282949bb1e3e676c6c307ddd081
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  6 ++++++
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 21 +++++++++++++++++++++
>   2 files changed, 27 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index c91dd602d5f1..440b793316df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -60,6 +60,11 @@
>    */
>   #define AMDGPU_GMC_FAULT_TIMEOUT	5000ULL
>   
> +/*
> + * Default stolen memory size, 1024 * 768 * 4
> + */
> +#define AMDGPU_STOLEN_VGA_DEFAULT_SIZE	0x300000
> +
>   struct firmware;
>   
>   /*
> @@ -192,6 +197,7 @@ struct amdgpu_gmc {
>   	uint32_t                srbm_soft_reset;
>   	bool			prt_warning;
>   	uint64_t		stolen_size;
> +	bool			stolen_temp_reserved;
>   	/* apertures */
>   	u64			shared_aperture_start;
>   	u64			shared_aperture_end;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 7dc8c068c62a..0c96b67d6ca7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -566,6 +566,11 @@ static int gmc_v10_0_late_init(void *handle)
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	int r;
>   
> +	if (adev->gmc.stolen_temp_reserved) {
> +		amdgpu_bo_late_init(adev);
> +		adev->gmc.stolen_temp_reserved = false;
> +	}
> +
>   	r = amdgpu_gmc_allocate_vm_inv_eng(adev);
>   	if (r)
>   		return r;
> @@ -756,6 +761,22 @@ static int gmc_v10_0_sw_init(void *handle)
>   		return r;
>   
>   	adev->gmc.stolen_size = gmc_v10_0_get_vbios_fb_size(adev);
> +	/*
> +	 * In dual GPUs scenario, stolen_size is assigned to zero on the 2nd GPU,
> +	 * then the bottom region of VRAM was allocated as GTT, unfortunately
> +	 * a small region of bottom VRAM was encroached by UMC firmware during
> +	 * GDDR6 BIST training, this cause pagefault.
> +	 * The page fault can be fixed by forcing stolen_size to 3MB, then the bottom
> +	 * region of VRAM was allocated as stolen memory, GTT corruption avoid.
> +	 * The stolen memory of the 2nd GPU will be free in late_init phase,
> +	 * no memory wasted.
> +	 */
> +	if (adev->fw_vram_usage.mem_train_support &&
> +		adev->gmc.stolen_size == 0) {
> +		adev->gmc.stolen_size = AMDGPU_STOLEN_VGA_DEFAULT_SIZE;
> +		adev->gmc.stolen_temp_reserved = true;
> +	} else
> +		adev->gmc.stolen_temp_reserved = false;
>   
>   	/* Memory manager */
>   	r = amdgpu_bo_init(adev);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
