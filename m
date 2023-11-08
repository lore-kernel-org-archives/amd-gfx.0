Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3522C4167B
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 13:57:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 384C410E75C;
	Wed,  8 Nov 2023 13:57:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BA5510E75C
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 13:57:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QphZ1ukU7oM+OukOc4e9s/B8zWubbjq0C8XW5j+4UE4pcjDDLBDjNlItMndTrzdB7SaRicGxlVY8LF+1zpp6Q+R1ITrkOgyjXaWkJZdIFmBzWP1Fjz45siyG428U8kzu1EzGdswjMqu74i/Ki8M/ZOYXmU1CkRWP9Ryp2/RzVn/9mVvRhJm4P5rJ5eWZMbpuBVhUFnj9cJyKV5jgvW+bkPefmL9F+RDZvm4CUw9rzKiM6MHKzbE7MVDpG8hGYWlTmclSqeLfuIdS+h9NQ/hurQ+sAZMyblyv7jeHeeJTeZC8eFXBCt0ljADPJvtrDQ8hOYMpGZXiHvYUsq5Vm9qqBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhjwnZVvlJM1hmCEmCUeBvxhQMQEqabcnPkLvl49b0c=;
 b=RVhwLoJqoq6IzBBo7snDNPN8C77SAw5ICZSAsDr/k12RIWGwhiJQ44ZzEQYKt4p6pEXDo+sgwlPNsBATEiwQ1YD7Z4v6esNZLY/uGJ/eF39C6zl+Swq4SVUn5hW6Sk3s+1mdKpatAo4+X5wT+WWT1MBb332jF/6MdIWu8YLEMHJr4nzbYs7U23wXV+c3Lw3fW0LQH4vbXOzPNds3VeTYexW96bU3sX6mGPQkBtw7QbQRMprijqzl3/HuwJpIKh9oZfQBAO3sbyGhVUlAXM+O7jdbvFdbDwZby80diTkJAoXLCY0dezLymzoM/W0/g5jik47v9/Cg5lrlwvQDXsd8Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhjwnZVvlJM1hmCEmCUeBvxhQMQEqabcnPkLvl49b0c=;
 b=5Pd8dFdEzAVvfILADGnd0QZGCHD8PA7o626aoUWm4cV4BzXmIkcC5ZDix7xWK/H4O+9J/BrsNEsWTgQadXsInXGYBXkdDaEczOn5gyu255SYUj+Buv7el8zmGhZ/2Z5tHKWuy1qubk/On0cR1RUSqAPV2NNhj+VSmA/50JMtJUc=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DM6PR12MB5021.namprd12.prod.outlook.com (2603:10b6:5:208::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 13:57:09 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e%4]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 13:57:07 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/7] drm/amdgpu: Support multiple error query modes
Thread-Topic: [PATCH 3/7] drm/amdgpu: Support multiple error query modes
Thread-Index: AQHaEkM+zW3qgQ8W6kmF/LoWjiuiSLBwckHQ
Date: Wed, 8 Nov 2023 13:57:06 +0000
Message-ID: <PH7PR12MB5997844A98664B9AF3346F0B82A8A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231108125735.2497856-1-kevinyang.wang@amd.com>
 <20231108125735.2497856-3-kevinyang.wang@amd.com>
In-Reply-To: <20231108125735.2497856-3-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DM6PR12MB5021:EE_
x-ms-office365-filtering-correlation-id: 0efc575e-f0c1-4dd6-3c19-08dbe0629857
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N/LDLZ/Cvy1uPoqNvH2KY+tkINxJPXWVjlkKyXgBPhOdD1kqGXBLXB9t0BANnRUWsvboknrNm4SnTfhSjms7phhwQ1d+sufOFhhHZ42Hh7/jdOIbfuLPCBuoDAhapoRZkVek9MescXWfFL1qgP6SzzZb56Yl9sOYI5kFTi3BWMrgfdgfPKfugHg8fhKH/XThvCMkjj9MFKV9w+32DeFhNOTkiZ8QJqcfP13Eta3ihe94eoAmn1zaluidioD0pDKAtIWp+hTz4QYxxxK9IkdA3cPty48QaGjm+u6Oe14e+yJIGKWjJ28ay4f+qtFNF09tXLrq2Xaj6g1wpQ1p2gIfkLHbNSmiuAIqiEI4ZmwGlNwOknthUsNfm/suJ4W6NXjYwSDwiUmYzA2oHC5gxZoTYDdrVpJwNcUbSFOMRAK9vyQRMMXVKcIbpOJ93tmQJRqc0mxkmNGKy3rWQep4SLRsDc3TKmUd/lfTdC1y4rhLzXO5v0K2eSICLSqQKGCV/p/BYaTQc+aT0lYUiUeCIFEF0l/Dw0TpvOWFHQt0i+FXAxdMMoZhCY3SODRkcOq/+Ftjlqv38eV0Dy+JgskySVdTGk/fKzY/AhL6RCOla8ZMH5YkxKMHGgmoT2njYElffZHz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(366004)(136003)(39860400002)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(9686003)(52536014)(76116006)(122000001)(26005)(110136005)(478600001)(66556008)(66476007)(66946007)(66446008)(38070700009)(64756008)(71200400001)(316002)(7696005)(53546011)(6506007)(8676002)(4326008)(5660300002)(8936002)(55016003)(2906002)(41300700001)(33656002)(38100700002)(83380400001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+7tHnN/wcj9vV3BEWoDsIk6RpVzKR34wVIt73W/Hexb69CVcq4w0UiDEB4mS?=
 =?us-ascii?Q?Wxu06kdJBMYWuMnAbZlmqV6P5aElE3fjst+MY9rtHs8T6Zjev2qQAXL4apJ8?=
 =?us-ascii?Q?+1hnJ8OLSLnEdWxZMWGyRX1g65u3ug2zL/AXAz6ClH5Ef7ZNnw4BUKV+0i4q?=
 =?us-ascii?Q?frxFi5ddkx/vo/yHAxb+NIINMCPdIqLO1Ar9GZYV27bogiy5rSXOhnqqT6Q+?=
 =?us-ascii?Q?Kps+L43p1rcnicwNDLFbTRrxKPklIgnJzc41Imc6h+W1zTwwJPQfegb5pQVR?=
 =?us-ascii?Q?YKum7KPWUXcZAZCsqLVAWtrlJfZ1leXnno4iWWQJ2hr5YOFTe9GAchJl1e2B?=
 =?us-ascii?Q?PCKxoiLTCK4muwLr3ewlkZ8gxaaFiGgiA7Zeo43Qcrn7u75xF9SN1Ph8C46k?=
 =?us-ascii?Q?WE8CmfmZUeFo0q517jA0js5S+5+l+PKt6KJckc7I2SBimte3d/Ofy5Zadx5q?=
 =?us-ascii?Q?LTmx1LezGuBY+Ia08sJQat2DlYM9Zo5tEq21Jc9Ig709pWVOmTpC+G9dtI7f?=
 =?us-ascii?Q?OZHRUrVwbemjtsWFgY724hRjvC3xrQ60bOrprYIZWZP5cwAGLk/ZHO+cWj2m?=
 =?us-ascii?Q?N5yF9pnWgKa2Bvl1W6fYXkCuymEIPy3rY0yisu6Np46ygj54yLlyOTlkNmFM?=
 =?us-ascii?Q?m6uAfr50JQfkyafM6EAurq8J7WnFDLatAvd4xm6BUhQ+sYCxvFYODFkgfsls?=
 =?us-ascii?Q?QqY4wAF55h4ZxJxYgtI0ge9eGxDiGNg8wiX1TgungD6rvv9H8AmLtr7oE8Pv?=
 =?us-ascii?Q?1Fvos7oLIuwoJBDnST5a+gmSzhTNSLMjna742heHTQaGWGOJ+3HomOp2mzS1?=
 =?us-ascii?Q?qsElfke0DyZXEesrVnIVKaZrAujvV8VE98/n6r+eZungtpaQH1tm56mLQoM6?=
 =?us-ascii?Q?tKCvdbHth0mqD1MSoAaU1xgFmLzDGvSto86hRcWOmLi8Dw2UCkQaZEZmX71w?=
 =?us-ascii?Q?KX4B+p9VzwKmnycif4MM/ENnYp/ELPZiznZTggf1NQWEw96F7Yk6vC+pmwqs?=
 =?us-ascii?Q?x6OHcCRWnrVaCthKgSel1tYFPmpYK2b6YLYJ/t4T6A19IlRqCu+A5dJ99JNH?=
 =?us-ascii?Q?sq92VSiHi9KkpF5bF3dfyWZKHbVkI0GsUNezJqxPxDQcZy15AEg3wxPk3pdw?=
 =?us-ascii?Q?e/aUKfm6uarx6T6i3kggJ+kDvYUwtAGsdDP/S4SGeX8RmEoi4SYaCAEBSxAC?=
 =?us-ascii?Q?MqFAFDECuJmxzBuCR6R1SNiUUsFw9JzxVCoXWKdvPda0zTrNR8N4mZLimD7k?=
 =?us-ascii?Q?/0sdcSM9oo+S3tv8xhFMm1Tf6Be16o0qP2dN2JgfRPltbAhSVs+BzQYnRHYW?=
 =?us-ascii?Q?TfH7f2QiLb1jhUyzdEyjGb2H+dZq5YN645Pcd2Q41N4nuNq1o+GdPrZo+xFF?=
 =?us-ascii?Q?7iSgkCSHPs5QA80Ea6tq1DHar7c/1xB0u9ErJ5aveChztT3lJSW20K9MVIdJ?=
 =?us-ascii?Q?nBfEj7GIGBHtTklHWdmsvsqI5wBh6tMxt95g7YE/RNnZsPmccg7GG+xfOOya?=
 =?us-ascii?Q?1j/LEy9KdTQjaFe309DCfTX6R405uXqRM0v1uz3o0pcFovaL8wvpR5+lBCwf?=
 =?us-ascii?Q?kuvtQjFIp2WMEQEOdFQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0efc575e-f0c1-4dd6-3c19-08dbe0629857
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 13:57:06.9741 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: utKJl+rgu67LA036uBPXYZcIyYX3FnH+dP5uqP8qD+RvF2r3ssXIVxcvIdnQ+rdw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5021
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Wednesday, November 8, 2023 8:58 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 3/7] drm/amdgpu: Support multiple error query modes

From: Hawking Zhang <Hawking.Zhang@amd.com>

Direct error query mode and firmware error query mode are supported for now=
.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 93 +++++++++++++++++++------  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  8 +++
 2 files changed, 78 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index cfb361cd0320..11055e0856bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1165,13 +1165,53 @@ static void amdgpu_rasmgr_error_data_statistic_upda=
te(struct ras_manager *obj, s
 	}
 }
=20
-/* query/inject/cure begin */
-int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
-				  struct ras_query_if *info)
+static int amdgpu_ras_query_error_status_helper(struct amdgpu_device *adev=
,
+						struct ras_query_if *info,
+						struct ras_err_data *err_data,
+						unsigned int error_query_mode)
 {
+	enum amdgpu_ras_block blk =3D info ? info->head.block :=20
+AMDGPU_RAS_BLOCK_COUNT;
 	struct amdgpu_ras_block_object *block_obj =3D NULL;
+
+	if (error_query_mode =3D=3D AMDGPU_RAS_INVALID_ERROR_QUERY)
+		return -EINVAL;
+
+	if (error_query_mode =3D=3D AMDGPU_RAS_DIRECT_ERROR_QUERY) {
+		if (info->head.block =3D=3D AMDGPU_RAS_BLOCK__UMC) {
+			amdgpu_ras_get_ecc_info(adev, err_data);
+		} else {
+			block_obj =3D amdgpu_ras_get_ras_block(adev, info->head.block, 0);
+			if (!block_obj || !block_obj->hw_ops) {
+				dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
+					     get_ras_block_str(&info->head));
+				return -EINVAL;
+			}
+
+			if (block_obj->hw_ops->query_ras_error_count)
+				block_obj->hw_ops->query_ras_error_count(adev, &err_data);
+
+			if ((info->head.block =3D=3D AMDGPU_RAS_BLOCK__SDMA) ||
+			    (info->head.block =3D=3D AMDGPU_RAS_BLOCK__GFX) ||
+			    (info->head.block =3D=3D AMDGPU_RAS_BLOCK__MMHUB)) {
+				if (block_obj->hw_ops->query_ras_error_status)
+					block_obj->hw_ops->query_ras_error_status(adev);
+			}
+		}
+	} else {
+		/* FIXME: add code to check return value later */
+		amdgpu_mca_smu_log_ras_error(adev, blk, AMDGPU_MCA_ERROR_TYPE_UE, err_da=
ta);
+		amdgpu_mca_smu_log_ras_error(adev, blk, AMDGPU_MCA_ERROR_TYPE_CE, err_da=
ta);
+	}
+
+	return 0;
+}
+
+/* query/inject/cure begin */
+int amdgpu_ras_query_error_status(struct amdgpu_device *adev, struct=20
+ras_query_if *info) {
 	struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, &info->head);
 	struct ras_err_data err_data;
+	unsigned int error_query_mode;
 	int ret;
=20
 	if (!obj)
@@ -1181,27 +1221,14 @@ int amdgpu_ras_query_error_status(struct amdgpu_dev=
ice *adev,
 	if (ret)
 		return ret;
=20
-	if (info->head.block =3D=3D AMDGPU_RAS_BLOCK__UMC) {
-		amdgpu_ras_get_ecc_info(adev, &err_data);
-	} else {
-		block_obj =3D amdgpu_ras_get_ras_block(adev, info->head.block, 0);
-		if (!block_obj || !block_obj->hw_ops)   {
-			dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
-				     get_ras_block_str(&info->head));
-			ret =3D -EINVAL;
-			goto out_fini_err_data;
-		}
-
-		if (block_obj->hw_ops->query_ras_error_count)
-			block_obj->hw_ops->query_ras_error_count(adev, &err_data);
+	if (!amdgpu_ras_get_error_query_mode(adev, &error_query_mode))
+		return -EINVAL;
=20
-		if ((info->head.block =3D=3D AMDGPU_RAS_BLOCK__SDMA) ||
-		    (info->head.block =3D=3D AMDGPU_RAS_BLOCK__GFX) ||
-		    (info->head.block =3D=3D AMDGPU_RAS_BLOCK__MMHUB)) {
-				if (block_obj->hw_ops->query_ras_error_status)
-					block_obj->hw_ops->query_ras_error_status(adev);
-			}
-	}
+	ret =3D amdgpu_ras_query_error_status_helper(adev, info,
+						   &err_data,
+						   error_query_mode);
+	if (ret)
+		goto out_fini_err_data;
=20
 	amdgpu_rasmgr_error_data_statistic_update(obj, &err_data);
=20
@@ -3397,6 +3424,26 @@ bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_dev=
ice *adev)
 		return true;
 }
=20
+bool amdgpu_ras_get_error_query_mode(struct amdgpu_device *adev,
+				     unsigned int *error_query_mode) {
+	struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+	const struct amdgpu_mca_smu_funcs *mca_funcs =3D adev->mca.mca_funcs;
+
+	if (!con) {
+		*error_query_mode =3D AMDGPU_RAS_INVALID_ERROR_QUERY;
+		return false;
+	}
+
+	if (mca_funcs && mca_funcs->mca_set_debug_mode)
+		*error_query_mode =3D
+			(con->is_mca_debug_mode) ? AMDGPU_RAS_DIRECT_ERROR_QUERY : AMDGPU_RAS_F=
IRMWARE_ERROR_QUERY;
+	else
+		*error_query_mode =3D AMDGPU_RAS_DIRECT_ERROR_QUERY;
+
+	return true;
+}
+
 /* Register each ip ras block into amdgpu ras */  int amdgpu_ras_register_=
ras_block(struct amdgpu_device *adev,
 		struct amdgpu_ras_block_object *ras_block_obj) diff --git a/drivers/gpu/=
drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 665414c22ca9..19161916ac46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -320,6 +320,12 @@ enum amdgpu_ras_ret {
 	AMDGPU_RAS_PT,
 };
=20
+enum amdgpu_ras_error_query_mode {
+	AMDGPU_RAS_INVALID_ERROR_QUERY		=3D 0,
+	AMDGPU_RAS_DIRECT_ERROR_QUERY		=3D 1,
+	AMDGPU_RAS_FIRMWARE_ERROR_QUERY		=3D 2,
+};
+
 /* ras error status reisger fields */
 #define ERR_STATUS_LO__ERR_STATUS_VALID_FLAG__SHIFT	0x0
 #define ERR_STATUS_LO__ERR_STATUS_VALID_FLAG_MASK	0x00000001L
@@ -769,6 +775,8 @@ int amdgpu_ras_set_context(struct amdgpu_device *adev, =
struct amdgpu_ras *ras_co
=20
 void amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enable=
);  bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device *adev);
+bool amdgpu_ras_get_error_query_mode(struct amdgpu_device *adev,
+				     unsigned int *mode);
=20
 int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
 				struct amdgpu_ras_block_object *ras_block_obj);
--
2.34.1

