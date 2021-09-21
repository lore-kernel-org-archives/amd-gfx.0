Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CFAC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:07:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DB9661168
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2DB9661168
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 288176EA44;
	Tue, 21 Sep 2021 18:07:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 272F56EA37
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSK4Ve36vOquKwaU9I8eOU+Q82ZQMpbtbe9lOxtuO6+8qUe0Sk8ShRqjuCQk49649olZli0BOojEekFjnAVMibYaUxDxj5Fyl/2Y+LRYOboPorOFExSRPP9938RxuyA2g4JgfEbCDNG8M3H60GrtHy3h5omu0TuPbRtnr13cgtcGWomeW4LOfTdJiiTiI8GzUabtXAjxP1SKzT+buNq/HuDhsV+PXLjkBFI4r/RTz7r7nYF/qNE0i2V+GYZemzT/OnfaPs5+CRaMT6HMwtUUGBab9d+aZZPF92aeeJggW0S0qHyzoTZG98aVjCSNETeJH7/ec97xRioP0kNLB0hCVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=dZWuEBP8ZcCuUodryLt12NqMd9ApwVzE8trXjn/Saj0=;
 b=ZIXgNPlMujpUFBzR6RcEQ9dQhW1PaPyJQAGQ8XHcKfYGcM6YfF/EbDAsiemszOgf0knAocz2uo1pUqNuFJ36t+8+sJstP0pDQ7RLGBCyw5x+R699s7HAgwPe3mq2cnuBhSqGBK79xifokicJZRgkaq0Nm3T+h32UQ4lblaCLP0FDCE8W7ILJeh11UG3/7WxSegs1dJvxFoORGWlcYaWDjPLV+MPL+7ZpB4oYLUayYN8oYY4dG46kUwMdn35FzxOPtb1yTmQCEaNJGVMtPXjpznrpjXC0G/R0rXbjd65jM2jALpLkFLO1jIMyKE4tCkG37eOWI7bF1AN+XhfxJQ1Cyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZWuEBP8ZcCuUodryLt12NqMd9ApwVzE8trXjn/Saj0=;
 b=U4Vb/F8qzj6DYkOQM0cjO8TriCbpe+NjX+cDSha9yR6/9Xj4QYNU+eQrzgxq9PJzMFpxZv2/ZSvqYpjG5geNTwAEygboHAu3T27lzyKm58TSMFTmOPlStWpXhYwB+X/I/XgiwVNdRa/SpdnlCfTyMTWlMsDm541N9cUXjmpQmjc=
Received: from DM5PR11CA0014.namprd11.prod.outlook.com (2603:10b6:3:115::24)
 by DM6PR12MB4025.namprd12.prod.outlook.com (2603:10b6:5:1c8::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 18:07:47 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::43) by DM5PR11CA0014.outlook.office365.com
 (2603:10b6:3:115::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 12/66] drm/amdgpu: bind to any 0x1002 PCI diplay class device
Date: Tue, 21 Sep 2021 14:06:31 -0400
Message-ID: <20210921180725.1985552-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed014c4c-9c0b-490b-e1fd-08d97d2ab7c8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4025:
X-Microsoft-Antispam-PRVS: <DM6PR12MB40254E9ABF9F8C1ABDA68766F7A19@DM6PR12MB4025.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lVS+02NZJLvnKPMT5zJR889UyTKAXSwoa+yxMCKW4T4IYmGAuc/zvhfwOgFjlWVbsH2gAyKv9Rov7afHpzt6o5thRJ+3fNRC+xkbL12JY0hmWZWdGn7HvgY3rUvho8hvosj+/cb0fjvwLPss0nZf52vxAo7vBodYOKM0GRUDD/yy+dQma7UY0PNitJyPcb09I1csYaeTAYu5N3lPitlwLILP/iLl6Vn/HfqxK8SjFrQIO03/GQ3W1cNj1eFdL5bS4fAf3lv0HWoS6iECmBiBMD/XgR/gHORGTcZgYw/nfJi83Ltso78TcJw/km1n03EPc3qzI57eT18PCg/4tPPx/1oiBDZ6qT6QW0OO+DK+3uYNcuzvPYwo52Ffd2JqvQuL/CicrtOdHfXbodxWTQlqVJGUDWMt0FQnT7vEfz/xxfKvsVXcgs1uHrYPEYdsJwUmzJdEMPE/Lhte5MSO6a44gQXglIrWckJLzcMv86fWY0nPosrOfZRXqKW/4einGsBPj/6ccc7SV0jAy2h2Vcu0/0I8iymiy/5netRRcEabTY6/AxubS9wtRyhSCA7GQVMS9uilgQTPz4xpahigX469g/xPBvcoezdo04zFnOZJTt7n2bESijk8jATtm6t4jQYZT0wlMTdwXCEHVyuI6VUUYQMwJzrekMFQictFTDvmgCYr2rQA9F4R69NS8+7tcUBUJz9MpOgRGZ9iQpA/xLhDDZ5AWSmDhtAngnZNLGCc7pk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36860700001)(508600001)(6916009)(4326008)(426003)(356005)(5660300002)(1076003)(6666004)(316002)(2616005)(81166007)(2906002)(82310400003)(8936002)(86362001)(16526019)(186003)(336012)(36756003)(47076005)(70206006)(7696005)(26005)(70586007)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:47.4320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed014c4c-9c0b-490b-e1fd-08d97d2ab7c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4025
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

Bind to all 0x1002 GPU devices.

For now we explicitly return -ENODEV for generic bindings.
Remove this check once IP discovery based checking is in place.

v2: rebase (Alex)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3ab7099a1b16..c21eac6216a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1793,6 +1793,16 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x7423, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BEIGE_GOBY},
 	{0x1002, 0x743F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BEIGE_GOBY},
 
+	{ PCI_DEVICE(0x1002, PCI_ANY_ID),
+	  .class = PCI_CLASS_DISPLAY_VGA << 8,
+	  .class_mask = 0xffffff,
+	  .driver_data = 0 },
+
+	{ PCI_DEVICE(0x1002, PCI_ANY_ID),
+	  .class = PCI_CLASS_DISPLAY_OTHER << 8,
+	  .class_mask = 0xffffff,
+	  .driver_data = 0 },
+
 	{0, 0, 0}
 };
 
@@ -1815,6 +1825,11 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 			return -ENODEV;
 	}
 
+	if (flags == 0) {
+		DRM_INFO("Unsupported asic.  Remove me when IP discovery init is in place.\n");
+		return -ENODEV;
+	}
+
 	if (amdgpu_virtual_display ||
 	    amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
 		supports_atomic = true;
-- 
2.31.1

