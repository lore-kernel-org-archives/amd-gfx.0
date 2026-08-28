Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C223C61DCB
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 04:16:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2E2910F23C;
	Fri, 28 Aug 2026 04:16:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JNl4mycN";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010067.outbound.protection.outlook.com [52.101.201.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B19610E454
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 04:15:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEztV+iV2Gk87i99feOTmoWUjkwMVCv5vw0QrRNBckNgk43TH2eAKh+cRowddhSYKFO0VFHSpKwimsxzxrCCA3CuwobqduXso3UIhRqJrS/TEL9V/ElcQ3qrsk4qz5WEP11rsVf7pQQTzfa9Od4FZgz9seXJeL7CjysaWs0koTzibtpIyog8s71OV1rhh7nn/YoSsP34Hu0V340kuDpox1BJDIkuy/5d+YhCjWFDpQhSfDVjnyG2p6cIQXZaIIa1a7tmO49ZJphRLAbwu7Yx+Vylq60ynZb0ouuFlBk63f56rk+RSA/Eqr76zFufDfv/bqVGh7YOjZ7opJ4/QeMEcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dV/0bJ/v7tykiWf0F2ecd76qWopjOiEsNazFUWKe7gc=;
 b=HyhrnhYEVYqmnbx2uIRarn8/v5S3H0d8gZAk6LOB9EXKvChZFegkPkxL8SKrtMtW9FKAz7XKhj+oMTKzO47TMLLR9kqOSQsY61GRZF0XTDzV5MFbipeV19a18N2CpSMCHQgbHGvhe8Bn67gB3v1eAWYtm8zUhmqNfQn5lX+5YBNw8LxmNCpS4IutotFc5bD9nForfL7hWyivK+onRlu7cH1FXkv9E6rOccY9SuhAbE8z6L/7Wy1lgvJZ8YMfF5BKpHw2fRWJWdVF9vo/VBPaj4cvSnyAvvEfQOB5vSa0FLCwOGTXm5Ab9nP3lRBnw5xBPGXtwgxhcLVo+e/cVyzbAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dV/0bJ/v7tykiWf0F2ecd76qWopjOiEsNazFUWKe7gc=;
 b=JNl4mycNT4dGtziDpryyCfeFNyvF5VmdJpnEiZSV13MIy5m9eXO/qe5Cn40sXIdC1sdSJ2OyR8lfc/Qiaz7lDz+7AQ+Z90joBuIuRc/szgMkNhaE+P2f/r+iYxjUBjry/1OKDfsi2alsHQ58Es3t1HomqVj915JCeZYjVVLaffk=
Received: from SJ0PR03CA0013.namprd03.prod.outlook.com (2603:10b6:a03:33a::18)
 by BL4PR12MB9506.namprd12.prod.outlook.com (2603:10b6:208:590::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 04:15:54 +0000
Received: from CO1PEPF00012E63.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::7e) by SJ0PR03CA0013.outlook.office365.com
 (2603:10b6:a03:33a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Fri,
 28 Aug 2026 04:15:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E63.mail.protection.outlook.com (10.167.249.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 04:15:53 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 23:15:52 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 23:15:52 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 27 Aug 2026 23:15:51 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 06/10] drm/amdgpu/sdma7: implement update_mqd
Date: Fri, 28 Aug 2026 12:15:12 +0800
Message-ID: <20260828041537.3464782-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260828041537.3464782-1-Jesse.Zhang@amd.com>
References: <20260828041537.3464782-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E63:EE_|BL4PR12MB9506:EE_
X-MS-Office365-Filtering-Correlation-Id: fe628415-baf6-441d-009d-08df04bb0d2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: II0Za0QqELbMGzsOLRkqcYXrtFXC7LM752AlGOqnyMgp6Fa1rUSeRDlxjXmru5fKXy6+iQ4qzA13LQJnoKITI6ANAv/z1lEwcZ/TfNJAsic9Nt4tEhNXfTfdVbXL9iuI4XJGKvOg91cRdNgHlWK7MOtigaowyMQYK4FLFxs67KIoTh8TsCyXlBgvAHPdVQZYklXsmQzTtUfnDNLAmxNkWliU0NIAXExfFJxXYySK7YE/EeMuscisQ64qZzcK3WIapl/QRQsdKDXjNvxXKx1TPK+obt9Wg0gEdxqm2ipVIq1udKbPystEnq3VvU7XUEV1mrfUnat9xxciadr9JcdThHQve7WN52exYZ0SQBrUTsqx8iam/xcP5aIJxL7hQLFYAvHHOc8MaGsMr+lEHF6IKbSQuSdSy33q0ZVH0MdnXWBmmdjsdevmLb7XSJY7KukEyUlK2N1xY4lkchO1iUSGwsd7KLGumGn/OJCJwrGDtR1HE/VrAv9WjGsWw8pH8nYObmzaTVH1KrFZ7PZxBQwUlU45elrAl8c5sS1nnnuhG/rDuV233xLy3vbG+zJmMDQAFMQlhkuAd4LdyZ914d/EIE0kFEcqk/RSQCXFv4rAL81JaaHD5u8oCK0TNEPJKdahKUgUFqr+a6ajnhfAPxyai1Lqa1nIDUT11ELDM+CkqhdZQYcpKx+PLf8CLIvx/pDqrspsK/3zIEEB9ck7cyu3KQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qMg+ogRdY98HT2OuLg4UDkTOjA5tVjFTZptCKfhInWwmjLcRRVqSZ4hb7/Ba+j3lD9o8ckEyHAEuBnevTvEf/GOJROck9GzrNZIu87cOoE6F89d+eJpjSZvCmsDOam9Vzjs/6Qvkf8Rlv1d+VfXRpnQ5RhGV4VlN97FMmTRr/BnJVIF7hV318pUG/eJ24JDBaGHGul2Um9kae3SIuOMPjBNe0bSKbPXKF/NGrhK6DWI9wMc3V76Gq2SGHDKi0MH4qrufFtTtbrp1xK28xIVsDPyE26WNj4x3UpsPSr3+fQAY3LOMU0CvJLHqPD/SnDlCEWM/H9pMaHGB25/GeHhM1tE1csGn+TgbLKX9IrlG3z4EyaxwG+oE4YkQGf7x+X1VH8ezCr3P7dooP53DyHiZreQPx0COkVrr00eaTO8XHLJ9omX/qL53/Qx/JQGHxCCx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 04:15:53.4758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe628415-baf6-441d-009d-08df04bb0d2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9506
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

Implement the update_mqd callback for sdma_v7_0 user queues. SDMA init_mqd
leaves the ring rptr/wptr alone, so re-run it to rebuild the HQD, then
restore the saved read pointer and forward the user write pointer. Force
IB_ENABLE on, since init_mqd seeds ib_cntl from the live IB_CNTL register
which reads back IB_ENABLE=0 on a stopped queue.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 2068e2e6e3d6..2ab24d99c5ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -905,10 +905,39 @@ static int sdma_v7_0_mqd_init(struct amdgpu_device *adev, void *mqd,
 	return 0;
 }
 
+/*
+ * SDMA update_mqd: init_mqd leaves the ring rptr/wptr alone, so re-run it to
+ * rebuild the HQD, then restore the saved rptr and forward the user wptr.
+ */
+static int sdma_v7_0_mqd_update(struct amdgpu_device *adev, void *mqd,
+				struct amdgpu_mqd_prop *prop, u64 user_wptr)
+{
+	struct v12_sdma_mqd *m = mqd;
+	u32 saved_rptr = m->sdmax_rlcx_rb_rptr;
+	u32 saved_rptr_hi = m->sdmax_rlcx_rb_rptr_hi;
+
+	sdma_v7_0_mqd_init(adev, mqd, prop);
+
+	m->sdmax_rlcx_rb_rptr = saved_rptr;
+	m->sdmax_rlcx_rb_rptr_hi = saved_rptr_hi;
+	m->sdmax_rlcx_rb_wptr = lower_32_bits(user_wptr);
+	m->sdmax_rlcx_rb_wptr_hi = upper_32_bits(user_wptr);
+
+	/*
+	 * init_mqd seeds ib_cntl from the live IB_CNTL register, which reads
+	 * back IB_ENABLE=0 on a stopped queue; the re-mapped engine would then
+	 * drain the ring without executing the IBs. Force IB_ENABLE on.
+	 */
+	m->sdmax_rlcx_ib_cntl |= SDMA0_QUEUE0_IB_CNTL__IB_ENABLE_MASK;
+
+	return 0;
+}
+
 static void sdma_v7_0_set_mqd_funcs(struct amdgpu_device *adev)
 {
 	adev->mqds[AMDGPU_HW_IP_DMA].mqd_size = sizeof(struct v12_sdma_mqd);
 	adev->mqds[AMDGPU_HW_IP_DMA].init_mqd = sdma_v7_0_mqd_init;
+	adev->mqds[AMDGPU_HW_IP_DMA].update_mqd = sdma_v7_0_mqd_update;
 }
 
 /**
-- 
2.49.0

