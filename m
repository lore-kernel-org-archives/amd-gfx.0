Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B607C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 02:19:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 197116E3EE;
	Thu, 25 Nov 2021 02:19:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66B4B6E3EE
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 02:19:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrSbOJsbmWxzf6sTBkvhECzqfrSHZRAGdOy1XkbqGSIl3xdcwWRwcbedKm0rbjs4wpyBL7hKoSKbma3uYPp2y4MZ/tZ9TOiotHt9ZnU0wHZyWNQz/OTULiPujyLgkvjirXqRr5R6JXCQ/ND6bvxzAuqxqzpfZmgoWBpULgYl/BeiXbMngmUF3xbO/qtmdqmOkOQ2oG5G9itkTQsuSK2OqYrZJKR69u6Zsn5biVySGGRA3mO5gUNIAOGe4S9DuO8vNCSRkFwM/qGzVbInmQccodxhljzhj4B+VEN7ADw7Z9lqSGMPL5N0Fbxf71pIl9i5wnzNHDZpgCuc+pnM8nfQfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5tW7CsnZHi5yQTlVGSVUf9XpdKGnVOLF6Icx0jhxJQ=;
 b=CuIBTADl+VV+QuNeIkg3XpnQ86BL0DeBxRous4rv0TnqoVtlgdpgF1aLJKk0bPJXJcyYnW3cEwtzWlIdxWPJuEA4NLcNIKAYKajxSrG/P7i3S3Zs5721x1gP/cSIn2WUnMb9250GZK22AEWGI9g70FiMo5OR6TEbVAZMbXGI5Vfb3APwjDQ4SCAv/XmaYgnvFrHc9jGDEMIePTrvALcyT4Kek0aKLem0rzPa7NKMjS6SBjuKgpUotwNpjWxTeY+WXpURVpcFaLQEO/eucjqpqAjhyl+YKcHYy4XV19Acp3jujvKTLExOigyl540acDS9NRjMnLp1OM6jRIofCd9wTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5tW7CsnZHi5yQTlVGSVUf9XpdKGnVOLF6Icx0jhxJQ=;
 b=ca1B6EjrTe1+yYShVYMUfIZiTj+QmqJunlVJo+pKDn/6TXKxXjViAZkaQrq8iE4lFvmiiB9UOzGNpQH7biFmIDY7+oJA671ikulElprbvRo8vpadhAaAa5R17cycNMkY0jhBmXumXeLr5BGdfV1pp/oj9yczgJRQcrSI5/8+cPM=
Received: from BN6PR19CA0053.namprd19.prod.outlook.com (2603:10b6:404:e3::15)
 by BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 25 Nov
 2021 02:19:41 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::5b) by BN6PR19CA0053.outlook.office365.com
 (2603:10b6:404:e3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Thu, 25 Nov 2021 02:19:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Thu, 25 Nov 2021 02:19:41 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 24 Nov 2021 20:19:40 -0600
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] amdgpu/pm: Create shared array of power profile name
 strings
Date: Wed, 24 Nov 2021 21:19:24 -0500
Message-ID: <20211125021925.7881-2-darren.powell@amd.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211125021925.7881-1-darren.powell@amd.com>
References: <20211125021925.7881-1-darren.powell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c5e97a4-1520-4868-028a-08d9afba09af
X-MS-TrafficTypeDiagnostic: BL1PR12MB5286:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52861774B7BE5D163D0D73EFF0629@BL1PR12MB5286.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EeeIXQwVdWegN0pX+f8AGySZfvQ4q/9t2P6zo236x9TuFO7FLnHuDynvmbxhkbWybQfYWAfplhezBI/tV+9SakMcn24m5bjPNVK7c/Nees2aY8u/WWJ/Z3rGh3xiiyB4objoP5gfFAHuhERU5lsR3RhX04388dNwD4AiLdp530jvW5+MeqiWDxZqjjh0HI5F4zW1r2Kv6ROqJbcMuy3rSEFkCph+Nne5A/jW0YQLxE62UWylEyuvUgHma/nXBSg3ykxynfP/b0QuNMzoMiy7lkJBzMOxpjYC43qg+GFStCzs0ynyLpl9cNNg9XqlFyiXJyHW5st/cg81oieyPVUEomRgo+LnYdxjUydR8aWou0t7VlxzJJJSTOy+9u2Soh+TDtcsHhEqhOjt+gm/IgcAaDxeKk66ONk6VMXrTZ9cc2Z8Jk15xN8R+esm6gMAk58AHoDPX91WrpDxguIEnOXCuuUg99RiI5kfPvhxXwtmkPn/YxrXOvkwzEAuNBmwZWzWX9f8zKlpXY6/9yKCCHQkcUdOWdP7rAIw8HTmahTUkOrbtG/sJOtjl2yU2jRcoTe/o7gRzaf4MZBxa/EuoL1gKCEd3iSaC/My5chBzambsxMY3a8tPzHuSnYjIwtGTwt4lXnX8RCQEYBZ7zeZVaCOfMJ+Je59tAtoVh7k3WW7wfGASbMVsq/P6Y/+kDEEAbJzXbK0P5Hqt3DEWYfF85ncibvxbfHx2RTp0NZ+Y4BGC28=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(356005)(81166007)(83380400001)(6666004)(8676002)(44832011)(36756003)(2906002)(5660300002)(36860700001)(1076003)(4326008)(7696005)(508600001)(316002)(8936002)(6916009)(2616005)(70206006)(336012)(86362001)(47076005)(16526019)(186003)(426003)(70586007)(26005)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 02:19:41.0448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5e97a4-1520-4868-028a-08d9afba09af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5286
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
Cc: Darren Powell <darren.powell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

 == Description ==
 All the power profile modes use the same strings (or a subset of)
 Creating a public array of the strings will allow sharing rather than
 duplicating for each chip
 First patch only implements change for navi10, followup with other chips

 == Changes ==
 Create a declaration of the public array in kgd_pp_interface.h
 Define the public array in amdgpu_pm.c
 Modify the implementaiton of navi10_get_power_profile_mode to use new array

 == Test ==
 LOGFILE=pp_profile_strings.test.log
 AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
 AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk '{print $9}'`
 HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}

 lspci -nn | grep "VGA\|Display"  > $LOGFILE
 FILES="pp_power_profile_mode "

 for f in $FILES
 do
   echo === $f === >> $LOGFILE
   cat $HWMON_DIR/device/$f >> $LOGFILE
 done
 cat $LOGFILE

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h  |  4 ++++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c              | 10 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 10 +---------
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index bac15c466733..5c0867ebcfce 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -153,6 +153,10 @@ enum PP_SMC_POWER_PROFILE {
 	PP_SMC_POWER_PROFILE_COUNT,
 };
 
+extern const char * const amdgpu_pp_profile_name[PP_SMC_POWER_PROFILE_COUNT];
+
+
+
 enum {
 	PP_GROUP_UNKNOWN = 0,
 	PP_GROUP_GFX = 1,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 41472ed99253..b47d4140859a 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -82,6 +82,16 @@ static const struct hwmon_temp_label {
 	{PP_TEMP_MEM, "mem"},
 };
 
+const char * const amdgpu_pp_profile_name[] = {
+	"BOOTUP_DEFAULT",
+	"3D_FULL_SCREEN",
+	"POWER_SAVING",
+	"VIDEO",
+	"VR",
+	"COMPUTE",
+	"CUSTOM"
+};
+
 /**
  * DOC: power_dpm_state
  *
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 71161f6b78fe..020f596baed2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1710,14 +1710,6 @@ static int navi10_get_power_profile_mode(struct smu_context *smu, char *buf)
 	DpmActivityMonitorCoeffInt_t activity_monitor;
 	uint32_t i, size = 0;
 	int16_t workload_type = 0;
-	static const char *profile_name[] = {
-					"BOOTUP_DEFAULT",
-					"3D_FULL_SCREEN",
-					"POWER_SAVING",
-					"VIDEO",
-					"VR",
-					"COMPUTE",
-					"CUSTOM"};
 	static const char *title[] = {
 			"PROFILE_INDEX(NAME)",
 			"CLOCK_TYPE(NAME)",
@@ -1756,7 +1748,7 @@ static int navi10_get_power_profile_mode(struct smu_context *smu, char *buf)
 		}
 
 		size += sysfs_emit_at(buf, size, "%2d %14s%s:\n",
-			i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
+			i, amdgpu_pp_profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
 
 		size += sysfs_emit_at(buf, size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
 			" ",
-- 
2.33.1

