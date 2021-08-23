Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F12C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 06:58:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D4E261250
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 06:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0D4E261250
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A933889C51;
	Mon, 23 Aug 2021 06:58:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF59A89C51
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 06:58:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cj31pnnO45D6eFaj0tGMJ5uxWgAxEwPf+O+mVj9nWaecyun7RK/coP1/B8uitdGVeLM3aG0iGgX5yqzZTXONGZD/mWzcAWaRZBMSc5x2R4mbtBdqVrI+fz8nhDWfWwD/Ye1mpPVBN20P9NDPPIWCgo3Y7gQmT3+c/TBetHaqz5B+GBRNtIaQxoAOeA7c5+LHl5ZuPtFP+sjSN1PUZGhxCCrRnrcg5uaP93Eq7EKxfRrte7fkFZbhWCc5axFShp62Oi6SsaeISZdSV+fxl2N5f9TZHvyHqOExnILa/jKt5P3ipM2wuLqwtHu01u4HYUFumKo77qJZYuDGBzv9NTq4LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zsRXX4G9Zv1V4W/oyIJsZEOgCUlGt76eFiYGzGxNAI=;
 b=PKQ7r2VRN1aWpXyE3vE6IFsRJMZlSeF/7ItCap2oKZscyGzrwFxfjDlboYWrN6ifX4nfJySgUGP0f1j0Wyqji+ZwjNTuupVKJTstO6DTgzluW53V3r32y8/Rgxe7loj2sgOa0qR4aZM5k3YmnNmOw8gb2NObks2ZQUBRfCo10pK5yvCyYILE5l+e2zc52V4ffsiLOgj8P+jbCZqsGrlj3OalRqtDShOgR5ot7m+mpphsmkA4NSFuKdr5ub41UP1rIQc7z9/+6fbz0r0sJLWCKQAdlAQJ7H3bUgbkuLd87/6M2E62aDALKmiaB7OCku8VQ9qAvYaBuHj/osb3y7TyCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zsRXX4G9Zv1V4W/oyIJsZEOgCUlGt76eFiYGzGxNAI=;
 b=kcWkwSTNtuSLVfc1wnLDS+hSNM8v9crWCIXk50/Zo09DAci+OQzShjt3y0BfFgFJNnKYVAWlkdcL1k7OwAGnOH03K1xKdjcAwYVPpiwMiO8/ZGyNhgg8yOrkQMbdnhoXwisEqRozBp4EJqlJMrzaBjfzlLckMKjvSS7rBBR2kBM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4913.namprd12.prod.outlook.com (2603:10b6:208:1c7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 06:25:38 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 06:25:38 +0000
Subject: Re: Voltage control on Southern Island GPU using radeon driver
To: Evans Jahja <evansjahja13@gmail.com>, amd-gfx@lists.freedesktop.org
References: <CAAq5pW_7Tv=qzTeUkTuMZMwq+FN63Qmz3pXCiwMx5R4Gbg89bA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a4db54d0-9978-035a-538e-7c51d8082037@amd.com>
Date: Mon, 23 Aug 2021 08:25:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CAAq5pW_7Tv=qzTeUkTuMZMwq+FN63Qmz3pXCiwMx5R4Gbg89bA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PR3P191CA0029.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:54::34) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.21] (91.14.161.181) by
 PR3P191CA0029.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:54::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 06:25:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8823828-114d-4855-2a2b-08d965fed306
X-MS-TrafficTypeDiagnostic: BL0PR12MB4913:
X-Microsoft-Antispam-PRVS: <BL0PR12MB49135E8D40AE7008260B0D8C83C49@BL0PR12MB4913.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fcKFASSAnqgZ49Xu4R3hk1qdcb43Okigxvr0zU0xrsoWo1M8Y9fGkOxbPZuMtk8FaEIHk3AuKfNursygxfnj55FmRiPTujbZcsGSY17upkWnDAripw8QtWYhqYJo0vNTY1IYjJAcj4KfXYAL9ik21fUW99Z15tFqqt0ZI1E9nONp+YPHWnkBlxCGnrOSRsYet//tK+X7n5rlALZ82V1548aLu3SBC85CcCX7ouryJn1lHtk8jg8iZgb2HdyAnDp1CyNexNBzCp65uJw2/B8sQyof6+quGh+NqZjTjaqWwFXk2rQwRJIC+XDwOwQetf9dAkWNYCTpLkmfI5K/w/0cpjbXqD9uz8cQqbXUz3bQvX3RHWtnjKZYIFrJgyPGlnf3boXxXqLDDoc0GLXoiOzgzIjrKTSfEhdGAjVuqrw8mHwF6ZYPNJHrb7zj795C48HGSq27J4ZYU6VQ/NGmztsH8Wt+5uoxSGn9hmthZHGihnoAxClmTRRVfPgxJjf52aPV9zLcoywkwzxTYUzCdAnMuhnzPFdGcD4Hh0UaaCfwM0yC8jY0Fh4bHXv3RV/ZU0tzANz3ngNDVjtcy7jcRczqVxpYjg8mgSU1s2bPIZOG70uwNDiK5dRone10KFAFsGYV8P7zvw/tjUo7xrfJIervzMOPYojnYi4AT994b1Y1ZFgL9tzcUTIOX1z0L+ZEo/MwrsiURTO2shqRRz4cxLPMQh/W3BDOYeJFgZTbNeX9dQE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(956004)(2616005)(8676002)(38100700002)(8936002)(36756003)(66946007)(66556008)(66476007)(2906002)(83380400001)(26005)(186003)(16576012)(316002)(508600001)(31696002)(6666004)(5660300002)(31686004)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eitWY1lxNlhaRlZ4YmloK0N5UGt6a1pUYzlvQmtmMVJ5NVBNNkozcm5PWDZY?=
 =?utf-8?B?OFhHaVZOYWw5VVd0RzFzYzFLMlU0U2p1c1hSSEhwdlRxUjRacWozdUw3OFdU?=
 =?utf-8?B?UVRIVDY3ZGtQeURsb0JsZnZLVkxWS0JHZVJOT1hVZjBDRzRjQ2hYRmJ4dWJr?=
 =?utf-8?B?bWpMUW1XNFlXcUlyNXJST0Zyb0hZL2hmMnlMeWxyWURScDdONVRDTFp5TEw4?=
 =?utf-8?B?WjJjbDQvcFFuZVlCc0JNc3psaUZFUzN4OTNDVzNKSmVzRW1haVc5RGNXYXU3?=
 =?utf-8?B?bkl0Z01CWnRKTTAxV2k1Ymx6NVF1THBja0pDRkRuZnZoOVEyakwxbEdIQTZY?=
 =?utf-8?B?SXRPNGV2dXUwZlBvVEQ4RVlwazZGRElJcFp6aDJ6aEpvSzFYUlpzSG5FNGwz?=
 =?utf-8?B?S2d2RVhyRTI5ZGNWdGtCN3RtUEFkWFc0UUVpSk15K3lrTmlmUGFmK0twQ2gy?=
 =?utf-8?B?Z1FOY2QwcFU5TG43VXVoQ0p2WWVsSGVvQ1dvaWY4cHVsNWZoYUVVc2JmWmQ2?=
 =?utf-8?B?aWdyZndxVXdEU3dVeHg0V243K1VhOXdDYjJ3YitiYzRBc0d2cUF6ckUvRklY?=
 =?utf-8?B?TnJiOXgwRG5KVEptWTZQdlRCMWRUZXJCUHdYMnlkWHZBVmdOazRpVHFpK1o4?=
 =?utf-8?B?V29YR01PK21yVEVzVW1leU5LVDRkUmVpWXEreDVHRXJTMWVORFNoRCtJVENZ?=
 =?utf-8?B?QmRjcmdVcFFoUHlYdzRCMHkzQ0cvdWtaVjJpU05lRHdSRWExaHUveXh5eFE5?=
 =?utf-8?B?Q2Uwb1p3SzdBSXk5dUNBOWpPQjFCU2V1c2g3algyb0NNM3dvaDNNWFpxUjlu?=
 =?utf-8?B?WWo3TG1jRlRDQXZVMmdzL0I3Uzh3RWF4T2xYbGgvNEdqZGtaaHVuQXlQNVFz?=
 =?utf-8?B?eU0rQWZpMTMwQ1NVMVdoZFhaRDhJSmxzd2lzQVhLMjVxLzRUS1hpMkpYT25h?=
 =?utf-8?B?RWIydHliN1VEUzdnZDhpUXJkSzRyNURUbkd6cHFMSkdiRHVBOXlYYUJHR0Ry?=
 =?utf-8?B?dlJFM3BOMStxWkZqL1o2OFRPU3RhOHhXYnVDY3dJYkNlRThzSWxvTjBKTTdH?=
 =?utf-8?B?aHJiOFNZWDl3WHNRcjByTnhmSWpmNW5EUG5Hd090WHExZWVHL3pNUGIyeGZN?=
 =?utf-8?B?azV4RnkrLzUxQ2RaKzQ2VXJnVGRnekJTMkZ6d2U3RGlnaFdMRGdmcGcrajBn?=
 =?utf-8?B?bVc3YUJxSGJ6RW5Qd3g1c01TT1lycnJQUWV0eEdVTW1CcFBkZ0RPNWFOd0gx?=
 =?utf-8?B?OWpibzh2ZUFGRzhUN0QvUmg1UG02bDVhSFBzeFcvcEpZY0Exa3hCVkF1L00r?=
 =?utf-8?B?ek9jaWZJaTZSd0VlSFVPeDhRdm1UWkJDUnU3RVB3dnZBYzJZb2JNcWEvSEdQ?=
 =?utf-8?B?K1JnUTVXZkVMaWVSTHlkeXp0ZGV2QnUyanhEOElDSUlUNjJQNDBma2ZFcmdK?=
 =?utf-8?B?NVY4dW9oQmc3bzRDUWJ0Tzd3VGdZc0ltMTIzY0ZzVy96c3J3SVlJZWE2Skg2?=
 =?utf-8?B?ZUFjbmdjdTNTWXlaQXBJWmkxcXVWbDJsaFh6RGNJcVZnWTlJSHU3anAwN1c4?=
 =?utf-8?B?eVdKRTVUOGI5VVVxZGNMeHlKaDlka0dYeUc1VFN6dGxVVHBucFRBeGpVNlRZ?=
 =?utf-8?B?OE5rN21Hd0p4cDJRWUJJU0V2MzFoRGJpSUkwTzJMMnNLYjBqUDRiMnRmTVcv?=
 =?utf-8?B?NnJrazg2ZHJXelBvYTNuZDIxTDZJUkpBa29TeXpsYjZGekh1UG1IZDIrVzhD?=
 =?utf-8?Q?PNDfwumNqKC8IoGXeUq2mEzdfayuZnzky1GMuD7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8823828-114d-4855-2a2b-08d965fed306
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 06:25:38.7929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Law7Iooy/frpJjaQKhU3iMnRD/hXuDD9DCQG3IdF641lAhlrCfzSp6Tp9S+RvfY1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4913
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Evans,

in general the voltage tables are stored in the atombios and the best 
advice I can give you is to first double check if there isn't an updated 
BIOS for your hardware.

But Alex is the expert on power management, especially for those older 
hardware generations. Maybe he has another idea what to try.

Regards,
Christian.

Am 23.08.21 um 03:56 schrieb Evans Jahja:
> Hi, I have a HAINAN GPU below:
>
> lspci -nn
> 0a:00.0 Display controller [0380]: Advanced Micro Devices, Inc. 
> [AMD/ATI] Sun LE [Radeon HD 8550M / R5 M230] [1002:666f]
>
> I run linux 5.13.12 on Arch on a Lenovo B40-70 laptop.
>
> I'm trying to understand more on how voltage control works and how I 
> can modify the voltage for doing overvoltage / undervoltage on my GPU. 
> The reason is I am observing how running programs under high GPU load 
> (glmark2) would lead to crashes when I use dpm=1 in either radeon or 
> amdgpu driver, which seems to happen when I am reaching power level 4 
> (sclk 900MHz), while a lighter program like glxgears could run and 
> switch power levels  between 0,1,2 without issue under both drivers. I 
> believe my laptop might be faulty, but I would like to take this 
> opportunity to try fixing it from the driver's side so that it can run 
> anyway, however limited.
>
> Right now, I have managed to increase the performance of my GPU by 
> manually overwriting the sclk to 630MHz in all performance_levels in 
> radeon_pm.c, which surprises me as overriding the clock was not 
> possible for me to do previously via sysfs.
>
> I've managed to tweak both sclk and mclk (or so I believe), but I 
> still cannot tweak the voltage (vddc). The reason is, if I increase 
> the sclk to 650MHz, the lockup will happen again. Changing the 
> pl->vddc  variable does not seem to do anything. After various tracing 
> with printk, I understand that on my system:
>
> pi->voltage_control = radeon_atom_is_voltage_gpio(rdev, 
> SET_VOLTAGE_TYPE_ASIC_VDDC,
>    VOLTAGE_OBJ_GPIO_LUT)
>
> this returns false, while:
>
> si_pi->voltage_control_svi2 =
> radeon_atom_is_voltage_gpio(rdev, SET_VOLTAGE_TYPE_ASIC_VDDC,
>    VOLTAGE_OBJ_SVID2);
>
> This returns true, so I believe my system is using SVI2 somehow to set 
> the voltage. Having no experience with SVI2, I read online and found 
> out that SVI2 is a voltage regulator that uses Data / Clock pins to 
> clock-in 8 bits of information and convert it to some voltage value 
> between OFF, 0.5V -> 1.5V, offering fine control based on some look up 
> table.
>
> My questions are as follows:
> Is it possible for me to modify my system so that I can manually 
> adjust the voltage to my GPU?
>
> Thank you very much in advance. This is the first time I deal with 
> kernel drivers, so any guidance on the matter helps a lot.
>
> - Evans
>
>

