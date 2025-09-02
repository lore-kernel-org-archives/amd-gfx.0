Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2108DCA0FFE
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 14:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4F5A10E77A;
	Tue,  2 Sep 2025 14:45:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YPhDGudb";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6F4910E77A
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 14:45:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sgWuZmLtQfUvvdY09J1LXSlbgXYJzVDJepncNcZJozifv1o+EGuWW2FrrLvqJrutzTOW6ykV2yKXRyhxe8Rsd6dwDmmQkiA5HGqEE124CgLAPHaeJV8INAK4JJBCR9pVfPQAFWwWEsqcMIl/o/jqPlvZ4qIwGcYWAVPL5Emo4l2QZ8JOGnl4Yr/JUlHU/rPsUOXAj6Cp1jgatNMVPXpIjZGTa0GK7XUHQVZ+3v4OM8jHOxsAyXNm//ayDPPwo1jpv0rHDFA14a/QXwXn9skG7XrF5WvefbPfDxa/bjshywtFg5YViWMe4oJtYhnrSdCgSoCVp03Fr41Lwho+UKhHTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsIKkrXnZb80UybdZOS7fDsVtYEWCa4QYS85NTxEyBI=;
 b=CzxeqoWT0+52jVuamTBrFppIllenOc9DXZTpk8JOM7hnsAevj8/IoQOMU7G/KnG3Fa5COozO7/H3s19w6JQ2D9Q6fQptYkYgOz2U/j+9aC75jIeYVxoeS5AEdUwbOQtraC5eEu+TvKMBCtyW3tRdxcvLRxit4/dZNI0At+XwhI0Dq0A6ZOlMkL9ZYbhoJ5kWsT0opIURUF54ObEEU5jvt3HGIZZraa3eiAHQt3ujKdhQx5Vo6JujGiU86ajzJdXpKB3e9r7VBUKjBy6glNbDKDHGTW3L8Wx7OtrxGG1LW+TQ0oaZuGrnrERnWj7jfMfnD6idnsxlq5HCS/CrFfBHUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsIKkrXnZb80UybdZOS7fDsVtYEWCa4QYS85NTxEyBI=;
 b=YPhDGudbWHNhZOKX8icThH16DbWtxMFYCSOZcTojNOxSzaV7weAmhGmqwWU0qtl4jVvDo7AjUkXYDX3ysXbgjAIMazF1P1G02pBrLQn3Ommc77HsvIOLEi330xI9vKlgM0f+tc7gPlE7vnIRJgGMkN8fox039NzlCYn1Qk1gd0U=
Received: from DSZP220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::7) by
 MN0PR12MB6343.namprd12.prod.outlook.com (2603:10b6:208:3c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 14:45:36 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:5:280:cafe::7b) by DSZP220CA0004.outlook.office365.com
 (2603:10b6:5:280::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Tue,
 2 Sep 2025 14:45:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9115.0 via Frontend Transport; Tue, 2 Sep 2025 14:45:35 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 09:45:34 -0500
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 2 Sep
 2025 07:45:32 -0700
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Correct info field of bad page threshold exceed
 CPER
Date: Tue, 2 Sep 2025 22:45:11 +0800
Message-ID: <20250902144511.67751-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|MN0PR12MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c91acbe-455d-41b2-a06c-08ddea2f607a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q+uX/T9NpBzMXikjEjVurdveqRRZBpzSa0+impnA3/kZPUM/9C5b8Us54G99?=
 =?us-ascii?Q?Omsb6xv24/VpqLj2ZsD/ev2BPzXu3s833pEovCaY6R8eh8zPwAo01L8FHLCZ?=
 =?us-ascii?Q?mRWsS3Uv/aO5fsPTNxhpP9j+ts1klLP+LwgemI9FGuRDFykskCaAoWyTGBcM?=
 =?us-ascii?Q?eDl1kjmBDOX2PLxZgNcBBP9VHa4xfEJgOHZtvea/8qPWRPRFjJQE+SPXbRTo?=
 =?us-ascii?Q?0DslCWDPhnmzyrm0ti9vMvhiTBkxyq7b6gOd0WBgQ27DNo4ydTxDYlqzULOB?=
 =?us-ascii?Q?e8ksf6RmbP7yyovI5quxjCAagt3RLLwPoV5MroF8BSWegGfWM3a3F9OB6v0t?=
 =?us-ascii?Q?hDKNET1EuRwgug6QR/od111up1i2/8KMk8u1+3drIe0ZeklrzCiXZQvuTPyF?=
 =?us-ascii?Q?kWdQJ/vXLSXH+0MLPXGH5ABzM1/51Wo1rYzNDHNwLRBJLzi0A+/f4C1E0x1U?=
 =?us-ascii?Q?OLxdDPPQ8fgzSqnagI6w5Rt/5clnicWF1FTDEqP76TuPtKHKjbQ6Lrd5WvR6?=
 =?us-ascii?Q?f/fMaWNfgUJfcCBql/zOU8/xVx4ybEgNc5pYWapOi5NP/vqIAp+TLiSm0vUT?=
 =?us-ascii?Q?+L5lv58fdE55NVVwK2im/nyYPEJPalQ7RbyQIu0kInOVcJn8Q0wwF6PuVZMM?=
 =?us-ascii?Q?aGI3sXDC1d+Q3ao8G0X83TFk+e4zB8BbVxgIJlP/vZ750j56IsPLLYA6qPj+?=
 =?us-ascii?Q?dk5pjCWLLeYpKIu1SI7CghiFzXcVUbKkpm8Nxjpv/fxPF/G9XIVutbhrf97M?=
 =?us-ascii?Q?K7xObo+yG/PB3w6taPj+3e6DqZt5OPjuZh6PEcI5nKvwPkxvhqOU6KqeGBje?=
 =?us-ascii?Q?6kymBPdbl8q/fqU5QeX/S2D2QXxS/gc+f582TMuFh9ixjSj774vtZ4IWg5Gv?=
 =?us-ascii?Q?10LpS88Fn19SCyeqh4+zI0AMnjOdKKP+Bjg2yRKYpnM8rLSzP4lR7dEQYmWq?=
 =?us-ascii?Q?ebquwiCHrRV1vCjQS0AtqTGSj8U8HxrMR8y6U21GJc2XP4HgKPaQyX7EC4GA?=
 =?us-ascii?Q?rmWz+3efsgyQcYMtiV0zDViG33LwvO1QKRI/dLT/K6hDQOXinz5NXOZ9+TiL?=
 =?us-ascii?Q?5qS9N7p8Twq+8PYoJLUclulK74Q+RKgiK7HidH8n4Zlz00VW757b1JA3KfDl?=
 =?us-ascii?Q?eNZubW75drA2BWY5bubOTotm43hwi+zcshncXbx4UrNwTGYoBKKlTEuN6xkW?=
 =?us-ascii?Q?ByI9Iax+8xUYZYnxuFAAGOyCiAohNYHe7wZgp/8Ev3o1ZdVi6N+wCqJM7OnV?=
 =?us-ascii?Q?1oWfBbfyBUdVkt2lEvHBqQgMucXk6RfiVStrgYALH0UEJDIOmxvL1YoNfRF7?=
 =?us-ascii?Q?Jpv7GmnI0muo4JnjICrqnJUSvoEIZhFWBq+ThmRd8TLYBL4dMiqXI+p5y1rL?=
 =?us-ascii?Q?mHnxyS8rdLttluWP5iQdO2meIlCVcu2Ba4cy+UCX8XZXiwwt7jVllGSfznOI?=
 =?us-ascii?Q?6bKtHt90sPg6MyMFWWmuN4h8rJeNYnY4fKyJdil5hV72e99WVr6LVNvy+XS6?=
 =?us-ascii?Q?IqWxOlYa/eGSVqyF3RRjIKzIKwS7QlZPSiWm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 14:45:35.8883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c91acbe-455d-41b2-a06c-08ddea2f607a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6343
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

Correct valid_bits and ms_chk_bits of section info field for bad page
threshold exceed CPER to match OOB's behavior.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index 15dde1f50328..287a54086620 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -68,7 +68,6 @@ void amdgpu_cper_entry_fill_hdr(struct amdgpu_device *adev,
 	hdr->error_severity		= sev;
 
 	hdr->valid_bits.platform_id	= 1;
-	hdr->valid_bits.partition_id	= 1;
 	hdr->valid_bits.timestamp	= 1;
 
 	amdgpu_cper_get_timestamp(&hdr->timestamp);
@@ -219,7 +218,10 @@ int amdgpu_cper_entry_fill_bad_page_threshold_section(struct amdgpu_device *adev
 	section->hdr.valid_bits.err_context_cnt = 1;
 
 	section->info.error_type = RUNTIME;
+	section->info.valid_bits.ms_chk = 1;
 	section->info.ms_chk_bits.err_type_valid = 1;
+	section->info.ms_chk_bits.err_type = 1;
+	section->info.ms_chk_bits.pcc = 1;
 	section->ctx.reg_ctx_type = CPER_CTX_TYPE_CRASH;
 	section->ctx.reg_arr_size = sizeof(section->ctx.reg_dump);
 
-- 
2.34.1

