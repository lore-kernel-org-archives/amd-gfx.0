Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89888C432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 06:57:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42DB960FD7
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 06:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 42DB960FD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D027C6E8E4;
	Fri, 27 Aug 2021 06:57:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8E8C6E8E4
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 06:57:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9Up512+MwFdRiXr/OYkqXYU+0SuGPecKX2Dk3V7m0xbxx9hO19WoPExrLPggybTuxDjSWtm8TH9VtD5+40KhU4vJOAsV3zBHsNNI9iylyunvBVOBLoaDxKy2gP9STKXTp29ZjmjL/kAzFQ7L83SfAaZ8SIHtZGZK0kqiqOV1fEBL/wsgDeGEMBbuWzof8pYytIvMPVWRaUqWFKTee3iKynej7bkkN5m+9QMI83SYsAmnVP2Uv2IPlZrow9x+snyKbDECctE+FNfOuMjJO7bqBDVdFilV0tsc1FCHNwV5AlRGNH7MoUcLyTvMZkgnmJ6iOWMpWdNYZeh5B9ZtxS8qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYF0wnTBh8pBV44S/F1UkgTLIEkN45cPY86YeyT4CTE=;
 b=YlHW/Y7ruEaYklvOP40JSqcRgQNwVblxVF9LS06n2aZ62GdB3JKfMxu4fBGjNpmeswdb5MbDX+gF7xeMtU2AQ9/+EK/Oq155At5ehkqVUhXYiVnP90sZehPBnYT5PqwcyxC14qeYwcM8fIZiXhlge3Dyuno+Oe93GCqENDmjf4jPMDxBKdnF9+Js9LwZNRtNs6zRtUQq2leYlhlBoRWLyELfOZ6W18BSWdgBD4/wUNW009fi9nd7HPUvNX/jC2elQiHMO6PvYD5F8HphtToN7/wHFyKhWAzE+57Po2oD/jYUK3KJ75Gr183fFYDmLLZZEf4OvSOIn4VWt0r1vX1gRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYF0wnTBh8pBV44S/F1UkgTLIEkN45cPY86YeyT4CTE=;
 b=ytKzHBxmYuQ5SYnYIL5Yg42Ij+3bFOvg+EaXOnu5r/4vBVR/+DTmVwQoJ98DVvZTUlfdK8MRR06m+qPHCGR53mozTZHjbAasnVj43XhyGN3lHZW2csAWxEDKPqYTO1zGsgAVv3TonnyTjogBAlWhFWMVAPnQCfdYMZUVn6ek0Rs=
Received: from MW4P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::26)
 by CO6PR12MB5458.namprd12.prod.outlook.com (2603:10b6:5:35b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Fri, 27 Aug
 2021 06:57:13 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::e6) by MW4P220CA0021.outlook.office365.com
 (2603:10b6:303:115::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23 via Frontend
 Transport; Fri, 27 Aug 2021 06:57:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 06:57:12 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 27 Aug
 2021 01:57:11 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 26 Aug
 2021 23:57:09 -0700
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12
 via Frontend Transport; Fri, 27 Aug 2021 01:57:06 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Evan Quan
 <Evan.Quan@amd.com>, <horace.chen@amd.com>, Tuikov Luben
 <Luben.Tuikov@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Deucher Alexander <Alexander.Deucher@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, "Monk
 Liu" <Monk.Liu@amd.com>, Feifei Xu <Feifei.Xu@amd.com>, Kevin Wang
 <Kevin1.Wang@amd.com>, YuBiao Wang <YuBiao.Wang@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Add ready_to_reset resp for vega10
Date: Fri, 27 Aug 2021 14:56:51 +0800
Message-ID: <20210827065651.459756-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc705f65-6864-448d-1048-08d96927e59b
X-MS-TrafficTypeDiagnostic: CO6PR12MB5458:
X-Microsoft-Antispam-PRVS: <CO6PR12MB54581D9184F04C755916E33FE5C89@CO6PR12MB5458.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WUatht/gKCm9qDu1lEfiETUTfyRTzWpZOwU1M9s6Dt2r3YWw02kwY9yPqfHpFUOMrfo401SvFQAq7tILaYnYVLxgOqPNddvqUkE8+gvbMBQ8VrSsBeoTCppAm2zom4MrnBJLL8mQlqBJLm1iVQEPDdjweRlSafigC2HYFdkrO3LGkeUeeQMMhj8edjp4tytDegyHX0NfaGGhjZjzdO42/xi4dkE9bbQOtZE+KBsbXCnj7K4BS7Vznumo4v8FggrT0ULMbxypR5APQshphVVh/BcDRVGfRyDWYkZ4u1/HgUXac9cWbk/5OAtBxtBXVCfjzxU02VTb2d4fc6sd5lCOLnV083TtrnV2aocrC6ieclpm2jp7TF8Uvi6dfR5tCBcadl79qsJYPLM2Jg4MpCavyV8MsmigTB0q3ye/JIaES3BFv/n1niXP8g1/PtpBNM/kBPQP1GVIp2oDb8dPyIigiG6tckFeKUpq8FjUgiaThuHVpMd/QZt/gpAs/511+QoRQW+YbJj7v4QTvL11OvOFMScKXiEy11TySeGJiSmJ5dq7vGdDoYTPGsWv6Z1YHNK/9gXV/XwEke1AjXQqTk2jpxM2GcnEdUB9yn6sOUvs2XoJLJRdCtLA6avNY/c2+1xxAPP8ChPjR+It2dxCXubyGxmGafCNOLlSqGeXaEEa1yr4d+evNj3Pd7Nhj6LJhm4py4CcPSSLGu4ME9xeTl6gjWVfIyOcqN0h7WDv+qMIYMs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(83380400001)(426003)(82310400003)(36860700001)(316002)(47076005)(86362001)(54906003)(8936002)(2616005)(6666004)(26005)(7696005)(508600001)(6916009)(2906002)(70586007)(356005)(4326008)(81166007)(36756003)(70206006)(186003)(5660300002)(336012)(1076003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 06:57:12.4722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc705f65-6864-448d-1048-08d96927e59b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5458
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

Send response to host after received the flr notification from host.
Port NV change to vega10.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index ff2307d7ee0f..23b066bcffb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -258,6 +258,8 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 	amdgpu_virt_fini_data_exchange(adev);
 	atomic_set(&adev->in_gpu_reset, 1);
 
+	xgpu_ai_mailbox_trans_msg(adev, IDH_READY_TO_RESET, 0, 0, 0);
+
 	do {
 		if (xgpu_ai_mailbox_peek_msg(adev) == IDH_FLR_NOTIFICATION_CMPL)
 			goto flr_done;
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
index 50572635d0f8..bd3b23171579 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
@@ -37,6 +37,7 @@ enum idh_request {
 	IDH_REQ_GPU_RESET_ACCESS,
 
 	IDH_LOG_VF_ERROR       = 200,
+	IDH_READY_TO_RESET 	= 201,
 };
 
 enum idh_event {
-- 
2.25.1

