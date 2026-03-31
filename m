Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A852109B467
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 13:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EABE510E165;
	Tue, 31 Mar 2026 13:41:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yc6NwgSJ";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011004.outbound.protection.outlook.com [52.101.57.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA5A610E165
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 13:41:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUlS1iEJ3I/pVygNJSgneYEcnrYV+0a9l3JZbBpp623rbYYjtdnDXiR+5j81Vl6KrlEPpMCmSj/hUz0o8uMa904uNynqyrJerdGYJC8T4p7JEb1bws2eu723Or5mH7gtJfLrbxIvlMnLb7S7bD/nW07g1IkXHlziEmW8nsvDNguwtVJ1m12lzWlUKff1Qw6t2sfoKdsQJ9ibkg+2p5OlBtD/Ko7FaCbtoM4NnVDxAA8TAvgtomRZAiL4Ie/7EK1a/AODgqkAE4vulJrD5ZSl1W1165zyxaTCkjhKTG+cR9UCzjSg+Hlh5ZiVz7hPqeTtslSXwBHxbCTjQw8Hfx+ttA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amwJ0S88doQKAV3e5fplt7XRkHUhSrCojcn83P3wlVg=;
 b=aaYPU3n4oAsKTfBr94GdE880FdvGzcA1TgvAndTkJdHFH3fT5ihMZylPvZpvD/3o0tuFjKk++ex4Me8AaqB1HcVGJ7YIsxaLSMKm5ZXCYlDntlDSBI0irCq6evcyw6wEczUeHflhtD7+pQxVuQLcFhO0o/oCZUnfuopSlh9WC7YmeCOVIkfQq6b/fd+OiP+cQx5Nf5MRCq9qv2aYnHQsaixU0STGyozDUNbHShQnettL+tKdVO4HT5FcdJitirnCwIa8W2jrjQXC7SqeL2uoMt1ThIBTNUxd18IKNZbxBO1hfTHAFAbH6dRDgvy3BlYwk5IGcLmXwrAxVtA+ELHVgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amwJ0S88doQKAV3e5fplt7XRkHUhSrCojcn83P3wlVg=;
 b=yc6NwgSJKGWvWOHBaR69IpVza08I4CCNTgH+ZyOo+jvZbLZAEak8OwQi6z2icVcay+/v6kkwQH7/OVUA4L0FX6jQcBXaqqP482ZRwvZ0KxYCoBVvlPGWsNdSc5repIJE7h//FFa25qoBeHk/KIEQiymEqFdXIgwDxhKyhOd08e0=
Received: from BYAPR05CA0089.namprd05.prod.outlook.com (2603:10b6:a03:e0::30)
 by BY5PR12MB4178.namprd12.prod.outlook.com (2603:10b6:a03:20e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 31 Mar
 2026 13:41:48 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:e0:cafe::bd) by BYAPR05CA0089.outlook.office365.com
 (2603:10b6:a03:e0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 13:41:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 13:41:47 +0000
Received: from ram-Splinter.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 31 Mar
 2026 08:41:45 -0500
From: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <Pratik.Vishwakarma@amd.com>
CC: "Ramalingeswara Reddy, Kanala" <Kanala.RamalingeswaraReddy@amd.com>
Subject: [PATCH] drm/amdgpu: Use SMUIO 15.0.0 offsets for TSC upper and lower
 count.
Date: Tue, 31 Mar 2026 19:11:29 +0530
Message-ID: <20260331134129.1688799-1-Kanala.RamalingeswaraReddy@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|BY5PR12MB4178:EE_
X-MS-Office365-Filtering-Correlation-Id: 1349e91f-a768-4320-0b1c-08de8f2b4149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 7mIn3Ma3INWQMiHUhXRWhGLwV5By9DbjSUOapWyVgfq3vlHkjJBpZ/nAniGyyMn6FHeFWUMPiOG+k9z0z1SUR7FLGdNHrUm301/0GzdDQwEwMxPZ9Pk8GQ5T+e/09AIKAD+mGB0SpGRztRK48ZhG0wfhKQ9uXbXHbIfs7/+YPxXRhx/e/XbW6rYZpCs8+AKUk1HCAdXQuk2Fiwj/l2hv6/VFIOJtrIsd5ZhK2QHsfDBt4nTOY6pM5LkXoqD8OEC+ALLxv66/fI3dNJ3grFMWKxXGpe/eBxZ14Okdz0BtTwx8rUrRC8sNa0c5gGjOw0JW8JuGwPE0F3EM7XspX5MWGRvBET2m0ZMhWoZr0ee1LaM91dSVuhNSkD8av6k5wAjhW3qwualebZHnceTXNqrnuTrqoaJ81M3rTcss/m5TEeAPI1TTSVwA7LJFlbHmzeR8WZewtrFr/rnr8PuTGXieMOU6vMZbqnA0xBFIEiDoTOUD0niU9Bhp+JdmewW51we9OhUoJ0MAMMgSm9HGhB4gSiKBVWZLo8JQVQp/NAeeF/ABgALyoKT5QM7sZ7MXo1wUcPhNG22fp9qnf4bL/9yEU7GcX6EWjVma2C09OX3N0oh1+ShKOcLf//moIZ42BJn8Vo//tgdeYFF/o3Csp1fPGw7tMUV5wCz2smmBrZ+BCDrtrAnbfT0R23YK7SxulduTQ/fQNdYQ5Y69/0tr9PRJ2S2Vam/LN0njsZmhCS3iQ9Cgx9nVOGXRfPqWunpw7VJh1MFYWcpxXULNbTvgH6MMyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zMUhASUB7MWiwLronQtgySqZV0DqangjC3OPEJC2/PQ4Hb9nykax/lEfcvlx3IvnaNQ+73k6AjBZJgSV6c85Jwfgjzylpj9Dx0nQX3vyy2ANFgWyn7dUXcf17TjTGEXVM50sOPfChuBeCWDWuY4capY6QSOC6sgVMDm1U3NXKegA30u+eKWQ6cQplsy8VBqd/h47k9vXia9+NPUcSewhiuhxmHinNBpxKRq61vxjVWD0ZNIGcUJm2bnPkCpnvoZXKGyuJf70IfJLrYp3XZd8oJKOab1UQSMfUrDxoCOZgxdiNWkr67aYye193dtjiHEazvUSElkV3+p4QEx65cTHhxrSVmS7eheG8GLiZpGLtfzOpIP8OGK/Tbx3Mv0F3OtzF1hwdeQQJujJ4n8LGKoNp8jJCwv4jVxKY6EeLG3cYYmRmms/gjQk5u2L8woNXVDL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 13:41:47.3515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1349e91f-a768-4320-0b1c-08de8f2b4149
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4178
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

Define and use regGOLDEN_TSC_COUNT_UPPER_smu_15_0_0 and
regGOLDEN_TSC_COUNT_LOWER_smu_15_0_0 for TSC upper and lower count.

Signed-off-by: Ramalingeswara Reddy, Kanala <Kanala.RamalingeswaraReddy@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 31 +++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ae39b9e1f7d6..a40479fb00f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -64,6 +64,11 @@
 #define regPC_CONFIG_CNTL_1		0x194d
 #define regPC_CONFIG_CNTL_1_BASE_IDX	1
 
+#define regGOLDEN_TSC_COUNT_UPPER_smu_15_0_0               0x0030
+#define regGOLDEN_TSC_COUNT_UPPER_smu_15_0_0_BASE_IDX      1
+#define regGOLDEN_TSC_COUNT_LOWER_smu_15_0_0               0x0031
+#define regGOLDEN_TSC_COUNT_LOWER_smu_15_0_0_BASE_IDX      1
+
 #define regCP_GFX_MQD_CONTROL_DEFAULT                                             0x00000100
 #define regCP_GFX_HQD_VMID_DEFAULT                                                0x00000000
 #define regCP_GFX_HQD_QUEUE_PRIORITY_DEFAULT                                      0x00000000
@@ -5234,11 +5239,27 @@ static uint64_t gfx_v11_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 		amdgpu_gfx_off_ctrl(adev, true);
 	} else {
 		preempt_disable();
-		clock_counter_hi_pre = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER);
-		clock_counter_lo = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER);
-		clock_counter_hi_after = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER);
-		if (clock_counter_hi_pre != clock_counter_hi_after)
-			clock_counter_lo = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER);
+		if (amdgpu_ip_version(adev, SMUIO_HWIP, 0) < IP_VERSION(15, 0, 0)) {
+			clock_counter_hi_pre = (uint64_t)RREG32_SOC15(SMUIO, 0,
+					regGOLDEN_TSC_COUNT_UPPER);
+			clock_counter_lo = (uint64_t)RREG32_SOC15(SMUIO, 0,
+					regGOLDEN_TSC_COUNT_LOWER);
+			clock_counter_hi_after = (uint64_t)RREG32_SOC15(SMUIO, 0,
+					regGOLDEN_TSC_COUNT_UPPER);
+			if (clock_counter_hi_pre != clock_counter_hi_after)
+				clock_counter_lo = (uint64_t)RREG32_SOC15(SMUIO, 0,
+						regGOLDEN_TSC_COUNT_LOWER);
+		} else {
+			clock_counter_hi_pre = (uint64_t)RREG32_SOC15(SMUIO, 0,
+					regGOLDEN_TSC_COUNT_UPPER_smu_15_0_0);
+			clock_counter_lo = (uint64_t)RREG32_SOC15(SMUIO, 0,
+					regGOLDEN_TSC_COUNT_LOWER_smu_15_0_0);
+			clock_counter_hi_after = (uint64_t)RREG32_SOC15(SMUIO, 0,
+					regGOLDEN_TSC_COUNT_UPPER_smu_15_0_0);
+			if (clock_counter_hi_pre != clock_counter_hi_after)
+				clock_counter_lo = (uint64_t)RREG32_SOC15(SMUIO, 0,
+						regGOLDEN_TSC_COUNT_LOWER_smu_15_0_0);
+		}
 		preempt_enable();
 	}
 	clock = clock_counter_lo | (clock_counter_hi_after << 32ULL);
-- 
2.53.0

