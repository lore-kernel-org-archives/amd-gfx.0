Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8ACC0015E
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Aug 2023 08:42:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BCD610E5D7;
	Thu,  3 Aug 2023 08:42:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0E4410E5D6
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Aug 2023 08:42:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sb5mAYmmGekFBeChn+J5iqUwqQrj8G0R3de4P5d3owTiU9y/gs9l4dIjJOQxDhGt5t5ipefwbC++6LLHEM60HsWfUzmQF61bGoDhDZn1pezIfSk2fGEUcH91KoD2RpMrxoe8t/LN2cKm3M18yf94kNjqDPtDcGpUEaxQeUdV4o2g+p4adSr4IdxrHEjyj5UhH+MAIjh59RBmDqr3QbznFb+VGxXXM4nbP56XUgrrAScH+HgxcLpSDiJhve4Bq/iLzDeMwM4VoBhmOa+qPwNzkdqnWl3ErNESAD4fPo7+03MSNaLbawJhEBDQrbBWgbPgpg6laA/yofjgKKJifXMf5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJYAruDn0sa/aebjwVQqFnGmT9QCbCVBlO70lCT7GsM=;
 b=fp+6KlI7FlVt4nGVzxF5sMaPxbuPpM1tlmuCfr3mIv5QkaNB8WZK/fOe2nKUwN+vhU3eQe8fRAoecsLuJWBcVRLRdYBFwKYBcvxdcUlejR7gAKhrsvCptidl9sRRuo5e6VTQJR1ufKHwUTKzgyh9R0HavLgO/sw0uyxVvrby5tmmd83AFTGKc3cpXCkfsoWZ3Tx7Hm9YlCI0zmPgm7WBFVQ4jZdDCtce8AoXhGTnybE4B3cu+fp01AQ3HVheJXz+i/kmETuDXABlxQblyJF8dn0Azfii4pPbl4RKqjNRQf9Wp0FEDp1lTd1Be0En35cVWKvPPzvkcqgJRlK5KPKP4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJYAruDn0sa/aebjwVQqFnGmT9QCbCVBlO70lCT7GsM=;
 b=lgbxP2mmGIM/NXzVx/b68Y/e5vd3Mzzdilae19tNuCx6FzxjTQ1anS+qkb9Bde+a8+njgglWuCmIIs1ZdQSTshGxDrEW6hPvJ7/a0zDtE56CbznDPFisR7LXRYjI5Czcks+Yd0Nv6UAjFI+vjuM/sC6RhsttQroW+Xi/H6nyTbQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by IA0PR12MB8350.namprd12.prod.outlook.com (2603:10b6:208:40d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Thu, 3 Aug
 2023 08:42:50 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81%4]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 08:42:50 +0000
Content-Type: multipart/alternative;
 boundary="------------2Krwn1pCGpYWw0Ta5BgZ2n0b"
Message-ID: <af0efe19-e78c-2a8c-96c3-ddec10a62cf4@amd.com>
Date: Thu, 3 Aug 2023 10:42:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdgpu: Remove volatile from 'wb' & from 'ptr' in
 amdgpu.h
Content-Language: en-US
To: "SHANMUGAM, SRINIVASAN" <srishanm@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
References: <20230724155418.2179209-1-srinivasan.shanmugam@amd.com>
 <CADnq5_NcEr3=bDoSo5_YYYuNAMps655fcOuUDaAPmw3_QDwQNQ@mail.gmail.com>
 <f8c546b3-669b-41dc-bc35-c7fef96ad4e4@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <f8c546b3-669b-41dc-bc35-c7fef96ad4e4@amd.com>
X-ClientProxiedBy: FR0P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|IA0PR12MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e6b55aa-1592-43da-b076-08db93fd9eb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3mLfImEYQ82XYaKI46fSMcYpObJ1XjbVXe3I7fjRd41VQFOGyhzshEkYj2TYQXlsRF4h2sew/Cn8PEYTG5+1etwSa5gmlqp2MIoFnTvfiTuXfJGsAyruK19N1x8O5QD4kA9UIj104z/zBC3Jt5OKMSQcpM5VFSOEYbJa8RcvRq1uoEMQC09Oi6CuZNg4Ag94PuxPiikCBu4DQCFzByIMy5Omp28ys6GuPRUFIIfMgkxOorDObEa0sSDjzqk7vqYzeX/5V7cAuEiSaXUDtSTthTmrjSsbzkOka1b+YOHOt+zwj79/3I1Mt/PNQ8oKB6Crz/MG14ho6c2bZQi7K/c8LdqqKq1w+VcnE8/1tWSs12zsGzx9iTuFpjGNU3Tty5OifpxQBuujHbU48Wn3/Vdw9i4J+LmeLKBY4voG8eOs0owdTIO7PndU2/9JCUInjRAVZvJq001T9PWlY16slIdWY70KeWy2Lm3ZWlyafb/emdQJZDp1TtjGnyTSkItG1EgnjeBx5Cn9slRyLO/iyCw0BbgQ4kr+gao7t3zcCy0PfV2KfUMAKHnhIAW3Y61voK9mnVFPPniLO25OiI/J8H8sHT7wtwnaaDZXH9BxZGcTiPPOgpKJTAI1OoIrgROhnHQWtD+nzs22QTbNwdMn7yobjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199021)(478600001)(66476007)(66556008)(66946007)(2906002)(4326008)(6636002)(33964004)(6486002)(86362001)(6666004)(31696002)(6512007)(36756003)(186003)(66574015)(83380400001)(6506007)(38100700002)(2616005)(53546011)(110136005)(31686004)(8936002)(8676002)(41300700001)(316002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzRXZ2lrUjI5ZWJOUXdDUHIvaU05dE5ZYktLWk9EOUQ2TmlQdGgwcWVGWkNO?=
 =?utf-8?B?WFAyZ1N3dVFMVGVmc3g1aXJsYjlJNUxtTmI0K3EzTGFtY2JsM3FISXFXUDZJ?=
 =?utf-8?B?aXMvekk3RkNVOTRzQkhacnIvZERuV3B5NFZxTFpERDI1SDQwRStMMHpaR0cx?=
 =?utf-8?B?QUdNZlJJa1U1U1JielBiZTI0YVI2M1hjcmNQOFdxZVlkdktnUFJOeW50dEdO?=
 =?utf-8?B?eVFMd3pOYks3eUdLRHFYbk94TVJZSUVxVktYTmlSb0VmTjd0dlJoejJoTmgz?=
 =?utf-8?B?UTBiVnVkVCtYZ3MvOEg4RzBBSzlGc1FZMW1NbG9JK2FqM3MxQXJYWmZDT1N6?=
 =?utf-8?B?UFVVUmM4bkQxZDdPcSs5WnBJaExRY0lwelM4MFR4V2Jkd3pDQjZaUVRndWpq?=
 =?utf-8?B?MjlaWW9DSS9DUHBNcDUyUTVRSUM2R2lBT2w1WnlGdllSNHpaV2xmaVB5b2Rx?=
 =?utf-8?B?bkN6MTZuZEthRmloeW80cnF6TVhPL0x0TTZ3SElObFdjRkJqMHBFUEMxWWto?=
 =?utf-8?B?eGJWS0lzbjBnTDk3aTBTZ09hTmFZcjZTMFNUMk8wWXIvRHY2Vzd4R29MU1ND?=
 =?utf-8?B?N0xQRXNLaXhDWjJsR2ZFQVdmZWoxMW05V2x5NVNWMUw3TFAwVTZnNnNNSkdv?=
 =?utf-8?B?WE9BS0JVN1RGV1graVhFK2tHdVd0K1FDWlBwVHRRT2h2Nkc4a21YQkZXbjdh?=
 =?utf-8?B?TnQwN3lpTHhWbHZBTEtHNjRUc3NJcHlLdG9xYlRFdmRuT0dvMkFUaGNGOUkw?=
 =?utf-8?B?c0xrd2hxT0hONVRuaVNqWnBvTkZnb0ZtQitiUlpBcnZ2bGdSclVsTUJJL3h2?=
 =?utf-8?B?VlN0LzRKT09VaGFyUXVINmdUQXVtT1hGcUtJVGZFYUs4eDkwdXBlRVNyRTFr?=
 =?utf-8?B?amxpTUMvTWRUQ1c3MC8vdFhsZmVPM2V1Rm54OWx1NTQ1dGorQy85bWxSM01D?=
 =?utf-8?B?NlVta1R6KzVGd0dTMm02Z24zSnFUNEpLVHI5eVg3YkdXV1hRRU42U2g2Unp1?=
 =?utf-8?B?T3BsdlMrdW1JbVlNejRoM09BU1p4Z3BsUDZ1TlljZ290aDM3WkI0ZHdJamNB?=
 =?utf-8?B?Z0drMmh6UVRtak9JNjdzbjAvbG9naEpWUFJPakhYeDJJOUV3MzBMS2Q1N21h?=
 =?utf-8?B?T255S3VTbjJRdW9VT2gxcFp5V29BQU5FaGM4d0xMeWNKMTQ0N25jdGJKcGlv?=
 =?utf-8?B?ay9ZRGJFT0xrUjJCV2hRU09WM0VFaTN4WGVjSVliVTRNdDhOUkpVcG1LNE5D?=
 =?utf-8?B?Q1hHZ3FHWmpOZGJTYjhOU21NdVVRcDY5KzJnTGRTR0RLRjBYRnlxQVczKzU2?=
 =?utf-8?B?V3RuL0JTK3M3d1pDbDVGTlRUUTlzTVJIODk0UXdEL0FSclFScHQ1elZEVTd2?=
 =?utf-8?B?OWo3U1MyRmlGL244V3lZVG5hZ094SmZwLzgwVlpUU3lMM215cUJ3TG1zdmhL?=
 =?utf-8?B?ZUNPZWpqWXh3dldzZnJ2eldjN3U0OWJiSGpoRlY4ZDNaU3Y3WDhvd3NiQWk5?=
 =?utf-8?B?dmR1YWt2dUNtbVZHRmZvZnNnNnovR1hETGRFMkVraEZaam1VRzhOT05RejVC?=
 =?utf-8?B?NFh4eHNRMnh5dXlxVEF4UFNUSUEzWXJtYnhIUldQdjBKM3dKYkZoU0U3R25R?=
 =?utf-8?B?UFN1KzFGMzBwQ1pqSExGcTFaaHR2dUlaeXRzMXlvc2F3V0ZBZmxLSGpHWXl4?=
 =?utf-8?B?R1A1a0x3UGdzZUdWTkh2LzZPYTVzbzM0TjM5cG9xMHlpd3BlRXVpVGNiWjFJ?=
 =?utf-8?B?Ni82K2Q4YytaVTRWbU5rYlUvY2pUR0pIOGpJYnZzYVFBdkE1bFYvdnY4eFZF?=
 =?utf-8?B?OFRjRmxLYkRFTTJnY0JLbERvMndxNW1wZTViSERIZnpMVlpqK1dKd2Y3T2ZN?=
 =?utf-8?B?MXY4UVIwcVYwY2dNTFJ6SmtXc3ErSlpKOGRJeS9DR0JZRkkzZGNiNlp6YWhF?=
 =?utf-8?B?WDcxVjZPTGFoYnk3SVdYaFV6b2NSUXhwTEtENENrZDkwS3dBdzYwbjdqMFpD?=
 =?utf-8?B?ZFBHZ3lnNjVTSDFTOEJ4SkxteFdoTDRiaVpvQzRObHNUWWVDcDRmekdETGZG?=
 =?utf-8?B?eERZanRzQ1ZOYVZUb1JvUXpodDdxcHFBeWk0eVY3VlhPZGVKRUx1bTMrc1ZL?=
 =?utf-8?B?MkJ4ekFuUmFzd3hsbXlzT01MNzM5aXFyMGhNdUNuMnFhSnlWT3E3MVh3RGxw?=
 =?utf-8?Q?Byi7iy60QbQB+34J3MAKymxtbYIqlqIzkzt/56k7DzRP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6b55aa-1592-43da-b076-08db93fd9eb9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 08:42:50.4102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QR3XYt9I+ipaQNXg+cAZuPqsPnoFzsUa+FcIYY1xzBG/8Ai6pFL5MG8O9m943q9a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8350
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------2Krwn1pCGpYWw0Ta5BgZ2n0b
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 03.08.23 um 07:23 schrieb SHANMUGAM, SRINIVASAN:
>
>
> On 7/24/2023 10:43 PM, Alex Deucher wrote:
>> On Mon, Jul 24, 2023 at 11:54 AM Srinivasan Shanmugam
>> <srinivasan.shanmugam@amd.com>  wrote:
>>> Fixes the following from checkpatch.pl:
>>>
>>> WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
>>> +       volatile uint32_t       *wb;
>>>
>>> WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
>>> +       volatile uint32_t               *ptr;
>>>
>>> 'wb' field from 'amdgpu_wb' struct & 'ptr' field from
>>> 'amdgpu_mem_scratch', is not used to access h/w directly, neither they
>>> are shared variables, so volatile is not necessary
>> How did you come to that determination?  Both are GPU accessible
>> memory allocations.  The writeback (wb) allocation happens to be in
>> GTT so it's system memory, but the the mem_scratch allocation can be
>> in device memory.
>>
>> Alex
>
> Hi Alex,
>
> Thanks for your feedbacks!
>
> Commit message is misleading, I presumed that this volatile modifiers 
> are used for monitoring HW status registers due to external events & 
> for some shared variables - may be volatile might be needed for *wb 
> pointer variable - as they may be used for caches in between (on 
> surface level info), can we split this patch into two, I felt volatile 
> for *ptr is unnecessary as it is type casted with void type  [(void 
> **)&adev->mem_scratch.ptr); in amdgpu_device.c]- Any advises onto this 
> please?
>

Instead of declaring pointers we should use READ_ONCE()/WRITE_ONCE() 
when accessing those values to make sure that the compiler doesn't do 
any nasty things.

Regards,
Christian.

> Best regards,
>
> Srini
>
>>> Cc: Christian König<christian.koenig@amd.com>
>>> Cc: Alex Deucher<alexander.deucher@amd.com>
>>> Signed-off-by: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index a046160b6a0e..06f79a84ff4b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -502,7 +502,7 @@ int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
>>>
>>>   struct amdgpu_wb {
>>>          struct amdgpu_bo        *wb_obj;
>>> -       volatile uint32_t       *wb;
>>> +       u32                     *wb;
>>>          uint64_t                gpu_addr;
>>>          u32                     num_wb; /* Number of wb slots actually reserved for amdgpu. */
>>>          unsigned long           used[DIV_ROUND_UP(AMDGPU_MAX_WB, BITS_PER_LONG)];
>>> @@ -621,7 +621,7 @@ int amdgpu_cs_wait_fences_ioctl(struct drm_device *dev, void *data,
>>>   /* VRAM scratch page for HDP bug, default vram page */
>>>   struct amdgpu_mem_scratch {
>>>          struct amdgpu_bo                *robj;
>>> -       volatile uint32_t               *ptr;
>>> +       u32                             *ptr;
>>>          u64                             gpu_addr;
>>>   };
>>>
>>> --
>>> 2.25.1
>>>

--------------2Krwn1pCGpYWw0Ta5BgZ2n0b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Am 03.08.23 um 07:23 schrieb SHANMUGAM, SRINIVASAN:<br>
    <blockquote type="cite" cite="mid:f8c546b3-669b-41dc-bc35-c7fef96ad4e4@amd.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 7/24/2023 10:43 PM, Alex Deucher
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:CADnq5_NcEr3=bDoSo5_YYYuNAMps655fcOuUDaAPmw3_QDwQNQ@mail.gmail.com">
        <pre class="moz-quote-pre" wrap="">On Mon, Jul 24, 2023 at 11:54 AM Srinivasan Shanmugam
<a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com" moz-do-not-send="true">&lt;srinivasan.shanmugam@amd.com&gt;</a> wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Fixes the following from checkpatch.pl:

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
+       volatile uint32_t       *wb;

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
+       volatile uint32_t               *ptr;

'wb' field from 'amdgpu_wb' struct &amp; 'ptr' field from
'amdgpu_mem_scratch', is not used to access h/w directly, neither they
are shared variables, so volatile is not necessary
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">How did you come to that determination?  Both are GPU accessible
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
        external events &amp; for some shared variables -&nbsp;<span><span class="ui-provider fy b c d e f g h i j k l m n o p q r s t
            u v w x y z ab ac ae af ag ah ai aj ak" dir="ltr"> may be
            volatile might be needed for *wb pointer variable - as they
            may be used for caches in between (on surface level info),
            can we split this patch into two, I felt volatile for *ptr
            is unnecessary as it is type casted with void type&nbsp; [(void
            **)&amp;adev-&gt;mem_scratch.ptr); in amdgpu_device.c]- Any
            advises onto this please?</span></span></p>
    </blockquote>
    <br>
    Instead of declaring pointers we should use READ_ONCE()/WRITE_ONCE()
    when accessing those values to make sure that the compiler doesn't
    do any nasty things.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:f8c546b3-669b-41dc-bc35-c7fef96ad4e4@amd.com">
      <p><span><span class="ui-provider fy b c d e f g h i j k l m n o p
            q r s t u v w x y z ab ac ae af ag ah ai aj ak" dir="ltr">Best
            regards,</span></span></p>
      <p><span><span class="ui-provider fy b c d e f g h i j k l m n o p
            q r s t u v w x y z ab ac ae af ag ah ai aj ak" dir="ltr">Srini<br>
          </span></span></p>
      <blockquote type="cite" cite="mid:CADnq5_NcEr3=bDoSo5_YYYuNAMps655fcOuUDaAPmw3_QDwQNQ@mail.gmail.com">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Cc: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com" moz-do-not-send="true">&lt;christian.koenig@amd.com&gt;</a>
Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com" moz-do-not-send="true">&lt;alexander.deucher@amd.com&gt;</a>
Signed-off-by: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com" moz-do-not-send="true">&lt;srinivasan.shanmugam@amd.com&gt;</a>
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
    </blockquote>
    <br>
  </body>
</html>

--------------2Krwn1pCGpYWw0Ta5BgZ2n0b--
