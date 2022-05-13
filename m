Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704D3C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 21:17:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E79B210E4B1;
	Fri, 13 May 2022 21:17:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB9ED10E4A7
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 21:17:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFUIsOFygQWpCODCireU5UWygkU7YEG2AC/xX7LpZj98T7BWsskLp6QrWOS+K5+ab925cxYZLdW4e4SvtgKcaDgUAqnrKl35afZWtsUNizQP0flZdezvRFfauVnBlhPLn9QEyzX2C1mMd9hb5RqF8seUAyRsUKgc0hmBLD/suYNTobY/gVSZXvXQUyU9ueJP7NDgc/bnEGyjnrv5aLQQ7gOFRZAj5kuq+NDYnR0K5eP/q6XarIeYCtQ/8dGTSTI/yLd56k2AAPb3A75aKVeuhqsBYiGaaXNB1mhlVH4TbHLg00MKbp8XXCJKkJRyar1A6peNVVngfDvApVXY3aISoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/rt+GE6ZZJxljW7CSUoLUQt8cRb4Yadk8yqgT89kDg=;
 b=caBFJTH/EEoZfwQ8LH/uenQ/pC+AL7yIzDqH4PBV9wUd7ssN6+3xiOuMZnlP/ETpIeyPy6ZHY3zkHvTsMiY/C3zI0DsoyLmThp5PN7Pd+QQ0Vbv5C+pIOS4gqjYm7ZtB1NYYbY2MtUth5PPFJwGX7QQH7bL8ITfWIfip5dhfpFcijtn/d0E0EJP4ilqF4MSFuysvKzBbIc0W6cQG/J1Wogix9mxgWg4f24xStRrDiXlGKApAnlyH+lamd/pWBuptHK9METtKpVPGb5qopdfcHbIy19WouHVyjSpOoGPJEkxXb4hHCxNxeDb2dXklWk+AiLJmkaO0+upFMFdZoy8Yww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/rt+GE6ZZJxljW7CSUoLUQt8cRb4Yadk8yqgT89kDg=;
 b=g61878RDzNwZ1Gh64wWmfOOjJVUw7ByHtBn4J9EKqYbxf2fZYSf39V+o5wAEmJCZRnrS/pP4jdWcJZXoM9IFiBd/2No9ACRrO047j0ek6PDNSPmNOCH5vHhLj6fXlB5XQ1sYq1jExW/fbKOzsqUEIr/PVK1izcaLMPqYfOaAOyo=
Received: from MW4PR04CA0326.namprd04.prod.outlook.com (2603:10b6:303:82::31)
 by SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 21:17:16 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::c6) by MW4PR04CA0326.outlook.office365.com
 (2603:10b6:303:82::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14 via Frontend
 Transport; Fri, 13 May 2022 21:17:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 21:17:16 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 13 May
 2022 16:17:14 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 00/11] DC Patches May 16, 2022
Date: Fri, 13 May 2022 17:16:40 -0400
Message-ID: <20220513211651.1312846-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87a61c68-e0f5-4480-df4b-08da3525f4dc
X-MS-TrafficTypeDiagnostic: SN6PR12MB2718:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB27186AA8612026F2A1EE2848FBCA9@SN6PR12MB2718.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FwGyvsv8f/QFfQWFJLnJQpDCWmH0benqa8oKOOulygyXpDKYhNafv1DwsRr/HlkLFu34nOweCx4lDDqOfU/8t2Xk23+20p1Cv+Ng9XD1qYmIF5lVRF+dzaHUAjou+w3kaVtLebAWXd6KZ+UZRZYA6V78L2uipqtgu58W89XR8ZtdvYPfXcdpSJRJIpYV5iGR2/kPABdUgiHCtlzIe4qgZFvttNgIXBgGahk4eusYdubjC+Io4vGD5Bl1iOZTM+dz+Zd769ll1XNSvIly4rAjYz+Y/eFRsOD13O6KoSgscSRtF/hqdf1xNeBaFsrDcRWlQpeK82NYCz9qruStdah5t5cXTFP0rTP0vY54wtT6TuJpZj2GvOSjd5L51XAWawUjPPiYHj9aXy5JITLihyIbCDqDxfAjDrrQlw18E6xiOiS6KeEbyUCj7o2ZeCnZ723ZS69mngjYlmlrNLpt/+BzSh2vusDBUIkbN6CE0jiIqoyWTE2d9+h6Oa+Cgl4v8TzoBKT0jy+P/GxN1xQOv2vH467V0li5o3O37n1lRq9IOGVwNj7ZhmThl9Gww/Zn/XnQsAM0WUGpEcLI4Gv7NEGgR899f6i0UzxfWcO5cH+Bk8uAzB1hrIlIvFMLvoBQbY5KslhHazwPgYtq6h2AFFqsjjhJiwUiowOOUIwDLbCyU5GkG5mE73M0SM0XhJ3iqxyGkoAQAZhvtqaz8+azN9v9Jw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(83380400001)(44832011)(8936002)(40460700003)(186003)(336012)(426003)(47076005)(16526019)(36756003)(70586007)(70206006)(8676002)(26005)(5660300002)(508600001)(1076003)(4326008)(2616005)(86362001)(54906003)(6916009)(316002)(36860700001)(356005)(2906002)(81166007)(6666004)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 21:17:16.2649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a61c68-e0f5-4480-df4b-08da3525f4dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2718
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:
 
* Improvements in link training fallback
* Adding individual edp hotplug support
* Fixes in DPIA HPD status, display clock change hang, etc.
* FPU isolation work for DCN30

---

Alvin Lee (1):
  drm/amd/display: Clean up code in dc

Aric Cyr (1):
  drm/amd/display: 3.2.186

Bhawanpreet Lakha (1):
  drm/amd/display: Fic incorrect pipe being used for clk update

David Galiffi (1):
  drm/amd/display: Check if modulo is 0 before dividing.

Derek Lai (1):
  drm/amd/display: Allow individual control of eDP hotplug support

Jasdeep Dhillon (1):
  drm/amd/display: Move FPU associated DCN30 code to DML folder

Jimmy Kizito (2):
  drm/amd/display: Update link training fallback behaviour.
  drm/amd/display: Query DPIA HPD status.

Michael Strauss (1):
  Revert "drm/amd/display: Refactor LTTPR cap retrieval"

Nicholas Kazlauskas (1):
  drm/amd/display: Check zero planes for OTG disable W/A on clock change

Paul Hsieh (1):
  drm/amd/display: clear request when release aux engine

 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |   2 +-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |   3 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |   3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  15 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  24 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 248 ++++---
 .../drm/amd/display/dc/core/dc_link_dpia.c    |  19 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   2 -
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |   3 +-
 .../drm/amd/display/dc/dce/dce_clock_source.c |   9 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   1 -
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |  10 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 516 ++-------------
 .../drm/amd/display/dc/dcn30/dcn30_resource.h |   5 +
 .../amd/display/dc/dcn301/dcn301_resource.c   |   2 +
 .../amd/display/dc/dcn302/dcn302_resource.c   |   2 +
 .../amd/display/dc/dcn303/dcn303_resource.c   |   2 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   2 +
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |   3 +-
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  | 617 ++++++++++++++++++
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.h  |  67 ++
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   7 +
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   3 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dpia.h |   5 +
 .../amd/display/include/link_service_types.h  |   6 -
 26 files changed, 947 insertions(+), 633 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h

-- 
2.25.1

