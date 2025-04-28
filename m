Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D73FC369D5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 17:51:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5552810E22F;
	Mon, 28 Apr 2025 17:51:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D7OtOn09";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A87AB10E22F
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 17:51:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wpP4ruvgTWi0Y7N0xOPguts9Axrt+1LycjxHkJUdpc25ZA53aUQ4HiuHZ6ELpHi5XtQs0Eaib32vLRcAMRntPqUMPh6zP36nkjmNlaO8SdiK2K+/T24cSWgZbMKcPvQnm+ZfP1xAY0MqhNo1+G+fA3YRWNhISfEucuv31VffEkgM4oQsP0Z5k01MEwdB9zUfSJZR5WE+yIKc+yxCFhocojJ83Gd+/A0hDjm1nLSy/E/NkKV7yLeBMDPhXfn5OI3/L70qAztlwejyxVnbQMgokW56iKwwC+Fp8m2ifX44lnCLgKc3c/ENGQf4rrlqXNXLdvwRrxVZk6FAnBZbaVVgqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGlFq+Go1TkpfaFmExN5s9tYbBpoc1blwNm4q+kkK8s=;
 b=FBDig+Ks9JrVWgQ9foFiIcnxTLVflLTA0oF5iPLtYz0vbwXIdRsF6h5++Q+1z68a1u/N3GvhuGw9Iv2snNlFRzUESE01VbA4N6ZPfRR89HPSg/33ywJpuWawF0jMpq/UZ0qE02t/wDtmMolxpgGbxwHkt2Ww063Od21eK4tc8S1UIvBMFFxicjZiftt/lm5aSJddyRhJimkOzl5b2Xhf5SlgcDuJ9cqm4cLAQtLwO015oqeLFi+Y9c9gn90vWNTDnN+1eLAXbXf3eVJAlqjSYsuG1bu7l6+lzM8/ItiHwXgPHGx11+vzRIIll3rtbQBDJTwuKPDDNJ4+dnfRYsfKKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGlFq+Go1TkpfaFmExN5s9tYbBpoc1blwNm4q+kkK8s=;
 b=D7OtOn09L6osQDC2AWgbmiB45FSx/UzFOKzrSTAVVVGizTNcfJmo7w1e5Iaup8cJu6xMT1P4zCB0w1z/NseK6e77bAgTE+MQXS8eqd/SSRQpNNlJF9ioRf6HmvkED8Z8tDExxdkuEzhnkB34x3IL6ewEVuhaOyKPq1QZnqAnfO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7842.namprd12.prod.outlook.com (2603:10b6:510:27a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 17:51:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 17:51:36 +0000
Message-ID: <79b1950d-436e-40bf-a9f1-1bc1974f42e0@amd.com>
Date: Mon, 28 Apr 2025 19:51:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: validate the eviction fence attach/detach
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250425070730.4033803-1-Prike.Liang@amd.com>
 <20250425070730.4033803-3-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250425070730.4033803-3-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0de944-13ae-4be0-a56d-08dd867d522b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmNMdnp4V20rc0Z1NkFwSG5aVmNxSVpGV0x0R3UzT0lkeTdnY0lBeVZOSDh1?=
 =?utf-8?B?b042eXlrOGpobE13T3hHVStJM1NNNjQxeUx5ekpiakFaV0pZVU9mWDNzNHVU?=
 =?utf-8?B?Sm4yS1R4dko0TzJacG9Ga3BFbmNLRzF1dlZYbGUzMy9uYWROMzJqV3lmQ0NW?=
 =?utf-8?B?dWJHYkI3cEUxOG9aNmN1WFVKV3Z5ejRnS2JtdmdWb1c1NThOaXVFamNUMWYx?=
 =?utf-8?B?TGdYcWRHZ2JnTlovSlJqVW5pZGJkaTAvU1R6eHJzNWhRODBsa2lXWE9FcC9p?=
 =?utf-8?B?eC9VSFFxbExGejRaWGhlZHJETHQzNGludW4ySVN3RTI5SkFxY0psVzFGZjV5?=
 =?utf-8?B?dnNscXJPb25HUm1BdVZtcStvb2lrQkQ5YTd3NWs1Wk9SN3RlcEIyaTZIQlNt?=
 =?utf-8?B?NGVBaExlYzZ4d01UMzRmZGRSKzhPSGR5SXRIcUZzSTR3UG1DRGp2dVlOYUhS?=
 =?utf-8?B?V28zcmsza0RqTXBPTWNLRWhzckcrUkRxMXhQVXhuZm9IVnVhaDJlZi9zNlZI?=
 =?utf-8?B?Vk12Q2ZuNXZWbVJhbVFUQXM2VG93MzZlSWFIZG1sUVZOZ1J6R2FSK21vaHY3?=
 =?utf-8?B?LzU5TWFXYk1GN09zQm02emJrR25PSjNqWWVMd0srQk8xL3hGbngxM0pPa2RO?=
 =?utf-8?B?cngxSEc5emI0WDkvSmUrMm1BMDEwclg5dCtXcWpEa1JROGtoUmpLQ05wZVpK?=
 =?utf-8?B?USs4Z0pDTzdrelVUWnVDZFV5d1VYN2lRYmZicHVlbWtaQnRUUUlTZW1jTmUx?=
 =?utf-8?B?TnlNOUc4dWdnbDR1WGN6dzBoTEhXWThnRSs3VFNBZDJpTUNMZkNITFdFbUh4?=
 =?utf-8?B?ZTVlTmdMaTVXWnExaXNiaFBjVXhJV2hOTitnQlRkWTFwNEJkVldvb01SQjc2?=
 =?utf-8?B?bWp0SHhVVG42NG40cldRK2pWMWRzMUNuWWdSeDZNQjBmaEhqTG5BSGovUVRu?=
 =?utf-8?B?R3FlNy9kSjJrRERvSUFadWZUSzdVTFIxSC90eEI4UDN0Tk03Y1BTa3FtdTJB?=
 =?utf-8?B?b3dUNWk0UkdMbzErbmxnNjFuQXVtL1ZhMTNRT1EzR1IzRTE3Qm9QakFlWVhB?=
 =?utf-8?B?aVFnYWpLd1M4K2s1Zm10SlhJYmlLVERGOHAzZHhXcW5kSTZRekVDaE9Obk1m?=
 =?utf-8?B?RmRUS3VLOEJhQWdFbW5xSnBJeXNFckFYRVZwMDVPTjJOYVdnck5ML3luQkJa?=
 =?utf-8?B?MG10M1QxakdzS3F0UWs1UWVOcHFrRVlKd2UwRHBrS0UwODBYQjV2V0JheGov?=
 =?utf-8?B?Tlh6dHF1bFBLSE1vZkp4N2x4K2lyM0RmWjlBUThYZ3R4UlZ6Y3Nkb3VEUXp2?=
 =?utf-8?B?RzZjejdESXM0SEFOSTZidkx0Z1NadWFPYWZjaHpOc3VUYWhpQzhGSi9lNDAx?=
 =?utf-8?B?TC9GU2xNd2JlSjVFN0NqaDFSVmF2RHYweHpZTTdQbkdMbHFiSDNNOHAybXd5?=
 =?utf-8?B?ZDR2aU52ZThvRjJCZk42YWUxVW8xMnp0ZzdubkpSTTBDZGVTL2plNVV5d0JI?=
 =?utf-8?B?QWw2dGJVR0IrdjBaN2hSd3ZQWEJkZGxTQjVLZ2IxWWhncHJNWUNEeUFEcEdY?=
 =?utf-8?B?dEVCZ2VYS25aTmREYWIyR0RBb2ExQjNVdFJvenhCemNRakl2b2pocDJ1cG85?=
 =?utf-8?B?b015c2JTRndJYkhXaDE4eTEwOTE0UDhmSGxLellpR3ZEcitQNmYrREN0QXhp?=
 =?utf-8?B?OXRWSVhXQzNrL0pzamYveWxxQ1JpOThKeHpXV05uTUU1SGkzUjU5YStwR1po?=
 =?utf-8?B?U01EbmVIQzJZa3pwYVo5OWJSM0NXaDBqaGlhVnplc2RkQXJGM01pNHMwRHNI?=
 =?utf-8?B?TE9vMS9ENkVOZFhwSkIvamRVb3k4TVRtRDRRSEdBQmozeWdHdEV0cjF6VWMv?=
 =?utf-8?B?QTJIZWtPendnK3JxU2xGSnhzbHo1WDIrQXFLV0l3TGllSldCMFkxQ2Q5cHZl?=
 =?utf-8?Q?LRqWegWzWrs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTYvM2ZCbDltVFBFY2xyMVRBakdwUG9aSXZYRXdwY3J1cmhSYjdMbE00ZFpi?=
 =?utf-8?B?NFBJYy90bUQxOVVYNFdTZ2JkWTFtb2l5WE9VL0kxd2V4R1ZyTFhaNlFHUkVC?=
 =?utf-8?B?Vi9kaWd5TGRhU3I3VWVtaDF1VFk1bHkzZFZFRVpsUzF6bU1CVjJvOEx3Nm9U?=
 =?utf-8?B?UGltamdTUEFGNVhzOXpYdUtrS0U2WTF4TEZxbXNwN2JpUzlwMkU3cWdDNndK?=
 =?utf-8?B?RzRTdFphWE45RkhIZFJZcjMwWm82R3RJR3VEZjdtbG8rZFVJWjIyS0lFN2pm?=
 =?utf-8?B?ckdjMEg0bzFvZHVYT3dnNzE0eWJmWkdDOG5kQWhXbVBpMi9MNm9CbUNMNGdn?=
 =?utf-8?B?QW5GRUkvRmNhdTZseS9MRXBHeTgybEw1ajFnVlFoaVdtRmxxYVMxYnRsYTFE?=
 =?utf-8?B?eDFHWHBQaFRCZDd6UlYrSi9tS0JHS3d4eEZvN3J0bUhvcndyVlZUV21TK2R2?=
 =?utf-8?B?V3Y3TmRTOTZMc09zRGxTdXU4VENKamc4dG9OaGkydExDMkNhUkdORWljRnRj?=
 =?utf-8?B?cC9ua3Yzc3k3RE5iMXZtUGxHdTh4cWo5YnpQQ3RhVzgzTyt5U0JKOFlNVTdV?=
 =?utf-8?B?NXZXWEFDaCs3S0R3bzcwd2VxZ0loMEw3UW9DbkNZdlpBU2N5SUhET1Q2eEhq?=
 =?utf-8?B?TXpXZzU4UkdPNTFjaVcramlZMzRab1MvQno1bi80WVR2eWhHS20zL3FTYjFQ?=
 =?utf-8?B?clZjNVJnKzkrTVE1WGxlUEUzaTY5WkZtbXZCbFh5RjMwNjF2ZjcvRGlENmkz?=
 =?utf-8?B?dlFDQlVjTW9RQVZXaWtxYzhpemFicUMxeHlDcmFDVlNBZnozbWQ3dkFINzFR?=
 =?utf-8?B?MUpyVHVEdVFHZTJkMjQ5RTJiS1V6aG45REpIQlNrcERsR1pGUGoybExCYk5v?=
 =?utf-8?B?eGZta1dNUTFWNFlZWkNEVjJ1b3NrNDA2T25iVGI0bmRRV09QM3pJYUR4eERt?=
 =?utf-8?B?SnNBSzRHTXVxQTJPbjkxdGl1Yk8vNHBnSHMra0lXTERobzRYK1FwK1k3bExO?=
 =?utf-8?B?TUlzY25BdnJpZVAyend3VitoVDZ3Y0o5SVFaRzg4aWdSNHY1NWUxZXhrdmJy?=
 =?utf-8?B?RjFZSEN2VTdHQ2JWTXljY1JtMWFIaVJVN01UN2k2ZjlUYjFEc2dycTJWd3Ev?=
 =?utf-8?B?VWh6enlPbVJrN2R5a2dyYTZCcjhKdkswbXQycUdlSElnUStRb1gxbTBla25S?=
 =?utf-8?B?OXF1aVhsNytjZGJDdXVhNytiZHJZUjZVUnlRbWp0Mkc1Zm1MZWc0RG9PV1JO?=
 =?utf-8?B?dEhtVnVlM3B1ZnV2TDNRZ1hKaHB3Qk1wcUE4T3Q1K1V5STFycTZYR0Zxemhy?=
 =?utf-8?B?Zy9CdFE4MHo1aXpLTXBNMXVrRmZpQzUwWHhlQUc5eHlXSVUwcmxJNW4xeUE2?=
 =?utf-8?B?by9ZWGpabWxRc1Jsc0tFOHJ3OXpKZDJGVlZlOGYwVTAxZStvUENZMEtJK1VY?=
 =?utf-8?B?cm93R0RqcHowOU1BdFE0VzlCVTZxUmg0OG9wWEc4SkhldkJBVWFjQnIzWnds?=
 =?utf-8?B?aCtiUDh5TndJYWtLalVKWXFybjlrNFV5S1puVlhsYVJZQUJkZnRrc0xYaDVP?=
 =?utf-8?B?RTdQMkxZMVhvQ2NzVTdVMW1yeHpEdng2VUtJVHdyS3pveXdUTGoxWjZmUm1M?=
 =?utf-8?B?WmhJZUVOcU80RFVEdTQ4WWZIYm4xS1ZtWi92eC9MZjFSblJRSmJicUEwMnZW?=
 =?utf-8?B?eitkOEdEYUZaWWpFNWVmZ2dOWVlQWEQxTWdJblI0NzQwVVpMeWxYV0ZRbFEy?=
 =?utf-8?B?OHRWeHYyN29pT1M5bytRMFRJclFYOHRMMXB1Q0lSb29NVEdnUVlNMFZYM0FN?=
 =?utf-8?B?enYxN1JkR0hrSzRaalJ1MnptR3FTR2Fpb200OGdiR2hvWnpnWEZvaXh3KzIw?=
 =?utf-8?B?Vm95YndrcWMyU05Rc3dZRy9xaDRnQTU0SHVGNVRTMXNVSm5OQWJzbW84RC92?=
 =?utf-8?B?ZWJRNUdLNjl0YnBhZzhZRmc5N0FiQ0lLVDBCU0lyMHo0bzRJb0Q0dHd5RXAx?=
 =?utf-8?B?S0tEckR1M1V0cTVFM1B3NHBOL2o4YlQ5MmxIdE1weU9PNWgxclJuK1krNjgy?=
 =?utf-8?B?U0pGbHVBbmpGUzhSRDJtMlhyZG5KYWwxY1gyMFR5NjE5LzJaZklvSGpKV0lK?=
 =?utf-8?Q?DvYo5B+gDnn8iId+EITnDB8M9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0de944-13ae-4be0-a56d-08dd867d522b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 17:51:36.6827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mx9QC83NJkbfc4TX9l69GRf3CXClBjXGGGCbmuyzl+W0HiRvXemuw++GVsQwEhaI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7842
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

On 4/25/25 09:07, Prike Liang wrote:
> Before the user queue BOs resume workqueue is scheduled;
> there's no valid eviction fence to attach the gem obj.
> For this case, it doesn't need to attach/detach the eviction
> fence. Also, it needs to unlock the bo first before returning
> from the eviction fence attached error.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c   |  3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          | 16 ++++++++++------
>  2 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index d2271c10498d..375f15b6fd58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -216,6 +216,9 @@ void amdgpu_eviction_fence_detach(struct amdgpu_eviction_fence_mgr *evf_mgr,
>  {
>  	struct dma_fence *stub = dma_fence_get_stub();
>  
> +	if (dma_fence_is_signaled(&evf_mgr->ev_fence->base))
> +		return;
> +

Clear NAK, that is racy. You can only access evf_mgr->ev_fence while holding the spinlock to make sure that it isn't replaced.

>  	dma_resv_replace_fences(bo->tbo.base.resv, evf_mgr->ev_fence_ctx,
>  				stub, DMA_RESV_USAGE_BOOKKEEP);
>  	dma_fence_put(stub);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index c1d8cee7894b..04256de4bee9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -292,11 +292,14 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>  	else
>  		++bo_va->ref_count;
>  
> -	/* attach gfx eviction fence */
> -	r = amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo);

That here is buggy, fpriv->evf_mgr can only be accessed while holding the spinlock.

> -	if (r) {
> -		DRM_DEBUG_DRIVER("Failed to attach eviction fence to BO\n");
> -		return r;
> +	/* attach gfx the validated eviction fence */
> +	if (!IS_ERR_OR_NULL(fpriv->evf_mgr.ev_fence)) {

Please don't use ERR_PTR functions on members.

> +		r = amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo);
> +		if (r) {
> +			DRM_DEBUG_DRIVER("Failed to attach eviction fence to BO\n");
> +			amdgpu_bo_unreserve(abo);
> +			return r;
> +		}

We should always have a stub fence in fpriv->evf_mgr.ev_fence, so those checks are unnecessary.

Regards,
Christian.

>  	}
>  
>  	amdgpu_bo_unreserve(abo);
> @@ -362,7 +365,8 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
>  			goto out_unlock;
>  	}
>  
> -	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
> +	if (!amdgpu_vm_is_bo_always_valid(vm, bo) &&
> +			!IS_ERR_OR_NULL(fpriv->evf_mgr.ev_fence))
>  		amdgpu_eviction_fence_detach(&fpriv->evf_mgr, bo);
>  
>  	bo_va = amdgpu_vm_bo_find(vm, bo);

