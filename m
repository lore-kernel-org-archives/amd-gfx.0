Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8514C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 05:12:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38A8910EA72;
	Fri, 18 Feb 2022 05:12:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB64410EA72
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 05:12:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndJiEbHAAJLpcNVSVYgt6UCXK00Qf+LZoctqw0D5kZRrKVHXZk2XkcnPX88yqe/0nnvAoK/AX8ew7I4xU4GKxe8HDN4PeQ4TsiBFQ7WSJCdim1IWHS5Hhy6sZZcwXJU9Orop2XnG5A9t4+lXyE21ERaOee1Dbs5rqkFazaUtdP+6nce9uO8Em8jPPp8S9JyelRfFMuaLwGbWYHaSZF/SEye78cfL5/+beUx3Hnl/7NV+jg6AhJAjKBFLwO2i+C8GZXjKpdfpjzuxl/qZ2x6RIUr0/YW2n7gW+uLuW5P3A7f8bsf0VUcTxzW43MOlP6QrLs8GUSH481/Shp43Cpf2lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZEqNIJeyIXJOO8nv9zz0G509t+kpTf+koYVwKGj8cw=;
 b=RbAwG9FDsTlbZDnx8cV9RCOOW1PcolEbd8fGWmm6pexY1EgDC1+VU49kRTa1Uv7WXJgO/6IwzF+dRGcIcUd/MTaXFcs0vtuIyfFCL6ocPO14MbakWIUUPkJGE5tYI1ZiwXJTgl3aEfCNwsUTmdWYRe/+VV5IKQ1+1SBJ/p3Rx1ITCtQ3AvVSeW1YkTFb7pzG05a6No7wIZjUn6mCnJlGVGwFEbGohznNoyt/6WaXDuInArKmIu8jhhzGW85gR4ysOqQjNcn5j33Sqfw+AnDJ3gvOcf70WU/JtIe0B+4l416bG1DHvV4CqBQrEn5MPW5LDp31mZf1RfXFpB8RsW7ZGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZEqNIJeyIXJOO8nv9zz0G509t+kpTf+koYVwKGj8cw=;
 b=BXweQro2Hn2aTZEIZMqQ6CXtViQQSMr1xHktD87AzWXihpJsd0ShTE2Bh8NMOy1FFdZhnlMUaSDgSgGuOrWkL6EdfJm+m3CjvlWslMbJlUDTlmKt9gYjHow/skmQzgGtYTLdxnyhqv2sKbvCPgPxZUMJ4dzb8hms+/sHKkfXUdU=
Received: from BN6PR17CA0026.namprd17.prod.outlook.com (2603:10b6:405:75::15)
 by BY5PR12MB3699.namprd12.prod.outlook.com (2603:10b6:a03:195::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Fri, 18 Feb
 2022 05:12:13 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::e3) by BN6PR17CA0026.outlook.office365.com
 (2603:10b6:405:75::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.22 via Frontend
 Transport; Fri, 18 Feb 2022 05:12:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 05:12:12 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 17 Feb 2022 23:12:09 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <Yuliang.Shi@amd.com>, <flora.cui@amd.com>,
 <christian.koenig@amd.com>, <xinhui.pan@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: bypass tiling flag check in SRIOV
Date: Fri, 18 Feb 2022 13:11:57 +0800
Message-ID: <20220218051157.19548-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55732a8b-a2b6-472b-fec3-08d9f29d38ac
X-MS-TrafficTypeDiagnostic: BY5PR12MB3699:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3699C9B56988A0DF8AA046B3F1379@BY5PR12MB3699.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hb2AfdpICAosrOoGmrAD7CWWy/hcOP4dSYbl8nkuk5Y0K0E8t+4qy2i5PN2KyqGG9Lym0GZkWABs47jSbrisQId/5gcMszdGPSnthBxvyBdfp+m+oXBjeKp6cE9WLbL/Q4wKM7v4b5ymBHcPR2odR43/IcqOV4tsNA7QcZJWVhKXslgZofXJq6a8koSDjzT810n6AwCynMLU7Z+1l5vnGZsdiu8d5oWmM4TrmKvz+p9GfyvFDErRIRuqRHPkFmf+ZUu6PnLlVjjTS7Spw9UnaNRr+ugvs6pxmAlXuTL6PNn3Wr5jPw9eiFPeyjG9uTR6vgyqFus7Jvt3BnzcFq6W6MbYQmGH0FOX5kUkafw5t27kT1EaukgY+L+rBH7LCP0iYcayYYi5X0Afjx/gzkyX3Z8Rk8EKXqg33sg/GfNbF9sQkAihlPbqGjFwvovRYpZW24f9s0ua5D/0ev/iio7TJtkXAeqGnOdFcUFtj+vgrAtGsaDO8fup8pcTiQ7rBOSMdynErxPcDqs24KnQ1wSidcoQxNVs/FYuXJSYusZt2UA05STtOR/rbEs0eWBHLa74+7T5u4uS5Xfg5Xc8uNUhl/4ycThfZ+G5zUNkn/xxT+q7QUhSlPqC/J1NO42jUHZUi+Mb6dQTmPgNQkn8MRL8R6C41E+0Bj4dafYhRNiFIZkB4ligbhjlSW+Sd9yddrin+PWzHm1FIuV5A9PkAKixrX6A+9OD5AiWxlnyBvpvusw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(316002)(7696005)(6636002)(81166007)(44832011)(40460700003)(26005)(356005)(110136005)(36756003)(508600001)(86362001)(2616005)(426003)(16526019)(186003)(2906002)(1076003)(6666004)(336012)(4326008)(83380400001)(8936002)(8676002)(70206006)(5660300002)(70586007)(47076005)(82310400004)(36860700001)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 05:12:12.3659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55732a8b-a2b6-472b-fec3-08d9f29d38ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3699
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

vkms leverages common amdgpu framebuffer creation, and
also it does not support pixel format modifier, so there
is no need to check tiling flags when initing framebuffer.
This can fix below calltrace:

amdgpu 0000:00:08.0: GFX9+ requires FB check based on format modifier
WARNING: CPU: 0 PID: 1023 at drivers/gpu/drm/amd/amdgpu/amdgpu_display.c:1150 amdgpu_display_framebuffer_init+0x8e7/0xb40 [amdgpu]

Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 0d4ad1ee8348..63cc210e4b6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1150,7 +1150,7 @@ int amdgpu_display_framebuffer_init(struct drm_device *dev,
 	if (ret)
 		return ret;
 
-	if (!dev->mode_config.allow_fb_modifiers) {
+	if (!dev->mode_config.allow_fb_modifiers && !amdgpu_sriov_vf(adev)) {
 		drm_WARN_ONCE(dev, adev->family >= AMDGPU_FAMILY_AI,
 			      "GFX9+ requires FB check based on format modifier\n");
 		ret = check_tiling_flags_gfx6(rfb);
-- 
2.17.1

