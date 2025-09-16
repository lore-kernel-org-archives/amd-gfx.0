Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C610ECAC599
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 09:37:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DF0E10E76F;
	Tue, 16 Sep 2025 09:37:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BF/uorrb";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010031.outbound.protection.outlook.com [52.101.56.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 003FD10E76E
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 09:37:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhw3vk8GP0Ym7jxZmhvG7qPrVd53EmCUCsrTJ3tzBhzOv28y1H+fTg9df057pcxAVXt+8KY4EQCjz0k0vYOYv9X0z/OUz6oM8MACr7EkUlKRK9VUZJ0SZ308UK+dUXE5IexwJIyRZSeBslGExNJ/eniUAQcJQWbYKLuX+9ZXQrY85A+4CZWoQgL4eW34P4hzmT9bsqWo04mF+zWx4abk00XQZi2lgNYS4QokSDC17H8E3PxpzQq7mjkcSYc1aVFZpv8CxwTyscgWLW9odcZW1WynTosfukx+0pdqeMgSJAf//+2+d2D3SDHxOpttqOfflxFWmYEO0v7NZTXpBnE1iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgFTxSXutLwaWkwrlDmxNV4Bi58UnhjZwIqgunpzOrY=;
 b=hQ1N2A5UUKUxz+syla5kwDxqIKC1RM+moWDX16uAXfy5Jy5Kt1RAbYmuY1FQ6uH6W110T97nNhY0YlkwLeTbLiGoxfBjH8UXvCsO+Ki9e5duwoyknxFRFcQ00zF+9e8OXYSCLB1KCIrTAv8U6flYquugeiSfgc5m1CM36hLcgW2HmjQzpRjn2cCR8NF1Sce+0b51FSJnJJY0qRMKU2P+fUtd3eSik6e0XRFsrHGr/HO1etcnUdZIo+oQXGI3WlLtqK6GSK/dFBBnq9J0OyGGRQiPFwyhjShB/dOFrhjJfsLG3dcfMx+og146VXVp1pGrb7sSem++V7JpS//g0k1ApA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgFTxSXutLwaWkwrlDmxNV4Bi58UnhjZwIqgunpzOrY=;
 b=BF/uorrbeQGUqO7wrPez8/FPZBn+j9x2wWX9lfwT8aVYPSgDg7lFFMVAXDZ+UgVQRYo0Q1K3BG9T3OO2AAAkmZL44jAAH/QHvRtai2ThUSKKAmMGpGIwy4edxLF0EtxM151x2wtuKwiGEGvB0T6n6dM1u8I6umfAD16GN0Ugw8E=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH1PR12MB9646.namprd12.prod.outlook.com (2603:10b6:610:2af::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.22; Tue, 16 Sep 2025 09:37:24 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 09:37:24 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH v3 5/6] drm/amd/pm: Fetch npm data from system metrics
 table
Thread-Topic: [PATCH v3 5/6] drm/amd/pm: Fetch npm data from system metrics
 table
Thread-Index: AQHcJukcvuUPwf93Q0O2IZ/+xrl66rSVixZw
Date: Tue, 16 Sep 2025 09:37:24 +0000
Message-ID: <DS0PR12MB7804FDB9ADE3CAF313EA569A9714A@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20250916090527.2727930-1-asad.kamal@amd.com>
 <20250916090527.2727930-5-asad.kamal@amd.com>
In-Reply-To: <20250916090527.2727930-5-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-16T09:30:00.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|CH1PR12MB9646:EE_
x-ms-office365-filtering-correlation-id: a56ab6ef-c3d9-45e2-0ab7-08ddf504a47f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?TIl2ikaN7mZ2NjyAKN0Sjh/ruySvvuS9R+WM6Z0qOC8Pt8sHlUCFvCmwmMBS?=
 =?us-ascii?Q?mjXmQa/Ax6OufO8kdCU5BKnRJITxurnD7JN8dPYvzyW2d9CWNN5SxVkCQ/uF?=
 =?us-ascii?Q?axbtakyNtIbSTCEoyY0/8KKswzTBnZShkBNv9US2WRrp9M5OMihQbUgIZXyx?=
 =?us-ascii?Q?xjli0Dbwp/WIWKT00ampLrjbD24M4vpnkbq8WfG/Ggu/yjH4bDl0KqJ83yhP?=
 =?us-ascii?Q?GYErY2pnhFVrYZBrvzookZXsnvmDKt9/HMU9PgufwnidIO2J3+d6bmHXZkc3?=
 =?us-ascii?Q?9wB+/SRf+XDN5Qs0lPX5ggaY0LFGjPD6MOUk8ejxGfsT921qkW0qe2XAUrii?=
 =?us-ascii?Q?v4kLZdomn/VYu99r7w5zA24QnsT9ZllTZlhDF5JT/A15UOzDmTbeoTLpGneq?=
 =?us-ascii?Q?l0NoMyMWQraaL4e2P/f2B3o7SsJkmuSyJfnDCdpYyONl0zZv+/AShbY7H1Xd?=
 =?us-ascii?Q?DzhmilmHEH/3gQ0wn8G2xEILohjMm9pXLTfu5Y0vfPdV2n/bu/I3s3yyapjO?=
 =?us-ascii?Q?tSfsQrWOQjuqZUIQISYw5jxqNM8iYSb1zX77GARzImq20FQ21bRNSrbX5ItZ?=
 =?us-ascii?Q?Cec/vIvPhlc9l7HMosLq4iSkjJRcjymg9Foby1gXwg4Rdw7kH1omBSZWjZPM?=
 =?us-ascii?Q?pfvG9mO6lesuiJ3ffUB8CN+65MDPPkRPiXGO5QlVShc0+0aJ/KIhpvA0ggyi?=
 =?us-ascii?Q?oP3hDk697bz8xqEXtcYotes4t1PqVF6J01kVwdrESNIaKKAfNG1K6tOom87W?=
 =?us-ascii?Q?9AueUXUAizrZ5vILV0qJeXJ9Bj4KpyGlumjByuWLNX872shXnayc1oNsKEzW?=
 =?us-ascii?Q?aJim28fuHEc95C9qKbU/iYSHFIo3UJMgzC+L+jwFF/VGfvF11nN30nKmg+9g?=
 =?us-ascii?Q?sdOVP/Sjcw0qM7NifxCVNpTkCWq7TJ4rdhuJkid7/y8FXLwviQ0ckKwzH/vj?=
 =?us-ascii?Q?N3UHnF0h9tAPw1NPcV+9E2AIcs1xBFpsWEBj8dyr3sicWAOXghIqyCZui4iV?=
 =?us-ascii?Q?+QxYqu+aPSAbLLoZXtYCLrClPz9zrh+yXAfu3LVdU5dEnb8Lot114do88uHF?=
 =?us-ascii?Q?v5Q9vGX502y+DufA4s8pxahUsBjzmfxnxLDiXKcArpL+cCGQQMXTu/i2uULE?=
 =?us-ascii?Q?eXmLvmG98v2gEtz+IzbTqze0A1KCeyx42H1U0wK2gtpgTD9hJD/qdLQT79pw?=
 =?us-ascii?Q?MdfCyjBRT7uHpwlLzIlVjo9Kv5bTASYzZchvRjcu2AMw6AKvjG5nbccQJBz4?=
 =?us-ascii?Q?aeM0qx5Ue8s2KhwkgOPtUpQAUQaa3reHjOZRhXuAmtbPp5X0uEgMIi8opsa0?=
 =?us-ascii?Q?N6hOn4g6RHejZZGuOEomOPzBuHoPOa25wGP3Mhjcm3TwArVySAytt6i7WGgN?=
 =?us-ascii?Q?/6Le2AX317vKhr7DUcJwRsSsy/mWvYcmpj/zB6l64cZOC3YFnXbaV3FFCeVg?=
 =?us-ascii?Q?52M7xU0Ra1b/LAG9NoqzlqYy9cl9rcqUtQp9IfcQcByNSclHWA8Qha/sj7tt?=
 =?us-ascii?Q?LUiomNg/SVdPevc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K45hXqU/TdcLqThgmNcRR6XtierYIi64N7x+KAOy7Op7dF3kDEl2cMSgATE6?=
 =?us-ascii?Q?UHrfg8n58qeWndjUrOSws272wcaxgZ+ovrtrg4mNNDJ4oeXyL0ewkx2K//z2?=
 =?us-ascii?Q?4NLePxcO4fOy2eO/iku4k30n+uzUFc71r3pN0heDNm2Tunzv3TLzVJ4Yh1AM?=
 =?us-ascii?Q?209ZlSq2NDjHioa/ay7N6YBBp9VNcKZ65E5oVdGhPpH2Q2w8nXhI0D/ua+NK?=
 =?us-ascii?Q?hoETdLRaluF9cM4bkCUBbEHd4LtJndMCGEisXQBrjmm3tAwFTk5Y1GtHmPnA?=
 =?us-ascii?Q?QArOPOslvnoZdKMcr8BeXslDnjLXqsKjVm/TJoAYjcoZSXvG/hjKfVSSl7Of?=
 =?us-ascii?Q?mKmeArG0/QQdgWp9GBhZUGHGLZTCTD7RxkTi+k+lEqZRm11FfOGc+7oYvgd0?=
 =?us-ascii?Q?NJ1MXyXJ2QMMa/eot5YpJxHFRPnqKoC57PdXVbpAY3TglfB8HmlQNNHWEuuU?=
 =?us-ascii?Q?4DysLwuOyDSka0OeDEEQ08bVocG5qJ9DTrSwOS+lCKlOw0IM/3Vq4XCPfJnZ?=
 =?us-ascii?Q?3RQmtfI6Mj4pYKgbRCYQon5qOyHuwWrUkbc2QcQ2PMs2mKhcCnY7rgzHY9JU?=
 =?us-ascii?Q?cBO0w2c+wJkYqMEpSL/XHrZtazOuB8ejMkrKRS81DLja9jmG47VyeWFUj+/K?=
 =?us-ascii?Q?anAjZ5OcCRwYVb4gZfXfIcZay1t0rRsu4YrEl2rZzGqPMI5y9xfy6AUxg9VK?=
 =?us-ascii?Q?fZ/AOYMW87uNpcHz+xRzSWyRk2LsW9+vK6qzFxC+bhAR5cxFYH7pdW7Uw7l7?=
 =?us-ascii?Q?2Mo610snruGJPGcseYjzd49FDPYgpGyNlJsoVfi9reB7szliZmnfaLS8HlvR?=
 =?us-ascii?Q?SUFI1uQ17qP21i0FvXn8dai/6Zpk9W73OUyDna3VUTLC/z4hYXU6hsRFzFUI?=
 =?us-ascii?Q?q4cevjkpuZcQ99n2a+HG+YfMnD+6JifzV/Sa/iG7MR/5BBTB4CxsHrNlx7gn?=
 =?us-ascii?Q?nrdQMPnzWCCHniF9vyQvtVu9N8B97gQ8d8Fd/ktBBkAS+OOAJq07MITsdq1k?=
 =?us-ascii?Q?Uz5VnVGobvcaq8Lvyc3KgQk/MCa7LP8hd/XXN8wFSj00DtO3iLLK/NS2rNAK?=
 =?us-ascii?Q?Xap+gGvC7o5ZGGRKw9btyaT2ui4ipQRlSxBXCtVrPwjGe20qLzPl0P50/+as?=
 =?us-ascii?Q?3Jp86IGpF+6C2CoHEe5/EW3A+ROKlqax8JlwBEQUlO1vnQQK7tig4bBLD9yf?=
 =?us-ascii?Q?MqDQbmQJnpiF0t02XXz15K2AhjHjVAKRj715JElPzsjhiuyjSni41uNUuzrL?=
 =?us-ascii?Q?G6mE/3VETqj0Qy3dq6UJmXK+Qjy2cobxv0b4uKlOpXn8LdyRg5OBw+sUQ+xq?=
 =?us-ascii?Q?W7kfJY5ezeo0dtiwjnURqeYybR2GWFT3LhrtDerCllXyilG+quycG/9xFUyZ?=
 =?us-ascii?Q?+YgJGB87LIergstU4AJW+DRfylp4orYWyWJn8tHhlB3iUeSql44AiozsZ1YW?=
 =?us-ascii?Q?s5yQE2rKESfCP0KRC4rphKcQVYIXy/9khc55LwwMhwU0gr6bm4EbiTuUgHZf?=
 =?us-ascii?Q?DKw+Nz+T/QclshP1qP/CtZUSU9l0KUHZV+HyWN2DDQ/723IY3CRwyukPjKFT?=
 =?us-ascii?Q?1vx4dqSK5NI/RH0SwTQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56ab6ef-c3d9-45e2-0ab7-08ddf504a47f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 09:37:24.4417 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YUFPQMkgsg33uLtL8EVN2/3I3yI4+PzCUBTJxjtfyOf2pzLuYafO/68XMwt3M2fv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9646
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

[Public]

-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Tuesday, September 16, 2025 2:35 PM
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, =
Morris <Shiwu.Zhang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.=
com>
Subject: [PATCH v3 5/6] drm/amd/pm: Fetch npm data from system metrics tabl=
e

Fetch npm data from system metrics table for smu_v13_0_12

v3: Remove intermittent type for npm data, remove node id check, move npm c=
aps check to npm_get_data function (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>

---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 48 +++++++++++++++++++  ..=
./drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  9 ++++  .../drm/amd/pm/swsmu=
/smu13/smu_v13_0_6_ppt.h  |  5 ++
 3 files changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/driver=
s/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index f10228de416c..48d9ab52be85 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -341,6 +341,9 @@ int smu_v13_0_12_setup_driver_pptable(struct smu_contex=
t *smu)
                        static_metrics->pldmVersion[0] !=3D 0xFFFFFFFF)
                        smu->adev->firmware.pldm_version =3D
                                static_metrics->pldmVersion[0];
+               if (smu_v13_0_6_cap_supported(smu, SMU_CAP(NPM_METRICS)))
+                       pptable->MaxNodePowerLimit =3D
+                               SMUQ10_ROUND(static_metrics->MaxNodePowerLi=
mit);
                smu_v13_0_12_init_xgmi_data(smu, static_metrics);
                pptable->Init =3D true;
        }
@@ -580,6 +583,51 @@ static bool smu_v13_0_12_is_temp_metrics_supported(str=
uct smu_context *smu,
        return false;
 }

+int smu_v13_0_12_get_npm_data(struct smu_context *smu,
+                             enum amd_pp_sensors sensor,
+                             uint32_t *value)
+{
+       struct smu_table_context *smu_table =3D &smu->smu_table;
+       struct PPTable_t *pptable =3D
+               (struct PPTable_t *)smu_table->driver_pptable;
+       struct smu_table *tables =3D smu_table->tables;
+       SystemMetricsTable_t *metrics;
+       struct smu_table *sys_table;
+       int ret;
+
+       if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(NPM_METRICS)))
+               return -EOPNOTSUPP;
+
+       if (sensor =3D=3D AMDGPU_PP_SENSOR_MAXNODEPOWERLIMIT) {
+               *value =3D pptable->MaxNodePowerLimit;
+               return 0;
+       }
+
+       ret =3D smu_v13_0_12_get_system_metrics_table(smu);
+       if (ret)
+               return ret;
+
+       sys_table =3D &tables[SMU_TABLE_PMFW_SYSTEM_METRICS];
+       metrics =3D (SystemMetricsTable_t *)sys_table->cache.buffer;
+
+       switch (sensor) {
+       case AMDGPU_PP_SENSOR_NODEPOWERLIMIT:
+               *value =3D SMUQ10_ROUND(metrics->NodePowerLimit);
+               break;
+       case AMDGPU_PP_SENSOR_NODEPOWER:
+               *value =3D SMUQ10_ROUND(metrics->NodePower);
+               break;
+       case AMDGPU_PP_SENSOR_GPPTRESIDENCY:
+               *value =3D SMUQ10_ROUND(metrics->GlobalPPTResidencyAcc);
+               break;
+       default:
+               *value =3D UINT_MAX;
[lijo]
        This probably should be return -EINVAL.

Thanks,
Lijo

+               break;
+       }
+
+       return ret;
+}
+
 static ssize_t smu_v13_0_12_get_temp_metrics(struct smu_context *smu,
                                             enum smu_temp_metric_type type=
, void *table)  { diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0=
_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 85c0777d6e3e..f749acc7d48e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1801,6 +1801,15 @@ static int smu_v13_0_6_read_sensor(struct smu_contex=
t *smu,
                        ret =3D -EOPNOTSUPP;
                        break;
                }
+       case AMDGPU_PP_SENSOR_NODEPOWERLIMIT:
+       case AMDGPU_PP_SENSOR_NODEPOWER:
+       case AMDGPU_PP_SENSOR_GPPTRESIDENCY:
+       case AMDGPU_PP_SENSOR_MAXNODEPOWERLIMIT:
+               ret =3D smu_v13_0_12_get_npm_data(smu, sensor, (uint32_t *)=
data);
+               if (ret)
+                       return ret;
+               *size =3D 4;
+               break;
        case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
        default:
                ret =3D -EOPNOTSUPP;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index 4652fcd5e068..7ef5f3e66c27 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -49,6 +49,7 @@ struct PPTable_t {
        uint32_t MaxLclkDpmRange;
        uint32_t MinLclkDpmRange;
        uint64_t PublicSerialNumber_AID;
+       uint32_t MaxNodePowerLimit;
        bool Init;
 };

@@ -70,6 +71,7 @@ enum smu_v13_0_6_caps {
        SMU_CAP(BOARD_VOLTAGE),
        SMU_CAP(PLDM_VERSION),
        SMU_CAP(TEMP_METRICS),
+       SMU_CAP(NPM_METRICS),
        SMU_CAP(ALL),
 };

@@ -91,6 +93,9 @@ ssize_t smu_v13_0_12_get_xcp_metrics(struct smu_context *=
smu,
                                     void *smu_metrics);
 int smu_v13_0_12_tables_init(struct smu_context *smu);  void smu_v13_0_12_=
tables_fini(struct smu_context *smu);
+int smu_v13_0_12_get_npm_data(struct smu_context *smu,
+                             enum amd_pp_sensors sensor,
+                             uint32_t *value);
 extern const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[];  ext=
ern const struct cmn2asic_msg_mapping smu_v13_0_12_message_map[];  extern c=
onst struct smu_temp_funcs smu_v13_0_12_temp_funcs;
--
2.46.0

