Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BE7C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 16:00:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7453510EA40;
	Fri, 15 Dec 2023 16:00:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ACC410EA56
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 16:00:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6vw90v+Gpmq3vJOH+l1GJOqKn2kTq3B3lkoxk7s+ZbMbU8+y9fw/DbAfj2O8/hmlP6/Unqmx1Li4KHD7PRF9LpXInaX4buyvwBZekAx+7/z2PirMtom0cPlomU+mXytAaKvJJdWPYXigHSR1WTJtOEr56PhfEiMXkv8qtvMhZ+Ifa4zxYvvMAqxSdKyOLKxtHn+no52if3fOokUDrioIhTVmjHCvSI4Urwkt9Y7OnB6itNhCCxP6uRTJuBlqT95tSB7v7EO6eea7Uk8xSQlASchQZ20MlomE0P9t1fqi828iME+7qnwUbq0DBpjToAr390rsJwXvU1caoPckxTnIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I35+K9HNMbE/sbXG3seR7Oc4R61yoVU0pqXFZz6oWhc=;
 b=QI24mv4GJp8Pg3JlKuArRBZQm17hEwGiV7WxBarofZukT5EbxcBDBDFHWmfggFiS1/p2ABK/DgPH9wdku6ZUtQQAl9a5zeC6TX/yK2gz5vwICdK9Nl4NHKhMVamPhbc0cOKesCglzrKhJ9/Y+8jxaMCDo4Ae8ZW5OWZ+ePa10YNucvGn2IvTrPJtiqByMjOz/uAVwok0msWWIS5BUjxfUO7gjZOeLZFHIWM7bMC5adylwOfQZPlO9Hum7BUm2jC8dWUWJHmnRMe5790fVU68JtJIDvfzxLPZ7SHR7jONmvk4xxl1moUYRCBR2+7SrIngKmDp6e6NQZ8icDlVHBFCCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I35+K9HNMbE/sbXG3seR7Oc4R61yoVU0pqXFZz6oWhc=;
 b=MgqxBHbsrywTBGei2+9ISXfMLsdD8aRWfxiKgaLEGnVaWCegkBVC7tdzEh8kax42dgfMm4aux+bOKbTmem/xHFvPnPpXi1xkL5E28l0YGc9ZjVxLhuCA0efBjqtNyq8ZSSgshMHj065z5D8UF7irY/SfKIHYkEdgcdGmJKyMgk8=
Received: from DM6PR06CA0013.namprd06.prod.outlook.com (2603:10b6:5:120::26)
 by CH2PR12MB4103.namprd12.prod.outlook.com (2603:10b6:610:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 16:00:42 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:5:120:cafe::f9) by DM6PR06CA0013.outlook.office365.com
 (2603:10b6:5:120::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Fri, 15 Dec 2023 16:00:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 16:00:42 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 10:00:36 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 05/24] drm/amdkfd: enable pc sampling create
Date: Fri, 15 Dec 2023 10:59:32 -0500
Message-ID: <20231215155951.811884-6-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215155951.811884-1-James.Zhu@amd.com>
References: <20231215155951.811884-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|CH2PR12MB4103:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f16211d-0ce0-443e-b7ea-08dbfd86fd94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /MytS2rsyES/18qE4AsgN4tacJJJb4pe4ZqYLGW4k5pvLJN+ksIykoTPEvIhNw9XOdjXV7rNdldP+XqQ/03EGC2aGUUL9OJlDC0S0K9TGtxcCicjxhBBQCjpPl5e607Dr/4gLRPuPTScFEWhWEJS8+STHbxLPM510RpxUqzH5aCRrZb51j1zlWDS3Dt8/8XHmUhVb9td8yJ4fzk1g3KkRgS5OqapJk1ecxxj7dDNsGoUICmUz6YIltiLZaydQ00MAtFtlM5HpxMXjhqGrhYupM81r/ErVZU4yyL89XNM4Z7BpcF1n6gQ7Xf4dld+ThrP0B3HPcUmkvVnuZw7PDafWHil0GSagN8Krkg2MdryJcHqKsUV813g7/QBc8ORO/9GLGGm2mlfzM9RdDDQxibOWkSp5YetBeOjg9xSpe7AQ1bvbLHfbvk+SIuvj4P7QeVpD8nlIuzDyc56HbpzoZjtHWl0Q4vFuk/sPMz/ysLRgf9e38iRGTZEvIjzFpK4xtvflN6ZmH/6i/X3SLJa8tzHURW4BulJgsCUWDfVsahi/nslBGcrTOhc6QmZYi54R6fV1tRb47tIaIQBk2WCRAOpGVn3AgWrnK4A/YnGVP66TVbwZ4ZyCGT0Wb6TUUV5an+Fm9wUY6hFhoKUxs9jCbi2MtESi8hIet2QCGruLqBykXnEichMgYU2SnDdueVxQvXDaM23Jnk08VbpR7AwtPSmXaZvMOLLE75Gl95uBYZLWr14jmALHVzEZlhakXwb8b7b7uM+TYa1fnbhXE0B6QW1TA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(356005)(26005)(81166007)(82740400003)(36860700001)(36756003)(336012)(426003)(16526019)(41300700001)(40460700003)(83380400001)(47076005)(7696005)(86362001)(6666004)(40480700001)(8936002)(8676002)(4326008)(5660300002)(478600001)(54906003)(70586007)(70206006)(6916009)(316002)(2906002)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:00:42.3946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f16211d-0ce0-443e-b7ea-08dbfd86fd94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4103
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Yat Sin <david.yatsin@amd.com>

Enable pc sampling create.

Co-developed-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 53 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h        | 10 ++++
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index 987c415f8f0f..106fac0ba1b3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -97,7 +97,58 @@ static int kfd_pc_sample_stop(struct kfd_process_device *pdd)
 static int kfd_pc_sample_create(struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *user_args)
 {
-	return -EINVAL;
+	struct kfd_pc_sample_info *supported_format = NULL;
+	struct kfd_pc_sample_info user_info;
+	int ret;
+	int i;
+
+	if (user_args->num_sample_info != 1)
+		return -EINVAL;
+
+	ret = copy_from_user(&user_info, (void __user *) user_args->sample_info_ptr,
+				sizeof(struct kfd_pc_sample_info));
+	if (ret) {
+		pr_debug("Failed to copy PC sampling info from user\n");
+		return -EFAULT;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(supported_formats); i++) {
+		if (KFD_GC_VERSION(pdd->dev) == supported_formats[i].ip_version
+			&& user_info.method == supported_formats[i].sample_info->method
+			&& user_info.type == supported_formats[i].sample_info->type
+			&& user_info.interval <= supported_formats[i].sample_info->interval_max
+			&& user_info.interval >= supported_formats[i].sample_info->interval_min) {
+			supported_format =
+				(struct kfd_pc_sample_info *)supported_formats[i].sample_info;
+			break;
+		}
+	}
+
+	if (!supported_format) {
+		pr_debug("Sampling format is not supported!");
+		return -EOPNOTSUPP;
+	}
+
+	mutex_lock(&pdd->dev->pcs_data.mutex);
+	if (pdd->dev->pcs_data.hosttrap_entry.base.use_count &&
+		memcmp(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info,
+				&user_info, sizeof(user_info))) {
+		ret = copy_to_user((void __user *) user_args->sample_info_ptr,
+			&pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info,
+			sizeof(struct kfd_pc_sample_info));
+		mutex_unlock(&pdd->dev->pcs_data.mutex);
+		return ret ? -EFAULT : -EEXIST;
+	}
+
+	/* TODO: add trace_id return */
+
+	if (!pdd->dev->pcs_data.hosttrap_entry.base.use_count)
+		pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info = user_info;
+
+	pdd->dev->pcs_data.hosttrap_entry.base.use_count++;
+	mutex_unlock(&pdd->dev->pcs_data.mutex);
+
+	return 0;
 }
 
 static int kfd_pc_sample_destroy(struct kfd_process_device *pdd, uint32_t trace_id)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index cbaa1bccd94b..db2d09db8000 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -269,9 +269,19 @@ struct kfd_vmid_info {
 
 struct kfd_dev;
 
+struct kfd_dev_pc_sampling_data {
+	uint32_t use_count;         /* Num of PC sampling sessions */
+	struct kfd_pc_sample_info pc_sample_info;
+};
+
+struct kfd_dev_pcs_hosttrap {
+	struct kfd_dev_pc_sampling_data base;
+};
+
 /* Per device PC Sampling data */
 struct kfd_dev_pc_sampling {
 	struct mutex mutex;
+	struct kfd_dev_pcs_hosttrap hosttrap_entry;
 };
 
 struct kfd_node {
-- 
2.25.1

