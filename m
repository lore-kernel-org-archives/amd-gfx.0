Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3E4C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 16:26:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 710C610E328;
	Fri, 22 Apr 2022 16:26:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD8F010E328
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 16:26:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeDPnPJNhfhA+4RSh+PdeWzr+7U6TjMndaLsdbu8EONsBvviuMkQbeRgFSm9qTJD4QL5O/jJyTtT9InMRPpRZ1lX4Sqo5nPvXTnsGNlSyOpNZyQgZI6t2Se6flhf9HYZamU1VDST8Ei+CZAU9mJitBnuamUf64vkuVNjnKTOOn/Ye/2BI8NdFlgFt8rWowD68z01u86mlg2/YpJ0TZK+mEutjanhXqi2usRe9cR+bGOGRtZ9k3I9q6TJwIckXar9hgor/LthfOR8d+ptSpNKU+m8+i9Bo7IqRuJojz0WEfLxS9VXDm4RxrRMxf5ra6rHFGx3p/S7pcC8YjIGR4yTSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWSvT7ihX7afs9wK+HVXUcTdzQXk7sHKiNLfJ6XYAoE=;
 b=SkwI/A2XO3oxS6Xx9dx0SPOVsTjds3iq+EwnkcKmY8J8eCt4u1iyfZ8V+R1hi5W2FoK9gGl/KOgvc0cOJcC6qvY8OZSsTg4seatE6JQae0tW6SFKxhcNXFiuWoNz8SjPgoI0D+z9S9J93rgNbwcJzpZ9rD9fSljEW7hcvnwWZ8ChcoVmXjKug9cghFBX2mIBCRVspRNoJ8KPb3HrpEpA0A6Dq9VPOg/5d84+wfJofF4RiRty0M6ODZNxUoWC2S9nIg+6QBFnCNG3NEgJtOtoEc0yvE6cc157g1xU2l9/8PbrQhi/BsGxKVdtZTg8VaVMcAqSt57PRHIu0T4h3k48CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWSvT7ihX7afs9wK+HVXUcTdzQXk7sHKiNLfJ6XYAoE=;
 b=Hoz3BP/LHnPHGmgm1VGG8APmXye3jT7oz8dnRawwA1Io6OKXhj6cUl7suMA0I6cF50ZNgx8qG8LoRVRaBExjMlwrPqpuTuod5/gdi7JEZijRhgkKrodaviwty70/7tWnaE1StpNeMJ9uRqJg8Q6SaY0rlvYRKV+3ET0Ewah1Np8=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by BYAPR12MB3272.namprd12.prod.outlook.com (2603:10b6:a03:131::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 22 Apr
 2022 16:26:05 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::8da2:e9e9:647f:df81]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::8da2:e9e9:647f:df81%3]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 16:26:05 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Yu, David" <David.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Ta fw needs to be loaded for SRIOV aldebaran
Thread-Topic: [PATCH] drm/amdgpu: Ta fw needs to be loaded for SRIOV aldebaran
Thread-Index: AQHYVmNMeMoOYWemHUWxdsQZTJeNvqz8GnQQ
Date: Fri, 22 Apr 2022 16:26:05 +0000
Message-ID: <CH0PR12MB5372496E4D5395D55019D52BF4F79@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20220422160848.4819-1-David.Yu@amd.com>
In-Reply-To: <20220422160848.4819-1-David.Yu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-22T16:26:03Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=7c66f392-2d8d-40d4-9839-84ac9f13046b;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-04-22T16:26:03Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 7513bcba-697a-41fe-8d40-10b3f44c6cd2
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47ff5632-8820-4b95-7701-08da247cccd6
x-ms-traffictypediagnostic: BYAPR12MB3272:EE_
x-microsoft-antispam-prvs: <BYAPR12MB32728B281DE6731E69A5D2A6F4F79@BYAPR12MB3272.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2eyN0nxRPVIAShsohqLsqLiOHemCmR9an/NsZSpTxOL567QZcW2CR828NLNXmFzoD/sMkG9VP5UFbJsrYf8D1jEoaXrXI4CI92sBaWZBzgLEdSpa4HcwYcWzO9O5kkjnl/xtcPYdIyvigX8qzlDpZWiidLC+n6sY7vbkUjrvk33Cowfvq9O4kZpTszXYZOpr4tem9zr/ZzTqJJ5nZ9NzcapSJLOH0FrWizSuFeyT7eaV+d7YehTv8E2tgacm2vpADlPt7cU4u2lSn1OmIxTS5fygVo3YvpbvaZ3odOjgz8JdWBL+EOarTIQ3YaSH/DsKiFSuSt4KoZAX1MP9yZWlcKX1hTySHrxzKZ7a/kybLvYHP/edeqxXqV4t3EMKOJjN6Z3u4DwGsnND5XTfAjccN9zQax/5y9c6Qi1NYYJLiu/J+TggT3avEFZIS6a+tTAeXuge5UsgFWMceqalN79SmPcDXqGGaoAtk4yMFoNApl9K0ZI9H2e3j4NAnal3BDSX24hbF7O0fIFEnnTOR5l1jP0IWLgQcIS/iNWtejvpakkJ0SIxtK9cZz/5YIwn73qmMLXL4watq6FE+0Gg6+iINp1gBGCYD+4OA0++bfVLD19N0xVCo9tMD+C8YjqJZe7hud6pllEwO3myIN0vJ2XLjW2HHkQSYKje+m9Ttq5w1IV8vlbuA4xThBZCZWJIO5+ssMnyJVSDe3KW+BFomfnNug==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(64756008)(186003)(66446008)(4326008)(316002)(26005)(508600001)(8676002)(110136005)(9686003)(7696005)(53546011)(86362001)(33656002)(71200400001)(76116006)(55016003)(83380400001)(66946007)(2906002)(5660300002)(66556008)(8936002)(66476007)(52536014)(122000001)(38070700005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gM18+25bAaFzuT2VqyjluWkLpdJCA8H8fnT5v5PQzbMElV53QLS5JbOLtZhq?=
 =?us-ascii?Q?Dli026LNZSN04/mGcDbsh5EWmzj+aEFRyGOdczp4bjKv9s/cLP0mz7QRXnUr?=
 =?us-ascii?Q?7yblXuSdj/AP+xVqJKfRdOM/dpP1ybs8kqY05ZeoYjunx/pokmIbdzDLg6JJ?=
 =?us-ascii?Q?Y+F4c1PucZ5GL60MdBfLVH/z66wlnen8gM/YuBz1KMgsOX1YBIBeIKDMvhal?=
 =?us-ascii?Q?YILKrr4vKqU2gKxj+rSPEQkdmGbhijmEiIYCsdKSJ7q0QKhTQWteDAbj/yAR?=
 =?us-ascii?Q?kdvSEyKQ24KlkqEyCsxxO0xMWZBg62SyehMM3SJ6rtmee788rzew/IyrGzff?=
 =?us-ascii?Q?aSN//tXWSMdjArXkHTEc/zdx+PuNEw5TkZRgbC+sWpx0Ja/KJlDW4lC/g0Rs?=
 =?us-ascii?Q?acriFV6MJ0PQKeWKuP6ATpqeSVFAQaMS9elJjr0xSzpkuwB1dak5z+/fAcwd?=
 =?us-ascii?Q?qNM9RfA5C2vWlCiBs/nb8HoJZUMdzqBFHGnTOL/Zz1ktRzy3YYSsSYhLDUzX?=
 =?us-ascii?Q?g8janTk4Mfnr9XM5s6I+6ieMi17g0M81aIQbzT9SFEu+Rhh2X37d22N7BwS4?=
 =?us-ascii?Q?9TvdFjcjph8Aj0QJLSaBuwAwF041bBo8L6/ONl36gGSA5xRIjIkcLFa8hFj5?=
 =?us-ascii?Q?xwiYwyYmW2cdB0oTGiHUT8dYl/nzyfE7XedSZwTCg9RB4clBbuyfBZRvFplR?=
 =?us-ascii?Q?c4tK/+81OKX+0lg4hpfaZq+rZss/Q4GNHtJLiehWseL/yG0srXA/rIRXvQNU?=
 =?us-ascii?Q?c4bc8eW+MMO9uLqmbhDN67TU1gZENNrgqcs0CsZzAmbnbF4cBLjM1lCIPvO2?=
 =?us-ascii?Q?pX4I1kjIH36XJ5PgYYu4YXA4y/7Jl4laKh3Ic06B+MAWN6owtjagoQ9bWfzw?=
 =?us-ascii?Q?TgaObkyfhNSREHMbYLsVyemFgrf4znpdKMAye6Ci0Bd3Cxt8F3kPif5GBFrK?=
 =?us-ascii?Q?I1zXHObdisA6cYrDxZZONWDD6MH9QEqcefeJaGjGNFvcMxFTUP+UgsIEHcBC?=
 =?us-ascii?Q?goBL5ckdagiIZU2Ym4jmdhoezPJMpfWK5MUI8kadX+6wH1SfC6dQIioi0afG?=
 =?us-ascii?Q?P8M/h8HQ/dcqpngE8ig3P1jI4NZnlC24Kz8RwkUqQny6kHh1mb7Qhc5DsK2x?=
 =?us-ascii?Q?mvSvYdjC9pHzLh1O7mTnohMrsrMdMFVauPEXyDvQYd30n/n1Icysilyshm36?=
 =?us-ascii?Q?XY2hwSBZVJgTmc4QMg5p8zMF5INdgshFtUr+vHYgKumGs2nJlmhYrs4L1JhV?=
 =?us-ascii?Q?Ycs4atAjzLjNFs21elG30h5ab4RN/hkG+vc+e2Ixv28oCvUYMS82rTb10JJj?=
 =?us-ascii?Q?PG0FKwcodqfaQkLWXfZa7c7Gd/sckcOGUWJErBMr20YZE1O06XRE8EXoWCl6?=
 =?us-ascii?Q?S7GLKVniI7gF/RB5OpNV6S47UCVyPw+ltrlsn8WKvcIHqCCLB73xHR1tK/+U?=
 =?us-ascii?Q?LGomdsyzlSGxieoAkBdTSiVUDr0O3swt07+12whq7yXCpufFTZPavIX4kwZw?=
 =?us-ascii?Q?XWPN3FuAl63Lnc+1U+dqNuAUKbebgxJxSSC2HTY6zipwRuelBEl707F1TMS3?=
 =?us-ascii?Q?HlsPW4xw7HWO7o6sWxIxWJqxZN11HPjdKqUdouqLsfnrXqkXMSZ2Q4yVDiEW?=
 =?us-ascii?Q?/LPM7Yd5myNQ4+G7dA77p5YhFQmPWwTUUSxScOwalzG4RFfEC2/lvuJJDt1C?=
 =?us-ascii?Q?GtLAHCYplJAuUbyx53j3JpP0EWuFPR365l8hgu3tWodkbaxm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ff5632-8820-4b95-7701-08da247cccd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 16:26:05.7029 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xTY5ynVsp9QsEkXxwsCT0quD2wRqr2apvsZF8+cLeWgT67RSm3jE3x0gtAJNHckqpwnWZvqdxejU6tWjIY2jxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3272
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
Cc: "Yu, David" <David.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Looks ok to me .=20
You can  add  reviewed-by: Shaoyun.liu <Shaoyun.liu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of David Yu
Sent: Friday, April 22, 2022 12:09 PM
To: amd-gfx@lists.freedesktop.org
Cc: Yu, David <David.Yu@amd.com>
Subject: [PATCH] drm/amdgpu: Ta fw needs to be loaded for SRIOV aldebaran

Load ta fw during psp_init_sriov_microcode to enable XGMI. It is required t=
o be loaded by both guest and host starting from Arcturus. Cap fw needs to =
be loaded first.
Fix previously patch that was pushed by mistake.

Signed-off-by: David Yu <David.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 895251f42853..0bd22ebcc3d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -275,8 +275,8 @@ static int psp_init_sriov_microcode(struct psp_context =
*psp)
 		ret =3D psp_init_cap_microcode(psp, "sienna_cichlid");
 		break;
 	case IP_VERSION(13, 0, 2):
-		ret =3D psp_init_ta_microcode(psp, "aldebaran");
-		ret &=3D psp_init_cap_microcode(psp, "aldebaran");
+		ret =3D psp_init_cap_microcode(psp, "aldebaran");
+		ret &=3D psp_init_ta_microcode(psp, "aldebaran");
 		break;
 	default:
 		BUG();
--=20
2.25.1
