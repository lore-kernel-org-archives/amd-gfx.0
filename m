Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2F5D3B7EA
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 10:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 246D810E4F9;
	Tue,  9 Dec 2025 10:10:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ibfWjBJT";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010008.outbound.protection.outlook.com [52.101.85.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52B6410E502
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 10:10:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHCiKA2YdE8Q8T/Jtyr5JYBvOIYoigNVdMnhqiVRG4D4T+FCrTee6E3pyqOcJ6Szv7jbV7zk7Sb6rCt2GVagQ/kcMaABk8SV2fFXT/lOs7PaPlFz5kRdPkIVHR14V8xb7S2FjZciNvxoQHX8VRqlAt+eE6Rfn7X2v80pTfmciNzB+JCHQBmmR+Vw47kiEds6K+qKl4eWq2B8EJ+L+IHdXQ2J6WVly2Vl8TTM64us4PfyI2YQTNXNZHZ+BsGSIg8h40uFU5ltai12YsRiSX79t9pjMKsd98G/339cCqPB6O3ECP3oBRrASeVZxOoKTduBkdvHEKcbSznlOXGzoyCj/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMAqanuIUH7dxPyy1rN4V/MtfPjL+atLGajAUkHKo1c=;
 b=HGupEJuzZi3Pr3f+Xgdshr73C9akvoGmDcmqAkp9xJFuNIHeICfpDJ/L5+gIeWC2jiTVN+mJkZJc8TctNNxe4T3IkvnGm02qj8gruxz3ludM5uKFhKDNoYqmYr5CyFW7ULcxR29S3k3XRdGNzKuUsYFGXyQzDRSIIGWiZtaksRnxnOCseqTRhDhhtHHhtDpzpyBWPeFUso9NLOdPrPQ32a0eADMwVbMAHkInAlEWbJTFEJwPHIGDeuKZwgekcuS1RWoA9YnDgat4fAGx/LCWy5AhdTyK/b8n3j6R/BtaYt4O7OVH0kreefN/4oH+XhesIvKUNAC0mLVa4UG/BPVk8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMAqanuIUH7dxPyy1rN4V/MtfPjL+atLGajAUkHKo1c=;
 b=ibfWjBJTVvILcutQjJ1HdAFZkMXBkP6wwr3LGIm0/owmtt1oyjOYB48u8lwHcF7n7i1LrgN1sh8doP+NCzA9IOhj5GrLATZKx6E86OkA24ZeYxsqKYDvlf9HOXgmCzsvOCPvsc2a1LgVo/x7sZ8X4NrTlsgG717RB9SC6P1t3N4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 10:10:20 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 10:10:19 +0000
Message-ID: <47faea8b-7d87-4bae-9e9d-a7b32799db5f@amd.com>
Date: Tue, 9 Dec 2025 15:40:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix issue when switch NPS1 to NPSX
To: chong li <chongli2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: emily.deng@amd.com
References: <20251209090614.1428589-1-chongli2@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251209090614.1428589-1-chongli2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26c::13) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a785667-6dce-4b46-3fab-08de370b2846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDVHdVZXeWRKZWp6Z2hnaGUvSm1HYm1qMjAvOTlBNmYxODBPV1pKODdMNml4?=
 =?utf-8?B?Q2FzVVNTZ3hnV2dOWWZEU3NiWTQvbFVlUy90WHRieG1xSkFZKzlJdjBJajhZ?=
 =?utf-8?B?QVBjMm5UOUFrYnJMbWxPVGYxUUZETGlmbDdwS2Q3Tmt1c054RkFWenl6M0Nq?=
 =?utf-8?B?NVFZQnRnenNkbTdyV0svYmdiM2Z3bWZHazJOcFhWRTFZL2hzNnNXRWNtemNj?=
 =?utf-8?B?eGRWUjV2WWh5RnR6WitKVjNvK0RBZjRSenhWdHY2dDd5MGFWTi9zTkFwQkVV?=
 =?utf-8?B?dEpLN2xSUURKcHdvcVI2c1JkbnRpdDB1VHNlY1NsSG9RZityM1MzejdmcEU1?=
 =?utf-8?B?Q1pNLytFMGhRWWlHWVZ2MjRxZkh4RFgrVEhIZ216L2ExajZwbC9Pd0grMmdj?=
 =?utf-8?B?aGRPU2tLeXJnUXlhVktLYitpZUdHbHhVNnNXMmN3VjIxS21mWGt4M0ZHV2hB?=
 =?utf-8?B?b2dZcUZnbjJxTGFIL2VwVGJZZHJpaTY5VWw1dVVKblpSYWVIdWFzMmFIbVlm?=
 =?utf-8?B?MG5FOHo2Zi8rLzJ1dnZ6b0o0aVh3YWRScXFOckdnOXlnZXVkdSthWEIrN00r?=
 =?utf-8?B?eFgxaHNuaUNLOGd3SGpQOEtXaXV0MVlNUFpya1JHQytDZmpHdE9zalFpUlBI?=
 =?utf-8?B?MnJXa3RrSW9rbHhOdE9pc2dWVnRBaDFRemhueC84RGpaNFEzV1V4b3F5czV2?=
 =?utf-8?B?V1lDU1J0RGtRRWdlOW9kSk03SG5ORG9NZ2ZqTzVnUDVWTWIyalVGUXR4cDZP?=
 =?utf-8?B?Y25ISG02QXhKUHAvTUsyVWFkakJvMU1QMnVpWGxQc3VkRFg3b2VRTFRCWllp?=
 =?utf-8?B?Z0ZaODFvWC9zUi9uaEExR0pIbE95Y0VxQVhiOUpnNmhsL2JtU3RZV1RaN2lt?=
 =?utf-8?B?NHhub1FXajJ1UUZ4RUNZQUpPeldPWlpDS2xTOGd5VVVBdmNZWlc5RVcvUkth?=
 =?utf-8?B?MVNScG1aSXFTemRGdWFubnF1N0VnMFBqNWsvNm16L1BWV2RRZUQ0aURqTXFx?=
 =?utf-8?B?Mkh6bHZiQXJHQmNnaWdjNDgyTVBkaFFIeEJ0dTJjOVQ2RFZyV2M5OXBlSHpk?=
 =?utf-8?B?dDFaNEMyaUIwemVMVDU1WEs1QStyQUNmbUkwOXdvVWRLR3NrVm5SNHNGKzNq?=
 =?utf-8?B?UGJSMTRleXkxRmpjMUNsMVFOL1V1SlI0aTk4aVliV3FESXVtRThtWktYME9Q?=
 =?utf-8?B?b2JQZmg2Kzk3TXlLUE9KZmRvRDR1VkFtUUdTYVVrZm1WRU1HSjBEazRwYlBO?=
 =?utf-8?B?NTZsNmNkYUJmRTEyNmJWUEl3NjhTaWlqQ3B6QXp0YkRPMEJLdlNxcGUybVhn?=
 =?utf-8?B?eGUzSnZuS1h4WE0vTW0rZHlxUnNiV0RtYW56cTdGUlEzbU00ek41WWFHN3BG?=
 =?utf-8?B?ejY2K3czeGsvVHpXOTRXS1UraVpTNmMvcTM2ZW5ZTjhLdDBBRzB2QVp6bVZw?=
 =?utf-8?B?cjUxZHY4blhocXBnNmM2V2M3RFljeXBLT3BLZmE0WEZXZEpRcEFYS1pkUXll?=
 =?utf-8?B?RzZVbXR1NU91MjZFZFczRFRJeGU2aVYvMTBKRHFCRkRYNitDNlp6cHpoSUxW?=
 =?utf-8?B?MGttVzJSS1Y3ZW9yM1dOakx0aG0xV2NNY0tyZzg0ZUhJaWtobmdOY1dkU1pl?=
 =?utf-8?B?YkNGa3JvWFVsQzB2OU1QblRCMWoreDVNVUpHczJYbjN6QWVOY3RWZ2p0aDg3?=
 =?utf-8?B?NHkyS0RBY2IzUFAxL2RvQTcyY0xPSmJOQzFQQ1NQeWJueTlvcWtXT0NvSktK?=
 =?utf-8?B?dVBhcXVGRXRxb2ZXbVNkeXVVVW04VUhaSXVBaWd1N0NWbTZYUTRNOHA0eW1w?=
 =?utf-8?B?RlZGRTlPVU4zQmZCNXd3SkJ0eXJyVzlTVTZlWm54enlQV3NOWGlmVEZiYUIx?=
 =?utf-8?B?ZzVnbXVGZkMvVkRvQUpqdS9nQytLam1mak0wMWV3aEVhRUh3WmMwanFTRzBJ?=
 =?utf-8?Q?vdcpI5xTJTkAGDJ/jR1GPnR2VfxdBmJi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG43QytyTnJwZWZLODBReFZkbjU4SGM4dHRYS3ordFBtZVBnWkpiZk5jSFhl?=
 =?utf-8?B?eXFCQ1puVUMybEpLaVhDUGcyVlpITG9JVmFVbXlZNjhKUXVKbGJUbDNEaytX?=
 =?utf-8?B?Q00xS3ZqeEpmSTNsOHVoTHRoSDdUaHZmbFo4NGtEK2dXWlN6Njc1dFdIVG8v?=
 =?utf-8?B?V3VEMFZsMng5RitkdjY1ZDhiQjVCSEthaVN0VnpDcnc2Y2NPSWxCKzZYWkVJ?=
 =?utf-8?B?Z05ZY2hrcnUyREQwVVpkM0tzUHhJNnNBKzJrWmdOK2xUYlAyRC9QSEUzWTR2?=
 =?utf-8?B?eFA0bllVZEdpeTVaVFVRb2lPRDgxbUlhT0I5WGtLbU9GcmNUNm9mT1M1RFZD?=
 =?utf-8?B?R0lHeWlxMlFoZEV6bmVtQVNXcEhTU3lrSkFIQU84dm9WNFpPSHIrdDc2ZUxG?=
 =?utf-8?B?azE3U1Nab1NGb2pWRkQ2OHNwUUwrSlo0aGR3Nk45Vk1oWkFiWnA1S3lZRHkv?=
 =?utf-8?B?MmlQbjN1SklXMGY1UXdyTWIvSVpMTUhjY2wzMFdWNUhLZEppMy9pNnUwUDRx?=
 =?utf-8?B?M3ZLVWpzVVgzWVp3cGJjbVJxdkxoRFg5RGo5cmFTbTk2dzdzVloyZHRLSUtk?=
 =?utf-8?B?YUdraDgva0hkelJKd3ptd0FaK3grWjdJVGlpS2JvUWM5Znovc0REeHgrb1R5?=
 =?utf-8?B?ZkRQTlVqaExieGQzNmppV3RTVXlkUVJreEJrMkpGWld6R0w3d0FxUmdLR3JR?=
 =?utf-8?B?YS9Yb2d4OFdkNk8xck5Jb0o2Y2pnTWNiT3Z0ZHFRMnFpRGxNV0htVUM4US9C?=
 =?utf-8?B?cTd6a01nTXNxSUdZcENnazZwdWUyM0lkNFB6TWJQUUZyOGlhK0ZRa2FvRzdP?=
 =?utf-8?B?UmtNdWxyd0xtQjVHSjRJd08zWXdPcFN1OXQ3MDFvVHRuWi8vQStxQkFTUEcv?=
 =?utf-8?B?d1hoVGE1QW05aWE0bi9pekdOSEUwb1Nna1BKek80WHAxR2Z4eDAyblRwSzdu?=
 =?utf-8?B?QzRxMVB3RTE0ODRaekdXNFM2Z3lkT0hhbkhBc2U5YTBEMWN4SDRqNzJ6czA4?=
 =?utf-8?B?cWNXbkJ2QTlGbFovS2ljSkJDaEtZRnNUV2VsRU4wMFFSUk5RYkNXYk92dXNJ?=
 =?utf-8?B?b1lQWWIvY1FVWFhWNEVqR2NZaEFUTVBGSk96UGdldGRQVnc3VlJ2TkZUOEt5?=
 =?utf-8?B?aXRvSHpndnAzYlV5L3JJUGkwTCtIaWNlbmdDb2ZtdjJFUys3aTBBR1N3UTBT?=
 =?utf-8?B?b3NPQlV1OXRpaEl3aFBGWEVzVEJvTVZzdC8rQ0x3OGs5QXh5S3dFemZROWxr?=
 =?utf-8?B?dFVxaEJ1cXN1NHdIZFQ0MVZjQnVITW1ZSXdxazFHcXR1eWl1dlY3MXFocmsx?=
 =?utf-8?B?Wi9HUktXT0pLWlBQSUxBUmZROXdabC9hbFpVc0Vucnd0OEFrOU9mSUZLWElj?=
 =?utf-8?B?VWdzTmFWM1VTYjVwZFhCdmVxY2x4S1A3U1cwMmlEZWZsVlNOdlVDRUtHaEVz?=
 =?utf-8?B?bWtKMFl4NVlHdGlMTS9TOXFseTF4T0JOY1N5Y2IwOWlKU2JBLzR2Z2JoM1FR?=
 =?utf-8?B?VWQ5K1lTTURTU011clNWbnNVelZISjFHdzJPOStsQ3VwRzJsWER3REZsd3Ba?=
 =?utf-8?B?aWc1YkRqV3pzN2laSHJJdmZYekVadkxWUjlNTHFIWlFBZTBwUXh5Uk83OEc2?=
 =?utf-8?B?ZmlXMDRlbEUyWG1DMDFUeHBLVzZPNTNjMCtBcW9RRllVRlp6M016K01GV3JX?=
 =?utf-8?B?cXdpVXh3TWcvbExLMDNVcHVoZU55ZStFSE5vczBRMVVUZ0tEQTFJQjFCOWVw?=
 =?utf-8?B?VG1lL3VScWhrTGJlaW4yUmZRSXpPWUVRVzZ4VmlQQ0VkMTZPcGJkNEVReDlu?=
 =?utf-8?B?NktQYTFWU2J4MWR5dEZ6cVk5MERRRmpEcURTVXRUeW5EbGdtdktqQmUrcit6?=
 =?utf-8?B?TnMzVGV0aE1sUUc1Ym56NE9ONWxzQldKN3RnRGNXWUJxQ2l4SUk3QmhlQVRL?=
 =?utf-8?B?WGdLV09QWmx3c21hK0VEUFpucnMxTVZWQTBsR0tSYjV2ckFpU05zaEhiWDlN?=
 =?utf-8?B?cGUxQkJGOUZxQTV6NVBEdVgzTllTRFJIWFZ5U2dOWURuUFZHdWttQmhJcEMy?=
 =?utf-8?B?bGtYMlhUR0Y5SXJxa3Vqcml1N21yc1NoamNpTEppS0J1WjZLdkJXNUt3UXEx?=
 =?utf-8?Q?Z4WBX1IZkFzR9GG8YDBD0em0R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a785667-6dce-4b46-3fab-08de370b2846
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 10:10:19.6925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Spgj+0Kjq8T3IKFvFQTBe9+3Q+6AL3tqPx5bR8/+B3At97T6GmDJy+47yqCfZveh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451
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



On 12/9/2025 2:36 PM, chong li wrote:
> fix the function execution sequence after removing
> kgd2kfd_init_zone_device out of gpu full access region.
> 
> Signed-off-by: chong li <chongli2@amd.com>

Please also add the Fixes: tag with the breaking commit id before 
submitting.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7a0213a07023..5939df918570 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4931,15 +4931,15 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   		flush_delayed_work(&adev->delayed_init_work);
>   	}
>   
> -	if (adev->init_lvl->level == AMDGPU_INIT_LEVEL_MINIMAL_XGMI)
> -		amdgpu_xgmi_reset_on_init(adev);
> -
>   	/* Don't init kfd if whole hive need to be reset during init */
>   	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
>   		kgd2kfd_init_zone_device(adev);
>   		kfd_update_svm_support_properties(adev);
>   	}
>   
> +	if (adev->init_lvl->level == AMDGPU_INIT_LEVEL_MINIMAL_XGMI)
> +		amdgpu_xgmi_reset_on_init(adev);
> +
>   	/*
>   	 * Place those sysfs registering after `late_init`. As some of those
>   	 * operations performed in `late_init` might affect the sysfs

