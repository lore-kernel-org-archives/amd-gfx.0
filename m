Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69EDC3600C
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Apr 2025 10:48:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49F1D10E99A;
	Thu,  3 Apr 2025 10:48:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vsBnEaLV";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4157710E004
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Apr 2025 10:48:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKeflrDXU/B0+izjvOZR1q0vW+hmZmbWMsJEGKqqrbjnMfLBDqI6bDQpcHsNV82ZVnlhlmPBckmF5AH4VlN++lPuQtrqUOCoj8wFf/7Ear7Mm+tOO6zaxl00KeQmnoxEZZnQ3GDo/EkSe5UXWtI8OhCXZgpA6Bm2Mrv1TWNGgvOFRWExp93pBwr+F29xQQ+OBs2QUjZhl2lIYNWJ5tgvSrmbZ0n5liTfv/SH+Xtsv2m1tAA/wXnDyHnZiUsVTHOqOA54lve0RiVWNhbY3jsqFfSRfLHoPhdZOz3HrBNsy/7XxVFKyulvpesQTglMVm0tELUxQdwgA4cSTftyfTdQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoFZ8J+ng4RBjTpLwyVd4K4RtKZRDfJL/JZOvnjqua8=;
 b=IRx8L0JqspwVLwY0x95ZpLD3mh75WKoFb/QGNvrSv/v1n7LcECLFkw0zAEGW+02yo5fa+nA1DkfYZxVHB/K+TDEMf5WFwOohY5jKNpTfFJPsiTmORPs25o24H6b6/imuP+h/PdEzOrbp1b93qze/+oX+DKrCVxqojJw9tNQv7D4c4qtqGCPF9BeL1BlHiwRWglXP4jhBYrbC1k4ZWI/sdT21+R7ZSylXjWSt7CRmnH7hnZJ1qe+vuPIREIL/4VV/pDFC1u0DDNRVx7j2KZWjX5514lpXbjY1aY0xQrfgLhTOkJ2rfwSlZKYqRzToWL9yvnXTxNG5drPmmqUsQ/DURw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoFZ8J+ng4RBjTpLwyVd4K4RtKZRDfJL/JZOvnjqua8=;
 b=vsBnEaLV9SX9+FTQ0Xh520jAJqBK9L3AZK70EdBclvbyK5ufW8foOMMulJ6YRoTWxkqyMzpRvt/pV5+r03Pt0/+daJhKIRs6te0GfXii2kYNeG6Et5WTlxaifeFUjUXU1FeDVgsrNJ1BUOnpzxztKYix2wzxf77Y2MC+UTh+dZg=
Received: from BLAPR03CA0103.namprd03.prod.outlook.com (2603:10b6:208:32a::18)
 by PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.47; Thu, 3 Apr
 2025 10:48:24 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::66) by BLAPR03CA0103.outlook.office365.com
 (2603:10b6:208:32a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.24 via Frontend Transport; Thu,
 3 Apr 2025 10:48:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Thu, 3 Apr 2025 10:48:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Apr
 2025 05:48:23 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Apr
 2025 05:48:23 -0500
Received: from RSB-CVSLAB-03.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 3 Apr 2025 05:48:22 -0500
From: Nikola Petrovic <nipetrov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Nikola Petrovic <nipetrov@amd.com>
Subject: [PATCH] SWDEV-513979 - Fix for BSOD on Hyper-V host side
Date: Thu, 3 Apr 2025 12:48:21 +0200
Message-ID: <20250403104821.2507-1-nipetrov@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: nipetrov@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|PH0PR12MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: 716ea179-c0a3-44f9-481c-08dd729d0ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T+Li/7Vnlm1Sl2ydgdkynTzov8MOFZw8iheRW46UGZh3uxbvCt1p+CnOcRPj?=
 =?us-ascii?Q?3IJqRayMEE9yH6z+jD+u3C6GqSGRGHWntU3k7LeHWybfEKZg1r+K2zJtj4vv?=
 =?us-ascii?Q?GvfBMp6DJn3eNR+vLrPu0LgQa0TFLaPK/kU4YyPnqucyvlbhQdqTUyF9gsnY?=
 =?us-ascii?Q?4Wt9lZ0J7iXhljx/4rN1MvNQDTUg6K9IPEzkTeOwIZXNhKmIUxxMcWga30fN?=
 =?us-ascii?Q?kGk3GPFr8w5fo2ZqapmPa7IlRcpN4FqqYCWxocddF3zi5bg/ahqkR3Qrk8I4?=
 =?us-ascii?Q?5W2/+e5OSrB2VMEa+dsytxlOqFWrg8purPVo80Uj7mZYS2aj2LGPmrXl8oKH?=
 =?us-ascii?Q?bhUiQKDdulwPTm0RdTtEKJ3XXUfRoUoV42GhVnW2PRRTNzNA9sofR/cO1xUF?=
 =?us-ascii?Q?JA/TRjMeYlAlsk3tXCNIUIRmNyYE9x6yOezC/BI26DPuZWh7ySFU4RfX1ToU?=
 =?us-ascii?Q?tq++15mRs/e95eh45igdHO0yxfaQ9K9GSI87PI6q70+2aSAzR0jV9ca+1778?=
 =?us-ascii?Q?+VjGRLkF1QXOUXXhwoimBbYmH3odQ5k9wimVOXs/ppxtChQbGhBvbAeI/fk1?=
 =?us-ascii?Q?rZhVgpVjtxJ/zWbILCzP+InhCOcMIHjlPT+um9j5aP+xZHgbGLCNB8lbNkr8?=
 =?us-ascii?Q?hsjhHrtcRXN2mVPoUY9DzBdnpoSdGswVAuy/iBPvpa6vNBjOVnTmoa6YxJKb?=
 =?us-ascii?Q?kxeNDyygFxH98CWvhaMhpAJ/nKoVLmoqb48DU7RUcJ0J4amqIGu5X3FpacmV?=
 =?us-ascii?Q?fTdPZE2grM9uGYJkwDkw8yPo8jTNKcFDYsKPs7Rs+FBDfEA6sk07oJ1AO1Hn?=
 =?us-ascii?Q?Dz/X5jgLa4HJxFMWMPY5r/7KP+7uZLFoO0Up3qYAV6qbEhFNlL5wiyLbOmxj?=
 =?us-ascii?Q?kIt+HwvQz98QvbllgiB5z40hifJIFyQKjrft7/4/naL82d4yH4ojydLgBaEw?=
 =?us-ascii?Q?faqZGb7J/3rVjkAdorF8jCr+TVFP3XHrXm5UIGQVlStrkq5BLUP5JgkULRVa?=
 =?us-ascii?Q?hkI2quMHIVdxAt3FH1IYpE/5RoUjfBx0mQ7fd/TsvRGY58wTcNP/fEEkfOPH?=
 =?us-ascii?Q?mZKW5gcfwzM10eAYZLWiZ1w3c4vlk8XMJ53hNCaSB9VVRMMy5eYHYpJes38/?=
 =?us-ascii?Q?WAkPX+sySdsX93UyBxvuUWVZ68Zoxx+lug63F3M82VtCIjQhocOYzkksuVDs?=
 =?us-ascii?Q?CiZJ+Z5dpWzl7Hy7sfXJOAIjIy7mOKV9oDUHxKG86zTpXycj08LnfwNBhJaO?=
 =?us-ascii?Q?nGZRPzJM6KJYkXJFLYyCRaBh6By/wmf07A2JTX08vUX4WZsdVnc5WmtaWtBt?=
 =?us-ascii?Q?hquq5d0OAI1wJJefiYo2JZMUODHAleROlJGBzFCxsxmyXSbke9d0ZeZukObT?=
 =?us-ascii?Q?7Zzp2ugEA5Ws4fvfkOE2F+UFY0kFmDMi5vPw88KI7LZl3Z1q58Pm0lS1fMoH?=
 =?us-ascii?Q?aZwVC3FlNE7BeE4cIlDlaeFZkEDVlQATWcF3nZdI870eNDqtMkby3ibn+pkv?=
 =?us-ascii?Q?1DravYCjyYaujxc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 10:48:24.2619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 716ea179-c0a3-44f9-481c-08dd729d0ef6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8800
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

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a30111d2c3ea..0f337a0bdee8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5307,11 +5307,12 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	struct amdgpu_hive_info *hive = NULL;
 
 	if (test_bit(AMDGPU_HOST_FLR, &reset_context->flags)) {
+		r = amdgpu_virt_wait_reset(adev);
+		if(r)
+			return r;
 		if (!amdgpu_ras_get_fed_status(adev))
-			amdgpu_virt_ready_to_reset(adev);
-		amdgpu_virt_wait_reset(adev);
+			r = amdgpu_virt_reset_gpu(adev);
 		clear_bit(AMDGPU_HOST_FLR, &reset_context->flags);
-		r = amdgpu_virt_request_full_gpu(adev, true);
 	} else {
 		r = amdgpu_virt_reset_gpu(adev);
 	}
-- 
2.43.0

