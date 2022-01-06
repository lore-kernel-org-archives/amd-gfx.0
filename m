Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB06FC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jan 2022 13:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0129210FB58;
	Thu,  6 Jan 2022 13:40:54 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2074.outbound.protection.outlook.com [40.107.101.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CCA410FB58
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jan 2022 13:40:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qt6efY4d4Kp/7JnOmpDG8wUvuLYCt5Rw6utQzGPHwbytzeiDsEl0I4ZbFFRfOGndswm0b8/m7A2yzPlT6sVa0fkbu8kG3TPsO0wHHMQIilytfL18WBanRwxJDrUXtGhEYDx2Qw3ROzJR1knsJCFJU1t0WCrysMsh7o3EZM3pguZ8RQ+Nt5UPOy3QW37DLLO88qS8StzD7oHxeqvhswCDiuX4nsm0DEmow3wwjB3Z8XJfhmS+dXhKBujadQNwa/fEj9Trgxe7MCp3coFzS5e6Enl2uVOSpdv/WWYDhBwY3++8bMQb1ASTd2VQPg7nl/mtwp3pcW7qdCPOAOH2520cfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEtPvcBK/z6J/qIN/CBbKx2kk4ZOKzbXTIIoCmgu8VI=;
 b=bOoWUHoB+Qgfit/coyEjdxaW7JZMGT8y2KdIndcaMkZPwtYPBvSh8DWdwh2d/g0fVa0oRQZm1lKkJSPwjcH41b4CU5wRXAy8vESTJ/G1RzsTLJ643/kDvNldK7i7SJFh9ovMsbNS4f0UzID120SkaAKPQYkxVinyIu8XlaK9A1gWP+ysiHuhkL2ry7ezwq4q/ga86ykrq94goytJlIqC8wGAuQP3vY3WFRBb+oddwHy0M4kvrAVW6ecN7OaefOoLyBTOVHOKiO7BMujExcSeBQHjDeRmSSkzRbBQyGbiQKfzm23miwGBvVQDKg+Ugf7jag5QO9Ed6SKm2ZCHv5CCaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEtPvcBK/z6J/qIN/CBbKx2kk4ZOKzbXTIIoCmgu8VI=;
 b=NXrolzcO0WCnSySlAjTI2FrSr/UXXYNN31R4gU+0SSxsI+iDM/OyH2OgzGMg5bQ7q3zaDTww4H0omJqtAEpPxVQq9dse6n4PePz2YZq0/d+TBsQgtToWd0SqRCFZ8QEBqIz5z+9WvzSE54L0BdtEvXCJjWwMBxhHSqPpoHI8ua4=
Received: from BN9PR03CA0317.namprd03.prod.outlook.com (2603:10b6:408:112::22)
 by BN6PR12MB1442.namprd12.prod.outlook.com (2603:10b6:405:f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Thu, 6 Jan
 2022 13:40:50 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::22) by BN9PR03CA0317.outlook.office365.com
 (2603:10b6:408:112::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Thu, 6 Jan 2022 13:40:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.9 via Frontend Transport; Thu, 6 Jan 2022 13:40:49 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 6 Jan
 2022 07:40:47 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: explicitly set is_dsc_supported to false
 before use
Date: Thu, 6 Jan 2022 07:40:49 -0600
Message-ID: <20220106134049.23608-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5edabb88-0f25-4bff-bd00-08d9d11a26bf
X-MS-TrafficTypeDiagnostic: BN6PR12MB1442:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB14421C29A21C7F107C98AF65E24C9@BN6PR12MB1442.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bxdb6MSc67D/9OfAfMGHRPjTILDxbWgIuuLNbDv8SM22s9drfJBQagCdLHSYHF7rlwvxTQu6J8KV5Z0NBtm8QQMOrhsYDYx14SGrxWDNpS63sn1iz7hp2xe+7AyJv1rC8MzBKyaJaiCh3XzeD3UBfcq57oWS50pVn3mDqooeFC0QKlPnr82uwsXw/QhFTB10d7714lZkVHNQoS/ZIjonnKbzFKr2XKG+T02qVTFMrx0MOO2pJdQ+D9E0Q1dhv9W/UMn5jhh0IHS1FMaWEev0zppe8kho94fRL5gYtFP7H/UPbSksDAMoCa4OTloGCMyX15ejnhvogm5YPCWmx/cyAAD8EV22cjjuuaYrobc9MXpFp0cdz054+UfotY93KasrZ/eONwmitBZ3bGNTzRNJ2p52ExFR2tIcUpLBPNZIIvu28HDnMoJbq/JAUqmzS8pEhxAz/9WS5pefOZXfYpvGNvTLYd7bw7MsjEGVcLv/Q1JsWkLcCSO/72+ZRmTkhTOnAaX17L+C65xoQbp5xXZB/fLplYn+QUEWiev3C/WX08ZGCRSIDZzOckijGLMZwr+iVg2zCiHKOFJ4LSJNFRxolaCCuQBDSQ631zQiaO/PsISJTdVbfzWTNlHQl9Ef3LYhFIwAxHx/vbzGxtaLX7E6L4UkV2s6eZk3Ly+uSA8AMIuSRDvNyW7IcNNxZda3bOAJo4yqfA6hmeUIHDBlgtQW22WH169m3MKl+YkOCAuDWkIEK8w5wSlLPM3XfGhaw7qhON2TRHG9Yq+UD1lNjWeuMV63KEMNXHUqsZIjlyXWeEff8VTVz4QzGhILu611Whv2kb1ndJmjRO/Wu2bJYgis1xDm7beG4FezUhAN7AzvcZKr4pD8MGKEDBVoTs52P/qM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(8936002)(47076005)(508600001)(336012)(44832011)(16526019)(81166007)(86362001)(70206006)(2616005)(426003)(356005)(70586007)(8676002)(966005)(186003)(316002)(6916009)(4326008)(5660300002)(2906002)(7696005)(1076003)(82310400004)(36860700001)(40460700001)(83380400001)(26005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 13:40:49.8621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5edabb88-0f25-4bff-bd00-08d9d11a26bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1442
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When UBSAN is enabled a case is shown on unplugging the display that
this variable hasn't been initialized by `update_dsc_caps`, presumably
when the display was unplugged it wasn't copied from the DPCD.

Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1956497
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5d20807b6f88..3d81314e6cb4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6093,6 +6093,7 @@ static void update_dsc_caps(struct amdgpu_dm_connector *aconnector,
 							struct dsc_dec_dpcd_caps *dsc_caps)
 {
 	stream->timing.flags.DSC = 0;
+	dsc_caps->is_dsc_supported = false;
 
 	if (aconnector->dc_link && (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT ||
 		sink->sink_signal == SIGNAL_TYPE_EDP)) {
-- 
2.25.1

