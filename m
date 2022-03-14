Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB38C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 06:54:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D86AF10E46F;
	Mon, 14 Mar 2022 06:54:06 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2052.outbound.protection.outlook.com [40.107.96.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0BF710E4AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 06:54:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZxg5Xo8ir4SI3IEYAcqkCSsWdvd8BkWEiFFHNQ96MPqIcxlRoRrccuLdNZYhk8cXTYOwXTfs7bCUPCKyeLL5NWSZmVaDL1IGVwbH5arowr4bXDTvAwuMfJSxf4fcnScmUV1tiRBoiwpGYrCPuBTQp0h09+/Ww9IHd+uhl8ZIOshqYZTkk8V9Fd8TtJX1wdijoLDO+aoVMM/NTnIePzzJqUMOijoVVpo0Eh6jHYBtCsJtwRPLwQMykV2d04KIUoNtxLMmnKKEaEldHiVFF/PuBhUXaEC+3Z1iLR4uyt4EiwyXNeFwzNBCvezLEmtp4R9YqzJsVgkk7VlCKDUbw2v7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hjDDVNkc2npwZPibhfAEqgHRaqxyw0O36KIaxWQ76o=;
 b=OyCRoKiAfZZW3DlpOqNmFTg8lkdODoVqqdBu0m1NecSZlohj+aubOXu91iFyS2pD1WzoDKDydL11HXdscMNO4KgSjfA4FJ7ZGUmldKP6Y8Lrs9TzM3vxwFqjWoWFe9KetTSYG4XEBvD4KgV1Zrg7F/d6rqGyuY6hUeXZNCjbSge6zy459oRqlcLvTHuH/yPB3pcQP91BSqlje1rGdDUaxiTpwOOS/QkB1vJnVC8VVbDnw+A1ith+0WKim4BWG0Wk2/eRGyxHL6prAR/60DIqnPo7+ndOMeLZ5/qw27mIRgA/XHNVqBUzrD8qw+mXjUqWMKWb6e/kYuarvjSBBaOFew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hjDDVNkc2npwZPibhfAEqgHRaqxyw0O36KIaxWQ76o=;
 b=ffrn0MqUQJXuXBj+bOj5Ei3+GsOPSf3KsBnFHhl4Iq71c2vjpHjnqMEvuk/CEJIy+08SAj8BXKmseIu8BAE/4j3Ji7dnGGo1wu0oELl9156nh6r9aN7T6jnH1GJ9AFv/N4YfAb9Pxx7MvptxjjLKH2MMq4qjt2j1aaWGqILgx5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1264.namprd12.prod.outlook.com (2603:10b6:300:d::16)
 by BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Mon, 14 Mar
 2022 06:54:03 +0000
Received: from MWHPR12MB1264.namprd12.prod.outlook.com
 ([fe80::f85d:36da:b28d:507c]) by MWHPR12MB1264.namprd12.prod.outlook.com
 ([fe80::f85d:36da:b28d:507c%9]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 06:54:03 +0000
Message-ID: <3d397907-4845-3900-1046-47a6a5cd3fb6@amd.com>
Date: Mon, 14 Mar 2022 12:23:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] amd/display: set backlight only if required
Content-Language: en-US
To: Harry Wentland <hwentlan@amd.com>, Shirish S <shirish.s@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Bhawanpreet.Lakha@amd.com
References: <20220311153320.101332-1-shirish.s@amd.com>
 <0b094720-8c17-db60-bccf-7cdb4ecf6dee@amd.com>
From: "S, Shirish" <sshankar@amd.com>
In-Reply-To: <0b094720-8c17-db60-bccf-7cdb4ecf6dee@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::31) To MWHPR12MB1264.namprd12.prod.outlook.com
 (2603:10b6:300:d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6ec72c8-423c-49f8-b928-08da05876c92
X-MS-TrafficTypeDiagnostic: BN9PR12MB5306:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB53060A15D9CAC76DF1E752A7F20F9@BN9PR12MB5306.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KXbCFlRVb9GeKWOvvPUoJ3rweWVUoa1NFr21BVuWDMDRZYY03OarGh/+oIAOhFIgs4rnwwoyp9XKBLhkot0hRHDwtiepOTJhZDG7WT29mZJTU5ACxB5eYNxnattTjO4Va5EdTI0KTUd5ZCWTrHNER3v53iNpE6Zkz+g9GoBk9gLz24zd+a5uss1puLHaH6FutLH4tqE2kcugZ0ltp+LXnTz+2YJqaAFr80EpKj3NCEq1GuAfeCd8cwGytGsZEz6HbRKPGn5cQDvn7Luk9Jdsl4PkX0ddsoxsO4A6b16DLZeL3sSI3QFLLwWSnGFry0i4pFe+rDigQnx2+r7k55cIWZ7jMGF7wGmcWBFQe5ut14x107HFcAg2FcEpdJWXRm3iKOwFrkT9TB5hSoSjBOVPk7GLvc7pDu8L+9inRtphX3eXaeG6/qVNDw2kf2jpkNOu2KlGj4vYK7DAcZVDy6eQl9tilgEyBbroZip3Ou9cjllq6ENzjER22fig5PB39CLe0ELFBj9xaVwX0vGdi/uy33bhaptielRGUQH3yZzjOfbwg/nL3Rol+3D4tbs3PeEkKS/MyPKO7bYnuDAFYUKRq/fk1ECzaHmrAnZwBF77R4DzAT3iP5hzzFkrI/Ca7o8PgE6FT6R+4y41tLRgfV9fTgcwg4LQcYsaRIgZLyjJVTZ9k1TLrym478ZH5jvLTYsXN2J/zwYjfdaP3XzX+mtYe6/pj0rPF0mBUzbxVrrH8ZI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1264.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(2616005)(31696002)(6512007)(31686004)(2906002)(83380400001)(36756003)(8936002)(6666004)(66476007)(66556008)(4326008)(26005)(186003)(8676002)(66946007)(53546011)(38100700002)(6506007)(316002)(6636002)(110136005)(6486002)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek1xZ0VlTU9BR2txS29TVnlCODdwSXNjd085YzgreDY3bnlvbWVqeFRxSWpQ?=
 =?utf-8?B?SU9PbDBUeEVYM3JNQ09KTUsrZ0RkMW5td25vOXdXb1FLSnp6enluN2U3cDlB?=
 =?utf-8?B?bElSbnhBbVdMMk9JTTUvWldWSkRpVFI4UTEwdEJFbW5ZVlpRTFpVWjQ2bzVQ?=
 =?utf-8?B?MXRXL0xKYlJFWllMeTRTaytYQno5QjROVlFyRzc5VldhMDBjM0pXUGIwZm9h?=
 =?utf-8?B?V2Y1cG9PMXU0TkRSZHU4TVBtOGNwQmFmaW1sL0x4MXl0Ukh4YzRBWXBBVWVo?=
 =?utf-8?B?dElhblByS2ZCdjkvSWdGZnV3aTZPMmxxSVI3ZDFhaHRCZEdFWjBDN1Rzbzlh?=
 =?utf-8?B?VUZFTExlUUkwRVZJcGpZejJ3eVFicThpcGd6UjBvMGZFcVRLTlY5WWFEV1ZO?=
 =?utf-8?B?U1ArZ0RsMmR4Sm1KZSsvREFZaFVVWTNiUzRaQ1BuUS9SY1VOcS9JUkF1cTND?=
 =?utf-8?B?akVQU2pKRTllVXVIa2hkY2JKUnI0MXh5RkdiZmlkRm54WkRXbTRMYVZ1VWJh?=
 =?utf-8?B?b2crTXVMQzk0MDVXL3BORUVvV0thVTRnSEFHK1JmaHYwY2w2dTJVckM2d0JN?=
 =?utf-8?B?Z0dRbzNZSEhncEg3UWRidm54UXM5bEVxODhLR3hUS0RiTnRwc1k3REZaM0FB?=
 =?utf-8?B?dVlvc3JiK1NnMk5OK0puVmRCYnNEemorSUJtT3hHeVZaSUx1WkorUitkVS9j?=
 =?utf-8?B?amlMdFRQZmtPU1hMRmIwUHRsNm5GeFVUR3R4V2w2V3laWTFDQlNZanVwb041?=
 =?utf-8?B?MDA2V0l4NkVuVUNjWUNSRVNKZ3BDWlVLVHNOcUpEYW1LUHdmekJmcU9oUXZi?=
 =?utf-8?B?Y2NjeGFDejNaTUNEd1kwckZZOTdKZk5BeDdETmFDYUpnTmFJNldEbVdNVmho?=
 =?utf-8?B?M0xoRVVaMjlHTVNQRzh0YmNkZ21ySFMyTlFwaGdCSy9DQSs0TUVFUVRDdFdD?=
 =?utf-8?B?ejFYb1FCMUFvd0NjQ3cvWHQvbDZtTUloa2FyTGRPTXZSZytrRE85NEs3SW1h?=
 =?utf-8?B?Z2c5NGJiUEsxQm5sd3docjdoZmZ4TjZpZTFBcG5yc1A2a01sNVVoNnZEYTdL?=
 =?utf-8?B?QTJGNExmemZXcEVKcGFBUHVLRFVJN0VlcGNmS0orRW1KVnpBVjJta0liVmNE?=
 =?utf-8?B?TU1lUXNYOGpudGFqM0xQeGFqWkR6K0dleXNLckJVTWNXOFhqRENjT3I3bER1?=
 =?utf-8?B?NVBiVDNManA5ZkZ1WmxMS3h5WHQyQy9xSmYzajRsYnhzZWhDKzB6c3d2ZzJH?=
 =?utf-8?B?ZEpHUUUyY1Q5Z2lXREhjMmpyTVJoMmV5OFpqMm5obGJkbVlwZm45eEl6QWxH?=
 =?utf-8?B?YWNIRTN6d2NJSm1OdTN3WjhyVGJrWmRtczVNVzlWMU5QUkUrOUVtL1FLM1li?=
 =?utf-8?B?c3lDaWdCL0VKZ1E4MVVCVDh3cmowNHBJNUtWbktQSDJzQjduKzBJT1l2Q3JT?=
 =?utf-8?B?blN6NEZnZW5OQjJuNG5oQU1tQzZyZzJsZGo4WEljSW1iUVJRMFNodVdjNlFQ?=
 =?utf-8?B?UHlkZnVFb2dyOGFISTFHVkl0aUtkZktOclVTYXBBbE1RTE1acTYxZldWS3dW?=
 =?utf-8?B?cUZHWWMyOVdlVnc4T0hxU2M3SUNPVGtqcnQ2YXhhNmNSRVlZQWJGcmh4TUxu?=
 =?utf-8?B?WHpUTkdSLytnS1V6aVZlNCtzSEZIbm1DaGt6NCtFZi9mRGpiQjZuU1RvMlRi?=
 =?utf-8?B?dFVKTldHVHJ6VDN3aVAxeGtmb0dLb1BjSTZXcnZ3ZVVmK2RIM0krd3NUeXNw?=
 =?utf-8?B?U1VGUmdCK1dRN2JPRTJyQWpURi9kTExjMVduM201NkpsNnlEM21sRXBjSmtW?=
 =?utf-8?B?ZkpkTTVTcWE5NU9kN3hHeU1KbWlBV2pvTGZtUEljblhlWERxM2hrNnExVlNW?=
 =?utf-8?B?L3U4UmVSczJZR1FZMjF5RkRuS0tjRlQ2elZVREs0NlhMTHZ6ekFPQU1zVWdX?=
 =?utf-8?Q?iz+NMquO10Sw1PHj6MLt+LEM76kD1Nc+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ec72c8-423c-49f8-b928-08da05876c92
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1264.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 06:54:03.0843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQVuc3qXEwbofCdzZiFIStKF+2h2Xb7zj1PWci8Kd8CXuZTOrc2LNWdjjJxD3orliDCjhs6WM9Xj8JPmbzsuvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5306
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 3/11/2022 9:11 PM, Harry Wentland wrote:
>
> On 3/11/22 10:33, Shirish S wrote:
>> [Why]
>> comparing pwm bl values (coverted) with user brightness(converted)
>> levels in commit_tail leads to continuous setting of backlight via dmub
>> as they don't to match.
> Why do the values not match?

Here is a sample of values:

dmub_abm_get_current_backlight() reads backlight value as 11526 => 
convert_to_user() as 45.

user_brightness value to be set at this point is 159 => 
convert_from_user() gives 40863.

Now, we are continuously comparing 45 (current backlight) with 159 (to 
be set from user space) in every commit tail till any actual changes 
happen to brightness.

Ideally, current brightness/backlight value read from pwm register, when 
converted should yield 159 but it returns 45.

Hence, I believe, there's a bug either in conversion back and forth of 
user space levels or pwm register is not the right way to arrive at 
current brightness values.

>   It looks like the value mismatch
> is our root cause.
Yes, apparently I could not find any other register read that could bail 
us out here and provide actual/proper values, hence this patch.
> I remember a while back looking at an issue
> where we the readback was from DMCU while we were setting BL
> directly via PWM. I wonder if the opposite is happening now.
>
> See this for the previous fix:
> 2bf3d62dabcc drm/amd/display: Get backlight from PWM if DMCU is not initialized

The sample values mentioned above are with this patch applied.

Is there a better way of reading current backlight levels, that reflect 
user space ones?


>> This leads overdrive in queuing of commands to DMCU that sometimes lead
>> to depending on load on DMCU fw:
>>
>> "[drm:dc_dmub_srv_wait_idle] *ERROR* Error waiting for DMUB idle: status=3"
>>
>> [How]
>> Store last successfully set backlight value and compare with it instead
>> of pwm reads which is not what we should compare with.
>>
> Does BL work reliably after S3 or S4 with your change? I wonder if
> there are use-cases that might break because we're no longer comparing
> against the actual BL value but against a stored variable.
I've verified this patch for boot, S0i3 and GUI method of changing 
brightness on ChromeOS
>
>> Signed-off-by: Shirish S <shirish.s@amd.com>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 6 ++++++
>>   2 files changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index df0980ff9a63..2b8337e47861 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -3972,7 +3972,7 @@ static u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *cap
>>   				 max - min);
>>   }
>>   
>> -static int amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
>> +static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
>>   					 int bl_idx,
>>   					 u32 user_brightness)
>>   {
>> @@ -4003,7 +4003,8 @@ static int amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
>>   			DRM_DEBUG("DM: Failed to update backlight on eDP[%d]\n", bl_idx);
>>   	}
>>   
>> -	return rc ? 0 : 1;
>> +	if (rc)
>> +		dm->actual_brightness[bl_idx] = user_brightness;
>>   }
>>   
>>   static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
>> @@ -9944,7 +9945,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>>   	/* restore the backlight level */
>>   	for (i = 0; i < dm->num_of_edps; i++) {
>>   		if (dm->backlight_dev[i] &&
>> -		    (amdgpu_dm_backlight_get_level(dm, i) != dm->brightness[i]))
>> +		    (dm->actual_brightness[i] != dm->brightness[i]))
>>   			amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
>>   	}
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> index 372f9adf091a..321279bc877b 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> @@ -540,6 +540,12 @@ struct amdgpu_display_manager {
>>   	 * cached backlight values.
>>   	 */
>>   	u32 brightness[AMDGPU_DM_MAX_NUM_EDP];
>> +	/**
>> +	 * @actual_brightness:
> "actual" seems misleading here. We might want to call this
> "last" or something along those lines.
>
> But let's first see if we can fix the mismatch of BL reads
> and writes.

Yes, lets thoroughly evaluate if there is any other way.

Regards,

Shirish S

>
> Harry
>
>> +	 *
>> +	 * last successfully applied backlight values.
>> +	 */
>> +	u32 actual_brightness[AMDGPU_DM_MAX_NUM_EDP];
>>   };
>>   
>>   enum dsc_clock_force_state {
