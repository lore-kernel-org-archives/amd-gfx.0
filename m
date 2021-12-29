Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B29BC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Dec 2021 10:36:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9A7110E707;
	Wed, 29 Dec 2021 10:36:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6E1910E707
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Dec 2021 10:36:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvRsMGmOPiBylctY7lebezMu740B14E75mSsiIP0a8mnl7oHVAi+q7Gi/4gFYChzY34dAfa6/JGLqheK3XGiZRxpO7l6WdwyGSmw3XjTBOeIpZpojGOz7FDPlLthHMTOIeC27bErTAJe5YMnp85GPz3PpwUH/n0Q2SGQy0WYzfR6HBQRIiZi+AqAJvo9cWQxjY/M8fAYGoDQyeUTXYWAhIxwThwIHdamJOYSO6S1t6Vsg4n6jVTdqeu5HuaKynHULwJz5pGNIFDiGGDReyRVFYx/34oeutELvyonLv91ki7N+8Bzgc32jyEl3hrSXMsxiED0avSx/Bx8FZVr5hUAIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FS6wpByA3mHyirjrGn3ygpfWoI08N9WKNAiTnTf4eWQ=;
 b=McogbhsfhQtpuOM+GdWPVRcMqEzGen0sDyckSlWTrUTGh9L8sVCD0eXF/ym8J5L7FqWcIOV7tykdF/k31d1yEPpGxyWDNsTe8J4nPikFMPcLqyHS41sSTqwNFTszhZ2CACrPwVKLj/IulviERIbUCf46EXe5/FZ4VW6r93AL+IBKgtn5tIf2gjghxG2KjwKno7v8PETfekxu6QWOsYH24qBGjIIXmktDdFdbAAVAWV2xLrhBqzepGImx29z5j79Byp1n4gBjCkAdfZV2wD1zMjrlVB5xRQmFgHr1EYx/lsOBjMzBTgiKxUH4+wKWPMCa+vQGJ0ciU86VYtxmmVZn5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FS6wpByA3mHyirjrGn3ygpfWoI08N9WKNAiTnTf4eWQ=;
 b=FHxsNSq00MxTOKVgulXjj6FiacPoa+44gnvrar3/59S7hoRgTdf4g3utqYler2jTbXRiSY9x4kpX6I6ReAPshTrhhA/Yw2nKuZr+LCrYyOZPGQ0ftJ+HPiovQHEzLLzJZYYBwwlKJHt4KU4buWQnJQrojXbf2QxxXFP/RxoJ1HY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5358.namprd12.prod.outlook.com (2603:10b6:5:39c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.22; Wed, 29 Dec
 2021 10:36:25 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::c45:f65d:78:99e7]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::c45:f65d:78:99e7%7]) with mapi id 15.20.4823.023; Wed, 29 Dec 2021
 10:36:25 +0000
Message-ID: <354487d7-3930-d9bd-5c92-6383a4865ce2@amd.com>
Date: Wed, 29 Dec 2021 11:36:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amdgpu: avoid NULL pointer dereference
Content-Language: en-US
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com, Tao.Zhou1@amd.com, John.Clements@amd.com,
 lijo.lazar@amd.com
References: <20211222141956.13239-1-guchun.chen@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
In-Reply-To: <20211222141956.13239-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR04CA0019.eurprd04.prod.outlook.com
 (2603:10a6:20b:92::32) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6bd0ced-72cd-4afc-fb6d-08d9cab71065
X-MS-TrafficTypeDiagnostic: DM4PR12MB5358:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB535844038640A62BFBACF84B8B449@DM4PR12MB5358.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P3j7lvk6Xe7E7XgLbCP2h4UVe0CdRnt9+VdgLWlte2K+PbeZVNHA/PxCclcHkWl/WikNwNp4AQunhRJdVMAfKgdsEVnXQhb8TYEMepZg9fsI70QFWlOqdo2G+DvwK4j0qX451IlXSXwwPyDWwYmUjERkV2ISKpg3ukZByhHHETgypthctYsAr06hxxjPimGNDbs9An86lY2Sv0R8ZD+yl6Fleq50TvT6MTo8UcjoCvEcp7a0BtILEsFKMr6PdCyDK7JYO6Lk7z9Aeq3FdFubBjGb/EMBRkPTy4v7r5hCTsYTCXHWRVVxhrWEzyQTF3K5QiRC1hCbPhTGRzT8FaCQDISbvTQYGuV4i3nkhhzsQeAyJgxAq/pGEyTOlJAzaIWWosowAmQurB/3EKM1FVmTe23PbypK3B3DUn0+D6/4/JVXN+QG6FvQArfrY1dGuMn19dSlScUZwRqXI4bml4JbcsLKgZLuhM5YtQunHl2/Fw80YsVc3jGoQmAWleAr0+OACqXfYgJ3spYqfx5LVD/hh62bQuljy4Q8FvGP/wMVRnrcBQLSVrJgMtSj6ae5r2w5Ct9fpDuVHiBgWOswzcVWys2bGmRreQQ/T2oYTsRk3o0MDeZwdbeRrliFvYxY9XUOHlsNB3wXH1qkc3b+vVMlm/T3r9HJOgrE4nHi4HFuZ3uC7A6XvdgXV7bgifYPSd2GGA78ybp/chhQR8ddwRK+N3rASldX7WSsoTJe4l4W4+Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(2906002)(6512007)(2616005)(66946007)(316002)(6666004)(5660300002)(508600001)(66556008)(66476007)(53546011)(26005)(6636002)(31696002)(36756003)(6506007)(186003)(31686004)(86362001)(8676002)(6486002)(8936002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WllKZjJ1eHZnRzFMaVZ1UzdmVGk3Tm9sc25JdGdDdmtFMnZnRWVtcmMwY0tz?=
 =?utf-8?B?RmEvS2o5TStVTSthSldXL3V4UW5EaVc2SjJMSE03MzJCWlhNUEVUNHJuYlFT?=
 =?utf-8?B?VmkvSUN6aDNPUDgxTHU5aVE3NjJKWkNaVEpnYURVYlJuRlR1UmJhbE4vVEJK?=
 =?utf-8?B?SkR1bnFhNDV2SkdVNDNLZ2FTd3R5Qy9UOFlnWFg4R1MrYng1TFNYdU5JNVpL?=
 =?utf-8?B?N3MwblF3RXpCL3RDaFY3b2tnSmtnbzZUL1hMOFpDaFkxSk42V3hIUU1ta0NR?=
 =?utf-8?B?TDlSSGV1aE9iMnh2RzN5MTVFWTkrTG1PTlNzMndPNzNPYnBqd3ZyMStvS21j?=
 =?utf-8?B?M0Q1QW5ONGdLYkFTOHFCWWlRY2J1VzFrcWRKVHZ0blYrMFd2Nk5xa0tsYVFV?=
 =?utf-8?B?VXBkamlOM3RyUHRJZm92Zy9jVXhWYnhiWjdRSGxxRTE4ekhIb2xMd0lITk1B?=
 =?utf-8?B?NlZYdGFWMTEyOGZtMDh4OUx3WnpsSXNlYkZZV2E0OGZDWUc2cTk5aUlHb2tX?=
 =?utf-8?B?d3dMcFRjRlpraGc1M1pqdTdIWXhSc3RKeHBiUStTdkpnaXNWbjgwY2FQU0J3?=
 =?utf-8?B?OW1mV0J0R2FBUTRMZEt6cGttY1ZPdExZZjNiUmY4UzJ4bHRVVE5XRnIyYUZ0?=
 =?utf-8?B?UFlkYkw4WmJiQ0RoRXNKQmxlSytFVERnOGhxQVhaWHZWak9yVDdaNDZqZnBu?=
 =?utf-8?B?ZnBFeUxxWmhodWk0R0x2cDJScUJlaEcxcDYrdUd3UFdVeWxSQmdEYkJKaE0w?=
 =?utf-8?B?RkVVTUQza0FxNlFiNWJuVG40K0pWU0prT09JTjZQd3R2VHpocEttdkNLNFA3?=
 =?utf-8?B?RkRZcEdDbnZMZktDM21xUnhYbjExTVRURlhjUTRDWnIySWFGcmtNbGRvbzli?=
 =?utf-8?B?RkowWkczc0FqQm9ieEZmanFlM3ZzMVh5cExvUnZSWWEwZmxCL2VjMkJVZVdv?=
 =?utf-8?B?TmFzRGtDRy9WV3VRZlAzS2pEUWd5R1hKc21RYktzSmhyUVkrZEc2a2hlSFp3?=
 =?utf-8?B?SUFOV2twQmszbjVDbkduRDlNUEVrakNEc2grbDVKNDNieDAvcG9Rd2xPTnJH?=
 =?utf-8?B?QXNpaXJVUnNZM1AwMitnRzhsb256L1lnMjFxbERxSjNyZUFuQVhxTjZSTGg2?=
 =?utf-8?B?bGExTmxlbFpkYlF3c3d6bW45dkN0UFlwRUlHU3duRWhUWWFSbTlSSi9vYXRy?=
 =?utf-8?B?RFB2R1lDWFJRMjdrM2JUdHJtNmdLdXFUeFlzRTVpZUY2cGJoZzZ4Mmp6ZEtG?=
 =?utf-8?B?ZGFNelRxejFTRnFqd0ZYSlV0ZkJIQVRlL085Y0x3VysvckE0Qm9xeVl3U2lH?=
 =?utf-8?B?NHdjTFZOdjlvSkNsYWJZS3FycmdEdkVrazVZa3JnSEpJRGlnQ0hCekM5UllL?=
 =?utf-8?B?VHFrdmEyWkhyUTFnU3hmU2c1bHNTcXpocDVEVFE0WUtRdjY1VGVabHRkQUVD?=
 =?utf-8?B?WEdtK1BSUHloNzVOekxwWmc4SXlPZ3J3bS9BcnhrMW1RN1NGZk1TMENRTVR6?=
 =?utf-8?B?RGY3M001b2d2dW44UmI0VVpRaFF6MkJZdE55WkVSSnFqbEEyZENQbGxIYUl1?=
 =?utf-8?B?RWhzd2g1UWs3ZFd4ZUNuTFY4KzhNb0Z5MEpTa3owRkZMSVJmZzFYSGRIQ3Ja?=
 =?utf-8?B?ZzE4YnF3eFJVTHlMTmpUbEVOVS9rOVE0UHFlZ2lERWJvRERlU2dKTkd6U3dw?=
 =?utf-8?B?MC9Vak9QRUt3N3IyWCtLREpRZlUySEpjdEVzd28yd25ydzJZTnYvRWw1SXlT?=
 =?utf-8?B?SU5paDNZWWhVL0pLVEJBZWx5Zkp6YllzaVY0QnBkaElkR2NleVFsYWdZUWdh?=
 =?utf-8?B?ZWozd3VZSjh3Y09QeUpCbjNlWWE0WTJXK0M3TVM3NEJXZmhlNkJ6c0htY2FJ?=
 =?utf-8?B?ZHppWHNMWDJER1NoUWYwdURiajkzaVcxOTNpZ3NFTEQzMWtZazVTcGhuZTFP?=
 =?utf-8?B?akhYNnVvWVFjOEF0MUdhbnVveGkrTFEwcGRKdUQ5TDRHd0J2bENmbU90UXpU?=
 =?utf-8?B?R213WHpHYU0rQ0xWRUV3ZVhVUkpqWlh4alpoSWNRQW9FdU11a2VQL1EzdTlW?=
 =?utf-8?B?Y0dwL05Hc3JXYk1vM1Z2SHpDWkZ0aDlzV04zN1J6ZkEzbGc3RnZ0UUhNdVBZ?=
 =?utf-8?B?cjd2cVJubHl5dW1KZ0U4OFVOZ1pVYzNzSC9jRVZSakpsdzlpWktDejQxaUtU?=
 =?utf-8?Q?Ai0yl5ByOmQskJKdPMF90rQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6bd0ced-72cd-4afc-fb6d-08d9cab71065
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2021 10:36:25.5139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: naZEeBMogAqjf4Rh30nEloUmuBaD89egPUBC7CCaSuEM/UhdMoGjdwgDqNfQ3Dy3dsGXoEi5Zp/fPfoU0Ii0Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5358
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

LGTM Acked-by: Nirmoy Das <nirmoy.das@amd.com>

On 12/22/2021 3:19 PM, Guchun Chen wrote:
> amdgpu_umc_poison_handler for UMC RAS consumption gets
> called in KFD queue reset, but it needs to return early when
> RAS context is NULL. This can guarantee lower access to
> RAS context like in amdgpu_umc_do_page_retirement. Also
> improve coding style in amdgpu_umc_poison_handler.
>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index 46264a4002f7..b455fc7d1546 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -112,16 +112,20 @@ int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
>   		void *ras_error_status,
>   		bool reset)
>   {
> -	int ret;
>   	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
>   	struct ras_common_if head = {
>   		.block = AMDGPU_RAS_BLOCK__UMC,
>   	};
> -	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head);
> +	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> +	struct ras_manager *obj;
> +	int ret;
> +
> +	if (!con)
> +		return 0;
>   
> -	ret =
> -		amdgpu_umc_do_page_retirement(adev, ras_error_status, NULL, reset);
> +	ret = amdgpu_umc_do_page_retirement(adev, ras_error_status, NULL, reset);
>   
> +	obj = amdgpu_ras_find_obj(adev, &head);
>   	if (ret == AMDGPU_RAS_SUCCESS && obj) {
>   		obj->err_data.ue_count += err_data->ue_count;
>   		obj->err_data.ce_count += err_data->ce_count;
