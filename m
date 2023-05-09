Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46453C7EE23
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:11:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A335E10E40A;
	Tue,  9 May 2023 22:11:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD26910E412
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:11:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpKQj+vwHBOeKPHb/1zmC9a2zOJuQEOXkHQqpKhpIORmUNeynzq1iPUK+mJSU+nZVSP03JKwTLfFc9Ys/la6ekIVnZGAI4KLPL6zgcramo9+jk/g8mdFjIgKBVxMkeiXu+KnnBIQ4DCQzY2Ge0+xdnR8CkIjXzGVIYDVenv3Zvdvm3zGVNRVbR8Txh/fKeZikiga/ffjDPZfM521tQPt33nDhTTnvXL22eBGKMA8K0XigplUTTz4RwYSQOx+7XhTQVNFDObmBb74uWPa4QdghGi33Cb9SMrVMGQizGZY2nPRpB2ApiqHWnNXpYBLWo2JLnYL4U3Ds4cfR7rbNgP2Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Mh7uF8la1LsbNio0YAINcZ3b7gb5FrRKrl+Us+B2M8=;
 b=EUEdY4Afyaw6/AUTrO12Q8GE3aKDw/pT2n0HssTlCFef9cfTaYxVbQ1Mz9ALkOaUyazm/TpFiTvunHxDvB0cxlDiFcdxa3GABEsTBv/crS0978qCqVxQd2666JdUUIl55Yp2vxi7G5Kuj/78DzrzjqjytC8TON/Oev5IFP8W1BD3oRAuM3VoaHO/v4N6BeJy0QaL2+Yh+KkdC/iPGlo0/vJZYBvCIEdagn+6X5MTk6YR7T5RZbiJjKt5WHHsniv2e1UYF1ie3l6wPERWVZx9AoOLanfqdXLAG5PTNpYlD+GCMgywsZqTWvetDRtUYCCOrlUmh0neMocxEq/hcgZqng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Mh7uF8la1LsbNio0YAINcZ3b7gb5FrRKrl+Us+B2M8=;
 b=bCAZabyIlEfh3X1rNLRo3yD+URkFfZBX3rOaEF/kwKeDPpCxin8VjeQEYSp9NOOb/0S2k9WCG+9O2atVGJMO3PCz8ANGZhKU0vglS7e3PQuk8fTV88Y9TqwZ2Vw3Z/Bx4yUzl4EkLkuogF4tmMgHhK1o/l+wOQAQzMxHdEb+WGA=
Received: from BN7PR06CA0043.namprd06.prod.outlook.com (2603:10b6:408:34::20)
 by CH0PR12MB5076.namprd12.prod.outlook.com (2603:10b6:610:e3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 22:11:43 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::18) by BN7PR06CA0043.outlook.office365.com
 (2603:10b6:408:34::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:11:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:11:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:11:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/12] drm/amdgpu: Load vcn_v4_0_3 ucode during early_init
Date: Tue, 9 May 2023 18:11:17 -0400
Message-ID: <20230509221128.476220-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT015:EE_|CH0PR12MB5076:EE_
X-MS-Office365-Filtering-Correlation-Id: 57cdd829-2fbd-4a3f-56f6-08db50da5f56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XvJ/md9wX1p9S9g+GkvUe9LLmcEtaAMVNypXPgRL5LAENijvo+9tFhL7pAMhKkXCDpnLzROm26W7vnGWBLaF2GWlpmbOtY43BGQcczfQUsNfb+w8SyaXcMq0tfMv205QmA637XoEZMjBpYEzTT+2YTjlyqVPqtIK2xPLdUL/ETyIRcleqZMD0oIvYl5gmRcyJOuRlFYvEB0uj3cLvpPtGveEcd+PB/JFknAGIkcjmZVPO+NjTrRNXNWbhZVPe0ahc2qiHeIGr3yAM0VuniKzQLroCZmZLj63wKw/zgn6f29WxV64irHzhWjBSyFWJ91s2FtKB9zFLrYPv7aBP0TzGD+9khC8nt6sxlTJxp9adsx7xw0eJ3hGOIzD6Cu0L5Wz8zdUl/9Xm0EVHgpRn7eUWOrYc11Y2JHqifKMgEyTTJKf82n5aHtZM8ZapR/2d6DDvcT0n2KHrU6Nc4wVoYL20saHnGDw5UjCu/5jZ3pLte8E9frFY0VDxzl+wWVbNV+A9qbRNLaoe80d0/dp4XBMlNqKhoSQh0fTGACwhz0vIWEOqS9WB9AgEJPWL+PsaWtCcA66nJk1hagILTm6NAAd1KR9Ox/mKCSZxz+iarML1BWgmLnAQAbhdgi5LvDSfCjcNlru0tRiisSzhrHTRpa27A8Kjg6Pceit81Zf2zBZ2FhmvhLJGzCU2M/+WrWMJi7kIvHxP5gM13ymElSQkoa1zmWoyUbExZfjUP4g/OYoJys=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(83380400001)(336012)(426003)(186003)(16526019)(4744005)(2906002)(40480700001)(2616005)(36756003)(86362001)(82310400005)(356005)(81166007)(82740400003)(36860700001)(47076005)(5660300002)(8936002)(8676002)(6916009)(70206006)(70586007)(4326008)(478600001)(6666004)(7696005)(41300700001)(316002)(1076003)(54906003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:11:43.5174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57cdd829-2fbd-4a3f-56f6-08db50da5f56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5076
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 Sonny Jiang <sonjiang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sonny Jiang <sonjiang@amd.com>

VCN loading ucode is moved to early_init with using 'amdgpu_ucode_*'
helpers.

Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Sonny Jiang <sonjiang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 746df23b2eaa..308dfe80a87c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -69,7 +69,7 @@ static int vcn_v4_0_3_early_init(void *handle)
 	vcn_v4_0_3_set_unified_ring_funcs(adev);
 	vcn_v4_0_3_set_irq_funcs(adev);
 
-	return 0;
+	return amdgpu_vcn_early_init(adev);
 }
 
 /**
-- 
2.40.1

