Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B758BC77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 01:27:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E93DF10E314;
	Tue,  9 May 2023 01:27:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11D9310E314
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 01:27:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwVEsujvzFTz00DotBCTsFIbbNPP8hH1+XU4Il06w5Bn3MEh249YGIS1RCFDF/h5dyM0fQ4YAcFXyEo6cRVeqWMKOCGvTiTX8oTipBuorL/MEnI6VksFrfr3M/iOW41YDZVbRreXAZY76XJrpjXXXMi44j1/3//3QHD/mnkMH6uZS5xLtRECChjsev6RHvwbcFNGgJDdHj9pz854g0lMJVJAo+ar8vwTS7aKIw9l8H3M4A9vmnuwVjT9QJswhyySJj0wmG2dN9pV7vJfcVKSF8lgSeru/ah0OdRWbsPsfvdu6YXV//+OxhWDC/EkcwzW+9iFH8++vq9s3wiuD45reQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWBN3KsQ711OwJcvIJs+oqv1hVq9BPNhz+LsggQW/xI=;
 b=f9cqerl8tB3sWkkeiB27Q7CcB2tvVWqtk10H92tMpe1D/twZQlSdl7cFhY7slGPfZP3deWSdWCTQ4Ui25nZrh/Ooq0WzCBlK5n8ujtWXFdFzTieEJNkUQohe3kiUush2smyeZaY4WdQGn43DaJ37cyXhW6W62wjJ01CSHR9tU6v3IrwUNZI2r8S3B8qiQoqRhSZUzjm6ljrY2EYpXPc2UxVWbCWtEl82dnIrHclFerg+2AXBjOirD6mtSujokV06WcDt+gGIpOAc/GPiUng3g+fE3+rMbeC5jM4wLOHBlWeUclGeiXpqEQBQRKrMY59hphqiiybhEBhkfrfGrVdz6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWBN3KsQ711OwJcvIJs+oqv1hVq9BPNhz+LsggQW/xI=;
 b=yBl1eFT8+Q38EyQAO3amDqrxR1OwdK/64GGb2lGDmn8FAU7iA/wOUsLqc9k9cLc7ZbLl+UHiOzo3yPg2weRZt2GXK0qhYExl9acNWwcmmIoMaKXP7UJ69m+DX7Ga3kzuPNwBkgRK0K0RXzwJIRktiJGNGW0K6+Y1gkLisVasoRw=
Received: from MN2PR16CA0051.namprd16.prod.outlook.com (2603:10b6:208:234::20)
 by PH7PR12MB6787.namprd12.prod.outlook.com (2603:10b6:510:1ad::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 01:27:51 +0000
Received: from BL02EPF000145BB.namprd05.prod.outlook.com
 (2603:10b6:208:234:cafe::55) by MN2PR16CA0051.outlook.office365.com
 (2603:10b6:208:234::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32 via Frontend
 Transport; Tue, 9 May 2023 01:27:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145BB.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 01:27:51 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 8 May 2023 20:27:48 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <evan.quan@amd.com>,
 <christian.koenig@amd.com>, <xinhui.pan@amd.com>
Subject: [PATCH] drm/amdgpu: disable sdma ecc irq only when sdma RAS is
 enabled in suspend
Date: Tue, 9 May 2023 09:27:34 +0800
Message-ID: <20230509012734.2095928-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BB:EE_|PH7PR12MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 6841075e-35fd-4e54-f2e2-08db502c9b22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RifYE44cgaIcIfi7UrHoJP1zoYk8RQpRTPzUpXVqTL9u7MmPmDTpVAMSWG2onjDGfOPB5iuz2Q7JjcnKkPeAjN8GD6h+oFBifwIkoDtwBQZUdOHmzOTBHsXOQVD2b8pzyzLnzQODgsrrDU/cBQ/qkNHPW0ev+9FbIop9MG6GVUbKZS2G2AIL24GZYjKXzth+3GS7jOe2rWNQTt5UklxVoGjk0h4doRZVQyJOoFl+vXxIPMQttTAGaN6rgjtDcaZt0vidQ8XsOwss467SQkGjotNb17KibyIc/HoJ9p/E0s0dJaGAzZB4M3ZWeHq/TyOsexYEF5lfuD3AUG+W3G/5RN17NQXVZYNfuwPu9QjkSkcjKyEz0fqqdZEiK0Aj8r1KnUEinYA8W5qxkZYCe3kb3sX9eA3pySITXr4xlSgFsqkPI9lZ/MNlqYrG3IUrVKdVoT5oNpHxuczjGVmafiwDDTEfAycv2yq5MY8sr6YCJI+gVkmi8ROFh7aIL3AnaPPStQDF1mjWPtB0wvCScba8I9tow860lMzNhw69DqEYo2NTrebS/pDJR9RPn/YmNGIYVw+SHwXmqlKoA9IeMo3Q3pFHdXeHo/5qOoHcUikd+5YoxMmA833riHO4ZpwmokZS8E4ri4pfov9W43Wgm2TmeXiu0+npWKgG7Zm9If5Zb61yrEQ+ydu2v5zSkMcNnMqeye2KGZN1RQZHpMsVXfMyDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(40470700004)(46966006)(36840700001)(54906003)(4326008)(2906002)(5660300002)(8936002)(478600001)(316002)(6636002)(8676002)(15650500001)(41300700001)(16526019)(110136005)(6666004)(70586007)(44832011)(70206006)(7696005)(966005)(1076003)(26005)(186003)(82740400003)(47076005)(40460700003)(2616005)(36756003)(36860700001)(426003)(336012)(83380400001)(40480700001)(82310400005)(356005)(86362001)(81166007)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 01:27:51.4130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6841075e-35fd-4e54-f2e2-08db502c9b22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145BB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

sdma_v4_0_ip is shared on a few asics, but in sdma_v4_0_hw_fini,
driver unconditionally disables ecc_irq which is only enabled on
those asics enabling sdma ecc. This will introduce a warning in
suspend cycle on those chips with sdma ip v4.0, while without
sdma ecc. So this patch correct this.

[ 7283.166354] RIP: 0010:amdgpu_irq_put+0x45/0x70 [amdgpu]
[ 7283.167001] RSP: 0018:ffff9a5fc3967d08 EFLAGS: 00010246
[ 7283.167019] RAX: ffff98d88afd3770 RBX: 0000000000000001 RCX: 0000000000000000
[ 7283.167023] RDX: 0000000000000000 RSI: ffff98d89da30390 RDI: ffff98d89da20000
[ 7283.167025] RBP: ffff98d89da20000 R08: 0000000000036838 R09: 0000000000000006
[ 7283.167028] R10: ffffd5764243c008 R11: 0000000000000000 R12: ffff98d89da30390
[ 7283.167030] R13: ffff98d89da38978 R14: ffffffff999ae15a R15: ffff98d880130105
[ 7283.167032] FS:  0000000000000000(0000) GS:ffff98d996f00000(0000) knlGS:0000000000000000
[ 7283.167036] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7283.167039] CR2: 00000000f7a9d178 CR3: 00000001c42ea000 CR4: 00000000003506e0
[ 7283.167041] Call Trace:
[ 7283.167046]  <TASK>
[ 7283.167048]  sdma_v4_0_hw_fini+0x38/0xa0 [amdgpu]
[ 7283.167704]  amdgpu_device_ip_suspend_phase2+0x101/0x1a0 [amdgpu]
[ 7283.168296]  amdgpu_device_suspend+0x103/0x180 [amdgpu]
[ 7283.168875]  amdgpu_pmops_freeze+0x21/0x60 [amdgpu]
[ 7283.169464]  pci_pm_freeze+0x54/0xc0

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2522

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index b5affba22156..8b8ddf050266 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1903,9 +1903,11 @@ static int sdma_v4_0_hw_fini(void *handle)
 		return 0;
 	}
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
-			       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
+		for (i = 0; i < adev->sdma.num_instances; i++) {
+			amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
+				       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
+		}
 	}
 
 	sdma_v4_0_ctx_switch_enable(adev, false);
-- 
2.25.1

