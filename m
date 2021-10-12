Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FA0C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 07:56:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9517360F92
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 07:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9517360F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B8876E7D2;
	Tue, 12 Oct 2021 07:56:38 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2084.outbound.protection.outlook.com [40.107.212.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A05816E7D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 07:56:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4gcDxqz53SO4E0wwW2GMXzFjK3DL4v+XH6eLS57wgoHvVjd9k7a+elEuTeTJBOBuKh57sBgqzwe5WmrRHdhRCwNFDJJnjYj/Hk4+KBxWB21qB7vUupvx843R1tw4xc/zvcnkr3VAZSPn+TG2+fyCj/m94N8sLTFKv0IMxUp9gTgXwn6y/LPmnY7/5jp9slfO9kLwlS4rNPABskFrMK+9igkpsOyALUodzHUDF3exNjJ6h1iwIdkynRYa1im1nTUbfAnYeAf0Dw88jhyrwqrF5CFYLCZ//hxi2GQS3NWLLwFUkrFJ5mVtWgLRSquPho1dIHUL7p/tvq1EoLNqi4QsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnurBhhr+5XBkGaFZLv1WVW4ADIofIo6rKQlOg6qHY0=;
 b=oc5wjXPBDwOwDj1tXVvJo/c9S/N9jOE0BoBKYxjijYGwsBoQSWXDUDFSWYWtVrHY68D99S2oesS8D30xTAX9SQ67A3ev7kKV1UBUSYLP9pb7LeQtsXN6wgoiA2X0YKZ770VwBnNb+nv2N3hTNBwB+lqI+hn80kR2odGX+OsbdLTnCBWS4Bvo/+/fhrs/4YkQeOuCg3knW+53Fk2pPF+3TVwkn8fuPkDshx5ZdwvEJmaw39wNCDWD5LQZqiH6j5L5VL2KzYozOUd2bab2xcA/YW5M3rgYrCP8k7FaUS8Ujtuzlky3Uc7xkUbGkWKp505RNcFpCZDOlNlCSRM5kJiMog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnurBhhr+5XBkGaFZLv1WVW4ADIofIo6rKQlOg6qHY0=;
 b=DWjX1HveFowJDApvB4n5VyibxLSFQ7fYFcI3stCT0ZTJSCKBEzi2AM8/zt4f/nMbq67Y40pS/O2SaHTQqk5iCcdbvG218/S0lsZ8M28rmJyJwm3QLc24LSMG4XWrdrhD0smv5VesEVtAaTKH5ZndExitnpboUyueVuu5eSFs7AE=
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16) by CY4PR1201MB0183.namprd12.prod.outlook.com
 (2603:10b6:910:20::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24; Tue, 12 Oct
 2021 07:56:34 +0000
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::91ce:4fae:eca6:9456]) by CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::91ce:4fae:eca6:9456%9]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 07:56:34 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu, Charlene"
 <Charlene.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: enable display for cyan skillfish
Thread-Topic: [PATCH] drm/amdgpu: enable display for cyan skillfish
Thread-Index: AQHXvzCwrfprOXvAfkWY6fvGWgtAp6vO/e+A
Date: Tue, 12 Oct 2021 07:56:33 +0000
Message-ID: <CY4PR1201MB02461A6C6C1556665D787E99ECB69@CY4PR1201MB0246.namprd12.prod.outlook.com>
References: <20211012061605.809634-1-lang.yu@amd.com>
In-Reply-To: <20211012061605.809634-1-lang.yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-12T07:56:30Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=2ec7421d-549e-4470-928b-4c264d1a087b;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce094777-23c6-4ba1-3f57-08d98d55cf62
x-ms-traffictypediagnostic: CY4PR1201MB0183:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB0183B9469FAF6A8CF64BC711ECB69@CY4PR1201MB0183.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:765;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h0my7gmummX3QguafGQHYGo1rG9HGfTf1eiKZTOIB96CR42edm6t08gWt5/7JLqBE0MRxT4f9s9xgtQ5tQvnhLe+687y2zGgiRI88puFXFf5JTgSGkbsUcx2qKqboG88JTj51KEs4/+KiF/ckeTX3M+OU7AFK3D+2oCMkbuxmwZdEMGeKI710wfOL/GuhvmSiYMSVuZtPc9dkbqwKiOCwSxN2OAij90zcDy65d6P2sBmCcfpQMA3bOnugJaikqES2dy42zHSDSfQUqfyUaKYsUDVdlqShJzU1cFtJincgIhHOhVAZtxFAwLx8PwwrHZPW6lPNGWQ7da7s7hgVwUVSfUfIYBm4eLQN6PxSF/y/vV0p//DFUf5KttrXL3aFTsUQy0fO4QRmEAgDflv9CmZyc45CKc+OeVaax9lxbMLMS45dlwFD/q+x2ELYSmCAnrbK0HgV5WOB2aRgdfhJN4cD9BUbPnPQnRBiBKb/vzZCfHp/Wf6xiB+iVRpdPwFOP4XzwReG/VKy6iPqkF2rlEIyjWxBgwzI2fWsD4rDofZq5DX8ZkhB4MWchONsZ1n+7sAgUNCNwDQPrlduBUvHcip0kqI1An7hOfxyMG1CEQxrVVZNkN5VdCCWi7yzlAyLBD3gU1WRJ+QiBBp1HDROtdz/Qn6Bgs4EfhIcoWTQFVp63wBeAzFZPSl4KEvcH10sRcSDveAgliEqozHxXczk77xVg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB0246.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(38070700005)(64756008)(54906003)(316002)(110136005)(4326008)(2906002)(76116006)(66446008)(83380400001)(8676002)(7696005)(86362001)(71200400001)(66476007)(66556008)(122000001)(38100700002)(8936002)(26005)(52536014)(508600001)(55016002)(5660300002)(9686003)(33656002)(186003)(53546011)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7wBOgFMgZoc0qWQzDGhl43HLtKBwNJFMuAAWw3hlyiQzJK4tDSr7I9gIm9IT?=
 =?us-ascii?Q?noX46QlOUrP28GnmJPIHKdQqKNDH57bFPUdGzGSyZXi4t1kKAgSQOt5Pk7FI?=
 =?us-ascii?Q?RxM4WHT8P2VF7J3329i3OoJP5FhX8tmu5yAoQ15ZkuiXuOAm1UJgYJPgtmJJ?=
 =?us-ascii?Q?kUxE7O7pw8y5AMfWP+I0HsRr89LazlYKevtPXGO4kmpN5ndwvseUedM4vPEA?=
 =?us-ascii?Q?tJZRSbvnR5m1RZJIiAbqehXlYGLBpgLkJKxHU1PPc7aTu4t4Y5wjvJeTxslM?=
 =?us-ascii?Q?z1Go2y4eb0OzzZtNrlqp7D2IiZZ/xIDY3zF6rxov9LWi8sPIEecXr8e+kXI5?=
 =?us-ascii?Q?DmioTxYtmJ5GxjF4snHo0z9N4z0V4kS1LRpD92sXVSg/AF+el1cZk44iPmsf?=
 =?us-ascii?Q?2RxrTun1Z9CezOPMrK/69Em/gNJmlzgiGHXNZYCtwhXGPEseBlsNzaanTqsW?=
 =?us-ascii?Q?VyqnXZj/x6GGRzuMRZIr1zhnw8Ik7ryO1FrxdCVXrLD0AzZMoAHImr1hQy7I?=
 =?us-ascii?Q?Kc5+X/WUwDUfOBHfsq06gd9r3AJupQacboUZTsmbezZkkuRSLGMaiWhhfEHb?=
 =?us-ascii?Q?L+a7kBqIZsFRxTa3CmTiD54c8I7TDyG0itQm6LFXsgbwi/e8D6GCDzQ2eyzr?=
 =?us-ascii?Q?i/jUv6hnUJQflcmkjiLumgnN5taQrI7hAmrC+NlO+eNmAW7zMJrSqgBy/PRE?=
 =?us-ascii?Q?bknxizQNmTmW1srR1ggrIwh9dTfcXchR/VXA5+spLMNRsV5z+CkeX392EZEu?=
 =?us-ascii?Q?Im/bWVp7fjOKqZAnIBy3zrLKV98Hb1bjsjIaHY73rqm12QL+YgzSOK4xzrDP?=
 =?us-ascii?Q?w6r8fEQprP4qHpUk2nhM3qzb7x4A1aC8xSZKpaRrL6sCgoU+L/1WoDb1zscs?=
 =?us-ascii?Q?32Pch7Npqg9B+FBWNj04LSVwYoXkF1YsdbIjuNJFKlxJCzrltncxqms9+90l?=
 =?us-ascii?Q?lnAbQGWUxWzg6iBi+gNlSjgZefcCeGKfiVEIiJkPBVA4F6g9x0mQZlBcTLw3?=
 =?us-ascii?Q?y84Je0Yx+6eaNsUT27Pm+CDSr/Fnev/DhkSq/QaOxCQWOnm010CgV3CowE+I?=
 =?us-ascii?Q?2iy+TxbMKtnMxN1O+HHASx6yGETlrLm8dI4d2S8PHmaxwqgD8j1AmluAVQOl?=
 =?us-ascii?Q?NH3Aowo9K5Spi4xyoFeA6pi3X7ogBkBV6VaRCiifufA1jsLs8ov4H8U0O6zq?=
 =?us-ascii?Q?IXYr8dlruNdq0WYuiai0+NFniEQ+Bvd9htTMA3hFylS1cIHg6QIwE2XI4MSM?=
 =?us-ascii?Q?sxy3ZSs0dKvFn/5xCO2EuTAi/F+yezuhr9u1DP80u9muZQsNkWvWpNAFt4JH?=
 =?us-ascii?Q?F+aCamJWZYy7kwXUAnXG/RSd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce094777-23c6-4ba1-3f57-08d98d55cf62
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2021 07:56:33.8765 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hth+DYi1R5YsfU/2b2vuqpmuRZ9IcdNzkrMB1jp+czpUEOrkCBv7RxCJb+E4qt1P1VJKcuAY2bjZphDCNbcH6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0183
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

+ Charlene.

Reviewed-by: Huang Rui <ray.huang@amd.com>

-----Original Message-----
From: Yu, Lang <Lang.Yu@amd.com>=20
Sent: Tuesday, October 12, 2021 2:16 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Yu, Lang <Lang.Yu@amd.com>
Subject: [PATCH] drm/amdgpu: enable display for cyan skillfish

Display support for cyan skillfish is ready now. Enable it!

Signed-off-by: Lang Yu <lang.yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 2bebd2ce6474..4228c7964175 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -736,6 +736,7 @@ static int amdgpu_discovery_set_display_ip_blocks(struc=
t amdgpu_device *adev)
 		case IP_VERSION(1, 0, 1):
 		case IP_VERSION(2, 0, 2):
 		case IP_VERSION(2, 0, 0):
+		case IP_VERSION(2, 0, 3):
 		case IP_VERSION(2, 1, 0):
 		case IP_VERSION(3, 0, 0):
 		case IP_VERSION(3, 0, 2):
@@ -745,8 +746,6 @@ static int amdgpu_discovery_set_display_ip_blocks(struc=
t amdgpu_device *adev)
 		case IP_VERSION(3, 1, 3):
 			amdgpu_device_ip_block_add(adev, &dm_ip_block);
 			break;
-		case IP_VERSION(2, 0, 3):
-			break;
 		default:
 			return -EINVAL;
 		}
--=20
2.25.1
