Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F98EB64DD
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Aug 2023 05:23:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40CF010E0BF;
	Thu,  3 Aug 2023 05:23:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFF2910E0BF
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Aug 2023 05:23:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cS/z0goAMIFLeoXNfAo0+CwftYEfOkhy9uVxBpCCD/VQq3BBWwyfXuqR2f4tuZvSL4ZKJsGUAuRj9zbiRm4pSoGvu9yww42Ke+pnN1Mixbu9whh7hUFu2XbvsE8OeEXb9+40bSzamzjJQGIByAFM+2mFfbYelUS8WKTHt5nEJY080uqBGpjFijvRJl7xxdpmH7cz42tJ2L9qh8XGj6ZKY9dcG5MFS4haM/K9wHeIChgKpfBCxzyn7Fv1ucfwGnoi9OZ2Bn0OlCuy4UXRx4jYyv7BLwBikalF0nzNRA62uQXC/5u5aWgkkFl9qhDUAca6nCbaCXdGrKeyT6cRWHqvNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tjY9f3wj2zFY65lQvuY1x3nOOV7uWotGF7rr+UDmYk=;
 b=AEEVQ1vrL4JEM61WPQzBeLdH4Y+rHIN7sfSjmEFpUwnsyf1ngtC8pqcpQPKydrRaoiswC+F9HeifeNNeFahcQakCxI2QSqpvcqnrwIUc1E1AS7XlX6kO0ylM7YXBk1wCEUfr1bj3P2isWgGESKVO5RwsU3yveMDuI3aXiuVjQGIAvpQ9qvG9cPqR1awJPimNZL+RqTUrEwIH4ZuCa7qURCo+SOHRbw9Cvxa1KtqjfDf1tvUg4KYhUJNiZqGyPppkA7qe94kMrnWp2Qn+Nku9YqiY15Z3TYxzjKheXYh51GvjzT5ATGasyJHHI2LlIV9ufIplmTg6fGahKk6/HysnTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tjY9f3wj2zFY65lQvuY1x3nOOV7uWotGF7rr+UDmYk=;
 b=Ugxapd9Wcio7l53wr389at92PalSBEgIIU53JSHE2uRy3Uh+hn/u3AqNl2Oi3Y24z8q9/YvTjShPslJd8+ZyajBuSuapGPuDY8isGJBEUS0VlKHpKIh95t0+toUMFm+TSxnREFUxzjUjZUZAwRMWgjpCc4NMhqbA85vlwJ3vHco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by BL3PR12MB6452.namprd12.prod.outlook.com (2603:10b6:208:3bb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 05:23:32 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::c725:d5a0:a4a8:772b]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::c725:d5a0:a4a8:772b%3]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 05:23:32 +0000
Content-Type: multipart/alternative;
 boundary="------------ItezspT227fV0y8tpGW7r2F9"
Message-ID: <f8c546b3-669b-41dc-bc35-c7fef96ad4e4@amd.com>
Date: Thu, 3 Aug 2023 10:53:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Remove volatile from 'wb' & from 'ptr' in
 amdgpu.h
Content-Language: en-GB
To: Alex Deucher <alexdeucher@gmail.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
References: <20230724155418.2179209-1-srinivasan.shanmugam@amd.com>
 <CADnq5_NcEr3=bDoSo5_YYYuNAMps655fcOuUDaAPmw3_QDwQNQ@mail.gmail.com>
From: "SHANMUGAM, SRINIVASAN" <srishanm@amd.com>
In-Reply-To: <CADnq5_NcEr3=bDoSo5_YYYuNAMps655fcOuUDaAPmw3_QDwQNQ@mail.gmail.com>
X-ClientProxiedBy: PN3PR01CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::15) To MN2PR12MB4128.namprd12.prod.outlook.com
 (2603:10b6:208:1dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4128:EE_|BL3PR12MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: 645f3f7a-73b3-4364-99c0-08db93e1c6c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HAoyz2Jj0yBwYFOmnAohleWUwz2AQodHrO0CTYPQNAUxhLlOgeG6AeK3YPfhiiSaGqIwKKf8P0CIZp9/91dnfbgcCRdGQ8HN01xdXaCPZOqBD3lqd3a8qRwpw7AAdTc9ZuuI16zbGkt0Urt/3wg3trgp4STg38B8dB3QRojqwxTp9ZqZVnSIINO/YSPcnzXLbbIa1b5StGj5LeVM8kIzCdSbxzhzIoCaYrHA+edpgNAw8Yyj268iMoiRG55IM496es2LThcOIvEbjVKp2XJnOEad2ztMQw3gyP3yz2hoH1CohyR+XOr9uX7R4ooJsZRmFZIJgORpqjwIAjeUGWHZ5Z9bi7/spARH8RtwJ17FB7k5ev9nFyw1MiJvkjtr8Gl1Pm1SYLNehgePykelhvN23fDOhF02Igg4Hf2nH387kzvYc1w0dDLWYmuoZ7JfoPdGPpCuJwgQXTZgSJ+uItmvUAw3muOfnM7dYY1HBu8TxrvOn4ecCI/bt6sUXge6teHpUG64lnPeCjVYhefcSX+b6VACNfoLoUZZlcYOLWM8tSYaJeo42DZdsEuwaCbaLCSIxsGtjq0I2HQT0B8nK+KQIDm9goEkiHY5Z+MAhqaT1wbs6abyOuRM1rfHlJID9oWq6jtHneZWwLulgkrI/mG69g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(66574015)(2616005)(33964004)(53546011)(6506007)(83380400001)(26005)(186003)(316002)(2906002)(66946007)(4326008)(66476007)(66556008)(6636002)(5660300002)(41300700001)(8676002)(8936002)(6666004)(6486002)(6512007)(478600001)(110136005)(54906003)(38100700002)(36756003)(31696002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVpXdDMwekZZSk5DZmppRG9jN2JuMldmUGJ1Z0ZHcWgzTDhMR2ZFNHd2VEdO?=
 =?utf-8?B?UlMvcC9lSzhIOGgwazd3Nm9BSHg4V25kS3dHU2tBbWdJTUR1TFF4SndGZ29u?=
 =?utf-8?B?VXVKUXFSMXltbGFmVEU5Ni9CUzR0VmpVSUJUTXZveCtRUjRyU3NvRC9LWUpy?=
 =?utf-8?B?STdNRXcweWptaDZuRlB4aVhubjF0MG5TdURrb01vU2g0ektnMzk3bGJhQjFw?=
 =?utf-8?B?d1ZlRHdYV1JMRUFCUjQ5TzY5NExLMFY4V1lzcXBORW9jbDQ2b3FEazlXL2ln?=
 =?utf-8?B?NjIrZU4yVHVIQlEwNGhHUDdldm9KN0Q3dkpzdWJaTzhESmJRRnlMK0E0S0ZT?=
 =?utf-8?B?cXp2YWxjbHh4K0hMQ0NNN1hWd01tTDExSENQQkNHYWlxRlhsbWhkTE8rbUV0?=
 =?utf-8?B?L1dwWjl3c3BZTURJV2xYWmhGNkFVSFV2SEFEVUkwa2h6NGF4SkZNc1VRS3ZB?=
 =?utf-8?B?R3dKWlY3ZHJrRlZnMC84VWZIQUZscWo0Wm4vcTdzS21hajcza29EV1c2WWdr?=
 =?utf-8?B?VU5ZMkF5bG5TN3VZYXJ6MERoTHhUekR6dTlmYTdtWEdXWjdEbWJaYXV6SEU4?=
 =?utf-8?B?T0toNjRFN21yT2REcXIzbVd5a2dlQkhwR1pDaDBtUVdVSnBsNjBmd1FhVnVk?=
 =?utf-8?B?QWdMTnJiTkhWdlo1N3BtUjZjL0hOa1pCU0RBK0pnUDVBYmZid2lHWXdBaUov?=
 =?utf-8?B?d3RvUzN0WUpiSU4yb200MGZmY3lFNnA2cmNwc0VCT255eU5WL3dUdFd6TGpO?=
 =?utf-8?B?SmY3TDVrRWJVUjd2WXdHR2ZpK3lHbUJOV21mRmNkbXhMdUFpOEpjSjB6M3I4?=
 =?utf-8?B?UFoxLzZGYS94bGYvMlVVK1RnOUdaMHV1WEwybnIyTFlyRmV0ODNLazlSSVpT?=
 =?utf-8?B?MjVOWlhmZjRhNnlXTCtabHl3UHJVMXNZODNBL1RQRXFyS3o1N0JzTFFYc0N4?=
 =?utf-8?B?d29KZ1dxMys0aWE3ZDVRbktGY0pRUi9mN2J4WFhrd2VRZFZrdHJvTyszdFl3?=
 =?utf-8?B?d2pER3paNW9ETjhab0lWUHVtWDUydzZlRFJGUlUwVVdxYUY0Z0lHeTZFUVdm?=
 =?utf-8?B?OG51VFRFajJ0WjBsK3JWc3lJVTBZdzNOSHY5c1JpZ1V5c1ZPcHlJQ2UxUFlY?=
 =?utf-8?B?QTlmSGZKSXFMWlRteTNsellRL1R4SGJZbTNUTmhVQWo5N0xvNVBkRUYxQXJX?=
 =?utf-8?B?TVF0bG9YekdDaHlzK3ZVbW9hbm93NXhZOE0wb096M0MzK1pPdTRNa2xGWDZs?=
 =?utf-8?B?OUtyTlQ1SUJvMEx3OWZZemVmMGhwK29Xei9LMnB2bGhUL0tuMUxOKzlpOGpP?=
 =?utf-8?B?ZEo4bjhaU3dpbDZqOWI3R2Y4aUdLTnVaakFpRytmbjhQN2pzejY1WW0wcE9o?=
 =?utf-8?B?UmNmNEp3eTE2S0dYS3ZSb09JZzJxcFpRei9WVCtsYTVHbHhRQ1VXWm0xN2Jv?=
 =?utf-8?B?UHdnMmZydzB4MVhyVktYNWxOajBHNGZVMlhNNE5XSTVrb0RPM01XZTk0OGpJ?=
 =?utf-8?B?M0dVNkNPd0pwcldjcWtCTlZMQWtkbnkrUWx3TVVLQnlSaG1tVUIyaHRuYUF1?=
 =?utf-8?B?Y29PdWxlWUVtaVZ3eVg5THhqcUNtSDJEbEpJbDFaNFFheG95UmJJZ0p1K1l4?=
 =?utf-8?B?OGxFZzZuS215TUhZUzFHM1lVdlQ2YWJGeXhzUGtHai9VdGphUlIvQkRjYWZI?=
 =?utf-8?B?SDlGeHYyWlNsOXF0a0RZclBmQzBvNGhFZjVJRkhiNGJYTVhBdnpyRWdvdGhs?=
 =?utf-8?B?Q0VTT1N3Z2w0dFM5eGxOSTZhb1RVUGZvWjN4RVNydlBYLzlKQmI2UHdXd0xD?=
 =?utf-8?B?azhLR3pkTGRESU16TUZoUjNybHpPaFBoYmtQeE1BNEZOZ0dVdkR4am5uRE5S?=
 =?utf-8?B?MGU3NTJKQ2RYMWR2bGxlbzRmM2JPbjA3UWJHYlF3VU1JRWlDTnNuY0V2NU53?=
 =?utf-8?B?VVJ3MGF1b1l0elVyLzhveXZzTEJpcmVCQWFnRXJLWGczb0JHMmFWc01UREk2?=
 =?utf-8?B?aDd4UVpXSGxhNXo5RWFGN1MrWWJ1NnplWERwRFJiYXpxZXRsWXUxTWQ3TXZw?=
 =?utf-8?B?cEJPSGRLL0pWL1dlV293MnFaOGc5NVJzekwyTVUycXNIVlJPN21ZZldiNG9I?=
 =?utf-8?Q?Co0JZsZg73yKPx7Uv3qcf61xd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 645f3f7a-73b3-4364-99c0-08db93e1c6c3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 05:23:31.8601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJUdwVg2G0JTMOIMJ46OmbBYgOrLBhpXd8VwHOb/1LFJ9namLJJqcqkpFPAQ93s2pUrLqOmlKJV++3IOAg5vcw==
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------ItezspT227fV0y8tpGW7r2F9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/24/2023 10:43 PM, Alex Deucher wrote:
> On Mon, Jul 24, 2023 at 11:54 AM Srinivasan Shanmugam
> <srinivasan.shanmugam@amd.com>  wrote:
>> Fixes the following from checkpatch.pl:
>>
>> WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
>> +       volatile uint32_t       *wb;
>>
>> WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
>> +       volatile uint32_t               *ptr;
>>
>> 'wb' field from 'amdgpu_wb' struct & 'ptr' field from
>> 'amdgpu_mem_scratch', is not used to access h/w directly, neither they
>> are shared variables, so volatile is not necessary
> How did you come to that determination?  Both are GPU accessible
> memory allocations.  The writeback (wb) allocation happens to be in
> GTT so it's system memory, but the the mem_scratch allocation can be
> in device memory.
>
> Alex

Hi Alex,

Thanks for your feedbacks!

Commit message is misleading, I presumed that this volatile modifiers 
are used for monitoring HW status registers due to external events & for 
some shared variables - may be volatile might be needed for *wb pointer 
variable - as they may be used for caches in between (on surface level 
info), can we split this patch into two, I felt volatile for *ptr is 
unnecessary as it is type casted with void type  [(void 
**)&adev->mem_scratch.ptr); in amdgpu_device.c]- Any advises onto this 
please?

Best regards,

Srini

>> Cc: Christian König<christian.koenig@amd.com>
>> Cc: Alex Deucher<alexander.deucher@amd.com>
>> Signed-off-by: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index a046160b6a0e..06f79a84ff4b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -502,7 +502,7 @@ int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
>>
>>   struct amdgpu_wb {
>>          struct amdgpu_bo        *wb_obj;
>> -       volatile uint32_t       *wb;
>> +       u32                     *wb;
>>          uint64_t                gpu_addr;
>>          u32                     num_wb; /* Number of wb slots actually reserved for amdgpu. */
>>          unsigned long           used[DIV_ROUND_UP(AMDGPU_MAX_WB, BITS_PER_LONG)];
>> @@ -621,7 +621,7 @@ int amdgpu_cs_wait_fences_ioctl(struct drm_device *dev, void *data,
>>   /* VRAM scratch page for HDP bug, default vram page */
>>   struct amdgpu_mem_scratch {
>>          struct amdgpu_bo                *robj;
>> -       volatile uint32_t               *ptr;
>> +       u32                             *ptr;
>>          u64                             gpu_addr;
>>   };
>>
>> --
>> 2.25.1
>>
--------------ItezspT227fV0y8tpGW7r2F9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 7/24/2023 10:43 PM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CADnq5_NcEr3=bDoSo5_YYYuNAMps655fcOuUDaAPmw3_QDwQNQ@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Mon, Jul 24, 2023 at 11:54 AM Srinivasan Shanmugam
<a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Fixes the following from checkpatch.pl:

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
+       volatile uint32_t       *wb;

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
+       volatile uint32_t               *ptr;

'wb' field from 'amdgpu_wb' struct &amp; 'ptr' field from
'amdgpu_mem_scratch', is not used to access h/w directly, neither they
are shared variables, so volatile is not necessary
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
How did you come to that determination?  Both are GPU accessible
memory allocations.  The writeback (wb) allocation happens to be in
GTT so it's system memory, but the the mem_scratch allocation can be
in device memory.

Alex
</pre>
    </blockquote>
    <p>Hi Alex,</p>
    <p>Thanks for your feedbacks!<br>
    </p>
    <p>Commit message is misleading, I presumed that this volatile
      modifiers are used for monitoring HW status registers due to
      external events &amp; for some shared variables -&nbsp;<span><span class="ui-provider fy b c d e f g h i j k l m n o p q r s t u v w x y z ab ac ae af ag ah ai aj ak" dir="ltr"> may be volatile might be needed for *wb pointer
          variable - as they may be used for caches in between (on
          surface level info), can we split this patch into two, I felt
          volatile for *ptr is unnecessary as it is type casted with
          void type&nbsp; [(void **)&amp;adev-&gt;mem_scratch.ptr); in
          amdgpu_device.c]- Any advises onto this please?</span></span></p>
    <p><span><span class="ui-provider fy b c d e f g h i j k l m n o p q r s t u v w x y z ab ac ae af ag ah ai aj ak" dir="ltr">Best regards,</span></span></p>
    <p><span><span class="ui-provider fy b c d e f g h i j k l m n o p q r s t u v w x y z ab ac ae af ag ah ai aj ak" dir="ltr">Srini<br>
        </span></span></p>
    <blockquote type="cite" cite="mid:CADnq5_NcEr3=bDoSo5_YYYuNAMps655fcOuUDaAPmw3_QDwQNQ@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Cc: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Signed-off-by: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a046160b6a0e..06f79a84ff4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -502,7 +502,7 @@ int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);

 struct amdgpu_wb {
        struct amdgpu_bo        *wb_obj;
-       volatile uint32_t       *wb;
+       u32                     *wb;
        uint64_t                gpu_addr;
        u32                     num_wb; /* Number of wb slots actually reserved for amdgpu. */
        unsigned long           used[DIV_ROUND_UP(AMDGPU_MAX_WB, BITS_PER_LONG)];
@@ -621,7 +621,7 @@ int amdgpu_cs_wait_fences_ioctl(struct drm_device *dev, void *data,
 /* VRAM scratch page for HDP bug, default vram page */
 struct amdgpu_mem_scratch {
        struct amdgpu_bo                *robj;
-       volatile uint32_t               *ptr;
+       u32                             *ptr;
        u64                             gpu_addr;
 };

--
2.25.1

</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------ItezspT227fV0y8tpGW7r2F9--
