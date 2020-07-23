Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51CCC433E3
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 08:34:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B64DB2084D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 08:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AwCdcRK0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B64DB2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84D836E868;
	Thu, 23 Jul 2020 08:34:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F7C46E868
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 08:34:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kxzkf6ltdXxr4ItTXUNWd4u68+uHDd+kOm/oH4BNDFxwqTOweq1fG2wxRY2vud0WIoqR25AMrs6rrx8VIqzzZrkms8JrvMn5Y9MM+iKxAXcS/8J/UH/8JdyjAEsqmgDiHbRcivDNBS49OPCjd5SGPxqTH8iQF1JU7doIzGCqhZub3S0+uB8EQFrAH077eDRN93OewFVh32oq63p0s+rFOZ6xtcaT2+yqVhpfKSrNVQ6ZcWtlzBpnRWWrnwlH4T1slBQrYjhv4hb0mAXLYFuLcXxCd0EQ5EwezsBKqy7tXujkfdnkz2Rtx7JgVQKWpzNXP45yjDlUPmAMkh4E4zSREQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSK+TxUJWEWdZy09/9wY0+SpoUh4nQxFism3FdQ2bpY=;
 b=ET4YkI4XOOxUBsoW/CWX5jpqSsYkNxTD5He8Mfeo/CQ2h03zYbcRD+9t3YNXHmlc6nv5kM4d1ewR43i3TPIkogDXc9iWwcXIRPjZyOmE14OWYLlBIYv5hReGyj5mm8JHrvVGLNwDdsqSIlSV4xyGHBQjrgM6XqvoD0PgjX81trDxVYAyvIvzB4Ww7eMEh6Cs/XS5tE64Y2DZ7/GlnX23FPrpaAFtXTFn04SG2VjWEB7OCcoK/ZHx82HLUNIu/C9s15id5MhlDWX2ICcSjNlzXsO+whp8s2jsxj1l84TKMZniNbDgmCIpNl9LYMLHIMZcYEPkdVR4Fkxed1PxW1Ztxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSK+TxUJWEWdZy09/9wY0+SpoUh4nQxFism3FdQ2bpY=;
 b=AwCdcRK0+MpScEj/1eKrum+WDCU+rmvOoD4FxSMSemhk+CK6YAz4HWRxe4gXK3o2K5wiYYTqEDpoY09YJ+Ib2GWjPvl8ZtiX32sGfn0Mffxy7V49jJrLc/rVaieNpuE05N+4gN28tPC89aMe5N55Im1LwEJ3nEchJKc4J3raoz8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0005.namprd12.prod.outlook.com (2603:10b6:903:d1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Thu, 23 Jul
 2020 08:34:19 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.024; Thu, 23 Jul
 2020 08:34:19 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, Stanley.Yang@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com
Subject: [PATCH 4/9] drm/amdgpu: break driver init process when it's bad GPU
Date: Thu, 23 Jul 2020 16:33:41 +0800
Message-Id: <20200723083346.8743-5-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200723083346.8743-1-guchun.chen@amd.com>
References: <20200723083346.8743-1-guchun.chen@amd.com>
X-ClientProxiedBy: HK0PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:203:b0::21) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK0PR03CA0105.apcprd03.prod.outlook.com (2603:1096:203:b0::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Thu, 23 Jul 2020 08:34:16 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: addf5a67-a486-4c3d-f1d2-08d82ee33110
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0005:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB000591361D9EC8EA483C2F20F1760@CY4PR1201MB0005.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h+oVQrfxOx+jUhveKsdrbv9hMibwFID1xzSkjP3kFBiAmbohnl0rJqdx5QCgK/WrBtspoNjOefdnMmLMbNOHyrk8qP6o127E9w+GZu7RhFBvV0ZgaX7c+MueM9OO7wCzSb8juLYMOF2bpiFbBSjnOKg0DjfmKw6Cqsk8BdyXvihDe3l5ZeRdPG5Fxfy2W8MFXMt80bAq90xEcI0PV4+pNvZ0dp6syMVmtY+QWvSU3Evj0PQVJOG0IvwXU2mAq5b4AFgtZr5naOIW4w5K4Yhxx57DvHLFOj6uCgQsFkQ8M/bmS+cBkmr/Bt3PqLdYTaIxSlzjVZKo4qIsirsYyKF/Ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(8936002)(316002)(2616005)(36756003)(2906002)(16526019)(186003)(8676002)(6486002)(44832011)(4326008)(956004)(26005)(7696005)(478600001)(52116002)(5660300002)(66476007)(66556008)(66946007)(83380400001)(1076003)(6636002)(86362001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: KS/JlsR3/zB4d4Mmn9/s+TM1mLD2HCWiT/whjrPcujwp/IVv1UCd/+iL7TE15lhxVQFMtE7gw3IVgHKpvXOE+Qx8a0E7jaayvNWHFxy0KXHFKR08EyGzva24OPvr1WQNPmNiMuNcQOe1Tqt8qxwfK1FfgpUo7ilGhGsaoRAwH0Gbrx3TBlkyHoh7lHk6Q4ydIVdCxAI9qu9+p7ZmbOndo+H9Og/PzJU5MYHdTZYtiSTClgv2kzu3TxrCP1FolpTqgoHpIOMRMuQ03sWG03LjdiS5ASiuXh7oSn+ssZruGcRA6NUDnx5zj/asa5Aaf0uCtdtqTNaasZNXW7ElP6b4mTguH5jkYRt2OAHxFiBygewTOPJaaMG/RG6vZ9Qb1dw924O916b2f9+ou64ufAUgILRyFYaW86OF9kR36PaunS9FNyPSRCsw6mZge7Xc6XhNeeug7x/2vvxEJ+IaQVm5zocIo0rfU8ovRg3GnFgfc+TpXWVKp2o9nytaCdMB63dF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: addf5a67-a486-4c3d-f1d2-08d82ee33110
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 08:34:19.2771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLDNe4IzAiZA6TgQT9f9TjqmG/9cChdpQkKrszLGM6Qf446RA94UkhnhxJAqGlFslj+hZMAIr+HQh+d8rxGhdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0005
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

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     | 12 +++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c        | 15 +++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 11 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h |  3 ++-
 4 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2662cd7c8685..882f8a0964a5 100644
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
+	 * arrordingly. For other failed cases, it will still release all
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
index 8daeb54917ed..06db2f0b78d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1819,6 +1819,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_err_handler_data **data;
 	uint32_t max_eeprom_records_len = 0;
+	bool bad_gpu = false;
 	int ret;
 
 	if (con)
@@ -1840,9 +1841,12 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	max_eeprom_records_len = amdgpu_ras_eeprom_get_record_max_length();
 	amdgpu_ras_validate_threshold(adev, max_eeprom_records_len);
 
-	ret = amdgpu_ras_eeprom_init(&con->eeprom_control);
-	if (ret)
+	ret = amdgpu_ras_eeprom_init(&con->eeprom_control, &bad_gpu);
+	/* We only fail this calling and halt booting when bad_gpu is true. */
+	if (bad_gpu) {
+		ret = -EINVAL;
 		goto free;
+	}
 
 	if (con->eeprom_control.num_recs) {
 		ret = amdgpu_ras_load_bad_pages(adev);
@@ -1865,6 +1869,13 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 out:
 	dev_warn(adev->dev, "Failed to initialize ras recovery!\n");
 
+	/*
+	 * Except bad_gpu case, other failure cases in this function
+	 * would not fail amdgpu driver init.
+	 */
+	if (!bad_gpu)
+		ret = 0;
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 35c0c849d49b..3f1b167afe6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -241,12 +241,14 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 
 }
 
-int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
+int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
+			bool *bad_gpu)
 {
 	int ret = 0;
 	struct amdgpu_device *adev = to_amdgpu_device(control);
 	unsigned char buff[EEPROM_ADDRESS_SIZE + EEPROM_TABLE_HEADER_SIZE] = { 0 };
 	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 	struct i2c_msg msg = {
 			.addr	= 0,
 			.flags	= I2C_M_RD,
@@ -254,6 +256,8 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 			.buf	= buff,
 	};
 
+	*bad_gpu = false;
+
 	/* Verify i2c adapter is initialized */
 	if (!adev->pm.smu_i2c.algo)
 		return -ENOENT;
@@ -282,6 +286,11 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 		DRM_DEBUG_DRIVER("Found existing EEPROM table with %d records",
 				 control->num_recs);
 
+	} else if ((ras->bad_page_cnt_threshold != 0xFFFFFFFF) && (
+			hdr->header == EEPROM_TABLE_HDR_BAD)) {
+		*bad_gpu = true;
+		DRM_ERROR("Detect BAD GPU TAG in eeprom table and "
+			"GPU shall be retired.\n");
 	} else {
 		DRM_INFO("Creating new EEPROM table");
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index b272840cb069..a2de243da31d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -77,7 +77,8 @@ struct eeprom_table_record {
 	unsigned char mcumc_id;
 }__attribute__((__packed__));
 
-int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control);
+int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
+			bool *bad_gpu);
 int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control);
 
 int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
