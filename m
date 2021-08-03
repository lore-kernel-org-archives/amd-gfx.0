Return-Path: <SRS0=T22W=M2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1786C4338F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 03:17:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8918A60F94
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 03:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8918A60F94
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CBE36E0BE;
	Tue,  3 Aug 2021 03:17:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E58B6E0BE
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Aug 2021 03:17:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTam6QU0mrckRVE458iLhS8FZktXLPaP2rwulOM4Q4gp+2JQj1EY5fG0k927IaRPR5IVRPzhdJKNWAUK7nWJl9WOp4qSVWZzgkWpk17g2G87EYABx9nP/WY10M4G7TWQ/fF0wXg7zF4CqAtlDKYENT4Ws4TFNj5d+UqlxJbMRF6Y64+r5gNutqwwBjLGQC8DSXdzxdFXK2zz6w4DO+Zvt/wmR29GHCutvItNT7XWU46DK8uquGxJXcG7+dwcbsO0BJbuGiFbK9JMoHt9KfnSltfRZwTF1sCNCwDoUfYYJtQ72fWx/37ODDGEffEgqX2RU/Vlf/RjZcBNFTaXzb3RsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRbJJ/4n41mluBQcz29kIPCAKay8Gt9SYIizXKH1+e4=;
 b=nLE0JtH0YbX9Sd1obPrLfDLvK2aYcyBaSNevhHPgU5QNpkbz9BVCn4KIgYOw6/FXyjbGddy0wojcNDBSA3DH2Xv+v92Ai8j5n5B8dsGqsgi1j+DWrAbbt3DXDZmoWLo7piIeermG/6OhwLfvDfrQvaU+bJuIVP2kYRu9g0Bkc0a9tn6uH1uSrNAFp+lXJRMywMpwkOan04MqGAJSpzVF5Cs/GIDkjShx7M1OAf2G0HvyfDJ7/VRxAhwudWpKP8YpvjEizQtZ+J17S7P1/ehlLs5aHiVty8ciJchPVU7HrwH16AbNWAnv2YO3ZY/dg+Q9/935FxiZDQLc4hFx5f1RhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRbJJ/4n41mluBQcz29kIPCAKay8Gt9SYIizXKH1+e4=;
 b=3TVp4yw++2Iokx2BeCdAHBtQ2NlWfjNRqWB+kcDTvpIZsGWbeIPcNlsVXubsmAOt/uqA8EfDqxCFqRYax6keygMvhlFm5J0sb8/8b4BLzkDbNkjBKMrkwXjuB/jMMLiCayM+R+lfbVxy40aox2QRpL4KfbXmGtLw4A272y987Jc=
Received: from CO6PR12MB5412.namprd12.prod.outlook.com (2603:10b6:5:35e::15)
 by CO6PR12MB5460.namprd12.prod.outlook.com (2603:10b6:5:357::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 3 Aug
 2021 03:17:35 +0000
Received: from CO6PR12MB5412.namprd12.prod.outlook.com
 ([fe80::6db6:e154:cc28:112f]) by CO6PR12MB5412.namprd12.prod.outlook.com
 ([fe80::6db6:e154:cc28:112f%9]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 03:17:35 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Hou, Xiaomeng (Matthew)" <Xiaomeng.Hou@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Liu, Aaron" <Aaron.Liu@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: update smu v13.0.1 firmware header
Thread-Topic: [PATCH] drm/amd/pm: update smu v13.0.1 firmware header
Thread-Index: AQHXiBX6Sx4JHp7+r0ubhUd0GX7d2athG/JQ
Date: Tue, 3 Aug 2021 03:17:35 +0000
Message-ID: <CO6PR12MB5412B9005EF03FB51C379006ECF09@CO6PR12MB5412.namprd12.prod.outlook.com>
References: <20210803031559.18025-1-Xiaomeng.Hou@amd.com>
In-Reply-To: <20210803031559.18025-1-Xiaomeng.Hou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-03T03:17:32Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d2035e0e-964c-4468-90a9-7e5c9534337d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8297cc25-8ce7-4ba3-2116-08d9562d3d4b
x-ms-traffictypediagnostic: CO6PR12MB5460:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR12MB5460D087DCCB54CC5C36FA64ECF09@CO6PR12MB5460.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:386;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XWe6kPLBN5R5CCOQ+4YiFUAVxg3dOI25TlSauW3z4dbZ2cScbQ7s1U7vnZnPKRDHBJZXyVW5mAZEZtVLRPlqma4hucNy0Oh9MmHKDdpdM7Sv8THQtYpsnQGkOOHik7e2jkvi/ODbwqfs/xoMDDhY4Em7LRl8niVjljZBlOH1gECywGKrFmMv8jvYZD2oVLNLD7nAQqODINUpUQLmxkoVZ5opN7HRAU72j7sshe52QvLGnRRaFlKXJa7Tqj9D9koxcuOpBNQGakfmDgYO/OvcQP7uworEI1vfrinsKb3xjq9voWVd3X2QJm2oy0G/NgzMi83NJRSTP04r3+NV5jkjxyKnk2tvC01Car4nPMi/pOS8SPch7040HALxEVhyieRfGPxG71d2k+WopzhjNi1lz3cBluK2UvX8RgpUS+N3QDHtksL34nWWWbe0AZ3Mlhv35Erv5WEhBSYYVDZELRKnI/sryRfmYDLuFKRqt7UGUPS0XVAhXlPZp5Pf/pNsSPDKVwltuoIKtUWnzt3uqbwrT/QlvI32k1oN1jif7EfJzLXyDyPPEeklnlX8UP9pnk7e5Nf5FORgiCE7NZ5FM9X1mBSCwOztluytpirvmzdKvoECLtyzxluA7db3xfaQ6nLBcIwScYaQdePz0gEPs3zAgwrJbb9XEzaivxv0k1/taEct5Btg8+44l4NPay/Nb6+yQINQ6BttJ4GIEz8rmWEY7A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5412.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(38070700005)(66946007)(66476007)(15650500001)(52536014)(186003)(86362001)(66556008)(54906003)(110136005)(64756008)(26005)(66446008)(53546011)(6506007)(478600001)(33656002)(9686003)(2906002)(8936002)(5660300002)(4326008)(76116006)(71200400001)(316002)(122000001)(19627235002)(83380400001)(7696005)(55016002)(38100700002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YNkX5l0S9JUVyfpQJGhlngKXUraBiKTm1zKViNTWk00wsBKtoHpBPn0qC1pE?=
 =?us-ascii?Q?djkk+1srhTUAxY22/Hn9At/3Hjc0v4Px6ouA+VT0HPzS9hqtbilO5IAFoUeF?=
 =?us-ascii?Q?GEH+T21kDAQMGLtFRLpemn4kVHPZUMV5Gh7dlKhGp5+vKodh+cINHEBTpLiH?=
 =?us-ascii?Q?T0v4RWpWsvgOy9cEjVri0+uZ3NTjjKEExLvTjlGQTuSnhVDzDrSZMW9DG64s?=
 =?us-ascii?Q?ZA7tjZaCAOKwOXjzko6FLo9S4UgaN3Hz/wEESSjkt5paIjy5sV7QBuWWwSfI?=
 =?us-ascii?Q?NkFyetA8Rhy36mFTDYY8swLOHluBHAn1kn1qwEeaAtuVE2ZRq10GJokQ4WIf?=
 =?us-ascii?Q?zl7ckbEyU8xQ/qLwSGR93ZVUjejhExgDVJ4aJn7PM4ZzWAlUvtZTijMBiNLJ?=
 =?us-ascii?Q?a06vbPhGIPXqyUp5wNgYE853gpL1zMEo1puU3rVsm8fn33pB1hhtqR2asVHI?=
 =?us-ascii?Q?zAADxN0PFt0cVm1IWNWpZQ2lyTO38CPeERK2FUjDJankKiO+9HILvjiCSzzj?=
 =?us-ascii?Q?vjedTGhb7bUfwfG+RZzNeoanKkIsm4Q04VWxOVn5jxDfD7lINc+BHJQDxik6?=
 =?us-ascii?Q?flyW4zdp5w5+QM3sFGZisu7qelWiLeLJgbhhuLuByolpgtbC4tuKfjfHYpdo?=
 =?us-ascii?Q?Fri6Mo7S+bUbTwsWqdK4gOw6rcI2+HV5aYIWkGf3A6l5MEgCBNaVFrplQLzB?=
 =?us-ascii?Q?zoNrHvkQZTBfObVEcxY6Qr3bPMgkrHtZ4nk7ta3tJ9lCCrO09r7W2jJe4Neq?=
 =?us-ascii?Q?OXM2fNpZAOARYJaBZNKyu9rxr5M2CzSwmoc2yWeODf9z6/ahW8nOY50Je9IS?=
 =?us-ascii?Q?vdG/yZUeAzxrPG2uVGTqH1ZcY3rsTAEpK7AHTWEJ9GBVniTzC24Nh1nlIoL9?=
 =?us-ascii?Q?Yrrkl1vUg6RBCwLjZKMxdcVCeG78jJ060K0eP0Uuz1CZbMXcNlnlVj+00OR1?=
 =?us-ascii?Q?3pcheNelIWvQId3aO6+RxPC/KjhSjSwQ5feZKJR6f+sCmyhbUa9e466FsqkL?=
 =?us-ascii?Q?NjxeLspyXKs2zBo1ZL+lXQrm+ebNREHNC4nsJ3ToVmY4K2gJX3BEPPHz/smx?=
 =?us-ascii?Q?Tat2E2XiBeLQJvXUPubqF9bbekw+kWdAZsUhzzqCk6XDfgY5PWNNatpYHwsm?=
 =?us-ascii?Q?CJOQoqTwii+NAxbL4E8tgvJa4EajWHCo50hNsEwThnIi/6C1f4KEjfeRXKqb?=
 =?us-ascii?Q?DMNrR77rNiMaDleCncJoLrR5xCmGQbbOaAqiybrMq6f+eVzsgzHNMGqrNPjT?=
 =?us-ascii?Q?NOFIdkwoeqa5F6Ac4ukR7t6/mI/+zImBj4Xz2wcPHWq1b2FcjmgdG0+RzCdR?=
 =?us-ascii?Q?RBxun7E6wRzRJxyqDXL46+9C?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5412.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8297cc25-8ce7-4ba3-2116-08d9562d3d4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 03:17:35.0481 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OOaNOhGu9tGvf4FxMluN0TcIYe8aWghKpuDZLsxT5ly67aQ66qBEzcX/kzF380Y/PinrFwDOKeQVRZBCB1Xbnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5460
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

[AMD Official Use Only]

Reviewed-by: Huang Rui <ray.huang@amd.com>

-----Original Message-----
From: Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>=20
Sent: Tuesday, August 3, 2021 11:16 AM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Aaron <Aaron.Liu@amd.com>; Deucher, Alexander <Alexander.Deucher@a=
md.com>; Huang, Ray <Ray.Huang@amd.com>; Hou, Xiaomeng (Matthew) <Xiaomeng.=
Hou@amd.com>
Subject: [PATCH] drm/amd/pm: update smu v13.0.1 firmware header

Update smu v13.0.1 firmware header for yellow carp.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h b/drivers/gpu/dr=
m/amd/pm/inc/smu_v13_0_1_pmfw.h
index 5627de734246..c5e26d619bf0 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_pmfw.h
@@ -111,7 +111,9 @@ typedef struct {
   uint32_t InWhisperMode        : 1;
   uint32_t spare0               : 1;
   uint32_t ZstateStatus         : 4;
-  uint32_t spare1               :12;
+  uint32_t spare1               : 4;
+  uint32_t DstateFun            : 4;
+  uint32_t DstateDev            : 4;
   // MP1_EXT_SCRATCH2
   uint32_t P2JobHandler         :24;
   uint32_t RsmuPmiP2FinishedCnt : 8;
--=20
2.17.1
