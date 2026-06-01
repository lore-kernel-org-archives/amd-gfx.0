Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487D4CD6E4C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:54:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1413112DDA;
	Mon,  1 Jun 2026 05:54:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hLDFbvDs";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011023.outbound.protection.outlook.com
 [40.93.194.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 544F8112DDA
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:54:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHWr0/2M2ekcIAG3cqUUuEussEjoTIxjteMi/9oVNCY22P9WlfYJdJ4Dggav5oKZRg4ep09xwnPJGoRcIPWidPv+/tx+IWNykkvv9wa3sDLn8OJgRNnTcOd5ZHSZhxcj86zOm7DRpz+1R9qnK+4VlZdThicykkrOBPQqwlkILo8xFGYlcwJ6zoQOsaYHv061ATftV78T6E1cypv1vCfldPUyb6A2AZ04oq33NVElDUQk81RlyOOsLIrqXuFvFMCtwIfxNRYJ2AWv3kMhdUf086h5M1Dauap07yhee3T2RKRQvl+FXxn6vesPoQh1/7lWzb1V8jMKOUjGhIivPxPpvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mws5h7cfi2XXUmucgTH3CwTuISkQ+Sm/u3QfaDVhJaM=;
 b=Tlk53Yb0V7ooNptEvYlOJ3gW/p59hsd1+/yhWiDlvy+IVyec6F0t06j8vuEfnYvT6Txg4tivnMVoAlIlGyrFFSX4xNy1TPl7mEXQ/vQksb5wBpR2siiuR5n7mEulkCcPLVWWDvb8KrilawQgOKFj9FP8wGVoEeKC6HlB6XR1vHSBF9iv8+7QYoCdFO5spJ7b4CLpq1+Vmr1A8qFY2gY97/AShRjfSsriXExY81Go+YBocsIVaCYP+AgjRJxguyl13aJCqRzx8fdQRLnwsql5cXotnvayqOr31+haYHKnwQwYFWyJtR78EjmaUuHhN3XOb6ooW53k4LsHMpC/b4tTIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mws5h7cfi2XXUmucgTH3CwTuISkQ+Sm/u3QfaDVhJaM=;
 b=hLDFbvDsqPxH+uTGZTnglczLs046sn94jdikwbhEas8N59M2+aVm3D8iwACNyI1tbOUNe1FUl9AO7ayagfixvIuDwo5QLghqkbJ2vJnoUUYTSu6DL0rjQ1bL8ntOYFLV6zLDxGAjsipX6IRRCcuJnm+Wq9pL+VQH9QCSVZAVXMk=
Received: from BN0PR04CA0159.namprd04.prod.outlook.com (2603:10b6:408:eb::14)
 by SN7PR12MB7418.namprd12.prod.outlook.com (2603:10b6:806:2a5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 05:54:48 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:eb:cafe::3) by BN0PR04CA0159.outlook.office365.com
 (2603:10b6:408:eb::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 05:54:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:54:47 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:54:47 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:54:47 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:54:40 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Amber Lin <Amber.Lin@amd.com>
Subject: [PATCH v2 34/42] drm/amdkfd: split out mes queue reset sequence into
 standalone function
Date: Mon, 1 Jun 2026 13:49:20 +0800
Message-ID: <20260601055034.3700921-34-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|SN7PR12MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: b059f4af-ce05-44f2-c0b0-08debfa249e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: KKifNwnKgmq4oV4r0QluvMViEz8GIEvxBpy2v741HTTp4Mf6Jpby/GkjyYZGZste85Qc4x+3Cpg19FEEAeVH2TCTmig83oSjF//N862ozsErPFaXMYCbKf87N3AT3dFc3rnijfV8esqmM/pePzwsG5NrBtNuxqUvAwciYywdT0ycYpm86//tTrI1EfXKf/54nZBmYx1OmyyX8K7DPfmXJIyWvezzDny/0OG6Bz4ub5Z+QrIOx5IqtsQ9bUuOGuMyoGHpUdn6XZWzOO/63Xv/WPKc4+ybHAwlB1J519Ci9sl5sGaJ1DALvy8v6THCuPkUClREVik/sLoMSeVwDdmZga1xrn4uC/tUt48lE0NukEqatO59PlmaJNYKJ+hYGjvB/WeZMxKyYG5sIyU5XnotNpS5mLyZFVfwglOAccAjXaYQcMxmXxS8yhu+JHpLyx9IemsymqU7jjBeANPm1rpa4skv+ubz7GFqQtz+x45mUjAXrJK/o2xtpyFFrOCMNtk5s7jvAhF7Kbn8KiaX3BuCoCI1yBDniQW53RwRIgWvl448YPtyVznO05ZqBMsw8zSoOK4xUoMWHhPUDDz1BWbPaNa5lZunsgnJ2TCt9ic8hb9lGhGV0eHUgUWJlidiC+IqwmycVFFgQqFdwlLlmf7o8M3ncvb0WqB2jP6RaEt3tKsDwqS8Ky4AiGWLkivvWoLm8ODNsJIWKl9xo27cbYrYkuCLRCUt+XbQCCxU99AJgrQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OitgsLoo8iJhRv/HCvfu1GSTRjfbwPSPD3KWD92GHHF5y8FQOM/CNVwXzO58ItXKNXs1oyE0QF2YnXpc+WDn8WCm9ySXXapT3HPyBrTBzvIrWt6svp6pgR3ILZfd0krjSZ2gq2bQxgxk3xkSbYfBfftC3PJbq5YmfpnoSzPRd074qmKBBDDq8xuzl5Jp9xCOOTmjpIaInlX2dbjSpEJuUttVfZ1WLKxZu6kMj7Y//jDnMxbvo/0gRgyHZSElkqJUKNiJU8pfiAUZgsNnniHtN5mMDgUEb3R2JwoU8rR3OL6ySO/LcWvnxIGu754MbtPRPdlCmB8tX1NzcfuXaf5KPIGOFlbEapqfhaJ+TzxD8HgUSfF8qrkOj5Uw1CuZri9jlu3ki2O/4+Y2VREJlfSmBrwT/O3C4UFBLV1mi+1S6DiDp5xZD/loJd5uxYjO2l/5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:54:47.7844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b059f4af-ce05-44f2-c0b0-08debfa249e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7418
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

From: Alex Deucher <alexander.deucher@amd.com>

No intended functional change.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Amber Lin <Amber.Lin@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 48 ++++++++++++-------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index e323658f972c..0a59a79ee28b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -407,6 +407,32 @@ static int add_all_kfd_queues_mes(struct device_queue_manager *dqm)
 	return retval;
 }
 
+static int reset_queue_mes(struct device_queue_manager *dqm, struct queue *q,
+			   int queue_type, int pipe, int queue, unsigned int db)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
+	struct kfd_process_device *pdd;
+	bool use_mmio = false;
+	int r;
+
+	pdd = kfd_get_process_device_data(q->device, q->process);
+	if (!pdd)
+		return -ENODEV;
+
+	if (use_mmio)
+		r = amdgpu_mes_reset_queue_mmio(adev, queue_type, 0, 1, pipe, queue,
+						ffs(dqm->dev->xcc_mask) - 1);
+	else
+		r = amdgpu_mes_reset_user_queue(adev, queue_type, db,
+						ffs(dqm->dev->xcc_mask) - 1);
+	if (r)
+		return r;
+	/* Proceed remove_queue with reset=true */
+	remove_queue_mes_on_reset_option(dqm, q, &pdd->qpd, true, false);
+	set_queue_as_reset(dqm, q, &pdd->qpd);
+	return 0;
+}
+
 static int reset_queues_mes(struct device_queue_manager *dqm)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
@@ -414,7 +440,6 @@ static int reset_queues_mes(struct device_queue_manager *dqm)
 	int num_hung = 0, r = 0, i, pipe, queue, queue_type;
 	u32 *hung_array = dqm->hung_db_array;
 	struct amdgpu_mes_hung_queue_hqd_info *hqd_info = dqm->hqd_info;
-	struct kfd_process_device *pdd;
 	struct queue *q;
 
 	if (!amdgpu_mes_queue_reset_by_mes_supported(adev)) {
@@ -468,24 +493,13 @@ static int reset_queues_mes(struct device_queue_manager *dqm)
 
 		q = find_queue_by_doorbell_offset(dqm, hung_array[i]);
 		/* skip queues not owned by KFD */
-		if (!q)
+		if (!q) {
 			continue;
-
-		pdd = kfd_get_process_device_data(q->device, q->process);
-		if (!pdd) {
-			r = -ENODEV;
-			goto fail;
+		} else {
+			r = reset_queue_mes(dqm, q, queue_type, pipe, queue, hung_array[i]);
+			if (r)
+				goto fail;
 		}
-
-		pr_warn("Hang detected doorbell %x pipe %d queue %d type %d\n",
-				hung_array[i], pipe, queue, queue_type);
-		r = amdgpu_mes_reset_user_queue(adev, queue_type, hung_array[i],
-						ffs(dqm->dev->xcc_mask) - 1);
-		if (r)
-			goto fail;
-		/* Proceed remove_queue with reset=true */
-		remove_queue_mes_on_reset_option(dqm, q, &pdd->qpd, true, false);
-		set_queue_as_reset(dqm, q, &pdd->qpd);
 	}
 
 	dqm->detect_hang_count = num_hung;
-- 
2.49.0

