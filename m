Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26503C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 07:38:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B17610EE9A;
	Fri, 26 Apr 2024 07:38:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ByPgCg8X";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 746A9112C1E
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 07:38:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQM5ddCh2uLPBBT0M3kkoBERfKawryHIN1dR19//P0vPaO5b5QP+ZFdAl7swBf6CRw4jWF+9FZ85ywK2uAL8lEsvtd038YYJ7waIY8EtUe+zeUpgVZRisDLrNS2627jbEAKy7xUPpEsGJJoLWwCbcwStihUD45l9SMxRJLDBFcXBCBIxBO9pZkPxE6zzSpsjSBAQUEIlv3rGrx6RBke1BPEAu8cbuZwvWHqO7loXsrKKk7OvUqZCawJ2modXJVOhrmy64kCiTw1voIqZVJ2b8QjarEiJf1eF4BmfWEh/DvgP6hZX51n8Q9zhw7fWur2yYqpYreONZQyItYzsB0bjLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKTIQN4UPb6TyYLLrHtk6aL+yZpbfmU+eZNLy0b46Zg=;
 b=LEKZqoiLl4SiWze5dlUzvBMsw2kPe9cOvG0GUz54EKavoU4/K3ydP/I1m21yXy8MzN4C2zPahooOPVTZfU93Iz1UFHHF2nZ5w8RYMkCFLqfdIvNmQmILN6ow+uJiLKGE6azjffDf4wTxkgWJGGaQ8nG60GFjFdV5FLLsmIIeAVZUO61B0y6WmEq7b97XO5iULE91rUbpmU09R8t5pMNyRRoWfMXXaS4a+n9FSHPyOB+hv0B/fBjHgZGQsDugz8QCtutRS32oj0G7Vd7eNmiQ4ejLU0rZe/WrBnBI5d5vLXNwguponoTolzxzJXzYKW7gYFvA+4wWvJsUH6EPk2MfmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKTIQN4UPb6TyYLLrHtk6aL+yZpbfmU+eZNLy0b46Zg=;
 b=ByPgCg8XknkYKbaeJQwqt2lcq7n+HkkNI3Y9wm44/sParhInEw/XNilS7MsdXuFd3z7Zc5r2Qy4mw1vTOHMQs6TFxkgO6TCtm+gmAbIsSaFRgq6irbm/TdasWOiNkTES6pfphU4fIMlOn1kvnt6UyTf5hPnTFYLDxUfKyBeMR74=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6832.namprd12.prod.outlook.com (2603:10b6:a03:47e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.46; Fri, 26 Apr
 2024 07:38:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 07:38:39 +0000
Message-ID: <2b0b8031-7a01-45ab-8f1c-1e528618975c@amd.com>
Date: Fri, 26 Apr 2024 09:38:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix out-of-bounds write warning
To: "Ma, Jun" <majun@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com
References: <20240425100027.637016-1-Jun.Ma2@amd.com>
 <c2327261-e425-493f-bdc8-d3b57819834c@amd.com>
 <95431aa1-1567-42d1-8e18-df7406cf4b45@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <95431aa1-1567-42d1-8e18-df7406cf4b45@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR10CA0096.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::25) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b32d104-2315-432e-034b-08dc65c3e3ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWdiY1NtanMrbmRPRXZQZjdWMnI1aWdXSUNBV29TWnYzWmRHZjdNa0tHd25u?=
 =?utf-8?B?UnI2WEhPeGtPZVNIZFg5TmNqMG95SytOQUpkMHpjNGZnQzBNcWhWR0RqVHk3?=
 =?utf-8?B?WURjUllLdkVETEI3eEdJVU1UNUY1b1U0eXRsb0ZJZkV1L01Ia0kydlBZQllU?=
 =?utf-8?B?QW1lVjlmWXNMZ1JtSktCOVBNbHdkaTEwQzY1ZDZqYlJhQXFiWDRBYm9BVTVB?=
 =?utf-8?B?RGExYW9pVlBXbDZ2QmhEdE1NR1VWazFSZ2NyN05XcXdMRUt4ZWt4dG5MaHlS?=
 =?utf-8?B?cUlSYXpJUGVMc0RVbGJkTDdOUTg3Y3E4RGZlUExLVWNaK2c0aXEzajM2Q0hM?=
 =?utf-8?B?OUtrK2owMlJGbVpKZmlTZnFDOW9BVE9WTHFWY1ZPS0lNclVaRFQxZWdXQVUy?=
 =?utf-8?B?N25EdDdPTEdacUp4a2tVU1JiSkNMOWZraC8yRVNrWFFzTExFQk5EdUl3Y2s0?=
 =?utf-8?B?U1pPNlNmZmc4Tkp0bHdnUUdyQUtRcFpremRodm53aFUwSy9nUUs3aVY4U05I?=
 =?utf-8?B?d25nakx0OHpiYmd4bG5nbkdhaHkyWWRQMk80bnpvUnAyV3BQYXFUYzR3V3Bm?=
 =?utf-8?B?K3RqL0dPeVpSMHhQT0FKQmc3TzdnNStlRjF6b0hyNEQ0RUhLeVdNYUt0QTF6?=
 =?utf-8?B?VXdWeThsZkg0cVVCSnRVUUxQVDI5aUUydko1VjZhcm04akthMVBHQ0RqZjRV?=
 =?utf-8?B?UmhEckxzQTZxQVdOUmJHMGl1bmd6SXI3eVRyaThia0FxMGxCR0h4aG9Mb1BT?=
 =?utf-8?B?S2JuNWlSc2REUTJYN3JIcW1ZdU1ORCt1TEZkcktVUW9oeHg1S3cwcmJIOGtB?=
 =?utf-8?B?RWd0UTEyNFgxV0srbER1Q25WRlg0QWc5ekh2NDBDQ2FmTStGUlJqb3dMU3Ra?=
 =?utf-8?B?UjY5S3ltOGxXbzNVaytwR0UwM3RUYlVJZnFCTzU5aFFzbjI1SEF5Qjk5OG96?=
 =?utf-8?B?dmtBY2RLUWtoeEtZVTRMTWI4VWpNMms3ZmRqSzc0SFA5NlR6NmFJRUM5NXM1?=
 =?utf-8?B?bkJPdEFMSklZazZwcEI4ZDRTUFBpbW1iUktJWXRGdzRsYU9MNFZ2c3c0NUN2?=
 =?utf-8?B?Um1Ob2drRDRrL21SZXdkdVNHOEY4OW55WGtVZUszbmZwWTdyVE9UVEE1dEp2?=
 =?utf-8?B?aUMvZElURnZzbldiNHJhR2pOaG51Z3Q5c1NsemhWTnA4bmtsZW0yQ1BNdWFD?=
 =?utf-8?B?K1dqYmF2S2dOSjdlWkh0Q1N3dDdXZUpncGdaS0JIdXBqZjZ3UXJiQmRia2Iy?=
 =?utf-8?B?dDRTRDJzNkgyOU9ycERDSU8zdHdnck5FSDAyMDV3Q09qcFY5QzZlb1lES2lQ?=
 =?utf-8?B?UEMrZ25DZ2N5bSsvOUs4eDJoQVNhMDkvNkM4U1licTdXYXVjdTROTEhoZWx6?=
 =?utf-8?B?M21FanRvanRJWHdxT2ZGek5oVytCaXdJcVVuSnVrc09mMVg4MHJlRkhmVm5R?=
 =?utf-8?B?U2NQeTBJSEJJSVYvRGdjN1NRRUxrUVZCQ2lEMWRyekFIbXJzT1JPNlBuQjRW?=
 =?utf-8?B?emRxSnFtb0dHcy9CZmpheWorQzdCQzVaTGl0SFlLa2xJdFdnL2F3aHRHRG0z?=
 =?utf-8?B?emlPd2hicHhHVElBaCtCMjhjd0hGMVpQRGRiWWFZWlB3WDU4Mm9tZHRQUi92?=
 =?utf-8?B?YU1uaEVnWmh2U1U5TzczeGtyb1Joa200UUg0Sm9pZzlET3ltYzdpRXFZMVA2?=
 =?utf-8?B?TnFiaWFZUEhBcWgxUDQ5K3V5M3Q5QkNNRjlBNW5HQTJKOEg3YjdqalZ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckE1bGI1VUhVTmhWOXM0MEVaZk1BRHQ0NzNBcGJsM1VkTDNhZ2FuUUtadFBJ?=
 =?utf-8?B?dmR3ZzEzT1Q0NDJ3Rk5wT2tldndzM2RMZ0NBbUVqd2drWm1FbkpLQzZuTkRN?=
 =?utf-8?B?S3E1RHZPVDNJa3h5MkpDaUswRDdkczNjWlA2ZDRhRVdRZlhiVG13N3BQbDFX?=
 =?utf-8?B?YytVY3RjUmd2SGh0ZTUreWJQcS9HcnpnU0NLK0pGK1hneVBJM01KRGJIZURk?=
 =?utf-8?B?cEJZd2xrQUo1VUVKcEFsdHhoN0hpTnNsT2pEdTl4RHRNbk1xR1VDeTlSdHdC?=
 =?utf-8?B?RjBnMGZLMXMydTR1L1N6SDN6QTJPM2FzR1ZUUFplK0JabDg3SGNsKzZvUkZR?=
 =?utf-8?B?MEFMUGtWREdKY0U5cEpicEdQQjI2MXdjdGlrQkFWMm9qdy84eW91ODNpc2xC?=
 =?utf-8?B?VXBnUDFGS3Q1cFNCbk1mbW5mb1dOeFU3SEVuVFpvc2lWUUZHODg1RUZlQWZL?=
 =?utf-8?B?R2RiMFhkQUVyRWYwM3hIUFR2OCtWNVowQk1iSkRQZjk4T2R4djVFV1Vnb2Vr?=
 =?utf-8?B?ZFNGa00ycWZTYWEvNUoyeitOL2dSd0JXMjVVTzh3dzJUR25wNWtCRS9GTDdP?=
 =?utf-8?B?dU1GNlQxVjFSbXBBNTdsK2cvanNoRUprdGlkdmpOdVJIZnNVQU9MK3U2M1VJ?=
 =?utf-8?B?enBkNmxKU0F6UmdDVmw4KzFzWWE1UXl6T28yRjIvc203L1pJbjFXQWg4cnRL?=
 =?utf-8?B?OUpYbXhOdE1ibFNtMHVFMVM5VUtSVWRLOG5odGpzb3BtalRMSTlkK25FRFRx?=
 =?utf-8?B?Z3gxQjNhQjltc0RlK3JUQ21hMkdsVld6WEkxQkowMDl6SWNzSlJ1Z1YzRmJw?=
 =?utf-8?B?L1cwMFZxMEw0Y1QvZFdKQjNabW5xRm40b3JXVEdMcFhUTzR5Z2lXenFPNmhk?=
 =?utf-8?B?UmFOemYrY3BGbHpocXBFcU5zdEltMzNLc3ZUOU1FMWxra2E3T2lDY3BtNk1J?=
 =?utf-8?B?akR0MDkzWmV2VVg1b0R4UFdUZE9FYysvSWFzOXZ0M3AweTdmd0cvL3IrL0ZN?=
 =?utf-8?B?aUp2cFRPTlNVM0tHL0lmVDFBN253ditidk9WZDhiaXJ1Y1ZmMnRMNEx6Um1j?=
 =?utf-8?B?S0twcVNhR2l3V0RmTjlqcWJ2dDF4NklpTTRHa0pIYTNvancwNlN2TVFuNTN4?=
 =?utf-8?B?RzgzZGxsZlluaXJwOFNqOXI0OEJsdm1pYzRvTk1HQWI4NU1UNE9qRWNwVG1W?=
 =?utf-8?B?dTk4dVRwK2cvMC9IMDgvWE5lakFLQjhpa1U2OVVkMGg3RDFJeExCVk9HTlhD?=
 =?utf-8?B?WTlrajhIcyt1R3gvbWRHL1ZWNUZVY2RzemNqT1RCamJubXN5L05yZkJLWXBH?=
 =?utf-8?B?NVA1eGZuVVhKYmFyNjRLeHY0RC85NVRJa0xvNmZoSTNUbHJtVDBkMDJKUEpl?=
 =?utf-8?B?YTB0ZFpPWDc0cFRINmlDQ2M3bTlPT2RzQ1FCVkhuQ1BWZ1NiakZ6TGF5cEUx?=
 =?utf-8?B?SlRpRm5RdnR4MHFEU1ZzKzNpSzhtUUVrRG9nV1dOdjhBaG04ZE5RVGFJR3lW?=
 =?utf-8?B?Kyt5aE14cUVOMVQrd3RYRmE2dVFueW5HajRFN1ZNQmtxZ2FPaElYQ1pLL1Q1?=
 =?utf-8?B?NmszMFcybzl5OFV5SEhic2d6YTBpS2o0N2xXRVBxYjF0SWdXR3ZhdWtrTXh6?=
 =?utf-8?B?TFMzalkxU0RtUW9meWl2SXBHVS9wODF5dU1BRHhXeVhXNVlwUlFTUGdtNWtF?=
 =?utf-8?B?UlpzYStQUVowKzBKOTQ5TjJJc2xZZ2JiZStJUmw1MzBFd3dQRThuaUs2K09a?=
 =?utf-8?B?WFdndzRpbEZGT3dDcnVrL3Vnc1kzY0NJMHA4ZUlsNnQvelFvV1Y4OTROQTdJ?=
 =?utf-8?B?MU1ZbFJsdC96WGI4dkdVSVRrZjdIZkR3VTB1dXI5RGllYjdjd2dYT2d3WGVM?=
 =?utf-8?B?SDhlRzQ2aThDREJkVWM4TVRQRVRRVmd6dzRJS1R4RDIxL2lJY3RyclBqOWRF?=
 =?utf-8?B?VXNXQXRFa3B6QzFBTFV6VVlNWUdxdi93WEgyTWsvY0RtSE4xcEtjN1Y5SENM?=
 =?utf-8?B?QUlUV0JpSkFYcDRzN2d6cERWNUFrZlBkVE9nYVJueVd6ZGZLdkpIVkhFYXZL?=
 =?utf-8?B?TGRYWnBGU0ZXN05Vd1VRUlk4ZkVPU1VpbHQzcjN2ZFQ0Y0RaZmlBak13L0xj?=
 =?utf-8?Q?wFfTpgQFX+BQKGaMzW0ImMrJL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b32d104-2315-432e-034b-08dc65c3e3ba
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 07:38:39.4652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BB0bz8rsYZ41GBCouzxsA6tperTMQIpY13x/lLdzAtd1FaGB+JrKqLcNW6jkSOg9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6832
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

Am 26.04.24 um 05:24 schrieb Ma, Jun:
> On 4/25/2024 8:39 PM, Christian König wrote:
>> Am 25.04.24 um 12:00 schrieb Ma Jun:
>>> Check the ring type value to fix the out-of-bounds
>>> write warning
>>>
>>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> index 06f0a6534a94..1e0b5bb47bc9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> @@ -353,6 +353,11 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>>>    	ring->hw_prio = hw_prio;
>>>    
>>>    	if (!ring->no_scheduler) {
>>> +		if (ring->funcs->type >= AMDGPU_HW_IP_NUM) {
>>> +			dev_warn(adev->dev, "ring type %d has no scheduler\n", ring->funcs->type);
>>> +			return 0;
>>> +		}
>>> +
>> That check should probably be at the beginning of the function since
>> trying to initialize a ring with an invalid type should be rejected
>> immediately.
>>
> This check is used to skip the gpu_sched setting for the rings
> which don't have scheduler, such as KIQ, MES, UMSCH_MM.
> Without this check, there could be an potential out-of-bounds writing
> when ring->no__scheduler is not set correctly.

Ah! In this case that that is not really clean.

Probably best approach is to change the "if (!ring->no_scheduler)" instead.

Maybe even move this code here into amdgpu_ctx.c:

                 hw_ip = ring->funcs->type;
                 num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
adev->gpu_sched[hw_ip][hw_prio].sched[(*num_sched)++] =
                         &ring->sched;

And then add something like hw_ip <= AMDGPU_HW_IP_NUM.

Background is that it is perfectly valid to have a scheduler for the MES 
for example.

Regards,
Christian.

>
> Regards,
> Ma Jun
>
>> Regards,
>> Christian.
>>
>>>    		hw_ip = ring->funcs->type;
>>>    		num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
>>>    		adev->gpu_sched[hw_ip][hw_prio].sched[(*num_sched)++] =

