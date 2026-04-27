Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B62DFF8860
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 11:52:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DE2910E6E4;
	Mon, 27 Apr 2026 11:52:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zSBhcPJ0";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010046.outbound.protection.outlook.com
 [40.93.198.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67E9710E6FA
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 11:52:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vk7ItplqXq+7qtIFnj2iTtIQIj0NWcdKVut89X7Uj3GSnIAG4GV5kpPXkufXLEgb0fKpHMrLykjaqHs8E0V034cPYvxaZDymGhg15P0FKztivnkuRxRijD/swN5V3CgBlkX1Tnveg8sJxiqENZk5nrYVRaiHRUx1ZXCieA6sQ6X0zJf2lEhnlgxXqkJAkPY2exljJdc6wh/qwFbqBGdMYI8ijGBRfKGgwVqBqJs9XfZTp380zo2hDzXXihOooRN+UtBNxC8QGqR6CsGtF/HikWCnoDZeJ4TPE+Tw2fYOGGxR1F0t1k73b0FuFTWtOF3GIjqWQ49exytfPP79MYA/nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUTbSs3GuuABnQmHhdH6SZMXLkynGxZefg7GAo8XCpk=;
 b=mThRNPvHrdbDNV5BEzbO/9J1+BouVdHZIbj1dv28fZXGBFoIcA9zSw4opSfB4dIspQrtP24ZPOGssyjp6O64BYp+CVtXB44Cmk+9dbJm1kmPpuwR5tdezKpkhNhPpZS5/fhfP86UygbuVWCUWOdU9MU5XMg1IZBu2XlQ4yG+OAclLyzwlhRYVuAKiqd/h3ZGwRZHQrcHHxN0ga24cGkKlT4x/nNvy5xwEnqP6HTcfTEmFe7II0L/p2oiKv1wU9PC9tx0UPR/GLt+nyHydVekod3+157gmXeF1NK1zZ0HL0iJrvx6nnuIWvQQZskL0WfvE8KQPFya6xe4Mwke4PzPKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUTbSs3GuuABnQmHhdH6SZMXLkynGxZefg7GAo8XCpk=;
 b=zSBhcPJ0Nn+xmj7tErxvyciz+XwK/yvHiVbVTdPDUDqwFY0ZQFlDyckvMZ5w0H05ivtZzcP4rBsypz/WBlerNM2QOo9i778Z4QD3mux4FwLnSy0il89xXsJMSD84Mz+fZv6+ssfIkep9qx/NjUvabCFY3HlSYETqWtBdD6MRLLU=
Received: from SJ0PR03CA0007.namprd03.prod.outlook.com (2603:10b6:a03:33a::12)
 by MN0PR12MB5812.namprd12.prod.outlook.com (2603:10b6:208:378::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 11:52:11 +0000
Received: from MWH0EPF000C6192.namprd02.prod.outlook.com
 (2603:10b6:a03:33a:cafe::ef) by SJ0PR03CA0007.outlook.office365.com
 (2603:10b6:a03:33a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 11:52:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6192.mail.protection.outlook.com (10.167.249.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 27 Apr 2026 11:52:10 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 06:52:08 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amd/pm: Update emit clock logic
Date: Mon, 27 Apr 2026 17:21:51 +0530
Message-ID: <20260427115151.3626843-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6192:EE_|MN0PR12MB5812:EE_
X-MS-Office365-Filtering-Correlation-Id: a853b4fe-900f-4bea-6440-08dea4536a58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9e2bRm9WryVhuwdzixAvH0JzcZMT6LxM6oArrPlH6s4WNSoGba+GMihRq3CsJhOM1KYJ3ZtFedA2fuhzbV3W8DUpGm4ZiKExXPYbdgLvp0X42jtNwnLgVblxP7IattwKOpuyEBocm7WlynZt7F6CY7hx1F0ic27768u0qQClyuaBmsvp2itPLNl9j1B0hfkfmM3VcMGQMF/PxCWIc0GLDa1ivXm3q/f1UnQ8YZCg2nIBV0S+UBQ4ZD8Rp42HEDAUV1ACo6TGxQAOnysCMY/HjsrXsgzcfh9vbAk0MsZm9HhlhYOYCy+J42tBePJb/PH4vsZMR4Z9DnCMrGma6IgU6wJBMRDUUhO02vFVabekPDQRMuH5wXHLA/joKx9/IA8eepOejAUR565ZqxSAzILOu4SQagRPn6Xo3k0iAp1B6FZrWKM/vEzzjtgipLuj9OMjgZq3Mroy85rziuQP9gu4jv3eBnIsf+effJmVA/JQ7FtiymW8DdqOWQ/rMyfrFUG2t5F2Wp7bOOYcP7vw8iXtAXp6lV1fvSYCan3F2wMDOLSFQj8dJ7rtlcBcqakbd1tCAP71ZoyCL/Ao3O1NyR/+IzFvSV6t7Xu0CyGA3OgVKK9HztBt4LeXg+P0/veJ72kqxRp9bKPkLBzx7gfR+D/V0zFR5NDuqxGF+2/T3C1qgtpBY5XtHPrYAb8MATXYFI4K9ZYlTnuOjQsPykjNEiUwNQXC6ILlaMB8YL9U6uLgRdwMW9cx59Q8LnKU02gRVCGtmS2JK4TEYNq6iwUkRJ798A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LkavMfImYUxwxrUn4PrxYfkfDDYAtdskVixEL/XW1sVuW7qOIvrnCzOMwW4+IJ5dK5PqF6azgaqTryR1zhNKNS8eyRU/gQ8zruqKM++gG03jaiNvkzax8qZtdSikODJcWGSqLBKm+psaawbHwDmICo6x1kyL7KWDtYeTZi/1C1DJN0TL5WaEWPrR+whVoCuWckJKj93L6GeQz0TBh7TAqH/HjqcmN9f1oPpU7gotGofZ/pe1Itv7QmO0ISiH3GB4k6A81QnH6uA0n4Ajf5fFrv3Xk8mlFJAJLTAxf907GVIc9GU+ChBvchVlFsZHJvmb/dAABxCyMsesWY5UxxUXPddLO/DZZI6E1Vy5h+PpmpAcP5eVO4V9ZeQWM76f/uAz4toVzB5aiwuMQ4bZR2aOvA6vfqCx0/ys2lSuZCU7s8XObxq3WBUbzyxEeiJuMzj7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 11:52:10.5787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a853b4fe-900f-4bea-6440-08dea4536a58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6192.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5812
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

If only one level is enabled in clock table, there is no need to
follow the fine grained clock logic which expects a minimum of
two levels (min/max).

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 006ef585a377..bbe2ebaf4294 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1357,7 +1357,7 @@ int smu_cmn_print_dpm_clk_levels(struct smu_context *smu,
 		level_index = 1;
 	}
 
-	if (!is_fine_grained) {
+	if (!is_fine_grained || count == 1) {
 		for (i = 0; i < count; i++) {
 			freq_match = !is_deep_sleep &&
 				     smu_cmn_freqs_match(
-- 
2.49.0

