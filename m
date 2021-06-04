Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E64C07E94
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 15:30:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78D9161402
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 15:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D9161402
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D1316F60F;
	Fri,  4 Jun 2021 15:30:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C957D6F60F
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 15:30:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuB03XsMurAHVxEThCCnOrb120Hb583oQbQr3G37OtaVGWlTQ9T4jNPKKt8E5F0O4CYPmq3V5CgCbZvpjCYdVpluW7J48Ajc8d4deGTpDQVhHnKmzCQ12DZxgJhbMsxJQz2UcSZ5c1FZm6dSw39wfsb9HvAw1qez4kg0SWPXbRXlaZnN68sH9zRfkdkwBcrpI7mTaxW2pps1vXi2rWix0SLFLYYVY88fL1kWBAtD/DolvUCS/54WtBDXwddsT1nLIZB68SPJXk/zPUfiSRzre2DKGADCqkYellZFZHKimmVXFnaQmLalCFL78XMGAlgN5r+zlLgylDILMkgDNgyTfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdUt+Tv06uROSAdZwGqYcWawFm203n48qUm2Unk1xTo=;
 b=ZZd9Uh1Sfijnn/km4G3LZkKcUs+pmdHir3lLd3Liwv/ar+jnD8VJbNMkWCSRNvNWEvHoKYb+iOgpRSjiuhLRCiQrYPw1B3KzIH+Bp62u/ikAQGOcRftXJieCq3qRohEUoKmCL+wa+b6tgXE+Fws9TjY7318lZ7fiV1TwYhUH7HTP55j9kpmHpHPV8Aan7iQkBZSI5Z4Dic7+SLV3B53tUnMgr6cqfs6xSQ/G/bWD7DqiAVOCVEFVvUtYhfx1dC68yzactNgFcc70zVvsFPC7cylAf2+YPfaOPdJUNx25rTII8Xy12+HQFpskobjPTvufmxQqGQyDYm+sacmdKF+63A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdUt+Tv06uROSAdZwGqYcWawFm203n48qUm2Unk1xTo=;
 b=Crb8ATBTyGUwmfpkrQzPnkHS2UyhBN6kuBVLN34P96bA0Bc6U41KAbggoe/8HP+WG7k8pGWsehRrI1YGLU2i3z2iIytmKNEB9tAXJSkEUxx6FzQJ6mZegz1zJWe6grgjnG+7NwHT3n8s4lKPn577b2H6NAGxBtO2GeRTecwomiA=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4738.namprd12.prod.outlook.com (2603:10b6:208:8e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Fri, 4 Jun
 2021 15:30:12 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%9]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 15:30:12 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Khaire, Rohit" <Rohit.Khaire@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deng, Emily" <Emily.Deng@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Zhou,
 Peng Ju" <PengJu.Zhou@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Enable RLCG read/write interface for Sienna
 Cichlid
Thread-Topic: [PATCH] drm/amdgpu: Enable RLCG read/write interface for Sienna
 Cichlid
Thread-Index: AQHXWVXEuo3SimhkYUGB/LGuzl/Xv6sD+kNl
Date: Fri, 4 Jun 2021 15:30:12 +0000
Message-ID: <MN2PR12MB448819C165F92F52BD69BDA1F73B9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210604152431.16015-1-rohit.khaire@amd.com>
In-Reply-To: <20210604152431.16015-1-rohit.khaire@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-04T15:30:11.582Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6869f26-6ade-4159-3560-08d9276da50c
x-ms-traffictypediagnostic: BL0PR12MB4738:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB4738FE04C96DEC724D3C144BF73B9@BL0PR12MB4738.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:530;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CGBG/+aivItvYtXKGWmA714f7dsDOWGgVnGuHTesCKSo872yJp3r4zWwcIHF9q3dDF9kqDij8azUJ68M3DuWOvAsWSq61kmbk8Pryopis9EO9wAzhXiu51sK9ebuijjbDXNgCFAOv/cMKjAKaoX7/Th3LHG+Q5mJtYvQ9n1JNDbQDxCEDBEymCHJKKeHF8IJbY6j7iMVUYbP0AqHiQIC643p8QA6yV8lZd7uoNQWBem1z1aRm8+AYPmvLRWTQ/AxTilOD8em483lBkgchmYRgmkZH0tgUC8OKSuBMrGvQxyemT6eYlX49w87tjAEfeogC/rdA8dOG0pUoTU4UWXAWFa6tjALOnJ4PwljljR3ECBbrKQ6K8Wp14jTkDmaAk9r5vnKmFg7n1tfGH9/RAjxM2U+GuxlV3HvJvqXzrrdg97voNnWI45UUwJAwxuhkMb9A3um+9/3hRPImX3TenOmRRzm5SVTVJ2cstn6plCzbcfy/VMx3ZGtHdBxCp+v1EQDDpgG9S0tgHaBJfDzkIKik1NwvQnHEcxZMecZSHEncKfO809bgSKpz/u6xbfQjoJ+e5YspsQHJkbpl+IJlbOGinmN3fBkbqUjePD3OEJ5TaPF2WAihZQH60g3x24YnKiyE26TBzttNVLe+AIO7Op3ZudYe1kx1zKk1zZSJ75EDXDkBLexG6DJUKG4a95WorE0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(54906003)(9686003)(8676002)(38100700002)(55016002)(6636002)(110136005)(966005)(478600001)(4326008)(45080400002)(6506007)(53546011)(71200400001)(33656002)(122000001)(86362001)(316002)(7696005)(66946007)(19627405001)(66446008)(64756008)(26005)(921005)(66476007)(83380400001)(5660300002)(166002)(2906002)(76116006)(66556008)(52536014)(186003)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?J7mb5TcfBfgGbSi7pYOgqF0D3noygA0hj0AbDGnGTgPN6kYSCieYDXu6Gv3a?=
 =?us-ascii?Q?yqpGBUdu8JOZRvWajyKP+WfGnjJG6Ml1J5XxyWd80DKKBPF6POh+V+2aja42?=
 =?us-ascii?Q?A91nbdH/86SCAMJGVgMVM1efGprWp26j6Unv1B6udOFxOTjZG9PYkbpXS/s/?=
 =?us-ascii?Q?xmgvAELAWR0F+Fl5M79tMjpTuycY1Ln6PZ/1r8nsjVTukcFV8g8eHGVesBru?=
 =?us-ascii?Q?6QZ2tnfb0yCw3VizN7OMMsCcPd84YxNgFFnBxSiIuDVeEarRi5f0PI2QiTt7?=
 =?us-ascii?Q?7vDwIjWf4iMJRK5ozPCYgbnYoG8tiFd4DBGc7URKviPyl1cE9iRhoA+rsv4Y?=
 =?us-ascii?Q?HXXrEB2AcCkPcq4RhIT4A/6mPdeaTOYSsE4pqy62SUL4DYJfudnfrVr+VBcX?=
 =?us-ascii?Q?cpdAbWZDi73dxwD86z8iPQmzRhV4fTiYMYI1zk00tidG0Wxeveg4uGc7CvW2?=
 =?us-ascii?Q?3pAJ7Xx+SZJq3+T06P3qtPOECsVdjREyIauAa7Je9yfDZVJHsd4ofRQGJmiD?=
 =?us-ascii?Q?Eg31ZXRAZMsbjUfwatIiQDIvmjCrQaJzdUnkCR8dXycT6DIl+P+aq3tmUXTK?=
 =?us-ascii?Q?yk7GorDdxuI/r8agOL446fD6cVmKpHkNmWizDit0dqPd2bcAx3Lw9kSIhCjK?=
 =?us-ascii?Q?ugbEN2EEImptf5W5byFmf1JH8yMGskAolUVrHKyGFJm35oz3nhZo04Qgr17I?=
 =?us-ascii?Q?9+Bj6FqcYO21ezv5cLs6mAdSs6gmCSyn8bmENOOJKOclDBdIeQB0hkbDriEM?=
 =?us-ascii?Q?XCleNgVFRM+wQhArOVmiNz5tsWNceWxtyY5F/UJtD3Y9EsumuZwg349Z3est?=
 =?us-ascii?Q?cMR9PDzY6DORpMN5hucQwKINuAO2oGOo6Gk8sYCMpXeTV+meBZAwoVKknI6V?=
 =?us-ascii?Q?ekIZm9gQDR3CYLeJzlkkYpFtPQWU1WBLGoIzTGgN3+Wz3637cxcdk4vgvZr0?=
 =?us-ascii?Q?FikaNG82Ad5C+c6D7s5TQRScq4tm+8LT6MDIKNX2pXfHfiXBGglstVDOTJp5?=
 =?us-ascii?Q?vSUCMKdbn0cLVKQdeE4vU5Zcwj3a5DD1KlzirOdlcAYQALuaTQ+m2QkOxzNm?=
 =?us-ascii?Q?pZ/wwez6UOMvsO49GQyEa8OyXsiYAoh8J/sHYEumfm8BF++gY97w7lmsK7PE?=
 =?us-ascii?Q?9J7ygmGkXIDMnm5pR2t0ZNB2kG8JgRiQagaavrCFsbwq3c1Z8dO82XiIeYhu?=
 =?us-ascii?Q?VSVY09Y2BS7bSbj89MNiLSYGrneYN6nH1G02PPditHaMdIAlzUsuidvHtoUc?=
 =?us-ascii?Q?VDvc1x9Rw0CpoWOPyPNBSg4E+X35iJ/nVpqCpHaa2P8oggzFOaoFg4xAYKBz?=
 =?us-ascii?Q?5Y652gS4zHt49EzrH7xOfjgi?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6869f26-6ade-4159-3560-08d9276da50c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 15:30:12.1703 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8LEm2A3ZySEo8w62L+Ko7MOgRK0uBgI6agPCseIZ2KxJ/bfxUk9rwt3jvDqr02mz0Enx2x42dANjCJqxUPxBuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4738
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
Cc: "Ming, Davis" <Davis.Ming@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: multipart/mixed; boundary="===============0061143594=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0061143594==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448819C165F92F52BD69BDA1F73B9MN2PR12MB4488namp_"

--_000_MN2PR12MB448819C165F92F52BD69BDA1F73B9MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Rohit Kh=
aire <rohit.khaire@amd.com>
Sent: Friday, June 4, 2021 11:24 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Deng, Emily <Emily.Deng@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhou, =
Peng Ju <PengJu.Zhou@amd.com>; Chen, Horace <Horace.Chen@amd.com>
Cc: Ming, Davis <Davis.Ming@amd.com>; Khaire, Rohit <Rohit.Khaire@amd.com>;=
 Koenig, Christian <Christian.Koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Enable RLCG read/write interface for Sienna Ci=
chlid

Enable this only for Sienna Cichild
since only Navi12 and Sienna Cichlid support SRIOV

Signed-off-by: Rohit Khaire <rohit.khaire@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 4a50c4e9aea0..29017b18470d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9217,7 +9217,6 @@ static void gfx_v10_0_set_rlc_funcs(struct amdgpu_dev=
ice *adev)
         switch (adev->asic_type) {
         case CHIP_NAVI10:
         case CHIP_NAVI14:
-       case CHIP_SIENNA_CICHLID:
         case CHIP_NAVY_FLOUNDER:
         case CHIP_VANGOGH:
         case CHIP_DIMGREY_CAVEFISH:
@@ -9225,6 +9224,7 @@ static void gfx_v10_0_set_rlc_funcs(struct amdgpu_dev=
ice *adev)
                 adev->gfx.rlc.funcs =3D &gfx_v10_0_rlc_funcs;
                 break;
         case CHIP_NAVI12:
+       case CHIP_SIENNA_CICHLID:
                 adev->gfx.rlc.funcs =3D &gfx_v10_0_rlc_funcs_sriov;
                 break;
         default:
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C8cb0fce709d24222678708d9276ce550%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637584170934932543%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdat=
a=3DlI7ogfd1EhAtkxo1eAnPXB1LtGGCcJzD9BmfJ0hLJKk%3D&amp;reserved=3D0

--_000_MN2PR12MB448819C165F92F52BD69BDA1F73B9MN2PR12MB4488namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Rohit Khaire &lt;rohit.khaire=
@amd.com&gt;<br>
<b>Sent:</b> Friday, June 4, 2021 11:24 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &=
lt;Hawking.Zhang@amd.com&gt;; Deng, Emily &lt;Emily.Deng@amd.com&gt;; Liu, =
Monk &lt;Monk.Liu@amd.com&gt;; Zhou, Peng Ju &lt;PengJu.Zhou@amd.com&gt;;
 Chen, Horace &lt;Horace.Chen@amd.com&gt;<br>
<b>Cc:</b> Ming, Davis &lt;Davis.Ming@amd.com&gt;; Khaire, Rohit &lt;Rohit.=
Khaire@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Enable RLCG read/write interface for Si=
enna Cichlid</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Enable this only for Sienna Cichild<br>
since only Navi12 and Sienna Cichlid support SRIOV<br>
<br>
Signed-off-by: Rohit Khaire &lt;rohit.khaire@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 4a50c4e9aea0..29017b18470d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -9217,7 +9217,6 @@ static void gfx_v10_0_set_rlc_funcs(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI10:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI14:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_SIENNA_CICHLID:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVY_FLOUNDER:<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VANGOGH:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_DIMGREY_CAVEFISH=
:<br>
@@ -9225,6 +9224,7 @@ static void gfx_v10_0_set_rlc_funcs(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.funcs =3D &amp;gfx_v10_0_rlc_funcs;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI12:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_SIENNA_CICHLID:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.funcs =3D &amp;gfx_v10_0_rlc_funcs_s=
riov;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C8cb0fce709d24222678708d9276ce550%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637584170934932543%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C3000&amp;amp;sdata=3DlI7ogfd1EhAtkxo1eAnPXB1LtGGCcJzD9BmfJ0hLJKk%3D&amp;a=
mp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7Calexander.deucher%40amd.com%7C8cb0fce709d24222678708d9276ce550=
%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637584170934932543%7CUnknown%=
7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M=
n0%3D%7C3000&amp;amp;sdata=3DlI7ogfd1EhAtkxo1eAnPXB1LtGGCcJzD9BmfJ0hLJKk%3D=
&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448819C165F92F52BD69BDA1F73B9MN2PR12MB4488namp_--

--===============0061143594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0061143594==--
