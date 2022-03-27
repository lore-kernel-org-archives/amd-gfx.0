Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC8DC433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Mar 2022 10:42:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08E7C10E33E;
	Sun, 27 Mar 2022 10:42:42 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2080.outbound.protection.outlook.com [40.107.96.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3DDB10E33E
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Mar 2022 10:42:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJis+QaKhYaqQ6g6DAiYaBaFRVUFlQ2En/KfWp9RBLaGtLl/XIEJ4IxSYjnRVW48adSN7YL8ytbOXYImzoGxXN95ZD20XNgFJHOkbwvj5ZL/0DQDgXnwmcz3ZI9IPSl/vUAa8ZlCJBKMTEfuBu1mFOZ00Xb7Iwfmt3hfhJgwmhaTZyKQUbCzUVpD51CPMW1m1qWvrWji6XPJoYb/PS/kJ1a8BLk+OkHjds/CQ+CStL7E9KmFtN4j8ncOzYaWSP3atcrZddG2Q2/5hvGgyPT74+0Bf8xuwNpsuX3lNoPLvdzyD/yYZCd0HnMRrT4AAoODp4FUaZO1+WWqXq+Xwvd1UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fj48oK2ntDDLXKkO3lWBk5AQnOcnzCOsoodd0ke7irw=;
 b=lSYf54dBRS5f/RIRr/JVha9GXyQa4F70DPWTBYaHDJfIdF5OeF9O94F1pAMCYPLKMS6SzgSOLD2vSUozkTXMFXYK3n1H9E3f1YeXwi5AEgDXdtCahgfM1jq0M9NCkIg4Z4vANMnJLiCozM1exlNvUWPpiQcqbv22szQihe92NEqfEadNYWrqrVkQzOfl4x+Po7hh1roISrGV6fR8HeboT9rbAXJiqPd8MY0IpDxSd+eOzvlnwNys9HwAfBYUZSOrpBtYbVSfioHSm95QnsAJwjzb3WZcNVIx/ME/gCftg3CEKviGRrj/I2jpHX7P1Ztgxb3PVV+lQ+E14RLViKrWoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fj48oK2ntDDLXKkO3lWBk5AQnOcnzCOsoodd0ke7irw=;
 b=2rT/eubX5/572fUae1S5nXk2ZrG1uoc3WPl8VRfJZPM4CDxv1kZED70PysC16QXkJIwk/Bxvad7PHjQtELEAHWZphIy8hl5hXa4916uj7J0vkqaBetMvbCCmBeWog1ANz1i7w3/r4AuUa9tycfiq9WK3T6zU7dgPtFRvIivOm0k=
Received: from DM5PR15CA0026.namprd15.prod.outlook.com (2603:10b6:4:4b::12) by
 SN6PR12MB2621.namprd12.prod.outlook.com (2603:10b6:805:73::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.19; Sun, 27 Mar 2022 10:42:36 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::ff) by DM5PR15CA0026.outlook.office365.com
 (2603:10b6:4:4b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Sun, 27 Mar 2022 10:42:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Sun, 27 Mar 2022 10:42:35 +0000
Received: from pc-32.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 27 Mar
 2022 05:42:34 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] umr: Completion: update new format options
Date: Sun, 27 Mar 2022 06:42:14 -0400
Message-ID: <20220327104214.106340-5-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.1.607.gf01e51a7cf
In-Reply-To: <20220327104214.106340-1-luben.tuikov@amd.com>
References: <20220327104214.106340-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a4d467d-e6cb-4ac6-eaee-08da0fde8198
X-MS-TrafficTypeDiagnostic: SN6PR12MB2621:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2621E42344B8D16C23296BDE991C9@SN6PR12MB2621.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HPKcazuDTBuakphcwtXKn6mCygkZceSB9Rp6BGjnrfJT5139WgtYJvF3mZWwv4bUY+exdV6oLyl/QcDB6Vyhdqk1lvJM/8AfSrl/kseRd3tgeC8plp9oBsRatfrp6zmi+vkWUjGF2sX0qwyFRi7/XQ5AL+zrM3thAK45nBbyajU4JItJW4cEkx06M+VFecIMD4nTk4H7Ao14AH9dPgU+Zy7G7ogGkglLfpp/pqUPQ0If6LnghHYY1MBnZYFuDHU3NfI2LgrOxrcPOHRvcMCnTxUKw3Hu4AbvZvSTJjM1jJKAQ1CDrHl2XLhJ5PeQWge0n66PrbQd1NSmWCGpf3SuqHNtjwuAYBvYDviQ9IuxNPE1Z+6DzRHl35fyHCpxbWOs9AZlzG8MBZCIj58d5YZpV2sZGrY6xR53J0leg25ktiz31/U+ww6F0zCKl1uWybcFd8gGTUlgerXAWxJWSoxmRJkyImWutlZJKM/KsPXZindRrJGGJfqZZZwhX2RYM9WmYQNUUO5yJi2GbWc8M5M37AjStMI2dy7AXHK1yLL60sRGdI2Up39iTFd8OCxB8W+N+RVx9XPPzXUCnLyFiFC7IknjLjJ5hmhmNHQy1ZkmSCBCRhtjwe4SC/C721vUKegoPuoozQe7kA3qB2oG4ILCXVCROSkeK2r6TpN/xWYw/kZkceBU/ZIngkKB08icH0BiYDbUtwg6aIHB3BfOJHSpVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(44832011)(356005)(8936002)(15650500001)(5660300002)(47076005)(2906002)(36860700001)(40460700003)(81166007)(36756003)(82310400004)(83380400001)(186003)(70206006)(70586007)(426003)(1076003)(26005)(336012)(2616005)(16526019)(86362001)(316002)(6916009)(4326008)(6666004)(54906003)(8676002)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2022 10:42:35.6691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4d467d-e6cb-4ac6-eaee-08da0fde8198
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2621
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
Cc: Tom StDenis <tom.stdenis@amd.com>, "Jinzhou . Su" <Jinzhou.Su@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update completion for "--ppt-read" and "--gpu-metrics".

Cc: Tom StDenis <tom.stdenis@amd.com>
Cc: Jinzhou.Su <Jinzhou.Su@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 scripts/umr-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/umr-completion.bash b/scripts/umr-completion.bash
index 0e1444357c82a9..bd0b61b2d38831 100644
--- a/scripts/umr-completion.bash
+++ b/scripts/umr-completion.bash
@@ -333,7 +333,7 @@ _umr_comp_ring_stream()
 
 _umr_completion()
 {
-    local ALL_LONG_ARGS=(--database-path --option --gpu --instance --force --pci --gfxoff --vm_partition --bank --sbank --cbank --config --enumerate --list-blocks --list-regs --dump-discovery-table --lookup --write --writebit --read --scan --logscan --top --waves --profiler --vm-decode --vm-read --vm-write --vm-write-word --vm-disasm --ring-stream --dump-ib --dump-ib-file --header-dump --power --clock-scan --clock-manual --clock-high --clock-low --clock-auto --ppt_read --gpu_metrics --power --vbios_info --test-log --test-harness --server --gui)
+    local ALL_LONG_ARGS=(--database-path --option --gpu --instance --force --pci --gfxoff --vm_partition --bank --sbank --cbank --config --enumerate --list-blocks --list-regs --dump-discovery-table --lookup --write --writebit --read --scan --logscan --top --waves --profiler --vm-decode --vm-read --vm-write --vm-write-word --vm-disasm --ring-stream --dump-ib --dump-ib-file --header-dump --power --clock-scan --clock-manual --clock-high --clock-low --clock-auto --ppt-read --gpu-metrics --power --vbios_info --test-log --test-harness --server --gui)
 
     local cur prev
 
-- 
2.35.1.607.gf01e51a7cf

