Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4216EE4996
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Aug 2023 12:47:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9164910E23F;
	Mon, 21 Aug 2023 12:47:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E83C10E23F
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Aug 2023 12:47:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGlCQ/BPQXYrBnvO9hWBjhmv1hoCNLgpyDQ5eJauVY6aqLH4De9JdjXCHPpDxMUIJHm+EWQdRhL4NTJlD4kY5Nru2kP8DEo//8jp0IxpASvjnF1RW/TZOjUW2BU4h96x+2nNO4ZbQmjB2BohaafdXyZ/TK+h/B9C1uumLLyT5CeGI3vTlBM/2UQlwiXuELBCnrGikF88uM2EYUxywaqapdqL+fIvE1eMUDj0IfbXjEhRFEVlvs0OUQ4DmFCrh5Sk1gwVZ3pj+WfJjr+B5BL+c5R5pK4XTVEXQaXiIsxks9lq5HI9Rriu6AybUv2NN3fh27a2tsvq2vWZ1wbR/YU8UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H83YjIEFIR9wf93RSummclKsfQ4wA3SwWja21PFCatg=;
 b=ebUHQsx/YSP4zOOvzHNJOkPH+RtBycquFoYFodlV5sSMO5CO4UPAjDQa7uelvqI6r7NKo/2zdJ7k8jvtGTOzqu5iMFnoMHIw9T2WQwbzQk+5UaIm1EijBqA6IncUI89A0HLLFYro4VId53kGH5s5+rva3pUEhbAzPfICcUB0rApKdExvg5PFYp5dPmIa8OnxbOk0XceANV7/KN2XkpBlVQn5Ys22pHTEtQtBWDGZuBwn9NanI/xre7CMprsiiu75M21SDTzV91yLj+U5jIDOjGm+h+G4SbSSYfdIbqOqFFcZ1LK8vJbo4iRekQvpYd1hPtgcERzMllGwjnzyeTTNhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H83YjIEFIR9wf93RSummclKsfQ4wA3SwWja21PFCatg=;
 b=RGpYXk/8FtnYHh22xkmKTV5iBBSiDtmljAKma7yiXDWpYibHr4SGHIyQLZ+akAn521I4fqzVDgcH02QYcxIPE6WttVlKpYpCfvUTP3lOr0hKQDi10MqPIYDAMmD02sGM1A7OkUSefmx2RnYO66iPg+/I363Z/6nxNMvDD5bbfQw=
Received: from MWH0EPF00056D12.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:15) by PH7PR12MB7020.namprd12.prod.outlook.com
 (2603:10b6:510:1ba::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 12:47:35 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2a01:111:f403:f807::) by MWH0EPF00056D12.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.4 via Frontend
 Transport; Mon, 21 Aug 2023 12:47:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 12:47:35 +0000
Received: from mangesh-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 07:47:32 -0500
From: Mangesh Gadre <Mangesh.Gadre@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Lijo.Lazar@amd.com>
Subject: [PATCH v2] drm/amdgpu : Updated TCP/UTCL1 programming
Date: Mon, 21 Aug 2023 20:47:04 +0800
Message-ID: <20230821124704.3746697-1-Mangesh.Gadre@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|PH7PR12MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fc65468-ed39-4115-ecc8-08dba244cb5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aO10q2mi16z8kWxYmaflkbunCDh+vMQYFESdCiJtfSL57GV6dUa87ewvP9DTmqll16ei9wFCZUc0M0oMtySq16y013c689rlEaA+n0dkRpZmDU1jE+MuN7Imf75DZ5VkgS0mUO8zQMAYxLFM082sMk7CP0DYv76LUGYeb9LX1MHM8klTvOKlUxd4jz5hCcnjn0rMh9q9uA03g9FRBTiwg5Abw94l++jQti7hkhXrUEQs+HTYrTKgjuafUHpUtGBHuZb7ApeCKSHkGj9UTxrSLlyyhT4I4VXt1gjT/lO11DDxgpH6/iEvAS5/3vtUrhTIHj32emr7cR5JXmkqO6JY1icjGtKN0f/e+1KYXy7DyeCG+45vMYdZdW3CU/blN/unoLNE+6VMEzxa53xWcje7AsBbKAs25dFKX9AMRY1EMw+LbPbDEuqV4jNKc/DZci6zAqA8lIan+YdvhlxkilXEXspl7FhiYlD1NOo2yoXht7wFKtvZ8tcMX100kgjrdFNdt5+mZ937ZMNfmp+1K8PeJNtH0NfxdNgN0lbgvPtKD6MjPqW4rJNRpT9WCAJamtAcGRWmc3tw2xbm/DQATVUKvq9M3hEXgUgiq42Qf2vGhbtKRBrajybbPJ1VZiPDnjwzdbcjt6jWknOGuCCZFa+vericO76k+l4ZFOS3wS2rbYF55mSN0oAxu6FI3ZO1Fc0Frqo8Vgx6dpxteAdv7JctBBQscb/3hndKJ8Fqh+F6H0rj6SSooNg4XfLGyqLUaoCpOeUMiPnSuO3wsuz45m4hLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(40470700004)(46966006)(2906002)(4744005)(40480700001)(15650500001)(83380400001)(5660300002)(336012)(426003)(16526019)(26005)(7696005)(86362001)(36860700001)(47076005)(8676002)(2616005)(8936002)(4326008)(70206006)(316002)(6636002)(70586007)(110136005)(478600001)(82740400003)(356005)(81166007)(6666004)(36756003)(41300700001)(40460700003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 12:47:35.4547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc65468-ed39-4115-ecc8-08dba244cb5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7020
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
Cc: Mangesh Gadre <Mangesh.Gadre@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is required for TCP/UTCL1 thrashing

v2: updated rev_id check

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 93590adf2b04..8b84ca80d80b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -203,6 +203,9 @@ static void gfx_v9_4_3_init_golden_registers(struct amdgpu_device *adev)
 		if (adev->rev_id == 0) {
 			WREG32_FIELD15_PREREG(GC, dev_inst, TCP_UTCL1_CNTL1,
 					      REDUCE_FIFO_DEPTH_BY_2, 2);
+		} else {
+			WREG32_FIELD15_PREREG(GC, dev_inst, TCP_UTCL1_CNTL2,
+						SPARE, 0x1);
 		}
 	}
 }
-- 
2.34.1

