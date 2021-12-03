Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707F4C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 05:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E871B7300F;
	Fri,  3 Dec 2021 05:47:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EFB97300F
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 05:47:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkpXivwHJwL8FJ/TUuK1tpoEaAXB8kNPNVtAPPaM3fs8yXYD5367aB9P9JSxyPMD0ZTMP+B2zdxLsvtkKxuOi6YgWmIWE9Q/PePkcMXrOw4dhlV/48EcMpRhwtG0+ZTzY2sYEEQ8D5Mxmz3vzjIiEmO0cUpE2m6uq5BBvx8G77onU7OYo/IqOHnOhsycURG2ivXjzl3fFhvaFr/PqIfR9PmPwLuYCdAwagPj2/JoC/tNcOx3tHQwN+rnN28i/OjhSPtCOkRTpsvOrtlqPOF7jcGm2/gKqqhCWkpxC9Z46wciA6++doBxPn27G7uHXdtC7MnJB/bIVOFi/9/yqWMpkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8EKWZYuH3Bz+ejExx4dPU7L0hZmmdWeImmdgGKynZg=;
 b=NZK5dwBYgiE5qNwV7pO+oMx0e0DfNupeFCJR35o8yeA8VGLCnC8LzV/4MbOudEMlx9esmSRLxP6Y6eSn4qksmfsxZySDzPHrCO9VCYvwHjqSv+Ykjiv0DJQhrAerFpoDtqpZvYZuY9iC1+dAWmBumvlOQNuym3CptNKD5eC8Q1IY/5bLO3fJ+rwPwI05vESf2h2y5I5hQTyfS28xD8ak9CZ8fKJV4SilOA8wxCjdxsA5PqQ9Xkt1YuGcN0kLyx1zTHXrtLLVHH3/4ccgJ/4pI3VWuNlADGsjBEjXJqjeKss2/2iW2hiIvhyB+PRVtTIsdts6/gUtTp+Uqv9Sq8ZQBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8EKWZYuH3Bz+ejExx4dPU7L0hZmmdWeImmdgGKynZg=;
 b=DZ7lfUOn+75W6c0NEL93BKyHk1+wFejYTv0x8QWReJGuQkxJyf4nxmmEspWY3q262pPcNQn4oc2P89VW7fPH9MiaeChmZDJipmip6sVikhiMjqR4wX1ysMdg7Pe573AeAw6cbaxSHVlmg7nU5U3XamqRkHLbUM6yzzMdC6z1Qh8=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5195.namprd12.prod.outlook.com (2603:10b6:408:11c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 3 Dec
 2021 05:32:34 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::2919:f0f6:40a9:e1c0]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::2919:f0f6:40a9:e1c0%7]) with mapi id 15.20.4713.029; Fri, 3 Dec 2021
 05:32:34 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>, "Chai,
 Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: only skip get ecc info for
 aldebaran
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: only skip get ecc info for
 aldebaran
Thread-Index: AQHX6AbHR+E/g9FctE2scuAmzDP266wgPhVQ
Date: Fri, 3 Dec 2021 05:32:34 +0000
Message-ID: <BN9PR12MB5257CF401FA707712CDCF1BCFC6A9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20211203052938.7448-1-Stanley.Yang@amd.com>
In-Reply-To: <20211203052938.7448-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-03T05:32:29Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=0d48a039-c2ce-4281-ad81-19f4cc84c530;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b41f26f2-9392-49a0-70e2-08d9b61e4f21
x-ms-traffictypediagnostic: BN9PR12MB5195:
x-microsoft-antispam-prvs: <BN9PR12MB519530464656D04742174DF4FC6A9@BN9PR12MB5195.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NHnD9SS5vG9HtNvI+ZTEz0m8QJjE0Y7fCkY+rYTUrOAEg9FVk8jVCatSzbeFqoAy/KW4I7EeuYRC35PadeEfRzHvRVj/IWPiO7cTkXv6oLeHaTB3tgW1wL5+hNHDnAi60F2eXBZBBfc2MPWizWheF1n/WsfIuMU19LhGauyTCWsq3PrfvsZPPl016m4l7hIOkySMKiUs5m9GGrTUrSDNjQJ3QBpT0piP+ifVVNg9aeNfcW/9gdXQE/C5ZCsJD9ZRq/m/fnUH/mTKYi88yeqFyZ4S7ny724FZ0g9YBy9QGKd+Xg2NOV6IsmdxFNGSjC4xT8xPCyeuPzxA+ep1NqBYjMPRe4WiQfzESBgAr8xyBLL4sdRxCxhnclTNVh2GlBtbzaiNYVkaZkNJNtOO8RSk8P/cVY/oyPJP/zC0lcH01tNVwCAJ3Pcm6njJYh8PByEiFVBQmNKa9sVQj/aeK2LJCM2HhwsXBrC848rjRjR5wAEz3PfRMj0rpUOQJxcircOFD4rEnaGn5GYIhfZMI6t6HetrhJP1i/7tU+xNU2QhsBjHDw6gPoLJOSMRDjLXSYtM/eAjeW2hDppY/GiwIhuUXPeP3OBFevJjLOHp4CYOQKVFpbEs585Axla0DRDf8+5XYesq3DVsuAp5PJ9WDlSnkbBG663ZftuZKy1kUjZtd9SLMrhOoMo6Q3jbXroAkZqahjSLcIh2LTW3LxTvhNUgS4n6bvgX8g7M400jm73gTro=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(86362001)(26005)(110136005)(8676002)(6636002)(921005)(316002)(2906002)(7696005)(508600001)(66446008)(52536014)(6506007)(76116006)(71200400001)(8936002)(55016003)(33656002)(66556008)(66946007)(64756008)(66476007)(53546011)(5660300002)(4326008)(186003)(122000001)(38100700002)(9686003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dmuKszqa/tv4PLuHFFraDTFPQUTsEdopo3srjiv+rLXJmbC5WLIiVJarI0wh?=
 =?us-ascii?Q?mxMi3/CiiX5pvwWSKwjSchSJE179jHJkw95pSUlLNGE2SyggYZffpWq4eCa7?=
 =?us-ascii?Q?bDJZsiR1vpIB9eJofvmFXhBn3TvqkrExcPzpCdKqihUHPMcG9EJzjaPnqn+I?=
 =?us-ascii?Q?YmdMILXGRUhug0NrEZBeh4oEDIXtDuOnF/3LRuroysUdfgZ7TUW5M5fH6iSw?=
 =?us-ascii?Q?+UDYcr6RHW42ysNMCfp4xzF117dHH4zHvsL2BGHfJstwYtMTK5gkVkpCir1U?=
 =?us-ascii?Q?CS458xueiMvrwXaqvvNjXj0vla0SE0vLsBf5YrJECEy9k43FQ7VEpiiQqzxj?=
 =?us-ascii?Q?MbyT1eOfegxnGIXQCMCFUHVOmzznhBapmC5t7hTy4exOgOJfG/pVmLGHrT5X?=
 =?us-ascii?Q?T/qPzn9EBlDC1jYn0qdBeJj6ySDmz6dxyiLbRLz2vVrq/VDAqWEZOPolVKng?=
 =?us-ascii?Q?0j3A3A8y41c/uOX5TlEaON2plwjijFw9XDmz1e5tfrSE1Au0UYxgQNiR+1bx?=
 =?us-ascii?Q?sFKObyRI88gDYzEi8tjb13JnJgV/WhSipaqvwMKD/WO3+PznUL96pJj2+vZR?=
 =?us-ascii?Q?iocVwtkKO8S0+em4JX1koWGwYxlx/Yz6IQbm02P/YjETX7+8EkyuilPY+1kJ?=
 =?us-ascii?Q?YeaZzljrAoR5atpJACHkSju51OpUCvaD5At+k0xi59ebTlLoq7UIpbeCJp8S?=
 =?us-ascii?Q?/i+zlqQnFpMw0Oe627g8Ujv2G6GDLk6qbho/brAfE8IV2c+hldcyLZTn6CD2?=
 =?us-ascii?Q?hzqtxRKwUpjXunCovOPJzaBz4TpfUU+kA+dej1Y5MOcY+TTbMqiFxwaalsxK?=
 =?us-ascii?Q?HRYDWsQuTvPt6TaiBxlNprD8AcU5HA6Cqal17+koL0ktsD30PokQrFBNi267?=
 =?us-ascii?Q?15FEchCwR/dX2F9ss5PcUiTzgXlhTalg4sbrpugRqhm7pHmK3+4lifUCef1E?=
 =?us-ascii?Q?91z1FfEo3fMWwmDRlHEc6jn1KQlvl6kvOcp0d9Z0/6LOW3PcKQJtKf0fMvVZ?=
 =?us-ascii?Q?ZHd0X3/h7skk+ZM8V0P/a1MAfH+h/B0qxfybEL4LUlAqb5Fo6yt7MyzJVHMf?=
 =?us-ascii?Q?OU6jAIxA7HrcXIISRvOawoqueytzMDQYFaDxfDK2bup87vDyw2Zp2RuyGq+2?=
 =?us-ascii?Q?WdyP4hm4ldo7pDKl9iUVExvdaKVc+JQ87Z8I4GbQiK3AQrS7EV24DLGGGmkl?=
 =?us-ascii?Q?KC52KvfQV5Ks05PWeWIeVCMjutEvQFNsgypHs5DfAIwWEhD1bGIJ+SQNODX5?=
 =?us-ascii?Q?z0NWPIiag8irorwFRFfSJ2S1BiW9ckOO9hoBVynkZGGKgXC67MAuI9/iIoAX?=
 =?us-ascii?Q?jI97ABQQGGjTduY6HfrYmtQgiD0yGljxLTv5RCHeszP8k1IzbqXZBt+EbVjT?=
 =?us-ascii?Q?goWJwlIZ8JZivTPrxPegYCdfIDqG2NeRhivmNBn/Ex6j0jVGUkqxtqcC3gLT?=
 =?us-ascii?Q?8MGGpM/y3LKtSwg069pSstS1UbzeuWm3m5VPX39L4+YxLTJ648Nxm4BsIxw3?=
 =?us-ascii?Q?zjKNRLGdpqvqNxBktUlnEziIM7O4EUEmTImgv1u9DINnzJMG8aprCxM4sQs9?=
 =?us-ascii?Q?KEACXN+cMIFW4iy43Zz0qB0f0glZkWHDxOlc9rgpB7pKyTV+450zXO/tVv5k?=
 =?us-ascii?Q?Rt5SX20Fsfha4kgcgGuC79k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b41f26f2-9392-49a0-70e2-08d9b61e4f21
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2021 05:32:34.0530 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DDo2AjbDX7onIuxCoqd0POKKQ3sOmzkSTWssPVawgKYMMrXm24q8EvuUKM5NSaplkdhyMjZArQ3BFv5x1efobA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5195
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Stanley.Yang <Stanley.Yang@amd.com>=20
Sent: Friday, December 3, 2021 13:30
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Clements, John <John.Clements@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li,=
 Candice <Candice.Li@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: only skip get ecc info for aldebara=
n

skip get ecc info for aldebarn through check ip version do not affect other=
 asic type

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 641f9b447997..7c18732f68a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -896,7 +896,8 @@ static void amdgpu_ras_get_ecc_info(struct amdgpu_devic=
e *adev, struct ras_err_d
 	int ret =3D 0;
=20
 	/* skip get ecc info during gpu recovery */
-	if (atomic_read(&ras->in_recovery) =3D=3D 1)
+	if (atomic_read(&ras->in_recovery) =3D=3D 1 &&
+		adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 2))
 		return;
=20
 	/*
--
2.17.1
