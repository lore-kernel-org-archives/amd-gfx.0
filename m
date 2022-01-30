Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C88CC433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Jan 2022 07:38:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B676310F866;
	Sun, 30 Jan 2022 07:38:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B00310F866
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jan 2022 07:37:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jk6BqxaAbEXpXwWsZvpoDWOGdCmqFx5h5XHPLRjYqj1fVHjzmTadETOlcu8mNvCUH5+SLybf8pmieJC2QidLmeplDfYuZLh9vojE1+n016iuRJ+8rHb0GTFMkqFZMy8acL+EkhYPaIZbLKNRmtq+kdhOPmtKmQfORrnajDQo8bJ+xAzOy6zyAxCu8pNKla6fIn/dlLNHz66rLtEDX6ho9H4T6aBk127Er7D4Jp+qMWyC+76BPqhXbEo4fcfdNklXhos5u9pPSol3b7ZVYKv5T4sjinpH2kDBs6I+FT3O+bySB8oOs6O8J1M9bvwUFJN6GbiP0wTRG9BYtrsGI59P/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cxcai1vm35eUT88J0AXIzbdWc0BNJKtvSByK71ncgpE=;
 b=FjJMppDsAJK9NmTkxO7Zn14zBRNgr01kOGuIl1gLn6V/HF+fYH05b5afLNk0CrBKaKI8IQDBEjX+4Yd40LAYGZ0t+I2boiQMGPQ9wTnDehfx6/UIgMCdy+V8yWjTA0cW05OqfUir5bWrmhpBTSyviuesDL0bZbvSCZAPZ0bqWs5AGiD/DllTBK9/Ba1D/ktoxpkP4B6s171pzI/Cvxjk0Tz8OKheZtdGjwueYI2UwQ+YfYqLLoJEcbYI2iLPYmIVNgz5XxzF839KAfWB8khlDB1mNl28Miipg5auYMyY0GMq4pT4jNAroVLKm7CDnjET0FjRt7FbKd1sLr2qz4gQDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cxcai1vm35eUT88J0AXIzbdWc0BNJKtvSByK71ncgpE=;
 b=WQA1Sfn2wvnze9Cb1frMuv4CFIF5DUrwvLJD/sHvaDr1q6htMUh9yvylmZZUIW9cpAn0u3fZlxV5JU2qlseHoYpActj8wLp11qnmM8aSGcisNNyqkrjv8Gmo9r6whoS/PNz0LGY5BlrBxUXudAacqGHJpxLllEJR5nC5oAMg+QY=
Received: from MWHPR15CA0044.namprd15.prod.outlook.com (2603:10b6:300:ad::30)
 by CH2PR12MB4921.namprd12.prod.outlook.com (2603:10b6:610:62::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Sun, 30 Jan
 2022 07:37:55 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::65) by MWHPR15CA0044.outlook.office365.com
 (2603:10b6:300:ad::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21 via Frontend
 Transport; Sun, 30 Jan 2022 07:37:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Sun, 30 Jan 2022 07:37:54 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 30 Jan
 2022 01:37:51 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <yipeng.chai@amd.com>, <john.clements@amd.com>
Subject: [PATCH] drm/amdgpu: fix list add issue in vram reserve
Date: Sun, 30 Jan 2022 15:37:42 +0800
Message-ID: <20220130073742.17173-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec089463-9b4e-499a-b20e-08d9e3c36d72
X-MS-TrafficTypeDiagnostic: CH2PR12MB4921:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB49216C52113AED1AEFE47852B0249@CH2PR12MB4921.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2tbPVmteRSINoXaU1fJD5+sSnc6zvflAnYWsM4CpxkUZL41sOwTpLYvCwlhU42vBkSTUEMRDUXjBen0pary61Nx7pRLyrePa773PqKDFpyPS+enUCKwF8KebpuOWrkM1R46QgBMLZTw72wXTZFYtc/QOrzwErUsVorCPjUp1ArHLwPJyWixYG/XSYtdMlyKIZwY80QvSNmJ09uwemylgwnNk1+pz3IRr+dpl1GhEVz+fKYzOU9ccfjrZZVKV5YKadGeurX4C0nJ28KRuRepE/LktCZrDP+uHeARz7F5aYuSMkAw7J7WidC80+tsfGt5yiQ3zQsS5xXPJhZhFhlFDaPTigfh73RV/UApuk3rD9Zl+8eR89ShdKRDbwHyofgewQeqHD0KCsWt0F5rBMFgg4P85PVghqPwW3UXFOb6ZS0azvBW4jM24aFbz7n2dMN4LBm0Jb+rZFVSkk+GT+ndZOH+jnj3VfU9hMgNTlI2KAJ9GlP5tRG/ZjRUiuiun1RqKO8evx589i5TaQMo+wMfqwSHiNFAqEXfGq5sIE46Oo5wUNRW/tq37uzsi4VdqMa5y0yu8ey70kk18QV6JgwG+7ZTbOdkEl4b22gExOmrNKuIDwunqu7qgB5x+dtLdgdDRIsMWuHqtEhfScI41hYGyS+x6xZSu7HF6vDd3LeOMe+iDYmiIXycIPoNKgWTdREjcBI5EghtDLdlQ2eV/vYg1IQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(4744005)(8676002)(4326008)(316002)(70206006)(70586007)(36860700001)(5660300002)(47076005)(2906002)(6636002)(36756003)(8936002)(110136005)(40460700003)(26005)(81166007)(16526019)(1076003)(86362001)(6666004)(186003)(7696005)(426003)(508600001)(2616005)(336012)(82310400004)(356005)(83380400001)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2022 07:37:54.2122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec089463-9b4e-499a-b20e-08d9e3c36d72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4921
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The parameter order in the list_add_tail is incorrect, it causes the
reuse of ras reserved page.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 7a2b487db57c..6c99ef700cc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -281,7 +281,7 @@ int amdgpu_vram_mgr_reserve_range(struct amdgpu_vram_mgr *mgr,
 	rsv->mm_node.size = size >> PAGE_SHIFT;
 
 	spin_lock(&mgr->lock);
-	list_add_tail(&mgr->reservations_pending, &rsv->node);
+	list_add_tail(&rsv->node, &mgr->reservations_pending);
 	amdgpu_vram_mgr_do_reserve(&mgr->manager);
 	spin_unlock(&mgr->lock);
 
-- 
2.17.1

