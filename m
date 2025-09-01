Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB73CA0FF0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Sep 2025 09:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDCF010E0D0;
	Mon,  1 Sep 2025 09:14:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fWnNRPMx";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B60B10E0D0
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Sep 2025 09:14:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDrau7iW3ypR6LEb+27zHH4FGyp8kuwZd5NZ88maYILEPh8M/94fcxsJBhfqj9lByow+wKZXBPwC2SnwM4gM5rIN6PqXdlIHXNYFR6QaZwlTzjncd8lydIARTeB8VpQRqMoQ+Dbw7ELrDLhiJjvTj4ba2qhkDDFjar64nCtXWnZUVWFqOGMMkA+lmRuz8qnXonGUUXWkg7JvYhn0yLwuBFaCJJXx7N0ZpKqKH0zTzKfcDO6o3MrRD7SVWrUHk2bw8fWNQRIsenFb/209B7QtLjDXJX2ubvGJ54S7tzqF3VsHaN1DIBBpIV/I+fqpDP7/6v//eHAavXy/mL+9YsFs6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8NlHil/A+C7she4fD85KqIGbsZPrvCSg3myy2d5kpM=;
 b=FiYeN8Mg5y+/yOfMcssHhtC8ElGbXRJcuJ6ZbOEj5TfSyPVmssLU1jU1fZV0e6nXP9jNfhh4XToyQnVtBzIN8qSa+9nz0gWckWuYB5iRiaHbG5Gdt9DszsHDWzicaZoecqoaBPxznlX+yw/aQs+GMMUAtLotrch0Skd/k4lmz/nvPf5c44HoJKZqG3vlOZdBIhiq1HeFhZBiBZfvw7kD1nWnrrI92Lc09xQajVH9S3pXKePQYAg6NxZmeLLGqZEVGXokw/6R90oBlxHy3hto9h3NMqDUQOxApCX84NCuQPl4oIB2uniHWuwuDsH1nJ6r9TdnbDO3G6jxiWTluSinLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8NlHil/A+C7she4fD85KqIGbsZPrvCSg3myy2d5kpM=;
 b=fWnNRPMxKYSId5FsNrBKlFJjOQQS3O6xhdHmbEtro05tw0zNHv8SnJi3AWFcKkYmvrLvQ6VdCU71eaAC28O3BoS2CqL+O6WavQVAnrpDh1x5p9y1c2ox0DXzB+VfJPF5bbsCZe/iXELvgkWciRsw06fFvLAcx4ncoLnzTCzkrQQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB7865.namprd12.prod.outlook.com (2603:10b6:a03:4cc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Mon, 1 Sep
 2025 09:14:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 09:14:29 +0000
Message-ID: <b82b6da0-1338-4b57-a6d8-f430816b0e73@amd.com>
Date: Mon, 1 Sep 2025 11:14:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/9] drm/amdgpu: Implement TTM handling for MMIO_REMAP
 placement
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250829135523.4032168-1-srinivasan.shanmugam@amd.com>
 <20250829135523.4032168-7-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250829135523.4032168-7-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR01CA0008.prod.exchangelabs.com (2603:10b6:208:10c::21)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: 82ff70d8-4489-4e88-d03e-08dde937f4b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmdVQjc3T3lMWFFaa293anpqakx1UXVkRlhWb3RJc3FBQmtjWU1RUDBFRHda?=
 =?utf-8?B?Q1JWZ2FrRmFMNWhtN0xjRTJCMDB3M2tGNU9yakJrSzZxdW5nYmxFUnh1cUk4?=
 =?utf-8?B?Q3N1YWFtam9yNFY1MEVzSkVEd1JlYmU1S0pPOHAwRE5oN1BYajNrdXhRa0M0?=
 =?utf-8?B?eWhrTXp5VFM1bnpzWENuMmNyYnZIdkRMVTJiemVMZ0hkN2s4OEc3My8zMDBU?=
 =?utf-8?B?eU14ckxBUjJ2SzhBUkNlUkg2OERmckRKYUt3alBQK0UxUTBhRmlpTUI3TTRY?=
 =?utf-8?B?VVJrdnIwTXA3Y2xISlIyN1VHZThISzhiODFuOWlEOVg3dzdmZUkxWVB3U2lK?=
 =?utf-8?B?aVdra1Y1WDBDYk9oUElGejE2ZG5SVXZqNWZGeThVZVpYKzR4aVRyTVdlTUxX?=
 =?utf-8?B?TUw3eXVJeVYzVmlzT1V2dDU2VE91cWx6VjhXKzRWTkRTRWZva3dzSG4zUno5?=
 =?utf-8?B?dWt2SVBaZFZOYTh4SXduY3BBbWRKRlQ4eWFFMmlkTjE5eUNkelVJUWZVTjR3?=
 =?utf-8?B?M1Bqc3VyajY2eFdTU3ZhclpMZitxSWtRcFh6UzlSYjd1aTJLSlY1akFjUFgx?=
 =?utf-8?B?dXBOOElaT0lyTlNHRm9VYWhIMzdIajBoNkdMaGtsM2NEdVVnK3lML2tiN0ZK?=
 =?utf-8?B?VjR1U0VNbWJ1L0IzMUhFRTdjd0EvT3FxYzgvZnh2YU15dFN1Z093NzdZMHRx?=
 =?utf-8?B?c0t3aU54NzhMVmxodERoanhQN1NQTW5RZGxLTkJDaGQ1MGtQcjY0eU80NllH?=
 =?utf-8?B?b2wvMWh4OWZ0VEhyUklmWm8yalhNQlJFNXQyeEg0T0hEa3NOUTQwTEtrNnIw?=
 =?utf-8?B?VDRBNk9TNkpxalRZTG5majh0MFVDMjhGSFR1RGpadXhqQVRkcjUzODZKV3ZK?=
 =?utf-8?B?dC9QbzhHRk1Jem9wbzJPRTJKRTJBU3VubThzQm9kdFBwSW9UTzZNTUtTOGk1?=
 =?utf-8?B?MVdHeFdRR3ljRUs4ZTVpMXI3ZXJJd05zY25WYnBMTm9xekRqR1BRNDZ3OXFQ?=
 =?utf-8?B?Z3Q5d0tqSnZWZE9UOUZ5bjU0YUJCemxwOVdqZSs3OGJUcEtYOTdNclJ1MHBP?=
 =?utf-8?B?c1gveWNhSnZXZnBjdC95dTFhdkZzLzU1WDNmSGxPTk5vZVlqUUJ0V1NibDNJ?=
 =?utf-8?B?TExuWVVjSnE1UlNBRzMwVFdsOExKOUxuMGUzNk43cjk1QlY5dGZPYlhqVTdN?=
 =?utf-8?B?eTA3T1NraDBSc1BkemxBSlZGaWJWb2QyY0NPNVF2MmNKeHFXYXorU2Ivbmdu?=
 =?utf-8?B?VFVMWG1xdklVekU3M2U4RVVmV3ZTSHc0YkpmdWg2OUQwc1BEWlNvL0NOS2hF?=
 =?utf-8?B?eGMzY2NRa2FOd3pvdjV1NlhvSGxNQlM4TmQ0Nkh5RGtDTElKZ1MyNis3TWR6?=
 =?utf-8?B?NUtYQ0MxQVpoK0IycVdicHlXTlNHRXJ6U1hiSG5mTWdOZVRlcEdWRDVGOTJZ?=
 =?utf-8?B?Ly9JUklZZCtDZklvYVQrTTBXTXpCNFV5emhjMzdRdDYrQUN5b0prUzhXVEMw?=
 =?utf-8?B?RjEvMVQrYzA3U25HSWhYdmVHYmhHTWc3dkFmU3Z5SlplUldiTW9hVFh4MmdG?=
 =?utf-8?B?TkMwdTI3d0dzUUdPTm9JdUFTZlpjLy9pYUhQaExwVTJ1NWtiWUNQY1lEUk93?=
 =?utf-8?B?ajlaREN6djlHRzZXTkpMdFp6RWU3M25QaDRIaHJ2a1E5RWlRYVpHRUVWWGVp?=
 =?utf-8?B?NDQwYzNIRXdRWC95ajlpaVR3eHFIcEVaWXdPNjk1S0N4Zjd3Y1pydHpnSDZI?=
 =?utf-8?B?a0cwZ3lTRFhRelRuVVUrR3pVYmhvVmdPUWh1UHJERk1MY2l3SkJZdG5ScEtv?=
 =?utf-8?B?QWxjZUtTbWxGRFhVZEpUTnp2QlBYY2FwSjBwb2djYSt2UWk4ckZYd2FiYVRO?=
 =?utf-8?B?bVlEUHJrTDdZNnRJZVg1VVBtaUlhZ1gxV29VWHZ3cXhZSWVvSThBRCtBVzNv?=
 =?utf-8?Q?IJfDpQkJYGg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWxqcEsvLy83RmJ0aTZPMWNJUWVPWjRTTFk5RC9vWTRmWC9MRUlPdC8ydlpz?=
 =?utf-8?B?Zkp3T014bjdxNU44ZHJPZ01XSHU0eXNKcFU5VEJUOTREWVIyaDhBVU0welo3?=
 =?utf-8?B?SXlDazArSXBUMHJaeVNNZW4zMnp2THVTRk53N0hXaHhmZTNpVDFXWHU2TjJi?=
 =?utf-8?B?Qy9Kcm1MUCt1U0wrKzd6b250YlIxdUNrVkNldmNLR3VGUC80Qy9OUTFaeFhs?=
 =?utf-8?B?M2hmTHREaEgyUjdvVEY5THNwSndyVXZXWndiS0tadnh0dHUzNStacWNaa0sy?=
 =?utf-8?B?Z2ZOKzZDNGJXbzdsczh4UGFhUVR4ZDZNSHY0eDE4N1ptcW5XeE1BUVRGeGxG?=
 =?utf-8?B?a0d6WlkxTEliQ1NINFk4RnpReXFkak55azB3S25NOE9rVW4xUGpVS0dQNmFU?=
 =?utf-8?B?M05pa2VrN1cyRWFRcFlpUktoYTBDOW9BNjl6NGI5cHQ4Y2IxdXdCQUVBNHVn?=
 =?utf-8?B?RUJlZFNlVW9Hc3NjNEQ5Z1pYZk5UQlVEaUVUNkRDcUxjWkZVcEVocyt1SVpJ?=
 =?utf-8?B?MkVINWFxamVUdWVXaW5qTTlxT1ZERVNTeVBGZUFjdm9va2tNT2o4MWtqZy9l?=
 =?utf-8?B?SUFhZmZjR2hTU2o0TG50c2J3Z2xxSXJWMnVheUhIaElJaTQ2WEttMjdkT2ZM?=
 =?utf-8?B?TGdLNWRNVklXd3JBNDRqVWxEano2NmppcUdYQkgxZDU5MUZzWkowOGU3Vkk3?=
 =?utf-8?B?M0RhR3N3NU01QVd1N1pud1hYMjNEc3RlTHhuQVRyRThKcDhURlBER3pIcmNY?=
 =?utf-8?B?Umc5eU5QODBubnhhdk5CazhxcE9xa1RLZFI2TUd5ZDFJOSt1WHA2SjF5bjRI?=
 =?utf-8?B?TWtZNG5RRXdySGJ6VFZRQTNWVFc2WTk1cGZrQ0xiT2NQN0tkNlZqaEI0VXhU?=
 =?utf-8?B?NXdHYUNmWDJZcE1QYWVYRGhQVkQxSHhTakNYWkt2d2lsVWFUbENlMWVmb0dn?=
 =?utf-8?B?bVdIY3NDM1hob1dPZy9EYXJOeSt0Uzcycm11OWpZeW9MQmJpQWRGQTh1cmdo?=
 =?utf-8?B?d1c0SXJvKzZySC80UnllNnQrMGpUdFc5bjZsQ2ViRFhVU1dOSWkwaDJjRzVE?=
 =?utf-8?B?SDhEV0k0eGV0d0tTUjdIV2FZVmpRWGpBMGNTYXpkQk93WnBjclhDSHFYV0dM?=
 =?utf-8?B?L0NvTm16TndEYm5KZXRxeGtSTEFXTlQwTmQ4bFAvUTZYNUkzL0ptQ20vQlFB?=
 =?utf-8?B?QVNuUEYxYzBzZ2lZdkNUbmQrYnJwYjFYQXpxK29jRVBNZ1llZnFINE96ZmVs?=
 =?utf-8?B?YlRYWnZ3TGUvWUpzaHhzVk9DU0dEMFN4d2hMVHlJVmhhYVV5WlQ2cjkxay9E?=
 =?utf-8?B?bWdndUVLdFhtM1QySE1yRzR2bzh4STROcEdQUEE2TGdHWGg5Y0tHaXlmNEti?=
 =?utf-8?B?dENoL2pyRWlkSWV6T3IyNTRBKzF1WGhnaFA4TkdLUzBrV0NsdmRtQ0hjZko3?=
 =?utf-8?B?WHVyYXJMYjYySEhMR1BhT3V3bU14T2FaUnlNK3FIZDBBeDExUURUVTNNVmJT?=
 =?utf-8?B?YVJSL2ZTTExNUDZCa2Z2LzQxdDdSSU4vMTU4STNRUHhKS3NUOTZwVjc3WEwy?=
 =?utf-8?B?YTJnSlFsWjBHWTNEc1BFb2s3RWJkalR1RTVFZEd6RmdySUQ2dmJ1a3pGSzd6?=
 =?utf-8?B?K1QvTEgxT2RpelhaOEZKWnk5YlN0N0lITTJ1VVhpblJpbnpFdmNUTDErREVV?=
 =?utf-8?B?Z3FZZTFTM25aM0dFSlgrRGhOSzZTaGFUdi92VGowWTJYdFlxWS83Sk42dm9L?=
 =?utf-8?B?NmlOVTV3T1Z4M2l3ME1DYnlHNk1yWW5LQUpNMlMwdnEyY1dUUnkyMThFZFZk?=
 =?utf-8?B?MDZkR2dHbHNiSW5TbnliVUVreFZYVXJhemt3MUhjcnpzN2pJNEFiZkhrQVVI?=
 =?utf-8?B?YUh1cHl1STdqcjlDODdKNXRNcWhkWm02aWg4eXQ3RWpOR0NhQ2xrSXhJWTg0?=
 =?utf-8?B?Y3VvZU9KQ0FJQldXaXhLdThFaG9Ua1BnVmQxN1ZnMFBtalR3dVpyY3JYbFRy?=
 =?utf-8?B?Y0VKSkxNZG9wQlg1SG9rQXB0Ylhod21iUWNvcGtqd2d1bkJrUHk1WTZVQVZ0?=
 =?utf-8?B?RTJ5QmdRTEZPeis0NE5oREM5QzF4K0ZPOWtNclBlb1h3ME5uTHBaUGMwNW00?=
 =?utf-8?Q?YONfq1GUdBi6VxN+AYolr4fmx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ff70d8-4489-4e88-d03e-08dde937f4b6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 09:14:29.6371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NdBMfq76L+NuiDKBV4/gGc9KV5RVsgkyXAVFjKPP7AOw932ZEMhTwpZsCU9K9Ywd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7865
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

On 29.08.25 15:55, Srinivasan Shanmugam wrote:
> Implement TTM-level behavior for AMDGPU_PL_MMIO_REMAP so it behaves as a
> CPU-visible IO page:
> 
> * amdgpu_evict_flags(): mark as unmovable
> * amdgpu_res_cpu_visible(): consider CPU-visible
> * amdgpu_bo_move(): use null move when src/dst is MMIO_REMAP
> * amdgpu_ttm_io_mem_reserve(): program base/is_iomem/caching using
>   the device's mmio_remap_* metadata
> * amdgpu_ttm_io_mem_pfn(): return PFN for the remapped HDP page
> * amdgpu_ttm_tt_pde_flags(): set AMDGPU_PTE_SYSTEM for this mem type
> 
> v2:
> - Drop HDP-specific comment; keep generic remap (Alex).
> 
> v3:
> - Fix indentation in amdgpu_res_cpu_visible (Christian).
> - Use adev->rmmio_remap.bus_addr for MMIO_REMAP bus/PFN calculations
>   (Alex).
> 
> v4:
> - Drop unnecessary (resource_size_t) casts in MMIO_REMAP io-mem paths
>   (Alex)
> 
> Cc: Christian König <christian.koenig@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 27ab4e754b2a..5f378f5c9350 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -123,6 +123,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
>  	case AMDGPU_PL_GWS:
>  	case AMDGPU_PL_OA:
>  	case AMDGPU_PL_DOORBELL:
> +	case AMDGPU_PL_MMIO_REMAP:
>  		placement->num_placement = 0;
>  		return;
>  
> @@ -447,7 +448,8 @@ bool amdgpu_res_cpu_visible(struct amdgpu_device *adev,
>  		return false;
>  
>  	if (res->mem_type == TTM_PL_SYSTEM || res->mem_type == TTM_PL_TT ||
> -	    res->mem_type == AMDGPU_PL_PREEMPT || res->mem_type == AMDGPU_PL_DOORBELL)
> +	    res->mem_type == AMDGPU_PL_PREEMPT || res->mem_type == AMDGPU_PL_DOORBELL ||
> +	    res->mem_type == AMDGPU_PL_MMIO_REMAP)
>  		return true;
>  
>  	if (res->mem_type != TTM_PL_VRAM)
> @@ -538,10 +540,12 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
>  	    old_mem->mem_type == AMDGPU_PL_GWS ||
>  	    old_mem->mem_type == AMDGPU_PL_OA ||
>  	    old_mem->mem_type == AMDGPU_PL_DOORBELL ||
> +	    old_mem->mem_type == AMDGPU_PL_MMIO_REMAP ||
>  	    new_mem->mem_type == AMDGPU_PL_GDS ||
>  	    new_mem->mem_type == AMDGPU_PL_GWS ||
>  	    new_mem->mem_type == AMDGPU_PL_OA ||
> -	    new_mem->mem_type == AMDGPU_PL_DOORBELL) {
> +	    new_mem->mem_type == AMDGPU_PL_DOORBELL ||
> +	    new_mem->mem_type == AMDGPU_PL_MMIO_REMAP) {
>  		/* Nothing to save here */
>  		amdgpu_bo_move_notify(bo, evict, new_mem);
>  		ttm_bo_move_null(bo, new_mem);
> @@ -629,6 +633,12 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,
>  		mem->bus.is_iomem = true;
>  		mem->bus.caching = ttm_uncached;
>  		break;
> +	case AMDGPU_PL_MMIO_REMAP:
> +		mem->bus.offset = mem->start << PAGE_SHIFT;
> +		mem->bus.offset += adev->rmmio_remap.bus_addr;
> +		mem->bus.is_iomem = true;
> +		mem->bus.caching = ttm_uncached;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -646,6 +656,8 @@ static unsigned long amdgpu_ttm_io_mem_pfn(struct ttm_buffer_object *bo,
>  
>  	if (bo->resource->mem_type == AMDGPU_PL_DOORBELL)
>  		return ((uint64_t)(adev->doorbell.base + cursor.start)) >> PAGE_SHIFT;
> +	else if (bo->resource->mem_type == AMDGPU_PL_MMIO_REMAP)
> +		return ((uint64_t)(adev->rmmio_remap.bus_addr + cursor.start)) >> PAGE_SHIFT;
>  
>  	return (adev->gmc.aper_base + cursor.start) >> PAGE_SHIFT;
>  }
> @@ -1355,7 +1367,7 @@ uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem)
>  
>  	if (mem && (mem->mem_type == TTM_PL_TT ||
>  		    mem->mem_type == AMDGPU_PL_DOORBELL ||
> -		    mem->mem_type == AMDGPU_PL_PREEMPT)) {
> +		    mem->mem_type == AMDGPU_PL_PREEMPT || mem->mem_type == AMDGPU_PL_MMIO_REMAP)) {

Maybe put the new check for AMDGPU_PL_MMIO_REMAP on a new line, apart from that looks good to me.

Feel free to add Reviewed-by: Christian König <christian.koenig@amd.com>.

Regards,
Christian.

>  		flags |= AMDGPU_PTE_SYSTEM;
>  
>  		if (ttm->caching == ttm_cached)

