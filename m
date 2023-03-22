Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE93C6FD1F
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Mar 2023 09:16:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B81410E8CF;
	Wed, 22 Mar 2023 09:16:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C7DE10E8CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 09:16:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cs0uGzE8m8PtYG1Fc1tIMr5OSKovm1FyqB15QoSiXXPnR4wuTeoqrys4e/5odislIoPwhpA8Uj00rVB3lHiQndnV/Zb1ZnX3J91r5WjWRBcVrQ1VGBQrMaKBsTckpPZFdS1Q9JBFUCNbaR/1OAwrgncYi/q3PUbqojJcqdsi2z8S9OWgAl+FRd4dHerxKluIfLoRU4DdvIZKYRYmHdejrEqIhZWj3VjItzjGP22ZVjgfh1rE6gvjp1wMMoKrr+VaGSpXttV7BBa7xOPxB8rA2A6nMep70m/ufLzm/YNjSwcxqNca3hHnrvGuF6rxrJPXkxITIFvAcR+/lHkVx4w74Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJb4EaEge8xromOgCgEIk7V9MdGZCIR7p1J8/P4YPPs=;
 b=W/7hWR+DSzOjwLLgK1saqnndG1uVQIHtfUqIwidGbimXsgSRTSBxCqeLdwwnS2tIMSv3Lk03BE42kWUE+Zefp5KJXrheapJ3vc7RLhCJkBb9c/0y79pcB+G5jS+mPHfCemYP3fIKJKMG+RUFs54pk/9CvL04PclYYYICf2FVCxhtoSJdivEwESs80WEPTwW3E7AItfKpDfKGZctn7m7Ooqc9tkF4XtEDzpP9ZIxmJ1I1zhc1Fx/ynkHCSRo21ACZcrfWijuwwIt7j+WZl+eKJlpLjppsLiVfcebbFmuePAvn2bOBS2oDRPkbLLVG35PPyIli0IWsNQY7E9LHVAynzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJb4EaEge8xromOgCgEIk7V9MdGZCIR7p1J8/P4YPPs=;
 b=Vt4UCEA1TLV+RniY9AgQJaYj42h8nkHrQwonjKTcJM7tgw9jufnlsKxA+ZWCp7Kg2ukDiWFFD9C0hjsBUI+Mob5h0+qzeI3WIqwNr0rRRHIA6MrXHEaHu4vZmxQRxQPhV2rr8E2HWK+/4Ws0lBkJddQiR9Rlusj1xBzs7XaaK5g=
Received: from MW4PR03CA0153.namprd03.prod.outlook.com (2603:10b6:303:8d::8)
 by SA3PR12MB8000.namprd12.prod.outlook.com (2603:10b6:806:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 09:16:20 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::1d) by MW4PR03CA0153.outlook.office365.com
 (2603:10b6:303:8d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Wed, 22 Mar 2023 09:16:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Wed, 22 Mar 2023 09:16:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Mar
 2023 04:16:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Mar
 2023 04:16:18 -0500
Received: from archlinux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 22 Mar 2023 04:16:16 -0500
From: Wenyou Yang <WenYou.Yang@amd.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>
Subject: [Resend PATCH v1 1/3] cpu/smt: add a notifier to notify the SMT
 changes
Date: Wed, 22 Mar 2023 17:16:05 +0800
Message-ID: <20230322091607.1609145-2-WenYou.Yang@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322091607.1609145-1-WenYou.Yang@amd.com>
References: <20230322091607.1609145-1-WenYou.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT004:EE_|SA3PR12MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: adba83e0-e4ae-4852-e8e1-08db2ab61967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hqfDfgyt02Rw72deWkxNOlJILWwAOdgr7du0PKskeiAFMs/tTwqMwX5lh41DkoJMHQiljVI2zlYFUwn98z57YD3mf6Gd3fh7gp7UFQu+/qtQAjRDAQkcJqsOlEQl4KlHTuRHMMIBXdfmPHKnFFsQEznTTyGF4QlWrysTnOIqteQ78WI+W8QlPm3az4uuwKbD5mOvaRoZTBGBbpAcdwGvtZlSSqK1fepwmNIPlh2/Xz2nswC/EmOFqAvCx+8exy1/XeEo8JX0mQcdajxxeDFADKW65xfJLMpp9SdeE0NWqo/NqXWUBDq1cqfwUfPTLsRwJUq5uZMFlMZO7YrJaPicgGRIB53XX59/UPBo4offhZeIMlaotAea7fwEUJtFK1Fz0rRfkKT35bzPqVTEEb3iKdwnvEHSuNd6mPz0O9ME8RydFnfvbxztkkONXHG6kkHioMP+fD3t1EroRBobLbbLhR07GJn7duee320uQWHrGcT8K1V6A1re0VBvn4Y3YVjCk8qT4ZveCd07rsIRcSrUizfHwxEbGrYh5NPExXPSguXku5NFCN+zLWqHZFcTXGwzA6TLHVymCLJ3zJTkOwBRyTXJcWUR2NVB3Zit14emP5H4/c/l0jkJvQwgyGu8Fkpg5z27TmGUHMKnDDZw4Wb5bWTfWonwIymwir3kVrjZ5xRM4nbTk6OCgxz+nxapkm5/FE7i0rOmMpgkBW9MfFoNYNFPlYj3geut0tncS2Tm5fs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199018)(40470700004)(36840700001)(46966006)(2616005)(110136005)(336012)(26005)(47076005)(1076003)(426003)(6666004)(4326008)(316002)(70206006)(83380400001)(186003)(54906003)(70586007)(8676002)(478600001)(6636002)(36860700001)(41300700001)(8936002)(5660300002)(81166007)(2906002)(82740400003)(356005)(7696005)(82310400005)(86362001)(40480700001)(36756003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 09:16:19.9993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adba83e0-e4ae-4852-e8e1-08db2ab61967
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8000
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
 Wenyou Yang <WenYou.Yang@amd.com>, kunliu13@amd.com, richardqi.liang@amd.com
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

