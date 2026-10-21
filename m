Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B39F606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 00:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xXVOSlp5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02FEB10F841;
	Wed, 21 Oct 2026 00:22:03 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013000.outbound.protection.outlook.com
 [40.93.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71DA410F841
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 00:21:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYgdMAuTGHwUDn1OYlkDWXxiFMW4DSWnjaXoclwp0zh95ldeVcj4k8+SOrjdobrj0Xu1e+ncweZMlsITIvFqFfDVReiFRpnNLmsDAXGevUi1Cde/CU/RFN7jlVYWoSsvvs7/52ZnuFBMHobdMbJylHgWIiEwxpGBlRyc7gVwskfqLD8qgL8oI83VsXdO5wc8chqSGMA/geux0pyWyLjGFm7r0FdvZciYq15DGUW7MmLc+j2Yi1439Tvz45C8cfDn7GbgHa8GUwfEYQesxI6R6bmHAnZFZc1ukqa829HRnc1/XT5LGggjDBj3iVYJwodSzSI7Hob11CF/++C8jGXEWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yyo/5XLSaW+oDx2C6LGqTX7k06VOym1BaHmRUYivpQ=;
 b=xpAp70SkmG5oBZeHrw/hei9FZdeRmacdTrO+AzUvDHUa/N4HAyOGoACoh0Vts5S69v6ifxw1Q5+RJtK7UrnI7oE2btKrqrY0+Tp5fxGG6q3dw38Et2Flu4EcETTwoY4MGT+qbCjAJOMucm1fFjbFgv02iB1HCHrxzLLnvNYoGn2xmTqs9biYYvC8MvDanaV2VWFrQXKD4ZhznIKEw+7dGVL0l63eYWQtI2fJ/qJzMjWBTBzUC33kvlCdwSuAwZAsePtbaI1WT7ej1sT2wtT43EHlTSO8S2Gvy6FYj5iHLHBTvPeadZ7pyJicxGXx0I2dHOLPc/MDvr6yFKRAZHv1ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yyo/5XLSaW+oDx2C6LGqTX7k06VOym1BaHmRUYivpQ=;
 b=xXVOSlp5aYXzAb61BCUcBwwK9RxNzNh5kjXteGIGoQwnWYREC5JkIvSleef9IJTLmY/CWfDGfY069Qj0YS+VoXWSuGGDs2+ZNHOxmc+TJVgFRKUofuh6sDLG60ezG+qdV4RlP/9dyuhfZmdlHC9LvGy0bdswj7yhM0Sw+YCr2vo=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by LV8PR12MB9449.namprd12.prod.outlook.com (2603:10b6:408:204::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 00:21:53 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 00:21:53 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Gill, Harkirat (Harry)" <Harkirat.Gill@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: re-enable GFXOFF for compute on GFX12
Thread-Topic: [PATCH] drm/amdgpu: re-enable GFXOFF for compute on GFX12
Thread-Index: AQHdYKyxs3UfJjbm+0isywVDAnttCbcHItpA
Date: Wed, 21 Oct 2026 00:21:53 +0000
Message-ID: <MW4PR12MB68038237F5CA4C9B1DC0DCA28E662@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20261020160316.2411569-1-harkirat.gill@amd.com>
In-Reply-To: <20261020160316.2411569-1-harkirat.gill@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-21T00:21:22.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|LV8PR12MB9449:EE_
x-ms-office365-filtering-correlation-id: ae67cc6e-d6fd-4c14-c146-08df2f094ed6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10067099003|18002099003|22082099003|38070700021|261009223027099003|11063799006|56012099006;
x-microsoft-antispam-message-info: iWjS3vLSJhvrvp/ByOGOVMl7wh6xiJofkBuJW4MOn+Kgm+8fdaWtw/5JwL4AbeSd+mX48RQ4FI67BhNjl1yOvsF+K0DCPKK/U6OnkNIiL6CUBc7/CZGyxNSW0eniiRq/V2EVL/VGpPtl87IwPMYNS24aYtTEhN1xuqwdF00s8uxYlliYzHJjHgKRRuVGCSEiw/3R/GopLovKUlUMXZoV7ZntNITAVlEbvZm4jm53nllRhwEBsGkdYk55SUjcO/LlDWU1PS/1FfP0xBp/1vZwtQTLld1UleVpgEbRzzJsPpln9yZIxuMjqX8XouL9fCiWMVhQZ/KVXzdyxzDBT/FaMNRr9McPKXsurnnInXBom7gNwHGwxS6RpAPkkJN6KoK630MMYaCKddL7zG72QpKp/bWApfbtd2gHdGf3t/na69ukXMiqZ913QrGbpI+3LDBz6dKc464IZEDxhGPC4BF6U0rhHQqgw7jQ/FDB6NIav1TOHNDDktYrmATKKmrLUTgFb5P5Hwy3Cl4uhqG7+/fFIIvBaBidSH2/MsZpVM1GQiN5ldJxzuW3WhQ+rQfE93dYisc58StOzMq4Is9k9QnpkvyzetbEC4pL1br9WyhSROwM0iClmoFomDx62DrenkWfyAwQDlQphyH18YF9iRysEtWtZc2MS5Sd4j1ID04gtMn1NP0znh6AAD1V55oCd8RMlZ/v/l0JrxeUAQW+v+ZvOrNsJi6BKjnt1XnvloTX8tU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(18002099003)(22082099003)(38070700021)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ySIFit6VPiau4h1qVBg4z+3wVAcgtYJFy5TFxltPP2FOLxZLgX0LCnbGWgHW?=
 =?us-ascii?Q?Zs0YNByGvGAl020UQRW6/3vQaR4zmG3uUUAZn6ozMr6Qg2AfTu9AO5dFO9HQ?=
 =?us-ascii?Q?XU94ck98RT1HUHqNc99E9ui7bmprsy0d/ACqHhNKA1JNEL3VgzFY7kvZAlVZ?=
 =?us-ascii?Q?m704oKCNCIIaaO8tnF89SrQx9Wl5bXC4ZRy48D//HWZABdSQ0jcdPI7+c7Kw?=
 =?us-ascii?Q?WJX/97SmdskR3qaBPVEQhFYTf7SsAuVQ2lKsT/3UWbbGEMlVTzzz1pLjFpXC?=
 =?us-ascii?Q?Bh7sTHg3ATeDAn+BoCTG49/yQwM7mQS9ojbQPHUgZdSyuNaylJbkF6k1VWOH?=
 =?us-ascii?Q?Bx0OS+UFbS8fO3bhk9VGhTB4aPXMiH6D+1k5fTMBqyBYIa39XDQ/s9KAqv1r?=
 =?us-ascii?Q?zcxn256c8pUHaNsc1UQtK7HQiQFUW1r937jc5zJazMKCLj7dIR7DfPsF6zb6?=
 =?us-ascii?Q?WSvixNxnBPH/2XjJjC0FS5auR/wtONJt7f0p6X42qfMufIp+2MbBc8mpFgSS?=
 =?us-ascii?Q?50K9+Yp1r3vC2OWU1huqUxgfEYT3v7dj1znvoCymlbA0v/pvIJpo16yxi5xB?=
 =?us-ascii?Q?K7zzFO62q02MAUUuFC+syUuN1BdJH3rEPT04cb1wxFN1MPGK+MmxO4K279is?=
 =?us-ascii?Q?NuneCgDOEdHWhpqPvZuxUrCXgX781lHx6BLJJFrJjlrg8SEmj67tqipcHByw?=
 =?us-ascii?Q?lmeF+7RaJm5+798aZTx2Os98GLDoRtZzs0yRiQFj5LAKpCNjC8mZgKvnFQYN?=
 =?us-ascii?Q?XROrAB0U5otWUWEBpxlu5eLhS2B1OtDYElkJWpWVx8gc62e1Wp/1HnJt2a0m?=
 =?us-ascii?Q?2xfAvieSgk3bO7ll02EWDY8TMUUxEkTBV23Ri6TQoH4JKixQjab7hX7GI6og?=
 =?us-ascii?Q?z9E4/UrwX+BWqJyyFJiAPHeNmCAc7Qllkb/tRX+ZaZlLlCByXale0d889f/I?=
 =?us-ascii?Q?iOvbSCtc9EVs9q1tRGLyUDpPQyT0xOmT1MnxHSQUqhi5TZQop/ZxKVFfkjqK?=
 =?us-ascii?Q?Jh7DZxOcad7FlKUx4pKbEqWpMh2V0CztWnLqYkDcLxGdrI9LWDoFVl/S8lvf?=
 =?us-ascii?Q?/hpDlwmTS/byZ6wTdySjIStR78FMd+NNRCwvXdhBslPFcRurwJ1NFeeoVFa8?=
 =?us-ascii?Q?xSNLvHuiIgNf6bOfYGBeks7iKmmNKsGLFEq9AegK3YQ8sfBLMISJAAk95lo3?=
 =?us-ascii?Q?p+174mYlp/3HTunuwFY6AfM1iyYTvEQ0y7D0l32CEDWsLZJS6QsLDfPOr01Y?=
 =?us-ascii?Q?3fgoHqRBZU8o3M4CC7dh32rtppMbPNOfjau1meQr/tvMXSskyn6Z09Z6OowT?=
 =?us-ascii?Q?bNiH5Wn41Dre1uH9x1LUfd2K076iKsnHDlNtzY9HRp+h2kkCSYLyWKxU6ce+?=
 =?us-ascii?Q?yTj+uWM88/UlPKX+fGE6IwJq9mXkHSH0oMYskzPp67FoaCMXjNtGVHveISCP?=
 =?us-ascii?Q?LY2NWHKfoYXqpYl8epqu15uul9jwzbTuReueTLw4RAEPJIJZT5uVQMxWh7rf?=
 =?us-ascii?Q?u+hoqjdfuF6to+IIQfsgJ2I9Q3ngil2P5qPRfURkdpnMtYJ06ETbzpY47DSb?=
 =?us-ascii?Q?lo/MBLDWFZ08DM9GL95aNnHaN/YA/0NXXWqVzcXJKyU78lgkQcEW8WuAqCpl?=
 =?us-ascii?Q?CXreM1U8TEusKt2joP6T+3XasQuXp5xZhL0HYwFmS+10KlSLm+Yk5lOFv1ha?=
 =?us-ascii?Q?Y+/QNbi+Bi28wCPuC7bFfo6GA7xvzlIr1nIzVGYhCdhUKuPa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae67cc6e-d6fd-4c14-c146-08df2f094ed6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 00:21:53.3735 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: llgU18WlKRJ9cWM4bOmmisPXsQb8yGsXdLuybZJBXg0HQmsRBXyg8lF1PoDE+1VW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9449
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Gill, Harkirat (Harry) <Harkirat.Gill@amd.com>
Sent: Wednesday, October 21, 2026 12:03 AM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Gill, Harkirat (Harry) <Harkirat.=
Gill@amd.com>
Subject: [PATCH] drm/amdgpu: re-enable GFXOFF for compute on GFX12

Commit 2affe2bbc997 ("drm/amdgpu: disable gfxoff with the compute workload =
on gfx12") disabled GFXOFF whenever a user-mode compute queue exists, as a =
workaround for an OpenCL test failure. The MES firmware issue behind that f=
ailure has since been addressed, so the workaround is no longer required.

Without this change, idle inference servers that hold a context for hours n=
ever let the graphics block power down, costing roughly 3-4% reported GPU a=
ctivity and ~3 W per GPU at idle.

Measured on gfx1200 with an idle HIP process holding one stream and two res=
ident KFD queues:

  before:  VDDGFX 695 mV, GPU load 2%, ~9-10 W
  after:   VDDGFX  35 mV, GPU load 0%, ~8 W (idle baseline)

The resident queue count is unchanged in both cases; only GFXOFF availabili=
ty differs. The ocltst runtime suite (40 tests) passes with and without thi=
s change.

Fixes: 2affe2bbc997 ("drm/amdgpu: disable gfxoff with the compute workload =
on gfx12")
Signed-off-by: Harkirat Gill <harkirat.gill@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index 121282dd30c1..34573cef3393 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -746,9 +746,8 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,=
  void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle=
)  {
        enum amd_powergating_state state =3D idle ? AMD_PG_STATE_GATE : AMD=
_PG_STATE_UNGATE;
-       if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) =3D=3D 11 =
&&
-           ((adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK) <=3D 64)) ||
-               (IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) =3D=3D=
 12)) {
+       if (IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) =3D=3D 11 &=
&
+           ((adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK) <=3D 64)) {
                pr_debug("GFXOFF is %s\n", idle ? "enabled" : "disabled");
                amdgpu_gfx_off_ctrl(adev, idle);
        } else if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) =3D=
=3D 9) &&
--
2.43.0

