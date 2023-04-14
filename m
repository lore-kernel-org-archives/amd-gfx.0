Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F396C77B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02CA710EDF1;
	Fri, 14 Apr 2023 15:54:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F87410EDE3
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7jESimHYGKrjO5Ftka8Fnb1yVU2W9qIDPkaWYk3la5b0GPRsQmOAaSs4pWY/WsIBjApv7u4CxootX2zIQ979RQhHMcYyd+brtT7GEo1VCixdDLO3JwQeWDKYb/y3MS5RJxVCzaQPYoYSwxIlOrLkZzn+tRv+dM9DqGkO3/4ZjdCBY3InhQKmVn5CGmLvT0GWjrZOm+X/L6BuSirvbX7ootNzlh/hKp3ruvPLydlTtr3aed5h209HxBYg1uMAn6eqvxvF7BCUKxXiaKIWjyXVS624WyjV2W/B8xmr1q6k54p3MA2RumJ+RUMx+KaQlqH5fzo30Bp46m0QLhcx38AFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j62EnmjDcR7ezryPOrgxSpcauhCpURF6y3cIlzbz8wI=;
 b=XLa0+JdrTbwhBpi1hUwAsLDDJVp7sCHbFuWMF4tr1OQOoR8DYwv07Cb+xpLtC7wohfgi8aLGZsU1hGPgP8SzxhcJlCvgtjUK+W3+jx6PO3qhMTIw6ey5JHX/3gzIGKFxFlAq5RLUInIvvpqakfqM2K5F+Q1AwOkvHjPo3EgY6O+Msd4y+RmpkysSiQF1c65a7doCvwwMfsQb4tcYS+a7q5SQl6hqGnYrpba7G85KjVi/RfqZKC1HFsZW+bC4FyyNWtJr3qoQwgKYOT1WsbHVQORlCm2w78KiDgJ6xUO756sM/rvjhb9VIQ91wCTmI5HWurpGcFpwH08/RDqY2jtCPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j62EnmjDcR7ezryPOrgxSpcauhCpURF6y3cIlzbz8wI=;
 b=wDD3C6qDQnmZCj5yJFdqlqnlE/SpIwX/XVraY6xN1DXcRL+UGKBqmFkrE8BJJi1Pd5PKHp9pkLznQXHdniFjhxRDrnUBwKgSQ8zX7DXQgwS0gPVcQo5oBrBiZNcB3sDFLDsECs1geJqYrk7k+MebuWgAgCsF54/604KuHaA0ghI=
Received: from BN9PR03CA0139.namprd03.prod.outlook.com (2603:10b6:408:fe::24)
 by PH7PR12MB6419.namprd12.prod.outlook.com (2603:10b6:510:1fd::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Fri, 14 Apr
 2023 15:54:46 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::b8) by BN9PR03CA0139.outlook.office365.com
 (2603:10b6:408:fe::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.31 via Frontend Transport; Fri, 14 Apr 2023 15:54:46 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:44 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 39/66] drm/amd/display: remove incorrect early return
Date: Fri, 14 Apr 2023 11:53:03 -0400
Message-ID: <20230414155330.5215-40-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT026:EE_|PH7PR12MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f0ce971-22bd-4f70-f8fa-08db3d009235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w80F7X5oz4776nLbZqwvexyNkMgIfmJrj1y2ZMadsfo0MpHsIpAGsWMnsq0A5Sc0Uzq0atli0xaEBDNjQzDf+DLoQhAWPziqzQP0J4/8Kb/03ktEVyci0UEkBR1PR22E+zwIBT4tRZf5ztTV9GTZU5mRwZRHCNKtWoTdQWGl1WsgYAcQPJ5jev9uWV/KdgoatYgF0HedqW3Tdn8qMRNTbwfoHDcjM1NQP1fnROoLKnL2oUNJoKrcmd/EWMWxt5UU/dimSdf3lvkt3RQE5WPNArxOwRUwetbLXr51nNxOVjyP+hWastMESEIfHp46ePFimWVdHtdX27eeBXj4juuEwH5jDjbcLl/f1CrKp7zrZyx3xkMPY6IcZLVcwmmDzqpHaoE4MjBoC0xAS/GBBkCb/jnn7V2F7+RRvJKPKwUG1BkSxLJzA9vqGkpylAt68qzJfi3GuJ/E013GyatufOzMaGgG2NFqdt1ccdNFLocRGZlbVAbhT4U+7y3xCuDoru8lCDYVFmml7vsZCEwa5a2h2HZT1ZbM4NCwvmI0IR6oWYROinPcIM77GsPAzLUYDubrQxPBc3DtT941TcGWlCV4XKoRjwlyVHbW/P6t/4P803smwA8IoG5oCTpAmma4sPG8llu5PRMF1cLyZZEN55h9OjnCo0RgM1Rqc7yq/ej1PQsQ4Uwn6+wPdmc1Lj4fxqgWUP4pxvM0bvw4rHmsEQuJ8en1ZwRWhafSad3mMELQWW0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(36840700001)(40470700004)(46966006)(6666004)(8936002)(40480700001)(40460700003)(4744005)(5660300002)(86362001)(6916009)(70586007)(70206006)(4326008)(478600001)(82310400005)(82740400003)(356005)(8676002)(54906003)(36860700001)(81166007)(2906002)(1076003)(186003)(2616005)(426003)(336012)(47076005)(16526019)(316002)(36756003)(41300700001)(26005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:46.4893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0ce971-22bd-4f70-f8fa-08db3d009235
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6419
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
Cc: stylon.wang@amd.com, Leo Li <sunpeng.li@amd.com>, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
Remove incorrect early return in a device specific fifo reset workaround

Reviewed-by: Leo Li <sunpeng.li@amd.com>
Reviewed-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 330ab036c830..c6ce2b7123b7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -687,7 +687,6 @@ static void apply_synaptics_fifo_reset_wa(struct drm_dp_aux *aux)
 		return;
 
 	data[0] |= (1 << 1); // set bit 1 to 1
-		return;
 
 	if (!execute_synaptics_rc_command(aux, false, 0x31, 4, 0x221198, data))
 		return;
-- 
2.34.1

