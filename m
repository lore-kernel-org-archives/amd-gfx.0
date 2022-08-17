Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85056C25B08
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Aug 2022 08:04:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A931510F5D4;
	Wed, 17 Aug 2022 08:04:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC4E710F152
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Aug 2022 08:04:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqH8xB6Bx7laZtsb5JIxOqH76FDhQJRtYrnjFCDDI0979T0Arhb33yes82ZF4/JvQfIj716+y/TqP0i1Kb6uowrN8BaaufMa6KQIgbLWLCU0slVPyf5HohFB9lk4OAboh5C7X5YpbeGMo/MHy/zGRo1hyB74/EQHC+GxO11XYm0R7PD8UBu77Cr1XQMRQtfh7xCRzTMrxbQZ8wij5dXy2Z58nIKLXnv3MRFtInGn1L2ph0SM95LUB8vdh9OM/oQivQZLHclTQuiCiUZFnTSCyqXXO26NY3ucK+Y15kNiGlg4zoIdHmO5kv/vAfp01Lrwiallzf/Q9JS4hyF5kiKCLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGawhOuapbiOiiIslrdzA/DEDrZ9Dzs5F0YzK1pPZP8=;
 b=mstsVbw/iDxGKvAFsXmHGuPaBny37zvvaOI/PMo+He8aSNTJKxqbJ5MrjuwhdAgy/UUilD1Cx7WC+lQ+3yM8MlrAWPVc9zAKqmMVMsZf2OY9nj0Yxlf5Pc1IleamHbz2Yha4Y2FCLXFrxxu7b/PvX4NYn1esGcrKx/hm2PZakEemDqI3ZnJQ0q8BrMd8cdjiGA0U7FeyrAFFzIpX6tKEWwOllDQCxJFeQCps7V1a5YzuwM+sJu/eD+raqL4avrWN3sU6Eo/Nae5RwrNz8moIAZ7kBPvC1avJfeGi1akpnHx5ch7PhadQYmyWVEzyOTvg/Z1T4+HLMeMVnaa2RndX+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGawhOuapbiOiiIslrdzA/DEDrZ9Dzs5F0YzK1pPZP8=;
 b=C6NnzSs8Pc24JT1pWYLvf9rLVOXlS3pZItCtMQeZpiHJR/LjAobKJkDmtDEA67d1Q0Gz+YmXx2ot+chvUkWz/HtJnV9H8K8Dvn3+ueIgx5WSBzc7h/Ipn1KSHUWbblDLE2L8omXXzs8pCafzJteWCrhG/Mh+tmsqa1r3m6r6uAQ=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by DM4PR12MB6543.namprd12.prod.outlook.com (2603:10b6:8:8c::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14; Wed, 17 Aug 2022 08:04:39 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d0ca:88b0:e558:2de1]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d0ca:88b0:e558:2de1%4]) with mapi id 15.20.5504.028; Wed, 17 Aug 2022
 08:04:39 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable GFXOFF allow control for GC IP v11.0.1
Thread-Topic: [PATCH] drm/amdgpu: enable GFXOFF allow control for GC IP v11.0.1
Thread-Index: AQHYsgCniFh475LznEqoWaeDWZB4Ca2yu5wg
Date: Wed, 17 Aug 2022 08:04:39 +0000
Message-ID: <CY5PR12MB636953E14E7ADDD3D346B5EDC16A9@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20220817061355.4046018-1-tim.huang@amd.com>
In-Reply-To: <20220817061355.4046018-1-tim.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-08-17T08:04:22Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=36a60700-d8c5-4329-90c4-1c089100b982;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-08-17T08:04:35Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 23e41cba-f9f5-44e3-b23f-19b4bc6aa9a3
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16bd00d7-c547-4850-e909-08da80272229
x-ms-traffictypediagnostic: DM4PR12MB6543:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ghgrTPF/eekWJNPftUvDodA9QXoljlSPiGPym+YIxMacxTAYrrqKRLPUw0cBIU1F6YLmvrkiMx5vysVko0AHKaCryOn0+eI4NNF6vuWluMwy3p9qdhFaZ1hpfA+EhGi3RQ93wIq2DvVfZVlWmoT5DonOn0tiyqodSx441bdaN12gUlqYNDkyBmF5ZrDgLdZDA4M6aJbPYjaIv51xFQOnsjShDyPz2f2LElo+IhL2gEsd0Zxnhc25t4kffQ1ZpVZq3ACaOE2m9fJOMet3RfZ8TqKU8xdmHLiokI+TLab5eQCcU46WsB3wUArfs0nZEfTmtcoraGjTTj4+hVkwfdSGce5Ho/LDztw6Z5T66YIMCzhswLKoOCPXvOo7H3PLtjW/Kblw05q8PgVmYSTcQUqrXBXFG1SrwKDrwcYIcGVRnyEH49Yn5OzAjTB/2AuC12fsIszHJoRKSqXutOX+Eh8CwaFKe1YV/qPpD3uHCnPuV9+xY0mD4bMwTPGuuteRJb+JXG5OoINpfqRBsdVv4oq5BTg6Yd9yjSP2NQFtuahrx6kiCT6uHGbiEzXDtIU+CLxv1UuzM6EM6d4i0JH8bjthNVN9yZ8iYLlAbjTQMY2mJHe0+fjSme0v9n+LHXmdvD4dsg0SBSHJ65XlfaieneKxSudHvNfoid77fghNo24ua6dicEp69R5gIEFt+vQvhayuSEG3/TNoSvXoiVz2ATDwJTcALM4poryooxVGe+y1m5uddLsSw8R9zKOsfpn1NtglInWilYcc0jKyLeeGhpfHuWPuI1M87ZsrPHG7mhtzwgciu3sFvEloFeEIkx5zg0hK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(8936002)(4326008)(52536014)(54906003)(316002)(478600001)(110136005)(64756008)(86362001)(66556008)(66476007)(66446008)(76116006)(66946007)(71200400001)(8676002)(33656002)(9686003)(26005)(83380400001)(186003)(55016003)(5660300002)(41300700001)(7696005)(38070700005)(38100700002)(6506007)(122000001)(2906002)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dKvoQXm+jI+bbBuifJTh1asNL69AJvB2kgIUv5qgqHF/ltk7S4SqV/ZoX/7M?=
 =?us-ascii?Q?GrDc+/YMeQyI9+9pZYcQ0Z09gqMPVn7ANh/Ft1SPupSxR3vTuxpNHToy+M2s?=
 =?us-ascii?Q?oQ7t+QYgu2TIhTMr0OF8gctWeZU36ZiD+LjUx+aooTARnrUsJzo9G7evfSvg?=
 =?us-ascii?Q?VJo4P+ytFMDnPiajlfW6KEkGRlpBRCfmDA3k/nbSaf9+doItXCjo3TzwJHqP?=
 =?us-ascii?Q?yESZYgx7I4oh3w6orEmJkCQNe4LIDvZH+IvnQ4hFXJhHHUEGhrgUDMTggICc?=
 =?us-ascii?Q?lp/jae4wmWK4u1ZoZA8rB8F3zlPBS6ti9OJh8asguKE1PB7zHenQQcC589MF?=
 =?us-ascii?Q?rU+BTcptc7VoK1FR/9Ts7PU7d9PEAS62wSFaTEMy0YtV2AnfxAXJu2Zwc2Fx?=
 =?us-ascii?Q?JNi4mjdqExyOoO+dLo78X9W7vP4pCoWrQ1xRnk5sQjgfRikrZUg7a8AhRJ2f?=
 =?us-ascii?Q?6CiqvmARJ//DE9XIWqtawm69USPCLbtZgSLHrxK7bZPFxA/RxYfgHbhtPzxQ?=
 =?us-ascii?Q?KVdM1HhTZFZPS++cZiT2rWnvYaClx8BRXhJxwGqPlCfMymHakjzco9RrUfeN?=
 =?us-ascii?Q?vaV71jBJiCe9fy5JGsw2lAYZj6FikvGy9mx08KTfQmTwaMHGPvLuH+89Wpfi?=
 =?us-ascii?Q?WpK5l8sXEjrZdv56HIr7fyHz5o0EZ4LYeMbsllgWc0sbsWNa3XIh+KkN8TSh?=
 =?us-ascii?Q?CEh5Mwqd1E8pm5xK9iZM8J3Pi5U5x5LwKoCWHc44pXl9JedpMG20UIYRxMq2?=
 =?us-ascii?Q?alXj1F35fgjJfmpoEjS5sBdffZUt6m143Xk1r8+9bGqQlyJWYOk6IJlUa4xM?=
 =?us-ascii?Q?672GU5VuK6oI5G+dP/+0zgbq6V0CB9eoxT6hQedMLahMKyIp0ssKA918eGpA?=
 =?us-ascii?Q?T9N1oJ+HT2/CcmOckKtzEnQxDT1TcKWR5PVXdzpDDVjfOquFuyAFHAb0TwWn?=
 =?us-ascii?Q?QLlAX2+Her1awwcLingTP9DHqg5Twoqm463fEx+X7EM5BinPDdobw0mnylEO?=
 =?us-ascii?Q?EE3a5gR6ebGw52RM2e1LfixDJNMhAawtAjBiMZ6nlihkeTymaUQkzD26+8rI?=
 =?us-ascii?Q?A8qRt78MVXJPj+fYHaUz7hcSnVVx0qdby14JLZDHV8mIFoutv/WkaiKUrFEV?=
 =?us-ascii?Q?6RRb7kbcloK8j5mf9cNTPXavnMmlkfF1YapHzTFMnUC71JsGRTOnq0Rxqy86?=
 =?us-ascii?Q?yH8+9ya6AWWCqAVtVQMJcCGTkjoOwmK9GFx4pGVvhZbFXHUsDQn6Yb+vtSCu?=
 =?us-ascii?Q?n/g0k9PqF1kpO8l+97/Pbmr/mbDeb6SDXkw3id4I1bikTX3DMbu1JhK9vYrk?=
 =?us-ascii?Q?FSJUMPQWHtRayQ+RAF+CC1MnlNurQBG9segMnzkYK278YT9M9/71BnCscBbh?=
 =?us-ascii?Q?i+A558bQYMOBpCm4o/66wUqC912C42w9EWDXqK9YfmeUAs5x+IFZzSrYHL0q?=
 =?us-ascii?Q?wdmLpPge51xRN2g7qS/Q+X8FV7szYHOK5UiYzCeDDK7vFNXAKkaR+GV4sSw7?=
 =?us-ascii?Q?++ZD8aHz9b8qZAMd2NP1TTzpv07kRfIVvDpXvNwLs09iM37Q0uN82g/lioTo?=
 =?us-ascii?Q?38wvxrNn+myxxU5QljM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16bd00d7-c547-4850-e909-08da80272229
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2022 08:04:39.0973 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wBiB3C5UzN9PD3tx3mBzTtWOaJvRJAUoZ8VYNazud8NdntKO9bdw7NMor/nzTQye
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6543
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

This patch is=20
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>=20
Sent: Wednesday, August 17, 2022 2:14 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Huang, Tim <Tim.Huang@amd=
.com>
Subject: [PATCH] drm/amdgpu: enable GFXOFF allow control for GC IP v11.0.1

Enable GFXOFF allow control when set the GFX power gating.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 158d87e6805d..f45db80810fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5328,8 +5328,7 @@ static int gfx_v11_0_set_powergating_state(void *hand=
le,
 		break;
 	case IP_VERSION(11, 0, 1):
 		gfx_v11_cntl_pg(adev, enable);
-		/* TODO: Enable this when GFXOFF is ready */
-		// amdgpu_gfx_off_ctrl(adev, enable);
+		amdgpu_gfx_off_ctrl(adev, enable);
 		break;
 	default:
 		break;
--=20
2.25.1
