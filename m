Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BE5C34026
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 14:35:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88D29208C4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 14:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="S43VuHkt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D29208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C3096EA19;
	Tue, 18 Feb 2020 14:35:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4255F6EA19
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 14:35:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCmaf5qLuNwsQCNDGP64Y+MI95Ew6GgLdBSmh3hFf3CEw+UartT3iY8SgoLQ61bkobVcbGxwOxQIG3VvWV/vkyJXKTG/b1K+ytX63sQztIF3bgPLvmHkYzrep/vfoiGpahhWCM0HwoAwsnzg689eLr9UyvySZiGRhHsSrmqAjg60qyt+T6GlWn9pT778F6CSkpAbIHW0Qvqbjq8qVt9A9ueHMe3IzDVMZtgi3ohWTyMf78ccELNuBouf7EoaucgZ9ZI+uDH1SP1YHvRKXrw4RTuqIK++SgX4nXY65WY3H5zmvQi8ln2U6PzRmfPzgM8doY3mQKnIEWjhK9gOyy0loQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlDw0wEzK/OnECw5ILYuQzJZvgI6JsUjC4NyuQXW15I=;
 b=meSvPgDr+BmWwhQ1UMrqFQOHJM0oGjrMyYNIGfWJYTD2t6PGJOPcteYtudSf3kYyIrCZfCbDEITxSrQHExTSORF6kO083DJynBeVhhhUPNFlclUloVJU3eJtrNk7xDCEuE3YAefd6I+wS9/rMIwjRmEeW+YWs8KiGfm0QkQ5Tlym8FtXfhQglmm/OoE/V2Aqy0JN8U12ylugvpB1Tv6iLrNJocOnCSr9AMaXsfhkREGlfBXB5loL8z32anruePWkb4yGw/Eur6UvEvRPYilVWlFhw4UjAu0q8xzjo1h/mTITaIoeaYLCrXOGpH2co4DOdjt9ica3g+eOuncyDEPlNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlDw0wEzK/OnECw5ILYuQzJZvgI6JsUjC4NyuQXW15I=;
 b=S43VuHktSG6/Uk5VKJda/jgtKv6Y6Wm0UInq4wliVYo49opleRTL8J7YS5MhOG5lK5uDfUGpPBGBhuHDSOfsrZ0Rmi0WBDUcc+h6XJ7JM69FJ+dDs4c/hq/2WX6jM2xND7s9vjQw7138CXgsLm0kkxVHUvAfaQpO0S//9eIZl8Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB1417.namprd12.prod.outlook.com (10.168.236.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Tue, 18 Feb 2020 14:35:05 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2750.016; Tue, 18 Feb 2020
 14:35:05 +0000
Subject: Re: [PATCH] drm/amdgpu/smu: add a send message lock
To: amd-gfx@lists.freedesktop.org
References: <20200218143156.1640434-1-alexander.deucher@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <5d301d58-49c7-6c3c-0652-6e051514d1ff@amd.com>
Date: Tue, 18 Feb 2020 15:37:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200218143156.1640434-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0103.eurprd02.prod.outlook.com
 (2603:10a6:208:154::44) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2c:e900:7512:2832:6401:b174]
 (2003:c5:8f2c:e900:7512:2832:6401:b174) by
 AM0PR02CA0103.eurprd02.prod.outlook.com (2603:10a6:208:154::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24 via Frontend
 Transport; Tue, 18 Feb 2020 14:35:04 +0000
X-Originating-IP: [2003:c5:8f2c:e900:7512:2832:6401:b174]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d6a8b6be-43a6-4cff-12f3-08d7b47fbe87
X-MS-TrafficTypeDiagnostic: DM5PR12MB1417:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1417B2B5B3A2EF708C5000FE8B110@DM5PR12MB1417.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(189003)(199004)(81166006)(81156014)(2906002)(6916009)(8676002)(478600001)(31696002)(6666004)(31686004)(36756003)(53546011)(6486002)(15650500001)(2616005)(8936002)(66476007)(16526019)(5660300002)(66946007)(52116002)(186003)(66556008)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1417;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KD6aBIsHSUDU3i+4FW0iX+2qYmI8sD+uh0UkW60nZdRU2sue0o6Nn0qX4m6duXNdJBZIbu2NBiTmE+IXZM1Jya3B/ZSkbLYOXqSiQdHX3voOwqTcRhM9E0JPlwmq/yP58k8jb1KZL8llVi1JwqMrETL3HmpZ1u2KKFYZfI4lv/NgL1d/d1Ioldbqp27/SQBRBdScwXf6+rcAXH8j3Y5N5tv2yIPO7ErVtlrBblEZ9I2qGSiDAhAw7h/YXusDAznY2kN+9wiVMRf3VeAlQc6dYI60PeHyZ3ymsS3rw8azH8c9K5MFnfyCWKrOkpbLvPjldUmsnWh48ADVCEfEbwI1EnZL6SQ+hAc5K6/vQMGuMU9WX+wm8p+sdO9qHkSdgkAr7eRkwOSaetMTwkgVMF+/zvxm1V5AF7rh3wcrgdEHEdBvd/CJHKYobFC60IhL/ZDC
X-MS-Exchange-AntiSpam-MessageData: YgqeSsAEZNo0rut7QctQq/tK5SS5ZTZI5j0HriN68HVxzwkvrR1G2xo0CZwyHV39m0st5T38hvLUGGTem7nGQLBKFQENYvAMazc4I1WT91VlYYVKTsGK58w0X68uGp3ZT3FeIOf6U+429mgc92V7LGISZ6QyWd5lG0dI6ok4E+Twxuh/kMDidatL8MFTV98RAgI7XDOve4CUrhLkgTPbtA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a8b6be-43a6-4cff-12f3-08d7b47fbe87
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 14:35:04.8902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHYw5FOobNwLp4cJDEFMmryctJ6VFI14TS+KOC48uhY2AGtZg3Q73Q7fwHkHOyJk1XlvRmx8inDhztX7UYKiLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1417
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


On 2/18/20 3:31 PM, Alex Deucher wrote:
> The driver uses a scratch register to communicate with the SMU.
> Add a lock to make sure we don't try and do this concurrently
> by accident.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     | 1 +
>   drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h | 1 +
>   drivers/gpu/drm/amd/powerplay/smu_v11_0.c      | 7 ++++++-
>   drivers/gpu/drm/amd/powerplay/smu_v12_0.c      | 7 ++++++-
>   4 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 437a3e7b36b4..694017740186 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -905,6 +905,7 @@ static int smu_sw_init(void *handle)
>   	mutex_init(&smu->sensor_lock);
>   	mutex_init(&smu->metrics_lock);
>   	mutex_init(&smu->update_table_lock);
> +	mutex_init(&smu->send_msg_lock);
>   
>   	smu->watermarks_bitmap = 0;
>   	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index 506288072e8e..25fa5c5ed09b 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -363,6 +363,7 @@ struct smu_context
>   	struct mutex			sensor_lock;
>   	struct mutex			metrics_lock;
>   	struct mutex			update_table_lock;
> +	struct mutex			send_msg_lock;
>   	uint64_t pool_size;
>   
>   	struct smu_table_context	smu_table;
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index b06c057a9002..ed5b3afcab66 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -97,12 +97,16 @@ smu_v11_0_send_msg_with_param(struct smu_context *smu,
>   	struct amdgpu_device *adev = smu->adev;
>   	int ret = 0, index = 0;
>   
> +	mutex_lock(&smu->send_msg_lock);
>   	index = smu_msg_get_index(smu, msg);
> -	if (index < 0)
> +	if (index < 0) {
> +		mutex_unlock(&smu->send_msg_lock);
>   		return index;
> +	}
>   
>   	ret = smu_v11_0_wait_for_response(smu);
>   	if (ret) {
> +		mutex_unlock(&smu->send_msg_lock);
>   		pr_err("Msg issuing pre-check failed and "
>   		       "SMU may be not in the right state!\n");
>   		return ret;
> @@ -118,6 +122,7 @@ smu_v11_0_send_msg_with_param(struct smu_context *smu,
>   	if (ret)
>   		pr_err("failed send message: %10s (%d) \tparam: 0x%08x response %#x\n",
>   		       smu_get_message_name(smu, msg), index, param, ret);
> +	mutex_unlock(&smu->send_msg_lock);
>   
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> index 870e6db2907e..1ca8a8c959b1 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
> @@ -83,12 +83,16 @@ smu_v12_0_send_msg_with_param(struct smu_context *smu,
>   	struct amdgpu_device *adev = smu->adev;
>   	int ret = 0, index = 0;
>   
> +	mutex_lock(&smu->send_msg_lock);
>   	index = smu_msg_get_index(smu, msg);
> -	if (index < 0)
> +	if (index < 0) {
> +		mutex_unlock(&smu->send_msg_lock);
>   		return index;
> +	}
>   
>   	ret = smu_v12_0_wait_for_response(smu);
>   	if (ret) {
> +		mutex_unlock(&smu->send_msg_lock);
>   		pr_err("Msg issuing pre-check failed and "
>   		       "SMU may be not in the right state!\n");
>   		return ret;
> @@ -104,6 +108,7 @@ smu_v12_0_send_msg_with_param(struct smu_context *smu,
>   	if (ret)
>   		pr_err("Failed to send message 0x%x, response 0x%x param 0x%x\n",
>   		       index, ret, param);
> +	mutex_unlock(&smu->send_msg_lock);
>   
>   	return ret;
>   }
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
