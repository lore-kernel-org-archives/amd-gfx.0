Return-Path: <SRS0=3ay0=CF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D391DC433E3
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 06:35:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FBF8207BC
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 06:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lGs/s9vf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FBF8207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 035086E22C;
	Thu, 27 Aug 2020 06:35:37 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690056.outbound.protection.outlook.com [40.107.69.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 564256E22C
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2020 06:35:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ob/zAfE7OM9CN+NOSDtH3NKNIBcr5ZlH150VfiZaMeO7KD1GR48OG4aF7lnMwJbL7a4gRY97/fiFSfn+JGsLp160Ramjjp6e3OXQDLU1P5eR7s51S/i0uI85YOIXmCTJwFkHgqICzzoJhNe/rZWGsfHf2cyP/k2dWfDMd1mWHIOSCsAidBnfFLkJPjgj2RfbTthXohEOb5VX/F/9lT5FsTTPoQDaQT7kW1pGjG/s3okmZtuFUEMyHT8j5aTjc2B/jKq5FZb2NCVlgW4g4ES3t8CSZO8Ou007/l5h+lDJG1iENufy1cy2EwdhdCgDg1xndvK8HwMxq47owVScIPz/0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phIFYRPCohbxh0SYvbT8euih6W+gqE9mTWZhempNIvs=;
 b=i8UL98W4vwF5iwJvMxVrEo/QtFGBPbXCd+UGZQoLLsmis6aqhs/5LaIpah5D0GXUWKLhf93K22AvAl2ZzxYcFN2e3NwJPVh5JITxAteEAAb5ZhSNHtLAaZrw6Diz8aDzXJW0NRY6vCzrYj/06SXOp4x0n0bXnfPh2NREl4wun4odq0oRdaS+nFiLbCmvyMsFy42gflEq4pAx6oleFhDZ+OCMmLJbQRn1LS3MTuVdceaiWoiyGVbhs8PPMtPFZkqS+6U6K9YRpAxP3NjVtF8eFhGp4wthHrubLMQI1dQytJIrIrrjtOt+GM8R9TtaLk99p6KLSoms5Bdk4/AJdbaKnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phIFYRPCohbxh0SYvbT8euih6W+gqE9mTWZhempNIvs=;
 b=lGs/s9vfz5wYNaKKdue+3Jq/1jndPXLQ807frH9BGGDT2vkhhrWTA4Z4hgCAy6BLYP9PD7Tg0yqF24bWI+/9uCHI1dt7pNIVkj3XoBmYwbU2NiotF6a9gdNt/kBJ8NhqWyBkY6CkbHSaRqiXsuVJaBbh3u6+LTsbQ2a/8OkkirU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4579.namprd12.prod.outlook.com (2603:10b6:5:2ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Thu, 27 Aug
 2020 06:35:33 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 06:35:33 +0000
Subject: Re: [PATCH 1/4] drm/amd/pm: drop unnecessary feature->mutex lock
 protections(V2)
To: amd-gfx@lists.freedesktop.org
References: <20200825074923.32345-1-evan.quan@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <efc66f15-2291-dcdf-79eb-ce2085614360@amd.com>
Date: Thu, 27 Aug 2020 08:39:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200825074923.32345-1-evan.quan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0025.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::35) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 AM0PR10CA0025.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Thu, 27 Aug 2020 06:35:32 +0000
X-Originating-IP: [217.86.119.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6beca636-ad6a-4933-f171-08d84a536655
X-MS-TrafficTypeDiagnostic: DM6PR12MB4579:
X-Microsoft-Antispam-PRVS: <DM6PR12MB457911D965652D952D7976068B550@DM6PR12MB4579.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:233;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j+2h9Q7w2V6Q2B/M2CnIl/6UK0TlDmBg0LU5kabslubv1Mqp1wKCJjSWTm/LTNjQZ7FnwE8cWOF9vYnLDz4tb/Zt3PblR/pIhsTxK8P2X0lXZfSGhCpSHrB/VrblU3FRsTq+okBLPUIFqv8xzQQoDzeT7QnCgP+kl2jO1c1xRDlFdBE1GL251T9gZy7rbRHBFS5wyQkN3NG68mAynLdm9nLXVfuHkFWsqtbyKm9haoQMOft5QF845/Ta7kyr+nrYWHILWIBD+7Aiavgpx5+caUd9mmnclF5T7pP3IwdDRlb2RVX/Ll8TzI7BkTwl6bZQ1gew50JCq9cINtjY38A9Va/q2TpW6amDOAciyAyRWrauXuuVpGW9SyBHzYxT8zeH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(956004)(16576012)(66476007)(66946007)(66556008)(2616005)(53546011)(6916009)(8936002)(5660300002)(83380400001)(186003)(26005)(31696002)(52116002)(36756003)(316002)(31686004)(2906002)(8676002)(6486002)(478600001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: DO5MMazFxoYbC32dn7DHwrjBvYvsXJOBloFlqQmO1tMEyOyo3oKFyrvZKoZyi7CnWIKNXq6uxW94JGbT4BfTQUg0AvWfpgemKnsGQjWwdsuM8KhZPYR8S4xl+sf2EiMlwKRmrLtW+Gme5PrDAIrJ6VsdieVp7w+7aoFOV4cs2mKHCokjlB7MzS4+iknZMLDkbdX6akRiNObKT7Twvh/YocaTzKHhPF+lIAZV0JLDqJ29p/23RuLy9jtRKFOjzc8s6mdm7xfFhx+MV2nRGa/PrFxl/umBHoJCYuruy4QjodGbQallY1kPztO7VmJddE/BJr9K5st2AyUp2mxC9HQXIAG67UQe2JFW6ecT2yOFGmjDxueCZajbeXv/+BKn0g2nhjT3llfKjPInSkDh9t8RArMf3f5U/H3Z0VL1xHeHQwcAZawUAw+5PEDZ+dixre0mqOPZpLSO+2CUgSnAw8ryW5FY73pgoKjca4jVdDPP/lQI014ky5mvPaBSy3+lak8ahenao+ClxvM2oZ7hxFrIPkvaJ/KIfTw71uosk9lZI8549D2AZ3TjKEVFcRzqVuOIibh7zo5gp0LilNRlvqcIBxx6DEeKjYVmSwrzYr0rGyvPplEcTdudobBF0+lDha1dZqAFeSEM9YsSnFI5FnO9Ig==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6beca636-ad6a-4933-f171-08d84a536655
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 06:35:33.4353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7oRghLw1DVpQI144U/ui9moH/e+fkCoZl4R89aacu1DL5O6/6zTpEtvWQJw4EMle5mUBcEYeMSmZNOsl3Gw2Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4579
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

Series is Acked-by: Nirmoy Das <nirmoy.das@amd.com>


On 8/25/20 9:49 AM, Evan Quan wrote:
> As these operations are performed in hardware setup and there
> is actually no race conditions during this period considering:
> 1. the hardware setup is serial and cannnot be in parallel
> 2. all other operations can be performed only after hardware
>     setup complete.
>
> V2: rich the commit log description
>
> Change-Id: I096d7ab0855ff59b0ecb56fd9d6d9946b3605fc8
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 4 ----
>   drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 2 --
>   2 files changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 09dc5303762b..b7cad8ef6153 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -361,20 +361,16 @@ static int smu_get_driver_allowed_feature_mask(struct smu_context *smu)
>   	int ret = 0;
>   	uint32_t allowed_feature_mask[SMU_FEATURE_MAX/32];
>   
> -	mutex_lock(&feature->mutex);
>   	bitmap_zero(feature->allowed, SMU_FEATURE_MAX);
> -	mutex_unlock(&feature->mutex);
>   
>   	ret = smu_get_allowed_feature_mask(smu, allowed_feature_mask,
>   					     SMU_FEATURE_MAX/32);
>   	if (ret)
>   		return ret;
>   
> -	mutex_lock(&feature->mutex);
>   	bitmap_or(feature->allowed, feature->allowed,
>   		      (unsigned long *)allowed_feature_mask,
>   		      feature->feature_num);
> -	mutex_unlock(&feature->mutex);
>   
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 548db1edd352..28a19ffd22a1 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -721,7 +721,6 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
>   	int ret = 0;
>   	uint32_t feature_mask[2];
>   
> -	mutex_lock(&feature->mutex);
>   	if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) || feature->feature_num < 64)
>   		goto failed;
>   
> @@ -738,7 +737,6 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
>   		goto failed;
>   
>   failed:
> -	mutex_unlock(&feature->mutex);
>   	return ret;
>   }
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
