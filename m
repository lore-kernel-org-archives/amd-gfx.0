Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4011CC6FD20
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 06:52:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9C0110E4E8;
	Fri, 24 Mar 2023 06:52:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 055C310E4E8
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 06:52:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwPFDJVQ5FGNS7GwJ3rZ+G0fve3i0iJfnHNlUKZ+/a/fE+hV2/0HJwf9sQS8kYAX4emvWpCU+BKKSnh3jZDFN1SQfpp+YOmnFHa2GhCbqdJvJuVO59L/Hve3z/aForAkefvsfmFFqytWTVHRGoss4Qhg4t2c+U7KI2MqMAiRrHc3qq43Vzj3Z8E3eJddW7mhofs/EU1qBAupCoWmO+9fFzMw/uaSYkxQuCpvCnEoZpwwClPAAwLE+nKLDikcMHBuh0Cc/fz9QHXgV79pc2K514lGLiWjkih1i0GLF2XT3PhKhD8OPoLbrwQfyxGrrH/TReAcSLgiZKktJ2Rsx94r4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uau7Orrotbu3+M+U5bWZ9igbp+nFlgy/fDNWiCzVC80=;
 b=G773IifwXbLB3h4i+Hwr7aON612kNMx/iSb/DOtiwocyWdA8QxKu3CMLDXAcdAECqPmQcU3buCXaQGCBns4YOOS+6Q9Ysg23ZjqU6VjZ1HPKHGP86dfKFEFd8jPjPS8oiwOPnpCNvG0cyg5jMAgTwtPAvxSFJ4Ux5OPNVPXeDcByzLd7QlYdgMs8KYU31PKYfs4/5ERDUBy3wQBwRurceswl04IF+4gPHQdg5XXHlwWBRxqY7LsQqNF31ZKiGISCdsvkXiS+xNMV6QAFF7FcOkcf2/qABwAEHpqDi3BZhlMCn/3pWL2/0NaRzAme9PFTMMwg13RQFhVMa9dtjKjFiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uau7Orrotbu3+M+U5bWZ9igbp+nFlgy/fDNWiCzVC80=;
 b=pNA63fN4Wblg42XWBZh+D5Av10kVQPNCEaqbbHuy8/3UP3CXRbOsmTLkdjt07WaCi0kdI4x8X9kT1D2LTJB+z/WKGYBmnnILd6v9B0rrfGs/1S+2EJ+QVsHg7EPbUJyy7csoka5WxfUVztzsw0gIsRfxepdZy9SVgOPKY/wPG9U=
Received: from MW4PR03CA0153.namprd03.prod.outlook.com (2603:10b6:303:8d::8)
 by CH3PR12MB8281.namprd12.prod.outlook.com (2603:10b6:610:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 06:52:35 +0000
Received: from CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::44) by MW4PR03CA0153.outlook.office365.com
 (2603:10b6:303:8d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.39 via Frontend
 Transport; Fri, 24 Mar 2023 06:52:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT111.mail.protection.outlook.com (10.13.174.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.21 via Frontend Transport; Fri, 24 Mar 2023 06:52:34 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 01:52:29 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/19] drm/amd/display: Add 90Mhz to
 video_optimized_pixel_rates
Date: Fri, 24 Mar 2023 02:51:00 -0400
Message-ID: <20230324065111.2782-9-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324065111.2782-1-qingqing.zhuo@amd.com>
References: <20230324065111.2782-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT111:EE_|CH3PR12MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: 82da4514-0a6b-435d-ee1f-08db2c345907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GnaaGKgIi0lRZavdFFkz6a2pyKHmJiz/mwMD7fK3V4Y7Bc3TpEzwbTsRDm8tyy9aZ0XqKQyyAzI/B3fDVXl1kL3IEAdgs2eAPKuibuvV1YULqBkXpDlAC81rzRKfyjxNhh6SrjrdSUkxb99T5ROCqFe6DmpYhDdPvsATcu8Kqv98ZdP/r9JEhSplDlHiX5qnGq/Tw4pWLLvd/4jCaRvV3305YBNCV2HlSP6h/fM1q5280ywvIhcfz/35qcTV8B94R+wjqVy1rG0jg0NUTy8n96EkhMx9Q5k6gpfA3JpdhHr4UYtZVHalC0bzB/3cLWPJ86xXw1kU8V/oxxAweBKS1G39kNSD+jxJbQQtpEIjDgjZHRdOxA06UfSnI8q/bRS8BgeUgz9y5/JNQj3MY8DHZwKidTzvYpP34meigj7TZ1y42Se6Fu6SjA3x05P5NvwtzPLZSwFk2LCWYrbwgX9DaiN5yhrVYfJZdDTWHgsLArheTmYdSA6Hc8zic9zFh617EPpIWs1StjSVa8rxQtxV4dNnQFmKecd8qRsKaW6MS7D4Gmt59gIaaHh1fLJcF5JLUR3hEZTBgjRQzJVLjzQggL3xmINJAwxGSM5S8u6r7Greu6suuDqjyNkrWQT0wlcaI3bmfv6CNDAky9vYx6iuem1njpaXplRKFt4rExuyNdeViOUdiE5l3IDDgV8myZOJTFt3M2Rb8o3FT8BhYNiN1c+DdjU1qCyDf5tCbpRGAeI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199018)(40470700004)(46966006)(36840700001)(5660300002)(6916009)(4326008)(41300700001)(2906002)(40460700003)(44832011)(36860700001)(8676002)(356005)(82740400003)(81166007)(86362001)(36756003)(1076003)(26005)(6666004)(316002)(478600001)(70206006)(70586007)(8936002)(82310400005)(40480700001)(47076005)(54906003)(426003)(336012)(186003)(16526019)(2616005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 06:52:34.5264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82da4514-0a6b-435d-ee1f-08db2c345907
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8281
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Taimur Hassan <Syed.Hassan@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <Syed.Hassan@amd.com>

[Why & How]
Needed to get certain EDID to light up during TMDS compliance.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 67e3df7e1b05..462c7a3ec3cc 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -1157,6 +1157,7 @@ const struct pixel_rate_range_table_entry video_optimized_pixel_rates[] = {
 	{25170, 25180, 25200, 1000, 1001},	//25.2MHz   ->   25.17
 	{59340, 59350, 59400, 1000, 1001},	//59.4Mhz   ->   59.340
 	{74170, 74180, 74250, 1000, 1001},	//74.25Mhz  ->   74.1758
+	{89910, 90000, 90000, 1000, 1001},	//90Mhz     ->   89.91
 	{125870, 125880, 126000, 1000, 1001},	//126Mhz    ->  125.87
 	{148350, 148360, 148500, 1000, 1001},	//148.5Mhz  ->  148.3516
 	{167830, 167840, 168000, 1000, 1001},	//168Mhz    ->  167.83
-- 
2.34.1

