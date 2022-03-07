Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A3DC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 09:10:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D87410E5FC;
	Mon,  7 Mar 2022 09:10:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F04AE10E5FC
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 09:10:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kN0+MNugW+TIZGDdRrOnZa8MJkaq+bMeMUDRwOjrlJ8PcT2p7rYt6pDcBh46EURGF0wFZ4pLc2JqWH6WzMXDlwA4LMFZCNraIVsklJUvrPsF0LzhM0QFf7yiN1KL830MWVYUbruFcDrCoif8TqXBh1rgyqCmuY+rMNdGc8IJdh89S0ftqAH31K2nEuwOSlJPfa3IJ0+4r5Lq9S3FHgvkSpz52Ps4tmMwzF9wz3scV7td4snOHSbbUoaELIZ0boTicTd10vcgC9ac8i/nidr6ZAMpk4dtoFYbPPbgB+gNtJ98fmGXZi2qs43Vlho08kp0GA9zrStntMq0+ZG27Ulgyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0EEvGp62CuqpnazT9vHRfT3TSh8j2OBIXGCZHDWOU8=;
 b=BCvGMrbwhZzSd7UTpHi8Vb4ysvJ5AWBmZYEHAVKPpCb44fXdOYMAP2eZ8jJrQPNymcOIhNK70lfiCyJsWRku08VGbXzUlsDUHstj2a4gznPzRRPjwHVKvV37D9KtOlKiy6W+XkYJ7gE4+uPWJ30yzqNYzzZZ6uF9aiHMlVOIqe6r7jkuUFCU57f1t23r3rHIGO/AGXhkqALqGk+dPGHas3OBogrUpNxZTyJqAcsQX3/FUjuNZ4d7pIRQpKlGYrJZBIOaK4qWTQaJs3/d/wol2sNtvB3jfAZ9hOHtLlEC9Kje6vBmHEXFhSDVYQChY796eok0vEQ4Ialyhfq6aDkidA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0EEvGp62CuqpnazT9vHRfT3TSh8j2OBIXGCZHDWOU8=;
 b=B2r34Jqs1sS0ikXLTu9p3PBdq4RAtslWuKgowv2epKsI6L7fTFmIuJPKAkE3aQcDheLFSt224IokB6G07kZp5IeFra8nFG1wbaalhWJYHDdmHVfSG0xwG3C0Mgsu78xO95EjfkcF68cuW0av/d1Zkrz7icCxlb+1QJymiyPFecQ=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 BN8PR12MB3027.namprd12.prod.outlook.com (2603:10b6:408:64::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Mon, 7 Mar 2022 09:10:31 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::612d:cd2a:369b:17c6]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::612d:cd2a:369b:17c6%6]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 09:10:31 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2] drm/amdgpu: Move common initialization operations of
 each ras block to one function
Thread-Topic: [PATCH V2] drm/amdgpu: Move common initialization operations of
 each ras block to one function
Thread-Index: AQHYMf9z+xWDjyANRECGk+AEzag8/ayzod9w
Date: Mon, 7 Mar 2022 09:10:31 +0000
Message-ID: <DM5PR12MB2469A8BB6896786AB2059A7AF1089@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220307084259.1752140-1-YiPeng.Chai@amd.com>
In-Reply-To: <20220307084259.1752140-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1d66ae6-0321-4558-6a44-08da001a54cf
x-ms-traffictypediagnostic: BN8PR12MB3027:EE_
x-microsoft-antispam-prvs: <BN8PR12MB30279191C16E9F344530FCF1F1089@BN8PR12MB3027.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: loMbkOcrWh60XX5dLynj1G5YLNCKNGYXCT3Ocqr+F9bK5WhW9A3GBZl+XdtGHF9TaK3z5RYoVVYPWMkotTx5aJB9SgN0YZ5TDDsA01BRkkobPiM7+W/V2XaIYgPcBhqkAJ1WoHUdanQZCei++9yT8evwp8qTCtGojX8HesR1GV0GY9Lcst4srLsshCvOCoYOxIE1Z7leerDNeTteballR+7JFjv6Fy//TNntmWJtDsBa0ZIn3bPeRSJVcbi8HRHGE2LB9AnuYQ73yP/QsG/RlNlIWbPRGf+EjzvDxSX6d2eaiTd/RQFTXGsp93DDlLmySL20Nx9yvzFofVWGlfO7dB/wVxKBKV80P+GuwaYz6XYjRfeOsx9lzWim/PBGr2+BT7yUfTdRqs3EA0Egk5vBsYRjCIF204mcPY7aYA2XCn5p2CbnRVPR97Qh80JvDFD7JSq3krZ5vZQXfR4vxvRrswFzblhwC8wjt+4htDfOr2JMDaOSOtqPUdyPfpk+TkvXsuN+jA3YMwbFWtuf4QLTAxQPfR0a4+NwxwGENIZ8k47Uri5MoCadMDDy8uw4x3vr31RmAEya06JurB8TafDaxoEMYPAWRpLBOkvhLC/DSdskxgYoypw0lF5gkKvDjQzh4kn0LPtHOEbJxwiIFmJ4xVvcfUmjJSddz4LkWCentO+ABTtSt48zLi0s6xf0k4M1vY4j8d/c9ImlCVNyOtyE8A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(53546011)(83380400001)(54906003)(110136005)(6506007)(2906002)(7696005)(9686003)(316002)(8936002)(30864003)(52536014)(122000001)(508600001)(55016003)(71200400001)(5660300002)(33656002)(38100700002)(66556008)(66446008)(66476007)(64756008)(8676002)(4326008)(66946007)(76116006)(186003)(26005)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4l6gp7AcjC8zRBJY9rFGKwPaKR5O1oguWiNTbbWtg32Pfg+bZEPXMM8hfGe9?=
 =?us-ascii?Q?8FEPHnyWwGWoZmC2nWCjxtJijZdTOvFPaX//NErYcU1RitSUPI1SNUgQM2Py?=
 =?us-ascii?Q?jbIUa+rJul0HDF2gT2zmTdyN7usxWxk8eYxUHTz8KZDP/zN0PX5ndvpKh582?=
 =?us-ascii?Q?tiRIRul1pmHDSw2/+0HmxSc4oPgTYL7l+xjli5ClkcjKWJHm7bstCXG+/Ule?=
 =?us-ascii?Q?0FwJrY5R9jRUcYFypDjr4YDF+47XUYAHK2WK/QSa4pwalLi2dkEli7I1HAQx?=
 =?us-ascii?Q?dRrZunteukTKVEX5y1saXKFYKb0+OOstZh6Va6uKvba8HdX3fHc2Ck81zGX4?=
 =?us-ascii?Q?sacHxn16I9ICf7M1zD0pHf6E879bTqeSoKZkLXhfkWbCoYcbnVVwUrDBpFfh?=
 =?us-ascii?Q?CoBC/ehApZk9hSdmgG/ilXOigLVNmdBbtjzYSwPhAtlYsfZFrNbnWWx+baMP?=
 =?us-ascii?Q?Xf0iMrng3HMFhM+zYwqatApGrsSj6DaPSrLnoQGRApcW5UXg2DJ95NNS1/n+?=
 =?us-ascii?Q?0WNno+FbmwNNmbTmCnshSml6XvKeORoa71xF/xTz5czpPaYih2Tx9dFc6tOP?=
 =?us-ascii?Q?Cs6KXIB9EkjvIHK8Xyvw9u7BfVWAGapsjQb2AXcipKsKtjr9nSCfxsE6hE7k?=
 =?us-ascii?Q?RSsGTxhNVDfM3r0DqmXHuFhLdCX4mnHynQpXMiKHFK+fdvFYdooqU5iEfrN3?=
 =?us-ascii?Q?klphmEoQfk1XempjAvp5T3OTl6iWN3kOA0Ny1usxrmCbt1eMDyIuik3rz0+0?=
 =?us-ascii?Q?d3v0ckxJD2+9iDJsEdUqNsSTQyilcBpSeJd/cREm+BT1+wC4T0BYAMRYeRyU?=
 =?us-ascii?Q?4B0PMQjtW1+oDzwr5e9qeT7w9PpYorOmq/qzx/xhiCcR0BOkPOlWumcnzm1N?=
 =?us-ascii?Q?7yGoFKTBvFG0z97Dl7PY3JtWPNEWM51kQFWLHjtJ3sfGasxVMCpnXoifQexh?=
 =?us-ascii?Q?Z/AvOK6JzB3lf8EUAcMTRwoKUg8W2EtpbOe2z+WEt2Q2A3xgz7Lt2bwuJNel?=
 =?us-ascii?Q?vwU5tZ4H2sjTZUS5oQlNFfHW6keY02MaJF9nB0rlbSY90eQmrG4u1usVN7Ob?=
 =?us-ascii?Q?T4I0Rw59l6JPz2ttbDNvcM/NcZzDZyFRgWluZYOkzamZlQ6p2fe2r+co4GYj?=
 =?us-ascii?Q?KYHppSTU2mUAXTSCBzaclAAGccFx+qEogsmufJs6OkzZoI7xCESv11y7Ptxs?=
 =?us-ascii?Q?fsGc7QitKPFeOJNcMOjhtbPue2Sryero5TOJKeRwsBxG25Q70ZO4cIPSJGwX?=
 =?us-ascii?Q?G2V4YykaTe9qZibthxjI24iYOyg67FmKqf/MNWbC5zEhdwJwMOlMXAD6AsIi?=
 =?us-ascii?Q?+dEV1aLniDhGquyf+5Al7WWy8Ug9OEPX22oSzY5UGV5+9KBFlX+JcqHpqjDm?=
 =?us-ascii?Q?K7/Rt9wHLY3ATKEsrKIgYqIo7wzkez5CSlRba+WQJ118YBaTOUPqDCtiry5V?=
 =?us-ascii?Q?6JYMK4G2RrMTNxT+cZcU7vwWm40AP3WuOT+GZezt3iBDajfUaEOALjWNBpeu?=
 =?us-ascii?Q?TEP+F+yMuE26II0gJzZ6VbUh/9MiO7PiqxikwFEQkMQ2syubNjQK37Apf8D3?=
 =?us-ascii?Q?MUktbrH36ecSq0OSRPJHyear+O85D0P10Jg52J7AltUUHTF5aliv1IaTI/LU?=
 =?us-ascii?Q?lfFmvdL6dnbkjNPpkXRGMyg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d66ae6-0321-4558-6a44-08da001a54cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 09:10:31.7594 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y9vhR1mpQucc7GvmvrzDOEZavPcONye67bPFATUXguNqyMxpQXxBQq3uZUelG7uDzKhKX2cjikbRkxqbBvqRDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3027
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
Cc: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

if (!adev->gmc.xgmi.connected_to_cpu) {
 		adev->gmc.xgmi.ras =3D &xgmi_ras;
-		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras->ras_block);
-		adev->gmc.xgmi.ras_if =3D &adev->gmc.xgmi.ras->ras_block.ras_comm;
 	}

Coding style needs to be fixed as well. '{}' should be dropped as there is =
only one line after upper if.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of yipechai
Sent: Monday, March 7, 2022 4:43 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;=
 Clements, John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>=
; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH V2] drm/amdgpu: Move common initialization operations of ea=
ch ras block to one function

Define amdgpu_ras_sw_init function to initialize all ras blocks.

V2: Modify error debugging information.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |   2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 143 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  21 ---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     |  16 ---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  28 ----
 drivers/gpu/drm/amd/amdgpu/mca_v3_0.c      |   6 -
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |  17 ---
 9 files changed, 148 insertions(+), 92 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 6113ddc765a7..0c83eb69dad5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2402,6 +2402,12 @@ static int amdgpu_device_ip_init(struct amdgpu_devic=
e *adev)
 		}
 	}
=20
+	r =3D amdgpu_ras_sw_init(adev);
+	if (r) {
+		DRM_ERROR("amdgpu_ras_sw_init failed (%d).\n", r);
+		goto init_failed;
+	}
+
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_init_data_exchange(adev);
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index ab75e189bc0b..544241f357b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -440,8 +440,6 @@ int amdgpu_gmc_ras_early_init(struct amdgpu_device *ade=
v)  {
 	if (!adev->gmc.xgmi.connected_to_cpu) {
 		adev->gmc.xgmi.ras =3D &xgmi_ras;
-		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras->ras_block);
-		adev->gmc.xgmi.ras_if =3D &adev->gmc.xgmi.ras->ras_block.ras_comm;
 	}
=20
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index d3875618ebf5..89075ab9e82e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2299,8 +2299,6 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	case CHIP_ALDEBARAN:
 		if (!adev->gmc.xgmi.connected_to_cpu) {
 			adev->nbio.ras =3D &nbio_v7_4_ras;
-			amdgpu_ras_register_ras_block(adev, &adev->nbio.ras->ras_block);
-			adev->nbio.ras_if =3D &adev->nbio.ras->ras_block.ras_comm;
 		}
 		break;
 	default:
@@ -2533,6 +2531,147 @@ void amdgpu_ras_suspend(struct amdgpu_device *adev)
 		amdgpu_ras_disable_all_features(adev, 1);  }
=20
+int amdgpu_ras_sw_init(struct amdgpu_device *adev) {
+	int err =3D 0;
+
+	if (!amdgpu_ras_asic_supported(adev))
+		return 0;
+
+	if (adev->nbio.ras) {
+		err =3D amdgpu_ras_register_ras_block(adev, &adev->nbio.ras->ras_block);
+		if (err) {
+			dev_err(adev->dev, "Failed to register nbio ras block!\n");
+			return err;
+		}
+		adev->nbio.ras_if =3D &adev->nbio.ras->ras_block.ras_comm;
+	}
+
+	if (adev->gmc.xgmi.ras) {
+		err =3D amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras->ras_blo=
ck);
+		if (err) {
+			dev_err(adev->dev, "Failed to register xgmi ras block!\n");
+			return err;
+		}
+		adev->gmc.xgmi.ras_if =3D &adev->gmc.xgmi.ras->ras_block.ras_comm;
+	}
+
+	if (adev->gfx.ras) {
+		err =3D amdgpu_ras_register_ras_block(adev, &adev->gfx.ras->ras_block);
+		if (err) {
+			dev_err(adev->dev, "Failed to register gfx ras block!\n");
+			return err;
+		}
+
+		strcpy(adev->gfx.ras->ras_block.ras_comm.name, "gfx");
+		adev->gfx.ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__GFX;
+		adev->gfx.ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCOR=
RECTABLE;
+		adev->gfx.ras_if =3D &adev->gfx.ras->ras_block.ras_comm;
+
+		/* If not define special ras_late_init function, use gfx default ras_lat=
e_init */
+		if (!adev->gfx.ras->ras_block.ras_late_init)
+			adev->gfx.ras->ras_block.ras_late_init =3D amdgpu_gfx_ras_late_init;
+
+		/* If not defined special ras_cb function, use default ras_cb */
+		if (!adev->gfx.ras->ras_block.ras_cb)
+			adev->gfx.ras->ras_block.ras_cb =3D amdgpu_gfx_process_ras_data_cb;
+	}
+
+	if (adev->umc.ras) {
+		err =3D amdgpu_ras_register_ras_block(adev, &adev->umc.ras->ras_block);
+		if (err) {
+			dev_err(adev->dev, "Failed to register umc ras block!\n");
+			return err;
+		}
+
+		strcpy(adev->umc.ras->ras_block.ras_comm.name, "umc");
+		adev->umc.ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__UMC;
+		adev->umc.ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCOR=
RECTABLE;
+		adev->umc.ras_if =3D &adev->umc.ras->ras_block.ras_comm;
+
+		/* If don't define special ras_late_init function, use default ras_late_=
init */
+		if (!adev->umc.ras->ras_block.ras_late_init)
+			adev->umc.ras->ras_block.ras_late_init =3D amdgpu_umc_ras_late_init;
+
+		/* If not defined special ras_cb function, use default ras_cb */
+		if (!adev->umc.ras->ras_block.ras_cb)
+			adev->umc.ras->ras_block.ras_cb =3D amdgpu_umc_process_ras_data_cb;
+	}
+
+	if (adev->mmhub.ras) {
+		err =3D amdgpu_ras_register_ras_block(adev, &adev->mmhub.ras->ras_block)=
;
+		if (err) {
+			dev_err(adev->dev, "Failed to register mmhub ras block!\n");
+			return err;
+		}
+
+		strcpy(adev->mmhub.ras->ras_block.ras_comm.name, "mmhub");
+		adev->mmhub.ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MMHUB;
+		adev->mmhub.ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNC=
ORRECTABLE;
+		adev->mmhub.ras_if =3D &adev->mmhub.ras->ras_block.ras_comm;
+	}
+
+	if (adev->hdp.ras) {
+		err =3D amdgpu_ras_register_ras_block(adev, &adev->hdp.ras->ras_block);
+		if (err) {
+			dev_err(adev->dev, "Failed to register hdp ras block!\n");
+			return err;
+		}
+
+		adev->hdp.ras_if =3D &adev->hdp.ras->ras_block.ras_comm;
+	}
+
+	if (adev->mca.mp0.ras) {
+		err =3D amdgpu_ras_register_ras_block(adev, &adev->mca.mp0.ras->ras_bloc=
k);
+		if (err) {
+			dev_err(adev->dev, "Failed to register mca mp0 ras block!\n");
+			return err;
+		}
+		adev->mca.mp0.ras_if =3D &adev->mca.mp0.ras->ras_block.ras_comm;
+	}
+
+	if (adev->mca.mp1.ras) {
+		err =3D amdgpu_ras_register_ras_block(adev, &adev->mca.mp1.ras->ras_bloc=
k);
+		if (err) {
+			dev_err(adev->dev, "Failed to register mca mp1 ras block!\n");
+			return err;
+		}
+		adev->mca.mp1.ras_if =3D &adev->mca.mp1.ras->ras_block.ras_comm;
+	}
+
+	if (adev->mca.mpio.ras) {
+		err =3D amdgpu_ras_register_ras_block(adev, &adev->mca.mpio.ras->ras_blo=
ck);
+		if (err) {
+			dev_err(adev->dev, "Failed to register mca mpio ras block!\n");
+			return err;
+		}
+		adev->mca.mpio.ras_if =3D &adev->mca.mpio.ras->ras_block.ras_comm;
+	}
+
+	if (adev->sdma.ras) {
+		err =3D amdgpu_ras_register_ras_block(adev, &adev->sdma.ras->ras_block);
+		if (err) {
+			dev_err(adev->dev, "Failed to register sdma ras block!\n");
+			return err;
+		}
+
+		strcpy(adev->sdma.ras->ras_block.ras_comm.name, "sdma");
+		adev->sdma.ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__SDMA;
+		adev->sdma.ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCO=
RRECTABLE;
+		adev->sdma.ras_if =3D &adev->sdma.ras->ras_block.ras_comm;
+
+		/* If don't define special ras_late_init function, use default ras_late_=
init */
+		if (!adev->sdma.ras->ras_block.ras_late_init)
+			adev->sdma.ras->ras_block.ras_late_init =3D amdgpu_sdma_ras_late_init;
+
+		/* If not defined special ras_cb function, use default ras_cb */
+		if (!adev->sdma.ras->ras_block.ras_cb)
+			adev->sdma.ras->ras_block.ras_cb =3D amdgpu_sdma_process_ras_data_cb;
+	}
+
+	return 0;
+}
+
 int amdgpu_ras_late_init(struct amdgpu_device *adev)  {
 	struct amdgpu_ras_block_list *node, *tmp; diff --git a/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 7cddaad90d6d..fc5ed6c47443 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -595,6 +595,7 @@ amdgpu_ras_error_to_ta(enum amdgpu_ras_error_type error=
) {
=20
 /* called in ip_init and ip_fini */
 int amdgpu_ras_init(struct amdgpu_device *adev);
+int amdgpu_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_ras_late_init(struct amdgpu_device *adev);  int amdgpu_ras_fini=
(struct amdgpu_device *adev);  int amdgpu_ras_pre_fini(struct amdgpu_device=
 *adev); diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/d=
rm/amd/amdgpu/gfx_v9_0.c
index 8def7f630d4c..e26fc2ae98e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2188,27 +2188,6 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_dev=
ice *adev)
 		break;
 	}
=20
-	if (adev->gfx.ras) {
-		err =3D amdgpu_ras_register_ras_block(adev, &adev->gfx.ras->ras_block);
-		if (err) {
-			DRM_ERROR("Failed to register gfx ras block!\n");
-			return err;
-		}
-
-		strcpy(adev->gfx.ras->ras_block.ras_comm.name, "gfx");
-		adev->gfx.ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__GFX;
-		adev->gfx.ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCOR=
RECTABLE;
-		adev->gfx.ras_if =3D &adev->gfx.ras->ras_block.ras_comm;
-
-		/* If not define special ras_late_init function, use gfx default ras_lat=
e_init */
-		if (!adev->gfx.ras->ras_block.ras_late_init)
-			adev->gfx.ras->ras_block.ras_late_init =3D amdgpu_gfx_ras_late_init;
-
-		/* If not defined special ras_cb function, use default ras_cb */
-		if (!adev->gfx.ras->ras_block.ras_cb)
-			adev->gfx.ras->ras_block.ras_cb =3D amdgpu_gfx_process_ras_data_cb;
-	}
-
 	adev->gfx.config.gb_addr_config =3D gb_addr_config;
=20
 	adev->gfx.config.gb_addr_config_fields.num_pipes =3D 1 << diff --git a/dr=
ivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0=
.c
index d9353bb99314..5046be86702f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -669,22 +669,6 @@ static void gmc_v10_0_set_umc_funcs(struct amdgpu_devi=
ce *adev)
 	default:
 		break;
 	}
-	if (adev->umc.ras) {
-		amdgpu_ras_register_ras_block(adev, &adev->umc.ras->ras_block);
-
-		strcpy(adev->umc.ras->ras_block.ras_comm.name, "umc");
-		adev->umc.ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__UMC;
-		adev->umc.ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCOR=
RECTABLE;
-		adev->umc.ras_if =3D &adev->umc.ras->ras_block.ras_comm;
-
-		/* If don't define special ras_late_init function, use default ras_late_=
init */
-		if (!adev->umc.ras->ras_block.ras_late_init)
-				adev->umc.ras->ras_block.ras_late_init =3D amdgpu_umc_ras_late_init;
-
-		/* If not defined special ras_cb function, use default ras_cb */
-		if (!adev->umc.ras->ras_block.ras_cb)
-			adev->umc.ras->ras_block.ras_cb =3D amdgpu_umc_process_ras_data_cb;
-	}
 }
=20
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 4c3483fbe613..8f6aefb9be08 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1228,23 +1228,6 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_dev=
ice *adev)
 	default:
 		break;
 	}
-
-	if (adev->umc.ras) {
-		amdgpu_ras_register_ras_block(adev, &adev->umc.ras->ras_block);
-
-		strcpy(adev->umc.ras->ras_block.ras_comm.name, "umc");
-		adev->umc.ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__UMC;
-		adev->umc.ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCOR=
RECTABLE;
-		adev->umc.ras_if =3D &adev->umc.ras->ras_block.ras_comm;
-
-		/* If don't define special ras_late_init function, use default ras_late_=
init */
-		if (!adev->umc.ras->ras_block.ras_late_init)
-				adev->umc.ras->ras_block.ras_late_init =3D amdgpu_umc_ras_late_init;
-
-		/* If not defined special ras_cb function, use default ras_cb */
-		if (!adev->umc.ras->ras_block.ras_cb)
-			adev->umc.ras->ras_block.ras_cb =3D amdgpu_umc_process_ras_data_cb;
-	}
 }
=20
 static void gmc_v9_0_set_mmhub_funcs(struct amdgpu_device *adev) @@ -1278,=
15 +1261,6 @@ static void gmc_v9_0_set_mmhub_ras_funcs(struct amdgpu_device=
 *adev)
 		/* mmhub ras is not available */
 		break;
 	}
-
-	if (adev->mmhub.ras) {
-		amdgpu_ras_register_ras_block(adev, &adev->mmhub.ras->ras_block);
-
-		strcpy(adev->mmhub.ras->ras_block.ras_comm.name, "mmhub");
-		adev->mmhub.ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__MMHUB;
-		adev->mmhub.ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNC=
ORRECTABLE;
-		adev->mmhub.ras_if =3D &adev->mmhub.ras->ras_block.ras_comm;
-	}
 }
=20
 static void gmc_v9_0_set_gfxhub_funcs(struct amdgpu_device *adev) @@ -1297=
,8 +1271,6 @@ static void gmc_v9_0_set_gfxhub_funcs(struct amdgpu_device *a=
dev)  static void gmc_v9_0_set_hdp_ras_funcs(struct amdgpu_device *adev)  {
 	adev->hdp.ras =3D &hdp_v4_0_ras;
-	amdgpu_ras_register_ras_block(adev, &adev->hdp.ras->ras_block);
-	adev->hdp.ras_if =3D &adev->hdp.ras->ras_block.ras_comm;
 }
=20
 static void gmc_v9_0_set_mca_funcs(struct amdgpu_device *adev) diff --git =
a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mca_v3=
_0.c
index d4bd7d1d2649..3d2b974f6e0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
@@ -129,12 +129,6 @@ static void mca_v3_0_init(struct amdgpu_device *adev)
 	mca->mp0.ras =3D &mca_v3_0_mp0_ras;
 	mca->mp1.ras =3D &mca_v3_0_mp1_ras;
 	mca->mpio.ras =3D &mca_v3_0_mpio_ras;
-	amdgpu_ras_register_ras_block(adev, &mca->mp0.ras->ras_block);
-	amdgpu_ras_register_ras_block(adev, &mca->mp1.ras->ras_block);
-	amdgpu_ras_register_ras_block(adev, &mca->mpio.ras->ras_block);
-	mca->mp0.ras_if =3D &mca->mp0.ras->ras_block.ras_comm;
-	mca->mp1.ras_if =3D &mca->mp1.ras->ras_block.ras_comm;
-	mca->mpio.ras_if =3D &mca->mpio.ras->ras_block.ras_comm;
 }
=20
 const struct amdgpu_mca_funcs mca_v3_0_funcs =3D { diff --git a/drivers/gp=
u/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 01b385568c14..fe61fcd22f18 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2809,23 +2809,6 @@ static void sdma_v4_0_set_ras_funcs(struct amdgpu_de=
vice *adev)
 	default:
 		break;
 	}
-
-	if (adev->sdma.ras) {
-		amdgpu_ras_register_ras_block(adev, &adev->sdma.ras->ras_block);
-
-		strcpy(adev->sdma.ras->ras_block.ras_comm.name, "sdma");
-		adev->sdma.ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__SDMA;
-		adev->sdma.ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__MULTI_UNCO=
RRECTABLE;
-		adev->sdma.ras_if =3D &adev->sdma.ras->ras_block.ras_comm;
-
-		/* If don't define special ras_late_init function, use default ras_late_=
init */
-		if (!adev->sdma.ras->ras_block.ras_late_init)
-			adev->sdma.ras->ras_block.ras_late_init =3D amdgpu_sdma_ras_late_init;
-
-		/* If not defined special ras_cb function, use default ras_cb */
-		if (!adev->sdma.ras->ras_block.ras_cb)
-			adev->sdma.ras->ras_block.ras_cb =3D amdgpu_sdma_process_ras_data_cb;
-	}
 }
=20
 const struct amdgpu_ip_block_version sdma_v4_0_ip_block =3D {
--
2.25.1

