Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0918EC6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 12:43:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7630210E0D2;
	Wed, 29 Mar 2023 12:43:50 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8E0110E0F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 12:43:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOZLMjiQk+EWtBbABkppPgowVax2ljpkuI6g6lwpFAvSXp2TYjGdQ3jO5BOgoZqdlHoUsZm4xT4pQYfNKCOjPEeyycrNFbKz74mcHvpLyVkyWi9QomOYikkf3RUHgP6KbAouGawXtVT9zd44MMfzXt+JOiNRk/cp8dI7ubMhNOlZcT7+F1qSxegsdYmow3rofO+RicBEyFQtZ2z7jfVBsOMX5D/f100MrekOnpD/iaf4SZdD5SMb9XPi9dpwtRY+rmCnjfPr7ybomIijS1ggk4yOJfgJmxb8wj+uZWSsMWEdM2SxIoMOQitFPnVxO8yXXPh+KA122IuhNR+dKVbqQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtOB1IIpNTMTKgX0ORSDiWVy9Wn6W1ersgIrPl+ZCM4=;
 b=dFbLKQL+aTmxiZzhpuxL9kmhlCYLr3otRSK9s/YA6DJzg1E99JtULV10Sl3uH7wMASBEhe/bC0InpYuEeacupjCyW9tuOy78l1q17PL/ZhMLTmABg5pU/wGrFLdSk9JfJIQXE+PWCheZk61PO7kGsPXCNIf+Gv15sK8Pci1m4kA2OPHOpN6sh04QLcZmmCAwZ/xz0XnNW1bA79XikhYNfHlILNKQSA6kSBgA8vxeewnmoUJITgN0NFNHI+o5zBkwj5Go+CwNPP8cG627o7W49o3lrMRCHmX6U6rb5Ru6WHHE6yf/j19YKQ8BhZjm0iVAf2S/xZOiO4tjdcRYiQChFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtOB1IIpNTMTKgX0ORSDiWVy9Wn6W1ersgIrPl+ZCM4=;
 b=vRcQICnrrPtdRWuuBFvVPKFd5wTicF2y9KlQwTzgF7fFpJfgRXgmT/KmiFNlk80IfIDvRq+rSAG9c8/OIaXAMFEl3836MX/vhAJFG0NEAD0GGPtBCrTHUihVn0Ty0NsIL4Cn4MbPLN8KakgV8c7FyAgp5aMVDmF3vpQxvPPTEok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MW4PR12MB6923.namprd12.prod.outlook.com (2603:10b6:303:208::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Wed, 29 Mar
 2023 12:43:46 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::b877:9974:5a14:cc37]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::b877:9974:5a14:cc37%4]) with mapi id 15.20.6222.028; Wed, 29 Mar 2023
 12:43:46 +0000
Message-ID: <36d10a1d-c9d2-7c27-59e2-9db19790e1fb@amd.com>
Date: Wed, 29 Mar 2023 08:43:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-CA
To: Tong Liu01 <Tong.Liu01@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329105116.214594-1-Tong.Liu01@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: add sysfs node vclk1 and dclk1
In-Reply-To: <20230329105116.214594-1-Tong.Liu01@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::31) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|MW4PR12MB6923:EE_
X-MS-Office365-Filtering-Correlation-Id: 0429c3e7-4a5a-4f63-660e-08db30533c6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sJlAhX3k5cNf2JSW/aiVBnAgG/OVb1maO9JtRtxCVwQtcjp+uxH4lK1WMXWB0WpxyY1SicSwt6CQ/+XxpKw5610WOmbcKdeAnyKIHECquKLnpwPeiHGE2LHzjtIBcQWlKYLtljr5PpTSAhISkR4bcQirxXhbk6L6wIM2QK5a3OZdWNm6sQxAyGypmhjoc4Tjze/9BrIwQsDxInLs/3ensADk5PpiTYTBIDpi57jOJyCfDZddJd9c+pAZIPN8KKcrCwIvXgkoDDoKthxG1iCfcxGCsvNgy1a6nqTtJuxhQLSAQU9lMbu8satml8PXUiDLr3FiJ/ky07YR/NNCUqfKro7o5l2APHypZB53wC9XeoSHKwfU6K0qYMMMje2xHwfv4WxQXnRhQGva7TonLFrTQ7H/9+sRXX25VMgZj6ChO0wjCnTQgjGH/iLsPH3PnWihN4TSVksGCiI18SIy0unyZFlxyNLhUAjAdNTM7b6uK69W5s67cXH9M8eW5w1iYxX/ilH3UQCy9TrVhyRldDK1pYJXM1nM59UhPMcuzQtHiNh48swK8m/UGWvzS1kQcYkZlw3lwsjg98NP/ZRS9YVdld1t1ONKV4TXxb7Hii/3AcS7sUOBLMY3f8I2k1qO0X8NYULSKAghMG7OoW4B6+DDwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199021)(8936002)(31686004)(2906002)(83380400001)(2616005)(6512007)(86362001)(41300700001)(31696002)(38100700002)(36756003)(5660300002)(6486002)(54906003)(66556008)(478600001)(8676002)(66946007)(66476007)(4326008)(6506007)(6666004)(44832011)(186003)(53546011)(55236004)(316002)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3NyNEN3UmpVdnpDSVRWNS9nb05SUVRMNTlMQ1BTc2xvOE5yZ2FLQUQyaVpD?=
 =?utf-8?B?TWo0SFF6U1RIeGx2Nk9OZjNuK3RSc1hGRkRLbnB4blp0Z2dRaTl1QmM0Tk5v?=
 =?utf-8?B?MzF3WGM3K0QrRjEvekxSK2VzeUt6VlZUR3dQdFl2U2RPcFg5UEM2RmgwUDJH?=
 =?utf-8?B?YzhsWU9MMGlsRmVzNko4ckhIOUdab1RFWmczeXE3YmxZSjdxb0VGMnF0TjZ5?=
 =?utf-8?B?ald1Nm04MjZaYk4zSkZzdmZ0bGNjU0Zja0NLTDZkV3dkaEhYbGVVQzFmK2hp?=
 =?utf-8?B?NzN4RGpYZDVocUh4Nzlra2lhWDRBREJnQnNmVzFBMkVhUE1ETGhjVmVGQytV?=
 =?utf-8?B?bUFMYmlMN2pJRSt5aVpENk5SbUFuRWVTMmVtamNnVFFycFFCK0RIMDF6aEtn?=
 =?utf-8?B?dUgraFNyeUVTL1F5dkNhNllvSmYzVVZZTHRKdmcrTFBwOWxGNll4RG4vRHpQ?=
 =?utf-8?B?VW9nTElVNWVRZ2pzYU9NZGtrek5peUFLajRkazVVU2tlZHJuUWtZd0xQcS8v?=
 =?utf-8?B?K0F6QzdUSUZzaG9WZkY5MjlIck94cmhjQkRuVjd5TzQranVEYlQ4eHNZZ1lN?=
 =?utf-8?B?MTA4dXZicDFrL1E1WEZsMUxPTXNCZ0pMUXZnWXpzelpmVzZCQVVFYUxKN3kx?=
 =?utf-8?B?QnJudjlIak1EcnBYaTY1SWpoQ0h2TzFOMzFxc3dlM05MWk1tUHV0dGdoZDlT?=
 =?utf-8?B?RmdBNjNramFkR1dXYVhhemFsV2wyUVpDMmlvRjdMV25obFBPbFpHM1hPeTNQ?=
 =?utf-8?B?KzduWnhMcDZLRklPYUdTWWk0SkF0OGE5WnNWODFOVEFNdkp6dkFKZTZyTGIz?=
 =?utf-8?B?UWtiTFc3dmNJNjJBcnpleHNaMjdqM3U3U2Njb0NHelpiNE5KUG1uTlFLK2JS?=
 =?utf-8?B?ckE5RDYvajlWMVdMS0xId2xURE1maHJ0RUxIZE5ZeFp6eEtMOE4rREpvWlVL?=
 =?utf-8?B?a0E2bjloOUgxbHBETjhVZUxMYjBHTGVna3Q5ZDFqTWdydmJJYmE5T0o0UWFY?=
 =?utf-8?B?SzdaejZlSGNIR2NQazRFY0V2RWk5cEVYa0srd0NnYVY0cFo3MmZwZVh5Zmkr?=
 =?utf-8?B?bkUrQnJ6RHBvdGNiRENCWkRNU1JEaHI3ckRMbStzcXBCcmZseDhjb2Jzb0Jn?=
 =?utf-8?B?Q1M5RnNTVXFiZmN1SVlMbzRQSXRSQ2ZJZTZ2RDMwb2g2bWwvdlVsT1NVTHp2?=
 =?utf-8?B?QkNaNjlyTFhYRUVFOEtQNTgvV1RkbEZ1Wk9PYTVtQXIrdUsvb2pFdEoxVSt2?=
 =?utf-8?B?a3lMQmthL01nVWlNRm56U0t3NzR1RTZKWjlud3pscDgrS3VzOEtEL2NUYUJr?=
 =?utf-8?B?L09GRGM2TDh4MmFpMTZHQUo2Vm1YSGdJMDVGWjc0SkZNVHFINlZqMk5CUytX?=
 =?utf-8?B?YVFSaVYyRko1akdkS3g4ZzhORkJGVGRLZGlabFM0MFRWcW9PTkFpL3YyM05N?=
 =?utf-8?B?TkZxRHVFK2NWaWhyN1o3MS9ra0M0b2RBcFUwY1R2Z0hjNFN2cUg5QTZMamQ5?=
 =?utf-8?B?L2p3K3AvcUcwMitOK0h1M0tBQm5UM2hZUks0SUo1Z0lhMjQ0QlhyRzhnV3JK?=
 =?utf-8?B?NHRVYmhvOXE4bkUvM1pOeTl3OFdRbEU4RExidDhQWk16TkJ3SW9FMnQwR2F1?=
 =?utf-8?B?eCtpU2JMWTZaU0RQb3BlMzJ2V2dpS25RZFp3ZEZZa3FNcUtwdjNiWktDZ0xY?=
 =?utf-8?B?OFhhM3M4SDF4K0paUnUvM2VOd2hjUmRzWnMrV3BvTHNIQjFWd0hRTDU0dG5U?=
 =?utf-8?B?ZkhjS0tRY0gvR3JQQkRzTGRNZFJ2YVIyTzV2bGxLRXZCNXJkQWJ2OW1GcVl2?=
 =?utf-8?B?YWFMRENzSzZmcmw5RGJObUE5YnNHMU1EUlNvZ2ZmOGtPaTBKUHE5RnRjdjhu?=
 =?utf-8?B?ZDE1bEdQZmxCSjltWWVwcG9tYVFaRTBRTXR6YloveDZBREJldDJtdzluZm04?=
 =?utf-8?B?RjRnNGVqZ2hvUkRaY29sRXk4MS85VE1WV3FXVHppc1E1WXV1SlhHSm91ZWJx?=
 =?utf-8?B?Qkd6YjZvVzRqWDB2TCtJV0xxZ1JlTmJZSzN6OTBzRmkzbGZITytRL0xlTHRs?=
 =?utf-8?B?M2pCUTFweEZyYnhyQW1SZ21FMTR0a0NCV3NPd3lKdEgvb0ZHNksveDl1SENF?=
 =?utf-8?Q?k0HRAtVc6sDYl5Ndo0Ch+B/Wm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0429c3e7-4a5a-4f63-660e-08db30533c6e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 12:43:46.0460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nA/wA28E2/NrwmK8BISGeQ5s7A/wEK1MkXHPNrNE/ACPkCxIWL98tjYuGTijwRq3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6923
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is,

Acked-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2023-03-29 06:51, Tong Liu01 wrote:
> User can check pp_dpm_vclk1 and pp_dpm_dclk1 for DPM frequency of
> vcn and dcn
> 
> Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
> ---
>  .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 ++
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 32 +++++++++++++++++++
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  8 +++++
>  3 files changed, 42 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index 86b6b0c9fb02..9f542f6e19ed 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -104,7 +104,9 @@ enum pp_clock_type {
>  	PP_FCLK,
>  	PP_DCEFCLK,
>  	PP_VCLK,
> +	PP_VCLK1,
>  	PP_DCLK,
> +	PP_DCLK1,
>  	OD_SCLK,
>  	OD_MCLK,
>  	OD_VDDC_CURVE,
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index d75a67cfe523..9991447b5f14 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1180,6 +1180,21 @@ static ssize_t amdgpu_set_pp_dpm_vclk(struct device *dev,
>  	return amdgpu_set_pp_dpm_clock(dev, PP_VCLK, buf, count);
>  }
>  
> +static ssize_t amdgpu_get_pp_dpm_vclk1(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	return amdgpu_get_pp_dpm_clock(dev, PP_VCLK1, buf);
> +}
> +
> +static ssize_t amdgpu_set_pp_dpm_vclk1(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t count)
> +{
> +	return amdgpu_set_pp_dpm_clock(dev, PP_VCLK1, buf, count);
> +}
> +
>  static ssize_t amdgpu_get_pp_dpm_dclk(struct device *dev,
>  		struct device_attribute *attr,
>  		char *buf)
> @@ -1195,6 +1210,21 @@ static ssize_t amdgpu_set_pp_dpm_dclk(struct device *dev,
>  	return amdgpu_set_pp_dpm_clock(dev, PP_DCLK, buf, count);
>  }
>  
> +static ssize_t amdgpu_get_pp_dpm_dclk1(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	return amdgpu_get_pp_dpm_clock(dev, PP_DCLK, buf);
> +}
> +
> +static ssize_t amdgpu_set_pp_dpm_dclk1(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t count)
> +{
> +	return amdgpu_set_pp_dpm_clock(dev, PP_DCLK, buf, count);
> +}
> +
>  static ssize_t amdgpu_get_pp_dpm_dcefclk(struct device *dev,
>  		struct device_attribute *attr,
>  		char *buf)
> @@ -2002,7 +2032,9 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_socclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_fclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_vclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> +	AMDGPU_DEVICE_ATTR_RW(pp_dpm_vclk1,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> +	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dclk1,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dcefclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(pp_dpm_pcie,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(pp_sclk_od,				ATTR_FLAG_BASIC),
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 94fe8593444a..056ac2b512eb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2022,8 +2022,12 @@ static int smu_force_ppclk_levels(void *handle,
>  		clk_type = SMU_DCEFCLK; break;
>  	case PP_VCLK:
>  		clk_type = SMU_VCLK; break;
> +	case PP_VCLK1:
> +		clk_type = SMU_VCLK1; break;
>  	case PP_DCLK:
>  		clk_type = SMU_DCLK; break;
> +	case PP_DCLK1:
> +		clk_type = SMU_DCLK1; break;
>  	case OD_SCLK:
>  		clk_type = SMU_OD_SCLK; break;
>  	case OD_MCLK:
> @@ -2409,8 +2413,12 @@ static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type)
>  		clk_type = SMU_DCEFCLK; break;
>  	case PP_VCLK:
>  		clk_type = SMU_VCLK; break;
> +	case PP_VCLK1:
> +		clk_type = SMU_VCLK1; break;
>  	case PP_DCLK:
>  		clk_type = SMU_DCLK; break;
> +	case PP_DCLK1:
> +		clk_type = SMU_DCLK1; break;
>  	case OD_SCLK:
>  		clk_type = SMU_OD_SCLK; break;
>  	case OD_MCLK:

