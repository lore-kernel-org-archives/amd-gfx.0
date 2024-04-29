Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784E0C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 02:44:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9285310F25E;
	Mon, 29 Apr 2024 02:44:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CReAa36B";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC97F10F25E
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 02:44:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gquWUIMzHr8yp4kV9Yd/SriAfsPiidViBNYZx3Weovhp7cIIMtK90InNtaeHNucBSjvq2AWkpF14EhutEYp2T3M4eklb8vRfY4483lDpyUjQdXf35m+QozvuJqN3XOszg8rneQwxIhMD8GdO6cTT+hQ9botX15CqG3+ycHNeFsh6RHqo49thiELDSVLcDfM7IUKY5o2ZOkjMI5mNlPyoYsNc7zcmnrOUrAvBDcT78q0QqyDxwpWkeCPj5MfnXlIRzHXfA2gAKfTx8JKHzIe/Kt8yapjNfKQ8gwtizI9GDn54mX76VI/ADYWdbI/oRuLdgqF/ICQsT8/v5mgOZzfUeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3NBoeHCIx8zLShH3ZODjBv1WQPQT4A2KLSs4PpQVm4=;
 b=YmBb6ZHMP7HSbWiCtHcvt6O2VbSTdV8y5+rJOdRgj3fC1I3oqsBDx8WrFDtkXZ4oDrFIJVAcd6CrkIGswU7mnXDhY6OpBn+Z0GvLkSJh9cXcBsGflUj8yw81zXXqU43auZw0egE5DQmJyA48xZusqvnMYjoy+pospxtMICCOLgTiZ1pKF5k6ZXFCuvXjcGuuzgSKscZQpVPuFcUmfbfSAHuFAX1aNoV0RNDFm7SoxbsVImkDr7lFS8Dfii8kMpwYuuKKCsnMc9IuwzgCjrXzGc5qvarjN2z6ZrKZL6AuN5OM1pS7D7V8+5QDpMkKZ+Nm+q1aiUT66RYxhJIwo6jVdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3NBoeHCIx8zLShH3ZODjBv1WQPQT4A2KLSs4PpQVm4=;
 b=CReAa36B894S4m9y80x2coZEuuznbzS547gH3Iw6rAyfSFfdndRqDW4FfzF7XCzW59vtIJby+DGncEyhLfdRgpm/lvcImKadKdAqAaiaxah9TVeCcB8wfc5DkJVmwKNs7vbSv60j8v5bK4clao+6l3blDrXbOZPdjK7S7tmzZI0=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SJ0PR12MB8114.namprd12.prod.outlook.com (2603:10b6:a03:4e8::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 02:44:36 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 02:44:36 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu/pm: Fix uninitialized variable warning
Thread-Topic: [PATCH 2/2] drm/amdgpu/pm: Fix uninitialized variable warning
Thread-Index: AQHamVIkVbroNlZbU0ymhztd0gLDRrF+i5eg
Date: Mon, 29 Apr 2024 02:44:36 +0000
Message-ID: <PH7PR12MB5997BDCF6D04D34BF5BEBB0C821B2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240428095435.126980-1-Jun.Ma2@amd.com>
 <20240428095435.126980-2-Jun.Ma2@amd.com>
In-Reply-To: <20240428095435.126980-2-Jun.Ma2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=759fc00c-5351-43a5-93b5-2e1cb2c5ec35;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-29T02:44:11Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SJ0PR12MB8114:EE_
x-ms-office365-filtering-correlation-id: 794d31e6-e447-4d1f-6da7-08dc67f64f27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?LBH6OmFZQIg4wwjJ/OmP+VYunuDuEB0g08HKtpVY9GFBsGX2TMliGSzlSNQh?=
 =?us-ascii?Q?q/Z713WHw0ALiytXzSGFKf1Acp6Y/btxBgY3KJ4zDFIlCOpe1EI0ZfQSlT+E?=
 =?us-ascii?Q?NK23K4wY0XjFe+5QCGfhreToqvz6JyAT/25QZEo7ubpZP9AETZZ0i3v60jyx?=
 =?us-ascii?Q?ZA6bovf2pSb6gTS2ooIFlQkPH7G2Ug0SjidhwH2KCJKKil9SHdby4rW9f3XQ?=
 =?us-ascii?Q?i7H5BI3Szd2D1zLn53ynqrZH5Vvbr1lmQ+OC1uuBszp/WhYvWaNeDIVij8uX?=
 =?us-ascii?Q?Hiu1YFFOwzwnt/EVHeSBqqHFVWDRjXZVGdjKlwUM4pg7ApUR/7Q5dOucJxcX?=
 =?us-ascii?Q?6vDyv0BRmyQ/vvFp8KWDOgcozpIL6qfm8jkZFT0mTrpernuz7bjrBLoosRO5?=
 =?us-ascii?Q?BcFKhkeULauYPL2EiAGmkjJ3PrpP4I830P+zkOKVo7XNiS8n/72W/f1IMAVP?=
 =?us-ascii?Q?G7kzAbYAnV2vnFE/S6vCB4/nFTEayA6P7iGEBWRFxeilqB/AGxmU+3l/eKBL?=
 =?us-ascii?Q?Yj7fEr5s/Kd0Rq7UlLdqRhDDPXYTKHQqMgF3Gr0KvNoxUJb0RCLdaXjiSlzl?=
 =?us-ascii?Q?P/HoojOy7uObYb+ea1VQ08F39zSbwexCUDVddQoTPcusrpY8aoAXsaZAt6QO?=
 =?us-ascii?Q?8lGaWdnopJO62EvR4WPXuItR0WZ2DMql9woramyb1hcwzFKPgWCmPzdn6Ed9?=
 =?us-ascii?Q?LTzvtTaewaJWUCgOarEUS6TRwWcNYFEjEg88VRrZnXz86Li25O4GKWXP56H1?=
 =?us-ascii?Q?rB8KdeMDkFzGOz1WhNwgNkWRsoEiDhQByVAlyATE24GMVI7/drR6hmO54JYd?=
 =?us-ascii?Q?JLnO812r/QJTSMElQVzfSRthjg+1qjhdzMUZi9Q1nk0Ir3eOXnS3wUKjTPyZ?=
 =?us-ascii?Q?3q5I7gAFDK35VaMMQsnajKJR6jko9oGxhemPPsTsfZIfDsVOa72HZynlA4a+?=
 =?us-ascii?Q?V0iWvhz9frjfVPDWzC5thagzVQ+TiWqJ+pkgvbj47Dc9AQqiECVjHpVuQGqM?=
 =?us-ascii?Q?NKN7eXMVAo1trM9JEyWmTRv6n9I4gs04HWe3t1mqYELpMR9eiZB0bbX7R5ky?=
 =?us-ascii?Q?bCvfUd+MMXKQGJwjt3U0qWGVPW+WX1pHB5/BKrBLgS5mP4tzSbjoKX0dW+7W?=
 =?us-ascii?Q?xD9MEzx4zHDuPr4s1uRVwO2/cGzwwuinkOTdG8epCUtxoztv/1nJ4iznHlfC?=
 =?us-ascii?Q?aGN9uP3mGlykmypsjcU/EVHzHpVASZEMSrxJZ5GoF6JSDVesYJvMOyr3lH8v?=
 =?us-ascii?Q?hBBeJL30oP8vZCjn+cTzM3wgjMQ1E9BgY06asMp7QIwpoC5gMKCzPg3orqx8?=
 =?us-ascii?Q?VPBFz+j2wlsW4oUc2Hy2iw8ExLDdzM+BoxSmxv92i+4McQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q6cYTr7jzce/VYsNx49aCTi20so8gjFJJUGCaimxW0ieTo0kohDWjXAQEvjM?=
 =?us-ascii?Q?ea04Sqk9gu5ElfGltUF/NfoQE9z5M7VEN6R+ZiPuvwFYaG5f9Awz19nwFGxc?=
 =?us-ascii?Q?5unhm7pSaAXklZO4uAoWBO7AU5m+7oD6i+3gLfJUOi3DNNh0wCgkrvK2BO6+?=
 =?us-ascii?Q?Q+RcPA5wKrIp6UaVHKh53vDWZxW7R8mAaQFfLWLSPaMVvGYqHLi9MP2J8Zy7?=
 =?us-ascii?Q?iFNKtwI9eK9iEMxu5v0JJpBDX4RdmMH1fMVnvH7zRcRnch4tGYRH30r2dr9l?=
 =?us-ascii?Q?lyG4hW8YSlPoXhIyhnoHKq7YudM0+IDNQffXXNhmMX8NR0MJkHm7SrPlV4aL?=
 =?us-ascii?Q?wrCPthBCojZI9oFekldLNpu2n2yD4H0fRd20lN4HtTWDotZZvDJibCN/7Acd?=
 =?us-ascii?Q?ta5FiCq5DrnHuQ5nCpwK4ULkR0kjbizNnhRguiYvv4DSDZZSjbjKY+Epyx9Q?=
 =?us-ascii?Q?HSt3mHWFqIlbm74U7bMDToqJgYKf9tgjcSaO+O+hV6I8E1hyTsZTf4iCqyqZ?=
 =?us-ascii?Q?loY8JnWzYdX17EuJcnHvXcbpCTtpX7FQqTEoZAOrmhkCoUG0hOGwabsZ7gzN?=
 =?us-ascii?Q?d+ItACSjheRGIN4CpLf8z/7OrmLcN/Yh9PoNlH7zPt/EbVBb0SlJgotKQTc/?=
 =?us-ascii?Q?B2ajHvOxuJwueBJaD8kZRNVev8ZW6+NFz6U/rmVzkR1NNyfN6sEo97aEQMxt?=
 =?us-ascii?Q?BKss4h9+P+IhQpD8I3idJJfzsopvRfCykIkdlysZEUK6MaPqwxmGRqojltY/?=
 =?us-ascii?Q?Cd9a2YC3ywlwLfrUAqNyW9hkEv5WGiFnJjzVSMQqDiBnlCvmKbFcHVH3bfip?=
 =?us-ascii?Q?NJZpdncVSKEBYoaELCtwG/OAgVZrb0yaXMIJ3kgM8HvL3nf0TYea5MvjBx8i?=
 =?us-ascii?Q?SpLzhbwRXzqpuA4B/tDYQ73hGPKJSACC9gcqrXeM7Af8FFNi0fqCCTTFE22G?=
 =?us-ascii?Q?6siwDgT7bxqim0ijf8OvDtnLF+HbT2DGURlO9GkoV3pSXl4LyBiZOtbC7Il6?=
 =?us-ascii?Q?dabl2tyaKerQ+3LUSmGS0SthnjmgeaDHVB8Qe7f6OXvzf2G+DtUEhxLHS5Kx?=
 =?us-ascii?Q?mc9cjyhVfVX88Fe30iAVquJcEFQ9wm9fQgu1qPDK0ZyYxjwncDQ2cKPltHtD?=
 =?us-ascii?Q?DTpyHu6b9QgcAJNJ5RNCmITYty6pombBlGIXO9kHdpC4Qd7KtOR8EnVbbLo3?=
 =?us-ascii?Q?iUB8sX0vzxoe0sls3h5iBailV9OPdAKnIpFApw5HwOyEZyL/lbMX15WOb8NW?=
 =?us-ascii?Q?Zp7sg/sRvhiWYbuNcwOxZaE++IWdIfuei2JLJi2Yh0GBiXWp2mk54A1VH9iD?=
 =?us-ascii?Q?CgR5v7hSqiFmHH5dvTLMqXvRcP48PxyUug0/a9G+qLUsIYEZLnIo7kB4Dz9n?=
 =?us-ascii?Q?h5Jr2s66PggYVDQ6eCusU0mA08ckXOt2JDh4fnvIJ/YCjOELjQqF5ko0QSq1?=
 =?us-ascii?Q?N3jlSTf5U/KdUjRRY1G7bsLQ3cTsAFbFkcjynjVP1QVsuG6nkMeY5JYdk/8e?=
 =?us-ascii?Q?uZH5UnsUGp7YBCamkMBdez27OU8D5hHiCUzPIHi0LZRQhAt6J3bMIcoXOa2r?=
 =?us-ascii?Q?V9Lr1rfYgqxxZoR6X18=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 794d31e6-e447-4d1f-6da7-08dc67f64f27
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 02:44:36.7148 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DMhjOfwON/h0Vxb7g+TuKZ/vA6flPUeAdoTFe/C4Gd/C3C2Z7f3xjfQzHutfVo0W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8114
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

[AMD Official Use Only - General]

Series is.
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Ma, Jun <Jun.Ma2@amd.com>
Sent: Sunday, April 28, 2024 5:55 PM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Koenig, Christia=
n <Christian.Koenig@amd.com>; Ma, Jun <Jun.Ma2@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/pm: Fix uninitialized variable warning

Check return value of smum_send_msg_to_smc to fix uninitialized variable va=
rning

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 21 ++++++++++++++-----  ..=
./drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c |  8 +++++--  .../drm/amd/pm/po=
werplay/hwmgr/vega12_hwmgr.c |  6 ++++--  .../drm/amd/pm/powerplay/hwmgr/ve=
ga20_hwmgr.c |  6 ++++--
 4 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers=
/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 0b181bc8931c..f62381b189ad 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1554,7 +1554,10 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hw=
mgr *hwmgr,
                }

                if (input[0] =3D=3D 0) {
-                       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkF=
requency, &min_freq);
+                       ret =3D smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMi=
nGfxclkFrequency, &min_freq);
+                       if (ret)
+                               return ret;
+
                        if (input[1] < min_freq) {
                                pr_err("Fine grain setting minimum sclk (%l=
d) MHz is less than the minimum allowed (%d) MHz\n",
                                        input[1], min_freq);
@@ -1562,7 +1565,10 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hw=
mgr *hwmgr,
                        }
                        smu10_data->gfx_actual_soft_min_freq =3D input[1];
                } else if (input[0] =3D=3D 1) {
-                       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkF=
requency, &max_freq);
+                       ret =3D smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMa=
xGfxclkFrequency, &max_freq);
+                       if (ret)
+                               return ret;
+
                        if (input[1] > max_freq) {
                                pr_err("Fine grain setting maximum sclk (%l=
d) MHz is greater than the maximum allowed (%d) MHz\n",
                                        input[1], max_freq);
@@ -1577,10 +1583,15 @@ static int smu10_set_fine_grain_clk_vol(struct pp_h=
wmgr *hwmgr,
                        pr_err("Input parameter number not correct\n");
                        return -EINVAL;
                }
-               smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkFrequency=
, &min_freq);
-               smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFrequency=
, &max_freq);
-
+               ret =3D smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkF=
requency, &min_freq);
+               if (ret)
+                       return ret;
                smu10_data->gfx_actual_soft_min_freq =3D min_freq;
+
+               ret =3D smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkF=
requency, &max_freq);
+               if (ret)
+                       return ret;
+
                smu10_data->gfx_actual_soft_max_freq =3D max_freq;
        } else if (type =3D=3D PP_OD_COMMIT_DPM_TABLE) {
                if (size !=3D 0) {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 74a33b9ace6c..c60666f64601 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -2486,9 +2486,13 @@ static int vega10_populate_and_upload_avfs_fuse_over=
ride(struct pp_hwmgr *hwmgr)
        struct vega10_hwmgr *data =3D hwmgr->backend;
        AvfsFuseOverride_t *avfs_fuse_table =3D &(data->smc_state_table.avf=
s_fuse_override_table);

-       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
+       result =3D smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32=
, &top32);
+       if (result)
+               return result;

-       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &botto=
m32);
+       result =3D smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBotto=
m32, &bottom32);
+       if (result)
+               return result;

        serial_number =3D ((uint64_t)bottom32 << 32) | top32;

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index c223e3a6bfca..9dd407134770 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -364,8 +364,10 @@ static void vega12_init_dpm_defaults(struct pp_hwmgr *=
hwmgr)
        }

        /* Get the SN to turn into a Unique ID */
-       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
-       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &botto=
m32);
+       if (smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top3=
2))
+               return;
+       if (smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &b=
ottom32))
+               return;

        adev->unique_id =3D ((uint64_t)bottom32 << 32) | top32;  } diff --g=
it a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/dr=
m/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index f9efb0bad807..3a95f7c4c6e3 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -404,8 +404,10 @@ static void vega20_init_dpm_defaults(struct pp_hwmgr *=
hwmgr)
        }

        /* Get the SN to turn into a Unique ID */
-       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top32);
-       smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &botto=
m32);
+       if (smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumTop32, &top3=
2))
+               return;
+       if (smum_send_msg_to_smc(hwmgr, PPSMC_MSG_ReadSerialNumBottom32, &b=
ottom32))
+               return;

        adev->unique_id =3D ((uint64_t)bottom32 << 32) | top32;  }
--
2.34.1

