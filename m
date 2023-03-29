Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1C5C6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:18:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CACC610EC48;
	Wed, 29 Mar 2023 20:18:07 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73ABF10E3BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:18:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBBnP457aReb+e4ABxU/J05HNaMgCwZLIo82Ee73joZQKr0pXh+eFraZ6ZQlFYoTiCtKhjl14HjVas1UEfvvSe8Kt7TjUq/W0DRFvaL1Sim9FEZ0rGD076MbbHVEccIXuY4hGr/PACryc8j4QAEJMswIc0O7IWKr/abx4Jr06BCkC6Ek1ov+EbspoDlSGamGrhsc8bfFrRy2fs7BFTeZwjJ8UOdtUUTeUDxWYmKgWcyDfReO28crDSWlH9ZjA4/VfFVqi7bLeOqMjPHQdQwuVD0bQMQnKW4k/1xivKySiBONssIRyCS/mVTK26NeBRopv89ioui+n5ScayqLTFDBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7P1LGf/0hGkt1XB1Ckjdh0tfz35JQ4+OYX65DXHJAM=;
 b=dMj2V+1VSZ/xHd7poEvGfOcvJyd4Cyc1e1qob8cF3X0Moz9bgzp5nzqGdaRvxrfT5v8ZxfwJZ9MDt6WG/BQw3qaAsZxrr/fytgUe8FDJpRjfGW6vzd2U++mq4WH4ymgp9dtlEO74+MfqmMt6im/zy6A3b/8tKWhvlg+VTwx4OXqNZ+uLcVpQ2jPJ8QJwbSbzLhiMWGSxyLdhPmEdur5rMTfiNCVXs/pSayo7LYhZVmduc46QFZ0xxzHiZ9h7ubNUJhREDya6gSftsPMaKho2spr4Nr89xJzcl/w09ha6VAwf3Fnv20NzHPV3Mb/PUL8TUSnYvHjYydy3oBo6p2kHWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7P1LGf/0hGkt1XB1Ckjdh0tfz35JQ4+OYX65DXHJAM=;
 b=oGp2sNMXWY3AIqYalmFufb4N2K8sqNS58UyRduGEp5FvrQzNiYJJ9Dsbj7o09vAhNaUpwnjcwnmlzjpvxmEK/cxSfW2hcnGGJLeicGRlHVhzhfItjiEhNQVLUAYWJoKEUUYtjQ1H0UY8SMEQKctCXMlBgL4ttw9vxZAA5owmVA0=
Received: from BL0PR1501CA0028.namprd15.prod.outlook.com
 (2603:10b6:207:17::41) by PH0PR12MB8176.namprd12.prod.outlook.com
 (2603:10b6:510:290::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 20:18:01 +0000
Received: from BL02EPF000100D3.namprd05.prod.outlook.com
 (2603:10b6:207:17:cafe::5b) by BL0PR1501CA0028.outlook.office365.com
 (2603:10b6:207:17::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:18:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Wed, 29 Mar 2023 20:18:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:17:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amdgpu: Add mask for SDMA instances
Date: Wed, 29 Mar 2023 16:17:42 -0400
Message-ID: <20230329201744.1982926-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329201744.1982926-1-alexander.deucher@amd.com>
References: <20230329201744.1982926-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D3:EE_|PH0PR12MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fd30577-df41-4078-b2b7-08db3092b18a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DZJSe1tCSm+9mkD7Ww5Z47MSQWZjjPeU0NxeiYajFDDyIBjM5RbJYyXR8EODChXmHaP9qQzZ7/8IdqyYWSWDLhhCff7qWBgx38kv7/raZMNE41o1GofKC94lmHGCDrODlOYtrW8t4X686vkQloUy4oav9ikS73RKIcXsUG97d4vuEyqsWWmIaTeQyhRvno8Udk/9YO6wt6kYFSCZoyzBu71UdxM1ZPHEYuMvy7UOIQh2PUutjmUJgMrTxe531ufhD+PikBNIzV52D9ZF3lvAqwaBRQKMbpunrmeGaGUrcIbj8sSR3I2EfDeBTWWsaI+N4DLiIT8qFrNST/4UHQn3VWoLtISghOJZKEzldGqaY9Q/xABGwBnot3PuDbsVktqjA67THPAM5kD88g0j0EJqwzYW7KzahjUTUPY6UJCbeiYNAxxg1UdyMa68GkoTToQB9JFvQLMDCbN1v3nBoM3cMInv4QEObg5XPzjBpa5l3V7xQGMzbMEC19nw/45w13xWm2lB2xoZkv2a/nO8ub2nG1vMD0OApv+3N1HkFmYgq5m/ORPsm7okpt5VlaXDFuzffXdbKakD+JmPx6GqFGFHJTVSi+Qs+nic+O961A9NFG1rgrP1cSkbtlrWYMADANv3Jlpoj9oxRoOySt0thqBCaVD4Rs+G8KFeTa5dVqVGrSuSF8kTFcl+kjodEOmAA3G45kpG5L7iwQvGNsSywwAnkFk3v5hx9rzREsoQwSWn3Uw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199021)(46966006)(40470700004)(36840700001)(7696005)(6916009)(40480700001)(4326008)(40460700003)(41300700001)(70206006)(36860700001)(70586007)(316002)(8676002)(478600001)(54906003)(83380400001)(16526019)(82740400003)(186003)(5660300002)(2616005)(82310400005)(426003)(86362001)(47076005)(36756003)(336012)(2906002)(6666004)(1076003)(26005)(8936002)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:18:00.4603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd30577-df41-4078-b2b7-08db3092b18a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8176
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Add a mask of SDMA instances available for use. On certain ASIC configs,
not all SDMA instances are available for software use.

v2:
	Change sdma mask type to uint32_t (Le)

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
index dbff8220fc19..5a1511a22367 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -37,7 +37,7 @@ void aqua_vanjaram_doorbell_index_init(struct amdgpu_device *adev)
 	adev->doorbell_index.userqueue_end = AMDGPU_DOORBELL_LAYOUT1_USERQUEUE_END;
 
 	adev->doorbell_index.sdma_doorbell_range = 20;
-	for (i = 0; i < adev->num_aid * adev->sdma.num_inst_per_aid; i++)
+	for (i = 0; i < adev->sdma.num_instances; i++)
 		adev->doorbell_index.sdma_engine[i] =
 			AMDGPU_DOORBELL_LAYOUT1_sDMA_ENGINE_START +
 			i * (adev->doorbell_index.sdma_doorbell_range >> 1);
-- 
2.39.2

