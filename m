Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DC8C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Apr 2022 15:23:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2002710E6D4;
	Mon, 18 Apr 2022 15:23:34 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F8FE10E34E
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Apr 2022 15:23:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mvin/OtmmyaWoRJi9cc2JdSEqWLdLrKV1jmM4b6ooKTZZDMpUAH+30Dw1/eneOUaYCwJJm5euIuC/OY5wNzgFi3le+EUJirGBDZF/o4Z3jmkPi3KmUTfZeg8dmdZnwVdGEXvvBd5Kf65N6/gW4Fq9h4xixLV+DWXCsBS9LkZNkInC+YNHxI5CeKSP0TKsQ+ECJ2bFLCpwi9ttmmxUwgXLcUkVO6MBdRDDSh5UDl+DHzd56erBn1jX5SIo5cdGUM8W+YvV5xFwusjuuVVgEcdnnXtXIC1YwxHwEMdpEn2YmEiaucbB5P/xVwulMB0IMQY02Nj/uo8eUuP3gFnNaGXAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7wn8R1bHuxcXta1qGLkEeOPEjLRJFBmokAIWz3EM0c=;
 b=ly35KyGmvMj1hBuT/oH79zPJ+jmlez26PLcfY/Q1AzYUZVszQjjvLNaMrAq/kLOgPVU04KRVl8nXeTpvZpR92R05NPpPNFr/lxzjACfSOr4rl/RcA6k+dcHzawmhCRitUfAMqV1GAjGwpjScMok/SciBIBuS9JV1LKv4PNntJmoL4zyLtHDg5V1aKDm4ax97KUapq74RFIniJAEXC8xSXjNNdB6TsozHWJoZyeDMuwsK+51w/dnqA3RuiOJdOiPuqM1PFPvupZ/36gz2hFDuZ4o3eDQI+dQyyUrOaTmk1nEVkN0NKiVDzc7TbuS+9o6I6EeXrqV/KKIbIn3soCp32A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7wn8R1bHuxcXta1qGLkEeOPEjLRJFBmokAIWz3EM0c=;
 b=bl5BTG6cuz4WlBtwjQppxrc87MXzkgV+C5Gm/e0+1hfksfuevytJuhmOUP9FG6OXSAt9pgWjH/tDl2k2XL1IabyuSFAXZbivmAemlr0K7cVzkUyWXstcChdTq2H02t1NJClVVV9AwvuJ4lkU/8uCu7XSP5E8wwhwsZ5Tlj5BZ0U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by CY4PR1201MB0102.namprd12.prod.outlook.com (2603:10b6:910:1b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Mon, 18 Apr
 2022 15:23:25 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::4967:ac3d:d5eb:ebb4]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::4967:ac3d:d5eb:ebb4%9]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 15:23:25 +0000
Content-Type: multipart/alternative;
 boundary="------------xrbxjLbD1QNXX7AXrR0UR8ux"
Message-ID: <c5a41b51-5275-05dc-2a4e-2522ddb898b9@amd.com>
Date: Mon, 18 Apr 2022 11:23:21 -0400
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
 <c82b697a-b032-1b03-8a9c-49af57f4ae9e@amd.com>
 <7825EEC6-BAF8-4B71-B01C-FE246D360779@microsoft.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <7825EEC6-BAF8-4B71-B01C-FE246D360779@microsoft.com>
X-ClientProxiedBy: YT3PR01CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::10) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91d6472d-70f3-4aa3-d9d0-08da214f6164
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0102:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB01029640AFDD5CCCD036519DEAF39@CY4PR1201MB0102.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IOykeOlwtzI6uBE89eqMRwFdAdO4AYunvwN8+dz5b6x/NrlWfg4FpILxYvHyebHVeEAuRdisah9AHPh8Gllc1GtnFt6CEp4hEUAck2m7ge3tLtVptavLBB7CQGZ+043QdSyxdqfxcbxb2Oz0NX2ea+vgyf+hgkv48UVZpU2QkYUzmte3bpC6fOgt8PuHxqJ+0ILYZtQdMMxcww3huzUdhdrSr68wQJMnRtJCVS/GzJIWwgM3IHKGLPk4cCcoIRXJCc01itH0HdVEDeFCPnfdQcMgjW5C8mjHfB3hbcT4J1vl9OWh842UhtPXy/mP4BjyASyMt3nM78AxJcT3tGCFpveBTsWHdj+/MYhWwj2v7QE9UlSa2Lcit52FqA4o9jpmsUF1QwRLLANcIhaLxYglltnxVEUAaMfzUeBzmcACabVBItDT4/Wk5lXzJmQOv2XvfO54Emoj0GBYeM1NtSzSYqw60m6KCgubJDdIms20qyat2mteYpVbhCe2MrV5LdKl+jv90Mc03WTRXSEW3T6H+BSRUuDwV9GMIBhwl6b7DXbfWP4vEytvdKli+2oWdmCIzq0nQ+CY1eDjK9eMRC+tOpczrZ15b3IYwZ9g0mrB2gYibHaB+Fid4m40tfrLfQjioMt27YVf0tdgL+giiBN3lDpaS5RAcmJVRHXwjGzTfW2g5qLTnZt5+h05UoHw3FBAzGyZ+s2HZ0N3chSbxIl/d2Yu4HffYw0QLyfYPUAkuCaHEFdPhn72DNWNHsFq8MtFsA9GipeepavyUOVFcJ3h4elVxtngsw8qneZLEaHTd7RRRuFH+76gILIZSWpgxqYCp+wyxng89AAxWSUGaD8q82ICMkaYmQgdiV3mmPVi13JiNtO0TZWRLECB+IsVgea2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(54906003)(6666004)(38100700002)(186003)(4326008)(316002)(66476007)(66556008)(8936002)(66946007)(6916009)(2616005)(31696002)(44832011)(966005)(30864003)(508600001)(2906002)(53546011)(6486002)(31686004)(45080400002)(86362001)(166002)(6506007)(33964004)(5660300002)(36756003)(83380400001)(6512007)(45980500001)(43740500002)(559001)(579004)(10090945011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3M4Y0FyUjVNWnpJNlB3R0FCRFZtclE3ZUs5eHVKQ1JMZHAvRDhMNGdwOERB?=
 =?utf-8?B?bTBhMzB1R1JGTW5QMUJGcGFVby9lUGdqRWJpQlVLRGVOMlhXODNLdUwvZlp6?=
 =?utf-8?B?MjJUVWtZMmhHa3FUNGJIdmxGcW5sZW1UM3VBUG1IanBucndzR2ovbGFzQW8z?=
 =?utf-8?B?T0tCRTd5b3pUWEFUemVqcEN5L2ZxOGU1TkJsMmVnM0FXcnVGd280VVlZVTFt?=
 =?utf-8?B?OHRKZ05DMDlzTGdndkV2TFI0SFk1eXljUnFZd00zWVNBVmNqUXhMMElxU0xs?=
 =?utf-8?B?SUZLaDI2RkR5SnE3WlhFa0ZMeWE0QlViQkYwMnVQb1ZhNWJ5b0QyUkg0NExO?=
 =?utf-8?B?NThQMFN0NVplZ1JjR0x4RFJIdnkvNjNkWC9pWjNySnMxdVg3ZjhqbWpBQkpZ?=
 =?utf-8?B?OENNZ3BXT0lXTUxDRE1UeFBPQVgvV0drTTh2WE9oMWhSc05BMzdtSWtXSVJB?=
 =?utf-8?B?L24ydGVlNmVKZVBGSGJERG93d2oraDNIL0dBU0pKQXNXU0VVcXpQU0FRcnVx?=
 =?utf-8?B?MWsyczFtbzg1OGVZVmptR1ZBMXFjWjN2N0VTTFF2RkN4N2tSeGhKellzUkhE?=
 =?utf-8?B?K29CQU1ObnhDRW1aNnVtYTlnL3pRTW5rbUdMVWdLcmlKcXBJOWorRmMrM00v?=
 =?utf-8?B?TDNzMWd4bTdOaVhSMXVuS2JORXhjdmFITklVNGpWVUFtVjJFZFhGNHZZZFFE?=
 =?utf-8?B?ZUt2THUwQ2d5WTRKYXVpaEtmNmxsTnVSMklpcklJemxRYWtIWlBVbjlGMk05?=
 =?utf-8?B?UVovV2FkU3c1RkVtY3RVSlQraUllVytlREJUUUVoOEt4c21YTUgxMWJzb0Z6?=
 =?utf-8?B?R0hjRmJLUXR2Y21rRHJPcjZKVTJ2eUlTSlRxb1V0STVRc09EMDc1N0VOQWl0?=
 =?utf-8?B?YTh2Z3lETC9rOUxjWDBQdHVnY05zYW5GTk0weG1xTkg3SmdnYlJ5QXJ3VlB5?=
 =?utf-8?B?Y0Q3U0ZObnMyTE1jeVRtTnpReTU0RS9hMzZ2Y3lRbS9qWVhYNCt3anJGb0JB?=
 =?utf-8?B?MWFra1lpS05vdVV1WkJFeGJyU0VzYTBHYXZ3ZzBRU09tYXVVcDU0RDdaYTMx?=
 =?utf-8?B?eEZUNUhYbUJ1NFFSd1ZnSWhINDV0THlpWjhjRE9PdkVWalN1S1lHKzRwZkdT?=
 =?utf-8?B?Q3ZHMkd2NElIMit6eURxYU1zRHdwQU5ZcEFBZ1pQa2RGNzVNSHRPMWlYVUtS?=
 =?utf-8?B?ZDRvQ0NpSGFhZHRWeHJoZ3FVdnVObnMrWTYxODFUREZJeDdsQkh1SnFCYjA3?=
 =?utf-8?B?QThlUngxVWRFNlJnQ0JvaE85bHJmQ3B2cThNTHZ5TnNtaUtXU00wYW1sVjc0?=
 =?utf-8?B?MzRjMlowRldZZ1dXQlRHdEhPZFVDNGdnWTRqeXUxWlBwT3NtZFZTazV0dVRZ?=
 =?utf-8?B?T0xGcXRqMkdjTkxCczFoeVNkd293dTE5WlRxd0xRQmUwTWRBWU1xMm9PMXFN?=
 =?utf-8?B?NkZYTmZqY1NaWlZ0N3ZTWTZ6dlpnQUpLeU9scFIrazJaZ2ZzZ0V2dGFvajRZ?=
 =?utf-8?B?MGdzN204eEtzZ09HTnVYYVNDdVlZOTU3TkdobDFqVUthUjRCdHM4V0JTQ2g2?=
 =?utf-8?B?eGNRRk1UWW4vbFR1dTFQOWw1WjFJM3pYT1h0eGxWakZWUVMxdUN2RzE4L1NQ?=
 =?utf-8?B?UkgwOUNudk5GQnV1RklOaHVCenpQVHJsbDJUa2pZbTlLSU55U3JhMEtnYXA0?=
 =?utf-8?B?ZEh4KzFqUm54UXJuU1ZxV3RuKzlJQjJmUTNYVkNIZWwxMFAzR012U3d1TnNO?=
 =?utf-8?B?RHF1RSs4cUZkaTZXcVdKVGdQUEY2YkpXUEpJYTU4UXJSbEY1YzVGYUVFZ0hl?=
 =?utf-8?B?NE1oMHkzZGd2R3MzaE5zSUVYeTZRbmVZUUtCUVNVV1BEUUoyOUU5YjBMb2Ev?=
 =?utf-8?B?eCtiTWgwUUlHcUpMbkRMVFhkeWozTHF1ZUxPS2V1Q2Vkd091K1dpSHNseGJI?=
 =?utf-8?B?aEdSV1RyYzJaMU1VRkFyNnJlZzNZNFhreU9WcUJ2a2lkWG04eTBWZmFyN1hS?=
 =?utf-8?B?TnlRWUdsVGhrUEsrN0ZTTDRKaHJtUTBiNFpzeTNYNk9LRy8zczNicW9pN0cy?=
 =?utf-8?B?ajlUWVpGSEVOYmhzSW9VN2N6TDNGbXRNaS9KSnNXTTZTcHc2STJicis5cjBo?=
 =?utf-8?B?U3hLWnhUNWR1L05GRldlTEh4ejRsTVlNSGtTelRjNGNUTVgxWWduR0xscFhM?=
 =?utf-8?B?SE5LYjdGRzlKcHRQQ3BUQXE4VHhZcUM0Y1JYNzFZNExsUzZiN3JwY2s0TFdl?=
 =?utf-8?B?Qzc1M1lQTkd0dHBidkJZL0t3UzVSaDlSa1g2aG94VFBxVFU0dkR4eVkyUnBo?=
 =?utf-8?B?WERXVmhTYkNjT2hUZk5xZytHNXA0MjlPSXJnNUl5bFJLbzk0OEttbWczYVlz?=
 =?utf-8?Q?bE9/bhAhTAovLMyrJEQgRdIkD1NQGCQFOlrXzqk614F1t?=
X-MS-Exchange-AntiSpam-MessageData-1: 6/ExkFXSKbACiA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d6472d-70f3-4aa3-d9d0-08da214f6164
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 15:23:24.9759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DIUPktTzjyhyPvi0nAc7KVTyhWQQkqxqUWIVcQzCnLLP9Ce/MIcXextnZqdDMKlW1whXjfHUg8TfREEscXyXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0102
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

--------------xrbxjLbD1QNXX7AXrR0UR8ux
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2022-04-18 09:22, Shuotao Xu wrote:
>
>
>> On Apr 16, 2022, at 12:43 AM, Andrey Grodzovsky 
>> <andrey.grodzovsky@amd.com> wrote:
>>
>>
>> On 2022-04-15 06:12, Shuotao Xu wrote:
>>> Hi Andrey,
>>>
>>> First I really appreciate the discussion! It helped me understand 
>>> the driver code greatly. Thank you so much:)
>>> Please see my inline comments.
>>>
>>>> On Apr 14, 2022, at 11:13 PM, Andrey Grodzovsky 
>>>> <andrey.grodzovsky@amd.com> wrote:
>>>>
>>>>
>>>> On 2022-04-14 10:00, Shuotao Xu wrote:
>>>>>
>>>>>
>>>>>> On Apr 14, 2022, at 1:31 AM, Andrey Grodzovsky 
>>>>>> <andrey.grodzovsky@amd.com> wrote:
>>>>>>
>>>>>>
>>>>>> On 2022-04-13 12:03, Shuotao Xu wrote:
>>>>>>>
>>>>>>>
>>>>>>>> On Apr 11, 2022, at 11:52 PM, Andrey Grodzovsky 
>>>>>>>> <andrey.grodzovsky@amd.com> wrote:
>>>>>>>>
>>>>>>>> [Some people who received this message don't often get email 
>>>>>>>> fromandrey.grodzovsky@amd.com. Learn why this is important 
>>>>>>>> athttp://aka.ms/LearnAboutSenderIdentification.]
>>>>>>>>
>>>>>>>> On 2022-04-08 21:28, Shuotao Xu wrote:
>>>>>>>>>
>>>>>>>>>> On Apr 8, 2022, at 11:28 PM, Andrey Grodzovsky 
>>>>>>>>>> <andrey.grodzovsky@amd.com> wrote:
>>>>>>>>>>
>>>>>>>>>> [Some people who received this message don't often get email 
>>>>>>>>>> from andrey.grodzovsky@amd.com. Learn why this is important 
>>>>>>>>>> at http://aka.ms/LearnAboutSenderIdentification.]
>>>>>>>>>>
>>>>>>>>>> On 2022-04-08 04:45, Shuotao Xu wrote:
>>>>>>>>>>> Adding PCIe Hotplug Support for AMDKFD: the support of 
>>>>>>>>>>> hot-plug of GPU
>>>>>>>>>>> devices can open doors for many advanced applications in 
>>>>>>>>>>> data center
>>>>>>>>>>> in the next few years, such as for GPU resource
>>>>>>>>>>> disaggregation. Current AMDKFD does not support hotplug out 
>>>>>>>>>>> b/o the
>>>>>>>>>>> following reasons:
>>>>>>>>>>>
>>>>>>>>>>> 1. During PCIe removal, decrement KFD lock which was 
>>>>>>>>>>> incremented at
>>>>>>>>>>> the beginning of hw fini; otherwise kfd_open later is going to
>>>>>>>>>>> fail.
>>>>>>>>>> I assumed you read my comment last time, still you do same 
>>>>>>>>>> approach.
>>>>>>>>>> More in details bellow
>>>>>>>>> Aha, I like your fix:) I was not familiar with drm APIs so 
>>>>>>>>> just only half understood your comment last time.
>>>>>>>>>
>>>>>>>>> BTW, I tried hot-plugging out a GPU when rocm application is 
>>>>>>>>> still running.
>>>>>>>>> From dmesg, application is still trying to access the removed 
>>>>>>>>> kfd device, and are met with some errors.
>>>>>>>>
>>>>>>>>
>>>>>>>> Application us supposed to keep running, it holds the drm_device
>>>>>>>> reference as long as it has an open
>>>>>>>> FD to the device and final cleanup will come only after the app 
>>>>>>>> will die
>>>>>>>> thus releasing the FD and the last
>>>>>>>> drm_device reference.
>>>>>>>>
>>>>>>>>> Application would hang and not exiting in this case.
>>>>>>>>
>>>>>>>
>>>>>>> Actually I tried kill -7 $pid, and the process exists. The dmesg 
>>>>>>> has some warning though.
>>>>>>>
>>>>>>> [  711.769977] WARNING: CPU: 23 PID: 344 at 
>>>>>>> .../amdgpu-rocm5.0.2/src/amd/amdgpu/amdgpu_object.c:1336 
>>>>>>> amdgpu_bo_release_notify+0x150/0x160 [amdgpu]
>>>>>>> [  711.770528] Modules linked in: amdgpu(OE) amdttm(OE) 
>>>>>>> amd_sched(OE) amdkcl(OE) iommu_v2 nf_conntrack_netlink nfnetlink 
>>>>>>> xfrm_user xfrm_algo xt_addrtype br_netfilter xt_CHECKSUM 
>>>>>>> iptable_mangle xt_MASQUERADE iptable_nat nf_nat xt_conntrack 
>>>>>>> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT 
>>>>>>> nf_reject_ipv4 xt_tcpudp bridge stp llc ebtable_filter ebtables 
>>>>>>> ip6table_filter ip6_tables iptable_filter overlay binfmt_misc 
>>>>>>> intel_rapl_msr i40iw intel_rapl_common skx_edac nfit 
>>>>>>> x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel rpcrdma 
>>>>>>> kvm sunrpc ipmi_ssif ib_umad ib_ipoib rdma_ucm irqbypass rapl 
>>>>>>> joydev acpi_ipmi input_leds intel_cstate ipmi_si ipmi_devintf 
>>>>>>> mei_me mei intel_pch_thermal ipmi_msghandler ioatdma mac_hid 
>>>>>>> lpc_ich dca acpi_power_meter acpi_pad sch_fq_codel ib_iser 
>>>>>>> rdma_cm iw_cm ib_cm iscsi_tcp libiscsi_tcp libiscsi 
>>>>>>> scsi_transport_iscsi pci_stub ip_tables x_tables autofs4 btrfs 
>>>>>>> blake2b_generic zstd_compress raid10 raid456 async_raid6_recov 
>>>>>>> async_memcpy async_pq async_xor async_tx xor
>>>>>>> [  711.779359]  raid6_pq libcrc32c raid1 raid0 multipath linear 
>>>>>>> mlx5_ib ib_uverbs ib_core ast drm_vram_helper i2c_algo_bit 
>>>>>>> drm_ttm_helper ttm drm_kms_helper syscopyarea crct10dif_pclmul 
>>>>>>> crc32_pclmul ghash_clmulni_intel sysfillrect uas hid_generic 
>>>>>>> sysimgblt aesni_intel mlx5_core fb_sys_fops crypto_simd usbhid 
>>>>>>> cryptd drm i40e pci_hyperv_intf usb_storage glue_helper mlxfw 
>>>>>>> hid ahci libahci wmi
>>>>>>> [  711.779752] CPU: 23 PID: 344 Comm: kworker/23:1 Tainted: G  W 
>>>>>>>  OE     5.11.0+ #1
>>>>>>> [  711.779755] Hardware name: Supermicro 
>>>>>>> SYS-4029GP-TRT2/X11DPG-OT-CPU, BIOS 2.1 08/14/2018
>>>>>>> [  711.779756] Workqueue: kfd_process_wq kfd_process_wq_release 
>>>>>>> [amdgpu]
>>>>>>> [  711.779955] RIP: 0010:amdgpu_bo_release_notify+0x150/0x160 
>>>>>>> [amdgpu]
>>>>>>> [  711.780141] Code: e8 b5 af 34 f4 e9 1f ff ff ff 48 39 c2 74 
>>>>>>> 07 0f 0b e9 69 ff ff ff 4c 89 e7 e8 3c b4 16 00 e9 5c ff ff ff 
>>>>>>> e8 a2 ce fd f3 eb cf <0f> 0b eb cb e8 d7 02 34 f4 0f 1f 80 00 00 
>>>>>>> 00 00 0f 1f 44 00 00 55
>>>>>>> [  711.780143] RSP: 0018:ffffa8100dd67c30 EFLAGS: 00010282
>>>>>>> [  711.780145] RAX: 00000000ffffffea RBX: ffff89980e792058 RCX: 
>>>>>>> 0000000000000000
>>>>>>> [  711.780147] RDX: 0000000000000000 RSI: ffff89a8f9ad8870 RDI: 
>>>>>>> ffff89a8f9ad8870
>>>>>>> [  711.780148] RBP: ffffa8100dd67c50 R08: 0000000000000000 R09: 
>>>>>>> fffffffffff99b18
>>>>>>> [  711.780149] R10: ffffa8100dd67bd0 R11: ffffa8100dd67908 R12: 
>>>>>>> ffff89980e792000
>>>>>>> [  711.780151] R13: ffff89980e792058 R14: ffff89980e7921bc R15: 
>>>>>>> dead000000000100
>>>>>>> [  711.780152] FS:  0000000000000000(0000) 
>>>>>>> GS:ffff89a8f9ac0000(0000) knlGS:0000000000000000
>>>>>>> [  711.780154] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>>> [  711.780156] CR2: 00007ffddac6f71f CR3: 00000030bb80a003 CR4: 
>>>>>>> 00000000007706e0
>>>>>>> [  711.780157] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
>>>>>>> 0000000000000000
>>>>>>> [  711.780159] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
>>>>>>> 0000000000000400
>>>>>>> [  711.780160] PKRU: 55555554
>>>>>>> [  711.780161] Call Trace:
>>>>>>> [  711.780163]  ttm_bo_release+0x2ae/0x320 [amdttm]
>>>>>>> [  711.780169]  amdttm_bo_put+0x30/0x40 [amdttm]
>>>>>>> [  711.780357]  amdgpu_bo_unref+0x1e/0x30 [amdgpu]
>>>>>>> [  711.780543]  amdgpu_gem_object_free+0x8b/0x160 [amdgpu]
>>>>>>> [  711.781119]  drm_gem_object_free+0x1d/0x30 [drm]
>>>>>>> [  711.781489] 
>>>>>>>  amdgpu_amdkfd_gpuvm_free_memory_of_gpu+0x34a/0x380 [amdgpu]
>>>>>>> [  711.782044]  kfd_process_device_free_bos+0xe0/0x130 [amdgpu]
>>>>>>> [  711.782611]  kfd_process_wq_release+0x286/0x380 [amdgpu]
>>>>>>> [  711.783172]  process_one_work+0x236/0x420
>>>>>>> [  711.783543]  worker_thread+0x34/0x400
>>>>>>> [  711.783911]  ? process_one_work+0x420/0x420
>>>>>>> [  711.784279]  kthread+0x126/0x140
>>>>>>> [  711.784653]  ? kthread_park+0x90/0x90
>>>>>>> [  711.785018]  ret_from_fork+0x22/0x30
>>>>>>> [  711.785387] ---[ end trace d8f50f6594817c84 ]---
>>>>>>> [  711.798716] [drm] amdgpu: ttm finalized
>>>>>>
>>>>>>
>>>>>> So it means the process was stuck in some wait_event_killable 
>>>>>> (maybe here drm_sched_entity_flush) - you can try 
>>>>>> 'cat/proc/$process_pid/stack' maybe before
>>>>>> you kill it to see where it was stuck so we can go from there.
>>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> For graphic apps what i usually see is a crash because of 
>>>>>>>> sigsev when
>>>>>>>> the app tries to access
>>>>>>>> an unmapped MMIO region on the device. I haven't tested for compute
>>>>>>>> stack and so there might
>>>>>>>> be something I haven't covered. Hang could mean for example 
>>>>>>>> waiting on a
>>>>>>>> fence which is not being
>>>>>>>> signaled - please provide full dmesg from this case.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Do you have any good suggestions on how to fix it down the 
>>>>>>>>> line? (HIP runtime/libhsakmt or driver)
>>>>>>>>>
>>>>>>>>> [64036.631333] amdgpu: amdgpu_vm_bo_update failed
>>>>>>>>> [64036.631702] amdgpu: validate_invalid_user_pages: update PTE 
>>>>>>>>> failed
>>>>>>>>> [64036.640754] amdgpu: amdgpu_vm_bo_update failed
>>>>>>>>> [64036.641120] amdgpu: validate_invalid_user_pages: update PTE 
>>>>>>>>> failed
>>>>>>>>> [64036.650394] amdgpu: amdgpu_vm_bo_update failed
>>>>>>>>> [64036.650765] amdgpu: validate_invalid_user_pages: update PTE 
>>>>>>>>> failed
>>>>>>>>
>>>>>>>
>>>>>>> The full dmesg will just the repetition of those two messages,
>>>>>>> [186885.764079] amdgpu 0000:43:00.0: amdgpu: amdgpu: finishing 
>>>>>>> device.
>>>>>>> [186885.766916] [drm] free PSP TMR buffer
>>>>>>> [186893.868173] amdgpu: amdgpu_vm_bo_update failed
>>>>>>> [186893.868235] amdgpu: validate_invalid_user_pages: update PTE 
>>>>>>> failed
>>>>>>> [186893.876154] amdgpu: amdgpu_vm_bo_update failed
>>>>>>> [186893.876190] amdgpu: validate_invalid_user_pages: update PTE 
>>>>>>> failed
>>>>>>> [186893.884150] amdgpu: amdgpu_vm_bo_update failed
>>>>>>> [186893.884185] amdgpu: validate_invalid_user_pages: update PTE 
>>>>>>> failed
>>>>>>>
>>>>>>>>
>>>>>>>> This just probably means trying to update PTEs after the 
>>>>>>>> physical device
>>>>>>>> is gone - we usually avoid this by
>>>>>>>> first trying to do all HW shutdowns early before PCI remove 
>>>>>>>> completion
>>>>>>>> but when it's really tricky by
>>>>>>>> protecting HW access sections with drm_dev_enter/exit scope.
>>>>>>>>
>>>>>>>> For this particular error it would be the best to flush
>>>>>>>> info->restore_userptr_work before the end of
>>>>>>>> amdgpu_pci_remove (rejecting new process creation and calling
>>>>>>>> cancel_delayed_work_sync(&process_info->restore_userptr_work) 
>>>>>>>> for all
>>>>>>>> running processes)
>>>>>>>> somewhere in amdgpu_pci_remove.
>>>>>>>>
>>>>>>> I tried something like *kfd_process_ref_release* which I think 
>>>>>>> did what you described, but it did not work.
>>>>>>
>>>>>>
>>>>>> I don't see how kfd_process_ref_release is the same as I 
>>>>>> mentioned above, what i meant is calling the code above within 
>>>>>> kgd2kfd_suspend (where you tried to call 
>>>>>> kfd_kill_all_user_processes bellow)
>>>>>>
>>>>> Yes, you are right. It was not called by it.
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> Instead I tried to kill the process from the kernel, but the 
>>>>>>> amdgpu could **only** be hot-plugged in back successfully only 
>>>>>>> if there was no rocm kernel running when it was plugged out. If 
>>>>>>> not, amdgpu_probe will just hang later. (Maybe because amdgpu 
>>>>>>> was plugged out while running state, it leaves a bad HW state 
>>>>>>> which causes probe to hang).
>>>>>>
>>>>>>
>>>>>> We usually do asic_reset during probe to reset all HW state 
>>>>>> (checlk if amdgpu_device_init->amdgpu_asic_reset is running when 
>>>>>> you  plug back).
>>>>>>
>>>>> OK
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> I don’t know if this is a viable solution worth pursuing, but I 
>>>>>>> attached the diff anyway.
>>>>>>>
>>>>>>> Another solution could be let compute stack user mode detect a 
>>>>>>> topology change via generation_count change, and abort 
>>>>>>> gracefully there.
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>> index 4e7d9cb09a69..79b4c9b84cd0 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>> @@ -697,12 +697,15 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, 
>>>>>>> bool run_pm, bool force)
>>>>>>> return;
>>>>>>>
>>>>>>>         /* for runtime suspend, skip locking kfd */
>>>>>>> -       if (!run_pm) {
>>>>>>> +       if (!run_pm && !drm_dev_is_unplugged(kfd->ddev)) {
>>>>>>>                 /* For first KFD device suspend all the KFD 
>>>>>>> processes */
>>>>>>>                 if (atomic_inc_return(&kfd_locked) == 1)
>>>>>>> kfd_suspend_all_processes(force);
>>>>>>>         }
>>>>>>>
>>>>>>> +       if (drm_dev_is_unplugged(kfd->ddev))
>>>>>>> + kfd_kill_all_user_processes();
>>>>>>> +
>>>>>>> kfd->dqm->ops.stop(kfd->dqm);
>>>>>>> kfd_iommu_suspend(kfd);
>>>>>>>  }
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>>>> index 55c9e1922714..84cbcd857856 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>>>> @@ -1065,6 +1065,7 @@ void kfd_unref_process(struct kfd_process *p);
>>>>>>>  int kfd_process_evict_queues(struct kfd_process *p, bool force);
>>>>>>>  int kfd_process_restore_queues(struct kfd_process *p);
>>>>>>>  void kfd_suspend_all_processes(bool force);
>>>>>>> +void kfd_kill_all_user_processes(void);
>>>>>>>  /*
>>>>>>>   * kfd_resume_all_processes:
>>>>>>>   *     bool sync: If kfd_resume_all_processes() should wait for the
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>>> index 6cdc855abb6d..fb0c753b682c 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>>> @@ -2206,6 +2206,24 @@ void kfd_suspend_all_processes(bool force)
>>>>>>> srcu_read_unlock(&kfd_processes_srcu, idx);
>>>>>>>  }
>>>>>>>
>>>>>>> +
>>>>>>> +void kfd_kill_all_user_processes(void)
>>>>>>> +{
>>>>>>> +       struct kfd_process *p;
>>>>>>> +       struct amdkfd_process_info *p_info;
>>>>>>> +       unsigned int temp;
>>>>>>> +       int idx = srcu_read_lock(&kfd_processes_srcu);
>>>>>>> +
>>>>>>> + pr_info("Killing all processes\n");
>>>>>>> + hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>>>>>>> + p_info = p->kgd_process_info;
>>>>>>> + pr_info("Killing  processes, pid = %d", pid_nr(p_info->pid));
>>>>>>> + kill_pid(p_info->pid, SIGBUS, 1);
>>>>>>
>>>>>>
>>>>>> From looking into kill_pid I see it only sends a signal but 
>>>>>> doesn't wait for completion, it would make sense to wait for 
>>>>>> completion here. In any case I would actually try to put here
>>>>>>
>>>>> I have made a version which does that with some atomic counters. 
>>>>> Please read later in the diff.
>>>>>>
>>>>>>
>>>>>> hash_for_each_rcu(p_info)
>>>>>> cancel_delayed_work_sync(&p_info->restore_userptr_work)
>>>>>>
>>>>>> instead  at least that what i meant in the previous mail.
>>>>>>
>>>>> I actually tried that earlier, and it did not work. Application 
>>>>> still keeps running, and you have to send a kill to the user process.
>>>>>
>>>>> I have made the following version. It waits for processes to 
>>>>> terminate synchronously after sending SIGBUS. After that it does 
>>>>> the real work of amdgpu_pci_remove.
>>>>> However, it hangs at amdgpu_device_ip_fini_early when it is trying 
>>>>> to deinit ip_block 6 <sdma_v4_0> 
>>>>> (https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L2818 
>>>>> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux%2F-%2Fblob%2Famd-staging-drm-next%2Fdrivers%2Fgpu%2Fdrm%2Famd%2Famdgpu%2Famdgpu_device.c%23L2818&data=04%7C01%7Candrey.grodzovsky%40amd.com%7Cbfb611b3f5984b73ad3708da213e781e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637858849473779872%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=Tn6rrnnrg%2BzkoLQUeN3WOjqDbgKD5Rotccd6AZs%2BQmI%3D&reserved=0>). 
>>>>> I assume that there are still some inflight dma, therefore fini of 
>>>>> this ip block thus hangs?
>>>>>
>>>>> The following is an excerpt of the dmesg: please excuse for 
>>>>> putting my own pr_info, but I hope you get my point of where it hangs.
>>>>>
>>>>> [  392.344735] amdgpu: all processes has been fully released
>>>>> [  392.346557] amdgpu: amdgpu_acpi_fini done
>>>>> [  392.346568] amdgpu 0000:b3:00.0: amdgpu: amdgpu: finishing device.
>>>>> [  392.349238] amdgpu: amdgpu_device_ip_fini_early enter ip_blocks = 9
>>>>> [  392.349248] amdgpu: Free mem_obj = 000000007bf54275, 
>>>>> range_start = 14, range_end = 14
>>>>> [  392.350299] amdgpu: Free mem_obj = 00000000a85bc878, 
>>>>> range_start = 12, range_end = 12
>>>>> [  392.350304] amdgpu: Free mem_obj = 00000000b8019e32, 
>>>>> range_start = 13, range_end = 13
>>>>> [  392.350308] amdgpu: Free mem_obj = 000000002d296168, 
>>>>> range_start = 4, range_end = 11
>>>>> [  392.350313] amdgpu: Free mem_obj = 000000001fc4f934, 
>>>>> range_start = 0, range_end = 3
>>>>> [  392.350322] amdgpu: amdgpu_amdkfd_suspend(adev, false) done
>>>>> [  392.350672] amdgpu: hw_fini of IP block[8] <jpeg_v2_5> done 0
>>>>> [  392.350679] amdgpu: hw_fini of IP block[7] <vcn_v2_5> done 0
>>>>
>>>>
>>>> I just remembered that the idea to actively kill and wait for 
>>>> running user processes during unplug was rejected
>>>> as a bad idea in the first iteration of unplug work I did (don't 
>>>> remember why now, need to look) so this is a no go.
>>>>
>>> Maybe an application has kfd open, but was not accessing the dev. So 
>>> kill it at unplug could kill the process unnecessarily.
>>> However, the latest version I had with the sleep function got rid of 
>>> the IP block fini hang.
>>>>
>>>> Our policy is to let zombie processes (zombie in a sense that the 
>>>> underlying device is gone) live as long as they want
>>>> (as long as you able to terminate them - which you do, so that ok)
>>>> and the system should finish PCI remove gracefully and be able to 
>>>> hot plug back the device.  Hence, i suggest dropping
>>>> this direction of forcing all user processes to be killed, confirm 
>>>> you have graceful shutdown and remove of device
>>>> from PCI topology and then concentrate on why when you plug back it 
>>>> hangs.
>>>>
>>> So I basically revert back to the original solution which you suggested.
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> index 4e7d9cb09a69..5504a18b5a45 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> @@ -697,7 +697,7 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool 
>>> run_pm, bool force)
>>>                 return;
>>>
>>>         /* for runtime suspend, skip locking kfd */
>>> -       if (!run_pm) {
>>> +       if (!run_pm && !drm_dev_is_unplugged(kfd->ddev)) {
>>>                 /* For first KFD device suspend all the KFD processes */
>>>                 if (atomic_inc_return(&kfd_locked) == 1)
>>> kfd_suspend_all_processes(force);
>>>
>>>> First confirm if ASIC reset happens on
>>>> next init.
>>>>
>>> This patch works great at *planned* plugout, where all the rocm 
>>> processes are killed before plugout. And device can be added back 
>>> without a problem.
>>> However *unplanned* plugout when there is rocm processes are running 
>>> just don’t work.
>>
>>
>> Still I am not clear if ASIC reset happens on plug back or no, can 
>> you trace this please ?
>>
>>
>
> I tried add pr_info into asic_reset functions, but cannot trace any 
> upon plug-back.


This could possibly explain the hang on plug back. Can you see why we 
don't get there ?


>>
>>>> Second please confirm if the timing you kill manually the user 
>>>> process has impact on whether you have a hang
>>>> on next plug back (if you kill before
>>>>
>>> *Scenario 0: Kill before plug back*
>>>
>>> 1. echo 1 > /sys/bus/pci/…/remove, would finish.
>>> But the application won’t exit until there is a kill signal.
>>
>>
>> Why you think it must exit ?
>>
> Because rocm will need to release the drm descriptor to 
> get amdgpu_amdkfd_device_fini_sw called, which would eventually call 
> kgd2kfd_device_exit called. This would clean up kfd_topology at least. 
> Otherwise I don’t see how it would be added back without messing up 
> kfd topology to say the least.
>
> However, those are all based my own observations. Please explain why 
> it does not need exit if you believe so?


Note that when you add back a new device, pci device and drm device are 
created, I am not an expert on KFD code but i believe also a new KFD 
device is created independent of the old one and so the topology should 
see just 2 device instances (one old zombie and one real new).  I know 
at least this wasn't an issue for the graphic stack in exact same 
scenario and the libdrm tests i pointed to test exact this scenario. 
Also note that even with running grpahic stack there is always a KFD 
device and KFD topology present but of course probably not the same as 
when u run a KFD facing process so there could be some issues there.

Also note that because of this patch 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=267d51d77fdae8708b94e1a24b8e5d961297edb7 
all MMIO accesses from such zombie/orphan user processes will be 
remapped to zero page and so will not necessarily experience a segfault 
when device removal happnes but rather maybe some crash due to NULL data 
read from MMIO by the process and used in some manner.


>>>
>>> 2. kill the the process. The application does several things and 
>>> seems trigger drm_release in the kernel, which are met with kernel 
>>> NULL pointer deference related to sysfs_remove. Then the whole fs 
>>> just freeze.
>>>
>>> [  +0.002498] BUG: kernel NULL pointer dereference, address: 
>>> 0000000000000098
>>> [  +0.000486] #PF: supervisor read access in kernel mode
>>> [  +0.000545] #PF: error_code(0x0000) - not-present page
>>> [  +0.000551] PGD 0 P4D 0
>>> [  +0.000553] Oops: 0000 [#1] SMP NOPTI
>>> [  +0.000540] CPU: 75 PID: 4911 Comm: kworker/75:2 Tainted: G       
>>>  W   E 5.13.0-kfd #1
>>> [  +0.000559] Hardware name: INGRASYS         TURING  /MB      , 
>>> BIOS K71FQ28A 10/05/2021
>>> [  +0.000567] Workqueue: events delayed_fput
>>> [  +0.000563] RIP: 0010:kernfs_find_ns+0x1b/0x100
>>> [  +0.000569] Code: ff ff e8 88 59 9f 00 0f 1f 84 00 00 00 00 00 0f 
>>> 1f 44 00 00 41 57 8b 05 df f0 7b 01 41 56 41 55 49 89 f5 41 54 55 48 
>>> 89 fd 53 <44> 0f b7 b7 98 00 00 00 48 89 d3 4c 8b 67 70 66 41 83 e6 
>>> 20 41 0f
>>> [  +0.001193] RSP: 0018:ffffb9875db5fc98 EFLAGS: 00010246
>>> [  +0.000602] RAX: 0000000000000000 RBX: ffffa101f79507d8 RCX: 
>>> 0000000000000000
>>> [  +0.000612] RDX: 0000000000000000 RSI: ffffffffc09a9417 RDI: 
>>> 0000000000000000
>>> [  +0.000604] RBP: 0000000000000000 R08: 0000000000000001 R09: 
>>> 0000000000000000
>>> [  +0.000760] R10: ffffb9875db5fcd0 R11: 0000000000000000 R12: 
>>> 0000000000000000
>>> [  +0.000597] R13: ffffffffc09a9417 R14: ffffa08363fb2d18 R15: 
>>> 0000000000000000
>>> [  +0.000702] FS:  0000000000000000(0000) GS:ffffa0ffbfcc0000(0000) 
>>> knlGS:0000000000000000
>>> [  +0.000666] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  +0.000658] CR2: 0000000000000098 CR3: 0000005747812005 CR4: 
>>> 0000000000770ee0
>>> [  +0.000715] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
>>> 0000000000000000
>>> [  +0.000655] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
>>> 0000000000000400
>>> [  +0.000592] PKRU: 55555554
>>> [  +0.000580] Call Trace:
>>> [  +0.000591]  kernfs_find_and_get_ns+0x2f/0x50
>>> [  +0.000584]  sysfs_remove_file_from_group+0x20/0x50
>>> [  +0.000580]  amdgpu_ras_sysfs_remove+0x3d/0xd0 [amdgpu]
>>> [  +0.000737]  amdgpu_ras_late_fini+0x1d/0x40 [amdgpu]
>>> [  +0.000750]  amdgpu_sdma_ras_fini+0x96/0xb0 [amdgpu]
>>> [  +0.000742]  ? gfx_v10_0_resume+0x10/0x10 [amdgpu]
>>> [  +0.000738]  sdma_v4_0_sw_fini+0x23/0x90 [amdgpu]
>>> [  +0.000717]  amdgpu_device_fini_sw+0xae/0x260 [amdgpu]
>>> [  +0.000704]  amdgpu_driver_release_kms+0x12/0x30 [amdgpu]
>>> [  +0.000687]  drm_dev_release+0x20/0x40 [drm]
>>> [  +0.000583]  drm_release+0xa8/0xf0 [drm]
>>> [  +0.000584]  __fput+0xa5/0x250
>>> [  +0.000621]  delayed_fput+0x1f/0x30
>>> [  +0.000726]  process_one_work+0x26e/0x580
>>> [  +0.000581]  ? process_one_work+0x580/0x580
>>> [  +0.000611]  worker_thread+0x4d/0x3d0
>>> [  +0.000611]  ? process_one_work+0x580/0x580
>>> [  +0.000605]  kthread+0x117/0x150
>>> [  +0.000611]  ? kthread_park+0x90/0x90
>>> [  +0.000619]  ret_from_fork+0x1f/0x30
>>> [  +0.000625] Modules linked in: amdgpu(E) xt_conntrack 
>>> xt_MASQUERADE nfnetlink xt_addrtype iptable_filter iptable_nat 
>>> nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter 
>>> x86_pkg_temp_thermal cdc_ether usbnet acpi_pad msr ip_tables 
>>> x_tables ast drm_vram_helper iommu_v2 drm_ttm_helper gpu_sched ttm 
>>> drm_kms_helper cfbfillrect syscopyarea cfbimgblt sysfillrect 
>>> sysimgblt fb_sys_fops cfbcopyarea drm drm_panel_orientati
>>> on_quirks [last unloaded: amdgpu]
>>
>>
>> This is a known regression, all SYSFS components must be removed 
>> before pci_remove code runs otherwise you get either warnings for 
>> single file removals or
>> OOPSEs for sysfs gorup removals like here. Please try to move 
>> amdgpu_ras_sysfs_remove from amdgpu_ras_late_fini to the end of 
>> amdgpu_ras_pre_fini (which happens before pci remove)
>>
>>
>
> I fixed it in the newer patch, please see it below.



> I first plugout the device, then kill the rocm user process. Then it 
> has other OOPSES related to ttm_bo_cleanup_refs.
>
> [  +0.000006] BUG: kernel NULL pointer dereference, address: 
> 0000000000000010
> [  +0.000349] #PF: supervisor read access in kernel mode
> [  +0.000340] #PF: error_code(0x0000) - not-present page
> [  +0.000341] PGD 0 P4D 0
> [  +0.000336] Oops: 0000 [#1] SMP NOPTI
> [  +0.000345] CPU: 9 PID: 95 Comm: kworker/9:1 Tainted: G  W   E     
> 5.13.0-kfd #1
> [  +0.000367] Hardware name: INGRASYS         TURING  /MB      , BIOS 
> K71FQ28A 10/05/2021
> [  +0.000376] Workqueue: events delayed_fput
> [  +0.000422] RIP: 0010:ttm_resource_free+0x24/0x40 [ttm]
> [  +0.000464] Code: 00 00 0f 1f 40 00 0f 1f 44 00 00 53 48 89 f3 48 8b 
> 36 48 85 f6 74 21 48 8b 87 28 02 00 00 48 63 56 10 48 8b bc d0 b8 00 
> 00 00 <48> 8b 47 10 ff 50 08 48 c7 03 00 00 00 00 5b c3 66 66 2e 0f 1f 84
> [  +0.001009] RSP: 0018:ffffb21c59413c98 EFLAGS: 00010282
> [  +0.000515] RAX: ffff8b1aa4285f68 RBX: ffff8b1a823b5ea0 RCX: 
> 00000000002a000c
> [  +0.000536] RDX: 0000000000000000 RSI: ffff8b1acb84db80 RDI: 
> 0000000000000000
> [  +0.000539] RBP: 0000000000000001 R08: 0000000000000000 R09: 
> ffffffffc03c3e00
> [  +0.000543] R10: 0000000000000000 R11: 0000000000000000 R12: 
> ffff8b1a823b5ec8
> [  +0.000542] R13: 0000000000000000 R14: ffff8b1a823b5d90 R15: 
> ffff8b1a823b5ec8
> [  +0.000544] FS:  0000000000000000(0000) GS:ffff8b187f440000(0000) 
> knlGS:0000000000000000
> [  +0.000559] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.000575] CR2: 0000000000000010 CR3: 00000076e6812004 CR4: 
> 0000000000770ee0
> [  +0.000575] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
> 0000000000000000
> [  +0.000579] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
> 0000000000000400
> [  +0.000575] PKRU: 55555554
> [  +0.000568] Call Trace:
> [  +0.000567]  ttm_bo_cleanup_refs+0xe4/0x290 [ttm]
> [  +0.000588]  ttm_bo_delayed_delete+0x147/0x250 [ttm]
> [  +0.000589]  ttm_device_fini+0xad/0x1b0 [ttm]
> [  +0.000590]  amdgpu_ttm_fini+0x2a7/0x310 [amdgpu]
> [  +0.000730]  gmc_v9_0_sw_fini+0x3a/0x40 [amdgpu]
> [  +0.000753]  amdgpu_device_fini_sw+0xae/0x260 [amdgpu]
> [  +0.000734]  amdgpu_driver_release_kms+0x12/0x30 [amdgpu]
> [  +0.000737]  drm_dev_release+0x20/0x40 [drm]
> [  +0.000626]  drm_release+0xa8/0xf0 [drm]
> [  +0.000625]  __fput+0xa5/0x250
> [  +0.000606]  delayed_fput+0x1f/0x30
> [  +0.000607]  process_one_work+0x26e/0x580
> [  +0.000608]  ? process_one_work+0x580/0x580
> [  +0.000616]  worker_thread+0x4d/0x3d0
> [  +0.000614]  ? process_one_work+0x580/0x580
> [  +0.000617]  kthread+0x117/0x150
> [  +0.000615]  ? kthread_park+0x90/0x90
> [  +0.000621]  ret_from_fork+0x1f/0x30
> [  +0.000603] Modules linked in: amdgpu(E) xt_conntrack xt_MASQUERADE 
> nfnetlink xt_addrtype iptable_filter iptable_nat nf_nat nf_conntrack 
> nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter x86_pkg_temp_thermal 
> cdc_ether usbnet acpi_pad msr ip_tables x_tables ast drm_vram_helper 
> drm_ttm_helper iommu_v2 ttm gpu_sched drm_kms_helper cfbfillrect 
> syscopyarea cfbimgblt sysfillrect sysimgblt fb_sys_fops cfbcopyarea 
> drm drm_panel_orientation_quirks [last unloaded: amdgpu]
> [  +0.002840] CR2: 0000000000000010
> [  +0.000755] ---[ end trace 9737737402551e39 ]--


This looks like another regression - try seeing where is the NULL 
reference and then we can see how to avoid this.


>
>>>
>>> 3.  echo 1 > /sys/bus/pci/rescan. This would just hang. I assume the 
>>> sysfs is broken.
>>>
>>> Based on 1 & 2, it seems that 1 won’t let the amdgpu exit 
>>> gracefully, because 2 will do some cleanup maybe should have 
>>> happened before 1.
>>>>
>>>> or you kill after plug back does it makes a difference).
>>>>
>>> *Scenario 2: Kill after plug back*
>>>
>>> If I perform rescan before kill, then the driver seemed probed fine. 
>>> But kill will have the same issue which messed up the sysfs the same 
>>> way as in Scenario 2.
>>>
>>>
>>> *Final Comments:*
>>>
>>> 0. cancel_delayed_work_sync(&p_info->restore_userptr_work) 
>>> would make the repletion of amdgpu_vm_bo_update failure go away, but 
>>> it does not solve the issues in those scenarios.
>>
>>
>> Still - it's better to do it this way even for those failures to go awaya
>>
>>
> Cancel_delayed_work is insufficient, you will need to make sure the 
> work won’t be processed after plugout. Please see my patch


Saw, see my comment.


>>
>>>
>>> 1. For planned hotplug, this patch should work as long as you follow 
>>> some protocol, i.e. kill before plugout. Is this patch an acceptable 
>>> one since it provides some added feature than before?
>>
>>
>> Let's try to fix more as I advised above.
>>
>>
>>>
>>> 2. For unplanned hotplug when there is rocm app running, the patch 
>>> that kill all processes and wait for 5 sec would work consistently. 
>>> But it seems that it is an unacceptable solution for official 
>>> release. I can hold it for our own internal usage.  It seems that 
>>> kill after removal would cause problems, and I don’t know if there 
>>> is a quick fix by me because of my limited understanding of the 
>>> amdgpu driver. Maybe AMD could have a quick fix; Or it is really a 
>>> difficult one. This feature may or may not be a blocking issue in 
>>> our GPU disaggregation research down the way. Please let us know for 
>>> either cases, and we would like to learn and help as much as we could!
>>
>>
>> I am currently not sure why it helps. I will need to setup my own 
>> ROCm setup and retest hot plug to check this in more depth but 
>> currently i have higher priorities. Please try to confirm ASIC reset 
>> always takes place on plug back
>> and fix the sysfs OOPs as I advised above to clear up at least some 
>> of the issues. Also please describe to me exactly what you steps to 
>> reproduce this scenario so later I might be able to do it myself.
>>
>>
> I can still try to help to fix the bug in my spare time. My setup is 
> as follows
>
>  1. I have a server with 4 AMD MI100 GPUs. I think 1 GPU would also work.
>  2. I used the
>     https://github.com/RadeonOpenCompute/ROCK-Kernel-Driver/tree/roc-5.0.x
>     <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Ftree%2Froc-5.0.x&data=04%7C01%7Candrey.grodzovsky%40amd.com%7Cbfb611b3f5984b73ad3708da213e781e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637858849473779872%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=fJZBoJHu%2FwD8Ge1whM1VUERBNlCAyrnUGU78RLDp5yg%3D&reserved=0> as
>     the starting point, and apply Mukul’s patch and my patch.
>  3. Then I run a tensorflow benchmark from a docker.
>       * docker run -it --device=/dev/kfd --device=/dev/dri --group-add
>         video rocm/tensorflow:rocm4.5.2-tf1.15-dev
>       * And run the following benchmark in the docker:  python
>         benchmarks/scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py
>         --num_gpus=4 --batch_size=32 --model=resnet50
>         --variable_update=parameter_server
>           o Might to need to adjust num_gpus parameter based on your setup
>  4. Remove a GPU at random time.
>  5. Do whatever is needed to before plugback and reverify the
>     benchmark can still run.
>
>> Also, we have hotplug test suite in libdrm (graphic stack), so maybe 
>> u can install libdrm and run that test suite to see if it exposes 
>> more issues.
>>
> OK I could try it some time.
>
> The following is the new diff.
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 182b7eae598a..48c3cd4054de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1327,7 +1327,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>   * ASICs macro.
>   */
>  #define amdgpu_asic_set_vga_state(adev, state) 
> (adev)->asic_funcs->set_vga_state((adev), (state))
> -#define amdgpu_asic_reset(adev) (adev)->asic_funcs->reset((adev))
> +#define amdgpu_asic_reset(adev) ({int r; pr_info("performing 
> amdgpu_asic_reset\n"); r = (adev)->asic_funcs->reset((adev));r;})
>  #define amdgpu_asic_reset_method(adev) 
> (adev)->asic_funcs->reset_method((adev))
>  #define amdgpu_asic_get_xclk(adev) (adev)->asic_funcs->get_xclk((adev))
>  #define amdgpu_asic_set_uvd_clocks(adev, v, d) 
> (adev)->asic_funcs->set_uvd_clocks((adev), (v), (d))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 27c74fcec455..842abd7150a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -134,6 +134,7 @@ struct amdkfd_process_info {
> /* MMU-notifier related fields */
> atomic_t evicted_bos;
> +atomic_t invalid;
> struct delayed_work restore_userptr_work;
> struct pid *pid;
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 99d2b15bcbf3..2a588eb9f456 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1325,6 +1325,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, 
> void **process_info,
> info->pid = get_task_pid(current->group_leader, PIDTYPE_PID);
> atomic_set(&info->evicted_bos, 0);
> +atomic_set(&info->invalid, 0);
> INIT_DELAYED_WORK(&info->restore_userptr_work,
>  amdgpu_amdkfd_restore_userptr_worker);
> @@ -2693,6 +2694,9 @@ static void 
> amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
> struct mm_struct *mm;
> int evicted_bos;
> +if (atomic_read(&process_info->invalid))
> +return;
> +


Probably better  to again use drm_dev_enter/exit guard pair instead of 
this flag.


> evicted_bos = atomic_read(&process_info->evicted_bos);
> if (!evicted_bos)
> return;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ec38517ab33f..e7d85d8d282d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1054,6 +1054,7 @@ void 
> amdgpu_device_program_register_sequence(struct amdgpu_device *adev,
>   */
>  void amdgpu_device_pci_config_reset(struct amdgpu_device *adev)
>  {
> +pr_debug("%s called\n",__func__);
> pci_write_config_dword(adev->pdev, 0x7c, AMDGPU_ASIC_RESET_DATA);
>  }
> @@ -1066,6 +1067,7 @@ void amdgpu_device_pci_config_reset(struct 
> amdgpu_device *adev)
>   */
>  int amdgpu_device_pci_reset(struct amdgpu_device *adev)
>  {
> +pr_debug("%s called\n",__func__);
> return pci_reset_function(adev->pdev);
>  }
> @@ -4702,6 +4704,8 @@ int amdgpu_do_asic_reset(struct list_head 
> *device_list_handle,
> bool need_full_reset, skip_hw_reset, vram_lost = false;
> int r = 0;
> +pr_debug("%s called\n",__func__);
> +
> /* Try reset handler method first */
> tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
>  reset_list);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 49bdf9ff7350..b469acb65c1e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2518,7 +2518,6 @@ void amdgpu_ras_late_fini(struct amdgpu_device 
> *adev,
> if (!ras_block || !ih_info)
> return;
> -amdgpu_ras_sysfs_remove(adev, ras_block);
> if (ih_info->cb)
> amdgpu_ras_interrupt_remove_handler(adev, ih_info);
>  }
> @@ -2577,6 +2576,7 @@ void amdgpu_ras_suspend(struct amdgpu_device *adev)
>  int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
>  {
> struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> +struct ras_manager *obj, *tmp;
> if (!adev->ras_enabled || !con)
> return 0;
> @@ -2585,6 +2585,13 @@ int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
> /* Need disable ras on all IPs here before ip [hw/sw]fini */
> amdgpu_ras_disable_all_features(adev, 0);
> amdgpu_ras_recovery_fini(adev);
> +
> +/* remove sysfs before pci_remove to avoid OOPSES from 
> sysfs_remove_groups */
> +list_for_each_entry_safe(obj, tmp, &con->head, node) {
> +amdgpu_ras_sysfs_remove(adev, &obj->head);
> +put_obj(obj);
> +}
> +
> return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 4e7d9cb09a69..0fa806a78e39 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -693,16 +693,35 @@ bool kfd_is_locked(void)
>  void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm, bool force)
>  {
> +struct kfd_process *p;
> +struct amdkfd_process_info *p_info;
> +unsigned int temp;
> +
> if (!kfd->init_complete)
> return;
> /* for runtime suspend, skip locking kfd */
> -if (!run_pm) {
> +if (!run_pm && !drm_dev_is_unplugged(kfd->ddev)) {
> /* For first KFD device suspend all the KFD processes */
> if (atomic_inc_return(&kfd_locked) == 1)
> kfd_suspend_all_processes(force);
> }
> +if (drm_dev_is_unplugged(kfd->ddev)){
> +int idx = srcu_read_lock(&kfd_processes_srcu);
> +pr_debug("cancel restore_userptr_wor\n");
> +hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
> +if ( kfd_process_gpuidx_from_gpuid(p, kfd->id) >= 0 ) {
> +p_info = p->kgd_process_info;
> +pr_debug("cancel processes, pid = %d for gpu_id = %d", 
> pid_nr(p_info->pid), kfd->id);
> +cancel_delayed_work_sync(&p_info->restore_userptr_work);
> +/* block all future restore_userptr_work */
> +atomic_inc(&p_info->invalid);


Same as i mentioned above with drm.dev_eneter/exit

Andrey


> +}
> +}
> +srcu_read_unlock(&kfd_processes_srcu, idx);
> +}
> +
> kfd->dqm->ops.stop(kfd->dqm);
> kfd_iommu_suspend(kfd);
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c 
> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 600ba2a728ea..7e3d1848eccc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -669,11 +669,12 @@ static void kfd_remove_sysfs_node_entry(struct 
> kfd_topology_device *dev)
>  #ifdef HAVE_AMD_IOMMU_PC_SUPPORTED
> if (dev->kobj_perf) {
> list_for_each_entry(perf, &dev->perf_props, list) {
> +sysfs_remove_group(dev->kobj_perf, perf->attr_group);
> kfree(perf->attr_group);
> perf->attr_group = NULL;
> }
> kobject_del(dev->kobj_perf);
> -kobject_put(dev->kobj_perf);
> +/* kobject_put(dev->kobj_perf); */
> dev->kobj_perf = NULL;
> }
>  #endif
>
> Thank you so much! Looking forward to your comments!
>
> Regards,
> Shuotao
>>
>> Andrey
>>
>>
>>>
>>> Thank you so much!
>>>
>>> Best regards,
>>> Shuotao
>>>>
>>>> Andrey
>>>>
>>>>
>>>>>
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>> index 8fa9b86ac9d2..c0b27f722281 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>> @@ -188,6 +188,12 @@ void amdgpu_amdkfd_interrupt(struct 
>>>>> amdgpu_device *adev,
>>>>> kgd2kfd_interrupt(adev->kfd.dev, ih_ring_entry);
>>>>>  }
>>>>> +void amdgpu_amdkfd_kill_all_processes(struct amdgpu_device *adev)
>>>>> +{
>>>>> +if (adev->kfd.dev)
>>>>> +kgd2kfd_kill_all_user_processes(adev->kfd.dev);
>>>>> +}
>>>>> +
>>>>>  void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm)
>>>>>  {
>>>>> if (adev->kfd.dev)
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>> index 27c74fcec455..f4e485d60442 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>> @@ -141,6 +141,7 @@ struct amdkfd_process_info {
>>>>>  int amdgpu_amdkfd_init(void);
>>>>>  void amdgpu_amdkfd_fini(void);
>>>>> +void amdgpu_amdkfd_kill_all_processes(struct amdgpu_device *adev);
>>>>>  void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);
>>>>>  int amdgpu_amdkfd_resume_iommu(struct amdgpu_device *adev);
>>>>>  int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm, 
>>>>> bool sync);
>>>>> @@ -405,6 +406,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>>>>> const struct kgd2kfd_shared_resources *gpu_resources);
>>>>>  void kgd2kfd_device_exit(struct kfd_dev *kfd);
>>>>>  void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm, bool force);
>>>>> +void kgd2kfd_kill_all_user_processes(struct kfd_dev *kfd);
>>>>>  int kgd2kfd_resume_iommu(struct kfd_dev *kfd);
>>>>>  int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm, bool sync);
>>>>>  int kgd2kfd_pre_reset(struct kfd_dev *kfd);
>>>>> @@ -443,6 +445,9 @@ static inline void kgd2kfd_suspend(struct 
>>>>> kfd_dev *kfd, bool run_pm, bool force)
>>>>>  {
>>>>>  }
>>>>> +void kgd2kfd_kill_all_user_processes(struct kfd_dev *kfd){
>>>>> +}
>>>>> +
>>>>>  static int __maybe_unused kgd2kfd_resume_iommu(struct kfd_dev *kfd)
>>>>>  {
>>>>> return 0;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> index 3d5fc0751829..af6fe5080cfa 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>> @@ -2101,6 +2101,9 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>>>>>  {
>>>>> struct drm_device *dev = pci_get_drvdata(pdev);
>>>>> +/* kill all kfd processes before drm_dev_unplug */
>>>>> +amdgpu_amdkfd_kill_all_processes(drm_to_adev(dev));
>>>>> +
>>>>>  #ifdef HAVE_DRM_DEV_UNPLUG
>>>>> drm_dev_unplug(dev);
>>>>>  #else
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>> index 5504a18b5a45..480c23bef5e2 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>> @@ -691,6 +691,12 @@ bool kfd_is_locked(void)
>>>>> return  (atomic_read(&kfd_locked) > 0);
>>>>>  }
>>>>> +inline void kgd2kfd_kill_all_user_processes(struct kfd_dev* dev)
>>>>> +{
>>>>> +kfd_kill_all_user_processes();
>>>>> +}
>>>>> +
>>>>> +
>>>>>  void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm, bool force)
>>>>>  {
>>>>> if (!kfd->init_complete)
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> index 55c9e1922714..a35a2cb5bb9f 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> @@ -1064,6 +1064,7 @@ static inline struct kfd_process_device 
>>>>> *kfd_process_device_from_gpuidx(
>>>>>  void kfd_unref_process(struct kfd_process *p);
>>>>>  int kfd_process_evict_queues(struct kfd_process *p, bool force);
>>>>>  int kfd_process_restore_queues(struct kfd_process *p);
>>>>> +void kfd_kill_all_user_processes(void);
>>>>>  void kfd_suspend_all_processes(bool force);
>>>>>  /*
>>>>>   * kfd_resume_all_processes:
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> index 6cdc855abb6d..17e769e6951d 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> @@ -46,6 +46,9 @@ struct mm_struct;
>>>>>  #include "kfd_trace.h"
>>>>>  #include "kfd_debug.h"
>>>>> +static atomic_t kfd_process_locked = ATOMIC_INIT(0);
>>>>> +static atomic_t kfd_inflight_kills = ATOMIC_INIT(0);
>>>>> +
>>>>>  /*
>>>>>   * List of struct kfd_process (field kfd_process).
>>>>>   * Unique/indexed by mm_struct*
>>>>> @@ -802,6 +805,9 @@ struct kfd_process *kfd_create_process(struct 
>>>>> task_struct *thread)
>>>>> struct kfd_process *process;
>>>>> int ret;
>>>>> +if ( atomic_read(&kfd_process_locked) > 0 )
>>>>> +return ERR_PTR(-EINVAL);
>>>>> +
>>>>> if (!(thread->mm && mmget_not_zero(thread->mm)))
>>>>> return ERR_PTR(-EINVAL);
>>>>> @@ -1126,6 +1132,10 @@ static void kfd_process_wq_release(struct 
>>>>> work_struct *work)
>>>>> put_task_struct(p->lead_thread);
>>>>> kfree(p);
>>>>> +
>>>>> +if ( atomic_read(&kfd_process_locked) > 0 ){
>>>>> +atomic_dec(&kfd_inflight_kills);
>>>>> +}
>>>>>  }
>>>>>  static void kfd_process_ref_release(struct kref *ref)
>>>>> @@ -2186,6 +2196,35 @@ static void restore_process_worker(struct 
>>>>> work_struct *work)
>>>>> pr_err("Failed to restore queues of pasid 0x%x\n", p->pasid);
>>>>>  }
>>>>> +void kfd_kill_all_user_processes(void)
>>>>> +{
>>>>> +struct kfd_process *p;
>>>>> +/* struct amdkfd_process_info *p_info; */
>>>>> +unsigned int temp;
>>>>> +int idx;
>>>>> +atomic_inc(&kfd_process_locked);
>>>>> +
>>>>> +idx = srcu_read_lock(&kfd_processes_srcu);
>>>>> +pr_info("Killing all processes\n");
>>>>> +hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>>>>> +dev_warn(kfd_device,
>>>>> +"Sending SIGBUS to process %d (pasid 0x%x)",
>>>>> +p->lead_thread->pid, p->pasid);
>>>>> +send_sig(SIGBUS, p->lead_thread, 0);
>>>>> +atomic_inc(&kfd_inflight_kills);
>>>>> +}
>>>>> +srcu_read_unlock(&kfd_processes_srcu, idx);
>>>>> +
>>>>> +while ( atomic_read(&kfd_inflight_kills) > 0 ){
>>>>> +dev_warn(kfd_device,
>>>>> +"kfd_processes_table is not empty, going to sleep for 10ms\n");
>>>>> +msleep(10);
>>>>> +}
>>>>> +
>>>>> +atomic_dec(&kfd_process_locked);
>>>>> +pr_info("all processes has been fully released");
>>>>> +}
>>>>> +
>>>>>  void kfd_suspend_all_processes(bool force)
>>>>>  {
>>>>> struct kfd_process *p;
>>>>>
>>>>>
>>>>>
>>>>> Regards,
>>>>> Shuotao
>>>>>
>>>>>>
>>>>>> Andrey
>>>>>>
>>>>>>> +       }
>>>>>>> + srcu_read_unlock(&kfd_processes_srcu, idx);
>>>>>>> +}
>>>>>>> +
>>>>>>> +
>>>>>>>  int kfd_resume_all_processes(bool sync)
>>>>>>>  {
>>>>>>>         struct kfd_process *p;
>>>>>>>
>>>>>>>
>>>>>>>> Andrey
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Really appreciate your help!
>>>>>>>>>
>>>>>>>>> Best,
>>>>>>>>> Shuotao
>>>>>>>>>
>>>>>>>>>>> 2. Remove redudant p2p/io links in sysfs when device is 
>>>>>>>>>>> hotplugged
>>>>>>>>>>> out.
>>>>>>>>>>>
>>>>>>>>>>> 3. New kfd node_id is not properly assigned after a new 
>>>>>>>>>>> device is
>>>>>>>>>>> added after a gpu is hotplugged out in a system. libhsakmt will
>>>>>>>>>>> find this anomaly, (i.e. node_from != <dev node id> in iolinks),
>>>>>>>>>>> when taking a topology_snapshot, thus returns fault to the rocm
>>>>>>>>>>> stack.
>>>>>>>>>>>
>>>>>>>>>>> -- This patch fixes issue 1; another patch by Mukul fixes 
>>>>>>>>>>> issues 2&3.
>>>>>>>>>>> -- Tested on a 4-GPU MI100 gpu nodes with kernel 5.13.0-kfd; 
>>>>>>>>>>> kernel
>>>>>>>>>>> 5.16.0-kfd is unstable out of box for MI100.
>>>>>>>>>>> ---
>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 5 +++++
>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 7 +++++++
>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
>>>>>>>>>>> drivers/gpu/drm/amd/amdkfd/kfd_device.c | 13 +++++++++++++
>>>>>>>>>>> 4 files changed, 26 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>>>> index c18c4be1e4ac..d50011bdb5c4 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>>>> @@ -213,6 +213,11 @@ int amdgpu_amdkfd_resume(struct 
>>>>>>>>>>> amdgpu_device *adev, bool run_pm)
>>>>>>>>>>> return r;
>>>>>>>>>>> }
>>>>>>>>>>>
>>>>>>>>>>> +int amdgpu_amdkfd_resume_processes(void)
>>>>>>>>>>> +{
>>>>>>>>>>> + return kgd2kfd_resume_processes();
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>> int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev)
>>>>>>>>>>> {
>>>>>>>>>>> int r = 0;
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>>>>>>>> index f8b9f27adcf5..803306e011c3 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>>>>>>>> @@ -140,6 +140,7 @@ void amdgpu_amdkfd_fini(void);
>>>>>>>>>>> void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool 
>>>>>>>>>>> run_pm);
>>>>>>>>>>> int amdgpu_amdkfd_resume_iommu(struct amdgpu_device *adev);
>>>>>>>>>>> int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool 
>>>>>>>>>>> run_pm);
>>>>>>>>>>> +int amdgpu_amdkfd_resume_processes(void);
>>>>>>>>>>> void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
>>>>>>>>>>> const void *ih_ring_entry);
>>>>>>>>>>> void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev);
>>>>>>>>>>> @@ -347,6 +348,7 @@ void kgd2kfd_device_exit(struct kfd_dev 
>>>>>>>>>>> *kfd);
>>>>>>>>>>> void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
>>>>>>>>>>> int kgd2kfd_resume_iommu(struct kfd_dev *kfd);
>>>>>>>>>>> int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
>>>>>>>>>>> +int kgd2kfd_resume_processes(void);
>>>>>>>>>>> int kgd2kfd_pre_reset(struct kfd_dev *kfd);
>>>>>>>>>>> int kgd2kfd_post_reset(struct kfd_dev *kfd);
>>>>>>>>>>> void kgd2kfd_interrupt(struct kfd_dev *kfd, const void 
>>>>>>>>>>> *ih_ring_entry);
>>>>>>>>>>> @@ -393,6 +395,11 @@ static inline int kgd2kfd_resume(struct 
>>>>>>>>>>> kfd_dev *kfd, bool run_pm)
>>>>>>>>>>> return 0;
>>>>>>>>>>> }
>>>>>>>>>>>
>>>>>>>>>>> +static inline int kgd2kfd_resume_processes(void)
>>>>>>>>>>> +{
>>>>>>>>>>> + return 0;
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>> static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd)
>>>>>>>>>>> {
>>>>>>>>>>> return 0;
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>> index fa4a9f13c922..5827b65b7489 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>> @@ -4004,6 +4004,7 @@ void amdgpu_device_fini_hw(struct 
>>>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>>> if (drm_dev_is_unplugged(adev_to_drm(adev)))
>>>>>>>>>>> amdgpu_device_unmap_mmio(adev);
>>>>>>>>>>>
>>>>>>>>>>> + amdgpu_amdkfd_resume_processes();
>>>>>>>>>>> }
>>>>>>>>>>>
>>>>>>>>>>> void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>>>>>>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>>>>>> index 62aa6c9d5123..ef05aae9255e 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>>>>>> @@ -714,6 +714,19 @@ int kgd2kfd_resume(struct kfd_dev *kfd, 
>>>>>>>>>>> bool run_pm)
>>>>>>>>>>> return ret;
>>>>>>>>>>> }
>>>>>>>>>>>
>>>>>>>>>>> +/* for non-runtime resume only */
>>>>>>>>>>> +int kgd2kfd_resume_processes(void)
>>>>>>>>>>> +{
>>>>>>>>>>> + int count;
>>>>>>>>>>> +
>>>>>>>>>>> + count = atomic_dec_return(&kfd_locked);
>>>>>>>>>>> + WARN_ONCE(count < 0, "KFD suspend / resume ref. error");
>>>>>>>>>>> + if (count == 0)
>>>>>>>>>>> + return kfd_resume_all_processes();
>>>>>>>>>>> +
>>>>>>>>>>> + return 0;
>>>>>>>>>>> +}
>>>>>>>>>>
>>>>>>>>>> It doesn't make sense to me to just increment kfd_locked in
>>>>>>>>>> kgd2kfd_suspend to only decrement it again a few functions 
>>>>>>>>>> down the
>>>>>>>>>> road.
>>>>>>>>>>
>>>>>>>>>> I suggest this instead - you only incrmemnt if not during PCI 
>>>>>>>>>> remove
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>>>>> index 1c2cf3a33c1f..7754f77248a4 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>>>>> @@ -952,11 +952,12 @@ bool kfd_is_locked(void)
>>>>>>>>>>
>>>>>>>>>> void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
>>>>>>>>>> {
>>>>>>>>>> +
>>>>>>>>>> if (!kfd->init_complete)
>>>>>>>>>> return;
>>>>>>>>>>
>>>>>>>>>> /* for runtime suspend, skip locking kfd */
>>>>>>>>>> - if (!run_pm) {
>>>>>>>>>> + if (!run_pm && !drm_dev_is_unplugged(kfd->ddev)) {
>>>>>>>>>> /* For first KFD device suspend all the KFD processes */
>>>>>>>>>> if (atomic_inc_return(&kfd_locked) == 1)
>>>>>>>>>> kfd_suspend_all_processes();
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Andrey
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> +
>>>>>>>>>>> int kgd2kfd_resume_iommu(struct kfd_dev *kfd)
>>>>>>>>>>> {
>>>>>>>>>>> int err = 0;
>>>>>>>
>>>>>
>>>
>
--------------xrbxjLbD1QNXX7AXrR0UR8ux
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-04-18 09:22, Shuotao Xu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:7825EEC6-BAF8-4B71-B01C-FE246D360779@microsoft.com">
      
      <br class="">
      <div><br class="">
        <blockquote type="cite" class="">
          <div class="">On Apr 16, 2022, at 12:43 AM, Andrey Grodzovsky
            &lt;<a href="mailto:andrey.grodzovsky@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">andrey.grodzovsky@amd.com</a>&gt;
            wrote:</div>
          <br class="Apple-interchange-newline">
          <div class="">
            <div class="">
              <p class=""><br class="">
              </p>
              <div class="moz-cite-prefix">On 2022-04-15 06:12, Shuotao
                Xu wrote:<br class="">
              </div>
              <blockquote type="cite" cite="mid:76C16B06-0539-48EE-AB11-80089490CE3A@microsoft.com" class="">
                Hi Andrey,
                <div class=""><br class="">
                </div>
                <div class="">First I really appreciate the discussion!
                  It helped me understand the driver code greatly. Thank
                  you so much:)</div>
                <div class="">Please see my inline comments.&nbsp;<br class="">
                  <div class=""><br class="">
                    <blockquote type="cite" class="">
                      <div class="">On Apr 14, 2022, at 11:13 PM, Andrey
                        Grodzovsky &lt;<a href="mailto:andrey.grodzovsky@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">andrey.grodzovsky@amd.com</a>&gt;
                        wrote:</div>
                      <br class="Apple-interchange-newline">
                      <div class="">
                        <div class="">
                          <p class=""><br class="">
                          </p>
                          <div class="moz-cite-prefix">On 2022-04-14
                            10:00, Shuotao Xu wrote:<br class="">
                          </div>
                          <blockquote type="cite" cite="mid:B7970589-ACF6-41F3-8622-1C0F705F3EE0@microsoft.com" class="">
                            <br class="">
                            <div class=""><br class="">
                              <blockquote type="cite" class="">
                                <div class="">On Apr 14, 2022, at 1:31
                                  AM, Andrey Grodzovsky &lt;<a href="mailto:andrey.grodzovsky@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">andrey.grodzovsky@amd.com</a>&gt;
                                  wrote:</div>
                                <br class="Apple-interchange-newline">
                                <div class="">
                                  <div class="">
                                    <p class=""><br class="">
                                    </p>
                                    <div class="moz-cite-prefix">On
                                      2022-04-13 12:03, Shuotao Xu
                                      wrote:<br class="">
                                    </div>
                                    <blockquote type="cite" cite="mid:5A64FAEA-CCE8-4EB6-8E7B-852D4F384255@microsoft.com" class="">
                                      <br class="">
                                      <div class=""><br class="">
                                        <blockquote type="cite" class="">
                                          <div class="">On Apr 11, 2022,
                                            at 11:52 PM, Andrey
                                            Grodzovsky &lt;<a href="mailto:andrey.grodzovsky@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">andrey.grodzovsky@amd.com</a>&gt;
                                            wrote:</div>
                                          <br class="Apple-interchange-newline">
                                          <div class=""><span style="caret-color: rgb(0,
                                              0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none; float: none;
                                              display: inline
                                              !important;" class="">[Some
                                              people who received this
                                              message don't often get
                                              email from<span class="Apple-converted-space">&nbsp;</span></span><a href="mailto:andrey.grodzovsky@amd.com" style="font-family: Helvetica;
                                              font-size: 12px;
                                              font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              orphans: auto; text-align:
                                              start; text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              widows: auto;
                                              word-spacing: 0px;
                                              -webkit-text-size-adjust:
                                              auto;
                                              -webkit-text-stroke-width:
                                              0px;" class="moz-txt-link-freetext" moz-do-not-send="true">andrey.grodzovsky@amd.com</a><span style="caret-color: rgb(0,
                                              0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none; float: none;
                                              display: inline
                                              !important;" class="">.
                                              Learn why this is
                                              important at<span class="Apple-converted-space">&nbsp;</span></span><a href="http://aka.ms/LearnAboutSenderIdentification" style="font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              orphans: auto; text-align:
                                              start; text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              widows: auto;
                                              word-spacing: 0px;
                                              -webkit-text-size-adjust:
                                              auto;
                                              -webkit-text-stroke-width:
                                              0px;" class="moz-txt-link-freetext" moz-do-not-send="true">http://aka.ms/LearnAboutSenderIdentification</a><span style="caret-color: rgb(0,
                                              0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none; float: none;
                                              display: inline
                                              !important;" class="">.]</span><br style="caret-color: rgb(0,
                                              0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <br style="caret-color:
                                              rgb(0, 0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <span style="caret-color:
                                              rgb(0, 0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none; float: none;
                                              display: inline
                                              !important;" class="">On
                                              2022-04-08 21:28, Shuotao
                                              Xu wrote:</span><br style="caret-color: rgb(0,
                                              0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <blockquote type="cite" style="font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              orphans: auto; text-align:
                                              start; text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              widows: auto;
                                              word-spacing: 0px;
                                              -webkit-text-size-adjust:
                                              auto;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                              <br class="">
                                              <blockquote type="cite" class="">On Apr 8, 2022,
                                                at 11:28 PM, Andrey
                                                Grodzovsky &lt;<a href="mailto:andrey.grodzovsky@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">andrey.grodzovsky@amd.com</a>&gt;
                                                wrote:<br class="">
                                                <br class="">
                                                [Some people who
                                                received this message
                                                don't often get email
                                                from <a href="mailto:andrey.grodzovsky@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">
andrey.grodzovsky@amd.com</a>. Learn why this is important at <a href="http://aka.ms/LearnAboutSenderIdentification" class="moz-txt-link-freetext" moz-do-not-send="true">
http://aka.ms/LearnAboutSenderIdentification</a>.]<br class="">
                                                <br class="">
                                                On 2022-04-08 04:45,
                                                Shuotao Xu wrote:<br class="">
                                                <blockquote type="cite" class="">Adding PCIe
                                                  Hotplug Support for
                                                  AMDKFD: the support of
                                                  hot-plug of GPU<br class="">
                                                  devices can open doors
                                                  for many advanced
                                                  applications in data
                                                  center<br class="">
                                                  in the next few years,
                                                  such as for GPU
                                                  resource<br class="">
                                                  disaggregation.
                                                  Current AMDKFD does
                                                  not support hotplug
                                                  out b/o the<br class="">
                                                  following reasons:<br class="">
                                                  <br class="">
                                                  1. During PCIe
                                                  removal, decrement KFD
                                                  lock which was
                                                  incremented at<br class="">
                                                  the beginning of hw
                                                  fini; otherwise
                                                  kfd_open later is
                                                  going to<br class="">
                                                  fail.<br class="">
                                                </blockquote>
                                                I assumed you read my
                                                comment last time, still
                                                you do same approach.<br class="">
                                                More in details bellow<br class="">
                                              </blockquote>
                                              Aha, I like your fix:) I
                                              was not familiar with drm
                                              APIs so just only half
                                              understood your comment
                                              last time.<br class="">
                                              <br class="">
                                              BTW, I tried hot-plugging
                                              out a GPU when rocm
                                              application is still
                                              running.<br class="">
                                              From dmesg, application is
                                              still trying to access the
                                              removed kfd device, and
                                              are met with some errors.<br class="">
                                            </blockquote>
                                            <br style="caret-color:
                                              rgb(0, 0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <br style="caret-color:
                                              rgb(0, 0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <span style="caret-color:
                                              rgb(0, 0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none; float: none;
                                              display: inline
                                              !important;" class="">Application
                                              us supposed to keep
                                              running, it holds the
                                              drm_device</span><br style="caret-color: rgb(0,
                                              0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <span style="caret-color:
                                              rgb(0, 0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none; float: none;
                                              display: inline
                                              !important;" class="">reference
                                              as long as it has an open</span><br style="caret-color: rgb(0,
                                              0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <span style="caret-color:
                                              rgb(0, 0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none; float: none;
                                              display: inline
                                              !important;" class="">FD
                                              to the device and final
                                              cleanup will come only
                                              after the app will die</span><br style="caret-color: rgb(0,
                                              0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <span style="caret-color:
                                              rgb(0, 0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none; float: none;
                                              display: inline
                                              !important;" class="">thus
                                              releasing the FD and the
                                              last</span><br style="caret-color: rgb(0,
                                              0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <span style="caret-color:
                                              rgb(0, 0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none; float: none;
                                              display: inline
                                              !important;" class="">drm_device
                                              reference.</span><br style="caret-color: rgb(0,
                                              0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <br style="caret-color:
                                              rgb(0, 0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <blockquote type="cite" style="font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              orphans: auto; text-align:
                                              start; text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              widows: auto;
                                              word-spacing: 0px;
                                              -webkit-text-size-adjust:
                                              auto;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                              Application would hang and
                                              not exiting in this case.<br class="">
                                            </blockquote>
                                            <br style="caret-color:
                                              rgb(0, 0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                          </div>
                                        </blockquote>
                                        <div class=""><br class="">
                                        </div>
                                        Actually I tried kill -7 $pid,
                                        and the process exists. The
                                        dmesg has some warning though.</div>
                                      <div class=""><br class="">
                                      </div>
                                      <div class="">
                                        <div class="">[ &nbsp;711.769977]
                                          WARNING: CPU: 23 PID: 344 at
                                          .../amdgpu-rocm5.0.2/src/amd/amdgpu/amdgpu_object.c:1336
amdgpu_bo_release_notify+0x150/0x160 [amdgpu]</div>
                                        <div class="">[ &nbsp;711.770528]
                                          Modules linked in: amdgpu(OE)
                                          amdttm(OE) amd_sched(OE)
                                          amdkcl(OE) iommu_v2
                                          nf_conntrack_netlink nfnetlink
                                          xfrm_user xfrm_algo
                                          xt_addrtype br_netfilter
                                          xt_CHECKSUM iptable_mangle
                                          xt_MASQUERADE iptable_nat
                                          nf_nat xt_conntrack
                                          nf_conntrack nf_defrag_ipv6
                                          nf_defrag_ipv4 ipt_REJECT
                                          nf_reject_ipv4 xt_tcpudp
                                          bridge stp llc ebtable_filter
                                          ebtables ip6table_filter
                                          ip6_tables iptable_filter
                                          overlay binfmt_misc
                                          intel_rapl_msr i40iw
                                          intel_rapl_common skx_edac
                                          nfit x86_pkg_temp_thermal
                                          intel_powerclamp coretemp
                                          kvm_intel rpcrdma kvm sunrpc
                                          ipmi_ssif ib_umad ib_ipoib
                                          rdma_ucm irqbypass rapl joydev
                                          acpi_ipmi input_leds
                                          intel_cstate ipmi_si
                                          ipmi_devintf mei_me mei
                                          intel_pch_thermal
                                          ipmi_msghandler ioatdma
                                          mac_hid lpc_ich dca
                                          acpi_power_meter acpi_pad
                                          sch_fq_codel ib_iser rdma_cm
                                          iw_cm ib_cm iscsi_tcp
                                          libiscsi_tcp libiscsi
                                          scsi_transport_iscsi pci_stub
                                          ip_tables x_tables autofs4
                                          btrfs blake2b_generic
                                          zstd_compress raid10 raid456
                                          async_raid6_recov async_memcpy
                                          async_pq async_xor async_tx
                                          xor</div>
                                        <div class="">[ &nbsp;711.779359]
                                          &nbsp;raid6_pq libcrc32c raid1
                                          raid0 multipath linear mlx5_ib
                                          ib_uverbs ib_core ast
                                          drm_vram_helper i2c_algo_bit
                                          drm_ttm_helper ttm
                                          drm_kms_helper syscopyarea
                                          crct10dif_pclmul crc32_pclmul
                                          ghash_clmulni_intel
                                          sysfillrect uas hid_generic
                                          sysimgblt aesni_intel
                                          mlx5_core fb_sys_fops
                                          crypto_simd usbhid cryptd drm
                                          i40e pci_hyperv_intf
                                          usb_storage glue_helper mlxfw
                                          hid ahci libahci wmi</div>
                                        <div class="">[ &nbsp;711.779752]
                                          CPU: 23 PID: 344 Comm:
                                          kworker/23:1 Tainted: G &nbsp; &nbsp; &nbsp;
                                          &nbsp;W &nbsp;OE &nbsp; &nbsp; 5.11.0+ #1</div>
                                        <div class="">[ &nbsp;711.779755]
                                          Hardware name: Supermicro
                                          SYS-4029GP-TRT2/X11DPG-OT-CPU,
                                          BIOS 2.1 08/14/2018</div>
                                        <div class="">[ &nbsp;711.779756]
                                          Workqueue: kfd_process_wq
                                          kfd_process_wq_release
                                          [amdgpu]</div>
                                        <div class="">[ &nbsp;711.779955]
                                          RIP:
                                          0010:amdgpu_bo_release_notify+0x150/0x160
                                          [amdgpu]</div>
                                        <div class="">[ &nbsp;711.780141]
                                          Code: e8 b5 af 34 f4 e9 1f ff
                                          ff ff 48 39 c2 74 07 0f 0b e9
                                          69 ff ff ff 4c 89 e7 e8 3c b4
                                          16 00 e9 5c ff ff ff e8 a2 ce
                                          fd f3 eb cf &lt;0f&gt; 0b eb
                                          cb e8 d7 02 34 f4 0f 1f 80 00
                                          00 00 00 0f 1f 44 00 00 55</div>
                                        <div class="">[ &nbsp;711.780143]
                                          RSP: 0018:ffffa8100dd67c30
                                          EFLAGS: 00010282</div>
                                        <div class="">[ &nbsp;711.780145]
                                          RAX: 00000000ffffffea RBX:
                                          ffff89980e792058 RCX:
                                          0000000000000000</div>
                                        <div class="">[ &nbsp;711.780147]
                                          RDX: 0000000000000000 RSI:
                                          ffff89a8f9ad8870 RDI:
                                          ffff89a8f9ad8870</div>
                                        <div class="">[ &nbsp;711.780148]
                                          RBP: ffffa8100dd67c50 R08:
                                          0000000000000000 R09:
                                          fffffffffff99b18</div>
                                        <div class="">[ &nbsp;711.780149]
                                          R10: ffffa8100dd67bd0 R11:
                                          ffffa8100dd67908 R12:
                                          ffff89980e792000</div>
                                        <div class="">[ &nbsp;711.780151]
                                          R13: ffff89980e792058 R14:
                                          ffff89980e7921bc R15:
                                          dead000000000100</div>
                                        <div class="">[ &nbsp;711.780152] FS:
                                          &nbsp;0000000000000000(0000)
                                          GS:ffff89a8f9ac0000(0000)
                                          knlGS:0000000000000000</div>
                                        <div class="">[ &nbsp;711.780154] CS:
                                          &nbsp;0010 DS: 0000 ES: 0000 CR0:
                                          0000000080050033</div>
                                        <div class="">[ &nbsp;711.780156]
                                          CR2: 00007ffddac6f71f CR3:
                                          00000030bb80a003 CR4:
                                          00000000007706e0</div>
                                        <div class="">[ &nbsp;711.780157]
                                          DR0: 0000000000000000 DR1:
                                          0000000000000000 DR2:
                                          0000000000000000</div>
                                        <div class="">[ &nbsp;711.780159]
                                          DR3: 0000000000000000 DR6:
                                          00000000fffe0ff0 DR7:
                                          0000000000000400</div>
                                        <div class="">[ &nbsp;711.780160]
                                          PKRU: 55555554</div>
                                        <div class="">[ &nbsp;711.780161]
                                          Call Trace:</div>
                                        <div class="">[ &nbsp;711.780163]
                                          &nbsp;ttm_bo_release+0x2ae/0x320
                                          [amdttm]</div>
                                        <div class="">[ &nbsp;711.780169]
                                          &nbsp;amdttm_bo_put+0x30/0x40
                                          [amdttm]</div>
                                        <div class="">[ &nbsp;711.780357]
                                          &nbsp;amdgpu_bo_unref+0x1e/0x30
                                          [amdgpu]</div>
                                        <div class="">[ &nbsp;711.780543]
                                          &nbsp;amdgpu_gem_object_free+0x8b/0x160
                                          [amdgpu]</div>
                                        <div class="">[ &nbsp;711.781119]
                                          &nbsp;drm_gem_object_free+0x1d/0x30
                                          [drm]</div>
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
                                        <div class="">[ &nbsp;711.785387]
                                          ---[ end trace
                                          d8f50f6594817c84 ]---</div>
                                        <div class="">[ &nbsp;711.798716]
                                          [drm] amdgpu: ttm finalized</div>
                                      </div>
                                    </blockquote>
                                    <p class=""><br class="">
                                    </p>
                                    <p class="">So it means the process
                                      was stuck in some
                                      wait_event_killable (maybe here
                                      drm_sched_entity_flush) - you can
                                      try 'cat/proc/$process_pid/stack'
                                      maybe before<br class="">
                                      you kill it to see where it was
                                      stuck so we can go from there.<br class="">
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
                                          <div class=""><br style="caret-color: rgb(0,
                                              0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <span style="caret-color:
                                              rgb(0, 0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none; float: none;
                                              display: inline
                                              !important;" class="">For
                                              graphic apps what i
                                              usually see is a crash
                                              because of sigsev when</span><br style="caret-color: rgb(0,
                                              0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <span style="caret-color:
                                              rgb(0, 0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none; float: none;
                                              display: inline
                                              !important;" class="">the
                                              app tries to access</span><br style="caret-color: rgb(0,
                                              0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <span style="caret-color:
                                              rgb(0, 0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none; float: none;
                                              display: inline
                                              !important;" class="">an
                                              unmapped MMIO region on
                                              the device. I haven't
                                              tested for compute</span><br style="caret-color: rgb(0,
                                              0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <span style="caret-color:
                                              rgb(0, 0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none; float: none;
                                              display: inline
                                              !important;" class="">stack
                                              and so there might</span><br style="caret-color: rgb(0,
                                              0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <span style="caret-color:
                                              rgb(0, 0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none; float: none;
                                              display: inline
                                              !important;" class="">be
                                              something I haven't
                                              covered. Hang could mean
                                              for example waiting on a</span><br style="caret-color: rgb(0,
                                              0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <span style="caret-color:
                                              rgb(0, 0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none; float: none;
                                              display: inline
                                              !important;" class="">fence
                                              which is not being</span><br style="caret-color: rgb(0,
                                              0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <span style="caret-color:
                                              rgb(0, 0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none; float: none;
                                              display: inline
                                              !important;" class="">signaled
                                              - please provide full
                                              dmesg from this case.</span><br style="caret-color: rgb(0,
                                              0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <br style="caret-color:
                                              rgb(0, 0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <blockquote type="cite" style="font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              orphans: auto; text-align:
                                              start; text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              widows: auto;
                                              word-spacing: 0px;
                                              -webkit-text-size-adjust:
                                              auto;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                              <br class="">
                                              Do you have any good
                                              suggestions on how to fix
                                              it down the line? (HIP
                                              runtime/libhsakmt or
                                              driver)<br class="">
                                              <br class="">
                                              [64036.631333] amdgpu:
                                              amdgpu_vm_bo_update failed<br class="">
                                              [64036.631702] amdgpu:
                                              validate_invalid_user_pages:
                                              update PTE failed<br class="">
                                              [64036.640754] amdgpu:
                                              amdgpu_vm_bo_update failed<br class="">
                                              [64036.641120] amdgpu:
                                              validate_invalid_user_pages:
                                              update PTE failed<br class="">
                                              [64036.650394] amdgpu:
                                              amdgpu_vm_bo_update failed<br class="">
                                              [64036.650765] amdgpu:
                                              validate_invalid_user_pages:
                                              update PTE failed<br class="">
                                            </blockquote>
                                            <br style="caret-color:
                                              rgb(0, 0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                          </div>
                                        </blockquote>
                                        <div class=""><br class="">
                                        </div>
                                        The full dmesg will just the
                                        repetition of those two
                                        messages,</div>
                                      <div class="">
                                        <div class="">[186885.764079]
                                          amdgpu 0000:43:00.0: amdgpu:
                                          amdgpu: finishing device.</div>
                                        <div class="">[186885.766916]
                                          [drm] free PSP TMR buffer</div>
                                        <div class="">[186893.868173]
                                          amdgpu: amdgpu_vm_bo_update
                                          failed</div>
                                        <div class="">[186893.868235]
                                          amdgpu:
                                          validate_invalid_user_pages:
                                          update PTE failed</div>
                                        <div class="">[186893.876154]
                                          amdgpu: amdgpu_vm_bo_update
                                          failed</div>
                                        <div class="">[186893.876190]
                                          amdgpu:
                                          validate_invalid_user_pages:
                                          update PTE failed</div>
                                        <div class="">[186893.884150]
                                          amdgpu: amdgpu_vm_bo_update
                                          failed</div>
                                        <div class="">[186893.884185]
                                          amdgpu:
                                          validate_invalid_user_pages:
                                          update PTE failed</div>
                                      </div>
                                      <div class=""><br class="">
                                      </div>
                                      <div class="">
                                        <blockquote type="cite" class="">
                                          <div class=""><br style="caret-color: rgb(0,
                                              0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <span style="caret-color:
                                              rgb(0, 0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none; float: none;
                                              display: inline
                                              !important;" class="">This
                                              just probably means trying
                                              to update PTEs after the
                                              physical device</span><br style="caret-color: rgb(0,
                                              0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <span style="caret-color:
                                              rgb(0, 0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none; float: none;
                                              display: inline
                                              !important;" class="">is
                                              gone - we usually avoid
                                              this by</span><br style="caret-color: rgb(0,
                                              0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <span style="caret-color:
                                              rgb(0, 0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none; float: none;
                                              display: inline
                                              !important;" class="">first
                                              trying to do all HW
                                              shutdowns early before PCI
                                              remove completion</span><br style="caret-color: rgb(0,
                                              0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <span style="caret-color:
                                              rgb(0, 0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none; float: none;
                                              display: inline
                                              !important;" class="">but
                                              when it's really tricky by</span><br style="caret-color: rgb(0,
                                              0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <span style="caret-color:
                                              rgb(0, 0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none; float: none;
                                              display: inline
                                              !important;" class="">protecting
                                              HW access sections with
                                              drm_dev_enter/exit scope.</span><br style="caret-color: rgb(0,
                                              0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <br style="caret-color:
                                              rgb(0, 0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <span style="caret-color:
                                              rgb(0, 0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none; float: none;
                                              display: inline
                                              !important;" class="">For
                                              this particular error it
                                              would be the best to flush</span><br style="caret-color: rgb(0,
                                              0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <span style="caret-color:
                                              rgb(0, 0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none; float: none;
                                              display: inline
                                              !important;" class="">info-&gt;restore_userptr_work
                                              before the end of</span><br style="caret-color: rgb(0,
                                              0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <span style="caret-color:
                                              rgb(0, 0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none; float: none;
                                              display: inline
                                              !important;" class="">amdgpu_pci_remove
                                              (rejecting new process
                                              creation and calling</span><br style="caret-color: rgb(0,
                                              0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <span style="caret-color:
                                              rgb(0, 0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none; float: none;
                                              display: inline
                                              !important;" class="">cancel_delayed_work_sync(&amp;process_info-&gt;restore_userptr_work)
                                              for all</span><br style="caret-color: rgb(0,
                                              0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <span style="caret-color:
                                              rgb(0, 0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none; float: none;
                                              display: inline
                                              !important;" class="">running
                                              processes)</span><br style="caret-color: rgb(0,
                                              0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <span style="caret-color:
                                              rgb(0, 0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none; float: none;
                                              display: inline
                                              !important;" class="">somewhere
                                              in amdgpu_pci_remove.</span><br style="caret-color: rgb(0,
                                              0, 0); font-family:
                                              Helvetica; font-size:
                                              12px; font-style: normal;
                                              font-variant-caps: normal;
                                              font-weight: 400;
                                              letter-spacing: normal;
                                              text-align: start;
                                              text-indent: 0px;
                                              text-transform: none;
                                              white-space: normal;
                                              word-spacing: 0px;
                                              -webkit-text-stroke-width:
                                              0px; text-decoration:
                                              none;" class="">
                                            <br class="">
                                          </div>
                                        </blockquote>
                                        I tried something like
                                        *kfd_process_ref_release* which
                                        I think did what you described,
                                        but it did not work.</div>
                                    </blockquote>
                                    <p class=""><br class="">
                                    </p>
                                    <p class="">I don't see how
                                      kfd_process_ref_release is the
                                      same as I mentioned above, what i
                                      meant is calling the code above
                                      within kgd2kfd_suspend (where you
                                      tried to call
                                      kfd_kill_all_user_processes
                                      bellow)
                                      <br class="">
                                    </p>
                                  </div>
                                </div>
                              </blockquote>
                              Yes, you are right. It was not called by
                              it. &nbsp;<br class="">
                              <blockquote type="cite" class="">
                                <div class="">
                                  <div class="">
                                    <p class=""><br class="">
                                    </p>
                                    <blockquote type="cite" cite="mid:5A64FAEA-CCE8-4EB6-8E7B-852D4F384255@microsoft.com" class="">
                                      <div class=""><br class="">
                                      </div>
                                      <div class="">Instead I tried to
                                        kill the process from the
                                        kernel, but the amdgpu could
                                        **only** be hot-plugged in back
                                        successfully only if there was
                                        no rocm kernel running when it
                                        was plugged out. If not,
                                        amdgpu_probe will just hang
                                        later. (Maybe because amdgpu was
                                        plugged out while running state,
                                        it leaves a bad HW state which
                                        causes probe to hang).</div>
                                    </blockquote>
                                    <p class=""><br class="">
                                    </p>
                                    <p class="">We usually do asic_reset
                                      during probe to reset all HW state
                                      (checlk if
                                      amdgpu_device_init-&gt;amdgpu_asic_reset
                                      is running when you&nbsp; plug back).
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
                                      <div class="">I don’t know if this
                                        is a viable solution worth
                                        pursuing, but I attached the
                                        diff anyway.</div>
                                      <div class=""><br class="">
                                      </div>
                                      <div class="">Another solution
                                        could be let compute stack user
                                        mode detect a topology change
                                        via&nbsp;<span class="">generation_count
                                          change, and abort gracefully
                                          there.</span></div>
                                      <div class=""><br class="">
                                      </div>
                                      <div class="">diff --git
                                        a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
b/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
                                      <div class="">index
                                        4e7d9cb09a69..79b4c9b84cd0
                                        100644</div>
                                      <div class="">---
                                        a/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
                                      <div class="">+++
                                        b/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
                                      <div class="">@@ -697,12 +697,15
                                        @@ void kgd2kfd_suspend(struct
                                        kfd_dev *kfd, bool run_pm, bool
                                        force)</div>
                                      <div class="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                        return;</div>
                                      <div class=""><br class="">
                                      </div>
                                      <div class="">&nbsp; &nbsp; &nbsp; &nbsp; /* for
                                        runtime suspend, skip locking
                                        kfd */</div>
                                      <div class="">- &nbsp; &nbsp; &nbsp; if (!run_pm)
                                        {</div>
                                      <div class="">+ &nbsp; &nbsp; &nbsp; if (!run_pm
                                        &amp;&amp;
                                        !drm_dev_is_unplugged(kfd-&gt;ddev))
                                        {</div>
                                      <div class="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /*
                                        For first KFD device suspend all
                                        the KFD processes */</div>
                                      <div class="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if
                                        (atomic_inc_return(&amp;kfd_locked)
                                        == 1)</div>
                                      <div class="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                        &nbsp; &nbsp;
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
                                        55c9e1922714..84cbcd857856
                                        100644</div>
                                      <div class="">---
                                        a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h</div>
                                      <div class="">+++
                                        b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h</div>
                                      <div class="">@@ -1065,6 +1065,7
                                        @@ void kfd_unref_process(struct
                                        kfd_process *p);</div>
                                      <div class="">&nbsp;int
                                        kfd_process_evict_queues(struct
                                        kfd_process *p, bool force);</div>
                                      <div class="">&nbsp;int
                                        kfd_process_restore_queues(struct
                                        kfd_process *p);</div>
                                      <div class="">&nbsp;void
                                        kfd_suspend_all_processes(bool
                                        force);</div>
                                      <div class="">+void
                                        kfd_kill_all_user_processes(void);</div>
                                      <div class="">&nbsp;/*</div>
                                      <div class="">&nbsp; *
                                        kfd_resume_all_processes:</div>
                                      <div class="">&nbsp; * &nbsp; &nbsp; bool sync:
                                        If kfd_resume_all_processes()
                                        should wait for the</div>
                                      <div class="">diff --git
                                        a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
b/drivers/gpu/drm/amd/amdkfd/kfd_process.c</div>
                                      <div class="">index
                                        6cdc855abb6d..fb0c753b682c
                                        100644</div>
                                      <div class="">---
                                        a/drivers/gpu/drm/amd/amdkfd/kfd_process.c</div>
                                      <div class="">+++
                                        b/drivers/gpu/drm/amd/amdkfd/kfd_process.c</div>
                                      <div class="">@@ -2206,6 +2206,24
                                        @@ void
                                        kfd_suspend_all_processes(bool
                                        force)</div>
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
                                      <div class="">+ &nbsp; &nbsp; &nbsp; struct
                                        kfd_process *p;</div>
                                      <div class="">+ &nbsp; &nbsp; &nbsp; struct
                                        amdkfd_process_info *p_info;</div>
                                      <div class="">+ &nbsp; &nbsp; &nbsp; unsigned int
                                        temp;</div>
                                      <div class="">+ &nbsp; &nbsp; &nbsp; int idx =
                                        srcu_read_lock(&amp;kfd_processes_srcu);</div>
                                      <div class="">+</div>
                                      <div class="">+ &nbsp; &nbsp; &nbsp;
                                        pr_info(&quot;Killing all
                                        processes\n&quot;);</div>
                                      <div class="">+ &nbsp; &nbsp; &nbsp;
                                        hash_for_each_rcu(kfd_processes_table,
                                        temp, p, kfd_processes) {</div>
                                      <div class="">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                        p_info = p-&gt;kgd_process_info;</div>
                                      <div class="">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                        pr_info(&quot;Killing &nbsp;processes, pid
                                        = %d&quot;, pid_nr(p_info-&gt;pid));</div>
                                      <div class="">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                        kill_pid(p_info-&gt;pid, SIGBUS,
                                        1);</div>
                                    </blockquote>
                                    <p class=""><br class="">
                                    </p>
                                    <p class="">From looking into
                                      kill_pid I see it only sends a
                                      signal but doesn't wait for
                                      completion, it would make sense to
                                      wait for completion here. In any
                                      case I would actually try to put
                                      here<span style="caret-color:
                                        rgb(0, 0, 0); font-family:
                                        Helvetica; font-size: 12px;
                                        font-style: normal;
                                        font-variant-caps: normal;
                                        font-weight: 400;
                                        letter-spacing: normal;
                                        text-align: start; text-indent:
                                        0px; text-transform: none;
                                        white-space: normal;
                                        word-spacing: 0px;
                                        -webkit-text-stroke-width: 0px;
                                        text-decoration: none; float:
                                        none; display: inline
                                        !important;" class=""><br class="">
                                      </span></p>
                                  </div>
                                </div>
                              </blockquote>
                              I have made a version which does that with
                              some atomic counters. Please read later in
                              the diff.<br class="">
                              <blockquote type="cite" class="">
                                <div class="">
                                  <div class="">
                                    <p class=""><span style="caret-color: rgb(0, 0,
                                        0); font-family: Helvetica;
                                        font-size: 12px; font-style:
                                        normal; font-variant-caps:
                                        normal; font-weight: 400;
                                        letter-spacing: normal;
                                        text-align: start; text-indent:
                                        0px; text-transform: none;
                                        white-space: normal;
                                        word-spacing: 0px;
                                        -webkit-text-stroke-width: 0px;
                                        text-decoration: none; float:
                                        none; display: inline
                                        !important;" class=""></span><span style="caret-color: rgb(0, 0,
                                        0); font-family: Helvetica;
                                        font-size: 12px; font-style:
                                        normal; font-variant-caps:
                                        normal; font-weight: 400;
                                        letter-spacing: normal;
                                        text-align: start; text-indent:
                                        0px; text-transform: none;
                                        white-space: normal;
                                        word-spacing: 0px;
                                        -webkit-text-stroke-width: 0px;
                                        text-decoration: none; float:
                                        none; display: inline
                                        !important;" class=""><font class="" size="4"><br class="">
                                        </font></span></p>
                                    <p class=""><span style="caret-color: rgb(0, 0,
                                        0); font-family: Helvetica;
                                        font-size: 12px; font-style:
                                        normal; font-variant-caps:
                                        normal; font-weight: 400;
                                        letter-spacing: normal;
                                        text-align: start; text-indent:
                                        0px; text-transform: none;
                                        white-space: normal;
                                        word-spacing: 0px;
                                        -webkit-text-stroke-width: 0px;
                                        text-decoration: none; float:
                                        none; display: inline
                                        !important;" class=""><font class="" size="4">hash_for_each_rcu(</font></span><span style="caret-color: rgb(0, 0,
                                        0); font-family: Helvetica;
                                        font-size: 12px; font-style:
                                        normal; font-variant-caps:
                                        normal; font-weight: 400;
                                        letter-spacing: normal;
                                        text-align: start; text-indent:
                                        0px; text-transform: none;
                                        white-space: normal;
                                        word-spacing: 0px;
                                        -webkit-text-stroke-width: 0px;
                                        text-decoration: none; float:
                                        none; display: inline
                                        !important;" class=""><font class="" size="4">p_info) &nbsp;&nbsp; <br class="">
                                          &nbsp;&nbsp;&nbsp;
                                          cancel_delayed_work_sync(&amp;</font></span><span style="caret-color: rgb(0, 0,
                                        0); font-family: Helvetica;
                                        font-size: 12px; font-style:
                                        normal; font-variant-caps:
                                        normal; font-weight: 400;
                                        letter-spacing: normal;
                                        text-align: start; text-indent:
                                        0px; text-transform: none;
                                        white-space: normal;
                                        word-spacing: 0px;
                                        -webkit-text-stroke-width: 0px;
                                        text-decoration: none; float:
                                        none; display: inline
                                        !important;" class=""><font class="" size="4"><span style="caret-color: rgb(0,
                                            0, 0); font-family:
                                            Helvetica; font-size: 12px;
                                            font-style: normal;
                                            font-variant-caps: normal;
                                            font-weight: 400;
                                            letter-spacing: normal;
                                            text-align: start;
                                            text-indent: 0px;
                                            text-transform: none;
                                            white-space: normal;
                                            word-spacing: 0px;
                                            -webkit-text-stroke-width:
                                            0px; text-decoration: none;
                                            float: none; display: inline
                                            !important;" class=""></span><span style="caret-color: rgb(0,
                                            0, 0); font-family:
                                            Helvetica; font-size: 12px;
                                            font-style: normal;
                                            font-variant-caps: normal;
                                            font-weight: 400;
                                            letter-spacing: normal;
                                            text-align: start;
                                            text-indent: 0px;
                                            text-transform: none;
                                            white-space: normal;
                                            word-spacing: 0px;
                                            -webkit-text-stroke-width:
                                            0px; text-decoration: none;
                                            float: none; display: inline
                                            !important;" class=""><font class="" size="4">p_info</font></span>-&gt;restore_userptr_work)
                                          <br class="">
                                        </font></span></p>
                                    <p class=""><span style="caret-color: rgb(0, 0,
                                        0); font-family: Helvetica;
                                        font-size: 12px; font-style:
                                        normal; font-variant-caps:
                                        normal; font-weight: 400;
                                        letter-spacing: normal;
                                        text-align: start; text-indent:
                                        0px; text-transform: none;
                                        white-space: normal;
                                        word-spacing: 0px;
                                        -webkit-text-stroke-width: 0px;
                                        text-decoration: none; float:
                                        none; display: inline
                                        !important;" class=""><font class="" size="4">instead&nbsp; at
                                          least that what i meant in the
                                          previous mail.&nbsp;</font></span></p>
                                  </div>
                                </div>
                              </blockquote>
                              <div class="">I actually tried that
                                earlier, and it did not work.
                                Application still keeps running, and you
                                have to send a kill to the user process.</div>
                              <div class=""><br class="">
                              </div>
                              <div class="">I have made the following
                                version. It waits for processes to
                                terminate synchronously after sending
                                SIGBUS. After that it does the real work
                                of amdgpu_pci_remove.</div>
                              <div class="">However, it hangs at
                                amdgpu_device_ip_fini_early when it is
                                trying to deinit ip_block 6
                                &lt;sdma_v4_0&gt; (<a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux%2F-%2Fblob%2Famd-staging-drm-next%2Fdrivers%2Fgpu%2Fdrm%2Famd%2Famdgpu%2Famdgpu_device.c%23L2818&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Cbfb611b3f5984b73ad3708da213e781e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637858849473779872%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=Tn6rrnnrg%2BzkoLQUeN3WOjqDbgKD5Rotccd6AZs%2BQmI%3D&amp;reserved=0" originalsrc="https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L2818" shash="jR18MLHtemS6bRGVmO5015CqG3ON06xYu9Q2U1UtDuRz5orYg5SiignuxD2yBtBm5GzZs5Z7oNRxM2MRB6EhIA9tGJCIckEkJZ/Trc0yLMPZPEPQAsoFLqiAWljpIcx/6A3L6SN4rcO7+nqZLDC8e/AEwMSz2lnQNrXslt3WuRc=" class="" moz-do-not-send="true">https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-ne
 xt/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L2818</a>).
                                I assume that there are still some
                                inflight dma, therefore fini of this ip
                                block thus hangs?&nbsp;</div>
                              <div class=""><br class="">
                              </div>
                              <div class="">The following is an excerpt
                                of the dmesg: please excuse for putting
                                my own pr_info, but I hope you get my
                                point of where it hangs.</div>
                              <div class=""><br class="">
                              </div>
                              <div class="">
                                <div class="">[ &nbsp;392.344735] amdgpu: all
                                  processes has been fully released</div>
                                <div class="">[ &nbsp;392.346557] amdgpu:
                                  amdgpu_acpi_fini done</div>
                                <div class="">[ &nbsp;392.346568] amdgpu
                                  0000:b3:00.0: amdgpu: amdgpu:
                                  finishing device.</div>
                                <div class="">[ &nbsp;392.349238] amdgpu:
                                  amdgpu_device_ip_fini_early enter
                                  ip_blocks = 9</div>
                                <div class="">[ &nbsp;392.349248] amdgpu:
                                  Free mem_obj = 000000007bf54275,
                                  range_start = 14, range_end = 14</div>
                                <div class="">[ &nbsp;392.350299] amdgpu:
                                  Free mem_obj = 00000000a85bc878,
                                  range_start = 12, range_end = 12</div>
                                <div class="">[ &nbsp;392.350304] amdgpu:
                                  Free mem_obj = 00000000b8019e32,
                                  range_start = 13, range_end = 13</div>
                                <div class="">[ &nbsp;392.350308] amdgpu:
                                  Free mem_obj = 000000002d296168,
                                  range_start = 4, range_end = 11</div>
                                <div class="">[ &nbsp;392.350313] amdgpu:
                                  Free mem_obj = 000000001fc4f934,
                                  range_start = 0, range_end = 3</div>
                                <div class="">[ &nbsp;392.350322] amdgpu:
                                  amdgpu_amdkfd_suspend(adev, false)
                                  done</div>
                                <div class="">[ &nbsp;392.350672] amdgpu:
                                  hw_fini of IP block[8]
                                  &lt;jpeg_v2_5&gt; done 0</div>
                                <div class="">[ &nbsp;392.350679] amdgpu:
                                  hw_fini of IP block[7]
                                  &lt;vcn_v2_5&gt; done 0</div>
                              </div>
                            </div>
                          </blockquote>
                          <p class=""><br class="">
                          </p>
                          <p class="">I just remembered that the idea to
                            actively kill and wait for running user
                            processes during unplug was rejected<br class="">
                            as a bad idea in the first iteration of
                            unplug work I did (don't remember why now,
                            need to look) so this is a no go.<br class="">
                          </p>
                        </div>
                      </div>
                    </blockquote>
                    <div class="">Maybe an application has kfd open, but
                      was not accessing the dev. So kill it at unplug
                      could kill the process unnecessarily.</div>
                    <div class="">However, the latest version I had with
                      the sleep function got rid of the IP block fini
                      hang.</div>
                    <blockquote type="cite" class="">
                      <div class="">
                        <div class="">
                          <p class="">Our policy is to let zombie
                            processes (zombie in a sense that the
                            underlying device is gone) live as long as
                            they want
                            <br class="">
                            (as long as you able to terminate them -
                            which you do, so that ok)<br class="">
                            and the system should finish PCI remove
                            gracefully and be able to hot plug back the
                            device.&nbsp; Hence, i suggest dropping<br class="">
                            this direction of forcing all user processes
                            to be killed, confirm you have graceful
                            shutdown and remove of device<br class="">
                            from PCI topology and then concentrate on
                            why when you plug back it hangs. </p>
                        </div>
                      </div>
                    </blockquote>
                    So I basically revert back to the original solution
                    which you suggested.</div>
                  <div class=""><br class="">
                  </div>
                  <div class="">
                    <div class="">diff --git
                      a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
                      b/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
                    <div class="">index 4e7d9cb09a69..5504a18b5a45
                      100644</div>
                    <div class="">---
                      a/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
                    <div class="">+++
                      b/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
                    <div class="">@@ -697,7 +697,7 @@ void
                      kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm,
                      bool force)</div>
                    <div class="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return;</div>
                    <div class=""><br class="">
                    </div>
                    <div class="">&nbsp; &nbsp; &nbsp; &nbsp; /* for runtime suspend, skip
                      locking kfd */</div>
                    <div class="">- &nbsp; &nbsp; &nbsp; if (!run_pm) {</div>
                    <div class="">+ &nbsp; &nbsp; &nbsp; if (!run_pm &amp;&amp;
                      !drm_dev_is_unplugged(kfd-&gt;ddev)) {</div>
                    <div class="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* For first KFD
                      device suspend all the KFD processes */</div>
                    <div class="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if
                      (atomic_inc_return(&amp;kfd_locked) == 1)</div>
                    <div class="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                      kfd_suspend_all_processes(force);</div>
                  </div>
                  <div class=""><br class="">
                  </div>
                  <div class="">
                    <blockquote type="cite" class="">
                      <div class="">
                        <p class="">First confirm if ASIC reset happens
                          on<br class="">
                          next init. </p>
                      </div>
                    </blockquote>
                    <div class="">
                      <div class="">This patch works great at <b class="">planned</b> plugout, where all the
                        rocm processes are killed before plugout. And
                        device can be added back without a problem.</div>
                      <div class="">However <b class="">unplanned</b>
                        plugout when there is rocm processes are running
                        just don’t work.</div>
                    </div>
                  </div>
                </div>
              </blockquote>
              <p class=""><br class="">
              </p>
              <p class="">Still I am not clear if ASIC reset happens on
                plug back or no, can you trace this please ?</p>
              <div class=""><br class="">
              </div>
            </div>
          </div>
        </blockquote>
        <div><br class="">
        </div>
        I tried add pr_info into asic_reset functions, but cannot trace
        any upon plug-back.<br class="">
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>This could possibly explain the hang on plug back. Can you see
      why we don't get there ?<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:7825EEC6-BAF8-4B71-B01C-FE246D360779@microsoft.com">
      <div>
        <blockquote type="cite" class="">
          <div class="">
            <div class="">
              <p class=""><br class="">
              </p>
              <blockquote type="cite" cite="mid:76C16B06-0539-48EE-AB11-80089490CE3A@microsoft.com" class="">
                <div class="">
                  <div class="">
                    <blockquote type="cite" class="">
                      <div class="">
                        <p class="">Second please confirm if the timing
                          you kill manually the user process has impact
                          on whether you have a hang<br class="">
                          on next plug back (if you kill before </p>
                      </div>
                    </blockquote>
                    <b class="">Scenario 0: Kill before plug back</b></div>
                  <div class=""><br class="">
                  </div>
                  <div class="">
                    <div class="">1. echo 1 &gt; /sys/bus/pci/…/remove,
                      would finish.&nbsp;</div>
                    <div class="">But the application won’t exit until
                      there is a kill signal.</div>
                  </div>
                </div>
              </blockquote>
              <p class=""><br class="">
              </p>
              <p class="">Why you think it must exit ? <br class="">
              </p>
            </div>
          </div>
        </blockquote>
        Because rocm will need to release the drm descriptor to
        get&nbsp;amdgpu_amdkfd_device_fini_sw called, which would eventually
        call kgd2kfd_device_exit called. This would clean up
        kfd_topology at least. Otherwise I don’t see how it would be
        added back without messing up kfd topology to say the least.&nbsp;</div>
      <div><br class="">
      </div>
      <div>However, those are all based my own observations. Please
        explain why it does not need exit if you believe so?</div>
    </blockquote>
    <p><br>
    </p>
    <p>Note that when you add back a new device, pci device and drm
      device are created, I am not an expert on KFD code but i believe
      also a new KFD device is created independent of the old one and so
      the topology should see just 2 device instances (one old zombie
      and one real new).&nbsp; I know at least this wasn't an issue for the
      graphic stack in exact same scenario and the libdrm tests i
      pointed to test exact this scenario. Also note that even with
      running grpahic stack there is always a KFD device and KFD
      topology present but of course probably not the same as when u run
      a KFD facing process so there could be some issues there. <br>
    </p>
    <p>Also note that because of this patch
<a class="moz-txt-link-freetext" href="https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=267d51d77fdae8708b94e1a24b8e5d961297edb7">https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=267d51d77fdae8708b94e1a24b8e5d961297edb7</a>
      all MMIO accesses from such zombie/orphan user processes will be
      remapped to zero page and so will not necessarily experience a
      segfault when device removal happnes but rather maybe some crash
      due to NULL data read from MMIO by the process and used in some
      manner. <br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:7825EEC6-BAF8-4B71-B01C-FE246D360779@microsoft.com">
      <div>
        <blockquote type="cite" class="">
          <div class="">
            <div class="">
              <blockquote type="cite" cite="mid:76C16B06-0539-48EE-AB11-80089490CE3A@microsoft.com" class="">
                <div class="">
                  <div class="">
                    <div class=""><br class="">
                    </div>
                    <div class="">2. kill the the process. The
                      application does several things and seems trigger
                      drm_release in the kernel, which are met with
                      kernel NULL pointer deference related to
                      sysfs_remove. Then the whole fs just freeze.</div>
                    <div class=""><br class="">
                    </div>
                    <div class="">
                      <div class="">[ &nbsp;+0.002498] BUG: kernel NULL
                        pointer dereference, address: 0000000000000098</div>
                      <div class="">[ &nbsp;+0.000486] #PF: supervisor read
                        access in kernel mode</div>
                      <div class="">[ &nbsp;+0.000545] #PF:
                        error_code(0x0000) - not-present page</div>
                      <div class="">[ &nbsp;+0.000551] PGD 0 P4D 0</div>
                      <div class="">[ &nbsp;+0.000553] Oops: 0000 [#1] SMP
                        NOPTI</div>
                      <div class="">[ &nbsp;+0.000540] CPU: 75 PID: 4911
                        Comm: kworker/75:2 Tainted: G &nbsp; &nbsp; &nbsp; &nbsp;W &nbsp; E &nbsp; &nbsp;
                        5.13.0-kfd #1</div>
                      <div class="">[ &nbsp;+0.000559] Hardware name:
                        INGRASYS &nbsp; &nbsp; &nbsp; &nbsp; TURING &nbsp;/MB &nbsp; &nbsp; &nbsp;, BIOS
                        K71FQ28A 10/05/2021</div>
                      <div class="">[ &nbsp;+0.000567] Workqueue: events
                        delayed_fput</div>
                      <div class="">[ &nbsp;+0.000563] RIP:
                        0010:kernfs_find_ns+0x1b/0x100</div>
                      <div class="">[ &nbsp;+0.000569] Code: ff ff e8 88 59
                        9f 00 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41
                        57 8b 05 df f0 7b 01 41 56 41 55 49 89 f5 41 54
                        55 48 89 fd 53 &lt;44&gt; 0f b7 b7 98 00 00 00
                        48 89 d3 4c 8b 67 70 66 41 83 e6 20 41 0f</div>
                      <div class="">[ &nbsp;+0.001193] RSP:
                        0018:ffffb9875db5fc98 EFLAGS: 00010246</div>
                      <div class="">[ &nbsp;+0.000602] RAX: 0000000000000000
                        RBX: ffffa101f79507d8 RCX: 0000000000000000</div>
                      <div class="">[ &nbsp;+0.000612] RDX: 0000000000000000
                        RSI: ffffffffc09a9417 RDI: 0000000000000000</div>
                      <div class="">[ &nbsp;+0.000604] RBP: 0000000000000000
                        R08: 0000000000000001 R09: 0000000000000000</div>
                      <div class="">[ &nbsp;+0.000760] R10: ffffb9875db5fcd0
                        R11: 0000000000000000 R12: 0000000000000000</div>
                      <div class="">[ &nbsp;+0.000597] R13: ffffffffc09a9417
                        R14: ffffa08363fb2d18 R15: 0000000000000000</div>
                      <div class="">[ &nbsp;+0.000702] FS:
                        &nbsp;0000000000000000(0000)
                        GS:ffffa0ffbfcc0000(0000) knlGS:0000000000000000</div>
                      <div class="">[ &nbsp;+0.000666] CS: &nbsp;0010 DS: 0000 ES:
                        0000 CR0: 0000000080050033</div>
                      <div class="">[ &nbsp;+0.000658] CR2: 0000000000000098
                        CR3: 0000005747812005 CR4: 0000000000770ee0</div>
                      <div class="">[ &nbsp;+0.000715] DR0: 0000000000000000
                        DR1: 0000000000000000 DR2: 0000000000000000</div>
                      <div class="">[ &nbsp;+0.000655] DR3: 0000000000000000
                        DR6: 00000000fffe0ff0 DR7: 0000000000000400</div>
                      <div class="">[ &nbsp;+0.000592] PKRU: 55555554</div>
                      <div class="">[ &nbsp;+0.000580] Call Trace:</div>
                      <div class="">[ &nbsp;+0.000591]
                        &nbsp;kernfs_find_and_get_ns+0x2f/0x50</div>
                      <div class="">[ &nbsp;+0.000584]
                        &nbsp;sysfs_remove_file_from_group+0x20/0x50</div>
                      <div class="">[ &nbsp;+0.000580]
                        &nbsp;amdgpu_ras_sysfs_remove+0x3d/0xd0 [amdgpu]</div>
                      <div class="">[ &nbsp;+0.000737]
                        &nbsp;amdgpu_ras_late_fini+0x1d/0x40 [amdgpu]</div>
                      <div class="">[ &nbsp;+0.000750]
                        &nbsp;amdgpu_sdma_ras_fini+0x96/0xb0 [amdgpu]</div>
                      <div class="">[ &nbsp;+0.000742] &nbsp;?
                        gfx_v10_0_resume+0x10/0x10 [amdgpu]</div>
                      <div class="">[ &nbsp;+0.000738]
                        &nbsp;sdma_v4_0_sw_fini+0x23/0x90 [amdgpu]</div>
                      <div class="">[ &nbsp;+0.000717]
                        &nbsp;amdgpu_device_fini_sw+0xae/0x260 [amdgpu]</div>
                      <div class="">[ &nbsp;+0.000704]
                        &nbsp;amdgpu_driver_release_kms+0x12/0x30 [amdgpu]</div>
                      <div class="">[ &nbsp;+0.000687]
                        &nbsp;drm_dev_release+0x20/0x40 [drm]</div>
                      <div class="">[ &nbsp;+0.000583] &nbsp;drm_release+0xa8/0xf0
                        [drm]</div>
                      <div class="">[ &nbsp;+0.000584] &nbsp;__fput+0xa5/0x250</div>
                      <div class="">[ &nbsp;+0.000621]
                        &nbsp;delayed_fput+0x1f/0x30</div>
                      <div class="">[ &nbsp;+0.000726]
                        &nbsp;process_one_work+0x26e/0x580</div>
                      <div class="">[ &nbsp;+0.000581] &nbsp;?
                        process_one_work+0x580/0x580</div>
                      <div class="">[ &nbsp;+0.000611]
                        &nbsp;worker_thread+0x4d/0x3d0</div>
                      <div class="">[ &nbsp;+0.000611] &nbsp;?
                        process_one_work+0x580/0x580</div>
                      <div class="">[ &nbsp;+0.000605] &nbsp;kthread+0x117/0x150</div>
                      <div class="">[ &nbsp;+0.000611] &nbsp;?
                        kthread_park+0x90/0x90</div>
                      <div class="">[ &nbsp;+0.000619]
                        &nbsp;ret_from_fork+0x1f/0x30</div>
                      <div class="">[ &nbsp;+0.000625] Modules linked in:
                        amdgpu(E) xt_conntrack xt_MASQUERADE nfnetlink
                        xt_addrtype iptable_filter iptable_nat nf_nat
                        nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
                        br_netfilter x86_pkg_temp_thermal cdc_ether
                        usbnet acpi_pad msr ip_tables x_tables ast
                        drm_vram_helper iommu_v2 drm_ttm_helper
                        gpu_sched ttm drm_kms_helper cfbfillrect
                        syscopyarea cfbimgblt sysfillrect sysimgblt
                        fb_sys_fops cfbcopyarea drm drm_panel_orientati</div>
                      <div class="">on_quirks [last unloaded: amdgpu]</div>
                    </div>
                  </div>
                </div>
              </blockquote>
              <p class=""><br class="">
              </p>
              <p class="">This is a known regression, all SYSFS
                components must be removed before pci_remove code runs
                otherwise you get either warnings for single file
                removals or<br class="">
                OOPSEs for sysfs gorup removals like here. Please try to
                move amdgpu_ras_sysfs_remove from amdgpu_ras_late_fini
                to the end of amdgpu_ras_pre_fini (which happens before
                pci remove)</p>
              <div class=""><br class="">
              </div>
            </div>
          </div>
        </blockquote>
        <div><br class="">
        </div>
        I fixed it in the newer patch, please see it below.</div>
    </blockquote>
    <p><br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:7825EEC6-BAF8-4B71-B01C-FE246D360779@microsoft.com">
      <div>I first plugout the device, then kill the rocm user process.
        Then it has other OOPSES related to ttm_bo_cleanup_refs.</div>
      <div><br class="">
      </div>
      <div>[ &nbsp;+0.000006] BUG: kernel NULL pointer dereference, address:
        0000000000000010<br class="">
        [ &nbsp;+0.000349] #PF: supervisor read access in kernel mode<br class="">
        [ &nbsp;+0.000340] #PF: error_code(0x0000) - not-present page<br class="">
        [ &nbsp;+0.000341] PGD 0 P4D 0<br class="">
        [ &nbsp;+0.000336] Oops: 0000 [#1] SMP NOPTI<br class="">
        [ &nbsp;+0.000345] CPU: 9 PID: 95 Comm: kworker/9:1 Tainted: G &nbsp; &nbsp; &nbsp;
        &nbsp;W &nbsp; E &nbsp; &nbsp; 5.13.0-kfd #1<br class="">
        [ &nbsp;+0.000367] Hardware name: INGRASYS &nbsp; &nbsp; &nbsp; &nbsp; TURING &nbsp;/MB &nbsp; &nbsp; &nbsp;,
        BIOS K71FQ28A 10/05/2021<br class="">
        [ &nbsp;+0.000376] Workqueue: events delayed_fput<br class="">
        [ &nbsp;+0.000422] RIP: 0010:ttm_resource_free+0x24/0x40 [ttm]<br class="">
        [ &nbsp;+0.000464] Code: 00 00 0f 1f 40 00 0f 1f 44 00 00 53 48 89 f3
        48 8b 36 48 85 f6 74 21 48 8b 87 28 02 00 00 48 63 56 10 48 8b
        bc d0 b8 00 00 00 &lt;48&gt; 8b 47 10 ff 50 08 48 c7 03 00 00 00
        00 5b c3 66 66 2e 0f 1f 84<br class="">
        [ &nbsp;+0.001009] RSP: 0018:ffffb21c59413c98 EFLAGS: 00010282<br class="">
        [ &nbsp;+0.000515] RAX: ffff8b1aa4285f68 RBX: ffff8b1a823b5ea0 RCX:
        00000000002a000c<br class="">
        [ &nbsp;+0.000536] RDX: 0000000000000000 RSI: ffff8b1acb84db80 RDI:
        0000000000000000<br class="">
        [ &nbsp;+0.000539] RBP: 0000000000000001 R08: 0000000000000000 R09:
        ffffffffc03c3e00<br class="">
        [ &nbsp;+0.000543] R10: 0000000000000000 R11: 0000000000000000 R12:
        ffff8b1a823b5ec8<br class="">
        [ &nbsp;+0.000542] R13: 0000000000000000 R14: ffff8b1a823b5d90 R15:
        ffff8b1a823b5ec8<br class="">
        [ &nbsp;+0.000544] FS: &nbsp;0000000000000000(0000)
        GS:ffff8b187f440000(0000) knlGS:0000000000000000<br class="">
        [ &nbsp;+0.000559] CS: &nbsp;0010 DS: 0000 ES: 0000 CR0: 0000000080050033<br class="">
        [ &nbsp;+0.000575] CR2: 0000000000000010 CR3: 00000076e6812004 CR4:
        0000000000770ee0<br class="">
        [ &nbsp;+0.000575] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
        0000000000000000<br class="">
        [ &nbsp;+0.000579] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
        0000000000000400<br class="">
        [ &nbsp;+0.000575] PKRU: 55555554<br class="">
        [ &nbsp;+0.000568] Call Trace:<br class="">
        [ &nbsp;+0.000567] &nbsp;ttm_bo_cleanup_refs+0xe4/0x290 [ttm]<br class="">
        [ &nbsp;+0.000588] &nbsp;ttm_bo_delayed_delete+0x147/0x250 [ttm]<br class="">
        [ &nbsp;+0.000589] &nbsp;ttm_device_fini+0xad/0x1b0 [ttm]<br class="">
        [ &nbsp;+0.000590] &nbsp;amdgpu_ttm_fini+0x2a7/0x310 [amdgpu]<br class="">
        [ &nbsp;+0.000730] &nbsp;gmc_v9_0_sw_fini+0x3a/0x40 [amdgpu]<br class="">
        [ &nbsp;+0.000753] &nbsp;amdgpu_device_fini_sw+0xae/0x260 [amdgpu]<br class="">
        [ &nbsp;+0.000734] &nbsp;amdgpu_driver_release_kms+0x12/0x30 [amdgpu]<br class="">
        [ &nbsp;+0.000737] &nbsp;drm_dev_release+0x20/0x40 [drm]<br class="">
        [ &nbsp;+0.000626] &nbsp;drm_release+0xa8/0xf0 [drm]<br class="">
        [ &nbsp;+0.000625] &nbsp;__fput+0xa5/0x250<br class="">
        [ &nbsp;+0.000606] &nbsp;delayed_fput+0x1f/0x30<br class="">
        [ &nbsp;+0.000607] &nbsp;process_one_work+0x26e/0x580<br class="">
        [ &nbsp;+0.000608] &nbsp;? process_one_work+0x580/0x580<br class="">
        [ &nbsp;+0.000616] &nbsp;worker_thread+0x4d/0x3d0<br class="">
        [ &nbsp;+0.000614] &nbsp;? process_one_work+0x580/0x580<br class="">
        [ &nbsp;+0.000617] &nbsp;kthread+0x117/0x150<br class="">
        [ &nbsp;+0.000615] &nbsp;? kthread_park+0x90/0x90<br class="">
        [ &nbsp;+0.000621] &nbsp;ret_from_fork+0x1f/0x30<br class="">
        [ &nbsp;+0.000603] Modules linked in: amdgpu(E) xt_conntrack
        xt_MASQUERADE nfnetlink xt_addrtype iptable_filter iptable_nat
        nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter
        x86_pkg_temp_thermal cdc_ether usbnet acpi_pad msr ip_tables
        x_tables ast drm_vram_helper drm_ttm_helper iommu_v2 ttm
        gpu_sched drm_kms_helper cfbfillrect syscopyarea cfbimgblt
        sysfillrect sysimgblt fb_sys_fops cfbcopyarea drm
        drm_panel_orientation_quirks [last unloaded: amdgpu]<br class="">
        [ &nbsp;+0.002840] CR2: 0000000000000010<br class="">
        <div class="">
          <div><font class="" color="#000000"><span style="caret-color:
                rgb(0, 0, 0);" class="">[ &nbsp;+0.000755] ---[ end trace
                9737737402551e39 ]--</span></font></div>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>This looks like another regression - try seeing where is the NULL
      reference and then we can see how to avoid this. <br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:7825EEC6-BAF8-4B71-B01C-FE246D360779@microsoft.com">
      <div>
        <div class="">
        </div>
        <br class="">
        <blockquote type="cite" class="">
          <div class="">
            <div class="">
              <blockquote type="cite" cite="mid:76C16B06-0539-48EE-AB11-80089490CE3A@microsoft.com" class="">
                <div class="">
                  <div class="">
                    <div class="">
                      <div class=""><br class="">
                      </div>
                      <div class="">3. &nbsp;echo 1 &gt; /sys/bus/pci/rescan.
                        This would just hang. I assume the sysfs is
                        broken.</div>
                      <div class=""><br class="">
                      </div>
                      <div class="">Based on 1 &amp; 2, it seems that 1
                        won’t let the amdgpu exit gracefully, because 2
                        will do some cleanup maybe should have happened
                        before 1.</div>
                      <div class="">
                        <blockquote type="cite" class="">
                          <div class="">
                            <p class="">or you kill after plug back does
                              it makes a difference).&nbsp;<br class="">
                            </p>
                          </div>
                        </blockquote>
                      </div>
                      <div class=""><b class="">Scenario 2: Kill after
                          plug back</b></div>
                      <div class=""><br class="">
                      </div>
                      <div class="">If I perform rescan before kill,
                        then the driver seemed probed fine. But kill
                        will have the same issue which messed up the
                        sysfs the same way as in Scenario 2.</div>
                      <div class=""><br class="">
                      </div>
                      <div class=""><br class="">
                      </div>
                      <div class=""><b class="">Final Comments:</b></div>
                      <div class=""><br class="">
                      </div>
                      <span class="">0.&nbsp;cancel_delayed_work_sync(&amp;p_info-&gt;restore_userptr_work)
                        would&nbsp;make the&nbsp;repletion of
                      </span>amdgpu_vm_bo_update failure go away, but it
                      does not solve the issues in those scenarios.</div>
                  </div>
                </div>
              </blockquote>
              <p class=""><br class="">
              </p>
              <p class="">Still - it's better to do it this way even for
                those failures to go awaya</p>
              <div class=""><br class="">
              </div>
            </div>
          </div>
        </blockquote>
        Cancel_delayed_work is insufficient, you will need to make sure
        the work won’t be processed after plugout. Please see my patch<br class="">
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>Saw, see my comment.</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:7825EEC6-BAF8-4B71-B01C-FE246D360779@microsoft.com">
      <div>
        <blockquote type="cite" class="">
          <div class="">
            <div class="">
              <p class=""><br class="">
              </p>
              <blockquote type="cite" cite="mid:76C16B06-0539-48EE-AB11-80089490CE3A@microsoft.com" class="">
                <div class="">
                  <div class="">
                    <div class=""><span class=""><br class="">
                      </span>
                      <div class="">1. For planned hotplug, this patch
                        should work as long as you follow some protocol,
                        i.e. kill before plugout. Is this patch an
                        acceptable one since it provides some added
                        feature than before?</div>
                    </div>
                  </div>
                </div>
              </blockquote>
              <p class=""><br class="">
              </p>
              <p class="">Let's try to fix more as I advised above. <br class="">
              </p>
              <p class=""><br class="">
              </p>
              <blockquote type="cite" cite="mid:76C16B06-0539-48EE-AB11-80089490CE3A@microsoft.com" class="">
                <div class="">
                  <div class="">
                    <div class="">
                      <div class=""><br class="">
                      </div>
                      <div class="">2. For unplanned hotplug when there
                        is rocm app running, the patch that kill all
                        processes and wait for 5 sec would work
                        consistently. But it seems that it is an
                        unacceptable solution for official release. I
                        can hold it for our own internal usage. &nbsp;It
                        seems that kill after removal would cause
                        problems, and I don’t know if there is a quick
                        fix by me because of my limited understanding of
                        the amdgpu driver. Maybe AMD could have a quick
                        fix; Or it is really a difficult one. This
                        feature may or may not be a blocking issue in
                        our GPU disaggregation research down the way.
                        Please let us know for either cases, and we
                        would like to learn and help as much as we
                        could!</div>
                    </div>
                  </div>
                </div>
              </blockquote>
              <p class=""><br class="">
              </p>
              <p class="">I am currently not sure why it helps. I will
                need to setup my own ROCm setup and retest hot plug to
                check this in more depth but currently i have higher
                priorities. Please try to confirm ASIC reset always
                takes place on plug back<br class="">
                and fix the sysfs OOPs as I advised above to clear up at
                least some of the issues. Also please describe to me
                exactly what you steps to reproduce this scenario so
                later I might be able to do it myself.</p>
              <div class=""><br class="">
              </div>
            </div>
          </div>
        </blockquote>
        <div>I can still try to help to fix the bug in my spare time. My
          setup is as follows</div>
        <div><br class="">
        </div>
        <div>
          <ol class="">
            <li class="">I have a server with 4 AMD MI100 GPUs. I think
              1 GPU would also work.</li>
            <li class="">I used the&nbsp;<a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Ftree%2Froc-5.0.x&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Cbfb611b3f5984b73ad3708da213e781e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637858849473779872%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=fJZBoJHu%2FwD8Ge1whM1VUERBNlCAyrnUGU78RLDp5yg%3D&amp;reserved=0" originalsrc="https://github.com/RadeonOpenCompute/ROCK-Kernel-Driver/tree/roc-5.0.x" shash="ccG93SzPZgwMLo5Cyz/zbCVX6etq/35rRCtO25tGikE0ErgwJBfvsIpOZaMvER1knxbiKUmEXMnJySulvFYul8dldn3spwG9mnu1JSd3D0BztSwb/C5tq1xGV5ueexu4VoI7xu5L4k7nYa8CpCES8N1W8tiGcSkS4GbVR+UgYqU=" class="" moz-do-not-send="true">https://github.com/RadeonOpenCompute/ROCK-Kernel-Driver/tree/roc-5.0.x</a>&nbsp;as
              the starting point, and apply Mukul’s patch and my patch.</li>
            <li class="">Then I run a tensorflow benchmark from a
              docker.</li>
            <ul class="">
              <li class="">docker run -it --device=/dev/kfd
                --device=/dev/dri --group-add video
                rocm/tensorflow:rocm4.5.2-tf1.15-dev</li>
              <li class="">And run the following benchmark in the
                docker: &nbsp;python
                benchmarks/scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py
                --num_gpus=4 --batch_size=32 --model=resnet50
                --variable_update=parameter_server</li>
              <ul class="">
                <li class="">Might to need to adjust num_gpus parameter
                  based on your setup</li>
              </ul>
            </ul>
            <li class="">Remove a GPU at random time.</li>
            <li class="">Do whatever is needed to before plugback and
              reverify the benchmark can still run.</li>
          </ol>
        </div>
        <blockquote type="cite" class="">
          <div class="">
            <div class="">
              <p class="">Also, we have hotplug test suite in libdrm
                (graphic stack), so maybe u can install libdrm and run
                that test suite to see if it exposes more issues.<br class="">
              </p>
            </div>
          </div>
        </blockquote>
        OK I could try it some time.</div>
      <div><br class="">
      </div>
      <div>The following is the new diff.</div>
      <div><br class="">
      </div>
      <div>
        <div>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
          b/drivers/gpu/drm/amd/amdgpu/amdgpu.h</div>
        <div>index 182b7eae598a..48c3cd4054de 100644</div>
        <div>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h</div>
        <div>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h</div>
        <div>@@ -1327,7 +1327,7 @@ int emu_soc_asic_init(struct
          amdgpu_device *adev);</div>
        <div>&nbsp; * ASICs macro.</div>
        <div>&nbsp; */</div>
        <div>&nbsp;#define amdgpu_asic_set_vga_state(adev, state)
          (adev)-&gt;asic_funcs-&gt;set_vga_state((adev), (state))</div>
        <div>-#define amdgpu_asic_reset(adev)
          (adev)-&gt;asic_funcs-&gt;reset((adev))</div>
        <div>+#define amdgpu_asic_reset(adev) ({int r;
          pr_info(&quot;performing amdgpu_asic_reset\n&quot;); r =
          (adev)-&gt;asic_funcs-&gt;reset((adev));r;})</div>
        <div>&nbsp;#define amdgpu_asic_reset_method(adev)
          (adev)-&gt;asic_funcs-&gt;reset_method((adev))</div>
        <div>&nbsp;#define amdgpu_asic_get_xclk(adev)
          (adev)-&gt;asic_funcs-&gt;get_xclk((adev))</div>
        <div>&nbsp;#define amdgpu_asic_set_uvd_clocks(adev, v, d)
          (adev)-&gt;asic_funcs-&gt;set_uvd_clocks((adev), (v), (d))</div>
        <div>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h</div>
        <div>index 27c74fcec455..842abd7150a6 100644</div>
        <div>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h</div>
        <div>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h</div>
        <div>@@ -134,6 +134,7 @@ struct amdkfd_process_info {</div>
        <div>&nbsp;</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>/*
          MMU-notifier related fields */</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>atomic_t
          evicted_bos;</div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>atomic_t
          invalid;</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>struct
          delayed_work restore_userptr_work;</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>struct
          pid *pid;</div>
        <div>&nbsp;};</div>
        <div>diff --git
          a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c</div>
        <div>index 99d2b15bcbf3..2a588eb9f456 100644</div>
        <div>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c</div>
        <div>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c</div>
        <div>@@ -1325,6 +1325,7 @@ static int init_kfd_vm(struct
          amdgpu_vm *vm, void **process_info,</div>
        <div>&nbsp;</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>info-&gt;pid
          = get_task_pid(current-&gt;group_leader, PIDTYPE_PID);</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>atomic_set(&amp;info-&gt;evicted_bos,
          0);</div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>atomic_set(&amp;info-&gt;invalid,
          0);</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>INIT_DELAYED_WORK(&amp;info-&gt;restore_userptr_work,</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>&nbsp;amdgpu_amdkfd_restore_userptr_worker);</div>
        <div>&nbsp;</div>
        <div>@@ -2693,6 +2694,9 @@ static void
          amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>struct
          mm_struct *mm;</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>int
          evicted_bos;</div>
        <div>&nbsp;</div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>if
          (atomic_read(&amp;process_info-&gt;invalid))</div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>return;</div>
        <div>+</div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>Probably better&nbsp; to again use drm_dev_enter/exit guard pair
      instead of this flag.</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:7825EEC6-BAF8-4B71-B01C-FE246D360779@microsoft.com">
      <div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>evicted_bos
          = atomic_read(&amp;process_info-&gt;evicted_bos);</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>if
          (!evicted_bos)</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>return;</div>
        <div>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c</div>
        <div>index ec38517ab33f..e7d85d8d282d 100644</div>
        <div>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c</div>
        <div>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c</div>
        <div>@@ -1054,6 +1054,7 @@ void
          amdgpu_device_program_register_sequence(struct amdgpu_device
          *adev,</div>
        <div>&nbsp; */</div>
        <div>&nbsp;void amdgpu_device_pci_config_reset(struct amdgpu_device
          *adev)</div>
        <div>&nbsp;{</div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>pr_debug(&quot;%s
          called\n&quot;,__func__);</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>pci_write_config_dword(adev-&gt;pdev,
          0x7c, AMDGPU_ASIC_RESET_DATA);</div>
        <div>&nbsp;}</div>
        <div>&nbsp;</div>
        <div>@@ -1066,6 +1067,7 @@ void
          amdgpu_device_pci_config_reset(struct amdgpu_device *adev)</div>
        <div>&nbsp; */</div>
        <div>&nbsp;int amdgpu_device_pci_reset(struct amdgpu_device *adev)</div>
        <div>&nbsp;{</div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>pr_debug(&quot;%s
          called\n&quot;,__func__);</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>return
          pci_reset_function(adev-&gt;pdev);</div>
        <div>&nbsp;}</div>
        <div>&nbsp;</div>
        <div>@@ -4702,6 +4704,8 @@ int amdgpu_do_asic_reset(struct
          list_head *device_list_handle,</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>bool
          need_full_reset, skip_hw_reset, vram_lost = false;</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>int
          r = 0;</div>
        <div>&nbsp;</div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>pr_debug(&quot;%s
          called\n&quot;,__func__);</div>
        <div>+</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>/*
          Try reset handler method first */</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>tmp_adev
          = list_first_entry(device_list_handle, struct amdgpu_device,</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>&nbsp;
          &nbsp;reset_list);</div>
        <div>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</div>
        <div>index 49bdf9ff7350..b469acb65c1e 100644</div>
        <div>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</div>
        <div>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</div>
        <div>@@ -2518,7 +2518,6 @@ void amdgpu_ras_late_fini(struct
          amdgpu_device *adev,</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>if
          (!ras_block || !ih_info)</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>return;</div>
        <div>&nbsp;</div>
        <div>-<span class="Apple-tab-span" style="white-space:pre"> </span>amdgpu_ras_sysfs_remove(adev,
          ras_block);</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>if
          (ih_info-&gt;cb)</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>amdgpu_ras_interrupt_remove_handler(adev,
          ih_info);</div>
        <div>&nbsp;}</div>
        <div>@@ -2577,6 +2576,7 @@ void amdgpu_ras_suspend(struct
          amdgpu_device *adev)</div>
        <div>&nbsp;int amdgpu_ras_pre_fini(struct amdgpu_device *adev)</div>
        <div>&nbsp;{</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>struct
          amdgpu_ras *con = amdgpu_ras_get_context(adev);</div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>struct
          ras_manager *obj, *tmp;</div>
        <div>&nbsp;</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>if
          (!adev-&gt;ras_enabled || !con)</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>return
          0;</div>
        <div>@@ -2585,6 +2585,13 @@ int amdgpu_ras_pre_fini(struct
          amdgpu_device *adev)</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>/*
          Need disable ras on all IPs here before ip [hw/sw]fini */</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>amdgpu_ras_disable_all_features(adev,
          0);</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>amdgpu_ras_recovery_fini(adev);</div>
        <div>+</div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>/*
          remove sysfs before pci_remove to avoid OOPSES from
          sysfs_remove_groups */</div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>list_for_each_entry_safe(obj,
          tmp, &amp;con-&gt;head, node) {</div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>amdgpu_ras_sysfs_remove(adev,
          &amp;obj-&gt;head);</div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>put_obj(obj);</div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>}</div>
        <div>+</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>return
          0;</div>
        <div>&nbsp;}</div>
        <div>&nbsp;</div>
        <div>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
          b/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
        <div>index 4e7d9cb09a69..0fa806a78e39 100644</div>
        <div>--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
        <div>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
        <div>@@ -693,16 +693,35 @@ bool kfd_is_locked(void)</div>
        <div>&nbsp;</div>
        <div>&nbsp;void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm,
          bool force)</div>
        <div>&nbsp;{</div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>struct
          kfd_process *p;</div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>struct
          amdkfd_process_info *p_info;</div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>unsigned
          int temp;</div>
        <div>+</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>if
          (!kfd-&gt;init_complete)</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>return;</div>
        <div>&nbsp;</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>/*
          for runtime suspend, skip locking kfd */</div>
        <div>-<span class="Apple-tab-span" style="white-space:pre"> </span>if
          (!run_pm) {</div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>if
          (!run_pm &amp;&amp; !drm_dev_is_unplugged(kfd-&gt;ddev)) {</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>/*
          For first KFD device suspend all the KFD processes */</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>if
          (atomic_inc_return(&amp;kfd_locked) == 1)</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>kfd_suspend_all_processes(force);</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>}</div>
        <div>&nbsp;</div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>if
          (drm_dev_is_unplugged(kfd-&gt;ddev)){</div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>int
          idx = srcu_read_lock(&amp;kfd_processes_srcu);</div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>pr_debug(&quot;cancel
          restore_userptr_wor\n&quot;);</div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>hash_for_each_rcu(kfd_processes_table,
          temp, p, kfd_processes) {</div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>if
          ( kfd_process_gpuidx_from_gpuid(p, kfd-&gt;id) &gt;= 0 ) {</div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>p_info
          = p-&gt;kgd_process_info;</div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>pr_debug(&quot;cancel
          processes, pid = %d for gpu_id = %d&quot;, pid_nr(p_info-&gt;pid),
          kfd-&gt;id);</div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>cancel_delayed_work_sync(&amp;p_info-&gt;restore_userptr_work);</div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>/*
          block all future restore_userptr_work */</div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>atomic_inc(&amp;p_info-&gt;invalid);</div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>Same as i mentioned above with drm.dev_eneter/exit</p>
    <p>Andrey</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:7825EEC6-BAF8-4B71-B01C-FE246D360779@microsoft.com">
      <div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>}</div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>}</div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>srcu_read_unlock(&amp;kfd_processes_srcu,
          idx);</div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>}</div>
        <div>+</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>kfd-&gt;dqm-&gt;ops.stop(kfd-&gt;dqm);</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>kfd_iommu_suspend(kfd);</div>
        <div>&nbsp;}</div>
        <div>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
          b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c</div>
        <div>index 600ba2a728ea..7e3d1848eccc 100644</div>
        <div>--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c</div>
        <div>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c</div>
        <div>@@ -669,11 +669,12 @@ static void
          kfd_remove_sysfs_node_entry(struct kfd_topology_device *dev)</div>
        <div>&nbsp;#ifdef HAVE_AMD_IOMMU_PC_SUPPORTED</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>if
          (dev-&gt;kobj_perf) {</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>list_for_each_entry(perf,
          &amp;dev-&gt;perf_props, list) {</div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>sysfs_remove_group(dev-&gt;kobj_perf,
          perf-&gt;attr_group);</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>kfree(perf-&gt;attr_group);</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>perf-&gt;attr_group
          = NULL;</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>}</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>kobject_del(dev-&gt;kobj_perf);</div>
        <div>-<span class="Apple-tab-span" style="white-space:pre"> </span>kobject_put(dev-&gt;kobj_perf);</div>
        <div>+<span class="Apple-tab-span" style="white-space:pre"> </span>/*
          kobject_put(dev-&gt;kobj_perf); */</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>dev-&gt;kobj_perf
          = NULL;</div>
        <div>&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>}</div>
        <div>&nbsp;#endif</div>
        <div class=""><br class="">
        </div>
        <div class="">Thank you so much! Looking forward to your
          comments!</div>
        <div class=""><br class="">
        </div>
        <div class="">Regards,</div>
        <div class="">Shuotao</div>
        <blockquote type="cite" class="">
          <div class="">
            <div class="">
              <p class="">Andrey</p>
              <p class=""><br class="">
              </p>
              <blockquote type="cite" cite="mid:76C16B06-0539-48EE-AB11-80089490CE3A@microsoft.com" class="">
                <div class="">
                  <div class="">
                    <div class="">
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
                              <div class="">index
                                8fa9b86ac9d2..c0b27f722281 100644</div>
                              <div class="">---
                                a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c</div>
                              <div class="">+++
                                b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c</div>
                              <div class="">@@ -188,6 +188,12 @@ void
                                amdgpu_amdkfd_interrupt(struct
                                amdgpu_device *adev,</div>
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
                              <div class="">&nbsp;void
                                amdgpu_amdkfd_suspend(struct
                                amdgpu_device *adev, bool run_pm)</div>
                              <div class="">&nbsp;{</div>
                              <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>if
                                (adev-&gt;kfd.dev)</div>
                              <div class="">diff --git
                                a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h</div>
                              <div class="">index
                                27c74fcec455..f4e485d60442 100644</div>
                              <div class="">---
                                a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h</div>
                              <div class="">+++
                                b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h</div>
                              <div class="">@@ -141,6 +141,7 @@ struct
                                amdkfd_process_info {</div>
                              <div class="">&nbsp;int
                                amdgpu_amdkfd_init(void);</div>
                              <div class="">&nbsp;void
                                amdgpu_amdkfd_fini(void);</div>
                              <div class="">&nbsp;</div>
                              <div class="">+void
                                amdgpu_amdkfd_kill_all_processes(struct
                                amdgpu_device *adev);</div>
                              <div class="">&nbsp;void
                                amdgpu_amdkfd_suspend(struct
                                amdgpu_device *adev, bool run_pm);</div>
                              <div class="">&nbsp;int
                                amdgpu_amdkfd_resume_iommu(struct
                                amdgpu_device *adev);</div>
                              <div class="">&nbsp;int
                                amdgpu_amdkfd_resume(struct
                                amdgpu_device *adev, bool run_pm, bool
                                sync);</div>
                              <div class="">@@ -405,6 +406,7 @@ bool
                                kgd2kfd_device_init(struct kfd_dev *kfd,</div>
                              <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>const
                                struct kgd2kfd_shared_resources
                                *gpu_resources);</div>
                              <div class="">&nbsp;void
                                kgd2kfd_device_exit(struct kfd_dev
                                *kfd);</div>
                              <div class="">&nbsp;void kgd2kfd_suspend(struct
                                kfd_dev *kfd, bool run_pm, bool force);</div>
                              <div class="">+void
                                kgd2kfd_kill_all_user_processes(struct
                                kfd_dev *kfd);</div>
                              <div class="">&nbsp;int
                                kgd2kfd_resume_iommu(struct kfd_dev
                                *kfd);</div>
                              <div class="">&nbsp;int kgd2kfd_resume(struct
                                kfd_dev *kfd, bool run_pm, bool sync);</div>
                              <div class="">&nbsp;int
                                kgd2kfd_pre_reset(struct kfd_dev *kfd);</div>
                              <div class="">@@ -443,6 +445,9 @@ static
                                inline void kgd2kfd_suspend(struct
                                kfd_dev *kfd, bool run_pm, bool force)</div>
                              <div class="">&nbsp;{</div>
                              <div class="">&nbsp;}</div>
                              <div class="">&nbsp;</div>
                              <div class="">+void
                                kgd2kfd_kill_all_user_processes(struct
                                kfd_dev *kfd){</div>
                              <div class="">+}</div>
                              <div class="">+</div>
                              <div class="">&nbsp;static int __maybe_unused
                                kgd2kfd_resume_iommu(struct kfd_dev
                                *kfd)</div>
                              <div class="">&nbsp;{</div>
                              <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>return
                                0;</div>
                              <div class="">diff --git
                                a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c</div>
                              <div class="">index
                                3d5fc0751829..af6fe5080cfa 100644</div>
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
                                kill all kfd processes before
                                drm_dev_unplug */</div>
                              <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>amdgpu_amdkfd_kill_all_processes(drm_to_adev(dev));</div>
                              <div class="">+</div>
                              <div class="">&nbsp;#ifdef HAVE_DRM_DEV_UNPLUG</div>
                              <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>drm_dev_unplug(dev);</div>
                              <div class="">&nbsp;#else</div>
                              <div class="">diff --git
                                a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
b/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
                              <div class="">index
                                5504a18b5a45..480c23bef5e2 100644</div>
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
                                kgd2kfd_kill_all_user_processes(struct
                                kfd_dev* dev)</div>
                              <div class="">+{</div>
                              <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>kfd_kill_all_user_processes();</div>
                              <div class="">+}</div>
                              <div class="">+</div>
                              <div class="">+</div>
                              <div class="">&nbsp;void kgd2kfd_suspend(struct
                                kfd_dev *kfd, bool run_pm, bool force)</div>
                              <div class="">&nbsp;{</div>
                              <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>if
                                (!kfd-&gt;init_complete)</div>
                              <div class="">diff --git
                                a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
                                b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h</div>
                              <div class="">index
                                55c9e1922714..a35a2cb5bb9f 100644</div>
                              <div class="">---
                                a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h</div>
                              <div class="">+++
                                b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h</div>
                              <div class="">@@ -1064,6 +1064,7 @@ static
                                inline struct kfd_process_device
                                *kfd_process_device_from_gpuidx(</div>
                              <div class="">&nbsp;void
                                kfd_unref_process(struct kfd_process
                                *p);</div>
                              <div class="">&nbsp;int
                                kfd_process_evict_queues(struct
                                kfd_process *p, bool force);</div>
                              <div class="">&nbsp;int
                                kfd_process_restore_queues(struct
                                kfd_process *p);</div>
                              <div class="">+void
                                kfd_kill_all_user_processes(void);</div>
                              <div class="">&nbsp;void
                                kfd_suspend_all_processes(bool force);</div>
                              <div class="">&nbsp;/*</div>
                              <div class="">&nbsp; *
                                kfd_resume_all_processes:</div>
                              <div class="">diff --git
                                a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
b/drivers/gpu/drm/amd/amdkfd/kfd_process.c</div>
                              <div class="">index
                                6cdc855abb6d..17e769e6951d 100644</div>
                              <div class="">---
                                a/drivers/gpu/drm/amd/amdkfd/kfd_process.c</div>
                              <div class="">+++
                                b/drivers/gpu/drm/amd/amdkfd/kfd_process.c</div>
                              <div class="">@@ -46,6 +46,9 @@ struct
                                mm_struct;</div>
                              <div class="">&nbsp;#include &quot;kfd_trace.h&quot;</div>
                              <div class="">&nbsp;#include &quot;kfd_debug.h&quot;</div>
                              <div class="">&nbsp;</div>
                              <div class="">+static atomic_t
                                kfd_process_locked = ATOMIC_INIT(0);</div>
                              <div class="">+static atomic_t
                                kfd_inflight_kills = ATOMIC_INIT(0);</div>
                              <div class="">+</div>
                              <div class="">&nbsp;/*</div>
                              <div class="">&nbsp; * List of struct
                                kfd_process (field kfd_process).</div>
                              <div class="">&nbsp; * Unique/indexed by
                                mm_struct*</div>
                              <div class="">@@ -802,6 +805,9 @@ struct
                                kfd_process *kfd_create_process(struct
                                task_struct *thread)</div>
                              <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>struct
                                kfd_process *process;</div>
                              <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>int
                                ret;</div>
                              <div class="">&nbsp;</div>
                              <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>if
                                ( atomic_read(&amp;kfd_process_locked)
                                &gt; 0 )</div>
                              <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>return
                                ERR_PTR(-EINVAL);</div>
                              <div class="">+</div>
                              <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>if
                                (!(thread-&gt;mm &amp;&amp;
                                mmget_not_zero(thread-&gt;mm)))</div>
                              <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>return
                                ERR_PTR(-EINVAL);</div>
                              <div class="">&nbsp;</div>
                              <div class="">@@ -1126,6 +1132,10 @@
                                static void
                                kfd_process_wq_release(struct
                                work_struct *work)</div>
                              <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>put_task_struct(p-&gt;lead_thread);</div>
                              <div class="">&nbsp;</div>
                              <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>kfree(p);</div>
                              <div class="">+</div>
                              <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>if
                                ( atomic_read(&amp;kfd_process_locked)
                                &gt; 0 ){</div>
                              <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>atomic_dec(&amp;kfd_inflight_kills);</div>
                              <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>}</div>
                              <div class="">&nbsp;}</div>
                              <div class="">&nbsp;</div>
                              <div class="">&nbsp;static void
                                kfd_process_ref_release(struct kref
                                *ref)</div>
                              <div class="">@@ -2186,6 +2196,35 @@
                                static void
                                restore_process_worker(struct
                                work_struct *work)</div>
                              <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>pr_err(&quot;Failed
                                to restore queues of pasid 0x%x\n&quot;,
                                p-&gt;pasid);</div>
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
                                =
                                srcu_read_lock(&amp;kfd_processes_srcu);</div>
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
                                ( atomic_read(&amp;kfd_inflight_kills)
                                &gt; 0 ){</div>
                              <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>dev_warn(kfd_device,</div>
                              <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>&quot;kfd_processes_table
                                is not empty, going to sleep for
                                10ms\n&quot;);</div>
                              <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>msleep(10);</div>
                              <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>}</div>
                              <div class="">+</div>
                              <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>atomic_dec(&amp;kfd_process_locked);</div>
                              <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>pr_info(&quot;all
                                processes has been fully released&quot;);</div>
                              <div class="">+}</div>
                              <div class="">+</div>
                              <div class="">&nbsp;void
                                kfd_suspend_all_processes(bool force)</div>
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
                                  <div class=""><span style="caret-color: rgb(0, 0, 0);
                                      font-family: Helvetica; font-size:
                                      12px; font-style: normal;
                                      font-variant-caps: normal;
                                      font-weight: 400; letter-spacing:
                                      normal; text-align: start;
                                      text-indent: 0px; text-transform:
                                      none; white-space: normal;
                                      word-spacing: 0px;
                                      -webkit-text-stroke-width: 0px;
                                      text-decoration: none; float:
                                      none; display: inline !important;" class=""></span><br class="webkit-block-placeholder">
                                  </div>
                                  <p class=""><span style="caret-color:
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
                                      text-decoration: none; float:
                                      none; display: inline !important;" class=""><font class="" size="4">Andrey</font><br class="">
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
                                      kfd_resume_all_processes(bool
                                      sync)</div>
                                    <div class="">&nbsp;{</div>
                                    <div class="">&nbsp; &nbsp; &nbsp; &nbsp; struct
                                      kfd_process *p;</div>
                                    <div class=""><br class="">
                                    </div>
                                    <div class=""><br class="">
                                      <blockquote type="cite" class="">
                                        <div class=""><span style="caret-color: rgb(0,
                                            0, 0); font-family:
                                            Helvetica; font-size: 12px;
                                            font-style: normal;
                                            font-variant-caps: normal;
                                            font-weight: 400;
                                            letter-spacing: normal;
                                            text-align: start;
                                            text-indent: 0px;
                                            text-transform: none;
                                            white-space: normal;
                                            word-spacing: 0px;
                                            -webkit-text-stroke-width:
                                            0px; text-decoration: none;
                                            float: none; display: inline
                                            !important;" class="">Andrey</span><br style="caret-color: rgb(0,
                                            0, 0); font-family:
                                            Helvetica; font-size: 12px;
                                            font-style: normal;
                                            font-variant-caps: normal;
                                            font-weight: 400;
                                            letter-spacing: normal;
                                            text-align: start;
                                            text-indent: 0px;
                                            text-transform: none;
                                            white-space: normal;
                                            word-spacing: 0px;
                                            -webkit-text-stroke-width:
                                            0px; text-decoration: none;" class="">
                                          <br style="caret-color: rgb(0,
                                            0, 0); font-family:
                                            Helvetica; font-size: 12px;
                                            font-style: normal;
                                            font-variant-caps: normal;
                                            font-weight: 400;
                                            letter-spacing: normal;
                                            text-align: start;
                                            text-indent: 0px;
                                            text-transform: none;
                                            white-space: normal;
                                            word-spacing: 0px;
                                            -webkit-text-stroke-width:
                                            0px; text-decoration: none;" class="">
                                          <br style="caret-color: rgb(0,
                                            0, 0); font-family:
                                            Helvetica; font-size: 12px;
                                            font-style: normal;
                                            font-variant-caps: normal;
                                            font-weight: 400;
                                            letter-spacing: normal;
                                            text-align: start;
                                            text-indent: 0px;
                                            text-transform: none;
                                            white-space: normal;
                                            word-spacing: 0px;
                                            -webkit-text-stroke-width:
                                            0px; text-decoration: none;" class="">
                                          <blockquote type="cite" style="font-family:
                                            Helvetica; font-size: 12px;
                                            font-style: normal;
                                            font-variant-caps: normal;
                                            font-weight: 400;
                                            letter-spacing: normal;
                                            orphans: auto; text-align:
                                            start; text-indent: 0px;
                                            text-transform: none;
                                            white-space: normal; widows:
                                            auto; word-spacing: 0px;
                                            -webkit-text-size-adjust:
                                            auto;
                                            -webkit-text-stroke-width:
                                            0px; text-decoration: none;" class="">
                                            <br class="">
                                            Really appreciate your help!<br class="">
                                            <br class="">
                                            Best,<br class="">
                                            Shuotao<br class="">
                                            <br class="">
                                            <blockquote type="cite" class="">
                                              <blockquote type="cite" class="">2. Remove
                                                redudant p2p/io links in
                                                sysfs when device is
                                                hotplugged<br class="">
                                                out.<br class="">
                                                <br class="">
                                                3. New kfd node_id is
                                                not properly assigned
                                                after a new device is<br class="">
                                                added after a gpu is
                                                hotplugged out in a
                                                system. libhsakmt will<br class="">
                                                find this anomaly, (i.e.
                                                node_from != &lt;dev
                                                node id&gt; in iolinks),<br class="">
                                                when taking a
                                                topology_snapshot, thus
                                                returns fault to the
                                                rocm<br class="">
                                                stack.<br class="">
                                                <br class="">
                                                -- This patch fixes
                                                issue 1; another patch
                                                by Mukul fixes issues
                                                2&amp;3.<br class="">
                                                -- Tested on a 4-GPU
                                                MI100 gpu nodes with
                                                kernel 5.13.0-kfd;
                                                kernel<br class="">
                                                5.16.0-kfd is unstable
                                                out of box for MI100.<br class="">
                                                ---<br class="">
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 5 +++++<br class="">
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 7 +++++++<br class="">
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +<br class="">
drivers/gpu/drm/amd/amdkfd/kfd_device.c | 13 +++++++++++++<br class="">
                                                4 files changed, 26
                                                insertions(+)<br class="">
                                                <br class="">
                                                diff --git
                                                a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br class="">
                                                index
                                                c18c4be1e4ac..d50011bdb5c4
                                                100644<br class="">
                                                ---
                                                a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br class="">
                                                +++
                                                b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br class="">
                                                @@ -213,6 +213,11 @@ int
amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm)<br class="">
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
                                                int
                                                amdgpu_amdkfd_pre_reset(struct
                                                amdgpu_device *adev)<br class="">
                                                {<br class="">
                                                int r = 0;<br class="">
                                                diff --git
                                                a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br class="">
                                                index
                                                f8b9f27adcf5..803306e011c3
                                                100644<br class="">
                                                ---
                                                a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br class="">
                                                +++
                                                b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br class="">
                                                @@ -140,6 +140,7 @@ void
amdgpu_amdkfd_fini(void);<br class="">
                                                void
                                                amdgpu_amdkfd_suspend(struct
                                                amdgpu_device *adev,
                                                bool run_pm);<br class="">
                                                int
                                                amdgpu_amdkfd_resume_iommu(struct
                                                amdgpu_device *adev);<br class="">
                                                int
                                                amdgpu_amdkfd_resume(struct
                                                amdgpu_device *adev,
                                                bool run_pm);<br class="">
                                                +int
                                                amdgpu_amdkfd_resume_processes(void);<br class="">
                                                void
                                                amdgpu_amdkfd_interrupt(struct
                                                amdgpu_device *adev,<br class="">
                                                const void
                                                *ih_ring_entry);<br class="">
                                                void
                                                amdgpu_amdkfd_device_probe(struct
                                                amdgpu_device *adev);<br class="">
                                                @@ -347,6 +348,7 @@ void
kgd2kfd_device_exit(struct kfd_dev *kfd);<br class="">
                                                void
                                                kgd2kfd_suspend(struct
                                                kfd_dev *kfd, bool
                                                run_pm);<br class="">
                                                int
                                                kgd2kfd_resume_iommu(struct
                                                kfd_dev *kfd);<br class="">
                                                int
                                                kgd2kfd_resume(struct
                                                kfd_dev *kfd, bool
                                                run_pm);<br class="">
                                                +int
                                                kgd2kfd_resume_processes(void);<br class="">
                                                int
                                                kgd2kfd_pre_reset(struct
                                                kfd_dev *kfd);<br class="">
                                                int
                                                kgd2kfd_post_reset(struct
                                                kfd_dev *kfd);<br class="">
                                                void
                                                kgd2kfd_interrupt(struct
                                                kfd_dev *kfd, const void
                                                *ih_ring_entry);<br class="">
                                                @@ -393,6 +395,11 @@
                                                static inline int
                                                kgd2kfd_resume(struct
                                                kfd_dev *kfd, bool
                                                run_pm)<br class="">
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
                                                kgd2kfd_pre_reset(struct
                                                kfd_dev *kfd)<br class="">
                                                {<br class="">
                                                return 0;<br class="">
                                                diff --git
                                                a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br class="">
                                                index
                                                fa4a9f13c922..5827b65b7489
                                                100644<br class="">
                                                ---
                                                a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br class="">
                                                +++
                                                b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br class="">
                                                @@ -4004,6 +4004,7 @@
                                                void
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
                                                void
                                                amdgpu_device_fini_sw(struct
                                                amdgpu_device *adev)<br class="">
                                                diff --git
                                                a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br class="">
                                                index
                                                62aa6c9d5123..ef05aae9255e
                                                100644<br class="">
                                                ---
                                                a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br class="">
                                                +++
                                                b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br class="">
                                                @@ -714,6 +714,19 @@ int
                                                kgd2kfd_resume(struct
                                                kfd_dev *kfd, bool
                                                run_pm)<br class="">
                                                return ret;<br class="">
                                                }<br class="">
                                                <br class="">
                                                +/* for non-runtime
                                                resume only */<br class="">
                                                +int
                                                kgd2kfd_resume_processes(void)<br class="">
                                                +{<br class="">
                                                + int count;<br class="">
                                                +<br class="">
                                                + count =
                                                atomic_dec_return(&amp;kfd_locked);<br class="">
                                                + WARN_ONCE(count &lt;
                                                0, &quot;KFD suspend / resume
                                                ref. error&quot;);<br class="">
                                                + if (count == 0)<br class="">
                                                + return
                                                kfd_resume_all_processes();<br class="">
                                                +<br class="">
                                                + return 0;<br class="">
                                                +}<br class="">
                                              </blockquote>
                                              <br class="">
                                              It doesn't make sense to
                                              me to just increment
                                              kfd_locked in<br class="">
                                              kgd2kfd_suspend to only
                                              decrement it again a few
                                              functions down the<br class="">
                                              road.<br class="">
                                              <br class="">
                                              I suggest this instead -
                                              you only incrmemnt if not
                                              during PCI remove<br class="">
                                              <br class="">
                                              diff --git
                                              a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br class="">
b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br class="">
                                              index
                                              1c2cf3a33c1f..7754f77248a4
                                              100644<br class="">
                                              ---
                                              a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br class="">
                                              +++
                                              b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br class="">
                                              @@ -952,11 +952,12 @@ bool
                                              kfd_is_locked(void)<br class="">
                                              <br class="">
                                              void
                                              kgd2kfd_suspend(struct
                                              kfd_dev *kfd, bool run_pm)<br class="">
                                              {<br class="">
                                              +<br class="">
                                              if
                                              (!kfd-&gt;init_complete)<br class="">
                                              return;<br class="">
                                              <br class="">
                                              /* for runtime suspend,
                                              skip locking kfd */<br class="">
                                              - if (!run_pm) {<br class="">
                                              + if (!run_pm &amp;&amp;
                                              !drm_dev_is_unplugged(kfd-&gt;ddev))
                                              {<br class="">
                                              /* For first KFD device
                                              suspend all the KFD
                                              processes */<br class="">
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
                                                int
                                                kgd2kfd_resume_iommu(struct
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
            </div>
          </div>
        </blockquote>
      </div>
      <br class="">
    </blockquote>
  </body>
</html>

--------------xrbxjLbD1QNXX7AXrR0UR8ux--
