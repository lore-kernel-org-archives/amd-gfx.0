Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0DED591CC
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 06:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 014C310E5D1;
	Tue, 19 Nov 2024 06:36:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XwjW1zun";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 323FA10E5D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 06:36:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKXGLnk0Y+4fvVc94TFAUmujW7EUpmbEOkjvPXrfLAeNoPlwSyG6y81eJzOyMD7dDs6Kt+XzCh04gkpqU7CG1B6Jmd7oA73ZMXXwYz4CMfaHAdsSCTsxHvH20tJUUWsuTWuwrcpNcMYrv38isF9ehezqQZWQUTHDjMBmchrB2uPwNQ40LqV43FmlaTqnFaQGdZH7h1HbT0c8llAxYvukksQWe8u+ft3WEcPWNbyA4V6K6phRbUflGoyhk3Xa1Od0RztdaoAwwx22XOJ2C93PCX1DCv0gnRCi4vm+08/5i4s6vN2LeCo5/7NIQW+TPRWdpTfx2FPxUz82uxZNHkC7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTuKSxlfjBLF8SC77QXO1XhFvaKyWudRouNtLmFsioE=;
 b=FdebdOP85Jw2611pJxJW6RV010ZRiXq9auTTMndBaRSI2HMrYi9QMNYvfMU2568d5O6rTlZTao2CKBDB4Oi4dalcMYtWAePqwR2tBruW0+1cQBGa+jaYL9xQrCfPK509SJJ2/EAkumcIDISVl67KY2HxC3T5qfhkkiwnRKG1WDsrubsJZda4a0/7HkXEJ8CAyEqSAMKXmeEup8VcCmmSZlE206sHxRIFBbchfhI95I3VgSIKH1zup8NcKm00gB4vS2DPvp98HxURxf8YEpNb5bURq3VHGlAqQ/+H6FCIAbpHSliMnmypKueZhmWHDKMosym+Fo0xFL3+MVmovus0FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTuKSxlfjBLF8SC77QXO1XhFvaKyWudRouNtLmFsioE=;
 b=XwjW1zun6WFExJkvqJbCKc9ShUPl3ES/TrqP5mOI+zN1fFteQ9tPkmYxWByj/wDFv5EzNnaE3GCXsv1u47bRQVpN4lB1REiuwQSNxFkqC9Oh2zeCVNsHJnR+b/jueqgIQ/CgvpVeRcR3YLNlZaqx7d8pm0KL3+bQ01DbhEHpgDE=
Received: from MW4PR03CA0041.namprd03.prod.outlook.com (2603:10b6:303:8e::16)
 by MN0PR12MB5932.namprd12.prod.outlook.com (2603:10b6:208:37f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 06:36:43 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::f0) by MW4PR03CA0041.outlook.office365.com
 (2603:10b6:303:8e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Tue, 19 Nov 2024 06:36:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 06:36:42 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 00:36:41 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 16/21] drm/amdgpu: add interface to get die id from memory
 address
Date: Tue, 19 Nov 2024 14:35:59 +0800
Message-ID: <20241119063604.81461-16-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119063604.81461-1-tao.zhou1@amd.com>
References: <20241119063604.81461-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|MN0PR12MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ffceac1-451f-49f0-5d0a-08dd08648828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nxNlShc5N7p+z+WnfNAOJvxIr2eBQyl5rKC9FaW+if+vZQP3xW4jmY//5XHt?=
 =?us-ascii?Q?8JvkpKF0R5vMsFRKtwmOZkWpWqPDNuXbty1Ii7pYNq8SRmP5OSDGZY6C+PAA?=
 =?us-ascii?Q?ZmoO6RRyvf7aCHsg9hw4O33UkeQjSjUCBJfHp4nRYF/oHu7t9YjR0ScgqQt7?=
 =?us-ascii?Q?YtnWxqYk4nk5XvG565s2eZCgaHRpLeSfY8F7hiOd+YiVYJ1IRhFzUiY2QbDx?=
 =?us-ascii?Q?WH3fei2p1i1vVFD66uLLtNfdAhKRzg0qTEyT94xiMjG0ns8r4tMkuHJf6VSp?=
 =?us-ascii?Q?3g7yiJ8Sj03VbT2+JKXfoUpMOQDpcP9t/O6bybyLX9Bl6YCAwBg79CfCKmzJ?=
 =?us-ascii?Q?3OQaVvUTl3rZ2gitZl/wNdXSJIeQq4yCbxEdD/+1URovH6TYxjgGkjlbjdbb?=
 =?us-ascii?Q?OOEMwGJRR6qShBlJIe58QlUZDYiPzPKNp15VRsmr3KX836tQZB/p/wMBabVb?=
 =?us-ascii?Q?M30rF+xDSzgvq1l673SE4gPP0dBb5GZjRcM91bG7d4bj+GD5LZ65UseyRnfM?=
 =?us-ascii?Q?mS6ApAC25EEwxO/Ui0YWqJbYIfH9SVVOMmgJtlthslRU/QfSRdJcsIAHo9AD?=
 =?us-ascii?Q?rZ5PrPyJqW3erQDEm+CNkMQC6pRkNfbM5Aathc1KaaEhyfzkgUra6bYbi817?=
 =?us-ascii?Q?zlFETQAxY83QZlQADou5Qxja76Pe95XVijsV5cLYj/4wIBtfmnKVcLlB3U2Q?=
 =?us-ascii?Q?33spo2ZJPTuxtxEuXQeloktqlgtWtXYnFp2gSWg0q401Cyhlsgg3QGmh631u?=
 =?us-ascii?Q?WaHzkZJEwq747AbncUSrDUnyYM4OULamh1W/sGl8aYU1LXFd5N8nNJMxGFQB?=
 =?us-ascii?Q?mxNUvWXZRkJhtxF+29UzlhvBOPqprwtGf7HqadoeCqFZTziMFWkreK1wjtr8?=
 =?us-ascii?Q?kOE51KUZ40zWGRAOEzH+bA9bo/wkhUbnTUL5D5xDCvvfrwSsTqgj3/RKnW4a?=
 =?us-ascii?Q?DhMxfoWmHl9vCqAe9OSA9K2NAdD3P4oFWWlgQYH7H1gkLz66fTTsFMq6AP37?=
 =?us-ascii?Q?Il8dJsvlcScv9joWd1RmOfK3MYA/PFAtu+miikj7FVKL+I9WWNZwrK8W2Afi?=
 =?us-ascii?Q?7+oRPGeSe8Y2yKltSjF6Nh0jg1NySCNJUrKN81jLtRn+GdlngWdOsbINZkX0?=
 =?us-ascii?Q?vPd1C/TsRVGnnXazrNfNJun8lV9huyTusFZmbqCK2XAKxnNQodu9m3enUwv4?=
 =?us-ascii?Q?Sh5ArbsAkhzweWtR5yPRzNxMbVz6VP0lvWzFkt6SHj1bOXnN3mF8/cwtis/S?=
 =?us-ascii?Q?DlfqSGfe2jquBAB7o2PiUUjX5V7rVWAZeplnFUteZnimHrqq57vdwX+M5F3p?=
 =?us-ascii?Q?pf2uJMZ8qXcQsSXAVZ9R6ba3WFpLg8c5AS0WysHqvaHn9xCn62RhtAei4vfb?=
 =?us-ascii?Q?vLdOYNHJFK/la02Mq9Du6QthP+F3Bw5cUlKmQ6uS1fpD2aUu/A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 06:36:42.8701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ffceac1-451f-49f0-5d0a-08dd08648828
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5932
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

And implement it for UMC v12_0. The die id is calculated from IPID
register in bad page retirement flow, but we don't store it on eeprom
and it can be also gotten from physical address.

v2: get PA_C4 and PA_R13 from MCA address since they may be cleared in
retired page.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 26 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index f97c45b4eeb8..a4a7e61817aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -91,6 +91,8 @@ struct amdgpu_umc_ras {
 			struct ta_ras_query_address_input *addr_in,
 			struct ta_ras_query_address_output *addr_out,
 			bool dump_addr);
+	uint32_t (*get_die_id_from_pa)(struct amdgpu_device *adev,
+			uint64_t mca_addr, uint64_t retired_page);
 };
 
 struct amdgpu_umc_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index cce93b4ffb58..30ee4cb9aaab 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -619,6 +619,31 @@ static void umc_v12_0_query_ras_ecc_err_addr(struct amdgpu_device *adev,
 	mutex_unlock(&con->umc_ecc_log.lock);
 }
 
+static uint32_t umc_v12_0_get_die_id(struct amdgpu_device *adev,
+		uint64_t mca_addr, uint64_t retired_page)
+{
+	uint32_t die = 0;
+
+	/* we only calculate die id for nps1 mode right now */
+	die += ((((retired_page >> 12) & 0x1ULL)^
+	    ((retired_page >> 20) & 0x1ULL) ^
+	    ((retired_page >> 27) & 0x1ULL) ^
+	    ((retired_page >> 34) & 0x1ULL) ^
+	    ((retired_page >> 41) & 0x1ULL)) << 0);
+
+	/* the original PA_C4 and PA_R13 may be cleared in retired_page, so
+	 * get them from mca_addr.
+	 */
+	die += ((((retired_page >> 13) & 0x1ULL) ^
+	    ((mca_addr >> 5) & 0x1ULL) ^
+	    ((retired_page >> 28) & 0x1ULL) ^
+	    ((mca_addr >> 23) & 0x1ULL) ^
+	    ((retired_page >> 42) & 0x1ULL)) << 1);
+	die &= 3;
+
+	return die;
+}
+
 struct amdgpu_umc_ras umc_v12_0_ras = {
 	.ras_block = {
 		.hw_ops = &umc_v12_0_ras_hw_ops,
@@ -630,5 +655,6 @@ struct amdgpu_umc_ras umc_v12_0_ras = {
 	.check_ecc_err_status = umc_v12_0_check_ecc_err_status,
 	.update_ecc_status = umc_v12_0_update_ecc_status,
 	.convert_ras_err_addr = umc_v12_0_convert_error_address,
+	.get_die_id_from_pa = umc_v12_0_get_die_id,
 };
 
-- 
2.34.1

