Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2675C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 14:23:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23E0A10E144;
	Thu,  5 May 2022 14:23:46 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2063.outbound.protection.outlook.com [40.107.102.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A05ED10E040
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 14:23:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iK3fS33PZvByBpDpXthzX0e1aVykkyOHp9U//kMbzx2GED6t32MMBYAfvbVH/6zvj/+2/kW/gjy+8OJO+uxrXY51hluYvL9csRe9zHy2GTOKz8l50xnJntShRxV8OKi/KOCCwd9uhO4YgwnRJL2yYCkRIpJvYZeiOgVRLAgiDitY9+xkRpWhY8nPXvKZC1m1K4TSD6MpSagPxOQKTK2y82S2/UpgUFgG7j5yf0rqwij1vsv+om1Td8xgMK3lx3FeUxNcJSikr+g4wpa7z56x4tRudTw5Tyf5z16/MGACjUen99d1b6+F8O3TVglUNVstpZ1rswRIefSxJVEuLvuCoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktKWsn7/F5eVpct9sOWZ6eqeObLZE7o1CHFmFcVSsls=;
 b=HsawYWej7zI1sTMd2f9JZEhsNlUpC6SSsXmfnCyNSLoWsqrGD9bAqfdUrF9xcGo8rBgSYiP77AzYiMHPvVvLQYQzPtbmnzkD4PMZxk0+ICFCRXDZ2Goh1OKP2hYiQwTrjed9I7cVTygkBSQjeRoSryHrHjZo6/2Y5YOEQK8sYMLtIsyYOFot9mtseCh5ZdCn1YTpZwI51pjmVJgnMT8HnhQhyL9SNVfeCFnhy9vbVLWGYu1+cZ7X9lAUPDFKigJ6thWvvnHwqlnVaQ2HbuWYboQ3a8/GqjeIUN50KQCOBhleYadyEq1mGJY4rVDUT3WB8VqGRqTPWid8P4Uag7eZeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktKWsn7/F5eVpct9sOWZ6eqeObLZE7o1CHFmFcVSsls=;
 b=FAP3frvMoIUbJXZJ2QDOD1aiNnYPdIqnL/Se8w9c0grlPtWv83t29hfbclBzRolHhkLdD1k1zuwZ7Ns/fPEpT8t2Sc32gp+8RuZp/lirGs4xnyYg+17+KoGTCTsb7kEJKwzbazOuBPlSFWehS+v8UdC6mEXVmMfMLhaMe1ZefKg=
Received: from DM6PR06CA0021.namprd06.prod.outlook.com (2603:10b6:5:120::34)
 by CH2PR12MB4327.namprd12.prod.outlook.com (2603:10b6:610:7d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 14:23:41 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::b3) by DM6PR06CA0021.outlook.office365.com
 (2603:10b6:5:120::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25 via Frontend
 Transport; Thu, 5 May 2022 14:23:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 14:23:41 +0000
Received: from Gundam.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 09:23:40 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/17] drm/amd/display: feed PSR-SU as psr version to dmub FW
Date: Thu, 5 May 2022 10:23:08 -0400
Message-ID: <20220505142323.2566949-3-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505142323.2566949-1-dingchen.zhang@amd.com>
References: <20220505142323.2566949-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe486813-6f6b-4f7a-f020-08da2ea2daf1
X-MS-TrafficTypeDiagnostic: CH2PR12MB4327:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4327E0BB89081E4C0E50DAF58DC29@CH2PR12MB4327.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: efnGdF8USyoYwrpoXBXnjc9bdkXO9+rzd3CjnHtoWEZwvXW2ZOb0cnJsy5v08OY+8+XOMIyOl/i0mI6G78J389FBhoEuOvG6S12AayBX2sw6/naMYkmQQL5Y5FDDEHNIm3j+WFMtoHxN7gJQsnzf0NyDO0GQ2/3tanpfelFyYva2SPfWU0/lbChw2KTg320wH9tJzpS0Q/MejIRDIQrlya0rse37Kp2nVvem2+dzF11cHqlsBMFSL9UxFgjMsv5IdavKx+a2GaD81AGks7I9ylf4f1kLnePAE5rhYoP9/wd2b+p2WmxpetbqGgDhi8eDBk4elxeyesvanPmNTuecATo+NKY9y/3WjAh3pbzbgrK45Zb51jFDg9h2diZI5xvOjkpnCSEM9Z+UmUMqeui812SiqjQDmY6x9Rr834xDUXDlx/cocX1BJIei1e2EBhyuiwJEAFXtYVi5NeZVgdZE9SBye6h9kkh5MR2YohaHbh9vnM15uFeCd9G8Urpf5ACM1zxBo3Tblm/VuAi9yJxXHu1YH2isLk0KKXT1OXiroShM1lX83PlQw31iwtblV7LUOKsAqykbaWqU9dHkd8B238431UFDhmqLsT3AdosfXAfljeIUZAjOuqeStAR2jRnt+lZ09U2xHu4ZBURjQn7BMO2sqLVxFLZdnZ0Hye9qPe5yTqd5bzBnHePChy6kBwh1lbvca6naE2LTLaxS2z/Csg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70206006)(336012)(426003)(4326008)(16526019)(40460700003)(8676002)(5660300002)(54906003)(36756003)(1076003)(47076005)(186003)(2616005)(6916009)(36860700001)(316002)(86362001)(81166007)(82310400005)(508600001)(356005)(8936002)(26005)(4744005)(70586007)(7696005)(2906002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 14:23:41.8121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe486813-6f6b-4f7a-f020-08da2ea2daf1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4327
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
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why & how]
set psr version as PSR-SU in kernel-FW interface function to ensure
the correct dmub command parameter is fed into FW.

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 1d4f0c45b536..f1411a22cf1e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -133,6 +133,9 @@ static bool dmub_psr_set_version(struct dmub_psr *dmub, struct dc_stream_state *
 	case DC_PSR_VERSION_1:
 		cmd.psr_set_version.psr_set_version_data.version = PSR_VERSION_1;
 		break;
+	case DC_PSR_VERSION_SU_1:
+		cmd.psr_set_version.psr_set_version_data.version = PSR_VERSION_SU_1;
+		break;
 	case DC_PSR_VERSION_UNSUPPORTED:
 	default:
 		cmd.psr_set_version.psr_set_version_data.version = PSR_VERSION_UNSUPPORTED;
-- 
2.25.1

