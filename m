Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691E0606A333
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 13:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VZfnWyyr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD1BC10E7E0;
	Wed, 18 Nov 2026 13:44:20 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013044.outbound.protection.outlook.com
 [40.93.196.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31B6810E7E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 13:44:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIRMhbpuCGuQbyINHSgHGvFBHler8gr8qn6YaEYphLrUWcCe5b8mNAgvHNb0NYshSomAJ5fB3O4hwAzEkOei+bTOt8RlS597mCkN/L4w1Z1Jc9xLLE5IXBOz92w4cA4o9KvMlg9Lv1pAcssCBEWZbBp5Ih7OjxJxI/7MK5Aa0y9k0urAir0Gs9YVCsloBehsoGr6Wb4nRqZiAe1in+fQqyuBZKGZIT2dOTxKXS6eNjGOCCmEkJG175kn8EKUEtGhRtjRHmeFNCllTJnhMifrmEtG2WqgDgln03ZUB2hbd/K/ARZ5BE/sLmJxSSwUywijJouS2Mhu2INx5e4VOfSAvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0Om754a+zgKmBndxo1QagpjotOxNbWzz/BsvL5jG0o=;
 b=H5p/LkJTl1KmlStNjXE3G7NN5XQh9sBI45CtP949omfJbmVnzIUPMx0V1rp2N3lrKk3puhx65AampypckBjCXmOfPpags7/FKTezBOeMNnGLv9ujjbJ+SJFnmenMQSsIA2/T0E8s0VOKamQOnl8kPh6UGyWOHzP/x+erEr/+T7Inxwwk5cA19q4HJ6A6edPy/XVEC5gfZQ3KEcWr/GXaZ1e1Q8SPQQdBq1hc6m2eSnKKDkKRZ787vBQWclc/tMuDxLDFHSGK3Y8XBWtykWvojipbb9eZ4PdhNykNvh0W81ScEEfEDzvbLmyMJPYPBiq2SqVfxpRiPN+wcUfrxgO6PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0Om754a+zgKmBndxo1QagpjotOxNbWzz/BsvL5jG0o=;
 b=VZfnWyyr5/xA26cZ0PYhzVJKdRO7CTBiSHdcAFNV5RQ5h0IC8PS7EJFCVKOjmX1/m4Ov1LPGZCqfrTZDNqFB5HnSJJgZHoDHA0ty7DTUpgOmcqY5CiMLp21nxPAjQbMoho7cIG3jY4rEb1lvsLgYfqEWkCTrWVmEIv+n7O2rMsM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by LV2PR12MB6016.namprd12.prod.outlook.com (2603:10b6:408:14e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 13:44:10 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 13:44:10 +0000
Message-ID: <b7863c55-dacc-4519-97e8-a9cc6b07ffea@amd.com>
Date: Wed, 18 Nov 2026 19:14:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Enable IMU_I/DRAM FW_LOAD CMD
To: Suresh Guttula <suresh.guttula@amd.com>, Alexander.Deucher@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20261118132348.4101528-1-suresh.guttula@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261118132348.4101528-1-suresh.guttula@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|LV2PR12MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: b21e4b9b-1596-4634-603e-08df457a0614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|261102123227099003|261022075727099003|10067099003|11063799006|56012099006|261026121527099003|261021121427099003|261021123027099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MIp6gu/e73PvZAJukG84e8PXqzduHaV5uGsXP6CAcGKyV9FGDSWcSPdxFsK2LCaxVcuLfupT1W5/nVGG9vOgpOAk9PSE78LI8OpC8114W1MABxccLmzBwt9nsbZEAGf2ywgG3VhFL3eqceDg+geEEZv0ho59/Ngstmgvzs0v/cFs1G/Gx1JLwvPR2vqg/xj/1HuIW4vPY6q6AVK6Vvaj49ZkMXXCQsVc2Xdhh1dyn/dUpJ5gGVvqvPHaZSpVVF/2S6epSQ/j7pbQkcXxlR+cyXRA1LIOHemUoecc2zrMEHw/iIwPocwhGA4/FmNX/Lmg1veVpxFzd3TCHlC98FNT9bQ6KhreEpCyUulweSFb2LwiensMYt9JyhzI08GV3LPRWJCIPujSaFrfmHb8GVYAeeF8Vas7XsoLd7Eg2UmOPm6GFaWpNVIBkcVIgczy6BeYm8k+NUz1cik31hKz3PFNKdvhyYGxQPRpIAw6SACoaPheZP0fPNLe1IuihZuVFEJMRUqA1iXYiVH5eRHBA4jeiweG0oOWOhg/n+vKbQgnfSqb3lQoc9tBSjrRsRwYguBx4/49vQyve6xlyQEoiBWyFqPUT2BbzQBQV67XaPVHRP07bus0uzqp81Ecz9Ro50/gfzRxziKADFDGVBxxNY76Hho7r9equALV9EB8ekMaKG4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(261102123227099003)(261022075727099003)(10067099003)(11063799006)(56012099006)(261026121527099003)(261021121427099003)(261021123027099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmJkVlBCVWNwckFJVWc5QWNDVW54ZDNOUXFrdmZlWmdiSWh0UnIxckI0QTdV?=
 =?utf-8?B?MEJrSmpkL3YzcG9BeTNld0pKY3JUODdSbkZTYzE5UW1VTEw3WHZhcmtwVHlJ?=
 =?utf-8?B?RXpKTjN4UnQwWHBnMnNlNnFJYmt1RU1nNjNIN2hQd2tyWlRUbU1rWVo5anRq?=
 =?utf-8?B?VTFMbHNhMnBNT1d3VFBic0NVUEhYdEFQMUp4NVpUd0ZNM0xtbW9aTWg3T2dS?=
 =?utf-8?B?bC9NUERqYXRvUU9hSXZwaEsxZGpXRUJ4bzQ3dnpCOUtnUXRncnZFU2d5MGVM?=
 =?utf-8?B?eUpnMW8zL2V6ck1NM0NCSEYzQTQ1Q2JDMllKbGZwZCtBVllMMHVRdS9HWG5P?=
 =?utf-8?B?RTZuWithNTluMytHRGJDNVdlMmF6UHVJQlQ4MisvbktQVWZSSHVoUTdqTzBq?=
 =?utf-8?B?azJtVEtLVjVwUFFyOXoxYzFRd3FlSEJWTkxtT2NXNnlPcFByTUJ4TmhacWs5?=
 =?utf-8?B?TVB5WXVPVUE4b2ttdDB0TzVXL3lJdDFHaXh6T0RncjFyL1ZjMlJpdEdsOTFr?=
 =?utf-8?B?bjA3TDFPSENNcFpsRDA1QVlycTl6Q2VVOVdBTUNDTlNnWDg2bm51dHJVM1Qw?=
 =?utf-8?B?TnVkbnIrZ1IyMmJDc0hOU0lrNDlxUDFZdG1xeXNsbWJMczczSmRsWjhVUmh6?=
 =?utf-8?B?Mm0wRWtIM2FaR1hmYmxTam45dXVQcGQ3c1FkRFZSTjZMWU5TNHB0MG5XRDky?=
 =?utf-8?B?cjkxb3JOd2puaEtKaXFaajk4UFArN1dsc082WWI4S0xPNURJaXBSSHZXaTl1?=
 =?utf-8?B?aVc3dHlrSDFHOVcyZHV3a2Fla1U1OVBpcUs4T0Q3VHE3Q3J5Mnh4VU8veEx3?=
 =?utf-8?B?dENyM0VrdkNFS0p2ZFFhVXRCaGRrOVFnT0Y2N2JEY2NVV2czWFczK1cybG5Y?=
 =?utf-8?B?M2dCOS90RnI5aTZYOHhkTk5uc2FtVGp1cDlrbm1rRytocFBHbFJaYUluUWNN?=
 =?utf-8?B?NmlNWjJicWpPdm9EUmF0YXpraXBvWExZbzhsd2tQNktmdmlwNk4xdzBuaUp4?=
 =?utf-8?B?bDNwQzlwMWJPM0I2T2FpQkpLcVF5c2RaMkhWTUhzdVROL0xDWjUwVXNZV0gw?=
 =?utf-8?B?cE9POGZ0bGNuS3VWTUVsZHR1em8wc1B4YjJpbEpCa2FwMGFrZE5vV0xWVWdx?=
 =?utf-8?B?MjBuWWdwcGwxczMwR3FKekk2RFVGK1J6cmdJNVRxbExXd3JsZG1BTGpxZ2Zx?=
 =?utf-8?B?cXBidEk3Ni90bjhZY0xHUGIvTFp5RzFOMC9aQXVJd1JrKy9ZbGVRbU1MYVVr?=
 =?utf-8?B?WWxWclFucFVjeU9XVVZrcDhEYy9ZRkluY0NmdG85VE0zM3JRcUVTS2pnQTNU?=
 =?utf-8?B?UGtUd29laFEvZlpWd25WOEJVdjhoVUh2eC9pYTd5N3FNWlFUL3pnSjl1Qnht?=
 =?utf-8?B?OC9HNm4rSUQrWUNnWjBYOXV0UENsa0VUYThWWUgzS05PNWRESGRRSWpVbldS?=
 =?utf-8?B?SE1RRmQzcGoxQnZlb2p5OWt1RlVEblBpOXFXYStuaEtFS2tVNjdWQ045ZnZx?=
 =?utf-8?B?UmRnR2k5YkJNYm9lcHNJNGY4WUVVRmhVRXBNN3BreVE1b2Jvc2hiV3hwQ3cv?=
 =?utf-8?B?SFdQd3BIeHN1R1ZhMk5PVzl5YUxReUYxQWFJQWV2TmJGQnluRnhFcTRlVVFK?=
 =?utf-8?B?dG9RKzJucXhFZ3VvdmcwemE1RXJ2bTdFTGtTQVM1QmRucms3a2swWGZvTXda?=
 =?utf-8?B?aTc5Mjcyc0d0OEg4TGtkc1g4SXZsY2xta3Bzc2J2c1FUNkxtKzBhbmgxWkN4?=
 =?utf-8?B?YThiK1ZwRklkM05vaDV5dlhMRDkwaXREOGRlam5TZnJXZjJURVdYVzNKaE9M?=
 =?utf-8?B?bFZReVBlQlp4WWpwR0hoTEFEQTJNSWxnS3ZDTzJKTEdlY1JpMjJmMVIwQWYr?=
 =?utf-8?B?ZHIybnZnREMvUUplc1JnckdTbUhEdlNJbXZVbXpmZTd4Mm1laEd0bkxMVzN5?=
 =?utf-8?B?SUh3WExVWGNBdHBTV1RQQ1NlTlJhL1hSdzlaajlhaUYwWm9yaTNUUG5DNjBC?=
 =?utf-8?B?ZGUyZUROQVJrbkZCeDRxQTBMcHR0LzBjK29LMVNmeThLdnJJWUJpMmtzN0I3?=
 =?utf-8?B?NGhyc3AwdVVleVVWOFpvQURBa1RHcW15RStVaFJRb0lVK0xWamQ4ZFdtM1pa?=
 =?utf-8?B?K0FHRUt2azBsWmFvcVROeTZROFJzVjlFVTJNSitDSkYzQ2phQWo0bFA1SWFu?=
 =?utf-8?B?WC9RbFdsRHBJRUprL005aTFVTUNYWG5YL3MrV3RhVzZBS0lISThSeDVaRkE3?=
 =?utf-8?B?Z3VmTk9BMURKc1dMTUtlbTkwQ2F4QnlMSHpUZlpNNjgyMHNtTTN4UnBGQXQ1?=
 =?utf-8?B?RldvcUo5TEJGWnFUemJmS1Q3WDlDWUVkeitMWHc1MlZJZDRFU1Rudz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b21e4b9b-1596-4634-603e-08df457a0614
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 13:44:10.4113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4cxc9afucxWp1HCoI3Ep6vjR+Y9YR6CMqR18fGg9kpww8qwPBvvHeRZZ/k/rVvU8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6016
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 18-Nov-26 6:53 PM, Suresh Guttula wrote:
> For GC 11, Eventhough IMU ucode load from BIOS/IFWI, PSP exepct Load
> command from GFX to load IMU ucode.
> 
> Signed-off-by: Suresh Guttula <suresh.guttula@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  9 +++++++--
>   drivers/gpu/drm/amd/amdgpu/imu_v11_0.c  | 14 +++++++++++++-
>   2 files changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 7a8cc043df5e..9d6c192db348 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -4091,8 +4091,13 @@ static int psp_load_non_psp_fw(struct psp_context *psp)
>   			continue;
>   		}
>   
> -		if (fw_load_skip_check(psp, ucode))
> -			continue;
> +		if (fw_load_skip_check(psp, ucode)) {
> +			if (!ucode->fw && (ucode->ucode_id == AMDGPU_UCODE_ID_IMU_I ||
> +			    ucode->ucode_id == AMDGPU_UCODE_ID_IMU_D))
> +				dev_dbg(psp->adev->dev, "don't skip IMU fw load!\n");
> +			else
> +				continue;

Keeping this in common code causes side effect on other SOCs. Better add 
a check inside fw_load_skip_check() such that it returns false for the 
particular GC IP version.

Thanks,
Lijo

> +		}
>   
>   		if (psp->autoload_supported &&
>   		    (amdgpu_ip_version(adev, MP0_HWIP, 0) ==
> diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> index b6c4ae35ca03..3aef68c9891a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> @@ -31,6 +31,8 @@
>   #include "gc/gc_11_0_0_offset.h"
>   #include "gc/gc_11_0_0_sh_mask.h"
>   
> +#define IMU_DATA_SIZE_BYTES	66304
> +
>   MODULE_FIRMWARE("amdgpu/gc_11_0_0_imu.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_0_0_imu_kicker.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_0_1_imu.bin");
> @@ -73,8 +75,18 @@ static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
>   	else
>   		err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, required,
>   					   "amdgpu/%s_imu.bin", ucode_prefix);
> -	if (err == -ENODEV && imu_in_ifwi)
> +	if (err == -ENODEV && imu_in_ifwi) {
> +		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_IMU_I];
> +		info->ucode_id = AMDGPU_UCODE_ID_IMU_I;
> +		info->fw = adev->gfx.imu_fw;
> +		info->ucode_size = IMU_DATA_SIZE_BYTES;
> +
> +		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_IMU_D];
> +		info->ucode_id = AMDGPU_UCODE_ID_IMU_D;
> +		info->fw = adev->gfx.imu_fw;
> +		info->ucode_size = IMU_DATA_SIZE_BYTES;
>   		return 0;
> +	}
>   	if (err)
>   		goto out;
>   

