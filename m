Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88003C04A68
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 07:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEF3218A5B4;
	Thu, 28 Jul 2022 07:05:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5680A18A5B4
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 07:05:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A71nrCgi9B0rx8WqXEVpsieJXganM14S5XgZktimI/FzJ+RebzVu3fZKuKKse/u4uC4IJLS5Ztk5pLljdRfVmjRbgf3WVmjZ4KhBQoSHnHajETrj67r3Wg6noIGcNCMLSD2H9Q2W9LtOtbhzAXSSJap+69QUR9ncmnt9goB1DDoT8+vFZi6cjc6hA+6y+m45CCCTWanXEHH/YPEgTRKq94U3ClNbKEi8LMbfpAo9RX9MCSt2kaY9tHIPAm4GXRsJ/MsSNcQJIZK1wjNLP+RvJRUZjWUwmCuBuClKwvu7JZ3m2kNb4FxcTGpkfa0cMTBrMKjxL+OFddhIewWDPXNPbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qOLHK2NFZjbABphgp2+QP0faUF4+W6o8mvfYv1rKSQ=;
 b=n4ZOsHgtExfP/nAygBNOaGTk5fPWlqQL2pF8R7m5ICpe+Q9dDaMdDE7M5i0xYtlQK8kv+H3pRQIwb3ESZuuXFyfzm99hzNqgs588qDG9XwEArI77HTUnvG95HIJNMcq2qb3G/34UeHi5eH7HymrElWqbaIoSFGiAFGjAJTC5YmPgrbBkSvFjePov/PtU4qoaM4jeh+JDL+E01Bp+MTC2gZAyOROBNLW3IoTesZY8nCfvenVLO/YV5gjwDa63ubtQDUqz1OVwhLOZ1PUI3IYQG6XhVaU2gqCl4q8qbPWBI/ROZY0zS+SD/ywi/AEONdN4GAEWuCJFz8g9cXH/gweTdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qOLHK2NFZjbABphgp2+QP0faUF4+W6o8mvfYv1rKSQ=;
 b=S0nU2vjQ4bfNoQfJG3ilLx5GDZEv5X6LzlvosRhGcMWqQP0frgRQBVwvmNpjzfP2gvBCHjxPzmli+3mm5A6n6UQXFifJMVJjbWiYX9Tq++kz6iEpw25NadFQpU+MkL+VSFsBormKFgoRdrcxUB1JctWIucoCkWExSqz5JtwaKFo=
Received: from MW3PR05CA0010.namprd05.prod.outlook.com (2603:10b6:303:2b::15)
 by DM6PR12MB5550.namprd12.prod.outlook.com (2603:10b6:5:1b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 28 Jul
 2022 07:05:14 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::3a) by MW3PR05CA0010.outlook.office365.com
 (2603:10b6:303:2b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.7 via Frontend
 Transport; Thu, 28 Jul 2022 07:05:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Thu, 28 Jul 2022 07:05:13 +0000
Received: from jenkins-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 28 Jul
 2022 02:05:09 -0500
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amdgpu: correct RLC_RLCS_BOOTLOAD_STATUS offset and
 index
Date: Thu, 28 Jul 2022 15:04:16 +0800
Message-ID: <20220728070419.2485384-2-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220728070419.2485384-1-Xiaojian.Du@amd.com>
References: <20220728070419.2485384-1-Xiaojian.Du@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a2218f3-3642-4e28-8e07-08da706784ec
X-MS-TrafficTypeDiagnostic: DM6PR12MB5550:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0kz+XRyFMEZ0n6J9LgJfmOlveFtEY9mC4tS1LZ+kI8GaiGrcHC/+nHCHJ9mXBdTNz9Cqhwx+/iNTcWk4kEHilZ2MKGiyHQOuzp6aIlmqiOnGjtgjT7ESZJdW9ozeTVCQJPydMkskpN99krSX+qfGlBAw2zsp7iRXplIJ9Mlw7Ot5tGdlBRwKMVMimgJ4LXuZk2QtIBhOjMdk2ZnXt+o+tboutVVjiJD30e7Z2j17ZZiTfd5ejm7av+twutgn6Qn1cU3gjH6sAJ1RoY9fZj87qiRbSUY3EO/fsNk4fqbKeEIu9rrbTLnR0nmQq3KG9OkbxkFMKWj7uVKqL2TJ7vKvnXr0l6HZ26c5Tpjk46KW1FeNSZNwchzVa/oouFZqJpGmsp/TaCeYVN9YEAUJF4d7hx63kdKeE46Ls1e26Ec+gOcsOjx4ajYyLjCoUoJs+5tI2oCTbSbDcTwkE423+X+a2CrmvHIGObwgBigqrk6/ZTvEWQh5M4pjyRj3Sy7l3QOGna0H8N4h093/QENE1LHtoYcyxoYe7UYeeITYlt4Ir228lUWCru2Kdnp0LYetBv6hyCXurOlybaTYered3Ij7clj3IdPIZUwVwiVh7rQd8JnMerpU9t03soEWg6m31EczBLbfRRvQKJbmbWNSu3VMdHUfRjSphb5aF9+O2GKmfPcfOwaKXscUWfW2F9mhIxy0CEKinkaf5+x2h1U4vKqsgLLUdnRo4uUnrqS4tl2fJY4QkpBlaobrkwzXAJH7DvSTvWAF8lY/4hQ/zism0TtLEYT0rWhzKsn+ba+z3rEHt8ae0BcLEvufqbzDTTXEPyCLWkC/a4KpsZkGJemvy5Mhnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(136003)(346002)(396003)(40470700004)(46966006)(36840700001)(16526019)(83380400001)(336012)(70586007)(4326008)(2906002)(40460700003)(8676002)(6666004)(70206006)(186003)(426003)(2616005)(7696005)(26005)(41300700001)(478600001)(8936002)(1076003)(19627235002)(86362001)(82310400005)(356005)(36860700001)(81166007)(47076005)(82740400003)(5660300002)(6916009)(36756003)(316002)(54906003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 07:05:13.8665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2218f3-3642-4e28-8e07-08da706784ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5550
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
Cc: Alexander.Deucher@amd.com, tim.huang@amd.com,
 Xiaojian Du <Xiaojian.Du@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch corrects RLC_RLCS_BOOTLOAD_STATUS offset and index for
GC 11.0.1.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 0d8193b30fc5..6fd71cb10e54 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -56,6 +56,8 @@
 
 #define regCGTT_WD_CLK_CTRL		0x5086
 #define regCGTT_WD_CLK_CTRL_BASE_IDX	1
+#define regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1	0x4e7e
+#define regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1_BASE_IDX	1
 
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_me.bin");
@@ -2765,7 +2767,13 @@ static int gfx_v11_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		cp_status = RREG32_SOC15(GC, 0, regCP_STAT);
-		bootload_status = RREG32_SOC15(GC, 0, regRLC_RLCS_BOOTLOAD_STATUS);
+
+		if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(11, 0, 1))
+			bootload_status = RREG32_SOC15(GC, 0,
+					regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1);
+		else
+			bootload_status = RREG32_SOC15(GC, 0, regRLC_RLCS_BOOTLOAD_STATUS);
+
 		if ((cp_status == 0) &&
 		    (REG_GET_FIELD(bootload_status,
 			RLC_RLCS_BOOTLOAD_STATUS, BOOTLOAD_COMPLETE) == 1)) {
-- 
2.25.1

