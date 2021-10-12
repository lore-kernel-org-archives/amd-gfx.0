Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C11AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 02:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 535E760EE5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 02:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 535E760EE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C77D289D79;
	Tue, 12 Oct 2021 02:34:01 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D00489D79
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 02:34:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7684VCGg36aFCZOA4b7GUl1eW6eA4fpDiJw1QbK4jDHbKmsiarMg2fN/e0adwDsSd0Cv8/aAl3bafSimUacmRQowGbALf2VWlfyoh1CjaPHigCUZHPyVzx7LAhDpsvklYfE2Pht6m9IxZlCx4BPbBp5eD0jV8/pZPkKvti/pdWWC+faea31VVndQervApz4EUR0nKxUfk4soCu35Jlef7Xz7f3Mm4vOE6EQtSHl+3dPj07BPt7cE8N79P2gh+G3YPnOdIJl413Q4AS7tD8fnqfYJmRhsX0+h7GksWAdFRCIB3Jw+T7cv0Dr+aS2d7SrAaRHPl0liDnvWpE8yfwWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jk06s8Nv2Bd+zqO9i7ed+s31SGP0RWvVCd6Nf8C8e2g=;
 b=jGyFECewQ2rpnZLX/WsNgjDOe4Ib76PxJYDjUK5W5HpbpkGfVOpPT6sLdBzs8K/Jw3AqmQnhbOt5C5YZOPhPft27AO8Qcve0XXNR7C5OV8/wxlVObE84oLw0y5lHYqxm1SjApv9OljRs16ozwXgIIRBaNB9kzT798DIyfny9woZmgQCHM76Cas9PC36MQU/BErQTzt/+nDkTZyLGEiY8OnAypVJQjWrZjFWDpI0e+8nPYty4ps95kI+OF1S2dvSVomj24zOWgN4DcRibdODeeVWiBZuLg1Ye3e/EyVK1hSSLWLnIwe3oCMD34EQRLfRGH1uJDyy0WcinIzJOw8Pl9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jk06s8Nv2Bd+zqO9i7ed+s31SGP0RWvVCd6Nf8C8e2g=;
 b=YeBcuSZ1+VJ1a2u2qeOESSkqrVAJyCYAPOUXTelyufY3yFvpL4Ko3KFX6G4AQpCycDXZ+CugC79OCt0TVOJMjsHB1hv80MAXaGDn18gN9JywiGZCT00GfLOZd7absiFlrm+fZ0uRtHm7h28IDv0J+coSvny+hICjyzGB7s3DfJk=
Received: from DM3PR08CA0024.namprd08.prod.outlook.com (2603:10b6:0:52::34) by
 SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.19; Tue, 12 Oct 2021 02:33:56 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::d1) by DM3PR08CA0024.outlook.office365.com
 (2603:10b6:0:52::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19 via Frontend
 Transport; Tue, 12 Oct 2021 02:33:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Tue, 12 Oct 2021 02:33:55 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 21:33:54 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <john.clements@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Enable RAS error injection after mode2 reset
 on Aldebaran
Date: Mon, 11 Oct 2021 22:33:42 -0400
Message-ID: <20211012023343.23935-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 283d585e-d5d9-45bf-5aad-08d98d28bcf3
X-MS-TrafficTypeDiagnostic: SA0PR12MB4510:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4510C22F6AC37AA487B81989EEB69@SA0PR12MB4510.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:529;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9vcJ9Vl7fuXoTSMt9k0q1n5w4f8dQbdZsNKDncCxVOi/SsMDH302K934UoCyW4F7Lh51MFTl7kB3Yu8gkVVkoNbCctVxPrLw2nagNRVen0K3gu487btIIKfAh1kZbhZX9+crDS7LvcxNH0DdQHUh6mvmOBxEsr/QlfRNugPY1TrL8kl0U2+FioBQ6E1wC0eYu78wo5BT0iu7pvCpf4eAXG0E/ENsiQu7vgcNcEFSWRB6GcByT2uX3Ei7/gR5dacAYjSe/D+bk6mGuABtDO8y/ZsTnLAPkGgR9b5CVp6132yxrmYHWbt+vYzdPr3zyBSC3ouBz9VOMVJsx1ctmwwRepIB+REiuia+Gp5CMOC1YGIh/hs6VBwvn2sGLgQhACofHcUrtQonMdcRW/DsrufFsduPEJsFdE3BQHjB8yuSSuJcNnVa7tyvWATcg6tMOoJ6Okkd457761mZKrGd9g2Eg33QcUY2V4cRYrDb/2kqjUzJyghLqKYhjMjzMoB1AkClkGwFFYAoQpeR9woEjczjOOyfchmZGZJxYQ7A38+82zT1yY7cvA7eDHnuNlxcXwlVtjgws3x6vrbAy5k124jadnsydEUB39MQLGPMHAvqfbjGra3oXa65niYra2otuUUsgilmAW1ElqnCttTOTqvrmtulWjJUS/g5ExYqZRBA2v7vKNaci0mPNyZW8xJVhz6VYWJH9GsK9x3uRdGemkWQpPcQ++tiNq+QrYE0LO3pXIE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36860700001)(81166007)(47076005)(54906003)(508600001)(356005)(86362001)(316002)(4326008)(5660300002)(26005)(7696005)(6916009)(44832011)(83380400001)(16526019)(8936002)(426003)(6666004)(336012)(70586007)(82310400003)(1076003)(2616005)(70206006)(2906002)(186003)(8676002)(4744005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 02:33:55.7039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 283d585e-d5d9-45bf-5aad-08d98d28bcf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4510
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

Add the missing call to re-enable RAS error injections on the Aldebaran
mode2 reset code path.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index 148f6c3343ab..bcfdb63b1d42 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -307,6 +307,8 @@ static int aldebaran_mode2_restore_ip(struct amdgpu_device *adev)
 		adev->ip_blocks[i].status.late_initialized = true;
 	}
 
+	amdgpu_ras_set_error_query_ready(adev, true);
+
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
 
-- 
2.33.0

