Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835B9CD6E56
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 09:00:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18BC0113020;
	Mon,  1 Jun 2026 09:00:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CO5Iz6Of";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0B1511301A
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 09:00:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5Jsxn4JTKnwcnLVspniAigUUZaM58/DZxMZSihAvW+yIeL8RJIH57D/02sFu+R5lzLjR5Ea38Pyxc6skdj/1z6tNv+wg2tmLceS/s/YWdL89n7xBN7569G/z8JGTbAquUtif8kQUX/LyzhSEneNJLvvbBho5aSGVQQkBh0gdsmk7zjmHkqtpLY7n3n8mgUfCCpi3zucQTWsiMCzVypAgvBskvl5VuVnAXGBJmbyVCH8VLrayGzJnEn7CEJiGrpuI0l5djs1+O59EKWNgAZp+RyGtzd3pAM+b4aUw9waepBmhm6SFrfhIgkXpptzCpA1iu3a6H9cvOMXdxGTXYObXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkM97hYPrSdeIbVTAHkdApnV8p1bGwbhdz0xuzdgns4=;
 b=TBYZ40vM29uZxdb/fIE3438GdEsDV0XwD4g1vgfV1J9WB9mb/r74G1sPgMc+hw+nefdTu9cs0NFVcCOsUVAA6pC1Pmjy1Ga8mIsZbtAhFdZ/P7SHds0lHUMee6TQlKh/pm4QLeZIuyR75mql0tSUY3144YUu+0E2mBdNAAjv7+0womf8VeUQDaXklQTDaPtTysmsY2Vakdqpapk2JZ2BkHzn4viT8qHf2gHqqQs4pfbkwBA/RMh2Z6n8/5XT+Nla91QKsq2KbNgFjaTMRPBDllGL2438NE+4/Hdg5EY9XoA1CU7FpLzWKLmZ4eEOhPjEvFbdpiaooU3CeAnC95gyCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkM97hYPrSdeIbVTAHkdApnV8p1bGwbhdz0xuzdgns4=;
 b=CO5Iz6OfjEEAebh10M15Ha/Vb2S7uuNkR2lGzpcobKOmQen925R0nKbZa6FDJbk4UDi8Ph2s/SE1xmTHVxcBNKQo54I6brFHQ8uadzR5hyMAySI87c+JtBUhjChX0LQbS+nNr8mRIW49oUZPt2TkJ8GK6tpUJs4spyZvp3YIr34=
Received: from DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18)
 by SA1PR12MB9472.namprd12.prod.outlook.com (2603:10b6:806:45b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Mon, 1 Jun 2026
 09:00:05 +0000
Received: from DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4]) by DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4%6]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 09:00:05 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amd/pm: zero unused SMU argument registers
Thread-Topic: [PATCH] drm/amd/pm: zero unused SMU argument registers
Thread-Index: AQHc8Zwxo5GnkFv1v0ekDcMGOQkkI7YpYv7A
Date: Mon, 1 Jun 2026 09:00:05 +0000
Message-ID: <DM4PR12MB5038ED546A1736A4DFB4172F8E152@DM4PR12MB5038.namprd12.prod.outlook.com>
References: <20260601075632.1557596-1-kevinyang.wang@amd.com>
In-Reply-To: <20260601075632.1557596-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-01T08:46:15.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5038:EE_|SA1PR12MB9472:EE_
x-ms-office365-filtering-correlation-id: ff56cae9-71cc-49e2-d5cf-08debfbc2c5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: Dfq/FiRikw1vOXj4Q1mKpRz5YyYrPI860OlnqiTfQPxdon4kL9lYOYedcSxGDUq43SxL7zD7vixHHxM7RzRMLGF3Gz8xggKFVCnpUik9PzztYuhf/YgnO756TA9iM7Ogw/Zrw0KarmQBdVp/TY0TYKh7RJJoB3PgQLWUszPlnMKgX5AKi1lrzDlcEhXpErrhveQ8XwHnkZsg1DcQgWKFiVrn15nk0uaYdbfzqc1soeklPqjblzpMGRjc10hibkKjHifM1LUednvar9oY7mSzXPXretWGLR5t5KWqOAppC9FjymbYTCPiIU1T4YISmqw4qaIf0pKsScCYq72TI/yfvbwxA5+nrixvhJRQyS4fwBf3oWuIfh69qt9avps5oLV0C2w1JrDE0CVJH9IEwFKTGe25/DdLGqa/VQRBm/ET6V1rmKA+J8LsUlH8NZls0/sjqP/Fq6wW0sI7fW67ECZdend1ymTmvteVWpECo5PQnubavj3Ug1krY/cKQTWAghQ5oSS4wz7kF90+YfrBKx7zyS5AmHc16Ys8zoja5Yc8oH0L+lcufS+ItkMyps3Q73h9PHcDSF0TGFpKgmfK3v3PntznBtBuklO2cFuZlAcXPuxhwlamvYscCqKNYV0sOs30xyeI2d3GmrxAR66asFshOE6ueBIjIsGEWYkkH8PPA1U2QMgFC5uciPYnku9O+Alb93CzH217/p6o/XQAvCOxyrTmrr85U+5ai128U5TM0u5K8F/4eYYcfuwJDhHCJdsN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5038.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HPmxn7cEqpRp3KfsPF85cjIgplT14FcU+vGcZmYZd7jew9mC3PWwOBaxnjR/?=
 =?us-ascii?Q?/0DwjUjAdOejnekHUiiYrA/6x+6IGE213xRRFPKZkEEC9lvNrXEgz5cV0409?=
 =?us-ascii?Q?Qx6cZlSoz6ixJUbxQ8pIYCdm8M7elLiannGYNTju4raeSFv+/8lASr3l2PdA?=
 =?us-ascii?Q?uS+1zoSIE//1jyvOwDbBusp7IR+ZPYRuPP8t/5xHDAvcBLRterkK7FYeAUbg?=
 =?us-ascii?Q?XEtteuQdpWty4S2LyzGbUjZnXengH2N/TlOoddOtTs56yjyPyDl1Il1bTP5j?=
 =?us-ascii?Q?gOu0n25ZVHJmOml4vaSEDaoaWPnVwEtLU9UyWkhe3wk/3F2a0LEMsGGlK+79?=
 =?us-ascii?Q?pnKwBVKa7koaHtm7nJBXFDBurZBmD7ysXvVHyyfMUHM7+3ea3HXN+gbGOXiM?=
 =?us-ascii?Q?jBDacmj7z6tWxjoSqCywVPSDcDnhvwvzOAXJj543nukbA6MbgkBRKnKoyFL+?=
 =?us-ascii?Q?VXsQcNFqX3zb0AzE2ctQXs9xn1bP/biKBWv5noVRpoqLnYU9HdlDPU2Qbn6e?=
 =?us-ascii?Q?KPZl1RGgu7UqWQOduc04x9CKLQNc4hF6j32iKEmrTXlQgSMVAzvnusk54nDN?=
 =?us-ascii?Q?cCgHTcy+edRkhtF99KKcER3EGTUsUZgzHL7SX5M1ZtE53ARy5BLPnRLcMwq9?=
 =?us-ascii?Q?TYx983Pxcb2hYEcn5VSWPRC3pgtoCnY6rF48XIR3t0V9I5zF3F9aPsrXnjVC?=
 =?us-ascii?Q?8xTklo7gWZMpvzwxeHy1hhzfOwj424abVxTeUbbWQjE7EMGF9lshoMtE8oeN?=
 =?us-ascii?Q?IWtNbkm8/ufYwha6ASJm2F/0/Dc6marNBrNO/dpTgHmk8kMEDulIn8u1A/ib?=
 =?us-ascii?Q?4m87v+CrhBRC0SXnnwyF9Pleag+Kj+mjRS08/tmI42XhLZMINGK5SE4Wfqdw?=
 =?us-ascii?Q?1pOgUxcn+okpsnrtJuZhT2xvxlT+YGRP6bAqTFR7tW2Z+yFnsmHLRdwm44rH?=
 =?us-ascii?Q?77YDvptRWLOhrNvEL7KduxEzwXKuIEzQxirgjIlTskNLJsni/+JuEixCiGOe?=
 =?us-ascii?Q?zxMa0yCgfb/TJbx+rI6A4lKYJTo3aLyLBbieB5VbL2luw7I20gXKntq1A9iP?=
 =?us-ascii?Q?GOS7apLs4112fc1hbMr+ANyDxNzez/JV7isLmjznGjO/r+xK/oPe/vLjL9bx?=
 =?us-ascii?Q?nxoXoyNer/+FGO8zaiVGL0H/T0smLMwT1yJpNr6Jhkd/PojjWiV/YD8Oe0wa?=
 =?us-ascii?Q?P7ZoFtTC0sDTKxGMlbhjBYYQVTSQO89Jm5b9cZ7kjfcz7Md9bx/JZcd9y6gd?=
 =?us-ascii?Q?qQJ0whUTifYYI6a3mHcGGoqVXgFpCfjdlTWl1uvvCVD21PZB1vfG43UoMuPC?=
 =?us-ascii?Q?Fasc5cua+xCa4G8/2b8R4fMDYHfOEuYCfr4JaTcSRZXwTHXZVI2rlOFQVWy/?=
 =?us-ascii?Q?wYLIicQTs2QooUuO/H9454L2YEN16Rpukqtuui2sC/JI2XfAYOR6f2I8NJXg?=
 =?us-ascii?Q?KvpHPU+FYim9aoMoJpUZAilwJDvt8y79JDm+qTN/KXJ4IHmH9m8unnLYNAfw?=
 =?us-ascii?Q?jSE92iqu4GDiSXz2ghOdarTCdwdoO8FgC7bazZIgqbO1hW4f01HOHAdlLsfX?=
 =?us-ascii?Q?wfCxwjb+FceAsVJAJVh6M4bjHhMfCtkswwBUo1cwCvmkadNfKJmESAWM4OUv?=
 =?us-ascii?Q?ZS3kOjZZu6gKjyoPcKu6dc9VqswQcphzIiCoq/0v76OwenP2igo2jfnaPw8R?=
 =?us-ascii?Q?d+clDS1LYKHusXv/jfAy0HbjCeKDaKtKit39rMZvH/Y90Nip?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5038.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff56cae9-71cc-49e2-d5cf-08debfbc2c5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 09:00:05.2082 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YbR1FjghsBGsF3VnUr4KLRquXzZebX1+iAq70vAxxUjHEWNRa3wL150JTf9UQgVauPWgoYnp/pOA2YZCiNfP+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9472
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

AMD General

With minor nit below

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Monday, June 1, 2026 1:27 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Kamal, Asad <Asad.Ka=
mal@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
Subject: [PATCH] drm/amd/pm: zero unused SMU argument registers

SMU messages may use fewer arguments than the available argument registers,=
 the previous code only wrote used registers and left the rest unchanged, s=
o stale values from a prior message could persist.

Write all argument registers for each message and zero the unused tail to k=
eep command arguments deterministic and avoid unintended carry-over.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index 546e64e3ba9c..85e7a8b347f7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -313,11 +313,15 @@ static void __smu_msg_v1_send(struct smu_msg_ctl *ctl=
, u16 index,  {
        struct amdgpu_device *adev =3D ctl->smu->adev;
        struct smu_msg_config *cfg =3D &ctl->config;
+       u32 arg;
        int i;

        WREG32(cfg->resp_reg, 0);
-       for (i =3D 0; i < args->num_args; i++)
-               WREG32(cfg->arg_regs[i], args->args[i]);
+       for (i =3D 0; i < ctl->config.num_arg_regs; i++) {
AK: Can directly use cfg as already defined as local variable
+               /* NOTE: Clear unused argument registers to avoid stale val=
ues. */
+               arg =3D i < args->num_args ? args->args[i] : 0;
+               WREG32(cfg->arg_regs[i], arg);
+       }
        WREG32(cfg->msg_reg, index);
 }

--
2.47.3

