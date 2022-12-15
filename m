Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541D8C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Dec 2022 19:38:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F75B10E52E;
	Thu, 15 Dec 2022 19:38:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71CF910E52D
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Dec 2022 19:38:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBiFCMiUSKHsWfT4cFOnIALqjXqa7LdKMYmYbH1INBMb4WY0IFtj1wsAZoBzEf5JsSrXV/0t/0DAVUiOZegtmNK1UotMJpW0TM29244SG6Go+05HLuoNgu6WbZEjDKSrmolubt7k2cZ748PiJoeBf9ge8IrHKCyg/UaN8sDpB+HLa+egs2IEpyC01Sr+KDGxlIZdexwENyXhU8uCTpDNsjClNqygUZOrhk3BUEQeNRsW58M9Z2bhBXUoE/UFn3J9Hww6FlYSvDur/+VfUcUo0fqaCfVDv2CXK6w3yjowLFEnJclIGZEjK/cYwI6+H4N97RcjwjSN4pvLylzplomxiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zVvflKDiFXVx8S+Xs9M+95kHkayofnnMO+7crhEqBo=;
 b=WR4Y5a+bGmReQASb6ELKodPwtYyBmgu7jqB7qu4FpEHccqzQ6Hl9RRt/8xUxxsDaf34xJKYOVq8u/LVqAekI/bCczJCNxBnyknYCCuQkpLLW22TQMRNGIXHf+zU977bBwQHYraXdoHfHR4/t+glg4rvrfwP/NnLqsVU6kuIZVPQXyPc2cWzdlVOd5b4q+SEEVc4SwBEBD2vqaoCh+6Ln8/5kaUGYXlYEbd06mE3Fgx4pNP03mFYCMsAXYZFPoidQphFcd3kYv7I/sR8zFMfXfQsSapv0QOXp8IuQmtpcVm90mrrgYWAPF9yh6FAcvt8Uie46TrESzlYRlDS9T33IuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zVvflKDiFXVx8S+Xs9M+95kHkayofnnMO+7crhEqBo=;
 b=hIj5yflAwQwTn5TMf9X3TCfzEJKXk8cxCTFjZ8QFLAl2XSZyF+8xCbW4A4Zww4HUPEA3pZ7j2/57myIsZjibuOU/96PZq4YsU3ZWld8SCgyEqNVoxA1UuJOq3seqNVnsS0x1Q1ZsyWt3/d95tY97EgB0+AiUxb6lo8ntZ2/2l20=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 15 Dec
 2022 19:38:02 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::c700:72b0:6c23:f781]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::c700:72b0:6c23:f781%2]) with mapi id 15.20.5924.012; Thu, 15 Dec 2022
 19:38:01 +0000
Content-Type: multipart/alternative;
 boundary="------------KRXK8YlmnytoA6Utt0jQqysH"
Message-ID: <e72b3c1f-08f0-68f8-4aad-69c16966fb99@amd.com>
Date: Thu, 15 Dec 2022 14:38:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 05/18] drm/amd/display: Use mdelay to avoid crashes
To: Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Hung <alex.hung@amd.com>, Alex Deucher <alexdeucher@gmail.com>
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
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <636f4287-803f-4cb9-dec0-2ffcc0f072d4@amd.com>
X-ClientProxiedBy: YT4P288CA0088.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::21) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|SN7PR12MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 7af86b8e-f4b5-4f9c-7cb0-08daded3e0c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nin6y1VfG2r71sJlO3OYO5WLGkEloGI4CR5dJhog6vJPho27VDSylIZ32rlRvdev1sUkMpz4kMuU9CUhfCMlTMIdg65tX/vIH2pPja+Ed3hxHMYDpgtoj68XgKQ0qtLWuHXdGk7SsvwmEBax+pVQHjSlVV0OgIkH5QJYar9xCxL5hSiJ1hxCaPCGJ6a4ZIaZe/w7tOF6jXog9WuNzXhHji0GvETIdwVHBRalSfcng97jMbZqGi+gbwPzp1pFLZDtUHZHFfoM2gkfOVn3BjM/gdh6lz66hmYJU+RvV9Rkmi1idjet0UQ7DTrzDqt4Ft+P5qlBme4ZicabYlq7iTitmlrJs5ndRxDm8XNcI35eB20ZuT1HyCIyqFcE6yjZ2J0NPcGCsrlQd5WzdfAPloY1juwbGrpy8o2qFV9Gpb+rL8l5PzdxNYHiLQMF33aHHrBNZG97MQJNJkkzenrYd3+QHShpiGw39k0g1586CgXqFbhjxdEOXnzUCdFG1xbrZKVYu7YPNAWpnYj2bQ6t+/szoCjQgto3WYEtV5j9cfyMldc/1QSFyUL0Ae8R5hqxUCi/aSXUJ5vYEUVVqoz8dylJXq2ejTnlWeNsAvampayuxEuHaUD/5a1Z0TAbnN+B/zIT/TwSw5Gj7+ebdCc2tPaQwtrn/uEuXDNJG4n69TUOgNI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199015)(38100700002)(44832011)(478600001)(5660300002)(2906002)(166002)(53546011)(31696002)(86362001)(41300700001)(6486002)(4001150100001)(8676002)(66556008)(33964004)(66574015)(4326008)(186003)(8936002)(6506007)(83380400001)(6512007)(110136005)(316002)(66946007)(31686004)(2616005)(26005)(66476007)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGZQeWd4K1hOUEVSa2dQOUdKNHU0b2Z5VXFGV011V05IaEprSWphTTdQUnFo?=
 =?utf-8?B?OTEvdHlPa0FyOFhGSHpDNGo3eW9xZnRSYUx0aTk5Vk5jbk05My9wM3M5Um9K?=
 =?utf-8?B?YUkyT2JVajBpZzdsWUN2Vk5tUGUxUGU0NlVQR3FPdnljY1hYS0JLRXpvV1BG?=
 =?utf-8?B?bWl0MjdLOFIvTVZWUE5QMS9odHhkeFVxT1hmSGI1cFJzR2k1b253TStRMEph?=
 =?utf-8?B?U0w2UGhmVzNkU2RPcmtZMXV5Qm0xWFBoZitvWXFXTUQ0R2I5dWMvVUtiZ0J6?=
 =?utf-8?B?WEl5QlJvODAwdmdPakpmVllCNFYvLzBiQmVyR2prZE95aXN2d1o2eTBIbE40?=
 =?utf-8?B?ZUcxeVBBZXdnRW5vbHdJN1BjTGRmWWRDQ1o2dEhCTFlGZlVHYjZ2RTlrL1VX?=
 =?utf-8?B?N1VnWFJCUUF6SWNkdkprdzhWcWpMdXZiNEdkenFvakcvRGJhT0U1RWVQaWNn?=
 =?utf-8?B?Mm5BZ010bmc3QTVnQXpsdldpZlFJOW9pcXpoN05TcUhZZkZ4RU1GdmxPM1Vl?=
 =?utf-8?B?bkYvYUU4U28xT1lXSUxQbnpGcklWYU1SMDlOOWIvTkZmeHgxbWVjcHhCRW5I?=
 =?utf-8?B?TG94cERJMFc3OW0rVlozWkdJY2plWjFmSzArak9BYXR4RU5vN1RTL2hpWmpU?=
 =?utf-8?B?NTUyNGx3MDFDaDdnQi9zMnlUdzkzVkd0THlCSlJkRjRzYzNMUGE3WnV6Q1ZT?=
 =?utf-8?B?VXl3QmFpZ3lIei9jTjRNZnd2dUMxR29TTHhWR3U1alE5UUtucm1kTXRpZUpw?=
 =?utf-8?B?YldLWWhWM3drak0vd1NIUWdrSWRKSG81VXg5RTZlMjlsT0NoYmJibTMvU2Rr?=
 =?utf-8?B?SjBWZk1vZG04RDhUcldmdUtOaXIveWhOdWV5MU5yalczZjdObm96djhWZkJk?=
 =?utf-8?B?OXlMTENOc2lRVnU5R3RBUFA2cVdRc0RVL1BCNE9OT3hzSlQ4RGcyNXhMZ1JL?=
 =?utf-8?B?bVh6a0JuZll2L0p4RFFuU3BRbzNmTDVNbXczQXcyaUU4bEhJM3U5VDNCZGNB?=
 =?utf-8?B?QXN0UWZXdlpQVFozWmlnMFpuVS9tVENwbzYzVVJUWWIvdHQrdXl2WHpUblBW?=
 =?utf-8?B?UE1tZndabHBMOUtVMS9qQWJRM05oNVQvQmw5d1c2ditZTUkxKzk3OGZIN2Ux?=
 =?utf-8?B?V3JFRnZHaHVvRVhLMzFVUzZvS05XV0pjM2R2YVYzSCtDQUp2bnVTcDM5T3Zs?=
 =?utf-8?B?L0xCTCt3VnZYcklRN2FKWnJEK2l6aVJyMmoxK3NzSkJWeGEyWEFQMDVYZldL?=
 =?utf-8?B?MW9HVHlaRDdvODFNbGh5ZFlsU2FGeXV6ZmtCMmlTbm1GN3BlTTN2OFZNSzFm?=
 =?utf-8?B?WmNZdHkwQUxubVE3MDRIcUFYRWtJMktHaTltZnFENzlneER6K3dRbXhCNVpp?=
 =?utf-8?B?UXE0bGQ1aW9ZRnVlNUYyMk5zYkZ5TlJLbXhaS1N2dWJuM3pnT29rcGJvV0da?=
 =?utf-8?B?S1UzdVVqWGpjV2NBR2ZrcFlhZDlXV29HR3hCS0FIa1Z2a3hTbzNqR3djRnFl?=
 =?utf-8?B?ckY3bHhUdklvaitsL1JqU2hpL1Y4aTk3TmcyM29MeUQ4b3B4Zm5DMVpYcnJz?=
 =?utf-8?B?U2VXTWdpSE03cEhmM3YwdXJ2WG5qdlYvbThLdnYwSjlnck5iMWFucGVoTHRr?=
 =?utf-8?B?UFdNWVpJa09XUXh1UHRYenVsSDVGajJ1S2twTzdyWElHKzQ2bi9yQzdnVjcz?=
 =?utf-8?B?TjUzVm9xZWhud2F3ODMyeE5UMmJTU010cHhsZUlKODhndzRyWUdyRnpzWTBJ?=
 =?utf-8?B?NzQvNnBTTnVSZkJhSGtPalppQjNMdkVCb1NoUkU3bVB3Ti80aW54Q1FwUGhC?=
 =?utf-8?B?QTY5d1E3WFhTRmVFd1l3Ukhxb2pRS1owQmlvQ0wxTDdSelV0VGp2SjhxU1E5?=
 =?utf-8?B?QU5kYW1BZXhnc1dLNTZaSEdlT3Y0RnJwY0ZBWVl5YVhiaXpPRUduOXRiY3FC?=
 =?utf-8?B?TmJXeWRUSzlYK3ZRcXhQeE95eDh0QXRpQzAxMW15L290ZlB0YmJ2NU5qV0RQ?=
 =?utf-8?B?eTA5MU5JUTNSTFlRVWl4NWJoTlV3TjM4ckZBZGZLVjduSlN3dGZPbnpBR3ZR?=
 =?utf-8?B?MGdGZEVpTE5oSlNPMmtUNVNzK1d2UEg5OXdMdFo2Tmp2NGJJd1BTVFhKZEhZ?=
 =?utf-8?Q?NjvN8RKld9ltYUQli91Z5/R+f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af86b8e-f4b5-4f9c-7cb0-08daded3e0c0
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 19:38:01.8398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7R9/fF7F+ugOBUkVRmbYeTcRVL/8PuiISCt4OfPXMYYfDCvwRyy0ZZrJjq3lxwKZVaO9Ibu8cq4AxdXSSqOcOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
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
 solomon.chiu@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------KRXK8YlmnytoA6Utt0jQqysH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/15/22 10:17, Harry Wentland wrote:
>
> On 12/15/22 05:29, Michel Dänzer wrote:
>> On 12/15/22 09:09, Christian König wrote:
>>> Am 15.12.22 um 00:33 schrieb Alex Hung:
>>>> On 2022-12-14 16:06, Alex Deucher wrote:
>>>>> On Wed, Dec 14, 2022 at 5:56 PM Alex Hung<alex.hung@amd.com>  wrote:
>>>>>> On 2022-12-14 15:35, Alex Deucher wrote:
>>>>>>> On Wed, Dec 14, 2022 at 5:25 PM Alex Hung<alex.hung@amd.com>  wrote:
>>>>>>>> On 2022-12-14 14:54, Alex Deucher wrote:
>>>>>>>>> On Wed, Dec 14, 2022 at 4:50 PM Alex Hung<alex.hung@amd.com>  wrote:
>>>>>>>>>> On 2022-12-14 13:48, Alex Deucher wrote:
>>>>>>>>>>> On Wed, Dec 14, 2022 at 3:22 PM Aurabindo Pillai
>>>>>>>>>>> <aurabindo.pillai@amd.com>  wrote:
>>>>>>>>>>>> From: Alex Hung<alex.hung@amd.com>
>>>>>>>>>>>>
>>>>>>>>>>>> [Why]
>>>>>>>>>>>> When running IGT kms_bw test with DP monitor, some systems crash from
>>>>>>>>>>>> msleep no matter how long or short the time is.
>>>>>>>>>>>>
>>>>>>>>>>>> [How]
>>>>>>>>>>>> To replace msleep with mdelay.
>>>>>>>>>>> Can you provide a bit more info about the crash?  A lot of platforms
>>>>>>>>>>> don't support delay larger than 2-4ms so this change will generate
>>>>>>>>>>> errors on ARM and possibly other platforms.
>>>>>>>>>>>
>>>>>>>>>>> Alex
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
>>>>>>>>> Why does sleep vs delay make a difference?  Is there some race that we
>>>>>>>>> are not locking against?
>>>>>>>>>
>>>>>>>>> Alex
>>>>>>>>>
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
>>>>>>> That's pretty ugly.  I'd rather try and resolve the root cause.  How
>>>>>>> important is the IGT test?  What does it do?  Is the test itself
>>>>>>> correct?
>>>>>>>
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
>>>>> What hangs?  The test or the kernel or the hardware?
>>>> The system becomes completely unresponsive - no keyboard, mouse nor remote accesses.
>>> I agree with Alex that changing this is extremely questionable and not justified at all.
>>>
>>> My educated guess is that by using mdelay() instead of msleep() we keep the CPU core busy and preventing something from happening at the same time as something else.
>>>
>>> This clearly points to missing locking or similar to protect concurrent execution of things.
>> Might another possibility be that this code gets called from an atomic context which can't sleep?
>>
>>
> It can come through handle_hpd_rx_irq but we're using a workqueue
> to queue interrupt handling so this shouldn't come from an atomic
> context. I currently don't see where else it might be used in an
> atomic context. Alex Hung, can you do a dump_stack() in this function
> to see where the problematic call is coming from?
>
> Fixing IGT will only mask the issue. Userspace should never be able
> to put the system in a state where it stops responding entirely. This
> will need some sort of fix in the kernel.
>
> Harry
>
>
I will drop this patch from the series.
--------------KRXK8YlmnytoA6Utt0jQqysH
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html data-lt-installed="true"><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body style="padding-bottom: 1px;">
    <p><font face="monospace"><br>
      </font></p>
    <div class="moz-cite-prefix"><font face="monospace">On 12/15/22
        10:17, Harry Wentland wrote:<br>
      </font></div>
    <blockquote type="cite" cite="mid:636f4287-803f-4cb9-dec0-2ffcc0f072d4@amd.com">
      <pre class="moz-quote-pre" wrap="">

On 12/15/22 05:29, Michel Dänzer wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On 12/15/22 09:09, Christian König wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Am 15.12.22 um 00:33 schrieb Alex Hung:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">On 2022-12-14 16:06, Alex Deucher wrote:
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">On Wed, Dec 14, 2022 at 5:56 PM Alex Hung <a class="moz-txt-link-rfc2396E" href="mailto:alex.hung@amd.com">&lt;alex.hung@amd.com&gt;</a> wrote:
</pre>
              <blockquote type="cite">
                <pre class="moz-quote-pre" wrap="">On 2022-12-14 15:35, Alex Deucher wrote:
</pre>
                <blockquote type="cite">
                  <pre class="moz-quote-pre" wrap="">On Wed, Dec 14, 2022 at 5:25 PM Alex Hung <a class="moz-txt-link-rfc2396E" href="mailto:alex.hung@amd.com">&lt;alex.hung@amd.com&gt;</a> wrote:
</pre>
                  <blockquote type="cite">
                    <pre class="moz-quote-pre" wrap="">On 2022-12-14 14:54, Alex Deucher wrote:
</pre>
                    <blockquote type="cite">
                      <pre class="moz-quote-pre" wrap="">On Wed, Dec 14, 2022 at 4:50 PM Alex Hung <a class="moz-txt-link-rfc2396E" href="mailto:alex.hung@amd.com">&lt;alex.hung@amd.com&gt;</a> wrote:
</pre>
                      <blockquote type="cite">
                        <pre class="moz-quote-pre" wrap="">On 2022-12-14 13:48, Alex Deucher wrote:
</pre>
                        <blockquote type="cite">
                          <pre class="moz-quote-pre" wrap="">On Wed, Dec 14, 2022 at 3:22 PM Aurabindo Pillai
<a class="moz-txt-link-rfc2396E" href="mailto:aurabindo.pillai@amd.com">&lt;aurabindo.pillai@amd.com&gt;</a> wrote:
</pre>
                          <blockquote type="cite">
                            <pre class="moz-quote-pre" wrap="">
From: Alex Hung <a class="moz-txt-link-rfc2396E" href="mailto:alex.hung@amd.com">&lt;alex.hung@amd.com&gt;</a>

[Why]
When running IGT kms_bw test with DP monitor, some systems crash from
msleep no matter how long or short the time is.

[How]
To replace msleep with mdelay.
</pre>
                          </blockquote>
                          <pre class="moz-quote-pre" wrap="">
Can you provide a bit more info about the crash?&nbsp; A lot of platforms
don't support delay larger than 2-4ms so this change will generate
errors on ARM and possibly other platforms.

Alex
</pre>
                        </blockquote>
                        <pre class="moz-quote-pre" wrap="">
The msleep was introduced in eec3303de3378 for non-compliant display
port monitors but IGT's kms_bw test can cause a recent h/w to hang at
msleep(60) when calling &quot;igt_remove_fb&quot; in IGT
(<a class="moz-txt-link-freetext" href="https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tests/kms_bw.c#L197">https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tests/kms_bw.c#L197</a>&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;
It is possible to workaround this by reversing order of
igt_remove_fb(&amp;buffer[i]), as the following example:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; igt_create_color_fb with the order buffer[0], buffer[1], buffer[2]

Hangs:
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; igt_remove_fb with the order buffer[0], buffer[1], buffer[2]

No hangs:
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; igt_remove_fb with the reversed order buffer[2], buffer[1], buffer[0]

However, IGT simply exposes the problem and it makes more sense to stop
the hang from occurring.

I also tried to remove the msleep completely and it also work, but I
didn't want to break the fix for the original problematic hardware
configuration.
</pre>
                      </blockquote>
                      <pre class="moz-quote-pre" wrap="">
Why does sleep vs delay make a difference?&nbsp; Is there some race that we
are not locking against?

Alex

</pre>
                    </blockquote>
                    <pre class="moz-quote-pre" wrap="">
That was my original thought but I did not find any previously. I will
investigate it again.

If mdelay(&gt;4) isn't usable on other platforms, is it an option to use
mdelay on x86_64 only and keep msleep on other platforms or just remove
the msleep for other platforms, something like

-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(60);
+#ifdef CONFIG_X86_64
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mdelay(60);
+#endif
</pre>
                  </blockquote>
                  <pre class="moz-quote-pre" wrap="">
That's pretty ugly.&nbsp; I'd rather try and resolve the root cause.&nbsp; How
important is the IGT test?&nbsp; What does it do?&nbsp; Is the test itself
correct?

</pre>
                </blockquote>
                <pre class="moz-quote-pre" wrap="">
Agreed, and I didn't want to add conditions around the mdelay for the
same reason. I will assume this is not an option now.

As in the previous comment, IGT can be modified to avoid the crash by
reversing the order fb is removed - though I suspect I will receive
questions why this is not fixed in kernel.

I wanted to fix this in kernel because nothing stops other user-space
applications to use the same way to crash kernel, so fixing IGT is the
second option.

Apparently causing problems on other platforms isn't an option at all so
I will try to figure out an non-mdelay solution, and then maybe an IGT
solution instead.
</pre>
              </blockquote>
              <pre class="moz-quote-pre" wrap="">
What hangs?&nbsp; The test or the kernel or the hardware?
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">
The system becomes completely unresponsive - no keyboard, mouse nor remote accesses.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">
I agree with Alex that changing this is extremely questionable and not justified at all.

My educated guess is that by using mdelay() instead of msleep() we keep the CPU core busy and preventing something from happening at the same time as something else.

This clearly points to missing locking or similar to protect concurrent execution of things.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Might another possibility be that this code gets called from an atomic context which can't sleep?


</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
It can come through handle_hpd_rx_irq but we're using a workqueue
to queue interrupt handling so this shouldn't come from an atomic
context. I currently don't see where else it might be used in an
atomic context. Alex Hung, can you do a dump_stack() in this function
to see where the problematic call is coming from?

Fixing IGT will only mask the issue. Userspace should never be able
to put the system in a state where it stops responding entirely. This
will need some sort of fix in the kernel.

Harry


</pre>
    </blockquote>
    <font face="monospace">I will drop this patch from the series.<br>
    </font>
  </body>
  <lt-container></lt-container>
</html>

--------------KRXK8YlmnytoA6Utt0jQqysH--
