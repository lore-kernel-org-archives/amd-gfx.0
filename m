Return-Path: <SRS0=iyzK=O7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5E0C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 05:04:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E23160F21
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 05:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8E23160F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24A326E40A;
	Mon, 11 Oct 2021 05:04:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF6836E40A
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 05:04:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hp9iKNxpdWhWfXK2piAD9PculFslaP/KRCN2JbVM9DDWMGS8ip7Oosei9wGRvy3YN9H9J38BUAvjwyQeiT03pqxfUjdcYVG56ah898dmpQcVoNwnVd4D8kuawh8gRRr4v6h2TJDhBCsQ4HaRCl9DFoO5nr8bUuH8AqEZoNel0Gpp2x+THJDa22DAdTZW2cCdbYxbVDyzHAkxbH0rkT4JpTuzGjbt1lJPZ6isuClxdz1slF/1eFXva77VAJDMqXSsm+Lv74/7L8bPNMReJvTvnxgcPeNVUkRzLunZDZM6Bmi8FQ1CNvNKtKfuxR1if93ZALUflQpEnS/fiDTpHxKxVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FpyGe36lZLTVqpcB4OpgD6pRUSKXZn/42bCmHZHbd4=;
 b=K1JAw1ra4iYqfh30r8GXwAslm8e7y2AwGcWkWYY77Mghn2lCHecRV7CzyJ1kYQVMLQJOufqfQ7aWQzXppsZXxxwcRuWZ7LQWSiK5i+Bif61BPegAZ4SSjbz6rnUYfqO7KNnUT5lktLToVwPMP375ING9syFsY5uxWoaJ7jclsZyECG/4vUCvTW3JhodWZyep4oKKeYt9YlDZxfaNoqE5GUrWtKOIR9GzepXjdBzq3yr99iaSK0gd09FEKk60U7wSx30YiNAeVLmj335d6ulWWq6Q5iZJrZsyO00ZJbCw8kO9cNsRYNtCQ69q1VD7LX1Jl+regcfWcxLSSf296EpYIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FpyGe36lZLTVqpcB4OpgD6pRUSKXZn/42bCmHZHbd4=;
 b=OCytCcvvnCZ6PYx8pvEZdYVzO0l4oW+zvRU6Sljse38QA89TkWmxuHlaz32YXe8k0gdiXti8r6XghRT313mREjL/ViVqZhE2tQ729qYYKiFqjx+iunj7y8cQEgNBXn8lTHLiPzNK3saaBDfqiX8iy7/ogLqknpwDFB2gMzCGY9U=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1672.namprd12.prod.outlook.com (2603:10b6:910:11::16)
 by CY4PR1201MB0087.namprd12.prod.outlook.com (2603:10b6:910:1b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Mon, 11 Oct
 2021 05:04:38 +0000
Received: from CY4PR12MB1672.namprd12.prod.outlook.com
 ([fe80::4c19:3458:dfa7:bc9f]) by CY4PR12MB1672.namprd12.prod.outlook.com
 ([fe80::4c19:3458:dfa7:bc9f%4]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 05:04:38 +0000
Content-Type: multipart/alternative;
 boundary="------------N0HNtSi08g2cvQD0gjawiRJ7"
Message-ID: <09d8abec-7e83-a83f-e53d-ae827b753e7a@amd.com>
Date: Mon, 11 Oct 2021 10:34:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH] drm/amd/display: Enable PSR by default on DCN3.1
To: amd-gfx@lists.freedesktop.org
References: <20211008161415.4296-1-nicholas.kazlauskas@amd.com>
From: "Vishwakarma, Pratik" <pvishwak@amd.com>
In-Reply-To: <20211008161415.4296-1-nicholas.kazlauskas@amd.com>
X-ClientProxiedBy: PN2PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::31) To CY4PR12MB1672.namprd12.prod.outlook.com
 (2603:10b6:910:11::16)
MIME-Version: 1.0
Received: from [10.252.92.67] (165.204.159.242) by
 PN2PR01CA0026.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:25::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 05:04:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9be43ae-82d2-4cbf-3547-08d98c749fc0
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0087:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00875DECBBF293C2E34CD6ED80B59@CY4PR1201MB0087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0/gwrcSBm1WCxAGudby6AbhWLWhF7Gf0xP/4XrpaObC/FjUk4yB3eXoi0xm01DtHdTd6rZU7YpuKk/KXVRVoLhT6zmKaCXD56c5l9NLILpJ2VAeC6E0M/JBImV8WXcYz+vl9IbNxGYgX7qU5OGRfYZlDJHVrLmztjIGdLtoSuHUi8DekY70gwbG1U9ftQx8N4FTw/kHwEL1xUskCQqMeRpkSkPjx5zHl7/HT/ISbPxgrVdAEzDmNwKtjCF1xrFdX549FzEfJouyp9zNh7umxNsU8n4BfEvFEFaObM7mtN4WjTYJWANUfXBdrLlIHb249snmTvblaabQNesWAEkUaWdUx4+fOrO0C+Dg8I5LbfidMe3PMaNmzJKYakrBirGmMXAwCEvUr2bmpk5oepno2mdNTXN1Y/g2dCIHRzzRzYKW4PCRoj0O40sWUiaD8cCQOW0OIa1068NHfnYLhxsgXCNf9d+S+GmZAYLYxDK7IeVieU66JPXvfpbEFp/gMZqfltJBmUGCbuNxpP5ZV/HEpVm/1hbN/TW62ShXwqN2qrmhPJBffe39g6QP0l+g9W5MS7OJJOO3AXw8oFj/MONtdrl+ws/jDUKb2VcuqoKko42u/jooEGNtgSo2LGKuV0B9kZgeHkzPuOd/DohzVDcrkwcFnpj0V5buUf0omZ/LdL57rnMwbvrWHuyYOfSZ8xhAXuhGyc04/zs6jZJxIHUbKTk/M8Sxa3z6eDmUHSlimAAQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1672.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33964004)(53546011)(2616005)(956004)(83380400001)(6666004)(5660300002)(316002)(8936002)(2906002)(31696002)(8676002)(16576012)(186003)(6486002)(26005)(31686004)(66946007)(508600001)(38100700002)(66476007)(66556008)(36756003)(6916009)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djZBTHhQYloxa3ZpNTNvWllpbU9ENjhlblp6N2xNNlBJRVhxSVdHWTQ2U2tl?=
 =?utf-8?B?Sm5FVmdPWDNQeFF3eitKWGJzbW93d0t2ZURvcDVtNG1VWmFyRm83RTczVjZQ?=
 =?utf-8?B?KzhLaG9sanBBSTl3VnFpUWFnUmdaQnExb3E2d2pJSFZ1N2pjZ1Ywd1hyTWhG?=
 =?utf-8?B?YzYxREdUYm50ckJCUjZnZ2tMMjMxUE5YblR3dUdEUEZzZGFOdWtoYVNMcmVX?=
 =?utf-8?B?dVZGRjdNTXZoV25GV292R3BYV3dVd0xOWGdkdWdJRmczUVozQlpHWGF5OU1Z?=
 =?utf-8?B?ZFc4ZWRqM0FPMUxnNW9LTG00V0w1S0tOT0tCaTlZRFpoa2VWYnlqenpmRVRa?=
 =?utf-8?B?NXRuWkZkVkMzOFE2WThYY2NuSjFCTjFCdFdISEV5VGRNeWVEK0k3OWJZOW5Z?=
 =?utf-8?B?VEhaQ0N6UUVFbXNxbWsrUDRuTHVCbWJ1SG45R0M4b01PVHp2L0E0SnYwRzN5?=
 =?utf-8?B?Mm9pMDZrdGRUNlF2SFB1blZPNFlaU0JKNUhJWGQ4eWRkUlJXVG8yNnIxSHV3?=
 =?utf-8?B?TXllNXgvOWRDaERKR2lmckg0d3JXd01ER3BGM3YvT1lwUXhBa1U1NG1CZ2t2?=
 =?utf-8?B?ZDNoRzlrSzZ5Mm12ZGtrVnlMOFFOR3B3V3VXTTRGOXcyQmxhdGhLM0xoUlRH?=
 =?utf-8?B?T1lpQWt6MEYxOW5vYkJDajZZeXNoZVVMZGUwc3hmRWJBY093cXl2K3dPSGJ0?=
 =?utf-8?B?YVU2Q2NTMTNLY2pOSkV4MzVCWXNwUFFiWC9iVkM1WnlPVEQxcmJIeFlIQmE2?=
 =?utf-8?B?UXBzRzUwMlAvOCtCNXJ3Z3FQUUs0R0FES2I1L2J6UU5qRFJYc1ovRS83T1Z1?=
 =?utf-8?B?RHFEdW15RGFtQVhkYWZBbjBpUzRoUzUxQ2U5TGlxV08xRU5ZdmhlRWlUbUFK?=
 =?utf-8?B?SzBmMkV2YkhrV05OU0NITzAwZDl0RndxcUtWdWdadjhDOEN3SGFYMXB4bTgx?=
 =?utf-8?B?ZURHNldTVVBjWEVRWTdiZFkydGxLYVQ2S2JCZWU4cllheXh0VU41d3NiaHBz?=
 =?utf-8?B?cExqWkpLTGt2UWNaWGJDRXlkYjY0NzIvMFhDU1NPZnpBbEo1YnhGUWhXY2cx?=
 =?utf-8?B?UUpwWEhHaDhhZ0N3M2cvNDFuVEp1SldhTWNQelZFN0piQ05mZU1zSlRSWkd5?=
 =?utf-8?B?YngyU2JWd3ptdGo3Y2xpQjJuNXFwQ1FkdUtsUmVxaEhHQzRIK21Nc2pYaGcv?=
 =?utf-8?B?VVVPTm82S0RGQWoyL21oejVOMkpBSFQrUDhHQjVINnN6QS9jbDZDUVgxNmlw?=
 =?utf-8?B?NzZxQUpqNDg0MG4wNkQ1WkRjQVBicFRDcXEwYWQrQ1E2WERIMzdEOW1CNFdK?=
 =?utf-8?B?WmE4NlVld29NRERRL1hFWGxCZTZpRWl2UTJrSlhrYkRLVEx4Nk1ESC9KWkdF?=
 =?utf-8?B?T0lCVTN1UGdiTXh5Ymk2bEdlMFd0ZnRrd1pkM2cxaXBJaThSencwU1ZvN25a?=
 =?utf-8?B?cmh4K2h6eGdQeVU2aUY1Z1BxZ0hQK2taVXhnZWZDRDVUeTVCd2U1MEdPVUFa?=
 =?utf-8?B?SVNwUDFyVzg4TUIra3gwYlIzNWdVN3JrOUI1WkFQS2orQjFRSjV0TzZrWkQy?=
 =?utf-8?B?dHg3U0NhSHVxQnJiU09RSVZjbzVaSzk1VUsyZ2Rsd3p2K0hXY1NyVDR4ZTdk?=
 =?utf-8?B?R3VXSHdVdXFsTEhodTA1MjZTOWFOelE0ejVBUFk1ekxpOFZ0Ykw1WXhCL3Rj?=
 =?utf-8?B?d1ZMWHRrV0EwSEszbnBqK2Z1R0pGWHJFb2Y3U2Y4S05SZi93NzZGeXRaUU10?=
 =?utf-8?Q?ab0YXUn+oX4/2xzSBgRNupDS00Uow/ilVbAP7E/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9be43ae-82d2-4cbf-3547-08d98c749fc0
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1672.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 05:04:37.9202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVNyOlBQK3Vxbe0pMgtI8dxAtdUajwCbLwTp0u+czpeQvoWQ9uvBL6ED8SxdOrWQeiglmjpDGLQIK7UN6pvPbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0087
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

--------------N0HNtSi08g2cvQD0gjawiRJ7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/8/2021 9:44 PM, Nicholas Kazlauskas wrote:
> [Why]
> New idle optimizations for DCN3.1 require PSR for optimal power savings
> on panels that support it.
>
> This was previously left disabled by default because of issues with
> compositors that do not pageflip and scan out directly to the
> frontbuffer.
>
> For these compositors we now have detection methods that wait for x
> number of pageflips after a full update - triggered by a buffer or
> format change typically.
>
> This may introduce bugs or new cases not tested by users so this is
> only currently targeting DCN31.
>
> [How]
> Add code in DM to set PSR state by default for DCN3.1 while falling
> back to the feature mask for older DCN.
>
> Add a global debug flag that can be set to disable it for either.
>
> Cc: Harry Wentland<harry.wentland@amd.com>
> Cc: Roman Li<roman.li@amd.com>
> Signed-off-by: Nicholas Kazlauskas<nicholas.kazlauskas@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 17 ++++++++++++++++-
>   drivers/gpu/drm/amd/include/amd_shared.h        |  5 +++--
>   2 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index dc595ecec595..ff545503a6ed 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4031,6 +4031,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>   	int32_t primary_planes;
>   	enum dc_connection_type new_connection_type = dc_connection_none;
>   	const struct dc_plane_cap *plane;
> +	bool psr_feature_enabled = false;
>   
>   	dm->display_indexes_num = dm->dc->caps.max_streams;
>   	/* Update the actual used number of crtc */
> @@ -4113,6 +4114,19 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>   		DRM_DEBUG_KMS("Unsupported DCN IP version for outbox: 0x%X\n",
>   			      adev->ip_versions[DCE_HWIP][0]);
>   	}
> +
> +	/* Determine whether to enable PSR support by default. */
> +	if (!(amdgpu_dc_debug_mask & DC_DISABLE_PSR)) {
> +		switch (adev->ip_versions[DCE_HWIP][0]) {
> +		case IP_VERSION(3, 1, 2):
> +		case IP_VERSION(3, 1, 3):
> +			psr_feature_enabled = true;
> +			break;
> +		default:
> +			psr_feature_enabled = amdgpu_dc_feature_mask & DC_PSR_MASK;
> +			break;
> +		}
> +	}
>   #endif
>   
>   	/* loops over all connectors on the board */
> @@ -4156,7 +4170,8 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>   		} else if (dc_link_detect(link, DETECT_REASON_BOOT)) {
>   			amdgpu_dm_update_connector_after_detect(aconnector);
>   			register_backlight_device(dm, link);
> -			if (amdgpu_dc_feature_mask & DC_PSR_MASK)
> +
> +			if (psr_feature_enabled)
>   				amdgpu_dm_set_psr_caps(link);
>   		}
>   
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index 257f280d3d53..f1a46d16f7ea 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -228,7 +228,7 @@ enum DC_FEATURE_MASK {
>   	DC_FBC_MASK = (1 << 0), //0x1, disabled by default
>   	DC_MULTI_MON_PP_MCLK_SWITCH_MASK = (1 << 1), //0x2, enabled by default
>   	DC_DISABLE_FRACTIONAL_PWM_MASK = (1 << 2), //0x4, disabled by default
> -	DC_PSR_MASK = (1 << 3), //0x8, disabled by default
> +	DC_PSR_MASK = (1 << 3), //0x8, disabled by default for dcn < 3.1
>   	DC_EDP_NO_POWER_SEQUENCING = (1 << 4), //0x10, disabled by default
>   };
>   
> @@ -236,7 +236,8 @@ enum DC_DEBUG_MASK {
>   	DC_DISABLE_PIPE_SPLIT = 0x1,
>   	DC_DISABLE_STUTTER = 0x2,
>   	DC_DISABLE_DSC = 0x4,
> -	DC_DISABLE_CLOCK_GATING = 0x8
> +	DC_DISABLE_CLOCK_GATING = 0x8,
> +	DC_DISABLE_PSR = 0x10,

Don't we need a corresponding check in amdgpu_dm_init() to disable PSR 
in runtime?

Also, how does it handle conflicting declarations from feature mask and 
debug mask?

/BR
/

/Pratik
/

>   };
>   
>   enum amd_dpm_forced_level;
--------------N0HNtSi08g2cvQD0gjawiRJ7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/8/2021 9:44 PM, Nicholas
      Kazlauskas wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20211008161415.4296-1-nicholas.kazlauskas@amd.com">
      <pre class="moz-quote-pre" wrap="">[Why]
New idle optimizations for DCN3.1 require PSR for optimal power savings
on panels that support it.

This was previously left disabled by default because of issues with
compositors that do not pageflip and scan out directly to the
frontbuffer.

For these compositors we now have detection methods that wait for x
number of pageflips after a full update - triggered by a buffer or
format change typically.

This may introduce bugs or new cases not tested by users so this is
only currently targeting DCN31.

[How]
Add code in DM to set PSR state by default for DCN3.1 while falling
back to the feature mask for older DCN.

Add a global debug flag that can be set to disable it for either.

Cc: Harry Wentland <a class="moz-txt-link-rfc2396E" href="mailto:harry.wentland@amd.com">&lt;harry.wentland@amd.com&gt;</a>
Cc: Roman Li <a class="moz-txt-link-rfc2396E" href="mailto:roman.li@amd.com">&lt;roman.li@amd.com&gt;</a>
Signed-off-by: Nicholas Kazlauskas <a class="moz-txt-link-rfc2396E" href="mailto:nicholas.kazlauskas@amd.com">&lt;nicholas.kazlauskas@amd.com&gt;</a>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 17 ++++++++++++++++-
 drivers/gpu/drm/amd/include/amd_shared.h        |  5 +++--
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index dc595ecec595..ff545503a6ed 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4031,6 +4031,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	int32_t primary_planes;
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	const struct dc_plane_cap *plane;
+	bool psr_feature_enabled = false;
 
 	dm-&gt;display_indexes_num = dm-&gt;dc-&gt;caps.max_streams;
 	/* Update the actual used number of crtc */
@@ -4113,6 +4114,19 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		DRM_DEBUG_KMS(&quot;Unsupported DCN IP version for outbox: 0x%X\n&quot;,
 			      adev-&gt;ip_versions[DCE_HWIP][0]);
 	}
+
+	/* Determine whether to enable PSR support by default. */
+	if (!(amdgpu_dc_debug_mask &amp; DC_DISABLE_PSR)) {
+		switch (adev-&gt;ip_versions[DCE_HWIP][0]) {
+		case IP_VERSION(3, 1, 2):
+		case IP_VERSION(3, 1, 3):
+			psr_feature_enabled = true;
+			break;
+		default:
+			psr_feature_enabled = amdgpu_dc_feature_mask &amp; DC_PSR_MASK;
+			break;
+		}
+	}
 #endif
 
 	/* loops over all connectors on the board */
@@ -4156,7 +4170,8 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		} else if (dc_link_detect(link, DETECT_REASON_BOOT)) {
 			amdgpu_dm_update_connector_after_detect(aconnector);
 			register_backlight_device(dm, link);
-			if (amdgpu_dc_feature_mask &amp; DC_PSR_MASK)
+
+			if (psr_feature_enabled)
 				amdgpu_dm_set_psr_caps(link);
 		}
 
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 257f280d3d53..f1a46d16f7ea 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -228,7 +228,7 @@ enum DC_FEATURE_MASK {
 	DC_FBC_MASK = (1 &lt;&lt; 0), //0x1, disabled by default
 	DC_MULTI_MON_PP_MCLK_SWITCH_MASK = (1 &lt;&lt; 1), //0x2, enabled by default
 	DC_DISABLE_FRACTIONAL_PWM_MASK = (1 &lt;&lt; 2), //0x4, disabled by default
-	DC_PSR_MASK = (1 &lt;&lt; 3), //0x8, disabled by default
+	DC_PSR_MASK = (1 &lt;&lt; 3), //0x8, disabled by default for dcn &lt; 3.1
 	DC_EDP_NO_POWER_SEQUENCING = (1 &lt;&lt; 4), //0x10, disabled by default
 };
 
@@ -236,7 +236,8 @@ enum DC_DEBUG_MASK {
 	DC_DISABLE_PIPE_SPLIT = 0x1,
 	DC_DISABLE_STUTTER = 0x2,
 	DC_DISABLE_DSC = 0x4,
-	DC_DISABLE_CLOCK_GATING = 0x8
+	DC_DISABLE_CLOCK_GATING = 0x8,
+	DC_DISABLE_PSR = 0x10,</pre>
    </blockquote>
    <p>Don't we need a corresponding check in amdgpu_dm_init() to
      disable PSR in runtime?</p>
    <p>Also, how does it handle conflicting declarations from feature
      mask and debug mask?<br>
    </p>
    <p><i>BR<br>
      </i></p>
    <p><i>Pratik<br>
      </i></p>
    <blockquote type="cite" cite="mid:20211008161415.4296-1-nicholas.kazlauskas@amd.com">
      <pre class="moz-quote-pre" wrap="">
 };
 
 enum amd_dpm_forced_level;
</pre>
    </blockquote>
  </body>
</html>
--------------N0HNtSi08g2cvQD0gjawiRJ7--
