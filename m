Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9EBCD98CC
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 14:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33E5210E1E6;
	Thu, 11 Jun 2026 14:25:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2m4OY1Sf";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013032.outbound.protection.outlook.com
 [40.107.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E9DC10E1E6
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 14:25:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mddarfsPi4/tSlhSsBuOD2tFOQEDQcKJKYn11T3cuHiSqbpctZaCeiBxwPWWPQomKkSpC22u7H6jwJfQaQz+V4ZwwltyvSSy08Z+3gZCl+9b4Y9p2uQhvGJScgLPIslfnNd5VU3h56ykQln9E+jzfLjVNH6Pkw7A7bKuBA7l/mW3eY81jMADS7UABzA22nHxatAOSi+Dlgd4wHs1gBA0cyMH+7ygjJ6XJqCp7vVIEenTzGAH3QDTeN/mD49QsJJwE+m+3vQdsK4+ebdlLwSRoNxWdBmSkONF3P5ThajOp/WfDHwxX4P45n+UNWqG0nzPg5wZDBdB4iVtH6mkoc+TUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8/dF5eVvl2QWp06699kEODkpWc43hx0xkue8O1lUKM=;
 b=OFrXtd0RlvdZsLeIPVmN+3akztPVWqw774+1XU4JrlWJNfRPmRunOhOrNWwBHIn76jouHSwDYT/Nj6mTjwcNaVyiYQ/MkUyUuzdcA0Q/BfIp6KdQ/Hds3ZtFZd8o31HqQjHGUYBHVZvSXqubBQKh7jYPzsCO8ew7NgQaFJoBfzWQNqQsgvQ9XZHXPQDKAeErzY799QoB1XlH++g2Yff35uziD4UpSBvYnKZOiMzKAnKANguYWc8k28DGtJ2WobyCfDs1KS0isHfY+TXn9NHEbjF2RAYNYPh9O+CEyUX8g7UFv30wfpg2vtsNHSCjhNq8Dr4HxlrjVeOhNmf/UKxo1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8/dF5eVvl2QWp06699kEODkpWc43hx0xkue8O1lUKM=;
 b=2m4OY1SfTarnwk3xyqmbveXsNOqasJcjHR7iNXmi2+ohQ6o+tOUxjwnaFCZy0x39OBaMxCyQp1rFpN17Zk3TFyFXrrTb/riYp4g5dLq+YuOlZcVugjh60Gc0futKhfiwWCFi1BUhilepcgkjWhMjL8xcIBgaGSX/us3E5giTT7c=
Received: from MN0P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::33)
 by DS0PR12MB8765.namprd12.prod.outlook.com (2603:10b6:8:14e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Thu, 11 Jun
 2026 14:25:23 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:531:cafe::2f) by MN0P222CA0025.outlook.office365.com
 (2603:10b6:208:531::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Thu,
 11 Jun 2026 14:25:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 14:25:22 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 09:25:22 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 11 Jun 2026 09:25:20 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Priya Hosur <Priya.Hosur@amd.com>
To: Lijo Lazar <Lijo.Lazar@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Mario.Limonciello@amd.com>,
 <Kenneth.Feng@amd.com>, <Pratik.Vishwakarma@amd.com>,
 <Veerabadhran.Gopalakrishnan@amd.com>
Subject: Re: [PATCH v3 1/4] drm/amd/pm: smu_v14_0_0: add DCLK metric handler
 via VCLK fall-through
In-Reply-To: <20260611113628.3217-2-Priya.Hosur@amd.com>
References: <20260611113628.3217-1-Priya.Hosur@amd.com>
 <20260611113628.3217-2-Priya.Hosur@amd.com>
Message-ID: <6e0b1840-5428-482a-ab92-aea6c21d2e97@satlexmb07.amd.com>
Date: Thu, 11 Jun 2026 09:25:20 -0500
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|DS0PR12MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: 57f208b3-4c3a-4f18-4cf3-08dec7c545ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: +W2cP1uKa+Ppbzlyp1RPTXXNFMwZR8CvK/W0/N3iFPo5tE7TzP+LYa6AEpxmLOnMK7QB+7HV56XXA5AoMkTCb4Ux+vlSdn8ves23IgRdcuck3eVlWQuKpu0i/fCtPrtpShA8TI/HWSaBWsZ24ZjsqIp+P4oOIs24kdcb/S1qs1TJicWNeKY3vKbYIVqDU5dy69YwepqzKar0MWOM3M2JeaBC8UGG+EfLcvuzJjoc8GSPsTmDQfn5DSTIPtcEgihNXWfXcmSSz2xAMj8kNefyew6lD0P5uoCZqlDRbni+lUO165tCm794s58iDPehnvwEZ3GULekn84eNFEBktDR0hGLLYf8oAmHgkHJU9GrL3t1JyyvqeemXAsLm7Jj4LArdynWBLm0XCG6Pd+AFKWWLzalUv2FaeTPO6qfdLjojYBGI0WolBw2uAzdIJ7/0rN3d2NpQfX2sPYBCJeNITBi7arJfyyJQd970LUPKpVjSpsv78g3BUrWgTnioIEAeGmRJVnYE/aGaVU+3mVL3rUiQAFReMfni3PxHrVZFYuLlz1EYTH4eq2s2h4TFmywYz+Ebxm7X6WeOo0EARKEqvBZrorKei5dji0Tf8W9Z6rNR2wjqc6qPjGj+bglbkqLQJTrLvhqyfsW2l4y4XsHT4AYat3jXCuUGq9dk0/eGY0Y8CZBfW4/PsqjSNzFXlX63da3aUNCFzwxQ5x14EhtULqRlgrTKSzj7aNz811yTyVAvgnY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2oW5/k7WvqWKgtnCX6noKf69Y6v8euagpvE81mlPvi44tsQx56pM/dRESQK6ShDG2YOyngmb3ZIKgPMCMM5x8C5CI1xdacid+WayYWo/nY25tmT7UjJ35C+MBeylp4Co0PUAKMl7VbIiT53UYkaqBFsdYu3p6LJUN3wE5SqrC2/7QDaJYmAUNDTON6V0DTM6vUbJb63lq40Gh57NLcnrv0IJiiOyRqTns54BYKgw+bZrOwnuTd6r3KNouMu60aLFBtTO9Rp9gkfRg4zsnVjYJVcIy8n8C9qtZgyrWIStLwS5GIPhzxz9n7Yw4sxyYnbiZM2/0ZZbZSk/NRkg/1k1I+nonswO/BnRITatK3UsTSqkZjTFdbv5Kk64qnxzRs062daGybe2mV8SL305OwMk3nJ5ywsjxLwJKHa5MaFSphNtH4nydwgrTbWGGbYdwoIv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 14:25:22.8484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f208b3-4c3a-4f18-4cf3-08dec7c545ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8765
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

Hi Lijo,

Thanks for the suggestion. I confirmed that the DPM tables are
indeed different on this hardware (GC 11.5.1, SMU 14.0.1):

pp_dpm_vclk: 800, 1472, 1605, 1766, 1962, 2208, 2523, 2944 MHz
pp_dpm_dclk: 800, 981, 1104, 1177, 1358, 1472, 1766, 2208 MHz

The original code was returning 0 for METRICS_AVERAGE_DCLK, so the
fall-through to VclkFrequency was an improvement but not fully
correct given the different DPM tables.

Since VcnClkLevelsEnabled applies to both VCLK and DCLK with the
same level count, I'll update patch 1 to match VclkFrequency to its
DPM level index and then report the DCLK frequency at that same
level for METRICS_AVERAGE_DCLK.

Will also check with the FW team about adding a DclkFrequency field
to SmuMetrics_t.

Will send v4 with the fix.

Regards,
Priya
