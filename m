Return-Path: <SRS0=6vDE=62=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66B6CA90AF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 16:44:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBDA220714
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 16:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GxWWMDmt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBDA220714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BAED6E93B;
	Tue, 12 May 2020 16:44:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C52A66E93B
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2020 16:44:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZd8BYB938GkqIkvMcFPnMo8hN2oZMY/HW85JRpDBWLxkQ6L06+G1V0xvbZvGIRcdGaAoa073fTnxQ8zNG+OWVUG607Wy2mgPVQNDv5JM9wA9GHOAYlE5TDUTy/+TqZt8ix/ku5/dv93MRJVkJrdCKnb4WydGmKApjV/kbrvguuNoJsHc3mhG9kieldBlbe4CVcClGBTPugNMM6jWaD6ahyt42hNo0MM0tuPvAlhOAAzQGg1fTW/c9cEcIyVPc8N+fuRjYIzdZGGzu02G0rJy97PbFdMRdFQ4ha1uNLKnOjJX3nBGiXrs5WUulWmzyxMBh0zZ1Sq2DzVyZzAJoHIiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwA/9P4jvkpZSxDh9d9/arRPMZZ1K1Y6CmKN05CDoMg=;
 b=K3lRfEXaELWU66lw/AZQG0CNivf0iko8oQb716PbgWw+h6feNYdHVI0oohpoZio/xjk10Tw4fDVSx0Q9vV1iI4cUSqjxFp7/X0DpfRI0ZNXNelA6xjTAScf0QsUh8qZPq8Tc4WWzzGU6W9au6NdzWdfd9NUdzfbhgZ9q47DUV0aKWQ946FQk/JCtzZDFjql6RukS7CBbURM/RY3ktXX8yWVLrBLGHKrsgDqHmGA3N7ZsZehsCK7s97udxnvD8lswzNspWy1Cv0UFyyKmZy+58XVX6yI9a/XOFCgsS+6ot11TCl15WSFpRglfVVwN3i9a1kHplGYQ7zV7avvmUsi/Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwA/9P4jvkpZSxDh9d9/arRPMZZ1K1Y6CmKN05CDoMg=;
 b=GxWWMDmtgGdQQfqnEkTd9X9MRYcOrxuv3Am/Y2T+sNL6lic986aq6KnAy897EMm27n0SBoFbEanDtlF0Pd+3LI3pq6MQvfw2V2v6LYdsKX1ZpNSMQK8qRBfzTCwfFDiDXkpTYRs94PLEBvTA55DAsGmGZYDiKxr4c8eOh7vEryE=
Received: from MWHPR14CA0013.namprd14.prod.outlook.com (2603:10b6:300:ae::23)
 by CH2PR12MB4119.namprd12.prod.outlook.com (2603:10b6:610:aa::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Tue, 12 May
 2020 16:44:40 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ae:cafe::11) by MWHPR14CA0013.outlook.office365.com
 (2603:10b6:300:ae::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.30 via Frontend
 Transport; Tue, 12 May 2020 16:44:40 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2979.27 via Frontend Transport; Tue, 12 May 2020 16:44:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 12 May
 2020 11:44:38 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 12 May
 2020 11:44:37 -0500
Received: from hwentlanstrix.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 12 May 2020 11:44:37 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amd/display: Respect PP_STUTTER_MODE but don't
 override DC_DISABLE_STUTTER
Date: Tue, 12 May 2020 12:45:06 -0400
Message-ID: <20200512164506.26861-4-harry.wentland@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512164506.26861-1-harry.wentland@amd.com>
References: <20200512164506.26861-1-harry.wentland@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(46966005)(33430700001)(86362001)(36756003)(26005)(186003)(5660300002)(47076004)(8676002)(426003)(1076003)(70586007)(82740400003)(8936002)(2906002)(6916009)(6666004)(70206006)(478600001)(356005)(336012)(82310400002)(33440700001)(44832011)(2616005)(7696005)(81166007)(316002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e44beca5-5de5-45b5-802e-08d7f693c3a3
X-MS-TrafficTypeDiagnostic: CH2PR12MB4119:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4119DED46C836B9D267B49DF8CBE0@CH2PR12MB4119.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b7l37aqwzrNcqoqlAmbvrkYdUgRzYfQdqp9YDnJ1Po+gAwWHhjuhwr2lf6HxDKM+7ckCavN0z6w1RVQN9RNZuK7K9aWgN86Ma9VcrGWr4N1YvenQGhIrTwMhkeG2h5G/O4D4KK/Vrxx932BhZrg/zR8d91dgbJa7ekf26OnmdQdKh+YK07Gois3FJ03xnDk1qwXS34BwMUziHfumrNiuE052eFsKJgFKrVNvAzu4qAym8q9GeJabwepfGYByJCGBfHNff9A1BC8KMOKh5aK4HBcj89pMi06h+j8H14eYS5trd/BY80guzAjkWLtg5V+jTUan4p3jYkOvJ0loSwNr29jpF5NaijckJV2o1kKmhLF2RHhoXeqCJkPBlhfGH/TBpGdasOFqInHuPkNKZczWJ/2jgznxn6f93c3DZRtnkNBf96O9jCXCBW91umbs0wom94Vgx/ZlF4rQTo3BGSC2K0UXyMQRD9m+U536V8WbXvrqjRhFEyLPJ9toAiZaGZVEDavNVd48WqR8jYazzvjMkGPfVW6+o1rPxlTQWLIAXxSLYddJ12tTA2Zp+bsU/wNcJfIP4Q2xb3/92pA6Vcd7uA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 16:44:39.7503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e44beca5-5de5-45b5-802e-08d7f693c3a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4119
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
Cc: Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bf347ca43064..9d8aaaa33264 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -923,6 +923,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		adev->dm.dc->debug.pipe_split_policy = MPC_SPLIT_AVOID;
 	}
 
+	if (adev->asic_type != CHIP_CARRIZO && adev->asic_type != CHIP_STONEY)
+		adev->dm.dc->debug.disable_stutter = amdgpu_pp_feature_mask & PP_STUTTER_MODE ? false : true;
+
 	if (amdgpu_dc_debug_mask & DC_DISABLE_STUTTER)
 		adev->dm.dc->debug.disable_stutter = true;
 
@@ -3036,9 +3039,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		goto fail;
 	}
 
-	if (adev->asic_type != CHIP_CARRIZO && adev->asic_type != CHIP_STONEY)
-		dm->dc->debug.disable_stutter = amdgpu_pp_feature_mask & PP_STUTTER_MODE ? false : true;
-
 	/* No userspace support. */
 	dm->dc->debug.disable_tri_buf = true;
 
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
