Return-Path: <SRS0=4Mkx=LD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364F1C48BCD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 18:48:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0138D61182
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 18:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0138D61182
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 914D089F85;
	Wed,  9 Jun 2021 18:48:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8E4A89F6B
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jun 2021 18:48:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cz1GLKbw3dfyTYmX6V5ud2UhMhz5i5nXiNLz6lC8OGjvAb5FXqQLcxNOrHBss6ogbfR6HKjyC/gz8qexuJoRO9z1PnQv2dNzYs1D8hSg4mydfSvBN98+uRF8fdAPpSjQFgEgxxcP0bOFegVAO/pUXYHGrrp4iP3g/aroiAN4dV6FPW59rErZrZi6piwWF5Iwn8RITCDGzeNZj5oIrDe/Qru3e2tx6L579iDgNED5Kha0oQaigqJRW22KZyU9UGi9QFnqLAyKknoQMrmnE8jhnyfhdNWDw/we+fPCobvm0LRugmu4Ba5z2veGkCxMyQPqVXeXPpL7AYeXXhTjvdy2Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/iuwU3kul5V6lX6P6z0UTa+EX5QZ+5QOJaOD/CSyws=;
 b=S3aXo8safkyA92g1bapHmdEQSIU/5wuJialLOyHqximSM3ny80Pg1JsI02qWJ7F3/EmRJktMYL+GnsckGXSMpjfsgl8H8fB6H4A2BYoa6ipiJzd87g+QTTB3Q2l2hJj0clr82F4KsEP6zGZ1Ee/LVTLwZ1gjDYBtZEAVDmxQHxNPZhepxDLGp/iBw72wLmIRiAvsL+Dchn/DsUz05kfKjzg/g6u9kkI+NnURToSgJmZjWz+jwQtp85opeddALsOPpebtAk/ggK/Jw5IFw1NGTLN8Q67xrLnH5IfPfxuLO8No0RYiRAPiafrN5Rhhkpmt87O+o7gPGS5i/ApFGdgVMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/iuwU3kul5V6lX6P6z0UTa+EX5QZ+5QOJaOD/CSyws=;
 b=VoyQPevpGd2KlH8Nw0oUDED0H0hffiaBW+37wZcogi70Yqvw4RzEEGD3ijoBL2lygGJF4eIW1z9uVxLWRotLDegt+gniWormWwswJjPj90YcH8rEtrRR4WbeXfNGBufEMV9H7+9oQgZjzATFj+CpygarcHKv5XLhkXlD80io8OA=
Received: from MW4PR04CA0086.namprd04.prod.outlook.com (2603:10b6:303:6b::31)
 by BN8PR12MB3220.namprd12.prod.outlook.com (2603:10b6:408:9e::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Wed, 9 Jun
 2021 18:48:33 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::1e) by MW4PR04CA0086.outlook.office365.com
 (2603:10b6:303:6b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Wed, 9 Jun 2021 18:48:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 18:48:32 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 9 Jun 2021
 13:48:30 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 9 Jun 2021
 11:48:30 -0700
Received: from jenkins.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Wed, 9 Jun 2021 13:48:29 -0500
From: Ashish Pawar <ashpawar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: PWRBRK sequence changes for Aldebaran
Date: Thu, 10 Jun 2021 02:47:58 +0800
Message-ID: <20210609184758.2556918-1-ashpawar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0c6d5b3-626d-4c9a-5c0a-08d92b772e8a
X-MS-TrafficTypeDiagnostic: BN8PR12MB3220:
X-Microsoft-Antispam-PRVS: <BN8PR12MB322016692C18B0B00F07D33A8E369@BN8PR12MB3220.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:330;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P3i1w86mGpjPd8JZiG6Nk1ujqtUoa5nb3+/uvQBVx8YnBEfaSn+M67lbm7y1mDgozHQc/8kQd1MnvximNgsQe/VEO3748Y9yu1VXj0zlMktyP7cNJ/EZ0hPZhIqWlDbKQE5JO32yc/9sa9yZP5B8qtkBVRZFXbHQ9WSdcJP5bmQDfFKwHqbk8zD3T3vzx694FfWHf4zxfhiCi+pVzZ5YsdA0IKPYLpFwzvFPAM7i96ChehugpafY8H56w6FFCRbBWszVw13cE9cTeNM1EZPW7J87ghl+XT+sUdoJ7oy6zWMscZvSzp4wDN5v23c+tf1rWDTrvMPea24wQ7D+7+4Tg5oBgLFPeu/mE7oDwxAnOiZyXgGhUijfKa5XtX+BauNgwm2/HTMyjDm4Vxx10H8AsSWgUB1a+V2Ae0xNrkcQ4/3TMTuViU5qCK9WCtxhtXgzCfkFrNh/H9fDVxOwt2xhIyJ+Re/GnQOwpy0hhVgBf4NWyyNeUFvZSmL9iW8n/+gIDJPtRUFt9UadICNAllSOpdjP5CVbVyCX4VWRlz+0U/oslRR04DwuVJqHnzpODCtlwgEoNYe5XXCDf5t/8pmtSbs47DrfqmMG5Sl9vCe24/c2Z7Hf5ggtLGrlBEu0XfyaN3b4brct5Su6FoZwu56k4RDAhZy0UANCWAgw/0S2T0NW7UwprqlKI01PNq6m/tdp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(46966006)(36840700001)(8936002)(54906003)(70206006)(5660300002)(356005)(83380400001)(8676002)(70586007)(316002)(7696005)(82740400003)(81166007)(4744005)(82310400003)(1076003)(4326008)(2616005)(186003)(478600001)(336012)(426003)(47076005)(6916009)(36756003)(36860700001)(26005)(2906002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 18:48:32.9938 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c6d5b3-626d-4c9a-5c0a-08d92b772e8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3220
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
Cc: Lijo.Lazar@amd.com, Ashish Pawar <ashpawar@amd.com>, Evan.Quan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Modify power brake enablement sequence on Aldebaran

Signed-off-by: Ashish Pawar <ashpawar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index c0352dcc89be..1769c4cba2ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -782,11 +782,6 @@ void gfx_v9_4_2_set_power_brake_sequence(struct amdgpu_device *adev)
 	tmp = REG_SET_FIELD(tmp, GC_THROTTLE_CTRL1, PWRBRK_STALL_EN, 1);
 	WREG32_SOC15(GC, 0, regGC_THROTTLE_CTRL1, tmp);
 
-	WREG32_SOC15(GC, 0, regDIDT_IND_INDEX, ixDIDT_SQ_THROTTLE_CTRL);
-	tmp = 0;
-	tmp = REG_SET_FIELD(tmp, DIDT_SQ_THROTTLE_CTRL, PWRBRK_STALL_EN, 1);
-	WREG32_SOC15(GC, 0, regDIDT_IND_DATA, tmp);
-
 	WREG32_SOC15(GC, 0, regGC_CAC_IND_INDEX, ixPWRBRK_STALL_PATTERN_CTRL);
 	tmp = 0;
 	tmp = REG_SET_FIELD(tmp, PWRBRK_STALL_PATTERN_CTRL, PWRBRK_END_STEP, 0x12);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
