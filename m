Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3CCC54E94
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jan 2023 17:21:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D6CB10E02A;
	Wed, 25 Jan 2023 17:21:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6997010E02A
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jan 2023 17:21:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOoMSJvi5ClkxUtXrmSkDcv9Ph0P7JMLNwtjBHRgYl6xD+nx7EyxFezl9bNqXG7j6W956YkM3ePkYUpRm7+0VEvjxoWvY7wTy2DDDQNV1NF3BjD6ecUTmvJX4Xs+Ne0OQUEHhKzcw4KFxArmkjz1YcQ6NUg6HOGGQ1FKwnqXL4QVuN5Axx/BdasBGb2YgfJoD7YR4OV7CBd2ct2IsNIMK3SKUkWistTXZq2haecGcFZMktrW2FiZupNY0jZYBY0A7id7uXzq/9+mVjLOACXu/5mV7eMHtsZRHVA0VvI8r8MGAuqptb6E+lhKxDCZQmyiNVkyC5GcWt1Sbrp87vpFnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viXsyhYsUdw3z/N/92UUxgcUNqjHQWCKbDZm2UogAdA=;
 b=f8GHgs0QBl9wX33Q+0QNJUqUxgeJrJfOWGm+QMisswTbIe8kh7WcnwRsZEoDuZyQNoIow0EOiM7MU37hxvi78BuAuCcYYvkbUxCznMnMUxkwbx1yHtU+Tqsl3h82vsD5vYtQQmG3zhAusXG6LbDivDXHtsuOIMaBKVwxSVVjZegYY5OgBvtWij6G6GaiPdCYgXgdxanX0gjZ44Pq0QQcj2j5rj+SFK0Q/VldqgbDhABJggFDPFnO4LaaHkJFHMWDA8cKg4yNNMXtDSOZWXQopTEpi/EsjaZTobKgjPka3Sjnfy9FJLX9RxLY3zfy8OINqrFCJ53Ue4kBReE5GQH99A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viXsyhYsUdw3z/N/92UUxgcUNqjHQWCKbDZm2UogAdA=;
 b=f6/Pac8sUhrvrkLePnIcEalvN71DcxKLFgHuewI4TOSg4L96BbnWmrkAHADCyx/tRffUsiuMhBEwCreHYPq8h72fXJEITpTKVX3/coPQUJvso2oKDeUREHvaXLRxR7IkG7wKcf2sVydvnc+mjRN1w+DFVQ0MRClbGiPkfgVr1Hc=
Received: from MW4PR03CA0216.namprd03.prod.outlook.com (2603:10b6:303:b9::11)
 by CY8PR12MB7660.namprd12.prod.outlook.com (2603:10b6:930:84::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 17:21:00 +0000
Received: from CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::7b) by MW4PR03CA0216.outlook.office365.com
 (2603:10b6:303:b9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Wed, 25 Jan 2023 17:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT113.mail.protection.outlook.com (10.13.174.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.17 via Frontend Transport; Wed, 25 Jan 2023 17:21:00 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 25 Jan
 2023 11:20:59 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 25 Jan
 2023 09:20:59 -0800
Received: from desktop-host.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 25 Jan 2023 11:20:59 -0600
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: always sending PSP messages LOAD_ASD and
 UNLOAD_TA
Date: Wed, 25 Jan 2023 12:20:57 -0500
Message-ID: <20230125172057.114746-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT113:EE_|CY8PR12MB7660:EE_
X-MS-Office365-Filtering-Correlation-Id: fd886895-9bae-4e62-d008-08dafef88784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JxMoYCSZFQqk+LZreaOf05treDusKERGHrgEJsADSNFwQGT/HzPl2gSujZtuNH2QUCerlG8h9ycAbEm6+es01Xwtd6296MrYAfw0udsGoX+emMUVVNUYog4bs0TMeOXlUw3jmESaq/h0FDX6zp54zyebkrdL9p6hg4EvH+C7rxOmDbK/JLJPhojl1nxwQ0m3HZlUsa2fhuaoFIrKXX3mSqQKSXfWkZO9lOtUzSiiS0U1OBxIRhJBbD3Az+wsEd1TCbcGS65fXuh9BDhHxaaxXYlXWbbGFLpbzFKcAHERda5owZ4Iv8CpbIxZ0f8dCZ7i/gxDnrLWrwba+ln9gcHKANzZ41GQC7gi807UA+E2udAGKy0YP/SV9HijxUgsYPdoLt/NaWPAcG/MPHqvdkf2ZpuQcSLuax9Rsah2xSXdf5Ic3zumMRgrCqD6Xe+TAs0qezJ9iyL+8OzPa0LOgNlUkDQwsU7NSUrvNWIRNu2P230VZGpdthgWkY2sq8mzgDJcXE/DJVNdgtRje3iCD6xKDqt2bfUsuL2iT/zEPOJ/oLrA0+AO4DrzTZ5oQic60CB1baXHvPZXKD7Mz1jGMH+yq2lWgOOoJJl9JPDfZxFD9KCiKz8cOt5MjeeqZTCkAPo6QG0dNDIGjKY5+c4tKiA3gye27SraX8fURX8waAlv7lGZVkwTTKEDI4G7o8Gpn/BaAWMBeG6b/rn+hokINlWI8SMiJmnTzXhYwA0gRhSsXCA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199018)(36840700001)(46966006)(40470700004)(336012)(316002)(2876002)(47076005)(6636002)(7696005)(426003)(110136005)(70586007)(15650500001)(356005)(5660300002)(2906002)(8936002)(82740400003)(41300700001)(40460700003)(4326008)(70206006)(36860700001)(40480700001)(8676002)(186003)(81166007)(2616005)(1076003)(26005)(82310400005)(36756003)(478600001)(83380400001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 17:21:00.3913 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd886895-9bae-4e62-d008-08dafef88784
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7660
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
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

We allow sending PSP messages LOAD_ASD and UNLOAD_TA without
acquiring a lock in drm_dev_enter during driver unload
because we must call drm_dev_unplug as the beginning
of unload driver sequence.
Added WARNING if other PSP messages are sent without a lock.
After this commit, the following commands would work
 -sudo modprobe -r amdgpu
 -sudo modprobe amdgpu

Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Reviewed-by Alex Deucher <alexander.deucher@amd.com>
Change-Id: I57f65fe820e2f7055f8065cd18c63fe6ff3ab694
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a8391f269cd0..40929f34447c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -606,12 +606,21 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	int timeout = 20000;
 	bool ras_intr = false;
 	bool skip_unsupport = false;
+	bool dev_entered;
 
 	if (psp->adev->no_hw_access)
 		return 0;
 
-	if (!drm_dev_enter(adev_to_drm(psp->adev), &idx))
-		return 0;
+	dev_entered = drm_dev_enter(adev_to_drm(psp->adev), &idx);
+	/*
+	 * We allow sending PSP messages LOAD_ASD and UNLOAD_TA without acquiring
+	 * a lock in drm_dev_enter during driver unload because we must call
+	 * drm_dev_unplug as the beginning  of unload driver sequence . It is very
+	 * crucial that userspace can't access device instances anymore.
+	 */
+	if (!dev_entered)
+		WARN_ON(psp->cmd_buf_mem->cmd_id != GFX_CMD_ID_LOAD_ASD &&
+			psp->cmd_buf_mem->cmd_id != GFX_CMD_ID_UNLOAD_TA);
 
 	memset(psp->cmd_buf_mem, 0, PSP_CMD_BUFFER_SIZE);
 
@@ -676,7 +685,8 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	}
 
 exit:
-	drm_dev_exit(idx);
+	if (dev_entered)
+		drm_dev_exit(idx);
 	return ret;
 }
 
-- 
2.25.1

