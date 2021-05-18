Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76589C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 02:01:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C30B613BA
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 02:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C30B613BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CB6A6E598;
	Tue, 18 May 2021 02:01:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB8C96E598
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 02:01:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHqUkzDN+hfbCtjNTfYpz3TjFzDehLadtb9xL/bS78jLjmhnlW2bTCqXAyK3ovLd74wWJX6diGG++fbQUB9uMmkY0A/kJqGHsbD2+/4i7PWL1KjxpMCSZf2If2T0qEjtX5yC2xM4y2Nx4fWj2qDiGFs2OLAS6b79qr4zO2He9G791fHkmgSmHE5VNzuM1ah1lh8nTUYqIcoJsQkdR3317iGLDsGsUyLhkvIRNkyU0h3auEi/0t8zz2fpdOkfJr/F+4t90QDTx4sVCLLeIQLnxB9PFK4ZrnuIWHZqFP50VgWyoQmJ3rRJdEN359L/ADPpXBtw7jB7O70TxPvu6GH0dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrgY86dh+3rxEjKDwC81LDOpo0mmdr7e94fZALafZv0=;
 b=Vfau1IbM/AxklpZQNgY4f3g6YT7D/6fkXa34162JTE3UfS0PuGzlnuHTl/r4qIcalnM8FNNUlzSLnLsQklgrIXyIYeBxX9MYXz0CJvmEIIeBiXvx7WACEUJxUsBYawUq2L6Ur+yqamh6wPjlGNhx3xbwOXcNGzZ2FaDupptTdmVhGaZ21KYBzeStkEzD8ncOfwZDnpG6pEuxQxpiXzyfX+16gliFx86qjaBy5laFtFV5PIA5o/gJZ+EaW7StaX0eBAgiaCLfEYQojQwG+43S8oiXrUFhuUQHdmKQM/HQVPqtWBA+3XaE/WbVLJ0xAKn1KzkYn4grEjBXnEDLYwJAwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrgY86dh+3rxEjKDwC81LDOpo0mmdr7e94fZALafZv0=;
 b=PvhU/0LBmg2a1N2Sn+58w0lPykVH9jbwB39rLFP60nMtkaBJv4/QtzqlJqOkTBKn00XLArubl2n/bd48sZGSfZzaowgiQMkqy288XYZCaHERx0O/3Skds148xEOP1FhECs63UCCC5v/Xgi5Fp4ufLFkgD6HBVS9O+EyyA9tqLZs=
Received: from BN9PR03CA0737.namprd03.prod.outlook.com (2603:10b6:408:110::22)
 by BN9PR12MB5339.namprd12.prod.outlook.com (2603:10b6:408:104::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.27; Tue, 18 May
 2021 02:01:17 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::d8) by BN9PR03CA0737.outlook.office365.com
 (2603:10b6:408:110::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Tue, 18 May 2021 02:01:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Tue, 18 May 2021 02:01:16 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 17 May 2021 21:01:14 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Hawking.Zhang@amd.com>, <kenneth.feng@amd.com>, <jiansong.chen@amd.com>,
 <jack.xiao@amd.com>, <evan.quan@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: update gc golden setting for Navi12
Date: Tue, 18 May 2021 10:00:54 +0800
Message-ID: <20210518020055.2132-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4687d3dc-36be-4339-26d1-08d919a0d2b3
X-MS-TrafficTypeDiagnostic: BN9PR12MB5339:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5339D3897BA3081F414CC869F12C9@BN9PR12MB5339.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:176;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 29gZRQcd9oA4kVs0mkxk95IemnsIhZrOCs4zCkn6er7osZr0cu1qgA9Dq/InkECkPxoeI8pHlAp8f/jbyHBw+22uVbAfiKIemvD61UaDUSUZZ/ekgaYOeeqcUef4xCIlbWPRChjBDB+o8BwkrCDgSiFsCVVcG8aWKOezjarlET29+t+DRKqKC4vuqoFcFYVYIKW08tkem4wpO7+tAlrJfH5GzjW+CYejOw1ZuBaJ+gz5kmg1oI/I7gCuEsRRfMjWc03zIHuQY4qqfkMJEFtqpwRfcVHrutc90qax3ci7jx3bSf6DQC4VB67NkiITRC2EEW205MuIyKht3v3YGBG5CdIZLp3sywwPiFxljUN7wWZp6zkCiJm4NcnPS0q7byUbKUNOocBnJ0L1VbmJARSRfwr0eLOvSq42CXZZIV6CzeeWDiL6gv19WCxR+1bLVzyxk6VTup+5W64I4uyKMuqxLn/0PKbwAs7HE7q1ChupIvThx7JzBYG6ia3Qbr/y3RFoNEIEp1YoVAi6xLL0LXiylo1PUWO6+qfDn47WCcjyWNx+TXAz+UMWPzIsN1vkJkhMkq9KTmCVtRa2Bcj8XENmfomJ0H0Bwa2I20b85vzc+ePjsMhkEeUfG/SGsnZ35xVyvaSjeFrdZY3APs2Z5/UTof0HXxxiAzEcZ6dbg+TbAYi9yPDrUSl3XDIzNMRBbsed3sYDymFswzFjuyXE59+kJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(36840700001)(46966006)(26005)(47076005)(36860700001)(316002)(8676002)(36756003)(356005)(5660300002)(478600001)(110136005)(1076003)(44832011)(70586007)(336012)(81166007)(16526019)(186003)(6636002)(2616005)(6666004)(86362001)(8936002)(70206006)(83380400001)(2906002)(4326008)(426003)(7696005)(82310400003)(82740400003)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 02:01:16.9624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4687d3dc-36be-4339-26d1-08d919a0d2b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5339
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Current golden setting is out of date.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 2a3427e5020f..7edd0c0eed8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -1399,9 +1399,10 @@ static const struct soc15_reg_golden golden_settings_gc_10_1_2[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG, 0xffffffff, 0x20000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG2, 0xffffffff, 0x00000420),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff, 0x00000200),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x04800000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x04900000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DFSM_TILES_IN_FLIGHT, 0x0000ffff, 0x0000003f),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_LAST_OF_BURST_CONFIG, 0xffffffff, 0x03860204),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGB_ADDR_CONFIG, 0x0c1800ff, 0x00000044),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL, 0x1ff0ffff, 0x00000500),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGE_PRIV_CONTROL, 0x00007fff, 0x000001fe),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL1_PIPE_STEER, 0xffffffff, 0xe4e4e4e4),
@@ -1419,12 +1420,13 @@ static const struct soc15_reg_golden golden_settings_gc_10_1_2[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE_2, 0x00000820, 0x00000820),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_LINE_STIPPLE_STATE, 0x0000ff0f, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmRMI_SPARE, 0xffffffff, 0xffff3101),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_CONFIG_CNTL_1, 0x001f0000, 0x00070104),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_ALU_CLK_CTRL, 0xffffffff, 0xffffffff),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_ARB_CONFIG, 0x00000133, 0x00000130),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_LDS_CLK_CTRL, 0xffffffff, 0xffffffff),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0xfff7ffff, 0x01030000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTCP_CNTL, 0xffdf80ff, 0x479c0010),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x00800000)
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x00c00000)
 };
 
 static bool gfx_v10_is_rlcg_rw(struct amdgpu_device *adev, u32 offset, uint32_t *flag, bool write)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
