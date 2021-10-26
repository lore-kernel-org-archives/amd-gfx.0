Return-Path: <SRS0=fVrT=PO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CE0C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 09:27:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F14B660724
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 09:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F14B660724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 671A96E47A;
	Tue, 26 Oct 2021 09:27:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA0956E47A
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Oct 2021 09:27:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGUFIMkuw5XvQPAgvLUyQofF2lUB/5pCnLwd8B44bh4ju0W6uCT43+JfcvEahMyWMFZWzN/SZYc4WVYlqeYAU/XTC3YUxf69uiOT7CUmjx4nQaNeJ5x88nZ39E1tYWHmC3oAHlh9Tg1qQTh5wDprsFgyimjQ9+pry8LjmVLaHzn/eBRFFpZCZTUtxeC/vy8Wb1+32MqnZcfGwe71qMkp7deNIhKXdOALEWMlA5LHO2Vw23Ono4f2PBH80k1cqpAqwlh98ypAomdeylGnfPX+fi8LXF06/BtsZSe59MLTyAihOYkd/ptCG5BeJjfeuU6K9e6L4A6+7103zdW0NSCURg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXix7nQ7/xgblrkFov2Yz48PUJhFcKaC8ayLdcL4ggs=;
 b=XDJZhk0D8pNhlqc6ExKXrSxfP/FpPbeDjqD2YmpEnszOpJ/y9FpxFTGtSHBmMPiCVG1BNM7boIFEgep9qKrivhJbZf5sPDL1NaB7R77I8mWt0OzNzwthKkzeSZamqFEYvpy7br/2j8LwbfBrE9r61lEIWRexLkqzIbaL13rs9dZE4d/wFBxKWsTAFFDDfuCwYE3IQEpAGDi+Ks8sGyQK4NRkTAcvNTMHQ0IJnBxy7Cl4zAyAKtT7bAGAHsB9Oo9FUAoKpOKm5462Fh2aP51ZLc0a/PRgDEaZ/fqRLYAE2S38azUUs1IZu7JAYaJiabCcg3LmZ0QFlbAA4zL7I42hkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXix7nQ7/xgblrkFov2Yz48PUJhFcKaC8ayLdcL4ggs=;
 b=OM/sCGc7gPQkTbq2+Hgtu/7IJ2lCdUC3ZVi59hSYrccsZa6mz41M1qmlqah0HtrT6MCFBa6zjuz1wePVJkJ+6wKjOTEcFEtXFg65O6R5IF5VbzFVz3nJa1fwFRVFbr3o+ZK5bisoYoYsWj9JxlqWC4GuJEAMUlzEMzunIjjEkdM=
Received: from BN9PR03CA0421.namprd03.prod.outlook.com (2603:10b6:408:113::6)
 by MN2PR12MB4000.namprd12.prod.outlook.com (2603:10b6:208:16b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 09:27:09 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::20) by BN9PR03CA0421.outlook.office365.com
 (2603:10b6:408:113::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Tue, 26 Oct 2021 09:27:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 09:27:09 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 26 Oct
 2021 04:27:08 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: remove GPRs init for ALDEBARAN
Date: Tue, 26 Oct 2021 17:26:58 +0800
Message-ID: <20211026092658.16891-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f80b6ff-a5d1-4926-4845-08d99862c8f5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4000:
X-Microsoft-Antispam-PRVS: <MN2PR12MB400035D71B22F218D0D2E1AAB0849@MN2PR12MB4000.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3dH+aT/7W/HZZvae2ciTloySVzR3YCmNZSFRx6HY56SjCam8F7es0+Vf5p4GusZTPgeTE/znEt6ZLeVo83HytIuy+uBOP1THvKguCEQ5S5qn/YDXGruF2e7eHeBP5sryQ/s80QBKE0plzyKPfkl542AXA18kiMs1KTpe8XwXEv1aErjg+Lkke6jdpHvd8QXS0ZiF4Gwpzk6zZelab1XoNV4MDrns0Bw33XaFEwETgAVtiORxh1+Wr4q1gqg1IEdQimepuOycykbfUgUjSCEHgyUFhTciJmzq9D6aWlTnTkqorRtk/OXVBtLBGNbdt+hlUqQTb6ejH8+Z8ZNIaocyCwfxUWsG5lyMZtTPkcuj5OiL9rKNnCwChb61t50X+WpDuGq/pG0/+e4J6lg6Qx31+JfaDu6I5aaZdt1LTjvIq3N5bqY3ygD+UAK3YRFtLd1AEyetZn5Tla879JtkPBdyQTtZmLvTUxJJaRUGAIW0oW5t4w6RGZ8uKa+HnIhOpIX0QXveWwKfckgD0sfIfww9l6f5+mYTbVYFfiwOGsh+aLR/ARDcB1GVXRZEG9nf8JEzG2ZLwvg/klT+UIL9TWjQ3LaL1qVQ9ZzeCJx1FIGwuct4CDS2BIdC0ZRv2lLXUclTVcOgw1YG4nakss2QkbZaGm0TxsJGr/K8tc7dtzChlyFyik9LA5jRZ9Y0o65wD5yakazneW8j/zyzPiSwB1m8pqOHoswaYl8ln+tYNAGZ7v4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(47076005)(508600001)(316002)(81166007)(7696005)(1076003)(70206006)(4326008)(6666004)(70586007)(6636002)(356005)(110136005)(26005)(8936002)(86362001)(36860700001)(2906002)(4744005)(82310400003)(426003)(16526019)(186003)(36756003)(83380400001)(336012)(2616005)(5660300002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 09:27:09.4951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f80b6ff-a5d1-4926-4845-08d99862c8f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4000
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

Remove GPRs init for ALDEBARAN temporarily, will add the init once the
algorithm is stable.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 24852a24cc58..c85bad4f1394 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -706,10 +706,9 @@ int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
 		return 0;
 
-	/* Workaround for some CU settings, skip GPRs init.
-	   Will remove it once GPRs init algorithm works for all CU settings */
-	if (adev->gfx.cu_info.bitmap[1][1] == 0x3f7f)
-		return 0;
+	/* Workaround for ALDEBARAN, skip GPRs init.
+	   Will remove it once GPRs init algorithm works for all CU settings. */
+	return 0;
 
 	gfx_v9_4_2_do_sgprs_init(adev);
 
-- 
2.17.1

