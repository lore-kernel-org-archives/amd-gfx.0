Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A360EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 14:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E48210E4BA;
	Wed, 19 Jul 2023 14:53:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D939210E0AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 14:52:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwC8GZmSm/oIjq6SDJit4NAoHEoL8Fn7PBJ/JBdnEL+B+65E86In4rD1hzP79fvpyMc+vMXgQLqRHlSpl96kA92fWSN2gle6HLmqx4quUfgfwpYsi3qsUzkWYndLOmAsn4i82teOVXVuXdBj9FiyDZDxjK5VoWHRlqpW9bcKWvQMVHHFuxfPmsgvHmO23zxREpQgnmfdqACfH8N9EYfWSaL/CGmRj5d+1ypXTvtJfLlWEUwhswoGB2KlQYVVaAZYw0xFFZjWY4N2GcKtNS9KO1Qvt3zs1TrV2oLgfA/2FKIbokz7ZUEgVTa7bLKZADp+1l4Td42TwQaWlENTL/f2nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBiNQSucjJvq6q1EJanzaZdKk6tbwtIs3APn8vxnoMU=;
 b=XtQyY39FWrVWvN8Ppe4pPeW9yE6hfUHKJpLvl+HAoeDnt23aiGFLQzgk8SKN3MIzz/XeLZlAfEq0UwffE0BI9coaLWKPM6JO9SqbKd/bbnoGKl7yMUXkXPuC4Y4xTnuKHK6JStGbYK/8ooQxbm2WoyMdSu5Z0zaErJJqMPXJ2vL5WeM2YNgfcJVAe1Kw4GS+fwsUbAfv0o8O9dSv3grCpSlI1L+D6QnDQ/Q5HUzQ0KTIjg+afVvuMieq1xtM+0XEIl5t46c25cWQLXiJNKYudAX0X0P0WQscbsl2//RVAxv+OyELM0kCS5R1KdtHuXuBIWNoQK5NxhUAG1sAKZuwbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBiNQSucjJvq6q1EJanzaZdKk6tbwtIs3APn8vxnoMU=;
 b=kt2tzjM30qFMlAJMnrecmai6rPc1B3Eql42QnYpuoD4GzDaBayDOTj+V3ZV9bx2DMZw9PqmOU0GAnk8OHBIrA5Ct1FOyeGQgIbyWZxYAEF/tGkbVaa3Vm0X9wuyO2BYLYypcJzHTYcMwmQJq66vOhgZSZA3WHJ9P6Acjva2O73Q=
Received: from BN9PR03CA0911.namprd03.prod.outlook.com (2603:10b6:408:107::16)
 by SA1PR12MB9248.namprd12.prod.outlook.com (2603:10b6:806:3a3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 14:52:55 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::c0) by BN9PR03CA0911.outlook.office365.com
 (2603:10b6:408:107::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 14:52:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 14:52:54 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 09:52:54 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Fix infinite loop in
 gfxhub_v1_2_xcc_gart_enable (v2)
Date: Wed, 19 Jul 2023 10:52:08 -0400
Message-ID: <20230719145208.3769-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT022:EE_|SA1PR12MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: ed5a4d61-43c3-49a1-d38a-08db8867d599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NdDMXO6khG38t1Eb1Ir2/JSW2a4hjvDoFsS+phTec0R5KXW/55c4hUf3qks8gNugM1TntOwDm4I2yn03eYwqZNqFt5pvfTIQ02ob40th9S94ktUXTfSKEbUZDyb7RCnAhxhhO+mlpevBjYFhCZLttQOdueMMcUCh8MP8TZPTSfI2nhxDRqlyCn9qwsjnrPnM2Bdy5MCPGDjNv25n6O3T8Le8EuZXOfW+OV0qoHduHzDZdo1J+wXaWC49wcaE1OlS397HJosVx5icRDVKpsHZZqm939rmqyjThnPcvaUko7wssLxH/hbe7UTO4zs2HTnA0lVo1VVneB9vJ3E+51gQCPvuIO7gDmpGwjpYc7xOPdX6wN2cXSeAbAeieMgkEe7eNe1jgd8ZWH8f7EJDyTDwx/5eRgPxwVaimK5usk6IhS5TexPTb5+Ck2yDybbXwbb5G2ND5HV9hM//dnYoCSlvrQRVvwWq3GN69B2iCcglZcPcrh/nCoT9p9nWq1Mib9G0CFoqcaP46p10QbaYlU+E9c5I8zjPC52Qn/UXyb6/FFoZWLNLbJ1pqbLcbnWDGckf4UA/s81xUoFzWVE7vhCv3qyuhHi5eRL6e6L3SfHpiP3umBoNcGUYnIzabZ1HEAXOeLM+ZQnlCBXEtYlhjvfoNBUELEetkyzgoHZctDvzlHInYH/L+RNYqAFeLiGEb3LwX8IkZ6gdwdBAD8P41/XCm/irDWUqAjvPwGvXUactdrGZpJg7ZsRl1qO+tFbur6HqaiLQ6zi3qFcmRxE7DIDB8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(54906003)(478600001)(40480700001)(41300700001)(8936002)(8676002)(5660300002)(70206006)(70586007)(6916009)(4326008)(316002)(82740400003)(81166007)(2616005)(36756003)(86362001)(36860700001)(426003)(47076005)(1076003)(336012)(186003)(26005)(16526019)(356005)(83380400001)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 14:52:54.9225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5a4d61-43c3-49a1-d38a-08db8867d599
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9248
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
Cc: victor.skvortsov@amd.com, bob.zhou@amd.com, lijo.lazar@amd.com,
 victorchengchi.lu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

An instance of for_each_inst() was not changed to match its new
behaviour and is causing a loop.

v2: remove tmp_mask variable

Fixes: 50c1d81d6365 ("drm/amdgpu: Modify for_each_inst macro")
Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c |  5 +-
 scripts/package/builddeb                 | 60 ++++++++++++------------
 2 files changed, 31 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index 47f95ec218a3..dbdee1a0aefe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -402,18 +402,15 @@ static void gfxhub_v1_2_xcc_program_invalidation(struct amdgpu_device *adev,
 static int gfxhub_v1_2_xcc_gart_enable(struct amdgpu_device *adev,
 				       uint32_t xcc_mask)
 {
-	uint32_t tmp_mask;
 	int i;
 
-	tmp_mask = xcc_mask;
 	/*
 	 * MC_VM_FB_LOCATION_BASE/TOP is NULL for VF, because they are
 	 * VF copy registers so vbios post doesn't program them, for
 	 * SRIOV driver need to program them
 	 */
 	if (amdgpu_sriov_vf(adev)) {
-		for_each_inst(i, tmp_mask) {
-			i = ffs(tmp_mask) - 1;
+		for_each_inst(i, xcc_mask) {
 			WREG32_SOC15_RLC(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_BASE,
 				     adev->gmc.vram_start >> 24);
 			WREG32_SOC15_RLC(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_TOP,
diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 67cd420dcf89..c5508054bfc8 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -164,23 +164,23 @@ if is_enabled CONFIG_MODULES; then
 		mv "$tmpdir/lib/modules/$version"/* "$tmpdir/usr/lib/uml/modules/$version/"
 		rmdir "$tmpdir/lib/modules/$version"
 	fi
-	if [ -n "$BUILD_DEBUG" ] ; then
-		for module in $(find $tmpdir/lib/modules/ -name *.ko -printf '%P\n'); do
-			module=lib/modules/$module
-			mkdir -p $(dirname $dbg_dir/usr/lib/debug/$module)
-			# only keep debug symbols in the debug file
-			$OBJCOPY --only-keep-debug $tmpdir/$module $dbg_dir/usr/lib/debug/$module
-			# strip original module from debug symbols
-			$OBJCOPY --strip-debug $tmpdir/$module
-			# then add a link to those
-			$OBJCOPY --add-gnu-debuglink=$dbg_dir/usr/lib/debug/$module $tmpdir/$module
-		done
-
-		# resign stripped modules
-		if is_enabled CONFIG_MODULE_SIG_ALL; then
-			INSTALL_MOD_PATH="$tmpdir" $MAKE -f $srctree/Makefile modules_sign
-		fi
-	fi
+	#if [ -n "$BUILD_DEBUG" ] ; then
+	#	for module in $(find $tmpdir/lib/modules/ -name *.ko -printf '%P\n'); do
+	#		module=lib/modules/$module
+	#		mkdir -p $(dirname $dbg_dir/usr/lib/debug/$module)
+	#		# only keep debug symbols in the debug file
+	#		$OBJCOPY --only-keep-debug $tmpdir/$module $dbg_dir/usr/lib/debug/$module
+	#		# strip original module from debug symbols
+	#		$OBJCOPY --strip-debug $tmpdir/$module
+	#		# then add a link to those
+	#		$OBJCOPY --add-gnu-debuglink=$dbg_dir/usr/lib/debug/$module $tmpdir/$module
+	#	done
+
+	#	# resign stripped modules
+	#	if is_enabled CONFIG_MODULE_SIG_ALL; then
+	#		INSTALL_MOD_PATH="$tmpdir" $MAKE -f $srctree/Makefile modules_sign
+	#	fi
+	#fi
 fi
 
 # Install the maintainer scripts
@@ -220,18 +220,18 @@ fi
 
 create_package "$packagename" "$tmpdir"
 
-if [ -n "$BUILD_DEBUG" ] ; then
-	# Build debug package
-	# Different tools want the image in different locations
-	# perf
-	mkdir -p $dbg_dir/usr/lib/debug/lib/modules/$version/
-	cp vmlinux $dbg_dir/usr/lib/debug/lib/modules/$version/
-	# systemtap
-	mkdir -p $dbg_dir/usr/lib/debug/boot/
-	ln -s ../lib/modules/$version/vmlinux $dbg_dir/usr/lib/debug/boot/vmlinux-$version
-	# kdump-tools
-	ln -s lib/modules/$version/vmlinux $dbg_dir/usr/lib/debug/vmlinux-$version
-	create_package "$dbg_packagename" "$dbg_dir"
-fi
+#if [ -n "$BUILD_DEBUG" ] ; then
+#	# Build debug package
+#	# Different tools want the image in different locations
+#	# perf
+#	mkdir -p $dbg_dir/usr/lib/debug/lib/modules/$version/
+#	cp vmlinux $dbg_dir/usr/lib/debug/lib/modules/$version/
+#	# systemtap
+#	mkdir -p $dbg_dir/usr/lib/debug/boot/
+#	ln -s ../lib/modules/$version/vmlinux $dbg_dir/usr/lib/debug/boot/vmlinux-$version
+#	# kdump-tools
+#	ln -s lib/modules/$version/vmlinux $dbg_dir/usr/lib/debug/vmlinux-$version
+#	create_package "$dbg_packagename" "$dbg_dir"
+#fi
 
 exit 0
-- 
2.34.1

