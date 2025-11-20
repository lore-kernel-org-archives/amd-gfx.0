Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4887CCF8545
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 06:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1E8F10E0F1;
	Thu, 20 Nov 2025 06:41:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GgFusaMR";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A1CD10E0F1
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 06:41:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6suuJcpWzqkjuiAdIo5ze35j5gkOi998JjkhWqnlZS3ymNqIQgHa0c09HdrqNnA35ZGtOUjZSWbAd27S/aqGkvKAIk8fxaRsCner8iJdr2pyZUIQtUjiL3mS7Rpv/M1xz4qAy1WOzKYZOm1tLh5+UZNb4Hw0YqMdkHpdh1U69tMncCIN+ja5Uh18fXzo/eOBAhK0RzWyJrUdyxleQY6i4WEPYX09GnNIStVeErJI4P/JiKp0gwJcXyrcIIet7KOFe4Q5fNPqejUmw1E+EP65Q397ECsZnpfJo9YQOazv+M16To63W9fGk8rRE40ihsXpFfgVE2tIyC7vnS1WIwn7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ReK4ZacYsJ+l2iNvD6Ta/KBUcsRhQfZZPZ0JaIsyfcc=;
 b=HfWpcisMA1ir2k18WrZkZ6evrUkWVeLcAumiKrLOmXJz2Qt0AM19l1YJ/90fbrXDQr0227rpGdrN/K0uiLsb8j5pcWMht8rGaS0+ZlecWqSQAoqcwpeBCsnFuWmmyuvlgVholJ+81bPZQDE5be/RYw1jjmpnqV703fcDaSqJrlyK/XYPg0Un3KXkldzfrcapQWmL8hbRP/HqlnpWCdwfDCBgRUsIfZ1AeolkAwrjFSJjv3Sfnuy5XGlcw+TxbF+A66OcJxEKpG93PU67s+JAEHQ0a/H6nxyPsYyhqZOpiMSmR9RMwtV2chUhKIZKun5Y/ihoAuIgYxum3kriGwBzAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReK4ZacYsJ+l2iNvD6Ta/KBUcsRhQfZZPZ0JaIsyfcc=;
 b=GgFusaMRMcbQDcpVdt4+cncJYM5iQafy6vWo2qQOcSNc5FlsQjHpUJmAQHtAUG7B94+p/KNXZM6ABLeI+jjUKb4SLFF0dbkUGcFFfIoqOnRWRmfBJjxliZ5W3Zm46AZUZ4F85hGWxzsQeGTjjKXRkPRJxPRbL7u0D7W+SO3Qbgo=
Received: from DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) by
 SA3PR12MB7859.namprd12.prod.outlook.com (2603:10b6:806:305::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Thu, 20 Nov 2025 06:41:23 +0000
Received: from DM4PR12MB6012.namprd12.prod.outlook.com
 ([fe80::caee:6914:7597:725c]) by DM4PR12MB6012.namprd12.prod.outlook.com
 ([fe80::caee:6914:7597:725c%3]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 06:41:23 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: adjust the visibility of pp_table sysfs node
Thread-Topic: [PATCH] drm/amd/pm: adjust the visibility of pp_table sysfs node
Thread-Index: AQHcSTryCZvdQDmGk0GlNyL+I1sFP7T7Pr6Q
Date: Thu, 20 Nov 2025 06:41:23 +0000
Message-ID: <DM4PR12MB6012F6F0A577D1D47A950B9082D4A@DM4PR12MB6012.namprd12.prod.outlook.com>
References: <20251030011651.1433120-1-kevinyang.wang@amd.com>
In-Reply-To: <20251030011651.1433120-1-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-20T06:40:46.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6012:EE_|SA3PR12MB7859:EE_
x-ms-office365-filtering-correlation-id: 21005ed1-4efa-4731-211f-08de27ffd272
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?nErgV8y0bHemLyLNeFMJ+87+RAsnrSPqMPRdTzsaxWBrpxdewRlskQ7KJKSJ?=
 =?us-ascii?Q?t7Y91q28Igaiw45E1xpF9HVQrGPY1Z7J2LBqOahaI1RO+WWdxgHCQdSIeEJo?=
 =?us-ascii?Q?cPFvAOZ1enZTZ116O0gU7PhERK5rK6QfJXkYo+Ptge0L1cZkdsYkloHTL48G?=
 =?us-ascii?Q?0Y7EExQXT6bX3ZODNEGJ5bRaqRyH/ITU27OkQF46kDdyhZ7MTfvcwhT9AaDw?=
 =?us-ascii?Q?UWl55ZxrG9ODudLeEH+tebDUptQegjNe+YGkUERvUkHCYGApmq/TdxUsmQtK?=
 =?us-ascii?Q?kWs+tbxRsBbLbtFcsVBAtSri7zXQFrKnYykq73vHorGrSSOXBtU21os+LHIB?=
 =?us-ascii?Q?CXXYhriBQInxhICSdOPnwvGDti8v9LV5mmy7OX4WXjsXqdSAc1qPMs4EtRyK?=
 =?us-ascii?Q?StMyd96pyvChNL0amY5elEPxJ4XtxrQzd2sXWrb8NsrIA33BZydQcNOzOTbY?=
 =?us-ascii?Q?LyY8kbuFf+PWrY8Q2kPecit7Z8mITS9jqrfR9a/ES72EUOeRnYdUyLKpxLpr?=
 =?us-ascii?Q?8+njduLSWjjoqRkzJg+eR0+6gymZPO2S9gCLjEtaGxpmiX/ASdKBdeSPNILA?=
 =?us-ascii?Q?N4bV78zSK4nWFMN4czG9VSM33txCeCeDCfs6PFA02a2KkQerqDYj2WmXefig?=
 =?us-ascii?Q?0KQvx4IoTMGLfClbypd+4mD2H3l5a6hSmVjswDvGvyRBx/qSgh7cLSfq66oe?=
 =?us-ascii?Q?FCe052sPMNyRPrKXgbp+GRJ/0Lg6tvxZZSz4krKcyHlt/R4Hz/i2xmgpEB4S?=
 =?us-ascii?Q?cf3PXUQUS6PORJQHpINqW+oDdxjed/Spx+P1ajV7TxdStE1d+krbkkPtSbwi?=
 =?us-ascii?Q?qiVYMltMAZsPUmAc0FuRogU3ChHS3YMlKLJoZ92TVscQnOj/3NQKw/+z+tF/?=
 =?us-ascii?Q?RaAOC8xvk8xY6w2GJ6oX79lnIA5ZGg5Ni6wDs9qVN3YYFwNgjjMNAx8wQgRG?=
 =?us-ascii?Q?eyF4/hOt5a/jmtIY62Xpg63x5PkEOb39qQvnHqln7AdRly69QRKsrqWCWmLX?=
 =?us-ascii?Q?r3TVA1PknFv+hgjxpaDQ5R6SoaGKHWEjfvLudxqg2agfB9QujUxBlrF7Z32F?=
 =?us-ascii?Q?wvZKsigl+xRgQw/5ARXN8mH1VxdMMfSpVvefr+o+PpwhqqyrOMU+3LdftgUi?=
 =?us-ascii?Q?KKH8/WLNMBrr7FfaTu/SlnWAWA9L2lTWpsl9UHO444wUatITmkSrvZCWLyPF?=
 =?us-ascii?Q?dPeKa/b6yO3n+jtL5joODEQoEIOXK3OzoEleQocB/vHbVjo7HfhOVs/aytEA?=
 =?us-ascii?Q?yXKtHKSJQ6aGt3ENIYMEYW6BTk98BSeVdhW/fp4l30I/XXC1c9gE2IhMvqQi?=
 =?us-ascii?Q?fsgCUUxywNiCMZClFA0vP75H7c+3x3MjU1YVi9341kWuNLNFYAdfbqYDF6hh?=
 =?us-ascii?Q?v3/OUKhSf7lLHh1AD+8a2TjtB1NrfjgvhLyT786LvlCsGHZH+PMXFrSKBhLH?=
 =?us-ascii?Q?FgUxOlF/ra6zIyP+F1C7T2rTLyWbCLmOzcHOXHudMCTg9uug1BP8Q3W/ylCL?=
 =?us-ascii?Q?jwOCxpak6I7D7juHAUagJPY/6RdItJ+lu2AH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6012.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y+fq9T4ngE6Yv2vrddAVHaBi/LTRWBfQP06WOMyiORuKkAP5w01m4mDrhDXO?=
 =?us-ascii?Q?lRPZ7DFhLkUCfjhG7jQqndKAz9Y/byzdU4xKfljvDx0EXNerPM+1XPBeeqeB?=
 =?us-ascii?Q?4HTXKkB1V1tWsI9AiU9NOerq9z4o6VrCNlvD3E0bPtk8T3uY/h+sK2SC4kqZ?=
 =?us-ascii?Q?9KeLhMl9PnhYffQW4bm/7ZVGJeqg6kGQyn0nz3B2uSGGMDwRxu2daxs1OwiC?=
 =?us-ascii?Q?aTc2pNGA5biDWFiJEBtu89nXjgmNAodro80cds/NGNu3V7UCssIf0SGt95Tu?=
 =?us-ascii?Q?auNZkwl3b5V82VZkDWMKYYLTAzjNvM/t93rRXOfdtYohHDUa1/CTU3KEj5ED?=
 =?us-ascii?Q?iBC1iaxDhuoBosED4avUJP24yy+MnKFgQ67uvzTZ88XOOcOidE7jVOF1O5xq?=
 =?us-ascii?Q?0YRa06Yzz4oIHOPATXvSvZ1yrIAqdPI6pFkCqU293UU3b6OyLJyAxSSuQFSn?=
 =?us-ascii?Q?s+bazRf8d0HepgyZJ1C/Jl6wdkkcRpACTjSq4Yk4Sn1LovSu11zixazpmbmH?=
 =?us-ascii?Q?PIOvQTI4p6Usau827/1aYsKieHkE6Imo/3JO+IgiNs71wsHvoWcnG7yPFabM?=
 =?us-ascii?Q?qitE9qGJa7QExdtHMy18fP5tjpggF07z6urvMvpgRc4P7KWTqIUFuMw6Cfvd?=
 =?us-ascii?Q?fLVv2EUGI6D3k3l91CXDO+BnsYXCinBLcU2WsPcniAjYyoOwpJeXEHXMdhJe?=
 =?us-ascii?Q?bCIxAbhQ7qyEpwkRtOgMWez4MIlforEBJ3wqi4MMSd4mSyD4ur9XdtlBg+sI?=
 =?us-ascii?Q?twHlNHaK0gxe0UPOMb5/2S6t5SSUmRIIi3Q4gCU9rRKEFyJaneLekOgLOJ23?=
 =?us-ascii?Q?szsme/S06mC6j8PHzQ/svS3wB03dYbbLOxo+mPjKAYjakNIfI9wL9gkDFpQb?=
 =?us-ascii?Q?PB0GvJVtjhpnH6PYtgptjTzUFp9to/eZ0qMFpP4Tas0Z8FpZRWBgfCvjfeaX?=
 =?us-ascii?Q?gmuZgl5bh+Y6/PddID66+5gmClv9Z6zBbc9nBnfRKtZAqr05c9KCf10s3Fka?=
 =?us-ascii?Q?Spm5HU6wWgEUuRbW/n5CHZGpmH2tn1y/51p0XC6TaNDBrrNxbWa78u4InU6B?=
 =?us-ascii?Q?LbZE2MAbyg67EzepUcjEsjjjTa3xtQAaRYGpDlPZxRrTrDyW/LWG9Be0YqIq?=
 =?us-ascii?Q?Mz8sgTH0Zz75a4rEA2IV/YY5a4McnMk/rIPmLK0hfiIHZZZ4TEmkb7g442kY?=
 =?us-ascii?Q?xYJFnmKys+QL3b97mdXAfpwRiaAd2NnkgNAaXG6JalU4Jr/GRYrQJXtiM7Mu?=
 =?us-ascii?Q?D9b/54kCqFG+iUWqHLP5sYzG2FkcISvVpi1wTSpC771PoHLaEtKCYeVrsamU?=
 =?us-ascii?Q?ghsVXQSqCCi36UXzJT2V1KaP3IUOFNPCjlhV2f1RGpBjeNDZYJbPj3JnYiSQ?=
 =?us-ascii?Q?muCXHj1BvSAywB6B/9tVvPAD5sCOmuRf0S+nSNVgD/1pHxxOXQfypmz3EUwF?=
 =?us-ascii?Q?rdt6IiO6m/Vpf7FYpNipTojNqPMNmBEMdPXA7prh1cl95gjxi+BjHd/+DKxc?=
 =?us-ascii?Q?E7fTgiS3R7pxBVooambGVklalopqTyIf7wFE5UQCl87nYVo3uWdfNVEQTwi9?=
 =?us-ascii?Q?5+EndSm67YMVcKgE6QA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6012.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21005ed1-4efa-4731-211f-08de27ffd272
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 06:41:23.3866 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dzXVjwsNK3op83NdJgc8cnyQ+/5JLjiS9hlAfWyhXRiHJaDvigUnoNeD+NznuYFq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7859
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

Ping...

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Thursday, October 30, 2025 09:17
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH] drm/amd/pm: adjust the visibility of pp_table sysfs node

- make pp_table invisible on VF mode (only valid on BM)
- make pp_table invisible on Mi* chips (Not supported)
- make pp_table invisible if scpm feature is enabled.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index c83d69994380..3a14e0ff38ae 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2507,7 +2507,7 @@ static struct amdgpu_device_attr amdgpu_device_attrs[=
] =3D {
        AMDGPU_DEVICE_ATTR_RO(pp_num_states,                            ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
        AMDGPU_DEVICE_ATTR_RO(pp_cur_state,                             ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
        AMDGPU_DEVICE_ATTR_RW(pp_force_state,                           ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
-       AMDGPU_DEVICE_ATTR_RW(pp_table,                                 ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
+       AMDGPU_DEVICE_ATTR_RW(pp_table,                                 ATT=
R_FLAG_BASIC),
        AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,                              ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF,
                              .attr_update =3D pp_dpm_clk_default_attr_upda=
te),
        AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk,                              ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF,
@@ -2639,6 +2639,21 @@ static int default_attr_update(struct amdgpu_device =
*adev, struct amdgpu_device_
                if (amdgpu_dpm_get_apu_thermal_limit(adev, &limit) =3D=3D
                    -EOPNOTSUPP)
                        *states =3D ATTR_STATE_UNSUPPORTED;
+       } else if (DEVICE_ATTR_IS(pp_table)) {
+               switch (gc_ver) {
+               case IP_VERSION(9, 4, 3):
+               case IP_VERSION(9, 4, 4):
+               case IP_VERSION(9, 5, 0):
+                       /* No PPTable support on Mi* chips */
+                       *states =3D ATTR_STATE_UNSUPPORTED;
+                       break;
+               default:
+                       if (adev->scpm_enabled)
+                               *states =3D ATTR_STATE_UNSUPPORTED;
+                       else
+                               *states =3D ATTR_STATE_SUPPORTED;
+                       break;
+               }
        }

        switch (gc_ver) {
--
2.34.1

