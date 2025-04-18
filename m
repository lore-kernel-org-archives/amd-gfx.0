Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751AAC369AB
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Apr 2025 07:33:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3136910E417;
	Fri, 18 Apr 2025 07:33:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u0vfi7tS";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9A4B10E417
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Apr 2025 07:33:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UW2Ek5bzL31NppSZF12A3jcFJHD8X2rk0pBYkhmZSy0E8ka2jNhl2ZRUCSYvVZTD1XPvewNdUK2bfpr1whjiKGOfYSN+ueCViqRFxiUMNsoYmYfc8EHVGhEOsjsj/MTxLjdjeypY3BC58dmakpIP7I8/lxoNR1fkRe6xAfpGk06PtCh+PuWU6Mt6ki21nE3h7qbuZVC2vFZy9w/WQWZwN45dLI37PZoYTnIEpnXIp/N7c9BSzf9wB0ICQZ6xVTd3heqZ8u+ucQaf+dyo6wPKo1rpHp74dz5mcJ1X8WqUuSWMgC1ZRR3xNldD9YWBEAIiMaEQQF0nSUzs6zSdzVK0yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hk2hkoCB3lLScL0kzl6AwZ7xEE8WmP80L2z7k1CFo/0=;
 b=ozFD0l9b2jm+9zBWKHy6rm5i7TfQ3WjIMkgjRBP1v1Ga3HNe0cBzjrCX7Vvr8jYhKtWOWNI8DbZANjI21lfklpGN/U9qj6XOLHNBrpC9CTLlluvd3DuKap+4QLCNZmPmwi3sXW6Pm/CrQH1wdh3LmPj0IRlwRL8mvFzTEkBtlQQ8F10RIp9FMHLsCzQ52wqE00S/ntzhOH+FNSGX/HWP5C3Pr2Cn/X9wA91qY0GjKZu29IoYkVTZLDf4U0AZutGnauN6uFrcPBshclUb8pNyBTBXznQNuGgw4G+2QJbINk1vqUdCHKzk/qfOaKnhAZN8xmWZuiKCH/uaJdm4eyKFZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hk2hkoCB3lLScL0kzl6AwZ7xEE8WmP80L2z7k1CFo/0=;
 b=u0vfi7tSJD21pR8B+pru/EqdHb8lzRtDrj2s1ISQuwnNjR3oPGFztKkb4n24WgY4nt1U5YvsfzZ/6j1zhSbVZFaHsIjx+Bw+HVseuDtuk6ztVZfD5oBYs6/Ri1uEtC9A+sjZlKJFRICONyE78VppuXWj11yPd7K9R+iPVqTe5yk=
Received: from PH7PR03CA0004.namprd03.prod.outlook.com (2603:10b6:510:339::30)
 by CH2PR12MB9458.namprd12.prod.outlook.com (2603:10b6:610:280::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 07:32:50 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:510:339:cafe::de) by PH7PR03CA0004.outlook.office365.com
 (2603:10b6:510:339::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Fri,
 18 Apr 2025 07:32:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.4 via Frontend Transport; Fri, 18 Apr 2025 07:32:48 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Apr
 2025 02:32:47 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Print kernel message when error logged by scrub
Date: Fri, 18 Apr 2025 15:32:28 +0800
Message-ID: <20250418073228.117249-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|CH2PR12MB9458:EE_
X-MS-Office365-Filtering-Correlation-Id: d9c4ca40-c022-4a44-9023-08dd7e4b3860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?etqULCA5QyUUwg8xwxIj95u0QCcpH6AaafnRbBPagZ/BD9ZbB2e1iiVD1Ajj?=
 =?us-ascii?Q?36j9l5kG7lhcUJnYMEoiwywiOEyOJnEDXZ/VYBytSvMyjODrOLDBQn1MxYs5?=
 =?us-ascii?Q?8LWcjDWyyxy67uOCgbNRzsyx6yjErvcW/t92+4N2w7fpnNi2bSgemRnYggtb?=
 =?us-ascii?Q?GEQDDC0R+vgrriI1P7W6EsVV5BFY+Qvv4oI9gfoyTaw0LtCGGSEAM4KRhDKF?=
 =?us-ascii?Q?Cu9pWCqFDwGD8BPtO3azPlLC+D54fKuY1ELKwr5Ne8v8XBh7VJnwM8WwqcbN?=
 =?us-ascii?Q?b8258M9hGFGVwjLCPBFSXzEly1AUU2yExYF0VyxFLgN46AsNX5zaboczNOes?=
 =?us-ascii?Q?hIVWYrnoeNb9FpJyj7GbvayG1ZLa0D4NPzQS7PF8rizFIqAn0Trw7EH+DcWS?=
 =?us-ascii?Q?bQrJkUVY5tqQXrDnKkBgPO6SMbHashivdYxCE9/57WTDC2MUe9Y0YXma1Its?=
 =?us-ascii?Q?Uw8vDrUnZYd72OPfLA73XyiQdwtdLz+cOSwvRLcLk/JBJwd3TSnmBxY1tFMG?=
 =?us-ascii?Q?8Ce4kQ/lkjwvwpgFRV7Xi269fj7rHeyBj5RM+ybwQZ9c0aq+yDxSusOntvZg?=
 =?us-ascii?Q?NllQVTnCkICKROQc86z+mSEoHp2rAtk1HY2gcc9XHuHyhxyHrXzcmrhVRVQs?=
 =?us-ascii?Q?o9aqu4Y2wGQsAqRqszC6e73k4HOYy+wQu9DxRTYE8Lf9toMgKlYhEQQna1Cf?=
 =?us-ascii?Q?kxov789LBYtIAjD9I4X34vJzsnNDXMwmuMWCLeTvj2l+ssO6ZXgRBR+SzUNq?=
 =?us-ascii?Q?x2+hIfxzaeQegWr72dBQ4dVThpSbYSFVuhwBbjpQa0YPoCOuGW2qUQcX7jBe?=
 =?us-ascii?Q?jQlLRHPZjg2vSJaAR/g2gQgBEjzVHpBJCcQsjgcILLLliv5TDambHJ54hxdQ?=
 =?us-ascii?Q?sp1Z9JdXFVMk0878FGVIiiHMiXycUYtbl8ZNiN5QJ+9lzUrQQYQy8ZlZ+paS?=
 =?us-ascii?Q?48G3ECU28zKgqfx6ByLCQkuqyj8cK/qepZfnVPJ0NOYN/mOHyc/dN0gdnA8R?=
 =?us-ascii?Q?ABo5+mw/D5EaBQu87r4VdMCu0hJPSg1QmbfSlsJC1c2R3xbpJsFRJa7+5hoN?=
 =?us-ascii?Q?ZLz51xDrpXR53hS6DbE6ROYzG7qpUY9+2nwQVidBMEir+BPXwNw4F3XUOCJQ?=
 =?us-ascii?Q?bG/7D+u9gCMPINUyApAQuidKxJByaEh2eaWuS++AMkWDg4Ig/e+EQ47AjnXP?=
 =?us-ascii?Q?JHhOSttbIm1Z6b/tZycnzqN1C1uFSqnVFSkABm41yZlYfPkxRlKUOaC1e3MM?=
 =?us-ascii?Q?oKSbAEvJ8D/lj6RZpq491Mk9kz0ta9yxW2lxdakgOUIks2P2W2p/N+EObsU+?=
 =?us-ascii?Q?FKrdqKpFkDhJmHHGcVlUIxLQdWGorGDEe8/k8S0Q2X5hCa/6NnxIsTq+ECkH?=
 =?us-ascii?Q?e50oFtZWGj4pQ0dRYKHFretLdkfD9qZGRIkyCk0ggtn8L5gQ/hf01jVwz+g9?=
 =?us-ascii?Q?S+/s/xX59hHxEWDmw7GT6b48sblK4sm3N4L+afurdZn4F9+0bstf+2pcotbP?=
 =?us-ascii?Q?9/F1OeMtl8C1Ip7ze/sGbIA8Zp6v91uHw0bQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 07:32:48.8651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c4ca40-c022-4a44-9023-08dd7e4b3860
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9458
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

Print a kernel message when the scrub bit of status register is set to
indicate that errors are being logged by the scrub.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index b4ad163f42a7..2b7b3abdbfc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -120,6 +120,10 @@ static void aca_smu_bank_dump(struct amdgpu_device *adev, int idx, int total, st
 	for (i = 0; i < ARRAY_SIZE(aca_regs); i++)
 		RAS_EVENT_LOG(adev, event_id, HW_ERR "ACA[%02d/%02d].%s=0x%016llx\n",
 			      idx + 1, total, aca_regs[i].name, bank->regs[aca_regs[i].reg_idx]);
+
+	if (ACA_BANK_ERR_IS_DEFFERED(bank) &&
+	    ACA_REG__STATUS__SCRUB(bank->regs[ACA_REG_IDX_STATUS]))
+		RAS_EVENT_LOG(adev, event_id, HW_ERR "Error logged by scrub\n");
 }
 
 static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_smu_type type,
-- 
2.34.1

