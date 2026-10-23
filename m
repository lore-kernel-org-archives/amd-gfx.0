Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FCB606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 17:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2TDrX8wl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75922112C57;
	Fri, 23 Oct 2026 17:13:14 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99D2C10E496
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 14:48:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mViODwd3Z7cK3RrnlOE5xGAOT1t8kmXcJIPkWui0WiDsHPKVQwbhFpFRSdNSdSSZRjoDsuER0z3MLCeIEpma1yxg94VjdVjBI4hnncwV7/Qy0S1x4cIzkE9n2c+9fhJFc28BYyEIRWJKLdOY88+rhG6ZDqWEsyM2ZZQ6HIsiYsRVwu0wy2vIEKqLLOv+lc0LtNHk5/WgzYU/eo8Al+BKb8dbLU9FIMyWEDsIwkCJgOwHVqydW7PLSNWybPhTvati/CLvZ0ddO6hFBJmZcknyDntGqOKe/jQPhVLHXKTd4lv1bupmX040vzCwkWEdK7M9LpdeURoilcS1yPOqaepWKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJeY3TsXVJmq94ikD5pdmaWN8Qit0xLnZPXwOcQS3cI=;
 b=SehTAeOAo1Fg47SeJNrVaO+4BZPGmb13brtGGhmwQ09R1a0jA5s4Ed4D7in8IU8xz1F2+M1hcwyPGwSt/zbqzY1/6HenPkYwIZf6C8WejqQhbJ7K2Cid5EUx9ILWiWhVmhCcbVjlBvS9FVBeiUJAMTgK5LpXX1zfewGF5wpgRqm9BWkOJ+JL7iW3huJ38l3qS/j1m3tCnYQ7MgC1qavfz8Gkyf1ue/QXy9NzkkdxF8ULELV2r0yxTDtKTf+4HLP6avg17ZY9YkOzqxX4zCT1KRe/fMcEQdU4Ujzn/nRkm/FX6zzJFvk6c9ORGYfKuIwYGNFb7pY1xPIWfH24ZX7CkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJeY3TsXVJmq94ikD5pdmaWN8Qit0xLnZPXwOcQS3cI=;
 b=2TDrX8wlKjXiFfE1BxPoe2UJpKYM1iWi5ZtKcOKiXAMQLkshawoIydppiNPyVEQAFopt95rfeAX1zLzQ8WTD4niDFBUZeKKuRK+X9wRLz3FmtSYsPlHWmGe7MfPbc6X5nwK6lSkDM5Cq4jEEIzKc34LRxb3npsgt+L8HUA0AAIE=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by DS7PR12MB8276.namprd12.prod.outlook.com (2603:10b6:8:da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 14:48:16 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%7]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 14:48:16 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Patel, Maharshii" <Maharshii.Patel@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Feng, Kenneth"
 <Kenneth.Feng@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH] drm/amdgpu: reset dGPU on resume if it kept power across
 s2idle
Thread-Topic: [PATCH] drm/amdgpu: reset dGPU on resume if it kept power across
 s2idle
Thread-Index: AQHdTGSkT7KTy78QcUiN4U+JMv18BLcLX5cA
Date: Fri, 23 Oct 2026 14:48:15 +0000
Message-ID: <BN9PR12MB514689CD438188AF0AD61E37F7642@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20260924203756.2771789-1-Maharshii.Patel@amd.com>
In-Reply-To: <20260924203756.2771789-1-Maharshii.Patel@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-10-23T14:38:45.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|DS7PR12MB8276:EE_
x-ms-office365-filtering-correlation-id: db8f0bdf-efd8-4be9-29ba-08df3114abba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|38070700021|11063799006|56012099006|261022105027099003|261021121427099003|261009223027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: /tskV6R/iBkFULUzYpdbVQU6YzgD9OCJ534nSLmQW8m2ahysACKm8+3ekQzQ/t5AZ/Hr+Fc2b7dthUqTj65cf2YJol0Lu6ZqyW3GuoHcH26lOXypcEiw6vIp5BhZWQnMN4Du9UdSQs5RLMnE/3mp/Ke7SrRoQ9dlm8HZsbhwOk48qfgi5BbFm840BsxtFrEnvfWOR5wAVISD5qhV/SirdqG8NAlAtIxl8beRzvQsoMPZPw3Na99+wClq1Wu2u1U+FidYaEex2tRJKAPJxgGqToMlvIIcZEyoPPPemRLC0+qLitgeVUok/y6qocCzmKwhyuJmMSHBRBYQZy52Wov8BWL13PmK5TMSdGGz18fZobl3ijAGQ2hvoQtaltr1lnjzmqmISdMdIk+F4es1hUYTRBktnUVHuWTwnvxZt60kdogf9bu9LM1qVUpfbx7pmzGooquDJ6kCvXshOQR2Y6Z56TMRTZM9IjWPciuMJER5SZnccaB0P+Bo8iM+VWIt4uvMI7AO+RJVWAI+xmZLTPq+JOatIVfZnfNfTaLCpaYdUIUeLl9rBQ4Hjaf101RHHYiBnPVzIBbihS0ru/MwMTk6ndRcEVJziU6I/51lNFw3cWotwnXo+NKd8M0fvXQD9JB/XVATDKGvCJSw0WejvT+uAtpOvS+i+a1VxLYApyZPouc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uT4lq7fi0aDmoQ6b6wjlJJUvoCNXF4anKvn7YE7LfXNFLZUEUuyIV6Zl2370?=
 =?us-ascii?Q?2vKqAl0x6kBm5Owb2bfTbpXgPN5Y8cHR2moMLxTpX0766hcRbV0BQPKei9xl?=
 =?us-ascii?Q?ACdkxYT17mIz+08Ju48ov+CTv4w8Tb0Dt3EtMm4L9NRvqxg6BJo5zOrFUAHT?=
 =?us-ascii?Q?H51+2EH4paBw5N+rLNY95KYAvLUF3oaQ49NblB9RLIMk+ik/dcHEQW5bmmRD?=
 =?us-ascii?Q?/OXh5kfrPnStHhzHQl5lq7+fDs0XvtWFlEPuzbpWy+cfGDpCj7RYCTENSKlq?=
 =?us-ascii?Q?M8bQI7n/mi35Z/B3Y8Bky3V/VfOzNyUey4sPbhN9X9ifQ734KZaT2mpwx2Ni?=
 =?us-ascii?Q?MPyxTO7zBDUPMx/5Vxkq10itWnfAw2iPmJxSq7q8TQwssFQ4O6HzBX9E9Wfj?=
 =?us-ascii?Q?ZuA/ET57skFm4ERsr8D+DCrTfsCxManh9vLdueX9F0qG8tTKHbTTUgZDd3vP?=
 =?us-ascii?Q?gPfagGMajxscnUIbLFSgUA/N2lzJA0czQ2kuZ2My5LJnPH0s6shv5SCaniVr?=
 =?us-ascii?Q?1F4prmg9l4kvjPZ2wA38BCcV5MaMfZRMq2ReU8yTR0dwVWiiWFJIRYkYEkLT?=
 =?us-ascii?Q?94Q+u4UwgQrEBMzR/B/bXARaOcimwYWP3lu/3qcaejPP+Esp5WWtiwklaHYJ?=
 =?us-ascii?Q?gsb/8RmfdqZwsc5ZgJB+Uc+AqEEBAGYJ3J35X3JzcOM3Ax/3cDihHjCzSVfo?=
 =?us-ascii?Q?cCBauK5JBPrty41+8+1oJQDDbLeAmi2F9G0leKdKLE8kUFauyacGMftze+jw?=
 =?us-ascii?Q?7ode99W2b5bbAzgx1YZGtdW1FtrC3rYspyg8F0bA0pkCNo73bbbEzWJVutU3?=
 =?us-ascii?Q?4mKqKWRDTNA29ZzyfxIWoTRe7piJGLKt6RPFM7tjJjFN4hwXPnkPboX5N9NG?=
 =?us-ascii?Q?NGgkMJcuCPe8gqw/xBxibvPRb6IoWr+GoUh4DdnidzG5xkPN+w+9FQyZfFHl?=
 =?us-ascii?Q?dpqO03w/dxBfvUGr8EN2SX622mhH/w/DaZktgIag7JgVN9Z1ztbl3wqI2AMO?=
 =?us-ascii?Q?Ul5D6JsMWBkhQcWcqiSeK8+WSfWnxbknchNn+I0afmDfWpdmSj1TAnm8iHFq?=
 =?us-ascii?Q?lRA3EYNbS7OjexsdrRGPLsDkldVvnWz6qCIDwpDpMX0xJXRsK5NNPl72BbeJ?=
 =?us-ascii?Q?tj2vadpeIlyNXgMJlywVS1Q9W0xhJdUAXXTfEprimkjGD3PNcJrxeklykMTr?=
 =?us-ascii?Q?jGiwg0+bNCgXRFpNNM2RKfwA3P1XQnB/GjYaTwMroJuzW2V1tPCJo9bBpD7s?=
 =?us-ascii?Q?7ljB7+6J5c9HXn+RPTES4amTVUXFjPlVl374dzz0wMwPm7azVkDZZRYYIXMA?=
 =?us-ascii?Q?b/+yPLCvx7+lQ7dt6cz06kjw8U8Ab3KqCDn5O7oO4VR1isRO02gsmY+SIpe7?=
 =?us-ascii?Q?AS+q7jUsgH2EgCuDd5yvO8e3S4fXl7mAxbmBGMfZws8KY07IBQDsGwQ+4R/C?=
 =?us-ascii?Q?KY7AUq21YETk1PlHLZ9kl/XdfmpsBxvlQz6qOG89u91BS08hXchVRjJwU1ll?=
 =?us-ascii?Q?BwEV/7uI2rU5lkKQqoNLvu81VOSWOY11/G86BrobOlUMhFNvbz3XpZj4rnzi?=
 =?us-ascii?Q?0BNWULDsjHjLZZnHhJpi2BBcVvykWmHvgaLw1IrWKCRalvTMya8mxvjns37W?=
 =?us-ascii?Q?rIZwBXivGM5XIV675l4v8RMara6QiydeyAWQSBvw4xgD53c+XtLmuSGU6sej?=
 =?us-ascii?Q?0Dt77lxhQbDdDT4s4VQdM523qWFAemGIqrNI1TWECT9dyE0G?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8f0bdf-efd8-4be9-29ba-08df3114abba
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 14:48:15.9482 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a+uazfrUn8TgQ6mzD/V+fewb/sq/vVhIcobn2TZCcLJ1IxGv1scOkC3hNNrXOT08ENf2GQn+MbDgvza+gOMj+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8276
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
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Public

+ Mario

> -----Original Message-----
> From: Patel, Maharshii <Maharshii.Patel@amd.com>
> Sent: Thursday, September 24, 2026 4:38 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>;
> Patel, Maharshii <Maharshii.Patel@amd.com>
> Subject: [PATCH] drm/amdgpu: reset dGPU on resume if it kept power across
> s2idle
>
> dGPUs take the S3 suspend path even when the platform suspends to idle, b=
ut
> amdgpu_pmops_suspend_noirq() skips the ASIC reset for s2idle. On desktops
> the GPU also keeps power in s2idle, so it resumes without having been res=
et or
> powered off.
>
> SMU 13.0.0/7/10 and 14.0.2/3 skip smu_disable_dpms() on suspend and rely =
on
> the PMFW to clean up on reset or power loss. With neither, the PMFW still
> holds its pre-suspend DPM state and stops responding when resume sends
> EnableAllSmuFeatures:
>
>   amdgpu 0000:03:00.0: SMU: No response msg_reg: 6 resp_reg: 0
>   amdgpu 0000:03:00.0: resume of IP block <smu> failed -62
>
> SDMA ring resets and mode1 recovery then fail as well, leaving the GPU
> unusable until a power cycle. soc24_need_reset_on_resume() does not catch
> this, as it only detects aborted suspends.
>
> Do the skipped reset in amdgpu_pmops_resume() when the VBIOS init state
> survived suspend, i.e. the GPU kept power. S3, and s2idle platforms that =
cut
> power to the GPU, are unaffected.
>
> Tested with this change applied to the amdgpu 6.19.4 DKMS driver on two
> Radeon AI PRO R9700 (gfx1201) on an Intel Z390 system: s2idle failed on t=
he
> first cycle without it and passed 16/16 with it; S3 passed 10/10 with no =
extra
> reset.
>

This should probably use the runtime pm path for dGPUs, otherwise the GPU w=
ill be on the whole time consuming power if the platform doesn't power off =
the port.  Can you try these patches?
https://gitlab.freedesktop.org/agd5f/linux/-/commits/dgpu_s0i3?ref_type=3Dh=
eads

Alex

> Closes: https://github.com/ROCm/legacy-rocm-build/issues/6684
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Maharshii Patel <Maharshii.Patel@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 9c5e93c..b9be88e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2703,6 +2703,24 @@ static int amdgpu_pmops_resume(struct device
> *dev)
>       if (!pci_device_is_present(adev->pdev))
>               adev->no_hw_access =3D true;
>
> +     /*
> +      * A dGPU takes the S3 path even for s2idle, but suspend_noirq skip=
s
> +      * the reset there. If the platform also kept the GPU powered (VBIO=
S
> +      * init state survived), the PMFW still holds its pre-suspend DPM
> +      * state and times out when resume re-enables features. Do the
> +      * skipped reset now; resume will POST the card afterwards if neede=
d.
> +      */
> +     if (!(adev->flags & AMD_IS_APU) && !amdgpu_sriov_vf(adev) &&
> +         !adev->no_hw_access && !amdgpu_acpi_should_gpu_reset(adev)
> &&
> +         !amdgpu_device_need_post(adev)) {
> +             dev_info(adev->dev, "GPU kept power across suspend,
> resetting\n");
> +             amdgpu_device_lock_reset_domain(adev->reset_domain);
> +             r =3D amdgpu_asic_reset(adev);
> +             amdgpu_device_unlock_reset_domain(adev->reset_domain);
> +             if (r)
> +                     dev_err(adev->dev, "reset on resume failed (%d)\n",=
 r);
> +     }
> +
>       r =3D amdgpu_device_resume(drm_dev, true);
>       if (amdgpu_acpi_is_s0ix_active(adev))
>               adev->in_s0ix =3D false;
> --
> 2.43.0

