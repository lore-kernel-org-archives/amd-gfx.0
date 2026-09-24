Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FD9C98304
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 05:18:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D98110E9B3;
	Thu, 24 Sep 2026 05:18:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aBbMOHxZ";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FB8210E9B3
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 05:18:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mx05yaiYhMryI7ukSAjzABdtpsGBThqG2aC3FPFo/1huam0hWirJ+NdWUHVr7RvqK8/bBsLDJalgB4S6ZKlv++Lx23rA6eE/oYgMEjWHuPkOa49C0aZzh7gk09JNoxlr5UJ9PHYDljbhl7jU8A4pio41fhOeQHhfVKl4H7WBWACF2ZSlBwwMfbUYCcs6cFMux3IaEuAOIBnaQpVpvlPWFKBnNv2wKJvewskGn3hefUhoW7od5RPoNKzqXWQ9h2HTtPG3VglOdhlPozbPjr891pAls2gOZ/U7XspK1LeXXsdxdkaDehJ638UTls/qFTb6wJne7ff4G8a4q5QO3GY0fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfhkHsJzuJ7bJ4DBOPiePYau8/7Ie2JN0c9JVruOQhI=;
 b=UJ0vD86qUMy6xxsLU+iP4HtqC6fqbpkGPkAIPftpjXxv6IP14VYcD2knUGahD71z2Gj0wJKprROaGfAEdTrXuQwoAQ/j9SmsY8CBEK0r95pOsLw/RUJTQ2T+VwHnPoivjyDopMugr+K2b8nWSiolqp/RnRIg7A8d7eu/g1jHGp7H/CYjrTwAld/FAgxU0umrkrMWsVe8ZVYyuBA1E+Uu+o8HA2KLi/UP8WG7e3oyULUrpSKGcqjx53DIH+3Da5IIOsbupZLA/Sswt50NBQv5GLurPlGKXMJUV26MQL45TA0cTIxuix7XwOgES1LdVRAeZ8xxVwo6cN2MjEhodW4fgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfhkHsJzuJ7bJ4DBOPiePYau8/7Ie2JN0c9JVruOQhI=;
 b=aBbMOHxZAEIau7YR3YIuQQwuiEb+n5Zz4W/MAFUDxZs3dLqF3Cjvb9TZGMS4IDp2rOWtDwZMys50AbuDiEBOv8ETUT6GoOtaEnF8fvXPLU8xvPTw+w3RE3Sj7g8Rh1zpWbpp8eogcGBu4LaqHIqyU5xHxZze0eKU1eojnkZp8yE=
Received: from BN0PR03CA0037.namprd03.prod.outlook.com (2603:10b6:408:e7::12)
 by DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 05:17:55 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:e7:cafe::1f) by BN0PR03CA0037.outlook.office365.com
 (2603:10b6:408:e7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 05:17:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 05:17:54 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 00:17:52 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, Asad Kamal <asad.kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Fix metrics formatting in SMUv15.0.8
Date: Thu, 24 Sep 2026 10:47:36 +0530
Message-ID: <20260924051736.2567772-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|DM4PR12MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: c6a82589-4191-4558-9970-08df19fb3016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|11063799006|56012099006|3023799007|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: KyFdTvrVTZ5snYFOgS1I/FFReaIcAlRkriffsnV4G+nrSNo5mssvz6a5V1E4TpK+PbwT8hVS2sbOgUoL11O8dZ26NiAa/ito5tpGrwhJXONRp1hHnFWQ7UUP2yj0tbHxKpEZR8p96pBHwurUfAaF02OmgVuHmTOKFnJ994BaQWqH4oWTRa8h5K+SvO4n4DaZfj00KljVsr3sjNN5HgwCNhvPrIDaUIOHDl12B+RKQOM04R82yFwyDm6tSUzhLahIS1rh/XqTmEnP2S/5jgarHVqZMEnimbwkCrA3uwAoLgLMNG7UjFWhMb82IkgQlXuoDbqO+MOGROKNUpsTvedYtV6T8yVPB0TlST1O29Ubh0hrBnLzJ9KhEIM1FhuUE0vUtgy2o4ZugOSbrbxqD254QWmT1EDpCPn5TKTZgRmFkkkoPblABrfobuONq0Or6X4rfszl2z+hkVrQk2kwl+6xRT2Bwcrl5FjbvJGSpQsRIeOKm5rqjdR5Ao/FFOFWcEYLFNeamJl/HzKJE9aYwwkkFzJUmVrbk8K4nOuDM4QBdEf6QBseQCY0mseaWQV00spzzv9lKkIp3BG609MbwJ1ATQ4nwL25QqMHKhxi8vhPYvhqR4iPaKl7HxOEto6pFSWq5atxADsW4kz8Q1kExD6iM+g3tVYlEKDuiE4wK/UgMH5XzS5Dad+ZA3AwLSGOAejN1XJaWg+Nxk1qL66tULbMLw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(11063799006)(56012099006)(3023799007)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hdeuzdbSBY8kdLJlWqfqz7fWvaoWjh2HzODme18iPFF5XatW0o2BQhqWr/YB44E1Bq7S0mVrveX4IPo4PG4MxK1Iq990/5/XcpxVhadA3PHDfQjzo0hoprCfLMPEnZAf5/1ul4Nc597SlO7ph+5zF26sJD/pFqlCkCnwdw8b31AW6mceNUAdkKHMlFJ0fdeGqm14EyS94zLIiiPo5/UYjyJK+NB1fcDesUYJHho22OYCFcQ4wLX/9vnyohq0VSzaMYynBdBn8yLt0yQ6lA7051oyOyA4fdhKfnk1FjliJ74RmWpu/LfUss1VeLnHYp3mRQLTGGMK6FbstHZ/aL1gDVub99pev5ABQVig3KvBvAjJSKxqY0D0wkd3M8MbiS0COOaj3gSokujCj3itJ6XfgAp24+gvOsXdIfVMMnTB4q0I1giOYbVJka4sn/6vhIBN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 05:17:54.3757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a82589-4191-4558-9970-08df19fb3016
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6566
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

Use the right formatting for some fields which are encoded in Q10
format.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index a27a5158b9eb..39073a9be8d6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -1941,7 +1941,8 @@ static ssize_t smu_v15_0_8_get_gpu_metrics(struct smu_context *smu, void **table
 	gpu_metrics->mem_max_bandwidth = SMUQ10_ROUND(metrics->MaxDramBandwidth);
 
 	/* Energy counter reported in 15.259uJ (2^-16) units */
-	gpu_metrics->energy_accumulator = metrics->SocketEnergyAcc;
+	gpu_metrics->energy_accumulator =
+		SMUQ10_ROUND(metrics->SocketEnergyAcc);
 
 	for (i = 0; i < NUM_XCC(adev->gfx.xcc_mask); ++i) {
 		xcc_id = GET_INST(GC, i);
@@ -2019,7 +2020,7 @@ static ssize_t smu_v15_0_8_get_gpu_metrics(struct smu_context *smu, void **table
 	}
 
 	gpu_metrics->xgmi_link_width = metrics->XgmiWidth;
-	gpu_metrics->xgmi_link_speed = metrics->XgmiBitrate;
+	gpu_metrics->xgmi_link_speed = SMUQ10_ROUND(metrics->XgmiBitrate);
 
 	gpu_metrics->firmware_timestamp = metrics->Timestamp;
 
-- 
2.49.0

