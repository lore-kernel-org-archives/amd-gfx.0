Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1927FC7EE22
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:21:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6C0D10E433;
	Tue,  9 May 2023 22:21:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A28010E430
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:21:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiGrBMXVFUhDMH63cBeN+xdHDBhv2e2MBHaesdTBWwVK1xdUhjjwGkxV7cv5zsybQKG51DOkA8OpebcEytYq3p0US2SM7XvYbqpnKwduNb6CNSNKVwnHVwekXrCUJnv9SCWv7sMIsuoj0E9bL7GVNV+37TvJg7qxxPRb+7k1NnXuze5QOkcbw5vVLNdQ7mgupQ2E13soNKdFKB72ivoJocST6tuf/A2vmn1VT6gXpGpDU7LDrbyD/eFGEFHCjKE7sMejZCx/firNpgZ92Ik1GsC1UUN07ggNi6b896pTDcZuZnQPLZIMBGIgcn0evS+2BlMc3dLlI4W809STsiKaIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMEL+CcILPTa7sEUOnGb5jih0M/gSb5qQvPUjW+MdG4=;
 b=nEHdXWxMfdZ97IavwO5h87WOn8a5gbi6HsdyYRGWvAZO4N9y5g+9zEm77/pAmTRe9//VKoFDk2q1i3OAPGkg0hVBJnil0Nk6qp9JwGxGj+Pj3m05txFnSv/vah8LC8gpDkUukwq9x/IndfNFqbgO2YTBwcwwL0TIv/bNBhC8PGEoq7wZy6PhOUgrUdXT46ivbMx6R7C942vmBHFMTbAxcDmWWPNOvESSX9CXpOwZqvLFEr5tgT1eDFf2SvvjELEzcwDMyoFarLePSwYSV1RjW58ivztfHL1IaIEqWZzUMNCq1c21913KPa7+Lhz+sN8E5zO4sHaBHZVi1h7kOawB/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMEL+CcILPTa7sEUOnGb5jih0M/gSb5qQvPUjW+MdG4=;
 b=mz0dtudYbjoAzv80LAN9D+xAQshJSirIOXR+zH05izen8l+F8o28knTAuSspeA9LcgIQM/CbMH4KhWR/c/AEdG/NyTFLNyPvwkj+Vv1zPx1gUCwz3TzxGLU5vnEF6QhsBEutQjexLDldQLEw7GDQHcsihFYiBN/7lHAHK89b52E=
Received: from BN8PR15CA0015.namprd15.prod.outlook.com (2603:10b6:408:c0::28)
 by IA1PR12MB7686.namprd12.prod.outlook.com (2603:10b6:208:422::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:21:45 +0000
Received: from BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::ac) by BN8PR15CA0015.outlook.office365.com
 (2603:10b6:408:c0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:21:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT114.mail.protection.outlook.com (10.13.177.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:21:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:21:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 9/9] drm/amdgpu: Adjust the sequence to query ras error info
Date: Tue, 9 May 2023 18:21:26 -0400
Message-ID: <20230509222126.477847-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509222126.477847-1-alexander.deucher@amd.com>
References: <20230509222126.477847-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT114:EE_|IA1PR12MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: f2a2df1b-6497-446d-4750-08db50dbc5d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5wEbXP3EjCC2cPciURFItLYvdLhaR/6CXf9bK3acdclf3z/YWeZnbeVK17ILOaN5qir1CaGUPyEcVB2s/czjpXNjaFtJKHUFJYJ3sxpOYVjkf1V8iu/QHA+Dldum01o7IZIKgQPnYutAZbrTkenUyu+Y3S3lsdQvtmY9MJJbPvzUqNbFVgAvTQgSV6fJ8srMva0uy6WB3cvEIZX4KoNiUb+qrlNlxV0kRJEpDGFDMXQPIbkI3CsQ0as/+M5D+hPnxePw8srZY8fOxKBSBhoRvoYXCyj+bhUFVQi2OOYI8TU2AieaYjL7FgXQLs4k+7pGhJT1egCGwWo1bY4RzPCaHHIjIT55+z/FK9Gc6/Sseje2UVvosMpy2F6eh/slErbSMSLBCKVou8VHyrJyJZaK6E45ijRtd/0foUl5//JuJ+9UfD/Ij83CRCVLOWyFhWshxIMejWiwpACVLXfQKYrMDgr+98SgIA48EjyEM7W5eOfAg6RxGDmgpJUjr0hdrOCf3KeFlawvmTD1P1Ll1T/ldb2F2POYyMhHvsLsWWgK6JDOWrWLtDYI8kXR4c8BXeo/FQuZEEK7Kk83DWQymGLbJcjzEuNQa143xV+64ox4Bua78H3FHce+BlKWkNuch9Ixc7tFtzCLSuOJ7C+AxZYn5JjoqQ17lQ3FXJmdie3QcCKMAcMV0OlpHINP2TdRWo4gVzQahTyA4BxHGNofRg33UeAS3pyJOQxZQ/fsLywoiMU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199021)(46966006)(36840700001)(40470700004)(336012)(426003)(40460700003)(16526019)(2616005)(186003)(2906002)(47076005)(83380400001)(36860700001)(36756003)(82310400005)(86362001)(356005)(81166007)(40480700001)(82740400003)(7696005)(8676002)(41300700001)(316002)(8936002)(6666004)(5660300002)(54906003)(70206006)(4326008)(70586007)(6916009)(478600001)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:21:44.9802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a2df1b-6497-446d-4750-08db50dbc5d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7686
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

It turns out STATUS_VALID_FLAG needs to be checked
ahead of any other fields. ADDRESS_VALID_FLAG and
ERR_INFO_VALID_FLAG only manages ADDRESS and ERR_INFO
field respectively. driver should continue poll
ERR CNT field even ERR_INFO_VALD_FLAG is not set.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 5ae89602a116..64f80e8cbd63 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3164,7 +3164,8 @@ bool amdgpu_ras_inst_get_err_cnt_field(struct amdgpu_device *adev,
 
 	if ((reg_entry->flags & AMDGPU_RAS_ERR_INFO_VALID) &&
 	    !REG_GET_FIELD(err_status_hi_data, ERR_STATUS_HI, ERR_INFO_VALID_FLAG))
-		return false;
+		/* keep the check here in case we need to refer to the result later */
+		dev_dbg(adev->dev, "Invalid err_info field\n");
 
 	/* read err count */
 	*err_cnt = REG_GET_FIELD(err_status_hi_data, ERR_STATUS, ERR_CNT);
@@ -3187,17 +3188,17 @@ void amdgpu_ras_inst_query_ras_error_count(struct amdgpu_device *adev,
 	uint32_t i, j;
 
 	for (i = 0; i < reg_list_size; i++) {
+		/* query memory_id from err_status_lo */
+		if (!amdgpu_ras_inst_get_memory_id_field(adev, &reg_list[i],
+							 instance, &memory_id))
+			continue;
+
 		/* query err_cnt from err_status_hi */
 		if (!amdgpu_ras_inst_get_err_cnt_field(adev, &reg_list[i],
 						       instance, &err_cnt) ||
 		    !err_cnt)
 			continue;
 
-		/* query memory_id from err_status_lo */
-		if (!amdgpu_ras_inst_get_memory_id_field(adev, &reg_list[i],
-							 instance, &memory_id))
-			continue;
-
 		*err_count += err_cnt;
 
 		/* log the errors */
-- 
2.40.1

