Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B028C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 04:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3A0410E466;
	Wed, 31 May 2023 04:29:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A192910E466
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 04:29:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8YDaYx9fxF+raFHCOmXdWNFsnJVbQrqOVKo1Xiv438Xd7oJSrKDUXSmBFvXGOYIvJC82vfmotBt4xt1KJpYgPTNW8+DS0l0qegrqhZvkv0j/w3sNhm/sAqH0QVH77XiEoGSY4bHhStpyXpt6LsfBSXDGAfAdW8C5FInC1JlOFGXu2lVI6UFeuu9gVb0Gfmc/ZCwL7lGCYqC9GzMczL5xy09MvoSYAFvQFfztcr0SrlG52HIs1o7CAokz9Xe6eZ/bqSv2Qznv0igjFdUY/oIogMnbVkyUbDo+moVexy6SCw0f7oL2I/0H7GDVaLFmV+GFSL9DPtW8ANAk1nKGve7PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lt8Tdh6Ux9k0NA71mymgWlzxid9HGWL44ZSafQy7IZ0=;
 b=HHAwgZ4f7rkae8xWbivWhKNv0ldhRAPmS2uMUU5F+M1B+cfmm3+jnBidBShY+Kcu7r1VvLldQGkygpsE+vS+qKX/UlQPV8dFsCrZCdJ0zRDYCBJwhFOSIRyTf6zWs+vp8ToFkfxg7SI2a0yacfErW80T164duSZIcu6RCKu/kX7yiCEHevy/C4t8YEKxNuRZWKQq3NWlsVMjKDZvt5DyrSsrJeQs+uQ1soNwnR4cSToqMUB3TcwRL0lPLs4drub5xUQd2pZ9Mu0AhoBRqf8NlmbwOTMgojVJVAystmaxv1lzyZ/wherEBmgN4bG/KwzYa4lNs3tuVGYmKMb1jr7H0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lt8Tdh6Ux9k0NA71mymgWlzxid9HGWL44ZSafQy7IZ0=;
 b=d7j6MB5mpafWvSs3ek49bK2nbeivUX946wmPjKIoYFFoqsDsLOqI3DG4wRW9Ngipz0oSCS5Of5j6TgpyZLtkuU77D5i7JEbr5Bqa7lX6mqsVr14bXu9kHCRsP0kQ+abVVX8cJbK4+RIAR0IhE6PZkv6+5YwAF4+DkVPN0hy9XCs=
Received: from DM6PR11CA0005.namprd11.prod.outlook.com (2603:10b6:5:190::18)
 by CH2PR12MB4088.namprd12.prod.outlook.com (2603:10b6:610:a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 04:29:16 +0000
Received: from DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::12) by DM6PR11CA0005.outlook.office365.com
 (2603:10b6:5:190::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Wed, 31 May 2023 04:29:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT070.mail.protection.outlook.com (10.13.173.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Wed, 31 May 2023 04:29:15 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 23:29:13 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, "Harry
 Wentland" <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Fix up missing 'dc' & 'pipe' kdoc parameters
 in delay_cursor_until_vupdate()
Date: Wed, 31 May 2023 09:58:24 +0530
Message-ID: <20230531042824.3243659-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT070:EE_|CH2PR12MB4088:EE_
X-MS-Office365-Filtering-Correlation-Id: 9880bbbf-caa0-4523-01ec-08db618f97ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +1JCspOt5NluBPny2YxXHehhg/tBCU0lUBuQRb83e71wZV4YX1FnTaRdlMol1bPC9JmSj9mBCJazEGUOCtUmqrqpVLiKqGMfAsnxGJpetfowbgydUKFgln1gB+dJVVn0mv8oqU8QM5xgSG9q+ou9S8PwBrB6BLJ2f2bHdXIvH1yM31W0BCti5tK61+n/IZ5v3vRKHGFeIWuNABCDJEjrPmkKTewsf4S68lY+FDW6MUQi0DeDIcP3K6tWLzWVVNv18yol3ORFlNp5AkFXtdCesntS+BhYIVZu7CJhCEi0tliMrP6jPxDB3h+O2GTdLHvZ1IDaW6nANIjGXJlowevBf1YhT8qjXehtCCWdRQ+a5rYnhbh7ftdc4Rh4Qxws4OoA9Qf2P1a+RcItvEzdjgw1RVTc+Ciwmx1bFwKxZSWbAOk4B8VEEGPmng9C9KqxxeFxDLWM4pi0zltKroGE1yzU2ENiOnqkzAKz4ULQ5uf5kHZF6H67iHdgVnsQ1aBpRYR9peZ8InVd6rMIabB2DS2tGHMEzIbxb8v+Fd4uLeV/1mjOJ6XkkkuqUs5FYQdW0lcfnP091rSunV3FGIFliBqz/ECfyuqPy7bBqI/e/rj5jskbOYDkdDk7dD/jWqZl09IEHS3BxdqCgao5d08TI+xD2VKCJSjYgv9SJUqJpLFXC3SAfhne3umdoEbh6YQrFRAv4CmCeIghldhdqTLyL7HX5H5+QDW7WhbLm+zGvJqwcLGtr8NR1fNw1ZoZVSKYoybjhty/BlDVvIMf+2vGFsx/Mw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(5660300002)(2906002)(4326008)(6636002)(8936002)(8676002)(44832011)(316002)(70586007)(54906003)(110136005)(478600001)(70206006)(6666004)(7696005)(41300700001)(186003)(1076003)(26005)(16526019)(83380400001)(47076005)(2616005)(426003)(36860700001)(336012)(40460700003)(40480700001)(82310400005)(81166007)(86362001)(36756003)(82740400003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 04:29:15.9189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9880bbbf-caa0-4523-01ec-08db618f97ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4088
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following gcc with W=1:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:1904: warning: Function parameter or member 'dc' not described in 'delay_cursor_until_vupdate'
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:1904: warning: Function parameter or member 'pipe_ctx' not described in 'delay_cursor_until_vupdate'

Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 13b4e5118459..97d34cb903a2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1899,6 +1899,11 @@ void dcn10_pipe_control_lock(
  *
  * TODO: Optimize cursor programming to be once per frame before VUPDATE
  *       to avoid the need for this workaround.
+ *
+ * @dc: Current DC state
+ * @pipe: Pipe to be considered for use in cursor
+ *
+ * Return: void
  */
 static void delay_cursor_until_vupdate(struct dc *dc, struct pipe_ctx *pipe_ctx)
 {
-- 
2.25.1

