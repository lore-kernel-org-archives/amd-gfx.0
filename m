Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A02CAC582
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 20:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F39EC10E267;
	Tue,  9 Sep 2025 20:43:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xv63t/7o";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E06F810E267
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 20:43:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3pKDnMPUEf86rI4+uJTQV37e0NPPmm2cCldtS4P20BwlQBNayCUE4SXeFTMpCVAxU8vRI+WG8/OCZaqmPLEKhj6O/t/BfahX/3JfJSoL7v8cF/blRSZ86+Uz0tEjxqPtHFgFhmQSkSMEfDkQhHu/trmlgkBcLh5jboaCI7gK0s3NxxAFom6GFqFlO8v2ZlPgSGNBjrtBIEB5I5jxEJMp50rPk1ZNJI08/CrRNRvaNb7kyy7EtWc+uk6gsf4wYTyimAVtZ5rcx7LfLdrm2ZyZ0t4ja0WGnFc+Inq4+92YT0Fxwm1+poi3QAZOLLNS1AhbAiwoPiAFOCWXrkqcS6Ajg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uymVAHpD0TcInqA0DbISj0ezuI11o6JwjOcJnp88HFg=;
 b=n1sFp9gSSix4Sq8QFMFtrnZftkq+sxAxWwk3lBlOorWhQb4jLmARyc6b6P1S5Y2sSS1idl3s0iQQfvA6GFj9893EVfVpt8CTXZw/XNygHaQlpBjIJRUCBbDvxJqno31YZG6OTBZUQN9F/bn93OAhXYXPkZgcAk7Dk0FGuRTKjV7GX3oZtmXfiLB0IjAoU8AI28Ks8uK1L7UTb1ir9IDsUAjOe/bqiNfQwIbpvN/cTBMGj0mnGSqpYQtZ6pYk4nW4y/w52dna3fMIywSZyuchQXrlYI/dF7lRkn1lLqPRpUSJsrhC1HtL+Dt0XjDQzkPSXNifT3X7/U+cWsmxxLaELg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uymVAHpD0TcInqA0DbISj0ezuI11o6JwjOcJnp88HFg=;
 b=xv63t/7oxlZTyMHz20DWKq27JglQmw1HqLwp4s+/XvO6sAtYgoGt6ZKDLMykxa+ZJ7cm/KpYldY9RAfIbDI2sqhPaXuGepA8pPHfj07tBtEohTo4diFwFw4AZM1RmbSz9uY4VNk+9YbLMvSCtCH/vvNBzkM0LEsY3GDYkwPmr1s=
Received: from BL1P223CA0036.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::18)
 by LV8PR12MB9449.namprd12.prod.outlook.com (2603:10b6:408:204::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 20:43:44 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:208:5b6:cafe::90) by BL1P223CA0036.outlook.office365.com
 (2603:10b6:208:5b6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Tue,
 9 Sep 2025 20:43:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 20:43:43 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 13:43:43 -0700
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.kuehling@amd.com>, <philip.yang@amd.com>, <chengjun.yao@amd.com>,
 <jamesz@amd.com>
Subject: [PATCH v3 3/3] drm/amdkfd: free system struct pages when migration
 bit is cleared
Date: Tue, 9 Sep 2025 16:43:33 -0400
Message-ID: <20250909204333.103893-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908161526.99413-3-James.Zhu@amd.com>
References: <20250908161526.99413-3-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|LV8PR12MB9449:EE_
X-MS-Office365-Filtering-Correlation-Id: 329576c4-01aa-4617-df49-08ddefe1913f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vFz+48eds3K+nbUEiDYR5qAY6gw6dtL8OdW+Seh5jWARis2aIp8939f28Z+l?=
 =?us-ascii?Q?3Um/o5dbHBz6Cwjb2h6/Yyf85So+EmWDRQfOYOp0Qw8tL5WMBybmpOYBi/5r?=
 =?us-ascii?Q?T0SY2ukVC48lmxIUjujOSlWt0VoVxtFms4odNGTvCyZ42L7ZLk3RpHa3YDAH?=
 =?us-ascii?Q?21H98miLCqEnkFxeO651cWOtqUOWMAILd1wQZO5KOv95YzM9weoCVnGdg0Z3?=
 =?us-ascii?Q?9Hlynjc6y7IrfWc1nSngSnEdQW6TXVLqM97esWXuaUmDZjQz9Lr89ViIXicl?=
 =?us-ascii?Q?T2qD506b7709yGGF8kmvNGHuRV3yNzZPNMcp3AYa1mZjv/3ADX708+ZurHMb?=
 =?us-ascii?Q?tIML0cCmSCLD384IJsUFQkIBSAO+fK9FhGHoBseCyNKcJE+sq/8KEw0k9QqV?=
 =?us-ascii?Q?GEcIwgiGmTjfnIDBa0igxsY6nX9KPm2iKPFVA57jnGMg1nbpr57dUQcnVNQM?=
 =?us-ascii?Q?axTd4rWsGn9aGTPb94OHEM9s2FB7C4dPoR0FheFZSJMGFVo3jlyiF8Du0Glt?=
 =?us-ascii?Q?WwmGMa7XMB1skhEnI7E8CHoycBPhZXoE9IINgYoeYhurb2wRXzodcILXx8IG?=
 =?us-ascii?Q?3IIiH8CCads3fSUB23ilZJYD7O/bBnLJYdXgFhkV9+CmqR75miNW3R0t0WBS?=
 =?us-ascii?Q?dQqRskaOuBhT3IZjsZTcM7ElC4B0BT1hJkr4GmseaL5pKydOC6gXsua4G7Fm?=
 =?us-ascii?Q?LJclw1993yUcoyWCMGOSkhksme3jRMrAzV91NuKQVLxWOemgXqfREiLEgYWd?=
 =?us-ascii?Q?eEh19GBgEd4kv8qvEIOMfm8StpEnUqzVeFDptor2D9lAGakvXACVkA1ewVgc?=
 =?us-ascii?Q?VYZn1WEVce2YDjKkiiLoOJkVEkyF+T0J9wtUaV+1z+qeGZT2dRdSdh4HW85y?=
 =?us-ascii?Q?nz0FdQxnFy13jCDO9LeKcE3E+/0wT/uto8PtstE8JQ1PxB6TLrMS3XTcfrwo?=
 =?us-ascii?Q?dVOx6ZCglokZZf9ZWnnuUPn2iwd+7srJWYqR/+a5ZZw6EKQMmtIjLlRYKLOg?=
 =?us-ascii?Q?35MSSdJpzO0bSqt2ENVJrYSdwHSaO2/Ri7iNXCEc28nknGZZV54V8lPCn3fN?=
 =?us-ascii?Q?B7VbvJfs9htT0Gcrjo4/XV4BZai84tq7P+Joo+bN0IKkQs4kh7WpL4LIpC6t?=
 =?us-ascii?Q?YKLd7KqFNJ66We1cRizJHeIgOggd/upuDws9vNSPTq0eE5FJZ9Jf0lNYC5GK?=
 =?us-ascii?Q?ac4cD8Gw2a+075hLW2Z0KDfiNNlbMjLUOTFuZ6X1JGFycBbO/7xBgrR2a1Zh?=
 =?us-ascii?Q?wQqJwAZF/7A7b7eD4/X9uQSjVHV6HTEU4uGF4Va9HOwAK/AHPKaKuspnOY/u?=
 =?us-ascii?Q?AZPCi2WV3NOFRw1baL3loP4Q8fMnGbOebDYvuEyOV8JDoHN/jT7ljfO2Ac/I?=
 =?us-ascii?Q?B07RE9YUn5ser5+yzSALX7LizlRsi0e56QSSCb1nCsEixDkksBo7ShsAOd8Q?=
 =?us-ascii?Q?Dvvxg0Emfvsk/JDqhvAfJsZP06RV7JA+DFldyORT5CSyhQTwsMh4AYOLYC6P?=
 =?us-ascii?Q?2NnzzVJo6l/Kl5z/W35CvzLnervYq4kcCQGU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 20:43:43.9631 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 329576c4-01aa-4617-df49-08ddefe1913f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9449
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

if destination is on system ram. migrate_vma_pages can fail if a CPU
thread faults on the same page. However, the page table is locked and
only one of the new pages will be inserted. The device driver will see
that the MIGRATE_PFN_MIGRATE bit is cleared if it loses the race.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 10e787e47191..1a30764aa91b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -266,9 +266,13 @@ static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
 	unsigned long i;
 
 	for (i = 0; i < migrate->npages; i++) {
-		if (migrate->dst[i] & MIGRATE_PFN_VALID &&
-			migrate->src[i] & MIGRATE_PFN_MIGRATE)
-			mpages++;
+		if (migrate->dst[i] & MIGRATE_PFN_VALID) {
+			if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
+				mpages++;
+			} else if (!(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM)) {
+				svm_migrate_put_sys_page(migrate->dst[i]);
+				migrate->dst[i] = 0;
+			}
 		}
 	}
 	return mpages;
-- 
2.34.1

