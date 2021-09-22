Return-Path: <SRS0=EYW0=OM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5E6C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 10:33:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A1C60F4B
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 10:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 15A1C60F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7C7A6EB6E;
	Wed, 22 Sep 2021 10:33:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E5546EB71
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 10:33:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijV/nDPhRk3inuhnpGpXMsApRZV4yPXjAHCdCVOMxvuGlU6ZZDvJ1NOraT0t/yN5F28DHW+NNeArV5U4JqD/MuBFbB03I3GCpxMU2PSuN8NqMeKelpmfq7y0O9CUqT+uPO9WXiu4fXjsFCIbAlQFtaOlVR9ZE/guDZqpTTtfv+tjD7czXKzIGYVvfvPhX2bssm+g8UzilmlewTIaAOH7IaIZRNcGvPP8AmuFbg4y8hH6aufcbn57ivxj9S2rEBYkobqJ45bJv2SieO2OdKPkk/V3JLsegaylQdbWVVcnLJ2+hSAz3C9AaRLdDzzrdfGlSZoylWjbpvFHuh8SWdP1Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=GRVmciCZaVd1JF4h1ozWrNzXEJW0mqdPXubq5vZzfI8=;
 b=cjLxdlBWFiV4rOvr207XILDnfUE1z5KdOhMvO9s5bqxKbF+ue2eIaZ0v/EnaJIfTY2Np7v/8nhvsRTpZQn0XGsUFwHAzz6EaJpTAphb0xNBYsbbUOIboJ9JWCNsUEsJskOFNC8ddlibn5aTtpXzCizkqvFZPdTkh8rNlraGAZLO8Mq/6d6wq4QcsfHho1cVCANplDkwdBDbWLGKX2OSGJdGJPGdP8V39DMk3PWV6fI7w7CfS8SgO95f/Vj3JMcDm/eqFeSsAyZSh+VrI3LHk4zRJdQePUsoYonTUmFi/mLr1W2j/L+pmsWuFc6QsR+oZzwkp8LjWoNevzVJGYAKQ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRVmciCZaVd1JF4h1ozWrNzXEJW0mqdPXubq5vZzfI8=;
 b=GZ6QP/mToacd8RznCd3mTAgdOwAUhnDKi0b1twLSDADJs+cjpI7UxTiFk3j4ELGGsedmXzm6/x9xQ+hosPABcj1ohnKDpodqpmvRgKCfmPR4Bg+lVixIum8HBSEhUqq1Y3U15Y3nJj4t0w8heQ+1UytdfgDrcFya0C9Rc9+ttBA=
Received: from BN6PR1101CA0007.namprd11.prod.outlook.com
 (2603:10b6:405:4a::17) by MN2PR12MB3247.namprd12.prod.outlook.com
 (2603:10b6:208:ad::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Wed, 22 Sep
 2021 10:33:04 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4a:cafe::92) by BN6PR1101CA0007.outlook.office365.com
 (2603:10b6:405:4a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Wed, 22 Sep 2021 10:33:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 10:33:04 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 22 Sep
 2021 05:33:01 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <john.clements@amd.com>, <stanley.yang@amd.com>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: skip umc ras irq handling in poison mode (v2)
Date: Wed, 22 Sep 2021 18:32:48 +0800
Message-ID: <20210922103248.2401-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210922103248.2401-1-tao.zhou1@amd.com>
References: <20210922103248.2401-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a259381-732e-41fd-4264-08d97db45c21
X-MS-TrafficTypeDiagnostic: MN2PR12MB3247:
X-Microsoft-Antispam-PRVS: <MN2PR12MB32478417B808638E11DDA751B0A29@MN2PR12MB3247.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QW4ZVGJpiJhVxiFYGzpGlQheHCYxe2tm1OpGDHBrTh21CiYjQREdaSvGxEKdHNBhM0mT1vJ/j3E6WHIO2Q7x6TBXx8XHkNufsHJFN3AqpkTrguAqM6dusRNWxHXUKwh57HrwZBrOXz05mK9hrlZ30PFcwLCUSJvR4OwxWNkWIALmeh7IA/L7EzZ6bYgrzLrRXDJjuk00J+ffaWGf+1xI6VrsDdoTb6Go6dRXQ8OQPd16gjNUHFzqSHSAP0d4iz9rsmEO2+MhdPCX7GGhoIE77ajhbyyGqNk3lKVDJmk0LU0HBw83UHQYzy/pt9KXT8ez5NExEsRA5c2VVUkKR8WKPaSePyDg8AKkTg9xI0DXizgm7/Nbw+882WscX37/pNHTWxayi+dT+VT9mFeEionvGoKXujpKXiGP9qCFnDW0z3BM8z9240qdeUszTRLb/AfyvynH/Dt6+azwuhMWjApxyjaLpsUYR5eliXogmud8eXXaMXQN7J6Cm98agw4TWemwcQVP8R6UCc00DZP/o5Zumyu/3Zw9lKHYQyXFh4yBpv96ROZq6mHf73pSRuFVxmzdAO4krTX/XZRgjBIaBTb4oXIFpOZmHsOQB1HHiBw4vw/U7zOFVFdyMtwLkKR6xuu/Fm07BSykD8S46DGAJ61Bv6U9oZzR1IM5ufxlXe0l8lirDItqdLtnP2MyRbuNmsulRwd0cqlFqu+8ZFbNEgUvtmBR/LgyC74qCI827vIliKY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(508600001)(2906002)(47076005)(82310400003)(36756003)(86362001)(2616005)(110136005)(8676002)(36860700001)(81166007)(336012)(7696005)(4326008)(26005)(8936002)(70206006)(83380400001)(5660300002)(6636002)(70586007)(16526019)(186003)(426003)(356005)(1076003)(6666004)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 10:33:04.2464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a259381-732e-41fd-4264-08d97db45c21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3247
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

In ras poison mode, umc uncorrectable error will be ignored until
the corrupted data consumed by another ras module (such as gfx, sdma).

v2: simplify the debug message and replace dev_warn with dev_info.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 33 ++++++++++++++-----------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 5b362e944541..6fad3e1b8c94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1544,22 +1544,27 @@ static void amdgpu_ras_interrupt_handler(struct ras_manager *obj)
 		data->rptr = (data->aligned_element_size +
 				data->rptr) % data->ring_size;
 
-		/* Let IP handle its data, maybe we need get the output
-		 * from the callback to udpate the error type/count, etc
-		 */
 		if (data->cb) {
-			ret = data->cb(obj->adev, &err_data, &entry);
-			/* ue will trigger an interrupt, and in that case
-			 * we need do a reset to recovery the whole system.
-			 * But leave IP do that recovery, here we just dispatch
-			 * the error.
-			 */
-			if (ret == AMDGPU_RAS_SUCCESS) {
-				/* these counts could be left as 0 if
-				 * some blocks do not count error number
+			if (amdgpu_ras_is_poison_supported(obj->adev) &&
+			    obj->head.block == AMDGPU_RAS_BLOCK__UMC)
+				dev_info(obj->adev->dev, "RAS poison mode\n");
+			else {
+				/* Let IP handle its data, maybe we need get the output
+				 * from the callback to udpate the error type/count, etc
+				 */
+				ret = data->cb(obj->adev, &err_data, &entry);
+				/* ue will trigger an interrupt, and in that case
+				 * we need do a reset to recovery the whole system.
+				 * But leave IP do that recovery, here we just dispatch
+				 * the error.
 				 */
-				obj->err_data.ue_count += err_data.ue_count;
-				obj->err_data.ce_count += err_data.ce_count;
+				if (ret == AMDGPU_RAS_SUCCESS) {
+					/* these counts could be left as 0 if
+					 * some blocks do not count error number
+					 */
+					obj->err_data.ue_count += err_data.ue_count;
+					obj->err_data.ce_count += err_data.ce_count;
+				}
 			}
 		}
 	}
-- 
2.17.1

