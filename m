Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61917C77B72
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:55:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3E3310EDED;
	Fri, 14 Apr 2023 15:55:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDF9D10EDED
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:55:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkhGitav+qVfTs/FZ7I9+STgiB/YJWgoCT+cVg1sV7b6hsL0ZfdOYiXEOa/K4b2c6n78aU0rLTSk8hK+fUqhDCFT3lP2rHmu62DT6xggHRu25M6/VqLMtN+qwunH7+POncmCbFuwKAG0ZGAr9JEVUIJoxD9Qx3h5Tavyg4T5BifUW8cccC6ssLL6iiiYnyOoETpgiS4JpBMxzos2P07owHE0tXBIhCPY8r1gkeOwzSCoCRB6VXC29m7/vhLKpDmtNCYlVqE4YxIabxIdTQO3Squg2ZWmc+ZDFkLkic9J+qnvWazYKlNRasw6Qw6BECCB++OkGoATTU4ScAz8jHv1OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7QgAtHXgjpyQsmBtz+lTysxcXBTnpK16HXizVAisRo=;
 b=nz4tcjw47AC8aNKjChD78063/RMY+GQV5zpBA+6oDSn70SwxteFm+zd2QpgRvYe29N4ynjZBNNoxNCEVxiAf7Nui4YYjH8eJfYFGoKLowcLe0dvClrregFf9e2u4IluG4QwDuKC2wJ0uugpCMHB0Sqr84MNcYKRDEk4m7ZboE25e57rZMT+oH/W2vWffqk3jF3d6AlTXWzl8Id5ZRN+5iC/So8kBqSI9mGY92reDDmBys2a/uafKTfAG8sca7aAAjDH1zRFqrI4SLPriPDSRYdtHOOjI/XfL5PM+9lX6YLJLWAZgIiTyR2QWNRXnKYR42Qq2d/RYMzY/wHSbh1IB7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7QgAtHXgjpyQsmBtz+lTysxcXBTnpK16HXizVAisRo=;
 b=Z3Imwy7ee2PAqrtWJF646jjuwXd4M0mnHDXjK/TI7b3/Rp3Xsa/6kW2LKmxVqcD9ujQ5Egscob3YsD1obxAxFLj5cUlbUsWYx6sFwnQofaz2tsaS3G+1+uApAy0uadmQIVQ1qrwR9YkR7trZn81H/yuUc5JJMZ9Sro2RV6IPiCs=
Received: from DS7PR06CA0008.namprd06.prod.outlook.com (2603:10b6:8:2a::15) by
 MN0PR12MB6200.namprd12.prod.outlook.com (2603:10b6:208:3c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:55:13 +0000
Received: from DM6NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::2e) by DS7PR06CA0008.outlook.office365.com
 (2603:10b6:8:2a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:55:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT087.mail.protection.outlook.com (10.13.172.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.38 via Frontend Transport; Fri, 14 Apr 2023 15:55:13 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:55:10 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 56/66] drm/amd/display: Add extra check for 444 16 format
Date: Fri, 14 Apr 2023 11:53:20 -0400
Message-ID: <20230414155330.5215-57-Qingqing.Zhuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT087:EE_|MN0PR12MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: 3032e269-1b6a-4b3e-e3d2-08db3d00a208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4YJ+rLOuJRx+vftBsMpX0qmKBOF45aeUbO49ThT9Wd9dVI0RySXO7Sxj+CbQrkzwCUfJEx31v5HaZC7ijy60sSWJGOz0kyWRTEV/Ze8GioeBvF2ssoETc/Ox0ZPzf976kKOoBZh8R+pyXGL9nTukB2iKHiGLD5Ss6LvVc+Vo6AIVn4j2UNgmeJTK2rBOxVCx6tyApAuLDwCtt1Wt0ejyQKkBRBVVxGiSUX+3Gybea5SCKyAIUnmPQzkvcbx+xiw1ODmIysRQHnEossD0iyc5qcHmZHIarXLM0UiPniW4hRyS3TOnAfCyEHU7caTtOzTv2sJe6XaE6kXS61T/Q9+T0GIeV85o6uEBZhBIxUhwXd96Q9cPi4C0YHvqNfg37tZK/0XANrQ+moHxgBFUtypdlVIaTOCJGVZcN09yrv5Rv73zHvCSHcIiiqlT5Cf+1ogWpWR3WlRdMfbEjC0olwS4C7TVSfTMZN/9e7p2YjDtxmbE3lFbWy3Xobiimi8hbZMxGmWlbqk+7eMsb/AKePn5Zg9/Epj87FgFNf+RJtpA3takYHcP+XLUZ/uSbaFxIT6Jhft+Nvq0doH5J6UqK2XmNqkr8Ou+sPcPH7ej5WI/Pe3i9kDlBtalA4V3n7DZU3x73wto3fBPm7bsKimDEkZMQjRNMG11+UQezLUlf9UyCvlFomLv6mbZuqgqfZm4MLD3i9R/ZjxHJ0s7eJFNEnt+TbEgRkdiG8ymxHpBjoPKUKk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(26005)(336012)(426003)(1076003)(54906003)(40480700001)(186003)(47076005)(83380400001)(2616005)(16526019)(36860700001)(40460700003)(6666004)(5660300002)(41300700001)(316002)(8936002)(82740400003)(82310400005)(8676002)(356005)(86362001)(81166007)(478600001)(70586007)(36756003)(4326008)(70206006)(6916009)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:55:13.0061 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3032e269-1b6a-4b3e-e3d2-08db3d00a208
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6200
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
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

DCN30 is missing a check for the pixel format 444 when using 16bits
before setting the flag that Viewport exceeds the surface.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index dea2b84e5ebe..9af1a43c042b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -5130,7 +5130,7 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			ViewportExceedsSurface = true;
 
 		if (v->SourcePixelFormat[k] != dm_444_64 && v->SourcePixelFormat[k] != dm_444_32 && v->SourcePixelFormat[k] != dm_444_16
-				&& v->SourcePixelFormat[k] != dm_444_8 && v->SourcePixelFormat[k] != dm_rgbe) {
+				&& v->SourcePixelFormat[k] != dm_444_16 && v->SourcePixelFormat[k] != dm_444_8 && v->SourcePixelFormat[k] != dm_rgbe) {
 			if (v->ViewportWidthChroma[k] > v->SurfaceWidthC[k] || v->ViewportHeightChroma[k] > v->SurfaceHeightC[k]) {
 				ViewportExceedsSurface = true;
 			}
-- 
2.34.1

