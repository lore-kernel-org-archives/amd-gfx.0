Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D31CDB484
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 17:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABCB310E451;
	Wed, 18 Oct 2023 17:44:10 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67BA210E44A
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 17:44:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFjjD3dN3gyJdeoUIA7lxdDDQNO2wVeZmKc/c10pEPAcnB0JGREKEdJrezk59hZBylDYSaKqoUrafkl6N7TPT52RWOPZcRnQzDjuuRR4Zv2BNbh+B+6QqOrNZymTSQNy0D8cfMgjTR2+d8uvDLvklOgiVGtM3fpDIFA9UNtlEDmKH5Ho7B+szSk6R2m/1x8MFY1y34VtYL2lz5i0LEnNVo18H0d0jUkPUU+JyLySJPcytvbS6/y5ZI+S/5Xnq/+tRwlIEw6GF1SNEP/c9hjGBF/w+xz2UzE6BLdpWka714CazaAqyq05KaBI3sFCmbHmJctPeB5afxr6YF6sbMOWfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPd7uxx0HWBP0LHF8bzJFvrD6wQrcPLxCvKOkgTECU4=;
 b=ZMVoDGHOjPRvyOeMmmqz69dAM81NEnlbO6OCelGuR9Qv7xcjPxRBSjYnsJhIfN8GE48X87BELhZ3wi6sYvW0Nff1njIJTIq+vmGMthSezcOIFK4a0/0bgKq25ZwKK7CyFRL8z5lWyDeqeszypfV7NDc/V6e/NgJn1mNFUPsA7YKSYPHoBIC0bnnhvkUONc2J9lScHDBPNBU/+eBV2wjyNTKV6kBlSEYHhZL8rVpOkRldJqIVXo052P1gzqk3mA/FNgN1xbxtuQ3nPlWiWDvhMadY3JRBNex7pDUdSudZWBjK2V997Css2W9L1AT790oH5e6WXY1tyFYsvZkFkDG6yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPd7uxx0HWBP0LHF8bzJFvrD6wQrcPLxCvKOkgTECU4=;
 b=jw5EPCd8RITiqjwbc7+gxcti4CCFcfxAnXkR8cdKmDXo9GheeKk0AzXvzardPErTt0HKJs4VWulaDHIsJ9f7Uf8g8hJqRXInISSXL7fBbA12NDYP4hx0E0WxVYN8myaRdauhrncMaoUu2VDUSmcSSAkYSlVGHV9sxhtvaxFTe6E=
Received: from DM6PR17CA0014.namprd17.prod.outlook.com (2603:10b6:5:1b3::27)
 by DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 17:44:02 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:1b3:cafe::fb) by DM6PR17CA0014.outlook.office365.com
 (2603:10b6:5:1b3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Wed, 18 Oct 2023 17:44:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 17:44:02 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:43:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 10:43:36 -0700
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 18 Oct 2023 12:43:30 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/26] drm/amd/display: fix compilation warning in dml2
Date: Wed, 18 Oct 2023 13:41:32 -0400
Message-ID: <20231018174133.1613439-26-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018174133.1613439-1-Roman.Li@amd.com>
References: <20231018174133.1613439-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|DM4PR12MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: 8edd7912-5b80-406b-35c5-08dbd001d129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: exxg9hZmRp0xyTXLdk9raV2IqpISp5b9jFrS5QmDd96P5GX4Tu/2xVLCHODK/BpY1Nu7XV7PVorQSq7fpRBYw0Mxz85KGs+5Fl00+6E3i6nSOe9Ka3Q3QD22DMCnWsunN3TOPfpVG6ac8AY8AFFieHCZd1B3z3BdwwJp8sN8nPC2+etyBkOa4r78VolcJ3k5UkGLL0nFG+W1mzbOA4eHEdw8nF233tquecZcZ3j/kffRXd8rFXBFXveqq2RY/EUeOeYDFlasrqT9sPN6qM8RBZtJxtsDNrawgYMaxl+/jgvfu1Fg8qzTQPJEgku8jvNC3WaSP6v7ug4AvPk/A764ai8Bd/BKS/GztbKo89PuuHV4xnDkjHN3TBdSt4d6cKwMtw0moC1JK091Jjosj6VvvYl3Q1/zKpjNRtlsheS4kMEVcfxwTRGFZB2gWFkfsDgU+gr0yben0se8qHAmt21m8Dt7589mCR3JRpx4ptT4Q9GFySZmIMgw4I79HkxnVKjWYeKnqF2qJfwI4uWY9sDOmnJksAFnUPdPD/opsGQQRURpHYOa58lUpvGgzedojSWU7MGNovumEH3iUUmT3v3kkJOlykpBuQmalOcFw00RjOx91xdURR8dh2DVtvl4MwEDQimxnI6/dCmtXiusMaEQOa4X3z8B1nmlmVUtcJ3O/lj1q8DuddLqoLf7XmQPMqQdLMfrjXNQAAeDcDNKEkq6Qjke76AEtqa8g92Ywd5kLU0B9GUkWo2p5jvV0YJzBLbkarBLTq2BSXaRjUj5I4OiXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799009)(46966006)(36840700001)(40470700004)(81166007)(478600001)(1076003)(7696005)(2616005)(356005)(36860700001)(26005)(82740400003)(47076005)(426003)(336012)(41300700001)(5660300002)(40460700003)(4326008)(8676002)(8936002)(316002)(54906003)(70206006)(40480700001)(70586007)(6916009)(86362001)(2876002)(2906002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:44:02.4803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8edd7912-5b80-406b-35c5-08dbd001d129
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6158
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Qingqing Zhuo <qingqing.zhuo@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

[Why]
dml2_dc_resource_mgmt.c:792:3: error:
enumeration value ‘dml_odm_mode_split_1to2’ not
handled in switch [-Werror=switch]
  792 |   switch (disp_cfg->hw.ODMMode[cfg_idx]) {
      |   ^~~~~~

[How]
Add default case for switch.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index 71fce58da44d..fc266c6e1398 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -791,6 +791,8 @@ static unsigned int get_odm_factor(
 			return 2;
 		case dml_odm_mode_combine_4to1:
 			return 4;
+		default:
+			break;
 		}
 	ASSERT(false);
 	return 1;
-- 
2.34.1

