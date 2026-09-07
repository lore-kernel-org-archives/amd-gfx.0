Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BACC79F9E
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 01:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 839E910E5EB;
	Mon,  7 Sep 2026 01:46:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SO8mKF1F";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012023.outbound.protection.outlook.com
 [40.93.195.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 789AB10E58C
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 01:46:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3Rl7guf+d5EqR9vkAdMl7+GwGwtkFi07axK1BWJQRe80G6aiag2jUDqtAoKgaIMx56TTFDEoUkZ1orQ/RTUCAfoMdKPSvvUDA58zBaBgRIAP9JwRic3OBxTAHQBMW9k9UbKyLpA6/23w4AjLcFxzJNY02Ci3UHnDIqE7XrhsItVvQQxBzuvVyWCYmJjCc6EgXIpVwM0OpNpqgGGB/YoYBl/x4EIBqLSAJth2pMQn2C+xMOQQZNO9cvzDl+syKPdkDGDRHQV6inx8Vlx8UrXIBAb/din/JF+apOuWmd4/5AAmAR1X2oLYSQi3tRtIou2ZCP6qIXKoDMJCPgpjc67Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUaIaHD/aLqD5NGzQUee3WHVCmVm65t2y8DoVwZYQng=;
 b=oxmfTOutMZ79JBL0/x/5qYC76rBai3DecJeGhZGN6d/J7YXd0GvGJRKubw5EhTCkTCNw1Ag9dFVBBJhZ5qLrwW/Wr8frHYmC1b/9o1H8ujxQhijbFNqhKy0QB/NaOLbMVvWqA5y0q5HB9B40gALs7sTO9rmF4QYoUHSwREdKZIV7y9G5QbJFjKsmrcL7ZoStx0pbCwo/OfqlsQCuxwL9pGi5cB6xXejH4eHqNWpu3Y7e+7E0QvM+w6mPZ0/Qo5dBMP6t7MhNswKk7CzkPzAFfmbBKGg55eyfw19gw558fXrUQOWtd7lheredfseUWEQvqPOhTWCOkP0FB/k9NJbRiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUaIaHD/aLqD5NGzQUee3WHVCmVm65t2y8DoVwZYQng=;
 b=SO8mKF1Fs8Z72OkbNR2LiW9SMdaZ/a9/Np9ZajDCkABXiQEJC4qRwvbNVzzsn170CRQmsU75455AD+X7GGp4AELz/FCU3Gi7Gwx9xM8E4FjhMsUYwqXBCPJ+j2TzrS7ngEPrY0RQDHHlLJQbABz+ejRaFebSNnGPZ8+LITa/5fM=
Received: from BY1P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::8)
 by DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 01:46:47 +0000
Received: from BY1PEPF0002695D.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::91) by BY1P220CA0018.outlook.office365.com
 (2603:10b6:a03:5c3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 01:46:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0002695D.mail.protection.outlook.com (10.167.244.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 01:46:47 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 6 Sep
 2026 20:46:46 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Sun, 6 Sep 2026 20:46:45 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v4 7/8] drm/amdgpu/sdma7_1: honor mqd_prop modify flag in
 init_mqd
Date: Mon, 7 Sep 2026 09:45:34 +0800
Message-ID: <20260907014629.2186163-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260907014629.2186163-1-Jesse.Zhang@amd.com>
References: <20260907014629.2186163-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0002695D:EE_|DM6PR12MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bec7192-d09f-494d-d586-08df0c81e10b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|10067099003|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1fyOY5WDwmkfaYbhBtQufwwOSr1QiZ0GX3K3N4Af/5VEBuOrcvXEYvbgr2lGKKBYInpAWq9hnoK0t4E/wTdroebm47P6NNxH2BVdKdKgZdyJX+CSSJ4KMGFBMfFwtygcy0Dm7eQHJHridstfBmJL39wVoPMJZ30LmHSvYGCOf2Z3eK47ZJ6qo17t5RfbejmthUYrVhgA5aWhg499jh7cWrcitOOqKq/bef7CUw9lDFq52cXWFZlTZbIAL9/FNoEYPY5QMU+Cvyun59WJb8tx/vZrzTsj5mFfNtY/wlDdgKkGX4TyzyWEz6nmsnBJdZB1OvtoCaly0ysCtEx9hXnuEj6rQLyrodyg5qjxiWgbyNLoFlWUXqIyKVP9mAoZvJ8coEHdMXMAVcqU4hfOFHj02OVdhI0gFMOz7XGabMEqNCWcCown/lPBXCOpDR6bUnC4Aw7kaw+FFSwzaffwD2ZiemikaZCGg49wQQrOo3MzUHrbQLWDQmqRhlM/BpG7IJOCsES+w1VQxdm3ANGkoSP5owrmHEKMqiZAH6qAxMt/xz5O/2qh3HTpGkyE78dOXBBiMHQUED9WdmZw5QGRlVe5BzLv5jB8pucqQHVtw6DBBwguB10JT4PH9oAG90luL3ZHr5Xuk3jY4poCwJ77MXP2FAFsEJLrHRVuEoqN/5Uve9zFdO5MrUlMjNoDTGl1t4qVQWxasJTfjGlPqWzqY2kFww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(10067099003)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Mn4bifjRavKCoW1BdI6MUGYK3VoaJl9/kK+F2MzE1M56BZdav9UapvQeC8xlbdlV/xxZei9Y2ylWrgvVPoUQPHQ3/pTgQzBGDhFf+1629QWmP0su3dC3dmGSL7rfs22cdi20OUgx4vuHr4j0ZWKtv+Y+nz6lVNh0qmRGQYuPbR6a5gA0bl2MD0iIlD19bEZVK4tt2ojk1TbpNE85vRJVMcthD5bWFFH0aR0F1+UzG+ogtyfayhyefmtn87Bk772d/XnIU1AbrSYkutkbvQRn+ACQsuAHuvGn8fRRN8dNIyad8cBbozvziusETd9kyblqq2h3eJjBKnZxvJjByZDr2gwEfJuRSKR6g5lLCOeHodhScza02KNXaVyuNvlMiF9/EoDaOKxneSkLksW6mIRDjMVg45SxEiVfXfB5kddl079U5EvuI+ux3OsTKKCi4Mbl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 01:46:47.4574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bec7192-d09f-494d-d586-08df0c81e10b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0002695D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4186
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

On a queue MODIFY (prop->modify) sdma7_1 init_mqd keeps the ring rptr/wptr
that firmware context-saved into the MQD, so a re-enabled queue resumes
at the first un-consumed packet. It also forces IB_ENABLE back on, since
ib_cntl reads back IB_ENABLE=0 on a stopped queue.

v3: consume the mqd_prop modify flag inside init_mqd instead of adding a
    separate sdma7_1 update_mqd callback, per review.
v4: also keep the context-saved wptr instead of programming a user_wptr,
    per review.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index e9a3bcfd7775..0af11841b727 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -886,6 +886,14 @@ static int sdma_v7_1_mqd_init(struct amdgpu_device *adev, void *mqd,
 	m->sdmax_rlcx_csa_addr_lo = lower_32_bits(prop->csa_addr);
 	m->sdmax_rlcx_csa_addr_hi = upper_32_bits(prop->csa_addr);
 
+	if (prop->modify) {
+		/*
+		 * MODIFY keeps the firmware-saved rptr/wptr (left untouched above);
+		 * ib_cntl read back IB_ENABLE=0 on the stopped queue, so force it on.
+		 */
+		m->sdmax_rlcx_ib_cntl |= SDMA0_SDMA_QUEUE0_IB_CNTL__IB_ENABLE_MASK;
+	}
+
 	return 0;
 }
 
-- 
2.49.0

