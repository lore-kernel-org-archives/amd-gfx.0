Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843CBE81E02
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Oct 2023 14:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CE0F10E503;
	Fri,  6 Oct 2023 14:42:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3852110E52A
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Oct 2023 14:42:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqRgSOs/1RUpe6E1fLLkg4itFSJ8ZEwlekaoiQ3vPWYMW/uhNJzRwivUqa06zUG0wvbD1vuuV3t3BtRVUt5gMGgYY/+g9I2mg9TQma4ktas+EWQ9W3gKox92Z7tjrBWsWsxx1CKJkVmhYs3c5NbIbb/rcmUxy9g381MIH/Nuw+vU779o+do0ABvm8x2eriPtiEqjkmgrVmOMUVFphsCj1zhH3YNSxdYDvJWozbTJXXcSor10/LPSvsFpZ3g+KfHfOpQtbd012orZnrmJhWve2no1Fn4kAIPLzoEZEX11L+sj0kdJyS8VUQmoZdf2+6G2+I+i9o1OSIs+swil4rDN1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zB0b6/eWXovXqt5StPvmYMtyozl/n8HVzfJYAiZE7ic=;
 b=I35yJ2ged1VaK2yUP6dCF5/VzhKCWYbq77+iTC/2afdHImA9dGWt6Kb0Db77jMjdl8i05n+CPUQ2C2lIZTOVowIUEGL8mNxOsWECsY6bfg2yT9M6nDFM6o4J7wczCcLhuKnM6M5QSvClzWM/yJ35xcGJcbzZ8xZrgTa4FKV/7A/DwjLgamsu+tv6Fz/yJXGRwnGLntgEzwaBsI6NouFdm8/QVmihDRod4fDTlhwJQj7Xgf5ZQzu+hmP3fBsex2F52PnBSl0COkawzbV02WWL/mIfQRqcLFABIWSup1OcWmhHlm8vwan9S0TpQ8Q0wwlPJxSyFc5KDWyPqhUZRM32tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zB0b6/eWXovXqt5StPvmYMtyozl/n8HVzfJYAiZE7ic=;
 b=t/WG4qvLgmVNn/Lr8lECIafPEeLa2nfI8urVMvucp/ye+9uJ4VFY6dzJCcuVuZ6HXYYzcR/4sS5BE8TA8cKr+yD2zBcXR/PL3eCHTChRf0Gan9U/P34xetVl8LquBd/BlvcVXBHdnBaP9EdJY6Uh5loyQHyfJI0/97igIi150x8=
Received: from MW4PR04CA0183.namprd04.prod.outlook.com (2603:10b6:303:86::8)
 by SJ2PR12MB9005.namprd12.prod.outlook.com (2603:10b6:a03:53d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Fri, 6 Oct
 2023 14:42:32 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:303:86:cafe::c4) by MW4PR04CA0183.outlook.office365.com
 (2603:10b6:303:86::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.30 via Frontend
 Transport; Fri, 6 Oct 2023 14:42:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 14:42:32 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 09:42:29 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/3] drm/amd/pm: Update metric table for smu v13_0_6
Date: Fri, 6 Oct 2023 22:41:38 +0800
Message-ID: <20231006144140.566546-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|SJ2PR12MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: f30f05ca-a1da-4e00-ae84-08dbc67a793b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OmNpDKt9KKNImGvDLMp/CgAvLadiVK/+PfSHvzaJiaxCRF0VuAMKsvNJ+2TcqJY4TkWK6fREays+UNa+Ur2Ef2GyVTYr6XyBGOe3P4Elg06l2jA+q+G7EssNHrWgDtQTNwXjdbsiycP9o/mNbn6PQjroNCq+M918h+DY04jq8mLNwwpRqlFEmffMfCZMQUIwJ+IE0rlmHZqXgyoAQo6rhZtezlvGQP+LVeXAE9FWZKaQ78wvMSoTd0YjHzoYZm/r7ObiQfKeLDm77KTAExBoYwhbG20Vt8T2AyiWgBQnz7c/IElNjPgdKiibXXGI/2zCPRruci1ISHcxOxR6/IjRiSHgLaPTW2+XfEKAeTkinmIlNpAcy2XdILlBjiBJ8lU+vSSTnxAWwpEPPA1x0forgAb32fMhUbXtiDnHU816iPEvgzIjMRdzn2m9csUKDmNsAT2ygdQwGRxnCFL+QR9aDYPfzGWyk8JToVMKDBRcPUv0Qio+ra/6RKDMRfZ3+P/1nFLtDcYHzKclXmhKMLyYmSdryFK17O0Bd2yOVhDCYMFtnWms5hApC5zSgMC0r+wkA3T3fG4/KcCzsdD2eeC+vYNpAOEbZjreczwhDkc9YtWbV+j3JswkrZcdHvuKlLFxgR8E+a/i99/NXIdIzuaj5EIl7oXeDl3KSTzWu5Y2VYKU12zKbULRR6Dr7Ox5B6xKpJSes1S1qcmj4qDQ7GiTtvw2jH6CNcGN99ymhkN9NZQuCvH0sLPKjEu9250xIMWzZ0nbbFoD6ogaW3UNLIRoIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(82310400011)(64100799003)(1800799009)(451199024)(186009)(40470700004)(36840700001)(46966006)(1076003)(41300700001)(2616005)(478600001)(70586007)(7696005)(6916009)(54906003)(316002)(70206006)(336012)(426003)(44832011)(8676002)(4326008)(8936002)(26005)(16526019)(5660300002)(6666004)(40460700003)(82740400003)(15650500001)(83380400001)(2906002)(47076005)(36860700001)(81166007)(36756003)(356005)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 14:42:32.3133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f30f05ca-a1da-4e00-ae84-08dbc67a793b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9005
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
Cc: le.ma@amd.com, Lijo.Lazar@amd.com, asad.kamal@amd.com, shiwu.zhang@amd.com,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update pmfw metric table to include xgmi transfer
data and pci instantaneous bandwidth for smu v13_0_6

v2:
Updated metric table version

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h  | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
index 9be4051c0865..76cbb4f51bf6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
@@ -123,7 +123,7 @@ typedef enum {
   VOLTAGE_GUARDBAND_COUNT
 } GFX_GUARDBAND_e;
 
-#define SMU_METRICS_TABLE_VERSION 0x7
+#define SMU_METRICS_TABLE_VERSION 0x9
 
 typedef struct __attribute__((packed, aligned(4))) {
   uint32_t AccumulationCounter;
@@ -207,6 +207,13 @@ typedef struct __attribute__((packed, aligned(4))) {
   uint64_t PublicSerialNumber_AID[4];
   uint64_t PublicSerialNumber_XCD[8];
   uint64_t PublicSerialNumber_CCD[12];
+
+  //XGMI Data tranfser size
+  uint64_t XgmiReadDataSizeAcc[8];//in KByte
+  uint64_t XgmiWriteDataSizeAcc[8];//in KByte
+
+  //PCIE BW Data
+  uint64_t PcieBandwidth[4];
 } MetricsTable_t;
 
 #define SMU_VF_METRICS_TABLE_VERSION 0x3
-- 
2.42.0

