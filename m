Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5B3C54EE9
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 01:37:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA28610E115;
	Fri,  9 Sep 2022 01:37:09 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2049.outbound.protection.outlook.com [40.107.212.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4190510E115
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Sep 2022 01:37:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4EnsMruXdno9oVQkhXgcxpa0b863gnuMvkdUSgJR7JVnCPNWSdIyk3NMyx48sHsDP35HrN5LnLvPD5EScqyqvSqWXLNF8p3lRMQ9UdYp/8pQjf46d6qLhUCgrHXD+KqbdcSj5QRPZW971DnATlIcFSIuNDVmDEn3lW1ysBglHQoLDEXRqaUjcwYbOiItdKSVAEv8mK9X40TYlZuK2PjoiIGQeftoBCuT8LCGzUpmNMPIndYmUVxmFiIq1nkKZIw3L0rEyY3PkUY0M8qnXqiOfzaEo46X5FmM+R7k4752fVITykmGsqXKadEc84gXL05ZFmv9dx+vjV84ykisgBAjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiWiXNFwgPiBD/aFgW0BCni+OsWEsiYecLQ+SAtCNcQ=;
 b=eyen+VUYmCG4RjSeuVV9XZS1gEKGN2jFbhlcVAni1WxLw4j2Ei+uyM1/1IkM6OgS6/b6DUmRZBRD+u+ddfCAvX2lGnZmXd4Jj/WQQQTnpUvMXVJbt0lEHxeS16eYZZQywR1CuL7phmd9RbJFk9xNvrD7eUEOBL9GM28XvUmH0RKuHqUewAwKFiyTMWW7UzlH74btPov+R3uiih6n1TKjGmIJSSZhyka82Pbha6Fc24G1rde21ed6SHaqpEASj/PXGRlet/zOwt048/XVE8nH0tp6+ha13nihu0fnJgs8C43GniPErueEEZvqJsyN1eYnVjzalh+ECe1CAxV/rtWUig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiWiXNFwgPiBD/aFgW0BCni+OsWEsiYecLQ+SAtCNcQ=;
 b=vNBc1ZqXt0A0Fe0SD6BNZb07QOPGNyXZ5c7/zeflCTBc0QvkrQ4uAzbEK60rawv23pMBsID2Fq/Zc7oi1TcyRsMmb/LG+2f8T8AIGJppc9jrWH+gCjI9mGqUSAmwtNeizy5And4UpPnBU6bNfq6NghK9T1OriWuvuWM66U+ffo8=
Received: from BN9PR03CA0294.namprd03.prod.outlook.com (2603:10b6:408:f5::29)
 by MW3PR12MB4540.namprd12.prod.outlook.com (2603:10b6:303:52::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 01:37:03 +0000
Received: from BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::70) by BN9PR03CA0294.outlook.office365.com
 (2603:10b6:408:f5::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.13 via Frontend
 Transport; Fri, 9 Sep 2022 01:37:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT083.mail.protection.outlook.com (10.13.177.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 01:37:03 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 8 Sep
 2022 20:37:02 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Enable full reset when RAS is supported on gc
 v11_0_0
Date: Fri, 9 Sep 2022 09:36:50 +0800
Message-ID: <20220909013650.16276-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT083:EE_|MW3PR12MB4540:EE_
X-MS-Office365-Filtering-Correlation-Id: badff1e7-faf3-40ce-d639-08da9203cc3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k87UeNY2nwWKyJUANKKH8Q28S/5coGDm2bm4tQq/0TkEyDXnh1WuGwA+B9avAOmFi8HEAIZafOWYSEV4vL0Eml8t77Xalt9rhVFNa529e43YK+LY3EgBk2yzo0DYNayM6kqmblfeF+Ke3OkwtHKL649sQKh45L20exPX7OzBUV9S3+obvHGkw5hoIoaZLkqHuvIPu5OJczZ71YpvTSvbHZhwVx0I6pFzDJJS+IXS3ttOUAMmzt5KpmsiVTcF67ArCR6THH6szNKBNI34aVNLJs8HALYZa+ej9d9wvzmKDBwuftmZLiPftk32AnODdULjBKB+dvutl7zA2yQ8qlTnxqSfgXC8W0u4VoSHwEuqLpYw+Tyh8ZoviO0rCD+y7lZ+WddFS6dTNdbgz8srkljGrwiuoShJm/ltzSCO+pueu9ihyHY7HQlwFKQz4t4rfHUOmKdBnim/yb5PVneqAOfoaONecQ3Oi9rngMWQgemLMDOC3owdOF8YOhRthFy61BIjom6pS3cyMPwhVBD+yppVhU5dKtqAcpHzBZGbDc2KHKG83UojdJXO+mojZDtsSOUNuCeFMXZ899bIclBHqw6ZYmMS8fndkBchLWLPicegLzJwPcoD7mVCIbs21TMhzEOHXAc+tEvSdE1RUN3OaODYsvJw2gy1tV5wiNmzO0Mqq82NeQeC/ZKT7pxN+EafsugU2zBzKzufcT87Si83WHvgPI+ESmgAcCoFmJ3XFa5n93xk6fnqom9qWLdN7saedRVJW3TDIeRdGBQSL8A/cZJmhGJOaan8hz2dn1rbW3do6fS0HVkkG80X4Q4FXf7E2tU3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(396003)(346002)(39860400002)(36840700001)(46966006)(40470700004)(316002)(36860700001)(6916009)(2906002)(86362001)(82310400005)(40460700003)(70206006)(356005)(8936002)(81166007)(40480700001)(82740400003)(4744005)(44832011)(5660300002)(70586007)(6666004)(4326008)(8676002)(2616005)(1076003)(36756003)(336012)(478600001)(426003)(83380400001)(186003)(47076005)(16526019)(41300700001)(7696005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 01:37:03.4792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: badff1e7-faf3-40ce-d639-08da9203cc3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4540
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable full reset for RAS supported configuration on gc v11_0_0.

v2: simplify the code.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index a26c5723c46e27..5f0d6983714add 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -421,6 +421,7 @@ static bool soc21_need_full_reset(struct amdgpu_device *adev)
 {
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(11, 0, 0):
+		return amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC);
 	case IP_VERSION(11, 0, 2):
 		return false;
 	default:
-- 
2.17.1

