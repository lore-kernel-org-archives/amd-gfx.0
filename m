Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA889EB64DE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Sep 2024 13:37:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B89410E7E5;
	Tue, 10 Sep 2024 13:37:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h6m2P0Zn";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5036D10E7C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Sep 2024 13:37:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYM68ssLDI2it4NRx55yBDnhhjl6Q5pVStTbAb/b1USlkipjZcZDxlGMq2T3h0jEm8wzvDZRDPeTAORVfn6wfJbxVhSiHOYpJAjTde2NGFE+qmG0nIjRgUFaqWcZiLSfgBXxEBWgFREyqc8y+T+/hUyTrrhvMwJOBsQtydQhT5IqacM46jHmCTTzNZ5BGCaD06TGdqMu0tzkhLozWnb1mXg+i8KHwXs9vUo2pY9jX+C9jjmCzJyE/DCZ/3TAp+Cfbbm6Vx0eRRvXeZOTXmo8Wv4wPzXwjuXxcc6O/awuBJd72sxPxHPb0I0AMmbWpFxKi/aLZKxCvJqlZVjlf81e8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4crALe6ReAmTEhC2lU1ulff50qWnzqhccrJKAFjuxM=;
 b=AYtEIHGjXAwO3vSFpkgN03PzaSNfxRBmuSrcfUyrzb4UXLuZY6UC0KP1L+VWPuF9LSH+XjVFn91Q1dZpVobaDrWEZGZ4k5beHeDCjiw+aUwFq+imcBBN/IdOo091iXT/phOQx1P+QKvvB9VDzuR9kOdpjiHAJBhhrLwTWluRW4vUFcS4OpRj+0ye3Z546UdGqXkP3MxsOh0FpobK6DWWVGy/XgqK1tXvVbTIYQkD5g+zdYifx84OIi7DKhPRzTu3WwYb9MsIqjRHve0ebs0BvUgD3XJXQ23bcwsmZIg1j4kPsGks5RdxohDRALK65hVXIrNX0jSBYbgyOOOlL5YYeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4crALe6ReAmTEhC2lU1ulff50qWnzqhccrJKAFjuxM=;
 b=h6m2P0ZnDr90TZZag0nN24ugN8NZZMrwa+TbrRyHeYxMEwfGRGL0Fr6vvrv9KEZndbqqWv4DElqyUGd8mGKooiWoO+pUfbZcfVBjyg/+GCcOqktDSrZBDkDKoxk47lEizOIj+slVF6s0BUD+kklcV6C6+a9DIY5lFWUVUkKAsaY=
Received: from BYAPR06CA0067.namprd06.prod.outlook.com (2603:10b6:a03:14b::44)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Tue, 10 Sep
 2024 13:37:16 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:a03:14b:cafe::1a) by BYAPR06CA0067.outlook.office365.com
 (2603:10b6:a03:14b::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Tue, 10 Sep 2024 13:37:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7982.0 via Frontend Transport; Tue, 10 Sep 2024 13:37:15 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 08:37:15 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kent Russell <kent.russell@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Retry i2c transfer once if it fails
Date: Tue, 10 Sep 2024 09:37:03 -0400
Message-ID: <20240910133703.430803-2-kent.russell@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910133703.430803-1-kent.russell@amd.com>
References: <20240910133703.430803-1-kent.russell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: 1769851d-5ac0-4860-9c24-08dcd19daf3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TaHWWe13vCEUhoOVrmCZ1ZZ1sTMv55J5AX5jvw3akZWMfZmudCc5meGQKwkp?=
 =?us-ascii?Q?z+ImpriIVh5Xf0YkpBEsnARcyYBkyMP79izbQfyQFDn3CR+3UZsBeKG3l1+w?=
 =?us-ascii?Q?AGcjgsPyNze/wj9V9VtYu4fhFG+Qr1qgyl0GFKwPwVXLSkh4rMv4gJ+HW+sg?=
 =?us-ascii?Q?PL5cZ/Kggmkso+LYembOdFHzkp2gFFHYzd8f894g0P4h7deS2W8GxL5MTHPW?=
 =?us-ascii?Q?zNZ+V92uAoqKMELyzO4h373icN5SwNpstSlWmiYGT19Vjr339fRbwPlqUBs0?=
 =?us-ascii?Q?AI5k3N3gk9dJlwGwYyxskbSWwam+p5ACVf8cZtw2bBFbuCHOFFu0Yr43FQb5?=
 =?us-ascii?Q?VIK+SxBn9ZnlsJHpVyQ4g1k0LFADp/6a6j7T+P0m0ehJjhR+OgNSMMMzvNs5?=
 =?us-ascii?Q?JUyXjk2XgktTDtBlAR2K4HxkTKB9YvdbHtsr9cy+Rusg/E/zxqCUW29YoW+C?=
 =?us-ascii?Q?Ko/3zIzBNppk7sSTEA0WgLLSivuI+td1ZLRLn0NUkDGTCjuytV0ec3NgL99X?=
 =?us-ascii?Q?aDaKCEWE+WSgMJWFyAGuMDac7jspR57h+rs6DIonMmHFoE9ZTMV743DAXQ+F?=
 =?us-ascii?Q?CMoixDFC3Vtbg+bwMhHW+raZsfVKTN1LjWlPh+4SsPuJy4yx7j2yeEg5FkWj?=
 =?us-ascii?Q?aEZqcVvZNZyPB96tP+R+1BX/CsxRb0shK8X2kXr/WLXtxj0FcHus+5UuNk/B?=
 =?us-ascii?Q?skbIWEqdX98DC8+karf8hpjeS+xUN+4zc7YoSxTVb9IV56k/o8K08AJz4n7t?=
 =?us-ascii?Q?d2F/zBU1YX9C83XdEI619rQC8by+J0zFaYg3JzPE++U5obVY1s470mdkaQHT?=
 =?us-ascii?Q?zeji/GlfZ+K00l74iS+1ikkvhUFkJCciKYomFEQG1ClmtQBpfBomOO7/YsUJ?=
 =?us-ascii?Q?FKHq5B4wukrPUK42gBMygsoxJ0pkEUaqtcbiM84Ed8eJmV9ynGtndfI9pAa+?=
 =?us-ascii?Q?BmXSr6zo8lNolDguQ/Dt8FDgaei84m4bFZB8aSnaw5up2ZxqWm7CEc4Ep+Ff?=
 =?us-ascii?Q?m3HXboXELA7ev5J4q7wT/saj+LHG6m2g3o0kJRuKg3Mh4sJlRbb2uukPhY8x?=
 =?us-ascii?Q?XFOd8xzkI6v6Xj4w7qsm17QeJLG7PEplYgRpNioCy6XlZuMygrpJucLB1Dmc?=
 =?us-ascii?Q?0HzaIp4Fi43/RJllGMgtGe4mv+AdgojKaDf8xQOEhdS7Hdn5dwzA5YGo16RC?=
 =?us-ascii?Q?wnOlv/ay0Im3gHE7xsiKXL6SAe6RIF6AynfpnRteKaX30ARViD7rxXmNN9Ax?=
 =?us-ascii?Q?bQ4o22JFW2WankfMlN4Z9QYVtV1FdiCPf9T6Vt2svVTN3fGaqNcSNEHg/qBJ?=
 =?us-ascii?Q?kD2HiAUI89Auovq/eGrOTOiFTurvsecCgEy3U9lD7c5iHdiUi7xJ8SYMAkbZ?=
 =?us-ascii?Q?vSgx8VWo+NLFXWHqonzDiu6JjhytNACXsjVK+mzTe9COJxwuin8jT29cEBPK?=
 =?us-ascii?Q?5Hj6wcLtCD5rkL2xed4WJTIsit4HoQ12?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 13:37:15.8195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1769851d-5ac0-4860-9c24-08dcd19daf3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930
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

During init, there can be some collisions on the i2c bus that result in
the EEPROM read failing. This has been mitigated in the PMFW to a
degree, but there is still a small chance that the bus will be busy.
When the read fails during RAS init, that disables page retirement
altogether, which is obviously not ideal. To try to avoid that
situation, set the eeprom_read function to retry once if the first read
fails.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
index 35fee3e8cde2..32755a37dcef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
@@ -227,8 +227,14 @@ int amdgpu_eeprom_read(struct i2c_adapter *i2c_adap,
 		       u32 eeprom_addr, u8 *eeprom_buf,
 		       u32 bytes)
 {
-	return amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_buf, bytes,
+	int ret;
+
+	ret = amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_buf, bytes,
+				  true);
+	if (ret)
+		ret = amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_buf, bytes,
 				  true);
+	return ret;
 }
 
 int amdgpu_eeprom_write(struct i2c_adapter *i2c_adap,
-- 
2.34.1

