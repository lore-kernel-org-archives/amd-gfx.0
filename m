Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7F8C11F65
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 05:57:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2153E61C85
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 05:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2153E61C85
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B60566E10E;
	Wed, 30 Jun 2021 05:57:39 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2085.outbound.protection.outlook.com [40.107.95.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 688536E10E
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 05:57:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=go26JwP05Yc63AA5aKkoGDZxgRThUCU0lVPVWirgzs2p9nEsB/M4dENC99uZKpJ09LXlIiH2p9G4/Dgrd+MAe70MdEl8WO6w1xeEr+uM7R4tHvtPLAZMawDR0CbvV3tN4Lx5w8hCrgtnavC4E7Jj82aeGUIvspwzjNcQl85ajE4gUYyEDK5gZtU7wYsVncNAf84wfPf2YR94dZgqqI31E12DF0abGhzBdIkifwQupYel1Fo51PazDjGtgmqsBHcbxCjnM/uzIzLu4lwzxPZ+SwDUxMhqTcs6YAf4UPhXGzZhxw5bll1oULNnQUYyKCeZJ6Gr+jDUFudkD/c/1HKbBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnBzWg+qj7JWgXZ7tNfzsc1zPTIXdqZkWSl3iRa0Jhg=;
 b=HuuzUOVtoM7PPLShX1Z3kF9P6LT76nXyW9IsVPak84sqWHlrY9j+3cizhdYcA4OBdcPFYiPIs8jCEBbDKD4P4xcukxe41J6u1vfknJGhZDvKD/16D6+KyK4bgCGE3yekhfkPstQXC1Bccmig/WtrFZ8MA8ngVmpBMNtJFYS3PwcLXLvaJRpaky7vJ0nkCcxYelG9Rq3hpAs98M/KdbWzZtHfCh9wgwtBg6zWR6/QZo3QH/kK+E6jm8OIl+OqhhoE6E4f9+b7S5vjBI8I8N9XkcnF1TVII3cuk46LcAYSlOJbPqIL8hLmf9GFSuznirpEgmekeVXpZcrKG19fWVTpoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnBzWg+qj7JWgXZ7tNfzsc1zPTIXdqZkWSl3iRa0Jhg=;
 b=vGVI8m/BMNCajgl5aKroXGfp/1nom4lgf2949cKULRvKQUE/s1uE2kjwEFidpsdCk2yWI7OSbF1t2B+DSOq3jUiFOqQFs8P5EwGYhORL3kE7WhGN9z9dexTYmELC8X9QRRvhih+dZhzjbHxQBsvbrJGtWTZmtEqwe9rJcc6AX8E=
Received: from MWHPR20CA0007.namprd20.prod.outlook.com (2603:10b6:300:13d::17)
 by BN7PR12MB2788.namprd12.prod.outlook.com (2603:10b6:408:30::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Wed, 30 Jun
 2021 05:57:36 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:13d:cafe::ce) by MWHPR20CA0007.outlook.office365.com
 (2603:10b6:300:13d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Wed, 30 Jun 2021 05:57:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Wed, 30 Jun 2021 05:57:35 +0000
Received: from aaliu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 30 Jun
 2021 00:57:31 -0500
From: Aaron Liu <aaron.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Make noretry the default on yellow carp
Date: Wed, 30 Jun 2021 13:57:18 +0800
Message-ID: <20210630055718.3133-1-aaron.liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5156a6aa-3671-4699-5144-08d93b8bf5ba
X-MS-TrafficTypeDiagnostic: BN7PR12MB2788:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2788CC11AC53FFC72CE70FC8F0019@BN7PR12MB2788.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xSS2+uhQllcw6+IAxjkG7EnpnGfv5rNdo2F+OSBjWReYu+T8ZV5gz4AxdONAB6zwfry4KB4yixxNPZy+Xx4Euf8zu4T8kNg57tK0Y5HtrooExGZMTwh6/crbys6MmJaS9UlVTpELFzfG3DGgREt/SL7YYi2MvFQyn6F6UiajE1b0WhUGBMkTHLlYUB6k6rDpQT8hSWdi9gOtn/MSH0cGguZz24zFUFzMfsPqsNf6pRjQS/kMSiwEJ5UzMJ3HnuEegq0559G83pSJs70uflOGQJIE6cxOSKQrMC6Hl+7/zjcAd8YoB7wOZRN3fJpoG+WK3a7SJLt2poDy1PrlSut3sZ6ziABruMB3v553d+TSkC0BB+sJHG4FSHRdEKZH/S1LXLhs4Kx00lRcB1WndxpqXyQ3LxnTqhSbaJkUZT9274UgjUtoRBddggdwyLp0fq8KltkIRCGF502VKom63lPI4NtP5zkNjNsqTBZ7qNdvitCLV/iZbapBUXG+z4Rib5nGIo/8Yl6QYNAP55kNcGdUYP2I9NEKwgcN4mGle2kvQcuChINAQqJsxZvZJPu61uUg5RDj6gmiN2QVUhVOvaiU5SITBKU8Fsbh4iWjQEGPPz/Tmb1VT4mWCtd5E+/0cpWt64je6mSHvsJZS/50XsqoFaosr0IBMv1IjMBHw7UzMIMfdNq+AUREfa1qDxOiTNXqSWbMFUMmwBsCh3kzh5pWLGhDzH5XrB7OCFD3brwX7EA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966006)(36840700001)(316002)(82740400003)(1076003)(426003)(8936002)(2616005)(47076005)(336012)(44832011)(36756003)(36860700001)(4326008)(6666004)(83380400001)(356005)(81166007)(26005)(16526019)(186003)(8676002)(82310400003)(70206006)(54906003)(86362001)(2906002)(478600001)(7696005)(5660300002)(70586007)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 05:57:35.7078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5156a6aa-3671-4699-5144-08d93b8bf5ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2788
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
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
 Huang Rui <ray.huang@amd.com>, Aaron Liu <aaron.liu@amd.com>,
 curry.gong@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: chen gong <curry.gong@amd.com>

Performing kfd page fault tests on the yellow carp platform will fail.

From the scan data after the failure, it can be found that a
nack=0x1(retry fault) is returned. but we did not enable the interrupts
for retry faults in the code.

So we need to set noretry = 1 like the above ASICs.

Signed-off-by: chen gong <curry.gong@amd.com>
Reviewed-by: Aaron Liu <aaron.liu@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 1525d957e114..d4e9704dec62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -591,6 +591,7 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 	case CHIP_ARCTURUS:
 	case CHIP_ALDEBARAN:
 	case CHIP_BEIGE_GOBY:
+	case CHIP_YELLOW_CARP:
 		/*
 		 * noretry = 0 will cause kfd page fault tests fail
 		 * for some ASICs, so set default to 1 for these ASICs.
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
