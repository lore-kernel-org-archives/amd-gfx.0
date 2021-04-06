Return-Path: <SRS0=1IUY=JD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DC3C433B4
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 10:34:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E006128A
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Apr 2021 10:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E006128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18D7A6E3B2;
	Tue,  6 Apr 2021 10:34:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 189DE89C27
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Apr 2021 10:34:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OM4VMB7jdyZWb7HdKfpUq9q2NCmd609s4OsEr24I9tK3a5ikQsnwI8DFD1GRbfyBd1t8wBo5FN5o9b7S7SWqGyF1D5RMXeh7BPb/XR3CbcAcUkQPjwlKqBFt+CF28aCBWEVCBF8kOBiyUNGUgnpJgdVi7Wfrw/OGuEwGDHlQOhZ9Q5Gwvr6KfvEzTOIvf5dAWA+m81WLN+DebpIRqC13kFRZEfeM4LHzn5766jS3WT1/k1lRdMvyFsA4ul3vaGR66PRMH9zszuZFoTLsGTr+Yd4/OPuKz+hhzo786cvS9DpX2FOsvWEG4KQQ3RSjZbzG3w7qdNGVa8ciegR63eXX/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5CNjChEQMP3wBX/VTrfPlILvROBrpopreH83XbI0vA=;
 b=cPP0ne/AXPH9ej83w3Sxp/UWC0PcbNUJR2AgExGPoTETWxk6/Y13gyXZnbXUvX6tUREPl6MTZDK3cW5OwjKiswS4YYgwL04S2ktiJDiF0JfEv6VTvJW1X9DEJRAme5Uw2n7BXgj8gu6CZhYbQHCuT9rEWA09NJJK3preIUODECbPfYrku3EIoWDqfTETEEFOu9XE8YvLK5JS0feHvDkMVBVYKh3Fe22nukUpoGO60xcN6gcfbjhxG4/+WK5k69dUy+z+0M81gwJq1eP1aK0cbwK4ClHZEbEG86EwOIUWYv6DLNwJQhCjVW4EPwkhrE4J1kTW18avr4FWJbt9I5LTpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5CNjChEQMP3wBX/VTrfPlILvROBrpopreH83XbI0vA=;
 b=GdA2ZkODFgD3+ilQbRmBYtxRMLbHKglEfixB38+lf1G5b6uzBrK9wPEyIhyRmU09/ioch9o0aKMZOfUNo4p1jqBNb0dkIK+yd3cZ/DBlVR0V0QpMAn4l0KA6Z4KCfdlxLYc5ESjElX6D2/zhDe2O8bGb6x4+gBbLw5Gq8onNwM8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (10.255.86.19) by
 MN2PR12MB3901.namprd12.prod.outlook.com (10.255.238.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.26; Tue, 6 Apr 2021 10:34:13 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 10:34:13 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <d40648ba-9948-5442-23ed-d352f824f8f9@amd.com>
 <DM5PR12MB25330F3CD92C587C2E921424ED699@DM5PR12MB2533.namprd12.prod.outlook.com>
 <MN2PR12MB3775531A74B886A207134B1583699@MN2PR12MB3775.namprd12.prod.outlook.com>
 <DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com>
 <378fdffb-99b5-2a14-736d-a06f310b040c@amd.com>
 <1e37bb4d-f54d-1b7e-4632-94cfcf749528@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <51d7873d-cf35-6be5-79c2-024937c67f6a@amd.com>
Date: Tue, 6 Apr 2021 12:34:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <1e37bb4d-f54d-1b7e-4632-94cfcf749528@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:8475:9991:cfb3:4162]
X-ClientProxiedBy: FR0P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::12) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:8475:9991:cfb3:4162]
 (2a02:908:1252:fb60:8475:9991:cfb3:4162) by
 FR0P281CA0066.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:49::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.12 via Frontend Transport; Tue, 6 Apr 2021 10:34:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4288dde0-d9ff-4038-b1ba-08d8f8e7855c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3901:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3901B370C1FC8857F70300C283769@MN2PR12MB3901.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VQUEp9L3i+j+kdpcQEOKZ8OnsiS3Oxiq3UPIw35jP/SmdaeB283nmuRCoOeNCYl/2xJy7GjioasjeiXbxX0H3eJD3ef9BPdehocVyMdDyv7O9wni1NWy8g6f1FK11+XWEALMgVRNm6hXkljpfhWWfe4YdTZ4w+beet3IvqKzZkNWBCDp7dwJwr+I9IwYqlXCTP0N7IZ581oZwrK/p+9DESGARSXeD+9jEqbaLBdJVdSl+XZNPMBMfmTARVHj7y5e0/g9FJrBVN2mMAiRrAYIUDLxKZDd9TJBZUPvS8L/DHwz4ei1mNzQP2Bz+xoVDS6/n4tY1EbLVG+EMOaXFtA/iVPLfMliILsLdwcPjMHtIDsEgmI0obBkgNz9zZoaszSfBHjb9Ba9ole0isIl9aklj1Ct3sKIrKLVV2Fvz3gJltBa7koF+o6xxu6D//6RVPmIwo1CjNYfe5tqZtbU0inXDn/WVDNJvh4ASAC0beefJNRS30+LiGkEwC+pezc1SkgXT8pmdmlB9FmAsD3pPKM38WLq0KIPGbd2e5+39EN93NBtR/lRjKtwqhb/k6PwzLH4QnxSNugR9Ku+OUoNNVcJpRUgk9zenMiyqd45WHP9YPH1KR0WRxgSykbPPodqmiQVPHZsaa7aU2sKPIQRq9oWwKlsByFfcMqay+9ZfI0MG5moI33RW+c1KscZVbCBykTYW1ASJc4q8WaPZuc5fvP9wNEVjSP83WuCJX5Mhg5AXAlIiGbEbg0s34K8UKhVirhHEMwO1yCxjQb7eVd20QI20TnF0eeA1Bs1Af2FiL5EVtzLdmxDY6QktH+bDhbVEPMV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39830400003)(346002)(376002)(66556008)(66476007)(30864003)(8936002)(52116002)(186003)(110136005)(16526019)(21615005)(6486002)(31696002)(83380400001)(33964004)(36756003)(53546011)(2906002)(5660300002)(8676002)(86362001)(508600001)(34490700003)(6636002)(66574015)(31686004)(2616005)(966005)(166002)(6666004)(921005)(38100700001)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RHZ2WVhyYVBIbXNLa1FGMXFWMmxKc01qVFlhWllkWEY1RVRwSnRYYThGRERC?=
 =?utf-8?B?RU5sa2ZOamF6NEVEenBnNVBSdHkzeDZrNXIxaCtxRUdYeEtybW9RZWNZTlNh?=
 =?utf-8?B?VElyU3dBb29lMkxJRFprcFY1UGZ6Y00zaEFOMmd6NHYvaHhOYkszblBzb3Rk?=
 =?utf-8?B?Sm52YmtjeFBHZGlKTVBDUzJ5S1FoQk16ekx2YUZ2eWoxSElnQktUUFk4TVQx?=
 =?utf-8?B?czhCR3lrVHVmd3pLb2N5WFY5MnhkVzI1ZHI4b0pNK2NjeUs1MmZQdE0rNGp5?=
 =?utf-8?B?UVhPK2ZCVVFzejNWSVdEbzdOOERsUldwWEpMcXhyUGlGK09zNUJMQ3g5MVZi?=
 =?utf-8?B?bDVKU3l6dGtINjFqc3RjSk5Ta2JxQ2lPQm83NE1MbGhmbk1Id3NwS251bVBj?=
 =?utf-8?B?eEJCZFk3UTM3cXBXOE82SVdZNERrQW83WDhZMGRMREhOVUJSUzk5NHFEb0di?=
 =?utf-8?B?VCtjMldURVlDZytOc0FmeTIyaXhpUm5xZXJseGkvUjVlOTJqSlhJQ3lNemtF?=
 =?utf-8?B?SjZ0bTY0R3pjVFo4VG5PVVlYVmxWRGxYcDJWaFpFMm50Y241L2xpa2lURlRL?=
 =?utf-8?B?U0tobCtkUVZsaXBUSFMrUnArMGdhaG1WL1hJYVhnUklFSWN0QStoYnVFZ0ds?=
 =?utf-8?B?bWYyYkJxL3p2T2JrVFIxSFhCZzFNRm5IYXgzdUFDZmlzaTVPNUEzcnA5RDhz?=
 =?utf-8?B?L2pBaGVUSll5QW4rV1Q1SWRQckJpbmJxc1BoSVBBSXVrbSsyRWUvc0NPb3ZY?=
 =?utf-8?B?WmZWWEdPaDV5QjcwK3dCRytxTVpUQlVTQzI5NnQ5RVNlSDlBZ2g5RFRSQlNz?=
 =?utf-8?B?dXJ6cDVHSURtbldORTJpbTBEQWl3VWtxV1k5RnVwa0xPRkZSMkZOUmNkZmNS?=
 =?utf-8?B?Z0RNYitiVHN6QUNMWmVhVDFSS3NkeURZYXJsT3l1bjJwNUJkOEhodDkvMXBY?=
 =?utf-8?B?T2ZwbFRzeEdZUDJsaHZ1cG51akZ0QTUwUEthRUlCSzhGYXhuQkJDSzRBcUtL?=
 =?utf-8?B?dW9uVlNITXJiWHRidzR5ejFORTJKOHFXczROelcxNmFKSGZ1R21hdnZ3UnJs?=
 =?utf-8?B?MW40d2puUHBIaWcwNTNoWEt4YVhObTJFc3p1SVExdTNNOStIR21RbndxUFkw?=
 =?utf-8?B?c2NZQ0t3WktlUlc2ekgxRDVVK1ZmdmNaMkJVUFdvK3lORzRPd3dxWWdJT2VC?=
 =?utf-8?B?NExGSHhDV2prT3ZiWnV1d0ttRkJ4eGlRSDdwUWNoQ0YwaEg5VEJ0MFBXT1Zs?=
 =?utf-8?B?M2p4NlltVzRiVUdINnJEM081TVk0QnZjT1J0K3EwcHVyckg5ZUl0bDhGM2JN?=
 =?utf-8?B?dHBiY3lZZmRFU0taaUpJa2pJOUdNZzlNdTB0dlp3MWc2VnVtZHBZeG9qVDhn?=
 =?utf-8?B?b2NhZlZTc2R0YWYzUk1aaFlUZUtadlZjK3J4dmxIMVpYT3FBY3pTQlZPQmcv?=
 =?utf-8?B?WXBZak9jc0hpSXpLVG92R2N4OHY4eFArbFdVc3k2c0lZWVdJb2FrcDJjT2Vr?=
 =?utf-8?B?anZEWUtId1ZKQzlqL2xIemFFMHRJd0haWHdxVGpKU1FsNTlxT2pHMEgrMHRq?=
 =?utf-8?B?ajEvdHZTdS9xck5OR2NzcUxFanc0YXJoRVRCOTZLMTZieWFGVUpxSHZocFEw?=
 =?utf-8?B?VW8zaDNnZUtqVEc0Z3JvaXhPbVJlb3N4eHJLTXY2aTZUdjRES3lsSVdQaTRS?=
 =?utf-8?B?SmFpeXZoRnB4OVpKOG9zYXNIVDJISDdhN1Q3eG12WGc0c3pFTHhCUkNFLzZo?=
 =?utf-8?B?ZENxSTZDS3R2RVA0UEZ5MFRZQnpwZjV3Q2NUcHM2anc5b0VyaTdQRkpmMEky?=
 =?utf-8?B?VGpFYy9Qdm4vTG8yN0JISXBxelNYcG5CZXFla1pHS1F3b3M2QlptKytUNFJ0?=
 =?utf-8?Q?IVfcHajhlXG+o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4288dde0-d9ff-4038-b1ba-08d8f8e7855c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 10:34:13.3632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/wZcRwGsJgy7Elga5SyOkdN5WpaoLaOCiVE/xINVUgRG35ZEco8HZG+AelI9t5h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3901
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
Content-Type: multipart/mixed; boundary="===============0780516683=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0780516683==
Content-Type: multipart/alternative;
 boundary="------------F7182D95F5A8366030F28419"
Content-Language: en-US

--------------F7182D95F5A8366030F28419
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Andrey,

well good question. My job is to watch over the implementation and 
design and while I always help I can adjust anybodies schedule.

Is the patch to print a warning when the hardware is accessed without 
holding the locks merged yet? If not then that would probably be a good 
starting point.

Then we would need to unify this with the SRCU to make sure that we have 
both the reset lock as well as block the hotplug code from reusing the 
MMIO space.

And then testing, testing, testing to see if we have missed something.

Christian.

Am 05.04.21 um 19:58 schrieb Andrey Grodzovsky:
>
> Denis, Christian, are there any updates in the plan on how to move on 
> with this ? As you know I need very similar code for my up-streaming 
> of device hot-unplug. My latest solution 
> (https://lists.freedesktop.org/archives/amd-gfx/2021-January/058606.html) 
> was not acceptable because of low level guards on the register 
> accessors level which was hurting performance. Basically I need a way 
> to prevent any MMIO write accesses from kernel driver after device is 
> removed (UMD accesses are taken care of by page faulting dummy page). 
> We are using now hot-unplug code for Freemont program and so 
> up-streaming became more of a priority then before. This MMIO access 
> issue is currently my main blocker from up-streaming. Is there any way 
> I can assist in pushing this on ?
>
> Andrey
>
> On 2021-03-18 5:51 a.m., Christian König wrote:
>> Am 18.03.21 um 10:30 schrieb Li, Dennis:
>>>
>>> >>> The GPU reset doesn't complete the fences we wait for. It only 
>>> completes the hardware fences as part of the reset.
>>>
>>> >>> So waiting for a fence while holding the reset lock is illegal 
>>> and needs to be avoided.
>>>
>>> I understood your concern. It is more complex for DRM GFX, therefore 
>>> I abandon adding lock protection for DRM ioctls now. Maybe we can 
>>> try to add all kernel  dma_fence waiting in a list, and signal all 
>>> in recovery threads. Do you have same concern for compute cases?
>>>
>>
>> Yes, compute (KFD) is even harder to handle.
>>
>> See you can't signal the dma_fence waiting. Waiting for a dma_fence 
>> also means you wait for the GPU reset to finish.
>>
>> When we would signal the dma_fence during the GPU reset then we would 
>> run into memory corruption because the hardware jobs running after 
>> the GPU reset would access memory which is already freed.
>>
>>> >>> Lockdep also complains about this when it is used correctly. The 
>>> only reason it doesn't complain here is because you use an 
>>> atomic+wait_event instead of a locking primitive.
>>>
>>> Agree. This approach will escape the monitor of lockdep.  Its goal 
>>> is to block other threads when GPU recovery thread start. But I 
>>> couldn’t find a better method to solve this problem. Do you have 
>>> some suggestion?
>>>
>>
>> Well, completely abandon those change here.
>>
>> What we need to do is to identify where hardware access happens and 
>> then insert taking the read side of the GPU reset lock so that we 
>> don't wait for a dma_fence or allocate memory, but still protect the 
>> hardware from concurrent access and reset.
>>
>> Regards,
>> Christian.
>>
>>> Best Regards
>>>
>>> Dennis Li
>>>
>>> *From:* Koenig, Christian <Christian.Koenig@amd.com>
>>> *Sent:* Thursday, March 18, 2021 4:59 PM
>>> *To:* Li, Dennis <Dennis.Li@amd.com>; amd-gfx@lists.freedesktop.org; 
>>> Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix 
>>> <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
>>> *Subject:* AW: [PATCH 0/4] Refine GPU recovery sequence to enhance 
>>> its stability
>>>
>>> Exactly that's what you don't seem to understand.
>>>
>>> The GPU reset doesn't complete the fences we wait for. It only 
>>> completes the hardware fences as part of the reset.
>>>
>>> So waiting for a fence while holding the reset lock is illegal and 
>>> needs to be avoided.
>>>
>>> Lockdep also complains about this when it is used correctly. The 
>>> only reason it doesn't complain here is because you use an 
>>> atomic+wait_event instead of a locking primitive.
>>>
>>> Regards,
>>>
>>> Christian.
>>>
>>> ------------------------------------------------------------------------
>>>
>>> *Von:*Li, Dennis <Dennis.Li@amd.com <mailto:Dennis.Li@amd.com>>
>>> *Gesendet:* Donnerstag, 18. März 2021 09:28
>>> *An:* Koenig, Christian <Christian.Koenig@amd.com 
>>> <mailto:Christian.Koenig@amd.com>>; amd-gfx@lists.freedesktop.org 
>>> <mailto:amd-gfx@lists.freedesktop.org> 
>>> <amd-gfx@lists.freedesktop.org 
>>> <mailto:amd-gfx@lists.freedesktop.org>>; Deucher, Alexander 
>>> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>; 
>>> Kuehling, Felix <Felix.Kuehling@amd.com 
>>> <mailto:Felix.Kuehling@amd.com>>; Zhang, Hawking 
>>> <Hawking.Zhang@amd.com <mailto:Hawking.Zhang@amd.com>>
>>> *Betreff:* RE: [PATCH 0/4] Refine GPU recovery sequence to enhance 
>>> its stability
>>>
>>> >>> Those two steps need to be exchanged or otherwise it is possible 
>>> that new delayed work items etc are started before the lock is taken.
>>> What about adding check for adev->in_gpu_reset in work item? If 
>>> exchange the two steps, it maybe introduce the deadlock.  For 
>>> example, the user thread hold the read lock and waiting for the 
>>> fence, if recovery thread try to hold write lock and then complete 
>>> fences, in this case, recovery thread will always be blocked.
>>>
>>>
>>> Best Regards
>>> Dennis Li
>>> -----Original Message-----
>>> From: Koenig, Christian <Christian.Koenig@amd.com 
>>> <mailto:Christian.Koenig@amd.com>>
>>> Sent: Thursday, March 18, 2021 3:54 PM
>>> To: Li, Dennis <Dennis.Li@amd.com <mailto:Dennis.Li@amd.com>>; 
>>> amd-gfx@lists.freedesktop.org 
>>> <mailto:amd-gfx@lists.freedesktop.org>; Deucher, Alexander 
>>> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>; 
>>> Kuehling, Felix <Felix.Kuehling@amd.com 
>>> <mailto:Felix.Kuehling@amd.com>>; Zhang, Hawking 
>>> <Hawking.Zhang@amd.com <mailto:Hawking.Zhang@amd.com>>
>>> Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its 
>>> stability
>>>
>>> Am 18.03.21 um 08:23 schrieb Dennis Li:
>>> > We have defined two variables in_gpu_reset and reset_sem in adev 
>>> object. The atomic type variable in_gpu_reset is used to avoid 
>>> recovery thread reenter and make lower functions return more earlier 
>>> when recovery start, but couldn't block recovery thread when it 
>>> access hardware. The r/w semaphore reset_sem is used to solve these 
>>> synchronization issues between recovery thread and other threads.
>>> >
>>> > The original solution locked registers' access in lower functions, 
>>> which will introduce following issues:
>>> >
>>> > 1) many lower functions are used in both recovery thread and 
>>> others. Firstly we must harvest these functions, it is easy to miss 
>>> someones. Secondly these functions need select which lock (read lock 
>>> or write lock) will be used, according to the thread it is running 
>>> in. If the thread context isn't considered, the added lock will 
>>> easily introduce deadlock. Besides that, in most time, developer 
>>> easily forget to add locks for new functions.
>>> >
>>> > 2) performance drop. More lower functions are more frequently called.
>>> >
>>> > 3) easily introduce false positive lockdep complaint, because 
>>> write lock has big range in recovery thread, but low level functions 
>>> will hold read lock may be protected by other locks in other threads.
>>> >
>>> > Therefore the new solution will try to add lock protection for 
>>> ioctls of kfd. Its goal is that there are no threads except for 
>>> recovery thread or its children (for xgmi) to access hardware when 
>>> doing GPU reset and resume. So refine recovery thread as the following:
>>> >
>>> > Step 0: atomic_cmpxchg(&adev->in_gpu_reset, 0, 1)
>>> >     1). if failed, it means system had a recovery thread running, 
>>> current thread exit directly;
>>> >     2). if success, enter recovery thread;
>>> >
>>> > Step 1: cancel all delay works, stop drm schedule, complete all 
>>> unreceived fences and so on. It try to stop or pause other threads.
>>> >
>>> > Step 2: call down_write(&adev->reset_sem) to hold write lock, 
>>> which will block recovery thread until other threads release read locks.
>>>
>>> Those two steps need to be exchanged or otherwise it is possible 
>>> that new delayed work items etc are started before the lock is taken.
>>>
>>> Just to make it clear until this is fixed the whole patch set is a NAK.
>>>
>>> Regards,
>>> Christian.
>>>
>>> >
>>> > Step 3: normally, there is only recovery threads running to access 
>>> hardware, it is safe to do gpu reset now.
>>> >
>>> > Step 4: do post gpu reset, such as call all ips' resume functions;
>>> >
>>> > Step 5: atomic set adev->in_gpu_reset as 0, wake up other threads 
>>> and release write lock. Recovery thread exit normally.
>>> >
>>> > Other threads call the amdgpu_read_lock to synchronize with 
>>> recovery thread. If it finds that in_gpu_reset is 1, it should 
>>> release read lock if it has holden one, and then blocks itself to 
>>> wait for recovery finished event. If thread successfully hold read 
>>> lock and in_gpu_reset is 0, it continues. It will exit normally or 
>>> be stopped by recovery thread in step 1.
>>> >
>>> > Dennis Li (4):
>>> >    drm/amdgpu: remove reset lock from low level functions
>>> >    drm/amdgpu: refine the GPU recovery sequence
>>> >    drm/amdgpu: instead of using down/up_read directly
>>> >    drm/amdkfd: add reset lock protection for kfd entry functions
>>> >
>>> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h |   6 +
>>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  14 +-
>>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 173 
>>> +++++++++++++-----
>>> >   .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c |   8 -
>>> >   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |   4 +-
>>> >   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c |   9 +-
>>> >   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c |   5 +-
>>> >   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c |   5 +-
>>> >   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 172 
>>> ++++++++++++++++-
>>> >   drivers/gpu/drm/amd/amdkfd/kfd_priv.h |   3 +-
>>> >   drivers/gpu/drm/amd/amdkfd/kfd_process.c |   4 +
>>> >   .../amd/amdkfd/kfd_process_queue_manager.c |  17 ++
>>> >   12 files changed, 345 insertions(+), 75 deletions(-)
>>> >
>>>
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------F7182D95F5A8366030F28419
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Hi Andrey,<br>
    <br>
    well good question. My job is to watch over the implementation and
    design and while I always help I can adjust anybodies schedule.<br>
    <br>
    Is the patch to print a warning when the hardware is accessed
    without holding the locks merged yet? If not then that would
    probably be a good starting point.<br>
    <br>
    Then we would need to unify this with the SRCU to make sure that we
    have both the reset lock as well as block the hotplug code from
    reusing the MMIO space.<br>
    <br>
    And then testing, testing, testing to see if we have missed
    something.<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 05.04.21 um 19:58 schrieb Andrey
      Grodzovsky:<br>
    </div>
    <blockquote type="cite" cite="mid:1e37bb4d-f54d-1b7e-4632-94cfcf749528@amd.com">
      
      <p>Denis, Christian, are there any updates in the plan on how to
        move on with this ? As you know I need very similar code for my
        up-streaming of device hot-unplug. My latest solution
        (<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/archives/amd-gfx/2021-January/058606.html" moz-do-not-send="true">https://lists.freedesktop.org/archives/amd-gfx/2021-January/058606.html</a>)
        was not acceptable because of low level guards on the register
        accessors level which was hurting performance. Basically I need
        a way to prevent any MMIO write accesses from kernel driver
        after device is removed (UMD accesses are taken care of by page
        faulting dummy page). We are using now hot-unplug code for
        Freemont program and so up-streaming became more of a priority
        then before. This MMIO access issue is currently my main blocker
        from up-streaming. Is there any way I can assist in pushing this
        on ?</p>
      <p>Andrey&nbsp; <br>
      </p>
      <div class="moz-cite-prefix">On 2021-03-18 5:51 a.m., Christian
        König wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:378fdffb-99b5-2a14-736d-a06f310b040c@amd.com"> Am
        18.03.21 um 10:30 schrieb Li, Dennis:<br>
        <blockquote type="cite" cite="mid:DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com">
          <meta name="Generator" content="Microsoft Word 15 (filtered
            medium)">
          <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
          <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:等线;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:"\@等线";
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
          <div class="WordSection1">
            <p class="MsoNormal">&gt;&gt;&gt; The GPU reset doesn't
              complete the fences we wait for. It only completes the
              hardware fences as part of the reset.<o:p></o:p></p>
            <p class="MsoNormal">&gt;&gt;&gt; So waiting for a fence
              while holding the reset lock is illegal and needs to be
              avoided.<o:p></o:p></p>
            <p class="MsoNormal">I understood your concern. It is more
              complex for DRM GFX, therefore I abandon adding lock
              protection for DRM ioctls now. Maybe we can try to add all
              kernel &nbsp;dma_fence waiting in a list, and signal all in
              recovery threads. Do you have same concern for compute
              cases? </p>
          </div>
        </blockquote>
        <br>
        Yes, compute (KFD) is even harder to handle.<br>
        <br>
        See you can't signal the dma_fence waiting. Waiting for a
        dma_fence also means you wait for the GPU reset to finish.<br>
        <br>
        When we would signal the dma_fence during the GPU reset then we
        would run into memory corruption because the hardware jobs
        running after the GPU reset would access memory which is already
        freed.<br>
        <br>
        <blockquote type="cite" cite="mid:DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com">
          <div class="WordSection1">
            <p class="MsoNormal"><o:p></o:p></p>
            <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            <p class="MsoNormal">&gt;&gt;&gt; Lockdep also complains
              about this when it is used correctly. The only reason it
              doesn't complain here is because you use an
              atomic+wait_event instead of a locking primitive.<o:p></o:p></p>
            <p class="MsoNormal">Agree. This approach will escape the
              monitor of lockdep.&nbsp; Its goal is to block other threads
              when GPU recovery thread start. But I couldn’t find a
              better method to solve this problem. Do you have some
              suggestion? </p>
          </div>
        </blockquote>
        <br>
        Well, completely abandon those change here.<br>
        <br>
        What we need to do is to identify where hardware access happens
        and then insert taking the read side of the GPU reset lock so
        that we don't wait for a dma_fence or allocate memory, but still
        protect the hardware from concurrent access and reset.<br>
        <br>
        Regards,<br>
        Christian.<br>
        <br>
        <blockquote type="cite" cite="mid:DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com">
          <div class="WordSection1">
            <p class="MsoNormal"><o:p></o:p></p>
            <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            <p class="MsoNormal">Best Regards<o:p></o:p></p>
            <p class="MsoNormal">Dennis Li<o:p></o:p></p>
            <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            <div>
              <div style="border:none;border-top:solid #E1E1E1
                1.0pt;padding:3.0pt 0in 0in 0in">
                <p class="MsoNormal"><b>From:</b> Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>
                  <br>
                  <b>Sent:</b> Thursday, March 18, 2021 4:59 PM<br>
                  <b>To:</b> Li, Dennis <a class="moz-txt-link-rfc2396E" href="mailto:Dennis.Li@amd.com" moz-do-not-send="true">&lt;Dennis.Li@amd.com&gt;</a>;
                  <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>;
                  Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
                  Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">&lt;Felix.Kuehling@amd.com&gt;</a>;
                  Zhang, Hawking <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com" moz-do-not-send="true">&lt;Hawking.Zhang@amd.com&gt;</a><br>
                  <b>Subject:</b> AW: [PATCH 0/4] Refine GPU recovery
                  sequence to enhance its stability<o:p></o:p></p>
              </div>
            </div>
            <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            <div>
              <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                  UI&quot;,sans-serif;color:black">Exactly that's what
                  you don't seem to understand.<o:p></o:p></span></p>
            </div>
            <div>
              <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                  UI&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
            </div>
            <div>
              <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                  UI&quot;,sans-serif;color:black">The GPU reset doesn't
                  complete the fences we wait for. It only completes the
                  hardware fences as part of the reset.<o:p></o:p></span></p>
            </div>
            <div>
              <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                  UI&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
            </div>
            <div>
              <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                  UI&quot;,sans-serif;color:black">So waiting for a
                  fence while holding the reset lock is illegal and
                  needs to be avoided.<o:p></o:p></span></p>
            </div>
            <div>
              <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                  UI&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
            </div>
            <div>
              <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                  UI&quot;,sans-serif;color:black">Lockdep also
                  complains about this when it is used correctly. The
                  only reason it doesn't complain here is because you
                  use an atomic+wait_event instead of a locking
                  primitive.<o:p></o:p></span></p>
            </div>
            <div>
              <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                  UI&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
            </div>
            <div>
              <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                  UI&quot;,sans-serif;color:black">Regards,<o:p></o:p></span></p>
            </div>
            <div>
              <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                  UI&quot;,sans-serif;color:black">Christian.<o:p></o:p></span></p>
            </div>
            <div>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            </div>
            <div class="MsoNormal" style="text-align:center" align="center">
              <hr width="98%" size="2" align="center"> </div>
            <div id="divRplyFwdMsg">
              <p class="MsoNormal"><b><span style="color:black">Von:</span></b><span style="color:black"> Li, Dennis &lt;<a href="mailto:Dennis.Li@amd.com" moz-do-not-send="true">Dennis.Li@amd.com</a>&gt;<br>
                  <b>Gesendet:</b> Donnerstag, 18. März 2021 09:28<br>
                  <b>An:</b> Koenig, Christian &lt;<a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">Christian.Koenig@amd.com</a>&gt;;
                  <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
                  &lt;<a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>&gt;;
                  Deucher, Alexander &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;;
                  Kuehling, Felix &lt;<a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">Felix.Kuehling@amd.com</a>&gt;;
                  Zhang, Hawking &lt;<a href="mailto:Hawking.Zhang@amd.com" moz-do-not-send="true">Hawking.Zhang@amd.com</a>&gt;<br>
                  <b>Betreff:</b> RE: [PATCH 0/4] Refine GPU recovery
                  sequence to enhance its stability</span> <o:p></o:p></p>
              <div>
                <p class="MsoNormal">&nbsp;<o:p></o:p></p>
              </div>
            </div>
            <div>
              <div>
                <p class="MsoNormal">&gt;&gt;&gt; Those two steps need
                  to be exchanged or otherwise it is possible that new
                  delayed work items etc are started before the lock is
                  taken.<br>
                  What about adding check for adev-&gt;in_gpu_reset in
                  work item? If exchange the two steps, it maybe
                  introduce the deadlock.&nbsp; For example, the user thread
                  hold the read lock and waiting for the fence, if
                  recovery thread try to hold write lock and then
                  complete fences, in this case, recovery thread will
                  always be blocked.<o:p></o:p></p>
              </div>
              <div>
                <p class="MsoNormal" style="margin-bottom:12.0pt"><br>
                  Best Regards<br>
                  Dennis Li<br>
                  -----Original Message-----<br>
                  From: Koenig, Christian &lt;<a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">Christian.Koenig@amd.com</a>&gt;
                  <br>
                  Sent: Thursday, March 18, 2021 3:54 PM<br>
                  To: Li, Dennis &lt;<a href="mailto:Dennis.Li@amd.com" moz-do-not-send="true">Dennis.Li@amd.com</a>&gt;; <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                    amd-gfx@lists.freedesktop.org</a>; Deucher,
                  Alexander &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;;
                  Kuehling, Felix &lt;<a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">Felix.Kuehling@amd.com</a>&gt;;
                  Zhang, Hawking &lt;<a href="mailto:Hawking.Zhang@amd.com" moz-do-not-send="true">Hawking.Zhang@amd.com</a>&gt;<br>
                  Subject: Re: [PATCH 0/4] Refine GPU recovery sequence
                  to enhance its stability<br>
                  <br>
                  Am 18.03.21 um 08:23 schrieb Dennis Li:<br>
                  &gt; We have defined two variables in_gpu_reset and
                  reset_sem in adev object. The atomic type variable
                  in_gpu_reset is used to avoid recovery thread reenter
                  and make lower functions return more earlier when
                  recovery start, but couldn't block recovery thread
                  when it access hardware. The r/w semaphore reset_sem
                  is used to solve these synchronization issues between
                  recovery thread and other threads.<br>
                  &gt;<br>
                  &gt; The original solution locked registers' access in
                  lower functions, which will introduce following
                  issues:<br>
                  &gt;<br>
                  &gt; 1) many lower functions are used in both recovery
                  thread and others. Firstly we must harvest these
                  functions, it is easy to miss someones. Secondly these
                  functions need select which lock (read lock or write
                  lock) will be used, according to the thread it is
                  running in. If the thread context isn't considered,
                  the added lock will easily introduce deadlock. Besides
                  that, in most time, developer easily forget to add
                  locks for new functions.<br>
                  &gt;<br>
                  &gt; 2) performance drop. More lower functions are
                  more frequently called.<br>
                  &gt;<br>
                  &gt; 3) easily introduce false positive lockdep
                  complaint, because write lock has big range in
                  recovery thread, but low level functions will hold
                  read lock may be protected by other locks in other
                  threads.<br>
                  &gt;<br>
                  &gt; Therefore the new solution will try to add lock
                  protection for ioctls of kfd. Its goal is that there
                  are no threads except for recovery thread or its
                  children (for xgmi) to access hardware when doing GPU
                  reset and resume. So refine recovery thread as the
                  following:<br>
                  &gt;<br>
                  &gt; Step 0:
                  atomic_cmpxchg(&amp;adev-&gt;in_gpu_reset, 0, 1)<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp; 1). if failed, it means system had a recovery
                  thread running, current thread exit directly;<br>
                  &gt;&nbsp;&nbsp;&nbsp;&nbsp; 2). if success, enter recovery thread;<br>
                  &gt;<br>
                  &gt; Step 1: cancel all delay works, stop drm
                  schedule, complete all unreceived fences and so on. It
                  try to stop or pause other threads.<br>
                  &gt;<br>
                  &gt; Step 2: call down_write(&amp;adev-&gt;reset_sem)
                  to hold write lock, which will block recovery thread
                  until other threads release read locks.<br>
                  <br>
                  Those two steps need to be exchanged or otherwise it
                  is possible that new delayed work items etc are
                  started before the lock is taken.<br>
                  <br>
                  Just to make it clear until this is fixed the whole
                  patch set is a NAK.<br>
                  <br>
                  Regards,<br>
                  Christian.<br>
                  <br>
                  &gt;<br>
                  &gt; Step 3: normally, there is only recovery threads
                  running to access hardware, it is safe to do gpu reset
                  now.<br>
                  &gt;<br>
                  &gt; Step 4: do post gpu reset, such as call all ips'
                  resume functions;<br>
                  &gt;<br>
                  &gt; Step 5: atomic set adev-&gt;in_gpu_reset as 0,
                  wake up other threads and release write lock. Recovery
                  thread exit normally.<br>
                  &gt;<br>
                  &gt; Other threads call the amdgpu_read_lock to
                  synchronize with recovery thread. If it finds that
                  in_gpu_reset is 1, it should release read lock if it
                  has holden one, and then blocks itself to wait for
                  recovery finished event. If thread successfully hold
                  read lock and in_gpu_reset is 0, it continues. It will
                  exit normally or be stopped by recovery thread in step
                  1.<br>
                  &gt;<br>
                  &gt; Dennis Li (4):<br>
                  &gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: remove reset lock from low level
                  functions<br>
                  &gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: refine the GPU recovery sequence<br>
                  &gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: instead of using down/up_read
                  directly<br>
                  &gt;&nbsp;&nbsp;&nbsp; drm/amdkfd: add reset lock protection for kfd
                  entry functions<br>
                  &gt;<br>
                  &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  |&nbsp;&nbsp; 6 +<br>
                  &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c&nbsp;&nbsp;
                  |&nbsp; 14 +-<br>
                  &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&nbsp;&nbsp; |
                  173 +++++++++++++-----<br>
                  &gt;&nbsp;&nbsp; .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c&nbsp;&nbsp;&nbsp;
                  |&nbsp;&nbsp; 8 -<br>
                  &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  |&nbsp;&nbsp; 4 +-<br>
                  &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  |&nbsp;&nbsp; 9 +-<br>
                  &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  |&nbsp;&nbsp; 5 +-<br>
                  &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  |&nbsp;&nbsp; 5 +-<br>
                  &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_chardev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
                  172 ++++++++++++++++-<br>
                  &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  |&nbsp;&nbsp; 3 +-<br>
                  &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  |&nbsp;&nbsp; 4 +<br>
                  &gt;&nbsp;&nbsp; .../amd/amdkfd/kfd_process_queue_manager.c&nbsp;&nbsp;&nbsp;
                  |&nbsp; 17 ++<br>
                  &gt;&nbsp;&nbsp; 12 files changed, 345 insertions(+), 75
                  deletions(-)<br>
                  &gt;<o:p></o:p></p>
              </div>
            </div>
          </div>
        </blockquote>
        <br>
        <br>
        <fieldset class="mimeAttachmentHeader"></fieldset>
        <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------F7182D95F5A8366030F28419--

--===============0780516683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0780516683==--
