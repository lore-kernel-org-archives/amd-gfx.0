Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD8FC38142
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Jan 2023 18:13:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55C8B10E36D;
	Tue, 31 Jan 2023 18:13:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96AD210E2CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Jan 2023 18:13:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QERPG2wtnGeib95H3d9+OhxSoK7/8lIF7NWF/pu28K69AbhtS4zysHdRHhiTQOPBDCXGN6Tj5LXGch5+Sk+AVulGVUHWg35LwW04xQMXApCyQO8XEHmnQQvLVOnOrEICEkpR3+Si0KciqO6gnO9zAWVl/7HR+rICJc9I2bdYOuoqjkdWmsIJbRR7jdDfsWmoQYFA8n1amStr/WiH49fz2Ib1PLdFlIZYPHgQUbmi4J7oOixtmTm5SwCLrwO0gaR0eSM1jKZX7GoRGAR5VCqIGtSSrfSEfymOiQjzJfByXU8M/dJrOMg5Cai4GyWCivEpxBkjVZOYtsEpt2ypBScxQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbsYPrEsqTgy+h3sx1BoKZ9JtRc3lDJgbzkcJ4m7va8=;
 b=D64DO9TWpJrb8gj6xEK3HHkisJ4Kd1DyimIEC91QhnKgyjgPQ4O2yxdBMsv1hmfQ5zO0wevIDW+sgSRiHNuXhbY2imW0fMyxKuDchWPfZcR96fAPLQ2c6U5QciKLhg39vs5iwdLTrTe4jbrEl/cZ+B5nFnWClxVYFmMXRpv3F8FsuscuUBDkpxE34hMZtOqNud8O5TDaJSIiP3/U+jriNIIB2vnX3iknZSAsxYiy6uD9SFTGLSupYgpn2sEUNdttJsbiyGPsRqg0zIhR87FePL7eXg31Pau2JAz5Bg2ELYUmNKEIkK7zvnMOcydmS7zUe1bz71r/SP8D1ewH1/MHpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbsYPrEsqTgy+h3sx1BoKZ9JtRc3lDJgbzkcJ4m7va8=;
 b=a/SNflFFqAtu/emsnJD5JjbuivdHe6/cLixMQEAGPnbAVC2mRSPLW7cduMVZLUbiuW0JgdUbrFXGeO8JZhBVtCnWCaWHcDhOrN1WKZR/AlrgPm6iU8kKHBj4P2dna7mZ6pEX2tuSi0E+LhFMcbSchYgTpDwxtjSznhEdBs7rm7w=
Received: from MW4PR03CA0135.namprd03.prod.outlook.com (2603:10b6:303:8c::20)
 by DS7PR12MB5861.namprd12.prod.outlook.com (2603:10b6:8:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 18:13:44 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::65) by MW4PR03CA0135.outlook.office365.com
 (2603:10b6:303:8c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Tue, 31 Jan 2023 18:13:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.22 via Frontend Transport; Tue, 31 Jan 2023 18:13:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 12:13:42 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amd/display: disable S/G display on DCN 2.1.0
Date: Tue, 31 Jan 2023 13:13:22 -0500
Message-ID: <20230131181326.3507396-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT034:EE_|DS7PR12MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: a1e3985b-c903-4b6b-bcc4-08db03b6e38c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tN0G/1HsChGwWtszEBjlkLSfXGskIRGdU7nYhFQ80WVTDilSHRB3g1lJvqirtHI3Fd0rlfZCLOnxMvad9PLyjnmy9RvRYEGyTvCTe4O9GD/a+780TABO+ZCZQ8rt/dLqoKaG6dTwYLnhSRBBXM09R447T2P1Vw5I8XgHGwp4nbyh5Xtn8vxEQz33JpZ3Mm2Hd74GlbCU/nN2z0QpsyVDOvaSsiFbNIns3ULFLIdd+nnfgffVrB+4EA4JgETFKQEhY9HLD4DkxXExddgVAvqRJ3UuVJ4hJ2zJ4uOx6zkMPvDL2K+lhNfYbjTHvP5cddqeMCtmdU8aqY78LnUF+THm7VKphG7z8TsDHr35DN1smnmnB7kEu8dpNTEyq5Q2j4gob/srvgdTvVOn2wtFisI3t0K8XyKqt/iU/M5XFDwj417t3VYOKXlFSVJcy3V8ZwPwxacusKwhfh/8cjTRLiqRaIVsRbQ4PXFatQ1FO3ixw8X0E2NO84OvOpRRWkqgh0oqEOZznLKGNxlWY8hK6UWT5QAsoSlpYwZcdvs0rtqNIuTRX9s1Y4rxcLtB67xhFsM3um1a+XeA7IUR0N4EbLOa+HB+7VydxruPlZUU5MU5OksRWLp1V8NYyE9CtMm/sNLHswKG/xSfZd73s+kjbKN8KBT8lNN1Dzra9uJ2ruiz70KLNpp2JvsjKp0uKPJY5Be+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199018)(46966006)(40470700004)(36840700001)(5660300002)(54906003)(41300700001)(316002)(70586007)(2906002)(7696005)(8936002)(966005)(70206006)(6666004)(4326008)(186003)(16526019)(478600001)(1076003)(26005)(47076005)(336012)(6916009)(2616005)(8676002)(426003)(40480700001)(81166007)(83380400001)(36756003)(82310400005)(4744005)(356005)(40460700003)(86362001)(36860700001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 18:13:43.8233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e3985b-c903-4b6b-bcc4-08db03b6e38c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5861
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
Cc: Alex Deucher <alexander.deucher@amd.com>, yifan1.zhang@amd.com,
 roman.li@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Causes flickering or white screens in some configurations.
Disable it for now until we can fix the issue.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2352
Cc: roman.li@amd.com
Cc: yifan1.zhang@amd.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3a40c6dec3d2..2e4040f1a357 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1534,7 +1534,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 			    (adev->apu_flags & AMD_APU_IS_PICASSO))
 				init_data.flags.gpu_vm_support = true;
 			break;
-		case IP_VERSION(2, 1, 0):
 		case IP_VERSION(3, 0, 1):
 		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 1, 3):
-- 
2.39.1

