Return-Path: <SRS0=eP35=BG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F8AC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 11:04:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D59472072E
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 11:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Aa05AJem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59472072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A13089C9C;
	Mon, 27 Jul 2020 11:04:01 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C909E89C9C
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 11:04:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHcxPy243Z4XXJ6KXxbtqeR7ryunC+K850pOQ9bxMxoq6KbtdIE961/ZMq/IjfdKry0kEFal+uOJXQL1AgtawPAKFz6bLaDmiDpNoQiAF91qJofVjWDGWpe8CJvpLHdoXz4RIQ1BnTOBw+2IhfT5ixoM6wVhPk11c7t68zOwvh2TieR9IpBbBCz2ffVNWaqNBxyOuNIaKEfvhlC3w0t4rZnHInVWExTbr9OxzPcTxFz8lDrzVppSkUUQo4M8OthCJNseitdp5Z/Z0O0VcgncroZWFgyB8dORdCcmPFkzqbfdXciblBwtc/9vb4AFPDS4OY5xxsw8yRa3Ni/nXQPnFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKzJzsDNiFFRJalhdrNsV7+pPtrAwi7eDuK0qYhi0Kg=;
 b=Pr/VfdBWTv0FSMi9AqamEOozmEiltSjUsWPr/YLHsfo+i3KZx8piC0uAXbTpKszoQVzbKqjZwVV58+AnFMfHiuU49HcwSxCPneuv9AFroFRQb8LEktBQXjsfP0OglUgfGYgbe07gDEWWLlpK4oSdM2kbxKrew0bGwVX6sALE7aNBZeXixGwB2jj+4+w73uR1tJByGfjbs4rToeLL7lbh/alH6CFROhbtLfSAJcLWpy/8TBWBCUBoYxR+OVZg/RwKBRTokObvZj7DIMNMhuzwfwtLHyf895FHqbZST2j7rweOVYATPRvoZA/bpM1knGJUZdJkhdjCshf3HzfFwX3rcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKzJzsDNiFFRJalhdrNsV7+pPtrAwi7eDuK0qYhi0Kg=;
 b=Aa05AJem7l9sDCCsEe/hgS/XHH4uLb0J3dkgpubK9zQ0jTIAWs4khbdBFl/Zckc8oaadaDDyQoWCCFccve1XEQin21rmFOJjCgqwPyubNL3GYaFTED094oh91BVYqYVhegUUdJVhvtm/ymbIs4G9RwBeMmUNppDtOVJ/H7oABA8=
Received: from DM5PR06CA0044.namprd06.prod.outlook.com (2603:10b6:3:5d::30) by
 CH2PR12MB4005.namprd12.prod.outlook.com (2603:10b6:610:22::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23; Mon, 27 Jul 2020 11:03:59 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:5d:cafe::e5) by DM5PR06CA0044.outlook.office365.com
 (2603:10b6:3:5d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend
 Transport; Mon, 27 Jul 2020 11:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Mon, 27 Jul 2020 11:03:58 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 27 Jul
 2020 06:03:58 -0500
Received: from chengzhe-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 27 Jul 2020 06:03:55 -0500
From: Liu ChengZhe <ChengZhe.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix PSP autoload twice in FLR
Date: Mon, 27 Jul 2020 19:03:42 +0800
Message-ID: <20200727110342.401382-1-ChengZhe.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84d1a123-9afb-4619-d6ad-08d8321cc341
X-MS-TrafficTypeDiagnostic: CH2PR12MB4005:
X-Microsoft-Antispam-PRVS: <CH2PR12MB400558267FA1B39789A0167B93720@CH2PR12MB4005.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5VAhVH0CLGYyXl3TrEkJaDnHwgn7468mEHVWsg9GRwoli8A4B/uV92Nb/rHoTb7GVBJTG48vWHb7cfnVOClruuhGE/jQ31cAnTCJz7Hr+EGdV+/0mlP6dTFdDO3ZSNopvPfNQc+eVNmH0ROUgDbYLATbpareaFUKpG3d8mTpelD2sPgFTtyQ8GdjxKaVTyJLynA/8OyJHQey8LAUm1zKhUKMBErtvvQr6DcIpqOhzqkW/74F3jTjCl1QuLyqxL8VgJOM6r3U99pCK16+eR8WOxAjElRt7iLguKW/tGnNKruSTv2LCOxTa3P9HPcKkMa/deYNkpvUfEYzERNcussAyuR9+SCWqQAiMfxqlBwEWUiMjQQspnIHsznXJNWzxgoIp864WaHw6Ms0do/Pga5+7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(46966005)(6666004)(426003)(1076003)(2616005)(70206006)(5660300002)(26005)(336012)(7696005)(186003)(36756003)(86362001)(70586007)(478600001)(54906003)(316002)(8676002)(83380400001)(81166007)(82740400003)(2906002)(356005)(47076004)(4326008)(6916009)(8936002)(82310400002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 11:03:58.8430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d1a123-9afb-4619-d6ad-08d8321cc341
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4005
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei
 Xu <Feifei.Xu@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>,
 Liu ChengZhe <ChengZhe.Liu@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the block->status.hw = false assignment will overwrite PSP's previous
hw status, which will cause PSP execute resume operation after hw init.

Signed-off-by: Liu ChengZhe <ChengZhe.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 62ecac97fbd2..88c681957d39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2574,6 +2574,10 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
 		AMD_IP_BLOCK_TYPE_IH,
 	};
 
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		adev->ip_blocks[i].status.hw = false;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(ip_order); i++) {
 		int j;
 		struct amdgpu_ip_block *block;
@@ -2581,7 +2585,6 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
 		for (j = 0; j < adev->num_ip_blocks; j++) {
 			block = &adev->ip_blocks[j];
 
-			block->status.hw = false;
 			if (block->version->type != ip_order[i] ||
 				!block->status.valid)
 				continue;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
