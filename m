Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8CFC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 18:57:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C60910E35F;
	Tue, 18 Jan 2022 18:57:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E31510E35F
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 18:57:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0QVWvc6As6plFbxog5N+KFanwDATmS9EgtwRclumQ9nAdeiNxx1IkCf+CvYka+xyhCVpDIStnPE+7aAgml0Cvy8r0lUFTC4hf068MmZFvwmOkkfXMQY1g+bovsIfBT/5XIV9bG/TqvqeNYC2EZInZjiHO9DlENqcJQpA7+DchSHSciJMdYwo+DRKA83gpkqTa3xVS2Nylk6hEwz3apUfFK4vS33z1rcLjefHES1jPu+dVUwm/QDA4b64njcaXHLsKbda4dSdZFcUQOw7LqLbwTjteDF09ism/bLzSlX1CywuHkZxnhhfpYmbRkCQTmMPrYJtNAnJYy5c+RFtU8p0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcFW/3ybayNFe18Z6p2SY+4EnurEJzKW8DyWxcVtXPY=;
 b=HxZGmcuVX1ku7BtMiW+nU3P4Ps/C92VSEg8/4isLEl9Qk9GUSQtrNZ4P9mCG9S3NXmCSkkkCFLakjwSCl+GM3avYmOlGAwQfYDUnWtClMQRY7NWoaEqNxgT785D/MB1bLDyHyl/obLBvHJfX8fISgtJZ9AaXD/mTO1DNdsdDz/uyGPc/B6hJzkUTKeda9C+sPfr9GFmhQqbDawKzo952cwcv90MYffZ82Oaw1AZLE3s/+3ueraq0q698n64pI9SSQP9cWnQDnDbshaOZYbACdcX+5JSYnO7d5BKbjAJkj6K5fuPVSyxcmxtZRSf0CjDS7UWkoCj2MlQfbX7vFFnv2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcFW/3ybayNFe18Z6p2SY+4EnurEJzKW8DyWxcVtXPY=;
 b=MDiu8VUpaU/m5uIQD4zt8W9/48YnFrD1PAk2NwlVwHNqgSg/IQAlXeqE2KzHlWijSVAzbTp4gyfKQOq5Isy37qSxxP8hyljqflU740fPe7mOiMhvjtddwBQeZRHClC1ZN9oq4HkYWbUv0lVCwAhClZUXpkGvBCZ/ZfN6bB+jq5E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (2603:10b6:208:ab::22)
 by BYAPR12MB3288.namprd12.prod.outlook.com (2603:10b6:a03:130::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 18:57:20 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::44f7:66fe:4419:d8d3]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::44f7:66fe:4419:d8d3%7]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 18:57:20 +0000
Subject: Re: [PATCH] drm/amd/display: Copy crc_skip_count when duplicating
 CRTC state
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Mark Yacoub <markyacoub@chromium.org>, Leo Li <sunpeng.li@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
References: <20220118164004.601780-1-Rodrigo.Siqueira@amd.com>
 <46372b6f-0bb0-72e6-766b-b43afc2783c7@amd.com>
From: Rodrigo Siqueira Jordao <rjordrigo@amd.com>
Message-ID: <9734514b-283f-9121-f2e0-e98f416bb40b@amd.com>
Date: Tue, 18 Jan 2022 13:57:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <46372b6f-0bb0-72e6-766b-b43afc2783c7@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0101.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::16) To MN2PR12MB2896.namprd12.prod.outlook.com
 (2603:10b6:208:ab::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8eb9db91-394c-43cc-8d86-08d9dab45aea
X-MS-TrafficTypeDiagnostic: BYAPR12MB3288:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB32881B5F7EF609D978E1D0CA98589@BYAPR12MB3288.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5wvwCGlRrPJuzgt+KwTq9leMAig7Nb2v519UaCFu03d9gLfWH3dKKXs872JCbxkxaHQzrVNAbQWcx4EvVGoLNgivVoT5Hl7eN3N26Fgo6zsnafQh66G5JwRymJbUe6WK2hWwyjO/mra+6s0Z5iuaSzt5ddy1I8VpwdnriwBzdVZdYbFaydfJLW52E2djqefqn9wz1OpJ9sXng+8g74XN3PPESyCDoQhHdhC00Ep4vmK069484HXmpcmCGMwjm14FUBR8BSAP6v4hoU4SE+C888D+piCqbej1K/gqVFrnKzdkcLaXD6VVdXRE6Azrv9sRBm57qeLO8QpzLeYhH4si/w7/uawENSqwLjYBJcIkMIlC2oCMiXmh37mQQebqE8eEEzuOplbSHAgjbCVXvMK9Ew10GyLbAhQc4ztgXDyRftkQh2xE+puTls16m3N/o+rFtRiCs87qpDQQwCr8jAbF9bIpcXwM7JeLWxCnx4eqHZibES4HlJQJx9vcOxdVxKbfCRVwNwBy5ooRVoEqM7At3qE6ra0iDxlptXWWmZbSITS7CFvrdmXRmipL41spdT9pfX+9XGniYqHcUy+uxb70IwA5oKCQfey0SEukbg/dCpbTyn6IDN5p/CQRO0hJxReTg/hLz6BCua67odSAFNJw0NWM4vxw87T264Ey+/WPoqj1gbjPK2B/O1TERviRT8aA2VLz8hH9CT5Xysb8QbTFT04SCAQlCI4GgC57LnQLZmiejlAmSirAKu8G8aX4WPTH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2896.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(31696002)(966005)(6636002)(54906003)(38100700002)(66946007)(2906002)(31686004)(66556008)(66476007)(2616005)(83380400001)(6512007)(508600001)(110136005)(316002)(6486002)(53546011)(4326008)(36756003)(5660300002)(186003)(6506007)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGVhREh6bStKTHNRMTZnWTF1MmVGWFJYc0djS0kzVlowYkxPd1Z4VkpxOEY5?=
 =?utf-8?B?UGJHd3h4eTFqUmRUKzh1L2F4Z28vcmVQd0pvNWtNSXgwdWxMbzA0dXpvejdM?=
 =?utf-8?B?Y1hNZ3VldXU2VXdDVFJNSmZDejNnQzBIRlIrbzBwcFd3SDBBd0JzMUlZQ0Vn?=
 =?utf-8?B?ak9iQXVqL1ZFa2twSlJqc2pSNG9rWmM3SC91RjRoMlUyYnJpYWdjKzZ1NzdL?=
 =?utf-8?B?ejBqd096Wk1MNG9rdkZpMzg4ZngvTFByVHVPeDFBV3pnZHR5UHJORTJIWmFU?=
 =?utf-8?B?N3VSaHc1a3BJeG8rRTg1R24rRGRwK3p2YzNBc1VjaGNYaEp1bFk5dUtzMUVJ?=
 =?utf-8?B?Smw4M2F2R00zMDRDb1oxUWdJZXY2WTRoTjNHczdPcFNrWGt3RVdLelB2aFRR?=
 =?utf-8?B?L09FOEVpakxaZHAydmRlOElVVjg5bEFMSlhpTEJBUGpMSHd3SzIxRm1EbCsz?=
 =?utf-8?B?TjlLSHJESHQxWUNJNWJjcUQ3TDJyMHJ6T3dsZ2I5UXdyTmI0cE05SmZrV2t0?=
 =?utf-8?B?WWt1MjhQRkg0c2FwR3laZytYYUQrT1VBbVJEUXJETjZ1YWN6WE9QLzBvbU1p?=
 =?utf-8?B?TmczcXllRVBlKytKUnlOV1ZNOVUxQTNNOWM3Wmx3RGFYQW02Zm1pU1A1ZGEr?=
 =?utf-8?B?dEV5RlIxeG1PSEtQODAzUVhwZFpaYmt5UFpTbm1PYkZsRFc3SUd3dVpLTkZ6?=
 =?utf-8?B?NkNPL2dLNUtIN3ZGejJ4MHY3dURMYms2OTVNRlVYOXUyRkVCWmpkeE9McTcv?=
 =?utf-8?B?bFJrdWVUTWJLbjF1bi8wZ01XQmI2RGd3Znk3Y1JtWXFXWDdaYkhnZHhkNHI5?=
 =?utf-8?B?VHErWFJwQ0dWVXdkdkhEWlVnYmlGaWxvOGdIYlduR2YxWjN2eUdYWU95T1Bq?=
 =?utf-8?B?VTdkenFqckhISW1Idnk4RnFBTW0zL3k0SXB2UXdTczhpOWRiYjNPcDN2Y3da?=
 =?utf-8?B?YWRiTzdsZHRuMCtKckZOUis2clhBbm5HMXVoR0FkSVR0b21kU0JJejBUN1JT?=
 =?utf-8?B?QVdmZzgyNWZWVXlSWlkvakRhL051UVQwU0x0Q2Z6a2FHNEFiaWJDb1NmMmk5?=
 =?utf-8?B?cS9VTUROakRDREx5WVFhclRhMi9ueXNYQ1ZCVm9oTUlmWGp6RldycnhCTG92?=
 =?utf-8?B?NkF3SEJyNEtMblJnbGwvMUVZbmZvWEYvMGpBSGFKODlETGVzWkFtSlB4M0RC?=
 =?utf-8?B?bFRBR2Jvb0c5dkV4WmNHMWRoRXdveUp4dG52bXpKMDlJeEtySHg5amZTUWsy?=
 =?utf-8?B?SHVTSytJQ1d1YzFsMkFsb3Y5KzBOYzN1ellBcEo4M1c0UC9GaGc3dmZweTBM?=
 =?utf-8?B?Y1ZwVlhiMDgxd3FWaTBZaXhYYlY1cjZaUzNVdmF4dGc3T1cxdTI4R2I3MDQv?=
 =?utf-8?B?T1p6Yk1vM1dZLzFjVWUzMWo2VHUwcmtvdEpvazFEc1lzd1VjZ1RIdllWODhj?=
 =?utf-8?B?K051RkcwTGs0QmhjazYrOGowVGhoaThqb0FocEhmRjljY2NGWlJEYXE3WGMy?=
 =?utf-8?B?VTVvUWdHRG9WeDdwUktOL3JsMWNiU09GUEZmbUV6QTJoUTVXSHhHVk1HdXhJ?=
 =?utf-8?B?akg4NEdvOEV4TkJSTDNmOUgvcGZTVVp3RGJiUUJEVXB1YTgwVGs2aDlLRGo1?=
 =?utf-8?B?VXpsZ1VJd0szTHRLWXc0a1FLZE9STllCWHp6cjFuR3RtZ0R0NkJFWWpteUYw?=
 =?utf-8?B?bDdPOTFIbWVjSG5CL1lCQnBiUEExMmMxV0htWTd6V2FxRzY1RStLMktJZ2dJ?=
 =?utf-8?B?dVBEbEJDUVBwSUxESllYcVh4cDNGc0NpTXhiTVk3K0VOcGVqSHRRT0k5TjNv?=
 =?utf-8?B?NUFHQjBMQU1RWkFRYkxoTkYvY0RmTHNLdHYzNElpemhQMXorMTFhTDJHZHBu?=
 =?utf-8?B?UmgxS3JmVWJVbjhYbFZ4WmsrREQ1dHZka1VhWUlDTVJuQUozNEg1TkRwWkRh?=
 =?utf-8?B?UEpiM2kyRmdjM0htWnNyVFloVnljUXRlTWEwTkd0eFdCRGVtdVZtcVhJVk4v?=
 =?utf-8?B?YU1Nd0M1SysrdjNJN1VuS0NNbHE5RXRhM0sxN1hUQjl0bVdOZXJ5SGZBZWk0?=
 =?utf-8?B?VHVHbkFJazNZN2Q1WnBubTA0blhUMXU0cC8rS3I2UnduZDIrZ1ViWW1ETzNn?=
 =?utf-8?B?OVBpay9NdTVDaDMxeTJJTUV0MXRVbFN5cis5THcwNDhsZVppZ1RLUVR3a05U?=
 =?utf-8?B?eklSNUZBclJOOGFIb01QYk5PQ2ZCWUNnS3N1b3hVMEg3QmZwMEtqWlVQK1Uy?=
 =?utf-8?Q?OFRwbsO6pzvwk4ilGvR9I7DXueo2ObnIeA4pWnHOAQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb9db91-394c-43cc-8d86-08d9dab45aea
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2896.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 18:57:20.5244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mr5fEtzKmIOcrqjhl4Uze/ZsPUQZHzkKSYStbAQuf36Ir2KMfi5BJ5R64XvMv6vvgEzbkjxj0eGQDUhBaJW0sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3288
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
Cc: Nicholas Choi <Nicholas.Choi@amd.com>, amd-gfx@lists.freedesktop.org,
 Hayden Goodfellow <hayden.goodfellow@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-01-18 11:49 a.m., Kazlauskas, Nicholas wrote:
> On 1/18/2022 11:40 AM, Rodrigo Siqueira wrote:
>> From: Leo Li <sunpeng.li@amd.com>
>>
>> [Why]
>> crc_skip_count is used to track how many frames to skip to allow the OTG
>> CRC engine to "warm up" before it outputs correct CRC values.
>> Experimentally, this seems to be 2 frames.
>>
>> When duplicating CRTC states, this value was not copied to the
>> duplicated state. Therefore, when this state is committed, we will
>> needlessly wait 2 frames before outputing CRC values. Even if the CRC
>> engine is already warmed up. >
>> [How]
>> Copy the crc_skip_count as part of dm_crtc_duplicate_state.
> 
> This likely introduces regressions.
> 
> Here's an example case where it can take two frames even after the CRTC 
> is enabled:
> 
> 1. VUPDATE is before line 0, in the front porch, counter=0
> 2. Flip arrives before VUPDATE is signaled, but does not finish 
> programming until after VUPDATE point, counter=0.
> 3. Vblank counter increments, counter=1.
> 4. Flip programming finishes, counter=1.
> 5. OS delay happens, cursor programming is delayed, counter=1.
> 6. Cursor programming starts, counter=1.
> 7. VUPDATE fires, updating frame but missing cursor, counter=1.
> 8. Cursor programming finishes, counter=2.
> 9. Cursor programming pending for counter=2.
> 
> This is a little contrived, but I've seen something similar happen 
> during IGT testing before.

Hi Nick,

I'm wondering if we have a test that can reproduce the issue that you 
described. For this specific patch, I ran it through our pre-submission 
CI, and everything worked as expected, except the subtest 
pipe-a-primary-size-* in the kms_plane_cursor. However, I submitted the 
below IGT patch that fixed the issue:

  https://patchwork.freedesktop.org/patch/469919/?series=98994&rev=1
  (Note that the IGT fix is not related to the scenario you described.)

In summary, I do not see regressions in other tests, whereas this patch 
fixes multiple CRC mismatches when running IGT (e.g., kms_plane and 
plane_scaling).

Do you recommend running some specific test to reproduce the issue? 
Maybe some particular set of steps that enable me to see the issue?

Ps.: Some IGT tests already compensate for the two extra frames (see 
link [1]), this behavior also happens on other drivers such as i915, and 
we still fail in those tests because we are skipping four frames without 
this patch.
1. 
https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tests/kms_plane.c#L612

Thanks
Siqueira

> This is because cursor update happens independent of the rest of plane 
> programming and is tied to a separate lock. That lock part can't change 
> due to potential for stuttering, but the first part could be fixed.
> 
> Regards,
> Nicholas Kazlauskas
> 
>>
>> Cc: Mark Yacoub <markyacoub@chromium.org>
>> Cc: Hayden Goodfellow <hayden.goodfellow@amd.com>
>> Cc: Harry Wentland <harry.wentland@amd.com>
>> Cc: Nicholas Choi <Nicholas.Choi@amd.com>
>>
>> Signed-off-by: Leo Li <sunpeng.li@amd.com>
>> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 87299e62fe12..5482b0925396 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -6568,6 +6568,7 @@ dm_crtc_duplicate_state(struct drm_crtc *crtc)
>>       state->freesync_config = cur->freesync_config;
>>       state->cm_has_degamma = cur->cm_has_degamma;
>>       state->cm_is_degamma_srgb = cur->cm_is_degamma_srgb;
>> +    state->crc_skip_count = cur->crc_skip_count;
>>       state->force_dpms_off = cur->force_dpms_off;
>>       /* TODO Duplicate dc_stream after objects are stream object is 
>> flattened */
> 

