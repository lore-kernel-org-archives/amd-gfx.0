Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B856C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 15:05:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4BDB10EFE3;
	Fri, 18 Feb 2022 15:05:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FC7C10EFE3
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 15:05:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6R308y+ho5kpdyupCfQmgwWLSdjJpQPS8VLSTJsWaiYkNGq1m75nPRFR5QFmzULyzEBegyt5sjpUj311t3ZTLCRP+oolsdO9tJ9Q+vvIaUlILRnP/ed22ajY7JgjrTn47b3lA15SKDw0CVm+TFUwN/yQhczAtaglOYfQQ5XuC6yHkVJl17URafD4wiY2e1BUPYEXq4m+N8G3m/IkE4v/0YZ7i7G/EE6hZWl64IjCoG0ljjiyBAXRdnmmWFhZN8Jpk2iI17JMg1UF1W2sa1hEVV6kmhQiPEBMhBodtiw1zp4H1WbKzgdYSrvWlc31ihQhi5LoeVfo9qmaR0NQQhOsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20CwBgFn7Yo0OU6XB7oUzAI+xHZNYY2vSEj3lcu6NkI=;
 b=aCjKPZvqVRIhz5rp2Wy4SbQRK4MJJfmqctZls5vfimwMtrigNwqGubWzUyHBDRX5ybpzZZFBUY4L5zkHprkQwvvbYYZzXbKFGsnwyEuYibRAsw05EDu8kegTvUlnjPUIZHwbF1EoM/O2kxqZ9MGjBbZCjGBJ6vRVJ675qNvQPn6wrINziFPVBTi+YjUd8sKZxaOI/i7lKzFaN0ykr2Sb8GN2HiXccS98ow5KHgA6a4WgUJ6MIO9IFSlH4TcyQ0S3yi8aDMrElcONoBpx1lJo8dz+4T0BLMN6IxsYWTwu3eb1xPivHS2n/mZfEngCgF1kgaxWDOZCG1or76OcD5+Itw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20CwBgFn7Yo0OU6XB7oUzAI+xHZNYY2vSEj3lcu6NkI=;
 b=vk4+B/Lk0+rise/YKLb5LzeZajL74YIloxMFlBYi41HqvbfilWmbXaQHk18kzzyl6z6MW4hp7DJ1c/M4qJHu8U/fh+MO8p/liZLwv7F9YWH9ztsplwf3tDoLcK99lOHGtSbiJ9fFAlT/3XQY79fXITQ0dWZAIx9By0bAcnruAQ8=
Received: from DM5PR20CA0047.namprd20.prod.outlook.com (2603:10b6:3:13d::33)
 by SA0PR12MB4575.namprd12.prod.outlook.com (2603:10b6:806:73::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 15:05:04 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13d:cafe::e5) by DM5PR20CA0047.outlook.office365.com
 (2603:10b6:3:13d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Fri, 18 Feb 2022 15:05:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 15:05:03 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 09:04:57 -0600
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/12] drm/amd/display: add debug option to bypass ssinfo from
 bios.
Date: Fri, 18 Feb 2022 23:03:28 +0800
Message-ID: <20220218150329.7976-12-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220218150329.7976-1-solomon.chiu@amd.com>
References: <20220218150329.7976-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8639524-9569-4973-a8c9-08d9f2f00ad8
X-MS-TrafficTypeDiagnostic: SA0PR12MB4575:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB457597E6266A4E2AED49D07997379@SA0PR12MB4575.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W4WMYMMFfyzLgBq7lV9fmz/Urr7RRkty6O2A5/n5KRfzFEbfao/5Zq71eGrk+orUc37wLaxNvO/8dayh3SLXTpy+eGxOOkIYP2p1nYFZxZho5vmQXBkyntbXVTz8T0fdVVLomqMIG+ynKuPxhSThFkktvQmQ8ypnNTVmhQHRT26TXwIEJ8sweImHcmKp9tjw6koUxitDH39RoZme6aL+1BLHz4/f39EhDX9kH36Kr6eaAKcejKEuRFkleKlt8naELHl96HynZ3xaAdPp5BxoQtw7z3fhZFABRfoBlvk7aAHT/iczsijYJj7pwbruMU6gh2yNix72hrrAU4x8/eDr6Jb87WeUFQ6AC8vu/2i4JkOrgU1mT0jhXMqEFRd23cHKgv5Vocm0Q7KxqcF9R7Y5WhrxDJqfqvKRAcYk/USfEl1YKChGYhVLsbKBxU++UCXC6bYT4M/ImFUKDz1HiBhOqxfDH2y4vYWXB+NS/VAhwbierBhuFDZ1qj7g4XvqYxxpCbDl7jNbwxCjiyxLuxbJYtPMTTczduQL5Z1kQsPJH1RIqIMV1aLT+WLjlJEhUiUUKDk10HK7//g0pQqcys8XwWyoaTzztOzbWAeRPBedStP6xlBFPyzWrkVgX+nv4IfLyEhavl28sFssW+C0WbO2gwVGdB2BGRVWyDkEIJ9ru+yLM/2bL3GeYUsEE84IvwpjFkt9XomV/CA+rbmpdR/+Kw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(6916009)(2906002)(508600001)(336012)(7696005)(44832011)(54906003)(4326008)(8936002)(8676002)(5660300002)(1076003)(83380400001)(81166007)(16526019)(426003)(86362001)(26005)(186003)(2616005)(40460700003)(82310400004)(316002)(70206006)(36860700001)(6666004)(70586007)(356005)(36756003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 15:05:03.6586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8639524-9569-4973-a8c9-08d9f2f00ad8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4575
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
 Chris Park <Chris.Park@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[Why&How]
add debug option to bypass ssinfo from bios.

Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c  | 2 ++
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c | 2 ++
 drivers/gpu/drm/amd/display/dc/dc.h                          | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index b210f8e9d592..dfba6138f538 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -374,6 +374,8 @@ void dce_clock_read_ss_info(struct clk_mgr_internal *clk_mgr_dce)
 				clk_mgr_dce->dprefclk_ss_percentage =
 						info.spread_spectrum_percentage;
 			}
+			if (clk_mgr_dce->base.ctx->dc->debug.ignore_dpref_ss)
+				clk_mgr_dce->dprefclk_ss_percentage = 0;
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index e17c9938cee5..59fdd7f0d609 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -697,6 +697,8 @@ void dcn31_clk_mgr_construct(
 	clk_mgr->base.base.dprefclk_khz = 600000;
 	clk_mgr->base.dccg->ref_dtbclk_khz = 600000;
 	dce_clock_read_ss_info(&clk_mgr->base);
+	/*if bios enabled SS, driver needs to adjust dtb clock, only enable with correct bios*/
+	//clk_mgr->base.dccg->ref_dtbclk_khz = dce_adjust_dp_ref_freq_for_ss(clk_mgr_internal, clk_mgr->base.base.dprefclk_khz);
 
 	clk_mgr->base.base.bw_params = &dcn31_bw_params;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 9fa87a426f9c..c5a36c81d0b8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -709,6 +709,7 @@ struct dc_debug_options {
 	union dpia_debug_options dpia_debug;
 #endif
 	bool apply_vendor_specific_lttpr_wa;
+	bool ignore_dpref_ss;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
-- 
2.25.1

