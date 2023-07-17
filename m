Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DD9C001DF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jul 2023 15:59:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED85610E280;
	Mon, 17 Jul 2023 15:59:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DFB510E280
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jul 2023 15:59:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7VOnbFRLfbu6fr84uycAWznUZ7KQ0isIjHy2NJuVyN4Y0iNwwzVa8l3DEVZinE82ocWGNrZLCTPEnQZbVGpWGcS24NTOCZHWSnUyPVHFbowhkbO9uL72wro+9Q7aapq557AD7Mu3+TV2wtLaQXI2QyB2i0yWLn0hmPwi2kFL7NCK8k7ORlazPa7tEDO4WwSTKMf8fTY9r6yqsPLE/OUNUlGg49uYe6uGVoBVjoVgHv9O2+LAV51DHKqMOedvKya4vg4jYwlhf6vgCC01wkV6xhfEWuVTC8/rOty8UleCZuU8rKuw4lwuShkHkx0yNjDSAny5D8VOTUogGhEofnxtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOTUfDRdAJ19pTQeUKB2On1bXu9BJim1OXCWQkafYSA=;
 b=HXTDBXdsGRdHagUr5fo546ivg5exhxzy/8vjzDUIis0l7a8h0nCft1b2EkSoUIbi9NTO7eI3G90ch+47FpwMSCLBkkEAjH0VcG5I9r5wS3bAARl0AW0D7Ns/J9aAobnisfPV6QlLX75LVzJRRcG2P6T+99J+mzbWWhlkjJOeDgVhb5kCtFCiYRN/e09toaNsiHEnH003PK+bONHbrpOPT75SNhp9V2Tee8u17eXz8dhalIhO1zIBd2SoovTmUky6YRHDjhl7DdkCmelAE9y3TZTtA2kqGc8PnUViJleM9qKzz8IFgCYozBvNjvOOyS+ObqVjAes1MkjtQLcNAjLszA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOTUfDRdAJ19pTQeUKB2On1bXu9BJim1OXCWQkafYSA=;
 b=YCgFbDqsuHFcEeooVzvjCz1vdhgrRRjJqX2YgwNpDCEAihyVbou7JQ4/RERi498OMnd4Ue11Fw/q4qe209arepwBTGQjsqJ3IcTedIO4GXtMrz5+77F+us8IgJ13zV1BDzXmcO8vKe9Lv/DMt6YJwnEnfVFDrksAGiAXiAuoCPs=
Received: from MW2PR16CA0053.namprd16.prod.outlook.com (2603:10b6:907:1::30)
 by CY8PR12MB8066.namprd12.prod.outlook.com (2603:10b6:930:70::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 15:59:17 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::e1) by MW2PR16CA0053.outlook.office365.com
 (2603:10b6:907:1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Mon, 17 Jul 2023 15:59:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.33 via Frontend Transport; Mon, 17 Jul 2023 15:59:17 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Jul 2023 10:59:16 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/7] drm/amdgpu/jpeg: mmsch_v3_0_4 requires doorbell on 32
 byte boundary
Date: Mon, 17 Jul 2023 11:58:40 -0400
Message-ID: <20230717155841.758516-6-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717155841.758516-1-samir.dhume@amd.com>
References: <20230717155841.758516-1-samir.dhume@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT012:EE_|CY8PR12MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: c255ccb9-866a-4c54-3a7e-08db86dec6bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bcO4G2nohIc8N4py72K71fs++XaMduyprTFvEEExLBOHDv299tt5DO8T2ANObG+olMKY5cVf3i1As7llV9lzTpyrtEedsSrX5X/EUNRVAzP0ZjcA8phMAl9XVxmT+PR69RKn444C1VCEPf1RzWDcWFX22SKc1H34gyHSwIuEW/RPY5R39WjOr5gGocAll6+7MmbESmf0Ds8k/lZmcZWUZhZU6fHork1ZNN9w1q/mZQvVSnCDrqgkSAyYDJajEQgsSjq82eieUo66pisGjYvJ1adc8917jQHtKsSe0/bgVY77S/EXll0440ocpVfDpKVUij5TJeWFMr1fDhu8hh47eRd6lA68ChA7Io3DE2N7YnJYEQSLtVpeTVgAwjJS6MqeRAznnKTEjcKriAUaUP+TZqFWIk/ZaQXaHITy6M3TEB7G4ynILXfTn6VFf9OuOgNhmh2tPUkaBG6i4X1kdIGlAqJsw/KAqctoWy7MeQJsRflcPdjwzujKPhoTN4DpJHRArk7IwPvRda8nuhnN4Lil/xDjRiMjONZyNLwEEIdTolf3dUsB5YUBriZQsEon4vXcSzQAXEfsF3cLTF1j06T6wSR2qenF1wDkPN/nygEuEKJ1+DnFOxttJelqifrhrXRF3DFIhDVj5ldes877ghr8NWpceKwuNPse1dvYzy1qsL81aKcwBT2ryMtVJjNxP9TWZpfmCs6MgCSL/bHraLHuaO1YUB8+eNsgsojjJr7e04lO6wym49q8QN2mUhNJWKTIabzMTyX9yoWj1F7hfnq+Qw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(86362001)(2906002)(36756003)(44832011)(40460700003)(40480700001)(47076005)(2616005)(336012)(426003)(16526019)(186003)(83380400001)(36860700001)(1076003)(26005)(356005)(81166007)(7696005)(6666004)(82740400003)(316002)(4326008)(70586007)(70206006)(6916009)(8936002)(478600001)(5660300002)(41300700001)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 15:59:17.6515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c255ccb9-866a-4c54-3a7e-08db86dec6bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8066
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
Cc: Samir Dhume <samir.dhume@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 85ee74fdb7e3..896e2f895884 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -111,9 +111,20 @@ static int jpeg_v4_0_3_sw_init(void *handle)
 			ring = &adev->jpeg.inst[i].ring_dec[j];
 			ring->use_doorbell = true;
 			ring->vm_hub = AMDGPU_MMHUB0(adev->jpeg.inst[i].aid_id);
-			ring->doorbell_index =
-				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
-				1 + j + 9 * jpeg_inst;
+			if (!amdgpu_sriov_vf(adev)) {
+				ring->doorbell_index =
+					(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+					1 + j + 9 * jpeg_inst;
+			} else {
+				if (j < 4)
+					ring->doorbell_index =
+						(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+						4 + j + 32 * jpeg_inst;
+				else
+					ring->doorbell_index =
+						(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+						8 + j + 32 * jpeg_inst;
+			}
 			sprintf(ring->name, "jpeg_dec_%d.%d", adev->jpeg.inst[i].aid_id, j);
 			r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0,
 						AMDGPU_RING_PRIO_DEFAULT, NULL);
-- 
2.34.1

