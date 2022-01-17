Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BB5C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 05:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FB3810EBF8;
	Mon, 17 Jan 2022 05:42:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7CBD10EBF8
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 05:42:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gphDPNRx3bKwztQ/JinqqAYdGv/Jo2P9EtsyNbD+EHRf7+cretQn/e7zVFhNt6/N5PpuW8TcvZOtvvXF8UtOF8dsGJ+hUaf/O1blqdVVPwNpmq+0a1gMl8zA1eVzASDi8tK58k7oVyvNdGHhWB7boQyw40yF79iQ02iaYI0Q88kQkq2vFaYg2AkhaU463cjYLl+rrW2XfYhc70NGyqe/PsIwHm+CvkElEza4bBa3bRfN3va5Ux0LzNVDoLAkuuGdeH9ppac/SOY7nCO2Rw+hTYYU5D1DSmV+U/KF44N+yW8TtZW2A4Hz5U7sk4GSzX8/LtNljbRWtNn56c9ar/kOCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2rQwtaSEI+LXxurkNfSbkvGqT1isuVWYjfHb4gYmdE=;
 b=A25xnMoQc9m6vtdJx0vzZhkhIRkV7tau9Hl3VePSWZ+SnrycAeE7ZKLaM6BB/hE80sNd1zYFLPvUb7HnE4HQNYxIj8jKFcTEQO/Et7NNQOPnVXZoGuhH+4H85Wjg3Hr2bitKo9nVckRRu/3dgLk2/NkwjlleB2MGhwuen9FoJTt4N8og1ChJABN5JHGKK2d/jdNjOtf/2nNCQPw6A7Nnk4Q8PK7pI1FUI9JMoOkZITpICxOiWBnX4UgR7SGTkf3zZt7qJiCdHVa1+3csttsEjEzoJsvRIoLYS0VxTzbDOhIsVGo1gchaikGYaXK/VcH6BQgpvb86tJf4eXtEMyh63w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2rQwtaSEI+LXxurkNfSbkvGqT1isuVWYjfHb4gYmdE=;
 b=Eq1X5ygpIDJdsh9LuI/4/T+DkMuGDxvPa8lWKKpbsg5zyhwcaQTxbGED6ZLPLyLNEMrF/EHE+WAMZTxmhy/NSFS64wi3SfUBMouSqYOPpNo10VgkBJKB+VowbL+j9VMIiNqROuvTAae3JaZBFmkr0zRwTJiAjqnTRbsYJqcRTUU=
Received: from BN9P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::28)
 by DM6PR12MB3642.namprd12.prod.outlook.com (2603:10b6:5:11f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Mon, 17 Jan
 2022 05:42:28 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::f9) by BN9P223CA0023.outlook.office365.com
 (2603:10b6:408:10b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Mon, 17 Jan 2022 05:42:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Mon, 17 Jan 2022 05:42:27 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 16 Jan
 2022 23:42:15 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 2/7] drm/amd/pm: drop unneeded vcn/jpeg_gate_lock
Date: Mon, 17 Jan 2022 13:41:46 +0800
Message-ID: <20220117054151.124838-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220117054151.124838-1-evan.quan@amd.com>
References: <20220117054151.124838-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fde1ac0a-2af6-4b13-75bc-08d9d97c259c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3642:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB364219CF2ACC560722D98D4CE4579@DM6PR12MB3642.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YzrN8q/HaMkW9JQyhpp2BCdEm8HQ75IATuEWBX3Cf8O6trM4ThYe0Cu9Yw6bQqm86IZZfsyAgH8GXAfiIWveBlWdVql9Fb4QuXPKFv9Vb+irnoNXGhVe6vAX2Ph1Q+aynjLuoZGnkJCmTl7Xu6SOJYraANKXgnGLJjl2uhGygxpvOYsmtDjfu27Eiw0R+YENAoUjiSIGcYLPH/a5O7i4nQERICpHMSqLD7gjcmRXJN/B2M9kvC719r7kD7Cqf6vy+tqG8RlB4+J5VrQFlatxyg/ip1KpxDtTZxksxo0ThhkuBied4kKXhtBSDTReZebklZ0N1Kj7TApt87AlTVb72zausDKjiNsE7PLsliSp8/6hYVeaIrizqvMnSarsITf6Jxfjhrkn/lK5i2EQtspkjzW1JabfVdPNSIBQHue+l2dxIrwGPf3UebOtMuH/hGFCb6vkh8Q6SZ5tw5OMFaZbWnvZw9b9Dc0jnsjZiVr4FcUQZ5UjvRXVXpan+BWOhGK6lKbuKqjkar4yFOuYUty5KesZJR0TdbLgxSCCwwCyvjl+qRQjlowLipNXRdP8+qU4Nw5cCH4653QW76GQpkbOEOlZJBO799Xy52i2f9c3CJI8Mur40FnYkL+DDGRd0mvoeTbTbM0UMLxxRgxxQAOXmybur5w8A9WzG73EpTSLTwHFn+/3Ar3scDZbftQKLBeLRC69cZdy9EgB3S32XNTDNYzn/YUQfdvV4BP++Z5ZSV3cqmRqNRQFGl315lR2IRUwmAKqB1F8Xp1HK4tXQnWf6ou8EqzD0KDpn9M8psBDMKw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(8936002)(2616005)(4326008)(36756003)(426003)(44832011)(47076005)(5660300002)(82310400004)(36860700001)(316002)(2906002)(86362001)(83380400001)(81166007)(1076003)(356005)(26005)(336012)(8676002)(6666004)(70586007)(7696005)(6916009)(70206006)(54906003)(40460700001)(508600001)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 05:42:27.9349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fde1ac0a-2af6-4b13-75bc-08d9d97c259c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3642
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>, Guchun.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As those related APIs are already protected by adev->pm.mutex.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I762fab96bb1c034c153b029f939ec6e498460007
--
v1->v2:
  - optimize the label for error exit(Guchun)
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 63 ++++---------------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 -
 2 files changed, 11 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 411f03eb4523..1a560d2702db 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -158,8 +158,8 @@ static u32 smu_get_sclk(void *handle, bool low)
 	return clk_freq * 100;
 }
 
-static int smu_dpm_set_vcn_enable_locked(struct smu_context *smu,
-					 bool enable)
+static int smu_dpm_set_vcn_enable(struct smu_context *smu,
+				  bool enable)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 	struct smu_power_gate *power_gate = &smu_power->power_gate;
@@ -178,24 +178,8 @@ static int smu_dpm_set_vcn_enable_locked(struct smu_context *smu,
 	return ret;
 }
 
-static int smu_dpm_set_vcn_enable(struct smu_context *smu,
-				  bool enable)
-{
-	struct smu_power_context *smu_power = &smu->smu_power;
-	struct smu_power_gate *power_gate = &smu_power->power_gate;
-	int ret = 0;
-
-	mutex_lock(&power_gate->vcn_gate_lock);
-
-	ret = smu_dpm_set_vcn_enable_locked(smu, enable);
-
-	mutex_unlock(&power_gate->vcn_gate_lock);
-
-	return ret;
-}
-
-static int smu_dpm_set_jpeg_enable_locked(struct smu_context *smu,
-					  bool enable)
+static int smu_dpm_set_jpeg_enable(struct smu_context *smu,
+				   bool enable)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 	struct smu_power_gate *power_gate = &smu_power->power_gate;
@@ -214,22 +198,6 @@ static int smu_dpm_set_jpeg_enable_locked(struct smu_context *smu,
 	return ret;
 }
 
-static int smu_dpm_set_jpeg_enable(struct smu_context *smu,
-				   bool enable)
-{
-	struct smu_power_context *smu_power = &smu->smu_power;
-	struct smu_power_gate *power_gate = &smu_power->power_gate;
-	int ret = 0;
-
-	mutex_lock(&power_gate->jpeg_gate_lock);
-
-	ret = smu_dpm_set_jpeg_enable_locked(smu, enable);
-
-	mutex_unlock(&power_gate->jpeg_gate_lock);
-
-	return ret;
-}
-
 /**
  * smu_dpm_set_power_gate - power gate/ungate the specific IP block
  *
@@ -619,32 +587,25 @@ static int smu_set_default_dpm_table(struct smu_context *smu)
 	if (!smu->ppt_funcs->set_default_dpm_table)
 		return 0;
 
-	mutex_lock(&power_gate->vcn_gate_lock);
-	mutex_lock(&power_gate->jpeg_gate_lock);
-
 	vcn_gate = atomic_read(&power_gate->vcn_gated);
 	jpeg_gate = atomic_read(&power_gate->jpeg_gated);
 
-	ret = smu_dpm_set_vcn_enable_locked(smu, true);
+	ret = smu_dpm_set_vcn_enable(smu, true);
 	if (ret)
-		goto err0_out;
+		return ret;
 
-	ret = smu_dpm_set_jpeg_enable_locked(smu, true);
+	ret = smu_dpm_set_jpeg_enable(smu, true);
 	if (ret)
-		goto err1_out;
+		goto err_out;
 
 	ret = smu->ppt_funcs->set_default_dpm_table(smu);
 	if (ret)
 		dev_err(smu->adev->dev,
 			"Failed to setup default dpm clock tables!\n");
 
-	smu_dpm_set_jpeg_enable_locked(smu, !jpeg_gate);
-err1_out:
-	smu_dpm_set_vcn_enable_locked(smu, !vcn_gate);
-err0_out:
-	mutex_unlock(&power_gate->jpeg_gate_lock);
-	mutex_unlock(&power_gate->vcn_gate_lock);
-
+	smu_dpm_set_jpeg_enable(smu, !jpeg_gate);
+err_out:
+	smu_dpm_set_vcn_enable(smu, !vcn_gate);
 	return ret;
 }
 
@@ -1006,8 +967,6 @@ static int smu_sw_init(void *handle)
 
 	atomic_set(&smu->smu_power.power_gate.vcn_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
-	mutex_init(&smu->smu_power.power_gate.vcn_gate_lock);
-	mutex_init(&smu->smu_power.power_gate.jpeg_gate_lock);
 
 	smu->workload_mask = 1 << smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT];
 	smu->workload_prority[PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT] = 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 00760f3c6da5..c3efe4fea5e0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -376,8 +376,6 @@ struct smu_power_gate {
 	bool vce_gated;
 	atomic_t vcn_gated;
 	atomic_t jpeg_gated;
-	struct mutex vcn_gate_lock;
-	struct mutex jpeg_gate_lock;
 };
 
 struct smu_power_context {
-- 
2.29.0

