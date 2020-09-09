Return-Path: <SRS0=5+Vp=CS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEE1C43461
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 14:29:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 847F72224F
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 14:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Yd9gQmPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847F72224F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A4686EB94;
	Wed,  9 Sep 2020 14:29:02 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760041.outbound.protection.outlook.com [40.107.76.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1DBF6EB8A
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2020 14:29:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Na/L2MhT0/vqmZ1hPHvpaJNAZpTSW7qTLkr6+BOW0RmZlkH9yPGKwW4L5/9ngVRN2v43yQw3RYH0FVwySVtMSajLy0WcaWURGcXn9zFnHXEPcXeEI2pd3xILyXn8t6r061OVYFIJd8w38fS1cw4ESN8FhndkNJm1qsKTLl1p59IK7wQAC2a3ASJeAK/LxqfYoPMdgTZ18SYOHWBtOwzZ3s6w3b/RpOYsWngB82gvnSqFWsqeD9bVHKzizja6XIUBAsCZH6zXngXqT0jghuWrwZcz/vQfoain7N9u4PupVa9Twap5LE8uehYAITA1FNMTGZGzsNR+XDQ4KMDWzwkI3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2ZZDmuMssWaeVQyu7LnOkivNdiSNHhj5dxRTv94xU0=;
 b=hD1NnR6jgSgwr4JSaSkC+YvGxGsJ73lbXLG/Oa5/772niln7LDH8x3Yev6s5gfezMr8hcYy6v4NGJvBEfXBZu5M1CAtUSOJxcVECFG07X7rUVU3M2vyjC4+j7mqrTk85t1XBTNdTy9DlcLQMNBBCTMvqco9Qe0JN+UPnzBZP3/nS1WpWB8jNVirwF3GmxKliBTskpj7NMdhiMFv7q+cnciB7+JL0gkXmqZ5U7K3jNYRw+dbNmHRb690MqhG/0ZXk1ZwiizEZwZyEXLgKnTSKGKA4kwVM/D+uIrH1OMH1k73swJy9gayYKm5R3uUktIAysIiqr60fxxnBUaE25Keehg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2ZZDmuMssWaeVQyu7LnOkivNdiSNHhj5dxRTv94xU0=;
 b=Yd9gQmPSJTyDZp984BnWEvWts+fOHvubqk1ZBYVBRuYyqyjfyTOPND0RqH8rri3MS1oxaRR8p3N7yemHwLYQ+DCOHFlDxYxkwiI8fD5rcMbrzLA/G+Q3UVeGhfbse8KEKlXmZfk6rvO8j26QlPnN7IERB9cvuCcrEFWL0XUlG/c=
Received: from MWHPR07CA0022.namprd07.prod.outlook.com (2603:10b6:300:116::32)
 by MN2PR12MB4317.namprd12.prod.outlook.com (2603:10b6:208:1d0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 14:28:56 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:116:cafe::2b) by MWHPR07CA0022.outlook.office365.com
 (2603:10b6:300:116::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Wed, 9 Sep 2020 14:28:56 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 14:28:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 9 Sep 2020
 09:28:55 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 9 Sep 2020
 09:28:55 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 9 Sep 2020 09:28:55 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/3] Refactor DM IRQ handling
Date: Wed, 9 Sep 2020 10:28:51 -0400
Message-ID: <20200909142854.105032-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: baf73986-52a3-4647-dfd3-08d854ccaf64
X-MS-TrafficTypeDiagnostic: MN2PR12MB4317:
X-Microsoft-Antispam-PRVS: <MN2PR12MB43176531969FF02C615C7A4D8B260@MN2PR12MB4317.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3lT1h+xQFauUWADpE7FozKvINQNYh8ojp0MyZ0QNE7GqUiF0a0NT47v07+UEJtfFyYBycjIrj35a0SWVMOFhmHVAQkpbvFF4iA/9CoyshledgXqQzlFlqU8jcYJ+5R5/ZLSbNXby4iyziiMbSvkEcySo2h0lS70CML+OAepzf6zjtT6njBMOodMxNMA8v7bzy6+d8zlvpZLy3VS2bIX+nNr+VSNuu8OFqmfN3fT4RU4SbUVP2c8vG/orjgBgqE1veqnmynynfoq0AKXMFsrgjZodDzCttZg+Z2FHgdFq7VTqzHja9TZaZFOhyEv4x+SOqQH5wD7ByQ3g9pRxAqAP++F2Mt2p21twhdpD0TAxrfCu9S7NAZ5ijP7NyBHE5FRPpWlTp7NzZsYMFbMsFy4/Mg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(46966005)(1076003)(7696005)(83380400001)(26005)(4326008)(82740400003)(356005)(316002)(81166007)(6666004)(47076004)(2906002)(36756003)(4744005)(8676002)(5660300002)(70206006)(70586007)(44832011)(478600001)(8936002)(2616005)(6916009)(186003)(86362001)(426003)(82310400003)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 14:28:56.4041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baf73986-52a3-4647-dfd3-08d854ccaf64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4317
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
Cc: nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Interrupts are disabled too early in DM's atomic_commit() which can
cause issues in certain situations with non blocking commits timing
out on flip_done interrupt. The early disabling of interrupts were
necessary due to interrupts accessing crtc state directly. This
refactor removes direct access of crtc state from the irq handler
so that disabling of interrupts can be done later in commit_tail()

Aurabindo Pillai (3):
  drm/amdgpu: Move existing pflip fields into separate struct
  drm/amd/display: Refactor to prevent crtc state access in DM IRQ
    handler
  drm/amd/display: Move disable interrupt into commit tail

 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |   4 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 157 +++++++++---------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 -
 .../display/amdgpu_dm/amdgpu_dm_irq_params.h  |  37 +++++
 4 files changed, 116 insertions(+), 83 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
