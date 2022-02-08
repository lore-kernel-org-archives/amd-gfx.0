Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9E6C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 07:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24B5810E4C8;
	Tue,  8 Feb 2022 07:09:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2586310E4C8
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 07:09:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmF+TVuBsU84BUjkx3pnG9a0wy0opOQyXtjNpRulqKenPERpPZmtDjz0UpznIaNvhfurs2wyOhyKXqr0uVKbemeKUGfcYXmPg4aS85fal9lqniFmz6AiKM40wUEnfce8RZOLXWwuCgZXeqesMOWIhlWOc92LS6XZKjyXkI9tfUp/SncvHt26GdeCvU6IdVFmPfKbaPk+8cSbt/ikQ6Wsmt2RV1Uu5yTeFz8mPLAfq3VaUeYwjCDkhB/ag/K6gUerIMtJPQpuXsWkWvnVSNWmLFGqcRc97dJdEluVWXRK4NBvfhsis61OTVlOCNi5gO05Lwm/12JFU/Cs7QhUDb7iNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NP9KjQOqh51N44AgQyTGND4k89p8Y1u0y1tPOTFJkk=;
 b=YcRoZcHdFHTb+L1rpRdCkMNVkE08GxoVhvlgx2nwMPy+Ftjx4qJwzV4o7nGjY3ZHNWSUKb4m0hd0hCUtjC/y6o+/QYJv+80FzNTxiouJ3kxl1zUyl9YVSK7u3g3Z56YmryHn2UVWNzhCjGUOc/iG1QFCrM8Bbfp7nlvJAvFz/CYJKg/LmyuXySARd/BPFQBWmbh0y69jER8YJQv5iboY0QGJ7Bnl28OJzpBIVMJ56OXhsna2CviW3O5bz+JjeWboaXVvu9kg89M2ICFYWCz+y1FZ+yIlqWS8CejC3JRdn02pQg032kKeVuxh5TIKNpiEoVtVsh/+XZwv7JOzj0NMBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NP9KjQOqh51N44AgQyTGND4k89p8Y1u0y1tPOTFJkk=;
 b=prP9SGqh0Sqc5iJWEx0YaANfZMXFoO2SfG4A/WMGe+a1PsXdzQDNSz1W/O8CKAhOS7MkNZTLKKCAPXHUfs+kJaP8H/w/rde9zGkt991QpPewaIPAiSKpjapk0HShy3bWYMN1MchscSpAR1VI2Kw3o7NkeB7PwkF+9fsBd1/ptwY=
Received: from DS7PR05CA0103.namprd05.prod.outlook.com (2603:10b6:8:56::18) by
 SN6PR12MB4750.namprd12.prod.outlook.com (2603:10b6:805:e3::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12; Tue, 8 Feb 2022 07:09:13 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::78) by DS7PR05CA0103.outlook.office365.com
 (2603:10b6:8:56::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.5 via Frontend
 Transport; Tue, 8 Feb 2022 07:09:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Tue, 8 Feb 2022 07:09:12 +0000
Received: from kevin-ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Feb
 2022 01:09:10 -0600
From: Yang Wang <KevinYang.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/pm: fix hwmon node of power1_label create issue
Date: Tue, 8 Feb 2022 15:08:28 +0800
Message-ID: <20220208070828.337043-1-KevinYang.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66509f61-a973-41e3-1954-08d9ead1e924
X-MS-TrafficTypeDiagnostic: SN6PR12MB4750:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB4750537D38D1040615F4F773822D9@SN6PR12MB4750.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CAGB9z35w1vNgtezBaYDyZREg9XL7+zgnz3gWPsuZc5UYxokOackBAJI5nKlTdf4ycr1vp59ibmEXUk0WU5QfK3n/uwpJHGjxtc3DNSAeU4fL7Pj49vkUYT4K5kbW/uSpMSy47JaN62THD/EvdEY6uC28eoS5Kypfw254sitVgvzfu/CILpMbavCrG8oH8HUcxqIOKgHCQVjZWx6JC6vblvXF70H+jR+jPDP53jB3U0Wuhwu25BtODdtrFMDdlMVgSzlMGU/62Mik7ejc3dHijSxNBTyQWiRuw4dsO5tVaRahAF33MWoZiADFcM/fRyeX5mqVKdkx/RuHTKz+XrimzEUmaoxkgnao5zsS+xahYIvdLkVwZgFcaWM40CC67vp6Oszo4j5qT/+zz+MRpk49npdlvoYJBVomyawG5j0ZPMT3aGTZg4Tz6EKuBj1vCkDWvj9D2kCNhvS/XN54WfxMlFv/wNJK5xYv+wp13U913mmXBQJVP3nx71vdnnolUDXFheYssATPhaNXIQEV5RQnSjDnmk0g8CJNHvpeH+Jod0No7Fl9Yn9LQ7swreIr2jBLyynFt1K/dJEyJJuj0TermDbL+fzXkR22D09luvXTwvv1laIVDZbZC1LS6j7sVA25D5ZZTnCFbwdT0RcGOFDytYYc9Xc55qjN9pZCRlvyL1f+bfYx8PSbEdNB2iJ6seUzoBR79IVmPlWYpxm4XWX+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36756003)(6916009)(70586007)(5660300002)(16526019)(316002)(2616005)(186003)(1076003)(26005)(2906002)(54906003)(356005)(81166007)(82310400004)(6666004)(336012)(426003)(7696005)(508600001)(40460700003)(36860700001)(86362001)(4326008)(83380400001)(47076005)(8936002)(8676002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 07:09:12.9063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66509f61-a973-41e3-1954-08d9ead1e924
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4750
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
Cc: xiaomeng.hou@amd.com, lijo.lazar@amd.com, Kenneth.feng@amd.com,
 Yang Wang <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

it will cause hwmon node of power1_label is not created.

v2:
the hwmon node of "power1_lable" is always needed for all ASICs.
and the patch will remove ASIC type check for "power1_label".

Fixes: ae07970a06 ("drm/amd/pm: add support for hwmon control of slow and fast PPT limit on vangogh")

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index d68e7132da2c..d6c01c59f32e 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3288,7 +3288,7 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 		 attr == &sensor_dev_attr_power2_cap.dev_attr.attr ||
 		 attr == &sensor_dev_attr_power2_cap_default.dev_attr.attr ||
 		 attr == &sensor_dev_attr_power2_label.dev_attr.attr ||
-		 attr == &sensor_dev_attr_power1_label.dev_attr.attr))
+		 attr == &sensor_dev_attr_power2_label.dev_attr.attr))
 		return 0;
 
 	return effective_mode;
-- 
2.25.1

