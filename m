Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CBACDB483
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 17:42:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A97210E446;
	Wed, 18 Oct 2023 17:42:50 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D07E10E422
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 17:42:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bujjy/1VsmwtlLolEt+33OHflGDa1CN+HcF7UT7RC8KC+HpCmL3U7KaoqjGdcPwZgDyDdK5j6+RVu7ktv0l+dU/nkVqFavHi0U0HZCPLgm3FrjWAn763gMfHYDrZEtkHap2n653z/hvghlf3fmnMdSKAUB9EkuUdyaJXeJlp3eQFtt40qbIEYDdZqJkQNYIsLNiOeCJi8/NQ5QHYXmrU/n9VCsLN5uv0rodW3pTGHWn9w7FU956TKnffqWksFnd9NW95wdNcgByfBloggPwHeZWAzkHhj6D8S9doSHxhQl6CXbPAzcFi97JReek2Xy8HhRYQZ0Zw7eXkBcQlzyjHzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vc/8Ss/IuSiEoONLEDvfcP0e5faEN09JSzD6grv2c/Q=;
 b=Uj4PP4zqcQBIB04iBsdcmUyYiUycce25GPjcErnvSy5AB9KJqwOD/ak6JtFooSC4d3eOxbRR52mUhcRW0gVuDrSjYEF/3V7TcJcrypSKBbvOZMlfiVjk/M4ezANJ6/ufNT4EQTeSVn/1drzxuFHkIDWpLRjHMJqqGfimX7nYIX4zihiL1cg2dvPEZYM+PbPSt7l8n8mjuH3zj/YNDRtpscVhTuZMqoQEzUOhvHR94bwstRZnCyA0FPtW6L9ObMbue1TKaZILEnGI1s5DgLcYIAXTTp78U9IPLZeexAybeZuQ9cGO11Wtl3QXPf1Th6e3pPY7C9MD+Tpn9VtrzfLwYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vc/8Ss/IuSiEoONLEDvfcP0e5faEN09JSzD6grv2c/Q=;
 b=DJhTpJTELAcOVk/cyna0rIPgHAMJZ6jUaIq6/w+Knt3PktlXv3cIPuWT/z1E2rhBxRb5+idr72KS1JPHmmu+bWurWYyGvdjoMlBo41apz7avFLTadEzxzahOYNURv1DyvIqyp+CAFl3Ciw81FvTChJ9KjjztlETxftAxyunV6bk=
Received: from DM6PR02CA0098.namprd02.prod.outlook.com (2603:10b6:5:1f4::39)
 by DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Wed, 18 Oct
 2023 17:42:36 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:1f4:cafe::d4) by DM6PR02CA0098.outlook.office365.com
 (2603:10b6:5:1f4::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 17:42:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.21 via Frontend Transport; Wed, 18 Oct 2023 17:42:36 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:42:33 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 10:42:33 -0700
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 18 Oct 2023 12:42:32 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/26] drm/amd/display: Set emulated sink type to HDMI
 accordingly.
Date: Wed, 18 Oct 2023 13:41:21 -0400
Message-ID: <20231018174133.1613439-15-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018174133.1613439-1-Roman.Li@amd.com>
References: <20231018174133.1613439-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|DM6PR12MB4169:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c4ee59b-058c-4183-c568-08dbd0019e11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i+Se7tZ0SNEBAbr9AUpPNFktCMGopC/Oe4LbP2tFsdQqmUXwc3lpA2xcKpbSLDp0ocrUkNzxQiAQ+XV3lb/VOyN5QBDqOaa++zWE+t8fyW9KuLBBuaWIXhPn6JFqCiVwzk0Z8Kp5RnOTj6SaTt1Ij/LyvPMwHUB59JXo718gYhXeojhOaZla1c8aQnuro/IlC4U04hHbFOl3HvmL+QRu/QzFc+VzAHeeq70ZDAVHypq/2cABXyp49zChsTKzx9OV/ysa9nnx7WzXUHMILBZeq9ukvswe6LHT0wNwjO8xxetS04eHFyYwQlopYlOWx0LzGvhJ2aRtE5kOFDwpizmRxoE6C7eBKHfL856OyTUZSEiVOUvn4zkMD6O46FAyUEO3Q687FzBSLRLX/FABXsTQs7gDIaOTbA2NApKrBNBJnATh8UglFCz8kGY2JVauYQnlLvN3ip0GIqKLenzWCJBlR69IXOvkhuVpOc/pkHSZNwODGHZJAOoyMb9SDfUYdMKmtpdlU9AURkkxCTnNaLUZkee+4S5YGWPyM4jN7gTwicTCw2UnHztae5vs6zpVEvZaL8xXIG0yHSiMT6l5BQhzBEMJuTyel/SlaU1TKO7GaA/8xkOvedHwzudzQZ7cUgEBOqNnDIhGu4RUBZ3Ysqsifbg09OTSPcDggl0uDpCYxtBqMCo59q4aA+mXzYEZoFsxKtw3VZuRkRuQbRUUw9F6NvCvpqJxKGoNjsEKKhtSSQ7p4DLL4kSHLqtDyVw97gLCNu32nDgeUWEH2R8m8+Eoqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(82310400011)(186009)(40470700004)(46966006)(36840700001)(26005)(426003)(336012)(2616005)(1076003)(41300700001)(6916009)(82740400003)(36756003)(86362001)(8676002)(8936002)(36860700001)(2906002)(81166007)(356005)(4744005)(40480700001)(6666004)(5660300002)(4326008)(47076005)(83380400001)(7696005)(70206006)(54906003)(316002)(478600001)(2876002)(40460700003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:42:36.7785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4ee59b-058c-4183-c568-08dbd0019e11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Alex Hung <alex.hung@amd.com>,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com,
 kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

[WHY & HOW]
Virtual sink is not audio-capable and this causes kms_hdmi_inject's
inject-audio to fail. Set it to HDMI according to EDID.

Reviewed-by: Chao-kai Wang <stylon.wang@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 02eca0856eca..23088ddac649 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6593,6 +6593,9 @@ static void create_eml_sink(struct amdgpu_dm_connector *aconnector)
 		return;
 	}
 
+	if (drm_detect_hdmi_monitor(edid))
+		init_params.sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
+
 	aconnector->edid = edid;
 
 	aconnector->dc_em_sink = dc_link_add_remote_sink(
-- 
2.34.1

