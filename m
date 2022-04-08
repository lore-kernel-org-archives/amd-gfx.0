Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE370C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 21:01:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D3FF10E31A;
	Fri,  8 Apr 2022 21:01:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B302D10E672
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 21:01:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEYSUugDYpncWdFnA1/2FXqE6FJJ3D8GoHR7SObDe+0uLZSPcOJ7EDIQ1FU3zsI4Y2RnPCVYJRZz71l5UGVAPKj8FILzdoqh9w5RbJyjNg9AfdJ06LEGPnYpjf0cNakRMo4H6owBtoPeLN1QInPmDL3QUjRTBnlfwe4I3NzTPC6ae0aV/pwlB6nJMYU3uNYIAa/SZaicU1iAroAPjNAYmRM/4pfG9E6SisZWZuzlU5Z9F+Jja0xxGLrzSy/5U3naPhcRkSF+pWev3SaMRip5ltC+Xub4YlITwd7b51pTBMJr5g5rkrEWCxHipuT//KxcTVAuPstXk8diTKfFqbUEWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+Hr/n7PP5uUvtAaVxoGT/vBOBeeIu9GjoSM281N0kc=;
 b=nt2lpxBZ1uY5btgD+hhtC54exV9bOG0IkUDWyzsHyVVuPvENxfX/UN/54JPa4afG23z8+gjhpuVy/GeYQct90gT0zD6Ln2A6xXojpk/ZWpPNI0jZoy4pN/GfJJiQpXXaa7zSA1pmoT4nxt+YEcOXnprnoxQUyae2zhL8Uwv9DBvAE1Xx3ptROdPkFkax5qk5XDHAPPRe2oiF7I0wiD/UTnLJYFxPS1B/Oj5Ea1B0I8vfdCNDib3IQOTQEAbu0zofE/6LY8+fVmMRb9lhs74AJBYrv5L49Bc4yASxJxZIXOxvXKTjVfGt3a5A6WKwVnWmJeXMsbepNh6WJW8lIAwaUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+Hr/n7PP5uUvtAaVxoGT/vBOBeeIu9GjoSM281N0kc=;
 b=hSGVQLc90WzAWUDuyEujb5wGR+bp0dcTpgM+MKG/jjDmyKzlTXC/pZ+PC2aiwkNIzrrOXkoRMZJkAYHLvkEGNz/JbSPGVD/5l7BvNGOLfQy6StjyFmajl/xCyz4nBYFEU/QepudAYDv5NaSvetwX/Jl2JiOMsUw+sRobhv1NZ58=
Received: from MW4PR03CA0153.namprd03.prod.outlook.com (2603:10b6:303:8d::8)
 by BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 21:01:09 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::9) by MW4PR03CA0153.outlook.office365.com
 (2603:10b6:303:8d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26 via Frontend
 Transport; Fri, 8 Apr 2022 21:01:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 21:01:08 +0000
Received: from tuspatel.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 16:01:07 -0500
From: Tushar Patel <tushar.patel@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: fix warning in kgd2kfd_device_init function
Date: Fri, 8 Apr 2022 17:00:29 -0400
Message-ID: <20220408210029.120885-1-tushar.patel@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed5fda06-a5d4-437d-21f8-08da19a2e7cc
X-MS-TrafficTypeDiagnostic: BY5PR12MB4115:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4115F7F7B775F4C617A0C21396E99@BY5PR12MB4115.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ja/8ePMtlgkfKsjPCxzAz6XbPhzLUH5+pKliQP8th36hKoMXY3iChO3cA2ympHTwAVPXZHhyPig/QFFrhGqCOqOuqQe5sG4BsNclINHRsRXAXzf3PyXYjx7EGSu5KHGRK2maIafzDn4x2+r3ZXQVcJyVjSjKzvXtzsjUXqgU89gccsAmmiaZpmPzrMBbuS717AWWt2mbLDvhRBqHvOyYQfJlBOnL5WcSDrwYVcIsYWWAkly22wrqn9I/HLz2sV5uP3cfu4MobTq1iNw0ZBzXKSc6HaW4jXdZc1AYdC1lVX8SoKFeVBDqWql3eRiMKIbsApNbYErIkHBQGJ+fnLv3OzhqHBNnH8b2c9q3tnv3vw7Ky7bWTeLxKVz0NlUuaYELpP/AR+A5szauvjwIkr1QRikvdA6c29KlfrXyJR0sG57hRPn9zSJL++nIB35+FC5aK9asy7lbDJ6tYPljAT1KgktfDn3f1W6SBEuuaSFS7zLnLJCW//e7LQBwJ07ZZu1sXCBk6tvQ8WBW6CF7kkYq0vmrBrVG5JuuY3cy7JdVWhfYfWqXx0JtZUYRSwEl3w/2XjQHmhso9PiMFJHVhqo+/l7c0lsJkxwmO6uEtr75BRY/AQV/TJoHiCisUc/YMIYalcbHwncNogjz55BXrx4A+znFYOpSTV8lshzlNdD35844vnIYqAu1qqC0BtnMSzi7MbtAxGpcZRGumaKWw2U0CA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(4744005)(4326008)(44832011)(16526019)(36756003)(36860700001)(426003)(26005)(83380400001)(186003)(336012)(508600001)(316002)(82310400005)(6916009)(70586007)(70206006)(81166007)(8676002)(356005)(2616005)(8936002)(2906002)(5660300002)(1076003)(86362001)(7696005)(6666004)(40460700003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 21:01:08.8939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5fda06-a5d4-437d-21f8-08da19a2e7cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4115
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
Cc: Tushar Patel <tushar.patel@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

fix compilation warning arising from fixing incorrect VMIDs passed to HWS patch

Signed-off-by: Tushar Patel <tushar.patel@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 0978e1145995..0cd20962b99c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -484,7 +484,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 
 	/* Verify module parameters regarding mapped process number*/
 	if (hws_max_conc_proc >= 0)
-		kfd->max_proc_per_quantum = min(hws_max_conc_proc, kfd->vm_info.vmid_num_kfd);
+		kfd->max_proc_per_quantum = (unsigned int) min(hws_max_conc_proc, (int)kfd->vm_info.vmid_num_kfd);
 	else
 		kfd->max_proc_per_quantum = kfd->vm_info.vmid_num_kfd;
 
-- 
2.25.1

