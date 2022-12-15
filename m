Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C10C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Dec 2022 15:17:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67D1010E0E7;
	Thu, 15 Dec 2022 15:17:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA69510E0E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Dec 2022 15:17:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ud5a8XJSSlsOta9zf1T476saR+oU9JLeqP9b6OOCs/LfwPJR/sZiO27l3GTG4s9zNtXCYcCXEsLD91ry0G/4Bg1fVoHcbaT5r2AagxnPogPOeSrS0vBBYVIoJt9TTsVPHNODvmD+uWQLq1YgAQsf6hWlMkCYVEnQRwPKL7YHxX72CkZzL1nKauQMPrB2y2aP6apovu1ley4JgkdWnVY6zbesHcBXdgig/0vN5UdGoTwKHEafAkFn+brF3jR10ignQEqFZqsEq8oeYuF4+bh2Xxms59/JFDU03nBdc3+JSKdwZC1TL9a3GpSEGtgfyAIGi5Q+UYgvdHrj0Z3gZCt5Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVA1g+O5V5nj06RQYQfWHxpvbQKxuRR6CXyjZJ2Rh7I=;
 b=XvZet7zIb8FGAyoQb6x4ayQwcU/IirEEd+olxuIzVyQ3GhQX69boX7uVUodrvU+5aaCcBkbZ8o5dKIHwpRTd/sUF/9F2F6qazCHxw1Us863vXWO+/eFCGx6bJa9Sz2kp/x6ITssKyFY+6y01iKkviI2txyCxKKZJNZVB9Fqv11I7yiy1WpxgrcuvHUX1Zl3by52AH2TTpzYzVtUlLdkZPqJiLCr5vuIIhQu6PK06SW/ESaPYC2fP5UPIwqJBYXMDyjDf8sTIWKPx/WvoLCGF8QNTbO+q5oXxcyUttAgBMUw4HDfAOjNzWtMrAYiozcNj60iqSE9SWI+Cw9ARaW1XqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVA1g+O5V5nj06RQYQfWHxpvbQKxuRR6CXyjZJ2Rh7I=;
 b=UKNdVZ2iU4jsYkW+Zk7x7z0gDyJl4FLheEXiWDepaqFlIbCIsnVs8vizyOhAd/1n9Jj52qY6jybBvp79v+/9n4B1D74goYX+WCwf8j0Yf9f49O+bI8qCcVKuz6ILYliqpoylqLcya5to5RArYVMThwsye+v56KafUq8tkpy+LIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CH0PR12MB5107.namprd12.prod.outlook.com (2603:10b6:610:be::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Thu, 15 Dec
 2022 15:17:43 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::2d6a:70d0:eb90:9dca]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::2d6a:70d0:eb90:9dca%8]) with mapi id 15.20.5924.014; Thu, 15 Dec 2022
 15:17:43 +0000
Message-ID: <636f4287-803f-4cb9-dec0-2ffcc0f072d4@amd.com>
Date: Thu, 15 Dec 2022 10:17:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 05/18] drm/amd/display: Use mdelay to avoid crashes
Content-Language: en-US
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>,
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
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <e8801420-3212-702a-93dd-1b3f323bfd87@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0223.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::12) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|CH0PR12MB5107:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d0bcd15-b6ae-4968-005f-08dadeaf834e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /n2x7cmddbOdhToAWu7tlN0FrQzRQhqMGBf/JF789gaEQvusny4rRDtnOtFThrF9fi/j9V24DPUwVzDVlZrv2m3BmhImyd1Aqd8X4OMEQVS5qFR0OQ36zNDcvHRaScrWYP9jGDaS7D0Ug4glf6YCLPb5ahBc5IUmm62p8c++aPDxmvamVV4eGfdhWzyv2t5luUWUh4wpDMLtydEvjiKbpKTMrNbBGGDcCugnzEB4RAPvj38HhmuAlPlY3g5nV0PwjchWg9Y792+DMLP9WDW3XTRj0YFM0mhsUzc1Tctl7NZVGUOYKMQfNLIZLzmROeUgXXwGUpUwEMJNTKscZr/5ooT5DC5QVgiltrJy4tfUFUkcBVUJbifr5qN73RBABi1EQGQzfPiq7o+BYsS0JBF+KfdrO4LDb+6ohDghn5xjrRlx8jrsd0xgxMBhpkIwkKM3mFWsQUjdouLy+2MEALRF2X8O2V8Fq5GXuVjJFFq2ajWpG/lW1Mp+O1EQS56ymED5jzU1BRv7BnBL8ycQioP/7k+1IJ/OXv2Mcm0zs1tMe6nFQ5PW+y7X3V6+1/r6eAId0InHp/6zBkT2ZM0+VsYQ0/6ayFaO2nhajT48p9rxzFR1beJ0871wjN7idfliv0o6IMrCSAJXDIS5zWUzS6Y2FZhaCBm3+dIdpo3CphWXz1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199015)(26005)(2616005)(38100700002)(31686004)(83380400001)(66574015)(2906002)(186003)(4001150100001)(6512007)(44832011)(110136005)(31696002)(53546011)(6506007)(316002)(86362001)(6486002)(6666004)(478600001)(36756003)(41300700001)(8936002)(66476007)(66556008)(4326008)(66946007)(8676002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clkySk1KaEVuc1pyMnYxTk8zSHZ6a2ZESkY4aU5IcnJ0cXVSMTBQMHk2ZkJ3?=
 =?utf-8?B?VElqZ1J3Q3RscENVcUpOMWFVelR4VnpJcnN1dXN2N3lLdzhsQ29Fb3ZSQ2tm?=
 =?utf-8?B?VnpidXdVdW1IUVZZMjIzcEswY1c5Tlg2UDBoRjd5K2hiUGZlcXk3RHRQOFVG?=
 =?utf-8?B?S2xwL0d3VUN4bHF1YlJUb28yc01naW5OR0xDa0dIa21OR2k0RFJuNG00alVC?=
 =?utf-8?B?VEcyeHdBdVJFRGN2R1gzb3NvRDB0MnVGNHZVL0w3YXdzV2lVNlVQMG83VjZK?=
 =?utf-8?B?L2poYmFNckZjcFl5ZnllVjBIUWRzbW4xZEwzVDk5TjdzcUVtSy9sZXdnMjV4?=
 =?utf-8?B?S08rNGdQM3UySVQ4UCt6MWFCMDNQSHBqWnNUZzYrV1RNRUYrM3o1T29MOFJZ?=
 =?utf-8?B?NmpncHRvWEIvOXgxR045a0wyNlIvQ0ZETW5QUHN2c1I5TWcvVndtV3NDRnZ1?=
 =?utf-8?B?VFYrU2hGQ25nWHRjQ3FSTnJRc0dpcEdhWGNocjNpZ2xaMllLdW81SDU4TFlw?=
 =?utf-8?B?V2o5Y0Z4YkRTSzBrbG9rNlZrMmovcVdjeklTZmNSQUlJUWxjY3daaEw2RWk4?=
 =?utf-8?B?Z1JqZHFNejhocEl5SWVUNEtFc1JRb0l0MExHQlFaSnRXL1JCVGV4ZkFjMjJY?=
 =?utf-8?B?WnNVV0FIRkc4SFlkS0dVQ0NNT0J3K0EvYjlsa0VndW1PdS9rUkV5aGpBSEFF?=
 =?utf-8?B?Rmh0NGFJVHRNaHFqalF5UVF2eEhPZWZJSUI5QnNtY3pKVENJQi8zdnZCbEFV?=
 =?utf-8?B?cVdtSnMvcW9zMW9hbE0zZXN1SEthMVhZUnNJaWtUK1hBNVREWGt2TVlWekxT?=
 =?utf-8?B?WDFLWXhTMEtlWVgrK2FGeW9LZ0FXWkFRaEg4S3V0dmh3OENFUzlLVUhES0Z2?=
 =?utf-8?B?dGxjRDR6RCttTWJuWVA4bjFZTXk0ck51M2ZCVkJjb0RBa05tT0N0ZytaSWIr?=
 =?utf-8?B?bmhkNFJkOGh4Mk5tUWFLdXBVR2l2R3IxdjF5cXArNWxTNU9CMDhQOGxnY3Fk?=
 =?utf-8?B?MUFUZTN1c1pieE82RGVVcTVZRjVhOVRJTVRNd1R5U0lOdSs1K3NXM2JnazFt?=
 =?utf-8?B?bllVakRXOXpodzhDWHBlSkNidi9jcWh0bGtNZ0wrQjl1SnlkMEcvUEQ5dUhD?=
 =?utf-8?B?Y0tlZzdaTnZXTUNlWFdaM2FOM2V4b0RBV2kzblNKa0JCRVVFUkd0OHhhUncw?=
 =?utf-8?B?dUhIanNnQlNrbGpSSkRjZFo5ZFJkUjFVeWZ4akhXK0p1S01GMlMyY2ZFdVVB?=
 =?utf-8?B?MjRnYzlGaFZpbHltNmVNem1OWDFvOW1qbUdiVlRPM0NqWCtsNXRGUFdwUlpZ?=
 =?utf-8?B?VVR6Ykc4OGpiY2Frb1pTdWNxYlplRTk3NkZ3UUEyWXB1NlRuSnJYUjF4enoy?=
 =?utf-8?B?clFCQWRCWGEvMHZoQWZ3eGhEam1uN2tGWTFRSWNoUWREeDF3SlF0bU51bEtX?=
 =?utf-8?B?WmR6MlBjaU5YNUEwalN4L29xSHFUa1NUaTJ2MjZ1dWpHUVFORzNnRkFVbm5W?=
 =?utf-8?B?UEdzc2d3THJKVGRhNDdUZEZpRkRWdmR6Zy9Cblp6L3E2RUFTZWs5WTY5QkJ2?=
 =?utf-8?B?Y2xKUkdwTXZHeEZDdWU3YUhEQVBwMi9ScEpXeEpleFFpM3ZoMUZyRFV3QTBq?=
 =?utf-8?B?NVVWSHlHS1BNc2Z3cUZCL1UvVXJZZzRyTGlVSFc2SzdBbUZHdjV0TFVUVEZH?=
 =?utf-8?B?NFowQnFOeC9WVXg1aXhMdWdIaWtIYkNYVlQrVmVXbitERzVoc21zWlpUZmlq?=
 =?utf-8?B?QjVqcUZDTUVqSkE0bHZoeEorSUwvTk5oN1lPbnYxNTBjdHEyRXdYRldmZHpS?=
 =?utf-8?B?K3k2MDlIQm9GRnR0TlY0ZWUzMVppMllyQkI0VkNLT2t0OEhrc3R5bEQwNFky?=
 =?utf-8?B?a1pNblJ1UWhrb0xKZFhhL2Q0NVR4UW5KWlpaNFFINU5XVmIzYmFpMnBReEtN?=
 =?utf-8?B?V21DWC90M2tPOGpJRzVCS2ljbWZmbHpjM2hPU0x4SEExMmFIVUxsbnJHZU80?=
 =?utf-8?B?VFhKaFJZYVFSUjd3cnJzRHE5TWZCUTl1ODYwanFWcGY4aVR1ZkVuK3FzaXVi?=
 =?utf-8?B?dUlHT205d1cvTmlpQUIrTXBHUjQ5TkJDNG9FQkNyd1c3dlFxOEJBV2ZlekdD?=
 =?utf-8?Q?HfDSafX6e4//ZnysXngoL1ixc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0bcd15-b6ae-4968-005f-08dadeaf834e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 15:17:43.2572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GfvJPYs8BdcWvEBZLvHHBEOGWturBaqPBWq+qVmmZUmAac+g1hdzqnldQVPgVCSgJMT8BArLdUBMU6iFAK5UZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5107
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



On 12/15/22 05:29, Michel Dänzer wrote:
> On 12/15/22 09:09, Christian König wrote:
>> Am 15.12.22 um 00:33 schrieb Alex Hung:
>>> On 2022-12-14 16:06, Alex Deucher wrote:
>>>> On Wed, Dec 14, 2022 at 5:56 PM Alex Hung <alex.hung@amd.com> wrote:
>>>>> On 2022-12-14 15:35, Alex Deucher wrote:
>>>>>> On Wed, Dec 14, 2022 at 5:25 PM Alex Hung <alex.hung@amd.com> wrote:
>>>>>>> On 2022-12-14 14:54, Alex Deucher wrote:
>>>>>>>> On Wed, Dec 14, 2022 at 4:50 PM Alex Hung <alex.hung@amd.com> wrote:
>>>>>>>>> On 2022-12-14 13:48, Alex Deucher wrote:
>>>>>>>>>> On Wed, Dec 14, 2022 at 3:22 PM Aurabindo Pillai
>>>>>>>>>> <aurabindo.pillai@amd.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> From: Alex Hung <alex.hung@amd.com>
>>>>>>>>>>>
>>>>>>>>>>> [Why]
>>>>>>>>>>> When running IGT kms_bw test with DP monitor, some systems crash from
>>>>>>>>>>> msleep no matter how long or short the time is.
>>>>>>>>>>>
>>>>>>>>>>> [How]
>>>>>>>>>>> To replace msleep with mdelay.
>>>>>>>>>>
>>>>>>>>>> Can you provide a bit more info about the crash?  A lot of platforms
>>>>>>>>>> don't support delay larger than 2-4ms so this change will generate
>>>>>>>>>> errors on ARM and possibly other platforms.
>>>>>>>>>>
>>>>>>>>>> Alex
>>>>>>>>>
>>>>>>>>> The msleep was introduced in eec3303de3378 for non-compliant display
>>>>>>>>> port monitors but IGT's kms_bw test can cause a recent h/w to hang at
>>>>>>>>> msleep(60) when calling "igt_remove_fb" in IGT
>>>>>>>>> (https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tests/kms_bw.c#L197>>>>>>>>>>
>>>>>>>>> It is possible to workaround this by reversing order of
>>>>>>>>> igt_remove_fb(&buffer[i]), as the following example:
>>>>>>>>>
>>>>>>>>>       igt_create_color_fb with the order buffer[0], buffer[1], buffer[2]
>>>>>>>>>
>>>>>>>>> Hangs:
>>>>>>>>>       igt_remove_fb with the order buffer[0], buffer[1], buffer[2]
>>>>>>>>>
>>>>>>>>> No hangs:
>>>>>>>>>       igt_remove_fb with the reversed order buffer[2], buffer[1], buffer[0]
>>>>>>>>>
>>>>>>>>> However, IGT simply exposes the problem and it makes more sense to stop
>>>>>>>>> the hang from occurring.
>>>>>>>>>
>>>>>>>>> I also tried to remove the msleep completely and it also work, but I
>>>>>>>>> didn't want to break the fix for the original problematic hardware
>>>>>>>>> configuration.
>>>>>>>>
>>>>>>>> Why does sleep vs delay make a difference?  Is there some race that we
>>>>>>>> are not locking against?
>>>>>>>>
>>>>>>>> Alex
>>>>>>>>
>>>>>>>
>>>>>>> That was my original thought but I did not find any previously. I will
>>>>>>> investigate it again.
>>>>>>>
>>>>>>> If mdelay(>4) isn't usable on other platforms, is it an option to use
>>>>>>> mdelay on x86_64 only and keep msleep on other platforms or just remove
>>>>>>> the msleep for other platforms, something like
>>>>>>>
>>>>>>> -                       msleep(60);
>>>>>>> +#ifdef CONFIG_X86_64
>>>>>>> +                       mdelay(60);
>>>>>>> +#endif
>>>>>>
>>>>>> That's pretty ugly.  I'd rather try and resolve the root cause.  How
>>>>>> important is the IGT test?  What does it do?  Is the test itself
>>>>>> correct?
>>>>>>
>>>>>
>>>>> Agreed, and I didn't want to add conditions around the mdelay for the
>>>>> same reason. I will assume this is not an option now.
>>>>>
>>>>> As in the previous comment, IGT can be modified to avoid the crash by
>>>>> reversing the order fb is removed - though I suspect I will receive
>>>>> questions why this is not fixed in kernel.
>>>>>
>>>>> I wanted to fix this in kernel because nothing stops other user-space
>>>>> applications to use the same way to crash kernel, so fixing IGT is the
>>>>> second option.
>>>>>
>>>>> Apparently causing problems on other platforms isn't an option at all so
>>>>> I will try to figure out an non-mdelay solution, and then maybe an IGT
>>>>> solution instead.
>>>>
>>>> What hangs?  The test or the kernel or the hardware?
>>>
>>> The system becomes completely unresponsive - no keyboard, mouse nor remote accesses.
>>
>> I agree with Alex that changing this is extremely questionable and not justified at all.
>>
>> My educated guess is that by using mdelay() instead of msleep() we keep the CPU core busy and preventing something from happening at the same time as something else.
>>
>> This clearly points to missing locking or similar to protect concurrent execution of things.
> Might another possibility be that this code gets called from an atomic context which can't sleep?
> 
> 

It can come through handle_hpd_rx_irq but we're using a workqueue
to queue interrupt handling so this shouldn't come from an atomic
context. I currently don't see where else it might be used in an
atomic context. Alex Hung, can you do a dump_stack() in this function
to see where the problematic call is coming from?

Fixing IGT will only mask the issue. Userspace should never be able
to put the system in a state where it stops responding entirely. This
will need some sort of fix in the kernel.

Harry


