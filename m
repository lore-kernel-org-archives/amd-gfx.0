Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF1710A3D81
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 12:12:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E6FB10EA54;
	Thu, 26 Mar 2026 12:12:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Q80AhQx";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F02FA10EA54
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 12:12:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HP/vnO+kBCwmIxoZaFtCspMMbF3RNCpqQY6jLC+BQH4Lpe147tYI0pNra9DxKecPHxfG7DjpXvt8OqQWy24O3zgKBVdDOq1r9kxlLFBvs3EX3ipFF81vTAki96lHESiz01gHU67K+ZKEIXBK9Rh0xyKcayva5prbOciIvfzee5XCmFZAErSAe7LkUnKeWpEc6w0JYfqliS0Lnjw8Xy/23+gW3T+OHTpupPs4XvZ4JebBq3cp1czX6ysOp9EXNiKVnTM0Sv12Oj2pm9Llx9RK7RcEqpV59YlThMlHWFlqCfLk4UdzyrfHfrOzWmv7i+G3bIOTx3a6S0UslCr43DH+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cj4QAiYOMj4Sr3k40x4+pEKFCWOZU7wCOQQ6LlxxCzY=;
 b=S3hrwEPzIlcPokSouq2qEvTFdV5HqJZ/3mdlIFjwDoCoYtiWqN4rLM9XgvsQ2eVJQ53gRpAQOEEQBtQgGNgjVXurpbwbN41fZ4xEwDPOwxVFdcIItHg5edTD9OJ8OCL0df+onlrazza7zh8i8N3OzofU7pI3OMbQ5f1el+cc+CgNH6eWRrGBakAHDTWOvxy5qQtcrkf+k83fw35PBS4ykRlo9trV+bxAurW2nx5XNWxQoiZiGHC12GdIRsX8ZUM8PHd/zja4Tbj8FBHT2cYCL52s06L2EaX/R4192ekjm0ro7Y8XUWUW9IC7v6UbgqnnQHFSzEjYE/XVls/gfDVd5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cj4QAiYOMj4Sr3k40x4+pEKFCWOZU7wCOQQ6LlxxCzY=;
 b=5Q80AhQxbjQ35itghcgdigIEWpKIcy5w3cgVatMv3LcP3nRF8nDjZZigMuEMUeMHrbhORUi3zd5eP6yKEJ5VRiDYDTfbKM/BXGABd/V3LvtRrg4Ccb90MjN6KZinZy7+J32XrAUkBPKkmyR5XPrPeMxRPRn0qdkz0p0UNC17QRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by CYYPR12MB8749.namprd12.prod.outlook.com (2603:10b6:930:c6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.12; Thu, 26 Mar
 2026 12:12:21 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%5]) with mapi id 15.20.9769.006; Thu, 26 Mar 2026
 12:12:21 +0000
Message-ID: <d24b7d91-e775-4310-997c-f628332c13c3@amd.com>
Date: Thu, 26 Mar 2026 13:12:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v1 4/4] drm/amdgpu/userq: Fix the code alignment for
 readability
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260326085601.2665215-1-sunil.khatri@amd.com>
 <20260326085601.2665215-5-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260326085601.2665215-5-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::16) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|CYYPR12MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: d41fddd4-ef3d-45a4-f58b-08de8b30eebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: RamyuV39Pdj2XaoOeM8GlkzBV6Cukou2zia0rvo0encnLLH3z1oM0tqhrGbpmGydA9S++n5VUbn95dc3GicNPiwRFrQNb3QibxkI36Hkf1DLz/6b7Mp+OttHv3+Vl0avcUZGBmJCMxtpYWxr3PwBYg31OOTMl07bRiz7LKFOxNEgu67Ua14BbeXwUv1eDZ4qHbZJdSdL13zxwR2pwJXcF/ZT+4QuGxTp6I6VndAodRr+tjABZNEiaLtT/LjcsO3/ltzBeU7CiSo5hQZhkIpvjTVvR6KJCLS9ajiukGDR4lbaH4yb7fOYf6RJa+K2pUdRBQS8HFCe9cWrsiE+uB6XqsgZWEMeGyZUYgpYtF7WOQ8LluTZyczVaIsVarIiKx9HWHnibutQjt3qgC40BQhEQEyVZL8lgHnuxOuVJNtbV0v06Q/awNXN9Etk5dM6YF9bNvr778Xs+P+mOi9LOqlHIJnPgqqw15gjBvFgIbHU1a/JAFPJ13JS/0SBc0xlAJ9RD6gfejJAv30LMDa9eSKi59t4ser/Jq6EyU4TfOuFpL5YqQa7pr5GB2HZo5t+yuExIg9DpuMCzNbCjuDn2b61D3JeudLx7SeaMWZGrIpeJCB1s9keXrhFQLDuZ+knyFMirKMlXpi0h5Q2+UlKUxfVN2zyxiSxL1Bhm+mtd9YoeFC9qBoOKxuvmOcBs66N20LBCpOblSVFx40KVnrIi6E+C2zCpbvYOfh2w7oqVkdmIqU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WitxdHUrZkM2MlRLVTBMZm50SjBvQWN1bTU3eUpCYmpPVlM2cGhlTnd2Nm1r?=
 =?utf-8?B?ZDErc3RBTWZBVnF0eGFPTUM5Tmc3Mk5NdHhsVGRrbm9Uakl6TGYwNFVkaG0x?=
 =?utf-8?B?eUY4OVlrbzNod3poN1d6S3NCYU13ZXl0WWtYNFZCRHRRYXlkVXlNdUxRUldE?=
 =?utf-8?B?V1cyeTAxU3UrUlE0NEg2bytPckVYM0dsRm9tbWZYQ3V4RlRUNjIrVE01ZjJW?=
 =?utf-8?B?anF6UXRselhyME5ab21NTXBDbjU3UC9BUjYrd2oyaWkrcEh1MTcrQWNtb0hx?=
 =?utf-8?B?ZVBLMGt0dk5Mb0FITUlvendaeUpCL0xCb0M5MUhDNkc2MnhnUzBxTHQyWTdu?=
 =?utf-8?B?NW9WK09RMjdLNHFjQ2tlNHEydHNlNUR5c2llTXdrUTQybVlkL1J0MmpEMEE2?=
 =?utf-8?B?RTRMQjdXdG8rUlhlQU9tcmJWN2F0d3BXTzhPRDZaUDNGZ0cvYTI2S2VoMml5?=
 =?utf-8?B?b1JGenppaS9UeHN4RTFnbWFmSlJNckppblZGQ0lVdk44d2JERkhSVzhtUHNt?=
 =?utf-8?B?RnRZcEQvUGtOdGtockN5T2RwR3lRV2tFVVdWQlF0ampGQnB6V1MydTB3T3cw?=
 =?utf-8?B?T1djT09uNzNnYnhPYzVEZXhWWWRuZzdSeXdnTnhrR0pld0p6eUIxRGg5Mi8x?=
 =?utf-8?B?dEdvTEpLWGxVaDg0eGpBU2ZWYU8wUVlVVHUwQmM4aUE4MkZ5dWh1WE1PS09V?=
 =?utf-8?B?d0ljVml6S1FsMEdsMkxTN2ZjaFhHWVZxKzVQQW9pWjZ2VFBHZEhlZnFYUXNI?=
 =?utf-8?B?TkErYzcxUnlRdVV0RkJDbnQ4S2w5WTQwcm9temUvaWtkOGhSakVYbys5cVVj?=
 =?utf-8?B?QlZqNkhaMzc3Tk05aWJpb054SHYxSjNoYkpEQW9yenM0dlQrV0tzcEUxUU5r?=
 =?utf-8?B?UzFpTlRaaG5SeTB2Qy9meHZPTTJUVU1VcHRNbkcrUloreWpZSVQ4RFJUdnF5?=
 =?utf-8?B?NmF0dTFWZHBZR2JqUEFjWHlLaitRLzJadkZUQXd4VlFTUmhlTk5HWWZWSHpV?=
 =?utf-8?B?b1BpRmx6MXNtcGtrK3BDNERRWEd5SDhEMCs1RnAySG1aMW1ZYzBqTHo4RWJY?=
 =?utf-8?B?VVg2enlyR2RINjNsYjM5MlNoYWM2OUEwbmtwUWg4WXhUVDJsNlpubldxRkZv?=
 =?utf-8?B?OGZadERVQURGczBsdkpEV0R6aFg3dnhmaGY5QnZlb0UxSWZ5UFNlSkloazF1?=
 =?utf-8?B?OFJsSUUyczBTS2N4azlEYVpYcGQvZ1paS281eWhER3NGRU9INkJQdU5pU0Nt?=
 =?utf-8?B?QjduaUQyeW5PVm5ieVowVXVCd1d3RzZoZzFaMXFNNks1MU9wM3BIS0tnWFQ0?=
 =?utf-8?B?VVBSSWZXVHViL2pzMG5WZXlNcmhYQVhEbk9DMFZIaVhUY1AvZWpCUGc3T3NM?=
 =?utf-8?B?WGN2MWJCcmxpT2p4ZVh5RzZEcUtkZDVsNHcxYmVIOU1LSjk1ekdIMFdNRDBl?=
 =?utf-8?B?Um9ydk5RV2tQVWRMbS9SQUdDcEw5dGNDY1JhZk0rbTA1bExIV1ZFR1JsT3Jw?=
 =?utf-8?B?OGVNeUM4QytjNXNuQXc2dmZkQU5OYnkzQ01OT0diOER3QUNoeGE4M1lRY29G?=
 =?utf-8?B?MGZQYUVoVXBSMDFyZG5rMURrZWg3NmlZK1NvZExaM2lhTUE0NUhzbWlRNW5a?=
 =?utf-8?B?a3hBRmlYY1M5K21IWTlKVmFTa0w5K2Q3V3diQWhHMkJTZzFIYmI4S0IwNEF2?=
 =?utf-8?B?a25BU3RvWDJNV0w0NUx6SFVwZnFua1RIVUNNMEpFek1rYzlNZ3NIaEVVMFhK?=
 =?utf-8?B?OUE5cGNzMGZXT2kzSzhXdVJ0akpJZ2gwUTRGK0lvekpzN3IreXA1aGZySWRY?=
 =?utf-8?B?ci9Nc2ZRSnRpTHZGOGVzR2pjS0Z3VHFBOEQzb2ppWFFMTlJmNXplWUFsQTA4?=
 =?utf-8?B?ei9PWFdjUFNjem0wbGxEQzdUY0J6dG5wSXlscHZnV3kranpYNHhzNTZPUm96?=
 =?utf-8?B?a1d2cnZEMFYwdWxTTThSc2hXbWZacXNsMUE2aW1YYU5PUFBZWmt4eDBaTjI0?=
 =?utf-8?B?NmhQZWNVWCtQdXMxSXRVZXFhcWNsa1o4eVJhNk5VcThvbUpISy8zNXZmZ0d2?=
 =?utf-8?B?QjVXUFpML0NkaWRGU3pneWJ6dFhzdXZEcDg3djQrVXh5T2R4MjUyY1RDc2M3?=
 =?utf-8?B?UWlQT0xDUWJsdlpKTWZnYmc0TFUwb2Q2MDMyM3FxWmRSYkV3ZmZKYnlTOXh2?=
 =?utf-8?B?aTBVcm55Y3dRUlhLNE5KUk9hNjhXbkVFQUl1Q2NyalJ3TmpDM1lzWEx5Zllz?=
 =?utf-8?B?bjBnSE5ka3o0RGdoTk91WXBBWExGSi9TVE13Vk5wdC9XOTRMZnJta0JOZlRr?=
 =?utf-8?Q?nbn58pAeOGx1ZMCtFE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41fddd4-ef3d-45a4-f58b-08de8b30eebd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 12:12:21.5453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6BARTS+nuhkFcn3+ZM0wyqfD6mcT9H83dZtxbaLkELo04ts2w0r2MCj7m4m+Eck+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8749
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

On 3/26/26 09:56, Sunil Khatri wrote:
> Fix the code alignment for if condition and also provide
> a line space between multiline if condition and next
> statement.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 48cb2e21ce56..7cdfe3adcbae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1454,17 +1454,19 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>  
>  	if (!adev->userq_halt_for_enforce_isolation)
>  		dev_warn(adev->dev, "userq scheduling already started!\n");
> +
>  	adev->userq_halt_for_enforce_isolation = false;
> +
>  	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
>  		uqm = queue->userq_mgr;
>  		mutex_lock(&uqm->userq_mutex);
> -			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
> -			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
> -			    (queue->xcp_id == idx)) {
> +		if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
> +		     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
> +		    (queue->xcp_id == idx)) {
>  			r = amdgpu_userq_restore_helper(queue);
>  			if (r)
>  				ret = r;
> -			}
> +		}
>  		mutex_unlock(&uqm->userq_mutex);
>  	}
>  

