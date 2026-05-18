Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2331DCD4F3C
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 06:41:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE4C210E682;
	Mon, 18 May 2026 06:41:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bru6odI5";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011009.outbound.protection.outlook.com [40.107.208.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF69810E682
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 06:41:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VU5hpmqu8dbeJF5ubbiWP+pQRVZYLJKtjc4ALd77OVf4i0NN+qfb0zcrb4xpanmowPpGjffPC3v/XmgnDgn5NdHA2VTLlk1bQ9AjXBDY+9gtyHMEd61W7gJbIxLOQUxJlGPwfonbjfsh56vKd1TBWo3xre9EHdjV/gWF83vcAhSUfYGte1mfP9sGYBuXphbnO3jWY/EAOP4etglJcWyyDhabeW0iVLemCHof37EwZyayAD23jDrxxg+anXawYsLj52QDUr2N7/5xecl4Rw4iMpVL9bxCm/sGfFVeM/sf/vCIonHnIpZN8LpUdRpt8a3gu2KpuxhQVKlsdmpbIcFpCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtpioBN2P2a0yYv+3KGSxXctx/5uhB6e/MmL2yot/e0=;
 b=Q0m6eQldOYJGBp/thCco8wakHWqrIrSRQugiETSA3yfJEy/x49/RgrzRM6zZZ4sFlYOqLGfE6iZJ4wDYUJvvWZhH7R5YP80AUpdSgIMQM/mLkBX6CsOQdXTMVXHBebu8Fbjppc+lZ7ocaK7fwmOOKS784u+Zt47CzncSnlr/nJwx2StLqloMJUmB1IiNyAnBQa5cgvEFKEqxeOYXZLCs+0z2z/Zorj1k9F9ZtId3gJeE2i91OUQ9YCbBSX1Uvh/hRFSricJkC406gMG6S8oxQs8uHiCAhb+kcTr3MJswlD0GPHeJmNlQCPxIXSeR/iZYsEYhe0N38KcRNScn+ScZMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtpioBN2P2a0yYv+3KGSxXctx/5uhB6e/MmL2yot/e0=;
 b=Bru6odI5vncXyDlK0f2r6yEDV3YO1fF8ZPFZWqYPfRs57JPZ20TX5aGBeanJCNHt2OKvs4dVEf1zB5eIYhRTQBPEeVEoWVPocqKWlLmCRczjHJxxCgo7nbArpTIL+9cPh6doThEkHBJ81ZyROYwBfAU5gX1AQfP9sJib7LCffgM=
Received: from SN7PR04CA0076.namprd04.prod.outlook.com (2603:10b6:806:121::21)
 by DM4PR12MB6040.namprd12.prod.outlook.com (2603:10b6:8:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 06:41:43 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:121:cafe::30) by SN7PR04CA0076.outlook.office365.com
 (2603:10b6:806:121::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 06:41:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 06:41:43 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 18 May 2026 01:41:41 -0500
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, Gangliang Xie
 <ganglxie@amd.com>
Subject: [PATCH 3/3] drm/amd/ras: return error when converting records to nps
 pages fails
Date: Mon, 18 May 2026 14:40:53 +0800
Message-ID: <20260518064053.2778626-3-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518064053.2778626-1-ganglxie@amd.com>
References: <20260518064053.2778626-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|DM4PR12MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a26a8fd-0d3e-4d21-9858-08deb4a8862e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: 9rCjoqQkkRpikHX+0+i6dmTrahQrDg7rlWCyxw7dBmC8bV7nu2QEEZOEAvtehJOiabnYKZ6Lj3wFPRU5dtHzAm5rC+PvExse6UG5ziSrutLlCBOw5jXaaU1IiLIYs9i9+ZXctIZnxGkhhBwkQ8USqW8a11UONnHxfWAxN/Rk5A1A7/fUbrM85SRh3wavEGpNaJcZOQDf/G6L/+2dl83vKXNovvgM7CNjuDGXCXsheATPzoB0echq1DbtRQJfTEbnaM8A1BHpvJjhg5A/ePhhyPPhg2ML7PbXan1Hfl0oCk2FQtVktj+gIobzweZQ2UR+vrs/kaTvrm4wfTCZLjXzrjqo/YAUQB2+A/CjAYnk8NZSsSMT18TX0NkXUfVHQ39YWu6wVmIxERsdtpNRT8v2Q+ws5HLQlnUY+HBrlUoFOO5+c2BN9bpC0GWg7gUHlRgiOc8e9xoqh2fuaxOd+I3aIPDdEKcdPTnA1Bt4l/P4Gg2nXW+waQGvdDTCITApTdncklna5+UpOXbRpXJsrDRAXofl3kuv3xPD9qOodOGdyAjxcnl8wuZWW0gIbNXba+E0Zm5WgVeildMPVgWqRYmURz2ZYDXs4H/OVzvsZa7msIQ+qQGBcS0u+/5OoI1eq1tBuznLhqbukFnLA/az62r3/WcSY4snRkh9wLg0M/J21Tj8mYNmar2mOJCaDDxzORnOZC4KzWMDwvP6JksPo4/qi3+TfdegPptVZbRJIsuZOEQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oDZN86nSTbcG+o4fOhLe70PbqMm3xAeBjtHDaQtTYvpK55yoxB/saLSjXtY3XtOXjN/IqnF4hGHlCIgWFUvYv4cfc5aHfgsBVhcdmU2Cl4DxE2AlvCoiWJFTk45IDekyqrqiwAeCRZ0bN1JwgejvPJ7NNTm76+hRDkl5Z7LdyzbrNChokrKGK7Y/hfDqq1vt4J8SKwKruT2bpPb4RPkcsuV4VFjL8TJE+Bc/bWGmfiFPpXDf34aaWUpykF0gDDZAhVlkdREqjQzCEAi7a4gMJKZjjEcXWsH6x6eZ0LMS06pkMrUXGBXVVy1a918erx6BRBNSUB6FYj/n3R91R80ugtvq2o3LmuFnTaYVYPNTlSkbcMrIqrC+6ReVSV4eVaTadARlgT+QYqmItnVzYBGsGIPOWGLJjUhFEdHhkh6JBaOPYpeG/0HdM8D0uneqsWcb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 06:41:43.1299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a26a8fd-0d3e-4d21-9858-08deb4a8862e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6040
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

return error when converting records to nps pages fails

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
index d4072350f48f..78db402182f7 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
@@ -391,9 +391,8 @@ static int ras_umc_update_eeprom_ram_data(struct ras_core_context *ras_core,
 			data->space_left--;
 		}
 	} else {
-		memcpy(&data->bps[data->count], bps, sizeof(*data->bps));
-		data->count++;
-		data->space_left--;
+		RAS_DEV_ERR(ras_core->dev, "Failed to convert record to nps pages!");
+		return -EINVAL;
 	}
 
 	return 0;
-- 
2.34.1

