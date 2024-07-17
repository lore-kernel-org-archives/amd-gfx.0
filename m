Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B00C3DA5D
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 20:10:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7868F10E3D9;
	Wed, 17 Jul 2024 20:10:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UTgrNGA8";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A776E10E3D9
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 20:10:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9GMDweP4vA0V9L7ilAldCNVUH5cABYdqgUZxXEb/YPMWiQk8j1xDK/i6v1s7cvmqdPn5ZEdfVLAeHM3sAOj3vNF+T2+zt8Rwn3wdrVptJqTqQLzc5hZFup9JbgQS3C5TpEHs+SlLcijoUWAReXAyCT4qGkKNHB3mATDsb2uM/yqimUgBNYDzRlKHOU+MVCZos9LQ3yq5Z+q4giD9KvgQfPrUHfMFG8sP4vf3TNXycHMBeXF6XlJ+63e122CzngJhUM2s6C/5Iv0jXa0BE8pT5qMlCVEVVwBuQD0vfpSNVG1VMmJo/AdLIMrnH/XiQ2U5aghzYynFxD4nMtaEATYLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IpmdshOVxwkaZ8R50Gfj24ijZbiV/ecPfHpJpyLftc=;
 b=BiHE+PSVk/xbtpjRRwdrsyEgzwvI/75P7lQlmLadeYn7jpMp1ALSUxn/oNY8kZfbANlzsV5dPXQYlbhQVg9GnKKEKagxnOm367M5kNHtlOK2oe4uQWjGhKRrn1f9RG85QCkaSWStjyfqUTNjOY0FXEPbVzGE4pQu5vx0uNM0tYWIbcPk2SInNeiw84smN+bwbKoP/jOtDJzNLhwvtihkiCYosbgOGVD6RxmfhCTMByAQC0RJPpKryzlohyj2fcllMZQFpSqfrTtgapG7UTHyOaogVL4Tu0+jgA5kE8WOXvUVjh9mJrnm2NUwM4g5ykho5KnxUbIcpgDuDb4ZSJrZsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IpmdshOVxwkaZ8R50Gfj24ijZbiV/ecPfHpJpyLftc=;
 b=UTgrNGA8BbPsfE2GlpdezepYVWi2qmuXvEsB5gmtWkuEq/GqoXEGfDcKLsysNZ8FkJEeXDCTjsx5VMdb1pg4NB1cbq+gzaB+uhKgBuowLlznOnWCk8OpPlQMj4wLq6AtaG+x8iGEXmtUimin3G05IlPcz4l2m6KOqzSAu0dw/GM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ2PR12MB8807.namprd12.prod.outlook.com (2603:10b6:a03:4d0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Wed, 17 Jul
 2024 20:10:34 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 20:10:31 +0000
Message-ID: <2239cfa0-6f41-4d8a-9915-0ec1829e248d@amd.com>
Date: Wed, 17 Jul 2024 16:10:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] drm/amdkfd: Refactor queue wptr_bo GART mapping
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com
References: <20240715123502.7013-1-Philip.Yang@amd.com>
 <20240715123502.7013-4-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240715123502.7013-4-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0312.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ2PR12MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b743f0-137d-4232-5465-08dca69c8254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THR5allJdklNUkQyZmltQzJFbFhUVVVsbnpnY2FKMWlld0J4bUYxRVF4ZDJX?=
 =?utf-8?B?L00rSUROQWpkR2RpZUZJODRBamNZQXNlVFUyUXFwTGxhemxxUUFTTEM3bUVO?=
 =?utf-8?B?c21YcTh4SmlMQ2FpcmpLbzg0UzNBWlh4ZTNtL2daaXNIRjA0SVRLSEhIZWRK?=
 =?utf-8?B?WTZGVUxPL282OG5iNTFRR3J2ZjNCelhCb09yV2xkaXVnWGZhWGxhVEt5MHJy?=
 =?utf-8?B?SUdHaEJDOHcyMGtqM29KTlhnV2ZYMk1NVmQ0VTN5MGw3Njd4SWlCYXRrM0Fz?=
 =?utf-8?B?MkxxMVlFUWltNmNySmw2clZGVWNyUEFCT2hSaks5TGxNUlZIN1gvNG9QTzcv?=
 =?utf-8?B?S3FDZ0RaM2NnTndWL0NLQVFKbS9tWDhDT0R4dzJrcWpzK0pkM0cyUnNsZzR2?=
 =?utf-8?B?YURMNVN2TXJqMVVHYVZqd0UvRUNEUy9EYVhWVkxQUmRlWlQvaGZHb25pdzlQ?=
 =?utf-8?B?OXMxVFllcmExZk45bHRuVGRmcEVVY01TZ0VQSC9yYkoxNVAyd3g1aWFBOHBS?=
 =?utf-8?B?enV6a0tIaXNhK3RkWU15S2MwWElMNndqNGg1aTRrY21qR2F3aDdxK3VHcjQv?=
 =?utf-8?B?L0FPc2lTQ2FGSDArbkYxSWhvY29NdTZuVDZzaDNVKzVCUlo1UGM1NnRiMXBk?=
 =?utf-8?B?NTNZZ050VnFsVmsxTXczSHFCZjJKQmFlSnFldjY5dVNnUWVJMENEVHZPTGFY?=
 =?utf-8?B?Ris4QVZDZ1N4a3pRRjNweE04dG5RVlF3b2RmNFVkSDkxK3pKaVVWTTAyQVJN?=
 =?utf-8?B?cnRQZy9ZVnA1WjFFRXJFZzRCRzNwelFOZ1FtTGJndmpXbjFCVUtDN0ZCamlE?=
 =?utf-8?B?UEFvd20zdExCZmdDS3NjTktlZ1YzNktHZHR4R3BibjZ1MlJKdjhObFNrR2hz?=
 =?utf-8?B?SWl0TEFxU1Q4ek1rSS9DdFByZFFnYUZoUW9kWTcyZU9NcUw0endoK2FTQmVC?=
 =?utf-8?B?Lytnc1JUZU1janhKd3ByNjBHVkJUNmQvanE4WEtURTNNVmNTVkJkMnkrMWRV?=
 =?utf-8?B?WU9zYnpLU0ZrdkhjQzZ1d2RiVktlSFZQQ1RydkpUZWo3V2dtd2xWNnRrQTRi?=
 =?utf-8?B?OXF1aXZNVytWSVE5TnZDZFduM0FIZnRaaW1BRGJEY09LVFJLYmdubXpIc0l6?=
 =?utf-8?B?aHhrNVlJWHgvSTlPb24wQ1JoN0drQ295VkFDc1haZElLTlExVjgwNjc2ZlJh?=
 =?utf-8?B?aXhHL0N6V0haNWlobGRCTk9mQ29tNHg1a1BHOGs1ZER1NHFrSnJzbWhtcFMz?=
 =?utf-8?B?Z1NhSktxb2R0TVVDT3A3VnpVeHZ1TEJwZzB6NXowa3RhYVdmU2FMa0FpOTNO?=
 =?utf-8?B?bkU5ZUVhdm1ZZWVQMVpodWlkZXFXSzFJckd1ZlFDTWJSVmZHY2FqODV4SGdZ?=
 =?utf-8?B?WS9ZVnNMa2RxUE5uZEQweFJkVVN1ZWNNOVh6MWNmQWVWYU0yMUhqVUUwUzJS?=
 =?utf-8?B?M3d2VjBPT01hK01RdG5kVHpNYXhYK2szZ0hJRmlKQVo5L05UTkxWcXhDSTVj?=
 =?utf-8?B?UmgxNStSK29OWVNsWkxFdm9iOVd1b3ZCNWtxS3hTRE1XeHJoQnFidW41eUxs?=
 =?utf-8?B?aWMvaC9rTDdKTXhUb0prWWloVXhmWWpBNGZvaXRVUFEyU1kzZ2hTeDU2NmVu?=
 =?utf-8?B?T1VLYlBYMG9sTFVtVWszSDBpQm4yZ1J2QUNubWw3OEw5ZnYyeFU3Mm5uL0V6?=
 =?utf-8?B?a0FDRkpmN3Q2blZ4USsvZlo1eFltck5OeG9QQkliV2FlZzg1b2FPMmpWMjQz?=
 =?utf-8?B?MmptQlJhVDFyWGllQW02bnVaSUJsZ01lVXQzdE1vc0JyMUZtZDJXSzQzM1cr?=
 =?utf-8?B?SGhXRCtrYmNsUnJNMExjZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rys4citCanZPRzVjaU9EckhkQjJPTDJXdUcya1dEOGd5VndKZjJuN1BUUEhz?=
 =?utf-8?B?QjJVc0QxMzlXQlpoTVU2UE9uNXBQNitwWElpdVR5eUZ3aHV0cFFJWC9zdjZQ?=
 =?utf-8?B?N0FoQ0JZdWNrT2tDcEtVTXFjMklDelFrY00yWkVSQkUrdWg5RzNKMU5ONkJP?=
 =?utf-8?B?cmFiVXkxc2ZWaExvd2RDVGYrVmU2UXRmN3I3b1NmQmY3MTQ5WGhlakhjVStt?=
 =?utf-8?B?ek5FemNqZldQZUdJbWdscFNEWTRlR3I3VmdxYmRlQVh2OVlReUpEU3hTUk5X?=
 =?utf-8?B?T3pqaXR1TjhCVlRVVFdUaEZJcFNaRVgvZVBmRWhBN0VoRGRhTmxOQjNZelBy?=
 =?utf-8?B?NVpXQ0Zmc0VyK1BGenoyYkR2eXNsMkVsZXFERVpDOGcxZEYyblZRMUhoQVZP?=
 =?utf-8?B?NlJOVGVzdDJpL0xrc2pTZ1dFYzR0bGFZQ2l4dDNIZzF3UFVSWTVBUEQyaFJK?=
 =?utf-8?B?WFBIdE5DV0tmelBPUUZ0ZVNDeVloU0FTVUJGa1BEb0RRQkhnOVF6OS9jWEpW?=
 =?utf-8?B?Z2tkRG5PT1dJNFp3NlRIZGtsM1M4UVNMU1NkVGpPTUdoRFBGRTNpZVlyeHBk?=
 =?utf-8?B?Q3UyWUplbUZHK3dMUU52RGQ3WDJrVFhJQURZVTk2VnJLK1lqOERnYTdJdm56?=
 =?utf-8?B?elRPbC9DMDlKYzdQRWdRSWM3dkFkS05SZXZTeUFzQW1LVHFYM1RQVkpWb3pW?=
 =?utf-8?B?K2pPZUl3VzlYSERLaEcxSXhIc0U2eWNaaGpLN1RmNTJ1aUdUZHgvWXhzS3ln?=
 =?utf-8?B?L0trYXB1Z0NVNTFmWHNXSXJUTUVBcUhXMmFFaHhLbHgyZ3pzRldSbzV3c1o0?=
 =?utf-8?B?RXF1RmRrUzZhOXpuNVJkZUpsbFEvWWRDQ1J0TUxpNVF3UnZLb1F6RGNURy9a?=
 =?utf-8?B?cVFaQzg4NUtaMGR2YWozWDVmTTF6WVhCbjJTcmxPL0p4c2pucHdqcTdoMzZr?=
 =?utf-8?B?MWVlUDZsY1NNdnFmRHBSd2QzRitFY3doZTlWUkNWMm44V0M4cDF4bzJVN3Nh?=
 =?utf-8?B?TEd4aEZmOWlYRDd4Z3U2RThkamZEWFRtMC9KaEphNUlKamxkVVBvTm9sMW1K?=
 =?utf-8?B?dS9UUGFaMzg2YklQNkIxNHFuang5V1Zhc3liT3dnajJCYVJVSHIyZm5WZXpk?=
 =?utf-8?B?QjBRMDhrbnBKRnIxcmVjclN1aGxSY1JqeWtjTWxuWk1GWTZubHI3ZTFzVGRE?=
 =?utf-8?B?aDh2Z0I1WUQrUUFqNUVQQmdPUlY1dXdhWVI5TGk3ak4yc0IxdEROa3RwOEhl?=
 =?utf-8?B?S1NDOXQ5ZEtya2NpNFVLeWZwR282ajJaZW1GMnRnQkQrYmZ5V1FtVlc1Nm1a?=
 =?utf-8?B?cllsYW1HMkRnTFFxYUpnZDA4L09vdU5wUEt0R1BUM1JyVUIwYXlabFdGRlV0?=
 =?utf-8?B?R3Bsdy9NREVrQmRnUXFqQ0RlYTRLWG9mS3l1T2dXK2tybFdxUXFKMXpWTTRG?=
 =?utf-8?B?cFBxeVBaNzg3aGRLaUdKVEFwUDdyalMzUVlwaVF4UWs1UCtzWTVwQUQ2aG81?=
 =?utf-8?B?QTZ1b05rTFhWbGtLQlVEdjFPZnpyeDllSDQyd0hxTGdaS29OMHl3Rmx3bXBV?=
 =?utf-8?B?dU1pSU9jem1HSHlESzRWRDkvWTU4eitjVDZTVWVHSGFSWmhOY3ZVSURIa0l0?=
 =?utf-8?B?aWdNZjYza09EZHFKcVBtMUNZTHA2MnFZNUQ5ZXYxMldJL1FJZDYwYzhGSXJY?=
 =?utf-8?B?cGtWR3ZwS1ZZeFZaZXhtNkEydFNmSjFyRUlCeWtLTVZ2a3FxL0lCNE1rUEZY?=
 =?utf-8?B?cldscVdCM2dJRmx2M2tyb2V2bnhRNVl1dzB6S0s2US9CemVZdld6ejYycUpz?=
 =?utf-8?B?alQ0akltd1Z6eDRPaGQ4TG05b25EL1gzWjhnTTlaZUsrYy9tN1BEQ1pGRnB6?=
 =?utf-8?B?dGZHQTF2bjdydnF5anlNVW9rZi91RkEyMnMwb3hDVHI3NncxTlllZnJWQVA3?=
 =?utf-8?B?WjBxREdLUTZ2elVqNnhXMFJCcjJUNHFrbkRDWlMwZk53d1lNS3E3dmIwYUty?=
 =?utf-8?B?YkFBQkdLbmVYOTlyZ2FWTFJzbEJGMS9YSjNJMjlPb0JNRmVCTjBBM1hUY2N3?=
 =?utf-8?B?U29vYWRlU1A5RHVjTW5jVTBUNnNMMHRlRVY0SkF1OU9tQVNYUVZHRTFjUXRy?=
 =?utf-8?Q?yN8A7J9DEo5k/gBassXwFj1Bv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b743f0-137d-4232-5465-08dca69c8254
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:10:31.2608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S1/zq4UZhxbKwODIG2da2XhbC7TaU5LEHXfoj9e7v9atAplgCukImaoc8PUQktyiAZldjdpvOT5sOLCYjARmDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8807
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


On 2024-07-15 08:34, Philip Yang wrote:
> Add helper function kfd_queue_acquire_buffers to get queue wptr_bo
> reference from queue write_ptr if it is mapped to the KFD node with
> expected size.
>
> Move wptr_bo to structure queue_properties from struct queue as queue is
> allocated after queue buffers are validated, then we can remove wptr_bo
> parameter from pqm_create_queue.
>
> Because amdgpu_bo_unref clear the pointer, queue_properties wptr_bo is
> used to acquire and release wptr_bo for validation, add wptr_bo_gart to
> queue_propertes, to hold wptr_bo reference for GART mapping and
> umapping.
>
> Move MES wptr_bo GART mapping to init_user_queue, the same location with
> queue ctx_bo GART mapping.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  5 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 56 +++---------------
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         | 14 +++--
>   .../amd/amdkfd/kfd_process_queue_manager.c    | 45 +++++++++++----
>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c        | 57 +++++++++++++++++++
>   7 files changed, 116 insertions(+), 69 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 6e591280774b..4ed49265c764 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -322,7 +322,7 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
>   					     void **kptr, uint64_t *size);
>   void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem);
>   
> -int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo);
> +int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo_gart);
>   
>   int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
>   					    struct dma_fence __rcu **ef);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 199e387d35f4..0ab37e7aec26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2226,11 +2226,12 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
>   /**
>    * amdgpu_amdkfd_map_gtt_bo_to_gart - Map BO to GART and increment reference count
>    * @bo: Buffer object to be mapped
> + * @bo_gart: Return bo reference
>    *
>    * Before return, bo reference count is incremented. To release the reference and unpin/
>    * unmap the BO, call amdgpu_amdkfd_free_gtt_mem.
>    */
> -int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
> +int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo_gart)
>   {
>   	int ret;
>   
> @@ -2257,7 +2258,7 @@ int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
>   
>   	amdgpu_bo_unreserve(bo);
>   
> -	bo = amdgpu_bo_ref(bo);
> +	*bo_gart = amdgpu_bo_ref(bo);
>   
>   	return 0;
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 823f245dc7d0..202f24ee4bd7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -247,8 +247,8 @@ static int set_queue_properties_from_user(struct queue_properties *q_properties,
>   	q_properties->priority = args->queue_priority;
>   	q_properties->queue_address = args->ring_base_address;
>   	q_properties->queue_size = args->ring_size;
> -	q_properties->read_ptr = (uint32_t *) args->read_pointer_address;
> -	q_properties->write_ptr = (uint32_t *) args->write_pointer_address;
> +	q_properties->read_ptr = (void __user *)args->read_pointer_address;
> +	q_properties->write_ptr = (void __user *)args->write_pointer_address;
>   	q_properties->eop_ring_buffer_address = args->eop_buffer_address;
>   	q_properties->eop_ring_buffer_size = args->eop_buffer_size;
>   	q_properties->ctx_save_restore_area_address =
> @@ -306,7 +306,6 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   	struct kfd_process_device *pdd;
>   	struct queue_properties q_properties;
>   	uint32_t doorbell_offset_in_process = 0;
> -	struct amdgpu_bo *wptr_bo = NULL;
>   
>   	memset(&q_properties, 0, sizeof(struct queue_properties));
>   
> @@ -342,53 +341,17 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   		}
>   	}
>   
> -	/* Starting with GFX11, wptr BOs must be mapped to GART for MES to determine work
> -	 * on unmapped queues for usermode queue oversubscription (no aggregated doorbell)
> -	 */
> -	if (dev->kfd->shared_resources.enable_mes &&
> -			((dev->adev->mes.sched_version & AMDGPU_MES_API_VERSION_MASK)
> -			>> AMDGPU_MES_API_VERSION_SHIFT) >= 2) {
> -		struct amdgpu_bo_va_mapping *wptr_mapping;
> -		struct amdgpu_vm *wptr_vm;
> -
> -		wptr_vm = drm_priv_to_vm(pdd->drm_priv);
> -		err = amdgpu_bo_reserve(wptr_vm->root.bo, false);
> -		if (err)
> -			goto err_wptr_map_gart;
> -
> -		wptr_mapping = amdgpu_vm_bo_lookup_mapping(
> -				wptr_vm, args->write_pointer_address >> PAGE_SHIFT);
> -		amdgpu_bo_unreserve(wptr_vm->root.bo);
> -		if (!wptr_mapping) {
> -			pr_err("Failed to lookup wptr bo\n");
> -			err = -EINVAL;
> -			goto err_wptr_map_gart;
> -		}
> -
> -		wptr_bo = wptr_mapping->bo_va->base.bo;
> -		if (wptr_bo->tbo.base.size > PAGE_SIZE) {
> -			pr_err("Requested GART mapping for wptr bo larger than one page\n");
> -			err = -EINVAL;
> -			goto err_wptr_map_gart;
> -		}
> -		if (dev->adev != amdgpu_ttm_adev(wptr_bo->tbo.bdev)) {
> -			pr_err("Queue memory allocated to wrong device\n");
> -			err = -EINVAL;
> -			goto err_wptr_map_gart;
> -		}
> -
> -		err = amdgpu_amdkfd_map_gtt_bo_to_gart(wptr_bo);
> -		if (err) {
> -			pr_err("Failed to map wptr bo to GART\n");
> -			goto err_wptr_map_gart;
> -		}
> +	err = kfd_queue_acquire_buffers(pdd, &q_properties);
> +	if (err) {
> +		pr_debug("failed to acquire user queue buffers\n");
> +		goto err_acquire_queue_buf;
>   	}
>   
>   	pr_debug("Creating queue for PASID 0x%x on gpu 0x%x\n",
>   			p->pasid,
>   			dev->id);
>   
> -	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id, wptr_bo,
> +	err = pqm_create_queue(&p->pqm, dev, filep, &q_properties, &queue_id,
>   			NULL, NULL, NULL, &doorbell_offset_in_process);
>   	if (err != 0)
>   		goto err_create_queue;
> @@ -422,9 +385,8 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   	return 0;
>   
>   err_create_queue:
> -	if (wptr_bo)
> -		amdgpu_amdkfd_free_gtt_mem(dev->adev, (void **)&wptr_bo);
> -err_wptr_map_gart:
> +	kfd_queue_release_buffers(pdd, &q_properties);
> +err_acquire_queue_buf:
>   err_bind_process:
>   err_pdd:
>   	mutex_unlock(&p->mutex);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 420444eb8e98..fdc76c24b2e7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -208,10 +208,8 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	queue_input.mqd_addr = q->gart_mqd_addr;
>   	queue_input.wptr_addr = (uint64_t)q->properties.write_ptr;
>   
> -	if (q->wptr_bo) {
> -		wptr_addr_off = (uint64_t)q->properties.write_ptr & (PAGE_SIZE - 1);
> -		queue_input.wptr_mc_addr = amdgpu_bo_gpu_offset(q->wptr_bo) + wptr_addr_off;
> -	}
> +	wptr_addr_off = (uint64_t)q->properties.write_ptr & (PAGE_SIZE - 1);
> +	queue_input.wptr_mc_addr = amdgpu_bo_gpu_offset(q->properties.wptr_bo) + wptr_addr_off;
>   
>   	queue_input.is_kfd_process = 1;
>   	queue_input.is_aql_queue = (q->properties.format == KFD_QUEUE_FORMAT_AQL);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 2b3ec92981e8..c98ff548313c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -494,8 +494,8 @@ struct queue_properties {
>   	uint64_t  queue_size;
>   	uint32_t priority;
>   	uint32_t queue_percent;
> -	uint32_t *read_ptr;
> -	uint32_t *write_ptr;
> +	void __user *read_ptr;
> +	void __user *write_ptr;
>   	void __iomem *doorbell_ptr;
>   	uint32_t doorbell_off;
>   	bool is_interop;
> @@ -522,6 +522,9 @@ struct queue_properties {
>   	uint64_t tba_addr;
>   	uint64_t tma_addr;
>   	uint64_t exception_status;
> +
> +	struct amdgpu_bo *wptr_bo_gart;
> +	struct amdgpu_bo *wptr_bo;
>   };
>   
>   #define QUEUE_IS_ACTIVE(q) ((q).queue_size > 0 &&	\
> @@ -603,8 +606,6 @@ struct queue {
>   	void *gang_ctx_bo;
>   	uint64_t gang_ctx_gpu_addr;
>   	void *gang_ctx_cpu_ptr;
> -
> -	struct amdgpu_bo *wptr_bo;

If the wptr_bo_gart is GART-mapped and freed in the same place as the 
gang_ctx_bo, then maybe it makes sense to keep the two together in this 
structure. It also avoids having two different reference to the same BO 
in the same queue_properties structure above.

Other than that, this patch looks good to me.

Regards,
   Felix


>   };
>   
>   enum KFD_MQD_TYPE {
> @@ -1284,6 +1285,10 @@ int init_queue(struct queue **q, const struct queue_properties *properties);
>   void uninit_queue(struct queue *q);
>   void print_queue_properties(struct queue_properties *q);
>   void print_queue(struct queue *q);
> +int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_bo **pbo,
> +			 u64 expected_size);
> +int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
> +int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
>   
>   struct mqd_manager *mqd_manager_init_cik(enum KFD_MQD_TYPE type,
>   		struct kfd_node *dev);
> @@ -1320,7 +1325,6 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   			    struct file *f,
>   			    struct queue_properties *properties,
>   			    unsigned int *qid,
> -			    struct amdgpu_bo *wptr_bo,
>   			    const struct kfd_criu_queue_priv_data *q_data,
>   			    const void *restore_mqd,
>   			    const void *restore_ctl_stack,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 36f0460cbffe..8552400d6d47 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -205,18 +205,21 @@ static void pqm_clean_queue_resource(struct process_queue_manager *pqm,
>   
>   	if (dev->kfd->shared_resources.enable_mes) {
>   		amdgpu_amdkfd_free_gtt_mem(dev->adev, &pqn->q->gang_ctx_bo);
> -		if (pqn->q->wptr_bo)
> -			amdgpu_amdkfd_free_gtt_mem(dev->adev, (void **)&pqn->q->wptr_bo);
> +		amdgpu_amdkfd_free_gtt_mem(dev->adev, (void **)&pqn->q->properties.wptr_bo_gart);
>   	}
>   }
>   
>   void pqm_uninit(struct process_queue_manager *pqm)
>   {
>   	struct process_queue_node *pqn, *next;
> +	struct kfd_process_device *pdd;
>   
>   	list_for_each_entry_safe(pqn, next, &pqm->queues, process_queue_list) {
> -		if (pqn->q)
> +		if (pqn->q) {
> +			pdd = kfd_get_process_device_data(pqn->q->device, pqm->process);
> +			kfd_queue_release_buffers(pdd, &pqn->q->properties);
>   			pqm_clean_queue_resource(pqm, pqn);
> +		}
>   
>   		kfd_procfs_del_queue(pqn->q);
>   		uninit_queue(pqn->q);
> @@ -231,8 +234,7 @@ void pqm_uninit(struct process_queue_manager *pqm)
>   static int init_user_queue(struct process_queue_manager *pqm,
>   				struct kfd_node *dev, struct queue **q,
>   				struct queue_properties *q_properties,
> -				struct file *f, struct amdgpu_bo *wptr_bo,
> -				unsigned int qid)
> +				struct file *f, unsigned int qid)
>   {
>   	int retval;
>   
> @@ -263,12 +265,32 @@ static int init_user_queue(struct process_queue_manager *pqm,
>   			goto cleanup;
>   		}
>   		memset((*q)->gang_ctx_cpu_ptr, 0, AMDGPU_MES_GANG_CTX_SIZE);
> -		(*q)->wptr_bo = wptr_bo;
> +
> +		/* Starting with GFX11, wptr BOs must be mapped to GART for MES to determine work
> +		 * on unmapped queues for usermode queue oversubscription (no aggregated doorbell)
> +		 */
> +		if (((dev->adev->mes.sched_version & AMDGPU_MES_API_VERSION_MASK)
> +		    >> AMDGPU_MES_API_VERSION_SHIFT) >= 2) {
> +			if (dev->adev != amdgpu_ttm_adev(q_properties->wptr_bo->tbo.bdev)) {
> +				pr_err("Queue memory allocated to wrong device\n");
> +				retval = -EINVAL;
> +				goto free_gang_ctx_bo;
> +			}
> +
> +			retval = amdgpu_amdkfd_map_gtt_bo_to_gart(q_properties->wptr_bo,
> +								  &(*q)->properties.wptr_bo_gart);
> +			if (retval) {
> +				pr_err("Failed to map wptr bo to GART\n");
> +				goto free_gang_ctx_bo;
> +			}
> +		}
>   	}
>   
>   	pr_debug("PQM After init queue");
>   	return 0;
>   
> +free_gang_ctx_bo:
> +	amdgpu_amdkfd_free_gtt_mem(dev->adev, (*q)->gang_ctx_bo);
>   cleanup:
>   	uninit_queue(*q);
>   	*q = NULL;
> @@ -280,7 +302,6 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   			    struct file *f,
>   			    struct queue_properties *properties,
>   			    unsigned int *qid,
> -			    struct amdgpu_bo *wptr_bo,
>   			    const struct kfd_criu_queue_priv_data *q_data,
>   			    const void *restore_mqd,
>   			    const void *restore_ctl_stack,
> @@ -351,7 +372,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   		 * allocate_sdma_queue() in create_queue() has the
>   		 * corresponding check logic.
>   		 */
> -		retval = init_user_queue(pqm, dev, &q, properties, f, wptr_bo, *qid);
> +		retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
>   		if (retval != 0)
>   			goto err_create_queue;
>   		pqn->q = q;
> @@ -372,7 +393,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   			goto err_create_queue;
>   		}
>   
> -		retval = init_user_queue(pqm, dev, &q, properties, f, wptr_bo, *qid);
> +		retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
>   		if (retval != 0)
>   			goto err_create_queue;
>   		pqn->q = q;
> @@ -490,6 +511,10 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
>   	}
>   
>   	if (pqn->q) {
> +		retval = kfd_queue_release_buffers(pdd, &pqn->q->properties);
> +		if (retval)
> +			goto err_destroy_queue;
> +
>   		kfd_procfs_del_queue(pqn->q);
>   		dqm = pqn->q->device->dqm;
>   		retval = dqm->ops.destroy_queue(dqm, &pdd->qpd, pqn->q);
> @@ -971,7 +996,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>   
>   	print_queue_properties(&qp);
>   
> -	ret = pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp, &queue_id, NULL, q_data, mqd, ctl_stack,
> +	ret = pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp, &queue_id, q_data, mqd, ctl_stack,
>   				NULL);
>   	if (ret) {
>   		pr_err("Failed to create new queue err:%d\n", ret);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> index 0f6992b1895c..b4529ec298a9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -82,3 +82,60 @@ void uninit_queue(struct queue *q)
>   {
>   	kfree(q);
>   }
> +
> +int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_bo **pbo,
> +			 u64 expected_size)
> +{
> +	struct amdgpu_bo_va_mapping *mapping;
> +	u64 user_addr;
> +	u64 size;
> +
> +	user_addr = (u64)addr >> AMDGPU_GPU_PAGE_SHIFT;
> +	size = expected_size >> AMDGPU_GPU_PAGE_SHIFT;
> +
> +	mapping = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
> +	if (!mapping)
> +		goto out_err;
> +
> +	if (user_addr != mapping->start || user_addr + size - 1 != mapping->last) {
> +		pr_debug("expected size 0x%llx not equal to mapping addr 0x%llx size 0x%llx\n",
> +			expected_size, mapping->start << AMDGPU_GPU_PAGE_SHIFT,
> +			(mapping->last - mapping->start + 1) << AMDGPU_GPU_PAGE_SHIFT);
> +		goto out_err;
> +	}
> +
> +	*pbo = amdgpu_bo_ref(mapping->bo_va->base.bo);
> +	return 0;
> +
> +out_err:
> +	*pbo = NULL;
> +	return -EINVAL;
> +}
> +
> +int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
> +{
> +	struct amdgpu_vm *vm;
> +	int err;
> +
> +	vm = drm_priv_to_vm(pdd->drm_priv);
> +	err = amdgpu_bo_reserve(vm->root.bo, false);
> +	if (err)
> +		return err;
> +
> +	err = kfd_queue_buffer_get(vm, properties->write_ptr, &properties->wptr_bo, PAGE_SIZE);
> +	if (err)
> +		goto out_unreserve;
> +
> +	amdgpu_bo_unreserve(vm->root.bo);
> +	return 0;
> +
> +out_unreserve:
> +	amdgpu_bo_unreserve(vm->root.bo);
> +	return err;
> +}
> +
> +int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
> +{
> +	amdgpu_bo_unref(&properties->wptr_bo);
> +	return 0;
> +}
