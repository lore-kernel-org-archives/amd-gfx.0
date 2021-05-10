Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A1CC433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 11:14:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7648D61363
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 11:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7648D61363
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04C9F6E043;
	Mon, 10 May 2021 11:14:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 384636E043
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 11:14:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1xd56osNihApbZThxCfWhjUJfW4Ce5g6bEnPXgBEjiqzOSpIWbUR9hqNQuvuAtvEjkAtO+iho5Mt+4VSpt/KseqPvmxEr5GGyvHmy7ktmD0+3r3g3kkCaZ1wGrjp9vo7vyY9vYHvXuL465hLm5WZU32jy9lssOLavJ7MzV+SUXvrEY4Xy5zB3nfbdrYJzkR7nEygVLy7foPCOJcrGzc7gGpLH0eEkogN2qMAXC5ukKOujbz8v1flv1r7J09WDzgzxNOrDjfP0V/QbuypdDeFvBQ0MyrYyA/51SKeziZoYUZcqD7ti4T9lzsbbrB271BaJUST9O6DY40U3ji4GaTcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJGxI+BV+3tWD1EarGE2qM3lKGcEKGnacn+9gO9O0oM=;
 b=b+clOUa/OzJQAdSz0VMm2Eeum3e/Orq47vaNse2hC3bYM2sTXU6XEthmqS67pu+n3hdMlQRbqGcPWDSi4q0vdfPqDikV70AhNrWZcQJoAs/Jmbs8SoisICeDhm3s7I6qkfHC3sJ3DvKZ7ojQiKBShUm94C//wudCvFQmNVrZLOOcZPftWTLu+bR1drQ51vO/ARwVVSlSlNrDgiMJciGqt9xgr+0fZKXcDLp7yYlZbE8K51sbQHlKDWXka+wqzUoEzYyxF5ZglF4RbRq/rPkl6IS4jT+bgikzEXo2ml7WvmoJmtSSlmwhljU4bcFd++Ten5DVcJV03cKe2GRVRQ0QMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJGxI+BV+3tWD1EarGE2qM3lKGcEKGnacn+9gO9O0oM=;
 b=vokTbUN6zhkb+F6Xa3jozwkEJFkpQfEbsxmnNH0P6w1E+753J6eZWTXJ3GAsXGOsppt5MCcfb/FGvz87ckw35tli3x1r6tNanz/dZqgmCaZDooIisM0W7oarNMrUY13Zuo5FfuC9SNQ/q7IqXIMdQeJe38g31JZTmWFSHK7WlSM=
Received: from MWHPR22CA0037.namprd22.prod.outlook.com (2603:10b6:300:69::23)
 by CO6PR12MB5411.namprd12.prod.outlook.com (2603:10b6:5:356::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 11:14:09 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:69:cafe::db) by MWHPR22CA0037.outlook.office365.com
 (2603:10b6:300:69::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Mon, 10 May 2021 11:14:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 11:14:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 10 May
 2021 06:14:08 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 10 May
 2021 06:14:07 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Mon, 10 May 2021 06:14:06 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: add function to clear MMEA error status for
 aldebaran
Date: Mon, 10 May 2021 19:13:57 +0800
Message-ID: <20210510111357.17676-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fe1ecf8-6128-4bcd-14ec-08d913a4bb87
X-MS-TrafficTypeDiagnostic: CO6PR12MB5411:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5411A9E979DE1B2988C46E17ED549@CO6PR12MB5411.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4vRsKvRXXzeHQDUMgDMlJ/XKtYgbojl/UffCB15D8DnhVyw2JI3qLKiyF9uf4fJyHUvsShXxhKRbrOlBIhGioolJ2L3PhSVEmxibyFv1t27a/NwUPGOQ2/o7R2gfYdY78Bq9xjALQDuFnEYgNLVXqSajqx48seZlY5KoCGMN8/JcJ6A+Q6JktQwTpVIPvyaADdpfS8VJxq/Su5eg1Wmlitxhm8ySZjch3Yx/BNAB6rISgN7JKa2VOHagP8kvuHwu6qpyU6Gwk1JZtWfYUrwKYFeUl8aqajqX7v1vhWWEKdgVe83MQj4CB4Cd3jVlGdnx7TmppoXbZ+srcWJkAA7+XEig9lPTI6zvYpk6WYp7WITOxiX8uK9qnV6jHlEuD1x7CSDF6jwIZiKM+Ap0JZEf6MPZnQS2JfNw+0GHhHaXZ0OAlQPtQLHNclnPBQvRlZPyYONRsrQ3HjapxW31ZjNYVxS2ppWXzTzMnIjLLRnOEdmoUYzymPE16JdtXtldG8+Pq6K3EXPbXBO+XlDbEPC6SxJVxBGUe19IR+iv3whi0Tfcj4LlK/EqyiBgQXkLa3GZA2/9VmKOE6/45GyPKj74OKccOG5p/jIAX/MAQrliHmJnl+aTs0/frGfk90XXu6S6dTURxZcgsLCY9ahTYskev0VDqXuzIazi6Y4LKgQ+4dto9X3JltmEqzrfEr9/wIJRBX0cP9pdGFMLfUVeEz2IfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(36840700001)(46966006)(2906002)(1076003)(82740400003)(36860700001)(316002)(70586007)(70206006)(83380400001)(86362001)(356005)(4326008)(81166007)(8936002)(6666004)(47076005)(8676002)(478600001)(26005)(7696005)(110136005)(186003)(5660300002)(336012)(2616005)(82310400003)(426003)(36756003)(6636002)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 11:14:08.9783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe1ecf8-6128-4bcd-14ec-08d913a4bb87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5411
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For aldebaran, hardware will not clear error status automatically when
reading error status register, insteadly driver should set clear bit of
the error status register explicitly to clear error status.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
index 11aa29933c1f..b27fcbccce2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
@@ -28,6 +28,7 @@ struct amdgpu_mmhub_ras_funcs {
 				      void *ras_error_status);
 	void (*query_ras_error_status)(struct amdgpu_device *adev);
 	void (*reset_ras_error_count)(struct amdgpu_device *adev);
+	void (*reset_ras_error_status)(struct amdgpu_device *adev);
 };
 
 struct amdgpu_mmhub_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 4eebb97994d6..a324dc2da101 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -938,6 +938,10 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 		if (adev->mmhub.ras_funcs &&
 		    adev->mmhub.ras_funcs->reset_ras_error_count)
 			adev->mmhub.ras_funcs->reset_ras_error_count(adev);
+
+		if (adev->mmhub.ras_funcs &&
+		    adev->mmhub.ras_funcs->reset_ras_error_status)
+			adev->mmhub.ras_funcs->reset_ras_error_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__SDMA:
 		if (adev->sdma.funcs->reset_ras_error_count)
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index e1500be4a208..998e674f9369 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -1314,12 +1314,31 @@ static void mmhub_v1_7_query_ras_error_status(struct amdgpu_device *adev)
 	}
 }
 
+static void mmhub_v1_7_reset_ras_error_status(struct amdgpu_device *adev)
+{
+	int i;
+	uint32_t reg_value;
+
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__MMHUB))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(mmhub_v1_7_ea_err_status_regs); i++) {
+		reg_value = RREG32(SOC15_REG_ENTRY_OFFSET(
+			mmhub_v1_7_ea_err_status_regs[i]));
+		reg_value = REG_SET_FIELD(reg_value, MMEA0_ERR_STATUS,
+					  CLEAR_ERROR_STATUS, 0x01);
+		WREG32(SOC15_REG_ENTRY_OFFSET(mmhub_v1_7_ea_err_status_regs[i]),
+		       reg_value);
+	}
+}
+
 const struct amdgpu_mmhub_ras_funcs mmhub_v1_7_ras_funcs = {
 	.ras_late_init = amdgpu_mmhub_ras_late_init,
 	.ras_fini = amdgpu_mmhub_ras_fini,
 	.query_ras_error_count = mmhub_v1_7_query_ras_error_count,
 	.reset_ras_error_count = mmhub_v1_7_reset_ras_error_count,
 	.query_ras_error_status = mmhub_v1_7_query_ras_error_status,
+	.reset_ras_error_status = mmhub_v1_7_reset_ras_error_status,
 };
 
 const struct amdgpu_mmhub_funcs mmhub_v1_7_funcs = {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
