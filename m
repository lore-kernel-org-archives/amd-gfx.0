Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38682C7EE2D
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 15:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBC7D10E6E2;
	Fri,  3 Mar 2023 15:51:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4983810E6E2
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 15:51:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVipBflaEopQ6S29VQfzD5i2sPuVcYxTFXSZxGZn2vwX1L8wTDKMN4Vayy9UaWHx5m23I53dqYxokpzylcbGJQdcUVQhH/qLTDxS2nC2etiVwP/gGsyUKLqeOJ90SHh6ZPMnY4PPXdrg+AvL+vlybaSQbg4YtvBi2PsVnHGhIDqvapG5cay0TEagECM20STfqetcmWfQ3guLXeXiCrPhKE+7inMgKCnqnsb/tHV4XdTmwY6Ez7TNqwRFzyh4LTE7Zlm5WkJHV/NGaDvVvNENfyPqj7KjdgQc742VNEPlOXSwyqUlro9/7USfDhB1fz3DodspfgLdo34vMS/BFF1edw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wRT9Xq6W1OiOcZOlAPdbph7x0snsQqKIgwLaiez1SM=;
 b=hzsvaXmI70ok5I6sUGa9+Iwz4MsJV6PG9uK+2rMFwTYCLO6n6gn3GvbV/Ho1zadm5q925BNE1gPo/n/G33QNMXZukUtgfms3tFHYbb4VnMIQ2Lvpyo574fyYVx7wD7o+aiWA9SB7/bO2oRr0Ulh0JUd1noabnQex2XcK3y0/52UJD5789Ws0iPMVuoXCNDRlKhvtvIf/jiD+2zr1KGBHf/tkr9u8EkrxF8o6vE6Q5ALGNNrwi/U05e3AsX9SL1fuJc2hAxo4Exlw1+U0fkoO6HQ0RB+4UGSlMnO2FuA/jdmUx3dPU7rk2IE2rKG0kysEUbRalLd4vxQ3iNfFrEYd7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wRT9Xq6W1OiOcZOlAPdbph7x0snsQqKIgwLaiez1SM=;
 b=fycMiAxP1RLAgOeMp0LjV5SocfqXBeAh0n8ZA//bKLJ3OLX1B9dJKdmDBS7ZiZ/9yUBduhXzZDuSgmr9/atYs7G35imnS5XE5cJiMzQYVqxzgabXaR0XlXXCk6P0n/iuidNZNcApmtZVOxpKUjfcTlM5JXVGnbkUEIlubKyNthQ=
Received: from DM6PR02CA0052.namprd02.prod.outlook.com (2603:10b6:5:177::29)
 by CH0PR12MB8530.namprd12.prod.outlook.com (2603:10b6:610:188::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Fri, 3 Mar
 2023 15:51:20 +0000
Received: from DS1PEPF0000E631.namprd02.prod.outlook.com
 (2603:10b6:5:177:cafe::14) by DM6PR02CA0052.outlook.office365.com
 (2603:10b6:5:177::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22 via Frontend
 Transport; Fri, 3 Mar 2023 15:51:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E631.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Fri, 3 Mar 2023 15:51:19 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 09:51:09 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/33] drm/amd/display: Enable HostVM based on rIOMMU active
Date: Fri, 3 Mar 2023 10:40:14 -0500
Message-ID: <20230303154022.2667-26-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303154022.2667-1-qingqing.zhuo@amd.com>
References: <20230303154022.2667-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E631:EE_|CH0PR12MB8530:EE_
X-MS-Office365-Filtering-Correlation-Id: 17a64f91-a772-49c7-ea9d-08db1bff21b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5lo3hsaT+kUm1H9pqBawQptFQE6SbiL8Un0/xIefkZDABve6hADIPopjVPDCqDgGBY+uycI7YNNvfb3l8MGSozrb35ZTNsHqDctAQlHmKUCiTWUtiSPWaczjRUkxzIsGojKgwfow+HJH2ohukoP62CJj+RRnYgAGdYYcgRN9Bk7JDofMtKvKMSp3uL9XuN4gN9IQlpXgmJvf0e6job+FN2CnoNxvcP+IW76Zoh3GRpAPE1lydOejaZ0YcZDI+9XG79CNPrqECaOkWvr6xs34Fx5w+s7pKwLbamtG4q2MBzX00FCuepikDEq0D1B4liNpl1MXybmUzplQ1X4bHkMoamaUtdaqC5R44tolmX7fwV5NoSv4bVwkMMEEUPrHjY8vBZg5Na+F9aMOaxyq1QOmaTCXraUdZYKEn6EaoM1TIqseppWIAooBDdR9kWJsMg0Tdi1AzUwOQ8z+SQnhn9VNgrat/eRbkwO2Z5oRSnSa1vizZLU9yFalehN37Pc988jcziXiqXGyppWyMi+LTytWEsaBnMsxVD5qZWG1Q7u4SGNgLkmniYgGOFxCg/oxXlJtuWhjRQOzgI54BxzPTg5bOV5TcIDKsoEicBlEeOyxfuTbugwvUp/0ZZHQb92U0WlHP+JEf8iF2jusWyWd9tQgLmFbd8J68tnu5Tgm35T0+41Kk3k6R18FFi3QDf+OPpx4aZHaD/cXkbMgko5Vcpd7QztW1W6lrRt3lvWz9WP+E40=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199018)(40470700004)(46966006)(36840700001)(36756003)(336012)(83380400001)(82310400005)(316002)(47076005)(478600001)(54906003)(40460700003)(356005)(426003)(16526019)(36860700001)(186003)(2616005)(1076003)(6666004)(8936002)(26005)(86362001)(41300700001)(2906002)(5660300002)(70586007)(44832011)(40480700001)(70206006)(8676002)(6916009)(81166007)(82740400003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:51:19.8496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a64f91-a772-49c7-ea9d-08db1bff21b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E631.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8530
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
 Gabe Teeger <gabe.teeger@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Gabe Teeger <gabe.teeger@amd.com>

[Why]
There is underflow and flickering occuring. The
underflow stops when hostvm is forced to active.
According to policy, hostvm should be enabled if riommu
is active, but this is not taken into account when
deciding whether to enable hostvm.

[What]
For DCN314, set hostvm to true if riommu is active.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index acda3e1babd4..c52b76610bd2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -308,6 +308,10 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 				pipe->plane_state->src_rect.width < pipe->plane_state->dst_rect.width))
 			upscaled = true;
 
+		/* Apply HostVM policy - either based on hypervisor globally enabled, or rIOMMU active */
+		if (dc->debug.dml_hostvm_override == DML_HOSTVM_NO_OVERRIDE)
+			pipes[i].pipe.src.hostvm = dc->vm_pa_config.is_hvm_enabled || dc->res_pool->hubbub->riommu_active;
+
 		/*
 		 * Immediate flip can be set dynamically after enabling the plane.
 		 * We need to require support for immediate flip or underflow can be
-- 
2.34.1

