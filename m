Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908C8C19F32
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 08:01:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F3C810E701;
	Wed,  5 Mar 2025 08:01:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2Fw0k6do";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A819810E6FF
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 08:01:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a106P6wosRdQp2mh3FSBwGVH7mqCoSCAVi4F2ZDmahpy+1kEfkBH1UIYLBBOhKUNLI2F3Cy7K61/ltvU6bi15WkC0iv1uwFkUe/alHX31uDqUx86qyyqJV3jegbXtwD3FyJ55A2pcovZyj7in1pZoHJQOjNwWiTqy1ylsvkXtFyQekTd3Atm3hMDYZEusalkXnZ6zeyEOK7letJSFIsF68oPsqIC7z8hzcosyFcWFIZUycbz6/ByurcLSKPfYt/4ewSxAIGMDtguOF67MUhS61L7H1iFTWP+nG+MZpbaxTZ33LF+6x/IRy8D7Rx7YZCsXxbyywqQE9T7ojQnwnhbfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzIx+2d112jpOHqc+8O0IH0b5fp+ULJIV3TnCwCaG/A=;
 b=naTtj4qsOzeRbeEeE1lG+4hjLNHdAD7zfJcvRyunf4BKSNA8sXOpXj2Bckf4E5pBkzjF2rbpObVY5snzZT787luS/tl3t4EoHij/lxqKeEQTZne7Q3WkLj7h0g9k4thHROUfYQA3+7dRzQ7ME3bhgPMudXKt/HIyfxfG4VLb2DVqVnLqfz8VPUh1vuubAz2pGuKPCc59xZPgXsX0XDqxP37WIAJtwFNAtBG2IPxxEvynACqBHuEY/vdWPmzkBRgiNy2hjTc+P5zkJHqiUCumvwIvj9DAI9WY+ybtwH1Jw6bvrZExpDLqUHYCtk/K6D1J1Tdi+Gahvdv6IFP6fPzRGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzIx+2d112jpOHqc+8O0IH0b5fp+ULJIV3TnCwCaG/A=;
 b=2Fw0k6doH6BM0fcz8Tg/vvqJzR8yqdt+Agi+Od25La5W8qRIjkm5SMbDnl5vyFp7adq3k8qPQkyhPqGt0Q5IUPUm+ibTvEypAY5xTffMlt/LSIHAWiB2zigWLQE9BwR2LfPBByng1K63lcGu3Y4G8WcwxOTSg5LT0H9i/CBT9FY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Wed, 5 Mar 2025 08:01:40 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 08:01:39 +0000
Message-ID: <aceb5ed4-4e7e-4578-a92f-5fdd01fc0e96@amd.com>
Date: Wed, 5 Mar 2025 13:31:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: fix the gb_addr_config_fields init value
 mismatch
To: Shiwu Zhang <shiwu.zhang@amd.com>, le.ma@amd.com, Hawking.Zhang@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20250305064435.3658987-1-shiwu.zhang@amd.com>
 <20250305064435.3658987-2-shiwu.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250305064435.3658987-2-shiwu.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0010.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::11) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MW3PR12MB4411:EE_
X-MS-Office365-Filtering-Correlation-Id: 912873b7-f59f-41a2-2791-08dd5bbbf59b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZjVTY1lYSWppZ1YyQlJHMGUyamovbzIyOHprTkdtYTZLRHlVZDdpV1YyU2t0?=
 =?utf-8?B?dnA5RksrVElnSjllNlZqNHViQnl2QkVCcWtqZk1yZ2tZL3psRWc4TC9IZEVv?=
 =?utf-8?B?N2JDUmZYWWkwbGlwM2VFZVQyQkpWZU1PcmplZzBKNCt1d2w3aW5xKzZqdFVR?=
 =?utf-8?B?TmhFU2J5cXlrQnIybDJEeWEwTlh5TGlUNUt6R0dZQ3IxTGxjUDlnVnFVMElQ?=
 =?utf-8?B?a2NoYVVOUW5NTTBUdlZEais3bWplNkJkZWlDV3RsY1cxVS9JVmltYWdRMURa?=
 =?utf-8?B?YWFDOHNEUExqYW9xblA2djVlbXFqa25lUTRBQjF1V3lnczBuV2x2Uks0U2Fq?=
 =?utf-8?B?SVJHVFdOOE5NMktuK0FKUzV6eGhCY2JMZnFqNGpMb2twS2lDZTNGLzU3TTZK?=
 =?utf-8?B?VzdsZGdtUEh6L2d4TUZKb2U0dFlPUEpEc1BhRFo3bUsyVnhsVlo0OUNybkUv?=
 =?utf-8?B?Y0VyMml5bVVGNE5IT2o3ZEtMaWovZHlkYmdpSTh3WDJobmpYOFdNdElwR0x6?=
 =?utf-8?B?dGVLQVBiYTZtdUNEa1JQV0ltYTBUVHQrdUVMZ01vMjhMSndhR2NDL2xXUW1F?=
 =?utf-8?B?ZjRmRHRGazhlTXdBVFpVTGlUa0lLcTdxQkg0WDAzKzJxV1VvYXpYNExOWU1D?=
 =?utf-8?B?Wk9xVXAwZzBTaUNYS2kwSjZuSUs0ekxLeGgrRW5WTU1MYjRsdjJWSnpyaTZq?=
 =?utf-8?B?Sm1rUDhndFpYdUFmRUVteGdNWmtRTXB4Zi9yaFR3WEtrTnJtOWg4cWdhVVNr?=
 =?utf-8?B?RjRMeXJrcndacjZzd1F1NFRlZzlERUl0R0N5TmFiTmRPT3gwVEpIN3FXZUxJ?=
 =?utf-8?B?UFMxSnRNOFNubnhHQnJFMnN5bEM5M1pEbEFHVFpjelVzRk1SQ29PNGpGT2Ir?=
 =?utf-8?B?SHM1UkJHdUIzU3hjTFNYcnphTm1pYWwzekNLZ2JxM255SGlMZmZtaDc3aEN6?=
 =?utf-8?B?SGdTMHhWL0hvdGYzdHVMQnpJRUt5RUtVdmlSUFRqdFptOWc5WDJLelBYQXc2?=
 =?utf-8?B?Z1hrSHNseG5kdVUvV0lhTVN4bDhSNnN6SlMxMm5KQnVibml3V3dqcmJGeHQy?=
 =?utf-8?B?SzNZN3BPMzZWSjFIYWhRbXo5bUVPUTFXQm9ScmZHYitaRXpSR1lSdzcwdG1R?=
 =?utf-8?B?MVhmT25VUjlpTXdEbkFCRnN1d1c0VGcrdlR2SE1zTjNPQkpWYktKMXlmU2Fm?=
 =?utf-8?B?U253N3N2ZDczRC93REEyaVZUYnpyRnF1T21vbnBkTkdJTzRKV0ZoaEdvcUtm?=
 =?utf-8?B?bEJhc1pPNlR4cGdpK2Zna3ZDdlNZNEIzL0dLV1ZTaEtnTTZEUzRYVDVMRlox?=
 =?utf-8?B?VjJaamdXaXRNMStTdXN3MDNNSmFxMVdlNGp0eXJLVm1mWFVIRWtDUVJsV0k5?=
 =?utf-8?B?VytpaERReWNEVDNmSnlXeVJxU2dmS1BLUnZYaTJhSVUrNGJVTmdrQUVSYlh5?=
 =?utf-8?B?emR4dG94eDFRSWNQODhQTlRsK044bjRxQWZFSUVxM2k3TW0za1AzdW1hWDhV?=
 =?utf-8?B?ampGZERJQWl4NmhQTHRIanVoaldldkZ4MjBCNGxYcEE4Q1NpTUxqTjk2b3Zh?=
 =?utf-8?B?Wno2dEtpY29kbGFkaTJ2SDhRR0VVcFNzVnRyRnhnM0lUVVdld0VyaXlRRW53?=
 =?utf-8?B?SUpHcnBIekV3RDdWU2FuWXpRbFRQbksvZVFyVWg5N05OQ3VFbFhJZkNocDYx?=
 =?utf-8?B?ZVdoeDFmc0tUZXRHK0FmektpSWdLUzBYcnlSak14cGU0TFVJWEF2MUNFc2NG?=
 =?utf-8?B?YXdURGlsL0R4bTRXYWNIQkR5VFpFV3NTMnA0ZnlyeFFsOHJDa2pDb0JYbDNT?=
 =?utf-8?B?a1k4Tm81VUJXV05OdU1DWEp0WVl6YUtwbDUyWUJ2b282dHJ5cTNMOVJpR21u?=
 =?utf-8?Q?vyT2Vl9zn8eYQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkJIZS9NNW16NTd3em9TS3BJb0gxRDJHRnVzWkdjWHZXMEVWeDcwTGJ3cjU0?=
 =?utf-8?B?cm96Rmp0bVpFbzVzL1ZzMldmVllhOU0veEFGTHVNRlBiZkZuUndVeUFybzVV?=
 =?utf-8?B?bHZXVjE1bzYxZ0pIdUtJdEpsalh0NVpYT0loaTR3RXNHeURjbFNFL3JmOFU0?=
 =?utf-8?B?TndtV2lFMjc1MlNUTnNrZmJqZjRXT0xJNEtha2pwKzVDdnppSVRwYmplRVhE?=
 =?utf-8?B?WEZubjBKVzQ3YnowMUluaEl3bHZzTTVpMmV3SVF1QUEvTldQMmFFcnV2UTFX?=
 =?utf-8?B?M3pITlFvYTNQNWo4UGtVU3VUVWpVTEw2VjdpZ0s1Vm1lUHVacmhiUUtQa21R?=
 =?utf-8?B?TE8vL0s1ZElBZS96Y1F4VE9hd3FobzZUak5yS29PRzZBM3ZpV2FpYnF4NjlJ?=
 =?utf-8?B?U0U2bC9xZnFSVWlNaDJ0S1NBUTg5NU45eU5IZ013a01YME5ZMU5kUEFteGhz?=
 =?utf-8?B?UEkzVlRXbU83RVBlTXhzRkdzQmZjOU4xMkxJd205RzBjUy9vQjBKMXpFK2Rr?=
 =?utf-8?B?R0xQbEtmc2FZTHovbi84RFJHRklxK21tVXNDNGQ5WUZGemRGTUJiVTBPeGg3?=
 =?utf-8?B?LzFMUlo3d2gyTkdpQ2c0VGlRQk9LM1o4T1BxaG9qbVh2RnZVWDJ3WUZTNFV5?=
 =?utf-8?B?bWNjZXZEM0xhLzZnc0F1djBjSEt0R2dlQ1Jiai93MzZ1MkZVWTRIMFZoWVNx?=
 =?utf-8?B?RzRkUkxZZmtJT3k5WEFDOXdmaStEWnphdVlveFJBVEl4aUVsNzJIakNBdGgy?=
 =?utf-8?B?eTIybUxTT3phUjRLd3UwWG1KN0tXTDlnRjE3cFMwTlZibjdiV01pbGJXa2VO?=
 =?utf-8?B?K2Rzb1EvanJyYzZVNE1rWEk3aU9oRVF3RzVQVUJFYUV0U0UyTG53ek5HZzVM?=
 =?utf-8?B?aU1kSHNZRjZsYTUxazFadW9wNTI5YWlhWmxPRFJoSmQ3dnBDbDZ2RVJQN095?=
 =?utf-8?B?WWE5Z0lKVFNzbzJJWXhDNzkvdmt3MGxaQ3BkRjhMUUoya0MzUnZYdVRsTm5S?=
 =?utf-8?B?Q3dNVStKZUQ5NzJzbXpPU2dOS0x3Z1pOaFgzay8wWFd5WFZsalVlTXpYRUx4?=
 =?utf-8?B?MGVIL2pSVmQra2NOYzkxSGxjcndVZUVRSkVXRHRDVGdMemprNDh5TjE2UjVJ?=
 =?utf-8?B?NjRaVUE4SXJnVzg5dkdFRUV4YzNMdnNydkc5Qk0xNFA3OWpJaDJJOHJsMG1J?=
 =?utf-8?B?cndnbkRvWjhvWFppWEJ1ZXNQTSt5Mk91Zkg0TzgvNU4ydVFCKzNBRWo0aGw2?=
 =?utf-8?B?a0J6TW1PZmdMazNjWnpLM2RaN1F0STlDSml3S3NYYkZ0cmZ6bmtuSmxWYUpm?=
 =?utf-8?B?TU1yTU9sS0xkTVNDSEJwMDJjWVBUbVNiZTdxYkVkQ1JDSDZMbVdqemN4NFp2?=
 =?utf-8?B?alJsL3FRWldCVEJRZ0d6cG9Gdkg5VTB6VEJHMWtUSi9YVmlCbU1FNEk0b1ox?=
 =?utf-8?B?MWp0dzh3VVk1KzE0cTByUysxcWdZZXVJSjFPY0lGQUlYaDVSOGNBUnNKdnpi?=
 =?utf-8?B?L1RyZ0xNMnVqa1phNGpQSjNqbEZYZ1ozeG0yZWJ2d2YzQTBJYWNJMHZuRkgw?=
 =?utf-8?B?eDdFU3c1NmtjbG1KdWNKbXpRc1ZUU0dGZjh4OHZFdHlacXBsRXBwQTlJSDI1?=
 =?utf-8?B?MlFoM01VUXBUZm1XVVd2YjR1Y2t6WkNsQTRydWZDajNXZUx6TVExOGg1N0lD?=
 =?utf-8?B?N3BwN2pEOFZxcXcrZHJFdjBkdU9naVN0R0hteEIydTJSZTVJR2FadkJBM1Z4?=
 =?utf-8?B?dm5QUHozZEdzM0VGR0RoV2ZMZUYvU1BobGNyaXRqWFZtMkowdUdjVlJJQlMx?=
 =?utf-8?B?MmZEaHk1bGJSS2l6eDM1VmVqd2dSeEhaUk1zeW9zUnV1OE5YaFpvd2oyR0x6?=
 =?utf-8?B?Q3FtU2Q1ZktkYzhNS0dGa2FnWk83UWhhS3QxYTZlRDdFWVh2MEMyUTlZcGF6?=
 =?utf-8?B?eDJpYno0YkxNdGVIamVIMzhKT1NWV3pZM0laSWN1c204Y2syZkdzek1zODhP?=
 =?utf-8?B?U2dBVHdCeU1lWkd3NkxrdElnVU1yY3ZERUcyN1lKYUNzdEs5MDlnNlJ1QlVX?=
 =?utf-8?B?SXR1cE8ycWhNeDlnZTRhT2ZDVytucmxON2xQd082aWJTdFNjL1FDUlpncm9J?=
 =?utf-8?Q?Mf+cq/tzVjxW+1CFxKZoPLBg+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912873b7-f59f-41a2-2791-08dd5bbbf59b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 08:01:39.7845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6VO6vqUgBRd47SyC/WLoE6NUXcY2F7I2mXvMgZ4sZa/qdjpmBkBA0XWXA3RgCJI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4411
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



On 3/5/2025 12:14 PM, Shiwu Zhang wrote:
> For gfx_v9_4_3 specifically, before regGB_ADDR_CONFIG is overwritten
> in gfx hw_init it is read out to popluate the gb_addr_config_fields
> in the sw_init stage, which causes mismatch.
> 
> Fix it temporarily by using the golden value in sw_init as well.

sw_init => early_init

> The final fix should be by vBIOS/IFWI.

This is supposed to be a driver-set golden reg. Most likely will remain
this way.

Series is -

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> 
> Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 2705f0cdd6da..af9b784eb78d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -918,8 +918,6 @@ static const struct aca_info gfx_v9_4_3_aca_info = {
>  
>  static int gfx_v9_4_3_gpu_early_init(struct amdgpu_device *adev)
>  {
> -	u32 gb_addr_config;
> -
>  	adev->gfx.funcs = &gfx_v9_4_3_gfx_funcs;
>  	adev->gfx.ras = &gfx_v9_4_3_ras;
>  
> @@ -928,9 +926,7 @@ static int gfx_v9_4_3_gpu_early_init(struct amdgpu_device *adev)
>  	adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
>  	adev->gfx.config.sc_hiz_tile_fifo_size = 0x30;
>  	adev->gfx.config.sc_earlyz_tile_fifo_size = 0x4C0;
> -	gb_addr_config = RREG32_SOC15(GC, GET_INST(GC, 0), regGB_ADDR_CONFIG);
> -
> -	adev->gfx.config.gb_addr_config = gb_addr_config;
> +	adev->gfx.config.gb_addr_config = GOLDEN_GB_ADDR_CONFIG;
>  
>  	adev->gfx.config.gb_addr_config_fields.num_pipes = 1 <<
>  			REG_GET_FIELD(

