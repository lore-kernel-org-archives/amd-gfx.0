Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AFAC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 09:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A6E161108
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 09:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4A6E161108
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C99E96ED05;
	Fri, 15 Oct 2021 09:10:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4367B6ED05
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 09:10:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4+5CJEvSPh/WHiH7EtZBimzixpL1gfLmGJQIQ0HKmD8XZAk3JA6WecYiZ29Dx4f69BvsPuxkP8fNuC3vIWsKzyhz8lv/A5WKpVlc8OlX5VQcHcftcr0oeDpcGxkJczuaqTL9bnAFU5KKstAB8QA5mNIvJgYXgmu1eT5S7ycPxd5zd02zRrV/7RvQZPxQ4oZvmo9SnIwP8WLcJu7FIVE27byPYaynZ0nwvwQayenGQDP7nPN0+Vh4MLFv5v9pa2fn2sahaO+mFnBxzAxZURqnkX5/nogOUeQAQQj08nba48WEpv3m3aCzFQlZJswxHFdgHpn0sE1bvKo8Nh8nk0oBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEa2UZcTKWvHWD5pc7JDVGnjxljv3Jwwoza/lryC1R8=;
 b=Z7gxSQCr1H5rKWHMKZKaoWYXhPGX/lLfW0wQ+Dpu6URxHk0HUxAme6IyWhgZLAGwVC1qFMpdozUX+6D213daFIuAhkvwIYR94uzx7J5eYEh1M1YfpDWLg+5/zdNRjziBwl8jfrve3zzO7dDFQNcZ4/Sz+7jmYn+AY4wZZt8RCdafnpJ5EP3Gd1l+/0CKfM8hCO9GYc/hCy3qBf2EbsrWYR+pkrHkcEmCxOXdwYBPM+urAstLRiElMNBj5jlEeEGoJaQQGSh+x4O1PuMBwNzSlptv4z7gXv0WZ4Bn3XFECkwvTmo3HO5UFu78sshzImZBOIl4cur3V7glAWFmC4vY7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEa2UZcTKWvHWD5pc7JDVGnjxljv3Jwwoza/lryC1R8=;
 b=Wv6AMCq0xfcaaUTTJE7GhIEZi+zZJvygZdSTg55jwJNMHp1C5z1lgrSe2vkHeawBWVwstBR/WSZ7N8A6UorpdQqpQzxuqoPk+2llIcteXm6gUM+LudaWBm53zLGqz8zhNySZcgJ/G1EKsHpC+xgSzuPmmYZ3OSpk6id2iiNxkiw=
Received: from DM3PR12CA0122.namprd12.prod.outlook.com (2603:10b6:0:51::18) by
 BYAPR12MB2725.namprd12.prod.outlook.com (2603:10b6:a03:6b::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.15; Fri, 15 Oct 2021 09:10:44 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::e9) by DM3PR12CA0122.outlook.office365.com
 (2603:10b6:0:51::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Fri, 15 Oct 2021 09:10:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 09:10:44 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 04:10:41 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <john.clements@amd.com>,
 <hawking.zhang@amd.com>, <stanley.yang@amd.com>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: output warning for unsupported ras error inject
Date: Fri, 15 Oct 2021 17:10:33 +0800
Message-ID: <20211015091033.21214-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfda8001-bae6-431b-eacd-08d98fbbab0f
X-MS-TrafficTypeDiagnostic: BYAPR12MB2725:
X-Microsoft-Antispam-PRVS: <BYAPR12MB27255627424278D2454BCC5FB0B99@BYAPR12MB2725.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:374;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ejRxRNTnUn/tmEBmDJcmZseKsPrQm2+n54ksEnjBnoEEPTKV3hN1CM5kxIpnPoLamzsy8gX0hTsfC5J1eYfmVp2zholdrdLvSEbWZz1c13H2UD1qei497DwBIL1KF1gfPmAVe33Ig0y7h8JqwwcZPdMlNlKXdBhrhOZ0EjyWtyB4u5ppkDKObZ6kLk/XDCXklPtCG3v80K/9KI+WKQiIK3dK3czxf8Sb5hAz7sJeY5fkR3mM4xfDI99m2sUXYOm5mhl/2AVRhQemrfAltNXMM4qN3zp/6fUnqO13fVMbxpK0HGT/5ezU8azcwDGLheAeKUp43eIGZbkZz0AiWU26uAWUr5WhxAD0Tcl06KyvW/h4sKqqdP4+1moA93WKJTm8eJ6UwAA1ykYyXM4cxaVmXEbc7k82UuP4Z5/rq97oo4HwpDkQeNcY9XtSp0vnrc+Z6qQncjPLmoQ/KcVAQbf0LxzH7pi2x4V+ybC32qITMDZtKQUJfMInk3MptY05hhhWq/JuLioiDaFXjwA04aj2G6B5hlEUFFcqoxyrjA3Hiwr2pZ8s/gS6vDhNh6YkpI2ea9qNJ2ObDcYKjxt26oI30cdDuGI7GJ+EyZwIVd71xNUPNjX3FWkd9iYlJ1IoV0/zXFzYsSMADcec1XzNX4969KGuMlqHNpK6QXLar9I0C7jQHx9OYBTjDuDx480ddJYedf6LDp5kudJ2fOi3ky1Ttds1+aYygKQW9tesioQetaY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2906002)(110136005)(70206006)(70586007)(5660300002)(82310400003)(7696005)(316002)(83380400001)(36756003)(6636002)(2616005)(186003)(8676002)(47076005)(1076003)(4326008)(356005)(8936002)(336012)(16526019)(6666004)(426003)(36860700001)(86362001)(81166007)(508600001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 09:10:44.0389 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfda8001-bae6-431b-eacd-08d98fbbab0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2725
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Output a warning message if RAS TA returns UNSUPPORTED_ERROR_INJ status.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/ta_ras_if.h  | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 88274c254c76..50d84deeb8f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1328,6 +1328,9 @@ int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 
 		if (ras_cmd->ras_status == TA_RAS_STATUS__ERROR_UNSUPPORTED_IP)
 		    dev_warn(psp->adev->dev, "RAS WARNING: cmd failed due to unsupported ip\n");
+		else if (ras_cmd->ras_status == TA_RAS_STATUS__ERROR_UNSUPPORTED_ERROR_INJ)
+			dev_warn(psp->adev->dev,
+				"RAS WARNING: cmd failed due to unsupported error injection\n");
 		else if (ras_cmd->ras_status)
 		    dev_warn(psp->adev->dev, "RAS WARNING: ras status = 0x%X\n", ras_cmd->ras_status);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
index de24a0a97d5e..5093826a43d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
@@ -59,7 +59,12 @@ enum ta_ras_status {
 	TA_RAS_STATUS__ERROR_SYS_DRV_REG_ACCESS         = 0xA011,
 	TA_RAS_STATUS__ERROR_RAS_READ_WRITE             = 0xA012,
 	TA_RAS_STATUS__ERROR_NULL_PTR                   = 0xA013,
-	TA_RAS_STATUS__ERROR_UNSUPPORTED_IP             = 0xA014
+	TA_RAS_STATUS__ERROR_UNSUPPORTED_IP             = 0xA014,
+	TA_RAS_STATUS__ERROR_PCS_STATE_QUIET            = 0xA015,
+	TA_RAS_STATUS__ERROR_PCS_STATE_ERROR            = 0xA016,
+	TA_RAS_STATUS__ERROR_PCS_STATE_HANG             = 0xA017,
+	TA_RAS_STATUS__ERROR_PCS_STATE_UNKNOWN          = 0xA018,
+	TA_RAS_STATUS__ERROR_UNSUPPORTED_ERROR_INJ      = 0xA019
 };
 
 enum ta_ras_block {
-- 
2.17.1

