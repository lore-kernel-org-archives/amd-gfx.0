Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E146C77B7E
	for <amd-gfx@archiver.kernel.org>; Mon, 29 May 2023 14:10:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC82F10E2C2;
	Mon, 29 May 2023 14:10:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBBA510E2C2
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 May 2023 14:10:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZvn5BrFxoAn7Ebsnhz2E4d5oDyEB0HE6HGDuF00Ia5Ka23Lu/19XQY1R7jEwIYgAuZ6Vq8copczB6gyI+Z96vQo32Z2/62J2MoVBn6xBnr9Fckmcg4Qis+yMsJnhI5z3c6JUWmrzOIz68Wv7D3q61LzvmNrjChbTyfCO8wp1NHVIWtSMy+cAQ3EwrZcfyqQ8sWjoElG8DaG46XkX/hc36Sg6N9kOBxpNoiaaSLl6PxGQL/emAAMPYEXj7R3cgWjYT5wmVa5B/QTLAPL/SpKXg4CvagnYQGjHbDLt9D0eNBYUaYp7FjacLv9dtzu/thfoxwGamFQHnvfAz/XUyb4kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cb1FCKNCHu/d7DNVaAACyI6CyuTx6FUZ1oi/Az6sqmg=;
 b=i3V3qab9M6u3SzFXMOgU74jSaeEBF1JxCPCerzB+Mo+XwzqHDC9XfXx7MzPnDr56Xjmwrf3CCr9LKByvVr0TQfsmruYl/J85FvRDvyrVLD7T1U62YAl691sIPqF3/QK0407zkRq17vZysapSXCkbF1Un8xfyWI4iH04bnebyAFdnU5AcXVqEVMm0lnPFFC0swyZRuHZlRgIVp4N8uefEv/G2KyB5TUeT0BORhX1ZMp7JvRX5nreRypm+vC56JDaLjC3K+y5IHoHRFJifkIQ/aBDnLNUdMpgIHDnaZ2s92pAMrBRI27NF57q40o1/IlNcW9jaZtet38KEDAEFMPLq2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cb1FCKNCHu/d7DNVaAACyI6CyuTx6FUZ1oi/Az6sqmg=;
 b=Z2ubknu3pOq6jmOpsLp2Qj/YQD/NpwGgY8TtXEoR3zcxR1ltP5WVrK1cd4+Oi8sEYxf6H/iI1/O15+BmUobeTyxcN+wfysUytk/bFxiH0+2e8AtKJAm9b1rE+8ef3VZDJ9yN0IthKhv5aVoHQQXvVEIxGpQZaIjEaEFFTmgMCK0=
Received: from DS7P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::14) by
 CYYPR12MB8940.namprd12.prod.outlook.com (2603:10b6:930:bd::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.22; Mon, 29 May 2023 14:10:35 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::8) by DS7P222CA0004.outlook.office365.com
 (2603:10b6:8:2e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Mon, 29 May 2023 14:10:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.20 via Frontend Transport; Mon, 29 May 2023 14:10:35 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 29 May
 2023 09:10:34 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix missing parameter desc for 'xcc_id' in
 gfx_v7_0.c & amdgpu_rlc.c
Date: Mon, 29 May 2023 19:40:11 +0530
Message-ID: <20230529141011.1896710-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT004:EE_|CYYPR12MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ba6509-be5e-4d82-cf3c-08db604e790c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2FGtgnmPY6IQ/lJVhc9tMmS71Hl5xZLsU3VHuLEFbjySMgPt4j+/d1DNO0YaZnfj1pozuPDf3J6C/Nh0Z4JYfWYNgQS0i3H5YxKPkJjBAs4VqNyavV1ywqHeKQB7IOsCBns8UrBEfnCNBxwHjBhw5GH98us7W4nUw0s7EuHCk2gIwri8ns9dGBjOIaKIPQtV/wpqJMy9hxNIaMAEsdqtXYtHWpsTLlamiWDK2xU8L+HGawEPkfLESxr2S0Je59mjuiDDbofxZlW05kNVVI96c+N793D8SV2mwnBDLKBszgeDSqdpb8Q+AdU3uqmktAsamvef+2bNLZ8OHhWv4bY/beqrWKrfqnF4wWbpeHEaeK+1qFNxsII2/k1+yqrM5FqPh+YcHHOnKZqnEOGqrHmTbFdnLkWGKJIA/o6USrrIzGWL+Ltj2uLr8TrjQyTwRW1Pc080SmHZzau+S45v1FnKWqLl1M/LFZpEFUW2w/oYbNTSSmVsmd5J8uScAFKU0NEHEZlZbGKUqm+KLMvm0DnRZwR3SY2Vv2hLHcfKcZ2k+ez189nYXwjY8Oxb1hEve7Op/jUw8bdZiemmG/e7sAJ7U98tA/bFjYD3rQIDeOi6V6tzmWBo8ug9RjjVbUVSt/Ed5TSjGVElwS0IgqyYAX3spAmeAJFGu/GNRsUdvIJ6jDPu3bvnRgTwiML1AtIiaUAlJomDdF0192xp6GlJBVjJaX8XiolX7RFUN5RcqTTNjqNGoE3nXieCYYIaTjXRrt8yI4VqufEzcQhDTvvIGIsNpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(36860700001)(40460700003)(47076005)(83380400001)(66574015)(5660300002)(316002)(6666004)(70586007)(70206006)(4326008)(6636002)(82310400005)(36756003)(82740400003)(81166007)(8676002)(41300700001)(356005)(8936002)(7696005)(86362001)(40480700001)(110136005)(54906003)(2906002)(2616005)(186003)(16526019)(44832011)(336012)(426003)(478600001)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 14:10:35.6874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ba6509-be5e-4d82-cf3c-08db604e790c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8940
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

