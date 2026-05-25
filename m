Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059C9CD5BC9
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 15:32:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E46110E3AE;
	Mon, 25 May 2026 15:32:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zo4ph4/F";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010041.outbound.protection.outlook.com
 [52.101.193.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0159010E3AE
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 15:32:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LN7zqDrRQd3BIIDbxnHzIGbUl8azXHg65eJ4qDGAtxYQDfsWX8lnbvcw0U4vCRhjfRjEW+MXEG5xP85+357zU0ez7twwUkl+DPIT5xwwP5NcISGjKTLZxEoPsBL+nV3tSNq9utKkWgaZr93yoxw+B5XzBtZk+7klfVyh/NjbUKkwGZXls5esOPSsmkbwSvd+Su4E2A370gzLMuHu1RHs8fE17t9Fw8FEuNrsjAMRo8n/2oh2DtJQ83WrIRIt4BT358cLAfB+mNamaeByNWneCPM+ZmC6rYDPnrghkC4Y6GdfIRFLuEbvq9vEdXzpGiyzG1NsBvhsl6EdFPHvd8VQNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MS212iNdX/CLiTsWkmQ2zma18TD1pYzDmcs569azJeM=;
 b=d/L1LMJEzRajdULcLklo7WZnmiwp4AomyTO4em7b1kvqeiUZ2V8rdxqRzu63SppbfaZVF7OI75SA1dnvVBsDyTaQcCUEUh/cE5uJQcfL5TK25ThT02pat9gHL3qfR7WNuGJxPmeyjV3M1mknfqylk4hHLrPBU2CjmCz4m9wZbrHilLZAw7aJ3HDQA3bQyITImBbSt88KcYf2wMuMaP6LhY4Rd3Zgd9c1EQ4gETSu+nkQZjnWJaukiMZAGgVr2RBjSX6AS2XT9UqAaqZ3Dl5uqmmFzRu56k86yF6iZuq6Z+yHjwhG1dyfOoKVrYndGuY2I7+cXDjbukgywKw7ls04wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MS212iNdX/CLiTsWkmQ2zma18TD1pYzDmcs569azJeM=;
 b=Zo4ph4/FZy41GOk5oPgng/eXY8MkMS03BYUQS5sc388+vLmljUoGE5qMnLwRoIolGIqQ2RDXcQuV23j/qIYrI7Q25PbqQLULdK31lEVETzWfaoAI/RWnyGMARd1APgitK66ZzKsVSmwPYnVnYg3FeC3EEbUTTGgb5pM8769U1Ks=
Received: from DS1P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:455::15) by
 CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.20; Mon, 25 May 2026 15:32:17 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:8:455:cafe::8) by DS1P220CA0009.outlook.office365.com
 (2603:10b6:8:455::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 15:32:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 15:32:17 +0000
Received: from jeevana-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 25 May 2026 10:32:15 -0500
From: Jeevana Muthyala <jmuthyal@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Jeevana Muthyala <jmuthyal@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/vcn4.0.5: enable secure submission on unified
 ring
Date: Mon, 25 May 2026 21:01:56 +0530
Message-ID: <20260525153156.1258211-2-jmuthyal@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525153156.1258211-1-jmuthyal@amd.com>
References: <20260525153156.1258211-1-jmuthyal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|CH2PR12MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: bf53cb99-fbff-4861-1512-08deba72cded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: 37P7SdFIiHn0/38wsz9ss/lT8i6TAyLXhE3U0NPgCmHXPTfydJkgnniP0iA1xihqihmwWR0Ts3h5ErwyXbiBBEXWRf1wBisRUziOhGEoMfCmYV3tXyNi9BvOYLZFJ9/7W+RG6A25J+64FNkHw0+UV2oy+WLZem/bC3Xg/iO7KQuAqgr9QDhKDQjVW3b7cHQCCQCZ+WelxyKBNqkygunZyuEhIoPdQQ8HUNZ7mqlRWXyLicZa8lXBck8QPWHw6XcG/MOdpPv9Jk+QcqjDJmHFLuZHH5/GLG1tyqcvDENo9o/ZRj8lIEkCb849st783mxHnizXkr0H10wQTEXqPfmUDV78tY9tkfKm5kdqCbnS0H7PoRBK05irxnoctMQ1sIkHu6aklO4zxfclNDfFvcSkvbtDLreRKbRva80AYiuKsIfqi0uBBGU77Lzzc9pbRAOT08MwoLgnRq/f+CQvUJDOoxYu16QXrBBcaPC23xgnY6wRIOKY8vl/XF28nmI6YSj7tHSe1rlc4/Q/tmTgWObrgEY6dQGAUY5gsFRlJUauJcD30HCysNDvdhFLv9KN2swmP1p7v8jKm5R0q8mJMlpLElW9lORMFtFVLEvwlWW0/rgrco8PARcP713DvgnM+rbl+9H0lvguDyqVSYqRSuwLN9fCXFtdZ6JTsAROAFRsUit+D7DJUAaO2wdotDi+H6U1A9u/JQt9WChJ6P+ZCly1uvjN2wkauMt0Hnv8EFhYTpE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(22082099003)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AUGqLSzbvfCBRly58iHTjigV3/2R6lLN8oyCXuFZxn8kYR7ikwYUI+uuB5WWQ1xXlTBTxTKA3kUc6JVJD+RcQ0bbtqrwLtDqUW9z6SWb5Q1z55hG0HkXJ18SLJ2OsJavq/iLBg47067Zhi6klFUJHTtlws3ltGGBAGv2timqefvkQFklpUIDfzQFez3DW1NF1LVzi6hR4egze/SOzSVDZLp8KYI7sgbMHoRSMi2N8uMNk3P4rdAIYAFx8xWKjbcNxqaN9DZVicOL977n7Xfa0ycpnC/Z9dQiDNSqLkPa1opvlN1PqyNeZyjXHqmG5RCuCnJDlhHNwwIuFDkHifFtXgl8LuJTrrjMeQDbz6PsEman/sIu8A/wFCDwIiPPoE5Ap6JtI0wNn8aiM7w9ApQhgIPIGKKSuGDjEmigE4G7pXLGeLvQ2JVpAlIOpHwIwefO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 15:32:17.6291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf53cb99-fbff-4861-1512-08deba72cded
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136
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

Set secure_submission_supported = true for the VCN unified ring funcs in
vcn_v4_0_5.c so secure IBs are allowed on the unifiedring.
Without this, protected decode submissions are blocked by the
common IB gate and can fail playback for secure content.

For vcn_v4_0_5.c (fixed STX VCN version), secure submission is
enabled directly in the ring funcs definition.

This change only advertises existing hardware/firmware capability;
non-secure decode paths are unaffected.

Signed-off-by: Jeevana Muthyala <jmuthyal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 1571cc5a148c..c8879a6e5297 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1479,10 +1479,11 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
-static struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
+static const struct amdgpu_ring_funcs vcn_v4_0_5_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.secure_submission_supported = true,
 	.no_user_fence = true,
 	.get_rptr = vcn_v4_0_5_unified_ring_get_rptr,
 	.get_wptr = vcn_v4_0_5_unified_ring_get_wptr,
@@ -1525,9 +1526,6 @@ static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		if (amdgpu_ip_version(adev, VCN_HWIP, 0) == IP_VERSION(4, 0, 5))
-			vcn_v4_0_5_unified_ring_vm_funcs.secure_submission_supported = true;
-
 		adev->vcn.inst[i].ring_enc[0].funcs = &vcn_v4_0_5_unified_ring_vm_funcs;
 		adev->vcn.inst[i].ring_enc[0].me = i;
 	}
-- 
2.43.0

