Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D764EC43334
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jun 2022 05:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44D821126F4;
	Thu,  9 Jun 2022 05:14:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B3EA1126F4
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jun 2022 05:13:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXjsN9PGrH1XWhNpcrfSwOBToVpxFxIlDQWaP3XT/xb8RleA+fUsL4n6Xa3JorBw3+HJ+TTD7y4QDwW9Q+0XcqjziJlgchDtP0zkufSRJw+RMvZ/WhBXd0CstraVgT3XHTiD8v2saF80fxYqqLnf4NGaYfqtt5v5wSb3ghVcmcqH12uoA2AZrq453u3ex60aB+N4zlwEbIlo8O/1R12g5LyGbVL/N5LFvY+yxjYp2SQ5ATFR6i8WzFjrp7S2+0ilv21+2iebuDErL+jmD7LJSUVDLgppajqlrUQOrLGQg0QTYpZgvf8Xs7pdreIuL3NQvYjC87WH98EYEIR2+ozuBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=br+0ckrubaJM8Oe1pYYhhgJq0l4XBYXNRRQdwUmbUgo=;
 b=Kl4nXl9YArZM4/ssAZkWxevnRw2U3I63RpbkuaRDpE1SprD7lLbpxIFLGPLPRGuTGjS5k+raC3L5SnIHqfJRsOkGyNTWLY2q8M2e3r2/I/lBiAJkPOOR2iIFR8IcUVTM+RG8012NQ4ddTez61BVgsc7uKsow9feAoPQk54qVPrcbsyzKb/fiRBuuNc5DF3ZYs5MTfLhupt0JV3h9Ii6gdX3Ir4lZuPi1ExVdIbHR0okRDKCn1hq+7HGjhA+jd6GYLUjPHv9quFmbwLosthQ+MEudEdsgpmI18FC28w2AZCMcy0iQqUIIsdGEHT4tx//2hq/nx49+NaNk2/B7cJn2Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=br+0ckrubaJM8Oe1pYYhhgJq0l4XBYXNRRQdwUmbUgo=;
 b=C2M3GujyIzdGebJEZZtkF8yDsbsbgfhmmbX9vuBM4HFFuOq6HjxylcIoGrkOi6bIIqMj2Rl+tUqHQILEsxmFHC/3bKKfp+2fZcrWI8h2teqcc1rWp1cLEMu/SNYktHUrg30ixIZUekLyt5RoRLimTZrF2JKlntzmFDnOLTe+oeU=
Received: from DM6PR06CA0026.namprd06.prod.outlook.com (2603:10b6:5:120::39)
 by DM6PR12MB2953.namprd12.prod.outlook.com (2603:10b6:5:189::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.16; Thu, 9 Jun
 2022 05:13:57 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::1d) by DM6PR06CA0026.outlook.office365.com
 (2603:10b6:5:120::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Thu, 9 Jun 2022 05:13:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 9 Jun 2022 05:13:56 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 9 Jun
 2022 00:13:54 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/pm: correct the firmware flag address for SMU
 IP v13.0.4
Date: Thu, 9 Jun 2022 13:13:04 +0800
Message-ID: <20220609051305.3462971-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df493ac8-6595-4b70-dc89-08da49d6daa8
X-MS-TrafficTypeDiagnostic: DM6PR12MB2953:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB295328D44A876FD0041E1517F6A79@DM6PR12MB2953.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eZxBjNvHSnZNAoh5Sw/YQGULlzKclQq+retmKNCF6+LWOYtX0AyHSA6jAMi6LJ1oDpS/Dk/wwL1xm0AUL6TuEUlnzH2szCbubgI7NXPNLtjn9PIHhOc94FxCjayCTBw1blZcAz2c9WAH2+FVYFnI8m5u+dMNdzmX17R+AbaTT0LbIPLw55d4YjI8vIqKuEZi92jYLsfqVMaW/mKxcbB3NlgkZ//B7zCNhplTUosT5Gy6HrWDp03+HW/Ab8DIOBl6QJeH2NJNZi48PIXqHK9SKK1vJ9BteRmDBNZK6B/ycnb2fc7ni4AhiaR1AMFvHSpapNH+ZcomslWLgGUCQP1Heg+MD06JpStHdUlnd45Pq2jWFu1ZZNN45wI9+ulaDamE1EkCdcx30nlFABLlMwDIth2QudIYxCIX4MHb5qQYJLxCdYqqKh+SqXbXf7Z0lCDmNbLiShPFdtO/iM+Jte97tOGM+KC92epClwI8QjEpfjQG7UW6q1Sb9qpuESu7WiWYCeqBymlaLKmP1jfBjbGavUf0yA41d+++k20Je04kDncU3Y194bTxjoRHQszX8I/BXbr0MfgTUL2pUFDb4QVp6r1+qXGnzKp6dlYNG6T0+MfHUZmKGbhBLAqxLyiCuk3QpL33A5VmD80DDUVrp0l5uXfWutfWyE+RKrl7lilPmAMSUxRtZbHVIB6oQvUOT8DuMWm524ShPT1efwySgnM/UA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(6666004)(16526019)(2616005)(81166007)(1076003)(7696005)(40460700003)(2906002)(82310400005)(86362001)(26005)(356005)(36756003)(8936002)(5660300002)(54906003)(6916009)(186003)(316002)(83380400001)(336012)(426003)(70586007)(8676002)(44832011)(47076005)(70206006)(4326008)(508600001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 05:13:56.5581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df493ac8-6595-4b70-dc89-08da49d6daa8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2953
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For SMU IP v13.0.4, the smnMP1_FIRMWARE_FLAGS address is different,
we need this to correct the reading address.

Signed-off-by: Tim Huang <tim.huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h   |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index e3454a876cac..43de0a8d4bd9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -43,6 +43,7 @@
 
 /* address block */
 #define smnMP1_FIRMWARE_FLAGS		0x3010024
+#define smnMP1_V13_0_4_FIRMWARE_FLAGS	0x3010028
 #define smnMP0_FW_INTF			0x30101c0
 #define smnMP1_PUB_CTRL			0x3010b14
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index f9c36d294448..fba0b87d01fb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -273,8 +273,16 @@ int smu_v13_0_check_fw_status(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t mp1_fw_flags;
 
-	mp1_fw_flags = RREG32_PCIE(MP1_Public |
-				   (smnMP1_FIRMWARE_FLAGS & 0xffffffff));
+	switch (adev->ip_versions[MP1_HWIP][0]) {
+	case IP_VERSION(13, 0, 4):
+		mp1_fw_flags = RREG32_PCIE(MP1_Public |
+					   (smnMP1_V13_0_4_FIRMWARE_FLAGS & 0xffffffff));
+		break;
+	default:
+		mp1_fw_flags = RREG32_PCIE(MP1_Public |
+					   (smnMP1_FIRMWARE_FLAGS & 0xffffffff));
+		break;
+	}
 
 	if ((mp1_fw_flags & MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK) >>
 	    MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED__SHIFT)
-- 
2.25.1

