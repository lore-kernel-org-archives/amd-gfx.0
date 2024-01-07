Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2670C47073
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Jan 2024 15:40:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EE6A10E0CB;
	Sun,  7 Jan 2024 15:40:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 157D710E0CB
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Jan 2024 15:40:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KV7NDmK1PtJqSKVUwPAyxJqHCxCmN9+7jojeyoMOOlMlAEzuWYPTxbFyMrwhYreQcWB5UgyG3jMMPwQPYS75+7HNwDSy/Cx3593FHKlANMl97CbE9ST80nPGww7Fpwy2RZSAlGX9Kbm4B6IztfhwxSdQbyz0Ids4PfI35vYe/s2YhhoTIlbtBmtp6VaV46IrmZB/ZO2FDK7HomxdZbzHVH/d7DcgbDYFKYeSMPyjreWnjS5HdiF+7ulr0RIJ5bFME8G7Fpe4MOP0V11a9WTLUKhohKC6q/AIaKs1XkdxB1l6tBvU1zHSX6yousLaFO67baYdzcLeG5169KCUKRuTrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgAVzo6NDr6nRRMPejbzkZ5VRVp10MgvNxe7KLxsi6Y=;
 b=EKVqYT4tPZcpbvZeHH5Ua9MfGwOn/sirIEYUwCHXEJ3EIA3G/pV4lE5qgZ1hxWwCaAEJitvpc2xHT/nAe8EnfBWW3odCrnRoJ2pca93E4tUSdmmm6E+mBd995+vbpypzRrCRsAI9O7WYOjClCj6D6Q9WJPn+QsNn5rs66z7iWE34d64xziGZPnfzChudZkokybeXqP5gSdJ8qo5eJLL37Vb7zqp/jbsIXOzhyNzGmpn0e4M1lbHEj1VycTE0GdSkalCQbuf6pfj9vlVgRl0EUkU42lnVtM3jR/qAXk9dGuFlHjAsInxQ+djCzUEciPHiOtUzVP86tanLW/P6U9ZRrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgAVzo6NDr6nRRMPejbzkZ5VRVp10MgvNxe7KLxsi6Y=;
 b=N4gi3ImlIhVimfohvZHuWidIaw+c/sYSOeoB8cIUa46X1rwOI5Q11iM4/R2NXQ4cjU8O4SVUEMwWi8ooCCCQIDh9QmWk42AHdrCDjz81jX4aBIhz4+rJex5lu2J/1m0ZMWRe2cuRAdrGHtqTirpdfIVVO93keghpMb8PYA+v8p4=
Received: from DS0PR17CA0010.namprd17.prod.outlook.com (2603:10b6:8:191::26)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Sun, 7 Jan
 2024 15:40:46 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::52) by DS0PR17CA0010.outlook.office365.com
 (2603:10b6:8:191::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Sun, 7 Jan 2024 15:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Sun, 7 Jan 2024 15:40:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 7 Jan
 2024 09:40:46 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 7 Jan
 2024 09:40:45 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2507.34 via Frontend Transport; Sun, 7 Jan 2024 09:40:43 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Yang Wang <kevinyang.wang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Candice Li <Candice.Li@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: Query boot status if boot failed
Date: Sun, 7 Jan 2024 23:40:06 +0800
Message-ID: <20240107154011.12927-5-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240107154011.12927-1-Hawking.Zhang@amd.com>
References: <20240107154011.12927-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|DM6PR12MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: 2680f662-02e9-40b2-702c-08dc0f970453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qYRDqJTJ/kQaxIZ7Xp1iMSOMGoNnSwc/z2UVZvAf3rfdmS0X+8M8bGjmC+Z1EtAYOpu137PIGu1AIJLdB2m3CED+N+oZF3HeWHeZNKICdnwz4VTpRYVgijFJ2uRd6Qwrx8IXi14ECRXlY9UEYhRkAtmslK7TcvIxy1V6roEvyveByOX4g/l1FXTqIaVhNF+mjM7pUsl0ylHJYuvmdOn64R6mWXCLcviiCWJ5uwalfF+3ltxkCJHqlEbZnG8lN40xxlYpZguHg3PbUBM7OHFVqgYwF/jfgPdoBoqnIJoN5z7hX+xMpMnjrNzPEAj2vQud7WuY8k8sLqvXdEYPBNfDcpiNJ/IjE7lpiMgjKLiT3DK62WoNHzfeWKSwCLkXbmeE3RkjU2+OfSHX9h25a11uyE0q3K9FehRVxg8NiQwQd2/RQ+zzy+TL9Euo+I+X6/zzIc1n2qF+crDw6rN/vsVEZdwX5rUuxqVTAlYQDl6Ha8qUG1DcXQR+bagsJmZjQdfLPf4OhOXIoUVcnm0CcB+idTT5SkZzjnqmb7e6kJ99F980AMAsk51dQTGpeV9ZxQCzYMcYcp1WEfcPrCqwvdWpbG0/l4WPbhWeCdCoGHeVJqV/2KAYkEu4GQmQjC5cXbPjG5hpJU0N4QKibQ/yLuz2CP6gEIdwkNryuyueRpTQyHNrRXnNe6CQhipJXeLoESt7qMz7uUDMs+BYqrtkojTwhsV5qige0AENupV4N5k5lCJdTGkDmEJqyj3Ih6QjL9TL4QPj8xGztl0/ElczHbNZxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(82310400011)(40470700004)(46966006)(36840700001)(2906002)(5660300002)(82740400003)(86362001)(81166007)(41300700001)(356005)(36860700001)(316002)(110136005)(54906003)(336012)(426003)(8676002)(36756003)(47076005)(8936002)(2616005)(40460700003)(70206006)(70586007)(40480700001)(26005)(6636002)(1076003)(478600001)(7696005)(83380400001)(6666004)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2024 15:40:46.5885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2680f662-02e9-40b2-702c-08dc0f970453
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check and report firmware boot status if it doesn't
reach steady status.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 6fad451a85be..676bec2cc157 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -187,11 +187,18 @@ static int psp_v13_0_wait_for_bootloader(struct psp_context *psp)
 static int psp_v13_0_wait_for_bootloader_steady_state(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
+	int ret;
 
 	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6)) {
-		psp_v13_0_wait_for_vmbx_ready(psp);
+		ret = psp_v13_0_wait_for_vmbx_ready(psp);
+		if (ret)
+			amdgpu_ras_query_boot_status(adev, 4);
+
+		ret = psp_v13_0_wait_for_bootloader(psp);
+		if (ret)
+			amdgpu_ras_query_boot_status(adev, 4);
 
-		return psp_v13_0_wait_for_bootloader(psp);
+		return ret;
 	}
 
 	return 0;
-- 
2.17.1

