Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B29C77B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC63910EDE9;
	Fri, 14 Apr 2023 15:54:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0922010EDE0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xe2BMaPFOib6XHqK9bJQT3YgwaeaqBu+HThhK5u5eCGjIRYAjXfT1tK3bYzI2RuqyEDEkbMMKQTzFBySDxT/rEG43jxTYmwcMjV//opJu7DEXXfQNzSWby1plHHSVBaSao47sw3s2rOh4F7mVb+bG33I33ZDcMC5iTfw8BSsU9Q2MICxxT8zcem+v1LRowLoNQ8j5o0GgaHZzZzF43IlbruYkF0wSfPv1Ku3bqusUHrx7wrDLVjMi0LBwzLLYUmmMa6B9NHEArbEqNrJYk8KS7SmGsTv0L95HCBSyAbRq6j42VecLkvXW9sFq4G0cwLdvNVTLZMbHgcVYmQUYxtiVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzqQI/U5qCXW4Hm0Eo5BLh9ibn+lyDtAug9YAuVPxko=;
 b=NmDWQTP8skgOSZIVHgxs6kHCje+/xv5DP+erRolUJPs+vHSRiheWZ4/ugKPUC2XURvn/URiP7KVTwhVFpvBdemRZ8yWrJL0K2u5ezet0axJpG7wGmw6TZGsLBJVIlc2to4hHsAdByOFMobohVhovkj2JGyJNqpLJ2nFkcqGMgOlkLY0VDQ48Rx/WFFkI8Yohoia1uI8uJjiCBTJYxjAQ0I1C7dvlBEX9kVQeEEqVs/sArqJ938A12fzpQoKiXMe1ycR1DsJzy+JAPIgDz4vijcyK77kF+KyExLekl63s2M3EPOGm1Piq7USHnDdfnvEqLqR58qHoCK55oUTcrFUBMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzqQI/U5qCXW4Hm0Eo5BLh9ibn+lyDtAug9YAuVPxko=;
 b=QCazAXz5DgyXyV1qCF4h7yN3jFJC+6EuBkcymCeA2Ldjcilyj8IlJvLZQI91c23asoicSKq3+NzK4Ikb1mnFn/Hy6v4bCGoz83i5rY5FGPVRVbwLQ+aWWxes4A5Z5fHIH4HPP4mSqot7gElcLvJei12bFojRsSON5eK64NPgesM=
Received: from BN9PR03CA0259.namprd03.prod.outlook.com (2603:10b6:408:ff::24)
 by IA0PR12MB7650.namprd12.prod.outlook.com (2603:10b6:208:436::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Fri, 14 Apr
 2023 15:54:41 +0000
Received: from BN8NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::e8) by BN9PR03CA0259.outlook.office365.com
 (2603:10b6:408:ff::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT077.mail.protection.outlook.com (10.13.177.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.37 via Frontend Transport; Fri, 14 Apr 2023 15:54:41 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:39 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 36/66] drm/amd/display: set dcn315 lb bpp to 48
Date: Fri, 14 Apr 2023 11:53:00 -0400
Message-ID: <20230414155330.5215-37-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT077:EE_|IA0PR12MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: b5aa73f5-274e-4d71-518e-08db3d008ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JnbYJZRkiJrRDgNIJs7O6ZTsX/cy8XYhJcmHGbKhTSnpEtCkmHWz5tv1TIEwnT/+MXj0uE2d1qXBn60kkEfma+E+HBE/Er1obvYwlileUIIIBBuQ5+TFUxvTuMeTTYXHdS6C8f6Wyd+bJkOiLCRw3BhJt16w7l2YVaFnlaBE4bnVq6MuYq9G4SmwXsRXErOAN/96gpnn9F4SbJlmp8ToZmEkUlUJgpz5LwwfuxIW5cRKLbh/a52ibUn3nPyigaaL/8BQr7CTch00a6HncdNAE0ZKsZe/02xwM/ptushO7mf+YaztereACVi6vU05ZBch5kBgCMrU5MA3CPZPMNM9+QWpCaSyk8XU8zaeuRhkjJv15dtykVXB5wPQRh0geu9bEs7bLWb9tMTzdgGuFe4N0h025AEhBgJx7RBcKIuZITdbohCGHdPX4CwaQ3utRJ6fWyPvKZFLP2QFRE7hxcWCk8hDLfcPHx/uoyavC8sfTgDzrX+Ic7aL3aVgwMvW5xYvevrLX7p7VynJCeVJw3h0vLorHjd+o5JraFZFuEyTpBVXfvsvxQqE3AHRkyDO/zAikze/hquMG6DNsrQxfHyxtro7vgAGkgS7LQUjBuTkw2wJJL9Kb9+8uVMnJsG0jWwobXKeb407cbyFzCx9RShxwHr21ieIdYLxsls+R6DP8YZ5jVnW8Fx3BHq0TlnX6C6W5q8LoXWt5vOpBPt342UhvlE0emJjRDgJ//hHHS0ILfw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(478600001)(36756003)(86362001)(316002)(41300700001)(70586007)(4326008)(8676002)(54906003)(70206006)(6916009)(8936002)(82310400005)(36860700001)(40480700001)(4744005)(2906002)(356005)(16526019)(186003)(81166007)(5660300002)(82740400003)(6666004)(1076003)(26005)(426003)(2616005)(336012)(83380400001)(47076005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:41.0390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5aa73f5-274e-4d71-518e-08db3d008ef6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7650
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

[Why & How]
Fix a typo for dcn315 line buffer bpp.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index b37d14369a62..59836570603a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -222,7 +222,7 @@ struct _vcs_dpi_ip_params_st dcn3_15_ip = {
 	.maximum_dsc_bits_per_component = 10,
 	.dsc422_native_support = false,
 	.is_line_buffer_bpp_fixed = true,
-	.line_buffer_fixed_bpp = 49,
+	.line_buffer_fixed_bpp = 48,
 	.line_buffer_size_bits = 789504,
 	.max_line_buffer_lines = 12,
 	.writeback_interface_buffer_size_kbytes = 90,
-- 
2.34.1

