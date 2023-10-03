Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B6AE8FDB6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 20:57:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FB5310E0F2;
	Tue,  3 Oct 2023 20:57:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DED0A10E0F2
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 20:57:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuJ3kWhe6gBend+760OUVPbzrUimJ+4RnEPWvEjyQuVMqNhPchkj/0aO+nSymmvrOMirBVD6NN90E2VcnAiWP2RKY2z0Me5UMVPc1njrfWrr5qFW1vyGIaPTRgE5mfLPwOsB7PtRr+ksbOazT5qAXzxW+JfmNzKV0BrjSGcTplPm402KyGFFJuftuCV/suya0qEoLBDmpq+JFJCntf1jB3Ev0mbPMaaDNeGkb2q/zXR1IwnKmBmznwk57uJk+wNwaFLCOwqkkImjHEUcBQpMwYfP4MUf0nEGJdYs6MrfkEIBW43Xk3mx0/yZmFc+SoISVXpLc5GP6RD0KTGYtf2Hqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Tn7TH7qvz5erIChAM/tywXarTxa2faJ+fRVyKa/jdY=;
 b=EHRd3IHO56W71ErQbBF70gJqql3WH1MobKAbpUildYAgBBs6DWzdu4XFMRW8+rpzkzHCJCgl28oJWJJbz4qJj1nTEjCdk8Q1fg63FsBYZj9o4+n1qgfQc7xXrTkxj74QFOIq0KOpEFEzw4BdyvcNnxUWzrGfHRnI8hWPzaaYZC1HFWbyj6XkFp4EhYDQeAbLslT4U3M6PSWR74umfy5N1Jf14kQFmzdT1Julv8Mx2OM6r+sspVC7W1y7UK3diPCRkKwId4b6jSSnGxq8A2Sj/XuTwmtbv5JQaj4EhY8OnZujw7NyuEyel2Tpqa8x6lJExMp3kAv/7fYuTWns+ZI7sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Tn7TH7qvz5erIChAM/tywXarTxa2faJ+fRVyKa/jdY=;
 b=UXSpllexiTTtpMTZCYlAtUIPHOjOwVoNfvCmAOT0pXxoxnzadyFYl6U1VLXrZJM/LI0u4LUGXs47sUh4gMD9U4VtBmHeRyQ7Jvmlb7mWfjSHcoiVAhQ4/FWZr3f8ZODwXAQb9kfyggBvDzmn6hpEVcPCMifql7EnSBNegcFd97c=
Received: from CYZPR12CA0023.namprd12.prod.outlook.com (2603:10b6:930:8b::19)
 by BL1PR12MB5362.namprd12.prod.outlook.com (2603:10b6:208:31d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.32; Tue, 3 Oct
 2023 20:57:28 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:8b:cafe::4f) by CYZPR12CA0023.outlook.office365.com
 (2603:10b6:930:8b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34 via Frontend
 Transport; Tue, 3 Oct 2023 20:57:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 3 Oct 2023 20:57:27 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 15:57:26 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 0/4] Better handle memory pressure at suspend
Date: Tue, 3 Oct 2023 15:54:33 -0500
Message-ID: <20231003205437.123426-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|BL1PR12MB5362:EE_
X-MS-Office365-Filtering-Correlation-Id: d451d369-26e5-46fb-9d07-08dbc4535a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cfNWP+aqkSwVqo1Ef4bl/xdbiowAszKgNh1kLbwd2OvNJiwgRoaKMbK7h2DgFwQ0v55l3RXox6H4DNbvQZbhUO01NqEhMsrCYUAAQt14hLWpEgawjxDakZbvxWDpajZVDO9tKc8MUfK6dk5GArdifUka9YLeI1Od7bQ38kZgil6sljXiH1be7gF6ihJ3ikuiYtYBYEvhjoUTqFsDrUx0RzM94+qJ3owuZchJRQ4g17pyqiZcaZtHvsu2+XTfClucpUsDsxRcJW65FzOkGSnpeHeRu7hJvaQXUAm4sIdUPgaTOmcu8UXavVEKWS1LrV0I4Uf/21LSzsbC2dlM23o94NKbOJV7AZzZWaKaGj+eoOqe6WgR0GVIQTGsm6j3CdnLAEnI3kfuEIr3F6foNLRdXFLBuJHqxnUtJ9FfyEQAU7k3tpuKvcOPDY4zeHbPeeZjLsyFbLjReSJEZ5/hqmNOS0SGeOXsixp2jq5EElZ57Yspf3wxPRgA0OF4vdZAbWFCMHpExuYqtJ+INLpFFDu0Mo9ejnIoJS+Z0VZpurog2ZX5xPyNOuv+PAFzPHVj8EQBc2da1Pi+DtkcIPeWX5jbsrrJ0aUidV7p07eWf5ooFpgCSdYjc7OOlpapT5HHr5/kXjXy4mGRibWwsYWoNi8f5hQb4ZUHR8JlGOA0L+gSzUpR1DG0x9pWTO5aP8kVNNOHjGa8C3cxUY99JvW23B8Vcn7Zy9b+SUOpdcpfkUY+AI5nBbsQ1bYOdSrHFRwxhjU2DfvYxry0ObThu/DckXPSa/wvO0Eejn5EJOqh7x/moUc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(82310400011)(186009)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(478600001)(6666004)(7696005)(966005)(47076005)(15650500001)(356005)(81166007)(36860700001)(86362001)(82740400003)(44832011)(41300700001)(426003)(6916009)(1076003)(26005)(83380400001)(336012)(2616005)(16526019)(2906002)(36756003)(8936002)(54906003)(70206006)(8676002)(70586007)(316002)(5660300002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 20:57:27.9836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d451d369-26e5-46fb-9d07-08dbc4535a64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5362
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
Cc: Harry.Wentland@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

At suspend time if there is memory pressure then dynamically allocating
memory will cause failures that don't clean up properly when trying
suspend a second time.

Move the bigger memory allocations into Linux PM prepare() callback and
drop allocations that aren't really needed in DC code.

v1: https://lore.kernel.org/amd-gfx/20230925143359.14932-1-mario.limonciello@amd.com/
v2: https://lore.kernel.org/amd-gfx/20231002224449.95565-1-mario.limonciello@amd.com/T/#mc800319a05df821cd1875234b09bf212e2e3282b

v2->v3:
 * Handle adev->in_suspend in prepare() and complete()
 * Add missing scratch variable in dc_resource_state_destruct()
 * Revert error code propagation in same series
v1->v2:
 * Handle DC code too
 * Add prepare callback rather than moving symbol calls


Mario Limonciello (4):
  drm/amd: Add support for prepare() and complete() callbacks
  drm/amd: Move evict resources suspend step to prepare()
  drm/amd/display: Destroy DC context while keeping DML
  drm/amd/display: make dc_set_power_state() return type `void` again

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 46 ++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 11 +++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 17 ++-----
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 31 +------------
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 12 +++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 7 files changed, 69 insertions(+), 52 deletions(-)

-- 
2.34.1

