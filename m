Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B62C4332F
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Nov 2022 01:24:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5754610E039;
	Mon,  7 Nov 2022 01:24:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3718B10E039
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Nov 2022 01:24:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6dfRlukpx8yjN8fY0RnuPpPjwabt98ayWxfhDKa5LkRZ3GOWlrtocUU7foY9x5oXlqRsI2NsdqnFBmvNKSYl/c+uLcQoTOAHEcv31JvTNyK4VHnUkILdjFh8TQIkg8IjYTk/6gx9DeQ9ZDI5tG/DltcGBm8/GJF/870f8VFc9ITnes7UieSIAwoZHsZH4PDpaPvYeOGm0x5ckNfr2Q8s+PV5r7rWx0oFIkhgl3yUi3vMCtFWlbneWYFIk0w8XfUg6IEfgdOOj1YrfbIDm8AM7ZGE6mzViH2FaMLHREfxwO7Trcyn09xyNhTOedgIb/IdZofs2K6Yx7iE55FihZVdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Dc8vH3jpAV/YvlmLYTGS32Ou0SgzGc+9f7fxp3bMoI=;
 b=BjFo3pXGfOAW53zXJXKYn7eg+jIGH14gvE9vsgK5bVW6+aTfnUAwd1WtVufORBTKnbwiW8/+nZccXh5vNoUfaBr8QE4gl34MI6J0L2XVNf1NEw1dhE/Giv+bfHtcaKQ6TXDtIraG05VW+6jkwtx382OqwVtaM3g0n793YB/irTmG6HENmn+AjHYVxk3q2Yk6P1tczPfM8cIbr7GLuUamNrCG4ZfIBeL5EPr6xQjMR/cdjrGZEPqAJoKyrZLHyyFDGQGC3/SlK5cPV6ssgiwAX0OGcyNnpRQKE/GB0q908jlhmbjUfDM5A6eWtS3s/ZcSnSpPhVokx3bEAh58OypEQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Dc8vH3jpAV/YvlmLYTGS32Ou0SgzGc+9f7fxp3bMoI=;
 b=fFGe2GCuDY6ac4h8/4Ipl86kcOs8rBpVxG9CyfcsM7HQZImlFNwmr2JVOy/AtutFLyA9MRfOcLJl1qQvkZWtBHPFxChyJSjZvk+7nqH6wcZQ0KJtttl1eMhHMGnVfL+CeU65SQ3p3ZHkJMZV6cqoQwHOsGczt6iMYmQUp45T03Q=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 01:24:05 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::aa23:a85e:de27:6520]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::aa23:a85e:de27:6520%4]) with mapi id 15.20.5791.025; Mon, 7 Nov 2022
 01:24:03 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Song, Asher" <Asher.Song@amd.com>, "stalkerg@gmail.com"
 <stalkerg@gmail.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>, "ernstp@gmail.com" <ernstp@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Revert "drm/amdgpu: Revert "drm/amdgpu: getting fan speed
 pwm for vega10 properly""
Thread-Topic: [PATCH] Revert "drm/amdgpu: Revert "drm/amdgpu: getting fan
 speed pwm for vega10 properly""
Thread-Index: AQHY8DAba91QByewdEWZuxLJ21VWq64yrrDQ
Date: Mon, 7 Nov 2022 01:24:03 +0000
Message-ID: <DM5PR12MB24692372EAF21F764041AE95F13C9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20221104093022.446357-1-Asher.Song@amd.com>
In-Reply-To: <20221104093022.446357-1-Asher.Song@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|MN2PR12MB4470:EE_
x-ms-office365-filtering-correlation-id: efacc6e0-7846-49c4-a04b-08dac05ec1ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VBvejCvCDdImdDiTP6fG1ZChzlxbfJINmcokT3iDZ3BOv3vLLu5cCRvhTt2jIdiLVj7xTmLx/GeYA/7I+5EClCYM/gjDACL4XFq65zUFRSYR4J7NowXw/3wwHHIx9v0Cc4b98ZQ7KfgHPuGmQuC9CPhSKFqaSB1hKXS1D7HKPWx0KRC5hVsuUBEEiOWo1noxByEwajpbH3tF7YBbC1ybFf4X1/QWvH3pvwyXenunolBSBVL+kJKA5uQEW36XYgmNX6Pq/SD2Pk/9H18H4f4CwgVhORp3vl/biLlGS6QneSe1fPgnWmJxJkNq1OSC3W+ipnvomdRCxjBoayuKq2zVGGutiEfcJT/Fh+GSBMe4BAr/VGqjHg97QaNtbjX5KTtl4F9T2XmL/+3c3CHqiOo2zOJt4jTNnQ8qXY0hlM0gvZ5aGr/ef1YQhTI5No1/2ZDlV/X3swmzTMWS1y3aaqbrGe95sk9KmIZeuIRnA9HdymD+sBJhXSUo+LLghjXp4ZV8RYwH95Afb9zPLqFZWjts1o0OKg/sTCP5W322gnYG/dinT7pI4XbZIRZfF2M52882Q53TOkLJEtk0iDdCMVs63A8AqxVGAubKyxffwPCSoKtlOSr3PHUep2fJnKndVAnhgeooghRse3J4iGKSGi3Yrm8ISING4X5u1/0Isq7Q3GAN/5OGilDwmnfQPOi5xt2asRVp/r/ZLUOqPobBC+4LezqUBTI7r+iebnp9HXPlDxFQwJG5UAegQTOS3mtMbiZsB//Xrw4M/OrS6R2BRYgsTA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199015)(316002)(33656002)(5660300002)(110136005)(55016003)(71200400001)(38070700005)(83380400001)(478600001)(2906002)(41300700001)(52536014)(8936002)(76116006)(66556008)(64756008)(66446008)(66946007)(66476007)(8676002)(9686003)(186003)(26005)(38100700002)(122000001)(53546011)(86362001)(6506007)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7ytqfnNQqDzOXuhiMoeEh/HA/GEGYy67SMZn4f+HzGqazeQpRb9XBpDiPqjm?=
 =?us-ascii?Q?rIBF09TilGkF3DY69tcvb6fRjxBOLO1REUa5mXNW784VpkyOHvRdpqiJaoz3?=
 =?us-ascii?Q?dQ+5ECkEYIf7nAOgqAJ2sk911i5QRKLZGsIoWdSBCUWNKf8HztnyrFLKwfS8?=
 =?us-ascii?Q?I0QbJf3YuKfV1sHiigXzI3Yeh8MJ+LPhafUr6NNg5lQ1Jmjvl6nVMV8ubC3Y?=
 =?us-ascii?Q?1KlJJGH1ye25DSqVOJT+w28bpUxGYyGY/0R0qAY7/poc4Sd/wErg3ofk6hOe?=
 =?us-ascii?Q?fN/Op930Jxot4sRmXhMFrxXbkEB2CD5FslSqEc17ui0QWXkai7/4xtg9/yUZ?=
 =?us-ascii?Q?1e6YxRDIBvzHbCogVC2riz70k+RziXk3rE6Himuyktn/4rf2/lQIEkizJCgo?=
 =?us-ascii?Q?4htCXoJCRKys9nh/mRCRVHyI7PNQpAEIj4NHqyxE3yoOSfB6os+FCAzVzqbZ?=
 =?us-ascii?Q?0uImRUDTQW7gOwZTGAwSJWENaWKcRM0l07mSwt8ui0seO+RWxd9U3K5nxdvA?=
 =?us-ascii?Q?cO3IuASYL4MTr5YKn3JSYP5HBF+b0y4a95jknD0Q5PD9LGTQRAdduCyRlJ67?=
 =?us-ascii?Q?L1246SNSAGzFh5h0bPAL0dhBCQKehpz3becvYIhMlP86jtmjwglZAyRugsP+?=
 =?us-ascii?Q?/WctuXfI62nUSjjkoxhReT87W2YH6fat/pbc+g6MKa4zt/JYVIaWG7xY1xMq?=
 =?us-ascii?Q?372PeTQOVnXBtVzNBp7dN5TEhheCNxVIVacFwbPh+Onln3m1/Vl3mN8jof37?=
 =?us-ascii?Q?fMCs/jcfX0k2ZOTTsyE+hAywhxrUCtsIa99Ij5iPZkL4r+aVE0AeYPEa01q+?=
 =?us-ascii?Q?/574OHaRn0cegL8i67P32kEwTM/U1vwVhM4d0KtqpYorVnqNqJlnvRj8KTAL?=
 =?us-ascii?Q?F3VT7KTg5EnDAie5De+YIdl+YB41B8hXlKfym4EOuV7PD7HwMwr71CYCIYTY?=
 =?us-ascii?Q?YYttNJftqzjziQFr+503O6FJ6Tx4us105xecVM8x4oJ9IGlGn95TohSRkK6g?=
 =?us-ascii?Q?UoOQftLHG9plHz9OXiJNEMoQxDUTUKnXTpEmO4JzwVf0Nua0A8Bsr48x1vu5?=
 =?us-ascii?Q?X9fWa27Br49GMz6LMHn8EOLKcI4v0/Zr5IS0hmhJVFe+b73HF8xbi2FmcMF5?=
 =?us-ascii?Q?9s/vbdQWute47AqF2ewCxJ77yIuZgmvWN3Sw93hPvUDwdaCa9LOzrz2hn8rv?=
 =?us-ascii?Q?l5RmSWMg4s5mlpHD1J/l+AnCkz4m89fE8+efNOcaholjYtGHGs3BRLxWHpBQ?=
 =?us-ascii?Q?vIu6adFiWrRbZaCKlrCSR0MmdJgAMBeB/DuU+1SaVYa4dECjShOB69taooP8?=
 =?us-ascii?Q?cRECXNIJhIfy4Yh48NzEqFw5bAxQy5x7s5hprg5ku8BxrrD+Xgj0cK8v4yji?=
 =?us-ascii?Q?Bce+lriYZTM9FV6s9/lkGwwHDYyBHcsUoO3kT8Lkfve1Gnzc+9sTadYPv4q3?=
 =?us-ascii?Q?b6DMCk50TG5f+Cc5ZbvNKgirF3ElA3r0XdQIvLyPvcs0EhPD/fN6GSPAderh?=
 =?us-ascii?Q?7tE23lZiNJwGcodLH/z5903qo4GSdjZvgRVz3kypUvcC73sRGkiZkMlw/3Tz?=
 =?us-ascii?Q?vIth5W3pEHO+zSxCxpfZSQ9uAeTInvrx8fZehNya?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efacc6e0-7846-49c4-a04b-08dac05ec1ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 01:24:03.4874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trvIoc/nharkMl5Qf9PwuTclprngM0aU1k2cdvw45YYwFn8rnlaAozibjEhCOVbs9AESPl9nRU0L2Ypqtm8/Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
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
Sent: Friday, November 4, 2022 5:30 PM
To: stalkerg@gmail.com; Chen, Guchun <Guchun.Chen@amd.com>; Deucher, Alexan=
der <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>; ernstp@gma=
il.com; amd-gfx@lists.freedesktop.org
Cc: Song, Asher <Asher.Song@amd.com>
Subject: [PATCH] Revert "drm/amdgpu: Revert "drm/amdgpu: getting fan speed =
pwm for vega10 properly""

This reverts commit 97370f1826eb7ee6880e09ee1eaafe28232cabc6.

The origin patch "drm/amdgpu: getting fan speed pwm for vega10 properly" wo=
rks fine. Test failure is caused by test case self.

Signed-off-by: Asher Song <Asher.Song@amd.com>
---
 .../amd/pm/powerplay/hwmgr/vega10_thermal.c   | 25 +++++++++----------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
index dad3e3741a4e..190af79f3236 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
@@ -67,22 +67,21 @@ int vega10_fan_ctrl_get_fan_speed_info(struct pp_hwmgr =
*hwmgr,  int vega10_fan_ctrl_get_fan_speed_pwm(struct pp_hwmgr *hwmgr,
 		uint32_t *speed)
 {
-	uint32_t current_rpm;
-	uint32_t percent =3D 0;
-
-	if (hwmgr->thermal_controller.fanInfo.bNoFan)
-		return 0;
+	struct amdgpu_device *adev =3D hwmgr->adev;
+	uint32_t duty100, duty;
+	uint64_t tmp64;
=20
-	if (vega10_get_current_rpm(hwmgr, &current_rpm))
-		return -1;
+	duty100 =3D REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
+				CG_FDO_CTRL1, FMAX_DUTY100);
+	duty =3D REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_THERMAL_STATUS),
+				CG_THERMAL_STATUS, FDO_PWM_DUTY);
=20
-	if (hwmgr->thermal_controller.
-			advanceFanControlParameters.usMaxFanRPM !=3D 0)
-		percent =3D current_rpm * 255 /
-			hwmgr->thermal_controller.
-			advanceFanControlParameters.usMaxFanRPM;
+	if (!duty100)
+		return -EINVAL;
=20
-	*speed =3D MIN(percent, 255);
+	tmp64 =3D (uint64_t)duty * 255;
+	do_div(tmp64, duty100);
+	*speed =3D MIN((uint32_t)tmp64, 255);
=20
 	return 0;
 }
--
2.25.1

