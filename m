Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93005C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 16:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23FE710E02A;
	Mon,  7 Mar 2022 16:02:17 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC47810E02A
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 16:02:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDvfiJ/8S0Zao4Jniez24DWGPmxa1VmaU48juRDLuiDZ3eAw8Y1cqoKMeXMrFDTLSMFznlzKfYHEACDFiwf1b/T4dCPHTpJz07ztQ0nuMZuF0UpXIEK/ku1ECt11CrZfjatxu3phk69rPBjaAQdK6e2auSXdNueSy5W0fB3cHK/ZPCyKB+HN9BsZigbiWTF0UYafDnjjyrOd1rhi+K2hhpoBmiAT4SUVSMj3wDLDrSDz8cBlg2VxUFy+GdKOApGmrRy5D95r28IsR2np1hBUC4m5WslroplDZ8PF/FLCpNfTvlxjdb/eCwgc8qOd+fz8gAkiW41nXMwKjy5ebQXjTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yk4GVvmBPwu39xZQb7fB4qJihJwMK6ZoWV3L6DcHnX4=;
 b=F+Dt8I7CZIlPj1PEJ5WCkvnJKc/bN1xMqguJcJtF71fVwmzwl3gCRKHTobMtH5riSZoM4z7e/csoP0I7VDw2rNmr4EINDOk6ns8oWB3tHCyey5d6MvGZaInFK4Q9FCwvXWYWImFZsCKO9K4+IW4vwcEwcgPijNRCa0YbjUEF5pO1iZDsUB21dyNzlqLS5U0CCfIvtBNrrAhp6qPHITcWw21EwAs1Lv5xfVQ/ueUXgNeyMuXbKBYM5mbew0OSm6xDAv6ucOvB1XqztKigyhxaAbRstl2z4ndCLTr1fPfVOuwnBkG5JriJ2/tboJc665hJunu/1gVgA3XrIOL4fx0kyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yk4GVvmBPwu39xZQb7fB4qJihJwMK6ZoWV3L6DcHnX4=;
 b=MiWvDLmnvRv4iMkXFpj3nI3FqjGvNu+qDJxJD5ZQEWoFJwT2EG7gbkFnHGrBngsIUVcj3cn9jUEB3fUDjFjhTLPjLRODn8hC40dq/4APGGqnw8ZHqOFzlhvhODV+NjEiRVLXATpgYERYSCJhswpN4jUMeakhj+SSxZwf5zKTpNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by LV2PR12MB5749.namprd12.prod.outlook.com (2603:10b6:408:17f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 16:02:13 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703%5]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 16:02:13 +0000
Content-Type: multipart/alternative;
 boundary="------------gLtQuiwURh1q3BlduUSHgMHu"
Message-ID: <65135b7d-6ea0-7fb1-6ee5-7cae42423ca7@amd.com>
Date: Mon, 7 Mar 2022 11:02:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 09/10] drm/amdgpu: add gang submit backend
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Marek.Olsak@amd.com
References: <20220303082308.38217-1-christian.koenig@amd.com>
 <20220303082308.38217-10-christian.koenig@amd.com>
 <9bf49ccf-09a9-15d5-5591-ee2164c07f3c@amd.com>
 <5c573f4d-0fa8-5c01-67fe-c33a79a6f89c@gmail.com>
 <6174d4b6-7a02-ffef-ce68-ca2f13dae337@amd.com>
 <dd6839eb-da19-30fd-1422-6b0aba326e7f@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <dd6839eb-da19-30fd-1422-6b0aba326e7f@amd.com>
X-ClientProxiedBy: YT2PR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::29) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8415908f-0ca7-4677-6efb-08da0053d797
X-MS-TrafficTypeDiagnostic: LV2PR12MB5749:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB574952D800018EE1C629DE46EA089@LV2PR12MB5749.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yFZS1TviWQ/WIUOn7fAPCc2uSvkZhIoxeeffw58dhhoC3CPwMmdT5TLlTlVIv4TIiJWIbH77bgsH8Le9wazUowtdWKS+r1gfXGNIRtE9/Krq6huZGqNpLaEHPi6UW6y5gRuoKXktjhN2hAS+krLFFN5hDZ59twxyRG0TRr0iqoDFN1z7C8h/XE2CqINCalygSLZtK/IPo19xt+4+Tj0mc1M1rGf7jzkuIs0HpTJ/nGw/F9oh9hj2VtWY9nKk3+KhN4xgMyDziFQc59PggJMrhJUvMnfLWl3Pcddw5y55tKsUtZ+OUUkgWqnbqiSbmyIJgFe974yntv/NAuXZue4dlrs7CQGq2HCDJQh2chgJX0qoZt9n/qp4jVqeN5YRsfMfPu0N7Hx+s9mkwyBWCj40XjjBDopgxTNAZFDJFXo+hLzcKFNq2nuipzHY2uaY+cGy3zMlBdVqEyBbzWgt1X70sygS5RPgf+JT8b1YQjmXor0rA5vLKH4+NjrSTKWO5CyLmRpakUkfWuf7MYjeta9qs2PZ3LB1v4AnRUrIyXV1LJYmcjEcVtXIbdRq114agbcT+XaundglsJezbQ5wTXFbR+Atw6uQPRVtD80+Vbcsui8MVe5XjjjZfZlhNpbuVi4u4gHsml/MbBW4J4wq+FGhwrl6EDSNchQkzCXWDvWQYh3WtRkTdFpjtyZFURBWyd0HcKieNyjmKMppFRnSG9SCkkV1SRa2Hl8fmDqIoXMYCNAWMbwGq38qPGPj2xgc+9K2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(8676002)(6506007)(33964004)(53546011)(44832011)(2616005)(31696002)(6512007)(5660300002)(8936002)(86362001)(31686004)(6636002)(2906002)(316002)(110136005)(508600001)(6486002)(38100700002)(66946007)(66476007)(36756003)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTk5Z1BnUEhMdDRGWDFkUnc1M0NUZzFMZlhzcy9LWmMzcXlyU1VKTGVpU1JL?=
 =?utf-8?B?L3lMR0JIL0I1N1kwNmR0UjRqQ1VVaTdIUlVQM1JUdEdHR3FZSnB6cE1LZ21J?=
 =?utf-8?B?SmRCUG95OGl4STAxUWxLZzVPQVFNa2dhQTJNaDNJaFo4WGVoS1BLVEZ5elJy?=
 =?utf-8?B?N2lsZld5NUZpTEZGMjJvRXNsVkU3UkNNVm1PREgvdWVHNmJXZm1XQ0pUbk9l?=
 =?utf-8?B?T1FJQ2RRSHJWNnhQVlJHdzZGMkw5RG9GcG15ZFZWU1BFMmdXMkFHdXRaekJs?=
 =?utf-8?B?Q282KzYwRjFaTk1ZWEZNZ1BDL3RRcit4SFJPbUdsdDVqK3FySnhpTEJVVit3?=
 =?utf-8?B?UmhENnMwcWNDdk1EUlJKZytjWkR3ak5Eb0xuVVZRQ1ZxRm9UWjk0R3VQVmVa?=
 =?utf-8?B?cUY0Umtmc1BRMmdnWUk0YWIrKzRCMm5tWmkzQkpwZzFJcTZBSXJBM01hdjZQ?=
 =?utf-8?B?L3N1MDYxbnplek9BaG5pdFlBWityYXo2RFlOZ1lxVnJsbEMrRHBGVWpteXBI?=
 =?utf-8?B?UmR2T041M0RtKzZnRWJEVXUzYUdqUUFWbFUydGp4ZGhZZm9sY0dtSndiSzl5?=
 =?utf-8?B?dzVubFR4dzV4djY5TFVmVWQrTHRobkg5ZVVrZWx6aUdIdTdlMnJacWpIcDcw?=
 =?utf-8?B?Wml2dUpvenBRN2ZvZDVKWisvTWxINXBLNXhnbURhNE1FeHdrL3VrQUpDVzNt?=
 =?utf-8?B?ODc2YmdHWTJrVjZ3QTRaYU42cXhQby8zNEZ4eHhhcWZqcGw2dGl5d3ZXTms2?=
 =?utf-8?B?MUYwTml3RFhrOVZ4bjFIYlFLaE8rMzdPcnNNSEZMMjFMQStsN1RhaXBqS2VT?=
 =?utf-8?B?NWJNNlpac3JZZ2dTSWVYZEV0OFNrYXdleWtxaXoxNjF3T2ZKZnBjakJMc1Rn?=
 =?utf-8?B?c0xZY01YcHIxWnJCandBc2RnaXRPUGJQM1pkdTBYeWxuMEVJckRyY2YvVnVv?=
 =?utf-8?B?SHhaMnpGR3lkRVZtbU1hdWNDejJKRjJXbmRQUWttVkhPbVZ6SlRuSTllTjI1?=
 =?utf-8?B?Z0xPT2J0MHorNi9tWm96YXdBZGRuam13MG0vWnpqWjVKK0xIV1pIS002Vmhl?=
 =?utf-8?B?NnN5MkpuL1hXN0ZBZzNNclA5bEJYQXVNM3V6UlB6cFdTU1NkWVZJRWxJUHF0?=
 =?utf-8?B?NlVoY01KUFlrTHlBUlJhdkNMQURQbDRUU1ZKTzhQanRFL0QrcnY4aTFacGhB?=
 =?utf-8?B?N1NkbFFvWDVlMjBpZjNOdTNSR3pLR3Z0RnZDeVI4UE1iUFc1VnB0eGJzTFU5?=
 =?utf-8?B?UmF0TFFjV3B2VW5yYzVBZThEdFpzall0clBkUW1zNmVFVHcrbHc1N3BoRWRE?=
 =?utf-8?B?cERNbThPUTROSHk1U3VjY0Q3QitlYkpkcmxlMmF5MG9TalVDeWRNV3BwZXpI?=
 =?utf-8?B?Y2JBcFNQSzlvR0lFVjI0WnA1UDYvMDhYTXN0WkFqVkRqK1pFVVo1VkxLMEFh?=
 =?utf-8?B?MFNsejVIcWxMWjVrOHhJQ2IwNFkwbmpJVkRWM1VVU2ltbnlmcFFTbkE5bW52?=
 =?utf-8?B?YTNXT1ZScGdZaEZQcHdwNWNzaU5hbFBpVkFiSXF1K01odHhUZUdCV0t2SDR3?=
 =?utf-8?B?c1VOZmdWbkoxMjIyVDNxRTVwRUk0NjViTFZ3OWVvTXFFc0xFV3k4VGlLSjZj?=
 =?utf-8?B?RUg1YWo0YlpTMUM0a2lFRERjVnhkMGh6OG9yTWFMbm0rZ1hVZEdlcE1xcXkw?=
 =?utf-8?B?SmpiLy94eVNob3pPeGMyNFdyU1dhendZYkNFNkxUQ2ttWk9vQzRkUTJRYk5l?=
 =?utf-8?B?dHpJSUVJL1EzcWJJVW5aVzZqUGJ4MWV6R2N4VUtYaTFsWUJoYmxNZEdHNzM3?=
 =?utf-8?B?L3lhRUN0M0JnR3RGQWFXTjA0MklYSXMxaXZhUmtjaXdSN2VrdTljQXVuN0Nv?=
 =?utf-8?B?NmlFYXJ1QWZ5SUNhR3hhc2Y5dmhESHRvWmR6a0dGWWtPOUpBR0p5MXBQV0dh?=
 =?utf-8?B?TU4xcWZpUmgwQ3hhUXJ4bXk1bXNmZ3J2RW9aVktlZG8yMUQxeEVkckdTTGkz?=
 =?utf-8?B?WUtlZUFjbHJvUWxIT2p2TzdwSkxjNFNSeDYyWVhPWEdqaUIwbnVPZFJBMWtz?=
 =?utf-8?B?SCtFRzEydllkUWczNTJibnBGc09TakRJcTdDbXl5cVNITzZucENmdUJKWlpF?=
 =?utf-8?B?UWtjdk5kc05RUWVwdytHeWNrUDlFNFJYQnIvUjF5TkFVTUEyK3FIemZxa0ND?=
 =?utf-8?B?ZHQxTHRaRlFQUFJwS1BiUmRxaVg1WnBVWFRPbnNLU0JiemRKNFhFc1NvNUF2?=
 =?utf-8?Q?dXzzr8kYKciidC4V51JhjRt+reGxykYPLP3qUu5M54=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8415908f-0ca7-4677-6efb-08da0053d797
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 16:02:12.9095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TpxC2dLtjrlE6enUybrjtCnWBqUUucLWMPE+iNS2I6OTGiVhJZUvVn5M5ZqD/OmyZd/tu9iGrj1v3nJA4RIXZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5749
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

--------------gLtQuiwURh1q3BlduUSHgMHu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

:)))))

I am like - I must be crazy because no way this works but you insist 
that it is and I know u are usually right.

Andrey

On 2022-03-07 10:59, Christian König wrote:
>>>
>>> If we don't check for NULL here we would just crash.
>>
>>
>> But you go into the 'if clause' if job->gang_submit is equal to NULL, 
>> i would expect to see here
>> if (!fence &&*job->gang_submit*) because you want to switch to an 
>> actual new gang (not to NULL)
>>
>
> WTF? I'm like 100% that I've fixed that before sending it out.
>
> Thanks for point it out, but yeah I've already stumbled over that typo 
> as well.
>
> Christian.
>
>> Andrey
>>
>>
>>>
>>> Christian.
--------------gLtQuiwURh1q3BlduUSHgMHu
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>:)))))</p>
    <p>I am like - I must be crazy because no way this works but you
      insist that it is and I know u are usually right.</p>
    <p>Andrey<br>
    </p>
    <div class="moz-cite-prefix">On 2022-03-07 10:59, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:dd6839eb-da19-30fd-1422-6b0aba326e7f@amd.com">
      <blockquote type="cite" cite="mid:6174d4b6-7a02-ffef-ce68-ca2f13dae337@amd.com">
        <blockquote type="cite" cite="mid:5c573f4d-0fa8-5c01-67fe-c33a79a6f89c@gmail.com"> <br>
          If we don't check for NULL here we would just crash. <br>
        </blockquote>
        <p><br>
        </p>
        <p>But you go into the 'if clause' if job-&gt;gang_submit is
          equal to NULL, i would expect to see here<br>
          if (!fence &amp;&amp;<b> job-&gt;gang_submit</b>) because you
          want to switch to an actual new gang (not to NULL)<br>
        </p>
      </blockquote>
      <br>
      WTF? I'm like 100% that I've fixed that before sending it out.<br>
      <br>
      Thanks for point it out, but yeah I've already stumbled over that
      typo as well.<br>
      <br>
      Christian.<br>
      <br>
      <blockquote type="cite" cite="mid:6174d4b6-7a02-ffef-ce68-ca2f13dae337@amd.com">
        <p> </p>
        <p>Andrey</p>
        <p><br>
        </p>
        <blockquote type="cite" cite="mid:5c573f4d-0fa8-5c01-67fe-c33a79a6f89c@gmail.com"> <br>
          Christian. <br>
        </blockquote>
        <blockquote type="cite" cite="mid:5c573f4d-0fa8-5c01-67fe-c33a79a6f89c@gmail.com"> </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------gLtQuiwURh1q3BlduUSHgMHu--
