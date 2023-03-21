Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A31C76195
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Mar 2023 02:41:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DBBB10E6AC;
	Tue, 21 Mar 2023 02:41:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1B7E10E0D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Mar 2023 02:41:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQ9a2/xvhhV/IiJfxK5tlqZqipvb665+0NwRh3W/mzlho2lHBUaXHCdFtsUMosrfrLtlq8UgCWeTJv5LCp7ZYqPhi8a2wS5oQtDe3FNWTeX4JsrTx3z7ueM8OQhCgI0TUJEVBu9f044r79plgUheh0VdbIliLnJGE7fFJMZe9nymfAUrJ2k4nNFAQRq7doMmA//IaVsS1GHM9CRIXCb1RSwsNHNJ0+6b3kJDCwINhn0TW20vXVAldYQ7NP8pJW06ByKkc+qxCUUy632vK9gUCy+WzPjnD88aNWXogR8rmn7kshXfGrO5f0rPl///f3T+5LSvOQ11VsLs8TlmZaygbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6ztgJ+0k3ea0d/AQquV+pdY5n1Y0S20UiXvRPtvGGc=;
 b=QHW17ktrhsbxH+0OPq/J7e3rfuV2wXk78ADgErUGy6/wm2BdC/szsIOVRVGxoRkEFa8AFtZmzQLo2/4Y9UgiuQMJSJUHhU2DW7sHTxzZ9WpDzxF6l6RyNzEfH6azR/383RKyFrLuJRQmmF3p6Mz959VtIf8Xwh0CYJX2z1xXDYjUJXXbkeMkkTFqUULhD7fqG7R4TyXMGHJ1Ot+BaQzCl7KTeCxLWQac8tmsSuVib1kih0pMVaUiQB4YLgcT/faziOdWZR6QnEN4dcKal0DBkhe+U5r8TTa7W9gT7kOUEepkr/+sUAf3QPYeGVfFnvXVPyHEvWOHAZAJygoKqDIRcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6ztgJ+0k3ea0d/AQquV+pdY5n1Y0S20UiXvRPtvGGc=;
 b=3DFDfNCcFVjpM3LKPWmrUOaKJLVByB6EN6F6WR93/KAnXaGvejF46LaWvRlNz+jP7L6jNs86xnFWSuyTGzZGldp88h2+jS2gUeSygFF0CSAYcQDFV0L6MiU0wslLogSFw06e0VBdJMOMV6FkgMVfB2fWYeP1vPCIW3x1y7M9j3o=
Received: from BN1PR10CA0020.namprd10.prod.outlook.com (2603:10b6:408:e0::25)
 by BY5PR12MB4178.namprd12.prod.outlook.com (2603:10b6:a03:20e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 02:41:17 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::fe) by BN1PR10CA0020.outlook.office365.com
 (2603:10b6:408:e0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 02:41:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.16 via Frontend Transport; Tue, 21 Mar 2023 02:41:16 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Mar
 2023 21:41:14 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: reinit mes ip block during reset on SRIOV
Date: Tue, 21 Mar 2023 10:40:19 +0800
Message-ID: <20230321024020.139199-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321024020.139199-1-YiPeng.Chai@amd.com>
References: <20230321024020.139199-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT027:EE_|BY5PR12MB4178:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e48b99-8e71-4f98-228e-08db29b5bea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IB1uBIr1Zuip5GmoKO3HgbY0yBA97pNcCCeuEcvLSnPI49C01fns86/x8CxmtlGLyub8F52Mu3kHg93u0Y/FbVb3Hl1pZLD4ZZ0NDOpV6mpTz7Gy0/Ykg82yotM2dr+DPfQVq+Y91yYoj5l8n0tAShu+HLZPDMGRpgUbtX/J3ZgDtqx9NSDyXvwvgVq6bcUaHREmWdxphwawGbXedWiWcNe5EwR2E6dlD6S7MD4OzF/T4I8VKsHs/ICFVUMTiDVJk4ZCgIaL+n9tBvURDsWlO0KJPTktM7s+j1mNjCDL4GKnfTv51vNmkuvWKKq77LxLMv0Yl/Go4B0njA56EFvEf1BH1qZIr3P5WkpmKPeYx2RMa1rby+/eSk0+DfECavA/tu5KDY9K4OFIsKJxtEbnajk329RU6V3nvZXua6Cic7Jmtph6O7Nte19OcgZBBnMlaRi9tewq6BE3bq+EkBr5YAgh3L0ZoQAk+QgrPZ30P5gh10ZtcdVxefElJcES6ODprNJ0nww05bkrJhwWP2yYRmC7cVT8MS6qJSkCzqyeVzQWJDUNEYZKj2Xd3jq+CANfJfo0Ys5hWQp1MkEbAtb+YM1ZxF/lHQ/CdOy6x+AdgcGUOyKRL0+HdXDr232j92e7sMSA+aE6cj36Hj90MwmmWaTwZafJyiOejX3lq9Or8dvA8FTzydejPyf22EzZ415kgjpF/pivYdIRoH54ZK9Jqjriqz5mwyuK6UdZsx1rZ3bmpAtBRaqK3GpqZbVkYPf1v0bcDyc9/2DE4pND0ohR78i66S1mpeud5UhPfcBS4sE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199018)(46966006)(36840700001)(40470700004)(82310400005)(2616005)(426003)(47076005)(54906003)(83380400001)(86362001)(82740400003)(336012)(81166007)(40460700003)(356005)(36860700001)(8936002)(4326008)(8676002)(36756003)(6916009)(2906002)(70206006)(70586007)(41300700001)(40480700001)(4744005)(5660300002)(186003)(1076003)(26005)(16526019)(7696005)(478600001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 02:41:16.6926 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e48b99-8e71-4f98-228e-08db29b5bea3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4178
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, YiPeng
 Chai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reinit mes ip block during reset on SRIOV.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2ffbaa1a4ce2..d74d05802566 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3147,6 +3147,7 @@ static int amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device *adev)
 		AMD_IP_BLOCK_TYPE_DCE,
 		AMD_IP_BLOCK_TYPE_GFX,
 		AMD_IP_BLOCK_TYPE_SDMA,
+		AMD_IP_BLOCK_TYPE_MES,
 		AMD_IP_BLOCK_TYPE_UVD,
 		AMD_IP_BLOCK_TYPE_VCE,
 		AMD_IP_BLOCK_TYPE_VCN
-- 
2.34.1

