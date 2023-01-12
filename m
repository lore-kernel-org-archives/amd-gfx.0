Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D6DC54EBD
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jan 2023 14:37:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B68410E0A5;
	Thu, 12 Jan 2023 14:37:07 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0164810E0A5
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 14:37:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0G62pExhvP0Nfg2HgTQFuOJGxT1xZflQuI0l/f4Bbn/5q1yGv7xXQ8SpS1GDwCWDLkkTrY9dmY4QCRjQ1QaXwKlagjqWpns1dssi1uOKaCJneaOQhz9JVBOWapzoBu/26P2uJok5SqU1K/mT2BxlPiDcFd6qLxgnItxJAmsqTUMWELmv2Fq74SaeIY24hzy4sZvd1mv4Csy4E32BpRST8n26FVabUkWUtd2T7WePs5TJJqk+vmZFyyOQD5mY78Xaawbi9Om0b33YGuQFIgQzr7vWGbjYBIGHqJf54WdVywIC4EiQWZgUZWJhGyAiwPCMAWbhavmp9mCWZsl2PWNzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GS/DTmZbJVVEpC2UpgzbQUjtjbEytg9/TlJoYR8ywtc=;
 b=OPTAWTfDayua2qP0Xy3LDRrxhiKupzGGi2opW+RbVBBXwIHSulnOJy2iRpN3I6hxbTye+2ASK+/LSSFP/UxnrSUIYJdKSD3RqsTKdzAZeW0Xer0o5Ef7UtLNFhtfYWoBCwka2iWf7xBbfS241vZexK1spqONPe/FgTxII4uGPbdXjV7WB0m5Ms1L9AHtR4F405RnEcX4j5SDrjbt0AVKQJQaGfYHCpXa3TK98nosGYhni51TmbE1mCgEs29K6euN49Z3nCuTyK2fTsS9NZccFtQphpD4Q/w7F+3gPH9vh0mjWz3NBzlAowK9tJKaXCLFXnbeibZMpw2/7HJbut7niA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GS/DTmZbJVVEpC2UpgzbQUjtjbEytg9/TlJoYR8ywtc=;
 b=TlklKcteTPz+2rzbxQaVZatG+xIOXdZLYn2tiUZJgIFzqW7LyDYPCuqgAiYk1a0B05T0AkKgZv083eDI1IKfUkkWLx3T6BCdPtaHfpaYGtt4EfhuLRFZA1wAEWOjcIJwX6U1syBg8RwA/2CMLj0euuNheAepm2n8No+8xaSh5V0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5089.namprd12.prod.outlook.com (2603:10b6:610:bc::8)
 by BL3PR12MB6452.namprd12.prod.outlook.com (2603:10b6:208:3bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 14:37:03 +0000
Received: from CH0PR12MB5089.namprd12.prod.outlook.com
 ([fe80::57e:55e8:5593:b39c]) by CH0PR12MB5089.namprd12.prod.outlook.com
 ([fe80::57e:55e8:5593:b39c%5]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 14:37:03 +0000
Content-Type: multipart/alternative;
 boundary="------------2Ng2qkXX9fIryS7rxR8J1xOS"
Message-ID: <5d0ca264-5730-ef6d-dbd0-037903d644e3@amd.com>
Date: Thu, 12 Jan 2023 09:37:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: fix amdgpu_job_free_resources
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20230112134811.495086-1-christian.koenig@amd.com>
 <CADnq5_NC93kgwPZxv550JxtzMDb6=Y9Pi4DAED5B1sZiiTx-vQ@mail.gmail.com>
Content-Language: en-US
From: Thong Thai <thong.thai@amd.com>
In-Reply-To: <CADnq5_NC93kgwPZxv550JxtzMDb6=Y9Pi4DAED5B1sZiiTx-vQ@mail.gmail.com>
X-ClientProxiedBy: YT4P288CA0007.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::8) To CH0PR12MB5089.namprd12.prod.outlook.com
 (2603:10b6:610:bc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5089:EE_|BL3PR12MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: ee3e95cf-cb75-48a2-23fc-08daf4aa78b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5l37hmkwmv1Dq67vnZcO6TcEcoLG5GOhE79ToCWB5Lfc09A1PvWBTh+h6QyQ+OSFyaC+ju3cU7oMVGjnHhD9jqJH9Cd9XZZMGizeJwY0OW9fnEx40xm9syVlmp6zmCD8FWYePnlBVXpCtHKxET+49TyZ+QoTrJ65Zlrmm/mfP0PAL2oA2mHOpNaVBu47v5IeWOkT9xbo9nd/kKwD+F+vY89eMdy/DiqNxqawLQL665W7iMml71nAexD1E6vzcjMji/zK5/G3E2wGuyWBHrSRZ4t9VdY5nwKuYpxD24MtlyqMsOz1fEf927cW+LdFngW8iFRVEl5KKJEv/OJABo0LKB4tWGfDQ5PC2KYtHgDYBx3u1WvvHXpOyaH54xjgyZrcbV57/Jghy0sIbIuKHCDbP8dGZFvLO276W2GW2cTUDjj1axZZnXYyVLZpe9B2NjVXpDWE84FIUeEK+HkySFSkPdRxCVycxRIASz8/zcFRFPcDtd2IPzZfL0Ar1yLfbj/jZ+tiMaNu0dAfC7ZwMR6AUqW+dQtGxPO7c//KSgE1kR1uMcbC7gWI7UUsbEHuY2EqiDs9qcFRlyK6fhCOyWKitjQNW863DGfEJbMI8yItLtc/9mog9t3XTwzEmpYiJquwhip9d8XznheDNfddjM5iUIBF8HV7HS98hWHztfvZdLI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5089.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199015)(26005)(8936002)(5660300002)(2906002)(41300700001)(166002)(66556008)(4326008)(316002)(8676002)(66946007)(66476007)(110136005)(6512007)(38100700002)(2616005)(86362001)(31686004)(44832011)(186003)(31696002)(966005)(83380400001)(53546011)(36756003)(33964004)(6506007)(478600001)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eC9WbXJoNlFGZi9KN0lKVlRwYzF3RFlQcU8yaHFtbng2eFAvUktVc2lCZGtB?=
 =?utf-8?B?ZjEzVzJJVTViSTNpTlhuQ1pvUjVncUJjS0duL2pDMitLdnNrNEo4OGxIY0hE?=
 =?utf-8?B?UjRXdUFCT2c2eG1iRVVqZmVjTythUE9uTGluTzRIZEZQL09HdVlkMkZEUXZR?=
 =?utf-8?B?bkZRQm5zaW8ySFdNWHNxQVBnMW4rcHJvYjZDYlVEYVVBaVFPNHpuRTE4d0NN?=
 =?utf-8?B?VjluZmQ1cDNJQ1dabEtsdWpFUVc5Sy9sVk42bTd5MVlDRFNJYTJTZjNQUERZ?=
 =?utf-8?B?cU1qT0R4aEVuOHdrUzVUOUZoRHNCZWR3TU1RRlUzUUU5OWJGY0psUk91S0pu?=
 =?utf-8?B?LzZSR1EwQlNYZlhld2VCM09ISEtHZmZXN2Fac2EzaFZNYnpCaEhvNHdyUmxY?=
 =?utf-8?B?R0F5SEVyU2djcmU4OEZXR2FZYUlEeHV4Q3owUVNuZm5pbWVTY3RmUU1zMDdL?=
 =?utf-8?B?NjVjd0lEekk2Ym5Ea1RhQ0FOcVBsTmhUNnB0T3NiVlJOb0gvc3lzVVZtWFdz?=
 =?utf-8?B?a05HMmVHaWVjZkxaeGNPOFVKK1hJZVdmcmRUblBNTkZyMStwMmJMMm1ZR25m?=
 =?utf-8?B?Y1NGTWR6aWJQTjhKOWVKcmJpNm95VXFWTTNwcXI0WnN6eUZJRE9hcGhKQ3g0?=
 =?utf-8?B?bjI0OEozUEF5UzJQVTlveTVsL1N5SXVWN1p1WkZ6ci8zdHpYbEFUTHhaQXFM?=
 =?utf-8?B?VU5mY2NGaWZLK1N3M0FZdWpCd3FjQVd1WktJdGtpTDIzaEwweGczQk1LQ2d1?=
 =?utf-8?B?OEN2clVKTkg2anRiTTVmZjV2a1VCLy84RzNJL3lhSnFzT3Z3UlBVTUcvT2I3?=
 =?utf-8?B?RGxKcDdhK0JaZ25PSVc1MFFidVBQSjdNd2ljVWdDWTVyeTQzZzd6RHFjbWJx?=
 =?utf-8?B?VGRkeE9SeGZhRHlqSmNjUDhORHJpTjVpSWhOTXVRSUsydmdlQm9tN0t0enFI?=
 =?utf-8?B?Z3EvbHEyK3Q3L2JqZ0V6TkpFZ1NnZE1UQlVLbG5lanlVTlJNTnZZWUEwOVFl?=
 =?utf-8?B?ZktPdGVpU29QQTI2TDlXL3BsTWNIdnVqSmpoL1REK2hBdXkvNkdRQVZKem54?=
 =?utf-8?B?MkYySUVVRTFuMldZUThFME1HVE8zY1YyVCtKNHR3dkF5b2RidHZ4ZGViK0x6?=
 =?utf-8?B?RzIxVjlaVW5ZTGI1WXVLQkk2QlFGL01mdnhQZHR3em1ieCtYUS8wZXh1UUh6?=
 =?utf-8?B?TVZlMTNLSXNackR3enorNStuNlJ6dE9pMFU1LzVWRjh5bkJuSVNDTUtJRWd1?=
 =?utf-8?B?dHk4T2ZCUHhjb0dlUW9iSEZaNzIvUDBiMmdYdGh4WTI3VGtoNi94azBIdUF6?=
 =?utf-8?B?dnAybEF5K0wwd3FGRTg5eFFKS2NIZmR4ZDZXTDlIazVjaktGcitqbGdaWVUx?=
 =?utf-8?B?NTNOOVdjNGFRc2NmQ3A4NmhaTmxhbU1uc2FRRW1zc0JZMnV0d01KNENiLzBE?=
 =?utf-8?B?NE9zQ0E0L042RzMwalg3UG9CNEJqSjVpTGNBUkQwV3p0OG52c2RSRFRKOVMy?=
 =?utf-8?B?UGRFVWtmQkdUMUJGVHJKTEVrbFVidC9jSkthR0I0RjYvNkE1d0ZXZmxJS1Nq?=
 =?utf-8?B?SmdCSisvb2xzS0FBcEFmTU1xN1YrYnM3VlZQS2pSdmowNVNhYVdOcThBRVdL?=
 =?utf-8?B?amwvblBjejZwVjJNQXhXbzZNNUJVNXJVaStVZk13eDJaMnd0bXRXakQxZ213?=
 =?utf-8?B?dTJiRk9qTTd6S0hYWkhTU0wwbFdENGhuRldsNjA3Mkh3a3BvOUdpenYxR0Nn?=
 =?utf-8?B?YlZWaWE0a2ViMDlCTGtTUnVyV2JsS3dtSnhWVUtQdXNKZHdiSmJ1aU5qbFFU?=
 =?utf-8?B?SjFQakc0NG9ockxNYjVDUG1EYXAwTlYxSUMyUnFESW95NDN2ajY5bUZWUGZL?=
 =?utf-8?B?NjBRM2lGKzZwM004d2dUbjNEWGppemNXOUZwenNDcVBSbXZGRjBZR0JCdHlJ?=
 =?utf-8?B?MDJOWWdoVnd0cXFxcTBOaW9kYXVtZlZ5Y2pxVlM1bFUrU283NHJ3bFlwb3NH?=
 =?utf-8?B?enV2b0FhTGJTU2l6cHQyTVpBN3JKaVl3Q2VhNE5VenYyeDFZSlIyOUpVNHl5?=
 =?utf-8?B?a09RWHYySGFocGRERmlSeWN1N2ptUnBzTytacTRhUzc5Yk9VREFIRFBWUURt?=
 =?utf-8?Q?qVPmFIWeEy8lMm4tcIK/D0Hwo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3e95cf-cb75-48a2-23fc-08daf4aa78b5
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5089.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 14:37:03.4975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvvhCwfhq7H0Cp/HrC2bAhwGSpzHcewyIKsFPb8dIZLck7lWWXDxeYZeeaaYRP5BThdo59rlvTF3vDgi59zu7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6452
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------2Ng2qkXX9fIryS7rxR8J1xOS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

The patch solves the UVD issue.

By the way, I had to change one of the "->"'s to a "." to compile:

drivers/gpu/drm/amd/amdgpu/amdgpu_job.c: In function ‘amdgpu_job_free_resources’:

drivers/gpu/drm/amd/amdgpu/amdgpu_job.c:159:61: error: invalid type argument of ‘->’ (have ‘struct dma_fence’)

   159 |         if (job->base.s_fence && job->base.s_fence->finished->ops)

       |                                                             ^~

Thanks,

Thong Thai

On 2023-01-12 09:05, Alex Deucher wrote:
> On Thu, Jan 12, 2023 at 8:48 AM Christian König
> <ckoenig.leichtzumerken@gmail.com>  wrote:
>> It can be that neither fence were initialized when we run out of UVD
>> streams for example.
>>
>> Signed-off-by: Christian König<christian.koenig@amd.com>
> Bug:https://gitlab.freedesktop.org/drm/amd/-/issues/2324
>
> Reviewed-by: Alex Deucher<alexander.deucher@amd.com>
>
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> index 9e549923622b..28929c6219a7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> @@ -161,8 +161,14 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
>>          struct dma_fence *f;
>>          unsigned i;
>>
>> -       /* use sched fence if available */
>> -       f = job->base.s_fence ? &job->base.s_fence->finished :  &job->hw_fence;
>> +       /* Check if any fences where initialized */
>> +       if (job->base.s_fence && job->base.s_fence->finished->ops)
>> +               f = &job->base.s_fence->finished;
>> +       else if (job->hw_fence.ops)
>> +               f = &job->hw_fence;
>> +       else
>> +               f = NULL;
>> +
>>          for (i = 0; i < job->num_ibs; ++i)
>>                  amdgpu_ib_free(ring->adev, &job->ibs[i], f);
>>   }
>> --
>> 2.25.1
>>
--------------2Ng2qkXX9fIryS7rxR8J1xOS
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
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
<a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
It can be that neither fence were initialized when we run out of UVD
streams for example.

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Bug: <a class="moz-txt-link-freetext" href="https://gitlab.freedesktop.org/drm/amd/-/issues/2324">https://gitlab.freedesktop.org/drm/amd/-/issues/2324</a>

Reviewed-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>


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
  </body>
</html>

--------------2Ng2qkXX9fIryS7rxR8J1xOS--
