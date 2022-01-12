Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D66C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 15:15:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FE6210E18C;
	Wed, 12 Jan 2022 15:15:44 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A29910E18C
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 15:15:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMNT0HeyIgiOqqyVXnjT9JBBOkzd8sqvl7nABCnirng+1D3U6U2DOTrrLbiUI9O9AIG4w8NglwTvwT90TkRayd/1MyFbTZtUkL7C25eXSW9/FdTgpZx5ZKzmtkepM0s8GObpf4sTmfleAG1zUuwHEAWd2Td9Ynl1Bnf3crQSU9X+O5xkz+4z7CxEyFKit0KEX/ZDwKUKT/ogtACtEXV3u14pL4hxJS/As7FpWgFJyHY3TM3xFyaBYeMsoRXAFC3Zl+/Xs1HIxPoDKt3EKrdWn41RnmxaAJXaf55RhW13cCqwNAavQko+kZS2DO7yysUzlVggo1CQaZQXa+qx8sGXKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3r5QE50UHlUcoxHgiN+9ZMoRIVaClXNu25VOvyj8aQI=;
 b=BaFMkO1iE2am1reZervCA8bJfpV7EHsKlH9cbfeyjfvCAfQEbJnjgq/LwnkT6bs+o0+SgnTmNhbRikx+LyLVktLVQf+X070lEh8KESUJ4InX8YYfrHBjU5gYJX9o9jlTEZzfFsauRRG55l2VFaKaimtzAwKULrE0EjVGu1C0w7Qlq6IC1NcrqxT0pkd+s+HyIjbvPtWKQTURh7C9EtYfYElOMq9xeU2KB/PBCl72Eyvb5j1Nf2eHLYHSRKVAk0X8oPUE8CvDtPMKbqLR0h3CKUI0FjCEhi4NYh2VR1J9/XnSTCcfnvz3KBnJvKSbqwFcPFwJK7azrxbOy16ZkYUKPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3r5QE50UHlUcoxHgiN+9ZMoRIVaClXNu25VOvyj8aQI=;
 b=DJGQY5SvOiiFCaQb2gGwLn0hV87q4UjIpeBHKOzixzZsBU2Yt6mKEJgFgHQ3BbryzaJlWDDaK9m3c/nucJ4mWXyAtHgxvS94ULcDeX+rFGlMpz4LUGu2ccnCkAnHcwrfABYD8m6sTKRhLq8cUt0Wk6EuQGpVSpBJVvHoStaCKVc=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 CH0PR12MB5371.namprd12.prod.outlook.com (2603:10b6:610:d6::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.10; Wed, 12 Jan 2022 15:15:41 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::1500:4b8c:efd6:672]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::1500:4b8c:efd6:672%4]) with mapi id 15.20.4888.011; Wed, 12 Jan 2022
 15:15:41 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Bokun" <Bokun.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add interface to load SRIOV cap FW
Thread-Topic: [PATCH] drm/amdgpu: Add interface to load SRIOV cap FW
Thread-Index: AQHYBmMz8R3Lc/nN2kmmU6mhRlkAB6xfgQpg
Date: Wed, 12 Jan 2022 15:15:40 +0000
Message-ID: <DM5PR12MB24690209470DFE75AC6BF47CF1529@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220110204627.408424-1-Bokun.Zhang@amd.com>
In-Reply-To: <20220110204627.408424-1-Bokun.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e98a4ed9-34a6-4b0c-145c-08d9d5de656e
x-ms-traffictypediagnostic: CH0PR12MB5371:EE_
x-microsoft-antispam-prvs: <CH0PR12MB537143B263E931172654B4A5F1529@CH0PR12MB5371.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BUd8WIBsUKV6c17nsCpSjaXOcTrRDOEPca0T1unxv2O7lgWUFmpn3tqdchI1N7r4DqUjFqSdHt0qcvu/gsDAmnSUNFrF/ofushfBLh7IBvtOe6vuQlEZv3d7WEjoAbdJnzmZwEjHtAKK3gboF1XXp08z8ESiOnIN/ZVHdBxZaImR6Bg00bkOxmYKuIrock1PiMkK+Ehjh1UqNfxUFWeQBhRG6NZTy9Q0w5spmhqpY27UVPef2M25UX+ru/Fh/T1d4Bk8Mz1aLI0nRqq/+89nAV2/j0WmUSLZQITFWyONYgv/z75TH5GFaZufMX4NEOfazKD3IgLgQ9X0OS6HRVD9iZTYVZiEnj6LTNOxZXuqQsCHLqlex8KsG0eWOr1OePHc9AVtm6KoaZzFHBsjVLsQ1MgF2m2O6J5MWaJSDSbrBMtQeoIEcZpqoLbswnGIvk9FfkbIwL3H6n6g8D5BNRA6Pe5Zp8LfqWrxSCIiY7GRUqDcgkoDqIXrLmu+w/Tzkzb2F3QS0Bp5DUE3F18v+z7mDkbvz/BF0qQziRdFswtcmhkq0PFkvAHRC1iYlYxPx18tTC9OBKG7EFsqNNsKkoaWIoHz+/sjws1mMj3wwf9l7Hc7KiIw6w3spS9UFfh0OMVk+4oWgze98+ehs6eSikjgCWDiDdycoaBHdf/Jqm9+qH2lO9k/Al4Nt/XiHymcj/YrrI3lB4xYDpH5B73zq8MYaw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(110136005)(66946007)(76116006)(66556008)(38100700002)(64756008)(54906003)(66476007)(122000001)(86362001)(71200400001)(66446008)(83380400001)(316002)(38070700005)(52536014)(2906002)(5660300002)(8676002)(30864003)(53546011)(6506007)(55016003)(4326008)(508600001)(7696005)(8936002)(33656002)(9686003)(26005)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Uyrgf6vgpFYqDN/FCwg4f7YC135YnZeKXKM7f+jzofyNqHKHT0DS2vSee095?=
 =?us-ascii?Q?RIm2T22gZAjPBnGRfAD9ctBuKOlFpXmejeoKJeHpB6nJD3MLg0Vi/r/JPzTB?=
 =?us-ascii?Q?EMcFS6jLx+nkA6ZssiPdLCmR4R74b3OQikXx41PTsG0CjsQ+G2XSA1SLKsRm?=
 =?us-ascii?Q?Ku9fSCijOFMtmkdYPn3FXRBwGgoRJhudcvfbTy3LMR8DDHP0ElCjFFtYAoDp?=
 =?us-ascii?Q?r+S+6hOIIvyseD6THNmpf3ivXwZFRpLwpoasJG0qQvnEshSpKs1jnPb3ThhM?=
 =?us-ascii?Q?LQ0ss1V4opgu3DzzSsV6t8tWCXN5M7Z/LLPVttce5edpK6recGJT/PluhMeH?=
 =?us-ascii?Q?RvdFyMzzaf0siDKBhq6xnciTFMuIIIJFj3M0blgjDSoPeqg9DOzYuofo4KtJ?=
 =?us-ascii?Q?fKvzfTvl1WmAQ2gJPwA5yBDyD1wTu6cEttpimLY5XNVA5DXvAClsYbGn1RIH?=
 =?us-ascii?Q?naQcuek6Swq1+YnBXG2nX312/Ki+xcI3QlzaTk4BYdHpQGNtnEVqRYVJzQoW?=
 =?us-ascii?Q?Ah15ljMxOyu29tPzEuyEWY2Gqh7DWbsHOiembex1fDi6cGIjDO1/Q7hg8IQ1?=
 =?us-ascii?Q?o+rt4waj2m5Xu9OdWXptM7NS88yTHl6OTxdctnbcPzDB2krQIwbYFXGVnJfp?=
 =?us-ascii?Q?rwPNK9gze2gS2oDuC/P+1b1Wce1GYRp7Ou5vEomPZPE0tHQiIgqBhkV3eAj4?=
 =?us-ascii?Q?1DMapKeA4nNRZw//8+/UnNbntXwC/NFo6yqRsX2y6yRWN/DGUnwxsUwIpr5G?=
 =?us-ascii?Q?tNYiNYp5wJt2WdZ2rloqWh2cN8ydOLTbC3jJUuRFDOIVFaDAXSTSeokCgw1B?=
 =?us-ascii?Q?n4LPy+cGffl77jtJV+uMu7vuH0X7aIXs8ohESw33d1AOXVYLBYUPS0cOeke8?=
 =?us-ascii?Q?s/do6/aZ89qprZm9xajfGCmQoIwHXwHqZCl5qmF+GjaxidRxbbYvTB+cLUQa?=
 =?us-ascii?Q?g/n4zhbwBo+qArM4G5vDxM1qpkuF+3t/OGwnehPqAue8Oqdvtqf+et/6ZjZf?=
 =?us-ascii?Q?/ISnPyI2SOcQkB8eeWIllLM2mKQDP2YUXYTIfOHnmlsihWczofMwdKm8bNiN?=
 =?us-ascii?Q?o6L68nl6CF9gyh2hdq688RfgHHQr0Ek0BVcgUaxsIb22OPCoAuWtNIIp4JzC?=
 =?us-ascii?Q?vSXFHDtBl+Rg6XrYIsTg/RUTHZzke3rWcfcOnWagucT9BxTwN7Ei6UQBvzce?=
 =?us-ascii?Q?Ph3Ds6U4sJETWP3V2RtlwJv3wKFU/PImPcw/ZkaVPVSYGtnHkaHeruhNEGHH?=
 =?us-ascii?Q?ZbmN9rX6+m9McnIKDXVq5SBoKhzPzxawiOppzIk0n8u8AM3p/++HGVLr0Z89?=
 =?us-ascii?Q?eGj4IPHy6RfSNvfB6dF7FZHuOSQO3Pc8mEelZWnsXMz2/5jw78OSRsiK69wV?=
 =?us-ascii?Q?1VD2XxaIO56oBBppsa8AAcYZ8+22/NFrI38EeTlRnPZTlnN3UnGZBnVc/61H?=
 =?us-ascii?Q?rmPxiYf7bZZ/nzdYnQf3udFCaABh5TVbnZQum1t4qWWLUfLTJT1d3pAFH2wo?=
 =?us-ascii?Q?PrB/usgBXyl5R5movFpfQkwB8PCOphEyYBNai1MwxdXCetMVZrD1K0cFld5x?=
 =?us-ascii?Q?Ysv5ehOwdVXFJTZDG3Vf9D901Sy7y/ML4sjQQqcn8Q5camSC/ojpP3Jc6JcT?=
 =?us-ascii?Q?U+8zJZn+CDhKuFPkoTHZzJw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e98a4ed9-34a6-4b0c-145c-08d9d5de656e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 15:15:40.9867 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5aRK134uCayu+XFl1NN8zQ/FELT6saTieO5jhIBvQZQs7raVIdV3CPt31mBZIu4kQ9X6sBYJah1nf7zaXAV83g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5371
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
Cc: "Zhang, Bokun" <Bokun.Zhang@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

+	int err =3D 0;
+	const struct psp_firmware_header_v1_0 *cap_hdr_v1_0;
+	struct amdgpu_firmware_info *info =3D NULL;

Please put short variable declaration last. With this fixed, the patch is:
Acked-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Bokun Zh=
ang
Sent: Tuesday, January 11, 2022 4:46 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Bokun <Bokun.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Add interface to load SRIOV cap FW

- Add interface to load SRIOV cap FW. If the FW does not
  exist, simply skip this FW loading routine.
  This FW will only be loaded under SRIOV. Other driver
  setup will not be affected.
  By adding this interface, it will make us easier to
  prepare SRIOV Linux guest driver for different users.

- Update sysfs interface to read cap FW version.

- Refactor PSP FW loading routine under SRIOV to use a
  unified SWITCH statement instead of using IF statement

- Remove redundant amdgpu_sriov_vf() check in FW loading
  routine

Ack-by: Monk Liu <monk.liu@amd.com>
Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   |  14 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 108 +++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h   |   9 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |   1 +
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h   |   1 +
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c    |   4 +-
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c     |   1 +
 include/uapi/drm/amdgpu_drm.h             |   2 +
 8 files changed, 125 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c
index 35bee9dabe1c..dc7f24a98c44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -400,6 +400,10 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info=
_firmware *fw_info,
 		fw_info->ver =3D adev->psp.toc.fw_version;
 		fw_info->feature =3D adev->psp.toc.feature_version;
 		break;
+	case AMDGPU_INFO_FW_CAP:
+		fw_info->ver =3D adev->psp.cap_fw_version;
+		fw_info->feature =3D adev->psp.cap_feature_version;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1665,6 +1669,16 @@ static int amdgpu_debugfs_firmware_info_show(struct =
seq_file *m, void *unused)
 	seq_printf(m, "TOC feature version: %u, firmware version: 0x%08x\n",
 		   fw_info.feature, fw_info.ver);
=20
+	/* CAP */
+	if (adev->psp.cap_fw) {
+		query_fw.fw_type =3D AMDGPU_INFO_FW_CAP;
+		ret =3D amdgpu_firmware_info(&fw_info, &query_fw, adev);
+		if (ret)
+			return ret;
+		seq_printf(m, "CAP feature version: %u, firmware version: 0x%08x\n",
+				fw_info.feature, fw_info.ver);
+	}
+
 	seq_printf(m, "VBIOS version: %s\n", ctx->vbios_version);
=20
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 07d563c6641f..2095866bdf81 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -259,6 +259,32 @@ static bool psp_get_runtime_db_entry(struct amdgpu_dev=
ice *adev,
 	return ret;
 }
=20
+static int psp_init_sriov_microcode(struct psp_context *psp) {
+	struct amdgpu_device *adev =3D psp->adev;
+	int ret =3D 0;
+
+	switch (adev->ip_versions[MP0_HWIP][0]) {
+	case IP_VERSION(9, 0, 0):
+		ret =3D psp_init_cap_microcode(psp, "vega10");
+		break;
+	case IP_VERSION(11, 0, 9):
+		ret =3D psp_init_cap_microcode(psp, "navi12");
+		break;
+	case IP_VERSION(11, 0, 7):
+		ret =3D psp_init_cap_microcode(psp, "sienna_cichlid");
+		break;
+	case IP_VERSION(13, 0, 2):
+		ret =3D psp_init_ta_microcode(psp, "aldebaran");
+		break;
+	default:
+		BUG();
+		break;
+	}
+
+	return ret;
+}
+
 static int psp_sw_init(void *handle)
 {
 	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle; @@ -273,19=
 +299,13 @@ static int psp_sw_init(void *handle)
 		ret =3D -ENOMEM;
 	}
=20
-	if (!amdgpu_sriov_vf(adev)) {
+	if (amdgpu_sriov_vf(adev))
+		ret =3D psp_init_sriov_microcode(psp);
+	else
 		ret =3D psp_init_microcode(psp);
-		if (ret) {
-			DRM_ERROR("Failed to load psp firmware!\n");
-			return ret;
-		}
-	} else if (amdgpu_sriov_vf(adev) &&
-		   adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(13, 0, 2)) {
-		ret =3D psp_init_ta_microcode(psp, "aldebaran");
-		if (ret) {
-			DRM_ERROR("Failed to initialize ta microcode!\n");
-			return ret;
-		}
+	if (ret) {
+		DRM_ERROR("Failed to load psp firmware!\n");
+		return ret;
 	}
=20
 	memset(&boot_cfg_entry, 0, sizeof(boot_cfg_entry)); @@ -353,6 +373,10 @@ =
static int psp_sw_fini(void *handle)
 		release_firmware(psp->ta_fw);
 		psp->ta_fw =3D NULL;
 	}
+	if (adev->psp.cap_fw) {
+		release_firmware(psp->cap_fw);
+		psp->cap_fw =3D NULL;
+	}
=20
 	if (adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(11, 0, 0) ||
 	    adev->ip_versions[MP0_HWIP][0] =3D=3D IP_VERSION(11, 0, 7)) @@ -491,7=
 +515,10 @@ psp_cmd_submit_buf(struct psp_context *psp,
 		DRM_WARN("psp gfx command %s(0x%X) failed and response status is (0x%X)\=
n",
 			 psp_gfx_cmd_name(psp->cmd_buf_mem->cmd_id), psp->cmd_buf_mem->cmd_id,
 			 psp->cmd_buf_mem->resp.status);
-		if (!timeout) {
+		/* If we load CAP FW, PSP must return 0 under SRIOV
+		 * also return failure in case of timeout
+		 */
+		if ((ucode && (ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_CAP)) || !timeout)=
=20
+{
 			ret =3D -EINVAL;
 			goto exit;
 		}
@@ -2052,6 +2079,9 @@ static int psp_get_fw_type(struct amdgpu_firmware_inf=
o *ucode,
 			   enum psp_gfx_fw_type *type)
 {
 	switch (ucode->ucode_id) {
+	case AMDGPU_UCODE_ID_CAP:
+		*type =3D GFX_FW_TYPE_CAP;
+		break;
 	case AMDGPU_UCODE_ID_SDMA0:
 		*type =3D GFX_FW_TYPE_SDMA0;
 		break;
@@ -3218,6 +3248,58 @@ int psp_init_ta_microcode(struct psp_context *psp,
 	return err;
 }
=20
+int psp_init_cap_microcode(struct psp_context *psp,
+			  const char *chip_name)
+{
+	struct amdgpu_device *adev =3D psp->adev;
+	char fw_name[PSP_FW_NAME_LEN];
+	int err =3D 0;
+	const struct psp_firmware_header_v1_0 *cap_hdr_v1_0;
+	struct amdgpu_firmware_info *info =3D NULL;
+
+	if (!chip_name) {
+		dev_err(adev->dev, "invalid chip name for cap microcode\n");
+		return -EINVAL;
+	}
+
+	if (!amdgpu_sriov_vf(adev)) {
+		dev_err(adev->dev, "cap microcode should only be loaded under SRIOV\n");
+		return -EINVAL;
+	}
+
+	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_cap.bin", chip_name);
+	err =3D request_firmware(&adev->psp.cap_fw, fw_name, adev->dev);
+	if (err) {
+		dev_warn(adev->dev, "cap microcode does not exist, skip\n");
+		err =3D 0;
+		goto out;
+	}
+
+	err =3D amdgpu_ucode_validate(adev->psp.cap_fw);
+	if (err) {
+		dev_err(adev->dev, "fail to initialize cap microcode\n");
+		goto out;
+	}
+
+	info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_CAP];
+	info->ucode_id =3D AMDGPU_UCODE_ID_CAP;
+	info->fw =3D adev->psp.cap_fw;
+	cap_hdr_v1_0 =3D (const struct psp_firmware_header_v1_0 *)
+		adev->psp.cap_fw->data;
+	adev->firmware.fw_size +=3D ALIGN(
+			le32_to_cpu(cap_hdr_v1_0->header.ucode_size_bytes), PAGE_SIZE);
+	adev->psp.cap_fw_version =3D le32_to_cpu(cap_hdr_v1_0->header.ucode_versi=
on);
+	adev->psp.cap_feature_version =3D le32_to_cpu(cap_hdr_v1_0->sos.fw_versio=
n);
+	adev->psp.cap_ucode_size =3D=20
+le32_to_cpu(cap_hdr_v1_0->header.ucode_size_bytes);
+
+	return 0;
+
+out:
+	release_firmware(adev->psp.cap_fw);
+	adev->psp.cap_fw =3D NULL;
+	return err;
+}
+
 static int psp_set_clockgating_state(void *handle,
 				     enum amd_clockgating_state state)  { diff --git a/drivers/gpu/drm=
/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index f29afabbff1f..ff7d533eb746 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -306,6 +306,9 @@ struct psp_context
 	/* toc firmware */
 	const struct firmware		*toc_fw;
=20
+	/* cap firmware */
+	const struct firmware		*cap_fw;
+
 	/* fence buffer */
 	struct amdgpu_bo		*fence_buf_bo;
 	uint64_t			fence_buf_mc_addr;
@@ -327,6 +330,10 @@ struct psp_context
 	const struct firmware		*ta_fw;
 	uint32_t			ta_fw_version;
=20
+	uint32_t			cap_fw_version;
+	uint32_t			cap_feature_version;
+	uint32_t			cap_ucode_size;
+
 	struct ta_context		asd_context;
 	struct psp_xgmi_context		xgmi_context;
 	struct psp_ras_context		ras_context;
@@ -440,6 +447,8 @@ int psp_init_sos_microcode(struct psp_context *psp,
 			   const char *chip_name);
 int psp_init_ta_microcode(struct psp_context *psp,
 			  const char *chip_name);
+int psp_init_cap_microcode(struct psp_context *psp,
+			  const char *chip_name);
 int psp_get_fw_attestation_records_addr(struct psp_context *psp,
 					uint64_t *output_ptr);
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.h
index 7c2538db3cd5..428f4df184d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -378,6 +378,7 @@ enum AMDGPU_UCODE_ID {
 	AMDGPU_UCODE_ID_VCN0_RAM,
 	AMDGPU_UCODE_ID_VCN1_RAM,
 	AMDGPU_UCODE_ID_DMCUB,
+	AMDGPU_UCODE_ID_CAP,
 	AMDGPU_UCODE_ID_MAXIMUM,
 };
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/=
amdgpu/psp_gfx_if.h
index dd0dce254901..1f276ddd26e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -258,6 +258,7 @@ enum psp_gfx_fw_type {
 	GFX_FW_TYPE_SDMA6                           =3D 56,   /* SDMA6           =
         MI      */
 	GFX_FW_TYPE_SDMA7                           =3D 57,   /* SDMA7           =
         MI      */
 	GFX_FW_TYPE_VCN1                            =3D 58,   /* VCN1            =
         MI      */
+	GFX_FW_TYPE_CAP                             =3D 62,   /* CAP_FW          =
                 */
 	GFX_FW_TYPE_REG_LIST                        =3D 67,   /* REG_LIST        =
         MI      */
 	GFX_FW_TYPE_MAX
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v11_0.c
index d0e76b36d4ab..9518b4394a6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -53,11 +53,13 @@ MODULE_FIRMWARE("amdgpu/navi14_ta.bin");
 MODULE_FIRMWARE("amdgpu/navi12_sos.bin");
 MODULE_FIRMWARE("amdgpu/navi12_asd.bin");
 MODULE_FIRMWARE("amdgpu/navi12_ta.bin");
+MODULE_FIRMWARE("amdgpu/navi12_cap.bin");
 MODULE_FIRMWARE("amdgpu/arcturus_sos.bin");
 MODULE_FIRMWARE("amdgpu/arcturus_asd.bin");
 MODULE_FIRMWARE("amdgpu/arcturus_ta.bin");
 MODULE_FIRMWARE("amdgpu/sienna_cichlid_sos.bin");
 MODULE_FIRMWARE("amdgpu/sienna_cichlid_ta.bin");
+MODULE_FIRMWARE("amdgpu/sienna_cichlid_cap.bin");
 MODULE_FIRMWARE("amdgpu/navy_flounder_sos.bin");
 MODULE_FIRMWARE("amdgpu/navy_flounder_ta.bin");
 MODULE_FIRMWARE("amdgpu/vangogh_asd.bin");
@@ -177,8 +179,6 @@ static int psp_v11_0_init_microcode(struct psp_context =
*psp)
 		err =3D psp_init_asd_microcode(psp, chip_name);
 		if (err)
 			return err;
-		if (amdgpu_sriov_vf(adev))
-			break;
 		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ta.bin", chip_name);
 		err =3D request_firmware(&adev->psp.ta_fw, fw_name, adev->dev);
 		if (err) {
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/am=
dgpu/psp_v3_1.c
index 1ed357cb0f49..01f3bcc62a6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
@@ -44,6 +44,7 @@
=20
 MODULE_FIRMWARE("amdgpu/vega10_sos.bin");
 MODULE_FIRMWARE("amdgpu/vega10_asd.bin");
+MODULE_FIRMWARE("amdgpu/vega10_cap.bin");
 MODULE_FIRMWARE("amdgpu/vega12_sos.bin");
 MODULE_FIRMWARE("amdgpu/vega12_asd.bin");
=20
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h =
index eef6e7e95a11..7b7190609ad0 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -790,6 +790,8 @@ struct drm_amdgpu_cs_chunk_data {
 	#define AMDGPU_INFO_FW_DMCUB		0x14
 	/* Subquery id: Query TOC firmware version */
 	#define AMDGPU_INFO_FW_TOC		0x15
+	/* Subquery id: Query CAP firmware version */
+	#define AMDGPU_INFO_FW_CAP		0x16
=20
 /* number of bytes moved for TTM migration */
 #define AMDGPU_INFO_NUM_BYTES_MOVED		0x0f
--
2.25.1

