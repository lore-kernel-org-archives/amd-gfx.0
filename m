Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33381EB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jun 2023 19:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9876510E02A;
	Fri, 23 Jun 2023 19:41:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3F9A10E02A
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jun 2023 19:41:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTHGYwNtl9yifqmfI4+O2S1Eqd+g8RR3S291hvxMRbC3XGl/Knumgw1XwkoVFOOIEa/049j/61ZalzCMeRM/ovHRtaqFYTx6EGjeJi2QjZAK/ghf1nphI/k76/4QgZFFjpfG29KqkG1AarEGZsd4tk/4aiMSXUKtUUSUWLdr3B666YY84ONgx1afria1jjFr/076XRiWPDjGgeJeJW3Mo89kZVOrGE653PdHIJHg7t/B+bKqG1Kjoew4DukeLd5WKbyvsG3m9J1FSptw25cjsv4DpLpFEkg17JjR3RoEtWz9Q07acT76mp+/gFKcINMOdfI+KTgf12HX5tTvNFirmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8fI9kdrTbPQVrWnMKXt2iTdb3Q6N2yLn0EiuCd7CpU=;
 b=NrATv8RO7GaoixHgAnraSseAuEaMGZc+SInk7ECNniMJIXgu1SCmGi/pRF6BDugcMLdJfwydDlIqwZVH5hviV3Yindh9oEmFA994f1sk44XxeQPo5Ukn5yxxlsyqUxu4ISa3lGlK3g8a10FSL9zNAUwuSm0u5t2ZSl9M4oYRnNxwnrPt9WYqOisOzeQLa68RbR8cfiSaYwt4empeLzpQFYsL8KIKpo885Ajc3ftIUzDb1Wa6HBjdeV3xawxT/74u++6Nggvfjw2rzcWBKQf44I5bwhxpQBZN37IDLmgGcoNTNkLGM51V6WbJKNrNoE3IKh5MKwDrpSBW6bdftR4FlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8fI9kdrTbPQVrWnMKXt2iTdb3Q6N2yLn0EiuCd7CpU=;
 b=F4C9sknk0Wo8guqtUoJ8gCyT9RGrBtHWOL4cVx1ApXlbqHvkI85KGPIJexVj5+ncyhHp9KCEqVb+yz4mfkBKnN0+73TQFQf52gJnfe+Z2KgdPYyFc1CWixuvLIwktm/H6x0c3s0q5wSkvKNdg3d/Qp0bsdOXC2oTyq/R8yXR1hk=
Received: from SA1P222CA0064.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::15)
 by PH7PR12MB7456.namprd12.prod.outlook.com (2603:10b6:510:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 19:41:02 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:2c1:cafe::7f) by SA1P222CA0064.outlook.office365.com
 (2603:10b6:806:2c1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Fri, 23 Jun 2023 19:41:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6544.11 via Frontend Transport; Fri, 23 Jun 2023 19:41:02 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 14:41:01 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 0/4] Add checks for enabling PSR-SU
Date: Fri, 23 Jun 2023 10:05:18 -0500
Message-ID: <20230623150522.32494-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|PH7PR12MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: 32aa624c-2383-469a-eaed-08db7421c6ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: smhn9bqpvlrzE+RhZZ/0w1E6NS54jZ+VYrC5dzf2TBhtyRDCqOdYHp+mMQHR2Y7ITU4JQZ4kUZ6w9nHJzv2uLPKRkhCnCP4TfSzfRVDgn0hRYijjuxER+nJfTu/hLYNMT77/AgZJ2GKrQR6zw84qGE8o/v9hg3XxSxx48ymZ0Se3goLvvHW6egC9ipE3mTYT1GJ0Np2MdMXmGy+uaAfuYxfoo4Qihoxqzr0QEMeIkM9YwvmJZ0QCIRLCThsyNHzBsQwkiRA3ozg+joP/Pp+ypzSGLaSk/ZluK2wxYiSBqSOuEwKqzENCTujrGmVFAgPLxjl5u/lsYOeeBaCKpAM0zf+wMvxWucWRVbmZBVHLTxyEC7KLegPlvyflRWKgitL4A84rT2rPY9yq+gE08NhDFzCOkN/ARSACmXFx0xPUg6zYnasKTrdSd2gaWGxtFIQF+qEG50m0eXyxt8lRn50lGyOJBN8neZckzgWJIo4ppNsb4AASdeqOssu8/KY6VQgG6LxFOiRVgNvDtqBDdNpJQVjA1uPvgfzh37Vf478jPjOBNxiIiCQeSJw1Rt2cVkghg6/NHzoUjUsSnH3nEegYuD1n5Er1EzscZDX/S2e4b5QNcRr0gstDxAb9AlFVEmdQq/3qpr1n+Pu58cug3Xc+pTcGjbVRGCjw+j0ejj3eljh9AmKIhcIVK0o4pNCA+mURlvl/WVmoygs6YPUrSdtY+Zu+DzK+dZUM1U4mhaakwXFn5D8Rv7WOjHQhBZwgtmkPYJE4dJjpvA1T8zX9cIOZdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(2906002)(41300700001)(8936002)(40460700003)(8676002)(82310400005)(6666004)(478600001)(81166007)(426003)(2616005)(82740400003)(83380400001)(1076003)(336012)(186003)(26005)(356005)(16526019)(47076005)(40480700001)(7696005)(36860700001)(54906003)(86362001)(36756003)(316002)(70206006)(6916009)(70586007)(4326008)(44832011)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 19:41:02.2615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32aa624c-2383-469a-eaed-08db7421c6ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7456
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
Cc: Tsung-hua Lin <Tsung-hua.Lin@amd.com>, Marc Rossi <Marc.Rossi@amd.com>,
 Sean Wang <sean.ns.wang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There have been a number of field reports of hangs tied to PSR-SU
specifically to Parade TCONs.  These hangs are fixed by changes
in DMCUB firmware for both Rembrandt and Phoenix. Add checks to ensure
that PSR-SU is only enabled when the newer DMCUB firmware is present.

Cc: Sean Wang <sean.ns.wang@amd.com>
Cc: Marc Rossi <Marc.Rossi@amd.com>
Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Cc: Tsung-hua (Ryan) Lin <Tsung-hua.Lin@amd.com>


Mario Limonciello (4):
  drm/amd/display: Correct `DMUB_FW_VERSION` macro
  drm/amd/display: Set minimum requirement for using PSR-SU on Rembrandt
  drm/amd/display: Set minimum requirement for using PSR-SU on Phoenix
  Revert "drm/amd: Disable PSR-SU on Parade 0803 TCON"

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  3 ++-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c          |  7 +++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h          |  1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h           |  4 +++-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c     |  5 +++++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h     |  2 ++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c    |  5 +++++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h    |  2 ++
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c       | 11 +++++++----
 .../gpu/drm/amd/display/modules/power/power_helpers.c |  2 --
 10 files changed, 34 insertions(+), 8 deletions(-)

-- 
2.34.1

