Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43823CA0EF5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Aug 2025 09:18:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5FA110E56B;
	Tue, 19 Aug 2025 09:18:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="am6y4NVf";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9409110E569
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 09:18:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gi4zZoycj7UawkCBthxGgYUPtjNPZmnup+lc4/XJHb8ecjZ90NxbGXlPSoxlM5UVA2N1QRM+9NX+2Ykx4PGL/KXxaV0KnlPCMMoCxvT5Xy1ag9LYz2JD3enb/mxugO808FvoirAzYOumTpTtXT/T5eLmlIKN2q/cTpOvD49KJIFShn/TqM8SbYfwAvJynWbWEQJLwPUIlQVj/W1mZdtDuxVagBi5rwX7UIjRMl7vISd8CQrd7Y2ul3Ck08jqIzcEoVV+MEBiBvrvDlC+is1LlwO68kEaRtnDnf6XiHk9N2osQG97rNE9uzb9GoxV+zlsFd2lRMHai00X+O89a/mgKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcs2sONx8sfnQpC+BBFaxWizgA0Y0C/zAwyrGPTnn50=;
 b=xb6iRR6q4bZJxNvzPgZPcpf1kpS0rcSJU8/BiSsQmlxutiEJaNgsOB3Ho4TrbyKFZyhzdlOn2lFDdVjnDWA0goOm/2WfcA1nEtg03tIhvw47Okl6yg/HcP0dNWuQ+zlWRoJPB5iLT5H2eMPUz3rmioQq4CobM0EYAZvFRnXw2qIj1tH1u8oPjRu7MOkjOdymKEQnsajGSYmD9c6r7UmXn3QoK4lo1NldGPCXoC8qI19+0nCCXzJkvn5MmfT8u3S9Rii70mzCYXlpuin19lspBZ63yOK0jjbtBeEgRDttMPAg6KmdDESw/5XVGTxrM3iEGN8GhSPVP3MuCbUzkBhRFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcs2sONx8sfnQpC+BBFaxWizgA0Y0C/zAwyrGPTnn50=;
 b=am6y4NVf8SsdhSHdLeZ+AvqLB4veyeADvtnfTERHmlwxPn7ZYcEqOAfy+qpAF7YY+oc7vB2spCBqUgBU8FVYAKvIpqKomSEGRbovpfKiL4M7KW+i8Tu8GHU+yp20zcJuaAusKGMwW4UUck8WiPrigAWYOVAXI3Sh9l/uoCJiFe0=
Received: from MW4PR03CA0290.namprd03.prod.outlook.com (2603:10b6:303:b5::25)
 by SJ2PR12MB8112.namprd12.prod.outlook.com (2603:10b6:a03:4f8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 09:18:13 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:303:b5:cafe::59) by MW4PR03CA0290.outlook.office365.com
 (2603:10b6:303:b5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.24 via Frontend Transport; Tue,
 19 Aug 2025 09:18:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 09:18:12 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Aug
 2025 04:18:12 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 19 Aug
 2025 02:18:11 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 19 Aug 2025 04:18:09 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>, Jesse.Zhang
 <Jesse.Zhang@amd.com>
Subject: [v2 4/5] drm/amd/pm: Update SMU v13.0.6 PPT caps initialization
Date: Tue, 19 Aug 2025 17:17:08 +0800
Message-ID: <20250819091802.445099-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250819091802.445099-1-Jesse.Zhang@amd.com>
References: <20250819091802.445099-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|SJ2PR12MB8112:EE_
X-MS-Office365-Filtering-Correlation-Id: 917dfadc-5b9b-4bb3-d884-08dddf015291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pWBKj/vxUvc1UK8aCGgBBqA3B3trIMee2qEfCYpBsUDTw0RETiqNAGyZAaYu?=
 =?us-ascii?Q?9XPaHbnI9BGJy7+ZgKu4Prfs91iYoiv6wQ6Yd3OvM2Pj8/fjR3j9kDgVHMvU?=
 =?us-ascii?Q?YrSj5IkqO46QHZ4dgxKqlpwYPrURxrETOgMuSY8FGGnFwAxScq9RG8cNh3sI?=
 =?us-ascii?Q?KrLj5dq6Yv/CsfMwYvw4c1pXoFWl6O3+tuuzxZNc1NcNr/5HKSqIx+OAmoMt?=
 =?us-ascii?Q?p8iqL5BXd5rEQdb4W8Et9MBHkQj/tl05xiMVf9QuACtSMRUaAYNf4KDpfY1i?=
 =?us-ascii?Q?BHhZBD35E6tHUCU4n18sbsC4q15KILEYsAAk/ISKihGDa/nwSkgZOamizKVP?=
 =?us-ascii?Q?wafbrCZeqqA3jvzD99xdrp5ojyHeFhdch2ER84X5gkT5gSMoVeRVCYFeqKLf?=
 =?us-ascii?Q?Sr3RBONyYM9moO+yPhFd+FjZD2j3HuIq7iV2/Arqf0Fk2nx5ZFiMFQm6mEXu?=
 =?us-ascii?Q?34Z6biXvgrirbiy8kmoDeycMghOMM3VVzAg0czSZM2B9jUVAef5IskDoR4Jm?=
 =?us-ascii?Q?ylxg7njF83AyO2bNikiGEf8EvZjOH9UAnhvDsE3GXsbaeOL0DHRD/q+q1jKf?=
 =?us-ascii?Q?FKGdwGdrs/zI8eYmMONwIJSrtTJb6sZtoFLTnomzAQGM4PPZqCYzh35kzK5g?=
 =?us-ascii?Q?qLCuKoQRFAdgf1LomlpoWGH50/78bZ0nEKT8vOeFPdYF/60W31NCx1t0P9qY?=
 =?us-ascii?Q?Gg8F+rmIzNy8bfyBUjBdQ7nAiinRRpjh+MK0ijYbwIkQbQauDU8SVd5xK8IO?=
 =?us-ascii?Q?GCY4nHUr6uA6e7ZkIyaXjkJaqtj+eLu9aivXHYaglaJa7xAnAFAfiqmTKpoH?=
 =?us-ascii?Q?A2o/VdRuALftDMqb6/6/CuhmaWOjGmYt6SAkU6XJrLuAeghm5/7fx2F/329a?=
 =?us-ascii?Q?uNTZzhJM1Qf22LQkrbfDhCXRRqpyCnMh23gX99ZbHiTgXwo/TcF8D4KLLOGK?=
 =?us-ascii?Q?dGs5qDJQ0wh5oZznW5kzZq2EMMXDRQmhwEny6PaC8rmmpG8ZP0fj+cg7pJnY?=
 =?us-ascii?Q?IIja0lImO+JsHSvepgofBjRv80XFvmrD065OMwPuUsBoJzWrDiunXsDn4nkS?=
 =?us-ascii?Q?R69/upJMWn1Gc8yY+zJetc+j0zslLt1jzyHLnmMkMpQxYZNOHW1tZlgu2ifr?=
 =?us-ascii?Q?2mOBVQqsKhFFVq6E+sqwsgVJyfo8oVSYvTFA2B+FXeSQGlhhJEO6Ukf3bn3i?=
 =?us-ascii?Q?aE5+PV8GbSxpODq6M3sS168toaZNvkWnZqJdkkQIyuUHHrFw1AkfDM7bHwDX?=
 =?us-ascii?Q?Fbl7JGfbnIzoR2zObrWKMatu/uyyRlCyKkoot8PYaYdNQYMCEBxBIEZTpFd9?=
 =?us-ascii?Q?ZPvLB9DwpPF27DVbei2KEHYp5ITnVy2ZdHIiIDf5TTCamgzeQpdfB93hPrgU?=
 =?us-ascii?Q?uAzryclAfQvzTLIBqnUlIKpUlNdsP3ukRfEqaTyKZLWL2LFlL+fLhsAmdaCL?=
 =?us-ascii?Q?n/sqGa0c4NEClq915LCnUH0ruFy4RY+IsTTgmaqZXC6SdQ1q+2D+1pCm0kcu?=
 =?us-ascii?Q?QSUMvfwJcROd/Aj9noBDUfXrqxoixs5KdJZl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 09:18:12.8848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 917dfadc-5b9b-4bb3-d884-08dddf015291
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8112
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

Update the conditions for setting the SMU vcn reset caps in the SMU v13.0.6 PPT
initialization function. Specifically:

- Add support for VCN reset capability for firmware versions 0x00558200 and
  above when the program version is 0.
- Add support for VCN reset capability for firmware versions 0x05551800 and
  above when the program version is 5.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 627a8188d868..9306bfe808e4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -437,7 +437,9 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
 	    ((pgm == 4) && (fw_ver >= 0x4557000)))
 		smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
 
-	if ((pgm == 4) && (fw_ver >= 0x04557100))
+	if (((pgm == 0) && (fw_ver >= 0x00558200)) ||
+	    ((pgm == 4) && (fw_ver >= 0x04557100)) ||
+	    ((pgm == 5) && (fw_ver >= 0x05551800)))
 		smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));
 }
 
-- 
2.49.0

