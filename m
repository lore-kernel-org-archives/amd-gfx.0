Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63230C4321E
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Dec 2021 16:01:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D48410E857;
	Wed, 15 Dec 2021 15:50:37 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2066.outbound.protection.outlook.com [40.107.102.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 849BF10E857
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Dec 2021 15:50:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOaicWS6Hlkh70DVWUSH4fJLqh+JWlFcW4K+BW0II4MJCF8+xNpZq+wzdxKD53MeDL+IkYM4fzGMtvHj3D0/RQ2wJzC/uAm1kEiaLRN/eduXNBDMEY7Drw2QyMygFsud7G1moMFJb2ePuga0jLqgSj2snuVV2x1VvVgbkrUg2hyTFSqEh4qRfttQ5zoKOII6v/pQUYhwghphJA6lMxKc7xXcf2BKqGyXDvNnhb5+dMB7PDMqtPQUf5qsC9PA0AmtxpRrXp/c1QuK1aTYqKS0zPCIARYZQM8r4Wxpp49Bgs1oIjLQUkLFm/qjMjxWFwEqO5qGHtI+x+YoYp1y+/F+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1EEGhH1n/C0ModqULHE3E57FyjvBwCpFu0uSr7r/xc=;
 b=eUIPQfy2J28pY+eIzcmEsIx2XSwPM5/S00Kv8ZhkARsVi0ciGSa5UrrWq/7LGHdgng4QUas2LvZ1Q6iNV+spaR0Ie+/py0NSwAfNvteFhSVjNIggZ465Mpou8Xch6frBswEyf8HFiDVAev+uB2Cq6OHXuXS6rVGmk2GTGweZ79nv8Qu1JXmQ1SWlH2sQFjCd1CmGBUErYOrm5Bkcogh7Cec0wz35VCSRvUvHBdtC0PTftXm/wfXj7lT0cD7rh5SpJ2ksb3yDLSMFC5BmE+LH3bbVaF6/sQWCBMIMlk5v4tRQdItQYnmzT04y+8j82n+Krc31e6TM9+9DGxVW6vyN4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1EEGhH1n/C0ModqULHE3E57FyjvBwCpFu0uSr7r/xc=;
 b=JVABxw1SxaIqVXMiCrHiOnLYksZO0pCqEsMwwzxx4V2bAiY2uUVf3CPBcUV0cuTDB4/AvphTKkjZeriZeu/b+qiD99usvrEc7KDkqWECP3e/1MYzpso6YIAm9BsldRyEl6X71iMBnNVYVfAiN2bmmdRcIKYQxqmeVWZAV+XC16A=
Received: from BN0PR03CA0030.namprd03.prod.outlook.com (2603:10b6:408:e6::35)
 by BN6PR12MB1938.namprd12.prod.outlook.com (2603:10b6:404:fe::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Wed, 15 Dec
 2021 15:50:34 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::6c) by BN0PR03CA0030.outlook.office365.com
 (2603:10b6:408:e6::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17 via Frontend
 Transport; Wed, 15 Dec 2021 15:50:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Wed, 15 Dec 2021 15:50:34 +0000
Received: from lijo-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 15 Dec
 2021 09:50:31 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Fix xgmi link control on aldebaran
Date: Wed, 15 Dec 2021 23:50:15 +0800
Message-ID: <20211215155015.615018-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fb07a37-5b7e-4097-21ed-08d9bfe2a1d5
X-MS-TrafficTypeDiagnostic: BN6PR12MB1938:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB193813A07A369BBF2E82402C97769@BN6PR12MB1938.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pxqMnzbDbOeQSKhNF9Zx6K5yMRj9lSn9OM6ujBIJdeb+0MoGRSCTt28gGWy0qnNAy1crei69fvlHacqAnQ3RfOdpvsY5WSVs6tzmaugGaO/KeYy5xckOhwMmjPeFBHzWMvL4G94QHO3h6ZaenwJMc8GDHim1BdQNFbPxlARM77knpVdtkce5C2lXRCRxWYBsIf+cffnZO4gFi2M+cSNL7VpRM6BNSIxwG88zTNkMO9kbGrMiWVRqemrcjsqTIelNNidelxIgRyb/qzAQQHa8nmSLKY8kiuJzQxcb4GWqNULeh8DoKBMwF0n7oBQONJ8df3yiU3hrnzYXtxNWekcnX7/h8wzIXtGKcWj9zsjMVpV0Af8cxpASUiNoO9YWFAt3EmILt7KPFBHRCzd3ePhlN4dAs4qzy8tu3F5QTDNCYrwXU3QR32tjB0/cVMQV+QSKriBCJRXp+RnTiL1smcmAa4eY1zoxW1rHE3R+xp00PhCPtyI6ytpA56WnUFmwZ1M1AMh/qIoTN55WlJ9PCXfRR8HjD7k1fAO4nAJkMx9GIIhJy3FlyWcC+Ef7/uK5J2u2rxo2vBO64I9wLe4UHD3oTXLkqFl8phAVwbkkvUQKaAG0cKwmIBjD/pB7bXOnE45gNPtF5iE5aeUMKm05nMGB2egcT88PEVZY4saTRkZOmeHVxxHn1oJBxljxdOSWixBYQtz+uO0nr5VLsDAzk64QE8bqG3FGgCOAKNLgkt74xZTEmwooAwXdczWUlSiXJUFXuR4h4RFMpExwgRbTgtgSGMQcD+es8wwJQJgWn99QMDM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(83380400001)(36756003)(70586007)(7696005)(2906002)(6916009)(40460700001)(316002)(70206006)(44832011)(6666004)(508600001)(1076003)(54906003)(356005)(86362001)(26005)(186003)(82310400004)(336012)(4744005)(426003)(4326008)(36860700001)(5660300002)(8676002)(8936002)(81166007)(2616005)(16526019)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 15:50:34.7780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb07a37-5b7e-4097-21ed-08d9bfe2a1d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1938
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
Cc: Alexander.Deucher@amd.com, Stanley.Yang@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the message argument.
	0: Allow power down
	1: Disallow power down

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 0907da022197..7433a051e795 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1625,7 +1625,7 @@ static int aldebaran_allow_xgmi_power_down(struct smu_context *smu, bool en)
 {
 	return smu_cmn_send_smc_msg_with_param(smu,
 					       SMU_MSG_GmiPwrDnControl,
-					       en ? 1 : 0,
+					       en ? 0 : 1,
 					       NULL);
 }
 
-- 
2.25.1

