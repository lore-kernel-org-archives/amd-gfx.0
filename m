Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FC2C35274
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 17:28:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D573010EA70;
	Fri, 15 Dec 2023 17:28:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32DC810EA6F
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 17:28:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhHas4RCemaEjuG/IX/rDvwkRIFox6q3RLLepb78qvSJQYO1yDKHg2rlZEDeVy84ZiW3NcbZA1n3SZPqb9JaAb8I9dV2hD39JcwwFVcZPeNKST8Zd6yzn3gq2Hnzwl/8E0I8UPWQoLya1KrGF5w5Twkb7vkQzKbo7oZox+Yr/rnZzxuj9CV28pl5jp2ufOIo9xlckJsqMEkUzg196lUV/ywZ1zpNyVgFEs1Ao6exJ0hEMLzYDbYaCSj709yZFh6y85xvn6lidhyT0REzDgdEPWQsdr4+U2WCS+r4nqEy3HVOQjg5TqdUtc6h+CVkmQh4U4IN1A5olySQQ9OTacsVog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uW3P1x8824oK01iD/g4i5TajiwKSD7sVrHL12ckfa2A=;
 b=ieRYPCt1tREXMnZSbvPav3g4MyrflUwgBw75V2WhTdd39pJyDNpUz9BXUnlNBAlMEvtOma0IpIpWbs3b3NPodf5A5Ke59U1Lzo41bl1HtzdiiOQ/2cdBYfITMOgOdItndG7RLP0OuNRnJNMXJDHPhYmpkgADD4mU3axPd5VVH3CrHY9bkZ1OkMTjSvI65RXOz0wbZucTGg7zQgGcrhVJBCZMy3D1kmIPLAKZAsKX48KzvETcKDOnJTOvznMEGedlWmdjJZDAPAzQAlbPPPUCyuTn0/lODlzUtFkKvs6zg1QMVP1Rko+XSFydKU3HrbUzb/BOoO64uWwdoCP8ufyt6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uW3P1x8824oK01iD/g4i5TajiwKSD7sVrHL12ckfa2A=;
 b=wSG5e7QsdFQPXxyUVro/BU5tDMyBp0I532ukvS4MOWIHOojEbqy46SRrtfZQ7ETeBgZoq56BmMx2iulOHFD/CAOVhvzQJSkP/pzKNtQg5MVlh86bNHn/OacuvnWoM93ODxMrpjyem4FE2x4iXyn4hGV46AXE99C6e4psPs4GAAI=
Received: from BL1PR13CA0136.namprd13.prod.outlook.com (2603:10b6:208:2bb::21)
 by IA1PR12MB6553.namprd12.prod.outlook.com (2603:10b6:208:3a3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 17:28:02 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:2bb:cafe::da) by BL1PR13CA0136.outlook.office365.com
 (2603:10b6:208:2bb::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.13 via Frontend
 Transport; Fri, 15 Dec 2023 17:28:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 17:28:02 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 11:27:53 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/3] drm/amd: Retry delayed work handler if sensor is busy
Date: Fri, 15 Dec 2023 11:27:40 -0600
Message-ID: <20231215172740.15407-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215172740.15407-1-mario.limonciello@amd.com>
References: <20231215172740.15407-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|IA1PR12MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: 030b7459-d508-4a96-c02f-08dbfd93311b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DBOh9kRDKXIBCa5TdZW4ehUTour7dE00NZJiTJMS5bOkxWJXoV6dsf3iCvDfJQ9exZ4m6biwQo6c1tN+jdvcJLzTM7e8BWwUAgX8v/kZrhOl0OlIRm8NiVDJ9LDAgwI+aDPSfFTBVDM5WrLxeJwJBdseYZS/C3Ykra9T0995z/vVEh6Ci4lRYkSJnaeNuxNPbthzQarOJ6tr4BazDKiT173bgsyZcPMA2N1TrLGVnXoOJYgeo99sI8OAGAb3b9P+1VKCfbeSPHI3g80WoFADVcee3dH8iTWtVnbOJAMwOM9/YCtSMlEpqabde3MDIAMgFT9pl5xtyBDkhS7NP2zpOmeq/PIa9d8LFy15deos0NhW9S97XZqR3PfZDPau57UskIW0AuJ3i0P/f/lVH8+T2N0Z5q9gXQ0P/DLKV8Xy/cqIouhJ2eADyeIvDxAXs2W2hmd04J6Qe0md/bTjDNcSM8ZO3KTBrhYtqpJNZQ5Z9XYb6vGSGC2fHcpOObdfEbPCdE3hKV4BEG5Iekr5/lApafltoOmf0JLyFfOb2HPIAztK8Hddz2ZrMD0nhtDjMG8r0w1Kr0toPQhU/yA5KxiiwoKSlF9fbMWIif0xBPDuYRciiP4euPT5rwNNdgl5+Yhf4EfS15SoCgpbA2KL7yAjeeYPNU1Ik+c3XKzJ3Ca86wnV3Z4Y1mHnpRDQibtEnlzRlrqE9M52EGuCZ4phYaxjvp+IQFjhYVSv30eitO6u7EIlDkqZAl3DMMAZ4Zgkef7Vnyg+60FWGxBgqqr48UD0LA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(356005)(40460700003)(86362001)(47076005)(40480700001)(81166007)(44832011)(8936002)(8676002)(2906002)(5660300002)(82740400003)(36860700001)(4326008)(316002)(45080400002)(26005)(426003)(16526019)(2616005)(1076003)(336012)(6916009)(70586007)(70206006)(36756003)(41300700001)(7696005)(478600001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 17:28:02.8510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 030b7459-d508-4a96-c02f-08dbfd93311b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6553
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The SW CTF delayed work handler triggers a shutdown if a sensor
read failed for any reason.

The specific circumstance of a busy sensor should be retried
however to ensure that a good value can be returned.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index b259e67a229b..ed4feac83b46 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1179,6 +1179,12 @@ static void smu_swctf_delayed_work_handler(struct work_struct *work)
 		case 0:
 			if (hotspot_tmp / 1000 < range->software_shutdown_temp)
 				return;
+		case -EBUSY:
+			dev_warn(adev->dev, "Unable to read hotspot sensor, retrying in %d ms\n",
+				 AMDGPU_SWCTF_EXTRA_DELAY);
+			schedule_delayed_work(&smu->swctf_delayed_work,
+					      msecs_to_jiffies(AMDGPU_SWCTF_EXTRA_DELAY));
+			return;
 		default:
 			dev_err(adev->dev, "Failed to read hotspot temperature: %d\n", r);
 		}
-- 
2.34.1

