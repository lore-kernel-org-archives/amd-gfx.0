Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF05D6ED26
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 13:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C8C110E92F;
	Thu, 21 Nov 2024 13:11:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iCEUYkcl";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF65D10E92F
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 13:11:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ex7ybyUp0lSDxjMsIKoVC3PpKXc8jz66IYVfkhQBoutUB0krMvWsGS3GdlnSW6Kufw8EehMdhsL9Io3DXwKtheF4Jv9r07yHFPHIWEDbZphUzVs6eaJfObM5AR4s53Tlpg58xqldi8rnZij+7S5qOFTEBJfqcQ9TkmwkRG5CnlrYdRErfKL99W0tnfISjgVs30MzG7VxMddaLRfifxbD1MFGTsSG7QYap/+5e1C6S3d0ff6sl6o4n/Wer128iGut6gFZRYg5Cre5kq5v3SXTENse5oKsWtaeSX7Mw50/7IfxHFof/DxGeXRUThudZCpvUIUiINPAgNWn0wSgI0fiIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5UZ862kGwdfW8d9qE0YpvRkirPD/StMyXUYwBrBldM=;
 b=xVPpaJmSUDVu71RqehapM6IR657A0jlogcqbeX+joERvCZKOAnjKVVr/QTrJIN/l4hB6lpYjL/2slA/cCc593prwO3tIDl3fcfxSSet72STXkVZRu7IZLVNY0CwYIvhcKI6ahFT1z3ExJaA4TUgxOGZ1GX/znQEghqPI1Zbp/G8EoBAAfvflk1zrkxqe2+nEqREkAY+1u1BhdV/2UDZMlRX0qB5HYM1wKlsi62ljwSmiPv2yAytxp/FQuahFYNOf6JMNMK7OovyYGzSK73wSCT8YBuY/y+6O6GpJu90NYIvN8aMXnjadL55ylSn5bny4pAFkrKLhhbEGm6Mj0sJlrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5UZ862kGwdfW8d9qE0YpvRkirPD/StMyXUYwBrBldM=;
 b=iCEUYkcl0wrx6A/+CqoYb7k+XCdGaGyajJ/jKNsn0Tn6XAdSt3lb/4V6z7lyLVxG0vpNlmNFWkqA5fUiRGT2V/+POatzTmr2HJAj3XTxF+3tTzNW6QHExcVVMBM6jbviYg5FirVUdfyp5VgAw5Ifag+kYch4FamDpBlcozzwfeM=
Received: from SJ0PR13CA0240.namprd13.prod.outlook.com (2603:10b6:a03:2c1::35)
 by DS0PR12MB9275.namprd12.prod.outlook.com (2603:10b6:8:1be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.16; Thu, 21 Nov
 2024 13:11:24 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::ce) by SJ0PR13CA0240.outlook.office365.com
 (2603:10b6:a03:2c1::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15 via Frontend
 Transport; Thu, 21 Nov 2024 13:11:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Thu, 21 Nov 2024 13:11:24 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Nov
 2024 07:11:21 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH 1/9] drm/amdgpu: add some additional members to amdgpu_mqd_prop
Date: Thu, 21 Nov 2024 14:10:47 +0100
Message-ID: <20241121131055.535-2-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20241121131055.535-1-shashank.sharma@amd.com>
References: <20241121131055.535-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|DS0PR12MB9275:EE_
X-MS-Office365-Filtering-Correlation-Id: f5983e00-0962-4329-ded7-08dd0a2e002c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y4tZi9szSUK9NGkpd0vVLs8N/XQWj4y9Z3kJ3E5tf01l8X+8OLVlW3r4XRKl?=
 =?us-ascii?Q?ZIBb+N0vv8IYa+OoSDL2xqGroVl1TzGqX1ldNf3C9qXUyQ+KhDzKXZBmU502?=
 =?us-ascii?Q?oSGc5D/5qPRtmKnMByWj9+wqb3IKZLkzc97McWUthLEnib6gn9oj7yQMoxF5?=
 =?us-ascii?Q?lI6WmY76fNkGjraazqHaNl8DXB1wsEXFirPPoKMGmW9xPvOARrxA40qfTS5e?=
 =?us-ascii?Q?ywYVpHQMcwS4CZsk4Cvepkj15lQhqFDfySn7OIVRggQrBxCan/pZ375qBWQ5?=
 =?us-ascii?Q?EG8CZRmlNNmTH+rU/JEpGZOAmouHingIZBQrKJMn2MV0g5Mt4bAlGicArMpj?=
 =?us-ascii?Q?MaAZxn2yvKpMwh0VqoRzednvwbrJCB/7T+Zl7SbNHajLM0jqe4TGNSTc0V0u?=
 =?us-ascii?Q?QyYVfjHGUu25fa4uelWIVV62q2g9YZqHR3thBZ3QulCjyoS/AjjgBqC7wYy5?=
 =?us-ascii?Q?uLxBaAnuqk5NaL+0Rxk0r+iHSNEp3LUt25/hOEXCfVLJozwItgY2KmPxVCXL?=
 =?us-ascii?Q?JUN9l5QaFhyg1OXq1B+TID/y6NrHu86ASAGeW5Cfdx+2fkH4tBX0Fs/WN2sU?=
 =?us-ascii?Q?/ehV1Z7Wyb7x3vdw/iSBqB93I0T53jOkGahbby5M5YYsH25fB7OAzz4S04de?=
 =?us-ascii?Q?8MQXzqv42EwtVxBpx9LUXN/mdRA0yFwGO2UEDU9kjj47znB9uQguhwaJZ1HF?=
 =?us-ascii?Q?FhIChI8Iu04yoYf9q7w3635NlCz5uzR5etPCGzH0iQ++cFU6F+qSg5uf48df?=
 =?us-ascii?Q?FDg/FvZSBldLnXj3GGp1yUQhbhq+pT569pv9wD63daYypioFNrEwcB4PERBF?=
 =?us-ascii?Q?lB4shdNXfOFLl6kp1yNMfyB0c2xUEZJ9VcKdMl4hHO9BiQSLQ06BWEvRQMcC?=
 =?us-ascii?Q?X0U/wiRLqUz9/qT0MGVUwg0Kt69tHnUBEpJ6XifBFx4UIOaZQ8PpgsbMfkFC?=
 =?us-ascii?Q?QmFFY0PbSiUxZ6W/iY17JgPEj1mpuK9PRnWltZNwcHdBNenKCQb+4R+Kt+B1?=
 =?us-ascii?Q?rS8g6MvQf+9gDLDJBXWRJv+2HKfRHtqrjlJVrdrC+xw2/cOhvC6+jQ3apBEQ?=
 =?us-ascii?Q?OUDftYPNe+X9tCc+1AXSdtpgra0ewSfXozKF9gcNMTDKqOIGbPuzJPTKazMD?=
 =?us-ascii?Q?dd2uxJqjhzZ9oFUfQsjD8PAVjUI/jhbBJj7Qsvx6YaVxIu3KP95wiLUgZMwc?=
 =?us-ascii?Q?a7d2tXFJNL0cozvtVqA4/25QTgclyV0Awa8xkR6ru/KJloiJAhtnJCvFS+dw?=
 =?us-ascii?Q?tJlDXlnIup5cuCkUO9jZSW6WZM01XlF9MNqnK+QA4+I0TANljIvWvGsRFtlC?=
 =?us-ascii?Q?wUAh2xkUxlPFD2k21b0d6zKgx6G5IUtmWOWNG4+bJhYFjNYAijZWJbiurqGs?=
 =?us-ascii?Q?P8yvO27YPz0EHvZ9jW+BgzT/ndkOyqKHqyItflrjFgBWEfyLIg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 13:11:24.2317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5983e00-0962-4329-ded7-08dd0a2e002c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9275
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

From: Alex Deucher <alexander.deucher@amd.com>

These are needed for user queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index fa30c78f830e..2c889cc2a59e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -826,6 +826,9 @@ struct amdgpu_mqd_prop {
 	uint32_t hqd_queue_priority;
 	bool allow_tunneling;
 	bool hqd_active;
+	uint64_t shadow_addr;
+	uint64_t gds_bkup_addr;
+	uint64_t csa_addr;
 };
 
 struct amdgpu_mqd {
-- 
2.46.2

