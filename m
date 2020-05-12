Return-Path: <SRS0=6vDE=62=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BF8CA90AF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 16:44:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 605C7206B9
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 16:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1gHlBcoO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605C7206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 115036E93D;
	Tue, 12 May 2020 16:44:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAC7A6E93B
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2020 16:44:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DS0Tit/21yro9pt56DrbEtzZkLJnp6qv/GVPfJPBscldciGaQsxADu6U/v9CQr82lB1hwnwfAmAuCYYui6lCf8jx9aJlAUn+RaKOe7thzd2cZG9FFf+vhWVaBwqrXpZ69P26AVkBum6U3876WCcCAeXrSD6v0pa/e2WNLAOVpkOGmzuJTsm0IqDIIIcRm51q6gzWoPLpX7Ru/vNTIzSHMOT3QHxZtcz04UELTkUbl0JEarheQA1HBaUdiX6ZyORos2WUDzTFqZ5aJ3PCAcKGzdT/LkxNAN1L1j0+frkBZLpjC3JP8Ba600tiPCP1Z6u47BZz0/9Gz6X+vheCvif4ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PetkMcgDcfcluEbU9R3qcnJg1cY+C6lTIhD1K9vYFk=;
 b=bq3+Fh/MaB1l+xOSRk0ERMR8UOPYJx7sqNqFLiI/7JGzCOvfyc+xU1ZSIF65rZCPUqc8XvV5BHd9Ad5TzYWga32TeYa2fHIRfvkDspQsosLNsJSSR2xvmQmjN5Nmyj/XhxEi7t5XkbvTT1Y7UPwIUehYPa6XsUrMaDUa+mPvvqDWcRP49NjSWI1FU2GaCMdnVeixy+Qq+HEX6bm/xxw0CQLeeT55TK94pgKXCvVKO5FtImRi79OeszuQAKIGM/PwXCxms61/IgBXcMPXTlcHG8W7HCBEbukMMq9yN+db87fDcysM6+CWbbLUNxmKLkncxUtmXzQd0gosOet90h2Bqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PetkMcgDcfcluEbU9R3qcnJg1cY+C6lTIhD1K9vYFk=;
 b=1gHlBcoOf/xY76FRL6z8lCILv0BfQSq7h1ilo6l7M4Ht7Xtdp48eBp3H0qcQgOXsANkvnGZCh2cnRw2gkZ/vsc78Pn9Auly677c/bIJq32Kis5qmkOPfCCJxy0QES1nqGfh09uwA9MZdr8Ev6Dee7lHENCMyCZt9kHurPZZ6IEQ=
Received: from CO2PR06CA0067.namprd06.prod.outlook.com (2603:10b6:104:3::25)
 by BY5PR12MB4065.namprd12.prod.outlook.com (2603:10b6:a03:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Tue, 12 May
 2020 16:44:38 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:3:cafe::5c) by CO2PR06CA0067.outlook.office365.com
 (2603:10b6:104:3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend
 Transport; Tue, 12 May 2020 16:44:38 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2979.27 via Frontend Transport; Tue, 12 May 2020 16:44:37 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 12 May
 2020 11:44:36 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 12 May
 2020 11:44:36 -0500
Received: from hwentlanstrix.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 12 May 2020 11:44:36 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/3] Adding DC debug options
Date: Tue, 12 May 2020 12:45:03 -0400
Message-ID: <20200512164506.26861-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(46966005)(33430700001)(8676002)(44832011)(186003)(356005)(7696005)(316002)(26005)(36756003)(82310400002)(33440700001)(5660300002)(2616005)(82740400003)(81166007)(336012)(4744005)(426003)(4326008)(6916009)(70206006)(86362001)(2906002)(47076004)(6666004)(1076003)(70586007)(8936002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7bddb33-d573-4c15-5823-08d7f693c25b
X-MS-TrafficTypeDiagnostic: BY5PR12MB4065:
X-Microsoft-Antispam-PRVS: <BY5PR12MB406514C1F884E0CF9C039BAA8CBE0@BY5PR12MB4065.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JQAz0UUMF1ksUBZK09w7VJsYIgQdXQ+woqzltEJes6NO6cFAMhHeDpDvXy7AoRFFpavFioRpesECssOoxsyWZ+w2cINgODP9c661ie5b1eJpxJwE3nfFXcIBzBOqrfNm20idjop4ofKbbZTn6KMbJGkngqcaSD1+Ap52owQgWf7vnzE1CWEHoZmI0I+yS29KICYG9lltsupnNP37ni30wpvSWXqYEdkjUySdoOSxmjc+P5VvuK7rybt7gk4lLlNoKWdiJE5CZ8UAg4QpzaQ28ds/M5gIJ5a1gBAx2IZ5JBimgYZaoYLsHULqHCW7v5JjvKzhnwDuZcl2RbvU4BUH6clkR0a28g8FnFBLeuLMfnBnGGcLSF3xcpmI4tBlJHxjwfuZAvshajUdQuDjPwbB4X2kMk8xREHFY/TUEEjU2cuIS8B/7l16UctBxn9t3r1IQBdEI/lkbv0SET6my+332Kx+gyr2bkbuia/ROb+Fly5DjMYv6t1Ir/Cv9f1AU0hLviE5VTDRiFhf6mC39vFidvApdupxy6i1Cfo9fgfemxbnRyeOzZ3sH3ZpEEqR2pc0ypAvTsePd3RKPxMvE3u22A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 16:44:37.6007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7bddb33-d573-4c15-5823-08d7f693c25b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4065
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
Cc: Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To facilitate bringup of new ASICs, debugging, and measuring of
various power features we would like the ability to disable them
as needed.

This differs from dcfeaturemask in that dcfeaturemask is a collection
of experimental features that can't be enabled by default, whereas
dcdebugmask is a collection of features that are enabled by default.

Harry Wentland (3):
  drm/amd/display: Add DC Debug mask to disable features for bringup
  drm/amd/display: Fix disable_stutter debug option
  drm/amd/display: Respect PP_STUTTER_MODE but don't override
    DC_DISABLE_STUTTER

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  8 ++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 ++++++++++++++++---
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.c   |  1 -
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  3 ++-
 drivers/gpu/drm/amd/include/amd_shared.h      |  7 +++++++
 6 files changed, 35 insertions(+), 5 deletions(-)

--
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
