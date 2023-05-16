Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A64C77B75
	for <amd-gfx@archiver.kernel.org>; Tue, 16 May 2023 21:18:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15A6510E0F9;
	Tue, 16 May 2023 21:18:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 890C510E0F9
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 May 2023 21:18:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfRtEPyZn+HSVO3ViSQQ8ZeztBQIXt7NzfBNWSsven0dqnx4b8RZV+c1rmnlH7FN1BhFk8e4WZu8frCauZKBy9k7tV26pBWiBh9ji7DDNYGzdHi79n6Oc+nRBg1fnEcusRtNCyyUlj/7WQd/GbLT+pL98jsN7IfIbwnyPgN0PXZnLUVFfxIaZJ7J3f6IcL2XVRqSbHZC1DSHv/OK4IwxIS2fLwQONmNvaC8Ib8gzPf5JIFsCm77j8d37+Gv61DvaYjRoCUnIJ0nTrEdSY5U18RVELHuy8+elvlZFrIE6QJjjpKYmfcFLzSQ6XRJGiLY3d165ZY7BRn2/JS8gIztVZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuwADQCBBKhbKCZVca8it9bNUVBh9lP2L1YZSyw/NKs=;
 b=ge4sd/EuJXKe9vrRe8ZlIX5c5+7dkRZB8anjho/oaSyOSOoRaaVFW1CbQuhm7yIzIUMlwkQCFWE16kA0H/fnLf3I6HBR958Sdkn8SSdLb5+U7iOVkmBgNAdyGWEJtUfNs/YdnYc5hn3RMLUup4nbUIFKXQXnB6d7u7a7L96U//wwMlzE/ai5H+KVVXKzSopF0TVDoglDXc+nclYkLDHLX0GUkwAajMI16q8/typWM8yac26j2qgvGSZ1eUo/vellHfZTBY1+S9MS9jn19p60qMfVyIbMibi/ZL+5YdfFY1rTE1S3wt9QvZ+GLN3GXMXlVhWuWfxXVFDqQi5eTQynyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuwADQCBBKhbKCZVca8it9bNUVBh9lP2L1YZSyw/NKs=;
 b=LdUDCjiiQzgzLTC9WeBzMyG7PgmOhKUl/H4uD2JjNP6UQlkiqeUQZsarwTMlVxcC9k6o7rc45vJJMzUOqIDPD2k+ckouzRRDQ0/gZVxS78uN+R3lTNi6NBxreXuWbYRX7tZFjDso1QZUeUASupoddJKaZBCFiO4JnDlzDixKFGQ=
Received: from SJ0PR03CA0228.namprd03.prod.outlook.com (2603:10b6:a03:39f::23)
 by SA1PR12MB7174.namprd12.prod.outlook.com (2603:10b6:806:2b1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 21:18:25 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:39f:cafe::b0) by SJ0PR03CA0228.outlook.office365.com
 (2603:10b6:a03:39f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Tue, 16 May 2023 21:18:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.17 via Frontend Transport; Tue, 16 May 2023 21:18:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 16:18:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/vcn4: fix endian conversion
Date: Tue, 16 May 2023 17:18:10 -0400
Message-ID: <20230516211811.2979728-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT035:EE_|SA1PR12MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 3799ea17-9d87-41db-d3bb-08db565315c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mnn4XAuJ9YXKahQUoHr9ws52Glk2aM79h9LCiK7EoM7De6WLIUPKZ6khF+ghlJLz8mN75GD9QHTQnHwA8eWlkzCzRhRSPNIkV0f31kqlmByw2QUPB/SwCW9pyJErbQIBE/hrV5y82bHR0us72TVyJtxEhUaXkSR9DAZU3e513h4whJi/O5u7nfYZCsIBLY1aFTrhpScVx/CxwEJyzGgMcCA9BO8VjV2BWcOZ5N8Pz7G8eBbIgGdBgtQpJV/OVnWC1jTeERNFeo1PsVjgoJt43uLWs9QkXj17+o1QoaGfhCDRK/cy7OInDvqg2HegAot+Zr3q0SoS+58YKSfM2a3vJsUyyVkG8ID9UzPIqftBF5e2vncd7MQGy/QbgHvI1WVb3ta3yKevJCeOv8PdDkq85UCEYU+ELhc+IoGE8t7lrdwGEHreorQcMdETkEmbzrZGSwh2IJ0PXj0tDttJjWyfxHF+IoF49bZ/eioXOQydpaOOYAvhb9InwP7zDYmWq46ogoejelVUr63XtbQWQ0XE3+n2hZncC0pW0NMQvqcP30yaEsbRzGq3DWo6AKGETV6sYnpZBtnQAoorvL/Uv8o2qlQjATXuKMZUDSg3n4RB1ZQjXInbIGjVxGJ/ICblhnwGdP+F44YvmW2ysai1mDIdg2HPz5C7+FFAvJoNx58cGKUB+LxODGsIaQ8DRlIbhsY8YJ/KvDUYcLR0wZ1jxQb9Hxa15qxJVnqrQv2j1OY+0BxItKp/K+mR8/cbZ1XdOXsTJixoponmYZudgeyufLdRbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(186003)(86362001)(16526019)(36860700001)(70586007)(2906002)(1076003)(26005)(6666004)(2616005)(47076005)(83380400001)(82310400005)(7696005)(426003)(336012)(8676002)(8936002)(478600001)(36756003)(40460700003)(81166007)(4744005)(5660300002)(316002)(82740400003)(4326008)(356005)(41300700001)(6916009)(70206006)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 21:18:24.9574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3799ea17-9d87-41db-d3bb-08db565315c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7174
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

sq.is_enabled is a byte so there is no need to endian swap it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index c77ceaf53dcd..339842382a1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -124,7 +124,7 @@ static int vcn_v4_0_3_sw_init(void *handle)
 
 		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
 		fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
-		fw_shared->sq.is_enabled = cpu_to_le32(true);
+		fw_shared->sq.is_enabled = true;
 
 		if (amdgpu_vcnfw_log)
 			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
-- 
2.40.1

