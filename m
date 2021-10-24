Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64779C433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31E60600D4
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 31E60600D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D87636E12E;
	Sun, 24 Oct 2021 13:32:45 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 876DC6E147
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJjLisFl1aYJ5gbrbTTF14A8bD+fGI9r2ho65uU2kETIOZwBF8I3wpkWsNk9YxrBFuxwU0MKBjw67rPYL7wqNbslIOvyY/9aPq9QznQx5/+M6cX4DCHR2mLR8dPJab6k+cyfoAb/Tao0dWy+dn5udKqHTXTMtu07jolStMaHLeXQ/JDKSNzHLSRQuE1cMlWm2ST5TVvK1X66xSWXnpJVIpM5Isk7c71/uw08k8FVtZJSyc/3bGuL5fA4G8I5Xeq4je47L2Hn9wyA72YNSMunCbxuenFGE74rAjvebfyDDvffN7sQ5s5lD+uHhEjI4EXbObP8JW7kAosEukdpSurzRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Svja8r5IPhfkggSjSy01Djhu3wZNSG0AeG9FpAlbX4=;
 b=Dumy/NbSwINrZGtyN1ohRb/GnXWSVLdWU/dhd++5Zt7vQjQDzOQlhYe6eip0jZFq7P53roVdOlXgiqPJInBtVaUYNfkkbPMtwvMITy6hfmXDeBMn9L7/6GS034XKG6mxu+fVtWJ6KwFFek++VBGRHErqWCQTdd/gXDyEwfyTx+uagp00YUG85hshqEPQcMxJNIqsXG70fLt6ghOHFS9UH3WPyzV4zDWBd/t+KE0ql1fW39FTA3oeglmkw3mGXWuUzNmtas3q6vWgUBFVmEAtdlx2zBucZ/Q/yxOk0gvfPTSn2cltQun7M88F/VgHBKczZ5VzhWOXQE48iwJUfHqqbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Svja8r5IPhfkggSjSy01Djhu3wZNSG0AeG9FpAlbX4=;
 b=vXI5kqwN2aanRRj8wXtdy2u2qwHlNgx/R57KKcSZcuU1iTQdyaWgMi8hIVFTzeJpE+E/wfPfr7q9FYCpaOrtGDx3lgvE/s1K4vhpv1VbOTciC5oU3KlB50vrN52ZZQEYKxAKoh1kffFA3sNuLHvLJqP4GfArITxG+PbToPJy6j8=
Received: from MW4P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::12)
 by BY5PR12MB5526.namprd12.prod.outlook.com (2603:10b6:a03:1d7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Sun, 24 Oct
 2021 13:32:35 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::7e) by MW4P223CA0007.outlook.office365.com
 (2603:10b6:303:80::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20 via Frontend
 Transport; Sun, 24 Oct 2021 13:32:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 13:32:35 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 08:32:33 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Martin Leung <Martin.Leung@amd.com>, Jun Lei
 <Jun.Lei@amd.com>
Subject: [PATCH 23/33] drm/amd/display: Manually adjust strobe for DCN303
Date: Sun, 24 Oct 2021 09:31:31 -0400
Message-ID: <20211024133141.239861-24-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
References: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac16e920-c35f-416f-853b-08d996f2bd69
X-MS-TrafficTypeDiagnostic: BY5PR12MB5526:
X-Microsoft-Antispam-PRVS: <BY5PR12MB552653188D85B8D2B3DDCB9998829@BY5PR12MB5526.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9KRJKD2olYoc5oow3TovWwqf64aaReTEjDaZ0l1bgBoCW48rdI4tdiiaFAZHToGxDG/lyn4SRyLGY6CLPUCRjH0xSp2a+lFuGNYV9Y9bCD6LddnvYD8iKN0EPY6nq1A2HLKHl4gV1PPoQpYvy0+Ztd7/nSiJcjjo2ETS+8Yz3x0lJn6iruUHBCLmMa/Beo2BZnKBDWDJud3npNKb/jdkJzl/rgsEfHKLi4/aDgLhRmUAWMdgYs60/+zWqo8igIsID8Z98FHdLQbsUtrhC8E8CkBX0D1X2HsCQd8XpNoOXZkUim5V0XT/XiMwYp8uva4AdZU8V07Cij/NewYFcTTjVgavOpyRV0iEFnIvufh4etfvqq2YYn39nZHQ6yUmr1g8d9hJXYxt7lj8CTRRFn2c0JWBCplQAbsZ1Piz7LfObVnbwPha2xXTaaHRfB2wdeevr4EOgDI+HND4Gmgs4E7IL0eFlvgL+YVlOrIvSW/86oeVI+cUqnAx2lS/0vActqNcv22X2z8v/CoyWiu2HoYheVrCr1QZ/aePCmGhNbVMGnWc+tyeJP8/+lq3MLOU+KvFoCY0hWyu9RSxIteQlJnX8ydCKp0XLk3gNHZFaHY16T7NVl/DHJHFcg8tazD1JcrC3HMMldxPNGj1fVfPYcIgWHYdpwuNeDXdA54uYQHGHITLemxy4acdEFIj+fSItAA3HX7GfCV+LSqJX2xq9YvF6DcKsbD/+8zzdj2xkLLpWaE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6916009)(82310400003)(508600001)(26005)(356005)(5660300002)(86362001)(8936002)(186003)(47076005)(36756003)(81166007)(426003)(54906003)(1076003)(70206006)(83380400001)(336012)(2906002)(16526019)(316002)(70586007)(4326008)(2616005)(36860700001)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:35.2187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac16e920-c35f-416f-853b-08d996f2bd69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5526
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <Martin.Leung@amd.com>

why:
DCN303's 4 channel SOC BB causes problems at strobe

how:
workaround to manually adjust strobe calculation using FCLK
restrict.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Martin Leung <Martin.Leung@amd.com>
---
 .../drm/amd/display/dc/dcn303/dcn303_resource.c    | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 2ce6eae7535d..4a9b64023675 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -1344,6 +1344,20 @@ void dcn303_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 			dcn3_03_soc.clock_limits[i].phyclk_d18_mhz = dcn3_03_soc.clock_limits[0].phyclk_d18_mhz;
 			dcn3_03_soc.clock_limits[i].dscclk_mhz = dcn3_03_soc.clock_limits[0].dscclk_mhz;
 		}
+
+		// WA: patch strobe modes to compensate for DCN303 BW issue
+		if (dcn3_03_soc.num_chans <= 4) {
+			for (i = 0; i < dcn3_03_soc.num_states; i++) {
+				if (dcn3_03_soc.clock_limits[i].dram_speed_mts > 1700)
+					break;
+
+				if (dcn3_03_soc.clock_limits[i].dram_speed_mts >= 1500) {
+					dcn3_03_soc.clock_limits[i].dcfclk_mhz = 100;
+					dcn3_03_soc.clock_limits[i].fabricclk_mhz = 100;
+				}
+			}
+		}
+
 		/* re-init DML with updated bb */
 		dml_init_instance(&dc->dml, &dcn3_03_soc, &dcn3_03_ip, DML_PROJECT_DCN30);
 		if (dc->current_state)
-- 
2.25.1

