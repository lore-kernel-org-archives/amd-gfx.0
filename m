Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B025CC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 13:57:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B96F10E663;
	Tue, 10 May 2022 13:57:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0986C10E663
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 13:57:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrdA8DDZrmbNwzXbXCZGvI/XXlkBTWVHwpZvsykcONJ1SnmmdaD8IqzG/1n/Dxu4qeXlIEzlc0gJgklACqw+y6jiKzwpP4aMq5u5pdYpdYT3j46M1OxDmfwZtXz36IDc5XXQlx0Q5xTuIEnQsmNJ1qbzdvzVfZdvQCPL3Wd7GCWzaacd9mL0e9U20Q+qm1NwzOlzPJFZzvcwrjZCkW7zGI3F85Dua0jC4jr+IRNaUDhl04Y6nimcYu9pqNb42kW+1bkY7YFLlvFG0aIJpJGp27TbSNhW3sYrVxCBRjitbBuObfcgqwM2CDO+PkZnonMA/uRDx9MhMKzKlROpCRVcaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/NsAEargI4n74/93Dr6z5Puq1qmmzL5cUpBdK77fTQ=;
 b=OLxkqVe2frB6ac+Uj9lHvW3KG2j2i2EBpf6kadILxF19LsXimaEO3OJ+hZe5uLjbYJJIB5BfLw6KeCAZe0+z+/XsuLfCZ9Jp5fTl9AUBvdAyoWYFci+NUx8rboFPwrIcg7fG2XAUM+w3j2XePLMTQjNptAxooO3NaRAqJZP0LNSE5cdeEvw3Ag0r7JEDo+yiO/TWHCs0GtaCoVVeMKZAyDOQ5nTSZvJ1v4ZRmibzmiFOsf6T7rBTpFBwbs9S96fEKBezJWzBZ3+9Kq8cODDo7jxkoQWivz7OMLtS5g50zOtxuur769yA58dYPtNK91k2yZYOhWPDeT8C+yGO+ygYGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/NsAEargI4n74/93Dr6z5Puq1qmmzL5cUpBdK77fTQ=;
 b=Cxn+sACUGbWDD+mGXsKBy8Fmc147f6xS4BPzMl8ZtbuDZtU50zFUKYeVXWjRT0UG9YJlEepNW4P6W17hnfwH9dDaOA659mV7f6UtfLQPAXmwGDf7gqbsTKWBgO51PZ0etm0N4TKdlD1ZUWgDjVyRSNqGWSEyVgFV9r89t8HXpIM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BL3PR12MB6618.namprd12.prod.outlook.com (2603:10b6:208:38d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Tue, 10 May
 2022 13:57:09 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f%5]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 13:57:08 +0000
Message-ID: <244f3a20-7aa8-d34e-3fea-109b4c493cda@amd.com>
Date: Tue, 10 May 2022 19:26:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] Revert "drm/amd/pm: keep the BACO feature enabled for
 suspend"
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220510135144.551692-1-alexander.deucher@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220510135144.551692-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::22) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 250f3f3e-4b14-4f27-d20d-08da328cf91e
X-MS-TrafficTypeDiagnostic: BL3PR12MB6618:EE_
X-Microsoft-Antispam-PRVS: <BL3PR12MB6618FD8F9E5BBCEF2FA1B7D097C99@BL3PR12MB6618.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r9vSgInAWGawc910QmK8VdNr4X4uZO2D5xhBBteoFUd2aa/RYGRNmxqyM3rn/07pXf43qCX1lG11S75PXu5A6Q87PRK5jD1oBrC0nw6XObV0BKuyYrffmnZH72CqGwiC3uWbtA9+A2GFCzVQLfIln5eSQYkJQ9eM8Ovl1KHp8Iz/kpNXmiLnHzDJQIW0mjbPqUhm8tK0+rgGJhcBJD21w1KX1gxbmNmb36i4FfLS58cZamSfZHzQ0AZfwUJnw+5hteSDAalQzElp3gIX9LRibx1k2Il/3JHAHge33Llp8kyGw8nUnYDss3EF8P5b6OM0Hm6Rsm6azyJzE/RlFS0K9CBwmHqLmSksyOT1HAlANS9X5jl35q/x2MtOHanqbxHvR5ojs3JrrNDI6wIeykHANm53kyO116B20Zr1z2y/vfMwKa0eYbCgYvAW6nkDZs9xOhtqmf+Hsb9yYcFqOa3qUs/5gx9GBMvfH2OzJ6LqMv6V7gQKSDUiUjab05s8ZBft7d/wnRhlQeFVx5e51GOSgmoSrRUwze8mr+i4jdVgUlWSJ2ZCLKOuwrmHuvIcW4rDXi8N2SqLbeGu+eCDHoNT6FpbyFc5Bfd5MP+DkDFZXEza4BsOCyl09xri1vD+NqQED0Mget8NgOZWVGrI92SLxXFfeOkl33vbAzfMOwvyZ31gQ+N5UbJPlaoU/Z2iFaX6piy3XRe1DE04/x/NtAqJ0KcqvO07h8d2Kdi5sPQjAW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(6666004)(86362001)(6506007)(31696002)(8936002)(6486002)(966005)(53546011)(5660300002)(508600001)(15650500001)(83380400001)(6512007)(38100700002)(26005)(2616005)(186003)(66476007)(66946007)(66556008)(316002)(31686004)(36756003)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmtMWjV3NlJ1eUJBN2NSbTRHQ2VDUzIrUC9yR0FhN0JrZENleGtkaDY4SHpa?=
 =?utf-8?B?QnBrWWE1dm1mWlN1dTdMZVNCbEFMWkdlNG00U2d6TUpMbk9vREgwQTFUY0RJ?=
 =?utf-8?B?azdtRFFpYjNxaGc3czZlZFdHL3pWNFZPUTROanEzVGdYSTIwVUh4YXlheGtF?=
 =?utf-8?B?TWt6ZEtwdjI5Ym9iTDBqbDNVbG9GRnlaTmx1dS81TVVRdkZ0MEx3c2xPdHBx?=
 =?utf-8?B?amgwV2dmSWdhMlJDWjBWREVuL2syZ2RlSWdZWUdra3lFVGdja2Jra0J5M0x3?=
 =?utf-8?B?cTZIOVBQbHp3NVdVZ3dpODltNVNINkpiN080ZzV6VmZpc0QweDlDY1UzdlpQ?=
 =?utf-8?B?bnhmQlA4d2dMSi9kQ3p1ODAweXpzN1BndWhXV1RURlQxdERzTXY1cWZ3SWlw?=
 =?utf-8?B?MkxhaTdKNU56b0VLalRMbUNrK1o5K3RRZ1pkWGNUN0pLelB3akVkQ3FRYURa?=
 =?utf-8?B?TGRWa1Fta3dpaXNFYXVoVFN4VDNlc3VZWmRmVit4Smx6UXFXL2pxVm5QSUpT?=
 =?utf-8?B?SjNEWGpTMzFZNmU4ZEJ5S3l4Rm0zTkVnYTJNa3BnWGdmSmJOZjhQbmdCYnBq?=
 =?utf-8?B?WEI1QW9MSVByVzA1c255elc4M0FpeWMvVmJiZ2FOL2tNQjRRaFlhdTVkS1Zz?=
 =?utf-8?B?Yk53MzRicVZhcUlCT2hBYmwvZUNzUzNWb1pjRmNwRlArRVB6elVWdWMrVXZ3?=
 =?utf-8?B?TTc3L254Wi81ZmNqYWJtV2I4SVIwRXp0NTgrZmRsUzFpQ0p3cE95M0tQaTZt?=
 =?utf-8?B?Rngrb3l1VCs1VFhHbnlCejBpLyt5VEhLYmc3OG5VK1RLYnFqNDRSbWlBT3RI?=
 =?utf-8?B?UUdCOXllM29talUrbkxGeE05WDhzRU0wcHkvd0c3bUIyZW9xanJORnh2ZHI4?=
 =?utf-8?B?Vk02QnB0aUhFN2M2ODNjMWVRYUlTMmtYOEN5ckVaYVQyV2xMMVdyZnJHQWxj?=
 =?utf-8?B?bnhDdGVwNDZES2QxaXBmbXRleG1hV2V2dVd1NEdvbmxuRUsxN29iT2RRckkw?=
 =?utf-8?B?dHI3dmtaYnYxbGR3K1l6ZGFSQmJQaGlvTEt5eUwvZEZSZjVRdTZQYzVrVzBD?=
 =?utf-8?B?V3NHekJYaUZCMzNsUTc4bDVNNU00T29mT2J2UENrd2ppOGY4Z1YrcG1qQzFQ?=
 =?utf-8?B?WTA1RjIxZ3ZiRmIrODhWdnlCbkpIMnRucUJuN1VxUkZaUUlPRHdJN29nb2Ey?=
 =?utf-8?B?MHFYQ0trcEFqSE1VQ3VLZi9lOW9tRHZTeUtqaEovRXljWXFOOFlaVGVKc0Fj?=
 =?utf-8?B?U0ovYlE4YnRjNmFyT2ZXL3M2d3JYK2ZMRW9hbWJCNXpkNDhzZ0Vtc1Q1TnJH?=
 =?utf-8?B?Tjl0ZlBzTW9pcUZsL0k2UlE0QWMvMFgyMkdTajdvRDJKSGhXYkhxMU9QRnJa?=
 =?utf-8?B?R1VCRnQxelFucDdjYVN4eUo4eVZ4UVJ6T0hwY2VFQ0E2eldrcmFEcmdyeEh2?=
 =?utf-8?B?YzBDUFFuNVl1WmpiNmlKUFcwSkVHSGttUjRFS3hKcUliRlVsblJnVEJrbERK?=
 =?utf-8?B?R2VhMzV1M20wb3VudmlyTzNmZTA3UFEwY3lCNEltZHdDOXY5T2tsQW5BZXQ3?=
 =?utf-8?B?OXlDdDh6dTNRSFVVUFk4czExa3FydUhwcmFPOWwvYjE1ZEgrSUxzWWExSm1s?=
 =?utf-8?B?b1dzUHJ2TG9JMGEzZy9vdFByNGZjNTl0QWVpTkV5YUFDUzdOVFhoUG5lY2Vk?=
 =?utf-8?B?bkF4bXV6RzNjVnc5S2c3NGxaYkZacGM2WGpOQ0ltUC9CUGgrV0xxckNEOFdq?=
 =?utf-8?B?L083Nk10WXVKRUxpV0Q1ZzRtUHZKelZHVFBIQXdPRXN6enJhSVliSURiMjV6?=
 =?utf-8?B?RWpSaXRRcGtKZHdRQUlFMC8zVi9ja3ppUnh6enZUMnFqNFJvYzlPUXZSM3dn?=
 =?utf-8?B?TENhankzUUJibmZmMDhCa3hWUnVVWDUzcTZUc0xyanp4M0ppclNCZWtZMzYx?=
 =?utf-8?B?L3Bsc2E1VmFuUDcva1NKRnFYd1R2Nm9LcGNoeWorTnF5Z3gyK3ZlRjE5a0k1?=
 =?utf-8?B?Mk44T2toYVFkOTNGZmF4MklsT0V0VFdUa3FHTjVQdmZNaFFUVER4ZHVEbzVR?=
 =?utf-8?B?V3didlJIVXJlMHdxQVh0bys1NG1UVWZBS0ZzNFFtdDY0azBabnZ3dHBzdHZH?=
 =?utf-8?B?b3FPU2tEeFlVSzZPWHcydEI3cDhETGRZb3dLeVpQZE9zcFpCdE0yZzVnYnMz?=
 =?utf-8?B?MDgwYWRnQ21FOW9hMGRwV2Ntc2o4d1hkKzIzSDBkMmRtWUFZRC9hT0xadnF2?=
 =?utf-8?B?S1oydlZFS0NSRG1qYzJWeE5EcUtkNklVTDNLeE5ENGE4V2VHOGI4N0VhMlFM?=
 =?utf-8?B?ZHF1d3llOXVQWDloVDh5UDF4SVFvMThOcGVvZnVZV2J6aW9KSTl0QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250f3f3e-4b14-4f27-d20d-08da328cf91e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 13:57:08.5828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/noDyDkiq/fphUceueSfuxG4FuK/0gcX8W2509RBSiiwlHqpxC0q65pPjageLMM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6618
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



On 5/10/2022 7:21 PM, Alex Deucher wrote:
> This reverts commit eaa090538e8d21801c6d5f94590c3799e6a528b5.
> 
> Commit ebc002e3ee78 ("drm/amdgpu: don't use BACO for reset in S3")
> stops using BACO for reset during suspend, so it's no longer
> necessary to leave BACO enabled during suspend.  This fixes
> resume from suspend on the navy flounder dGPU in the ASUS ROG
> Strix G513QY.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2008
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1982
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 395f266be690..956062496202 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1390,14 +1390,8 @@ static int smu_disable_dpms(struct smu_context *smu)
>   {
>   	struct amdgpu_device *adev = smu->adev;
>   	int ret = 0;
> -	/*
> -	 * TODO: (adev->in_suspend && !adev->in_s0ix) is added to pair
> -	 * the workaround which always reset the asic in suspend.
> -	 * It's likely that workaround will be dropped in the future.
> -	 * Then the change here should be dropped together.
> -	 */
>   	bool use_baco = !smu->is_apu &&
> -		(((amdgpu_in_reset(adev) || (adev->in_suspend && !adev->in_s0ix)) &&
> +		((amdgpu_in_reset(adev) &&
>   		  (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
>   		 ((adev->in_runpm || adev->in_s4) && amdgpu_asic_supports_baco(adev)));
>   
> 
