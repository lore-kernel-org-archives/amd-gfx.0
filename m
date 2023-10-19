Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3BBCDB484
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 13:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1C6A10E4EC;
	Thu, 19 Oct 2023 13:33:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46D7810E4E2
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 13:33:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDisycGiRI/PWSxQ40gJ2sXqkQOaBf0FVjDZSJRQbeACIpzG1bzruy+Od7msQUM6KGwQt4ppNhZRIjIuNcC3n/huvHX7L7a6m+I+fDMcmC1oWpwZDebF5BOM5YpLvmZdkTVhhuwGHysaCyWrIg+3t1VmBR9hIz0DBOXtCo/IygGlw7xAmDCsA1uMVJ4HQ+QXTzE9hFeWC2h9suQSzz/peZmb/0y0bNKJhrVfJlzgHuIzh1H6ymnG3hXEk44HZuPAf3SIWe+JcW/Gt43cjxjT8E370SGFcoqJ77XQya6Q4K/ryc0QRJW8XUDDffTQUta0whXtsa+XCJNComTIhUZvzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vc/8Ss/IuSiEoONLEDvfcP0e5faEN09JSzD6grv2c/Q=;
 b=fvY+/kt/7F4scX3PnqWdmz8W07ystchfM5D93sdVjnC3VfQ7zG505enmQFYvbsfWj27CgNXOl0IVHmb1dmVKLsQVOgcI/GpZA6z4cDTdhwTVi2GvkOIHpQnMjpiVn7QxNwkVUB2TfZ7iaUwcB2l1LFJTSPgroB0qPIgn3qLWnw6heV94VcRHWsHUQ7S1bnNhuuazEGuCk/daPMPvjwkMU1CPUkYK5YG0oLHu6XSTYhQpAwzEPbTL0kQY3po0ObFSf9Xs0V4wHrKh1HtXpYjq3ERPobUo6B9wwWU1z0BVFJjVuZ5cFprzX3NtM7pQ3JEosAzSudAZSqmr9gxSxpmerg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vc/8Ss/IuSiEoONLEDvfcP0e5faEN09JSzD6grv2c/Q=;
 b=b8FQX9IeRxrqUq4GkLpNn4gB9Oj7Sj+ZwYllZ4MIZYgkKsF7ZsfPmihC9DUcIWFQPOvi8UGcTlbIsYDZJQHsFpq4ZodNWZ8+6wqoeF9B6QCL+PNz86PYAqp73/Frtfjlxqiw25njwIMsONgO1gotQXqXs03A0TJMcoXLsjak3to=
Received: from BL0PR0102CA0006.prod.exchangelabs.com (2603:10b6:207:18::19) by
 SA1PR12MB8597.namprd12.prod.outlook.com (2603:10b6:806:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Thu, 19 Oct
 2023 13:33:12 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:207:18:cafe::be) by BL0PR0102CA0006.outlook.office365.com
 (2603:10b6:207:18::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Thu, 19 Oct 2023 13:33:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 13:33:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:33:11 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 08:33:10 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 13/24] drm/amd/display: Set emulated sink type to HDMI
 accordingly.
Date: Thu, 19 Oct 2023 09:32:11 -0400
Message-ID: <20231019133222.1633077-14-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133222.1633077-1-Roman.Li@amd.com>
References: <20231019133222.1633077-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|SA1PR12MB8597:EE_
X-MS-Office365-Filtering-Correlation-Id: 88831a87-9519-42f9-75cd-08dbd0a7f085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3CGhLM1XJpJVGzKWtaw3L4C1dXXbpAkmx4KX5PAjno5eBuqfHi+i6x8oO/aCUJn1mQTZUEk65YDkHxJh53jvvdsGh2vFgE5rwpRDkvoTSAJLRdFkFn7EakfJYAnI4u7UGzMO289SoKtzuX0IXmFez6yX+JIzEaDamUIb5WgHhdcyj3I4/vkoG+160AkebI6nKxMknjyYn9iTSLZZhQkaf45/8TPSTYH6NOdAwlCqdJ8iCJqjeL9uSco2oFnpii4nwuyxyCti860pr4NyZ0GqwswsZi6KdMMqD/iSW0NfHccUzWUiS9CMhq32oRoigcxLzyT+/zuC0vLgOrVGNoaK8r1pbHCrvgSYK8OQ7V3u9CH25I4NoTfb91jA1e9q0Ud7M0BTmVM38O+MR+TJaRrQ9Vw25w1VuQyz1HayglKj/55EIVGC5AlUI8yuWLRf7LejEcsv4Ob70YN8//9NMX7aaFb+Anwkc6Iry9iZayomxNjDg2gXvk9An4qDvJ8rbsBQCs8xLt36cnURitORw4F6yaIa/GbcHubcUJc0xQmBnIaATBlCb7xTgckz2j+VjN/YVLkbPOJfj0k7n8C59zIYb4o9BKzaY5JOlX6Pgw31AeSbP0+GsQoo2NpIxXSkBVmw7OqdTqMcy5bJlf4tQFzMcl4npvEqMoew1ZmK4YAp7+pv80nz5pbOlva/E8pKSjIgGxdDqWXGHODts+Mg9Wwb7YyKirAhBi3NVzgs4za8crLevvcHEIqikkX2BfABg23QSwYtY9pWlYmqezg4X2zYkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(1800799009)(82310400011)(186009)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(36860700001)(47076005)(40460700003)(4744005)(70206006)(40480700001)(1076003)(26005)(7696005)(8936002)(70586007)(316002)(4326008)(54906003)(2906002)(336012)(426003)(36756003)(41300700001)(5660300002)(8676002)(2876002)(2616005)(6916009)(86362001)(83380400001)(356005)(82740400003)(81166007)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:33:11.5982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88831a87-9519-42f9-75cd-08dbd0a7f085
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8597
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
 pavle.kotarac@amd.com
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

