Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA7BC00140
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Aug 2022 18:20:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C6A6BFF72;
	Wed, 24 Aug 2022 18:19:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4480E94BE9
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Aug 2022 14:11:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEfoZhANV5EEGWliOgORLrcXMu4dN7WPA7mOCaBJ5/+CV2MBvUtACE/Q5cEVDJ2bMf3p7rxcyaqlGZKdP3iRI6M4jpHXI4v0gGYBrm2IufZfeGzRzidclA7lAE/CLX5jNjgGys3mMKlYsw/jgm/GTRqdTromazTn2WSxDifHVrX2kOHL1NcA4pqM110VHeLvCwEpbyx1apJSV/q1zlRgn/d5NojFqfQfqeFOgtD5gmZCNPv1JTV2BeBwx0j02HOeGQV3vw0aALYOgg09HLEGbHxHOcJjz12DwZtl/pybnLDEw2Lc5HnvM6AIcPmqiK/hrAS3Xi6UJr8g0noXp1Qa3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqiQNKRo46gWkQSFpSDmX4fUOOf6ziM85pv24nWZEOs=;
 b=JiWe7N5or+NmsxuJZ2rRGuYavpt0jshWHamBYlF2kXJvXTXRoM9suYTnwduai5MojwL+Y2LGdOitkxIWfYB2zAMPGeymd5ad3NInTMa0pjTui2dH2+02c0wdn92qpoH+J173+eWptt3kGl6MSqepy4sVqA6d/8wtuRbQgQ2wrRwt10cLEXyqTQYW6d+u6t0flYCQEHb8TtoOwr6uUjagV1awIDEqH7UsrpR6HXLIUtR3BbgYPHyaGflcNoD9bbAkYq0PaM4LvLxUYBWYbmCudT9odave6g9NWhiyJ+9/Nyb20GQCR+/QwY1AQ/bapwQNONWzO6vfouxDJaZOj1NDPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqiQNKRo46gWkQSFpSDmX4fUOOf6ziM85pv24nWZEOs=;
 b=qT1wDHHqZArQsEEuJsB1JS1orjWElZ/Eo3pOvgtclkd+uQz8OwRHTXP2vvWJDJWctoD31eqGCxU6s9ggOmHbr7txE4tvWEbx6A19iCD/LhTiwM1sYnj3A25iMFuwuATDLhdpI9U+wPOMCUMaD6AmGwxDEmcWjUblHJZCHSN1Z9Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Wed, 17 Aug
 2022 14:11:13 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::80ca:c97:d395:1acf]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::80ca:c97:d395:1acf%6]) with mapi id 15.20.5504.028; Wed, 17 Aug 2022
 14:11:13 +0000
Message-ID: <cccc19fc-8e41-f366-322a-d3c80c98bcc5@amd.com>
Date: Wed, 17 Aug 2022 10:11:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: TA unload messages are not actually sent to
 psp when amdgpu is uninstalled
Content-Language: en-US
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
References: <20220815070512.452430-1-YiPeng.Chai@amd.com>
 <CADnq5_NLzjD+4q0vF8n8JRaOf3iiGYoNN+W9K3FPLEP+_FHjUg@mail.gmail.com>
 <CH2PR12MB42155B12C1A2C1D7101EAA2EFC6A9@CH2PR12MB4215.namprd12.prod.outlook.com>
 <CADnq5_NyNxCdJOC6d0du=+AAYA13xCFVXZRjsXEJT_rXSQTm-w@mail.gmail.com>
 <fc69f557-5851-c1fa-da6c-435fdb13241c@amd.com>
In-Reply-To: <fc69f557-5851-c1fa-da6c-435fdb13241c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::22) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 761f2efa-fde7-496d-8394-08da805a57ef
X-MS-TrafficTypeDiagnostic: DM6PR12MB3835:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ITosidLpfvNaybdnfipYZL9SCu7bUbw3KzLeORVNBmYe/FKeHYhjxMq12uvEfyiUHXOdObHgcba4v6qfCBC04yt0hz0be3KMEQvLwNeXDOut226PUu4ULy6uW7Ftxy0I6Iat85p4MnTwdmcwpguRcaSS1D6ehXz+OoB+AJmVQqg+VQ1Sm8iJ0KKNGkVIGIMUHFQsOsVSQEgHJGOFlhOYvr2IOTQg/xd6dcfJBTqmN/8ydpy+NxXaPfl/IH/9ti/V6VhES3a46k7nR2LcNvsznUn4SEGSmkiKCznjxkm4SfSqIErHyzIr7vWERKmRAxN/1rmCxnwk6UFkzuUxcYdwBUcyaEL9I32pGj+IqNKgjlBTKh1j0x8xtVmDjhicL52sibdCQGwyHYo3w38YbvfrzpqEuPsFlwqrEIDfCC8KIWWzVTBk6Ar6RFB8Luwr+PzmqIeJ0Nnl/iIdHIJtLb1odim7z2NXHsLSgZZgXNu9gDFSRABrccDitf0KNHM66BHPYmx6jb8YbnLsGeCcK4uqU57Z/+G342Z/skh+wu4o+o+kDyNeIIrbWNc3rNRraKBNV2qCM49yIgYd73kJpvmqqSG6v1DnQctn7OuMYZ2ahzv7A0Jxh2SQ4guDQnRzN37U25rTkSmTWGPib8qtNRc1leqjJU+myGR/CeKHubaBaWk21sGwGKvB+eIQy/b3Uc0sPPII4w0I9c3rkFxvN8nkCSIA4NSnzSwYyIEQ653L2JS6s4RDc6kqnbEsC8bFQmC8kDVwloj2wLe1XgqT7yPfmyiIWuboMQAErLHzYSsPpDoVmFJLH3K6mOxflDtACMAyMzILSzqzAIuQiM+NzKwQOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(6512007)(53546011)(6506007)(86362001)(2616005)(31696002)(186003)(38100700002)(83380400001)(5660300002)(36756003)(44832011)(478600001)(6486002)(66946007)(8936002)(8676002)(4326008)(66476007)(66556008)(15650500001)(31686004)(2906002)(110136005)(41300700001)(54906003)(316002)(6636002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWY5Z0dKdTBjRmJpOEcwaXRMa1lodVJPYUsrek00QmhrN3RiVlV0bEZWYjFS?=
 =?utf-8?B?dlNHTFB0c1JmekNlYnNGcXgzUkkxQ2pDbjBFQ2ZqN1Q2TnJrUXFFMlRIbzYy?=
 =?utf-8?B?YkZ3bEpCTFpmMVI1VmlBLzVaYWgza0ZaMTdRU0NOdkxnbVl3aU9WODRRNHgw?=
 =?utf-8?B?OCs0SGl2SUhqd1NJVUo2YjNjR3plMVdDOTVvV3JrVU90cXNpaDBYZ2lCWEpZ?=
 =?utf-8?B?SXJ3Tm0zS3d2d3BQTnUydlljVlJheCtuYVkyUnpDU2NvK3V5Y09lREZNeDUy?=
 =?utf-8?B?WkNlRUJ0ZWJpNHo5UktNRDVOYXZIQnhSRFcxem5kQ25RdklLNWdKVzRFaTNq?=
 =?utf-8?B?Z1d3UHQwcEl0TVpkOXRjOTNhbElRZVh1a0NBbnY4aytJakQ0d08va29IS3Mv?=
 =?utf-8?B?YjgxUzI4K3B1aWR2d0hITitkVlljclAxcCtJNjZySWhaa3QxVXJYSS9RRnFO?=
 =?utf-8?B?bkdJc1NkdEIvNHAzODlKZkI2YXdoZ3dDd2hLUjlZc055NHAxdWpSaHpnQU9s?=
 =?utf-8?B?OC9PWUMxZGJBaWcyd012dHJ4RXZrM0VhbElFZE9oSklJTXZlVUM5N1BxbnBh?=
 =?utf-8?B?YjV0TWtQYnNvalpmSWFybUZ0emNLMi9TVER2blA4M0lUUzd5Q25rSTZCVGhG?=
 =?utf-8?B?bWxoOGlqdDlTQk5EMURoTHNFeXMrcE1nL24xRHh2ZDF6UlZiSy82eWxaelYr?=
 =?utf-8?B?YmxOblR1c1JrK3NxQWwxbFhLSFdQM2pEZEx6MlJUc3FhS3hzYWQ0eHJPbGVI?=
 =?utf-8?B?RTQreGZFa1o0amxBMWU4Mit2OEczZ0Jrd20xY28rRzNMcE9qUVdja3JqTkow?=
 =?utf-8?B?THlpRWdkTnJqamRWalhRZTVCVWY5YXROQndJUjMzM2ZuL2lZV3ZSSkRDMDFv?=
 =?utf-8?B?RWZockRIQWZVWnNKRTVQdXRUYXlqWDF2T2pDTlZ2VE9lcG9Oblh5MmEwQ2Vo?=
 =?utf-8?B?ZHZQeUw1RXpuUnFFWkM2dE1nKzBLNlBzWnNXcmtEMDBTUUx6STRBVGNheDY0?=
 =?utf-8?B?anJNaTI3VFVYNlA2Rm9pdG5VOWRXT0EwRFg3VzBNNkh2RWRYbFBydHQ1eW8x?=
 =?utf-8?B?MjJaV1hKc3FEMmpyN0Q4VHRsTUNyaWRQd1oxZmZ3YWRHTVpieHlYMHhidGdZ?=
 =?utf-8?B?SWQ2V01vYzRRUHpxVWhzMGN6azZqYVEwS3EvQng5R0ZrcVBValhEVERYZ0tN?=
 =?utf-8?B?OTFxbGd2ZXpWZ0g2SEVqaVoxQmdLYm4zOVI0aDFTS1pWekhMM2pLR0cxdnlH?=
 =?utf-8?B?SkpNeUxnZy9rNU04M3hDWXNqOVZRYjJaZmhnMzVPbFUwTHJtR3hOUlZYcnMy?=
 =?utf-8?B?Yi9mbGhza0pmckpVZDdzSFA2K0w4YzlSMzB1aUZVZnROMk8wRlhDbzZaMWVx?=
 =?utf-8?B?c1JFNUhNbm51Syt3SzRobWw4UjUzZUhMOWZwUUFZV29JS3dQV1czTDJiaC9D?=
 =?utf-8?B?NU9ZOVZicUxGTmZGTHIvR2RuSmNFMGlyU1crQS9kRk5zbzRpTmlDblRQYk82?=
 =?utf-8?B?WmQxRDFBSDAva2VuQWtsQTM5N1E3aTFCdFg4L2x0UHNNdjJVb3IwTzdmNHdr?=
 =?utf-8?B?VW9pbXo2cTZxNW5ZQkRMUkpqTURVZnZqbGpVZXZZU3czSFIwc0xyYWVlMWhO?=
 =?utf-8?B?MGNkY0plb3hVL0JTR2Y0UFJtc3B5eFlRcEVkT3ZZLzZFRy9GMCtyaHMzdVgz?=
 =?utf-8?B?aG03eVRTd1puSFdIRmJPYjZjb3FmVDNPRnlabVUyNW4wbXdhS1g1dVZoTWY4?=
 =?utf-8?B?aU1RcDhZMWZNVSs1S3l2V3FHaTNmZ2NWcnpESG1UMjJtcmltTnZPZmR6Y1pi?=
 =?utf-8?B?SWFPR1JQdlhiQVVpQ3h1azRQdDE2bTFRNnF6TkRQZ3hMWWx6TkdwSDBjWEw4?=
 =?utf-8?B?U1o4b24zaTlMN1BNNlFyd0FTczdzZkZnTFNreWFWYWVOOTh4cE82RTFlVUQ4?=
 =?utf-8?B?S1hPb0p4dVFqZ0tZa2ZZMUQ0WU5uNkF1WjFlS0NtNmF0TDUramR4azJlZi9N?=
 =?utf-8?B?RENDeHNlZmtmZnBxNHc4UTBuSkNaMm1WMWFEdlViZXJLeDlKUGFCTmQ3ZVVZ?=
 =?utf-8?B?aVE3ZEJaWHVreS82Ri80RXJJTWMxRXc2V2lzUlZ3eXRIV1d4Rjc3RXlqWi81?=
 =?utf-8?B?cmdXOC9kWjM3OWJsbjVjbGFCQkxGeHAwOVJ5dVBFU0NCaU9ZckJnWWlGS3dD?=
 =?utf-8?Q?U9d/pLqyUQumHyYo7+l2FO9v8I0X1NH8FcbejWmAhV62?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761f2efa-fde7-496d-8394-08da805a57ef
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 14:11:13.8791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eE8P/DF3ASWPjQsyjgrMTNoUd81PwT9R5Dv0sgnUcjAiYz5ni1bD8MaECvoo8lZ3Q62xoX6Hg7asiZDwlmk49g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3835
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-08-17 10:01, Andrey Grodzovsky wrote:
>
> On 2022-08-17 09:44, Alex Deucher wrote:
>> On Tue, Aug 16, 2022 at 10:54 PM Chai, Thomas <YiPeng.Chai@amd.com> 
>> wrote:
>>> [AMD Official Use Only - General]
>>>
>>> Hi Alex:
>>>    When removing an amdgpu device, it may be difficult to change the 
>>> order of psp_hw_fini calls.
>>>
>>> 1. The drm_dev_unplug call is at the beginning in the 
>>> amdgpu_pci_remove function,  which makes the gpu device inaccessible 
>>> for userspace operations.  If the call to psp_hw_fini was moved 
>>> before drm_dev_unplug,  userspace could access the gpu device but 
>>> the psp might be removing. It has unknown issues.
>>>
>> +Andrey Grodzovsky
>>
>> We should fix the ordering in amdgpu_pci_remove() then I guess? There
>> are lots of places where drm_dev_enter() is used to protect access to
>> the hardware which could be similarly affected.
>>
>> Alex
>
>
> We probably can try to move drm_dev_unplug after 
> amdgpu_driver_unload_kms. I don't remember now why drm_dev_unplug must 
> be the first thing we do in amdgpu_pci_remove and what impact it will 
> have but maybe give it a try.
> Also see if you can run libdrm hotplug test suite before and after the 
> change.
>
> Andrey


Thinking a bit more about this - i guess the main problem with this will 
be that in case of real hot unplug (which is hard to test unless you 
have a real GPU cage with extenal GPU) this move will cause trying to 
accesses HW registers
or MMIO ranges from VRAM BOs when HW is missing when you try to shut 
down the HW in HW fini IP block specific callbacks , this in turn will 
return garbage for reads (or all 1s maybe) which is what we probably 
were trying to avoid by putting drm_dev_unplug as the first thing. So 
it's probably a bit problematic.

Andrey


>
>
>>
>>> 2. psp_hw_fini is called by the .hw_fini iterator in 
>>> amdgpu_device_ip_fini_early, referring to the code starting from 
>>> amdgpu_pci_remove to .hw_fini is called,
>>>     there are many preparatory operations before calling .hw_fini,  
>>> which makes it very difficult to change the order of psp_hw_fini or 
>>> all block .hw_fini.
>>>
>>>     So can we do a workaround in psp_cmd_submit_buf when removing 
>>> amdgpu device?
>>>
>>> -----Original Message-----
>>> From: Alex Deucher <alexdeucher@gmail.com>
>>> Sent: Monday, August 15, 2022 10:22 PM
>>> To: Chai, Thomas <YiPeng.Chai@amd.com>
>>> Cc: amd-gfx@lists.freedesktop.org; Zhang, Hawking 
>>> <Hawking.Zhang@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Chai, 
>>> Thomas <YiPeng.Chai@amd.com>
>>> Subject: Re: [PATCH] drm/amdgpu: TA unload messages are not actually 
>>> sent to psp when amdgpu is uninstalled
>>>
>>> On Mon, Aug 15, 2022 at 3:06 AM YiPeng Chai <YiPeng.Chai@amd.com> 
>>> wrote:
>>>> The psp_cmd_submit_buf function is called by psp_hw_fini to send TA
>>>> unload messages to psp to terminate ras, asd and tmr.
>>>> But when amdgpu is uninstalled, drm_dev_unplug is called earlier than
>>>> psp_hw_fini in amdgpu_pci_remove, the calling order as follows:
>>>> static void amdgpu_pci_remove(struct pci_dev *pdev) {
>>>>          drm_dev_unplug
>>>>          ......
>>>> amdgpu_driver_unload_kms->amdgpu_device_fini_hw->...
>>>>                  ->.hw_fini->psp_hw_fini->...
>>>>                  ->psp_ta_unload->psp_cmd_submit_buf
>>>>          ......
>>>> }
>>>> The program will return when calling drm_dev_enter in
>>>> psp_cmd_submit_buf.
>>>>
>>>> So the call to drm_dev_enter in psp_cmd_submit_buf should be removed,
>>>> so that the TA unload messages can be sent to the psp when amdgpu is
>>>> uninstalled.
>>>>
>>>> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ----
>>>>   1 file changed, 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>>> index b067ce45d226..0578d8d094a7 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>>> @@ -585,9 +585,6 @@ psp_cmd_submit_buf(struct psp_context *psp,
>>>>          if (psp->adev->no_hw_access)
>>>>                  return 0;
>>>>
>>>> -       if (!drm_dev_enter(adev_to_drm(psp->adev), &idx))
>>>> -               return 0;
>>>> -
>>> This check is to prevent the hardware from being accessed if the 
>>> card is removed.  I think we need to fix the ordering elsewhere.
>>>
>>> Alex
>>>
>>>>          memset(psp->cmd_buf_mem, 0, PSP_CMD_BUFFER_SIZE);
>>>>
>>>>          memcpy(psp->cmd_buf_mem, cmd, sizeof(struct
>>>> psp_gfx_cmd_resp)); @@ -651,7 +648,6 @@ psp_cmd_submit_buf(struct 
>>>> psp_context *psp,
>>>>          }
>>>>
>>>>   exit:
>>>> -       drm_dev_exit(idx);
>>>>          return ret;
>>>>   }
>>>>
>>>> -- 
>>>> 2.25.1
>>>>
