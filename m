Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75246C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 08:26:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 351646EA4E;
	Wed,  8 Dec 2021 08:26:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97AD96EBC4
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 08:26:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsPf7qtnDF98v+px2fvIseuRDSenwdnMsDx8TAVIvGEYgjPc+2d/jkNtJ9il9kxSkxt5rjmbafZMXNFuAsn0Q38CXvwjzSgeG1V1g8TXXOWmh2xNTayk6GYZ2vxF/b39lOLPmbQ4a+Bnz5H5klU7oD5+WKx2czDI6fyf/NtQUaInvJLOv/9aOcet7kll277JakdPwR6neiu27iqwokJ9leFyTSJlvyzZqjYuw9AJJPLH6LFt69TJEToQemrghBbnc9pfFExR1vNiFW0ok6/o7eWlR1VRqS5XRq86scXbm0DdcCbg4J7TLROnKu7aeZTaP8pyeA4J8vcneDB3RnZf2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1J7cDCzG06ONAp54+LC6DTfbkDh6nWDtXcvCeo6Tbk=;
 b=HN5oUFXMDFKvnLyWF057zgh/H13jOyMily76w4Kij6V2AzFUGdlOp4DmiGQlNhUAWyCIPdQXtUiAkifNLhshCbxVs1QNB1U0Pk5+XdLD9bmJ/hxg5xPAnqFWWPmFOD6TYYex9Qk4bFvQyd88AdZZv9vkCFq9XSx6G9iNU5/Ebzz7GLZ51N18j4r5kIfIkJN3qr3dXf+kPMy2UqlOwynLSA0hyBrggaVTaKS7NZwAEJK350Dmj2pdnpeaF9z+uI7YPuzQ5a3yVLkeuoqI2kP7SqNwZPToXTSAZ0w5wlUnWSVCa8URFwLa2kikQxwLi/Sw/nTB9q4+efc1f1tEHZLE0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1J7cDCzG06ONAp54+LC6DTfbkDh6nWDtXcvCeo6Tbk=;
 b=36btQbqHQOnMQhjTT9SfYyCPtE4BncEf7+CBjz66cMO4jAphkhV8ItbpAUddfBCmgTVEbAD8c0etP4o6MOZ7dZv+71n4gOeXMlFu17lKZewp5GBVKcIaCb3NCBPBKsiETPDGgE8co83CeXqwbZgRaOqpxi2+8VCPj7yPA1q008c=
Received: from BN9P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::33)
 by DM6PR12MB4763.namprd12.prod.outlook.com (2603:10b6:5:36::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 08:26:01 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::a5) by BN9P221CA0006.outlook.office365.com
 (2603:10b6:408:10a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend
 Transport; Wed, 8 Dec 2021 08:26:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 08:26:01 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 8 Dec
 2021 02:26:00 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdkfd: Make KFD support on Hawaii experimental
Date: Wed, 8 Dec 2021 03:25:31 -0500
Message-ID: <20211208082531.918062-2-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211208082531.918062-1-Felix.Kuehling@amd.com>
References: <20211208082531.918062-1-Felix.Kuehling@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b1ce0f7-bf42-4771-6888-08d9ba245e85
X-MS-TrafficTypeDiagnostic: DM6PR12MB4763:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB47632CC810EE80017A33E4A9926F9@DM6PR12MB4763.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4N+xEPQTb9NTSYQOiljyVmjayfdfYpvl8Jw/XEPQFwp/2mdxw1SVGDgNSV13/tL0BzcQvtosi+JKAMcMwBJbLk+8I8mSwP0V2F1L54r6rCeBjfjknxZI9tuv3rQWmM7NAYI67oUNaNfe+Os73GfozsfZUheR4CC2ZWtlAE+sWtGQ/1wXjYhs+7yx5WFTsJTyqwBFVrajgtj68jsToVwPJzklS706Cou2tIKPpubfmLAi13IyAoAVTSISKGZx20U7IF7+kPaBpaizswMeMkQornVOWd+mn1YKZ4s4mgqcPZlKCr0p0B1qrT6UI162+4q+C93uTYaOSqr76/OhDni79/nbCcesqdHJ3XIGTjYbIYgEGtHoAq7Buza7UNsC34DG6YH8mU1a+gNKI25Vkg2ikckiLppqZXL3n+ACLNLIe5QGkC6LIGZkBaCvXQEE5NEnGMZ+4aplLnV0qzUC9JvqNt7j3l2LM3aLh06Xk0rt2f+JqEyLKEIwbaweGcPpUaDR5sqalBc6Nb2ShlonTKzP3pJSddJ36CBCQ2X3tgOpiPr7T+mNRDkjxG/fneo1bph6UP0s8EHKNp+Zaeqrl6M4A5wW1GFqu9qdVhW9J2KPc7s1QguoUE7FEPvg/V0jojyka00vqnHH7It1id8HpUbXOukK/YZQBDnxiD3Lr+tCO9I9wqXX+mtHSFnOBMOHLk/gl62uWWe5dYqT0DfeiZ7rxnR1EY4mL4rGIocSoimyR1F5l9GwS/hUgusxPgzhTXCKb1pn7NPa/FpZ5cYAeOiqann7TrLhWWAmxY4f+jDFgg4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(8676002)(4744005)(336012)(426003)(7696005)(186003)(16526019)(316002)(2906002)(1076003)(70586007)(86362001)(70206006)(2616005)(82310400004)(5660300002)(40460700001)(26005)(47076005)(8936002)(83380400001)(36860700001)(36756003)(508600001)(6916009)(81166007)(6666004)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 08:26:01.6557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b1ce0f7-bf42-4771-6888-08d9ba245e85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4763
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

Hawaii support is mostly untested these days. ROCm user mode also
depends on custom firmware for AQL packet processing, that was never
pushed upstream due to quality regressions in graphics driver testing.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 267668b96456..facc28f58c1f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -147,7 +147,11 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 #ifdef CONFIG_DRM_AMDGPU_CIK
 	case CHIP_HAWAII:
 		gfx_target_version = 70001;
-		if (!vf)
+		if (!amdgpu_exp_hw_support)
+			pr_info(
+	"KFD support on Hawaii is experimental. See modparam exp_hw_support\n"
+				);
+		else if (!vf)
 			f2g = &gfx_v7_kfd2kgd;
 		break;
 #endif
-- 
2.32.0

