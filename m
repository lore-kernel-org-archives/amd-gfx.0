Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506D2C4363D
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 07:09:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E1E423A1E
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 07:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vFn+XZJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1E423A1E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5BCA6E0B7;
	Tue, 22 Sep 2020 07:09:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BADE6E0B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 07:09:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ceUBWrjBmbEcp0S1qaowdCR1qfYHhuO0pLRgdti8nWIHo1sd8OHsSkNj0TshR0GQAuwRSEOAZITlLRRf68Jc1SIWi1nzlShVKovA95TI8o8u1ZJ/Lnwy1D84oJ1oSdZquDg9TxQ0EVp0Zl66N2QKQcJ+e50XbFyT0CeNf4x5cCX7Vbbqwl+prnMOVI4EcqKTPmoBnllX1Txf5ldby1alalpqMoEJn0I3tfJl0b9drtyMUv+nRVfg0cLh0Id4ut3D5iGmCpP4V/GZv1cXaPEyLwnMRjPypPmce6/h5JGGVQ/vmDA/xJ26oIA9FyGnOGJC0T1uQyYjFcRBpINjvlo8/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGK4X5lgk5jaQavvPqDpieZgt9arSOjd+frR/bfXo8U=;
 b=TD/RTPI0+LMNE2e+njHIBuFe8jpwa977Z1iOpoHDGBusH1KMNphVbSjsarDMXwO+5VemeeesyRWZqyijS7RvLDZuX0x5CSWGD0GmsxKwFFpM5YZ3zxCiVCXbZKt8XVZN/hMcpYUBDzwJh9dQgrt3XRdehpl3s4N02G6db7bpbiVhlDS2Xv1Qx7nNJbpAlk6FZjjHAu98q8KOcE3dmjhArVuNEDeM2Pj1W+mLz5cxOloqQJFnVbbz3ayNR6lpHwqfBfUVBBfgShWsR8s7PaK4joQmdAnUjV7aNYUqOIUXrW2a+bsVw+nleg+yAncA90Jb9peof8bMnoNJoksvAtkeeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGK4X5lgk5jaQavvPqDpieZgt9arSOjd+frR/bfXo8U=;
 b=vFn+XZJPh3jpYRo4Xv/paJ0he1CAjWV7hFuObePddKYyoLjFnt5BbpNapJaQe464oOMsxKpB7455V3pIvVFxQmqseYES+R8Nqz3gGkXJTmhOySq34j24DW1blmOGTONtOWK7YZXErlRgoKA/1Pp7tGdZqzQb9zjYpkSTwMywQjE=
Received: from BN6PR03CA0009.namprd03.prod.outlook.com (2603:10b6:404:23::19)
 by MN2PR12MB4830.namprd12.prod.outlook.com (2603:10b6:208:1bc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Tue, 22 Sep
 2020 07:09:16 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:23:cafe::36) by BN6PR03CA0009.outlook.office365.com
 (2603:10b6:404:23::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Tue, 22 Sep 2020 07:09:15 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3391.15 via Frontend Transport; Tue, 22 Sep 2020 07:09:15 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 22 Sep
 2020 02:09:15 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 22 Sep
 2020 02:09:15 -0500
Received: from wayne-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Tue, 22 Sep 2020 02:09:13 -0500
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: Skip use smc fw data in SRIOV
Date: Tue, 22 Sep 2020 15:08:43 +0800
Message-ID: <20200922070842.366545-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07d9990a-fce4-4792-cb5b-08d85ec66aa1
X-MS-TrafficTypeDiagnostic: MN2PR12MB4830:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4830682B0777FCD102DB29B8B73B0@MN2PR12MB4830.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a+KDLDqZK4OkYURBeuG0Oy2WWi20UAtaKGXkdAqjVCCd6RbPob0T1/TXAxT8NdUKIxI7Tnsd1uAvAjJf6CztVIkMWzULQ8LEulSPxBB8aSVVfAPOEcg15IIbAszqvfHCJTn+vxinPR59hKRlZt3FvZJqSlSoEESS55/RnTSdvXhOOATFlWViaa/dk89Io6gN/zbpTAtjeWWNMpWXYNj4yeiPbcDNo6x2OyGMEYWGEq/i2eKOG34oAUTCFMn/KCc4Z4yjrmfw9ARQUUoFpHn5Nxtnf+X1kofSvgITUha1RL7mvtieEA3VUdc9KoL3l8Bx7uRKO8Dl497ENRlCqA8JgdS+KkBt+/0fIX/ZgoIgB+fuC2hUP/eg4IG2t5oZTVy7L7TkC1Jy3UXRTRIHnRjVRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(46966005)(70206006)(36756003)(356005)(8936002)(316002)(81166007)(8676002)(6916009)(478600001)(82310400003)(86362001)(1076003)(47076004)(83380400001)(7696005)(82740400003)(426003)(186003)(6666004)(5660300002)(2906002)(336012)(2616005)(70586007)(4326008)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 07:09:15.8029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d9990a-fce4-4792-cb5b-08d85ec66aa1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4830
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
