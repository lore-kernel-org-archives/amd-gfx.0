Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C75C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Apr 2022 19:46:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B8D710E1D3;
	Tue, 19 Apr 2022 19:46:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA71B10E10C
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 19:46:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/Nz+RlJNwD999eGj/L1b4wy5l3jckQua5pJg1EAlA5626xQAU9/274gf8m/Ya8fgMqtiC2otFJERxctOhQ/uI7YH9jd8XrieGA8he4WHyAwl7/7+58ndQedFmleDpidTmBUd+RuJEThLHivbP+GkkJFtTnGPEZThkVpa6X7lisuCJTuT91B/erYWX1A9/UMmK9EPm2DPvjYyb9A6d2C2Zc6XLxE0BuirA0c+l8+iUr6kSnneAkY1pqkGHxEtZiqCd3MPGQDvfuLxPNTdgMfdXYVC5UqN0ebcYF1WUK83xYadmeRPHLwXb+W1foGlGHo2oFIB8s5TLYF7JV7PZU+mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9Z2FKNFaxWIptKQT0IjLQKv8OBrUB1exvbo8rw669k=;
 b=ZB3Xut+51RBkjvoQQh/oR++LH8fOV3o8i3pZ0GG2z0Xait75Idfr6efSddzTdzcA/AUB8dQm9Z17uKlFeqfT2Jrz1QRm8tzaY3WHcvemPCGt+lLTxVdmp9TcCzhH0XG3be2U30j2ehVCnvuGfso70Pd99fkZA4+RZZ3P/lo5nZv1MQdlNHWN/FH5GYmmr/vcKwxe9hldxFShUXpHgoh5fRZ3Ryc/ZRk6BeBa4aagxofIaYWW+nwxyBjiIS9/mV9eoGxJVOidhrmYtKUyWjjBCFygRlSRl1vIVa62F4Cou0IiYHzs2sLH7bIoh8Rsnh62AMT0/RfEl4iZpqr4zJ3v+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9Z2FKNFaxWIptKQT0IjLQKv8OBrUB1exvbo8rw669k=;
 b=NueNgaFreo+m584/41nSK/qm0IFBSuuY5GmlUR6Oll9rllmsIu5z7YOKht4Xd3SGvwnC89yyjgIb8jFzXm0W3mHWMfuY4WJjkGwaXH1Ol3doELnrCmCNVN8wQnmOWrXzbDh2DfVFkdn39XdW6Z2/QdvE3OxXePW203SmlC84ci0=
Received: from DM6PR12MB3963.namprd12.prod.outlook.com (2603:10b6:5:1cd::29)
 by CH0PR12MB5202.namprd12.prod.outlook.com (2603:10b6:610:b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 19:46:16 +0000
Received: from DM6PR12MB3963.namprd12.prod.outlook.com
 ([fe80::58c7:fc3b:9fc3:d926]) by DM6PR12MB3963.namprd12.prod.outlook.com
 ([fe80::58c7:fc3b:9fc3:d926%7]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 19:46:16 +0000
From: "Wong, Alice" <Shiwei.Wong@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Bokun" <Bokun.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Free ucode bo memory during load failure v1
Thread-Topic: [PATCH 2/2] drm/amdgpu: Free ucode bo memory during load failure
 v1
Thread-Index: AQHYVCUpgPa39LBSCE6meMrr5ml8aqz3o9ZA
Date: Tue, 19 Apr 2022 19:46:16 +0000
Message-ID: <DM6PR12MB39635295926D9A6700D60F31EBF29@DM6PR12MB3963.namprd12.prod.outlook.com>
References: <20220419193852.1886705-1-shiwei.wong@amd.com>
In-Reply-To: <20220419193852.1886705-1-shiwei.wong@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-19T19:46:14Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=6953a849-8cb0-4956-a8d9-330d07b3aed0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-04-19T19:46:14Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 063bda7b-5ff6-406c-a4b0-69928270700e
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37ed609c-9ca4-47b9-fc41-08da223d4484
x-ms-traffictypediagnostic: CH0PR12MB5202:EE_
x-microsoft-antispam-prvs: <CH0PR12MB5202598954EB6A7303FA7458EBF29@CH0PR12MB5202.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yPFq7PYhTLzSbqF6DHX/gGkUuwmY/JDk9+dAfYMYINVCKDZLfPKR02B5NMEZnwZjs2Pw3g1Zc8YYuCx+OPoz4jUxsiPiHQbcvj5+tcmviUiHBCB6hrG5Su000HmLlvCl1+RvKE4WrBogvn8ZK23atkKk7Zgu4B63E3WLmzIzLDCecFl3NeGqmIMevTT11mOvpzfmU/oIzImC1PLoj642864yTQ8f3ZPwXJz9rnE8F1eKRTHQk2nAMR3OnJtFjfdoiUTHAV/VkGrRawGfM0LKs3m2mVcMGjvpLlnhCUYSyPvVKuJ+Ir+wZ8D9eGRDobS9zUJt9OAV82fC1i6njSoe//0Mjem7gaXoAR3+ffmIcQLP7K/ULqvU+vXEKIMSrwCa7jlTSF/zjYawbIPCooNlfmySS6Y5F1A31t3aa+fzIfCvvdOXBiZ4cVRfVMs3G+Y65dV8TBCsrtb0sllWs0NFbrGgmHjhGZqU7j7/scW4xfNpa8qeZ417yZEWaeqluZeoKxUDx3u7GJGOlNknCsTp0ZNbQ3PMvHGAUmm1aSh4Bh6Vf6L2lAl3jGw8P2oQEwWAOoaHxNCiY874AoSfLybf/Cmx7YhjrBkjrl3YTGrMMzT/BAHoKOGHyI8ECq0+Wdb5roDejtEwHrxKhOFCzG12qZ2H8pk3y9Dgju3gi0KY/d7c6N2Lc5xrb7HMqwt8rlezpQhbW/Q3fWARuu7hFHQNoQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3963.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(83380400001)(64756008)(122000001)(2906002)(5660300002)(6506007)(38070700005)(86362001)(9686003)(55016003)(7696005)(186003)(26005)(66556008)(316002)(66946007)(38100700002)(33656002)(66446008)(76116006)(8676002)(110136005)(6636002)(52536014)(71200400001)(8936002)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MBJkouHlnJnZW1cMw8qxbCXb/1mOw3jEn6zhXeFwofkCpxiAKFMXLIz6nrKv?=
 =?us-ascii?Q?XqmGhXMUoVKlw0622ErKUZXAV/B5qupzAAjjDKBQBF7rCNnTkbDcW70vgGdV?=
 =?us-ascii?Q?TfolVrxVQjxFs91i6k00E3jPh5Aa5fqoekXThS3D2RqXMkIv3ucgT9iUlu5A?=
 =?us-ascii?Q?0l+KncsSF8prKP5NIOUENybr6MeY/0eHMfa0gmlFntZil5D2GrZVn4oDW5w0?=
 =?us-ascii?Q?vl9zOcnfwFoDBTAqX6tOUsxmFS626ZX7m+NG4/IqlOvKan9FBIbY6H9yM+zX?=
 =?us-ascii?Q?kfR5KuA8NcGhvvPUiTasLQRRqswe+qXd4fk8ob7G2GYyCGpRyA51djh0QuCL?=
 =?us-ascii?Q?Sf3X4dpZkT71+AHqQDdT46UkOS9UtCLNQ1BSVZdvhurorrgOm/s5j0iqAyeh?=
 =?us-ascii?Q?Q0aKHh/GjLmcSwWpn+cn8S3oiVyCT8B0GztL1pNSsU8yF5ryq5mJyFTWICdC?=
 =?us-ascii?Q?e3EUx5jtsignflrZCAxVKiNvA8Dthkhc8hIkAOLuZtW5ojQTYmGKpF2IND7K?=
 =?us-ascii?Q?areqBaInKGfuO1Hn5AT8XpsbilTrZNm3bC4P29c7DSDNSmHzSfa1R5f4zdEB?=
 =?us-ascii?Q?EMwns2NQHnvgg5qShvDQCsTPA8lf4EWUJLa4hfPhzUMbWT2+SAtvPd83Wf4/?=
 =?us-ascii?Q?CnIABPvmUIVvg91T/ylajkT5doabe89PB7OEyG3oiaBCH0xDl/Pz2YOtclXe?=
 =?us-ascii?Q?wzp/nh17aMCRSMyFwU67bqrWVl+d6oUyVi8UZXp73yk8qbuWHUswI5ilJiUB?=
 =?us-ascii?Q?+4fIpbzJ4Yv+eZGVuoIRXiyddPNv02qJhrf/zSm0MVS8adXnkl+ehXJRwbrb?=
 =?us-ascii?Q?AJ/pWUH8K0Amt6Y/IIR5aelW2AvrQZgEydGzIHyjWnCpLq0kt2iU8AoXmVtU?=
 =?us-ascii?Q?FXiIflnjqd8A0tcEGPMzaKOLd+2Ir/goFPn+EC9en/+BjfkCXQsNIjEdWg/7?=
 =?us-ascii?Q?tcWfbfF306dZrYg5Tigof38vUZAX8Jt3zJXmj+yAC0du1dfTNDxIIrXpeFil?=
 =?us-ascii?Q?lBmtADmzj+BXhQweEnt+4M1wLgN04k2XTwsm/0NS5BtZeAkJ0/3lBtKyIBss?=
 =?us-ascii?Q?WQVyVFg45VbaQeulZ2YGywlKnBmxRiP/8FovTRIddifmzYxgWumbpdG+cQBw?=
 =?us-ascii?Q?FAKWxoqVji23Uk07cHrVG7YDaAR3kgUIrcT7YTAOjOi2qfAbpKh1QK02FtHE?=
 =?us-ascii?Q?0gvF2HEJZLjhQqi2Cv+u4FHXTprMhgSXTpugs9/dZ8Qdd+bF9K/kBZzi1w6o?=
 =?us-ascii?Q?vRfjqZ/fRdOv5NMtBwYyqJ4U5HfZ3rrl8hW39/hmcGYmUEU3MiYbJK3p9JUe?=
 =?us-ascii?Q?YFUfbhsYu38umDPoMUggD+16zJ004kPQjhd2lcBylEMOl4VjCPX4bg/pfy8x?=
 =?us-ascii?Q?Nkou05D26MJFqk42dQDfxD/fkr14WEse+zz89sQ0Op0wuS7GrD265bBLEKc+?=
 =?us-ascii?Q?VwUnhpZP27hU60gxZ2Pe3xfdnkIedSXmDhlshdPz+eUKWI+l+9+nroCYpoIq?=
 =?us-ascii?Q?kA+C8RxRlXpatm98wozyjXLcezziR07xhPs+GcXYvaIcfZzNH7m2OQ+30udi?=
 =?us-ascii?Q?x1fmKnVOWSeoxqs3XG1mZtnjU4LkDWwnfCdBjRNYDDB8U/lbV0zhJHHLGu/F?=
 =?us-ascii?Q?FVR5b/sNaTnz9jLBNeLvdFr1HAXCU5lGnnb4j+br8hfF/wo0qpgu48AlIpO1?=
 =?us-ascii?Q?0EtPduYN5TdkezGnQ6pC0IMYXYEqWHqAfEwWjIEtFMKBwVOq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3963.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ed609c-9ca4-47b9-fc41-08da223d4484
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 19:46:16.3636 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z9YCY/ErwS8qlAINwt96muetsZovi88LnKJ4OX9YppnBc1bfVSKrJS5S6Ib0t7YV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5202
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


Remove firmware.load_type check in amdgpu_ucode_free_bo.
If psp failed to load a firmware, it will set formware.load_type to AMDGPU_=
FW_LOAD_DIRECT for bring up purposes. This caused memory leak as amdpug_uco=
de_free_bo will skip freeing memory due to the load_type.

BUG:SWDEV-332449

Signed-off-by: Alice Wong <shiwei.wong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.c
index ca3350502618..da787cc2b6b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -714,10 +714,9 @@ int amdgpu_ucode_create_bo(struct amdgpu_device *adev)
=20
 void amdgpu_ucode_free_bo(struct amdgpu_device *adev)  {
-	if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_DIRECT)
-		amdgpu_bo_free_kernel(&adev->firmware.fw_buf,
-		&adev->firmware.fw_buf_mc,
-		&adev->firmware.fw_buf_ptr);
+	amdgpu_bo_free_kernel(&adev->firmware.fw_buf,
+						&adev->firmware.fw_buf_mc,
+						&adev->firmware.fw_buf_ptr);
 }
=20
 int amdgpu_ucode_init_bo(struct amdgpu_device *adev)
--
2.25.1
