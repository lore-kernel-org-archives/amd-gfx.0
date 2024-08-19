Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE073C3DA4A
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Aug 2024 12:43:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62ED810E25D;
	Mon, 19 Aug 2024 12:43:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hh+r+1Hw";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDDBA10E25D
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 12:43:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YB09K/yK3qg63uAeIBuXfnvYyAfTfouRldOWjZaetZ0UrzLhHKikmMTgh61lDPGya5SaXt9MnkuRYjLmGW9Q878kXdusmrYJ4cZ12oIY5KKqc/UgkPvkH+CxRqvnnOWiX2odR91qwVMF6k9OJD0kzdVIKv8DBh4nl7BEjUBAoIwVl/KuF0yEezEnjEcmJPTz6QTCnfWXNFAfezXQORIYEnTbjjjYUEQwAIGZqre2xbNIcMhg2q3LNjra9dbeVRQFNjtMFLdOgRSi1f8k3CO+BN2wBCxKj2xI4WxX86dW8iXJRK/BTXChdoI+twHfVgal0KJrg07hKeM8DUTLvzP2YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPlFB26kOS+f3735grjPBtaSlQWzPp4oLDrSjFf1QZ0=;
 b=FkXcnD/hAL18Ja7e3fimKDCKf1uVtAsnweSObQzoTULgeoxldS/jUzOJaYPb2V+pbU4lL4LfNWwmGPxBP44F0ebbiLSD/icw1rmqzvfvfVoPLabYOgM1iME1CAECyZpNK4PkJqEymLXY3SfUrhM/nzzns8uBq9M9JhTGwAWUOxgJudrcukSP27llVkDkr6LhRqJL7k3eXAXBw+WtdKY8QmegFEtV7HrCcrAKZVntMXnFb+ZmiPRRhl2SCxoyFPyA7jYPyhkuwgFm7049z6t6dIoSLUoTyDGhwNSAeLnQvJj1EzMpbHXpp4+SGq4CyaIdTSRxaSW2qtvDzzje95hZrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPlFB26kOS+f3735grjPBtaSlQWzPp4oLDrSjFf1QZ0=;
 b=Hh+r+1HwJdtevAjx0LE99pAok3mq0cKyfsRyXPTqkLBra7iDfeFJ1pO9IEb2qw0z/CkjtwYvVpdjCQD5gYKxaKmVxFn7e0iEqwB0QwNdkQGUFhKaY6EVkGs5jn4M4pJMwVJE5V4J5nd3pUCMXwV/43y3PbKOwuObgueq7ZWFEXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by MW6PR12MB8760.namprd12.prod.outlook.com (2603:10b6:303:23a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 12:43:36 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 12:43:35 +0000
Message-ID: <a782805f-c7c0-4084-a406-7ead10c6eab3@amd.com>
Date: Mon, 19 Aug 2024 18:13:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add DCC GFX12 flag to enable address alignment
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com, frank.min@amd.com
References: <20240805140125.549000-1-Arunpravin.PaneerSelvam@amd.com>
 <0f5d4a46-9f27-40c3-9b55-1f139240c964@gmail.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <0f5d4a46-9f27-40c3-9b55-1f139240c964@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0171.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::14) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|MW6PR12MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d5ea55b-da01-4a98-e0df-08dcc04c8a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?clFILzZtcHAvRjBqeVZWSFBHUDRnODRXWjJnbHZVaC9kbXkzczU4cCtXNEVW?=
 =?utf-8?B?RHRBQVlLSVY4TmRBWmlOZTdYSHVRQUxBcld0RmdYcE10OUxWMDVpTi9meTBF?=
 =?utf-8?B?T1NzQi9uUW9ONzRxSkI4MjFIb0VOM2tZc1MweTJyYWRVZXlRVVV4RW9ENTdP?=
 =?utf-8?B?bVl0U2RvNGV6a1R1ajJGZGV3eVFUVWxzWTJ0NUIzbVNWemNLK0dGWXFyMWto?=
 =?utf-8?B?aW00MitWeWdiQ0lKL0xEa0Z5TnVRMTJZbWNzc3lXZDNMUm4vSm5mVUViSElx?=
 =?utf-8?B?WnNoY2FVYnFkUEVSek5JSDNCMzZSVlpEM0NJL0RZTHRPZzQ0RjhQVmlxaUI1?=
 =?utf-8?B?dmF0dk5mQlVGRllEbjRmaTV0dnFORzFkdzl3dmt3Q3BTS3FhMm9hNUNxWWU3?=
 =?utf-8?B?UHVCaU9HaXJWVitLMUx5T2ovMnNoRWxnc0ZwL3BTaFI0UVRkMlgzMXhsaVo4?=
 =?utf-8?B?WEduMzRSL1JUSGhLMGF5VlI3Q0NkeE9YK29yaFE2amY2MHpVQm9XZDdTcVFF?=
 =?utf-8?B?dzhDc20vUDJtSHhJRW5sNzVtaldnMm1qeXhSZjBST2QycDNSL0p2SjdUb1lU?=
 =?utf-8?B?SzNzczQ3K3VVOHVCQ2RPbSs2ckdZTC8xaTNESGx0SzVvV3gxSDZyVUZWb1pF?=
 =?utf-8?B?Njlzc0Qybk1MTFZWSkIvWEtFMDQyK0RNYmx4MVFic01qQ3NyQnF0MGgyeE90?=
 =?utf-8?B?ZzY5Y2pza0xXRkVXR2pneHpxSjRxclBOazVSMTBVQ0xNQlhOVmhyVk9CZDVi?=
 =?utf-8?B?NHRMWDQwMUlUVUFlZld6bjVrRVc0UVZ2TGpIK09QdGRZMmpIQnNqMENycHV5?=
 =?utf-8?B?MUhzN0loSjNpYitFSFhudXJvL0s1SjB1bjZ0ZktRa0IyUmVLdWdPS0pxUFJT?=
 =?utf-8?B?ejJNRVlCMDlDeXE1ZnhkOExwTkJFWnVTc255ZUpIODhjSTFDNkFSQktsbmpo?=
 =?utf-8?B?cU1DTjMyWnYzSldYZWVTSmljM2dvYm9FT09oZ2d1Q250d2kyYnc2dm1OMFR5?=
 =?utf-8?B?ZW03ajZHNjMwV253bldVOXU0T2RjZ0ZzTjV1VUdoWHZIZTZWSEZGN2p3b1Uz?=
 =?utf-8?B?TDZPODVBNlE3NXFBR0JEZkE3VjZRTHNuL25yYkZvbHhHUGhuYmRFTkVXYlFR?=
 =?utf-8?B?THNEck1pMVd1cEs1NkNtWld2RlpqRTcvVE1Wb1QvWnlvdmtVZEtaYm1OOTd4?=
 =?utf-8?B?d3Q1Q0pVMEJHbFE5OC9kQzl5M1YzL3hTWkJua3FmcXhKVDQrOVEyN01kOExY?=
 =?utf-8?B?UnNsZGgrN1BhR2ZtZVR6WTkrS1ZHL1loNnFXaFR6c05sMkpHOXZxTFpUa3Vy?=
 =?utf-8?B?QVVFeUEwa3cwRHdjTzNDcE1mcFZ3OHZSYjBBd1hCOWF5a2w3VmN6enZiNFd0?=
 =?utf-8?B?TDRCZWxHRFlMTHdjNzBidjRCNmMxTVpKbjVCaXpKZTZnOWRQenlidUNHSDVx?=
 =?utf-8?B?NTNPenQ5THNMRnRReEM0bW1uWk1oRVVkVjZkN0xTNk42SXY3d1JmaUYxd2Rr?=
 =?utf-8?B?dit0encvNVhFRmdXM3lQazl1TW5qalh3eFdCcTZtbHRpWGFkUFMycFZadzRl?=
 =?utf-8?B?Qm5HYTUvMkdaM2pYMjdGdjBzcmEzUFlFOWYyL00zazVYazVMeU5oK3BVK2ZM?=
 =?utf-8?B?aUxJV2dDS0V2dndvMFFVZkxVYzEzZzhZUjM2dVFyaU1KUU9iZHVIOEFrNEhN?=
 =?utf-8?B?ZzFGaW1udzZpYXljQnViVWtvcGZFMkFCU1VjN1VqNWpTZUlSWEVRQ293Nk5M?=
 =?utf-8?B?ZFBrZGJtQU83cjN6d2FXbk55RklJUXpZajc3TjZqOTNtWTlRL3plVDIyMGRW?=
 =?utf-8?B?WkVQQ3dOYnMrT3hTUDhxQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1VnVGhCT3BjZmphOERHbWtEWkw4TWEyNmUwRVpjK1hzZ253WDVIamV4SzdM?=
 =?utf-8?B?Ly84SW9GNVQvV2VmdmhIVUtvN0VoRVFwTDlRWDk5czdVV0tZc05BRmlqYUh0?=
 =?utf-8?B?b2tFZWI0S1UzWUpyeGVlU0dQODBHVE91WFlLeWtOcTM5cy9aSUViMUdGODNq?=
 =?utf-8?B?RU9ZRGxwV3BUc1U4ZzJkYkxrcnpvUzh3bUg5ajBOTy9MVEZnaHUzbXc3a3dD?=
 =?utf-8?B?QXhYb0tBK2tVcGtueStQNTR1Qkh0MUR0S20xU0lDajE2WDFzV1g4SjJwOXFB?=
 =?utf-8?B?VjFOSmRYVzJjZ1ZTd3pEejRsVEp2bkdMam1XaTVIVTlVMWR2b2MzdWI4RGN2?=
 =?utf-8?B?L04xWHdwK3g0YStFeGpzdEJIV3FITlh3bDNOWjl2S2ZHcmNvdHhDdG9ZUUc4?=
 =?utf-8?B?VkIrLzk2bjJjYXN6eVpPeHJ6WklLdnQ5VkZPRjNpVE1RNHBEUjhrdUFSZnBa?=
 =?utf-8?B?b1RpSDF5QlpUakNDeGNWSHBFOVRRMWQyWENSRTZnR3hhN1VVU09aeWQ3MHRR?=
 =?utf-8?B?eFdOREtLNHZTSHRBU0JUYkVndG5TS1U1Q3cwa01oS0JHaWh5TzlpTXhyZndL?=
 =?utf-8?B?TXNEQjNFUHlOV2h3NTZhN1FTV0o3Wm8zZXJoMENWaVEyeCtKSEV6dVR6YWpZ?=
 =?utf-8?B?VVJmcmJveWI4eFJmMGMvLzR2TW9iR2VoK2I0NEZHeVJianBpWkFDVFFDbHlL?=
 =?utf-8?B?c3JVSDRLdkpkS1ZHZWVxWGhoaENEL3JrLzUvSFJyQndEUVJoRlZFRkU5QlZB?=
 =?utf-8?B?Qk03cGFZeXZCS29ZZlNHUW02WU80WStvSnpWSnhZT3RJaGRzVEJ6bmhMWW9K?=
 =?utf-8?B?YlltQlpkeXJRYzJ2aG42eGZ3dFFhbjcvc3BraDNaL0NwT3NNZVpTaHN5QkxP?=
 =?utf-8?B?M0JyK25SMDVRRjNVcUVLSTMvS3JYQXZkbkFxKzAvMElxSDBPbXJPbUJqOVMr?=
 =?utf-8?B?TlVGZnNmaDRlYVA2L2JtT3EwL1UwU3REYis4aEt5YU5Cc3hXb2c0SVZ6RkNa?=
 =?utf-8?B?V0ZiWklXQ2tXbEY5UGRtK2srYjVybG9rb3BiVFZEQ3RMVGJpV014U3lwU25U?=
 =?utf-8?B?WEQyTVIwWUVMWHNVTzlnT2xiNENXcGZGUnVPaFRPL3oyalRBdmltSHJUdS9r?=
 =?utf-8?B?OXVQY0hlNExWZTFjekVXeUh5aFBna0JqVDFuLytmL21TL2hDaHovK0QreFRp?=
 =?utf-8?B?Q01yVGlhWGdIR0lMLzlGTHp5cWZ3dnB5Q0hBUGY3ODB3RG5RQ1k1eExxdENV?=
 =?utf-8?B?Z2p1NndoZjdWY2xsakh5dFkvL2hqOUh5N0RYUlZlTnA4V1dtbDYvVlhEaUg3?=
 =?utf-8?B?a0pITkdXMjRjTU9maWRqeGt6a2ZMY3RTSGJobk14djJIdkZYTnFKZWVzTkRu?=
 =?utf-8?B?UzhnTXd3djVTVGtrRHlsRWo3QTNySjIwWWdoSVUwQW5DMmdwOVBhVzFxMEN0?=
 =?utf-8?B?c0dHWWI0enl2eXVYWW5zMVg0OE5GN0dXNWhUOUVOTTcvbWdldExTRjFidmxu?=
 =?utf-8?B?ekNib1laYUIzN08vQTdVZDVsODU4QVo2YjVaeU04TCs2d0x3NUhSYXliZUZw?=
 =?utf-8?B?NDRacE9ST21CQlJzQVJVOE5iZEIvemhFcFhTTXdrTWwrTStPQWNGaFdrVU14?=
 =?utf-8?B?T0NXRmsvSlEvU01nQ3VOVUFNc04venpKQjA4bVdvSjkxMEYxMjZOSlFXV01a?=
 =?utf-8?B?Um9HckovZzBsRU41QlhMcVlHcjJydzlnVVFzbDRaK25GRG9kaFdET1lwbFAz?=
 =?utf-8?B?QUgvQS9aUjNtNVZlc2phdEM2b3VKZ1hzcU52ZDg2WHQyRlhSM2ZUR1RyQU5C?=
 =?utf-8?B?WFFBNWlwUHF6cEJBWUY3cDB0bFVNVkQxODFCSEt6VWZuZllkaGVXZkNGcUtM?=
 =?utf-8?B?TDZxb0N1aWtxU0pVbjFlMURNa3BnbUsyRldnc0JUeUEydTVSM2xVTC9hSlVU?=
 =?utf-8?B?QmtBenplRGFHOFR0NGVmNDltSWpkS2ZEUDNweWFrcTBxSElIMlRxc1B0cDJL?=
 =?utf-8?B?TTVXOVpvQzJKL1ZYMTBYVThKQzVOZGpFNGhaNnBVUVo1KzJrZHVaQ0d6azI1?=
 =?utf-8?B?MzZRSXIyMXFDVzJGY1puR2xRcTliSVFCTGcrYWxZQUNKd3VJRlBJMmdHMTZr?=
 =?utf-8?Q?glR+uE5LDaSvbLKSyWXIo5u5o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5ea55b-da01-4a98-e0df-08dcc04c8a84
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 12:43:35.9187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oW6tR9oFhODkLlFjyozmvoPUrnDlRcfvOj2ptBRYOM2muKVX/vvb+7siuAVDuN4eDmheI7R/CsxBFTPmfEGjFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8760
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

Hi Christian,

On 8/19/2024 1:59 PM, Christian König wrote:
> Am 05.08.24 um 16:01 schrieb Arunpravin Paneer Selvam:
>> We require this flag AMDGPU_GEM_CREATE_GFX12_DCC or any other
>> kernel level GFX12 DCC flag to differentiate the DCC buffers and other
>> pinned display buffers(which has TTM_PL_FLAG_CONTIGUOUS enabled).
>
> That's a pretty bad idea, the DCC flag is not the right approach to 
> differentiate this.
>
> What other pinned display buffers are you talking about? As far as I 
> can see that patch shouldn't be necessary in any way.

TMR is requesting pinned buffer enabling the TTM_PL_FLAG_CONTIGUOUS. For 
DCC size adjustment,
we will try to over-allocate for the TMR region and that leads to memory 
allocation failure.

Thanks,
Arun.
>
> Regards,
> Christian.
>
>>
>> If we use the TTM_PL_FLAG_CONTIGUOUS flag for DCC buffers, we may over
>> allocate for all the pinned display buffers unnecessarily that leads to
>> memory allocation failure.
>>
>> Signed-off-by: Arunpravin Paneer Selvam 
>> <Arunpravin.PaneerSelvam@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> index 5415a5cc7789..7de0ac07a060 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> @@ -509,7 +509,8 @@ static int amdgpu_vram_mgr_new(struct 
>> ttm_resource_manager *man,
>>           /* Allocate blocks in desired range */
>>           vres->flags |= DRM_BUDDY_RANGE_ALLOCATION;
>>   -    if (adev->gmc.gmc_funcs->get_dcc_alignment)
>> +    if (bo->flags & AMDGPU_GEM_CREATE_GFX12_DCC &&
>> +        adev->gmc.gmc_funcs->get_dcc_alignment)
>>           adjust_dcc_size = amdgpu_gmc_get_dcc_alignment(adev);
>>         remaining_size = (u64)vres->base.size;
>

