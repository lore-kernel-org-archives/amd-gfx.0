Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7C1E810D6
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Sep 2023 12:01:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB78610E4EC;
	Wed, 27 Sep 2023 12:01:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CF8E10E4EC
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 12:01:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+U0AiwwU4ASY8LfPH1uIbVmO8Qb+3IV13/BVti7LfazEvkE2sooyXnoZsh4sGDn/5JlpNwZ7LErNq+gV6L0PwXNReFPh3Sfz8/GEnLy5IOKfoAVo+eGXnIU9sBy+OhU7x9iZAUaTxQVFKQwDaC+YsOB61KXnCruBv65po4ROZ7MKkrF+mPXHzIRZVDcqbErx0xD6wR3IeUde5Lp/gB7+JpOCzERcMYlBcCN//824BGlZEFBjF9RimvG74LwRPQyS1CQZ/5cFJJXYLpjewndGUr1j9VyVy1qhuAINOYKlTjNl0FcRAn9oU4LUFOLr11cWqQmlKzRTymMScSwLn+sxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdgCLexvTOLEmlqkMa69Wv/xogBlRa/Aop/gacBhilU=;
 b=DmPtMO0iDw8Kq+5vMvHvpN56xORWPMf4vVN4MQ7s759DLT0NIH63Ph4UWvK0xu+24yBJSqFTVRgf9LyGMtQUvNKrJ2legraFwUrykbOtBBXTpsJHZNfKbK6SX9UqVu+voK+DU5zM89ZL0Ze3HwlJw4v+h3GftdotLX7aPxLE6ECdFYffdsusrOZK6YYlJx3eyu8CTWPIvtXJNZKtgGfuRnStJrlX36E47+v6r8eCUQ1vyXvNvBEqu6dcMLfi5MZUpbwv+h09DCTrcREtkadp0kT3Od3PhtAK41mXLCH6iNcF132Qc6Qdq3qg7lCcLswLneNMwr7uFsuLDvJTq/zYJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdgCLexvTOLEmlqkMa69Wv/xogBlRa/Aop/gacBhilU=;
 b=s5oi0SpWQYFCXs9ZMMGsKcMC24z/bUVUuttgh2/vuA3iZrAbnm6rwWYzfBA5mxg+/aUqTb9OJmUKgRTQUMFrnMVx7k1xPKX+hIXwzopaNZnKkTWYsCQ3CqN/pAMgyg6aNLecQm6MJjM/i1i+8tsKjXqylFJYSqpbGIVtnHmOa8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB4944.namprd12.prod.outlook.com (2603:10b6:5:1ba::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 12:01:17 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a7fa:4411:67a3:131d]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a7fa:4411:67a3:131d%4]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 12:01:17 +0000
Message-ID: <5a02f9df-a198-600b-f413-79b60d2a2561@amd.com>
Date: Wed, 27 Sep 2023 14:01:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/amd/display: enable S/G display for for recent APUs
 by default
Content-Language: en-US
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230927054143.2169903-1-yifan1.zhang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230927054143.2169903-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::11) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM6PR12MB4944:EE_
X-MS-Office365-Filtering-Correlation-Id: be738553-2592-45dc-c893-08dbbf517486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5RMyKDYVQ+k2Ij6JVwM2VbgbjiHznCG0nonGmNNE20xvOSHaViKmL9c6fEqvi+54PyTnb79hacIXqRgbjyUK4nYtlkztocJ4RdxGfAJzS9hFqDv9kZoxQIGbJgEknk/8GyvOaqGA8at77WPJGo0322sBGmTQhMKApWm+ETvOoWDPkCJI586K+ntEcJHJ+ThWw+Y4vLX3zqd19F9Bg78iIDtV/7f9XVe6DC2JJFloYmaYzqk7Frol6TNt9wliP4msUdqWVj3O9nLmyGJQUJC2xpTtL3BPNjCFIvCwaqMe+1F4KyislUuhhA85bRaO1c3moOZuGQlhY4gIqBqwGEIUHB8NYxplSJudiN3ARq3uRvFOU+HYQRgeb7mjqOuRyuIV+XKpFC7RGAOFxcyZJor8jS7rbgU7wEbHSRqBpT5YWfl7JF68gxcBdkeTE8tDtKP7PNgVMBBsJf2UQ9TXWUsVB9265I16YsuY9rlTmSGBEsrdzDo4akrpZTjIHZR3IMRiMbuG2sF+sCSoVIUqEB1AnddIbsT1bUwgj0L2BKqDNT5WYHWoYxmo8R/FFeLDbVv2ec0864oVDrEhye6PR2ezUrC4n1frFaga7Ld06cgz7s0+Zk5x+xiZRHEuZGDlzGswI32jiDt27A2OLR82iQEXpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(346002)(39860400002)(376002)(230922051799003)(186009)(1800799009)(451199024)(6666004)(83380400001)(6506007)(38100700002)(66476007)(6512007)(66946007)(26005)(5660300002)(66556008)(41300700001)(8936002)(8676002)(316002)(478600001)(4326008)(6486002)(2906002)(2616005)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MklKMG5qVGxRT2xYNTZoN1NSTGZkTloxV0U4RVQyblJhSW5hSWhCZHY1Y2Z5?=
 =?utf-8?B?YmVicnV3bFRmT0hjTk5QUzRsVVl1aElHbjZSWmcwT2ljUzU0TzdJcEliN2N2?=
 =?utf-8?B?MnNaWFVmWGdxbE5pSzlDMmpqRklVclF4ZXJpeUh1V2xBN1RtTWpSZGdwWk1n?=
 =?utf-8?B?MTYza0ZRK1Z6Q20xM2RmRFBZSy9Od1dhSUlWeXNNU3NiNERKTUdzeDB3bFM1?=
 =?utf-8?B?bWpRa21aZ21YR2dqZU1kS2VqKytMNkpFWHNlV0x1YTZQTHRjV0VHU21NNkdB?=
 =?utf-8?B?S0xpSUo1ZUpxUUJ5aG9hd3dzdHNXYVIydDF0bUlCZVgyTkJ0bmcxTnNKSEMr?=
 =?utf-8?B?Y0JkaWV1VXhWaU9vODh1RU81VDFoZ3YxcFFFdXZqMVJhS2d2bzByOSttOUoz?=
 =?utf-8?B?dFVMT0ovdG1YTGNBNDJCL01vVTB3WXVldG05cUF0UjUwS2FqOFgzNzZaTU1U?=
 =?utf-8?B?cE41V3R5eXNST3lLNG5wOHRJMzFaVVlIM0JRNUNOUWRveUZWM2h4YVE3SmRZ?=
 =?utf-8?B?N2Y4M2dhVFZGLzhGZTU4dUdENE9Ldm5LRFErWklkblZ4S2dxM0cwRm4wa1RQ?=
 =?utf-8?B?eURvRW1QUFhVZVJUcWJLMFBGUks1WmpMWEdRM2tvdzVwSkdJbnVrWG8zR0FI?=
 =?utf-8?B?UU0xaUtuTlVGT0tvcnhiOVpLaEFuOXdPbXJ0MEF2VkkyeHFteUVSQ0Vab0Rl?=
 =?utf-8?B?TWl2dUh4UUlwc0RGTXFJbFIvbndjU3hvV3FkN0NoOVpZWnd5S2xxUlYrMGtz?=
 =?utf-8?B?ZElyeGhBWHpyNDA2TGNuZms1YUsxVk1EYUhCSTFaNmQrS2o1eEpibVJHL0FX?=
 =?utf-8?B?TWNaaXpHaldTVFlxb0tzMC9MSmFvUFZZUmF5Zi9OODBmL3ZrUzlpSU9MVHJu?=
 =?utf-8?B?T0hIZTVGa0R4NDliaGh6Y1EyOU1iWjBTOXNjSG8xV1ltdHQ4L1dmRXJTMjJi?=
 =?utf-8?B?NWRFNHZRQmR1QThhNHc4eTB0ZHVRelNBNGlVMktQbUFuY1JBRHlZK0VPcWp0?=
 =?utf-8?B?YlVTOFFmVWkxTHpqekNTRFBJYU8wYld5V1UwZ296cVVkaC8wWC83SHM4RTZP?=
 =?utf-8?B?cGZmZW9henVjSVM3bjN1dGE1U0R5VGxIMFpXenZzdC96dllXQzBmMFp6Rkll?=
 =?utf-8?B?ZnhJSlRhYUUveWNzZ0lTb2RhK3d3cGQ3WlE4YkJYbzZIbWtlYmFQQzE1MVVt?=
 =?utf-8?B?UGZvSkU2UVJidFVhM0JNb1VCSEo3Ry9MK2RHS3pjV1JXS0Z4dUY1M2o0RTVW?=
 =?utf-8?B?djd3L2FUVGNIL2ZWRjZRaEdJckhBQXNQd09wNEdpUTlPb1VpMG5PVUtxblJX?=
 =?utf-8?B?ZzR0bGk2eTNzTFY0SlFhOW96NytrZTdwbENNMWxWNWtTTE1SMlkyOUQ5M0lt?=
 =?utf-8?B?c1VITy9VUXM5TDBhaG0zZzVEOUVKVnpJVTBtZG5ZSWZVdlV6T29oNWZscVJr?=
 =?utf-8?B?K20rRjNzeFh2aytmMDhqQjlNa2JhRlNNaGpIc1VXZHpiUDBYdXFHMFBWSi9L?=
 =?utf-8?B?MFVaTXZBTzVOSUxQRVA0ZmlrcVd6VGkzZHhpT2wwN3BISzVJUGFRVjJvNjEr?=
 =?utf-8?B?aGVKdmFNN1B4d3c1SHE3RG8ydUk3dkxXZFQzZmpQWGc4d0hnTFZ0ZVhsZFgz?=
 =?utf-8?B?Wlk5bWhiaU5iZHpsL3EvSVVlRjlMZW9tOUxrcktlNWlVK2V4bUNXK2tySGJU?=
 =?utf-8?B?azBBTVRiOVFxaVF3VS94N3IyVm1aQ3FBTWhpcWJHNVorVS9RendEQVVLNVZ4?=
 =?utf-8?B?cEVFcE5ydVZhMW50N1pUTTBiUDhHb05id0pqZFlCS3h2M2lUd0NGeTIwVWFF?=
 =?utf-8?B?Ym96OGQyQ3pnQ0FPWm9jV2pMcHlHRTFnTmovUnFEbVhoZlp5blFROUwzdzBX?=
 =?utf-8?B?akRMUDEyTEZnT1R5RVpsdkl2MHMxVExqeVIrUXRlTGFkTXR0Qk1BTVltcUpy?=
 =?utf-8?B?eUhBYXFuRFYyY3MzclRCdFVJd2x1V00yOHovcG9qQkV4OXBLOUZJSmRmWEth?=
 =?utf-8?B?Q3BUWmJUMDhMRmxFQjFIT2hxRmRpdndOQnVMeThvTWtuZFNTVThIVHhRekt6?=
 =?utf-8?B?ZmsrTjFYYmNOK2c4Ym85enlSSlBlOTBQTWxCWWJiODF1WHNzbDlxUkNleE5x?=
 =?utf-8?Q?GPJEhEc24KPDawMHTNpxZLBVI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be738553-2592-45dc-c893-08dbbf517486
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 12:01:17.7533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTf+E95QYy7C1IjNnn1BAuYAPj+8fGOtM3IrDPOEZ4m2uzozOT902c+wj61z7diA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4944
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
Cc: Alexander.Deucher@amd.com, Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 27.09.23 um 07:41 schrieb Yifan Zhang:
> With S/G display becomes stable, enable S/G display for recent APUs
> by default rather than white list.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 43 +++++--------------
>   1 file changed, 10 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 7e6a693d6369..241fd8defdee 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1626,41 +1626,18 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   		break;
>   	}
>   
> -	switch (adev->asic_type) {
> -	case CHIP_CARRIZO:
> -	case CHIP_STONEY:
> +	if ((adev->asic_type == CHIP_CARRIZO ||
> +		adev->asic_type == CHIP_STONEY ||
> +		((adev->flags & AMD_IS_APU) &&
> +		amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(1, 0, 0) &&
> +		!(adev->apu_flags & AMD_APU_IS_RAVEN))) &&
> +		amdgpu_sg_display != 0) {

Looks like a good idea to me, but please double check your coding style 
settings. The second line of an "if (" should be indented so that it 
starts after the "(" of the previous line.

Additional to that this check actually looks quite messy to me and 
should probably be converted to always using the IP version instead of 
the asic_type.

Regards,
Christian.

>   		init_data.flags.gpu_vm_support = true;
> -		break;
> -	default:
> -		switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
> -		case IP_VERSION(1, 0, 0):
> -		case IP_VERSION(1, 0, 1):
> -			/* enable S/G on PCO and RV2 */
> -			if ((adev->apu_flags & AMD_APU_IS_RAVEN2) ||
> -			    (adev->apu_flags & AMD_APU_IS_PICASSO))
> -				init_data.flags.gpu_vm_support = true;
> -			break;
> -		case IP_VERSION(2, 1, 0):
> -		case IP_VERSION(3, 0, 1):
> -		case IP_VERSION(3, 1, 2):
> -		case IP_VERSION(3, 1, 3):
> -		case IP_VERSION(3, 1, 4):
> -		case IP_VERSION(3, 1, 5):
> -		case IP_VERSION(3, 1, 6):
> -		case IP_VERSION(3, 5, 0):
> -			init_data.flags.gpu_vm_support = true;
> -			break;
> -		default:
> -			break;
> -		}
> -		break;
> -	}
> -	if (init_data.flags.gpu_vm_support &&
> -	    (amdgpu_sg_display == 0))
> -		init_data.flags.gpu_vm_support = false;
> -
> -	if (init_data.flags.gpu_vm_support)
>   		adev->mode_info.gpu_vm_support = true;
> +	} else {
> +		init_data.flags.gpu_vm_support = false;
> +		adev->mode_info.gpu_vm_support = false;
> +	}
>   
>   	if (amdgpu_dc_feature_mask & DC_FBC_MASK)
>   		init_data.flags.fbc_support = true;

