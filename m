Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5D8CA1016
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 03:28:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5F8E10E3C5;
	Tue,  9 Sep 2025 03:28:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qVTM0y09";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62DAD10E3C5
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 03:28:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sawbxIG0sORSkMPW7jlTMPlz724bNhndLNT7guqfQBWWS2FkDxZELjE29wYTGE49f1ZQsUhxwZ+rAkK2mV1hDPUbRwF7DhGuEQv3SicTEULcwVYTGW8cY87WIiB0LxxXSNm5mRBXUc875wE/eFEYCRHnAy2QpZL5RAiWcOOsXBMM878kHBRZ4zyZKMI6iVVagmoOdZdovbc8Oe0VLrJ1/3x2m6B36d6qulVp8BntJ14I5jf8tzFg/X7cGchhw1wMEQ+BJj+XG/3izpZvkDuXAwQGRUZA4iSSmDks7QCXSJqyQahxI4H6wba10A/p55PGCJHWTzSKoWwR66WOR+t4tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egAYggg7BJozhCt2hVb6wqCtNa0O009KC26i663SnCs=;
 b=kg7jKoGxS023soL0tVgNkjnFZvpGt9ZdjH7dkl63+53tqW0tK4semSBs0IvpA/UogZv6DRATZr7vWMkLaRmkdBoKE0BdPYXRLD3y+LFOoehLkVktXqdAwch070mE9OP+QhVEuXusER62kcadJeyJgBue1O+351ys3D4pDtYgGw96DDK8yDGk0z7q5OWCGWzaFZxkmBndkqFKLNvUzLzr1DofR8Pmn3X9fl6/KOVsuX6FxHZapjm8RwxPjWi+O5MHQwpNE0avqFE49hTXNX+RA2LhmGzBd0Oj+PYsOb4jae5FzRueTRX3M66IbCm4mAftUGhMLdqednU0Dxu5FsNZCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egAYggg7BJozhCt2hVb6wqCtNa0O009KC26i663SnCs=;
 b=qVTM0y09NN+1W3006cloo3VVV8zdHzobKYJJ2Q0sG0qY7WJTgd7qOR4eiBtWcGDzkQIuOIc2Mv55yOt2yyOiFAH40e9Mpkc53TjTGuOmvAcAR2Uqxf75671xYH3BCHM98QpnanWKcH+5O2G+k3bUErH/htMNNCs1grmsdQ/ZjF8=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 CY8PR12MB7731.namprd12.prod.outlook.com (2603:10b6:930:86::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Tue, 9 Sep 2025 03:28:27 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 03:28:27 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: make smu_set_temp_funcs() smu specific for
 smu v13.0.6
Thread-Topic: [PATCH] drm/amd/pm: make smu_set_temp_funcs() smu specific for
 smu v13.0.6
Thread-Index: AQHcITByy05PVCxawU2/u5ptSk90QrSKMSNQ
Date: Tue, 9 Sep 2025 03:28:26 +0000
Message-ID: <DS7PR12MB6071C37F9843DAE138D33C878E0FA@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250909022110.2695284-1-kevinyang.wang@amd.com>
In-Reply-To: <20250909022110.2695284-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-09T03:28:06.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|CY8PR12MB7731:EE_
x-ms-office365-filtering-correlation-id: d40ae5a8-5b26-4a27-c317-08ddef50f097
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?eNlvLQtHO5HzH1ltq77N6/bmXaOStrZ0DlM+rGZGx+JtbBOujHXvUR8YANzY?=
 =?us-ascii?Q?Z/5P0bI51+f30fwinUr9kzmBVMXyLoQ1OesCPngZ4I8lQY1A/mFQ1qmTbqAR?=
 =?us-ascii?Q?JpMpiC73Yf1oYhioI3GOziVzhK817Z1RHDNs8gOJ8wenY400nyUbssoHNScY?=
 =?us-ascii?Q?L7ZVJTPDujtOdyvqOP5FxyiIAwR5gfTKs3EMG7tJ3fPJSFOHco4qzgbLa5r5?=
 =?us-ascii?Q?vkGQmD4iI52kJXdwIHhhVd2cwZBO6hrpGD3snNbXmjUCzbHy/TZpbyospOGA?=
 =?us-ascii?Q?KeKYGx9bnEW5MGhhJiCMQT0Sr9P8PyefIUbH9VDxOzglYE6uty+Bpp9+HHyI?=
 =?us-ascii?Q?aXm3UkgiVx30fr3jP+DgZoXdSkc5YvvCnukJSeSEYCyMpTgcgblX1nF0EASv?=
 =?us-ascii?Q?Z58BHWo/cLdXfRp5mwGFJnZIiytwr4GcMRCj89dvPwq5bXL2CMIFTRknRTpk?=
 =?us-ascii?Q?ZgO1ruisQay8Ip1AE9LMFDEOSCBo7QGhT6zPgVy4+2LpJyROtJFirNSqGtX5?=
 =?us-ascii?Q?nuAKllZwskw9TU2ZvWKo6JXDlOmJhAfTV89+cjjJb1pIl7A7fY/tQAA4dfDc?=
 =?us-ascii?Q?hZL+nL4w9ruWrJLgoZfW+96gjCSg9Cpo1kvsqbJ/EHu5li1Ul8dKiSOrBZp3?=
 =?us-ascii?Q?jdASX/AVYOQqKF22nYlpR2U/M5JMXv7tzNgcc/8GkLKArewkhG6LCXOcD6t1?=
 =?us-ascii?Q?XrBApxxlFmY96kWkxZZP6acJBqbaNFxQsGjRgC5+VX1ceE4sW2FU/rWiptrQ?=
 =?us-ascii?Q?sfZ0zkUWyxhzcaiGPUM1KI0DSyHz9i9BF2EM2IJZ+J3h6MPL8J1Dt5l4SO2u?=
 =?us-ascii?Q?Ta2yd6pNYHN8YPdcFloZisbwJE9jJGSjgoJOgDUTRNRinRqGQOq1GyPtQStK?=
 =?us-ascii?Q?USAhYX2LxRnk9chWxyY/WZlRSe4hR0Rpd9xxvzQV8LeiKGeMKUM0B5+qrwVQ?=
 =?us-ascii?Q?2UpCXdNLNCD5QS28OfV1eWI2mbK99rB8zAryKC7QaqDrspl57ezHkDtGTQB0?=
 =?us-ascii?Q?2hhQEC3DbNJy5+WNRYNuARCoGJSyhjKl2NvJtTb8OeJsihrZKQpVDhttqh3A?=
 =?us-ascii?Q?dMzmX7XN/RuMqDHooA5YOUod1NlIhD2fAlQwQWLhlocwOz65QzLlcnuGOEFn?=
 =?us-ascii?Q?w5QsjdufwYnXjLZjhu4G/D5Dc0NmIDLGQETDreGu/TxYlmDlbnBmYhjm/E92?=
 =?us-ascii?Q?DMiDmZbu091Vd5AeVEHvjnRTYQqZQnt4Z6ZnSSp8FVRkZmU96DbUyI/dGYdY?=
 =?us-ascii?Q?h7somhAsMTjRqNMk3Q1Gnw6m/rWitLqtnxAzJkpxm0mIOH/cEumjjuuQh4zm?=
 =?us-ascii?Q?S1EFSH9Qr12nJkwvKjbDwodCGs5NN2gLZqwoqjuG+CclIay50I8TaDbI9LoN?=
 =?us-ascii?Q?UL9OtmLzphLA82odnrh78rT1MJrmdN0bNKJ1ECl6Grl9vMXTwXTsUXXtN18q?=
 =?us-ascii?Q?gupuGTkoWbKUdS8fPE11tuYSnq2Rh8JtDI1SRLkkEsYjsvaoST6hkTPJnzJu?=
 =?us-ascii?Q?sjamoieBz4ZZrpc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q6RZHapMsuKcd7rGXtnV1s73Yzsj++IL/6fKeZWpAIhAafy5mlXkYrqlegO7?=
 =?us-ascii?Q?34DCO51x0rsdxplobb8Zv7Z8qfkDsH8kbZQf+I/F++w/i7dw830kEplcsWgJ?=
 =?us-ascii?Q?ZvR8dbTjDmtuhwGAQrxmCny5zWhjgm0qtlBE6fVmDIaMOgOnDpFn9Co9wU4y?=
 =?us-ascii?Q?kRbwHoZG1Tpv+9XB04g+3vzIR2m9uJjHTrrHvqLDgQpowCV8KBYfdmCarokU?=
 =?us-ascii?Q?q1Q45s1qP7srcEs3kpxvfS4Hy0K2xHOpfPKGaPaKPlhWlwjv4ABtdOFhPsWk?=
 =?us-ascii?Q?Pgt64IFBeA8lF5Ks7F884L1B021+4J82VoHiaMFRABuj4xrF2auO/cO4ro9I?=
 =?us-ascii?Q?EoHwvlEB6q7dHZe0MGvbbfLp64NnZlCveC74VPGWXiUvwFfpZQ+Fz/J0pl5g?=
 =?us-ascii?Q?H9fLLfivOATKbWR51Bsk5ROL5j3F+kxzZmPwQPbnN4tM9Ividx5/mHkUhrdl?=
 =?us-ascii?Q?dZxUOb5Tsd7AUTXCdyQoDz3y+deY/JwiV4uQo8OgmGc6O5Je4ptTawMWJaNs?=
 =?us-ascii?Q?6kuhCUY+bbzqpEic40/R6aADpm/wyUjmS1KN0Iy+g4comGLd8f9Fl3uzgB+Q?=
 =?us-ascii?Q?3az3q6+nMyTRW+CHPBYTjdou+uP6r2eHCQt7rX51fVZs/UgDhDlYn8fdkwYR?=
 =?us-ascii?Q?sJ34H14Ak6tuCXJLY4iI4LfHCxG5Ia6JijcHUK4evwj22WaLJx+qYxwpTjD9?=
 =?us-ascii?Q?nPGF7Crwf1DFkXD75QH0vVM/LDLwujeJBKZYGIKwawBJcljSALBULXkqdLvp?=
 =?us-ascii?Q?eILx3bw6b/DbtBI24+ClmdcseyTqn7DlyXtSRwym/UbX0hFhPqfyE20jV0xa?=
 =?us-ascii?Q?99OfgQQ+JkKOOTiehU2kktkLKKx1fkU1Pk8LkhjMHSz79u30lMGywBeqVXk8?=
 =?us-ascii?Q?AAwv+oiAhb1TRSmPzZTnTgdAMWjDPAmgKnJ7Zmy+5A0osIQgp90XtNv0ZKCi?=
 =?us-ascii?Q?4KVHvzpoT8ssV5HRrdY6x47R2loBwrrvT0kHSHkMHLlqlr3sNvqtst+N0a+R?=
 =?us-ascii?Q?ALjVE5gSVu2oKo+/6oEMfbGco7NSCnaZjlmpoc4C0CfXmWLu3QJZqBbOx7AX?=
 =?us-ascii?Q?iyxHUE8B0USxa0RUnfZCLobLNZ08xk3SfSyQzvRpSQH5pUa5gIm6lHwjTX7j?=
 =?us-ascii?Q?S/NHHmt+ZQnRa4dPrsQ341Z0LW5B60aRq0mhFgE/60boNSoGchYtbFDPgjah?=
 =?us-ascii?Q?tF7RSGiYTMZ/CkUFz5/hvtCeQsQ3H1w4iyiTe8glq/s7s5k5zqVTSWoafD+j?=
 =?us-ascii?Q?xLtxPeddP4Ymi362+lK/iCZj0HtcVrJvJiS/siky6PFpioBMsDNvXK/UDAVC?=
 =?us-ascii?Q?8Hpz4Wsa8++DI3NXxd3w33OiiUdAs8NmQOuI6n89zrymFtU8fhpJgXwyaNC9?=
 =?us-ascii?Q?35gm5xJIGrcbU09+z143zly4eNdiVHwYS7ZgJItnEFSKm2rWzR5Nuii1TXWz?=
 =?us-ascii?Q?YxWZLU+zq6aIdj67lTJe5kk/ijTSHcBL6ml/eyjTDlaKDEaKF46BvCD2yD0V?=
 =?us-ascii?Q?Bc4x8RpDuEmRuEue5myzVyWT7Kx2Jm339PGuSgpVhR1voG3JnGIrtE5UQhRv?=
 =?us-ascii?Q?muRU43dCBFT31kEeR8o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d40ae5a8-5b26-4a27-c317-08ddef50f097
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 03:28:26.8762 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lrtY+yKxU2nlT1hyz+d37YgvZtsISBeKyj2vFGBf6Of8Kn2JiFaBweEv67ntWu4ZAZjBLj+pO61m1/zlzcZyZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7731
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Tuesday, September 9, 2025 7:51 AM
To: amd-gfx@lists.freedesktop.org
Cc: Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: make smu_set_temp_funcs() smu specific for smu=
 v13.0.6

move smu_set_temp_funcs() into smu_v13.0.6 ppt.c file to keep same code lay=
er in amdgpu_smu.c. (only set_ppt func in amdgpu_smu.c)

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            |  1 -
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 12 +++++++-----  dr=
ivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h |  1 -
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index ae3f7f00c38f..b140f6fc50f6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -766,7 +766,6 @@ static int smu_set_funcs(struct amdgpu_device *adev)
        case IP_VERSION(13, 0, 14):
        case IP_VERSION(13, 0, 12):
                smu_v13_0_6_set_ppt_funcs(smu);
-               smu_v13_0_6_set_temp_funcs(smu);
                /* Enable pp_od_clk_voltage node */
                smu->od_enabled =3D true;
                break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 1e506781a470..e028046b027f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3850,6 +3850,12 @@ static const struct aca_smu_funcs smu_v13_0_6_aca_sm=
u_funcs =3D {
        .parse_error_code =3D aca_smu_parse_error_code,  };

+static void smu_v13_0_6_set_temp_funcs(struct smu_context *smu) {
+       smu->smu_temp.temp_funcs =3D (amdgpu_ip_version(smu->adev, MP1_HWIP=
, 0)
+                       =3D=3D IP_VERSION(13, 0, 12)) ? &smu_v13_0_12_temp_=
funcs : NULL; }
+
 static const struct pptable_funcs smu_v13_0_6_ppt_funcs =3D {
        /* init dpm */
        .get_allowed_feature_mask =3D smu_v13_0_6_get_allowed_feature_mask,
@@ -3921,12 +3927,8 @@ void smu_v13_0_6_set_ppt_funcs(struct smu_context *s=
mu)
        smu->smc_driver_if_version =3D SMU13_0_6_DRIVER_IF_VERSION;
        smu->smc_fw_caps |=3D SMU_FW_CAP_RAS_PRI;
        smu_v13_0_set_smu_mailbox_registers(smu);
+       smu_v13_0_6_set_temp_funcs(smu);
        amdgpu_mca_smu_init_funcs(smu->adev, &smu_v13_0_6_mca_smu_funcs);
        amdgpu_aca_set_smu_funcs(smu->adev, &smu_v13_0_6_aca_smu_funcs);  }

-void smu_v13_0_6_set_temp_funcs(struct smu_context *smu) -{
-       smu->smu_temp.temp_funcs =3D (amdgpu_ip_version(smu->adev, MP1_HWIP=
, 0)
-                       =3D=3D IP_VERSION(13, 0, 12)) ? &smu_v13_0_12_temp_=
funcs : NULL;
-}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index aae9a546a67e..4652fcd5e068 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -74,7 +74,6 @@ enum smu_v13_0_6_caps {  };

 extern void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu); -extern vo=
id smu_v13_0_6_set_temp_funcs(struct smu_context *smu);  bool smu_v13_0_6_c=
ap_supported(struct smu_context *smu, enum smu_v13_0_6_caps cap);  int smu_=
v13_0_6_get_static_metrics_table(struct smu_context *smu);  int smu_v13_0_6=
_get_metrics_table(struct smu_context *smu, void *metrics_table,
--
2.34.1

