Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70836D63923
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2024 10:37:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F9EC10E6DB;
	Wed, 20 Nov 2024 10:37:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zFDCDWAO";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B601910E6DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 10:37:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSJhrm/mtCR9qUEJQetJ0/59pqtSoHBSZQuBc7V6yXTWKfw+034WOOcXm4E3UB32scTv1bkutacz3bUNSqOhiyRD5PHTqzqL4udvfeCc6Ma8J9ex6c4oQHw8P4w7R7IrVAr+uUPmmwazGsSA0hAxRpBq8s9u3wkTUSyxbplAeT6j/Om63VNNiVLq8fDUJSb108Y0i0AKjetJ9X3XcpkRBgtqNFGX2sC8h5amolm15Em/V51s3PCW3zJ/tXns51Yqn3rgvCdJZIrGp5WbIE53ClBVzgPTW1MittNzb4/FPTAq3nr9Xcp7kkFQDp5rrTA4VPMFI5qppNJu7LhL2/HkAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3thpnd8yt4rYi3Mh2o6rSlp1m1bqgv6TpgLjcBqzP8I=;
 b=s/DDpbzkuvDXfBy2nibcicsfqoX0hArpxLcgrU7tISmLFdW3TeC9rg8daA88i/1Cf3i4BOrHxjOy4hzPH9QwNsusLlgSsHFgXpMR/Ezvx8dTEbmHO6wCmNR0lhy0XiksT+KfJ4J6T/qVuzUjDAWnivBrpoFnn40FEiDrKF87bWlQvMhsYYuBVi6MxahE9pkXZXOAGOisOmdKnP4ucmYWyqxNXgW2HPNV+nSUrWC5FQGXQqGUvAGZy7uporT3AZf2498Iedd5hhWr94Q9mSAUDkxDrX1z6Bv/gbeVm9DjUWZLA4h7dFSjI5PohZ7Ya5mNaCAosuoHh3RnD6Yf25KSnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3thpnd8yt4rYi3Mh2o6rSlp1m1bqgv6TpgLjcBqzP8I=;
 b=zFDCDWAO8d1pEeUPeDaut79/iVxqTMHxA5e35zIJm07oGstDTq6knNbNrmi/m8EdLDMxEVMl2/7r4gS09QJbGemDuznwGmZ7iTyeTpSJkdGO3fKJ5KQRRALVZm034+z2qRnVFdw4CbAPg5EIXax8tKn2K4eJHRLrfIC1Ih33rr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB6708.namprd12.prod.outlook.com (2603:10b6:303:1ed::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Wed, 20 Nov
 2024 10:37:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8158.019; Wed, 20 Nov 2024
 10:37:04 +0000
Message-ID: <9fb8c1a6-985b-4cf7-a5b9-fe1e33fbe538@amd.com>
Date: Wed, 20 Nov 2024 11:36:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Fix dmesg warning from xarray
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20241120092611.177202-1-Arunpravin.PaneerSelvam@amd.com>
 <20241120092611.177202-3-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241120092611.177202-3-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0251.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: aea6aae1-191b-4e4e-f489-08dd094f45ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFRJTDhDTnNScGNoaHlTdDVZS0JJNmk4YzlhUUtEYXNBR3d5c1hVTThwaW5y?=
 =?utf-8?B?QXR0OGtmME9NazVXQTR4ZC9HR01Pb3Fzd2Rud3huZmFrMXk3bjdlclNSaFpY?=
 =?utf-8?B?bHM4RXRHak5yWnVPZFlEaDdXWDdYMWRCSzlxeG5VaXVneFZwSXplMVpkeEpr?=
 =?utf-8?B?NWphNUpvOXVUZnNZSE5YcHY4NmZybmkzLzJaeWgyeTdGR2dmMFV1MUd2OVNw?=
 =?utf-8?B?SlU3UjloMkdFeDBlMjlIeGdBMzBicEVMTGU5Y3RpQjNhT2U0LzJOTk5OUVNi?=
 =?utf-8?B?WTVSMnJydDNXcit3SWkvdGVEUXVMNmdxcmpGM3JiT2ZCT3Vzb0UrR3ZGV1Vs?=
 =?utf-8?B?cHRtdkdVb1FaUWRkR0pnZktnT3JMSkpkTXNreVhZS29kdVJzV29xMDNYVmQ0?=
 =?utf-8?B?c0pNbjZnMXl6cUFxVk84S3l2M2RiSHVaL3YrVnAydWlIL2VzUlN4QUFWZnQ2?=
 =?utf-8?B?T001M1E1NEhhQ09hVlBWT2lZN0ZkRkNSaGlhbnRwQW9YN1Q2TVdENE5nZ3JZ?=
 =?utf-8?B?RThLcmY2SWk0TTBjUVp5cVJkZGh1cjdZWkJTcnJBTCtuS3MzazVQeGZFdHdW?=
 =?utf-8?B?Y04vUWJjUk5POVdxbUtNTHMwVnNONmlvOFM5d1JKQ2ZtQm9xOUtFWFFCNW4x?=
 =?utf-8?B?cXVYaU1iT0NTQWNUaG1ZMnR6bDAzdDJRdXVtV2FhVStzbFlKYmdweENHVFlh?=
 =?utf-8?B?S1pkdjRiTVRRbFQwS05sTXhEdzBNQVpiVHYxdDRpdGJndFAybDNhRnhUSHR5?=
 =?utf-8?B?T3NrQ0pzQWlSZ09FSEkxT0dKOHhIdnk1WndFanF4ZThKQXZtUjZFVTNpMzZT?=
 =?utf-8?B?eVp2T3Zhcm5xMW5zTkd6c0FXUGNEYnVPTlgzSjRNemdkTlA3cGd3TjI3VzNr?=
 =?utf-8?B?U1pLZTZXOGpVZC9Bdms2NUt5L0p1eTlsWjlhR21YMXpGVUV3V2hpRCtSajFk?=
 =?utf-8?B?SWFXUkdVcUU0TEs3dXVtT2UvWkFmY2ViN3kvRHZYMjJwc0ZpR0pwejB3ZFBz?=
 =?utf-8?B?cGFXNjIydkdrN1A5bHduTy94MHh4YVJmZzR1ZklVSGNFVG5IdWMxYXR4bUFq?=
 =?utf-8?B?eHByeXZIbDMzWDZaOVJGNzErWWNVUndITHBHWGc3dGJaVjZNRThPY2dGSGlC?=
 =?utf-8?B?L2NIWDRuaUpTT0VLVlp2bXVnZldtOTlGcXgxNUJUNTJYZ1FCR0RYY3JxUE9k?=
 =?utf-8?B?azZubW9tdlZZcEZHOS8vSnpvb0JmMkRMMVQ1c3JlL2JJVGxBSXBwdGFwSFVC?=
 =?utf-8?B?VVE4K1MwSlhGYTBxMm9mM0VSckJucWtNelVRL3htbzVTZnFNM0dRS3lOVmtm?=
 =?utf-8?B?SSswVlg2aWdYTUI2aVZzRVMxT1RNMGphZ29XTVFIVE1tVElYQWgralNuRCto?=
 =?utf-8?B?NGxDa0lvREF2OTE1M21qN2xCbUlhQ3ZTZEJkVVQ5WjhzSElzWG0wTTRqTDJ6?=
 =?utf-8?B?aldmV1B2MGxta0xBdS9jb2lVeEpVK25FK1pSNWxRdTk2UnM0VUxHeVVVZHVq?=
 =?utf-8?B?blFBZ1pYalhXcEhTSDVLLzhuMk5BdWpaTWZaQ3puWGJsMFZjQUI3RURSejNt?=
 =?utf-8?B?Q1RrNHY2Q05OdTFyS2JxUnNWMStRN1hsc1Btb2crUkJmbE9jWmltOTZkUkZk?=
 =?utf-8?B?c21TSmluWGx5RnFrTVVjRVQxWm1vVmtQdHZJYnlUc1N1RUdRWHhoT2lSRUNF?=
 =?utf-8?B?a3RoSmV4R1BHYXBXYkR5ZXl1eC96ZC9SeFk0bWNaRnNyQVhDVnNvZy9uN0Vn?=
 =?utf-8?Q?0BFHtELiINWlvjB3gVf1SGnubkkpuoDOyMhi6Cc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tkt6NnYwZHFtL0pHY0x1MVhoVlpuUGpuT1ZGeFNRdEVWZEdsUEovSXU4c1k5?=
 =?utf-8?B?Sk5uMjQ1OGZJSmZBNmErZjNZdzZjWUpYaEM4Vi8yS1R1c2JodUhmNlRCSUVi?=
 =?utf-8?B?cEZUbzd2NktRMUpNN0wrUm5VYWtPOHJ4K1hLVER2emxQdFRoYi9Bdk8wN1hi?=
 =?utf-8?B?dXRpNTdzWlZSWk5pVWc3MG1yTS9DT1dSZGQvTjZlY3p5N2hrYmhVU284SldB?=
 =?utf-8?B?SFAvMVZ5TFRBcGFJaUZBYkg5QVo4TVBuY29qeXlXVlVlZ2RvZmhJejNsNEdj?=
 =?utf-8?B?YjJZMWZsNnVTeCtVdThrMlIxdXh2V0diUlpoaTFPbkFTYmZYYjBvdFlURHJ1?=
 =?utf-8?B?cWkrMmZxa3k3RmN3VFRwMzRxSldMWUh6bXBNdlRxUUpDYVZKQXRGN3FDM1Ru?=
 =?utf-8?B?d3BKbVd3bzBtTDRjZnFZd1JSdW9VN1U1aTA3enU2Y3hWWXB5LzZGdzhldWN5?=
 =?utf-8?B?b3NobDFlaFhzRVZoOTI3bnFYRVNDemlqUXp3Ni9veWkyclQ3YitYNU1uL3hK?=
 =?utf-8?B?SEhTTkJBYWY5VFY0VDd6eklIY1JISkVKRmo3UDZ2ZnA4T2dDZFNWWnM3d29D?=
 =?utf-8?B?NGlrN05ycmFaQXBlSmIwOWJiL0tTeHdvemRVTnFkSmdlVElqczk5cTU5Uks0?=
 =?utf-8?B?UEcxMGZHRWd0MlBSeWRMRXl2eVpLa2IzRDlLWEtocVpnWGcxQUoyME82Tm1k?=
 =?utf-8?B?T1ROSjc0N1J4dk9jU0plbUk2aDkvcnZZeVFLU1ppR3VYMHVLc0xIaFZySzlY?=
 =?utf-8?B?dVFXSnVRRnRZTU5RU1VZMGlidDZoMFg1dXV1TUh6MTFYLzdFM0RxYUdxYm1U?=
 =?utf-8?B?MmRXTTFIT2NyRDV0clY0NHVpVGIxbHRLL1FEWlN5eWpkNGJUS0EvOHlpdGFX?=
 =?utf-8?B?ak94NXpaSWtXL050eXhEbGZEVExYRE9kOHRBUHdmZnVQdVpWbXJGK2drelhX?=
 =?utf-8?B?RUd2VExZWlFKMGFLY2gvckRRTkd0NkZIUzQwcWhqUHVUcVY0WHZsL0h1RFJv?=
 =?utf-8?B?K1ZmTjRzUzdoNG1WOXNhcXZ4YVd0RjZKWFFrRTk5dWVsaFFKVXpGZ1owVGt1?=
 =?utf-8?B?V2R1am1NdDgyU2xZc0gvYVNTNGtPZTlrL09GWlFieXlWdGlRRnJoV1gyb0NL?=
 =?utf-8?B?cHRBZ3RQMGowS2l5a2EwN3R4U3ROTHIxbE1NbWNxQ0lpQmJCNGh4eG4zS1JL?=
 =?utf-8?B?ei81UUY5enpxeVMwQS9kNkNUcU5tR2hpdVJpK0tyR1ZhTzFOQ2FraHRLZlBU?=
 =?utf-8?B?KzNiUmhhY3EyY0lkQ1piUjdMcHBxa3Q3cGFuU25OWnBKSSt4RWRrVVJBbUZm?=
 =?utf-8?B?VEdKempDdmFZRktncjBoTnpuNmxLMlRMdjlMU1VjWkg0ZlpMWHlveXhOeUlT?=
 =?utf-8?B?RGtsRlg1enczWUlmU3YzdU5Xb0FTNnI0czFwWG5kQW8xUmQrckNTMkdkbzkz?=
 =?utf-8?B?YldvZHJhT3RGTnFnekgyNFpIMTUvcENPL1hRaXM1VmwrSE81UUFrM2EzTHpR?=
 =?utf-8?B?RWxEaGc4dGZmWFlMUlliSGxKQjhwVkZGczIvbEljV3JBRE5rU01iUUhLSlhi?=
 =?utf-8?B?aUxsQWVNd2xXWjFsVHdUSVpSNDRRMDlyK1ZhY0xzaUVuY0lqZlRDY09MeDZv?=
 =?utf-8?B?YkJ5MTVhSVEwc29BcHh6dElCQ1B1UEswb25XZUtEbGZZcFpGc0crdDdiTEdx?=
 =?utf-8?B?b3Rrc01nSkxKc2ZTUlF1ZUs1NE5tQ0ZSbG9lSUcxeDg0OUhzZkQ1Ykx1dGJU?=
 =?utf-8?B?b1k0Ym81Qk0rVG5zVSszcW1oRHNTQU02ZXltcmZ3a2cyWEtXTkwzOEdkUDQ1?=
 =?utf-8?B?dHJtckEvRnlncmk0eDNJZWUyQUY3N1lxWHVGeXl1akM5V2c5R2U5M1Vyemx2?=
 =?utf-8?B?QUZrWWhWNEgyZEljbTNSdzAvNjlPaGF2b3MvdHMzK1VVTHZvUEwrVElNU00z?=
 =?utf-8?B?SHV6c004dCt4UllnUkhsaUduQXBZeTFsRkJNaGg3UEpKK0F3Zkh3TFkxam53?=
 =?utf-8?B?SHdrc2x4L3BpWXZIeXJ3RzBZOTE2TXo2dEdRVXF3OGh4SkcrZXlZbTJ2Q2NU?=
 =?utf-8?B?QU5oNU1zWmVvSVE5UGZCbW5URUFTcEpRSmVLKzZnOTR2OE1qdEdVL1lTaHlv?=
 =?utf-8?Q?b4MFjhKhy3eOVuD7ifokYgdaz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aea6aae1-191b-4e4e-f489-08dd094f45ec
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 10:37:03.9218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SzX9ZdPVap4lipvcUbS6SHheQJYnPZZehLPfkGNqwrPCY0DXJG507nDAujLE/UH0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6708
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

Am 20.11.24 um 10:26 schrieb Arunpravin Paneer Selvam:
> Fix the warning issue generated at lib/xarray.c:1849.
>
> v2: keep the error handling same as before when the
>      xalloc() call fails to store the fence_drv ref.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 76f7babd7a54..bfe7d1d139d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -842,8 +842,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   			 * have any more space left and crash.
>   			 */
>   			if (fence_drv->fence_drv_xa_ptr) {
> -				r = xa_alloc(fence_drv->fence_drv_xa_ptr, &index, fence_drv,
> -					     xa_limit_32b, GFP_KERNEL);
> +				xa_lock(fence_drv->fence_drv_xa_ptr);
> +				r = __xa_alloc(fence_drv->fence_drv_xa_ptr, &index, fence_drv,
> +					       xa_limit_32b, GFP_KERNEL);
> +				xa_unlock(fence_drv->fence_drv_xa_ptr);

Why should that fix anything? That code looks identical, just with 
explicit locking.

Regards,
Christian.

>   				if (r)
>   					goto free_fences;
>   

