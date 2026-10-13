Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04060CC6B0E
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 08:25:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8180410F5FF;
	Tue, 13 Oct 2026 08:25:31 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010045.outbound.protection.outlook.com [52.101.85.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF14810F5E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 08:25:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1P2bENSKi4yMEsoca7Fi+lgtK5IBZ9zCWsdkQn1Y2IyxnGG3Fyoi6VnzADXjSM56i5trU+lIa2XoCbUqBG+F7XyxM9/iEQvOJx+nNPr9pTFBLPgntJi7UWbOo7YE3R6uzym2Q+bzrd70DzTBhIeEuMjPCH9McKA1H70S16t7SgsdNB1u2ykESoPvqQtRO5bvC+aNBqt3GpEWyNxGDIeFTUQrmrBZPUkhGVWvY5+680IZ8GRH3uPVyuINLSX/8B/J1z8R9Ts1fw+n0IwVCR9qLZPT9M7f+db2nKThMlckK4yNWCcQ6Di+IJWrTW9W/n0oCu3HLBCYon7O4iMnlWy4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEyX7/3C5vC99KnDrlST0p9xydHi+62oLNc+Egoj9Qc=;
 b=IR2f0I3phnLXOuldSHpqMsrhVfXBoDjU9hlKSNQ7a+cUC0UH6cFWWJRpWAvqFWFIaOppihSwy94OUpsQEF1MvVdaOvHSoCHXaSEqyS1uth6fvkK65wdngJ614gaghEFOVX5Cln5BpvWE0OaNCB9wUx6TJ3saa8jKZaS9Lw8Rehkb5/p1aXN2MGZqiZQ3b2DEXH+RBWZu67+jXuprqXP5hsn6lh9JkkQIWmbyxV/uiCA8rtQwn8Z0wy0H54GrCSS6T3sXMR0anNAt6UiACB9lajsa94AJj9TW3YkCoeRzr/QfL8ziC0lT7WN6Nh0TwWuPMVTIRuSeNdrzhbMGHYQqHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEyX7/3C5vC99KnDrlST0p9xydHi+62oLNc+Egoj9Qc=;
 b=VxAL3Lt7Hr7nIPvHNmgrWMVeJtt74u0iufuOFHxdtB7vT8ZmUGfOCrvRniDfmnvHxuZT5LSWlyaVBTDvs8rVaM9sQ2Y65aW3z0rll8vfe11b9SKei9LJ5FY/DsqO4017efS5iJbIugRflFusFB08dWxmw6XoqCAjqRd7bvHY5is=
Received: from DS7PR05CA0023.namprd05.prod.outlook.com (2603:10b6:5:3b9::28)
 by IA0PR12MB7676.namprd12.prod.outlook.com (2603:10b6:208:432::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Tue, 13 Oct
 2026 08:25:20 +0000
Received: from DS1PEPF00053451.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::75) by DS7PR05CA0023.outlook.office365.com
 (2603:10b6:5:3b9::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 08:25:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00053451.mail.protection.outlook.com (10.167.23.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 08:25:19 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 03:25:06 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 3/9] drm/amdgpu: skip VMHUB fault handling while the device is
 inaccessible
Date: Tue, 13 Oct 2026 16:24:51 +0800
Message-ID: <20261013082457.2492273-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013082457.2492273-1-Prike.Liang@amd.com>
References: <20261013082457.2492273-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00053451:EE_|IA0PR12MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: a720e70e-7a40-4955-3ad3-08df29038455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|22082099003|10067099003|18002099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: SgVz7EGNiJdIZDHV/PkA8/CvnaUgM4DGYeU6CPC4+hLMpfKB9AQRec6B9V7iJTWnf1eo8cKa1qkz2UB7Cq9qyVhfp/WiKBmGJKMmK0/MPEhi80hUElFvdrFV6cM12wOgr9msgbW1nAUe+idMdtAkMNl1I4rbB7Xad9XojD/4qtcn9izj3dJ7TAJ0v9WrSpdfdZOTAXIg8WMIo4kmGC31o8LvWyhUEmtcHh7eX8bCMfkl00Lp7zN1xVlX7PIUY//ffsEFJ+NQpgGsd6MMXLLKFDME/uT1q0khHUqNaC+Kgr6ZIlZAab/KrYDQ65sfE+ZBNv/gpMI8QI5nUfFFayhE3lpm/52ykhFbrvEyoDXo40N0VP+9bdfwVUsAjbO1uSdQmNH3qsY29tTrBG9jmvN5pu7iaYPaxiTSAeKd/5+BT6UQMUA+t/HVlkwShKiTn9ENN3d1hBezP/TX/loOCWsxS3LsqX92whr1LGnMEHj6zA6jggTki4eHeSSlnYNCG/hAqbGw1qZu9df4NbnzO6J83zkcudIF7l5LKKss4dtG+QA53tBTK02RG+tiUOj4M4VRCFO3A5pzcRF0JNCm0uGKM8wwU9iwo9U2cD2xCVH9IMFi/9V2vxGiqt1GW4Om0Ko4ksLd52YMzbZf+1tN7pstSDWVxAXMRjn8FYEO6YLCvzMYCM4WaZGV/bT7jZKu520/iylMWglciGdpa1waA1trPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(10067099003)(18002099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mBx2lU+leekfEMbned91VmtXW/Hv7IyvwOi0tMiPRpwrteCGlOaczHrOPTJ60zeSgWMGZZW4HTsupGNRnNnYLjv6PbK0fT1II0zzSaJN6SxdjMmcVL8Erw+2BciNjbpSK8GWOzfreazaVr1g6V7qMDGZcgoAILPSCE51n7Hxb88I4ejJXOgipbIZSmnN0enroF+Gj7+iCrHkDDL+px7gGUTuDm9rNivpR3hyOKgSaPkPs7YnVzwUJkcKmh5xJg18umDv23dpbyIjNe8vf7tHjx6pFCWRfeFzcW7n0oXkQsU14PYWBY5M53AbRaODoO/wAF1Q1JQVIP3Dbh7Vn6Y7M7ngFa7bdV8Ip7Ps8pAEVCaLqJsUaaf03E0+u93EzHaieTUD8XchNB+eujocDeilt3M/UIUH/TdG4YzYvy/46VSzi8aQMrcjb9GGBsbhkpW4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 08:25:19.0923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a720e70e-7a40-4955-3ad3-08df29038455
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00053451.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7676
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

Skip GFX11 retry-fault processing and VMHUB status MMIO when reset is
in progress or hardware access has been disabled. Retain a rate-limited
diagnostic containing the fault address and client.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 3cdc7893587a..07b7ad753fe4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -115,6 +115,13 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 	addr = (u64)entry->src_data[0] << 12;
 	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
 
+	if (amdgpu_in_reset(adev) || adev->no_hw_access) {
+		dev_err_ratelimited(adev->dev,
+				    "[inaccessible device] page fault address 0x%016llx from client %d\n",
+				    addr, entry->client_id);
+		return 0;
+	}
+
 	if (retry_fault) {
 		cam_index = entry->src_data[2] & 0x3ff;
 
-- 
2.34.1

