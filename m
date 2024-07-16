Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F40FC3DA59
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jul 2024 08:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30B9410E5B2;
	Tue, 16 Jul 2024 08:08:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="demmCncl";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4337F10E5B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jul 2024 08:08:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2pyzOuaARAyYqlWAlOwE8J9OgXNPzq2gijedTmgO8noMPT6vcc9y7Z3WiRbx4YJDvt4WDm1Er1+qc+76qIHTAwEiVXMbG7xsSeTCKbwKmb+6HYNVw+qKABhs23LU+EgMKLpZ2yakiNi5xkqCMCo5WgPj1kiHpWBIrSw9cWexaTvvWa5IRnOjyh5X+96hjY6ItdYQwB53z0cWloAgAIFVtHJvQpqskC5deIPy9zSNAgNU1Zbqs9gL1w6K+eSHYMHPvCy0rWQOh7Pt3trzPdasbmLu1UcG4jJ8J2BO4gsY0mWCqEhE6WpnWMfz+fiaZq7XouOBn0gZT5knDLynIqB2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJD5L6L0kk0ftsp2uw/y54AYDV+EgGpRGeKgwyMQe4I=;
 b=PxHxkaN2JMv01zx9ThxJzgMY04cWXVLsNeIQbAQp2I7csffD7FWelBKOQPY6414iNxwmsI7mcOyn33V/sUe/qWxzDCw1VvJTr2X7MfyLEabfSS7cINFc0gGXT0PDi+xYNTmRQzmxeArDbddtTAzTSU7JV1XgxHRP5eChOYFc1tz8l8i5CDxc/9xmPQty0QbYwDB/mB/assVs6AEuTM7W1b3kbIYyf2WLsPd05m/DozkOOusPdm5J9EaarqZtUvz9pNupYDAjIvYNXUS7JMZrxpf1E+uSA1qk0wqqwcI8E/IWru1cDW/uyn0rQYPxNlhRT+hUuPzgye+NY4hDhu7y5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJD5L6L0kk0ftsp2uw/y54AYDV+EgGpRGeKgwyMQe4I=;
 b=demmCnclpGzMlp7naD4y8r7JJ8Yawr/V3DLpxMlgBQvSVZsJbM4Taq8l8V6LK7TzC2IBwn/8bpktEFkOoHUiIJeY2t8F7XSDnpFzw6Dn5TbwhSAHHqENeTO+HdMcJPOcJf2lFP6Deo9w+MHwev5dHZcHoWAOz8RJgW+Hin2YwW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MW5PR12MB5651.namprd12.prod.outlook.com (2603:10b6:303:19f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 08:08:03 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 08:08:02 +0000
Message-ID: <24d6f583-e1d7-4812-b8c2-dd192a447c0c@amd.com>
Date: Tue, 16 Jul 2024 13:37:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu/vcn: Use offsets local to VCN/JPEG in VF
To: Jane Jian <Jane.Jian@amd.com>, Haijun.Chang@amd.com, Victor.Zhao@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20240716075912.193722-1-Jane.Jian@amd.com>
 <20240716075912.193722-3-Jane.Jian@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240716075912.193722-3-Jane.Jian@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MW5PR12MB5651:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f6779b-b9ae-4975-7c7d-08dca56e6a26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDhOeUdYSVV1TGFDejcrdFBQTk5tWkphWmZIbjJDSlhmcGpsZHpMS3JPMklF?=
 =?utf-8?B?TDdYU2dxdW9lb1NSRnlmMXM3aUU1WWJZTDE3SStvaHB0NkV5TGsxS3V3TXBF?=
 =?utf-8?B?R3lBajhDY21rK2NWQWp4WUM1VTlkbWtRQlBjVXBETGdZTFZyS3dneDBsZnRo?=
 =?utf-8?B?cHdVWEVzcWU0RklIUVNrQ2ZYUnp5RllsSzFicUllUHUwTzA2dVRFZXVWNmtP?=
 =?utf-8?B?WlJDVGtwY21TQ0ppVmVZYmM0WS9HZDJuYUpIazFaY2RubGpRWXBFelBwS1lI?=
 =?utf-8?B?NWd6R3pqQ2kzcU5vbTBBdU5IRU1lUFAwSFB1TXVyaHlwK1hDRHhSSEQ1dzVp?=
 =?utf-8?B?eHlUV051QnZhNkZydklQYmNCVkZQbEFzVk91Z3psUml2TU9JUTdtVEY1bnda?=
 =?utf-8?B?cWFwSmNmeGpIYVBlamNyQjVGTjhJR0tXUmJTWExlWGlRd0h0UHR3ekxQYzZG?=
 =?utf-8?B?Zy9GNFZpeEUrKzF3a0xlK1pNLzNGWkVXNTlSQkkwdmNOV0oyMzRDUmNodUZh?=
 =?utf-8?B?cGIwYkFXU2RDUUdCWWdGeVRGc1paODA5TC9hNmQrSFFFWUxodjA2Nm9Lc2dr?=
 =?utf-8?B?cksrQnpTSkdlRTZ1Q09wNnZ1Sm5BNUZrVjZCUWxIemJGbXBwK0d0SkEyUUhC?=
 =?utf-8?B?OFhvbDVNbWlTeU5kMTBhWEtaQ3Z4TVhjUXJuc3lvSW1tb3F4RHlkbDF1YlUx?=
 =?utf-8?B?a0JTR0xXSDBtUGRMeW1hZXlWalZEVFJ5NTZJVTEweTdlOXlRU1ptYjRXdW91?=
 =?utf-8?B?TXpGaG1VSEtzSGpQVjdZUjVQMWNaNDUyM0NUajVGRzQzTEpvODlvTm1aY21T?=
 =?utf-8?B?MWNISFdvekQvcVArUmJIbll1ak1xK2VsMFRRQ1pxNkNWYUh1eFJSWE1Lc21K?=
 =?utf-8?B?MURsc1FDZWRGbjZvRUxMVWF2Y2FVaXR1QUszRGVBUzBMNVRHRXA1TUorZ3Zt?=
 =?utf-8?B?OTg5SG5Ya3VPUEs5VEUweGdMdmU0MFFIcXB6d2p2ckQveDcwM0kydkpPbzNY?=
 =?utf-8?B?eHdtemZJRktwTkFncmZrcndiaUh1WUN1ZitpOXVDcXovSW1BWnRjcnNsZTND?=
 =?utf-8?B?OEZlMVlmMTRxL0xFdjFudlZNTSszaWc4Ym1mTG43aTFtek41bWN2ZkpOV0h2?=
 =?utf-8?B?M0wxRnRCWDNZRTB4WThiMmRIczBZU0d2V1lnd1NjbEIxaWFsRWdnaG1nWE1I?=
 =?utf-8?B?OGV6OHdLL0NzaWpUb0hUT2FxNVFpdTVlQWNvZ1RETXJLM0d2V09iTEphTmNV?=
 =?utf-8?B?SVNwSUQyOHk4L2duQnUzTTFMK2NCSWM1aU5GZWhUNm4raVFYSm42d2puK2RC?=
 =?utf-8?B?eThSWFhXOFlxM29aRWFMQkphQVdNMjI3RllzcjZ6U1hHRW14YjlQUkVReG50?=
 =?utf-8?B?VzU0ZmwzMzZrWS8zNGxyaGRHY2p6M0VGRTFMT3V1WHEvZmlOSEMrSWh6WFVm?=
 =?utf-8?B?ZEluZlJBR2Z3ajRUUnFFSzZyYytRZG9lSkJmSXkrV2NkWlo2RzF1WlV0cGFJ?=
 =?utf-8?B?YzluOVNqUHBMb1FtN2NrR3VtTis1UTRmOUltRkJJVGdKdTBheDR5akJ1ZkF5?=
 =?utf-8?B?SjJsNXlhOThmMlBHNWtCekFiWk80dnI4TW9Wc25ocDNPaDNGQkpycitrZDgx?=
 =?utf-8?B?SFlwN0xVcnlTaUJYUHd4YkIvMUpRM0xwVnFVZytETWVPNmF3bE5oTlFuYjV2?=
 =?utf-8?B?ZW0yK2dZNHlaY1RXVUdxM2hQZVlpL3FWbEtnbjRyV2pWeXBCZk52SGdHRVNP?=
 =?utf-8?B?RjVlNjJaNzV3Y0hFUGZmL2ZYY1NRb1RCN3BrOGtHMVNRNVVYM3BPa3RiWWZ3?=
 =?utf-8?B?N05xRkFpWUFKSjhUOXNrUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVQ3OHN1M0h6ZmZOenNyMUtFNHdUTGo4d3FEM2ZPSzUxdVhaTkw2MnVuWDhB?=
 =?utf-8?B?NmJ2R2JYcE1YN2VwUDIxbzFIanVBMWtxK3dDNWVPKzNGeEdvTHFCWlRadUhP?=
 =?utf-8?B?ODBUanh4UUZ2NWtGcEl2cmcrS0dMYW9LV2ZIems2Y2FjM0xlRkQvMGxTNUda?=
 =?utf-8?B?QXVYaHZ1c2hMem5SRHF3VXN2UWUwN24xVzJKL25GN3NFU1g5ZUZtMHVPR2pS?=
 =?utf-8?B?K1ovUmhDVTVyelJSb0tYZ2EzSzNmRHZLaVA4blM1M2tDM0Y3QkxFYjZOamp1?=
 =?utf-8?B?ZHpub1NQUFhQVXJPQ09Id3hiekwwYUw2WFhYdkxXQnFVTEVySUVEV294YkJE?=
 =?utf-8?B?WWFhTkREZkNLVFE4OGozMEg4bGxiZG1mdlN6Sm9vMlRQMEFNSXdtdlB1N1dV?=
 =?utf-8?B?ZXRvK0NBN1BMQWdvcjhsVERJcHhOTVpSSnQrWDc5RzhReWJSalQvb0pUSkNv?=
 =?utf-8?B?SENuZFNnNUpWdXJ3eDluRWhVMU9xRnZ3NzBYa2JLMzF0ZDU5a1MyU21uQ1dC?=
 =?utf-8?B?bC83alhMWFlBVUJKVDRtY1lnRFBqc2ZzUE9YdTJTc3AvWFpGYVR2c1VUWlpV?=
 =?utf-8?B?Q2NyQjdRYlFuelpxajBLWGgzU2IwZmFyNDJWQnFJend4VHlxT2lzZm5Kb1Jy?=
 =?utf-8?B?M1BMS3NvTVVTR0pJbHlxR2VsQVFyVC9OZ3pHRFo5TDQrK01MUlVJbSsyVlZO?=
 =?utf-8?B?eC9Mb0RCV0xkQ0JGSERnTHdVV2pyck53QnkrTlJReHJVaFo0SFBFUmNDUWhF?=
 =?utf-8?B?eWN5ZmR5NlVJdENFUWpXRFdNZTkweW10SnF6S200SnRnT0VZVVhhc1lqWlJD?=
 =?utf-8?B?dGF2M0RJbngwa2hPWUxEeWU3dTNFemZtcTFFb1Y4QzI3RXQyWjFFVnk1cU9i?=
 =?utf-8?B?Smk5WU9sWEl6dGxWdmgrazFBV2cyVXBoU0JqOE8rTitiQ2R3VU9tdm4wdzBX?=
 =?utf-8?B?dW1meDNuWCtHNzIzc0s2T3VHNk0yYVVjNkxwZi9IbVZhOGNCTlZ4VE9oaTli?=
 =?utf-8?B?QnZnNVFBbzdCZkFUeXFrUlVoNFZXSUVzTFh2SHpwT3ZicEp5bnNybnpubUdu?=
 =?utf-8?B?UG5QZjVqdDRqaHFxWGVlWGRwVHdWYzlPNzlwMUcrM2JDclBmaHQyS3oyd091?=
 =?utf-8?B?TGhXOFQ0dWFNRFJwbnBBTUpXSmJnSzJhSEF5MDB6b2F1aC9mNFF1UUpXTlVD?=
 =?utf-8?B?QkwrNmtFL0VONVJMLzZMbWdmKzhYcmx4QVdtcThyN0xMd040Rzkra012WmJV?=
 =?utf-8?B?alQxREQ0dkdMZkhNSWQ1Zk9zNEl2WkRyaU5jZzJSSC9aUE5ZVTZPTTZYRUpT?=
 =?utf-8?B?akhEeGxxT1dBMjhrZGdRbnpteWg5b01uY2M2QkZ6YVhqdTB5djAwRENVV055?=
 =?utf-8?B?a3JvcVE3clZYNEVEemNCWVJFanNTTmRDSkVxVmZjbVNEbzJaSUhKNER0VUd3?=
 =?utf-8?B?NzR4NzZkNE5nQ1NKNm9ubXdrNUJpVkJvOWpNRVo4emxrblJ6bHJTZStnWGxL?=
 =?utf-8?B?NXVlTEZaNjFhY2RENTJMc295dmN6Y3RvSm1INTNVMCtzNEMwTFVVczVxbTJo?=
 =?utf-8?B?eTJQS0xjQmpYNldnejFsdjE4MkJiQVdDZVdCdlFJZllISk16SysxUHo1UVFU?=
 =?utf-8?B?SUxwRDZXV1lCSkN3VDRvOG85NVFPdGFGTDMzaldvVURTc0k2UFM0TTErdDBZ?=
 =?utf-8?B?SjQyQ0xVUmdqMFZoLzd5UFc5d2xuRVc2SVNsMEJqK3NjZ1FGaUE2TVVudkNL?=
 =?utf-8?B?VXk0cEZzd2pKZzJ4eEtRM3hKYkw2R0dDSXhoQ2VUQUN0SEZQN1lNYWxtUWQ1?=
 =?utf-8?B?aHBzN056KzlZSEZwQkxYN0FnVmRDcytLSVJrcm1Jb3p3RzNmZWp1RnZEU1Nn?=
 =?utf-8?B?SmVyUkQ1eUs5akNOWFVUWDBGTHJ3eXlYRU5HckpXTGFrM0hsRzRWTmE3Y3Yw?=
 =?utf-8?B?VVlGQ1NwVXVMZlM0SThGc0U4bUM3WVRCVXRQaVNrUSsxWkxTZ1ZnWWUvTWdr?=
 =?utf-8?B?eThGc05ZWjR4ZXllMi9rcXZETjNpV0VFemttVDBVOXpINFZWYWVBZy9QekIy?=
 =?utf-8?B?OEhtSDh6bXYvZFRxUSttV0pRZVp1MnNtL2JKbnhsSTV5MEt6cjl4dXBvNGhK?=
 =?utf-8?Q?2SmtnRIiiPCnhUT4sAgiodw0H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f6779b-b9ae-4975-7c7d-08dca56e6a26
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 08:08:02.9041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CietcUbkt8BgmSvGusKm9GSp0KdGjzypJcXnDraREtpbGjKLvBdW5Dl1l+ltV5Gp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5651
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



On 7/16/2024 1:29 PM, Jane Jian wrote:
> For VCN/JPEG 4.0.3, use only the local addressing scheme.
> 
> - Mask bit higher than AID0 range
> - Remove gmc v9 mmhub vmid replacement, since the bit will be masked later in register write/wait
> 
> Signed-off-by: Jane Jian <Jane.Jian@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    |  5 ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 19 ++++++++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 46 ++++++++++++++++++++++--
>  3 files changed, 60 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index b73136d390cc..2c7b4002ed72 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -844,11 +844,6 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>  	req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
>  	ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
>  
> -	if (vmhub >= AMDGPU_MMHUB0(0))
> -		inst = 0;
> -	else
> -		inst = vmhub;
> -

This doesn't look correct. This is also used to identify the KIQ to be
used to perform flush operation and it goes through master XCC in case
of MMHUB.

Thanks,
Lijo

>  	/* This is necessary for SRIOV as well as for GFXOFF to function
>  	 * properly under bare metal
>  	 */
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 30a143ab592d..ad524ddc9760 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -32,6 +32,9 @@
>  #include "vcn/vcn_4_0_3_sh_mask.h"
>  #include "ivsrcid/vcn/irqsrcs_vcn_4_0.h"
>  
> +#define NORMALIZE_JPEG_REG_OFFSET(offset) \
> +		(offset & 0x1FFFF)
> +
>  enum jpeg_engin_status {
>  	UVD_PGFSM_STATUS__UVDJ_PWR_ON  = 0,
>  	UVD_PGFSM_STATUS__UVDJ_PWR_OFF = 2,
> @@ -824,7 +827,13 @@ void jpeg_v4_0_3_dec_ring_emit_ib(struct amdgpu_ring *ring,
>  void jpeg_v4_0_3_dec_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
>  				uint32_t val, uint32_t mask)
>  {
> -	uint32_t reg_offset = (reg << 2);
> +	uint32_t reg_offset;
> +
> +	/* For VF, only local offsets should be used */
> +	if (amdgpu_sriov_vf(ring->adev))
> +		reg = NORMALIZE_JPEG_REG_OFFSET(reg);
> +
> +	reg_offset = (reg << 2);
>  
>  	amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_RB_COND_RD_TIMER_INTERNAL_OFFSET,
>  		0, 0, PACKETJ_TYPE0));
> @@ -865,7 +874,13 @@ void jpeg_v4_0_3_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
>  
>  void jpeg_v4_0_3_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val)
>  {
> -	uint32_t reg_offset = (reg << 2);
> +	uint32_t reg_offset;
> +
> +	/* For VF, only local offsets should be used */
> +	if (amdgpu_sriov_vf(ring->adev))
> +		reg = NORMALIZE_JPEG_REG_OFFSET(reg);
> +
> +	reg_offset = (reg << 2);
>  
>  	amdgpu_ring_write(ring,	PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
>  		0, 0, PACKETJ_TYPE0));
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 101b120f6fbd..9bae95538b62 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -45,6 +45,9 @@
>  #define VCN_VID_SOC_ADDRESS_2_0		0x1fb00
>  #define VCN1_VID_SOC_ADDRESS_3_0	0x48300
>  
> +#define NORMALIZE_VCN_REG_OFFSET(offset) \
> +		(offset & 0x1FFFF)
> +
>  static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
>  static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev);
>  static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
> @@ -1375,6 +1378,43 @@ static uint64_t vcn_v4_0_3_unified_ring_get_wptr(struct amdgpu_ring *ring)
>  				    regUVD_RB_WPTR);
>  }
>  
> +static void vcn_v4_0_3_enc_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
> +				uint32_t val, uint32_t mask)
> +{
> +	/* For VF, only local offsets should be used */
> +	if (amdgpu_sriov_vf(ring->adev))
> +		reg = NORMALIZE_VCN_REG_OFFSET(reg);
> +
> +	amdgpu_ring_write(ring, VCN_ENC_CMD_REG_WAIT);
> +	amdgpu_ring_write(ring, reg << 2);
> +	amdgpu_ring_write(ring, mask);
> +	amdgpu_ring_write(ring, val);
> +}
> +
> +static void vcn_v4_0_3_enc_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val)
> +{
> +	/* For VF, only local offsets should be used */
> +	if (amdgpu_sriov_vf(ring->adev))
> +		reg = NORMALIZE_VCN_REG_OFFSET(reg);
> +
> +	amdgpu_ring_write(ring, VCN_ENC_CMD_REG_WRITE);
> +	amdgpu_ring_write(ring,	reg << 2);
> +	amdgpu_ring_write(ring, val);
> +}
> +
> +static void vcn_v4_0_3_enc_ring_emit_vm_flush(struct amdgpu_ring *ring,
> +				unsigned int vmid, uint64_t pd_addr)
> +{
> +	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
> +
> +	pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
> +
> +	/* wait for reg writes */
> +	vcn_v4_0_3_enc_ring_emit_reg_wait(ring, hub->ctx0_ptb_addr_lo32 +
> +					vmid * hub->ctx_addr_distance,
> +					lower_32_bits(pd_addr), 0xffffffff);
> +}
> +
>  static void vcn_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>  {
>  	/* VCN engine access for HDP flush doesn't work when RRMT is enabled.
> @@ -1421,7 +1461,7 @@ static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
>  	.emit_ib_size = 5, /* vcn_v2_0_enc_ring_emit_ib */
>  	.emit_ib = vcn_v2_0_enc_ring_emit_ib,
>  	.emit_fence = vcn_v2_0_enc_ring_emit_fence,
> -	.emit_vm_flush = vcn_v2_0_enc_ring_emit_vm_flush,
> +	.emit_vm_flush = vcn_v4_0_3_enc_ring_emit_vm_flush,
>  	.emit_hdp_flush = vcn_v4_0_3_ring_emit_hdp_flush,
>  	.test_ring = amdgpu_vcn_enc_ring_test_ring,
>  	.test_ib = amdgpu_vcn_unified_ring_test_ib,
> @@ -1430,8 +1470,8 @@ static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
>  	.pad_ib = amdgpu_ring_generic_pad_ib,
>  	.begin_use = amdgpu_vcn_ring_begin_use,
>  	.end_use = amdgpu_vcn_ring_end_use,
> -	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
> -	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
> +	.emit_wreg = vcn_v4_0_3_enc_ring_emit_wreg,
> +	.emit_reg_wait = vcn_v4_0_3_enc_ring_emit_reg_wait,
>  	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
>  };
>  
