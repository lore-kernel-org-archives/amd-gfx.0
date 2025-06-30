Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E16EC8302D
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Jun 2025 08:56:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30A2110E3CF;
	Mon, 30 Jun 2025 08:56:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DoTmdhxE";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DE0110E3CF
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jun 2025 08:56:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/6iBZDuHs2rLo2RYbuksVQbcZ6Zq1x9ED5VnP/BAsn5HucfxeB0mz4QUCsMBl5kjdnzH2Q29Asr1bO4eqwXC5SO21G3GwIswYjti3U8WUHFTpY5Dmzo+pAB3vexHjYzvcvQOWyrOMMMHhEcIucX8eCjrZ5okcxL9jcPcEgJrH0TqDnvGsdaopzZ/qKdtzQ+dPp5KqumlGAfNtScU6Oz1ri6fEhPseMHjDWgZc4EigSJBPx444bajZ2fbqAqieDEUUnZ2kRKf7FkV2vbg4RIa15qPCvUPhuS01lfiATdH6vq0yXMbicrLd0bJPvcpk/8yosKHMttWhOmkY7X6Jx9WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6khtSNqG5bPmzTLOo+7sl4GM0xRSblUYl6TcTYkXG4=;
 b=bwy3wc+M+9FhP4Ay7rh9MJI6iMnFLA+TaOedQXcRnPM9gunUfLOiydJ34Kgo9S19YocCL/xFkbP2abLWuWbUT+/m45irRE0rZ08dGUsAU8H5vUCcsS/f0DgA3CYfOHocDHGsEeEUMjLusPyVX3j6HbsXGpaDVcLGg7nIm63fpFjEei5XLGQrXVDuzzJ2QiChBCewCtHvfxE1jTw1RC2ua1jAOraAToLyvfVqYuq2wLW/pxxoKsf7Sdfond/2HSAugCNgOdwUWAZz2jYNbAkN4ulLcDOWy79kl2f1m4D/M2I+TwX3nLxmT0HJno3kMhRUqt5nBtn/dmnmXZLVHj/HXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6khtSNqG5bPmzTLOo+7sl4GM0xRSblUYl6TcTYkXG4=;
 b=DoTmdhxEGXkv/qWTC29+/7JTgurB4yLZEfPr9Aa5awaiepUpth6EQ51twEUmemGT5wfhV0F7uwb8R/S771E3HTzPfYveaDqhe1CYArdHO4g38ASPvOLJwA0A+BWIayI96NBhMA8qj6OXYROGSkFmGFZ4iUKYyTMwsA/VMsEjwEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB5678.namprd12.prod.outlook.com (2603:10b6:510:14e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 08:56:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 08:56:40 +0000
Message-ID: <6c9dee37-cbc8-446e-ab18-6e88259eb26d@amd.com>
Date: Mon, 30 Jun 2025 10:56:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/33] drm/amdgpu/sdma7: clean up resume code
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 sasundar@amd.com
References: <20250627034002.5590-1-alexander.deucher@amd.com>
 <20250627034002.5590-8-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250627034002.5590-8-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0218.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB5678:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a3ff876-243c-461d-590c-08ddb7b40793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WU9zWlFSc21ERmwzakw5bzB3cjFhUWZMamszNkljVnlkN1VOVjFKcnNaSGRl?=
 =?utf-8?B?ZDdlc0FOT1FrcWh4S1JFNXBGUS9yMmFKazZuRkhIYnBybUdsZDdTV1hCOXp1?=
 =?utf-8?B?VGMyZ0V1SU9KTkpVUCt2RERhS2dPTWpSaVhVT3BhTE9WcGY3Z0JZNHR2S2pk?=
 =?utf-8?B?TWRhYjl4YlhVUVRzcVVBV0p0Vys0Vlkxa3l4cDR3MkVSb2ZXL3h5aVc1eUts?=
 =?utf-8?B?a01uZ01PSlhRMFdIN2ZuTlB1MkxtWTZUK1NYQkJQNkVUc21GN28yRDE4dEMw?=
 =?utf-8?B?MWNXcFpzT1dIMGZRaXlhR0VrNFhiZERQclZvRWEzN2J3aUNvU2t2T3IyMUdW?=
 =?utf-8?B?cWdoRUFYYWUwVWhkVVQybG5UdnQ2a3dTTTlSME9jZjRQSnp5RlRoRUVoVXZw?=
 =?utf-8?B?QjBBUXZLNzc2UjJFMjhhYldRM3JTaE04Z0d6a2VtWWMrWU9xL3lIZjEzWmlj?=
 =?utf-8?B?anJyeERtUmxDOHhwQVpwLzBSbEcwcEtuamxwS3lpNFU2NWdDUmJBVlhBZTNj?=
 =?utf-8?B?WW1mT0lJbkJYYlNtV2xGbW9OQ09yWFNySEhPL2RQUGMwN0FqMXl0VHNsbWV1?=
 =?utf-8?B?N3BZV3VKVXh1RUdEa3V2cTltbW9VQjlFdVlIMWwxMGtId3AwM3ZJbG8vT2hV?=
 =?utf-8?B?TEhzM0FpUTlyZGhnczY0SVRwdmExa1hNcGozNEVUa0VCUGxXWkF2cDhxOXl5?=
 =?utf-8?B?K2h2bW8xamx4TVc0K3RYdnJMSGNITC92QzJEMjRVTUtuYUkyTlhNK0RHQVB6?=
 =?utf-8?B?WlVrKzBMRWZWSSt1Y3kwamUrTHBlcHl4aDNMTDNVVEp3VjZ0YnR6WGkvU1lZ?=
 =?utf-8?B?cFMyMjRuTkF5RDhIdTRESGtTeXMxZUlVZGVVbzZyM2U4MGVRT0lROEdSVEpp?=
 =?utf-8?B?R3JVQWczR2R5U0xENHhGcDk5QzJFS0gzbzgwRnl1RE5nbThBQkV2SW5Ub2VB?=
 =?utf-8?B?amRrU2ZjWXZEb3BoQ3hNcDhHMnBleXBPMzdBK040Qk5VMU1BaEtZZ2M3T3M4?=
 =?utf-8?B?Q2J5UVRLeWJQQUR6c1UzdkxacmVTOTlMVnlVclRnNE5UU3dnWVZ1THBYYWdN?=
 =?utf-8?B?OStrWVNxdjE5eGtGako5RFpGZEJISmZnSEZmZW9EZlF3eUFwWWlUZ1FiZk03?=
 =?utf-8?B?ZjNyNFlLQkZNZW9wZFVXVEE5UGRIN0xyMXI1VHl3Y1VYaHZiZGJ0YlNYNTBQ?=
 =?utf-8?B?c1VockxpUkNFdUFibXovM3hJWTN3aXFpKytZZytScHBTb2VsbkJTR0lvNVky?=
 =?utf-8?B?NE9yVlBVNEl0REl4bFNheTk1d2tONjlHSlE1UDJYcTh4S1g0SmFVTW4zZlFG?=
 =?utf-8?B?U0JXQmVBSUZaT1haVVhOWVpUV3UwdStoWW5LTGpUWU1QSVdLUXBmNlh0dDFX?=
 =?utf-8?B?aXZhbU5xRHU2MXR5QTJzNDlTQ05SUmVNcVJZSU5uOTNncjNDeEFpU2hwMXVS?=
 =?utf-8?B?K1VaQ0JjMHI2cjRKNXE0UlFUN3ZTVEhwa09ZVlh2MUI4OTNaY0xZZ0Y3M0VP?=
 =?utf-8?B?SHJQVENDNENITGxOYkZyL0J4RkFjcDNSZjFJRithQ2ZJcnZlSTNrWjVuL2t4?=
 =?utf-8?B?c1I0K3A5cG1INmNiVHhmTDFHMjR6bHFFWWxDNm1keDZXQ201cDgwcGUxa1VY?=
 =?utf-8?B?cjBYbGFDNlQrdDRwMTFLdnZTdVNZSHJxYkZ5Y200SFF0NDVzd1pSRk54MWxR?=
 =?utf-8?B?Vy82MUQrbGtjZVBTUGwydjVmSlpaR2JKeTdIcnFpSTJiUmNzMjZIT1NmdWRE?=
 =?utf-8?B?NGltRk1TV1FvL1ZtQ1hIWnZxWmxNcHc0SFhkcG1DM1V5K3l2ZXN1V1QxT2Jw?=
 =?utf-8?B?NnVsdzdhUU5xV1ZlODcyZ09iR0tIT1JWbUZYdWVPYUg4V1dWdWVRZCtkMWpO?=
 =?utf-8?B?OU1zN1JENTc2V0lnSWNKNjRBVHM1SWpKZiszOXgxME9kbHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUYycENsU28wV3ZrdXFJRkFlYnZqcnhDT3QvNXJVbitxdVIxRUlHRHh0S2lY?=
 =?utf-8?B?UWFFRFRMVFhKVU1ZRyt5ZHBJdTN4WHBreWQzbmJLYnZ3V0V5Vy9kWWgxV0Jy?=
 =?utf-8?B?Kzd0Vk5ZeHc5TmJCQWMwS1pSK0tNWkVyd3NaL1EvZVpWQ1dudk8rU0puZnFG?=
 =?utf-8?B?Q20rMTZycjBuOGpNOGVJZlVOc2dLbHNmS0tFQlBiclB4YjNFekdIOFJRV1Vx?=
 =?utf-8?B?T1Jyb1FkN29JMWlVcFZFd3lucmNVNURieUxKWE9TNzIwbzFRVGUzTE5wdnFi?=
 =?utf-8?B?M0VaU0lTT0oxb2pFOHZKUWZyMGtYMU11Q29wWlgwUHh1bStBREx2V3ZPUStO?=
 =?utf-8?B?SEcvZkpGNDVQOXZqL2RSM3B3c2J2MGNGN3MwZlpSMFhDbmtDRlVrUUtKWlgw?=
 =?utf-8?B?U2o0Nm1FSHB2Zk50d1RHbi9teWFseU9VOGtoUTQycFZEUFRMU3h6anZBWi9R?=
 =?utf-8?B?R0JrK1lxVDI4RXZVQUU4aU4yekQzV0d2Ry9qcENmc2RHSzhxc2NzNW1vR1Za?=
 =?utf-8?B?dVdqb21SdXkrb2E2NExiSTIzR0xmclQrcjhzQ0tNd1hyYW9KaXlscGhxdUxi?=
 =?utf-8?B?bklNeFlMYXFHaThWQjRZVkVPbGljMTFLaTFhUVVMaHNJNytqbnFsL0ZrdmQ3?=
 =?utf-8?B?UjY2bHQ5SUZ5NnJod3dyYkxLTXAvUmNLTjB6OXk0RXhBS3IyM25BTFVTYjFO?=
 =?utf-8?B?L3FITDVhWENmUG1IV1hKZmlYYndzeGdEdnJuT2ZoUFJSZmU2V3pHZWtyM3Iv?=
 =?utf-8?B?aWJYRVhybGtSc21IQWRtbXBQdkNRK0NHVi8zazBIYmcrMk1DY3lwN3QvV2dt?=
 =?utf-8?B?a0JPdGNBcXdzdUNWT09nY2M5OTRKRVN4ZTlvNFZPWU5JOENjZlp0UXlwRkZW?=
 =?utf-8?B?dTBPVm96U21Zd3NwdjZrVDI1K2FsOFdtbm9mRTl1K25heU5IN3BlUGNXeldQ?=
 =?utf-8?B?enE3Y3ExZU9nbUI2OUI4QjM1aGRCQ1BzMXlGdHhhT0w3aXhKUHlROWF3M21W?=
 =?utf-8?B?Z0s4YnJJVnJWUGNueGk1Z1lQcW9lc3lLaUUwdjBSVTBqSGhpa0NrL1dTS2RY?=
 =?utf-8?B?MWhMNncwbEw5QnhvRi8ySWxSTGRqVzlGR0tQSnB3aW5Ucmw5RlhjaFRXWUty?=
 =?utf-8?B?N2IvVHRHUkF3WVpTRXJUaDJrT0NicUp1NDNmajY2WHAwY3A1T1doSElibmlB?=
 =?utf-8?B?VEpCWHVMdmNERXE5OVZ2TjFSQzQ4dFA1cisvZjkrbzFycXdHMlBXeGFKZVhk?=
 =?utf-8?B?aWN6eHM5cXYvUStKUTltMWxsaXM4Uk12Q2k3eVNDOUY4SWRMakVQY2YvT00y?=
 =?utf-8?B?TkhrTGNqNU16a1B4Ri9oUys1WjV4bzdjbGRvdmZ5L1FHbFRXRWo1Y1dwWEd4?=
 =?utf-8?B?c04xdEpNV1J6V2FYS1RERE16clo4OHhmRjRKcVlzcG9hSTNSeVM2d3ZsYklY?=
 =?utf-8?B?ZGhRU09xa1dSVStJUFpLYkI5ZkZ3dmtMTE1EcFFlcEtEMmJSSnRibXhBZWVP?=
 =?utf-8?B?V2ZmMDB0REFUL2hOREhYOUw4Z09WRSsyaHArMG9sRG1kc0xJbG9vZDZkZGtP?=
 =?utf-8?B?TmJjc0tNeW1tUFhkcmNmSmNFWm9LaXViQTFEU3B1TitvNkg1TXM4ME0vbVRw?=
 =?utf-8?B?d0xLRG5nYmNSeGVybDFtb1kwVUNRVWd1RGdHU3BDMXIxUWlTbkw4VXMwdlBr?=
 =?utf-8?B?dmRWS0wrMllsa2tvbDdIWHQvZUw1ODNjeWNsSXNRRENGdWFOQVp0OWFYZHFG?=
 =?utf-8?B?RFExaFU3OTAyRGxDV3dPQWx6b29SYWdKVGV5NjdlSWJGSkNjUzE2UkxOeE5v?=
 =?utf-8?B?bUFkdFl1b2ZsNzRNSVdTVDJQeWJYaEZGNXo1bkRlaDM5dUt3Rnc5UzRPWHk2?=
 =?utf-8?B?Ums2SHRJSllrUC9zaVVnUHZrQ29aK3FnY0JaRXN4cHRKU0NBZXk0WE5obk5B?=
 =?utf-8?B?V2hHQUxOZGRIVXMzZi9VZ3o0WjR0RjVVM3dGUTF5KzYrcWtQYThORlNKK2pO?=
 =?utf-8?B?a0Rwc2FNZjJTSjFKazFNdHk2QTN3V2lzVXVacG5SRk1SMCs2TjU2dHBxajg0?=
 =?utf-8?B?WGtObW9oTTQxODBmc2VheVhGNndJQXVFUmJSbFVCLzAwcjdFSG1WSFZWRmZZ?=
 =?utf-8?Q?JOB7PzguN1e2k9v3UVxkg8Sno?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3ff876-243c-461d-590c-08ddb7b40793
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 08:56:40.7311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6YtOR2hb8hcdLst4nWBUG1hHm/6QBVvE8wtnztGZeHd9pXkqLyr8EcPYqMR+2PpU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5678
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

On 27.06.25 05:39, Alex Deucher wrote:
> There no need to save the ring ptrs.  Just reset them.
> This cleans up a conditional in the resume code.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 28 +++++++++-----------------
>  1 file changed, 10 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index 99a080bad2a3d..95e54a1180ec6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -467,12 +467,11 @@ static void sdma_v7_0_enable(struct amdgpu_device *adev, bool enable)
>   *
>   * @adev: amdgpu_device pointer
>   * @i: instance
> - * @restore: used to restore wptr when restart
>   *
> - * Set up the gfx DMA ring buffers and enable them. On restart, we will restore wptr and rptr.
> + * Set up the gfx DMA ring buffers and enable them.
>   * Return 0 for success.
>   */
> -static int sdma_v7_0_gfx_resume_instance(struct amdgpu_device *adev, int i, bool restore)
> +static int sdma_v7_0_gfx_resume_instance(struct amdgpu_device *adev, int i)
>  {
>  	struct amdgpu_ring *ring;
>  	u32 rb_cntl, ib_cntl;
> @@ -498,17 +497,11 @@ static int sdma_v7_0_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
>  	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL), rb_cntl);
>  
>  	/* Initialize the ring buffer's read and write pointers */
> -	if (restore) {
> -		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR), lower_32_bits(ring->wptr << 2));
> -		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_HI), upper_32_bits(ring->wptr << 2));
> -		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR), lower_32_bits(ring->wptr << 2));
> -		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_HI), upper_32_bits(ring->wptr << 2));
> -	} else {
> -		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR), 0);
> -		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_HI), 0);
> -		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR), 0);
> -		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_HI), 0);
> -	}
> +	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR), 0);
> +	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_HI), 0);
> +	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR), 0);
> +	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_HI), 0);
> +
>  	/* setup the wptr shadow polling */
>  	wptr_gpu_addr = ring->wptr_gpu_addr;
>  	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_POLL_ADDR_LO),
> @@ -533,8 +526,7 @@ static int sdma_v7_0_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
>  	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_BASE), ring->gpu_addr >> 8);
>  	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_BASE_HI), ring->gpu_addr >> 40);
>  
> -	if (!restore)
> -		ring->wptr = 0;
> +	ring->wptr = 0;
>  
>  	/* before programing wptr to a less value, need set minor_ptr_update first */
>  	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_MINOR_PTR_UPDATE), 1);
> @@ -635,7 +627,7 @@ static int sdma_v7_0_gfx_resume(struct amdgpu_device *adev)
>  	int i, r;
>  
>  	for (i = 0; i < adev->sdma.num_instances; i++) {
> -		r = sdma_v7_0_gfx_resume_instance(adev, i, false);
> +		r = sdma_v7_0_gfx_resume_instance(adev, i);
>  		if (r)
>  			return r;
>  	}
> @@ -828,7 +820,7 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  
> -	r = sdma_v7_0_gfx_resume_instance(adev, i, true);
> +	r = sdma_v7_0_gfx_resume_instance(adev, i);
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);

