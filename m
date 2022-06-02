Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D38C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 18:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51B07113497;
	Thu,  2 Jun 2022 18:03:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 459EF113497
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 18:03:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZdqkcCa/5m945XMrsbdFOpAod0VkhYmSQBHR/13Ipzs0GwGT9UwoHQftL3KLfapK/d+dBkVCcolLBGQllaHpPeURlO7JiBNbsOXncXz1N4n93Wb5nytCD+4LflJUq/Os7J3ik6QNcCLzIG4wd7UXZkKWWVF12aIuDYxKmakFe8tSFWxRnIptl5AcscXezqcZuQBXV+hjwF0tr0OlGbO/LRoPSp2Im/l5+dDqLoGiPN8IrEk9m8gST9LLl+YqGL6NBFujXzQHyKfupAN3EEu+KX7r4Hka1V0cSHyydmJIKC8UPG78fNRAP01IlJiTsLmpi9d5oUlwU68Jd3Mw2zJyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SiuQl6s5a/OAG120I2FQDkGr5KhHtSkfus6NMp+ldE=;
 b=T1R5USqH5pW2wMQfsBlnoESWlHVxLvCU27K32TtReZeJY9+FOEQ7pRZPH5G5N1w3bmZGQYW0TiPKW5afyedQJsqobo8nEjg7QuXr8TG4bKZJLcWdf3uY4iaHhMr8GNB70bDa+42oQ/nAwyz0pmiFXKQlN57meH2NgCBkzKmvblVMr8fYP+IIx138JSzPPmtj75MtReJX+8jnVtmCaxplOC+kOPMUvyVyHfCpzzRjeVqp1VhoYxZhYdx83Y7w1fdyZbCyD8v/RXGjRM3X/Gr0EgUp6/fhWgZ/OrkEDsON8UKGgXb7JaTgUjuIk9OuILOg+5VDFywsN5UOYPWKk7/h/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SiuQl6s5a/OAG120I2FQDkGr5KhHtSkfus6NMp+ldE=;
 b=3u+P+dY488Tixqgzkly9B1CJ7sR1umG8tFpcmNiFyeZ2EA49tdYg+UFHknhHev4alGX4MJSaxt9F8VwKS2Ws26jgPgU7IZ++o5+URc0YYHncfJt9aHDDsILhaeqNkEkyYyUVhAtYdvbjL4uktnMy9OFQF8emMaS3Vn/+4iHdEVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN6PR12MB1652.namprd12.prod.outlook.com (2603:10b6:405:6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 18:03:14 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03%4]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 18:03:14 +0000
Message-ID: <f27f1a49-7ecd-ef6c-7886-eed078c4e752@amd.com>
Date: Thu, 2 Jun 2022 20:03:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu: Adjust logic around GTT size (v3)
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20220520150912.762831-1-alexander.deucher@amd.com>
 <CADnq5_OZ5e1hfA_6O1q=evs0RbVsH1xf8xybcarTMztZhdvEsg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_OZ5e1hfA_6O1q=evs0RbVsH1xf8xybcarTMztZhdvEsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P194CA0047.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::24) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b93f2d92-1400-4a43-b07b-08da44c22a15
X-MS-TrafficTypeDiagnostic: BN6PR12MB1652:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB165239E188835B33B652F33183DE9@BN6PR12MB1652.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JGwn4Iqzhf74//gaa0HhUt7D34FST8BytA95IoZDj/ARK623FoG6yN4Gxi4oA1E9ZLt+tv3FVjCSaB0wz6XheWw5vUPNiAV7l10mpM0Wsf1ZbkhT3MYTUvlo1qujqdJPQ2VIQ7fxwCOVucs4oW9h0cila8r+v9ssvmWmvQ4ZLRo9cYJaiix1Wp88U2RP8JHeoq8n7Ueb+faqlVJ+nRKLYdwO68dek9Zer9F8TQFpvrQ7toMFA5R/YrRQs9Ae6iyKcXtL3rP0oi+YYnJKoR9H8nFeYgstfqtltu0Fgls2mLRbFRHBdVJfrcec7lOSXd68bY20qx0TxkJAWkvCizPjDyoJEvIVHCYcqPNXWb+LCiEKt9vAiImY3LTgOJKV9/BQRJW0DyGc8RehChYG5qj8P+AxK4fFS90qAuX9Xo/Ps2c93k2ZCInJMhfdU5YrwQtToSr6wdjnAXi1ffma0To5vvHw94XUQa7fWk0Jsd7eNlvsZx8QuG9EOG9Wy5XPyk+JTDa8iDXTp5nTMFJX3n+YtEarptTwWT+Wq6mwfdZoOpoU68H67OWqwkUxb/BLPkqWREA9bLNUGsyv/eHxzIMd0DPsTXhF+Nl9wxedbyoRs2joXbr+0UsVzMUxwjIjasUb9zyjGGVu2tB6285YMXZFl+Tz2RHV1wcQdjpBGe7+EBJHnAC3KCZbv6YsrKfIwD+k0tVbQ3/kpi0YGwIf7R2Q/QpzOU0mxciIxEBiDoKID5E8mgo/bVU+ecWUyngBAeK3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(6636002)(2616005)(66946007)(66476007)(66556008)(8676002)(36756003)(6512007)(316002)(4326008)(38100700002)(31686004)(83380400001)(6666004)(186003)(2906002)(31696002)(5660300002)(86362001)(53546011)(8936002)(508600001)(110136005)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDNHcGJ2T3pPT0FNaEMvQmJ0Q0hUWm5mN28wS292VGdjRXFFWXRHV2htdUpu?=
 =?utf-8?B?eGhScnNYUU82TE0zUFBMV2xKcnlnSXE2d0FyZVRMRDNJQkQzcEM5Vzdkaysv?=
 =?utf-8?B?OWdWNHRQSDYwMVE3ejkyWG1KREl2WTNSekhNUWdMZHBvcHZFWGZoSzEwVVVN?=
 =?utf-8?B?dlk2UllrNTd2VDNIRkg5WTh2WmRsUnNjNC85bUtsdGZDMW8zNmZaUWJMUVlN?=
 =?utf-8?B?U0duOGhRdGZRUERNYUh3UlJmT3FOd1NBQXdPVW1rbDNWTDNQdTNmenlBTU9a?=
 =?utf-8?B?ZDlNbXN6Umh6Ty9ST3hoZm9pZzE4TURXcUFsL2hQVDRNNlVCcWpHK015dDhX?=
 =?utf-8?B?S3NZWmJMTUl0Qm1RQmRqV1lZNXNqby9IZHVVZkJhbXoxQktkNjc5RU1XeFVh?=
 =?utf-8?B?K2VrV2ora2EvZGJjR1ZFQWk0Tk1UNVJ6b29paVQzMG84eWI3M0JOK1ZqN2pa?=
 =?utf-8?B?R0FzcWcyTVVZeXdWTDdCSlhrSjRpSm9XYW1tZDZYU0RlWE41UmhPRTFWZHpG?=
 =?utf-8?B?OFJpZGRtVWpvTER4SXQxc3VSY0pPa1hKR2pYbS8xTjZjUFllMWxmaitWeit1?=
 =?utf-8?B?cWg3TmhEc3hiVU1PU1pVU1JmL1NWWk8wM1R6dWx5Uk1RUkNueGlpYW9TcWJy?=
 =?utf-8?B?eUtuN2hIZUtsU0ZVN256MW1sdG9RVjZ4cXFXeVVzQWU5Q2tHOHVaaEsxY24w?=
 =?utf-8?B?Z01WcUJKSnNqalZPdkp2NXZMM3VHb09NV25UeWsxcmRJNkNpWW5jTk4rQS8x?=
 =?utf-8?B?M2k4ckV2M3hmdkcxUDlQb1ZuUzBtSzBHbks2NnB5OTVISkQ0UGh2bFdvcjRE?=
 =?utf-8?B?Rmd5NEtMOXBqTlJ0dkFkVU9NTWJDa2l1SWdtTzF6Nk5FSFltWWlLRmR6R2xP?=
 =?utf-8?B?eGZsYWJPOEFCOFpRQW51M3FOcGFQUFprNTZQTVp5VXl1YWdWYkdsMWdNTDlz?=
 =?utf-8?B?L1FseGRBMlc3azJDQytWaVhMM0p2UVN6Uit1NTkrZ3Q4ZjVOQXR1V2Jsc1kv?=
 =?utf-8?B?WEhaR3h3a0ZhSTRDeW5FbDVTRTRDeWQyaGY2VG40NjNCd2NiUlBISW1lSnRi?=
 =?utf-8?B?ei9Dc2lFSGZEem1TaU1BSkdWcVFXbWtjMDc4a3plek5DUnBnS0ptdWdlSmRP?=
 =?utf-8?B?aTFpbGo0UXJyMFpTTmdObkpTdGVES0VHL0hVeHk1U1IweU1Va0VqbFZqTUVZ?=
 =?utf-8?B?VnNMK0UwVXpuYWw4b3c5bnlmYzhRTWtqUXAwOHpFbzNZTWJMVUV1S3E4M2Fx?=
 =?utf-8?B?VHNaM3pEQThuSlBlUHNjZVExdS9FWGxhWEwrT2FHRTc4bEdJaHdselc5Z3RU?=
 =?utf-8?B?eTFhd3F5RE9Ia21uaG5QeUF2OXBublNSUjRLR2RXUnNCZU1GTjhDTGsvcnZJ?=
 =?utf-8?B?YnBuN2JtVllrZDg4ajYvMHlJMnpybmxHVm9uU082NUJlakpMdnlNcXp5cW9p?=
 =?utf-8?B?MFVhNm5GWFdEZWE1QTFxSHAwZWtZTTdkUEcvWHBCMzJCQlJhOEVJRGFGbGlP?=
 =?utf-8?B?ZFdhMXFWWnZieXNXZ0oydjRvMnlVSzJtc0I3ZGluTGlrRU9QUjNHblBlZExq?=
 =?utf-8?B?NVE0RnNEZWJjWTJWY044MGN4NlRWNFpNSUZ2blpXSit6STNXTmw2bEtjVk1l?=
 =?utf-8?B?WVFpcGtCQUx6aFJ4dDRpNmV3NmxCZmFMR083N0h6TDJHcU8rbm9XQk1tL3RX?=
 =?utf-8?B?bkwzUjBieG9aTjAxc3VZbTFjY29PbWdlV04vSmZHcUdOS05oY0lSTFFMZDc0?=
 =?utf-8?B?VUo1WE9MY0lFNG1OcGFLdmdMdVpFbUxhSENWTENsRTZFZjRHdUEwbWRTMDFS?=
 =?utf-8?B?RlFvVi94cjIrZitjenNjY0diSTRIb2NVc3EzcVVBZG9oaXVYQVI2enNReU1E?=
 =?utf-8?B?NEdnbEVEYTlad3ZSQWhqajBCaDJnaElkSnl3QXFnQi85V1VCTnFuS1l4REJt?=
 =?utf-8?B?SXdrRzZDTHh1TlFQOGRKRTRwUm45ZDdxWUs5QjBHcUdNcm9HL3RMamhYZ0M1?=
 =?utf-8?B?TTZxRHNkbVRPcEtxVEFtb0dTZkE5UmpKMXFETXJrQlNGRVZvOWxDRHQvMEl3?=
 =?utf-8?B?MVdPTW9FN25BdXNhc2d2Nk5yWlRRYVE3elA3U2JydGNOVG93NW1hdFR3bnpH?=
 =?utf-8?B?ZHRtR0lDR2RhVVJNQldkaURDOFhIa1g1TDd6Q0NONk5KMVdVZ3o4L1ZjZ2NQ?=
 =?utf-8?B?SDdpdjUwMFh5SE5hMWU5ell3bDlUUWZpYXFPeXFoVm1DOElGZGg0SnZhRXNS?=
 =?utf-8?B?VDArczB4bHVtUHZnblk0UHlObXp4dk5SbnJhVkpZUmdMYWcwL3hhUjZSVG84?=
 =?utf-8?B?L29oSmJ6UytsRDE5dS93TjVPWXVpamZ4QStZMjg5eW1NUU5HRys1VVhGanZo?=
 =?utf-8?Q?lTcjtqt3dS5YV2RSFYHWjc1HpyUgGQXuL9+pWJl5L7jwm?=
X-MS-Exchange-AntiSpam-MessageData-1: b3bOLti/W6o6rQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b93f2d92-1400-4a43-b07b-08da44c22a15
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 18:03:14.8473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vAC1PoPQIWZie6DM2bRYaAzVK83PyVpf6Q/KZFnCthrOhKaMsYCoRhhitK3U0hV+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1652
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I totally agree on the reasoning, but I have the strong feeling that 
this will blow up in our face once more.

I've tried to raise this limit twice already and had to revert it both 
times. And the reasons why I had to revert it haven't changed since them.

Christian.

Am 02.06.22 um 18:40 schrieb Alex Deucher:
> @Christian Koenig
> Any objections to this?  I realize that fixing the OOM killer is
> ultimately the right approach, but I don't really see how this makes
> things worse.  The current scheme is biased towards dGPUs as they have
> lots of on board memory so on dGPUs we can end up setting gtt size to
> 3/4 of system memory already in a lot of cases since there is often as
> much vram as system memory.  Due to the limits in ttm, we can't use
> more than half at the moment anway, so this shouldn't make things
> worse on dGPUs and would help a lot of APUs.  Once could make the
> argument that with more vram there is less need for gtt so less chance
> for OOM, but I think it is more of a scale issue.  E.g., on dGPUs
> you'll generally be running higher resolutions and texture quality,
> etc. so the overall memory footprint is just scaled up.
>
> Alex
>
> On Fri, May 20, 2022 at 11:09 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>> Certain GL unit tests for large textures can cause problems
>> with the OOM killer since there is no way to link this memory
>> to a process.  This was originally mitigated (but not necessarily
>> eliminated) by limiting the GTT size.  The problem is this limit
>> is often too low for many modern games so just make the limit 1/2
>> of system memory. The OOM accounting needs to be addressed, but
>> we shouldn't prevent common 3D applications from being usable
>> just to potentially mitigate that corner case.
>>
>> Set default GTT size to max(3G, 1/2 of system ram) by default.
>>
>> v2: drop previous logic and default to 3/4 of ram
>> v3: default to half of ram to align with ttm
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 20 ++++++++++++++------
>>   1 file changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index d2b5cccb45c3..7195ed77c85a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -1798,18 +1798,26 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>          DRM_INFO("amdgpu: %uM of VRAM memory ready\n",
>>                   (unsigned) (adev->gmc.real_vram_size / (1024 * 1024)));
>>
>> -       /* Compute GTT size, either bsaed on 3/4th the size of RAM size
>> +       /* Compute GTT size, either bsaed on 1/2 the size of RAM size
>>           * or whatever the user passed on module init */
>>          if (amdgpu_gtt_size == -1) {
>>                  struct sysinfo si;
>>
>>                  si_meminfo(&si);
>> -               gtt_size = min(max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
>> -                              adev->gmc.mc_vram_size),
>> -                              ((uint64_t)si.totalram * si.mem_unit * 3/4));
>> -       }
>> -       else
>> +               /* Certain GL unit tests for large textures can cause problems
>> +                * with the OOM killer since there is no way to link this memory
>> +                * to a process.  This was originally mitigated (but not necessarily
>> +                * eliminated) by limiting the GTT size.  The problem is this limit
>> +                * is often too low for many modern games so just make the limit 1/2
>> +                * of system memory which aligns with TTM. The OOM accounting needs
>> +                * to be addressed, but we shouldn't prevent common 3D applications
>> +                * from being usable just to potentially mitigate that corner case.
>> +                */
>> +               gtt_size = max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
>> +                              (u64)si.totalram * si.mem_unit / 2);
>> +       } else {
>>                  gtt_size = (uint64_t)amdgpu_gtt_size << 20;
>> +       }
>>
>>          /* Initialize GTT memory pool */
>>          r = amdgpu_gtt_mgr_init(adev, gtt_size);
>> --
>> 2.35.3
>>

