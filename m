Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117BCD2ED00
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 01:34:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8750C10E40D;
	Tue, 20 Jan 2026 01:34:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RM8cp+06";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010057.outbound.protection.outlook.com [52.101.61.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE6EE10E292
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 01:34:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZ7xArayuHnSUbqr7SQO7LFLeeLLlw6lgZS5u6jv8rKxtlOnmIQHYRjr9Dde8DyM5qBuG/sq/+LXyap00EzsPnCS6WpS1T9ViltXRdK+3O0WKDPa/BdoA+ZyQ2sLvjKH6yNsrdrWOyrRikZUlCBwmg0JckNtZVsrY11oYBa5uoYMiV2QY3rk8u/W2I61j3W4V0wMiAWfSTc8GBp5OPiahZS76QMlTRjgGQLhvAYI/8GbMBcSC5I7Oc5/TQziJt6T42SA1XlfwKui8H/XHk4KZzdRkintHQ5Ji2pYYp+TNYYS94kTgdPjyu9sHufMEKygIlYeS71tiRkWPH2VzduKLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjlOi8lRdt8vUh5B+SkDYW6gu37nw+PvlzrxK/KaaKI=;
 b=iQYEvcGZI0Nc1qLFaqUpxIHHJJV1B1CB83LMO6GLjIkj8XfmpMWIvd7+9axBEAUnhc3U7haQDc0Si8M6gr6ZK9R0TGuOZF5mWovtXiQZpNqCJjAhmdAOS7aEpqxRWnDe5+By8W4UJA3V/5BppVJk79OLbGOPaC7aOKzAcAeGFvTKryvPpw1l6M0uF0AtAqs9D2MhTPbuhglYnpCmek9pNk/G5LExGj2KhijuJg1P7TIZE8Pz85NBiH7FK2KyEHf10kGiSs1g9jlP062jZh3Ikmi0GOKRn3eWE1uYmsCNcp1ksIURbourZILYWW5KKXa+Udx62dKNPJ8jDzi5CC00rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjlOi8lRdt8vUh5B+SkDYW6gu37nw+PvlzrxK/KaaKI=;
 b=RM8cp+06QBblTBODFB1nERQIYjTX4m8cEfEiXbyBSRpoMpmaVJh/asTFM9wStIf+3FJiAON0JFXp3hlOcKzi2lDMfzrHeVtskMWFMwDNeJewMNst3glacSEr9fa2Nf+LESOzvndBj6H93QiNyspGMVBV2zLFIAIjNGm0PQNNCO0=
Received: from BY3PR05CA0001.namprd05.prod.outlook.com (2603:10b6:a03:254::6)
 by MW4PR12MB7430.namprd12.prod.outlook.com (2603:10b6:303:224::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 01:34:24 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::3b) by BY3PR05CA0001.outlook.office365.com
 (2603:10b6:a03:254::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Tue,
 20 Jan 2026 01:34:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 01:34:24 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 19:34:21 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 19 Jan 2026 17:34:21 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/10] drm/amdgpu/cs: return -ETIME for guilty contexts
Date: Mon, 19 Jan 2026 20:34:07 -0500
Message-ID: <20260120013411.15659-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120013411.15659-1-alexander.deucher@amd.com>
References: <20260120013411.15659-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|MW4PR12MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a7b2b77-0221-411c-8d9b-08de57c40af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hR9bGjKrIPq6u0AycA6nIXH+bBb6zmhYOym9n5iL0P+SfvD9nizlDyYW98Wc?=
 =?us-ascii?Q?Sr66Ei52DWd7L1eX/60Ycho35vmQx/37zIqoUhZ9zedBEHPITYlmfzeF1B1W?=
 =?us-ascii?Q?KT5djzMbZo/dMMR1oxuiHYfvevGEH/72c9g4vCJwzgHbNMmp2UZoNkgz0lXc?=
 =?us-ascii?Q?qnkI8WQiP6fRYS0oVcPGfrxLmhiqhPjWeCAjPnXL/al3iz+A3NsdSjT+2ux4?=
 =?us-ascii?Q?b/wdsqlPuMMFeg3iD2xmmcvvoMgdJ1Ea33UNvs9KtLCb6htIbPjb1KXr/L17?=
 =?us-ascii?Q?YJiE5JHGz1OAaFGE4Q29+JgEZgAInjPO+hQ5oYgABsG7Xlxml8UwZDVgMK+x?=
 =?us-ascii?Q?wOe0CeI1bZsS3nlb+pUIp/OyqctETTLzuRYy7r1i1dB0pp6/xYlugzA/RGSY?=
 =?us-ascii?Q?rgz5U1yi5rXlYZf8toZS49d/EAxE8RnW6Kq+XJaZck887hBgOFfw0D7YOfkC?=
 =?us-ascii?Q?4NJJGBe9gitYnEEFSkcGkQ/8xTIF2DtRkAwaT5SV+e4FzEXKba9/A0JAr5kc?=
 =?us-ascii?Q?P6L81OJ39lG+MZ5+8PxF6fD2FXWYH1eIdrAQjJnll4mPWNScqCkbB+ZjwH74?=
 =?us-ascii?Q?xwAuXRwHoCo7zKvy8vJrGjMVsHcD05Llchk+Hl318aBDIIiOCWeccFZ2Sd5z?=
 =?us-ascii?Q?LkBSnmElyWfDkdveVcwlaBm4n53S/CVXXKV8IJ8Sp6VqO55haDZxxnvqjFyH?=
 =?us-ascii?Q?FwYyUygetda34Xxl8zvDUvgglKWg6/doxac1D2A0Ts2GFT6Vveqlt5As97oJ?=
 =?us-ascii?Q?AyV5LhGg39vR34KcDTz6Wy1k1XLeh7RE14krQnlApfTjGUeTq45PIWw/T/6N?=
 =?us-ascii?Q?a3gelV8ezqyPDdHBvAk6ipEOzKHWQEdSQWyVHmNxEc+UIqbAEwf2vvQn9CFI?=
 =?us-ascii?Q?rWN7Suh1b1fHiqw4q8aetjLg3GTPp3hxVIIxBwDJ5rgMIoikTzEqarHAUkwE?=
 =?us-ascii?Q?NJjr5FOx0dPUN8r37QpPOMrrUCxnRrx4G8kraej6CNGQBrqYfSh6tzJZmoUA?=
 =?us-ascii?Q?x4r2BTzpid3zW32CF4g7htpJu3TII61e3EhiXvtLQzxF6cIfp9rVO47dUP1k?=
 =?us-ascii?Q?PLJTR1zqoqpysS6bPo0RetVI6lKiRSM+XJNMCybkFgCWL3LyKuRN5YKyTjgb?=
 =?us-ascii?Q?7Q8M/kDHSwcH8RY9O0yMnSgkAWno+3xZzmeuBOsvDYIc2Ge3fHTLKQXBRCpC?=
 =?us-ascii?Q?cejWT0Br4qWlbyW4z8I/1tlntZ4gyqAUhfJNIrcIdSe3ZNC2xykRjjKwjytU?=
 =?us-ascii?Q?htKz3xV/JxSy8VPTYDAQ3J4Vis509qX7GnslaHGRSGvoXIJsL85zUEqmViif?=
 =?us-ascii?Q?MCMBtVJZfJsSOscLlKesUlGI7/i9NGKAmwBdYxf9DZ/R/MUwkBaDpipsXagk?=
 =?us-ascii?Q?fDv7GI7NIN9ivB8i5DyPoYyPdlGcmnbXbqhLIDUJ+WUefWiGSbDiYAQpVOMt?=
 =?us-ascii?Q?fCg8fQS8anE916aVkNv4FDN1cC9xQ8ALB+DHD5bo51c0tXF8+8ap59+B0qPc?=
 =?us-ascii?Q?LY8eOGNLMU9dNyZwQUb6epG99o+85NQprZrgYtwPP/o76pYZGdy8nJejbCzT?=
 =?us-ascii?Q?y1NQGa3dAnWzgSFFuFepxkocE8LgKHkAELERb1PqwN9ynzGct1xeVr0ELSP2?=
 =?us-ascii?Q?AqECGLAssHqaHHwnfeM3LQ5WsBJzYpK3zTvuSllW6pCLzM2QaDXdcXtRLe1W?=
 =?us-ascii?Q?WpMt7w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 01:34:24.1195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7b2b77-0221-411c-8d9b-08de57c40af9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7430
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

Return -ETIME rather than -ECANCELED for guilty contexts.
Userspace only considers contexts to be guilty if they
return -ETIME.  Returning -ECANCELED means the context was
innocent.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 4d53d9cb8490d..3112a7c5be81f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -62,7 +62,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
 
 	if (atomic_read(&p->ctx->guilty)) {
 		amdgpu_ctx_put(p->ctx);
-		return -ECANCELED;
+		return -ETIME;
 	}
 
 	amdgpu_sync_create(&p->sync);
-- 
2.52.0

