Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943B6C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 16:47:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FEC410E4AD;
	Fri, 22 Apr 2022 16:47:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDF2910E4AD
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 16:47:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOfs04MuiMWDE0UveulnUcqnjkQ3tUzCupggyBlIzs7BQrhi4Z7UJs8SqwgCRS8qj3qr04E0kH0zGD1QeJRTotmIELrrbw/41ho6sHV/ZML2TRcCwQzeNfxhQey9Hju3yDKLKBDiZXS3lWQGt9+PtNFn5QDA2JSNlbTFBTNKzwelxVEHfBO3a9AnBBVwpLpScGswk2WpnZI8gIINAzKBqO0qjRM4tUp0LPKD2o9rhwfQTZirbxAu6Gr4B+ddwwOWmraYNgdO2rIjKlECbMsnoA3ZzHrcrfuqjDSMLRj/Mq/k0bffcidwbprMSLkAx2HcTcVFr5O/qzy1S2yFFTWjEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNARmRqyIi7pkY9UqFjgtjrpyJDvN8atjiSLDjDNiZI=;
 b=G/nyypdmWvMuPoi0PVwsqauIo5c/l17ChkfMogwNCVIE4wvVf/MB4WUJViy+Qy0OmhmgxY3Iv7N1gL1YTIhMnoHmx7N2V0zKaKWKyaggMnmC+RU7z5XbuCIv2o7nJfjjjX9Bz1MXz64Ojlc7KlPATMT3QRlS4XYzFjmqnZ5Dn0vtIuVgKV9IpeF8G+TsIOgGBPuhkrIp8CBBTwxml+Bf1NTZmHmnXm0ka/aDf/GYw8ez7Vog48vRAGIh5mTt0L+KMIdzVZLeaT9Vp9VGotY8jCGEGIYEltCF31zrSx++ywvsGao2MnZnuOSv/0oDCddEwyh3z7E2wXLT2YoekQ0dZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNARmRqyIi7pkY9UqFjgtjrpyJDvN8atjiSLDjDNiZI=;
 b=usjB+P6NSz1QBAA+c6/mesw8RXxE1Rtwm1IJRXSLHvVdrvQiACXSo6+Er0H8Kgv4T6RmqpDLKIUBlJ3d1wZLSQkS8v13rjq5vvXGVv3s2dlpFXpDdInHaDWOaK1nh+04ZCmbnpHv9X0/oDYYztdoZu2RDV7PP1rZ4iaiQorXzpw=
Received: from MW4PR03CA0255.namprd03.prod.outlook.com (2603:10b6:303:b4::20)
 by CY4PR12MB1911.namprd12.prod.outlook.com (2603:10b6:903:121::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 16:47:03 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::51) by MW4PR03CA0255.outlook.office365.com
 (2603:10b6:303:b4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Fri, 22 Apr 2022 16:47:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 16:47:02 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 11:47:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 09:47:01 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Fri, 22 Apr 2022 11:46:57 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/13] drm/amd/display: read PSR-SU cap DPCD for specific panel
Date: Sat, 23 Apr 2022 00:44:52 +0800
Message-ID: <20220422164457.1755751-9-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220422164457.1755751-1-chiahsuan.chung@amd.com>
References: <20220422164457.1755751-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6db17384-b1a4-4d4a-9cdf-08da247fba32
X-MS-TrafficTypeDiagnostic: CY4PR12MB1911:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1911DCF3E8D1DF4FFD345043E6F79@CY4PR12MB1911.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QT68qwqtgAIFVJdvAY4q/K2nDJJzRUF07H61qpE1FEZoVpXGrv+u6kZ7jtg7rbWW5kj9lnjoW9m88bHMhXV8yL1UC7nYkxoMBkJHQKLLDn4ntg3JM9AZtS50lsLXrPwqOzNDr172oevpXLrv2W7AhEr6RBf/YQH4vvdeAEjgvMjG8FWeHfkgQuoSXey6jYboBPzA95k2iBNcSbLGFLDpaU5jZLXXNEelL7FsHUAFnnfXRAxG9vuK9t2jhpV0ZABjRf5J3rjF8TUZCjlGGcIjlJgY55JAfyuVFVNNvOERzMfnWi9/OqrYmyzYyucaPQkNJvy3KgnGA/lFlZdc8+oYavX3N69X7His/EaNoo1dJA3tANummhxvNxyiZW5Z6VCvphIwxvnLIs3hcnzQ59ALcoJ4PNOXZ37Vb+vSJSoHVKHzTnsxKeP7yKPfJkRZjKT/VmDrufnDqmksvHmhL+8LA98FVxQR5UtAK11HFkFOQqOGj+rgKj1EKw/bduUVqZT6CW96B4cjve1+XdHAe4T5sdw8UTPJMW57mvtMOAk95W4r47G2w7UBVpbrhQG+ezU+OIM512uJafzFYcubYAYMNAczIusD7HFuf4cZORgMHpJAplYyyT17SDT6MKZ2NJsjk/gFuLxjmqmKlIFCRcn4JuNwhNnpegpd32hv0bY02iDksRC63EfE29Tf8bAaf7DMAyH4A3B7bVASbopZCr/t9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(82310400005)(8936002)(508600001)(4326008)(70586007)(6666004)(7696005)(5660300002)(8676002)(70206006)(54906003)(186003)(26005)(6916009)(86362001)(81166007)(36860700001)(2906002)(36756003)(2616005)(356005)(83380400001)(40460700003)(1076003)(47076005)(426003)(336012)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 16:47:02.7797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db17384-b1a4-4d4a-9cdf-08da247fba32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1911
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
Cc: stylon.wang@amd.com, David Zhang <dingchen.zhang@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Tom Chung <chiahsuan.chung@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Zhang <dingchen.zhang@amd.com>

[why & how]
For some specific eDP panel, we'd check the PSR-SU cap during boot
by reading the vendor specific DPCD, otherwise it will cause to
false report the eDP panel which supports PSR-SU as an non-PSR-SU
panel.

- add the vendor specific DPCD address in ddc_service_types header
- if specific eDP panel detected, check vendor specific DPCD for
  PSR-SU cap

Reviewed-by: Aurabindo Jayamohanan Pillai <Aurabindo.Pillai@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: David Zhang <dingchen.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c        | 4 ++++
 drivers/gpu/drm/amd/display/include/ddc_service_types.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index c5f5d25035d2..10f990eefe7d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -5822,6 +5822,10 @@ void detect_edp_sink_caps(struct dc_link *link)
 		core_link_read_dpcd(link, DP_PSR_SUPPORT,
 			&link->dpcd_caps.psr_info.psr_version,
 			sizeof(link->dpcd_caps.psr_info.psr_version));
+		if (link->dpcd_caps.sink_dev_id == DP_BRANCH_DEVICE_ID_001CF8)
+			core_link_read_dpcd(link, DP_FORCE_PSRSU_CAPABILITY,
+						&link->dpcd_caps.psr_info.force_psrsu_cap,
+						sizeof(link->dpcd_caps.psr_info.force_psrsu_cap));
 		core_link_read_dpcd(link, DP_PSR_CAPS,
 			&link->dpcd_caps.psr_info.psr_dpcd_caps.raw,
 			sizeof(link->dpcd_caps.psr_info.psr_dpcd_caps.raw));
diff --git a/drivers/gpu/drm/amd/display/include/ddc_service_types.h b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
index f883d87791fe..73b9e0a87e54 100644
--- a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
@@ -39,6 +39,8 @@
 #define DP_BRANCH_HW_REV_20 0x20
 
 #define DP_DEVICE_ID_38EC11 0x38EC11
+#define DP_FORCE_PSRSU_CAPABILITY 0x40F
+
 enum ddc_result {
 	DDC_RESULT_UNKNOWN = 0,
 	DDC_RESULT_SUCESSFULL,
-- 
2.25.1

