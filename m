Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918C2D711D5
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Dec 2025 05:38:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2A5D10E199;
	Mon, 22 Dec 2025 05:38:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0FRjnYGM";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012050.outbound.protection.outlook.com
 [40.93.195.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 892FA10E199
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 05:38:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMzECUzfFHSpTHgPGqGggQOpng60Bb1tn1RMK4oUnIOQVGeuw2wQy46JtL3SIF3LVFosbHyZAw84iKHiPk4c/NJ73pRcaoPc6MFLBn6vKLh7E1mThldvO+YXEJLLGMjn8uoCNxM9kCfawXTztObTczdueBMD4L0CzDR9qconWT5wk5XIEMbm0Uipa91DoEaWqaRRNuKabx4WqrTLOqkI8CgnEsFw9tPxWq77XQ5XKtjAnmACFMtobrwFefRhit1AA71VBH2i5JqJStSLbg24kg3CLmF6Sl6Tco3xSmgYR+n+CeU5+Gc2Eq7QLoaS8R6rG8xQXNa2MTvgqrcCM3FIWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QDu9L6y4vVVo+RNhP28nrfZUAhlG4JWJCP0nl8RWpI=;
 b=aHV4v9T7j1k/nl21n0OCIqzUD2MRlqyVHhwMbj+2mEi4xH1TKrYSVmEir2sbxWF3P7Py+ecPEod8V2wbTmuwgdcnEWHTaawNc+xFSrKxapw5W74bvGOWWo5vN2Q0lHbEkP8nCNz7To3BTPakWtxxWdFW4N2VJNC1rCoUAI+giNnW+wFMb4ewo1xUK1VZoV9ZYVPwbwzlB3A9G2y7g9hyLt1nbA7lCqn84oWG/QeuFTKnMn4AcqzB+akUwZALMzAjtxmLnloisxl1e2Y51T3ABVyThpa3JGzjw5Enc6r2xskpF2zpgCt/k2WCC0sF3HYF8cwTR/1uNGsNsS4xeNgXTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QDu9L6y4vVVo+RNhP28nrfZUAhlG4JWJCP0nl8RWpI=;
 b=0FRjnYGM9w+WTqsHeMcyLs7wHoVid0rKBBedtUuewqpR/gJTmFrsezhCUdz9+nzKdBc7Uk4kZ+ejSvoVFmo2sA7V0qlH1rvxWbix0OLC0TSxGkkddNVtg3SApMcc6pdGNeizNAVJfc7f4NUAOW/y4kwBTAO8av3CtBPJvVksda4=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DS0PR12MB9726.namprd12.prod.outlook.com (2603:10b6:8:226::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 05:38:49 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 05:38:49 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [RFC PATCH v3 02/10] drm/amdgpu: Add cwsr functions
Thread-Topic: [RFC PATCH v3 02/10] drm/amdgpu: Add cwsr functions
Thread-Index: AQHcZFV0e7HR60EOMUeV38qMZWlDVbUtP2+Q
Date: Mon, 22 Dec 2025 05:38:48 +0000
Message-ID: <DM4PR12MB5152CF59A88110C65914D50CE3B4A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20251203130436.745633-1-lijo.lazar@amd.com>
 <20251203130436.745633-3-lijo.lazar@amd.com>
In-Reply-To: <20251203130436.745633-3-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-22T05:30:15.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DS0PR12MB9726:EE_
x-ms-office365-filtering-correlation-id: 8afbaabe-9397-483c-833c-08de411c61e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?57kzENOcd8g0RdgT8QevTNMs4XuFJCVpfl5pgfapueOKB1QkYEHBkK385pHJ?=
 =?us-ascii?Q?of02hyTX9Ct6YUCkZJWZe25T8Zc5MsuVPvS9Bnh3M0J521fsTSbO7AHI9u3E?=
 =?us-ascii?Q?6PrFLlflYYJzC/2W1+WqpHvJ6qIGk/YMjMlHfChG91vkU16Y8+hnpYrnJDFD?=
 =?us-ascii?Q?13kVpABlIS4Zkwn3x+rv7EX5jhSe1VkitrbYDjVnWoQwJRrE2xUWSGMla3EW?=
 =?us-ascii?Q?kCRhk1YrhLMDuQrE6+hNg6IxfRi0/Gid1G8JohqBIo3GlLMKBH3SJ62MDQXl?=
 =?us-ascii?Q?TsxPdnRnfDQ0iTIeIc2MgQpF2D5j2qfVjeGCJSw4/zTASMZy2Zd1ywMI2Q8J?=
 =?us-ascii?Q?ueRG/p3S8az89c0V37HB73ZmSuDcfkWkMiMaBotH+w8RfGtnfXMaXnSV+nUD?=
 =?us-ascii?Q?IT81adl/lhSneVT/nCc7vhtFWHMyx/HwDTnMkou91ATP7BQylU6O6eJv+AVz?=
 =?us-ascii?Q?Sa7wjwwskymn8gPjOCnZo+oSxHlLwX/C90uqzmVZWKyPARU3L2VtncnvGH1v?=
 =?us-ascii?Q?tKAyQOazv9RcTVXBUM8kuYWJglTN84Y6PA5pmMriqqOgwqj20BC4Jk2WrN1N?=
 =?us-ascii?Q?EsIQkQW5uCqoqK24ePJofnhJ41/dP+9jP+r48+UkxqZtkLrmYch/elX3o2v9?=
 =?us-ascii?Q?7vAbEOOqsDbA+sra4i0MjpnEnyywXK9B55aWr1LXXMguvPHlxLg8fyB7Fx18?=
 =?us-ascii?Q?sRp+GQ18X0qFk8UJl/pU5C98dMF314mc2+hanmk84yYKJKWZKCGPB9ddd0Mg?=
 =?us-ascii?Q?keXQA4uJzw8UmaECEkvOYEF7cxs5pqy/ixDbIpg5350Y1zqNgIlid9/7Jr2+?=
 =?us-ascii?Q?emG5P0haRse1rzzimf5so+IAig3RrjkN688Ur6KUIO4Omenmv6L0AJ4yFth6?=
 =?us-ascii?Q?Zwd0HYlBFdTT5nwiHnxfYijVLAuj5Ip+Ky9i5tbDnshOY+K3fy6L+Kx0vaxx?=
 =?us-ascii?Q?SEWHKZPOGQdzCs2lAPKejfy6A/USE4d5V0IbF6Pw5WBbtNil2MwlOoQ7mmn0?=
 =?us-ascii?Q?5tCJV1oxSNgrUZ4VZfj4GrxNxMvuVa01HOpY5DhqCzDDPihqtwQODkvOB2vw?=
 =?us-ascii?Q?cib7hPuSwLWo6dCLUvb5mTSh57AsETbTPFpCSsBGWrkcOOdXyrpDlnT3OhNy?=
 =?us-ascii?Q?Ro/KPm/d3jQ1vNbsW8lncKGNUN0C5elNBCT8uNSWfVzynTG4ZLmzdKqSdC24?=
 =?us-ascii?Q?McLNfbxn+lCTync3h6bEbjya/6UzZrGIZYdYrEDwxAN5/x+0MMW1GDsbeRPS?=
 =?us-ascii?Q?NK4sqOU81UvEhApQJlnESgr+tTX5bjoaywH5HfWGuiRmjNoEKS+yphatlQxr?=
 =?us-ascii?Q?F6PycHglxbZDZA8SXvmWNymyvGhmkl0SWGP0I8S4b8RMfQokbjMWfimGfMzt?=
 =?us-ascii?Q?UbfQkXZo/hg3UsL3O7le3fjaDdeq/BDpYBUuHj100YxLbHKa34+2qkNF0xCS?=
 =?us-ascii?Q?pawXFFg0/tZdIjxR4P08gtGVcoMI8ur2XsDHLKpH+nNY0v6O2mfSYUlBbhry?=
 =?us-ascii?Q?krdBYgm3oFDRHgdQ5Us1+TTlvHcb2AwaiRL7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6NJr6qjJ+LzSrEntrK5hHiRWWKkg43mctfkJ/vyuH5i+lDbSXyHd/Etu+e5y?=
 =?us-ascii?Q?qCDkhrAg0l+2V3baSXhvqwKEPBSL9eRuWgXNNkJzt9ru1ztZjuTKv8QrSvmD?=
 =?us-ascii?Q?E0ZJJ82pJlo+Qfe/1c6VZjLeTMYq7cjSCbe6h0RXsgO+yzgOdRJtJoW8fmcg?=
 =?us-ascii?Q?xmf6q1wLRcixyLeZ6HwLgy2IJuOL0UNFGu3XInNrIfv3ZoBC81PFCGxhC3p2?=
 =?us-ascii?Q?+9dS5cwkmsh4bazkb+7rW6wDirNb079FeMi/Pr1s3qNifWFQrvW2+Kt/KVUZ?=
 =?us-ascii?Q?DI/AR5fK/0R9xmvrbDGlkEt090N6HnJsQ4p8kR9ze7oawDcUI2aEjBMx/fyx?=
 =?us-ascii?Q?5wdJGEMb0NpsT4+CG4+nJRv7xxszIJXHxD6lJyxIAdE25TBC7BjI/CbKy02U?=
 =?us-ascii?Q?EjKsFtXVu8mlGDpadJbqSILDOU17dYYqaNII7zRJTNhBWnriEb0YCLLfF4PQ?=
 =?us-ascii?Q?Q0Le0VNGsCQKhOxgM0Xz2UoZDqTihdvu1+nfTk2SepmCwnE/IJeQ4I1T0k86?=
 =?us-ascii?Q?BoDRkkvZkm/bDB3GOa/81TcJLewBz8vXRTE0LaPplh8tFxedfloezejMGBQc?=
 =?us-ascii?Q?JSzqj92ZG6oM66UEBlIq8FMC44dMFKHIT6vK6JInnJWwTDgIaCbnKEp2nSx8?=
 =?us-ascii?Q?A3nbKWrEWKY52Q7cPD/qEYO3OAR9I8B/qItBLUPQrMSKn0+A3ZdDm1PXbd2w?=
 =?us-ascii?Q?nnvibif1T+cq9T3ZrbMKft6MYW/hQaufMjLzQ+zd0FMi8hFp6m43JOYudvHe?=
 =?us-ascii?Q?Y1zh/g0+FEBW+8MisvUUIL5lRhnv5gQhSngZSRc5QE+x7RgToF7K6zqEOGnN?=
 =?us-ascii?Q?Imok7SziIEtKAfpYIwPWBtTUewasgdWDlkfKg8BRWtDkL7aBHJq8/Gu/ydnT?=
 =?us-ascii?Q?MVAeOmbwVQ+eO3yKBoS8HNWHSf8InbBNuaCWX3A+NIzMNdV06O/EKy72c1Bu?=
 =?us-ascii?Q?fw/mH5+AzSaDq/T3omzglXNdKpd6lxCPmPTFX0tymJNDDmoNPGLv5KlhP984?=
 =?us-ascii?Q?wU371hRhzyNNU6KIg0ZpikkUtSyI0ulOSgRDUiLFWR3GdAevnieBsPswC13T?=
 =?us-ascii?Q?c8hmYDifydYIV/CHo2osojDZjZJ1uGY3KeoegyopfIhjfVgYzyoUlqBp+fu+?=
 =?us-ascii?Q?LdXk4RIheJkKUAw4rrtcuDNELY9uj1/IDvm2YvEjggTIO47PX1Vr68X1X7VN?=
 =?us-ascii?Q?BSWscw1+s2/83ilyg5rYGmWXcRdoXS+lDA73p3iDfvejBSohn5SYxtOmCvGA?=
 =?us-ascii?Q?FuuRWREYUakszmN6bQPnSX6jgXLMcnOmQnTnWDBd5Kx+qDmBlZitoK9S42vc?=
 =?us-ascii?Q?dJBZTEp6MPg/HVRrWtTOJ7xU3e1DjV9HRAWMb8yU2m4uY0Fw5YYS5lPoIEga?=
 =?us-ascii?Q?LgOLQ2JxwdSo4Iug+xKZKd9t10jZ+/BLLqtlTgbri0WReqNj9bHojRn9IXRK?=
 =?us-ascii?Q?PF5DiwLD7ZQDWnOfGvP2mj/2mw4G+zMOuyAL7NaMz9mDulFg2uQY/O7dEI0J?=
 =?us-ascii?Q?VGVqgMQijF2LEGKN48u6iWmYybr1wAr9r1k0so5rf1HyZbXO+dpoVx0njhwL?=
 =?us-ascii?Q?x4Aojtsozqwex5GBkEpu/VUlg4j5fN/GIYnvoApR/z3pnl/nh74EI6qtv0Ne?=
 =?us-ascii?Q?WA4SounEH5U+zzUEkPMMaP7+KH4qpJmH3Z2abYxxVsAVi5sGXcGsoX+4tTjt?=
 =?us-ascii?Q?L5jdhT9AQ5pbJZxBy+hLLmOxIQm2IRBQbF90FUkQlEGv4WIH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8afbaabe-9397-483c-833c-08de411c61e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2025 05:38:49.0237 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U4MX7gtM8HeQ4WZZTgOACur3Nva4XJ0PKotT5yG0QoKHR1SSIPTo6jGYvx008vR25WWoT14FdDlcXhuVpZxE3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9726
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

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Wednesday, December 3, 2025 8:55 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [RFC PATCH v3 02/10] drm/amdgpu: Add cwsr functions
>
> Add functions related to cwsr handling inside amdgpu framework.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile      |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 346
> +++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h |
> 67 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   |   2 +-
>  5 files changed, 418 insertions(+), 2 deletions(-)  create mode 100644
> drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
> b/drivers/gpu/drm/amd/amdgpu/Makefile
> index f65021678fc0..a5feb674508a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -67,7 +67,7 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_doorbell_mgr.o
> amdgpu_kms.o \
>       amdgpu_fw_attestation.o amdgpu_securedisplay.o \
>       amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
>       amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o
> amdgpu_dev_coredump.o \
> -     amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o
> amdgpu_ip.o
> +     amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o
> amdgpu_ip.o
> +amdgpu_cwsr.o
>
>  amdgpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index fa71df36f4b3..b9920cab5d31 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -331,6 +331,7 @@ struct kfd_vm_fault_info;  struct amdgpu_hive_info;  =
struct
> amdgpu_reset_context;  struct amdgpu_reset_control;
> +struct amdgpu_cwsr_isa;
>
>  enum amdgpu_cp_irq {
>       AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP =3D 0,
> @@ -1325,6 +1326,8 @@ struct amdgpu_device {
>        * Must be last --ends in a flexible-array member.
>        */
>       struct amdgpu_kfd_dev           kfd;
> +
> +     struct amdgpu_cwsr_info *cwsr_info;
>  };
>
>  static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *ade=
v, diff --
> git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> new file mode 100644
> index 000000000000..c0fc5a383071
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
> @@ -0,0 +1,346 @@
> +/*
> + * Copyright 2025 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person
> +obtaining a
> + * copy of this software and associated documentation files (the
> +"Software"),
> + * to deal in the Software without restriction, including without
> +limitation
> + * the rights to use, copy, modify, merge, publish, distribute,
> +sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom
> +the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> +included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
> KIND,
> +EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> +MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN
> NO EVENT
> +SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY
> CLAIM,
> +DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> +OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
> THE USE
> +OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#include <drm/drm_exec.h>
> +
> +#include "amdgpu.h"
> +#include "cwsr_trap_handler.h"
> +#include "amdgpu_cwsr.h"
> +
> +extern int cwsr_enable;
> +
> +#define AMDGPU_CWSR_TBA_MAX_SIZE (2 * AMDGPU_GPU_PAGE_SIZE)
> #define
> +AMDGPU_CWSR_TMA_MAX_SIZE (AMDGPU_GPU_PAGE_SIZE) #define
> +AMDGPU_CWSR_TMA_OFFSET (AMDGPU_CWSR_TBA_MAX_SIZE)
> +
> +enum amdgpu_cwsr_region {
> +     AMDGPU_CWSR_TBA,
> +     AMDGPU_CWSR_TMA,
> +};
> +
> +static inline uint64_t amdgpu_cwsr_tba_vaddr(struct amdgpu_device
> +*adev) {
> +     uint64_t addr =3D AMDGPU_VA_RESERVED_TRAP_START(adev);
[Zhang, Jesse(Jie)]  A new VA should be reserved for KGD userq to avoid VA =
conflicts with KFD CWSR.

> +
> +     addr =3D amdgpu_gmc_sign_extend(addr);
> +
> +     return addr;
> +}
> +
> +static inline bool amdgpu_cwsr_is_supported(struct amdgpu_device *adev)
> +{
> +     uint32_t gc_ver =3D amdgpu_ip_version(adev, GC_HWIP, 0);
> +
> +     if (!cwsr_enable || gc_ver < IP_VERSION(9, 0, 1))
> +             return false;
> +
> +     return true;
> +}
> +
> +static void amdgpu_cwsr_init_isa_details(struct amdgpu_device *adev,
> +                                      struct amdgpu_cwsr_info *cwsr_info=
) {
> +     uint32_t gc_ver =3D amdgpu_ip_version(adev, GC_HWIP, 0);
> +
> +     if (gc_ver < IP_VERSION(9, 0, 1)) {
> +             BUILD_BUG_ON(sizeof(cwsr_trap_gfx8_hex) >
> +                          AMDGPU_CWSR_TBA_MAX_SIZE);
> +             cwsr_info->isa_buf =3D cwsr_trap_gfx8_hex;
> +             cwsr_info->isa_sz =3D sizeof(cwsr_trap_gfx8_hex);
> +     } else if (gc_ver =3D=3D IP_VERSION(9, 4, 1)) {
> +             BUILD_BUG_ON(sizeof(cwsr_trap_arcturus_hex) >
> +                          AMDGPU_CWSR_TBA_MAX_SIZE);
> +             cwsr_info->isa_buf =3D cwsr_trap_arcturus_hex;
> +             cwsr_info->isa_sz =3D sizeof(cwsr_trap_arcturus_hex);
> +     } else if (gc_ver =3D=3D IP_VERSION(9, 4, 2)) {
> +             BUILD_BUG_ON(sizeof(cwsr_trap_aldebaran_hex) >
> +                          AMDGPU_CWSR_TBA_MAX_SIZE);
> +             cwsr_info->isa_buf =3D cwsr_trap_aldebaran_hex;
> +             cwsr_info->isa_sz =3D sizeof(cwsr_trap_aldebaran_hex);
> +     } else if (gc_ver =3D=3D IP_VERSION(9, 4, 3) ||
> +                gc_ver =3D=3D IP_VERSION(9, 4, 4)) {
> +             BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_4_3_hex) >
> +                          AMDGPU_CWSR_TBA_MAX_SIZE);
> +             cwsr_info->isa_buf =3D cwsr_trap_gfx9_4_3_hex;
> +             cwsr_info->isa_sz =3D sizeof(cwsr_trap_gfx9_4_3_hex);
> +     } else if (gc_ver =3D=3D IP_VERSION(9, 5, 0)) {
> +             BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_5_0_hex) > PAGE_SIZE);
> +             cwsr_info->isa_buf =3D cwsr_trap_gfx9_5_0_hex;
> +             cwsr_info->isa_sz =3D sizeof(cwsr_trap_gfx9_5_0_hex);
> +     } else if (gc_ver < IP_VERSION(10, 1, 1)) {
> +             BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_hex) >
> +                          AMDGPU_CWSR_TBA_MAX_SIZE);
> +             cwsr_info->isa_buf =3D cwsr_trap_gfx9_hex;
> +             cwsr_info->isa_sz =3D sizeof(cwsr_trap_gfx9_hex);
> +     } else if (gc_ver < IP_VERSION(10, 3, 0)) {
> +             BUILD_BUG_ON(sizeof(cwsr_trap_nv1x_hex) >
> +                          AMDGPU_CWSR_TBA_MAX_SIZE);
> +             cwsr_info->isa_buf =3D cwsr_trap_nv1x_hex;
> +             cwsr_info->isa_sz =3D sizeof(cwsr_trap_nv1x_hex);
> +     } else if (gc_ver < IP_VERSION(11, 0, 0)) {
> +             BUILD_BUG_ON(sizeof(cwsr_trap_gfx10_hex) >
> +                          AMDGPU_CWSR_TBA_MAX_SIZE);
> +             cwsr_info->isa_buf =3D cwsr_trap_gfx10_hex;
> +             cwsr_info->isa_sz =3D sizeof(cwsr_trap_gfx10_hex);
> +     } else if (gc_ver < IP_VERSION(12, 0, 0)) {
> +             /* The gfx11 cwsr trap handler must fit inside a single
> +                        page. */
> +             BUILD_BUG_ON(sizeof(cwsr_trap_gfx11_hex) > PAGE_SIZE);
> +             cwsr_info->isa_buf =3D cwsr_trap_gfx11_hex;
> +             cwsr_info->isa_sz =3D sizeof(cwsr_trap_gfx11_hex);
> +     } else {
> +             BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_hex) >
> +                          AMDGPU_CWSR_TBA_MAX_SIZE);
> +             cwsr_info->isa_buf =3D cwsr_trap_gfx12_hex;
> +             cwsr_info->isa_sz =3D sizeof(cwsr_trap_gfx12_hex);
> +     }
> +}
> +
> +int amdgpu_cwsr_init(struct amdgpu_device *adev) {
> +     struct amdgpu_cwsr_info *cwsr_info __free(kfree) =3D NULL;
> +     void *ptr;
> +     int r;
> +
> +     if (!amdgpu_cwsr_is_supported(adev))
> +             return -EOPNOTSUPP;
> +
> +     cwsr_info =3D kzalloc(sizeof(*cwsr_info), GFP_KERNEL);
> +     if (!cwsr_info)
> +             return -ENOMEM;
> +     amdgpu_cwsr_init_isa_details(adev, cwsr_info);
> +
> +     if (!cwsr_info->isa_sz)
> +             return -EOPNOTSUPP;
> +
> +     r =3D amdgpu_bo_create_kernel(adev, AMDGPU_CWSR_TBA_MAX_SIZE,
> PAGE_SIZE,
> +                                 AMDGPU_GEM_DOMAIN_GTT, &cwsr_info-
> >isa_bo,
> +                                 NULL, &ptr);
> +     if (r)
> +             return r;
> +
> +     memcpy(ptr, cwsr_info->isa_buf, cwsr_info->isa_sz);
> +     adev->cwsr_info =3D no_free_ptr(cwsr_info);
> +
> +     return 0;
> +}
> +
> +void amdgpu_cwsr_fini(struct amdgpu_device *adev) {
> +     if (!amdgpu_cwsr_is_enabled(adev))
> +             return;
> +
> +     amdgpu_bo_free_kernel(&adev->cwsr_info->isa_bo, NULL, NULL);
> +     kfree(adev->cwsr_info);
> +     adev->cwsr_info =3D NULL;
> +}
> +
> +/*
> + * amdgpu_map_cwsr_trap_handler should be called during amdgpu_vm_init
> + * it maps virtual address amdgpu_cwsr_trap_handler_vaddr() to this VM,
> +and each
> + * compute queue can use this virtual address for wave save/restore
> + * operations to support compute preemption.
> + */
> +static int amdgpu_cwsr_map_region(struct amdgpu_device *adev,
> +                               struct amdgpu_vm *vm,
> +                               struct amdgpu_cwsr_trap_obj *cwsr,
> +                               enum amdgpu_cwsr_region region)
> +{
> +     uint64_t cwsr_addr, va_flags, va;
> +     struct amdgpu_bo_va **bo_va;
> +     struct amdgpu_bo *bo;
> +     uint32_t size;
> +     int r;
> +
> +     if (!cwsr || !vm)
> +             return -EINVAL;
> +
> +     cwsr_addr =3D amdgpu_cwsr_tba_vaddr(adev);
> +
> +     if (region =3D=3D AMDGPU_CWSR_TBA) {
> +             size =3D AMDGPU_CWSR_TBA_MAX_SIZE;
> +             bo_va =3D &cwsr->tba_va;
> +             bo =3D adev->cwsr_info->isa_bo;
> +             va =3D cwsr_addr;
> +             va_flags =3D (AMDGPU_VM_PAGE_READABLE |
> AMDGPU_VM_PAGE_WRITEABLE |
> +                         AMDGPU_VM_PAGE_EXECUTABLE);
> +     } else {
> +             size =3D AMDGPU_CWSR_TMA_MAX_SIZE;
> +             bo_va =3D &cwsr->tma_va;
> +             bo =3D cwsr->tma_bo;
> +             va =3D cwsr_addr + AMDGPU_CWSR_TMA_OFFSET;
> +             va_flags =3D (AMDGPU_VM_PAGE_READABLE |
> AMDGPU_VM_PAGE_WRITEABLE);
> +     }
> +
> +     *bo_va =3D amdgpu_vm_bo_add(adev, vm, bo);
> +     if (!*bo_va)
> +             return -ENOMEM;
> +
> +     va &=3D AMDGPU_GMC_HOLE_MASK;
> +     r =3D amdgpu_vm_bo_map(adev, *bo_va, va, 0, size, va_flags);
> +
> +     if (r) {
> +             dev_err(adev->dev, "failed to do bo_map on CWSR TBA, err=3D=
%d\n",
> +                     r);
> +             amdgpu_vm_bo_del(adev, *bo_va);
> +             *bo_va =3D NULL;
> +     } else {
> +             if (region =3D=3D AMDGPU_CWSR_TBA)
> +                     cwsr->tba_gpu_va_addr =3D va;
> +             else
> +                     cwsr->tma_gpu_va_addr =3D va;
> +     }
> +
> +     return r;
> +}
> +
> +static int amdgpu_cwsr_unmap_region(struct amdgpu_device *adev,
> +                                 struct amdgpu_cwsr_trap_obj *cwsr,
> +                                 enum amdgpu_cwsr_region region) {
> +     struct amdgpu_bo_va **bo_va;
> +     uint64_t va;
> +     int r;
> +
> +     if (!cwsr)
> +             return -EINVAL;
> +
> +     if (region =3D=3D AMDGPU_CWSR_TBA) {
> +             bo_va =3D &cwsr->tba_va;
> +             va =3D cwsr->tba_gpu_va_addr;
> +     } else {
> +             bo_va =3D &cwsr->tma_va;
> +             va =3D cwsr->tma_gpu_va_addr;
> +     }
> +
> +     r =3D amdgpu_vm_bo_unmap(adev, *bo_va, va);
> +     if (r) {
> +             dev_err(adev->dev,
> +                     "failed to do bo_unmap on CWSR trap handler, err=3D=
%d\n",
> +                     r);
> +             return r;
> +     }
> +
> +     amdgpu_vm_bo_del(adev, *bo_va);
> +     *bo_va =3D NULL;
> +
> +     return r;
> +}
> +
> +/* TBD : Handle APU allocation */
> +int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +                   struct amdgpu_cwsr_trap_obj **trap_obj) {
> +     struct amdgpu_cwsr_trap_obj *cwsr __free(kfree) =3D NULL;
> +     struct amdgpu_bo *bo;
> +     struct drm_exec exec;
> +     int r;
> +
> +     if (!amdgpu_cwsr_is_enabled(adev))
> +             return -EOPNOTSUPP;
> +
> +     cwsr =3D kzalloc(sizeof(*cwsr), GFP_KERNEL);
> +     if (!cwsr)
> +             return -ENOMEM;
> +
> +     bo =3D adev->cwsr_info->isa_bo;
> +     drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> +     drm_exec_until_all_locked(&exec)
> +     {
> +             r =3D amdgpu_vm_lock_pd(vm, &exec, 0);
> +             if (likely(!r))
> +                     r =3D drm_exec_lock_obj(&exec, &bo->tbo.base);
> +             drm_exec_retry_on_contention(&exec);
> +             if (unlikely(r)) {
> +                     dev_err(adev->dev,
> +                             "failed to reserve for CWSR allocs: err=3D%=
d\n",
> +                             r);
> +                     goto err;
> +             }
> +     }
> +
> +     r =3D amdgpu_bo_create_kernel(adev, AMDGPU_CWSR_TMA_MAX_SIZE,
> PAGE_SIZE,
> +                                 AMDGPU_GEM_DOMAIN_GTT, &cwsr->tma_bo,
> NULL,
> +                                 &cwsr->tma_cpu_addr);
> +     if (r)
> +             goto err;
> +
> +     r =3D amdgpu_cwsr_map_region(adev, vm, cwsr, AMDGPU_CWSR_TMA);
> +     if (r)
> +             goto err;
> +     r =3D amdgpu_cwsr_map_region(adev, vm, cwsr, AMDGPU_CWSR_TBA);
> +     if (r) {
> +             amdgpu_cwsr_unmap_region(adev, cwsr, AMDGPU_CWSR_TMA);
> +             goto err;
> +     }
> +
> +     *trap_obj =3D no_free_ptr(cwsr);
> +
> +err:
> +     drm_exec_fini(&exec);
> +     if (r)
> +             amdgpu_bo_free_kernel(&cwsr->tma_bo, NULL, NULL);
> +
> +     return r;
> +}
> +
> +void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +                   struct amdgpu_cwsr_trap_obj **trap_obj) {
> +     struct amdgpu_bo *tba_bo;
> +     struct amdgpu_bo *tma_bo;
> +     struct drm_exec exec;
> +     int r;
> +
> +     if (!trap_obj || !*trap_obj || !(*trap_obj)->tma_bo)
> +             return;
> +     tba_bo =3D adev->cwsr_info->isa_bo;
> +     tma_bo =3D (*trap_obj)->tma_bo;
> +
> +     if (!tba_bo || !tma_bo)
> +             return;
> +
> +     drm_exec_init(&exec, 0, 0);
> +     drm_exec_until_all_locked(&exec)
> +     {
> +             r =3D amdgpu_vm_lock_pd(vm, &exec, 0);
> +             if (likely(!r))
> +                     r =3D drm_exec_lock_obj(&exec, &tba_bo->tbo.base);
> +             drm_exec_retry_on_contention(&exec);
> +             if (likely(!r))
> +                     r =3D drm_exec_lock_obj(&exec, &tma_bo->tbo.base);
> +             drm_exec_retry_on_contention(&exec);
> +             if (unlikely(r)) {
> +                     dev_err(adev->dev,
> +                             "failed to reserve CWSR BOs: err=3D%d\n", r=
);
> +                     goto err;
> +             }
> +     }
> +
> +     amdgpu_cwsr_unmap_region(adev, *trap_obj, AMDGPU_CWSR_TBA);
> +     amdgpu_cwsr_unmap_region(adev, *trap_obj, AMDGPU_CWSR_TMA);
> +err:
> +     drm_exec_fini(&exec);
> +     amdgpu_bo_free_kernel(&(*trap_obj)->tma_bo, NULL, NULL);
> +     kfree(*trap_obj);
> +     *trap_obj =3D NULL;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> new file mode 100644
> index 000000000000..26ed9308f70b
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
> @@ -0,0 +1,67 @@
> +/*
> + * Copyright 2025 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person
> +obtaining a
> + * copy of this software and associated documentation files (the
> +"Software"),
> + * to deal in the Software without restriction, including without
> +limitation
> + * the rights to use, copy, modify, merge, publish, distribute,
> +sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom
> +the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> +included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
> KIND,
> +EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> +MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN
> NO EVENT
> +SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY
> CLAIM,
> +DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> +OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
> THE USE
> +OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#ifndef AMDGPU_CWSR_H
> +#define AMDGPU_CWSR_H
> +
> +#include <linux/types.h>
> +
> +struct amdgpu_bo;
> +struct amdgpu_bo_va;
> +struct amdgpu_device;
> +struct amdgpu_vm;
> +
> +/**
> + * struct amdgpu_cwsr_obj - CWSR (Compute Wave Save Restore) buffer
> +tracking
> + * @bo: Buffer object for CWSR area
> + * @bo_va: Buffer object virtual address mapping  */ struct
> +amdgpu_cwsr_trap_obj {
> +     uint64_t tma_gpu_va_addr;
> +     uint64_t tba_gpu_va_addr;
> +
> +     struct amdgpu_bo *tma_bo;
> +     struct amdgpu_bo_va *tba_va;
> +     struct amdgpu_bo_va *tma_va;
> +     void *tma_cpu_addr;
> +};
> +
> +struct amdgpu_cwsr_info {
> +     /* cwsr isa */
> +     struct amdgpu_bo *isa_bo;
> +     const void *isa_buf;
> +     uint32_t isa_sz;
> +};
> +
> +int amdgpu_cwsr_init(struct amdgpu_device *adev); void
> +amdgpu_cwsr_fini(struct amdgpu_device *adev);
> +
> +int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +                   struct amdgpu_cwsr_trap_obj **cwsr_obj); void
> +amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +                   struct amdgpu_cwsr_trap_obj **cwsr_obj); static inlin=
e bool
> +amdgpu_cwsr_is_enabled(struct amdgpu_device *adev) {
> +     return adev->cwsr_info !=3D NULL;
> +}
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 139642eacdd0..783ca2b8dfef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -173,7 +173,7 @@ struct amdgpu_bo_vm;
>  #define AMDGPU_VA_RESERVED_SEQ64_SIZE                (2ULL << 20)
>  #define AMDGPU_VA_RESERVED_SEQ64_START(adev)
>       (AMDGPU_VA_RESERVED_CSA_START(adev) \
>                                                -
> AMDGPU_VA_RESERVED_SEQ64_SIZE)
> -#define AMDGPU_VA_RESERVED_TRAP_SIZE         (2ULL << 12)
> +#define AMDGPU_VA_RESERVED_TRAP_SIZE         (3ULL << 12)
[Zhang, Jesse(Jie)] )]  A new VA should be reserved for KGD userq to avoid =
VA conflicts with KFD CWSR.

>  #define AMDGPU_VA_RESERVED_TRAP_START(adev)
>       (AMDGPU_VA_RESERVED_SEQ64_START(adev) \
>                                                -
> AMDGPU_VA_RESERVED_TRAP_SIZE)
>  #define AMDGPU_VA_RESERVED_BOTTOM            (1ULL << 16)
> --
> 2.49.0

