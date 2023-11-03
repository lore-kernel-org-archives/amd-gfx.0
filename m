Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4715EC0018A
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 13:12:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4C2C10E9D5;
	Fri,  3 Nov 2023 13:12:19 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9987910E9CA
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 13:12:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPPs2xvUEqsA1++UIHXd3KnVs/YxaBxNZlWft9reVzrKVIW8hVL6xX1fatXVK1JlEYjgxlU2qin0DQ0nIf3jjhGZY/dvZtoj4N5q04z+kEoY5UzPmCuyLhFZ+g7vNaJ4IEozcYmeoPKWHoKo4VXaD4XMANl/gETsP/kw6LloFggdYpy4qCmZnkLrHG/MPE3lOj/mvDKA3MaOlc0wp0wkZO3vhBEeMDjiKryiWbXzo5Mbp3Ft7tvhH0q4ET3Ck4cRonC1E+H45NJK/mCuxw4YhUnhNDjo0DPZk3OTRP/iYfGiIkbYrGAPia6Dg9XNvy9DY1LIkbcx2rQXcMhqyiIWiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzjCUXxjzHQuRD4okdDUlp+8xEBN4H0UdxRXhQxalJE=;
 b=AhElxUKE6FULaZ7jTGf941aPJdXNyhPkactqdFQF5NZrvwETcp37QjSiDTRQ6mFjB3TTHNP27JjpF0noCwYFKY9pkwgDBxHAot4A6wGvObFaoHZZZnV2IIo4RDCAPIKWCEhFi0KgEV+0R5sreo97OyewO//eIyZCRNeEfWf1g9DsV1jsj69C8XhG03dKaoAapPOXLmPA/sDSWsA38jN3+Qhf3Zs+k81zq3BHQWuEKb12SvKE/x3nWfDsiWM3uNPkM+iGt0NQQFi6ojau7YuQoZRfl5T1LZgBz+0LgToYJTld0c0UCJllsemzeUt1gLpV1dXRDutOWc2SCTWWgBlZ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzjCUXxjzHQuRD4okdDUlp+8xEBN4H0UdxRXhQxalJE=;
 b=DhpRrEQntGY4pY1hqoy/05Ff9iI2j5GyHyOMEXwWuCO6ChxLJ1/WndQWwUlufFbusngN+2vNKivyjY0E6bLiEJRHaWLTfoO9yW6kqEBT9VEXb+w1ckrI6kUQA6w351O3LIIFO6OZPk7qbckfo+dVP30N3WF8tleIcLUSFimHpqs=
Received: from DS7PR03CA0107.namprd03.prod.outlook.com (2603:10b6:5:3b7::22)
 by SN7PR12MB6931.namprd12.prod.outlook.com (2603:10b6:806:261::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 13:12:11 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::23) by DS7PR03CA0107.outlook.office365.com
 (2603:10b6:5:3b7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.22 via Frontend
 Transport; Fri, 3 Nov 2023 13:12:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 13:12:11 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 08:12:09 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/24] drm/amdkfd: add pc sampling capability check
Date: Fri, 3 Nov 2023 09:11:38 -0400
Message-ID: <20231103131139.766920-24-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231103131139.766920-1-James.Zhu@amd.com>
References: <20231103131139.766920-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|SN7PR12MB6931:EE_
X-MS-Office365-Filtering-Correlation-Id: c91f138f-ae5d-47ed-8755-08dbdc6e7d6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WmJIdRX7mNZffnIUmkuy/b7sJodd++wjdFG9G7UxAACLwADbeNisHrvOjoeJulceam5pUHv8aNVNLVJ6PYjDtFVlAymUPHK6Ujs1uLdo8N16EQBgXILcSauHo00IAQz2bqsTs4LKoKot1MBfOR5T9iD8hm0wT3rOOm9MeaPX9ERbU/S1FDylD7pXSOezltWvV0Jdmv9jsIVkMafH2U/NEnLizSOPhnE9snNfcJUbgpT+sl3fxAr26HE0H2TGAZR5dOv/WaZkTaRab7GfmeKQ4WgwhGiZrgmrZ0N1h8p3gRkt9nmWeUHfoozEPDSRLOXQ1o2h51rn5XfqKlazUvjJrzf05OXsCJeAR1AjNaiz/sdCWfWxDFz3IPbPvcoE/BmUzY/DSYr2ybvE26olO+3CmPAoT6BpQCUCKbh/+azXR1zzUR8+pB5pBF7ISZlHjhaWZXsOFmM34hM+WMlK6Xk68QsQJOTdn1h/hobnuvQB5IdsRYkpIUdpdZowoYosAcfDkX/VFuyCDT1UKYvK/zJAOdzZ7QBkgiq2DwMwfuvP/3dRkdjFPYy1swKZl7JjqQSLUQ8z1h+TOx1FrhS3bXjWZ/qXVZJohlVHbPEYnfcRNhtc24dXsrGga+J0eneAGJ+o7sjahRmBLOn0XikAujaA0XGxYLbBOrFQvDkvDdNETbLtHlWVJSZcmwWVzKavULZBVgRzRSVNx4XaBFVRjlTsGSEN26I4XHwF+UYNGWU5GAAsFl/wUB8cmFAuVrILTVAoKSsPSvYScq8yhC6/jTV2EA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799009)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(2616005)(26005)(16526019)(1076003)(426003)(478600001)(8676002)(47076005)(6666004)(7696005)(36860700001)(2906002)(83380400001)(336012)(41300700001)(70586007)(70206006)(5660300002)(8936002)(316002)(6916009)(54906003)(4326008)(36756003)(82740400003)(356005)(81166007)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 13:12:11.0766 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c91f138f-ae5d-47ed-8755-08dbdc6e7d6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6931
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

Add pc sampling capability check.

Signed-off-by: David Yat Sin <david.yatsin@amd.com>
Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 10 +++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 13 +++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index b00390e451bf..5e47e374d824 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3259,7 +3259,7 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
 			kfd_ioctl_set_debug_trap, 0),
 
 	AMDKFD_IOCTL_DEF(AMDKFD_IOC_PC_SAMPLE,
-			kfd_ioctl_pc_sample, 0),
+			kfd_ioctl_pc_sample, KFD_IOC_FLAG_PERFMON),
 };
 
 #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
@@ -3336,6 +3336,14 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 		}
 	}
 
+	/* PC Sampling Monitor */
+	if (unlikely(ioctl->flags & KFD_IOC_FLAG_PERFMON)) {
+		if (!capable(CAP_PERFMON) && !capable(CAP_SYS_ADMIN)) {
+			retcode = -EACCES;
+			goto err_i1;
+		}
+	}
+
 	if (cmd & (IOC_IN | IOC_OUT)) {
 		if (asize <= sizeof(stack_kdata)) {
 			kdata = stack_kdata;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index b7062033fda4..236d3de85153 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -144,6 +144,19 @@ enum kfd_ioctl_flags {
 	 * we also allow ioctls with SYS_ADMIN capability.
 	 */
 	KFD_IOC_FLAG_CHECKPOINT_RESTORE = BIT(0),
+
+	/*
+	 * @KFD_IOC_FLAG_PERFMON:
+	 * Performance monitoring feature, GPU performance monitoring can allow users
+	 * to gather some information about other processes. PC sampling can allow
+	 * users to infer information about wavefronts from other processes that are
+	 * running on the same CUs, such as which execution units they are using. As
+	 * such, this type of performance monitoring should be protected and only
+	 * available to users with sufficient capabilities: either CAP_PERFMON, or,
+	 * for backwards compatibility, CAP_SYS_ADMIN.
+	 */
+
+	KFD_IOC_FLAG_PERFMON = BIT(1),
 };
 /*
  * Kernel module parameter to specify maximum number of supported queues per
-- 
2.25.1

