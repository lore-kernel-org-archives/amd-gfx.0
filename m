Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635B6CD4F59
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Sep 2024 07:43:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0129010E708;
	Thu,  5 Sep 2024 07:43:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mJvN+i3Q";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58C4A10E708
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Sep 2024 07:43:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKLyYNq7NpF2wHTijXj8bar2LpTclyWP//IdVSLSRTnUf90luH5S1O1D1121+qS0y7fzukMMwgc8vkNfhylhi0n4DcxMP6a9k6uI1OFKW0irJUiqZpg1ietXjXTN+f30kIRmYSZ1tFJBQ6uSiHjW87oq6C4+sWrAaGrRBlza0o/HWRlGph47nhIt2y2/exq7hKAjbTm7EsM53Sxu6g+NlMCHyGPnOnpefzlrf3I0JTZ/k86xha/DnfPD1o+mHwsyiPU82PNUIBAOLyLJL4nHJjM7wofglCIpIyQiUjORzeMKs4FRkWnzl4CNKw4lEFUG0mpOgAVOGwz8lYVrPFGB/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Foc959ipg8IM5TGpCLSdkL9gjJYhSwb4TSc98D9x5Gk=;
 b=NIApWgC+Jh2jiCEefH/aCMXWWp4OMqLb/Zim/ks8GTKZ3riw6KFiVym4Pj548nodxh0insXUfFR+NbGh3oRgQjYe4joxcdt1/BnUk43ltZ2DRpugg5IiM696sgeonqN5kQK5lr6FqL49kzzk8ZWnYx9DJLIOAXVS4whD9V5WMa5LBZztCCBwCCNhgndK2Mjq4NXppjTLITf9mIMKGQVuZbJEf4O1gS7SjTjdQ5ieF7mz4F3Vg7gyIobwEkyZdRlKHXAQqfbm3WhlyVLLK2ZoVrqVEJXGFDk+zeWLJoncKuJXM7uyq1jYThtxprfRXGirN5EcDGvUiRAPdxTn/GdVMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Foc959ipg8IM5TGpCLSdkL9gjJYhSwb4TSc98D9x5Gk=;
 b=mJvN+i3QOAOW/toU5QsJDs+gFbr4JC4WQ+5iKfLgSRaqY3EGOr7FcT4+1mv7LhEt/Lk5DnhV991zFTsSi+EaofxqEXUzkE5pi0j9971UlkWanHb27KWJkuyDiAG/1Xx0JXqXYVzKmG5kiAM9tqyOidlUzj6q9w/kjSxud/LwQv0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB9151.namprd12.prod.outlook.com (2603:10b6:510:2e9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Thu, 5 Sep
 2024 07:43:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 07:43:06 +0000
Message-ID: <c9af1114-a893-4933-9139-6c7960c28510@amd.com>
Date: Thu, 5 Sep 2024 09:43:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix kdoc entry in 'amdgpu_vm_cpu_prepare'
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240904073227.1726831-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240904073227.1726831-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB9151:EE_
X-MS-Office365-Filtering-Correlation-Id: d6ff207b-9c47-4295-76d6-08dccd7e617e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUI1VnFTNlVmYjc3Z1hmU00rQzN3LzJXNHdhaEJ3SERQVCtNN0llYUJjdTI1?=
 =?utf-8?B?cTkwK2pQckxySEd3QU1KdGJxOUZiOWxwTTdXcnNndUJNYW5hd25LU2pvTDlw?=
 =?utf-8?B?OS80RUI4a3U4L2syR1lvanRlaGdCT2xsWU9hTmplTlZ4R0d1cXpxSFl0VzY1?=
 =?utf-8?B?clFBeTlxa3VlQlNUcDZyS3hvRWFxbWVFTmlORCsrNVEyN0xZZFJIM2kvR3Ba?=
 =?utf-8?B?VDkrQldQSnpyM1VNWEpYc1lnN3pHVkQyc1dzaVEzT1gvQ0NRYVFSSWdUL1dY?=
 =?utf-8?B?dXF4alFRU2pEV0s0R1BqbWFHNGlhc0RRcytkY2NmNk4xS21PTEJsU1JPYVJj?=
 =?utf-8?B?bDZ0SnQwNy8xKzRMVjF0ZHkramlVRzY5WnphTFcyRVpsU0FHd3h1UmlxRGdk?=
 =?utf-8?B?REt1cEsvcTlwbkZCY0V3c3hHVGpqVTY3aDFEVEk4SSt5UFViNEUyZTIvMmgr?=
 =?utf-8?B?b1VPN2RhUEV6Z0lMZnVVd21oRmZsbFd0Q2dnOUFFSU1ySTEzMmVJcU5yOWor?=
 =?utf-8?B?ckhMY0ptYWZwMkhuOGU1U1VTRWQvMGVsa0FCS3d2KzM0N2Q2WFB3T3FZdm93?=
 =?utf-8?B?NVZ1aVdIZndudEF4SnpvUVB4b0RydGxvQ0NFY0VjUE9jWThLYWV2THJjNkpq?=
 =?utf-8?B?SG1CY2QydXE2SlRKcllMRi9kUXkrWGNmYkZaZXpiYTMzUFRKWGs1MFFOVm5p?=
 =?utf-8?B?dzJvcmd6V2c2c2R5NzQvWDdPa3Z5TVFXMEVKc3psclhPY2dEZGR3Q2pBanpw?=
 =?utf-8?B?U1hpZUkxTkljUWh0SkxhUm83NC8yY2RDeFl5VVhOdUJpSTR0emg1TDFkbFVL?=
 =?utf-8?B?ZThSS1ZCcno5LzdsK293OG1lVUV5SGhVM0pqcGt6UzFUeC9vNjJHT1dtMHNH?=
 =?utf-8?B?ZnBkTnROY01EbHRhR044akpWeDI0bHZLLzREYkVPNUtIdlB1aHZkOS9aa21O?=
 =?utf-8?B?UFFpSTFlWHdEdHd3aUdQWUhWemNmeXRnOTZ5cDljV1N4eVNSYzNyZHVFd2Ru?=
 =?utf-8?B?ZWlhbHF0SFpMcTNUVTAzd1JXTmhXMUpYb3JQdmcxQ1FiQ1dyek5nOVFwVVFN?=
 =?utf-8?B?dzFzN1BQdmhSQ1U0bk9uZlZzZnJWQTRiQWsrWFcxNmRrMk9uY0NCVGgzREZU?=
 =?utf-8?B?OUJsYnc0R01HZnp2WEQrbUprNjB4ZFJIZFhtSlhHNHdPV1hCQ2pPdnZPa01l?=
 =?utf-8?B?T2tLMTBrTU1tS0Jwc0dsNHdWd215SWFsc2U1Vy9RUkJvbTNURFZ5VlcrK0JN?=
 =?utf-8?B?L091ZFZqVmg4aVdacXF0U2Z1U1pEMW9CT2J6OWNNOE0rSm4xYkpiQ2xId2pH?=
 =?utf-8?B?cDhHVS82QVFSSmdMOGVsS2FvR0xpbE1QVzRSdGsvRXRxUnNYcTc3bVAxWDdv?=
 =?utf-8?B?SW5TT0lQamxVRTFiR2ZpK2FtMGI2UGh6Y21mT0NvM1BaRWNpYzNoQUNvdHFM?=
 =?utf-8?B?VGZNK2F0UExZRmc5dG9JcDBXWFFLWjJKU2dnaFBTYmRSTHBzOGRuSEVSNlJh?=
 =?utf-8?B?R0ppekhHRnlPdklMZ09rVVJNaFptQWtlc2JBSXk3cVVJQXo0RVhZalpDUHpJ?=
 =?utf-8?B?bkZZUXpLeGR3VHpXRHdVSG1oYm9oZWx1Y0RrbVFyWjlKa285Ti9JM0RYbDBj?=
 =?utf-8?B?SWpCZnRaTE1jK1IvOVd1TUJ3TVJ2TjFtMUlIbkVlRk1DU3A0UFJ2NUt6cGlk?=
 =?utf-8?B?VzNZOTdEelFFSGZmZldwT3NsdVNaTnBJY01zcW8wVUdtbk1BUGx4dGhEdy8v?=
 =?utf-8?B?aG9ORHdZSXRXKys3VklTYmlrSGdZQ29CM3cyYzZvUW53cGJ6MHE1cU41aHc5?=
 =?utf-8?B?MEVSY2pTVXdBdWZidEhvdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnNvVVptNVdOdytZTUxueDV0YUtxRkltYzNScmFFMC9qazV6c2ZrUUFsNytX?=
 =?utf-8?B?STNTSFVHUExaTEFsc2pHcGorUkQvWWJ1MlJySERLWC9mdUpuQjVyUXJNbk5Z?=
 =?utf-8?B?bUQ5Y1VSQThmSlh4TThDWE5nQUpLVEdPcnJWVlZOQnZFaXNLajM2SEdKRUUz?=
 =?utf-8?B?N0tTdlFLTTQwRDFCaDNlMWJQUGV5eG9HNWVtZ0JMazBHZHEwMmhDT0R5RmRk?=
 =?utf-8?B?Z01Hd1pudll3K2JqY25NS0VGM2RRblYyOGVoMGlnZlRiQit3MHZjeXBKUEhO?=
 =?utf-8?B?Z2EvSTB2WkR5a0lHQkprN1h5NGNqWHR3OVZIdkhPNXpWMUdXREFXNWdsNWl5?=
 =?utf-8?B?bWp6VktVMmd3aitZRXM3UDRjRzJ5SUVhTVpnbUFGdXFEM0JiUUl1WlNqK09a?=
 =?utf-8?B?Sk1HSXhaV1RqNlcyQW43emNWd0FuakZXK0ZPZ0dCNDdKdlA0UWFEY1poa2JV?=
 =?utf-8?B?aFlHM1QrSVc0TVBaOHJDS1J5VlFXUFl2U3VoZGthUHJualdnSkVlN3VKUWI1?=
 =?utf-8?B?akRjRjgxd3pWczdhbVNMUEpnS2pBc3hIeTYwY3NnUnl2d3h3ckRzZVFPYXhq?=
 =?utf-8?B?ZmNqbWRTMitpRzNSRDVBU1dNdWVGWTArS3hzRXllcll5SUxMa2ljY3VRTHBV?=
 =?utf-8?B?UTVkS29yVmMzV2d6N0F3bHk2Y01WMFplY1VoS1RWOHBDbXBQZktPQkhKZnpl?=
 =?utf-8?B?TnY1WHlQaktpYmhoRWd0cnhVczVLcGNYRjZjMmFFK0VydW5FRStQa0lndUJz?=
 =?utf-8?B?eGZDdUtYZ3pVdm9LQ3p6S25RUnBlM1pKdktoNmVjck1TWHV4ZkxzUXhxK3pm?=
 =?utf-8?B?Vll0SlhiaDM0YUR4Y2FYcTRlWHVYN3k0ZGZjWjNSSVBHVGJ2anllaTVuc3Nv?=
 =?utf-8?B?MlNKbUZ5RmlncEFqYXNGTkEzcWtSRFVibmw1VlN4Ykxxc2JDSFUwd2JQVnow?=
 =?utf-8?B?YTlwT2pMUFlFazJMczlSRzBwRDdOQWNYbXFBdy84T3NlMlgwTE9GLzUyUGdS?=
 =?utf-8?B?eEM5K3JwS3RpZG1LNGxHYkJoWkVsbTkyUTYwZVhORDNucjhuWEVaaytYcTBq?=
 =?utf-8?B?TmdnSi9RRWxHVkN5RHBrOUF3Z1VUMmpsemQvQi90ZS90SzB5bUxCMEFlOHFP?=
 =?utf-8?B?UXpEUndiTGpiRmEwWDhGUG14TXRFeHgwTlRYQVJHMzBqanZoaGV3K21Pc3gw?=
 =?utf-8?B?ckFpMTg0U29HL1pVdVVqNkU1Y0hycjB5NnlZK1VjZ2kzOE9jRnR4NzFlTVVE?=
 =?utf-8?B?QWtXN29aVzN2eDhEdTQ2THExelg0ZDNHdUU1QjBGM1RoTUFwcncvdXR4cmpp?=
 =?utf-8?B?bW96VlczaGpsWDN6RzJnZDA2NWNJbmVSa1FxSlB4VFd6MEMxZ2dhLzdEa242?=
 =?utf-8?B?UE42WGdtZmZrS1JDYUZQd3VEdnNFdy90aTFKZUk3NDcrdE9ObUpkZ202R0M2?=
 =?utf-8?B?a2g5ekJIRGpyVkFkblZ5MXpndGtabGdwOWFGbWZzckoxT0U1VWRLYjNNTDMv?=
 =?utf-8?B?ZE03UFVrQThDek9BT05SVU94c3dlL1RiSFhCeld2OWtYcTJiYTF3MWxpWXFp?=
 =?utf-8?B?eGpHbjNMWDA3Ymc2Q0Z3a2x3Y2RrU0JKdytTOE52UEtwS0xZd3gyRzBVMi9M?=
 =?utf-8?B?VXA3YWZYbktENDNIYi9ZR0R5ekkzS0M0TG5lZ3F6aUNDNXdtV2F3NmJFM0Vl?=
 =?utf-8?B?Z1lzMnhTNkxoU1JvcEFhYnJpcVBYSlVoMzhLcHg1NGYvbU8ycW5ISzZpUkpU?=
 =?utf-8?B?ajdRZmRzNGFoa3E0WkFBZXJ5R1VrOG5IdTE4eU54cGMrNnlrbG1xVi9jVWNR?=
 =?utf-8?B?SVNsdUhjbHp2QXpWYzNFcW9YWkd6UnJBanZrTFNaalBHTFY2eloreklHWFFu?=
 =?utf-8?B?VWpNbEdUV3QzcFBiZkhZR1EvaWVEQmRnUE55bHpNcjNSU21VMFR5TURPcW9M?=
 =?utf-8?B?Q0R6S3VEbDMzOHZOa3hDdVJMZzV4ZGNmN1VwS2dMeGJUb2JPTGl6enlCTTkv?=
 =?utf-8?B?ME5XRHhobUZIMDl1aTlrdHB5NzEzdnNaVmJjaDNiVmpqREF4aGNpOS9GZG92?=
 =?utf-8?B?V0RwY3drMDY3VWRhS3BKeWhnUjYyUlZLRGtVNzZ6NnU2UE5PZzlRa0Z1WDhw?=
 =?utf-8?Q?x2Q/i0Z42klt4FhILiSd48Lgz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ff207b-9c47-4295-76d6-08dccd7e617e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 07:43:06.7461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHtDCLOqrQpY4dskgTRT21f2YVY1EEod08SNJnPmZ6BpU5KN4DlKspgC6I14aMLc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9151
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

Am 04.09.24 um 09:32 schrieb Srinivasan Shanmugam:
> This commit updates described non-existent parameters 'resv' and
> 'sync_mode', and failed to describe the existing 'sync' parameter.
>
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c:50: warning: Function parameter or struct member 'sync' not described in 'amdgpu_vm_cpu_prepare'
> drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c:50: warning: Excess function parameter 'resv' description in 'amdgpu_vm_cpu_prepare'
> drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c:50: warning: Excess function parameter 'sync_mode' description in 'amdgpu_vm_cpu_prepare'
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> index 9ff59a4e6f15..29dbcdfeea8b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> @@ -39,8 +39,7 @@ static int amdgpu_vm_cpu_map_table(struct amdgpu_bo_vm *table)
>    * amdgpu_vm_cpu_prepare - prepare page table update with the CPU
>    *
>    * @p: see amdgpu_vm_update_params definition
> - * @resv: reservation object with embedded fence
> - * @sync_mode: synchronization mode
> + * @sync: synchronization mode

"@sync: sync obj with fences to wait on"

With that changed Reviewed-by: Christian König <christian.koenig@amd.com>


>    *
>    * Returns:
>    * Negativ errno, 0 for success.

