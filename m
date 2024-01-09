Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72AE0C4707B
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jan 2024 19:55:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C15710E510;
	Tue,  9 Jan 2024 19:55:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1852810E510
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 19:55:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XF2fvco/Ul0wfJH8GEw+gi8XI6G/QKC+1e0ZINOOK+Dicxe3Sw3UJRLutwXTgePpGaGbpazRLeYHmN7Uh+Ty/rmQ5B4rMh87ddwqNf3Ei4UPftPzgPpZfcZVD7xCUrDwS6XJB0yaThE3wJFtKC+MsqBlG1fzl1ttTqEDP9goZ/J2bcPHPk2u3gJtfd/dkft5aTk/DCang9Kse9hQicXptB2OFGJ+tcu8pgp8K3PiBQY0zdSaBqnqyx5T+NuC+cHHd3lXef8elI9q8MOYqD4fR5C5FJFXJwvhJGyyHBK/kEJnZTPa1a1LOrYuW2p3UNrInj9xzpxKMHhvL8OqoeCVLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7ExeyVJg8Qkec9DpSNMdWKJW2ZX3f6h8igAMVJq5NI=;
 b=FELQALM0Wn870rq16a7XyLwyi3HAZeGRnPGuSdg10vo0x2WcJ+rrCIvPFwVp5SOqOCJoaUVEYt3tnfHgqsIxXoCMir0tT34TxNbuOqqAwXRAVqCmx2rP+Vj+cNO0Ba8tBLRP90f7s2NT59F/+1+MQ04+YZem2pmqDc11Lsu8dkdHxf3cVa+tHJXeBkN1rCLirxb4VThWuxbLOchoFPJGqk0FTNh9vsIUC0Q7CUkIstIdCwcZJfueLrirdFlC+f6/s/ArJ8vq306NMjGUabiLIAqzALNbQYrq+I419p8NxJRsM6ojtJ2H8VXIRJzBDddxRmRjR6rmVF4XCsMVXTGN5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7ExeyVJg8Qkec9DpSNMdWKJW2ZX3f6h8igAMVJq5NI=;
 b=H022ZuzyylCqx+wbtavvTdr0QLHPoPyMQbUXlxzGSqyZOlE1zs0GZveGRJeBrtO16xe1R5JDLkVKW+JJrSWwASC9VADwF7IAxGJyNS3BE7aYipLRst7Z7iy+jN1hRqlrDkmnFx+wmoRzNXbsV2ageoCGIUq0UfOZIwPsoxr8lW8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by IA1PR12MB6041.namprd12.prod.outlook.com (2603:10b6:208:3d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 19:55:41 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::766c:af4:a36c:2c79]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::766c:af4:a36c:2c79%3]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 19:55:41 +0000
Message-ID: <4bafabe1-a5e0-26e5-8e85-ec4d6aa00ff1@amd.com>
Date: Tue, 9 Jan 2024 14:55:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] amd/amdkfd: Set correct svm range actual loc after
 spliting
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240108223651.14997-1-Philip.Yang@amd.com>
 <ba63e6cf-8162-1d99-00d6-62e4165a6b04@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <ba63e6cf-8162-1d99-00d6-62e4165a6b04@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0183.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::27) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|IA1PR12MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e39216b-55b6-4fb2-a657-08dc114cf54e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gjB7OBpiIytgSnFyb7cHuh6RzWqJrb8e5L6sruR+o5xne4UrRavFKfuYab3GAJ6SiO5LphIR/wCjgfy18S3aqZ3rxPGSDiD99oiuPrPcJZDdWVwDLwrJrc7RT9hOLf7noRUS4YbZYT73wB/XXWkE5UT1mw1rTKL1HMG4vFxrNZhSQB4ZscyN+TrCJW/KbQgo7T2PA0ca+rjGwOskNk5g7J3UOjHO4FXAiG3jEajQKALkOFSpsZWYmEphs9eb4eqskgEofsmwCo6jF2qry6AE0g7ejBsfw+6MKlnnWVbbUW03HOplOjTE3rjqIwOZBDlaLRjGuhvyleWK6hOgQo+Y3c1TS5+9aIm4RRHC8Qdp2ExWtSkg8Ep4j6kuccySyCTZmnWk4V1KZXf1sHqQfH/v9rz6kpsvNopaqRjzPtc8SNQr2L1H50LEBcCM6k5s6RkBFyVDvCOZQr7sYbOM90q//kkecV8O8SxlPtM2Tp9ZZimToeQOLS7QrZM0IHVmSWWfsliCHsxFoQcnP5grE0k5fSUcPB0IQran7oA1Ok2h9hQRUpR8psLR+lJqfvcltPfWKL7Xnw6RgzfUr+4rlgCEtE7Y11ucAopIzE3/2GQQ2oXCBZ+5blxgjEDi7KVYG++//GEsMwm19Tz6zG8STv1G9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(136003)(366004)(376002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(2906002)(5660300002)(478600001)(4326008)(41300700001)(66946007)(2616005)(66556008)(8676002)(36756003)(110136005)(8936002)(66476007)(316002)(31696002)(6512007)(6486002)(6506007)(53546011)(26005)(83380400001)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW9lUFlNZTdNTXJFMUdzTU95Z3B6b1h4K2xCVHhYQ3JCYzhTcUlHQmcxMTdk?=
 =?utf-8?B?QnZwbmVDOEc5amxPY2hBdjN4bmhOeDVvanFnWVF4U1ozS0JSR2ZCMnRtUTFQ?=
 =?utf-8?B?WWVJSUlQTk9zdUVWSDl3dFhSdU9CRXJlMG1XaHdFNXE0V0FqYXBSM2traU43?=
 =?utf-8?B?UWFCUlN2N0xuNzQvcmx2WnRiRHlacjgweEM3ZTd3N0FrU3BodVVQZnMxOUI2?=
 =?utf-8?B?MGxaTG5ZOWhFV0VzVnRjbW9hVERUWUlxS3F3V05DeldKZnlhLzE3SEx6WjVa?=
 =?utf-8?B?UG5acGR5YWEyR1hWVHl2V0dnKzc2OVZEM09Fa2ZBNHNadUw2Sy81Y3U4cE8v?=
 =?utf-8?B?eGhCKzdUOFNhbDJDT1lxaU9CSHRxdFVLTldFbm1sQmVqSFF5azJWV0FEK1Qv?=
 =?utf-8?B?T2FZbUlieUJwQmFiRzY2NFJkd0RqcGY5UWNobjliNnRmVk43anAxYkRQeFha?=
 =?utf-8?B?NDAvdkc4VFVlMGlhNnlXVDZpRTE3Y2NNajZ6Yk56THEvYmVLd3JaRXVPVkVN?=
 =?utf-8?B?QXpnWnJGSXpVSnljSzFyemxodnlOMXM3N0oyWW1aZ21Bc1FmdEg2ajBPanV0?=
 =?utf-8?B?VXg3M3U2RmkyMW1lbkZPeXNjd2tEMHNPZlU4R0dHZ2twb00wTDB6cVhEYUpi?=
 =?utf-8?B?VGE4dU91SFNvMmdoVEkyam52MzhXS1hMVEdlNDFIVDFUQ3RUNlZMblh4bVdo?=
 =?utf-8?B?U1JEQzE0YnNPeExGVnBRY05mTXlrSS9uM3dycFp0Y1QyOGR2MGlyYndidEt4?=
 =?utf-8?B?aGh2Ky9DUWZQR3B2QktMZ3hZRHd4Q0FaVXB2ZVVUclJhVWp5bVJ5KzNmVXFh?=
 =?utf-8?B?S2ozZXNvME5UVmdCZEdtM0s2cE9FT0QyNFlUWlNWaU10bmtlV3hLU3JMbTU4?=
 =?utf-8?B?Q0hvMmVnU2w1aFZ1NFRXdDI4ODYrbjE3NlFjU3FEalZHbXRXNjdhZ1FwSkZj?=
 =?utf-8?B?ZTU4bHJ3UzZhbUM4cHZhYjlmVld6UFlHSG5JVVZXZ3JJNFpoSEtkMk1mR09R?=
 =?utf-8?B?OVdlUmYwakdVOXdpLzFqWXZGRkQ5ejIxazZ1RFR1T0VPR1M2WDBiM2YvQ2tH?=
 =?utf-8?B?cjJ4QjJ4VHhlMmFFZmNiaVM0YTlRRDhKa0tZZ1hzT2xhVVRUMlVhR2N2SWg2?=
 =?utf-8?B?V0tmbFZYZ0lrRXBtQ05UTkJabDdSVlpsc1RON0d4WmlOYXpLNVdyY1hYaUFO?=
 =?utf-8?B?bXJTNGt4bHppamdpZDh0Q24yeVlJbmRMa1ZGSkxlZmtqTzVVRDgvUE9Vb1hX?=
 =?utf-8?B?Myt1MVlYUEdidFl1NC9IUTIyMUJLa2FvNGZqdHJTVGsrMXZsRHc5WW83SXRx?=
 =?utf-8?B?cUJHY2pzbi9XUGdGcFU5QWE2Mlk3VTEzdGE1clY1MXJCMEtkT2tpNDBCVVJp?=
 =?utf-8?B?cTRjUENQaVY3WGZGVjRJSVhWMEdCbit6R3cwd1B4dGE2aFBGZXJJWDl5NkEy?=
 =?utf-8?B?SDJCc2VJaytYOHNYcVJGamo3Rk1YSVdNeVpwN1h5L3NqbHFlNUsweVN2dXcy?=
 =?utf-8?B?bE9iSEFWbTl5dE5Ya3d6TEZyOUMyNTc1YUR1cGxES25KeWxBYmpFbzJPQWdH?=
 =?utf-8?B?MEJ3aU92VGJCNGdOZ1ZMMXRXVEpQaURyVkJzeWZYTW9Uc2N1NEVna2hvc0w1?=
 =?utf-8?B?UGQ5Lzl3Tkl1em83V3prcUxrNXNZVzVjS0t5dkNkdENjd2lpVmdNWjF1Z1VS?=
 =?utf-8?B?d2RscE9pVWNWb3NDM2kwaGR4SWcxTzM5STB2VmdlRGdOWVoydEJ5Q1NpRjhZ?=
 =?utf-8?B?VlRRYzRQcDZDS080NE1RV2xqdkNnYnZBT0pHb0trT1hIeDY2bG5FczVrZnZu?=
 =?utf-8?B?TFhtdXdhSFA0bmgyMm9Db3FGbUNwQTV5b1daZndSOSszekhIQm1WMkFUZGEv?=
 =?utf-8?B?Vk5CRTZtZ3hKM0RRUXB1b1hYcHlIRjlvWDExSHM0aThBdXhKNHMyYzlFOTQr?=
 =?utf-8?B?cVlhekVUdERBTFBJY3RiejFQZ3p0UVNhL2JNSWo3VkdKalVEb01wYXZ6K2FY?=
 =?utf-8?B?bGFhSmFDd1JzV1dNQmRwNnBaNDFSNm56bElPWkJ1Z2FNblZRN0lCYkNBVDU1?=
 =?utf-8?B?WWtMWXFBcFRvbUFiSE9TdTlQWi9oR0FPdGVzOWZVa1pEdVdOWWhsYTN3amdW?=
 =?utf-8?Q?GvG7CS/8tetk4JaRekhpI20+V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e39216b-55b6-4fb2-a657-08dc114cf54e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 19:55:41.2589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4TEvd8E0EJeTNYqYlAUwmN0mK4s5LuKDfFQmalem/jaDg3sqWMzHFZswyn1WpBKY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6041
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-01-08 18:17, Chen, Xiaogang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:ba63e6cf-8162-1d99-00d6-62e4165a6b04@amd.com">With a
      nitpick below, this patch is
      <br>
      <br>
      Reviewed-by:Xiaogang Chen<a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a>
      <br>
      <br>
      On 1/8/2024 4:36 PM, Philip Yang wrote:
      <br>
      <blockquote type="cite">After range spliting, set new range and
        old range actual_loc:
        <br>
        new range actual_loc is 0 if new-&gt;vram_pages is 0.
        <br>
        old range actual_loc is 0 if old-&gt;vram_pages -
        new-&gt;vram_pages == 0.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 8 +++++---
        <br>
        &nbsp; 1 file changed, 5 insertions(+), 3 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index cc24f30f88fb..cb09e1d3a643 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -362,7 +362,6 @@ svm_range *svm_range_new(struct
        svm_range_list *svms, uint64_t start,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;prange-&gt;child_list);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;prange-&gt;invalid, 0);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;validate_timestamp = 0;
        <br>
        -&nbsp;&nbsp;&nbsp; prange-&gt;vram_pages = 0;
        <br>
      </blockquote>
      I think it is better to keep it, also:
      <br>
      <br>
      +new-&gt;actual_loc = 0;
      <br>
      <br>
      though not necessary as prange is allocated by kzalloc, just keep
      consistent with previous statements, or remove
      <br>
      <br>
      atomic_set(&amp;prange-&gt;invalid, 0);
      <br>
      prange-&gt;validate_timestamp = 0;
      <br>
      <br>
      too.
      <br>
    </blockquote>
    <p>kzalloc memset prange to 0, we should remove unnecessary 0
      assignment. prange-&gt;validate_timestamp will be removed
      completely in the following patch.</p>
    <p>Will send out v2 patch to fix other related issues.<br>
    </p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:ba63e6cf-8162-1d99-00d6-62e4165a6b04@amd.com">
      <br>
      Regards
      <br>
      Xiaogang
      <br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        mutex_init(&amp;prange-&gt;migrate_mutex);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;prange-&gt;lock);
        <br>
        &nbsp; @@ -980,8 +979,12 @@ svm_range_split_pages(struct svm_range
        *new, struct svm_range *old,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        -&nbsp;&nbsp;&nbsp; if (old-&gt;actual_loc)
        <br>
        +&nbsp;&nbsp;&nbsp; if (old-&gt;actual_loc &amp;&amp; new-&gt;vram_pages) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; old-&gt;vram_pages -= new-&gt;vram_pages;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;actual_loc = old-&gt;actual_loc;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!old-&gt;vram_pages)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; old-&gt;actual_loc = 0;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        &nbsp; }
        <br>
        @@ -1058,7 +1061,6 @@ svm_range_split_adjust(struct svm_range
        *new, struct svm_range *old,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;flags = old-&gt;flags;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;preferred_loc = old-&gt;preferred_loc;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;prefetch_loc = old-&gt;prefetch_loc;
        <br>
        -&nbsp;&nbsp;&nbsp; new-&gt;actual_loc = old-&gt;actual_loc;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;granularity = old-&gt;granularity;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;mapped_to_gpu = old-&gt;mapped_to_gpu;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_copy(new-&gt;bitmap_access, old-&gt;bitmap_access,
        MAX_GPU_INSTANCE);
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
