Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEA7ECAAD5
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:27:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 256B410EB4C;
	Sat, 27 Aug 2022 02:27:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D2FC10EB4C
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:27:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P03PkiGUIh8a+5QZHC6YNMNcWLKshQ11zakMPY13pQo4jcOhTWXgTC1ORcoCEiIDC1a7TtNmUvb2fbXsWfPSS9RiviXAjVjdOwtqd7p6WhRTe7SjpKm6lDF/4mUYfvN7Ew7Hb3aUNi5i0anrMQw7I2noRVkDk1NBzmqzBm8HBbGpOQSaTg7bjbpycrwnGgLMAZ81loa7E4VJJku5snu+4dxwjqcKWRMP87lHel3IbH8HG904yCaw3rOyLeL0nWwvd8kL+6+MfHJnYOb4+XBGhqmg4lbqbwsPWnrCv1x1oQqcofruPHHFWCPhd1ULx2csKPStLwQmT4oYzqYmEpirzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9JExdU9IkqnyqzU6bFCDGOTOKLzubNMWvE3gEplnrI=;
 b=LFpUbmbu3ehVI0RmhLj1pB08mUA9Bcq5voUTn28UiXNdTEQb8nM9+BA/vd8qlnA1K6pJ4acDCZke7bfj02pfAM5tOwjwTmCFB73YTo8i/aVdXP27FmnrLdSyChHS0BtNQFBkJN5rIJT71jPO9PRORLhkgwg11rBehHujkZiJcPrIo9dq1k5E63orYIcrltuPVMAF1WeHVwFJq78YVxY63wzZfAUEE213eMkPT97C9G9yx2/cEL9rlwKfpcztB2x/EVdnwJvvXdhdVUtFBsn21VMP/1UxLfPOmCrVyND93ib9hb7m79jhAyhsaLlO6uIjL7TO8ltG8xJrtDWHS9BHtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9JExdU9IkqnyqzU6bFCDGOTOKLzubNMWvE3gEplnrI=;
 b=bIVZoc+ef64+6j5u5nh1FPgg0UzfMzWbC2c4uwi3nKh6uON1B3P2xMPVlLLoBVn78pYHnVGtT+a4n8f6TK87s+c0K/UZTwkkv8OLvKwpwpD6xPBe8uCdwtr+3BnocHG699LXPNhXaV5hUJynzPfSjTMfOiXA6NRo5XOJnxWD38k=
Received: from MW4PR03CA0316.namprd03.prod.outlook.com (2603:10b6:303:dd::21)
 by BN8PR12MB3540.namprd12.prod.outlook.com (2603:10b6:408:6c::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sat, 27 Aug
 2022 02:27:36 +0000
Received: from CO1NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::90) by MW4PR03CA0316.outlook.office365.com
 (2603:10b6:303:dd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Sat, 27 Aug 2022 02:27:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT102.mail.protection.outlook.com (10.13.175.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:27:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:27:34 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:27:31
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/33] drm/amd/display: add a override flag as wa for some
 specific dongle
Date: Sat, 27 Aug 2022 06:26:59 +0800
Message-ID: <20220826222722.1428063-11-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826222722.1428063-1-Brian.Chang@amd.com>
References: <20220826222722.1428063-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d658641-3fa1-4f8d-cb99-08da87d3b465
X-MS-TrafficTypeDiagnostic: BN8PR12MB3540:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6+Z7w9EJuADbwgmxjNrm6/6WraFppueRhZR5irxl+LlnWKGkhWcehLDYyxNByWFMy55q5T5R1G8vwi2FlEy5XigSA77XAWh6JhVRhG13EUnJ9IkmdOpBe1D1Aei8rukX+tv+Sa0B7UOKSBRDJkp9bBZdDq485mQ8bsA4dxvFpgY9O+5qdXo7gMNBpsiyKcrTFUwHCGQGPOYD/WgQhOc/jgwQmzKXWxXCDaKDbN/4U2JKk2Y44pNT2ljZUwlXHEaQZdYMfaBvvTvCb9+HsyO0rptfzCfQApubWcyZ3SjfRUOxHqBtgVtRUbKXdXQmBIrEKamR3vgf9lCHMBcQHU4VuBB0MyeN3Q5I+iTCA7FZzVj7N4/Hx0NQBpPX3OtMeYppzVbYJbBCdjrkIMQidoAZhQkyFoPKppcXCQfjF4nE0y6TPqDIy6e/CzkOV1d0sfpz0OeRMCqp3r8CaXfDzt3wcJakPe7m33FHqUPKz/3lfvXbLK23VAT+ueFmsnO1Ck2IXts3XZGUkkF55KNfORkMrq+xcXpIsj2ZPvZzA6Z1symn/TliIUAyYN+UF2n66AmuqetbMXUx6xhcE9rWl6BZk/6e7CtFzbmO1dUOq6pNBGWVsWSsNUGuUo6uC3LUD3xMrV2shqQOlF/msYNSqPpGm1sTx1TMtlJnevWpHlOt+pLm0V5GC57fmO5RyklEZAglsGK6g5r5jjBCzkwiD7WMhcM55qRegsT0/TCbKNqPqXxpI0QhQ6PLnEkmU9rW+QhQNlef7p/ypu/lQnPvuKTy/uwHi3aUPWVj7amA01RWM4lrS1Q9WeJaIzm4ftuApUNv2bpG/pCTjBUYpK88yr8xVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(396003)(136003)(346002)(36840700001)(40470700004)(46966006)(1076003)(336012)(186003)(2616005)(47076005)(426003)(36860700001)(70206006)(36756003)(316002)(70586007)(54906003)(6916009)(4326008)(8676002)(26005)(7696005)(86362001)(4744005)(2906002)(40460700003)(6666004)(8936002)(5660300002)(478600001)(81166007)(82310400005)(356005)(40480700001)(41300700001)(82740400003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:27:35.9047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d658641-3fa1-4f8d-cb99-08da87d3b465
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3540
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>, "Chen,
 Leo" <SanChuan.Chen@amd.com>, Brian Chang <Brian.Chang@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Leo Chen <sancchen@amd.com>, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Chen, Leo" <SanChuan.Chen@amd.com>

[Why & How]
Add a override flag as wa for some specific dongle

Co-authored-by: Leo Chen <sancchen@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Leo Chen <sancchen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_link.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index b18efe988830..d1214944839f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -224,6 +224,7 @@ struct dc_link {
 		bool dpia_mst_dsc_always_on;
 		/* Forced DPIA into TBT3 compatibility mode. */
 		bool dpia_forced_tbt3_mode;
+		bool dongle_mode_timing_override;
 	} wa_flags;
 	struct link_mst_stream_allocation_table mst_stream_alloc_table;
 
-- 
2.25.1

