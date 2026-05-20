Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4768CD4F3C
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 15:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CDF510E1C2;
	Wed, 20 May 2026 15:46:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JccZLjII";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013054.outbound.protection.outlook.com
 [40.93.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42EDE10E19A
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 15:46:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwVWMMg6C7fKNWZEH/Tn/W+vn/Eg3zfUbjV5kTIy+PuB4uXAyR1ofhRUKXZFwJjFZTTEOSAZBnPjpfXNi50IF8lZ2j6JX715K5Eu4j/uD4GGlphd9AhvgOTRCnHOCGVqqnNivrqXWnbrxgR3E6EEyx3LzI23u4b1eFHpFJH+tOBlT+oBvxTQgTwCZ0wO8zX98HAN3MaHAe3796AzOkLP0jnTZDqnDDVkq31rmk3Kc1VjcFOcaIqiZ/6y2E3fv/tO6r5x1XUHQ3SJteu5WunZVYnj6qVDg0rlkP0hTiTdq/y/gayOc+qrFuVSCkJbldr+LeLLJApyjlPMiUzWScQqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaXrOUYCaWVs9tA9t78/dJxw4DvlkhAP2isjWBR8FZk=;
 b=XK5InPY9AcfUTq3LEesg5UvddRyF7Nq1slmFl0gFzGsknLnKSR1TlNz/WOGW4Rfvl5ayXrs6KRq/UoIX8NXKFrKWBjoWBji9UbzPSf4iWnNOpISYcDj1IP6OkuOZEUxUrbr4X3AS9LWucGITtzpBRfS1IMa2hOdfLLRAUe9QRWn3+31Ybd5qlqeJAK3SCV4ih37SEvqaF0HvYvnZfklIH9BX96cfKHZfXn1d1TwABxWLHFrrzxbcOcA0YshTdRI+wUfT5rTsJDgMHQUR2xUJR0DnPOlEAssdyCNPJx4HC0OTOJoItkcc1uSHon72JaAVXCtM5d5wYh9zg/3vnLgPmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaXrOUYCaWVs9tA9t78/dJxw4DvlkhAP2isjWBR8FZk=;
 b=JccZLjIIQnD8C6hdYw+Yr720Rx9j1zhazLwXLKAfp0yKKSfdCbNA3+0RjItLXUKIJ733c7pIC07yS0r49fDip0Meu/mxAQvvI7Ly0LqxqBDH/QuEL6P5BgwgwLINlP3WyWuw3OHTBCS24ZMtETreRt8PzOlTD0sOs9Dy466vbJ0=
Received: from CH2PR18CA0043.namprd18.prod.outlook.com (2603:10b6:610:55::23)
 by MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 15:46:27 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::49) by CH2PR18CA0043.outlook.office365.com
 (2603:10b6:610:55::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Wed, 20
 May 2026 15:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 15:46:26 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 20 May
 2026 10:46:25 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/2] Adjustments to _PR3 detection
Date: Wed, 20 May 2026 10:46:16 -0500
Message-ID: <20260520154618.809699-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|MN2PR12MB4256:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c5add2e-9b4c-4662-48c6-08deb686f3d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: CX0vDlmEdyjtopDQGJQSo9+rTcFxEHR6Y/x0vvpnGQAoiYYinzocZ5S1baC3lWvBjAyCit/FiJ9+IQI0P3iOyRGQA3dyLmv9eJMTav8Q1sgeUKWabticR6ljUJe3itmy6ImRpGClqGNtFTV6yv0qx5VLATt3dJOraiZbskGqY4OSEa9dyUkT5cO71fWqwAQ8XwpFuEyGRSqgygL9oJENNsUV6w3xJwIMsbKW2NwNhWQlq/ZJKZGHHeDa6XYQfDRp4h/7WzZbuAZtfkv5y9tr+UPRC3okRXtBif89dWZ9+rKHnaAsZOIyN3f5CciRIhgMze9+xt7A3tDHv7EgH5LUj1nIWAQXEQnVcYd0mACemOl3VQYNUN55UyoFaiIKlooTJT/HUQSErFw2Xya/ioQPaaEi88PSIRVxq+e95eHBInz9rxWcqiS+RnG4/NbvOWcfUIBHyuZC0KL5gyxl/dmXRmZRY4MWbSkTlC/ZHGzsKeHNvUJzDP/sQdRdHXpiLGiLVamO3bEnvLr7dttv+Y/Nl+jba/VxhWXGwREcJDPS4AqEvoAOsN6gDbQQjlmsVd4v6GPqe23KtnadrGPDMUrA0cXf3MCfWUn5CFCRNuQZNT4sv71kVjYcZb8v5Oqpw6m7Dsnf7UaafEaS3zsIC2o2TBJiq0dM1nXJmj5RSX9oUhXd9KOZh7yk/5tJm/Koo95ChBcwoVvL8xu3ulvOzaZOKg2Ov7wX0/hbVDXL84OkvWk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ut3K9baN/YxnH+xX55OfLZCL4hWy19wpreywtLxFMkWeQfrsmQazcp+1m7ym6u2uoE7B98o20y5s57MAIoehwtvLC3ADOapW/R5yR+iEcctNI/vO0OYhdiPgjJ5a/9imxotdU7NG/x/oIc8h9nS2fSEzSx25JN3wMLd4Jgg2nqmp0VxCyK6mn+8ePelVUulbpXgFkwQlRA6xi2c6KhH7yVdnBi7RReNh1kAziW8hb/+vufTr3dgze1JvKG+Xffjff1AwthTS1MJmoJYIFh3qcMdPHbMLn+SUXNrWReo5L8iQyTGghJksJMV0MFl0QrVFfpYKh26Qrhrqnal3SfO9dFLV/C5N5kal7cVrJb0PQrSpt1N2Lk23EroNLxC3wTlc7UjvQ1AQr/fFDfG02lzNvwhtjzILiyKlFT1+s8SXA3COsu6Er2pj5+5v5SXyGtZq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 15:46:26.5473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5add2e-9b4c-4662-48c6-08deb686f3d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
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

As part of reviewing a recent issue with BOCO I looked more closely
at what we're doing for _PR3 detection.

We used to look at the immediate link partner of the GPU PCIe device to
detect _PR3. This was wrong because dGPUs have internal PCIe switches
and those switches won't have _PR3.

So I changed it a few years back to look at the root port.  This worked
correctly for some common cases, but I realized that if you have a bridge
between (for example a B650) then you might end up in the wrong power state
for either of these cases:
 * Bridge supports _PR3 but CPU root port doesn't
 * CPU root port supports _PR3 but bridge doesn't

Both of those cases could lead to actually using the wrong power management
for the dGPU.

So this series adjusts the detection to look at the link partner of the
first PCIe device "outside of the dGPU" instead of the root port.

Mario Limonciello (2):
  drm/amd: Add dedicated helper for amdgpu_device_find_parent()
  drm/amd: Adjust _PR3 detection

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 51 +++++++++++-----------
 1 file changed, 25 insertions(+), 26 deletions(-)

-- 
2.43.0

