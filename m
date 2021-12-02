Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18761C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 04:28:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80A306E9E3;
	Thu,  2 Dec 2021 04:28:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 670B96E9E3
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 04:28:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFq7LTKMP9D2aRr19gkPqQimtFgffA2gmvyFp8ztCmo4U8flY2DL2Mf+IUvr2A5UG+m+cYZ7Q87W3yntKEh3CA/VNpq5qjrRU2fxSV8qChu208y3OUX0i7bGR2AlNFlk4FiJtWxH/fK+hL76TS5ltrsnjWzcS2tPuaXoWgvrCuHQsQbQc0xnmBOM+7EADyctQkjQxRdoJKAPovJGikuYvK4PkRMxf6qiu0mhk83314gy3ULhONhfSrpHMGZiBGJenG+J4NZg789fPL04dtWzRJGAs8Ik67D4+ZmnQ8qJ1bPkAegnB+9+C+g2PE13q243XaVfsqH2bp35m3rtdpTRzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2IKnV1sy7OZJaGybthuduiYd+xFd/sfbwVn1As+0xM=;
 b=ZBcNDOHOrqJbSU2m9Z4uCGbSskf/Gs3y5KxGNmMC2v7ZqKGeuzDmnb+jzTaoP2G3miW6o7Pge9utMK6zx6btI5X+ZagJysb1qSeCo5OTYFI95xPtZHy2RA8EkBXCHPIFqTYGER/P7rUSntZOdeWR329uBFwWNqkdJInv0AXK/KyHCyGO/0yRh76i/xhAD99rDLf+ltGIKjS9sTcK07EIgudF/z6CXKdzBfMg5CoBIpwoBZ3Nc7Ti7vuoFk8qwjFvZjI0XkWS8eZoiwWBhVQFMOJ8iChuxTVf6U9ABhuAzk7OAWg/fyahRkkdO+TnpxnjgGnjOFpDyk0CncwpqtHwmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2IKnV1sy7OZJaGybthuduiYd+xFd/sfbwVn1As+0xM=;
 b=hzO2r/wX/GkM5FiTvEYuEC2lMzgAcz7PIjiGwtoO0y6ETNKvw356BNBB+Rfj2wSEzE9S9zqrlm1ddz3z72GW7hC4JfqOXPRNDFDHxT+h1QIBUYAXAdhoC0yOyrElmZISrFkRb+R6g3eoSwC4t6bOIIiAq4jp0EOZb0QKWXFG554=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 04:12:58 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4734.024; Thu, 2 Dec 2021
 04:12:58 +0000
Message-ID: <7e4f1675-5047-2994-bb7a-0cf03631b5c6@amd.com>
Date: Thu, 2 Dec 2021 09:42:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V3 01/17] drm/amd/pm: do not expose implementation details
 to other blocks out of power
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211202030930.1681278-1-evan.quan@amd.com>
 <20211202030930.1681278-2-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211202030930.1681278-2-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::32) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BM1PR0101CA0046.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24 via Frontend
 Transport; Thu, 2 Dec 2021 04:12:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e0d089a-69d2-4a4a-e401-08d9b54a05d5
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2491:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2491FBEDAB6723909E43CE4297699@DM5PR1201MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qozwquMBWJ9FW/S88SbNPqjmdMvqWhauEunU414yZm5eI0UucMtNaAuWYkI7FJ3r7UeYnl5phvSebdCT5Kj8AY/EQl6On2eesJfT5BRSC8szDOVhfI+kFNe0uWlyC5AMLqLQcSr3OMUB1+IcJJt3wxsfFBCP7iIcua55ZyXvcPCa+s4IEqHeTA9zN+RV0dWnVDF0gIoAfXYujduiDNL/S6EJDHwvrZ+uis+jDNaw8yR64gGJYt1o9tX/eOHGliIiEn6zg+MosKtj6NVYRgoxrPBKabZCrrm3dA2J6jBqah/lYaATk08x03zGOcpePbyIT4vGN9tKjgqC72V1IUsWBfUg0hRF0xeXscID5n3rhAzNhALzDQgu4ZBQW8SX5OVMZ4yBy/4t2yJqn2ohZbd1ATKIaTSR5FB/QwVsQl+rmOOJAnuPigyoKbMPXCEqJ7T1Wk1kO2E/nkhy6k+t+GIXAn3QD1/ECt43U6Xu978UNSeIvatNvWVpCK5DsQiXOFuc16W+U039nppWBuMzhTiVTZwNP7eqb4cu3Ym7joQI8bD/maZdUKT8I760WLprrJL+u2h1lqEe/DZ2uD9BDcsrToW8SnSc7UrOcnXwY5HJ6O3qcN6OYwz3E7D2ws/BWZwmtaQLFTpvo8Bb6MlV7xyHNmn2eWdrCxouJ//Pw0y6A7jhS97prOzQB5/7TEu757OR6Wx9C/AsdjZ6QqOIDnlc8/uF4yDTuWBkDGunbdNHrVV9rwYwWtvTDghOD9vO9qhH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(30864003)(19627235002)(26005)(4326008)(186003)(2906002)(6486002)(2616005)(8676002)(956004)(5660300002)(31686004)(6666004)(36756003)(86362001)(8936002)(53546011)(508600001)(316002)(16576012)(38100700002)(66946007)(83380400001)(31696002)(66476007)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2lPRGlkMkVBUkJ2ZFlxcGRUZ1FMNDNCeklHWU1ZVzJydU5xNUs0Yk9qc3lk?=
 =?utf-8?B?L1Z6UnhZdFNSSCszQkhwU0JXclU3a3gyYWNwbzlEbCtURWlEcGkvWXAvZVE0?=
 =?utf-8?B?SWJOSG1Ramd1VHZxRlA5VTVNT2lLcncvYWtrN2dlTkZmYWxRY0lkak9jZGFW?=
 =?utf-8?B?czNpVTFMNzZWQ3dKcVFUdTB3NmJ2c0x4UU10T2N5UmxsTE4zM3RDNzlKck8x?=
 =?utf-8?B?M3VXK3dZbWhuOGM5MG8wMDI0Tzd2ZzNaNldDeVVULzI3eFJuS25rS05zQXBz?=
 =?utf-8?B?Ujc2THZtMlVLTXNvaTBzWlk4dTZmMUpaRmNJeFcwRjM0M3RnaDEza3pRVGto?=
 =?utf-8?B?UHZLNW9UN3RNMHVLYURXQ3MzVkNLRmxQM1pvclFEaDBMZ2N5TDFWWEN5dTZa?=
 =?utf-8?B?akU3ZWUzM0JwRkFKd0Z6QTQrTjRIT0Y2Rml3b2RFeklhTEhrbFhSek1WV2Iv?=
 =?utf-8?B?Q3FqZUpjY1VNLzU4WnFuckJ4S1QzZ0FTbzI3ZVA5V2loWHJLU3RxQW9BbWs3?=
 =?utf-8?B?UDgrdUZTTlpyNWpqcGMrUVBZelpUR0c0SHo3eFR2TkZ3YmRtOU5SQ3JvV3Vk?=
 =?utf-8?B?clJ6THh6TmhienQyRTE0clRBV24xK3BGbGJNeGJDMU9lcjFmbStkSzU3Z21U?=
 =?utf-8?B?OUdFL2ZIcjBuWkpBUmdWek9jM2gvQnE1elhqTERIc3Y5SUhzS053V2cvTmNE?=
 =?utf-8?B?ZU5hYTN1ZE4xOVdPOHNJQWp0U3IzTVFiZENIcitlSEpMZGgrd1lTRkJ4TlpE?=
 =?utf-8?B?eHVpSU5CN0VjYU5SVnhXUGdPdXNVc2Iwd2J0NFRlTkpxVjdwR0FZbnFkdEkw?=
 =?utf-8?B?b1pJQmt2UlZoN2lRZXN3aWtGTVdzbHRLK0lzck9NdUxLT3VnS1BxOTJsaDFj?=
 =?utf-8?B?UWpOTzJ5S2RYSERSeEZsTkZBaFZnVVRmVjdqVE5jL0E1WHU0SGhFQTJvdGhJ?=
 =?utf-8?B?UjcyckFFR3NXWkZ0ZWpLNVZuaVUxa0Z4ZzRQT1pMb21TSzNGNm1naEVRNDJP?=
 =?utf-8?B?RTJJWkd0NVlIYkIvMml2cHJoSTFWdUtXbzRBekUwb0kzOHpzUVdkODl3dUQx?=
 =?utf-8?B?RFVLbHhWVVdoT2ZIb3gxY2hwSXRRd0Z3Q253bVRRN0pIbEJwK1pTUDVSQ296?=
 =?utf-8?B?alY3dXcveWJFNlRpZFJmTmNPWlpMaUpaZXlKUEg3c3dESXJxT3dUZEtEOW01?=
 =?utf-8?B?TmRpeTJhOWJEL1NJaFhJVEsxN25HcWl4UElQTnlQbGkwZVVCLzF0eXM4K3Ex?=
 =?utf-8?B?Y1dYS2lzVU5OYWJmWHp6UVlaWjZGdXFVOUVDN1dsYVdKRWl0SGY4UlRVcnVQ?=
 =?utf-8?B?Z0R3MnA3Ujk5YldpWm9QRTIydzlYaXVsK1o0dWVJWVowVVpiYW16NDZSZTRD?=
 =?utf-8?B?TThJTTg4a0lDR0VrVjEvSWVQL2hjbzFyK1BTcEorT2ZLZ0NRVGVsd3pBdTBI?=
 =?utf-8?B?VHZDVDh1b3BZOTBsMzAvTC92cU41dU1OdUJMV200Y25rQklDRXpzMWtzZXEv?=
 =?utf-8?B?QkF4Mm9iZG16MjRSQ1ZOMmoxSUFkem85NEw4dndFdHdTL3FjbTIwakNQaFBp?=
 =?utf-8?B?cHNYZlVpV0JsMFdRWlN0MldzWEVNUlIwVGMyaCtDSml0eHE3RmF1RXY3WWln?=
 =?utf-8?B?MzU2SGk4Wm40OHZSNWpIUGhPS05ndjdJeVpSOUtDdHkzamJJNzMyRnB3QWdy?=
 =?utf-8?B?M3BYeEtTUWgwcGNuN1lGT2FUWnp0VWVRU1RYTEhvUmFmQjFQbjdxOGp3eW10?=
 =?utf-8?B?YVZxK1kwbHNMd1hOOVNPL0ZJQ3V1aE91TkptS3VNcDJacjJrQlhtV1RDVm9C?=
 =?utf-8?B?YzJUYzJQTm9Cbi9lVENqc25YS21MT0NiY0dsWXF5TlAzR3p3ZGZhdzFqZXN5?=
 =?utf-8?B?TDA3Z0lOYmNjZEd2NWpuTGpQMEVpRnNqUlJ6QlNZdTZBRzltZ3pTRjlsUk5v?=
 =?utf-8?B?WG1mT3NWa21nU0JoVjFTOXpnYmFGR1p1OHFGZEErcUZnTGdsU1J3UFpwWmZE?=
 =?utf-8?B?QU0xLzV3VDVka3BZeTRYRXdwNUJ4ODgxbnpaSU56NjR0N3lRTUx3YTRGSUFx?=
 =?utf-8?B?TmE0ZDdWRWZ5WTE0aGo2dXlkYjMzcVhuL0Q1ZUk5dTVUSnBuTHM0ZFUwR3FY?=
 =?utf-8?Q?sIQk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0d089a-69d2-4a4a-e401-08d9b54a05d5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 04:12:58.4124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eh3m+NYXsJfwWdOAQC8unXlxGPYVDG5BXBHIlPmPBnrV7VZbEiH9I5Y5abM1wout
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2491
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
Cc: Alexander.Deucher@amd.com, Kenneth.Feng@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/2/2021 8:39 AM, Evan Quan wrote:
> Those implementation details(whether swsmu supported, some ppt_funcs supported,
> accessing internal statistics ...)should be kept internally. It's not a good
> practice and even error prone to expose implementation details.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: Ibca3462ceaa26a27a9145282b60c6ce5deca7752
> ---
>   drivers/gpu/drm/amd/amdgpu/aldebaran.c        |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   | 25 +++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  6 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 18 +---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  7 --
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  5 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |  5 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   |  2 +-
>   .../gpu/drm/amd/include/kgd_pp_interface.h    |  4 +
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 90 +++++++++++++++++++
>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       | 25 +++++-
>   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       | 11 +--
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 26 +++---
>   13 files changed, 161 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> index bcfdb63b1d42..a545df4efce1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> @@ -260,7 +260,7 @@ static int aldebaran_mode2_restore_ip(struct amdgpu_device *adev)
>   	adev->gfx.rlc.funcs->resume(adev);
>   
>   	/* Wait for FW reset event complete */
> -	r = smu_wait_for_event(adev, SMU_EVENT_RESET_COMPLETE, 0);
> +	r = amdgpu_dpm_wait_for_event(adev, SMU_EVENT_RESET_COMPLETE, 0);

Hi Evan,

As mentioned in the earlier comments, I suggest you to leave these newer 
APIs and take care of the rest of the APIs. These may be covered as 
amdgpu_smu* in another patch set. Till that time, it's not needed to 
move them to amdgpu_dpm (as mentioned before, some of them are are not 
even remotely related to power management).

Thanks,
Lijo

>   	if (r) {
>   		dev_err(adev->dev,
>   			"Failed to get response from firmware after reset\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 164d6a9e9fbb..0d1f00b24aae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1585,22 +1585,25 @@ static int amdgpu_debugfs_sclk_set(void *data, u64 val)
>   		return ret;
>   	}
>   
> -	if (is_support_sw_smu(adev)) {
> -		ret = smu_get_dpm_freq_range(&adev->smu, SMU_SCLK, &min_freq, &max_freq);
> -		if (ret || val > max_freq || val < min_freq)
> -			return -EINVAL;
> -		ret = smu_set_soft_freq_range(&adev->smu, SMU_SCLK, (uint32_t)val, (uint32_t)val);
> -	} else {
> -		return 0;
> +	ret = amdgpu_dpm_get_dpm_freq_range(adev, PP_SCLK, &min_freq, &max_freq);
> +	if (ret == -EOPNOTSUPP) {
> +		ret = 0;
> +		goto out;
>   	}
> +	if (ret || val > max_freq || val < min_freq) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ret = amdgpu_dpm_set_soft_freq_range(adev, PP_SCLK, (uint32_t)val, (uint32_t)val);
> +	if (ret)
> +		ret = -EINVAL;
>   
> +out:
>   	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>   	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>   
> -	if (ret)
> -		return -EINVAL;
> -
> -	return 0;
> +	return ret;
>   }
>   
>   DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1989f9e9379e..41cc1ffb5809 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2617,7 +2617,7 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
>   	if (adev->asic_type == CHIP_ARCTURUS &&
>   	    amdgpu_passthrough(adev) &&
>   	    adev->gmc.xgmi.num_physical_nodes > 1)
> -		smu_set_light_sbr(&adev->smu, true);
> +		amdgpu_dpm_set_light_sbr(adev, true);
>   
>   	if (adev->gmc.xgmi.num_physical_nodes > 1) {
>   		mutex_lock(&mgpu_info.mutex);
> @@ -2857,7 +2857,7 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>   	int i, r;
>   
>   	if (adev->in_s0ix)
> -		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D3Entry);
> +		amdgpu_dpm_gfx_state_change(adev, sGpuChangeState_D3Entry);
>   
>   	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
>   		if (!adev->ip_blocks[i].status.valid)
> @@ -3982,7 +3982,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
>   		return 0;
>   
>   	if (adev->in_s0ix)
> -		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D0Entry);
> +		amdgpu_dpm_gfx_state_change(adev, sGpuChangeState_D0Entry);
>   
>   	/* post card */
>   	if (amdgpu_device_need_post(adev)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 1916ec84dd71..3d8f82dc8c97 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -615,7 +615,7 @@ int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value)
>   
>   	mutex_lock(&adev->gfx.gfx_off_mutex);
>   
> -	r = smu_get_status_gfxoff(adev, value);
> +	r = amdgpu_dpm_get_status_gfxoff(adev, value);
>   
>   	mutex_unlock(&adev->gfx.gfx_off_mutex);
>   
> @@ -852,19 +852,3 @@ int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev)
>   	}
>   	return amdgpu_num_kcq;
>   }
> -
> -/* amdgpu_gfx_state_change_set - Handle gfx power state change set
> - * @adev: amdgpu_device pointer
> - * @state: gfx power state(1 -sGpuChangeState_D0Entry and 2 -sGpuChangeState_D3Entry)
> - *
> - */
> -
> -void amdgpu_gfx_state_change_set(struct amdgpu_device *adev, enum gfx_change_state state)
> -{
> -	mutex_lock(&adev->pm.mutex);
> -	if (adev->powerplay.pp_funcs &&
> -	    adev->powerplay.pp_funcs->gfx_state_change_set)
> -		((adev)->powerplay.pp_funcs->gfx_state_change_set(
> -			(adev)->powerplay.pp_handle, state));
> -	mutex_unlock(&adev->pm.mutex);
> -}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index f851196c83a5..776c886fd94a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -47,12 +47,6 @@ enum amdgpu_gfx_pipe_priority {
>   	AMDGPU_GFX_PIPE_PRIO_HIGH = AMDGPU_RING_PRIO_2
>   };
>   
> -/* Argument for PPSMC_MSG_GpuChangeState */
> -enum gfx_change_state {
> -	sGpuChangeState_D0Entry = 1,
> -	sGpuChangeState_D3Entry,
> -};
> -
>   #define AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM  0
>   #define AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM  15
>   
> @@ -410,5 +404,4 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
>   uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);
>   void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
>   int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev);
> -void amdgpu_gfx_state_change_set(struct amdgpu_device *adev, enum gfx_change_state state);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 3c623e589b79..35c4aec04a7e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -901,7 +901,7 @@ static void amdgpu_ras_get_ecc_info(struct amdgpu_device *adev, struct ras_err_d
>   	 * choosing right query method according to
>   	 * whether smu support query error information
>   	 */
> -	ret = smu_get_ecc_info(&adev->smu, (void *)&(ras->umc_ecc));
> +	ret = amdgpu_dpm_get_ecc_info(adev, (void *)&(ras->umc_ecc));
>   	if (ret == -EOPNOTSUPP) {
>   		if (adev->umc.ras_funcs &&
>   			adev->umc.ras_funcs->query_ras_error_count)
> @@ -2132,8 +2132,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
>   		if (ret)
>   			goto free;
>   
> -		if (adev->smu.ppt_funcs && adev->smu.ppt_funcs->send_hbm_bad_pages_num)
> -			adev->smu.ppt_funcs->send_hbm_bad_pages_num(&adev->smu, con->eeprom_control.ras_num_recs);
> +		amdgpu_dpm_send_hbm_bad_pages_num(adev, con->eeprom_control.ras_num_recs);
>   	}
>   
>   #ifdef CONFIG_X86_MCE_AMD
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index 6e4bea012ea4..5fed26c8db44 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -97,7 +97,7 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
>   	int ret = 0;
>   
>   	kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
> -	ret = smu_get_ecc_info(&adev->smu, (void *)&(con->umc_ecc));
> +	ret = amdgpu_dpm_get_ecc_info(adev, (void *)&(con->umc_ecc));
>   	if (ret == -EOPNOTSUPP) {
>   		if (adev->umc.ras_funcs &&
>   		    adev->umc.ras_funcs->query_ras_error_count)
> @@ -160,8 +160,7 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
>   						err_data->err_addr_cnt);
>   			amdgpu_ras_save_bad_pages(adev);
>   
> -			if (adev->smu.ppt_funcs && adev->smu.ppt_funcs->send_hbm_bad_pages_num)
> -				adev->smu.ppt_funcs->send_hbm_bad_pages_num(&adev->smu, con->eeprom_control.ras_num_recs);
> +			amdgpu_dpm_send_hbm_bad_pages_num(adev, con->eeprom_control.ras_num_recs);
>   		}
>   
>   		amdgpu_ras_reset_gpu(adev);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index deae12dc777d..329a4c89f1e6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -222,7 +222,7 @@ void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
>   
>   	len = snprintf(fifo_in, sizeof(fifo_in), "%x %llx:%llx\n",
>   		       KFD_SMI_EVENT_THERMAL_THROTTLE, throttle_bitmask,
> -		       atomic64_read(&dev->adev->smu.throttle_int_counter));
> +		       amdgpu_dpm_get_thermal_throttling_counter(dev->adev));
>   
>   	add_event_to_kfifo(dev, KFD_SMI_EVENT_THERMAL_THROTTLE,	fifo_in, len);
>   }
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index 5c0867ebcfce..2e295facd086 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -26,6 +26,10 @@
>   
>   extern const struct amdgpu_ip_block_version pp_smu_ip_block;
>   
> +enum smu_event_type {
> +	SMU_EVENT_RESET_COMPLETE = 0,
> +};
> +
>   struct amd_vce_state {
>   	/* vce clocks */
>   	u32 evclk;
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 08362d506534..54abdf7080de 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -1614,3 +1614,93 @@ int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_versio
>   
>   	return 0;
>   }
> +
> +int amdgpu_dpm_set_light_sbr(struct amdgpu_device *adev, bool enable)
> +{
> +	return smu_set_light_sbr(&adev->smu, enable);
> +}
> +
> +int amdgpu_dpm_send_hbm_bad_pages_num(struct amdgpu_device *adev, uint32_t size)
> +{
> +	return smu_send_hbm_bad_pages_num(&adev->smu, size);
> +}
> +
> +int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
> +				  enum pp_clock_type type,
> +				  uint32_t *min,
> +				  uint32_t *max)
> +{
> +	if (!is_support_sw_smu(adev))
> +		return -EOPNOTSUPP;
> +
> +	switch (type) {
> +	case PP_SCLK:
> +		return smu_get_dpm_freq_range(&adev->smu, SMU_SCLK, min, max);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +int amdgpu_dpm_set_soft_freq_range(struct amdgpu_device *adev,
> +				   enum pp_clock_type type,
> +				   uint32_t min,
> +				   uint32_t max)
> +{
> +	if (!is_support_sw_smu(adev))
> +		return -EOPNOTSUPP;
> +
> +	switch (type) {
> +	case PP_SCLK:
> +		return smu_set_soft_freq_range(&adev->smu, SMU_SCLK, min, max);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +int amdgpu_dpm_wait_for_event(struct amdgpu_device *adev,
> +			      enum smu_event_type event,
> +			      uint64_t event_arg)
> +{
> +	if (!is_support_sw_smu(adev))
> +		return -EOPNOTSUPP;
> +
> +	return smu_wait_for_event(&adev->smu, event, event_arg);
> +}
> +
> +int amdgpu_dpm_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value)
> +{
> +	if (!is_support_sw_smu(adev))
> +		return -EOPNOTSUPP;
> +
> +	return smu_get_status_gfxoff(&adev->smu, value);
> +}
> +
> +uint64_t amdgpu_dpm_get_thermal_throttling_counter(struct amdgpu_device *adev)
> +{
> +	return atomic64_read(&adev->smu.throttle_int_counter);
> +}
> +
> +/* amdgpu_dpm_gfx_state_change - Handle gfx power state change set
> + * @adev: amdgpu_device pointer
> + * @state: gfx power state(1 -sGpuChangeState_D0Entry and 2 -sGpuChangeState_D3Entry)
> + *
> + */
> +void amdgpu_dpm_gfx_state_change(struct amdgpu_device *adev,
> +				 enum gfx_change_state state)
> +{
> +	mutex_lock(&adev->pm.mutex);
> +	if (adev->powerplay.pp_funcs &&
> +	    adev->powerplay.pp_funcs->gfx_state_change_set)
> +		((adev)->powerplay.pp_funcs->gfx_state_change_set(
> +			(adev)->powerplay.pp_handle, state));
> +	mutex_unlock(&adev->pm.mutex);
> +}
> +
> +int amdgpu_dpm_get_ecc_info(struct amdgpu_device *adev,
> +			    void *umc_ecc)
> +{
> +	if (!is_support_sw_smu(adev))
> +		return -EOPNOTSUPP;
> +
> +	return smu_get_ecc_info(&adev->smu, umc_ecc);
> +}
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index 16e3f72d31b9..7289d379a9fb 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -23,6 +23,12 @@
>   #ifndef __AMDGPU_DPM_H__
>   #define __AMDGPU_DPM_H__
>   
> +/* Argument for PPSMC_MSG_GpuChangeState */
> +enum gfx_change_state {
> +	sGpuChangeState_D0Entry = 1,
> +	sGpuChangeState_D3Entry,
> +};
> +
>   enum amdgpu_int_thermal_type {
>   	THERMAL_TYPE_NONE,
>   	THERMAL_TYPE_EXTERNAL,
> @@ -574,5 +580,22 @@ void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable);
>   void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable);
>   void amdgpu_pm_print_power_states(struct amdgpu_device *adev);
>   int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_version);
> -
> +int amdgpu_dpm_set_light_sbr(struct amdgpu_device *adev, bool enable);
> +int amdgpu_dpm_send_hbm_bad_pages_num(struct amdgpu_device *adev, uint32_t size);
> +int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
> +				       enum pp_clock_type type,
> +				       uint32_t *min,
> +				       uint32_t *max);
> +int amdgpu_dpm_set_soft_freq_range(struct amdgpu_device *adev,
> +				        enum pp_clock_type type,
> +				        uint32_t min,
> +				        uint32_t max);
> +int amdgpu_dpm_wait_for_event(struct amdgpu_device *adev, enum smu_event_type event,
> +		       uint64_t event_arg);
> +int amdgpu_dpm_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value);
> +uint64_t amdgpu_dpm_get_thermal_throttling_counter(struct amdgpu_device *adev);
> +void amdgpu_dpm_gfx_state_change(struct amdgpu_device *adev,
> +				 enum gfx_change_state state);
> +int amdgpu_dpm_get_ecc_info(struct amdgpu_device *adev,
> +			    void *umc_ecc);
>   #endif
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index f738f7dc20c9..942297c69de0 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -241,11 +241,6 @@ struct smu_user_dpm_profile {
>   	uint32_t clk_dependency;
>   };
>   
> -enum smu_event_type {
> -
> -	SMU_EVENT_RESET_COMPLETE = 0,
> -};
> -
>   #define SMU_TABLE_INIT(tables, table_id, s, a, d)	\
>   	do {						\
>   		tables[table_id].size = s;		\
> @@ -1412,15 +1407,15 @@ int smu_set_ac_dc(struct smu_context *smu);
>   
>   int smu_allow_xgmi_power_down(struct smu_context *smu, bool en);
>   
> -int smu_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value);
> +int smu_get_status_gfxoff(struct smu_context *smu, uint32_t *value);
>   
>   int smu_set_light_sbr(struct smu_context *smu, bool enable);
>   
> -int smu_wait_for_event(struct amdgpu_device *adev, enum smu_event_type event,
> +int smu_wait_for_event(struct smu_context *smu, enum smu_event_type event,
>   		       uint64_t event_arg);
>   int smu_get_ecc_info(struct smu_context *smu, void *umc_ecc);
>   int smu_stb_collect_info(struct smu_context *smu, void *buff, uint32_t size);
>   void amdgpu_smu_stb_debug_fs_init(struct amdgpu_device *adev);
> -
> +int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint32_t size);
>   #endif
>   #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 5839918cb574..d8cd7c8c4479 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -100,17 +100,14 @@ static int smu_sys_set_pp_feature_mask(void *handle,
>   	return ret;
>   }
>   
> -int smu_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value)
> +int smu_get_status_gfxoff(struct smu_context *smu, uint32_t *value)
>   {
> -	int ret = 0;
> -	struct smu_context *smu = &adev->smu;
> +	if (!smu->ppt_funcs->get_gfx_off_status)
> +		return -EINVAL;
>   
> -	if (is_support_sw_smu(adev) && smu->ppt_funcs->get_gfx_off_status)
> -		*value = smu_get_gfx_off_status(smu);
> -	else
> -		ret = -EINVAL;
> +	*value = smu_get_gfx_off_status(smu);
>   
> -	return ret;
> +	return 0;
>   }
>   
>   int smu_set_soft_freq_range(struct smu_context *smu,
> @@ -3167,11 +3164,10 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
>   	.get_smu_prv_buf_details = smu_get_prv_buffer_details,
>   };
>   
> -int smu_wait_for_event(struct amdgpu_device *adev, enum smu_event_type event,
> +int smu_wait_for_event(struct smu_context *smu, enum smu_event_type event,
>   		       uint64_t event_arg)
>   {
>   	int ret = -EINVAL;
> -	struct smu_context *smu = &adev->smu;
>   
>   	if (smu->ppt_funcs->wait_for_event) {
>   		mutex_lock(&smu->mutex);
> @@ -3285,3 +3281,13 @@ void amdgpu_smu_stb_debug_fs_init(struct amdgpu_device *adev)
>   #endif
>   
>   }
> +
> +int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint32_t size)
> +{
> +	int ret = 0;
> +
> +	if (smu->ppt_funcs && smu->ppt_funcs->send_hbm_bad_pages_num)
> +		ret = smu->ppt_funcs->send_hbm_bad_pages_num(smu, size);
> +
> +	return ret;
> +}
> 
