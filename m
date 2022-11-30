Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D4EC4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Nov 2022 00:44:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3768B10E3F8;
	Wed, 30 Nov 2022 00:44:16 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E7EF10E3F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Nov 2022 00:44:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyrUIL3Nni7KTFGiK95wA6KSNgPUpVGLDmko+C6BN2GTAYl527cCdTy2RirKoAK7cAY3MDDFUWIPc4TLcLjFHtuYOOnuHQaKhm071Ie4KYmNf2UIDDVl3TqvVoLMFWOVpI38xgM7pUCzJPEq6QEFs+KPkUa/eqgdwWNGgv2YXYCfn7eypxdh+Taos8AykUh7Pnp+dFsWLBbUaFGCrSkt97x1w0gJ2sCMZtNU3ZS7jU/2kYyMpGkk9/VCLueGmQ11ft5X8qjtLT+/TMjlsaO+P0Ab7d5mJgoCa0OFMUc9aOvNngEWVc6EQARBPyZxLNCYQNwGdczGoTQRz8Y5l0ULHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qB1gWFX6RU6G78C1ZXkgIhZxVTP5uzPDfifT4lzgTXU=;
 b=g5e7Hwe/Ber6r5cfWqADGpvnM8soMuEk0z4fSNKWVFhhehh2Qb3VBm31qdMvaYfEVIfXqpywW9E01jI34peHxWDeCnxdSRhuBhSUfaMQEhRp0b29DgDMRilr5+3d3XW+bBAZeBG1Gg+U9ANvgy6XrBQl+d2v/5RKtLiJWj8MZJhxS4Wxyg5oZujDL58DcHgMTfm73TG/NLPqw18QDuSuv3+L5GH6ByQ3L9Uo8sU+oziZ3Q0f3U87eRbTtNwz1S1FGT4qguYBzJvWUVsSYmCUjEuAJIh/6sUOCJUU5jyf00WJueSesfQaNwn4cmgbzavLJGSsenxFPalt9LczSdiVbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qB1gWFX6RU6G78C1ZXkgIhZxVTP5uzPDfifT4lzgTXU=;
 b=WniU96ugC+lAn3ILQ7Fc4uGbX3BJ1ulz5krO3FFoh2/V7I3wa1nKjZufV67hairuznVpPShTjYWY9Z3lrHcFMzHHelzkuZJluN9d3F25heMm5ZTKq1HBFXpiJQAc/uH8dqvdXZ82leXqVP0F4/dQmyBUN6pDXLrLoU8GCPvfquc=
Received: from BN9PR03CA0511.namprd03.prod.outlook.com (2603:10b6:408:131::6)
 by BL1PR12MB5078.namprd12.prod.outlook.com (2603:10b6:208:313::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 00:44:11 +0000
Received: from BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::76) by BN9PR03CA0511.outlook.office365.com
 (2603:10b6:408:131::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Wed, 30 Nov 2022 00:44:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT095.mail.protection.outlook.com (10.13.176.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.17 via Frontend Transport; Wed, 30 Nov 2022 00:44:10 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 29 Nov
 2022 18:44:09 -0600
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/amdgpu: update mes11 api def
Date: Wed, 30 Nov 2022 08:43:52 +0800
Message-ID: <20221130004353.58323-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT095:EE_|BL1PR12MB5078:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ac8614-edb5-4bdf-457e-08dad26bff16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hWRrcANFPABDjzZIWbGvJIakjwXwYTLo9bK0LXSN/5z1oJIEEuAGw4YSEQZ9lpK36ng9K/I99VYsD4G5g95ygXyMiXac7gNlSFyvDctsAXe8iQbQl2Cn7GHl3uH/HK0bQsTvzJ8ohsmHXSBsri/ZRP4W7FUF+ql0sCmY8z4ofZCJCv4STgHdeHSkTrLbuvoDHtvtZ8BdmS3XoGcJT4oaok9WR2zIGxdn9x8Gqtkg0DaBFyh473jOp4ZkzmbMBik/W7DGq4qfdCysLR+U7khlD7jTPbQz/ybno+S+NXaOC76/8YhOzkbPCLk/MSGOIlk3RiXqQan2C1e2n8CPeaUofqU4pTPYlkmsphr5I9sqOI/ltQnKBCHc7cFEaCCUuqH62utreNycl6rnaPdqPq0JwgmeJXTiFDSw3EZx82NNDCUJW+KZ5lQAfZv2FOSVtFi3KH1YB70UE3BPwmi2g6m3+j0g4ZqILPT6q5kB3TP5NEM9zUh2pyvb1gk3tX6Lneg5kICqJw/+3Uv3bJB3IviGqG//8svUIByUtbZr4hjIGaKlwh1kf1mSjFvnPLzAhwXzWC01l/UY6PmyZLFaFRdT90YNoX9AOYTDh5SYk0mP9fGB5RTNI1F9Tx25io32iQfEFARak+XfCDlbB2rlPSteubnEBIYOo04wsYhV4iX7iZRxgjlTV19gaD6j+C/Gm7rwBCbgZTjpUQqwFlViuMsA4mgACSiGgskPLD3jNacD/xE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(356005)(81166007)(36756003)(6916009)(40480700001)(86362001)(82310400005)(7696005)(6666004)(70206006)(478600001)(4744005)(5660300002)(70586007)(2906002)(316002)(15650500001)(41300700001)(4326008)(8936002)(8676002)(26005)(82740400003)(1076003)(36860700001)(16526019)(40460700003)(2616005)(186003)(426003)(336012)(47076005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 00:44:10.8861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ac8614-edb5-4bdf-457e-08dad26bff16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5078
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
Cc: Jack Xiao <Jack.Xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update the api def of mes11.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index 7e85cdc5bd34..dc694cb246d9 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -222,7 +222,11 @@ union MESAPI_SET_HW_RESOURCES {
 				uint32_t apply_grbm_remote_register_dummy_read_wa : 1;
 				uint32_t second_gfx_pipe_enabled : 1;
 				uint32_t enable_level_process_quantum_check : 1;
-				uint32_t reserved	: 25;
+				uint32_t legacy_sch_mode : 1;
+				uint32_t disable_add_queue_wptr_mc_addr : 1;
+				uint32_t enable_mes_event_int_logging : 1;
+				uint32_t enable_reg_active_poll : 1;
+				uint32_t reserved	: 21;
 			};
 			uint32_t	uint32_t_all;
 		};
-- 
2.37.3

