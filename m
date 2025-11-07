Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C71CCFA05
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 09:41:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 990BB10EA53;
	Fri,  7 Nov 2025 09:41:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="znukjv38";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013035.outbound.protection.outlook.com
 [40.107.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE94310EA53
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 09:41:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JRP76lnLQPj00fCapiZgHaQ97XbRjG6V1Gl5ON8b12fNbOmEqdvGgw8W/lTPXbAFVxsgmen5pd/BekggLzZz1CGa/VITkPUmfiGGiE1dBHW11tjXYiY3EUgVTFxdrtOOmQmwwwCF2NNoHZK3iXWY6Ir/BA9E8cYMi2+VQTIlkDbgmLW9EWQt5xVam1q3vkd8A1+ZILsDdYL9qDBcVnaFGWoc/QdaYeQu0xiPerDjPU87D3D4XH0Xn933w5ujB07FgCeP4SYyAVCc7YREYXrr3AaUYlYikVRjF4OutxfSlQmsMtEkjxQ0NF8iWlR86y7fNFGmyKB+THwTPAskahk5VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyhmuW87ybSNChg03LIBAV8E9SK/+B1tGqh8mtpDgBc=;
 b=Y6ApznwDSuJKFeFjYs42gVFuitKuTUtNLTpEdZDCPAzt7wG3CisyN8jduqWFjEtqjQEMCl0wwlBdJb6tKDwJaNfcAoMIrmQEgAwl3oS6pSlQw6IldIOoDpezfYo3VQcJYbgkSYV+d0vXxNSBLCEaL4j4YVJKG4oqROC6JdtDIg3tFCarf8tSmKEkL2uQYrUuQVC2WgjtmwNxykDHqhTfs7G9TvO6ZP5oQxMU/6QvrcIecFYUvLqeY5lsq482tEVtHKqKJGlYiBrVDEocJQJLYrtGVQYJqakbPAuv41J8lLvxRCsOFx4M+EL2rDln9CiTC7mBQ2Nz0CxBORzpkl8v+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyhmuW87ybSNChg03LIBAV8E9SK/+B1tGqh8mtpDgBc=;
 b=znukjv38jvFAxHSIhMoc2lgkkhRT1uFFoGb0fwIelwU82oM2Bd11cvCRlFZkT8OyPHydFhIEe0erexHRiSmE8dZ/Yfo71D3m0fJh5qIc/iX1DzpY4Nu8vPj2XM+VgOmEbl1nVQu2FnVz1SXsPy5OnhO4oU2CriaNOnj0cn9/JBY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB9203.namprd12.prod.outlook.com (2603:10b6:510:2f2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 09:41:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 09:41:47 +0000
Message-ID: <628a4ef5-c8ad-4f29-904f-b98dc67f64e4@amd.com>
Date: Fri, 7 Nov 2025 10:41:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] drm/amdgpu/vce1: Workaround PLL timeout on FirePro
 W9000
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
References: <20251106184448.8099-1-timur.kristof@gmail.com>
 <20251106184448.8099-14-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251106184448.8099-14-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB9203:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b731995-cf19-48db-df7a-08de1de1dec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZER6d1J3OURFTkNiMEs5enUzdkVXRWJpaGdCdUtjZEN3d0VKbmNuWGhVSGpS?=
 =?utf-8?B?Nm15Z2F3U0U5TDVpcHFXQ0daN3YxUjg0NW1SOUk2TjMxc3U5QzhqdzBHa0RF?=
 =?utf-8?B?TUhpcXdTRFN1TXlPSlFoQVloYjZBb2ZqcVNpNC80V1ExMlBtRjhkcDdwY09q?=
 =?utf-8?B?ZjNXVUdKbWg2UW9JZmlRYWVabHNLWVV1ak9GVFA0cHNqcWJzSTM0elhlcW9Q?=
 =?utf-8?B?NUtPamdCbVRDNkJuTFVRQkFlWllpWUZBSmVMYVhoUVl0MENpdWd3QnQzSXBh?=
 =?utf-8?B?RFVSeHQ5dDdaNTZUdk93NU5KT21oTnVidExYdXozeXNZTGQvd2dQbVdEV0RM?=
 =?utf-8?B?dllubFFmSGtPWXp4MW1La0RESG9EOHpNK1BQa1lXZkZNay9kaUtvRUR4aFNn?=
 =?utf-8?B?ZVF4Y0paSVZuQXhmZEVCdmE5Smh5dHVWRm5LTVFWd3dDUWdFaDMzTHhPRmhm?=
 =?utf-8?B?N0ZieVkra0diSzVkWTlPMGJ2ZEI5UEZXeDVMVnpOM2NOVjVxU3FwTTU4R0tP?=
 =?utf-8?B?am4yelJudlFnUm9kSU9mTVNBMzA1akxhQmJ2UktzYVR3Wmxrb3RISWF2YlE1?=
 =?utf-8?B?aCtMV3czaEVMblVGc0VCVVV1UlFmZGNoZDg5UUJFYXNqdFFEeG9rdEU1ekVI?=
 =?utf-8?B?WFpXLyttQlhxY0Q2OXpXUTFIUjZETTNHUCtDemFzQnpXaUFXUy9VL1lGb2RB?=
 =?utf-8?B?QlA3NTJQSThTbFE0aGhZSmdjSCtTVkkrcHVla0pmcXExOTZMOVJKM1MwZlNE?=
 =?utf-8?B?TTRyRk5zRVlsRUcrWm1ZdTd4K3paVm5Zd1FrbHBlN0V5ZktmcElUQlhqTWVy?=
 =?utf-8?B?WHJZYmJkSlQ3cTJlSnFEYWY3dG50MzVCRGlldVR0OXoxV0JaakdpZVNTYVhK?=
 =?utf-8?B?cGtBTHNtTHlFbUM5UTRiNkYzTWRIUnQzeFo5YnBMZ0VPVHA4RGhDdTdKZldo?=
 =?utf-8?B?OFBGZWhFUm1TN2tnZjVrVUZSN2FWTVNRUU8wS0pleFdNTHdFODhYZjlONlVp?=
 =?utf-8?B?QTVwbU4rTDdZNEpjekhmNXVSWXlMSEd4ajRKTmdWQkExTGtnVUdlTThYYVk0?=
 =?utf-8?B?U3R3clBlS010Y2x4UGo5dlBmRGdhblM4dHRQZlAwcW5yUzF4aXB6Nm9kc096?=
 =?utf-8?B?TjZYWkg4dkV5Mk5uWUZBc0JnWWoxWUVmVlYvZ1RURy9SNUUwVWpKZ3ljb0Fr?=
 =?utf-8?B?UExhSDhsMmhFR0FBbGUyMndwWWc2SUk5OTQwQWlRYm8yL2dYZ20xd2RZQnlL?=
 =?utf-8?B?SVdTOHRCUEtEbjFMc05lZ3ZtTkZJUGk0RmlPazdkY1lpeW9ka2FlRWI3VTZU?=
 =?utf-8?B?ZHAvSGZWSGUxOGZmZjlaZTBycS85UXRlelZESXl1blROSzRER2VmUDRTbkJX?=
 =?utf-8?B?eVN5OGhnc2ZxQjlSZnZTSnNoclpVWDdWQ1JTczVUZEFWdlY2TzRsTEk1NEFR?=
 =?utf-8?B?WE1JdCtIaXRqSEtabEFDZUc3ZTN0V0lENkw1NVJ6YWdWSnk3Zk1JR3hJdGhH?=
 =?utf-8?B?cGp0aVR2Vi9IT2VaMTNkMTYvNWExVEFFRCtIOTkza3FMamEyVVhjYmlrODhu?=
 =?utf-8?B?WEEybk1HRTcrK2JKMzBUUWVScnA2VGYxTjNhY2pUU09jYXgwVGZacW5rSzgr?=
 =?utf-8?B?ZWcwUUxyUktIeHhqVEthK2ZJaFJ6ZDd1QnJyYkd0dm1GZnRMbUYrZy9MdGhM?=
 =?utf-8?B?WlQ4MzBVYXNiSkdMczBBVzhkZEM1S3lvUTM2T2NSRm5WSXovdWlOWk0vL2cx?=
 =?utf-8?B?THlFeU43ZnpSSGxiTDJVaEI2dXBEd0Z2eGxFeDBmeURzWDBPRG5tQlV5RmU3?=
 =?utf-8?B?N3I5bzR1VlNRV2NKSXRrRXZHR3VzOGxUZHYyQUMxWUVUVGd2SnlqWXVCV0xN?=
 =?utf-8?B?QVFQdUtaSm9GRHFhVEpxV29samw3NzYyTjNKRyt3L2RuNndFK3AwNjNXMHFK?=
 =?utf-8?Q?3d5RS3OkNuODQczCOlFmniApBD6qoX8/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnRadTVuSVgvTnVKVGloZWxSeDFieUNtQ0VMTlh2OW84TDhienBCaE9jNWJs?=
 =?utf-8?B?L1Y1SmpiVzh2VnZTZHJCUFVJRWU5cFFOVE5rYnhkcjZqMk5GWlErbWpjMEo4?=
 =?utf-8?B?WkFIdTRHTXRETzIxaTdqWDdDNnh1Nk9uMUxzTVlQeDlxMmdHQVdYN0JDYjVK?=
 =?utf-8?B?cEhoRENQM3dnaGJhcmNKS0NPWUh2M01vOTNzcDNEenN2TkRwV0hBYU9QcFRR?=
 =?utf-8?B?TVhNSG4yUDJnUkxSaTdGQ04rVVY1Qk5jN3JnRER4MnJneVZuSmhHREcyUVdD?=
 =?utf-8?B?V3hEZkxwY20yem1xWTQxd1ZIdU9HVDBpZmJxRVNLNE1pZ0JHNlJZbi9QbmIv?=
 =?utf-8?B?Si9WMVg1TnV6azBkN0M0bVZFVjFiVGtGZTVFQW5sb0tFaVEwNXdYRTR6VkJX?=
 =?utf-8?B?NTYrQWl5Yk5FU1U5MVVzSkZINWthYlo4Sm5uQ1p0K3RGMWlaRmxiR2JsV3lG?=
 =?utf-8?B?S1A5eUhEVHMyYkZkSEtOWXV4RmsxeWZGTGRjVlRMRU5hcWtmVHBZeW1raG80?=
 =?utf-8?B?WGo4UWVnbUZFQXorVEVmeEx3cWk5amppN1RLQnpUSWh6cVhERzAvOVUzNE5M?=
 =?utf-8?B?QnM0TjhBTU5kbjFGQnhvdmpCbmFjRDkzaHVRcFIvTzErdVFiWGswV0ZnUmRD?=
 =?utf-8?B?Wk5ibGpuZDYvb0h5ZjNmc25EeDFvYkVVeEtvbFlyb3VRMmZTNjdHMDlTUFRx?=
 =?utf-8?B?Y1VYWWt3QkI1b2RydDZpMTlScGpUVFFNUlorWVNDKzNWZDRhdlJHcmhXWEU3?=
 =?utf-8?B?a0h0enQvejBLNERQNUdaR2tpT0hQMzhhSHVHdDB0YzMxUG55ZnowOVY5VE9E?=
 =?utf-8?B?a0NpUGxFL1dLVHV5SlZrYnp1M3pocWhiVXp1VTFFdk9ISzk4cGI2dE9IZ1dJ?=
 =?utf-8?B?WU9LNjZsM1o4L3NSUFBQSjd1Skx2Tkt2bDlHL3dnUnpRYTNyZ0piR0xpQW01?=
 =?utf-8?B?NWlvaFRnYVJYT2l5QWZQOU9NeFdQMTI5T3ExYmxrQkVERityR09zODN0RWZo?=
 =?utf-8?B?Z1BCakZyUFNDaXJzOHdpY0p1V280azFrNlZsWDNEWmdxdTF1blkycy9GZHEv?=
 =?utf-8?B?T1g5czF4ZDFMUDlSUEZ1R01WZmV1RmdDeEFHUnZBSmFSc2Nob1VVcE1HTVN0?=
 =?utf-8?B?eFdkMHNrUGY4eXAyWW5tT0VGY3h4V1JFRTBPeHIzc0pvaVdKUGtITXNDa0VK?=
 =?utf-8?B?Q1pxUmMvbS81SDZsV2cwMWVkb00zSGowbXc3bklJVVJlUE00YTJhVG40YUlY?=
 =?utf-8?B?TEtIano3WnJCVEF6VTd1T25rRWE3dVkxMjd1UGgzRmRQdWxpWHRvM3YvTTVB?=
 =?utf-8?B?YlRvb3lPTjlvaHNxcEZBNzFzajRnT3o2UWtJUVlVZ1E4TFZFZHdHNms1TUQ4?=
 =?utf-8?B?SDFTTmQ3R1UyUGI0YmlsNkR4U29jZ282VFdjcW00eVZVR2g0MUpQRjRXUHNs?=
 =?utf-8?B?aUh2TXZEQzVleFFSdVpZTjlGZDJIODczdVJTTXZaMm50bHVGbFhKVm93VWdI?=
 =?utf-8?B?T25zSWQ4SE8yZTR5REYwbjJDdXR1dmMvOTZta3duc3I3cVBuM2NDcEl6djZ3?=
 =?utf-8?B?RlE4ZUh0eDdXc2NqcmpGTG1NRFZtSHRQaTJ2STZKbjh4VzQyTzZaZGdMaldj?=
 =?utf-8?B?RmYyNlc5NlUxZkJxeFo2RlU3WGNZVVI1cVowUDcvK0x3SHNIK2RPRExubHdt?=
 =?utf-8?B?bnlWVE9GQTY4clRkRTkxZnJSUzltc0ZmVFRvVWNxVnpUZCtuR09ZQzV1VG53?=
 =?utf-8?B?Y2I2N3JvRTd2aGpvYTNMblgzR01aSnZqWkk2a2w3Qk84YW5yOHdJcnhxUUpS?=
 =?utf-8?B?N3dTalA0bUl6STJzMXM2bm1SdU1obmZIbUw3dmFDeXcwYjJJSFNGb3VSZ3Nj?=
 =?utf-8?B?ZHBkb3IxVmZtWFVpMkhLakJjV0g1S1lCNUNvY3FwbElJRlZ1eW1xZkgwbEk4?=
 =?utf-8?B?cWQ5Q1IvYmNUSWJQSkE4d2Y4MlZlUVZ2a2ZUVE81WnhnQms1MTFTU0NDN09S?=
 =?utf-8?B?NTBHS2tyVGZQdmFsbnY5cXNiWmpiY0ZNUlNtUUtFcVBLYTMyclQ5NTd6cGhs?=
 =?utf-8?B?Z2tyL2FvRHpkWXU4TFAyd2l5RG1pRE5zYmdDR1lkMlN2cHpoYVR6NVZVNkFL?=
 =?utf-8?Q?8I+ktLl3I7Mk0ByrH7Sldurjh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b731995-cf19-48db-df7a-08de1de1dec9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 09:41:47.8543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kfu78R+yELhzqETT3okNiz1DK7YZRX3YE/D3E8+eNHQnnh6QB4AW+M5osNHzGrds
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9203
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

On 11/6/25 19:44, Timur Kristóf wrote:
> Sometimes the VCE PLL times out waiting for CTLACK/CTLACK2.
> When it happens, the VCE still works, but much slower.
> Observed on a Tahiti GPU, but not all:
> - FirePro W9000 has the issue
> - Radeon R9 280X not affected
> - Radeon HD 7990 not affected
> 
> As a workaround, on the affected chip just don't put the
> VCE PLL in sleep mode. Leaving the VCE PLL in bypass mode
> or reset mode both work. Using bypass mode is simpler.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/si.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
> index 9d769222784c..f7288372ee61 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -1918,6 +1918,14 @@ static int si_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
>  		     ~VCEPLL_BYPASS_EN_MASK);
>  
>  	if (!evclk || !ecclk) {
> +		/*
> +		 * On some chips, the PLL takes way too long to get out of
> +		 * sleep mode, causing a timeout waiting on CTLACK/CTLACK2.
> +		 * Leave the PLL running in bypass mode.
> +		 */
> +		if (adev->pdev->device == 0x6780)
> +			return 0;
> +
>  		/* Keep the Bypass mode, put PLL to sleep */
>  		WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, VCEPLL_SLEEP_MASK,
>  			     ~VCEPLL_SLEEP_MASK);

