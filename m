Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B4AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 977BE10F60B;
	Fri, 29 Apr 2022 17:47:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8952010F72B
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqWW+IRwhcqoXnp4EoFj/qu59+2ZnlNinlB2NfbnNvLj6nLpJpkETOoAhTP5uYvMMpbozwfdvgbhRoPQuleiHC1oLQS3jAml9asBeitNjok8s3Fb8XpanvcK8enN09xtRdoQ/A+3hhRZni29Y3pAzAclXh9wt4riXDqmpfRgsMyzEMIJdP76SNA1wxF6YQ2AvurwIEkB7N1mftU1OBgaW2e8arqeqD48vL3Pk8eX75wntfQmGC7983SyFBQp78V/sZRLh0aNuxLaNGhdb9We0QB9kj49V5q6nSkqzahNZIqY9NmbkcDlxBQ1lB4XTFpGV82MdWdQnfYNkfFFc45wFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfcN72CIf8/bwkDWocljSF4V9m0hbucAjwewGuuznLw=;
 b=AmqjIoAFDsnUOPL/gmim5xmssbzrptmR2twHyiJNGT/TipLNktNOh0kA+7vrEd1Hxze0mHCM8Q/tjGdzWnrKEMoJ21mxWbSZK/ifZoxItrMiqIWnXgPEIFrmAPjeE2ZE9TH2lZr0UP4dS/GePsXtUQ23Dbxe774DjPCC7TWQMbuK55ugJvRFrvVDgTsK/XArd/iO9GAQ9Bx2xIGRbonSFomZbT7noN6X5ENEsGuu1PKn1bbRkOfzVOI77GC5afOr0ANVUkZOKoRANqcKXXA+D757QcG2SPbTE6YvyKo9k47aZDA9c5AxWnqLWR3vQiQMiYje63sojTT51O/jRlEW8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfcN72CIf8/bwkDWocljSF4V9m0hbucAjwewGuuznLw=;
 b=yggEPsFpVw+tJRYsmiwg1I/2EdsmOEc1xzJRFD75YXfKUZLHSIfAoVwmXDtY9PJyTk0rdtD8nJ01e/edBqvibDPGDsGYa9F46ThU+UgsC7qrzFw2Qj0WBc/0gZg0HcIVAXPhCqmJm2ILws2rzyIMRWyFf0KkH6QxKrAzKP7F5VQ=
Received: from DM6PR17CA0024.namprd17.prod.outlook.com (2603:10b6:5:1b3::37)
 by DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 17:47:20 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::9e) by DM6PR17CA0024.outlook.office365.com
 (2603:10b6:5:1b3::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.25 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:47:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 68/73] drm/amdgpu/mes: add ring/ib test for mes self test
Date: Fri, 29 Apr 2022 13:46:19 -0400
Message-ID: <20220429174624.459475-69-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7a34f504-28c8-46bc-96ad-08da2a084f10
X-MS-TrafficTypeDiagnostic: DM4PR12MB5181:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB51818C84F80563F55EB7105CF7FC9@DM4PR12MB5181.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tdMWiW50tf656Fk8fTwsDt0uwaMFt9AYFBT8v3XfrPKgjN8MetkO1T5gA7CHUufbM6pWONC1A1pMHKkGmhbn83F9LLH95W0c7gQ1SXVaJpHjrur6pmfms+bq5cO/7iXeXp5NJU380Oq70VqRFOS2Z0NcxFdTjR1rvm8+yv3FPzK8VgCJvDTbuxUMSj1rZ94wq6BfxK06ltkusSnYVf8s8KuT5dY0RfqwXpj6wZZchJTJ7YMEK+LVCwC2xbpr3UUHaW4xzGoQ5MbIrtQTUpEGe0TeyBwVlB2/74hVVjgJ9ISlX4V2KS4P7mK/eFyfGHeW/tDT1zAEH/AjD8vytizRotvx3utLhWVmroBj7ydvRVNkvCYRoxUjs1vZmiqWZcnDXdDGg1uGQT5GRkGUb4xtVKa1DJ787FgeEjsm9eRmyS7IFq0b8cu8zKWVL4woIoMab6ejI7V6KrFzvbem7d/g7OybvdESZ80ncxGQzgm7C3K1XdmTcmrhcdkl8JfnBkovxKj1njNBL6qumVZUJ6NWrbP/+Aqa+bTAgipotJ4c6sp/ZSuovyiiD9BcHEX+rgYNZ+0PDHUHoX8wkh06OL9JFqR6/xtOhC4ZY4maCd7mdFwWDDFz8j7w0MmTfGBUUykN+RNqRQkfWdJQVQE11OdDgykYrdy+NuZKVjmkL3KsvGLcDBtV0huccXpiNCzkV+p8GOUCMTqH7So2+3BEZc0efg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(508600001)(5660300002)(2906002)(8676002)(4326008)(2616005)(86362001)(40460700003)(8936002)(7696005)(316002)(81166007)(6916009)(82310400005)(54906003)(36860700001)(356005)(186003)(16526019)(336012)(426003)(47076005)(36756003)(70206006)(70586007)(26005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:20.0001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a34f504-28c8-46bc-96ad-08da2a084f10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5181
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

Run the ring test and ib test for mes self test.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 027f3aae6025..e2b1da08ab64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -958,3 +958,35 @@ static int amdgpu_mes_test_create_gang_and_queues(struct amdgpu_device *adev,
 
 	return 0;
 }
+
+static int amdgpu_mes_test_queues(struct amdgpu_ring **added_rings)
+{
+	struct amdgpu_ring *ring;
+	int i, r;
+
+	for (i = 0; i < AMDGPU_MES_CTX_MAX_RINGS; i++) {
+		ring = added_rings[i];
+		if (!ring)
+			continue;
+
+		r = amdgpu_ring_test_ring(ring);
+		if (r) {
+			DRM_DEV_ERROR(ring->adev->dev,
+				      "ring %s test failed (%d)\n",
+				      ring->name, r);
+			return r;
+		} else
+			DRM_INFO("ring %s test pass\n", ring->name);
+
+		r = amdgpu_ring_test_ib(ring, 1000 * 10);
+		if (r) {
+			DRM_DEV_ERROR(ring->adev->dev,
+				      "ring %s ib test failed (%d)\n",
+				      ring->name, r);
+			return r;
+		} else
+			DRM_INFO("ring %s ib test pass\n", ring->name);
+	}
+
+	return 0;
+}
-- 
2.35.1

