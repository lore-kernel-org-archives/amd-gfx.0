Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFCFC021A4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 06:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5595410E246;
	Thu, 13 Feb 2025 06:34:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s8kkm9X8";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC42D10E246
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 06:34:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atyKWglO7saD50cwbkLjiwmJsY5DgX0/xi6V2C7lsGEXF/CD/UFFdHqFrl9Yx7yjYS/hv0W/n4Gqlx2a5I7AyY70/FSa9DVzTsMLv3sdrdup/FNVbj20eL8dtr3h4hDkRLjFwt3/G2FEF+Y/L65vpLvpQbqw4ywgWAItSLk823q/ZorQIVqxFjh6etc1HcvDPD77j6h+YDNnsF50rSuSIpzEu+YVS/ie9md8NhCTT2K9z/vx0dnfz38iHrNSqZWcM1kvhSH7IFyhGpdm8GQiA2nNLhhDqppzRKB6jFlCosusRSHyX7dhsW33ZeKBr3Q2jtcX5rW3Il8WLkoeBl+yDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5cz0RD94NXXsYYF2by0/lyuPPFAYxaTdNPbsNkrHyI=;
 b=f/tmvmY6Y5PTnyCcNOltGLY2h+yM41jRdl8m5qgnz1Zn4VOIyMZ5XQ5sT6eH64yB/13gCsMp+/m5VRIDPLMzYhKyydsu0asmB43zySPcGx2vrUv12oWAjxtvC8pBUoqjH/ZJQYKV0rMoQnz6hQNgNLhB11rnAGBGBOJg1T3bClSVlHao0c0NN95Qv8lCRzHQFpFZZsQWX3olLcin7kMD/1pDDRX86ycZDXqVdeL4QTEglgmAehIFCKaFTraJorT3dOT0IeBU/UVHs9Ay++C9qHDhUREJVSxx4KNQUww8Elf8P6F27Gg87PIR2wdaO2fMMQWNh2WejHaYSK6kea+LRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5cz0RD94NXXsYYF2by0/lyuPPFAYxaTdNPbsNkrHyI=;
 b=s8kkm9X8oGb0mIPRIZBvcOKF9xLKhgE1ZyIsYWMUm0nlnc4CtRJZ5Qrm8gd2KdIZPMP9+SdW39H92PYgxDjg0YRMmycO7EuM5VKxBlg1buz1a/j1hPLguX2vbPKyHaEVFmBI3aqk+zkjIP7f13rTHEl+Hus5gjprSYIAVJyW1Fg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM4PR12MB5985.namprd12.prod.outlook.com (2603:10b6:8:68::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.11; Thu, 13 Feb 2025 06:34:52 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 06:34:51 +0000
Message-ID: <63230f85-c3de-43aa-b23a-d7cec00d23ab@amd.com>
Date: Thu, 13 Feb 2025 12:04:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: simplify xgmi peer info calls
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250212155734.2213096-1-jonathan.kim@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250212155734.2213096-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::7) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM4PR12MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b44a4b3-261e-4ee8-9477-08dd4bf884ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3luT2h2aU9XTmF4Z2dDaFdMMUM2T3RRZzN6aURXeEluOVdJL2tIYnUvV2V6?=
 =?utf-8?B?VG9xNGZ6cEFBRkRYSzZwcFVrYVNKZlRxMU1hNm5HSXFCQkx4M1NQMWVUYUhW?=
 =?utf-8?B?eVFKNzFGYkM0dE5iWTliMFpKNlRKTDU4WkJUQjRBY3hlcG9VdklzTjRTR00z?=
 =?utf-8?B?emhwaHN3SjVZQnplTFpiU1kwOVhTTkxnT09kTVRWZUpWVWQ1OUloOXZvVHVj?=
 =?utf-8?B?WW5Kd3FiSTZKUlRPUVpVcmI1YkhnY09KeUFHS1BFcVpTM2RWdXVhQjBRSFE1?=
 =?utf-8?B?c085d3lkTjJRVDNZc0U5TVRjSEJoWFBWZ0tsbkhXN1NpNEk3TVpwRThnZXIv?=
 =?utf-8?B?UGhBVkt5bnl2eXUycG5QZEZuV0VOOGc0T2tQOU95cGhGYzFsbHQ5V2VXbTZl?=
 =?utf-8?B?RGdHWDdFajlPQUVNbjZhRmZ6NjBqN3gzcURuc0dLZ0ZoUmsyc0JQWVZoSTFG?=
 =?utf-8?B?SWwrT0l4R20yZmRFc0VidGtoM0N1NzJFZXlEWmp1eWFpMXJ1VFN3Qm1yM2J2?=
 =?utf-8?B?ZUd2dWpnVEIyek1HSHQzcFI5NjFRR2x6d1pBNklqQW9VQzJJQXlEZHRBTzNS?=
 =?utf-8?B?UWhGenNyVUxnN2VRcUJ6YzcwR1pyYml3VFV6MlY1ZkhQblNyREcwa2F1dVB3?=
 =?utf-8?B?aFp4eDJYc1VPL3dDOHBzODRGMXovWWhCTm9JVHVQdG1SRkZBNHZyUW1oZ0hp?=
 =?utf-8?B?b0VSVVdxY3ByWVZod2hPNVZTZDBzdHBONGdORzVZdndPTFFCTmZ6dU9tWFZG?=
 =?utf-8?B?eStqcTZvaDAxSVVaMEZaVTJPU1FOS29DQWMzT0FIdjdSajI2cm9sMDJlUTZT?=
 =?utf-8?B?a0Rpb0pMUitGY1VscXowR3ZVdmFpL3dacmdVWVdFUUVGN2w2WjhXNXlQbng5?=
 =?utf-8?B?VndHbUxXaEdURjFsa2FZTkRnSjJBZ05SVi9SOGoyWm5LcENsZ0ZRS3BFM0xp?=
 =?utf-8?B?U2pLVDZOMjRNL1JRVk9JZkMwZm5TSElTZXg2YU5FTjE2TFkxRVNCSmFuY1hu?=
 =?utf-8?B?ZWdmNGsyNVhoVFg4S2VvR2gvVlcwNDMwVXp2Z04yWWlTWmNJVnlBZWhRTHVt?=
 =?utf-8?B?dkF1dzBpN0g1TEVZQkU5WHAwQzE1MGFsNk40Q1lCbDJRczZvYVVhUWkzL05y?=
 =?utf-8?B?VUZ1T25YeU5UamZ6NXlocTlCWEtuN3dWdjYzcTQ2ZDFQbFVhdTRoUmcrNi9q?=
 =?utf-8?B?dVlNenBZbXdCR29Obm1sZktmTDI5UzZuVFpwdzRDeE5TZVF6RlZGdzV4QmY3?=
 =?utf-8?B?VjVtQTQ5M3dqQ3BLRUlVRXVUNnJvdkhPZ0owR29XTy9RY2FmNitsZC8zazlM?=
 =?utf-8?B?dE5ocmtFOFlQaDZTT0JGZmNLcGE2eFgreEZIc21OM2ozVmo5Nm1KS1YzM1F2?=
 =?utf-8?B?eFNSVE9GRCt6ZVZBclFucWFTbytHUFVibHVlYThyMmRkdStBVHNveDFqd1Vk?=
 =?utf-8?B?clVqdkNoNGt1dGh5eFZyazdzazQwSGptaERvODlRa0NXdDA4RkNuM0pCUzJs?=
 =?utf-8?B?TTFxRUQwMWJpeURQdlF5d0pzWkdoK2FBYjYzc0d1RFdSZjNnOUtrKzBlTndR?=
 =?utf-8?B?aE5OV0VjVUFpdnR4eTVnNnhrOHo1WlJFZ2VpNUpwY015bm5EMTJURzVWVW5h?=
 =?utf-8?B?VTV6N3ArQzI5aUpWRmk1VUlRdVM4Y2ZmR3RQWmRtaThIM0V2Z2h5WHRqT3Nz?=
 =?utf-8?B?QkNwNURvRFZjdkJzd3dGMTlOQlRDdlRvZDN3Zm9tN1d4OVJRMUdmSENkUDZq?=
 =?utf-8?B?MVNoWUxPekduZXBtS3hnWk1ILy9RckxMMzJrYW1Ib1Rka0p5NlNsUjQ0ZTdV?=
 =?utf-8?B?c01qSHhUV3pBN2N4UWNFVW9MaWVaaGxvaThsZHgyeDJ4bUFvMnhRSUpNb2Rn?=
 =?utf-8?Q?QqVEQNOzwOwHq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTd1clJieDB4ZlZTVDlSTEt4QUdyV2tpYklyOUZ4R1Yxa1QzSzVucGE1N2lI?=
 =?utf-8?B?dHI2L1ZOTDRnZ05ROFhWZFhtOERUZzZiaWluQk1yZGp2SEFRV3VibEUxcFBt?=
 =?utf-8?B?WFB2ZlJHZUJLcGZNaXgzNlNwdnVOc1VMK20yeGNXNGZUL3JDRXY2U0RRSkZk?=
 =?utf-8?B?NUlMemJDaktqaW9HT0huUm1HK1BpcGJMSndySFVwYWtXNzhWUkpCU1lMdjhW?=
 =?utf-8?B?OTBIdmhLN3UvZmhDMElPeERVa0FCVjROMzNraDdJVm1FanBlNVJGTC9vT1hI?=
 =?utf-8?B?bTY0WnNtM0cwSllSamtEVHFrRFlKVWhSMG9jd0pFY2VtN202aml5a0pnNFpJ?=
 =?utf-8?B?ekYrc01FSDJ1Zzg1ZFoyUzRQTERzYWRHdnp2UVVyK1BlK0NJcWdCWmNMWGRW?=
 =?utf-8?B?ay85Q0VGSnRwMUxuL1ZKek05SCtxREZWa2N3clorSGZWUDNjaWNidjgrZEoz?=
 =?utf-8?B?VGw4Q1pCZ1J4MWR0czE3WkpuL3RpdHJCTlBDQ24zWGVrVE03VUxId0tLQ3Ro?=
 =?utf-8?B?R3V2d3RTQnRPc3dOUXdxbStIa3VFTEtWSERXU3JUU1k2OU5TTkZhYWZLQ0M2?=
 =?utf-8?B?ZFNYdnM2TURLd3B6cFNyRldwVlpQQm5tR3dDam9TQXhYOW45ekdTT1h0dDFN?=
 =?utf-8?B?THo5WFJVSXZnSkVvcytuWktPYjRaZVdPWWxSMkp5M2twTjZ5TDA1MlJ6cDZB?=
 =?utf-8?B?a2dFME83ZVhURms5bGFGRzhaTFQwQldDVWZIWVUvSGQxK2ZiV2UzK0djMTUv?=
 =?utf-8?B?czJLQ0orbUJtL2QraXVxcS9IVTcwZDJQRUw4cDYxamhHMHJ5eDhXMm95ckZn?=
 =?utf-8?B?MEJhaTJEWVh0VU5kc2hJY0hMYU96M3BqaklVdU1rUmo1WmkvdWdBSG5qcHRJ?=
 =?utf-8?B?NWlScVl3R1lCN3psZkZ2NGQ1SC91RGhQOUp3a2ZQN3pIKzJacmkzT3JlZlBa?=
 =?utf-8?B?K0ptT0phUGRkNytNbUkyVXB5Mm1IZmV2UnhBejlSbnZ3enhLQlNLNUtOSVl1?=
 =?utf-8?B?WW0yNGg3dFgrOWp3RUUycVlIYTlZNUtRcWR4N3JsWDlNeS80a3VQbThOSWIz?=
 =?utf-8?B?cWNOT0doN080MTYxMUo5T1lTQVlCbFlrNUtIMXJwbWF1KzBRZWM1Zld2cGU1?=
 =?utf-8?B?TEdleHNwbjU4SWcwYVZsRG13M3NCak5GT1RuK29FVVpoUWZZSm14V2drUWxk?=
 =?utf-8?B?c005Y1BFZ1lJcXQ1dnVOWkxiT3BaK2dlaTViTWFkemlCVkowQzQ2VVd4YktN?=
 =?utf-8?B?RW84SkRxVjhXaWRSMDVHMElVT1B1U1UxaXM3elhSa1AxYjVEU0x5eVV4c2R0?=
 =?utf-8?B?Vll6eVI1YksxVGhrQmkrbjhpK3BNUzJibDBHSEU4SEpQZFg0bmRETXVvRVJq?=
 =?utf-8?B?WWJveExYejJ6NkhNR2JESFNwS0x1NC9laTMxMW1XcTFTNU1GOGZXTG1JSGdt?=
 =?utf-8?B?M1oxOVNCT2VCZnBCZlpmL3loMkdOL0Nndm9LamtIampLck1kQll4enp3VlZW?=
 =?utf-8?B?amFQem5lL0hXcW15YXhTdEdCTzFyOXRFVkpOa0ZmcUxsUjQ5c3pwY1VTdlYz?=
 =?utf-8?B?MGVzbTl3bDVhMlVFbnY1a1dRdm1qb0hqTjBjU3NVTDdOMzZodGlKQXlwcmxm?=
 =?utf-8?B?Z3VMb1ovUnM4VUswSVNIbGhnS2dGVnlXbE40VHJIajBLa0FhZzhVQTdKbWZY?=
 =?utf-8?B?dkVlZDF4NUVTUUM5aXh4OElUdWREMWpOQWRYOUJiK25EbjlCaFhYdVRLUjlL?=
 =?utf-8?B?eHhDN0JldVNkV3ZYeWFaOWlNRDNZeWdJbFFuU2U1UmIzYksrbkYydnhsVzFr?=
 =?utf-8?B?aGd6bW9PQjc4L0ZRS3FSN1MxcGlqZ1VkcUtkUVluSkcyQ3N0WnZsQkJ5cXdw?=
 =?utf-8?B?d2l3d1dZL1QyRHQ3L0RqUUYwS0dpSXhMblRXRitqVlV5SEVkdkF6Z1JvMVJx?=
 =?utf-8?B?Q1k5Z1JRS256RGV5ZENmOStKNkRIYmVWWmxvTWlicFVqOThwYTU1TUVCOENk?=
 =?utf-8?B?b3RUa2c1U2NiTU1IM3psYWdVa1Fjc29wK0REelBLN0hSNWN0NEVyQ0hOU2or?=
 =?utf-8?B?d0ZEMjlLQmswQy9ULzhLYXhCZUVuVGc1T3VzYm8zdUxoMnZmQU1NVlR0ZThv?=
 =?utf-8?Q?0IflXjHtFtBMxLFSnDZ6UNG1U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b44a4b3-261e-4ee8-9477-08dd4bf884ba
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 06:34:51.0996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 039WEEmGvPLu8ew91mQBmbXd6SNXALMxZqib346FarcxrMBOz8OaxTLBP12loFyA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5985
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



On 2/12/2025 9:27 PM, Jonathan Kim wrote:
> Deprecate KFD XGMI peer info calls in favour of calling directly from
> simplified XGMI peer info functions.
> 
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 42 ------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  5 ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 51 +++++++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  6 +--
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c      | 11 +++--
>  5 files changed, 48 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 0312231b703e..4cec3a873995 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -555,48 +555,6 @@ int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
>  	return r;
>  }
>  
> -uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_device *dst,
> -					  struct amdgpu_device *src)
> -{
> -	struct amdgpu_device *peer_adev = src;
> -	struct amdgpu_device *adev = dst;
> -	int ret = amdgpu_xgmi_get_hops_count(adev, peer_adev);
> -
> -	if (ret < 0) {
> -		DRM_ERROR("amdgpu: failed to get  xgmi hops count between node %d and %d. ret = %d\n",
> -			adev->gmc.xgmi.physical_node_id,
> -			peer_adev->gmc.xgmi.physical_node_id, ret);
> -		ret = 0;
> -	}
> -	return  (uint8_t)ret;
> -}
> -
> -int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *dst,
> -					    struct amdgpu_device *src,
> -					    bool is_min)
> -{
> -	struct amdgpu_device *adev = dst, *peer_adev;
> -	int num_links;
> -
> -	if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 4, 2))
> -		return 0;
> -
> -	if (src)
> -		peer_adev = src;
> -
> -	/* num links returns 0 for indirect peers since indirect route is unknown. */
> -	num_links = is_min ? 1 : amdgpu_xgmi_get_num_links(adev, peer_adev);
> -	if (num_links < 0) {
> -		DRM_ERROR("amdgpu: failed to get xgmi num links between node %d and %d. ret = %d\n",
> -			adev->gmc.xgmi.physical_node_id,
> -			peer_adev->gmc.xgmi.physical_node_id, num_links);
> -		num_links = 0;
> -	}
> -
> -	/* Aldebaran xGMI DPM is defeatured so assume x16 x 25Gbps for bandwidth. */
> -	return (num_links * 16 * 25000)/BITS_PER_BYTE;
> -}
> -
>  int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev, bool is_min)
>  {
>  	int num_lanes_shift = (is_min ? ffs(adev->pm.pcie_mlw_mask) :
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 092dbd8bec97..28eb1cd0eb5a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -255,11 +255,6 @@ int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
>  				  uint64_t *bo_size, void *metadata_buffer,
>  				  size_t buffer_size, uint32_t *metadata_size,
>  				  uint32_t *flags, int8_t *xcp_id);
> -uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_device *dst,
> -					  struct amdgpu_device *src);
> -int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *dst,
> -					    struct amdgpu_device *src,
> -					    bool is_min);
>  int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev, bool is_min);
>  int amdgpu_amdkfd_send_close_event_drain_irq(struct amdgpu_device *adev,
>  					uint32_t *payload);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 74b4349e345a..d18d2a26cc91 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -818,28 +818,59 @@ int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_dev
>   * num_hops[2:0] = number of hops
>   */
>  int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
> -		struct amdgpu_device *peer_adev)
> +			       struct amdgpu_device *peer_adev)
>  {
>  	struct psp_xgmi_topology_info *top = &adev->psp.xgmi_context.top_info;
>  	uint8_t num_hops_mask = 0x7;
>  	int i;
>  
> +	if (!adev->gmc.xgmi.supported)
> +		return 0;
> +
>  	for (i = 0 ; i < top->num_nodes; ++i)
>  		if (top->nodes[i].node_id == peer_adev->gmc.xgmi.node_id)
>  			return top->nodes[i].num_hops & num_hops_mask;
> -	return	-EINVAL;
> +
> +	DRM_ERROR("amdgpu: failed to get  xgmi hops count between node %d and %d.\n",

Suggest to use dev_ function to identify the device pci number. Since
the function still passes, maybe info level is good enough.

> +		  adev->gmc.xgmi.physical_node_id,
> +		  peer_adev->gmc.xgmi.physical_node_id);
> +
> +	return 0;
>  }
>  
> -int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
> -		struct amdgpu_device *peer_adev)
> +int amdgpu_xgmi_get_bandwidth_mbytes(struct amdgpu_device *adev,
> +				     struct amdgpu_device *peer_adev)
>  {
> -	struct psp_xgmi_topology_info *top = &adev->psp.xgmi_context.top_info;
> -	int i;
> +	int num_links = !peer_adev ? 1 : 0;
>  
> -	for (i = 0 ; i < top->num_nodes; ++i)
> -		if (top->nodes[i].node_id == peer_adev->gmc.xgmi.node_id)
> -			return top->nodes[i].num_links;
> -	return	-EINVAL;
> +	if (!adev->gmc.xgmi.supported)
> +		return 0;
> +
> +	if (peer_adev) {
> +		struct psp_xgmi_topology_info *top = &adev->psp.xgmi_context.top_info;
> +		int i;
> +
> +		for (i = 0 ; i < top->num_nodes; ++i) {
> +			if (top->nodes[i].node_id != peer_adev->gmc.xgmi.node_id)
> +				continue;
> +
> +			num_links =  top->nodes[i].num_links;
> +			break;
> +		}
> +	}
> +
> +	/* num links returns 0 for indirect peers since indirect route is unknown. */
> +	if (!num_links) {

This looks problematic. I guess, it is better to keep the old way of
passing min/max. Otherwise, there is a chance that min reports some
value and max could report this error.

Thanks,
Lijo

> +		DRM_ERROR("amdgpu: failed to get xgmi num links between node %d and %d.\n",
> +			  adev->gmc.xgmi.physical_node_id,
> +			  peer_adev->gmc.xgmi.physical_node_id);
> +	}
> +
> +	/*
> +	 * TBD - will update IP based bandwidth later.
> +	 * Bandwidth currently assumed to be x16 lanes x 25Gbps.
> +	 */
> +	return (num_links * 16 * 25000)/BITS_PER_BYTE;
>  }
>  
>  bool amdgpu_xgmi_get_is_sharing_enabled(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> index d1282b4c6348..325e7972469d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> @@ -62,10 +62,8 @@ int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_dev
>  int amdgpu_xgmi_add_device(struct amdgpu_device *adev);
>  int amdgpu_xgmi_remove_device(struct amdgpu_device *adev);
>  int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate);
> -int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
> -		struct amdgpu_device *peer_adev);
> -int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
> -		struct amdgpu_device *peer_adev);
> +int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev, struct amdgpu_device *peer_adev);
> +int amdgpu_xgmi_get_bandwidth_mbytes(struct amdgpu_device *adev, struct amdgpu_device *peer_adev);
>  bool amdgpu_xgmi_get_is_sharing_enabled(struct amdgpu_device *adev,
>  					struct amdgpu_device *peer_adev);
>  uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 70b3ae0b74fe..a787d192390c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -2133,8 +2133,8 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
>  		bool ext_cpu = KFD_GC_VERSION(kdev) != IP_VERSION(9, 4, 3);
>  		int mem_bw = 819200, weight = ext_cpu ? KFD_CRAT_XGMI_WEIGHT :
>  							KFD_CRAT_INTRA_SOCKET_WEIGHT;
> -		uint32_t bandwidth = ext_cpu ? amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(
> -							kdev->adev, NULL, true) : mem_bw;
> +		uint32_t bandwidth = ext_cpu ? amdgpu_xgmi_get_bandwidth_mbytes(kdev->adev, NULL) :
> +					       mem_bw;
>  
>  		/*
>  		 * with host gpu xgmi link, host can access gpu memory whether
> @@ -2198,12 +2198,11 @@ static int kfd_fill_gpu_xgmi_link_to_gpu(int *avail_size,
>  
>  	if (use_ta_info) {
>  		sub_type_hdr->weight_xgmi = KFD_CRAT_XGMI_WEIGHT *
> -			amdgpu_amdkfd_get_xgmi_hops_count(kdev->adev, peer_kdev->adev);
> +			amdgpu_xgmi_get_hops_count(kdev->adev, peer_kdev->adev);
>  		sub_type_hdr->maximum_bandwidth_mbs =
> -			amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->adev,
> -							peer_kdev->adev, false);
> +			amdgpu_xgmi_get_bandwidth_mbytes(kdev->adev, peer_kdev->adev);
>  		sub_type_hdr->minimum_bandwidth_mbs = sub_type_hdr->maximum_bandwidth_mbs ?
> -			amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->adev, NULL, true) : 0;
> +			amdgpu_xgmi_get_bandwidth_mbytes(kdev->adev, NULL) : 0;
>  	} else {
>  		bool is_single_hop = kdev->kfd == peer_kdev->kfd;
>  		int weight = is_single_hop ? KFD_CRAT_INTRA_SOCKET_WEIGHT :

