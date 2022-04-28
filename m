Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5498FC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 22:13:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D976310E072;
	Thu, 28 Apr 2022 22:13:27 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2078.outbound.protection.outlook.com [40.107.96.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9765E10E072
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 22:13:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwKYC57RoUDbCGKU3PR3gCG1rAF54PsW6UVIyjOE1KfMxgNH3hEa/nv2tCLwmuTLVj8MfahslWUlNO8UB2h/TdB3favMluphp+xTj2+yj3xNk1nWNqTTpJ/EWDn2+/ToA9RjdvpGa8SNpIu5qmy8oYZXPWCq2/7ZtDmS6elV56W4Uw1yfHQyLCKRg0WMFJ8B5IqB4FDoI+TULR/63SYKeKj27JbdrqvGM3VZReHI94jYYBGwmpu/b+8nJu2ml9wvwV078okWN9l4Bqtw+0MJOOfjN7Ra6hvI5VsVBEm+VqA/9HcKpklHxxGk/+jOLxxkPkKCVbWymZzZG1Zhtj2Plw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emFo/OYOPwN0zllqEQd+kjibUfRPh+pKXc4zphX/H+0=;
 b=UiFwuSW3e5yG77OljIGFcEeUrGqnzwkm3wVKx/LdxWtQxcx5vAIonV22fabJ4/1HmQsbHdw3/51b3Oke9XNAA2aQe9I4xs8Tl3ZeRC/KFZOGJh/FjhYT1Tyu+9yNlw+S8hzf2J0dZOjtitMWrFLA/kIgDESW7s5+jvmRSt1QJD1u9ty7f1k+sM14UkZ2+R2/fUfuRiaU5IhiDbX5IdfaaJJZzVr7AbkP1ZN5uPJIUw37vAeBtU5KfWPYfY+a4stjH2zX2D4iloh8DPwJNEwliKhizlBYbnOWJllHMFuUpYJXNwCZeFPlEO96iSdRFKTm51TrUHABFdsxlxDl8yLdKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emFo/OYOPwN0zllqEQd+kjibUfRPh+pKXc4zphX/H+0=;
 b=sOjMbZjAqiJC4AnoPOaYQOZOEm2ZtHAaRrKJ+UWiBC2FXeetsT+U3CjkhgRrfWhvhyOqUGcI1dT7tnGtg4i3fQTrjCrzz2yc2CfU6dRREmk4oF/SsDCzgoyMc3PeNVd5VWGgJLqHo11lVaSaC3TPhql8PZZkESNRgYxioQl+Gxk=
Received: from DM6PR12CA0010.namprd12.prod.outlook.com (2603:10b6:5:1c0::23)
 by BYAPR12MB4632.namprd12.prod.outlook.com (2603:10b6:a03:110::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 28 Apr
 2022 22:13:24 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::c7) by DM6PR12CA0010.outlook.office365.com
 (2603:10b6:5:1c0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Thu, 28 Apr 2022 22:13:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 22:13:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 17:13:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/display: flush the HDP when setting up DMCUB
 firmware
Date: Thu, 28 Apr 2022 18:13:11 -0400
Message-ID: <20220428221311.1030146-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c5b8d67-e13d-42e4-349a-08da29644fe2
X-MS-TrafficTypeDiagnostic: BYAPR12MB4632:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB4632E7352EDAD101BBB2ACC9F7FD9@BYAPR12MB4632.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EohN00ksjlWZ0vFajHmpScJzB5HQyeLSKHtEy1O3DIaXFcz8ttkZgOEb7ij5VdSMwVNtOuxycVgXHQmpMH013sJcxA0bbqc/WbVSFQqYlezCYOZipmBjWAUe5lbSNL6KkzoLBZtRLy/k8ZR4jLV3ZbkjI7qSsKkGeX6QYqNr6aFhjfOFahBE8cEtiyfsGGYq1x3M1aokjexqqnGz4dKdtTYmT1yBDqeEZxCFO5NlbyNkGFGEjXo92Pa5arCMV60zv6Ztp/tLxm/3zDEIIWkT4aARWLHlpphmJ3I8bUcVmliKyIf4OY+HPyn/fDgud6GOtpjSBdayfE6W41otNWQuoAjWzkWs9OVQUJygSVzeTIpKZhS1PaQIl2DNBU1NJZzViYQoMUoLJMdBW9WsSjMqs3YGRr8sogTHE/5k/ChkJmSTrF5F76NgkniMGjvT4OPfg58ACbepgUrtwnZ7qOqhsY8/kL7B3l5dCVNikrh+VayEakG9HLdkOcYYz/cFc9+Q6L2z6rpCtMEm5gif/rgnJMkhm7p1BHRRPsNio7b0QubgrckCBKVNJc4yP2m3kluDbNBWBKWNL6+OReCaYns3oAwPcE3Cj01iH6Dj9h5c0vtxBJV7SIQp6j/TxZ5XjLJVF2LKH0mBk0D4XHCB15T+LRUKbBtyiLNLvsjse9kwsMPxHsffaLf6TMvnB23pqIl4Y/Kxhbb7+em3Gi1Vbeubsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(4326008)(508600001)(8676002)(81166007)(70586007)(70206006)(5660300002)(7696005)(36756003)(40460700003)(356005)(6666004)(86362001)(82310400005)(2906002)(83380400001)(6916009)(36860700001)(8936002)(2616005)(1076003)(26005)(336012)(16526019)(186003)(47076005)(316002)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 22:13:23.9102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5b8d67-e13d-42e4-349a-08da29644fe2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4632
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

When data is written to VRAM via the PCI BAR, the data goes
through a block called HDP which has a write queue and a
read cache.  When the driver writes to VRAM, it needs to flush
the HDP write queue to make sure all the data written has
actually hit VRAM.

When we write the DMCUB firmware to vram, we never flushed the
HDP.  In theory this could cause DMCUB errors if we try and
start the DMCUB firmware without making sure the data has hit
memory.

This doesn't fix any known issues, but is the right thing to do.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a6c3e1d74124..5c1fd3a91cd5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1133,6 +1133,10 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 		break;
 	}
 
+	/* flush HDP */
+	mb();
+	amdgpu_device_flush_hdp(adev, NULL);
+
 	status = dmub_srv_hw_init(dmub_srv, &hw_params);
 	if (status != DMUB_STATUS_OK) {
 		DRM_ERROR("Error initializing DMUB HW: %d\n", status);
-- 
2.35.1

