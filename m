Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7A5C7EE23
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 04:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A16A10E338;
	Tue, 30 May 2023 04:56:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DDB210E338
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 04:56:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VriSM3LKXTWj9VkJgnL7zQasGEVBJ5eW2cwKMRwhTEw6T3af8qoCuVOpJfiCvDpcMBbljN3N8+FrB0fCgmqPne5GYYQCx3vbpUdZsbmIJ9vB55ubgveCBqVfeha8IjmYXd1psbklwVCttraAU5bhtC/6iZdJJZzy4NPJEYE8akP2Rx2ec45Cur29SuhMXVOBfwdLlYb2tNi0YFQrydi++3ca9pextsf2LrCWnUgi9NP022xJlKOT+drV7UTvh7eoea5Ynsa1h09RRVCBJCa7n3iKKVyoF/m67Xd1lTWIbwSK1zFXId+ITj8BZian/rTUqjDW2OgVITEPed70rQDp1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cb1FCKNCHu/d7DNVaAACyI6CyuTx6FUZ1oi/Az6sqmg=;
 b=jX0YJmq8hl4TKv50YxJX8rOf736QPgFXnY2+nMfhnqV4XytReJU7LscC33+w429I+/Nt+W1J0a7tis5EbV4NwbyNOI4HzA7VVRJe8LdAFVZEr7FccZnd7o9vI2bwaRlBxFK1gTpGpEbNdMmboF+ogKI7vk/oLX+1rO13ick9XKcNIe58KcBoozvOhDXsYWVXaNVz0u4pMS0QMM/jgNvDxbZij2sFoD4NM21og5UFsQPpBzB1OIeafOY/IvvIgs4Y1CeFm0zh2BcnrCA3cslaa/oKRUVt7iUKOCA92suHpXHjtzPOn8kC1gzdYPHLa70jYwfcsMl1NFahHorB4cyX5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cb1FCKNCHu/d7DNVaAACyI6CyuTx6FUZ1oi/Az6sqmg=;
 b=XGkdKlwwkk20RbijkpM8LGPOUoz45tOpTD5hRsxWo2HNyEUP4ipguP8+ziXZ5+m+hs1zMr9P+xGESlrmTUQLHscVJmdpRrwk4GK2HJiUK8aoruMVEjs03L6i2CxYm6oQ/vr2U63qwvlOuhNdBvz1wdv32yz2A0ij4hvAc/lWefY=
Received: from SJ0PR05CA0081.namprd05.prod.outlook.com (2603:10b6:a03:332::26)
 by PH0PR12MB8775.namprd12.prod.outlook.com (2603:10b6:510:28e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 04:56:07 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:332:cafe::2d) by SJ0PR05CA0081.outlook.office365.com
 (2603:10b6:a03:332::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.21 via Frontend
 Transport; Tue, 30 May 2023 04:56:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.21 via Frontend Transport; Tue, 30 May 2023 04:56:05 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 29 May
 2023 23:56:03 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix missing parameter desc for 'xcc_id' in
 gfx_v7_0.c & amdgpu_rlc.c
Date: Tue, 30 May 2023 10:25:50 +0530
Message-ID: <20230530045550.2267049-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT054:EE_|PH0PR12MB8775:EE_
X-MS-Office365-Filtering-Correlation-Id: 56d42375-e302-4f23-a0bb-08db60ca2d19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z/SnnyUFYFsACfvofTIruGzpKFY2K/8/qM5K01slsl4yDYzjKsToNagFwSwigVdzJUVHToA616hi26SZt2z/621+k2Dk6b+KtjZEwxCTLxSyTjgFOT09ktft55Bi4B1eKaPjyyv/RoL7w6jY2FRPjz8LnbqnjiLiwVxig+AbbvfJENw0w1EOZKUev2kykZtpqcvBVeQu3JHtJhejefR7EKCm8bopzu8GzGWKXC9uWge+DuYfUB4Me5UwbTbJhoKszxxYr0PcyWKdqGFZZi1txeUcxf1M52D6raOtYYZNXGbMWAn99zRL6mvMBUcPIErWgEQtof1I+pO5Q37smDdbz6/E7gNxkuxZ6l3SQEYc9KkSa7rdmYtiCuo+ScgvNN6gweolchgtAfoTqbkgvJQ305QQku7lVliUbCY72jSXGtT7qSGy/KxUcaGaDunxc/84oApJQVhyZPTTAfbe9HQ50l3lPv/h1O9hj8yp75/hdKkyk5QVPlEhna2b3X/nBPeP9rTqp8COzkwPVBDaZO14Gzt7AIA+vVCAtvpoV5AGAViwc0X8Hc8fwJ8TkCVrH3/hYxf7Vob/HdbPdyf6HQG95a4foqX8KuwD8It9tIhaEvd3FfqyLs7lC1vISA/VO70Ec1Sa0L4/CuVuFViA1LBeYidqn884RoNyHh+dhlBzpkp8tr2lJ3Pz/f2l0J5VwE/VVqE1CHJmxj8QCoK09PyZFWxgcbir49jJq03nocEFCYk/k8kLO2qoqJDIr5OfZm+95wU2WImCcBD5JYZUM0GdOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199021)(46966006)(36840700001)(40470700004)(1076003)(186003)(110136005)(2616005)(44832011)(16526019)(26005)(2906002)(336012)(426003)(54906003)(478600001)(66574015)(47076005)(83380400001)(40460700003)(36860700001)(86362001)(7696005)(8676002)(356005)(81166007)(82740400003)(8936002)(41300700001)(40480700001)(316002)(5660300002)(70586007)(6666004)(70206006)(36756003)(82310400005)(4326008)(6636002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 04:56:05.8590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d42375-e302-4f23-a0bb-08db60ca2d19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8775
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

Fix these warnings by adding 'xcc_id' arguments.

gcc with W=1
drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c:1557: warning: Function parameter or member 'xcc_id' not described in 'gfx_v7_0_select_se_sh'
drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c:38: warning: Function parameter or member 'xcc_id' not described in 'amdgpu_gfx_rlc_enter_safe_mode'
drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c:62: warning: Function parameter or member 'xcc_id' not described in 'amdgpu_gfx_rlc_exit_safe_mode'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
index d3bed9a3e61f..35e0ae9acadc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -31,6 +31,7 @@
  * amdgpu_gfx_rlc_enter_safe_mode - Set RLC into safe mode
  *
  * @adev: amdgpu_device pointer
+ * @xcc_id: xcc accelerated compute core id
  *
  * Set RLC enter into safe mode if RLC is enabled and haven't in safe mode.
  */
@@ -55,6 +56,7 @@ void amdgpu_gfx_rlc_enter_safe_mode(struct amdgpu_device *adev, int xcc_id)
  * amdgpu_gfx_rlc_exit_safe_mode - Set RLC out of safe mode
  *
  * @adev: amdgpu_device pointer
+ * @xcc_id: xcc accelerated compute core id
  *
  * Set RLC exit safe mode if RLC is enabled and have entered into safe mode.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 0f0c12bbe228..7b3f13221c0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -1548,7 +1548,7 @@ static void gfx_v7_0_tiling_mode_table_init(struct amdgpu_device *adev)
  * @sh_num: sh block to address
  * @instance: Certain registers are instanced per SE or SH.
  *            0xffffffff means broadcast to all SEs or SHs (CIK).
- *
+ * @xcc_id: xcc accelerated compute core id
  * Select which SE, SH combinations to address.
  */
 static void gfx_v7_0_select_se_sh(struct amdgpu_device *adev,
-- 
2.25.1

