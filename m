Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B577C761A6
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:14:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67F0B10EC3E;
	Wed, 29 Mar 2023 20:14:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 954F710EC35
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:14:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1PAQ54uUOZg6bX1o6wCbmk+/yN9Rf9KHqqsHzU9PgrB2RGPLx/7WdtC5tqeU3IA4fS1gN1jfSuKiKh96gW8LQQYvMKBJ/u1avd6eLlnfWbaxlQGzjk4zeVHD5yzCPuBmp+oIepiMSqfFrn84Rq2klBW85GPZpAYNuFlHVootDEk+oXzpZ9wbwnYImItPv9zpT1LHTnkdp9JHZG0XRTi3xbJOWccRq7fJd7lY3cQJdahvwABGL+KjVV+DAB4mJedstJsq7qXrlO57ecC68p4PRQtEdVMvnuJ1p4xfH7DYBXTJHzpNZ18jQMVg/t/Z+z/aBI8cwuFdXAdScM2kLfWow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PYHJR9PI7tnJhgIYEeH1JW5b/iT8AjWOy3rtwgX/nE=;
 b=LkJqEohmWJB5iHYkrnQR24JIleIhNAHxq/aOACTWQtsGyMTATrwNAPVCW/NDXN9tg5vgPRIIxNq5pbYWRAyY3QKqOURCYBq6OeYTNTGtjQJWNUK667uE3Z76OH3IXgeI7gjKBs6SPKd/jA6y4PaDxgeDaRWVTmBQK4O9oNPTUQ2XIYX0pDv16eXuJJarZ1Stvntf9UmaaR5kDDEldRJ1Ud+MNnpVOLrPBEbkZcmH1jFWWblU8WJFqm4XEjjfL7DF4H2h1AYMjMom88AS5/vnJpZ74H+LI2zlJxaGJfHYhhH+Z0l7RCJVU14TtQysRMVMXJYfOWns411u8D+Yp22+OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PYHJR9PI7tnJhgIYEeH1JW5b/iT8AjWOy3rtwgX/nE=;
 b=4nkurwitSRzjruNyl9CEXv0nzcIU2kpyKP7Tt6WjI5bypGUsdV0JKXl8uRzaFstt8E9NqNhhwBGE1ZIN8go3tvJCFwjc9yY/i/ynypN+9eY2ilzKkXrIL+MUKLwCWPzAsvoMhYG9zDJbhvc255dY6NHB/WnTxZNXzHh+eDMm9o4=
Received: from MW2PR2101CA0025.namprd21.prod.outlook.com (2603:10b6:302:1::38)
 by BN9PR12MB5049.namprd12.prod.outlook.com (2603:10b6:408:132::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 20:14:48 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::f7) by MW2PR2101CA0025.outlook.office365.com
 (2603:10b6:302:1::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16 via Frontend
 Transport; Wed, 29 Mar 2023 20:14:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.20 via Frontend Transport; Wed, 29 Mar 2023 20:14:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:14:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/14] drm/amdgpu: accumulate the num_links in xgmi topology
 info for gfx9.4.3
Date: Wed, 29 Mar 2023 16:14:18 -0400
Message-ID: <20230329201426.1982669-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329201426.1982669-1-alexander.deucher@amd.com>
References: <20230329201426.1982669-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|BN9PR12MB5049:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b5d200-eea4-470f-510a-08db30923ed0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JEcH3VGz3mGiATq7i0E2IX//IqOJPXu6aFslXjWT0DR0odfsei9xHylhuPJmMaPCNDmvaEfVla5jOzXgj9WcWFnYmOK8dTjf1lpSLFuiBJhu3rotnUl5E9AAkw98w1ebC16lpp98mgLNEJ/nEE8ViZ2P3YZTVGrfbPIgPvHHBS6nwTuMhfynnN4e6afVUyj72vsUTHP51r75Nj/9/ZvHLXPNdd5ABrxPZA11104cd5iXpKCUrmCUGkyRLY3NdjIlQpJgmRUJcwMMnwOGI41hZ0A01/bqvAANI8HqC++L3CeSpAqqGYVDYnteQwX7C6hlXU+BiH/K+6oh/VUV37/QqZLOUp/ZUxIKG8uhsINSNFlo+2Pv7AwmBowX3sRP+EXKj55ycbfuU8GN3jLIEC8JEPBM/S8mEkHE7XVyEEE80KUyPCaqYFSUx2TlS8VG6+8vTw0DSjMYZY51y1Mus2NIOYBtk9sjCDpaPXirVxEhCx4EyA4adRgwnAVUNdN+8jgAS7ocT5vw5eifLosiuUO/+VHWfZNlwqhRSQY8tztmis+tdSW8DrYcapj87NtimAKWh///S0lBI85fDLmxGZNgv5sHAIB7ZspN6a/A/DtpjFtrWgQgO+eNqRFKWQ/QlaZEvkz9kCmRaoJUukDi+8krvOrJzujOjCCxz5Ps+ZhJaeoSPvHQj5D9OXft+vHbc/UrroDofGNGUhmw+4fJKnGVCPEWZzEmRfuKjF+2Y6YHtoM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(83380400001)(26005)(81166007)(82740400003)(6666004)(356005)(8676002)(478600001)(82310400005)(316002)(7696005)(54906003)(36756003)(70586007)(70206006)(1076003)(86362001)(40480700001)(4326008)(6916009)(41300700001)(47076005)(16526019)(8936002)(40460700003)(5660300002)(336012)(2906002)(2616005)(426003)(36860700001)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:14:47.8849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b5d200-eea4-470f-510a-08db30923ed0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5049
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Shiwu Zhang <shiwu.zhang@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shiwu Zhang <shiwu.zhang@amd.com>

Since extended data is not supported, num_links should
be accumulated to reflect the xgmi topology info.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 2dffbea1d72e..130a66f5ea8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1377,8 +1377,8 @@ int psp_xgmi_get_topology_info(struct psp_context *psp,
 
 		link_info_output = &xgmi_cmd->xgmi_out_message.get_link_info;
 		for (i = 0; i < topology->num_nodes; i++) {
-			/* accumulate num_links on extended data */
-			topology->nodes[i].num_links = get_extended_data ?
+			/* accumulate num_links both on extended data and GC 9.4.3 onwards */
+			topology->nodes[i].num_links = (requires_reflection || get_extended_data) ?
 					topology->nodes[i].num_links +
 							link_info_output->nodes[i].num_links :
 					link_info_output->nodes[i].num_links;
-- 
2.39.2

