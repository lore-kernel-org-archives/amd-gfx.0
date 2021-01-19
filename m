Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30407C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 19:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E24C620776
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 19:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24C620776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D0366E06D;
	Tue, 19 Jan 2021 17:15:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C06006E06D
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jan 2021 17:15:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDnwJ5f8Rv+PAfI+BLN4lOfXpKy10XE1XmksFa49FSS3ugZ38f9+UbXftTlcAygr5iMoNvPNnA6xahfYNOPjnEH+3KLQL++Oncz5MQq7TMRviTeakev7tG8+bts3S8HjJcY2SFc3wVMu4VeHhJt6y0hrdluiIR6F/EC2ybyJqq0Z9K2Bb+XJRpWiC6Qjax86npgaBhHIHCMhjKQxSl3l8z1STBuwEcfjou3UvCFZhls19RW9I8zX1pKe36sxh6trHUofvvP62EEAGkh+jL745fxjm1zjvlz6JJOVpvrxlfeSS75iwslu/DsaHYCCbTuxOmH8dNA+gYJv6M+g/4oPIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLXB2S7Id7NGF4yJaMpp+rnIvB8KI2XaTWNu7mNuZcQ=;
 b=EVeqagogLqpqSWoPxguW6ozVkLmzcgX+reCGLAjMce7y7BFObD9SSEEy/lYr1du2EbbGcBVdVeadLFLpF6MyloomaGpn82XxpGU5GcCd+USYM6X9j3M2iDVm3caGz9NKLXluSd5ctQngLDKOsLjE9AWJncVkpqvI2lVHM9Pv/A9koqNItDIBECJ7mT0misgZVYAKbv7Yn03aD07XGALChnEqVEv3nZzTNLJ1EtBsPRxZwcesjjcre2gSNCOqmQTxOjYjPAj/DKpIQgzmItIna87A94rdOmpy1lsj5TGIu9b6MOjLMGG1xY6vUoKPP5nJZeS9/WVBDYBLogRSR9ilYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLXB2S7Id7NGF4yJaMpp+rnIvB8KI2XaTWNu7mNuZcQ=;
 b=ucjbWc7VzqYRUj2aKS4VjCvX7BnwwlPb1t5OhnDlvfsZF1iXf9+1+ptnu5IAzAPbD0nDsPjA2IIeyxJGKx7TPn/YgadyX+sMd38UIJSLSrYjGf9KSMpSlshqLqi9e+koz4FrYAWnKeSC8wS352ThEYEJKXGGJqSSrDznKUpD1x8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN1PR12MB2477.namprd12.prod.outlook.com (2603:10b6:802:28::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Tue, 19 Jan
 2021 17:15:30 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::5d30:b29d:5f5b:6921]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::5d30:b29d:5f5b:6921%5]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 17:15:30 +0000
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiBbUEFUQ0ggMS8yXSBkcm0vYW1kZ3B1?=
 =?UTF-8?Q?=3a_race_issue_when_jobs_on_2_ring_timeout?=
To: "Chen, Horace" <Horace.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210119122236.8039-1-horace.chen@amd.com>
 <3365c92c-9dbd-56df-4ba0-55793806cac7@amd.com>
 <CY4PR12MB157352A2F7BF029B68A4A769E1A30@CY4PR12MB1573.namprd12.prod.outlook.com>
 <bb133853-4291-1c6e-36ee-1eb05854c56a@amd.com>
 <CY4PR12MB1573CFBA40A3D36BF69C32FFE1A30@CY4PR12MB1573.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <ad87c326-9df3-db9e-0c83-3a417f09f5d4@amd.com>
Date: Tue, 19 Jan 2021 12:15:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CY4PR12MB1573CFBA40A3D36BF69C32FFE1A30@CY4PR12MB1573.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:c1b5:6dec:d289:5430]
X-ClientProxiedBy: YT1PR01CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::34) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:c1b5:6dec:d289:5430]
 (2607:fea8:3edf:49b0:c1b5:6dec:d289:5430) by
 YT1PR01CA0065.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9 via Frontend Transport; Tue, 19 Jan 2021 17:15:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d1c6c81a-550f-48c3-96b6-08d8bc9dd2cc
X-MS-TrafficTypeDiagnostic: SN1PR12MB2477:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2477722379424FB43286C2A1EAA30@SN1PR12MB2477.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kNR6MLxQ6KW0I2UHohw3SwCmJZVcHOWk0OswoiA5ts4JEQ72X7M/EbQvdLBPuyFPgqs+978d1jV2CmsTvV1fLo2vYqZ458DJotCBEbDG+dBZyulkeX6nflaKGlaINsFy+3WPaMFTmqG+bB0Z0KY8HnLptTHBWMwMXHCKVDJ7P8v6kt7vRy4C0D6V5ZYOMwB1OtaODx9ubxxBXDXDz9dEUmAf2LLNn5oD42b6LdPFkNrjjw7KXI/FTYxXfWyzitcLro8Gubge2P7xgMJefU3D4dd1JTU0UZyzdqPfmWrZkfY/0oloY29QD43/ftKoGB9hlLZSrp6e2x1Q2MPeZQNmXjvQI3Gxvt6gb0oPhREYrYoyiVtJIromjKWb/Yk68b1O0s/UONlu+PARXH1+KINHtl3KuV3c/6S+kgkeIh5NNNACoqJ77ZkKmGLOIA9qOkvMaPrhnQw268d9L16hUdJymIaG4KXmk2GmBiliXgDlpvE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(478600001)(53546011)(16526019)(2906002)(31686004)(6486002)(4326008)(5660300002)(186003)(66476007)(66556008)(66946007)(8936002)(19627405001)(30864003)(33964004)(2616005)(36756003)(86362001)(316002)(54906003)(31696002)(110136005)(52116002)(224303003)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Rm9NYnhYQ3pmaWxObDdNOEZLbzZXYXdETlJuRmczSDkvV2NpV0dUSG9sME4y?=
 =?utf-8?B?Q2VXWXd0N0pkSEdybHVpT0dtUVU0d1NsRnZEQmxScFV1WG9uVGp6WFM4cTRw?=
 =?utf-8?B?UDRRbGNWUzM1dUxQdGJmeWV1SXE2dFJXWXQ5aDJOREZMTnNYa2hxR2hCZTlX?=
 =?utf-8?B?ekFHSkNFQ3FIZXFrMVpFQjBtRlN5K1ZFVlhoc2N1MVFTdW9ITjJ2SFhXMTAy?=
 =?utf-8?B?ZWZsYUdWZjRNQTFINVdiZE8rODMvN3BWQ1ZqVm0xSHYweUFJem9hOVVDRHdX?=
 =?utf-8?B?S05nUEpaOWFYSW5GeG8vaUZjbDBJbmJzRGVqc1RsTktzRnZER2h2SDVsZHdV?=
 =?utf-8?B?cUFyekE2VmFrMFdDNWQ0WjVJWU56Y1FlOEdXTjBVc25Sa2p3SCtNYlYrRk5u?=
 =?utf-8?B?OWhQcVB2bVh4a25IWjhRMUFGY0xXUmdqTzVNaWpPQVhwYTBDTWZwaU5FTGN4?=
 =?utf-8?B?d1Z3U0J3c2tuWEZCU2lLRGhBdEhsbzB0NEdqZE5MZnVSQ1JFdUZLM1lnc29y?=
 =?utf-8?B?MDlrSXBVVllsL1ovdTRRZElhTXBNd0N2dnlpSXdmSmJiSVlKWi9wSVVUcHMv?=
 =?utf-8?B?bHdUZFgxdkNQaTVXNVNCL0E4L2dnMU91Sk9lVGs5R0cyQzBDS29jVmNjZmlm?=
 =?utf-8?B?NVYwN0VvZ3o3QVR3YklJVEZ4VEptMjRBSWdCeUJINzhhN3dWdmE4WVVDeWtz?=
 =?utf-8?B?ZlVPQzFmeEtkWmVUenZrV1BoTFVWQkZaZ2RvYlR6YTA0U1dITFNDOEE0Y3Zu?=
 =?utf-8?B?R3ZVcm5UMTBEMFJmdE1VZFFrTHo4azNLM1AyeUs0L2xJS3BaSTJ3TUV2cFM1?=
 =?utf-8?B?WDI3R0ZKNkVLZHdjTDdvME05ZTZ5d2NyQmxZell1MGoraUlsd3U1ZjFHR0Ez?=
 =?utf-8?B?czNRY2lXajlEREhtZDluY2FrdnNhRjBZMjBLS3lJa0Juc2cvM1VOUFRrZkJh?=
 =?utf-8?B?VHNKcWh2N1JGREFPejg1SDZaQjJHMjNkY3F1MW5yaEJ6RW9FWldmSHhxNFpM?=
 =?utf-8?B?bGtlNmRQN2l3Rm01aFUwVi9JOTJJamRtRm1leGRleW1XUjJtalQvMGh4WnE5?=
 =?utf-8?B?SDZxOTlDZ3dCZU5XdEhwUy9GT0FVZHd3SnFGRitvd3hDbUpwL2xJS2cybE83?=
 =?utf-8?B?bjlnaDBQbnhYTk5TY3lBNUo4L0xTNnFyL2htUWs4WFlKd3RUL3BGRjVwQm5W?=
 =?utf-8?B?U09BblVFYVl2SjdOSXV6TmhCU3Z4MXlxK2M0aStIUlZVU2J2V2s1YUZ4WWlz?=
 =?utf-8?B?YTYvZmVWWDV4ejBJUHcweDlpWXQ1czg3aWNTY2ZpQUpJS2ppTlJEZitjWXpa?=
 =?utf-8?B?OHhLTlJVSXJxTGNsRWo3TkUyblM1cjNFN24ycUMxMGx5RlhKRExCZmZXQnVi?=
 =?utf-8?B?OTBXcUIzZGRreGwvemxCaDhCT3Y5RDllWnlRazdLVVcxVkhrZS9VQ2FtQXN4?=
 =?utf-8?B?MFVXOEZuODQ2NS9Vci8yRHczeUxuNXFIUkNFalhBeStkYkQ4cU9vUHhYeWRn?=
 =?utf-8?B?YTFmcFR1THIxY0syNUJTUFZEWFFVdUMzRXBwV0h0RllIMTdpUk9YUjRBejFS?=
 =?utf-8?B?OU00dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c6c81a-550f-48c3-96b6-08d8bc9dd2cc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 17:15:30.7934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CqNnu5HWxiuheZ/u5tV91s2Vkhn9XLnpj/5PjutgQ4STg/fzOueIGCRHa7JQacUirVeK66DNADy2wWbKsX/EXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2477
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Liu, Monk" <Monk.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1849623932=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1849623932==
Content-Type: multipart/alternative;
 boundary="------------C0EF956F45EA1E692A5F51D7"
Content-Language: en-US

--------------C0EF956F45EA1E692A5F51D7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Well, it shouldn't happen with the hive locked as I am browsing the code but 
then your code should
reflect that and if you do fail to lock particular adev AFTER the hive is locked 
you should not silently break
iteration but throw an error, WARN_ON or BUG_ON then. Or alternatively bail out 
with unlocking all already
locked devices.


Andrey


On 1/19/21 12:09 PM, Chen, Horace wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> OK, I understand. You mean one device in the hive may be locked up 
> independently without locking up the whole hive.
>
> It could happen, I'll change my code.
>
> Thanks & Regards,
> Horace.
>
> --------------------------------------------------------------------------------
> *发件人:* Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> *发送时间:* 2021年1月20日 0:58
> *收件人:* Chen, Horace <Horace.Chen@amd.com>; amd-gfx@lists.freedesktop.org 
> <amd-gfx@lists.freedesktop.org>
> *抄送:* Quan, Evan <Evan.Quan@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; 
> Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking 
> <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei 
> <Feifei.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Xiaojie Yuan 
> <xiaojie.yuan@amd.com>
> *主题:* Re: 回复: [PATCH 1/2] drm/amdgpu: race issue when jobs on 2 ring timeout
>
>
> On 1/19/21 11:39 AM, Chen, Horace wrote:
>>
>> [AMD Official Use Only - Internal Distribution Only]
>>
>>
>> Hi Andrey,
>>
>> I think the list in the XGMI hive won't be break in the middle if we lock the 
>> device before we change the list. Because if 2 devices in 1 hive went into 
>> the function, it will follow the same sequence to lock the devices. So one of 
>> them will definately break at the first device. I add iterate devices here is 
>> just to lock all device in the hive since we will change the device sequence 
>> in the hive soon after.
>
>
> I didn't mean break in a sense of breaking the list itself, I just meant the 
> literal 'break' instruction
> to terminate the iteration once you failed to lock a particular device.
>
>
>>
>> The reason to break the interation in the middle is that the list is changed 
>> during the iteration without taking any lock. It is quite bad since I'm 
>> fixing one of this issue. And for XGMI hive, there are 2 locks protecting the 
>> list, one is the device lock I changed here, the other one is in front of my 
>> change, there is a hive->lock to protect the hive.
>>
>> Even the bad thing really happened, I think moving back through the list is 
>> also very dengerous since we don't know what the list finally be, Unless we 
>> stack the devices we have iterated through a mirrored list. That can be a big 
>> change.
>
>
> Not sure we are on the same page, my concern is let's sat your XGMI hive 
> consists of 2 devices, you manged to call successfully do
> amdgpu_device_lock_adev for dev1 but then failed for dev2, in this case you 
> will bail out without releasing dev1, no ?
>
>
> Andrey
>
>
>>
>>
>> I'm ok to seperate the locking in amdgpu_device_lock_adev here, I'll do some 
>> test and update the code later.
>>
>> Thanks & Regards,
>> Horace.
>> --------------------------------------------------------------------------------
>> *发件人:* Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com> 
>> <mailto:Andrey.Grodzovsky@amd.com>
>> *发送时间:* 2021年1月19日 22:33
>> *收件人:* Chen, Horace <Horace.Chen@amd.com> <mailto:Horace.Chen@amd.com>; 
>> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org> 
>> <amd-gfx@lists.freedesktop.org> <mailto:amd-gfx@lists.freedesktop.org>
>> *抄送:* Quan, Evan <Evan.Quan@amd.com> <mailto:Evan.Quan@amd.com>; Tuikov, 
>> Luben <Luben.Tuikov@amd.com> <mailto:Luben.Tuikov@amd.com>; Koenig, Christian 
>> <Christian.Koenig@amd.com> <mailto:Christian.Koenig@amd.com>; Deucher, 
>> Alexander <Alexander.Deucher@amd.com> <mailto:Alexander.Deucher@amd.com>; 
>> Xiao, Jack <Jack.Xiao@amd.com> <mailto:Jack.Xiao@amd.com>; Zhang, Hawking 
>> <Hawking.Zhang@amd.com> <mailto:Hawking.Zhang@amd.com>; Liu, Monk 
>> <Monk.Liu@amd.com> <mailto:Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com> 
>> <mailto:Feifei.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com> 
>> <mailto:Kevin1.Wang@amd.com>; Xiaojie Yuan <xiaojie.yuan@amd.com> 
>> <mailto:xiaojie.yuan@amd.com>
>> *主题:* Re: [PATCH 1/2] drm/amdgpu: race issue when jobs on 2 ring timeout
>>
>> On 1/19/21 7:22 AM, Horace Chen wrote:
>> > Fix a racing issue when jobs on 2 rings timeout simultaneously.
>> >
>> > If 2 rings timed out at the same time, the amdgpu_device_gpu_recover
>> > will be reentered. Then the adev->gmc.xgmi.head will be grabbed
>> > by 2 local linked list, which may cause wild pointer issue in
>> > iterating.
>> >
>> > lock the device earily to prevent the node be added to 2 different
>> > lists.
>> >
>> > Signed-off-by: Horace Chen <horace.chen@amd.com> <mailto:horace.chen@amd.com>
>> > ---
>> > drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 42 +++++++++++++++-------
>> >   1 file changed, 30 insertions(+), 12 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> > index 4d434803fb49..9574da3abc32 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> > @@ -4540,6 +4540,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>> >        int i, r = 0;
>> >        bool need_emergency_restart = false;
>> >        bool audio_suspended = false;
>> > +     bool get_dev_lock = false;
>> >
>> >        /*
>> >         * Special case: RAS triggered and full reset isn't supported
>> > @@ -4582,28 +4583,45 @@ int amdgpu_device_gpu_recover(struct amdgpu_device 
>> *adev,
>> >         * Build list of devices to reset.
>> >         * In case we are in XGMI hive mode, resort the device list
>> >         * to put adev in the 1st position.
>> > +      *
>> > +      * lock the device before we try to operate the linked list
>> > +      * if didn't get the device lock, don't touch the linked list since
>> > +      * others may iterating it.
>> >         */
>> >        INIT_LIST_HEAD(&device_list);
>> >        if (adev->gmc.xgmi.num_physical_nodes > 1) {
>> >                if (!hive)
>> >                        return -ENODEV;
>> > -             if (!list_is_first(&adev->gmc.xgmi.head, &hive->device_list))
>> > - list_rotate_to_front(&adev->gmc.xgmi.head, &hive->device_list);
>> > -             device_list_handle = &hive->device_list;
>> > +
>> > + list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
>> > +                     get_dev_lock = amdgpu_device_lock_adev(tmp_adev, hive);
>> > +                     if (!get_dev_lock)
>> > +                             break;
>>
>>
>> What about unlocking back all the devices you already locked if the break
>> happens in the middle of the iteration ?
>> Note that at skip_recovery: we don't do it. BTW, i see this issue is already in
>> the current code.
>>
>> Also, maybe now it's better to separate the actual locking in
>> amdgpu_device_lock_adev
>> from the other stuff going on there since I don't think you would wont to toggle
>> stuff
>> like adev->mp1_state back and forth and also the function name is not
>> descriptive of
>> the other stuff going on there anyway.
>>
>> Andrey
>>
>>
>> > +             }
>> > +             if (get_dev_lock) {
>> > +                     if (!list_is_first(&adev->gmc.xgmi.head, 
>> &hive->device_list))
>> > + list_rotate_to_front(&adev->gmc.xgmi.head, &hive->device_list);
>> > +                     device_list_handle = &hive->device_list;
>> > +             }
>> >        } else {
>> > - list_add_tail(&adev->gmc.xgmi.head, &device_list);
>> > -             device_list_handle = &device_list;
>> > +             get_dev_lock = amdgpu_device_lock_adev(adev, hive);
>> > +             tmp_adev = adev;
>> > +             if (get_dev_lock) {
>> > + list_add_tail(&adev->gmc.xgmi.head, &device_list);
>> > +                     device_list_handle = &device_list;
>> > +             }
>> > +     }
>> > +
>> > +     if (!get_dev_lock) {
>> > +             dev_info(tmp_adev->dev, "Bailing on TDR for s_job:%llx, as 
>> another already in progress",
>> > +                                     job ? job->base.id : -1);
>> > +             r = 0;
>> > +             /* even we skipped this reset, still need to set the job to 
>> guilty */
>> > +             goto skip_recovery;
>> >        }
>> >
>> >        /* block all schedulers and reset given job's ring */
>> >        list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
>> > -             if (!amdgpu_device_lock_adev(tmp_adev, hive)) {
>> > - dev_info(tmp_adev->dev, "Bailing on TDR for s_job:%llx, as another 
>> already in progress",
>> > -                               job ? job->base.id : -1);
>> > -                     r = 0;
>> > -                     goto skip_recovery;
>> > -             }
>> > -
>> >                /*
>> >                 * Try to put the audio codec into suspend state
>> >                 * before gpu reset started.

--------------C0EF956F45EA1E692A5F51D7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Well, it shouldn't happen with the hive locked as I am browsing
      the code but then your code should<br>
      reflect that and if you do fail to lock particular adev AFTER the
      hive is locked you should not silently break<br>
      iteration but throw an error, WARN_ON or BUG_ON then. Or
      alternatively bail out with unlocking all already<br>
      locked devices.<br>
    </p>
    <p><br>
    </p>
    <p>Andrey<br>
    </p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 1/19/21 12:09 PM, Chen, Horace
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CY4PR12MB1573CFBA40A3D36BF69C32FFE1A30@CY4PR12MB1573.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
      <p style="font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" align="Left">
        [AMD Official Use Only - Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          OK, I understand. You mean one device in the hive may be
          locked up independently without locking up the whole hive.</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          It could happen, I'll change my code.</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Thanks &amp; Regards,</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Horace.<br>
        </div>
        <div>
          <div id="appendonsend"><br>
          </div>
          <hr tabindex="-1" style="display:inline-block; width:98%">
          <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>发件人:</b>
              Grodzovsky, Andrey <a class="moz-txt-link-rfc2396E" href="mailto:Andrey.Grodzovsky@amd.com">&lt;Andrey.Grodzovsky@amd.com&gt;</a><br>
              <b>发送时间:</b> 2021年1月20日 0:58<br>
              <b>收件人:</b> Chen, Horace <a class="moz-txt-link-rfc2396E" href="mailto:Horace.Chen@amd.com">&lt;Horace.Chen@amd.com&gt;</a>;
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
              <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
              <b>抄送:</b> Quan, Evan <a class="moz-txt-link-rfc2396E" href="mailto:Evan.Quan@amd.com">&lt;Evan.Quan@amd.com&gt;</a>; Tuikov,
              Luben <a class="moz-txt-link-rfc2396E" href="mailto:Luben.Tuikov@amd.com">&lt;Luben.Tuikov@amd.com&gt;</a>; Koenig, Christian
              <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Deucher, Alexander
              <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Xiao, Jack
              <a class="moz-txt-link-rfc2396E" href="mailto:Jack.Xiao@amd.com">&lt;Jack.Xiao@amd.com&gt;</a>; Zhang, Hawking
              <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a>; Liu, Monk
              <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu@amd.com">&lt;Monk.Liu@amd.com&gt;</a>; Xu, Feifei
              <a class="moz-txt-link-rfc2396E" href="mailto:Feifei.Xu@amd.com">&lt;Feifei.Xu@amd.com&gt;</a>; Wang, Kevin(Yang)
              <a class="moz-txt-link-rfc2396E" href="mailto:Kevin1.Wang@amd.com">&lt;Kevin1.Wang@amd.com&gt;</a>; Xiaojie Yuan
              <a class="moz-txt-link-rfc2396E" href="mailto:xiaojie.yuan@amd.com">&lt;xiaojie.yuan@amd.com&gt;</a><br>
              <b>主题:</b> Re: 回复: [PATCH 1/2] drm/amdgpu: race issue when
              jobs on 2 ring timeout</font>
            <div>&nbsp;</div>
          </div>
          <div>
            <p style="margin-top: 0px; margin-bottom: 0px;"><br>
            </p>
            <div class="x_moz-cite-prefix">On 1/19/21 11:39 AM, Chen,
              Horace wrote:<br>
            </div>
            <blockquote type="cite">
              <p style="margin-top: 0px; margin-bottom:
                0px;font-family:Arial; font-size:11pt; color:#0078D7;
                margin:5pt" align="Left">
                [AMD Official Use Only - Internal Distribution Only]<br>
              </p>
              <br>
              <div>
                <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
                  font-size:12pt; color:rgb(0,0,0)">
                  Hi Andrey,</div>
                <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
                  font-size:12pt; color:rgb(0,0,0)">
                  <br>
                </div>
                <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
                  font-size:12pt; color:rgb(0,0,0)">
                  I think the list in the XGMI hive won't be break in
                  the middle if we lock the device before we change the
                  list. Because if 2 devices in 1 hive went into the
                  function, it will follow the same sequence to lock the
                  devices. So one of them will definately break at the
                  first device. I add iterate devices here is just to
                  lock all device in the hive since we will change the
                  device sequence in the hive soon after.</div>
              </div>
            </blockquote>
            <p style="margin-top: 0px; margin-bottom: 0px;"><br>
            </p>
            <p style="margin-top: 0px; margin-bottom: 0px;">I didn't
              mean break in a sense of breaking the list itself, I just
              meant the literal 'break' instruction<br>
              to terminate the iteration once you failed to lock a
              particular device. <br>
            </p>
            <p style="margin-top: 0px; margin-bottom: 0px;"><br>
            </p>
            <blockquote type="cite">
              <div>
                <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
                  font-size:12pt; color:rgb(0,0,0)">
                  <br>
                </div>
                <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
                  font-size:12pt; color:rgb(0,0,0)">
                  The reason to break the interation in the middle is
                  that the list is changed during the iteration without
                  taking any lock. It is quite bad since I'm fixing one
                  of this issue. And for XGMI hive, there are 2 locks
                  protecting the list, one is the device lock I changed
                  here, the other one is in front of my change, there is
                  a hive-&gt;lock to protect the hive.</div>
                <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
                  font-size:12pt; color:rgb(0,0,0)">
                  <br>
                </div>
                <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
                  font-size:12pt; color:rgb(0,0,0)">
                  Even the bad thing really happened, I think moving
                  back through the list is also very dengerous since we
                  don't know what the list finally be, Unless we stack
                  the devices we have iterated through a mirrored list.
                  That can be a big change.<br>
                </div>
              </div>
            </blockquote>
            <p style="margin-top: 0px; margin-bottom: 0px;"><br>
            </p>
            <p style="margin-top: 0px; margin-bottom: 0px;">Not sure we
              are on the same page, my concern is let's sat your XGMI
              hive consists of 2 devices, you manged to call
              successfully do<font size="2"><span style="font-size:11pt"><br>
                  amdgpu_device_lock_adev for dev1 but then failed for
                  dev2, in this case you will bail out&nbsp;</span></font>
              without releasing dev1, no ?</p>
            <p style="margin-top: 0px; margin-bottom: 0px;"><br>
            </p>
            <p style="margin-top: 0px; margin-bottom: 0px;">Andrey<br>
            </p>
            <p style="margin-top: 0px; margin-bottom: 0px;"><br>
            </p>
            <blockquote type="cite">
              <div>
                <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
                  font-size:12pt; color:rgb(0,0,0)">
                </div>
                <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
                  font-size:12pt; color:rgb(0,0,0)">
                  <br>
                </div>
                <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
                  font-size:12pt; color:rgb(0,0,0)">
                  <br>
                </div>
                <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
                  font-size:12pt; color:rgb(0,0,0)">
                  I'm ok to seperate the locking in <font size="2"><span style="font-size:11pt">amdgpu_device_lock_adev
                      here, I'll do some test and update the code later.<br>
                    </span></font></div>
                <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
                  font-size:12pt; color:rgb(0,0,0)">
                  <font size="2"><span style="font-size:11pt"><br>
                    </span></font></div>
                <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
                  font-size:12pt; color:rgb(0,0,0)">
                  <font size="2"><span style="font-size:11pt">Thanks
                      &amp; Regards,</span></font></div>
                <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
                  font-size:12pt; color:rgb(0,0,0)">
                  <font size="2"><span style="font-size:11pt">Horace.</span></font><br>
                </div>
                <div>
                  <hr tabindex="-1" style="display:inline-block;
                    width:98%">
                  <div id="x_divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>发件人:</b> Grodzovsky, Andrey
                      <a class="x_moz-txt-link-rfc2396E" href="mailto:Andrey.Grodzovsky@amd.com" moz-do-not-send="true">&lt;Andrey.Grodzovsky@amd.com&gt;</a><br>
                      <b>发送时间:</b> 2021年1月19日 22:33<br>
                      <b>收件人:</b> Chen, Horace <a class="x_moz-txt-link-rfc2396E" href="mailto:Horace.Chen@amd.com" moz-do-not-send="true">
                        &lt;Horace.Chen@amd.com&gt;</a>; <a class="x_moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                        amd-gfx@lists.freedesktop.org</a> <a class="x_moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                        &lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
                      <b>抄送:</b> Quan, Evan <a class="x_moz-txt-link-rfc2396E" href="mailto:Evan.Quan@amd.com" moz-do-not-send="true">
                        &lt;Evan.Quan@amd.com&gt;</a>; Tuikov, Luben <a class="x_moz-txt-link-rfc2396E" href="mailto:Luben.Tuikov@amd.com" moz-do-not-send="true">
                        &lt;Luben.Tuikov@amd.com&gt;</a>; Koenig,
                      Christian <a class="x_moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">
                        &lt;Christian.Koenig@amd.com&gt;</a>; Deucher,
                      Alexander <a class="x_moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">
                        &lt;Alexander.Deucher@amd.com&gt;</a>; Xiao,
                      Jack <a class="x_moz-txt-link-rfc2396E" href="mailto:Jack.Xiao@amd.com" moz-do-not-send="true">
                        &lt;Jack.Xiao@amd.com&gt;</a>; Zhang, Hawking <a class="x_moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com" moz-do-not-send="true">
                        &lt;Hawking.Zhang@amd.com&gt;</a>; Liu, Monk <a class="x_moz-txt-link-rfc2396E" href="mailto:Monk.Liu@amd.com" moz-do-not-send="true">
                        &lt;Monk.Liu@amd.com&gt;</a>; Xu, Feifei <a class="x_moz-txt-link-rfc2396E" href="mailto:Feifei.Xu@amd.com" moz-do-not-send="true">
                        &lt;Feifei.Xu@amd.com&gt;</a>; Wang, Kevin(Yang)
                      <a class="x_moz-txt-link-rfc2396E" href="mailto:Kevin1.Wang@amd.com" moz-do-not-send="true">
                        &lt;Kevin1.Wang@amd.com&gt;</a>; Xiaojie Yuan <a class="x_moz-txt-link-rfc2396E" href="mailto:xiaojie.yuan@amd.com" moz-do-not-send="true">
                        &lt;xiaojie.yuan@amd.com&gt;</a><br>
                      <b>主题:</b> Re: [PATCH 1/2] drm/amdgpu: race issue
                      when jobs on 2 ring timeout</font>
                    <div>&nbsp;</div>
                  </div>
                  <div class="x_BodyFragment"><font size="2"><span style="font-size:11pt">
                        <div class="x_PlainText"><br>
                          On 1/19/21 7:22 AM, Horace Chen wrote:<br>
                          &gt; Fix a racing issue when jobs on 2 rings
                          timeout simultaneously.<br>
                          &gt;<br>
                          &gt; If 2 rings timed out at the same time,
                          the amdgpu_device_gpu_recover<br>
                          &gt; will be reentered. Then the
                          adev-&gt;gmc.xgmi.head will be grabbed<br>
                          &gt; by 2 local linked list, which may cause
                          wild pointer issue in<br>
                          &gt; iterating.<br>
                          &gt;<br>
                          &gt; lock the device earily to prevent the
                          node be added to 2 different<br>
                          &gt; lists.<br>
                          &gt;<br>
                          &gt; Signed-off-by: Horace Chen <a class="x_moz-txt-link-rfc2396E" href="mailto:horace.chen@amd.com" moz-do-not-send="true">
                            &lt;horace.chen@amd.com&gt;</a><br>
                          &gt; ---<br>
                          &gt;&nbsp;&nbsp;
                          drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |
                          42 +++++++++++++++-------<br>
                          &gt;&nbsp;&nbsp; 1 file changed, 30 insertions(+), 12
                          deletions(-)<br>
                          &gt;<br>
                          &gt; diff --git
                          a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                          b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                          &gt; index 4d434803fb49..9574da3abc32 100644<br>
                          &gt; ---
                          a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                          &gt; +++
                          b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                          &gt; @@ -4540,6 +4540,7 @@ int
                          amdgpu_device_gpu_recover(struct amdgpu_device
                          *adev,<br>
                          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r = 0;<br>
                          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool need_emergency_restart =
                          false;<br>
                          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool audio_suspended = false;<br>
                          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; bool get_dev_lock = false;<br>
                          &gt;&nbsp;&nbsp; <br>
                          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
                          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Special case: RAS triggered and
                          full reset isn't supported<br>
                          &gt; @@ -4582,28 +4583,45 @@ int
                          amdgpu_device_gpu_recover(struct amdgpu_device
                          *adev,<br>
                          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Build list of devices to reset.<br>
                          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * In case we are in XGMI hive
                          mode, resort the device list<br>
                          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to put adev in the 1st
                          position.<br>
                          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
                          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * lock the device before we try to
                          operate the linked list<br>
                          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * if didn't get the device lock,
                          don't touch the linked list since<br>
                          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * others may iterating it.<br>
                          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
                          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;device_list);<br>
                          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                          (adev-&gt;gmc.xgmi.num_physical_nodes &gt; 1)
                          {<br>
                          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hive)<br>
                          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;<br>
                          &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                          (!list_is_first(&amp;adev-&gt;gmc.xgmi.head,
                          &amp;hive-&gt;device_list))<br>
                          &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          list_rotate_to_front(&amp;adev-&gt;gmc.xgmi.head,
                          &amp;hive-&gt;device_list);<br>
                          &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_list_handle =
                          &amp;hive-&gt;device_list;<br>
                          &gt; +<br>
                          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          list_for_each_entry(tmp_adev,
                          &amp;hive-&gt;device_list, gmc.xgmi.head) {<br>
                          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_dev_lock =
                          amdgpu_device_lock_adev(tmp_adev, hive);<br>
                          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!get_dev_lock)<br>
                          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
                          <br>
                          <br>
                          What about unlocking back all the devices you
                          already locked if the break<br>
                          happens in the middle of the iteration ?<br>
                          Note that at skip_recovery: we don't do it.
                          BTW, i see this issue is already in <br>
                          the current code.<br>
                          <br>
                          Also, maybe now it's better to separate the
                          actual locking in <br>
                          amdgpu_device_lock_adev<br>
                          from the other stuff going on there since I
                          don't think you would wont to toggle <br>
                          stuff<br>
                          like adev-&gt;mp1_state back and forth and
                          also the function name is not <br>
                          descriptive of<br>
                          the other stuff going on there anyway.<br>
                          <br>
                          Andrey<br>
                          <br>
                          <br>
                          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (get_dev_lock) {<br>
                          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                          (!list_is_first(&amp;adev-&gt;gmc.xgmi.head,
                          &amp;hive-&gt;device_list))<br>
                          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          list_rotate_to_front(&amp;adev-&gt;gmc.xgmi.head,
                          &amp;hive-&gt;device_list);<br>
                          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_list_handle
                          = &amp;hive-&gt;device_list;<br>
                          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
                          &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          list_add_tail(&amp;adev-&gt;gmc.xgmi.head,
                          &amp;device_list);<br>
                          &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_list_handle =
                          &amp;device_list;<br>
                          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_dev_lock =
                          amdgpu_device_lock_adev(adev, hive);<br>
                          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev = adev;<br>
                          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (get_dev_lock) {<br>
                          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          list_add_tail(&amp;adev-&gt;gmc.xgmi.head,
                          &amp;device_list);<br>
                          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_list_handle
                          = &amp;device_list;<br>
                          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                          &gt; +<br>
                          &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!get_dev_lock) {<br>
                          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(tmp_adev-&gt;dev,
                          &quot;Bailing on TDR for s_job:%llx, as another
                          already in progress&quot;,<br>
                          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job
                          ? job-&gt;base.id : -1);<br>
                          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = 0;<br>
                          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* even we skipped this
                          reset, still need to set the job to guilty */<br>
                          &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto skip_recovery;<br>
                          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                          &gt;&nbsp;&nbsp; <br>
                          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* block all schedulers and reset
                          given job's ring */<br>
                          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_adev,
                          device_list_handle, gmc.xgmi.head) {<br>
                          &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                          (!amdgpu_device_lock_adev(tmp_adev, hive)) {<br>
                          &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          dev_info(tmp_adev-&gt;dev, &quot;Bailing on TDR for
                          s_job:%llx, as another already in progress&quot;,<br>
                          &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job ?
                          job-&gt;base.id : -1);<br>
                          &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = 0;<br>
                          &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto skip_recovery;<br>
                          &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                          &gt; -<br>
                          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
                          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Try to put the audio
                          codec into suspend state<br>
                          &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * before gpu reset
                          started.<br>
                        </div>
                      </span></font></div>
                </div>
              </div>
            </blockquote>
          </div>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------C0EF956F45EA1E692A5F51D7--

--===============1849623932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1849623932==--
