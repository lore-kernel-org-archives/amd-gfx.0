Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A44C4743D
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 07:05:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA45A61059
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 07:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA45A61059
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A581B6E5BE;
	Fri, 11 Jun 2021 07:05:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD17C6E5CA
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 07:05:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OveDLq5WDLIglTdo6mtHY+Pqpuyh6cdx7Cguhwz2gtfaQDKRNxVv3XLdzzjpDObRZdYoHuK4bpZQuj09IGsVBos6ggQipoWXxMZmH1m/DHge68XUDWvvwXksb6mQE5zaKR1qI854DCOVAVpeHnjYIeFULVzASsQpEtZNc0fFXO7wAv3rd/b5rYtUl0oX2a530qsh1pUCpZ/b1YMD7QjGMMlXVwJdOIUGCRGtRC7tQWE9numGonTx2QHLrY5mKCn00LBEfxiH4p3pOOzi1HhJFVWXNXqhj589uYGvaAXeN7Fm5kaR0IM8YYuFQGMvT2rBQiYU9HlkzWv6DNIBTHO4xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+V0GXFvUM1zoN4W9yXPM3z+/tF5u4XP5c6qrlbnVcrU=;
 b=Ck4yJ4IxxSGsG8mYk2J5j3Q2BOpWl070fxcMV9iGXgF3XfzJ1HIklsfSedkQHYE5njlDJ2Kx9tRiTXbI4Y+1W1ZNI31HRSbGRMOIFHKkJxdF2aFNkT5dwpSXcFPo+3lobfrUxBcYayfClChvrZ9i0fy+aj2pICbg1KXWOh27LkUBEPywh88jRhJKYVmbpa9LA6KPEbQeuhKv8k9V1DN031NtSRTVhgONUldnLBibzP0AV1n4M4nayBwEKsJznnKrs0A77mtxvepopHITaXCYGQdX4IXQ9uvpZRqwy8SoYtFPKn/vSAiIrfb1EYGZA6TF5i4RPdzkHsFWCunVKBxgAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+V0GXFvUM1zoN4W9yXPM3z+/tF5u4XP5c6qrlbnVcrU=;
 b=s4/H04knL/oOqrehNM1PVg4JmmO/t0c4t6NXL8SHZrbAjaGp1y9gGmGDIHaKT4SZLIcBKDeZ+cFGN5knjj0qnZlg1wWWYKMEcHmhJLBWGND/z2VOUTBOFB01Y97ozYDoPuGYBz6YpfdwiHIeDK1QcjQ3tskekxjrN7pi4n1Bisk=
Received: from BN6PR16CA0029.namprd16.prod.outlook.com (2603:10b6:405:14::15)
 by MWHPR1201MB0223.namprd12.prod.outlook.com (2603:10b6:301:58::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27; Fri, 11 Jun
 2021 07:05:51 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::b9) by BN6PR16CA0029.outlook.office365.com
 (2603:10b6:405:14::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Fri, 11 Jun 2021 07:05:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 07:05:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 11 Jun
 2021 02:05:51 -0500
Received: from hawzhang-System-Product.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Fri, 11 Jun 2021 02:05:50 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/8] drm/amdgpu: allow different boot configs
Date: Fri, 11 Jun 2021 15:05:40 +0800
Message-ID: <1623395146-2162-2-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623395146-2162-1-git-send-email-Hawking.Zhang@amd.com>
References: <1623395146-2162-1-git-send-email-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d88f1e68-629d-4c24-1dfa-08d92ca75931
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0223:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0223BD52841540E0566D8FF5FC349@MWHPR1201MB0223.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:519;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5mHHVxp16JpnSv5dYm00QELlLvBuFrjOyAfpwR6H67NL5Geql3JbqgCQg1tkBq7sVFJLBIuhrgWpT6ciqao8HusxqaHcE3K+WgpCAVTvoIY/vbRp9dzNt0psiAUEYVjL3SFDph1Cp3h3wFwoFMEwaOB+YoNNlLLFM2XZSj+XF8kS/RvKWWhWpIWhOdh/eJuB3ulodalLq6j08wl6fSZDt8EcmnPlz9Y3KP5q21aLbfzf6U8/a5K6rjdcbPdMeYNFA7vmCvvK5S78nEqbogAuoiXeLjEIDqQvSWL/WirVPNwVsHN8Ri5A3x7I5IfkQ9JC7A4WHZY+YOCZhK3G+YiZygrg+bUmWsdVGb+eqp1IOWG8j26Sl1OyLJ6Pljyi9usbwlsW0XA7SNW7LanFD0EEsBPllgtBq039XxddcEDoYzjehD+x7/+rA8ZfksRj0MsjGURq9HO1x8M9lFa0pWcWfVRjcG5JINu0XQiEkVPqsrxp3Ycp27F/pDoldOpDyIaW/nuDYVFninSeGWfxn3DgjPtPW33oZKgJ+J2e3bzNIAs0xM5w3neuawCt46w1TgerTHAhLR5VyVGJmRo+z7/wjclhJj7W7cs1hIajqP/ffUy+OUyPeyKWAIylMX4GoXy3jhsVe/FJd2L6BRdDvc/7EoMlV0prZH2R97QQoIt72Oo0QPRF4/ByPql1Wnyj4zwx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(46966006)(36840700001)(336012)(26005)(8676002)(426003)(36860700001)(83380400001)(316002)(8936002)(5660300002)(81166007)(82740400003)(6666004)(36756003)(7696005)(2906002)(2616005)(47076005)(356005)(70206006)(478600001)(6916009)(186003)(70586007)(86362001)(4326008)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 07:05:51.6757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d88f1e68-629d-4c24-1dfa-08d92ca75931
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0223
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

More boot configs need to be supported via
BOOTCFG_CMD_SET

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: John Clements <john.clements@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 55378c6b9722..a8856697733e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -535,7 +535,7 @@ int psp_get_fw_attestation_records_addr(struct psp_context *psp,
 	return ret;
 }
 
-static int psp_boot_config_set(struct amdgpu_device *adev)
+static int psp_boot_config_set(struct amdgpu_device *adev, uint32_t boot_cfg)
 {
 	struct psp_context *psp = &adev->psp;
 	struct psp_gfx_cmd_resp *cmd = psp->cmd;
@@ -547,8 +547,8 @@ static int psp_boot_config_set(struct amdgpu_device *adev)
 
 	cmd->cmd_id = GFX_CMD_ID_BOOT_CFG;
 	cmd->cmd.boot_cfg.sub_cmd = BOOTCFG_CMD_SET;
-	cmd->cmd.boot_cfg.boot_config = BOOT_CONFIG_GECC;
-	cmd->cmd.boot_cfg.boot_config_valid = BOOT_CONFIG_GECC;
+	cmd->cmd.boot_cfg.boot_config = boot_cfg;
+	cmd->cmd.boot_cfg.boot_config_valid = boot_cfg;
 
 	return psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
 }
@@ -1934,7 +1934,7 @@ static int psp_hw_start(struct psp_context *psp)
 	}
 
 	if (amdgpu_atomfirmware_dynamic_boot_config_supported(adev)) {
-		ret = psp_boot_config_set(adev);
+		ret = psp_boot_config_set(adev, BOOT_CONFIG_GECC);
 		if (ret)
 			dev_warn(adev->dev, "PSP set boot config failed\n");
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
