Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D03C43217
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93C2210F741;
	Fri, 29 Apr 2022 17:47:20 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 614BE10F3BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYNkr3vqQ+KOj6YVcnNcjWR2lzptcSBuBzvrt2zBJL6cjpgMvXpLsfFMNmdGBwRpzi9xTFuv7hp6autkP6JGO1VSrBG0k1O/OemGKTNvk0Js2a1w7MPAvOD4aBkcppWOwH9GyXl/sadtQ/yDeVLqzuuaWdjOJjzV6DmOQ82w/7um0SuF7//3hCGej7t/emCWoXmBdSXv+U3EgHbRxsAp9JK1dSQhexnfhWjhjiYSWmGQli7/Pk6homEQHEgHNZLfJxAL0b1xav5y1SiWdTNpfKKtreyRiOPMiWIne1o9RJUxQjwHSwH1jS1vEMQjRR0IXzdrJaq18EHAqH+bhs/w1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfVQ0EmRV/Q6NYUdJFNDQNT6YYTU/N8EOTfcPzibrJU=;
 b=N2fSxiAbntPeDekXv15AI0g9j7+VFevi+8tYq32ApGzb5j+zfOLr5jEMb+eAmuNPwpVwN20PrE0KjXKYe+za/68Za+j47cHrh49s4WvxiY0bROsoXE0jML7EYSmFPqpcNrGLx9Kb68oaDToUQedDXQAcZWjLM7NPF/WCo06f+YHxqpeYbKUeF4w9vfiketyVxxerPKceTIwAYnwxCoclzs78qsraa2TeZ3vuw9xPr3aGZGtp8zmSNkpOxMOYt3rFZ3jfkQtlqG+bgz6TbobaE/dueMbwPc6EaqO5svKkXeYarSS/yfwgHzygkcgE5Lptp7EP9BMspl1I+UW8KPl/Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfVQ0EmRV/Q6NYUdJFNDQNT6YYTU/N8EOTfcPzibrJU=;
 b=CRHS4wkUxwVchVGb4fYbz0tROk7orIpRLsrQExcdvU6Yn39aVmNlk9SjDSrkdUPYb3VfCMnCw6gmn6KOo6rxLAVg2itJE59/yeMxvKvJmMHoRwKs4xU9Pjuxh/bP/FsLROWXvBVv50sPH6yvH7lV+/V9tkQ6au+mtAskaLmD++I=
Received: from DM6PR02CA0095.namprd02.prod.outlook.com (2603:10b6:5:1f4::36)
 by BN9PR12MB5100.namprd12.prod.outlook.com (2603:10b6:408:119::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 17:47:14 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::a7) by DM6PR02CA0095.outlook.office365.com
 (2603:10b6:5:1f4::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:47:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 59/73] drm/amdgpu/mes: add helper functions to alloc/free ctx
 metadata
Date: Fri, 29 Apr 2022 13:46:10 -0400
Message-ID: <20220429174624.459475-60-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69cff172-7df8-4ea7-ed1c-08da2a084b78
X-MS-TrafficTypeDiagnostic: BN9PR12MB5100:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB51003ED6DB1EA7BCCBFC840BF7FC9@BN9PR12MB5100.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L+7njpl2aL4jCRl08awtg0YaU2pQZnzThlB3MdAorG6P44XEOIO7MJN/A8uzRbmU+jT7JSpzJ2w0mPiyrBdV9sSr2UtA+VDs/sNLopdns7PvG8XRagkmFDC35FKr3WbzuIwMwkcL0rHEAT8QkAX3JHt84EZ+NS9Aom6kzhkQ953+Rc3IfDFukuq+9tVRhMsPHvXCRVJ+T/wwFxosS4oo4TSrextsCOwV7y5QsPEvJXKPIGQ5GH47UJNEF22eBqVFhv6jFQosiMbzo5uVwUSn1vpW7QHLDRAHW0nvElxxANJAot0/eDyCNu8QicEpix6YrI01GmeCFxBh8GwrzZvTM5zT/A8+GfJTQ4rg54MVWqthv21bpzu35kJLBSyD/bdZQZJVylGGznR64j6lJQepjGMmFQHFeENsXrDbbPARICJVLGuhVDW+rqQlMHcJkHUpbo8Bjfg95jiDeSK3M4YdAXi7Hh7OKDmrSUqgG6buZpu69deER1u16vwi3qD338BRpJbmEOTlsL4f4A95kw6QlQvRBWuBmSljDlpoxOqJzj07Vp1LfjMogTjMnnhJa0y71tYIqxbX+ZVZQWEYjmCNd7WIR/IukKiBKeasFNMNPcwewyFFjMrq2LSMEV8VMmhtbThQse4/I9+RhXZUi2ykKIM7YPpj2QL/D9UxXtXpSS4YUL8bMPcxN23u1RTic1OgzBLaUwJL7Wz7uxXvjt/khQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(186003)(16526019)(36756003)(5660300002)(7696005)(70206006)(2906002)(36860700001)(316002)(8676002)(6916009)(4326008)(70586007)(8936002)(54906003)(336012)(426003)(40460700003)(2616005)(47076005)(86362001)(508600001)(82310400005)(81166007)(356005)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:13.9417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69cff172-7df8-4ea7-ed1c-08da2a084b78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5100
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Add the helper functions to allocate/free context metadata.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 25 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  4 ++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index fa43a7e3c9ab..6c01581e3a7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -857,3 +857,28 @@ void amdgpu_mes_remove_ring(struct amdgpu_device *adev,
 	amdgpu_ring_fini(ring);
 	kfree(ring);
 }
+
+int amdgpu_mes_ctx_alloc_meta_data(struct amdgpu_device *adev,
+				   struct amdgpu_mes_ctx_data *ctx_data)
+{
+	int r;
+
+	r = amdgpu_bo_create_kernel(adev,
+			    sizeof(struct amdgpu_mes_ctx_meta_data),
+			    PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
+			    &ctx_data->meta_data_obj, NULL,
+			    &ctx_data->meta_data_ptr);
+	if (!ctx_data->meta_data_obj)
+		return -ENOMEM;
+
+	memset(ctx_data->meta_data_ptr, 0,
+	       sizeof(struct amdgpu_mes_ctx_meta_data));
+
+	return 0;
+}
+
+void amdgpu_mes_ctx_free_meta_data(struct amdgpu_mes_ctx_data *ctx_data)
+{
+	if (ctx_data->meta_data_obj)
+		amdgpu_bo_free_kernel(&ctx_data->meta_data_obj, NULL, NULL);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 37232b396b06..50d490e69cb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -261,4 +261,8 @@ int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
 void amdgpu_mes_remove_ring(struct amdgpu_device *adev,
 			    struct amdgpu_ring *ring);
 
+int amdgpu_mes_ctx_alloc_meta_data(struct amdgpu_device *adev,
+				   struct amdgpu_mes_ctx_data *ctx_data);
+void amdgpu_mes_ctx_free_meta_data(struct amdgpu_mes_ctx_data *ctx_data);
+
 #endif /* __AMDGPU_MES_H__ */
-- 
2.35.1

