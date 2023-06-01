Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452AEC77B7A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 01:59:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 997B710E1FE;
	Thu,  1 Jun 2023 01:59:37 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2075.outbound.protection.outlook.com [40.107.96.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7E4E10E1FE
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 01:59:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9qqRzUlRSZT32Ese7lANphl+ywaHnf4CRgCA1lA5liDptvqJdvhzAHCng/HSEdbHTtwu49WfTzeXvZeWSTh0AoohEyw1drt+jSu0o5E9FRC08PoFQPC7GW7Cza3AtNBG5IZoQDrCOVa3mDRyNk1r7hKfjFVldhFpNRT4sNU51m4gI/feL3faZy9cdEDyxNoMM/c5Dj6/BqRC9j47+Jlomd+wUUFRC29iWope9kP1JO7VedNkrg/MrdsR2BEo6JTboRUuBFDbDQ6VPdU2A2Puiry+3Mi5xCLxgWkyzHx7om9eZXL3TlTi1rTpw5XF4xVB/Zp553+YJuKzPnyXItPuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Fbz2ExfIS+hhProur3HmwFuErx7cKF4ttIgFz1GkXg=;
 b=HQO8abEhcU/udwLK0zLNOlbNpDUJix6SbJoowGekHJm5Ksw/YYqUsT/ZgoXlplM9rFlGp1aGPcFOzj1+1iW6TigArPUssVeh2kWlv7/c5X/74hGJBDNFVKJYEsy4w1W7lWcGMSm8hPPoY+Z+6lx0I8RUcwQtY/wxyapHVHETQ4bfgFIZMwgA0gb6IUTobjVXW6Xft7ufM99JuHzvM6+l57YoF//ja0w92UNibbaQhqofq+HLhbCl7FfamKFZ143GQR9lSyrHvYW9qONBcScYOqQ/Wu+mbxLPDCh/y+WXcg5K1NyUIRH6twqjZL/Tg8M/8bp8e3q8obn/TfPrML1Y+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Fbz2ExfIS+hhProur3HmwFuErx7cKF4ttIgFz1GkXg=;
 b=zOK1Ur7DZ88WokB4bft0JYU41yARfEsLFrn1mtUJ1CXYNBx59hZF6+ZMv3a1Jy9JV2jYkrinjTehhGrC6yx8fFAwzt9k26rIYaOLGxJtcONkzxsd5uIIPkn8VR/jYw08mU+UydDFBO+A4a+eNms2jIZjycxDZZwhOX10nHU1yMU=
Received: from BN0PR07CA0007.namprd07.prod.outlook.com (2603:10b6:408:141::24)
 by DS7PR12MB6046.namprd12.prod.outlook.com (2603:10b6:8:85::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 01:59:32 +0000
Received: from BN8NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::83) by BN0PR07CA0007.outlook.office365.com
 (2603:10b6:408:141::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Thu, 1 Jun 2023 01:59:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT076.mail.protection.outlook.com (10.13.176.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Thu, 1 Jun 2023 01:59:32 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 31 May
 2023 20:59:30 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/4] Enable legacy OD support for SMU13
Date: Thu, 1 Jun 2023 09:59:01 +0800
Message-ID: <20230601015905.49427-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT076:EE_|DS7PR12MB6046:EE_
X-MS-Office365-Filtering-Correlation-Id: 85596a4d-40cf-4d37-a521-08db6243d792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +c9dZHyRi/P86707GvIuqwo+FmoUL8AFbHZ7nuB5QtonsVHPOqBYz6NUa9UM76tjefZ9YubHoTfASy3Rs3UDGgmA0T1E5tZO2/MC4Pazhi07vOTnQhi6MYP5ioxwKO0pSop110D51//aVYgHJkGSR1jtmgcOaM2OjHlrCtWMyzFVDszV08n0PkXJLF/0ssVlEOuSviDBntCGqjywJ38seS3lbgrf0D5SCehPebNGYP3BGKi7jVgyZH630Eh2NrNPsgX1LF98jjnF8wXa7l8Kzg18tvc5XOJGuF2KuVpTXies08EF+U0kaWbyJZ0QtwlDUMwlzBuTaOGhdcTNq2ZvH4TWfgd3dzZ5YptEEUFlDJKy+zVMTjwvAjGj0UEMaZZL7j9q5upZG38Lp7jamEDA7ChzTRZNSfJwU1h6+v1hGl7VoaRrbtNMIPbmVWsLSBBgJ1FeV5ERmkEpqSurwRRNWASnHjA1koEcH3Ap1X4+8KAhhgkut4TyqSJCfSHJvYWWxn7ssdDzdHcOCQdn1/Siegn8T7KeFMbsM+awQNvPhmvLpw6oK2cQ1zlULOvCOqMGOyw94WBSsPMjjTr2xj3VwQZ+kUmVKHY1rp9MbKbVlFBMUholjtw/HAl92Y7DFxzXdfojspDzHCShIwJHD47K84FTDN77pj4yLNenhpxIoI5GQ8zjz6qtMqhF4j+WGk9ZLJe63f5fulnIfyKgrnvUL2BpMaL3VPeL9G5r+M8dPWa1ZlKS4K/pYYt4ukCA6W/kmuTALKJxkiXXTFdtcktdOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(44832011)(70586007)(70206006)(6916009)(4326008)(8676002)(316002)(41300700001)(54906003)(5660300002)(8936002)(2906002)(36860700001)(40460700003)(7696005)(6666004)(478600001)(356005)(40480700001)(1076003)(26005)(186003)(36756003)(426003)(336012)(83380400001)(47076005)(16526019)(81166007)(82740400003)(82310400005)(2616005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 01:59:32.1631 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85596a4d-40cf-4d37-a521-08db6243d792
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6046
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

Enable the following OD features support for SMU13:
- Maxinum and minimum gfxclk frequency settings
- Maxinum and minimum uclk frequency settings
- Voltage offset settings for gfxclk v/f curve line
  - This is quite different from previous generations/ASICs. For SMU13,
    there are six anchor points defined on the v/f curve. And what user
    configurable are the voltage offsets for those anchor points.

Evan Quan (4):
  drm/amd/pm: update SMU13 header files for coming OD support
  drm/amd/pm: fulfill SMU13 OD settings init and restore
  drm/amd/pm: fulfill the OD support for SMU13.0.0
  drm/amd/pm: fulfill the OD support for SMU13.0.7

 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  26 +-
 .../gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h  |  16 +-
 .../inc/pmfw_if/smu13_driver_if_v13_0_0.h     |  18 +-
 .../inc/pmfw_if/smu13_driver_if_v13_0_7.h     |  29 +-
 .../amd/pm/swsmu/inc/smu_v13_0_7_pptable.h    |  16 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  13 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 488 +++++++++++++++++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 487 ++++++++++++++++-
 8 files changed, 1038 insertions(+), 55 deletions(-)

-- 
2.34.1

