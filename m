Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C51C001B0
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 18:34:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3669D10E4DF;
	Wed, 19 Jul 2023 18:34:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::603])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DEA510E4DF
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 18:34:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ch43QN7de1boFc7O1DEz1AxW0OSqv7FZ2i3QLNsvljbemfP20Ynd2qaa6hTlcbmzf2l/gdR6YUdHqP2K7vH4BOrnHetb1U59DUyVHOFGlRqQJvb4ZJrwA9yoq+BVPWaQJ8DLO5/EEyFwvGPzmCwfYwO8yuYg7BbnBcJPiSntLE2MctJGsAUzruQaq79rJ9Q7g6xJ5NrJiviPYcGgSIXb6MOdwNtVyYTQqLRWJezeT/q0T2S/Wx9puH0y8Y+srqBgmdOgPlpGRDusd2CIup/c6rZss0qEMs5KNYmAF3ETTgZ1mqe/JKgZ3oXz0NzUMLJM8nvjub9GDv8IbY/GvPod7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwg1RgII0yPDLZXwtmvSB8ZvCm+LWrGpQLFH8eJmroc=;
 b=J5VIpQdt+tH3YudpyEF04STRC/3oZWx9j49yiGBqf18Ir3v9GFtXLqTfgNjfvk1Mn7fNvvBXmxUsj+o7VCMkN2kwh+Bu5KG4UzbZidJ3pa+sQvfbIMY0PyjJBtC4S0AII0ZJl1GUnTkmDv1f8bQEAxdKSo+PZXplbLu9W/0L1PmoNp4V37+i+hS6rmYlm4c63phEGZ/KacLgThRHU4RNLbq/Iyo5AngG8/3zqjJp5Apfp2SWsbphE9XIanBJ47/QTfmV878alxhUZb7yXj/6hr3uyoACFXVMUSRtGpYTCT3aMobeDX+cC/llm90SfTauylFIEN3gogWoAQ9OSLY9ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwg1RgII0yPDLZXwtmvSB8ZvCm+LWrGpQLFH8eJmroc=;
 b=S/DJuSy/QeV+vTc7Kdaf6enbjrtzeMBYMT+GD1vcKkWnXhNUs3UJ6uojMY08p9jW2+Z3G0+adZ53qNFSKhBHfEWOygsHQogjKlEItCs02t9Ph1RYBrRPXlZDqbftI9PfhXxGvpvQ38gibMR6lYA6t8m6MZhli6ce3oHEIi8pryw=
Received: from BN1PR12CA0023.namprd12.prod.outlook.com (2603:10b6:408:e1::28)
 by CY8PR12MB8244.namprd12.prod.outlook.com (2603:10b6:930:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 18:34:00 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::67) by BN1PR12CA0023.outlook.office365.com
 (2603:10b6:408:e1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Wed, 19 Jul 2023 18:34:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 18:34:00 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 13:33:57 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/16] drm/amd/display: Don't apply FIFO resync W/A if
 rdivider = 0
Date: Wed, 19 Jul 2023 12:27:55 -0600
Message-ID: <20230719183211.153690-6-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719183211.153690-1-alex.hung@amd.com>
References: <20230719183211.153690-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT030:EE_|CY8PR12MB8244:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d964f1-ba53-4a33-a88b-08db8886b840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: so80GXMzxB1S8K9i9H+wbGp4w2BipOVlc7+TShmxbTpuO5yDvmrIji5cFvdglV2t/58edxvOnheoR7cqxzKGRktOpoe9+2PI0kZLHAwF4wB4V1/PQXEmZX30ADb9/cLcd65GGdW0IM8sK9Mn0mOqYZpgY5XNhrlM2hKQGw/OAyzkJ81t7YSFpJcAludu84CgJhtyXdtY7f+KOiQd9JdcfjGyy0b4xwLgWjBYzqUlFp8fTDY9ybdz/LK1W/TBpG3hooVFkC1J++JALMj88/QLGdwgP/X7umuIRKeMoBBAZznhKqEcJElwSmP0PRQwjQWkw2/QmZHplUDCLgxB6Cc4pzcQLda8VjI7mweeAhq2cifkm9SCo/D3J2bsQwEO+nb2cckiTBrZ1F+2ISQ1pcj4TCnhWE6DEDW2CNEEz9KEdfQUEdgmm5NXKzvePp9WZ2UbE/oDJBoduI3XCbwHW9iCjm7kKFStoDK0xWoeGNCL19hTwCM96N4uZ2XsPQ3wNbUOHJjqlA1zotWtylVI5Qnp1WwgC3LUaUSlXvYtbgUau841PMa4hGxVBkYHF2elLRgQdbkj/Mj/JxuQ1CMU5oZtZHsh3ycC7tB8kfh2fUbm46RqqvFdphzWjaZRFTJSt3AhHXyAlsjKIbg83bKwGkGS/4Cj/AgbST0wZgFekjuolx+t5EfWW+kz6BegztQh3/Aj8lxhr109eBraJohe+EkXhNmOi4Bs553XbGh+qDkjlPdbSkYnXQmlIaZ3sZEfX1rjSaPBWaGB49VFZvUVrXeuyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(478600001)(7696005)(54906003)(426003)(47076005)(83380400001)(40460700003)(40480700001)(86362001)(70586007)(2906002)(1076003)(186003)(36756003)(16526019)(336012)(82740400003)(2616005)(316002)(81166007)(356005)(26005)(6916009)(36860700001)(70206006)(44832011)(5660300002)(8936002)(41300700001)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 18:34:00.0828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d964f1-ba53-4a33-a88b-08db8886b840
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8244
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Saaem Rizvi <syedsaaem.rizvi@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
It is not valid to set the WDIVIDER value to 0, so do not
re-write to DISPCLK_WDIVIDER if the current value is 0
(i.e., it is at it's initial value and we have not made any
requests to change DISPCLK yet).

Reviewed-by: Saaem Rizvi <syedsaaem.rizvi@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
index 11e28e056cf7..61ceff6bc0b1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
@@ -49,7 +49,10 @@ static void dccg32_trigger_dio_fifo_resync(
 	uint32_t dispclk_rdivider_value = 0;
 
 	REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_RDIVIDER, &dispclk_rdivider_value);
-	REG_UPDATE(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, dispclk_rdivider_value);
+
+	/* Not valid for the WDIVIDER to be set to 0 */
+	if (dispclk_rdivider_value != 0)
+		REG_UPDATE(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, dispclk_rdivider_value);
 }
 
 static void dccg32_get_pixel_rate_div(
-- 
2.41.0

