Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75E1C83F01
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Aug 2023 05:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D78310E4BB;
	Wed, 30 Aug 2023 05:57:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2140A10E0D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Aug 2023 05:57:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OM4KshBP2r/4TGpRWCDsrPCmXlYScu/fhXNC1LE+OGa7y1V+zW4MeHnamXZzSXXtuspoElXg2W3n0Ypl3CoU0RBvwPmtzGQz62vKztI/UIXqhNMX5Sok2w4WeUpd1jdAVueMWYTN7FVtnaw5eMDTg6IJQSqswwsA3Uk1vNHNPEd4gnQRRhV81stMwz1FD+M4x/nFz0JOzOVrTlBYyz1ctfQT7kjgAchrXDoZglr1t5FYrFnBS4wrGAvrGilvcUs+9J2aah4RtqzolzJzECBN2NUdUkfjCZmAp2Fyb4H8upKe+Qhjk1wqm8E/nCyT6LJhnsAegJ0uPUXthuzXS0pbxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGfy0XEnQhCBKqhrV3zAhB1Bu08NagnLhMkK/B1CvPs=;
 b=RQzY0bO4QZ7T1QrSDPfmEHtkJHKz0th8QxayBgSxuTivvpXHCngaOQUGa83J8LYtNwoPL5D85tJbG3kIiypU78Ttuc7j1JeLo2xmJv6ZG0DGsxdc3af3SuQ0p7zZuYCbhuCBtlVsZJrEpL4kb5kNH22algP/hHXcAYvoiaglrYTkULP8A6pbNwqeEFgTNeIYvyAUpV3ndMa1JqCx4tXmZJJ53vViAfp7Q4whVdhyxV1zpMS7TyCajdqmSo2Be7rn+TUPZsSsLqkEMfLytRxZWkyXFiv3wERNGujhQKg96usyQesLt20FZ/Iz/SinJDzj+/SJBbv5gjvd0h8nznYySA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGfy0XEnQhCBKqhrV3zAhB1Bu08NagnLhMkK/B1CvPs=;
 b=zm+dH948z2CzVThT90Ho62iqhWY6IT472PItyuVsKNKWI5ehXjjHZGz1IzIJsSCWZZeTYMwMw+yB+VrwGraz6vGva+kzIg7zXvHZsxpt4DKouS89+f56tKeZOhKGrBEed+ebclR3wbmYffOZwhOrHQET6R/tUmDoji8vJpMRc9c=
Received: from CYXPR02CA0081.namprd02.prod.outlook.com (2603:10b6:930:ce::9)
 by CY8PR12MB7610.namprd12.prod.outlook.com (2603:10b6:930:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 05:57:03 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:ce:cafe::66) by CYXPR02CA0081.outlook.office365.com
 (2603:10b6:930:ce::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Wed, 30 Aug 2023 05:57:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Wed, 30 Aug 2023 05:57:02 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 00:57:01 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [V3 0/7] A new set of Linux OD interfaces
Date: Wed, 30 Aug 2023 13:56:41 +0800
Message-ID: <20230830055648.477908-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|CY8PR12MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e1597b9-f33d-4adf-14df-08dba91deec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X4JPg61kD/AiOpatyQ3PtEewi/ICYy9F6LOcR6juT0AgmZGODRszNdlWcYT+37U8ALw32/00TrScZMXTDf9NPYHHHjPrxEDDMZiHMQ/P5Dshe1FxWGWKNUuyvngjn1URr7Wcd2hKsAW5Sm15J69zOOotarUZkj0PcH9faactnrvQTBu0PnLlE6qSuV4bWIKdYRcrjr5VsBL7qJO7rqcV+YwCsMhOhOxSlgsZsRDHRxPuw7IzruDGqKLBFk2vZujSkUgGIM9FErvusQJ7lZEDfbL5JtaUk5ooif3gu1kWoM9c06q1J5EtZ4HpUDG8/uVlu0TzS9ezrb3d8nk5i5ftdlpXZ9kdubHXNwVKXNtY1FrOYqATC1AXsKESM8Y0dvM+SW3/8Ga6YLAxV1wg7oFAT5baPVX9aUeIWg+UVV9FLeL7G4WcBPVq4VHTNnrSQblzsEikQAyR9gPb8j/oYw6ic7CsOL4HE8dTu78P8I1mzm8CiWCLdlyhuJvHmAr503ZA+MAc5wsm3E56J/VehR07Bk2/Q1P2qfPxgOXKJZTE1LCUJe1vYRf5TwTPOH/I2XByKTf1uDpoOIqTAuKFXNHaoP4rEr0rTBJSELjm7FlVjVAQdba5ETxbfSJwn20r5QsrBQrtUnc1vJ+LOHHjsLusJtnsFhTUAgmMTUz2VQH8jShOc6GR97uluATJhmVj/lFOo7g+sp25QE7gaivUWOlghK4FV70jQTBT6lHKPLCv9+1Ypej7hQJkbG90U1iAOQehoszGzcRNtwk+na7Si8Ki5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(1800799009)(186009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(356005)(81166007)(82740400003)(8936002)(6666004)(478600001)(70206006)(7696005)(70586007)(54906003)(6916009)(316002)(41300700001)(40460700003)(26005)(5660300002)(36756003)(1076003)(16526019)(44832011)(8676002)(2906002)(86362001)(2616005)(36860700001)(40480700001)(83380400001)(426003)(47076005)(336012)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 05:57:02.7264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1597b9-f33d-4adf-14df-08dba91deec9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7610
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The existing OD interface `pp_od_clk_voltage` is unable to meet the growing
demands for more OD functionalities. Since the buf used within it comes with
size limit as one page. With more OD functionalities added, we will hit that
limit soon.

To better meet the growing demainds, a new set of OD interfaces are designed.
With this new design, there will be multiple interfaces exposed with each
representing a single OD functionality. And all those interfaces will be
arranged in a tree liked hierarchy as below. Meanwhile all functionalities
for the same component will be arranged under the same directory.

gpu_od/
├── fan_ctrl
│   ├── acoustic_limit_rpm_threshold
│   ├── acoustic_target_rpm_threshold
│   ├── fan_curve
│   ├── fan_minimum_pwm
│   ├── fan_target_temperature

Evan Quan (7):
  drm/amd/pm: introduce a new set of OD interfaces
  drm/amdgpu: revise the device initialization sequences
  drm/amd/pm: add fan temperature/pwm curve OD setting support for SMU13
  drm/amd/pm: add fan acoustic limit OD setting support for SMU13
  drm/amd/pm: add fan acoustic target OD setting support for SMU13
  drm/amd/pm: add fan target temperature OD setting support for SMU13
  drm/amd/pm: add fan minimum pwm OD setting support for SMU13

 Documentation/gpu/amdgpu/thermal.rst          |  30 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  39 +-
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  12 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 730 +++++++++++++++++-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  14 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  10 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   5 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 298 ++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 298 ++++++-
 9 files changed, 1411 insertions(+), 25 deletions(-)

-- 
2.34.1

