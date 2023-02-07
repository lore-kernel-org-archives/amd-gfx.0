Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7587FC636CC
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 12:59:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7E3588284;
	Tue,  7 Feb 2023 12:59:16 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49C6F88284
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 12:59:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mj4O9F4dmsM7dH5t6bpVOz3aNYc/bsEHUpujZgYRZnDlOUXSn39vF4IIH0t+r52zEbqwTX43wrHW5+xrePfbC5yEUPy8K9iBEMTxTVzjewmWu+I5DwlIwg1WMSXhj9VExw0Gmm1EVXAFPK/VtsDBS16QqEpDQ4k8bA8RogewhFnkRGJQVFNeCTC3J72i3UWnGJ8sM27egZgXP5CRx5V68/50s/a+xClI/lb6ycR08twsMYLv/47AIvm8laDbxrNwdBoXEyPUMpARrd0skzyGJiamf3gYn/mxdczdvH58rgvs+/7sBBKiXkFihyIKvEFWona1Dj8hq2RBoNU6G2LZIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyUaqcUTei+/hTH/kzGcV1vCoPUpIrXOpejP8Ysdk2s=;
 b=YDyY0gR3td5SzBAYvZ9GIBGjBcjrcevy+mlVhn5UuXLXkZ2Pvn9wQ28B9GVbA4ni/3kqjb6syUK/LEq7JBkS8/NzjXF7oDu7UjFHAwfrGdwqUhDDRgyIgoTmvnKsKTCdIk6IC49744NZyQprtb6DsJ57VWNxsJfio1MKfzuzSL0myROjSbT+vuMHx1uZJZ0QrYo5UBBD5Us63l37xwoghEweS6zs9c+ojJfLYL0p3KkovTlGbTF0e3FD9EL2waeMYx5pp1BreGr/fUdyYM7d0qAgtyzWA8C9I7jC3Nmb+XrCbJDRtEtx4u4+nbXHL+usHJJPtcrSF1Kpt77/Xkt2dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyUaqcUTei+/hTH/kzGcV1vCoPUpIrXOpejP8Ysdk2s=;
 b=F3mjyF36TbFbvqigbd05nm+pr/o3dm74jUOXFylTyD6TBP9u+RxvY1eFc7y3DfZQJ5tm9k8StS6f69uqu58n2F+P5dnBKR2Lxgbn4B0wbdftnufkEMU4bHZOfFyS8Z+WDI8BxS2h9iP92hYfTm79I/2rW+34Awzyc3QrDyJKeAM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 DM6PR12MB4282.namprd12.prod.outlook.com (2603:10b6:5:223::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.36; Tue, 7 Feb 2023 12:59:14 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5935:7d8d:e955:6298]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5935:7d8d:e955:6298%9]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 12:59:14 +0000
Message-ID: <8d9869ff-a674-fef6-5422-db444ec2d125@amd.com>
Date: Tue, 7 Feb 2023 08:00:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] drm/amd/display: Align num_crtc to max_streams
Content-Language: en-US
To: Tianci Yin <tianci.yin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230207040524.4020763-1-tianci.yin@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20230207040524.4020763-1-tianci.yin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0110.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::13) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|DM6PR12MB4282:EE_
X-MS-Office365-Filtering-Correlation-Id: 72315262-2850-413c-1d4d-08db090b1d28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2OaKceXOlx/QlZMOfI3V4sFdq8K3Vc4BFL1NRIHVG+RopN0OstTI1P4uyll+8KODDvtq2Xf4mkx/XGWe3rg//aPRWLGhye6yAFBp3htfLvGzApyRPtfxg+10hZf46enfGslKgSdPH8ASWtcWHUgSVY+ya8FRFBS4KZxKNyUIMB4goGkw44cZ3s2wxaiW9//dozJSIxI+s0idYqyGRcNsW/HBKzDnm3Q7OBZOPWh3y7dM6DjckUmKl8iMxk7nkTXZm5EqC6BPrISk9Stu6PYlvCMfKhV9t2YlreD18f2+Wwp/2Q2e0DCI9HCWifQpgRtQQxWb5n48L9OCBGYdT2/2+1ottX9X3EiMCRxpakrawM9p2ND5HhW3psX2FmZg5FcGKO6UIWVcL1LxjuNfgQjatciezuuSW/94Z9WjaFNXCwblsw6YEtF1XDidUXEbCA74yicu6zuVwSEc1YCrjUzRZhDl+7Rmjnl7mGGQ8J6AkJ/nyHqlTPaeJUuRQw8/phOeK76+5GKsMItdCkD8P+bydlzXulnzPqRisaMkv0cunH8iMLpWEGWmtarEb1Dl8uU6krjmEtFdwoTOX8wM80A37zuTnYWvqrKIZXX8X82PJ064zDWAKdDp0DDy5YldLdM5pkkFqhhARedMorzgbEdSemPU9zFPQAf/jUAI5qcJFmP5KSofngCMH4Q5tz1e8oWb2cy93VJ7CL/WciwhUMLUFxg9vE2RCgjxvJl0q3v0R9c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199018)(2906002)(38100700002)(316002)(83380400001)(8936002)(66556008)(66476007)(4326008)(8676002)(66946007)(44832011)(5660300002)(41300700001)(6506007)(53546011)(6486002)(2616005)(26005)(478600001)(6512007)(86362001)(31696002)(54906003)(36756003)(186003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3h2bW0vR3NrUnB2bWlFa1NVU1h0cmNWeVFjRThHRmtQM1MrRkpIMUFsdTRm?=
 =?utf-8?B?T0dlYkhPVDVWUjdMcnFUa2N2ZXFZL2ZiYklhR3duNjNuRXhhU3l2aHdqL3hy?=
 =?utf-8?B?dzRESmRoaHE0N2RDbDVQNXdBbG5oenRZcXk2dUxqZlRWM05OZUJSQkVVUXUz?=
 =?utf-8?B?VTQ3Umo2MkxsZ3RSUmI0V1BDU0pDVFQ3OEl2bWxRM1RSaUhaNFUwTlY2R2lE?=
 =?utf-8?B?Z01MSzVIV2tzSTA0VFdjd3ZFNVJOQXVPTmFpRTFDWjF3WTBLUm1jZ3JJNXFI?=
 =?utf-8?B?Nk04dmVQY3pvc2ZtS2lmSmZNNzBjY3F1cGtEVTFsT1JKL2UwK2xsTVN6MTl4?=
 =?utf-8?B?WWFRL2ErWkxYZ2tlcUZlMDBpcDdod3VtNnpRS3VBZDZkUk0xZllCM0FObW0v?=
 =?utf-8?B?d1pieTgzUWVKQ3FySG1IMDlBOFpHOXgrV1FWTDlUZnNKcUx3WWYxQnVPUm9Y?=
 =?utf-8?B?MTB0dzRibHh6eC9MS0Z3VGhUNXYrZ05SVnhwVzhLaVdxVUFwVGxodnUxSWxw?=
 =?utf-8?B?ZTF5anRQdWZaS0FWekVqREJITU1JZmpOZ3d4c05HOWkxSkhjczVaalNxOVZJ?=
 =?utf-8?B?dHpienFuRUdHdklNS2tnSWt6bE5rZkZxcmxFTERuREpRWnEwMjdVRmh3QTNQ?=
 =?utf-8?B?S3ZDNm9KM2szRnBkUUcyRkM4YU1ZanlNSU9aeTlkWVFOb2V0aFZybUd5T3hl?=
 =?utf-8?B?bmRRVDFab3FoamtPNDZBZG9hZUFxT05XZldTSTlVZy8rc1FjWkdNNjJKREpU?=
 =?utf-8?B?VG5HSkpBeE5Qc09CRXhLY0svR2hST2s1YjFrWU5JazZhRTBVbmM4bXNEWkhB?=
 =?utf-8?B?VFB3dzlQcXBaNkttV01FMFVuRXZ3UWhPb2ptR1BBT1lYbEk5bjB6YjZGODha?=
 =?utf-8?B?MTFidnJOa3pxVHFXMy9rMWtnaWtNcXZOREVFWEVUYjRjNUkxS1ZpWTVTL2dp?=
 =?utf-8?B?bGNsYnpvOGsxU0lZZnoxNHpRTURGdzNmWktlVVhPQkJ3dVd5R0xTaGFNQmV2?=
 =?utf-8?B?cExuei96TldpK29QNUJXYWxrSkJyeksrR3FkR2h5aFZNY1pjcEx0MG1USGhT?=
 =?utf-8?B?d2dTVGx2dDBKTjVoWHBManJrYVppOVpSWEJpY1dmZUpqYm1STU1VblZGUVdD?=
 =?utf-8?B?SzluV0YvYzdJWHNiVnhaaUtiSVpwVm5wd3R4Nm5DNzhXTTluUGNmUE53RmRU?=
 =?utf-8?B?aUJIWWxRM1J5eDd1bStDQkRrR0xJbzFFZFo3ZE9EcUR2dVk4Z1BHRksrTHBH?=
 =?utf-8?B?bFNIeTBOby9qNzlVWSt6TVI1RjNIQmdrMDlWcHJHWTg0c1V0VmZRT1dTS1Fi?=
 =?utf-8?B?aThGNzFuK1cvTW9qUmw1b1VaRkZHUlFaUHk1ZHRFNnkvcnRuK01VUC9rMGVW?=
 =?utf-8?B?RDYzek1sS0t2UWs4RmtmZ3EzS3lLRUtQcWZpaEtZQzlNL3AveEJYbVljN3lN?=
 =?utf-8?B?Y2lvSklTZmI5bXZSN2VBWlBsL1Ntdy9wNkxaRkZ4UzVMSDJtcmRqS0dKNk1y?=
 =?utf-8?B?c20zalQ3enJ5V1ltQ2U5T1BtRnhZbHBENnY5ZDBFS0dNU2cxbGFmTTVXYnlN?=
 =?utf-8?B?dENRSWhDdVo5WVh2ZzFwMHhvRTFNRHd3WlZyS0VHU0NyaW5Ub1BmcGJSeWRl?=
 =?utf-8?B?U3FCQ3dXeW9TWFVHTU5rajdjUWJyMHl4Mk9RWWY3dHlPWi9kWVV2L1ZmUytQ?=
 =?utf-8?B?M3U2YTRCeTA3TlNzY2RKcmZYY0Q0SDlCSG9FNDZQWGlQcm5yamJMeHpyNTRu?=
 =?utf-8?B?czJDOEwyWjJVNW5VcDhYWWxkSUYybjlrMWVSbWFxVUcwTmlkeEc2M2dPQXAw?=
 =?utf-8?B?enN2R1dheE9VakRHWEx4Z0RKS3lrU0pJV0RJMlF0NHROamE3WUt0cElNUHhl?=
 =?utf-8?B?aHdCT3dyaFQ0L2FWZHE0M256SW9YSWpiQUlhMGk1Nnc1ak03MGllV2I5UzhR?=
 =?utf-8?B?WVo0dVV5Y1luNWJ3WkZVM1Vjd2w1aWIzN0xzUjFzME8yaW9ORGcwN2NzaStm?=
 =?utf-8?B?RXA4NlRiVHVxMTczTWp3NWUwL0tzY2xYdi83T2NjdnhJdTdVTWlaWFdsaVBq?=
 =?utf-8?B?MG5lMW1LSDFValpwSlhvcG9QOW5DT0JiT3d3ckpOSTJaSGNrcDNQYXhST2NJ?=
 =?utf-8?Q?ObaLmONO0YqtfbHK/viBetsHG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72315262-2850-413c-1d4d-08db090b1d28
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 12:59:14.2765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPs/dU1bF9IAaXpbsrIMYP6YNDK7xfosJ826T3VPToYCyBNs0pfJU1CMVeERdW5CfXwD0nhNv3+PS+gKz41udQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4282
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
Cc: Yu Wang <Yu.Wang4@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2/6/23 23:05, Tianci Yin wrote:
> From: tiancyin <tianci.yin@amd.com>
> 
> [Why]
> Display pipe might be harvested on some SKUs, that cause the
> adev->mode_info.num_crtc mismatch with the usable crtc number,
> then below error dmesgs observed after GPU recover.
> 
>    *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
>    *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
>    *ERROR* amdgpu_dm_set_crtc_irq_state: crtc is NULL at id :3
>    *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>    *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>    *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>    *ERROR* amdgpu_dm_set_pflip_irq_state: crtc is NULL at id :3
>    *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3
>    *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3
>    *ERROR* amdgpu_dm_set_vupdate_irq_state: crtc is NULL at id :3
> 
> [How]
> The max_streams is limited number after pipe fuse, align num_crtc
> to max_streams to eliminate the error logs.
> 
> Signed-off-by: tiancyin <tianci.yin@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b31cfda30ff9..87ec2574cc09 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4285,6 +4285,9 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>   		break;
>   	}
>   
> +	/* Adjust the crtc number according to the DCN pipe fuse. */
> +	adev->mode_info.num_crtc = dm->dc->caps.max_streams;

This would introduce array-out-bounds issues, since there are arrays of
size AMDGPU_MAX_CRTCS that use num_crtc as a bounds check.

> +
>   	for (i = 0; i < dm->dc->caps.max_streams; i++)
>   		if (amdgpu_dm_crtc_init(dm, mode_info->planes[i], i)) {
>   			DRM_ERROR("KMS: Failed to initialize crtc\n");

-- 
Hamza

