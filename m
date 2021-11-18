Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DF8C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 14:15:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A86AC61181
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 14:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A86AC61181
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F69C6E90D;
	Thu, 18 Nov 2021 14:15:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4040C6E90D
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 14:15:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3BXFd5vo+Cl1/GvFcXA8zDCvvYoVmH7lYYKv92AGnI6/Cei2Wnhjh1IVCyPWhu3moSsa3/LdtkYMulQLLI7J8EG2X1q/lsu3MWs4ue1rCNhyKkkKg+78V2brtsjmS46cXd17Gkk5NDxBWz9gulpJz+klCpDnYVeycgPFPSjpvhk+erA4o/7LyQ9bgJP41iRa+6L0CRXOQxUQCoAjbythBpgfwpDBr+htDLcXdQgUnhz6By20O8fse11YVdm+AVHVsM8BUfcLXYnKWojy+56kck2GdJwzpOdF0rSiVKeHYF0E2oPOQ8BBr9DBVQuYx3riC9F32DyW9oAaKS9qUAKlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAHMwg01R+vpPbc6tVkJsrz/3Bomes9RFM/85wwRSOg=;
 b=P/Dj8qz/GdUQmQX59kEOy97GxIMRtua4d2h/zzAuB+7BFB7E9mt3pBakA+B+YaQ/n0/BGQfE7p6DJg5lqU4ieaYiDATPO3d57Y/v7t+Tcm5tRq1qUqD4b0eSWqFC4Ioipr/v0Ys9+08nZxIzZXgLT8NMqKeHap/Krgw8Qj0Y4fTDvyZ4YRbI/Vj1lSFmFlZ+vhzDigwdlEDO9vZK/Odqal5tSA7nWNjVVcYvtS3bNe4xexWnlthaY4l5trx89UuD7f6irMUTkk+cdJZVhYaSxwduop9YMLQrSxKqZVv6Fj9cPiuDTJawdKmPyHcjT3ZOMEzipCbvEhpWklGAsFZlPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAHMwg01R+vpPbc6tVkJsrz/3Bomes9RFM/85wwRSOg=;
 b=l/VqlB2+1ne3Nch3JwDkQ8KwflpqWvs3Z4Mxvun0+7/MKMBoN9NVrb7M60+ptMxsa6JCEh+NyaenN1/RjImm8WMY2VdAkLkylXmp7b5t2DwamwRt87M3pql8BAZEjSzqZD+P7EiEkF7eXvRWV31PMm1QzXoznohqH21t8GqQ+qI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB1244.namprd12.prod.outlook.com (2603:10b6:3:73::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Thu, 18 Nov
 2021 14:14:57 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 14:14:57 +0000
Message-ID: <b42e6ba2-a849-f8c3-d013-6c4d64ec3ac4@amd.com>
Date: Thu, 18 Nov 2021 19:44:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amdgpu: reset asic after system-wide suspend aborted
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>, "Liang, Prike" <Prike.Liang@amd.com>
References: <1637218976-30718-1-git-send-email-Prike.Liang@amd.com>
 <aaf39737-31da-4925-1aac-56478ad5296f@amd.com>
 <MN2PR12MB324647AA070CF7883BF70036FB9B9@MN2PR12MB3246.namprd12.prod.outlook.com>
 <CADnq5_M_FpTJ=PNdLy9k7EELK_Q+hbeuQdvZi0aURPiSD9Zn_g@mail.gmail.com>
 <97141867-cf4c-eebc-425e-ab2418c9e87d@amd.com>
 <ef7d1842-df51-88b2-75fe-146140681321@gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <ef7d1842-df51-88b2-75fe-146140681321@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::24) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BMXPR01CA0084.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:54::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.10 via Frontend Transport; Thu, 18 Nov 2021 14:14:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dfede30-cef5-4469-52fb-08d9aa9dccbd
X-MS-TrafficTypeDiagnostic: DM5PR12MB1244:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1244EF075D66B6A9F95AD5B9979B9@DM5PR12MB1244.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmz8WWn1JrgQMEofie4J+zNNx1p1Q0yUJKjxfgQ4nfY7TFUudhQ4A87qpwtIl1tC1jH3ObU2FXk2QLh8kLoTXh5ZYy/0eVIWwYbJQTAG+71znsqqv4KkHbMMTlODRzo7Xjc83FzPUKXrsNGo1Iv9KT6mq6qG2qVLnN5oLFj3ED2xHtCJb9G9CHMYiqAU+oan6kkbGawsczTgIKNQxwR59L9h2qXX3D+cNcioT9TS4Haj1afoJuAYOW1dbcqyfbROxeTCiL8UFh8pgSFSZgmjZ1I6IWbuu57+4z2Eoa7rwgQSj6Toz89wxfYFFCuwFmWXe2Rd1L8WtbTXdyxvyo13/gFn4CRexocBrU44V3SOZewgpIJvKihBJAUVtPBf4KMZk0zbCcsfOderHRWJ5Ci+s952vjGSzR0WnfBhjhmgb0iCMo/6y2B30ziN5/fjIqjk0UPtyGpb2/2Hqnh8JUgVyxPuqEhY9Ht38xXwgIw+tPXXKlQkxeZ75diyHbLVddi4XuUMklBNe9CF1+Vc0Pih7lmAEqRj+x8ZDHt0QMV0hIsAodRogCzP+sC+c9NT6lSPTtGn20PYnJoENboHydF9710RTlycsq0bMOHvjvD6PZHaYYTkrE3XFETIPyx+W6KUUAX04aJGDj6pg2oodp+JasORuoB3F9tEp9RO6GOjCEflyt68MF3/ywE4eQYGuMIzV1CYmtSjcuJ5A/XonkAKxnEKwzPY4Qd+KtpS1pp1Rzn1gzOOvWXMjQwBfHC6oqAVionwspPSLtfC6a6I3TJ4sMR7WY+9QBXT26nYMfv4pAvEq34nXMpqHNs5EHt8PmgD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(66476007)(8936002)(66556008)(110136005)(36756003)(2906002)(31686004)(15650500001)(5660300002)(956004)(26005)(8676002)(86362001)(6636002)(38100700002)(53546011)(4326008)(66946007)(83380400001)(31696002)(54906003)(45080400002)(316002)(66574015)(186003)(16576012)(966005)(508600001)(2616005)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFhUQnQyZVZrMWZuS2pTVnQrMXFybUtlam1zQXJ4QmlzV0NjRUVFdEQ3RFhK?=
 =?utf-8?B?TnNZL2docnl0UVArZEpWU1YyYWxOK09HbHpXeG5SL2lzNFBmM1piNTB3d0pj?=
 =?utf-8?B?YW5HVDhjdEFVV2tjWFZhdGNsZHN4ZjZrM3FoZFVRdzZpNDBxcDNhRndMQ2dQ?=
 =?utf-8?B?cFEySkhHNW5CdGFSTFpvZis4TGpnQys3ckIya09zamxxZ2dNSVoyeDNEUkI4?=
 =?utf-8?B?QUhLNmc3M2FhcVhaNXZiUVhkdU5KeGt4d2FBRlFzRmVSYkVpVWJhd1FjL1FF?=
 =?utf-8?B?ekN0M1hGdE5tMnhTS3pFQU5mc1lrSEpqZEp2RUJOVGhFWmg1NmRoT0FoOWcw?=
 =?utf-8?B?eDJnNVBvTnJBTEx2emZyZkpkcS9UT0k2d24rSWhmZWQzMFEzSTVtRmNrTmlk?=
 =?utf-8?B?ZTJ1Ui9UOFJIQlMwV0Jtdm9uU0hYa3NyeThrb1BXOC9kU1dqcEdka1luaEtv?=
 =?utf-8?B?WHJ4WjRqQ3Fld2N4VUc5cE10UklTRTkrUndnS1dONlhnV0RIcDVWR0NIRmQy?=
 =?utf-8?B?WVJsckdPM2JiVlQyalpRTGthZUZPU3JTUE9BdXFxcjVCcVlFaFZXdmh4Ly9p?=
 =?utf-8?B?M0p0Y3NvYWdKemtXeGVzcDBvbjBNeGJqMEFPdW1nS2Y1cHowTmJDU2RkWFBa?=
 =?utf-8?B?dW9nTTAzUXNNRE9aS0hjVXRxb01XelZveldoMGdYTGNsRTVTLytVWDYxcGpY?=
 =?utf-8?B?SEZETjJBR0xndm04V1BNWHJwMzFrS1k3a0xlK2ZUeUtTNkR3ODJOM2VaQnp2?=
 =?utf-8?B?RzR5VWRJVjNXTGRZeEM4NVR6c2Y1N0lSOTZzeC9QWm9iSTFOSzR1eUZBZFFW?=
 =?utf-8?B?N0FVNDhKaXZhYnEvNmFOaWd6Rkhuc09SR21GeFYzTnpXdlU5WGJ1WE9EUXZy?=
 =?utf-8?B?d2M1MzQ2NEF3YWNnYk80eHJTSkhoV1JzU0o5eTRpSXJFYnVHZUxMQ3dEL2tS?=
 =?utf-8?B?RCsvT1ZWM1hkSk1JQzFZWHh6TzBxSlQ0ZEk1SDQyeTgvYjJTekNBb0g5ZmJR?=
 =?utf-8?B?TnNqRWJOQWtaZmIvQXB6ZGsxWVdvMTZQU3ViNC9WdGI5aTRodHN0NGVIZVNw?=
 =?utf-8?B?eTVPS1dXZGpqN0xhTGJiMWlpWmFtTGFUb0FKc1Y5SDlZTUN5U2xZam5SS3ZE?=
 =?utf-8?B?TGI5cE1YNWVZYTBZSjJoWFl6YXBQRnFZVm9HUXNYbStSdS9uY2JUdERwS25V?=
 =?utf-8?B?SXZEVi9lTEVYbkR0MnJrODZuWXNTdVJkUVNha1JkVGdHa2lnRlppZCtIUlA3?=
 =?utf-8?B?ME5KbmlPK3BqTGJhR1lJc0tzS0NtL2FxNE9RZGZUUERoYVM1RjdsVTdIUVpR?=
 =?utf-8?B?VEU4TUo3TW03U0tZVGQ0VFZKQ2VDbnVQYW80c1MrMnhOaGhQWWZmWDV6ckIw?=
 =?utf-8?B?ZXgzdHdDajRxVmsra0JDeGRwWjBuQUxOSG5WOGlsL0RPZm8zRThGaUhGZmo2?=
 =?utf-8?B?eVA4SCtFdUQzR2s1RXJDdkdzYmJCTXh2S1BpZTZySUx6MWpzeVhEQktlNW9C?=
 =?utf-8?B?d0JzOUpKb21FdHc5S2NmeTFmWmRaYkVkcVc0UDdXTjVFSUoyTnZKWHBUWG9I?=
 =?utf-8?B?QnJVTjJJcGorakdvYjBFYlJoOUQ4QmNJWFc1dkh6ZjNjeGpJbCswMW5MQTIx?=
 =?utf-8?B?Y3RIazFLQ3ozeGlONSszYURKalp3MjV1ODR3TDNpeUVDcGpXeDBlZHlQUzZr?=
 =?utf-8?B?VW5Sa25KMEM5OGZ2T0h5RDRVUWhQMGFhWjFraU11TldBM1l6NkZqb3hRVWRs?=
 =?utf-8?B?TThkeTloY3MwSWQ3RThVVDdNc3M4LzFXcnNRem1nKy95RUFIb2x3TEpveTR1?=
 =?utf-8?B?Um0yNmJJeVIwckxkbTYwdmRlMGhnVGIzbkdFMnVBVnFpSHhuQ0IvOFk2OWNs?=
 =?utf-8?B?eDhHdDA0R2hvZ0t1VFZlcnR1NndRWXcwWjBjY2JFUE1iYkJ1dmplZnF6eHlM?=
 =?utf-8?B?cW4xd1NNaTB6emV0ZGxzTEJyN1IzaGhjck94VmYyeFMzSUdQQURERjQvSml6?=
 =?utf-8?B?a3hTdmxJSFEzbzdwOEEvdFNrUkFJOEk4ZnJ1YU1mazRuZjUwMVhOSGpTUUwv?=
 =?utf-8?B?S0xIdHp6c2JDd3hDcjBoY0lESllkbmlnMTRJQ1JhQ2tCSk53SXZrU3JzWi91?=
 =?utf-8?Q?6puU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfede30-cef5-4469-52fb-08d9aa9dccbd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 14:14:57.5240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMguYkO0GezFWko4HYw5lM88/xa6Yf9i+cDxZ0D4rozLk8jLDTB0hz8RI9eeqgjc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1244
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/18/2021 7:41 PM, Christian König wrote:
> Am 18.11.21 um 15:09 schrieb Lazar, Lijo:
>> On 11/18/2021 7:36 PM, Alex Deucher wrote:
>>> On Thu, Nov 18, 2021 at 8:11 AM Liang, Prike <Prike.Liang@amd.com> 
>>> wrote:
>>>>
>>>> [Public]
>>>>
>>>>> -----Original Message-----
>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>> Sent: Thursday, November 18, 2021 4:01 PM
>>>>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>>>>> <Ray.Huang@amd.com>
>>>>> Subject: Re: [PATCH] drm/amdgpu: reset asic after system-wide suspend
>>>>> aborted
>>>>>
>>>>>
>>>>>
>>>>> On 11/18/2021 12:32 PM, Prike Liang wrote:
>>>>>> Do ASIC reset at the moment Sx suspend aborted behind of amdgpu
>>>>>> suspend to keep AMDGPU in a clean reset state and that can avoid
>>>>>> re-initialize device improperly error.
>>>>>>
>>>>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ++++
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 19
>>>>> +++++++++++++++++++
>>>>>>    3 files changed, 24 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>> index b85b67a..8bd9833 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>> @@ -1053,6 +1053,7 @@ struct amdgpu_device {
>>>>>>      bool                            in_s3;
>>>>>>      bool                            in_s4;
>>>>>>      bool                            in_s0ix;
>>>>>> +   bool                            pm_completed;
>>>>>
>>>>> PM framework maintains separate flags, why not use the same?
>>>>>
>>>>>           dev->power.is_suspended = false;
>>>>>           dev->power.is_noirq_suspended = false;
>>>>>           dev->power.is_late_suspended = false;
>>>>>
>>>>
>>>> Thanks for pointing it out and I miss that flag. In this case we can 
>>>> use the PM flag is_noirq_suspended for checking AMDGPU device 
>>>> whether is finished suspend.
>>>>
>>>>> BTW, Alex posted a patch which does similar thing, though it tries 
>>>>> reset if
>>>>> suspend fails.
>>>>>
>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2FDM6PR12MB26195F8E099407B4B6966FEBE4999%40&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C79c861fcfccc4f2cc45d08d9aa9d61f0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637728415203834017%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=gGnctl8rlNTj6o02hlE06og3RCA%2BQP37B3ejsZSxPdM%3D&amp;reserved=0 
>>>>>
>>>>> DM6PR12MB2619.namprd12.prod.outlook.com/
>>>>>
>>>>> If that reset also failed, then no point in another reset, or keep 
>>>>> it as part of
>>>>> resume.
>>>>>
>>>>
>>>> Alex's patch seems always do the ASIC reset at the end of AMDGPU 
>>>> device, but that may needn't on the normal AMDGPU device suspend. 
>>>> However, this patch shows that can handle the system suspend aborted 
>>>> after AMDGPU suspend case well, so now seems we only need take care 
>>>> suspend abort case here.
>>>>
>>>
>>> Yeah, I was thinking we'd take this patch rather than mine to minimize
>>> the number of resets.
>>>
>>
>> Wondering if suspend fails whether there is a need to call resume. It 
>> may not get to resume() to do a reset, that needs to be checked.
> 
> I would rather do it so that we reset the ASIC during resume when we 
> detect that the hardware is in a bad state.
> 
> This way it should also work with things like kexec and virtualization.

I was thinking from the power framework perspective. If the device's 
suspend() callback returns failure, why would the framework needs to 
call a resume() on that device.

Thanks,
Lijo

> 
> Regards,
> Christian.
> 
>>
>> Thanks,
>> Lijo
>>
>>
>>> Alex
>>>
>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>
>>>>>>
>>>>>>      atomic_t                        in_gpu_reset;
>>>>>>      enum pp_mp1_state               mp1_state;
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> index ec42a6f..a12ed54 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> @@ -3983,6 +3983,10 @@ int amdgpu_device_resume(struct drm_device
>>>>> *dev, bool fbcon)
>>>>>>      if (adev->in_s0ix)
>>>>>>              amdgpu_gfx_state_change_set(adev,
>>>>> sGpuChangeState_D0Entry);
>>>>>>
>>>>>> +   if (!adev->pm_completed) {
>>>>>> +           dev_warn(adev->dev, "suspend aborted will do asic 
>>>>>> reset\n");
>>>>>> +           amdgpu_asic_reset(adev);
>>>>>> +   }
>>>>>>      /* post card */
>>>>>>      if (amdgpu_device_need_post(adev)) {
>>>>>>              r = amdgpu_device_asic_init(adev); diff --git
>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>> index eee3cf8..9f90017 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>> @@ -2168,6 +2168,23 @@ static int amdgpu_pmops_suspend(struct
>>>>> device *dev)
>>>>>>      return r;
>>>>>>    }
>>>>>>
>>>>>> +/*
>>>>>> + * Actually the PM suspend whether is completed should be confirmed
>>>>>> + * by checking the sysfs
>>>>>> +sys/power/suspend_stats/failed_suspend.However,
>>>>>> + * in this function only check the AMDGPU device whether is 
>>>>>> suspended
>>>>>> + * completely in the system-wide suspend process.
>>>>>> + */
>>>>>> +static int amdgpu_pmops_noirq_suspend(struct device *dev) {
>>>>>> +   struct drm_device *drm_dev = dev_get_drvdata(dev);
>>>>>> +   struct amdgpu_device *adev = drm_to_adev(drm_dev);
>>>>>> +
>>>>>> +   dev_dbg(dev, "amdgpu suspend completely.\n");
>>>>>> +   adev->pm_completed = true;
>>>>>> +
>>>>>> +   return 0;
>>>>>> +}
>>>>>> +
>>>>>>    static int amdgpu_pmops_resume(struct device *dev)
>>>>>>    {
>>>>>>      struct drm_device *drm_dev = dev_get_drvdata(dev); @@ -2181,6
>>>>>> +2198,7 @@ static int amdgpu_pmops_resume(struct device *dev)
>>>>>>      r = amdgpu_device_resume(drm_dev, true);
>>>>>>      if (amdgpu_acpi_is_s0ix_active(adev))
>>>>>>              adev->in_s0ix = false;
>>>>>> +   adev->pm_completed = false;
>>>>>>      return r;
>>>>>>    }
>>>>>>
>>>>>> @@ -2397,6 +2415,7 @@ static const struct dev_pm_ops amdgpu_pm_ops
>>>>> = {
>>>>>>      .runtime_suspend = amdgpu_pmops_runtime_suspend,
>>>>>>      .runtime_resume = amdgpu_pmops_runtime_resume,
>>>>>>      .runtime_idle = amdgpu_pmops_runtime_idle,
>>>>>> +   .suspend_noirq = amdgpu_pmops_noirq_suspend,
>>>>>>    };
>>>>>>
>>>>>>    static int amdgpu_flush(struct file *f, fl_owner_t id)
>>>>>>
> 
