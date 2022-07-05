Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5B4C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jul 2022 20:24:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 377FD10E495;
	Tue,  5 Jul 2022 20:24:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9A8910E495
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jul 2022 20:24:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrExY8tNocQe1+S07/ndQF+cmES/RINrY7w7W0RG7CdzUvwW3LhhaZZkTZE+xDYiO9UL7Hdw/WyCa3honwmCwbkXWzzqouQDzP3iNjpS8ndLZWTckRBvmE0g75YBRn2k530+EqrybaqfOev5QbMT8vMvCkYuU39WZv+/ePa8d9PfpTejHs3fkyCYaNhWh+zM+JMeBn33qAWV3eXv0vDTLWqfMBYC7NkxwvDElJHJqJlWN0Y7+AbsVDPsF1WsgDnUiCmHL4t4Jnnz7/6iEaV5o01hw2kI5Av+DZfs5wcD5FfIvZs8R6mry4PmxPB0o8MHNhtDy7SOEQI5ZDcsWEGgIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oq/7oFWuRNg2m5mBCy17xcblET061xIYnhdzCJ60iw0=;
 b=oTYGDwJxJqbcVY8LwdcbqDSsqa6jG7kKdnDuyTL2EglEQQ17AkWfsHNnkzZj/CP+OrMomnSU20X/rJhQZk3J8w8KCpre+9o+dkfl0VYi4J4EZULv8tB26Sehk5Vu8SymLhQVcIH3Mp1sCpol4hzD3nji2aM5rknSF94uHchcmFvfFQes65vJ9Rzttkq9m8cvqzNJdLRKJUQvbDLjsiydRIaBO9l9geSy6czcr8t9ybz1ZJQgxoHtzqnMonelGwu6hTz/IbhJiqxGZYZYoU8i3rYbNKu2FW2l7NLMbjo+8xOLI7aOWcwG/hSMs2pQp1adWuaDEB5fclPAYa99m5MbYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oq/7oFWuRNg2m5mBCy17xcblET061xIYnhdzCJ60iw0=;
 b=TxXcQNNvcM6/Cq/pPVmkhgWrfEtqT/hNOASFpr56Fgq+9ly4gWJa8VCu8SJbwTCqlb2VNC7sd6KUjQkNyvgbRbAX2lLPnaRWo0pE+2Gd3qv9EWLntQhD4q1a57ipQG/FfZUVfLx4Lk/2c9jKJ2w5TevKl987lJA9nJHKR3rwW/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by DM6PR12MB3194.namprd12.prod.outlook.com (2603:10b6:5:184::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Tue, 5 Jul
 2022 20:24:48 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::1563:b9e5:78e3:5c15]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::1563:b9e5:78e3:5c15%6]) with mapi id 15.20.5395.022; Tue, 5 Jul 2022
 20:24:48 +0000
Message-ID: <f5f443cc-86bf-5d42-09e3-e33f09284b22@amd.com>
Date: Tue, 5 Jul 2022 16:24:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] drm/amd: Add debug mask for subviewport mclk switch
Content-Language: en-US
To: Harry Wentland <harry.wentland@amd.com>, alexdeucher@gmail.com,
 amd-gfx@lists.freedesktop.org
References: <20220628212635.2263706-1-aurabindo.pillai@amd.com>
 <3c8f371e-bd5c-3df3-cf25-96b2c81868ee@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <3c8f371e-bd5c-3df3-cf25-96b2c81868ee@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0072.namprd04.prod.outlook.com
 (2603:10b6:610:74::17) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9911f59-d977-4536-ef80-08da5ec46856
X-MS-TrafficTypeDiagnostic: DM6PR12MB3194:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WY9Cv7aGdkw7AByZWmw5f3TVLANtITu9iP7a650M/h0lmpl28UvFMufwgiYjbETHW3TLqoBLd3Pq/Y2Yix5CixX7ahNQprGijL+bo3RiSt3FRaaCIWJ9pEXgMnIwx/V+c3+AkpYh/YNdKY3k//7QvMFgMTtpstFAZ8GqCzT0rm2rNAx1GpDKQO2OhVpE9wmQqrlr6UebbNRl1TXUaFYrGRUDYLy/qxMXwOnhJ4KW3LB+S0vcu/0zNgdi8DVyp5TWx0SBzD9d2y91dry+LMIv1icsn/vhLIxmIMmYQbHF0oKxiM+Co8jzecYuC+arLVdywcSzSAaXKCSZMjqxKR20rH30m25/lNzdoGe8wvanl98GCV03jQuTiryj6w+NxfRgC0PAMpJwVYEnKmHEYb9geecAvkhgUEQjE2c3APmJeFdKDMKvj290A47uFH39Fj08W3CXT2U0x7b4iRHtxhFNljJZZMOgqde7wY581iMlC5iUYjorUxIxTKyFeLa5iL4lZoDM2fwH80H2EfFF2AzX6OVEss642MXdphkBpi2pnKLzoMdKJxyQhncLNe8slL41QA2MyXxN/S1byq/9MKuFjlpeGtTH4go7/YyPA6rW35E8qANRcXeewsow9ggXUKvmTDLFEFzO8gDhCAOZOModD6t1qWAmiYOEzJoeMYpu9xBkTE6ls6KRi3y9aLEUoXHT/fU7dQsYyGK1S9eqFvDJyGGb78gHGEs0JRPGnwcZx+phvcXIn44kRm/Yv3ZwXXbetNGEHWpW8n8IURXasKYNXgYXzin6iq0hzWGxvQ+T98QPFA3oK0bAO9g1jG8q5fbucT87lfqTwvTXPP7kejV+hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(86362001)(31696002)(316002)(38100700002)(2906002)(8936002)(31686004)(6486002)(53546011)(478600001)(6506007)(66556008)(26005)(66476007)(2616005)(83380400001)(36756003)(66946007)(6512007)(186003)(41300700001)(8676002)(5660300002)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDRMWGJpQTVvQXFiYnlFTjhGNmk1V3BDVEZtRXdjcEdCVVI5V0RZUGRyaTBU?=
 =?utf-8?B?NkFRSTJldXNkRjVvSGNaeVYwbTdHZXRvZW41MzFkdHk2SU1RYnFPMjFMeGlz?=
 =?utf-8?B?cEMzTmNoVnJoSkp3UFdVSDRhUmRBMitWR3dqeUVvQXhVbVBiTEVSWDdBQmZq?=
 =?utf-8?B?Q1YwTnhyTGZ6b2o1VDlWQVJnL3RhWFdaNmI0TFBJN0JlSmYzUy9HT0QrNzlG?=
 =?utf-8?B?ODFpdWRHZ2h1MUhHU1czcjl5QUV2Z21tZFlBS1llUWNaY2pKVTVrdklsM3dI?=
 =?utf-8?B?ZE1OVnFZdzFCczdBeDZjaTQ5ZnFVK0pIQ2k4THk2QkhZUW1BdXRVd2NRemZI?=
 =?utf-8?B?SklEb0R6dGJtbmFBcFZZQmRnS3NKUGlUcXEyV3JpOTVwd0gxKzRYM3E5Ulpo?=
 =?utf-8?B?cnRVbzBuSWdRSE5yU09mVVlCU0tVWjFPZlFxMFNKYVo5dWRzQ2MwallQMWg4?=
 =?utf-8?B?Nkd4TVFJK3A2ZmhYUzFvajVidFRvbk9OVHdSMkR4V0N3dUFFSTJiRlNSSTFU?=
 =?utf-8?B?bjZaMzMrN1BVbGgrY0FrQU5CQ2FZWk5KZ3gzV2YvZWJmakVPcjRmUUJiY1I4?=
 =?utf-8?B?Ym03N3VBb3M3dS9kejdLa1FlVUMwSFg4aDRqbXFZUTNYSWp0S2lSTUIycG9S?=
 =?utf-8?B?SEh0TDdoUDRzbVVYQitybS9ZUEQ1WFF5aUV2Z0JLeGJjbVVSUU1Fa3JCaTJ4?=
 =?utf-8?B?bVMwb3lOb2JEeUtnQVhxYmdPOVVOTElSUFVEWDJNWmx4dkhxY0dSazRKdnla?=
 =?utf-8?B?emlJUFdyZVVHVmpSbEEwSU1rMHJ0bkF3Z3MzK0g1a2pjaXdzZFBoN2hRZnA2?=
 =?utf-8?B?cHBWeHVyTXU3WEx5SlQ3RUhsclZtZUM1cE9xM0t4WHUybE9pT0sxVTJuZnFu?=
 =?utf-8?B?RmJjMXN2QWp5NVQxMllTMkFPQmdCRXdQODNKZWl4UkVpNVF2ejI3aGVPR2xB?=
 =?utf-8?B?TEtvYm5RNmY4c1V2VHlnS0ZnK1VHVUIzM1ZrOUNLUmFLZHJlb0xZTUw4ZFBq?=
 =?utf-8?B?MXFNQ1pTdktMeVNlMFVZdjFTNnBRbkRWaXA5a0Y0UXQvN0ZTVjBIaENyalI2?=
 =?utf-8?B?ZVB3TlZlRzVNeHhoMm9rcFppM1pDaENrKzdTUFh3L0pGR0xleGd6NVZ5alRi?=
 =?utf-8?B?NkFQVURYTUFuN1Q2UlZNOGxRWjNBb3dQWVpwUlllRnp1Y1J5bGdQN2dRNy9Q?=
 =?utf-8?B?RkFjSW1Cc01vdHo4cTZMcm5QRTJLMUdZVzRoREZ6eUhtRGFDQXZabUhXcHVu?=
 =?utf-8?B?YjMrUWtUZVFaYmY4c0JCNkdXS1pVVmFheTkwRkNicXJmMkp6MGZReU1qS2Mx?=
 =?utf-8?B?SmFia09IWTFFL1Z3TlhlNU5OenRPWi9XU0lZUDVKekJSNldpVUdodDl4QjA2?=
 =?utf-8?B?TkR2bnFPWXNBMExaS0hFeG9uUWxMZjJDMFNkcXB6dHZqMVBCUTEzN3hkK05P?=
 =?utf-8?B?UTBUMTkwcXE0MGFOQVVDWU9kZytUTTVFVXl5RXp1VDNDeE90Zjd5emNVQlpD?=
 =?utf-8?B?MzJkc0szVWZ3NGQvUUNBaitTWFRKT0RWZVNtL0ptNUY2YjFyYWoxeGhaM0Fq?=
 =?utf-8?B?MkF4ekVsQjFZMmttdVYxRDJRcVFHRVc2aE9IK25uWERTSSsxbElWTmtWbGJs?=
 =?utf-8?B?Z0tGam5xejBEWVNFRzA3WEJYZklwb0dBeDFTMU9XTC9jSDl2TlBCZUdDK3lo?=
 =?utf-8?B?MHVCa0V4VmZScFh4ZE9nSkE5Z3NHcW4zd1hJOVpaYngzY3BlKzhIb1g5MFE4?=
 =?utf-8?B?OXNFTnFEZzNSaDNydmNoR0UxR3NLRS9lVHVzMzR0MWNQRHVTNkhSWUxFMFRz?=
 =?utf-8?B?R0MrT1pqY2VyL0NYNXZKRU9VVlRwUS9IKy9Qem1aYkFGU0RGWmd2K3VKSjZD?=
 =?utf-8?B?VUtPQTB1Y3NaZWpDejYwS3hoc2NsZ2FZQjNJa0N2R3p2T2pseWk0VmdGWVZC?=
 =?utf-8?B?SHpUNE5QZCtsQXdCOTh2eE5ncWRZakhoSnBTMWJvRUtMTndIdnk1R2tjcEE3?=
 =?utf-8?B?aTFZeXJSOHJrem5YT1NKb0FVNUN3d1VjUjdoOXlvcjRqazQrK0tVUXQ4cFlY?=
 =?utf-8?B?QWFtc1JnQVlyUzBqK240TjZvWSswSTdjeUdNWHMyQTdyZHRSdUtjRVE2enZo?=
 =?utf-8?Q?qDhrReDpab44Fg3+77+k2TLjk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9911f59-d977-4536-ef80-08da5ec46856
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 20:24:48.5193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQsWzlNz7Udkjs9St25lzklB621VZ8Qx37/GXtCOOWXO2hkojIyFKObZlGSQsqFf9HbZM1YNHM8rb2bnAhjA/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3194
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



On 2022-07-05 15:53, Harry Wentland wrote:
> 
> 
> On 2022-06-28 17:26, Aurabindo Pillai wrote:
>> [Why&How]
>> Expose a new debugfs enum to force a subviewport memory clock switch
>> to facilitate easy testing.
>>
> 
> Does this force a single switch? Or at regular intervals?

If this debug option is set, each time a MCLK switch happens, a SubVP 
sequences shall be initiated. That is, during the MCLK switch the 
scanout shall be from the Subviewport memory. Setting this option doesnt 
trigger an MCLK switch though.

> 
> It would be useful to describe a bit better what it does.

Will keep that in mind, thanks! Unfortunately I merged it already since 
I got the ack last week.

> 
>> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> 
> Either way, since this is for debug purposes only this is
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> 
> Harry
> 
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
>>   drivers/gpu/drm/amd/include/amd_shared.h          | 1 +
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index c9145864ed2b..7a034ca95be2 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -1559,6 +1559,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>>   	if (amdgpu_dc_debug_mask & DC_DISABLE_CLOCK_GATING)
>>   		adev->dm.dc->debug.disable_clock_gate = true;
>>   
>> +	if (amdgpu_dc_debug_mask & DC_FORCE_SUBVP_MCLK_SWITCH)
>> +		adev->dm.dc->debug.force_subvp_mclk_switch = true;
>> +
>>   	r = dm_dmub_hw_init(adev);
>>   	if (r) {
>>   		DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
>> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
>> index bcdf7453a403..b1c55dd7b498 100644
>> --- a/drivers/gpu/drm/amd/include/amd_shared.h
>> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
>> @@ -247,6 +247,7 @@ enum DC_DEBUG_MASK {
>>   	DC_DISABLE_DSC = 0x4,
>>   	DC_DISABLE_CLOCK_GATING = 0x8,
>>   	DC_DISABLE_PSR = 0x10,
>> +	DC_FORCE_SUBVP_MCLK_SWITCH = 0x20,
>>   };
>>   
>>   enum amd_dpm_forced_level;
> 
