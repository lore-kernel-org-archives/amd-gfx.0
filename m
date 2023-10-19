Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024A2CDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 09:47:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B07410E4B5;
	Thu, 19 Oct 2023 09:47:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F00CA10E4B2
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 09:47:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGEsFthpdktCgZDCmSFHPsyJxrZZ1qbEJYUCGdne5dhnvMdziCkpxem6DXyiqQnS8x4eUllrJZ15BeaHNJrrsqzXcdnX2V8E8+wS3roAGVqXG2MvsrOAlj3ikEc7sEkLiLn4NwTVvFP+lR0hO+qPQy4m+9uGB+OXtgaKDhtUptj6D8+fFhC4D5Sc2EPIp+GzvdPmQDR51YEmzZiXX48MO8zUh3hdwPquEkEW1bniPj4Ks8Ola+g28UkB/IIk6Q5IPnhIxWTPb87KyHb9HWl1tkCngFmaM+AQq+A7cig3LNm/jBb24EPPfE0AES314J6GcohJ9qtaAT0U2SMCGYhdLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aY+cR3oHxJn6J7i/bYOqhEadmcSloSp0XAYS2ZnbvA0=;
 b=cWpsFxfLYAvGt2aw/W6qq/0K6bgWlKyVjWvR+zxvvxlm7kasU/TxVrMdx+LERkzmATxYcFZ11BK6O36GGOW1SaTOAfNLXYmh8IwNXCherHsPoNhXVdkgaindNd+NDRO/MHLYFfnucOi8sn9LnKOwofa0LZRYzNK9OPhfTmQTfRF9qgo5EH4uBXoKTEjRDwJKz4+B/bwAHLF4TDEQHJb6cBWnW92fm6J85vaB3CJRHytgUZDWQxaCdiInmuepdLOVvF5ffHX6gHTRBdmVGkaJx6hxg9mLy90FDEzx6H1xFGDZrXRqM8/HOCw/xisA1FSvhblkHUa9LkwA0YoaYEZ2wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aY+cR3oHxJn6J7i/bYOqhEadmcSloSp0XAYS2ZnbvA0=;
 b=gvNXyYtqffeEi9lJKJgPWO81Yrq7GHWs+V2/XxBAEbrtpzsihTc9lPRrMjCCDl+KsWicUfKpJXbExeJWJaaHCsrVcNz4OjuITOZ/f7w8voz9Kiy5jJ3mHqmFDw2p8+Z11webxaOYpLiE+3LNWsCUs3yhLhr38HHjz1PBEFviqio=
Received: from BL1PR13CA0392.namprd13.prod.outlook.com (2603:10b6:208:2c2::7)
 by IA0PR12MB8255.namprd12.prod.outlook.com (2603:10b6:208:404::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Thu, 19 Oct
 2023 09:46:58 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:2c2:cafe::d9) by BL1PR13CA0392.outlook.office365.com
 (2603:10b6:208:2c2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23 via Frontend
 Transport; Thu, 19 Oct 2023 09:46:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 09:46:58 +0000
Received: from primary-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 04:46:56 -0500
From: Lin.Cao <lincao12@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd check num of link levels when update pcie param
Date: Thu, 19 Oct 2023 17:46:42 +0800
Message-ID: <20231019094642.20229-1-lincao12@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|IA0PR12MB8255:EE_
X-MS-Office365-Filtering-Correlation-Id: c16db5c0-8b71-439c-4508-08dbd0885633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WLT815MbF6NVdrmWjAfDL127pO0eiE8tQ6sIL2D/VGn6Eb3HT7EJxoW4BT1YlAC4Kw/zd5Xrow6L3WwapdlttJWSHVco3HmZ4vJZWkQij/ncjuqogVyLCmfwr6t1yKzqd++Qj/8UtZutq3c9ECNGc5ckWhJmFnP6mLJqSmndRIZcgwmhE7mxRBj0lt+N+iFoyWOl3w+2YO5Yj7EHHhgrPjt166rNQOGrRe0A6NzDuQzfDCRerBzvd14PhvNLq2Tmh5wEvLDUKVQB+w43C6cyBX4/hybXiBmmacWltLAZofM6MiGdTlpNmlKGelp7qsTDjy3SS5XkbMrC2jzg1tIxu0xIOOVp6oTNtWdWRYOZccirvoTvELFScw4vVowRe/vWWxnmrhc8gCp9Bh+Q/iathYZPuzPgOK3x9t4wekcSKiS1oDueH58dv3X5Vwg1VS7gwTPnrt/L3dDXnonSrCZt8n3CW4B3uSaaazG3fwLSRCV+YWj5SSujl8o07KPBh8aqwbzsNhJmG/gtl6DlK9taiyUGXq1H8Pe7mp194oLbZv4QO4Qa6uNdIx+DdZri9tByKSgohy9Ugz2GAcHBgXaY9FybUhY+LPuBcyo6gi12MqAE3MzPDlAw/RUTZdOHOMY66J//1UvKHgH9cpvLCvwBOJtx/ldCOSs+kchCPDszswB3fU0b5ejCHf7yzk4kdUVPMKJKMeuXUH7aBokBLr/i5/WW8HFIJzh8boTCuTp5Zkp0hDK3tbOfFb6pZb+POno6UNqavHOLr/CH25nxGPE6bg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799009)(46966006)(40470700004)(36840700001)(5660300002)(70586007)(478600001)(70206006)(6916009)(54906003)(6666004)(41300700001)(36756003)(2616005)(426003)(1076003)(4744005)(336012)(26005)(83380400001)(81166007)(16526019)(8936002)(8676002)(4326008)(2906002)(316002)(356005)(36860700001)(47076005)(82740400003)(7696005)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 09:46:58.3074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c16db5c0-8b71-439c-4508-08dbd0885633
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8255
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
Cc: Deucher Alexander <Alexander.Deucher@amd.com>, jingwen.chen2@amd.com,
 lincao12@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In SR-IOV environment, the value of pcie_table->num_of_link_levels will
be 0, and num_of_levels - 1 will cause array index out of bounds

Signed-off-by: Lin.Cao <lincao12@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index bcb7ab9d2221..6906b0a7d1d1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2437,6 +2437,9 @@ int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
 	uint32_t smu_pcie_arg;
 	int ret, i;
 
+	if (!num_of_levels)
+		return 0;
+
 	if (!amdgpu_device_pcie_dynamic_switching_supported()) {
 		if (pcie_table->pcie_gen[num_of_levels - 1] < pcie_gen_cap)
 			pcie_gen_cap = pcie_table->pcie_gen[num_of_levels - 1];
-- 
2.25.1

