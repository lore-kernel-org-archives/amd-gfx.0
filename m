Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B100FEB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 17:13:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3823510E5AB;
	Wed, 12 Jul 2023 17:13:32 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86AD010E5AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 17:13:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acIyPTOb4vZnokANlaa3YUhCEaKBkOuI6jdSMgBaMHiSSbwbz7knyhxLDk+f8wcLnjGYcTDHR4mLsBnb7T0kxRklhi124q+9IbCdFmKH4LhOrSsUGwm9n6WAHVMmuF7+8/9n3M+ZeFCqpvlo/0v4x0sAWf+dSFeDg0OXJhmjO1+zshlutqsWBnFZZGPLZs5GimnBGjJ94TOh2afeu+bEuu1at27zl9ngFgMpVu/ot25BPFBD/XFdJJqssVVx+EbgxAmJyUrlPEEfOWV2mCb5yQ1PTANZ1g1fNgRWz+0MVq6S+zhZ01gRrqY8wt+BjMaKE5sE60hRIG5ktVEvSvzN1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQH/KEoOHblxUgP/Lsz/F/QGygeyhyzhwfgfXxiRCEc=;
 b=N55yGx2i1An0KXcI1rA7p/oX5w0U3XYa6/t/sOvQh9VwKBHFI+2P4jrczTVJLGyYNZjHTig0Fqt8tMV1TG8YvT9yYasTddmuTxwBQLMiVAfrrv7yrqrUV9eQZwZ6bGyiJl/cmynyNB4I250JDU15C/83zhNtW8A/5q5hKrPyFoJ3ic5jPby4hsilkclExlOjs4fUmP1w7w6KpWPw3p8AXlFB9keUAHJwKrHIUSJU0EY6ugc3uBaED7MEDSkPQRqgAQ9dIR0HuvQKa64uWoRSuUksheyp/zuAEJ129TN9DzSzCwEriSItvmxtcAuoTW5Gl5bS+eSOO90mfDhCGlMe6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQH/KEoOHblxUgP/Lsz/F/QGygeyhyzhwfgfXxiRCEc=;
 b=uZLKbdabnguDhQcbFOuxot/Me+LKC0aHziCfPzOsiWMy5w1M6X+UWtNfiDKyAd2PgpgKTq5x1qsj4g0RGV78E9OJJQpW9ZkFmgOE8JX/6njZ3WUSK7TI8xyDmlR6MRvuLtgHMhPu89D8VCXhv2azTNxjqnRRCJ9Ao3tVWMXxYdU=
Received: from BN9PR03CA0056.namprd03.prod.outlook.com (2603:10b6:408:fb::31)
 by CH3PR12MB8901.namprd12.prod.outlook.com (2603:10b6:610:180::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 12 Jul
 2023 17:13:26 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::57) by BN9PR03CA0056.outlook.office365.com
 (2603:10b6:408:fb::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 17:13:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 17:13:26 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:13:25 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 10:13:25 -0700
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:13:21 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/33] drm/amd/display: Promote DAL to 3.2.242
Date: Thu, 13 Jul 2023 01:11:18 +0800
Message-ID: <20230712171137.3398344-15-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT048:EE_|CH3PR12MB8901:EE_
X-MS-Office365-Filtering-Correlation-Id: b4eeda91-fcd3-4c90-7d99-08db82fb4e0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uFjHejjGcLw3kiyitLP0Q7Vi9mQ2xX/UQjr0RbZcxwGbAINJMRQkhlpgNNNBT37VA4yT2PyVugKS4L9uXW85cZkXy5xFsO2SkA0gQI9zaZ9Pr9Xg1+BMDOPB61+nfcFrkMy89NBo+Ck7DjM1CznPOs/Quwrs6aRwElg6sKDtuCStw+6zQSNDJNZBmXLfqNoEcub8rjQM5lYoiqyTUzi9YqlpyEDROAgs/4pE5IZuXEFYgR2+5ofzkyOIcws3cs0eVC9jGY1P9qv2FSrCviPnKr5CzQPZv/o0muF3CQPb7/HPC5UI4AsKPIqfrqTL1znmo1bmIITu2X9CjNVQJPaShTjRxZFF+5lOPxhiV6J2h1/9LFXjXsmatZova+8pYfEG7/N3n9CAUSSpWwhxxWxSo2zI4HP65G5MPTgJ59FS1CTpuNIdTT8JZikpNn9UIzg9QjXaMB+CPDPikDa9p9muNSUm9t6SZ05TjhhxQ9/cpnqEGhO65JXiJE6IR2YBb7EVBj7uLvTjnLO9egEPYCDTEzDIH56eRekRhg0NQwmQcqU8ggFlb8yAQItKMqBkn2055Z/wHWJhh9ukofCEfyU4yloJ9/sz0E6SLjXPIX1NZBCP77uT6OfoQSu6auoh1o8gfAWYkgGQUhKEWtFZUTIutg/XNtUC/LtCTsbyGduIudCTX8NUe5QubdiZhOc1SReRurigXsKCTPe04hYQBO1GHioDsrZKqj31A21SvaD34dlShXTVzCPIndT2upZOF+MMVGrwij/BMbys/AvsmecGyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199021)(36840700001)(40470700004)(46966006)(6666004)(47076005)(478600001)(54906003)(7696005)(336012)(2616005)(83380400001)(36860700001)(86362001)(426003)(40460700003)(40480700001)(186003)(2906002)(36756003)(82310400005)(70206006)(26005)(8676002)(41300700001)(1076003)(82740400003)(81166007)(4326008)(316002)(5660300002)(6916009)(70586007)(8936002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:13:26.0563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4eeda91-fcd3-4c90-7d99-08db82fb4e0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8901
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
Cc: stylon.wang@amd.com, Alan Liu <haoping.liu@amd.com>,
 Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
- Setup stream encoder before link enable for TMDS
- Use is_dig_enable function instead of dcn10 hardcode
- Re-add aux intercept disable delay generically for 2+ LTTPRs
- Add polling method to handle MST reply packet
- Remove unused function
- Improve the include of header file
- Add missing static
- Hardcode vco_freq for dcn316
- Reduce stack size
- Skip enabling DMCUB when using emulation
- Check TG is non-null before checking if enabled
- Update scaler recout data for visual confirm
- Skip querying caps when DMCUB emulation is in use

Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 194f185e7798..819c326baefe 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.241"
+#define DC_VER "3.2.242"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

