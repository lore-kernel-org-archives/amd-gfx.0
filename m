Return-Path: <SRS0=5bFg=L7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DB2C07E95
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 09:08:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A809261108
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 09:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A809261108
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6709B6E858;
	Wed,  7 Jul 2021 09:08:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B3AB6E858
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jul 2021 09:08:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/VgmLnSXULWgWLLYcSox2BKE1bFCI/FLQtCLycVfiLLpXF0r1PHyCDVamoaBW5B8iGCwBqdbnKuZueUf6XWcpa+tlXPgS5Pwc0gPKq2P07YAd2s8KxVvrGK/K0l/97T6pLTK1iM7Msp3GLRHq6t44+hyw0hLRQo3QIsI19Zzlr1R65PDoqFzExNFPgqe9G+6LP1Jx9J8mKJ8vNDE43ijEUQOcIur7c9RSZyhI+vmcFUl1Z/ocfyKoV29ZJx3whkrk7sy1naSDr5S8+PrpZWWxfBWDOy+Aief8hTC9ilqPhOi4Dj5xPBwXJn9h6rAGaAzIgLPh0j3BJCHjtJVkOcAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkEch+wdtT9hqz+Ba/SDSH4mBTZmc1b0NU9goGEhNqk=;
 b=RLxS7+jz7WIaC3U2pNgRL5wxfr5kUUNG/aiukO9DgbCR0k98UepiNoRAtl0psPBQdblv6iAMm4Q75NRukMXjhGODLjJjcCnXC3IZ7vySrQIT/2EAysyDIQHaT2DqmwVRl2GXme1JEpy+C7bCbgBYyZCVfpfjgiB5n3CFNiG1tgYTFvOM0l27XC9iwatsRYSdKHs9H0uBpTefzDLIVvG9V5tcd0I6vUOGpCTR7V/YfEjyMYcBXAY+WR1JcyREmz1o/+tJgJmTokHuNiGen2f0DhsA7tHTJqKeQGcBUcXdOahQBZJqPWtd9tMMoZUnGpzeLtnbXUDSN8dTUf+0gX3/cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkEch+wdtT9hqz+Ba/SDSH4mBTZmc1b0NU9goGEhNqk=;
 b=Q2ivH8OiJvVqjeVbidu8TtzULfyEIuaXlE5qiBs8WCXS7BgmUOWXVscW1/GB5uwL7XXbgQjEDh5xtXdxbYlF4KLkrt6q/2mLTHkdPXJDvmtxIKGYKT339JJN0YA1yRldPryCl3lyMKJJEC/CsWxuTiOViddvEPuQKVy4dpLa6pg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5074.namprd12.prod.outlook.com (2603:10b6:610:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Wed, 7 Jul
 2021 09:07:59 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::240c:be22:4f42:8068]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::240c:be22:4f42:8068%9]) with mapi id 15.20.4308.021; Wed, 7 Jul 2021
 09:07:59 +0000
Subject: Re: [PATCH 5/7] drm/amd/pm: drop the unnecessary intermediate
 percent-based transition
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210707015647.139127-1-evan.quan@amd.com>
 <20210707015647.139127-5-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <5b46c57a-f51d-2ea0-feac-0b30899555ac@amd.com>
Date: Wed, 7 Jul 2021 14:37:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210707015647.139127-5-evan.quan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: SG3P274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::28)
 To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 SG3P274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 09:07:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a4373ae-05fd-427e-272f-08d94126b78c
X-MS-TrafficTypeDiagnostic: CH0PR12MB5074:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB507469987A6121F90A0F1EDD971A9@CH0PR12MB5074.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Ph1pVDx2KaPm3Xcpw4ez0NvL4w5PUTSyO/lwOWKEi9UZkARL32ZchCWOJhtN75UdMnBT9zCntT8q3FjPOhYMRNT3ZnJP741CVPzy91iv5TSL/UO+qFXm04h1n4zpeceTxQz9ja85kbr6ToMUJC5S5xSgzFV2M25C6EsixpZ1yNwUh34s59dddODRm+HHAYAKzd/FF4zfMn2TjNBKSHXBIKMJDvpTWef3JKMEejTaaEm3VebfHikV3++i6liE0LJbzeK8nQA5VNN5p57AwbiPVc9A1QXoUlLYuExyZWzHVFvydLCh0rIVsMYYKWyhL9kjJE7zXCr4i/2mLYADcUZwxVZUlpksp1X2YSjhhAgrIIxaRGqFtXQ7lYzFDrtKDrikE/U/0uc7oWEYcuoXX7i7khr+sThGjNI+akd8qls6/MBuvia9O4e55dI3wdKqCPBN0GAop+6Xw7PO3HlvP3Gi7e7Of3yY8i3tLbXZTsRa4EKXs2dTC1ioRKmBdt4KlE3B5nKnQM7wYf7ZQqjWx4O1OAzxY5ovD7okeP0s2RLYOYOjbpnveUp1KG5h8ybfDWiTaSN2uqtDrZsxpgnBuzHGAodmlYvgGYX4bllOPLAbdFDHEW9+DQ7mu5p5T8wi0FkDs04fhm4mEzyc1+mjpr7ZnPFGfTj8Rsqao98xHlkIjVDnGUAj26YEejPous2e4r2YBd+psDS+XxiSCvzJUV9kwP8v7TN/Og598ffJDB9sFA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(31696002)(26005)(31686004)(8936002)(2616005)(8676002)(956004)(38100700002)(6666004)(66476007)(83380400001)(2906002)(186003)(478600001)(6486002)(53546011)(4326008)(5660300002)(36756003)(66556008)(316002)(16576012)(30864003)(66946007)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NldkTkF5anlaeWZjQy9IK090NHQ1Q3pzSUlQTWZKUmhYaXdUN1BtRDdiUHUv?=
 =?utf-8?B?RjZtRENXdSszSk9xQmhOWVFVR045bkhtN3lGODVSdFJYWjVyOXNzOENYOWs1?=
 =?utf-8?B?bHVscDdzZ2MrN1IzanVvaEo2eWFtQkRhMzdTN28rSEVoOTBjYkxVdEtqYXlX?=
 =?utf-8?B?TjNKcFUyOEpNbzFGK3h3ejZoT0pZVEhybiszc053UldENmE1NU83RVJUSU5L?=
 =?utf-8?B?WG5aS1ZhdENEZnEydTMxVDV0K1FCTUl0SDZNUm5GVkhmUHI2T1loUG9WRVFO?=
 =?utf-8?B?L1RnbHlCb2NSRzVoSTAvcWNVcGhmTzcxQkRKMDR5YUozQ3FYZGxIMFQrMndB?=
 =?utf-8?B?SjUreFVHbHlzeVV4aXE2d2k1TzYxZUVrUnBuZHpJanoxbXM3eW9mOGpHMm0z?=
 =?utf-8?B?d0F4dTljcmROWU1DWVVldWtZMG4wQUMvbzhocDhKZ0E5R0graEoxSDJLektH?=
 =?utf-8?B?MHR2RU5XMGlQMWFQeDJTSURIQ2ltaTd2Rm1pZ1ZuZ3BjaGxkNnE0aDZoZ2s1?=
 =?utf-8?B?SUdHREhVam9zVnZCd1RvTythOFdlYXhmWmN6ZDNIMk03VFRjZmY4NDdBTXhF?=
 =?utf-8?B?b1g4WUhhTkRJZmxVRnZZbE1FSFM5R09rRjFsdHV2enJvd1FIL0Y2NGZGanhF?=
 =?utf-8?B?OW5UQzBxNjZhM29acjZGbTlpSjlnenBSYUM2Si94N0R3MnhYUjBkWUhHY2hl?=
 =?utf-8?B?MjVGNlRLbVhDd2xvNXR6MkhFeGdvd1VjaFk1SE1hZnZFN2VIeG41NTU4RHMr?=
 =?utf-8?B?MWxJZWVMTHJwa3RiVVdYdi8xVFVRUnRnMzY5eXBOZjcvbDNyYm43aWVTcDZr?=
 =?utf-8?B?K20vNHRCMUt2bXB6Nk01OE94aWhOdWZ4Q0pBdFVvOEJHSUdDbHF5ejFaanFk?=
 =?utf-8?B?SmRwdzdzU3UvR2ZmZktudS9VS3locllrVTgzWjVjNFZXMnNtWTB4dElrdCt6?=
 =?utf-8?B?SCs4WW43YVhBU0pCdXhWZHN5RldQRzUwSG5NZndGUU9vUzJVb3RJMGgrOFpB?=
 =?utf-8?B?bWlvWHROb3Yvb01JYTRuYVE0Sy8ydE1WNll0aEFMT2VRZVIyTFptZ01tSVAy?=
 =?utf-8?B?R3JtVlYySjAvMnlGRVViNjg0T3piWHFPVG5vSHdPeU5iNURvaEhtUTQ2aTND?=
 =?utf-8?B?elVBS2p0TUtGdk9Id2Y2Z0h4WFIzZXh6V2hneVFvYitNME02VDRHRlBrT3ln?=
 =?utf-8?B?eW55V2h2aFJqN25BZTBpL3hyVnZTQithMVQxWnNrTlQrY04vTnZSdko4K2RT?=
 =?utf-8?B?eW9LcFBLMXQweCtrU01xMHFvblRXWG9DTlduZU4xNGlPbTkxc3AvQkprRDNz?=
 =?utf-8?B?VVljcklTVWptbEZXSU5qc2orblVCR2pINlVXbWtlN0xuTW5OQUphWVpWclZo?=
 =?utf-8?B?emtidDA3TjNpYlNNcld4K29vZ0hFdkRMdDNqOHlhNG9pR3o2MWozRG5ueXZI?=
 =?utf-8?B?UDNqY3VwNzlkVjlpK3h5MkRjMkdoemtINFJoL3ZjS1U0cm5uNStHUHFEbjVm?=
 =?utf-8?B?Rm5HU1NqU2treE1HYld2cmJPcDdjS3U4ODJDcWtOMHhVK21GMTJBeHg3T0tS?=
 =?utf-8?B?bGJXTVZ5S252c1o2QTdyV3VPMXRGRHl2Kzg2cnYrYW9Cb255dzJabnlkWjRh?=
 =?utf-8?B?RzJoRUpZbkxucWZFUnF2T0x5d3d6eVJDRXVFSG1mNFN5d0ZqKy9SSlRNQkdh?=
 =?utf-8?B?dWpJRTVlVzNWeFpXNGpjbVRFMTVPWFpmL3BsdGhSLzlwZ3UwUTBCd1NzQkVM?=
 =?utf-8?Q?glACKd2jrjp4TlXMgeh76DIhn+B6EN2F2AgeBpf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4373ae-05fd-427e-272f-08d94126b78c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 09:07:59.4858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ihpYSfPGTgiJJZfRkH3vqwwZ5Tc6d9TxCAw1I1e8PU9/iRP88LJAF1QIwILCbzLR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5074
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
Cc: Alexander.Deucher@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As mentioned in another patch, renaming function to set_/get_ pwm will 
clarify things better. The scale is 0-255 in hwmon as well.

Thanks,
Lijo

On 7/7/2021 7:26 AM, Evan Quan wrote:
> Currently, the readout of fan speed pwm is transited into percent-based
> and then pwm-based. However, the transition into percent-based is totally
> unnecessary and make the final output less accurate.
> 
> Change-Id: Ib99e088cda1875b4e2601f7077a178af6fe8a6cb
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |  4 ----
>   .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |  4 ++--
>   .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c  | 12 ++++++------
>   .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  |  2 +-
>   .../drm/amd/pm/powerplay/hwmgr/vega10_thermal.c    | 10 +++++-----
>   .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c  |  2 +-
>   .../drm/amd/pm/powerplay/hwmgr/vega20_thermal.c    | 12 ++++++------
>   drivers/gpu/drm/amd/pm/powerplay/si_dpm.c          | 10 +++++-----
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          | 12 ++----------
>   drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     | 14 +++++++-------
>   10 files changed, 35 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 769f58d5ae1a..e9c98e3f4cfb 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2469,8 +2469,6 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
>   		return err;
>   	}
>   
> -	value = (value * 100) / 255;
> -
>   	if (adev->powerplay.pp_funcs->set_fan_speed_percent)
>   		err = amdgpu_dpm_set_fan_speed_percent(adev, value);
>   	else
> @@ -2515,8 +2513,6 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
>   	if (err)
>   		return err;
>   
> -	speed = (speed * 255) / 100;
> -
>   	return sprintf(buf, "%i\n", speed);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index 0541bfc81c1b..aa353a628c50 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -3212,7 +3212,7 @@ static int smu7_force_dpm_level(struct pp_hwmgr *hwmgr,
>   
>   	if (!ret) {
>   		if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK && hwmgr->dpm_level != AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
> -			smu7_fan_ctrl_set_fan_speed_percent(hwmgr, 100);
> +			smu7_fan_ctrl_set_fan_speed_percent(hwmgr, 255);
>   		else if (level != AMD_DPM_FORCED_LEVEL_PROFILE_PEAK && hwmgr->dpm_level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
>   			smu7_fan_ctrl_reset_fan_speed_to_default(hwmgr);
>   	}
> @@ -4988,7 +4988,7 @@ static void smu7_set_fan_control_mode(struct pp_hwmgr *hwmgr, uint32_t mode)
>   {
>   	switch (mode) {
>   	case AMD_FAN_CTRL_NONE:
> -		smu7_fan_ctrl_set_fan_speed_percent(hwmgr, 100);
> +		smu7_fan_ctrl_set_fan_speed_percent(hwmgr, 255);
>   		break;
>   	case AMD_FAN_CTRL_MANUAL:
>   		if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
> index 6cfe148ed45b..70ccc127e3fd 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
> @@ -70,12 +70,12 @@ int smu7_fan_ctrl_get_fan_speed_percent(struct pp_hwmgr *hwmgr,
>   		return -EINVAL;
>   
>   
> -	tmp64 = (uint64_t)duty * 100;
> +	tmp64 = (uint64_t)duty * 255;
>   	do_div(tmp64, duty100);
>   	*speed = (uint32_t)tmp64;
>   
> -	if (*speed > 100)
> -		*speed = 100;
> +	if (*speed > 255)
> +		*speed = 255;
>   
>   	return 0;
>   }
> @@ -214,8 +214,8 @@ int smu7_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
>   	if (hwmgr->thermal_controller.fanInfo.bNoFan)
>   		return 0;
>   
> -	if (speed > 100)
> -		speed = 100;
> +	if (speed > 255)
> +		speed = 255;
>   
>   	if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
>   		smu7_fan_ctrl_stop_smc_fan_control(hwmgr);
> @@ -227,7 +227,7 @@ int smu7_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
>   		return -EINVAL;
>   
>   	tmp64 = (uint64_t)speed * duty100;
> -	do_div(tmp64, 100);
> +	do_div(tmp64, 255);
>   	duty = (uint32_t)tmp64;
>   
>   	PHM_WRITE_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__SMC,
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> index 25979106fd25..44c5e2588046 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> @@ -4199,7 +4199,7 @@ static void vega10_set_fan_control_mode(struct pp_hwmgr *hwmgr, uint32_t mode)
>   
>   	switch (mode) {
>   	case AMD_FAN_CTRL_NONE:
> -		vega10_fan_ctrl_set_fan_speed_percent(hwmgr, 100);
> +		vega10_fan_ctrl_set_fan_speed_percent(hwmgr, 255);
>   		break;
>   	case AMD_FAN_CTRL_MANUAL:
>   		if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> index 9b46b27bd30c..6b4c4294afca 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> @@ -78,11 +78,11 @@ int vega10_fan_ctrl_get_fan_speed_percent(struct pp_hwmgr *hwmgr,
>   
>   	if (hwmgr->thermal_controller.
>   			advanceFanControlParameters.usMaxFanRPM != 0)
> -		percent = current_rpm * 100 /
> +		percent = current_rpm * 255 /
>   			hwmgr->thermal_controller.
>   			advanceFanControlParameters.usMaxFanRPM;
>   
> -	*speed = percent > 100 ? 100 : percent;
> +	*speed = percent > 255 ? 255 : percent;
>   
>   	return 0;
>   }
> @@ -257,8 +257,8 @@ int vega10_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
>   	if (hwmgr->thermal_controller.fanInfo.bNoFan)
>   		return 0;
>   
> -	if (speed > 100)
> -		speed = 100;
> +	if (speed > 255)
> +		speed = 255;
>   
>   	if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
>   		vega10_fan_ctrl_stop_smc_fan_control(hwmgr);
> @@ -270,7 +270,7 @@ int vega10_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
>   		return -EINVAL;
>   
>   	tmp64 = (uint64_t)speed * duty100;
> -	do_div(tmp64, 100);
> +	do_div(tmp64, 255);
>   	duty = (uint32_t)tmp64;
>   
>   	WREG32_SOC15(THM, 0, mmCG_FDO_CTRL0,
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> index 0791309586c5..cbe5f8027ee0 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> @@ -2769,7 +2769,7 @@ static void vega20_set_fan_control_mode(struct pp_hwmgr *hwmgr, uint32_t mode)
>   {
>   	switch (mode) {
>   	case AMD_FAN_CTRL_NONE:
> -		vega20_fan_ctrl_set_fan_speed_percent(hwmgr, 100);
> +		vega20_fan_ctrl_set_fan_speed_percent(hwmgr, 255);
>   		break;
>   	case AMD_FAN_CTRL_MANUAL:
>   		if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
> index 43d754952bd9..eb007c00d7c6 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
> @@ -129,12 +129,12 @@ int vega20_fan_ctrl_get_fan_speed_percent(struct pp_hwmgr *hwmgr,
>   	if (!duty100)
>   		return -EINVAL;
>   
> -	tmp64 = (uint64_t)duty * 100;
> +	tmp64 = (uint64_t)duty * 255;
>   	do_div(tmp64, duty100);
>   	*speed = (uint32_t)tmp64;
>   
> -	if (*speed > 100)
> -		*speed = 100;
> +	if (*speed > 255)
> +		*speed = 255;
>   
>   	return 0;
>   }
> @@ -147,8 +147,8 @@ int vega20_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
>   	uint32_t duty;
>   	uint64_t tmp64;
>   
> -	if (speed > 100)
> -		speed = 100;
> +	if (speed > 255)
> +		speed = 255;
>   
>   	if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
>   		vega20_fan_ctrl_stop_smc_fan_control(hwmgr);
> @@ -160,7 +160,7 @@ int vega20_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
>   		return -EINVAL;
>   
>   	tmp64 = (uint64_t)speed * duty100;
> -	do_div(tmp64, 100);
> +	do_div(tmp64, 255);
>   	duty = (uint32_t)tmp64;
>   
>   	WREG32_SOC15(THM, 0, mmCG_FDO_CTRL0,
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> index 15c0b8af376f..96ca359c10a5 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> @@ -6555,12 +6555,12 @@ static int si_dpm_get_fan_speed_percent(void *handle,
>   	if (duty100 == 0)
>   		return -EINVAL;
>   
> -	tmp64 = (u64)duty * 100;
> +	tmp64 = (u64)duty * 255;
>   	do_div(tmp64, duty100);
>   	*speed = (u32)tmp64;
>   
> -	if (*speed > 100)
> -		*speed = 100;
> +	if (*speed > 255)
> +		*speed = 255;
>   
>   	return 0;
>   }
> @@ -6580,7 +6580,7 @@ static int si_dpm_set_fan_speed_percent(void *handle,
>   	if (si_pi->fan_is_controlled_by_smc)
>   		return -EINVAL;
>   
> -	if (speed > 100)
> +	if (speed > 255)
>   		return -EINVAL;
>   
>   	duty100 = (RREG32(CG_FDO_CTRL1) & FMAX_DUTY100_MASK) >> FMAX_DUTY100_SHIFT;
> @@ -6589,7 +6589,7 @@ static int si_dpm_set_fan_speed_percent(void *handle,
>   		return -EINVAL;
>   
>   	tmp64 = (u64)speed * duty100;
> -	do_div(tmp64, 100);
> +	do_div(tmp64, 255);
>   	duty = (u32)tmp64;
>   
>   	tmp = RREG32(CG_FDO_CTRL0) & ~FDO_STATIC_DUTY_MASK;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 54fb3d7d23ee..94c15526ad21 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2565,23 +2565,17 @@ static int smu_get_fan_speed_percent(void *handle, u32 *speed)
>   {
>   	struct smu_context *smu = handle;
>   	int ret = 0;
> -	uint32_t percent;
>   
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
>   
>   	mutex_lock(&smu->mutex);
>   
> -	if (smu->ppt_funcs->get_fan_speed_percent) {
> -		ret = smu->ppt_funcs->get_fan_speed_percent(smu, &percent);
> -		if (!ret) {
> -			*speed = percent > 100 ? 100 : percent;
> -		}
> -	}
> +	if (smu->ppt_funcs->get_fan_speed_percent)
> +		ret = smu->ppt_funcs->get_fan_speed_percent(smu, speed);
>   
>   	mutex_unlock(&smu->mutex);
>   
> -
>   	return ret;
>   }
>   
> @@ -2596,8 +2590,6 @@ static int smu_set_fan_speed_percent(void *handle, u32 speed)
>   	mutex_lock(&smu->mutex);
>   
>   	if (smu->ppt_funcs->set_fan_speed_percent) {
> -		if (speed > 100)
> -			speed = 100;
>   		ret = smu->ppt_funcs->set_fan_speed_percent(smu, speed);
>   		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
>   			smu->user_dpm_profile.custom_fan_speed |= SMU_CUSTOM_FAN_SPEED_PWM;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 0cdf55a0dba2..f0ae0920c07e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1191,8 +1191,8 @@ smu_v11_0_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
>   	uint32_t duty100, duty;
>   	uint64_t tmp64;
>   
> -	if (speed > 100)
> -		speed = 100;
> +	if (speed > 255)
> +		speed = 255;
>   
>   	if (smu_v11_0_auto_fan_control(smu, 0))
>   		return -EINVAL;
> @@ -1203,7 +1203,7 @@ smu_v11_0_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
>   		return -EINVAL;
>   
>   	tmp64 = (uint64_t)speed * duty100;
> -	do_div(tmp64, 100);
> +	do_div(tmp64, 255);
>   	duty = (uint32_t)tmp64;
>   
>   	WREG32_SOC15(THM, 0, mmCG_FDO_CTRL0,
> @@ -1274,12 +1274,12 @@ int smu_v11_0_get_fan_speed_percent(struct smu_context *smu,
>   	if (!duty100)
>   		return -EINVAL;
>   
> -	tmp64 = (uint64_t)duty * 100;
> +	tmp64 = (uint64_t)duty * 255;
>   	do_div(tmp64, duty100);
>   	*speed = (uint32_t)tmp64;
>   
> -	if (*speed > 100)
> -		*speed = 100;
> +	if (*speed > 255)
> +		*speed = 255;
>   
>   	return 0;
>   }
> @@ -1320,7 +1320,7 @@ smu_v11_0_set_fan_control_mode(struct smu_context *smu,
>   
>   	switch (mode) {
>   	case AMD_FAN_CTRL_NONE:
> -		ret = smu_v11_0_set_fan_speed_percent(smu, 100);
> +		ret = smu_v11_0_set_fan_speed_percent(smu, 255);
>   		break;
>   	case AMD_FAN_CTRL_MANUAL:
>   		ret = smu_v11_0_auto_fan_control(smu, 0);
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
