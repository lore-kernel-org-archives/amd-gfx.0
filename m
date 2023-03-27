Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B9DC761AF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 07:25:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D27E10E24F;
	Mon, 27 Mar 2023 07:25:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BBBD10E245
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 07:25:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T60VS/gILTKejYhe4cl6w6c7bKuKmihSI05g8ZYTtB9pblFMtgTuRy+O4fJ3olR/iQPPGwJ7utiuFnTE+pLxTKrBhQSH1rQC0P9v+CzXJxO12vAvFBnldSEc+7bRcCqfQOHVZyhD6RT4fKu2eJooFk2Hj3pY+JxJ/DFt2YrHxWpmGsb1oDh5aFe0ufdWIMGdcEt11bWz3ZsqgZ1NaW1I2SKUMA1JM9yqz/oOx73Uo1jiZYCBLSF+QaB1tnINOKBZJcoOMvwOI9DlX3b5Sd9hlK7ORTWVNEQiNhs8yoVr6hgyPStVh1jRs9UJqUrFYXq9TLiHyAMmOPASW+1DvXC42w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpPRzCVoU8SBia0TGgRHF/JJ9H0otrGk+VZwN8hLMXk=;
 b=U1xUTHN1UPKUR75Ti8Emepxj/OKCbMMYe+67OM6b+WLstl8z0vzzEnioHpYwOoFgH8MJFqr+QtR1pkKl5tHP3QvSI4FDdIggSyarvms0NP8MT0zGnMLT3qviWl61HNgHFwleFboAtmLI9rdUVL0AeWza+d9pZ62SZL6C2YQNXo8KutI00F8wNp5m3l85LCYMpIpx5jFptCFfiwGnKxzKoIB9/cXYUY/vKaO2q5To8Yj1R73sljYEipoDY00yBb8BeOsrCrXUKO6PYEOH3xjz9snuIq/S8aHEWMFtRTG+7C5tY1Z5/qt13abwU6xmvgE84lUnuaZ11i+vhXD0YD6DiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=igalia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpPRzCVoU8SBia0TGgRHF/JJ9H0otrGk+VZwN8hLMXk=;
 b=UQoLBS868JDkOCI3H6+ck09qmEFUPgrBS9ubWcS7d37o64x3uQORRF7WJGFuDamUsQSa8VdMSHaAXglfzWNMkKUrPa50yvnFmTH0mCIRV7iw3/3YFYAqhkfAcpc9Tx2uwwCvK1rdDy3CNok1k+iH8fUEXFthjfn0ONtllDQt1GE=
Received: from MWH0EPF00056D07.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:7) by DS0PR12MB6392.namprd12.prod.outlook.com
 (2603:10b6:8:cc::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 07:25:02 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::209) by MWH0EPF00056D07.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.9 via Frontend
 Transport; Mon, 27 Mar 2023 07:25:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.21 via Frontend Transport; Mon, 27 Mar 2023 07:25:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 02:24:59 -0500
Received: from archlinux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 27 Mar 2023 02:24:42 -0500
From: Wenyou Yang <WenYou.Yang@amd.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>, <evan.quan@amd.com>, <mario.limonciello@amd.com>
Subject: [PATCH v2 1/3] cpu/smt: add a notifier to notify the SMT changes
Date: Mon, 27 Mar 2023 15:24:35 +0800
Message-ID: <20230327072437.580766-2-WenYou.Yang@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327072437.580766-1-WenYou.Yang@amd.com>
References: <20230327072437.580766-1-WenYou.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|DS0PR12MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f4b48b-f910-43ec-520b-08db2e9460f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YEs2/HC2ULEttcgJXLXHxsk+tPmuogevUk9Rr58+R/6khOBiRlQgrsZs45PeqYV2L5AJpTjelNYbcMSJa3JfpZvsS0cEqONbbvgzf6X5Wt3b9MfL7+vJQFzI5rxOt4it9Zs+qk554DVMtmhB5WdhjOya73+RIq5Gg+1z1I7qMXLXt29JMUlNXf46k8deKLhb186azBfPgofS1oESaIjPEIbIytJxiH3O1sbnV5zkAUhOae6uc7l33QTr2r88N8SP3m8WP6c92fR7xtiiBhXmMW2Vcx+xvYC7gZjD5GVHCR/oIjsVIrPb+7Xmr9No1C+oZksqxEDScFQKEcmd/5k3laa2/7iWxaxoQ/VUYNxe5o3pemvV+4g2u7ujO128cUj/XBMyExs3vdzTcU+1cg4kyTk0rTNXuRHMJIMpmInw7KDo3M4FNIEkCzJMIRE3RYT4FVj20avhVgUO7+2ClPUw6POk1z3go4x22XPhovbHD7STxXkV4W+1374ZpWr6OLlGg5uOC9/pPIGp07s9q1dfzivKx4b2IovXGKwnzI5nGXz+gcFPt7c5L6XL9Cwp2AwgeLirX1O1K8lG26K3R94oWOqW3zC2eKMY33JomzyobZsJd6jtGBuIiSS3xghKXD2fn9oog+rVXceNW3Pl2l4P/kemqUBinwtvGhg8Olw+MbXPKVrEDf7uKL3ZVHfLpltZLluIVONEF0/vF1lVgMQVN/vjGy2zz5Nl9GK5mzca3y8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(1076003)(26005)(40480700001)(41300700001)(6666004)(186003)(7696005)(2616005)(83380400001)(426003)(336012)(47076005)(478600001)(54906003)(316002)(110136005)(6636002)(36860700001)(40460700003)(4326008)(2906002)(8676002)(70206006)(70586007)(81166007)(82740400003)(356005)(36756003)(82310400005)(86362001)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 07:25:01.7803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f4b48b-f910-43ec-520b-08db2e9460f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6392
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
Cc: weiyuan2@amd.com, ying.li@amd.com, amd-gfx@lists.freedesktop.org,
 Wenyou Yang <WenYou.Yang@amd.com>, gpiccoli@igalia.com, kunliu13@amd.com,
 richardqi.liang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add the notifier chain to notify the cpu SMT status changes

Signed-off-by: Wenyou Yang <WenYou.Yang@amd.com>
---
 include/linux/cpu.h |  5 +++++
 kernel/cpu.c        | 10 +++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 314802f98b9d..9a842317fe2d 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -213,6 +213,11 @@ enum cpuhp_smt_control {
 	CPU_SMT_NOT_IMPLEMENTED,
 };
 
+enum cpuhp_smt_status {
+	SMT_ENABLED,
+	SMT_DISABLED,
+};
+
 #if defined(CONFIG_SMP) && defined(CONFIG_HOTPLUG_SMT)
 extern enum cpuhp_smt_control cpu_smt_control;
 extern void cpu_smt_disable(bool force);
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6c0a92ca6bb5..1af66a3ffd99 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -89,6 +89,9 @@ static DEFINE_PER_CPU(struct cpuhp_cpu_state, cpuhp_state) = {
 cpumask_t cpus_booted_once_mask;
 #endif
 
+RAW_NOTIFIER_HEAD(smt_notifier_head);
+EXPORT_SYMBOL(smt_notifier_head);
+
 #if defined(CONFIG_LOCKDEP) && defined(CONFIG_SMP)
 static struct lockdep_map cpuhp_state_up_map =
 	STATIC_LOCKDEP_MAP_INIT("cpuhp_state-up", &cpuhp_state_up_map);
@@ -2281,8 +2284,10 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 		 */
 		cpuhp_offline_cpu_device(cpu);
 	}
-	if (!ret)
+	if (!ret) {
 		cpu_smt_control = ctrlval;
+		raw_notifier_call_chain(&smt_notifier_head, SMT_DISABLED, NULL);
+	}
 	cpu_maps_update_done();
 	return ret;
 }
@@ -2303,6 +2308,9 @@ int cpuhp_smt_enable(void)
 		/* See comment in cpuhp_smt_disable() */
 		cpuhp_online_cpu_device(cpu);
 	}
+	if (!ret)
+		raw_notifier_call_chain(&smt_notifier_head, SMT_ENABLED, NULL);
+
 	cpu_maps_update_done();
 	return ret;
 }
-- 
2.39.2

