Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899F3C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Oct 2022 04:34:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EEB510EA67;
	Fri, 14 Oct 2022 04:34:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19C5710EA67
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Oct 2022 04:34:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClTvPjw9TPGVNHdxafCgu8dlJRbSZ04iaRCn7BjuQqyM9wuczwNlMUoQFDtHgd7cx0Qk2joDU/IWACofPsEuCLVblVBCE9hTvhp/+IwWktNsP1BHbLpi80jfd6Y79ApViX5BXYaBGao/UBxo1WkMEigdBtPVIV9C0lJKlPsnpkQoELsS7Xoav25GGPi/ofZdnl5BPiwAVFJe9qTVgFMQzkY9Qmt95DH+N9Kq5DW6bSmgdlvZS0aY4GQtxBbOydHevqpCgJ1eu5jG0mcsYOk4h1tl6Ns4czLWw0uPnlOe4U2T9PVKc23PacxraKLlWkoXgGw6d7nG7fb962/JGRXRlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iKBuH2lbgnTmuKb+gRB3sQ7fdiiwejP3FSQMKAiqps=;
 b=JWPOXs9jlVDnMgIhpzMmlj7GkSpHoFVvCIgl6h7lGheftT1dU1AugTqqIGtJ3lhBD7vBj/8ijP8ZuFG+QVBhzUDjuZ1rotHckiPU3hPVUmCML4GBLN2db+kIM0WWAF8AddpfBXiD6xT7S59RQimkROz0sIrA7FbTnHyhkmeE6SEQdWj2U6S+4i7z/RAZqBB8ydmBUpflC0k+wpTZV+VJ34apPzaxp+ayhGszfq2lymnoJepgIYRE6QYZCj6jngT/AAuEHwflAjQ7hKVsjksFbrpA6bjGPr97tXNnUSiiRUrUbFLJk3YXaQomX3NQW7bMDmta0FoLKPeI+JFIf8M+4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iKBuH2lbgnTmuKb+gRB3sQ7fdiiwejP3FSQMKAiqps=;
 b=pBVQrpa52Wzf7tIZNDDgQlT7zWuoPmDyvTzROdg9jx8fBWpCmcA8dkLL6LVQldZiNABBVBkEcTuxYuTzdsxrbAAK5vejvX+Zg+o59CBdQHEFvJTt5aJUL6PI/dMfJltiJh/2zRNdg8wBL93ZJoeskhURUHW+M5U00QM47FqKUKk=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DS7PR12MB6191.namprd12.prod.outlook.com (2603:10b6:8:98::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.21; Fri, 14 Oct 2022 04:34:43 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::78b6:27fc:c590:d2c0]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::78b6:27fc:c590:d2c0%7]) with mapi id 15.20.5723.026; Fri, 14 Oct 2022
 04:34:43 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Song, Asher" <Asher.Song@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "stalkerg@gmail.com" <stalkerg@gmail.com>,
 "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Revert "drm/amdgpu: getting fan speed pwm for
 vega10 properly"
Thread-Topic: [PATCH] drm/amdgpu: Revert "drm/amdgpu: getting fan speed pwm
 for vega10 properly"
Thread-Index: AQHY34OYAhFoeDF4qEqRLI04baFNh64NTVbw
Date: Fri, 14 Oct 2022 04:34:42 +0000
Message-ID: <DM5PR12MB2469625AFACE86F218F14AF3F1249@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20221014041456.139813-1-Asher.Song@amd.com>
In-Reply-To: <20221014041456.139813-1-Asher.Song@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|DS7PR12MB6191:EE_
x-ms-office365-filtering-correlation-id: 3e06c0d3-23b4-44b8-527f-08daad9d6a40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5kK7vx8GQIkNw3tZxUyINqEwDEteJBAMRmsFVVsIogRNGF3jdeNMQMymgh7lsjP9lTJP/bhvNrXsgRafddXLVKRs57TtZm4Eu6T7Wc2npYXETJk0zldfD+kIvRgO11nBQJylWxfXTueYkXvrOeZs5fAulcPUalcHjQXB/1v5DafqFffVLAWPK0V5xjbLbE1IOFl58qgBPaftDo4IUuoj4ZotgtSyosvC9482ODR2megPf4dhHgzQOZVCcBggYdIjntR24967LYZAfCEz/YP8JCA9zMh0uZUZ0tlBtcbK0ibl6gD7VBBgal6xSBLg2xbkLdGhs0TDzeOD+wJ9H5N+7imZTrroKH7HioXE9Y1LhpRDINbO6vkQdAvLO+h/rfjQPjwhYm+dFVqg4RiCwZ9sPr4f8lhfUF+dhCTae/J02t0V9Za9g5wdkMIZYwcXQ9mVJ9weOEYFajiKjECj+JBbkRtAL3BDzGjOVKqDjk+2s5riavfeoMeUROpLgAARfpP4Zm0q6hgqT6maPB7cVNpgK5dAyWOhrnh5zrAN03mxQ6pBs1iodySlxzk60aERZZc5lCZDW8tiKw3hfJ/O4N2d8ctAZnLyAHjY5S6aFdzfOzKfwgoqaUrfDc2j7feqYotHwGb+DPU3KFt4MfNC4z4Cvl3LNj89ztDpuSirSmYWuIvWvWbRUlABSYkdHWtYbdT0JG5+rhO/kTxyGVFzk/hWhSevUg8bn+6SxMWE8YzNCeFl/Ttk7c27ABcSgXSZ4rzVBoP+olGVOXq9fubsTs7KIQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199015)(33656002)(86362001)(55016003)(41300700001)(5660300002)(66476007)(9686003)(2906002)(64756008)(8676002)(8936002)(38070700005)(76116006)(71200400001)(52536014)(66946007)(38100700002)(66446008)(122000001)(316002)(478600001)(6506007)(83380400001)(26005)(186003)(66556008)(110136005)(53546011)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eRQxFgyadnsuRKbt/5GK2LNEgxkGO7Q/BaQNWHRYuQ+7UEYKhd1rVmLqJy3k?=
 =?us-ascii?Q?OS/k+09CLaYlIGL65HNnkrjk2ArZUPZif2hFV4hUt4LfYffdX34km+D2K5Z/?=
 =?us-ascii?Q?MkoyFyGZA1O5yoCApstuYC8nxJ2PFX8wF9IdWZcBymxr8+OvcrLuVP690Z0W?=
 =?us-ascii?Q?fvJ01hlmtgnGM9LqwKTuMWJyB6CRQ+nlpBs/iZujdkdSTx7c6hANCCOmCyvk?=
 =?us-ascii?Q?NNrQYMSlvFCKYGu6b9jIPgCkY2MD/kMp4U8CJvdibQHN0nXDMLoRNbR7LSVR?=
 =?us-ascii?Q?b+bxm9D1D2zpq1nE4e4b+01kcwRD8sLYFXvc4WnbP9WOjLK1ve5gdxYQqqbI?=
 =?us-ascii?Q?CecuRiqJZrxmnTxeaRcMpq/TUztYKXP3JN6hJZex9EJJIvZFNCeyifxuX2QY?=
 =?us-ascii?Q?r8tTtwcTTxan+2gAMpsitr5QWAtTmgGF9di5B0ArgYC8X+ccjswlc4lpB9ky?=
 =?us-ascii?Q?6Xqiu/1xq5+sHrrsL3ksr3wq1xRjYMJCl8hvE+b3ZsrNvqn9F0qzBQxcm1W5?=
 =?us-ascii?Q?3d3WMvAmyax9XvrQqWWopE1MrR1+CMyHCyrThO65xRf9FvCnz2R2JfbyIEg4?=
 =?us-ascii?Q?BC5anGP6Fcqk7XpL1+3pt2SqCno1PNmcXtS76nPB1jQSVRJYuOjkqzfOTaiS?=
 =?us-ascii?Q?Pvd9NnpZwBpXr3HRc/WYfZ+z+Sg6l3bBPvEqYMTsgh47+LMedwWCQvIUs5T2?=
 =?us-ascii?Q?ESY+rPSO4rD3MuKbinqGbgdkgMmbDoRvl4QA2OQZySaIUdGvimxx5Tx2oHvW?=
 =?us-ascii?Q?9GQeb2p2Yhb8Kkcnz+h59fWmnl+yFk1AQVjJ9Tu24kwdz+/vq2qPcJuMhEnz?=
 =?us-ascii?Q?cb9ZDBRs5Luc5uHiNwS7M+QKBKYMVMeT3lKj5sIoCjdqDDAnukYIoDcYJDBT?=
 =?us-ascii?Q?6RzSwuau9OL6C5YYHvw5pHvz9Y9QtNlc2uxKjZzF/YG8YDjZwRP3DUKSxVZv?=
 =?us-ascii?Q?4LBJiLscvQaBAKo6dc9qzqKtitNe4QUJUX+Uuul7wBJanA5l2HLdMVlCdIjD?=
 =?us-ascii?Q?1cdJdtJv1H3x21UAtqf9tMGa2utE009xby++254XQJ/1HHRd1r3Tj0C8VfxM?=
 =?us-ascii?Q?OqO3uIzklsiEBxgmqqBZF3imXTlE/RITAi3F4Q/H3jsvoYYFtZaAyy3nEWOA?=
 =?us-ascii?Q?0WCSD3PYjxdhXtJf8YbfWqyqtxLaN0tZC5+loKV9mjOTcQ8b0cUZH913CQF3?=
 =?us-ascii?Q?tEAtg2aX61VQgVoPWN1UiRH0hAZ5LTShafR5bPUdCj9FmjivW8Zrm+2oCLPW?=
 =?us-ascii?Q?tjpbcMMZdwSITzxsrnhr38R2hhtQJEnPlfVqKiPynU5Tq7+z/CvMCDeS2IRj?=
 =?us-ascii?Q?9r2Ir0prmJZ0wyvwRTk92U/dHu/RDX4FqZUwnvh9iVATATEQTBN6g6UG6IYE?=
 =?us-ascii?Q?LLvL0zufgL6FS1ewr66mFreu35OYqsA2/f4JvVTBrpCcTVWBOhaawPeAyt7e?=
 =?us-ascii?Q?4VgHzk1X55iENErIImkT7sVI2rBh3iVbqthQtx/FqiZSyRXgHOZLyNFv3lkg?=
 =?us-ascii?Q?ob+e/mHjCBp0hFPxwJvt2jLTfgGvmLJi9ynFMuPIuKib5OBiBkRab/ud8OQA?=
 =?us-ascii?Q?iFWOc8IC3FXKMLmaYag=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e06c0d3-23b4-44b8-527f-08daad9d6a40
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 04:34:43.0105 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4iUOIhYk0YTSJYU9y7+8IsbTJwGMmD5ZhaRcn1BjzlVrBlgXWfaymkfmmds7LbB3j1i7gPXQICAlLTHfE3G5/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6191
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

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Song, Asher <Asher.Song@amd.com>=20
Sent: Friday, October 14, 2022 12:15 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; stalkerg@gmail.com; Che=
n, Guchun <Guchun.Chen@amd.com>; Quan, Evan <Evan.Quan@amd.com>; amd-gfx@li=
sts.freedesktop.org
Cc: Song, Asher <Asher.Song@amd.com>
Subject: [PATCH] drm/amdgpu: Revert "drm/amdgpu: getting fan speed pwm for =
vega10 properly"

This reverts commit fe01cb24b81c0091d7e5668874d51ce913e44a97.

Unfortunately, that commit causes fan monitors can't be read and written pr=
operly.

Signed-off-by: Asher Song <Asher.Song@amd.com>
---
 .../amd/pm/powerplay/hwmgr/vega10_thermal.c   | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
index 190af79f3236..dad3e3741a4e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
@@ -67,21 +67,22 @@ int vega10_fan_ctrl_get_fan_speed_info(struct pp_hwmgr =
*hwmgr,  int vega10_fan_ctrl_get_fan_speed_pwm(struct pp_hwmgr *hwmgr,
 		uint32_t *speed)
 {
-	struct amdgpu_device *adev =3D hwmgr->adev;
-	uint32_t duty100, duty;
-	uint64_t tmp64;
+	uint32_t current_rpm;
+	uint32_t percent =3D 0;
=20
-	duty100 =3D REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
-				CG_FDO_CTRL1, FMAX_DUTY100);
-	duty =3D REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_THERMAL_STATUS),
-				CG_THERMAL_STATUS, FDO_PWM_DUTY);
+	if (hwmgr->thermal_controller.fanInfo.bNoFan)
+		return 0;
=20
-	if (!duty100)
-		return -EINVAL;
+	if (vega10_get_current_rpm(hwmgr, &current_rpm))
+		return -1;
+
+	if (hwmgr->thermal_controller.
+			advanceFanControlParameters.usMaxFanRPM !=3D 0)
+		percent =3D current_rpm * 255 /
+			hwmgr->thermal_controller.
+			advanceFanControlParameters.usMaxFanRPM;
=20
-	tmp64 =3D (uint64_t)duty * 255;
-	do_div(tmp64, duty100);
-	*speed =3D MIN((uint32_t)tmp64, 255);
+	*speed =3D MIN(percent, 255);
=20
 	return 0;
 }
--
2.25.1

