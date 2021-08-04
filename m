Return-Path: <SRS0=biE/=M3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFB3C4338F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 07:50:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EBF60184
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 07:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B8EBF60184
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04BB66EA03;
	Wed,  4 Aug 2021 07:50:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C72746EA06
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Aug 2021 07:50:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGpilV0Gp25999jLQdl0E9+CFwcXjRJThRC5FkmDDt1hnhTlJik/cm92EHEac0BOzLgLy1s2vdjGz9Jh5cY88DFvdGLP0MsAA0N+PQWypg+Pv0O4v3slVUfyfhVKXaiPnOFMhZnaTmSoK1o3uCTuLgeWs6IKm9cKRxMPOJXPPT4yDInDFldHusyVPoA5nhCvLh2Rs308Swwgq+fgmv2GkkrgvQSfN8Ode0Ggr6wFTyyrtoKp5Tn6bgqjibVEMBEQvh4elq+fSzue8FU4KqNGpRFBgHdBjMar1sfPnPppGDxN0nJ8fNff3R2j87v6oBpZK4l0zvYy1GorvWm0aE/ZhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kpw1/Er99hGYSyc9hxe+f1hgrToZ4wgQHHAQtqv29aI=;
 b=dOdVeKS7r1CvCkFCq8TVzu47bG/ZyDo5AW/NpECrRxI+FgC3uTEE+Cy5WtUDr4uSA0ngmJHhf2Ivdi4odJ8dlfTZTrQ20QKu360DPz1Ea1cEAgRNoJT67elBqUQpQ0BDGViVWXHz5hU86ebb3/Y3qQpdOCYWKn9mMaPTqtZCgjA7oy5K6O2CQ6JjxCAOpE4shk/DfrTn03i/RwpbHPFe+laK/rc2mwW/OfRMD/W76MCqzzKU6VrwKLpQ9bIRM9sxssxJk4xrN3LVFzF4bFsF4vGKau2PhRYxbkkgIigUncMxNlUDKWKwwUfgBeMsd4XjVldnC7MxDjUJg5erDVMooQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kpw1/Er99hGYSyc9hxe+f1hgrToZ4wgQHHAQtqv29aI=;
 b=3OT7sQKhGgl0GnHucEt9JX5qsaY9pVPUwnDPcUqCYvhUaA0YiWCF5kCzdqkph9qbe6/7Kqdr/RD0CkihWxew2ofopRjc3NQFnNXRNYlcs36HIqmbXtPvh2ZJkx6x73oiwYFPoamPZJ9cDRsK12CxD24RYgBBpg5fuV3Ut61aAI0=
Received: from MWHPR18CA0029.namprd18.prod.outlook.com (2603:10b6:320:31::15)
 by BN8PR12MB3442.namprd12.prod.outlook.com (2603:10b6:408:43::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 4 Aug
 2021 07:50:42 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:31:cafe::7f) by MWHPR18CA0029.outlook.office365.com
 (2603:10b6:320:31::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Wed, 4 Aug 2021 07:50:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Wed, 4 Aug 2021 07:50:42 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 4 Aug
 2021 02:50:41 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 4 Aug
 2021 02:50:40 -0500
Received: from willgu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 4 Aug 2021 02:50:39 -0500
From: Jiawei Gu <Jiawei.Gu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <david.nieto@amd.com>, <emily.deng@amd.com>, Jiawei Gu <Jiawei.Gu@amd.com>
Subject: [PATCH] drm/amdgpu: enable more pm sysfs under SRIOV 1-VF mode
Date: Wed, 4 Aug 2021 15:50:24 +0800
Message-ID: <20210804075024.9407-1-Jiawei.Gu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50549ac9-54a9-4dbf-37e7-08d9571c8f34
X-MS-TrafficTypeDiagnostic: BN8PR12MB3442:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3442DABA04F41F69AF9FFEE4F8F19@BN8PR12MB3442.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZlgvPX36XDzJtoZbI4HofETjxndwYQEPobYXaFH8A49igV0xbhs8EqA5MfLfYOkmaCecqTyjcCUmT4VXWj0ibev8ILEoxPYVGeJD+/XtqHESbxu/tx/6E2EoRNGBENdLskSOk7tBZpFuPOHu1EMpjaxajPxzc7QiuMhnFEFnwQ12AaJXL6GYbFPdQTJNXECu/XD14BhGZFIr5iABsMDcq+N/uH+6m13fFitpxCNZ8o7uZRKndDsTKIiXGMGGWmRK3ZsQintytOXHfnevRxmc2yGjl2zs7quDnGtBxUYuc60wg9nt2JQIiF/uBxLzCk+swMzynFt5OL5r6IPfxYBDMUxryrrYMFkOwoFbA4Fo/xNucFFSNY8Rq5eCKTF0qc2XIijzAIthbImG6B3JCRq5EvdwSrhmvRcv8tXU2/rdjckbfA0xZKQN8c+pl0UixqOrKWc1U1K6vmq6nRy0R03KjoI87/8O7g+WWBL03rwYCTqjG/pgvpZInnPFlxT75a0bHB33rtT+Nb89r9CN9XgXUVMG7AlGtns5Pkzj0qvbiCtENeEPCRUzn1xAD5MQe2fsStXrhoSjvckPKIpQ24x1WdCW+VhM4DfNKG4riMsj1bYF3Ol9SC1QdvKdZDh/46/bFiHPdbobpzKP2MW54oIsuHJLwZ3zN9+e+XJ9CJHEbZsgKL81G3i2odL1g1eCR9A7WQEYc7XzvNeDVM0ZfEWk0AKwvKOdYuzCgAUY7P6vL8E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(36840700001)(46966006)(336012)(2616005)(54906003)(316002)(86362001)(82310400003)(426003)(478600001)(8676002)(81166007)(1076003)(6666004)(5660300002)(83380400001)(36756003)(6916009)(186003)(26005)(356005)(7696005)(2906002)(36860700001)(4326008)(70206006)(70586007)(82740400003)(47076005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 07:50:42.1221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50549ac9-54a9-4dbf-37e7-08d9571c8f34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3442
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

Enable pp_num_states, pp_cur_state, pp_force_state, pp_table sysfs under
SRIOV 1-VF scenario.

Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 769f58d5ae1a..04c7d82f8b89 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2005,10 +2005,10 @@ static int ss_bias_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RW(power_dpm_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RO(pp_num_states,				ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RO(pp_cur_state,				ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RW(pp_force_state,				ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RW(pp_table,					ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RO(pp_num_states,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RO(pp_cur_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_force_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_table,					ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_socclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-- 
2.17.1

