Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5E2C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 10:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36BF273E95;
	Mon,  6 Dec 2021 10:21:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 469366EA76
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Dec 2021 10:01:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejl3Vl4i7v5PSCJfd57846cvJZ5mcsv4RpSSxVMrhg1ZBcGeRJeQry0ybgNqEv9eBWec/1LbwXFoQbDwCvd8eHpi2Dg+uVhIDx+LcVj1mdAQVDPhzvQhnshkTYMII9xD7bwSTohYFtq51xgX75ZSmayjQ0KBQ/792u7QiQLA2yMjsLo0F1Y5lYTjGhR/GlyF/agI5uv/j7/+2/o1kNJ4LUf8t0+1gX/Nf1D0eVn3s8GgT6Tc3hemz7z+0Pt4M76prjDy25Aq1014D4K9i01LBrAnve/oEZ4bSfyIRju9QS9PKSB+ewCu7FjvLPE5+Nm432zhY4r8g4tmBLu4UJpYdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svS4eoUR+xSVKTuUPLJZswB4um8LpRm8UcyU6jBnMkE=;
 b=eSZT6GifEFDjwCpltXmP/1Elt752scndUCjpyKR9U+XEkAL+QJrwgHrEb5U6GTnY4beMpaZltEMa15yKDdhe7a2KOHe+r6RE1+0y/Zoi8ytAa8zn+mnAAq9whasllurbXCwqhH4X6ehswLi+JYsXOg2YdZeXZifUNkIPMe9UkZbhtHefdaZLdNmuUCRLyLFJ6M6DFHM83tLJCYrjvBJRpyZDQjZhwo9Ad5a1WLW+GajPjh2eM9Ex/7Mtp8zEJnTIahNHJNoiGtsCivmfmaCtOWZ3f370Mc6Zab26nwdhnR/ym5mFpcmeoO3hHXiamz6nRl+x9V2npbOP2J2UzzhhXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svS4eoUR+xSVKTuUPLJZswB4um8LpRm8UcyU6jBnMkE=;
 b=k6VfbxRuaY9WOKhfmBH49uliHYFU4uDkcQ2nqh4V5vyJ7UqB2phenq+6c+Mmy2b0eomZ+OJL9PLOiecIRN3tBuLCuOSklTbyNaZUzbJ38crlJ+MupYqEQUQNAPEZ35iKmzSwrQ7zk2HmORn2AlGHi52ldVUs6tpHNX4BJMiVlMc=
Received: from DS7PR03CA0055.namprd03.prod.outlook.com (2603:10b6:5:3b5::30)
 by BN7PR12MB2804.namprd12.prod.outlook.com (2603:10b6:408:2f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Sun, 5 Dec
 2021 10:01:47 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::66) by DS7PR03CA0055.outlook.office365.com
 (2603:10b6:5:3b5::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Sun, 5 Dec 2021 10:01:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Sun, 5 Dec 2021 10:01:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 5 Dec
 2021 04:01:46 -0600
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Sun, 5 Dec 2021 04:01:44 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <John.Clements@amd.com>, <tao.zhou1@amd.com>, <candice.li@amd.com>,
 <yipeng.chai@amd.com>, <evan.quan@amd.com>
Subject: [PATCH Review 1/1] drm/amd/pm: print errorno if get ecc info failed
Date: Sun, 5 Dec 2021 18:01:43 +0800
Message-ID: <20211205100143.26904-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67632bd9-bd14-4ca4-e8c2-08d9b7d64028
X-MS-TrafficTypeDiagnostic: BN7PR12MB2804:
X-Microsoft-Antispam-PRVS: <BN7PR12MB28045056EEA869A03552E0729A6C9@BN7PR12MB2804.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: obUELPmMT5oak0k8Q8cTZC7lDMYUMLTFPDkChsbkEu6e8gEvsFMrdJdruPARgmEuSOcik8CLHJKPXbVoIhdDrSIrXMAb86kArNiqjlx2yzdCbvovOSXm+BNKyRAP4gPUYO8tKpT16HucOopA34dxOXQ5ZXjHGTt5GK1gEa/43iFlxQdL7tD4gyD+l0UQWrC11ipcYyH2W/a8fzR67zcMlyK8Z7gfKqZK4MD5En4N27SXmNuLrxbGxWGGrCIZvry63PJpgaye2P9zJWvOEgeAAeOEuPNiSGt7fOCF1dso4gb8y8W3FTCJnjkT6oz6191OGI6IGi7OqSVqU/knz42Lb5bS8Cd4UVonrz6tWLIWj6VECJvj9Ljs/rYVsepGSHhNj1n61cHc9aczuoWBUHs75B56LpV0qtd3r+I38Cio3BMivtaDt4JtpPrzR0Vr+YV3Dwu38FJ8uisuFkL4yBt7mzgTXQh4VuqxORC7HYeMyRyXoCgESeS/f8NEIix0saciJOcCmZIgKtjbmxlFbD2ZDur+aKekEVdU2kNgClV56jXbFPaF6h5PxI5x5V2tBv5gQBrAJBU5IVJfGYKsAXFF4nTe9r9CaGJxq0N8zjWBCF2h5pUpuN/b6ER0fyftRbW+cjIOLv5/wyMiMJqwmNVSk1PwOigPm2oZXoqus6T1V+otgfpBj93uYtTPonMfFNnRATD9/QaPsMM6OAwogNiVyhE8cFwnKFCkc6bxwTKXJdV6OvsSx0ZJh1v1MoHUGUBNeWfSF8aTlQ6s/P1TCSeld92QboyOu1iiqLkUKQnkQEE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(47076005)(81166007)(82310400004)(8676002)(2616005)(110136005)(36860700001)(186003)(40460700001)(4326008)(8936002)(26005)(316002)(36756003)(508600001)(2906002)(426003)(70206006)(83380400001)(336012)(4744005)(5660300002)(70586007)(7696005)(356005)(6636002)(1076003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2021 10:01:47.6161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67632bd9-bd14-4ca4-e8c2-08d9b7d64028
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2804
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 6e781cee8bb6..e0a8224e466f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1815,7 +1815,7 @@ static ssize_t aldebaran_get_ecc_info(struct smu_context *smu,
 			       smu_table->ecc_table,
 			       false);
 	if (ret) {
-		dev_info(smu->adev->dev, "Failed to export SMU ecc table!\n");
+		dev_info(smu->adev->dev, "Failed to export SMU ecc table! ret %d.\n", ret);
 		return ret;
 	}
 
-- 
2.17.1

