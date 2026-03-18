Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64065FED9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 01:01:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA1E910E5E4;
	Wed, 18 Mar 2026 01:01:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sNzrSQQf";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010014.outbound.protection.outlook.com [52.101.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 718ED10E5EC
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 01:01:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGvFJTV1BzAsbUxC5itPzdaAklwHBelRmWhJdYgCHvlIdaNaagNRdn4bXfQ1sAnyxYxQpCi/HA/H2Ew1MVOaQcazF5b+GBPOAxjYzYfVxCnLqO96xC+BCfiYJmTKBrRt8RFRRz1brbw2XIpJedviU8+HIkX71+aBfbYdNZ+KeA54gGgHfn8tlnbCY330EWTshhsWR43pBwBggM8sljoDX0Y1Y++WE9i+YF9a3K7ZppyFdEQHNQhgW4OR74LqoXfjPWIHLxFyC8rCp4zHNzmaMiv/0jaEYlucUJ2YJLNNIFq4b5n9y5XyPixQ2k0KgKa3tw5sEF0uvJaNxVNHP59YvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U97X8D3PzjNxwTW/HJjEobUMjiOwQC/9QoyvZjwFvRM=;
 b=kvrUZ5cL+aWCjvVteYKocAoOdiZxJpf6EquiouRFiLmHKs3egjLoXfTg+fhwexeon0F/J+uCLc1UezUS7PbIJl60GqnIC619VCETR7XUZi1ybhWKS3xXCGgY62bHl3nCVVwmTzq3x2f2q2JJgSOo28sOjYXzGyoEjRNwR80suly/7fytQIOE5PfNgCb0/GSkwrE50toxj677iYFy0nV62D/EKRzq+gdC3S/Zw1o5DeOkuZBFIlcsmm5p1iU7YzqPXsSeRzVIijNurCj31EiNYHl0IIVo/Sq5LinTNR004kF7vwMYA7YB9SaupCVK0U8CTlhS9PZP9ZcV6mF38pSkxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U97X8D3PzjNxwTW/HJjEobUMjiOwQC/9QoyvZjwFvRM=;
 b=sNzrSQQf3cU7V37PKwFeu4coXplnYepPPbk0rkenPnD2XZ67p6VmtNbuON0bADUsMB5JKBWVu1lL8cq14hbSO25UboR68ceiAod5zqqQLUjXIBYPt3rEyxYpK8WGaMQzHVPRSUnAGrqukzRHpSEVci5UEuAqrjy4K5WAml6IRSU=
Received: from PH8P220CA0052.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:2d9::6)
 by IA0PPF170E97DF1.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 01:01:10 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:510:2d9:cafe::b8) by PH8P220CA0052.outlook.office365.com
 (2603:10b6:510:2d9::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 01:01:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 01:01:09 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 20:01:03 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>
Subject: [PATCH 02/31] drm/amd/display: dcn42 don't round up disclk and dppclk
Date: Wed, 18 Mar 2026 08:59:11 +0800
Message-ID: <20260318010224.513094-3-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
References: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|IA0PPF170E97DF1:EE_
X-MS-Office365-Filtering-Correlation-Id: fbf7988f-17b4-4675-b79c-08de8489d767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: aVu0PVwmlfYfoF4ox74livP/7Pe5DuinDyZEDVDktDS0RoJQvQORfABrmlsSnl6irppmaCTQTH//zXmscn66FhOBGVPGF3Ff7kJqCfhLdx0DpuTQ1fnRr6k0R6ZPXqO2uT9ZgbQfnGEZiZjkuhcQFRVLOhfJxHh5VvzEaKmF8t04sjLinZX5dWhu8ATmZhpb76eyDshpMqmWd3tm9oeMKa1l+VuPrIflSMZt3N9yfoEw606BmwZL56v0w78al2z8PiqCEdi+f9FDhBis9o7tpas7NE/eH3ixQn67XUt3FE5qG1i2E8ZTcp0d70Uczr8YDCE2+UV2sOVQlYsF29hNmP8IcTUhO3htZu5G9B7nIl6Ms/z6I/NmNMEplVxaSE9fHXWQxgm67ArcGsS/Jmuof/yXv1bioO+SyOP86zmYT3Y9+GwlM9/ml+epGD4qmq1ph+qa58Wj4bqddeiRbB3uCzkfX8+ivNQaBfnMjw/qmzcTUuWuquG7tmr1NFD3Rkxtim24QATF7noQb8qP1E4gbUAqLJMb4POGFWq7lFJLVQFmOAs84SkzULDx2/nGA8rUw9ge0ZpIiGcT+eZBv0WEIbAiG1h/RmkiBnNVwsXv4+bK6TZt0jL70XsxqMI9e0qaa9fuihnWrndSSIgXviLClxZeCLi3mRDRFREJbE4TGq2FV+i3KCaTYOpWkXovROhkIY8z/cKHeM0n/UUyu/HfIwQEhBpju6oPAUybJsUj50VoxIOgkTTeUdi9v6balqSFceIt3qies5su6dFY6cvBww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hu471p0SEdreM5vAwsSZulpIQza4YcaXrqNzlLm2ITPr3p9EC9Ns6ol9K//YEaSKiuXGnEVRwEih1rBxcC5bMwLkaTlzTaRp7C3IsJa17ycLwAGrvFFvj0Rk49bN0g/NlBxfs4Pwy8Bl1lzbwVAMbGjVGdDjTMR2z5+Wmeo3F6o88cOBV/kv3SHIY/u6w580r3CG0bToMngyOPq/NGrKfHrDhOPi2oFwPA4EXvksM/2d8zFeoa51HA6LlEIXyb7feeARqCGwdckK1OZ4jiOGHRsXKkO4b8vpRvmq1iDNo/uAk04JmNCIn/0Xm+WDH7qc4CBvZfAMwdm0x3doMSQ4elUHFaSKRhkHLj+83Y25PslvKn7aybZNrF2GtYBFQzCVd8ir2n3fRHp2sStTgx/FkZ27EPxVMyemsWBDHkWjHQ/PAqgx4Gwls0nC/RS8CKtf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:01:09.2133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf7988f-17b4-4675-b79c-08de8489d767
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF170E97DF1
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
dml2 based on num_enabled clock != 2 to do clock ramming to dpm.
apu has 8 levels dispclk/dppclk/dcfclk/fclk, but only 4 levels of memclk.
to avoid mapping dispclk/dppclk to DPM clock,
based on arch review, force dispclk/dppclk num_level as 2.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Signed-off-by: Chuanyu Tseng <Chuanyu.Tseng@amd.com>
---
 .../dcn42/dcn42_soc_and_ip_translator.c                   | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
index fd9c24b5df53..1c04171b296c 100644
--- a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
@@ -93,6 +93,10 @@ static void dcn42_convert_dc_clock_table_to_soc_bb_clock_table(
 			}
 		}
 		vmin_limit->dispclk_khz = min(dc_clk_table->entries[0].dispclk_mhz * 1000, vmin_limit->dispclk_khz);
+		/* dispclk is always fine-grain */
+		dml_clk_table->dispclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dispclk_levels >= 2 ? 2 : 1;
+		dml_clk_table->dispclk.clk_values_khz[0] = 0;
+		dml_clk_table->dispclk.clk_values_khz[1] = dc_clk_table->entries[dc_clk_table->num_entries_per_clk.num_dispclk_levels - 1].dispclk_mhz * 1000;
 	}
 
 	/* dppclk */
@@ -105,6 +109,10 @@ static void dcn42_convert_dc_clock_table_to_soc_bb_clock_table(
 				dml_clk_table->dppclk.clk_values_khz[i] = 0;
 			}
 		}
+		/* dppclk is always fine-grain */
+		dml_clk_table->dppclk.num_clk_values = dc_clk_table->num_entries_per_clk.num_dppclk_levels >= 2 ? 2 : 1;
+		dml_clk_table->dppclk.clk_values_khz[0] = 0;
+		dml_clk_table->dppclk.clk_values_khz[1] = dc_clk_table->entries[dc_clk_table->num_entries_per_clk.num_dppclk_levels - 1].dppclk_mhz * 1000;
 	}
 
 	/* dtbclk */
-- 
2.43.0

