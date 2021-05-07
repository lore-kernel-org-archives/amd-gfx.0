Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E361C433B4
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 03:43:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EDE5613DA
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 03:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EDE5613DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E67416E185;
	Fri,  7 May 2021 03:43:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9741C6E185
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 03:43:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvPAIkMSaxBOZFiyzGmJg+6Yy51Upcs5qeR8bF3ec6uxgXxZA554LfifvxmVEMpjl+FOb8ArvqhQWqe6/iTKYAfF+5aeFEqCQKuW4nKg4vIzAmdEuIfKCmYvdXyOh1xPFJhNJ6SNV7jffmL/TpdPVkaZrhPNz8ZEViJPRYc1mx7CL4RDu9PnpnDeBmwRJwqK/p5t44VjBEBcMzsOPhMToZk3M3tCqyKEtg/yL9yk7b81jHgywDvtcToYHmaWvOnYfDdVWTplzeAwuMqfkVMVi+OSHhZ55/sr7WEHJkLJkLo3k3Y+rUh0p0haj6ALvPwPrmr+zWII6mthPtBrtJ5vRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/furzHkgYkt6CCPZh6w7Ex+DIW4iB3Ne1FOR/ADgS8=;
 b=CWUnWPjhMdIOJTRjQIaTukhhjP/BiYsYdK8QsoQbMBzHT5MW+LZAAKMfGwN4mfHtRxlyOjOhyXJhpzcJaV7eyq23Bk0M2UY6KVf29IkteU8HGY7UvC7d76qzO2m3aLS4IbF4jL08VSUUb4t3rSKOsKJ2iJoIKO4Q4+EEtqJUQmHLspM3822Nxrh8C6yeu2inKnioK8EqlulFIPC3SAva0DJmeIxHpJPn6QZfalSFCpB5pdExmtFB5GWtcnSbT0WeKiFi9GUYwp1ZjeHFrDHpwZuXQUcmYZM+BGZXnuKVt3UP5c35oZqRqyStGLGpazCYdrpG6NGNbHMOefyruCWEmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/furzHkgYkt6CCPZh6w7Ex+DIW4iB3Ne1FOR/ADgS8=;
 b=MAE9bgmjn4/eZOLOIDIh9q095GcVOlwT2HnLt5KG1hMbJrqBUfuVwfBlEWB41sW0Nfq1uAlwW9HikY70ezTK+6TJ4zNTv2TXjkw2pmyegivmd8SlzpEFleHaFiLGP3ueQaA8TAnuBVf964cxKjqE+9AfxKqYgi+t0pCdHUoLbfc=
Received: from BN9PR03CA0264.namprd03.prod.outlook.com (2603:10b6:408:ff::29)
 by MW3PR12MB4473.namprd12.prod.outlook.com (2603:10b6:303:56::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 7 May
 2021 03:42:59 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::49) by BN9PR03CA0264.outlook.office365.com
 (2603:10b6:408:ff::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend
 Transport; Fri, 7 May 2021 03:42:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 03:42:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 6 May 2021
 22:42:56 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 6 May 2021
 22:42:55 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Thu, 6 May 2021 22:42:54 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: update the shader to clear specific SGPRs
Date: Fri, 7 May 2021 11:42:45 +0800
Message-ID: <20210507034245.22543-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9cfdb22-2623-4052-6d10-08d9110a3537
X-MS-TrafficTypeDiagnostic: MW3PR12MB4473:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4473C9A8F83125FC6ABA4568ED579@MW3PR12MB4473.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hnGn/DcSWBqoXuVbQYoqLHNJdeCcP5OKjm8n2yQN/3UDonYCgv8Hxdtt8eVKCN/LoUmUKucSEQy6X929iFrH5uZnATJJ9O5W8/ksCpbLx44erCu7Ca5pXRZ0rBhp+iW9zNK9mVfoRq5lVdg6POnTel3HldHtv49omAR4lRo5IR5cZ2Xiec8AFtNj8igZE1pC1pG6LvVnWSz36uLNIR8z/rsqR7lkJTUTTxhsgp0yDAtjdl1XmZ2He0OEVYjKJE1Hf1NJ3hpT8n0FI/2ExFIdpAIKB/73/Ha1b9K6IDxPXk7uJnFWuWVqXLfpGwHqNz3SvQ219T+zZxEpu7VtE+n/WlzLRNhextCsyiAtimxV88L2NzSZmwOtnSCSm98HEZ7RrF81pJ69z7+4v6MX8xCejVPYXICvHh3XAfeIkFkQ4T9OiKSE43eN6ATdMqAsBQGXUXrxwIXbGSCioDFwNI/v3XueH+mxvnnieny21E+uSzpf7WNg9j3lpOqrGoAeTkIcvdYn5FYUQ0npmO0Om9qQ979w5OB/5DU4uG0AqRxLEA0eARuz1N5Hd0/mzJ8z94ABdAxJCCxlzM+IWfYEp4G731Lmmkm/g9cn2wgw51cYLf80Ntha5+Bf3HBqXCeO62SFfheOtlRc596EGmNo8PvlCNfoUWEB7TouVDvk93euow3hhuC+UgCZYeX6UPq/rmRoGGtB8CLD4NUN07ZwJeY9wVuwcSXLoQTbaMYktcsSr/g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966006)(36840700001)(7696005)(5660300002)(110136005)(47076005)(6666004)(70206006)(2906002)(36756003)(356005)(478600001)(82740400003)(81166007)(316002)(186003)(86362001)(1076003)(36860700001)(8676002)(82310400003)(8936002)(26005)(4326008)(2616005)(70586007)(6636002)(336012)(426003)(17423001)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 03:42:58.9366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9cfdb22-2623-4052-6d10-08d9110a3537
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4473
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add shader codes to explicitly clear specific SGPRs, such as
flat_scratch_lo, flat_scratch_hi and so on. And also correct the
allocation size of SGPRs in PGM_RSRC1.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 025b1e42e31b..8ad6717e67d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -220,23 +220,24 @@ static const u32 sgpr112_init_compute_shader_aldebaran[] = {
 	0x9209a805, 0x920a8a04, 0x81080908, 0x81080a08, 0x81080308, 0x8e078208,
 	0x81078407, 0xc0410080, 0x00000007, 0xbf8c0000, 0xbf8e003f, 0xc0030200,
 	0x00000000, 0xbf8c0000, 0xbf06ff08, 0xdeadbeaf, 0xbf84fff9, 0x81028102,
-	0xc0410080, 0x00000007, 0xbf8c0000, 0xbefc0080, 0xbe880080, 0xbe890080,
-	0xbe8a0080, 0xbe8b0080, 0xbe8c0080, 0xbe8d0080, 0xbe8e0080, 0xbe8f0080,
-	0xbe900080, 0xbe910080, 0xbe920080, 0xbe930080, 0xbe940080, 0xbe950080,
-	0xbe960080, 0xbe970080, 0xbe980080, 0xbe990080, 0xbe9a0080, 0xbe9b0080,
-	0xbe9c0080, 0xbe9d0080, 0xbe9e0080, 0xbe9f0080, 0xbea00080, 0xbea10080,
-	0xbea20080, 0xbea30080, 0xbea40080, 0xbea50080, 0xbea60080, 0xbea70080,
-	0xbea80080, 0xbea90080, 0xbeaa0080, 0xbeab0080, 0xbeac0080, 0xbead0080,
-	0xbeae0080, 0xbeaf0080, 0xbeb00080, 0xbeb10080, 0xbeb20080, 0xbeb30080,
-	0xbeb40080, 0xbeb50080, 0xbeb60080, 0xbeb70080, 0xbeb80080, 0xbeb90080,
-	0xbeba0080, 0xbebb0080, 0xbebc0080, 0xbebd0080, 0xbebe0080, 0xbebf0080,
-	0xbec00080, 0xbec10080, 0xbec20080, 0xbec30080, 0xbec40080, 0xbec50080,
-	0xbec60080, 0xbec70080, 0xbec80080, 0xbec90080, 0xbeca0080, 0xbecb0080,
-	0xbecc0080, 0xbecd0080, 0xbece0080, 0xbecf0080, 0xbed00080, 0xbed10080,
-	0xbed20080, 0xbed30080, 0xbed40080, 0xbed50080, 0xbed60080, 0xbed70080,
-	0xbed80080, 0xbed90080, 0xbeda0080, 0xbedb0080, 0xbedc0080, 0xbedd0080,
-	0xbede0080, 0xbedf0080, 0xbee00080, 0xbee10080, 0xbee20080, 0xbee30080,
-	0xbee40080, 0xbee50080, 0xbf810000
+	0xc0410080, 0x00000007, 0xbf8c0000, 0xbefc0080, 0xbeea0080, 0xbeeb0080,
+	0xbf00f280, 0xbee60080, 0xbee70080, 0xbee80080, 0xbee90080, 0xbefe0080,
+	0xbeff0080, 0xbe880080, 0xbe890080, 0xbe8a0080, 0xbe8b0080, 0xbe8c0080,
+	0xbe8d0080, 0xbe8e0080, 0xbe8f0080, 0xbe900080, 0xbe910080, 0xbe920080,
+	0xbe930080, 0xbe940080, 0xbe950080, 0xbe960080, 0xbe970080, 0xbe980080,
+	0xbe990080, 0xbe9a0080, 0xbe9b0080, 0xbe9c0080, 0xbe9d0080, 0xbe9e0080,
+	0xbe9f0080, 0xbea00080, 0xbea10080, 0xbea20080, 0xbea30080, 0xbea40080,
+	0xbea50080, 0xbea60080, 0xbea70080, 0xbea80080, 0xbea90080, 0xbeaa0080,
+	0xbeab0080, 0xbeac0080, 0xbead0080, 0xbeae0080, 0xbeaf0080, 0xbeb00080,
+	0xbeb10080, 0xbeb20080, 0xbeb30080, 0xbeb40080, 0xbeb50080, 0xbeb60080,
+	0xbeb70080, 0xbeb80080, 0xbeb90080, 0xbeba0080, 0xbebb0080, 0xbebc0080,
+	0xbebd0080, 0xbebe0080, 0xbebf0080, 0xbec00080, 0xbec10080, 0xbec20080,
+	0xbec30080, 0xbec40080, 0xbec50080, 0xbec60080, 0xbec70080, 0xbec80080,
+	0xbec90080, 0xbeca0080, 0xbecb0080, 0xbecc0080, 0xbecd0080, 0xbece0080,
+	0xbecf0080, 0xbed00080, 0xbed10080, 0xbed20080, 0xbed30080, 0xbed40080,
+	0xbed50080, 0xbed60080, 0xbed70080, 0xbed80080, 0xbed90080, 0xbeda0080,
+	0xbedb0080, 0xbedc0080, 0xbedd0080, 0xbede0080, 0xbedf0080, 0xbee00080,
+	0xbee10080, 0xbee20080, 0xbee30080, 0xbee40080, 0xbee50080, 0xbf810000,
 };
 
 const struct soc15_reg_entry sgpr112_init_regs_aldebaran[] = {
@@ -244,7 +245,7 @@ const struct soc15_reg_entry sgpr112_init_regs_aldebaran[] = {
 	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_X), 0x40 },
 	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Y), 8 },
 	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Z), 1 },
-	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0x2c0 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0x340 },
 	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0x6 },
 	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0x0 },
 	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0xffffffff },
@@ -262,21 +263,22 @@ static const u32 sgpr96_init_compute_shader_aldebaran[] = {
 	0x9209a805, 0x920a8a04, 0x81080908, 0x81080a08, 0x81080308, 0x8e078208,
 	0x81078407, 0xc0410080, 0x00000007, 0xbf8c0000, 0xbf8e003f, 0xc0030200,
 	0x00000000, 0xbf8c0000, 0xbf06ff08, 0xdeadbeaf, 0xbf84fff9, 0x81028102,
-	0xc0410080, 0x00000007, 0xbf8c0000, 0xbefc0080, 0xbe880080, 0xbe890080,
-	0xbe8a0080, 0xbe8b0080, 0xbe8c0080, 0xbe8d0080, 0xbe8e0080, 0xbe8f0080,
-	0xbe900080, 0xbe910080, 0xbe920080, 0xbe930080, 0xbe940080, 0xbe950080,
-	0xbe960080, 0xbe970080, 0xbe980080, 0xbe990080, 0xbe9a0080, 0xbe9b0080,
-	0xbe9c0080, 0xbe9d0080, 0xbe9e0080, 0xbe9f0080, 0xbea00080, 0xbea10080,
-	0xbea20080, 0xbea30080, 0xbea40080, 0xbea50080, 0xbea60080, 0xbea70080,
-	0xbea80080, 0xbea90080, 0xbeaa0080, 0xbeab0080, 0xbeac0080, 0xbead0080,
-	0xbeae0080, 0xbeaf0080, 0xbeb00080, 0xbeb10080, 0xbeb20080, 0xbeb30080,
-	0xbeb40080, 0xbeb50080, 0xbeb60080, 0xbeb70080, 0xbeb80080, 0xbeb90080,
-	0xbeba0080, 0xbebb0080, 0xbebc0080, 0xbebd0080, 0xbebe0080, 0xbebf0080,
-	0xbec00080, 0xbec10080, 0xbec20080, 0xbec30080, 0xbec40080, 0xbec50080,
-	0xbec60080, 0xbec70080, 0xbec80080, 0xbec90080, 0xbeca0080, 0xbecb0080,
-	0xbecc0080, 0xbecd0080, 0xbece0080, 0xbecf0080, 0xbed00080, 0xbed10080,
-	0xbed20080, 0xbed30080, 0xbed40080, 0xbed50080, 0xbed60080, 0xbed70080,
-	0xbed80080, 0xbed90080, 0xbf810000,
+	0xc0410080, 0x00000007, 0xbf8c0000, 0xbefc0080, 0xbeea0080, 0xbeeb0080,
+	0xbf00f280, 0xbee60080, 0xbee70080, 0xbee80080, 0xbee90080, 0xbefe0080,
+	0xbeff0080, 0xbe880080, 0xbe890080, 0xbe8a0080, 0xbe8b0080, 0xbe8c0080,
+	0xbe8d0080, 0xbe8e0080, 0xbe8f0080, 0xbe900080, 0xbe910080, 0xbe920080,
+	0xbe930080, 0xbe940080, 0xbe950080, 0xbe960080, 0xbe970080, 0xbe980080,
+	0xbe990080, 0xbe9a0080, 0xbe9b0080, 0xbe9c0080, 0xbe9d0080, 0xbe9e0080,
+	0xbe9f0080, 0xbea00080, 0xbea10080, 0xbea20080, 0xbea30080, 0xbea40080,
+	0xbea50080, 0xbea60080, 0xbea70080, 0xbea80080, 0xbea90080, 0xbeaa0080,
+	0xbeab0080, 0xbeac0080, 0xbead0080, 0xbeae0080, 0xbeaf0080, 0xbeb00080,
+	0xbeb10080, 0xbeb20080, 0xbeb30080, 0xbeb40080, 0xbeb50080, 0xbeb60080,
+	0xbeb70080, 0xbeb80080, 0xbeb90080, 0xbeba0080, 0xbebb0080, 0xbebc0080,
+	0xbebd0080, 0xbebe0080, 0xbebf0080, 0xbec00080, 0xbec10080, 0xbec20080,
+	0xbec30080, 0xbec40080, 0xbec50080, 0xbec60080, 0xbec70080, 0xbec80080,
+	0xbec90080, 0xbeca0080, 0xbecb0080, 0xbecc0080, 0xbecd0080, 0xbece0080,
+	0xbecf0080, 0xbed00080, 0xbed10080, 0xbed20080, 0xbed30080, 0xbed40080,
+	0xbed50080, 0xbed60080, 0xbed70080, 0xbed80080, 0xbed90080, 0xbf810000,
 };
 
 const struct soc15_reg_entry sgpr96_init_regs_aldebaran[] = {
@@ -284,7 +286,7 @@ const struct soc15_reg_entry sgpr96_init_regs_aldebaran[] = {
 	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_X), 0x40 },
 	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Y), 0xc },
 	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Z), 1 },
-	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0x240 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0x2c0 },
 	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0x6 },
 	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0x0 },
 	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0xffffffff },
@@ -305,16 +307,17 @@ const struct soc15_reg_entry sgpr96_init_regs_aldebaran[] = {
 static const u32 sgpr64_init_compute_shader_aldebaran[] = {
 	0xb8840904, 0xb8851a04, 0xb8861344, 0xb8831804, 0x9208ff06, 0x00000280,
 	0x9209a805, 0x920a8a04, 0x81080908, 0x81080a08, 0x81080308, 0x8e078208,
-	0x81078407, 0xc0410080, 0x00000007, 0xbf8c0000, 0xbefc0080, 0xbe880080,
-	0xbe890080, 0xbe8a0080, 0xbe8b0080, 0xbe8c0080, 0xbe8d0080, 0xbe8e0080,
-	0xbe8f0080, 0xbe900080, 0xbe910080, 0xbe920080, 0xbe930080, 0xbe940080,
-	0xbe950080, 0xbe960080, 0xbe970080, 0xbe980080, 0xbe990080, 0xbe9a0080,
-	0xbe9b0080, 0xbe9c0080, 0xbe9d0080, 0xbe9e0080, 0xbe9f0080, 0xbea00080,
-	0xbea10080, 0xbea20080, 0xbea30080, 0xbea40080, 0xbea50080, 0xbea60080,
-	0xbea70080, 0xbea80080, 0xbea90080, 0xbeaa0080, 0xbeab0080, 0xbeac0080,
-	0xbead0080, 0xbeae0080, 0xbeaf0080, 0xbeb00080, 0xbeb10080, 0xbeb20080,
-	0xbeb30080, 0xbeb40080, 0xbeb50080, 0xbeb60080, 0xbeb70080, 0xbeb80080,
-	0xbeb90080, 0xbf810000,
+	0x81078407, 0xc0410080, 0x00000007, 0xbf8c0000, 0xbefc0080, 0xbeea0080,
+	0xbeeb0080, 0xbf00f280, 0xbee60080, 0xbee70080, 0xbee80080, 0xbee90080,
+	0xbefe0080, 0xbeff0080, 0xbe880080, 0xbe890080, 0xbe8a0080, 0xbe8b0080,
+	0xbe8c0080, 0xbe8d0080, 0xbe8e0080, 0xbe8f0080, 0xbe900080, 0xbe910080,
+	0xbe920080, 0xbe930080, 0xbe940080, 0xbe950080, 0xbe960080, 0xbe970080,
+	0xbe980080, 0xbe990080, 0xbe9a0080, 0xbe9b0080, 0xbe9c0080, 0xbe9d0080,
+	0xbe9e0080, 0xbe9f0080, 0xbea00080, 0xbea10080, 0xbea20080, 0xbea30080,
+	0xbea40080, 0xbea50080, 0xbea60080, 0xbea70080, 0xbea80080, 0xbea90080,
+	0xbeaa0080, 0xbeab0080, 0xbeac0080, 0xbead0080, 0xbeae0080, 0xbeaf0080,
+	0xbeb00080, 0xbeb10080, 0xbeb20080, 0xbeb30080, 0xbeb40080, 0xbeb50080,
+	0xbeb60080, 0xbeb70080, 0xbeb80080, 0xbeb90080, 0xbf810000,
 };
 
 const struct soc15_reg_entry sgpr64_init_regs_aldebaran[] = {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
