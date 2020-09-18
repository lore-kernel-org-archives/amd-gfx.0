Return-Path: <SRS0=nko/=C3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFC8C43465
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 05:56:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0313F2076B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 05:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3rPiBXTb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0313F2076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 929FE6E10B;
	Fri, 18 Sep 2020 05:56:34 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94C966E0FF
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2020 05:56:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/G0po69+9P9GOi2IZjVpC1ZBFRrL88sW012FlUqcbdqaTtSIR+C+oG0SYI8uDa5i4uQyo8Sv43Ht8x0QwQLmGLjcsPJMleaj/I+TDJ0K94DCSNuo0/aA+Bg4AmddF+wPpw3nkcGjVqNrjJKMRZFv9LmiFfPWc/sYOWx9x4mPWiFk0+a77hygA1A9CSnykcWfNrYGOpkmFyX5GtFjJH5otYAGdbGBCpR9pVIFXDt7xpKHWLc+zhrbFNKDBxbytKd+qVEYy2NO1LN9ryYtWQsnvz+VSAgScZ5on4Xv0uHQuxDg+Hku7+WlDb0s29C2gB1vSapr/qFmJKaBmDkkpJEbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGK4X5lgk5jaQavvPqDpieZgt9arSOjd+frR/bfXo8U=;
 b=XYEDgwohWAa3MlZCwKpM/A6cqMI5AiGcp5ItDQmbfOkZ+63xL+10eeIlnkH/HMEKm8HUW/gIHjAD65S/QCW83+fJVBK1/f/M0gIt+i83mHCgVQ+EuiGjMfOHva2Nqi5kNnEcpS/VXE09FC+l0tWPtj7yQfpeT3cpXt+bwakY9QgKJsildx5/ugYUvOrv2SkKNVWfzZcsfrrD3WPsxLACZoZSWb+n3RpGblriA2xtZiq8osrRX47pdZ3Bc3O8iux92NmZZbVCDFmVv0B9Gt5LLLv5FtxyNsGwJjjTIBWdgISq08mRY2JHOOS10YkFD1iZNqpeZbU1zfC7s+vkqmtMHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGK4X5lgk5jaQavvPqDpieZgt9arSOjd+frR/bfXo8U=;
 b=3rPiBXTb9InAsl/DU5ijBpWNhJDKEkjNEO+Jcw9OMORc8ETTWd54t9aqNsxQFjZ7hr27ihskAIwLEd7oddSeO45Ew1Vjy6EK/wuVmOk0/d0YTjSWvZFbtuvXpIxfwDG0cRERVcvnfLPDquhH2C3+hC1BLTDNRSg0ocJgaExNccg=
Received: from DM3PR12CA0071.namprd12.prod.outlook.com (2603:10b6:0:57::15) by
 DM6PR12MB2697.namprd12.prod.outlook.com (2603:10b6:5:49::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.15; Fri, 18 Sep 2020 05:56:28 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:57:cafe::7d) by DM3PR12CA0071.outlook.office365.com
 (2603:10b6:0:57::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend
 Transport; Fri, 18 Sep 2020 05:56:28 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3391.15 via Frontend Transport; Fri, 18 Sep 2020 05:56:28 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 18 Sep
 2020 00:56:27 -0500
Received: from wayne-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 18 Sep 2020 00:56:26 -0500
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: Skip use smc fw data in SRIOV
Date: Fri, 18 Sep 2020 13:55:40 +0800
Message-ID: <20200918055539.1682598-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01e67050-f74a-4904-5b4e-08d85b9795b0
X-MS-TrafficTypeDiagnostic: DM6PR12MB2697:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2697B49256CC44EA762312B6B73F0@DM6PR12MB2697.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SMt7GxokxL/qa8pNqMXbQLhTDjRfTWFXAaMGY4gaw/luLGSCvNRvtnYs8xxZEpKFXfM0Qiq1+4MwyvKcbplxljDh4jrvJ1D6PLWXKRD5uUOJwi8JJ0sPWDEv6+3zOI/8cjvU8V7MDfpCbEsb/Cp/DWC6LyUqcmbAszYJfvN45j/CioE3HDHPziBG81FRj7IzQI+57xeZ5PbG1/IF3BJc+1PcEaVw6r7pXGpv/g8vdPZrgZxcwel82uQFOt0TbFp3YL6Ha6AAwwv9Kxb4oTwkpmG3a20JXwPeQnhDG5pCn6EpmEvKLU4CWDL3cuXcK1auomaGam67kG6z+ivO/OQUex6xUhneoLUfbF/Sks9W2UH3OyCj+Ws/a7Y/rKAZOYQfjVHb5oRoaX03ORGLyyoMuMYuUheK6nRE6rbo41EKADRWdMcEWng+U2W4HEppY6yr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(46966005)(82310400003)(5660300002)(70586007)(47076004)(356005)(82740400003)(81166007)(4326008)(36756003)(7696005)(2616005)(2906002)(6916009)(70206006)(86362001)(8936002)(6666004)(1076003)(26005)(478600001)(8676002)(83380400001)(186003)(336012)(316002)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 05:56:28.1587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e67050-f74a-4904-5b4e-08d85b9795b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2697
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
