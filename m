Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B305C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Nov 2022 01:43:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5584410E25B;
	Mon, 14 Nov 2022 01:43:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A72E410E258
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Nov 2022 01:42:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUyS54IXSyFRJkWOPUJehpqzm6qDYdn15+9dEQsK2zIyOYAO3Q9YFeQDXxgtQuHl42N7Qo5HA0mBpOoyaLRlbSb89HErf/2vPnJm3uZ9Rd944V/gcLno5uvPosVOponlGdGYskf9OIulVM9fqXDkAgwNfr4rJQyjgKMpHsSS7oFZm4oojKcwL8SeBHzoFH+v9O4t0JkxIhwozqXRUp5N8+S0lhSduLbapCdIyc0Vz13f0Q9XqfuNrQqLkJQwC9AcyT1liQ6RL8hahJ4qOH/vBqeRJqHVwyE8DD0KeEvRyI2Es3L70Jk7CtAnemGGyOpJzfYEY+YUD1RSVr/mqmuOqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mVZUL+j3PxB71hnjlAvAqUzvfDLhre5v0mABTDcgHc=;
 b=aHCtRWfZLqDJQPrVPOGtxlEaIkb8/GHqeXBo6GPu02CxI1KfEqZlcfWhno+WryMQXDYT6MSwqspvIDgmtmS/LK9bB7QQ/VdOo8KmnERrNgUB7bAIGKHEhGmrFIsNQyGKvgUyTDa6LXNKsWDHUeyGteQMvSc1yNXCCMm6IrzHZYNeDzwWLfHe9viISmwUzYYAcF11RrASj/A1r8ytVv3DNQfv9T5HcoOISCdR/O3oEf4Zr+rEevigo36pEm+wUzYpXkxDi+PzsNxm4QgKu/wP9VZ+ic+IXvcs3uoBpZzoiVF7whccBFE5dIzkbtapxmy9ivtNtyVj19Hr9xOadfXNmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mVZUL+j3PxB71hnjlAvAqUzvfDLhre5v0mABTDcgHc=;
 b=oQP+cp3Qco/etgTtac/l7FDEF6L3Jd0KMseJ3J0F8N+/yOXGnsVt/mTz1Na/gBAXSttWbcrmITr4KjmVdhk/1wTdJndPxZwRTh4reOaM4AKDFFP9Tpua5izbE8ogWO1PPXvrVXkw2VKXSATnntNcw5e64fuqWTgoCfUCtVm0uBo=
Received: from CY5P221CA0038.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::24) by
 DS7PR12MB8083.namprd12.prod.outlook.com (2603:10b6:8:e4::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.27; Mon, 14 Nov 2022 01:42:48 +0000
Received: from CY4PEPF0000B8EC.namprd05.prod.outlook.com
 (2603:10b6:930:4:cafe::b) by CY5P221CA0038.outlook.office365.com
 (2603:10b6:930:4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Mon, 14 Nov 2022 01:42:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EC.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.11 via Frontend Transport; Mon, 14 Nov 2022 01:42:48 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 13 Nov
 2022 19:42:46 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amd/pm: enable runpm support over BACO for SMU13.0.7
Date: Mon, 14 Nov 2022 09:42:12 +0800
Message-ID: <20221114014213.1118084-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114014213.1118084-1-evan.quan@amd.com>
References: <20221114014213.1118084-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EC:EE_|DS7PR12MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: 866562d6-d2a7-4e57-4f04-08dac5e1890b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5mhhAnKSkIgwgiJie+BCVOYlcut8b49aYGRpp4Dg4nZJcFxNWUCplJb5FmEhz+9cySLMAdGdUIpUQY1RI++EsEMA/mAX0eDJVCgWIQUt+8fLS/gHz6BQekgbbv9/LAEqnTLg+QPAgmSfgi6L8z0t8H5GeABlKxNdI5Dh+rorBDZ7/rbUavNm6P+16jW3PopuhIT4cx58DKMAy7UmWXXBXuKjcvJyak8i9yOCsjQUCL9ySuggm0qX0UIb0qObhHQKGkCriIAixu+R/vTaDKLsLQILJ/UjPcBygBeUBlgpS4NL0dn6c1ipoxjZVnZ6GqTqcxOX3ylfyKUyEHFsy9urreH8KTT6a3b3QFJ+E85Q5vOwA8EUZ2gsMt/mJx5mektaMyEs0Rv6rdfEC3BpE2PEPutyX+TyOVzlQe+uIiUlx1bntOrNVpU8+WSkI1vcudqowi73pMqNDDcFeKx+a+3FE+2lzHUkEgDzHFxJIdB+CWjI0N/lT6Ed7wF9SpOM8ir6i3Qi+QrUWEJIPOfYAcuJsV1QoPMGhmz5ta7jCbTO/N2GE6oRQmNEZiW55+uBI4JYE6EvzGps4PbUdYnW0yoooChJjnWGxd9xwzcNRi96Gz1vNa2VX8Vmzvq/u8vTPgVT30zqa0B4PBVy4u8RBjygKSXnVsdm76wKQRMDUJf+D5Veov2ENVhkCSB/SiX5U60+iLJHauvZ85VvMpOkByXd6FkkI595jU8lfCCdYh4fq+It3Ip96O13Hz9ehDqBNTje5r7ycJyCytF9MyLruiH4y2EvapabTzNAtEZw5eUEhoin1HaOqGSoCJbdJpDboNbn
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(83380400001)(82310400005)(86362001)(36860700001)(81166007)(1076003)(82740400003)(478600001)(356005)(336012)(8936002)(316002)(6666004)(8676002)(6916009)(70586007)(40480700001)(4326008)(70206006)(40460700003)(54906003)(16526019)(2616005)(47076005)(7696005)(44832011)(41300700001)(186003)(426003)(26005)(2906002)(5660300002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 01:42:48.2941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 866562d6-d2a7-4e57-4f04-08dac5e1890b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8083
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Feifei Xu <FeifeiXu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable SMU13.0.7 runpm support.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Feifei Xu <Feifei Xu@amd.com>
Change-Id: Icf4ae80b232d6869598ba2b7039f152dbce14cd2
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 30 +++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index c4102cfb734c..cc6501114a06 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -122,6 +122,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(PrepareMp1ForUnload,		PPSMC_MSG_PrepareMp1ForUnload,         0),
 	MSG_MAP(SetMGpuFanBoostLimitRpm,	PPSMC_MSG_SetMGpuFanBoostLimitRpm,     0),
 	MSG_MAP(DFCstateControl,		PPSMC_MSG_SetExternalClientDfCstateAllow, 0),
+	MSG_MAP(ArmD3,				PPSMC_MSG_ArmD3,                       0),
 };
 
 static struct cmn2asic_mapping smu_v13_0_7_clk_map[SMU_CLK_COUNT] = {
@@ -1578,6 +1579,31 @@ static int smu_v13_0_7_set_mp1_state(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v13_0_7_baco_enter(struct smu_context *smu)
+{
+	struct smu_baco_context *smu_baco = &smu->smu_baco;
+	struct amdgpu_device *adev = smu->adev;
+
+	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
+		return smu_v13_0_baco_set_armd3_sequence(smu,
+				smu_baco->maco_support ? BACO_SEQ_BAMACO : BACO_SEQ_BACO);
+	} else
+		return smu_v13_0_baco_enter(smu);
+}
+
+static int smu_v13_0_7_baco_exit(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
+		/* Wait for PMFW handling for the Dstate change */
+		msleep(10);
+		return smu_v13_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
+	} else {
+		return smu_v13_0_baco_exit(smu);
+	}
+}
+
 static bool smu_v13_0_7_is_mode1_reset_supported(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -1655,8 +1681,8 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.baco_is_support = smu_v13_0_baco_is_support,
 	.baco_get_state = smu_v13_0_baco_get_state,
 	.baco_set_state = smu_v13_0_baco_set_state,
-	.baco_enter = smu_v13_0_baco_enter,
-	.baco_exit = smu_v13_0_baco_exit,
+	.baco_enter = smu_v13_0_7_baco_enter,
+	.baco_exit = smu_v13_0_7_baco_exit,
 	.mode1_reset_is_support = smu_v13_0_7_is_mode1_reset_supported,
 	.mode1_reset = smu_v13_0_mode1_reset,
 	.set_mp1_state = smu_v13_0_7_set_mp1_state,
-- 
2.34.1

