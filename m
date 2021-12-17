Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FE3C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 16:45:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78BCF10E59E;
	Fri, 17 Dec 2021 16:45:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A357E10E59E
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 16:45:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q70nu5j54D1gOFYwyrYll5w9YWolgwtm6k0Zq/s43sJ+ElDFCoyvrWKTmmqXnZs5atmJ2PgTD8CYjziz/HayBJfd2wT9z0jITApW1F1Tfaq6hKJ5KEWrszxeT7LPs87jIaymu68dYUGzmXPBTjdIDsxD91cbsKezOG1Gay/WogS18+v4jzPNQSXXvlnAv0yOq98V7F9f7wotK/PtkUxuXEgoB39txOEbftH6yiVjx/lDamBVv+CFd5nwO4hoSpDmdVQuQsFMMxoonbgDz/VnzBQjhaKyheYnWOSak1aWwfRx40K+RwHUa1mt0bzJn8D4w1Yhoeei1YgQeQd1b4ELXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MD4dKskNDIR2HSvnGL+Q7zAs1wU8JksWweWJ/y3zOG8=;
 b=AFkC7+9fX0xx98iAkTJYGtBqs/9K7V0iOP6KVxT81/8PMcQaBlgLFF8tc7wQvgDqbz2P1oZ9ZdIeE3e3bxtsKe8qJo1PXFkdmdqPiRtAiBPHbVTJJ4xLSvUDkuOTKfFW5d1NdERBlFigRZSttXNZE8/NkjRBg0+30165dNPB1b/cYPDyw9Rk7CLK+KT7I6KrMVMSUIvV8I19T/kCsdorCDly8412qO1yvfpPcppcxb7C9wuG9DT26bJ9qyIJcF1eRdj26lBZ8DPd93TEhvY1Pasv6xpJ1aIg/DnmT3SxhjK7IKPnCProLhLIIRohniI/BsqkYAuTAQmE1k8fVuMcqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MD4dKskNDIR2HSvnGL+Q7zAs1wU8JksWweWJ/y3zOG8=;
 b=rWYTfut9tMg+PKihx7vSBNloqZvsb3EB21J5b58uuLPDaEab1ArgCGWN7fNgQDKCZvaZODYfPd9j+CNpNd/mRb9R814+57q6FcaQQfAEPwJ9/HMU/4ohw+JcRQDSEMXw7Nvn0At7TowKle7MSeb9uhS9R/+vKJkuA0xrhbL1K1M=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by CH0PR12MB5369.namprd12.prod.outlook.com (2603:10b6:610:d4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 16:44:59 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::31b4:ebc:1707:f563]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::31b4:ebc:1707:f563%8]) with mapi id 15.20.4778.017; Fri, 17 Dec 2021
 16:44:59 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Saye, Sashank" <Sashank.Saye@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Send Message to SMU on aldebaran passthrough
 for sbr handling
Thread-Topic: [PATCH] drm/amdgpu: Send Message to SMU on aldebaran passthrough
 for sbr handling
Thread-Index: AQHX81uBknBplA2VSkGfNdOPR8f4G6w23geg
Date: Fri, 17 Dec 2021 16:44:59 +0000
Message-ID: <CH0PR12MB5372EAFB8ECE025BA088D829F4789@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20211217153324.181888-1-sashank.saye@amd.com>
In-Reply-To: <20211217153324.181888-1-sashank.saye@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-17T16:23:06Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=122135e3-fada-41e2-a729-6a70502decbc;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-17T16:44:58Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 50838d97-868e-45a1-b937-4b19ef610024
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 753f3d13-dc08-4320-da5c-08d9c17c90b2
x-ms-traffictypediagnostic: CH0PR12MB5369:EE_
x-microsoft-antispam-prvs: <CH0PR12MB5369BA3AB1ADF69B9936BD2BF4789@CH0PR12MB5369.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zvw8z9XeuW1pVQzpsq78Hp0kEiOsJOXLp6JJ5iaCfZjcSHHZpp5pF7E/Nxzo6KG+tSppK1NfnWpf36dEo0MqjvoK7eQL5LQDRChY7UnA0C2qEjUvagn/4lA8JfuQqRS3IT1QOByUyQWirSYedf41MTUpEgQ2jpu/fNs0A3h2TtQQH44s7BCfkpbOVl3LHWpmbwVF5qCt0fvqF5LGw5N1LPFoBZmbLqGuCoBRbaGceJNTVi/AjUCoojDVomzdvsRutB8vOofoExji2m8tH7ZnghvMRB42bESyZXY12CKqKFpvncZUotwtbsse/aO/iW0keDCtgrEMuivgPVvTO0ieJuO0aS+kCZP6927tC/busWqlXePGaJKui4uQ0kA1Hy9KVVY103MqBgP6oT2o68E1TmG6rGgDmY0f6MXUsSykJ4NXEjOTgSzRZvfH6oakmCWI0oz3StUwBr7cu3ybKpKWks2g/NUIXhG0MCeCqJVy5KzDUhcj2HpH7exxFKUMVXeUGvqGWhfnHcrMUi/sjVw6iOdf3iRblYGpbDWxE3frZ1e1QFDxxpp0ru18+wR199fXnTl+L4ZAcQfElXyiT5O/U7+6vxuPnUUZ0CiIa4VNRV/pfZrCUUWz+yOaO6ThlPGnskbDM6vsxJ7OXfkkS2CATdKJpcj7jzv3yNM25BzzEadQXvNhK9a+3tX6mwtrL34s9dveFCS4dumZ3yvOnPj9pw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(52536014)(53546011)(15650500001)(83380400001)(71200400001)(33656002)(7696005)(122000001)(76116006)(66946007)(8676002)(38070700005)(4326008)(110136005)(86362001)(508600001)(6506007)(55016003)(186003)(64756008)(66476007)(9686003)(38100700002)(2906002)(5660300002)(8936002)(26005)(66446008)(66556008)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vnUnefq+anHGzalstatelQcaeHEUQzIrhzIWS9XD1niOmdhCuz6d4zRyeuJO?=
 =?us-ascii?Q?iNBOXKRjuXoiSMUA6FPqBt5GSnOoJTpaxTaeZRkjNhF30eHveKiT40mfP+95?=
 =?us-ascii?Q?yD9C5ByD0AZOb1IkG8T0M0mQ4pDfzY2aD+AlXE2IAhAs7YFT6A0U7T2xkduE?=
 =?us-ascii?Q?2jhovM09TluzKBskn0Gpd1Qhf2jWG5l0vVsxLLTrFqzs7hbBXla6gwH122bP?=
 =?us-ascii?Q?M3jv0Y5eb9rR0cN2nt08m3I4m/fS/rbq3iC3BdQJYtt5qlHAihdjyb4fFoir?=
 =?us-ascii?Q?F8+4c8xjhZe/EVbhR/i0g8Rdc1YRBI9ocEksxzpKWgZAZhpTQGR7nE9vomoH?=
 =?us-ascii?Q?4zCkJKvPjqzZGtlZwAJGGBbWc8wZ8bqI+zZ2cCTgA1t4GUrT7FaHwS8WhZmC?=
 =?us-ascii?Q?9IybPOOsrLP7PpVT6xSKjw72rJXwFXoXNCXs+oCRx6C4gGxkWCncswuvQBcV?=
 =?us-ascii?Q?hliRXZPomYnBSvqUG1UfTPieucw8b4feg0I19HzG6zaekSdo3rlzbsnebffa?=
 =?us-ascii?Q?iOLjrzmUEyIPGZt4gi5gu/PF2FmxBxau/orf5kTl6Df33kN540//Ya9B6qr4?=
 =?us-ascii?Q?SeuAt2VY284P6pZk6OMPEmDjqIiQjG+sYKqWSqjO5zXRBRCvVeMPW4QnmpFs?=
 =?us-ascii?Q?fDXZ/H6MQ4T5mud2L1equWhSQAllbKBoh4RWm+znMBqYT1PC6UAW1szqkbPO?=
 =?us-ascii?Q?isnrXt82o7f7wUARmRcP2fVvbbf5umDq6iVoSlG/RIwIObKak5cH7wrK85M+?=
 =?us-ascii?Q?Og40JGosfj3zlODuwYsz+zk3Il2+oREuF0hGVYs4cOa57BcGPsVsnBz9pN/9?=
 =?us-ascii?Q?d6I0UDOVo1yTOOl47w+MBiiU0s7YposR6R38Hx4TxkxTcgqR8pSEfTHaiDOm?=
 =?us-ascii?Q?kO2fl2kGP2/8PwyNyqIvWyOS7+Twx2SOwKerYOBtDWyU5HzzWAawkPg3i7rP?=
 =?us-ascii?Q?kLFBxTA4IfUYz0ASmGI1HBSf0TasiCiw5WuYvu2eqpV15BPE6BlmcRlge3I/?=
 =?us-ascii?Q?yaHG3rjjHXSaZrdRjVT554hdXakS7WFBdRa1FclcnT4f6dEuPEk6jjf8cCTJ?=
 =?us-ascii?Q?RvieY4+I2+qWV3ZmPX0B8MnAlLIP4gEv0pGLKKdHGN+wTx/I9WQG45FhMRrB?=
 =?us-ascii?Q?oLFYHYDo7p9Cp8MDRzN+d4TpB5KLfWLwlkn2g7i2aJIseFldf4JysTtx6n9D?=
 =?us-ascii?Q?2KJfpWMIB3HNoQDtaL+fLK66YOr7stHL7jUveVrE2WSSpGNGQpzjXoAbYAFR?=
 =?us-ascii?Q?Qjo3CX0bibJBRyzMpTXnR7RSglQlwe/+3ITYbEBukj2K3pTHd/DMBYxU6+8x?=
 =?us-ascii?Q?AwGUCI9QImxAjtqvxgFIYB1RfkLCh+nP9Q9p5WCPeqBoX0zJFCVmCGVWN9uH?=
 =?us-ascii?Q?3AEbrpd1fmws7VGvpalXrr+jwvEAjpMOMw99I6efkP08HkN9rdks8V3quoYB?=
 =?us-ascii?Q?6Lzz4ITH/I8rtiqHgkxzTkYzwKe+UelLSb4pl5I74Df1VRVvukHeNd0DLsdt?=
 =?us-ascii?Q?s4kk6zGT5CgNRMJWWGjbsXskPP/zsvtVSn9T+xKhrKIzEVmTydQUbIZVPVm5?=
 =?us-ascii?Q?SAW4iAr2qPx6H2ndjqX5zqAcNtLQdtZW6PnVvwHfAtjDPU3tsstUdmTAFkSM?=
 =?us-ascii?Q?yLcfGq7jtfyzE0bj5X+aPTc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 753f3d13-dc08-4320-da5c-08d9c17c90b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 16:44:59.5738 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n1/gdtgTC1FC0Sl9gWpasaZVsyNSLfrvoWWGFdEJJ0bLHrYzLWSH9dGBirkyGzQKM8eASSND5RoSCz3te8yujQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5369
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
Cc: "Saye, Sashank" <Sashank.Saye@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

First , the name of heavy SBR  is confusing when you need to go through  li=
ght SBR code path.=20
Secondary,  originally we introduce the light SBR is because on older asic,=
   FW can not synchronize the reset on the devices within the hive, so it d=
epends on driver to sync the reset.  From what I have heard , for chip aruc=
tus , the FW actually can sync the reset itself.  I don't see a necessary t=
o  introduce the heavy SBR message, it seems SMU will do a full reset  when=
 it get SBR  request.  IS there  a different code path  for SMU to handle t=
he reset  for XGMI in passthrough mode ? =20

Regards
Shaoyun.liu

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of sashank =
saye
Sent: Friday, December 17, 2021 10:33 AM
To: amd-gfx@lists.freedesktop.org
Cc: Saye, Sashank <Sashank.Saye@amd.com>
Subject: [PATCH] drm/amdgpu: Send Message to SMU on aldebaran passthrough f=
or sbr handling

For Aldebaran chip passthrough case we need to intimate SMU about special h=
andling for SBR.On older chips we send LightSBR to SMU, enabling the same f=
or Aldebaran. Slight difference, compared to previous chips, is on Aldebara=
n, SMU would do a heavy reset on SBR. Hence, the word Heavy instead of Ligh=
t SBR is used for SMU to differentiate.

Signed-off-by: sashank saye <sashank.saye@amd.com>
Change-Id: I79420e7352bb670d6f9696df97d7546f131b18fc
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  4 ++--
 drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h       |  4 +++-
 drivers/gpu/drm/amd/pm/inc/smu_types.h             |  3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 11 +++++++++++
 4 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index f31caec669e7..06aee23505b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2618,8 +2618,8 @@ static int amdgpu_device_ip_late_init(struct amdgpu_d=
evice *adev)
 	if (r)
 		DRM_ERROR("enable mgpu fan boost failed (%d).\n", r);
=20
-	/* For XGMI + passthrough configuration on arcturus, enable light SBR */
-	if (adev->asic_type =3D=3D CHIP_ARCTURUS &&
+	/* For XGMI + passthrough configuration on arcturus and aldebaran, enable=
 light SBR */
+	if ((adev->asic_type =3D=3D CHIP_ARCTURUS || adev->asic_type =3D=3D=20
+CHIP_ALDEBARAN ) &&
 	    amdgpu_passthrough(adev) &&
 	    adev->gmc.xgmi.num_physical_nodes > 1)
 		smu_set_light_sbr(&adev->smu, true);
diff --git a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h b/drivers/gpu/drm=
/amd/pm/inc/aldebaran_ppsmc.h
index 35fa0d8e92dd..ab66a4b9e438 100644
--- a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
@@ -102,7 +102,9 @@
=20
 #define PPSMC_MSG_GfxDriverResetRecovery	0x42
 #define PPSMC_MSG_BoardPowerCalibration 	0x43
-#define PPSMC_Message_Count			0x44
+#define PPSMC_MSG_HeavySBR                      0x45
+#define PPSMC_Message_Count			0x46
+
=20
 //PPSMC Reset Types
 #define PPSMC_RESET_TYPE_WARM_RESET              0x00
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/p=
m/inc/smu_types.h
index 18b862a90fbe..ff8a0bcbd290 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -229,7 +229,8 @@
 	__SMU_DUMMY_MAP(BoardPowerCalibration),   \
 	__SMU_DUMMY_MAP(RequestGfxclk),           \
 	__SMU_DUMMY_MAP(ForceGfxVid),             \
-	__SMU_DUMMY_MAP(UnforceGfxVid),
+	__SMU_DUMMY_MAP(UnforceGfxVid),           \
+	__SMU_DUMMY_MAP(HeavySBR),
=20
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 7433a051e795..f442950e9676 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -141,6 +141,7 @@ static const struct cmn2asic_msg_mapping aldebaran_mess=
age_map[SMU_MSG_MAX_COUNT
 	MSG_MAP(SetUclkDpmMode,			     PPSMC_MSG_SetUclkDpmMode,			0),
 	MSG_MAP(GfxDriverResetRecovery,		     PPSMC_MSG_GfxDriverResetRecovery,		=
0),
 	MSG_MAP(BoardPowerCalibration,		     PPSMC_MSG_BoardPowerCalibration,		0)=
,
+	MSG_MAP(HeavySBR,                            PPSMC_MSG_HeavySBR,         =
               0),
 };
=20
 static const struct cmn2asic_mapping aldebaran_clk_map[SMU_CLK_COUNT] =3D =
{ @@ -1912,6 +1913,15 @@ static int aldebaran_mode2_reset(struct smu_contex=
t *smu)
 	return ret;
 }
=20
+static int aldebaran_set_light_sbr(struct smu_context *smu, bool=20
+enable) {
+	int ret =3D 0;
+	//For alderbarn chip, SMU would do a mode 1 reset as part of SBR hence we=
 call it HeavySBR instead of light
+	ret =3D  smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_HeavySBR, enable ?=
=20
+1 : 0, NULL);
+
+	return ret;
+}
+
 static bool aldebaran_is_mode1_reset_supported(struct smu_context *smu)  {=
  #if 0 @@ -2021,6 +2031,7 @@ static const struct pptable_funcs aldebaran_p=
pt_funcs =3D {
 	.get_gpu_metrics =3D aldebaran_get_gpu_metrics,
 	.mode1_reset_is_support =3D aldebaran_is_mode1_reset_supported,
 	.mode2_reset_is_support =3D aldebaran_is_mode2_reset_supported,
+	.set_light_sbr =3D aldebaran_set_light_sbr,
 	.mode1_reset =3D aldebaran_mode1_reset,
 	.set_mp1_state =3D aldebaran_set_mp1_state,
 	.mode2_reset =3D aldebaran_mode2_reset,
--
2.25.1
