Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB79C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 01:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6406610E466;
	Thu, 13 Jan 2022 01:28:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AD8110E466
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 01:28:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ni3ZIlVoxXxTJPZto/C8ub/mypwyOWY5SmehwwZvT/BDsv5Oa9XwBfupV/yi7oyEf9Rt/9WCzSdoJdQBRQbrkk6yFagCtFfYrOQbRbwnYOCHuRvyOqeXKU97FlyoVx4NNo1Rs3QqJnBJPEGNS11iYscSGQtK5u0yQHazy/kpXSzE3jUUzNBcfWLK94S0LBqtlzYiMYpCZ00nMtokEK0Vszr8XuaL72wTYN2iqyYTnWD2ri1EjplU/u/kzWZmipaoLXPlnYwKnHiP/xuV8UxThXENeuCpBDluvU9KTMzuYZmVvlRg+Lt7H3xZreo2wVj2z8nJnnZx0SLFr/P+aybdNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpzjOLC9yH18cSpcb1+Lf5NVnZ6gfMUo8Vnah3DcwqQ=;
 b=Uo9H8+GpMtcracsmJbwnZTx46+/rzbtwHv1Gi+ru5iaQWF2Kux6ShwjFq+tZ8jckfNzD5Z8TIiyEjKaSjyhjXOv83ZxydooFGQqbhxQPl0a0FIl4Gd8xGlPSKm1hA/6Q0xX6Z0+9O1rVVTbd9+0agnBXXnieWheFYxx966jg082q8vFSVjhMEmsuNipYEP/XFd50NnD1wRHbb7nh+0mkxiSPJP6GQsBrXxcmmMRA89nLJJLZl/+YHilfKN7y3UYqYy3PhDcYk8/qN3/ABrQrkxhPzE8/8LWdSw21PL0zbq7x2pGsjgwDm7c30tfMnVp3oZP5r4PLgN/Rb9XD87LEew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpzjOLC9yH18cSpcb1+Lf5NVnZ6gfMUo8Vnah3DcwqQ=;
 b=JZudhh1T/W7lFORtVgcL2DT4VvoSnc2xg2ws/ivRxnZDE4aXrYWmxEWuZ4Fg1OJa3HzPbQPwfBzujmH0YmeLy21oGkgfTjwSkmrjcAOJpXScBJHE8+psvkvB+PW0fAMCU5+Ulf3uRwUTgsTuxyLT7e8Nb2ZiFeTPY3QiH5MjMb8=
Received: from MW4PR04CA0269.namprd04.prod.outlook.com (2603:10b6:303:88::34)
 by BYAPR12MB2677.namprd12.prod.outlook.com (2603:10b6:a03:69::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Thu, 13 Jan
 2022 01:28:35 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::a0) by MW4PR04CA0269.outlook.office365.com
 (2603:10b6:303:88::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Thu, 13 Jan 2022 01:28:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Thu, 13 Jan 2022 01:28:34 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 12 Jan
 2022 19:28:33 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 12 Jan
 2022 17:28:33 -0800
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 12 Jan 2022 19:28:31 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH Review 1/1] drm/amdgpu: handle denied inject error into
 critical regions v2
Date: Thu, 13 Jan 2022 09:28:29 +0800
Message-ID: <20220113012829.27726-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c215996-5e2f-40da-a1bb-08d9d634043c
X-MS-TrafficTypeDiagnostic: BYAPR12MB2677:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2677A76FB3C70D6C3E0D1EB79A539@BYAPR12MB2677.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j69cZo9h5pZkQRH7HwkO0L1U5E0BaNTAXKaRnKTKcWXxVKy8x/3R0RwQyo0ukQtC3WpdxJSCI77OUpsMb+9gvOUm0UCdgVAlCswjYDW3b1n1BitoaPs2CVOyUpSb0uXAVZ4QN1GWDVEO5PEX3LQaRmszKeqPQwj0im6N6r6DZgKjUyNyWz9jzLNVBdx1lgdEVzOQuGbJP0P4F9Ca/ptcPYTh+Fn3INMElChu+DCA7/NnYgZtMf4daBAoMSNk6SgZ06U3Xj9z+15YfVyIP564LCTcglvrjUqNHYyJGOWkfKmmt47pwhzMfl9wASOxPLTmliunnwWGBWdRF746uY8tS1J7V2jSR0daRJwb294OgCLTdm0WWgg71p8FBwC14ewn+f96CRAgrBDKzebpfe4UIObLAhCw7Ns67hk1+iNzdyoINAkiw/E62Pqa4QIY+i3y1dj/mUuiALoAFgehepoHGmwcPWnDrfWaDMYqGbAML0AfldG5+wgAi9VV+xlidwyuTr5Aiu0lbzyXlN8FfB/MmfNfR98q+DP1ZU0CEkZTlKBFwNi4Wq4gTtR3ClQ9+gM/R241IURNegCPClqU6EpltBGXfAftcyuemT8W/YqhesY1Wbu9L9SbGEC+gR+7oznkJMNKnwH4tVmgsKsdYTJGpur3Nc20eLWgr4Z2WFqgdh8bscWxYPaFZqFKs6XIIWaR+h12+F6vOvWSKcLzH9/Rt0u/OynSMNK6EGGgNHN2Wz4I3ZCx+tUuZ5Tq4ZYATVV+S8GOcPABMDPFstAM0xINSPgMTKhcAm0/4ut5uGga1j8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(2906002)(2616005)(86362001)(4326008)(70586007)(336012)(54906003)(186003)(356005)(36860700001)(1076003)(508600001)(70206006)(426003)(81166007)(36756003)(26005)(6916009)(83380400001)(5660300002)(40460700001)(47076005)(8936002)(8676002)(316002)(7696005)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 01:28:34.5955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c215996-5e2f-40da-a1bb-08d9d634043c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2677
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>, Tao.Zhou1@amd.com,
 John.Clements@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Changed from v1:
    remove unused brace

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 9 ++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/ta_ras_if.h  | 3 ++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index c742d1aacf5a..144176779f9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1309,6 +1309,11 @@ static void psp_ras_ta_check_status(struct psp_context *psp)
 		break;
 	case TA_RAS_STATUS__SUCCESS:
 		break;
+	case TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED:
+		if (ras_cmd->cmd_id == TA_RAS_COMMAND__TRIGGER_ERROR)
+			dev_warn(psp->adev->dev,
+					"RAS INFO: Inject error to critical region is not allowed\n");
+		break;
 	default:
 		dev_warn(psp->adev->dev,
 				"RAS WARNING: ras status = 0x%X\n", ras_cmd->ras_status);
@@ -1521,7 +1526,9 @@ int psp_ras_trigger_error(struct psp_context *psp,
 	if (amdgpu_ras_intr_triggered())
 		return 0;
 
-	if (ras_cmd->ras_status)
+	if (ras_cmd->ras_status == TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED)
+		return -EACCES;
+	else if (ras_cmd->ras_status)
 		return -EINVAL;
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e674dbed3615..8bdc2e85cb20 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -449,7 +449,7 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f,
 	}
 
 	if (ret)
-		return -EINVAL;
+		return ret;
 
 	return size;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
index 5093826a43d1..509d8a1945eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
@@ -64,7 +64,8 @@ enum ta_ras_status {
 	TA_RAS_STATUS__ERROR_PCS_STATE_ERROR            = 0xA016,
 	TA_RAS_STATUS__ERROR_PCS_STATE_HANG             = 0xA017,
 	TA_RAS_STATUS__ERROR_PCS_STATE_UNKNOWN          = 0xA018,
-	TA_RAS_STATUS__ERROR_UNSUPPORTED_ERROR_INJ      = 0xA019
+	TA_RAS_STATUS__ERROR_UNSUPPORTED_ERROR_INJ      = 0xA019,
+	TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED          = 0xA01A
 };
 
 enum ta_ras_block {
-- 
2.17.1

