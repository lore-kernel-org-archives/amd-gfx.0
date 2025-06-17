Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751F3C71155
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 06:10:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E47310E4BA;
	Tue, 17 Jun 2025 06:10:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WPGG0DWn";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41EE710E4BA
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 06:10:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIIjex0VGRaVNkINKsqy1vtQtXuOL14MussAcJrIMck/cwFSDzGkcxDjuPmt3r56yiyHJ+cKT6ZmZB0XigsByJ2I1vwCaM4KUTaoyZ0rGHiFlD47ZYULalH5/biIMPHMmKenJMZbGqOPgSBWdcKeeZ3n4m/RbWVFvs6X5+U9wHY+UjLxMrThE3zKdOStCwtRuM3IrTTLquEmAf6iGYSZzb9fBPun0n2z2l+Cp5FifjzSzd7fCXS06nGQQDSEQLtnMvswcA2DTb3UqtGAOj8nIOozYZRDSr4gcRlIs2utRmF9HawMSXLkoCtsuYNXIda+OaFhkZ8kMN1PMlm1qFBcIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGopUBTxrRXsJ/d0b2LuFLm2NeyQ8Gkuy8lHRab6oV0=;
 b=LyjapqAtgUFgVUHpQJanE7E//+T1+QNMntRo8ZI+rRdO5YmyMLbCtiZ1DAwZBFCQeIyAe4p8nJBgYrsdOJraxUAX8zHeJxDKgXf3+SSiHfK41XM9WidMTOzP6T4Lg3nh0ye6O6+bKVvAuGW+IbT6J2hgRvAu7cEkTmW2cXJG7XEQcvAsmWiJGS5YyeYcDl2hLaoBrIapF7xE7xaP07NwLxMxBABfjNFTWdbmc9TnH0A8LEtJGBuCHhri/1tcmoBi9SacHV/msQcfA+tKFU7WzqRNRPSgYWRIA7Ftagi5R5R717Wxtg2F6rYFBcevLxNWYC6hIZadKx6Cf2d+Ivn2Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGopUBTxrRXsJ/d0b2LuFLm2NeyQ8Gkuy8lHRab6oV0=;
 b=WPGG0DWn/DXfrxJH1EtZm3Hs7YMlqrQo5FsTRjip1qpdcfPmzeQhxjqaqbmOJTkbgiWTPVSKHiOQ2pdLjnQrI/rMrcMB/nIpp7FtFBuANW5qTKQW/fEXYd3aKrZn0cGfZgjRzXpiZnKy8jw5jhmxQf3bdJzsh+Emj3DtvjgI8wM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by PH8PR12MB7133.namprd12.prod.outlook.com (2603:10b6:510:22e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 06:10:34 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 06:10:33 +0000
Message-ID: <575d165b-f587-4a58-9610-f40ce6f52017@amd.com>
Date: Tue, 17 Jun 2025 11:40:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/36] drm/amdgpu/vcn: add a helper framework for engine
 resets
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com
References: <20250617030815.5785-1-alexander.deucher@amd.com>
 <20250617030815.5785-34-alexander.deucher@amd.com>
 <351309f3-eb1e-4601-a2c4-51482bbeedda@amd.com>
Content-Language: en-US
In-Reply-To: <351309f3-eb1e-4601-a2c4-51482bbeedda@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0195.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::20) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|PH8PR12MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: df8686cf-5d2d-484f-a665-08ddad65ab55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmNtM1BXM0dMRytRbElwei9Xem93Zk41MGdReklGWnZJbGNoYm5GQVZFSUpo?=
 =?utf-8?B?NlVSbzFmMEN3UUtyb2ZETVZaS1pidURNTnl3T2JoYlByeUVid1N0MWc1emY5?=
 =?utf-8?B?VUhPNTZrazE0WERRWmdac0hkekJKVndMNkZKb0pqNGtKS1BqblptaXhWcVNH?=
 =?utf-8?B?cFk0NW1wL01aV1crOFRvNnV1VUR3V0FEVWpoTGUwRHNFODdVQkJkeGIwQ2JT?=
 =?utf-8?B?QnZHT0JzR0NrODhoUkhESm10VkJLelhLanBzMEVUaHkvaytrT2pyRlU5Sllk?=
 =?utf-8?B?YTRsWHc3aXVKaDVMS2JtaHI3aTVwem4xTHY1dllrZnNOOWtjMEdtdVIxUVpk?=
 =?utf-8?B?THNBakdlYWdaMmx1bnl0RU80MzA2a0ZRQVpJeGZJdHJOeUNJQ2NYeTJVZnpV?=
 =?utf-8?B?dkpCbWRNdjlRSXI4anoyR1NibEFvUW1LaHRqYUFhSzhIZ25CVjFIQUdTdDJr?=
 =?utf-8?B?R0Z2Tk1MZTRYWXFUU0pablhYUVgzb0M3dHVuTklUdmM4SHorMVhPZERPeHZR?=
 =?utf-8?B?MVVOVHcxTjVwR0hjbytxSHIvR0V3Z012VjFvMHp3NmpYNVQ4cGxpZ1ptWkxO?=
 =?utf-8?B?bXFmNW9XRkRrREg4MWgzcWUvMk0vc1pnVktBSHpSTUF5bm9kelBRcm1Lejh3?=
 =?utf-8?B?TTBkVHVxNW43Y3E3UG5QUFRyTkxBcitGZnVYdHlrZGhnMzdxcjYrUHR1dXQx?=
 =?utf-8?B?QUZkZDZPVGJTMHNpWE51NStNaFZMaytVSU91aFlERUVvV0pHWGZmZ1ZkTURl?=
 =?utf-8?B?Z0hhb1RKcVcrdVdyakl3QkRleG0zd2tTSm93QzVzdjBDUE1CWGp5aGkyQ0Ny?=
 =?utf-8?B?Mjk2L3p0N3ZoSWRZb3g5N1NNYTdlZ0RSdjNqMCtxWWh2Mk9CVENrdkIvVnlO?=
 =?utf-8?B?bzZHVWs1c1NmbjgyK2Q2dWhqc1NPclBnZzdkZDBWWG5WeWtBYXRNUEZ6anNN?=
 =?utf-8?B?cDIzMU9lYk5TVUpvVVVkV3FnYnRYb1loWmI5TEpRSWZtU1lybDR5aXo5VjRo?=
 =?utf-8?B?NVRqc0lUbEVoK1U4NnhzVldETVlydGw5QWpmVVRQUnpPQVNYdmVvNDNIWEcz?=
 =?utf-8?B?dEJKTm5uM1VHV2tPUkwzYisvTGtrQkFMUWxTUnNrb3llQjdmb3l4Zk9aYUNH?=
 =?utf-8?B?ZEs5ak9oSi9hS09raEZWMFVnNG5TQitnbGg0Y0dQTFFudkpISWZqOHBnSmxz?=
 =?utf-8?B?RzFQdzdJbVdFOC9iaW9xclZKdUhaYzhUWEU5cVU3UmhiZSszd3h3K1RUQVA2?=
 =?utf-8?B?ZVNuVW1yQ1lmc0twR0UveStubi9DcWxxNFFPOU10cnNrSkVlNHVaK3dRTThY?=
 =?utf-8?B?TXV0d2QwM2VNZHFKR2I5RXYwQTJNZVZVSHp1KzR4OG5acTFJVTJHZW4vcG5K?=
 =?utf-8?B?UklveCtRV2kzMkVUMDY0L2txNkNzMEc2KzkzQy9HaG50dHNiM2UxblY1VzJN?=
 =?utf-8?B?bTZqSGFlR1QwMGNTaXpIaU42eUlaVVN5SzlGeVpKeVpvWm95bVBBUExkUzhv?=
 =?utf-8?B?Ykc4SkdlNzdlMm9EZHU2VmlvUEpsVWhMNTByaStSNWYySEducHRicVE3QS9O?=
 =?utf-8?B?QWNWNVNaVkNRTEpLMEJTeFNqTmlRdWsvczhQMVRTRkV0em9IaTF5Y2llNlVB?=
 =?utf-8?B?TEsxL3ZWTXBUYjgvUmJYRkRoaS96MHhDbmtCUXgzSDd4SjR4MWJPcEFDZURJ?=
 =?utf-8?B?NGdWNmxoUjR6VWhaN1N4Sm5na1NSQVlRVWY0bWVQeExCT0NaYUNJbjQwdTdZ?=
 =?utf-8?B?Zm1XSVpXZWR1NHZNa1gvcU5LNFZTdVJzS1dSNU9wc2tuQ2VMQ2ZRc2tHYllJ?=
 =?utf-8?B?LzBSVEpRNm80aC85ZHk3cThUbkx3OWlTZU94VHRrOHU0czNUcWg3c2RzQ0Jj?=
 =?utf-8?B?MTh3cVhMTmM4TVJPclJJbUdCaE1VRjJIbGsrc3FaZmU3ZjBwa3RsenlIYWJi?=
 =?utf-8?Q?L246vow65AY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlJpNEVubzIzc0JhZCt3L3BPcDFNRHF6Y3QrQ3NRQnJmbm9QSlNqOEpQSWRt?=
 =?utf-8?B?My9IMzRZZU5EZVE1NHpKYVZORDJ4WnhFcTN6NTU1TkdqL0Nzc0Q2VGhRcGY5?=
 =?utf-8?B?TWN4WmNBNllHMVAyblYwUy9GaVhNREE0cXZZbmR0Z0dUaFFBZm1IODk4OXg5?=
 =?utf-8?B?YXpvSGhQajUySitTY2wzR1BlQ1M2ckpKRjNEbmRDTDQrbGs4Nms0VEFrOG1C?=
 =?utf-8?B?b1hpT3NYUGVvTFgrZy9MSjFvM1IwRU5IRzNnelNaaExiTHYxQnZUL2xDaXlq?=
 =?utf-8?B?UHQ1bG9UOURVc2Z3SGZFM0ZXOFlXTllUYmI0YWVYV0NtSko5eGpOd2xHcU5k?=
 =?utf-8?B?SkNoRk92RXpucm1adTF1bk82eE5JOUxhMUtMWVUvZW8xQnhGY1ZGZ29FZ0JJ?=
 =?utf-8?B?T1UwR2NvR2RsTS9CTERKR09kR1FOUjh1U1hEajY3bVV3aG9CQ0Z3eTR1VkFw?=
 =?utf-8?B?dXU5T056aWlrMmxiQmphRUpaaDk5VXZ0c1VyeFNLcUJhL3JTOVdsWDFGMjd5?=
 =?utf-8?B?aDdBaUhTZkRuQXZEZmxnUzdicHZySEZNQlkwbWxadWpuY1JoS2R0cmJHM3do?=
 =?utf-8?B?UFhZeUs2SzJQRnozQ1YzTjZ2NzNQRCtVVC9LMHR2aVpZNmYzSXY1bXVzZEk1?=
 =?utf-8?B?S2tpYlZRUm9LdnNneklXZytkVW9zSExkcTZFb3hGQWFPaklmQWoxZFhqT01R?=
 =?utf-8?B?QU45QWoyTlJDZTBPSmRGS1ozSEM0ek1CeG8rdUtTUWx5cHZ6YkZ3cS9ZYzFW?=
 =?utf-8?B?Qy9NS1MrL09uQVZ5clVQdHl3OTU1SEdZV0ZvY0M3YkorMTE4OWVzTG4ybVk2?=
 =?utf-8?B?Z21tRmVXdkhiS0xiaHE4bW8xNGNsT29JZ0hleS9HRXFQMTY5d1hiR211VjdT?=
 =?utf-8?B?clhJT3NuZkxQNkE5cFkzRzhlMFZpaU1kWHNpSXpuQnQwRGFOSmRZWVczbFBJ?=
 =?utf-8?B?alQyNm1ucEEwZnZZeTVqa3FWVmo2dmJaUDE1b1JCNWNta0JJSXNzaGtCSVJT?=
 =?utf-8?B?WkZPZGx0TDZEUzg0YWVyMnI1YVpLRUhVZTVnU1BodW5JRjVwZHBQNFJKUlpp?=
 =?utf-8?B?anFweE51RkwzS0hhcjgvb1dlMXZNT3R4ckNaYVdtZldCa09WVHRyZC93TFFH?=
 =?utf-8?B?cXRNWHNiNFZkMjk2UDhaNmo2ak9EVmpvZEVzYkkvVzM5YXRZQkY4NU0yYU1a?=
 =?utf-8?B?Q2owQ2N0clgyQklHcElMcU44N0kwcGFpVW1oOG9NUi9LR1NnNGJZY1AwdEYr?=
 =?utf-8?B?SEJmc0dGb0szSTNDVHQzOUYwK1RQNnRsYSsrSHErL3VqOE04eE91VWsydW5J?=
 =?utf-8?B?dG93MWUrSEQ1WCt1MXYraEVZVC9pWXlVOSt1bTM0eklVR25TdUg4ME1lOUM3?=
 =?utf-8?B?QXp5RnBiNFp5SCtxZHZQWElOK2h6UmR3L0YvdzkzVzB2M3QxMHJnVzFhWHlw?=
 =?utf-8?B?blk3UEhzMWdmVEprQkh3SUlWOHlZeWFZVWhRRW1Cd3o4dGtQcjdnNjFSNEtl?=
 =?utf-8?B?d3ROcUFML2g3cWlsUjVFYWE4aHYxak1LQm1Bd29zbkw0Nys4SkVCVGtJV1ZK?=
 =?utf-8?B?NUFXaXBobWpKK0dQOTJFeGE4UkVmZ1Y5VVJxSWpVMjFQQmdDR1FsRzgvQndL?=
 =?utf-8?B?ZFMraG5PUUxNSWprekIrZ21IWVFXY1NnRVpZeWNJZ2kyNm1oOTIxdDgzeUZK?=
 =?utf-8?B?M1hhZnhEWjg4VE8vb0FKbnJtcW84dTQ4U0x1QkVVNW1odWlGTFlWZ2djSUJy?=
 =?utf-8?B?QzFIdGN0bDY2LzVoUFlTSFI0dzczUFBLekNXcEZYVU5LcE84Y2RMRUdSVmRJ?=
 =?utf-8?B?SDhUcmd4S1huQXpva1NNenRtOGtGNHI2VTFQYVFDTHpwS2x1ZEJnUGVaRlN2?=
 =?utf-8?B?VFMxbHpxYnc5aG1sYlZvQk9ZZHk1TGdZK1NobEJzYWp5RlNUVzZRRjVxMnNV?=
 =?utf-8?B?U0JuNGpadWc3L3VCUEg2bWdpTDRJd0RsYTFiOVVFck5tdTRxUUNQcXJUS2Vj?=
 =?utf-8?B?UHNBK1Z0bVI1dWRqQzBWUUd3MzJRTkdpOWY5VXFVV3hNOWFjMzFsMzhMMnRy?=
 =?utf-8?B?ZnVpUWlBNWhDbUhITTJvU0NGZ0hnZ2oyOTFCYmNWNHJFRkxJYTJiY0tzSFJy?=
 =?utf-8?Q?Qss7cvx6mtgPSBBvzjq2Idc9f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df8686cf-5d2d-484f-a665-08ddad65ab55
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 06:10:33.7760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZClL3qyD0pRRIGn2Mz1Fe25QdtxoZ40M6d9OTf8JD9niKB7pky6y1HwBYpmV4zUh+H+XRbp2nBHHNAuVzYzfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7133
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

Please ignore my previous comments here, the new helper additions for 
vcn non unified queues are good.

But one concern, the vinst->reset(vinst) callback must take in ring 
pointer to handle guilty/non-guilty
for appropriate re-emit part, else the guilty ring has to be tracked 
within the ring structure or identified
by some query with in reset.

Regards,
Sathish


On 6/17/2025 10:00 AM, Sundararaju, Sathishkumar wrote:
> Hi Alex,
>
> Would it be good to have this logic in the reset call back itself ?
>
> Adding common vinst->reset stops the flexibility of having separate 
> reset functionality for enc rings and decode rings,
> can selectively handle the drm_sched_wqueue_start/stop and re-emit of 
> guilty/non-guilty for enc and dec separately.
>
> And the usual vcn_stop() followed by vcn_start() isn't helping in 
> reset of the engine for vcn3.
>
> I tried a workaround to pause_dpg and enable static clockgate and 
> powergate, and then stop()/start() the engine
> which is working consistently so far.
>
> Regards,
> Sathish
>
> On 6/17/2025 8:38 AM, Alex Deucher wrote:
>> With engine resets we reset all queues on the engine rather
>> than just a single queue.  Add a framework to handle this
>> similar to SDMA.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 64 +++++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  6 ++-
>>   2 files changed, 69 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> index c8885c3d54b33..075740ed275eb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> @@ -134,6 +134,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device 
>> *adev, int i)
>> mutex_init(&adev->vcn.inst[i].vcn1_jpeg1_workaround);
>>       mutex_init(&adev->vcn.inst[i].vcn_pg_lock);
>> +    mutex_init(&adev->vcn.inst[i].engine_reset_mutex);
>>       atomic_set(&adev->vcn.inst[i].total_submission_cnt, 0);
>>       INIT_DELAYED_WORK(&adev->vcn.inst[i].idle_work, 
>> amdgpu_vcn_idle_work_handler);
>> atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
>> @@ -1451,3 +1452,66 @@ int vcn_set_powergating_state(struct 
>> amdgpu_ip_block *ip_block,
>>         return ret;
>>   }
>> +
>> +/**
>> + * amdgpu_vcn_reset_engine - Reset a specific VCN engine
>> + * @adev: Pointer to the AMDGPU device
>> + * @instance_id: VCN engine instance to reset
>> + *
>> + * Returns: 0 on success, or a negative error code on failure.
>> + */
>> +static int amdgpu_vcn_reset_engine(struct amdgpu_device *adev,
>> +                   uint32_t instance_id)
>> +{
>> +    struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[instance_id];
>> +    int r, i;
>> +
>> +    mutex_lock(&vinst->engine_reset_mutex);
>> +    /* Stop the scheduler's work queue for the dec and enc rings if 
>> they are running.
>> +     * This ensures that no new tasks are submitted to the queues while
>> +     * the reset is in progress.
>> +     */
>> +    drm_sched_wqueue_stop(&vinst->ring_dec.sched);
>> +    for (i = 0; i < vinst->num_enc_rings; i++)
>> + drm_sched_wqueue_stop(&vinst->ring_enc[i].sched);
>> +
>> +    /* Perform the VCN reset for the specified instance */
>> +    r = vinst->reset(vinst);
>> +    if (r) {
>> +        dev_err(adev->dev, "Failed to reset VCN instance %u\n", 
>> instance_id);
>> +    } else {
>> +        /* Restart the scheduler's work queue for the dec and enc rings
>> +         * if they were stopped by this function. This allows new tasks
>> +         * to be submitted to the queues after the reset is complete.
>> +         */
>> +        drm_sched_wqueue_start(&vinst->ring_dec.sched);
>> +        for (i = 0; i < vinst->num_enc_rings; i++)
>> + drm_sched_wqueue_start(&vinst->ring_enc[i].sched);
>> +    }
>> +    mutex_unlock(&vinst->engine_reset_mutex);
>> +
>> +    return r;
>> +}
>> +
>> +/**
>> + * amdgpu_vcn_ring_reset - Reset a VCN ring
>> + * @ring: ring to reset
>> + * @vmid: vmid of guilty job
>> + * @guilty_fence: guilty fence
>> + *
>> + * This helper is for VCN blocks without unified queues because
>> + * resetting the engine resets all queues in that case.  With
>> + * unified queues we have one queue per engine.
>> + * Returns: 0 on success, or a negative error code on failure.
>> + */
>> +int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
>> +              unsigned int vmid,
>> +              struct amdgpu_fence *guilty_fence)
>> +{
>> +    struct amdgpu_device *adev = ring->adev;
>> +
>> +    if (adev->vcn.inst[ring->me].using_unified_queue)
>> +        return -EINVAL;
>> +
>> +    return amdgpu_vcn_reset_engine(adev, ring->me);
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> index 83adf81defc71..0bc0a94d7cf0f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> @@ -330,7 +330,9 @@ struct amdgpu_vcn_inst {
>>                     struct dpg_pause_state *new_state);
>>       int (*set_pg_state)(struct amdgpu_vcn_inst *vinst,
>>                   enum amd_powergating_state state);
>> +    int (*reset)(struct amdgpu_vcn_inst *vinst);
>>       bool using_unified_queue;
>> +    struct mutex        engine_reset_mutex;
>>   };
>>     struct amdgpu_vcn_ras {
>> @@ -552,5 +554,7 @@ void amdgpu_debugfs_vcn_sched_mask_init(struct 
>> amdgpu_device *adev);
>>     int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
>>                     enum amd_powergating_state state);
>> -
>> +int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
>> +              unsigned int vmid,
>> +              struct amdgpu_fence *guilty_fence);
>>   #endif
>

