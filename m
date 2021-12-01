Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64EBBC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 07:28:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1BCF6E974;
	Wed,  1 Dec 2021 07:28:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F13F76E9CE
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 07:28:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+EaL3PiqF+Kc+8egfhKu18lkO/7KaF7BPcWfiMN2BYPmOb+MimiLI+B1mHpCq1lVsRBTicTeJqZJiZl6kAqhjk+1d3fpGx4WnHuSIDQK/CUFmjB55gqf9t5ajdcTjQb+6XrtRV9pyZXVlDfwLowdBOho+jWpOePmRRsnPXeSSOo/SXmB6KHpcVd9u+dK6roOcd7QtAabYk/PVR0kS2sz3AlO+TeEEb/qnT6+HQdthHkiXi8tFzmt/R6UxgKrGUUBVOv4jYNue0mxVe1lyvpoVezXyHVXVRuok74kqQlGZsNV3dhFdfHnJAWNg805+eHO+43Sj6PF8LHdaUP8Qg7qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLszENMi/S6xPkU/TOwPuHB5pkEwnmglRXtHji02WWU=;
 b=mO7D8e6XAKSp5IIBeIvVpT8mQNZIcO7yR1t8xGy1DiezQg90wolHYcr2Zt3TQSc5MrcwMQEvJA83w2Xh+IweVnY5twvbL/mPsU4gEeLdXyUUwfThYMdnARJRtr819iNmzwgadMOyPLcBN6GbRsmM1gLqA++eufU2Of2Xt5EQC7prIgOMTZSLkz2OGbKgHeLhkAFeJw4G3QaRYgZaTuHCPJ8nY4rFjXkzpmD5GLkRdKnD6LWY5k2yADCauVTFTwhC24gDIBGX8g005yMisnMx90eFWiNiL0JOcfveWzQ+Dr40Ua0lcxD74vTQ5tJ+zO/uvxZiW5ttGFJidhEkLCnIrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLszENMi/S6xPkU/TOwPuHB5pkEwnmglRXtHji02WWU=;
 b=1u2aGc6mmC83wMpV+Lq4K9X2+T4hocs+MfjxpCFAC/YnzNpXAY81vbHbQAfSl1qAE9jX8C4L2I8HH2VH/JQoFOB2cBf2AwNiCeEHVoK2QrDf0zNyVlFfupgq8XBKQflfnPAhIP7Oq86UBbpgXUMsmngYwyxasV5N+ZLVjMxOGZ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB1242.namprd12.prod.outlook.com (2603:10b6:3:6d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 07:28:30 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 07:28:30 +0000
Message-ID: <891c0f73-4f2d-4cb2-b969-c68491362509@amd.com>
Date: Wed, 1 Dec 2021 12:58:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] drm/amdgpu: add SMU debug option support
Content-Language: en-US
To: "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211130051721.3192979-1-lang.yu@amd.com>
 <53f6a9da-9197-3cfd-3d9c-586dbad4584c@amd.com>
 <DM6PR12MB39306D37D616E811E56A1E6297689@DM6PR12MB3930.namprd12.prod.outlook.com>
 <DM6PR12MB4250B9CF078EF70E804BCA1FFB689@DM6PR12MB4250.namprd12.prod.outlook.com>
 <19b5cf3c-9ced-4abb-6d33-f5c4408a6e25@amd.com>
 <DM6PR12MB4250B223A492C9BB6B55C46AFB689@DM6PR12MB4250.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB4250B223A492C9BB6B55C46AFB689@DM6PR12MB4250.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::25) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN1PR01CA0085.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:1::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.24 via Frontend Transport; Wed, 1 Dec 2021 07:28:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13dc07ec-5aaa-4127-7d1b-08d9b49c2c50
X-MS-TrafficTypeDiagnostic: DM5PR12MB1242:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1242EBDD26C7F7A9F36F162997689@DM5PR12MB1242.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DzbG+u8XGdp3zdilu46cbFyvzf3aQAbNQdZLbRosIv3+MWCQHtZnxwe6Ux5Ztp3NcMv6UD357KIRQgKTuVfjPPGP7agL4LLkKlrwpzgW6n0tx168jvNXeQKvNkrQMKER2hi1ojfF8CwGqiGIVP1e/4b0kaI3RAnsyUE70GIq/KAMvm2x202AwieoJdYxXP6FhJiHj3CTOs3rxU4krqgz0OjtcGBbCVaRMbdONNcEiTLqlZWwdvyJ6yfe0MwrYBpWWAw2MfPVtx0gLEiGAgbe1GjHfcDoDS0d74y//IDIxrS06mYmItozXgTrLKfo5z9XXJsTaf+TsZDTyRFOZAJ7PDS5rV6tEv0gYUpbBHBmddzfIKmcYLJTYgafcMhqxvxButeTIMIbwxw6drztqUmni4LlsNMWyt2dN6zrw3lDxdoCpFALIXHNeCKmONkWoE96+JwpYHAZLjPTCIfVnVf6s5MoC84bR8EFO4z1WByh2qFpC4QFRK0XqwPIPisLZKB8e92SXDaunqmWV3MEFbiKRLmkL11PnB9HS17ySdfdVjr5D4zuYlhTlYv/3w+11wBGORlzOfJWjGg7DPQRtMaGY5Ugc02r5okBV5SMcgIek9/QFdbcS7sQERU45duLg7gutZDeMazp0VyjLENFvq4ZwoE8Gy5fyDgfKnxVGjEg9ji8ZQAb1DLe4oTUK2Jm8PdSqUzn8VGWqOKEtLht/Ik6U29j46PoAN7/wLpJsITdexMyGjD/2eG0AFawarIsDYW6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(16576012)(8676002)(83380400001)(38100700002)(31686004)(86362001)(6486002)(110136005)(30864003)(53546011)(8936002)(54906003)(2616005)(316002)(5660300002)(186003)(2906002)(36756003)(508600001)(26005)(4326008)(956004)(31696002)(66946007)(6666004)(66556008)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHpYSEhVV2t5Ykt4ZytMcjhGVnIwMFRKdHhPaGtzTmNLTmpLSjl1eUllOUZM?=
 =?utf-8?B?NDkzcjN5UmZaZXlEeDZJbG91OXlLbnBiVWdIMFB1M05tSU92TjZENlNiRm9u?=
 =?utf-8?B?Zm1XY21zcngzMkhNRmxycUhOSlZaRG1GRjFtUC9zekxiTlVLZk5nbURMNjhI?=
 =?utf-8?B?UlZ3aUg1ak43RXc3TXlzTE5zNVZpZGwySkFyY3ZDQWxpbEEvRUw3ZjlHSiti?=
 =?utf-8?B?TW1NNVJEWjQvZmRQVWNkMFMyaUZ3UHBLRnhFV1RhSGV1RUl5RUNXa2FrRzky?=
 =?utf-8?B?a21JNFB0M3NvdG1PUyszZVU0SUQ0Uk9CVHJHb0pRVjIyeDJZSVpQN2FFSjdT?=
 =?utf-8?B?VEpUck5qd1pRSEZ4NythME02ak9sOEttMm5SNDRKWkRuSkw1VXpLL0dOV2Rh?=
 =?utf-8?B?QUVNakxTS2JHb2gydHdsb25pa0d6alZra0NYSWx4YlNuc3puNWNKQ2tqaHdN?=
 =?utf-8?B?ZW82L0QvdkRWZlhVUFFiZ056TXQ4T3ZEVmF6TnBFZUEzYWsyRmJzUk9XRGxP?=
 =?utf-8?B?cS9OdjkzTnRIVkF4ZjdIbXNlS095ZTVpZ1RNM0ErSHZmcVFPdG50Njd6QWhn?=
 =?utf-8?B?WjN4Tko0TURXRFRqVXRpUlh5YXEwTmpUbnRGWjAyVU1lQVJjR1RYNHU1WWtx?=
 =?utf-8?B?VlBSZVQycHBUZEt0NzlCWTh1M2JQWEJabDBjTTBtajk1T1ZxekorTEdHYktZ?=
 =?utf-8?B?bTdEWE9WTXZwUzBBVXBxSjM1TTRmVGh0OFVQczlMYzNLVFM1K1dxcGRSOWlu?=
 =?utf-8?B?WWI3bEUwazI4NXp4eGRIQkk5K3hyTzV5T2Ewb0F4dEtlYmpMS2xLRFJFakx5?=
 =?utf-8?B?TFBucUpybGc4ZUk5U2NsSzFIaHFFd2dJbXpKS0ZwdzVUQVBOWnJGZ2JJVlJk?=
 =?utf-8?B?NEJ6c0tCcVFDd0IwQlE3U243NG04aW9wbW1KRjlkYjJMRkNjM0l0dzBjalpu?=
 =?utf-8?B?RTBzRXY2dVM4bDlzVjhqSUlSRXFpbWtMUUl6TzltdFZRa040Ly91TGRJcDBv?=
 =?utf-8?B?eEZPVmd4UE50aFhsSVNYdnpqeTUwVysxajQyM2FQSnlPMjlHTTdXeU94c2t1?=
 =?utf-8?B?aEdvR3dVcDB0eVRPMjA3Q0FrVEExZ3E5KzN0VExTOFZER3lJbEpFZ3NITzRk?=
 =?utf-8?B?bVFPL2NhNkFIKzVITUExVkxvWWhVcnltekRiMDBoTDFEdHBpMlRDS0lMNExK?=
 =?utf-8?B?NHpNS1dsSkY1NENDdE05QjdPUVJtakVEQkk5VjA5UXpMdnRyNjlzUFoyRjMx?=
 =?utf-8?B?MXJSRlZGUS9PdlhzZTRTcUxEeFF6RHd0V2FEaVpQT0lJUGtqUzJtRjJWRWR0?=
 =?utf-8?B?d2lzNjVQTUNDMkVCdkhwa2pMelAyV3hrL2Z1MDlRcUEwbE5jZ21ad0pSMUdw?=
 =?utf-8?B?Y1BpTUhqQnVIQ1UwYVNxZStsZk1GU0EwWjdiaGxTUzBWWFdRNXBHNmo2NHRa?=
 =?utf-8?B?SEdtbzVJTWg0QnVIaXhiRVRLTGVDLzkxQWJMczR3VDhsM0hFOHdGbW5CK3Z3?=
 =?utf-8?B?eHhvY0pJZDlmYTgzaldXb0gzMmhUVVdER3psY3h1eFpZWnhlNE1CUGlqNzdY?=
 =?utf-8?B?eXlmOS9iU3d4eVJCdTBIcjB5b2QyVFBHLy9aZVBhMUdibFh1WUdPSUFWeHYx?=
 =?utf-8?B?eGpnZ2ZSenZmdm5QYkZGYTFrV1ljbFQvOFNtN3RPUTJPZGJpaUdiRGMwQXc1?=
 =?utf-8?B?ejZSRTlvaHdZQ2tSczhpY0VoZFhRbTJkZE1iZkdTWFJKRm1EQlFWdDd0ck1I?=
 =?utf-8?B?bDdnZHEzTTBXWFFyM0t5UlZNYWk4aVN6TzQrRGN0UXZ3bmRRYkp4cXlraWxp?=
 =?utf-8?B?VTI2TXJyTERKZzJZcmRyQWp0bHhnQmRGNzc3UGFsWDNtNTFNMkRXTHNFdXZa?=
 =?utf-8?B?VlJvTUhUN1dOekVhUFhrWHhqZFJjdlBYRlVKMXFkQ1dsSGFRcCs0eUNRT3Yy?=
 =?utf-8?B?Ynhtc21CcEVsRjFNK3JxWXpzVU4xWEVJZEEyKytCZDJKd1J5dEMwcS9sWWVL?=
 =?utf-8?B?d1VWelI4U2xDWFp6T2JVMEsrdFJjODBuNUNwRGsrdnJtajJuK0x4T0MwbVd6?=
 =?utf-8?B?RkZxRGdpY25VMysxdnRnN05TL3ZGbnFoMjF6QUNGUFVHQ1BNNGV0NDlnKzBW?=
 =?utf-8?Q?sHDw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13dc07ec-5aaa-4127-7d1b-08d9b49c2c50
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 07:28:30.4653 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ZgUlwRKU3KtcdHntfNNqT1diAtXKB6SpRy5R5ugQexVZukHjgMjUXJ4X/3baMWB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1242
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
 Ray" <Ray.Huang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/1/2021 12:37 PM, Yu, Lang wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Wednesday, December 1, 2021 2:56 PM
>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>> <Ray.Huang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: add SMU debug option support
>>
>>
>>
>> On 12/1/2021 11:57 AM, Yu, Lang wrote:
>>> [AMD Official Use Only]
>>>
>>> Hi Lijo,
>>>
>>> Thanks for your comments.
>>>
>>>   From my understanding, that just increases the timeout threshold and
>>> could hide some potential issues which should be exposed and solved.
>>>
>>> If current timeout threshold is not enough for some corner cases,
>>> (1) Do we consider to increase the threshold to cover these cases?
>>> (2) Or do we just expose them and request SMU FW to optimize them?
>>>
>>> I think it doesn't make much sense to increase the threshold in debug mode.
>>> How do you think? Thanks!
>>
>> In normal cases, 2secs would be more than enough. If we hang immediately, then
>> check the FW registers later, the response would have come. I thought we just
>> need to note those cases and not to fail everytime. Just to mark as a red flag in
>> the log to tell us that FW is unexpectedly busy processing something else when
>> the message is sent.
>>
>> There are some issues related to S0ix where we see the FW comes back with a
>> response with an increased timeout under certain conditions.
> 
> If these issues still exists, could we just blacklist the tests that triggered them
> before solve them? Or we just increase the threshold to cover all the cases?
> 

Actually, the timeout is message specific - like i2c transfer from 
EEPROM could take longer time.

I am not sure if we should have more than 2s as timeout. Whenever this 
kind of issue happens, FW team check registers (then it will have a 
proper value) and say they don't see anything abnormal :) Usually, those 
are just signs of crack and it eventually breaks.

Option is just fail immediately (then again not sure useful it will be 
if the issue is this sort of thing) or wait to see how far it goes with 
an added timeout before it fails eventually.

Thanks,
Lijo

> Regards,
> Lang
> 
>>
>> Thanks,
>> Lijo
>>
>>>
>>> Regards,
>>> Lang
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Wednesday, December 1, 2021 1:44 PM
>>>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Yu, Lang <Lang.Yu@amd.com>;
>>>> amd- gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>>>> <Ray.Huang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
>>>> Subject: RE: [PATCH] drm/amdgpu: add SMU debug option support
>>>>
>>>> Just realized that the patch I pasted won't work. Outer loop exit
>>>> needs to be like this.
>>>> 	(reg & MP1_C2PMSG_90__CONTENT_MASK) != 0 && extended_wait-- >=
>>>> 0
>>>>
>>>> Anyway, that patch is only there to communicate what I really meant
>>>> in the earlier comment.
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>> -----Original Message-----
>>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>>> Lazar, Lijo
>>>> Sent: Wednesday, December 1, 2021 10:44 AM
>>>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>>>> <Ray.Huang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
>>>> Subject: Re: [PATCH] drm/amdgpu: add SMU debug option support
>>>>
>>>>
>>>>
>>>> On 11/30/2021 10:47 AM, Lang Yu wrote:
>>>>> To maintain system error state when SMU errors occurred, which will
>>>>> aid in debugging SMU firmware issues, add SMU debug option support.
>>>>>
>>>>> It can be enabled or disabled via amdgpu_smu_debug debugfs file.
>>>>> When enabled, it makes SMU errors fatal.
>>>>> It is disabled by default.
>>>>>
>>>>> == Command Guide ==
>>>>>
>>>>> 1, enable SMU debug option
>>>>>
>>>>>     # echo 1 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
>>>>>
>>>>> 2, disable SMU debug option
>>>>>
>>>>>     # echo 0 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
>>>>>
>>>>> v2:
>>>>>     - Resend command when timeout.(Lijo)
>>>>>     - Use debugfs file instead of module parameter.
>>>>>
>>>>> Signed-off-by: Lang Yu <lang.yu@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 32
>> +++++++++++++++++
>>>>>     drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c      | 39
>> +++++++++++++++++++-
>>>> -
>>>>>     2 files changed, 69 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> index 164d6a9e9fbb..f9412de86599 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> @@ -39,6 +39,8 @@
>>>>>
>>>>>     #if defined(CONFIG_DEBUG_FS)
>>>>>
>>>>> +extern int amdgpu_smu_debug;
>>>>> +
>>>>>     /**
>>>>>      * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes
>>>>>      *
>>>>> @@ -1152,6 +1154,8 @@ static ssize_t
>>>>> amdgpu_debugfs_gfxoff_read(struct
>>>> file *f, char __user *buf,
>>>>>     	return result;
>>>>>     }
>>>>>
>>>>> +
>>>>> +
>>>>>     static const struct file_operations amdgpu_debugfs_regs2_fops = {
>>>>>     	.owner = THIS_MODULE,
>>>>>     	.unlocked_ioctl = amdgpu_debugfs_regs2_ioctl, @@ -1609,6
>>>>> +1613,26 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>>>>     DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>>>>     			amdgpu_debugfs_sclk_set, "%llu\n");
>>>>>
>>>>> +static int amdgpu_debugfs_smu_debug_get(void *data, u64 *val) {
>>>>> +	*val = amdgpu_smu_debug;
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static int amdgpu_debugfs_smu_debug_set(void *data, u64 val) {
>>>>> +	if (val != 0 && val != 1)
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	amdgpu_smu_debug = val;
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +DEFINE_DEBUGFS_ATTRIBUTE(fops_smu_debug,
>>>>> +			 amdgpu_debugfs_smu_debug_get,
>>>>> +			 amdgpu_debugfs_smu_debug_set,
>>>>> +			 "%llu\n");
>>>>> +
>>>>>     int amdgpu_debugfs_init(struct amdgpu_device *adev)
>>>>>     {
>>>>>     	struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
>>>>> @@ -1632,6 +1656,14 @@ int amdgpu_debugfs_init(struct amdgpu_device
>>>> *adev)
>>>>>     		return PTR_ERR(ent);
>>>>>     	}
>>>>>
>>>>> +	ent = debugfs_create_file("amdgpu_smu_debug", 0600, root, adev,
>>>>> +				  &fops_smu_debug);
>>>>> +	if (IS_ERR(ent)) {
>>>>> +		DRM_ERROR("unable to create amdgpu_smu_debug debugsfs
>>>> file\n");
>>>>> +		return PTR_ERR(ent);
>>>>> +	}
>>>>> +
>>>>> +
>>>>>     	/* Register debugfs entries for amdgpu_ttm */
>>>>>     	amdgpu_ttm_debugfs_init(adev);
>>>>>     	amdgpu_debugfs_pm_init(adev);
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> index 048ca1673863..b3969d7933d3 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> @@ -55,6 +55,14 @@
>>>>>
>>>>>     #undef __SMU_DUMMY_MAP
>>>>>     #define __SMU_DUMMY_MAP(type)	#type
>>>>> +
>>>>> +/*
>>>>> + * Used to enable SMU debug option. When enabled, it makes SMU
>>>>> +errors
>>>> fatal.
>>>>> + * This will aid in debugging SMU firmware issues.
>>>>> + * (0 = disabled (default), 1 = enabled)  */ int amdgpu_smu_debug;
>>>>> +
>>>>>     static const char * const __smu_message_names[] = {
>>>>>     	SMU_MESSAGE_TYPES
>>>>>     };
>>>>> @@ -272,6 +280,11 @@ int smu_cmn_send_msg_without_waiting(struct
>>>> smu_context *smu,
>>>>>     	__smu_cmn_send_msg(smu, msg_index, param);
>>>>>     	res = 0;
>>>>>     Out:
>>>>> +	if (unlikely(amdgpu_smu_debug == 1) && res) {
>>>>> +		mutex_unlock(&smu->message_lock);
>>>>> +		BUG();
>>>>> +	}
>>>>> +
>>>>>     	return res;
>>>>>     }
>>>>>
>>>>> @@ -288,9 +301,17 @@ int smu_cmn_send_msg_without_waiting(struct
>>>> smu_context *smu,
>>>>>     int smu_cmn_wait_for_response(struct smu_context *smu)
>>>>>     {
>>>>>     	u32 reg;
>>>>> +	int res;
>>>>>
>>>>>     	reg = __smu_cmn_poll_stat(smu);
>>>>> -	return __smu_cmn_reg2errno(smu, reg);
>>>>> +	res = __smu_cmn_reg2errno(smu, reg);
>>>>> +
>>>>> +	if (unlikely(amdgpu_smu_debug == 1) && res) {
>>>>> +		mutex_unlock(&smu->message_lock);
>>>>> +		BUG();
>>>>> +	}
>>>>> +
>>>>> +	return res;
>>>>>     }
>>>>>
>>>>>     /**
>>>>> @@ -328,6 +349,7 @@ int smu_cmn_send_smc_msg_with_param(struct
>>>> smu_context *smu,
>>>>>     				    uint32_t param,
>>>>>     				    uint32_t *read_arg)
>>>>>     {
>>>>> +	int retry_count = 0;
>>>>>     	int res, index;
>>>>>     	u32 reg;
>>>>>
>>>>> @@ -349,15 +371,28 @@ int smu_cmn_send_smc_msg_with_param(struct
>>>> smu_context *smu,
>>>>>     		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
>>>>>     		goto Out;
>>>>>     	}
>>>>> +retry:
>>>>>     	__smu_cmn_send_msg(smu, (uint16_t) index, param);
>>>>>     	reg = __smu_cmn_poll_stat(smu);
>>>>>     	res = __smu_cmn_reg2errno(smu, reg);
>>>>> -	if (res != 0)
>>>>> +	if (res != 0) {
>>>>>     		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
>>>>> +		if ((res == -ETIME) && (retry_count++ < 1)) {
>>>>> +			usleep_range(500, 1000);
>>>>> +			dev_err(smu->adev->dev,
>>>>> +				"SMU: resend command: index:%d
>>>> param:0x%08X message:%s",
>>>>> +				index, param, smu_get_message_name(smu,
>>>> msg));
>>>>> +			goto retry;
>>>>> +		}
>>>>> +		goto Out;
>>>>> +	}
>>>>
>>>> Sorry, what I meant is to have an extended wait time in debug mode.
>>>> Something like below, not a 'full retry' as in sending the message again.
>>>>
>>>>
>>>> +#define MAX_DBG_WAIT_CNT 3
>>>> +
>>>>    /**
>>>>     * __smu_cmn_poll_stat -- poll for a status from the SMU
>>>>     * smu: a pointer to SMU context
>>>> @@ -115,17 +117,24 @@ static void smu_cmn_read_arg(struct smu_context
>>>> *smu,
>>>>    static u32 __smu_cmn_poll_stat(struct smu_context *smu)
>>>>    {
>>>>           struct amdgpu_device *adev = smu->adev;
>>>> -       int timeout = adev->usec_timeout * 20;
>>>> +       int timeout;
>>>>           u32 reg;
>>>> +       int extended_wait = smu_debug_mode ? MAX_DBG_WAIT_CNT : 0;
>>>>
>>>> -       for ( ; timeout > 0; timeout--) {
>>>> -               reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
>>>> -               if ((reg & MP1_C2PMSG_90__CONTENT_MASK) != 0)
>>>> -                       break;
>>>> +       do {
>>>> +               timeout = adev->usec_timeout * 20;
>>>> +               for (; timeout > 0; timeout--) {
>>>> +                       reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
>>>> +                       if ((reg & MP1_C2PMSG_90__CONTENT_MASK) != 0)
>>>> +                               break;
>>>>
>>>> -               udelay(1);
>>>> -       }
>>>> +                       udelay(1);
>>>> +               }
>>>> +       } while (extended_wait-- >= 0);
>>>>
>>>> +       if (extended_wait != MAX_DBG_WAIT_CNT && reg != SMU_RESP_NONE)
>>>> +               dev_err(adev->dev,
>>>> +                       "SMU: Unexpected extended wait for
>>>> + response");
>>>>           return reg;
>>>>    }
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>>     	if (read_arg)
>>>>>     		smu_cmn_read_arg(smu, read_arg);
>>>>>     Out:
>>>>>     	mutex_unlock(&smu->message_lock);
>>>>> +
>>>>> +	BUG_ON(unlikely(amdgpu_smu_debug == 1) && res);
>>>>> +
>>>>>     	return res;
>>>>>     }
>>>>>
>>>>>
