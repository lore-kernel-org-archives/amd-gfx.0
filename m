Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A38CC25B74
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 20:54:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3E5510E9F8;
	Tue, 21 May 2024 20:54:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yVSx8IXq";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2523210E9F8
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 20:54:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDIvwKzx7stAlmsBhf0OFo9NjYCWxFytn2g0y/V17xAUCxibtdKeHWFzESSNbLVy8Mag7xd3+1GtQeywqhJdL1QUWnklpcuayX4CvVnVJuaGpiCZ2Ia43RAJgSBr4aiNR0I14Fr4ou8v4jpp8dvWrAivFxwD9jV6B6Ewwy6IN4536ViLNYGpLfyHS4R24ZmFXAtoZqH0Evx85EwISXZN9yiZYi5f/TZqMnMMZ+urJs+gpfLFXbmp38S6/X/MyjDL7mUM04sXSzkpFDDKeKPfCX4enOhEVWC9GlCJ56xiYW0HuuJuoPOGiJJXmbagmENU6ISHAAuxBAOVllAnEvkJjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nW/IdD2WuM/lhUUZ2tL1nsGEFvdUppkAQEFvLNORX2M=;
 b=U+S8p+K6uXyFlYFAUbH/fB3VR3qbc+lNz1WI5FKqZ5ksrzGfh87OSmo6XmZ98EjVxak/RZoTl9IQQHn4UdOqA64tClSaCD8GyfUFLcW/WaIU0QrEitsY1B2cLV6ArW5wv/IoDzgdZAhjeRfWsoxPfT1GhD0nDf67OMe3Ap6Hbk5mgPxdc2lwG/78rpiUTABUs2w0D4xDSyWrJTdRe9jrn0IDwpXIBRN88Ln1pG8IDSEwhk/V9jpg76vBx7Vuo8TB2jzgCovp1D3ljEQEkN06Euy1mHionp7y5BEqxvpSjQyJF0xdyMmsDiqWz0//F23tCA2EIh8chkAVwdU0ZxztRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nW/IdD2WuM/lhUUZ2tL1nsGEFvdUppkAQEFvLNORX2M=;
 b=yVSx8IXqQhcl7Wee2va7ml31ZB3Lg8mbZ2yo6NNRH+k0fIBdR0tXI+0tJ8O6XRG6qB3Azc0VpbZMytniReqg3OjEV4D2draDGj0YC3R8S1StnCF1LAZEx4c4+fo43tqAzBT6xe7IEEP6/OnCT5yZdZDSF9O5LVptVZ+EB873Fe8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN0PR12MB6296.namprd12.prod.outlook.com (2603:10b6:208:3d3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 20:54:32 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 20:54:32 +0000
Message-ID: <cba9b415-676a-4782-bc5d-0f965611b507@amd.com>
Date: Tue, 21 May 2024 16:54:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Update the impelmentation of
 AMDGPU_PTE_MTYPE_GFX12
To: Shane Xiao <shane.xiao@amd.com>, amd-gfx@lists.freedesktop.org,
 alexdeucher@gmail.com, sreekant.somasekharan@amd.com
Cc: Aaron Liu <aaron.liu@amd.com>, longlyao <Longlong.Yao@amd.com>
References: <20240520091409.2435612-1-shane.xiao@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240520091409.2435612-1-shane.xiao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0093.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN0PR12MB6296:EE_
X-MS-Office365-Filtering-Correlation-Id: 222f9e0b-51ae-4428-2566-08dc79d836ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWJHT2lKUGFVS1pHZC9OZ3hsU2J6SGxucFQ1Z3I4MXF1Nk8rQUtRV1NTZ3Uw?=
 =?utf-8?B?bFU5TlZucmhTVzlablUyVmIyMGFaQ2o3SW43eTh5ZjZBS0lUN2ZtRUJjVTdB?=
 =?utf-8?B?eUx2OGJZWU1USzJOdk1zcWFPeVBSMWFlalJwajZxY2RMN20xc24zbTRMUExN?=
 =?utf-8?B?WHBvVmVYN2dYNXhnOFVTbFlrWTc1b3grVUtFNHhtTUZRZzBxRXVpUldyQUtM?=
 =?utf-8?B?eHlMMy8vb0hQTWFXY2NGcmZyRzFxWDFwVUFNbmVFUzgrVzR4NEd2WjA4V3NI?=
 =?utf-8?B?aW5pTHAxbHVTOCtpamtrM1VaeC9ad2doN1dJWUQyZ0pSWTZTOVFpejVvbko1?=
 =?utf-8?B?OWRPeGtmbFVHL0NJanZhajdaVXVtbnpma1ZTTUxsdGpQVGVabG9Pczh0V1Y2?=
 =?utf-8?B?STlyVmpIV3JJVUpROTdtcFl6d0Jvd0ZjOVQ2ekUyUWh6KzRKVmxCVjlrK0dj?=
 =?utf-8?B?YkFYMUJnZmJldDYvL2QvQnU4U3EranJOc2FsWG5XWXBvTXZZNmJhZ2V5L3hv?=
 =?utf-8?B?NVd2TmV5bktqd0FUSWtuSExaWTFGSHhmQ0NwOUh0c00zVFRmUlZINnZQdkJJ?=
 =?utf-8?B?d056b2wrVWxBZFJYQzZNbkU2YzkrN1c1R3dPT0hTdHE0R3g3ODFPL2E4VDZj?=
 =?utf-8?B?K2lNWEhBYVBJL2FETE9wcmhNRFVpYUZaZFRwOGVOdFZ1U0ZyLzdveGhxNTJx?=
 =?utf-8?B?eXRzZWRXVXZNT0VnbmtWd1hsYVZUMVdzZy9MeVdkSWcxY2kzR0cxMjJzcHBL?=
 =?utf-8?B?TlgzRGVXalcvNUdVR2VVNG5SYjQ5RTR3SHBFbDZHOHJIalBHMEhYNEc3SnRa?=
 =?utf-8?B?U3VhNHlud0J5ckR6azM3MUF3SnlhWUFqY3hCdXdRMU15Q1A0K3lzTVJQbnpm?=
 =?utf-8?B?b2k3TVdrSEhPb1F0VStwNWZDT2QreXlyUDBWMDl4NjVITTFnL05PRVdKSytH?=
 =?utf-8?B?Uk5heXRvVGdaemdKcUtnSEVRWlQ4Qno3V1VicHNsZVdtTUthN0JkSEZpN0ZG?=
 =?utf-8?B?QTNWZ0RTR3dUMnZ6bXp2emtsaVRnaW1EQnZlbjV3ZW02RWFYSW5ScS9GZEJO?=
 =?utf-8?B?S2JDcHE4ZjV0SWRhK09sZDdMblRTVjBkYURPU25xRHV3QnI1ZFp6TWpzVFFw?=
 =?utf-8?B?ZGFUMit5aXlnQUNMRlVHd1MxT0NMVmdpSEtiSmRxQy9DQ3FUNVc0RU5wNWdG?=
 =?utf-8?B?bm53UHNucnhTcjhmOUhtQ2R1dThhSkw0azJCUW9aNUVGeHlOKytEMXdrUCtP?=
 =?utf-8?B?WUczWTZaL2JpclprcitZWnBaNVZPRWJwcy9FcVRrUlFESVpDQm5yVTBwb2FU?=
 =?utf-8?B?bXlaUWFkZ1ZWQnFRb3ZBUUwxczdNM1M4aGhMb0F3djJxQUlnN1VQV1lWdnIy?=
 =?utf-8?B?SVowODlMU0NPem11MGJQKzAyMWVPbXhFekNXVmtmUGRyQ0xJdTdTa1hJRlVz?=
 =?utf-8?B?bVFZNlVUdWZzditlRnZwVHpreFdhU2hpTGJhZUtiOTVJMlZ0NVpzNlpWS05L?=
 =?utf-8?B?VlV2eDN0R01lb0IvR3NZSVJiRzl5TmFwSVBOL0l1WFphRzVWZ1owMC9yRHll?=
 =?utf-8?B?cE0wN2tBQk5yZTFOWHFlNFBxRnVkdG4vSkFFVlE3ZGsrczRVVTJ0L3hkN1Ba?=
 =?utf-8?B?Ti8wS002eEpQS3R0YVBWYlVDc2xYTGdNRFd6UnJHYUU0MTZjbzVSS3dWR0pr?=
 =?utf-8?B?OGRwandzZ3AzenFnblNrQy80Wng0bUdrMkxIYkhhUGoyajlBMjBXU0tRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGRScTZnOS9zSG85SXhtUkpkNjdkQUpUUlhKcmh6UXVGdUtzN284UFhOMWZV?=
 =?utf-8?B?allpei9VMzA4YW9tdkxLTk0xc1RtTlVYUy9ydEVnaVgyOTBQZTkxQi83YktD?=
 =?utf-8?B?dzI2SUZnMjFSb3NENTQ0dk1tc1V0S1RRc0ZqS2p0eVA4SUVaZEYwaUhKYkts?=
 =?utf-8?B?bEtiZDdyRHFhWFVGemZpdHZaMmFONGM3QzFOM2ZlMWtOK2o4a1dSQy93OFdJ?=
 =?utf-8?B?Ynlla0xmTDZtOFQvbzAxYU41N2NhQlNjVDVLM3JtQUhEL250b2xITWszMjNu?=
 =?utf-8?B?ZWd2ZFJyc0R3emZpWUUzL0taYlpCZHg3MmJ4MVNPb3A3ZjdsTmpaTk5rRFZW?=
 =?utf-8?B?eTNXeUhDM2NpNVhEY1ZjTkNEZ1R0aVpWdmlaYnV4RFpDQ0cra1B6S01xVC9j?=
 =?utf-8?B?b2xDOFhIcW1DVFVpT29aaG13MlRPZmRtQTdFZkZaVVpZM2xIYi9vWXNhZ1Jr?=
 =?utf-8?B?ZnVKTU1Qb09HOVdzKzhwdSsyV01DN25oNTUzUTliUHpvYlRsWXIyQU1QTlRx?=
 =?utf-8?B?SU0rS2NpWmVkaHFIVnRaNnkxSjFhM3hFRlVseFhCdkJkd0N0eTliWGhtakRt?=
 =?utf-8?B?cHhzVGR4Q0Q2RVBRY0ZyV2NxdDQ5d1M2SzBxcFdoUllmQjJnWHBUYlVaWHF1?=
 =?utf-8?B?T3BaTXdvM252SHFkM1prLzZBOUpGSTNkTElNWEhta2p6VEFZb0M0d3lKWStO?=
 =?utf-8?B?WU5JQUJ6WENPUW0yMDJoQUNPSVAyUk5meGNUZ2ZpY0pnV054N3IwUDFRRElM?=
 =?utf-8?B?d1RuMTIwbnZoK3dMWTR2K29McUIzODE1ZVg4ZSs0RnRlU09oK0JnaUhlcW9t?=
 =?utf-8?B?NVllUmtrMGRKQ09aU29OSW9paVVVVkJGYUQ0eUVhTzc0QTZ4MWRFbkVhK2dT?=
 =?utf-8?B?SGdiZjJWV0c4NlAzZ2VGOXJjSG14V0g0UnNqMHdjR2xteHVhaEJrZFRNSG1S?=
 =?utf-8?B?dGl0YVlQZkdEa25pQlQxbFhQL0dCbWhmc3J2eEFHNTg1Q0NxeDhhUWN6bE0z?=
 =?utf-8?B?RUxudCtubmFXeDF0WUtXbmpIVHpXdHo3ZkxBa2oxRkh4YlVNZXdJQTVBUzNV?=
 =?utf-8?B?NEM3RmZLSXRYZ3FNZVI3endYa3d6TWpyZU9jRUYzVXRUQ0UyL1I4dzJzQTlo?=
 =?utf-8?B?aEtvRjFzbEgyVGI4eHEzRGdLeFFkZVdYNzlobDUxRy9PY3VYbVdOR3BzSmN1?=
 =?utf-8?B?LzRNK3ZXK3V6RzdCUDBTOU1pMU5rN2FIWkxjcS9kTmgrT002UE93cmM2V1Fx?=
 =?utf-8?B?aFY3RFlFM1NVWFdFU2hGa3ptYjNmblRPUDdCZUs4OVU4Wis3QnMwVitsMXda?=
 =?utf-8?B?eTV6UDB5WERaZzhmelBqY1gwVHVOOE9RZFcwUWNSMEsxTDZ4d09BanhMbFVZ?=
 =?utf-8?B?LzZRZWdwdjZSNExPWFRiQzZTOW0rbGJMK0hqOUpTYlZlRTBCR1BzUzBEeUFD?=
 =?utf-8?B?dnpEWVdtREUrdlVGMDQ4Tm4rSmxMNi9oWUdyb1dILzd5NkxHL09Sa1hmNDlV?=
 =?utf-8?B?Qk45V210NDlZbGd5NHp3ZXZ3OCtuVGw0WGlrcElOdm9JeUpnVGRsY29rSW94?=
 =?utf-8?B?SHc5bmY1dGl0WUNLQWpIcFNqbUdWeWEvR1FTenl2bm9BdU1TWGZyR0VwNFF5?=
 =?utf-8?B?cDRjQVJJZW5rWWRwUE5Ld2dQSWlPQ3ZFS05RTGtpWWRwSDM0bjlwNkdEZ2E4?=
 =?utf-8?B?ZW4wLzE2d0Qzck9QUGVxaGphSVgxbFcrRFI2d0hnOWZ5bURBT2J0R3dEZ0Ns?=
 =?utf-8?B?OWlsMERBQjRIZmt3MEVLQWpEbURBbVozWkJkVzljczNENU85ekJOK1IyNnEy?=
 =?utf-8?B?Q2pBM0J2dGRpaVdUeVdZUmRXb1pubElHdW11U3N1eENRZ05tZW01WGJKTEln?=
 =?utf-8?B?QXZGWEE5VEtKY3JhTFdQU0gvWHVRcWRzU2o1MnRjS2p1V0V5Q0taRThUckZN?=
 =?utf-8?B?SGNQRTNISWlxVStoeWVNQVdsTWFBRUlycytmMUEwU1l4L2pyQ0NWMUQ5VTBO?=
 =?utf-8?B?clJuTWIvLzBSbDE0ay90bE5IdUdsRU5QaHRHUllRaTYxU1MrRFVCUUViZVZ3?=
 =?utf-8?B?YWJUK1FjUlVDTFJURXNzdldLL3RIYTNEanJ1eTNPd0xZZ0locUlUbG81NFB0?=
 =?utf-8?Q?lOl82ENqKeVYKwJcLM2TfQEQv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 222f9e0b-51ae-4428-2566-08dc79d836ea
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 20:54:32.5720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kA+J8ZVCsmQM/8aRtgte4eQCLqJnvCe7HLkNEjpTY0caKzloTI3raNawD/fcsNpnRbc/fcecSgCVCzGIFM9k/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6296
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


On 2024-05-20 5:14, Shane Xiao wrote:
> This patch changes the implementation of AMDGPU_PTE_MTYPE_GFX12,
> clear the bits before setting the new one.
> This fixed the potential issue that GFX12 setting memory to NC.
> 
> v2: Clear mtype field before setting the new one (Alex)
> 
> Signed-off-by: longlyao <Longlong.Yao@amd.com>
> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  7 +++++--
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 23 +++++++++++------------
>  2 files changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index bc71b44387b2..99b246e82ed6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -116,8 +116,11 @@ struct amdgpu_mem_stats;
>  #define AMDGPU_PTE_PRT_FLAG(adev)	\
>  	((amdgpu_ip_version((adev), GC_HWIP, 0) >= IP_VERSION(12, 0, 0)) ? AMDGPU_PTE_PRT_GFX12 : AMDGPU_PTE_PRT)
>  
> -#define AMDGPU_PTE_MTYPE_GFX12(a)	((uint64_t)(a) << 54)
> -#define AMDGPU_PTE_MTYPE_GFX12_MASK	AMDGPU_PTE_MTYPE_GFX12(3ULL)
> +#define AMDGPU_PTE_MTYPE_GFX12_SHIFT(mtype)	((uint64_t)(mytype) << 54)

You have a typo here: mytype -> mtype .

Regards,
  Felix


> +#define AMDGPU_PTE_MTYPE_GFX12_MASK	AMDGPU_PTE_MTYPE_GFX12_SHIFT(3ULL)
> +#define AMDGPU_PTE_MTYPE_GFX12(flags, mtype)	\
> +	((flags) & ((~AMDGPU_PTE_MTYPE_GFX12_MASK)) |	\
> +	  AMDGPU_PTE_MTYPE_GFX12_SHIFT(mtype))
>  
>  #define AMDGPU_PTE_IS_PTE		(1ULL << 63)
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index e2c6ec3cc4f3..f2d331d0181f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -461,17 +461,17 @@ static uint64_t gmc_v12_0_map_mtype(struct amdgpu_device *adev, uint32_t flags)
>  {
>  	switch (flags) {
>  	case AMDGPU_VM_MTYPE_DEFAULT:
> -		return AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
> +		return AMDGPU_PTE_MTYPE_GFX12(0ULL,MTYPE_NC);
>  	case AMDGPU_VM_MTYPE_NC:
> -		return AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
> +		return AMDGPU_PTE_MTYPE_GFX12(0ULL,MTYPE_NC);
>  	case AMDGPU_VM_MTYPE_WC:
> -		return AMDGPU_PTE_MTYPE_GFX12(MTYPE_WC);
> +		return AMDGPU_PTE_MTYPE_GFX12(0ULL,MTYPE_WC);
>  	case AMDGPU_VM_MTYPE_CC:
> -		return AMDGPU_PTE_MTYPE_GFX12(MTYPE_CC);
> +		return AMDGPU_PTE_MTYPE_GFX12(0ULL,MTYPE_CC);
>  	case AMDGPU_VM_MTYPE_UC:
> -		return AMDGPU_PTE_MTYPE_GFX12(MTYPE_UC);
> +		return AMDGPU_PTE_MTYPE_GFX12(0ULL,MTYPE_UC);
>  	default:
> -		return AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
> +		return AMDGPU_PTE_MTYPE_GFX12(0ULL,MTYPE_NC);
>  	}
>  }
>  
> @@ -509,8 +509,8 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
>  	*flags &= ~AMDGPU_PTE_EXECUTABLE;
>  	*flags |= mapping->flags & AMDGPU_PTE_EXECUTABLE;
>  
> -	*flags &= ~AMDGPU_PTE_MTYPE_GFX12_MASK;
> -	*flags |= (mapping->flags & AMDGPU_PTE_MTYPE_GFX12_MASK);
> +	*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, (mapping->flags &	\
> +			 AMDGPU_PTE_MTYPE_GFX12_MASK) >> AMDGPU_PTE_MTYPE_GFX12_SHIFT);
>  
>  	if (mapping->flags & AMDGPU_PTE_PRT_GFX12) {
>  		*flags |= AMDGPU_PTE_PRT_GFX12;
> @@ -524,8 +524,7 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
>  
>  	if (bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
>  			       AMDGPU_GEM_CREATE_UNCACHED))
> -		*flags = (*flags & ~AMDGPU_PTE_MTYPE_GFX12_MASK) |
> -			 AMDGPU_PTE_MTYPE_GFX12(MTYPE_UC);
> +		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
>  
>  	bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
>  	coherent = bo->flags & AMDGPU_GEM_CREATE_COHERENT;
> @@ -534,7 +533,7 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
>  
>  	/* WA for HW bug */
>  	if (is_system || ((bo_adev != adev) && coherent))
> -		*flags |= AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
> +		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_NC);
>  
>  }
>  
> @@ -707,7 +706,7 @@ static int gmc_v12_0_gart_init(struct amdgpu_device *adev)
>  		return r;
>  
>  	adev->gart.table_size = adev->gart.num_gpu_pages * 8;
> -	adev->gart.gart_pte_flags = AMDGPU_PTE_MTYPE_GFX12(MTYPE_UC) |
> +	adev->gart.gart_pte_flags = AMDGPU_PTE_MTYPE_GFX12(0ULL, MTYPE_UC) |
>  				    AMDGPU_PTE_EXECUTABLE |
>  				    AMDGPU_PTE_IS_PTE;
>  
