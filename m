Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D1AC28D13
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Aug 2022 02:35:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76992AA281;
	Tue, 23 Aug 2022 02:35:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D214AA257
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Aug 2022 02:35:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBxi/uuIVIx+//wyDafYy164KDTJUudKDOVkECm2pIZtYCJ89wNMOcNhf0Ncdh2cEdX94EAIuWqN3MIyi45Z4jh2rRni3T7n05FuvZMytNuuaiMxMloQaY7YGKEgRHq6dS0yZwhXMSTf2a9pYf073XsPEjGqn/mvNyikXRotFCIT0EMKS65X1g06WisQcGucvmzk1fIrPSiUKLEca/QAG+aBCVXMdSaY30BO6Lo3suJqIolVToepDukY3OtP627JvuwXtwmSwYc/bTmQhnHPZ/qoav3rKIitbXeaLY6RfSSkeH7MJBhx5vNeSYwlrh9FbGeF9gEwC32RjqoDMFMsRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjQ+5/u6R47cwVw+4I1FSIh6kMDMoN8lDOqD5QGVRIY=;
 b=R4Lw7DjKi5x1FMNMUC1NMsCi3DHbmjoENARDKRBCANrwxGoFqVTmENOa7SfdeSNobB5rMkYY8U1j7cOsOCNItKpoX+mch3VX62NJZen3ExH27nv+hVVxA+lW4/C+/zeaiZhjf80Oni5Ds/J+kEFB/vpsAOE7WuW6fqCDAYf4DLP0GPIvXyZMOVNzlQgZjvktXbUELELALJpQMnd/JLQTatKoPRq+VK3fNy9K829KC1vl65LS3ZqWRuc5/tJonzuWgWqfu2nrn0tqncHE+aoDaZ7VyaDuzhdJGsHU4dTttmOx2C6bAYKzcrQoDfgI3RaBvQ6TMAhDcsIteS750Hku7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjQ+5/u6R47cwVw+4I1FSIh6kMDMoN8lDOqD5QGVRIY=;
 b=UTLfRNaDKQC/Hy5mbNXDxYMPfnea20zcDMJCcJIS6Had4bE02/r6drF1m3gfq8OJ+iT4jaoVp506O9F0WvzZWf1uJgnsrrean34ojnFVO93IOz9XbLRFgIZ2KTwkuVvhcz48B5di7hme3nIOyr44Oj/b+Bgc6qC3O3gWzyWXFHQ=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 BY5PR12MB4276.namprd12.prod.outlook.com (2603:10b6:a03:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Tue, 23 Aug
 2022 02:35:02 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::bd9a:516b:ca81:3b46]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::bd9a:516b:ca81:3b46%7]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 02:35:01 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: improve BAMACO code for smu_v13_0
Thread-Topic: [PATCH] drm/amd/pm: improve BAMACO code for smu_v13_0
Thread-Index: AQHYtpSBmuBL7CJIEEGtOqeTGqSje627xI6w
Date: Tue, 23 Aug 2022 02:35:01 +0000
Message-ID: <DM5PR12MB2469DA2A1BDB0FF92756EAB4F1709@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220823020247.2545671-1-kenneth.feng@amd.com>
In-Reply-To: <20220823020247.2545671-1-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d3eacaa-a255-45db-4044-08da84b01400
x-ms-traffictypediagnostic: BY5PR12MB4276:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o7X181kUXcNZjvTlNPVyizfOVwMyR5l983shGuwbMJf1VpUO55ywAVYKXD8sQzzkroipsj9aLS+zTFQHlmo1XXdVVGeGfMKGwKc4SG/I7mMPDDEWatNMhBPcrvL0omKfiXbkubSq6gcihdesAf5HHF9uE0SU1jXxkvWtztfKbTfcMQMB2gQFFmyxWdPZR0jAxZDt+9Jwpn6xmRGTAZfMCis1BsrGuQ0bwbiz8mJY9s6jRUKiCt6YhzN3b0Kpn2H1HWr4ECJe64MBALAtwqP8pYg4oozmJK4FQp0eSMZI8aVQd19cMDnzMMrOJAMHK2+sA7fDt4GwLvlhG4Dp9qe0VVQ2WhCKbKH8h79VetmGxKeeSw0GNlneRRliE1Jzpj4CmhSCGUX6dlzwhO7PsfGtEBWiBP0cWGO9ZzaXnzcqwq8HCrDRNhtzvZclq92NzFJApXJOHQa7XBduUTZ336WadYPUVvQpxDvRrOmz2C7nhST/36OmJ70DhCT5P9u9xEXqkjZgxM8BVeShNHsq8R9onEcKh5Uz02wJMOHKmY2xlN5vu69KONlW8VFSkJDr1TIcDHsJ5bDLFtuHNYKRiiBNeMq15S6qYviBpYFMHLHiAzxTfsTc5eg5KflTYT447brOzyAUkYI9AUdNTkc7aLGCx6m0bFzdiW2c0VDI6Eopa1Wkn2WqbQPnG90V3kfBnaQXXFHeXJWtk/jf4KfXGXpl0KTqgtLyQ2QWglfo826hMSz8xnHVLDp1/8/iiK6fV/nz4sYQ2vlodSLvjVB9Zpkr7Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(186003)(55016003)(8676002)(66556008)(66476007)(66446008)(64756008)(4326008)(66946007)(7696005)(2906002)(76116006)(6506007)(110136005)(83380400001)(38100700002)(9686003)(122000001)(316002)(53546011)(38070700005)(26005)(8936002)(86362001)(5660300002)(478600001)(71200400001)(33656002)(52536014)(41300700001)(30864003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TycN8f9A/yommm+lqfC5KHmh27LElxBeKf2HPnazzmdvpwkkBAkpZOlcZbZu?=
 =?us-ascii?Q?eu9gLam6zKVaqUR2x0W1BHH5uC5z/I7uooQzTNRnNUdwOwbwGObY9xZk04ra?=
 =?us-ascii?Q?lRE94PP9VpSO9TzRDXPnSdCwDzMftfjQ+P3wjORRHYHKwXe5qxFC/5KHRS9K?=
 =?us-ascii?Q?dArrct1A/lzfDY4JNusp+brnS0dvsZVMqZPrEKaM5kLC9jb0EMB2CAPl+hJ/?=
 =?us-ascii?Q?tIQIlQztyTLt+/RbHAGGPICDMquibwWTnrcrHZzrEO1sWleRMzv89OvK+zip?=
 =?us-ascii?Q?8tzvu3ODMelNz66GbwXWz/nmJLesjpl6GFZTdJiHwpNBCviHInMmErtU8ThG?=
 =?us-ascii?Q?xzb8Cwa7gqUhLYMWdKrDQlLXKEJAAHdlTeuPCwdH+hLA8grsMURFZYL+pVb1?=
 =?us-ascii?Q?6uoj+8X44cWhLW8eR4rZEg+Z+7zR55UXCAiivGED0ebl9wNxOQtt9rkJmonX?=
 =?us-ascii?Q?zKeZOuhgU5TZzX+tyIj1in5+X5duWLgrLx9WIIGeflvu0I15tVZxcwzq4kbe?=
 =?us-ascii?Q?xf6YDVTTEwh/PQwUujVkeXsq58H7aNfxZbVYSGj5R5D6UGqdMdIkNMK8znqz?=
 =?us-ascii?Q?WRILj5zu/tfMDgapkP8BsSRMf0xW2wN1HtjTRl3IkBW5mj47TN9tW4lpjLjI?=
 =?us-ascii?Q?wgODwK/wlIza/M5HVKToDVuZl0WQT3f+4+iUzRe/CYfynqcc8L8oSF7Jb5Wh?=
 =?us-ascii?Q?TtfrofYeXCYdCdk8hG1l8IsXx9gzedJdhPn/zD+W1+C02m3+A38sbTVk1Pv+?=
 =?us-ascii?Q?1IxZhR/hNtTr9YjKFxKwjp2zhTpIAh+NZhgOWTXPxXd8GnanSKEgToKQW2fA?=
 =?us-ascii?Q?S3l8oXuwIuTLdKqHPZc4dZZMK9eZhcvRDvwarlG1k/71+PDkRsaGynp9jNuN?=
 =?us-ascii?Q?hdcXrwXH5EL92v7Q3F3xJdUBEuluganx/JC+jrfdhgw7NkCRExMpjLI7Ab6r?=
 =?us-ascii?Q?l9xt40ISXVermlZf4VTaUZ1JWyQLflzfdDBdfvob5iU1P/e0aygULA6JSg8r?=
 =?us-ascii?Q?uePTl7ggXpmHp1fRgqQgpC6wnvw3i8Ex0jcNpQlcQi6ZZTq/HZaTlBENyNRu?=
 =?us-ascii?Q?G6PPVlkxRGU0NXpTCRh238iPz80m7kTDVzgrCIGSGTNfWPQgIbYHuHK6vQMp?=
 =?us-ascii?Q?WQ8IDGhJTpm4H33oWqqPKPEij0QpDW4bCd2Xju1rM+/B4xTlJ3UdH20vyp4z?=
 =?us-ascii?Q?3zlzIEKbJx4W/amaymBl5Di84XHkfP3hWHsSfIPk0SPopq+9xH4C0ldexrWf?=
 =?us-ascii?Q?JyrfvXEJMtncKbzxj4HiAuT7RSrfWhVp5aHKt62azu+KaGtlylOOKgKRZaIy?=
 =?us-ascii?Q?gSpUCBfjUUWr15cYEe3Sh4D0pDYUzQAccWQ5HHEWRRPQP/+SwYpSwuHIoWPW?=
 =?us-ascii?Q?gkZFI9Krv3oZIjiMqZiJcBXJF30E4HQrncyCe/+KSkhj6yJ5jPEBbsu0/FCu?=
 =?us-ascii?Q?u/oiVGShJHnw9giNufD7OE0KXdtl1ghS6iYBRF0RSr5TQT1I6RHNWbtt68/z?=
 =?us-ascii?Q?YR9chUPPLqNYMruej679ddCujTTS4quhJi1q1Kcp55T+g5CLPTcbk2OfIdhN?=
 =?us-ascii?Q?M7mMD73PCpfwpijL6gtV/hjXhxMzYbDdj/i/4TGp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3eacaa-a255-45db-4044-08da84b01400
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 02:35:01.0705 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 13t9fGdvQ/16kRwLQwWRA8loFTpEco51CjiMLrqKYwXj2e5MSBPpQVe5YBVTgWeV4/3VIEc+Y2NAzcnRbN6ANw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4276
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

* Skip SMU FW reloading in case of using BACO for runpm only,
 	 * as SMU is always alive.

Above comment needs to be updated to cover BAMACO.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth =
Feng
Sent: Tuesday, August 23, 2022 10:03 AM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: improve BAMACO code for smu_v13_0

For runtime pm case:
1. prompt in dmesg for BAMACO feature test 2. set BACO by defatul and the u=
ser can select BAMACO

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  7 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       | 10 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  3 ++-
 drivers/gpu/drm/amd/amdgpu/soc21.c            |  1 +
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 23 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 16 +++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +  drivers/gpu/drm/amd/=
pm/swsmu/inc/smu_v13_0.h  |  1 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 17 +++++++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  1 +  .../drm/amd/pm/swsmu=
/smu13/smu_v13_0_7_ppt.c  |  1 +
 14 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 1372e2b47541..104bb62db830 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -598,6 +598,7 @@ struct amdgpu_asic_funcs {
 	uint64_t (*get_pcie_replay_count)(struct amdgpu_device *adev);
 	/* device supports BACO */
 	bool (*supports_baco)(struct amdgpu_device *adev);
+	bool (*supports_maco)(struct amdgpu_device *adev);
 	/* pre asic_init quirks */
 	void (*pre_asic_init)(struct amdgpu_device *adev);
 	/* enter/exit umd stable pstate */
@@ -1289,6 +1290,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);  #=
define amdgpu_asic_need_reset_on_init(adev) (adev)->asic_funcs->need_reset_=
on_init((adev))
 #define amdgpu_asic_get_pcie_replay_count(adev) ((adev)->asic_funcs->get_p=
cie_replay_count((adev)))
 #define amdgpu_asic_supports_baco(adev) (adev)->asic_funcs->supports_baco(=
(adev))
+#define amdgpu_asic_supports_maco(adev)=20
+(adev)->asic_funcs->supports_maco((adev))
 #define amdgpu_asic_pre_asic_init(adev) (adev)->asic_funcs->pre_asic_init(=
(adev))
 #define amdgpu_asic_update_umd_stable_pstate(adev, enter) \
 	((adev)->asic_funcs->update_umd_stable_pstate ? (adev)->asic_funcs->updat=
e_umd_stable_pstate((adev), (enter)) : 0) @@ -1329,6 +1331,7 @@ bool amdgpu=
_device_supports_px(struct drm_device *dev);  bool amdgpu_device_supports_b=
oco(struct drm_device *dev);  bool amdgpu_device_supports_smart_shift(struc=
t drm_device *dev);  bool amdgpu_device_supports_baco(struct drm_device *de=
v);
+bool amdgpu_device_supports_maco(struct drm_device *dev);
 bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
 				      struct amdgpu_device *peer_adev);  int amdgpu_device_baco_enter(=
struct drm_device *dev); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev=
ice.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ebb722811dcf..a034295fae71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -272,6 +272,13 @@ bool amdgpu_device_supports_baco(struct drm_device *de=
v)
 	return amdgpu_asic_supports_baco(adev);  }
=20
+bool amdgpu_device_supports_maco(struct drm_device *dev) {
+	struct amdgpu_device *adev =3D drm_to_adev(dev);
+
+	return amdgpu_asic_supports_maco(adev); }
+
 /**
  * amdgpu_device_supports_smart_shift - Is the device dGPU with
  * smart shift support
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c
index 95bce47943bb..4c022785ded1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -171,13 +171,19 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev=
, unsigned long flags)
 				adev->pm.rpm_mode =3D AMDGPU_RUNPM_BACO;
 			break;
 		default:
-			/* enable BACO as runpm mode on CI+ */
-			adev->pm.rpm_mode =3D AMDGPU_RUNPM_BACO;
+			/* enable BACO/BAMACO as runpm mode on CI+ */
+			if (amdgpu_runtime_pm =3D=3D 2 && amdgpu_device_supports_maco(dev))
+				adev->pm.rpm_mode =3D AMDGPU_RUNPM_BAMACO;
+			else
+				adev->pm.rpm_mode =3D AMDGPU_RUNPM_BACO;
 			break;
 		}
=20
 		if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BACO)
 			dev_info(adev->dev, "Using BACO for runtime pm\n");
+
+		if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BAMACO)
+			dev_info(adev->dev, "Using BAMACO for runtime pm\n");
 	}
=20
 	/* Call ACPI methods: require modeset init diff --git a/drivers/gpu/drm/a=
md/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index b067ce45d226..b363c729b9b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2374,7 +2374,8 @@ static int psp_load_smu_fw(struct psp_context *psp)
 	 * Skip SMU FW reloading in case of using BACO for runpm only,
 	 * as SMU is always alive.
 	 */
-	if (adev->in_runpm && (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BACO))
+	if (adev->in_runpm && (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BACO ||
+						   adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BAMACO))
 		return 0;
=20
 	if (!ucode->fw || amdgpu_sriov_vf(psp->adev)) diff --git a/drivers/gpu/dr=
m/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 1ff7fc7bb340..f21653fbe69c 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -511,6 +511,7 @@ static const struct amdgpu_asic_funcs soc21_asic_funcs =
=3D
 	.need_reset_on_init =3D &soc21_need_reset_on_init,
 	.get_pcie_replay_count =3D &soc21_get_pcie_replay_count,
 	.supports_baco =3D &amdgpu_dpm_is_baco_supported,
+	.supports_maco =3D &amdgpu_dpm_is_maco_supported,
 	.pre_asic_init =3D &soc21_pre_asic_init,
 	.query_video_codecs =3D &soc21_query_video_codecs,  }; diff --git a/drive=
rs/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd=
_pp_interface.h
index 7e3231c2191c..43635d238451 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -389,6 +389,7 @@ struct amd_pm_funcs {
 	int (*set_hard_min_fclk_by_freq)(void *handle, uint32_t clock);
 	int (*set_min_deep_sleep_dcefclk)(void *handle, uint32_t clock);
 	int (*get_asic_baco_capability)(void *handle, bool *cap);
+	int (*get_asic_maco_capability)(void *handle, bool *cap);
 	int (*get_asic_baco_state)(void *handle, int *state);
 	int (*set_asic_baco_state)(void *handle, int state);
 	int (*get_ppfeature_status)(void *handle, char *buf); diff --git a/driver=
s/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 956b6ce81c84..b3e373046928 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -209,6 +209,29 @@ bool amdgpu_dpm_is_baco_supported(struct amdgpu_device=
 *adev)
 	return ret ? false : baco_cap;
 }
=20
+bool amdgpu_dpm_is_maco_supported(struct amdgpu_device *adev) {
+	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
+	void *pp_handle =3D adev->powerplay.pp_handle;
+	bool maco_cap;
+	int ret =3D 0;
+
+	if (!pp_funcs || !pp_funcs->get_asic_maco_capability)
+		return false;
+
+	if (adev->in_s3)
+		return false;
+
+	mutex_lock(&adev->pm.mutex);
+
+	ret =3D pp_funcs->get_asic_maco_capability(pp_handle,
+						 &maco_cap);
+
+	mutex_unlock(&adev->pm.mutex);
+
+	return ret ? false : maco_cap;
+}
+
 int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev)  {
 	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs; diff --=
git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/=
amdgpu_dpm.h
index 65624d091ed2..911a293d95b2 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -50,6 +50,7 @@ enum amdgpu_runpm_mode {
 	AMDGPU_RUNPM_PX,
 	AMDGPU_RUNPM_BOCO,
 	AMDGPU_RUNPM_BACO,
+	AMDGPU_RUNPM_BAMACO,
 };
=20
 struct amdgpu_ps {
@@ -388,6 +389,7 @@ int amdgpu_dpm_baco_reset(struct amdgpu_device *adev); =
 int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev);
=20
 bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev);
+bool amdgpu_dpm_is_maco_supported(struct amdgpu_device *adev);
=20
 bool amdgpu_dpm_is_mode1_reset_supported(struct amdgpu_device *adev);  int=
 amdgpu_dpm_mode1_reset(struct amdgpu_device *adev); diff --git a/drivers/g=
pu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.=
c
index 7510d470b864..11e611edb874 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2723,6 +2723,21 @@ static int smu_get_baco_capability(void *handle, boo=
l *cap)
 	return 0;
 }
=20
+static int smu_get_maco_capability(void *handle, bool *cap) {
+	struct smu_context *smu =3D handle;
+
+	*cap =3D false;
+
+	if (!smu->pm_enabled)
+		return 0;
+
+	if (smu->ppt_funcs && smu->ppt_funcs->maco_is_support)
+		*cap =3D smu->ppt_funcs->maco_is_support(smu);
+
+	return 0;
+}
+
 static int smu_baco_set_state(void *handle, int state)  {
 	struct smu_context *smu =3D handle;
@@ -2984,6 +2999,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs =3D {
 	.set_active_display_count         =3D smu_set_display_count,
 	.set_min_deep_sleep_dcefclk       =3D smu_set_deep_sleep_dcefclk,
 	.get_asic_baco_capability         =3D smu_get_baco_capability,
+	.get_asic_maco_capability         =3D smu_get_maco_capability,
 	.set_asic_baco_state              =3D smu_baco_set_state,
 	.get_ppfeature_status             =3D smu_sys_get_pp_feature_mask,
 	.set_ppfeature_status             =3D smu_sys_set_pp_feature_mask,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index b81c657c7386..6bd5777b8780 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1134,6 +1134,7 @@ struct pptable_funcs {
 	 * @baco_is_support: Check if GPU supports BACO (Bus Active, Chip Off).
 	 */
 	bool (*baco_is_support)(struct smu_context *smu);
+	bool (*maco_is_support)(struct smu_context *smu);
=20
 	/**
 	 * @baco_get_state: Get the current BACO state.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_v13_0.h
index 6fe2fe92ebd7..f2f76fac28ea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -218,6 +218,7 @@ int smu_v13_0_get_max_sustainable_clocks_by_dc(struct s=
mu_context *smu,
 					       struct pp_smu_nv_clock_table *max_clocks);
=20
 bool smu_v13_0_baco_is_support(struct smu_context *smu);
+bool smu_v13_0_maco_is_support(struct smu_context *smu);
=20
 enum smu_baco_state smu_v13_0_baco_get_state(struct smu_context *smu);
=20
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 3651f6f75068..6db051eb6aa5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2278,6 +2278,21 @@ bool smu_v13_0_baco_is_support(struct smu_context *s=
mu)
 	return true;
 }
=20
+bool smu_v13_0_maco_is_support(struct smu_context *smu) {
+	struct smu_baco_context *smu_baco =3D &smu->smu_baco;
+
+	if (amdgpu_sriov_vf(smu->adev) ||
+	    !smu_baco->maco_support)
+		return false;
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_BACO_BIT) &&
+	    !smu_cmn_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT))
+		return false;
+
+	return true;
+}
+
 enum smu_baco_state smu_v13_0_baco_get_state(struct smu_context *smu)  {
 	struct smu_baco_context *smu_baco =3D &smu->smu_baco; @@ -2298,7 +2313,7 =
@@ int smu_v13_0_baco_set_state(struct smu_context *smu,
 	if (state =3D=3D SMU_BACO_STATE_ENTER) {
 		ret =3D smu_cmn_send_smc_msg_with_param(smu,
 						      SMU_MSG_EnterBaco,
-						      smu_baco->maco_support ?
+						      (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BAMACO) ?
 						      BACO_SEQ_BAMACO : BACO_SEQ_BACO,
 						      NULL);
 	} else {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index df4a47acd724..28d54e671a1a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1845,6 +1845,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_fun=
cs =3D {
 	.deep_sleep_control =3D smu_v13_0_deep_sleep_control,
 	.gfx_ulv_control =3D smu_v13_0_gfx_ulv_control,
 	.baco_is_support =3D smu_v13_0_baco_is_support,
+	.maco_is_support =3D smu_v13_0_maco_is_support,
 	.baco_get_state =3D smu_v13_0_baco_get_state,
 	.baco_set_state =3D smu_v13_0_baco_set_state,
 	.baco_enter =3D smu_v13_0_baco_enter,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 1016d1c216d8..459a6096e552 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1632,6 +1632,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_fun=
cs =3D {
 	.get_pp_feature_mask =3D smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask =3D smu_cmn_set_pp_feature_mask,
 	.baco_is_support =3D smu_v13_0_baco_is_support,
+	.maco_is_support =3D smu_v13_0_maco_is_support,
 	.baco_get_state =3D smu_v13_0_baco_get_state,
 	.baco_set_state =3D smu_v13_0_baco_set_state,
 	.baco_enter =3D smu_v13_0_baco_enter,
--
2.25.1

