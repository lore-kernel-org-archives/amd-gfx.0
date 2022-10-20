Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E30C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 09:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EC1410E56D;
	Thu, 20 Oct 2022 09:29:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C346B10E56D
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 09:29:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckX1MGnxufuifmY5CIza1lJcDx6y7uCyBR9CGdD8GPVQGeUyRljHS+xk5a1gbqrgm48uTWv8zJLS2iWCaiPEblMRt9aDnQkb8tPQPUcJtZI8rse0CGoriLyihrFHTsCEl/CwW/IYiIbm6jI02eX/8itQv1dehrJr6d34U0e+H9del0DRkarA2uUBXsfc4mN+kNXoYZdGl5oIQ1uhV7Tr8Z4vai45O0AjzD/jTmwnE5oT1JBLntXiy4LB6Sxw/fAhtnPq5c5plU/+y9m39WQR7575XXNfMhj4fJ6jLG8eGcqHa15ig3rXYv9Bmbf9xI+g3AsZL3fi+px1tx85JtGhtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzER3uU2rtdNMJUHTm6Yht2JxnIuCVw7dgVhvgnB6Pg=;
 b=XgworyHzZjy5nz5gpK4bR5xiYj6dPWN55SPvUa1C+i2g3sZSPtyLIg+etBpOIWkeeUKSrzn9s3Ctu4D6P52dEDMN+4MWyF1qAHDKDP9n+4E1ESpnBx9OQ6hrJWntM2VjKiPEvRa0RtRKG91lUojytOZ4mqtJX1hfhC4Do4jPhJZZASveAf6+8B9od1FZQDZKgpYB1ry/g5AFxVu7O9GHJ3sQvsidtOO5CeWMhihZQrI46L71zk9wZu9qRco7RPE0E8eY4YpECEny4SxficK8HNd49GhRCcyxzUEHypWnk//4KK6COy/wUYUjfqkY25fT9IJ4jEAbT0QHG4xb1EorTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzER3uU2rtdNMJUHTm6Yht2JxnIuCVw7dgVhvgnB6Pg=;
 b=WnfA1D5DUD+ZT2LYCUXbH1Wk42gVtWSfBRimo5QcvHoVRzV6n+7HPDHm/Ipi+vHsRSSDHqFSMovg8zpYG5P2ItxeSIyiy+drFSPIOBynl+k2jO3KgsWcALMahC1dX8uRvWu/WZbPc7zEgjOmavF4rqErhPaF9H3E5iUC+bUDUzw=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA0PR12MB7673.namprd12.prod.outlook.com (2603:10b6:208:435::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Thu, 20 Oct
 2022 09:29:48 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::8bd7:b65c:13f4:9b]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::8bd7:b65c:13f4:9b%7]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 09:29:48 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: remove ras_error_status parameter for UMC
 poison handler
Thread-Topic: [PATCH 4/4] drm/amdgpu: remove ras_error_status parameter for
 UMC poison handler
Thread-Index: AQHY45KMQUXA+CvRWkCOllFDR+fL964XBY+Q
Date: Thu, 20 Oct 2022 09:29:48 +0000
Message-ID: <BN9PR12MB52577A091E6ABE7D897CC8F5FC2A9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20221019081150.31773-1-tao.zhou1@amd.com>
 <20221019081150.31773-4-tao.zhou1@amd.com>
In-Reply-To: <20221019081150.31773-4-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-20T09:29:46Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0d3c6c90-131d-49b7-b1b9-df1aea2103fb;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA0PR12MB7673:EE_
x-ms-office365-filtering-correlation-id: ab9e00e4-2728-41fe-f09a-08dab27da1d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TioYXkMj9k3d7GUkXrxEJ0hM9BLZDzD1bgZ53BHN3wG96nAzhl5UiE6MynJzoNzOTogHP4Y76Jn4UqM0lnNfttaqDTYjiH/+n84wtHc80M350SOOS6Why0L41c0wOoY3ba6wC4PEyegwL8hJIr+InrtvJra7yq1ZzY4s+Dqa4Jr5L8yrf8nfedyPREiRwng8HUKKYtBzMion8UhjUvNxWeh+8qBDlxXGv0niNCx8oqBPIOxoCL6pC2LROEoje7bfj7mkxBjcKDKByDtO2TL1y6BDO4JrWNR9QowQtdPASBp7ge9/QDGzEtmPPlBim803D2kFcx7+2rkO5XCgnFmSAeE6H75jx0iAbPFCV2IbzfsRPQUlQBgQpQEMyBLhl+n2oDgutk3qhx+wXoYAe3BOtK63uQzRM7g8sMkbApZxyEBtRgUxLHlQQxGQAZ1s93UU3hlzjU4k8dAIDGFIy/LGSc8uC/FqoCmd10TLQk+w4YEl0CStxa7CPA5hs480OvwD8WERUOyMRlH1O+2gIs9oJqPRsEXLZgCnvy3fmaqHNySRhfOUS/sYgvccnqBd29wj+bsslyLr4s2jhBoDqD2K+X9bc6NxKepof4Tp3qwwUvjKdbQBfsnbOQZ3cQ3onNzdpjNioL++3D+71kIsrNGsexCY2F0Iz8PR74mmaH/Z0sFj/XYLoHg6D7XNwovZ6/8PVYT1SfqbI6GrkJfVrNBNd4p5WduSnDcZ7QZcIMlXNwzWkfDkShIGCvdqo0g88wG6B754soWVx3dRTQLNUisEFw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199015)(7696005)(66476007)(8676002)(71200400001)(316002)(33656002)(66446008)(478600001)(6506007)(64756008)(6636002)(66946007)(76116006)(122000001)(66556008)(110136005)(41300700001)(38070700005)(55016003)(26005)(186003)(38100700002)(86362001)(83380400001)(53546011)(9686003)(5660300002)(52536014)(8936002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U3WzLxOjQLUvgdDeG72weyULQbqa2p42sgIrCwV8eijYpHN/cR33NfCx7w7W?=
 =?us-ascii?Q?cARoc+Pi25cnx7OuFytDbiXLHaB/3nT+vzVmiC+4wHCGG6kt9FXiSfInpeX9?=
 =?us-ascii?Q?vqxMMud8uZd3lBS3XwLFPRzt6qzEQVeW7rSIqmMcayleVsucJxxtC93YAuq2?=
 =?us-ascii?Q?H/nRocp8GzRBVnkYT4a7EOJH9h3CLzp8KGRZiROHMZH+YMO3ZlmwpR1PCiG6?=
 =?us-ascii?Q?iqCt4Zhb94YX5AlMVytO7rPXUMAlxmRqm714OuD7WvqNNMrhQFA972u6z6RV?=
 =?us-ascii?Q?GjxXfyYQ+pvuQ9xMciwcxkXyKu/PHS79FUiTvLbUBeSVGYF73l6QTFUudRlc?=
 =?us-ascii?Q?BVfjekKPnoIlwASvUwCNSWEJLbe6YTUUN+t7+Q2Mq1MvpiXSJo+0PuDw/aD8?=
 =?us-ascii?Q?8911L0e/06CFbMcd5eAk/Klk5nmpW6dxDgO7FLErxMl0dJGS1A8bl7s+zdwn?=
 =?us-ascii?Q?vVxusnW4omK1hiJPs7Z+RpNxvHwX+KN5vW0EbygbnXosuKdX80vOJ7BMFMA0?=
 =?us-ascii?Q?RFbVhB/za3711loQZh8jo0uIUXgwqv8QiyT1a5UcA/TUGvasQinYttt1Dh/F?=
 =?us-ascii?Q?8zWVQRZ7/xIyHNongFVZ3xbRlY+Nt1G0eojUadCucP/NPMNMEWbb/cVnCjw0?=
 =?us-ascii?Q?MDtv9o2dvc08MPrtkFpokGLbPcnGs5YinFTZvd1BmABYOa69jCqyS8ArKN4I?=
 =?us-ascii?Q?OSRKo6Wj4d7c3u7Oh4aH7U95TOgHBSg/53IRXsa2DIfuevgTAvE82296Qwrl?=
 =?us-ascii?Q?oXJvut0xQEq2TmLhPOVJgeUjkl4P3ecXVRTGkFiZN7PSfi3Iba5/Chcicnld?=
 =?us-ascii?Q?frnr6wy2CBQIO/g020lyAE5nxic18DKhksvtU6r26ULdRGYD2wbxOiiAOp3o?=
 =?us-ascii?Q?I4lenkGuYp2onX+517fqvqD+5G2ajhhE1zp7DEGxibfLpXL0uc+YxQVkJG6h?=
 =?us-ascii?Q?rNVh3iWeZEcix6iO2Kkzi0KliHZ7DAA30hFcTCqEyc22L7PqRKMIZC2ncn9o?=
 =?us-ascii?Q?wWku+5IwzHfPkFCHeUxBTEQfcjDxu+PpIbMv/HLojVOMDM8e3FFVUe2SMSP0?=
 =?us-ascii?Q?gefprrir1WoFdcqBEHHs7a5JjvSvbfTfVWhq4NYEALZxSJ482tnL4GUCYYBh?=
 =?us-ascii?Q?uP7m/dxZ5UKcdQE4hfT3rfmj28fFcI4953OzQvV/p8SsBqjlA/sZFpB4gL0x?=
 =?us-ascii?Q?kZL+3BkxpcRgVNYLFdD65fwF2He8gdQD9A08gN/2hpwgBlnscdf4ryPOWgz2?=
 =?us-ascii?Q?AC1vHt+3ow1FH/jM+/QNnnBay10sS07D95wW8iUWef+hrxtiiVBvRMCwHE1y?=
 =?us-ascii?Q?+esXxcmaYGUAWO4KwdNZRMfsQi28Rja7/ZCROSjbyvFrTNzv7985jw5TyCIb?=
 =?us-ascii?Q?sZb4WJJik78MaRkSPq8AdCy3NnBLWcI/BN7a/GPu7YW5ZZgzuKYZmNyLNK5u?=
 =?us-ascii?Q?NRaCa2Fj0+jStEi0ligenWGShQS9NV+KamgCccC1OP4jpr31WhSuCS1iymtt?=
 =?us-ascii?Q?vuyQFrDa4FKIde2tHrwzfiYUvf4YwNT6KYT8oQrGu2qB7M70Otjgb9faLq22?=
 =?us-ascii?Q?/+JMgOQeQC/YvcNAxT9/MUTN7QaMnIgcGK4EflQP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9e00e4-2728-41fe-f09a-08dab27da1d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 09:29:48.1399 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0fzAcD/r+j4PMTHRfHZPpbw4VJT7aC1VKn/AJRtCf4ati7Mv3dA5leZsI8h6agpDQ8RxUUsoa0TTq8ElM5ylqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7673
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

Might squash this with patch 1

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Wednesday, October 19, 2022 16:12
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c    | 16 ++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h    |  4 +---
 4 files changed, 9 insertions(+), 18 deletions(-)

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
index dd1b1a612343..c040c9104521 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -179,27 +179,23 @@ static int amdgpu_umc_do_page_retirement(struct amdgp=
u_device *adev,
 	return AMDGPU_RAS_SUCCESS;
 }
=20
-int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
-		void *ras_error_status,
-		bool reset)
+int amdgpu_umc_poison_handler(struct amdgpu_device *adev, bool reset)
 {
+	struct ras_err_data err_data =3D {0, 0, 0, NULL};
 	int ret;
=20
 	if (adev->gmc.xgmi.connected_to_cpu) {
-		ret =3D amdgpu_umc_poison_handler_mca(adev, ras_error_status, reset);
+		ret =3D amdgpu_umc_poison_handler_mca(adev, &err_data, reset);
 	} else {
-		struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_statu=
s;
 		struct ras_common_if head =3D {
 			.block =3D AMDGPU_RAS_BLOCK__UMC,
 		};
 		struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, &head);
=20
-		ret =3D
-			amdgpu_umc_do_page_retirement(adev, ras_error_status, NULL, reset);
-
+		ret =3D amdgpu_umc_do_page_retirement(adev, &err_data, NULL, reset);
 		if (ret =3D=3D AMDGPU_RAS_SUCCESS && obj) {
-			obj->err_data.ue_count +=3D err_data->ue_count;
-			obj->err_data.ce_count +=3D err_data->ce_count;
+			obj->err_data.ue_count +=3D err_data.ue_count;
+			obj->err_data.ce_count +=3D err_data.ce_count;
 		}
 	}
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.h
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
