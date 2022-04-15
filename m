Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE05C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Apr 2022 16:44:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C662A10E15C;
	Fri, 15 Apr 2022 16:44:05 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2072.outbound.protection.outlook.com [40.107.95.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82F1410E15C
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Apr 2022 16:44:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6KTTD3cRpVYH8/PTjlWDjfRhhSVruK61gJwXJYoSRTk+PYeUGF63eu/OeqOdguo7ZIO9mjGjF2hC/c+IaoIeqIUMrhUjRW86NFmWaKSiB+9feUQHE6grQxajcOmnzrOvc2oackSVihzkL0JCMERuUNVkJ20QfrsGnkqqBoTTbmXUmtqvs3mA7HOBxa+EG396vnFX3nlFu+iSi1qb5Wz1//eGFCudQmbgqUX+b5YXOO6tuXpgNgn3uguZvgeKrjHp7zOPcw84l0dSzKEhAmI8gLUNWd/4gZJ/OAo4JMivjAcawJR1DQcn+C4xJZ0KuqRbiRDkIk62BPHG7+X8FUyAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4AonNVLRjvBH8UW83P+X4JBpr4PrDF7hgXr3UMgnv0=;
 b=Fyt1WPJ+xjK6rzNDXZ2EMeTxjNAX+NrwVHMWdxa6a+aZWM9BNdPJdleMddbaycJnt4GG2JkJPzg0CDXKfZ2+OZ1bKBpqZTb++JUeH5xnPfqKuoUp0OQnNWZ2hF+ZGSzvnekSvRMHsIqcvKMjTkvSzrHvWDw0Wb+7rx9XesPCLoSFXcFt3S5JEs4g9zffIwBDOOE87FBQBUVN6k8yvw07tov+op9l73qCoG7SVWyOABYn+QWSb+WiIyb7vqNM7txL1sSjMpuwPED1uqPf3M0igjvCFZfLrqEu9rvPM5jRcNxUNcNOO/a0LgB+fA/oabroaHgJ73g/qQn31f9zthhJ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4AonNVLRjvBH8UW83P+X4JBpr4PrDF7hgXr3UMgnv0=;
 b=UknvFayVPRPpD6hZI/MiOum1H+a49kYwS5RF7ZVuTTup1suwv7bB2o4/ZKDODq+R3EhHefKDbf9rezTNEAJlKhcuO9a/tac6z2BSJWlI9Z/UJMOfQJ0fn4A3+CfNFpwJL3oQyhYZdh9IlFbeGRTBiOsZs1w4eOGUEJ7ViGvseF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by BN8PR12MB4769.namprd12.prod.outlook.com (2603:10b6:408:a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Fri, 15 Apr
 2022 16:43:58 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::4967:ac3d:d5eb:ebb4]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::4967:ac3d:d5eb:ebb4%9]) with mapi id 15.20.5144.032; Fri, 15 Apr 2022
 16:43:56 +0000
Content-Type: multipart/alternative;
 boundary="------------P7oqr2ZhTfiCEKZs99D6sN0e"
Message-ID: <c82b697a-b032-1b03-8a9c-49af57f4ae9e@amd.com>
Date: Fri, 15 Apr 2022 12:43:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [EXTERNAL] [PATCH 2/2] drm/amdkfd: Add PCIe Hotplug Support for
 AMDKFD
Content-Language: en-US
To: Shuotao Xu <shuotaoxu@microsoft.com>
References: <20220408084544.9313-1-shuotaoxu@microsoft.com>
 <20220408084544.9313-2-shuotaoxu@microsoft.com>
 <03483a49-5cfd-3e41-955e-e0e4dee78a74@amd.com>
 <08212428-471E-4C1C-9037-9AE16E9BA356@microsoft.com>
 <5c22aa65-f75d-bc05-e210-f28533d9f0f8@amd.com>
 <5A64FAEA-CCE8-4EB6-8E7B-852D4F384255@microsoft.com>
 <c771861c-f25c-1953-3cb7-f805ddb11aa3@amd.com>
 <B7970589-ACF6-41F3-8622-1C0F705F3EE0@microsoft.com>
 <42927224-900a-8548-80c4-13cda4d3f867@amd.com>
 <76C16B06-0539-48EE-AB11-80089490CE3A@microsoft.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <76C16B06-0539-48EE-AB11-80089490CE3A@microsoft.com>
X-ClientProxiedBy: YT1PR01CA0141.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::20) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6d54256-b5ec-423e-0aed-08da1eff2213
X-MS-TrafficTypeDiagnostic: BN8PR12MB4769:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB47691F4D26A7AD7E805CEF20EAEE9@BN8PR12MB4769.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LK8Oy0aH54qAcajtDK0Q7DzLRw7hNCNbEGHQf+5gFbnXUsf7TmlotnII3kUEvfpQVvPCxjh9TduS0MXo519qJIJy8L1ql3fAxIa5FZTd4Zps8a+kRu8HFXyp5FIa+90dDPbDuGd926pyHraS6cmiJApSW8unMmeAjceketIBYltOwYudLflgpTAS5nTbenU+Eo/n1DW2wnzhfA7NOz8WpLdc613yC0nGN+trk7LMIQnNjv6svclcOJ0LcxGCv52VSy7Sguh8G80s0Ukt4WHe8DKA8Ma7Z3meFGj6ApAl3zhyB1L/uXjcv4KvHHuEeThIlqXXW7Jlljby1l9OsG/6qUCyntpxgg4p0jAdfoDtMnU/40CJKEPsenKOpF6KY/WCTsLXkglEAiIfjJtTfzt9NuX3a3fXlVR32ynMsu9clTSeJW8RhftbqAVdV/ENFWQe++tZ6NFMLOFpiqkoViuPU0iF0EmvA5fuTZayGjqAftvqCbsar8sR+C/KSy9fCMjenvuMvU2FZfdFRqKF+s2TCfMRTNswP/5u75A8CRY/+u9LTht+zVH7m2Y8HjzOJ21NL7QtrtwQySg7XjqaJlwKSF4kx/lnNP/m7JIKBk67XVpVRESL5fPzHn1wSumbote0dBzZcqlYlm1tz+Wk9sWBhhu60gLiA0rUe4c4DWtgqowrTAlW2sGx797Y56tJUtT6nP+ykvmZUWWaWjCUXR91vzBcqn8G256J4z9d8+9UpXS0rKw0KEIydZVqOyjG8OKRz517oPBc6kzC9dh5oR6dCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(36756003)(508600001)(38100700002)(8676002)(31696002)(6486002)(966005)(8936002)(66556008)(66946007)(6916009)(166002)(54906003)(186003)(31686004)(66476007)(83380400001)(86362001)(4326008)(30864003)(45080400002)(5660300002)(2616005)(2906002)(53546011)(44832011)(33964004)(6506007)(6512007)(45980500001)(43740500002)(579004)(559001)(10090945011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmRFMUZmUnIzSEpYMjRtNnJTcmhRZTE1MnlXN043dXBxd1I2RGhNa1BUekdq?=
 =?utf-8?B?cXd1ZEcwL3dFcEI5OEZuaGQ3QVllOG54K0tjcTQrc25CV2ZQdUtCOFB2Z3gv?=
 =?utf-8?B?ekJBYmtRaS8zZTdyd3dKbnM5UVJQcFRIcnhoblBSbVFTRjZVeDE0YUVGckpZ?=
 =?utf-8?B?QUQyTTZRdVFOMXE0UzNWWEdiYTZlT1FDdks2NlByZDJqaFMvZ1N3czkvek5I?=
 =?utf-8?B?dXRHMGUwNFZja2Y2U2pxNzBuem5ESWF6OWpReDJYMFV1WXNwK0xwbi9jbGFn?=
 =?utf-8?B?WWQyb1Z1bkZ2Y1RuR0xPQVhINTJIUitKL2dQTldYd1lMUjA5blBQN0o0elZO?=
 =?utf-8?B?eXRtc1VxNEt4ZGFkV1ZxK2xpZnhWSEJBb2lqTVVDZmFjN3pHVXlPREZhRjFM?=
 =?utf-8?B?R0FYWmhSeVB2MHN3YUJaZG1ielIvcFgzcjNZS09RbkxBb0NxcFY1L2lGVUhI?=
 =?utf-8?B?OE5DRVpUc0w1TVNPUGRCbzYyR2xJY0lhaHlqaG9KaFdkZHY0R2hFMjRlVThZ?=
 =?utf-8?B?RTNoNGppK2NoNFIxazR4QjB6NzEwVkUyZHZqR0lyNVFHR28zVmFVYmxxVEx2?=
 =?utf-8?B?MndOODE2bDg2blc1cFE5ZnVHamFQMXlnZTlrUU1UT3RYajBNTUc3b0svQUp1?=
 =?utf-8?B?bVNqMW5IM25Cb1lhMDdWT25GRGFlOGlPTEViRnM5RW5zVUZPM1BKRCtwWFM1?=
 =?utf-8?B?SVRHTnhTMWdDOHl6c0lHSnRjVmdibkZjczdqbys2Z2d2bUlXclYyeGIwdzNa?=
 =?utf-8?B?eWdzK1U5Q2Q5b0VrdkZQQXpQeFdxVGkxVndRNE42Tk8rK0hMRmdlelllN3dK?=
 =?utf-8?B?Y0swVDNWN0JMRjd1U25yR1hhdXJxVTlOS3hnR3ZaZ3pIRnRmdVFCSGc2SFFG?=
 =?utf-8?B?R0NCakZZTFlPL0Z4RVBWckJVSmZXb3ZZZFJUcDA2WHNPd0RuWXNickRlM1M3?=
 =?utf-8?B?eEV3eEdVR0xpUVRzeit6YUI4RTdEZVpaR0VwMDkxcTNLdTZKK3puZjR5NFUr?=
 =?utf-8?B?aWpSQTBJa1VZQXE3MXR1SWlzNFhnRGxvVmlHTUVOWXlYSjdnV3JVd3BuUmpY?=
 =?utf-8?B?Q0RqSURleG1UMHkwWnhScmxmMmlENFBPd0tSV2t6dDBBSXoxa3QvMUpXVmRT?=
 =?utf-8?B?OXlJdDBmT2lwY1FJSzdzQ3kxcXB3SU5EWHgyUGdYU2FQZytscWg3Z0RGNmor?=
 =?utf-8?B?Yk5ncHNzMzZDbHcwUllNbTFLUkZ3NVI0SkNUUnZ5SWQ1VEFaNVdLUVVWQTBv?=
 =?utf-8?B?UkV5d0MvOGt3T0d5NVpWZnRGM2w4U01neldsRHc3MlhhNGxSbmVBTHNGZWQ5?=
 =?utf-8?B?SGNNUXp2T2hkQ3M0cVVwQzhtcmtQRVh2NnVQT2dYb1UzcnpJUVhrMy9EcTNT?=
 =?utf-8?B?ZWY0Y2hMZmpYQTdFRmhzMGxkQUh3ODFpN1pqc2VPcURGdDV6NW5yYlF3K0pw?=
 =?utf-8?B?M2QyNTRvazkrRGh5ZGYrajRWVE5vSjV0OHFDQ3VVTkJ5L0U2VGF1RmJzOE9l?=
 =?utf-8?B?OWNWZWZiQ0k0QmxxOUk3ZGJtZ0RGcnE4dEtTMEg0ek1YcnY1SHdhM2dNamZ0?=
 =?utf-8?B?Q2YzUzQwRnNQL2VqOEVETkxBeHByVFlyR2hnYVhxNXlRdXNHS2gwaUY1czBa?=
 =?utf-8?B?NkpBT2lpL1FlT3g3bU1hNEpLLzMxSXFIYnA2clBrTlpDYlVGTVZJcWc1Vkpv?=
 =?utf-8?B?OUlGSUh6Z0lWYUUyQzFjcHBtaE1YRGE3eUlCUm1Sd3N5cERpckw1OEFGK3pX?=
 =?utf-8?B?clVlZmQxTDV1Y3ArdXhheEUzS2lVMG4zN2lVTkYwemkrV2U0ZVYrNENER3Ri?=
 =?utf-8?B?QnllZms0ZTFHdi9DSFVkbDVjLzdHdXhkQVpDMzNYZ3R2bDJINDVGM1liR1Ur?=
 =?utf-8?B?K0U4MlcwNituS0pZY3E3aEdaTTZ2OGFSUHZUTkJxcU1zdktXajFOQlZLZWJY?=
 =?utf-8?B?b2tZemY3RzZlaC9LZUJxcElwVm1PUVRVaVduRTRFWXNubWpSOGRqc09leWdp?=
 =?utf-8?B?SlpiclFpRWFLNmZleHZoVHhkc2ljMFp3V09RQ3FNOWY0UWlYSkp0Qm1uajJO?=
 =?utf-8?B?MmZzMUtVWmFNSFJtUUZJV2dKSVRrUS9VTlEyWHhrVW1ka2FlbW93WmNaMzNX?=
 =?utf-8?B?dmhKVUt0NWdUbzg4MFJpbE00QU42Z0gxRG82ODZZODJzeXIxNzVtNkdKMHBG?=
 =?utf-8?B?VUZrU0FVL1JkOTBURGJKOW55NjZWSEVTZ1JwTFJpQytROFlkSXd0a1RnWlFy?=
 =?utf-8?B?bVlaZUl3bXdEdi95ZnBPMTB2aGV0bmhCUlhIYi9EbFBFQlp2aXNPTHhXVGw2?=
 =?utf-8?B?cXlURlpPemI5bXQ0UU1lYzRuMXNuMHl2QUJSeDlYWkVUb2U4QUZ4SjlWTXRz?=
 =?utf-8?Q?EBbix1OdHD4YOaEbcOpr1sAF9fQxNolcVQK7t7Y2qmiNI?=
X-MS-Exchange-AntiSpam-MessageData-1: qi++kud60EVfOg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d54256-b5ec-423e-0aed-08da1eff2213
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 16:43:56.7732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffu2bcjOUZkyMp4ExzGc/vZZ5FLjBYbjEiR2qPNPRjQriXN9H/jXZ3sNY1j9zxsN8fe12Y+PwW3hl9RedCpTLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4769
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
Cc: "Mukul.Joshi@amd.com" <Mukul.Joshi@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, Peng Cheng <pengc@microsoft.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Lei Qu <Lei.Qu@microsoft.com>, Ran Shu <Ran.Shu@microsoft.com>,
 Ziyue Yang <Ziyue.Yang@microsoft.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------P7oqr2ZhTfiCEKZs99D6sN0e
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2022-04-15 06:12, Shuotao Xu wrote:
> Hi Andrey,
>
> First I really appreciate the discussion! It helped me understand the 
> driver code greatly. Thank you so much:)
> Please see my inline comments.
>
>> On Apr 14, 2022, at 11:13 PM, Andrey Grodzovsky 
>> <andrey.grodzovsky@amd.com> wrote:
>>
>>
>> On 2022-04-14 10:00, Shuotao Xu wrote:
>>>
>>>
>>>> On Apr 14, 2022, at 1:31 AM, Andrey Grodzovsky 
>>>> <andrey.grodzovsky@amd.com> wrote:
>>>>
>>>>
>>>> On 2022-04-13 12:03, Shuotao Xu wrote:
>>>>>
>>>>>
>>>>>> On Apr 11, 2022, at 11:52 PM, Andrey Grodzovsky 
>>>>>> <andrey.grodzovsky@amd.com> wrote:
>>>>>>
>>>>>> [Some people who received this message don't often get email 
>>>>>> fromandrey.grodzovsky@amd.com. Learn why this is important 
>>>>>> athttp://aka.ms/LearnAboutSenderIdentification.]
>>>>>>
>>>>>> On 2022-04-08 21:28, Shuotao Xu wrote:
>>>>>>>
>>>>>>>> On Apr 8, 2022, at 11:28 PM, Andrey Grodzovsky 
>>>>>>>> <andrey.grodzovsky@amd.com> wrote:
>>>>>>>>
>>>>>>>> [Some people who received this message don't often get email 
>>>>>>>> from andrey.grodzovsky@amd.com. Learn why this is important at 
>>>>>>>> http://aka.ms/LearnAboutSenderIdentification.]
>>>>>>>>
>>>>>>>> On 2022-04-08 04:45, Shuotao Xu wrote:
>>>>>>>>> Adding PCIe Hotplug Support for AMDKFD: the support of 
>>>>>>>>> hot-plug of GPU
>>>>>>>>> devices can open doors for many advanced applications in data 
>>>>>>>>> center
>>>>>>>>> in the next few years, such as for GPU resource
>>>>>>>>> disaggregation. Current AMDKFD does not support hotplug out 
>>>>>>>>> b/o the
>>>>>>>>> following reasons:
>>>>>>>>>
>>>>>>>>> 1. During PCIe removal, decrement KFD lock which was 
>>>>>>>>> incremented at
>>>>>>>>> the beginning of hw fini; otherwise kfd_open later is going to
>>>>>>>>> fail.
>>>>>>>> I assumed you read my comment last time, still you do same 
>>>>>>>> approach.
>>>>>>>> More in details bellow
>>>>>>> Aha, I like your fix:) I was not familiar with drm APIs so just 
>>>>>>> only half understood your comment last time.
>>>>>>>
>>>>>>> BTW, I tried hot-plugging out a GPU when rocm application is 
>>>>>>> still running.
>>>>>>> From dmesg, application is still trying to access the removed 
>>>>>>> kfd device, and are met with some errors.
>>>>>>
>>>>>>
>>>>>> Application us supposed to keep running, it holds the drm_device
>>>>>> reference as long as it has an open
>>>>>> FD to the device and final cleanup will come only after the app 
>>>>>> will die
>>>>>> thus releasing the FD and the last
>>>>>> drm_device reference.
>>>>>>
>>>>>>> Application would hang and not exiting in this case.
>>>>>>
>>>>>
>>>>> Actually I tried kill -7 $pid, and the process exists. The dmesg 
>>>>> has some warning though.
>>>>>
>>>>> [  711.769977] WARNING: CPU: 23 PID: 344 at 
>>>>> .../amdgpu-rocm5.0.2/src/amd/amdgpu/amdgpu_object.c:1336 
>>>>> amdgpu_bo_release_notify+0x150/0x160 [amdgpu]
>>>>> [  711.770528] Modules linked in: amdgpu(OE) amdttm(OE) 
>>>>> amd_sched(OE) amdkcl(OE) iommu_v2 nf_conntrack_netlink nfnetlink 
>>>>> xfrm_user xfrm_algo xt_addrtype br_netfilter xt_CHECKSUM 
>>>>> iptable_mangle xt_MASQUERADE iptable_nat nf_nat xt_conntrack 
>>>>> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT 
>>>>> nf_reject_ipv4 xt_tcpudp bridge stp llc ebtable_filter ebtables 
>>>>> ip6table_filter ip6_tables iptable_filter overlay binfmt_misc 
>>>>> intel_rapl_msr i40iw intel_rapl_common skx_edac nfit 
>>>>> x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel rpcrdma 
>>>>> kvm sunrpc ipmi_ssif ib_umad ib_ipoib rdma_ucm irqbypass rapl 
>>>>> joydev acpi_ipmi input_leds intel_cstate ipmi_si ipmi_devintf 
>>>>> mei_me mei intel_pch_thermal ipmi_msghandler ioatdma mac_hid 
>>>>> lpc_ich dca acpi_power_meter acpi_pad sch_fq_codel ib_iser rdma_cm 
>>>>> iw_cm ib_cm iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi 
>>>>> pci_stub ip_tables x_tables autofs4 btrfs blake2b_generic 
>>>>> zstd_compress raid10 raid456 async_raid6_recov async_memcpy 
>>>>> async_pq async_xor async_tx xor
>>>>> [  711.779359]  raid6_pq libcrc32c raid1 raid0 multipath linear 
>>>>> mlx5_ib ib_uverbs ib_core ast drm_vram_helper i2c_algo_bit 
>>>>> drm_ttm_helper ttm drm_kms_helper syscopyarea crct10dif_pclmul 
>>>>> crc32_pclmul ghash_clmulni_intel sysfillrect uas hid_generic 
>>>>> sysimgblt aesni_intel mlx5_core fb_sys_fops crypto_simd usbhid 
>>>>> cryptd drm i40e pci_hyperv_intf usb_storage glue_helper mlxfw hid 
>>>>> ahci libahci wmi
>>>>> [  711.779752] CPU: 23 PID: 344 Comm: kworker/23:1 Tainted: G  W 
>>>>>  OE     5.11.0+ #1
>>>>> [  711.779755] Hardware name: Supermicro 
>>>>> SYS-4029GP-TRT2/X11DPG-OT-CPU, BIOS 2.1 08/14/2018
>>>>> [  711.779756] Workqueue: kfd_process_wq kfd_process_wq_release 
>>>>> [amdgpu]
>>>>> [  711.779955] RIP: 0010:amdgpu_bo_release_notify+0x150/0x160 [amdgpu]
>>>>> [  711.780141] Code: e8 b5 af 34 f4 e9 1f ff ff ff 48 39 c2 74 07 
>>>>> 0f 0b e9 69 ff ff ff 4c 89 e7 e8 3c b4 16 00 e9 5c ff ff ff e8 a2 
>>>>> ce fd f3 eb cf <0f> 0b eb cb e8 d7 02 34 f4 0f 1f 80 00 00 00 00 
>>>>> 0f 1f 44 00 00 55
>>>>> [  711.780143] RSP: 0018:ffffa8100dd67c30 EFLAGS: 00010282
>>>>> [  711.780145] RAX: 00000000ffffffea RBX: ffff89980e792058 RCX: 
>>>>> 0000000000000000
>>>>> [  711.780147] RDX: 0000000000000000 RSI: ffff89a8f9ad8870 RDI: 
>>>>> ffff89a8f9ad8870
>>>>> [  711.780148] RBP: ffffa8100dd67c50 R08: 0000000000000000 R09: 
>>>>> fffffffffff99b18
>>>>> [  711.780149] R10: ffffa8100dd67bd0 R11: ffffa8100dd67908 R12: 
>>>>> ffff89980e792000
>>>>> [  711.780151] R13: ffff89980e792058 R14: ffff89980e7921bc R15: 
>>>>> dead000000000100
>>>>> [  711.780152] FS:  0000000000000000(0000) 
>>>>> GS:ffff89a8f9ac0000(0000) knlGS:0000000000000000
>>>>> [  711.780154] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> [  711.780156] CR2: 00007ffddac6f71f CR3: 00000030bb80a003 CR4: 
>>>>> 00000000007706e0
>>>>> [  711.780157] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
>>>>> 0000000000000000
>>>>> [  711.780159] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
>>>>> 0000000000000400
>>>>> [  711.780160] PKRU: 55555554
>>>>> [  711.780161] Call Trace:
>>>>> [  711.780163]  ttm_bo_release+0x2ae/0x320 [amdttm]
>>>>> [  711.780169]  amdttm_bo_put+0x30/0x40 [amdttm]
>>>>> [  711.780357]  amdgpu_bo_unref+0x1e/0x30 [amdgpu]
>>>>> [  711.780543]  amdgpu_gem_object_free+0x8b/0x160 [amdgpu]
>>>>> [  711.781119]  drm_gem_object_free+0x1d/0x30 [drm]
>>>>> [  711.781489]  amdgpu_amdkfd_gpuvm_free_memory_of_gpu+0x34a/0x380 
>>>>> [amdgpu]
>>>>> [  711.782044]  kfd_process_device_free_bos+0xe0/0x130 [amdgpu]
>>>>> [  711.782611]  kfd_process_wq_release+0x286/0x380 [amdgpu]
>>>>> [  711.783172]  process_one_work+0x236/0x420
>>>>> [  711.783543]  worker_thread+0x34/0x400
>>>>> [  711.783911]  ? process_one_work+0x420/0x420
>>>>> [  711.784279]  kthread+0x126/0x140
>>>>> [  711.784653]  ? kthread_park+0x90/0x90
>>>>> [  711.785018]  ret_from_fork+0x22/0x30
>>>>> [  711.785387] ---[ end trace d8f50f6594817c84 ]---
>>>>> [  711.798716] [drm] amdgpu: ttm finalized
>>>>
>>>>
>>>> So it means the process was stuck in some wait_event_killable 
>>>> (maybe here drm_sched_entity_flush) - you can try 
>>>> 'cat/proc/$process_pid/stack' maybe before
>>>> you kill it to see where it was stuck so we can go from there.
>>>>
>>>>
>>>>>
>>>>>>
>>>>>> For graphic apps what i usually see is a crash because of sigsev when
>>>>>> the app tries to access
>>>>>> an unmapped MMIO region on the device. I haven't tested for compute
>>>>>> stack and so there might
>>>>>> be something I haven't covered. Hang could mean for example 
>>>>>> waiting on a
>>>>>> fence which is not being
>>>>>> signaled - please provide full dmesg from this case.
>>>>>>
>>>>>>>
>>>>>>> Do you have any good suggestions on how to fix it down the line? 
>>>>>>> (HIP runtime/libhsakmt or driver)
>>>>>>>
>>>>>>> [64036.631333] amdgpu: amdgpu_vm_bo_update failed
>>>>>>> [64036.631702] amdgpu: validate_invalid_user_pages: update PTE 
>>>>>>> failed
>>>>>>> [64036.640754] amdgpu: amdgpu_vm_bo_update failed
>>>>>>> [64036.641120] amdgpu: validate_invalid_user_pages: update PTE 
>>>>>>> failed
>>>>>>> [64036.650394] amdgpu: amdgpu_vm_bo_update failed
>>>>>>> [64036.650765] amdgpu: validate_invalid_user_pages: update PTE 
>>>>>>> failed
>>>>>>
>>>>>
>>>>> The full dmesg will just the repetition of those two messages,
>>>>> [186885.764079] amdgpu 0000:43:00.0: amdgpu: amdgpu: finishing device.
>>>>> [186885.766916] [drm] free PSP TMR buffer
>>>>> [186893.868173] amdgpu: amdgpu_vm_bo_update failed
>>>>> [186893.868235] amdgpu: validate_invalid_user_pages: update PTE failed
>>>>> [186893.876154] amdgpu: amdgpu_vm_bo_update failed
>>>>> [186893.876190] amdgpu: validate_invalid_user_pages: update PTE failed
>>>>> [186893.884150] amdgpu: amdgpu_vm_bo_update failed
>>>>> [186893.884185] amdgpu: validate_invalid_user_pages: update PTE failed
>>>>>
>>>>>>
>>>>>> This just probably means trying to update PTEs after the physical 
>>>>>> device
>>>>>> is gone - we usually avoid this by
>>>>>> first trying to do all HW shutdowns early before PCI remove 
>>>>>> completion
>>>>>> but when it's really tricky by
>>>>>> protecting HW access sections with drm_dev_enter/exit scope.
>>>>>>
>>>>>> For this particular error it would be the best to flush
>>>>>> info->restore_userptr_work before the end of
>>>>>> amdgpu_pci_remove (rejecting new process creation and calling
>>>>>> cancel_delayed_work_sync(&process_info->restore_userptr_work) for all
>>>>>> running processes)
>>>>>> somewhere in amdgpu_pci_remove.
>>>>>>
>>>>> I tried something like *kfd_process_ref_release* which I think did 
>>>>> what you described, but it did not work.
>>>>
>>>>
>>>> I don't see how kfd_process_ref_release is the same as I mentioned 
>>>> above, what i meant is calling the code above within 
>>>> kgd2kfd_suspend (where you tried to call 
>>>> kfd_kill_all_user_processes bellow)
>>>>
>>> Yes, you are right. It was not called by it.
>>>>
>>>>
>>>>>
>>>>> Instead I tried to kill the process from the kernel, but the 
>>>>> amdgpu could **only** be hot-plugged in back successfully only if 
>>>>> there was no rocm kernel running when it was plugged out. If not, 
>>>>> amdgpu_probe will just hang later. (Maybe because amdgpu was 
>>>>> plugged out while running state, it leaves a bad HW state which 
>>>>> causes probe to hang).
>>>>
>>>>
>>>> We usually do asic_reset during probe to reset all HW state (checlk 
>>>> if amdgpu_device_init->amdgpu_asic_reset is running when you  plug 
>>>> back).
>>>>
>>> OK
>>>>
>>>>
>>>>>
>>>>> I don’t know if this is a viable solution worth pursuing, but I 
>>>>> attached the diff anyway.
>>>>>
>>>>> Another solution could be let compute stack user mode detect a 
>>>>> topology change via generation_count change, and abort gracefully 
>>>>> there.
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>> index 4e7d9cb09a69..79b4c9b84cd0 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>> @@ -697,12 +697,15 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, 
>>>>> bool run_pm, bool force)
>>>>>                 return;
>>>>>
>>>>>         /* for runtime suspend, skip locking kfd */
>>>>> -       if (!run_pm) {
>>>>> +       if (!run_pm && !drm_dev_is_unplugged(kfd->ddev)) {
>>>>>                 /* For first KFD device suspend all the KFD 
>>>>> processes */
>>>>>                 if (atomic_inc_return(&kfd_locked) == 1)
>>>>> kfd_suspend_all_processes(force);
>>>>>         }
>>>>>
>>>>> +       if (drm_dev_is_unplugged(kfd->ddev))
>>>>> + kfd_kill_all_user_processes();
>>>>> +
>>>>> kfd->dqm->ops.stop(kfd->dqm);
>>>>> kfd_iommu_suspend(kfd);
>>>>>  }
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> index 55c9e1922714..84cbcd857856 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> @@ -1065,6 +1065,7 @@ void kfd_unref_process(struct kfd_process *p);
>>>>>  int kfd_process_evict_queues(struct kfd_process *p, bool force);
>>>>>  int kfd_process_restore_queues(struct kfd_process *p);
>>>>>  void kfd_suspend_all_processes(bool force);
>>>>> +void kfd_kill_all_user_processes(void);
>>>>>  /*
>>>>>   * kfd_resume_all_processes:
>>>>>   *     bool sync: If kfd_resume_all_processes() should wait for the
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> index 6cdc855abb6d..fb0c753b682c 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> @@ -2206,6 +2206,24 @@ void kfd_suspend_all_processes(bool force)
>>>>> srcu_read_unlock(&kfd_processes_srcu, idx);
>>>>>  }
>>>>>
>>>>> +
>>>>> +void kfd_kill_all_user_processes(void)
>>>>> +{
>>>>> +       struct kfd_process *p;
>>>>> +       struct amdkfd_process_info *p_info;
>>>>> +       unsigned int temp;
>>>>> +       int idx = srcu_read_lock(&kfd_processes_srcu);
>>>>> +
>>>>> +       pr_info("Killing all processes\n");
>>>>> + hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>>>>> +               p_info = p->kgd_process_info;
>>>>> + pr_info("Killing  processes, pid = %d", pid_nr(p_info->pid));
>>>>> + kill_pid(p_info->pid, SIGBUS, 1);
>>>>
>>>>
>>>> From looking into kill_pid I see it only sends a signal but doesn't 
>>>> wait for completion, it would make sense to wait for completion 
>>>> here. In any case I would actually try to put here
>>>>
>>> I have made a version which does that with some atomic counters. 
>>> Please read later in the diff.
>>>>
>>>>
>>>> hash_for_each_rcu(p_info)
>>>>     cancel_delayed_work_sync(&p_info->restore_userptr_work)
>>>>
>>>> instead  at least that what i meant in the previous mail.
>>>>
>>> I actually tried that earlier, and it did not work. Application 
>>> still keeps running, and you have to send a kill to the user process.
>>>
>>> I have made the following version. It waits for processes to 
>>> terminate synchronously after sending SIGBUS. After that it does the 
>>> real work of amdgpu_pci_remove.
>>> However, it hangs at amdgpu_device_ip_fini_early when it is trying 
>>> to deinit ip_block 6 <sdma_v4_0> 
>>> (https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L2818 
>>> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux%2F-%2Fblob%2Famd-staging-drm-next%2Fdrivers%2Fgpu%2Fdrm%2Famd%2Famdgpu%2Famdgpu_device.c%23L2818&data=04%7C01%7Candrey.grodzovsky%40amd.com%7Cc74b47c7231b430bae5508da1ec870de%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637856143531476565%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=PHmqeYxqJ9WJ4IHDphaQqrhfTC95DL6%2B8NpbIyxtykI%3D&reserved=0>). 
>>> I assume that there are still some inflight dma, therefore fini of 
>>> this ip block thus hangs?
>>>
>>> The following is an excerpt of the dmesg: please excuse for putting 
>>> my own pr_info, but I hope you get my point of where it hangs.
>>>
>>> [  392.344735] amdgpu: all processes has been fully released
>>> [  392.346557] amdgpu: amdgpu_acpi_fini done
>>> [  392.346568] amdgpu 0000:b3:00.0: amdgpu: amdgpu: finishing device.
>>> [  392.349238] amdgpu: amdgpu_device_ip_fini_early enter ip_blocks = 9
>>> [  392.349248] amdgpu: Free mem_obj = 000000007bf54275, range_start 
>>> = 14, range_end = 14
>>> [  392.350299] amdgpu: Free mem_obj = 00000000a85bc878, range_start 
>>> = 12, range_end = 12
>>> [  392.350304] amdgpu: Free mem_obj = 00000000b8019e32, range_start 
>>> = 13, range_end = 13
>>> [  392.350308] amdgpu: Free mem_obj = 000000002d296168, range_start 
>>> = 4, range_end = 11
>>> [  392.350313] amdgpu: Free mem_obj = 000000001fc4f934, range_start 
>>> = 0, range_end = 3
>>> [  392.350322] amdgpu: amdgpu_amdkfd_suspend(adev, false) done
>>> [  392.350672] amdgpu: hw_fini of IP block[8] <jpeg_v2_5> done 0
>>> [  392.350679] amdgpu: hw_fini of IP block[7] <vcn_v2_5> done 0
>>
>>
>> I just remembered that the idea to actively kill and wait for running 
>> user processes during unplug was rejected
>> as a bad idea in the first iteration of unplug work I did (don't 
>> remember why now, need to look) so this is a no go.
>>
> Maybe an application has kfd open, but was not accessing the dev. So 
> kill it at unplug could kill the process unnecessarily.
> However, the latest version I had with the sleep function got rid of 
> the IP block fini hang.
>>
>> Our policy is to let zombie processes (zombie in a sense that the 
>> underlying device is gone) live as long as they want
>> (as long as you able to terminate them - which you do, so that ok)
>> and the system should finish PCI remove gracefully and be able to hot 
>> plug back the device.  Hence, i suggest dropping
>> this direction of forcing all user processes to be killed, confirm 
>> you have graceful shutdown and remove of device
>> from PCI topology and then concentrate on why when you plug back it 
>> hangs.
>>
> So I basically revert back to the original solution which you suggested.
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 4e7d9cb09a69..5504a18b5a45 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -697,7 +697,7 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool 
> run_pm, bool force)
>                 return;
>
>         /* for runtime suspend, skip locking kfd */
> -       if (!run_pm) {
> +       if (!run_pm && !drm_dev_is_unplugged(kfd->ddev)) {
>                 /* For first KFD device suspend all the KFD processes */
>                 if (atomic_inc_return(&kfd_locked) == 1)
>                         kfd_suspend_all_processes(force);
>
>> First confirm if ASIC reset happens on
>> next init.
>>
> This patch works great at *planned* plugout, where all the rocm 
> processes are killed before plugout. And device can be added back 
> without a problem.
> However *unplanned* plugout when there is rocm processes are running 
> just don’t work.


Still I am not clear if ASIC reset happens on plug back or no, can you 
trace this please ?


>> Second please confirm if the timing you kill manually the user 
>> process has impact on whether you have a hang
>> on next plug back (if you kill before
>>
> *Scenario 0: Kill before plug back*
>
> 1. echo 1 > /sys/bus/pci/…/remove, would finish.
> But the application won’t exit until there is a kill signal.


Why you think it must exit ?


>
> 2. kill the the process. The application does several things and seems 
> trigger drm_release in the kernel, which are met with kernel NULL 
> pointer deference related to sysfs_remove. Then the whole fs just freeze.
>
> [  +0.002498] BUG: kernel NULL pointer dereference, address: 
> 0000000000000098
> [  +0.000486] #PF: supervisor read access in kernel mode
> [  +0.000545] #PF: error_code(0x0000) - not-present page
> [  +0.000551] PGD 0 P4D 0
> [  +0.000553] Oops: 0000 [#1] SMP NOPTI
> [  +0.000540] CPU: 75 PID: 4911 Comm: kworker/75:2 Tainted: G        W 
>   E     5.13.0-kfd #1
> [  +0.000559] Hardware name: INGRASYS         TURING  /MB      , BIOS 
> K71FQ28A 10/05/2021
> [  +0.000567] Workqueue: events delayed_fput
> [  +0.000563] RIP: 0010:kernfs_find_ns+0x1b/0x100
> [  +0.000569] Code: ff ff e8 88 59 9f 00 0f 1f 84 00 00 00 00 00 0f 1f 
> 44 00 00 41 57 8b 05 df f0 7b 01 41 56 41 55 49 89 f5 41 54 55 48 89 
> fd 53 <44> 0f b7 b7 98 00 00 00 48 89 d3 4c 8b 67 70 66 41 83 e6 20 41 0f
> [  +0.001193] RSP: 0018:ffffb9875db5fc98 EFLAGS: 00010246
> [  +0.000602] RAX: 0000000000000000 RBX: ffffa101f79507d8 RCX: 
> 0000000000000000
> [  +0.000612] RDX: 0000000000000000 RSI: ffffffffc09a9417 RDI: 
> 0000000000000000
> [  +0.000604] RBP: 0000000000000000 R08: 0000000000000001 R09: 
> 0000000000000000
> [  +0.000760] R10: ffffb9875db5fcd0 R11: 0000000000000000 R12: 
> 0000000000000000
> [  +0.000597] R13: ffffffffc09a9417 R14: ffffa08363fb2d18 R15: 
> 0000000000000000
> [  +0.000702] FS:  0000000000000000(0000) GS:ffffa0ffbfcc0000(0000) 
> knlGS:0000000000000000
> [  +0.000666] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.000658] CR2: 0000000000000098 CR3: 0000005747812005 CR4: 
> 0000000000770ee0
> [  +0.000715] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
> 0000000000000000
> [  +0.000655] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
> 0000000000000400
> [  +0.000592] PKRU: 55555554
> [  +0.000580] Call Trace:
> [  +0.000591]  kernfs_find_and_get_ns+0x2f/0x50
> [  +0.000584]  sysfs_remove_file_from_group+0x20/0x50
> [  +0.000580]  amdgpu_ras_sysfs_remove+0x3d/0xd0 [amdgpu]
> [  +0.000737]  amdgpu_ras_late_fini+0x1d/0x40 [amdgpu]
> [  +0.000750]  amdgpu_sdma_ras_fini+0x96/0xb0 [amdgpu]
> [  +0.000742]  ? gfx_v10_0_resume+0x10/0x10 [amdgpu]
> [  +0.000738]  sdma_v4_0_sw_fini+0x23/0x90 [amdgpu]
> [  +0.000717]  amdgpu_device_fini_sw+0xae/0x260 [amdgpu]
> [  +0.000704]  amdgpu_driver_release_kms+0x12/0x30 [amdgpu]
> [  +0.000687]  drm_dev_release+0x20/0x40 [drm]
> [  +0.000583]  drm_release+0xa8/0xf0 [drm]
> [  +0.000584]  __fput+0xa5/0x250
> [  +0.000621]  delayed_fput+0x1f/0x30
> [  +0.000726]  process_one_work+0x26e/0x580
> [  +0.000581]  ? process_one_work+0x580/0x580
> [  +0.000611]  worker_thread+0x4d/0x3d0
> [  +0.000611]  ? process_one_work+0x580/0x580
> [  +0.000605]  kthread+0x117/0x150
> [  +0.000611]  ? kthread_park+0x90/0x90
> [  +0.000619]  ret_from_fork+0x1f/0x30
> [  +0.000625] Modules linked in: amdgpu(E) xt_conntrack xt_MASQUERADE 
> nfnetlink xt_addrtype iptable_filter iptable_nat nf_nat nf_conntrack 
> nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter x86_pkg_temp_thermal 
> cdc_ether usbnet acpi_pad msr ip_tables x_tables ast drm_vram_helper 
> iommu_v2 drm_ttm_helper gpu_sched ttm drm_kms_helper cfbfillrect 
> syscopyarea cfbimgblt sysfillrect sysimgblt fb_sys_fops cfbcopyarea 
> drm drm_panel_orientati
> on_quirks [last unloaded: amdgpu]


This is a known regression, all SYSFS components must be removed before 
pci_remove code runs otherwise you get either warnings for single file 
removals or
OOPSEs for sysfs gorup removals like here. Please try to move 
amdgpu_ras_sysfs_remove from amdgpu_ras_late_fini to the end of 
amdgpu_ras_pre_fini (which happens before pci remove)


>
> 3.  echo 1 > /sys/bus/pci/rescan. This would just hang. I assume the 
> sysfs is broken.
>
> Based on 1 & 2, it seems that 1 won’t let the amdgpu exit gracefully, 
> because 2 will do some cleanup maybe should have happened before 1.
>>
>> or you kill after plug back does it makes a difference).
>>
> *Scenario 2: Kill after plug back*
>
> If I perform rescan before kill, then the driver seemed probed fine. 
> But kill will have the same issue which messed up the sysfs the same 
> way as in Scenario 2.
>
>
> *Final Comments:*
>
> 0. cancel_delayed_work_sync(&p_info->restore_userptr_work) would make 
> the repletion of amdgpu_vm_bo_update failure go away, but it does not 
> solve the issues in those scenarios.


Still - it's better to do it this way even for those failures to go awaya


>
> 1. For planned hotplug, this patch should work as long as you follow 
> some protocol, i.e. kill before plugout. Is this patch an acceptable 
> one since it provides some added feature than before?


Let's try to fix more as I advised above.


>
> 2. For unplanned hotplug when there is rocm app running, the patch 
> that kill all processes and wait for 5 sec would work consistently. 
> But it seems that it is an unacceptable solution for official release. 
> I can hold it for our own internal usage.  It seems that kill after 
> removal would cause problems, and I don’t know if there is a quick fix 
> by me because of my limited understanding of the amdgpu driver. Maybe 
> AMD could have a quick fix; Or it is really a difficult one. This 
> feature may or may not be a blocking issue in our GPU disaggregation 
> research down the way. Please let us know for either cases, and we 
> would like to learn and help as much as we could!


I am currently not sure why it helps. I will need to setup my own ROCm 
setup and retest hot plug to check this in more depth but currently i 
have higher priorities. Please try to confirm ASIC reset always takes 
place on plug back
and fix the sysfs OOPs as I advised above to clear up at least some of 
the issues. Also please describe to me exactly what you steps to 
reproduce this scenario so later I might be able to do it myself.

Also, we have hotplug test suite in libdrm (graphic stack), so maybe u 
can install libdrm and run that test suite to see if it exposes more issues.

Andrey


>
> Thank you so much!
>
> Best regards,
> Shuotao
>>
>> Andrey
>>
>>
>>>
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> index 8fa9b86ac9d2..c0b27f722281 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> @@ -188,6 +188,12 @@ void amdgpu_amdkfd_interrupt(struct 
>>> amdgpu_device *adev,
>>> kgd2kfd_interrupt(adev->kfd.dev, ih_ring_entry);
>>>  }
>>> +void amdgpu_amdkfd_kill_all_processes(struct amdgpu_device *adev)
>>> +{
>>> +if (adev->kfd.dev)
>>> +kgd2kfd_kill_all_user_processes(adev->kfd.dev);
>>> +}
>>> +
>>>  void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm)
>>>  {
>>> if (adev->kfd.dev)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> index 27c74fcec455..f4e485d60442 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> @@ -141,6 +141,7 @@ struct amdkfd_process_info {
>>>  int amdgpu_amdkfd_init(void);
>>>  void amdgpu_amdkfd_fini(void);
>>> +void amdgpu_amdkfd_kill_all_processes(struct amdgpu_device *adev);
>>>  void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);
>>>  int amdgpu_amdkfd_resume_iommu(struct amdgpu_device *adev);
>>>  int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm, 
>>> bool sync);
>>> @@ -405,6 +406,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>>> const struct kgd2kfd_shared_resources *gpu_resources);
>>>  void kgd2kfd_device_exit(struct kfd_dev *kfd);
>>>  void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm, bool force);
>>> +void kgd2kfd_kill_all_user_processes(struct kfd_dev *kfd);
>>>  int kgd2kfd_resume_iommu(struct kfd_dev *kfd);
>>>  int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm, bool sync);
>>>  int kgd2kfd_pre_reset(struct kfd_dev *kfd);
>>> @@ -443,6 +445,9 @@ static inline void kgd2kfd_suspend(struct 
>>> kfd_dev *kfd, bool run_pm, bool force)
>>>  {
>>>  }
>>> +void kgd2kfd_kill_all_user_processes(struct kfd_dev *kfd){
>>> +}
>>> +
>>>  static int __maybe_unused kgd2kfd_resume_iommu(struct kfd_dev *kfd)
>>>  {
>>> return 0;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index 3d5fc0751829..af6fe5080cfa 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -2101,6 +2101,9 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>>>  {
>>> struct drm_device *dev = pci_get_drvdata(pdev);
>>> +/* kill all kfd processes before drm_dev_unplug */
>>> +amdgpu_amdkfd_kill_all_processes(drm_to_adev(dev));
>>> +
>>>  #ifdef HAVE_DRM_DEV_UNPLUG
>>> drm_dev_unplug(dev);
>>>  #else
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> index 5504a18b5a45..480c23bef5e2 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> @@ -691,6 +691,12 @@ bool kfd_is_locked(void)
>>> return  (atomic_read(&kfd_locked) > 0);
>>>  }
>>> +inline void kgd2kfd_kill_all_user_processes(struct kfd_dev* dev)
>>> +{
>>> +kfd_kill_all_user_processes();
>>> +}
>>> +
>>> +
>>>  void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm, bool force)
>>>  {
>>> if (!kfd->init_complete)
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index 55c9e1922714..a35a2cb5bb9f 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -1064,6 +1064,7 @@ static inline struct kfd_process_device 
>>> *kfd_process_device_from_gpuidx(
>>>  void kfd_unref_process(struct kfd_process *p);
>>>  int kfd_process_evict_queues(struct kfd_process *p, bool force);
>>>  int kfd_process_restore_queues(struct kfd_process *p);
>>> +void kfd_kill_all_user_processes(void);
>>>  void kfd_suspend_all_processes(bool force);
>>>  /*
>>>   * kfd_resume_all_processes:
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> index 6cdc855abb6d..17e769e6951d 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> @@ -46,6 +46,9 @@ struct mm_struct;
>>>  #include "kfd_trace.h"
>>>  #include "kfd_debug.h"
>>> +static atomic_t kfd_process_locked = ATOMIC_INIT(0);
>>> +static atomic_t kfd_inflight_kills = ATOMIC_INIT(0);
>>> +
>>>  /*
>>>   * List of struct kfd_process (field kfd_process).
>>>   * Unique/indexed by mm_struct*
>>> @@ -802,6 +805,9 @@ struct kfd_process *kfd_create_process(struct 
>>> task_struct *thread)
>>> struct kfd_process *process;
>>> int ret;
>>> +if ( atomic_read(&kfd_process_locked) > 0 )
>>> +return ERR_PTR(-EINVAL);
>>> +
>>> if (!(thread->mm && mmget_not_zero(thread->mm)))
>>> return ERR_PTR(-EINVAL);
>>> @@ -1126,6 +1132,10 @@ static void kfd_process_wq_release(struct 
>>> work_struct *work)
>>> put_task_struct(p->lead_thread);
>>> kfree(p);
>>> +
>>> +if ( atomic_read(&kfd_process_locked) > 0 ){
>>> +atomic_dec(&kfd_inflight_kills);
>>> +}
>>>  }
>>>  static void kfd_process_ref_release(struct kref *ref)
>>> @@ -2186,6 +2196,35 @@ static void restore_process_worker(struct 
>>> work_struct *work)
>>> pr_err("Failed to restore queues of pasid 0x%x\n", p->pasid);
>>>  }
>>> +void kfd_kill_all_user_processes(void)
>>> +{
>>> +struct kfd_process *p;
>>> +/* struct amdkfd_process_info *p_info; */
>>> +unsigned int temp;
>>> +int idx;
>>> +atomic_inc(&kfd_process_locked);
>>> +
>>> +idx = srcu_read_lock(&kfd_processes_srcu);
>>> +pr_info("Killing all processes\n");
>>> +hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>>> +dev_warn(kfd_device,
>>> +"Sending SIGBUS to process %d (pasid 0x%x)",
>>> +p->lead_thread->pid, p->pasid);
>>> +send_sig(SIGBUS, p->lead_thread, 0);
>>> +atomic_inc(&kfd_inflight_kills);
>>> +}
>>> +srcu_read_unlock(&kfd_processes_srcu, idx);
>>> +
>>> +while ( atomic_read(&kfd_inflight_kills) > 0 ){
>>> +dev_warn(kfd_device,
>>> +"kfd_processes_table is not empty, going to sleep for 10ms\n");
>>> +msleep(10);
>>> +}
>>> +
>>> +atomic_dec(&kfd_process_locked);
>>> +pr_info("all processes has been fully released");
>>> +}
>>> +
>>>  void kfd_suspend_all_processes(bool force)
>>>  {
>>> struct kfd_process *p;
>>>
>>>
>>>
>>> Regards,
>>> Shuotao
>>>
>>>>
>>>> Andrey
>>>>
>>>>> +       }
>>>>> + srcu_read_unlock(&kfd_processes_srcu, idx);
>>>>> +}
>>>>> +
>>>>> +
>>>>>  int kfd_resume_all_processes(bool sync)
>>>>>  {
>>>>>         struct kfd_process *p;
>>>>>
>>>>>
>>>>>> Andrey
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> Really appreciate your help!
>>>>>>>
>>>>>>> Best,
>>>>>>> Shuotao
>>>>>>>
>>>>>>>>> 2. Remove redudant p2p/io links in sysfs when device is hotplugged
>>>>>>>>> out.
>>>>>>>>>
>>>>>>>>> 3. New kfd node_id is not properly assigned after a new device is
>>>>>>>>> added after a gpu is hotplugged out in a system. libhsakmt will
>>>>>>>>> find this anomaly, (i.e. node_from != <dev node id> in iolinks),
>>>>>>>>> when taking a topology_snapshot, thus returns fault to the rocm
>>>>>>>>> stack.
>>>>>>>>>
>>>>>>>>> -- This patch fixes issue 1; another patch by Mukul fixes 
>>>>>>>>> issues 2&3.
>>>>>>>>> -- Tested on a 4-GPU MI100 gpu nodes with kernel 5.13.0-kfd; 
>>>>>>>>> kernel
>>>>>>>>> 5.16.0-kfd is unstable out of box for MI100.
>>>>>>>>> ---
>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 5 +++++
>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 7 +++++++
>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
>>>>>>>>> drivers/gpu/drm/amd/amdkfd/kfd_device.c | 13 +++++++++++++
>>>>>>>>> 4 files changed, 26 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>> index c18c4be1e4ac..d50011bdb5c4 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>> @@ -213,6 +213,11 @@ int amdgpu_amdkfd_resume(struct 
>>>>>>>>> amdgpu_device *adev, bool run_pm)
>>>>>>>>> return r;
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>> +int amdgpu_amdkfd_resume_processes(void)
>>>>>>>>> +{
>>>>>>>>> + return kgd2kfd_resume_processes();
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev)
>>>>>>>>> {
>>>>>>>>> int r = 0;
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>>>>>> index f8b9f27adcf5..803306e011c3 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>>>>>> @@ -140,6 +140,7 @@ void amdgpu_amdkfd_fini(void);
>>>>>>>>> void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool 
>>>>>>>>> run_pm);
>>>>>>>>> int amdgpu_amdkfd_resume_iommu(struct amdgpu_device *adev);
>>>>>>>>> int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
>>>>>>>>> +int amdgpu_amdkfd_resume_processes(void);
>>>>>>>>> void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
>>>>>>>>> const void *ih_ring_entry);
>>>>>>>>> void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev);
>>>>>>>>> @@ -347,6 +348,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd);
>>>>>>>>> void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
>>>>>>>>> int kgd2kfd_resume_iommu(struct kfd_dev *kfd);
>>>>>>>>> int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
>>>>>>>>> +int kgd2kfd_resume_processes(void);
>>>>>>>>> int kgd2kfd_pre_reset(struct kfd_dev *kfd);
>>>>>>>>> int kgd2kfd_post_reset(struct kfd_dev *kfd);
>>>>>>>>> void kgd2kfd_interrupt(struct kfd_dev *kfd, const void 
>>>>>>>>> *ih_ring_entry);
>>>>>>>>> @@ -393,6 +395,11 @@ static inline int kgd2kfd_resume(struct 
>>>>>>>>> kfd_dev *kfd, bool run_pm)
>>>>>>>>> return 0;
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>> +static inline int kgd2kfd_resume_processes(void)
>>>>>>>>> +{
>>>>>>>>> + return 0;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd)
>>>>>>>>> {
>>>>>>>>> return 0;
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> index fa4a9f13c922..5827b65b7489 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> @@ -4004,6 +4004,7 @@ void amdgpu_device_fini_hw(struct 
>>>>>>>>> amdgpu_device *adev)
>>>>>>>>> if (drm_dev_is_unplugged(adev_to_drm(adev)))
>>>>>>>>> amdgpu_device_unmap_mmio(adev);
>>>>>>>>>
>>>>>>>>> + amdgpu_amdkfd_resume_processes();
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>> void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>>>>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>>>> index 62aa6c9d5123..ef05aae9255e 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>>>> @@ -714,6 +714,19 @@ int kgd2kfd_resume(struct kfd_dev *kfd, 
>>>>>>>>> bool run_pm)
>>>>>>>>> return ret;
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>> +/* for non-runtime resume only */
>>>>>>>>> +int kgd2kfd_resume_processes(void)
>>>>>>>>> +{
>>>>>>>>> + int count;
>>>>>>>>> +
>>>>>>>>> + count = atomic_dec_return(&kfd_locked);
>>>>>>>>> + WARN_ONCE(count < 0, "KFD suspend / resume ref. error");
>>>>>>>>> + if (count == 0)
>>>>>>>>> + return kfd_resume_all_processes();
>>>>>>>>> +
>>>>>>>>> + return 0;
>>>>>>>>> +}
>>>>>>>>
>>>>>>>> It doesn't make sense to me to just increment kfd_locked in
>>>>>>>> kgd2kfd_suspend to only decrement it again a few functions down the
>>>>>>>> road.
>>>>>>>>
>>>>>>>> I suggest this instead - you only incrmemnt if not during PCI 
>>>>>>>> remove
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>>> index 1c2cf3a33c1f..7754f77248a4 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>>> @@ -952,11 +952,12 @@ bool kfd_is_locked(void)
>>>>>>>>
>>>>>>>> void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
>>>>>>>> {
>>>>>>>> +
>>>>>>>> if (!kfd->init_complete)
>>>>>>>> return;
>>>>>>>>
>>>>>>>> /* for runtime suspend, skip locking kfd */
>>>>>>>> - if (!run_pm) {
>>>>>>>> + if (!run_pm && !drm_dev_is_unplugged(kfd->ddev)) {
>>>>>>>> /* For first KFD device suspend all the KFD processes */
>>>>>>>> if (atomic_inc_return(&kfd_locked) == 1)
>>>>>>>> kfd_suspend_all_processes();
>>>>>>>>
>>>>>>>>
>>>>>>>> Andrey
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>> +
>>>>>>>>> int kgd2kfd_resume_iommu(struct kfd_dev *kfd)
>>>>>>>>> {
>>>>>>>>> int err = 0;
>>>>>
>>>
>
--------------P7oqr2ZhTfiCEKZs99D6sN0e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-04-15 06:12, Shuotao Xu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:76C16B06-0539-48EE-AB11-80089490CE3A@microsoft.com">
      
      Hi Andrey,
      <div class=""><br class="">
      </div>
      <div class="">First I really appreciate the discussion! It helped
        me understand the driver code greatly. Thank you so much:)</div>
      <div class="">Please see my inline comments.&nbsp;<br class="">
        <div><br class="">
          <blockquote type="cite" class="">
            <div class="">On Apr 14, 2022, at 11:13 PM, Andrey
              Grodzovsky &lt;<a href="mailto:andrey.grodzovsky@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">andrey.grodzovsky@amd.com</a>&gt;
              wrote:</div>
            <br class="Apple-interchange-newline">
            <div class="">
              <div class="">
                <p class=""><br class="">
                </p>
                <div class="moz-cite-prefix">On 2022-04-14 10:00,
                  Shuotao Xu wrote:<br class="">
                </div>
                <blockquote type="cite" cite="mid:B7970589-ACF6-41F3-8622-1C0F705F3EE0@microsoft.com" class="">
                  <br class="">
                  <div class=""><br class="">
                    <blockquote type="cite" class="">
                      <div class="">On Apr 14, 2022, at 1:31 AM, Andrey
                        Grodzovsky &lt;<a href="mailto:andrey.grodzovsky@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">andrey.grodzovsky@amd.com</a>&gt;
                        wrote:</div>
                      <br class="Apple-interchange-newline">
                      <div class="">
                        <div class="">
                          <p class=""><br class="">
                          </p>
                          <div class="moz-cite-prefix">On 2022-04-13
                            12:03, Shuotao Xu wrote:<br class="">
                          </div>
                          <blockquote type="cite" cite="mid:5A64FAEA-CCE8-4EB6-8E7B-852D4F384255@microsoft.com" class="">
                            <br class="">
                            <div class=""><br class="">
                              <blockquote type="cite" class="">
                                <div class="">On Apr 11, 2022, at 11:52
                                  PM, Andrey Grodzovsky &lt;<a href="mailto:andrey.grodzovsky@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">andrey.grodzovsky@amd.com</a>&gt;
                                  wrote:</div>
                                <br class="Apple-interchange-newline">
                                <div class=""><span style="caret-color:
                                    rgb(0, 0, 0); font-family:
                                    Helvetica; font-size: 12px;
                                    font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none; float: none;
                                    display: inline !important;" class="">[Some people who received
                                    this message don't often get email
                                    from<span class="Apple-converted-space">&nbsp;</span></span><a href="mailto:andrey.grodzovsky@amd.com" style="font-family: Helvetica;
                                    font-size: 12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; orphans: auto; text-align:
                                    start; text-indent: 0px;
                                    text-transform: none; white-space:
                                    normal; widows: auto; word-spacing:
                                    0px; -webkit-text-size-adjust: auto;
                                    -webkit-text-stroke-width: 0px;" class="moz-txt-link-freetext" moz-do-not-send="true">andrey.grodzovsky@amd.com</a><span style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none; float: none;
                                    display: inline !important;" class="">. Learn why this is
                                    important at<span class="Apple-converted-space">&nbsp;</span></span><a href="http://aka.ms/LearnAboutSenderIdentification" style="font-family:
                                    Helvetica; font-size: 12px;
                                    font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; orphans: auto; text-align:
                                    start; text-indent: 0px;
                                    text-transform: none; white-space:
                                    normal; widows: auto; word-spacing:
                                    0px; -webkit-text-size-adjust: auto;
                                    -webkit-text-stroke-width: 0px;" class="moz-txt-link-freetext" moz-do-not-send="true">http://aka.ms/LearnAboutSenderIdentification</a><span style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none; float: none;
                                    display: inline !important;" class="">.]</span><br style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <br style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <span style="caret-color: rgb(0, 0,
                                    0); font-family: Helvetica;
                                    font-size: 12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none; float: none;
                                    display: inline !important;" class="">On 2022-04-08 21:28,
                                    Shuotao Xu wrote:</span><br style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <blockquote type="cite" style="font-family: Helvetica;
                                    font-size: 12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; orphans: auto; text-align:
                                    start; text-indent: 0px;
                                    text-transform: none; white-space:
                                    normal; widows: auto; word-spacing:
                                    0px; -webkit-text-size-adjust: auto;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                    <br class="">
                                    <blockquote type="cite" class="">On
                                      Apr 8, 2022, at 11:28 PM, Andrey
                                      Grodzovsky &lt;<a href="mailto:andrey.grodzovsky@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">andrey.grodzovsky@amd.com</a>&gt;
                                      wrote:<br class="">
                                      <br class="">
                                      [Some people who received this
                                      message don't often get email from
                                      <a href="mailto:andrey.grodzovsky@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">
                                        andrey.grodzovsky@amd.com</a>.
                                      Learn why this is important at <a href="http://aka.ms/LearnAboutSenderIdentification" class="moz-txt-link-freetext" moz-do-not-send="true">
http://aka.ms/LearnAboutSenderIdentification</a>.]<br class="">
                                      <br class="">
                                      On 2022-04-08 04:45, Shuotao Xu
                                      wrote:<br class="">
                                      <blockquote type="cite" class="">Adding
                                        PCIe Hotplug Support for AMDKFD:
                                        the support of hot-plug of GPU<br class="">
                                        devices can open doors for many
                                        advanced applications in data
                                        center<br class="">
                                        in the next few years, such as
                                        for GPU resource<br class="">
                                        disaggregation. Current AMDKFD
                                        does not support hotplug out b/o
                                        the<br class="">
                                        following reasons:<br class="">
                                        <br class="">
                                        1. During PCIe removal,
                                        decrement KFD lock which was
                                        incremented at<br class="">
                                        the beginning of hw fini;
                                        otherwise kfd_open later is
                                        going to<br class="">
                                        fail.<br class="">
                                      </blockquote>
                                      I assumed you read my comment last
                                      time, still you do same approach.<br class="">
                                      More in details bellow<br class="">
                                    </blockquote>
                                    Aha, I like your fix:) I was not
                                    familiar with drm APIs so just only
                                    half understood your comment last
                                    time.<br class="">
                                    <br class="">
                                    BTW, I tried hot-plugging out a GPU
                                    when rocm application is still
                                    running.<br class="">
                                    From dmesg, application is still
                                    trying to access the removed kfd
                                    device, and are met with some
                                    errors.<br class="">
                                  </blockquote>
                                  <br style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <br style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <span style="caret-color: rgb(0, 0,
                                    0); font-family: Helvetica;
                                    font-size: 12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none; float: none;
                                    display: inline !important;" class="">Application us supposed to
                                    keep running, it holds the
                                    drm_device</span><br style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <span style="caret-color: rgb(0, 0,
                                    0); font-family: Helvetica;
                                    font-size: 12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none; float: none;
                                    display: inline !important;" class="">reference as long as it has
                                    an open</span><br style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <span style="caret-color: rgb(0, 0,
                                    0); font-family: Helvetica;
                                    font-size: 12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none; float: none;
                                    display: inline !important;" class="">FD to the device and final
                                    cleanup will come only after the app
                                    will die</span><br style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <span style="caret-color: rgb(0, 0,
                                    0); font-family: Helvetica;
                                    font-size: 12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none; float: none;
                                    display: inline !important;" class="">thus releasing the FD and
                                    the last</span><br style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <span style="caret-color: rgb(0, 0,
                                    0); font-family: Helvetica;
                                    font-size: 12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none; float: none;
                                    display: inline !important;" class="">drm_device reference.</span><br style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <br style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <blockquote type="cite" style="font-family: Helvetica;
                                    font-size: 12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; orphans: auto; text-align:
                                    start; text-indent: 0px;
                                    text-transform: none; white-space:
                                    normal; widows: auto; word-spacing:
                                    0px; -webkit-text-size-adjust: auto;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                    Application would hang and not
                                    exiting in this case.<br class="">
                                  </blockquote>
                                  <br style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                </div>
                              </blockquote>
                              <div class=""><br class="">
                              </div>
                              Actually I tried kill -7 $pid, and the
                              process exists. The dmesg has some warning
                              though.</div>
                            <div class=""><br class="">
                            </div>
                            <div class="">
                              <div class="">[ &nbsp;711.769977] WARNING: CPU:
                                23 PID: 344 at
                                .../amdgpu-rocm5.0.2/src/amd/amdgpu/amdgpu_object.c:1336
                                amdgpu_bo_release_notify+0x150/0x160
                                [amdgpu]</div>
                              <div class="">[ &nbsp;711.770528] Modules
                                linked in: amdgpu(OE) amdttm(OE)
                                amd_sched(OE) amdkcl(OE) iommu_v2
                                nf_conntrack_netlink nfnetlink xfrm_user
                                xfrm_algo xt_addrtype br_netfilter
                                xt_CHECKSUM iptable_mangle xt_MASQUERADE
                                iptable_nat nf_nat xt_conntrack
                                nf_conntrack nf_defrag_ipv6
                                nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4
                                xt_tcpudp bridge stp llc ebtable_filter
                                ebtables ip6table_filter ip6_tables
                                iptable_filter overlay binfmt_misc
                                intel_rapl_msr i40iw intel_rapl_common
                                skx_edac nfit x86_pkg_temp_thermal
                                intel_powerclamp coretemp kvm_intel
                                rpcrdma kvm sunrpc ipmi_ssif ib_umad
                                ib_ipoib rdma_ucm irqbypass rapl joydev
                                acpi_ipmi input_leds intel_cstate
                                ipmi_si ipmi_devintf mei_me mei
                                intel_pch_thermal ipmi_msghandler
                                ioatdma mac_hid lpc_ich dca
                                acpi_power_meter acpi_pad sch_fq_codel
                                ib_iser rdma_cm iw_cm ib_cm iscsi_tcp
                                libiscsi_tcp libiscsi
                                scsi_transport_iscsi pci_stub ip_tables
                                x_tables autofs4 btrfs blake2b_generic
                                zstd_compress raid10 raid456
                                async_raid6_recov async_memcpy async_pq
                                async_xor async_tx xor</div>
                              <div class="">[ &nbsp;711.779359] &nbsp;raid6_pq
                                libcrc32c raid1 raid0 multipath linear
                                mlx5_ib ib_uverbs ib_core ast
                                drm_vram_helper i2c_algo_bit
                                drm_ttm_helper ttm drm_kms_helper
                                syscopyarea crct10dif_pclmul
                                crc32_pclmul ghash_clmulni_intel
                                sysfillrect uas hid_generic sysimgblt
                                aesni_intel mlx5_core fb_sys_fops
                                crypto_simd usbhid cryptd drm i40e
                                pci_hyperv_intf usb_storage glue_helper
                                mlxfw hid ahci libahci wmi</div>
                              <div class="">[ &nbsp;711.779752] CPU: 23 PID:
                                344 Comm: kworker/23:1 Tainted: G &nbsp; &nbsp; &nbsp;
                                &nbsp;W &nbsp;OE &nbsp; &nbsp; 5.11.0+ #1</div>
                              <div class="">[ &nbsp;711.779755] Hardware
                                name: Supermicro
                                SYS-4029GP-TRT2/X11DPG-OT-CPU, BIOS 2.1
                                08/14/2018</div>
                              <div class="">[ &nbsp;711.779756] Workqueue:
                                kfd_process_wq kfd_process_wq_release
                                [amdgpu]</div>
                              <div class="">[ &nbsp;711.779955] RIP:
                                0010:amdgpu_bo_release_notify+0x150/0x160
                                [amdgpu]</div>
                              <div class="">[ &nbsp;711.780141] Code: e8 b5
                                af 34 f4 e9 1f ff ff ff 48 39 c2 74 07
                                0f 0b e9 69 ff ff ff 4c 89 e7 e8 3c b4
                                16 00 e9 5c ff ff ff e8 a2 ce fd f3 eb
                                cf &lt;0f&gt; 0b eb cb e8 d7 02 34 f4 0f
                                1f 80 00 00 00 00 0f 1f 44 00 00 55</div>
                              <div class="">[ &nbsp;711.780143] RSP:
                                0018:ffffa8100dd67c30 EFLAGS: 00010282</div>
                              <div class="">[ &nbsp;711.780145] RAX:
                                00000000ffffffea RBX: ffff89980e792058
                                RCX: 0000000000000000</div>
                              <div class="">[ &nbsp;711.780147] RDX:
                                0000000000000000 RSI: ffff89a8f9ad8870
                                RDI: ffff89a8f9ad8870</div>
                              <div class="">[ &nbsp;711.780148] RBP:
                                ffffa8100dd67c50 R08: 0000000000000000
                                R09: fffffffffff99b18</div>
                              <div class="">[ &nbsp;711.780149] R10:
                                ffffa8100dd67bd0 R11: ffffa8100dd67908
                                R12: ffff89980e792000</div>
                              <div class="">[ &nbsp;711.780151] R13:
                                ffff89980e792058 R14: ffff89980e7921bc
                                R15: dead000000000100</div>
                              <div class="">[ &nbsp;711.780152] FS:
                                &nbsp;0000000000000000(0000)
                                GS:ffff89a8f9ac0000(0000)
                                knlGS:0000000000000000</div>
                              <div class="">[ &nbsp;711.780154] CS: &nbsp;0010 DS:
                                0000 ES: 0000 CR0: 0000000080050033</div>
                              <div class="">[ &nbsp;711.780156] CR2:
                                00007ffddac6f71f CR3: 00000030bb80a003
                                CR4: 00000000007706e0</div>
                              <div class="">[ &nbsp;711.780157] DR0:
                                0000000000000000 DR1: 0000000000000000
                                DR2: 0000000000000000</div>
                              <div class="">[ &nbsp;711.780159] DR3:
                                0000000000000000 DR6: 00000000fffe0ff0
                                DR7: 0000000000000400</div>
                              <div class="">[ &nbsp;711.780160] PKRU:
                                55555554</div>
                              <div class="">[ &nbsp;711.780161] Call Trace:</div>
                              <div class="">[ &nbsp;711.780163]
                                &nbsp;ttm_bo_release+0x2ae/0x320 [amdttm]</div>
                              <div class="">[ &nbsp;711.780169]
                                &nbsp;amdttm_bo_put+0x30/0x40 [amdttm]</div>
                              <div class="">[ &nbsp;711.780357]
                                &nbsp;amdgpu_bo_unref+0x1e/0x30 [amdgpu]</div>
                              <div class="">[ &nbsp;711.780543]
                                &nbsp;amdgpu_gem_object_free+0x8b/0x160
                                [amdgpu]</div>
                              <div class="">[ &nbsp;711.781119]
                                &nbsp;drm_gem_object_free+0x1d/0x30 [drm]</div>
                              <div class="">[ &nbsp;711.781489]
                                &nbsp;amdgpu_amdkfd_gpuvm_free_memory_of_gpu+0x34a/0x380
                                [amdgpu]</div>
                              <div class="">[ &nbsp;711.782044]
                                &nbsp;kfd_process_device_free_bos+0xe0/0x130
                                [amdgpu]</div>
                              <div class="">[ &nbsp;711.782611]
                                &nbsp;kfd_process_wq_release+0x286/0x380
                                [amdgpu]</div>
                              <div class="">[ &nbsp;711.783172]
                                &nbsp;process_one_work+0x236/0x420</div>
                              <div class="">[ &nbsp;711.783543]
                                &nbsp;worker_thread+0x34/0x400</div>
                              <div class="">[ &nbsp;711.783911] &nbsp;?
                                process_one_work+0x420/0x420</div>
                              <div class="">[ &nbsp;711.784279]
                                &nbsp;kthread+0x126/0x140</div>
                              <div class="">[ &nbsp;711.784653] &nbsp;?
                                kthread_park+0x90/0x90</div>
                              <div class="">[ &nbsp;711.785018]
                                &nbsp;ret_from_fork+0x22/0x30</div>
                              <div class="">[ &nbsp;711.785387] ---[ end
                                trace d8f50f6594817c84 ]---</div>
                              <div class="">[ &nbsp;711.798716] [drm] amdgpu:
                                ttm finalized</div>
                            </div>
                          </blockquote>
                          <p class=""><br class="">
                          </p>
                          <p class="">So it means the process was stuck
                            in some wait_event_killable (maybe here
                            drm_sched_entity_flush) - you can try
                            'cat/proc/$process_pid/stack' maybe before<br class="">
                            you kill it to see where it was stuck so we
                            can go from there.<br class="">
                          </p>
                          <p class=""><br class="">
                          </p>
                          <blockquote type="cite" cite="mid:5A64FAEA-CCE8-4EB6-8E7B-852D4F384255@microsoft.com" class="">
                            <div class="">
                              <div class=""><br class="">
                              </div>
                            </div>
                            <div class="">
                              <blockquote type="cite" class="">
                                <div class=""><br style="caret-color:
                                    rgb(0, 0, 0); font-family:
                                    Helvetica; font-size: 12px;
                                    font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <span style="caret-color: rgb(0, 0,
                                    0); font-family: Helvetica;
                                    font-size: 12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none; float: none;
                                    display: inline !important;" class="">For graphic apps what i
                                    usually see is a crash because of
                                    sigsev when</span><br style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <span style="caret-color: rgb(0, 0,
                                    0); font-family: Helvetica;
                                    font-size: 12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none; float: none;
                                    display: inline !important;" class="">the app tries to access</span><br style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <span style="caret-color: rgb(0, 0,
                                    0); font-family: Helvetica;
                                    font-size: 12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none; float: none;
                                    display: inline !important;" class="">an unmapped MMIO region on
                                    the device. I haven't tested for
                                    compute</span><br style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <span style="caret-color: rgb(0, 0,
                                    0); font-family: Helvetica;
                                    font-size: 12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none; float: none;
                                    display: inline !important;" class="">stack and so there might</span><br style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <span style="caret-color: rgb(0, 0,
                                    0); font-family: Helvetica;
                                    font-size: 12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none; float: none;
                                    display: inline !important;" class="">be something I haven't
                                    covered. Hang could mean for example
                                    waiting on a</span><br style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <span style="caret-color: rgb(0, 0,
                                    0); font-family: Helvetica;
                                    font-size: 12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none; float: none;
                                    display: inline !important;" class="">fence which is not being</span><br style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <span style="caret-color: rgb(0, 0,
                                    0); font-family: Helvetica;
                                    font-size: 12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none; float: none;
                                    display: inline !important;" class="">signaled - please provide
                                    full dmesg from this case.</span><br style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <br style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <blockquote type="cite" style="font-family: Helvetica;
                                    font-size: 12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; orphans: auto; text-align:
                                    start; text-indent: 0px;
                                    text-transform: none; white-space:
                                    normal; widows: auto; word-spacing:
                                    0px; -webkit-text-size-adjust: auto;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                    <br class="">
                                    Do you have any good suggestions on
                                    how to fix it down the line? (HIP
                                    runtime/libhsakmt or driver)<br class="">
                                    <br class="">
                                    [64036.631333] amdgpu:
                                    amdgpu_vm_bo_update failed<br class="">
                                    [64036.631702] amdgpu:
                                    validate_invalid_user_pages: update
                                    PTE failed<br class="">
                                    [64036.640754] amdgpu:
                                    amdgpu_vm_bo_update failed<br class="">
                                    [64036.641120] amdgpu:
                                    validate_invalid_user_pages: update
                                    PTE failed<br class="">
                                    [64036.650394] amdgpu:
                                    amdgpu_vm_bo_update failed<br class="">
                                    [64036.650765] amdgpu:
                                    validate_invalid_user_pages: update
                                    PTE failed<br class="">
                                  </blockquote>
                                  <br style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                </div>
                              </blockquote>
                              <div class=""><br class="">
                              </div>
                              The full dmesg will just the repetition of
                              those two messages,</div>
                            <div class="">
                              <div class="">[186885.764079] amdgpu
                                0000:43:00.0: amdgpu: amdgpu: finishing
                                device.</div>
                              <div class="">[186885.766916] [drm] free
                                PSP TMR buffer</div>
                              <div class="">[186893.868173] amdgpu:
                                amdgpu_vm_bo_update failed</div>
                              <div class="">[186893.868235] amdgpu:
                                validate_invalid_user_pages: update PTE
                                failed</div>
                              <div class="">[186893.876154] amdgpu:
                                amdgpu_vm_bo_update failed</div>
                              <div class="">[186893.876190] amdgpu:
                                validate_invalid_user_pages: update PTE
                                failed</div>
                              <div class="">[186893.884150] amdgpu:
                                amdgpu_vm_bo_update failed</div>
                              <div class="">[186893.884185] amdgpu:
                                validate_invalid_user_pages: update PTE
                                failed</div>
                            </div>
                            <div class=""><br class="">
                            </div>
                            <div class="">
                              <blockquote type="cite" class="">
                                <div class=""><br style="caret-color:
                                    rgb(0, 0, 0); font-family:
                                    Helvetica; font-size: 12px;
                                    font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <span style="caret-color: rgb(0, 0,
                                    0); font-family: Helvetica;
                                    font-size: 12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none; float: none;
                                    display: inline !important;" class="">This just probably means
                                    trying to update PTEs after the
                                    physical device</span><br style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <span style="caret-color: rgb(0, 0,
                                    0); font-family: Helvetica;
                                    font-size: 12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none; float: none;
                                    display: inline !important;" class="">is gone - we usually avoid
                                    this by</span><br style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <span style="caret-color: rgb(0, 0,
                                    0); font-family: Helvetica;
                                    font-size: 12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none; float: none;
                                    display: inline !important;" class="">first trying to do all HW
                                    shutdowns early before PCI remove
                                    completion</span><br style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <span style="caret-color: rgb(0, 0,
                                    0); font-family: Helvetica;
                                    font-size: 12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none; float: none;
                                    display: inline !important;" class="">but when it's really tricky
                                    by</span><br style="caret-color:
                                    rgb(0, 0, 0); font-family:
                                    Helvetica; font-size: 12px;
                                    font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <span style="caret-color: rgb(0, 0,
                                    0); font-family: Helvetica;
                                    font-size: 12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none; float: none;
                                    display: inline !important;" class="">protecting HW access
                                    sections with drm_dev_enter/exit
                                    scope.</span><br style="caret-color:
                                    rgb(0, 0, 0); font-family:
                                    Helvetica; font-size: 12px;
                                    font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <br style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <span style="caret-color: rgb(0, 0,
                                    0); font-family: Helvetica;
                                    font-size: 12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none; float: none;
                                    display: inline !important;" class="">For this particular error
                                    it would be the best to flush</span><br style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <span style="caret-color: rgb(0, 0,
                                    0); font-family: Helvetica;
                                    font-size: 12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none; float: none;
                                    display: inline !important;" class="">info-&gt;restore_userptr_work
                                    before the end of</span><br style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <span style="caret-color: rgb(0, 0,
                                    0); font-family: Helvetica;
                                    font-size: 12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none; float: none;
                                    display: inline !important;" class="">amdgpu_pci_remove
                                    (rejecting new process creation and
                                    calling</span><br style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <span style="caret-color: rgb(0, 0,
                                    0); font-family: Helvetica;
                                    font-size: 12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none; float: none;
                                    display: inline !important;" class="">cancel_delayed_work_sync(&amp;process_info-&gt;restore_userptr_work)
                                    for all</span><br style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <span style="caret-color: rgb(0, 0,
                                    0); font-family: Helvetica;
                                    font-size: 12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none; float: none;
                                    display: inline !important;" class="">running processes)</span><br style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <span style="caret-color: rgb(0, 0,
                                    0); font-family: Helvetica;
                                    font-size: 12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none; float: none;
                                    display: inline !important;" class="">somewhere in
                                    amdgpu_pci_remove.</span><br style="caret-color: rgb(0, 0, 0);
                                    font-family: Helvetica; font-size:
                                    12px; font-style: normal;
                                    font-variant-caps: normal;
                                    font-weight: 400; letter-spacing:
                                    normal; text-align: start;
                                    text-indent: 0px; text-transform:
                                    none; white-space: normal;
                                    word-spacing: 0px;
                                    -webkit-text-stroke-width: 0px;
                                    text-decoration: none;" class="">
                                  <br class="">
                                </div>
                              </blockquote>
                              I tried something like
                              *kfd_process_ref_release* which I think
                              did what you described, but it did not
                              work.</div>
                          </blockquote>
                          <p class=""><br class="">
                          </p>
                          <p class="">I don't see how
                            kfd_process_ref_release is the same as I
                            mentioned above, what i meant is calling the
                            code above within kgd2kfd_suspend (where you
                            tried to call kfd_kill_all_user_processes
                            bellow)
                            <br class="">
                          </p>
                        </div>
                      </div>
                    </blockquote>
                    Yes, you are right. It was not called by it. &nbsp;<br class="">
                    <blockquote type="cite" class="">
                      <div class="">
                        <div class="">
                          <p class=""><br class="">
                          </p>
                          <blockquote type="cite" cite="mid:5A64FAEA-CCE8-4EB6-8E7B-852D4F384255@microsoft.com" class="">
                            <div class=""><br class="">
                            </div>
                            <div class="">Instead I tried to kill the
                              process from the kernel, but the amdgpu
                              could **only** be hot-plugged in back
                              successfully only if there was no rocm
                              kernel running when it was plugged out. If
                              not, amdgpu_probe will just hang later.
                              (Maybe because amdgpu was plugged out
                              while running state, it leaves a bad HW
                              state which causes probe to hang).</div>
                          </blockquote>
                          <p class=""><br class="">
                          </p>
                          <p class="">We usually do asic_reset during
                            probe to reset all HW state (checlk if
                            amdgpu_device_init-&gt;amdgpu_asic_reset is
                            running when you&nbsp; plug back).
                            <br class="">
                          </p>
                        </div>
                      </div>
                    </blockquote>
                    OK<br class="">
                    <blockquote type="cite" class="">
                      <div class="">
                        <div class="">
                          <p class="">&nbsp; <br class="">
                          </p>
                          <blockquote type="cite" cite="mid:5A64FAEA-CCE8-4EB6-8E7B-852D4F384255@microsoft.com" class="">
                            <div class=""><br class="">
                            </div>
                            <div class="">I don’t know if this is a
                              viable solution worth pursuing, but I
                              attached the diff anyway.</div>
                            <div class=""><br class="">
                            </div>
                            <div class="">Another solution could be let
                              compute stack user mode detect a topology
                              change via&nbsp;<span class="">generation_count
                                change, and abort gracefully there.</span></div>
                            <div class=""><br class="">
                            </div>
                            <div class="">diff --git
                              a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
                              b/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
                            <div class="">index
                              4e7d9cb09a69..79b4c9b84cd0 100644</div>
                            <div class="">---
                              a/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
                            <div class="">+++
                              b/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
                            <div class="">@@ -697,12 +697,15 @@ void
                              kgd2kfd_suspend(struct kfd_dev *kfd, bool
                              run_pm, bool force)</div>
                            <div class="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return;</div>
                            <div class=""><br class="">
                            </div>
                            <div class="">&nbsp; &nbsp; &nbsp; &nbsp; /* for runtime
                              suspend, skip locking kfd */</div>
                            <div class="">- &nbsp; &nbsp; &nbsp; if (!run_pm) {</div>
                            <div class="">+ &nbsp; &nbsp; &nbsp; if (!run_pm &amp;&amp;
                              !drm_dev_is_unplugged(kfd-&gt;ddev)) {</div>
                            <div class="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* For first
                              KFD device suspend all the KFD processes
                              */</div>
                            <div class="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if
                              (atomic_inc_return(&amp;kfd_locked) == 1)</div>
                            <div class="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                              kfd_suspend_all_processes(force);</div>
                            <div class="">&nbsp; &nbsp; &nbsp; &nbsp; }</div>
                            <div class=""><br class="">
                            </div>
                            <div class="">+ &nbsp; &nbsp; &nbsp; if
                              (drm_dev_is_unplugged(kfd-&gt;ddev))</div>
                            <div class="">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                              kfd_kill_all_user_processes();</div>
                            <div class="">+</div>
                            <div class="">&nbsp; &nbsp; &nbsp; &nbsp;
                              kfd-&gt;dqm-&gt;ops.stop(kfd-&gt;dqm);</div>
                            <div class="">&nbsp; &nbsp; &nbsp; &nbsp;
                              kfd_iommu_suspend(kfd);</div>
                            <div class="">&nbsp;}</div>
                            <div class="">diff --git
                              a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
                              b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h</div>
                            <div class="">index
                              55c9e1922714..84cbcd857856 100644</div>
                            <div class="">---
                              a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h</div>
                            <div class="">+++
                              b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h</div>
                            <div class="">@@ -1065,6 +1065,7 @@ void
                              kfd_unref_process(struct kfd_process *p);</div>
                            <div class="">&nbsp;int
                              kfd_process_evict_queues(struct
                              kfd_process *p, bool force);</div>
                            <div class="">&nbsp;int
                              kfd_process_restore_queues(struct
                              kfd_process *p);</div>
                            <div class="">&nbsp;void
                              kfd_suspend_all_processes(bool force);</div>
                            <div class="">+void
                              kfd_kill_all_user_processes(void);</div>
                            <div class="">&nbsp;/*</div>
                            <div class="">&nbsp; * kfd_resume_all_processes:</div>
                            <div class="">&nbsp; * &nbsp; &nbsp; bool sync: If
                              kfd_resume_all_processes() should wait for
                              the</div>
                            <div class="">diff --git
                              a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
                              b/drivers/gpu/drm/amd/amdkfd/kfd_process.c</div>
                            <div class="">index
                              6cdc855abb6d..fb0c753b682c 100644</div>
                            <div class="">---
                              a/drivers/gpu/drm/amd/amdkfd/kfd_process.c</div>
                            <div class="">+++
                              b/drivers/gpu/drm/amd/amdkfd/kfd_process.c</div>
                            <div class="">@@ -2206,6 +2206,24 @@ void
                              kfd_suspend_all_processes(bool force)</div>
                            <div class="">&nbsp; &nbsp; &nbsp; &nbsp;
                              srcu_read_unlock(&amp;kfd_processes_srcu,
                              idx);</div>
                            <div class="">&nbsp;}</div>
                            <div class=""><br class="">
                            </div>
                            <div class="">+</div>
                            <div class="">+void
                              kfd_kill_all_user_processes(void)</div>
                            <div class="">+{</div>
                            <div class="">+ &nbsp; &nbsp; &nbsp; struct kfd_process *p;</div>
                            <div class="">+ &nbsp; &nbsp; &nbsp; struct
                              amdkfd_process_info *p_info;</div>
                            <div class="">+ &nbsp; &nbsp; &nbsp; unsigned int temp;</div>
                            <div class="">+ &nbsp; &nbsp; &nbsp; int idx =
                              srcu_read_lock(&amp;kfd_processes_srcu);</div>
                            <div class="">+</div>
                            <div class="">+ &nbsp; &nbsp; &nbsp; pr_info(&quot;Killing all
                              processes\n&quot;);</div>
                            <div class="">+ &nbsp; &nbsp; &nbsp;
                              hash_for_each_rcu(kfd_processes_table,
                              temp, p, kfd_processes) {</div>
                            <div class="">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; p_info =
                              p-&gt;kgd_process_info;</div>
                            <div class="">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                              pr_info(&quot;Killing &nbsp;processes, pid = %d&quot;,
                              pid_nr(p_info-&gt;pid));</div>
                            <div class="">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                              kill_pid(p_info-&gt;pid, SIGBUS, 1);</div>
                          </blockquote>
                          <p class=""><br class="">
                          </p>
                          <p class="">From looking into kill_pid I see
                            it only sends a signal but doesn't wait for
                            completion, it would make sense to wait for
                            completion here. In any case I would
                            actually try to put here<span style="caret-color: rgb(0, 0, 0);
                              font-family: Helvetica; font-size: 12px;
                              font-style: normal; font-variant-caps:
                              normal; font-weight: 400; letter-spacing:
                              normal; text-align: start; text-indent:
                              0px; text-transform: none; white-space:
                              normal; word-spacing: 0px;
                              -webkit-text-stroke-width: 0px;
                              text-decoration: none; float: none;
                              display: inline !important;" class=""><br class="">
                            </span></p>
                        </div>
                      </div>
                    </blockquote>
                    I have made a version which does that with some
                    atomic counters. Please read later in the diff.<br class="">
                    <blockquote type="cite" class="">
                      <div class="">
                        <div class="">
                          <p class=""><span style="caret-color: rgb(0,
                              0, 0); font-family: Helvetica; font-size:
                              12px; font-style: normal;
                              font-variant-caps: normal; font-weight:
                              400; letter-spacing: normal; text-align:
                              start; text-indent: 0px; text-transform:
                              none; white-space: normal; word-spacing:
                              0px; -webkit-text-stroke-width: 0px;
                              text-decoration: none; float: none;
                              display: inline !important;" class=""></span><span style="caret-color: rgb(0, 0, 0);
                              font-family: Helvetica; font-size: 12px;
                              font-style: normal; font-variant-caps:
                              normal; font-weight: 400; letter-spacing:
                              normal; text-align: start; text-indent:
                              0px; text-transform: none; white-space:
                              normal; word-spacing: 0px;
                              -webkit-text-stroke-width: 0px;
                              text-decoration: none; float: none;
                              display: inline !important;" class=""><font class="" size="4"><br class="">
                              </font></span></p>
                          <p class=""><span style="caret-color: rgb(0,
                              0, 0); font-family: Helvetica; font-size:
                              12px; font-style: normal;
                              font-variant-caps: normal; font-weight:
                              400; letter-spacing: normal; text-align:
                              start; text-indent: 0px; text-transform:
                              none; white-space: normal; word-spacing:
                              0px; -webkit-text-stroke-width: 0px;
                              text-decoration: none; float: none;
                              display: inline !important;" class=""><font class="" size="4">hash_for_each_rcu(</font></span><span style="caret-color: rgb(0, 0, 0);
                              font-family: Helvetica; font-size: 12px;
                              font-style: normal; font-variant-caps:
                              normal; font-weight: 400; letter-spacing:
                              normal; text-align: start; text-indent:
                              0px; text-transform: none; white-space:
                              normal; word-spacing: 0px;
                              -webkit-text-stroke-width: 0px;
                              text-decoration: none; float: none;
                              display: inline !important;" class=""><font class="" size="4">p_info) &nbsp;&nbsp; <br class="">
                                &nbsp;&nbsp;&nbsp; cancel_delayed_work_sync(&amp;</font></span><span style="caret-color: rgb(0, 0, 0);
                              font-family: Helvetica; font-size: 12px;
                              font-style: normal; font-variant-caps:
                              normal; font-weight: 400; letter-spacing:
                              normal; text-align: start; text-indent:
                              0px; text-transform: none; white-space:
                              normal; word-spacing: 0px;
                              -webkit-text-stroke-width: 0px;
                              text-decoration: none; float: none;
                              display: inline !important;" class=""><font class="" size="4"><span style="caret-color: rgb(0, 0, 0);
                                  font-family: Helvetica; font-size:
                                  12px; font-style: normal;
                                  font-variant-caps: normal;
                                  font-weight: 400; letter-spacing:
                                  normal; text-align: start;
                                  text-indent: 0px; text-transform:
                                  none; white-space: normal;
                                  word-spacing: 0px;
                                  -webkit-text-stroke-width: 0px;
                                  text-decoration: none; float: none;
                                  display: inline !important;" class=""></span><span style="caret-color: rgb(0, 0, 0);
                                  font-family: Helvetica; font-size:
                                  12px; font-style: normal;
                                  font-variant-caps: normal;
                                  font-weight: 400; letter-spacing:
                                  normal; text-align: start;
                                  text-indent: 0px; text-transform:
                                  none; white-space: normal;
                                  word-spacing: 0px;
                                  -webkit-text-stroke-width: 0px;
                                  text-decoration: none; float: none;
                                  display: inline !important;" class=""><font class="" size="4">p_info</font></span>-&gt;restore_userptr_work)
                                <br class="">
                              </font></span></p>
                          <p class=""><span style="caret-color: rgb(0,
                              0, 0); font-family: Helvetica; font-size:
                              12px; font-style: normal;
                              font-variant-caps: normal; font-weight:
                              400; letter-spacing: normal; text-align:
                              start; text-indent: 0px; text-transform:
                              none; white-space: normal; word-spacing:
                              0px; -webkit-text-stroke-width: 0px;
                              text-decoration: none; float: none;
                              display: inline !important;" class=""><font class="" size="4">instead&nbsp; at least that
                                what i meant in the previous mail.&nbsp;</font></span></p>
                        </div>
                      </div>
                    </blockquote>
                    <div class="">I actually tried that earlier, and it
                      did not work. Application still keeps running, and
                      you have to send a kill to the user process.</div>
                    <div class=""><br class="">
                    </div>
                    <div class="">I have made the following version. It
                      waits for processes to terminate synchronously
                      after sending SIGBUS. After that it does the real
                      work of amdgpu_pci_remove.</div>
                    <div class="">However, it hangs at
                      amdgpu_device_ip_fini_early when it is trying to
                      deinit ip_block 6 &lt;sdma_v4_0&gt; (<a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux%2F-%2Fblob%2Famd-staging-drm-next%2Fdrivers%2Fgpu%2Fdrm%2Famd%2Famdgpu%2Famdgpu_device.c%23L2818&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Cc74b47c7231b430bae5508da1ec870de%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637856143531476565%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=PHmqeYxqJ9WJ4IHDphaQqrhfTC95DL6%2B8NpbIyxtykI%3D&amp;reserved=0" originalsrc="https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L2818" shash="McVglBWzn1RU1/WQY8Uydr3Y65+roao4G4yTAPlyDVxciw1OBLiAEcbfa05eBa9RoA5gEmwtUwGpO7lfWsr8YhJ/bNmyihyET9GhkDKzs7earlJZVXxpWnXpP4zScblwmswAqQ8n5B8hb0ZjNYRFG78GSHWTYuXJliwLXgkefd4=" class="" moz-do-not-send="true">https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-
 drm-next/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L2818</a>).
                      I assume that there are still some inflight dma,
                      therefore fini of this ip block thus hangs?&nbsp;</div>
                    <div class=""><br class="">
                    </div>
                    <div class="">The following is an excerpt of the
                      dmesg: please excuse for putting my own pr_info,
                      but I hope you get my point of where it hangs.</div>
                    <div class=""><br class="">
                    </div>
                    <div class="">
                      <div class="">[ &nbsp;392.344735] amdgpu: all processes
                        has been fully released</div>
                      <div class="">[ &nbsp;392.346557] amdgpu:
                        amdgpu_acpi_fini done</div>
                      <div class="">[ &nbsp;392.346568] amdgpu 0000:b3:00.0:
                        amdgpu: amdgpu: finishing device.</div>
                      <div class="">[ &nbsp;392.349238] amdgpu:
                        amdgpu_device_ip_fini_early enter ip_blocks = 9</div>
                      <div class="">[ &nbsp;392.349248] amdgpu: Free mem_obj
                        = 000000007bf54275, range_start = 14, range_end
                        = 14</div>
                      <div class="">[ &nbsp;392.350299] amdgpu: Free mem_obj
                        = 00000000a85bc878, range_start = 12, range_end
                        = 12</div>
                      <div class="">[ &nbsp;392.350304] amdgpu: Free mem_obj
                        = 00000000b8019e32, range_start = 13, range_end
                        = 13</div>
                      <div class="">[ &nbsp;392.350308] amdgpu: Free mem_obj
                        = 000000002d296168, range_start = 4, range_end =
                        11</div>
                      <div class="">[ &nbsp;392.350313] amdgpu: Free mem_obj
                        = 000000001fc4f934, range_start = 0, range_end =
                        3</div>
                      <div class="">[ &nbsp;392.350322] amdgpu:
                        amdgpu_amdkfd_suspend(adev, false) done</div>
                      <div class="">[ &nbsp;392.350672] amdgpu: hw_fini of IP
                        block[8] &lt;jpeg_v2_5&gt; done 0</div>
                      <div class="">[ &nbsp;392.350679] amdgpu: hw_fini of IP
                        block[7] &lt;vcn_v2_5&gt; done 0</div>
                    </div>
                  </div>
                </blockquote>
                <p class=""><br class="">
                </p>
                <p class="">I just remembered that the idea to actively
                  kill and wait for running user processes during unplug
                  was rejected<br class="">
                  as a bad idea in the first iteration of unplug work I
                  did (don't remember why now, need to look) so this is
                  a no go.<br class="">
                </p>
              </div>
            </div>
          </blockquote>
          <div>Maybe an application has kfd open, but was not accessing
            the dev. So kill it at unplug could kill the process
            unnecessarily.</div>
          <div>However, the latest version I had with the sleep function
            got rid of the IP block fini hang.</div>
          <blockquote type="cite" class="">
            <div class="">
              <div class="">
                <p class="">Our policy is to let zombie processes
                  (zombie in a sense that the underlying device is gone)
                  live as long as they want
                  <br class="">
                  (as long as you able to terminate them - which you do,
                  so that ok)<br class="">
                  and the system should finish PCI remove gracefully and
                  be able to hot plug back the device.&nbsp; Hence, i suggest
                  dropping<br class="">
                  this direction of forcing all user processes to be
                  killed, confirm you have graceful shutdown and remove
                  of device<br class="">
                  from PCI topology and then concentrate on why when you
                  plug back it hangs. </p>
              </div>
            </div>
          </blockquote>
          So I basically revert back to the original solution which you
          suggested.</div>
        <div><br class="">
        </div>
        <div>
          <div>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
            b/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
          <div>index 4e7d9cb09a69..5504a18b5a45 100644</div>
          <div>--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
          <div>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
          <div>@@ -697,7 +697,7 @@ void kgd2kfd_suspend(struct kfd_dev
            *kfd, bool run_pm, bool force)</div>
          <div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return;</div>
          <div><br class="">
          </div>
          <div>&nbsp; &nbsp; &nbsp; &nbsp; /* for runtime suspend, skip locking kfd */</div>
          <div>- &nbsp; &nbsp; &nbsp; if (!run_pm) {</div>
          <div>+ &nbsp; &nbsp; &nbsp; if (!run_pm &amp;&amp;
            !drm_dev_is_unplugged(kfd-&gt;ddev)) {</div>
          <div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* For first KFD device suspend all the
            KFD processes */</div>
          <div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (atomic_inc_return(&amp;kfd_locked) ==
            1)</div>
          <div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; kfd_suspend_all_processes(force);</div>
        </div>
        <div><br class="">
        </div>
        <div>
          <blockquote type="cite" class="">
            <div class="">
              <p class="">First confirm if ASIC reset happens on<br class="">
                next init. </p>
            </div>
          </blockquote>
          <div>
            <div>This patch works great at <b class="">planned</b>
              plugout, where all the rocm processes are killed before
              plugout. And device can be added back without a problem.</div>
            <div>However <b class="">unplanned</b> plugout when there
              is rocm processes are running just don’t work.</div>
          </div>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>Still I am not clear if ASIC reset happens on plug back or no,
      can you trace this please ?</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:76C16B06-0539-48EE-AB11-80089490CE3A@microsoft.com">
      <div class="">
        <div>
          <div>
          </div>
          <blockquote type="cite" class="">
            <div class="">
              <p class="">Second please confirm if the timing you kill
                manually the user process has impact on whether you have
                a hang<br class="">
                on next plug back (if you kill before </p>
            </div>
          </blockquote>
          <b class="">Scenario 0: Kill before plug back</b></div>
        <div><br class="">
        </div>
        <div>
          <div>1. echo 1 &gt; /sys/bus/pci/…/remove, would finish.&nbsp;</div>
          <div>But the application won’t exit until there is a kill
            signal.</div>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>Why you think it must exit ? <br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:76C16B06-0539-48EE-AB11-80089490CE3A@microsoft.com">
      <div class="">
        <div>
          <div><br class="">
          </div>
          <div>2. kill the the process. The application does several
            things and seems trigger drm_release in the kernel, which
            are met with kernel NULL pointer deference related to
            sysfs_remove. Then the whole fs just freeze.</div>
          <div><br class="">
          </div>
          <div>
            <div>[ &nbsp;+0.002498] BUG: kernel NULL pointer dereference,
              address: 0000000000000098</div>
            <div>[ &nbsp;+0.000486] #PF: supervisor read access in kernel
              mode</div>
            <div>[ &nbsp;+0.000545] #PF: error_code(0x0000) - not-present
              page</div>
            <div>[ &nbsp;+0.000551] PGD 0 P4D 0</div>
            <div>[ &nbsp;+0.000553] Oops: 0000 [#1] SMP NOPTI</div>
            <div>[ &nbsp;+0.000540] CPU: 75 PID: 4911 Comm: kworker/75:2
              Tainted: G &nbsp; &nbsp; &nbsp; &nbsp;W &nbsp; E &nbsp; &nbsp; 5.13.0-kfd #1</div>
            <div>[ &nbsp;+0.000559] Hardware name: INGRASYS &nbsp; &nbsp; &nbsp; &nbsp; TURING
              &nbsp;/MB &nbsp; &nbsp; &nbsp;, BIOS K71FQ28A 10/05/2021</div>
            <div>[ &nbsp;+0.000567] Workqueue: events delayed_fput</div>
            <div>[ &nbsp;+0.000563] RIP: 0010:kernfs_find_ns+0x1b/0x100</div>
            <div>[ &nbsp;+0.000569] Code: ff ff e8 88 59 9f 00 0f 1f 84 00 00
              00 00 00 0f 1f 44 00 00 41 57 8b 05 df f0 7b 01 41 56 41
              55 49 89 f5 41 54 55 48 89 fd 53 &lt;44&gt; 0f b7 b7 98 00
              00 00 48 89 d3 4c 8b 67 70 66 41 83 e6 20 41 0f</div>
            <div>[ &nbsp;+0.001193] RSP: 0018:ffffb9875db5fc98 EFLAGS:
              00010246</div>
            <div>[ &nbsp;+0.000602] RAX: 0000000000000000 RBX:
              ffffa101f79507d8 RCX: 0000000000000000</div>
            <div>[ &nbsp;+0.000612] RDX: 0000000000000000 RSI:
              ffffffffc09a9417 RDI: 0000000000000000</div>
            <div>[ &nbsp;+0.000604] RBP: 0000000000000000 R08:
              0000000000000001 R09: 0000000000000000</div>
            <div>[ &nbsp;+0.000760] R10: ffffb9875db5fcd0 R11:
              0000000000000000 R12: 0000000000000000</div>
            <div>[ &nbsp;+0.000597] R13: ffffffffc09a9417 R14:
              ffffa08363fb2d18 R15: 0000000000000000</div>
            <div>[ &nbsp;+0.000702] FS: &nbsp;0000000000000000(0000)
              GS:ffffa0ffbfcc0000(0000) knlGS:0000000000000000</div>
            <div>[ &nbsp;+0.000666] CS: &nbsp;0010 DS: 0000 ES: 0000 CR0:
              0000000080050033</div>
            <div>[ &nbsp;+0.000658] CR2: 0000000000000098 CR3:
              0000005747812005 CR4: 0000000000770ee0</div>
            <div>[ &nbsp;+0.000715] DR0: 0000000000000000 DR1:
              0000000000000000 DR2: 0000000000000000</div>
            <div>[ &nbsp;+0.000655] DR3: 0000000000000000 DR6:
              00000000fffe0ff0 DR7: 0000000000000400</div>
            <div>[ &nbsp;+0.000592] PKRU: 55555554</div>
            <div>[ &nbsp;+0.000580] Call Trace:</div>
            <div>[ &nbsp;+0.000591] &nbsp;kernfs_find_and_get_ns+0x2f/0x50</div>
            <div>[ &nbsp;+0.000584] &nbsp;sysfs_remove_file_from_group+0x20/0x50</div>
            <div>[ &nbsp;+0.000580] &nbsp;amdgpu_ras_sysfs_remove+0x3d/0xd0
              [amdgpu]</div>
            <div>[ &nbsp;+0.000737] &nbsp;amdgpu_ras_late_fini+0x1d/0x40 [amdgpu]</div>
            <div>[ &nbsp;+0.000750] &nbsp;amdgpu_sdma_ras_fini+0x96/0xb0 [amdgpu]</div>
            <div>[ &nbsp;+0.000742] &nbsp;? gfx_v10_0_resume+0x10/0x10 [amdgpu]</div>
            <div>[ &nbsp;+0.000738] &nbsp;sdma_v4_0_sw_fini+0x23/0x90 [amdgpu]</div>
            <div>[ &nbsp;+0.000717] &nbsp;amdgpu_device_fini_sw+0xae/0x260
              [amdgpu]</div>
            <div>[ &nbsp;+0.000704] &nbsp;amdgpu_driver_release_kms+0x12/0x30
              [amdgpu]</div>
            <div>[ &nbsp;+0.000687] &nbsp;drm_dev_release+0x20/0x40 [drm]</div>
            <div>[ &nbsp;+0.000583] &nbsp;drm_release+0xa8/0xf0 [drm]</div>
            <div>[ &nbsp;+0.000584] &nbsp;__fput+0xa5/0x250</div>
            <div>[ &nbsp;+0.000621] &nbsp;delayed_fput+0x1f/0x30</div>
            <div>[ &nbsp;+0.000726] &nbsp;process_one_work+0x26e/0x580</div>
            <div>[ &nbsp;+0.000581] &nbsp;? process_one_work+0x580/0x580</div>
            <div>[ &nbsp;+0.000611] &nbsp;worker_thread+0x4d/0x3d0</div>
            <div>[ &nbsp;+0.000611] &nbsp;? process_one_work+0x580/0x580</div>
            <div>[ &nbsp;+0.000605] &nbsp;kthread+0x117/0x150</div>
            <div>[ &nbsp;+0.000611] &nbsp;? kthread_park+0x90/0x90</div>
            <div>[ &nbsp;+0.000619] &nbsp;ret_from_fork+0x1f/0x30</div>
            <div>[ &nbsp;+0.000625] Modules linked in: amdgpu(E) xt_conntrack
              xt_MASQUERADE nfnetlink xt_addrtype iptable_filter
              iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
              nf_defrag_ipv4 br_netfilter x86_pkg_temp_thermal cdc_ether
              usbnet acpi_pad msr ip_tables x_tables ast drm_vram_helper
              iommu_v2 drm_ttm_helper gpu_sched ttm drm_kms_helper
              cfbfillrect syscopyarea cfbimgblt sysfillrect sysimgblt
              fb_sys_fops cfbcopyarea drm drm_panel_orientati</div>
            <div>on_quirks [last unloaded: amdgpu]</div>
          </div>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>This is a known regression, all SYSFS components must be removed
      before pci_remove code runs otherwise you get either warnings for
      single file removals or<br>
      OOPSEs for sysfs gorup removals like here. Please try to move
      amdgpu_ras_sysfs_remove from amdgpu_ras_late_fini to the end of
      amdgpu_ras_pre_fini (which happens before pci remove)</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:76C16B06-0539-48EE-AB11-80089490CE3A@microsoft.com">
      <div class="">
        <div>
          <div>
            <div><br class="">
            </div>
            <div>3. &nbsp;echo 1 &gt; /sys/bus/pci/rescan. This would just
              hang. I assume the sysfs is broken.</div>
            <div><br class="">
            </div>
            <div>Based on 1 &amp; 2, it seems that 1 won’t let the
              amdgpu exit gracefully, because 2 will do some cleanup
              maybe should have happened before 1.</div>
            <div>
              <blockquote type="cite" class="">
                <div class="">
                  <p class="">or you kill after plug back does it makes
                    a difference).&nbsp;<br class="">
                  </p>
                </div>
              </blockquote>
            </div>
            <div><b class="">Scenario 2: Kill after plug back</b></div>
            <div><br class="">
            </div>
            <div>If I perform rescan before kill, then the driver seemed
              probed fine. But kill will have the same issue which
              messed up the sysfs the same way as in Scenario 2.</div>
            <div><br class="">
            </div>
            <div><br class="">
            </div>
            <div><b class="">Final Comments:</b></div>
            <div><br class="">
            </div>
            <span class="">0.&nbsp;cancel_delayed_work_sync(&amp;p_info-&gt;restore_userptr_work)
              would&nbsp;make the&nbsp;repletion of
            </span>amdgpu_vm_bo_update failure go away, but it does not
            solve the issues in those scenarios.</div>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>Still - it's better to do it this way even for those failures to
      go awaya</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:76C16B06-0539-48EE-AB11-80089490CE3A@microsoft.com">
      <div class="">
        <div>
          <div><span class=""><br class="">
            </span>
            <div>1. For planned hotplug, this patch should work as long
              as you follow some protocol, i.e. kill before plugout. Is
              this patch an acceptable one since it provides some added
              feature than before?</div>
          </div>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>Let's try to fix more as I advised above. <br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:76C16B06-0539-48EE-AB11-80089490CE3A@microsoft.com">
      <div class="">
        <div>
          <div>
            <div><br class="">
            </div>
            <div>2. For unplanned hotplug when there is rocm app
              running, the patch that kill all processes and wait for 5
              sec would work consistently. But it seems that it is an
              unacceptable solution for official release. I can hold it
              for our own internal usage. &nbsp;It seems that kill after
              removal would cause problems, and I don’t know if there is
              a quick fix by me because of my limited understanding of
              the amdgpu driver. Maybe AMD could have a quick fix; Or it
              is really a difficult one. This feature may or may not be
              a blocking issue in our GPU disaggregation research down
              the way. Please let us know for either cases, and we would
              like to learn and help as much as we could!</div>
          </div>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>I am currently not sure why it helps. I will need to setup my own
      ROCm setup and retest hot plug to check this in more depth but
      currently i have higher priorities. Please try to confirm ASIC
      reset always takes place on plug back<br>
      and fix the sysfs OOPs as I advised above to clear up at least
      some of the issues. Also please describe to me exactly what you
      steps to reproduce this scenario so later I might be able to do it
      myself.</p>
    <p>Also, we have hotplug test suite in libdrm (graphic stack), so
      maybe u can install libdrm and run that test suite to see if it
      exposes more issues.<br>
    </p>
    <p>Andrey</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:76C16B06-0539-48EE-AB11-80089490CE3A@microsoft.com">
      <div class="">
        <div>
          <div>
            <div class=""><br class="">
            </div>
            <div class="">Thank you so much!</div>
            <div class=""><br class="">
            </div>
            <div class="">Best regards,</div>
            <div class="">Shuotao</div>
          </div>
          <blockquote type="cite" class="">
            <div class="">
              <p class="">Andrey</p>
              <p class=""><br class="">
              </p>
              <blockquote type="cite" cite="mid:B7970589-ACF6-41F3-8622-1C0F705F3EE0@microsoft.com" class="">
                <div class="">
                  <div class=""><br class="">
                  </div>
                  <div class=""><br class="">
                  </div>
                  <div class="">
                    <div class="">diff --git
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c</div>
                    <div class="">index 8fa9b86ac9d2..c0b27f722281
                      100644</div>
                    <div class="">---
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c</div>
                    <div class="">+++
                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c</div>
                    <div class="">@@ -188,6 +188,12 @@ void
                      amdgpu_amdkfd_interrupt(struct amdgpu_device
                      *adev,</div>
                    <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>kgd2kfd_interrupt(adev-&gt;kfd.dev,
                      ih_ring_entry);</div>
                    <div class="">&nbsp;}</div>
                    <div class="">&nbsp;</div>
                    <div class="">+void
                      amdgpu_amdkfd_kill_all_processes(struct
                      amdgpu_device *adev)</div>
                    <div class="">+{</div>
                    <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>if
                      (adev-&gt;kfd.dev)</div>
                    <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>kgd2kfd_kill_all_user_processes(adev-&gt;kfd.dev);</div>
                    <div class="">+}</div>
                    <div class="">+</div>
                    <div class="">&nbsp;void amdgpu_amdkfd_suspend(struct
                      amdgpu_device *adev, bool run_pm)</div>
                    <div class="">&nbsp;{</div>
                    <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>if
                      (adev-&gt;kfd.dev)</div>
                    <div class="">diff --git
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h</div>
                    <div class="">index 27c74fcec455..f4e485d60442
                      100644</div>
                    <div class="">---
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h</div>
                    <div class="">+++
                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h</div>
                    <div class="">@@ -141,6 +141,7 @@ struct
                      amdkfd_process_info {</div>
                    <div class="">&nbsp;int amdgpu_amdkfd_init(void);</div>
                    <div class="">&nbsp;void amdgpu_amdkfd_fini(void);</div>
                    <div class="">&nbsp;</div>
                    <div class="">+void
                      amdgpu_amdkfd_kill_all_processes(struct
                      amdgpu_device *adev);</div>
                    <div class="">&nbsp;void amdgpu_amdkfd_suspend(struct
                      amdgpu_device *adev, bool run_pm);</div>
                    <div class="">&nbsp;int amdgpu_amdkfd_resume_iommu(struct
                      amdgpu_device *adev);</div>
                    <div class="">&nbsp;int amdgpu_amdkfd_resume(struct
                      amdgpu_device *adev, bool run_pm, bool sync);</div>
                    <div class="">@@ -405,6 +406,7 @@ bool
                      kgd2kfd_device_init(struct kfd_dev *kfd,</div>
                    <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>const
                      struct kgd2kfd_shared_resources *gpu_resources);</div>
                    <div class="">&nbsp;void kgd2kfd_device_exit(struct
                      kfd_dev *kfd);</div>
                    <div class="">&nbsp;void kgd2kfd_suspend(struct kfd_dev
                      *kfd, bool run_pm, bool force);</div>
                    <div class="">+void
                      kgd2kfd_kill_all_user_processes(struct kfd_dev
                      *kfd);</div>
                    <div class="">&nbsp;int kgd2kfd_resume_iommu(struct
                      kfd_dev *kfd);</div>
                    <div class="">&nbsp;int kgd2kfd_resume(struct kfd_dev
                      *kfd, bool run_pm, bool sync);</div>
                    <div class="">&nbsp;int kgd2kfd_pre_reset(struct kfd_dev
                      *kfd);</div>
                    <div class="">@@ -443,6 +445,9 @@ static inline void
                      kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm,
                      bool force)</div>
                    <div class="">&nbsp;{</div>
                    <div class="">&nbsp;}</div>
                    <div class="">&nbsp;</div>
                    <div class="">+void
                      kgd2kfd_kill_all_user_processes(struct kfd_dev
                      *kfd){</div>
                    <div class="">+}</div>
                    <div class="">+</div>
                    <div class="">&nbsp;static int __maybe_unused
                      kgd2kfd_resume_iommu(struct kfd_dev *kfd)</div>
                    <div class="">&nbsp;{</div>
                    <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>return
                      0;</div>
                    <div class="">diff --git
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c</div>
                    <div class="">index 3d5fc0751829..af6fe5080cfa
                      100644</div>
                    <div class="">---
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c</div>
                    <div class="">+++
                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c</div>
                    <div class="">@@ -2101,6 +2101,9 @@
                      amdgpu_pci_remove(struct pci_dev *pdev)</div>
                    <div class="">&nbsp;{</div>
                    <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>struct
                      drm_device *dev = pci_get_drvdata(pdev);</div>
                    <div class="">&nbsp;</div>
                    <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>/*
                      kill all kfd processes before drm_dev_unplug */</div>
                    <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>amdgpu_amdkfd_kill_all_processes(drm_to_adev(dev));</div>
                    <div class="">+</div>
                    <div class="">&nbsp;#ifdef HAVE_DRM_DEV_UNPLUG</div>
                    <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>drm_dev_unplug(dev);</div>
                    <div class="">&nbsp;#else</div>
                    <div class="">diff --git
                      a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
                      b/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
                    <div class="">index 5504a18b5a45..480c23bef5e2
                      100644</div>
                    <div class="">---
                      a/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
                    <div class="">+++
                      b/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
                    <div class="">@@ -691,6 +691,12 @@ bool
                      kfd_is_locked(void)</div>
                    <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>return
                      &nbsp;(atomic_read(&amp;kfd_locked) &gt; 0);</div>
                    <div class="">&nbsp;}</div>
                    <div class="">&nbsp;</div>
                    <div class="">+inline void
                      kgd2kfd_kill_all_user_processes(struct kfd_dev*
                      dev)</div>
                    <div class="">+{</div>
                    <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>kfd_kill_all_user_processes();</div>
                    <div class="">+}</div>
                    <div class="">+</div>
                    <div class="">+</div>
                    <div class="">&nbsp;void kgd2kfd_suspend(struct kfd_dev
                      *kfd, bool run_pm, bool force)</div>
                    <div class="">&nbsp;{</div>
                    <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>if
                      (!kfd-&gt;init_complete)</div>
                    <div class="">diff --git
                      a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
                      b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h</div>
                    <div class="">index 55c9e1922714..a35a2cb5bb9f
                      100644</div>
                    <div class="">---
                      a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h</div>
                    <div class="">+++
                      b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h</div>
                    <div class="">@@ -1064,6 +1064,7 @@ static inline
                      struct kfd_process_device
                      *kfd_process_device_from_gpuidx(</div>
                    <div class="">&nbsp;void kfd_unref_process(struct
                      kfd_process *p);</div>
                    <div class="">&nbsp;int kfd_process_evict_queues(struct
                      kfd_process *p, bool force);</div>
                    <div class="">&nbsp;int kfd_process_restore_queues(struct
                      kfd_process *p);</div>
                    <div class="">+void
                      kfd_kill_all_user_processes(void);</div>
                    <div class="">&nbsp;void kfd_suspend_all_processes(bool
                      force);</div>
                    <div class="">&nbsp;/*</div>
                    <div class="">&nbsp; * kfd_resume_all_processes:</div>
                    <div class="">diff --git
                      a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
                      b/drivers/gpu/drm/amd/amdkfd/kfd_process.c</div>
                    <div class="">index 6cdc855abb6d..17e769e6951d
                      100644</div>
                    <div class="">---
                      a/drivers/gpu/drm/amd/amdkfd/kfd_process.c</div>
                    <div class="">+++
                      b/drivers/gpu/drm/amd/amdkfd/kfd_process.c</div>
                    <div class="">@@ -46,6 +46,9 @@ struct mm_struct;</div>
                    <div class="">&nbsp;#include &quot;kfd_trace.h&quot;</div>
                    <div class="">&nbsp;#include &quot;kfd_debug.h&quot;</div>
                    <div class="">&nbsp;</div>
                    <div class="">+static atomic_t kfd_process_locked =
                      ATOMIC_INIT(0);</div>
                    <div class="">+static atomic_t kfd_inflight_kills =
                      ATOMIC_INIT(0);</div>
                    <div class="">+</div>
                    <div class="">&nbsp;/*</div>
                    <div class="">&nbsp; * List of struct kfd_process (field
                      kfd_process).</div>
                    <div class="">&nbsp; * Unique/indexed by mm_struct*</div>
                    <div class="">@@ -802,6 +805,9 @@ struct kfd_process
                      *kfd_create_process(struct task_struct *thread)</div>
                    <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>struct
                      kfd_process *process;</div>
                    <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>int
                      ret;</div>
                    <div class="">&nbsp;</div>
                    <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>if
                      ( atomic_read(&amp;kfd_process_locked) &gt; 0 )</div>
                    <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>return
                      ERR_PTR(-EINVAL);</div>
                    <div class="">+</div>
                    <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>if
                      (!(thread-&gt;mm &amp;&amp;
                      mmget_not_zero(thread-&gt;mm)))</div>
                    <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>return
                      ERR_PTR(-EINVAL);</div>
                    <div class="">&nbsp;</div>
                    <div class="">@@ -1126,6 +1132,10 @@ static void
                      kfd_process_wq_release(struct work_struct *work)</div>
                    <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>put_task_struct(p-&gt;lead_thread);</div>
                    <div class="">&nbsp;</div>
                    <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>kfree(p);</div>
                    <div class="">+</div>
                    <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>if
                      ( atomic_read(&amp;kfd_process_locked) &gt; 0 ){</div>
                    <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>atomic_dec(&amp;kfd_inflight_kills);</div>
                    <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>}</div>
                    <div class="">&nbsp;}</div>
                    <div class="">&nbsp;</div>
                    <div class="">&nbsp;static void
                      kfd_process_ref_release(struct kref *ref)</div>
                    <div class="">@@ -2186,6 +2196,35 @@ static void
                      restore_process_worker(struct work_struct *work)</div>
                    <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>pr_err(&quot;Failed
                      to restore queues of pasid 0x%x\n&quot;, p-&gt;pasid);</div>
                    <div class="">&nbsp;}</div>
                    <div class="">&nbsp;</div>
                    <div class="">+void
                      kfd_kill_all_user_processes(void)</div>
                    <div class="">+{</div>
                    <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>struct
                      kfd_process *p;</div>
                    <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>/*
                      struct amdkfd_process_info *p_info; */</div>
                    <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>unsigned
                      int temp;</div>
                    <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>int
                      idx;</div>
                    <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>atomic_inc(&amp;kfd_process_locked);</div>
                    <div class="">+</div>
                    <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>idx
                      = srcu_read_lock(&amp;kfd_processes_srcu);</div>
                    <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>pr_info(&quot;Killing
                      all processes\n&quot;);</div>
                    <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>hash_for_each_rcu(kfd_processes_table,
                      temp, p, kfd_processes) {</div>
                    <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>dev_warn(kfd_device,</div>
                    <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>&quot;Sending
                      SIGBUS to process %d (pasid 0x%x)&quot;,</div>
                    <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>p-&gt;lead_thread-&gt;pid,
                      p-&gt;pasid);</div>
                    <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>send_sig(SIGBUS,
                      p-&gt;lead_thread, 0);</div>
                    <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>atomic_inc(&amp;kfd_inflight_kills);</div>
                    <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>}</div>
                    <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>srcu_read_unlock(&amp;kfd_processes_srcu,
                      idx);</div>
                    <div class="">+</div>
                    <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>while
                      ( atomic_read(&amp;kfd_inflight_kills) &gt; 0 ){</div>
                    <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>dev_warn(kfd_device,</div>
                    <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>&quot;kfd_processes_table
                      is not empty, going to sleep for 10ms\n&quot;);</div>
                    <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>msleep(10);</div>
                    <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>}</div>
                    <div class="">+</div>
                    <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>atomic_dec(&amp;kfd_process_locked);</div>
                    <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>pr_info(&quot;all
                      processes has been fully released&quot;);</div>
                    <div class="">+}</div>
                    <div class="">+</div>
                    <div class="">&nbsp;void kfd_suspend_all_processes(bool
                      force)</div>
                    <div class="">&nbsp;{</div>
                    <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>struct
                      kfd_process *p;</div>
                    <div class=""><br class="">
                    </div>
                    <div class=""><br class="">
                    </div>
                  </div>
                  <div class=""><br class="">
                  </div>
                  <div class="">Regards,</div>
                  <div class="">Shuotao</div>
                  <br class="">
                  <blockquote type="cite" class="">
                    <div class="">
                      <div class="">
                        <div class=""><span style="caret-color: rgb(0,
                            0, 0); font-family: Helvetica; font-size:
                            12px; font-style: normal; font-variant-caps:
                            normal; font-weight: 400; letter-spacing:
                            normal; text-align: start; text-indent: 0px;
                            text-transform: none; white-space: normal;
                            word-spacing: 0px;
                            -webkit-text-stroke-width: 0px;
                            text-decoration: none; float: none; display:
                            inline !important;" class=""></span><br class="webkit-block-placeholder">
                        </div>
                        <p class=""><span style="caret-color: rgb(0, 0,
                            0); font-family: Helvetica; font-size: 12px;
                            font-style: normal; font-variant-caps:
                            normal; font-weight: 400; letter-spacing:
                            normal; text-align: start; text-indent: 0px;
                            text-transform: none; white-space: normal;
                            word-spacing: 0px;
                            -webkit-text-stroke-width: 0px;
                            text-decoration: none; float: none; display:
                            inline !important;" class=""><font class="" size="4">Andrey</font><br class="">
                            <br class="">
                          </span></p>
                        <blockquote type="cite" cite="mid:5A64FAEA-CCE8-4EB6-8E7B-852D4F384255@microsoft.com" class="">
                          <div class="">+ &nbsp; &nbsp; &nbsp; }</div>
                          <div class="">+ &nbsp; &nbsp; &nbsp;
                            srcu_read_unlock(&amp;kfd_processes_srcu,
                            idx);</div>
                          <div class="">+}</div>
                          <div class="">+</div>
                          <div class="">+</div>
                          <div class="">&nbsp;int
                            kfd_resume_all_processes(bool sync)</div>
                          <div class="">&nbsp;{</div>
                          <div class="">&nbsp; &nbsp; &nbsp; &nbsp; struct kfd_process *p;</div>
                          <div class=""><br class="">
                          </div>
                          <div class=""><br class="">
                            <blockquote type="cite" class="">
                              <div class=""><span style="caret-color:
                                  rgb(0, 0, 0); font-family: Helvetica;
                                  font-size: 12px; font-style: normal;
                                  font-variant-caps: normal;
                                  font-weight: 400; letter-spacing:
                                  normal; text-align: start;
                                  text-indent: 0px; text-transform:
                                  none; white-space: normal;
                                  word-spacing: 0px;
                                  -webkit-text-stroke-width: 0px;
                                  text-decoration: none; float: none;
                                  display: inline !important;" class="">Andrey</span><br style="caret-color: rgb(0, 0, 0);
                                  font-family: Helvetica; font-size:
                                  12px; font-style: normal;
                                  font-variant-caps: normal;
                                  font-weight: 400; letter-spacing:
                                  normal; text-align: start;
                                  text-indent: 0px; text-transform:
                                  none; white-space: normal;
                                  word-spacing: 0px;
                                  -webkit-text-stroke-width: 0px;
                                  text-decoration: none;" class="">
                                <br style="caret-color: rgb(0, 0, 0);
                                  font-family: Helvetica; font-size:
                                  12px; font-style: normal;
                                  font-variant-caps: normal;
                                  font-weight: 400; letter-spacing:
                                  normal; text-align: start;
                                  text-indent: 0px; text-transform:
                                  none; white-space: normal;
                                  word-spacing: 0px;
                                  -webkit-text-stroke-width: 0px;
                                  text-decoration: none;" class="">
                                <br style="caret-color: rgb(0, 0, 0);
                                  font-family: Helvetica; font-size:
                                  12px; font-style: normal;
                                  font-variant-caps: normal;
                                  font-weight: 400; letter-spacing:
                                  normal; text-align: start;
                                  text-indent: 0px; text-transform:
                                  none; white-space: normal;
                                  word-spacing: 0px;
                                  -webkit-text-stroke-width: 0px;
                                  text-decoration: none;" class="">
                                <blockquote type="cite" style="font-family: Helvetica;
                                  font-size: 12px; font-style: normal;
                                  font-variant-caps: normal;
                                  font-weight: 400; letter-spacing:
                                  normal; orphans: auto; text-align:
                                  start; text-indent: 0px;
                                  text-transform: none; white-space:
                                  normal; widows: auto; word-spacing:
                                  0px; -webkit-text-size-adjust: auto;
                                  -webkit-text-stroke-width: 0px;
                                  text-decoration: none;" class="">
                                  <br class="">
                                  Really appreciate your help!<br class="">
                                  <br class="">
                                  Best,<br class="">
                                  Shuotao<br class="">
                                  <br class="">
                                  <blockquote type="cite" class="">
                                    <blockquote type="cite" class="">2.
                                      Remove redudant p2p/io links in
                                      sysfs when device is hotplugged<br class="">
                                      out.<br class="">
                                      <br class="">
                                      3. New kfd node_id is not properly
                                      assigned after a new device is<br class="">
                                      added after a gpu is hotplugged
                                      out in a system. libhsakmt will<br class="">
                                      find this anomaly, (i.e. node_from
                                      != &lt;dev node id&gt; in
                                      iolinks),<br class="">
                                      when taking a topology_snapshot,
                                      thus returns fault to the rocm<br class="">
                                      stack.<br class="">
                                      <br class="">
                                      -- This patch fixes issue 1;
                                      another patch by Mukul fixes
                                      issues 2&amp;3.<br class="">
                                      -- Tested on a 4-GPU MI100 gpu
                                      nodes with kernel 5.13.0-kfd;
                                      kernel<br class="">
                                      5.16.0-kfd is unstable out of box
                                      for MI100.<br class="">
                                      ---<br class="">
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 5 +++++<br class="">
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 7 +++++++<br class="">
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +<br class="">
drivers/gpu/drm/amd/amdkfd/kfd_device.c | 13 +++++++++++++<br class="">
                                      4 files changed, 26 insertions(+)<br class="">
                                      <br class="">
                                      diff --git
                                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br class="">
                                      index c18c4be1e4ac..d50011bdb5c4
                                      100644<br class="">
                                      ---
                                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br class="">
                                      +++
                                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br class="">
                                      @@ -213,6 +213,11 @@ int
                                      amdgpu_amdkfd_resume(struct
                                      amdgpu_device *adev, bool run_pm)<br class="">
                                      return r;<br class="">
                                      }<br class="">
                                      <br class="">
                                      +int
                                      amdgpu_amdkfd_resume_processes(void)<br class="">
                                      +{<br class="">
                                      + return
                                      kgd2kfd_resume_processes();<br class="">
                                      +}<br class="">
                                      +<br class="">
                                      int amdgpu_amdkfd_pre_reset(struct
                                      amdgpu_device *adev)<br class="">
                                      {<br class="">
                                      int r = 0;<br class="">
                                      diff --git
                                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br class="">
                                      index f8b9f27adcf5..803306e011c3
                                      100644<br class="">
                                      ---
                                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br class="">
                                      +++
                                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br class="">
                                      @@ -140,6 +140,7 @@ void
                                      amdgpu_amdkfd_fini(void);<br class="">
                                      void amdgpu_amdkfd_suspend(struct
                                      amdgpu_device *adev, bool run_pm);<br class="">
                                      int
                                      amdgpu_amdkfd_resume_iommu(struct
                                      amdgpu_device *adev);<br class="">
                                      int amdgpu_amdkfd_resume(struct
                                      amdgpu_device *adev, bool run_pm);<br class="">
                                      +int
                                      amdgpu_amdkfd_resume_processes(void);<br class="">
                                      void
                                      amdgpu_amdkfd_interrupt(struct
                                      amdgpu_device *adev,<br class="">
                                      const void *ih_ring_entry);<br class="">
                                      void
                                      amdgpu_amdkfd_device_probe(struct
                                      amdgpu_device *adev);<br class="">
                                      @@ -347,6 +348,7 @@ void
                                      kgd2kfd_device_exit(struct kfd_dev
                                      *kfd);<br class="">
                                      void kgd2kfd_suspend(struct
                                      kfd_dev *kfd, bool run_pm);<br class="">
                                      int kgd2kfd_resume_iommu(struct
                                      kfd_dev *kfd);<br class="">
                                      int kgd2kfd_resume(struct kfd_dev
                                      *kfd, bool run_pm);<br class="">
                                      +int
                                      kgd2kfd_resume_processes(void);<br class="">
                                      int kgd2kfd_pre_reset(struct
                                      kfd_dev *kfd);<br class="">
                                      int kgd2kfd_post_reset(struct
                                      kfd_dev *kfd);<br class="">
                                      void kgd2kfd_interrupt(struct
                                      kfd_dev *kfd, const void
                                      *ih_ring_entry);<br class="">
                                      @@ -393,6 +395,11 @@ static inline
                                      int kgd2kfd_resume(struct kfd_dev
                                      *kfd, bool run_pm)<br class="">
                                      return 0;<br class="">
                                      }<br class="">
                                      <br class="">
                                      +static inline int
                                      kgd2kfd_resume_processes(void)<br class="">
                                      +{<br class="">
                                      + return 0;<br class="">
                                      +}<br class="">
                                      +<br class="">
                                      static inline int
                                      kgd2kfd_pre_reset(struct kfd_dev
                                      *kfd)<br class="">
                                      {<br class="">
                                      return 0;<br class="">
                                      diff --git
                                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br class="">
                                      index fa4a9f13c922..5827b65b7489
                                      100644<br class="">
                                      ---
                                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br class="">
                                      +++
                                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br class="">
                                      @@ -4004,6 +4004,7 @@ void
                                      amdgpu_device_fini_hw(struct
                                      amdgpu_device *adev)<br class="">
                                      if
                                      (drm_dev_is_unplugged(adev_to_drm(adev)))<br class="">
                                      amdgpu_device_unmap_mmio(adev);<br class="">
                                      <br class="">
                                      +
                                      amdgpu_amdkfd_resume_processes();<br class="">
                                      }<br class="">
                                      <br class="">
                                      void amdgpu_device_fini_sw(struct
                                      amdgpu_device *adev)<br class="">
                                      diff --git
                                      a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br class="">
                                      index 62aa6c9d5123..ef05aae9255e
                                      100644<br class="">
                                      ---
                                      a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br class="">
                                      +++
                                      b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br class="">
                                      @@ -714,6 +714,19 @@ int
                                      kgd2kfd_resume(struct kfd_dev
                                      *kfd, bool run_pm)<br class="">
                                      return ret;<br class="">
                                      }<br class="">
                                      <br class="">
                                      +/* for non-runtime resume only */<br class="">
                                      +int
                                      kgd2kfd_resume_processes(void)<br class="">
                                      +{<br class="">
                                      + int count;<br class="">
                                      +<br class="">
                                      + count =
                                      atomic_dec_return(&amp;kfd_locked);<br class="">
                                      + WARN_ONCE(count &lt; 0, &quot;KFD
                                      suspend / resume ref. error&quot;);<br class="">
                                      + if (count == 0)<br class="">
                                      + return
                                      kfd_resume_all_processes();<br class="">
                                      +<br class="">
                                      + return 0;<br class="">
                                      +}<br class="">
                                    </blockquote>
                                    <br class="">
                                    It doesn't make sense to me to just
                                    increment kfd_locked in<br class="">
                                    kgd2kfd_suspend to only decrement it
                                    again a few functions down the<br class="">
                                    road.<br class="">
                                    <br class="">
                                    I suggest this instead - you only
                                    incrmemnt if not during PCI remove<br class="">
                                    <br class="">
                                    diff --git
                                    a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br class="">
b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br class="">
                                    index 1c2cf3a33c1f..7754f77248a4
                                    100644<br class="">
                                    ---
                                    a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br class="">
                                    +++
                                    b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br class="">
                                    @@ -952,11 +952,12 @@ bool
                                    kfd_is_locked(void)<br class="">
                                    <br class="">
                                    void kgd2kfd_suspend(struct kfd_dev
                                    *kfd, bool run_pm)<br class="">
                                    {<br class="">
                                    +<br class="">
                                    if (!kfd-&gt;init_complete)<br class="">
                                    return;<br class="">
                                    <br class="">
                                    /* for runtime suspend, skip locking
                                    kfd */<br class="">
                                    - if (!run_pm) {<br class="">
                                    + if (!run_pm &amp;&amp;
                                    !drm_dev_is_unplugged(kfd-&gt;ddev))
                                    {<br class="">
                                    /* For first KFD device suspend all
                                    the KFD processes */<br class="">
                                    if
                                    (atomic_inc_return(&amp;kfd_locked)
                                    == 1)<br class="">
                                    kfd_suspend_all_processes();<br class="">
                                    <br class="">
                                    <br class="">
                                    Andrey<br class="">
                                    <br class="">
                                    <br class="">
                                    <br class="">
                                    <blockquote type="cite" class="">+<br class="">
                                      int kgd2kfd_resume_iommu(struct
                                      kfd_dev *kfd)<br class="">
                                      {<br class="">
                                      int err = 0;</blockquote>
                                  </blockquote>
                                </blockquote>
                              </div>
                            </blockquote>
                          </div>
                          <br class="">
                        </blockquote>
                      </div>
                    </div>
                  </blockquote>
                </div>
                <br class="">
              </blockquote>
            </div>
          </blockquote>
        </div>
        <br class="">
      </div>
    </blockquote>
  </body>
</html>

--------------P7oqr2ZhTfiCEKZs99D6sN0e--
