Return-Path: <SRS0=m206=6N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE1DC83000
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 17:59:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D29F21D82
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 17:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tt5DOZ1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D29F21D82
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A2866EABE;
	Wed, 29 Apr 2020 17:59:03 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770071.outbound.protection.outlook.com [40.107.77.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C19936EABE
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2020 17:59:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nv4aVRPOWsCJw8RzqmGhT1NFu3wRUKaKVpzEo74E9EwB6jwXXrUD/FU3ze800oBhiqyg2sYTYt1Uj0Th1tYA+THFF7e++DK+/ftKmDdFuRcoCEyoCIZRQ00YbNXk8sOQcCD2D+ZLLhiKn1E9plYIpLs2+jS8eJ6D0oia77SViqzk6uDN6TOt76c9ASEp05r8w6bi1mC/ZLz3w5+XF1G5H//woDv8A17T3AcAhJ8Uf5ndEUDcNajto4YHy3q1rJGd2Zq+rKgTL4qRfWtzrwUCukm6oYjsc8AIVHNAZ/PEllIYl/ZJ8TZLHv5ZFUkCGCwLere72z+I8CISo2PYZhWTZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bB/KqEy9UU7gLvFhZku4NpmAWw+ZDrWIKSnZe/x4lIQ=;
 b=ELMRZYqDwvdpqYukc7FTtId3hSgCpYZRTi2k7dAyRh45sF2feG+vtxI5cKQbUptkCpFjU1qdlLAFBA13eNjRHnquEYzKB83lfZgtWBc/qsgR+EhDJhljANz8U7qZd3RGoCv6BKnWkaZUrWPUVw76jT7nkh7bA/jkwV+PH9Pimdg1OoDVE34Y6Gs3nEe56fYIpsxfaFO4l0IPMueR2amkzxMZyS1AZHOc9gIjG6M4S/GnvuuAu5Q5lOKC6S1/PHE1YHCZ7UzCzp9taEQuY3pzsQOk66HlQbshLFucvs3xISL6svpi883y7t4NeVl2qwBqdrVN20rhfIpwt5TKIb252A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bB/KqEy9UU7gLvFhZku4NpmAWw+ZDrWIKSnZe/x4lIQ=;
 b=tt5DOZ1rKXKqFBkyESzmSq1KrZL5AitZ3K2nTd5eGcG7Wy0olnqtyHwQjxIhBNXKWSQ1wK1QAxT+ozgwTZWQ92FV+F/RzRAByBl0Z7Eq+EUDzSDHM291sjHlrQIyLaeuk9WjyCqOaEJGPIY4nZQn17/QQIhTtgNNgljHAB9uGNI=
Received: from BN4PR10CA0014.namprd10.prod.outlook.com (2603:10b6:403::24) by
 BYAPR12MB3462.namprd12.prod.outlook.com (2603:10b6:a03:ad::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Wed, 29 Apr 2020 17:59:01 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:403:0:cafe::d5) by BN4PR10CA0014.outlook.office365.com
 (2603:10b6:403::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Wed, 29 Apr 2020 17:59:01 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2958.19 via Frontend Transport; Wed, 29 Apr 2020 17:59:00 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 29 Apr
 2020 12:59:00 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 29 Apr 2020 12:58:59 -0500
From: "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hersenxs.wu@amd.com>, <Shirish.S@amd.com>
Subject: [PATCH] drm/amd/display: Add dm support for DP 1.4 Compliance edid
 corruption test
Date: Wed, 29 Apr 2020 13:58:57 -0400
Message-ID: <20200429175857.17051-1-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(46966005)(5660300002)(2616005)(316002)(336012)(186003)(7696005)(47076004)(110136005)(86362001)(356005)(478600001)(81166007)(8676002)(82310400002)(82740400003)(8936002)(4326008)(70206006)(70586007)(2906002)(426003)(26005)(1076003)(36756003)(6636002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ca235b4-8669-4107-036a-08d7ec66ff16
X-MS-TrafficTypeDiagnostic: BYAPR12MB3462:
X-Microsoft-Antispam-PRVS: <BYAPR12MB34623DC74ACFEC369DB5644EE5AD0@BYAPR12MB3462.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-Forefront-PRVS: 03883BD916
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZH7lzex9+FRmTJhs3lD6hHfusBJiPx4oib5utne+GOzlVgoX+vZ0q+rX03rO73rd2ORE+bXTwXlhTk4n17O2wOFCjzw0CZBmERwLQaYyh8iB/uq0HwwDItkkgKbOtgkUTIJyAOoMNFkrqyN6wrE+hnSXcjb1CArszYu0a7JzdvKTjwj2kuOXV6KLzkAeEH3FQi9sE4g4m0V3u7ay6jOTxTiPxJH/UV893LmM5b+GQZUFGt/WxOx4It29FphqtPs9251msNNo1st4drYGFjxw8ar6V7o1u7dD6TMU5YVl5O0O9y4fZzf5ycjD9x2qP3HXdj53qbZSQWXGndPPsRuS229bpUdNXbEPK2czWkr/Ufs9pNcJj8Aw0BS2IYV0sfrvyPfROzyPzFheF8wcvwQOjl5MEK89DAGzOyFBD+QpjZubJggz1ijul/wPOfoFBdBK1qdYOxjIA9iH0vru22tLRUY3qZb5NoexQvGYZoWaSqz25vP8+FHHKxVErK4XHhd3hAuaspmLmCNxIQNKdnF/xQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 17:59:00.6236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca235b4-8669-4107-036a-08d7ec66ff16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3462
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
Cc: Alexander.Deucher@amd.com, "Jerry \(Fangzhi\)
 Zuo" <Jerry.Zuo@amd.com>, Rodrigo.Siqueira@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It works together with drm framework
"drm: Add support for DP 1.4 Compliance edid corruption test"

Signed-off-by: Jerry (Fangzhi) Zuo <Jerry.Zuo@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 40 ++++++-------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index c407f06cd1f5..b086d5c906e0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -554,6 +554,7 @@ enum dc_edid_status dm_helpers_read_local_edid(
 		struct dc_sink *sink)
 {
 	struct amdgpu_dm_connector *aconnector = link->priv;
+	struct drm_connector *connector = &aconnector->base;
 	struct i2c_adapter *ddc;
 	int retry = 3;
 	enum dc_edid_status edid_status;
@@ -571,6 +572,15 @@ enum dc_edid_status dm_helpers_read_local_edid(
 
 		edid = drm_get_edid(&aconnector->base, ddc);
 
+		/* DP Compliance Test 4.2.2.6 */
+		if (link->aux_mode && connector->edid_corrupt)
+			drm_dp_send_real_edid_checksum(&aconnector->dm_dp_aux.aux, connector->real_edid_checksum);
+
+		if (!edid && connector->edid_corrupt) {
+			connector->edid_corrupt = false;
+			return EDID_BAD_CHECKSUM;
+		}
+
 		if (!edid)
 			return EDID_NO_RESPONSE;
 
@@ -605,34 +615,10 @@ enum dc_edid_status dm_helpers_read_local_edid(
 		DRM_ERROR("EDID err: %d, on connector: %s",
 				edid_status,
 				aconnector->base.name);
-	if (link->aux_mode) {
-		union test_request test_request = { {0} };
-		union test_response test_response = { {0} };
-
-		dm_helpers_dp_read_dpcd(ctx,
-					link,
-					DP_TEST_REQUEST,
-					&test_request.raw,
-					sizeof(union test_request));
-
-		if (!test_request.bits.EDID_READ)
-			return edid_status;
 
-		test_response.bits.EDID_CHECKSUM_WRITE = 1;
-
-		dm_helpers_dp_write_dpcd(ctx,
-					link,
-					DP_TEST_EDID_CHECKSUM,
-					&sink->dc_edid.raw_edid[sink->dc_edid.length-1],
-					1);
-
-		dm_helpers_dp_write_dpcd(ctx,
-					link,
-					DP_TEST_RESPONSE,
-					&test_response.raw,
-					sizeof(test_response));
-
-	}
+	/* DP Compliance Test 4.2.2.3 */
+	if (link->aux_mode)
+		drm_dp_send_real_edid_checksum(&aconnector->dm_dp_aux.aux, sink->dc_edid.raw_edid[sink->dc_edid.length-1]);
 
 	return edid_status;
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
