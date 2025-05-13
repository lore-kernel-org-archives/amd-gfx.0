Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DFFC3ABD9
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 19:22:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38F2510E5DD;
	Tue, 13 May 2025 19:22:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HRvcF8YQ";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C523510E1AE
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 19:22:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1S3qfXmp+8wnqAvKRkY+lgggYSGHlY4FUk248jY9VFylIU+0TEVI5at3Yf56K5mhT/H+G+jYjtTHvvOUeNkpcZmpyXXvImWRflJhQSoZbY0UoDGyx4SgWn9U0ktAUx82TF3EsPvxQPEbUs+wIOcLbrrb/xJSmcSkM0ugtNiMKEVQ/8hBpZzH7GJ2A5WlG2Yr5Jq/RfhFHWIBnlfZc+OUThZY2rDXl9vVaxJClJ9ajm6c8tWcpR+hum3jxcifRinW/nzxCp39edqbmWnYRxxOGWuopbB7mf4D7FLyi4uP9HiLdjibsJsnAZfX0R7alJ8tTbuHAXklvkovwYUnDMOjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uqa53l4JnpLsKQOXbAUK0klJn/rKCjj/9FJbfvfpXDk=;
 b=m4kX+lbhjBup4A7cqkCqjZBnfxrVkrpbkiEqaMlbsEHHrawPiV2hobDJDKTWAE7Nj74q+2rcIqIhMIE+JiHG95eCol6jiVKd9BSQqb+KABGbtX5nA/I67rqcyCywzX67dKNYIQHhb7ghR2nlTIB5g8HIA4tiND3AanNkRPGXL/g5fNo7+KEGlJbOjA+dF3tmKV/bickYHl7eNJYyOfDtReB4KMqumyaU2tOSygpGXuJ/seJMM2bHZARCZyMgm5vyrrP+ZL60KmJ63unk/0osVPJLR8WkZoiNzmMVfRJbJ+a6RXt9MqTFiEeEhgYtE+RYpk5aXiKW2Pu+jmF1WK3UMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uqa53l4JnpLsKQOXbAUK0klJn/rKCjj/9FJbfvfpXDk=;
 b=HRvcF8YQOL6G/0pKTiEtONkNKExM+S9aFbNmNOuI5nx8yva73Hm+YSj+17/1W963Eat83SlrOmOo6nAl2oRWCJawLtC7fDtRjZlSjM7HwtPidjxMCcQpJUWVIV5Y32l+sGNkz9IdzksOUXX4WIR3fB4A8Oi9wRNasakp0jxKcrs=
Received: from BN9PR03CA0579.namprd03.prod.outlook.com (2603:10b6:408:10d::14)
 by DM4PR12MB7695.namprd12.prod.outlook.com (2603:10b6:8:101::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 13 May
 2025 19:22:02 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:408:10d:cafe::a8) by BN9PR03CA0579.outlook.office365.com
 (2603:10b6:408:10d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Tue,
 13 May 2025 19:22:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 19:22:02 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 May 2025 14:22:00 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
 <ruijing.dong@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 2/3] drm/amdgpu: read back register after written for VCN
 v4.0.0
Date: Tue, 13 May 2025 15:21:47 -0400
Message-ID: <20250513192148.646359-2-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513192148.646359-1-David.Wu3@amd.com>
References: <20250513192148.646359-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|DM4PR12MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f8a65dd-5d7a-4557-fe30-08dd92537077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VAxp+aB8mL4fhiohqu6+sHjm0HQvz4YXzi1pix78TWbapl62m1cCh9fW4E9Q?=
 =?us-ascii?Q?qq7D+xebMsne9ETGPx60l1/T2pavj1A78rFtGxr/YaQ+YdyPu9HAghKDiaDF?=
 =?us-ascii?Q?+NCk/Vl6wzL4uEuazGQZKGJUj+5weFynEU+UfviLWAkoi+aNrpTRRCUnLaBX?=
 =?us-ascii?Q?H3V5qCZbP5VIEtPXktl4JLCT3uDkWe1ed9ZbLoFQOMTNgIXaBdh6VVVKWNep?=
 =?us-ascii?Q?iGtxue20hxkpNz3r5IozJnKNPDdbhtCNNu+vPzftNpdv8LI125f7N14PDFtb?=
 =?us-ascii?Q?J7Jo69ajsn76+SpRP4RB1VbALpE1fBgUzZGKrM8KUtPv768fF4dMeCNPbZdn?=
 =?us-ascii?Q?nfxRNQW9JjyOtQC5mKWht3x9JswC7N2uk8zHFui5B0r1855r/FSaeDhLuwpW?=
 =?us-ascii?Q?vEFJBhxXDkaxXaZv7O2/eBpWu16XhRX+PrO6+qo3fJGMBdiE5LrR8Pll8daL?=
 =?us-ascii?Q?pyNx0LeHW6I3+hJXsf8PEkuvV70gdHYHxSuz7FvMbk9C/AaL3qepduKpm2e4?=
 =?us-ascii?Q?AIJL99US4pVPngRkfq0fPOC7E3Y8PLzxSbauWjQIwBuvgcLpR/A+HUSVBo0l?=
 =?us-ascii?Q?2wg7UrImlPWcwkHx03SNrkeaFZKESsVaQvd1dtqUu0EL92iVhomN5RYPKdgZ?=
 =?us-ascii?Q?dJ9zy2HchnrNbLBiieHtT27X5bYq0a/fEv5VPyuR6Ah8qJRXdTFeBYJfOEhg?=
 =?us-ascii?Q?/huHeaB0xAJPWSBvDzKjQbrYGYmCdThSkWaEAGD/mX9cesgmHFAp+urSOJZc?=
 =?us-ascii?Q?iOeR6uzCx51Z8GS7pJfC4Hgkauv2eZOaF5OmecLmJu691XYjkQrA4Cr6L2mX?=
 =?us-ascii?Q?vCVoOt22TBLW1hHccE7Ab7foG/fFmbP+LYA3zS8z0sAuMuROUTi6w7XRELG/?=
 =?us-ascii?Q?+fnnH6Xk4Fg+J1SXU+rXpjev/tEuEm7TLBcTZZFwbVQUKJlueeirrYVV2KzD?=
 =?us-ascii?Q?Z1K7SAEKjZidEQ5prw7wgoHN2THMQpiGIObULknYOtmQwN6Vsn4uF5Np+9dQ?=
 =?us-ascii?Q?28DFEf5jezp7jk/MVGugp64aIDeAAzaxzo/XAkteBJYG4QKJdRGQsPwwVd08?=
 =?us-ascii?Q?26aKKRHlISBjrxqJtl4f2X0dcJ+k4fkyVm9XTTbtmMdHtcCifyIuDMHl8j7a?=
 =?us-ascii?Q?JOlN1kkgwsu1D1rY404+TvbydI2cQyt/+tpTzO6/zexr5FTyyVp0U2X71riu?=
 =?us-ascii?Q?2b2e/lLzQwPTTzi1usHjZcPC5Tpj2sV+JJme/1+m8KIBVUvndIDtuvmayUP4?=
 =?us-ascii?Q?TGVna9muLsw/55MgR8Ve/VEF9cTx2oU80UORK/nQ/qA2j44lGS53N/8JJTV6?=
 =?us-ascii?Q?esX7gM9EbeHcmmawofD30biwKJWl1Qmp6GGgqtbeoIE66UWEe/PkTlJXTw28?=
 =?us-ascii?Q?FSHflN+uLR4yzTtXorcliwTaWX93vF68heQf+i0mg8IdGtumF9KZVRv9TmAp?=
 =?us-ascii?Q?lY6260uM+W2p9oyTax+pKzZjE3UxrNbMNu+Zi7rtJnwhjlBiBFdkB1FJc6aC?=
 =?us-ascii?Q?rIjZdZWZAdECoOHcHrJqPnvnrdotFN6bRcyP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 19:22:02.2689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8a65dd-5d7a-4557-fe30-08dd92537077
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7695
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

V3: patch for VCN v4.0.0 only

Similar to the previous changes made for VCN v4.0.5, the addition of
register read-back support in VCN v4.0.0 is intended to prevent potential
race conditions, even though such issues have not been observed yet.
This change ensures consistency across different VCN variants and helps
avoid similar issues on newer or closely related GPUs. The overhead
introduced by this read-back is negligible.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 8fff470bce87..070a2a8cdf6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1122,6 +1122,10 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 			ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
 			VCN_RB1_DB_CTRL__EN_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done, otherwise
+	 * it may introduce race conditions */
+	RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
+
 	return 0;
 }
 
-- 
2.34.1

