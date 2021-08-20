Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07574C4320A
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 09:23:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C7A6610E6
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 09:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9C7A6610E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4223C6EA46;
	Fri, 20 Aug 2021 09:23:24 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2067.outbound.protection.outlook.com [40.107.95.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 955566EA46
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 09:23:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSE7qSO5dt6E6TNR7Jj4XEWg3rAxIRS1hgMCimLpvtJsYrkqkXRAfQ1GOznS3SzB9vo3CwKlXRGQmyr0HvAiQMWg9qJfo63OsNs3xbrldpGOaMR66xHrl+H7xKybSme0zqLDcUXLJlgAwycin6elp/LcF/ioeXaiT20/7juM+vn1OphYK9lf2R8VCqAzFdaMwDZyDWzOeeowAgM9RCu/fWhaexT/IsU4kB0lsn1LdHKwuX9G1HE3ET0EyzJ3oSK5gSDo7SBwNU5fv5ocCA93Uh8iTNwIdv6wPiu1rWleLE7cv7X0bcdaQp9owZTbdHIcJFLhzRUZptpq9RkN69x6bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1kDDTfppEv11q0YlCsBgTavnuWwwbEBr5vY2WDMYZY=;
 b=it+osNINMfUEVDo6YisgDnBskwRda6XwQheFFWQ/rJCoJK5PeZ1NYxQm95W85u8+qOowGhD3/eAkZGs1B3dHh7HkZCFz5DYqekkSZDz8lzQ1aoN9vYD3Gc3Hot9p3GaPKnHzA7z58+GyC5CN1keXdYNi83d70u18xXYzDiRXJsfpwgag6h649xW+NFyIOGRdWZsz1AWkfUWlbdV1KBXpkGDa3xGR7dud0gsorJrV5TfWcaVGCy2oYz6sOh54G2648H/fXbPJKpCL0towlTk+ImwCXWi0TSdvPiDM6FWkprzIX8MzdhV5t6CbQhEVU7enIIeco17puj+86nG1KEyu5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1kDDTfppEv11q0YlCsBgTavnuWwwbEBr5vY2WDMYZY=;
 b=VqRjGavXhl6dbJTWnLjpGhfYBUSYohtMe5zpuicj4uiCohvdVLem6khi32qnRkpeNpfJD+QMFTh6QYWLpk1OCR4VE5p/5z9sOzphwqriScppDqSf+oioeeXVwJa2H/RbH5sFWlhJxETQmEYpwafY8kgoq48krlpDMakIM/+7RDc=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB2780.namprd12.prod.outlook.com (2603:10b6:5:4e::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.17; Fri, 20 Aug 2021 09:23:20 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e%4]) with mapi id 15.20.4415.024; Fri, 20 Aug 2021
 09:23:20 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Teng, Rui"
 <Rui.Teng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: a quick fix for "divided by zero" error
Thread-Topic: [PATCH] drm/amd/pm: a quick fix for "divided by zero" error
Thread-Index: AQHXlaIDZIqA5bC5BUKUGLglkHRBH6t8HnLA
Date: Fri, 20 Aug 2021 09:23:20 +0000
Message-ID: <DM5PR12MB24694B7511F297B302FACBFBF1C19@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20210820090104.19153-1-evan.quan@amd.com>
In-Reply-To: <20210820090104.19153-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-20T09:23:17Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=0e40e569-0370-4788-b064-a177481ac6cb;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1f89751-c99b-4360-3909-08d963bc26ef
x-ms-traffictypediagnostic: DM6PR12MB2780:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB27800120C71F18FD714D5C29F1C19@DM6PR12MB2780.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: whrZQpwohUjkOsSK9nhTf98QMTyZZCsBNWGoJgVFdx/OA3qGJYOjfa83kXMJoYucEY/9PO5uwnzr0GcUgRW92qwg6ebWgBTLUbPtL6D3dPTwH9pntR/URb4rRNPAB1BtXK87XU0/jZYcALR2gBMGx8QAuFatBJld2TSbxYrpeEJD+06tAdY7KVllGhezjiTJjiTpB+4siNnv3f152zmZII5eh0xH0NK5Pf+dTzP9OQrnJvIhyUPNs0oajQus13lqhEj5LLb1g2ACqnZDp4rSOeGj2rNtviwE4n/i8EsUyy5lCC8dVkz5BOuSUX19o/r+i1u2p5vblQzxCHVQ0YLUTZ7/qJBuuF6Y4G5OXp774iic0rF/lv0rk8PKjus8TZ0q99Z7gDAOG1VlDiU6QgppquDY7xBgg+Ccam9GeDTSZsAw/tX+4iuUWe8Dp+68M9ivsAOTr7B9rTQKdPRXMejlu3F7A40bGrANKD46UNNB8qUAxK2o5oCuqViH45BXWEyTGyUMCxjETky+6M1dq9429wZmNHO1B0I95J8/RmqM2XiJbhAptyE7ouuXp0oJisiQ2wzW070XgoadGTSo532h1Tunxr3dhZSQt0bNgG+c2KZN/c6oa/Ycv1nEn+gNtwN5H4YHF/1kcIbgefu8yh4dWBCrpJGyPQiRd6REqFv54gAevievlmHQE7kskPuKYUPe6CJdU65Lx64WCEQdL706pQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(6506007)(53546011)(54906003)(8676002)(4326008)(86362001)(52536014)(26005)(66946007)(478600001)(55016002)(33656002)(66556008)(2906002)(186003)(8936002)(9686003)(76116006)(38070700005)(71200400001)(316002)(7696005)(64756008)(66476007)(110136005)(122000001)(38100700002)(5660300002)(66446008)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6B8Ns50KgZFmR0uuBCrpbEBxjavEBdhCAA5ZmUwMN7uIh+Crbz47m55Qfxde?=
 =?us-ascii?Q?XzpPUR9vNAV15uZ0mCAahP3o2dOdUo5ueS8bVqM/Ve7/0yizCLFmjuWyXZ6P?=
 =?us-ascii?Q?Ni0LkSfCyqwHssw+BSfjOv0KZhj6dPdBWpdCbjyrPo1p4Xg62tvc+3xEMPb8?=
 =?us-ascii?Q?GgyQi2cCpwBRikl9eImL+vfFdzryDipjn43fXUPlBI+OQseY0oWZuv9jIJ6o?=
 =?us-ascii?Q?xwNEzam17CQclkJSpDM8fIdiYMOXMOxkg0a4PPTvhMdQDBTzw3x+EW1qm23b?=
 =?us-ascii?Q?e8jVL9zJDeQ9wcA7HRzGC8s+dtBlwmSRSvZIncPjw+T1sDCXjyB0M2ntHLXi?=
 =?us-ascii?Q?CQYCB5MpCpIBHwBG1yz8Gtuyi5T2qZ0CNmqOS2N+Iee7RzWZldl1BVAllFX8?=
 =?us-ascii?Q?SxJDmKbMe81i/YN38scex9vwPXsCUXXOdxlc4FohJ71w8t7xe+MtxHzKh/jR?=
 =?us-ascii?Q?XJm6lh785Vof/jom710jsDM3n0TQz7ungUNmf1ryecHufAldbZC0ahCkDZyj?=
 =?us-ascii?Q?GQlTid/ovA7GowZ0a7V1QX9/ooR4cssntP1zzwGY4CjWJWgHzgogxpJjym70?=
 =?us-ascii?Q?AGL+2O2eM5PZ1vm64vj9NKLmjUCcLJXQ8lonVdp52qV0c8/nc40L6OX9aX/0?=
 =?us-ascii?Q?g55N0dJ4h7uZbZCiZ+XKUPBcHRWNxs633U/jrtH4gN92yVixM2XaAudgI7oP?=
 =?us-ascii?Q?oqe4e6UbX/RvntuD98XkZ+Qp9g3FN0YV7rKKVPv3t5uGFqLqpmHzHrzPacxE?=
 =?us-ascii?Q?6JOuTqFCFWJdiU1XhzEipnhfL0gDK/4fQS6H/N9UPX8ey2PHSkkbKwF4RYSP?=
 =?us-ascii?Q?y3TPxDQKQCxx3FC1ZxlYdi5xCo8ErDLn5rhrzmTfjTf0VnYLQNF5xI3IHNOl?=
 =?us-ascii?Q?Ggbeq/a1PmvK1B14eIBJn0/8FSLgXY3XLYZg+qkf+QA0WuN3Po8e3lyq+MPX?=
 =?us-ascii?Q?5/ZVZc3Poo0tFks56Wr1He315IfJXvLpnOBU+bnytxgCIDbqg2M70aZxxc28?=
 =?us-ascii?Q?XHwIxbMUiugMoH0+PrWeBUToRi7IIVKyG/3rzewqr/VtN8qaZbG4AjGJVxBl?=
 =?us-ascii?Q?qCabU0kwqRmFO1JICKDp3FJ74MyrGJM6uhi+P4zpNfs3PRDakJmhkT3LFsRT?=
 =?us-ascii?Q?GSvRVlYiaIdztNlmJdr+7KuxnsnSPYtv/buOgnwoOp6t9b7XkV82cY+JEBWn?=
 =?us-ascii?Q?cDdnHEtyHuCG+Rg6Ell+Tek16fHvt+woSBq37EtDiYTkdXF+YUxF76V0L4WI?=
 =?us-ascii?Q?ZLgiK5RXk2huovGG7fNHMW2T3+fXj/kNNJe6F7P7/EYnYJ4e6kuuT4nosotr?=
 =?us-ascii?Q?rCIX/Z5U6PkcO9x7+bQF13en?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f89751-c99b-4360-3909-08d963bc26ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 09:23:20.7079 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vPGznCVm4gH+BOuk3UXXQuZzTPcgSGLdmAaBZNtBedlpgpMFved+S6y1pKqZWVvilqymC1R4t7Z7C+S9labIcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2780
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

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>=20
Sent: Friday, August 20, 2021 5:01 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <Guchun.Ch=
en@amd.com>; Teng, Rui <Rui.Teng@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/pm: a quick fix for "divided by zero" error

Considering Arcturus is a dedicated ASIC for computing, it will be more pro=
per to drop the support for fan speed reading and setting. That's on the TO=
DO list.

Change-Id: Id83a7a88f26644ba66c4fd15034b4fc861cc6901
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reported-by: Rui Teng <rui.teng@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 20 ++++++++++++-------
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  9 +++++++--
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index fbf71fc92b16..273df66cac14 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1227,8 +1227,12 @@ static int arcturus_get_fan_speed_rpm(struct smu_con=
text *smu,
=20
 		tmp64 =3D (uint64_t)crystal_clock_freq * 60 * 10000;
 		tach_status =3D RREG32_SOC15(THM, 0, mmCG_TACH_STATUS_ARCT);
-		do_div(tmp64, tach_status);
-		*speed =3D (uint32_t)tmp64;
+		if (tach_status) {
+			do_div(tmp64, tach_status);
+			*speed =3D (uint32_t)tmp64;
+		} else {
+			*speed =3D 0;
+		}
=20
 		break;
 	}
@@ -1303,12 +1307,14 @@ static int arcturus_get_fan_speed_pwm(struct smu_co=
ntext *smu,
 				CG_FDO_CTRL1, FMAX_DUTY100);
 	duty =3D REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_THERMAL_STATUS_ARCT),
 				CG_THERMAL_STATUS, FDO_PWM_DUTY);
-	if (!duty100)
-		return -EINVAL;
=20
-	tmp64 =3D (uint64_t)duty * 255;
-	do_div(tmp64, duty100);
-	*speed =3D MIN((uint32_t)tmp64, 255);
+	if (duty100) {
+		tmp64 =3D (uint64_t)duty * 255;
+		do_div(tmp64, duty100);
+		*speed =3D MIN((uint32_t)tmp64, 255);
+	} else {
+		*speed =3D 0;
+	}
=20
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c
index 01b9653c39c7..87b055466a33 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1306,8 +1306,13 @@ int smu_v11_0_get_fan_speed_rpm(struct smu_context *=
smu,
 	tmp64 =3D (uint64_t)crystal_clock_freq * 60 * 10000;
=20
 	tach_status =3D RREG32_SOC15(THM, 0, mmCG_TACH_STATUS);
-	do_div(tmp64, tach_status);
-	*speed =3D (uint32_t)tmp64;
+	if (tach_status) {
+		do_div(tmp64, tach_status);
+		*speed =3D (uint32_t)tmp64;
+	} else {
+		dev_warn_once(adev->dev, "Got zero output on CG_TACH_STATUS reading!\n")=
;
+		*speed =3D 0;
+	}
=20
 	return 0;
 }
--
2.29.0
