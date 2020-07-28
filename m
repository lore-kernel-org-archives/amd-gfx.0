Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983F2C433EB
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 07:50:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A51C20792
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 07:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="J13f2Br8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A51C20792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36A7F6E204;
	Tue, 28 Jul 2020 07:50:10 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750079.outbound.protection.outlook.com [40.107.75.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A0C96E204
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 07:50:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IS4r5kJKThdX6y66cwlwNrjA8yn33yJCvgmiAh9gMYBGDLahhkeQbBZaLjFW6Beb9d7/TsbwQOxaa2gsfpfPSF56UkvAobABCIlDyS+uC94rg433MheatJ42Lu4vpcGTL6WtCqfRQHFu1hjO6MtSkN1J1MxDTOoYS1DVR3/0awWxe6ZFKfVqrcBIvGnZhxjTKHIUt47duV3dC434THn4c8YNOO1TtkeYKSmF/CZP0R+k88xW9hekauaGlUKosov5ECV6UVtHE1DOk6ab0Lf1oZ6o6ViT0CGj1mDUgf5sjD4ck4vW+wOHHFKo5ZhXhj98Fybl1aibbkQxcf3nBwaoEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs0lvtaYMFOucfFYZNyQ6xltZL5+VYUlk4CvcrTeWZY=;
 b=Jq3D/NqPOTnDaFWjW0vqLNUQdcPSjG4kp0vmQC5Q01j+tawxR+RiXp+eRu4d85oD2B4dP58LPh8HmXr3pW4Z5ja6a25aLSLaFAULviSy0GaK3zOI82O7O+AAyl1IE6qpQGJttORsDlnNuDT1cdCx/Fmn0FXq97B/PBOvzYtIrcj/sum85pfdCbS2kfBkinMXMLmgKYapBgCn31pKyJqx8sxJtTRr2Z+I+bRaBDjvCBJwOBel2KNqTaGSbPD8f0R3N75YTAiv6MsVO4je0/Sp/JJbmlxoZTDyvgEv1CflkbYh1Mv4ATt2Db+H81yhEDtYyy4WGS+TJpx/C2NYlCrFww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs0lvtaYMFOucfFYZNyQ6xltZL5+VYUlk4CvcrTeWZY=;
 b=J13f2Br8GtiK49BpJKOGVtC1mKIXO6ICtM0NmAa+KBfe+AompgS/TrXnHdMYpA4GVlDu/7tpY8vvXe7n9mKOWlvQrfKkOMpM9NmWQtSUxzxR3cLMDJ59JEjPx0AVBaZayhaiI9bhTwxoWveIiVmCPkdzbILNvNvBzn8WPWx5ngU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1752.namprd12.prod.outlook.com (2603:10b6:903:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 07:50:08 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.033; Tue, 28 Jul
 2020 07:50:08 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, andrey.grodzovsky@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com,
 christian.koenig@amd.com, stanley.yang@amd.com
Subject: [PATCH 04/12] drm/amdgpu: break driver init process when it's bad GPU
Date: Tue, 28 Jul 2020 15:49:26 +0800
Message-Id: <20200728074934.12490-5-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200728074934.12490-1-guchun.chen@amd.com>
References: <20200728074934.12490-1-guchun.chen@amd.com>
X-ClientProxiedBy: HKAPR03CA0004.apcprd03.prod.outlook.com
 (2603:1096:203:c8::9) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HKAPR03CA0004.apcprd03.prod.outlook.com (2603:1096:203:c8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.9 via Frontend Transport; Tue, 28 Jul 2020 07:50:04 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 20b998f5-d037-4354-069c-08d832cad8ff
X-MS-TrafficTypeDiagnostic: CY4PR12MB1752:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1752C35BEA889601BDB9C5C6F1730@CY4PR12MB1752.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XOP1ZP86mmjsBoPC1kDJQ1Xv8lei/KJMbgnsfQPyIvgChm8pImddtVeARHJwR62xXUt/mjCEO/cGZEBvHopYlJvZ1a+KmEKC5/2Q3SwvbvvFDWvWKTe1c13uDmp9qr1PKwq/1tLp6743Gn7Qv8yymftc324CFcCNFtXUimLKTmVAE8Ik6B79fbFiyB2NufS8SUYzSio3k0aVaL8G+umoT1vXmUPRy0ThOzb2NM3BhQ6BCpqF3dik7sgQDJT9m0LofJmyh2cJSVNSbvcvxsI7cK/WYM/uDlSRbhPZ/qS9lmb5VBF0Hfe9LzB4yh8d33J4DZkZsA2rdj5NUIP58qTinV+pvAUmxrGJWDqNyduWucf20qfRa/ZY0PwpYM/hBfQu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(2906002)(956004)(2616005)(1076003)(6486002)(66476007)(66556008)(4326008)(6636002)(66946007)(52116002)(478600001)(36756003)(44832011)(86362001)(83380400001)(316002)(6666004)(16526019)(186003)(26005)(5660300002)(7696005)(8936002)(8676002)(921003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ck/7/r8/z5K7mOM5uhmC1ITeUWCh7fMiPjVd0lb9jAISfDX1PG6xiWcSd2HmbIahEi8USa7jXL/N3+UITd6GyZS/zKYOelikFO/pu0azjXcPEc3aAJCECLxuarxYTWUkACRMls7T0GaOYdCC5UDy+qZ15l/K4jx3UGps0QnHhEmyGHhMN1AGLAKV+iVgTuWhEZU3PDQ9JBllAMtxHz7deTs6O8DCb+54VS+E9QntPYvvvPqWbYHs06AwpmvZbwKNgz56Hhch/7EoL3DKSTqoHyyNuesUe7FhT8iK7VrRUFM9FkBia72T7ywclUYLjCm4qnoB9OmhdK2JEP4V090yraX/2fg7YAx16jah8jhd3OesggH7kgYN+Vto7DGDyN4Z08U45bSwfz9ne+FE6azQJjRLtAx26aTFHBLcQqtIKByqu0PrQQDitbjN4I9XmZF555prpgP9kf2xc1ydsMISLkp5tGuZhTf2+DP4SsqPxs4nnR0vGITOL5yIb07DBBgH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b998f5-d037-4354-069c-08d832cad8ff
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 07:50:08.0828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iIRU5BeqWK797sDj3pOiLJwYPqIUHHfUv4xhwpMQnCsZOBeSbLT0Uda2bjjxFUhQc7keEhdZe0R+nj8OzjA+zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1752
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When retrieving bad gpu tag from eeprom, GPU init should
fail as the GPU needs to be retired for further check.

v2: Fix spelling typo, correct the condition to detect
    bad gpu tag and refine error message.

v3: Refine function argument name.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     | 12 +++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c        | 18 ++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 10 +++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h |  3 ++-
 4 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2662cd7c8685..30af0dfee1a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2059,13 +2059,19 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	 * it should be called after amdgpu_device_ip_hw_init_phase2  since
 	 * for some ASICs the RAS EEPROM code relies on SMU fully functioning
 	 * for I2C communication which only true at this point.
-	 * recovery_init may fail, but it can free all resources allocated by
-	 * itself and its failure should not stop amdgpu init process.
+	 *
+	 * amdgpu_ras_recovery_init may fail, but the upper only cares the
+	 * failure from bad gpu situation and stop amdgpu init process
+	 * accordingly. For other failed cases, it will still release all
+	 * the resource and print error message, rather than returning one
+	 * negative value to upper level.
 	 *
 	 * Note: theoretically, this should be called before all vram allocations
 	 * to protect retired page from abusing
 	 */
-	amdgpu_ras_recovery_init(adev);
+	r = amdgpu_ras_recovery_init(adev);
+	if (r)
+		goto init_failed;
 
 	if (adev->gmc.xgmi.num_physical_nodes > 1)
 		amdgpu_xgmi_add_device(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 3c4c142e9d8a..56e1aeba2d64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1822,6 +1822,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_err_handler_data **data;
 	uint32_t max_eeprom_records_len = 0;
+	bool exc_err_limit = false;
 	int ret;
 
 	if (con)
@@ -1843,9 +1844,15 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	max_eeprom_records_len = amdgpu_ras_eeprom_get_record_max_length();
 	amdgpu_ras_validate_threshold(adev, max_eeprom_records_len);
 
-	ret = amdgpu_ras_eeprom_init(&con->eeprom_control);
-	if (ret)
+	ret = amdgpu_ras_eeprom_init(&con->eeprom_control, &exc_err_limit);
+	/*
+	 * We only fail this calling and halt booting up
+	 * when exc_err_limit is true.
+	 */
+	if (exc_err_limit) {
+		ret = -EINVAL;
 		goto free;
+	}
 
 	if (con->eeprom_control.num_recs) {
 		ret = amdgpu_ras_load_bad_pages(adev);
@@ -1868,6 +1875,13 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 out:
 	dev_warn(adev->dev, "Failed to initialize ras recovery!\n");
 
+	/*
+	 * Except error threshold exceeding case, other failure cases in this
+	 * function would not fail amdgpu driver init.
+	 */
+	if (!exc_err_limit)
+		ret = 0;
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 35c0c849d49b..67995b66d7d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -241,7 +241,8 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 
 }
 
-int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
+int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
+			bool *exceed_err_limit)
 {
 	int ret = 0;
 	struct amdgpu_device *adev = to_amdgpu_device(control);
@@ -254,6 +255,8 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 			.buf	= buff,
 	};
 
+	*exceed_err_limit = false;
+
 	/* Verify i2c adapter is initialized */
 	if (!adev->pm.smu_i2c.algo)
 		return -ENOENT;
@@ -282,6 +285,11 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 		DRM_DEBUG_DRIVER("Found existing EEPROM table with %d records",
 				 control->num_recs);
 
+	} else if ((hdr->header == EEPROM_TABLE_HDR_BAD) &&
+			(amdgpu_bad_page_threshold != 0)) {
+		*exceed_err_limit = true;
+		DRM_ERROR("Exceeding the bad_page_threshold parameter, "
+				"disabling the GPU.\n");
 	} else {
 		DRM_INFO("Creating new EEPROM table");
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index b272840cb069..f245b96d9599 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -77,7 +77,8 @@ struct eeprom_table_record {
 	unsigned char mcumc_id;
 }__attribute__((__packed__));
 
-int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control);
+int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
+			bool *exceed_err_limit);
 int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control);
 
 int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
