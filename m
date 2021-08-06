Return-Path: <SRS0=Y/Ds=M5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE38C4338F
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 16:35:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9843961158
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 16:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9843961158
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD9156EB95;
	Fri,  6 Aug 2021 16:35:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 395066E0C5
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Aug 2021 16:35:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gn4a4uhz0+qCPFpd0PeKGVjCQaqOxmuN3tUTahrdVBIwMqoFAjKlzl9yybz0Q4ozQ8cRI8F/MHT1iSXYGAbVXnz33RQgKvNvyFLSi+zZhaKOqjEsFfx61TECECv/szYfBnCSGrZBDGzSKTiLIRb35Zz75UPFa9RMem9AVo3iQpPKd8Z+KcEhDLy4LOr0oLDwOCuoFU9QS89FgC2AKKLF7zTg5dAA5poDB6MTMCrCgJ1SPw5vnE4pOzcOpWPBhpaFburQ13CvZJ16GppG0/FHoslHS6MQbAG0vnPHWkZhRVFqKvEFKoWZ0cKR4gnPwl+J/zNoQQ2+0ID6w8XhEdlJwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0kbU0dymdSMdmPBhmEmQxC7Z1n6oV6Y5LFIpiG7TZI=;
 b=T6yYDOLEHjKR+sw7AU9bRa4+6Kwq28v0N0HMkMzoK+0ZZS2QII6k2lk3XG2ORvSlUlQHWtg0D11PwIukjytqOAXbhKAAB6jHtXd16zUcrmngPj3fGtexHyUqCN54oOtP8PqTdhENUFbuqFtXKx1xFuI+4pQ4jNquYghzV1/DnioV/+FLF2cOPQCiinBNHLGWbEd82Syy7U16Ku5jQZ44EK+0N7AtBOx70pAKjaHe+Ge4w9ejoYFGxvQ4UAqa5/h9OlDfw7Swplbi2yX4uiyAxHmCwFxkAcFXnZzzJZADVaxfHlMtT2MEOor39eerrEXHnEgG9S5V2SrhRPJ8+A/dPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0kbU0dymdSMdmPBhmEmQxC7Z1n6oV6Y5LFIpiG7TZI=;
 b=tr7/r4mUpA6kZVmBkoL9CiQ1ZiZL4qXWzI9j8SrontIxxJdVMtanZhuYNGxCWsgxuewLfjEOXEhCBjmeQxdgGGoTfR03dnCzWLeyKSHeXFRcy0k7xZBMJw4/9J66cduoe0kVZXiPLYjKadxq4WN2CF/3M2sV+A5kHXvlJMzeL1k=
Received: from BN0PR04CA0176.namprd04.prod.outlook.com (2603:10b6:408:eb::31)
 by BN8PR12MB4787.namprd12.prod.outlook.com (2603:10b6:408:a1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Fri, 6 Aug
 2021 16:35:29 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::55) by BN0PR04CA0176.outlook.office365.com
 (2603:10b6:408:eb::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend
 Transport; Fri, 6 Aug 2021 16:35:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Fri, 6 Aug 2021 16:35:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 6 Aug
 2021 11:35:28 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Fri, 6 Aug 2021 11:35:25 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <Eryk.Brol@amd.com>,
 <bindu.r@amd.com>, <Anson.Jacob@amd.com>
Subject: [PATCH 00/13] DC Patches Aug 6, 2021
Date: Fri, 6 Aug 2021 12:34:36 -0400
Message-ID: <20210806163449.349757-1-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2131da0f-e43c-481d-8975-08d958f8337d
X-MS-TrafficTypeDiagnostic: BN8PR12MB4787:
X-Microsoft-Antispam-PRVS: <BN8PR12MB478770988C17EDD8A3268F74EBF39@BN8PR12MB4787.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bhCbenRFqP0YxiGayCCYgQKXHqucbUJofZiAgRsTj5p5xi42VhRdV7mHzrUIhIRovqDuAS46926lvf1jsWfenWE1y1CDc4xmUbzxv7hEcMIu6nX4hdiTOBUa8gZHGrxMXOckN7ppQkHICJbZ13dhELgXMk2lzz5oWTdwOTJMrTrXoc9QiMr6z2GSD3yLX4+ychxy/pcYAHNu3pea6txmGnWgPfU8WR3zctHKfaF8vmrP2Kbp+rFx+73QltsbXnVrQWWLgbFPg4NTHtct1RRj0CExOa59b7VU/L4s7L0gXIza7Ru/r5WaZ3Zo0uU1n8EHC1uKAgTC50x0q7PGo8WlsoKx3aL1YSu1F1Aj90fF2eBNxNfqow8Fo3X8XH/DVaQqKNdZzMMA1cPUCiokMK9uZUO9UirwomncSWiOjWwfDcw9UkB8LgFqpZKlkqKnZni0ZPqrrG5SHwsloTXiFQ8JLTIVYUcl+qh62yZH6nM03D6rDb/lNcq910tywuAvBFP8AbqhFp89/FQsM9BoKqvfnJJ83Z912kpu4aYL5JpXJd7SzIg0z7t6rcQ2qRwM/qePJuqHui2k0BnKcR+HCk9EKyqm7EKlPi5sgcE6RUqa4hoL40wnxLwdb/esNjdVI/VyqHUDRILt6vkuXlNcXgBaISrwibqLJ8gsES0v9QKb7e5xQWxv1hj1wLKkbGJCCZ7BffTxd+vLA1xxWt5y7Bzb84bOh9PGUZlHXd4JLS59fDI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(70206006)(26005)(70586007)(316002)(336012)(1076003)(81166007)(4326008)(356005)(8676002)(5660300002)(54906003)(8936002)(186003)(86362001)(6666004)(2906002)(83380400001)(2616005)(426003)(508600001)(47076005)(82310400003)(7696005)(6916009)(36860700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 16:35:28.8204 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2131da0f-e43c-481d-8975-08d958f8337d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4787
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:
- Fix memory allocation in dm IRQ context to use GFP_ATOMIC
- Increase timeout threshold for DMCUB reset
- Clear GPINT after DMCUB has reset
- Add AUX I2C tracing
- Fix code commenting style
- Some refactoring
- Remove invalid assert for ODM + MPC case

Anson Jacob (1):
  drm/amd/display: use GFP_ATOMIC in amdgpu_dm_irq_schedule_work

Anthony Koo (2):
  drm/amd/display: [FW Promotion] Release 0.0.78
  drm/amd/display: 3.2.148

Ashley Thomas (1):
  drm/amd/display: Add AUX I2C tracing.

Eric Bernstein (1):
  drm/amd/display: Remove invalid assert for ODM + MPC case

Nicholas Kazlauskas (2):
  drm/amd/display: Clear GPINT after DMCUB has reset
  drm/amd/display: Increase timeout threshold for DMCUB reset

Roy Chan (5):
  drm/amd/display: fix missing writeback disablement if plane is removed
  drm/amd/display: refactor the codes to centralize the stream/pipe
    checking logic
  drm/amd/display: refactor the cursor programing codes
  drm/amd/display: fix incorrect CM/TF programming sequence in dwb
  drm/amd/display: Correct comment style

Wenjing Liu (1):
  drm/amd/display: add authentication_complete in hdcp output

 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  62 ++++--
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 106 ++++++----
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  | 192 +++++++++++++++++-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  14 +-
 .../drm/amd/display/dc/dcn30/dcn30_dwb_cm.c   |  90 +++++---
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  12 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   1 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   6 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |  18 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |   5 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |   8 +
 .../display/modules/hdcp/hdcp1_transition.c   |   8 +-
 .../display/modules/hdcp/hdcp2_transition.c   |   4 +-
 .../drm/amd/display/modules/hdcp/hdcp_log.c   |  74 +++++++
 .../drm/amd/display/modules/hdcp/hdcp_log.h   |  72 -------
 .../drm/amd/display/modules/inc/mod_hdcp.h    |   1 +
 18 files changed, 479 insertions(+), 198 deletions(-)

-- 
2.25.1

