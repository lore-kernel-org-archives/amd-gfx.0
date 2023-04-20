Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBACC7618E
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 23:50:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E31BB10ED4C;
	Thu, 20 Apr 2023 23:50:19 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13E7710ED44
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 23:50:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3tCDY1rQwtohs4rzEZ5qD7FHbKswJbOf8JvkXF7pppO1f5RTr0+v+vlw6HoaGCdQN50ni4CyReM1gnazS0mCHaGgzSOcQxnt7DfLHeWTZ4f9cASvr0eDt6Uw1ATaqlNk4M0zIO7WZR4HlvrrbW1BBUID1qkOjBHWzJbB/lNv430RJC1e7uHlKUlcI23Aq0D6ux0XIXDG/Ua1W6X0avk0ixFEU197/J+Dk1jMG5nI+tg1vqVih6BAlz+9iTO3eTLibwRc1b2zt/XRG8i96IFQZR/BkgVEpkPnjHahdSywX20z4FbmDVaSRMEP1W/kaeelYujgGaYdMFW246xzRfNOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nr2UVq99/Vs4/XLFkiRtch4wCXw7teQZEUZevu22JHo=;
 b=cMUBn/OLjD8vgnLbvRF1cV/ba4o4qeq9kgHtn+2mdWtubws7mAeXJQEXoQVtT1lIm2GzcZvz79ovcxcjtEY16Dti6DTD3T+NIwNON4EsFhsURIGMchi+97ldAlf3oPgK7VKp+6HeLGlRvG+Og4nQ/Lv+X3WIYuGZLHaChv7KZCpxjzehBvRKcn8S7kjWxI4mhO0l0DxBxRDjSXEpvIM1rfTHcwSVFGWGsBF39xOJ6P/y9bIg8WuZi15usvwTNuf6nD9qymfCuOKrV8Tl60wt4E1l9MYQhdAvi8B4zO8eOwInJseqbUAD6n4JsnPNpDt6nVX27jASooyw9OFlh2q/3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nr2UVq99/Vs4/XLFkiRtch4wCXw7teQZEUZevu22JHo=;
 b=AxxHCL8oAjJq8cKCUZlChHkGt8H5N+egb87H/e5tEfRdH21RXydLRtz1kjLVl7u8asUblTdWCRNZnT6JpLHBnGhsPvV/93mQxre90Dtd7JHVfYVTbzrKKbLHK0R09oD69CDHOwgxKsKOwMJPl61+XOV2P9bMpydFlzLoFUnEM4Y=
Received: from DM6PR07CA0051.namprd07.prod.outlook.com (2603:10b6:5:74::28) by
 DM8PR12MB5448.namprd12.prod.outlook.com (2603:10b6:8:27::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22; Thu, 20 Apr 2023 23:50:12 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::a9) by DM6PR07CA0051.outlook.office365.com
 (2603:10b6:5:74::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.25 via Frontend
 Transport; Thu, 20 Apr 2023 23:50:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.27 via Frontend Transport; Thu, 20 Apr 2023 23:50:12 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 18:50:10 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/21] drm/amd/display: [FW Promotion] Release 0.0.163.0
Date: Thu, 20 Apr 2023 17:49:33 -0600
Message-ID: <20230420234951.1772270-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
References: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT027:EE_|DM8PR12MB5448:EE_
X-MS-Office365-Filtering-Correlation-Id: c852dd42-25fe-4af8-199d-08db41f9fb9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qMfwbVayHNx+m9EJK0mL0Q3sC6TDVP4azk/wUXv22IGaZ3vTtnWRpGRq6hs5ryLC44ro6d1s3w+FSssv1bDFysb6Yi2jKvhYJIk4wwCMZwEO33TeEF5S0PiGkE+YhXzCrCuqUvGxk8UdybIMF3w7NXO3na8FadVRp9NAKo58bP00dKiXyTrqxTA110WItaBq2/CqLWv3ZraWriY64nutu8JIfRzc7g52izHGAhZ0sbOaW4mJ7SfDQAJwofp7sUvyWNh4WAVZN0goULIUI06J3i9zohqnwYYMhFVtqQmk/qS8r0I7nxo0gxYZphqwlnSrY9TMi2BK+sISRnx+5Zw805JWdtVYXnNhho3o2gpa/Yn6qYHKLULlLEIlBhoo2Ie8z9PDz5SBu4t2aHruIsHpeWcv80HkDg6AKFDvdNUNk+x+WmSt6S0ED4I0oj1BJcAvxuRTfmKSgSicrDbx00cG1MJXgONjGhG39++vdrrjC091RAYfnfRou3TjX5ADxO4nUsp2R3a/KNwbCe6MPTXw2vZCCnXdA7ZzQwTlIlt6Abj/DzgpihB+WFYCm72HD//kJI/kfUU+OfFgLcQ9Z9JaB2SV/uEAlbObX6Wy4m8mKNLFFVuCMa6GIc7nldYrVHdY5sjIGQiSf9yBqxIwUtwyuFH4FidKIoLZbsOKu7USysaSIEmy3nKVuQOyyMQB/1JCB4xVhYUtpS8NJsVelfvvvgzBqwMr4id0spq5B22X46w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199021)(40470700004)(46966006)(36840700001)(4326008)(5660300002)(86362001)(336012)(426003)(2616005)(82310400005)(83380400001)(40480700001)(47076005)(186003)(1076003)(26005)(82740400003)(81166007)(356005)(36860700001)(16526019)(8936002)(8676002)(478600001)(6666004)(54906003)(41300700001)(316002)(40460700003)(36756003)(70206006)(70586007)(6916009)(2906002)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 23:50:12.6118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c852dd42-25fe-4af8-199d-08db41f9fb9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5448
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

- Add feature caps for Subvp + PSR so driver is back compatible

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index b32a5c977d17..dcec8955bde4 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -257,7 +257,8 @@ struct dmub_feature_caps {
 	 */
 	uint8_t psr;
 	uint8_t fw_assisted_mclk_switch;
-	uint8_t reserved[6];
+	uint8_t subvp_psr_support;
+	uint8_t reserved[5];
 };
 
 struct dmub_visual_confirm_color {
-- 
2.39.2

