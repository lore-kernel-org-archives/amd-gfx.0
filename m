Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3800ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Aug 2022 06:36:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37F9F10E1F0;
	Wed, 31 Aug 2022 06:36:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9133910E1E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Aug 2022 06:36:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqeEP2lyDp3RXLjiTdlPW/xR+mfEm17tDmkQXe2A32w/RhFv3VFmqdfJmRlOvtSCiKmF+IQyTvbtbL4jvb7dE0ezbyQZ/IcFSJvY6yHQ3G3RtEUH2NRepaG20onqXw14N7ycvUDHPEYHvENXJ7vwPjjjguJsf3oxMggkTMI1sXrzexdk4P9yGkMrKxz7F2Lp0ZSjuvHnmEnE2M8sL+DDbZ+5AtjI+YFXBwTMLLB7V5Fs9O38HwzJ9L+B7u93zvi9FnABOuWd6AtSPqV4mZKCGNE/SaMYBHIlaaO2WI7kcq7Qqw6RggO0cMLQXatKxPNzpMqasGBRcmPGQVIATMELvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUkjkxOacNErz/SmIv9/3Mx9noGnFolPMjKbYoQd5Wc=;
 b=DkgBUFURhiOgpKBYbvskIpjCymaKrJVhebaEBMIMI+wWFLbQY60dG0Yc/tThe2HZWV9Rx1V7UmCIaVd6pzIRXWvN75EvGEIHzEZMFuLMTx5tn7SR5e/Ru5BwqYMXmXDgE4YUeIi21yIRBN4IBMsXtHuISNIynghS0loTNefA+1pQ9b/7kP0af/LKhKevII1NIC8TTWKZh93/tv3AorBUm8FYkHCIhvqQzxKYFrdlq8yrZHaYLHCjT+qMW2k5vtOG7RjXajWUCHGsNBlqctToFIsbozqr6uA1jVADWOvD8hQNaIxEOdBmUpCkVnjqIN5uzGD7sPaDDLP9xnI1r23z3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUkjkxOacNErz/SmIv9/3Mx9noGnFolPMjKbYoQd5Wc=;
 b=iElXGeLB0juI6LFktoS2NHtEw/wcPwWRsEBYuJD9U/apWcC7VH4ptz4cLeFvhnrnt3T1DCIsckkmQryXRLoVX09hxZPV3XpUe7XPqa0iqpMjE5ESbL5N2amrM9PNd59lAvhHPTJsK7Kj26OiKpBIzpdbo3tolKR4w/WIvQaxXS4=
Received: from DM6PR08CA0022.namprd08.prod.outlook.com (2603:10b6:5:80::35) by
 BN9PR12MB5355.namprd12.prod.outlook.com (2603:10b6:408:104::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 06:36:07 +0000
Received: from DM6NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::bf) by DM6PR08CA0022.outlook.office365.com
 (2603:10b6:5:80::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21 via Frontend
 Transport; Wed, 31 Aug 2022 06:36:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT114.mail.protection.outlook.com (10.13.172.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 06:36:07 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 31 Aug
 2022 01:36:04 -0500
From: Asher Song <Asher.Song@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: remove a duplicated declaration
Date: Wed, 31 Aug 2022 14:35:45 +0800
Message-ID: <20220831063545.86428-1-Asher.Song@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1402053-674b-417a-f507-08da8b1b15e4
X-MS-TrafficTypeDiagnostic: BN9PR12MB5355:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: phOoyTmAbH4w+Q/UfzduIOAERuJPIF/fZrRSZ1ex7Ka4TUoh1VIhw9gQSbq5ibf5SIN8RwGSUsJn2wPdPsip2J4m2BOOsVxdPKTK8FymScd0mEQ4yHpxbd4NuRiI/zO5xHI8XsPdSfdFFkrJL6EI9znQNv067pJ6RTfEvX3ztV3MTd7muk92cUJrnXlit2jeYdV0Obyvx0ivviu8nOmfcgcT9Wxa3Kf46RxWOr5x9a1fk7+quOddDzd6wskRNZJ6xqHSfelxU6jFrIn3BMiMy5ejf+6cfi8Z41lTIlH5N/wSpvAvblJGh/Xvo8wv5ppGnunngvebbrMPNQ0bob5TaiHD1zWJPpt7L7XxKVMVJ2i7e2nGjuE731w0kVKWofi6bjAuAt/luCkgSlfmGJI7rEN6Fo7vNebGqFsFn+1dqDALudSZ3abUdnxgF6XmADVMPJmVZggu1feNDPo5LtmZCOw6ZmWNCOun+1LOyVFUsuS1B+vlY/ZzMFmn8/HRUwidcUaT0AiBkOI/a8J0CdDZz09VmKzsnqr83kradzEgGRch2JfuVr2XbGCV8T30Lxwq6HLc+Vp9PigEjX0z2vb+wgiua049BAzbbuSiE8zOyodhe08Tpdb8igdBByFfSIXHpi9BAuhTWMXX9wZhcnOsQJ8L+a8Fq0MUtFHZzO9joGgg6v+4+0DWJb9q0CWgruYIuRzQPXRLrSg8T3H6lW1PtCENInFow992FEpY6AfDKydbik8BLswVWGkIz/kAv7EQRH9vym/AlnXcMlkO3d8U+inMgYeQLXMlnI7N+gYwlDUspwX0GU3poferasYB0dTw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(396003)(40470700004)(36840700001)(46966006)(70586007)(70206006)(8676002)(4326008)(316002)(8936002)(26005)(6666004)(36860700001)(356005)(40480700001)(40460700003)(478600001)(81166007)(6916009)(86362001)(54906003)(41300700001)(82740400003)(2906002)(186003)(336012)(16526019)(1076003)(2616005)(4744005)(36756003)(83380400001)(82310400005)(426003)(47076005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 06:36:07.3113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1402053-674b-417a-f507-08da8b1b15e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5355
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
Cc: Asher Song <Asher.Song@amd.com>, jun.ma2@amd.com, flora.cui@amd.com,
 Guchun.Chen@amd.com, yuliang.shi@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There are duplicated declarations of i, remove one of those.

Signed-off-by: Asher Song <Asher.Song@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 9f8976b18839..7f6c977c4981 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1025,7 +1025,7 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 
 		dcn32_merge_pipes_for_subvp(dc, context);
 		// to re-initialize viewport after the pipe merge
-		for (int i = 0; i < dc->res_pool->pipe_count; i++) {
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
 			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
 
 			if (!pipe_ctx->plane_state || !pipe_ctx->stream)
-- 
2.25.1

