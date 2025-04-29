Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10A4C369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 14:13:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57C8D10E4A6;
	Tue, 29 Apr 2025 14:13:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mHAsLVaP";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6583010E4A6
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 14:13:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLHIufftsvChjiYwmtMR5rxq5RM26BDMXNai2Iq68SlQbhEuS5Azpzqx8tAlz3QvEeBiAmJYA8pU+92H2pi7Xy/GPzisRQJrwlKZvSMXHS7yB+emgPbUKMXQzscGcUzMg0fI1d0oCCl495y2jpMUMCuKupQXIJn8vGimOciilbaPKi61d577ebbgXUKJ1lAgXo+r6CcR/Z2twPhcLK9Hsbcr/K2lf0ClDltT7pvEuRO/Vgijub9/Y4N7ooJnPxpQ7adKiAZC6kA8nIx5XIR4wxdMvg623Z/ouQz5k4QbV9+t+24CAmfJkX4rE9VRxFj9DlfhwWYgb8BRjUSydzEILg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCejIQoZWAE31lgv4HLlwBhF398tPbkpzW1Jjnb+j5o=;
 b=N2mgMCBzLqIDQyveEA2cBFjOPv1F7b+fzjbzwdkwL3t4nP2tTJBfQJRgbDY/r5lC90RcDAvGATD72qv81i6Z741BexjQWCFp2WZ+DkhDigqzvvyk/L2O9VPQgBXwYSDY+Ug7KtHe/cE/jzq7wFcOzlYhxYJMlE6fZjzpqE0Ajs/nHmfFK3bLEmxc7pyN9830Nd+tuDPvjgXpfJRnIqooC8hJDt1WbiW/KMpwB+0MdgcXAOzi/LVCIVu1L7WImNigpwNlA/SjR0qQt/OaMVY2Ab4+7n4vNavjET/NZuu4LfGBVHgjqYb/8jxQ/UPewxcJlZDAr5QqaEuie0px7RKmDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCejIQoZWAE31lgv4HLlwBhF398tPbkpzW1Jjnb+j5o=;
 b=mHAsLVaPHcg24oHhCk8M+KYJiWDCCXYBfqj+tacC1quidVQxrGvLSFeyR/X67Axxc4MOUjAANGwTrCXKJFOH3ajuKxSXJu5cYTLpBGv0FeITPLToh9jXiSNhpJpOOvYjP4Yjqi//McLKLfN967enkMJFybDxw3rp3iEbbARw8wc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB7568.namprd12.prod.outlook.com (2603:10b6:208:42c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 14:13:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 14:13:20 +0000
Message-ID: <67f22149-ff0d-492d-b6f2-cd5efd7ec251@amd.com>
Date: Tue, 29 Apr 2025 16:13:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: validate the eviction fence attach/detach
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250425070730.4033803-1-Prike.Liang@amd.com>
 <20250425070730.4033803-3-Prike.Liang@amd.com>
 <79b1950d-436e-40bf-a9f1-1bc1974f42e0@amd.com>
 <DS7PR12MB60053400E90B33F0CC727DFDFB802@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB60053400E90B33F0CC727DFDFB802@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0295.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: f948ae4c-7c5f-4bf4-547a-08dd8727fe7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHYzYWNhYm9JM1U2VUJjbXV6YksrOXJnRlRjQVUxS3oybEUzUW1ITy9QdG5y?=
 =?utf-8?B?eFNsUlJYdDhEMFlPYUVjS0Nidm9pWllMS0NlVUZhSS9ySG54R2FHUXY4a2pk?=
 =?utf-8?B?WmoyMm51NFpsTlk5Q2JjbTdGWFYxeWdVbFFQRjNCc3ZRMGlFS0F2bW54ekpC?=
 =?utf-8?B?bVA3UEI2bGdMQytRSVRCMUtLV3lYSUo2MTEzeTlJbk9sQnBBbUZZMDNzRUlo?=
 =?utf-8?B?OE1LS0EySXp0WVRXWmpVZmxRZFQvaXRRdVUyNlJBWUVtbmZ3b2VlNnZLVG9k?=
 =?utf-8?B?ZGtPNGYyZXRmV1N1WmJRclFVVVFSYStCek9abk94NlhrWFJSTGdOb3N0OE9v?=
 =?utf-8?B?UldVYi9sRWlZMllQVzNUangwT0NTVVFwTmJ6b3B6TlpMQU9GY1hDbWp0NGtQ?=
 =?utf-8?B?T2h4bG5SVDJuUzRMTWVuNEU0dTBFaFlvS3dKNkVVWTJwaVBCZllIS2pIcnpt?=
 =?utf-8?B?a1M0T24zN29HUGZkUVFUa0VvamlyWU9xeWZIczBKSmMvSlB0dTN0U0dUMWhm?=
 =?utf-8?B?dEpISXUrQzNVVzJYeERnbGhkdE42aVczZ2ZyWHNreXJieFJWbUptemg3RDdw?=
 =?utf-8?B?c1lid213d2ZiL0xSSUFmWUlicnFkTHRLNU5UYVVFeEw0NEFkK3NjUUY5QzYx?=
 =?utf-8?B?dzY0T010blJMejM5SFdWVDJjR0hhV1kzQnltUlpuU1F6SnVobTlrZ1NocGZI?=
 =?utf-8?B?THh4MXJUeTMzZW9LWHdacklkZEc5K1RFMEVZcjNxLzVRcWVMaUZOOWRzYXZE?=
 =?utf-8?B?QmJSd2RROHJTakgvNGdObm1rOTNlMlpLUFdVZGdrakZPNlZCTTRCOXpRZFJD?=
 =?utf-8?B?WFlUNWxEWDh0S3YyWnBkVE9GK01qcGw4cFFhRjQ3VElpa1orOFBDV3V4dnB3?=
 =?utf-8?B?b09UWExpZUMxdXNJQXRlVTRGbXZVSTNOWTZpQzhzRnAwWk9kUk1VN0Q1QzRV?=
 =?utf-8?B?Vy9JYXdLby9yZFlyakorZVBBZFVPaHltRWFYUEdYQTZkbFpyU3VLOGdUbkd1?=
 =?utf-8?B?bWp3Ym1uSGI0OXNoSkpZMXE0c09IUWhBTVlySTMyeHNTRmVuVXpBYy9UMk92?=
 =?utf-8?B?ZUNnSEhQSTlOTldCUVFUdmxrVU94c2NBYTBLSnRjS0NOSExvQ0lNM2tqQU90?=
 =?utf-8?B?SVJMTHJmWDU4UEJsUmtlc3VyVEYrRzdRTGx4Q1RRaEFDcHpMQXppKzI4YVBs?=
 =?utf-8?B?TjBFeFM3VjB1cWlrTW5zTDlRTkNLekR2MU1oek93OWxqelRTeHV3MTFWWGgv?=
 =?utf-8?B?RDdpa0xxMHBHRmk3eEZwSE84WHYyZ3IycHRpbHNIS0NINlc2S0I1SmJabmE0?=
 =?utf-8?B?SUxKcUpmMEk0cGRKT2lVRjFLaWd0bDN6L20wS2lJZUdMdHlWNWppTnZCV0tk?=
 =?utf-8?B?dm1LU1Nuekt4UmtmL09SNEFub3Y2V3E4WWgrTTVUQXpNMG9IZkF4alVLYU5I?=
 =?utf-8?B?M2ZFK2VNYStyT0h0eXFLYjcxNzVmMm04SmFJbkFoSlp5WFI5K01VempjRGJF?=
 =?utf-8?B?clludzBtdkpyTVFpN3ZYcTNyTkFUdHppSVpvL1dYSXZxNWdtdGNxSXZsdGdY?=
 =?utf-8?B?YjV5bFRsVlY0bUF3Um5sQ2FadnVKWXRxOGkyc0owaG5BOSsvOWZEWHNYQjFk?=
 =?utf-8?B?TkFIOVJpUVhSSi9PTGhDSEFVMVc5KyswVWsyY2tNQ0JmazJrcEpzZms0Ti83?=
 =?utf-8?B?S01xUUM3VG91MitUanNwcFRPVitTQ3ZxdFpqV2N6czd3Vk9RYm1vYmh6YXlR?=
 =?utf-8?B?ZVBPdktoaXFpRlcrK0VJUmhiMy9kMHBab3gyYjJVK05yYWNWK1BtODczanNR?=
 =?utf-8?B?NUtGTHdLMTlyblYzWlFjQWU5T0JlUzBWczlOQzZITVdwYi9kKzluV1J6K2dx?=
 =?utf-8?B?YUdBaERGTkRqVFlVU2l2WVkwa0oxbXo0MEJxS3Z1OXdISzR1MXc3VFNyMytY?=
 =?utf-8?Q?N82NYKaIBVs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emdzemZ6OG9XcDMyWWVlRFRQTno4ZzV2UUQxV2hzL080Y08yQTZxL1ZmL3ZH?=
 =?utf-8?B?dklnaW5FM2ZEZHdiUGhZZDQ1UU1CUm9mRGpZV2pIRUVXeGM4bVROc1ZvNm4y?=
 =?utf-8?B?VUdheXJ6NUo3R0RWTHBGcEZOb2RMNGorMUdMQXZoN1Boblhkd3hKMGswSHph?=
 =?utf-8?B?ZlBvZW91U1ZzTi9Na2VaUXViWXVBd01sUFRoN0dCOG51OUUzbTJjcExqS2N1?=
 =?utf-8?B?R0QrWnQ0UTIzc0hSQmdKVUhBNkdFbDdsUW43Z21aTmJvZUFXb1dWcGRpbXZj?=
 =?utf-8?B?c25vZVBQc05VL1pOS3Q4UWx4RmRzWDhhRC9vSmdnLzlveWJFaE15b0lvcjhn?=
 =?utf-8?B?dDc4aytjVUJPOEtENkNQelJoWmFQNmFnRVFoQ1JlbHhtTFQxOGkzWmFGYTNw?=
 =?utf-8?B?M09ybS9mVTV3NHFNbm9TNzBUSWExSDJsdUZIdkdEdGsyRm1JbUswcGt2aG93?=
 =?utf-8?B?WGtZMGtmOUZSVkZXV0F3VVhkWGJUdmp4MDRkdng0bkxNSXFwT0JkMDYra1Fz?=
 =?utf-8?B?Y0RhdDR4OHpEd1piT1lteUorY2ZWVlNJR3BNTUJRVkFTVjNoakhpN0xKU1Zw?=
 =?utf-8?B?MVVBaGlVS0cxNVRiUHc5a29OQjk0UDFXZFkxQlBvVm5nVDZ0S21JUUNYTGFD?=
 =?utf-8?B?YnFSOHgyUVhLM1Z4WEhxS2dwcXBTaUZ5aEFmSkZhNXlEb1YrWVhmN01iVUxt?=
 =?utf-8?B?S1ZENlV6VU5PVEVCTlRSamRURjhicUM1VTJjNUQ4TkZaWjJMNWJxekE1aEZu?=
 =?utf-8?B?MUZ3SE9reWVWSVEwRk90TS9jVk4ySWJabVBucElzRDRDRFRMdEIyRW5qTjND?=
 =?utf-8?B?dGlNTXoyS1dkd3ZCVDJXYUNIeHZlTm95dW1xY0dJcUZxMmlKbkNCRUttMGJn?=
 =?utf-8?B?dHRHYW5YRTBkQk92RU1uZkpiVmYxeCtlT1cxeXZUaXJoaXVFNEdQZE1PcVRo?=
 =?utf-8?B?U2VKbzIxTzZwVXlJTys3RTczWkRyODArN3NxZmRkQWdhSXJFTHJldHZkQ29R?=
 =?utf-8?B?S3krSlFvQU5qN2tVY2JSMjZsaC9jQmJKUm1Bb2VCeDNyMzZ1eDZFRk9RdHdT?=
 =?utf-8?B?M2hYdkpDSTQ3SnVQeGkzVUplSTdJL2dzTUlDckxhR0dBd0dDcStKOGdza29O?=
 =?utf-8?B?aEJ5T1pKOVNpMHpTYUZESzlIQVhxWU5vUnJNL0gzK29FelRKcW8zSmhyNDY5?=
 =?utf-8?B?WmhhZldrQlM0RG1aMGFweDlldkIveWYrR3V5dEVIeENSeGN2RHFheTZVRWFU?=
 =?utf-8?B?M3ZJb2dEQ291RjhKclBnbUVWWmlHR1NiOUlVTHlqYUFXZWF0WmZZK29pUG4z?=
 =?utf-8?B?SldZU01MbllUczE3cWJpZEZ3Nk9odGZFeVNZaXJNNVpVZnMvazZZUDRmeDZS?=
 =?utf-8?B?MHFRZjRGclVpMlgzaHNwUGkxb2FaTFJtNVNJQnBWYmhUL2YvSUU5UEtHV1JN?=
 =?utf-8?B?TlNmbnRoeVErZGJ3enBkdC9HRTBJOTNRNEgrVXRycmNtRVh5bjZsbGJ6c0Vo?=
 =?utf-8?B?Wi9UVXhyTHEvU3p6eHY2UDdSMWJKbDFYaU5rMTFtSlBZendGaCs4a1RpT3N6?=
 =?utf-8?B?dlhtVSs2eEdkZzFhMXBmUVN3eWlxZGZTK2U3d2ZtWURVSTBOMG15Sng1NCtZ?=
 =?utf-8?B?eStiaEloNm1qNGlacllzczFoL1pnQlJURDJJaW4rYyt4OHpjWnZQUWJndU1C?=
 =?utf-8?B?TStaK2N4R1ArakYyUUJGU1lZVkJtOVFXZmw2enptZ3oyYWdXSmkwWU5pV1U1?=
 =?utf-8?B?alJDc200QUEzVUZUQkw5Wm5leVlKRWZhK1FTa0QzQUhiRGQxQ3FtQlViYkpw?=
 =?utf-8?B?VjZWdFNmL1JhS2NjWUVDbkJpQXJsczdUVG1hY3czcGZRN2w0VUlRVFNzOWJC?=
 =?utf-8?B?bVNtOUo0VVZGUTlrSVVPYnVISzRTVEpKR3hRak1BOXk4QTV5OGxYdmxwQVlP?=
 =?utf-8?B?eWVPbFpNSzNWaXkyVG5xUXFvNDhJVHoxRkZneFhxVDE1Vk9TK1ZQc0J4eG1z?=
 =?utf-8?B?WmpmaDVzZGhmVnFqd0NNYW13a25ndVNyblVPWDZpVk5iMUJIQTRhOWJGRllC?=
 =?utf-8?B?WTNHVWRDOExLUzhhT2lRL2JMci9TRG5LTUJWYTRCeFFBQWEwMC9MVlNhT24x?=
 =?utf-8?Q?7kO7Dq/NGtoHUsgqsRVVFb5qU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f948ae4c-7c5f-4bf4-547a-08dd8727fe7d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 14:13:20.2877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7fS/uj0sCMrSmE2S45S/6kVKOuev4pMN0mveHt4Szs9NOsJ1KR42mzdLsDI5YSNi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7568
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

On 4/29/25 11:12, Liang, Prike wrote:
>>> +   if (!IS_ERR_OR_NULL(fpriv->evf_mgr.ev_fence)) {
>>
>> Please don't use ERR_PTR functions on members.
>>
>>> +           r = amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo);
>>> +           if (r) {
>>> +                   DRM_DEBUG_DRIVER("Failed to attach eviction fence to
>> BO\n");
>>> +                   amdgpu_bo_unreserve(abo);
>>> +                   return r;
>>> +           }
>>
>> We should always have a stub fence in fpriv->evf_mgr.ev_fence, so those checks
>> are unnecessary.
> I checked that when enabling the kq and uq at the same time, and before schedule any user queue task then the eviction fence is NULL.

Yeah, but that case is handled by amdgpu_eviction_fence_attach() and *NOT* here.

You are completely messing up the logic with that stuff here.

Regards,
Christian.


> Based on the current design, the eviction fence only be created at the user queue BOs restored time.
> 
>> Regards,
>> Christian.
>>
>>>     }
>>>
>>>     amdgpu_bo_unreserve(abo);
>>> @@ -362,7 +365,8 @@ static void amdgpu_gem_object_close(struct
>> drm_gem_object *obj,
>>>                     goto out_unlock;
>>>     }
>>>
>>> -   if (!amdgpu_vm_is_bo_always_valid(vm, bo))
>>> +   if (!amdgpu_vm_is_bo_always_valid(vm, bo) &&
>>> +                   !IS_ERR_OR_NULL(fpriv->evf_mgr.ev_fence))
>>>             amdgpu_eviction_fence_detach(&fpriv->evf_mgr, bo);
>>>
>>>     bo_va = amdgpu_vm_bo_find(vm, bo);
> 

