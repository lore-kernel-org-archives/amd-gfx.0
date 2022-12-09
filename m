Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E37C4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 16:37:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0843710E564;
	Fri,  9 Dec 2022 16:37:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 122AD10E560
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 16:37:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsUjuVdZUvjK7pQXjJM7jhbGm4NSDZ2vlKpqhDbvFjl1PeULVqROagu5VFEMa8oIOy5XEXGQGpgfPCgo075gcL+Kt86cC7aDohySXrVgTsezaRwXG/7nlNLDhd5TTOS2EoSPqcIcsUt0SiYZqgCiJpM76rmqDMUGm7myZjQQwi201tl4oZ0Zts4OrWB5IxuMK/Bhy5wsu9QoFYt/S4hwqjVQ3LHvv+E0fCpQfAlHUisAesHtpPH36Ps8tU1tkway2/cQY1Y+ecvA67fB4U1+n1L7DHaAQuRmrvuCGGrGkdGMSYtwB0eNbDhD88hGxTACZhwwNdMswS4ZEOFuzcea1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBSwlxMSYuu9/vYZYkR3y7pmE1Ph7guFjYHRBpGWDuo=;
 b=K/bOdOuprzpI8S2Dxu9RwSylHFaKapGMuz0755lXhTYpattSbkNtCi/DfPTSliUa3PUYTW8D8bIw6qIMhpV9rqVWj73sFuop/UqdjrVZiKgSyKs+OJ0fOZcM8Rz52QBguZ/VrPgKNj6ESZ/pCi1TD3uNqMmEIP7FcRWzKuk5Yt8bcJE76iPQSjPyEkEiQjZQjI6q1lJEhNw/JwaX+3z9lpuGDSlAbdCP7XHo6/AVPpWg4d+J6kCXQ/TNfbJk9MHU627j73IKEg0mR0FPFtjfRXR50WL1v+8ChPSrkDM8X/XKOikBZk6BRYbQVAf3co4d/DIbpQlupphKzppRgodPCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBSwlxMSYuu9/vYZYkR3y7pmE1Ph7guFjYHRBpGWDuo=;
 b=udWVoYly12/dRqaAemKzCBoBy3KaLsVJ8xon4iQAiVjOEhCbzVfO2fKiqrkSia9taii0dmZlMljSIziJm/9cGRQp23YWagBQckXbaidCEkhpIEHMP763kKuQSthuQTj7aL2U/oS+oeNuRE7tEsFc4sQZjQhp7XCJfp2gMGTt0So=
Received: from MW4PR04CA0106.namprd04.prod.outlook.com (2603:10b6:303:83::21)
 by CH3PR12MB7570.namprd12.prod.outlook.com (2603:10b6:610:149::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18; Fri, 9 Dec
 2022 16:37:22 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::58) by MW4PR04CA0106.outlook.office365.com
 (2603:10b6:303:83::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18 via Frontend
 Transport; Fri, 9 Dec 2022 16:37:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 16:37:22 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 9 Dec 2022 10:37:21 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/23] drm/amd/display: fix warning in
 amdgpu_dm_crtc_configure_crc_source()
Date: Fri, 9 Dec 2022 11:36:30 -0500
Message-ID: <20221209163647.25704-7-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209163647.25704-1-jdhillon@amd.com>
References: <20221209163647.25704-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT025:EE_|CH3PR12MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ac9beed-adc8-46c7-55ae-08dada03a5a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rwZeT5Gil7XrFjTAVrOH5RTOG5bXEKJUtUqc3OVU/pnGGoXbcEWgcyIm72UoStSLiwAoN/F+kR4y4QPuIjtkW7KlohbPFJP9nV6Z9LgXUyb2uZUd9TYc514DKX7To9C7SQ0peBakHobw1ITwsDPOImC66QSboXdew5RM4SLjyWBZcj7teKdFkSJUVKen+y5EDBnywxYRbTgGxcbgVGmALsvhHTsN4FyZO/G3ILeWmKCFI5HOv96M9pChaSC6Isv++2ciowqZTgS0i8rj1W6ew189pHxnPtPjmGgat9+XFHRQhhjwrlHyl7GSHuaiF8AB7JwTe5uGWVs/DFLDRs0e1BCUlFNWiuou3khhU6c8QhByZF2fIpY8b2cZbdf92zgPi+RE2fRqG7UjJ8Txxmlv3EZBmODqFmHvVSacjlPcMRe/jZb8sssr03EoY9acy+8zbbsh+eOdDZxe5atl6T5Pks1Zk7Tl+0FL5jhI9F75KveX85N+HFP0/o95SjA7eh6m4Ej1bMMMNvszYX9ZSoZ79OxKsxSFeSYze513/f2FbB4M9KZVnKk/cle36igx+2+mdTDZZNhukm5tdx5A5B0l+bjK/ho/F7E5OQxKIeMmz1N1UBifJGMYMJ9q0EthD8xdLRx2Gf0XID4wEX6W11gvBo68SB37xv/Cd57AZNUO0MfbtaQfOZoD6TbY9LR3RlRCcmegAnK25s964P1/ihj0pfUampgOjL8HnJbowxT7p50=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(36840700001)(40470700004)(46966006)(2906002)(5660300002)(36860700001)(41300700001)(478600001)(26005)(186003)(83380400001)(426003)(47076005)(4326008)(36756003)(82310400005)(8676002)(8936002)(70206006)(70586007)(1076003)(16526019)(6916009)(316002)(54906003)(40480700001)(336012)(2616005)(40460700003)(356005)(6666004)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 16:37:22.3511 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac9beed-adc8-46c7-55ae-08dada03a5a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7570
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
Cc: stylon.wang@amd.com, HaoPing Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hamza Mahfooz <hamza.mahfooz@amd.com>

If we build the kernel without CONFIG_DRM_AMD_SECURE_DISPLAY set, we get
the following compile warning:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_crc.c: In function ‘amdgpu_dm_crtc_configure_crc_source’:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_crc.c:204:13: warning: unused variable ‘i’ [-Wunused-variable]
  204 |         int i, ret = 0;
      |             ^

So, guard variable i around CONFIG_DRM_AMD_SECURE_DISPLAY.

Fixes: 98f02f4c7050 ("SWDEV-351660 - dc: Implement multiple secure display")

Reviewed-by: HaoPing Liu <HaoPing.Liu@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 733041a55ed1..8bf33fa4abd9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -198,10 +198,13 @@ int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc *crtc,
 					struct dm_crtc_state *dm_crtc_state,
 					enum amdgpu_dm_pipe_crc_source source)
 {
+#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
+	int i;
+#endif
 	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
 	struct dc_stream_state *stream_state = dm_crtc_state->stream;
 	bool enable = amdgpu_dm_is_valid_crc_source(source);
-	int i, ret = 0;
+	int ret = 0;
 
 	/* Configuration will be deferred to stream enable. */
 	if (!stream_state)
-- 
2.34.1

