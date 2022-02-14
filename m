Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D86EC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Feb 2022 06:05:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A929110E3A2;
	Mon, 14 Feb 2022 06:05:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7E3510E3A2
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Feb 2022 06:05:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoeI8B5H2XTEJ0iM2LGN0xmh2hpiu5FfEyi7htsZ3ABPF3g06C+YPtITmpeyAa+jYI9FhWd1DmiLRCN/fI3mcNyKnb9Ae44+l3IlBni9NT46scIcLmAQaxp9o1KRrdoKKvPS7LVIqkNOJZZtz5KhJSjBtWpITtC/Y30V4bfoJUBMYCbTszcF5lfswHXqWdU1S37nNYTAX8wiaqAhkyhqJcz4T6Ww3HHmy9tr2spcFwLdHgvL4Tft1Ev6Y+FWe1IXzZsI+4la0JGxYEaq0r/fO7SggzATcfqkwzi2DscfDGIRvtSv7skwRTvKYH9+6UJDP4olS/4LV7Hq5QpNSl2huQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQLo/D8Jr/XMoNbId38h5wuSDHiDsGkqI1yg2i9qpAQ=;
 b=ZZ8PBz+Fn6slguv7nZndPzRPonomkcJUTIK060ozwsZHHzIsaDLeFz+fzRJkzYlkCsCLm7kQ1CHHNgow4EcSeJ6g9Zvxmg8NTSB8DfxB/C/XC4GTalxBom/h/X5I5ehRaEVxIGJDySBZt+BMI8XDLuT4JZQbBBGj+1sWLCYUSBBx81zR9VOapu+GFVrlrhiZyKbDcI5nBz9Z8GDuRyeG+iwoPzLIUFBT33LBtYgbgDmZYA4XvlNocI3QXk2PqOPuwQxuUl7fNkyjQwHZM1rdIsZyASJ0D+Q4QksbSuy6iIShFpqbNCgeftsx+LC7FBnQgYnGkjHh7tH1dMWqbamS7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQLo/D8Jr/XMoNbId38h5wuSDHiDsGkqI1yg2i9qpAQ=;
 b=N8DL+Sj2PbTvPPT5R3RtGMQxavAJiE7gyFjBfQ86Vwn28C3HYOeMVnv4dCwAvGmpjoCxdlIQdGMPoPOWnjNGfN34KgHSHgG/aGiYYgw7I9XSWF3PSetN0rBKQYvWPL5TZw7yOvi+hKaziIec0OVahRYkLbDEJp+qknucAPpb5cQ=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 BY5PR12MB3809.namprd12.prod.outlook.com (2603:10b6:a03:1aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 06:05:16 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c%4]) with mapi id 15.20.4975.011; Mon, 14 Feb 2022
 06:05:16 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: correct the sequence of sending gpu reset msg
Thread-Topic: [PATCH] drm/amd/pm: correct the sequence of sending gpu reset msg
Thread-Index: AQHYIVkP962e8nGp40yetVP2NgEoDqySjtnQ
Date: Mon, 14 Feb 2022 06:05:16 +0000
Message-ID: <DM5PR12MB2469B12DCB74484AE16DD29FF1339@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220214041142.2556519-1-yifan1.zhang@amd.com>
In-Reply-To: <20220214041142.2556519-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-14T06:05:05Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=385fcc32-4deb-4d65-94dc-75a3be497d40;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-02-14T06:05:10Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 547d5cfd-4fd5-40e8-8feb-e69b4e8174ca
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21cf9fdc-fc1e-4d60-f3f4-08d9ef7ff8af
x-ms-traffictypediagnostic: BY5PR12MB3809:EE_
x-microsoft-antispam-prvs: <BY5PR12MB380977B159749475B74D67CFF1339@BY5PR12MB3809.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sfQavCRL2iGqobQ/CL+Nz8/xAaGxUeeLd8FwAUGw16xG0EOPRUy3OWXx2DRLnkOt3GV0CHDTerGT3MPeKfgOsm7CRPdwg+mgKt42a/iCsaDH2b40MY9N9NeP/Av8sp76aTUmsqrnwHTuHZshd1+TqNicVdiXJoMoVKmgcZRYzL5PTUlkPscMmJTX1wfx1dYuXZV0htJGs4OxeSgCAsVKco5PjEpNwZfDfaxIpT883RqVxHH5qnl78TYCP1K4Qf99qo1Nu8jKHDAu+0XYZH8vosnzBgULT/7+PUQUeN7sfynB1tey1upBLe/0fpKruUdG2pr/Bo+AmDsceVk4eCvcM+AtgnckS0VskJwuAygTiH5cOInOMT0dxADA2eAmK8MdXhITZGEF7txeoIEUXKngY4dcVbEt48PIn3bFLJhO+pKxxH5y4U1Xe1BaTDGJEJLNQ31Eoa+eDn1/34X+FDWeea7CKepfJlxF2iKeGqhj2cWXB1l3o8uRg14tmnno7ylKeqIdbQbN6TRtdKpMvn4QMRHjH+zcVL/c06j6aSvl9/Wm6Y/QYClIoBgiIiWOfz6lAzjNtV9BXAhGIK9HBw7IY/Qu/CpI4u0ZM/OeXCvxPbvfxORWf9+DgjmGu6Pk8201Guv6stLYDHbf/mnfREE4WXv6/fMZnwWu1yipnhCADJOgoCBrKEqio6w8nbuqrSab5KMPSjkTsNlpCUP0i4bCpw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(8936002)(64756008)(66446008)(66476007)(4326008)(66556008)(53546011)(76116006)(66946007)(508600001)(9686003)(83380400001)(7696005)(86362001)(6506007)(122000001)(316002)(71200400001)(5660300002)(52536014)(54906003)(110136005)(2906002)(186003)(26005)(55016003)(38100700002)(33656002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UvLynaBDJxGxTd9QbeV6gxxmUcy8xncKbBAa9vEBCuBgY/lyxKY985hVevLv?=
 =?us-ascii?Q?wx7pIrAbzD7AJ5wo0OubL+Awx8/qO4dreQ+qb0OjiRM+ftXheoakJry0pIdH?=
 =?us-ascii?Q?2sR9y82DFM+CsiFqF5fdmGdgk02zEmnkcX9bDbHmNfxMbj+HqqERSt/yPVnx?=
 =?us-ascii?Q?VaxENJZAcfiX2rm31Mf5+g2vmXYMkmCZTzlCHn08ARL3VGq2yzbVk9AIvesq?=
 =?us-ascii?Q?FCvpE54s97MGeUU6iFAuwXrQZzOeZuAfCA8mGIlm5HwEQLq4P/TQxl01QWy3?=
 =?us-ascii?Q?gytcniA8iIF9MUJ64mleeLjzpflZwzw3BQXicqaYX7bXnpcQGY2+cd9S6fAj?=
 =?us-ascii?Q?DjPJmFcelYf/lBPa3RRz7LQWR6+/iptMd8tNvzciJCxbXeHSk9pwpYy6xzbs?=
 =?us-ascii?Q?AKrYglLYiFWlbfFiFlU0+ex3TeEVd4OQt1TMlp2ztJ8VjZZlqAwgiwcYqZoJ?=
 =?us-ascii?Q?JLyQ+fxJFQJJHH4ZQcl9JRugLRKBoWwqMW/RXKF0i2CNuGYJKZel1GE++q8G?=
 =?us-ascii?Q?3CEV3fr6EKejFe/kzlz4Pc3wHxCJOOmVy4dXs6XMm4RGu085mnK+Ul6SBGyI?=
 =?us-ascii?Q?7n5KBQa1pNxq3zSZArnxBje/xwSpoC/XKdoM2IlfXCaUR7jSzvCOZoAKiKPu?=
 =?us-ascii?Q?MLjseRGHWMV3mb6z73/xFWsPScGf69Y3b3QRVFm7U6uOdZ0WHdP+1m/OW+yC?=
 =?us-ascii?Q?/KBsIwueiGYGMzW4D/ogmm60/rR6W6GsAXt5I9b7J+pjY6WetN5P3J4UWMak?=
 =?us-ascii?Q?BwZZfPGE3/5SGqzlURY16LX7a1ny1wg6+37sv7UsKJv1XVrcgJ5pF+7VrpKJ?=
 =?us-ascii?Q?Y5vVl8BwlDd69EMyiLV1WerGlaE97L2alr47xiRRAyoFTlnKC5JgnUAapqUO?=
 =?us-ascii?Q?/POYfWg8pmCL8VBcjzz7lfccCQzJ7OcuEw7DoGBLzFv6MSw54gfRzM/ljbtV?=
 =?us-ascii?Q?29oU1q8dnD1VEF3mVB0mG5lVevN9yb+whhBXF108ykdpnmtA442wyaoHWDDb?=
 =?us-ascii?Q?knyjcQ6Y7whG0iWK6UsKnBk1ZQywJAMvhW4aOiQ++5EcpZ4F/la+HolsxtZ5?=
 =?us-ascii?Q?aF94a8dhcP7IB3fktqOBObMZdNr//9lTKWY91tqHoq/qrauSpfKAVKVL/wfI?=
 =?us-ascii?Q?gLfyGH071bZeEV3J2yf2s3Rkd1Jt3dFeh7PF/w8f97Tr5/yZbXJtFGv6aoIv?=
 =?us-ascii?Q?mmslp+uT3wtnpStFdOigHzEv4D2yA+nUKRT3OlPksRMEnnHh56+BQ1Bj49gt?=
 =?us-ascii?Q?Swd2IrY/ZxMyrrXdxr/WQpr3j5iGUfa8/BC+a1CEvlYc5T7OI13H3b1nCraN?=
 =?us-ascii?Q?N650EACinZmq4CnRkrGHFlBFAUxJSP9+ZVg8j2IBNIP4DbnSJ0p1IRf2x6sn?=
 =?us-ascii?Q?CApON3Ta8DUNb9CJBA47rACiFyyhEN5rsocJbWXgYKGOoFjm0kg3vMaGx2FV?=
 =?us-ascii?Q?1GtNcl5QSUBRSB5w0AwW74atkix5HLIKtSztmd8G9tp7wPiYftVFDTrrLiZM?=
 =?us-ascii?Q?uT/hNLRWAe4sYrevJETzrBt3QHJ8eBTqZq1Zoch5m127uqT+97gGKqVIWJhR?=
 =?us-ascii?Q?vQC2jg4/G3YdYylPcTJ96WODW0QQG36fPjcXeXhugzkIKr0Uf4hI+JkFsTge?=
 =?us-ascii?Q?ZrNTKzzBk+PkYoWLsu8etjc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21cf9fdc-fc1e-4d60-f3f4-08d9ef7ff8af
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 06:05:16.0395 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: St6RsQgxD+A3XmjK8b1ElwuQx7ZVQlmgXAD2Hu8N2+aG0SP3MZS7fzjYwkqm/Jm/se7cpMwvSEJHMPfyQnA1HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3809
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

A Fixes tag is preferred.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yifan Zh=
ang
Sent: Monday, February 14, 2022 12:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>
Subject: [PATCH] drm/amd/pm: correct the sequence of sending gpu reset msg

the 2nd parameter should be smu msg type rather than asic msg index.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Change-Id: I0a65fac53b06c053ce193580d68cf586e77d2c2d
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index e90387a84cbb..e2d099409123 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -262,14 +262,9 @@ static int yellow_carp_post_smu_init(struct smu_contex=
t *smu)
=20
 static int yellow_carp_mode_reset(struct smu_context *smu, int type)  {
-	int ret =3D 0, index =3D 0;
-
-	index =3D smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
-				SMU_MSG_GfxDeviceDriverReset);
-	if (index < 0)
-		return index =3D=3D -EACCES ? 0 : index;
+	int ret =3D 0;
=20
-	ret =3D smu_cmn_send_smc_msg_with_param(smu, (uint16_t)index, type, NULL)=
;
+	ret =3D smu_cmn_send_smc_msg_with_param(smu,=20
+SMU_MSG_GfxDeviceDriverReset, type, NULL);
 	if (ret)
 		dev_err(smu->adev->dev, "Failed to mode reset!\n");
=20
--
2.25.1
