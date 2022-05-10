Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31C4C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 20:45:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 924E910E819;
	Tue, 10 May 2022 20:45:34 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2057.outbound.protection.outlook.com [40.107.101.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2902C10E819
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 20:45:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNhJTEoLJgyLEwuWpoj+cLpL+7k/JPJgYgmbY3IaaxoP0VdkYWHnYzr8ippQ+LbGmedWp90AwT+uGeaJlVjf/dv3BJtEE4rh9Mo8NxYpjQCKDPZWxNUwUS2Km98An57lznEh32ruwy9F3lg1FMfpG1JyCaKYYqDc64sbARChIw+xxRUIr561mfq3f2SUCPuPAAmys/bLzBU/g/2imF7Fl4dTQPmQ5Gilj5lbF1cfQaRcy5HLr/Q8WqLHHiDK81ap0UQhEWJGgKu0NrlTZDbRVTvKMFxHusq+D+AjXcXUK169D1ahLyGqaAkJKDz/61wJHUNDql5nHPKoRAIXhhmSqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktKWsn7/F5eVpct9sOWZ6eqeObLZE7o1CHFmFcVSsls=;
 b=RZTlOdq7pp3MALyXgdGyiOzm4uslW19QGNkhXSVEsV6PzqkhBk+vph1bAk+dpM9Zn8L0E7Y4cP5R6DbupyaF1EdufTGftlQ9YNS/FyGg2CM7dfjPRByKnWQAV+O/wLP0jS+Pnd5rrBj6+tsEwbQoJAWn0q/O/bWUP7/mRdItUztODjq8PM7kGJUSpjyNfB+bH6xKwOCxK67cLNbwqrU3pJ0+GwMzh+oPMEAE27kmUoInENaSZEYRfkBgRkY4s1SKRd2H04JtC4s4kzeRGR/hLOPspH5+2eAoRnBNX1sPheIAUK1kagNOmM52Us//8udzmklbmGeq+/IT3A+RGevEHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktKWsn7/F5eVpct9sOWZ6eqeObLZE7o1CHFmFcVSsls=;
 b=5n0myDimSPYRqEIi4tsaE8YnqWMk7yef8jfrq3n2yG/HnGeXm+Jor8pBHs0nzr9E0feEcW33LxlrX6XRZP023MyV1KS5t+IyynRaiiwgDh5iP0/vWHkyaMgO1kFXq1bp1mgEFRlQcdJRDN4URW1o2f2MIuF23fjriRP3Yfc01/o=
Received: from MW4PR03CA0258.namprd03.prod.outlook.com (2603:10b6:303:b4::23)
 by SJ1PR12MB6268.namprd12.prod.outlook.com (2603:10b6:a03:455::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Tue, 10 May
 2022 20:45:31 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::63) by MW4PR03CA0258.outlook.office365.com
 (2603:10b6:303:b4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 10 May 2022 20:45:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Tue, 10 May 2022 20:45:29 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 15:45:28 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 13:45:27 -0700
Received: from xiaoT.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 10 May 2022 15:45:22 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 02/19] drm/amd/display: feed PSR-SU as psr version to dmub
 FW
Date: Tue, 10 May 2022 16:44:51 -0400
Message-ID: <20220510204508.506089-3-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510204508.506089-1-dingchen.zhang@amd.com>
References: <20220510204508.506089-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70d771c0-07c6-4437-065b-08da32c604ef
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6268:EE_
X-Microsoft-Antispam-PRVS: <SJ1PR12MB626888026B7BE8EDD1585A368DC99@SJ1PR12MB6268.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3KixQdJhRZzACswL1zlqqrMFRezg6kG0V+jMY7/n7XKLhc7Id8mtoTNC3L0fvoSSE5DrSiMJA0pc9PxddNVWqWNU6vrLedQoh9gRLEHSETBjEYOVw95jJWq+BsbtOyaazI3/eSiE4OyJ0RlNOb3gGs3MGGpl5A8tOtXdBCqmASf4h669dKkJazwqJnh1RVWerCfQ3qCr2UhplsXzLqbtpjrGAzpFjZP7NuDxu8VCghp4E9SkwkQQZAIIZk7oD+zOt7MbPiYAlsm+P8fapxRAZeQ9lGS1gCpl1s6imycMtYhNpP4RmyHdxUsFaU1Dd14ugnlbl2un0oaXfpmg4a2tm8bGL8lcX6iR7QXQpLNJSR6NVkB606XkUDHeozNFbLxSA0kN7OnuyxWimmkTesch3mbV+H/06gRc+L7Iqh+R+kerEAEtUQmaKr3DoJS25OaOfeoyvt1AkDQZ7+wTa8NzTQBiqeGJX2F49gLpQ+c8bRW4/eAxTg4gqeX6RVhayv+ywgHkqgfUGxiah4JIlZYJGcVVQTY6w1dgI0/OWaIeV5l7HKdim5DFNUZNFjqJtBpq3MIqKhtHgzXo3zsI99FylCYk+t8qcv0Lef82HBTPXLMGJZodGJvXfc+M2nnOu/FHtRtZq+fFtryd0ddVXJoGl/busUJEmDfccoMmmZ5VRNhfDWHfjjwsY/SYDILXCs2qY5ewLF2fGP5TRG6mm/Kz8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(186003)(2616005)(36860700001)(336012)(26005)(47076005)(2906002)(6666004)(36756003)(7696005)(1076003)(82310400005)(86362001)(40460700003)(81166007)(508600001)(4326008)(8676002)(70586007)(70206006)(8936002)(356005)(6916009)(5660300002)(316002)(4744005)(54906003)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 20:45:29.2158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d771c0-07c6-4437-065b-08da32c604ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6268
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
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
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

