Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D915BC00140
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 16:59:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EA0294916;
	Tue, 26 Jul 2022 16:59:52 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C978C94902
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 16:59:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lT093JH7ecv0V3JNhhTX90cQDn4a1P+aSwSSqSmKIK2jdWasNnd8oBskh1YmMAmRplzHGzLCBYO07b5XUfp6sfc72RtczNgJfDmnk42HASvJj/T4VgucD6xzYI2iM7WnU7CyRTMFxpWoodZ1q065d0d7+Y1RGYtGyDQagtSagjN1fDXhQIkSDVIdVREdbRerbClqHXST/WdKyUUWlTii8nb/44YYU3bLybxypFOZH8TF+wB9Ao0VOURhEcMXQPaLsk2oqYH/g3yhV5EW9qpyDFa4dd1JiNJ9xeXeP//rNC4Ckc8y06nz7iMovtqCHOIbHF2VMAP/9RXd7mMEcwQWiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuJkXIUN8AIh+baO8sYOoMMjgjk5d4sGISC9C/JbUjY=;
 b=XwAkvuMfJpof0/LFcPyAK4rpLwv8I5Kw3vy9OrMsUC9SpS0x6OohosxV9GVBLrBOgW38NdNZ2ysthPNjXMP1S+MTJ6XaykGtEhUskFGbjFQuyylzXRQ705viUF7de92KKBFzVTSUkAzTgt+0kIxtnqkxy7BX7l3Xv5ZMVcw9OBMbzz+hHKOxMnyqsJQfBkAuxlq36bv3K4gbuMFDplvNTnco0f90Q3dZ7pnxGLRKE78hW2rNOIGp/r8V0Fl3zimaEFyEaJeKXPFOZ51UijqiJO5/KqmXiPZ/qy7u/H7ExoUGlcFmScwmcVgccfsauoPHfvT9vj4QoeqmQvyD/XV5Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuJkXIUN8AIh+baO8sYOoMMjgjk5d4sGISC9C/JbUjY=;
 b=xzbA9ITzl6Y6Fa4fXS0ItqIbmEcBECxz6i8AtD18yLaPbcb7Acg6mUIDr6Uz99rh6PtG15pUtHCNPYhygVbWs4EcUB933EXHMP11MVteYXVG4W3HFwrAzsKQhISYTv8Mfkuqkm9Rf3ghAUPZyw7KvxLivoatUppkEM/eJOlAmQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by MWHPR12MB1263.namprd12.prod.outlook.com (2603:10b6:300:f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Tue, 26 Jul
 2022 16:59:48 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91%9]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 16:59:48 +0000
Message-ID: <59684a88-70b3-8c26-835a-4bca41c03c8f@amd.com>
Date: Tue, 26 Jul 2022 12:59:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/5] drm/amdgpu: revert context to stop engine before
 mode2 reset
Content-Language: en-US
To: "Zhao, Victor" <Victor.Zhao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220722073403.5171-1-Victor.Zhao@amd.com>
 <20220722073403.5171-4-Victor.Zhao@amd.com>
 <fbc20b21-8653-b162-fae1-76b8ba5cc3c4@amd.com>
 <DM6PR12MB434019849BC0BBE9A76A792FFA949@DM6PR12MB4340.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <DM6PR12MB434019849BC0BBE9A76A792FFA949@DM6PR12MB4340.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0076.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::19) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27f1f4ad-ce84-4c95-565e-08da6f283f90
X-MS-TrafficTypeDiagnostic: MWHPR12MB1263:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 34Ca9TvLuusoefeKyWUorI/kfkZrxJA11kdSlxk3lJN29Yp5cXJfHUM38NRJUm0e8hq3wEVlWMqpi7JfVCxkgcs085YLcs0ByunA9A1GuUe0Tr5RHFRIzFR0Fp01B3PN9bjgg9fDDluj2r2RhrhaXM1fokMVGXMs+Lcfl3fJuVSNtABL0ixJ/Jk6iS/drYHFiCQqdXCNCzC0HUDwCvSmdqaqZdIcUO9AVkb/YIzC+WAl6h7/AQ7py3UIBHjLspyq2XWO1bfyylf3CGzZKJVZXgmh6uyDns4eUuoZhUCUgb6jTSsZTK9ddS5SuFxaLTNavI8OThPiKxUdldaGkVVYPS7QZzf+ULb5ilmGPhKaeq+Kr+9a7nkIEJBWzuhhqcTvyTCYFbdtgFLgKqGH0hEpyUSF3QNY6qj84LE3fnjrx260xmTkv1oOWAgLqAib49c1meFz3+eD9VFkxvznbxIRZbF0EwwLjHjknl5Qqi/1p07FKYJYUiLetdFQWHIrHDq9z6fUeg5xkYxL0imotVZyKiW/tcpK1B7A6m51a1bL1o5qbA5cUTS6snwOnpDycjcr+qjw1qy6uqZS/JKVll15ckAmVk65THnVoBPQVOcMKkPsmOZVbQtwUD8wlBOdQCibd0BQdYiWyYheI3mJ2iN6vLJWEsin8uv+dFc9bPL301gDFfVjDZEo0oq8iSFh8FID0k4cA9fnh0B+ZeAmqobwmhdyeGL3nleoDRvwuw88KMLO275Ll8984hePXkrv15WH5SbfqGWZU6Oz5/2DlpReHj+bA0xwkaR1Jtzd51gNDMZRmdShEX0hvB6AnXWAvToHMVZKAfBCXhAf31hPKN6GYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(8676002)(6512007)(316002)(44832011)(66556008)(8936002)(4326008)(66946007)(41300700001)(53546011)(5660300002)(6506007)(38100700002)(2906002)(186003)(6486002)(86362001)(36756003)(478600001)(66476007)(83380400001)(31686004)(31696002)(2616005)(110136005)(54906003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?by9jdGpSN1diMjE0aDJkMmxzMkh5NGU4MUt1dFBZRUFQQUlyakQ1eGJCaDMr?=
 =?utf-8?B?M01GdCsrREZLeGUrNFRTTHRZK1RuMkR5em04bXdRWmt4OWlOVUV1SlNiZjBh?=
 =?utf-8?B?SkI2YzFQc285eFJycXJvL0YyYXhaYTlqRUlEMGRLRXpST1Q4Q1liWkJCblpQ?=
 =?utf-8?B?Z0FZQUR5K1RIM3VJbTdUNzc4VmVZOEN5Ry9MaytsVkcyMy9UdzRCZVBqQUIw?=
 =?utf-8?B?dnE3YzNlN3dvNTRaVy9MMTYvUjVEYVdJM3ZPV1RucUY5c2VYRHA0MFFNeit5?=
 =?utf-8?B?dTMzN24rTFk0Yzk4VFJiRnV4MjdNNUNTODlOMUtMQ2pneUsvN3NLR21ReWQ5?=
 =?utf-8?B?OWp1MVh5TkZuM1ZlV0I0M3VrK3FHcElKNUFiWWt5bm03bGJCM0dCRDQ3V3Nk?=
 =?utf-8?B?eFVrNGs3VjJmWVFrTkFhNWFrL25peTM2RXkzY1c4NHprM0NldGV3LzVCWGFu?=
 =?utf-8?B?MFdtamRNYXViaFZhd1RlSzcrc1RQMVUzdGRvWDlVSjArUFVocmtPN1FZVDZY?=
 =?utf-8?B?bnI0cHVKOHlWTi9rVDhuWHV4cjZRZS9WQ3NXWjk3ZVBkT1FKV2trOFVHaENh?=
 =?utf-8?B?L1J0S1dHTHJSTDZXOHk5YndDWFBoNVAzMlFXODN0NHBMbFJmSENMeUl2ZUxL?=
 =?utf-8?B?WlR1QklUcnliN3RhcW5oREM0dWFZZS9ZRUtCUUYzY051RCtCY0RoL09GRUg4?=
 =?utf-8?B?alQxemJxZmV3UFkzRG5zampsenFObUNyazBHb0xNTmxRb2dSeW5uYVVtbExh?=
 =?utf-8?B?S3NSakdqdXo2a2N5b3BNd3FFeTVWa0tUSWRHK1VsaHQrdTJ0T0lGZ0x2azlI?=
 =?utf-8?B?NVhJQmxjSEFFZmozQnZNUnY2aXpwTjRwT0gyeXIyRVM0TUlTVTM1WWd5eDUv?=
 =?utf-8?B?KzhqR3d0WU50c1NOQlZrZ0dhYi9EUkw1T21IeUFmNWovOStsVFhXRzVwU2lE?=
 =?utf-8?B?c0psYkNuTXdLbjZpTzEydy9qeXdya0ZvTmZCMXdXT3ZJeUljWjRLSnlzTTdm?=
 =?utf-8?B?L0VWUjdBeWVxL05CVC9DVkx3Sm1XZjJhbWZtUkd2K21HenJZMzNidEVaUkor?=
 =?utf-8?B?TDRNNkhqaHlMSWd3ZFJNdGx3OTNxVnVIcDNFNFpwMlRCdEhWMkhSV1lISFhX?=
 =?utf-8?B?b2dDTENVMFpYZnNQRys5ZEhLbmJ6S1cxQ1hwUVVWUmNOenVBbjVISFdtSnJL?=
 =?utf-8?B?SFEvbTNnT1dzMFZJMVN0SzV6NmFFbjZ0VWVJV0FSZGtNeTR5R2hub3hRblhG?=
 =?utf-8?B?ZzN5dmZpYk1pT25mZTNqcGV0YVRqNFNHbkhPWGVNT1NORjhESE1kWithSFFo?=
 =?utf-8?B?Mm5KZjU0QzFTWC9wdlNjYVpjelpDY1NQNDkvQ2VUOUZrQVc1cUhtQW52bjNj?=
 =?utf-8?B?dUtSenJVc3RKNzVXeDhCQ25BampCZnZnZ0pDMVRocm1iNnNwNTBqVDZPZFRk?=
 =?utf-8?B?UjZiUGFQakUxVGxlclBzb05DaTZ4bUUxeitKME5TYS8rcEhhSlluM3FPbzhC?=
 =?utf-8?B?RG5KQ0VTM0VBSkxON2RxVEVPSXNFQk9VRFpoa2dpdmR6NjJxempkV0VZeFBT?=
 =?utf-8?B?ZWJ2WGZDVzVJeUwzcHc4a3VOMTlEckFNeWkzd2hkSDVva094OFJUTGlXZ3lV?=
 =?utf-8?B?elBHRWZGMi9rVm5yTXUvR1M1Zm9Hemh0cFJpZS9YejM3YldrYjlGN2U0R1hS?=
 =?utf-8?B?M2lKL2ExMTR3R3VKalNiMERoTkVBZTlYQ0ZhaWdUNjM5SVAvaEdjWS8vSERq?=
 =?utf-8?B?cDNHcWMyZmxMQ1BsOHZHMUxqZUszbG5TbUdkbWVnT0xLU0pldDh0czBFMitk?=
 =?utf-8?B?NkY0a2hlRHdpOG1OM05kcStqVEpYZFg4SXNLblhTbFVSUXFUM2Yvd3pUbjVU?=
 =?utf-8?B?MUhZRU9KdmVRNFdzdVNCY1pkQ21DYndIVDJzZEErS1EwN29OMWFRZksyeExo?=
 =?utf-8?B?VXJjN2FaRW41N3dCM2lpbFdBYlRZZGNETko5MUxmUTRaNzlRRlNLRlh1M0gy?=
 =?utf-8?B?TVhNWEx6d2V4Y3NETUwwU2V2cXZ6S1FvVzByNmVHZEtvdlZyRDEvb0x2N2Zs?=
 =?utf-8?B?K1dDRVEzQ1Y4MFRVYVJmUzNXM0haNXM1enVGY3ZmenNkL2FXWm5TK2tnOXBC?=
 =?utf-8?B?OUZQdGlFakZ1WFFFZlExMjM5Vk05NDJNU3VDYXZmQ2RjUTNTenBpTnlwT2Vp?=
 =?utf-8?Q?U/SeTdfVFiN4fhQRMnCJbEMYewnLND69Bpx4KPX4x7YT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f1f4ad-ce84-4c95-565e-08da6f283f90
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 16:59:48.3864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qofPo/MIwm0reQ1/09nkgPrFzHQTmpXzjKLxy+z5FYidMiA4xXW6Sv7Y9u7dBUINq5LhszdoJIGBLn9OvOCwoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1263
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Deng,
 Emily" <Emily.Deng@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Got it

Acked-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 2022-07-26 06:01, Zhao, Victor wrote:
> [AMD Official Use Only - General]
>
> Hi Andrey,
>
> For slow tests I mean the slow hang tests by quark tool.
> An example here:
> hang_vm_gfx_dispatch_slow.lua - This script runs on a graphics engine using compute engine and has a hacked CS program which is massive and duplicates standard CS program move code hundreds of thousands of times. The effect is a very slowly executing CS program.
>
> It's not a bad job but just need a very long time to finish. I suppose we don’t have a way to stop shader here. And the running apps will be affected when reset is done.
>
>
> Thanks,
> Victor
>
>
>
> -----Original Message-----
> From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> Sent: Tuesday, July 26, 2022 5:20 AM
> To: Zhao, Victor <Victor.Zhao@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Deng, Emily <Emily.Deng@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: Re: [PATCH 4/5] drm/amdgpu: revert context to stop engine before mode2 reset
>
> On 2022-07-22 03:34, Victor Zhao wrote:
>
>> For some hang caused by slow tests, engine cannot be stopped which may
>> cause resume failure after reset. In this case, force halt engine by
>> reverting context addresses
>
> Can you maybe explain a bit more what exactly you mean by slow test and why engine cannot be stopped in this case ?
>
> Andrey
>
>
>> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  1 +
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h  |  1 +
>>    drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c    | 36 +++++++++++++++++++++
>>    drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c |  2 ++
>>    4 files changed, 40 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 5498fda8617f..833dc5e224d3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -5037,6 +5037,7 @@ static void amdgpu_device_recheck_guilty_jobs(
>>    
>>    			/* set guilty */
>>    			drm_sched_increase_karma(s_job);
>> +			amdgpu_reset_prepare_hwcontext(adev, reset_context);
>>    retry:
>>    			/* do hw reset */
>>    			if (amdgpu_sriov_vf(adev)) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
>> index f8036f2b100e..c7b44aeb671b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfxhub.h
>> @@ -37,6 +37,7 @@ struct amdgpu_gfxhub_funcs {
>>    	void (*utcl2_harvest)(struct amdgpu_device *adev);
>>    	void (*mode2_save_regs)(struct amdgpu_device *adev);
>>    	void (*mode2_restore_regs)(struct amdgpu_device *adev);
>> +	void (*halt)(struct amdgpu_device *adev);
>>    };
>>    
>>    struct amdgpu_gfxhub {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
>> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
>> index 51cf8acd2d79..8cf53e039c11 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
>> @@ -646,6 +646,41 @@ static void gfxhub_v2_1_restore_regs(struct amdgpu_device *adev)
>>    	WREG32_SOC15(GC, 0, mmGCMC_VM_MX_L1_TLB_CNTL, adev->gmc.MC_VM_MX_L1_TLB_CNTL);
>>    }
>>    
>> +static void gfxhub_v2_1_halt(struct amdgpu_device *adev) {
>> +	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
>> +	int i;
>> +	uint32_t tmp;
>> +	int time = 1000;
>> +
>> +	gfxhub_v2_1_set_fault_enable_default(adev, false);
>> +
>> +	for (i = 0; i <= 14; i++) {
>> +		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
>> +				    i * hub->ctx_addr_distance, ~0);
>> +		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
>> +				    i * hub->ctx_addr_distance, ~0);
>> +		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,
>> +				    i * hub->ctx_addr_distance,
>> +				    0);
>> +		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
>> +				    i * hub->ctx_addr_distance,
>> +				    0);
>> +	}
>> +	tmp = RREG32_SOC15(GC, 0, mmGRBM_STATUS2);
>> +	while ((tmp & (GRBM_STATUS2__EA_BUSY_MASK |
>> +		      GRBM_STATUS2__EA_LINK_BUSY_MASK)) != 0 &&
>> +	       time) {
>> +		udelay(100);
>> +		time--;
>> +		tmp = RREG32_SOC15(GC, 0, mmGRBM_STATUS2);
>> +	}
>> +
>> +	if (!time) {
>> +		DRM_WARN("failed to wait for GRBM(EA) idle\n");
>> +	}
>> +}
>> +
>>    const struct amdgpu_gfxhub_funcs gfxhub_v2_1_funcs = {
>>    	.get_fb_location = gfxhub_v2_1_get_fb_location,
>>    	.get_mc_fb_offset = gfxhub_v2_1_get_mc_fb_offset, @@ -658,4 +693,5
>> @@ const struct amdgpu_gfxhub_funcs gfxhub_v2_1_funcs = {
>>    	.utcl2_harvest = gfxhub_v2_1_utcl2_harvest,
>>    	.mode2_save_regs = gfxhub_v2_1_save_regs,
>>    	.mode2_restore_regs = gfxhub_v2_1_restore_regs,
>> +	.halt = gfxhub_v2_1_halt,
>>    };
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>> b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>> index 51a5b68f77d3..fead7251292f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>> @@ -97,6 +97,8 @@ sienna_cichlid_mode2_prepare_hwcontext(struct amdgpu_reset_control *reset_ctl,
>>    	if (!amdgpu_sriov_vf(adev)) {
>>    		if (adev->gfxhub.funcs->mode2_save_regs)
>>    			adev->gfxhub.funcs->mode2_save_regs(adev);
>> +		if (adev->gfxhub.funcs->halt)
>> +			adev->gfxhub.funcs->halt(adev);
>>    		r = sienna_cichlid_mode2_suspend_ip(adev);
>>    	}
>>    
