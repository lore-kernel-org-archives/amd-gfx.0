Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1DCC4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 03:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 105DF60EFE
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 03:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 105DF60EFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A9D16E108;
	Wed, 25 Aug 2021 03:58:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (unknown
 [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9670D6E108
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 03:58:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLhROAwOkG+osWRrhpYWBwfSR+VYvGHxicbLdK5QHpDgfzESB3F1IlpFrbXESwsZEk6Q4FeY0hK+Svak+MpMjVidBlCO+1fk0CyD8k82FRudYBafcEgxU5SHuU2O5YsHlERW/ysfIXMxt25ywUzwkCwxmO7kUqqL1w9SUzNmvgMHh9odQtTXFBnzsIthnIDnMH5OGNb3h/yQhKtDc5ZI7dDiiYrSKvjToW/bKpVQjjXkiVXMK1Tkfj9dW8ds0hi5EVenieZHRlUrt634H4+1un4FSbQXphNMvRfHpSgWOMqsmmasy9izKeYCa/OpOnwX1CKP2pvAD0NB0Ub9W7M0KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFJx2gaEUQO+V6HhkaQpqhVQPjyLowB5YAvrZuObv5I=;
 b=KKp7Ghpx1Hn0n0vIspevUbSTcIQzAPLT4FT+bB6papF7cM7AwztuQGNUgXuQ0kudsX15V5dofC6+hIxDF2Y2SuCfLrmtw0du4Hz/f8sLrxV5jGTkpSN3bLibZwMKrJRAFx9P9KEH7APZDCCQhoIWd69o2/rOfHKGvI8Kbu4nJ0sijImiZABoz6KVe+gdgfBprW6+a/TR5r9Pg9b29ImuUMKzm3jrdwsdo/IOuX4hf4QdTNFqVVSETg88aw/dvEOY85VN2JISc0AzuyyXrSghaEgtO8Tz5LQOLJW6U1lW57XTruH//6ChmjHiHnLogaorUgvMTmnIowYlLRVm0Rp4gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFJx2gaEUQO+V6HhkaQpqhVQPjyLowB5YAvrZuObv5I=;
 b=WqYYaraH3KC2eOmSLKrS/dGQoA0jQ4/naVJCkfjstxtILf1ZouF5N0L+EMRJkcP/5ItbcturzLow7bb/uTctLO66cU70cj+AG898kHvyYIJf9a9uRljuLyrloUoSe2ilynYNnkSc6rpb5ocAEBoOAh/da4uVUR3RQSiV4QBZ94s=
Received: from BN6PR11CA0056.namprd11.prod.outlook.com (2603:10b6:404:f7::18)
 by BN7PR12MB2836.namprd12.prod.outlook.com (2603:10b6:408:32::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Wed, 25 Aug
 2021 03:58:37 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f7:cafe::50) by BN6PR11CA0056.outlook.office365.com
 (2603:10b6:404:f7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Wed, 25 Aug 2021 03:58:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Wed, 25 Aug 2021 03:58:36 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 22:58:34 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Guchun.Chen@amd.com>, Evan Quan
 <evan.quan@amd.com>
Subject: [PATCH] drm/amdgpu: reenable BACO support for 699F:C7 polaris12 SKU
Date: Wed, 25 Aug 2021 11:58:14 +0800
Message-ID: <20210825035814.1284833-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fc11f06-19a9-4175-bc91-08d9677c9da0
X-MS-TrafficTypeDiagnostic: BN7PR12MB2836:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2836A3D7F801F0671F3D9C0DE4C69@BN7PR12MB2836.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 95jSq/gxQkIctRVI3UqMBaozv6UuwrnCqk/gj/yYyxBQabLAYiZVim1IbflQCZKsp0tt1w/mcuJ6TJbaGQzaG8TY37/LNBkDBD9IFmP6zitqUTfwsvfdpgmhtFCadVZLVQbltBBKDaetVsk9V6haVmZCfHv6+2ftu7r5DLTT2GBo3Ayh3fuunN6Nz+7/hUIsVjasKc3E5nRRWxGkQvs/redhu61Vews7fmF3v57Bh1mKDnccxc4hvBXY6kgyfSZIQQOpAHOomWIFgahmPK/mB52cLGnZlG8yqIvr/v4f+6Zp4IZMLKhTEyViKuvBzqhEvI/22fkmAahV0DeytZakYKs7EYWxPUxaUZ7E2qz3rzluCZPEA656yaiWzTjq8XcDxEYN+otjVJ5rxnejIyMsxx2cDpWOBe1uUqs+zcNA1mnVL0H/VfjzBx41W5ph7HUYTAGiC2YQius4q0NOQ7DEFepoXM/dfPLnUnDaOPBqgtvAQ2ZTsGDqb71CXY56YBL+nycWOkMT097ocH8fs5EtfkdG0/Tt1eSmHICvjIfX8mFa7kOlz1ZmTwcB0xOzXWdi4UQXx/9XeDb0s5v2dCvlcoAWozmUUQ1SYj4ridkUrhqBz3DnBvw4i4bvXKE/6iW123jJhPAuUtFREb0RDkW/im4oW24L93ZJGDULm2lTF1qx+P+DIZsrYfbcF9164fWocmivyDOmBKCxIYnY3mgcKFMsMKndwOOK6s4a21f174c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(46966006)(36840700001)(4326008)(36860700001)(86362001)(7696005)(81166007)(6666004)(1076003)(6916009)(2906002)(82740400003)(36756003)(336012)(356005)(44832011)(2616005)(8936002)(316002)(54906003)(83380400001)(26005)(5660300002)(16526019)(186003)(426003)(478600001)(70586007)(8676002)(47076005)(82310400003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 03:58:36.7368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc11f06-19a9-4175-bc91-08d9677c9da0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2836
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts the commit below:
"drm/amdgpu: disable BACO support for 699F:C7 polaris12 SKU temporarily".
As the S3 hang issue has been fixed by another commit:
"drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE on suspend".

Change-Id: I5ea08a75eedd7fe32c7fa0b448f5bae1f390abe6
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vi.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 42a35d9520f9..fe9a7cc8d9eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -904,14 +904,7 @@ static bool vi_asic_supports_baco(struct amdgpu_device *adev)
 	case CHIP_POLARIS11:
 	case CHIP_POLARIS12:
 	case CHIP_TOPAZ:
-		/* Disable BACO support for the specific polaris12 SKU temporarily */
-		if ((adev->pdev->device == 0x699F) &&
-		     (adev->pdev->revision == 0xC7) &&
-		     (adev->pdev->subsystem_vendor == 0x1028) &&
-		     (adev->pdev->subsystem_device == 0x0039))
-			return false;
-		else
-			return amdgpu_dpm_is_baco_supported(adev);
+		return amdgpu_dpm_is_baco_supported(adev);
 	default:
 		return false;
 	}
-- 
2.29.0

