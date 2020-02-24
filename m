Return-Path: <SRS0=KDYH=4M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB5FC3567B
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 10:18:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31D3720836
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 10:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="p/h3h2U+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D3720836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E69E46E417;
	Mon, 24 Feb 2020 10:18:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A21F6E41D
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2020 10:18:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCuW2vev61dTJbPGQmFmWa1GJzgZ2jMlv/OSUwUsxk6FxCJiIBmHd88CVNWas8qPU80MQIn5xRR3jwYrRZGmVoAp/tkZ7gvriifc3vHVf3HTlR/26jBbfI7U1uNkmOCDyOXsuxCJq+kA5wMD7PVPYlLSZXx353CgttGz/Kaq+G2+zInwEKJNtpRoU4Bz/Bb8Ry780qLgmH7DWu05xoq3U7Ffh/YuRwjEs2bDRV6y+N8u8xnkIPC60xWBqGly2glMD3MW2NMVfsk10f60btyqmVc7913fIAHTBAizjCQ30LequfNrqM1immpngXeLSbigd1lhRLKAMEUS4zZdhyf7Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jttUf8M5YBR99jWXfqZRAFyazLvGRZHxPkTSWB8VyqI=;
 b=EOyaEFDTgTYciP+Gxl0mXjC7cay+FMyiy8B4BrOkACWlb42XCfvRgZ4dYJruwchS4WCW47cJNK9tp7KkB3caDB2P/ZvpCsgthWvfnYKsGWv7rh5q8HnTeB384A3olaXsH9ARHFPA9/Ce9ZED4XmxoDVSGiHeD3z09IjqM9e+s3OkMVNAyzqT3UWbzOlh0nqQj19xZR9xDnCKOE7SFTH1ZNIBB5i2xCYl7Jf0gZZu+JStDq2T7tyZOWJsfzyhoM7a7DDNi2pQZv+K5LDlbn3ouGknj6nAIunHVKM+13ht0EQARmpHu0J7jF5ckriJJctPRXRrH+deHNPwiq5qqksSLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jttUf8M5YBR99jWXfqZRAFyazLvGRZHxPkTSWB8VyqI=;
 b=p/h3h2U+Rdhff0v8k4c8j1G5nUW1tqJVs3oNd3c4/RFrf30f7rkSNPdp4Wj+QrvxLY1c1Mb1loDCnevOvQj+mWa17z2InT4mLsMbACxKWB7THeRpszAYVSVxZBGpERSr4T7fdfusUHAtDL5mUvDMSESJOsC7dxd0u57pSfCacU0=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (2603:10b6:3:7a::15) by
 DM5PR12MB1625.namprd12.prod.outlook.com (2603:10b6:4:b::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Mon, 24 Feb 2020 10:18:25 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db%5]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 10:18:25 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: update psp firmwares loading sequence
Thread-Topic: [PATCH] drm/amdgpu: update psp firmwares loading sequence
Thread-Index: AQHV6vR7cLi/urdlg065vWPdO8srAKgqIHKAgAABARA=
Date: Mon, 24 Feb 2020 10:18:25 +0000
Message-ID: <DM5PR12MB141877F6C4E39995151C8D93FCEC0@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20200224092417.7589-1-evan.quan@amd.com>
 <DM5PR12MB1418D5CF6F341DC174C6AF5EFCEC0@DM5PR12MB1418.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1418D5CF6F341DC174C6AF5EFCEC0@DM5PR12MB1418.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-24T10:15:45Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f0986d10-208a-4c63-a13d-000072765be6;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-02-24T10:18:23Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 50689071-8450-4a72-ba7e-0000b43ce384
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 10258d7f-1b4a-405c-2392-08d7b912e28d
x-ms-traffictypediagnostic: DM5PR12MB1625:|DM5PR12MB1625:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB16251A13F325149213413128FCEC0@DM5PR12MB1625.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(199004)(189003)(86362001)(33656002)(52536014)(26005)(53546011)(15650500001)(2940100002)(76116006)(478600001)(71200400001)(66946007)(186003)(81166006)(55016002)(66476007)(9686003)(7696005)(316002)(6506007)(66446008)(64756008)(110136005)(81156014)(4326008)(5660300002)(2906002)(8676002)(66556008)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1625;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IWhykOQVZpynLYqURNv/LW7nkmdD8xmp9U/mFETK0A7bUZP7E+TOSXv9NbBJHNd69MTd3/wmnfAmaYahswV1DYGu1eJ4jdPMtweaf8Zhk2qD7a4WEpts59oxnBIWzhW2GW9DJPqZhxmjM+hvgChLVJm6JOLX0xD4p5ZmlVQIM4zfDHSYgzQUvHpBwsWFbOUS0XiWWv+p1oj7ZSLmL5AAiodfpzytyDAE0hqdIyb3fcymMtwU1UsKAK+KHeg/YvdX21+4lrMLF/+6EJcDbLBbUF2Rr8zPtGB7IeOLGSFa0U4pwNCjjLRJ3U96kv4VyMHC316rKFsDFTvBzYqhYW2qS+Mb63xqo+RRu7ja/qGkuW7NJbZNzCgtEZ6xtf0GI9DPp6vKm9SnQVrUoego61cN2lLO/prk6Bvd48hp03hz5+jhvu5xkGpItV5tHGw6YsLd
x-ms-exchange-antispam-messagedata: Duy0sD53h5mgfz9NIw+WN1JEcVb1aEe8yKv4UnqcGkI+c3DH2TLTeMzgv+V2WOjxfArZFyXV5zGvRhdtqh1/k4Xpj6RrvmBtlioboYSk9otC3vRFvE14tKVCGOVgXvYdgRN2JHYFeE0Kb9nx1DrtWw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10258d7f-1b4a-405c-2392-08d7b912e28d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 10:18:25.6145 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cwkP+yHey6+oBgXkdJZkbUY6/1tV43CbAua3no1FdtUS/LbHlbS2aGmEOnE29+18ENlITkROQpWFL6KStGm8YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1625
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

That's saying I suspect the PMFW was loaded twice with the patch for Arcturus and Navi12.

Regards,
Hawking

-----Original Message-----
From: Zhang, Hawking 
Sent: Monday, February 24, 2020 18:16
To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update psp firmwares loading sequence

[AMD Official Use Only - Internal Distribution Only]

Can you double check the following logic after your setup the TMR in psp_np_fw_load? For Arcturus and Navi12, it should be skipped as well.

if (ucode->ucode_id == AMDGPU_UCODE_ID_SMC &&
    (psp_smu_reload_quirk(psp) || psp->autoload_supported))
			continue;

Regards,
Hawking
-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com> 
Sent: Monday, February 24, 2020 17:24
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amdgpu: update psp firmwares loading sequence

For those ASICs with DF Cstate management centralized to PMFW, TMR setup should be performed between pmfw loading and other non-psp firmwares loading.

Change-Id: I8986ddb4d9ffe63ed0823d1dce8d9d52812a1240
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 61 +++++++++++++++++++++++--  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 +
 2 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 51839ab02b84..ef800ad68e1c 100644
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
