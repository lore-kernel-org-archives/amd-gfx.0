Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CB8C88E4C
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 08:22:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A65A710F56F;
	Fri, 11 Sep 2026 08:22:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EBPm+isI";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD26310F56F
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 08:22:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6g12WFVmwlboy+CgkdPpju0lotsg77xNI8er3M9LYear4WLRFdJCz2L3qNg2ZnomIqmvSP6pAbi4+GkseXoi541OqYeOneLKylFAHpM6rVY9gS7ADYo3yVj033+k5zXcDzm0mulrBczEZ1/+K9fDNETET2yeGQK5sY7Ug2n/H3KsErLYVGL902PQbKVSaha1GJ+mW3Ndhr+W8zRDBx7zBUZNhB4iFNDGmKEQoJ4vluAK0XfzypgVN99GN9qfuofuJyrDB2W/EqQkBzqY1S8B1t0KN/aSlgCxZqTieRHfqErJ1m/zyQ5Xna8AyVyOP7DqB7pXx+ZVNoSMoObJ1ecRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OS7otyWlGRslky1aPNlsGlgmz+N38EglW+oWaibo/t4=;
 b=tTykQnVPF8TZjRTYmSjdRmUMJb1aTt1PCPhlFwgTWhRnApSzbNyL4tzTILDhwHwD7zWMeRQk24VwpincEXNi2ZvQy0Z5gkjGSplXyCrwqTA1rRdM9hgd0hLBpmvJT11Eo5gggkUQ9va/I88MGycNGMaH/kgHNV8xsQi0W2n/fXJ+SgsfGYwLKSwCtwSy5jasBxbsmFTfvi6nwaMzhDu6sBVk5E9J+Tc2lk8izoc1GytUE5uNh9rjSBjNYTAd3XeP3xSzdXD/yzs1iEpMvnZK/OupwCE2HByjXCk6eu9zLTZ3z7ofbOUpvifQO7ORkjJyivHSpHT3MmrwWqcEXMKRfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OS7otyWlGRslky1aPNlsGlgmz+N38EglW+oWaibo/t4=;
 b=EBPm+isIULl9kDUNirvetyFXzM+LE9wJU7asE1iYiNcJqIwjmIYJ+oXYFxSfNxFF3QfIhAMeJ6jDl3oWJUETq/k0fJPRRQqRQxorUxEYAQl3KnC7R4RLK2Gn3lvEu64tDDxgSKMj4tnkcuYMUtbWJDiyoW1TrwJC0lOk4bGvpgM=
Received: from SJ0PR03CA0291.namprd03.prod.outlook.com (2603:10b6:a03:39e::26)
 by IA1PR12MB7542.namprd12.prod.outlook.com (2603:10b6:208:42e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 08:22:48 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::7f) by SJ0PR03CA0291.outlook.office365.com
 (2603:10b6:a03:39e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 08:22:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 08:22:48 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 03:22:46 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 3/5] drm/amdgpu: extend UAPI for reporting userq invalid VA
Date: Fri, 11 Sep 2026 16:22:31 +0800
Message-ID: <20260911082233.694414-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911082233.694414-1-Prike.Liang@amd.com>
References: <20260911082233.694414-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|IA1PR12MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: 12c41fd1-c570-4636-0f46-08df0fdddd21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|10067099003|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Nf5xEEv//zUEqRKmxTswnovVsI8qTypMOo+meLMvcKHtsJ8GvL2UVAJXvXCR405j2QXwAks5xyf2RdxyP0C59YT4e63CblOfPlXya15k6REipdJrmJEd9g/ZnF3QnDCzIAwA/+YMB13ZjvVNIT5b/ECfe6vKCZUn/sCyuwI3Qd+30UA766AR5B1GK63D8aEkhr+G6j3wk/W/N7uGOgOWdKEhCylfzEneQTl5VEymvXnRjzUo3QJ8GymhBf+9Kj19xeMXdhW/kmqz0UlrfJqsHiOWcrveM4yKS1T01CI/uPVR1aZO/zYqjZ9P6J5M0+iFZagvunV09YL09qkvBRzmyF5G3Bo7IVHvnsRLG9U/i1sImf/QYPjqR3gOLFnvTkAmsC5w2Fkb4BFfkHjVG9fvtot2hVv+32nK9J7xWrWraXVC32uDL5qmEpcHl8+01lGILXW0KoaRebBaDZ/nWQ93aPqlbyI0jmlp4qDSlbvURp3OJuaQ4lUkYJuB3EKQDpr5c9ALnhiq2Dag/DcS9+s0vlK9TkIpneVba82kwA2jTCjewCA4ptxag5BsLuZ7TNQBtkbB53LIrsh4RrTj3fLKMs0z/hIAm+5JODeHfCmKnh9zkId44JdKEdBQFWymzsOQnI5Jf/DmfOcR7OcoIkGlXfPetSN3cNYc8BL9wxhHTUkk4JTwr1KpXUN03ZJyoPdvV5nu2CBRahqRH+ovBBvTdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eTGNTvrg4prclLG6cbyjQyhG3AtD+M2roOWNIRgPC72apuzcxAbUVuufRXV3fxwQaCpsg2+x3PrbZ9Fa7Hb1ghTkRVsoPzT8FGLJ701jD8flQwdKcN8f5ms0+JBCn1/DUnOnXjvMAePZNgtXPn7QTK4MFlZbuULT77OkrdycnfLI/bZFsDX05JdVMxBglaTI/mOP5s79cqbyNPnpD/AxExxOnSFo5R5An5cYzDWp8tbgP0rCHU1jV8ZPA/qdbUVrIKZukorrXHihPjasFFbDlPmbX9ycdGoFPt8xrQ1mn8dEU+x3KsgH5kKm6IlUi1istyaDp0cdsemPDJwcj8k163AsfqeXVCxFB+Ri7ScIwmRJVF6ipAx8siNHALR0sZblXS5bo5QGCz/P0WXBstRslelbZbP4cUqWjmj4Pj2l+UYi0WfWpyBsh7T4gYqoWYeg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 08:22:48.0748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c41fd1-c570-4636-0f46-08df0fdddd21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7542
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

Add UAPI new definition for reporting userq invalid
virtual address status to user space.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 183ac26f2bd3..2f81ec3265cd 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -358,7 +358,8 @@ union drm_amdgpu_ctx {
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG    (1 << 0)
 /* indicate vram lost since queue was created */
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST (1 << 1)
-
+/* the invalid userq VA unmapped */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA (1 << 2)
 /*
  * This structure is a container to pass input configuration
  * info for all supported userqueue related operations.
-- 
2.34.1

