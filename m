Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950D4C61DB3
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jan 2023 15:52:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FDA410E194;
	Thu, 12 Jan 2023 15:52:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B7F810E194
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 15:52:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5sVK84KzIw8v2nc0EP11HHVCm6PZeQOn15gfnbBkkdIIyx1Ich+PxXoq7134Uyo7Ud8ZB+lepZAeXTsFq7wpwqPJ7z+utWr5g65ipHLVordW38H8umCUS+BhhdCwwQXDPsEniNlKn0udAIIWHlrGNjynLI1sxjiTV90dZt380ERqZ/by9EXXQJdiJUje18MK23pnnuhSDnQlOgl/gO6V/7I7wpCI5vbn+NfNKXTyWBB2Gc5ChoPqV2dn71nZ64XiZdHbSloiiLFNKkj8fZcbsv/IxRj8Cmxz1AqUIQadkQlDCZ4sGsL7QXu8+XK8fEbXSF29GlNbQvtcC0d5mb7Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZOwfQ79ZIWcMlfi22yd/RxFLKNzRulZvLfFJHjDzsQ=;
 b=llR8DIHwHQr6JIp8VqGu/+nQKELrHqkYQFw4ghVE2ngz3MYq00z5jAGgDDT2zkutaRH7saJwo6p6Bp/1eCqVzROzi2J0VPh/aHRduvRLv9JCop5dWawQhL7Jb5fOmfudJbHkKLiccIrA99RosPIGYMMaIFjjRhsRJwgrsYHhVo32Rr3wDSoxq6NZWh5Ymn+ZehJXKY0LjZjJ7N/9fzzb2zqkVzfiXm9cu9pGZtAtJ/hZOElcZ9qR8YG/EC8bfqCDEX6DIij378FedfGsdCY4EWOui2DVz1AVBAoDgzBbsvLX40p1JGCKKOMQdGGRNSruJbmI0grJgdDbWoNGLvXbkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZOwfQ79ZIWcMlfi22yd/RxFLKNzRulZvLfFJHjDzsQ=;
 b=4kr/Ca3HMuyBmDi/sdUDLXnAp/+Ly9CUynfzSYlYbtFIzDzjNF2HgH5RwflaEV93Nk2UNkVho1rHsjxlpJUfibZ0UHlEJLyl5GfJ+1PL49airrWS2NZEY0CVT/N/qb+OeqgaSF7jBdQrW/bvJLa2f8HQWmW2OO/iC+Y+ONOsHXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ0PR12MB5421.namprd12.prod.outlook.com (2603:10b6:a03:3bb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 15:52:25 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0%3]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 15:52:24 +0000
Content-Type: multipart/alternative;
 boundary="------------N1YGh7naq0WIsWn4mlLDijSD"
Message-ID: <e43240d6-72ef-2880-a529-25797980e462@amd.com>
Date: Thu, 12 Jan 2023 16:52:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: fix amdgpu_job_free_resources
Content-Language: en-US
To: Thong Thai <thong.thai@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20230112134811.495086-1-christian.koenig@amd.com>
 <CADnq5_NC93kgwPZxv550JxtzMDb6=Y9Pi4DAED5B1sZiiTx-vQ@mail.gmail.com>
 <5d0ca264-5730-ef6d-dbd0-037903d644e3@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <5d0ca264-5730-ef6d-dbd0-037903d644e3@amd.com>
X-ClientProxiedBy: FR0P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::14) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ0PR12MB5421:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d642c1f-9684-4c26-ad29-08daf4b4ffa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oAwywHE5tNWhtGJRplFfLA6xSGUz0xzZwXDnKNn+VCnCUOaNmm3cXEcBZFa3nYVzbXbBUAEU6MIKMfI1Y4N5aiyviyu+sFfhMj2fkZhfrff22DpyaObLmQa7Zddx8XKrwugVmIhr5vvjER3LdHZ+u/UEhx8jUTgDw6Rtq8YbJYxqm+PW7nein1/ieH2GpGqI+M4Azy2rjseSlcU0tWzQj0l0vd/uvmFmeb8qS1FQcAjjCd89lHT8tW0AASo0BHPwg19A9/a8hjGnKcf/0hMN6CfEPUySDpOVPbGnolp8A30o6gaaCdd8NtCnBI4hHLcBxJZd4v8bvTELTepDBh76/VGuBEW9EfVulOAitW5sqAtmeahcd8ThlaeWItymnb3Bih3UfetzetkUwY4rYT0DTvzidoGs/wPTkKLsaSXgu5g7itpmpVl1FEbSm8Ay30RZc4mf1cLXuzaqT7V+4MoyAvZdheSBTQV+3GzNW8YVUlHXBnyg1unDkUNKHqKSUP1trG38ba1W4Tmn46eryMUitfFgeryBYmTp2z/ZKyktsFtNGOyfU3dowBL1C/aFrcX7BO3Oj1B0oeYdi1iz3fn+jt+gdNhF915XTRrBisr9pztCR82FQzdBSMs7ys4jKm2PiOnZEXoEP3Cf6SEoOMgRKQRXOR2n5eGvbEKyaZMtbKfrD5yEGKSbdmJWBw/1F44E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199015)(6506007)(478600001)(38100700002)(33964004)(31686004)(53546011)(6666004)(166002)(2906002)(6486002)(2616005)(966005)(186003)(316002)(5660300002)(36756003)(6512007)(8936002)(86362001)(83380400001)(31696002)(66476007)(8676002)(110136005)(4326008)(41300700001)(66946007)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tlg1eGJ5NEdpZTRVbDByV1NZRXJqTDlzT1pJRXJpNXhXRktyTmZHam8rWWM0?=
 =?utf-8?B?SXVWMHp0a2llTElON3pqS2haNkJJS2VCd3p0WHBRc0xXR3dYdVRabGR4VnUx?=
 =?utf-8?B?emtXb0tiV282MGgwTWpGUmgyT0JTUVpMVUhnRmdaZFlGZFNvOTlHenR2Tk81?=
 =?utf-8?B?NE5NN3pndll0ME5sMEJkMndSeGtHN0lwOWFod2JOSk12d1pKMldZUDI5L3FH?=
 =?utf-8?B?K3YwczUyUGNnZTFjbDRIdmErbFVKczM0b1lySmVxQjU0TVBPeldnZEM0Y0pM?=
 =?utf-8?B?TlZkNXNKU2p1ZWFXWXhBbjAxOWZ1enRrU1Y0cHI5d0kyY1l2VEJqTmZIdThF?=
 =?utf-8?B?THdZUmE4YlBGUUcxVDdtWmpsLzlYQy9MVTNSL3U4QUhYdm1LZHQ0ZFFzT3Fn?=
 =?utf-8?B?ZUZidjhrYWVDblo2VVpxVnpMdHFhcUY1K0x3ZkZOOHJuSDFDOEVPSC8wK0xy?=
 =?utf-8?B?MTdaYUhXQlpkTTR4cWdYQnFkSkhRdEdZUzBCcTZVOTlyeUttQ1VkUWNqWTQy?=
 =?utf-8?B?dllORjFYWEdBUEM4VE10TlZFQnVOaEVzTmN3T1phcUJRM2NqREdtTXZGcVUw?=
 =?utf-8?B?SnB6cFlpL0V5UU54OUFOZXBuN0R6dlM2R08yUlhVeFZRSlVTOTNuR0tJTWJR?=
 =?utf-8?B?RVA0YXJBQnRXdGJNRHJhWWNyRGd3YVFXNW9EbVVFZVVpMk5EWm9NRTYwRTFD?=
 =?utf-8?B?d0hvbm5rZzYyaTRLdW55OU9XUEVhcnBnV2ZacXVGMG41YTVTMHUvRzlTdWxy?=
 =?utf-8?B?QTlya2I5ZTlIdGQvUEc2dnhCSUkwTWs3UHBjelNGbDlSaUhDbjRRUjhqNVha?=
 =?utf-8?B?MHhmT3BtSHFRT0FoQlUzWm9nSTdnTzJsem9jcTYrNGlHeWlaVzF1WFJsdDNm?=
 =?utf-8?B?SUVobDdRTWFMOHo5SmxvMlZvWi83VGRWaHBPZnFnQkNDeGVKWHhydDN0b1Jn?=
 =?utf-8?B?VmFXcURIYmpkNjBaSkJpZWR1K1FjeC9YYTh6NGdNV0FaQ2t3bkpxemxTSTMv?=
 =?utf-8?B?NXFjd040eHpRdERBTlNPcXR4eFhaYUlzV0p4ekdQekJldTJDd3Q2eXJkTkZu?=
 =?utf-8?B?d3psQVVZbEw2TEs3Mkp4KzlsYmJGRGo1bWFqWU9PN0xrVi9vSE42U0V5ZUNm?=
 =?utf-8?B?WS9ZZUVTZWF2cWsvaTE5SitubDNnN2VCMmhHdDNpd0VLZTFsV0VXK0cvTHlt?=
 =?utf-8?B?QTBHSHI1eFBXRHNRK1F0UVN1cFFtVUUxV2pxNnNIZFBmVGVCNllLWnZpUVJx?=
 =?utf-8?B?cWFxNVNDb0g5N0NoK25Yc1puZTBWRE51T1FKMnVXWDdndE5tOTdJQWdWbmsv?=
 =?utf-8?B?Z29INFlqY1p2SVRWL1lhTGJ5Vml2STA5Y1g5WmZvd0t6YnV4SWhsRGtDcUZi?=
 =?utf-8?B?OGI4M0tzRzMzN0wyOThobDhISnB0NUQyNHlYYkYxUlBDbHhsQzhjak44WGkv?=
 =?utf-8?B?OHh2amVOTVJmWWQrRlJvem1qVDNyUytLOEc0MG1RdWZUZFhKZDE3VHExRnlQ?=
 =?utf-8?B?RFhwa0ptby9HY2puVHpsVythWUFjYmIxcTdOMWdhTDRSY2pWTXF2ZGZIY2Y1?=
 =?utf-8?B?U0QvbnJia0k1bFpKQlIwZnNLNU1qYmVSS3pjYUpVT25IQU5ZcnNTemdjQjAw?=
 =?utf-8?B?Z1hVL29ScTh2aWk4bUxYek1jclpiKzVuT01LTW0ya2ZkalF1S2h3SXFpdVA2?=
 =?utf-8?B?cENNTHR5ZXNxNVJlOTJqazF2bEFvSDFBbEdPVnh0WDU4MW9yamtLd0dNV0E3?=
 =?utf-8?B?UEw0SkJwSXV4bkkwT1FXZ0ZSU0JGNUtIOXZZU0pwY2t3YUErQU0vYmovOHQy?=
 =?utf-8?B?blRzcHRRZ1VOMXJhMUM5L0NzL096a3FFNnhXa0hVU1pBT2laVTFWYk5VdlF2?=
 =?utf-8?B?Si9ObVJVZnpHbXh3THVYQ3FVdk9aMlVNbVRIY1UyWlZsRExRcXhBcEtzL0dX?=
 =?utf-8?B?WFVhL2JEN1BrV3lSWUxoSCs1bk5tOGhJSnVJNmNvbzdlTytQVHdWVWh5THMv?=
 =?utf-8?B?UzlRZEpJU3VFZzFwbmE0Z3g2ZGRmMSs0NWlyUFU2NzVDdEVFZzFUT2tLRStq?=
 =?utf-8?B?Ymd0NmNEYUt1QU5aZVZMZ3RxL04yeFJLUk5Nc1JFVC9MSGR1UWpIVytFbDho?=
 =?utf-8?B?MWlWUGpBLzUwbVNxY2UyL3pWeVJXZnV6T3NWWUJDMThqblhwNnVkQU05L2wv?=
 =?utf-8?Q?JIUDvEVcp85K9vwndj/uXp6V1e+6sf/my8xET3OGVPx/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d642c1f-9684-4c26-ad29-08daf4b4ffa3
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 15:52:24.8428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +JkZTpS+k50btIPawr6HdwemYstovnt6vqDEDwVwFQu25WJHQoX0WPX9vBcsG93X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5421
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------N1YGh7naq0WIsWn4mlLDijSD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Sorry for that I've only quickly hacked that together without testing.

Good to know that it solves the issue.

Thanks,
Christian.

Am 12.01.23 um 15:37 schrieb Thong Thai:
>
> The patch solves the UVD issue.
>
> By the way, I had to change one of the "->"'s to a "." to compile:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_job.c: In function ‘amdgpu_job_free_resources’:
> drivers/gpu/drm/amd/amdgpu/amdgpu_job.c:159:61: error: invalid type argument of ‘->’ (have ‘struct dma_fence’)
>    159 |         if (job->base.s_fence && job->base.s_fence->finished->ops)
>        |                                                             ^~
>
> Thanks,
>
> Thong Thai
>
> On 2023-01-12 09:05, Alex Deucher wrote:
>> On Thu, Jan 12, 2023 at 8:48 AM Christian König
>> <ckoenig.leichtzumerken@gmail.com>  wrote:
>>> It can be that neither fence were initialized when we run out of UVD
>>> streams for example.
>>>
>>> Signed-off-by: Christian König<christian.koenig@amd.com>
>> Bug:https://gitlab.freedesktop.org/drm/amd/-/issues/2324
>>
>> Reviewed-by: Alex Deucher<alexander.deucher@amd.com>
>>
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 10 ++++++++--
>>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> index 9e549923622b..28929c6219a7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> @@ -161,8 +161,14 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
>>>          struct dma_fence *f;
>>>          unsigned i;
>>>
>>> -       /* use sched fence if available */
>>> -       f = job->base.s_fence ? &job->base.s_fence->finished :  &job->hw_fence;
>>> +       /* Check if any fences where initialized */
>>> +       if (job->base.s_fence && job->base.s_fence->finished->ops)
>>> +               f = &job->base.s_fence->finished;
>>> +       else if (job->hw_fence.ops)
>>> +               f = &job->hw_fence;
>>> +       else
>>> +               f = NULL;
>>> +
>>>          for (i = 0; i < job->num_ibs; ++i)
>>>                  amdgpu_ib_free(ring->adev, &job->ibs[i], f);
>>>   }
>>> --
>>> 2.25.1
>>>

--------------N1YGh7naq0WIsWn4mlLDijSD
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Sorry for that I've only quickly hacked that together without
    testing.<br>
    <br>
    Good to know that it solves the issue.<br>
    <br>
    Thanks,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 12.01.23 um 15:37 schrieb Thong
      Thai:<br>
    </div>
    <blockquote type="cite" cite="mid:5d0ca264-5730-ef6d-dbd0-037903d644e3@amd.com">
      
      <p>The patch solves the UVD issue.</p>
      <p>By the way, I had to change one of the &quot;-&gt;&quot;'s to a &quot;.&quot; to
        compile:</p>
      <pre>drivers/gpu/drm/amd/amdgpu/amdgpu_job.c: In function ‘amdgpu_job_free_resources’:</pre>
      <pre>drivers/gpu/drm/amd/amdgpu/amdgpu_job.c:159:61: error: invalid type argument of ‘-&gt;’ (have ‘struct dma_fence’)</pre>
      <pre>&nbsp; 159 |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job-&gt;base.s_fence &amp;&amp; job-&gt;base.s_fence-&gt;finished-&gt;ops)</pre>
      <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^~</pre>
      <p>Thanks,</p>
      <p>Thong Thai<br>
      </p>
      <div class="moz-cite-prefix">On 2023-01-12 09:05, Alex Deucher
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:CADnq5_NC93kgwPZxv550JxtzMDb6=Y9Pi4DAED5B1sZiiTx-vQ@mail.gmail.com">
        <pre class="moz-quote-pre" wrap="">On Thu, Jan 12, 2023 at 8:48 AM Christian König
<a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a> wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">It can be that neither fence were initialized when we run out of UVD
streams for example.

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com" moz-do-not-send="true">&lt;christian.koenig@amd.com&gt;</a>
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Bug: <a class="moz-txt-link-freetext" href="https://gitlab.freedesktop.org/drm/amd/-/issues/2324" moz-do-not-send="true">https://gitlab.freedesktop.org/drm/amd/-/issues/2324</a>

Reviewed-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com" moz-do-not-send="true">&lt;alexander.deucher@amd.com&gt;</a>


</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 9e549923622b..28929c6219a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -161,8 +161,14 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
        struct dma_fence *f;
        unsigned i;

-       /* use sched fence if available */
-       f = job-&gt;base.s_fence ? &amp;job-&gt;base.s_fence-&gt;finished :  &amp;job-&gt;hw_fence;
+       /* Check if any fences where initialized */
+       if (job-&gt;base.s_fence &amp;&amp; job-&gt;base.s_fence-&gt;finished-&gt;ops)
+               f = &amp;job-&gt;base.s_fence-&gt;finished;
+       else if (job-&gt;hw_fence.ops)
+               f = &amp;job-&gt;hw_fence;
+       else
+               f = NULL;
+
        for (i = 0; i &lt; job-&gt;num_ibs; ++i)
                amdgpu_ib_free(ring-&gt;adev, &amp;job-&gt;ibs[i], f);
 }
--
2.25.1

</pre>
        </blockquote>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------N1YGh7naq0WIsWn4mlLDijSD--
