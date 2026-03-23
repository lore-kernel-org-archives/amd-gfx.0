Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC076D58CDD
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 06:04:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E77B10E03A;
	Mon, 23 Mar 2026 06:04:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SwSM8lG0";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D34310E03A
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 06:04:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cuj2yNwFDR72q6YT9Ps6McAoZ0+1pwtlynIEcsyphVMTkjtxWv9xcFzake5nTMGKXv0dc9jmaDfLxsD9Cl82N2mOGNJ8ROkXpo3yL4j+21O45DGc/N6SRlOlusBV3qm/cHXOpz1yxtB8cAVyRMHSMGcVi7YMUMwiscqqhJFAKQuKaE9hPnXBWSGyUeoS+5ckLg2WufVcuLXheoWFwb0YFKJWTvVVRXVKzGY5m+J9TS1JFkd4CJVl4iDhyU33idMzT5/Aolq9efhthZOCXuUnXbsLMMs4UejDAPvgkB8JeoBHD+zMIYJ/xK7NuxTAO2hMzf7FqNs6d3l7UlnjY+Tt1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36yh9GzFJDdkFx3xpePOYiC6Q6dueCreDuKHpMUw+Eo=;
 b=VVp0Vf44Lzv3W/M6ieqwYn8LzXo8LEzesM1wPzey+03bPU2Txxz6V9QVsjpvar018jK9ZcWQR1wAVbIU2+N1L7nf74KtG85ALf/WiAxWcfLnUYl2yy0WeVjq+mXSsgJleAATKg9C49UHmmDrZuVmSnny6fxvtJCzGAnb4/UKq0TQhKrzCt1AdqGTsMKmP54XhLYiHw/QoZZr2G2Mk6KM8CkSvaESBm2erg91bpy83p5ZWDQOmJNDVd2NZ1D4zWYy5RldUh+/iXE4LEOoGhoWoROIl9ky7vdFrv1QAXjcNvfEvDU4FvNDQ0CtDgOM3sFbOhYLHJ5rnj00/5h5iMx1Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36yh9GzFJDdkFx3xpePOYiC6Q6dueCreDuKHpMUw+Eo=;
 b=SwSM8lG0iRmR2/+qMa0XiDBkYfhlfMBFkCO4WXXZ4wyw7ytvU1YJm4zhT1JfQwII5yhB0MZrm/rMfI5CqhldCo4n6J/obCAH34dvKIrkNmgXXw0308eoT47qFoUEIzmwuTd2n7JjxiouxsePpYBXTXl6GqKvnS+ZtoXcEYomz1I=
Received: from DM6PR02CA0160.namprd02.prod.outlook.com (2603:10b6:5:332::27)
 by SJ1PR12MB6313.namprd12.prod.outlook.com (2603:10b6:a03:458::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 06:04:34 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:5:332:cafe::a3) by DM6PR02CA0160.outlook.office365.com
 (2603:10b6:5:332::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 06:04:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 06:04:33 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 23 Mar
 2026 01:04:32 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Mar
 2026 01:04:32 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 23 Mar 2026 01:04:25 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: use DISCOVERY_TMR_SIZE in ACPI TMR fallback
Date: Mon, 23 Mar 2026 14:03:40 +0800
Message-ID: <20260323060420.426580-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|SJ1PR12MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: 92c46309-7758-4381-0eb0-08de88a20e08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: G+uu1jF35ALlu++Pperat9CB21uSfjErwpN4rLCa2/Vu23RpWLKOCVAZEb5dHtISxlWnmui0rs66eGQCRRqRQh9SVGJPs+K6hOnuVp4iHdqugpzEeP+2Vs/jPUUI1XbCPUjDH/EoQYXh2upBiwRckYRnnF0EfpEZwOOF0gdJiPbpQHEGQ1Hou1igNqy8YXe53opZSL4rmXZhVPzlL7k9qUyl9TqznjI1Au2BTgDNQc3SrJ749tHBp9ecq0ALRAzi23smFDyAHA9FIGPCNMDUhTKog1Vi1LuvevEm17q4Y07piCmlql2IL8C4ywPmeZTkDfcO5BZR5gC1A/0xko9KxxMhxEVqvdd1na38O5tpeEcX16SpdNOPzzpRB2wF/2qROc7V7rha/OHI+nMPmAmw+DS+emyCv6HslL10l8u4NBdA/l+U/fnfxucTs1/UdUM+dEipEvWtlk2ONFRL1Ow79aXznCjIvx7J+tcSlTLqZ266vwgz/+O+sJmK/KI3S0aHsV9q37sO2FnIu95ObndtHGG4PrJKoiuCYeEW09TgZjOYlIb6YZ2sMbLAjfklsDQUVA8gsK9/v5XMqcXuWWR7/TJYRlaRJ1gy6t4d98uuGTNLqzokz3vZjvngEqsPwq7L9l+Bomcagv1/w9EsCH0olWUxv7EHdNOo4QXt9MewCFvIanAyyxWdBFxmrpG66aNpQdodflVgNs3dL1lJ2XU3G1h4FhNSj0jBR+r7nEVqIbY1XzzstN2oE07pxLuZi5Qnd/1D8mZK1c1VU/iHW4J9Vw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4Ygn+W5op3mNllT7GPg1MR7V4nh7EpfVOa3OCbMq/5vUhhhsOnTHlTjW5ylOufMKKz4vhQl41IISCGI0UwZ8BxcqO9q9jSslMAf2ClppmGC1nCEDCfX40g5bMA8InDCpwdgzGVuP40+aXn3mXb64gQf6XBvrpkp9uCZ9e77hpBWiyM8ODEWOs24R/74FGPvcQySn9ZgQeppguAOilW1V6/R74am7SxHkCDNw88wsRcUDMl6pPM6G7Utb8LP+2/03Ku8znZIw3/JJKaipvCY9cy/gZpjEfsYy8+rTdnte00K827iZMpJvi/ATnlMrLn6gRNv25G9kW5YUVhIf9nLbMnLcBLb2ko0EUnTrTz+NfCaVRzFI0xCvHgeUb8ePe5G91I32azNJeoVsMoK56NuBtkHEzQKJy+voqvVic6uScwVykuPDDHkpQyEY8jCyn3Oi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 06:04:33.3790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c46309-7758-4381-0eb0-08de88a20e08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6313
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

amdgpu_acpi_get_tmr_info() returns the full TMR region size, not the IP
discovery table size. Using tmr_size as discovery.size can lead to oversized
allocations and probe failure.

In the ACPI fallback path, keep discovery.size as DISCOVERY_TMR_SIZE and only
use ACPI data for offset calculation.

Fixes: 7055e5157742 ("drm/amdgpu: New interface to get IP discovery binary v3")

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index f7f37d93d0ce..c42bd563467f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -324,7 +324,7 @@ static int amdgpu_discovery_get_tmr_info(struct amdgpu_device *adev,
 			ret = amdgpu_acpi_get_tmr_info(adev, &tmr_offset, &tmr_size);
 			if (ret)
 				return ret;
-			adev->discovery.size = (u32)tmr_size;
+			adev->discovery.size = DISCOVERY_TMR_SIZE;
 			adev->discovery.offset = tmr_offset + tmr_size - DISCOVERY_TMR_OFFSET;
 		}
 	}
-- 
2.49.0

