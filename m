Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B82C77B60
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:10:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 948F410EC11;
	Wed, 29 Mar 2023 20:10:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5543510EC1C
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:10:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwkoeSovja/WxoV23zY/VasmuUI3/ZtxmfDVqc6IlAb2zl9yq5YhP9U3CSoeti0fAYlshcgkbT5WoBLQR3mg+3GzVuOSYF+zkY79LUeDPmhWzEBLpaEbf2/Gm7F9THaRe1zkzvZJGlvn1x4SzByKMEtmZMoYO4mjygq6HvF6ww1m+Olsu18zj5k+K9ejf79goeyb3JWh1lWIQc/O5QAzNqG1Z0Fs0Xfv2RiwJ6YrlDFdNMTOAdnaWnVLr+fq6iHXh0w0FkBUqCQ5hmP2RlVTivUTlhl+CGHourK/2y+VglCU+Irbb4Cq3tzrqDpSK6Ev+s3LnfFKKc8kp2kAAg+Rpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvhhjGmF9kp1apiS+WGR1jaKeGdbCNdKWWSaOH6HDJQ=;
 b=F9EV/S+QaFX5/ksZ+sfRJ+fpxpbffNfDATfom4WH0Mi+DmL+66vf7QOTd735jq0S5V9ej5aFBKps6HQGyCQVP78tl8PeX6EqcFofVAFctIt1L3yLW5F++GBRnXto/Xj8wXG3iDjoaiDmSVA16DR/wLTaw6mIXJm9iemTuxU2fL93KPs8H/b1ZAkdXeG9MsVJjKhqu+5Qc8q8vsCpq5C6Gu6i9hg9Vp6lijAVbVD3ssWIKCKhYGThFXENR+aY7mL+5+FqN9PjqgXwlKOnzUge3ikSJdK9hPWvVmJmR7usuVwF4Eygw6XmApbc1TdQQFujthuozPR6JxSQm+56c9+f5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvhhjGmF9kp1apiS+WGR1jaKeGdbCNdKWWSaOH6HDJQ=;
 b=0xUeflWGm/y+TGpgpRnZjMtkweUIBMha8YN88Ur/+qJRt7qz8gfRausy26uyfLcCdxXH6/1TTluhspRnBjE7QEJI3DIhdIymd1nXKSu5HPHxihCYBqsocN+07FKEDd1E5eBuZ3+KIQcH/nfyxUbbRLLpagJ/BEc3UyKW2JW1HAI=
Received: from DS7PR06CA0024.namprd06.prod.outlook.com (2603:10b6:8:2a::8) by
 BL1PR12MB5159.namprd12.prod.outlook.com (2603:10b6:208:318::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.35; Wed, 29 Mar 2023 20:09:58 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::a3) by DS7PR06CA0024.outlook.office365.com
 (2603:10b6:8:2a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:09:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 20:09:58 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:09:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/12] drm/amdgpu: Fix GRBM programming sequence
Date: Wed, 29 Mar 2023 16:09:29 -0400
Message-ID: <20230329200930.1982035-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329200930.1982035-1-alexander.deucher@amd.com>
References: <20230329200930.1982035-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|BL1PR12MB5159:EE_
X-MS-Office365-Filtering-Correlation-Id: 86970efb-6b9e-4fb3-eb3b-08db30919218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 94MwGfvXFGQochxrc90aFA+DY8cr99POMEM3A/2+LGNlni2jHg0jBVKUuGdZPYzIEKVG1pPS3JikPcLYMB1YH9ldbbgKGMTALqkOMHgxqwAdY4bbgPsFAJ82L4lHYBbZgxX23wz5DsmC/TuKDuZKeJd/w3XlVT3YsM5H7q30zUzjNPca13mvTQslKyQ2fXfk2YUUU1GWsQDRg3hrk6Zb9Ky7SI+zJMOPI/dXYl2i6Tp7TWEZvOsuC/DLMNA41OedTG1QgrasYiB25RbW16XEVgtXzTOrT+T835M3G4zai/h5t15MDCgn3EZC5LZIhj+23ZJury2u4CrASRVwckxh2E96VvcWtbqXqCPgzbxG2QSVsplsXP69vm9xhPEBJKFP9iMYfQ4reS3lVBsaWJkY5UHkufAIiMbuORW7GUc3xorlZAz+J7jnJFvIQhu5FvBu1wHlAr9cQjgU+XaD+rCVQM6GQICJTnxsKUQ73P+qE3OXJ2T8rqQlYcOSoX3YIrKVa+cqcSyQrU1Kz2KKvBWHam0bATTxKNQCdzq0WtQjuXCyiaLXh9wNkX96wsTpxpS+kZcaZgkgEj7aZMt36swOV8mI849oyLoA/+wavZIBZa8fsmfdAuRK0l3o1dGHzXAt2inlSqGqwte2WH8zeQhq1WCNLDDLqjJkbRD767X8W+cKjUNS95ITGHGw2rfWAGDfF9uxJU/ADfmMBwVAP4EcXmSVoIEqOcswXVfT2rRcrAY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199021)(36840700001)(40470700004)(46966006)(426003)(2616005)(336012)(186003)(47076005)(16526019)(26005)(83380400001)(6666004)(7696005)(478600001)(6916009)(70586007)(36860700001)(54906003)(1076003)(316002)(8676002)(81166007)(70206006)(4326008)(356005)(82740400003)(41300700001)(8936002)(2906002)(5660300002)(36756003)(82310400005)(86362001)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:09:58.1773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86970efb-6b9e-4fb3-eb3b-08db30919218
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5159
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

It needs to be done only for XCC instances in non-AID0. Use the physical
instance to determine non-AID0 XCC instances.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 589fc3e6197d..451a7e58375e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -191,11 +191,14 @@ static void gfx_v9_4_3_set_kiq_pm4_funcs(struct amdgpu_device *adev)
 
 static void gfx_v9_4_3_init_golden_registers(struct amdgpu_device *adev)
 {
-	int i, num_xcc;
+	int i, num_xcc, dev_inst;
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
-	for (i = 2; i < num_xcc; i++)
-		WREG32_SOC15(GC, GET_INST(GC, i), regGRBM_MCM_ADDR, 0x4);
+	for (i = 0; i < num_xcc; i++) {
+		dev_inst = GET_INST(GC, i);
+		if (dev_inst >= 2)
+			WREG32_SOC15(GC, dev_inst, regGRBM_MCM_ADDR, 0x4);
+	}
 }
 
 static void gfx_v9_4_3_write_data_to_reg(struct amdgpu_ring *ring, int eng_sel,
-- 
2.39.2

