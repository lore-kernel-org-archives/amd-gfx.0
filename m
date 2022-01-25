Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739D5C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 10:03:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D719310F0B4;
	Tue, 25 Jan 2022 10:03:42 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27E4B10F101
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 10:03:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4s563FRjY9qAc3jeRxfnL/EmYB0leLyPuJ7lIfzwMID98i78Cp6QYwYyuVHCydAQZdrCoh+TZaA9n7EFMxzDDnTX1jtTwYI99aAHHymnDPUmZ3wqxcVPP1pOONmibToXEvrWsXMlNwOKi/KD2Kh1LyKW9tQh/1oGfdNqz01r6zkgCrbucdKg6RBMEAMaodreIarP6ScpvLw2lL8xNo07wF7GWqIRG22A/nbXGkzi2OKQSHoM9wcqw4dY+oDUEYcrb74RNtYXixC9EIZwj19+7uRGSHOgsaq4MRcW8qJQPTS4kFf6JJNOpS2jqCSjF9E2Q3FHR/HN7bIy4Ks184CIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNCsGejZW1S/I2Sjf6cF1J9ty9N9rtEjbSUZw72wa8c=;
 b=HSQlQ5G3ohxOkj99a4aPnwjxQiy5yIrXbWOTfX97VECTmaGwwwuGVMgx0r8M9D0aZtsg3unX4UfJh57lWSUfVOADGu6RCTOGtcRpvfRTzJxJOuC5JvVLlEKEDydDPzHa4FPYdpXBLoLcpFQlPmHe75x8m77oJTe6+ONR2JeE5uYbYKIJkP2tKBccKQaO2vHRYKtxj5XEFgkAOpXTSykbStxdIrQPwXIEv/LA8jWES5cSnoOSFk3foyCbwWMZBb/wC+D2/KZuy7Euo4pQb5+LtqDnSZoEAdEKpALlZJGy0delihHkx10KWOmMTGc5C1JTv5W69jxKhi84BcBqGXgCnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNCsGejZW1S/I2Sjf6cF1J9ty9N9rtEjbSUZw72wa8c=;
 b=vbLbQiZ+giNd+GQRRRhOZje71M/sYcZvLI1ka4HnUV7Xrs0c17SaLcU+OBEPVgYJiS28ETulJZ/f/yO9KOQuXksdEZjtYPMdcMglsEvDOwHjMFj5JEwyG630u7WASBbdFlHfSUih9MIIA9+luiMk4ixp+bE7Mo3+S7QYdGeQY6U=
Received: from BN9PR03CA0031.namprd03.prod.outlook.com (2603:10b6:408:fb::6)
 by BYAPR12MB3367.namprd12.prod.outlook.com (2603:10b6:a03:d7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Tue, 25 Jan
 2022 10:03:40 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::f) by BN9PR03CA0031.outlook.office365.com
 (2603:10b6:408:fb::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Tue, 25 Jan 2022 10:03:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 10:03:40 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 25 Jan
 2022 04:03:39 -0600
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Tue, 25 Jan 2022 04:03:37 -0600
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix an error message in rmmod
Date: Tue, 25 Jan 2022 18:03:21 +0800
Message-ID: <20220125100321.450194-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12004676-b94f-4098-2161-08d9dfe9f63a
X-MS-TrafficTypeDiagnostic: BYAPR12MB3367:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB33674033C14921A6632108CC955F9@BYAPR12MB3367.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y46kMOWiHoij/gOzmxJDAXnK5QsNrVfrOM6zJespm+V7JrFnL2ZPxMF0klrSNoz0TWmUi5r628R9SUTabVMoNFSlD6QMUCZG5+0yiibFPQxI0vy7qSGdekdhx82eczjtQZ7rJSye4avMRu3OAgJSWAoDmfiem7GM9mdeeBpSBduvF/J6ftDis5eN/jSMde1UGI13kVSXZ6WHhDnv9xegxGp8kwkjRgAvPj7Lm0sVz+a5utdYGAgZ1Z1rwl/aK+vZfg/Em006PpWPbwV/I/pDGMOhzzlJn29rTtuQ2s9lrJRCbCi9a5zOUmWbfVDyD/o2d1V2RbXZBC/ZAhl9twFJG+IVLt9dSg3fa4JBR6TRnzL+wtI+h0kwRMEFqWB5n5A7ely1zBO07qXoI0meofQEC5XPz1hihC65aJi/6jlOXE5MBtqS55ATdlWkyma5/aGKtyFj5uAjHKo6Vi8jakjhEyA5P/kN29kPiNUyq13t+JE5lyoiI2oTsLBDYIgbu+6VmOrkSDOAbHmEhrPW7UYam+FqP8RL40lCTHU3CL0ELoi6GVEr0lHos8Mdd0i9TImFKyhomnxp7ccbJt07nUhk8p9weySycYkj3pGCFr3BbcVeKorvoysxy68gmHwlywOlfCBJIZlI94EstP1wHL++M7YVfjzKQwdd0tBF50mMhcYs6EcQq/DbAEzHGBb4hHetmMhYLA0sDS/4C+UBAnhMHS9UiDCpCJ6RIzGKwU8GA0bLYcTeeriRVv2326QRYAUZGP/H/vYS8HVA/C8mspzO81/xOIanqgjy5XF7x0pQBi4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700004)(36840700001)(1076003)(2906002)(83380400001)(356005)(70206006)(70586007)(40460700003)(4326008)(2616005)(54906003)(7696005)(81166007)(8936002)(5660300002)(508600001)(316002)(336012)(186003)(36756003)(15650500001)(6916009)(8676002)(36860700001)(26005)(44832011)(82310400004)(86362001)(6666004)(426003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 10:03:40.0545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12004676-b94f-4098-2161-08d9dfe9f63a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3367
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 "Tianci.Yin" <tianci.yin@amd.com>, Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tianci.Yin" <tianci.yin@amd.com>

[why]
In rmmod procedure, kfd sends cp a dequeue request, but the
request does not get response, then an error message "cp
queue pipe 4 queue 0 preemption failed" printed.

[how]
Performing kfd suspending after disabling gfxoff can fix it.

Change-Id: I0453f28820542d4a5ab26e38fb5b87ed76ce6930
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b75d67f644e5..77e9837ba342 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2720,11 +2720,11 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 		}
 	}
 
-	amdgpu_amdkfd_suspend(adev, false);
-
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 
+	amdgpu_amdkfd_suspend(adev, false);
+
 	/* Workaroud for ASICs need to disable SMC first */
 	amdgpu_device_smu_fini_early(adev);
 
-- 
2.25.1

