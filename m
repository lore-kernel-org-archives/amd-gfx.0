Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13659C83F1B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jul 2025 14:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9396810E4A1;
	Mon, 14 Jul 2025 14:00:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IzGLoflm";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E040110E4A1
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jul 2025 14:00:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgD8Z6cSCE+qf0Uap46bCGwxz+X79IDTqnEai818WZ5B25Wwmjd0J5OI+WsL97LCoyIhTFaRr0spWFcqNenUdwF4dR65yy16miAJa12MYOuNbIQ7zf1DT4zH+wcDNvxQ7AoFBPQ1MQgjzkbTalBVXn5a9uqYXaQjvS8rDdNEU9d7LuhaAnvm55nBdKlxOjpF5zLVpJN2arQOFkTBFdejc+r1CQowHyCU0o8CE1CS/cCKui4r0Wjsc4s1xxoSp20gbS4qtqTzH7tDmXzztQZeKx3xFA4HGteUIsJbVC4sZ9d3ISa9VDH2RmGs0gvO1RxKOrFL+3+5n84XLkRBW5ScNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxH7zlabNIx3xxVj7pvyWm252j5lQ53lNcLotKhu47A=;
 b=w3kcFsn7XmpbdpRVgjaU5vN/TcR2HCiKAp6P1wc3sRCXJsHnzuS+vCI4qLoWjjyrfcUu0M5UuaBkCkyMnB7cojD2U4Tae8A/poRHvhzqlC3kyBRtSWHaa/F7M0j6xwoGJ79esnHjtZytX6FsaEiOVWpXIkJ7j3s0gmUu051jNM/vj39UJ+VTNSBH5w25kr9n0/ajS/4MFlYhW1ZFY2eud5c3ll69O9yEK4A7XcuhYNQsNiomhuMmMnOawhTF04ClOyZDvlLGNHPps4a+7yDBbAm/EYikggvGJlzweqymgUb8NTCay6yBZJFUeOvoq8wMxjY/p4xqXHbSiS41gr1OgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxH7zlabNIx3xxVj7pvyWm252j5lQ53lNcLotKhu47A=;
 b=IzGLoflmEyEVq/lNXLu7H9LoudijZmR4Qz36aUII2lycTgAJNb1YSRKKq3veR6rCRi+M2HBQc4SWMsCcdnQaAQq99nkOmwYSn5ir/1LCdLwsl8enYviFSPeTdOjTJGU8AQ11C6M2f8TxHrgX1DyZg1Mk00nd6v45ER7uLbxC7XU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 LV8PR12MB9405.namprd12.prod.outlook.com (2603:10b6:408:1fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Mon, 14 Jul
 2025 14:00:38 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8880.023; Mon, 14 Jul 2025
 14:00:37 +0000
Message-ID: <1af4e26d-d25d-439a-a9c4-abbad9ea3d50@amd.com>
Date: Mon, 14 Jul 2025 19:30:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/33] drm/amdgpu: clean up sdma reset functions
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, sasundar@amd.com
References: <20250711224024.410506-1-alexander.deucher@amd.com>
 <20250711224024.410506-2-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250711224024.410506-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0126.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|LV8PR12MB9405:EE_
X-MS-Office365-Filtering-Correlation-Id: 16f62543-d963-46e7-212d-08ddc2decf64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REV5WWRNd28yYmVOaWFpUk1hMDR5bDhrcEpwQXZPcndrSGE0NXEzblNjbytt?=
 =?utf-8?B?azNjZWV1cGJ6cnh4YmUwemxXWjF5VHJIalRSYlFyLzZxNENrc1FBMjROMmNX?=
 =?utf-8?B?UTVZQTVPTTFkbHk4Y0cyR0NmcStRTXM4d21ub2dlOUpOUmVabDdkaXdyZjM5?=
 =?utf-8?B?YnVyR2U0VktLMWI3Y2JkR3E3WG9CekhSTjBlR0ltbmJaT1VQMCtRTElzcXVQ?=
 =?utf-8?B?WkZUQlFXd0ZpOHdjWE4zMHloK1RlUWloSmw0c1FnQzR0V3ZuOTYzeTJrYmhh?=
 =?utf-8?B?eXhQT1dpN25qOFp0LzN6UEQzUVdwSTNBODM4VVByeXZ2b2tPUVY3ckdCZWUz?=
 =?utf-8?B?R01sYkwxWldtdllzVWlrSVdpaFFsWkRSVi9Gd2RnUkh1TVM0bi9DVG1ZRFJ6?=
 =?utf-8?B?dnMwOVEya0RXRmJjUVJ0UGVEVFAwODJFUldVaTcyck45STJYNi9uWm1iVnp1?=
 =?utf-8?B?TFJPRGFVcHNUYjREd2l6YnBLVU53aG9sM2xUVnA0U3llbEtWaUh1aDhSTEJB?=
 =?utf-8?B?T3BYZnplY1ovTHVHNHRQT205ZzBYYTZPc052WDFURXRiZmdHaFhrbmJscU5O?=
 =?utf-8?B?RmdkaWFLd2JYSWxTcFI4VitGWTlldWM1KzlJbjFndm5zZ2J4aGhuOTQ3Zmo2?=
 =?utf-8?B?RUJDVU0zakRJWHVUZU95Z0w2Q25IR244OE5UNmdSeForNVdwd3dyTUtvRE5P?=
 =?utf-8?B?b3R6QXUxS1k5aXRycHVPeHpBR3gvaUp6SEorR3FvclZmbjNZVFkrSHQwVGky?=
 =?utf-8?B?MWYyLzJaUGNqWkpkWSt5TnF1N1hERldhejN6MnlNbVY1K010Q3ZCSWVGUFp1?=
 =?utf-8?B?dzRXbjFrcGpJSUthWXJwZ3NCQmtKQVUzcFhOQ01xbHRwemVzL0dIUXZibzAy?=
 =?utf-8?B?UjhUWC9MV1B4d05PeGJGMHBmbXF1UXF4d01KUzNuekJjZ1pZWGNLZis2eUhJ?=
 =?utf-8?B?eklQMlFOREZsUUFZOTl1MEs2b05ycTNGVmxqTVVaeEs1cGtQMExuNE5Gdzgz?=
 =?utf-8?B?NFZ5QnVidU5kK1lQZ0tQUzdhdmtwTllmRlJKaUk5aWVpRHpWSDZzSk92NURl?=
 =?utf-8?B?ek92bWZDSWVNLzVrNGxxMnhoUUhoc1BEZHVMNG02K1VmaUYzWjFhTUlUaURh?=
 =?utf-8?B?R2s5L2pkK1I3ck04THV2bUNjMTFMRHNWcklQcDlhbFN3bnpuOXFVMDV5NXJ6?=
 =?utf-8?B?cktUZkM1Mnp4MTY2aDlYV1ZSRXBveFJrYUpIazZRRG51cUpBb3JQc0tuaUdm?=
 =?utf-8?B?aUFPZEU2bllDNW1qTmlxMm9ZVk5ld243SG5RZ1BqYnFyY2RQbUtqdVVhSDVP?=
 =?utf-8?B?cEV4bW1McXpISHZnaC9KTWw5Vkp4NDhkZWFHV3FBSWZmVG5aY1p0aXU0RWF5?=
 =?utf-8?B?TFl6Y2lBdllLNG9lcFlDV1BvaGZrUjB2aFg1L0VYRTFVM0FiMkVMMXU4bWt1?=
 =?utf-8?B?ZEx3UnlvSnJKbC8yeDY4RUJuTzlFakRzVE1WL2JiR29EamNrNjBwUWJSOWFh?=
 =?utf-8?B?WVR4MkpQU2xwSVp5THkzSzdTZzZKbkhuTUozTnJPL1dkYkpFNFI1Sk9IVHN2?=
 =?utf-8?B?Tm55VVhpR1I3SzlBODdKakJJVUduUVRrVjh2RUtzQlJCSVp4UDhXcmFhT2NC?=
 =?utf-8?B?eVJ5WGF2eUpEdFNWSDRKOGtsUTJDTlM3TU5xQUdPb3YzSFBrQUNYSzBxYkRE?=
 =?utf-8?B?MmVPSVo1dWlTcmhJSWJVUlVraXJDKzdrcVlPWFRWNjBtWXhIdUUwTVJYVTRV?=
 =?utf-8?B?ZXFjK3d4MlFweWNaZ2tWTEhUaVpTSGlqSHl1c3ovYWdoMDRsQ1FuQVdqeHhV?=
 =?utf-8?B?MktZVTZYZmI1TW5wcFc2VjNuWUVGREY3R3VLSlJXV1c2Q1U1elVvRUlvVk1S?=
 =?utf-8?B?NGd4L0g0eGd0amtTakFZVHVqY2JKb3g1djltdVJIRGVOM0MwRzZnNkppK2RX?=
 =?utf-8?Q?4A85uuGQ4zs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjRCWm1EQ2M0N2xQd00xUzU5dW5LdHM4ZjJKRlVRVFFDNWhQOEFaTzNmMDRU?=
 =?utf-8?B?OFZ5akQyTkxDSnJZemZWYitqczVRVHpHNDY3NUswejJYMGxXSkFXWm1PNFYy?=
 =?utf-8?B?WG1GRmdlLzlLYm1PbG5NdHZGSFZPN0k2Q25yeHZwLzdIT0QvVml4UGZ4TS9V?=
 =?utf-8?B?cjFyQUVmNXpoWXVxRThMTzRZdEtPZDB1Smd2WEtGbkJXS1JnRHZURWxmMGRM?=
 =?utf-8?B?aWRNclJaTElsRVRtVTRSSTR4bHpaRGZEOHhaNjZsOXVZa1BPTnhkNGRoT0wv?=
 =?utf-8?B?UCtsMDN0aXVsWkI3VG5hOXZqQXRUWW94UFcxWHBhTElEQ3JGUUxUdlAzWld4?=
 =?utf-8?B?MVBZRnlHK1J0OFVGVG8wMHVzUDlvckU5KzF6UVJDckdZVmt1d3lSU2QwVUpE?=
 =?utf-8?B?aktjMkhzRE56cFlvZHZwS1VnanZRbUl4Y2R0RmczbUtGR0ZXUUtPZ044QTBh?=
 =?utf-8?B?UkFaeVRWNUo1cUdhajZ1VkdxVVFDMDU2N2tFb1cyanZmdEswbHBwb3g1cGsw?=
 =?utf-8?B?T3hTcHQzaXVyVFhoazJZNjFPZ09TMzh3elhkS2RERlovNENVZjlDUHUvSTdF?=
 =?utf-8?B?N1V5UERLb3I2a0pDRXlOcVBwR2dzU2pWVzhWTWZHMnNQV01PWmxIN2hmTlFt?=
 =?utf-8?B?VHRyclV1MTB6WkFoT0RXUUswVFV6dkozSjFMTGh4YnI0dFpGeElOOUlkb3Zw?=
 =?utf-8?B?bEtkRHhESElhVEVub0lJNzNJN2s1eGxkOFNsTHRuL0JyN1ZYQXFtNFQ3RjRG?=
 =?utf-8?B?aWpycFhhcFRScVZLNVpzNkxCc1NoQ29uYXlvRzFvZTdDM3lTNmJqK3A3SHpP?=
 =?utf-8?B?ZmxjMUpVUURhc3g2VFlZOUc0bmY2TjJoSnUyWE9pMmNCeWVzazBvYkZ5MWo3?=
 =?utf-8?B?cG9PMjRyeUZZRUJwUmIyZDJSWTFDT1BERTR0THNNZ1pRdzhEQUE2QWkrWWVU?=
 =?utf-8?B?amw5anRDbVpNWTg3Szc3Qk5BZjh4N0NhaWlFZXMxaXNEVVlLU0RMWURxa0xj?=
 =?utf-8?B?a0IrWEM3K2ZTLzJQMHlCc3pDcWJWV0YrUHpHTUg4MTdJS0oxaTJEN3lVMnRn?=
 =?utf-8?B?VUJvR25BYUlUYW9jT3IvSkdtQjFJUU82Rm9COVpTQldJVldDbWE5OTY1R3B0?=
 =?utf-8?B?Y2F1VVNRN2hYZ1RYbjZ0WXova3lZVzNqRyszdzlvNjRnMVRjWXY0VFRlcWYy?=
 =?utf-8?B?QnlUdk1EZWRGZ1FVMndhSTIvWGxEYU9mTEtlbXFwOVVVTkppNWxYUDlYS1VS?=
 =?utf-8?B?Rmp0ekpkbUlrSDdUMk5TaGtSK2k3bTBrek5CSW15NW1MY1ZYYXhwVlg5ZUpw?=
 =?utf-8?B?N2JuR0R4Zkd0c1lOQk5uV2dQTUR4TXNjU1BkU0pLL1RSdEh4amUxQXc4QklT?=
 =?utf-8?B?Njh2QWtwUjJNMlJURHN4SklGUHlrM1AvQWd3RENzZEoyMVphaXB5bllaUGU2?=
 =?utf-8?B?Vlh2aHNNRzc4K0NyNk13c3YydnFhT3NyZ2hUZmlzTE0yNEhOZk9aVFNaZ1lZ?=
 =?utf-8?B?UU9oSmpZZkJPTFlxeCtoQkVGL3JRei9YdWlrV1BoR1pMb1lYRGsxenV1ckJH?=
 =?utf-8?B?VG9MRjdhNVRKaDNKR01BeitBODlhLzh2OFVSWnBMaG9mMEdZUEFrdUJORkZE?=
 =?utf-8?B?cUJSM3dGcGlrZ0JpMXdXM09CZDk5TlRIUFFqc0JFVXFiRmZScEJJdm1rYldr?=
 =?utf-8?B?Z0tJcW55a3JDRkpDWXVqZm5vaU1hQkdRejlTMnF0OXlkcHFQMFpUbmhTbHhT?=
 =?utf-8?B?UTBjTU9ETkFYVThaY2FYZkpTOFJmOVFnbnFwRjVQOGJIQytRQk1Nc2k3aXB0?=
 =?utf-8?B?bXJldEpCUi9rekptdWNZczZMM1I3VW9uYWxUNGg0VzdiamI1OHFaRXJtMWoz?=
 =?utf-8?B?ejczWk5tN3QrZVQ4QytpdmFEcDM4YzZhb1JGdHVhK3lhZFZKOW42MVRHNVNM?=
 =?utf-8?B?engwRUpQemwzR25uc1M0aGh4ZXg1SzNjK0lITkd0RGd6b1A0TnFHVE9RdFJV?=
 =?utf-8?B?K2JPZlJ5U21KQVhPVFJBQmdLTE1sT0xLbEF5eEJvUUw3ZTRhTzIrelJ3dThL?=
 =?utf-8?B?bDZRRnBFNlZwZXdXWS96d1BWa3VGZmdVeFFpZURGUXdoTjRqblQ5bXdDKzRu?=
 =?utf-8?Q?/WtJQLs2zHpCWefS9mmFS4miY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f62543-d963-46e7-212d-08ddc2decf64
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 14:00:37.8110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c8bW2nsG5lkh4IAbSYi08e2ImJaE344+TW4RTNc/YSXOR43y3hcQTlLjGgOq5ixf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9405
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

Since the series has supported_reset across different ip blocks, isn't
it better to move this to amdgpu_ip_block? Or, if this needs to be
specific to be different type of rings within an IP block, keep a
supported_reset flag per ring to do something like -

amdgpu_ring_is_reset_supported(ring, reset_type) and call
amdgpu_ring_reset()?

Thanks,
Lijo


On 7/12/2025 4:09 AM, Alex Deucher wrote:
> Make them consistent and drop unneeded extra variables.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 14 +++++++++++---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 17 +++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 20 ++++++++------------
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 20 ++++++++------------
>  4 files changed, 40 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 5a1098bdd8256..999705e7b2641 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1428,7 +1428,8 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	case IP_VERSION(5, 0, 0):
>  	case IP_VERSION(5, 0, 2):
>  	case IP_VERSION(5, 0, 5):
> -		if (adev->sdma.instance[0].fw_version >= 35)
> +		if ((adev->sdma.instance[0].fw_version >= 35) &&
> +		    !amdgpu_sriov_vf(adev))
>  			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>  		break;
>  	default:
> @@ -1544,11 +1545,18 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
>  				 struct amdgpu_fence *timedout_fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	u32 inst_id = ring->me;
>  	int r;
>  
> +	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> +		return -EOPNOTSUPP;
> +
> +	if (ring->me >= adev->sdma.num_instances) {
> +		dev_err(adev->dev, "sdma instance not found\n");
> +		return -EINVAL;
> +	}
> +
>  	amdgpu_amdkfd_suspend(adev, true);
> -	r = amdgpu_sdma_reset_engine(adev, inst_id, false);
> +	r = amdgpu_sdma_reset_engine(adev, ring->me, false);
>  	amdgpu_amdkfd_resume(adev, true);
>  
>  	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 6843c2c3d71f5..e542195972dd4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1347,11 +1347,13 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
>  	case IP_VERSION(5, 2, 2):
>  	case IP_VERSION(5, 2, 3):
>  	case IP_VERSION(5, 2, 4):
> -		if (adev->sdma.instance[0].fw_version >= 76)
> +		if ((adev->sdma.instance[0].fw_version >= 76) &&
> +		    !amdgpu_sriov_vf(adev))
>  			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>  		break;
>  	case IP_VERSION(5, 2, 5):
> -		if (adev->sdma.instance[0].fw_version >= 34)
> +		if ((adev->sdma.instance[0].fw_version >= 34) &&
> +		    !amdgpu_sriov_vf(adev))
>  			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>  		break;
>  	default:
> @@ -1457,11 +1459,18 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
>  				 struct amdgpu_fence *timedout_fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	u32 inst_id = ring->me;
>  	int r;
>  
> +	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> +		return -EOPNOTSUPP;
> +
> +	if (ring->me >= adev->sdma.num_instances) {
> +		dev_err(adev->dev, "sdma instance not found\n");
> +		return -EINVAL;
> +	}
> +
>  	amdgpu_amdkfd_suspend(adev, true);
> -	r = amdgpu_sdma_reset_engine(adev, inst_id, false);
> +	r = amdgpu_sdma_reset_engine(adev, ring->me, false);
>  	amdgpu_amdkfd_resume(adev, true);
>  
>  	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index d2effa5318176..c08e9a6cf6827 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1355,7 +1355,8 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	case IP_VERSION(6, 0, 0):
>  	case IP_VERSION(6, 0, 2):
>  	case IP_VERSION(6, 0, 3):
> -		if (adev->sdma.instance[0].fw_version >= 21)
> +		if ((adev->sdma.instance[0].fw_version >= 21) &&
> +		    !amdgpu_sriov_vf(adev))
>  			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>  		break;
>  	default:
> @@ -1575,18 +1576,13 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
>  				 struct amdgpu_fence *timedout_fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	int i, r;
> -
> -	if (amdgpu_sriov_vf(adev))
> -		return -EINVAL;
> +	int r;
>  
> -	for (i = 0; i < adev->sdma.num_instances; i++) {
> -		if (ring == &adev->sdma.instance[i].ring)
> -			break;
> -	}
> +	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> +		return -EOPNOTSUPP;
>  
> -	if (i == adev->sdma.num_instances) {
> -		DRM_ERROR("sdma instance not found\n");
> +	if (ring->me >= adev->sdma.num_instances) {
> +		dev_err(adev->dev, "sdma instance not found\n");
>  		return -EINVAL;
>  	}
>  
> @@ -1596,7 +1592,7 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  
> -	r = sdma_v6_0_gfx_resume_instance(adev, i, true);
> +	r = sdma_v6_0_gfx_resume_instance(adev, ring->me, true);
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index 99a080bad2a3d..ba1f3e3b6eb61 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -807,18 +807,13 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
>  				 struct amdgpu_fence *timedout_fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	int i, r;
> -
> -	if (amdgpu_sriov_vf(adev))
> -		return -EINVAL;
> +	int r;
>  
> -	for (i = 0; i < adev->sdma.num_instances; i++) {
> -		if (ring == &adev->sdma.instance[i].ring)
> -			break;
> -	}
> +	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> +		return -EOPNOTSUPP;
>  
> -	if (i == adev->sdma.num_instances) {
> -		DRM_ERROR("sdma instance not found\n");
> +	if (ring->me >= adev->sdma.num_instances) {
> +		dev_err(adev->dev, "sdma instance not found\n");
>  		return -EINVAL;
>  	}
>  
> @@ -828,7 +823,7 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
>  	if (r)
>  		return r;
>  
> -	r = sdma_v7_0_gfx_resume_instance(adev, i, true);
> +	r = sdma_v7_0_gfx_resume_instance(adev, ring->me, true);
>  	if (r)
>  		return r;
>  	amdgpu_fence_driver_force_completion(ring);
> @@ -1346,7 +1341,8 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
>  
>  	adev->sdma.supported_reset =
>  		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
> -	adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
> +	if (!amdgpu_sriov_vf(adev))
> +		adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>  
>  	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
>  	if (r)

