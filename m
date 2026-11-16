Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED85D606A89D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 22:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lols0Hew
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BC9410E075;
	Mon, 16 Nov 2026 22:32:46 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012039.outbound.protection.outlook.com
 [40.107.200.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F06AE10E075
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 22:32:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o6UK3LH2/CLX50vAl3xCrMQEODIQCtwqXsbb/bV0FFBYeyFd08BpZ7bVJ3Z/GZdzZemmJSen7lQg1M2ryD6V4S3LiznwyAdGnuhThUZLrdOd2cmlJPjcXtJuRjJH2Bzg22EhgEaQh7hFVYLTaJD7wA7K2CsphLIMUWziUZOnqtt3NkcyWBhThGmxMjDgfHJA2kpmpnXnQ5Ykw6BhfSfEzt6HUBU/WqAkDJMiXFEzaG2X2WHq50NwAwIjfinVWztGzCMy7x/ftBQT6JhUIKBpVW0drYY74MftECHzxhc0r7NZXACIjhqeszWFYCq4K4oIBCv1eQK9/17VK2l4n3Spxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7d6OiseZOXL0LXUQ93JJ0gbvnV4V0+PGC4xCELwAX4=;
 b=HDHsnAy4fAidR1D1OtNL0tiRs0TVaKyBTq83Rc+NBEVj1LCMM6tlYMxWACFClxOp64mOoXWMvHGx9VXDLDv9OZ+ELKp7WFe9AwDo2tHJhzqbgYEk2OkwSdu58rmoj0XuRp0UJ1JlWIxF7Gse9+N3f6J3EK0wY89DBTMvCPeOmMG2bba+gsdRR6G67y+eRF2rriOy5KT/jfhX/HuCEuc5gcSvfJiZidDyO972Uz2mLPgMwscVAoW44d+5g2WJo7j/BWoeqLikOd7gCuTg5cakUkZI95LgKLe9UHZjQHaFaE5XCoyRXdvPxfFK9GMBs/KuziDEPxgt5Ozq9WV96h2cRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7d6OiseZOXL0LXUQ93JJ0gbvnV4V0+PGC4xCELwAX4=;
 b=lols0Hew5vsCKIgbQQQB7C7vGWlXwf7B1Hab02pqMrIPJoxqj31dZE4wZ76RSS2zF5GvtiGddft8I++9RiE58DpjbgXl68U2FIzH8XcGLN7wzUJD5lMuqVKnDC0jZy2RXJiTMZ89fIVahkDiL6xl6i7RLj2CrdEVVlK6gL9sFHw=
Received: from PH7PR12MB6812.namprd12.prod.outlook.com (2603:10b6:510:1b6::15)
 by CY8PR12MB7100.namprd12.prod.outlook.com (2603:10b6:930:60::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Mon, 16 Nov
 2026 22:32:35 +0000
Received: from PH7PR12MB6812.namprd12.prod.outlook.com
 ([fe80::a6a8:1bde:c3fb:1069]) by PH7PR12MB6812.namprd12.prod.outlook.com
 ([fe80::a6a8:1bde:c3fb:1069%4]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 22:32:34 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH v6] drm/amd: Select the firmware signing scheme the PSP
 reports
Thread-Topic: [PATCH v6] drm/amd: Select the firmware signing scheme the PSP
 reports
Thread-Index: AQHddFKVMNKMB9rmzUS/jS81PBFuErcxS4TA
Date: Mon, 16 Nov 2026 22:32:33 +0000
Message-ID: <PH7PR12MB681281105628E57EE173CBC5F77C2@PH7PR12MB6812.namprd12.prod.outlook.com>
References: <20261114160925.390350-1-superm1@kernel.org>
In-Reply-To: <20261114160925.390350-1-superm1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-11-16T22:32:08.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6812:EE_|CY8PR12MB7100:EE_
x-ms-office365-filtering-correlation-id: 5cda6d7f-9dbb-440c-d76c-08df44318254
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|6133799003|261009223027099003|5023799004|11063799006|56012099006|261028144727099003|261102123227099003|261026121527099003|261022105027099003|261022075727099003|261026140227099003|261021121427099003|38070700021|10067099003;
x-microsoft-antispam-message-info: X/pn9zrgh30evcW1BVNflAIOiMLEWR9s2XRnTMRMiuSa1Y/eQDsD6Th7XJns7xcr9B8bb+U40prxrskTtpu+ET2sewbsOew4wZsGRj9WkCa5250XEGPjdcF5pyYIsYB6381FZ3ShS1c3KZiLEyKGzgeRv91mIJApzw8uxml96qtBE7y9lCum9G6XV5iVzuMSJ8IFZWYxke+BPLaHVTXJGZdnnvLqfuxrmYB08QkX1NG6ywm+FbIYx8fwwIG9Ff9XMKF6bHRrnizuv31eJkgcD6/rmQQV8OXkLcB+q/RmvS+GjCUmXAOnvfeZEUl+Tm1i1CuoYApFXzbOyDywVnO/AS0zyjhak2FQK0x0Kd5oarwPBukIAJ/HW2qfNOk+ACSlvWorJTfhvsTdcri5wh/20ig0MhymzlHkLty06B0obY5V8Xea3ZRK2eUiHy13OZsAAiBb5EpnXaj1wshXHGQxXtwRuFarz7dVSxUgyBla86Pun3OdZF+CEzOqhAbmIpRQXkW1/GnvmLX1wBrQpdcTkYFRDoIOtlHCnvch8GZSDKrR+OUR1KTiD3UGw7fZnSjUq45XQHLGAKHAf8+PQDdqFwXIbtaIgRXnh+elFjLZLHvtkDEXVvJ+MMkY/iKCocBfCeVZeCbAJjn8cs29UhjJx/ziYnjlDefqkIpOhTfqMRM/5sHMbuS3cx21DSnyg4+tNFIg4IJv69o23ljn1Gr6E766mLkM/OfShgQHnZXXv40=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6812.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(261009223027099003)(5023799004)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261026140227099003)(261021121427099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kh3ybIew9irTNJiok+e3uWC4/o9x0iqBCKgqaqeio0ZJYNJNcif4OZWClvOX?=
 =?us-ascii?Q?lQraU2mcX/V9k9s530pHil6LSNyzPzBvB9C+TCgICS+fdUnuFrAdGgEKA1xq?=
 =?us-ascii?Q?SZ04C00ukehUwDr/jd8pw6N6N6coLaQx58oXZqsVpy5O5LXXjdDcdIDDFsl7?=
 =?us-ascii?Q?KGaYKcVOqEQgAvcHg+121KrXucgxKKnxfJeFkenfxzQ8aJOc8i1a7g8HH6jN?=
 =?us-ascii?Q?A0ze6vtuws89z+RyKqWDPfO85nAjNL1XyWTW6dp0/mgp+ilXqDTF930aU43O?=
 =?us-ascii?Q?gDFs5i9DyVN7MqSAdTxAqLzqqf4UL1xqtgCZUjh+7ugnPilfiMX6N9kcqeqr?=
 =?us-ascii?Q?2BHMfpFP5Gucky/LPmaYT/XqQIK/zTkYgLR6vNgl9ftpIykDLvU7IkdeXlcr?=
 =?us-ascii?Q?KHSb26DuCmT/gHqJ5/Y2gJF38kNTxmtJdVunv6bFVtJJWId9idda3cTWO0It?=
 =?us-ascii?Q?NLUI2lOqCZtmUAcU2aRuRh8vdqiwFa5BkhS/ZvLWjNEzhveR6hGxrmxI3GxY?=
 =?us-ascii?Q?2wXHlKBU2gKXM9Ly9fkhVhQLM7w5jxCfAJ6wBTUL/5rbwa/bhnge3lyXyXs8?=
 =?us-ascii?Q?lBqjDE70m6BO5HovoegWVSXdJ0+2coXrUOJ6uW0nm9crT0TOe6tbH0fqAvqQ?=
 =?us-ascii?Q?2n4jgQVHzia9e0BWO+uh0A61SWIf5/O5HQauaDqbbYXmA6ybHEJw0e0AeMp9?=
 =?us-ascii?Q?Rrd3mKd5sz/trThKeylc+WSGWCPyppPfMXjavN6x2fYxju47hEx1Dc9tfmUm?=
 =?us-ascii?Q?H8cWyR0G1TRqwqXtGZp5hSECj3qxxc+/GWyCbV2tPRk7ec8o6P3Q0MnH/495?=
 =?us-ascii?Q?FCFADSp4ECU0tos0wjbKwkEMEswUa1DIkON1M1eoO1tU+ENPhAAnBsY9VREr?=
 =?us-ascii?Q?kpijx27Pd8bZaYTLXXG2x9UeS6l4hrg7g9j8ghLHE+wGBpgXKB+BJukn9/9v?=
 =?us-ascii?Q?kZCIQy/1Gkg//0Hhjl7IH3KvZPM2KycXW7GrMyu2c+fXSoHLAtLSFD2bw/qt?=
 =?us-ascii?Q?Ey3ciJw1Ur7Wykz1BEMua+RZeDgjtI+A0OAlFW2uUu5ViBJSjpS55K8VNQHR?=
 =?us-ascii?Q?BnG8puWppTov36dpJ+pDcezZZvd1bJeLkNEnyWHGPSFKTQl/7SljaM7SlOu8?=
 =?us-ascii?Q?93n02d2Hnmlh1bYMohpNgO+MWgM793EDbsUNX7zYKsZ/PxfJ9EZJ0sAdVLAD?=
 =?us-ascii?Q?WZ3p8MwXD9Hzi3z0+vzyksV0nJA/64wywEbyLFYhTQL2onMBYdMyCzK9Zp/U?=
 =?us-ascii?Q?2fInNZhZBfERqNek6gImAs0+oTUFpH7WQ1QRcseIuDhauYaUcwo2F138/Cdy?=
 =?us-ascii?Q?k0O7OsxM/SFLuohSUrJByAh8/5m6XQS0myljSxfcps0BsfdRgfgqkhhe42D2?=
 =?us-ascii?Q?qBaSUv1aMm066jaZclNjlo5teRxy5596Q6GokpWA27KTgLVkD5lDFPHq4/4k?=
 =?us-ascii?Q?ipU4H9W1oSWGDOr6Sga14I0LcKl/IjXqBt+oXofNJPWfc9NabTSXj1VRC89f?=
 =?us-ascii?Q?hT7XpDQkkq4fA6gHhHUPv5ssHmoZlX0aSg1hUkEWFP3xjGdwcXt0mZB1pXDw?=
 =?us-ascii?Q?E4DLgI9hrQz4dyFpJ2ZLmdPwwBvebFesyART4MAJb2PXkMSapQo7B8g1yDL7?=
 =?us-ascii?Q?+/nuVtgQLgnM6kl4L0/WmiiH6P3Z/yJ7uCwdEe11RJTEuiAJBal7TRrz9U+Z?=
 =?us-ascii?Q?5/q84uoqmvqOGnEyr1JfZeMxxbUyyQVGo/GrPNGVYgfT3DOL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6812.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cda6d7f-9dbb-440c-d76c-08df44318254
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 22:32:33.9935 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: boqO54JiRtmAcHaEDolobmUVrTNVD53fjRfQ54fvCcTptd4/PFj2VWgj4Oysbpd5O7j18a8riv6GADcve3yq7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7100
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Public

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario
> Limonciello (AMD)
> Sent: Saturday, November 14, 2026 11:09 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: [PATCH v6] drm/amd: Select the firmware signing scheme the PSP
> reports
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> Some platforms ship BIOS with either a default or an alternative trust au=
thority,
> so firmware for every IP must be signed with the matching scheme.
> The PSP advertises which one is in use in bit 6 of C2PMSG_63, and in bit
> 28 whether this is a preproduction part, which needs firmware of its own.
>
> Add amdgpu_psp_init_fw_variant() which reads those bits through amdgpu's
> own MMIO, and keep the result in adev->firmware.sign_type next to load_ty=
pe,
> where preproduction is a type of its own. It is initialized once, after I=
P discovery
> has populated the register bases and only when firmware is loaded through=
 the
> front door (the PSP). Only MP0 15.0.0 reports it. For all other ASICs, SR=
-IOV VFs
> and an inaccessible register (all ones) the defaults are kept:
> AMDGPU_FW_SIGN_DEFAULT. A preproduction part that also reports the
> alternative scheme is not expected, so warn about it and use the default
> firmware.
>
> Firmware for preproduction parts is named with a "_p" suffix before the
> extension and firmware for the alternative scheme with an "_l" suffix (e.=
g.
> "foo.bin" becomes "foo_p.bin" or "foo_l.bin"). Production parts on the de=
fault
> scheme use the plain names. Do the substitution centrally in
> amdgpu_ucode_request() so it covers every IP that loads firmware through =
it
> (PSP, SMU, DMUB, GC, IMU, MES, SDMA, VCN, VPE, ...) without each loader
> having to care. There is no fallback to the default file: it would be rej=
ected
> anyway. Declare the variants with MODULE_FIRMWARE() so that initramfs
> generators include them.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v6:
>  * Return errors on unknown firmware combination (Lijo)
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  4 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 20 ++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     | 35 ++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h     |  9 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  4 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 16 +++++++
>  drivers/gpu/drm/amd/amdgpu/imu_v11_0.c        |  4 ++
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  8 ++++
>  drivers/gpu/drm/amd/amdgpu/psp_v15_0.c        | 47 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/psp_v15_0.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |  2 +
>  drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c         |  2 +
>  .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |  2 +
>  .../amd/display/amdgpu_dm/amdgpu_dm_dmub.h    |  2 +
>  15 files changed, 157 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 19a566187dfb5..b24ccdd958a7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2101,6 +2101,10 @@ static int amdgpu_device_ip_early_init(struct
> amdgpu_device *adev)
>                       amdgpu_ip_version((adev), GC_HWIP, 0) =3D=3D
> IP_VERSION(9, 4, 4);
>       }
>
> +     /* Needs the register bases, and must be known before requesting
> firmware */
> +     if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP)
> +             amdgpu_psp_init_fw_variant(adev);
> +
>       total =3D true;
>       for (i =3D 0; i < adev->num_ip_blocks; i++) {
>               ip_block =3D &adev->ip_blocks[i];
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 82a2684dbd2e1..6d693b5249ddd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -403,6 +403,26 @@ static uint64_t
> psp_get_runtime_db_header_pos(struct amdgpu_device *adev)
>       return pos;
>  }
>
> +/*
> + * Which firmware the platform needs, as reported by the PSP in
> +C2PMSG_63: the
> + * signing scheme and whether this is a preproduction part. The
> +defaults are kept if
> + * the ASIC doesn't report it or it can't be read.
> + */
> +void amdgpu_psp_init_fw_variant(struct amdgpu_device *adev) {
> +     if (amdgpu_sriov_vf(adev))
> +             return;
> +
> +     switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
> +     case IP_VERSION(15, 0, 0):
> +     case IP_VERSION(15, 0, 9):
> +             psp_v15_0_0_get_fw_variant(adev);
> +             break;
> +     default:
> +             break;
> +     }
> +}
> +
>  /*
>   * Helper funciton to query psp runtime database entry
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index a4ec60f6c3170..7d8fc8eb2b125 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -631,6 +631,7 @@ int psp_ta_invoke(struct psp_context *psp,
>
>  int psp_xgmi_initialize(struct psp_context *psp, bool set_extended_data,=
 bool
> load_ta);  bool psp_is_xgmi_ta_supported(struct psp_context *psp);
> +void amdgpu_psp_init_fw_variant(struct amdgpu_device *adev);
>  int psp_xgmi_terminate(struct psp_context *psp);  int psp_xgmi_invoke(st=
ruct
> psp_context *psp, uint32_t ta_cmd_id);  int psp_xgmi_get_hive_id(struct
> psp_context *psp, uint64_t *hive_id); diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index d2ce526dd95cc..1632eda91acd9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -1527,6 +1527,37 @@ void amdgpu_ucode_ip_version_decode(struct
> amdgpu_device *adev, int block_type,
>       snprintf(ucode_prefix, len, "%s_%d_%d_%d", ip_name, maj, min, rev);=
  }
>
> +/* Add the suffix of the firmware variant before the extension: foo.bin
> +-> foo_l.bin */ static int amdgpu_ucode_set_suffix(struct amdgpu_device
> +*adev, char *fname) {
> +     const char *suffix;
> +     size_t base;
> +
> +     switch (adev->firmware.sign_type) {
> +     case AMDGPU_FW_SIGN_PREPROD:
> +             suffix =3D "_p.bin";
> +             break;
> +     case AMDGPU_FW_SIGN_ALT:
> +             suffix =3D "_l.bin";
> +             break;
> +     case AMDGPU_FW_SIGN_UNKNOWN:
> +             drm_warn(adev_to_drm(adev), "Unknown firmware
> signing\n");
> +             return -EINVAL;
> +     default:
> +             /* Default variant: the name is unchanged */
> +             return 0;
> +     }
> +
> +     if (!strends(fname, ".bin"))
> +             return -EINVAL;
> +
> +     base =3D strlen(fname) - strlen(".bin");
> +     if (strscpy(fname + base, suffix, AMDGPU_UCODE_NAME_MAX - base)
> < 0)
> +             return -EOVERFLOW;
> +
> +     return 0;
> +}
> +
>  /*
>   * amdgpu_ucode_request - Fetch and validate amdgpu microcode
>   *
> @@ -1555,6 +1586,10 @@ int amdgpu_ucode_request(struct amdgpu_device
> *adev, const struct firmware **fw,
>               return -EOVERFLOW;
>       }
>
> +     r =3D amdgpu_ucode_set_suffix(adev, fname);
> +     if (r)
> +             return r;
> +
>       if (required =3D=3D AMDGPU_UCODE_REQUIRED)
>               r =3D request_firmware(fw, fname, adev->dev);
>       else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> index 35277b240f25a..0b2d1bccb999c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> @@ -571,6 +571,14 @@ enum amdgpu_firmware_load_type {
>       AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO,
>  };
>
> +enum amdgpu_firmware_sign_type {
> +     AMDGPU_FW_SIGN_DEFAULT =3D 0,
> +     AMDGPU_FW_SIGN_ALT,
> +     AMDGPU_FW_SIGN_PREPROD,
> +     /* Unexpected combination of signing bits, default firmware may not
> work */
> +     AMDGPU_FW_SIGN_UNKNOWN,
> +};
> +
>  enum amdgpu_ucode_required {
>       AMDGPU_UCODE_OPTIONAL,
>       AMDGPU_UCODE_REQUIRED,
> @@ -606,6 +614,7 @@ struct amdgpu_firmware_info {  struct
> amdgpu_firmware {
>       struct amdgpu_firmware_info
> ucode[AMDGPU_UCODE_ID_MAXIMUM];
>       enum amdgpu_firmware_load_type load_type;
> +     enum amdgpu_firmware_sign_type sign_type;
>       struct amdgpu_bo *fw_buf;
>       unsigned int fw_size;
>       unsigned int max_ucodes;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 6c12d8aa3c769..1df2725d31e0c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -66,6 +66,8 @@
>  #define FIRMWARE_VCN5_0_1            "amdgpu/vcn_5_0_1.bin"
>  #define FIRMWARE_VCN5_0_2            "amdgpu/vcn_5_0_2.bin"
>  #define FIRMWARE_VCN5_3_0            "amdgpu/vcn_5_3_0.bin"
> +#define FIRMWARE_VCN5_3_0_ALT                "amdgpu/vcn_5_3_0_l.bin"
> +#define FIRMWARE_VCN5_3_0_PREPROD    "amdgpu/vcn_5_3_0_p.bin"
>
>  MODULE_FIRMWARE(FIRMWARE_RAVEN);
>  MODULE_FIRMWARE(FIRMWARE_PICASSO);
> @@ -95,6 +97,8 @@ MODULE_FIRMWARE(FIRMWARE_VCN5_0_0);
>  MODULE_FIRMWARE(FIRMWARE_VCN5_0_1);
>  MODULE_FIRMWARE(FIRMWARE_VCN5_0_2);
>  MODULE_FIRMWARE(FIRMWARE_VCN5_3_0);
> +MODULE_FIRMWARE(FIRMWARE_VCN5_3_0_ALT);
> +MODULE_FIRMWARE(FIRMWARE_VCN5_3_0_PREPROD);
>
>  static void amdgpu_vcn_idle_work_handler(struct work_struct *work);  sta=
tic
> void amdgpu_vcn_reg_dump_fini(struct amdgpu_device *adev); diff --git
> a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index d5f428ac19bf3..b42733d85ea89 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -134,13 +134,29 @@
> MODULE_FIRMWARE("amdgpu/gc_11_5_6_me.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_5_6_mec.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_5_6_rlc.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_7_0_pfp.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_pfp_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_pfp_p.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_7_0_me.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_me_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_me_p.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_7_0_mec.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mec_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mec_p.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_7_0_rlc.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_rlc_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_rlc_p.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_7_1_pfp.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_pfp_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_pfp_p.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_7_1_me.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_me_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_me_p.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_7_1_mec.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_mec_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_mec_p.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_7_1_rlc.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_rlc_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_rlc_p.bin");
>
>  static const struct amdgpu_hwip_reg_entry gc_reg_list_11_0[] =3D {
>       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS), diff --git
> a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> index 09dc01a425d13..a409911939d38 100644
> --- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> @@ -44,7 +44,11 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_3_imu.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_5_4_imu.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_5_6_imu.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu_p.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_7_1_imu.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_imu_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_imu_p.bin");
>
>  static int imu_v11_0_init_microcode(struct amdgpu_device *adev)  { diff =
--git
> a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 0895c29899d2b..c76a6c4e69992 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -61,9 +61,17 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_4_mes1.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes_2.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes1.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2_p.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1_p.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes_2.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes_2_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes_2_p.bin");
>  MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes1.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes1_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes1_p.bin");
>
>  static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block);  static =
int
> mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block); diff --git
> a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
> b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
> index abaa40b6def90..94b3fce1bc70a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
> @@ -32,11 +32,19 @@
>  #include "mp/mp_15_0_0_sh_mask.h"
>
>  MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc_l.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc_p.bin");
>  MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta_l.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta_p.bin");
>  MODULE_FIRMWARE("amdgpu/psp_15_0_5_toc.bin");
>  MODULE_FIRMWARE("amdgpu/psp_15_0_5_ta.bin");
>  MODULE_FIRMWARE("amdgpu/psp_15_0_9_toc.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_9_toc_l.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_9_toc_p.bin");
>  MODULE_FIRMWARE("amdgpu/psp_15_0_9_ta.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_9_ta_l.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_9_ta_p.bin");
>
>  #define regMPASP_PCRU0_MPASP_C2PMSG_64
> 0x4280
>  #define regMPASP_PCRU0_MPASP_C2PMSG_64_BASE_IDX
> 2
> @@ -108,6 +116,45 @@ static int psp_v15_0_0_ring_stop(struct psp_context
> *psp,
>       return ret;
>  }
>
> +/*
> + * C2PMSG_63 bit 6: 0 =3D default firmware signing, 1 =3D alternative
> + * C2PMSG_63 bit 28: 0 =3D production part, 1 =3D preproduction part  */
> +#define PSP_V15_0_0_FW_SIGN_ALT              BIT(6)
> +#define PSP_V15_0_0_FW_PREPROD               BIT(28)
> +
> +void psp_v15_0_0_get_fw_variant(struct amdgpu_device *adev) {
> +     bool alt, preprod;
> +     u32 val;
> +
> +     if (!adev->reg_offset[MP0_HWIP][0])
> +             return;
> +
> +     val =3D RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_63);
> +     if (val =3D=3D 0xffffffff) {
> +             drm_warn(adev_to_drm(adev), "Unable to access
> regMPASP_SMN_C2PMSG_63\n");
> +             return;
> +     }
> +
> +     alt =3D val & PSP_V15_0_0_FW_SIGN_ALT;
> +     preprod =3D val & PSP_V15_0_0_FW_PREPROD;
> +
> +     if (alt && preprod) {
> +             adev->firmware.sign_type =3D AMDGPU_FW_SIGN_UNKNOWN;
> +             return;
> +     }
> +
> +     if (preprod)
> +             adev->firmware.sign_type =3D AMDGPU_FW_SIGN_PREPROD;
> +     else if (alt)
> +             adev->firmware.sign_type =3D AMDGPU_FW_SIGN_ALT;
> +
> +     dev_info(adev->dev, "PSP firmware: %s signing, %s part
> (C2PMSG_63=3D0x%08x)\n",
> +              alt ? "alternative" : "default",
> +              preprod ? "preproduction" : "production", val); }
> +
>  static int psp_v15_0_0_ring_create(struct psp_context *psp,
>                                enum psp_ring_type ring_type)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h
> b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h
> index ebd612103526f..081be8e8268bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h
> @@ -26,5 +26,6 @@
>  #include "amdgpu_psp.h"
>
>  void psp_v15_0_0_set_psp_funcs(struct psp_context *psp);
> +void psp_v15_0_0_get_fw_variant(struct amdgpu_device *adev);
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index 4845588c4c247..2586d49f1e940 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -56,6 +56,8 @@ MODULE_FIRMWARE("amdgpu/sdma_6_1_1.bin");
>  MODULE_FIRMWARE("amdgpu/sdma_6_1_2.bin");
>  MODULE_FIRMWARE("amdgpu/sdma_6_1_3.bin");
>  MODULE_FIRMWARE("amdgpu/sdma_6_1_4.bin");
> +MODULE_FIRMWARE("amdgpu/sdma_6_1_4_l.bin");
> +MODULE_FIRMWARE("amdgpu/sdma_6_1_4_p.bin");
>  MODULE_FIRMWARE("amdgpu/sdma_6_4_0.bin");
>
>  #define SDMA1_REG_OFFSET 0x600
> diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
> b/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
> index c92c5fc59aeb9..cefb8d739faf8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
> @@ -31,6 +31,8 @@
>  #include "vpe/vpe_2_0_0_sh_mask.h"
>
>  MODULE_FIRMWARE("amdgpu/vpe_2_0_0.bin");
> +MODULE_FIRMWARE("amdgpu/vpe_2_0_0_l.bin");
> +MODULE_FIRMWARE("amdgpu/vpe_2_0_0_p.bin");
>  MODULE_FIRMWARE("amdgpu/vpe_2_2_0.bin");
>
>  #define VPE_THREAD1_UCODE_OFFSET     0x8000
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
> index 383c53afd1f67..7cd08a9a957d6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
> @@ -62,6 +62,8 @@ MODULE_FIRMWARE(FIRMWARE_DCN_351_DMUB);
>  MODULE_FIRMWARE(FIRMWARE_DCN_36_DMUB);
>  MODULE_FIRMWARE(FIRMWARE_DCN_401_DMUB);
>  MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB);
> +MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB_ALT);
> +MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB_PREPROD);
>  MODULE_FIRMWARE(FIRMWARE_DCN_42B_DMUB);
>  MODULE_FIRMWARE(FIRMWARE_DCN_60_DMUB);
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
> index df3e776c1ad14..219e9c0427441 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
> @@ -61,6 +61,8 @@ int dm_init_microcode(struct amdgpu_device *adev);
>  #define FIRMWARE_DCN_36_DMUB
>       "amdgpu/dcn_3_6_dmcub.bin"
>  #define FIRMWARE_DCN_401_DMUB
>       "amdgpu/dcn_4_0_1_dmcub.bin"
>  #define FIRMWARE_DCN_42_DMUB
>       "amdgpu/dcn_4_2_dmcub.bin"
> +#define FIRMWARE_DCN_42_DMUB_ALT
>       "amdgpu/dcn_4_2_dmcub_l.bin"
> +#define FIRMWARE_DCN_42_DMUB_PREPROD
>       "amdgpu/dcn_4_2_dmcub_p.bin"
>  #define FIRMWARE_DCN_42B_DMUB
>       "amdgpu/dcn_4_2_1_dmcub.bin"
>  #define FIRMWARE_DCN_60_DMUB
>       "amdgpu/dcn_6_0_0_dmcub.bin"
>  #define FIRMWARE_RAVEN_DMCU          "amdgpu/raven_dmcu.bin"
> --
> 2.55.0

