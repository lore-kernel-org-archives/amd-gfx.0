Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FE4C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 01:25:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8657A10E51A;
	Thu, 17 Nov 2022 01:24:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4917810E513
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 01:24:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTGBfkWg93M8XgWnnqd2y5OxQIEJtikk5F/vG2t60GttHFi8QDshEKrTlyprtG5ZOMlrFfHaq5xbEOY5SnsoB4bpf0kxL9jNumAmp//RWLAWQF2jx7UOfMvmUOGOQ8XfLdipzy1PMug01IFp+DsdPsl+s9MAlLQqMiPKPxDTVxQ9c16WCNCY/I1Ws+sxRiXakTRz7A+QOhhfG/WNNNrl8+uMAc4bf6wQAU9IHTmFxik6EI8Bl6EGeSsswMXtsSJarimJfsFC2mIzDWqckDri0DSmJNRorxIA9eOz4t0natn9NcMQhMSeeWQ6KkUo1fxKJ2ayLY/XokPXXtQ7HcLocQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3vO93D02uPhYp5GYoILvYiOEFtmvUwwaSqXZJ4K6sk=;
 b=ZbB5EzCp8gTgrEaveElSo2+43hIvY0uTK8Uahc+7Hh3JMMgGlL3q3R0DSZY3nhSgAUGUcXnmlRUmla2R+3qgdsxrNTL5lLVcQUnM4UbzNCbB4DcPKhpYNTbENenSrdkqAJ2kNDZXvQGL/Akea1x/SP0RAFyth1wWzYtlnAlpL9IkKdjjE853vimvWgHW5IVDdom9PQ1wfsjuoZe+c9QLGVRtFhXTdFj7wE+9nCB9+TlnWrjfoTyWWZsls60pQy+VJTQDflPQRxJ/kFtmZAtpkNp62QgiSsvpd7CSDd5Ot+Ow9uC0kXY5Isx0Np/x/gsTaWa3QntBz+6OqmoOZGxo0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3vO93D02uPhYp5GYoILvYiOEFtmvUwwaSqXZJ4K6sk=;
 b=nQ/XdVnestrVq+/XobUVny/re8+AbrY+WazWBfGMN0ADKuOFB++beycT8h9AKt1Na4SNzBafr9TF/5l7y6hTWPWADVCp5o3wWJRIt8oTMZT9P2iCGDS45uTcrAo2qyc8YndBvgOr1YGldwM8cPpIomsCjVFtyw/92GlUVSiyuPk=
Received: from MW4PR03CA0170.namprd03.prod.outlook.com (2603:10b6:303:8d::25)
 by CH3PR12MB7668.namprd12.prod.outlook.com (2603:10b6:610:14d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 01:24:49 +0000
Received: from CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::c5) by MW4PR03CA0170.outlook.office365.com
 (2603:10b6:303:8d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19 via Frontend
 Transport; Thu, 17 Nov 2022 01:24:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT111.mail.protection.outlook.com (10.13.174.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 01:24:48 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 16 Nov
 2022 19:24:47 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/4] Fix reading IPMI data on newer boards
Date: Wed, 16 Nov 2022 20:24:02 -0500
Message-ID: <20221117012406.33268-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-check-string-leak: v1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT111:EE_|CH3PR12MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: a0dc193e-dea0-4275-bd0a-08dac83a84e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6CHWeArgJSDlWOjoZ42SLAX4NR9tnfapjxwIm8K0tCc3RSEtKIW+jOrz7/5zDH0szG3jOCdTMTGkDqudstVM0wOAwYhXiv6IiwZDt1/LVkxJI1IN6mDyqYwPv6PUXK7ATfWVKZ4T7FGGhftNZ3iq6RXDpoVDrw5o4ck7DJVd98N6R+12airUOYntYU2XcWm2/ytOurZYy2BcXh2uKeF1Kp8Y6Cqt16VDF8xPPFY6fwpFK96U8qfyQFMcCXFebYLayTdhrrj1OZtLNMv3qeYXQ/UZuyqA/WBfh4+2UvvgYmIh0gsj2szDxJKqNowcsTdsHMspBfnj5N5mIhN04Hv7w5cMJKoqGg2d6DoLiyEa/M/D6Qd7IsJ67teUJyG3zKSHeHCFnybseCgcD6SO1u354n8R0Q+xACfNObKVRj2f8MMFB5xNblH++nsWBB2tR7fw/mXx88pjQj9NQ5VyPAvQCTrnIf7J1xiDLb8v9t5NGBO4VfQfIO36Dq3TOlCq/+rqVkuORowoJYJUddbgvdwFnHL15x3aYG4O67AW6S9LwQNO4ij/KpA5Eb6qL2Oyuo4gJk4hCnDyKhp8atAJP/oO9Sw6rXnuj3o+yYKfOv4cSritwuoi9BtwUhyTMBRqZxSCCzbOtZzqsn8IawVlMl1htEN8AhR70LsspqkAOdI5XfxW5hEKT4Azp814PwWtHstuhN9TNmJjvmD5oAVhAossBHkQ11GKr7TdGC3KFM7FPq2LXax12dSzQ75zsk3DFSKKrxCTTRHONU2JjAZqi87Ni0fH2+DYjgr7ZaJFLmPTevw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199015)(40470700004)(46966006)(36840700001)(82740400003)(40480700001)(478600001)(356005)(81166007)(83380400001)(40460700003)(36860700001)(82310400005)(86362001)(8936002)(44832011)(5660300002)(47076005)(426003)(4744005)(336012)(2906002)(36756003)(8676002)(70206006)(4326008)(70586007)(7696005)(6666004)(26005)(2616005)(1076003)(16526019)(186003)(41300700001)(316002)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 01:24:48.7738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0dc193e-dea0-4275-bd0a-08dac83a84e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7668
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Bug fix reading the product name, product number, and serial number
on newer boards, especially new Aldebaran boards.

This edition fixes reading the actual serial number rather than the
product version, in patch 3. Also rebase to latest
amd-staging-drm-next.

Clarify changes in commits 1-3.

Add tags we've received so far.

Luben Tuikov (4):
  drm/amdgpu: Allow non-standard EEPROM I2C address
  drm/amdgpu: Bug-fix: Reading I2C FRU data on newer ASICs
  drm/amdgpu: Interpret IPMI data for product information (v2)
  drm/amdgpu: Add support for RAS table at 0x40000

 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c    |   2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 215 +++++++++---------
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |   7 +-
 3 files changed, 115 insertions(+), 109 deletions(-)


base-commit: f9cb9d9b7cfde813d3b2d19dc0016645f985b543
-- 
2.38.1

