Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8634C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 13:31:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A08810E9E2;
	Fri,  3 Nov 2023 13:31:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6C7D10E9E2
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 13:31:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rij947xIQVPBYyoKMGkpzbvu7q+FfVSySKJ/eUSPcGmfspWXDSCa+pUO8HqFEPiapbDG7Ns2M9EHYTY4ZpMNU8aZt36t2k2n0+lUE4re7P+P910uk5hqf1AnbeIesW+7K96/dFmMXIyRDQYMbvqH9JMMqziOR5Zn1utxx9AiYsSzK0i+G0/H4LejLGaI68SESywpMpn7svBkKlkIBgtoN+RMIVQpfs3IzfH0gb6icse38naYgP3fktofM4QxDqeK2L5IsQpW9f2mRL6uodl/aH/9Rll49SQjeexm+0Bc6SfzGusa+cZbg9a23+0N+/ldv8mYnRMqwrEI9W7QZZX0cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAhyILvY34fI0V67+HdbjjTQXsn935Dar3mpeURvxZQ=;
 b=iVVop9h3aJPLeaV5G4BQtOp06aT88KL0ASqrKrNRbKcTk86es9/QCZogimOmfz4AGXyu1PcluMDtHEDtZXCyQUYDgjEnLZOeFBUffoq8LPa67VS/BOdvDA1DAclDRVC0TDcxECso+Yn2++4BdLcQATK069BjtF83XpYe3NWUNXT7E9JOfj85oJ+3/UkayvZWeyI0rYZFjxb2++PWenBBatfmEICGnN79Eh2RNSgZ8G4M9EpMob/k3dAGEaEQB0UR30KTwnf0rAJvMvimC3ATYc1HZAgRP359KsBea4UJz9VbMBZooLi1+KcjLGiADo/A55p9TmqHmPKXIJcQ++HZsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAhyILvY34fI0V67+HdbjjTQXsn935Dar3mpeURvxZQ=;
 b=Vt4LV+Qo85vxKa/kQRzVj9sWGAw7l1Lkp+oFbvL8oVSjZcFfzx5ru5jPxoRBFDWNuoLAP7cffQdKy9RreRQBaDxahRmEBPghYUrFLUCuqlc3by2n/4PiQaTdYzAKZKnRYJz2WqT+5AHNAfE10lLNb4Uni1Tts4xYgswB2UxH5Nc=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CYYPR12MB8890.namprd12.prod.outlook.com (2603:10b6:930:c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.24; Fri, 3 Nov
 2023 13:31:35 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e%4]) with mapi id 15.20.6933.025; Fri, 3 Nov 2023
 13:31:35 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Move some functions to smu_v13_0.c as generic
 code
Thread-Topic: [PATCH] drm/amd/pm: Move some functions to smu_v13_0.c as
 generic code
Thread-Index: AQHaDi7A054iCXkn5U2dXu04E5y63bBolneQ
Date: Fri, 3 Nov 2023 13:31:35 +0000
Message-ID: <PH7PR12MB5997321C7E66526CF227B3CB82A5A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231103082113.3038890-1-Jun.Ma2@amd.com>
In-Reply-To: <20231103082113.3038890-1-Jun.Ma2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CYYPR12MB8890:EE_
x-ms-office365-filtering-correlation-id: b29a0656-9776-42c5-6ff8-08dbdc71334c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: avMN+6Tm5ucYcsSgjJhSzPFD9ZBxylOSOtPVh7h73ZAhQ29kjyOAo8hBmyVLx96kc7rppEyAGrL4pyGdoNUrfBbjkxDvUrVyVmIfLY9lPsMrBrOQ7LX2O0ewWxuSOQKfcqRyGO15ELNJrJvg9z0Nj+llsOzJNZIBCfW5wBhs3gZKh2xl4cCY0sqtrc07sdeeZzeQb6nKST/L6G1Ij5A0nlIYt82janSnzTBfj6Osiu7HYLSxWaqKzqZKR2vfnwqmMWP+NTJf5GxQcwsYjdZW4d2yHwqRKalXG+NcFVxDflOn9RuXq97GM5wGAffo4r36p/j2YunMDo8gC9Bqk+zaStIYf3A2VMVCycfemVVuSV+VKlVq70l+xhvsefhLGuapP+McSwucsHzNn7aIZsqE5kTtjH1UextcvA3JevqvgCuwrB1lYj/6OIwjhnKAPNGyBRDI1ks/JkjohH1lyAgLezBT0Jg7Gx+lBkdDIm5NmV2H8W6AX0VNefBHXUOfznx6BATDuwtdofkIHhhoa7fF1aNBVyHV4GGP+dHXsutK7ZKCbVvNHNuwCMGLdX+XqVRzbSiIeaGomgRiNXkTW9pmTlVz9unWf2vhNt3FLu6iCuFSin3Oz8E1F/Wmw9T4SekE74auGODdi6yFxXeIYlr++A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(346002)(366004)(136003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(122000001)(33656002)(478600001)(52536014)(86362001)(5660300002)(2906002)(38100700002)(41300700001)(55016003)(83380400001)(26005)(9686003)(6862004)(8676002)(64756008)(66476007)(4326008)(66446008)(66556008)(53546011)(6506007)(38070700009)(7696005)(71200400001)(6636002)(66946007)(76116006)(316002)(8936002)(41533002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CPS/uSQdO/QnQv9gSMB53HBmDrgp8daA/EEXNvWQXfhy6SPYdXe6yXADcFfn?=
 =?us-ascii?Q?CBFxLjJxWE37Gq5E0P1Mopcoya1EnKQZImjsj+759+++Pjh8l+Zg9ETrE0qz?=
 =?us-ascii?Q?x87l0AUuW+Czq9y2MnB3n7YNZHE7ookkysFfPr20sQ9sSQQP0vwIy8p3flZz?=
 =?us-ascii?Q?aBh+5KX03lELHGNwFVZX2ymcTIoJXt8ElX76PrYiUSDAUiIeK+S9f2Zvg1/d?=
 =?us-ascii?Q?bLDeY+OZRva3AhoNaL15v2UV4at4+3hPCEe/Dv4WFCE2BXpDF6SkOhKCL9pC?=
 =?us-ascii?Q?g/xbVc83+wPn+MxTnTkONU7Y+hgWj7nBv/Ah8Ys0dcr1hLaRJp7mcCPH0iak?=
 =?us-ascii?Q?SdzpAZLwCSxn+VkubqE33TEXrhAE6W1UPYIrxb/ZrSyQmNcy9AbVmgjr0Dv5?=
 =?us-ascii?Q?4PgOwahY/lbabpiKa/j/xKncQioSDyjvRHL477tET92xviHT5RwPr1KlhsLw?=
 =?us-ascii?Q?Ft3bXDtwO4H6iPFbm1pccGh0fmWYYp0ZuAcH++5IgOWa+vjNQOmjuNmgBMld?=
 =?us-ascii?Q?df8XKdMKU0eHc3iQdWw1y6Ik7u2h5SLCFcv5Ks7zwa7LGLy9BzANvvPbpcHd?=
 =?us-ascii?Q?8MqA8S9DGlUKA9EZ3La0N0a30e6/8yyVDXWJs13WdHIk40M37wVXQCzxRVog?=
 =?us-ascii?Q?3N3+Y+9lI16QQyxSt9JLNoffHbT6hw2sQqrPnd4DvX10RvXfiAEe2wDGR1xH?=
 =?us-ascii?Q?Wtyc/2CoeWDCe0klmqdHB77ClIma6ogTRj1YZey91kYsEdRyi+s+7cQA4QQp?=
 =?us-ascii?Q?rlU23Vt5uhcTriYMwlVY3Fuu28kOAaFSXSjm58JETUX9px5IVf4CT71rD6b0?=
 =?us-ascii?Q?dnDg3DB1686xZ0218B+k0UN3EGA320ZzRAjGVs1oZE42qyYelqGIle5SPt1t?=
 =?us-ascii?Q?Gw1b7Am41/gqxz4AdwnIjhjd6Uo8EgbD90dNJcWl9yvlg/0u/kHep2WB31cP?=
 =?us-ascii?Q?sdfyW8qrG2OsoFtzW/Wav9v91375a6muqLteTywOq9YeuJSys8RUA5OMfCc3?=
 =?us-ascii?Q?KoKMpdqmE+u19bVKo+mOeXT6UTEYaw4MR1he+9XGZSCCAtJy/vBkYMRnM/4n?=
 =?us-ascii?Q?MpA4uQ7jFrYHW24Jx0/rw/MCYmQ6eqoclzgNS+7CQTfpCQMCNh4d2uoKprwY?=
 =?us-ascii?Q?z7Be+vnajt3Xl9kzEXQsV9UOWVhNUaAfwVvrwqfmkWnjDKLPGeuDRYcGcfxQ?=
 =?us-ascii?Q?IOuxYiH35okXkNhPlljB98Fyu477VHB60mWdJhxMPIKdtuZoyqFIP0ix4usE?=
 =?us-ascii?Q?GP42sFwZ3eDKBn4FokoD/9UZpUBXAJ/Ak37lRMJ1n+lI7Yh69BIGBrW+pw7V?=
 =?us-ascii?Q?+nFenTlU7fCN6lRjgDRkczQYzN5tZolRpWr/SPCeIvoeEfA6e+hCyle/1P4p?=
 =?us-ascii?Q?al7Ga1TafMk1iwJr+d8KWZaS9zOEO/p2Tb9hRbWO02OqfMDptc1/TXh+myr+?=
 =?us-ascii?Q?gw8f5vCsHJI+dcqwUPcpexLC0EgD2WYg8vdoBB5sGNCkpxW+Ma/4L+3LX7Fj?=
 =?us-ascii?Q?miXL/3OXlWFMpoKwAmG0oiTS/IPmY0yDLNOWl56W/PGh7Hy05Z1MnBtm7RIU?=
 =?us-ascii?Q?k8dpqCHL3pdHbZsDA78=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b29a0656-9776-42c5-6ff8-08dbdc71334c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2023 13:31:35.2706 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PNXNtXB4GQilfxOnfu3xfHza4dykYGnPdKTkfkWzj4hbkqgydmzEzp13NKAnY0/s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8890
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


-----Original Message-----
From: Ma, Jun <Jun.Ma2@amd.com>=20
Sent: Friday, November 3, 2023 4:21 PM
To: amd-gfx@lists.freedesktop.org; Feng, Kenneth <Kenneth.Feng@amd.com>; De=
ucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYang.=
Wang@amd.com>
Cc: Ma, Jun <Jun.Ma2@amd.com>
Subject: [PATCH] drm/amd/pm: Move some functions to smu_v13_0.c as generic =
code

Use generic functions and remove the duplicate code

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 38 ++++++++++++++-----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 36 +-----------------  ...=
/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 36 +-----------------
 3 files changed, 32 insertions(+), 78 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 281c3cb707a5..1f42befcc213 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2282,22 +2282,40 @@ int smu_v13_0_baco_set_state(struct smu_context *sm=
u,
=20
 int smu_v13_0_baco_enter(struct smu_context *smu)  {
-	int ret =3D 0;
-
-	ret =3D smu_v13_0_baco_set_state(smu,
-				       SMU_BACO_STATE_ENTER);
-	if (ret)
-		return ret;
+	struct smu_baco_context *smu_baco =3D &smu->smu_baco;
+	struct amdgpu_device *adev =3D smu->adev;
+	int ret;
=20
-	msleep(10);
+	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev))
+		return smu_v13_0_baco_set_armd3_sequence(smu,
+				(smu_baco->maco_support && amdgpu_runtime_pm !=3D 1) ?
+					BACO_SEQ_BAMACO : BACO_SEQ_BACO);
[kevin]:

Miss {} here?

Best Regards,
Kevin
+	else {
+		ret =3D smu_v13_0_baco_set_state(smu, SMU_BACO_STATE_ENTER);
+		if (!ret)
+			msleep(10);
[kevin]:
Please use usleep_range() function instead of msleep() to keep the same cod=
ing style.

-	return ret;
+		return ret;
+	}
 }
=20
 int smu_v13_0_baco_exit(struct smu_context *smu)  {
-	return smu_v13_0_baco_set_state(smu,
-					SMU_BACO_STATE_EXIT);
+	struct amdgpu_device *adev =3D smu->adev;
+	int ret;
+
+	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
+		/* Wait for PMFW handling for the Dstate change */
+		usleep_range(10000, 11000);
+		ret =3D smu_v13_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
+	} else {
+		ret =3D smu_v13_0_baco_set_state(smu, SMU_BACO_STATE_EXIT);
+	}
+
+	if (!ret)
+		adev->gfx.is_poweron =3D false;
+
+	return ret;
 }
=20
 int smu_v13_0_set_gfx_power_up_by_imu(struct smu_context *smu) diff --git =
a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/am=
d/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 4d3076fe37a1..d715ca2ec121 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2586,38 +2586,6 @@ static int smu_v13_0_0_set_power_profile_mode(struct=
 smu_context *smu,
 					       NULL);
 }
=20
-static int smu_v13_0_0_baco_enter(struct smu_context *smu) -{
-	struct smu_baco_context *smu_baco =3D &smu->smu_baco;
-	struct amdgpu_device *adev =3D smu->adev;
-
-	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev))
-		return smu_v13_0_baco_set_armd3_sequence(smu,
-				(smu_baco->maco_support && amdgpu_runtime_pm !=3D 1) ?
-					BACO_SEQ_BAMACO : BACO_SEQ_BACO);
-	else
-		return smu_v13_0_baco_enter(smu);
-}
-
-static int smu_v13_0_0_baco_exit(struct smu_context *smu) -{
-	struct amdgpu_device *adev =3D smu->adev;
-	int ret;
-
-	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
-		/* Wait for PMFW handling for the Dstate change */
-		usleep_range(10000, 11000);
-		ret =3D smu_v13_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
-	} else {
-		ret =3D smu_v13_0_baco_exit(smu);
-	}
-
-	if (!ret)
-		adev->gfx.is_poweron =3D false;
-
-	return ret;
-}
-
 static bool smu_v13_0_0_is_mode1_reset_supported(struct smu_context *smu) =
 {
 	struct amdgpu_device *adev =3D smu->adev; @@ -3064,8 +3032,8 @@ static co=
nst struct pptable_funcs smu_v13_0_0_ppt_funcs =3D {
 	.baco_is_support =3D smu_v13_0_baco_is_support,
 	.baco_get_state =3D smu_v13_0_baco_get_state,
 	.baco_set_state =3D smu_v13_0_baco_set_state,
-	.baco_enter =3D smu_v13_0_0_baco_enter,
-	.baco_exit =3D smu_v13_0_0_baco_exit,
+	.baco_enter =3D smu_v13_0_baco_enter,
+	.baco_exit =3D smu_v13_0_baco_exit,
 	.mode1_reset_is_support =3D smu_v13_0_0_is_mode1_reset_supported,
 	.mode1_reset =3D smu_v13_0_0_mode1_reset,
 	.mode2_reset =3D smu_v13_0_0_mode2_reset, diff --git a/drivers/gpu/drm/am=
d/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu=
_v13_0_7_ppt.c
index 81eafed76045..f5596f031d00 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2515,38 +2515,6 @@ static int smu_v13_0_7_set_mp1_state(struct smu_cont=
ext *smu,
 	return ret;
 }
=20
-static int smu_v13_0_7_baco_enter(struct smu_context *smu) -{
-	struct smu_baco_context *smu_baco =3D &smu->smu_baco;
-	struct amdgpu_device *adev =3D smu->adev;
-
-	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev))
-		return smu_v13_0_baco_set_armd3_sequence(smu,
-				(smu_baco->maco_support && amdgpu_runtime_pm !=3D 1) ?
-					BACO_SEQ_BAMACO : BACO_SEQ_BACO);
-	else
-		return smu_v13_0_baco_enter(smu);
-}
-
-static int smu_v13_0_7_baco_exit(struct smu_context *smu) -{
-	struct amdgpu_device *adev =3D smu->adev;
-	int ret;
-
-	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
-		/* Wait for PMFW handling for the Dstate change */
-		usleep_range(10000, 11000);
-		ret =3D smu_v13_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
-	} else {
-		ret =3D smu_v13_0_baco_exit(smu);
-	}
-
-	if (!ret)
-		adev->gfx.is_poweron =3D false;
-
-	return ret;
-}
-
 static bool smu_v13_0_7_is_mode1_reset_supported(struct smu_context *smu) =
 {
 	struct amdgpu_device *adev =3D smu->adev; @@ -2628,8 +2596,8 @@ static co=
nst struct pptable_funcs smu_v13_0_7_ppt_funcs =3D {
 	.baco_is_support =3D smu_v13_0_baco_is_support,
 	.baco_get_state =3D smu_v13_0_baco_get_state,
 	.baco_set_state =3D smu_v13_0_baco_set_state,
-	.baco_enter =3D smu_v13_0_7_baco_enter,
-	.baco_exit =3D smu_v13_0_7_baco_exit,
+	.baco_enter =3D smu_v13_0_baco_enter,
+	.baco_exit =3D smu_v13_0_baco_exit,
 	.mode1_reset_is_support =3D smu_v13_0_7_is_mode1_reset_supported,
 	.mode1_reset =3D smu_v13_0_mode1_reset,
 	.set_mp1_state =3D smu_v13_0_7_set_mp1_state,
--
2.34.1

