Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69489C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 11:08:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AEAA10E30D;
	Mon, 11 Apr 2022 11:08:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8BBF10E277
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 11:08:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ms9hG63vlU7dBj19T0Jh+BwRQrl0/WzQU6s6GWgmVIVb6BqYFuMwm1EYzELei/0ENN6SM5hcY48iRyKCxk8/1ma1jiPWe/LwWpLTnly3xMTpEq6ayOLjCpEJwJg2VPPqv57CCeQqvPK348y7npKB3igjDlVdFiXRowu7oICn6VdassLznA38omWgNeAXvdg7cL73ntyGDA2gMVpHAkVTZoCDO6Wp7zgbE00Sv1XksWjitSq8JZCUgG6XVBqVUhmuqBQsxSqM9hLUAAA3OAruj8CVIBRVcAGCCfzh7wJp4GsRH5oVDS4RylZv6UEw8PWZznyhjb+Opa6IAZNJgMzOVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoSNlm5SUvkNFomCm5R0VK3wZ79uJumoMuNVEGUdOsc=;
 b=O/qz4ikortUNAxaoAXowEASjVkYmZgrhlp4WRFUBeJSfWQ6T43LKoGgdc3KNUGWt8MjMG4fHhWnD24nWf4ZehKnFZBTofwhfqk5iDc/KYl3rex0QSg27KwRGxP/gN7okFAO3W2LTXp3KRYTiHh37ZHMZrxNWQWPxp18DKVD0v517OwrTPWIqDxLNLqIA/fI30T424O24bbVUZ4Da4Cjut7f3AE8OSquHRZVu3vGntzpwIxoQczAVWCdCLWY1AXmPGjJEmix+tIb58ZczdxCB4+ufMUMpZ4emgLoxS7wdaHvJlbwRXlkDncVnsAY0jB8wZ+y/yPQYUzGG0n0c+ozyRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoSNlm5SUvkNFomCm5R0VK3wZ79uJumoMuNVEGUdOsc=;
 b=Mt7qqrxE53mrkR7GDx5umRIZ1QyuhTPQcbi7PUf8iOP470d/H4ZX+7I34XKDannEzrkZ3iAOofwfGmAAKbZ5WoBomx3cC7cMycVGPtytVO8tcRkQk3EQ+mV8TniCAj+q3YQtTRSzFDX1uiN/dNjgrW3u/2VVQFwBtbJPzFjdyIg=
Received: from BN9PR03CA0802.namprd03.prod.outlook.com (2603:10b6:408:13f::27)
 by MWHPR1201MB0112.namprd12.prod.outlook.com (2603:10b6:301:5a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 11:08:50 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::52) by BN9PR03CA0802.outlook.office365.com
 (2603:10b6:408:13f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Mon, 11 Apr 2022 11:08:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 11:08:50 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 11 Apr
 2022 06:08:47 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>,
 <Mohammadzafar.Ziya@amd.com>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: add poison consumption flag for RAS IH
Date: Mon, 11 Apr 2022 19:08:23 +0800
Message-ID: <20220411110825.18808-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c88ef563-d0c9-44f0-91b6-08da1baba82c
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0112:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0112A831A0FE2F85644AE985B0EA9@MWHPR1201MB0112.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qC0ljKvkiUlqzVO+6s5Bwp0iuUS9Xo6W8uOlOSVIZRfm13i/F369cNTxzblscxntjdzsa80i/Nbg8hQOdHE1U9xi8wjksHQcLam9bRWbILj34Oxxe1eksR/yJqzM4lwy0wjhzKSOfutJB379HSMLYT5tZSf4BaJKukJnr/itnoTWoW4olHu9w/hQqoAnszuvl0zPgwzSz9h9u9ws0LHkQ0buJR25r+mG8fwnsP43Nm+J9vRrrhf3VfSQOxfjyXPx9QYhiyA+WopS+gmq6rtQU3OwL7sviomhpRdZChtB/vpiBmbkkE/Wl82DlTyKZZnos76oZq1RWDey4mTMBiQ9V04izHls3mmMO+GcqXxpqZ36249pURrNFgK3kGLTVcqUIxl31fQYcce20Iw0uriJO/toGgBPUdPvvIVYqS5A60lQb61VmBb0uNKW9+KI7DrMUeV349MCPGHxAzIbff+k6E9hw1DePvv0JafFZttklz//f2JB6UNiXVrHt2EA5iP4aBhZEkvgeRrGYAltiHr6M8NkM1C9LRFN/cYTwL+B7v6vqYP9CUUlBAiyPB87kEhUeEFFf+ozvOysajgJSXcBaxSQdWEgSg1CrVAU8Bw7hsr1ko1/QWbhHr0NCD2IFB+5ZTwgY3k0BilAx9dpPc0tylyxOSvzJgaOyZmW8OUdndOFygUIzNOp0OY4jxe3cxgnB/6Nx+MscMI9URM0lOXEYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70206006)(26005)(2616005)(186003)(70586007)(16526019)(36860700001)(1076003)(508600001)(8676002)(86362001)(83380400001)(47076005)(82310400005)(4326008)(426003)(336012)(110136005)(5660300002)(36756003)(6666004)(356005)(4744005)(316002)(7696005)(81166007)(6636002)(8936002)(40460700003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 11:08:50.0572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c88ef563-d0c9-44f0-91b6-08da1baba82c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0112
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So we can distinguish RAS poison consumption interrupt from UE
interrupt.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 606df8869b89..380f4c3020c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -314,6 +314,11 @@ enum amdgpu_ras_ret {
 	AMDGPU_RAS_PT,
 };
 
+enum amdgpu_ras_ih_flag {
+	AMDGPU_RAS_IH_POISON_CONSUMPTION = 0,
+	AMDGPU_RAS_IH_LAST,
+};
+
 struct ras_common_if {
 	enum amdgpu_ras_block block;
 	enum amdgpu_ras_error_type type;
@@ -419,6 +424,8 @@ struct ras_ih_data {
 	unsigned int aligned_element_size;
 	unsigned int rptr;
 	unsigned int wptr;
+	/* interrupt type flag */
+	unsigned int flag;
 };
 
 struct ras_manager {
-- 
2.35.1

