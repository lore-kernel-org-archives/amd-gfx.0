Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5556ECA0FE7
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 14:37:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D885510E045;
	Mon, 25 Aug 2025 14:37:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ylhu0Aqc";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4C7D10E045
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 14:37:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0tekB/0w21ckca15W6G+npjgwwd8+ZFDjMq3eoWHYXucLb9J7VXwwjSiExIHbOsTQLus+LHUwBC+b5eUUDW2b9eZVmHrKI49jRNYORCfT+NJhVk7o3i5RdDwETOhoEvY09Cr7dWUTvaV+3N7A2AdhsByymUmwJWINLw9cPEISRUBmKmYUBUGhxfhv4dn7gqoAlR0hDMaWWu+omZY6poqvIxV1j5J95sIGLFmlSvbgQndU8IF3EOmZxyVHYnBuOODkT/vuMRvVtYaBlzdhq6Bc0j2gQsG86ltaxkkx2vrg+a58T32ntBtuUSgpp+WCgUTHWNEhCOy52u6SzmbqpvJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Gco35aayyCkBQBnebBwQk7IzcWt4Nw9aLNu4OvwH8c=;
 b=E7QHrv5ESHAo2im9JVvpCrCJZYyPwuU28UaVL5UBvucE23TdZQi7XPzchAwBrpyefnDyiQd+KbtD2yPBauslUxAf+MQWDk5y4bc9Rv/+qty8qx2duVJ54tXUVweNwl+T+TkmN0D4UNQbPhheMhFYXPT0JsrDfVPPYOBGVHJrPos8DdzYZXU9r7bVkYEHQL88YG2xXz7LpBqcRm5ZUL0nMYUEQW0+i/8gRu+RosUFHo0xm/59GaG/QzD5dsYNGXjxG4hJE/9u0cQDdEGb6H/VpP1ddbX48xMAsaT7rBdDBPTcJWmAaTY+dDDvhTpxvdImz11Qgx/b+7Qc8v4eqNdtBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Gco35aayyCkBQBnebBwQk7IzcWt4Nw9aLNu4OvwH8c=;
 b=Ylhu0AqcWM8r6rIQppJD52+X758Zug45sb5/YP21sdWgu0fGbCKa7hjlsJutMZ460CGamaU+UXcY3+X0KnSpjZqld/bJA02P1GsdXIxM0d9hjXvnIdN55Y+rCYUwWIUUBpHz6Ioa5JymscU/fMTg88IO0Ycp1oL5BDFe4TRTF64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB8556.namprd12.prod.outlook.com (2603:10b6:208:452::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 14:37:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 14:37:51 +0000
Message-ID: <5de56a55-0f19-499e-b4aa-b89aef896376@amd.com>
Date: Mon, 25 Aug 2025 16:37:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/7] drm/amdgpu: Add New TTM Placement -
 AMDGPU_PL_MMIO_REMAP and wire up plumbing
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
 <20250820113254.3864753-3-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250820113254.3864753-3-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR16CA0014.namprd16.prod.outlook.com
 (2603:10b6:208:134::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB8556:EE_
X-MS-Office365-Filtering-Correlation-Id: a35744fa-8c44-4eb9-f7a4-08dde3e4f7ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnhJVVF6S0EwZmZyU3F6eERHTUQ5TURVNWxuOFJialp4NTRnVDNLZCtXVnV0?=
 =?utf-8?B?bHFPY09YVzZpWitEc2d6NHdiVXpkOG5oZFJ6VE94NldycXdSa1J4QXAzYUVw?=
 =?utf-8?B?VWU4bUdvUW5SSjQyM1BXWUlXTnNMRm81ZlgwZmk5Qy9kSEdNNE16L3Z4SnJD?=
 =?utf-8?B?Z3RhclJhQS81bUJNTmYrS0pIWkt0bUNFdnRST1ZJVHErMkhOTStIL3lvcTU0?=
 =?utf-8?B?Y25TR2NTUmxXOTZsMnJ1LzAyMHZXYzNLKzhWRForb3hEbkwvSFlrTFoxRTRZ?=
 =?utf-8?B?K0J0ejVteGJVWWUvcXNSeU5PVzlyRzFBamtaclRENTBUdURKRHlQNFpWMUJa?=
 =?utf-8?B?c2Z6eGZydzJISjYvVlJkeXEwem1PWTgySlEvUkxyN2FJOGpBYUFsZUJ1OGdI?=
 =?utf-8?B?YnFBTnprWlBEN3d2L2tvYnVwRmwvT1BlYnRWeHl2dnZ3dnIwbEk1Q2pxUnJQ?=
 =?utf-8?B?Mnh1T1Z3TjNjeUhybm5PVGZWRjRxYms4UE93d3QzaHlQNUUwcnl0YmVaZFQ4?=
 =?utf-8?B?Z0dlYlZIbktwU0twTEQrTC94bDQ2Si9JMm1OOHpUODVhcUY5cTBKcVQxMVZ3?=
 =?utf-8?B?R1dXMEhYRTBWcTFNeUFiVXFXNnppaWVZUUF1Z25PM29SOXRBa1Y1UGhNVExJ?=
 =?utf-8?B?WTNaNFZlTHBvNTM3ZHpWS2FlWnptY1prbTlZTUx5aXF5QzVFKzFxWUs2TnMv?=
 =?utf-8?B?UFlScXE5TFlzTGpMbXhoUjRoWlFvL2lGUHova3BhclBCVVZsRFF0cjBFbHd5?=
 =?utf-8?B?bUM4aHd1TmcwMUsrUWk1WWlNWW1iTjQzUmlpY0cwZFZlYVdhRTRVVkJYR3dC?=
 =?utf-8?B?VmFtYytIRlFOYzRmOFpaUkVNWkVvbENvbVJBcGZOOCtEUDVmcnhFVG00U25T?=
 =?utf-8?B?QWd1YlEvbU8yRzF1MmhuVkpORWJRWmNHSG5oVW1ra2hwUk9EZHdMRHJUOWxD?=
 =?utf-8?B?VHIyVzQzRHFNQlM2UWNocWZ1eUU2RUFEcVBIMk13Ri9qWmZqbTdXN2xCMlUr?=
 =?utf-8?B?UGVsSTVrck5veDJKTUx6ekVlNk1OWTRHWHdtUXFkcWc2OEpzK3BNcHc0YjQ2?=
 =?utf-8?B?S1BSaFVkeEcxRFRUS0l1ZXYwejR2ME9Cb0VjVlRQRkorRUhOV1VKMUF2SThw?=
 =?utf-8?B?Y0ZlUmZmMWhhaFJzMENBWHJYVW9laDRVZWJXazVoNXNEN283K29QSk9UeTdO?=
 =?utf-8?B?UXhPQjFicWpzUjhqRG9JQVBrb20zK205WGhUR1A4L1M4NkZHcjZKZ21yWlFz?=
 =?utf-8?B?aXpBa1g5OFBqZGp3R2JXUFNtWHdHNkt0YkpzYVY3SzFYdW96VkJiZnhIMyta?=
 =?utf-8?B?YzJhazVoTDZXdDJUKzZnd2RNZHFaYlN4eXYzK3JPUHNCSEFnSE5zdDlTUWxB?=
 =?utf-8?B?Y0hJN1FwaEczbDJzWVd5MytqSjdrTVlBYUhad3RmZjZrZ0ZKVlNGdjJ4NnBn?=
 =?utf-8?B?clVocVFZSFdMMUh2VkozTGZpMDh5a0RQK29NVFA0R1l6L3pwQmU2U0sxcmdu?=
 =?utf-8?B?VjBWdU1iYS9MWVE4V0ZnYnlVUHZsVHZsOGdLbzJhdEVYWGg3NXgvejRCUTFY?=
 =?utf-8?B?SStDdWJRVDhZZVRpNFVFSml1Z2FsYTdib3lkYy9adGNDOVR6NkJCenZHanly?=
 =?utf-8?B?MmFNcldPMW5LcEtObEFrbzFidll4YURzU0s4bCswUXMwUDhJWVpyM29qT0RR?=
 =?utf-8?B?NStrY1hxQWpYUFJGVXBCWkFINHhjanFJeGZjTHlua2RxanZpOFNUZXpwUndX?=
 =?utf-8?B?MG9HbmVKTkxlcGtGMUFTMk1FbmJld1g2Q1UxUGZRenREWHUxMXZabHBRY2xU?=
 =?utf-8?B?cWRBemdidTd0Qzd3QWQ2cy81QXFweTBjWmxieGxTcnN6bGlidVBoMHdHbDlW?=
 =?utf-8?B?bCs3UlBpS0pLZmVraU0xQkZHUENRUUF6eGpTUjMxWU40QVdZUU5jQVpJQmJX?=
 =?utf-8?Q?lsnSlLNAUUM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXFucm1IRXZMejBhaTdWTmMxMVVrc05DeFk4V2wxQ2pvbEY5NElWNGlIVnFp?=
 =?utf-8?B?QWFSM1hNOWNPb0p0WkdTOUxQeVRRTUtpd2lxNzdpaEM4TVF1ekh4T2tzUTA3?=
 =?utf-8?B?RFkvQXJjMGhEbTFLclZla3J4elJlQm5URTdGNldMckYzMmY3NVQxM1UvVlhu?=
 =?utf-8?B?bE1pZVoxbTBOZFdNbUMxNHkxNmVhc01pWW9HNzlUaU9VL0hBU3dueVhNUEdR?=
 =?utf-8?B?K0RTRUJsWGlYa2krbjRiTVV6OFFhYlRGK1Zka25xNzg1MUo5TkNzeE40OXhs?=
 =?utf-8?B?b21zVHhwOHVVb1Y5Z0JxQ0JWeFhiYytKUTBCY0lxNWx4WDZnRmd2Y1FCRTZQ?=
 =?utf-8?B?R2ZZZno4RUhrTkZnT2N4YjBScW5XWjRvQzJBd2xXcHZ1cDVMakI1SndwNDRm?=
 =?utf-8?B?enR4aVpRM1oxWUFkenlCY1NWVWZuNXRtT1c4NVc3UzRsMGFOSEJSWHVxSlJF?=
 =?utf-8?B?WkFiQWUvY1VhK1lRc1ZKcEt1MHpkZ0xpSUo2WiswVk1mRGxPSUVPQ3F0QXpm?=
 =?utf-8?B?ZG1Cb2dlazYzWVNVTWM1RlNSV2RnUGR0NVZkZE12Q3NWNTJZWTRGaFpVc3hK?=
 =?utf-8?B?ZnJRREQ0WWRLdmpMWUJxMFIwbzJab0pBVVYrSlczUVJrT3IyRWF1cjNKbDdh?=
 =?utf-8?B?cHBmUWRUSkl5Z2x1RnNMZkJkdHlDc1dzc2hqZHUzdm85U1NhaWx6OGxybzgz?=
 =?utf-8?B?ZmxEcGRzcVZmZlgwdk1uS0MxZWZiL0x2Zm5mTkcydEFxczBXRnNxMWRyRVdn?=
 =?utf-8?B?S1dQNUxPWUVGY3JuaWtDcGFsQ2I3MFU4aHlmcHlIWXVGZll0cVNWMnM5MlJV?=
 =?utf-8?B?TDhnRHk0V08yZmp6aFRLdTNXMzA4S205YzRKM3FiV1k5T0RGY3daMytNWmNQ?=
 =?utf-8?B?a29ML1RmeDljZ25yTmRXZnFBbkhvejdmTU1kSngvemFaV1pueVhNU1VWU0V4?=
 =?utf-8?B?WjJUQVhkZmE5UzZ3d2RoVFpoQkxab2o1dTNrWTVBdlgxVWdVMDJSMHYwZWxD?=
 =?utf-8?B?U3lBMnFmU3Z0cFQ1dkRqczljQXBuZkZ0aElLcmY4RVQzOE9YNHZPZUVGbG4y?=
 =?utf-8?B?UUFBNGc2RHRKdDdEZjdqZkFBV3p0MW5jWFZZN1ZhSERHVm5Hd2xwR3d0MS9n?=
 =?utf-8?B?NTJCQjZPUWtQVm9DcEZrMWUwVU03ckw4QmZJZTFsNzE5b21XL1J0WVlBbFBi?=
 =?utf-8?B?T3orYi9FM1V5R3M0bFN1RFhVS2hUejdMcjFNeEUrYW9mbmxxWTdoNUNxai9r?=
 =?utf-8?B?OEtkcStLSlRLeTBaTmdza1RoWlNWOTVlSWVJaGhkN1NnVVR4bWo5SE5CZWN1?=
 =?utf-8?B?d3JTbGNGNUlLOVFMenZDR2RPM3dtUlJKeGw0MnJUVzNWeTlQb0xRbXlvWXhL?=
 =?utf-8?B?VmU0ZTdFa016dHBPTFo1LzNXV3pydkkwZGRZWW1JZUxCM21SWGpRMzZLN3ZC?=
 =?utf-8?B?MGlDUHZ1T2hac0cveSt6TDRqUGd1YjF5WlcvRUI2M3hLcnVvcG8yUTlNOVRN?=
 =?utf-8?B?TzBTY0ZSUjVnd3lPejRlVWRWSjRlekpkUkRBTVdsWGl0S2FOUGdJQlR1ajFw?=
 =?utf-8?B?RUE5Z2JpcXh2aHpxdDJxdlRtS0VLbXFFZUdPMVQwcXptdUM0UVNXMHN0Nkx4?=
 =?utf-8?B?MDFuNkpzWHhkSnpOVFpRMGtWMUt0MUhwUGFXalNYY3BBQ2ltdFFyWWV2Z3NY?=
 =?utf-8?B?cTY1dGhianNYRktBVDFuY2g2eVhQQ2VBUDRpZnYzRlpMVmliOVJQbS85Q0tG?=
 =?utf-8?B?T3V3NWZQUEJwRkN3dFdOODVzZnVNaitKT05SMHNIb1N1K3VoRFFHalVqcWcr?=
 =?utf-8?B?bUNCTzUyY2ZFanF2MGp0MWdCWlRMVUFVTnBlOHhKN1BYQXF5a3lieXk1Rmw3?=
 =?utf-8?B?WTRMMkR1VzUzUjlCR1Q2U240S21uOFVzdW9TRTRrVGMyajVYV0gydUhQbDBQ?=
 =?utf-8?B?ZWliWHZoR2ozNEJjanR3c2ZBZ041czlBakQ5VTJhT010YUlQNDJEeWtBUXpI?=
 =?utf-8?B?T2ZINllvOVo2emticGY5TFF1Q2dTclZVMHFhR2gyeWN4bHM3Mkl6RVA0ZjR0?=
 =?utf-8?B?Nk80Z0RGT0ZHZmluWlpKaFMrUlpueDVOb084L0drVjBqYk5xRi9zVHZHYXpu?=
 =?utf-8?Q?XDzMDsyRNkVChbKLTqwoL5Z4f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35744fa-8c44-4eb9-f7a4-08dde3e4f7ef
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 14:37:51.0728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQb9u8g1HZc0FT6+tJ+G/sE5ceIME6UYiQBO3MOYjLfCigrb7VAUBhPyl50HTMJW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8556
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

On 20.08.25 13:32, Srinivasan Shanmugam wrote:
> Introduce a kernel-internal TTM placement type AMDGPU_PL_MMIO_REMAP
> for the HDP flush MMIO remap page
> 
> Plumbing added:
> - amdgpu_res_cursor.{first,next}: treat MMIO_REMAP like DOORBELL
> - amdgpu_ttm_io_mem_reserve(): return BAR bus address + offset
>   for MMIO_REMAP, mark as uncached I/O
> - amdgpu_ttm_io_mem_pfn(): PFN from register BAR
> - amdgpu_res_cpu_visible(): visible to CPU
> - amdgpu_evict_flags()/amdgpu_bo_move(): non-migratable
> - amdgpu_ttm_tt_pde_flags(): map as SYSTEM
> - amdgpu_bo_mem_stats_placement(): report AMDGPU_PL_MMIO_REMAP
> - amdgpu_fdinfo: print “mmioremap” bucket label
> 
> Notes:
> - This patch bumps __AMDGPU_PL_NUM and (for now) TTM_NUM_MEM_TYPES to
>   avoid compile-time guards.
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 3 ++-
>  include/drm/ttm/ttm_resource.h          | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 2309df3f68a9..bb17987f0447 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -34,7 +34,8 @@
>  #define AMDGPU_PL_OA		(TTM_PL_PRIV + 2)
>  #define AMDGPU_PL_PREEMPT	(TTM_PL_PRIV + 3)
>  #define AMDGPU_PL_DOORBELL	(TTM_PL_PRIV + 4)
> -#define __AMDGPU_PL_NUM	(TTM_PL_PRIV + 5)
> +#define AMDGPU_PL_MMIO_REMAP	(TTM_PL_PRIV + 5)
> +#define __AMDGPU_PL_NUM	(TTM_PL_PRIV + 6)
>  
>  #define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
>  #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2
> diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
> index e52bba15012f..f49daa504c36 100644
> --- a/include/drm/ttm/ttm_resource.h
> +++ b/include/drm/ttm/ttm_resource.h
> @@ -36,7 +36,7 @@
>  #include <drm/ttm/ttm_kmap_iter.h>
>  
>  #define TTM_MAX_BO_PRIORITY	4U
> -#define TTM_NUM_MEM_TYPES 8
> +#define TTM_NUM_MEM_TYPES 9

Please make that a separate patch.

Thanks,
Christian

>  
>  struct dmem_cgroup_device;
>  struct ttm_device;

