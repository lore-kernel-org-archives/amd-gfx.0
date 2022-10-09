Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C08C433F5
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Oct 2022 06:40:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D33FE10E11D;
	Sun,  9 Oct 2022 06:40:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E96CF10E11D
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Oct 2022 06:40:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2adP59qvLNTQYlN8dIFXJ5cZvNBkoRGPtXHUGURuG+C/sKpDM2a7vpglcHrqplQubTdIpC4ECwUbSJ3cjcaLjd5A3yKHx+iehW9tzvydyyu2hiQjtsQRdBNwGCkVyFTTAGML2v48TrCu9k0b5XbyOsfRiRn3mLYXFR1xrqVj2Xpi6+iqkKvVsF+8na/f0YGBFEtVSFxTQQ8Gn4ogjiNNGEJn2y1HDzPkF6IfWr5FSdLZlbfhDNqLSgMwDSaC50FvwhmrFR7b86WSSFhtryTIrRBfZk9WztznPWxAINZFOqKLyAiaV80cUPLPE48lbsI72RmNOgGtIOlFO7xOBDtDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbDJt6wk4zClr5lWkIL2KtPGwpI8TXrmzXNGxZt0yQo=;
 b=k+yhZZqgMfryzZCpyNI3PMNtJgwTUYFvuqDlr3awt/JUFis1JBf5lJbIb4L1Il7f4MB0y+Iav1kw7APBLBAmVnpA9yzkPXLS19pKxZZ4MyEfcxDPMrps/V8NdE3TEDJzuA79l8sM/EIrsh4mM7OVczqQGrQxOTZPa1mZ+uMqYZgW872iRA9EZhSNVV1Buef49mNNG9TxChAuyLA77tWpCJQ2yw5P2zPVZD5pTpUrG49S1tA7Bgj00DsPoxSRPTuhXK1H7Q2xwbsOM14zDR7c4qBQTl56nTGvlL6eNSdJWg+tOh5yztOJuCIzPki/2G8Cmyy+WkQq3xF+pBRdCWFOiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbDJt6wk4zClr5lWkIL2KtPGwpI8TXrmzXNGxZt0yQo=;
 b=bb7lGfownLOTIOdD5TYLA7UUlLfZJW09LAuKWInu3YuK+1w2JvSTFHGj6yMfvPIImb7kjaMnR7+EFUIwg9Uk+n8NezSy5ImIZmOzu323xkMy3aEUVp+hkSAYMZ5KqQvAigckJFUZJd/wMkvjec05ObbyqihtMY5Mn5iEhmbogLQ=
Received: from BN9PR03CA0517.namprd03.prod.outlook.com (2603:10b6:408:131::12)
 by MW3PR12MB4395.namprd12.prod.outlook.com (2603:10b6:303:5c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Sun, 9 Oct
 2022 06:40:08 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::4c) by BN9PR03CA0517.outlook.office365.com
 (2603:10b6:408:131::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Sun, 9 Oct 2022 06:40:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Sun, 9 Oct 2022 06:40:07 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 9 Oct
 2022 01:40:06 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: add tmz support for GC 11.0.1
Date: Sun, 9 Oct 2022 14:39:51 +0800
Message-ID: <20221009063952.3156418-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT058:EE_|MW3PR12MB4395:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dcfc32f-d387-467d-b1bf-08daa9c11b61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xHpnbbVlhTTVVom32fGhF3Fw6LazQTBsLnSVYDgvbMmEOcB0RwBE19SGRm1HV403H+kGAQfcMy4fVwZmyWOKYTHhfuci0APUe8bFZ5QN9SPEwWt5K5e5VRV3W1ihgLGSUz25iwCdrvBpQ8Ps9JnC3ubg4nvImk8IfAxgaEzSLPnnqW9XYjRYRE0PYttmOMG5Y0UgK8zcl/ELJx3uaNXKSIcwd5wjjUXvXoANcicWYFZt/qjXAP8Bjvg9ZO1jdaBE2slBTt3+4bGVSWLArDiaVqEXbAo/9EgA36t/39ebuPECywU2NeumrjCX3jbvBtTRP48qHx1XuMDE5PJf491dG4GTblmYGSWg2Hov/LHZPsBzTlSvNIrfW0Ui9dLGez9BUxFD/ZtRlzHdC4U55d5/HHUw4TevQskNGb3SppbKZtB184Qkus8jab2K/YzviQNVTm8gzWAqGUJTWEQbIdULk9KkfbV6S9wPNnqshLbgL/Jn216q14d7p2997LVgJoeWFrNcNdTcWaZ6e2mbFnohW6aqRY6xoGpJWBCP4ib/vhAafCkWYFFkSdCw2gXWFxX25YNYuijIACgwBARshhLhOhyH8Tfo68GaOJ9eFWHyr1b6Qimp39+rRPW+tf1DQYpJb2UwfFp608vrZ+INp+VVo6s8uNpo8X9K7p9D2oGE3aRMxu9y/4PEkU+cnoG5sEAPf8uZ0fFicHtJrAFDARQDJeMRnZ2jo6/xYs9LBHNqp7DJ1WC+Sfl/BfYq2tAA/jo62KW3VXjPB2A/aZYewwj2oDhSg2pAA7qWsfSWbwK0ivM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(36840700001)(40470700004)(46966006)(36756003)(4326008)(478600001)(70206006)(70586007)(40460700003)(8676002)(8936002)(41300700001)(316002)(6916009)(54906003)(81166007)(86362001)(36860700001)(6666004)(356005)(82740400003)(5660300002)(7696005)(47076005)(26005)(82310400005)(4744005)(2616005)(40480700001)(186003)(2906002)(16526019)(336012)(426003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2022 06:40:07.9203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dcfc32f-d387-467d-b1bf-08daa9c11b61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4395
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Xiaojian.Du@amd.com,
 Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

this patch to add tmz support for GC 11.0.1.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 34233a74248c..9c0d9baab4e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -542,6 +542,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 1):
 	/* YELLOW_CARP*/
 	case IP_VERSION(10, 3, 3):
+	case IP_VERSION(11, 0, 1):
 		/* Don't enable it by default yet.
 		 */
 		if (amdgpu_tmz < 1) {
-- 
2.37.3

