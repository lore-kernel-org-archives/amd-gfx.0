Return-Path: <SRS0=tcRC=MO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197FCC6377D
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 05:27:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D187660FEA
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 05:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D187660FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 997816EE4E;
	Thu, 22 Jul 2021 05:27:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8432E6EE4E
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jul 2021 05:27:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRW1jGFdjQrUd4crjvawecP7SnyZtR3ZQe8noJLrBZXcb8CN9Db4LVPvYBDNLROBfdmHciEE0gUsjY9t0XavrurkU5lvHyy9FV3AzyV1EgXmY0zWJw8vFE72NZJq+7nflZbzIw1EPpxrAVoTzhPD2PK+GqD0cOHUtM4xJ+Tg3v3cn6Gb+2OEG9PQX+VqhWtGB2bA8OSPhTcVBTNCGnO8OfNMr6sNuv2XzdlLyXD9xchKdI6rFITHMnW7Sc336Ke6U7cKCSGOmewaos45dzTvDYOdAKSSUuj6hskZkNv9+v31/SKS/c2pXt8aRSzJewg/BriuBCyeACcYyRU1RohWnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQgvFiknoSF4zMDrWZEmRtOqizDbwMBndwArUJbwuCo=;
 b=MAKZzW6oL5Kj/6hAUZjTGppD6bsVLph7kS0OLfJcC9cfiPIk126ICeL9ee+CS0bKcLNjTkEEgS1Nplx6askdCwagBx4onPzPp1oD7XGiHgGVj2p3aSepETOJQ9q6iCBR2wGb5JZbzb6JKFqHBLn3Du9X7IF3izS4CDoMYBcSY3UG2e+70lqtYN6w682QmaT9fWjYbqWqQ931jEK6PFCmMgX8geqLAdCWkdd8ov1AKKRvqD5vIsMiPKY4NMD1P5zCrtm1Jh5Ph6/DWfu4yLiPoKaPGNBat+Cj6kVffS4k09JEDdmI3Hnk8MPGSDVibBMyJcC2+doQN4Yvgbw1cwtQSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQgvFiknoSF4zMDrWZEmRtOqizDbwMBndwArUJbwuCo=;
 b=Mmh/0Rmn3/eGpan3H/Lyff8xaTmeiSF7Ehn+K7ENf0jPbw0iHTNX97+6Gx/MnuLmN42yggcQ4sz9KEtLMldETvMZEjOAlHYj32La+DH24yH604m92KNnILEUHBnEWy6nhCgXZG8OoCOarlGgpLZAlLbEQRU9FJK9lvAa5I/8/Ks=
Received: from DM5PR06CA0083.namprd06.prod.outlook.com (2603:10b6:3:4::21) by
 BY5PR12MB4148.namprd12.prod.outlook.com (2603:10b6:a03:208::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Thu, 22 Jul
 2021 05:27:38 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::3e) by DM5PR06CA0083.outlook.office365.com
 (2603:10b6:3:4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend
 Transport; Thu, 22 Jul 2021 05:27:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Thu, 22 Jul 2021 05:27:38 +0000
Received: from ETHANOL.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Jul
 2021 00:27:36 -0500
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Check pmops for desired suspend state
Date: Thu, 22 Jul 2021 10:57:14 +0530
Message-ID: <20210722052714.626304-1-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f62aead2-4c36-4972-eaf6-08d94cd16b44
X-MS-TrafficTypeDiagnostic: BY5PR12MB4148:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4148E919B1E5F25609F2295E80E49@BY5PR12MB4148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1aJRab+kLPcXgTxAvfSdyfcOyfo4gbqhowwQp4vbhqnyQUuQhyFbPdmx+gaXNzM6BpZB6G1uUYqfVlMTkvD06/2eDSO6ZWJ9WQuT2pKfX6O4lo/QfZ0v3BAgji2XE4vqdR6hws36gRAFXZl5hi93GQEpuet/4c5UIWIYhRSW526CkOWdsBSA1gmRv90Dy0KglRCfL8Wy3drCs1iIUHMOLd4YbpqMTDaw6zbEdgeOfrTP/PdaUvcUEIxWr3gN5TzY/2xQyP9BfA4l3IzgFXi5ryf0uNFebs/MKGYoauGHwAQ4ajeLm1EREvLnzofAkJ+buH7GLqcID11QHKuOQin0zCdoMBXYjAX69LEkcJqa9tgk6rIgjBj/K8TlNBD60JJN0mG9LsyUj3RibmgVpfbZk/ilOIZVqfSVDC2PWJMJE3zdzuQXLaOuUijOk4gPuH3RACVUOpJo7uVY0qlJR+w2C3ejNg3kDwIOhQFNUtVidfnCcCxNWhoA5h8FyT350kpqdwY5604gcPzWmkViZMB3kX9O8w/LUGQ2bwaU/r/llUmr+yi/q62f3WJkwhQSgVnBHTA46dHt0Nln2fhYl+LZZrQyAmyEMZMZvLPO9ovZflBvTm8sB31dIErYTE5zgxzotBXoyjo6eYa73v/63yKyz7xV3F/svA4RSGYC/vpFvBDZ5GfGte2oSEmGAwD4Ui34m4Ldf6zc6YqXlJUFzHiYh3HxywLo3OVGEoUg7bi7p51xwxKJ7Ug0COEqDMifGEpf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(7696005)(36756003)(2906002)(81166007)(4326008)(36860700001)(5660300002)(110136005)(8676002)(86362001)(6666004)(26005)(336012)(4744005)(82310400003)(316002)(356005)(8936002)(16526019)(2616005)(70586007)(15650500001)(70206006)(186003)(1076003)(426003)(508600001)(83380400001)(47076005)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 05:27:38.0190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f62aead2-4c36-4972-eaf6-08d94cd16b44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4148
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
User might set mem_sleep as deep and it will result
in amdgpu resume errors.

[How]
Check with pm for default suspend state

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index af1710971ff3..d92196429741 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1468,7 +1468,8 @@ static int amdgpu_pmops_suspend(struct device *dev)
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 	int r;
 
-	if (amdgpu_acpi_is_s0ix_supported(adev))
+	if (amdgpu_acpi_is_s0ix_supported(adev)
+		&& pm_suspend_default_s2idle())
 		adev->in_s0ix = true;
 	adev->in_s3 = true;
 	r = amdgpu_device_suspend(drm_dev, true);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
