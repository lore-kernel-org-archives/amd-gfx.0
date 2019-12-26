Return-Path: <SRS0=shUv=2Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3709C2D0DA
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Dec 2019 08:11:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A68432071E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Dec 2019 08:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="M9sdVoVN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68432071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6188989A98;
	Thu, 26 Dec 2019 08:11:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46A4289A98
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Dec 2019 08:11:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbNueNx1pBXm4OFaBbr6cFcH5nELbakYRx5+r8ERJ8390Ims4GpQycr6q1sHEvqNBU0eSfsaXTd3BxoeWdbG37+XKT5K8XOHMFS9fpyekRMsj9/KbuUBbelTophEDeUyghaGsiijou4J8IsXNMj4nhflZG3n493M5lJUjxNnrgJ4iWg0aPSEEzuXQV7NterLuRQj0FHHZkC1njXGosE9gDtUpilf8QoAg9zm8EPqbatnkfwyrFfWOX1SVI6b99/rZgxUXTV1pjtLWG5gSXPG1qu4Mh/ly+HZEuGTjdq67qFV3nUjzzem36a4M6XbV0JIg4zIexQTWw1KpVujxpIXQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKg4ZlLh5odb1/CmLqloak1xMEbtYgU5hfFPF7N8hvk=;
 b=g/b7QIUL0TLMOvwAw9EzAaaDkgeNoRWMJX9qiqyN93EHbpDg5MjBithlhjE7pJV3UjLtF4A5AgRFhTgSgztdcUoY5Ec6mrzxbD+jFAfq+qdVTbHolIeJxdlVogt3Xiua3VJmlD4Web5iQEGUzg1qezCWk2M7h5aOeKVVtRyySwqgDEtdBYZD5nADzTSQKPU0nSLeDS2FD/qbXo052BqWL5zFtCfANL4/jZo6T0ljoisH+3/3aZu970HnxMGoNs+ElVQ+QFz7xqF1wGNnNdYsUIxpEA5mT6CnlRQszhvSPzmTJMUc1BGYAY58mvRQ6N1OQaXZDy5G2ip8EV9Mb6Bq1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKg4ZlLh5odb1/CmLqloak1xMEbtYgU5hfFPF7N8hvk=;
 b=M9sdVoVNu8NaWWny+/yeQ0FAC8yX/RYQ0VtOZZz0JSgRdRAgLAf49OOViQAmcazH4ArM/qjYEpG5pG/cXeWhYCzYg8CyftYQYx00+9TjU9JhYZEJPSqlV6O6dLU/BijoGucQeA1DiaDcUci2GXWSJfz6x62Jm7qTsH0kDoliC4o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3200.namprd12.prod.outlook.com (20.179.82.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Thu, 26 Dec 2019 08:11:15 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2581.007; Thu, 26 Dec 2019
 08:11:15 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: avoid unnecessary SMC firmware reloading
Date: Thu, 26 Dec 2019 16:10:41 +0800
Message-Id: <20191226081041.8747-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191226081041.8747-1-evan.quan@amd.com>
References: <20191226081041.8747-1-evan.quan@amd.com>
X-ClientProxiedBy: HK0PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::13) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK0PR01CA0049.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend
 Transport; Thu, 26 Dec 2019 08:11:13 +0000
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 64ea6f79-f113-412b-44b4-08d789db2d43
X-MS-TrafficTypeDiagnostic: MN2PR12MB3200:|MN2PR12MB3200:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB32003992195F5977C71841B6E42B0@MN2PR12MB3200.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-Forefront-PRVS: 02638D901B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(189003)(199004)(81166006)(86362001)(186003)(36756003)(6916009)(26005)(1076003)(4326008)(7696005)(52116002)(6486002)(6666004)(16526019)(66946007)(66556008)(478600001)(8676002)(66476007)(8936002)(81156014)(956004)(2616005)(44832011)(5660300002)(2906002)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3200;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ic6SBR9hwktjDRS561fkNWgr6n80wlUmIi8Tg05xiBzxRAhJsswuU1TrvtPGUI9QH9y2lC1CpkdFG8q+Xd04rexB+1RjQYrTqrpkh8ZuE9gQifmTxhJKfI266PbuF6cGZT6Qkxc+9bdnb6wfrUAnA53NlgPUvI+yxg9PfVqN6WxuiTZpmfCg8yun70OFkPySk5+dcd5EVJ3pyJ7m8vLOdK6DyefOnYm16yP6S/WheuC1JR9Wf+jzrXH6b8+/U9uP4oiOKVHliQJk/lHtp+Ntbe+dgsNy0yL8Bb7mr8+0q6fFzpHZDWGJ6ekfsid73JXfxxVVJLfYESvX1riUyIap6pmdfvEaJdEQi+izUxBiQG4ZY5YmzsF5lsNIo7kwrdFvfqHB+Pdx2ndSUmHx3+lNufaOY4PDTKexlQhc2TMGN6Ri2TOBMGJLBs9DxIln/+BN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ea6f79-f113-412b-44b4-08d789db2d43
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2019 08:11:14.9479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SH+qDbokirRI0hVHqVRp7l6PV7Jv8SLGAUgm/pvRKgD/ZAIUvQYxUT+gc7ucoBku
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3200
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

E.g. During non-RAS baco reset, the SMC is still alive.
Thus there is no need to reload the SMC firmware.

Change-Id: I73f6284541d0ca0e82761380a27e32484fb0061c
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index c66ca8cc2ebd..ba761e9366e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -676,6 +676,19 @@ static bool psp_v11_0_compare_sram_data(struct psp_context *psp,
 	return true;
 }
 
+/*
+ * Check whether SMU is still alive. If that's true
+ * (e.g. for non-RAS baco reset), we need to skip SMC firmware reloading.
+ */
+static bool psp_v11_0_smu_reload_quirk(struct psp_context *psp)
+{
+	struct amdgpu_device *adev = psp->adev;
+	uint32_t reg;
+
+	reg = RREG32_PCIE(smnMP1_FIRMWARE_FLAGS | 0x03b00000);
+	return (reg & MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK) ? true : false;
+}
+
 static int psp_v11_0_mode1_reset(struct psp_context *psp)
 {
 	int ret;
@@ -1070,6 +1083,7 @@ static const struct psp_funcs psp_v11_0_funcs = {
 	.ring_stop = psp_v11_0_ring_stop,
 	.ring_destroy = psp_v11_0_ring_destroy,
 	.compare_sram_data = psp_v11_0_compare_sram_data,
+	.smu_reload_quirk = psp_v11_0_smu_reload_quirk,
 	.mode1_reset = psp_v11_0_mode1_reset,
 	.xgmi_get_topology_info = psp_v11_0_xgmi_get_topology_info,
 	.xgmi_set_topology_info = psp_v11_0_xgmi_set_topology_info,
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
