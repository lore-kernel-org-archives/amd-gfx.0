Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C8EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 15:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B70DB10E464;
	Tue, 15 Feb 2022 15:19:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 281DE10E464
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 15:19:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlREjtNXc0QK3bydUsiYlqt+2CUM++oDA5/qrhf/rqon4LLaYDFpi21R7c3jHlpVKT3BqL7ejGbRsUj9lCid00GyCslOoF/eSeGltgRfBM2KA6H91dbbp8+/RN4DRtSg2I75LxbG+j2+h3NtEPEVvqW+zggLY601+weRDDwOQ/2J9p7pCwUjRK2IiRaVCn+Tng2+R6NM5ySHN2HNnnklNu6eKeqye//VbEzW0VKjAJT0atkMez6KcCoMHw/2uwvpv+yeRtunWsveQcHMQbmAN7+QTDyqnpXOkwK3v4ujUGiGF1RJOpJM5/dwLqUHxeKJe7W0kox3nIrc7kXoU+g8kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50uQNJvYA+uLtWCnk7oEJdF2AgNPlBojp+yFLi9yJ7Y=;
 b=HLpAWOK6g0O3vMr2rCj4pgrbdePGGq20JyKADe+h8iMFfg9WELipWbImIaWuOoCcXmZoXJ/rROc6Qkhab1FlyQ6h5Eo5RfFiZW0B6gAlP4X2jL2ouohnceen6TlsOZ3a4o/oZzk9jHhHQZucSjNte9FQrTdXrwnn9VCwh07XGpYoGVAq+gQva045qtVLinCl53eHkqoXI51GCBDrTAaNQu3iDztA75W8qlRGgQt7CLnV5gqKPALJbfpw5Q0qAuRZOtIh2ij25hMdrr0Zi4mjysczaU+a+SFttUL/fEWMLGef9luC+tNmRHVyFb63S8gGr0D7IYehr2ctCgodC83OyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50uQNJvYA+uLtWCnk7oEJdF2AgNPlBojp+yFLi9yJ7Y=;
 b=cwYL3s0Dcerx8frDZoi23leQ9t3rpxUsS0eAbRo7jx4FXqBFV+0erRD2THmRhuWQCWeNZrF0NLauq6z2YKhw37yKRIAH6N1eG3lH5pVNZAlMloaLZZOmgN+FjSCtVz8KTVx7BEg/9JvNcUAp5PHyWlLb+mgaXXUz7Ed6LADkTLc=
Received: from DM5PR07CA0135.namprd07.prod.outlook.com (2603:10b6:3:13e::25)
 by DM5PR12MB2391.namprd12.prod.outlook.com (2603:10b6:4:b3::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Tue, 15 Feb
 2022 15:19:20 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13e:cafe::dd) by DM5PR07CA0135.outlook.office365.com
 (2603:10b6:3:13e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15 via Frontend
 Transport; Tue, 15 Feb 2022 15:19:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 15:19:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 09:19:19 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: update vcn/jpeg PG flags for VCN 3.1.1
Date: Tue, 15 Feb 2022 10:19:07 -0500
Message-ID: <20220215151907.2229731-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46fa6568-f4f9-40f2-a1e2-08d9f0968a67
X-MS-TrafficTypeDiagnostic: DM5PR12MB2391:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB23914EA4FD652D651EFC7D10F7349@DM5PR12MB2391.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NZqyoionfAhds6Ne5Bb1QpVczRsODz+ybdrHLhoJdKaHJnGoFynuIj/125KnBKdMaEydFMsRdyGDtBYox2a9u3p33DOfj7qlPPpgkRWQFJfh6MDjgQ5MC4ex998Ef8zuA6T759hsm8oUPiLh658IgUFUHJQBCLMq4RHydE4rz7lPSphHXDZgXSFytxcfOfQ+PcMQDADvJ3JUbOku1JBev7aT2Mr58Gw39f8uqylbFDc6Y6sLrU9WkeIpBDL3vJfxmvxyVyFwtF9iRwPdyURZY08qCCrOWkSUCWs1kKVFqNVdp7Kjb5YqGgw5W6xFIlQrp9o/VZYU6ptKGi68byxwmkvfitzNXyfN3efdHqPacPioeFZrzs+Bg/cTr0vbX52Ck2hVjqF0xJ4CXpXdoDGrAXyyLALHl1hJQ8aNWdT8BazgfI5ZCbXEocCXq6bNK8Q8WQkIj8nieebv0wyV53oadkTwHUUlzN4H2eucoz8O4KrvW1YSXF0QALAsgpbJT9RbOvSCNoaQzZIDZjAlThsU5M87kQPUpA0BehyVjQsTsQw0sUEvR13o6hKaWu0dKSMu8Gi/lQCGHmZRW+hKsEs0cofkg3ZIb69dVLoDvS/nQkSi1h37ADMN1bE3+v9lNehEItwmk1Lbix1fhhw3n01f8JBdkosyDTeRyCdZBbQqgvlJGmRd3aBEkBjSPXpdNggvHDaW2GY1MPTBnXWHQIgo/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(54906003)(6916009)(336012)(316002)(508600001)(82310400004)(7696005)(86362001)(83380400001)(36860700001)(426003)(6666004)(47076005)(2616005)(40460700003)(15650500001)(16526019)(2906002)(36756003)(8676002)(4326008)(70206006)(81166007)(1076003)(356005)(26005)(4744005)(70586007)(186003)(8936002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 15:19:20.6037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fa6568-f4f9-40f2-a1e2-08d9f0968a67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2391
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sathishkumar S <sathishkumar.sundararaju@amd.com>

update vcn and jpeg power gating flags for VCN 3.1.1

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Reviewed-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 8cd1dbaddeb4..8a5642f2daa6 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -907,7 +907,9 @@ static int nv_common_early_init(void *handle)
 		break;
 	case IP_VERSION(10, 3, 7):
 		adev->cg_flags = 0;
-		adev->pg_flags = 0;
+		adev->pg_flags = AMD_PG_SUPPORT_VCN |
+			AMD_PG_SUPPORT_VCN_DPG |
+			AMD_PG_SUPPORT_JPEG;
 		adev->external_rev_id = adev->rev_id + 0x01;
 		break;
 	default:
-- 
2.34.1

