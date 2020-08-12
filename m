Return-Path: <SRS0=Jh+1=BW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED63DC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 20:18:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7139B206DA
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 20:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IkRGtaBM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7139B206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AE6F6E19C;
	Wed, 12 Aug 2020 20:18:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A6AC6E19C
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2020 20:17:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOn6Y7mjAFZeutjtmoJA2GgmHBloWjn4jwo0WldBNOUSvGGmPgz6BNd6Ltl2VWlOirhfsJ/gF5hZHKw/h9JRxXhREDdvBMy/XJnSIhXrMtU761HNwJT+x/i0ek4FlMx5r4Ffuts7stAZSnagOlmSS3+TzQ0qstdVr3xe73JgQTpszOwHclq4M2+wRDSDxSHLHRPvVaBo555VUEvQBZwS6iKL0qegRVX7c3YYv/z8xRxZlGjI4E0aeatEirfGAjYc7HOY4fgvoGCS/j7UnizjirAb41tDlzt9ECUtOnO1x6QrW6ODBANbAtQ3ngjo8hxUOzR1+fGkWPKz8UJ0ySBYWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4B1cpFvH/gHe3rlLU59gmj0voq2QrBCoaUoLzSLI00=;
 b=R4UPtIa64u7AUGYn/dvjK8v28eAwhvyNh0IwWFFU+i8/JALVLEFuGuErV6DQNq4XsG283yDnA0Kx4SCFCWX74HZ1og+l5aSBMe8+9H9QRbOkAkMKOV1+uGbhQN+H71wCO4QZFEx2Vs78c+tMtKMad24PFmpjIvC2ZyrB/Cqp2dx9U28Et79SpOVHYNMv5M79voP1ydOEwpUZE/0CBpy9xpoSoZnmBMQrnMAjYVbrfuZru5gc7ws766EAd9vVx9uM5yhg0j5xWXcZ4tkyYsyHLzpx7DrVwmNpFWKXxgjgCvwxJQWX0eT4eH0z77/TZRFzyV6YSF/wLiYhA1nnZ/jj3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4B1cpFvH/gHe3rlLU59gmj0voq2QrBCoaUoLzSLI00=;
 b=IkRGtaBM6969e+MKYoe7frYcK53JtUyTjd6GpTRhijmqu04Rs4SpAVK9LTt/8MJ3M6wlf8FWdWz+J4D/22UJ/Noit3xjuLDnwSvxeO0TU42o3avyrYS9UnOYcDqhDpeyZENpbi4NJ6srdmfb7h07Ppg6N9NELgEjKGdwWx4uykE=
Received: from DM5PR19CA0010.namprd19.prod.outlook.com (2603:10b6:3:151::20)
 by MN2PR12MB3134.namprd12.prod.outlook.com (2603:10b6:208:c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Wed, 12 Aug
 2020 20:17:56 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::68) by DM5PR19CA0010.outlook.office365.com
 (2603:10b6:3:151::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend
 Transport; Wed, 12 Aug 2020 20:17:56 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3261.16 via Frontend Transport; Wed, 12 Aug 2020 20:17:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 12 Aug
 2020 15:17:56 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 12 Aug
 2020 15:17:55 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 12 Aug 2020 15:17:55 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <nicholas.kazlauskas@amd.com>, <alexander.deucher@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: load ta firmware for navy_flounder
Date: Wed, 12 Aug 2020 16:17:20 -0400
Message-ID: <20200812201720.25242-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7eb7dafb-3581-48b3-33c7-08d83efccd25
X-MS-TrafficTypeDiagnostic: MN2PR12MB3134:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3134BB6E2A88F4556D3144FDF9420@MN2PR12MB3134.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:473;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hYansMwZWFY3UVzDWJJ2D9k6dmJeqLO04JWaAlReES7TUqMihcFhUwFR7HXC/T/iTVjg1jpFTKl+2o7xYfrtcBfo14s7bwbRaDS1FV8Cn8eKWh1H+9XeA2XPHWEQibKEOfL4PQMYaDdX+9DcCYRUh0mGwYzjilxGAlxT02bbzyO7dVviFkGXzfeX37FT5IsHAkoYV3tWC4scJwUyOVIEDolsvxlyU4GHIHmayJriJer2MkSaExA/4E99po80uUqImJ+pwCbNc3LGrny+2z9ZpeA+GFFhE0CfxH7+T15z3baK1lvpy1CUV4QU+/M46h+C2M710I9rYd93g/cTzy/4qGDGkSGMfa1jZ2BgI47ndSZQs6m7ZNZOnyKmiJ9KskCYK2qDWLqaNjcJYpgeWX4cN0AFwurgSAUL83cDJEnvP/Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(46966005)(7696005)(426003)(8936002)(26005)(2906002)(6666004)(86362001)(186003)(4326008)(8676002)(2616005)(478600001)(110136005)(316002)(54906003)(70586007)(70206006)(82740400003)(336012)(47076004)(36756003)(81166007)(82310400002)(5660300002)(356005)(83380400001)(1076003)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 20:17:56.6543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb7dafb-3581-48b3-33c7-08d83efccd25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3134
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, john.clements@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

call psp_int_ta_microcode() to parse the ta firmware.

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index d488d250805d..6c5d9612abcb 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -58,7 +58,7 @@ MODULE_FIRMWARE("amdgpu/arcturus_ta.bin");
 MODULE_FIRMWARE("amdgpu/sienna_cichlid_sos.bin");
 MODULE_FIRMWARE("amdgpu/sienna_cichlid_ta.bin");
 MODULE_FIRMWARE("amdgpu/navy_flounder_sos.bin");
-MODULE_FIRMWARE("amdgpu/navy_flounder_asd.bin");
+MODULE_FIRMWARE("amdgpu/navy_flounder_ta.bin");
 
 /* address block */
 #define smnMP1_FIRMWARE_FLAGS		0x3010024
@@ -179,12 +179,11 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 		}
 		break;
 	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
 		err = psp_init_ta_microcode(&adev->psp, chip_name);
 		if (err)
 			return err;
 		break;
-	case CHIP_NAVY_FLOUNDER:
-		break;
 	default:
 		BUG();
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
