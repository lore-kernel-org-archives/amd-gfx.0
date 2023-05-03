Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E8AC77B7F
	for <amd-gfx@archiver.kernel.org>; Wed,  3 May 2023 09:10:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F09C10E229;
	Wed,  3 May 2023 09:10:24 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9445010E229
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 May 2023 09:10:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fg/kh+Ky2lfQw8+fhNQHiG4tz7KhiGSjmskkEDdxt4vjUqEiDF5I1mJR3+HXTNDKGZITxD7DFebadnyFmjzzOlv3+poUC1ABlefZ+QFy7Yjxr6JaB9vG953xmie9RLMQEcRDYCEY3cIT3ct5C0uYZEK2/Hbrjop+ee3yFisQQkDHVD8QrUi6bH1Y7fim4xv4+1o+fUiVbY2BC3yRzkVajvUgvHtxf3Nsd4bNoQIA7j9jPv0NXSCk2OgcYH10cfyt0j9z4k1g0qzGev/6EepZ9M8KCOiSUHKKWeoi8ZLNvpfFkgZjfeyGTbtYalFb+/sqddTQvm3Q6+G0Qz+jN+mlDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/d6ldhffE+vi9xqKbNhHxIHTa/hQzH/NAv/Gd/0aSTU=;
 b=aGPP7WZqoX4PeLN2y6LdWs+O/6t7O8FVoTQOPsCOKTVVDpoSFbDPSpnq9UwkNMLhkxsWNbgrE52t3SgIIsQHcPFizJiqo4HuvWzuZZo0+ntYxuC9WsJOGY8wfDOvkPA3B9halJIATcuFrAF0x/BmLcxBlM3FltDjEdkiURm5/jEbdsUEDEDzRZJNrloGGAVodhVc1CNIdJLjYo/kHLhgkPE5trQLArKaqL7NVKzO6YLTvi4h41pd9QupX6p9wYyKoS6j6+PCvVKL/9XeLX80paLVieEQmeoZYw9fRl6THpT1fu0vvoEybKPH/WDd0JEyvKUZxdejiiuoI3PnQaKphg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/d6ldhffE+vi9xqKbNhHxIHTa/hQzH/NAv/Gd/0aSTU=;
 b=J0K+D/8K0S+9PuXa+Zf/IDCzO77zDm7Tu6Wz4OL9TXT8Fu30aipW1YZ4VBkKHC94pTnyw2aYIrMlkY690EkvIxa8z3XPMXzkaeeAJUqL+vKbQHIUt/fh7MBjdahFHZjMOJMPOKI0F3GR1ViMzrDyCWdHPx+RefFNGjwvB2OQFmM=
Received: from MW2PR2101CA0004.namprd21.prod.outlook.com (2603:10b6:302:1::17)
 by LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20; Wed, 3 May
 2023 09:10:20 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::c6) by MW2PR2101CA0004.outlook.office365.com
 (2603:10b6:302:1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.8 via Frontend
 Transport; Wed, 3 May 2023 09:10:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.20 via Frontend Transport; Wed, 3 May 2023 09:10:19 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 3 May
 2023 04:09:52 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Remove unnecessary OOM messages
Date: Wed, 3 May 2023 14:39:37 +0530
Message-ID: <20230503090937.1489457-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT039:EE_|LV2PR12MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a106b5a-7a69-410a-18ef-08db4bb6382b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LmvuLEOF/YkV7bngKzqtgPXjEXHHh6XQQbYozK66IsW+1IQIz64ONxVScvgUvHlmw0dFIUFopgwCRP+UhHEZPQhRVlmfUK12gcAoCbQQiWe4q97FuP2U0iuPkAvvyfyYJk5SZ8zodAI5yvSzYGC2iB9mitk3Z6B7tsMs/TX5eyc5hfy+c74q22whUwK7cVMWW0k50/dMIxt6aJleF/tKVIFQnDIaDD7dKftgcNu1CQhYAf/t0XJJH6tqHAOJ9WC7kVsmOmjjs7CEmTn5e9Q3hJzwjswHfVa84VeeQFNwm1LenQQ4Wo2RP4rw2dz6dNTc5H641tlVov0eneCDo/3VWYv+Vf3kQrK60F247CNZubSCBdDjTLZYEKsxGk1YjUcXdgltpiuBEaUT3X1W7jeZEJGLV30Y+udfFa7eJEx4msVTgWNIoUmSJVu7DNt5606K9eAQUYPmnYsjbkd8HZBChBcZZmFI+wlMrGitFvDZxBOGK2IxFrqF1Xzhcc5jlAaOPnLqC1lqrOIRbUQD5kTyE7LwEin6r5Yr6zPo8RiF1Jkx5dOeXmyI/qL5LiHDGgwDQYYVoSWwg8op0Re+FjKQ6A2umAbt92iaCazaAXBf62RdXj5iReUlCmnjn2FVc78THVK6lfjgQOW9TNShxo3soAcVSeyqPiv1IslykSoJuyLjT0CiWg3K7S5uU75Jh/ctWyfMmCOVWTTWG7/gqbk86C+QhvCHHxOEGIrX05iqR5o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199021)(46966006)(36840700001)(40470700004)(70206006)(4744005)(2906002)(15650500001)(70586007)(2616005)(86362001)(336012)(426003)(82310400005)(44832011)(5660300002)(8676002)(8936002)(40460700003)(36756003)(41300700001)(6636002)(40480700001)(4326008)(54906003)(110136005)(478600001)(316002)(6666004)(7696005)(36860700001)(82740400003)(186003)(16526019)(356005)(81166007)(26005)(1076003)(83380400001)(47076005)(66574015)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 09:10:19.9818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a106b5a-7a69-410a-18ef-08db4bb6382b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The following checkpatch warning is removed.

WARNING: Possible unnecessary 'out of memory' message

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index b582b83c4984..2e0f82f7b2c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -318,10 +318,8 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_device *adev)
 	pci_dev_put(pdev);
 
 	adev->bios = kmalloc(size, GFP_KERNEL);
-	if (!adev->bios) {
-		dev_err(adev->dev, "Unable to allocate bios\n");
+	if (!adev->bios)
 		return false;
-	}
 
 	for (i = 0; i < size / ATRM_BIOS_PAGE; i++) {
 		ret = amdgpu_atrm_call(atrm_handle,
-- 
2.25.1

