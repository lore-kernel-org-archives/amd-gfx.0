Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 796C3EE14A9
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Sep 2023 03:02:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77A0110E74D;
	Thu,  7 Sep 2023 03:02:36 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B6C510E74D
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Sep 2023 03:02:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqBGiYCvxfykFpEUmfDva6oMR3alz4/GS8MHWQasf1j4pBRtWsJoCxlLpChmQISZ/0PQgSdJcLXTCU9M8keWlzw6EjVXm4TsEOZFUDLAM29aDNeCRp5sWb4j7u6pFl3fwjdgTfUXlYN5vwLxkB1u1njlmZ5HxoiQIKBPVm9Mm03HVq3Dbzl5jS/kby0CgJLhXQq0Wzl7+YuSaBlqanKTU6jUzERt6MowGd6ClVD1t4SsHGPilVkhujOBiXuh6e/d55ZNwEAHo3m1twYKAC/x2o/gULImMINrsKKNWRnRczMJKMKQ51YptBEnWnfTvYff/ULUhah6gV84pKaGZdxaog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=myosW9iLBo4NW4qqyKp1oOhXBexElmBvlS6E4V2DcTQ=;
 b=cWhlioFSoxYIZug0iWrS7UBSpAhkego+FAxJcIxw2B+o12dbU7p1xJcf0Pfqm6LouZtIupDIHCxpwXLg93uILTARd0KV50zxpojOQRVKNBNS4aVhPwYSyWIG6hKw+qT2KHTAZfrooEIWcaxcwDQ/1t1IO7X7btRzcGO8ZF+gCvRiluRDTGhmXkw2hDE965cpDqVjB+Nsb+meIh513Ch36avoaisBtbwcqkSfmR/hn5nhiqE5Lhfcatq3nGp00DQ9QL1q0KFAjcv4ut5TL+vbiHobcBqrseCAO3vxZvowBr1ypalAPpSaWCpXIKolwB2mJrvZK3M4mE7jizePf3/5lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=myosW9iLBo4NW4qqyKp1oOhXBexElmBvlS6E4V2DcTQ=;
 b=ImjW7xPmJa9UY9jhpV4PAXITLMb7ngAzNfdjFDjgiKy2CRwmDT3tOAUOfbWinN9OwYyW28dOukRMmpAWxdFp58KUSiryW248BgeZAh7KMeRoiU3s8lrruAoZxHLVXV9jyVkvnZgKIGO7UGOdRyUPSXAFyuTrXVRyGZwno3OSM1s=
Received: from SJ0P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::9)
 by DM6PR12MB4074.namprd12.prod.outlook.com (2603:10b6:5:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 03:02:30 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::6e) by SJ0P220CA0004.outlook.office365.com
 (2603:10b6:a03:41b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34 via Frontend
 Transport; Thu, 7 Sep 2023 03:02:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 03:02:29 +0000
Received: from primary-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 22:02:27 -0500
From: Lin.Cao <lincao12@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: update struct pm4_mes_runlist Struct
 pm4_mes_runlist in amdgpu is conflict with spec Add last dword of the design
 of spec into struct pm4_mes_runlist
Date: Thu, 7 Sep 2023 11:02:06 +0800
Message-ID: <20230907030206.254253-1-lincao12@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|DM6PR12MB4074:EE_
X-MS-Office365-Filtering-Correlation-Id: f417b018-1cb9-4fd5-f3b7-08dbaf4edfd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0yenJcnDrKu/Nf45YF93nydNQMjOtm2TV2EjsTMbOEieMjKuRFYVgxJA+8c6DPguWvfqfDicQ05XsnyZLPq+CDVfE1qNtFSOGdUW+uyjkoWdp0a5L2KTY/IA0N0GHHNvz/f0F0+xSSA/A8dHbe8fO+8b1GyuhmaPVKMS2umJvtk7gqfRcwzhPCCRpRttYtx3QSZX2JYjtgOE99BN7eP0g3YsHe8+auavUsTxT0ZCCy4on7AeHez8X2hmoUEgj+hSltxfnmu0xSM6PRmjwAVWU6HeNWokCjxuv7i7XtAaA62EadI8dl8sYMwA+4AeJZyKKEpbESkRD7wGCwXwqRcyKlxckRJ1F72ie1pjo9OwyKk/Mr7wypj4PY1SmsJ7rV2emlc6/0yjusGDj474sF8y6m1xM3JF2+7YEQWtwPyBf0qo6vK2AbOu5bae1oXvJ388nQUmVBsXH9ByBT7OSAGbWjyHF2MidP7nimaC242idAukaI/Ic9Jdrzohku36Rj8NryCLsGNSem8uIc3NFOC6I2CCuZSsNZQ4PxCptS6YuIyGKcmpLqQvfNht/Q5KzZqkomL2hxYTl+QE01ka+B6kwfzxahK+Wm+qB+2b+rTVzgXpLDEeOJ/ZlYlWbz1VBwcxZkIti/PtJTB/DJV9amOXXDrwGFDGBHbsn4J2XJyX/vvhuxgcqNdq9Rj/0+C8mcsjf9Z6s6DjNShFQWsBn5vUwHUjpGSXdSgZusoqI5hcDqjRhGcC4VpLpjQurH5ArubWwR5rJj4ZRt9xi1G/YuHjbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(186009)(451199024)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(36756003)(316002)(2906002)(41300700001)(4744005)(82740400003)(40460700003)(40480700001)(356005)(81166007)(5660300002)(2616005)(36860700001)(426003)(8936002)(4326008)(8676002)(47076005)(26005)(1076003)(16526019)(336012)(7696005)(6666004)(54906003)(478600001)(70206006)(6916009)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 03:02:29.9301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f417b018-1cb9-4fd5-f3b7-08dbaf4edfd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4074
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
Cc: ZhenGuo.Yin@amd.com, Felix.Kuehling@amd.com, jingwen.chen2@amd.com,
 lincao12@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Lin.Cao <lincao12@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h
index 8b6b2bd5c148..ed937f70895c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h
@@ -129,6 +129,16 @@ struct pm4_mes_runlist {
 		uint32_t ordinal4;
 	};
 
+	union {
+		struct {
+			uint32_t level_1_static_queue_cnt:4;
+			uint32_t level_2_static_queue_cnt:4;
+			uint32_t level_3_static_queue_cnt:4;
+			uint32_t reserved4:20;
+		} bitfields5;
+		uint32_t ordinal5;
+	};
+
 };
 #endif
 
-- 
2.25.1

