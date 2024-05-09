Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA95C10F1A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 19:56:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F31A310F1E1;
	Thu,  9 May 2024 19:56:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HfJ32lme";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72A6510F1E1
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 19:56:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enJl/PkfpUScI33YDeiA4bLzSQVLqvHdxiX5gxbk6GQmtCOhVvRvoRC8jegvF3HHYgdUQ3VLnTmaQp2YgEUY3qmjLpM9AJn3e0ZreuS82dGxIK5BfIlQyCyFU0pyD9hAnUjz3thpOko6fJvKO66ZzJFKNcxo4oMKmMpsBFIZIgPBB61moV0FBYYIaLLTP6Ptm1szXofmSpUN1W4Cv2XFizYK3CbLc9rzRQCVeh7srLqnCPFDZDSt8bxOz1bTKwKIOvZp8u2RxB6nQF4kejLf6ny4ipoc8jzTaJUWkhiHtrgWsGy2VmYtPKtY7QBEbO3PrMZqQcsFc19C4bepK/1ZaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEiAvmbKOR5RXGrW3Bv5bL7IvoJvaXCQK61Pmbpzw5g=;
 b=ToGqwNfKEYvsjUjsBrtRxGibJeLSwV1NIqhQ6fdoyz6xaA1PT/Hy/+PZpQoaABU+v1Zv9aJI+rTbkaoOrfzzwUpZz3PCUs5npG8VPAW0pJqeWYv/YGgZzsPrFQuYQ2mYGeMjwBkUvPlenl1TT8JXggMru4nAhBeU6r5BT/MpYOVxJ4dmINeHHun2upmjlBowXUXw18ZYMj2PV4I55hhFN+mRBMGTL3yZiVZn4j8Qe9BlU/YGp/xXARSA7oys6H7YhNtOozvTpvAmWNnbWaDOq5UQwbQCWVxTOf9OTxvmBMEgNO+tYRRW6RQfmjPv3tq51OCgNseLmS9ob5cgbcoW2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEiAvmbKOR5RXGrW3Bv5bL7IvoJvaXCQK61Pmbpzw5g=;
 b=HfJ32lme+yt4j01UUW51+ud8hnY9+TtSgxh0nDZS/FEuPoeddkAOhKapVYVx7ZidDyek5PuzIONZ48uglk0UtKUni+ZN3eNHMUIKYPu6SXq+6Cp/akhBOxi552Ag/sqpb43RziLFHjdPU4PKdipig8wgM0AoXBXJB4w6kF9PRt4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB6691.namprd12.prod.outlook.com (2603:10b6:806:271::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Thu, 9 May
 2024 19:56:04 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 19:56:04 +0000
Message-ID: <fec72f93-4f8f-4d84-8d45-45c3273e6ece@amd.com>
Date: Thu, 9 May 2024 14:56:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/amd/amdgpu: Enable ISP in amdgpu_discovery
To: Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, mlimonci@amd.com, benjamin.chan@amd.com,
 king.li@amd.com, bin.du@amd.com
References: <20240509193531.129092-1-pratap.nirujogi@amd.com>
 <20240509193531.129092-4-pratap.nirujogi@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240509193531.129092-4-pratap.nirujogi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: 21f183ce-194c-48ce-5486-08dc70620ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXFSQVIySGFmelpSTU9oZGE0VUdtWlhXTnQzT1VveFNabE5VWFJnKzRwRGxN?=
 =?utf-8?B?ek5tekdMUzAybkhjYlIrS3BwamRmdmNtZkxCQmY1WTJtSThNeWQvRDJveTJa?=
 =?utf-8?B?TEMyWTM2SFNtUWpPKzJYQThNcmFQNjg1Z3RaR2l0ZjB4WlNyeWYyaXdjRm04?=
 =?utf-8?B?ZjJoWVcyOWQvMlFTbUdkQzhITnA4eUoyMksveWx0QVdnaDZ4UEc2dXBzZ2Jq?=
 =?utf-8?B?T2FCTm1pV1cxemVBeTdTMFVYbEJqemt3b2U5cVlpYi9wblRubnV4MDg1Nkh3?=
 =?utf-8?B?VlpRc2tBdE1Ld1Q1ZVpmelY1c0hrY0lXa1EvdUxxU0tIcUVob1hYWUtLRTBG?=
 =?utf-8?B?Q3cwTzIvUkw3OUU5emtZdFdIYWd6UVRERVc2anR3VEtUalc1TWtxQWc4ZHBV?=
 =?utf-8?B?TElhSHEwcmxxS0dyVUNERVlIaE42TjJ1RjZTdDVvMmNldzByTDNQc1ZVd21E?=
 =?utf-8?B?cWVSdVhtY1ZGbUhXTU1LWHltQ3JoSDF6UVV4WUxXVUdrdzVWcnJhR2N2U2s0?=
 =?utf-8?B?ZWNEMFU3WEIwenlNUWZPQlFZcWdiOWh5ejhrQmpwZ1psNXB6VkpxMGwwaXJU?=
 =?utf-8?B?bFBYcjQzOHk3U1d0dk11ZTFwM0tMNkUxZUFPdmJHVERCZTIvOWljZUhKQVBP?=
 =?utf-8?B?ckxKNmdLbzh3SGZCNGhoaDZtMFA4U3U2eUlqOUVBaXNURWtBOEJ3U0tZMkta?=
 =?utf-8?B?dkZSd3IxWU5xR0YyYjgwb0dLY05id1lRL0tIMS9oc1ZSa1JTL1I0d0dacDc2?=
 =?utf-8?B?L2lQem5tcVBuOFNTUFYrK3MveFZPckFsb1Iydm5CV21BUm10dmZvbTJFWWRH?=
 =?utf-8?B?cC9xTVZPSE9xeVdjT1JoUHF0SGo3SmQ1cUF0OFcwTFQycUlrQkkrRWxhczYv?=
 =?utf-8?B?N0IvR2tiLzlER2t2K1YyV21CNXgxUUNIaHJhbTFiU2Y3SjFHKzRoNW5HQVBx?=
 =?utf-8?B?UXRRL1BqeHkzTVRRUWk1QklaNWFHYm1OMitJSll3NCttbGdlbVJieEVTVDlq?=
 =?utf-8?B?eFl6YmYvUG5IVGNUa1JDS1ZMYkVhM0l6R2xyZ2owL1hGaCtnS2lXTUxqWGta?=
 =?utf-8?B?S3hvSm1SNFVTRlJrRGlRdDgvM3o5SGpzT1dTYmdoSkZraXlJMFJ5M3Irc2pm?=
 =?utf-8?B?WjQ1UWZsYjA2MlI3dkppWHpFVmpxSGtZam9LdGoxNU1EV0p4b25KQmpHckJn?=
 =?utf-8?B?clRUMGoya2Q3Nk9ORlNUQ2JkMmI1ZDBreE5mVE1qZnFXT1hURFF5ek94dCtB?=
 =?utf-8?B?UWJrZDFmOElFTEpMV3BldngvMlJ2d2lPeE5mOCtxMjJVYkFCcmxtek1HY2NN?=
 =?utf-8?B?c1UyK2MxTW5WdE9FcGl3alBmU1E2YStXa3h1ZEdRU1pidENoajROQmJicmhh?=
 =?utf-8?B?cG4xL2J5M2Jjb05zcmJYVDJzekR0Nm1namRZanMvYUpQZ2hqOWlxWC8zNXZK?=
 =?utf-8?B?dVE2eFdCYkFMdGJ6MUdrZEtFU1RMOWdrZ29TcW14R000Ykg1U1BQc3llbHZY?=
 =?utf-8?B?MWdKeTJyd3B3NGZiTDVXaTRlMmNTTWI2c2FEZDYvZGpzZnVyV1VFdncyQzRO?=
 =?utf-8?B?ZUFuUGhwdXhtZXFtMkJKeFR3RDRvVlVKN0FqdHQzdlZlYTFqSGhXU2J3RXhs?=
 =?utf-8?B?NVhmN0tNdzdiWjF6ZlJMK0tBSVh1Vm9PYTlZS3I2c3dCTWc3c2c0TE1CU1Va?=
 =?utf-8?B?WDE3WkhjTml6NCtxMUVGTEZXSGNHWEVUR2N1WVhkdWNhVW1aREo3aVJRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2NlKzRmRU4zb2xBU3hCd1ZmcGM1bEp2M01NalJDUFcwNGtFaVdFQStkK1d4?=
 =?utf-8?B?cW1palltSnRVNEI0TktiQkI0RGNyRUExNWU3U0orWE9iUUFpM0tpRHhrN2xV?=
 =?utf-8?B?Y0F2T2E4ekpzODUvQTBLdFZRRVZNKzhTR0pGSEgyTUZKbHpBSU1ISVVRZ1h5?=
 =?utf-8?B?S1hMYXNpMnZyMmFKZjA2ZTRvZWR3T0wvNjB1ei9ubXA2RTV4WEU1L3luMEdo?=
 =?utf-8?B?bzhCaTljekxPcXhURGRSTDQzZHQ3Kzk3RHVWWDVmZUJGaHZzRHlIMSs3eFZT?=
 =?utf-8?B?Q0dNRTJsSU9lQmdZUXdZSkhhTGNmY3IzVjZXa21MZEhjZEcwYlJsay9raGV3?=
 =?utf-8?B?d1orYUZ4ODRBK1Y5Vm8rWkp5NENYb3dJd1ZWVG95bGVjWnFWTXBhSW9SRDlX?=
 =?utf-8?B?QmdxUmtZaWVaTjVoOUxrU1YxZ2ZOZkRXanZKUXkzSDY4UHptcVhiMVhFdjUr?=
 =?utf-8?B?bFRNaXJId21aSXFacVZBZnBLOGlvTmg4YzJRcGZ6TCtGM0tURXBJZnVENjNx?=
 =?utf-8?B?ZnlPSmNSQWVieHpTcVYrdVIwc0FqY0poNzV5SUN3T3NHL3JiTzVJcmROY0tJ?=
 =?utf-8?B?blB4dXpKSSszSzg2VTY1S2RlWjl0RU42cDg0MVF6amRIUWEwUGQwSDBXQWZY?=
 =?utf-8?B?SFQzSmgvK2lXdkU1bUFKZVFjdnRTOHBEWnJMaXYvYUlyTTVzaG96ekNPNEE0?=
 =?utf-8?B?SXQ1WlVteGxHWlFHOHl0ZzJGRFJPUVRKT2Z0bDUwU28rMmhKSDI2ak90dE04?=
 =?utf-8?B?a3FneHl6VXRnVW1udUNITXF3c3ZMeXRodjV3WGdlREVnVFdBYzFscFVOYWx2?=
 =?utf-8?B?QnUrVzdxc2ZURU51ejRNRkEvdjBDSVYwbG5FMlU0djRxRGJrQmkwemFQRlBD?=
 =?utf-8?B?V1pZNk02WXdrWUdGbXFHSmdvVW10Qi9ZZkM3RDNVaFNRQi80dnFiQjJGWHFn?=
 =?utf-8?B?S0JMczZ3K2NyK2JGZkFyeTM5YkQyamhsQytaMnhDMGo4c1BpcDRsMG43UU0r?=
 =?utf-8?B?WnZ4WHhWU0ZNQ3BrUGxMcjB5YlFndWdJencrUENkMzBzRis3VVlXTkQ1TFZD?=
 =?utf-8?B?THoxZGhYTjROc1lMQ0pGK1MvYllFYXlJeUpoWlovc3VldkNhS1c2QkJXVGtC?=
 =?utf-8?B?c1BCQjg2QXR2S21xa1p6TTBKanV3MzVOc2tTbkg4ZEpZQWJsL09wZ1p2cEk4?=
 =?utf-8?B?VFdTbGxXV0xMcEVDekdjN0k0Q3Z6UVM5UUtqcXpXQjUrbXRmQ05XRUVHemZm?=
 =?utf-8?B?MXdrV3h4bFNWZHErd2gzOGNLeWdWVjhKZjJDY0ljZzhiMU1rYUFRRThVSGp6?=
 =?utf-8?B?ZzYyZ1d4emFrdVM4VFpzbmNpMUNldnNzUUxJS3UwWExWOXNmVkZKSlJmUURQ?=
 =?utf-8?B?c1Eyc1JsbmV1bTdPZEw3dG1oSVNIOG9lWDJTc2dMZXlUVi9IS1RiRUcya0NU?=
 =?utf-8?B?Tm9HZGRjeUlOZHlIT3MwU3NCZ3J6ZGl5MHYxVmJyZDE1bmY4ZFRrWG1sYXp3?=
 =?utf-8?B?MXlEZldnYzF0MUF3UmxMTCt3UVY5akI5ZTdsRS84Nm8zdWVRNWtVS0FKRURY?=
 =?utf-8?B?a1NTRGt6aTBVR2dQYXpxWDZtVFNQWHJYK203eUpSYWhEZTdXUC91RWw4dDhx?=
 =?utf-8?B?cUZIS0d4UGxLWFA0dnVYUWVCYnJiaUNLRytLdUN3V3g0bThrc0k1ajY5LzhG?=
 =?utf-8?B?OWRpSzBpaXZWcjNoN3J2aTExN0FZSTZEMitUeXdTS2tXWWN4OHE5Q1FVVTBN?=
 =?utf-8?B?OUh6WGNEd3hua3puM1VPQVVmOVYvRGJzUC9EK1JNaW5rL2FZdFd3Q0VoS1FO?=
 =?utf-8?B?cHkvSStadHdZVkd1MFJXQS9QdEtlSTZCMVN4cC9jQ1NxZ2ltKzRGSUpUaCsv?=
 =?utf-8?B?d1VhV1hZOXV3WGR1MmRBTjNXZDlJMG1qWHJhOWRYSHo0ejRmZlU1QXZTS29H?=
 =?utf-8?B?b1hYd3RhaDJNSUNOeEgzWE00aHV1UWFoQ3ZtNHh1QU9sMUJqQ2pVNTlFT2pp?=
 =?utf-8?B?Z2E2K3RDbXY4VGRoOWtKVjYwK1RNL3ludGhjdWFhR0Q4MUVMSkwxTnQ1RUdW?=
 =?utf-8?B?UHlabDBGWlFUUlkwRmV6Z09SVitxWU52SGVGaWZweExSZlU1OFdNYmpDT24r?=
 =?utf-8?Q?skKuZ78hUFo0nDWMqMFDMqUnD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f183ce-194c-48ce-5486-08dc70620ef6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 19:56:04.1168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nM2geqLpljFJDxeg9jKHsfLwzR3RY8r1ZsndonmZbQJU2H9nNwIMJXcv7Zcvt5h9DQQz5bU48xtOwoZH2INg0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6691
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

On 5/9/2024 14:35, Pratap Nirujogi wrote:
> Enable ISP for ISP V4.1.0 and V4.1.1 in amdgpu_discovery.
> 
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 22 +++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 6586feab8c2c..82d064adaa49 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -107,6 +107,7 @@
>   #include "jpeg_v5_0_0.h"
>   
>   #include "amdgpu_vpe.h"
> +#include "amdgpu_isp.h"
>   
>   #define FIRMWARE_IP_DISCOVERY "amdgpu/ip_discovery.bin"
>   MODULE_FIRMWARE(FIRMWARE_IP_DISCOVERY);
> @@ -682,6 +683,10 @@ static void amdgpu_discovery_read_from_harvest_table(struct amdgpu_device *adev,
>   			adev->sdma.sdma_mask &=
>   				~(1U << harvest_info->list[i].number_instance);
>   			break;
> +		case ISP_HWID:
> +			adev->isp.harvest_config |=
> +				~(1U << harvest_info->list[i].number_instance);
> +			break;
>   		default:
>   			break;
>   		}
> @@ -2303,6 +2308,20 @@ static int amdgpu_discovery_set_umsch_mm_ip_blocks(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> +static int amdgpu_discovery_set_isp_ip_blocks(struct amdgpu_device *adev)
> +{
> +	switch (amdgpu_ip_version(adev, ISP_HWIP, 0)) {
> +	case IP_VERSION(4, 1, 0):
> +	case IP_VERSION(4, 1, 1):
> +		amdgpu_device_ip_block_add(adev, &isp_ip_block);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
>   int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   {
>   	int r;
> @@ -2829,6 +2848,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   	if (r)
>   		return r;
>   
> +	r = amdgpu_discovery_set_isp_ip_blocks(adev);
> +	if (r)
> +		return r;
>   	return 0;
>   }
>   

