Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AA3CD5BB1
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 11:46:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED5DE10E151;
	Tue, 26 May 2026 11:46:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2IBxsyyE";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012047.outbound.protection.outlook.com [52.101.48.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C563510E151
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 11:45:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wa0z3HNvqakIF0FBUGRNdbpKEcct3RQuRZtyC8UzV3Xh/3fKtDLpbXky9YkLqTAdyUKRBemsjzWsb32GM6KYk7c8RocWcf5fH2hEWkCnqPQTkwBswzuAcAZ0cGvLkEFz602fwfg5D//44zGHFMiYpm0UOB4bljfpyo9Ank42kzgy1IfVERp9aLEt70dOycPTsBXuMd7nnjCp5EMotF2AsS3adxTSROUiHwaJAyZ0VcUFeFITDOOpsYJrdi8Ww8rGV96EFOpHLh1Pds7KYsdIPiRE7T5Q6oTt7CnM4A3Sty6sJfNMtbq16yf03ERpf9k01GG+XESm4KJ88wpxLoZf1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qT4zAa4AFhbV6X0zyrjvfkMKrZ4Fe2uxk+m5D3/xxac=;
 b=dnXizD3l6xK8Ib9sZyS2ipzjOJlaqKsJHsOZ5krYtrklY7+ebBEnJ4UZ+3MZucG1lZYt+DM/7B75Gt+Msmi4WvrIkmeXqPPMd2Sq6ZaLzlAv1QoMvYLWorlMa7loAfzOdZIuPwejchGsHorbQAr2GxF7m4cSBwDkxts2vOGAkhujB4i7J3VELiyukxp6c4y6og4DsE9RFSexMZoTcDlSMnt5DEGpjai8uEeqR3vyu3NMCrUmip3T7h1SRC2yoV/bDh+ILHdNYZPusgrEWJFn6FlROGsAkwqgqstHgpPJtBO6MXMYOkcYZku44MBkxwwgVxE1xYeCmw50aQqeS3bwXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qT4zAa4AFhbV6X0zyrjvfkMKrZ4Fe2uxk+m5D3/xxac=;
 b=2IBxsyyEiIRtqogA/fI4jtvGAdiJZrUzHpgR52FweiNZ0porG1M5TwgYtn0RYvb4NYbmMRN+i4jXZo16kvV4o0iRRzNAHgLO5FQYZ1iJ/TTWNr5wDE5NsF1o5a+MJwievHDRiguuNZsJMPvpJ9Y964xf0sJWfvg4mbXlIFRGgD0=
Received: from IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5)
 by DS4PR12MB9659.namprd12.prod.outlook.com (2603:10b6:8:27f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Tue, 26 May
 2026 11:45:53 +0000
Received: from IA0PR12MB8895.namprd12.prod.outlook.com
 ([fe80::904a:1cfc:7595:522]) by IA0PR12MB8895.namprd12.prod.outlook.com
 ([fe80::904a:1cfc:7595:522%5]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 11:45:52 +0000
From: "Hosur, Priya" <Priya.Hosur@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
CC: "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>, "Gopalakrishnan,
 Veerabadhran (Veera)" <Veerabadhran.Gopalakrishnan@amd.com>
Subject: RE: [PATCH 1/1] drm/amd/pm: smu_v14_0_0: use SoftMin for gfxclk in
 set_soft_freq_limited_range
Thread-Topic: [PATCH 1/1] drm/amd/pm: smu_v14_0_0: use SoftMin for gfxclk in
 set_soft_freq_limited_range
Thread-Index: AQHc3ffYwY2ypZgtJUyvUNJ6nKyG07YgStbQgAAAIsA=
Date: Tue, 26 May 2026 11:45:52 +0000
Message-ID: <IA0PR12MB88954E0603AE0591C9FA40FEF30B2@IA0PR12MB8895.namprd12.prod.outlook.com>
References: <20260507080137.841442-1-Priya.Hosur@amd.com>
 <20260507080137.841442-2-Priya.Hosur@amd.com>
 <DS2PR12MB977328897A55E01978F41CBB8E0B2@DS2PR12MB9773.namprd12.prod.outlook.com>
In-Reply-To: <DS2PR12MB977328897A55E01978F41CBB8E0B2@DS2PR12MB9773.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-26T11:32:51.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8895:EE_|DS4PR12MB9659:EE_
x-ms-office365-filtering-correlation-id: 8d40a055-cddd-48e4-2049-08debb1c5716
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|11063799006|22082099003|3023799007|56012099003|18002099003|4143699003|921020|38070700021;
x-microsoft-antispam-message-info: DG807pUDFIbmT2ozYM5xrDCjWdK4vKFBOYZbl4DJJyc8M4k3Lzz7Ppr0zqqvPzYyIm8oBA2aGqxOol289BH/R14echCX3Lj7xTJufv+wVi0xXsTqgVxQjQkxQJLznGFNvp3U0GBNWrnDmn9e7nDKh0Nz/Sk9B5c99GserPbTFN/3xfmUwspkOaADAqThUm9mmHreuDTbO8aCWDzMNLEcIX9C1NFA/rEG3aC5s74qBh4ARAYt46sp1JOVxlv+GEbieI18AZFaiq06aUWB6twjbDLXxR49lSlq11jgPBJKSlGu6Vx4EjlU9ZUNIkNDCUTFooC59TLXyso9c5Y/2RV6ohZDdNQN0dg+HHKsGL28t7+isJzyHOuGzpLA5+E84SxKXJXlfpsWDseN2CeIsNVOxeSJGsexPhNipjI7Nxqb1ATMNTvMNNHP0cAwL1+7ikFK4jC5j45G9FPAlW/9H8p3i555tcJOAHoLBDOzzveiA18UBXLDpWjzH4lb822vKy/RMxl7z01ZX1/0TQh29yEwMwzjT8RcPHY+annUJYuDI4cWzKmRRrMoRBPlEMx0eNMKWhtyKsPm68CZbBPboMV8R7xVquTPDirk+LAvxrEU8dzU/6elsw6U9x8Ipfsz8p9ZVsHPjPPsNt1Xy285zMtqnVEh/WdkkwcZqcw3GaK0jav1IG0zOaFS5l9FgD/udrsODm9CPm0ECEFhlje8UJ4paFKyDAMc2rMUxB7IerELFM93D+1x4syF7RVl/N/VXGsO0DYD6WyuY+zB8EN1q7nRIg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8895.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(11063799006)(22082099003)(3023799007)(56012099003)(18002099003)(4143699003)(921020)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1nkHPa2ba6W8P/nwEzPS7jqifgZD8wtvVzpVq35jEPdzU2PK0F0wPf8TLjlp?=
 =?us-ascii?Q?MHIUUxO3j50XJHWplq8YwvE4IzuqTVYljPWKQgXbUlULNzlZjnISlV9AcodT?=
 =?us-ascii?Q?/UdlTjnIhSpUZUDXJDWOnYb9X/b8KcrHDLXcq3Q0WZtATgfkvCrNgDXIM4C4?=
 =?us-ascii?Q?gynPk7ytqITg/FUn63HB/O/A8btP2+vnJ83URbzDDRRXApvtI79lxeWjRqGM?=
 =?us-ascii?Q?ocKDV1q2Tytftbc9Q+X/r/8W5fA9JtidFIrv1BP/NA9E+JlcsRn+KI3oxtl0?=
 =?us-ascii?Q?wpOIuJfGU71qODmXFPy+yXrFO92xvAVaeK3ooMycrXUIp+8nOKlBVWvZcaLM?=
 =?us-ascii?Q?Ge2KHm+UnMiW9BodSk/V1+fg7c8ipQHo/m4XARIQx+mkTLec/M/nq/N6WPIv?=
 =?us-ascii?Q?9sx3KZm24eYpY0F+WSVwmmQMJvRsGInKxehok/Je0CJ7F0PpKBBnCAOzBuEB?=
 =?us-ascii?Q?kYVCtqaIK2IigxdKn0R50ZIBspflQJsRiB2bJ62GF6p6CzqMOnaAKhGHlDZK?=
 =?us-ascii?Q?w8WxEtc5lnS4j8GIzgmi0lr4dp6GVV0/GqG7t7uEFKp/KTRXi7GoaBER3iyM?=
 =?us-ascii?Q?FF8V48clSMmsXbVXvLyGDtVVRiPbEKjTgvyYyOoo1X1/QoXusetn6dAsmxIC?=
 =?us-ascii?Q?oqxSFtptHALLXxEnIYdRBpJ6rEnmNU/WQQuVZVOIajTjnATeyxFkmUipuxpV?=
 =?us-ascii?Q?cOPG25O3rFv6Vjo0o66nH9VhpMbA+9JgZ2fa48rQ88iukwAE02bmtYT3gwzP?=
 =?us-ascii?Q?HORzCZolnvu47J47YR4ZdkOc135SQ85tMjGbzDHw1iqlncVCnbwaA/UHnqe1?=
 =?us-ascii?Q?SaW0KH7+TjTQ6GWNgvH4TaGX6L0KcLEctoLT96x2Mna6/MYHHNhjyQ3udocy?=
 =?us-ascii?Q?dLNuqL6mhyhDru9U0PhqtE7c7w2oL6I8+7F5UMhxh0YuQxfId4GHSRjxrS3/?=
 =?us-ascii?Q?OU4aT4AAdJyEaVWvfK11A91OmQnDx5UzkfgQjmwNvNS168sJapBixQOlrwuC?=
 =?us-ascii?Q?jW1Sy0BYYNONwU+u4EzomX9DEOPqqoFlPc06U+tTlstfXdTvIOjUCr2fng+y?=
 =?us-ascii?Q?Ub/kZBj2AfVm2ABK34l1kdkbMBDAOlI7Y5M4HaFVEYtddJv3A8R+1gINnWk2?=
 =?us-ascii?Q?7VRnzluQZU6jFkXvRB7blxlzFPPzafVw5omaQSuaYUVrQEJ2Qi3rrS/oEA68?=
 =?us-ascii?Q?+tDDZcRoFtdO8GIlRS13NCawUxSmsVfBPqe29mHwA0E6vFrTCdXHrJrzX/Tg?=
 =?us-ascii?Q?PawkoPDMfeGGDmfThor+l7E+GwUjch0qh4B4kgBNeHqmGXNzx0JB2T8OUMv8?=
 =?us-ascii?Q?xWHhKvawFXcBRud4hYKZ2NN0FfY7e3xz4+06pkthJs5vaM5zTpDZ7/Ygnwgl?=
 =?us-ascii?Q?1DftmYCp8l3QHIHLX5g2wxjW1XDttXs42byl8DuD4OpDXmdNwnh6h25S+PaU?=
 =?us-ascii?Q?LpdGC16qHatQkjKg+jyrxBdV3hkO+JHb7ZEccIcEoUby9Ys9GIQTDTmsj2sp?=
 =?us-ascii?Q?/U72ltfaBCZlN5x/KKLb3TX5SOnSjZy0nnrGs+WgUzEiV+knOPfS9pHIHyrk?=
 =?us-ascii?Q?37Qxbd+Ekx3E7wRklKLmfazw+dPuInb9Sd8j3aVyZunymm0Bv0a4WZqS+yOe?=
 =?us-ascii?Q?hW6MAMrvjZiz/jNQKGso0LGIDz6ff99np896tR+ukPNZiRLgLVBXOFkJhd9N?=
 =?us-ascii?Q?Rp5rRGyEs27ouEqPT0oI0Wditn7zEZROqvXTQmxQ6llRdtnj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d40a055-cddd-48e4-2049-08debb1c5716
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 11:45:52.7146 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rJN3L4Ndy3TXAu/kGJClaDWx5iS4K0DhVMGnntbPsFldZ+W+c2Z2FO59eOggpvN1o+yfMZxrJZkDCQAWNqdmmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9659
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

Hi Team

Gentle reminder regarding the review of the patch shared earlier.

Thanks and Regards
Priya Hosur

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Priya Ho=
sur
Sent: Thursday, May 7, 2026 1:32 PM
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>; Deuche=
r, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koen=
ig@amd.com>
Cc: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>; Gopalakrishnan, Veera=
badhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH 1/1] drm/amd/pm: smu_v14_0_0: use SoftMin for gfxclk in set=
_soft_freq_limited_range

[Some people who received this message don't often get email from priya.hos=
ur@amd.com. Learn why this is important at https://aka.ms/LearnAboutSenderI=
dentification ]

In smu_v14_0_0_set_soft_freq_limited_range(), the gfxclk floor is programme=
d via SetHardMinGfxClk together with SetSoftMaxGfxClk. Under power_dpm_forc=
e_performance_level=3Dhigh this pins HardMin to peak gfxclk.

In PMFW arbitration HardMin has higher priority than SoftMax, so the firmwa=
re thermal/PPT throttler cannot clamp gfxclk via SoftMax once HardMin is se=
t to peak. Replace SetHardMinGfxClk with SetSoftMinGfxclk so the driver sti=
ll requests peak performance but the firmware throttler retains the ability=
 to clamp gfxclk under thermal/PPT pressure. SoftMax handling is unchanged =
and no other clock domains are affected.

Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index c76b1f07885e..2fe006de927a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -1231,7 +1231,8 @@ static int smu_v14_0_0_set_soft_freq_limited_range(st=
ruct smu_context *smu,
        switch (clk_type) {
        case SMU_GFXCLK:
        case SMU_SCLK:
-               msg_set_min =3D SMU_MSG_SetHardMinGfxClk;
+               /* SoftMin lets PMFW throttle gfxclk; HardMin would overrid=
e SoftMax. */
+               msg_set_min =3D SMU_MSG_SetSoftMinGfxclk;
                msg_set_max =3D SMU_MSG_SetSoftMaxGfxClk;
                break;
        case SMU_FCLK:
--
2.43.0


