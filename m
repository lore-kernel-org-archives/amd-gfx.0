Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B786C021AB
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 02:10:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C41FB10E9E7;
	Thu, 13 Feb 2025 02:10:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XOnN83lx";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88F7210E9D4
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 02:10:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ucwHDUpuLgzi4kmn3c4Mi3OhsWSdFwxARVW8UtnvruAIZJYRtq0TLbb0S/+/KuSmb4O4ZBRhrNP2tbP5U8PN66SDqN9H0hnkxSzUT8YrrK30fjJogOKggS9nU0wBRNTNwNejpuYh03oJPaANTQ7RgV5JrE5sWiwxfrCoepSEXJ1rVmzNNP3dHe1E0S6xVxTSmnZ3vUFNoXy5gjZzUR8j0TytQXIs6hYbqgJnaBbATc/U6fsRgjOHSieULcd82zXKT0DeZw4Kf4tiKih+jecSWJmtlO+DjIS2gTdHGdo1UZsuuITE7UewGNMVm83HjCKbW+I2rSlYqEBH+030rKZDzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ah9+T3ubHssoDv9kt+6zzs88tLb7bQU7OqQLaj7U/jk=;
 b=KsI98VsNqAr1mlOdn7bnO84SnkkKasBeOp15pTPSDgAYIzLVZvsu9l/bF4S6QgfQjo6twCqepxwrhh6hZ2YromJTTHTEAUDt/EL01F4rzOJ1XF73j+b8H/DTeLjIuSPviFgfNykBfcNRirTaQ9XS1g+jn7GT/spjfVPBJw2CQWJNHqIsOI5LKrRCTPvPnqaU1pzXgQNm5B4Hx/671UIc7z4yn6CDWiYF/VXotLiseP/RmCb+PJ+zgJegzlb//nOKAwbb92+FhzFtraMXMea538w/JZUxsDnT2JtxFQkwiQj8idG0MwqJUi1MwDMNdrTuE/LPaOl5ulvsGObeLnc/cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ah9+T3ubHssoDv9kt+6zzs88tLb7bQU7OqQLaj7U/jk=;
 b=XOnN83lxv4BGO/+tlVMQ1gWsvUkIbGPXo6z4r23b9qQyjmoDzEAduWtdp9CZReWTuO9QJJHH/WkUxqd+re1oYLpYXhZOiUO0fp0GM+rHYCSTMhAlMcpISWb/5aJeXLdmynITVsxoEzFIdRrkfyHHKok2ryHzKON78xtuNCcHiac=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA1PR12MB7319.namprd12.prod.outlook.com (2603:10b6:806:2b5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 02:10:16 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 02:10:16 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Optimize the enablement of GECC
Thread-Topic: [PATCH] drm/amdgpu: Optimize the enablement of GECC
Thread-Index: AQHbfQYi0nc7E7KPAUuFUKWSmJvVgrNEfaDA
Date: Thu, 13 Feb 2025 02:10:16 +0000
Message-ID: <BN9PR12MB52579F31A56F1FA340CC0B84FCFF2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250212042321.1612148-1-candice.li@amd.com>
In-Reply-To: <20250212042321.1612148-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=02d41990-e980-44df-89b4-046c6e6c2965;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-13T02:06:04Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA1PR12MB7319:EE_
x-ms-office365-filtering-correlation-id: dd5055ab-10bd-4253-7c44-08dd4bd38ef5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?sTs2fb/wJzSCF1hZ0lJc28L/846hk/lw4Y+N5RR9WebmvgJ3vC/xI+MVib0Y?=
 =?us-ascii?Q?YlMxWxVYZ03HgnxYZJd2qL6nEvn4n3OVa7b4PhPrihrmbguOkCFzdrTRSJ+b?=
 =?us-ascii?Q?Kv2XEVRGHm4/X7rxVo2fPGNFnnzvBTQEytk2aGePQcRkdHeT8M1J6Xmir6vc?=
 =?us-ascii?Q?XiPHYN6XJMm6LfqkDZAB40HuPVfFBRa3dlustIQrmQjn7GNxsI/QqQ1Y5BqM?=
 =?us-ascii?Q?lw0nUGLBtI0TaLQBUfdwn8wk95Xrw7DPvbSYzyg+30FfSfh/1kEQWBzP9TeW?=
 =?us-ascii?Q?q8OLRLD8FDLW0UcyJsFS1Gl12Z9bPvm7G35CJ0xC/tg4/q6cHpi4jNE9vRM7?=
 =?us-ascii?Q?eBBbgzRfCBRlzrMh7yJuz02aSoheznNHWOj9kmYvIU0O1MYAeFRkFnGfGh9s?=
 =?us-ascii?Q?rGe4BWcnXFRHnCi0xEiC8dPyZk2j4luAMX/8ebCIvqYZhyw9LNETrZ8vLJQg?=
 =?us-ascii?Q?4wdLh/bkXQCc42TsiXngBZLCrhMJkeb5I7jGOlSvOLNzllZpF4r1BbDnpMow?=
 =?us-ascii?Q?hLOjmlDsKS3WlgIuuKp+Glgy9P8BvZvGev5xBXjq+FpfGSUBgneycYhhazMq?=
 =?us-ascii?Q?OscqU1/rmvMEROHk+VdsdBUYB5dRqNLngq4DQ9upD0swC9QHXNQZUSxXTOf1?=
 =?us-ascii?Q?eaP0Ebi0n6x8F3q/E0QVYZiKz9db+laQ7OK1uFoYPHuttqqei9a6EY4ixZNO?=
 =?us-ascii?Q?YJrJpgpqg0CdhAZnvd48jEXRaS8X23VRpSjLDu+UKG18yjrbrTkl7YH39tV4?=
 =?us-ascii?Q?EgzuM4PkOsDYnVyvj+qVdhu6DxwZ1d28PQ7l90rDex1eQzr1ZGl316IP9cZZ?=
 =?us-ascii?Q?bG5yyafqCjRvYKA+tzICFiTfRatjtwYy18tOfdWmnN5bdXgzzXh1BxjoCNOa?=
 =?us-ascii?Q?/fLK/jCQ6kFVxqIccpGvQ/9iCvm2lxycD7b1GN+cT/EMwHhAJxWyFkt3LyAA?=
 =?us-ascii?Q?i61XBuP8ZRYe+cYLBWPz0xRhqTJSPpZPUYcb8OzOflQPHrFlj0r30JhWzhAL?=
 =?us-ascii?Q?osbUVZt4655UUBNVC9Qs2KWahfwqSpHUSgQyyoOmVufY7qUKpMOb41eAgg1r?=
 =?us-ascii?Q?MueTDpSnQHKdI+RaicDMe/xcUWZwbfwx8IjYRk5IfYP8UfNV8kaNwF05CuPW?=
 =?us-ascii?Q?3iPN3dgagmbfXxtGfjRUe3fQyKd1yAzGu3BJSV10Of8/2hKC377TsY+3UzNM?=
 =?us-ascii?Q?CwJ1G0SS3wLPOL+A6YkO87fXGb/e4vzmOUbytw3vjBfbUY1WRBY4sP9cw4Gx?=
 =?us-ascii?Q?l4W3lFIavsDWIEHY5HLz2nQaHbnxt81+twHn+0TEvtUh1XayOg+uXiLm2d40?=
 =?us-ascii?Q?v7OpaCRhxQKEA04UyX1J46UB7AiShXKa79hhMYEhU2HC9zlK+5zer4Ro4Oum?=
 =?us-ascii?Q?GWcChfQKWeZi1mV2+OtEUwshrO11cwxOzNlCJYfrl2YhagZ02OjhlUvHbL1v?=
 =?us-ascii?Q?4ELRfUCpGebsn0jJia5INDecXiMjmmcr?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0KyiyiOQ8x71R1OZaFIiAwbC1daLR/CsGDT+H9whQrxeoLXu2HyVusErls0b?=
 =?us-ascii?Q?OgJp7kXKQEAvZzLmBZ6Oj2fsxeEGuIAt4xr6Oo26bzzc9RdtGw3WK7QOAHPh?=
 =?us-ascii?Q?i2Af5lKoqSTNopZb0IgdHtp4w9H1lS5Y1vLzKLujwTHemkk7E+OJEyn3XkUn?=
 =?us-ascii?Q?Wl5V9doCfDjDzgcxRf8ySniJfs0dxkVDi/CKapPNGebSmRphrENPuorUvZ57?=
 =?us-ascii?Q?tB8Gwchn4y9qd/yrCN79LUQECta+D2/YsGGspjYKadsweYEaNFrfcg9bfOfZ?=
 =?us-ascii?Q?b4L1PUt9EyBOVwRqh6QR9SH+EPJZTAF3CRa8c1yPMRp9IIDzjCr2nuTkt9VM?=
 =?us-ascii?Q?EFl9oa3BK0bxgfLmaksrXKQWh4Fe82Qdx1axLSCig5IU9+TosFWeynIzYu0C?=
 =?us-ascii?Q?PM3zcROFJFOBrrAfIysmCi3XjC9N32fzEI57hA1N9ns1+gWU1zWJg/GuWZ/s?=
 =?us-ascii?Q?CA8qAaUXQtklbIon7Tlf9CmIh00O12gxzQHBHSDs1ieraIleJlbEuUq45wpe?=
 =?us-ascii?Q?ud2SzNVMjeOgFDConx7Y1gi3+g8U0cF0y+DifEzra+2O1GNuPyUFlYo/kPUd?=
 =?us-ascii?Q?e7YANPQ6mSyc4gV1RRegXZtYn+05ZdqbHXaUfN+4x3E/1zlkHi/zHliRV9fE?=
 =?us-ascii?Q?7XJ2ZVzAGy0LRAmGpU8T5ykJCY7dAJR+y+n08oBkUYDhZl+nxIl0oIZhPnhR?=
 =?us-ascii?Q?kwdp0UtukPBIEtTk4u+LgvIlLdaNowj+J7erzNsorqtqM3YKYycezduN/Wcm?=
 =?us-ascii?Q?6my8Ode0AcdD36pRgFFP7zQNYczJDGtVCyUZTExB95R2Pfeegu4fYgId3dCI?=
 =?us-ascii?Q?9tRw3XC9sjqdwNe2FyIHQTKkw0nTbYn9I9ShP+EVHrrfb2kJPHJ04XRdxJRX?=
 =?us-ascii?Q?jCfdM+cK62i5lNKEZJwr61SUqhpX1TecCapaq9N9DNui/LwPUu11+RWACI5i?=
 =?us-ascii?Q?u1+6yX+dvWZAf2ZVGTeXrQVdteVNPMYtw/t83QmCGGaA8ZNvfBeDEmUONGln?=
 =?us-ascii?Q?btQnmIinlppdQEHjZpawXpMsUaw+71ikXVeFB9xdea1RpC3vKiBjTtHHSAjZ?=
 =?us-ascii?Q?5vivIPMr2O6vzW+KsIuqA7gv6/vvtu2Ae0pCzWQ+FCXcZCMPSLL1SzLMBSj1?=
 =?us-ascii?Q?DAWv6+CaeWJrS0p8WnVNMjiyYDCCBA4lAl3FlXyUY7hQ362tHMkJKMl4ryH3?=
 =?us-ascii?Q?ctMmxvOaot1nskHWMr5iQqRVnjo04Vxks/KepDuyaVVxBwWO40vFYeRT/Cwj?=
 =?us-ascii?Q?CKfUILpDJZ2RIaM6KyH8WNX1gIm99AFNuUgQIq1jXwi0bkkr9Qq4KZY/biEZ?=
 =?us-ascii?Q?dMoV6t+cjK7/Jdat/T7kL/xJJ+n9JZ5v2yGwtzHohStS1NWwD8wcjRA0eBCW?=
 =?us-ascii?Q?/qkvnZExHjgf1M3xVMtkplVXGp4sgR/Nr9EXED891EwIfOFEILxivv279C4P?=
 =?us-ascii?Q?42ZjdJsz15PMRCciatrPeLXlI7mSfI9QU8Br5Rt8DoEYgWBYX/RuCiwxOdnx?=
 =?us-ascii?Q?+i90FZV/SnQ5+5fiB5CPwoDaC2vzQVErEzRSR/qBGhypsZkxH61GNzD1LMOr?=
 =?us-ascii?Q?q5jhrKtBAG/Z70YZQ6I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5055ab-10bd-4253-7c44-08dd4bd38ef5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 02:10:16.5092 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3GSv1AiuDeaYLn6zh6bUcH2wpsy01QVAB23HQ3fRQxvvxzJOUEMs7Z0xjpVTJRODL1Gjy0NzwAhxBTu2nXNMXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7319
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

When dynamic GECC platform is detected and default mem ecc is disabled, Let=
's add kernel message to remind users explicitly set amdgpu_ras_enable=3D1 =
before driver loading to enable GECC if needed.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice =
Li
Sent: Wednesday, February 12, 2025 12:23
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Optimize the enablement of GECC

Enable GECC only when the default memory ECC mode or the module parameter a=
mdgpu_ras_enable is activated.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 18 +++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 31 ++++++++++---------
 3 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index c03a586eb5a26f..7f84cc66a19b34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1167,6 +1167,7 @@ struct amdgpu_device {
        struct ratelimit_state          throttling_logging_rs;
        uint32_t                        ras_hw_enabled;
        uint32_t                        ras_enabled;
+       bool                            ras_default_ecc_enabled;

        bool                            no_hw_access;
        struct pci_saved_state          *pci_state;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_atomfirmware.c
index f873dd3cae1606..eb015bdda8a749 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -549,9 +549,10 @@ bool amdgpu_atomfirmware_mem_ecc_supported(struct amdg=
pu_device *adev)
        u16 data_offset, size;
        union umc_info *umc_info;
        u8 frev, crev;
-       bool ecc_default_enabled =3D false;
+       bool mem_ecc_enabled =3D false;
        u8 umc_config;
        u32 umc_config1;
+       adev->ras_default_ecc_enabled =3D false;

        index =3D get_index_into_master_table(atom_master_list_of_data_tabl=
es_v2_1,
                        umc_info);
@@ -563,20 +564,22 @@ bool amdgpu_atomfirmware_mem_ecc_supported(struct amd=
gpu_device *adev)
                        switch (crev) {
                        case 1:
                                umc_config =3D le32_to_cpu(umc_info->v31.um=
c_config);
-                               ecc_default_enabled =3D
+                               mem_ecc_enabled =3D
                                        (umc_config & UMC_CONFIG__DEFAULT_M=
EM_ECC_ENABLE) ? true : false;
                                break;
                        case 2:
                                umc_config =3D le32_to_cpu(umc_info->v32.um=
c_config);
-                               ecc_default_enabled =3D
+                               mem_ecc_enabled =3D
                                        (umc_config & UMC_CONFIG__DEFAULT_M=
EM_ECC_ENABLE) ? true : false;
                                break;
                        case 3:
                                umc_config =3D le32_to_cpu(umc_info->v33.um=
c_config);
                                umc_config1 =3D le32_to_cpu(umc_info->v33.u=
mc_config1);
-                               ecc_default_enabled =3D
+                               mem_ecc_enabled =3D
                                        ((umc_config & UMC_CONFIG__DEFAULT_=
MEM_ECC_ENABLE) ||
                                         (umc_config1 & UMC_CONFIG1__ENABLE=
_ECC_CAPABLE)) ? true : false;
+                               adev->ras_default_ecc_enabled =3D
+                                       (umc_config & UMC_CONFIG__DEFAULT_M=
EM_ECC_ENABLE) ? true : false;
                                break;
                        default:
                                /* unsupported crev */
@@ -585,9 +588,12 @@ bool amdgpu_atomfirmware_mem_ecc_supported(struct amdg=
pu_device *adev)
                } else if (frev =3D=3D 4) {
                        switch (crev) {
                        case 0:
+                               umc_config =3D le32_to_cpu(umc_info->v40.um=
c_config);
                                umc_config1 =3D le32_to_cpu(umc_info->v40.u=
mc_config1);
-                               ecc_default_enabled =3D
+                               mem_ecc_enabled =3D
                                        (umc_config1 & UMC_CONFIG1__ENABLE_=
ECC_CAPABLE) ? true : false;
+                               adev->ras_default_ecc_enabled =3D
+                                       (umc_config & UMC_CONFIG__DEFAULT_M=
EM_ECC_ENABLE) ? true : false;
                                break;
                        default:
                                /* unsupported crev */
@@ -599,7 +605,7 @@ bool amdgpu_atomfirmware_mem_ecc_supported(struct amdgp=
u_device *adev)
                }
        }

-       return ecc_default_enabled;
+       return mem_ecc_enabled;
 }

 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 196b8dbffc2e28..06f6bbdc7f5e9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1794,7 +1794,22 @@ int psp_ras_initialize(struct psp_context *psp)
                if (ret)
                        dev_warn(adev->dev, "PSP get boot config failed\n")=
;

-               if (!amdgpu_ras_is_supported(psp->adev, AMDGPU_RAS_BLOCK__U=
MC)) {
+               if ((adev->ras_default_ecc_enabled || amdgpu_ras_enable =3D=
=3D 1) &&
+                   amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC)) {
+                       if (boot_cfg =3D=3D 1) {
+                               dev_info(adev->dev, "GECC is enabled\n");
+                       } else {
+                               /* enable GECC in next boot cycle if it is =
disabled
+                                * in boot config, or force enable GECC if =
failed to
+                                * get boot configuration
+                                */
+                               ret =3D psp_boot_config_set(adev, BOOT_CONF=
IG_GECC);
+                               if (ret)
+                                       dev_warn(adev->dev, "PSP set boot c=
onfig failed\n");
+                               else
+                                       dev_warn(adev->dev, "GECC will be e=
nabled in next boot cycle\n");
+                       }
+               } else {
                        if (!boot_cfg) {
                                dev_info(adev->dev, "GECC is disabled\n");
                        } else {
@@ -1809,20 +1824,6 @@ int psp_ras_initialize(struct psp_context *psp)
                                else
                                        dev_warn(adev->dev, "GECC will be d=
isabled in next boot cycle if set amdgpu_ras_enable and/or amdgpu_ras_mask =
to 0x0\n");
                        }
-               } else {
-                       if (boot_cfg =3D=3D 1) {
-                               dev_info(adev->dev, "GECC is enabled\n");
-                       } else {
-                               /* enable GECC in next boot cycle if it is =
disabled
-                                * in boot config, or force enable GECC if =
failed to
-                                * get boot configuration
-                                */
-                               ret =3D psp_boot_config_set(adev, BOOT_CONF=
IG_GECC);
-                               if (ret)
-                                       dev_warn(adev->dev, "PSP set boot c=
onfig failed\n");
-                               else
-                                       dev_warn(adev->dev, "GECC will be e=
nabled in next boot cycle\n");
-                       }
                }
        }

--
2.25.1

