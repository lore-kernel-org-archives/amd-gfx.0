Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B06CC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 14:56:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07BB660C40
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 14:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 07BB660C40
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7C4D89DA3;
	Mon, 25 Oct 2021 14:56:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9E6689DA3
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 14:56:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUcxrSR1CRE0mmuYgFyPRA9OSK4Cr46MFiH3OPHbuGzWgBKgs6lIGcdVmzu+x5nVQqjvnyljVEno0bavQej4AMyV6Zr9gRTHCbSROkTAmo88dv5PYcuiVD0iAY3qWPHim7htFYDBOTKQKDz/+EYhwMPZLpWlLz+Nkh/uk7I19MbGDayuDmjJPrg3dKO4p63Hk5kgVwSimx9+JabTOx0Aqn5/Ig9VjsT7XDsYRSKhriaYGM8w+ldpF8V5KZHIwqodu7vFbNRNMLZBvZV5h88ShqOjFcU0BoqqZnam8n0YmUZXHazfzO3KknP+iFnEAUtaZ15XILiN28rGTfF/0xalng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+XxWMiHY4dxImu7eweFJKx9WLofiWmziFvv8ieyOz0=;
 b=N5tSHNewnwIUEu3JwIBMOCjEoSnUbxKCta6olU2iKOq+hHRZYsWjK3lAfPffBn4OisfmKOyYdrbodUI3y/8P35dFjXiL4uNyiIgtpRuI3Ju3Jacxt+gx7GNSyE3jZOjv/VyojdiTb5T+6UM0K9TUK9GiYuhfm1DbHlBQoDOHOvub7lmxYYyscpN2As4N65BAR5yrimcr6I9wdLMQ5mxzJqfdWeLVB8FqP+k2YBPqxVFw3GFK8OBuMeS27/Ynxc0H7EjhoBYnLNUXRBN8tPKPTOhMbn6VrRuOBxWJL2HL7bgzHMJtKFKiBg/xFt9xy6MX/ujV5TZvZ6cnprNP32Wb/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+XxWMiHY4dxImu7eweFJKx9WLofiWmziFvv8ieyOz0=;
 b=buH97H3egIiHeLdhmoqb0KJSCRVNqlVMDyOeQMfKj0/8WA/1mx6NQ1sZrdDkpnmTJq4FgoIx66Wrn6IzMMrwVpAg+7JEwxpMotZ39Sf4pV6NAidq4OjhT6lb9N6DGdc3S9OXqoQjVaq0+4EVqbxDiYfQqTPLtQcLLVOWoJfYuqM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB5564.namprd12.prod.outlook.com (2603:10b6:610:65::24)
 by CH0PR12MB5233.namprd12.prod.outlook.com (2603:10b6:610:d0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 14:56:15 +0000
Received: from CH2PR12MB5564.namprd12.prod.outlook.com
 ([fe80::7988:8b2a:5575:4510]) by CH2PR12MB5564.namprd12.prod.outlook.com
 ([fe80::7988:8b2a:5575:4510%5]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 14:56:14 +0000
Subject: Re: [PATCH 32/33] drm/amd/display: fix link training regression for 1
 or 2 lane
To: Paul Menzel <pmenzel@molgen.mpg.de>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Aurabindo.Pillai@amd.com, qingqing.zhuo@amd.com, mikita.lipski@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, wayne.lin@amd.com,
 stylon.wang@amd.com, solomon.chiu@amd.com, pavle.kotarac@amd.com,
 agustin.gutierrez@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 Eric Yang <eric.yang2@amd.com>
References: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
 <20211024133141.239861-33-Rodrigo.Siqueira@amd.com>
 <16010bef-7bf4-1da4-9f76-7b23d4296d5b@molgen.mpg.de>
From: Rodrigo Siqueira Jordao <rjordrigo@amd.com>
Message-ID: <bde4f1f2-670e-2acf-4dcc-61effd4009a6@amd.com>
Date: Mon, 25 Oct 2021 10:56:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <16010bef-7bf4-1da4-9f76-7b23d4296d5b@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0557.namprd03.prod.outlook.com
 (2603:10b6:408:138::22) To CH2PR12MB5564.namprd12.prod.outlook.com
 (2603:10b6:610:65::24)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:56e0:6d60:67b9:6133:caf:7179]
 (2607:fea8:56e0:6d60:67b9:6133:caf:7179) by
 BN9PR03CA0557.namprd03.prod.outlook.com (2603:10b6:408:138::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Mon, 25 Oct 2021 14:56:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fed77ced-d95d-476c-8460-08d997c79767
X-MS-TrafficTypeDiagnostic: CH0PR12MB5233:
X-Microsoft-Antispam-PRVS: <CH0PR12MB523302907CDB7E5BC997FAD998839@CH0PR12MB5233.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KOA2AtlRAstZe1gbNCR810HoGvzJe3FlmeV86l80jqy5b/pUHmIZ/1h6RC3sq7iKWdsxMIHjFBNBKxtwZBKEW1DtXprG5eQQcF2AED94RxgMZTR6SYFjkkpHMw9EWuBWScDF5F/qulXyNUbjw6rerIWH0/ZsW3RHhAwHo3PIbNA5ECJs63OhkWz9nxXdorakvTGPTJSpPvUYrbSj8amq11i/++24F7cEfehbIfCtelTvtZ5Icp70sYayizph+nlWl2Oemu65ORBlh2ylwq5FfGUIS7b06tHiZ0iB9Umsshsi0l4stBeErMiJUNOnA3iI4Vq9mZz7jPNE80m1m4ey91y/R83JDoNiWexhxa46qk5nk3Ba+oe3vRDmKMs3NstOnhRJmlWeiFcryDGIFn07DiWnVYx/lIBYN7weR4s65lJoD3iZA2NkM17Xfq4DdQKR6/24Xls7tEPQKRmuez33kaJEi1haXM0+RHWZC8dn34hzuKgPLQoWYTonuRpfoD2L7xB7dNfoCpdVbsKywcnaHsUbkmFaMhvNLd78iE5FKgLB99P+D8/JWeaurWG7f6/59JFOAa/34euLxdfCzbdHmx27rI2iPkFb01xMMvFo191iGoDAq5hnOZZIhr07zQmVV1xSjKaSOWgXOJTE++a63HIXJfRMRQDY0ugC9g0bVXUfC6N8mv8UKE9bfqz0v0HBchJwoNIOPvBvXk3QdlLcjkDfaEq3Fk7HkGTPrxNLFuE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB5564.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(4326008)(110136005)(66946007)(508600001)(31686004)(66556008)(54906003)(66476007)(38100700002)(2906002)(2616005)(316002)(186003)(5660300002)(36756003)(83380400001)(6486002)(8676002)(4001150100001)(31696002)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0RyTHRvK250VVhpYjVYYnh2ZEpXWFZJMExXS1lDeXVCWlpPTTcxOFdMYTl2?=
 =?utf-8?B?aHduNVBpd3drNnVCQTZvM0Z3M3lSeWtONERzYW16M05nQ0hOSzJNR0thNGg3?=
 =?utf-8?B?YWhIeGpFdHlPUEZJVHJkS0ZmcUEyWWVUZ0hTUm5Na0I4UzRnUlFaa1M5dXBZ?=
 =?utf-8?B?c2RvZk5UbC9kZzV2Y3V3VzM0cHRDMFdjc1RRdWhpN0M5NGtWVG9DL1VpWm9w?=
 =?utf-8?B?NVZjZEljaVk3dmFvRjIrbk02dFVrMkRmNEVyL05LZTdVVVZkYnRZNy8zWUM1?=
 =?utf-8?B?dVUvOGFWMXhOS0NpcjlpSTVySStTc1Ezb3J6cHpwTjRkbTVpT3VJT05jM0pk?=
 =?utf-8?B?eC9RZFVBTTUzcFFubDh4d2JBaDhpM0xBR2RROENBdmh5bFFnNkkwSVJhc0d2?=
 =?utf-8?B?RFZvTEV3bFBOemxJZEc0OGZOVmlQTDZwVDF0Ni9ORDZZeWdYYkFLb1M3WnRG?=
 =?utf-8?B?WHFjTXplZmdJTk96YnVSVlFEV0hDa3dsL2I5NWRpVDJxdW9YbkVmdWdnT1c2?=
 =?utf-8?B?T2pLSFRNRS8rUFpzaUhoQkhnWkZXRXFSY2FHeUREUmZRUy9GdlllZ2o4bVYr?=
 =?utf-8?B?a2VhVUk1VUtzaFZkMVgza1Y2SFg1Z3ZuSy9YOTJsRHRSRjZFNjVYYi84QkFI?=
 =?utf-8?B?T0ROcVp3VDh5bjQ4NlBVcDB1QmtsczAyUUVKdkJXWTZSS3BxUU04MklEZEhZ?=
 =?utf-8?B?VC9EMXdEaXBpRThrRmh6SVNIMzJHQ2FFMHJ4Q0hnUVJpblpRSllYWklGcmU4?=
 =?utf-8?B?b3FNQzhoY1lhMkhna1VMS2RNSllLVmdSeUk3ZmpuTnpSVnFsQnpoY00ya2V5?=
 =?utf-8?B?MW4zLzIyMEphRkgvanhCMDdnYlJtN3JJdmpkcWNCT3ZNc1Q2N0lJZkJFemJ3?=
 =?utf-8?B?MVhBRnQ5L0VPRzJLc0xVZ2NSNUVVQ2xSOEh4YS9oMjgzcDE4SzUvVGRKUTFY?=
 =?utf-8?B?c25vQy8yYW5vQy9vR0xKN0J0eWVManRabzcyb1NRRUpXQ0k3Y0hPMWRSQVhx?=
 =?utf-8?B?bVJEZ1NMeVdyNGVDUWZvaVlHVVEzdVZsa3ZPWUtNRGJSNHlRbjFLZE5CeS8r?=
 =?utf-8?B?L2FZVDVDWDZON2htamdXSy9kTEpDaWJXcFVPNXBoc0ZxZWcxUjBTRlVpc1BG?=
 =?utf-8?B?T1MrdXFUR0lUcXJFL0hKVVRRM0tQUUFNSURrUjFONlpDcHFUbmpqcGFrL09I?=
 =?utf-8?B?TFgrM1dlQ2ZzMzdxY2pIOXdBcWdhUlI1cVRKcEROZEwxTGJoR21iOTM1R3I2?=
 =?utf-8?B?ckpSaUZrSWRBSGJmaFduYXJ3ckNxK3Z3czMrT1R1MSt0Y3k5L1pma2xiT0lW?=
 =?utf-8?B?OGJEWkhaMWxGTmtoR09hYXpVT3IzSVNKakh0TExma1hvQktqYzc3WlZjS2M1?=
 =?utf-8?B?WWFrSC85OHRpeTlQM3FnaUtBa3cyOWoyamU0OHVyU3pWaTh4c0pCazhOeW5j?=
 =?utf-8?B?SmZTQ1lSaXFRbGJaU1hsZU5EcHE0NWxPc25xSzBoY1RPMlJMTm1OdHVSc1Zo?=
 =?utf-8?B?ejU4dDhTTXhDZFp1L0pXOWJOYWxzNm1EVnlNMkRiWWE0MzVYc05NN05ZZVpL?=
 =?utf-8?B?WnBwK21PRW5ROUFJb2ZtTzlIQ0NwYlVmdEJrR1Q5Q0N6Szh2SVREQ083TzZ4?=
 =?utf-8?B?TlVLSnBxSlVyb1dIR3NUeWdSVm0xR0hMYytvNG16eHZlUUZRdWIzdEp1Nmg3?=
 =?utf-8?B?ZllXNEhaUXJZck50TXdFRWhqWkxTZndhTmtJdHB2NUExaTBpUUpNTWtVZXAy?=
 =?utf-8?B?TzZ1eWVQMTNPNGsvVXd4ZFMvNGNtMk0zNEdHNUM5MWZESSszbEtLV2JWOE9C?=
 =?utf-8?B?WnNQTndRN1B4dFBobXo5UGJ0Tlh3NW5FRmgxYk9aelhQS1hBeHk1THFxeURp?=
 =?utf-8?B?eTVMU2NGaWJjL0ZNNjdwa0g1bzM2b294QVNzMTFWa1d4MnF0UXZRQWRDNCtT?=
 =?utf-8?B?UHlNRWRpcG15YUphbElaaDY0cGdJRnJkMXJOY3FJZ2VkSVBQVDFEd3FHSTNU?=
 =?utf-8?B?c3NMUE9vZnNseWg4OGpmc09wZGo5WCtyZDJrMkFlakpyNmN3TUtDQUNVUjBq?=
 =?utf-8?B?NTE0QUo3aDVtVWg4aTlvcE5xZ01wMUQ1L2tXeDdnUlp6RHhtYzRub1c4RFNE?=
 =?utf-8?B?bitaeTNTaUg3OW1XNjVYN3NCV3Uvc3hVblNPVnZaTlk4amYxdjF2SHdOWUtC?=
 =?utf-8?B?WDNWSVJpWnJLdmFPL0V4Nk55RXA1Y1V6K3plaitJWDFYOFNveTZIZHlrQkcw?=
 =?utf-8?Q?U2trdMF/rTutgpU9P8cBUDg0WIVbvTF4zbRKinMI3o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed77ced-d95d-476c-8460-08d997c79767
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB5564.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 14:56:14.5519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJD1an5KeWmBK+tq2T4qwx+4b97fGZ0Vb7CHzB4LPRWnkBeSC3kiNfgee4CHj6yGHTHTcnbr5LUqhx3a1XRmdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5233
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

Hi Paul,

First of all, thanks for your feedback.

Before I address your comments, I just want to give you some background 
about this type of patchset.

All patches in this series are from a week ago and came from all display 
teams in AMD. Keep in mind that we share our display core with other OS; 
as a result, we have multiple updates every week. To keep the upstream 
aligned with the Display core, we run a weekly process where we extract 
patches made for other people who might be a good candidates to be sent 
to the upstream. The process looks like this (oversimplified):

1. Run a script to check which commit from last week is a good candidate 
to go upstream - finally, port all of those patches to the upstream 
(this is a manual task).
2. Prepare a branch based on amd-staging-drm-next with all the new 
patches on top of it.
3. Send it to our validation team to run an extensive set of tests in 
the new series.
4. If everything is ok, send the patchset to amdgfx.
5. If the test results are positive, we merge this series in the upstream.

Again, that's just a summary; we have way more steps here...

On 2021-10-25 7:25 a.m., Paul Menzel wrote:
> Dear Wenjing, dear Rodrigo,
> 
> 
> On 24.10.21 15:31, Rodrigo Siqueira wrote:
>> From: Wenjing Liu <wenjing.liu@amd.com>
>>
>> [why]
>> We have a regression that cause maximize lane settings to use
>> uninitialized data from unused lanes.
> 
> Which commit caused the regression? Please amend the commit message.

This is one of the situations where the week interval creates some 
descriptions that might sound a little bit different. Basically, this 
patch refers to the patch "implement decide lane settings", in this 
series; however, we noticed that this is not reverted, and that's why we 
decided to keep both patches in this series.

>> This will cause link training to fail for 1 or 2 lanes because the lane
>> adjust is populated incorrectly sometimes.
> 
> On what card did you test this, and how can it be reproduced?

Our DQE team validates this series using multiple ASICs. See the final 
report from Daniel in reply to this series cover letter for more details.

> Please describe the fix/implemantation in the commit message.
> 
>> Reviewed-by: Eric Yang <eric.yang2@amd.com>
>> Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>> Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
>> ---
>>   .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 35 +++++++++++++++++--
>>   1 file changed, 32 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c 
>> b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>> index 653279ab96f4..f6ba7c734f54 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>> @@ -108,6 +108,9 @@ static struct dc_link_settings 
>> get_common_supported_link_settings(
>>           struct dc_link_settings link_setting_b);
>>   static void maximize_lane_settings(const struct 
>> link_training_settings *lt_settings,
>>           struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX]);
>> +static void override_lane_settings(const struct 
>> link_training_settings *lt_settings,
>> +        struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX]);
>> +
>>   static uint32_t get_cr_training_aux_rd_interval(struct dc_link *link,
>>           const struct dc_link_settings *link_settings)
>>   {
>> @@ -734,15 +737,13 @@ void dp_decide_lane_settings(
>>           }
>>   #endif
>>       }
>> -
>> -    /* we find the maximum of the requested settings across all lanes*/
>> -    /* and set this maximum for all lanes*/
>>       dp_hw_to_dpcd_lane_settings(lt_settings, hw_lane_settings, 
>> dpcd_lane_settings);
>>       if (lt_settings->disallow_per_lane_settings) {
>>           /* we find the maximum of the requested settings across all 
>> lanes*/
>>           /* and set this maximum for all lanes*/
>>           maximize_lane_settings(lt_settings, hw_lane_settings);
>> +        override_lane_settings(lt_settings, hw_lane_settings);
>>           if (lt_settings->always_match_dpcd_with_hw_lane_settings)
>>               dp_hw_to_dpcd_lane_settings(lt_settings, 
>> hw_lane_settings, dpcd_lane_settings);
>> @@ -833,6 +834,34 @@ static void maximize_lane_settings(const struct 
>> link_training_settings *lt_setti
>>       }
>>   }
>> +static void override_lane_settings(const struct 
>> link_training_settings *lt_settings,
>> +        struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX])
>> +{
>> +    uint32_t lane;
>> +
>> +    if (lt_settings->voltage_swing == NULL &&
>> +            lt_settings->pre_emphasis == NULL &&
>> +#if defined(CONFIG_DRM_AMD_DC_DP2_0)
>> +            lt_settings->ffe_preset == NULL &&
>> +#endif
>> +            lt_settings->post_cursor2 == NULL)
>> +
>> +        return;
>> +
>> +    for (lane = 1; lane < LANE_COUNT_DP_MAX; lane++) {
>> +        if (lt_settings->voltage_swing)
>> +            lane_settings[lane].VOLTAGE_SWING = 
>> *lt_settings->voltage_swing;
>> +        if (lt_settings->pre_emphasis)
>> +            lane_settings[lane].PRE_EMPHASIS = 
>> *lt_settings->pre_emphasis;
>> +        if (lt_settings->post_cursor2)
>> +            lane_settings[lane].POST_CURSOR2 = 
>> *lt_settings->post_cursor2;
>> +#if defined(CONFIG_DRM_AMD_DC_DP2_0)
>> +        if (lt_settings->ffe_preset)
>> +            lane_settings[lane].FFE_PRESET = *lt_settings->ffe_preset;
>> +#endif
> 
> Normally these checks should be done in C and not the preprocessor. `if 
> CONFIG(DRM_AMD_DC_DP2_0)` or similar should work.

Nice catch! I'm going to drop this CONFIG_DRM_AMD_DC_DP2_0 line.

Thanks
Siqueira

>> +    }
>> +}
>> +
>>   enum dc_status dp_get_lane_status_and_lane_adjust(
>>       struct dc_link *link,
>>       const struct link_training_settings *link_training_setting,
>>
> 
> 
> Kind regards,
> 
> Paul

