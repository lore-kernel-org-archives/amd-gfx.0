Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A0FC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 16:09:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B767610E0F5;
	Fri, 22 Apr 2022 16:09:04 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C54D810E0F5
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 16:09:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLjBjB7OMpjg89KLZ7sKUb6j0CltnZf55MaEEB0Rum0YXyZ4rclL/oPUwMt4ENAwRqfAyyRv/+SiTezzszb2ObGhdR2buQxP1Hgd50jKBRlayQWIKtWv72Wfup/udLmRPkKiW5c+mGgBEMSPKMGUBMNyPVHfe3z1ohEhG620Ox7lPV6D03W/Vu8t3aGlt7ZyazfWsdc7d68qPWG745g1R2bqrgGX/HIwgFnO2rtyaurtcwWNTDFbpGmiWOtCSab4OCFhkDzpGSR3qYkvFDGT3/1FUajcfmcOvCuF2wR3A/djKfLHB9u8S53pXDgHDF/cArXSN+55+plcdcjsy3K7tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c08VStJBDRlw2PFWajOIUmyI+BxtKBHsVn5buCf0DNw=;
 b=HO0QdAqCZj+vJVHbvH+uR0Ngq4OCwFUwqztb85XjQOkAUrG2UEOEBixWx8p65R5JZE1Q6k743/yCxzlpDizelf8sCTlePCR+ErUCZ5oEtwyCAXJaYDOKh2mUaaIraFMF1PBO7jDENqVHngAbA2HiBtsvFaklHpjKXS1JghdozJww1ZTwJzh63DD6Nu18lb2TS8vnwTObmJNMs53oEyeoQIUP5YGlQVpzVMsenauelUzGq8CV+Cl0+F7Vm+2H+fZteyTGiJeHf8z6/002zQQPVwo4gngWMaRaJx4b/Ue7nvIwVXSuxhzB5rvsL+QC7Vqz0JYC+CFfQ8rE6eWliMx9qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c08VStJBDRlw2PFWajOIUmyI+BxtKBHsVn5buCf0DNw=;
 b=a2XY1++48qbDcJR3WQOvhZyB6TRakH4CEi8HbwMzvRbg87obpzSQsFzUdr1UPS+teOYgf0eTPxmiJ8c04s1GZfZcxgvCzQODeLJOPeRKHuohH3SBV/2p5BCUGLV27lh3K39qpG9O+BWsodFepK3GYteg7+2s0vhJDu6AlF3ZAaM=
Received: from MW4PR03CA0270.namprd03.prod.outlook.com (2603:10b6:303:b4::35)
 by DS7PR12MB5743.namprd12.prod.outlook.com (2603:10b6:8:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 16:09:01 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::6b) by MW4PR03CA0270.outlook.office365.com
 (2603:10b6:303:b4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Fri, 22 Apr 2022 16:09:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 16:09:00 +0000
Received: from MSDN-LAPTOPDYU.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Apr 2022 11:08:59 -0500
From: David Yu <David.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Ta fw needs to be loaded for SRIOV aldebaran
Date: Fri, 22 Apr 2022 12:08:48 -0400
Message-ID: <20220422160848.4819-1-David.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e841c048-ad93-4717-01d1-08da247a69f0
X-MS-TrafficTypeDiagnostic: DS7PR12MB5743:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB574332E80977C1586D5A02C081F79@DS7PR12MB5743.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MyZYjpqy3M5VYMuAve9RqIl+7ZEIz6AJK97pOFW7DKkh07rrf9pBBuUM/e5i17xFADLJOmwY6sdPUmagYnKGdHQ3ZpzUlcvXO/DlhsNfTHyAVj0nfu/ba95NSgX7vC3NK7Yn4NY1aEAqoVlHhc/jKOSIvSnxGDg5tNVetqw/QXJDjAan1utrTUfMLwtpPzGFiUoPuyhOfQTYsELI2LGAAhSjPW8KGsaL64CwsF4OtaXBu0XYEcyw09FCI8ekdWIZRdDyTWYT2JTmCuM70Qm7lS1/tBMoop6fRt3SFr9ymmWzed2CffPomUs0ayjQHDV5J/HD/I9RgfgHnM2xs1x/k+7S9b1YwbZdu9mcQpb+yaFkiuR2LLJART3Hvpq/0YUtXWO7zNEiX/iOia/BGC56nIOvD3wGPLVvq8YxalQ++24MdqST3ecfbJ80XWJev7z/KX5VWux6Ett4j1Nm03HMEDYlWjz/9aOhokY8S2vAvaJay8/qLFR9KhAwNXteiNOXersieftvarh9n0umkHc4SqCPZxjNDWUayIhe+g1JEdQI10rnc8ve/U0RT0Go8bNckchJNkKss0DN8rIYDHNQD2VHQ2mXwol36ZGma8uvRiQeh0wD0E3wKM/2v1GL1rWQPIDLO2bGrDmZXbRgGKazufm/3YapO2FFYnXfgCGu9TTVVET/0JZ/2kSKhEfBSLlJp6FCsjZzhIaT++GrtCkzlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36756003)(8936002)(82310400005)(4744005)(426003)(81166007)(186003)(26005)(2616005)(508600001)(1076003)(70586007)(70206006)(8676002)(4326008)(2906002)(6666004)(5660300002)(36860700001)(6916009)(336012)(16526019)(47076005)(316002)(83380400001)(40460700003)(86362001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 16:09:00.5949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e841c048-ad93-4717-01d1-08da247a69f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5743
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
Cc: David Yu <David.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Load ta fw during psp_init_sriov_microcode to enable XGMI. It is required to be loaded by both guest and host starting from Arcturus. Cap fw needs to be loaded first.
Fix previously patch that was pushed by mistake.

Signed-off-by: David Yu <David.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 895251f42853..0bd22ebcc3d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -275,8 +275,8 @@ static int psp_init_sriov_microcode(struct psp_context *psp)
 		ret = psp_init_cap_microcode(psp, "sienna_cichlid");
 		break;
 	case IP_VERSION(13, 0, 2):
-		ret = psp_init_ta_microcode(psp, "aldebaran");
-		ret &= psp_init_cap_microcode(psp, "aldebaran");
+		ret = psp_init_cap_microcode(psp, "aldebaran");
+		ret &= psp_init_ta_microcode(psp, "aldebaran");
 		break;
 	default:
 		BUG();
-- 
2.25.1

