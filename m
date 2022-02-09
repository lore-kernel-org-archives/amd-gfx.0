Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3C1C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Feb 2022 14:36:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED4CB10E415;
	Wed,  9 Feb 2022 14:36:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B67D610E415
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Feb 2022 14:36:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzMlRWTSw8yJTLbZ4fl52IjQqeWk91AMmsu2V09jn7kYlRWVM8H4yqmV8B6R+ZLrj0t9MP2U+BV1WBv9bss9RBUiZGrZxvDKu6XzgcWqJMtHsVet4jUblTLyGogJnB59dVlyPMsfLA00eGYQu4MExLtTyjPBI/BbDXc5Jw6v3ME3HnTr10pJUk5bXnEEyouFvhxTZPwJpzlrzqcnP58BA0W4IeIzToyqj18FcK0FB3WeAwyQXI6mkkf0dMOrKF94FEDfwerJ1mayEWqamcD6cyrvZk2CSH4QDTv4RbvH4R8z4i/3sy8jFRNm5g1VDJzjHn2/gGTWaXBOCJIGk05oZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTdl8wiCVPc+OC3+UqnnDpnosb3yS7IW/NL5KO8UCz0=;
 b=g5wG6RPCqLcII+syBChifvF+msorFotIxRn70kOT0MZIeVOp9ubkN/AcPwqyWo2EZHiGRNzkTwL5yEB2/lj5RbsIZkJrrzkD6GIZxX95YyorGhWYvfTxatzjK/P9hPdK8PBeBjYsXhtnNapWJ4zwcSLGMIogycc7YEITNE3yp8+TX8iCa4QxDJgC3KlvlCO8UARe5fzNBkQJJTnnQnwxRR3AkwAaowCAjVJ/x03+Up0SraI7PZbJgqA98czEzS+N0ItCw1ntQFo1Y3+rBsvFj+3fIdY14yEblQJakfssgA/6EEVaZj51+xKirXcFuIaDEJKfKgpggm/uLwXygQoaZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTdl8wiCVPc+OC3+UqnnDpnosb3yS7IW/NL5KO8UCz0=;
 b=2DC6zlRasPFwCJkCX62veyCfmpPrh5UAi+F3pZptNoiRkdtGRSfWo2oLXUCSolyLsffUaB6MV0XmTidryPo2ZQ73o2fuH+2wF/X8M+eG86TBYpgqsMalV8cxIOOPCfh1CT5l3vsNfJS4U8BZyUyiKmr5GMLxxbMf1eA1HmuQfBw=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BY5PR12MB3666.namprd12.prod.outlook.com (2603:10b6:a03:1a4::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 14:36:23 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f124:4f19:716f:e18]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f124:4f19:716f:e18%7]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 14:36:23 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix gmc init fail in sriov mode
Thread-Topic: [PATCH] drm/amdgpu: fix gmc init fail in sriov mode
Thread-Index: AQHYHcGlo64rsfSrjUKVNsSfnSp3LayLSRng
Date: Wed, 9 Feb 2022 14:36:23 +0000
Message-ID: <BN9PR12MB5257BC63E3DAFA6836D8481DFC2E9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220209143022.1437127-1-KevinYang.Wang@amd.com>
In-Reply-To: <20220209143022.1437127-1-KevinYang.Wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-09T14:36:20Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=1882ab69-c0de-4fc0-bcae-ad2a5a3090cf;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29a36286-8356-408d-f525-08d9ebd98bb4
x-ms-traffictypediagnostic: BY5PR12MB3666:EE_
x-microsoft-antispam-prvs: <BY5PR12MB3666A0C762D6DD5539FAE622FC2E9@BY5PR12MB3666.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3frtOSUfpTOH6nYDg2EXNblFi2FQX9t7OGAtkN5k8biXnTVD6oMf77IQWQ4HGz4A/n6ivPhIfufCOyQZRHWOrr3K+miGvfQ/IxKQ6NTW9MPAele7xFykGcBwMQuNNfZQFRhof1IEEh9pBK+bTeRa918GxTYPLEqQp1bEq3+JHJ8uH+p2o6mi+T1JNWt/CLikug2d7OwmtsLuwMRbv6lyoyJcbOZQ7HrThh/mPEe6U/1SOfF9SoSDUIDH8zLj3SziegN/aOeJGFz/lI7tsvVFp0w1IL8ivmb7ybRUNE5oRXhSDlmjGxcaLdApcKih/lxDnlRk6HDg6pmbWBSJXPBCx7xKAbCs3sT4JR+mV8WGM8M/8MB2uzQfxsC5OgCsOgoFJ5JVlsYEcWeBQI8Sbl+5wIbegVUieuFDC8sNDWDoWdVAUJV+DWUlcZWJzzdt2FJvb3LDIUuU1fSWrYy511eUifMxLk6+Mr4/FkLWrSkYL/JNgu6C6Q664E3+96AqQ/Pp8C4UFbve6D9ajnm3Z1cmK5I6h/L4o/MP0pQ75rAWh/Xb/IruWwL8D/UOq8p9kh++OJIhTaTQBMGU9D0kep0VGWH1CyomutOQLAPlRI1XNbKr0maOzBdrB1b9e6D7041lM4BLy9xTKMllXy/0pG9NHyQncx+BijbfIWnPJYk5HjSsmkYmprMYPtuh/ADRpfJKU2BjnoCz+Yb97QPfJRBGWKNmU7yLuR37xz15PyobpRs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(55016003)(53546011)(66476007)(38100700002)(83380400001)(33656002)(6506007)(9686003)(71200400001)(508600001)(110136005)(38070700005)(86362001)(8676002)(8936002)(4326008)(7696005)(316002)(52536014)(5660300002)(186003)(26005)(76116006)(2906002)(64756008)(66946007)(66446008)(66556008)(122000001)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+xHcy7M1zkIK3t5NQAbMgoIfehVmk3Kxfp3LLBkNjqLm9EylxD0xVFLXM7bW?=
 =?us-ascii?Q?hvT/OyL+beHqz40/7KCWSWATL5hnZQtO9swOPlgipR+XVN/QgcroUFPBesQq?=
 =?us-ascii?Q?gHSCkPWnpciLdbSXVh4F4qs9u/0fTJmlYFk5JPjhZdZTlixiBwaAGRvdg6RY?=
 =?us-ascii?Q?rXZpUyolZcuHJ47pNhpGMBsxnhp6RyHZAK2tPNLVyZ1eGt8f/BINYwpc8YN7?=
 =?us-ascii?Q?MeZSb3RQHiU3DcdWhsWPIGOuWDqMc+077jmj9c2YtOu1thU8kM5x6tjd69tt?=
 =?us-ascii?Q?rFOuJP2V8Oig/+XvbQVg+kbEMMgtS92LIJMl8YqDEhuO2r/lHO7dbKiFp1oy?=
 =?us-ascii?Q?wVuMmyVmWcfSlDmrfj+o6WjzpTA7DH5kEI4Jx3WLRoiRzEg/TbRZvxLOmcva?=
 =?us-ascii?Q?wh2zq/1Dh9NVuhw7X6kw4fz6hjAXe9MiQ9sA73MDJP/xi+CurAWkIFidN3UZ?=
 =?us-ascii?Q?Y2u/+cGUemG1LWd/tVSPL4/vW+5KaoKTO4Eh9aIfAB6ZWf5enSOHqFZUJS/W?=
 =?us-ascii?Q?AP8prDL5jL+JaU20ywBPRWsH9KrQz7DdClsELoMoboSn8N+rfORrkQ+OTkeK?=
 =?us-ascii?Q?CBo5oEh4J3cltiKvQSbksJt93c90a7NPEGM9i84/rjoaADynr+OyW9uSHOMv?=
 =?us-ascii?Q?HI0fOA6ZMz+Kv3bKSF+k2U6FSlvtersJWAvPj6IgcDqNcv9hiZ1Ud2gq67BD?=
 =?us-ascii?Q?Mk3/Dmix4Ngl1EN29VZy3YUKzyiyFnEtcPaGtvSmW7ntYMPH6TEWW1Gcr811?=
 =?us-ascii?Q?4HPjY/5Jwa9P5Wd2cCV1O3cJVYbQP+ZblfgH7RHZDgDPyNSLu9zRTJgyy2mF?=
 =?us-ascii?Q?lLsRtYEwQc0UoMgEmFVgWLWW5hbaJgWjMIj7fJXha6/6lp7So3zwJ5SfTBYK?=
 =?us-ascii?Q?r9L1UeHuCPaJ7oHwLUgoz2E/GgYMtxu+M/R6U0pToxqRYDF9c/aPiWRBPhnm?=
 =?us-ascii?Q?XsRW9FN0DMxlp3vGpzverQj5kU2DhjDFr2RS96wYKZEGbM1jKpHLMzxGzL8h?=
 =?us-ascii?Q?JkwRk9DncwodZIz+vlfynUwRJS0BQAW3i3n63/4dFcchu7WgXkqEDGNmYCoc?=
 =?us-ascii?Q?SyCw1xmVcOQvdWWi1ax4RB9N9FFJ9QT5lVsXTquqDD2SZoYtL6D2qr75QWZB?=
 =?us-ascii?Q?RLmT0pu1lMl5nTE3kK/n9GjMRqIFG5+cCvgA6CrdUp1NKB2nv2Hv3YtU9ZG9?=
 =?us-ascii?Q?ESFtSp03hTM01gSc2kUTzJRwJNzaa4ccIQwGGCR4RdviJgqb1jVgiZ9iwH1q?=
 =?us-ascii?Q?eZjsUK/h6C+KihczxCXLvS5/xLG/2gqHRZ+Ti9q9gh1p+pBCmLJobUZh8OcW?=
 =?us-ascii?Q?3vD9a9jcnMF0OglsvO1b028PDGYRMJZO6EpCfgmQU4XuNAjExB7IIMq8K3dU?=
 =?us-ascii?Q?roxi8t9ATV3lsRgQNDTYYJ8IH08MsD7INzulw0M6momBVnQJq6VD+dVkvRbD?=
 =?us-ascii?Q?83Vzj4wvuGRPLqoWeJNz9kdTqfTywZpjfebiB5M3N6xBFNmqzCi6VAlozhqQ?=
 =?us-ascii?Q?+AjpPnmDlGHmMZDne3Z1pLfXtYCHHJfdq96FBDcIB5HXJ5ShYjuVmuayik3Y?=
 =?us-ascii?Q?Lzb/or0cSqCzMVcCyGvsLYUbVSCRg2B1QrjkBU/BtdibEK2RNXeRxvCpQw0H?=
 =?us-ascii?Q?ud1sv5ro/q8TWWUkYBOTZGE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a36286-8356-408d-f525-08d9ebd98bb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 14:36:23.3490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZWHfC13Dq1x4GiFH5mUnumXgWv5Q4ID58x2Bu2TUny8jQBa25VqEuePi7ssqqOK3Z+vS2Uordb1U7Y0ESWK/aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3666
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
Cc: "Min, Frank" <Frank.Min@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>=20
Sent: Wednesday, February 9, 2022 22:30
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Min, Frank <Frank.Min@amd.com>;=
 Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: [PATCH] drm/amdgpu: fix gmc init fail in sriov mode

"adev->gfx.rlc.rlcg_reg_access_supported =3D true;"
the above varible were set too late during driver initialization.
it will cause the driver to fail to write/read register successfully during=
 GMC hw init in sriov mode.

move gfx_xxx_init_rlcg_reg_access_ctrl() function to gfx early init stage t=
o avoid this issue.

Fixes: 51263163eb3 ("drm/amdgpu: add helper for rlcg indirect reg access")

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 +++-  drivers/gpu/drm/amd/amdgp=
u/gfx_v9_0.c  | 6 +++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index f54e106e2b86..3d8c5fea572e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4343,7 +4343,6 @@ static int gfx_v10_0_rlc_init(struct amdgpu_device *a=
dev)
 	if (adev->gfx.rlc.funcs->update_spm_vmid)
 		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
=20
-	gfx_v10_0_init_rlcg_reg_access_ctrl(adev);
=20
 	return 0;
 }
@@ -7682,6 +7681,9 @@ static int gfx_v10_0_early_init(void *handle)
 	gfx_v10_0_set_gds_init(adev);
 	gfx_v10_0_set_rlc_funcs(adev);
=20
+	/* init rlcg reg access ctrl */
+	gfx_v10_0_init_rlcg_reg_access_ctrl(adev);
+
 	return 0;
 }
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index ca7b886c6ce6..744253be5142 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1934,9 +1934,6 @@ static int gfx_v9_0_rlc_init(struct amdgpu_device *ad=
ev)
 	if (adev->gfx.rlc.funcs->update_spm_vmid)
 		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
=20
-	/* init rlcg reg access ctrl */
-	gfx_v9_0_init_rlcg_reg_access_ctrl(adev);
-
 	return 0;
 }
=20
@@ -4755,6 +4752,9 @@ static int gfx_v9_0_early_init(void *handle)
 	gfx_v9_0_set_gds_init(adev);
 	gfx_v9_0_set_rlc_funcs(adev);
=20
+	/* init rlcg reg access ctrl */
+	gfx_v9_0_init_rlcg_reg_access_ctrl(adev);
+
 	return 0;
 }
=20
--
2.25.1
