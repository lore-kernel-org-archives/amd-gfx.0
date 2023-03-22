Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DEAC6FD1C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Mar 2023 05:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 505F210E064;
	Wed, 22 Mar 2023 05:48:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1BCD10E043
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 05:48:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayLvawTc0m+uQAjFNXsPBd6G6mahCKnfJjbRDxMo8soy03buwBV3jSfMQU0RqavfOxmdCv7MMDj14yiakvZavbZilY8FEEEIcefxKneICLjT0ZvVA5JCkeDZu7Ha9tVifQTMa+oLtqcuyn9C5COCbavRR8Sb2bloR9dix9Cogfn97VHF6F2dPEIIjPZ/CM2+NBMNM5oxVoc9muBg3dM8bfk7z+GIsgISguiOJEuU3nsVhNA1MJFfr6LNumhmTp9sJUjSM2/BFreJedmEVPbqeZz8I2uiRdckOWiFKQo2YX1sxi+9Ao0xbRsC4MO044Smo1jB9jWT6OM21r+W8PahAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJb4EaEge8xromOgCgEIk7V9MdGZCIR7p1J8/P4YPPs=;
 b=cGQlSier+R2n7WPAmyyRAqaWBiRBEJFDeD1yvj4xAiJUBvfWqlw0kGy6ZTwEPOvhrN3A3JWiSi7lEcpPtUg7vl1q6HSoR3Iq/R02mW/ojmOM0nCUC/XhkFUNOpDAis/6JjCkUqL9RyiWSm4vAVyyxMh5RO0YHAR0ZTTCIdA49fudUu4vvMsfSy73OMKZ36Ao59eSVZ5tv7knsOhCyTBUhmiJMbM+9VE9UK6ZTF4JxKPtT7+CneLuTEu/4fr81KhRRaebqGLfjBcLJ47REkbd13CPqPXTSM1RmRqLNjmo6iKxvjG6AeuDm3E5I/K+l4Z6MB07yepxSPPJWaJG1aQkIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJb4EaEge8xromOgCgEIk7V9MdGZCIR7p1J8/P4YPPs=;
 b=gazD9LDy+BziuI6dR7KfGYRV86NmJknnTX5YEkY7/A/bdP2PSRFV8wlAS9R/mBNnpGS5WLjGIepEbh0uMqh248G8jmxumrVUMQKQ2rhS+JZBm7Wmh+Q0gHA881zivCts8T8A1OZWsKUzpunVThUD6V2z7HwWKCH/yn1zEab13O8=
Received: from DS7PR03CA0354.namprd03.prod.outlook.com (2603:10b6:8:55::12) by
 IA0PR12MB8085.namprd12.prod.outlook.com (2603:10b6:208:400::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 05:48:15 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::71) by DS7PR03CA0354.outlook.office365.com
 (2603:10b6:8:55::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Wed, 22 Mar 2023 05:48:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Wed, 22 Mar 2023 05:48:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Mar
 2023 00:48:13 -0500
Received: from archlinux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 22 Mar 2023 00:48:11 -0500
From: Wenyou Yang <WenYou.Yang@amd.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>
Subject: [PATCH v1 1/3] cpu/smt: add a notifier to notify the SMT changes
Date: Wed, 22 Mar 2023 13:48:06 +0800
Message-ID: <20230322054808.1555230-2-WenYou.Yang@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322054808.1555230-1-WenYou.Yang@amd.com>
References: <20230322054808.1555230-1-WenYou.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT016:EE_|IA0PR12MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ac54c7f-efb0-4eae-e73b-08db2a990804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z+fGUvEGdDfAF0CgOVINVlYydOB+8ZZUwkE/DStJsPNDjmG+oBksXN9+Dov5aD4wVanOlsS5f3OdivLpsRBt+pjlatISdluoycGj6rjnVb6f9/3kkKD0B8zTc+BJFtCtFWGZnvoPHjH8ZJ3beYcD4uFRi91Jyz7LtioWcg/wT7C7H7tfFHTz9P9yHkjwmUolp5u6+dha4VeGuDBYuK6/slJXEyXbdbquiI2n85VFw+2m4lIBBjKiPIqvWwsWJDEgi99zTnBpsPCIgICtN3oyAKXJYn22Rp94nqoitxdmXQz9SMUQ8Y1HQBf0sxO3I+nUtMMEz5j0boB393RNEDMSoUNQEC5hEDRQBqOTMIXGLJkcW2Z2kLUv/1q8F9Y7UxnPO4W+48gteaNMUuswhXga/KoJjU55GdsMSZk1rUFYNq239gvt5dSeXIa4wgrcsFMLkA4MJ3QW2di4GS7LIcA16gnoj/1CXpcVYs+Va/2Hnq1neUmM6F28s68O38lom5IFObSkhWyIuFbxdqdwoRZQFKZzx8sRxVuXC/v/X9VTn8L1TMbkeU/ldSLA+HcmAGRJNiItKLzZ7zm7Uj7CPDe6pnbFtsWMYVZdMCB95xlZ/o6RPpYmwm8YEbgIl7wK7oTbAtkfBeTBTtgRYAtcsk/xWGDyHug09eD/rx8R9PBCIhivb0nmrUKhU57nlJw5vnYuJIirmEEXlWeDg12ZVajsSs+C9ZtCZ7QPPUxd3nyENZg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199018)(36840700001)(46966006)(40470700004)(7696005)(47076005)(336012)(1076003)(26005)(6666004)(82310400005)(478600001)(316002)(6636002)(54906003)(110136005)(186003)(356005)(2616005)(426003)(5660300002)(83380400001)(86362001)(8676002)(36860700001)(4326008)(70206006)(41300700001)(40480700001)(40460700003)(8936002)(70586007)(82740400003)(36756003)(81166007)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 05:48:15.5177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac54c7f-efb0-4eae-e73b-08db2a990804
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8085
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
Cc: Wenyou Yang <WenYou.Yang@amd.com>, ying.li@amd.com, kunliu13@amd.com,
 amd-gfx@lists.freedesktop.org, richardqi.liang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add the notifier chain to notify the cpu SMT status changes

Signed-off-by: Wenyou Yang <WenYou.Yang@amd.com>
---
 include/linux/cpu.h |  5 +++++
 kernel/cpu.c        | 11 ++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

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
index 6c0a92ca6bb5..accae0fa9868 100644
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
@@ -2303,7 +2308,11 @@ int cpuhp_smt_enable(void)
 		/* See comment in cpuhp_smt_disable() */
 		cpuhp_online_cpu_device(cpu);
 	}
+	if (!ret)
+		raw_notifier_call_chain(&smt_notifier_head, SMT_ENABLED, NULL);
+
 	cpu_maps_update_done();
+
 	return ret;
 }
 #endif
-- 
2.39.2

