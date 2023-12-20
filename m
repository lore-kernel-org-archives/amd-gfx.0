Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCC7C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 19:30:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B9FC10E5FE;
	Wed, 20 Dec 2023 19:30:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44EF310E5FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 19:30:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNV1r0qYSWTW2D6+yPZAff3quDgb8wpD1Ox7NMECcmaElDfowWVzQJmmuQAEbGoCPlRYn6PLuorrfI4/k6JZGZQt/BsiAiKs/oq5/rlWtnCdBAgZPvzeAJXqkurfOECzUFBoDUPT0rDzBrP0hRoCaQwzspdXtObDSmy2OePUY5rivEPOSaQO8+FcPgRX6p+RBCTxauHGC2b/sQEJwKhkds6nxVn+31MnZ7PTxItgb8+C/sRqPfswprti/ABi+NijSAdh7814Lk+9TsIWpcsbqj3XhfVYffwYY4YTeYvG8dYmnWtAxn96CCoCgtCpZ04CCcx360vMipmDAhpvPgpGLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGWtk5QXj/BgHSpgt4whBC6cmIZnrESOftKrpHar1HY=;
 b=YmRfWwRcZBqhJLkiZ527HWiAZlS+Bm8O+yfZjGemdvkM1x0rRutdnUxLvoykbWm/TjyU26TcfrjZfy1vOrEBOmLl6sTkh3UxcQXmHAj4+ZpFzwogw4gqZ5n4yoho27OsZc045XQPj0SysSx73N0OWNOeeP9yBysgGUKVBOHbzEr1asSQtC4l2h54B8KnUuISzyip1/SusqXoOLO5vdo3rwvjAX8IEz7zl8HVPKjOV5QAZBpXyJEr5AewQObgT8fSGs8/kmg5wqFbM+2s/vYUmxmGfR7Cr2sXG6eXdckehfQJOuDHxgUF8rFIZNqrMBkwPvO9/wAg+oJJmrYP+BIefg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGWtk5QXj/BgHSpgt4whBC6cmIZnrESOftKrpHar1HY=;
 b=ECCsn/JHHTAOptQhj/yqtP3h9RgQedKjYXIjR/OFxuYeZ/lGGwR0lSMHarkzcesOWqD5T3b0myou8xEstIPJTB1lcLV0kFV0YzVMpEfaRwJA9yarPu3P7FgCfhZVi+o7w6y8QQrEROS2cK7CNSD5C3NPSW5Ys7co+5Iy1ECarf8=
Received: from BN8PR04CA0012.namprd04.prod.outlook.com (2603:10b6:408:70::25)
 by CY8PR12MB7537.namprd12.prod.outlook.com (2603:10b6:930:94::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 19:30:24 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:408:70:cafe::d6) by BN8PR04CA0012.outlook.office365.com
 (2603:10b6:408:70::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 19:30:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 19:30:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 13:30:22 -0600
Received: from roma-vbox.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 20 Dec 2023 13:30:21 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <mario.limonciello@amd.com>, <li.ma@amd.com>, <Rodrigo.Siqueira@amd.com>
Subject: [PATCH] drm/amd/display: Disable IPS by default
Date: Wed, 20 Dec 2023 14:30:13 -0500
Message-ID: <20231220193013.6897-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|CY8PR12MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e7f180-e4d9-47af-9ce8-08dc01921d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 887Yod7f0U4fezL8EzUlo3kOOhzGRjppUvHYhZWs50D/zP7VkJw6eOaBucl5LUP0bhbLxikw2e4WMDWsyhcvww7bwJ0rrtufT1UG9rSXCsm6Af5EOlgUcz67E8ufjG8WA9nFd/y7H7d2aw1y47mYUiXTazhh3302TJ/OSmMbvzErKjiIRKdw6XbvgMIMZRrMDfXJP1/s82/CJQBUuzYpxN505SMy0Z+FdGUCUF5e7UgXTxMubYy8FxUk2zLggeabD2xAK4A+XCtgBjvITPO0+AiWeOKeo6KYViEef5X4dMwWTypbEPr+tV6v+7oYNJUmb2umfMcZHARbccQcDqRXTadyUN1Z3rg3eFNkFO8RB6ADmkXNYr/PP1d+rBJIDea7Y0cRDVqlCAlSaeSjyDFD5HueSmlcqc6uAixYFp+Lr0/v8Iv+r9nEzuxgVuxELmbZivISK1Vnx1ltoL97HgfcS1GUYilwEorIjy13qd9SQn83zmyEjlCWEvDInQVYR+zyR8QE+13xvir4furUoTlEylwuCR5yszGiKyWVEvKrQZxcDLnsB3y00AVcyTGLnrEY39XUWt0BNEEa+ZyvYzIaaQayZAuiRVTEFUm+a+LW3dS+ifJxgXOV8srHSWh8b3+l54rOQJUS5uFwBVC6RAwJAmFE+NjCs75XIrL/5FHYfXbaAyfDSbsp/HAjq3pEx2bfzsYEdBOcvKEgnKl89Q7cJV14Yzr1GkjAg7K+QmkLVS52I+hpKbfPX+8akqsMZhED8TKAOMlrTzzheoX/kODD+45PSP+ZCf8sRqKrQxfZg+I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(46966006)(36840700001)(40470700004)(2906002)(47076005)(2876002)(36756003)(356005)(82740400003)(8936002)(8676002)(5660300002)(4326008)(36860700001)(478600001)(1076003)(26005)(81166007)(2616005)(40480700001)(41300700001)(336012)(426003)(7696005)(40460700003)(70206006)(86362001)(70586007)(6666004)(6636002)(54906003)(316002)(110136005)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 19:30:24.3492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e7f180-e4d9-47af-9ce8-08dc01921d0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7537
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
Cc: chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Roman Li <Roman.Li@amd.com>,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <Roman.Li@amd.com>

[Why]
Instability is observed on DCN35 if idle power optimization is enabled.

[How]
Disable IPS until issue is resolved.

Signed-off-by: Roman Li <Roman.Li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2845c884398e..2cabe1b463bc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1710,6 +1710,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	init_data.nbio_reg_offsets = adev->reg_offset[NBIO_HWIP][0];
 	init_data.clk_reg_offsets = adev->reg_offset[CLK_HWIP][0];
 
+	init_data.flags.disable_ips = DMUB_IPS_DISABLE_ALL;
+
 	/* Enable DWB for tested platforms only */
 	if (amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 0, 0))
 		init_data.num_virtual_links = 1;
-- 
2.17.1

