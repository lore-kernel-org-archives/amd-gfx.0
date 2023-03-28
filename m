Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE80C76195
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 07:00:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 400CB10E0B4;
	Tue, 28 Mar 2023 07:00:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD05910E0B4
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 07:00:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQ8MFJL5haxi4+IBx/Xwt5do0kw7enLmoWDbEx2RNRHYGt/5Za5uHIbIU+qQTfsH4UeCaHIk/8lcxlUtu4wNzdBNUTxVkez9fl174SO6iScE0mNs3fE2m9PjmW5AxvRmcLaoCqKQQmWqmmZEHGWVAJfDoOk5KI/BFsi2Zx8zVZdMCGjZcmNwFBmApQrefuD+bQ+rCmtKFR4Ik83MLBVbC4hgwCKjRIlPf7WCwDJO4MfUY+XzJRTopv6h3GfTvT3SM9+4blZIQyLThok5yigT+aRzjdM1gqQPV0Fgsnqbaa9OxyNBZH77SbnnPnYRXBaWtbjuc8IXvCpTpJX3Z1f5yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/+aA9U2JFgU2IMbeDE8Wmqr3AJnOSIlYG+Fswm2DVc=;
 b=CijXCPupxYrH6rN5ZzkE1sMKiDxHT9tUnPnQ6PgNMxtQYseEkD+bY09ZcRQXqz1bbGsE11/YdF+LJgx9yFERRm/xoKS3Xg5t0q4PlzJL8IExnNbmnMi9ypyYalaXhUP3RSfiOfQF6cJ0+9Nn2WmebjLJDv6/Y9DXRra7CI3Io0SPD316VQstRMUoM5P9t0wWpYc9zjaiUsSsUbF22fVbvJ4hH86XIAgNWnHW7EOeoTlaKH2dAMRGdQ7STeai8gDal17DRnF9T8/wTby1/AgM3OSQ4EuKyEjjnIn184HmaMiTXJ40YIMF7khUun3d227zQqNBSyB6AHe31MWDh6ZoaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/+aA9U2JFgU2IMbeDE8Wmqr3AJnOSIlYG+Fswm2DVc=;
 b=qY1QL695t3A3tVh+IQuvHaf1QAhxNLJosEqe+LqznfKizFjE3dic6vTbwqL+NGjguxPm7UeIckRvtIs4/zmb3EKriaYO8zdvHejSxhDUokyZaY+anDGod4WVUtReY6kxdU9YXMa8OVVluSkQx+R3TiGfJXn9mKJLjuNNS8C3MAI=
Received: from DM4PR12MB5072.namprd12.prod.outlook.com (2603:10b6:5:38b::22)
 by BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 07:00:39 +0000
Received: from DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::5507:c08a:ac3a:997]) by DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::5507:c08a:ac3a:997%7]) with mapi id 15.20.6222.030; Tue, 28 Mar 2023
 07:00:39 +0000
From: "Chen, Horace" <Horace.Chen@amd.com>
To: "Zha, YiFan(Even)" <Yifan.Zha@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Chang, HaiJun" <HaiJun.Chang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add JPEG IP block to SRIOV reinit
Thread-Topic: [PATCH] drm/amdgpu: Add JPEG IP block to SRIOV reinit
Thread-Index: AQHZYSrc1SE8PZcFWUCHci4ekboDIq8PwdEQ
Date: Tue, 28 Mar 2023 07:00:39 +0000
Message-ID: <DM4PR12MB50720F3988FCDBCCD6B53893E1889@DM4PR12MB5072.namprd12.prod.outlook.com>
References: <20230328040650.3306297-1-Yifan.Zha@amd.com>
In-Reply-To: <20230328040650.3306297-1-Yifan.Zha@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3b4e1c3f-bb76-46f8-b1d9-586976c08040;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-28T06:54:00Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5072:EE_|BL1PR12MB5827:EE_
x-ms-office365-filtering-correlation-id: 2d7b622c-4fdc-4ca2-b032-08db2f5a23b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: llzX//qFh8o47ET/b3pXq/aLhPwwjwDkHc5kctvQz3LZXmQlsYbg7P1Y5GVX7oHMcD1TQrAiOgyJfll0tbevYW2eWmkIvWJS6b6F2D4/k6OwIcdLfMHTqOs3QQoFK2m3qYl5nBxkwiio4JSGXisimo+6OEGWw4jOu5ymAN+maMEvs4ECxtQUxt31dD/PCyK/AuHXv3bgwNGFLTRkGidsKkM4r3m/WT53QLv5wy8s+sfPrqwIlBdmfau6b09VsxGFv1rQjOriv+2gDsHAlUfXppTS1GZfxUWKJBzKKrc7Gyo2nVMljvuCuOECcmqn19Gcup2FDQ0o9WTqVZOg8F4uE2Dj9cxhDlBFGxGzu5xy6bHUHLfBaZongXTl+KP2E/WbUqxFvn7cjOz5qlopGrbuxXqgOgj1o/CfbaI5Tn5BBDGwgRIicIeaEKWCaiF40bn1iyyvEprqOEjoFwK1VM1MSCV+rCvFWGK5XC8ycAe+n9EpUTpTXg66yI2C1HogUVa74+KVEiwMJUOSEjOJ3gaUCjOoxHjMNX1uc4xUbZjvKBJGVeykkbW1zvYUzld1wvUr3krS+Aw+6+W6Wfg7QbhL14HaiS/LLdZhgY6cjOY2pmQ/Mss2fCzSUzU6Iyz+7jtn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199021)(64756008)(478600001)(316002)(6636002)(110136005)(38070700005)(122000001)(8936002)(5660300002)(86362001)(52536014)(2906002)(38100700002)(76116006)(66446008)(66556008)(66946007)(33656002)(66476007)(8676002)(55016003)(41300700001)(4326008)(9686003)(186003)(83380400001)(26005)(6506007)(53546011)(71200400001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?22GIIBp+dsPp5cmeIFZBm90FcjhZA9BtNjlJgMIOd2xKYz580HR7nOBWmnha?=
 =?us-ascii?Q?0LLboydTcIcihaBGTLWzLXqyDUA0p1GHkwjVISh/vRibC70t+wxPdUq4FwdD?=
 =?us-ascii?Q?gt2O5ikD0kOPvaF2ICKLdBNJPm+dR6jdNZoqmBLrm0VMLGzXY6DCnSILbRXR?=
 =?us-ascii?Q?/CXbqJQCO1hes+G15690XMzXHzI690QMj+DScCSJem1f6kfLS/oXZ9jLfp4y?=
 =?us-ascii?Q?WDSzlNEnHjbOZETiVONK9aEjTvL7YJOKExeodPcHj3WL7u4bm6jvA6b1bq3V?=
 =?us-ascii?Q?e1YeSbzL1Ipno6O8zyb6GgHU42kFEi0l9FvyhIr/EXNEZ6Vp1Gne5c/kr9DL?=
 =?us-ascii?Q?U9u6CBlDOsYkePAm9ixzfQ8P+jMZbWHNpUa5BJTpT+yR1UH1JwHAoQMdprR9?=
 =?us-ascii?Q?f9MFFyEdn23APdMqKxeo5cKnQ8NPKikzpDTuQYDkfscyQyPgTU5EVPjiYEe7?=
 =?us-ascii?Q?xxCpaafJIVhxriZLyuynEYNktvlmWgidwU3Ghp19epHexZ9I3oyjFTxW53pc?=
 =?us-ascii?Q?VBBCtdO2XJ56BO5JCAWyYsc/+oCPGWtzXQcw9bk6n1SlAFMISsyDz1yO+lss?=
 =?us-ascii?Q?8tLBPzFtB/3VcCg+Ov2Gi9gHE+gyQShO5IkYA+P2WeD9g4RjMb8b2uALCeSp?=
 =?us-ascii?Q?34OwpHQMkygt5dOcKNNqsSrBuhbKV+8Cuydl6xLIOsVDQn69IAMi9x01MFu0?=
 =?us-ascii?Q?1q5YUi++G9knnWOooo0jMgcURCGA/Ivw8Igh2g+9KXPAiPKOx7mYsYtjGtbY?=
 =?us-ascii?Q?K5RHkA4c9hRiVE+ACq7sT6T4enc40IXml2Q02gLxIWEEY4knq73ryyolNtU7?=
 =?us-ascii?Q?fc8W23hxAOfwOgECbNI+348OQGZWHSwJdiT+imgzZx6EY/2g5m/s3rOlaTXi?=
 =?us-ascii?Q?G6F7a+banSlBwhFipqySqZ5ZQHxoCwq0gZpyTjNRzXOiRzPZScHRIM3iZxAa?=
 =?us-ascii?Q?CKR6Nla0MY05do5kx5qqDSlbGOpThqNQkytJijLt6RXORswr9A1LNdzPZEg9?=
 =?us-ascii?Q?Pd/zJ7JhjpEIUvYF/M0qxmoBx19sT42buUZ5P0nYNHPWCfNuKTl2u6Uj0raz?=
 =?us-ascii?Q?5H7zEoPwbSWkYpDqC3hqPfIG5RBzishs9yJ708hWhb3Ac5qYjGmGlq5TbltE?=
 =?us-ascii?Q?HQD0UPTYrODX7n7cUszEBlfGb4zioug+3feaRryW3EMc2rGDifKI9Ao7UZBY?=
 =?us-ascii?Q?+nxCqCEQOgxac1oDGGnFGZ2zS++q7cmTiCCsLjNAFUUlBN39qprmbAeZahnE?=
 =?us-ascii?Q?iti8sVn8GoJOynXmCCphKV7C0nLIdLrGpgXUD/CmrCBDo4N3C5Ap9Q1MB/BL?=
 =?us-ascii?Q?s0xKPmOw4pKvqu9yWEeRXYxqQpiww2aTzrAOu6GnTKwItK5+zJUqYOr9m4we?=
 =?us-ascii?Q?rUAH9MpwFuUYph++mpr6u9Qp/7Zi2HBGWIPpkVZ6PTbXu2/zXgpBkdj1BGcX?=
 =?us-ascii?Q?sriPyCalWHsKH+RyrmqVAfh6vcwuWbPFkDrDX8eE7NCCvEcjbMZ78iW3zgfm?=
 =?us-ascii?Q?Sz2pPej9ADFi5c0jk4Ma34DT851flrU1lx4KjBL+iSi6UNRMVA7E5/ZFNGo3?=
 =?us-ascii?Q?Zrowe/4q0//SqCns5PI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7b622c-4fdc-4ca2-b032-08db2f5a23b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 07:00:39.4981 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jNSV2Tl4IBesTZjzDVRB5cYSMI/cJwe5fnakiDzBEkIZFtKgqLq0RQymjI2SiY2Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5827
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
Cc: "Zha, YiFan\(Even\)" <Yifan.Zha@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Horace Chen <Horace.Chen@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yifan Zh=
a
Sent: Tuesday, March 28, 2023 12:07 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Chen, Horace <Horace.Chen@amd.com>; Zhang, Hawking <Hawking.Zhang@a=
md.com>; Chang, HaiJun <HaiJun.Chang@amd.com>
Cc: Zha, YiFan(Even) <Yifan.Zha@amd.com>
Subject: [PATCH] drm/amdgpu: Add JPEG IP block to SRIOV reinit

[Why]
Reset(mode1) failed as JPRG IP did not reinit under sriov.

[How]
Add JPEG IP block to sriov reinit function.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 065f5396d0ce..3b6b85d9e0be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3183,7 +3183,8 @@ static int amdgpu_device_ip_reinit_late_sriov(struct =
amdgpu_device *adev)
                AMD_IP_BLOCK_TYPE_MES,
                AMD_IP_BLOCK_TYPE_UVD,
                AMD_IP_BLOCK_TYPE_VCE,
-               AMD_IP_BLOCK_TYPE_VCN
+               AMD_IP_BLOCK_TYPE_VCN,
+               AMD_IP_BLOCK_TYPE_JPEG
        };

        for (i =3D 0; i < ARRAY_SIZE(ip_order); i++) {
--
2.25.1

