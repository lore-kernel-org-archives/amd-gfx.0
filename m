Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC4BC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 22:59:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D693AA4B4;
	Fri,  3 Dec 2021 22:59:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70293AA4B0
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 22:59:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyCsRpE2RDw8fPEbcoVB+ofknoE8dm7o5JQAnOosljdWGTEaCfTCoxMUiWu/18FgeFNbS25kJz49Jona/jNy7+qC4P2Xu54mMSltuSlUaRv1YjQ2kSxE7gPD5WVp9R4SwGbb8xwWhPEFvg+lgVRVwj+fWe0KH9jgjcGPvG6p70iENzL2fyy9DWAjZLsAuKAh5DSeZjCgHmQyrtzICkrJ3qHq6QqfGRzxGSpbsE7HKh93iWKVVhsYo45tPHhk0ZGfCbW6vHK0y2aPuqB8x+RkOF5WxwXUnUpsnaSwTKMmwGDDzt82dw5i/g3ZDsrPRjXKBVdWrpN+plx0XMNDcHePvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5qgmnCxpCzKOGH3dEYFiQVw0Aad28y07iWTk/kADBE=;
 b=b06b6Ag5/EOU0+aYvpEzs608zMYf2Ku1eaHHVZgfz2Y22AhGtFxIf+XFn757x4/OBryrmwVZd+1WiU0q7U3I1x47/q2/8SmFi86D11ufDrIphX+LCHUFgKtN9MoqNM800e7pSUrIEChPoLasylOXCk/6d7uFnW6uCxuVMgQyZrvhTP9coDO8XUTSFuT9AnKCFj5Y/9spAmqQThaiWiDI7QQWIPceoX/+VGGocpJLESv9eOauMckBVOdL0ozBh4n5eP52xwCS8s2tvBSQnztallyip7Jp+vDK/CNct0OCr3fZ9EFRmdA11Zm1YrjXU39pMyGvd1rwY181wcLYwDgbpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5qgmnCxpCzKOGH3dEYFiQVw0Aad28y07iWTk/kADBE=;
 b=foHxszCUmL6On3ktxdZyrPLECqEf/OY+W0UI23U/8e6zdCcBXk7KonXBx1pSUB/qliEtRReoa5v4phiuFLgkAEDV9+lWK+hODp6E9AKXvc6EmXE9F2Z1dpy/R2S7gwB4C0LYnJ3LVMvDPb04/MaKMnWXm7/LvTc4sfkCFvHOQ94=
Received: from BN8PR07CA0024.namprd07.prod.outlook.com (2603:10b6:408:ac::37)
 by DM6PR12MB4514.namprd12.prod.outlook.com (2603:10b6:5:2a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Fri, 3 Dec
 2021 22:59:13 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::db) by BN8PR07CA0024.outlook.office365.com
 (2603:10b6:408:ac::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Fri, 3 Dec 2021 22:59:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 22:59:13 +0000
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 3 Dec
 2021 16:59:11 -0600
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/15] drm/amd/display: Rename a struct field to describe a
 cea component better
Date: Fri, 3 Dec 2021 14:57:57 -0800
Message-ID: <20211203225802.651367-11-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211203225802.651367-1-Pavle.Kotarac@amd.com>
References: <20211203225802.651367-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 493cb5ce-a58a-4678-1e33-08d9b6b08631
X-MS-TrafficTypeDiagnostic: DM6PR12MB4514:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4514B8461A47EA477DEDB542FC6A9@DM6PR12MB4514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9L+HlaHHtWtzzynhDSFKgHUZYGQQDw3X3/9zMLNaioEf128lkhc/Ljl3fpfRgbVGxBWRM5xOe9xR1wgI4P8rk8/VAdYUh/NCx9FLx5UbiF0tbQu7UWbLESOD2TLhuM1hB9tTLeixKqr1XSluypkWSco7ukdQD8UBbVnY83D5hZusViSRrAp6aoUi3NwEZo3DepWVdGuAnIGw8Ywj54NBONCUQfsDwBBEIyyE1LMTM1WtfjSnswSngniGhAK/Bq1XzDrYKTqRpIgGKtwMuDnV4Zuyq1SpkqgkMBqZ3M9HN1i5P49HdCOn3c8uVTvdXKQ0nLlN5MXD/enViQyxXx8jrIzaJu5SwDwIHi0Ro55jAbnrTwag/VLid4Pi2RVnM9FMXiehgYvJEYicuIIaAjljG+6XLr9VmXYbFgyeFhn7Z3brwqDV7OqkQZImx2hOhRHjkMQ/xK5i3gCw5M0jhVY1V4NEEcm70gAgnRmaViVnEG0ODxCHEmyadwByYd8VAS8nT6ugvc7LL1eC+Nozr7oxzizk3r/o55LJeYWIj7YkRrj/yp08dnUZp0/CI5sFepXPpgWpodPbhFsnT9lUpcw+B+oo511E+2/nh6hWwYtb3W+ha/6lF143xWCSgZexVyjXKyZTfsSNH/kihrBK+VnnAp/1FHg8elfriR10BsS9NK3jqyLmNfd3VoQELQMKoEnv1qc6ygd5Jxz+5OwxgpIBi6qSIm3Cm3nECox7unQN+w5KBbImTMQlRt0cx5ByMyKImY3IDrlFkd9s/GrIq6Q01sYZOpvPozbStndji3QhI+M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(54906003)(186003)(26005)(2906002)(36756003)(82310400004)(70586007)(1076003)(6666004)(5660300002)(16526019)(40460700001)(316002)(83380400001)(356005)(70206006)(86362001)(47076005)(81166007)(8676002)(336012)(7696005)(4326008)(8936002)(36860700001)(426003)(508600001)(6916009)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 22:59:13.1032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 493cb5ce-a58a-4678-1e33-08d9b6b08631
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4514
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
Cc: stylon.wang@amd.com, Anthony
 Koo <Anthony.Koo@amd.com>, Oliver Logush <oliver.logush@amd.com>,
 solomon.chiu@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oliver Logush <oliver.logush@amd.com>

[why]
Need to fix the code so it does not use reserved keywords

[how]
Change the total_length member of the cea struct

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Oliver Logush <oliver.logush@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b8b303260302..1cb0a5c75114 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11289,7 +11289,7 @@ static bool dm_edid_parser_send_cea(struct amdgpu_display_manager *dm,
 		sizeof(cmd.edid_cea) - sizeof(cmd.edid_cea.header);
 	input->offset = offset;
 	input->length = length;
-	input->total_length = total_length;
+	input->cea_total_length = total_length;
 	memcpy(input->payload, data, length);
 
 	res = dc_dmub_srv_cmd_with_reply_data(dm->dc->ctx->dmub_srv, &cmd);
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 4efced63995e..8c53ce426466 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2405,7 +2405,7 @@ struct dmub_rb_cmd_lvtma_control {
 struct dmub_cmd_send_edid_cea {
 	uint16_t offset;	/**< offset into the CEA block */
 	uint8_t length;	/**< number of bytes in payload to copy as part of CEA block */
-	uint16_t total_length;  /**< total length of the CEA block */
+	uint16_t cea_total_length;  /**< total length of the CEA block */
 	uint8_t payload[DMUB_EDID_CEA_DATA_CHUNK_BYTES]; /**< data chunk of the CEA block */
 	uint8_t pad[3]; /**< padding and for future expansion */
 };
-- 
2.32.0

