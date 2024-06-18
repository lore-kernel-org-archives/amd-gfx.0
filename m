Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50708C2BA1A
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 06:34:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAEEF10E570;
	Tue, 18 Jun 2024 06:34:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1u6HCaNy";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FB0210E570
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 06:34:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcI4kOoLQa0izl3ey7wXOYSd6UTydpJwktXizPuxg4TJwf4PfogNTR/bz7PC718GfyWDt5wPbcTdzceruhR4X1oZYzsmZyc+i4DnEkGEB9he4HX60W84skult/iSsXhrx2eDueFEt/49Aipc8aOJdBWKAZHX3BilJ0UrfA43ENxMRu9ARmIpvomY7yrBsIo7CQ0q6IPnUcM9XnMLWGzbEodVkqc3KL9J37b91kdpAccHF0jddKSGgbpRBNodG9o3VQ9GsbsvV6pUlGQ+TIN0t4Y/EHOD5UC1ZxC/Mwt1/6JqG815kbxU5FgIoodanynGCTpHTcaKNvN4Tofng/boAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbk1OVS6B8P8mCa7qN8lmzDwR3DmbyrkxYa/eOc+5mw=;
 b=HAUz0mkH/gnJh4jB8SPKnamEJeN94snMXIr2AuPemxvw7JB87Pl3mSc3XvyiSBU7ehrIfkebrSlDRS69M9k385qGV4rvgANW1Bor2ywREa37c8m1ub6QohlTm6pV3ng2EKjvo35f5X/Cic3fH6ubpD8U08bAp4TGr+LEws31UMcHGTSyi1rPevByD8zpfTktbZty6WXj+/yB40SQ7JFGrsKtBsEbckM3Qra0Dh+QUyBvrN3GIDWvbMQhOLFw3qSUTKS0IreiBsfAF5XIkpEBt5Y9zeKYEzRS8pdbSkoiBluVBNuzLhLa42HS07PjoCnHYHjXxosPcUK5DnZIggrmoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbk1OVS6B8P8mCa7qN8lmzDwR3DmbyrkxYa/eOc+5mw=;
 b=1u6HCaNyjjPodj7urgt3ZRhOO4SfggZasi8UI+dM0zg0LmqqcnWM2g83v392uzNq3EsLMWvF4baJXnWe6opfvzzcCqLjEbMds7OB2Vq6YnCLGrt846UkMfaO6rSbOnkKUZlW9qZ5SjpZc05YsKK6H8H/1GMrvF1Up8wAEw2F9vo=
Received: from SA1P222CA0141.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::8)
 by CYYPR12MB8729.namprd12.prod.outlook.com (2603:10b6:930:c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 06:34:41 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:3c2:cafe::f) by SA1P222CA0141.outlook.office365.com
 (2603:10b6:806:3c2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Tue, 18 Jun 2024 06:34:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 06:34:41 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 01:34:38 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: add gpu reset check and exception handling
Date: Tue, 18 Jun 2024 14:33:59 +0800
Message-ID: <20240618063359.304293-5-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618063359.304293-1-YiPeng.Chai@amd.com>
References: <20240618063359.304293-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|CYYPR12MB8729:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c6e75f6-4e69-4ef5-c721-08dc8f60bc0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|376011|1800799021|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ewHH8vlNoNLP7/jm5mVpH1qtjs0rIYw207/R4yZvMlN2OnOcXPQ2yKjbn4da?=
 =?us-ascii?Q?27tguppD4NSI+EOXMsWXGYHw+VdGu+ifiPG/7GZeThcAMjFNge3m/TcWv+0m?=
 =?us-ascii?Q?3sKXdeacJ7XFxHLLhWKCQ10nGxWTTrX0CezacH8H7Rg9lghbduaohJQDBH7C?=
 =?us-ascii?Q?/5NZWaifHgDCHyi3oja9az/xj31bERPqbfttda9bn9FM+MPEnOJNOwMwF+mr?=
 =?us-ascii?Q?hv4YDKV1FHx1JgijBRsjyM3Xtto43mDr2w6gBd1BX8caPcB9ZT5h+unlUVGV?=
 =?us-ascii?Q?HklameRJhwiGbuRopMAflX3PXn59FHV0GhZEDlnxQegd29Fr/ddXaFDc0h9T?=
 =?us-ascii?Q?jTnpNcrN1Ez1vdNuTlwgWhfMkTOrLr03pXEmTrCPMYFkfMlwPf9BF9Z35JtP?=
 =?us-ascii?Q?xBbADHOn+tHvcdsX+xrH1LILfl14HwGPGyPimi2/4+ZLdGzqQmTeAMpJpycy?=
 =?us-ascii?Q?1wMN3K/WnOdzPKj8niJS5jWW3mBheJncNnajVNU6xrHbMZQyQZ9W3icH3sOC?=
 =?us-ascii?Q?pKR9j3ibAak3pK76FkfSkfVE4q3NZTWXCRu9T86xoYjIwdxIRbJwQ9F5dKNn?=
 =?us-ascii?Q?p2usiNcErjN06wPz8hMkKbz5Bn3mYwpMSPrUWo4LEdQ/eQPepaDmaAjywC2Q?=
 =?us-ascii?Q?OJGQijPZ3/b7kkbk7hgEffn0QTIwMRrgDcOLk/0Ou9O8Nlt0ef8E7839RCcm?=
 =?us-ascii?Q?pAH4TsbqOstoOPvj85qHrXKc0iWX2b1vsThv3PxK5rbzGXGIbYDd4ZockxQ7?=
 =?us-ascii?Q?CSjGBvew6kldcCAcEXeiuP38t/y0KROUogIfYivKUE/sQBhMt60jaqv3zFZ7?=
 =?us-ascii?Q?LsZlZE0hWfOG00cun03hqPLrxhYx2ariBL0D37RKaoYtwndPzXx2anNmgOFV?=
 =?us-ascii?Q?qR17WM8dNA4k3q9+IMw0MCd8P5ew6au86eFw93bbnDMg7zXMIAJpIosPM7i8?=
 =?us-ascii?Q?X8nJe9116OjXKcvIznAhvnegC7wa4KLLj21TuROuQJhbFMuUD+26tmELKAtN?=
 =?us-ascii?Q?a4PUTFUJeoXNOGDRcNSLT5Oy8dPCbsttXmB4B2p1h4Y8b02H6gh56WGyjW7s?=
 =?us-ascii?Q?5x8axPziKBpoIFglOIuDlzKbuIoW9bd1+v7NwrVsneXlg8kU37E2fHsDSuFy?=
 =?us-ascii?Q?s5f+2hzY82lzJ3kgY0tjP1hbw6GcENtPZsjJgDLsso5r5cLoGhnrCQoaDpxy?=
 =?us-ascii?Q?APWBdkiy05SsEjHuB8icUf2iyLVNgGkWOE0l26IBomRbsoNLSydZGV16joLW?=
 =?us-ascii?Q?byO1jcGyEXgevNiVYjGKte7Y3OC5aN3j/Ekc7c/8xKQmB/ky7NeOzedvi7ob?=
 =?us-ascii?Q?lLIP1x5pRABmc1z1n+Bsti+nXEWgoEZO41IiLoaUdbYyl/8Sqo+IMOtIALSW?=
 =?us-ascii?Q?InpBrI70NXJf05Cqx7C3U3M4CNwc20xi9eRwnytKNd3Il+UiTw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 06:34:41.3572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6e75f6-4e69-4ef5-c721-08dc8f60bc0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8729
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

Add gpu reset check and exception handling for
page retirement.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 43 +++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 7f8e6ca07957..635dc86dbfd8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1386,10 +1386,15 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev, struct ras_query_i
 	memset(&qctx, 0, sizeof(qctx));
 	qctx.event_id = amdgpu_ras_acquire_event_id(adev, amdgpu_ras_intr_triggered() ?
 						   RAS_EVENT_TYPE_ISR : RAS_EVENT_TYPE_INVALID);
+
+	if (!down_read_trylock(&adev->reset_domain->sem))
+		return -EIO;
+
 	ret = amdgpu_ras_query_error_status_helper(adev, info,
 						   &err_data,
 						   &qctx,
 						   error_query_mode);
+	up_read(&adev->reset_domain->sem);
 	if (ret)
 		goto out_fini_err_data;
 
@@ -2884,6 +2889,14 @@ static int amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void amdgpu_ras_clear_poison_fifo(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct ras_poison_msg msg;
+
+	while (kfifo_get(&con->poison_fifo, &msg));
+}
+
 static int amdgpu_ras_poison_consumption_handler(struct amdgpu_device *adev,
 			uint32_t msg_count, uint32_t *gpu_reset)
 {
@@ -2913,6 +2926,11 @@ static int amdgpu_ras_poison_consumption_handler(struct amdgpu_device *adev,
 		else
 			reset = reset_flags;
 
+		/* Check if gpu is in reset state */
+		if (!down_read_trylock(&adev->reset_domain->sem))
+			return -EIO;
+		up_read(&adev->reset_domain->sem);
+
 		flush_delayed_work(&con->page_retirement_dwork);
 
 		reinit_completion(&con->ras_recovery_completion);
@@ -2977,6 +2995,31 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 			}
 		}
 
+		if ((ret == -EIO) || (gpu_reset == AMDGPU_RAS_GPU_RESET_MODE1_RESET)) {
+			/* gpu is in mode-1 reset state */
+			/* Clear poison creation request */
+			while (atomic_read(&con->poison_creation_count))
+				atomic_dec(&con->poison_creation_count);
+
+			/* Clear poison consumption fifo */
+			amdgpu_ras_clear_poison_fifo(adev);
+
+			while (atomic_read(&con->page_retirement_req_cnt))
+				atomic_dec(&con->page_retirement_req_cnt);
+
+			if (ret == -EIO) {
+				/* Wait for mode-1 reset to complete */
+				down_read(&adev->reset_domain->sem);
+				up_read(&adev->reset_domain->sem);
+			}
+
+			/* Wake up work queue to save bad pages to eeprom */
+			schedule_delayed_work(&con->page_retirement_dwork, 0);
+		} else if (gpu_reset) {
+			/* gpu is in mode-2 reset or other reset state */
+			/* Wake up work queue to save bad pages to eeprom */
+			schedule_delayed_work(&con->page_retirement_dwork, 0);
+		}
 #else
         dev_info(adev->dev, "Start processing page retirement. request:%d\n",
                     atomic_read(&con->page_retirement_req_cnt));
-- 
2.34.1

