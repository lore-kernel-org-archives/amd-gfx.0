Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B052ECAAD5
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:52:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E045510EB8D;
	Sat, 27 Aug 2022 02:52:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6802D10EB8C
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:52:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cxmy20QAychPcM/hBvQ0UZzXTGxW5ITUs1d5zeUp5XHxBKXHpDzpWQbVY0SkbZchtQGod9pUBrwFdgm1of8bNPh5ylaZKytsqcEKFfh7mk8rje6zsf+mQNISORRDNVac5zE1OPFuOEgWWkjox+GDD4gINfB1abdKihTxI4LV35xgELYYOAddOcuT0TMz4ShKS2bT2xD2SYvdvGrlO3n5GwEYnpOjEGFAJsbBPpO0CkQqsq7mtWYF2+lhWVfaLszhzcsDtFZOMk61ZWmfspHLrdrHqAFqi5ose7HrhMtTZ5Fmbnsp6XWYo4tuDmqyrksksXK0ReYgi0mB2F+5T9jicw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGsIIIYP1OsuQFd/QfLQt5jBD74OYkBRq63gRKNHU8w=;
 b=gpBVW9Hci3xe57sGJ0g7AG/8AJjY1B7vut9ZSXRmpEkI64fOL3gYlWKxEFTGwMvpynxxsF5pCROn+NGHrwKHdOjIGSA21lhfHyyZ5I/ONZeKcSXrI9UvBLJkp70tJyg57FlGc2IffiPL0TMkGW0SJ9Qc8GBbGBpUiujjXVT5Xiy4AcTCqXv6M3o/8NSPFgZ+immeOqKWV32+OQIdfybuwc6WjKMbwE9Sg+jSI/mNI9rVz+87DFijA4Y5aZ+SRWKopay1tfio0qNinEQ1rzkFX9vPfPyJUkn+bcewPZW/CtyrJKrI/1zakswro/ALI+nyZNv5z1i8DRRC7PYgMzqdLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGsIIIYP1OsuQFd/QfLQt5jBD74OYkBRq63gRKNHU8w=;
 b=0ja5DFHWUS7y4I5DhQOApyLXm2iCON5n7FPW2SzhIlgl7mJS5cRNohQZwcXw3fLs5088bepQ6HjHVyqviuazHnDRzi7OFv5qvB7MlbYKu7GlRWDDZDugbHFBGvQfrVRGT/rhVlKcsKM/vwpsreHtbjjtUHkN7l+AIDLdahZTDLs=
Received: from DM6PR02CA0122.namprd02.prod.outlook.com (2603:10b6:5:1b4::24)
 by CY5PR12MB6298.namprd12.prod.outlook.com (2603:10b6:930:21::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sat, 27 Aug
 2022 02:52:34 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::73) by DM6PR02CA0122.outlook.office365.com
 (2603:10b6:5:1b4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Sat, 27 Aug 2022 02:52:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:52:33 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:52:33 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:52:29
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/33] drm/amd/display: Add comments.
Date: Sat, 27 Aug 2022 06:50:46 +0800
Message-ID: <20220826225053.1435588-27-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98141fdd-50ee-440d-9c01-08da87d73135
X-MS-TrafficTypeDiagnostic: CY5PR12MB6298:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BCet9aSj475LgIoGYH+X4A9EqWF830oDvWhCvhigMADVVdjOJGcQ1U+J81lDVNt0iWKNwrPgSwLacQT9n+Z5EFt4DHMXwMqt+vRAPdRwvFylGJ7hR1/Dnv+AdyZAKy+jlra0FJo3l/qZeDRO7WPe9JxysGE00YQ70mjB2DG2Ts6uUpAjai6qpfBvPI9srhptcKUuU5KHQcxggBcFa+RxfAAVMyAEcEfNXrWbdkN5AOOkr0Yqq0UGHxy/tQQBtCGt0lAhQlBwRvHRaiM/bky6ZYQO8w4INW0jffcnL9nmihbF59+Cvma5Di8GDxhCz3I7ygtWgz9AeQCmLoaFWcrBj/hr7U0XQkiN7kQL9nfslgIJhdOC5nCrlHNePnEdLvVSHP5qQkXu5tJ6DouQ/x67kY9bKuv2ANL2vPtAi7gPvDgjT88/cxHQUv+dNQpRUtkLCn3eLNMUE3rX3URWVoKGupAU120sRZnAqOQRZJrbCr4KD6TXWd5JjpYxhU0nXO8y/NK/MFs8l4DvhW2x/95KBJgYkPkActtDIcdFvfR0OvRkgbsyqNp+ia4i4vjKhCxzXSBeuPgdK6W9cCwqKln66E5VeELzLih6hJbZNMna4sMmBAF8wVkhhof08hivoE+B0PaO/Wimrxh+5V0GrG1jvqx1WOVqQCUfVDuHhwr0TxalsSQp1WYSkBPzyAwytlECzP5GGKYJv/9cREmNi59BnpXaba3ONeOhq/oi9ktZ2qgtjtPn5tvNfT4oGZrCUfc1kAPF0Qgu/aMot7v+cuVLb3D7nZGK/e7JStF6WYFQjPxkxLXlmArUXV1wp29jbMM0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(39860400002)(376002)(346002)(40470700004)(36840700001)(46966006)(7696005)(26005)(36756003)(2906002)(82310400005)(81166007)(316002)(36860700001)(54906003)(6666004)(40480700001)(82740400003)(6916009)(356005)(4326008)(8936002)(186003)(40460700003)(5660300002)(41300700001)(336012)(1076003)(70586007)(4744005)(8676002)(86362001)(426003)(2616005)(478600001)(47076005)(70206006)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:52:33.8724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98141fdd-50ee-440d-9c01-08da87d73135
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6298
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
Cc: stylon.wang@amd.com, Ian Chen <ian.chen@amd.com>,
 Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Dennis Chan <dennis.chan@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ian Chen <ian.chen@amd.com>

Reviewed-by: Dennis Chan <dennis.chan@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Ian Chen <ian.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_link.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 43d250918fd0..3f64b3092692 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -117,6 +117,7 @@ struct psr_settings {
  * Add a struct dc_panel_config under dc_link
  */
 struct dc_panel_config {
+	// edp DSC
 	struct dsc {
 		bool disable_dsc_edp;
 		unsigned int force_dsc_edp_policy;
-- 
2.25.1

