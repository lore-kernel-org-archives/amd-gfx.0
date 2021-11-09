Return-Path: <SRS0=P/1w=P4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8902DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 07:44:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4284D61029
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 07:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4284D61029
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C60A36E7D3;
	Tue,  9 Nov 2021 07:44:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 421D26E7D3
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Nov 2021 07:44:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4Yxd0upBRbi38tA4NYtV7d82CkIB3uw2Wwd05BJ0rn9xV2qbaFr3VCvcfDlAqbxx1Toa1lrJlva2BmM/q/+rb/ouS5kb4DboJec4NINdQvNZAH3OR/So6UzLlh1GSMii1A0p3wxotM/8JHxasr52ybsG7S62kCZCta88dTWAL59nmXe4ZEt98KVqOoXqGtt3LiRGKuEhE2ltxqt0FWyKBy9hZiSypueGrH51VpfYX1At/to1PNi/+jAI1KIFLtnVBfNtZZ/eW75HRyZWgORXCuUrE9hRRRF1lG/NfKzu/UbaFs7KNHB6p44oRaxiAGajvXeKBZFhyJ1dM0Kf83yiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fw8rB5AV8IeoYHQgGgXHNdsf4ceG48T8VW7lpTxpOww=;
 b=hqTMTBEW3D1KfuqRR0rUkNIdEpKatzkj2ftUsduGR0o00jo/jlzg56a2zBBB2CeRH7z+Ob/EultsuPFmt5wW4tchZPWN7iNjUX7GGR/aixUAWBMEMo1sWltBqkV1BIhDqSVLb1gb37xZsoYvtsXV/CW3bMBEzsFRNcsl1qex4rpkllZxCEkhg0u4sX2Ls3uVH2Gi0a6vutAHMNMEX+fSucdWvsqj+yKGqcI+pfsKOs+UmbJL/gJPlUN1zyVOJto8kai0AT2YGjrM7AI06yKiK86dlIhG5VjJg1cJtQdOVcxUS6f82pOGYh0zTFrqH5Y2pjixDJF1gSkHxQGNImecfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fw8rB5AV8IeoYHQgGgXHNdsf4ceG48T8VW7lpTxpOww=;
 b=25I6xE1EwYYEfknCAwerFig+Og2p+yPkHZNXR9/WZQfBbG5GuEq3NkisoO9HQToQVy3PThXubSCHIkdhXjIBbPI2xYdK+AEv3P2PRp1WLSxnQZ4KU8ig1ArzBvEV6o//ecRNTauMfOWnj5CQBlEwRquS2IsakA2MNHv82EZFiLw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR12MB1677.namprd12.prod.outlook.com
 (2603:10b6:301:11::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Tue, 9 Nov
 2021 07:44:18 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769%5]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 07:44:17 +0000
Subject: Re: [PATCH] drm/amd/pm: avoid duplicate powergate/ungate setting
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Borislav Petkov <bp@suse.de>,
 Paul Menzel <pmenzel@molgen.mpg.de>, "Liu, Leo" <Leo.Liu@amd.com>
References: <20211108044723.54716-1-evan.quan@amd.com>
 <427ace3e-ba04-bd5c-4eef-d83147ef288e@molgen.mpg.de>
 <YYkGteomN5Cbh1+C@zn.tnic> <3800b659-f0cb-2565-c525-91b5b34d1a30@amd.com>
 <d35eca15-df36-5885-ca31-a1bd50f09fdf@amd.com>
 <a1bfc35c-c987-38b4-e7b7-16c9b9295635@amd.com>
 <00fc5d97-5228-1935-a544-91f2a9b1b803@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <dd7aaabf-0c32-1db4-0105-c6181a8923b3@amd.com>
Date: Tue, 9 Nov 2021 08:44:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <00fc5d97-5228-1935-a544-91f2a9b1b803@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0128.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::45) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [192.168.178.21] (79.194.4.163) by
 AM0PR10CA0128.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11 via Frontend Transport; Tue, 9 Nov 2021 07:44:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52caaa13-8bb1-43c0-c730-08d9a354bbd5
X-MS-TrafficTypeDiagnostic: MWHPR12MB1677:
X-Microsoft-Antispam-PRVS: <MWHPR12MB167782533CEC98B29BD92DD583929@MWHPR12MB1677.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4rygAtBtzT8XsRNz+9AR2lwgX1saE5NTBSKV9SwJ6JaAQywSJWa19z8Wh2UUXDBUnPiCCoA/l/ur5xZUHhHu6N4roawd6SkptKPPAilHogwKvbUTwmF9lGr6uTCq6pn9yXEthsvtkyDueYmz7WBECYRnHIDIrA2nBJD1p40dy9Cfg4lxcZtUsbbqtRkD1zyaXko+45rd4Yq6OBjfB11bUvAwgqGk9UET99LMklPWJQfGE3cuvngr9mR0KDD2gyktgD3R/QHMeT+cg8J4d8PqzvrEif2T52xZdyU2BLAlitWGqm19s/MMkG4TJy8417qb/QmhvMAreVJk/W2BLFzh+W2Pq3xdBZ2jI9w1xu+C/1RNckXRIUf63oIvgNntn6woxUS+IBtFDEu7eK4Jffr+QfIjlCZEMZ+khEZUFndX8ixNb4XL4g3p8ZLxNFR6K0KevONMtxCgRxAtQeX4vrQzw8LqwexxRregcKsEkybii8gLmSQtoGbCneQRaHm6oBEy5/XbZRjDrhIT96Z3yKH6DtmIcY36hpqo8pd4tJvouzOQ8kyGPlCvzVyeB5l7UHOc7G8MJVlOnKMMc38/x2hm4s4FeS09hugn9jLOFi+irG/4VXD/zMPko4RPYrnbpEpBVi/OUgNll32n4QSBi2HHrRN7clSm0ySaXprOLY0PgLQp3nrIrCNCILkPm9nmou3/ojpe6CZjvcrY+cDpXa8body6mZ8rSGD17JU+7g9O51AhSvgGOahpe1xKkBUrVTKLcTxqSspVotiq5Ub1Exjj8GJW1ztjmrJHxRjYUXFsYS8loYN9S2inJD9I1QlLUZgT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(31686004)(83380400001)(966005)(316002)(508600001)(66556008)(6636002)(6666004)(2906002)(5660300002)(36756003)(31696002)(186003)(956004)(38100700002)(2616005)(66946007)(86362001)(8676002)(110136005)(6486002)(66476007)(4326008)(16576012)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU1kcVRqUTl2RkR3cnh6UGdEQkRnVWk4RmFkSkFwYk1sVndEZEJVZlo2aXNY?=
 =?utf-8?B?WTBCMC9sbElqQWRzeU9qQldWbnd2ajN6Rjg2SnFycytGKzY0OGxmRktKakdW?=
 =?utf-8?B?d3JkS2F2YnBTdEZOSlhjLzcyRUJTSWdzUHdjZ3UrRWRWQjhNOUVSZ1BncXJK?=
 =?utf-8?B?RHJqV1o0dU00WVN4SS9nSmFqWXJpRDJxSFd3U2VjRWMvemVScVJUSGlNeG53?=
 =?utf-8?B?MmlKL0UvKzFHUi9CR1BGMVRxNWxRL1l2MGpmM0VTVytRWFc3ZEg3aWQrcURB?=
 =?utf-8?B?RndFRC8xRFRnTUZaeXpBYjhEQ21laktFN1hpZytNVWRQdloycmRGdWZEU2hy?=
 =?utf-8?B?aVRlUFlpbmdHMkNUalBoOGJaR2RBaUFWUXVPSkFqMUJ0dmJwOGRyeDRBZFBk?=
 =?utf-8?B?d0g1eGhjVitTZy9jeHhMVFN5aDArSDlvK2hwcnpaYzhGVXB6cWZuSysxM3l6?=
 =?utf-8?B?YkxCUTN6OU40WjhtNzJnQmpSTThwVTBJT2ozeGtyTWh6RFdZSzRJamxBVVBQ?=
 =?utf-8?B?Y3QwNno5Z09nY3hBUE5qSnZuRWtQQnhCRFlaaGxxRGpiWkdhdVprQUgxc2ZE?=
 =?utf-8?B?ajg4ZXR6RG0xV1YyM1RKMkVLdnRqZVhFcFFUcSttSWZRaHZOR2M2OC9lQ0JW?=
 =?utf-8?B?emRaWXg5Vzd5WVJ2UFZybUhXSmJJaU52K240ZHpRS0hncDN5aithazNVUVhu?=
 =?utf-8?B?d0h1OFg2Zm1DeDNxT2I4Ykw1VzM4ZjFJNlBYNmVmaHhhc1ZScElRcXNFLzMy?=
 =?utf-8?B?VTVrbEdaT2IxRjFUckRSUGQrNU40TGtjTklQRkJXdm5idjduRmNWQVN5dE1a?=
 =?utf-8?B?dXpSNmRqSGs4eVk3N1dMeVVYcXBnWnEzNTI5WHlBR21wNzhwdXEzdXNyV29w?=
 =?utf-8?B?MkdGWTdsVE54Ym8rVnpoaEpaNHVRcXRySWRhZUJWL0hhaTVDL0JLRVZEU2RG?=
 =?utf-8?B?RERtc2lNejZqT3JxUisxekcxc2NkUkhVaVVtUHdJN0dNWFdyeDhKY0lsTzdQ?=
 =?utf-8?B?dDk5YWlPdnZGMFpxeFhHd2pjMHlTOFVWMnFmMHEzSmtPMUUrRC9JUU0vYmxZ?=
 =?utf-8?B?VXNUWWZJY0hNeDg5TEtLaDNyM2hKbHd0MjJBNUR4V3kyU3ZWSEwvQ01ibTdv?=
 =?utf-8?B?ZGdTRTBmSlFCOGw0RFd4RUo3S251cmp2UGIvR0lSamFldHhEVmwySVRpdjNK?=
 =?utf-8?B?UFpJZWNjMXBITlRWRjc5ZUdWaVlIbjc5ck9HRHdqank4Q1lwdGMvYlhmTTM2?=
 =?utf-8?B?RFRwbU5jWWdtNUpkdTY1ZjZ3YlhxZW5mNlRlK05nNFB1S1hSYTZQS3hTRjFG?=
 =?utf-8?B?WFcwVHdtbVVTTXhkWU5JUGp3Z0V3OWw4OFhRUHZTTlE4dVZnRUVLQUF1aGh3?=
 =?utf-8?B?N0tuTk93NVVuWForUlFZK0Y1Nm5TRjZXUEZZN3FONk0wdFJMVTVTd2JWRUpu?=
 =?utf-8?B?UXpGQ0w3NVJwTGNPTFNZTkwwa0JjVG5RRWt3ZmNSN01lbEtBR24rOW1iUWF1?=
 =?utf-8?B?YUJ3akl5NFFnQTkxazJGeVdvR0dEU1d4a0ROVWZweGpJWmErcldrOEh1Yi9y?=
 =?utf-8?B?WGVwUVp3dEZIQXdBUS9GYnpYakFqekI2K3N6eStoSzErbjFNK2VaRXRIZ2Fy?=
 =?utf-8?B?b3JVRjJoZll6NUtpRDFFc0JDVXdZblB0cDRzNThRc3RoNlI0VXhaWlZNU1Zw?=
 =?utf-8?B?bXFONVpnRjlsSUdsK3Q4WEcxVFVpVjF3L1J1UEpYV2dESTkxVXZPZGZCV094?=
 =?utf-8?B?Y29wckxuRkpLUWV2NUd5ZGtlUTlPWXY1cTl6TEtOMkxoNm8rc0g1UFh5LzJS?=
 =?utf-8?B?WVplM3BDSWpNeEx2Y0FFOFEvN1ZwQkZGa3hkT1Bqa0dHOHpLUjFiUk81SXgr?=
 =?utf-8?B?bUpudVV4K3hkeHdEUUNNVGNtKzBEZ281Tm9QVGNxc3F2WTBTME9lUXNrVGpT?=
 =?utf-8?B?Szh1Z2x5eFpLQkFhSGlrUmtiaTNCU2hUSXdZcENBNUdDRmk4ZytVN0MvWFl2?=
 =?utf-8?B?R1hDc2N4NzRlWE5LTlhmcm9SMHNENXdTMzJKOGlKaWlLdG9NN09QTDcyQUFR?=
 =?utf-8?B?dWcwT2NhV3Jxb29JZnMrSmtTS3l5YUtBNEc4LzBnRlFqNEQxWk9hL0o5WVRF?=
 =?utf-8?Q?w8eA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52caaa13-8bb1-43c0-c730-08d9a354bbd5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 07:44:17.5474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Src2iOPhQBNDwuDgkcWAkQXUeGJ5z+2+BbaiPRHvjFxOw4QVBQ0UX9XrrSu0NlyQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1677
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 09.11.21 um 08:28 schrieb Lazar, Lijo:
> [SNIP]
>>
>> Ok guys I've double checked the git history and found that this here 
>> is not as it is intended to be.
>>
>> See the code in question was just added in August by the following 
>> commit:
>>
>> commit 859e4659273f1df3a23e3990826bcb41e85f68a5
>> Author: Evan Quan <evan.quan@amd.com>
>> Date:   Thu Aug 19 12:07:59 2021 +0800
>>
>>      drm/amdgpu: add missing cleanups for more ASICs on UVD/VCE suspend
>>
>>      This is a supplement for commit below:
>>      "drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE on 
>> suspend".
>>
>>      Signed-off-by: Evan Quan <evan.quan@amd.com>
>>      Reviewed-by: Guchun Chen <guchun.chen@amd.com>
>>      Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>
>> Before that we where just not touching the UVD power state at all 
>> during suspend and so we won't had a problem in the first place.
>>
>> So what we should do instead is to just revert commit 
>> 859e4659273f1df3a23e3990826bcb41e85f68a5 with a proper fixes Tag and 
>> explanation why that is a bad idea.
>>
>
> Yeah, right. If I remember correctly, this commit was originally added 
> to fix hangs with S3 suspend/resume cycles triggered during video 
> playback. Reverting could bring back that one. Evan will know more 
> background details.

Exactly that's my memory as well. So what happens here is that we go in 
circles with one patch fixing a bug and the next patch effectively 
reverting it again to fix another bug.

What we need to do is stop this madness and take a look at the 
underlying problems instead of trying to work around them.

Thanks,
Christian.

>
> Thanks,
> Lijo
>
>> Regards,
>> Christian.
>>
>>
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> See we usually assume that updating to the already set state is 
>>>> unproblematic and that here sounds like just trying to mitigated 
>>>> some issues instead of fixing the root cause.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> Whoever commits this, pls add
>>>>>
>>>>> Link: https://lore.kernel.org/r/YV81vidWQLWvATMM@zn.tnic
>>>>>
>>>>> so that it is clear what the whole story way.
>>>>>
>>>>> Thx.
>>>>>
>>>>
>>

