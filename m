Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E215C54E94
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jan 2023 00:36:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AADAC10E8CB;
	Thu, 26 Jan 2023 00:36:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEB9B10E8CB
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 00:36:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0h6LkVTaEadgvBMa00ZeSc4lexCRibsVeywU+/kU6NQTqL7jNqkxpu4m8/WFuhA8dd08GU1JcTyPtEEtPho3L1cc5BtyLF7TH7+SszDwNilhhBISlM8brCNrbk7sBq6Or/bu5OJ5CAU3pw/7jPD7/vDM3AZqXiaeu3967sVZq44u6SqL8Fnng1hq9fFaAbKAcgAlcvJ425L9HH/ffZOypzVIlT1AqbZd9lse9owMCvbReI6EfT0Qsfy9AvGKlauHwLjlBr/3Xsw12y7B49J1OVmKDEY5tIicqKzim4f6ziVwe/kx9qbB94B2DkBF/2pzH/TGURt+pJEe2IWAK1+0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BI3AZLWLxQPnZZQ7z+FX7FhFuZwDbeJgr4YVj0f4tak=;
 b=hDAUfuRno05hmieepQxDquZjjSVkpQ4yaI1grpuH9R46jyf1f4GgBZs7r61H8Xa+ZDJtbZpOCj7t3OSZlvqIH6QwPU1vGZIHpTKh/29FhpCKfxaIsL/Hu6vxUarFYUXAUl9CzmuxIdE1bFzWRAVY4mYRVIaGNWHVriGDTU6m48dcnIxl2OwWLVO3rtS0SOC2kiIxS7G8HO0lArUMQDsZ2P5qQK30QAXIcCRIdLSKfHaBlAL77lounGcUW80qlCekD2kUsbOautKd+x7MB6K3mWUTkorTeTbVuUjqlJePGp7qQSYlNI0RHahiJD6R/hY3ODYX6gqrocc5vCf0FkgDlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BI3AZLWLxQPnZZQ7z+FX7FhFuZwDbeJgr4YVj0f4tak=;
 b=c2kPQgpgJpjBsOpPdjNDKY/7saN25lHHRFiwJhJe2NZH2ZtPbJ2ZWil8AxGAag0r+jnDJjMK2qmFbnD9MVTKapqVsT6E4Vzp1NNzP3dGDcXyGFM20BlNIHvnFeXcGriJ1maofa+x1UDd5qdMr5HHPdlUR3mBa2MS+2tcT08AGj4=
Received: from BN1PR10CA0018.namprd10.prod.outlook.com (2603:10b6:408:e0::23)
 by CY8PR12MB7514.namprd12.prod.outlook.com (2603:10b6:930:92::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Thu, 26 Jan
 2023 00:36:39 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::94) by BN1PR10CA0018.outlook.office365.com
 (2603:10b6:408:e0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21 via Frontend
 Transport; Thu, 26 Jan 2023 00:36:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.17 via Frontend Transport; Thu, 26 Jan 2023 00:36:39 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 25 Jan
 2023 18:36:36 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/16] drm/amd/display: Reset DMUB mailbox SW state after HW
 reset
Date: Wed, 25 Jan 2023 17:32:28 -0700
Message-ID: <20230126003230.4178466-15-alex.hung@amd.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126003230.4178466-1-alex.hung@amd.com>
References: <20230126003230.4178466-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT058:EE_|CY8PR12MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: b95e1bc1-7c94-4252-f2b9-08daff35634d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kA1skHQirAgQRgoi0EVI//tvlziW3MGTLjXbuXCuuzXhAJFfdX3/xqHz1jPvXvh9MqIugrD93QsSqZNMP0/LXoc7NU3rg4+pGhvSYpWEBODR+nGVPrJBPuoy+rnqC2ohX9trdsqmYLGAsZGISdWUY1jKPOEBL5KpIjKrzxnms6w00yagpHNpRs3UyStlJGZcv0R4lG1EoN5sCnyTDHOnmHkntzRD7HRo+jlss693SdUd4f86JdZNU1IQELDd2I2BuuxLj86qOUdr8C2VQQGdPw2TYyM2PsoQGsZheULZnF/SwzXp+T64PLnHfAUjjxZvFsiruAI/J1Y17iIncWNnGBqS9Nx5XEU9C/Aw81lfsm6tecYgDfR1xNDlYW8eLRy2RvSVkhvF/BsgWbPpXsp+PRcBCW/3HfyBD2pi6eWX+7TStUQpvFyE7xKbC//VkT7Cx8na5iMQQZREF9FSYjkZOPUK5SQT4VbNmiKnIKOkyc1Dns0Fd4l/jLAWMc4ohl4tglcflxe6YA6RMVM8jZkw7XIc51OqeHcss+Z+nOq43unPEAAnzap77wUYN0idArrWZMdcFPaANBlFM0hha+62URnyPuqg9CBDH+EfH8rFbsIDqVf9MKJqZOSKTkNbKiLClN2U9VJ94aYX4lkDr40rQx8uj19ddYpLIup6NrEsNShwBJl+MjSaizIK7u77AW/Bf5mu5M+mjzE2zWUGSheSI4vI8Du3Zgmpi62szJmcOoc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199018)(46966006)(36840700001)(40470700004)(2616005)(36756003)(86362001)(2906002)(15650500001)(82310400005)(356005)(82740400003)(4326008)(8936002)(83380400001)(44832011)(81166007)(36860700001)(41300700001)(5660300002)(316002)(478600001)(70206006)(7696005)(186003)(6916009)(8676002)(40460700003)(26005)(70586007)(47076005)(336012)(40480700001)(54906003)(1076003)(16526019)(426003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 00:36:39.0280 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b95e1bc1-7c94-4252-f2b9-08daff35634d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7514
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
Cc: stylon.wang@amd.com, Hansen Dsouza <hansen.dsouza@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alex
 Hung <alex.hung@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Otherwise we can be out of sync with what's in the hardware, leading
to us rerunning every command that's presently in the ringbuffer.

[How]
Reset software state for the mailboxes in hw_reset callback.
This is already done as part of the mailbox init in hw_init, but we
do need to remember to reset the last cached wptr value as well here.

Reviewed-by: Hansen Dsouza <hansen.dsouza@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 4a122925c3ae..92c18bfb98b3 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -532,6 +532,9 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 	if (dmub->hw_funcs.reset)
 		dmub->hw_funcs.reset(dmub);
 
+	/* reset the cache of the last wptr as well now that hw is reset */
+	dmub->inbox1_last_wptr = 0;
+
 	cw0.offset.quad_part = inst_fb->gpu_addr;
 	cw0.region.base = DMUB_CW0_BASE;
 	cw0.region.top = cw0.region.base + inst_fb->size - 1;
@@ -649,6 +652,15 @@ enum dmub_status dmub_srv_hw_reset(struct dmub_srv *dmub)
 	if (dmub->hw_funcs.reset)
 		dmub->hw_funcs.reset(dmub);
 
+	/* mailboxes have been reset in hw, so reset the sw state as well */
+	dmub->inbox1_last_wptr = 0;
+	dmub->inbox1_rb.wrpt = 0;
+	dmub->inbox1_rb.rptr = 0;
+	dmub->outbox0_rb.wrpt = 0;
+	dmub->outbox0_rb.rptr = 0;
+	dmub->outbox1_rb.wrpt = 0;
+	dmub->outbox1_rb.rptr = 0;
+
 	dmub->hw_init = false;
 
 	return DMUB_STATUS_OK;
-- 
2.39.1

