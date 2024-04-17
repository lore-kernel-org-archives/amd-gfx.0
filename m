Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4200C001CC
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 15:28:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 855EA11361A;
	Wed, 17 Apr 2024 15:28:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tZud2bGz";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7C7911361A
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 15:28:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjB+M2V43O9D8IR37M3u+paLWRMK8jW1ngW2hCdrMr8aHmmzCGT6xX0PUCiluZ0cvR+Akn8WQKINIHiE+kyAk8LWUE8xUPDlu8Mk9NEL4VCm8O4jy4K7JO5m9uKEst27wvQ3xo9eeLFZWhRc6rAKg4amgH7E96pYattzR8dsZe6Uy0/n9JicvQ6kDdyEwzW1yjvd97uRDpceEBPROvYJMpES+0A+le7jI2PHTcFOh44gRE2NXI3pJH3sjrTP8qkHte/XvhTFWBjZ9Gqtzm5/Ol7Kng8CjNby0D1X9izYKkAHQlVMVSvN+D5J/UfQdhMh8MBoM/NIu3IZsEzLvSFkrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvEe0Qy36XXsC5VAAkq9tSkLckw85vAGZxnhpSW7bNk=;
 b=kVjhdu1jIBObsyRl1GPT0OrVXM291+Pq+bk50x4gooMPdyEMFkset0i3n2S0tkUunLCCe2gOEwLBZ8BsORnc96en3lwHC02fV6JjcPNlZ4RvSZW1F9BguWrwHk8Wnqdjc7XjUGOjsaUMnM6Cz2Qrfwx7VOOTpAF1NvH+fSf4b4gO/ZOlwk7x5Y1IAKJkvABkfq9zD17V1LPY1AO71mOdinZv6ZgMPyUz8LtnsSQxbX5TV/KX/xb4EW10n5bGtH6fw54WNG+dzMGOnaxNwel/X/IGOP7tGyODYEkW29VEAVUKCtMkWuHmQtpEIMYCXySua/O3qvYbcGcAETNKijCswA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvEe0Qy36XXsC5VAAkq9tSkLckw85vAGZxnhpSW7bNk=;
 b=tZud2bGztzZsX0HAXGYGuXXpNK+7eDvZCh5iKTDt//L7l3hGza0R45KoEiWE58BmSzkfpXaFpLHEiY35IHjwwKyE5WamgHtVji96LAqXgJaFNfLXyODIJHBNNVrfWMfiP47Rbvk/4TXzro6C1boxvCWYoS3akDbS63b4pmGTgNo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by IA1PR12MB8335.namprd12.prod.outlook.com (2603:10b6:208:3fa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.58; Wed, 17 Apr
 2024 15:28:44 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a%5]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 15:28:44 +0000
Message-ID: <16517871-3b50-15b1-2011-e6b08dbe0525@amd.com>
Date: Wed, 17 Apr 2024 11:28:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amdgpu: Modify the contiguous flags behaviour
Content-Language: en-US
To: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, felix.kuehling@amd.com, philip.yang@amd.com
References: <20240417062121.3779-1-Arunpravin.PaneerSelvam@amd.com>
 <0ebbd37d-1872-4d54-9aa1-842a6090c678@amd.com>
 <b5460307-ce38-4a34-af22-e0936507a3cc@amd.com>
 <ea5d73f1-0bf9-41a1-95b7-6479ea4c6ad8@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <ea5d73f1-0bf9-41a1-95b7-6479ea4c6ad8@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0428.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::20) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|IA1PR12MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: d19cde54-bf21-47d5-1e98-08dc5ef3118a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dc8DnBx/n+0odcv4/gIHK+ZGtpZLDJjzQDYf/iW/r8bRTx4sF1nh26M/Pf/oMcfeKQSn98SpV70ZF0ZXkshl4tytUeRxcEtJXtkreLa8m6l+JC+DJCMvcysaBN5FusVaLqaxHrKS2mQFUESTK53BvZNFhLEqJeffTUlibZKkOzcUbfgkN0HX9ER5IpycUSW87xsbLkUy77xHKbNYnajxwPuR5jWtDC0a3G6w+/cRsS9MDug6BbNE7GKuNsYFWr3GgcJf/Um0T9kQ0f+rAiOFRY8ZhpkFlwSOd7TNgOC4QylRekb0oa6fQ18BgiUzk56tSNTrBO++Ig9C2Hy9mDH9ddeR0/SFfUIOf+6iEMoyCAWZOfaZ7fvRuhcweqCDhMBck8ecUDTjPie5a2I7HmUmRA/K2ddDrdl+96TT7obE91058CMjG5VvlY5cfTasucmErtaRsMU9etg7qoqLUhqf0IVg7HE8o+G+wQq4hzFuY7xAMPBcmyzmaPqVrRMxR9IXePGMuBT4O2vp1ws1WfWysvhsGJBxQo5V+sTDGQgcoJPG6wmEwR6iszLZZBrLSiwKlJ+FlNzqXcnT6jlNWn2XLp+tXUewy74TxJULeEmSUY+pI7/WfhAlKLPRH1QrPz/rLIXXnc4TolDyTW6SmQIZUC8LTkdNMur6/jQVeKuk/Zw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVNVU1RPVjdZOWtpZ2VkV2F6cmJwK2trVjZVVHgvRG5VbktScDV2OHNOdTdR?=
 =?utf-8?B?TGl3U3kxQkhSbm5RTWl6aXMvQVg3U25TdldIcHZxMTlNVWZnWWJpYTUwcXYv?=
 =?utf-8?B?ZnFUbkxwbFZiblNLM3kxbTdPYmlXa3Uzc0VtNGxycVZIVUc3VGNhbzNzVDZk?=
 =?utf-8?B?NTBSaG5SQ0EyTHU4Z1FTVWRZVDhlSjJPNXcyMktyWWtCQ3NWd3p2SXpReHRX?=
 =?utf-8?B?Z1VIaEZQd1lVM0RsMXJTVjgzdFIvOUZycjZKRnBRUlRtNUJJQlF6Z2tMdXEz?=
 =?utf-8?B?MVg3Wk1OdllPeTdpaWhaWHJLUFJ3ZHNnWVRwNWNxa3kram9LRDZQZHp2cjRw?=
 =?utf-8?B?VXduRDg2OWQ3bCsrYjRvVHlkMC9mWjM3YnJ4NEFyRHNkN0JPUGwvLy9JcCtI?=
 =?utf-8?B?cnV2akFYRlR1K2tHWWpmdnBZYU0xT2JkdjJlT1hJeUVXbUhnK0RvTzlFcC9u?=
 =?utf-8?B?dWdRRG5RT0lLVUh0TFA3aVdQcFJaTlJQYTlOOVR5dTByYjc2dGtRc0FtMVhz?=
 =?utf-8?B?SFUyNnJTa2ZYU29nR25Sc2hiTjhydi9tRWV1T2U1TmR4QUYwQnZJNXVEdm1m?=
 =?utf-8?B?SmFPa1BGNHZBNEMrZEFKSXVxV1FRNFNqQWI2SmpFT0ZZd0R6ampvSXhqV1ZO?=
 =?utf-8?B?akhRaEJPN3dyUWROTDM2c3FqZzJETzN1cUhhUzZLQkpYdlJYZW42K0pKbEtN?=
 =?utf-8?B?bDRLUXNnNGU2aWR4MHN1bEJEUEtoWGg4N1JnK1R2a1FOWXliTW55c1BCcGYy?=
 =?utf-8?B?dk9JbTZsbGVRMFJoLzdJdDlLWWZHb2w1RkRwaTRKMUxrWFJ3Z1lubzJMRmlX?=
 =?utf-8?B?SVJmK3VPWWErVVQ3SCt1YzZhc1ZqU1NUci83YUVSSVRjZkRaTFJEcE9lZS8x?=
 =?utf-8?B?UWJ1Y1VQSG1uTFUxYXo3MkppN2ZpRVZPNHdTVzUxMGhDcTVqK0RSOE1vZFlk?=
 =?utf-8?B?TUxFa0t2RkdpSU5FcUhBM005cUJMODBmTXB4M2U5UnVqTHkvM1BQN1RvcVRP?=
 =?utf-8?B?OEhuN2JXZUc0dlVFK0lnTGpGS0FGRmcrSU9NeFlCOURPRGh4WDZ1ZURRaldh?=
 =?utf-8?B?MHFjOTBkNm44WHNDanB4dEFSOHlHcCtwRFVIRldwSmw5eG5ZOTBneGt4TlpC?=
 =?utf-8?B?SmEvK2tCZ1I0d3hiUWFVYXZISVV1NDBPVVUvd1hiZ1puSFE3UEl6bE5wV1Mw?=
 =?utf-8?B?NVhpUzNJTkxDb2cvdk1mOUd3a2hEOEVMZTZTUkxtRWpIaENpT3JRdEZpR282?=
 =?utf-8?B?SXl3c3J6QWIrdEdiQlV3cUFubWg2Zk9aQVBIdUZ3NFlVUVVqZUd2OGUxUVJM?=
 =?utf-8?B?K2pLVnFBdWRaQnU0blV4VzhVeUV5WXMxSlpaL0ZMWUIwZXMrMTBxMTMwa3V1?=
 =?utf-8?B?L1dOSVBacGdvM0Q0eWhEdHBONmV2cWtGODdqVUFoQ05pK1Erc1JTd3pVdG5J?=
 =?utf-8?B?b00wL2UweDdlQW5sRVpPU3dSanlHZno5dE5obUNDdnE4eUxtbXVCSXRpTFdl?=
 =?utf-8?B?V293NE9nR1Q4U2FDaVRkT2dFQjdSd3A0YnFNYkJhTHIvUytyaUhLNXhmNzIw?=
 =?utf-8?B?alF2djUxZk0xdnpJSzhDRG0yOGtwV3lrbmRhcGRrZkwzSUVjQ3MzcWMwOE03?=
 =?utf-8?B?cDRNa2MxVHlxTDdtVllacDF2SWlLMW1vdi9uNmE5YjNRRmd0RkgxcklhN0di?=
 =?utf-8?B?N0xDL1BsU1RLbWZkVlJ2YXJ2c3dWNGRqWVBoa3JsT28vQmlHblpYVkdHNUlV?=
 =?utf-8?B?Y0hwNENhbXBvZzN6RlZJS2pNcm13MERYU0JtcGc2dG81eS9FMFdPUDZtcTVo?=
 =?utf-8?B?ZHBQSmpNR3N4OW5WQk5Jekt3aUNDTjVYdlZ2NGlnOE1KZ0xuWlkzaHlJTEN1?=
 =?utf-8?B?ajBYUnNlOXVZZ1NHeUFlQWF3U25OQlZqSUlQTDV6NnYxNTA0NTJVVG9OaDh6?=
 =?utf-8?B?UWFoVXZMYUVWOG0rV3VkZ243RklmMWg2RUswc0MzV2M1VmJnaks2aURwVkI1?=
 =?utf-8?B?R1RuTkFiOEFNQzRrWVFHWFVmYzQ1YlhqR1FYazU2UDhCM0dVYkVPSEk3VSs5?=
 =?utf-8?B?Ym1MSlBhY3pMbEpCd1N6WUc0MFpneXdxdXg2dkRlZTg5KzhmL3NIV041djNk?=
 =?utf-8?Q?2pTE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d19cde54-bf21-47d5-1e98-08dc5ef3118a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 15:28:44.5413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2ST2Y5bQrM4s7tM29EVcqyM9MuB1a4qQflxY+IGki0iy93FziDIgly4whBn2N0Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8335
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-04-17 10:32, Paneer Selvam,
      Arunpravin wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:ea5d73f1-0bf9-41a1-95b7-6479ea4c6ad8@amd.com">Hi
      Christian,
      <br>
      <br>
      On 4/17/2024 6:57 PM, Paneer Selvam, Arunpravin wrote:
      <br>
      <blockquote type="cite">Hi Christian,
        <br>
        <br>
        On 4/17/2024 12:19 PM, Christian König wrote:
        <br>
        <blockquote type="cite">Am 17.04.24 um 08:21 schrieb Arunpravin
          Paneer Selvam:
          <br>
          <blockquote type="cite">Now we have two flags for contiguous
            VRAM buffer allocation.
            <br>
            If the application request for
            AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS,
            <br>
            it would set the ttm place TTM_PL_FLAG_CONTIGUOUS flag in
            the
            <br>
            buffer's placement function.
            <br>
            <br>
            This patch will change the default behaviour of the two
            flags.
            <br>
            <br>
            When we set AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS
            <br>
            - This means contiguous is not mandatory.
            <br>
            - we will try to allocate the contiguous buffer. Say if the
            <br>
            &nbsp;&nbsp; allocation fails, we fallback to allocate the individual
            pages.
            <br>
            <br>
            When we setTTM_PL_FLAG_CONTIGUOUS
            <br>
            - This means contiguous allocation is mandatory.
            <br>
            - we are setting this in amdgpu_bo_pin_restricted() before
            bo validation
            <br>
            &nbsp;&nbsp; and check this flag in the vram manager file.
            <br>
            - if this is set, we should allocate the buffer pages
            contiguously.
            <br>
            &nbsp;&nbsp; the allocation fails, we return -ENOSPC.
            <br>
            <br>
            v2:
            <br>
            &nbsp;&nbsp; - keep the mem_flags and bo-&gt;flags check as
            is(Christian)
            <br>
            &nbsp;&nbsp; - place the TTM_PL_FLAG_CONTIGUOUS flag setting into the
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_pin_restricted function placement range
            iteration
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; loop(Christian)
            <br>
            &nbsp;&nbsp; - rename find_pages with
            amdgpu_vram_mgr_calculate_pages_per_block
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; (Christian)
            <br>
            &nbsp;&nbsp; - Keep the kernel BO allocation as is(Christain)
            <br>
            &nbsp;&nbsp; - If BO pin vram allocation failed, we need to return
            -ENOSPC as
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp; RDMA cannot work with scattered VRAM pages(Philip)
            <br>
            <br>
            Signed-off-by: Arunpravin Paneer Selvam
            <a class="moz-txt-link-rfc2396E" href="mailto:Arunpravin.PaneerSelvam@amd.com">&lt;Arunpravin.PaneerSelvam@amd.com&gt;</a>
            <br>
            Suggested-by: Christian König
            <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
            <br>
            ---
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_object.c&nbsp;&nbsp; |&nbsp; 8 ++-
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 57
            +++++++++++++++-----
            <br>
            &nbsp; 2 files changed, 50 insertions(+), 15 deletions(-)
            <br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
            <br>
            index 8bc79924d171..caaef7b1df49 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
            <br>
            @@ -153,8 +153,10 @@ void
            amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32
            domain)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; places[c].flags |= TTM_PL_FLAG_TOPDOWN;
            <br>
            &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (flags &amp;
            AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (abo-&gt;tbo.type == ttm_bo_type_kernel
            &amp;&amp;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags &amp; AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; places[c].flags |= TTM_PL_FLAG_CONTIGUOUS;
            <br>
            +
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c++;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; @@ -966,6 +968,10 @@ int amdgpu_bo_pin_restricted(struct
            amdgpu_bo *bo, u32 domain,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bo-&gt;placements[i].lpfn ||
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (lpfn &amp;&amp; lpfn &lt;
            bo-&gt;placements[i].lpfn))
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-&gt;placements[i].lpfn = lpfn;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo-&gt;flags &amp;
            AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS &amp;&amp;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-&gt;placements[i].mem_type == TTM_PL_VRAM)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-&gt;placements[i].flags |=
            TTM_PL_FLAG_CONTIGUOUS;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = ttm_bo_validate(&amp;bo-&gt;tbo,
            &amp;bo-&gt;placement, &amp;ctx);
            <br>
          </blockquote>
          <br>
          Nice work, up till here that looks exactly right as far as I
          can see.
          <br>
          <br>
          <blockquote type="cite">diff --git
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
            <br>
            index 8db880244324..4be8b091099a 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
            <br>
            @@ -88,6 +88,29 @@ static inline u64
            amdgpu_vram_mgr_blocks_size(struct list_head *head)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return size;
            <br>
            &nbsp; }
            <br>
            &nbsp; +static inline unsigned long
            <br>
            +amdgpu_vram_mgr_calculate_pages_per_block(struct
            ttm_buffer_object *tbo,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct ttm_place *place,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long bo_flags)
            <br>
            +{
            <br>
            +&nbsp;&nbsp;&nbsp; unsigned long pages_per_block;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; if (bo_flags &amp; AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pages_per_block = ~0ul;
            <br>
          </blockquote>
          <br>
          If I understand it correctly this here enforces the allocation
          of a contiguous buffer in the way that it says we should have
          only one giant page for the whole BO.
          <br>
        </blockquote>
        yes, for contiguous we don't have the 2MB limit, hence we are
        setting to maximum to avoid restricting the min_block_size to
        2MB limitation.
        <br>
        <blockquote type="cite">
          <br>
          <blockquote type="cite">+&nbsp;&nbsp;&nbsp; } else {
            <br>
            +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pages_per_block = HPAGE_PMD_NR;
            <br>
            +#else
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* default to 2MB */
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pages_per_block = 2UL &lt;&lt; (20UL - PAGE_SHIFT);
            <br>
            +#endif
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pages_per_block = max_t(uint32_t, pages_per_block,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tbo-&gt;page_alignment);
            <br>
            +&nbsp;&nbsp;&nbsp; }
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp; return pages_per_block;
            <br>
            +}
            <br>
            +
            <br>
            &nbsp; /**
            <br>
            &nbsp;&nbsp; * DOC: mem_info_vram_total
            <br>
            &nbsp;&nbsp; *
            <br>
            @@ -451,8 +474,10 @@ static int amdgpu_vram_mgr_new(struct
            ttm_resource_manager *man,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = to_amdgpu_device(mgr);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 vis_usage = 0, max_bytes, min_block_size;
            <br>
            +&nbsp;&nbsp;&nbsp; struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vram_mgr_resource *vres;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 size, remaining_size, lpfn, fpfn;
            <br>
            +&nbsp;&nbsp;&nbsp; unsigned long bo_flags = bo-&gt;flags;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_buddy *mm = &amp;mgr-&gt;mm;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_buddy_block *block;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long pages_per_block;
            <br>
            @@ -468,18 +493,9 @@ static int amdgpu_vram_mgr_new(struct
            ttm_resource_manager *man,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tbo-&gt;type != ttm_bo_type_kernel)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_bytes -= AMDGPU_VM_RESERVED_VRAM;
            <br>
            &nbsp; -&nbsp;&nbsp;&nbsp; if (place-&gt;flags &amp; TTM_PL_FLAG_CONTIGUOUS) {
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pages_per_block = ~0ul;
            <br>
            -&nbsp;&nbsp;&nbsp; } else {
            <br>
            -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pages_per_block = HPAGE_PMD_NR;
            <br>
            -#else
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* default to 2MB */
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pages_per_block = 2UL &lt;&lt; (20UL - PAGE_SHIFT);
            <br>
            -#endif
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pages_per_block = max_t(uint32_t, pages_per_block,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tbo-&gt;page_alignment);
            <br>
            -&nbsp;&nbsp;&nbsp; }
            <br>
            +&nbsp;&nbsp;&nbsp; pages_per_block =
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vram_mgr_calculate_pages_per_block(tbo,
            place,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_flags);
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vres = kzalloc(sizeof(*vres), GFP_KERNEL);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vres)
            <br>
            @@ -498,7 +514,7 @@ static int amdgpu_vram_mgr_new(struct
            ttm_resource_manager *man,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (place-&gt;flags &amp; TTM_PL_FLAG_TOPDOWN)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vres-&gt;flags |= DRM_BUDDY_TOPDOWN_ALLOCATION;
            <br>
            &nbsp; -&nbsp;&nbsp;&nbsp; if (place-&gt;flags &amp; TTM_PL_FLAG_CONTIGUOUS)
            <br>
            +&nbsp;&nbsp;&nbsp; if (bo_flags &amp; AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vres-&gt;flags |= DRM_BUDDY_CONTIGUOUS_ALLOCATION;
            <br>
          </blockquote>
          <br>
          And this here just optimizes it in the way that it says try
          harder to make it look contiguous.
          <br>
        </blockquote>
        Here I removed the TTM_PL_FLAG_CONTIGUOUS. AFAIU, in both cases
        (BO pinning and normal contiguous request)
        <br>
        this flag AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS is always set.
        <br>
        <blockquote type="cite">
          <br>
          Question is if that also works with pages_per_block of 2MiB or
          does that only kick in when pages_per_block is maximal?
          <br>
        </blockquote>
        AFAIU, if this flag AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS is set, we
        are setting the pages_per_block as maximal, thus
        <br>
        we dont limit the BO. when we set the pages_per_block as
        maximal, the min_block_size would be the tbo-&gt;page_alignment,
        <br>
        and this tbo-&gt;page_alignment would be the same value as the
        required size. Required size can be less than 2MB or more than
        2MB.
        <br>
        Below we have check size &gt;= pages_per_block, when the
        pages_per_block is maximal we don't limit the min_block_size.
        <br>
      </blockquote>
      a small correction, when we set the pages_per_block as maximal, we
      don't set the min_block_size, the buddy allocator will set the
      min_block_size
      <br>
      as roundup_pow_of_two(size).
      <br>
    </blockquote>
    <p>If setting 2MB pages_per_block, without
      DRM_BUDDY_CONTIGUOUS_ALLOCATION flag, does buddy alloc from free
      2MB blocks first, or buddy split larger blocks into smaller
      blocks, as we want to keep larger block for contiguous allocation.</p>
    <p>Regards,</p>
    <p>Philip&nbsp; </p>
    <blockquote type="cite" cite="mid:ea5d73f1-0bf9-41a1-95b7-6479ea4c6ad8@amd.com">
      <br>
      Thanks,
      <br>
      Arun.
      <br>
      <blockquote type="cite">
        <blockquote type="cite">
          <br>
          <blockquote type="cite">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fpfn || lpfn !=
            mgr-&gt;mm.size)
            <br>
            @@ -529,8 +545,21 @@ static int amdgpu_vram_mgr_new(struct
            ttm_resource_manager *man,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_block_size,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;vres-&gt;blocks,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vres-&gt;flags);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(r))
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(r)) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo_flags &amp;
            AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS &amp;&amp;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !(place-&gt;flags &amp;
            TTM_PL_FLAG_CONTIGUOUS)) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Fallback to non contiguous allocation */
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vres-&gt;flags &amp;=
            ~DRM_BUDDY_CONTIGUOUS_ALLOCATION;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_flags &amp;=
            ~AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
            <br>
          </blockquote>
          <br>
          Well I would say that this is a rather hacky implementation
          and should be avoided if possible.
          <br>
        </blockquote>
        sure, I will try to rewrite the code.
        <br>
        <blockquote type="cite">
          <br>
          <blockquote type="cite">+
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pages_per_block =
            <br>
            + amdgpu_vram_mgr_calculate_pages_per_block(tbo,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; place,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_flags);
            <br>
          </blockquote>
          <br>
          Rather move the AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS handling out
          of amdgpu_vram_mgr_calculate_pages_per_block().
          <br>
        </blockquote>
        sure.
        <br>
        <br>
        Thanks,
        <br>
        Arun.
        <br>
        <blockquote type="cite">
          <br>
          Regards,
          <br>
          Christian.
          <br>
          <br>
          <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_free_blocks;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (size &gt; remaining_size)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remaining_size = 0;
            <br>
          </blockquote>
          <br>
        </blockquote>
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>
