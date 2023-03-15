Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E19C6FD1D
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Mar 2023 08:13:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2914610E99F;
	Wed, 15 Mar 2023 08:13:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8607410E9D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Mar 2023 08:13:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVYixYGDMYdTtwWSW6Z1tRMJ22poNklvC4HdM0HCCS9UAcs5OEypCFOcLHwBTDAv8hfJKK6dq4D0E+EwVOXqDoZhHhRCPm769Oa7yEbvlVd3JZa4l0vmRdl6tEbJzJzTKySC1pP3MOGxOAj0tovi5UnaAIf4CGBvDJs3NnfloJZpMcdhDAq57gvmRbjV0i0zcR2xfAhwW9HHE6JxEN5Kyz1IO0twDY3SrhMNFCtOdWjq9KLOKmobnKrBp0OIqsMV7mKDuXVxc6PduTOmQZjj0hEJQkfGB03HTNOSA4Otq7oOAhEXXu6NRZsVxsCFIqVopWPnqiHutOUVCArKcUq30w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDdUL4d6Tuod6SeYbS7cSRPv0QcwnHTMWjuxwTlKqXA=;
 b=WoX6pF9ZD/BFBuQu5lUqUPoxgl5yyxhdTp90eeWSslKvLoXsZoNlQlCgDdiw2T46ly8y49Vy2btQGY9LxAR5kH6JY/vqGemPtzNxlFAVwUTZDxbFOTCHgx5NVX05aFW9Wt1zKQnrFjyAjICAY8D22iVkcSvPr80JE9cIFD1CjNPNBm4YVg0FgoqT1gJWnGF08mjh+HvTza3r8807pN88rJNQGjcnZ7+5djurWRUH/85khxDdg3VFCFrwdrL8Lmjb1gJbK6JQCcD3hCJq61tWg+GaAafRd8seU6GNG3qJCjRaS0j2gbIXRCFNB4o5GbMJIk+5XcXclcJj21gXxhkt6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDdUL4d6Tuod6SeYbS7cSRPv0QcwnHTMWjuxwTlKqXA=;
 b=hKivIeHkWq6WFunIDi2STxHCvCZCQr/VGlf/BitGZFnYl1a3INFyOvienSThbOEvAIQyeZjaJz9cBpWohyGHJ8DwAIXdh7sVlALUtj2GLKjthYE9T6/Zu896ug2d11eGpic1RFfQsDobfMwcz2iCGG/d2Itwt+kq9cY3im63hdQ=
Received: from BN9PR03CA0481.namprd03.prod.outlook.com (2603:10b6:408:130::6)
 by PH0PR12MB5483.namprd12.prod.outlook.com (2603:10b6:510:ee::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 08:13:33 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::d4) by BN9PR03CA0481.outlook.office365.com
 (2603:10b6:408:130::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26 via Frontend
 Transport; Wed, 15 Mar 2023 08:13:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.11 via Frontend Transport; Wed, 15 Mar 2023 08:13:33 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Mar
 2023 03:13:33 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Mar
 2023 01:13:32 -0700
Received: from amd-SYS-7048GR-TR.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 15 Mar 2023 03:13:30 -0500
From: Tong Liu01 <Tong.Liu01@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add mes resume when do gfx post soft reset
Date: Wed, 15 Mar 2023 16:13:27 +0800
Message-ID: <20230315081327.207785-1-Tong.Liu01@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT030:EE_|PH0PR12MB5483:EE_
X-MS-Office365-Filtering-Correlation-Id: 91859d70-fb03-4e44-236a-08db252d2b5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eTHrlHuA0TYvdM/ZrDvBd/h38OtJRukUaOFnUaIPoICPaivaUSWCMvL/lZkyNlwCMcokFYJcu8fv8STpFolJ1RsQxoCdfWCSocvy2ukniFYPTAPi1fOnQ02iFW5q0Eqs2jP8pKM9xe7C4+Szoiq93FBUSmq/RuDay9Rpqq192i4EfSCRYED0uLJOwKJGRwJl5RdFdygd5V85pB/NsDWQlkhewESMmJXpAlqyLFAzBKuhCVO+1kOogg/L6luZ8ngmnh9FQWCb5FCOxGFBp3XsCV9t8e4Wp2IUNbP4gJYoVqy8E1TFT1oEJH9JAyTMA9WQF0/qaAZbb+8INdg/YA2rC5Z0kP6jB9aGx70SiwuDeBhYOwdhTHX8N4c/tRVaRewy62rF6H94d2uHmoBcH661VCJ/nCma/gq9dp1b48IdhIt3mGuC5m8Zvzn5wx6Fi87PVSPSZl1wvEKzoJqg47lADjiQO4MF47KWEpKW35E6dRlpLhk8TecM8exgQdKX/EZCU3Ui3Cg5V5G0b1v4Tnl2vixdtLB9qYgzSFv2qh8cw1rQm+WHv8JIHvLSzf3zwZALbwFAWL+eaBgG5kD19v7ZjeR1eBnOUJynS4XjL3iykYnYka4pBAVjrLxHJ4WYIB8QBll9FChLiIof+TuOexZ9JP0ftGvJMEBzDJNnU0Re0B0pLrGCHO88tZKod0EwbXy0kUAaV7DcOlTXjr5FkyCf2U5bJV2OhXl6Y9J1xIKRGV0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(5660300002)(41300700001)(8676002)(6916009)(4326008)(2906002)(70586007)(70206006)(8936002)(478600001)(83380400001)(316002)(54906003)(7696005)(40460700003)(6666004)(36756003)(1076003)(26005)(186003)(2616005)(426003)(40480700001)(47076005)(336012)(81166007)(82310400005)(36860700001)(82740400003)(86362001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 08:13:33.3934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91859d70-fb03-4e44-236a-08db252d2b5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5483
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, horace.chen@amd.com, Tong
 Liu01 <Tong.Liu01@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
when gfx do soft reset, mes will also do reset, if mes is not
resumed when do recover from soft reset, mes is unable to respond
in later sequence

[how]
resume mes when do gfx post soft reset

Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 3bf697a80cf2..08650f93f210 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4655,6 +4655,14 @@ static bool gfx_v11_0_check_soft_reset(void *handle)
 	return false;
 }
 
+static int gfx_v11_0_post_soft_reset(void *handle)
+{
+	/**
+	 * GFX soft reset will impact MES, need resume MES when do GFX soft reset
+	 */
+	return amdgpu_mes_resume((struct amdgpu_device *)handle);
+}
+
 static uint64_t gfx_v11_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 {
 	uint64_t clock;
@@ -6166,6 +6174,7 @@ static const struct amd_ip_funcs gfx_v11_0_ip_funcs = {
 	.wait_for_idle = gfx_v11_0_wait_for_idle,
 	.soft_reset = gfx_v11_0_soft_reset,
 	.check_soft_reset = gfx_v11_0_check_soft_reset,
+	.post_soft_reset = gfx_v11_0_post_soft_reset,
 	.set_clockgating_state = gfx_v11_0_set_clockgating_state,
 	.set_powergating_state = gfx_v11_0_set_powergating_state,
 	.get_clockgating_state = gfx_v11_0_get_clockgating_state,
-- 
2.34.1

