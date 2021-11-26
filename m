Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BEC9C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 19:49:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C72B6E876;
	Fri, 26 Nov 2021 19:49:44 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2052.outbound.protection.outlook.com [40.107.101.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E9716E876
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 19:49:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEQHcACd882PdfBDuFC0pHX0SzOBKq4mE5sCEChMnnC0JaVQ6hYL1iVZgiimuAISKVW6uKjtWxuui9eFUMo+mtcGug9KDzgoWAcMIz603qGHoQ3DaoH/IeEMcgjQmZd5KVAPxrq92c0FFO4pJJuqVu61eXzPcncP7MFRLT6flUYov4ThYyBereABhkk3o6r817LxUSiY45nxRhoZsaeatKY+hR1h2lIh9BxtBVL2s3Ax/5s91GufX2E6QUILTZ/nCC04csu7W5vezmvnoedrhhNDezhMHumLc6ZUC9iZhFfLghsb8iglmWSc9CnCYlBxLjB0czCAJpxcILM1y6xC5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQRjBg7ti6fsLHUlR1AISTsobCMszLSxYNCSk7Wqyio=;
 b=HuKw7ErX1i5hdptgaja5jS+MtC9H7Chf3SRBkc0rO+IL+HzjCW+BFCh5PsaI2EpIRHITO6Tm6eRBVmVme9v0O+OjnChEWFvTDb0HcaeR50eOfMQdZA1f1nHYAFImoizBfVtGDZWG/W0xUQO593pN1Q7ova9+bkYl6443A/BmEqkIe6o5+Vor5/UfDDR/oITYaTqdbBbcF14vR+RGu6Md12W62Tt9B0El2K6J+8aOCkQbSHujeq6VyOAk4SNxcHUkUk6yTZh6u1uzdRMPxk1ZtXuR/dBBaGRYOJg3TI8KTHumbCBXP1gO4RXS8cLb6cX2Zrtv7xuSRKcsoU620e2Ylg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQRjBg7ti6fsLHUlR1AISTsobCMszLSxYNCSk7Wqyio=;
 b=0U9i1e5K9eUXoythmR0XQ9x0BUfoh9uz5i4pE9TqBLDQFDNLH5nc0q39efkK3tZiM70EkbSky63fW+FFr6jBdfH5QJ+ojWF1lAYhU16z4ZkFflL6aH+pUrZwUyUvNNOhXtMusGW8vwgY2QOcqIe1laH5yXTpzCGT7W51h2ohJ5I=
Received: from BN6PR19CA0098.namprd19.prod.outlook.com (2603:10b6:404:a0::12)
 by SA0PR12MB4592.namprd12.prod.outlook.com (2603:10b6:806:9b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 26 Nov
 2021 19:49:38 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::e6) by BN6PR19CA0098.outlook.office365.com
 (2603:10b6:404:a0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Fri, 26 Nov 2021 19:49:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Fri, 26 Nov 2021 19:49:38 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 13:49:32 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 11:49:32 -0800
Received: from blakha.ht.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 26 Nov 2021 13:49:31 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/16] drm/amd/display: Fix for the no Audio bug with Tiled
 Displays
Date: Fri, 26 Nov 2021 14:49:12 -0500
Message-ID: <20211126194922.816835-7-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
References: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bebe0aa-fcde-4f5f-0df3-08d9b115e195
X-MS-TrafficTypeDiagnostic: SA0PR12MB4592:
X-Microsoft-Antispam-PRVS: <SA0PR12MB459211247FF6A680F3D8F26DF9639@SA0PR12MB4592.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pmx6ar4sqWCIAPgW2gs9oHPNx36upd1PwPXaGoCdjlbpuLUBoHCyTY4E5aXvxiqpyWvWRZn4UTsU9tyt8eP5ox/FVPUKRjarA26bAO6SC/Mi54rgIfYRVnqzpaB5KEuiXG5GxUPpbRaTbodLUd0Cr200zntultPlARuSzhHSQCK+yuFw1BqqIug6eRQYsoN85nYbRZ5pOtcVpE6pSlWcdvkF1e361CIOlP/sEyJQJXNeC/Tdrd+SFjBNxJK8PbxRw0VAzUWTFrwLZCyT+yB/R0opFbtAbkB+SH/Y8J86hBLP6q5rBYFwe9g3xpZd+5noTWQRIZYgbPOzKjz4Lr3piX35MhZMXX3E6hFhzIV7k/ScfNCb+7+n3z4fE0Lq/dSG3FDkJRdU/OQ3uj4vz0WLpsx/tH1B7MQtnW8WqZkq/Mfm2NXz61iw1fm4Jxe5PGwCoq2N+f05Sbtqi6Hphs0YNEIxz2Uy44dO9OkzzQVz/UAQkEwO631PiXEYCKvK2914cOliUQz03MieBRv9hv0NrJ7y5PZgdD+q2m+gSdgCTaWBlFo4p+69ZjpIMlJ3NhNBPBAMk00keLJ9oMZXOYNx/mytmDmu2sQixXQPJ2njQaGAC6vO2XtPdtROPdUP7sS7gbCQy+RfSSw74O8ArXJCPfblbktOxxm5TnUI+Iig5CG2Y0NSv4JDhaC1HGOVTiy/fxcddAGMqu+sb3QD4CjdV8z1xSceidBGtMgvC9nma34=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(54906003)(8936002)(5660300002)(47076005)(2906002)(70206006)(4326008)(6666004)(26005)(356005)(1076003)(82310400004)(186003)(2616005)(336012)(6916009)(426003)(81166007)(316002)(508600001)(36756003)(70586007)(8676002)(86362001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 19:49:38.2959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bebe0aa-fcde-4f5f-0df3-08d9b115e195
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4592
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
Cc: stylon.wang@amd.com, Mustapha Ghaddar <mustapha.ghaddar@amd.com>,
 Jun Lei <Jun.Lei@amd.com>, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Mustapha Ghaddar <mghaddar@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mustapha Ghaddar <mghaddar@amd.com>

[WHY]
It seems like after a series of plug/unplugs we end up in a situation
where tiled display doesnt support Audio.

[HOW]
The issue seems to be related to when we check streams changed after an
HPD, we should be checking the audio_struct as well to see if any of its
values changed.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Mustapha Ghaddar <mustapha.ghaddar@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 51e22b965ed6..a2cf35a7ccaa 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1664,6 +1664,10 @@ bool dc_is_stream_unchanged(
 	if (old_stream->ignore_msa_timing_param != stream->ignore_msa_timing_param)
 		return false;
 
+	// Only Have Audio left to check whether it is same or not. This is a corner case for Tiled sinks
+	if (old_stream->audio_info.mode_count != stream->audio_info.mode_count)
+		return false;
+
 	return true;
 }
 
-- 
2.25.1

