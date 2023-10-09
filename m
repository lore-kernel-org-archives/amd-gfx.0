Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AC0C2BA1B
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 15:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEDE210E142;
	Mon,  9 Oct 2023 15:55:05 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25D5710E106
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 15:55:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWd8+BNxhonbkzGfKrvcdW8k4dCzpGkHyWTCcM5mny6ExGGp5OROClTPC8yujO9J9SZCL+ue1aFPA+4fvNZhA9SnGLB7YdWC4d+GgMfWlgAK6GIYndxSelBcsbxJqM3DhGy8p1PaztQSZf3E3mftrFAZX9GplBIA73lpdz40kjsplcxfSLWsq3Z4LTuRmSg4Weog9r++AEW+GNDTt+ZIA0EyJs37CZUhwz4Xnase3dakCDosBW+66SUEFGSkUPk4miQ1UeQuyJSqHY9aURFLmpCTZ8BtrWT/oTT1D+l9bRUIqYDdsBtGeZGSzQgIU8BT2MtYFoo42tDLd/v0LmEyGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7TX7Sh/yndcfynpSmI1+RG8SDnhSK6FQKw/fwEJ3To=;
 b=fr3R1gE34Qo6ABHyX+ZpD5AFxx03/FocmfZ3ePhmuaey79+jtawY8BHEvobgTCa9Ds16kLLzlIla7MqHF4y2bSghimRnTL9Rv/ybCmvco5SXmAq/UBePUJRzQqJWC9ocMLje4V2n8eUMwePAn4Sj4CrL7RLzA/LwSeLbhSHjyazradQR+szViFlgHY6+1owcA5108oa0ZAhu7GNX/NYLIEpmC4r7vLnakr4c0T8iue/h1F9inq4rX/+vzXlOk7QdFKeNL6fzlGHrSH/66e3pG6Awlf0gr3G+6hALwveyeDzhV8pNNc2OzzY8eKZLoiuvmjIWoC5Os4hb2Ve7BbZjmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7TX7Sh/yndcfynpSmI1+RG8SDnhSK6FQKw/fwEJ3To=;
 b=vp5SQ45balD2ULTcEk7hA6pmHRP4UGK+jJorLmDa2RZjPNCXUkUi8arkqIClhS0MV09rtLcQPYSfKJdPnmhzaDAkrbl1Hg3+Qthz0uuy2207mPR1Dog0vuxAqpFa65KAsRqF/+JwSstcNNraGVtcrtSFDTDJOAejXqLcoNL1F/o=
Received: from CH2PR16CA0014.namprd16.prod.outlook.com (2603:10b6:610:50::24)
 by MW3PR12MB4473.namprd12.prod.outlook.com (2603:10b6:303:56::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 15:55:02 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::b7) by CH2PR16CA0014.outlook.office365.com
 (2603:10b6:610:50::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Mon, 9 Oct 2023 15:55:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 9 Oct 2023 15:55:01 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 10:54:57 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v6 5/7] drm/amd/display: Catch errors from
 drm_atomic_helper_suspend()
Date: Mon, 9 Oct 2023 10:54:24 -0500
Message-ID: <20231009155426.96232-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009155426.96232-1-mario.limonciello@amd.com>
References: <20231009155426.96232-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|MW3PR12MB4473:EE_
X-MS-Office365-Filtering-Correlation-Id: 99fc9a87-a367-49cf-8872-08dbc8e018a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ATq0kmuOF+wbWpjV6MbIfPKwVkvqE4S2LY2el9VS14SCxb45MuVZoynwwhJPRfH9mEpdC0m9NAHsKk57oQmmGh3hHGh5wQyp0MaDdNqFlbHsklXkujz447vkr2OpRPfhCYx8/CL9fsC6h64FHbweDvw2ym9xzLH8LEinyDFA8hfh6rcDCr78cQ79jZYd8vLrgEUJ7osnZPENdSyahcihikCbTeCNjOvok1gyBCnTbAY8H7eF4qmpof7C73NJDDE0hROmvXz7NXAs848/EvkvdhEQBATymmxU8o79nFsB0ZTesbPijnrWmuBWrbP744IryYndJR+MlUYpP45RsVKo5nGJDLFKJRqIUAszgnjKP+r2dcS4ofuUTOQNqGmkj1BTIHwK5rU5aZiWhyw95Q708C8N/Fi31E7U+oz90bSUpM62x24EoNIvCCZ5gvCic4UM3K3sHXCem5cW41ZMnZtI73Hv5hRvcq8eNkClClsfAGcuGn5cg8Uc/c+or8am3SQr5eyAXLWkDVWOEsmXrk0+6sPHLsZVVs8iDHAns5I31KDfD8knxB0V2Ecl8F8nZU0LLC1Bg7C2RrYDSaneLZzX7fjf8OVogLrlfZuXOXBL+umiYo95raEnZXZ4LAHs8fPuewhv1qjB4YObNJyV0SYFzN3Zf17aouD01iVnMKuegcg3TXd91v3LB2CDWQFRSfMB8NzLfdIoKc619uW/stvg1AKtX+o5IuOv9dtlOaULYKifFoBBD4aP0nlFwhl2edSa
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(82310400011)(64100799003)(186009)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(2616005)(336012)(26005)(16526019)(426003)(1076003)(36860700001)(7696005)(478600001)(66574015)(47076005)(6666004)(44832011)(8676002)(83380400001)(4326008)(2906002)(8936002)(54906003)(70206006)(70586007)(41300700001)(5660300002)(316002)(6916009)(966005)(40460700003)(81166007)(40480700001)(356005)(36756003)(86362001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 15:55:01.3578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99fc9a87-a367-49cf-8872-08dbc8e018a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4473
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

drm_atomic_helper_suspend() can return PTR_ERR(), in which case the
error gets stored into `dm->cached_state`.  This can cause failures
during resume.  Catch the error during suspend and fail the suspend
instead.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
Acked-by: Christian König <christian.koenig@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bd6cb8ffda7f..97e21bbac5cf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2698,6 +2698,8 @@ static int dm_suspend(void *handle)
 
 	WARN_ON(adev->dm.cached_state);
 	adev->dm.cached_state = drm_atomic_helper_suspend(adev_to_drm(adev));
+	if (IS_ERR(adev->dm.cached_state))
+		return PTR_ERR(adev->dm.cached_state);
 
 	s3_handle_mst(adev_to_drm(adev), true);
 
-- 
2.34.1

