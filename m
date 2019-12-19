Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2979C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 11:43:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8331A24672
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 11:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EL3OpA1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8331A24672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 233D36EB55;
	Thu, 19 Dec 2019 11:43:56 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770040.outbound.protection.outlook.com [40.107.77.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10C2C6EB55
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 11:43:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GG8XSOMMslLh7yaraPATCNzu4MgJfZNH7wfGD81d4HroPmJWKR23R2xGVSOBNwipAepwda5Q+GkQIV1PGz4+Vc5fLeHKC3PIkLI/+Dj5he+LGd59yl+b28GF1na7TKPcOAEOeX1jUJi64gRSOVnE8bwvXBgNxrcnUmpk5RTFEYkR0KD7KCr5z72F/PdgRiUtGv2Gn+rhcCZyo0w9MLSHgBnvpQth9ZY2CuJjgtHX2GtFUg7cGqToV5/kDe6b1YO/gQTw6tjFucVQD+NdIi+8gpIp9LRuYXsoP5gzyJPJaxQlTwqu5RFipLDxs/Xj0F7w/sCzjQEc5z5I94etR12ErQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxr1ZxzcjEQKLgBXe3FpxO26iii7fldyEoMVD4LluJg=;
 b=YJlDY5GrbXN7ab/zEeSjcnMyubXjiFbd2+MOWz0cHa1MaOjvZ0TPy0usHWm7Fv2uWfGaPUKChiZkD0NFSgZSCfaRNrMU8EFO4pv5jumGV/C3udYGhnyYxLwxAbzyYX9kC49rK9HjZAt0hf5vW439OH2VitKV8CXbBhE5A5CEE+XzREbIb9pkIc9Wb8uP1UK2nMdo9ZyBskU3NXOnJWg/BYaHCaDPDm+LB7u/IncfXeeA6LnpX2g4ijxLnARHwV8r7MkJCoI8GyFmx0wOrnL4yQ/FQkxyUlbnU/QNmGi3vZZedTMtbupKgVqSpFj+cHixukDCEllhgpIJLsmRSIKflA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxr1ZxzcjEQKLgBXe3FpxO26iii7fldyEoMVD4LluJg=;
 b=EL3OpA1jlioE0/WpQX4bqT2jvs9M11okfPkYkK+Tdv3rfebF+TFJNtg9FmmgBNpyOcwsH4jYLw6XxcM90ec0tc65fsswiVJC/nRy6Ajyrq2rTjAP1fx/aILvi5/bvD1jEl5Ix89S9nNePySAs6Nfa5bHsAbDrv+g970cMYFMQiI=
Received: from BN4PR12CA0004.namprd12.prod.outlook.com (2603:10b6:403:2::14)
 by CH2PR12MB3816.namprd12.prod.outlook.com (2603:10b6:610:2f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.14; Thu, 19 Dec
 2019 11:43:53 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::208) by BN4PR12CA0004.outlook.office365.com
 (2603:10b6:403:2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Thu, 19 Dec 2019 11:43:53 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Thu, 19 Dec 2019 11:43:53 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 19 Dec
 2019 05:43:52 -0600
Received: from vbox-debug.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 19 Dec 2019 05:43:51 -0600
From: Frank.Min <Frank.Min@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: add psp session ID get interface for sriov
Date: Thu, 19 Dec 2019 19:43:35 +0800
Message-ID: <20191219114335.22528-2-Frank.Min@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219114335.22528-1-Frank.Min@amd.com>
References: <20191219114335.22528-1-Frank.Min@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(396003)(428003)(199004)(189003)(6666004)(7696005)(8676002)(2906002)(81156014)(2616005)(81166006)(70586007)(8936002)(356004)(86362001)(4326008)(70206006)(1076003)(426003)(186003)(6916009)(5660300002)(26005)(336012)(478600001)(316002)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3816; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca7d6c30-00c4-46e2-f9ed-08d78478b90a
X-MS-TrafficTypeDiagnostic: CH2PR12MB3816:
X-Microsoft-Antispam-PRVS: <CH2PR12MB38166C0B57F01D5367B123F5E9520@CH2PR12MB3816.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-Forefront-PRVS: 0256C18696
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nG/u2Ymf8sinUqPCrW4fQRxwEUWnjCDmcK3bFy9NSnQRQjl3w8cskeWlQOGI6gvv+7/NpRt2IvWsHlD9Va7ES1L22DCN/Yt55r3ShEKEI6XnDpR8HPiggfpsl+u3MIpvhDkn6QEKtBLUkTSjT9IMFp2sLJPzdJSI7uYKFlg4ochP79g8FgeJ5496oVtaAIKj43XGnu5ojpC9P0gYHrvC5CeZ0IWxwEOJBah6nsJZMwEHeq/FIlWjdNqrdJUq5Qc9R1lisnbrkCRJckWMU14t2T2JPVDPO+XdJMjz0Li6pqGS2x/uzdjjYYYhqHKMJcVlm+q3T2ekpf5xBa0HV7GgZuc7/qVu1MdQYVE23PaIZmpUaQ/+pDPvE+uRx6t1DzdlCHDvESYuGLpL8femB/RkasY8nk5eOw4IEBwSqMgLjb5JXrdfUY3LLfX0UPhz5PU9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2019 11:43:53.1240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7d6c30-00c4-46e2-f9ed-08d78478b90a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3816
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
Cc: "Frank.Min" <Frank.Min@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

on sriov, psp vf ring running depends on interrupt,
so have to move the xgmi TA loading after IH hw init.

Change-Id: Ieffb3a94107c437f54abc0c41238c6f40274b35d
Signed-off-by: Frank.Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h |  1 +
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a0bee12b095f..73c393392b0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -573,7 +573,7 @@ static int psp_xgmi_terminate(struct psp_context *psp)
 	return 0;
 }
 
-static int psp_xgmi_initialize(struct psp_context *psp)
+int psp_xgmi_initialize(struct psp_context *psp)
 {
 	struct ta_xgmi_shared_memory *xgmi_cmd;
 	int ret;
@@ -1540,7 +1540,7 @@ static int psp_load_fw(struct amdgpu_device *adev)
 		return ret;
 	}
 
-	if (adev->gmc.xgmi.num_physical_nodes > 1) {
+	if (adev->gmc.xgmi.num_physical_nodes > 1 && !amdgpu_sriov_vf(adev)) {
 		ret = psp_xgmi_initialize(psp);
 		/* Warning the XGMI seesion initialize failure
 		 * Instead of stop driver initialization
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 5f8fd3e3535b..a29ffe2e5b45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -362,7 +362,7 @@ int psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
 			uint64_t cmd_gpu_addr, int cmd_size);
 
 int psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
-
+int psp_xgmi_initialize(struct psp_context *psp);
 int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
 int psp_ras_enable_features(struct psp_context *psp,
 		union ta_ras_cmd_input *info, bool enable);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 61d13d8b7b20..f791ff3f1f64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -357,6 +357,19 @@ int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
 	return	-EINVAL;
 }
 
+int amdgpu_xgmi_get_session_id(struct amdgpu_device *adev)
+{
+	int ret;
+
+	if (amdgpu_sriov_vf(adev) && !adev->psp.xgmi_context.initialized)
+		ret = psp_xgmi_initialize(&adev->psp);
+
+	if (adev->psp.xgmi_context.initialized)
+		return adev->psp.xgmi_context.session_id;
+	else
+		return -EINVAL;
+}
+
 int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 {
 	struct psp_xgmi_topology_info *top_info;
@@ -369,6 +382,9 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 	if (!adev->gmc.xgmi.supported)
 		return 0;
 
+	if(amdgpu_sriov_vf(adev))
+		amdgpu_xgmi_get_session_id(adev);
+
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
 		ret = psp_xgmi_get_hive_id(&adev->psp, &adev->gmc.xgmi.hive_id);
 		if (ret) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index bbf504ff7051..9e917208e25f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -36,6 +36,7 @@ struct amdgpu_hive_info {
 };
 
 struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev, int lock);
+int amdgpu_xgmi_get_session_id(struct amdgpu_device *adev);
 int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_device *adev);
 int amdgpu_xgmi_add_device(struct amdgpu_device *adev);
 void amdgpu_xgmi_remove_device(struct amdgpu_device *adev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
