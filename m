Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F6EECAAD6
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Aug 2022 18:43:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45A5C10E106;
	Fri, 26 Aug 2022 18:43:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 430AF10E0CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Aug 2022 18:43:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEfkXEka81ew3y30CXDAPHZ5UoO+VVnVwuI2icRaNDvYutRwgdzQSNsFpPLimJ/fdXoWRiFK2EG2uBS/Q1P0TBs9ANAP4WrntRH4p7aE/9LTc/Adm4A8xfwFcSEner4NOkiHdLTucAIaaPNHaPYEw4OvYfIzQH+tHkbPXVecOmxF70cuojyZWDGE0ADzMzf5z4MXwSHVFShdG8r/AeSVSz5i8tbGBV6iKflMVM/7VgjByJ0ubQoGdHEbDkVT1syvA6hdXd3P0mZWCb8+PyvqlRsZ+fd0eS5AtRPrc9w6Hsm2xb7VTmLFkyLOjHxvsYH61lNglDjxNwzReWzfICZpMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fwhi1gskAL+Mrx/gqxhu1qvgMGpxn/T/cO9aYczt3Vw=;
 b=SgJaLf93VAcTyIMfGyP12IfgcUVB5QnLILMacIj5XdXUH5Jrl6lBiDeg5dAeH252fo7EbdTo4Gbu/iBju/BB6jabYeNUmsdkZK6DF4dAzeiV7KRYPB8NYYpiedcWuhejJoyg9VSnG3h/A+WU1AOgbSm/tjZMUbwlia3pqdWKqOOnLMJAXGKBnH5OqU9aJECmeiWO6q+9NSBUAK1zuQUFhb2p5udkPMg/r9OPDC+TGDtXXiwj2jpR5xJo0WE2aH0Wp2ZxKKNsIFh1y1K9WXJyMIr/lsbakftpiEKwEPO59fV9PxuDNmr0xx8Ur8BBy55HR5422hEkiB8MAzeVFGnskQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fwhi1gskAL+Mrx/gqxhu1qvgMGpxn/T/cO9aYczt3Vw=;
 b=LFAXR0WHOWfpaq18TANW2URj7lXCF8nSWwRELgK54GcAr2uIPvdOCM89OoSqR2LV1saJZNKVAcgQ8sCypAql1YFklR/qF6wS/GEMEiYQKrx96n2+MZqxduW0Sm7a1C8yhtW/z8QuYLmbg0dUgcKi32B2p5CXVApnO2dzQiYZZB8=
Received: from BN9PR03CA0047.namprd03.prod.outlook.com (2603:10b6:408:fb::22)
 by SN1PR12MB2544.namprd12.prod.outlook.com (2603:10b6:802:2b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Fri, 26 Aug
 2022 18:43:01 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::d1) by BN9PR03CA0047.outlook.office365.com
 (2603:10b6:408:fb::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16 via Frontend
 Transport; Fri, 26 Aug 2022 18:43:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Fri, 26 Aug 2022 18:43:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 13:42:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: initialize common sw config for v11_0_3
Date: Fri, 26 Aug 2022 14:42:43 -0400
Message-ID: <20220826184245.855216-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ea266d7-882c-472a-6216-08da8792cd46
X-MS-TrafficTypeDiagnostic: SN1PR12MB2544:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ttvRFl55OYyiPJYpbmif09f37C/9nnPOCUN3CMFwMCzPabdZhrpPHpwdWPwMjUVOqEfJYWPmVFjtSnZxeU6+2eQ7UsMDB23WrwV94lIk/GPJIFOz2dB0Rx42OKoZgkL5c+lfoCXOiz+7K/QfxEyLU0Vwb7Qnu4Z6wvkU1x9Hl+a4ylN6pdw+kycDOw6Xrt7RbvF+5rBgRtE/Zz0wOfZQMZh76lwQzNhC7Sq3uggiodKOm2dqMY7BbgzFZkfKYrMwvC+feNZ3SPoXqL37WTCj/TWPt49iyMYS2Px1IQRum50H+93EtH1WQ8QLYRUScyX7Id8stEokFlpyvfzrM61F7DUkS20I9DtNuBSLeQFWM8DtQ6cQqnO+fXDaohS6XqxrvCHN4Ohm8Ie7g+liDMYOvTMWilutcpSrl/EHO5JcoHDFu2n5n5fMERoqgM8HWUyILi5XSPlRfCElCezBzOjemQTsNjmoIL47h0pwNeUnBKqdkp8CjXCPEafJ1I4Hq4kSJxz9wzkSHdXG3Ayqv2PCrE0Adxer2GBDfWl0a2u30XHi893qGuBZ7K9IIp06Bj0z6jpmQlvLkYPjQLdhamYs1qpq8TRs7wloMu0WnDGXf1JkD8b+8WGEa2K01Lc8SILqhVSA2viqBvxDoVrvxYGx/FPoUcMACszdPFIQMC2myYZ55w7POZuHcaPzakqShVXT1xtTMVOOVC4JDvmsJAUYKckfv7T2lKAjvV7QDFMFrz1im5yg/CWNQVMopbuSeskkzlzX3HgfjmIL0k7RBgaqTpQxhWHyuFsdedCdN4zEAk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(136003)(396003)(376002)(46966006)(36840700001)(40470700004)(70206006)(41300700001)(4744005)(4326008)(8936002)(36756003)(40480700001)(36860700001)(54906003)(6666004)(8676002)(6916009)(5660300002)(70586007)(478600001)(16526019)(316002)(1076003)(426003)(26005)(2616005)(86362001)(7696005)(336012)(47076005)(2906002)(40460700003)(186003)(356005)(81166007)(82740400003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 18:43:00.4638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea266d7-882c-472a-6216-08da8792cd46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2544
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Frank Min <Frank.Min@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

init cp/pg_flags and extenal_rev_id

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 55284b24f113..f87dfae4efda 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -627,6 +627,11 @@ static int soc21_common_early_init(void *handle)
 			AMD_PG_SUPPORT_JPEG;
 		adev->external_rev_id = adev->rev_id + 0x1;
 		break;
+	case IP_VERSION(11, 0, 3):
+		adev->cg_flags = 0;
+		adev->pg_flags = 0;
+		adev->external_rev_id = adev->rev_id + 0x20;
+		break;
 	default:
 		/* FIXME: not supported yet */
 		return -EINVAL;
-- 
2.37.1

