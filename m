Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D04C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Dec 2022 21:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B091E10E574;
	Thu, 15 Dec 2022 21:02:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7363110E572
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Dec 2022 21:02:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNfBMe3ElmF+91mJb1Ty+5U9Tjb9qKC211DtkNiWxc/T8sowkDysCgz3JdlaxLfqCh0ndAI4Fj43O8hslScSTIfEVrBpWnTL3r60WBq0G0kONoAsaQOFV6rJqSgGpoAvtK1csxw/PPvHQG0kh0+9JzyHEJ+ED5fTVDWvwLGCl0bBm0l1b/ACKbdjR9/NhYHDplf9PoB4KmcveMGKCuL3hNFm/VKZUp5hbfQNKPWgDMzW7zl2E+/xI6Rv5ygheyhoav81RE8ER+P0B9JQp0/K5fOUGBaPx3fR3fWgSQfQyN2ToepiV7rBuqIRInxCxC6rRPj3b1/l2q3Sl0vWNiE7tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PC/nCqQ5UBC7m5q1MiRxLUohGSq8UySD6O5kP8qVYK0=;
 b=fkIaxGyL0h+wZlSX5i47BdSikjVyo+sV33eHANMajXg7xiFsOMLakmOpZFT0RO95lfMVe1E04lo8923Z/KKuq+4Ow+mTAXjVqe0Lkmm0uL6ykG3jzVOq7lA44vjXBumg8lPBj8KQK0ekSpPwPB40d9xEMAMkosPAS9P1xMxpfY48a/6YlVqdsPklm2Qwp/+RPJ/Jp97ia2N273hDlTR/VyrX+7kT7ocbMjhv5q3FKRBHdqaBE6UR7TojyN2QIQV2QiuS5Vn/cmrbPle7tsFWQ2l4mmcfs+lpKO/isRvmQ34C+whabWszdENHo8vw97AbzcAV9eDfQeRcNe6JyByj9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PC/nCqQ5UBC7m5q1MiRxLUohGSq8UySD6O5kP8qVYK0=;
 b=kOJs47A+nRnlbI7MLC4PLnargzDCDGe/INkUhAWR3bVnFUNPybhfWQ6Ph10CbGQq1IACBMlOz+dzRUD/12zZGKrjcuiKzuKrehglDyNMo2CdBiyQ0Pzw5yfLeSoeH94hhhsrTef/b4IBgldruW840rH9ttpv6gTzAk9Wbtukp3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3048.namprd12.prod.outlook.com (2603:10b6:a03:ad::33)
 by MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 15 Dec
 2022 21:02:10 +0000
Received: from BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::59a:33d2:5505:3a99]) by BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::59a:33d2:5505:3a99%6]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 21:02:10 +0000
Message-ID: <ffd8a259-d3ec-b2a0-ed59-62727e08998f@amd.com>
Date: Thu, 15 Dec 2022 14:02:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 05/18] drm/amd/display: Use mdelay to avoid crashes
To: Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
 <20221214202141.1721178-6-aurabindo.pillai@amd.com>
 <CADnq5_PKy2+2-5X+zn4Ax2wp1iuiZ7E-r-bQ3cSHifE34FYfRA@mail.gmail.com>
 <2938ab78-3224-4097-f5d1-f64c354e5eb6@amd.com>
 <CADnq5_P83EkSqXxe29diJZ2eJH8-8v308jLRZxJ4f8e7FnEOmw@mail.gmail.com>
 <12eed813-c250-4b14-7497-afbd6a41cf2b@amd.com>
 <CADnq5_OzcwSgC3a5MwX=tdLNAxuSeQiAjei9b6CYq84rhA6ncQ@mail.gmail.com>
 <fb472bf8-0478-0acb-a730-19802277dfdc@amd.com>
 <CADnq5_Pz=JDUaGW3HE17sL0rnkOB9KSVKeNc5u5zn-8QNTNPrQ@mail.gmail.com>
 <7a976873-033c-461e-c6de-4df01051ec24@amd.com>
 <e2337d02-594e-9c69-d8a4-b046fc9c221f@amd.com>
 <e8801420-3212-702a-93dd-1b3f323bfd87@mailbox.org>
 <636f4287-803f-4cb9-dec0-2ffcc0f072d4@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <636f4287-803f-4cb9-dec0-2ffcc0f072d4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0057.namprd16.prod.outlook.com
 (2603:10b6:907:1::34) To BYAPR12MB3048.namprd12.prod.outlook.com
 (2603:10b6:a03:ad::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3048:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 67574d0b-9251-486d-9a8b-08dadedfa208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j73deRRKjl4Ad5SzUJqTDWS6ygGCXFRWLKGXOSeXcA0r9rTT5NGjl+L0sGeZuSJ2uEBtHvLEFWI61wM384FEbhnt/XNWmoeaNEEw4UYE3sfYTpIDLbUhJcl0x7rtPB+iQfCUEgxS8ESj/D3iFqUN5d1wqpbm8gBuLFiylgADLM0a3J7MRCiQx28oAQYB2a53vglXTtA8On9dkjMXZrR2U0eu0wKFI9oi0p4i3Y9mcNEnpwoZD8tepdjAAbjhepTPt4yzCXCgh27OPm2b3dyONkvj5t80nqGR910FMTadZUN1G1THpUj3j54HY5P1YN3ujbQy7yVRhA1TV8N/AkkFnWio8k4LCXMwpwTEKBWuEX3mQhAakSbmacnWWmrH0/KmwhyXQ1bJOtyKPykTrz9I5w8s/PqGvN12ceSlYbqfYrFCm3FParvgeERNUQzpbXtHqCYf03nAvFFLxk43zWh0HqxY8W8b/uQPn1V7dg4pZ2iUJEsyZfFbht4WOSLiohiw+0pxYZaYdKRJWHyyONO2LSDUPjN9dfp+DOPiOki0jWJT0+qXm4zj800WMpkow4R09cXSSAIHqhmIg99GJLI2aew1vTbF42T9q8qpXh1nNGuH7ZI3d/YxvnYKfgBCPLa7CTwYVWksEKN9ThZHzY2Fj9Aavg9T+NLmZrTi+yP9sDY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199015)(36756003)(53546011)(6666004)(8936002)(478600001)(6486002)(31696002)(38100700002)(86362001)(41300700001)(31686004)(5660300002)(110136005)(44832011)(4001150100001)(2616005)(30864003)(186003)(66946007)(4326008)(316002)(66476007)(66556008)(8676002)(2906002)(6512007)(66574015)(83380400001)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTA3MkJXTXVUVnpmVHZndTE2WGI3VjR3VTZ3R2dSVWx3Um9UM2h3aEJDNnZF?=
 =?utf-8?B?OExlbXlhcTM2VkdLQnhFRTQxckxsQnBDbFUxS09ZV29VUFR4RVNOUzhhdUZM?=
 =?utf-8?B?RG81aHRKb0pJN2J3TWdaclFBeVRrR00waEFrTy9CODg4Um02SXcwK2xTRFJX?=
 =?utf-8?B?ZDA1SG91eDg0L3JpOHZuNDZuMTFDMmFlQTROSk5hNDBOQUF1eVJJdnpqVlds?=
 =?utf-8?B?RUJQL3E2S3g2ZVlrSExRNjlRM2xhVUhxSlNtMFZDbm44bVJNUlJoYndQcEJE?=
 =?utf-8?B?RUNqaVlYUDExb203MjE3Y1lhUXNsZ1N2UjFNWWdYYnMwOXVKQ213M3ExVklU?=
 =?utf-8?B?RjEvVGliWm43TFZjOTJyMXprSW9XOExPTis5cXY2YmVlTktTWVV2eDV3Vksy?=
 =?utf-8?B?Z2o2alI3MkhhdUNFcU1OWExxUkg0U1A4LzcvSXVPUktkWDIxODdsZ2FXUnh0?=
 =?utf-8?B?dHVwV0JvSDRBR0owaWt1MTlHd1NZbzRxQVRyeUgrWDNzM0JoNkdRdHlHeHpU?=
 =?utf-8?B?TzNlaStPWFJzcFZreDZ5S3RSUC9QQ2FSOHBqcHBwSHM2VHR4Z1hoWExkY0Nv?=
 =?utf-8?B?bVMzYkVCM0FWSHRaWWxIR2ZXMmVqdmNNQ0xKd0VVYXpaOWZLUXZKd2tSMlpp?=
 =?utf-8?B?SlNia2RSTXhjbWlhWXc4Z3hvZVlZaWMwV3JBMXByUmFhdGJtZW9HdjQyMy9o?=
 =?utf-8?B?VUdKSzZIV1BEWE9YMldKVDdEY2oyZFp0RkdlKy9mNVp5eSs4UDFCT3ZMMEQ3?=
 =?utf-8?B?cXAwWUUwZmxSRUNncm4rbno2VmFVcmZabFdNbUFteVVYcXBBRElvc3pQL3E2?=
 =?utf-8?B?MjY5ZlF2dmhkSUFiM2VZaWhTVUxlZExDWXIxdGQvOGNmeXVBdTJzc0FlNm4r?=
 =?utf-8?B?VklVTWkxN2NnbStOYXplYkdQWjlvZytOV1Rpa2c4M3ZvWm1NOTk3SFlLQXpx?=
 =?utf-8?B?V25GZ2tPZ2l4cHgyYW9GSWR2OHI5WitzOHVpTHZLRHY3VVBhRFUrNkUwekw3?=
 =?utf-8?B?bEMydWlWcFVIZnR4K1FrZFYrWkxCTkJCY3kwdmUrNGQ4ZllCclZGWjcrSjJ6?=
 =?utf-8?B?dzZmK1JwUzIrZHlyeGNzRjlabVQ4dzNWQklnV09oMEtoWWlPRy9vSGRFaWdZ?=
 =?utf-8?B?ei9ZY2swcHE1ZUpDcWJRdDFYSmQxcFVWQUtXY3o3UjR1OHJmNERpS1dlS2hT?=
 =?utf-8?B?cjRpaU9JT1MwWStuRTVUNWhUcm1adDl2TmlwV0hnMW92NGxmSjE5aFdNaTV3?=
 =?utf-8?B?K1pVTkIyOGM2RXo5NmpBMkRKT1lFemU5Q2M3SFRDdEs3b0NlWk9xQ3lENnJH?=
 =?utf-8?B?Z0JpVCt5ZEdBSXRIcWh4c0h3d3kwNXd0RGdrTEFjSHVKU2szeEZyLzRtL2RZ?=
 =?utf-8?B?ZElqcm9vRDFLZHp2VW9YcFpFZVRrQ1BuYzB6dUhheHZkSk9aNmdFR29PVEgy?=
 =?utf-8?B?ekhoUW1ST2tWMHlDQWt5dE5PeS9VZ2RqcjlvVms2QmVEa2FGQmVIajN0Y2hC?=
 =?utf-8?B?Q3F5b2VzR1l5MmNGUnNkNTVuMzhkb2NXZlc3dzdpajJ3TWtmSTZkQmVYblNS?=
 =?utf-8?B?d1MzM2dIZTN2amR1Q291ak5mOVVDN3ZMbU1iZVRVUGhkZWJiRzJtaFpHYmQ2?=
 =?utf-8?B?aWhXT1h0L1B6ZkxlcldERE92ZTJFdXFqWUQ1eDZhbi9XYTRJYzZnV3YyTTF2?=
 =?utf-8?B?ci9sY29qNEdDMElsZFJ6RHpMTWtmUEZnd2FkZXNFUU41eXFSUU9neFZvM0Nn?=
 =?utf-8?B?dXRsMFZMbmJLM0dXbWMyQlEvY0E2a2hvUXZWYVJkLzErVjJJOFlXa0pkYkZE?=
 =?utf-8?B?M3oyNVc5cFR2UGdoaTdodDhTc0U2cFFURlR3dS9QdnlvWTk3NE5wdW5xS3hT?=
 =?utf-8?B?aW12UEVSSVhUalFFbGVQK2NqU2x0ZjZlcXYxa2U4djY1bXJuYVFnR1JnOStK?=
 =?utf-8?B?Yi9Hb1l6bkpuM1JpckhjM2VaQzhQVzExUFhiRUJ6MnFENGNxRk1EK3I3a2M4?=
 =?utf-8?B?MG40KzhyOTg0WXNhcWRwcEpzZ01pUHYrcE4wSzlxTXJVM3h0LzAyN1lJS201?=
 =?utf-8?B?akoxUHNYd2VVd3pENExORUFhZ1Y3b0VFTHlCQVdyZVJ4d2YxZXZOV1grU21V?=
 =?utf-8?B?cTY5KytRNlhSc0o2VkwxLzFqcFlDUDVyQUJNSFp6dEpkOGFsRTJSYW52OG8r?=
 =?utf-8?B?Vmc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67574d0b-9251-486d-9a8b-08dadedfa208
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 21:02:10.5611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0w6oAAsXfyTcquLD6eUNDBSeb6i2yvRqHydEZFYWhVPKDwz+YfzhUE39TxCJBkz6qSs3YOYhrNmt2dZkQXT4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, amd-gfx@lists.freedesktop.org,
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-12-15 08:17, Harry Wentland wrote:
> 
> 
> On 12/15/22 05:29, Michel Dänzer wrote:
>> On 12/15/22 09:09, Christian König wrote:
>>> Am 15.12.22 um 00:33 schrieb Alex Hung:
>>>> On 2022-12-14 16:06, Alex Deucher wrote:
>>>>> On Wed, Dec 14, 2022 at 5:56 PM Alex Hung <alex.hung@amd.com> wrote:
>>>>>> On 2022-12-14 15:35, Alex Deucher wrote:
>>>>>>> On Wed, Dec 14, 2022 at 5:25 PM Alex Hung <alex.hung@amd.com> wrote:
>>>>>>>> On 2022-12-14 14:54, Alex Deucher wrote:
>>>>>>>>> On Wed, Dec 14, 2022 at 4:50 PM Alex Hung <alex.hung@amd.com> wrote:
>>>>>>>>>> On 2022-12-14 13:48, Alex Deucher wrote:
>>>>>>>>>>> On Wed, Dec 14, 2022 at 3:22 PM Aurabindo Pillai
>>>>>>>>>>> <aurabindo.pillai@amd.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> From: Alex Hung <alex.hung@amd.com>
>>>>>>>>>>>>
>>>>>>>>>>>> [Why]
>>>>>>>>>>>> When running IGT kms_bw test with DP monitor, some systems crash from
>>>>>>>>>>>> msleep no matter how long or short the time is.
>>>>>>>>>>>>
>>>>>>>>>>>> [How]
>>>>>>>>>>>> To replace msleep with mdelay.
>>>>>>>>>>>
>>>>>>>>>>> Can you provide a bit more info about the crash?  A lot of platforms
>>>>>>>>>>> don't support delay larger than 2-4ms so this change will generate
>>>>>>>>>>> errors on ARM and possibly other platforms.
>>>>>>>>>>>
>>>>>>>>>>> Alex
>>>>>>>>>>
>>>>>>>>>> The msleep was introduced in eec3303de3378 for non-compliant display
>>>>>>>>>> port monitors but IGT's kms_bw test can cause a recent h/w to hang at
>>>>>>>>>> msleep(60) when calling "igt_remove_fb" in IGT
>>>>>>>>>> (https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tests/kms_bw.c#L197>>>>>>>>>>
>>>>>>>>>> It is possible to workaround this by reversing order of
>>>>>>>>>> igt_remove_fb(&buffer[i]), as the following example:
>>>>>>>>>>
>>>>>>>>>>        igt_create_color_fb with the order buffer[0], buffer[1], buffer[2]
>>>>>>>>>>
>>>>>>>>>> Hangs:
>>>>>>>>>>        igt_remove_fb with the order buffer[0], buffer[1], buffer[2]
>>>>>>>>>>
>>>>>>>>>> No hangs:
>>>>>>>>>>        igt_remove_fb with the reversed order buffer[2], buffer[1], buffer[0]
>>>>>>>>>>
>>>>>>>>>> However, IGT simply exposes the problem and it makes more sense to stop
>>>>>>>>>> the hang from occurring.
>>>>>>>>>>
>>>>>>>>>> I also tried to remove the msleep completely and it also work, but I
>>>>>>>>>> didn't want to break the fix for the original problematic hardware
>>>>>>>>>> configuration.
>>>>>>>>>
>>>>>>>>> Why does sleep vs delay make a difference?  Is there some race that we
>>>>>>>>> are not locking against?
>>>>>>>>>
>>>>>>>>> Alex
>>>>>>>>>
>>>>>>>>
>>>>>>>> That was my original thought but I did not find any previously. I will
>>>>>>>> investigate it again.
>>>>>>>>
>>>>>>>> If mdelay(>4) isn't usable on other platforms, is it an option to use
>>>>>>>> mdelay on x86_64 only and keep msleep on other platforms or just remove
>>>>>>>> the msleep for other platforms, something like
>>>>>>>>
>>>>>>>> -                       msleep(60);
>>>>>>>> +#ifdef CONFIG_X86_64
>>>>>>>> +                       mdelay(60);
>>>>>>>> +#endif
>>>>>>>
>>>>>>> That's pretty ugly.  I'd rather try and resolve the root cause.  How
>>>>>>> important is the IGT test?  What does it do?  Is the test itself
>>>>>>> correct?
>>>>>>>
>>>>>>
>>>>>> Agreed, and I didn't want to add conditions around the mdelay for the
>>>>>> same reason. I will assume this is not an option now.
>>>>>>
>>>>>> As in the previous comment, IGT can be modified to avoid the crash by
>>>>>> reversing the order fb is removed - though I suspect I will receive
>>>>>> questions why this is not fixed in kernel.
>>>>>>
>>>>>> I wanted to fix this in kernel because nothing stops other user-space
>>>>>> applications to use the same way to crash kernel, so fixing IGT is the
>>>>>> second option.
>>>>>>
>>>>>> Apparently causing problems on other platforms isn't an option at all so
>>>>>> I will try to figure out an non-mdelay solution, and then maybe an IGT
>>>>>> solution instead.
>>>>>
>>>>> What hangs?  The test or the kernel or the hardware?
>>>>
>>>> The system becomes completely unresponsive - no keyboard, mouse nor remote accesses.
>>>
>>> I agree with Alex that changing this is extremely questionable and not justified at all.
>>>
>>> My educated guess is that by using mdelay() instead of msleep() we keep the CPU core busy and preventing something from happening at the same time as something else.
>>>
>>> This clearly points to missing locking or similar to protect concurrent execution of things.
>> Might another possibility be that this code gets called from an atomic context which can't sleep?
>>
>>
> 
> It can come through handle_hpd_rx_irq but we're using a workqueue
> to queue interrupt handling so this shouldn't come from an atomic
> context. I currently don't see where else it might be used in an
> atomic context. Alex Hung, can you do a dump_stack() in this function
> to see where the problematic call is coming from?


IGT's kms_bw executes as below (when passing)

IGT-Version: 1.26-gf4067678 (x86_64) (Linux: 5.19.0-99-custom x86_64)
Starting subtest: linear-tiling-1-displays-1920x1080p
Subtest linear-tiling-1-displays-1920x1080p: SUCCESS (0.225s)
Starting subtest: linear-tiling-1-displays-2560x1440p
Subtest linear-tiling-1-displays-2560x1440p: SUCCESS (0.111s)
Starting subtest: linear-tiling-1-displays-3840x2160p
Subtest linear-tiling-1-displays-3840x2160p: SUCCESS (0.118s)
Starting subtest: linear-tiling-2-displays-1920x1080p
Subtest linear-tiling-2-displays-1920x1080p: SUCCESS (0.409s)
Starting subtest: linear-tiling-2-displays-2560x1440p
Subtest linear-tiling-2-displays-2560x1440p: SUCCESS (0.417s)
Starting subtest: linear-tiling-2-displays-3840x2160p
Subtest linear-tiling-2-displays-3840x2160p: SUCCESS (0.444s)
Starting subtest: linear-tiling-3-displays-1920x1080p
Subtest linear-tiling-3-displays-1920x1080p: SUCCESS (0.547s)
Starting subtest: linear-tiling-3-displays-2560x1440p
Subtest linear-tiling-3-displays-2560x1440p: SUCCESS (0.555s)
Starting subtest: linear-tiling-3-displays-3840x2160p
Subtest linear-tiling-3-displays-3840x2160p: SUCCESS (0.586s)
Starting subtest: linear-tiling-4-displays-1920x1080p
Subtest linear-tiling-4-displays-1920x1080p: SUCCESS (0.734s)
Starting subtest: linear-tiling-4-displays-2560x1440p
Subtest linear-tiling-4-displays-2560x1440p: SUCCESS (0.742s)
Starting subtest: linear-tiling-4-displays-3840x2160p
Subtest linear-tiling-4-displays-3840x2160p: SUCCESS (0.778s)
Starting subtest: linear-tiling-5-displays-1920x1080p
Subtest linear-tiling-5-displays-1920x1080p: SUCCESS (0.734s)
Starting subtest: linear-tiling-5-displays-2560x1440p
Subtest linear-tiling-5-displays-2560x1440p: SUCCESS (0.743s)
Starting subtest: linear-tiling-5-displays-3840x2160p
Subtest linear-tiling-5-displays-3840x2160p: SUCCESS (0.781s)
Starting subtest: linear-tiling-6-displays-1920x1080p
Test requirement not met in function run_test_linear_tiling, file 
../tests/kms_bw.c:156:
Test requirement: !(pipe > num_pipes)
ASIC does not have 5 pipes
Subtest linear-tiling-6-displays-1920x1080p: SKIP (0.000s)
Starting subtest: linear-tiling-6-displays-2560x1440p
Test requirement not met in function run_test_linear_tiling, file 
../tests/kms_bw.c:156:
Test requirement: !(pipe > num_pipes)
ASIC does not have 5 pipes
Subtest linear-tiling-6-displays-2560x1440p: SKIP (0.000s)
Starting subtest: linear-tiling-6-displays-3840x2160p
Test requirement not met in function run_test_linear_tiling, file 
../tests/kms_bw.c:156:
Test requirement: !(pipe > num_pipes)
ASIC does not have 5 pipes
Subtest linear-tiling-6-displays-3840x2160p: SKIP (0.000s)

The crash usually occurs when executing 
"linear-tiling-3-displays-1920x1080p" most of time, but the crash can 
also occurs at "linear-tiling-3-displays-2560x1440p"

============
This is dump_stack right before the failing msleep.

[IGT] kms_bw: starting subtest linear-tiling-3-displays-1920x1080p
CPU: 1 PID: 76 Comm: kworker/1:1 Not tainted 5.19.0-99-custom #126
Workqueue: events drm_mode_rmfb_work_fn [drm]
Call Trace:
  <TASK>
  dump_stack_lvl+0x49/0x63
  dump_stack+0x10/0x16
  dce110_blank_stream.cold+0x5/0x14 [amdgpu]
  core_link_disable_stream+0xe0/0x6b0 [amdgpu]
  ? optc1_set_vtotal_min_max+0x6b/0x80 [amdgpu]
  dcn31_reset_hw_ctx_wrap+0x229/0x410 [amdgpu]
  dce110_apply_ctx_to_hw+0x6e/0x6c0 [amdgpu]
  ? dcn20_plane_atomic_disable+0xb2/0x160 [amdgpu]
  ? dcn20_disable_plane+0x2c/0x60 [amdgpu]
  ? dcn20_post_unlock_program_front_end+0x77/0x2c0 [amdgpu]
  dc_commit_state_no_check+0x39a/0xcd0 [amdgpu]
  ? dc_validate_global_state+0x2ba/0x330 [amdgpu]
  dc_commit_state+0x10f/0x150 [amdgpu]
  amdgpu_dm_atomic_commit_tail+0x631/0x2d30 [amdgpu]
  ? dcn30_internal_validate_bw+0x349/0xa00 [amdgpu]
  ? slab_post_alloc_hook+0x53/0x270
  ? dcn31_validate_bandwidth+0x12c/0x2b0 [amdgpu]
  ? dcn31_validate_bandwidth+0x12c/0x2b0 [amdgpu]
  ? dc_validate_global_state+0x27a/0x330 [amdgpu]
  ? slab_post_alloc_hook+0x53/0x270
  ? __kmalloc+0x18c/0x300
  ? drm_dp_mst_atomic_setup_commit+0x8a/0x1a0 [drm_display_helper]
  ? preempt_count_add+0x7c/0xc0
  ? _raw_spin_unlock_irq+0x1f/0x40
  ? wait_for_completion_timeout+0x114/0x140
  ? preempt_count_add+0x7c/0xc0
  ? _raw_spin_unlock_irq+0x1f/0x40
  commit_tail+0x99/0x140 [drm_kms_helper]
  drm_atomic_helper_commit+0x12b/0x150 [drm_kms_helper]
  drm_atomic_commit+0x79/0x100 [drm]
  ? drm_plane_get_damage_clips.cold+0x1d/0x1d [drm]
  drm_framebuffer_remove+0x499/0x510 [drm]
  drm_mode_rmfb_work_fn+0x4b/0x90 [drm]
  process_one_work+0x21d/0x3f0
  worker_thread+0x1fa/0x3c0
  ? process_one_work+0x3f0/0x3f0
  kthread+0xff/0x130
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x22/0x30
  </TASK>


============
If msleep is replaced by mdelay, the dump_stack is almost the same:

$ diff mdelay.log msleep.log
<  dce110_blank_stream.cold+0x5/0x1f [amdgpu]
---
 >  dce110_blank_stream.cold+0x5/0x14 [amdgpu]


============
If the IGT fix is applied (i.e. no crashes when removing buffers[i] 
reversely by "igt_remove_fb", the dump_stack outputs are the same:

$ diff msleep_igt.log msleep.log
2c2
< CPU: 6 PID: 78 Comm: kworker/6:1 Not tainted 5.19.0-99-custom #126
---
 > CPU: 1 PID: 76 Comm: kworker/1:1 Not tainted 5.19.0-99-custom #126

============
Note the msleep doesn't always trigger crashes. One of the passing 
dump_stack is as below:

[IGT] kms_bw: starting subtest linear-tiling-2-displays-1920x1080p
CPU: 6 PID: 78 Comm: kworker/6:1 Not tainted 5.19.0-99-custom #126
Workqueue: events drm_mode_rmfb_work_fn [drm]
Call Trace:
  <TASK>
  dump_stack_lvl+0x49/0x63
  dump_stack+0x10/0x16
  dce110_blank_stream.cold+0x5/0x14 [amdgpu]
  core_link_disable_stream+0xe0/0x6b0 [amdgpu]
  ? optc1_set_vtotal_min_max+0x6b/0x80 [amdgpu]
  dcn31_reset_hw_ctx_wrap+0x229/0x410 [amdgpu]
  dce110_apply_ctx_to_hw+0x6e/0x6c0 [amdgpu]
  ? dcn20_plane_atomic_disable+0xb2/0x160 [amdgpu]
  ? dcn20_disable_plane+0x2c/0x60 [amdgpu]
  ? dcn20_post_unlock_program_front_end+0x77/0x2c0 [amdgpu]
  dc_commit_state_no_check+0x39a/0xcd0 [amdgpu]
  ? dc_validate_global_state+0x2ba/0x330 [amdgpu]
  dc_commit_state+0x10f/0x150 [amdgpu]
  amdgpu_dm_atomic_commit_tail+0x631/0x2d30 [amdgpu]
  ? debug_smp_processor_id+0x17/0x20
  ? dc_fpu_end+0x4e/0xd0 [amdgpu]
  ? dcn316_populate_dml_pipes_from_context+0x69/0x2a0 [amdgpu]
  ? dcn31_calculate_wm_and_dlg_fp+0x50/0x530 [amdgpu]
  ? kernel_fpu_end+0x26/0x50
  ? dc_fpu_end+0x4e/0xd0 [amdgpu]
  ? dcn31_validate_bandwidth+0x12c/0x2b0 [amdgpu]
  ? dcn31_validate_bandwidth+0x12c/0x2b0 [amdgpu]
  ? dc_validate_global_state+0x27a/0x330 [amdgpu]
  ? slab_post_alloc_hook+0x53/0x270
  ? __kmalloc+0x18c/0x300
  ? drm_dp_mst_atomic_setup_commit+0x8a/0x1a0 [drm_display_helper]
  ? preempt_count_add+0x7c/0xc0
  ? _raw_spin_unlock_irq+0x1f/0x40
  ? wait_for_completion_timeout+0x114/0x140
  ? preempt_count_add+0x7c/0xc0
  ? _raw_spin_unlock_irq+0x1f/0x40
  commit_tail+0x99/0x140 [drm_kms_helper]
  drm_atomic_helper_commit+0x12b/0x150 [drm_kms_helper]
  drm_atomic_commit+0x79/0x100 [drm]
  ? drm_plane_get_damage_clips.cold+0x1d/0x1d [drm]
  drm_framebuffer_remove+0x499/0x510 [drm]
  drm_mode_rmfb_work_fn+0x4b/0x90 [drm]
  process_one_work+0x21d/0x3f0
  worker_thread+0x1fa/0x3c0
  ? process_one_work+0x3f0/0x3f0
  kthread+0xff/0x130
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x22/0x30
  </TASK>



> 
> Fixing IGT will only mask the issue. Userspace should never be able
> to put the system in a state where it stops responding entirely. This
> will need some sort of fix in the kernel.
> 
> Harry
> 
> 
