Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B801C46467
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jan 2023 21:16:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B719C10E264;
	Thu, 19 Jan 2023 21:16:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9045510E264
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jan 2023 21:16:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WV4guWI57x42sG2GBnmZr6KxxAmfw9AU9HMxNcTn6E12kFLKvoL+dBaQjvRA9FKjCtzQiKzv/FwaCdDNhEOiiktvSfFcepZZzrFkIBdJkyzxBFbiAfhIxXmTdraw3ECZb2dwEBxPvVtndmOwpRZIOANgVoyB9PT4oiYxnhCiOegX85oxn22lpS3ws61FwOzlC7V+u1PvFHb3mJg6Qx2R1vG0oylvWz548l4HN8n2bnHbGLGG28Su3TH5XsoBYYpS7boJ0Jqfk7kWj2qNEdsaE+R0on75sUZpsWYoylgDliUSv4YUE/aCR/n4uK86Z5dvIp3n52SAU1RzZhND7ZukIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnwzFCd9qxYgoRxd0Brq94jCqSPkuEIVxS/oLJ+Cwkg=;
 b=RH1ECiBlV45omS72sILNo/l41bH/10+02ip+4GacFaNWzLXGDbHuH7wis4pzsKBKp/Hzu4ZWMYSKMKwXquN+VTdaLLaPnQx4rPC0eOWasY/nB4KdgXTxSB+MgDXaWlTj7V0aZHx/tSJk1EWxNqF/v7YYUVWD90sx3AutaScDizJDTvIpJa7A5yLRJPJFKrNpzRtEK1ZEvunQVDb4lzVkh5+2DYs03ayC/h7Z6KFBTPKHBvMyvqHzLMVMtDigCrunO9id4a/p2G0dyYdYQnXSyC9vlNfEeWOJkg0X1moEzg18KWrf1+vTuWz5Gr8TsiBo457OHZBrzbpi3fY1DuzaDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnwzFCd9qxYgoRxd0Brq94jCqSPkuEIVxS/oLJ+Cwkg=;
 b=Mp8A5TckxF9p7yol4Lm/Cf8RCMwGGVok2taQa3WBQhv4d1oNIb7ueQUFTUMDX3tI0PonLla4DROn9rD1DvXGNNkY0b/+8T0r6LdD5R5MgOeJAWFUjhBI23Xj7wcZTv+sSyOpRtzbwqj07O3d/lz5oBCC5ommmy+zfQJDdxsgh0g=
Received: from BN9PR03CA0668.namprd03.prod.outlook.com (2603:10b6:408:10e::13)
 by PH8PR12MB7424.namprd12.prod.outlook.com (2603:10b6:510:228::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 21:16:01 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::7a) by BN9PR03CA0668.outlook.office365.com
 (2603:10b6:408:10e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Thu, 19 Jan 2023 21:16:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Thu, 19 Jan 2023 21:16:01 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 19 Jan
 2023 15:16:01 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Documentation: gpu: Fix number of columns in APU IP versions
 table
Date: Thu, 19 Jan 2023 15:15:54 -0600
Message-ID: <20230119211554.13728-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT039:EE_|PH8PR12MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: 9df3a77b-1db1-4033-1062-08dafa625de6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E36Z4oo+wYVBTlVR8XzzInObb3RNwp7/5IMg/cFM1KdFjU8rKbRSS7NUKHEd1VGoUPKcCm/rCcXepsRAFTNHFSJD2jouxbQjlspq6RMZnlgQRu6ty8ukMS7+saXHQkPP+o2t1XYKPFpsND9i7ds1UdGBKdckWROj/g7AQJqG/jsaoh8kMqGk/3f5ypUXAraI4XyHYvEL8OFfB9Y5WmmooXZl2YDQcgwhrQEgo53y49JRdZhwwLHAbEwJPnL1hI8N0B6zzcgOWMW3eXWeK04wlxgR42W0i5kaUg2Jrg1TXrhLmRMoOjH3AVEdMU0TvwR4Dp6cgK6LOmo2j/QoH1kSKnhgruo+jrf3rfdFARMBAA4F5yhg6i8iNoD6jf+BoAmOAw19qRWNhef3bQqjfkIPo5S7QEQxmlEEiW0bVJWyAvvWOaxbXo163VOH0lTBfnzGFDJ2z1Lsc0FftvIk4964WnJZ7ZewSyXBtQiL8Gsx8QqsxSO6Xirs+eqmR2hmGowTTjx/1lo27NgIydfJECqPPiAMggBta+YD6pz2KNRJOl7DGs99oxzD+U6ii5DDdoKwOP4UrIYnmwuMvLg5Nl9gOj+dN4FUdkgT3cd+1IExq6MBxZWyGBatYL/puJZMTPAL73/MrIg7OGj4La043dvvXTQpujDc8byotzB9rRuRDsnOdqtWKhAP7dVUqWKPI9xGsEdir7CLRrydL2V3geZccvzOvQAlcKLDWYN0YO5oMW0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199015)(36840700001)(40470700004)(46966006)(36756003)(82740400003)(41300700001)(44832011)(4744005)(8936002)(5660300002)(2906002)(36860700001)(83380400001)(86362001)(356005)(47076005)(426003)(82310400005)(6916009)(70206006)(8676002)(70586007)(7696005)(81166007)(1076003)(6666004)(2616005)(40480700001)(40460700003)(4326008)(316002)(16526019)(478600001)(186003)(26005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 21:16:01.4975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df3a77b-1db1-4033-1062-08dafa625de6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7424
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

A new column was added for MP0 version, but the table is imported
into an RST file and that needs to be accounted for.

Fixes: 393c5b8fa8d85 ("Documentation/gpu: Add MP0 version to apu-asic-info-table")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/gpu/amdgpu/driver-misc.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/amdgpu/driver-misc.rst b/Documentation/gpu/amdgpu/driver-misc.rst
index 1800543d45f74..be131e963d87c 100644
--- a/Documentation/gpu/amdgpu/driver-misc.rst
+++ b/Documentation/gpu/amdgpu/driver-misc.rst
@@ -37,7 +37,7 @@ Accelerated Processing Units (APU) Info
 
 .. csv-table::
    :header-rows: 1
-   :widths: 3, 2, 2, 1, 1, 1
+   :widths: 3, 2, 2, 1, 1, 1, 1
    :file: ./apu-asic-info-table.csv
 
 Discrete GPU Info
-- 
2.25.1

