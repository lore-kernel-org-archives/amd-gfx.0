Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FCEC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jul 2022 18:26:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D64918DC93;
	Tue, 19 Jul 2022 18:26:58 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2041.outbound.protection.outlook.com [40.107.96.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CFC18DC44
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 18:26:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfRPDElupfrqCCqVbbTnoSWn7TI5+Z5PSS3Xcf7ixYiftq/MJ9w3ygjL6woDafGiSfbgalV+rdh2Hm96kfIsxbzIrrzl3iYgSb1kkJM7QF+PDb9+S59Typz4sSDcZEBor56jWXUAACXtBMy6gt50cVAkrXW9dD3RePPwR8Bcl7gknk62HdVPBlotVA9gnvOZPQfrp8Cnm7w9gTaevTTJY0CbmVAq7RKmi7pn+CMAOp9ovdFN6iui1DYJCvNy5mJUUA9dKVY0TJJsD8uuaPNqr3IDgJMeTSl2LML9MNQzaqZwvZODpdjAAVV/jMR7WdaArTMFqlnr7TU2Xhkdx9GzlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ju9+xGUv0Y8KHBb0Nbv4/DY5AjWbl82csdTAjF+Ayq8=;
 b=QKKf5UHHrbAw1BX3Yyzn4hTvEsod4te/ss1tZk/x4orv7fxNlAKiPCjobVi+uSaC45FUXnzO3io+PA4c8gNtAuE17JiJE8LyPZ+d1/euhp4B5yc51GUnm/bBwRqzq++wTLE0RG1qkwi0Zzi/vXCJr3wd7UCQ071LoFzP5azk5HVp7/eHsqD9i1W5Ozu7XgNAat0e0fZ0+eEdUPtAwTLOK8vmhPneWAio6zOF72H5InP5Sbfw+kNYQLrA8CvrOxQIe9bfGwvYIo5KXFl4IUVMngaV97t8K7j+sGNztDZigQa2S8J+ji2zQISTs2+fvu/s8+8gXyW2NiFayGea+wsslw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ju9+xGUv0Y8KHBb0Nbv4/DY5AjWbl82csdTAjF+Ayq8=;
 b=nhXDmvN8uZYIyILrLimsFq9Zv7sfP/v7y6l4IJj0OU4DbnHwqd0+mRCeq1Y6ZZkeTWKlrGap9neLmv0+U6t7eDcBRsojiOXM/fhlhVV/+VfmG7CliH6P0IJkvh9gjKGUX0bHTJEMa4zUd3xtYzcGUXiGhuInu30QSOz4zKBZd7A=
Received: from BN9PR03CA0674.namprd03.prod.outlook.com (2603:10b6:408:10e::19)
 by MWHPR12MB1389.namprd12.prod.outlook.com (2603:10b6:300:13::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Tue, 19 Jul
 2022 18:26:54 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::43) by BN9PR03CA0674.outlook.office365.com
 (2603:10b6:408:10e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23 via Frontend
 Transport; Tue, 19 Jul 2022 18:26:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Tue, 19 Jul 2022 18:26:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 19 Jul
 2022 13:26:52 -0500
Received: from roma-vbox.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 19 Jul 2022 13:26:52 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add dm ip block for dcn 3.1.4
Date: Tue, 19 Jul 2022 14:26:46 -0400
Message-ID: <20220719182646.23049-2-Roman.Li@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220719182646.23049-1-Roman.Li@amd.com>
References: <20220719182646.23049-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 638c08ce-9b53-492b-c0e8-08da69b4412b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1389:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: biZ+cgNJ8I2TXP4BnK49/Z33Yvbq1Zmwa8nhykXkHJN9xDnWDo+9VwKpkgP+ZF480Sc6grfBSjVEXXw1eI275KqTCC0jGFNOkcqL6flTGGDtVkpyOXc/ib25N92q5eF1B45Bkn4LUy/KSMlL3AlZUwJ3LGhM8GehPyuoAsEc9PD8kXC6Sis77I3gs0ZJq+1pAW+bggMM+NgE431rEQ2bZzbRPq5RDvM6AKQPZp73ZjC8fwQlalNDdpinylJetByYOQ3WcYU/4jNpIVyEnEGGsMCDyerfTAYgYQqNP9t3bsTgWB/RNmlNyMv4HMEg94m/aha6/f3JRzQb6SbGk3h+tJX9/0fAVi6pRe5mPSYogJQ5Lx28Iw018atuqto87LeNAdkh7rQv4iNjdbIGfoZYYsoL3+HX3W1VD8HepjZntjmJfnD3IIqcMUsdID5ncJJajf8E36D8YT8cNbf4mVTwf4z1jP8siV+Ufis2E2M9fnhyWN4IelvUxswrTDDOLvkHWxs8zFWi5TfEzMa5E6plkjT3ovEcurGJYwBKUqq8VLxgOVKx/gvc4QI0D7WAKn/ZYNP7hUz41/GXFw4PmR1UkcXgNnNcG4pAhC/2JI/AsMfT4ucUQWP+JOG6mHDLjClyufNIm1ONN2HMsNf17u+ghmJ8R8zXUxUgQ3CzcXUi/GuqLLR71NvRr6tiuxxP3X39UnpQJr78c5khbsowNIji8vvNXiRMJ1SuOUsDlIatZwoqK1GWiGKnOor2kAGEUoTjpBQdqH44fhiLCntc3oAju4xJXxv3QBLRodiIOkdoHn1QjRZwTdRDuI7za18XFzKxw6GZW0FxTVDQteXZy7VSNj1LxrJ0aWrZBWA+4kbczHM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(40470700004)(36840700001)(46966006)(83380400001)(426003)(336012)(36860700001)(82740400003)(186003)(81166007)(40460700003)(70586007)(47076005)(110136005)(36756003)(316002)(8676002)(6636002)(4326008)(70206006)(478600001)(8936002)(5660300002)(7696005)(26005)(1076003)(2616005)(356005)(82310400005)(40480700001)(41300700001)(2906002)(6666004)(4744005)(86362001)(2876002)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 18:26:53.4137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 638c08ce-9b53-492b-c0e8-08da69b4412b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1389
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
Cc: Roman Li <Roman.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <Roman.Li@amd.com>

Adding dm ip block to enable display on dcn 3.1.4.

Signed-off-by: Roman Li <Roman.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 0ba56e2ebf09..242d1847c4aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1716,6 +1716,7 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(3, 0, 1):
 		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 1, 3):
+		case IP_VERSION(3, 1, 4):
 		case IP_VERSION(3, 1, 5):
 		case IP_VERSION(3, 1, 6):
 		case IP_VERSION(3, 2, 0):
-- 
2.17.1

