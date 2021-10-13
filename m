Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5628CC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 03:11:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1579160F92
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 03:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1579160F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EA8D6E060;
	Wed, 13 Oct 2021 03:11:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02FBD6E060
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 03:11:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mu3P+d3B27M/fn/FSFDw3kyXTQz0jtsLFVMIFrhr0pN+YNbPhkl2m7V5rkNqN63J/QembNG922v+yWMrmYNiX6GfS/30DCXOwJV4zlvweUAx2HruvpNECmjjn98EejBpcsamkOs8aDkQC/0fbrPqqY/DM945wmfjqu4zr1gRK8lHFS4x+82b9F4f+kDokJjunRVKXG+t0WuGroFGlj0EpzbN5vyZ8wHeuuK8DrPlbF/mVm+e8DPo3AjdAr8MpPz5wcOrbumHky5ydVni9vkP5z8iOXudSWf/Z/5/nJgz2J25PxwMq4BJi+e8HQ6OQ38plmLd0sjb5GoOIDoVGB4tDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIGhoK3Lvdv0CBv5OUz68RleAQJc1mxm6iEc4sHDa4E=;
 b=RsKh913EiM0jUAz07vC7CpBVrfu48AgfSfKoecIS3yM6U5Fyq+hlQ8kTbCOXXdPKxWaLH1gIaalmKAfJijifgkzmZxCFE2v7X1hnOYDVyS2ftfvxliwnO+bZKAImoEIsZa9eSGfqr+hC3z9yrf3s9oDdraYE1XxziGm/LoYBiHTvep2a5mYkKbxrtZDyXZKUFw8m5AFVDHJgU83Y9oluPFrLxErd8PXbYOgdyhZaE3rhWs/rsfdPMMnOiX9ojb1WBJF9aiPkGErzNy1WeY9CiegCaCMx83FpisZRsA/u1lTONT2isjOjI4Jd5tJQIANfBQxC6Pqyer9aCzO/SUO/iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIGhoK3Lvdv0CBv5OUz68RleAQJc1mxm6iEc4sHDa4E=;
 b=5q1Iux90vjbjT/CyW44QUI7aH6cYwts6nvGiNz+7FTR+lQgoXh/GZYprP/Kw9rgJUDFEfIFx2bY1Dk+AwWV9v/qgeOOtY8XUey5JamwKR6tCPeQsJZSzlwcg8d6UIbbI9oo0TwMS9EPaRrikYu/j10Lb8kVGeZUFi8bMSt3isyo=
Received: from DM5PR19CA0011.namprd19.prod.outlook.com (2603:10b6:3:151::21)
 by PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Wed, 13 Oct
 2021 03:10:59 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::f) by DM5PR19CA0011.outlook.office365.com
 (2603:10b6:3:151::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24 via Frontend
 Transport; Wed, 13 Oct 2021 03:10:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 03:10:58 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 22:10:57 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <Alexander.Deucher@amd.com>, Luben Tuikov
 <luben.tuikov@amd.com>
Subject: [PATCH 0/5] 0 MHz is not a valid current frequency
Date: Tue, 12 Oct 2021 23:10:37 -0400
Message-ID: <20211013031042.53540-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.33.1.558.g2bd2f258f4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9a5262e-18ef-48a5-3462-08d98df71433
X-MS-TrafficTypeDiagnostic: PH0PR12MB5417:
X-Microsoft-Antispam-PRVS: <PH0PR12MB54175002D61F6F45EE82ED9699B79@PH0PR12MB5417.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sf8+h5ujrJdRN0gGQv6DE/erQHAHxW7fzI+ChXsU6lzFFqdRh3lH1v3UVo8SY5cx4z2DQFCMz+NfIpgtZBCCAwW3tDUSexxCnUtGzetBQd3ddZTWEIwfoOWjIQF4G4KcLToW3Q7yIOii0bPQn7/EO0Fc+NoByLDcgQpgRiRV3pfq9m3xPXyVgIqbb2e4PQhp+dorouy4Rsq8UPhphkLCRp82jKiBCCvjN9M+wjPOP2S5SgGVbz7QtICBthnTk+bsNL+ScNUQjUuhoKX+38AdEQMvhNzDVmSyKBHIdQKDg/3F5yXOoVEa/DEhdgfgeR7sP/oI0ii8GDFQ1SR3+pYnYgUbxJ/41Qo+R06PTmDFDxHzU29jjAQvhYWQj81Dwuy8+STYsSELpG04fqk8bqMwtTBlqmXpTEPjgW5zkb6Cn8gL4K/ZIZbTW2wQOw7H3VgSI4qi3Vml+22NeozamtBMmcxjJvoFs9Dy0Xwqmmz1avnoBe297KnkgkNSZwAdr4rwWGOP3Lq6d/KkM/uoLMyCIdsOZfeFtQFMkU80QTNCSfZoQn/YSGp6x6+/rhwS5lTV0SDHQhQTtcZP55ywEp+SyfTycrVQUk1QZzAl8ebi6YT1afoK5xM1qaNHmWvmAlFPxBqzEuZhCHch/7D+ms9qHZqnX0AEVL8FgYkNFsQkoiSkjwVfFVOF4RJ2Q36WO5t2i9LGqhnOVUCk7TsGeAptVuh+4+Po5+XouCGyiGL2M/w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(47076005)(54906003)(82310400003)(316002)(2616005)(44832011)(186003)(26005)(5660300002)(16526019)(356005)(2906002)(6916009)(36756003)(8676002)(6666004)(83380400001)(70206006)(8936002)(4326008)(508600001)(36860700001)(1076003)(70586007)(426003)(86362001)(336012)(81166007)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 03:10:58.4174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a5262e-18ef-48a5-3462-08d98df71433
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5417
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

Luben Tuikov (5):
  drm/amd/pm: Slight function rename
  drm/amd/pm: Rename cur_value to curr_value
  drm/amd/pm: Rename freq_values --> freq_value
  dpm/amd/pm: Sienna: 0 MHz is not a current clock frequency
  dpm/amd/pm: Navi10: 0 MHz is not a current clock frequency

 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 60 +++++++++------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 73 ++++++++++++-------
 2 files changed, 86 insertions(+), 47 deletions(-)

-- 
2.33.1.558.g2bd2f258f4

