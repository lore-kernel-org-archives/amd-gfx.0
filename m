Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E30CCF2DA
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 08:34:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 922CB10E88F;
	Mon, 19 Oct 2026 08:34:34 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C54610E87B
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 08:34:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4LOEAXTlGSuSSIe1ytPQwzj7TG5yVVKM2mMBOVBG/VSm1PxbA4HBeoqOLnJRn0vXuApPhHkJZaakqNfXTm/oTaZPeh6TwBNUfzDnvlmCRppm4AIvABUqWL7QTxLUJ+kp7cETh+736CQOxFKwqpbtpS27xozxcjY03/1E08I83OMQDzVUFIYhpGqITDketqyreVC20FawziiIQZSR8iJWyCDUWHWZ45RIVeo1ki5m0VE4t7eBaLGcAo/D0jZjP25k3FO8bRgzau9BXHEGKG1esO2dVZuC5IFN1pl2oUE7sXc+qf5LLe3hhShC7jTANCsdO9IGcvrQjF4Iya/GqX1Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8JWWjhXyuoU7M+m24UyubOiKoEUt4ny/jjkIbyyDdk=;
 b=WrXdDd2lj6ctfOPIDiJJ1od2xelzKxWF9Jjuu42LWzNIqIcheK6LPIQkRLn8NLDB0/FB9xfScLCCTiCRvgXHbktJC0s+SzHKsokAidJg917ALGu4354rYqdFM7LqGHrIjPEDRXf2a1tPmeEc10Kuj+skXFaJpvsuEbIV24//DG3STpUe17pZdC4kS4PCHlcByEbWljx8gmZ7rQSXMl01qpZ4MnBtHie5M1vIYDW2tf256pvoe4FDiUWsB4OvkZQ+YqY1FWD4gV0+quwjz78y0MBSECnq+zWXDiCOrBKCQ+wRJX+VpL4DSGKoQe1ot8k3YPQdwLSZkT8/Cqp7vr7EYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8JWWjhXyuoU7M+m24UyubOiKoEUt4ny/jjkIbyyDdk=;
 b=rVXCKzqRY/XROYY8ii1kWSX9jr1MThKA7qpUCER5E+4Ac45JKqLG34pfrU5PxTl9jETwlhMpToR6waZ4h96sE6aMx15It9ApvqGQHNbLSSo2hQ3FX4VPzoHTDnU6O8HbA4/ioHdTJCgm31tOLb7h8t9nZjM9ot176ZhRNJHT+Q4=
Received: from PH8PR20CA0024.namprd20.prod.outlook.com (2603:10b6:510:23c::19)
 by PH7PR12MB7940.namprd12.prod.outlook.com (2603:10b6:510:275::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Mon, 19 Oct
 2026 08:34:24 +0000
Received: from PH1PEPF00062F26.namprd02.prod.outlook.com
 (2603:10b6:510:23c:cafe::17) by PH8PR20CA0024.outlook.office365.com
 (2603:10b6:510:23c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 19
 Oct 2026 08:34:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH1PEPF00062F26.mail.protection.outlook.com (10.167.243.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 08:34:24 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 03:34:13 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 03:34:12 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 19 Oct 2026 03:34:11 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 10/13] drm/amdgpu: show the engine reset in the reset masks
Date: Mon, 19 Oct 2026 16:33:10 +0800
Message-ID: <20261019083402.2033724-10-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261019083402.2033724-1-Jesse.Zhang@amd.com>
References: <20261019083402.2033724-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH1PEPF00062F26:EE_|PH7PR12MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: 318756c7-61bd-47b1-dcc3-08df2dbbc7e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|11063799006|56012099006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: miA1cz4uSdbMOUpgkt7ymsPv5hA/UhA+ODUNULVh3T3FuYcloJgpRnx1BA/jokMdHyxYDB6ozR+N57IixRaernIspeP9WmZdny7Im91aLIaOrAY0YAD6lojEgZXM8hYuCrhQ/14rwEV6wA7vCnjhqTmpn71t7uaJaOrP69bp/0WMJe1Kptq05cg4+9HxB+q+1dxoBAIBLVoA6JkRPby2ySQusavXfFsXHfUQKgeoiXdNhPEIkjYh3BLZwI7vqy6tEb/ZwZTLkVfa8iyncCEkOiNcOU2dg2oVu6anq3UpkocbGDt5MQocH1AP1DMJ04yvdd2ocdl6Nhy3XOYytgIIzeKu2YoCKPmmfx4yfrG40pnS4pR12RODjDe/vIEOv3EZVJKHzM+vE/JHlXlg0pNjIm9Hqv4lGLs+Rb5Ue24SaxARxIImptP89+VTc5TLnE66RpuPBtnyQMComkZ5HDwM8wj5bva1D/eI0McahrhOUIS0VXuR9IwS5oyhMuaMz23jnHYXPjJf1HWFN3fr4T+lFGEMuQVD9319kTKbgCPPvYgU5yf3UkLhVRyw2aEjZFVmnldnpmEbFssSpi2yba2BApSudbA+Wb49DamdAcTg4G8v3gU0bc202nJIH/2PSRBuDuR1kvHsXXcW3rofSYawwQ6WkeSswMPRE3e1IjsRJC8brirFZjlVrQuhDqB7/4Ruvo/jJ6cO/MBo9AA0x/SHzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(11063799006)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tQH7TQ6zN5qpLnKhSLfzbigAj5lTc2S3jZVbv5fLeHvVRJ0b9/bJTFmKoxMYQ5p6Mm0EEKt3SsaXqWbdtZrlGlcaNulQFYCCPBI6xPehcYn+OVl+S4h3chx9w2qoIgIujojqsmZP1bDMOKIItR7f11kqBGp0pyWJ5JZsOzUYwZB3gOS5u5baOIPsRSvdCNEP/OAdVHRhuUA2VI2lLg4Siwda2i6FCs06dADP5MP00Sby8ucvxRpQNUSfBROb3J+oANNpgIUf5xsw8cA4bZT/Sj3+7wgqj1j4fjTJxP+rHJInfhLVdncg6JRVNTraNCRAvv2Jf3ZIlwoywLiXCyAtKrF+zWBzof3blkVYhkear1PGiaxML9QLyH1qSffAdshYzuxQ1PGbR39v6MTnUWG+/JXgC/qQ3yZU54/9bxDpQzA1EhvND1zc6pkW9eKuyzJX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 08:34:24.4721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 318756c7-61bd-47b1-dcc3-08df2dbbc7e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH1PEPF00062F26.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7940
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

Show AMDGPU_RESET_TYPE_PER_ENGINE as "engine" in the reset mask sysfs
files, eg. gfx_reset_mask.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3aba35bdfc9e..cf565c028491 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6834,6 +6834,9 @@ ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset)
 	if (supported_reset & AMDGPU_RESET_TYPE_PER_PIPE)
 		size += sysfs_emit_at(buf, size, "pipe ");
 
+	if (supported_reset & AMDGPU_RESET_TYPE_PER_ENGINE)
+		size += sysfs_emit_at(buf, size, "engine ");
+
 	if (supported_reset & AMDGPU_RESET_TYPE_FULL)
 		size += sysfs_emit_at(buf, size, "full ");
 
-- 
2.50.1

