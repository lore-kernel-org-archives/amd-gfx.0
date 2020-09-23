Return-Path: <SRS0=BIvg=DA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9796C2D0A8
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 10:07:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 704E92076E
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 10:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="c/4boWi+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704E92076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A8296E90D;
	Wed, 23 Sep 2020 10:07:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C9CA6E910
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2020 10:07:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoDW/umSJbnkNOaL10xSeKVa7y6vU3/Y76FJCB/pBh+ZeHoQkjLBUS98yL677mloGMGbE3vCvB0QkD7KWuYIRqBqUKNFn3Jz/GIdwsNGXzE9k3lm7imdsAm8OoVgjjHaBY5ri9DhwWBNwQlIWj189ekn2hl8pENOn4Ga+9ME/h+PvqJldxwRQ/bourr4nQfBWQwlqea56vho3hAgCPE4+Suk8kP5mzs4u+qHrpLMOBO5LfXtvu7omiuOILQJ184UHdixlnLcEifWuv/F6UOa1rL70ocYUSz4NvN5UNkZGKIh504LERrxsjoKsC/ZuUJzAINi/8KhoFlcpJ72lgK0tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGK4X5lgk5jaQavvPqDpieZgt9arSOjd+frR/bfXo8U=;
 b=mfOJHHdypguiYijwy8F37wVXdcG6CfOyvQpY8GeYgJhygXN0Uyd5aTbGLwBDG0I3WDpH8TURM9Q180Fc7b4SSQ6SQa3cJKpvuRUCrqEgtfcyCtYWn50kpA6DdR7x9DgldfDy5z7LTwrTodG4J+f9w4mjSQCVp4OjUKQfXvecjuByZXy8DcXEb0YyCamdUUvfTob1g4flr3ZD84rnLbdEOBJWOhYeKPuJJrJ3kQd9DzvvXaxU9XVa3Sf1uuYvq3O4XAqvfAaBUw61rfwLsyLdjWQjJs3jUpPvOjr/okdpUKRmAzd93gCXb8hNuP8Gao5d3w7JvS+LW+y4AeocIDjjlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGK4X5lgk5jaQavvPqDpieZgt9arSOjd+frR/bfXo8U=;
 b=c/4boWi+AMMflexcAz9LjNH7lFtuyP6Ka4BWTYbWql45/sJ8oBbeQqDFVYPbxiQQJ+T+ICCmLNeUhuyaWuqukV/JF6fPW5ptqlWXp04/E5MC/qgrfJhsFW3f2wdiKbpBr4Pz8DlpaqlvWUaCBUR+P3GNJKRtBAuFlP3d/hQmfZM=
Received: from DM3PR12CA0054.namprd12.prod.outlook.com (2603:10b6:0:56::22) by
 CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14; Wed, 23 Sep 2020 10:06:59 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::ba) by DM3PR12CA0054.outlook.office365.com
 (2603:10b6:0:56::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Wed, 23 Sep 2020 10:06:59 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3391.15 via Frontend Transport; Wed, 23 Sep 2020 10:06:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 23 Sep
 2020 05:06:59 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 23 Sep
 2020 05:06:58 -0500
Received: from wayne-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 23 Sep 2020 05:06:57 -0500
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: Skip use smc fw data in SRIOV
Date: Wed, 23 Sep 2020 18:06:52 +0800
Message-ID: <20200923100653.740198-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c4f5df5-75b7-4277-843c-08d85fa86936
X-MS-TrafficTypeDiagnostic: CH2PR12MB4199:
X-Microsoft-Antispam-PRVS: <CH2PR12MB419914F252699818DB244FA6B7380@CH2PR12MB4199.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EHjMOp/Ho2HugeRqh4U2ycILsREfVaw8QgsOp5orpEbbhy2UyjR5LwrM4r+5OAHc9qA4zCzerDZvo7pyPg7T+ULUeQRI8yqohwrFkIdC59sngHxFWBPrN6YpjuOHuGtHhQhB9qgSxCRISsS1J/sAIHt18CHzl2o/v+9Bb66t7Tdo0RdmTSZ+OQJr0X9dOY5TCk2fx5AOJZHokNJMivJvE7eW7hXAbWzD0T7jpDXf5G/dTZb1zWwg1QHTFN8N4wnOVd79RtZV+Na5aidXI3tCOkazaFS3B9FxI6LP2Dt9NbnMUQvvEXea54YHeV7SgbJYfOuyA4/1WYLNHZXRXRT5yaY223TW4axleV/FGt03xYSfV1WlE/kMIzPrxHB5TPibmg3mRXfY++1ahRC2Rn3XqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(46966005)(8936002)(5660300002)(7696005)(70586007)(70206006)(83380400001)(6666004)(2906002)(8676002)(478600001)(1076003)(2616005)(47076004)(82740400003)(316002)(186003)(6916009)(81166007)(336012)(26005)(4326008)(426003)(36756003)(82310400003)(356005)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 10:06:59.6290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4f5df5-75b7-4277-843c-08d85fa86936
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4199
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
Cc: Jingwen Chen <Jingwen.Chen2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

smc fw is not needed in SRIOV, thus driver should not try to get smc
fw data.

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 61 ++++++++++---------
 1 file changed, 32 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index b53872eb4398..d8ca6d968813 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -322,39 +322,42 @@ int smu_v11_0_setup_pptable(struct smu_context *smu)
 	void *table;
 	uint16_t version_major, version_minor;
 
-	hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
-	version_major = le16_to_cpu(hdr->header.header_version_major);
-	version_minor = le16_to_cpu(hdr->header.header_version_minor);
-	if ((version_major == 2 && smu->smu_table.boot_values.pp_table_id > 0) ||
-	    adev->asic_type == CHIP_NAVY_FLOUNDER) {
-		dev_info(adev->dev, "use driver provided pptable %d\n", smu->smu_table.boot_values.pp_table_id);
-		switch (version_minor) {
-		case 0:
-			ret = smu_v11_0_set_pptable_v2_0(smu, &table, &size);
-			break;
-		case 1:
-			ret = smu_v11_0_set_pptable_v2_1(smu, &table, &size,
-							 smu->smu_table.boot_values.pp_table_id);
-			break;
-		default:
-			ret = -EINVAL;
-			break;
+	if (!amdgpu_sriov_vf(adev)) {
+		hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
+		version_major = le16_to_cpu(hdr->header.header_version_major);
+		version_minor = le16_to_cpu(hdr->header.header_version_minor);
+		if ((version_major == 2 && smu->smu_table.boot_values.pp_table_id > 0) ||
+			adev->asic_type == CHIP_NAVY_FLOUNDER) {
+			dev_info(adev->dev, "use driver provided pptable %d\n", smu->smu_table.boot_values.pp_table_id);
+			switch (version_minor) {
+			case 0:
+				ret = smu_v11_0_set_pptable_v2_0(smu, &table, &size);
+				break;
+			case 1:
+				ret = smu_v11_0_set_pptable_v2_1(smu, &table, &size,
+								smu->smu_table.boot_values.pp_table_id);
+				break;
+			default:
+				ret = -EINVAL;
+				break;
+			}
+			if (ret)
+				return ret;
+			goto out;
 		}
-		if (ret)
-			return ret;
+	}
 
-	} else {
-		dev_info(adev->dev, "use vbios provided pptable\n");
-		index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
-						    powerplayinfo);
+	dev_info(adev->dev, "use vbios provided pptable\n");
+	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
+						powerplayinfo);
 
-		ret = amdgpu_atombios_get_data_table(adev, index, &atom_table_size, &frev, &crev,
-					      (uint8_t **)&table);
-		if (ret)
-			return ret;
-		size = atom_table_size;
-	}
+	ret = amdgpu_atombios_get_data_table(adev, index, &atom_table_size, &frev, &crev,
+						(uint8_t **)&table);
+	if (ret)
+		return ret;
+	size = atom_table_size;
 
+out:
 	if (!smu->smu_table.power_play_table)
 		smu->smu_table.power_play_table = table;
 	if (!smu->smu_table.power_play_table_size)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
