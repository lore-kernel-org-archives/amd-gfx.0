Return-Path: <SRS0=xdDd=JC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CDDC433ED
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Apr 2021 17:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44ABB6113D
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Apr 2021 17:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44ABB6113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEB7289664;
	Mon,  5 Apr 2021 17:58:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55C6389664
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Apr 2021 17:58:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lefQz22q8mVFo5HAbD1VaivmE4VsdU2kwT9Y030kAFQj4M49SVevK7OcNQ0Vvz/BvpKGQjIad3lejFItfuP8PcxW6g3/kCvzsYVIqJAmSh1MuETsTnVZDanRDEj7G+XzTUFY3MNkI9gCLY+pIZthneXaBxU4MM4GKfxCvDRQ3US4ldckzhSi7Ui3GbSw0BFdNvFOi4Nos2tZe4Cp8g8xATT0eC0EJ4fD57/oZCnSRGqa/bkDEpfxijzpQgB7Sle4SnCjIP9R04QuoTDCRzbjWMhA4Hbwqoems7wgYrGjaPxhPR9FeuxnacKsQWACmDzw0ulPn0YFc8MUQI7HH7dzkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZwzDKYtHpZ5cd6UUoGa1jVlJTCao1TTK3Pv4R/VtR4=;
 b=S1SJDfCBOv7KgQdYX/J0PZ3snHvI7BnjimjSXYvbrDlCXTxxQneCwuvvYPGj9DlvKSZtkUIblgt+8+zjbpGPluDwS7prP+pO7ECIokYUS5R7IzZ1LwU4ZlkAIW3IvD6Z21943kr/7XguSY+hHpWTlo6kJX5nzFr2GWIwXbDS2utKThenzAV89B53w9HCQSQtmRwGa/ZFWbbGLmwA0rELpdK3irum2dn5l1vD8YzHanRHUrJJTD/VXqbr4zxzECySIyN3oP+d89UhGR0fTWbzBEcjHloBl8Gz3Ru62odK2d/oF/WoPuME4tCGlQiI9nw9S79IUUJa2mImm2ZKN8olZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZwzDKYtHpZ5cd6UUoGa1jVlJTCao1TTK3Pv4R/VtR4=;
 b=yaRXWTsPxm0zf9c0Nm9GPDXBWSK/aHWERU191m6c+5Ka72TF5UilJ0myndaeQZ0glqHOKS7tRxbL/Is2cb1wLzGgCB7Mqjbvw9hK1yEu/Yc79bq9Kgqazfq4DLL+yLIG0qcF1naE8Pm3iuVxPjyU4xj/kj5SgWxXED5vpAe0hmw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB2814.namprd12.prod.outlook.com (2603:10b6:805:72::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Mon, 5 Apr
 2021 17:58:11 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8%6]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 17:58:11 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <1e37bb4d-f54d-1b7e-4632-94cfcf749528@amd.com>
Date: Mon, 5 Apr 2021 13:58:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <378fdffb-99b5-2a14-736d-a06f310b040c@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:735:b7a7:7d67:dece]
X-ClientProxiedBy: YT1PR01CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::28)
 To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:735:b7a7:7d67:dece]
 (2607:fea8:3edf:49b0:735:b7a7:7d67:dece) by
 YT1PR01CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.32 via Frontend Transport; Mon, 5 Apr 2021 17:58:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59400800-5920-4b04-e908-08d8f85c6089
X-MS-TrafficTypeDiagnostic: SN6PR12MB2814:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2814499DC2AF2E4B84A88220EA779@SN6PR12MB2814.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S/gGa2dAvuVEho9HpiXSm3PdJlzd8PG+vVb6N0BE4jqTAUdxGvtFzS6xTTvmjO28avOTKDfo+Pc79hRoiVNZayererSG4Lltv8atuE9H+EQp+o6bX+nxDboOtTkgXQMA+DKhjwVybZpjmqy2h5+jq6s2/jpA97BlE9Ut7KYf5ogyhLYMalMMm4aAjmiU8UMXEcZ9tw7iJfbe9ZMIB4i8ihpvQW6+LeyOErw9L8Z0EIi5X3TwbEmKWF84JUL8H3n35qZmEUypQHB5BBFoYH5XoCkWiVttKmGUWclCwEFPQ4eVSFlWLBUTkvS5aUh/Xvi+jJ0DCBDE/3xDnX8XhSNaBpMXKUZcYYoRZdgoINrgOneqEJABGvIHJQ96UUnZIymEIGnFmBaDF3heu3wuAqpdZKV/5BzaomfBzEg/hlvlnRL3U9wYh+vuglJlgacjhof1hYCGjtlNrz9d3mk8UwpOi4ucmWFpjZ2OOCPyO+A2RuolqDCgu89ZE4xKctMJm6AC9eGBxWTfBH3VkM377FAtovJd7Ml6Ex+rdCzLiCdiS8IHDERNGuieIggXIrfEqKi3rGjBRiYH4ax51jWsdKnQj4lAMHh4wVZCpng8sNh0A0iER3Vp4Dei8ZBaOJ/piM8eznto0cyEaw48Js0HGs+fbbdAo7VR9f6+TdahuYtywdDtP7T0sMdRDmKubXSduqZuu0cA39a404PaVPS1a/6pSVa1C7ysnKuVOxT8XDlkZ1Nc4n+t+7hMOJ7R2+Ot631DZ2FOmBplv4O3u6LrYprxiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(478600001)(316002)(2906002)(38100700001)(66946007)(8676002)(110136005)(52116002)(5660300002)(966005)(44832011)(30864003)(921005)(31686004)(16526019)(186003)(36756003)(66574015)(21615005)(66556008)(33964004)(66476007)(166002)(86362001)(53546011)(8936002)(83380400001)(6636002)(31696002)(2616005)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YnlIdFN4U1dKZ0lDaWhaNVpiT3NvdDZBdzBVR1g0UjYwQ2thd1JVTVNJNXli?=
 =?utf-8?B?OGpDSS8yc1JrS2hvZElpbVh3Rm9mMituUHVNMURDNHJsbnVoQWlPbHplTEtJ?=
 =?utf-8?B?QldoR1AzN2dzLzBlSk9wbEpLa1prMms0TlU1UzJyWFNzS1JWTmxkWDk5NEkx?=
 =?utf-8?B?anFNRDBTNGVic0hWSnVuWW5zQ2NUakU2MmNtR2VndXJGUzY3NFlYQ0RtMW9p?=
 =?utf-8?B?OTlNa1R0VTZmQjEvZy9wdmkrVEUrL3JvaTlyTXMrT0V3SGMwWExJNldHdkpT?=
 =?utf-8?B?VWIzZkZ1eGZReUxGQlc4aTg0dUwzWlZEOEQ2eGtXYlU4RWxvZStKZWpBajZV?=
 =?utf-8?B?VmNXQjgyaDJ3NUJqTmJKRW9GMXh0VXdYSVFOaWR3cmVGOHBrVFpZdk1JQ1RC?=
 =?utf-8?B?aUlYbVRtWVBBcFNLMVR2c0w2SkN3ajZ6eUg2bVRIeFh0aUJHdGZINjUrSVNK?=
 =?utf-8?B?a2RCcHhoOUx1WTlRQWFBQ3RTN2RYU0RzSyswYXZzUC9zQ3hjdlVkdkxwZ2I3?=
 =?utf-8?B?Z1ZaVTZ3WGpZZTlZK0tnRjZ0NXVQYzFjVmN0NHJRVkxNZm1pc0dadjBiNWd0?=
 =?utf-8?B?YlpRQXk3aFZPN25rVU15SVBGeHRyeVJXY29LQzNpQTQ1ZWVSaUlBK1ZtUnJi?=
 =?utf-8?B?NmxzNmJTUlBmZk9qTFlqTlVTMXFVb3EwUUpSbkk3ZE1PUUEvWWZWdjJ6NGNV?=
 =?utf-8?B?VGJrUWtaeSs2Zzh0emFSbi9LMHZDWDhscm9YcWxLV3V3bmlKSWtMaDNUTThB?=
 =?utf-8?B?TnphaThJRlBjaXBJOHQ2UTF4aTFDaE5sS1NZTGpROExXVjYrMWNvK25meXFH?=
 =?utf-8?B?S1BYN0IvbFJYRVFEWnVPUmZHbmhtNEZKOW9ubkd5by9uSnlLR0toVHlqUkZk?=
 =?utf-8?B?NXFEUDkxQlh5SUJ0bU0wUWR4TEZHTTdibE9MUTE5UDRxVzQrOU1QN0oxK0hO?=
 =?utf-8?B?dDlhR2YrR0t2NHY2eXZ3em1yYTVDYWI3ZnlxUG9EcmpMTGlScGppVWlZVXhz?=
 =?utf-8?B?RFVOaWdNekt6UXRrS2VESWU4emZpZEgvcDErT2g4QlExbHoxYVRtRlVGTmtu?=
 =?utf-8?B?MDBncGU2eWw3N0FXSmJnWlNaNE12eEsycWZhVGtQR1BoNUNyQVZuSHRQU2xR?=
 =?utf-8?B?bjdYcWhxZnBzM25PNTFTc3p4MFJROXdjVXc3RnNaRkpsYm1ESWcycDZkUnFh?=
 =?utf-8?B?UWdSRUZYWmFUOW9MSUhYT2JEWjM4M1JmVkg2K0xEbmNVQkRJQ3hxaUYwbEsz?=
 =?utf-8?B?WWNxYUF3S29reFlvZ1duVVVsNjZwTXBHcU5EbTB2T05RTEVnN1lIQjNvUWt2?=
 =?utf-8?B?dkdzd0c0VzVrTjhvejc2eWdqZkM2Rk9DVnRRVW93dGZwVGZYSzFUUFdDd2Jj?=
 =?utf-8?B?RUhVekxabXRnUGZUd1FqbVNRekJueUd4cGN0WnFIWGZkSWlKN1FjUXlsLzRW?=
 =?utf-8?B?NVFQSVptZ1ZvYkUrVFluR3NyU1dHU2h0NEpKQ1pQZEo4V0c1NFlrRmdIVmly?=
 =?utf-8?B?UjhpU2VwWW1MWUpvVjl6ZFhTY0luSG1MbFVPbENGcTF2NlpkQmM1Y1JGcjRC?=
 =?utf-8?B?elVJYnZUU3dLd05qcllMbCttNmttYStaaFpBSE04NXlRL2NTS2FUbzJ4OHNB?=
 =?utf-8?B?Ty84TW5rWUlVY3lpeGNJbHhYU2MxQ0xXeDYvVUdPNVo2QVFXVzM1dTBPNzk2?=
 =?utf-8?B?eVZJS3JJQ3dnUmxtRVBqbFkzNy94eUN2RkI2UmUzR29zN3ZWclB0b2p2dTRG?=
 =?utf-8?B?T2hIUS90TFd1dnl0a3pTSVM0dWR3Ti9HdHlPVU9oTlVkbXJhWE1NMEhEbnNP?=
 =?utf-8?B?K2Z0dysvU1YyeGdGRm92RCtOaVQ0a2FXZ0NIOEdjNEdCK2Jjd0pwUXJiWFZZ?=
 =?utf-8?Q?mdzYAEAEBDeNi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59400800-5920-4b04-e908-08d8f85c6089
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 17:58:11.5764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3KdW8zALCz8mD6O6FDrdgzYDy/e0EDn/AkqBQI++sxnPQHPAE+ORk6A0qVQPbF1n72u4/0MaWA3CZUWEDjBzsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2814
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
Content-Type: multipart/mixed; boundary="===============0894081199=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0894081199==
Content-Type: multipart/alternative;
 boundary="------------4B7ACB8AE37D0731AA0BDA4A"
Content-Language: en-US

--------------4B7ACB8AE37D0731AA0BDA4A
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Denis, Christian, are there any updates in the plan on how to move on 
with this ? As you know I need very similar code for my up-streaming of 
device hot-unplug. My latest solution 
(https://lists.freedesktop.org/archives/amd-gfx/2021-January/058606.html) 
was not acceptable because of low level guards on the register accessors 
level which was hurting performance. Basically I need a way to prevent 
any MMIO write accesses from kernel driver after device is removed (UMD 
accesses are taken care of by page faulting dummy page). We are using 
now hot-unplug code for Freemont program and so up-streaming became more 
of a priority then before. This MMIO access issue is currently my main 
blocker from up-streaming. Is there any way I can assist in pushing this 
on ?

Andrey

On 2021-03-18 5:51 a.m., Christian König wrote:
> Am 18.03.21 um 10:30 schrieb Li, Dennis:
>>
>> >>> The GPU reset doesn't complete the fences we wait for. It only 
>> completes the hardware fences as part of the reset.
>>
>> >>> So waiting for a fence while holding the reset lock is illegal 
>> and needs to be avoided.
>>
>> I understood your concern. It is more complex for DRM GFX, therefore 
>> I abandon adding lock protection for DRM ioctls now. Maybe we can try 
>> to add all kernel  dma_fence waiting in a list, and signal all in 
>> recovery threads. Do you have same concern for compute cases?
>>
>
> Yes, compute (KFD) is even harder to handle.
>
> See you can't signal the dma_fence waiting. Waiting for a dma_fence 
> also means you wait for the GPU reset to finish.
>
> When we would signal the dma_fence during the GPU reset then we would 
> run into memory corruption because the hardware jobs running after the 
> GPU reset would access memory which is already freed.
>
>> >>> Lockdep also complains about this when it is used correctly. The 
>> only reason it doesn't complain here is because you use an 
>> atomic+wait_event instead of a locking primitive.
>>
>> Agree. This approach will escape the monitor of lockdep.  Its goal is 
>> to block other threads when GPU recovery thread start. But I couldn’t 
>> find a better method to solve this problem. Do you have some suggestion?
>>
>
> Well, completely abandon those change here.
>
> What we need to do is to identify where hardware access happens and 
> then insert taking the read side of the GPU reset lock so that we 
> don't wait for a dma_fence or allocate memory, but still protect the 
> hardware from concurrent access and reset.
>
> Regards,
> Christian.
>
>> Best Regards
>>
>> Dennis Li
>>
>> *From:* Koenig, Christian <Christian.Koenig@amd.com>
>> *Sent:* Thursday, March 18, 2021 4:59 PM
>> *To:* Li, Dennis <Dennis.Li@amd.com>; amd-gfx@lists.freedesktop.org; 
>> Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix 
>> <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
>> *Subject:* AW: [PATCH 0/4] Refine GPU recovery sequence to enhance 
>> its stability
>>
>> Exactly that's what you don't seem to understand.
>>
>> The GPU reset doesn't complete the fences we wait for. It only 
>> completes the hardware fences as part of the reset.
>>
>> So waiting for a fence while holding the reset lock is illegal and 
>> needs to be avoided.
>>
>> Lockdep also complains about this when it is used correctly. The only 
>> reason it doesn't complain here is because you use an 
>> atomic+wait_event instead of a locking primitive.
>>
>> Regards,
>>
>> Christian.
>>
>> ------------------------------------------------------------------------
>>
>> *Von:*Li, Dennis <Dennis.Li@amd.com <mailto:Dennis.Li@amd.com>>
>> *Gesendet:* Donnerstag, 18. März 2021 09:28
>> *An:* Koenig, Christian <Christian.Koenig@amd.com 
>> <mailto:Christian.Koenig@amd.com>>; amd-gfx@lists.freedesktop.org 
>> <mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freedesktop.org 
>> <mailto:amd-gfx@lists.freedesktop.org>>; Deucher, Alexander 
>> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>; 
>> Kuehling, Felix <Felix.Kuehling@amd.com 
>> <mailto:Felix.Kuehling@amd.com>>; Zhang, Hawking 
>> <Hawking.Zhang@amd.com <mailto:Hawking.Zhang@amd.com>>
>> *Betreff:* RE: [PATCH 0/4] Refine GPU recovery sequence to enhance 
>> its stability
>>
>> >>> Those two steps need to be exchanged or otherwise it is possible 
>> that new delayed work items etc are started before the lock is taken.
>> What about adding check for adev->in_gpu_reset in work item? If 
>> exchange the two steps, it maybe introduce the deadlock.  For 
>> example, the user thread hold the read lock and waiting for the 
>> fence, if recovery thread try to hold write lock and then complete 
>> fences, in this case, recovery thread will always be blocked.
>>
>>
>> Best Regards
>> Dennis Li
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com 
>> <mailto:Christian.Koenig@amd.com>>
>> Sent: Thursday, March 18, 2021 3:54 PM
>> To: Li, Dennis <Dennis.Li@amd.com <mailto:Dennis.Li@amd.com>>; 
>> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>; 
>> Deucher, Alexander <Alexander.Deucher@amd.com 
>> <mailto:Alexander.Deucher@amd.com>>; Kuehling, Felix 
>> <Felix.Kuehling@amd.com <mailto:Felix.Kuehling@amd.com>>; Zhang, 
>> Hawking <Hawking.Zhang@amd.com <mailto:Hawking.Zhang@amd.com>>
>> Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its 
>> stability
>>
>> Am 18.03.21 um 08:23 schrieb Dennis Li:
>> > We have defined two variables in_gpu_reset and reset_sem in adev 
>> object. The atomic type variable in_gpu_reset is used to avoid 
>> recovery thread reenter and make lower functions return more earlier 
>> when recovery start, but couldn't block recovery thread when it 
>> access hardware. The r/w semaphore reset_sem is used to solve these 
>> synchronization issues between recovery thread and other threads.
>> >
>> > The original solution locked registers' access in lower functions, 
>> which will introduce following issues:
>> >
>> > 1) many lower functions are used in both recovery thread and 
>> others. Firstly we must harvest these functions, it is easy to miss 
>> someones. Secondly these functions need select which lock (read lock 
>> or write lock) will be used, according to the thread it is running 
>> in. If the thread context isn't considered, the added lock will 
>> easily introduce deadlock. Besides that, in most time, developer 
>> easily forget to add locks for new functions.
>> >
>> > 2) performance drop. More lower functions are more frequently called.
>> >
>> > 3) easily introduce false positive lockdep complaint, because write 
>> lock has big range in recovery thread, but low level functions will 
>> hold read lock may be protected by other locks in other threads.
>> >
>> > Therefore the new solution will try to add lock protection for 
>> ioctls of kfd. Its goal is that there are no threads except for 
>> recovery thread or its children (for xgmi) to access hardware when 
>> doing GPU reset and resume. So refine recovery thread as the following:
>> >
>> > Step 0: atomic_cmpxchg(&adev->in_gpu_reset, 0, 1)
>> >     1). if failed, it means system had a recovery thread running, 
>> current thread exit directly;
>> >     2). if success, enter recovery thread;
>> >
>> > Step 1: cancel all delay works, stop drm schedule, complete all 
>> unreceived fences and so on. It try to stop or pause other threads.
>> >
>> > Step 2: call down_write(&adev->reset_sem) to hold write lock, which 
>> will block recovery thread until other threads release read locks.
>>
>> Those two steps need to be exchanged or otherwise it is possible that 
>> new delayed work items etc are started before the lock is taken.
>>
>> Just to make it clear until this is fixed the whole patch set is a NAK.
>>
>> Regards,
>> Christian.
>>
>> >
>> > Step 3: normally, there is only recovery threads running to access 
>> hardware, it is safe to do gpu reset now.
>> >
>> > Step 4: do post gpu reset, such as call all ips' resume functions;
>> >
>> > Step 5: atomic set adev->in_gpu_reset as 0, wake up other threads 
>> and release write lock. Recovery thread exit normally.
>> >
>> > Other threads call the amdgpu_read_lock to synchronize with 
>> recovery thread. If it finds that in_gpu_reset is 1, it should 
>> release read lock if it has holden one, and then blocks itself to 
>> wait for recovery finished event. If thread successfully hold read 
>> lock and in_gpu_reset is 0, it continues. It will exit normally or be 
>> stopped by recovery thread in step 1.
>> >
>> > Dennis Li (4):
>> >    drm/amdgpu: remove reset lock from low level functions
>> >    drm/amdgpu: refine the GPU recovery sequence
>> >    drm/amdgpu: instead of using down/up_read directly
>> >    drm/amdkfd: add reset lock protection for kfd entry functions
>> >
>> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 6 +
>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   | 14 +-
>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 173 
>> +++++++++++++-----
>> >   .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 8 -
>> >   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        | 4 +-
>> >   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 9 +-
>> >   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c         | 5 +-
>> >   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c         | 5 +-
>> >   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 172 ++++++++++++++++-
>> >   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         | 3 +-
>> >   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 4 +
>> >   .../amd/amdkfd/kfd_process_queue_manager.c    | 17 ++
>> >   12 files changed, 345 insertions(+), 75 deletions(-)
>> >
>>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--------------4B7ACB8AE37D0731AA0BDA4A
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Denis, Christian, are there any updates in the plan on how to
      move on with this ? As you know I need very similar code for my
      up-streaming of device hot-unplug. My latest solution
(<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/archives/amd-gfx/2021-January/058606.html">https://lists.freedesktop.org/archives/amd-gfx/2021-January/058606.html</a>)
      was not acceptable because of low level guards on the register
      accessors level which was hurting performance. Basically I need a
      way to prevent any MMIO write accesses from kernel driver after
      device is removed (UMD accesses are taken care of by page faulting
      dummy page). We are using now hot-unplug code for Freemont program
      and so up-streaming became more of a priority then before. This
      MMIO access issue is currently my main blocker from up-streaming.
      Is there any way I can assist in pushing this on ?</p>
    <p>Andrey&nbsp; <br>
    </p>
    <div class="moz-cite-prefix">On 2021-03-18 5:51 a.m., Christian
      König wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:378fdffb-99b5-2a14-736d-a06f310b040c@amd.com">
      
      Am 18.03.21 um 10:30 schrieb Li, Dennis:<br>
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
          <p class="MsoNormal">&gt;&gt;&gt; So waiting for a fence while
            holding the reset lock is illegal and needs to be avoided.<o:p></o:p></p>
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
      would run into memory corruption because the hardware jobs running
      after the GPU reset would access memory which is already freed.<br>
      <br>
      <blockquote type="cite" cite="mid:DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com">
        <div class="WordSection1">
          <p class="MsoNormal"><o:p></o:p></p>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <p class="MsoNormal">&gt;&gt;&gt; Lockdep also complains about
            this when it is used correctly. The only reason it doesn't
            complain here is because you use an atomic+wait_event
            instead of a locking primitive.<o:p></o:p></p>
          <p class="MsoNormal">Agree. This approach will escape the
            monitor of lockdep.&nbsp; Its goal is to block other threads when
            GPU recovery thread start. But I couldn’t find a better
            method to solve this problem. Do you have some suggestion? </p>
        </div>
      </blockquote>
      <br>
      Well, completely abandon those change here.<br>
      <br>
      What we need to do is to identify where hardware access happens
      and then insert taking the read side of the GPU reset lock so that
      we don't wait for a dma_fence or allocate memory, but still
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
                UI&quot;,sans-serif;color:black">Exactly that's what you
                don't seem to understand.<o:p></o:p></span></p>
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
                UI&quot;,sans-serif;color:black">So waiting for a fence
                while holding the reset lock is illegal and needs to be
                avoided.<o:p></o:p></span></p>
          </div>
          <div>
            <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                UI&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
          </div>
          <div>
            <p class="MsoNormal"><span style="font-size:12.0pt;font-family:&quot;Segoe
                UI&quot;,sans-serif;color:black">Lockdep also complains
                about this when it is used correctly. The only reason it
                doesn't complain here is because you use an
                atomic+wait_event instead of a locking primitive.<o:p></o:p></span></p>
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
              <p class="MsoNormal">&gt;&gt;&gt; Those two steps need to
                be exchanged or otherwise it is possible that new
                delayed work items etc are started before the lock is
                taken.<br>
                What about adding check for adev-&gt;in_gpu_reset in
                work item? If exchange the two steps, it maybe introduce
                the deadlock.&nbsp; For example, the user thread hold the
                read lock and waiting for the fence, if recovery thread
                try to hold write lock and then complete fences, in this
                case, recovery thread will always be blocked.<o:p></o:p></p>
            </div>
            <div>
              <p class="MsoNormal" style="margin-bottom:12.0pt"><br>
                Best Regards<br>
                Dennis Li<br>
                -----Original Message-----<br>
                From: Koenig, Christian &lt;<a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">Christian.Koenig@amd.com</a>&gt;
                <br>
                Sent: Thursday, March 18, 2021 3:54 PM<br>
                To: Li, Dennis &lt;<a href="mailto:Dennis.Li@amd.com" moz-do-not-send="true">Dennis.Li@amd.com</a>&gt;; <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true"> amd-gfx@lists.freedesktop.org</a>;
                Deucher, Alexander &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;;
                Kuehling, Felix &lt;<a href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">Felix.Kuehling@amd.com</a>&gt;;
                Zhang, Hawking &lt;<a href="mailto:Hawking.Zhang@amd.com" moz-do-not-send="true">Hawking.Zhang@amd.com</a>&gt;<br>
                Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to
                enhance its stability<br>
                <br>
                Am 18.03.21 um 08:23 schrieb Dennis Li:<br>
                &gt; We have defined two variables in_gpu_reset and
                reset_sem in adev object. The atomic type variable
                in_gpu_reset is used to avoid recovery thread reenter
                and make lower functions return more earlier when
                recovery start, but couldn't block recovery thread when
                it access hardware. The r/w semaphore reset_sem is used
                to solve these synchronization issues between recovery
                thread and other threads.<br>
                &gt;<br>
                &gt; The original solution locked registers' access in
                lower functions, which will introduce following issues:<br>
                &gt;<br>
                &gt; 1) many lower functions are used in both recovery
                thread and others. Firstly we must harvest these
                functions, it is easy to miss someones. Secondly these
                functions need select which lock (read lock or write
                lock) will be used, according to the thread it is
                running in. If the thread context isn't considered, the
                added lock will easily introduce deadlock. Besides that,
                in most time, developer easily forget to add locks for
                new functions.<br>
                &gt;<br>
                &gt; 2) performance drop. More lower functions are more
                frequently called.<br>
                &gt;<br>
                &gt; 3) easily introduce false positive lockdep
                complaint, because write lock has big range in recovery
                thread, but low level functions will hold read lock may
                be protected by other locks in other threads.<br>
                &gt;<br>
                &gt; Therefore the new solution will try to add lock
                protection for ioctls of kfd. Its goal is that there are
                no threads except for recovery thread or its children
                (for xgmi) to access hardware when doing GPU reset and
                resume. So refine recovery thread as the following:<br>
                &gt;<br>
                &gt; Step 0: atomic_cmpxchg(&amp;adev-&gt;in_gpu_reset,
                0, 1)<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp; 1). if failed, it means system had a recovery
                thread running, current thread exit directly;<br>
                &gt;&nbsp;&nbsp;&nbsp;&nbsp; 2). if success, enter recovery thread;<br>
                &gt;<br>
                &gt; Step 1: cancel all delay works, stop drm schedule,
                complete all unreceived fences and so on. It try to stop
                or pause other threads.<br>
                &gt;<br>
                &gt; Step 2: call down_write(&amp;adev-&gt;reset_sem) to
                hold write lock, which will block recovery thread until
                other threads release read locks.<br>
                <br>
                Those two steps need to be exchanged or otherwise it is
                possible that new delayed work items etc are started
                before the lock is taken.<br>
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
                &gt; Step 5: atomic set adev-&gt;in_gpu_reset as 0, wake
                up other threads and release write lock. Recovery thread
                exit normally.<br>
                &gt;<br>
                &gt; Other threads call the amdgpu_read_lock to
                synchronize with recovery thread. If it finds that
                in_gpu_reset is 1, it should release read lock if it has
                holden one, and then blocks itself to wait for recovery
                finished event. If thread successfully hold read lock
                and in_gpu_reset is 0, it continues. It will exit
                normally or be stopped by recovery thread in step 1.<br>
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
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;
                6 +<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c&nbsp;&nbsp; |&nbsp;
                14 +-<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&nbsp;&nbsp; |
                173 +++++++++++++-----<br>
                &gt;&nbsp;&nbsp; .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;
                8 -<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;
                4 +-<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;
                9 +-<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;
                5 +-<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;
                5 +-<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_chardev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
                172 ++++++++++++++++-<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;
                3 +-<br>
                &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;
                4 +<br>
                &gt;&nbsp;&nbsp; .../amd/amdkfd/kfd_process_queue_manager.c&nbsp;&nbsp;&nbsp; |&nbsp;
                17 ++<br>
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
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
  </body>
</html>

--------------4B7ACB8AE37D0731AA0BDA4A--

--===============0894081199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0894081199==--
