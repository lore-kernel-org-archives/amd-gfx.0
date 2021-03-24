Return-Path: <SRS0=J6fF=IW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7AAC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 21:13:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F85A61A09
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 21:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F85A61A09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B33D36E1BC;
	Wed, 24 Mar 2021 21:13:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C7D86E1BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 21:13:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXF3giwVzeTYIwAgyG7crQq8+PKpNry5n02XF3TOOM0Nh9ZcPlDtATXJs0q0YlILCLYEfFszd60n7UaIWYMrzwiqTsRAi8JM9SMkoklq3PsXS3rTXhLFQSItP+J68/ORJ/Aze0ELxpJFvU2RzggirCQOzf8cZG9fWbwNMOx8RROAleC1ySNs01vdoH14HT6dmkaRE4t/eA2wzAiLDjUE5+8KJUGhVu3CD3ZEKCURF1lr6/Gc8TRPE8+vkFTbQV3+qqH5B+m5b2s/UYybFgALvje3JjhcRs/u3TlvUTfUF4KKgeY6PeBIWNEK4lmh8DjEv9MnwDd65LYdsXMXuqDZgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3sC4ZCmwNRQ38xVh9BgTbzpR+zWVH0cbh3a1TtFIfw=;
 b=Fnm/l0Z6K6QmeSFKbotNrpEzLsogUPENhM6dr0Vb5v9gemcCLWmB3YqBMRMOlRGUFv96I9Pz9SrHRHyff+99CRTGxCi1LRxCRvUbmiuwAzVa4Zz5P/LuPWYv8gs75gkRKnGeq5UrKv3OcvHdH3A4a+BxXCLe7FD17wANH9XSod5Bs+hBEfXsxRHPkk1vE4HVyBng7BXtW9GmnQY7cKAoDTe7GzOS2RfrOguo3/EdQ6WLz91YmHwGl0IvQMi43G97E2kcOCZRqzt9zWzoVcYRo4hacTU4kFP/CP2cv+MQO+WPVjVeN/1DEkid7xH4AsDvO2cWgiU/inNwNhFsSq4EOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3sC4ZCmwNRQ38xVh9BgTbzpR+zWVH0cbh3a1TtFIfw=;
 b=uK+BtlMcYPyJIPEYM+bas5ybgdsMHCCadCALuxFt4L/qJOSBD8o53V/0psnTznhQqT8wYptQJlEFmDbwZ7iTs3Pys0rpG+z9fSytdkT+15ufMaUvRL3TE/N2BKNm6ZBwue0vdhEigCEfFLI7HYymfTqUjDFV4/ELSrC8RUc6Y8g=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MW2PR12MB2345.namprd12.prod.outlook.com (2603:10b6:907:2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 21:13:22 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::4987:8b2f:78ca:deb8]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::4987:8b2f:78ca:deb8%7]) with mapi id 15.20.3977.024; Wed, 24 Mar 2021
 21:13:22 +0000
Subject: Re: [PATCH] drm/amdgpu/display: fix dmub invalid register read
To: Alex Deucher <alexdeucher@gmail.com>, mail@thomaslambertz.de,
 "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
References: <3eb98a62-12f4-d191-97b8-15e2f8ca06e3@thomaslambertz.de>
 <CADnq5_Oq8nBVuLomgPJm0o054ZTDoeuZSCJNkGe+ZhODDp93eQ@mail.gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <67f5ccb8-7bb7-6d8f-f15f-7a8397c42e29@amd.com>
Date: Wed, 24 Mar 2021 17:13:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <CADnq5_Oq8nBVuLomgPJm0o054ZTDoeuZSCJNkGe+ZhODDp93eQ@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR16CA0003.namprd16.prod.outlook.com
 (2603:10b6:404:f5::13) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.7.77] (165.204.84.11) by
 BN6PR16CA0003.namprd16.prod.outlook.com (2603:10b6:404:f5::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.24 via Frontend Transport; Wed, 24 Mar 2021 21:13:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ba3a28f-f21e-4659-c9ca-08d8ef09a76b
X-MS-TrafficTypeDiagnostic: MW2PR12MB2345:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2345B0AC3CCB9C6382486C1A8C639@MW2PR12MB2345.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bWAE7U71vJ9lj6qwP+JNhVniItU+PHMJyeqoFwwSmBI6Y+nt94PWrgK0r5PvBWmfh1zsaRRehy985iZ2s6VJnfuNstN1B2UPqziuB1DmooJp5QEchmJryeoqOET8WTpwEDuH8pwdI/xZWp/BcDMPXM2Wm5Vmy4u7elY4Dl5Uh0bQDPKpqLeefYRg6ajAlnzsT3hMYaObjh4fZ+0X7J+WgPbrGsK+omVe0vbxbJEFpONxEJvSIeNI+l4MaBooSFrhk+bNgxXLLcDW7X+TzKjmyCig7WDAgTxSdxDw3JSQPGysS2f1U7GCX0M/Ixvkbo6LA7Zdsi0rDImMsQwqTnHyz6BBMg9qzfkpkDsG/jSlly3+KSHTIkEqj1iTviJP0YQCRqjsTk/sBGVac3VWCvDyOfFn6nCJbRLgVIYO7+5nt7VVwg1uU4NYuGPzBMWpY3zcY8eNQwqzLstqOFh0ClHUQ5NSZECvdvt1G48V6hMLPJ2EBjpna4W7kXaMSv5yKtSdDgEJ1Um6eC/T2FuC1itdn+WBpvf20D7H0mXeKchKHq2jjk2dvn2rLKIdP3tqjD1zCMkld/zApTFnOfcrm0+kWEQVpxW829o70YMsnlW1+GBcyOy07X1UzFlMTazTlC2d5FFGvjXiw8oX0evF9q40yUmcBH8E7vksWtmZao5oiE2ArXJ1+aGf7tjMm0sKmtYc0P5GocWnZ9FzEqbYA8WdoQcrDacFcvC7rax5oNeF6vaeVAxzZX9i3Nf/Ev2owmNMyByPhcqhiMVo86n6uZtNUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(86362001)(6636002)(31686004)(8676002)(26005)(36756003)(956004)(44832011)(66556008)(31696002)(2616005)(8936002)(66946007)(16526019)(83380400001)(186003)(66476007)(6666004)(478600001)(53546011)(54906003)(2906002)(110136005)(5660300002)(4326008)(316002)(16576012)(966005)(38100700001)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aGFUMHpUSlRaUWZPeTErZm5KakdIZ3RmMHZWNXZHZ1Zja01KUkhLdjYrVDdr?=
 =?utf-8?B?YlpXRGpmdUVvb1FXTzAvZzFqQkhJZUc2cHJuM0JEeHNDNC90RXU4VFg1d3R6?=
 =?utf-8?B?a3FlTlJZSzZQNlZxeHNVaXhkTWlqc1NQMUoxS0w5V0FKU0pCSnZSRmttYmd0?=
 =?utf-8?B?V25rSSt5S05zckVHY3JwZm9ScTB6MW5TMGhJbWdZK0hzRlFxVE5memRXRE94?=
 =?utf-8?B?aWV1Sloxd2grckJaYVU2Nlh3SGNpNGxHbk9PNXhvdUlweVg4S0lGdzlZYXlz?=
 =?utf-8?B?anR4SSs2d2lxRXc5NjRaU094RHN6ZjZ3ZWoweHhWb0FvK3FzRVZhOHROZ2V1?=
 =?utf-8?B?a2h4ZnIyMzB5aWhVNjNnQThwQ1VJdVRNc3FyZDg1eUdJWE02Y1cvTTR1UzI1?=
 =?utf-8?B?U1FkZitTYkp0b3lyVEV1U2s4cGRkN1VHMXJoY1NNS0VteDY0Q01BVHBFTFFI?=
 =?utf-8?B?TWxMMEdMTmxkc0dXNUlNQ3FkRHVtVEhQcURBQ1l0MVRnSzFCbkxWNGZTMHVo?=
 =?utf-8?B?N1ZYSEh2dHlEd1FIbzlWTGVwSU81Tis5bEp4YS9OQk1EbGkwaXM5V1l2UG9H?=
 =?utf-8?B?UnVFcnhhNDZiak9rVzkxYXg3MVlSWEIzdFQwWVVudENMUmpCbk5CQjV0K0Zk?=
 =?utf-8?B?Q25kWGRHV1lXL0YyUFV0c1o3QnRMdm5Ram9mRjc1NkhweWtzVTJhWGV2cDdi?=
 =?utf-8?B?MER5NG9UemE1MVVlMXQwaitkbW16MmlXY01uVVdLTUdmNDEyNUpLQWhVbFRs?=
 =?utf-8?B?aExONkdUVkdZV2o4WC9xMkJiYTVxNEM4Q3hHa3FDQkh0dTJXdGNnNW0vNDNX?=
 =?utf-8?B?QTBVZSs2anlRSmNLSkp2cUh1VHJ3SzNMK0lKV3c2ODlCalRLV0JhUEVRc2J4?=
 =?utf-8?B?RFV4bVVpQXB2TkxTdE1sLy9maWdaRENHY1B0UkV4ckVsclRxQ001a0JJK2Ew?=
 =?utf-8?B?SDJlVjYyaFdBMjRQejY2aXhyUXFCN1FncWtQYUdLamxGMUxMK2tSWktoN1pT?=
 =?utf-8?B?U3l3SXkzc083Qys5WHhxMmVjcXQyN1VseVByUW83TFlrRkNmS1hDYnhNU0Vz?=
 =?utf-8?B?eUMxWHk4eWlobFFRdEdFaU5HMSs4YXgvVnhGZHB0c1dVazI1TXZqS0ZxU3lu?=
 =?utf-8?B?MGVuZ3hucW11NEVuN1psa0xIQkl3S1VsSm50cU94eEVmcjYrY3psWXlBRStJ?=
 =?utf-8?B?NUhZeUQ4NmhJWEpNQUdHQ3NVU28rS3R2MTBNeVNWQjMzZlFNMVY2a3NYY2I3?=
 =?utf-8?B?U05Ydjd5bFdlaTYwalpRTytjRHpuZjZGcndYMS8vdHFoME1CcEtkUWpHMzFK?=
 =?utf-8?B?VlRrZDBkTDNrNlc5N25rOWNIOVEzNml0Q25ZTXNwMU5scEl0bEJaL3R0UHpj?=
 =?utf-8?B?T2ozZGJNM29pb2lxWXp0aXBJZ3FWaW81OXJWNU9kZ1J3OFAxc3dRckF3NlNo?=
 =?utf-8?B?Q0VBeDBQVGV3UkM0aWdPcmFKZnBXbkl5ck1MRXZCRmVVcjRKSHRCOWtZSUZ2?=
 =?utf-8?B?eGo4bExXdHd5N1RCNzVLdDVodHhEVXEvcTl5N1hWSTJGRjM5bEFlRWhqbU0w?=
 =?utf-8?B?WGRIQ29CWjYxWHlQZE0zM3dIR1NFQXJtT2Z3bjl4UVBDWUE4b2lsSnptYk1r?=
 =?utf-8?B?a3ZnUDE1cDIyT1R4YzM4aFYyWllzYTZMMDR0T2krVUIrNHR5c2x2cGl3SFlv?=
 =?utf-8?B?Rng4VExKcG00RGo3VVNIV3dIZTBmOXZsNGl4ejdYYzcwRHo3cHdkcEkwOHlr?=
 =?utf-8?Q?xGG8mHdOwI6TWiR7fKZ8khylfICnlNi5rVCWmUw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba3a28f-f21e-4659-c9ca-08d8ef09a76b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 21:13:21.8545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ge2jzhrjD+JlxcfKfNsZqHhRq+O4GZG1rCg5u/E85/ELOvUa9yXtZ9lKuSpk1ubQko994Fl2tipRsZ680XT3Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2345
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
Cc: Leo Li <sunpeng.li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

+Nick, Bhawan

On 2021-03-24 4:39 p.m., Alex Deucher wrote:
> On Tue, Mar 23, 2021 at 4:18 AM Thomas Lambertz <mail@thomaslambertz.de> wrote:
>>
>> DMCUB_SCRATCH_0 sometimes contains 0xdeadbeef during initialization.
>> If this is detected, return 0 instead. This prevents wrong bit-flags
>> from being read.
>>
>> The main impact of this bug is in the status check loop in
>> dmub_srv_wait_for_auto_load. As it is waiting for the device to become
>> ready, returning too early leads to a race condition. It is usually won
>> on first boot, but lost when laptop resumes from sleep, breaking screen
>> brightness control.
>>
>> This issue was always present, but previously mitigated by the fact that
>> the full register was compared to the wanted value. Currently, only the
>> bottom two bits are tested, which are also set in 0xdeadbeef, thus
>> returning readiness to early.
>>
>> Fixes: 5fe6b98ae00d ("drm/amd/display: Update dmub code")
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1518>> 
> Harry, Leo, Rodrigo, any ideas?
> 

When I checked with our DMUB experts yesterday they said they'd never 
expect to see 0xdeadbeef in SCRATCH0.

That said based on Thomas's test it does look like we're getting 
deadbeef at resume so I'm almost inclined to ACK this patch. It doesn't 
really do any harm.

Harry

> Alex
> 
>> Signed-off-by: Thomas Lambertz <mail@thomaslambertz.de>
>> ---
>>   drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c | 8 +++++++-
>>   drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h | 2 ++
>>   2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
>> index 8e8e65fa83c0..d6fcae182f68 100644
>> --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
>> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
>> @@ -323,8 +323,14 @@ uint32_t dmub_dcn20_get_gpint_response(struct dmub_srv *dmub)
>>   union dmub_fw_boot_status dmub_dcn20_get_fw_boot_status(struct dmub_srv *dmub)
>>   {
>>          union dmub_fw_boot_status status;
>> +       uint32_t value;
>> +
>> +       value = REG_READ(DMCUB_SCRATCH0);
>> +       if (value == DMCUB_SCRATCH0_INVALID)
>> +               status.all = 0;
>> +       else
>> +               status.all = value;
>>
>> -       status.all = REG_READ(DMCUB_SCRATCH0);
>>          return status;
>>   }
>>
>> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
>> index a62be9c0652e..9557e76cf5d4 100644
>> --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
>> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
>> @@ -154,6 +154,8 @@ struct dmub_srv_common_regs {
>>
>>   extern const struct dmub_srv_common_regs dmub_srv_dcn20_regs;
>>
>> +#define DMCUB_SCRATCH0_INVALID 0xdeadbeef
>> +
>>   /* Hardware functions. */
>>
>>   void dmub_dcn20_init(struct dmub_srv *dmub);
>> --
>> 2.31.0
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
