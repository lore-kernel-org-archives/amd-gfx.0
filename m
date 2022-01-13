Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDBFC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 07:45:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E9C410E6EC;
	Thu, 13 Jan 2022 07:45:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EAA610E718
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 07:45:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niJmFIDVDYTW9X8WvyPMFPOYMpEklE2Ylruy39yi1Sy7cy2BBnZQnkUQLK0aLwoy/w84Jh34K5Cd+80YVRklBTNMy8JSLYKqM+JFYsVId9TYKO5viq76eySKh1HfWBUe3M9UI9isXpKG7yolruepEwLu1jMFwq3+qlR0EPIF1kh88zFxVWyBeDoIjWUW1kriufMShAJHCetcUuceCXIz0ywArXVvn+I3UUwpaTazMyFktuTrA5W4IHFUCsEvmNDM/O0ZCulHnS5spZGIhNIwDpPhJhW0V7HcHkWntLjm2IDcYMSdRnWb2gaz0hFiUG8ysWgvzVKkEAdT8gIe1l1HcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65AjSfpiM/m752FD9OWDRm3L9IK5v8epUKQRgXGXh18=;
 b=O5lmXXOazzYGkrUYrAfnoObVcomEaMJb+I+dVSVvC9FcGFTGgvChptYdM4c4mTkuIoid5lnjwNEU4uVhP3Ac0WbxBLui4zO7D9lPZtNYZCclgh+vynMK94kmoFjxPQ00CAmBvgyFa4A3Y918lAukLVx3/P8qygozDoMJka3bvdso6Au897j9OvzYcErMW7MVbCgg5ecABdnJbLQNVV1HbYG9oY9C0DTHWeEshyZkS/wBOgbofpyax4pPPcA1guILF8QisSqIyJndRKd4zsO2aydfkSntqLk2l3/osHVvcV1Gy7FXTFfaZp2D/p6hlFYHZNt3XzWCSGlRtwOTpabdzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65AjSfpiM/m752FD9OWDRm3L9IK5v8epUKQRgXGXh18=;
 b=dCbUYcoy/EGhTx47oUqm/POc7R10m4cvOcDgvTGg038up7JPWe9WNxx0O3huXlV5F4iGdavT3GZiKNUVZqsQukhTbKylyeTgTDuHZD2/bk8YplPqisX3r9TwSKN59uOaTJbJSmbjqRz3uan4UO0of9dFEfZo0vNfS4w7E5HAOuc=
Received: from BN9PR03CA0909.namprd03.prod.outlook.com (2603:10b6:408:107::14)
 by DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Thu, 13 Jan
 2022 07:45:43 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::84) by BN9PR03CA0909.outlook.office365.com
 (2603:10b6:408:107::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Thu, 13 Jan 2022 07:45:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Thu, 13 Jan 2022 07:45:42 +0000
Received: from jenkins-MyrtleD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 01:45:41 -0600
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/admgpu: add data struct for vram check
Date: Thu, 13 Jan 2022 15:45:25 +0800
Message-ID: <20220113074526.29827-1-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 981df48d-2d08-47c3-c1b0-08d9d668b3ad
X-MS-TrafficTypeDiagnostic: DM6PR12MB4106:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB410603C481F9473445791C7FF1539@DM6PR12MB4106.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ej2ZOQ6O/tDMnMah0M1fS1NJeP4u9ALHjyMxKn68AQWVoJDWWAIed5BC9r9APg21YbDVz6pDk6AzeLV43lqRDRA6FkUunHv684pO0dW//oLISY7ZfRyj+dNJO1sHj44nSTejICpnGpItl8+g7h4HoW6WgbJFtE6VOLSQEJfddxA3FuTQFyJlhI3BQXHtoIMTM+rUyxgcVmAQGquIE7/a7bFvt7C22Afogboo4Zdk1mY6fQ15pPpY8NkK4Qbnsh50LzNF8OXfjZUc738bhhhcxn5c8Aprg4vwpmJYzwdwuRDSEnH3OGwZ0lgJuFTq+vJ+Rpu+vDDvb0JqDlRTAj09EstBbFeRVWrFRPQ3d+D/DXap0AYECo8N59oJ6DsLigfD6sXe2yci6hLywTY7ziLCbesosY6bCFSbRdlNk9/LDrpBYIa/nCPGVjDpoyf5jOCdiO0uzMGhvUBdbB5VR3bPUZ3skOAOUDFX64lkjHcIepddFeI2It1dVpHXRBaf/rI0vtXbEz/hxLs6HFdaAAbv4ecdfHTIgSNFYkMwF0E2TvHh5llhsI9g+0bsVUwVHkgS+l/VwBOVMoyD5yKVgt3KuXX2NuGkvrSvXCKF4GRDoaZgcv5NC5t9VOAe8tZ1G2vWZLRwlSuA2BPi3ma8SidqUpReu8w2ZUEw4OdJ2s/9RosBJyzRUyl2DH01BSZq4zAeK9mEHt4PRuUkOEKykI1uWW3L34TzlyHZWC+HPjrQFrE+hy56W/PYiACRXSmFgCVkXWEZWrhQ8n5Nr56vN47Dduopyj6sfUO/nyW0YUQ87+A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(1076003)(508600001)(8676002)(2616005)(81166007)(47076005)(82310400004)(6916009)(4326008)(356005)(40460700001)(7696005)(54906003)(8936002)(16526019)(36756003)(36860700001)(70586007)(70206006)(2906002)(6666004)(5660300002)(336012)(86362001)(186003)(4744005)(426003)(26005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 07:45:42.8775 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 981df48d-2d08-47c3-c1b0-08d9d668b3ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106
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
Cc: Alexander.Deucher@amd.com, ray.huang@amd.com,
 Xiaojian Du <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to add data struct for vram check.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 64cd80d050eb..13196e50a98a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -928,6 +928,11 @@ struct amdgpu_device {
 	uint32_t			bios_scratch_reg_offset;
 	uint32_t			bios_scratch[AMDGPU_BIOS_NUM_SCRATCH];
 
+	/* vram check */
+	struct amdgpu_bo                *vram_bo;
+	uint64_t                        vram_gpu;
+	void                            *vram_ptr;
+
 	/* Direct GMA */
 	struct amdgpu_direct_gma	direct_gma;
 	/* SSG */
-- 
2.25.1

