Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD34FC25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 03:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0728710EDC4;
	Thu, 30 May 2024 03:51:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FOq5DfYr";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F67D10EDC4
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 03:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHbNhL2LKZvxiv6M5OJUor3dqMlkHQ3JPm0rSTG73QZlUebgbxMMvZ9VICCzniZeJjyYU3NWaKoOeAbu6iF3uSbV00qwVpG4PQil08edVgsbzip1jwNtihexn7oAlZIbckxWVMjdYoOZH6u5m/4s0Vh9W8J/qi1zvhPGCHZ3DBEm26SLNU/kndWeXA3q1WyHf6xPH9BQjUUnmcSC7fG/4qCtTcvesDAj/jbrf9O7npIfH2wtYbRWrzU0nP91n2xI2jyZ0WFTEZjf9QIlscHUygCGin21+8365Lu0wJfvp9apf2woBevE0jmRsy3T5RWjtmXPju9GBLdL7SaG7MTfUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbJSoSfthXvwzyyitk2EpoeYD9Fxu+KCDNNXsdv0tDM=;
 b=kEm1MGGFLrmIQu5Yc51Mj/B2DBkjVlBDDSWAdEJO4Viyj00M4PCJjXO/GlU5qUqF3oSZ9Vxh1jPySBT8u0aWgKGxHOKE2zS+Ad4gC8DuP/BEnknhbIjPFdZxlDnbGv3Auo8EKW0UB/Uu+da0JcGkUTglln1zPEultPLgJPCk2qPg4ud7KRdhOvwmvdymqTPcX8lH/q/uT3CFJkb2SMU97iJPJSOzHZxmkNedVwv7JfQ54a3q3eWBPKMX+WLPdbnH0WpFkriaIL50HxtPuQsJQMrhYbWFEX7LlcgVUZ6TZCGWC61gLp/c/kz3hg/t16xaNto0zeVJK2hyVI/sjiBcTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbJSoSfthXvwzyyitk2EpoeYD9Fxu+KCDNNXsdv0tDM=;
 b=FOq5DfYr2RQP42oMw/HHw8NoyA9AbIvCy3RDpgOdeicbYJKhcPLWDdggokpylrygoLF2dT2IaHG1QhpWo16RSThXRsYljhXja6ZBZ+OwrkaWrEA99bM3uXjZQ+0r4/HroHcgA25JWMexN7g4wf+y9Pub1wu/t0JykgWAHPu9hM8=
Received: from SA9PR13CA0032.namprd13.prod.outlook.com (2603:10b6:806:22::7)
 by DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 30 May
 2024 03:51:08 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:22:cafe::14) by SA9PR13CA0032.outlook.office365.com
 (2603:10b6:806:22::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.16 via Frontend
 Transport; Thu, 30 May 2024 03:51:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 03:51:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 May
 2024 22:51:07 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 29 May 2024 22:50:49 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, <jonathan.kim@amd.com>,
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 8/8] drm/amdkfd: remove dead code in kfd_create_vcrat_image_gpu
Date: Thu, 30 May 2024 11:50:48 +0800
Message-ID: <20240530035048.2341626-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|DS7PR12MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: cb5f8c81-90e1-44d2-c6c3-08dc805bbd00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400017|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?twYFEIIdTNsq6mvEika7uZZDbEK9B2tP1tJ+96RUu7Xbf/Jz53xPKzMitbSh?=
 =?us-ascii?Q?E+mUwQFeDnWyl623YSHxykazP513jcAv8GEMaOUQW5TKQCslLRzTLjqaMGsP?=
 =?us-ascii?Q?ZySDlN2mr3OEaYhSTKd4Ju3/o0JoMPnf48QDTsjfM2Gc9Le1gakHNnzR+SV8?=
 =?us-ascii?Q?XANOTOkCpsd0Rp6IPWrGledoVgICQXzyF/htrDhsuqrb1rCgv5gu46J4HnRV?=
 =?us-ascii?Q?jYXA3WKANLtybBkcfEsAw38Q2n7ix2xdZ7G/VI4LTRHqFzoV+T7+6RlXN+Ks?=
 =?us-ascii?Q?rYqig4lIhj9CU+eDnlCJ4WoRWbfHLoMCAcJVDdMhS8HMx0xowf6qeM1zXusm?=
 =?us-ascii?Q?y7gRWvDeP/6qyt3xCb8o3vYDkVv9gVXApN7X5AmVthTIJoNqYwDeVDhGKTBe?=
 =?us-ascii?Q?kCP4McEZ5RXrkjDRNUWKzGXojO0k+0VgAd6qjEoTLpblpa4amdEcEoBPgWyh?=
 =?us-ascii?Q?E+irAjmrwzkI+IV5TTIUpsbfyysssKDlexfGGGd38y1HgwxxebKMfix9Xc7N?=
 =?us-ascii?Q?44CDxNo3/qwKHAdKprDt2+rCNmrwGMwkXdp1udr8nAcBElIb3VzVmT8aDde/?=
 =?us-ascii?Q?YW68OYW7KjP4ecQ9OghK/AjdIGIVcDB4zuNw2bBHpN6dCtJ2PQpwgjHupfrK?=
 =?us-ascii?Q?VB+L5LCB/OcCLEg9U7VJ99JTRJZSJiCt/RzkXXdv3BWj3+l7dcLSlhlweTXk?=
 =?us-ascii?Q?CnnVOx97UrAbwX+QRehK/etid6KIF1JIshveZDrZOT40FRFNTWPYP1zf3UkY?=
 =?us-ascii?Q?NIp+VZs7nGLwQhD3h8ge59npIR8HfZo3LaHElJBve97l5DsuGEei3oKAoE8M?=
 =?us-ascii?Q?C99s6ptj9OIQ5tQhuH8zBzDl1pvL8tDCUsmC6Mi1VYJq82hv6vyGzSw8D/pB?=
 =?us-ascii?Q?Bo3TP7Fw+ZVsfUa+jkAJYSrYSGct2I2LyjEhhn36HR9uJJiMQleZzsHFObKj?=
 =?us-ascii?Q?jS+8ZefJ5ILv+13OMsPqcJoOeQMFqJQQBCdX6hOu9MNzziTIPzLEnOVyodYQ?=
 =?us-ascii?Q?EVVelbSLAwqvZ0NQIrNjE93AaIwOu3EiHoPOFVSIW8Hbe7+n8B/nTBsfW11T?=
 =?us-ascii?Q?q1mAH8/WqOPjQizHqKUghWspvpj2vUBpMKxhGGoHb1nN6BSdCT5rGYYsl2YS?=
 =?us-ascii?Q?jgVvceIzZ/hrjl4wmC6q+GnMwbuLlf2rAWxeSVqvKl3sAyi2kMShg6oS+lqG?=
 =?us-ascii?Q?l6aGq54xNxLw4hATMoJ1tsEGUFR/MGp1MlNTdyudyApMdZUyv+6AMhhizAc3?=
 =?us-ascii?Q?8yzju3djzs6TSHmM3Gpyq3KNeFhCcz+PA6LbyB0OF572/0hODngE9DUwznSR?=
 =?us-ascii?Q?MVeFNifAHZ5S35fpyVVGQbcHTNLJV7qgdur7E2qyp2GC3hywcZNnY/68TwiZ?=
 =?us-ascii?Q?ihQbAMCBqMeSKj9xcvatqmgnOky6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400017)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 03:51:08.0466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5f8c81-90e1-44d2-c6c3-08dc805bbd00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6214
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

Since the value of avail_size is at least VCRAT_SIZE_FOR_GPU(16384),
minus struct crat_header(40UL) and struct crat_subtype_compute(40UL) it cannot be less than 0.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 71150d503dc7..ead43386a7ef 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -2213,9 +2213,6 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
 	 * Modify length and total_entries as subunits are added.
 	 */
 	avail_size -= sizeof(struct crat_header);
-	if (avail_size < 0)
-		return -ENOMEM;
-
 	memset(crat_table, 0, sizeof(struct crat_header));
 
 	memcpy(&crat_table->signature, CRAT_SIGNATURE,
@@ -2229,9 +2226,6 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
 	 * First fill in the sub type header and then sub type data
 	 */
 	avail_size -= sizeof(struct crat_subtype_computeunit);
-	if (avail_size < 0)
-		return -ENOMEM;
-
 	sub_type_hdr = (struct crat_subtype_generic *)(crat_table + 1);
 	memset(sub_type_hdr, 0, sizeof(struct crat_subtype_computeunit));
 
-- 
2.25.1

