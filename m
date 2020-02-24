Return-Path: <SRS0=KDYH=4M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B86C35671
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 11:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9917720732
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 11:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cgqy5kbE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9917720732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FC596E438;
	Mon, 24 Feb 2020 11:34:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65BC66E438
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2020 11:34:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyUjN2V9zUmupLFB6E7OAaDR1M0rBSqtZDHpxOdO1en3Inz7F+HOxKLFbs1U0NmL9Dorb6g/ioxICZLo5KbeMPZLdUKFQThXDeGDWkbUIInpAoPBWwA94CX78Whu5UKtYcs3Krykd4nUxBZ+srkq5KbNAOlRYdZBLdnp+Bbh5dchEGaqBj9Z2GJvZegXv/GRdoAUsjmQZFd71sk3bbkJVUmf1r2X3JYjLi3/REDFs5ThxFAWpmS8BN4yPrxXjEcVzX54V/BhJcogOembUstZkDH9PgnVcDO2YzSA2Vy6qicc/Tsxxpfs6Tsij2Mrrqi9yIO7doXJOeCCq0Cmkuge+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ne4aOBhmb1tJ8glTI/EL8bGRmCydSEAHQtyFzr+wNl8=;
 b=dpv9d/1wPUY8b70QkZNF6QkFgfcIEaXxJgBiLuP97onWao7QH2/F7Kq+7O1PbXQjUihXm959I5T2k/yahbUBZqpb56d05sD7ledFLgmG8JKUPyZ1UJlVYV1vDt6xy/1izzHP3F2RHIWKaFm9yWBbfUFL8ZHkoK9VtsSpQ9vLIXmCFDST0O09N5q4GCcae6YswdcCzZxgsHn2G5GMajg1vijCVnaq8eIaxqbiscK0q6qkUwoCwBKy/ykfLWiwolPMa33gc/YkZIa8rg0h4CfWSzCjR9Z+ngDZIRLsrHuCepuGLTVKBxS4fL35YsePITGVD9KiBhFV1FIfNoTcMfvumw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ne4aOBhmb1tJ8glTI/EL8bGRmCydSEAHQtyFzr+wNl8=;
 b=cgqy5kbEXyhODkNFofgYAkvKyDfrubO9u551GAnUOAOLM56LDzvIj7vYeLgTGqntBuv1Z5Uf6i1Bc8YiY6m95jd8wv6x7Jctk+Vo1RSrew0EjQrBNnIV0RIfsLHg4YlQPzlDVjpMy6LvYc0ybdgCxrsDiNjiRxoEJ3JZu+mmINU=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (2603:10b6:3:7a::15) by
 DM5PR12MB1818.namprd12.prod.outlook.com (2603:10b6:3:114::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.22; Mon, 24 Feb 2020 11:34:18 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db%5]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 11:34:18 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Min, Frank" <Frank.Min@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update psp firmwares loading sequence V2
Thread-Topic: [PATCH] drm/amdgpu: update psp firmwares loading sequence V2
Thread-Index: AQHV6v5SJNrzE/yxTUaNEiX3ys77jqgqMdag
Date: Mon, 24 Feb 2020 11:34:17 +0000
Message-ID: <DM5PR12MB14182932E713D06F6462882DFCEC0@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20200224103629.9344-1-evan.quan@amd.com>
In-Reply-To: <20200224103629.9344-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-24T11:34:14Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b989024a-e732-4bbf-9cb3-00004960a5c1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-02-24T11:34:14Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 2ac8e71d-73cf-4a90-8feb-000006c7be15
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3abb8d20-8d84-4dc3-c84a-08d7b91d7bfc
x-ms-traffictypediagnostic: DM5PR12MB1818:|DM5PR12MB1818:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1818AC6FF42119D2669EB1ABFCEC0@DM5PR12MB1818.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(478600001)(81166006)(316002)(81156014)(110136005)(4326008)(15650500001)(8676002)(8936002)(71200400001)(7696005)(6636002)(55016002)(53546011)(86362001)(6506007)(5660300002)(52536014)(26005)(186003)(66946007)(76116006)(2906002)(9686003)(33656002)(66556008)(66476007)(66446008)(64756008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1818;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t801LvFobHIxdLfM7OpW2ggxmjoEliLkSzQhDVsQZ292+WEGoZGrtyQYcpAgdeSwXIRyrWkWoXPrFstmkciujYu8AV/VJT4TeIljNhhrMx06kHGC99WaEd5IGoClGy1OtKUNbvKy/IRfpQ21OVEBResZS+z21kYFdGMYBJThzow87xBgQ1c2p3A7lDbH+F8OiUmUW+nnZWLAiM7js+SdVq+jtmNBYec0hK9S5GwmoKhXysV8USYMRY/PEIvbjOtJGS8PvumXtHpz9XY23R2FHVXcg7JTnLnY18h3fTp64DcqItvokFU7qGHQscO1L83heoWBCWxyBF96ednh1aImngSUqM0sizzREO6Gb4PNVQhzbOr08SDJ689nYxRfqzsHLaPdpYr7uo833aUjpaUwIlseyibRa9O/ECW1v11PpvPAVE6A72GvG8gwfacabnwS
x-ms-exchange-antispam-messagedata: uzLP0FgtT3CrE2wLXGoZfvND1r+T9pGK9HDchx0ABJOY81bLuWwPyEJP0zHGH1cVpuKqn2ndUIt3JsNKMNMSOxjX4NOUDtJ8srcNWzfy4KwfeUREhSMjoHk6ow9pCiAYeIDk91hhvLwiMxU4hf0W8Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3abb8d20-8d84-4dc3-c84a-08d7b91d7bfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 11:34:17.9869 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cxrSBc03cNxBjbqh5wU/h5Dybg4PvqC9xppQiUocI1xElJPPtfkwVuwrY7Tzho893ru18fZrqq0Rq5TKTNBmog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1818
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

The patch looks good for bare-metal case now. Frank is still on the way to clean up our concern on SETUP_VMR command (i.e. SETUP_TMR for bare-metal case). After that settled, please push the patch with my RB. Thanks.

Regards,
Hawking
-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com> 
Sent: Monday, February 24, 2020 18:36
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amdgpu: update psp firmwares loading sequence V2

For those ASICs with DF Cstate management centralized to PMFW, TMR setup should be performed between pmfw loading and other non-psp firmwares loading.

V2: skip possible SMU firmware reloading

Change-Id: I8986ddb4d9ffe63ed0823d1dce8d9d52812a1240
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 65 ++++++++++++++++++++++---  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 +
 2 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 51839ab02b84..d33f74100094 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -38,6 +38,39 @@
 
 static void psp_set_funcs(struct amdgpu_device *adev);
 
+/*
+ * Due to DF Cstate management centralized to PMFW, the firmware
+ * loading sequence will be updated as below:
+ *   - Load KDB
+ *   - Load SYS_DRV
+ *   - Load tOS
+ *   - Load PMFW
+ *   - Setup TMR
+ *   - Load other non-psp fw
+ *   - Load ASD
+ *   - Load XGMI/RAS/HDCP/DTM TA if any
+ *
+ * This new sequence is required for
+ *   - Arcturus
+ *   - Navi12 and onwards
+ */
+static void psp_check_pmfw_centralized_cstate_management(struct 
+psp_context *psp) {
+	struct amdgpu_device *adev = psp->adev;
+
+	psp->pmfw_centralized_cstate_management = false;
+
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	if (adev->flags & AMD_IS_APU)
+		return;
+
+	if ((adev->asic_type == CHIP_ARCTURUS) ||
+	    (adev->asic_type >= CHIP_NAVI12))
+		psp->pmfw_centralized_cstate_management = true; }
+
 static int psp_early_init(void *handle)  {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle; @@ -75,6 +108,8 @@ static int psp_early_init(void *handle)
 
 	psp->adev = adev;
 
+	psp_check_pmfw_centralized_cstate_management(psp);
+
 	return 0;
 }
 
@@ -1116,10 +1151,17 @@ static int psp_hw_start(struct psp_context *psp)
 		return ret;
 	}
 
-	ret = psp_tmr_load(psp);
-	if (ret) {
-		DRM_ERROR("PSP load tmr failed!\n");
-		return ret;
+	/*
+	 * For those ASICs with DF Cstate management centralized
+	 * to PMFW, TMR setup should be performed after PMFW
+	 * loaded and before other non-psp firmware loaded.
+	 */
+	if (!psp->pmfw_centralized_cstate_management) {
+		ret = psp_tmr_load(psp);
+		if (ret) {
+			DRM_ERROR("PSP load tmr failed!\n");
+			return ret;
+		}
 	}
 
 	return 0;
@@ -1316,7 +1358,8 @@ static int psp_np_fw_load(struct psp_context *psp)
 	struct amdgpu_firmware_info *ucode;
 	struct amdgpu_device* adev = psp->adev;
 
-	if (psp->autoload_supported) {
+	if (psp->autoload_supported ||
+	    psp->pmfw_centralized_cstate_management) {
 		ucode = &adev->firmware.ucode[AMDGPU_UCODE_ID_SMC];
 		if (!ucode->fw || amdgpu_sriov_vf(adev))
 			goto out;
@@ -1326,6 +1369,14 @@ static int psp_np_fw_load(struct psp_context *psp)
 			return ret;
 	}
 
+	if (psp->pmfw_centralized_cstate_management) {
+		ret = psp_tmr_load(psp);
+		if (ret) {
+			DRM_ERROR("PSP load tmr failed!\n");
+			return ret;
+		}
+	}
+
 out:
 	for (i = 0; i < adev->firmware.max_ucodes; i++) {
 		ucode = &adev->firmware.ucode[i];
@@ -1333,7 +1384,9 @@ static int psp_np_fw_load(struct psp_context *psp)
 			continue;
 
 		if (ucode->ucode_id == AMDGPU_UCODE_ID_SMC &&
-		    (psp_smu_reload_quirk(psp) || psp->autoload_supported))
+		    (psp_smu_reload_quirk(psp) ||
+		     psp->autoload_supported ||
+		     psp->pmfw_centralized_cstate_management))
 			continue;
 
 		if (amdgpu_sriov_vf(adev) &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index c77e1abb538a..37fa184f27f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -264,6 +264,8 @@ struct psp_context
 	atomic_t			fence_value;
 	/* flag to mark whether gfx fw autoload is supported or not */
 	bool				autoload_supported;
+	/* flag to mark whether df cstate management centralized to PMFW */
+	bool				pmfw_centralized_cstate_management;
 
 	/* xgmi ta firmware and buffer */
 	const struct firmware		*ta_fw;
--
2.25.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
