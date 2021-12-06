Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6206C433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 10:29:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 939EA7B1FB;
	Mon,  6 Dec 2021 10:21:42 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2067.outbound.protection.outlook.com [40.107.102.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EFDB7347E
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 06:35:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsPveF2YZGvO0qzXWhQExVwUsF4yZuu3804B9UcGAY3KrN737zkt3r6T+J1m1inrZ49zKkIrfOjcIZBFJCIzmPphbvuhk89V+ZZeAUFGWuyz4IWsn9iqYLoEM+y6WHtxO+CMPh2tjKdILkPfFWUuQDrQEx/cblGQXZEWJQerYMHuf3dW8ORtFonl5rQsszH04DUlqUhOgLoF2Lbm03rlq8+hF3ndRKDNNVNWwWIYNu5rMaxA90a2JG1aKZegG3HIR4SiLv7hb168resb32fm6uYUKTL/b/doO8/vEoxEF0a9bV88u75lRE37Fn7nJ89qy2oemxNi8N4fafaABB9KnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqIjlR0ZHi6YzOHLdiHnShIlr+7Fex7KuhcOxsVCpaI=;
 b=ITczlXLirWx5kZh/hkp4NNk1mgccKhoDKlp3kYb835xoYrhVkFzC9WxaMrym65ljOLX029UC43dWPLiiesoyioMN5pB9V/8EEevVEBr/InR5G6HpaviyDuaCie+g2QAU/Z8bU3Zd2zRWRFvkk6vKIa2nNcPy1N1a7nBZNOTLvy8mkZ58DyNOfQ/yrk4CYDbEJo9snjQyQ4rss9NAinx9SuthRGZ47f+Ub7k2dcZSEN94+U+c8iFr8VJ0p3zy0jQIUoSpAd0B7JrW7YJ5uItE+R8OuyBhjMljjskO7KbfeQCs8aVhFvG2jacEwkGN3mQvabiTpXxBkqZkDY70iFekmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqIjlR0ZHi6YzOHLdiHnShIlr+7Fex7KuhcOxsVCpaI=;
 b=ji1t4tSIRKfYLlyqHP0PfUITPl53otYiKw3QU9Z+gmIF9D5sIxwjuArtt8wI3dJQS47UBcZuVl1I/lK3W1scFpw54PY39pTtYLGn8AOzZKQt5+Rh3yWQ/gvQ//2UQHq5Hszso+YrwMf0M2cixiFfGK517/7u+sHa807zsL/W0dY=
Received: from BN1PR12CA0008.namprd12.prod.outlook.com (2603:10b6:408:e1::13)
 by BN6PR12MB1923.namprd12.prod.outlook.com (2603:10b6:404:107::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Mon, 6 Dec
 2021 06:35:11 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::3b) by BN1PR12CA0008.outlook.office365.com
 (2603:10b6:408:e1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend
 Transport; Mon, 6 Dec 2021 06:35:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Mon, 6 Dec 2021 06:35:11 +0000
Received: from flora.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 6 Dec
 2021 00:35:02 -0600
From: Flora Cui <flora.cui@amd.com>
To: <=guchun.chen@amd.com>, <perry.yuan@amd.com>, <yuliang.shi@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: drop the critial WARN_ON in amdgpu_vkms
Date: Mon, 6 Dec 2021 14:34:44 +0800
Message-ID: <20211206063445.104874-1-flora.cui@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4717a086-f478-4946-57ef-08d9b8828df8
X-MS-TrafficTypeDiagnostic: BN6PR12MB1923:
X-Microsoft-Antispam-PRVS: <BN6PR12MB19234ACBF3E67C9A16D2228CFA6D9@BN6PR12MB1923.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ibh4sLtRSgwQcYRPzo8Htxhe9zwWMDLhUF4I/qEJIbIfygqG8+V8r2t+stq5ClIuxOuOR+lqG/ZZcUe4y1ztAUfYhTJuP0OyStE2Ltdd35FA4hdfi3onrnwQjBXH2In1Rz/GjUtFFqQcoUbPuBNAKTrlbIAosh8IwtfgHCIDuJjeXM27lK1Z7Czs4YI7Yjp9OlHJM+t5E2W8Z36JMwUpOWGnkPQIUbb1d+kf47tlaQldsKd+CZlVhZCVrDUF6YfCpIzSaOWWQ9HLdQfCPQwFyxwK0yaVL4JgPP6eUVGwtT5N8RvlHqWDZrKRUeFovPfjzqMBrKWRYwwdUx08jHAyUyy4x7jf34qXXHQs9cIzIDiDt839DL84EX+53+poKLT9FhHYqUSxItQkbOMGQXS+DbbJ/To7SO0re867JuehvgMn8LCKG8V9vP76+00scBRTZs/Cdo6zjUwPtWPzXbCQbrHeH+Ps+3EW9kD51ukAkZMsQmebVtCRb3nIF4xn/2uPb/NqunzP13sDzwMKwj/GQSwd711kmRauILobaNA6uWktivyDdRiClAGyEJVqK9JmCz4pSnoPekiBBryfbubULBKhtgCv3HlE3sqSmtr05cxAPCjCcSGLql1M/yplJRQKtD6eWWvgDC6LELkqgkXtemn1+hg/g2mpIlsJfIqIVG3tWysrF+TE5HXi8bL63AcWB7Hu2iOOD4aLJrAQ5dHvdXdBtuDzpUzBH3NG2U51oy68gKAiT9PsioGX3XBCFfvDY0gmn4MfNuZV1+U6moG4rryvMZ4xx/xGKLtgwZN6Npo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(186003)(47076005)(2906002)(8936002)(5660300002)(508600001)(4326008)(70586007)(86362001)(26005)(16526019)(36860700001)(7696005)(1076003)(110136005)(54906003)(316002)(4744005)(6666004)(40460700001)(2616005)(336012)(36756003)(83380400001)(81166007)(70206006)(8676002)(356005)(44832011)(426003)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 06:35:11.6289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4717a086-f478-4946-57ef-08d9b8828df8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1923
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
Cc: Leslie Shi <Yuliang.Shi@amd.com>, Flora Cui <flora.cui@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Flora Cui <flora.cui@amd.com>
Reviewed-by: Leslie Shi <Yuliang.Shi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 6c62c45e3e3e..acc2d31ea93f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -51,7 +51,8 @@ static enum hrtimer_restart amdgpu_vkms_vblank_simulate(struct hrtimer *timer)
 
 	ret_overrun = hrtimer_forward_now(&amdgpu_crtc->vblank_timer,
 					  output->period_ns);
-	WARN_ON(ret_overrun != 1);
+	if (ret_overrun != 1)
+		DRM_WARN("%s: vblank timer overrun\n", __func__);
 
 	ret = drm_crtc_handle_vblank(crtc);
 	if (!ret)
-- 
2.25.1

