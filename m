Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AADAC369C9
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Apr 2025 09:01:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEFA510E1F6;
	Fri, 18 Apr 2025 09:01:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KU8WbxAU";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E84A10E1F6
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Apr 2025 09:01:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yENU+d3Ngwko7k+zBxj5j7n7E7kWFoNTTiLk/I7snL1tdX9j+IFS6/+5WqqKS+iOUwEDaYsVv4Qc8k+9PIdKCN+N0yMlSmHvZSBJbqZtMyuNr+1RyQMZKuuaorR7hbzQqFk3QYWXdijQsEmnmgHaUdUHpz3xDPsztSI2lrR0hC9cEA7zBC5o+5WfyPGFKz/AluI/QQPwDZloAfusWbpJqP7edVPpfr+okVyGbO55R87tux3qjlpDoV5V/ceZ94dBkjwR8i/8N/Cb6oQZDu1vUjFzABv/i1poLrmbt2jZjtSmiaRaBI81xjKYdYw+kUiasAhgZQrnnrsoSp7gl8HaLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWoPtdQwylgiK8cCNQLSRwhbsXQizPVsaE8KFALSaUw=;
 b=bZF5ljc1fTcHvglAW7k+qv8ZmfAPs4EXqTipIo6rjhoKwovEdAObH5oH1h39ubSep9X/3MiGiWXqhKNhBQh87V3RWyWH/3ELw+zH0QTtIWNSV21cTDXvLxGRlue+r/7RTeKUtnLPOCCcbd+QW10XoJy/N1j8cJoFRDMYF4THDaYh4YcgxXlnEbHI2inqo7+ueXjSyEvacTFKInXEPhiE0HKDmLOh7b8uhA0OBC/7/47PPqyl924Hr7bdUWAQ1phQuKaSpdEydbUmQKeMV1X1Lk1dhMTNCV7CYMtfMFN3uxsm5im/+Ese0UbF9HYcurbLe8Kqqi3zacalJM8tjNEHiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWoPtdQwylgiK8cCNQLSRwhbsXQizPVsaE8KFALSaUw=;
 b=KU8WbxAURLqn/OynK9uKC+0tP9owWldSdTR6ulpnqiYrpmC9JMjVC4fYp9fz/w1LvEcVnokq9wKQijDuK01FPuksPqquWAy4+8kp1aye172ZjiRAMFF+FS+6chREZzFx4HSc/EsUOQ1qlIkZ84y3qTMMfI+0ch++8M8eJfuPkBM=
Received: from CH0PR13CA0020.namprd13.prod.outlook.com (2603:10b6:610:b1::25)
 by CH3PR12MB8583.namprd12.prod.outlook.com (2603:10b6:610:15f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Fri, 18 Apr
 2025 09:01:43 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::12) by CH0PR13CA0020.outlook.office365.com
 (2603:10b6:610:b1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Fri,
 18 Apr 2025 09:01:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 18 Apr 2025 09:01:43 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Apr
 2025 04:01:41 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Print kernel message when error logged by scrub
Date: Fri, 18 Apr 2025 17:01:27 +0800
Message-ID: <20250418090127.122831-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|CH3PR12MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b4223f-f80c-42ce-72eb-08dd7e57a3de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Bk1etd/1ltXo6hygQ1ZsgUPnnwGTMkEss8hMzT8Orp9y1hK+/6RIGDXsH26b?=
 =?us-ascii?Q?NyA7lGrWadoxuDGAF+/OMVZNxaxC708p80j/tHGht8uDsKjudAXn+zLV8NOy?=
 =?us-ascii?Q?arq3fXHUqatmsD1rEbxJdv/V2Bf1qr8J4hAamuDF69yBW4vYWvVtXUHEtHFj?=
 =?us-ascii?Q?oWQzP6S2UDdNHrWRRRRTUltrAV0gQIl6xfvyvWzP5ASKZ95hV0vCF0IbLjB6?=
 =?us-ascii?Q?zTI/3NDzMyaHUEAycAZ+3j+cPvhh/yxxo4y82zvIey5TfCUETqhm4q7TW+l8?=
 =?us-ascii?Q?lqVZhg8ACRzbk6SIWaTwI65yRxFdGG0YxJk7mcgKL4JMiBusNy0ckMgmZKU5?=
 =?us-ascii?Q?8OOT+aPv6yKEf7nCUBMCxyW0CFFtM+R+0hvQ+V8LrJG49XOS7Ejxvs6+QWXR?=
 =?us-ascii?Q?la28zXylvJzcomkK9x0/fVXH0/wrNIOUmG3659gUYqvck3isXpdaXiVhzJjh?=
 =?us-ascii?Q?PiXzzmUDSPgxqRS7Tb7THAUAK4k230x/hV3vpgyNSdXjWNlmm1cqvjhqjYnI?=
 =?us-ascii?Q?K+x+RrfDbYJBA5wrXp9GalpkzdGV6k+ge4dq8jt7dkNLghi/rTGhpHhRL8s+?=
 =?us-ascii?Q?3xSzXVEiGAUSU7gNUjcIlhcCW6lBHBETwlDfbs+/VXHxgU5nJaF4Nq5Ks7Yn?=
 =?us-ascii?Q?J5lEBv9iVPVGmA6GAp+ItNw7/+W88zS4sTmZYaO90QRzgdUt5XMk7CZB26Yy?=
 =?us-ascii?Q?lVG325tG1195diFwlOOVqFJdoHrxZtRRcW3E0W/DbSKuSDJdrI5csG3jlvnf?=
 =?us-ascii?Q?dKa/v+NnS93yBqbfuqE0hyFxbTCCCv97EBeovTygOkF4j3f8F1aWtEm1ApC5?=
 =?us-ascii?Q?6hoIRHXovT8AYiSaWNen21n1vbhj3ANPvN5VR/004Ogw2zq1ychX2Pzq/k/d?=
 =?us-ascii?Q?mIJGXvhDKK70FajyOtVblo9RIIWedHHcZQgVBNtt42VN+WDNIHULtV3MT8kw?=
 =?us-ascii?Q?yIhS6MoG02cAr87OzOZQwKRNyIvYwkD2of27BZ4l5e4bgG2Ry7Sizpez96xk?=
 =?us-ascii?Q?St4Xz+mfzYccw3pGF9JYsLcd78zvK1hlo2ShqLEhJfIKV5sjpKBpUYy1VSLp?=
 =?us-ascii?Q?uNqPxmvFt9I9iwnCx0YTFRtPPXgZJLJilR1xtsVQBwkDZogjUbyNwDc7ZuzJ?=
 =?us-ascii?Q?gFbMB58gRL3yICjFDDdErgsjb/8oof8qSgLwqfXELqbdkmnyb4WH15mEn145?=
 =?us-ascii?Q?SHaMWaRnG374UsI1Tz6U5xpFsudwe2PIG8zehzy1M1IM3cU1s5HiU2+HoVuX?=
 =?us-ascii?Q?ukp2uHgfXW2/w7DcBcBxs3PWdypnBBl8l63AuzNaGbkOVSDL0TKBoA+iobvl?=
 =?us-ascii?Q?EbJTslHTGsKf4vOiiRLzb8vWYEO6qka8reTFf0BAU3SWmZOEfYTKUHA7dtjN?=
 =?us-ascii?Q?dTiTjHcwR+ZRd8Hh5UNYwxIi4xdZmLFyAopYsmzO0LSSY0I0gaA820WWTlWP?=
 =?us-ascii?Q?lXj8EJS5arMN4vFRABsGQVO4ww7+Y9JTqjfpLq2hPOXnxdzgKsF4LhmDyHJd?=
 =?us-ascii?Q?Zm3yLD1rE8Z7I7/bxRVRljfqQOHwR+2Ho8pP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 09:01:43.2060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b4223f-f80c-42ce-72eb-08dd7e57a3de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8583
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

Print a kernel message when the scrub bit of status register is set to
indicate that errors are being logged by the scrub.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index b4ad163f42a7..3835f2592914 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -120,6 +120,9 @@ static void aca_smu_bank_dump(struct amdgpu_device *adev, int idx, int total, st
 	for (i = 0; i < ARRAY_SIZE(aca_regs); i++)
 		RAS_EVENT_LOG(adev, event_id, HW_ERR "ACA[%02d/%02d].%s=0x%016llx\n",
 			      idx + 1, total, aca_regs[i].name, bank->regs[aca_regs[i].reg_idx]);
+
+	if (ACA_REG__STATUS__SCRUB(bank->regs[ACA_REG_IDX_STATUS]))
+		RAS_EVENT_LOG(adev, event_id, HW_ERR "hardware error logged by the scrubber\n");
 }
 
 static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum aca_smu_type type,
-- 
2.34.1

