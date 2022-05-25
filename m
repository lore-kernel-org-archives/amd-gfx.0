Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB897C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 03:26:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D32A112081;
	Wed, 25 May 2022 03:26:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FA92112078
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 03:26:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTpPGvZ6SiOjywZVuJiu/qYxkE+MAQTs7YPDW1a9lY199CqtnJKSAVKHPQS+yCiNaHsCaeTAC479IESeaxQtsd8owJlL0+O9Se9kxdWx/4e0ykL9uUMgB8vBb10NEzQG0I1I9W0c/TG9l9Vza60Xxo3RabNKc4g8Sik8j/jjzKgjq0m4t/2sgg4uVHKfM5GdT+7iUoPhMtma0FaDV2qjjvUDt7T+K4MnJrkvldrwSS80XfnvIwEh9Ym9uPOuqdSfZsvGmEl0fQ5SOHe2ek3qVectXy9s1Lx2ZrwFOrnp0puMserFWWjFqGT1MscXGFDjgYbO0liMVTfrtH4HV9lVgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9Iai2lRZcJqhjj8aG3ROlVc4XJ13ph0qA8+hoHRcwQ=;
 b=mjKS9XRImLJMwc0UHTWddPOQhLyoryctiW5MwmbgmPn0GFV/F8xOJoWlKWBXMBrkzvm6vNL6mYCELg4ijQXQN+jp3CBScDUC9V9yAmx+aMYBbk6fPq2KeBhS/8Ghk1NQwIthC8RVSoUtHTkES7X7ciSPyTE0nHG2HKkw3AHiNz5VWowSrzXyzXo0KR09ZWR5yiR9zoX+xJGHRqGiZ4HBWqV7V5FvgM409e5AIbSOVRvF6Dsfz5DfoqjTZzGY1eKS4xddgS8FfVbT/MLS2Ikhkd7E7mZ1sYx6513TO2Cr2m26dAKbPr8lJef26JXJLUMKT7MbTGIG48mQ/vKAitlJnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9Iai2lRZcJqhjj8aG3ROlVc4XJ13ph0qA8+hoHRcwQ=;
 b=tuRVVSdV1Vukj5Qp/anwBTqdUIU5mlJKg7LNFK6XN1n8VvZn/GouN+vns26SsBAjEc4OxoV+9Vz96MiJvzSPgqDCR1ExDV74UH14fA3mJU9XrUfwxBApZz4U7gy88YgyWH8cwe+kKhdqUNWq6/pkb4BDj3QaRJiUS7FPPAz1i5g=
Received: from BN0PR03CA0001.namprd03.prod.outlook.com (2603:10b6:408:e6::6)
 by DM5PR1201MB0251.namprd12.prod.outlook.com (2603:10b6:4:55::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Wed, 25 May
 2022 03:26:20 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::3d) by BN0PR03CA0001.outlook.office365.com
 (2603:10b6:408:e6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 03:26:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 03:26:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 24 May
 2022 22:26:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add beige goby PCI ID
Date: Tue, 24 May 2022 23:26:02 -0400
Message-ID: <20220525032602.2250343-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b04caf0-453b-4a9d-dfc7-08da3dfe5644
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0251:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB025124C5DBE0CA687618793BF7D69@DM5PR1201MB0251.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZ69RilSNfijuhGTxDj3DueShDSe2YCU/LhZRGZDkKUWjgeCNhb/6sG++iCOvsLAsjaKv1SITnM+jGak75VaeacC90lX9UztZDGAoYtojgukoa755zl9+Sbd1kr7vC7vMp+A8EI5fjJi4nfi7bmygdLzqxJxmcDUiIcre9sdQHX9lBNOC/mUnyCwcXtKCjBtrdvsc1Qy/lVT592zceAi/IPfMbQbp9T7LZlWkk+GM6L176VgrODLde8OsOafCYuEvYsSDh3cqkzI7ESS0FY3Xgt+wnecMZJnUVQvI/YRMYjzHe8eCHqP7gFHPcB+a4WFJXzfri6ONbp6T1DhYbW7ojRPI8f98jFF7pbGyi+tqhGX5pD6C/P6G1w5CQbzvUwdKDkWNVKamWW7xmGsKi7zkeAfQb2vdvJdcAA5M7k5Awlts21Uk1UazJ+O0YjFIk6FL16x0+swlvhSlmyMpX9CtTpaKsCUQw0NGYo6D0MUIpL4omAVlbVp323zbhy0Ti9jI1EzFvVOYBWcgPCJW9e5purljVWWgP7zGfk28MbrJwT95DVhqSHeMNcDFgNHg3hJAut/9w9/1wEkt0tTZVvdAwnlpqQwynCpOmOD53ZITDrOGi6agDMs4c7Lsf5Y1LqHTYuIELlc8NZVO10SmnCvUzCKzWztQvgt6JAT0NTuJjKQLH1D8uDlje96zbdtFO9PIT1f8eClUOPaHUjwhQwhEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(40460700003)(7696005)(6666004)(4744005)(356005)(81166007)(26005)(508600001)(6916009)(316002)(36756003)(36860700001)(186003)(2616005)(1076003)(16526019)(82310400005)(426003)(86362001)(336012)(47076005)(5660300002)(2906002)(70586007)(70206006)(4326008)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 03:26:20.3907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b04caf0-453b-4a9d-dfc7-08da3dfe5644
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0251
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a beige goby PCI ID.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 0bc6b2369e65..02731e28f18d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1942,6 +1942,7 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x7421, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BEIGE_GOBY},
 	{0x1002, 0x7422, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BEIGE_GOBY},
 	{0x1002, 0x7423, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BEIGE_GOBY},
+	{0x1002, 0x7424, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BEIGE_GOBY},
 	{0x1002, 0x743F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BEIGE_GOBY},
 
 	{ PCI_DEVICE(0x1002, PCI_ANY_ID),
-- 
2.35.3

