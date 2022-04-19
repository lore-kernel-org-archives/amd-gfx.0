Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA883C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Apr 2022 16:01:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BF1910EE94;
	Tue, 19 Apr 2022 16:01:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA04910EE94
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 16:01:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAPdeNQHiJ3pIv70IrrZzUs9xQodJ1N4gZF+tpq1YIwnLThgU89Y9TCFdGs2tB36vafSwriT9fa1w0EBSgxdrbCiftOL8OBBXihyLJZCU07v0xVxq8xoAi9OEK02ShR1EurG8XcvrK7owfQcf7POhaDkDWJJ7seHuq+kw0EQKIFxON6U2DBmPUNdKLNGhFjHK3Nf4P4gSBuMHzSHcPg7wFOSkvxCUOefLy+ZrLo047DkuFHn4CpbHzgwJZGOaVwzhaLRl7aABPn63hbSSTYUigmpYQeN1KgCKU2oGFKpE3mGBqDdXn1kyJfo2aIcyiBI8A5tDwQBVng1BqisjRZD4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3xw37N9Q59ayFPeAf1jw862/w4IATRdtoF9hO5um4A=;
 b=AnxFk+FRZLj1tik9VFV13dDWliYzCMOMqwwaD69KBYLnUGSr1hYrVOM6OgcNHZoZOZ43DM7rZYqale9BLcfteanJSMVvD6MxSMpxrHiRUQgAoypBdQ8K9iLZPPsoouYH2sNH+onaBavYul5LbIG6d4aHQPEPrvRcPF6BbTXGUCqqYQ2A7GMF85PWRXMOWSWAfoikAp9gr+Hzvo6PjsO37Ay0W8RCuygOveFPy41q/73r6rS169Jcljghz3GTvMIgAmhj96aJZq1KAqt8kX3OR33v0O75/dU8Z6PRWj9IatUECcUAMZ78p5XG5pilXduo4jCglN03foKc2daHWGmziA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3xw37N9Q59ayFPeAf1jw862/w4IATRdtoF9hO5um4A=;
 b=KM8f62H40UjLnmz4eG6eEDRASQtG+goOQuEB0DsjG1IrZsdSdU1w/zg+e/VWhQN5D2VWnqDVOGsCplxXpWclU0YAQWY6bHjPQiMrQNDLKG/7IsUTA0ieEO1XRHm4Mxb2sJb91ooxutyRbCo8nGagFALe64V4BvnvieX6aGyqQV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by MWHPR12MB1598.namprd12.prod.outlook.com (2603:10b6:301:4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 16:01:37 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::4967:ac3d:d5eb:ebb4]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::4967:ac3d:d5eb:ebb4%9]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 16:01:36 +0000
Content-Type: multipart/alternative;
 boundary="------------1kPSWthhFoGfhQAi5DCrigrp"
Message-ID: <77a8677a-0ac9-74be-598d-a2e8cf4d6883@amd.com>
Date: Tue, 19 Apr 2022 12:01:06 -0400
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
 <c5a41b51-5275-05dc-2a4e-2522ddb898b9@amd.com>
 <0FD33B90-BD27-4F32-9735-CA525735B5FA@microsoft.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <0FD33B90-BD27-4F32-9735-CA525735B5FA@microsoft.com>
X-ClientProxiedBy: YT3PR01CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::19) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82416622-014a-4052-a1db-08da221dd36f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1598:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1598AD716784BCF5D13506FAEAF29@MWHPR12MB1598.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XDQOzxKISGJVn+JDhbnE5IG/VIoI/HjpSH+6p173/XrJweeyVmoen9okh5BINp+FUVH/H44Kh7REo2n57Prrp/4V9wRQQdVuEHTwyuICcGrlDk950vsyRpEAY6L5regahp8MnBbNNQKT/ATyYiCTbX2VLEYs5lGWnDRwVfT+aJnEL+pQ7NYyjRSxJr+cLCoHzy+4k4VwXtP9X95z4GY0POnHco18Ky+ZisMh8o1MELqT9Vpnl8KoitO3+ZzAkGM7Zxqdxc7xX6pzgm2b/Ld/oFiPYg0qLuYDXcAowGXQus0Juuiw4I2bbuPcX/PZWDcNbCv7/ka+l66oLaQ49fdL2r1j/aw818d/Pc0wH83J65xVcOFORop6QxVjfn84cXdyDDsOHvOCkk0rnuQkePqz6K44z/OoPkf0ntbf2xxSLyfI4sEHKcGAcqIEB5ktLW50wzNK0Xf995oQrjmWR8mDyT1jL5Dgaxsrqci9SZZNRb5WrRyABN6m+qztjGqR2dn2oJaKmh29x5l/90fuBxoda1CvkYQ+pySTKlt4ZgTy0yZJg5cOV4cvYDkC/kxdG3Xjkm+lr1suzQJfoax9Uo6PONzmBLO1pu3Rl20rZvm2h3CkU7eDWTeWpjuMvmVCfigj3iY6qMw+6cEqQnrZn4VX7lu5p9NIzaFZHVbk5bCEv9vA1yWCbY6QGH4NYt4kYb0GRZtd+IXhQ1JMhMArh5GHcgbYTSX3jLA/LQlgGgOA7dXgSanEcKGxRoWRB+2NZwuvy1mcM8vsmo9hJNr2ENetskchQX4cqjtZNojoUjwbXk9n41fEcqxBLXDw1sE1jYh4zAUPS5+V0hWScgkwQnBAfUvDaKqOoy8Q1Xy52nU4+3tN6anp9gLkOg1atNFKuo/l
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(279900001)(629001)(36756003)(86362001)(54906003)(44832011)(8676002)(38100700002)(8936002)(316002)(5660300002)(2906002)(33964004)(6512007)(6916009)(30864003)(45080400002)(66476007)(66556008)(66946007)(166002)(508600001)(966005)(6486002)(4326008)(6666004)(6506007)(2616005)(186003)(31686004)(31696002)(83380400001)(53546011)(43740500002)(45980500001)(559001)(579004)(10090945011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDNEM2JpRXVUR2tJWldtVjdhejlkeVdqYlB1RVUzR2dDWStkbDY3VGVKc1Vz?=
 =?utf-8?B?QnMyYmk1aWNzeklVMmNDYTBGRkVHbEhUcE5BWm1qa0JYNVhkaTNKcHhlU1hh?=
 =?utf-8?B?MkZwZkRxdmxRSG05QndmNTl2RE1PbG9zdTluNWhWaVpJWU9oSUUzdE9HcEZi?=
 =?utf-8?B?QVFkVzBFUk8zQXdiVTV6akdVaUVZU2xVRElsS0t3ai85NTY4amg1R1AvU3By?=
 =?utf-8?B?UlAwcngrNUtLOFMwbDk0VmR3MnRTZHpsR2NBRzBydnNtUmFlQ0JtUk81bzE5?=
 =?utf-8?B?N0d1ckhzVVVJck9EeDRXcVFIalJxcHB4RGdVemxjTmVhV3UvNWtSNlhEWGVl?=
 =?utf-8?B?VTVzaTJ3ejJ4QVNFTHlRa3pzZUNLR0djK29keFdsZDFRMS9qMGtHeURvNnRl?=
 =?utf-8?B?OVcwYzJPT3pqZ09QODBBRTg1RmRGZHB0OGpoc1FzYzRwMCt4SDNSMkpkdlkr?=
 =?utf-8?B?Z3B4bWNYbGljQ2ZjZ2FVUVdhc21pV0Jld1hrTUl1YzhXYWdFWU5GaEFFbGxX?=
 =?utf-8?B?Ym5SUlRZVzJ6OUxwOEticDRoQlVOK2ZoRElEemdtMEYwZVNxTDNJTVNldk91?=
 =?utf-8?B?VFlqeFdPcE1vNVkzcVhjMUV6T0xUbjR6WWhBY1hOeGNUVldKcWhrVXcvMVEv?=
 =?utf-8?B?WTkwQW9Lc0ZndnluUGJVejBUSVJHZEVpM0ZLbVQ4OGJTUGoyWlNPaFYwai9Z?=
 =?utf-8?B?eEY3M2lkMDZZZzZGQzhBam5GS2tXSURIaWorOXIrcmFEMzJEOWF4VW1jSkl2?=
 =?utf-8?B?T0VHSlBCTXJYOW9QSkNCL0FjN1BoaHZLcndYM2E2NStncnlibE1EVDlWYW9H?=
 =?utf-8?B?ZW83cW0xU3hTWGVYamZDVDJsY3dQMk5ZVU1wUzM1K1JQRzM2WVd3enRLeXp2?=
 =?utf-8?B?TmxzU2VFaGF2YjIvRG5pWS9CVDhURVFiMk4zQzNYYkRKODFpU2JIT2FTR01k?=
 =?utf-8?B?NzdIYUMrZ2gxS2VhanJScys0MXA0Y1R0SE1VOHhTVXhZY3ZxbVBjWlA1WUE0?=
 =?utf-8?B?UFVRejFXWHdSelRsVDVGYjA1R296OW1nWThESEZlOFBSalFhMTZobS8xSWUx?=
 =?utf-8?B?WjN0U2xiVFV5bUUrbXI4KzVXU1JuSUlIeHh5MEs2ODl1R0Z1eWI4b1cyN1Fm?=
 =?utf-8?B?ckxEUHQyZVZLRzA3NE1lREFJN2d5a3VWOE51SWRZQ3JFWlV2d0hVNW4zcHlv?=
 =?utf-8?B?WTF2dVVkSXVQZ2NUdkw1OTVUSmVqUVlGaGU0dWJYN29IeXNsWmhhODJSZUNa?=
 =?utf-8?B?SHhhSWlOZ0Z2bmN2ZXE1cTVjcUgrc0lrVGpQUDVFYTFsa3p1Z1lBdWUyOGpq?=
 =?utf-8?B?L1FwN04rVTB1WHZ6QW9WZi9DTXZ1ZzVlTFRObnF1aHBFOVZ5MmdJVGlSMm9r?=
 =?utf-8?B?cEc0UG9TVFRlRW9Uc080VlBvalkxaTdIc1JwY1orTmxmVThwREdRZFJtV1hB?=
 =?utf-8?B?Y2F5ZUY3VGUxUG9lYUVVYlp2SlByYXZBOVZTQVhJUGE4RDJhSmd0czZ0OVpm?=
 =?utf-8?B?aTlIVGRLUTRYUzBxM3pCcDl0VjE0bm5pVkZZSFJHd0FHZy9Qd28vUzVXRzVv?=
 =?utf-8?B?WFJxVlMrQUxQYk5mb3hqTFVGcmN6dXBpQkEydERyT282L3RBZkZxZUFKa242?=
 =?utf-8?B?akpOd3JQaUVEWVR3M0EvR2t5MlRFeFNDSG5oOU9KS1FuaGJTdlA3RFI3a2RG?=
 =?utf-8?B?N0NqQ0xTZlFnL0IyeWQ5RU1tNTE5czg0U2p1eldXeUMyNEJYczZZSlBVbjJl?=
 =?utf-8?B?VDRnQ0JUWkplY0xVWWRlR3B3aUpCYXNiOUduR291YzVPVm1od1ltUkhEYlZ4?=
 =?utf-8?B?c2Faam90UEdTdDN2SS9DcHVLR05PL2xUWitLTUlJc3A5UlVuaGtCODRxT2w4?=
 =?utf-8?B?VFZWZEp6Tm0rd21NMjgzYlZHaVZtT3ExcWlTSjFyMnhzVXA1ODhmd01vNGQ2?=
 =?utf-8?B?UVVYZ2xzYUUzVWtoRVZ2WnFzT21kYjhaWUw2c242NFNnVExSWVRWK1loajhy?=
 =?utf-8?B?dG9HZEc3cXVHMkZoVjhlVWFLVDc2Ni92V0gwSnB0cWt4TythcWxOejlvbTBa?=
 =?utf-8?B?ME1wUXQvelFDM1RPY2dPa29lWXgzWVdOeUpCYms1WU8vS3dPNTI0TkJaaVBl?=
 =?utf-8?B?T2xyYTdrTGJWTnpKNFc0SzJJQkRTWkxSVytzS25sQnhHNGFEbzdGWFdjNGRJ?=
 =?utf-8?B?aGJPRzBTWHZKY0tGZmdjcmlNZ1hXUVRaeFkxaERTNElPSzJPcTBld0NZQklp?=
 =?utf-8?B?cWF4cDF1MWdvRG51VWVvV1pONEMwNk5Ib1BESFg5UXpEb3JKMnc0UUlOMGNk?=
 =?utf-8?B?azZ1c1NtMFVNQ1JhOUdOWEVNQjU4RFQ1UEJvbHkxSUlpbTZDd0pkeFFoREdm?=
 =?utf-8?Q?NzXUXRnoCh8T9KFqWZn02sa0Z9JDQqe3dsLs5IfwANnTG?=
X-MS-Exchange-AntiSpam-MessageData-1: 3Bx+Jaw4ScZhYw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82416622-014a-4052-a1db-08da221dd36f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 16:01:36.8189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ynXSZl9+ciVTpcqfxPntO1n52seyPMcMARw/ECSQ5pAjkVBgF86l/mB/0chkEVLkQjytmMH/T1gZ9J62sr9aBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1598
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

--------------1kPSWthhFoGfhQAi5DCrigrp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2022-04-19 03:41, Shuotao Xu wrote:
>
>
>> On Apr 18, 2022, at 11:23 PM, Andrey Grodzovsky 
>> <andrey.grodzovsky@amd.com> wrote:
>>
>>
>> On 2022-04-18 09:22, Shuotao Xu wrote:
>>>
>>>
>>>> On Apr 16, 2022, at 12:43 AM, Andrey Grodzovsky 
>>>> <andrey.grodzovsky@amd.com> wrote:
>>>>
>>>>
>>>> On 2022-04-15 06:12, Shuotao Xu wrote:
>>>>> Hi Andrey,
>>>>>
>>>>> First I really appreciate the discussion! It helped me understand 
>>>>> the driver code greatly. Thank you so much:)
>>>>> Please see my inline comments.
>>>>>
>>>>>> On Apr 14, 2022, at 11:13 PM, Andrey Grodzovsky 
>>>>>> <andrey.grodzovsky@amd.com> wrote:
>>>>>>
>>>>>>
>>>>>> On 2022-04-14 10:00, Shuotao Xu wrote:
>>>>>>>
>>>>>>>
>>>>>>>> On Apr 14, 2022, at 1:31 AM, Andrey Grodzovsky 
>>>>>>>> <andrey.grodzovsky@amd.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2022-04-13 12:03, Shuotao Xu wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> On Apr 11, 2022, at 11:52 PM, Andrey Grodzovsky 
>>>>>>>>>> <andrey.grodzovsky@amd.com> wrote:
>>>>>>>>>>
>>>>>>>>>> [Some people who received this message don't often get email 
>>>>>>>>>> fromandrey.grodzovsky@amd.com. Learn why this is important 
>>>>>>>>>> athttp://aka.ms/LearnAboutSenderIdentification.]
>>>>>>>>>>
>>>>>>>>>> On 2022-04-08 21:28, Shuotao Xu wrote:
>>>>>>>>>>>
>>>>>>>>>>>> On Apr 8, 2022, at 11:28 PM, Andrey Grodzovsky 
>>>>>>>>>>>> <andrey.grodzovsky@amd.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> [Some people who received this message don't often get 
>>>>>>>>>>>> email from andrey.grodzovsky@amd.com. Learn why this is 
>>>>>>>>>>>> important at http://aka.ms/LearnAboutSenderIdentification.]
>>>>>>>>>>>>
>>>>>>>>>>>> On 2022-04-08 04:45, Shuotao Xu wrote:
>>>>>>>>>>>>> Adding PCIe Hotplug Support for AMDKFD: the support of 
>>>>>>>>>>>>> hot-plug of GPU
>>>>>>>>>>>>> devices can open doors for many advanced applications in 
>>>>>>>>>>>>> data center
>>>>>>>>>>>>> in the next few years, such as for GPU resource
>>>>>>>>>>>>> disaggregation. Current AMDKFD does not support hotplug 
>>>>>>>>>>>>> out b/o the
>>>>>>>>>>>>> following reasons:
>>>>>>>>>>>>>
>>>>>>>>>>>>> 1. During PCIe removal, decrement KFD lock which was 
>>>>>>>>>>>>> incremented at
>>>>>>>>>>>>> the beginning of hw fini; otherwise kfd_open later is going to
>>>>>>>>>>>>> fail.
>>>>>>>>>>>> I assumed you read my comment last time, still you do same 
>>>>>>>>>>>> approach.
>>>>>>>>>>>> More in details bellow
>>>>>>>>>>> Aha, I like your fix:) I was not familiar with drm APIs so 
>>>>>>>>>>> just only half understood your comment last time.
>>>>>>>>>>>
>>>>>>>>>>> BTW, I tried hot-plugging out a GPU when rocm application is 
>>>>>>>>>>> still running.
>>>>>>>>>>> From dmesg, application is still trying to access the 
>>>>>>>>>>> removed kfd device, and are met with some errors.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Application us supposed to keep running, it holds the drm_device
>>>>>>>>>> reference as long as it has an open
>>>>>>>>>> FD to the device and final cleanup will come only after the 
>>>>>>>>>> app will die
>>>>>>>>>> thus releasing the FD and the last
>>>>>>>>>> drm_device reference.
>>>>>>>>>>
>>>>>>>>>>> Application would hang and not exiting in this case.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Actually I tried kill -7 $pid, and the process exists. The 
>>>>>>>>> dmesg has some warning though.
>>>>>>>>>
>>>>>>>>> [  711.769977] WARNING: CPU: 23 PID: 344 at 
>>>>>>>>> .../amdgpu-rocm5.0.2/src/amd/amdgpu/amdgpu_object.c:1336 
>>>>>>>>> amdgpu_bo_release_notify+0x150/0x160 [amdgpu]
>>>>>>>>> [  711.770528] Modules linked in: amdgpu(OE) amdttm(OE) 
>>>>>>>>> amd_sched(OE) amdkcl(OE) iommu_v2 nf_conntrack_netlink 
>>>>>>>>> nfnetlink xfrm_user xfrm_algo xt_addrtype br_netfilter 
>>>>>>>>> xt_CHECKSUM iptable_mangle xt_MASQUERADE iptable_nat nf_nat 
>>>>>>>>> xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 
>>>>>>>>> ipt_REJECT nf_reject_ipv4 xt_tcpudp bridge stp llc 
>>>>>>>>> ebtable_filter ebtables ip6table_filter ip6_tables 
>>>>>>>>> iptable_filter overlay binfmt_misc intel_rapl_msr i40iw 
>>>>>>>>> intel_rapl_common skx_edac nfit x86_pkg_temp_thermal 
>>>>>>>>> intel_powerclamp coretemp kvm_intel rpcrdma kvm sunrpc 
>>>>>>>>> ipmi_ssif ib_umad ib_ipoib rdma_ucm irqbypass rapl joydev 
>>>>>>>>> acpi_ipmi input_leds intel_cstate ipmi_si ipmi_devintf mei_me 
>>>>>>>>> mei intel_pch_thermal ipmi_msghandler ioatdma mac_hid lpc_ich 
>>>>>>>>> dca acpi_power_meter acpi_pad sch_fq_codel ib_iser rdma_cm 
>>>>>>>>> iw_cm ib_cm iscsi_tcp libiscsi_tcp libiscsi 
>>>>>>>>> scsi_transport_iscsi pci_stub ip_tables x_tables autofs4 btrfs 
>>>>>>>>> blake2b_generic zstd_compress raid10 raid456 async_raid6_recov 
>>>>>>>>> async_memcpy async_pq async_xor async_tx xor
>>>>>>>>> [  711.779359]  raid6_pq libcrc32c raid1 raid0 multipath 
>>>>>>>>> linear mlx5_ib ib_uverbs ib_core ast drm_vram_helper 
>>>>>>>>> i2c_algo_bit drm_ttm_helper ttm drm_kms_helper syscopyarea 
>>>>>>>>> crct10dif_pclmul crc32_pclmul ghash_clmulni_intel sysfillrect 
>>>>>>>>> uas hid_generic sysimgblt aesni_intel mlx5_core fb_sys_fops 
>>>>>>>>> crypto_simd usbhid cryptd drm i40e pci_hyperv_intf usb_storage 
>>>>>>>>> glue_helper mlxfw hid ahci libahci wmi
>>>>>>>>> [  711.779752] CPU: 23 PID: 344 Comm: kworker/23:1 Tainted: G 
>>>>>>>>>        W  OE     5.11.0+ #1
>>>>>>>>> [  711.779755] Hardware name: Supermicro 
>>>>>>>>> SYS-4029GP-TRT2/X11DPG-OT-CPU, BIOS 2.1 08/14/2018
>>>>>>>>> [  711.779756] Workqueue: kfd_process_wq 
>>>>>>>>> kfd_process_wq_release [amdgpu]
>>>>>>>>> [  711.779955] RIP: 0010:amdgpu_bo_release_notify+0x150/0x160 
>>>>>>>>> [amdgpu]
>>>>>>>>> [  711.780141] Code: e8 b5 af 34 f4 e9 1f ff ff ff 48 39 c2 74 
>>>>>>>>> 07 0f 0b e9 69 ff ff ff 4c 89 e7 e8 3c b4 16 00 e9 5c ff ff ff 
>>>>>>>>> e8 a2 ce fd f3 eb cf <0f> 0b eb cb e8 d7 02 34 f4 0f 1f 80 00 
>>>>>>>>> 00 00 00 0f 1f 44 00 00 55
>>>>>>>>> [  711.780143] RSP: 0018:ffffa8100dd67c30 EFLAGS: 00010282
>>>>>>>>> [  711.780145] RAX: 00000000ffffffea RBX: ffff89980e792058 
>>>>>>>>> RCX: 0000000000000000
>>>>>>>>> [  711.780147] RDX: 0000000000000000 RSI: ffff89a8f9ad8870 
>>>>>>>>> RDI: ffff89a8f9ad8870
>>>>>>>>> [  711.780148] RBP: ffffa8100dd67c50 R08: 0000000000000000 
>>>>>>>>> R09: fffffffffff99b18
>>>>>>>>> [  711.780149] R10: ffffa8100dd67bd0 R11: ffffa8100dd67908 
>>>>>>>>> R12: ffff89980e792000
>>>>>>>>> [  711.780151] R13: ffff89980e792058 R14: ffff89980e7921bc 
>>>>>>>>> R15: dead000000000100
>>>>>>>>> [  711.780152] FS:  0000000000000000(0000) 
>>>>>>>>> GS:ffff89a8f9ac0000(0000) knlGS:0000000000000000
>>>>>>>>> [  711.780154] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>>>>> [  711.780156] CR2: 00007ffddac6f71f CR3: 00000030bb80a003 
>>>>>>>>> CR4: 00000000007706e0
>>>>>>>>> [  711.780157] DR0: 0000000000000000 DR1: 0000000000000000 
>>>>>>>>> DR2: 0000000000000000
>>>>>>>>> [  711.780159] DR3: 0000000000000000 DR6: 00000000fffe0ff0 
>>>>>>>>> DR7: 0000000000000400
>>>>>>>>> [  711.780160] PKRU: 55555554
>>>>>>>>> [  711.780161] Call Trace:
>>>>>>>>> [  711.780163]  ttm_bo_release+0x2ae/0x320 [amdttm]
>>>>>>>>> [  711.780169]  amdttm_bo_put+0x30/0x40 [amdttm]
>>>>>>>>> [  711.780357]  amdgpu_bo_unref+0x1e/0x30 [amdgpu]
>>>>>>>>> [  711.780543]  amdgpu_gem_object_free+0x8b/0x160 [amdgpu]
>>>>>>>>> [  711.781119]  drm_gem_object_free+0x1d/0x30 [drm]
>>>>>>>>> [  711.781489] 
>>>>>>>>>  amdgpu_amdkfd_gpuvm_free_memory_of_gpu+0x34a/0x380 [amdgpu]
>>>>>>>>> [  711.782044]  kfd_process_device_free_bos+0xe0/0x130 [amdgpu]
>>>>>>>>> [  711.782611]  kfd_process_wq_release+0x286/0x380 [amdgpu]
>>>>>>>>> [  711.783172]  process_one_work+0x236/0x420
>>>>>>>>> [  711.783543]  worker_thread+0x34/0x400
>>>>>>>>> [  711.783911]  ? process_one_work+0x420/0x420
>>>>>>>>> [  711.784279]  kthread+0x126/0x140
>>>>>>>>> [  711.784653]  ? kthread_park+0x90/0x90
>>>>>>>>> [  711.785018]  ret_from_fork+0x22/0x30
>>>>>>>>> [  711.785387] ---[ end trace d8f50f6594817c84 ]---
>>>>>>>>> [  711.798716] [drm] amdgpu: ttm finalized
>>>>>>>>
>>>>>>>>
>>>>>>>> So it means the process was stuck in some wait_event_killable 
>>>>>>>> (maybe here drm_sched_entity_flush) - you can try 
>>>>>>>> 'cat/proc/$process_pid/stack' maybe before
>>>>>>>> you kill it to see where it was stuck so we can go from there.
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> For graphic apps what i usually see is a crash because of 
>>>>>>>>>> sigsev when
>>>>>>>>>> the app tries to access
>>>>>>>>>> an unmapped MMIO region on the device. I haven't tested for 
>>>>>>>>>> compute
>>>>>>>>>> stack and so there might
>>>>>>>>>> be something I haven't covered. Hang could mean for example 
>>>>>>>>>> waiting on a
>>>>>>>>>> fence which is not being
>>>>>>>>>> signaled - please provide full dmesg from this case.
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Do you have any good suggestions on how to fix it down the 
>>>>>>>>>>> line? (HIP runtime/libhsakmt or driver)
>>>>>>>>>>>
>>>>>>>>>>> [64036.631333] amdgpu: amdgpu_vm_bo_update failed
>>>>>>>>>>> [64036.631702] amdgpu: validate_invalid_user_pages: update 
>>>>>>>>>>> PTE failed
>>>>>>>>>>> [64036.640754] amdgpu: amdgpu_vm_bo_update failed
>>>>>>>>>>> [64036.641120] amdgpu: validate_invalid_user_pages: update 
>>>>>>>>>>> PTE failed
>>>>>>>>>>> [64036.650394] amdgpu: amdgpu_vm_bo_update failed
>>>>>>>>>>> [64036.650765] amdgpu: validate_invalid_user_pages: update 
>>>>>>>>>>> PTE failed
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> The full dmesg will just the repetition of those two messages,
>>>>>>>>> [186885.764079] amdgpu 0000:43:00.0: amdgpu: amdgpu: finishing 
>>>>>>>>> device.
>>>>>>>>> [186885.766916] [drm] free PSP TMR buffer
>>>>>>>>> [186893.868173] amdgpu: amdgpu_vm_bo_update failed
>>>>>>>>> [186893.868235] amdgpu: validate_invalid_user_pages: update 
>>>>>>>>> PTE failed
>>>>>>>>> [186893.876154] amdgpu: amdgpu_vm_bo_update failed
>>>>>>>>> [186893.876190] amdgpu: validate_invalid_user_pages: update 
>>>>>>>>> PTE failed
>>>>>>>>> [186893.884150] amdgpu: amdgpu_vm_bo_update failed
>>>>>>>>> [186893.884185] amdgpu: validate_invalid_user_pages: update 
>>>>>>>>> PTE failed
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> This just probably means trying to update PTEs after the 
>>>>>>>>>> physical device
>>>>>>>>>> is gone - we usually avoid this by
>>>>>>>>>> first trying to do all HW shutdowns early before PCI remove 
>>>>>>>>>> completion
>>>>>>>>>> but when it's really tricky by
>>>>>>>>>> protecting HW access sections with drm_dev_enter/exit scope.
>>>>>>>>>>
>>>>>>>>>> For this particular error it would be the best to flush
>>>>>>>>>> info->restore_userptr_work before the end of
>>>>>>>>>> amdgpu_pci_remove (rejecting new process creation and calling
>>>>>>>>>> cancel_delayed_work_sync(&process_info->restore_userptr_work) 
>>>>>>>>>> for all
>>>>>>>>>> running processes)
>>>>>>>>>> somewhere in amdgpu_pci_remove.
>>>>>>>>>>
>>>>>>>>> I tried something like *kfd_process_ref_release* which I think 
>>>>>>>>> did what you described, but it did not work.
>>>>>>>>
>>>>>>>>
>>>>>>>> I don't see how kfd_process_ref_release is the same as I 
>>>>>>>> mentioned above, what i meant is calling the code above within 
>>>>>>>> kgd2kfd_suspend (where you tried to call 
>>>>>>>> kfd_kill_all_user_processes bellow)
>>>>>>>>
>>>>>>> Yes, you are right. It was not called by it.
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Instead I tried to kill the process from the kernel, but the 
>>>>>>>>> amdgpu could **only** be hot-plugged in back successfully only 
>>>>>>>>> if there was no rocm kernel running when it was plugged out. 
>>>>>>>>> If not, amdgpu_probe will just hang later. (Maybe because 
>>>>>>>>> amdgpu was plugged out while running state, it leaves a bad HW 
>>>>>>>>> state which causes probe to hang).
>>>>>>>>
>>>>>>>>
>>>>>>>> We usually do asic_reset during probe to reset all HW state 
>>>>>>>> (checlk if amdgpu_device_init->amdgpu_asic_reset is running 
>>>>>>>> when you plug back).
>>>>>>>>
>>>>>>> OK
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> I don’t know if this is a viable solution worth pursuing, but 
>>>>>>>>> I attached the diff anyway.
>>>>>>>>>
>>>>>>>>> Another solution could be let compute stack user mode detect a 
>>>>>>>>> topology change via generation_count change, and abort 
>>>>>>>>> gracefully there.
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>>>>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>>>> index 4e7d9cb09a69..79b4c9b84cd0 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>>>> @@ -697,12 +697,15 @@ void kgd2kfd_suspend(struct kfd_dev 
>>>>>>>>> *kfd, bool run_pm, bool force)
>>>>>>>>>       return;
>>>>>>>>>
>>>>>>>>>         /* for runtime suspend, skip locking kfd */
>>>>>>>>> -       if (!run_pm) {
>>>>>>>>> +       if (!run_pm && !drm_dev_is_unplugged(kfd->ddev)) {
>>>>>>>>>       /* For first KFD device suspend all the KFD processes */
>>>>>>>>>       if (atomic_inc_return(&kfd_locked) == 1)
>>>>>>>>> kfd_suspend_all_processes(force);
>>>>>>>>>         }
>>>>>>>>>
>>>>>>>>> +       if (drm_dev_is_unplugged(kfd->ddev))
>>>>>>>>> + kfd_kill_all_user_processes();
>>>>>>>>> +
>>>>>>>>> kfd->dqm->ops.stop(kfd->dqm);
>>>>>>>>> kfd_iommu_suspend(kfd);
>>>>>>>>>  }
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>>>>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>>>>>> index 55c9e1922714..84cbcd857856 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>>>>>> @@ -1065,6 +1065,7 @@ void kfd_unref_process(struct 
>>>>>>>>> kfd_process *p);
>>>>>>>>>  int kfd_process_evict_queues(struct kfd_process *p, bool force);
>>>>>>>>>  int kfd_process_restore_queues(struct kfd_process *p);
>>>>>>>>>  void kfd_suspend_all_processes(bool force);
>>>>>>>>> +void kfd_kill_all_user_processes(void);
>>>>>>>>>  /*
>>>>>>>>>   * kfd_resume_all_processes:
>>>>>>>>>   * bool sync: If kfd_resume_all_processes() should wait for the
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>>>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>>>>> index 6cdc855abb6d..fb0c753b682c 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>>>>> @@ -2206,6 +2206,24 @@ void kfd_suspend_all_processes(bool force)
>>>>>>>>> srcu_read_unlock(&kfd_processes_srcu, idx);
>>>>>>>>>  }
>>>>>>>>>
>>>>>>>>> +
>>>>>>>>> +void kfd_kill_all_user_processes(void)
>>>>>>>>> +{
>>>>>>>>> + struct kfd_process *p;
>>>>>>>>> + struct amdkfd_process_info *p_info;
>>>>>>>>> + unsigned int temp;
>>>>>>>>> + int idx = srcu_read_lock(&kfd_processes_srcu);
>>>>>>>>> +
>>>>>>>>> + pr_info("Killing all processes\n");
>>>>>>>>> + hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>>>>>>>>> +       p_info = p->kgd_process_info;
>>>>>>>>> +       pr_info("Killing  processes, pid = %d", 
>>>>>>>>> pid_nr(p_info->pid));
>>>>>>>>> + kill_pid(p_info->pid, SIGBUS, 1);
>>>>>>>>
>>>>>>>>
>>>>>>>> From looking into kill_pid I see it only sends a signal but 
>>>>>>>> doesn't wait for completion, it would make sense to wait for 
>>>>>>>> completion here. In any case I would actually try to put here
>>>>>>>>
>>>>>>> I have made a version which does that with some atomic counters. 
>>>>>>> Please read later in the diff.
>>>>>>>>
>>>>>>>>
>>>>>>>> hash_for_each_rcu(p_info)
>>>>>>>> cancel_delayed_work_sync(&p_info->restore_userptr_work)
>>>>>>>>
>>>>>>>> instead at least that what i meant in the previous mail.
>>>>>>>>
>>>>>>> I actually tried that earlier, and it did not work. Application 
>>>>>>> still keeps running, and you have to send a kill to the user 
>>>>>>> process.
>>>>>>>
>>>>>>> I have made the following version. It waits for processes to 
>>>>>>> terminate synchronously after sending SIGBUS. After that it does 
>>>>>>> the real work of amdgpu_pci_remove.
>>>>>>> However, it hangs at amdgpu_device_ip_fini_early when it is 
>>>>>>> trying to deinit ip_block 6 <sdma_v4_0> 
>>>>>>> (https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L2818 
>>>>>>> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux%2F-%2Fblob%2Famd-staging-drm-next%2Fdrivers%2Fgpu%2Fdrm%2Famd%2Famdgpu%2Famdgpu_device.c%23L2818&data=04%7C01%7Candrey.grodzovsky%40amd.com%7C78c882de9193490a3b4408da21d8132d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637859509203317436%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=rHsAHCgj8akFPDv6S3Td3GYgqEaWa6%2FhJ94fjH8k3%2Bg%3D&reserved=0>). 
>>>>>>> I assume that there are still some inflight dma, therefore fini 
>>>>>>> of this ip block thus hangs?
>>>>>>>
>>>>>>> The following is an excerpt of the dmesg: please excuse for 
>>>>>>> putting my own pr_info, but I hope you get my point of where it 
>>>>>>> hangs.
>>>>>>>
>>>>>>> [  392.344735] amdgpu: all processes has been fully released
>>>>>>> [  392.346557] amdgpu: amdgpu_acpi_fini done
>>>>>>> [  392.346568] amdgpu 0000:b3:00.0: amdgpu: amdgpu: finishing 
>>>>>>> device.
>>>>>>> [  392.349238] amdgpu: amdgpu_device_ip_fini_early enter 
>>>>>>> ip_blocks = 9
>>>>>>> [  392.349248] amdgpu: Free mem_obj = 000000007bf54275, 
>>>>>>> range_start = 14, range_end = 14
>>>>>>> [  392.350299] amdgpu: Free mem_obj = 00000000a85bc878, 
>>>>>>> range_start = 12, range_end = 12
>>>>>>> [  392.350304] amdgpu: Free mem_obj = 00000000b8019e32, 
>>>>>>> range_start = 13, range_end = 13
>>>>>>> [  392.350308] amdgpu: Free mem_obj = 000000002d296168, 
>>>>>>> range_start = 4, range_end = 11
>>>>>>> [  392.350313] amdgpu: Free mem_obj = 000000001fc4f934, 
>>>>>>> range_start = 0, range_end = 3
>>>>>>> [  392.350322] amdgpu: amdgpu_amdkfd_suspend(adev, false) done
>>>>>>> [  392.350672] amdgpu: hw_fini of IP block[8] <jpeg_v2_5> done 0
>>>>>>> [  392.350679] amdgpu: hw_fini of IP block[7] <vcn_v2_5> done 0
>>>>>>
>>>>>>
>>>>>> I just remembered that the idea to actively kill and wait for 
>>>>>> running user processes during unplug was rejected
>>>>>> as a bad idea in the first iteration of unplug work I did (don't 
>>>>>> remember why now, need to look) so this is a no go.
>>>>>>
>>>>> Maybe an application has kfd open, but was not accessing the dev. 
>>>>> So kill it at unplug could kill the process unnecessarily.
>>>>> However, the latest version I had with the sleep function got rid 
>>>>> of the IP block fini hang.
>>>>>>
>>>>>> Our policy is to let zombie processes (zombie in a sense that the 
>>>>>> underlying device is gone) live as long as they want
>>>>>> (as long as you able to terminate them - which you do, so that ok)
>>>>>> and the system should finish PCI remove gracefully and be able to 
>>>>>> hot plug back the device.  Hence, i suggest dropping
>>>>>> this direction of forcing all user processes to be killed, 
>>>>>> confirm you have graceful shutdown and remove of device
>>>>>> from PCI topology and then concentrate on why when you plug back 
>>>>>> it hangs.
>>>>>>
>>>>> So I basically revert back to the original solution which you 
>>>>> suggested.
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>> index 4e7d9cb09a69..5504a18b5a45 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>> @@ -697,7 +697,7 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool 
>>>>> run_pm, bool force)
>>>>>                 return;
>>>>>
>>>>>         /* for runtime suspend, skip locking kfd */
>>>>> -       if (!run_pm) {
>>>>> +       if (!run_pm && !drm_dev_is_unplugged(kfd->ddev)) {
>>>>>                 /* For first KFD device suspend all the KFD 
>>>>> processes */
>>>>>                 if (atomic_inc_return(&kfd_locked) == 1)
>>>>> kfd_suspend_all_processes(force);
>>>>>
>>>>>> First confirm if ASIC reset happens on
>>>>>> next init.
>>>>>>
>>>>> This patch works great at *planned* plugout, where all the rocm 
>>>>> processes are killed before plugout. And device can be added back 
>>>>> without a problem.
>>>>> However *unplanned* plugout when there is rocm processes are 
>>>>> running just don’t work.
>>>>
>>>>
>>>> Still I am not clear if ASIC reset happens on plug back or no, can 
>>>> you trace this please ?
>>>>
>>>>
>>>
>>> I tried add pr_info into asic_reset functions, but cannot trace any 
>>> upon plug-back.
>>
>>
>> This could possibly explain the hang on plug back. Can you see why we 
>> don't get there ?
>>
>>
> Is amdgpu supposed to asic_reset each time when it is probed? I right 
> now it seems to probe ok (it did not hang). I will trace back further


Yep


>>>>
>>>>>> Second please confirm if the timing you kill manually the user 
>>>>>> process has impact on whether you have a hang
>>>>>> on next plug back (if you kill before
>>>>>>
>>>>> *Scenario 0: Kill before plug back*
>>>>>
>>>>> 1. echo 1 > /sys/bus/pci/…/remove, would finish.
>>>>> But the application won’t exit until there is a kill signal.
>>>>
>>>>
>>>> Why you think it must exit ?
>>>>
>>> Because rocm will need to release the drm descriptor to 
>>> get amdgpu_amdkfd_device_fini_sw called, which would eventually call 
>>> kgd2kfd_device_exit called. This would clean up kfd_topology at 
>>> least. Otherwise I don’t see how it would be added back without 
>>> messing up kfd topology to say the least.
>>>
>>> However, those are all based my own observations. Please explain why 
>>> it does not need exit if you believe so?
>>
>>
>> Note that when you add back a new device, pci device and drm device 
>> are created, I am not an expert on KFD code but i believe also a new 
>> KFD device is created independent of the old one and so the topology 
>> should see just 2 device instances (one old zombie and one real 
>> new).  I know at least this wasn't an issue for the graphic stack in 
>> exact same scenario and the libdrm tests i pointed to test exact this 
>> scenario.
>>
> Yes, regardless of the OOPS in ttm_bo_cleanup_refs, I plugged back the 
> gpu, and I think it got probed all right, however the old kfd node is 
> still there.
> I can passed libdrm basic test suite on the plugged back. The bo test 
> hangs out-of-box even without hotplug (see dmesg below).
>
>  kernel:[ 1609.029125] watchdog: BUG: soft lockup - CPU#39 stuck for 
> 89s! [amdgpu_test:36407]
> [  +0.000407] Code: 48 89 47 18 48 89 47 20 48 89 47 28 48 89 47 30 48 
> 89 47 38 48 8d 7f 40 75 d9 90 c3 0f 1f 80 00 00 00 00 b9 00 10 00 00 
> 31 c0 <f3> aa c3 cc cc cc cc cc cc 0f 1f 44 00 00 48 85 ff 0f 84 f2 00 00
> [  +0.000856] RSP: 0018:ffffb996b57b3c40 EFLAGS: 00010246
> [  +0.000434] RAX: 0000000000000000 RBX: ffff9cc7f8706e88 RCX: 
> 0000000000000980
> [  +0.000436] RDX: fffff935b17d9140 RSI: fffff935b17e0000 RDI: 
> ffff9c831f645680
> [  +0.000439] RBP: 0000000000000400 R08: fffff935b17d0000 R09: 
> 0000000000000000
> [  +0.000447] R10: 0000000000000000 R11: 0000000000000000 R12: 
> 000000000000000a
> [  +0.000437] R13: ffff9cc783980a20 R14: 000000000b5dbc00 R15: 
> ffff9cc7f8706078
> [  +0.000438] FS:  00007ff1ef611300(0000) GS:ffff9d453efc0000(0000) 
> knlGS:0000000000000000
> [  +0.000445] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.000462] CR2: 00007f418bbb9320 CR3: 000000819fa84006 CR4: 
> 0000000000770ee0
> [  +0.000466] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
> 0000000000000000
> [  +0.000451] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
> 0000000000000400
> [  +0.000455] PKRU: 55555554
> [  +0.000451] Call Trace:
> [  +0.000448]  ttm_pool_free+0x110/0x230 [ttm]
> [  +0.000451]  ttm_tt_unpopulate+0x5e/0xb0 [ttm]
> [  +0.000454]  ttm_tt_destroy_common+0xe/0x30 [ttm]
> [  +0.000453]  amdgpu_ttm_backend_destroy+0x1e/0x70 [amdgpu]
> [  +0.000569]  ttm_bo_cleanup_memtype_use+0x37/0x60 [ttm]
> [  +0.000458]  ttm_bo_release+0x286/0x500 [ttm]
> [  +0.000450]  amdgpu_bo_unref+0x1a/0x30 [amdgpu]
> [  +0.000544]  amdgpu_gem_object_free+0xad/0x160 [amdgpu]
> [  +0.000534]  drm_gem_object_release_handle+0x6a/0x80 [drm]
> [  +0.000476]  drm_gem_handle_delete+0x5b/0xa0 [drm]
> [  +0.000465]  ? drm_gem_handle_create+0x40/0x40 [drm]
> [  +0.000469]  drm_ioctl_kernel+0xab/0xf0 [drm]
> [  +0.000458]  drm_ioctl+0x1ec/0x390 [drm]
> [  +0.000440]  ? drm_gem_handle_create+0x40/0x40 [drm]
> [  +0.000438]  ? selinux_file_ioctl+0x17d/0x220
> [  +0.000423]  ? lock_release+0x1ce/0x270
> [  +0.000416]  ? trace_hardirqs_on+0x1b/0xd0
> [  +0.000418]  ? _raw_spin_unlock_irqrestore+0x2d/0x40
> [  +0.000419]  amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
> [  +0.000499]  __x64_sys_ioctl+0x80/0xb0
> [  +0.000414]  do_syscall_64+0x3a/0x70
> [  +0.000400]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  +0.000387] RIP: 0033:0x7ff1ef7263db
> [  +0.000371] Code: 0f 1e fa 48 8b 05 b5 7a 0d 00 64 c7 00 26 00 00 00 
> 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 
> 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 85 7a 0d 00 f7 d8 64 89 01 48
> [  +0.000763] RSP: 002b:00007ffdf1cd0278 EFLAGS: 00000246 ORIG_RAX: 
> 0000000000000010
> [  +0.000386] RAX: ffffffffffffffda RBX: 00007ffdf1cd02b0 RCX: 
> 00007ff1ef7263db
> [  +0.000383] RDX: 00007ffdf1cd02b0 RSI: 0000000040086409 RDI: 
> 0000000000000007
> [  +0.000396] RBP: 0000000040086409 R08: 00005574eefd5c60 R09: 
> 00005574eefdd360
> [  +0.000391] R10: 00005574eefd4010 R11: 0000000000000246 R12: 
> 00005574eefd66d8
> [  +0.000386] R13: 0000000000000007 R14: 0000000000000000 R15: 
> 00007ff1ef830143
>
>
> I also tried to run tf benchmark to the newly plugged nodes (one of 
> the node is dummy), but failed.
> Can we have some confirmation from kfd team that they have considered 
> a zombie kfd node?
>
>> Also note that even with running grpahic stack there is always a KFD 
>> device and KFD topology present but of course probably not the same 
>> as when u run a KFD facing process so there could be some issues there.
>>
>> Also note that because of this patch 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=267d51d77fdae8708b94e1a24b8e5d961297edb7 
>> all MMIO accesses from such zombie/orphan user processes will be 
>> remapped to zero page and so will not necessarily experience a 
>> segfault when device removal happnes but rather maybe some crash due 
>> to NULL data read from MMIO by the process and used in some manner.
>>
> It depends on where the application is when the device is plugged out.
>
> For example, in one case, the application keeps saying out-of-memory, 
> but won’t exit.
> For one of the cases. The other case is that it would wait for a signal.
>
> 2022-04-18 12:42:38.939303: E 
> tensorflow/stream_executor/rocm/rocm_driver.cc:692 
> <https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Frocm_driver.cc%3A692%2F&data=04%7C01%7Candrey.grodzovsky%40amd.com%7C78c882de9193490a3b4408da21d8132d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637859509203317436%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=y%2Bkqeyw4HyTRWT3E5OHXbgUfSe3oDutSL0h4FNvjlIA%3D&reserved=0>] 
> failed to alloc 2304 bytes on host: HIP_ERROR_OutOfMemory
> 2022-04-18 12:42:38.939322: W 
> ./tensorflow/core/common_runtime/gpu/gpu_host_allocator.h:44] could 
> not allocate pinned host memory of size: 2304
> 2022-04-18 12:42:38.940772: E 
> tensorflow/stream_executor/rocm/rocm_driver.cc:692 
> <https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Frocm_driver.cc%3A692%2F&data=04%7C01%7Candrey.grodzovsky%40amd.com%7C78c882de9193490a3b4408da21d8132d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637859509203317436%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=y%2Bkqeyw4HyTRWT3E5OHXbgUfSe3oDutSL0h4FNvjlIA%3D&reserved=0>] 
> failed to alloc 2304 bytes on host: HIP_ERROR_OutOfMemory
> 2022-04-18 12:42:38.940791: W 
> ./tensorflow/core/common_runtime/gpu/gpu_host_allocator.h:44] could 
> not allocate pinned host memory of size: 2304
> 2022-04-18 12:42:38.942379: E 
> tensorflow/stream_executor/rocm/rocm_driver.cc:692 
> <https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Frocm_driver.cc%3A692%2F&data=04%7C01%7Candrey.grodzovsky%40amd.com%7C78c882de9193490a3b4408da21d8132d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637859509203317436%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=y%2Bkqeyw4HyTRWT3E5OHXbgUfSe3oDutSL0h4FNvjlIA%3D&reserved=0>] 
> failed to alloc 2304 bytes on host: HIP_ERROR_OutOfMemory
> 2022-04-18 12:42:38.942399: W 
> ./tensorflow/core/common_runtime/gpu/gpu_host_allocator.h:44] could 
> not allocate pinned host memory of size: 2304
> 2022-04-18 12:42:38.943829: E 
> tensorflow/stream_executor/rocm/rocm_driver.cc:692 
> <https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Frocm_driver.cc%3A692%2F&data=04%7C01%7Candrey.grodzovsky%40amd.com%7C78c882de9193490a3b4408da21d8132d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637859509203317436%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=y%2Bkqeyw4HyTRWT3E5OHXbgUfSe3oDutSL0h4FNvjlIA%3D&reserved=0>] 
> failed to alloc 2304 bytes on host: HIP_ERROR_OutOfMemory
> 2022-04-18 12:42:38.943849: W 
> ./tensorflow/core/common_runtime/gpu/gpu_host_allocator.h:44] could 
> not allocate pinned host memory of size: 2304
> 2022-04-18 12:42:38.945272: E 
> tensorflow/stream_executor/rocm/rocm_driver.cc:692 
> <https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Frocm_driver.cc%3A692%2F&data=04%7C01%7Candrey.grodzovsky%40amd.com%7C78c882de9193490a3b4408da21d8132d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637859509203317436%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=y%2Bkqeyw4HyTRWT3E5OHXbgUfSe3oDutSL0h4FNvjlIA%3D&reserved=0>] 
> failed to alloc 2304 bytes on host: HIP_ERROR_OutOfMemory
> 2022-04-18 12:42:38.945292: W 
> ./tensorflow/core/common_runtime/gpu/gpu_host_allocator.h:44] could 
> not allocate pinned host memory of size: 2304
>
>>
>>>>>
>>>>> 2. kill the the process. The application does several things and 
>>>>> seems trigger drm_release in the kernel, which are met with kernel 
>>>>> NULL pointer deference related to sysfs_remove. Then the whole fs 
>>>>> just freeze.
>>>>>
>>>>> [  +0.002498] BUG: kernel NULL pointer dereference, address: 
>>>>> 0000000000000098
>>>>> [  +0.000486] #PF: supervisor read access in kernel mode
>>>>> [  +0.000545] #PF: error_code(0x0000) - not-present page
>>>>> [  +0.000551] PGD 0 P4D 0
>>>>> [  +0.000553] Oops: 0000 [#1] SMP NOPTI
>>>>> [  +0.000540] CPU: 75 PID: 4911 Comm: kworker/75:2 Tainted: G    W 
>>>>>   E     5.13.0-kfd #1
>>>>> [  +0.000559] Hardware name: INGRASYS         TURING  /MB  , BIOS 
>>>>> K71FQ28A 10/05/2021
>>>>> [  +0.000567] Workqueue: events delayed_fput
>>>>> [  +0.000563] RIP: 0010:kernfs_find_ns+0x1b/0x100
>>>>> [  +0.000569] Code: ff ff e8 88 59 9f 00 0f 1f 84 00 00 00 00 00 
>>>>> 0f 1f 44 00 00 41 57 8b 05 df f0 7b 01 41 56 41 55 49 89 f5 41 54 
>>>>> 55 48 89 fd 53 <44> 0f b7 b7 98 00 00 00 48 89 d3 4c 8b 67 70 66 
>>>>> 41 83 e6 20 41 0f
>>>>> [  +0.001193] RSP: 0018:ffffb9875db5fc98 EFLAGS: 00010246
>>>>> [  +0.000602] RAX: 0000000000000000 RBX: ffffa101f79507d8 RCX: 
>>>>> 0000000000000000
>>>>> [  +0.000612] RDX: 0000000000000000 RSI: ffffffffc09a9417 RDI: 
>>>>> 0000000000000000
>>>>> [  +0.000604] RBP: 0000000000000000 R08: 0000000000000001 R09: 
>>>>> 0000000000000000
>>>>> [  +0.000760] R10: ffffb9875db5fcd0 R11: 0000000000000000 R12: 
>>>>> 0000000000000000
>>>>> [  +0.000597] R13: ffffffffc09a9417 R14: ffffa08363fb2d18 R15: 
>>>>> 0000000000000000
>>>>> [  +0.000702] FS:  0000000000000000(0000) 
>>>>> GS:ffffa0ffbfcc0000(0000) knlGS:0000000000000000
>>>>> [  +0.000666] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> [  +0.000658] CR2: 0000000000000098 CR3: 0000005747812005 CR4: 
>>>>> 0000000000770ee0
>>>>> [  +0.000715] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
>>>>> 0000000000000000
>>>>> [  +0.000655] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
>>>>> 0000000000000400
>>>>> [  +0.000592] PKRU: 55555554
>>>>> [  +0.000580] Call Trace:
>>>>> [  +0.000591]  kernfs_find_and_get_ns+0x2f/0x50
>>>>> [  +0.000584]  sysfs_remove_file_from_group+0x20/0x50
>>>>> [  +0.000580]  amdgpu_ras_sysfs_remove+0x3d/0xd0 [amdgpu]
>>>>> [  +0.000737]  amdgpu_ras_late_fini+0x1d/0x40 [amdgpu]
>>>>> [  +0.000750]  amdgpu_sdma_ras_fini+0x96/0xb0 [amdgpu]
>>>>> [  +0.000742]  ? gfx_v10_0_resume+0x10/0x10 [amdgpu]
>>>>> [  +0.000738]  sdma_v4_0_sw_fini+0x23/0x90 [amdgpu]
>>>>> [  +0.000717]  amdgpu_device_fini_sw+0xae/0x260 [amdgpu]
>>>>> [  +0.000704]  amdgpu_driver_release_kms+0x12/0x30 [amdgpu]
>>>>> [  +0.000687]  drm_dev_release+0x20/0x40 [drm]
>>>>> [  +0.000583]  drm_release+0xa8/0xf0 [drm]
>>>>> [  +0.000584]  __fput+0xa5/0x250
>>>>> [  +0.000621]  delayed_fput+0x1f/0x30
>>>>> [  +0.000726]  process_one_work+0x26e/0x580
>>>>> [  +0.000581]  ? process_one_work+0x580/0x580
>>>>> [  +0.000611]  worker_thread+0x4d/0x3d0
>>>>> [  +0.000611]  ? process_one_work+0x580/0x580
>>>>> [  +0.000605]  kthread+0x117/0x150
>>>>> [  +0.000611]  ? kthread_park+0x90/0x90
>>>>> [  +0.000619]  ret_from_fork+0x1f/0x30
>>>>> [  +0.000625] Modules linked in: amdgpu(E) xt_conntrack 
>>>>> xt_MASQUERADE nfnetlink xt_addrtype iptable_filter iptable_nat 
>>>>> nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter 
>>>>> x86_pkg_temp_thermal cdc_ether usbnet acpi_pad msr ip_tables 
>>>>> x_tables ast drm_vram_helper iommu_v2 drm_ttm_helper gpu_sched ttm 
>>>>> drm_kms_helper cfbfillrect syscopyarea cfbimgblt sysfillrect 
>>>>> sysimgblt fb_sys_fops cfbcopyarea drm drm_panel_orientati
>>>>> on_quirks [last unloaded: amdgpu]
>>>>
>>>>
>>>> This is a known regression, all SYSFS components must be removed 
>>>> before pci_remove code runs otherwise you get either warnings for 
>>>> single file removals or
>>>> OOPSEs for sysfs gorup removals like here. Please try to move 
>>>> amdgpu_ras_sysfs_remove from amdgpu_ras_late_fini to the end of 
>>>> amdgpu_ras_pre_fini (which happens before pci remove)
>>>>
>>>>
>>>
>>> I fixed it in the newer patch, please see it below.
>>
>>
>>
>>> I first plugout the device, then kill the rocm user process. Then it 
>>> has other OOPSES related to ttm_bo_cleanup_refs.
>>>
>>> [  +0.000006] BUG: kernel NULL pointer dereference, address: 
>>> 0000000000000010
>>> [  +0.000349] #PF: supervisor read access in kernel mode
>>> [  +0.000340] #PF: error_code(0x0000) - not-present page
>>> [  +0.000341] PGD 0 P4D 0
>>> [  +0.000336] Oops: 0000 [#1] SMP NOPTI
>>> [  +0.000345] CPU: 9 PID: 95 Comm: kworker/9:1 Tainted: G        W   
>>> E     5.13.0-kfd #1
>>> [  +0.000367] Hardware name: INGRASYS         TURING  /MB      , 
>>> BIOS K71FQ28A 10/05/2021
>>> [  +0.000376] Workqueue: events delayed_fput
>>> [  +0.000422] RIP: 0010:ttm_resource_free+0x24/0x40 [ttm]
>>> [  +0.000464] Code: 00 00 0f 1f 40 00 0f 1f 44 00 00 53 48 89 f3 48 
>>> 8b 36 48 85 f6 74 21 48 8b 87 28 02 00 00 48 63 56 10 48 8b bc d0 b8 
>>> 00 00 00 <48> 8b 47 10 ff 50 08 48 c7 03 00 00 00 00 5b c3 66 66 2e 
>>> 0f 1f 84
>>> [  +0.001009] RSP: 0018:ffffb21c59413c98 EFLAGS: 00010282
>>> [  +0.000515] RAX: ffff8b1aa4285f68 RBX: ffff8b1a823b5ea0 RCX: 
>>> 00000000002a000c
>>> [  +0.000536] RDX: 0000000000000000 RSI: ffff8b1acb84db80 RDI: 
>>> 0000000000000000
>>> [  +0.000539] RBP: 0000000000000001 R08: 0000000000000000 R09: 
>>> ffffffffc03c3e00
>>> [  +0.000543] R10: 0000000000000000 R11: 0000000000000000 R12: 
>>> ffff8b1a823b5ec8
>>> [  +0.000542] R13: 0000000000000000 R14: ffff8b1a823b5d90 R15: 
>>> ffff8b1a823b5ec8
>>> [  +0.000544] FS:  0000000000000000(0000) GS:ffff8b187f440000(0000) 
>>> knlGS:0000000000000000
>>> [  +0.000559] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  +0.000575] CR2: 0000000000000010 CR3: 00000076e6812004 CR4: 
>>> 0000000000770ee0
>>> [  +0.000575] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
>>> 0000000000000000
>>> [  +0.000579] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
>>> 0000000000000400
>>> [  +0.000575] PKRU: 55555554
>>> [  +0.000568] Call Trace:
>>> [  +0.000567]  ttm_bo_cleanup_refs+0xe4/0x290 [ttm]
>>> [  +0.000588]  ttm_bo_delayed_delete+0x147/0x250 [ttm]
>>> [  +0.000589]  ttm_device_fini+0xad/0x1b0 [ttm]
>>> [  +0.000590]  amdgpu_ttm_fini+0x2a7/0x310 [amdgpu]
>>> [  +0.000730]  gmc_v9_0_sw_fini+0x3a/0x40 [amdgpu]
>>> [  +0.000753]  amdgpu_device_fini_sw+0xae/0x260 [amdgpu]
>>> [  +0.000734]  amdgpu_driver_release_kms+0x12/0x30 [amdgpu]
>>> [  +0.000737]  drm_dev_release+0x20/0x40 [drm]
>>> [  +0.000626]  drm_release+0xa8/0xf0 [drm]
>>> [  +0.000625]  __fput+0xa5/0x250
>>> [  +0.000606]  delayed_fput+0x1f/0x30
>>> [  +0.000607]  process_one_work+0x26e/0x580
>>> [  +0.000608]  ? process_one_work+0x580/0x580
>>> [  +0.000616]  worker_thread+0x4d/0x3d0
>>> [  +0.000614]  ? process_one_work+0x580/0x580
>>> [  +0.000617]  kthread+0x117/0x150
>>> [  +0.000615]  ? kthread_park+0x90/0x90
>>> [  +0.000621]  ret_from_fork+0x1f/0x30
>>> [  +0.000603] Modules linked in: amdgpu(E) xt_conntrack 
>>> xt_MASQUERADE nfnetlink xt_addrtype iptable_filter iptable_nat 
>>> nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter 
>>> x86_pkg_temp_thermal cdc_ether usbnet acpi_pad msr ip_tables 
>>> x_tables ast drm_vram_helper drm_ttm_helper iommu_v2 ttm gpu_sched 
>>> drm_kms_helper cfbfillrect syscopyarea cfbimgblt sysfillrect 
>>> sysimgblt fb_sys_fops cfbcopyarea drm drm_panel_orientation_quirks 
>>> [last unloaded: amdgpu]
>>> [  +0.002840] CR2: 0000000000000010
>>> [  +0.000755] ---[ end trace 9737737402551e39 ]--
>>
>>
>> This looks like another regression - try seeing where is the NULL 
>> reference and then we can see how to avoid this.
>>
>>
> Those are the line of code.
>
> (gdb) l *(ttm_bo_cleanup_refs+0xe4)
> 0x19c4 is in ttm_bo_cleanup_refs (drivers/gpu/drm/ttm/ttm_bo.c:360).
> 355             ttm_bo_move_to_pinned(bo);
> 356             list_del_init(&bo->ddestroy);
> 357             spin_unlock(&bo->bdev->lru_lock);
> 358 ttm_bo_cleanup_memtype_use(bo);
> 359
> 360             if (unlock_resv)
> 361 dma_resv_unlock(amdkcl_ttm_resvp(bo));
> 362
> 363             ttm_bo_put(bo);
> 364
> (gdb) l *(ttm_resource_free+0x24)
> 0x57f4 is in ttm_resource_free (drivers/gpu/drm/ttm/ttm_resource.c:65).
> 60
> 61              if (!*res)
> 62                      return;
> 63
> 64              man = ttm_manager_type(bo->bdev, (*res)->mem_type);
> 65  man->func->free(man, *res);
> 66              *res = NULL;
> 67      }
> 68      EXPORT_SYMBOL(ttm_resource_free);
> 69
>>>
>>>>>
>>>>> 3.  echo 1 > /sys/bus/pci/rescan. This would just hang. I assume 
>>>>> the sysfs is broken.
>>>>>
>>>>> Based on 1 & 2, it seems that 1 won’t let the amdgpu exit 
>>>>> gracefully, because 2 will do some cleanup maybe should have 
>>>>> happened before 1.
>>>>>>
>>>>>> or you kill after plug back does it makes a difference).
>>>>>>
>>>>> *Scenario 2: Kill after plug back*
>>>>>
>>>>> If I perform rescan before kill, then the driver seemed probed 
>>>>> fine. But kill will have the same issue which messed up the sysfs 
>>>>> the same way as in Scenario 2.
>>>>>
>>>>>
>>>>> *Final Comments:*
>>>>>
>>>>> 0. cancel_delayed_work_sync(&p_info->restore_userptr_work) 
>>>>> would make the repletion of amdgpu_vm_bo_update failure go away, 
>>>>> but it does not solve the issues in those scenarios.
>>>>
>>>>
>>>> Still - it's better to do it this way even for those failures to go 
>>>> awaya
>>>>
>>>>
>>> Cancel_delayed_work is insufficient, you will need to make sure the 
>>> work won’t be processed after plugout. Please see my patch
>>
>>
>> Saw, see my comment.
>>
>>
>>>>
>>>>>
>>>>> 1. For planned hotplug, this patch should work as long as you 
>>>>> follow some protocol, i.e. kill before plugout. Is this patch an 
>>>>> acceptable one since it provides some added feature than before?
>>>>
>>>>
>>>> Let's try to fix more as I advised above.
>>>>
>>>>
>>>>>
>>>>> 2. For unplanned hotplug when there is rocm app running, the patch 
>>>>> that kill all processes and wait for 5 sec would work 
>>>>> consistently. But it seems that it is an unacceptable solution for 
>>>>> official release. I can hold it for our own internal usage.  It 
>>>>> seems that kill after removal would cause problems, and I don’t 
>>>>> know if there is a quick fix by me because of my limited 
>>>>> understanding of the amdgpu driver. Maybe AMD could have a quick 
>>>>> fix; Or it is really a difficult one. This feature may or may not 
>>>>> be a blocking issue in our GPU disaggregation research down the 
>>>>> way. Please let us know for either cases, and we would like to 
>>>>> learn and help as much as we could!
>>>>
>>>>
>>>> I am currently not sure why it helps. I will need to setup my own 
>>>> ROCm setup and retest hot plug to check this in more depth but 
>>>> currently i have higher priorities. Please try to confirm ASIC 
>>>> reset always takes place on plug back
>>>> and fix the sysfs OOPs as I advised above to clear up at least some 
>>>> of the issues. Also please describe to me exactly what you steps to 
>>>> reproduce this scenario so later I might be able to do it myself.
>>>>
>>>>
>>> I can still try to help to fix the bug in my spare time. My setup is 
>>> as follows
>>>
>>>  1. I have a server with 4 AMD MI100 GPUs. I think 1 GPU would also
>>>     work.
>>>  2. I used the
>>>     https://github.com/RadeonOpenCompute/ROCK-Kernel-Driver/tree/roc-5.0.x
>>>     <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Ftree%2Froc-5.0.x&data=04%7C01%7Candrey.grodzovsky%40amd.com%7C78c882de9193490a3b4408da21d8132d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637859509203317436%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=7evLdVmTyf7MAADp0k4Gkjl1KwNYqMfqYTJiZbSr8tk%3D&reserved=0> as
>>>     the starting point, and apply Mukul’s patch and my patch.
>>>  3. Then I run a tensorflow benchmark from a docker.
>>>       * docker run -it --device=/dev/kfd --device=/dev/dri
>>>         --group-add video rocm/tensorflow:rocm4.5.2-tf1.15-dev
>>>       * And run the following benchmark in the docker:  python
>>>         benchmarks/scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py
>>>         --num_gpus=4 --batch_size=32 --model=resnet50
>>>         --variable_update=parameter_server
>>>           o Might to need to adjust num_gpus parameter based on your
>>>             setup
>>>  4. Remove a GPU at random time.
>>>  5. Do whatever is needed to before plugback and reverify the
>>>     benchmark can still run.
>>>
>>>> Also, we have hotplug test suite in libdrm (graphic stack), so 
>>>> maybe u can install libdrm and run that test suite to see if it 
>>>> exposes more issues.
>>>>
>>> OK I could try it some time.
>>>
>
> I tried suite 13, the hotplugout test, but it says it got killed? 
> There are a some oops from dmesg during ttm_pool_free_page.
>
> Userspace log:
>
> $ sudo ./tests/amdgpu/amdgpu_test -f -s 13
>
>
> The ASIC NOT support UVD, suite disabled
>
>
> The ASIC NOT support VCE, suite disabled
>
>
> The ASIC NOT support UVD ENC, suite disabled.
>
>
> Don't support TMZ (trust memory zone), security suite disabled
>
>
>      CUnit - A unit testing framework for C - Version 2.1-3
> http://cunit.sourceforge.net/ 
> <https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fcunit.sourceforge.net%2F&data=04%7C01%7Candrey.grodzovsky%40amd.com%7C78c882de9193490a3b4408da21d8132d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637859509203317436%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=Y%2F6RnXqHvigeTXjCIJDEsslzNm0mtTOhsftckL2WGaI%3D&reserved=0>
>
>
> Suite: Hotunplug Tests
>   Test: Unplug card and rescan the bus to plug it back …Killed
>
> Dmesg log:
> [  +0.000479] BUG: unable to handle page fault for address: 
> ffffc01343fc81b4
> [  +0.000054] #PF: supervisor write access in kernel mode
> [  +0.000033] #PF: error_code(0x0002) - not-present page
> [  +0.000032] PGD 807ffc1067 P4D 807ffc1067 PUD 807ffc0067 PMD 0
> [  +0.000038] Oops: 0002 [#1] SMP NOPTI
> [  +0.000025] CPU: 92 PID: 7534 Comm: amdgpu_test Tainted: G        W 
>   E     5.13.0-kfd #1
> [  +0.000048] Hardware name: INGRASYS         TURING  /MB      , BIOS 
> K71FQ28A 10/05/2021
> [  +0.000045] RIP: 0010:__free_pages+0xc/0x80
> [  +0.000031] Code: 01 00 74 0f 0f b6 77 51 85 f6 74 07 31 d2 e9 3b dc 
> ff ff e9 66 ff ff ff 66 0f 1f 44 00 00 0f 1f 44 00 00 41 54 55 48 89 
> fd 53 <f0> ff 4f 34 74 46 48 8b 07 a9 00 00 01 00 75 54 44 8d 66 ff 85 f6
> [  +0.000103] RSP: 0018:ffff96f71ba6fd60 EFLAGS: 00010246
> [  +0.000032] RAX: 00000000ffffffff RBX: ffff89f1ccf86078 RCX: 
> 0000000003fc8180
> [  +0.000041] RDX: ffff89f1b4746000 RSI: 0000000000000000 RDI: 
> ffffc01343fc8180
> [  +0.000042] RBP: ffffc01343fc8180 R08: 0000000000000000 R09: 
> 0000000000000246
> [  +0.000040] R10: 00000080b4746fff R11: 0000000000000003 R12: 
> 0000000000000000
> [  +0.000041] R13: ffff89f1ccf85f80 R14: ffff89f1ccf86ef8 R15: 
> ffff8972293b0000
> [  +0.000042] FS:  00007fcfb843a300(0000) GS:ffff89ef80100000(0000) 
> knlGS:0000000000000000
> [  +0.000046] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.000033] CR2: ffffc01343fc81b4 CR3: 0000000178154006 CR4: 
> 0000000000770ee0
> [  +0.000041] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
> 0000000000000000
> [  +0.000041] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
> 0000000000000400
> [  +0.000041] PKRU: 55555554
> [  +0.000017] Call Trace:
> [  +0.000018]  ttm_pool_free_page+0x69/0x90 [ttm]
> [  +0.000038]  ttm_pool_type_fini+0x58/0x70 [ttm]
> [  +0.000034]  ttm_pool_fini+0x30/0x50 [ttm]
> [  +0.000031]  ttm_device_fini+0xf3/0x1b0 [ttm]
> [  +0.000032]  amdgpu_ttm_fini+0x2a7/0x310 [amdgpu]
> [  +0.000265]  gmc_v9_0_sw_fini+0x3a/0x40 [amdgpu]
> [  +0.000246]  amdgpu_device_fini_sw+0xae/0x260 [amdgpu]
> [  +0.000219]  amdgpu_driver_release_kms+0x12/0x30 [amdgpu]
> [  +0.000219]  drm_dev_release+0x20/0x40 [drm]
> [  +0.000059]  drm_release+0xa8/0xf0 [drm]
> [  +0.000053]  __fput+0xa5/0x250
> [  +0.000023]  task_work_run+0x5c/0xa0
> [  +0.000026]  exit_to_user_mode_prepare+0x1db/0x1e0
> [  +0.000033]  syscall_exit_to_user_mode+0x19/0x50
> [  +0.000030]  do_syscall_64+0x47/0x70
> [  +0.000018]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  +0.000025] RIP: 0033:0x7fcfb86403d7
> [  +0.000869] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 
> 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 
> 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 f3 fb ff ff
> [  +0.001788] RSP: 002b:00007ffc8fc26c28 EFLAGS: 00000246 ORIG_RAX: 
> 0000000000000003
> [  +0.000888] RAX: 0000000000000000 RBX: 000055d67a05b6a0 RCX: 
> 00007fcfb86403d7
> [  +0.000867] RDX: 00007fcfb8627be0 RSI: 0000000000000000 RDI: 
> 0000000000000003
> [  +0.000846] RBP: 000055d67a05b8a0 R08: 0000000000000007 R09: 
> 0000000000000000
> [  +0.000816] R10: 0000000000000000 R11: 0000000000000246 R12: 
> 0000000000000000
> [  +0.000791] R13: 0000000000000000 R14: 0000000000000000 R15: 
> 00007fcfb8659143
> [  +0.000770] Modules linked in: amdgpu(E) xt_conntrack xt_MASQUERADE 
> nfnetlink xt_addrtype iptable_filter iptable_nat nf_nat nf_conntrack 
> nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter x86_pkg_temp_thermal 
> cdc_ether usbnet acpi_pad msr ip_tables x_tables ast drm_vram_helper 
> drm_ttm_helper ttm iommu_v2 gpu_sched drm_kms_helper cfbfillrect 
> syscopyarea cfbimgblt sysfillrect sysimgblt fb_sys_fops cfbcopyarea 
> drm drm_panel_orientation_quirks [last unloaded: amdgpu]
> [  +0.003303] CR2: ffffc01343fc81b4
> [  +0.000799] ---[ end trace 2360927435b19009 ]—
>
>
>
>>> The following is the new diff.
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index 182b7eae598a..48c3cd4054de 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -1327,7 +1327,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>>>   * ASICs macro.
>>>   */
>>>  #define amdgpu_asic_set_vga_state(adev, state) 
>>> (adev)->asic_funcs->set_vga_state((adev), (state))
>>> -#define amdgpu_asic_reset(adev) (adev)->asic_funcs->reset((adev))
>>> +#define amdgpu_asic_reset(adev) ({int r; pr_info("performing 
>>> amdgpu_asic_reset\n"); r = (adev)->asic_funcs->reset((adev));r;})
>>>  #define amdgpu_asic_reset_method(adev) 
>>> (adev)->asic_funcs->reset_method((adev))
>>>  #define amdgpu_asic_get_xclk(adev) (adev)->asic_funcs->get_xclk((adev))
>>>  #define amdgpu_asic_set_uvd_clocks(adev, v, d) 
>>> (adev)->asic_funcs->set_uvd_clocks((adev), (v), (d))
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> index 27c74fcec455..842abd7150a6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> @@ -134,6 +134,7 @@ struct amdkfd_process_info {
>>> /* MMU-notifier related fields */
>>> atomic_t evicted_bos;
>>> +atomic_t invalid;
>>> struct delayed_work restore_userptr_work;
>>> struct pid *pid;
>>>  };
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index 99d2b15bcbf3..2a588eb9f456 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -1325,6 +1325,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, 
>>> void **process_info,
>>> info->pid = get_task_pid(current->group_leader, PIDTYPE_PID);
>>> atomic_set(&info->evicted_bos, 0);
>>> +atomic_set(&info->invalid, 0);
>>> INIT_DELAYED_WORK(&info->restore_userptr_work,
>>>  amdgpu_amdkfd_restore_userptr_worker);
>>> @@ -2693,6 +2694,9 @@ static void 
>>> amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>>> struct mm_struct *mm;
>>> int evicted_bos;
>>> +if (atomic_read(&process_info->invalid))
>>> +return;
>>> +
>>
>>
>> Probably better  to again use drm_dev_enter/exit guard pair instead 
>> of this flag.
>>
>>
>
> I don’t know if I could use drm_dev_enter/exit efficiently because a 
> process can have multiple drm_dev open. And I don’t know how I can 
> recover/refer drm_dev(s) efficiently in the worker function in order 
> to use drm_dev_enter/exit.


I think that within the KFD code each kfd device belongs or points to 
one specific drm_device so I don't think this is a problem.


>>
>>> evicted_bos = atomic_read(&process_info->evicted_bos);
>>> if (!evicted_bos)
>>> return;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index ec38517ab33f..e7d85d8d282d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -1054,6 +1054,7 @@ void 
>>> amdgpu_device_program_register_sequence(struct amdgpu_device *adev,
>>>   */
>>>  void amdgpu_device_pci_config_reset(struct amdgpu_device *adev)
>>>  {
>>> +pr_debug("%s called\n",__func__);
>>> pci_write_config_dword(adev->pdev, 0x7c, AMDGPU_ASIC_RESET_DATA);
>>>  }
>>> @@ -1066,6 +1067,7 @@ void amdgpu_device_pci_config_reset(struct 
>>> amdgpu_device *adev)
>>>   */
>>>  int amdgpu_device_pci_reset(struct amdgpu_device *adev)
>>>  {
>>> +pr_debug("%s called\n",__func__);
>>> return pci_reset_function(adev->pdev);
>>>  }
>>> @@ -4702,6 +4704,8 @@ int amdgpu_do_asic_reset(struct list_head 
>>> *device_list_handle,
>>> bool need_full_reset, skip_hw_reset, vram_lost = false;
>>> int r = 0;
>>> +pr_debug("%s called\n",__func__);
>>> +
>>> /* Try reset handler method first */
>>> tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
>>>  reset_list);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> index 49bdf9ff7350..b469acb65c1e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> @@ -2518,7 +2518,6 @@ void amdgpu_ras_late_fini(struct amdgpu_device 
>>> *adev,
>>> if (!ras_block || !ih_info)
>>> return;
>>> -amdgpu_ras_sysfs_remove(adev, ras_block);
>>> if (ih_info->cb)
>>> amdgpu_ras_interrupt_remove_handler(adev, ih_info);
>>>  }
>>> @@ -2577,6 +2576,7 @@ void amdgpu_ras_suspend(struct amdgpu_device 
>>> *adev)
>>>  int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
>>>  {
>>> struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>>> +struct ras_manager *obj, *tmp;
>>> if (!adev->ras_enabled || !con)
>>> return 0;
>>> @@ -2585,6 +2585,13 @@ int amdgpu_ras_pre_fini(struct amdgpu_device 
>>> *adev)
>>> /* Need disable ras on all IPs here before ip [hw/sw]fini */
>>> amdgpu_ras_disable_all_features(adev, 0);
>>> amdgpu_ras_recovery_fini(adev);
>>> +
>>> +/* remove sysfs before pci_remove to avoid OOPSES from 
>>> sysfs_remove_groups */
>>> +list_for_each_entry_safe(obj, tmp, &con->head, node) {
>>> +amdgpu_ras_sysfs_remove(adev, &obj->head);
>>> +put_obj(obj);
>>> +}
>>> +
>>> return 0;
>>>  }
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> index 4e7d9cb09a69..0fa806a78e39 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> @@ -693,16 +693,35 @@ bool kfd_is_locked(void)
>>>  void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm, bool force)
>>>  {
>>> +struct kfd_process *p;
>>> +struct amdkfd_process_info *p_info;
>>> +unsigned int temp;
>>> +
>>> if (!kfd->init_complete)
>>> return;
>>> /* for runtime suspend, skip locking kfd */
>>> -if (!run_pm) {
>>> +if (!run_pm && !drm_dev_is_unplugged(kfd->ddev)) {
>>> /* For first KFD device suspend all the KFD processes */
>>> if (atomic_inc_return(&kfd_locked) == 1)
>>> kfd_suspend_all_processes(force);
>>> }
>>> +if (drm_dev_is_unplugged(kfd->ddev)){
>>> +int idx = srcu_read_lock(&kfd_processes_srcu);
>>> +pr_debug("cancel restore_userptr_wor\n");
>>> +hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>>> +if ( kfd_process_gpuidx_from_gpuid(p, kfd->id) >= 0 ) {
>>> +p_info = p->kgd_process_info;
>>> +pr_debug("cancel processes, pid = %d for gpu_id = %d", 
>>> pid_nr(p_info->pid), kfd->id);
>>> +cancel_delayed_work_sync(&p_info->restore_userptr_work);
>>> +/* block all future restore_userptr_work */
>>> +atomic_inc(&p_info->invalid);
>>
>>
>> Same as i mentioned above with drm.dev_eneter/exit
>>
> Same as I mentioned as the process can have many drm_dev open.
>
> Final comments:
>
> I suspect that the my linux kernel version might not have all the 
> fixes you did for hotplug. Can you give me a pointer to the lowest 
> version of linux kernel (5.14 from linux kernel repo? 
> amd-drm-staging-next does not work for MI100 out-of-box), which would 
> pass all libdrm tests including hotplug tests (some tests hang, some 
> failed now) ?


That a problem, latest working baseline I tested and confirmed passing 
hotplug tests is this branch and commit 
https://gitlab.freedesktop.org/agd5f/linux/-/commit/86e12a53b73135806e101142e72f3f1c0e6fa8e6 
which is amd-staging-drm-next. 5.14 was the branch we ups-reamed the 
hotplug code but it had a lot of regressions over time due to new 
changes (that why I added the hotplug test to try and catch them early). 
It would be best to run this branch on mi-100 so we have a clean 
baseline and only after confirming  this particular branch from this 
commits passes libdrm tests only then start adding the KFD specific 
addons. Another option if you can't work with MI-100 and this branch is 
to try a different ASIC that does work with this branch (if possible).

Andrey


> p.s. I cloned and build libdrm from source 
> (https://gitlab.freedesktop.org/mesa/drm 
> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fmesa%2Fdrm&data=04%7C01%7Candrey.grodzovsky%40amd.com%7C78c882de9193490a3b4408da21d8132d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637859509203317436%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=k%2FqmPOyW%2BnIStUdJZqlBHPXDU6AaXGKGS0GKH34r7Mc%3D&reserved=0>)
>
> Thank you so much!
>
>> Andrey
>>
>>
>>> +}
>>> +}
>>> +srcu_read_unlock(&kfd_processes_srcu, idx);
>>> +}
>>> +
>>> kfd->dqm->ops.stop(kfd->dqm);
>>> kfd_iommu_suspend(kfd);
>>>  }
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> index 600ba2a728ea..7e3d1848eccc 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> @@ -669,11 +669,12 @@ static void kfd_remove_sysfs_node_entry(struct 
>>> kfd_topology_device *dev)
>>>  #ifdef HAVE_AMD_IOMMU_PC_SUPPORTED
>>> if (dev->kobj_perf) {
>>> list_for_each_entry(perf, &dev->perf_props, list) {
>>> +sysfs_remove_group(dev->kobj_perf, perf->attr_group);
>>> kfree(perf->attr_group);
>>> perf->attr_group = NULL;
>>> }
>>> kobject_del(dev->kobj_perf);
>>> -kobject_put(dev->kobj_perf);
>>> +/* kobject_put(dev->kobj_perf); */
>>> dev->kobj_perf = NULL;
>>> }
>>>  #endif
>>>
>>> Thank you so much! Looking forward to your comments!
>>>
>>> Regards,
>>> Shuotao
>>>>
>>>> Andrey
>>>>
>>>>
>>>>>
>>>>> Thank you so much!
>>>>>
>>>>> Best regards,
>>>>> Shuotao
>>>>>>
>>>>>> Andrey
>>>>>>
>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>> index 8fa9b86ac9d2..c0b27f722281 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>> @@ -188,6 +188,12 @@ void amdgpu_amdkfd_interrupt(struct 
>>>>>>> amdgpu_device *adev,
>>>>>>> kgd2kfd_interrupt(adev->kfd.dev, ih_ring_entry);
>>>>>>>  }
>>>>>>> +void amdgpu_amdkfd_kill_all_processes(struct amdgpu_device *adev)
>>>>>>> +{
>>>>>>> +if (adev->kfd.dev)
>>>>>>> +kgd2kfd_kill_all_user_processes(adev->kfd.dev);
>>>>>>> +}
>>>>>>> +
>>>>>>>  void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm)
>>>>>>>  {
>>>>>>> if (adev->kfd.dev)
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>>>> index 27c74fcec455..f4e485d60442 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>>>> @@ -141,6 +141,7 @@ struct amdkfd_process_info {
>>>>>>>  int amdgpu_amdkfd_init(void);
>>>>>>>  void amdgpu_amdkfd_fini(void);
>>>>>>> +void amdgpu_amdkfd_kill_all_processes(struct amdgpu_device *adev);
>>>>>>>  void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool 
>>>>>>> run_pm);
>>>>>>>  int amdgpu_amdkfd_resume_iommu(struct amdgpu_device *adev);
>>>>>>>  int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool 
>>>>>>> run_pm, bool sync);
>>>>>>> @@ -405,6 +406,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>>>>>>> const struct kgd2kfd_shared_resources *gpu_resources);
>>>>>>>  void kgd2kfd_device_exit(struct kfd_dev *kfd);
>>>>>>>  void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm, bool force);
>>>>>>> +void kgd2kfd_kill_all_user_processes(struct kfd_dev *kfd);
>>>>>>>  int kgd2kfd_resume_iommu(struct kfd_dev *kfd);
>>>>>>>  int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm, bool sync);
>>>>>>>  int kgd2kfd_pre_reset(struct kfd_dev *kfd);
>>>>>>> @@ -443,6 +445,9 @@ static inline void kgd2kfd_suspend(struct 
>>>>>>> kfd_dev *kfd, bool run_pm, bool force)
>>>>>>>  {
>>>>>>>  }
>>>>>>> +void kgd2kfd_kill_all_user_processes(struct kfd_dev *kfd){
>>>>>>> +}
>>>>>>> +
>>>>>>>  static int __maybe_unused kgd2kfd_resume_iommu(struct kfd_dev *kfd)
>>>>>>>  {
>>>>>>> return 0;
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>>> index 3d5fc0751829..af6fe5080cfa 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>>> @@ -2101,6 +2101,9 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>>>>>>>  {
>>>>>>> struct drm_device *dev = pci_get_drvdata(pdev);
>>>>>>> +/* kill all kfd processes before drm_dev_unplug */
>>>>>>> +amdgpu_amdkfd_kill_all_processes(drm_to_adev(dev));
>>>>>>> +
>>>>>>>  #ifdef HAVE_DRM_DEV_UNPLUG
>>>>>>> drm_dev_unplug(dev);
>>>>>>>  #else
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>> index 5504a18b5a45..480c23bef5e2 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>> @@ -691,6 +691,12 @@ bool kfd_is_locked(void)
>>>>>>> return  (atomic_read(&kfd_locked) > 0);
>>>>>>>  }
>>>>>>> +inline void kgd2kfd_kill_all_user_processes(struct kfd_dev* dev)
>>>>>>> +{
>>>>>>> +kfd_kill_all_user_processes();
>>>>>>> +}
>>>>>>> +
>>>>>>> +
>>>>>>>  void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm, bool force)
>>>>>>>  {
>>>>>>> if (!kfd->init_complete)
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>>>> index 55c9e1922714..a35a2cb5bb9f 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>>>> @@ -1064,6 +1064,7 @@ static inline struct kfd_process_device 
>>>>>>> *kfd_process_device_from_gpuidx(
>>>>>>>  void kfd_unref_process(struct kfd_process *p);
>>>>>>>  int kfd_process_evict_queues(struct kfd_process *p, bool force);
>>>>>>>  int kfd_process_restore_queues(struct kfd_process *p);
>>>>>>> +void kfd_kill_all_user_processes(void);
>>>>>>>  void kfd_suspend_all_processes(bool force);
>>>>>>>  /*
>>>>>>>   * kfd_resume_all_processes:
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>>> index 6cdc855abb6d..17e769e6951d 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>>> @@ -46,6 +46,9 @@ struct mm_struct;
>>>>>>>  #include "kfd_trace.h"
>>>>>>>  #include "kfd_debug.h"
>>>>>>> +static atomic_t kfd_process_locked = ATOMIC_INIT(0);
>>>>>>> +static atomic_t kfd_inflight_kills = ATOMIC_INIT(0);
>>>>>>> +
>>>>>>>  /*
>>>>>>>   * List of struct kfd_process (field kfd_process).
>>>>>>>   * Unique/indexed by mm_struct*
>>>>>>> @@ -802,6 +805,9 @@ struct kfd_process 
>>>>>>> *kfd_create_process(struct task_struct *thread)
>>>>>>> struct kfd_process *process;
>>>>>>> int ret;
>>>>>>> +if ( atomic_read(&kfd_process_locked) > 0 )
>>>>>>> +return ERR_PTR(-EINVAL);
>>>>>>> +
>>>>>>> if (!(thread->mm && mmget_not_zero(thread->mm)))
>>>>>>> return ERR_PTR(-EINVAL);
>>>>>>> @@ -1126,6 +1132,10 @@ static void kfd_process_wq_release(struct 
>>>>>>> work_struct *work)
>>>>>>> put_task_struct(p->lead_thread);
>>>>>>> kfree(p);
>>>>>>> +
>>>>>>> +if ( atomic_read(&kfd_process_locked) > 0 ){
>>>>>>> +atomic_dec(&kfd_inflight_kills);
>>>>>>> +}
>>>>>>>  }
>>>>>>>  static void kfd_process_ref_release(struct kref *ref)
>>>>>>> @@ -2186,6 +2196,35 @@ static void restore_process_worker(struct 
>>>>>>> work_struct *work)
>>>>>>> pr_err("Failed to restore queues of pasid 0x%x\n", p->pasid);
>>>>>>>  }
>>>>>>> +void kfd_kill_all_user_processes(void)
>>>>>>> +{
>>>>>>> +struct kfd_process *p;
>>>>>>> +/* struct amdkfd_process_info *p_info; */
>>>>>>> +unsigned int temp;
>>>>>>> +int idx;
>>>>>>> +atomic_inc(&kfd_process_locked);
>>>>>>> +
>>>>>>> +idx = srcu_read_lock(&kfd_processes_srcu);
>>>>>>> +pr_info("Killing all processes\n");
>>>>>>> +hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>>>>>>> +dev_warn(kfd_device,
>>>>>>> +"Sending SIGBUS to process %d (pasid 0x%x)",
>>>>>>> +p->lead_thread->pid, p->pasid);
>>>>>>> +send_sig(SIGBUS, p->lead_thread, 0);
>>>>>>> +atomic_inc(&kfd_inflight_kills);
>>>>>>> +}
>>>>>>> +srcu_read_unlock(&kfd_processes_srcu, idx);
>>>>>>> +
>>>>>>> +while ( atomic_read(&kfd_inflight_kills) > 0 ){
>>>>>>> +dev_warn(kfd_device,
>>>>>>> +"kfd_processes_table is not empty, going to sleep for 10ms\n");
>>>>>>> +msleep(10);
>>>>>>> +}
>>>>>>> +
>>>>>>> +atomic_dec(&kfd_process_locked);
>>>>>>> +pr_info("all processes has been fully released");
>>>>>>> +}
>>>>>>> +
>>>>>>>  void kfd_suspend_all_processes(bool force)
>>>>>>>  {
>>>>>>> struct kfd_process *p;
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Regards,
>>>>>>> Shuotao
>>>>>>>
>>>>>>>>
>>>>>>>> Andrey
>>>>>>>>
>>>>>>>>> +       }
>>>>>>>>> + srcu_read_unlock(&kfd_processes_srcu, idx);
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +
>>>>>>>>>  int kfd_resume_all_processes(bool sync)
>>>>>>>>>  {
>>>>>>>>> struct kfd_process *p;
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> Andrey
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Really appreciate your help!
>>>>>>>>>>>
>>>>>>>>>>> Best,
>>>>>>>>>>> Shuotao
>>>>>>>>>>>
>>>>>>>>>>>>> 2. Remove redudant p2p/io links in sysfs when device is 
>>>>>>>>>>>>> hotplugged
>>>>>>>>>>>>> out.
>>>>>>>>>>>>>
>>>>>>>>>>>>> 3. New kfd node_id is not properly assigned after a new 
>>>>>>>>>>>>> device is
>>>>>>>>>>>>> added after a gpu is hotplugged out in a system. libhsakmt 
>>>>>>>>>>>>> will
>>>>>>>>>>>>> find this anomaly, (i.e. node_from != <dev node id> in 
>>>>>>>>>>>>> iolinks),
>>>>>>>>>>>>> when taking a topology_snapshot, thus returns fault to the 
>>>>>>>>>>>>> rocm
>>>>>>>>>>>>> stack.
>>>>>>>>>>>>>
>>>>>>>>>>>>> -- This patch fixes issue 1; another patch by Mukul fixes 
>>>>>>>>>>>>> issues 2&3.
>>>>>>>>>>>>> -- Tested on a 4-GPU MI100 gpu nodes with kernel 
>>>>>>>>>>>>> 5.13.0-kfd; kernel
>>>>>>>>>>>>> 5.16.0-kfd is unstable out of box for MI100.
>>>>>>>>>>>>> ---
>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 5 +++++
>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 7 +++++++
>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
>>>>>>>>>>>>> drivers/gpu/drm/amd/amdkfd/kfd_device.c | 13 +++++++++++++
>>>>>>>>>>>>> 4 files changed, 26 insertions(+)
>>>>>>>>>>>>>
>>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>>>>>> index c18c4be1e4ac..d50011bdb5c4 100644
>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>>>>>>>>> @@ -213,6 +213,11 @@ int amdgpu_amdkfd_resume(struct 
>>>>>>>>>>>>> amdgpu_device *adev, bool run_pm)
>>>>>>>>>>>>> return r;
>>>>>>>>>>>>> }
>>>>>>>>>>>>>
>>>>>>>>>>>>> +int amdgpu_amdkfd_resume_processes(void)
>>>>>>>>>>>>> +{
>>>>>>>>>>>>> + return kgd2kfd_resume_processes();
>>>>>>>>>>>>> +}
>>>>>>>>>>>>> +
>>>>>>>>>>>>> int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev)
>>>>>>>>>>>>> {
>>>>>>>>>>>>> int r = 0;
>>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>>>>>>>>>> index f8b9f27adcf5..803306e011c3 100644
>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>>>>>>>>>> @@ -140,6 +140,7 @@ void amdgpu_amdkfd_fini(void);
>>>>>>>>>>>>> void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, 
>>>>>>>>>>>>> bool run_pm);
>>>>>>>>>>>>> int amdgpu_amdkfd_resume_iommu(struct amdgpu_device *adev);
>>>>>>>>>>>>> int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool 
>>>>>>>>>>>>> run_pm);
>>>>>>>>>>>>> +int amdgpu_amdkfd_resume_processes(void);
>>>>>>>>>>>>> void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
>>>>>>>>>>>>> const void *ih_ring_entry);
>>>>>>>>>>>>> void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev);
>>>>>>>>>>>>> @@ -347,6 +348,7 @@ void kgd2kfd_device_exit(struct 
>>>>>>>>>>>>> kfd_dev *kfd);
>>>>>>>>>>>>> void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
>>>>>>>>>>>>> int kgd2kfd_resume_iommu(struct kfd_dev *kfd);
>>>>>>>>>>>>> int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
>>>>>>>>>>>>> +int kgd2kfd_resume_processes(void);
>>>>>>>>>>>>> int kgd2kfd_pre_reset(struct kfd_dev *kfd);
>>>>>>>>>>>>> int kgd2kfd_post_reset(struct kfd_dev *kfd);
>>>>>>>>>>>>> void kgd2kfd_interrupt(struct kfd_dev *kfd, const void 
>>>>>>>>>>>>> *ih_ring_entry);
>>>>>>>>>>>>> @@ -393,6 +395,11 @@ static inline int 
>>>>>>>>>>>>> kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>>>>>>>>>>>>> return 0;
>>>>>>>>>>>>> }
>>>>>>>>>>>>>
>>>>>>>>>>>>> +static inline int kgd2kfd_resume_processes(void)
>>>>>>>>>>>>> +{
>>>>>>>>>>>>> + return 0;
>>>>>>>>>>>>> +}
>>>>>>>>>>>>> +
>>>>>>>>>>>>> static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd)
>>>>>>>>>>>>> {
>>>>>>>>>>>>> return 0;
>>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>>>> index fa4a9f13c922..5827b65b7489 100644
>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>>>> @@ -4004,6 +4004,7 @@ void amdgpu_device_fini_hw(struct 
>>>>>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>>>>> if (drm_dev_is_unplugged(adev_to_drm(adev)))
>>>>>>>>>>>>> amdgpu_device_unmap_mmio(adev);
>>>>>>>>>>>>>
>>>>>>>>>>>>> + amdgpu_amdkfd_resume_processes();
>>>>>>>>>>>>> }
>>>>>>>>>>>>>
>>>>>>>>>>>>> void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>>>>>>>> index 62aa6c9d5123..ef05aae9255e 100644
>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>>>>>>>> @@ -714,6 +714,19 @@ int kgd2kfd_resume(struct kfd_dev 
>>>>>>>>>>>>> *kfd, bool run_pm)
>>>>>>>>>>>>> return ret;
>>>>>>>>>>>>> }
>>>>>>>>>>>>>
>>>>>>>>>>>>> +/* for non-runtime resume only */
>>>>>>>>>>>>> +int kgd2kfd_resume_processes(void)
>>>>>>>>>>>>> +{
>>>>>>>>>>>>> + int count;
>>>>>>>>>>>>> +
>>>>>>>>>>>>> + count = atomic_dec_return(&kfd_locked);
>>>>>>>>>>>>> + WARN_ONCE(count < 0, "KFD suspend / resume ref. error");
>>>>>>>>>>>>> + if (count == 0)
>>>>>>>>>>>>> + return kfd_resume_all_processes();
>>>>>>>>>>>>> +
>>>>>>>>>>>>> + return 0;
>>>>>>>>>>>>> +}
>>>>>>>>>>>>
>>>>>>>>>>>> It doesn't make sense to me to just increment kfd_locked in
>>>>>>>>>>>> kgd2kfd_suspend to only decrement it again a few functions 
>>>>>>>>>>>> down the
>>>>>>>>>>>> road.
>>>>>>>>>>>>
>>>>>>>>>>>> I suggest this instead - you only incrmemnt if not during 
>>>>>>>>>>>> PCI remove
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>>>>>>> index 1c2cf3a33c1f..7754f77248a4 100644
>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>>>>>>> @@ -952,11 +952,12 @@ bool kfd_is_locked(void)
>>>>>>>>>>>>
>>>>>>>>>>>> void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
>>>>>>>>>>>> {
>>>>>>>>>>>> +
>>>>>>>>>>>> if (!kfd->init_complete)
>>>>>>>>>>>> return;
>>>>>>>>>>>>
>>>>>>>>>>>> /* for runtime suspend, skip locking kfd */
>>>>>>>>>>>> - if (!run_pm) {
>>>>>>>>>>>> + if (!run_pm && !drm_dev_is_unplugged(kfd->ddev)) {
>>>>>>>>>>>> /* For first KFD device suspend all the KFD processes */
>>>>>>>>>>>> if (atomic_inc_return(&kfd_locked) == 1)
>>>>>>>>>>>> kfd_suspend_all_processes();
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Andrey
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>> +
>>>>>>>>>>>>> int kgd2kfd_resume_iommu(struct kfd_dev *kfd)
>>>>>>>>>>>>> {
>>>>>>>>>>>>> int err = 0;
>>>>>>>>>
>>>>>>>
>>>>>
>>>
>
--------------1kPSWthhFoGfhQAi5DCrigrp
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-04-19 03:41, Shuotao Xu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:0FD33B90-BD27-4F32-9735-CA525735B5FA@microsoft.com">
      
      <br class="">
      <div><br class="">
        <blockquote type="cite" class="">
          <div class="">On Apr 18, 2022, at 11:23 PM, Andrey Grodzovsky
            &lt;<a href="mailto:andrey.grodzovsky@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">andrey.grodzovsky@amd.com</a>&gt;
            wrote:</div>
          <br class="Apple-interchange-newline">
          <div class="">
            <div class="">
              <p class=""><br class="">
              </p>
              <div class="moz-cite-prefix">On 2022-04-18 09:22, Shuotao
                Xu wrote:<br class="">
              </div>
              <blockquote type="cite" cite="mid:7825EEC6-BAF8-4B71-B01C-FE246D360779@microsoft.com" class="">
                <br class="">
                <div class=""><br class="">
                  <blockquote type="cite" class="">
                    <div class="">On Apr 16, 2022, at 12:43 AM, Andrey
                      Grodzovsky &lt;<a href="mailto:andrey.grodzovsky@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">andrey.grodzovsky@amd.com</a>&gt;
                      wrote:</div>
                    <br class="Apple-interchange-newline">
                    <div class="">
                      <div class="">
                        <p class=""><br class="">
                        </p>
                        <div class="moz-cite-prefix">On 2022-04-15
                          06:12, Shuotao Xu wrote:<br class="">
                        </div>
                        <blockquote type="cite" cite="mid:76C16B06-0539-48EE-AB11-80089490CE3A@microsoft.com" class="">
                          Hi Andrey,
                          <div class=""><br class="">
                          </div>
                          <div class="">First I really appreciate the
                            discussion! It helped me understand the
                            driver code greatly. Thank you so much:)</div>
                          <div class="">Please see my inline comments.&nbsp;<br class="">
                            <div class=""><br class="">
                              <blockquote type="cite" class="">
                                <div class="">On Apr 14, 2022, at 11:13
                                  PM, Andrey Grodzovsky &lt;<a href="mailto:andrey.grodzovsky@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">andrey.grodzovsky@amd.com</a>&gt;
                                  wrote:</div>
                                <br class="Apple-interchange-newline">
                                <div class="">
                                  <div class="">
                                    <p class=""><br class="">
                                    </p>
                                    <div class="moz-cite-prefix">On
                                      2022-04-14 10:00, Shuotao Xu
                                      wrote:<br class="">
                                    </div>
                                    <blockquote type="cite" cite="mid:B7970589-ACF6-41F3-8622-1C0F705F3EE0@microsoft.com" class="">
                                      <br class="">
                                      <div class=""><br class="">
                                        <blockquote type="cite" class="">
                                          <div class="">On Apr 14, 2022,
                                            at 1:31 AM, Andrey
                                            Grodzovsky &lt;<a href="mailto:andrey.grodzovsky@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">andrey.grodzovsky@amd.com</a>&gt;
                                            wrote:</div>
                                          <br class="Apple-interchange-newline">
                                          <div class="">
                                            <div class="">
                                              <p class=""><br class="">
                                              </p>
                                              <div class="moz-cite-prefix">On
                                                2022-04-13 12:03,
                                                Shuotao Xu wrote:<br class="">
                                              </div>
                                              <blockquote type="cite" cite="mid:5A64FAEA-CCE8-4EB6-8E7B-852D4F384255@microsoft.com" class="">
                                                <br class="">
                                                <div class=""><br class="">
                                                  <blockquote type="cite" class="">
                                                    <div class="">On Apr
                                                      11, 2022, at 11:52
                                                      PM, Andrey
                                                      Grodzovsky &lt;<a href="mailto:andrey.grodzovsky@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">andrey.grodzovsky@amd.com</a>&gt;
                                                      wrote:</div>
                                                    <br class="Apple-interchange-newline">
                                                    <div class=""><span style="caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:
                                                        12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none; float:
                                                        none; display:
                                                        inline
                                                        !important;" class="">[Some
                                                        people who
                                                        received this
                                                        message don't
                                                        often get email
                                                        from<span class="Apple-converted-space">&nbsp;</span></span><a href="mailto:andrey.grodzovsky@amd.com" style="font-family: Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal; orphans:
                                                        auto;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal; widows:
                                                        auto;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-size-adjust:
                                                        auto;
                                                        -webkit-text-stroke-width:
                                                        0px;" class="moz-txt-link-freetext" moz-do-not-send="true">andrey.grodzovsky@amd.com</a><span style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none; float:
                                                        none; display:
                                                        inline
                                                        !important;" class="">. Learn
                                                        why this is
                                                        important at<span class="Apple-converted-space">&nbsp;</span></span><a href="http://aka.ms/LearnAboutSenderIdentification" style="font-family: Helvetica; font-size: 12px; font-style: normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal; orphans:
                                                        auto;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal; widows:
                                                        auto;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-size-adjust:
                                                        auto;
                                                        -webkit-text-stroke-width:
                                                        0px;" class="moz-txt-link-freetext" moz-do-not-send="true">http://aka.ms/LearnAboutSenderIdentification</a><span style="caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:
                                                        12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none; float:
                                                        none; display:
                                                        inline
                                                        !important;" class="">.]</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:
                                                        12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <br style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <span style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none; float:
                                                        none; display:
                                                        inline
                                                        !important;" class="">On
                                                        2022-04-08
                                                        21:28, Shuotao
                                                        Xu wrote:</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:
                                                        12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <blockquote type="cite" style="font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal; orphans:
                                                        auto;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal; widows:
                                                        auto;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-size-adjust:
                                                        auto;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                        <br class="">
                                                        <blockquote type="cite" class="">On
                                                          Apr 8, 2022,
                                                          at 11:28 PM,
                                                          Andrey
                                                          Grodzovsky
                                                          &lt;<a href="mailto:andrey.grodzovsky@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">andrey.grodzovsky@amd.com</a>&gt;
                                                          wrote:<br class="">
                                                          <br class="">
                                                          [Some people
                                                          who received
                                                          this message
                                                          don't often
                                                          get email from
                                                          <a href="mailto:andrey.grodzovsky@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">
andrey.grodzovsky@amd.com</a>. Learn why this is important at <a href="http://aka.ms/LearnAboutSenderIdentification" class="moz-txt-link-freetext" moz-do-not-send="true">
http://aka.ms/LearnAboutSenderIdentification</a>.]<br class="">
                                                          <br class="">
                                                          On 2022-04-08
                                                          04:45, Shuotao
                                                          Xu wrote:<br class="">
                                                          <blockquote type="cite" class="">Adding
                                                          PCIe Hotplug
                                                          Support for
                                                          AMDKFD: the
                                                          support of
                                                          hot-plug of
                                                          GPU<br class="">
                                                          devices can
                                                          open doors for
                                                          many advanced
                                                          applications
                                                          in data center<br class="">
                                                          in the next
                                                          few years,
                                                          such as for
                                                          GPU resource<br class="">
disaggregation. Current AMDKFD does not support hotplug out b/o the<br class="">
                                                          following
                                                          reasons:<br class="">
                                                          <br class="">
                                                          1. During PCIe
                                                          removal,
                                                          decrement KFD
                                                          lock which was
                                                          incremented at<br class="">
                                                          the beginning
                                                          of hw fini;
                                                          otherwise
                                                          kfd_open later
                                                          is going to<br class="">
                                                          fail.<br class="">
                                                          </blockquote>
                                                          I assumed you
                                                          read my
                                                          comment last
                                                          time, still
                                                          you do same
                                                          approach.<br class="">
                                                          More in
                                                          details bellow<br class="">
                                                        </blockquote>
                                                        Aha, I like your
                                                        fix:) I was not
                                                        familiar with
                                                        drm APIs so just
                                                        only half
                                                        understood your
                                                        comment last
                                                        time.<br class="">
                                                        <br class="">
                                                        BTW, I tried
                                                        hot-plugging out
                                                        a GPU when rocm
                                                        application is
                                                        still running.<br class="">
                                                        From dmesg,
                                                        application is
                                                        still trying to
                                                        access the
                                                        removed kfd
                                                        device, and are
                                                        met with some
                                                        errors.<br class="">
                                                      </blockquote>
                                                      <br style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <br style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <span style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none; float:
                                                        none; display:
                                                        inline
                                                        !important;" class="">Application
                                                        us supposed to
                                                        keep running, it
                                                        holds the
                                                        drm_device</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:
                                                        12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <span style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none; float:
                                                        none; display:
                                                        inline
                                                        !important;" class="">reference
                                                        as long as it
                                                        has an open</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:
                                                        12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <span style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none; float:
                                                        none; display:
                                                        inline
                                                        !important;" class="">FD to
                                                        the device and
                                                        final cleanup
                                                        will come only
                                                        after the app
                                                        will die</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:
                                                        12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <span style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none; float:
                                                        none; display:
                                                        inline
                                                        !important;" class="">thus
                                                        releasing the FD
                                                        and the last</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:
                                                        12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <span style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none; float:
                                                        none; display:
                                                        inline
                                                        !important;" class="">drm_device
                                                        reference.</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:
                                                        12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <br style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <blockquote type="cite" style="font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal; orphans:
                                                        auto;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal; widows:
                                                        auto;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-size-adjust:
                                                        auto;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                        Application
                                                        would hang and
                                                        not exiting in
                                                        this case.<br class="">
                                                      </blockquote>
                                                      <br style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                    </div>
                                                  </blockquote>
                                                  <div class=""><br class="">
                                                  </div>
                                                  Actually I tried kill
                                                  -7 $pid, and the
                                                  process exists. The
                                                  dmesg has some warning
                                                  though.</div>
                                                <div class=""><br class="">
                                                </div>
                                                <div class="">
                                                  <div class="">[
                                                    &nbsp;711.769977]
                                                    WARNING: CPU: 23
                                                    PID: 344 at
                                                    .../amdgpu-rocm5.0.2/src/amd/amdgpu/amdgpu_object.c:1336
amdgpu_bo_release_notify+0x150/0x160 [amdgpu]</div>
                                                  <div class="">[
                                                    &nbsp;711.770528] Modules
                                                    linked in:
                                                    amdgpu(OE)
                                                    amdttm(OE)
                                                    amd_sched(OE)
                                                    amdkcl(OE) iommu_v2
                                                    nf_conntrack_netlink
                                                    nfnetlink xfrm_user
                                                    xfrm_algo
                                                    xt_addrtype
                                                    br_netfilter
                                                    xt_CHECKSUM
                                                    iptable_mangle
                                                    xt_MASQUERADE
                                                    iptable_nat nf_nat
                                                    xt_conntrack
                                                    nf_conntrack
                                                    nf_defrag_ipv6
                                                    nf_defrag_ipv4
                                                    ipt_REJECT
                                                    nf_reject_ipv4
                                                    xt_tcpudp bridge stp
                                                    llc ebtable_filter
                                                    ebtables
                                                    ip6table_filter
                                                    ip6_tables
                                                    iptable_filter
                                                    overlay binfmt_misc
                                                    intel_rapl_msr i40iw
                                                    intel_rapl_common
                                                    skx_edac nfit
                                                    x86_pkg_temp_thermal
                                                    intel_powerclamp
                                                    coretemp kvm_intel
                                                    rpcrdma kvm sunrpc
                                                    ipmi_ssif ib_umad
                                                    ib_ipoib rdma_ucm
                                                    irqbypass rapl
                                                    joydev acpi_ipmi
                                                    input_leds
                                                    intel_cstate ipmi_si
                                                    ipmi_devintf mei_me
                                                    mei
                                                    intel_pch_thermal
                                                    ipmi_msghandler
                                                    ioatdma mac_hid
                                                    lpc_ich dca
                                                    acpi_power_meter
                                                    acpi_pad
                                                    sch_fq_codel ib_iser
                                                    rdma_cm iw_cm ib_cm
                                                    iscsi_tcp
                                                    libiscsi_tcp
                                                    libiscsi
                                                    scsi_transport_iscsi
                                                    pci_stub ip_tables
                                                    x_tables autofs4
                                                    btrfs
                                                    blake2b_generic
                                                    zstd_compress raid10
                                                    raid456
                                                    async_raid6_recov
                                                    async_memcpy
                                                    async_pq async_xor
                                                    async_tx xor</div>
                                                  <div class="">[
                                                    &nbsp;711.779359]
                                                    &nbsp;raid6_pq libcrc32c
                                                    raid1 raid0
                                                    multipath linear
                                                    mlx5_ib ib_uverbs
                                                    ib_core ast
                                                    drm_vram_helper
                                                    i2c_algo_bit
                                                    drm_ttm_helper ttm
                                                    drm_kms_helper
                                                    syscopyarea
                                                    crct10dif_pclmul
                                                    crc32_pclmul
                                                    ghash_clmulni_intel
                                                    sysfillrect uas
                                                    hid_generic
                                                    sysimgblt
                                                    aesni_intel
                                                    mlx5_core
                                                    fb_sys_fops
                                                    crypto_simd usbhid
                                                    cryptd drm i40e
                                                    pci_hyperv_intf
                                                    usb_storage
                                                    glue_helper mlxfw
                                                    hid ahci libahci wmi</div>
                                                  <div class="">[
                                                    &nbsp;711.779752] CPU: 23
                                                    PID: 344 Comm:
                                                    kworker/23:1
                                                    Tainted: G &nbsp; &nbsp; &nbsp; &nbsp;W
                                                    &nbsp;OE &nbsp; &nbsp; 5.11.0+ #1</div>
                                                  <div class="">[
                                                    &nbsp;711.779755]
                                                    Hardware name:
                                                    Supermicro
                                                    SYS-4029GP-TRT2/X11DPG-OT-CPU,
                                                    BIOS 2.1 08/14/2018</div>
                                                  <div class="">[
                                                    &nbsp;711.779756]
                                                    Workqueue:
                                                    kfd_process_wq
                                                    kfd_process_wq_release
                                                    [amdgpu]</div>
                                                  <div class="">[
                                                    &nbsp;711.779955] RIP:
                                                    0010:amdgpu_bo_release_notify+0x150/0x160
                                                    [amdgpu]</div>
                                                  <div class="">[
                                                    &nbsp;711.780141] Code:
                                                    e8 b5 af 34 f4 e9 1f
                                                    ff ff ff 48 39 c2 74
                                                    07 0f 0b e9 69 ff ff
                                                    ff 4c 89 e7 e8 3c b4
                                                    16 00 e9 5c ff ff ff
                                                    e8 a2 ce fd f3 eb cf
                                                    &lt;0f&gt; 0b eb cb
                                                    e8 d7 02 34 f4 0f 1f
                                                    80 00 00 00 00 0f 1f
                                                    44 00 00 55</div>
                                                  <div class="">[
                                                    &nbsp;711.780143] RSP:
                                                    0018:ffffa8100dd67c30
                                                    EFLAGS: 00010282</div>
                                                  <div class="">[
                                                    &nbsp;711.780145] RAX:
                                                    00000000ffffffea
                                                    RBX:
                                                    ffff89980e792058
                                                    RCX:
                                                    0000000000000000</div>
                                                  <div class="">[
                                                    &nbsp;711.780147] RDX:
                                                    0000000000000000
                                                    RSI:
                                                    ffff89a8f9ad8870
                                                    RDI:
                                                    ffff89a8f9ad8870</div>
                                                  <div class="">[
                                                    &nbsp;711.780148] RBP:
                                                    ffffa8100dd67c50
                                                    R08:
                                                    0000000000000000
                                                    R09:
                                                    fffffffffff99b18</div>
                                                  <div class="">[
                                                    &nbsp;711.780149] R10:
                                                    ffffa8100dd67bd0
                                                    R11:
                                                    ffffa8100dd67908
                                                    R12:
                                                    ffff89980e792000</div>
                                                  <div class="">[
                                                    &nbsp;711.780151] R13:
                                                    ffff89980e792058
                                                    R14:
                                                    ffff89980e7921bc
                                                    R15:
                                                    dead000000000100</div>
                                                  <div class="">[
                                                    &nbsp;711.780152] FS:
                                                    &nbsp;0000000000000000(0000)
GS:ffff89a8f9ac0000(0000) knlGS:0000000000000000</div>
                                                  <div class="">[
                                                    &nbsp;711.780154] CS:
                                                    &nbsp;0010 DS: 0000 ES:
                                                    0000 CR0:
                                                    0000000080050033</div>
                                                  <div class="">[
                                                    &nbsp;711.780156] CR2:
                                                    00007ffddac6f71f
                                                    CR3:
                                                    00000030bb80a003
                                                    CR4:
                                                    00000000007706e0</div>
                                                  <div class="">[
                                                    &nbsp;711.780157] DR0:
                                                    0000000000000000
                                                    DR1:
                                                    0000000000000000
                                                    DR2:
                                                    0000000000000000</div>
                                                  <div class="">[
                                                    &nbsp;711.780159] DR3:
                                                    0000000000000000
                                                    DR6:
                                                    00000000fffe0ff0
                                                    DR7:
                                                    0000000000000400</div>
                                                  <div class="">[
                                                    &nbsp;711.780160] PKRU:
                                                    55555554</div>
                                                  <div class="">[
                                                    &nbsp;711.780161] Call
                                                    Trace:</div>
                                                  <div class="">[
                                                    &nbsp;711.780163]
                                                    &nbsp;ttm_bo_release+0x2ae/0x320
                                                    [amdttm]</div>
                                                  <div class="">[
                                                    &nbsp;711.780169]
                                                    &nbsp;amdttm_bo_put+0x30/0x40
                                                    [amdttm]</div>
                                                  <div class="">[
                                                    &nbsp;711.780357]
                                                    &nbsp;amdgpu_bo_unref+0x1e/0x30
                                                    [amdgpu]</div>
                                                  <div class="">[
                                                    &nbsp;711.780543]
                                                    &nbsp;amdgpu_gem_object_free+0x8b/0x160
                                                    [amdgpu]</div>
                                                  <div class="">[
                                                    &nbsp;711.781119]
                                                    &nbsp;drm_gem_object_free+0x1d/0x30
                                                    [drm]</div>
                                                  <div class="">[
                                                    &nbsp;711.781489]
                                                    &nbsp;amdgpu_amdkfd_gpuvm_free_memory_of_gpu+0x34a/0x380
                                                    [amdgpu]</div>
                                                  <div class="">[
                                                    &nbsp;711.782044]
                                                    &nbsp;kfd_process_device_free_bos+0xe0/0x130
                                                    [amdgpu]</div>
                                                  <div class="">[
                                                    &nbsp;711.782611]
                                                    &nbsp;kfd_process_wq_release+0x286/0x380
                                                    [amdgpu]</div>
                                                  <div class="">[
                                                    &nbsp;711.783172]
                                                    &nbsp;process_one_work+0x236/0x420</div>
                                                  <div class="">[
                                                    &nbsp;711.783543]
                                                    &nbsp;worker_thread+0x34/0x400</div>
                                                  <div class="">[
                                                    &nbsp;711.783911] &nbsp;?
                                                    process_one_work+0x420/0x420</div>
                                                  <div class="">[
                                                    &nbsp;711.784279]
                                                    &nbsp;kthread+0x126/0x140</div>
                                                  <div class="">[
                                                    &nbsp;711.784653] &nbsp;?
                                                    kthread_park+0x90/0x90</div>
                                                  <div class="">[
                                                    &nbsp;711.785018]
                                                    &nbsp;ret_from_fork+0x22/0x30</div>
                                                  <div class="">[
                                                    &nbsp;711.785387] ---[
                                                    end trace
                                                    d8f50f6594817c84
                                                    ]---</div>
                                                  <div class="">[
                                                    &nbsp;711.798716] [drm]
                                                    amdgpu: ttm
                                                    finalized</div>
                                                </div>
                                              </blockquote>
                                              <p class=""><br class="">
                                              </p>
                                              <p class="">So it means
                                                the process was stuck in
                                                some wait_event_killable
                                                (maybe here
                                                drm_sched_entity_flush)
                                                - you can try
                                                'cat/proc/$process_pid/stack'
                                                maybe before<br class="">
                                                you kill it to see where
                                                it was stuck so we can
                                                go from there.<br class="">
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
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <span style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none; float:
                                                        none; display:
                                                        inline
                                                        !important;" class="">For
                                                        graphic apps
                                                        what i usually
                                                        see is a crash
                                                        because of
                                                        sigsev when</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:
                                                        12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <span style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none; float:
                                                        none; display:
                                                        inline
                                                        !important;" class="">the app
                                                        tries to access</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:
                                                        12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <span style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none; float:
                                                        none; display:
                                                        inline
                                                        !important;" class="">an
                                                        unmapped MMIO
                                                        region on the
                                                        device. I
                                                        haven't tested
                                                        for compute</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:
                                                        12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <span style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none; float:
                                                        none; display:
                                                        inline
                                                        !important;" class="">stack
                                                        and so there
                                                        might</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:
                                                        12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <span style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none; float:
                                                        none; display:
                                                        inline
                                                        !important;" class="">be
                                                        something I
                                                        haven't covered.
                                                        Hang could mean
                                                        for example
                                                        waiting on a</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:
                                                        12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <span style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none; float:
                                                        none; display:
                                                        inline
                                                        !important;" class="">fence
                                                        which is not
                                                        being</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:
                                                        12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <span style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none; float:
                                                        none; display:
                                                        inline
                                                        !important;" class="">signaled
                                                        - please provide
                                                        full dmesg from
                                                        this case.</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:
                                                        12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <br style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <blockquote type="cite" style="font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal; orphans:
                                                        auto;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal; widows:
                                                        auto;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-size-adjust:
                                                        auto;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                        <br class="">
                                                        Do you have any
                                                        good suggestions
                                                        on how to fix it
                                                        down the line?
                                                        (HIP
                                                        runtime/libhsakmt
                                                        or driver)<br class="">
                                                        <br class="">
                                                        [64036.631333]
                                                        amdgpu:
                                                        amdgpu_vm_bo_update
                                                        failed<br class="">
                                                        [64036.631702]
                                                        amdgpu:
                                                        validate_invalid_user_pages:
                                                        update PTE
                                                        failed<br class="">
                                                        [64036.640754]
                                                        amdgpu:
                                                        amdgpu_vm_bo_update
                                                        failed<br class="">
                                                        [64036.641120]
                                                        amdgpu:
                                                        validate_invalid_user_pages:
                                                        update PTE
                                                        failed<br class="">
                                                        [64036.650394]
                                                        amdgpu:
                                                        amdgpu_vm_bo_update
                                                        failed<br class="">
                                                        [64036.650765]
                                                        amdgpu:
                                                        validate_invalid_user_pages:
                                                        update PTE
                                                        failed<br class="">
                                                      </blockquote>
                                                      <br style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                    </div>
                                                  </blockquote>
                                                  <div class=""><br class="">
                                                  </div>
                                                  The full dmesg will
                                                  just the repetition of
                                                  those two messages,</div>
                                                <div class="">
                                                  <div class="">[186885.764079]
                                                    amdgpu 0000:43:00.0:
                                                    amdgpu: amdgpu:
                                                    finishing device.</div>
                                                  <div class="">[186885.766916]
                                                    [drm] free PSP TMR
                                                    buffer</div>
                                                  <div class="">[186893.868173]
                                                    amdgpu:
                                                    amdgpu_vm_bo_update
                                                    failed</div>
                                                  <div class="">[186893.868235]
                                                    amdgpu:
                                                    validate_invalid_user_pages:
                                                    update PTE failed</div>
                                                  <div class="">[186893.876154]
                                                    amdgpu:
                                                    amdgpu_vm_bo_update
                                                    failed</div>
                                                  <div class="">[186893.876190]
                                                    amdgpu:
                                                    validate_invalid_user_pages:
                                                    update PTE failed</div>
                                                  <div class="">[186893.884150]
                                                    amdgpu:
                                                    amdgpu_vm_bo_update
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
                                                    <div class=""><br style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <span style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none; float:
                                                        none; display:
                                                        inline
                                                        !important;" class="">This
                                                        just probably
                                                        means trying to
                                                        update PTEs
                                                        after the
                                                        physical device</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:
                                                        12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <span style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none; float:
                                                        none; display:
                                                        inline
                                                        !important;" class="">is gone
                                                        - we usually
                                                        avoid this by</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:
                                                        12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <span style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none; float:
                                                        none; display:
                                                        inline
                                                        !important;" class="">first
                                                        trying to do all
                                                        HW shutdowns
                                                        early before PCI
                                                        remove
                                                        completion</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:
                                                        12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <span style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none; float:
                                                        none; display:
                                                        inline
                                                        !important;" class="">but
                                                        when it's really
                                                        tricky by</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:
                                                        12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <span style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none; float:
                                                        none; display:
                                                        inline
                                                        !important;" class="">protecting
                                                        HW access
                                                        sections with
                                                        drm_dev_enter/exit
                                                        scope.</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:
                                                        12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <br style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <span style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none; float:
                                                        none; display:
                                                        inline
                                                        !important;" class="">For
                                                        this particular
                                                        error it would
                                                        be the best to
                                                        flush</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:
                                                        12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <span style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none; float:
                                                        none; display:
                                                        inline
                                                        !important;" class="">info-&gt;restore_userptr_work
                                                        before the end
                                                        of</span><br style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <span style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none; float:
                                                        none; display:
                                                        inline
                                                        !important;" class="">amdgpu_pci_remove
                                                        (rejecting new
                                                        process creation
                                                        and calling</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:
                                                        12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <span style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none; float:
                                                        none; display:
                                                        inline
                                                        !important;" class="">cancel_delayed_work_sync(&amp;process_info-&gt;restore_userptr_work)
                                                        for all</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:
                                                        12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <span style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none; float:
                                                        none; display:
                                                        inline
                                                        !important;" class="">running
                                                        processes)</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:
                                                        12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <span style="caret-color:
                                                        rgb(0, 0, 0);
                                                        font-family:
                                                        Helvetica;
                                                        font-size: 12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none; float:
                                                        none; display:
                                                        inline
                                                        !important;" class="">somewhere
                                                        in
                                                        amdgpu_pci_remove.</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:
                                                        12px;
                                                        font-style:
                                                        normal;
                                                        font-variant-caps:
                                                        normal;
                                                        font-weight:
                                                        400;
                                                        letter-spacing:
                                                        normal;
                                                        text-align:
                                                        start;
                                                        text-indent:
                                                        0px;
                                                        text-transform:
                                                        none;
                                                        white-space:
                                                        normal;
                                                        word-spacing:
                                                        0px;
                                                        -webkit-text-stroke-width:
                                                        0px;
                                                        text-decoration:
                                                        none;" class="">
                                                      <br class="">
                                                    </div>
                                                  </blockquote>
                                                  I tried something like
*kfd_process_ref_release* which I think did what you described, but it
                                                  did not work.</div>
                                              </blockquote>
                                              <p class=""><br class="">
                                              </p>
                                              <p class="">I don't see
                                                how
                                                kfd_process_ref_release
                                                is the same as I
                                                mentioned above, what i
                                                meant is calling the
                                                code above within
                                                kgd2kfd_suspend (where
                                                you tried to call
                                                kfd_kill_all_user_processes
                                                bellow)
                                                <br class="">
                                              </p>
                                            </div>
                                          </div>
                                        </blockquote>
                                        Yes, you are right. It was not
                                        called by it. &nbsp;<br class="">
                                        <blockquote type="cite" class="">
                                          <div class="">
                                            <div class="">
                                              <p class=""><br class="">
                                              </p>
                                              <blockquote type="cite" cite="mid:5A64FAEA-CCE8-4EB6-8E7B-852D4F384255@microsoft.com" class="">
                                                <div class=""><br class="">
                                                </div>
                                                <div class="">Instead I
                                                  tried to kill the
                                                  process from the
                                                  kernel, but the amdgpu
                                                  could **only** be
                                                  hot-plugged in back
                                                  successfully only if
                                                  there was no rocm
                                                  kernel running when it
                                                  was plugged out. If
                                                  not, amdgpu_probe will
                                                  just hang later.
                                                  (Maybe because amdgpu
                                                  was plugged out while
                                                  running state, it
                                                  leaves a bad HW state
                                                  which causes probe to
                                                  hang).</div>
                                              </blockquote>
                                              <p class=""><br class="">
                                              </p>
                                              <p class="">We usually do
                                                asic_reset during probe
                                                to reset all HW state
                                                (checlk if
                                                amdgpu_device_init-&gt;amdgpu_asic_reset
                                                is running when you&nbsp;
                                                plug back).
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
                                                <div class="">I don’t
                                                  know if this is a
                                                  viable solution worth
                                                  pursuing, but I
                                                  attached the diff
                                                  anyway.</div>
                                                <div class=""><br class="">
                                                </div>
                                                <div class="">Another
                                                  solution could be let
                                                  compute stack user
                                                  mode detect a topology
                                                  change via&nbsp;<span class="">generation_count
                                                    change, and abort
                                                    gracefully there.</span></div>
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
                                                <div class="">@@ -697,12
                                                  +697,15 @@ void
                                                  kgd2kfd_suspend(struct
                                                  kfd_dev *kfd, bool
                                                  run_pm, bool force)</div>
                                                <div class="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                  &nbsp; &nbsp; &nbsp; return;</div>
                                                <div class=""><br class="">
                                                </div>
                                                <div class="">&nbsp; &nbsp; &nbsp; &nbsp; /*
                                                  for runtime suspend,
                                                  skip locking kfd */</div>
                                                <div class="">- &nbsp; &nbsp; &nbsp; if
                                                  (!run_pm) {</div>
                                                <div class="">+ &nbsp; &nbsp; &nbsp; if
                                                  (!run_pm &amp;&amp;
                                                  !drm_dev_is_unplugged(kfd-&gt;ddev))
                                                  {</div>
                                                <div class="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                  &nbsp; &nbsp; &nbsp; /* For first KFD
                                                  device suspend all the
                                                  KFD processes */</div>
                                                <div class="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                  &nbsp; &nbsp; &nbsp; if
                                                  (atomic_inc_return(&amp;kfd_locked)
                                                  == 1)</div>
                                                <div class="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                  kfd_suspend_all_processes(force);</div>
                                                <div class="">&nbsp; &nbsp; &nbsp; &nbsp; }</div>
                                                <div class=""><br class="">
                                                </div>
                                                <div class="">+ &nbsp; &nbsp; &nbsp; if
(drm_dev_is_unplugged(kfd-&gt;ddev))</div>
                                                <div class="">+ &nbsp; &nbsp; &nbsp; &nbsp;
                                                  &nbsp; &nbsp; &nbsp;
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
                                                <div class="">@@ -1065,6
                                                  +1065,7 @@ void
                                                  kfd_unref_process(struct
                                                  kfd_process *p);</div>
                                                <div class="">&nbsp;int
                                                  kfd_process_evict_queues(struct
                                                  kfd_process *p, bool
                                                  force);</div>
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
                                                <div class="">&nbsp; * &nbsp; &nbsp;
                                                  bool sync: If
                                                  kfd_resume_all_processes()
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
                                                <div class="">@@ -2206,6
                                                  +2206,24 @@ void
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
                                                <div class="">+ &nbsp; &nbsp; &nbsp;
                                                  struct kfd_process *p;</div>
                                                <div class="">+ &nbsp; &nbsp; &nbsp;
                                                  struct
                                                  amdkfd_process_info
                                                  *p_info;</div>
                                                <div class="">+ &nbsp; &nbsp; &nbsp;
                                                  unsigned int temp;</div>
                                                <div class="">+ &nbsp; &nbsp; &nbsp;
                                                  int idx =
                                                  srcu_read_lock(&amp;kfd_processes_srcu);</div>
                                                <div class="">+</div>
                                                <div class="">+ &nbsp; &nbsp; &nbsp;
                                                  pr_info(&quot;Killing all
                                                  processes\n&quot;);</div>
                                                <div class="">+ &nbsp; &nbsp; &nbsp;
                                                  hash_for_each_rcu(kfd_processes_table,
                                                  temp, p,
                                                  kfd_processes) {</div>
                                                <div class="">+ &nbsp; &nbsp; &nbsp; &nbsp;
                                                  &nbsp; &nbsp; &nbsp; p_info =
                                                  p-&gt;kgd_process_info;</div>
                                                <div class="">+ &nbsp; &nbsp; &nbsp; &nbsp;
                                                  &nbsp; &nbsp; &nbsp; pr_info(&quot;Killing
                                                  &nbsp;processes, pid = %d&quot;,
pid_nr(p_info-&gt;pid));</div>
                                                <div class="">+ &nbsp; &nbsp; &nbsp; &nbsp;
                                                  &nbsp; &nbsp; &nbsp;
                                                  kill_pid(p_info-&gt;pid,
                                                  SIGBUS, 1);</div>
                                              </blockquote>
                                              <p class=""><br class="">
                                              </p>
                                              <p class="">From looking
                                                into kill_pid I see it
                                                only sends a signal but
                                                doesn't wait for
                                                completion, it would
                                                make sense to wait for
                                                completion here. In any
                                                case I would actually
                                                try to put here<span style="caret-color:
                                                  rgb(0, 0, 0);
                                                  font-family:
                                                  Helvetica; font-size:
                                                  12px; font-style:
                                                  normal;
                                                  font-variant-caps:
                                                  normal; font-weight:
                                                  400; letter-spacing:
                                                  normal; text-align:
                                                  start; text-indent:
                                                  0px; text-transform:
                                                  none; white-space:
                                                  normal; word-spacing:
                                                  0px;
                                                  -webkit-text-stroke-width:
                                                  0px; text-decoration:
                                                  none; float: none;
                                                  display: inline
                                                  !important;" class=""><br class="">
                                                </span></p>
                                            </div>
                                          </div>
                                        </blockquote>
                                        I have made a version which does
                                        that with some atomic counters.
                                        Please read later in the diff.<br class="">
                                        <blockquote type="cite" class="">
                                          <div class="">
                                            <div class="">
                                              <p class=""><span style="caret-color:
                                                  rgb(0, 0, 0);
                                                  font-family:
                                                  Helvetica; font-size:
                                                  12px; font-style:
                                                  normal;
                                                  font-variant-caps:
                                                  normal; font-weight:
                                                  400; letter-spacing:
                                                  normal; text-align:
                                                  start; text-indent:
                                                  0px; text-transform:
                                                  none; white-space:
                                                  normal; word-spacing:
                                                  0px;
                                                  -webkit-text-stroke-width:
                                                  0px; text-decoration:
                                                  none; float: none;
                                                  display: inline
                                                  !important;" class=""></span><span style="caret-color:
                                                  rgb(0, 0, 0);
                                                  font-family:
                                                  Helvetica; font-size:
                                                  12px; font-style:
                                                  normal;
                                                  font-variant-caps:
                                                  normal; font-weight:
                                                  400; letter-spacing:
                                                  normal; text-align:
                                                  start; text-indent:
                                                  0px; text-transform:
                                                  none; white-space:
                                                  normal; word-spacing:
                                                  0px;
                                                  -webkit-text-stroke-width:
                                                  0px; text-decoration:
                                                  none; float: none;
                                                  display: inline
                                                  !important;" class=""><font class="" size="4"><br class="">
                                                  </font></span></p>
                                              <p class=""><span style="caret-color:
                                                  rgb(0, 0, 0);
                                                  font-family:
                                                  Helvetica; font-size:
                                                  12px; font-style:
                                                  normal;
                                                  font-variant-caps:
                                                  normal; font-weight:
                                                  400; letter-spacing:
                                                  normal; text-align:
                                                  start; text-indent:
                                                  0px; text-transform:
                                                  none; white-space:
                                                  normal; word-spacing:
                                                  0px;
                                                  -webkit-text-stroke-width:
                                                  0px; text-decoration:
                                                  none; float: none;
                                                  display: inline
                                                  !important;" class=""><font class="" size="4">hash_for_each_rcu(</font></span><span style="caret-color:
                                                  rgb(0, 0, 0);
                                                  font-family:
                                                  Helvetica; font-size:
                                                  12px; font-style:
                                                  normal;
                                                  font-variant-caps:
                                                  normal; font-weight:
                                                  400; letter-spacing:
                                                  normal; text-align:
                                                  start; text-indent:
                                                  0px; text-transform:
                                                  none; white-space:
                                                  normal; word-spacing:
                                                  0px;
                                                  -webkit-text-stroke-width:
                                                  0px; text-decoration:
                                                  none; float: none;
                                                  display: inline
                                                  !important;" class=""><font class="" size="4">p_info)
                                                    &nbsp;&nbsp; <br class="">
                                                    &nbsp;&nbsp;&nbsp;
                                                    cancel_delayed_work_sync(&amp;</font></span><span style="caret-color:
                                                  rgb(0, 0, 0);
                                                  font-family:
                                                  Helvetica; font-size:
                                                  12px; font-style:
                                                  normal;
                                                  font-variant-caps:
                                                  normal; font-weight:
                                                  400; letter-spacing:
                                                  normal; text-align:
                                                  start; text-indent:
                                                  0px; text-transform:
                                                  none; white-space:
                                                  normal; word-spacing:
                                                  0px;
                                                  -webkit-text-stroke-width:
                                                  0px; text-decoration:
                                                  none; float: none;
                                                  display: inline
                                                  !important;" class=""><font class="" size="4"><span style="caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:
                                                      12px; font-style:
                                                      normal;
                                                      font-variant-caps:
                                                      normal;
                                                      font-weight: 400;
                                                      letter-spacing:
                                                      normal;
                                                      text-align: start;
                                                      text-indent: 0px;
                                                      text-transform:
                                                      none; white-space:
                                                      normal;
                                                      word-spacing: 0px;
-webkit-text-stroke-width: 0px; text-decoration: none; float: none;
                                                      display: inline
                                                      !important;" class=""></span><span style="caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:
                                                      12px; font-style:
                                                      normal;
                                                      font-variant-caps:
                                                      normal;
                                                      font-weight: 400;
                                                      letter-spacing:
                                                      normal;
                                                      text-align: start;
                                                      text-indent: 0px;
                                                      text-transform:
                                                      none; white-space:
                                                      normal;
                                                      word-spacing: 0px;
-webkit-text-stroke-width: 0px; text-decoration: none; float: none;
                                                      display: inline
                                                      !important;" class=""><font class="" size="4">p_info</font></span>-&gt;restore_userptr_work)
                                                    <br class="">
                                                  </font></span></p>
                                              <p class=""><span style="caret-color:
                                                  rgb(0, 0, 0);
                                                  font-family:
                                                  Helvetica; font-size:
                                                  12px; font-style:
                                                  normal;
                                                  font-variant-caps:
                                                  normal; font-weight:
                                                  400; letter-spacing:
                                                  normal; text-align:
                                                  start; text-indent:
                                                  0px; text-transform:
                                                  none; white-space:
                                                  normal; word-spacing:
                                                  0px;
                                                  -webkit-text-stroke-width:
                                                  0px; text-decoration:
                                                  none; float: none;
                                                  display: inline
                                                  !important;" class=""><font class="" size="4">instead&nbsp;
                                                    at least that what i
                                                    meant in the
                                                    previous mail.&nbsp;</font></span></p>
                                            </div>
                                          </div>
                                        </blockquote>
                                        <div class="">I actually tried
                                          that earlier, and it did not
                                          work. Application still keeps
                                          running, and you have to send
                                          a kill to the user process.</div>
                                        <div class=""><br class="">
                                        </div>
                                        <div class="">I have made the
                                          following version. It waits
                                          for processes to terminate
                                          synchronously after sending
                                          SIGBUS. After that it does the
                                          real work of
                                          amdgpu_pci_remove.</div>
                                        <div class="">However, it hangs
                                          at amdgpu_device_ip_fini_early
                                          when it is trying to deinit
                                          ip_block 6 &lt;sdma_v4_0&gt; (<a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux%2F-%2Fblob%2Famd-staging-drm-next%2Fdrivers%2Fgpu%2Fdrm%2Famd%2Famdgpu%2Famdgpu_device.c%23L2818&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7C78c882de9193490a3b4408da21d8132d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637859509203317436%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=rHsAHCgj8akFPDv6S3Td3GYgqEaWa6%2FhJ94fjH8k3%2Bg%3D&amp;reserved=0" originalsrc="https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L2818" shash="wzJT3UiLBUUZWNu2+yG8ZTXOPN2sT/aZCC63wxBnH48P8fmFOv2r0AIwILgRa8/YsjzgXOQHLZYH1czkYukM6y/UgtNa4IGWYVBY6TwSCcOHWnMOLFaNC0SBazwYqjpeacR3KF9DDlcy111NYAHSFHBvqtjGIrCbJZcPKOsoZ/Y=" class="" moz-do-not-send="true">https://gitlab.freedesktop.org/agd5f/linux/-/bl
 ob/amd-staging-drm-next/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L2818</a>).
                                          I assume that there are still
                                          some inflight dma, therefore
                                          fini of this ip block thus
                                          hangs?&nbsp;</div>
                                        <div class=""><br class="">
                                        </div>
                                        <div class="">The following is
                                          an excerpt of the dmesg:
                                          please excuse for putting my
                                          own pr_info, but I hope you
                                          get my point of where it
                                          hangs.</div>
                                        <div class=""><br class="">
                                        </div>
                                        <div class="">
                                          <div class="">[ &nbsp;392.344735]
                                            amdgpu: all processes has
                                            been fully released</div>
                                          <div class="">[ &nbsp;392.346557]
                                            amdgpu: amdgpu_acpi_fini
                                            done</div>
                                          <div class="">[ &nbsp;392.346568]
                                            amdgpu 0000:b3:00.0: amdgpu:
                                            amdgpu: finishing device.</div>
                                          <div class="">[ &nbsp;392.349238]
                                            amdgpu:
                                            amdgpu_device_ip_fini_early
                                            enter ip_blocks = 9</div>
                                          <div class="">[ &nbsp;392.349248]
                                            amdgpu: Free mem_obj =
                                            000000007bf54275,
                                            range_start = 14, range_end
                                            = 14</div>
                                          <div class="">[ &nbsp;392.350299]
                                            amdgpu: Free mem_obj =
                                            00000000a85bc878,
                                            range_start = 12, range_end
                                            = 12</div>
                                          <div class="">[ &nbsp;392.350304]
                                            amdgpu: Free mem_obj =
                                            00000000b8019e32,
                                            range_start = 13, range_end
                                            = 13</div>
                                          <div class="">[ &nbsp;392.350308]
                                            amdgpu: Free mem_obj =
                                            000000002d296168,
                                            range_start = 4, range_end =
                                            11</div>
                                          <div class="">[ &nbsp;392.350313]
                                            amdgpu: Free mem_obj =
                                            000000001fc4f934,
                                            range_start = 0, range_end =
                                            3</div>
                                          <div class="">[ &nbsp;392.350322]
                                            amdgpu:
                                            amdgpu_amdkfd_suspend(adev,
                                            false) done</div>
                                          <div class="">[ &nbsp;392.350672]
                                            amdgpu: hw_fini of IP
                                            block[8] &lt;jpeg_v2_5&gt;
                                            done 0</div>
                                          <div class="">[ &nbsp;392.350679]
                                            amdgpu: hw_fini of IP
                                            block[7] &lt;vcn_v2_5&gt;
                                            done 0</div>
                                        </div>
                                      </div>
                                    </blockquote>
                                    <p class=""><br class="">
                                    </p>
                                    <p class="">I just remembered that
                                      the idea to actively kill and wait
                                      for running user processes during
                                      unplug was rejected<br class="">
                                      as a bad idea in the first
                                      iteration of unplug work I did
                                      (don't remember why now, need to
                                      look) so this is a no go.<br class="">
                                    </p>
                                  </div>
                                </div>
                              </blockquote>
                              <div class="">Maybe an application has kfd
                                open, but was not accessing the dev. So
                                kill it at unplug could kill the process
                                unnecessarily.</div>
                              <div class="">However, the latest version
                                I had with the sleep function got rid of
                                the IP block fini hang.</div>
                              <blockquote type="cite" class="">
                                <div class="">
                                  <div class="">
                                    <p class="">Our policy is to let
                                      zombie processes (zombie in a
                                      sense that the underlying device
                                      is gone) live as long as they want
                                      <br class="">
                                      (as long as you able to terminate
                                      them - which you do, so that ok)<br class="">
                                      and the system should finish PCI
                                      remove gracefully and be able to
                                      hot plug back the device.&nbsp; Hence,
                                      i suggest dropping<br class="">
                                      this direction of forcing all user
                                      processes to be killed, confirm
                                      you have graceful shutdown and
                                      remove of device<br class="">
                                      from PCI topology and then
                                      concentrate on why when you plug
                                      back it hangs. </p>
                                  </div>
                                </div>
                              </blockquote>
                              So I basically revert back to the original
                              solution which you suggested.</div>
                            <div class=""><br class="">
                            </div>
                            <div class="">
                              <div class="">diff --git
                                a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
b/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
                              <div class="">index
                                4e7d9cb09a69..5504a18b5a45 100644</div>
                              <div class="">---
                                a/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
                              <div class="">+++
                                b/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
                              <div class="">@@ -697,7 +697,7 @@ void
                                kgd2kfd_suspend(struct kfd_dev *kfd,
                                bool run_pm, bool force)</div>
                              <div class="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return;</div>
                              <div class=""><br class="">
                              </div>
                              <div class="">&nbsp; &nbsp; &nbsp; &nbsp; /* for runtime
                                suspend, skip locking kfd */</div>
                              <div class="">- &nbsp; &nbsp; &nbsp; if (!run_pm) {</div>
                              <div class="">+ &nbsp; &nbsp; &nbsp; if (!run_pm
                                &amp;&amp;
                                !drm_dev_is_unplugged(kfd-&gt;ddev)) {</div>
                              <div class="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* For first
                                KFD device suspend all the KFD processes
                                */</div>
                              <div class="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if
                                (atomic_inc_return(&amp;kfd_locked) ==
                                1)</div>
                              <div class="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                kfd_suspend_all_processes(force);</div>
                            </div>
                            <div class=""><br class="">
                            </div>
                            <div class="">
                              <blockquote type="cite" class="">
                                <div class="">
                                  <p class="">First confirm if ASIC
                                    reset happens on<br class="">
                                    next init. </p>
                                </div>
                              </blockquote>
                              <div class="">
                                <div class="">This patch works great at
                                  <b class="">planned</b> plugout, where
                                  all the rocm processes are killed
                                  before plugout. And device can be
                                  added back without a problem.</div>
                                <div class="">However <b class="">unplanned</b>
                                  plugout when there is rocm processes
                                  are running just don’t work.</div>
                              </div>
                            </div>
                          </div>
                        </blockquote>
                        <p class=""><br class="">
                        </p>
                        <p class="">Still I am not clear if ASIC reset
                          happens on plug back or no, can you trace this
                          please ?</p>
                        <div class=""><br class="">
                        </div>
                      </div>
                    </div>
                  </blockquote>
                  <div class=""><br class="">
                  </div>
                  I tried add pr_info into asic_reset functions, but
                  cannot trace any upon plug-back.<br class="">
                </div>
              </blockquote>
              <p class=""><br class="">
              </p>
              <p class="">This could possibly explain the hang on plug
                back. Can you see why we don't get there ?<br class="">
              </p>
              <p class=""><br class="">
              </p>
            </div>
          </div>
        </blockquote>
        Is amdgpu supposed to asic_reset each time when it is probed? I
        right now it seems to probe ok (it did not hang). I will trace
        back further<br class="">
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>Yep</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:0FD33B90-BD27-4F32-9735-CA525735B5FA@microsoft.com">
      <div>
        <blockquote type="cite" class="">
          <div class="">
            <div class="">
              <blockquote type="cite" cite="mid:7825EEC6-BAF8-4B71-B01C-FE246D360779@microsoft.com" class="">
                <div class="">
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
                                  <p class="">Second please confirm if
                                    the timing you kill manually the
                                    user process has impact on whether
                                    you have a hang<br class="">
                                    on next plug back (if you kill
                                    before </p>
                                </div>
                              </blockquote>
                              <b class="">Scenario 0: Kill before plug
                                back</b></div>
                            <div class=""><br class="">
                            </div>
                            <div class="">
                              <div class="">1. echo 1 &gt;
                                /sys/bus/pci/…/remove, would finish.&nbsp;</div>
                              <div class="">But the application won’t
                                exit until there is a kill signal.</div>
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
                  Because rocm will need to release the drm descriptor
                  to get&nbsp;amdgpu_amdkfd_device_fini_sw called, which
                  would eventually call kgd2kfd_device_exit called. This
                  would clean up kfd_topology at least. Otherwise I
                  don’t see how it would be added back without messing
                  up kfd topology to say the least.&nbsp;</div>
                <div class=""><br class="">
                </div>
                <div class="">However, those are all based my own
                  observations. Please explain why it does not need exit
                  if you believe so?</div>
              </blockquote>
              <p class=""><br class="">
              </p>
              <p class="">Note that when you add back a new device, pci
                device and drm device are created, I am not an expert on
                KFD code but i believe also a new KFD device is created
                independent of the old one and so the topology should
                see just 2 device instances (one old zombie and one real
                new).&nbsp; I know at least this wasn't an issue for the
                graphic stack in exact same scenario and the libdrm
                tests i pointed to test exact this scenario.
              </p>
            </div>
          </div>
        </blockquote>
        Yes, regardless of the OOPS in ttm_bo_cleanup_refs, I plugged
        back the gpu, and I think it got probed all right, however the
        old kfd node is still there.</div>
      <div>I can passed libdrm basic test suite on the plugged back. The
        bo test hangs out-of-box even without hotplug (see dmesg below).</div>
      <div><br class="">
      </div>
      <div>
        <div>&nbsp;kernel:[ 1609.029125] watchdog: BUG: soft lockup - CPU#39
          stuck for 89s! [amdgpu_test:36407]</div>
        <div>[ &nbsp;+0.000407] Code: 48 89 47 18 48 89 47 20 48 89 47 28 48
          89 47 30 48 89 47 38 48 8d 7f 40 75 d9 90 c3 0f 1f 80 00 00 00
          00 b9 00 10 00 00 31 c0 &lt;f3&gt; aa c3 cc cc cc cc cc cc 0f
          1f 44 00 00 48 85 ff 0f 84 f2 00 00</div>
        <div>[ &nbsp;+0.000856] RSP: 0018:ffffb996b57b3c40 EFLAGS: 00010246</div>
        <div>[ &nbsp;+0.000434] RAX: 0000000000000000 RBX: ffff9cc7f8706e88
          RCX: 0000000000000980</div>
        <div>[ &nbsp;+0.000436] RDX: fffff935b17d9140 RSI: fffff935b17e0000
          RDI: ffff9c831f645680</div>
        <div>[ &nbsp;+0.000439] RBP: 0000000000000400 R08: fffff935b17d0000
          R09: 0000000000000000</div>
        <div>[ &nbsp;+0.000447] R10: 0000000000000000 R11: 0000000000000000
          R12: 000000000000000a</div>
        <div>[ &nbsp;+0.000437] R13: ffff9cc783980a20 R14: 000000000b5dbc00
          R15: ffff9cc7f8706078</div>
        <div>[ &nbsp;+0.000438] FS: &nbsp;00007ff1ef611300(0000)
          GS:ffff9d453efc0000(0000) knlGS:0000000000000000</div>
        <div>[ &nbsp;+0.000445] CS: &nbsp;0010 DS: 0000 ES: 0000 CR0:
          0000000080050033</div>
        <div>[ &nbsp;+0.000462] CR2: 00007f418bbb9320 CR3: 000000819fa84006
          CR4: 0000000000770ee0</div>
        <div>[ &nbsp;+0.000466] DR0: 0000000000000000 DR1: 0000000000000000
          DR2: 0000000000000000</div>
        <div>[ &nbsp;+0.000451] DR3: 0000000000000000 DR6: 00000000fffe0ff0
          DR7: 0000000000000400</div>
        <div>[ &nbsp;+0.000455] PKRU: 55555554</div>
        <div>[ &nbsp;+0.000451] Call Trace:</div>
        <div>[ &nbsp;+0.000448] &nbsp;ttm_pool_free+0x110/0x230 [ttm]</div>
        <div>[ &nbsp;+0.000451] &nbsp;ttm_tt_unpopulate+0x5e/0xb0 [ttm]</div>
        <div>[ &nbsp;+0.000454] &nbsp;ttm_tt_destroy_common+0xe/0x30 [ttm]</div>
        <div>[ &nbsp;+0.000453] &nbsp;amdgpu_ttm_backend_destroy+0x1e/0x70
          [amdgpu]</div>
        <div>[ &nbsp;+0.000569] &nbsp;ttm_bo_cleanup_memtype_use+0x37/0x60 [ttm]</div>
        <div>[ &nbsp;+0.000458] &nbsp;ttm_bo_release+0x286/0x500 [ttm]</div>
        <div>[ &nbsp;+0.000450] &nbsp;amdgpu_bo_unref+0x1a/0x30 [amdgpu]</div>
        <div>[ &nbsp;+0.000544] &nbsp;amdgpu_gem_object_free+0xad/0x160 [amdgpu]</div>
        <div>[ &nbsp;+0.000534] &nbsp;drm_gem_object_release_handle+0x6a/0x80
          [drm]</div>
        <div>[ &nbsp;+0.000476] &nbsp;drm_gem_handle_delete+0x5b/0xa0 [drm]</div>
        <div>[ &nbsp;+0.000465] &nbsp;? drm_gem_handle_create+0x40/0x40 [drm]</div>
        <div>[ &nbsp;+0.000469] &nbsp;drm_ioctl_kernel+0xab/0xf0 [drm]</div>
        <div>[ &nbsp;+0.000458] &nbsp;drm_ioctl+0x1ec/0x390 [drm]</div>
        <div>[ &nbsp;+0.000440] &nbsp;? drm_gem_handle_create+0x40/0x40 [drm]</div>
        <div>[ &nbsp;+0.000438] &nbsp;? selinux_file_ioctl+0x17d/0x220</div>
        <div>[ &nbsp;+0.000423] &nbsp;? lock_release+0x1ce/0x270</div>
        <div>[ &nbsp;+0.000416] &nbsp;? trace_hardirqs_on+0x1b/0xd0</div>
        <div>[ &nbsp;+0.000418] &nbsp;? _raw_spin_unlock_irqrestore+0x2d/0x40</div>
        <div>[ &nbsp;+0.000419] &nbsp;amdgpu_drm_ioctl+0x49/0x80 [amdgpu]</div>
        <div>[ &nbsp;+0.000499] &nbsp;__x64_sys_ioctl+0x80/0xb0</div>
        <div>[ &nbsp;+0.000414] &nbsp;do_syscall_64+0x3a/0x70</div>
        <div>[ &nbsp;+0.000400] &nbsp;entry_SYSCALL_64_after_hwframe+0x44/0xae</div>
        <div>[ &nbsp;+0.000387] RIP: 0033:0x7ff1ef7263db</div>
        <div>[ &nbsp;+0.000371] Code: 0f 1e fa 48 8b 05 b5 7a 0d 00 64 c7 00
          26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e
          fa b8 10 00 00 00 0f 05 &lt;48&gt; 3d 01 f0 ff ff 73 01 c3 48
          8b 0d 85 7a 0d 00 f7 d8 64 89 01 48</div>
        <div>[ &nbsp;+0.000763] RSP: 002b:00007ffdf1cd0278 EFLAGS: 00000246
          ORIG_RAX: 0000000000000010</div>
        <div>[ &nbsp;+0.000386] RAX: ffffffffffffffda RBX: 00007ffdf1cd02b0
          RCX: 00007ff1ef7263db</div>
        <div>[ &nbsp;+0.000383] RDX: 00007ffdf1cd02b0 RSI: 0000000040086409
          RDI: 0000000000000007</div>
        <div>[ &nbsp;+0.000396] RBP: 0000000040086409 R08: 00005574eefd5c60
          R09: 00005574eefdd360</div>
        <div>[ &nbsp;+0.000391] R10: 00005574eefd4010 R11: 0000000000000246
          R12: 00005574eefd66d8</div>
        <div>[ &nbsp;+0.000386] R13: 0000000000000007 R14: 0000000000000000
          R15: 00007ff1ef830143</div>
        <div><br class="">
        </div>
        <div><br class="">
        </div>
      </div>
      <div>I also tried to run tf benchmark to the newly plugged nodes
        (one of the node is dummy), but failed.&nbsp;</div>
      <div>Can we have some confirmation from kfd team that they have
        considered a zombie kfd node?</div>
      <div><br class="">
      </div>
      <div>
        <blockquote type="cite" class="">
          <div class="">
            <div class="">
              <p class="">Also note that even with running grpahic stack
                there is always a KFD device and KFD topology present
                but of course probably not the same as when u run a KFD
                facing process so there could be some issues there.
                <br class="">
              </p>
              <p class="">Also note that because of this patch <a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcommit%2F%3Fid%3D267d51d77fdae8708b94e1a24b8e5d961297edb7&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7C78c882de9193490a3b4408da21d8132d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637859509203317436%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=aIogHw9CZ7J6zBT5dJQChjtgRnSPeWzWfVjYokPwb9Q%3D&amp;reserved=0" originalsrc="https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=267d51d77fdae8708b94e1a24b8e5d961297edb7" shash="xp76mMXPp/33Rbf3ePI8pFYd4ePqE1eIR5yCCpW42XtBhtTDMZLxRVsbr/Vwmkg0jIFawJh5PyJtm7CwgSKimVUETnw8NlLdxR9B4KqGN63imqJJ2Yqmmh3WgInbycaWMzqpoSAVU0kHw3ZzXcyLVZ+a2agcaVV1ynuAA+iurcw=" moz-do-not-send="true">
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=267d51d77fdae8708b94e1a24b8e5d961297edb7</a>
                all MMIO accesses from such zombie/orphan user processes
                will be remapped to zero page and so will not
                necessarily experience a segfault when device removal
                happnes but rather maybe some crash due to NULL data
                read from MMIO by the process and used in some manner.
                <br class="">
              </p>
            </div>
          </div>
        </blockquote>
        It depends on where the application is when the device is
        plugged out.</div>
      <div><br class="">
      </div>
      <div>For example, in one case, the application keeps saying
        out-of-memory, but won’t exit.</div>
      <div>For one of the cases. The other case is that it would wait
        for a signal.</div>
      <div><br class="">
      </div>
      <div>
        <div>2022-04-18 12:42:38.939303: E
          tensorflow/stream_executor/rocm/<a href="https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Frocm_driver.cc%3A692%2F&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7C78c882de9193490a3b4408da21d8132d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637859509203317436%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=y%2Bkqeyw4HyTRWT3E5OHXbgUfSe3oDutSL0h4FNvjlIA%3D&amp;reserved=0" originalsrc="http://rocm_driver.cc:692/" shash="j9efKqMyTH5e34ZZsnbHqM8Vn48Ojm33XQ9yn5dCKRob91vu//7fMp6jqUCG3ydaBC48qTUGSYCWhcEMs2KqcqsSw5Urtg5cClgWXSARgZ7O6carSIaGoU+LWq4dmjTgCo5NwhrwwTl9RTgc9NCLJBxMtEd0hPFfDeqA6FVGmog=" class="" moz-do-not-send="true">rocm_driver.cc:692</a>]
          failed to alloc 2304 bytes on host: HIP_ERROR_OutOfMemory</div>
        <div>2022-04-18 12:42:38.939322: W
          ./tensorflow/core/common_runtime/gpu/gpu_host_allocator.h:44]
          could not allocate pinned host memory of size: 2304</div>
        <div>2022-04-18 12:42:38.940772: E
          tensorflow/stream_executor/rocm/<a href="https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Frocm_driver.cc%3A692%2F&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7C78c882de9193490a3b4408da21d8132d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637859509203317436%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=y%2Bkqeyw4HyTRWT3E5OHXbgUfSe3oDutSL0h4FNvjlIA%3D&amp;reserved=0" originalsrc="http://rocm_driver.cc:692/" shash="j9efKqMyTH5e34ZZsnbHqM8Vn48Ojm33XQ9yn5dCKRob91vu//7fMp6jqUCG3ydaBC48qTUGSYCWhcEMs2KqcqsSw5Urtg5cClgWXSARgZ7O6carSIaGoU+LWq4dmjTgCo5NwhrwwTl9RTgc9NCLJBxMtEd0hPFfDeqA6FVGmog=" class="" moz-do-not-send="true">rocm_driver.cc:692</a>]
          failed to alloc 2304 bytes on host: HIP_ERROR_OutOfMemory</div>
        <div>2022-04-18 12:42:38.940791: W
          ./tensorflow/core/common_runtime/gpu/gpu_host_allocator.h:44]
          could not allocate pinned host memory of size: 2304</div>
        <div>2022-04-18 12:42:38.942379: E
          tensorflow/stream_executor/rocm/<a href="https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Frocm_driver.cc%3A692%2F&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7C78c882de9193490a3b4408da21d8132d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637859509203317436%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=y%2Bkqeyw4HyTRWT3E5OHXbgUfSe3oDutSL0h4FNvjlIA%3D&amp;reserved=0" originalsrc="http://rocm_driver.cc:692/" shash="j9efKqMyTH5e34ZZsnbHqM8Vn48Ojm33XQ9yn5dCKRob91vu//7fMp6jqUCG3ydaBC48qTUGSYCWhcEMs2KqcqsSw5Urtg5cClgWXSARgZ7O6carSIaGoU+LWq4dmjTgCo5NwhrwwTl9RTgc9NCLJBxMtEd0hPFfDeqA6FVGmog=" class="" moz-do-not-send="true">rocm_driver.cc:692</a>]
          failed to alloc 2304 bytes on host: HIP_ERROR_OutOfMemory</div>
        <div>2022-04-18 12:42:38.942399: W
          ./tensorflow/core/common_runtime/gpu/gpu_host_allocator.h:44]
          could not allocate pinned host memory of size: 2304</div>
        <div>2022-04-18 12:42:38.943829: E
          tensorflow/stream_executor/rocm/<a href="https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Frocm_driver.cc%3A692%2F&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7C78c882de9193490a3b4408da21d8132d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637859509203317436%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=y%2Bkqeyw4HyTRWT3E5OHXbgUfSe3oDutSL0h4FNvjlIA%3D&amp;reserved=0" originalsrc="http://rocm_driver.cc:692/" shash="j9efKqMyTH5e34ZZsnbHqM8Vn48Ojm33XQ9yn5dCKRob91vu//7fMp6jqUCG3ydaBC48qTUGSYCWhcEMs2KqcqsSw5Urtg5cClgWXSARgZ7O6carSIaGoU+LWq4dmjTgCo5NwhrwwTl9RTgc9NCLJBxMtEd0hPFfDeqA6FVGmog=" class="" moz-do-not-send="true">rocm_driver.cc:692</a>]
          failed to alloc 2304 bytes on host: HIP_ERROR_OutOfMemory</div>
        <div>2022-04-18 12:42:38.943849: W
          ./tensorflow/core/common_runtime/gpu/gpu_host_allocator.h:44]
          could not allocate pinned host memory of size: 2304</div>
        <div>2022-04-18 12:42:38.945272: E
          tensorflow/stream_executor/rocm/<a href="https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Frocm_driver.cc%3A692%2F&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7C78c882de9193490a3b4408da21d8132d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637859509203317436%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=y%2Bkqeyw4HyTRWT3E5OHXbgUfSe3oDutSL0h4FNvjlIA%3D&amp;reserved=0" originalsrc="http://rocm_driver.cc:692/" shash="j9efKqMyTH5e34ZZsnbHqM8Vn48Ojm33XQ9yn5dCKRob91vu//7fMp6jqUCG3ydaBC48qTUGSYCWhcEMs2KqcqsSw5Urtg5cClgWXSARgZ7O6carSIaGoU+LWq4dmjTgCo5NwhrwwTl9RTgc9NCLJBxMtEd0hPFfDeqA6FVGmog=" class="" moz-do-not-send="true">rocm_driver.cc:692</a>]
          failed to alloc 2304 bytes on host: HIP_ERROR_OutOfMemory</div>
        <div>2022-04-18 12:42:38.945292: W
          ./tensorflow/core/common_runtime/gpu/gpu_host_allocator.h:44]
          could not allocate pinned host memory of size: 2304</div>
      </div>
      <div>
        <div><br class="">
        </div>
      </div>
      <div>
        <blockquote type="cite" class="">
          <div class="">
            <div class="">
              <p class=""><br class="">
              </p>
              <blockquote type="cite" cite="mid:7825EEC6-BAF8-4B71-B01C-FE246D360779@microsoft.com" class="">
                <div class="">
                  <blockquote type="cite" class="">
                    <div class="">
                      <div class="">
                        <blockquote type="cite" cite="mid:76C16B06-0539-48EE-AB11-80089490CE3A@microsoft.com" class="">
                          <div class="">
                            <div class="">
                              <div class=""><br class="">
                              </div>
                              <div class="">2. kill the the process. The
                                application does several things and
                                seems trigger drm_release in the kernel,
                                which are met with kernel NULL pointer
                                deference related to sysfs_remove. Then
                                the whole fs just freeze.</div>
                              <div class=""><br class="">
                              </div>
                              <div class="">
                                <div class="">[ &nbsp;+0.002498] BUG: kernel
                                  NULL pointer dereference, address:
                                  0000000000000098</div>
                                <div class="">[ &nbsp;+0.000486] #PF:
                                  supervisor read access in kernel mode</div>
                                <div class="">[ &nbsp;+0.000545] #PF:
                                  error_code(0x0000) - not-present page</div>
                                <div class="">[ &nbsp;+0.000551] PGD 0 P4D 0</div>
                                <div class="">[ &nbsp;+0.000553] Oops: 0000
                                  [#1] SMP NOPTI</div>
                                <div class="">[ &nbsp;+0.000540] CPU: 75 PID:
                                  4911 Comm: kworker/75:2 Tainted: G &nbsp; &nbsp;
                                  &nbsp; &nbsp;W &nbsp; E &nbsp; &nbsp; 5.13.0-kfd #1</div>
                                <div class="">[ &nbsp;+0.000559] Hardware
                                  name: INGRASYS &nbsp; &nbsp; &nbsp; &nbsp; TURING &nbsp;/MB &nbsp; &nbsp;
                                  &nbsp;, BIOS K71FQ28A 10/05/2021</div>
                                <div class="">[ &nbsp;+0.000567] Workqueue:
                                  events delayed_fput</div>
                                <div class="">[ &nbsp;+0.000563] RIP:
                                  0010:kernfs_find_ns+0x1b/0x100</div>
                                <div class="">[ &nbsp;+0.000569] Code: ff ff
                                  e8 88 59 9f 00 0f 1f 84 00 00 00 00 00
                                  0f 1f 44 00 00 41 57 8b 05 df f0 7b 01
                                  41 56 41 55 49 89 f5 41 54 55 48 89 fd
                                  53 &lt;44&gt; 0f b7 b7 98 00 00 00 48
                                  89 d3 4c 8b 67 70 66 41 83 e6 20 41 0f</div>
                                <div class="">[ &nbsp;+0.001193] RSP:
                                  0018:ffffb9875db5fc98 EFLAGS: 00010246</div>
                                <div class="">[ &nbsp;+0.000602] RAX:
                                  0000000000000000 RBX: ffffa101f79507d8
                                  RCX: 0000000000000000</div>
                                <div class="">[ &nbsp;+0.000612] RDX:
                                  0000000000000000 RSI: ffffffffc09a9417
                                  RDI: 0000000000000000</div>
                                <div class="">[ &nbsp;+0.000604] RBP:
                                  0000000000000000 R08: 0000000000000001
                                  R09: 0000000000000000</div>
                                <div class="">[ &nbsp;+0.000760] R10:
                                  ffffb9875db5fcd0 R11: 0000000000000000
                                  R12: 0000000000000000</div>
                                <div class="">[ &nbsp;+0.000597] R13:
                                  ffffffffc09a9417 R14: ffffa08363fb2d18
                                  R15: 0000000000000000</div>
                                <div class="">[ &nbsp;+0.000702] FS:
                                  &nbsp;0000000000000000(0000)
                                  GS:ffffa0ffbfcc0000(0000)
                                  knlGS:0000000000000000</div>
                                <div class="">[ &nbsp;+0.000666] CS: &nbsp;0010
                                  DS: 0000 ES: 0000 CR0:
                                  0000000080050033</div>
                                <div class="">[ &nbsp;+0.000658] CR2:
                                  0000000000000098 CR3: 0000005747812005
                                  CR4: 0000000000770ee0</div>
                                <div class="">[ &nbsp;+0.000715] DR0:
                                  0000000000000000 DR1: 0000000000000000
                                  DR2: 0000000000000000</div>
                                <div class="">[ &nbsp;+0.000655] DR3:
                                  0000000000000000 DR6: 00000000fffe0ff0
                                  DR7: 0000000000000400</div>
                                <div class="">[ &nbsp;+0.000592] PKRU:
                                  55555554</div>
                                <div class="">[ &nbsp;+0.000580] Call Trace:</div>
                                <div class="">[ &nbsp;+0.000591]
                                  &nbsp;kernfs_find_and_get_ns+0x2f/0x50</div>
                                <div class="">[ &nbsp;+0.000584]
                                  &nbsp;sysfs_remove_file_from_group+0x20/0x50</div>
                                <div class="">[ &nbsp;+0.000580]
                                  &nbsp;amdgpu_ras_sysfs_remove+0x3d/0xd0
                                  [amdgpu]</div>
                                <div class="">[ &nbsp;+0.000737]
                                  &nbsp;amdgpu_ras_late_fini+0x1d/0x40
                                  [amdgpu]</div>
                                <div class="">[ &nbsp;+0.000750]
                                  &nbsp;amdgpu_sdma_ras_fini+0x96/0xb0
                                  [amdgpu]</div>
                                <div class="">[ &nbsp;+0.000742] &nbsp;?
                                  gfx_v10_0_resume+0x10/0x10 [amdgpu]</div>
                                <div class="">[ &nbsp;+0.000738]
                                  &nbsp;sdma_v4_0_sw_fini+0x23/0x90 [amdgpu]</div>
                                <div class="">[ &nbsp;+0.000717]
                                  &nbsp;amdgpu_device_fini_sw+0xae/0x260
                                  [amdgpu]</div>
                                <div class="">[ &nbsp;+0.000704]
                                  &nbsp;amdgpu_driver_release_kms+0x12/0x30
                                  [amdgpu]</div>
                                <div class="">[ &nbsp;+0.000687]
                                  &nbsp;drm_dev_release+0x20/0x40 [drm]</div>
                                <div class="">[ &nbsp;+0.000583]
                                  &nbsp;drm_release+0xa8/0xf0 [drm]</div>
                                <div class="">[ &nbsp;+0.000584]
                                  &nbsp;__fput+0xa5/0x250</div>
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
                                <div class="">[ &nbsp;+0.000605]
                                  &nbsp;kthread+0x117/0x150</div>
                                <div class="">[ &nbsp;+0.000611] &nbsp;?
                                  kthread_park+0x90/0x90</div>
                                <div class="">[ &nbsp;+0.000619]
                                  &nbsp;ret_from_fork+0x1f/0x30</div>
                                <div class="">[ &nbsp;+0.000625] Modules
                                  linked in: amdgpu(E) xt_conntrack
                                  xt_MASQUERADE nfnetlink xt_addrtype
                                  iptable_filter iptable_nat nf_nat
                                  nf_conntrack nf_defrag_ipv6
                                  nf_defrag_ipv4 br_netfilter
                                  x86_pkg_temp_thermal cdc_ether usbnet
                                  acpi_pad msr ip_tables x_tables ast
                                  drm_vram_helper iommu_v2
                                  drm_ttm_helper gpu_sched ttm
                                  drm_kms_helper cfbfillrect syscopyarea
                                  cfbimgblt sysfillrect sysimgblt
                                  fb_sys_fops cfbcopyarea drm
                                  drm_panel_orientati</div>
                                <div class="">on_quirks [last unloaded:
                                  amdgpu]</div>
                              </div>
                            </div>
                          </div>
                        </blockquote>
                        <p class=""><br class="">
                        </p>
                        <p class="">This is a known regression, all
                          SYSFS components must be removed before
                          pci_remove code runs otherwise you get either
                          warnings for single file removals or<br class="">
                          OOPSEs for sysfs gorup removals like here.
                          Please try to move amdgpu_ras_sysfs_remove
                          from amdgpu_ras_late_fini to the end of
                          amdgpu_ras_pre_fini (which happens before pci
                          remove)</p>
                        <div class=""><br class="">
                        </div>
                      </div>
                    </div>
                  </blockquote>
                  <div class=""><br class="">
                  </div>
                  I fixed it in the newer patch, please see it below.</div>
              </blockquote>
              <p class=""><br class="">
              </p>
              <p class=""><br class="">
              </p>
              <blockquote type="cite" cite="mid:7825EEC6-BAF8-4B71-B01C-FE246D360779@microsoft.com" class="">
                <div class="">I first plugout the device, then kill the
                  rocm user process. Then it has other OOPSES related to
                  ttm_bo_cleanup_refs.</div>
                <div class=""><br class="">
                </div>
                <div class="">[ &nbsp;+0.000006] BUG: kernel NULL pointer
                  dereference, address: 0000000000000010<br class="">
                  [ &nbsp;+0.000349] #PF: supervisor read access in kernel
                  mode<br class="">
                  [ &nbsp;+0.000340] #PF: error_code(0x0000) - not-present
                  page<br class="">
                  [ &nbsp;+0.000341] PGD 0 P4D 0<br class="">
                  [ &nbsp;+0.000336] Oops: 0000 [#1] SMP NOPTI<br class="">
                  [ &nbsp;+0.000345] CPU: 9 PID: 95 Comm: kworker/9:1
                  Tainted: G &nbsp; &nbsp; &nbsp; &nbsp;W &nbsp; E &nbsp; &nbsp; 5.13.0-kfd #1<br class="">
                  [ &nbsp;+0.000367] Hardware name: INGRASYS &nbsp; &nbsp; &nbsp; &nbsp; TURING
                  &nbsp;/MB &nbsp; &nbsp; &nbsp;, BIOS K71FQ28A 10/05/2021<br class="">
                  [ &nbsp;+0.000376] Workqueue: events delayed_fput<br class="">
                  [ &nbsp;+0.000422] RIP: 0010:ttm_resource_free+0x24/0x40
                  [ttm]<br class="">
                  [ &nbsp;+0.000464] Code: 00 00 0f 1f 40 00 0f 1f 44 00 00
                  53 48 89 f3 48 8b 36 48 85 f6 74 21 48 8b 87 28 02 00
                  00 48 63 56 10 48 8b bc d0 b8 00 00 00 &lt;48&gt; 8b
                  47 10 ff 50 08 48 c7 03 00 00 00 00 5b c3 66 66 2e 0f
                  1f 84<br class="">
                  [ &nbsp;+0.001009] RSP: 0018:ffffb21c59413c98 EFLAGS:
                  00010282<br class="">
                  [ &nbsp;+0.000515] RAX: ffff8b1aa4285f68 RBX:
                  ffff8b1a823b5ea0 RCX: 00000000002a000c<br class="">
                  [ &nbsp;+0.000536] RDX: 0000000000000000 RSI:
                  ffff8b1acb84db80 RDI: 0000000000000000<br class="">
                  [ &nbsp;+0.000539] RBP: 0000000000000001 R08:
                  0000000000000000 R09: ffffffffc03c3e00<br class="">
                  [ &nbsp;+0.000543] R10: 0000000000000000 R11:
                  0000000000000000 R12: ffff8b1a823b5ec8<br class="">
                  [ &nbsp;+0.000542] R13: 0000000000000000 R14:
                  ffff8b1a823b5d90 R15: ffff8b1a823b5ec8<br class="">
                  [ &nbsp;+0.000544] FS: &nbsp;0000000000000000(0000)
                  GS:ffff8b187f440000(0000) knlGS:0000000000000000<br class="">
                  [ &nbsp;+0.000559] CS: &nbsp;0010 DS: 0000 ES: 0000 CR0:
                  0000000080050033<br class="">
                  [ &nbsp;+0.000575] CR2: 0000000000000010 CR3:
                  00000076e6812004 CR4: 0000000000770ee0<br class="">
                  [ &nbsp;+0.000575] DR0: 0000000000000000 DR1:
                  0000000000000000 DR2: 0000000000000000<br class="">
                  [ &nbsp;+0.000579] DR3: 0000000000000000 DR6:
                  00000000fffe0ff0 DR7: 0000000000000400<br class="">
                  [ &nbsp;+0.000575] PKRU: 55555554<br class="">
                  [ &nbsp;+0.000568] Call Trace:<br class="">
                  [ &nbsp;+0.000567] &nbsp;ttm_bo_cleanup_refs+0xe4/0x290 [ttm]<br class="">
                  [ &nbsp;+0.000588] &nbsp;ttm_bo_delayed_delete+0x147/0x250 [ttm]<br class="">
                  [ &nbsp;+0.000589] &nbsp;ttm_device_fini+0xad/0x1b0 [ttm]<br class="">
                  [ &nbsp;+0.000590] &nbsp;amdgpu_ttm_fini+0x2a7/0x310 [amdgpu]<br class="">
                  [ &nbsp;+0.000730] &nbsp;gmc_v9_0_sw_fini+0x3a/0x40 [amdgpu]<br class="">
                  [ &nbsp;+0.000753] &nbsp;amdgpu_device_fini_sw+0xae/0x260
                  [amdgpu]<br class="">
                  [ &nbsp;+0.000734] &nbsp;amdgpu_driver_release_kms+0x12/0x30
                  [amdgpu]<br class="">
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
                  [ &nbsp;+0.000603] Modules linked in: amdgpu(E)
                  xt_conntrack xt_MASQUERADE nfnetlink xt_addrtype
                  iptable_filter iptable_nat nf_nat nf_conntrack
                  nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter
                  x86_pkg_temp_thermal cdc_ether usbnet acpi_pad msr
                  ip_tables x_tables ast drm_vram_helper drm_ttm_helper
                  iommu_v2 ttm gpu_sched drm_kms_helper cfbfillrect
                  syscopyarea cfbimgblt sysfillrect sysimgblt
                  fb_sys_fops cfbcopyarea drm
                  drm_panel_orientation_quirks [last unloaded: amdgpu]<br class="">
                  [ &nbsp;+0.002840] CR2: 0000000000000010<br class="">
                  <div class="">
                    <div class=""><font class=""><span style="caret-color: rgb(0, 0, 0);" class="">[
                          &nbsp;+0.000755] ---[ end trace 9737737402551e39
                          ]--</span></font></div>
                  </div>
                </div>
              </blockquote>
              <p class=""><br class="">
              </p>
              <p class="">This looks like another regression - try
                seeing where is the NULL reference and then we can see
                how to avoid this.
                <br class="">
              </p>
              <p class=""><br class="">
              </p>
            </div>
          </div>
        </blockquote>
        Those are the line of code.</div>
      <div><br class="">
        <div>(gdb) l *(ttm_bo_cleanup_refs+0xe4)</div>
        <div>0x19c4 is in ttm_bo_cleanup_refs
          (drivers/gpu/drm/ttm/ttm_bo.c:360).</div>
        <div>355 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ttm_bo_move_to_pinned(bo);</div>
        <div>356 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; list_del_init(&amp;bo-&gt;ddestroy);</div>
        <div>357 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; spin_unlock(&amp;bo-&gt;bdev-&gt;lru_lock);</div>
        <div><font class="" color="#ff2600">358 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            ttm_bo_cleanup_memtype_use(bo);</font></div>
        <div>359</div>
        <div>360 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (unlock_resv)</div>
        <div>361 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          dma_resv_unlock(amdkcl_ttm_resvp(bo));</div>
        <div>362</div>
        <div>363 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ttm_bo_put(bo);</div>
        <div>364</div>
        <div>(gdb) l *(ttm_resource_free+0x24)</div>
        <div>0x57f4 is in ttm_resource_free
          (drivers/gpu/drm/ttm/ttm_resource.c:65).</div>
        <div>60</div>
        <div>61 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (!*res)</div>
        <div>62 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return;</div>
        <div>63</div>
        <div>64 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;man = ttm_manager_type(bo-&gt;bdev,
          (*res)-&gt;mem_type);</div>
        <div><font class="" color="#ff2600">65 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp;man-&gt;func-&gt;free(man, *res);</font></div>
        <div>66 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*res = NULL;</div>
        <div>67 &nbsp; &nbsp; &nbsp;}</div>
        <div>68 &nbsp; &nbsp; &nbsp;EXPORT_SYMBOL(ttm_resource_free);</div>
        <div>69</div>
        <blockquote type="cite" class="">
          <div class="">
            <div class="">
              <blockquote type="cite" cite="mid:7825EEC6-BAF8-4B71-B01C-FE246D360779@microsoft.com" class="">
                <div class="">
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
                                <div class="">3. &nbsp;echo 1 &gt;
                                  /sys/bus/pci/rescan. This would just
                                  hang. I assume the sysfs is broken.</div>
                                <div class=""><br class="">
                                </div>
                                <div class="">Based on 1 &amp; 2, it
                                  seems that 1 won’t let the amdgpu exit
                                  gracefully, because 2 will do some
                                  cleanup maybe should have happened
                                  before 1.</div>
                                <div class="">
                                  <blockquote type="cite" class="">
                                    <div class="">
                                      <p class="">or you kill after plug
                                        back does it makes a
                                        difference).&nbsp;<br class="">
                                      </p>
                                    </div>
                                  </blockquote>
                                </div>
                                <div class=""><b class="">Scenario 2:
                                    Kill after plug back</b></div>
                                <div class=""><br class="">
                                </div>
                                <div class="">If I perform rescan before
                                  kill, then the driver seemed probed
                                  fine. But kill will have the same
                                  issue which messed up the sysfs the
                                  same way as in Scenario 2.</div>
                                <div class=""><br class="">
                                </div>
                                <div class=""><br class="">
                                </div>
                                <div class=""><b class="">Final
                                    Comments:</b></div>
                                <div class=""><br class="">
                                </div>
                                <span class="">0.&nbsp;cancel_delayed_work_sync(&amp;p_info-&gt;restore_userptr_work)
                                  would&nbsp;make the&nbsp;repletion of
                                </span>amdgpu_vm_bo_update failure go
                                away, but it does not solve the issues
                                in those scenarios.</div>
                            </div>
                          </div>
                        </blockquote>
                        <p class=""><br class="">
                        </p>
                        <p class="">Still - it's better to do it this
                          way even for those failures to go awaya</p>
                        <div class=""><br class="">
                        </div>
                      </div>
                    </div>
                  </blockquote>
                  Cancel_delayed_work is insufficient, you will need to
                  make sure the work won’t be processed after plugout.
                  Please see my patch<br class="">
                </div>
              </blockquote>
              <p class=""><br class="">
              </p>
              <p class="">Saw, see my comment.</p>
              <p class=""><br class="">
              </p>
              <blockquote type="cite" cite="mid:7825EEC6-BAF8-4B71-B01C-FE246D360779@microsoft.com" class="">
                <div class="">
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
                                <div class="">1. For planned hotplug,
                                  this patch should work as long as you
                                  follow some protocol, i.e. kill before
                                  plugout. Is this patch an acceptable
                                  one since it provides some added
                                  feature than before?</div>
                              </div>
                            </div>
                          </div>
                        </blockquote>
                        <p class=""><br class="">
                        </p>
                        <p class="">Let's try to fix more as I advised
                          above. <br class="">
                        </p>
                        <p class=""><br class="">
                        </p>
                        <blockquote type="cite" cite="mid:76C16B06-0539-48EE-AB11-80089490CE3A@microsoft.com" class="">
                          <div class="">
                            <div class="">
                              <div class="">
                                <div class=""><br class="">
                                </div>
                                <div class="">2. For unplanned hotplug
                                  when there is rocm app running, the
                                  patch that kill all processes and wait
                                  for 5 sec would work consistently. But
                                  it seems that it is an unacceptable
                                  solution for official release. I can
                                  hold it for our own internal usage.
                                  &nbsp;It seems that kill after removal
                                  would cause problems, and I don’t know
                                  if there is a quick fix by me because
                                  of my limited understanding of the
                                  amdgpu driver. Maybe AMD could have a
                                  quick fix; Or it is really a difficult
                                  one. This feature may or may not be a
                                  blocking issue in our GPU
                                  disaggregation research down the way.
                                  Please let us know for either cases,
                                  and we would like to learn and help as
                                  much as we could!</div>
                              </div>
                            </div>
                          </div>
                        </blockquote>
                        <p class=""><br class="">
                        </p>
                        <p class="">I am currently not sure why it
                          helps. I will need to setup my own ROCm setup
                          and retest hot plug to check this in more
                          depth but currently i have higher priorities.
                          Please try to confirm ASIC reset always takes
                          place on plug back<br class="">
                          and fix the sysfs OOPs as I advised above to
                          clear up at least some of the issues. Also
                          please describe to me exactly what you steps
                          to reproduce this scenario so later I might be
                          able to do it myself.</p>
                        <div class=""><br class="">
                        </div>
                      </div>
                    </div>
                  </blockquote>
                  <div class="">I can still try to help to fix the bug
                    in my spare time. My setup is as follows</div>
                  <div class=""><br class="">
                  </div>
                  <div class="">
                    <ol class="">
                      <li class="">I have a server with 4 AMD MI100
                        GPUs. I think 1 GPU would also work.</li>
                      <li class="">I used the&nbsp;<a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Ftree%2Froc-5.0.x&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7C78c882de9193490a3b4408da21d8132d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637859509203317436%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=7evLdVmTyf7MAADp0k4Gkjl1KwNYqMfqYTJiZbSr8tk%3D&amp;reserved=0" originalsrc="https://github.com/RadeonOpenCompute/ROCK-Kernel-Driver/tree/roc-5.0.x" shash="hpeezMtd/3HvH2frcoqlvhVNBz4i2wfjvJM0hIlb/ng6a7TTZGyw8hsKAnWAG3C6JNa5md0J6G84I2NSTM5Kx3/S6YJv2itTBcdQ/HydWDQ7es/eLvfIW2x4HAnPdQD1AL10Y6TH+5E6kWfv6AqzqXJa/ECKiEVN5nxJ3GgAkFc=" class="" moz-do-not-send="true">https://github.com/RadeonOpenCompute/ROCK-Kernel-Driver/tree/roc-5.0.x</a>&nbsp;as
                        the starting point, and apply Mukul’s patch and
                        my patch.</li>
                      <li class="">Then I run a tensorflow benchmark
                        from a docker.</li>
                      <ul class="">
                        <li class="">docker run -it --device=/dev/kfd
                          --device=/dev/dri --group-add video
                          rocm/tensorflow:rocm4.5.2-tf1.15-dev</li>
                        <li class="">And run the following benchmark in
                          the docker: &nbsp;python
                          benchmarks/scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py
                          --num_gpus=4 --batch_size=32 --model=resnet50
                          --variable_update=parameter_server</li>
                        <ul class="">
                          <li class="">Might to need to adjust num_gpus
                            parameter based on your setup</li>
                        </ul>
                      </ul>
                      <li class="">Remove a GPU at random time.</li>
                      <li class="">Do whatever is needed to before
                        plugback and reverify the benchmark can still
                        run.</li>
                    </ol>
                  </div>
                  <blockquote type="cite" class="">
                    <div class="">
                      <div class="">
                        <p class="">Also, we have hotplug test suite in
                          libdrm (graphic stack), so maybe u can install
                          libdrm and run that test suite to see if it
                          exposes more issues.<br class="">
                        </p>
                      </div>
                    </div>
                  </blockquote>
                  OK I could try it some time.</div>
                <div class=""><br class="">
                </div>
              </blockquote>
            </div>
          </div>
        </blockquote>
        <div><br class="">
        </div>
        <div>I tried suite 13, the hotplugout test, but it says it got
          killed? There are a some oops from dmesg during
          ttm_pool_free_page.</div>
        <div><br class="">
        </div>
        <div>Userspace log:</div>
        <div><br class="">
        </div>
        <div>$ sudo ./tests/amdgpu/amdgpu_test -f -s 13</div>
        <div><br class="">
        </div>
        <div><br class="">
        </div>
        <div>The ASIC NOT support UVD, suite disabled</div>
        <div><br class="">
        </div>
        <div><br class="">
        </div>
        <div>The ASIC NOT support VCE, suite disabled</div>
        <div><br class="">
        </div>
        <div><br class="">
        </div>
        <div>The ASIC NOT support UVD ENC, suite disabled.</div>
        <div><br class="">
        </div>
        <div><br class="">
        </div>
        <div>Don't support TMZ (trust memory zone), security suite
          disabled</div>
        <div><br class="">
        </div>
        <div><br class="">
        </div>
        <div>&nbsp; &nbsp; &nbsp;CUnit - A unit testing framework for C - Version 2.1-3</div>
        <div>&nbsp; &nbsp; &nbsp;<a href="https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fcunit.sourceforge.net%2F&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7C78c882de9193490a3b4408da21d8132d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637859509203317436%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=Y%2F6RnXqHvigeTXjCIJDEsslzNm0mtTOhsftckL2WGaI%3D&amp;reserved=0" originalsrc="http://cunit.sourceforge.net/" shash="nW0ggAP7FZPTvSfJAresJBsCw+3fCo94jTUZPxNGQWIunXfGRa1oJLWCsdJyl9KbSDZbD9uZecohyzcY0FaARnR11Ea6Ce5aAMzblHrV31yZKbiQPyWBaHOtMZu0zJhaw7xyhH4KODdnYZ40o5Xi/aKLCU1w/qMTHP6oTG+lwWw=" class="" moz-do-not-send="true">http://cunit.sourceforge.net/</a></div>
        <div><br class="">
        </div>
        <div><br class="">
        </div>
        <div>Suite: Hotunplug Tests</div>
        <div>&nbsp; Test: Unplug card and rescan the bus to plug it back
          …Killed</div>
        <div><br class="">
        </div>
        <div>Dmesg log:</div>
        <div>
          <div>[ &nbsp;+0.000479] BUG: unable to handle page fault for
            address: ffffc01343fc81b4</div>
          <div>[ &nbsp;+0.000054] #PF: supervisor write access in kernel mode</div>
          <div>[ &nbsp;+0.000033] #PF: error_code(0x0002) - not-present page</div>
          <div>[ &nbsp;+0.000032] PGD 807ffc1067 P4D 807ffc1067 PUD
            807ffc0067 PMD 0</div>
          <div>[ &nbsp;+0.000038] Oops: 0002 [#1] SMP NOPTI</div>
          <div>[ &nbsp;+0.000025] CPU: 92 PID: 7534 Comm: amdgpu_test
            Tainted: G &nbsp; &nbsp; &nbsp; &nbsp;W &nbsp; E &nbsp; &nbsp; 5.13.0-kfd #1</div>
          <div>[ &nbsp;+0.000048] Hardware name: INGRASYS &nbsp; &nbsp; &nbsp; &nbsp; TURING &nbsp;/MB
            &nbsp; &nbsp; &nbsp;, BIOS K71FQ28A 10/05/2021</div>
          <div>[ &nbsp;+0.000045] RIP: 0010:__free_pages+0xc/0x80</div>
          <div>[ &nbsp;+0.000031] Code: 01 00 74 0f 0f b6 77 51 85 f6 74 07
            31 d2 e9 3b dc ff ff e9 66 ff ff ff 66 0f 1f 44 00 00 0f 1f
            44 00 00 41 54 55 48 89 fd 53 &lt;f0&gt; ff 4f 34 74 46 48
            8b 07 a9 00 00 01 00 75 54 44 8d 66 ff 85 f6</div>
          <div>[ &nbsp;+0.000103] RSP: 0018:ffff96f71ba6fd60 EFLAGS: 00010246</div>
          <div>[ &nbsp;+0.000032] RAX: 00000000ffffffff RBX: ffff89f1ccf86078
            RCX: 0000000003fc8180</div>
          <div>[ &nbsp;+0.000041] RDX: ffff89f1b4746000 RSI: 0000000000000000
            RDI: ffffc01343fc8180</div>
          <div>[ &nbsp;+0.000042] RBP: ffffc01343fc8180 R08: 0000000000000000
            R09: 0000000000000246</div>
          <div>[ &nbsp;+0.000040] R10: 00000080b4746fff R11: 0000000000000003
            R12: 0000000000000000</div>
          <div>[ &nbsp;+0.000041] R13: ffff89f1ccf85f80 R14: ffff89f1ccf86ef8
            R15: ffff8972293b0000</div>
          <div>[ &nbsp;+0.000042] FS: &nbsp;00007fcfb843a300(0000)
            GS:ffff89ef80100000(0000) knlGS:0000000000000000</div>
          <div>[ &nbsp;+0.000046] CS: &nbsp;0010 DS: 0000 ES: 0000 CR0:
            0000000080050033</div>
          <div>[ &nbsp;+0.000033] CR2: ffffc01343fc81b4 CR3: 0000000178154006
            CR4: 0000000000770ee0</div>
          <div>[ &nbsp;+0.000041] DR0: 0000000000000000 DR1: 0000000000000000
            DR2: 0000000000000000</div>
          <div>[ &nbsp;+0.000041] DR3: 0000000000000000 DR6: 00000000fffe0ff0
            DR7: 0000000000000400</div>
          <div>[ &nbsp;+0.000041] PKRU: 55555554</div>
          <div>[ &nbsp;+0.000017] Call Trace:</div>
          <div>[ &nbsp;+0.000018] &nbsp;ttm_pool_free_page+0x69/0x90 [ttm]</div>
          <div>[ &nbsp;+0.000038] &nbsp;ttm_pool_type_fini+0x58/0x70 [ttm]</div>
          <div>[ &nbsp;+0.000034] &nbsp;ttm_pool_fini+0x30/0x50 [ttm]</div>
          <div>[ &nbsp;+0.000031] &nbsp;ttm_device_fini+0xf3/0x1b0 [ttm]</div>
          <div>[ &nbsp;+0.000032] &nbsp;amdgpu_ttm_fini+0x2a7/0x310 [amdgpu]</div>
          <div>[ &nbsp;+0.000265] &nbsp;gmc_v9_0_sw_fini+0x3a/0x40 [amdgpu]</div>
          <div>[ &nbsp;+0.000246] &nbsp;amdgpu_device_fini_sw+0xae/0x260 [amdgpu]</div>
          <div>[ &nbsp;+0.000219] &nbsp;amdgpu_driver_release_kms+0x12/0x30
            [amdgpu]</div>
          <div>[ &nbsp;+0.000219] &nbsp;drm_dev_release+0x20/0x40 [drm]</div>
          <div>[ &nbsp;+0.000059] &nbsp;drm_release+0xa8/0xf0 [drm]</div>
          <div>[ &nbsp;+0.000053] &nbsp;__fput+0xa5/0x250</div>
          <div>[ &nbsp;+0.000023] &nbsp;task_work_run+0x5c/0xa0</div>
          <div>[ &nbsp;+0.000026] &nbsp;exit_to_user_mode_prepare+0x1db/0x1e0</div>
          <div>[ &nbsp;+0.000033] &nbsp;syscall_exit_to_user_mode+0x19/0x50</div>
          <div>[ &nbsp;+0.000030] &nbsp;do_syscall_64+0x47/0x70</div>
          <div>[ &nbsp;+0.000018] &nbsp;entry_SYSCALL_64_after_hwframe+0x44/0xae</div>
          <div>[ &nbsp;+0.000025] RIP: 0033:0x7fcfb86403d7</div>
          <div>[ &nbsp;+0.000869] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb
            0f 1f 80 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85
            c0 75 10 b8 03 00 00 00 0f 05 &lt;48&gt; 3d 00 f0 ff ff 77
            41 c3 48 83 ec 18 89 7c 24 0c e8 f3 fb ff ff</div>
          <div>[ &nbsp;+0.001788] RSP: 002b:00007ffc8fc26c28 EFLAGS: 00000246
            ORIG_RAX: 0000000000000003</div>
          <div>[ &nbsp;+0.000888] RAX: 0000000000000000 RBX: 000055d67a05b6a0
            RCX: 00007fcfb86403d7</div>
          <div>[ &nbsp;+0.000867] RDX: 00007fcfb8627be0 RSI: 0000000000000000
            RDI: 0000000000000003</div>
          <div>[ &nbsp;+0.000846] RBP: 000055d67a05b8a0 R08: 0000000000000007
            R09: 0000000000000000</div>
          <div>[ &nbsp;+0.000816] R10: 0000000000000000 R11: 0000000000000246
            R12: 0000000000000000</div>
          <div>[ &nbsp;+0.000791] R13: 0000000000000000 R14: 0000000000000000
            R15: 00007fcfb8659143</div>
          <div>[ &nbsp;+0.000770] Modules linked in: amdgpu(E) xt_conntrack
            xt_MASQUERADE nfnetlink xt_addrtype iptable_filter
            iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
            nf_defrag_ipv4 br_netfilter x86_pkg_temp_thermal cdc_ether
            usbnet acpi_pad msr ip_tables x_tables ast drm_vram_helper
            drm_ttm_helper ttm iommu_v2 gpu_sched drm_kms_helper
            cfbfillrect syscopyarea cfbimgblt sysfillrect sysimgblt
            fb_sys_fops cfbcopyarea drm drm_panel_orientation_quirks
            [last unloaded: amdgpu]</div>
          <div>[ &nbsp;+0.003303] CR2: ffffc01343fc81b4</div>
          <div>[ &nbsp;+0.000799] ---[ end trace 2360927435b19009 ]—</div>
          <div><br class="">
          </div>
        </div>
        <div><br class="">
        </div>
        <div><br class="">
        </div>
        <blockquote type="cite" class="">
          <div class="">
            <div class="">
              <blockquote type="cite" cite="mid:7825EEC6-BAF8-4B71-B01C-FE246D360779@microsoft.com" class="">
                <div class="">The following is the new diff.</div>
                <div class=""><br class="">
                </div>
                <div class="">
                  <div class="">diff --git
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu.h</div>
                  <div class="">index 182b7eae598a..48c3cd4054de 100644</div>
                  <div class="">---
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu.h</div>
                  <div class="">+++
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu.h</div>
                  <div class="">@@ -1327,7 +1327,7 @@ int
                    emu_soc_asic_init(struct amdgpu_device *adev);</div>
                  <div class="">&nbsp; * ASICs macro.</div>
                  <div class="">&nbsp; */</div>
                  <div class="">&nbsp;#define amdgpu_asic_set_vga_state(adev,
                    state)
                    (adev)-&gt;asic_funcs-&gt;set_vga_state((adev),
                    (state))</div>
                  <div class="">-#define amdgpu_asic_reset(adev)
                    (adev)-&gt;asic_funcs-&gt;reset((adev))</div>
                  <div class="">+#define amdgpu_asic_reset(adev) ({int
                    r; pr_info(&quot;performing amdgpu_asic_reset\n&quot;); r =
                    (adev)-&gt;asic_funcs-&gt;reset((adev));r;})</div>
                  <div class="">&nbsp;#define amdgpu_asic_reset_method(adev)
                    (adev)-&gt;asic_funcs-&gt;reset_method((adev))</div>
                  <div class="">&nbsp;#define amdgpu_asic_get_xclk(adev)
                    (adev)-&gt;asic_funcs-&gt;get_xclk((adev))</div>
                  <div class="">&nbsp;#define
                    amdgpu_asic_set_uvd_clocks(adev, v, d)
                    (adev)-&gt;asic_funcs-&gt;set_uvd_clocks((adev),
                    (v), (d))</div>
                  <div class="">diff --git
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h</div>
                  <div class="">index 27c74fcec455..842abd7150a6 100644</div>
                  <div class="">---
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h</div>
                  <div class="">+++
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h</div>
                  <div class="">@@ -134,6 +134,7 @@ struct
                    amdkfd_process_info {</div>
                  <div class="">&nbsp;</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>/*
                    MMU-notifier related fields */</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>atomic_t
                    evicted_bos;</div>
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>atomic_t
                    invalid;</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>struct
                    delayed_work restore_userptr_work;</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>struct
                    pid *pid;</div>
                  <div class="">&nbsp;};</div>
                  <div class="">diff --git
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c</div>
                  <div class="">index 99d2b15bcbf3..2a588eb9f456 100644</div>
                  <div class="">---
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c</div>
                  <div class="">+++
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c</div>
                  <div class="">@@ -1325,6 +1325,7 @@ static int
                    init_kfd_vm(struct amdgpu_vm *vm, void
                    **process_info,</div>
                  <div class="">&nbsp;</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>info-&gt;pid
                    = get_task_pid(current-&gt;group_leader,
                    PIDTYPE_PID);</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>atomic_set(&amp;info-&gt;evicted_bos,
                    0);</div>
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>atomic_set(&amp;info-&gt;invalid,
                    0);</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>INIT_DELAYED_WORK(&amp;info-&gt;restore_userptr_work,</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>&nbsp;amdgpu_amdkfd_restore_userptr_worker);</div>
                  <div class="">&nbsp;</div>
                  <div class="">@@ -2693,6 +2694,9 @@ static void
                    amdgpu_amdkfd_restore_userptr_worker(struct
                    work_struct *work)</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>struct
                    mm_struct *mm;</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>int
                    evicted_bos;</div>
                  <div class="">&nbsp;</div>
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>if
                    (atomic_read(&amp;process_info-&gt;invalid))</div>
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>return;</div>
                  <div class="">+</div>
                </div>
              </blockquote>
              <p class=""><br class="">
              </p>
              <p class="">Probably better&nbsp; to again use
                drm_dev_enter/exit guard pair instead of this flag.</p>
              <div class=""><br class="">
              </div>
            </div>
          </div>
        </blockquote>
        <div><br class="">
        </div>
        I don’t know if I could use drm_dev_enter/exit efficiently
        because a process can have multiple drm_dev open. And I don’t
        know how I can recover/refer drm_dev(s) efficiently in the
        worker function in order to use drm_dev_enter/exit.<br class="">
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>I think that within the KFD code each kfd device belongs or
      points to one specific drm_device so I don't think this is a
      problem.</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:0FD33B90-BD27-4F32-9735-CA525735B5FA@microsoft.com">
      <div>
        <blockquote type="cite" class="">
          <div class="">
            <div class="">
              <p class=""><br class="">
              </p>
              <blockquote type="cite" cite="mid:7825EEC6-BAF8-4B71-B01C-FE246D360779@microsoft.com" class="">
                <div class="">
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>evicted_bos
                    = atomic_read(&amp;process_info-&gt;evicted_bos);</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>if
                    (!evicted_bos)</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>return;</div>
                  <div class="">diff --git
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c</div>
                  <div class="">index ec38517ab33f..e7d85d8d282d 100644</div>
                  <div class="">---
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c</div>
                  <div class="">+++
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c</div>
                  <div class="">@@ -1054,6 +1054,7 @@ void
                    amdgpu_device_program_register_sequence(struct
                    amdgpu_device *adev,</div>
                  <div class="">&nbsp; */</div>
                  <div class="">&nbsp;void
                    amdgpu_device_pci_config_reset(struct amdgpu_device
                    *adev)</div>
                  <div class="">&nbsp;{</div>
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>pr_debug(&quot;%s
                    called\n&quot;,__func__);</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>pci_write_config_dword(adev-&gt;pdev,
                    0x7c, AMDGPU_ASIC_RESET_DATA);</div>
                  <div class="">&nbsp;}</div>
                  <div class="">&nbsp;</div>
                  <div class="">@@ -1066,6 +1067,7 @@ void
                    amdgpu_device_pci_config_reset(struct amdgpu_device
                    *adev)</div>
                  <div class="">&nbsp; */</div>
                  <div class="">&nbsp;int amdgpu_device_pci_reset(struct
                    amdgpu_device *adev)</div>
                  <div class="">&nbsp;{</div>
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>pr_debug(&quot;%s
                    called\n&quot;,__func__);</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>return
                    pci_reset_function(adev-&gt;pdev);</div>
                  <div class="">&nbsp;}</div>
                  <div class="">&nbsp;</div>
                  <div class="">@@ -4702,6 +4704,8 @@ int
                    amdgpu_do_asic_reset(struct list_head
                    *device_list_handle,</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>bool
                    need_full_reset, skip_hw_reset, vram_lost = false;</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>int
                    r = 0;</div>
                  <div class="">&nbsp;</div>
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>pr_debug(&quot;%s
                    called\n&quot;,__func__);</div>
                  <div class="">+</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>/*
                    Try reset handler method first */</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>tmp_adev
                    = list_first_entry(device_list_handle, struct
                    amdgpu_device,</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>&nbsp;
                    &nbsp;reset_list);</div>
                  <div class="">diff --git
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</div>
                  <div class="">index 49bdf9ff7350..b469acb65c1e 100644</div>
                  <div class="">---
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</div>
                  <div class="">+++
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</div>
                  <div class="">@@ -2518,7 +2518,6 @@ void
                    amdgpu_ras_late_fini(struct amdgpu_device *adev,</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>if
                    (!ras_block || !ih_info)</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>return;</div>
                  <div class="">&nbsp;</div>
                  <div class="">-<span class="Apple-tab-span" style="white-space:pre"> </span>amdgpu_ras_sysfs_remove(adev,
                    ras_block);</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>if
                    (ih_info-&gt;cb)</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>amdgpu_ras_interrupt_remove_handler(adev,
                    ih_info);</div>
                  <div class="">&nbsp;}</div>
                  <div class="">@@ -2577,6 +2576,7 @@ void
                    amdgpu_ras_suspend(struct amdgpu_device *adev)</div>
                  <div class="">&nbsp;int amdgpu_ras_pre_fini(struct
                    amdgpu_device *adev)</div>
                  <div class="">&nbsp;{</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>struct
                    amdgpu_ras *con = amdgpu_ras_get_context(adev);</div>
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>struct
                    ras_manager *obj, *tmp;</div>
                  <div class="">&nbsp;</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>if
                    (!adev-&gt;ras_enabled || !con)</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>return
                    0;</div>
                  <div class="">@@ -2585,6 +2585,13 @@ int
                    amdgpu_ras_pre_fini(struct amdgpu_device *adev)</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>/*
                    Need disable ras on all IPs here before ip
                    [hw/sw]fini */</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>amdgpu_ras_disable_all_features(adev,
                    0);</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>amdgpu_ras_recovery_fini(adev);</div>
                  <div class="">+</div>
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>/*
                    remove sysfs before pci_remove to avoid OOPSES from
                    sysfs_remove_groups */</div>
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>list_for_each_entry_safe(obj,
                    tmp, &amp;con-&gt;head, node) {</div>
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>amdgpu_ras_sysfs_remove(adev,
                    &amp;obj-&gt;head);</div>
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>put_obj(obj);</div>
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>}</div>
                  <div class="">+</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>return
                    0;</div>
                  <div class="">&nbsp;}</div>
                  <div class="">&nbsp;</div>
                  <div class="">diff --git
                    a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
                    b/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
                  <div class="">index 4e7d9cb09a69..0fa806a78e39 100644</div>
                  <div class="">---
                    a/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
                  <div class="">+++
                    b/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
                  <div class="">@@ -693,16 +693,35 @@ bool
                    kfd_is_locked(void)</div>
                  <div class="">&nbsp;</div>
                  <div class="">&nbsp;void kgd2kfd_suspend(struct kfd_dev
                    *kfd, bool run_pm, bool force)</div>
                  <div class="">&nbsp;{</div>
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>struct
                    kfd_process *p;</div>
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>struct
                    amdkfd_process_info *p_info;</div>
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>unsigned
                    int temp;</div>
                  <div class="">+</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>if
                    (!kfd-&gt;init_complete)</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>return;</div>
                  <div class="">&nbsp;</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>/*
                    for runtime suspend, skip locking kfd */</div>
                  <div class="">-<span class="Apple-tab-span" style="white-space:pre"> </span>if
                    (!run_pm) {</div>
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>if
                    (!run_pm &amp;&amp;
                    !drm_dev_is_unplugged(kfd-&gt;ddev)) {</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>/*
                    For first KFD device suspend all the KFD processes
                    */</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>if
                    (atomic_inc_return(&amp;kfd_locked) == 1)</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>kfd_suspend_all_processes(force);</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>}</div>
                  <div class="">&nbsp;</div>
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>if
                    (drm_dev_is_unplugged(kfd-&gt;ddev)){</div>
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>int
                    idx = srcu_read_lock(&amp;kfd_processes_srcu);</div>
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>pr_debug(&quot;cancel
                    restore_userptr_wor\n&quot;);</div>
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>hash_for_each_rcu(kfd_processes_table,
                    temp, p, kfd_processes) {</div>
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>if
                    ( kfd_process_gpuidx_from_gpuid(p, kfd-&gt;id) &gt;=
                    0 ) {</div>
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>p_info
                    = p-&gt;kgd_process_info;</div>
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>pr_debug(&quot;cancel
                    processes, pid = %d for gpu_id = %d&quot;,
                    pid_nr(p_info-&gt;pid), kfd-&gt;id);</div>
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>cancel_delayed_work_sync(&amp;p_info-&gt;restore_userptr_work);</div>
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>/*
                    block all future restore_userptr_work */</div>
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>atomic_inc(&amp;p_info-&gt;invalid);</div>
                </div>
              </blockquote>
              <p class=""><br class="">
              </p>
              <p class="">Same as i mentioned above with
                drm.dev_eneter/exit</p>
            </div>
          </div>
        </blockquote>
        Same as I mentioned as the process can have many drm_dev open.</div>
      <div><br class="">
      </div>
      <div>
        <div>Final comments:</div>
        <div><br class="">
        </div>
        <div>I suspect that the my linux kernel version might not have
          all the fixes you did for hotplug. Can you give me a pointer
          to the lowest version of linux kernel (5.14 from linux kernel
          repo? amd-drm-staging-next does not work for MI100
          out-of-box), which would pass all libdrm tests including
          hotplug tests (some tests hang, some failed now) ?</div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>That a problem, latest working baseline I tested and confirmed
      passing hotplug tests is this branch and commit
<a class="moz-txt-link-freetext" href="https://gitlab.freedesktop.org/agd5f/linux/-/commit/86e12a53b73135806e101142e72f3f1c0e6fa8e6">https://gitlab.freedesktop.org/agd5f/linux/-/commit/86e12a53b73135806e101142e72f3f1c0e6fa8e6</a>
      which is amd-staging-drm-next. 5.14 was the branch we ups-reamed
      the hotplug code but it had a lot of regressions over time due to
      new changes (that why I added the hotplug test to try and catch
      them early). It would be best to run this branch on mi-100 so we
      have a clean baseline and only after confirming&nbsp; this particular
      branch from this commits passes libdrm tests only then start
      adding the KFD specific addons. Another option if you can't work
      with MI-100 and this branch is to try a different ASIC that does
      work with this branch (if possible).</p>
    <p>Andrey<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:0FD33B90-BD27-4F32-9735-CA525735B5FA@microsoft.com">
      <div>
        <div>p.s. I cloned and build libdrm from source (<a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fmesa%2Fdrm&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7C78c882de9193490a3b4408da21d8132d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637859509203317436%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=k%2FqmPOyW%2BnIStUdJZqlBHPXDU6AaXGKGS0GKH34r7Mc%3D&amp;reserved=0" originalsrc="https://gitlab.freedesktop.org/mesa/drm" shash="ZBWuX9zzRH0f9tjMtG5pjJb0316KhJSccHJLgmNEmohbK7MYjUxTs797jJ1vb5KldQ/bUl3DG2ZmS3GrPv3dpf9NTFuHG+A7AgvJDkcX7AsX/kv02fuyCvXtgOQSQ6lTiKewhPQIyx7JeqpxK3tXy8nTyMop532jRzI5HDk39oQ=" class="" moz-do-not-send="true">https://gitlab.freedesktop.org/mesa/drm</a>)</div>
        <div><br class="">
        </div>
        <div>Thank you so much!</div>
        <div class=""><br class="">
        </div>
        <blockquote type="cite" class="">
          <div class="">
            <div class="">
              <p class="">Andrey</p>
              <p class=""><br class="">
              </p>
              <blockquote type="cite" cite="mid:7825EEC6-BAF8-4B71-B01C-FE246D360779@microsoft.com" class="">
                <div class="">
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>}</div>
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>}</div>
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>srcu_read_unlock(&amp;kfd_processes_srcu,
                    idx);</div>
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>}</div>
                  <div class="">+</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>kfd-&gt;dqm-&gt;ops.stop(kfd-&gt;dqm);</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>kfd_iommu_suspend(kfd);</div>
                  <div class="">&nbsp;}</div>
                  <div class="">diff --git
                    a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
                    b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c</div>
                  <div class="">index 600ba2a728ea..7e3d1848eccc 100644</div>
                  <div class="">---
                    a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c</div>
                  <div class="">+++
                    b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c</div>
                  <div class="">@@ -669,11 +669,12 @@ static void
                    kfd_remove_sysfs_node_entry(struct
                    kfd_topology_device *dev)</div>
                  <div class="">&nbsp;#ifdef HAVE_AMD_IOMMU_PC_SUPPORTED</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>if
                    (dev-&gt;kobj_perf) {</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>list_for_each_entry(perf,
                    &amp;dev-&gt;perf_props, list) {</div>
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>sysfs_remove_group(dev-&gt;kobj_perf,
                    perf-&gt;attr_group);</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>kfree(perf-&gt;attr_group);</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>perf-&gt;attr_group
                    = NULL;</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>}</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>kobject_del(dev-&gt;kobj_perf);</div>
                  <div class="">-<span class="Apple-tab-span" style="white-space:pre"> </span>kobject_put(dev-&gt;kobj_perf);</div>
                  <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>/*
                    kobject_put(dev-&gt;kobj_perf); */</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>dev-&gt;kobj_perf
                    = NULL;</div>
                  <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>}</div>
                  <div class="">&nbsp;#endif</div>
                  <div class=""><br class="">
                  </div>
                  <div class="">Thank you so much! Looking forward to
                    your comments!</div>
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
                                          8fa9b86ac9d2..c0b27f722281
                                          100644</div>
                                        <div class="">---
                                          a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c</div>
                                        <div class="">+++
                                          b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c</div>
                                        <div class="">@@ -188,6 +188,12
                                          @@ void
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
                                          amdgpu_device *adev, bool
                                          run_pm)</div>
                                        <div class="">&nbsp;{</div>
                                        <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>if
                                          (adev-&gt;kfd.dev)</div>
                                        <div class="">diff --git
                                          a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h</div>
                                        <div class="">index
                                          27c74fcec455..f4e485d60442
                                          100644</div>
                                        <div class="">---
                                          a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h</div>
                                        <div class="">+++
                                          b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h</div>
                                        <div class="">@@ -141,6 +141,7
                                          @@ struct amdkfd_process_info
                                          {</div>
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
                                          amdgpu_device *adev, bool
                                          run_pm);</div>
                                        <div class="">&nbsp;int
                                          amdgpu_amdkfd_resume_iommu(struct
                                          amdgpu_device *adev);</div>
                                        <div class="">&nbsp;int
                                          amdgpu_amdkfd_resume(struct
                                          amdgpu_device *adev, bool
                                          run_pm, bool sync);</div>
                                        <div class="">@@ -405,6 +406,7
                                          @@ bool
                                          kgd2kfd_device_init(struct
                                          kfd_dev *kfd,</div>
                                        <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>const
                                          struct
                                          kgd2kfd_shared_resources
                                          *gpu_resources);</div>
                                        <div class="">&nbsp;void
                                          kgd2kfd_device_exit(struct
                                          kfd_dev *kfd);</div>
                                        <div class="">&nbsp;void
                                          kgd2kfd_suspend(struct kfd_dev
                                          *kfd, bool run_pm, bool
                                          force);</div>
                                        <div class="">+void
                                          kgd2kfd_kill_all_user_processes(struct
                                          kfd_dev *kfd);</div>
                                        <div class="">&nbsp;int
                                          kgd2kfd_resume_iommu(struct
                                          kfd_dev *kfd);</div>
                                        <div class="">&nbsp;int
                                          kgd2kfd_resume(struct kfd_dev
                                          *kfd, bool run_pm, bool sync);</div>
                                        <div class="">&nbsp;int
                                          kgd2kfd_pre_reset(struct
                                          kfd_dev *kfd);</div>
                                        <div class="">@@ -443,6 +445,9
                                          @@ static inline void
                                          kgd2kfd_suspend(struct kfd_dev
                                          *kfd, bool run_pm, bool force)</div>
                                        <div class="">&nbsp;{</div>
                                        <div class="">&nbsp;}</div>
                                        <div class="">&nbsp;</div>
                                        <div class="">+void
                                          kgd2kfd_kill_all_user_processes(struct
                                          kfd_dev *kfd){</div>
                                        <div class="">+}</div>
                                        <div class="">+</div>
                                        <div class="">&nbsp;static int
                                          __maybe_unused
                                          kgd2kfd_resume_iommu(struct
                                          kfd_dev *kfd)</div>
                                        <div class="">&nbsp;{</div>
                                        <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>return
                                          0;</div>
                                        <div class="">diff --git
                                          a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c</div>
                                        <div class="">index
                                          3d5fc0751829..af6fe5080cfa
                                          100644</div>
                                        <div class="">---
                                          a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c</div>
                                        <div class="">+++
                                          b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c</div>
                                        <div class="">@@ -2101,6 +2101,9
                                          @@ amdgpu_pci_remove(struct
                                          pci_dev *pdev)</div>
                                        <div class="">&nbsp;{</div>
                                        <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>struct
                                          drm_device *dev =
                                          pci_get_drvdata(pdev);</div>
                                        <div class="">&nbsp;</div>
                                        <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>/*
                                          kill all kfd processes before
                                          drm_dev_unplug */</div>
                                        <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>amdgpu_amdkfd_kill_all_processes(drm_to_adev(dev));</div>
                                        <div class="">+</div>
                                        <div class="">&nbsp;#ifdef
                                          HAVE_DRM_DEV_UNPLUG</div>
                                        <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>drm_dev_unplug(dev);</div>
                                        <div class="">&nbsp;#else</div>
                                        <div class="">diff --git
                                          a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
b/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
                                        <div class="">index
                                          5504a18b5a45..480c23bef5e2
                                          100644</div>
                                        <div class="">---
                                          a/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
                                        <div class="">+++
                                          b/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
                                        <div class="">@@ -691,6 +691,12
                                          @@ bool kfd_is_locked(void)</div>
                                        <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>return
                                          &nbsp;(atomic_read(&amp;kfd_locked)
                                          &gt; 0);</div>
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
                                        <div class="">&nbsp;void
                                          kgd2kfd_suspend(struct kfd_dev
                                          *kfd, bool run_pm, bool force)</div>
                                        <div class="">&nbsp;{</div>
                                        <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>if
                                          (!kfd-&gt;init_complete)</div>
                                        <div class="">diff --git
                                          a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h</div>
                                        <div class="">index
                                          55c9e1922714..a35a2cb5bb9f
                                          100644</div>
                                        <div class="">---
                                          a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h</div>
                                        <div class="">+++
                                          b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h</div>
                                        <div class="">@@ -1064,6 +1064,7
                                          @@ static inline struct
                                          kfd_process_device
                                          *kfd_process_device_from_gpuidx(</div>
                                        <div class="">&nbsp;void
                                          kfd_unref_process(struct
                                          kfd_process *p);</div>
                                        <div class="">&nbsp;int
                                          kfd_process_evict_queues(struct
                                          kfd_process *p, bool force);</div>
                                        <div class="">&nbsp;int
                                          kfd_process_restore_queues(struct
                                          kfd_process *p);</div>
                                        <div class="">+void
                                          kfd_kill_all_user_processes(void);</div>
                                        <div class="">&nbsp;void
                                          kfd_suspend_all_processes(bool
                                          force);</div>
                                        <div class="">&nbsp;/*</div>
                                        <div class="">&nbsp; *
                                          kfd_resume_all_processes:</div>
                                        <div class="">diff --git
                                          a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
b/drivers/gpu/drm/amd/amdkfd/kfd_process.c</div>
                                        <div class="">index
                                          6cdc855abb6d..17e769e6951d
                                          100644</div>
                                        <div class="">---
                                          a/drivers/gpu/drm/amd/amdkfd/kfd_process.c</div>
                                        <div class="">+++
                                          b/drivers/gpu/drm/amd/amdkfd/kfd_process.c</div>
                                        <div class="">@@ -46,6 +46,9 @@
                                          struct mm_struct;</div>
                                        <div class="">&nbsp;#include
                                          &quot;kfd_trace.h&quot;</div>
                                        <div class="">&nbsp;#include
                                          &quot;kfd_debug.h&quot;</div>
                                        <div class="">&nbsp;</div>
                                        <div class="">+static atomic_t
                                          kfd_process_locked =
                                          ATOMIC_INIT(0);</div>
                                        <div class="">+static atomic_t
                                          kfd_inflight_kills =
                                          ATOMIC_INIT(0);</div>
                                        <div class="">+</div>
                                        <div class="">&nbsp;/*</div>
                                        <div class="">&nbsp; * List of struct
                                          kfd_process (field
                                          kfd_process).</div>
                                        <div class="">&nbsp; * Unique/indexed
                                          by mm_struct*</div>
                                        <div class="">@@ -802,6 +805,9
                                          @@ struct kfd_process
                                          *kfd_create_process(struct
                                          task_struct *thread)</div>
                                        <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>struct
                                          kfd_process *process;</div>
                                        <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>int
                                          ret;</div>
                                        <div class="">&nbsp;</div>
                                        <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>if
                                          (
                                          atomic_read(&amp;kfd_process_locked)
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
                                        <div class="">@@ -1126,6
                                          +1132,10 @@ static void
                                          kfd_process_wq_release(struct
                                          work_struct *work)</div>
                                        <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>put_task_struct(p-&gt;lead_thread);</div>
                                        <div class="">&nbsp;</div>
                                        <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>kfree(p);</div>
                                        <div class="">+</div>
                                        <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>if
                                          (
                                          atomic_read(&amp;kfd_process_locked)
                                          &gt; 0 ){</div>
                                        <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>atomic_dec(&amp;kfd_inflight_kills);</div>
                                        <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>}</div>
                                        <div class="">&nbsp;}</div>
                                        <div class="">&nbsp;</div>
                                        <div class="">&nbsp;static void
                                          kfd_process_ref_release(struct
                                          kref *ref)</div>
                                        <div class="">@@ -2186,6
                                          +2196,35 @@ static void
                                          restore_process_worker(struct
                                          work_struct *work)</div>
                                        <div class="">&nbsp;<span class="Apple-tab-span" style="white-space:pre"> </span>pr_err(&quot;Failed
                                          to restore queues of pasid
                                          0x%x\n&quot;, p-&gt;pasid);</div>
                                        <div class="">&nbsp;}</div>
                                        <div class="">&nbsp;</div>
                                        <div class="">+void
                                          kfd_kill_all_user_processes(void)</div>
                                        <div class="">+{</div>
                                        <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>struct
                                          kfd_process *p;</div>
                                        <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>/*
                                          struct amdkfd_process_info
                                          *p_info; */</div>
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
                                          SIGBUS to process %d (pasid
                                          0x%x)&quot;,</div>
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
                                          (
                                          atomic_read(&amp;kfd_inflight_kills)
                                          &gt; 0 ){</div>
                                        <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>dev_warn(kfd_device,</div>
                                        <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>&quot;kfd_processes_table
                                          is not empty, going to sleep
                                          for 10ms\n&quot;);</div>
                                        <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>msleep(10);</div>
                                        <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>}</div>
                                        <div class="">+</div>
                                        <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>atomic_dec(&amp;kfd_process_locked);</div>
                                        <div class="">+<span class="Apple-tab-span" style="white-space:pre"> </span>pr_info(&quot;all
                                          processes has been fully
                                          released&quot;);</div>
                                        <div class="">+}</div>
                                        <div class="">+</div>
                                        <div class="">&nbsp;void
                                          kfd_suspend_all_processes(bool
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
                                            <div class=""><span style="caret-color:
                                                rgb(0, 0, 0);
                                                font-family: Helvetica;
                                                font-size: 12px;
                                                font-style: normal;
                                                font-variant-caps:
                                                normal; font-weight:
                                                400; letter-spacing:
                                                normal; text-align:
                                                start; text-indent: 0px;
                                                text-transform: none;
                                                white-space: normal;
                                                word-spacing: 0px;
                                                -webkit-text-stroke-width:
                                                0px; text-decoration:
                                                none; float: none;
                                                display: inline
                                                !important;" class=""></span><br class="webkit-block-placeholder">
                                            </div>
                                            <p class=""><span style="caret-color:
                                                rgb(0, 0, 0);
                                                font-family: Helvetica;
                                                font-size: 12px;
                                                font-style: normal;
                                                font-variant-caps:
                                                normal; font-weight:
                                                400; letter-spacing:
                                                normal; text-align:
                                                start; text-indent: 0px;
                                                text-transform: none;
                                                white-space: normal;
                                                word-spacing: 0px;
                                                -webkit-text-stroke-width:
                                                0px; text-decoration:
                                                none; float: none;
                                                display: inline
                                                !important;" class=""><font class="" size="4">Andrey</font><br class="">
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
                                              <div class="">&nbsp; &nbsp; &nbsp; &nbsp;
                                                struct kfd_process *p;</div>
                                              <div class=""><br class="">
                                              </div>
                                              <div class=""><br class="">
                                                <blockquote type="cite" class="">
                                                  <div class=""><span style="caret-color:
                                                      rgb(0, 0, 0);
                                                      font-family:
                                                      Helvetica;
                                                      font-size: 12px;
                                                      font-style:
                                                      normal;
                                                      font-variant-caps:
                                                      normal;
                                                      font-weight: 400;
                                                      letter-spacing:
                                                      normal;
                                                      text-align: start;
                                                      text-indent: 0px;
                                                      text-transform:
                                                      none; white-space:
                                                      normal;
                                                      word-spacing: 0px;
-webkit-text-stroke-width: 0px; text-decoration: none; float: none;
                                                      display: inline
                                                      !important;" class="">Andrey</span><br style="caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size:
                                                      12px; font-style:
                                                      normal;
                                                      font-variant-caps:
                                                      normal;
                                                      font-weight: 400;
                                                      letter-spacing:
                                                      normal;
                                                      text-align: start;
                                                      text-indent: 0px;
                                                      text-transform:
                                                      none; white-space:
                                                      normal;
                                                      word-spacing: 0px;
-webkit-text-stroke-width: 0px; text-decoration: none;" class="">
                                                    <br style="caret-color:
                                                      rgb(0, 0, 0);
                                                      font-family:
                                                      Helvetica;
                                                      font-size: 12px;
                                                      font-style:
                                                      normal;
                                                      font-variant-caps:
                                                      normal;
                                                      font-weight: 400;
                                                      letter-spacing:
                                                      normal;
                                                      text-align: start;
                                                      text-indent: 0px;
                                                      text-transform:
                                                      none; white-space:
                                                      normal;
                                                      word-spacing: 0px;
-webkit-text-stroke-width: 0px; text-decoration: none;" class="">
                                                    <br style="caret-color:
                                                      rgb(0, 0, 0);
                                                      font-family:
                                                      Helvetica;
                                                      font-size: 12px;
                                                      font-style:
                                                      normal;
                                                      font-variant-caps:
                                                      normal;
                                                      font-weight: 400;
                                                      letter-spacing:
                                                      normal;
                                                      text-align: start;
                                                      text-indent: 0px;
                                                      text-transform:
                                                      none; white-space:
                                                      normal;
                                                      word-spacing: 0px;
-webkit-text-stroke-width: 0px; text-decoration: none;" class="">
                                                    <blockquote type="cite" style="font-family:
                                                      Helvetica;
                                                      font-size: 12px;
                                                      font-style:
                                                      normal;
                                                      font-variant-caps:
                                                      normal;
                                                      font-weight: 400;
                                                      letter-spacing:
                                                      normal; orphans:
                                                      auto; text-align:
                                                      start;
                                                      text-indent: 0px;
                                                      text-transform:
                                                      none; white-space:
                                                      normal; widows:
                                                      auto;
                                                      word-spacing: 0px;
-webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px;
                                                      text-decoration:
                                                      none;" class="">
                                                      <br class="">
                                                      Really appreciate
                                                      your help!<br class="">
                                                      <br class="">
                                                      Best,<br class="">
                                                      Shuotao<br class="">
                                                      <br class="">
                                                      <blockquote type="cite" class="">
                                                        <blockquote type="cite" class="">2.
                                                          Remove
                                                          redudant
                                                          p2p/io links
                                                          in sysfs when
                                                          device is
                                                          hotplugged<br class="">
                                                          out.<br class="">
                                                          <br class="">
                                                          3. New kfd
                                                          node_id is not
                                                          properly
                                                          assigned after
                                                          a new device
                                                          is<br class="">
                                                          added after a
                                                          gpu is
                                                          hotplugged out
                                                          in a system.
                                                          libhsakmt will<br class="">
                                                          find this
                                                          anomaly, (i.e.
                                                          node_from !=
                                                          &lt;dev node
                                                          id&gt; in
                                                          iolinks),<br class="">
                                                          when taking a
topology_snapshot, thus returns fault to the rocm<br class="">
                                                          stack.<br class="">
                                                          <br class="">
                                                          -- This patch
                                                          fixes issue 1;
                                                          another patch
                                                          by Mukul fixes
                                                          issues
                                                          2&amp;3.<br class="">
                                                          -- Tested on a
                                                          4-GPU MI100
                                                          gpu nodes with
                                                          kernel
                                                          5.13.0-kfd;
                                                          kernel<br class="">
                                                          5.16.0-kfd is
                                                          unstable out
                                                          of box for
                                                          MI100.<br class="">
                                                          ---<br class="">
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 5 +++++<br class="">
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 7 +++++++<br class="">
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +<br class="">
drivers/gpu/drm/amd/amdkfd/kfd_device.c | 13 +++++++++++++<br class="">
                                                          4 files
                                                          changed, 26
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
                                                          @@ -213,6
                                                          +213,11 @@ int
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
                                                          amdgpu_device
                                                          *adev)<br class="">
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
                                                          @@ -140,6
                                                          +140,7 @@ void
amdgpu_amdkfd_fini(void);<br class="">
                                                          void
                                                          amdgpu_amdkfd_suspend(struct
                                                          amdgpu_device
                                                          *adev, bool
                                                          run_pm);<br class="">
                                                          int
                                                          amdgpu_amdkfd_resume_iommu(struct
                                                          amdgpu_device
                                                          *adev);<br class="">
                                                          int
                                                          amdgpu_amdkfd_resume(struct
                                                          amdgpu_device
                                                          *adev, bool
                                                          run_pm);<br class="">
                                                          +int
                                                          amdgpu_amdkfd_resume_processes(void);<br class="">
                                                          void
                                                          amdgpu_amdkfd_interrupt(struct
                                                          amdgpu_device
                                                          *adev,<br class="">
                                                          const void
                                                          *ih_ring_entry);<br class="">
                                                          void
                                                          amdgpu_amdkfd_device_probe(struct
                                                          amdgpu_device
                                                          *adev);<br class="">
                                                          @@ -347,6
                                                          +348,7 @@ void
kgd2kfd_device_exit(struct kfd_dev *kfd);<br class="">
                                                          void
                                                          kgd2kfd_suspend(struct
                                                          kfd_dev *kfd,
                                                          bool run_pm);<br class="">
                                                          int
                                                          kgd2kfd_resume_iommu(struct
                                                          kfd_dev *kfd);<br class="">
                                                          int
                                                          kgd2kfd_resume(struct
                                                          kfd_dev *kfd,
                                                          bool run_pm);<br class="">
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
                                                          kfd_dev *kfd,
                                                          const void
                                                          *ih_ring_entry);<br class="">
                                                          @@ -393,6
                                                          +395,11 @@
                                                          static inline
                                                          int
                                                          kgd2kfd_resume(struct
                                                          kfd_dev *kfd,
                                                          bool run_pm)<br class="">
                                                          return 0;<br class="">
                                                          }<br class="">
                                                          <br class="">
                                                          +static inline
                                                          int
                                                          kgd2kfd_resume_processes(void)<br class="">
                                                          +{<br class="">
                                                          + return 0;<br class="">
                                                          +}<br class="">
                                                          +<br class="">
                                                          static inline
                                                          int
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
                                                          @@ -4004,6
                                                          +4004,7 @@
                                                          void
                                                          amdgpu_device_fini_hw(struct
                                                          amdgpu_device
                                                          *adev)<br class="">
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
                                                          amdgpu_device
                                                          *adev)<br class="">
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
                                                          @@ -714,6
                                                          +714,19 @@ int
kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)<br class="">
                                                          return ret;<br class="">
                                                          }<br class="">
                                                          <br class="">
                                                          +/* for
                                                          non-runtime
                                                          resume only */<br class="">
                                                          +int
                                                          kgd2kfd_resume_processes(void)<br class="">
                                                          +{<br class="">
                                                          + int count;<br class="">
                                                          +<br class="">
                                                          + count =
                                                          atomic_dec_return(&amp;kfd_locked);<br class="">
                                                          +
                                                          WARN_ONCE(count
                                                          &lt; 0, &quot;KFD
                                                          suspend /
                                                          resume ref.
                                                          error&quot;);<br class="">
                                                          + if (count ==
                                                          0)<br class="">
                                                          + return
                                                          kfd_resume_all_processes();<br class="">
                                                          +<br class="">
                                                          + return 0;<br class="">
                                                          +}<br class="">
                                                        </blockquote>
                                                        <br class="">
                                                        It doesn't make
                                                        sense to me to
                                                        just increment
                                                        kfd_locked in<br class="">
                                                        kgd2kfd_suspend
                                                        to only
                                                        decrement it
                                                        again a few
                                                        functions down
                                                        the<br class="">
                                                        road.<br class="">
                                                        <br class="">
                                                        I suggest this
                                                        instead - you
                                                        only incrmemnt
                                                        if not during
                                                        PCI remove<br class="">
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
                                                        @@ -952,11
                                                        +952,12 @@ bool
kfd_is_locked(void)<br class="">
                                                        <br class="">
                                                        void
                                                        kgd2kfd_suspend(struct
                                                        kfd_dev *kfd,
                                                        bool run_pm)<br class="">
                                                        {<br class="">
                                                        +<br class="">
                                                        if
                                                        (!kfd-&gt;init_complete)<br class="">
                                                        return;<br class="">
                                                        <br class="">
                                                        /* for runtime
                                                        suspend, skip
                                                        locking kfd */<br class="">
                                                        - if (!run_pm) {<br class="">
                                                        + if (!run_pm
                                                        &amp;&amp;
                                                        !drm_dev_is_unplugged(kfd-&gt;ddev))
                                                        {<br class="">
                                                        /* For first KFD
                                                        device suspend
                                                        all the KFD
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
            </div>
          </div>
        </blockquote>
      </div>
      <br class="">
    </blockquote>
  </body>
</html>

--------------1kPSWthhFoGfhQAi5DCrigrp--
