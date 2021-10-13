Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF02C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 16:12:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C66E60EBB
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 16:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7C66E60EBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EF586EA76;
	Wed, 13 Oct 2021 16:12:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34D456EA7F
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 16:12:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwXDIh0nvC4ruTlH6G6Qu5IQlwgCTI8u7so29GsNL6ApJRPV1uLsQ3V3YLYrHwsnkQ6TSyZce+kCh1Sp/CanQedhKe9WRv6VpWQK4xkyQVN8I7iLls8AsN845LS1sTNFg7EG4V7XQfMYg/3Y5agGhR7kdouHbAlMX1Fw5yoMebBD3Ko+4FcuFpg4/j8DwQ5S8GLO8Km0gneschYp5nFlz3XwGPeQz15NDQcpSSHrN90LEJldCG5P5DHT7vqoUB68iPEQYVP1HyeZCI/6u2pamQ3/BKetjGVTgMfxafFDK/fjezybWEZJ1IHkHrA4npFrL7jMl3V67QfENGkCIe5iSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oqtAcKOi0xf0mdpc3zhbbckI/TXrLhhzivJ5sJTHR8=;
 b=JbOzy6J/gUTOzuJdaABY1owrdHu9nsu1jbY08quPxRDLt4zw6TLvUzA30oY1tx88dDuXV08anW+JpSL3vrrFRil+5os/FEGEXHWIZprdytWlIg7jZqRVjELI1/CLhxlJD7nh276m8gD5taZG4TwLFN400kt0KWKqh/qSCQFjT/uI8YY9TORzb4kZuESG8reItXT92gUjREh3feQ7hlPcoPAQdH/W+axeiKPEG6mg9uQmpWj6u2ExnB/XZtUOhkRuG/M09GbIRnY9+D3uKqCPvug6DAqNuBtNyLCRDnlcWakVWOODcf55pknXicboTQFVUUrTEB6PnNs/eT596ZtWVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oqtAcKOi0xf0mdpc3zhbbckI/TXrLhhzivJ5sJTHR8=;
 b=D9JDIXDwoWjhxPT0pdw1OjbpjVtM5BfU4RRVLAZ2Gu8d9HF+p6FOfDICeGQ3ZX1Qj2E5pzS32yYMPtcslNwyQCd8OUF8GTi3mQSUdEdIQzPzoLAcfZ0yXxOfknh+hdKGgqVloa9ze1+MBRomd4OAsd16muklC9iEPPPZ1X8Rhl0=
Received: from MWHPR19CA0067.namprd19.prod.outlook.com (2603:10b6:300:94::29)
 by BY5PR12MB4260.namprd12.prod.outlook.com (2603:10b6:a03:206::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 13 Oct
 2021 16:12:13 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::b0) by MWHPR19CA0067.outlook.office365.com
 (2603:10b6:300:94::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Wed, 13 Oct 2021 16:12:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 16:12:13 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 13 Oct 2021 11:12:12 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Luben Tuikov <luben.tuikov@amd.com>
Subject: [PATCH 0/5] 0 MHz is not a valid current frequency (v2)
Date: Wed, 13 Oct 2021 12:11:55 -0400
Message-ID: <20211013161200.9052-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.33.1.558.g2bd2f258f4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07054277-a53d-4a6e-8c56-08d98e6437b6
X-MS-TrafficTypeDiagnostic: BY5PR12MB4260:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4260616A0AB118219993993299B79@BY5PR12MB4260.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ApivBbIH6jEJDdK/BSvp9T7XYoDDQ048BAb96e1h/5yYZxvZ1KnnAHdzzu+50EZN7PvmrckRVL5SquavYMkfH7M5J7OKnA0sCXvFzA3OUftHPMsN2RDqzx2bXDY92rR6j9LrODVe8TpfHcIxbIbjalthSLsmPzbVoD/YwS8VG/As/+TTaApyG42KaiOLmkmS6WWwnJfbd5S2/JBo52a+EsJbzuGI1oR8NHfrQt+xeDSrlVW99a361iI08zIyGakN9hbhfsDQht+bT/HX/j1OqCuE1ZG4Jj7okMZt1ir+ubuJOsHRacZx5X8qSjuPy0w0FHAIPXsRhoEbgfzg1mflq2P04YOo3VffSUOHM3WFXonr4NSaPngphNwtMulQPTRQxFibOwLuPATIVJkAYhJy9qHjdEmny2myfqchESM2hWivTIkTwsVAE9Cbd6fHhGSWpjQ76xyMqYPkS+39OXP1OFpIodkPxwvWaVoABMXVWQe1IgFtpDcAKhfqT4hnNulQtDawatWafIoFv7+7TfPwVtxEGBqSMoYBuzQ7mIkXlvryIqi6AqEu665kyMaj85GYTnvfAzCt/pzMoUqd3khvK+VCHXPsS14RrLcPowsPf+JohCaBL1mTHCu1HhnoAK+5Tk9CLy/6rtgaFWtYJw3pkEezS51vVAWpMtsPdXqRlZitqCzd/YbroL0HynJ3Y+4STjmoGifAEHPVE+Ee6u5EuxYXViWlDp1e8aGWq6aABJw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(70206006)(36756003)(82310400003)(508600001)(70586007)(426003)(8936002)(44832011)(47076005)(36860700001)(8676002)(6916009)(4326008)(6666004)(316002)(2906002)(2616005)(86362001)(5660300002)(7696005)(83380400001)(356005)(26005)(1076003)(81166007)(186003)(16526019)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 16:12:13.0600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07054277-a53d-4a6e-8c56-08d98e6437b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4260
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

Some ASIC support low-power functionality for the whole ASIC or just
an IP block. When in such low-power mode, some sysfs interfaces would
report a frequency of 0, e.g.,

$cat /sys/class/drm/card0/device/pp_dpm_sclk
0: 500Mhz 
1: 0Mhz *
2: 2200Mhz 
$_

An operating frequency of 0 MHz doesn't make sense, and this interface
is designed to report only operating clock frequencies, i.e. non-zero,
and possibly the current one.

When in this low-power state, round to the smallest
operating frequency, for this interface, as follows,

$cat /sys/class/drm/card0/device/pp_dpm_sclk
0: 500Mhz *
1: 2200Mhz 
$_

v2: Fix description to reflect change in patch 1--add an 's'.

Luben Tuikov (5):
  drm/amd/pm: Slight function rename (v2)
  drm/amd/pm: Rename cur_value to curr_value
  drm/amd/pm: Rename freq_values --> freq_value
  dpm/amd/pm: Sienna: 0 MHz is not a current clock frequency
  dpm/amd/pm: Navi10: 0 MHz is not a current clock frequency

 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 60 +++++++++------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 73 ++++++++++++-------
 2 files changed, 86 insertions(+), 47 deletions(-)

-- 
2.33.1.558.g2bd2f258f4

