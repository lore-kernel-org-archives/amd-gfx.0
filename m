Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A469CAC586
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 11:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA69710E13C;
	Mon,  8 Sep 2025 11:55:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AgKF6y68";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 146E310E13C
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 11:55:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MzdZGFelmAUrfVBg725G+EkXTvRIo10y3jOd6XSWZUfifmhYE3+hv4eJPoX1Bqn0sBuBPBbm2e4pN9sESEjhE48bP+rAGbuiHHbE5H2qjEbrVd7hNRyLNvd1MwnX2q6ChquUBkJ9xecsy2HimQh5H1J/GYCGQ2Klep8yww12WAiTDqT2bve71j56QL3eeClNGAMF0I3z/9YNs4xRtBvHIukWqFSBM2sZHZqZhUGOmHYehA3+oJswLomdPWjnOexoPJzLyypvZKJAuAF0tE6G+ugGyjYlzCs70bl2a6sFvGOF/c/h76s/xgHJRlCq/Z4heevxOI4lni/A0UCXmVIU+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJj/TJVCjM+JgzlH0J+CkafwQhK1n8P8BTlWKgrS4uw=;
 b=dJRsTpwmzfY/17fSwU9ErP4iNLybYGucOC/bTwSP1bNzTJdbrKbmpXDPIEBF5mSljn+Xvrr0XfRqNYaYH2cVwpbVwXPudBGYRSPHPO501+wgQkWAEahitAVbSQi1yDlI9Za183hKkrJ8nw1OcRP3fDmtUMhXJsNaLAq03+NCT8Yq7qI/8jZMlFP1OhJTddpI7aLWQP9FOeTdXMgDsCkvlJgjw+hQF9Y1OoX85NNZvx0aPtvg5sDZg5N88Sz6VH9S8mVyHVR8nE2ir/kEvgU9QXF90k64rI7WhJCwzUuW7wfaxDGPu6TDNlOYX1bWA8BQ7gwnOLKy134atDo7xJT8MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJj/TJVCjM+JgzlH0J+CkafwQhK1n8P8BTlWKgrS4uw=;
 b=AgKF6y68LYSarLMo7xCdUBB2xSJI6HVxN4t10Q5X0TvD3lgymHjLaoZy8lFhAn+2CVzza6hMdvgL89Xk0TbeiT8XaQJ/tD6cil8Dp75FwRCYpvJk6MPNk7ZsLBc0xOqZE5D5QTEt9qXWnh+aDgSB5adC9BkW1qGn3okDrBiF3wE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4073.namprd12.prod.outlook.com (2603:10b6:5:217::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 11:55:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9094.017; Mon, 8 Sep 2025
 11:54:59 +0000
Message-ID: <16cdcaf1-54ea-4e3b-a64c-474abaaf880b@amd.com>
Date: Mon, 8 Sep 2025 13:54:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix use-after-free in
 amdgpu_userq_fence_driver_process
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250905072041.3304368-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250905072041.3304368-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4073:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a80ed6-1066-4c5a-d3d7-08ddeece895e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTF4TGVic3hEdlM3ZGFlZGppdG1vWnAvQk5oWnIwb25odVYwMFoxZWtGWjVH?=
 =?utf-8?B?SjhnVS96TmlnT1pQNHJvdm93eHpoYWRoc0hMN3JpWDlOTC81ZlYyMUZGbzUw?=
 =?utf-8?B?Qnl3UzRocVBqbHYwQkF4NmhsZGVQcmF2akVNdFZ4ZUdJc2Z3Qk1rL3liMTMy?=
 =?utf-8?B?MTJZd2Juc1VBQ3VPdklVeVdlQ3licHBEbjJsUGVUdTFFLzc5YmZKVDJGQmtB?=
 =?utf-8?B?TjFNZFgvYWZHQUNMa2RzTjBveUhibTFaVWFJMlZqb2c4SjNGMTFFNE84RENj?=
 =?utf-8?B?YnBVMTFrcVR2M2RuTWJXdWhDNG9JN1V1TjEwTm9CaXNpaUloSUZhaHZVdU9x?=
 =?utf-8?B?clNtbXdjUDBscDgvRVU4cG45cm5ETmVYNUFQaC8zSEhISEFFN1F0QU55dFJo?=
 =?utf-8?B?T0pLb2VWRWVZb0JsbXh1MXJjdGxVcXNYY2tVbTZPd1JlNkhyK0xJbnpvUTVn?=
 =?utf-8?B?L0Izc0dEMWhqSXkxNUlrMzBncVdRM3ZEb1JUcTJhTGlrbnA0SlZaNW5XQXNT?=
 =?utf-8?B?NlFtQThnUEU4ZS9ETGFkdHZMU1B0MXJPVjdNcFFCRWltZXpNaU1QVU1FNEpk?=
 =?utf-8?B?WDJ0UmZiWktLam9WMzhTQWpWNm5lNk9WeHpaSFcrUmpWYkdMTndiTEtHYWhp?=
 =?utf-8?B?ZnJrK0k3dWRJVDZiMkN3QnJWbUU1N1Nwb3FYbzVFUEZQaU1PVEtlUXN0Q01D?=
 =?utf-8?B?Ry95TVBHS0tnWU5ZNjVVNmJnR2VZWi9IM2RFclhyVkZvZEJhNldIbFVodU9r?=
 =?utf-8?B?M25lcE5mYlREM2sxdUxzQk5ZUWo4NmNQWHlzclh6dkduTndSR3VUM25rY1RW?=
 =?utf-8?B?OXFtOSt1ZE00dGtnSkp1M2hYamVYS0IvSWczR3B3ZEl2bUQrS1o3bTNUbGVZ?=
 =?utf-8?B?OUJ6SkFyckFNd0RmNlJQa2dVNHdMM016WFF1UU9KY2pTM1htRGs3NmhYazZa?=
 =?utf-8?B?bGM5Y2wwTlEyaDFPVHQvRTJ4WTcvQzVjMnd2ZzZlNm5ONGMxVnNzYVcrQjFl?=
 =?utf-8?B?YldmZGREL2lrSHphQlNPcEhRU3poUVRoenV5VzNPQVA3Nkx4NndJNUZWSGo3?=
 =?utf-8?B?Q1JnNWMwRWVXRVp1MG5FRFkza1JiRm5EZnloWUFhSjhPUTNFdjU1VFRlL2NV?=
 =?utf-8?B?TGpDN092aE1XUG9iZDJKeVQ1SWxOSThXbDhqdkRJSEZjZmJCbDVPWnhMc1N1?=
 =?utf-8?B?N3p4MzF6MFBOOWk3UEFvdDZlZU5xRWlvM01kODVRcUhBUFZsWGlsQ3hXTjRB?=
 =?utf-8?B?bWVYc1I3eEJibExTbzF6OHJtM052aFpIdURxZ0VBemNjRDNmcHdwWE5VK0Zz?=
 =?utf-8?B?bHRwckl2WnlTYWtjRDFYdTlEczhvWUVTUHdEQUpoeXd4bndTSXoybXBpczZP?=
 =?utf-8?B?cWs0RktHNjBHSlNTNm04aUthdjlRajBWUVlSbEJvbUl3elBtUkEwUEk0ME5N?=
 =?utf-8?B?a3FFTy9mc3lRU21ieGx0ZkdKNnNselJsUnBsV2dWYzNVUkh3R1ltdGFpbjk2?=
 =?utf-8?B?VXhLa3UxakZCQzRvNUE2eFoxSFJ4clRqbUI3TlVTSXp3TFRCQ3dCV2ZOREUy?=
 =?utf-8?B?bTJSdTZXdVlLWmxWZktGeEJiR0dhbHhPN3VGeVBYQ2hhSThqbkxFOXhUN1RN?=
 =?utf-8?B?S2lCZVF4Y1dwUnNhMUtDL3hUMGhkMmhFNEJOKzhLbkVwaXRMSGJkREtYZHVL?=
 =?utf-8?B?MkE2bGhvdWdKVGVXQ0tPMTJGeFlqaHhLenZKb0lQejhmaWhEWS9JSWRZTDZt?=
 =?utf-8?B?bzBiK1FqL0lXTnd4SW1KM1dYQm1ISlk4YjZ2Ny9jdHdBYi96OGRiN09Kb0J2?=
 =?utf-8?B?V01lSm9zUG1aS1dKMVFYdnpZUGJVdkl4dXg2aXVlbzRiMTJYN1lmRmRjRHhQ?=
 =?utf-8?B?YTZZS3dVL2tJR0pja2hQQWUvSWNpYVBjaGJVT3JMbWNGRGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?di9NcklyejVXa3YvVzNVNktyb3BOSDJmZGErT3FvRW5RdUh6dnlaTW8zakdU?=
 =?utf-8?B?dWt3K3VoRWhlaVl5djhtNStvMlRqMFF4YzhKVDBnaVEzRGFnR2JWNjl6alMx?=
 =?utf-8?B?S2FNNkYxcWpzQ3JadlVUd2d2dHZyUUw3TWlvQVF2OE5PTUYwK29HbG9MQkVM?=
 =?utf-8?B?bUZTSFA1Z3lYUEpHemZ2TWlJQ213MDNjU1NVN1kxSlQ2MW82NEVjdWdEdkZT?=
 =?utf-8?B?OGpIQWZyNzNyT3JlWTZkem9KLzE2UG1UVDk5SUhSaVE3bkw2bmNuRXpwM3Yz?=
 =?utf-8?B?SWFGUjJ1eHcwUmxFNlpuL0p6Nit1OHd1ZTR1bFpHejJFQ2pZZXNYeStsVUk5?=
 =?utf-8?B?SUY0bXVIQXdNZSt3SUJCUWZYU0hSUFRjSUJPdEx6ak5SSk9aK3lOS2lTUktI?=
 =?utf-8?B?T3M4YVBPRE5GVmNwOFpOd3hOMTdTZDBTZmhDdU1BcHVDR01EMkRQcVU2by9u?=
 =?utf-8?B?MTNIRVNPV1l1MWZWUFdpTUloTFdCaTVUOFRMbjJZdUpVNjJaWXAvV3g1a01R?=
 =?utf-8?B?bGJDWWFHc0p4ekVIdkI0MnU3R0RiR29SNzkxMnBRdFdRS0I0R0J2TnFZa0tu?=
 =?utf-8?B?R0JPdVdMRmdoZHMyM0s1dHI2dHhQb3cxNmR3RGpuZlRvRWpSOU9xT0ppeEIw?=
 =?utf-8?B?RUE4YnQ2UXF4dlZFMGwrb1pGNWZtc2NzQlFkUFJBcVBxcGF6cGtwU0YwU01E?=
 =?utf-8?B?YnBKU3RjakEzc1QwWUROTVorVHovMG56RElXR0NIK21EMDcrODZ4SURwb3Ju?=
 =?utf-8?B?K05JL3VxaWdpbGRETW50NUtvK1RibjUvc3UwV1hncitsQW9jeUxjR0RQMkVB?=
 =?utf-8?B?cll0VWU3V0UvZVFOQ1dXSjI5MWp2RlBtUlhzUzBwL3hwcjYvRUc2YmYxMTBp?=
 =?utf-8?B?QzF2Zms2N2ZDeVptcE13VlpnWVp6QzUvcVE5V2lUNEFuZHRqUU12OENGcGIw?=
 =?utf-8?B?QjVxaHJySUdHN3hpOUl2dlRoYlB1RTlGZnpIdDI0MFhnL2huUi90bGE5U2lE?=
 =?utf-8?B?YWFOWS9MV1lJSm13S2laYTFoWjRsVVhqdEd6c3pJU3p2dkd4em9XRmRnS1BB?=
 =?utf-8?B?WEgyWnBITFd3T2RiR3NDOVNzeHIydm4wZm1IWjhockxVc1VtLzNpeWNlaURZ?=
 =?utf-8?B?ZGlFbUplUllKSjdmeklMdUlZbnpESllmL1hIUVdiOGh6OGxGaDQyMWRjWGJM?=
 =?utf-8?B?akFSR080YnFGQ1plVTNjblVPaXJMcE1uTHFvbm1XcWtHNVVKb3RtMkZxNkhU?=
 =?utf-8?B?SktrL2NpN3BEaTUvZmRzMmdxTWdETFhDZDIwaGsrdklwQTEydDFyaXNUNUMv?=
 =?utf-8?B?K1BLdlNaV1BkUldYUWRhSzFXOVJrb056NE11QjVmdmR4amNra3VuVnN0eVV2?=
 =?utf-8?B?SHhlODNOa0VkQ1VxZFlUZHNXTHFRVVQ2QmlPV0ljdkJQNzduZXZSamdOM2tG?=
 =?utf-8?B?L0I0ZE9MWXNiU0NwaFc5dmdJV2tNMmd1dHJ1ZkJmUVBZZ2gwdmdPMFVTMXFG?=
 =?utf-8?B?cnRwOWRTOTBUNmZGNiswUG95eWhXN0ZYeU8rN1hqUEFYaEJNQURNZGlPdWlu?=
 =?utf-8?B?L3EzRkpmMWNKSmVLTmszM2h5RGZYN29DWTFsNVBiY2I3UC80K0NPQ1BGU1U4?=
 =?utf-8?B?VWhBcUtra3FTVEZkTDdKYWxDNGNWWTZUSEkyVmNGM2FoamxudEtxNEhKa3VB?=
 =?utf-8?B?am15ODAxMllJOXRMMkw5Rm56Yk9QbVBma2x6d0UrMGhEZjhUTStCMTdMT1kz?=
 =?utf-8?B?NC8rSTVkdTZnNXQrQUliWURWRmkrYit3cFVjUXZOVXZ4bEpUUi9EVmN5VmJN?=
 =?utf-8?B?d1pQZy9IR1VrNW9USUhSRnUzTUs1RmM3UXdRQkpuMjBIQW9Bd2tTU3dlK0Fp?=
 =?utf-8?B?eUlpdzA5L1Zia3dSRXFUbUtFdkFSazlTdWQ2SzRWclpmUk1pakVKL2RTWTA1?=
 =?utf-8?B?L3REc0Z1L2VFWitIYzQwWU1laHkxc2NtN2ViZ0pRR0IzUVJMWEJIM3dsQ3dl?=
 =?utf-8?B?TlR6S0IrM0g5Z0h2K00zc2NMSFdqaWljemREQ2wySlR2akZUejJnZ0k0MGEy?=
 =?utf-8?B?a245Q1dNY21nMy83QmFnODdLbXk1a2dHV1dvSG8wL0NsdCtrNGUrVy9PZStZ?=
 =?utf-8?Q?2kbfGaDhDTgZnjN7OwMjPys5R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a80ed6-1066-4c5a-d3d7-08ddeece895e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:54:59.5477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hp6Anv0xK6/5owTXt8/fIh8h6obWu3o3NF3StFKCWBpFnh7LqMtt00FK+RKOoebb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4073
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

Well good catch, but clear NAK to this workaround.

On 05.09.25 09:19, Jesse.Zhang wrote:
> A general protection fault occurs when signaling DMA fences from
> the user queue fence driver due to an invalid callback function
> pointer. This indicates a use-after-free
> where fence objects are accessed after being freed.
> 
> The issue occurs because:
> 1. Fences may be signaled multiple times if they remain in the
>    fence list after signaling

That's the problem. Why in the world would a fence stay on the list after signaling?

> 2. Fence objects may be freed while still referenced in the list

That's a complete no-go.

> 3. The fence list isn't properly validated before processing
> 
> Add necessary safeguards:
> - Check if fence is already signaled before attempting to signal
> - Validate fence ops structure before accessing callback pointers

Stuff like that is a whale big NO-GO.

Regards,
Christian.


> - Use list_for_each_entry_safe with proper reference counting



> - Add WARN_ON for debugging corrupted fence states
> 
> This prevents the GPF by ensuring we only process valid, unsignaled
> fences and properly handle already-signaled or corrupted entries.
> 
> 0xdeadbeafdeadbeaf: 0000 [#1] SMP NOPTI
> [  353.889511] CPU: 22 UID: 0 PID: 0 Comm: swapper/22 Tainted: G            E       6.16.0+ #15 PREEMPT(voluntary)
> [  353.889531] Tainted: [E]=UNSIGNED_MODULE
> [  353.889539] Hardware name: AMD Splinter/Splinter-GNR, BIOS WS54117N_140 01/16/2024
> [  353.889552] RIP: 0010:dma_fence_signal_timestamp_locked+0x7c/0x110
> [  353.889570] Code: 10 f0 80 4f 30 04 66 90 48 8b 75 d0 48 8b 1e 48 89 f0 4c 39 ee 75 05 eb 24 48 89 d3 48 89 06 4c 89 e7 48 89 46 08 48 8b 46 10 <ff> d0 0f 1f 00 48 8b 13 48 89 d8 48 89 de 4c 39 eb 75 dc 31 c0 48
> [  353.889593] RSP: 0018:ffffc0840078cd30 EFLAGS: 00010087
> [  353.889606] RAX: deadbeafdeadbeaf RBX: ffffc0840078cd30 RCX: 0000000000000018
> [  353.889617] RDX: 00000000000216c8 RSI: ffff9ed014558160 RDI: ffff9ed00bab3680
> [  353.889628] RBP: ffffc0840078cd60 R08: 0000000000000000 R09: 0000000000000000
> [  353.889639] R10: 0000000000001808 R11: 0000000000000001 R12: ffff9ed00bab3680
> [  353.889650] R13: ffffc0840078cd30 R14: ffff9ed00bab3680 R15: 0000000000000014
> [  353.889661] FS:  0000000000000000(0000) GS:ffff9ed198865000(0000) knlGS:0000000000000000
> [  353.889674] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  353.889684] CR2: 00007f44ebebf000 CR3: 0000000108240000 CR4: 0000000000750ef0
> [  353.889696] PKRU: 55555554
> [  353.889703] Call Trace:
> [  353.889711]  <IRQ>
> [  353.889722]  dma_fence_signal+0x35/0x70
> [  353.889738]  amdgpu_userq_fence_driver_process.part.0+0x67/0x150 [amdgpu]
> [  353.889995]  amdgpu_userq_fence_driver_process+0x17/0x30 [amdgpu]
> [  353.890204]  gfx_v11_0_eop_irq+0x137/0x180 [amdgpu]
> [  353.890345]  amdgpu_irq_dispatch+0x1b2/0x2f0 [amdgpu]
> [  353.890452]  ? sched_clock+0x14/0x30
> [  353.890462]  amdgpu_ih_process+0x8d/0x1f0 [amdgpu]
> [  353.890566]  amdgpu_irq_handler+0x28/0x60 [amdgpu]
> [  353.890667]  __handle_irq_event_percpu+0x50/0x1b0
> [  353.890677]  handle_irq_event_percpu+0x19/0x60
> [  353.890683]  handle_irq_event+0x3d/0x60
> [  353.890689]  handle_edge_irq+0xa0/0x180
> [  353.890696]  __common_interrupt+0x52/0x100
> [  353.890703]  common_interrupt+0x9b/0xc0
> [  353.890711]  </IRQ>
> [  353.890714]  <TASK>
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 28 ++++++++++++++-----
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 95e91d1dc58a..e18656d0bee3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -163,16 +163,30 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
>  	list_for_each_entry_safe(userq_fence, tmp, &fence_drv->fences, link) {
>  		fence = &userq_fence->base;
>  
> -		if (rptr < fence->seqno)
> -			break;
> +		/* Add sanity check - ensure fence is still valid */
> +		if (!dma_fence_is_signaled(fence)) {
> +			if (rptr < fence->seqno)
> +				break;
> +
> +			/* Verify the callback function pointer looks reasonable */
> +			if (WARN_ON(!fence->ops || !fence->ops->signaled)) {
> +				/* Remove corrupted fence from list */
> +				list_del(&userq_fence->link);
> +				continue;
> +			}
>  
> -		dma_fence_signal(fence);
> +			dma_fence_signal(fence);
>  
> -		for (i = 0; i < userq_fence->fence_drv_array_count; i++)
> -			amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
> +			for (i = 0; i < userq_fence->fence_drv_array_count; i++)
> +				amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
>  
> -		list_del(&userq_fence->link);
> -		dma_fence_put(fence);
> +			list_del(&userq_fence->link);
> +			dma_fence_put(fence);
> +		} else {
> +			/* Fence was already signaled, remove from list */
> +			list_del(&userq_fence->link);
> +			dma_fence_put(fence);
> +		}
>  	}
>  	spin_unlock(&fence_drv->fence_list_lock);
>  }

