Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA111C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Nov 2022 15:22:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED98A10E47E;
	Wed, 30 Nov 2022 15:22:33 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2081.outbound.protection.outlook.com [40.107.96.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38F4210E47E
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Nov 2022 15:22:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Flb7Yc/HvEYI9gPBNtpt2XJZ3XMNtX/SIQQFkVORNh6r+wNFpLZxsbN693vYaV/GbLgriTY2ZdgU/K3plPreFwTMtp9SK2/A90mPtMU1Sx3WeI1IFP31FnOcuuLQgZVYK3Nai8bvBrJcVUnAku1AMBVE2SdOjDe9AMXHRpYMGdK/91is27v4adZLxkXPadUC5jiec8RjXYH4qDrXJZcsV5ttVuZkaHaOD5mr2MAx8qAhXnAgLEaXBdnd5Mj6PVHmOcKQ/oz2jvTqU4mzdI5HLgKsZ17ht7yQXxeviUdwi+MtePZbiTx/S1WOdmXTC4AAPD/hAjsrQ/yEnCCw/ZYcbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otFn2PbXHNMRi5wHleGsB2k3/SrRlKUH+Oiwt3tcc88=;
 b=i5IbFQ64h+kaXRE6fvGlHdgj45U0UFaIomCQtqNx229FQLn9w/rqq4iGOI3+eSB5i0I7nrxubjq4DBHURfv4aVsD4vT9jQEZCk523rz+cMeHTkg5kNMFvlvCwLFOWPWqTb7LBYrCsi1qNRveFEptwwOB02f9y0hdZcCpN5ObKQN/97ygQlTcTCxV24D+iUJwp/Nol7FMWGM2q7g2Phg9SF8XnxgUqQ/NW8nKMHJB6DFgvlbEa3jLTrgBjWSB3HDqVPYo3sDV/OzwpF5npdPBIOsZglat2ZsTPwT3drxrc2JOJksHzGiMbgvvgOTUzj7JRSQ5DMKrrv5B1nRATIhIxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otFn2PbXHNMRi5wHleGsB2k3/SrRlKUH+Oiwt3tcc88=;
 b=eHLLfnqvAjA1NWoruRYN+7orKvhasFovqc4SReOYVNmhwug2vO3ikNDnm4/riSO/pbQ/9eh57Y4A0kEGekBku+NDQTSuEClC0Ri9ApzEVHySJvgTfSzEJJSuSIIZ3X4M1I5OWJw4kDzwX/9zml8F9XqMfwy3/leubmVw6jTgYSQ=
Received: from MW4PR04CA0115.namprd04.prod.outlook.com (2603:10b6:303:83::30)
 by SA1PR12MB8118.namprd12.prod.outlook.com (2603:10b6:806:333::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 15:22:28 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::e6) by MW4PR04CA0115.outlook.office365.com
 (2603:10b6:303:83::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Wed, 30 Nov 2022 15:22:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.18 via Frontend Transport; Wed, 30 Nov 2022 15:22:27 +0000
Received: from fedora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 09:22:26 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: Tom StDenis <tom.stdenis@amd.com>
Subject: [PATCH 1/2] umr: Convert the last underscored parameters to dash
Date: Wed, 30 Nov 2022 10:22:11 -0500
Message-ID: <20221130152212.16913-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.39.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT066:EE_|SA1PR12MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c03e741-8da7-4bd4-885a-08dad2e6b0da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 68tv2GLwUbziNif7d2k7kIY0mC5+7ln/BfokLT8ESMb4TFwgtmJ+S/HvseLmChP8r8lUD4gAg1JnC8Tuiroz45TcfhgeOgTCDMRkO2spv5mUQWKcMt6os9p30DVRGXcL6yZ51oMyjWKq5Rr4Gy927EwbbEp6CCxCROXL6sdkDp1a6kh3JcZvZ6BuLP51dK3J7fNQg0/Lp9ibyhwSuK1BZQXq0rE6ad68zhi74V9gU6j5NISuVw32O02Q/bAhGcs1bSGavzqH35hqpNJEk+nq2UWgEy9dwr86BvyyrdvokRkZjQrUm/xS+KOKlY+l1+I+Y08NJ0ZX4X3YtiXBcf9rgM+35FjEldPB16RMLX1gaGytJw/0pVbLJrl84oy+7U4uuuNzjn5Lgy7IREv1CGzQaB5LX9rPnNwAbSGrFMrgIQFSUiuqRv9itzu94Q/KzAR1J1etn2DahY5yoyxcek6k5UmVGKXKn97KuvJd/CRz2JQmurWHGL96/Khwj7WbhhV0Z4m8Dv8Dq3DZMIq/clqCRvgOwaEEDsF05fqJqOy50ncj6Q/HOzOA7jhQDchvQiDXBA6n7H+U0kf4m6EHrSAJM7oxgyq0bJEK3JhmHRlfFrK3WSAOZ5mi4J4OcZRLShNvn5LxwmTsL30m0o5Ool7jCJcA0jaFEtuyTkFLPgmzc8K6MKtBANJhIavhtQrN0luJLqIczEAIyBr7ebLGCGKboyXQDQ5csT22wikclKbq3Zc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199015)(46966006)(40470700004)(36840700001)(47076005)(5660300002)(44832011)(426003)(81166007)(356005)(6666004)(40460700003)(37006003)(82740400003)(6636002)(82310400005)(54906003)(70586007)(316002)(26005)(186003)(40480700001)(16526019)(336012)(70206006)(36756003)(8936002)(1076003)(41300700001)(4326008)(6862004)(7696005)(86362001)(8676002)(2616005)(478600001)(36860700001)(2906002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 15:22:27.6206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c03e741-8da7-4bd4-885a-08dad2e6b0da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8118
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
Cc: Luben Tuikov <luben.tuikov@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Convert --vm_partition and --vbios_info, to --vm-partition and --vbios-info,
respectively.

The old underscored versions are still supported and understood, however not
suggested in shell completion or printed in the help menu.

Now, for instance, completion on --vm looks much better.

Cc: Tom StDenis <tom.stdenis@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 doc/umr.1                   |  2 +-
 scripts/umr-completion.bash |  2 +-
 src/app/main.c              | 14 +++++++++-----
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/doc/umr.1 b/doc/umr.1
index b462e2a56584b6..fcc50fe259a46b 100644
--- a/doc/umr.1
+++ b/doc/umr.1
@@ -30,7 +30,7 @@ loaded the corresponding instance will be automatically detected.
 .IP "--gfxoff, -go <0 | 1>"
 Turn on or off GFXOFF on select hardware.  A non-zero value enables the GFXOFF feature and
 a zero value disables it.
-.IP "--vm_partition, -vmp <-1, 0...n>"
+.IP "--vm-partition, -vmp <-1, 0...n>"
 Select a VM partition for all GPUVM accesses.  Default is -1 which
 refers to the 0'th instance of the VM hub which is not the same as
 specifying '0'.  Values above -1 are for ASICs with multiple IP instances.
diff --git a/scripts/umr-completion.bash b/scripts/umr-completion.bash
index 0b8beab97b9aec..1488dc10d6dc5c 100644
--- a/scripts/umr-completion.bash
+++ b/scripts/umr-completion.bash
@@ -333,7 +333,7 @@ _umr_comp_ring_stream()
 
 _umr_completion()
 {
-    local ALL_LONG_ARGS=(--database-path --option --gpu --instance --force --pci --gfxoff --vm_partition --bank --sbank --cbank --config --enumerate --list-blocks --list-regs --dump-discovery-table --lookup --write --writebit --read --scan --logscan --top --waves --profiler --vm-decode --vm-read --vm-write --vm-write-word --vm-disasm --ring-stream --dump-ib --dump-ib-file --header-dump --power --clock-scan --clock-manual --clock-high --clock-low --clock-auto --ppt-read --gpu-metrics --power --vbios_info --test-log --test-harness --server --gui)
+    local ALL_LONG_ARGS=(--database-path --option --gpu --instance --force --pci --gfxoff --vm-partition --bank --sbank --cbank --config --enumerate --list-blocks --list-regs --dump-discovery-table --lookup --write --writebit --read --scan --logscan --top --waves --profiler --vm-decode --vm-read --vm-write --vm-write-word --vm-disasm --ring-stream --dump-ib --dump-ib-file --header-dump --power --clock-scan --clock-manual --clock-high --clock-low --clock-auto --ppt-read --gpu-metrics --power --vbios-info --test-log --test-harness --server --gui)
 
     local cur prev
 
diff --git a/src/app/main.c b/src/app/main.c
index dbe85f94e025eb..aa2152f977367e 100644
--- a/src/app/main.c
+++ b/src/app/main.c
@@ -265,12 +265,14 @@ int main(int argc, char **argv)
 				fprintf(stderr, "[ERROR]: --instance requires a number\n");
 				return EXIT_FAILURE;
 			}
-		} else if (!strcmp(argv[i], "--vm_partition") || !strcmp(argv[i], "-vmp")) {
+		} else if (!strcmp(argv[i], "--vm-partition") ||
+			   !strcmp(argv[i], "--vm_partition") ||
+			   !strcmp(argv[i], "-vmp")) {
 			if (i + 1 < argc) {
 				options.vm_partition = atoi(argv[i+1]);
 				++i;
 			} else {
-				fprintf(stderr, "[ERROR]: --vm_partition requires a number\n");
+				fprintf(stderr, "[ERROR]: --vm-partition requires a number\n");
 				return EXIT_FAILURE;
 			}
 		} else if (!strcmp(argv[i], "--bank") || !strcmp(argv[i], "-b")) {
@@ -889,7 +891,9 @@ int main(int argc, char **argv)
 				asic = get_asic();
 			ih_self_test(asic);
 #endif
-		} else if (!strcmp(argv[i], "--vbios_info") || !strcmp(argv[i], "-vi")) {
+		} else if (!strcmp(argv[i], "--vbios-info") ||
+			   !strcmp(argv[i], "--vbios_info") ||
+			   !strcmp(argv[i], "-vi")) {
 			if (!asic)
 				asic = get_asic();
 			if (umr_print_vbios_info(asic) != 0)
@@ -955,7 +959,7 @@ int main(int argc, char **argv)
 "\n\t--gfxoff, -go <0 | 1>"
 	"\n\t\tEnable GFXOFF with a non-zero value or disable with a 0.  Used to control the GFXOFF feature on"
 	"\n\t\tselect hardware. Command without parameter will check GFXOFF status.\n"
-"\n\t--vm_partition, -vmp <-1, 0...n>"
+"\n\t--vm-partition, -vmp <-1, 0...n>"
 	"\n\t\tSelect a VM partition for all GPUVM accesses.  Default is -1 which"
 	"\n\t\trefers to the 0'th instance of the VM hub which is not the same as"
 	"\n\t\tspecifying '0'.  Values above -1 are for ASICs with multiple IP instances.\n"
@@ -1068,7 +1072,7 @@ printf(
 "\n\t--power, -p \n\t\tRead the conetent of clocks, temperature, gpu loading at runtime"
 	"\n\t\toptions 'use_colour' to colourize output \n"
 "\n*** Video BIOS Information ***\n"
-	"\n\t--vbios_info, -vi \n\t\tPrint Video BIOS information\n"
+	"\n\t--vbios-info, -vi \n\t\tPrint Video BIOS information\n"
 "\n*** Test Vector Generation ***\n"
 	"\n\t--test-log, -tl <filename>\n\t\tLog all MMIO/memory reads to a file\n"
 	"\n\t--test-harness, -th <filename>\n\t\tUse a test harness file instead of reading from hardware\n");

base-commit: 7a56fe819d76884a68c31d34e56f9e7c462da351
-- 
2.39.0.rc0

