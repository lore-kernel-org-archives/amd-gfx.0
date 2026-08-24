Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC7EC5DF94
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 07:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56D7210E36E;
	Mon, 24 Aug 2026 07:39:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OwV56bb+";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BCE810E36E
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 07:39:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHOwcF7j3iIVDpq6jA8OO0W574X6U18JbhrmHVD1zcED9jsUh3M1Y2lCd8w+vtfvRY/+wCX1g3fP2g5BN1s7P6r5oz4bNL380ZeNK2BbP4B4AKigdicv9TqUrDF6LUYDQ0gIUFIEvibAD4DhqejiB9wuBuOpdmfFvdwHfymPVboEJvN6oRpPNFAqADf3NPG3dAlDdEzzXos1DDr6mFK3dZFdZtqZQnkpfMdcpTSodLggKcHJZ3pQ7jpckQJBci7nUHWl8m+XTQOICCww204IwvIi3k9hWBsy5UriSrmm8Zizl10hTUdMIKys9POWWRrPZkf0d+nfos20qG39tlVGTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+y6xFVtf3ncs01OuhZZozd7z98Qw6yK5a3YjFX/ypc=;
 b=b8Cs1L06dz4E7oqUbnI9am+CPQ5XyFSsoNJIKYMsPXuvQaJTiR7V7Qy/YFGQYS9/W4pvQ6geHlpbv4bPqe2YHPRS5RHU/hg3g1xYtM00JqXpiHEukk57XMMSYQb4qm74GtC1XCGHRVLnUN72ft01Wo/0/5CjxH+X/QEdFfiKZStWrIN4u+aDf9Uw0xG//U8hWd02xznzW7o7mOGi31LI3dtG+NuGCE2k9htp+VAnp3f2lprX9HxrCeFrWjV89R6omKoaVEi1rx+NjZju1jTpKeqHyX+U76gKy2x+9aHM6y10IBngB53qUEYdXjpgfjj1B5q82vQQyuA+R2bxqDe3NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+y6xFVtf3ncs01OuhZZozd7z98Qw6yK5a3YjFX/ypc=;
 b=OwV56bb+DuAjaQzMHT9Htg+fwV/zTptsPQPWBRT7r3t52jwrHE9014yBg0sqJ3MwcCOWDaDST1zNwjqEo+TPVawWiWMHgNvJ5t45L9/gvKs0UzrAjXwAeBW7Y0diLx2k440D2AhRJ8O+dC9ce1uK/ae7O2IPhzh6zhUAr7HPdWY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7140.namprd12.prod.outlook.com (2603:10b6:510:200::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 07:39:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Mon, 24 Aug 2026
 07:39:26 +0000
Message-ID: <39ce25a7-c20b-4513-9ac1-3b636e3af6a5@amd.com>
Date: Mon, 24 Aug 2026 09:39:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queue
 unmap
To: Priya Hosur <Priya.Hosur@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Sunil.Khatri@amd.com, Felix.Kuehling@amd.com,
 Shaoyun.Liu@amd.com, Lijo.Lazar@amd.com, Mario.Limonciello@amd.com
Cc: Pratik.Vishwakarma@amd.com, Veerabadhran.Gopalakrishnan@amd.com
References: <20260814161841.5906-1-Priya.Hosur@amd.com>
 <20260814161841.5906-3-Priya.Hosur@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260814161841.5906-3-Priya.Hosur@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: 35b6f9b3-6206-4eea-45dc-08df01b2d2c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|10067099003|22082099003|4143699003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: XGUBQmZ6pPicg9w9eaZg18CRk8H21uE+3GQilygMRMAjkXRXLLWHO5OSagO5IFIBzzlzdpc/RXNPFAGSeUxQiQSdJH4BftJSczH8jfbGH5YiyHh2JeAuXkp3z0tQt4MOisRDN71MWM+D54qGjWu5Yvvz+IXTBig5rT0IfVRFlqI0XeExqqrQTUQIqkX5VT3HU/3TY+1er7m/I7p07a3TcCOwr28stwMxlGJaPmZMeUOwqYwcDS8rOxtFRoUuOrsMh+BPD0RpSnNOhfNv6k5+UyLnMK/yRJOtsVQFevR1rRPJG8dPMk3L4EWyC2Hr21Hxn9fGn0+2Oy45JN1flzaFf/LWeSmWZiG+cM7XY6nwy2plFpA+f+F0lIWygGfC9LKwCS8SIVFljvsDv6hUA7nad2DHVV8BeKS0p0VQEerpKgKnuMdCittDNBkMgK7DlWBUifktKh38TA2jKT7k8WZiQjVv5L3EUMUFjT0Si3Ua7ldmIxwttNnAB5U92j7Zmwe2P7z87Le0drfausyIcMxuo+OQtoTgpX20lkm5S9/tVd7Py2gmfzEZ98M95p/PDW4Ad+JaCQMEOOSzgSVHDQWrXe7k3Gpa+puXfP9qNaqM4+6flYI06lUN9gWjkj7aQu7cpiVVabk5L1jefGgAAEwlZR9jqhuuCmNQj3MWsQl+9A4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(22082099003)(4143699003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1orOHJoQ1RmdlpVMmRUNCtIcldneGJTdU5OVHBYS3ZLNjVoZE9oNnU2WGU5?=
 =?utf-8?B?bnBQbmdJdVFhaVNybkx4NGJtSi84VEpuTTV2VFN3NmczTko3L0cxZkEzRGgw?=
 =?utf-8?B?ckp6L2hpK0JhMHdicGFPRWNLVXMzMFQvRHRqcDQ0VzA3dGNvbkVXY2EwWWZF?=
 =?utf-8?B?UkpuSnJ5aUlVOFh4OUdFc2VoVzZVWWJMeGc2cEtwQkhtQzh0YWpwekxZUTE3?=
 =?utf-8?B?a2xuSkprSjN5RUFTVHMzYXMyczJJVkJyaUhvS0ttemFaTjBsVzhSY2I3T3VT?=
 =?utf-8?B?c3FFemJYaDRHOXdoMm0weVdmZkVLVjQvRkNUWFQ2ZWVRaG9icDdVU2FUclhC?=
 =?utf-8?B?L3N2Q2xSd1E4OThza1pSaUsyWCtMZ0JpQkFPMUZ4bzBPR3IxZmZpYzdNalVO?=
 =?utf-8?B?U3R5NWxRSktrVURqditnbXVieDJBdGdVcDV4V0JvU2p6QkljUm02UDBVVW1C?=
 =?utf-8?B?VUhLMW8zOWZ1OTVTNDlSeXFMcmFsSXY3MHB4bjdlNFAzbGRySVhMYTNzdWg2?=
 =?utf-8?B?WXMxbWpuUkNwS2h5elJSMGVHSElFK1hZVTdrSXZpMEF6dzI2cy92RGlaYXk2?=
 =?utf-8?B?WGdyazUrSEhYVGtpV0ZWNUVnc3JLQVk0dHd2Y0FETzF3YytvMy82TWMzRmZD?=
 =?utf-8?B?MHBwOExyVXVCcWZoQzRLRjVLdytaL2JsNXFINktNWDJDUUdEK01za290dnp5?=
 =?utf-8?B?WEY2L2prbHdLRFFuaW50MEVsbXhjbEJrTXQyYXd0R3kxUlNsbWNmZXdiYTFN?=
 =?utf-8?B?WWc1Z0xyenZxT0dJSTQrcXNQZEM0c3htZ25rWUlFTjM5bjBuQnZ0eWFnQmRF?=
 =?utf-8?B?aFEvYjczcUg4ay9pdmpQUnlaR0JvR0xiZTg2MWV0L082c3FSaXEyU29MUnhn?=
 =?utf-8?B?OG5sbWhxKzBoY1lIRytpd3hqM1ljTXovaVZBOHB2am9GVk9FQW5nem42dUJ4?=
 =?utf-8?B?Ny8wMFBtRHkwRnZiZU5Ed1NONklrMDVvWEZ2aG9HU21rWkNIY2puM1MrYWIw?=
 =?utf-8?B?bGlkOEVZT1p4b2lOSDlXTlNIeFhMNzVoc3pob1pDVjJHWDE3K1RUV20zMGRZ?=
 =?utf-8?B?SHB4VEUvcSt1RVdSODE3WUdSNHZTenlSb0wwRk5wSVo4L0ZOODcyTUkwZWll?=
 =?utf-8?B?SGF1dnhHd2o1MnZrSVZacnJwS21qM2NuZlhmcHd6cUVYUmcvQWZmYUVqem5w?=
 =?utf-8?B?K1dzd0tkeDdOWTVOT0U3Q2ZCb05yVHV2R1dRY2wrd3VDODUxOHVTWUN2K0NZ?=
 =?utf-8?B?ZFZtRHdZVWt4SmU4OTVUVklNaklhSHRyTnpTcUNoYXRJajhvVnBTSzV2R3M1?=
 =?utf-8?B?VHQ2bnd0b2hVNWMwd25DYXlDUytyVDl2eTRQZ2sxWmRTU2NTRWJzQ3R5aElM?=
 =?utf-8?B?ZFdaU3haOEZpR1REM0JJRUc2TWJtSldkK01LMnFPRVJxcjZnaG5kb3dVU2pz?=
 =?utf-8?B?dlM3bXRjcXRJU0ovVW11b05qUE5aSDFJSHAvZkJKVERQWVlLcFh3ak9zY01h?=
 =?utf-8?B?OVJaYlVYK3duRTdLS0psYjlzQ3A3N0ZyN2VRNGY4d0xmY3ljb2c5alhNTGpi?=
 =?utf-8?B?VTBVcHlXQ1hYMERpVGpVWXY0RGdpRVZ4UTJvOHZFYnowdE01VFhkejQwRGgw?=
 =?utf-8?B?K3NZYXdyYmF4bGN3VFY0ZE5NM3pxbUJnLzFaTUZINGJtY1pab2R0YUg4RUNL?=
 =?utf-8?B?WWp4NXN1cXRKc2I2M0NYdTRIaC9Ta2lwYTA1d0d0LzlqblhFMmJ0Qjc5eHhJ?=
 =?utf-8?B?VHc1YWdCdE5BRXVoZVIxUnFvWHlxa3pxM25mdDlGcTljSzNaTXVndzNUdXRB?=
 =?utf-8?B?d0RtQ3VYK1VIVGsrRkIrSWQwcnRHV3dBV29jc2tyVUtmYTUyL0IyaUNWWWU4?=
 =?utf-8?B?REpXZ2FaSXB6MEJRRTJWd3Vnc2MxTjhSR1I2OFp4YWhHUUVNNG14N1JSMUdM?=
 =?utf-8?B?bXBrUWd3amxCemE0dlNOM1FSemlkOEFGTHRIU3BybmlpKzBZcEVyR2t3dU5P?=
 =?utf-8?B?ODdELzZuUHA5RGhsMFRCL2FwemFIRmRJR3dLUWlRTlIxeXlpazhJRHJ5VUg1?=
 =?utf-8?B?QU9LRE40Z2FJOTNFVGZlV3N4dmVpMndObEFWSDd3Wm5QMitLemlLVVdhL01L?=
 =?utf-8?B?ZGJHTnIyaVY3VkFtYmFvbUxoUjhYd0l6RU11VXBwckdDRDdPQTh2cHhScnM0?=
 =?utf-8?B?RjZBa0hES0RSbHZaa1hmME1BdUxVSWd5U2E4NldVN2o1T1ViTE1PUHFjK0Vv?=
 =?utf-8?B?elpYbjBqcXFxMjkrRGI3aHlKZ0RRVnEycmtoTFBqcjhUWkZTODZLZURVZ0NU?=
 =?utf-8?Q?pdWhVBwhIxhAKWAzLu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b6f9b3-6206-4eea-45dc-08df01b2d2c2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 07:39:26.5127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OcV0HhltCZkSy3wS/u7GguR+vtBx5xC0DBRQjjHWreaGN7cT8Vu0fuda2k3WTkLw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7140
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

On 8/14/26 18:18, Priya Hosur wrote:
> Similar to the KFD fix, MES does not perform heavy-weight TLB
> invalidation after unmapping user queues. Add
> amdgpu_gmc_flush_gpu_tlb_pasid() after MES unmap succeeds in
> amdgpu_userq_unmap_helper() to ensure in-flight memory accesses
> complete before memory is freed or migrated.
> 
> Change-Id: I94fe2c84547723b6b73816ce8d727a54bd773a6a
> Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 6d3ed55e9ab4..9fcf15d69b7b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -375,6 +375,12 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
>  		} else {
>  			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_UNMAPPED);
>  			queue->state = AMDGPU_USERQ_STATE_UNMAPPED;
> +			/*
> +			 * Heavy-weight TLB flush after MES unmaps queue to ensure
> +			 * in-flight memory accesses complete before memory is freed/migrated.
> +			 * MES does not do this automatically unlike HWS.
> +			 */
> +			amdgpu_gmc_flush_gpu_tlb_pasid(adev, queue->vm->pasid, 2, true, 0);

Absolutely clear NAK to this.

The MES *must* guarantee that in flight memory accesses are completed before it unmaps the queue or otherwise we run into massive problems.

Flushing out any VM changes by invalidating the TLB doesn't change anything on that.

Regards,
Christian.

>  		}
>  	}
>  

