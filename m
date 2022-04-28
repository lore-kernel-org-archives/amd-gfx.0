Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB40C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 18:45:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CD6910E996;
	Thu, 28 Apr 2022 18:45:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3B7B10E990
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 18:45:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncgk55lbziOO8VFILjoRu7/wiJ14HAsGz8IRX33OFCK5dNeubMFBL9DPscM1JGqjxq3TnvOZ+l+RsY8fRgVn21nksNQpu1009C1iElTbnLE7shmvveF0glGcaH2HAEJEJHWARGmfDC9BOm7IxB5m/G/oidLgqhO4MQhOQxfy9jthIf8AeXWnvhYYCmCsVO583e88QnwWAFB+OZn/rW8JdLMFwRVkiffaSNMaHfICN2r33gNNBFasBlqYNOJyDi6btV0c1NSoyepn56ot3xKsNP5WYYenvA37vvwK1Osg9H1XyMBtqNT3LGXFQiDq/4tuYBTVbt65UgFuZwrWh6V0YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ijwl77C9paiMruOFMgdiAI3FJZFEfArVccNDcA+3bB0=;
 b=ThTi/LTG71Yrf1KSTzQUEfu9A22TLyE9WZnTwF3xDT4QFcateoRL9q/ZiF3wZpyec8k0xy30z3YMU2aSPPfkDF88JduBA9uOVirEqn8/2TaDjFrox3ibXtzjfIz/w2VdgrNck661V8N7NVbssLtnSjg5ipBNJdZ3jiSaoySR7ouiAnqeD7UveVJGw1PzNAfNjlm/NjvhcCqOsPnrmWLTtFYwgg2/1D+BPQiRHYk19mtAOooNnjoImLdE9doDxGFzzCslOutPmTUlwxUfkPvwzXM7N3qAVObqaSBPN3GaSN/nw6zcJGWAgnoOINK/8C4MKk0Zh3NSeRa65Di6gRb95w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ijwl77C9paiMruOFMgdiAI3FJZFEfArVccNDcA+3bB0=;
 b=YhVNQH8Ppd1qa1BteSn9OrFdHFhHgAJV1V8On8I4WdVWGabN2OG9oaOxY9zsC5f/M8hw78EaPw3NXqTiUBUVo87QRUtmvlSgv01eeVG9Di/SBngo+MiOkMkdEBjmrrKYjVLhYRPWo2hiECDH7td6CZJbtcXsHcbLAwsKCP9qnEU=
Received: from DS7PR03CA0188.namprd03.prod.outlook.com (2603:10b6:5:3b6::13)
 by BN6PR12MB1889.namprd12.prod.outlook.com (2603:10b6:404:105::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Thu, 28 Apr
 2022 18:45:34 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::67) by DS7PR03CA0188.outlook.office365.com
 (2603:10b6:5:3b6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Thu, 28 Apr 2022 18:45:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 18:45:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 13:45:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/7] drm/amdgpu: add support for spl fw load on psp v13
Date: Thu, 28 Apr 2022 14:45:16 -0400
Message-ID: <20220428184520.651971-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428184520.651971-1-alexander.deucher@amd.com>
References: <20220428184520.651971-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac9986a4-1f6d-49fc-f3b0-08da2947476a
X-MS-TrafficTypeDiagnostic: BN6PR12MB1889:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB188904CB010601FE66E88F02F7FD9@BN6PR12MB1889.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TTW505ajHnnKp1re2yh4D9rWDdXxq96GaPmiiVDQL/jTvdZkDLuiYVc85oxuD9GWEI6G5nwhLbvGVwE/koXwYF4nId2dIJWzszi/dUvyIv1LVrkU0/RD9moBlHMhRcGU3QLjOeVzuhdnk6r9P5dGhv83EsSXqhqvS6sx+BfwHVfe2eW/WCl/LAuctwnaD7FNC354P1Y5JMVNU5SI2VogPKHkewl0BI+vHc/F7YZE2TIF4iUK+f/8ynVfjJck6F7qQMPzQWyA0mbo5g5zp8vMQprJJUsnOQutmg3CXxwchzNGtFNMaFCk9zifrAupO89tQ0XGw5m8tr3azh23kp6OR1Y82pp1LmEVlABi3e4VhDY4jsESUGsAH569T3ITb7mN1NAvz6vLkEtGlbShVUQ4iytSbZYEzUzJ0v4ASb7g/gYeW6c2HnitmugQNM2euJTKyofVthnoklNI5RRLiodFBcXJ1TSI1n66IDx5eXU0MKVbjSzXDlGUz04o1IroQ8mS19YvnkiHCyhFrqs2BdAEWiLVDjuC+5sK3coogrcRmr7Ab7hSbUGxCaHixzZOf2OVHLE1Q2irOR/qEDlFJOn+AH6LBfH/FnIbX5hQRiyfuFOeoUxeP0+ZOYL+/hWck1wDgsRxrT4oFLY/rQUP52eL11esvvq8NQdFjn6LZ6fqSxP1ih7pkqe33PrRwMfhDIy4MwnGdvHe/wgLAREHv/+2wA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(26005)(6916009)(54906003)(36860700001)(36756003)(81166007)(1076003)(8676002)(4326008)(86362001)(82310400005)(70586007)(2616005)(70206006)(7696005)(40460700003)(5660300002)(508600001)(186003)(47076005)(316002)(426003)(336012)(356005)(6666004)(2906002)(16526019)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 18:45:34.2861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9986a4-1f6d-49fc-f3b0-08da2947476a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1889
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Support for spl firmware load on psp v13.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 024f60631faf..f951dbf21af6 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -174,6 +174,11 @@ static int psp_v13_0_bootloader_load_kdb(struct psp_context *psp)
 	return psp_v13_0_bootloader_load_component(psp, &psp->kdb, PSP_BL__LOAD_KEY_DATABASE);
 }
 
+static int psp_v13_0_bootloader_load_spl(struct psp_context *psp)
+{
+	return psp_v13_0_bootloader_load_component(psp, &psp->kdb, PSP_BL__LOAD_TOS_SPL_TABLE);
+}
+
 static int psp_v13_0_bootloader_load_sysdrv(struct psp_context *psp)
 {
 	return psp_v13_0_bootloader_load_component(psp, &psp->sys, PSP_BL__LOAD_SYSDRV);
@@ -457,6 +462,7 @@ static int psp_v13_0_read_usbc_pd_fw(struct psp_context *psp, uint32_t *fw_ver)
 static const struct psp_funcs psp_v13_0_funcs = {
 	.init_microcode = psp_v13_0_init_microcode,
 	.bootloader_load_kdb = psp_v13_0_bootloader_load_kdb,
+	.bootloader_load_spl = psp_v13_0_bootloader_load_spl,
 	.bootloader_load_sysdrv = psp_v13_0_bootloader_load_sysdrv,
 	.bootloader_load_soc_drv = psp_v13_0_bootloader_load_soc_drv,
 	.bootloader_load_intf_drv = psp_v13_0_bootloader_load_intf_drv,
-- 
2.35.1

