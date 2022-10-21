Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB68C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Oct 2022 08:22:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF8A210E491;
	Fri, 21 Oct 2022 08:21:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAD7D10E491
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Oct 2022 08:21:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIeU4fhX4HOUgsXjP8UWB0H1Vot/38d8Jhu8YMiHEzAeW04jKbE3zju2F1fLl6EetokM2/mv2kxDgZKYPRul/gPYIU+MpkpNdjeyMRm47E13sSoR8Yt+1AJ+Qt459ztIC98cvDGsoiVbz8c0URN625Bnq1M+QCG4V5kuRuhI+Tvu8IYTWJVf7HjtaUC9i2XfZfedfaHyxntKi0Dyh2fLbABsbnXs8Fxc2HgjxBHRDKUjR1Lk4veSqG9zQhfN3drMAum1pxpYeQOZEkqS4B9mf8yPFII8WZ6lVV8CcSfT/jhe9DsTOobaiiTDiWJH7AM1xDSurqlr1/AW5avQWDt6fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqWVlygds8ykFT9GjK4ksK7SFhZphvbAN/pzdPnDOVU=;
 b=QQqKMxRv2xAX4G+EAGi9QmN1Qax7epzEkQhW6VXesHxdRQd5vBz4ffKaUNumWClyLbJYN9FitXEgEyKLhZyi48sUVvqUf4NWm5EhHJ8O1CZ2KcLWQEnlL1K/JaPFFTSLiGOnQN2FarhN1NgMAFeYnaPDGK1R+RcsYWF0UWLIPAQ9v+yvAkxBYADLJIPR8wdwfwGfa2Xmexe+kAuY24VIBbCF1zRAlv0RkKOyx9pgYfXQj+jv6UECZNsc/iQ9/QhEyNVVbo67yRnnW4wjyD0QfvmihJ2fV44DNkDFbEUnMoVxN/b1pO6tR0JTagny+Mhn5YxdTRjjntEyLjuewpYYQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqWVlygds8ykFT9GjK4ksK7SFhZphvbAN/pzdPnDOVU=;
 b=TFLDcDfLPcIx6zBJQCtLxgCUEEVtGLCdYh2ELVY3LOLbMMi8u87ngGxRnsoCw8uU2Jjx/efDzLG4l7MvolfajxCu/qN173g8YhyE5wrsMUHPuJ7bwXigvs5YoE1QnRezRDfNcumviXjKcFmBwwGwd665QNzBZcQpZPVZlsD0wes=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SN7PR12MB6816.namprd12.prod.outlook.com (2603:10b6:806:264::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Fri, 21 Oct
 2022 08:21:49 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::8bd7:b65c:13f4:9b]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::8bd7:b65c:13f4:9b%7]) with mapi id 15.20.5723.034; Fri, 21 Oct 2022
 08:21:36 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: remove ras_error_status parameter for UMC
 poison handler
Thread-Topic: [PATCH 4/4] drm/amdgpu: remove ras_error_status parameter for
 UMC poison handler
Thread-Index: AQHY5R/cqnkK4bFvDE6BxoOG+vAxyq4YgaYA
Date: Fri, 21 Oct 2022 08:21:35 +0000
Message-ID: <BN9PR12MB52578665C378846F5C598DE7FC2D9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20221021073605.20352-1-tao.zhou1@amd.com>
 <20221021073605.20352-4-tao.zhou1@amd.com>
In-Reply-To: <20221021073605.20352-4-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-21T08:21:33Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=522b07b1-10cb-4429-a696-88051517adf1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SN7PR12MB6816:EE_
x-ms-office365-filtering-correlation-id: a7213868-7c3b-4eba-2887-08dab33d4521
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +jUu3oiuIVysi/hGte0gZjxq7W76GrJ6vDgwgMxOFJaTYNJKBe//2XK2Aexu8W1mA5eiWeeebAX3U5AGUzOaKkxSX8O4apuQEEibWgVLDw5GkBDIi6SSYHPyrm/4EbiDsj7gpUKwD5cVsKZACOdsEVHcTfw2aO269FRal2OdWaFtlWmpBQ335QCrpeRnJKtinawkFbwkoPGLCbUjxgrUrCgIEDufvg/8S8tR9hT0sZxQrw20W3WohO+WTmqD/cqVZNMpyaAGbbQ1sba6vqzfxAqH5vbFEogSmOs0MlCgrCG3dgh2qgQ+o0nM7YPiNJkhEdsXFW1eD3m6fu3hl7Sc5dSoNS4VlNPP1PZ0jhmiIFW0RbEURucKg5qL86MAJD0824oAsAebNs1/bA8l8zKiJNzEZJMdiC7rxAnch9yry8z1EHd6lnZ+SkOUPM3jtpEeSl4NBo24+5fYV1T+LPjbJ76XCCPMfNDK8PP3+D9G7hA0WE7STgAEFkCHYoR5bvSNyv10iMjj+ItQUQgT0G1vWIGJTLa8Z+Ynhdl0CZh9qYMoYuQxBnaPud1RV6NUqT9Tt3SqJC7ZB5vvpT0lbEOq20gMp87pMQEUKPLDxy0o5+rmbQ4LEFxqsUegQIT7/1AKUBL+8en4KRpcuZcv0URygFX9+FKP+Mn90VlClEjK9JCOVHB84iAAJs31C5IHUwLRvLac6EibBbjVuMZWEM2YBsWJkIKxm4O//U6Tf7jQfXUR00KMf26Fa1jPJh53KV6DrsijxXiblWZVEB8tY52eOA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199015)(5660300002)(83380400001)(52536014)(8936002)(9686003)(26005)(6636002)(8676002)(64756008)(66446008)(66476007)(66946007)(110136005)(76116006)(41300700001)(122000001)(66556008)(53546011)(38100700002)(6506007)(7696005)(71200400001)(186003)(38070700005)(2906002)(33656002)(316002)(55016003)(86362001)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rTeMFGr8uLWnff0xpzzSsZw/iQWcRPnWj8LZeVYOL9FcS/S9JHOYfcVmtzog?=
 =?us-ascii?Q?VNfSvG9KX/ni7MKNPTl0SCVmF6l8K4E1dJkPWUqfmyRYtNq0PsxiOwl5VrYt?=
 =?us-ascii?Q?vR+ndM2Be4xwWLZaUWQY2kOi9WCwjCRtkMQhS6TWgUmYSKWuEF79UMoj6QLm?=
 =?us-ascii?Q?/zJ1PzHncS0IH6ZzvHWDXzwUn0887QsCLusrHmMxqUS46UATabNooR1pehBl?=
 =?us-ascii?Q?4tJUvthyDoBgQNMbxv8KJhQ+HBpSjFp/Ia3NFJyN+njNwaQXdxZKyr9K7HXW?=
 =?us-ascii?Q?Xzy/lMqa85eNH4ufBAItsd/OoX24cEMYFTq2ZSPAIYJ1zg/Azq2jwR0A12q9?=
 =?us-ascii?Q?j3n23RH0k6ukpg7PtgUie9stULo/rkKujhUJhYX/SUeJKaWPKqPO5B0ZPaNs?=
 =?us-ascii?Q?RPiYlyEvhIZPkq4hU5hcZARQjHSkI2TEku40p2GGwrusQwwha/aEEYrdWYMw?=
 =?us-ascii?Q?p979W7mZcqGZlKsxkInleo5zRfwG7ou6HXC5SQ5DPYMWOBaWOF8QFfgzz5hl?=
 =?us-ascii?Q?7pNr1lkSPFLFI+9zjQoA1zq+dZCjt4tTUjGrlBPcYi3PBaFrSZrKFpFjPoAM?=
 =?us-ascii?Q?t2otROlXEM7EayQ/Yl4EUd04tZEQeiBZiYLEKdioqFXpMFvo0IephXE/e5RC?=
 =?us-ascii?Q?P0LUhGq1ktXkjoLlxaEra8xGzusLYZp0z/ZZNOTzLvrz7BmTfw1AhVwbKr7T?=
 =?us-ascii?Q?b2TjUZjxs1o2oYR8+rlNcu/rMKIocaagZh+zNkBP7AuOxAS13CIPvqQStZ3S?=
 =?us-ascii?Q?pOajKnf6o1FaVxcv32dgCRBuxH1koqKYpFjggYlsEJujrzPBzgz1uNwnLPgj?=
 =?us-ascii?Q?/yNetpmIjPIFKmnijlcWm2I0eEVJ2nzGzCuJqLuV9/bP0Utb2OcuaiTzf3cn?=
 =?us-ascii?Q?NK11+e+C/RFo9LDDm1koyYq8uFtEh6KH4KCHsyQks0qRUG6GAS0vZ1qCgpPP?=
 =?us-ascii?Q?By43VeJTO5/N5d+chbT4DnyVMA5KmOwOioCGg4Uts92orNCORP6ahN6CC5QA?=
 =?us-ascii?Q?gp1pXurCeeuhrlb9BfjweZwJ1fywIT3NoyoZzsKIqKQUck7fQTidQu9uhTkz?=
 =?us-ascii?Q?itoXMSPxTOF5/gbdGeLouBsYVhwznFdpQ4AVpb/GSSITPN+4qSSog67eLDO3?=
 =?us-ascii?Q?XjmWxWBlgsSlg0qYhg1Vk8fh8V7W0/dUvsXV3cx0w18xu2WXvY7Zq4feO16Y?=
 =?us-ascii?Q?ZspFFqSKn+v6p+SstvPYCJWQPkuhQLXyGlzllyJbritEXP4NOotz2Ppw4mB+?=
 =?us-ascii?Q?rruBzROII00Hts8WL1UTmCOLm6onMI2cTycvsytduSdwrvH6D8ezRZL/sOIP?=
 =?us-ascii?Q?Oxsk7VTH0wGcNIcmrTLmfWtmkIliv8noE+u+d2Ac0mJpPaDLBeRRaR2Ya04J?=
 =?us-ascii?Q?Gh37RdI6Dxk7uptDlcuHRl5DQrhD7q3dSdvaSTdSb5ZbKCZaRqjKAbOBmduw?=
 =?us-ascii?Q?ViaFTeZ8co+UdTpT5+pQcTbLu0uGBwCDieJzjhB0FCLV97Phdc2ax2ZDIUxW?=
 =?us-ascii?Q?cVPyvEFN5nLhg9D4ZNHXy3rVcsLMYOoWMeR4xrc/nV7f+jI5pkXs/jGwRDHc?=
 =?us-ascii?Q?87R8sc8We+U38MF1ziws2J6J0H0kdk6Pe+rviVL1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7213868-7c3b-4eba-2887-08dab33d4521
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 08:21:36.0055 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eNhUqbrjOGLaVofcLNtUgnhlxsLCqMrwhtR9hBhLdYAVDC46w6JwtXkMYxaFhwGXlJ5/CTF1j69EzfczS36Qfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6816
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

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Friday, October 21, 2022 15:36
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; L=
i, Candice <Candice.Li@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: remove ras_error_status parameter for UMC =
poison handler

Make the code more simple.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    |  3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c    | 13 +++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h    |  4 +---
 4 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index 0561812aa0a4..37db39ba8718 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -753,9 +753,7 @@ bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_d=
evice *adev)
=20
 void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *ad=
ev, bool reset)  {
-	struct ras_err_data err_data =3D {0, 0, 0, NULL};
-
-	amdgpu_umc_poison_handler(adev, &err_data, reset);
+	amdgpu_umc_poison_handler(adev, reset);
 }
=20
 bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *ade=
v) diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ras.c
index 28463b47ce33..693bce07eb46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1561,7 +1561,6 @@ static void amdgpu_ras_interrupt_poison_consumption_h=
andler(struct ras_manager *  {
 	bool poison_stat =3D false;
 	struct amdgpu_device *adev =3D obj->adev;
-	struct ras_err_data err_data =3D {0, 0, 0, NULL};
 	struct amdgpu_ras_block_object *block_obj =3D
 		amdgpu_ras_get_ras_block(adev, obj->head.block, 0);
=20
@@ -1584,7 +1583,7 @@ static void amdgpu_ras_interrupt_poison_consumption_h=
andler(struct ras_manager *
 	}
=20
 	if (!adev->gmc.xgmi.connected_to_cpu)
-		amdgpu_umc_poison_handler(adev, &err_data, false);
+		amdgpu_umc_poison_handler(adev, false);
=20
 	if (block_obj->hw_ops->handle_poison_consumption)
 		poison_stat =3D block_obj->hw_ops->handle_poison_consumption(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c
index 758942150c09..f76c19fc0392 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -165,25 +165,22 @@ static int amdgpu_umc_do_page_retirement(struct amdgp=
u_device *adev,
 	return AMDGPU_RAS_SUCCESS;
 }
=20
-int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
-		void *ras_error_status,
-		bool reset)
+int amdgpu_umc_poison_handler(struct amdgpu_device *adev, bool reset)
 {
 	int ret =3D AMDGPU_RAS_SUCCESS;
=20
 	if (!adev->gmc.xgmi.connected_to_cpu) {
-		struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_statu=
s;
+		struct ras_err_data err_data =3D {0, 0, 0, NULL};
 		struct ras_common_if head =3D {
 			.block =3D AMDGPU_RAS_BLOCK__UMC,
 		};
 		struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, &head);
=20
-		ret =3D
-			amdgpu_umc_do_page_retirement(adev, ras_error_status, NULL, reset);
+		ret =3D amdgpu_umc_do_page_retirement(adev, &err_data, NULL, reset);
=20
 		if (ret =3D=3D AMDGPU_RAS_SUCCESS && obj) {
-			obj->err_data.ue_count +=3D err_data->ue_count;
-			obj->err_data.ce_count +=3D err_data->ce_count;
+			obj->err_data.ue_count +=3D err_data.ue_count;
+			obj->err_data.ce_count +=3D err_data.ce_count;
 		}
 	} else if (reset) {
 		/* MCA poison handler is only responsible for GPU reset, diff --git a/dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_u=
mc.h
index 659a10de29c9..a6951160f13a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -83,9 +83,7 @@ struct amdgpu_umc {
 };
=20
 int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, struct ras_common=
_if *ras_block); -int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
-		void *ras_error_status,
-		bool reset);
+int amdgpu_umc_poison_handler(struct amdgpu_device *adev, bool reset);
 int amdgpu_umc_process_ecc_irq(struct amdgpu_device *adev,
 		struct amdgpu_irq_src *source,
 		struct amdgpu_iv_entry *entry);
--
2.35.1
