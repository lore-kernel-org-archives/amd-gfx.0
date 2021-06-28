Return-Path: <SRS0=DKNW=LW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0A7C49EB7
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 02:55:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58DA7616E8
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 02:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58DA7616E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01F046E04E;
	Mon, 28 Jun 2021 02:55:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54F9E6E04E
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jun 2021 02:55:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGNgMPGuDjcayrYivR1T0sPVtcACFjMWS3XEXUZxs/8iFnPEmCQt96YGY5oX+EOW2kUu6PxNJKBg/gd5cXlPCp5I74wY+CNlchgkHjZkKYxtGTW8TSzg1+vJ/AgAe9mvdHlVP9+YIl3wUQf/XehMgO1LN2sfNh/I1Y3gxWqlfSY0EoUGVzlCC4IB226yWFVvbd9GL8/EZjILoV9OCkk/nUQSHf0TfDWqY8LdEZPNjn6l1DqCdr75i2t/EFKpewipHzEuYv7OadFf063rGhVFtfi0ed/dYZOpM2UppmElM8qTw8Fv+UxdeUTIKUDDJVXGT5Dne3hZkvpuu8Epu3FK0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTTQojeuC/tRMp31kMObba9qtvfFLBc0Wh79jN+Ewr0=;
 b=gVYPvU2AdwPUI3BBF4Culq9gmBya2hwc4qit8TewYrEUXc5tJmZctZ8NPVdYipn0O4DGlf1iJdRFR1/rW/s3nXUPtIfdFAJsRtPQAZxgayLv3LqzFs0t2y8v5isH/N0sNsz3LKiCm6JtYwxqo71MWZ6uEIuSj4sVIZ7U59qdSDPO1X0wgff0ZGQSdQWuBUN/eUdkts+e4ocXEqzSGC2otiVWw16i6BBv1+Y5J9aoZ1CbBq4tVKEPp0mdVDi0prvlkE0JPftT4QtTie36cEntLukgIYTFK4PuxLbfRqdTtcbUq+sKdG8luQ332rS1fp2PnYWpfw/ALsrsZ2ehXKlJeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTTQojeuC/tRMp31kMObba9qtvfFLBc0Wh79jN+Ewr0=;
 b=3+eU9Bxvk7dGvOvTTzl+3906QXC1W4QS2FjKLu7/dldIfsb3ajLniyDdNseXg3XPymgmbLJo4p4KJcCqAljEN8DdAA/gAOlH05JUjJs/N0PQm6EUOVqoNDvcz9vg7Yahuu5w+zZ6LO/LShCY+Ixle3e2mJjYQgKiei1n6CuHZo8=
Received: from DM6PR12CA0001.namprd12.prod.outlook.com (2603:10b6:5:1c0::14)
 by MN2PR12MB3517.namprd12.prod.outlook.com (2603:10b6:208:ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Mon, 28 Jun
 2021 02:55:04 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::cd) by DM6PR12CA0001.outlook.office365.com
 (2603:10b6:5:1c0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Mon, 28 Jun 2021 02:55:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Mon, 28 Jun 2021 02:55:04 +0000
Received: from aaliu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 27 Jun
 2021 21:55:02 -0500
From: Aaron Liu <aaron.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable sdma0 tmz for Raven/Renoir(V2)
Date: Mon, 28 Jun 2021 10:54:49 +0800
Message-ID: <20210628025449.3404-1-aaron.liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d803b75-67c7-4f35-b970-08d939e0218e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3517:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3517E6F79589A42BE8A8A486F0039@MN2PR12MB3517.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8c3wyeeGl4KnGeGI4agvBkVnqspFZMwWPXxKe2TCfgl7Z3zCQrWVwifp6nJb+aqy6Mfnq+7H5lJI6juapo5yXwT5UifFBOB4CqBhBZV2ZQAun8tc+5DDhu7Ej+ID9daqGKkYqueB/qTSRwDQjo538eGvAQZ11pJioXzs5xgjyScv6WU+wUBkYiHbzFsg2fbdmd6l+aub9Io1dldMzAWb6lfgUDVPCrEELZpxY+7xOPDxMUViDTZIRTVmOGYV0RrWoMmWICBTYh7wC25XwsIaSNCTz9TrqAavHjQj7TREyB02ILZlAIWR6vAnYsNNYUAF3/m7+TFMsN8Mevl3RzpmwPHHjdinD/JIqYKDlwJugs88KjyUd237pMglh+SBMMEtm86oYpJpV3eDWbSsjgY1NsXs5QkKqLDFoszYTNYCszzBM2l+xmtnjatN3jP8+4P4dp3CexefNXOrMJFTPaHtio6BwasXdXJ44dFl7N+C4ScvlaNekWOCJSUdLWhJGKqxqO/v0JwRpwyVcphDmInqCSnVkM+YdLLLHmNY7zh60izavdpoGwr9bvvs9I3J6s32CJWWxHnYhea8osIQYRdMys0cT7kCWKW8husJhDeL14erlvaIcDK7fWPf1NOgPcrHLQ0hEV1LF6woSOzj9pcbMKFo/bSgA0sRmeer/MEbwdHripoyVbr5uj49blK8gSTl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(46966006)(36840700001)(316002)(7696005)(5660300002)(336012)(356005)(478600001)(36860700001)(70206006)(83380400001)(54906003)(2616005)(70586007)(36756003)(82740400003)(186003)(6666004)(4326008)(16526019)(26005)(426003)(2906002)(6916009)(8936002)(81166007)(8676002)(86362001)(44832011)(47076005)(82310400003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 02:55:04.7065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d803b75-67c7-4f35-b970-08d939e0218e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3517
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
Cc: Alexander.Deucher@amd.com, luben.tuikov@amd.com, Ray.Huang@amd.com,
 christian.koenig@amd.com, Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Without driver loaded, SDMA0_UTCL1_PAGE.TMZ_ENABLE is set to 1
by default for all asic. On Raven/Renoir, the sdma goldsetting
changes SDMA0_UTCL1_PAGE.TMZ_ENABLE to 0.
This patch restores SDMA0_UTCL1_PAGE.TMZ_ENABLE to 1.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Acked-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index ae5464e2535a..f6881d99609b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -144,7 +144,7 @@ static const struct soc15_reg_golden golden_settings_sdma_4_1[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC0_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC1_IB_CNTL, 0x800f0111, 0x00000100),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC1_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
-	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_PAGE, 0x000003ff, 0x000003c0),
+	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_PAGE, 0x000003ff, 0x000003e0),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_WATERMK, 0xfc000000, 0x00000000)
 };
 
@@ -288,7 +288,7 @@ static const struct soc15_reg_golden golden_settings_sdma_4_3[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_POWER_CNTL, 0x003fff07, 0x40000051),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC0_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_RLC1_RB_WPTR_POLL_CNTL, 0xfffffff7, 0x00403000),
-	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_PAGE, 0x000003ff, 0x000003c0),
+	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_PAGE, 0x000003ff, 0x000003e0),
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_WATERMK, 0xfc000000, 0x03fbe1fe)
 };
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
