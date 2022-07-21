Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1496CCA485
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jul 2022 17:27:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 510BF18AF1D;
	Thu, 21 Jul 2022 17:27:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12CBF18B0BB
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 17:27:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knwsOpeBXBohki7YKveKS3lvudikIzK8G5JEHOJDO4A1bx3wXhgOOZ9b3pFqh7ct77GGttRfYgaJDcmOx2j+LKA1zM4vCMjghjsmGrLH3zSEljOyfEBFx8amO4sSDy96lGH/8NTmKxtb2Ftq0wrWr/p51q1VSVrvNIUS4eS/F/rnrlwlGXOUAtXbQnolabwdD6eS8EjC6azMp4T/+WQF3tSQK5AjVN2c7XgRZCcbZddqOgULWBNmXYAcT36sw6OZAW+hMA4FDQkdc6vlley2VkNqRFtLRvQCXZjo6B7RUd6zslPSiMjnyU8i9g3Lh3VpMWF0ufWdXrSY30WOJCjJ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25JlFwshx2XRweVJ6ORBH0Gx8v4VJp3/9xNaGXKosvo=;
 b=ePa9VzmMLaK+/IppZ3R7LRqBd9k4+H1EVX0OPtiOL6qnO6cuReOgKlFj95JB+dVtacpYdOd5D1cIjDsL2k20ARxQlXExopmGRBWw22mjvCyNU4ob/IrrESSPJUDX5+1k0vPACO+BgQodQJziDbn/p6OcWA+35GW1lRhtTj19c8V3OXrNFACTmrBEZJyfHtMw3Onfjwe7I/O4AqUcZTmYYccrG/HMMCdz4BFFiZfuNIv4hjDFUpflu/oeuhu4DzJfyCwhZTh24fb14vXTKa4ndiTvVWO3+LwnE9WAE+iEWWx7/xWVZObhfnBhq1YGqhXZiT6LxBOX6+sl08s1/mTryQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25JlFwshx2XRweVJ6ORBH0Gx8v4VJp3/9xNaGXKosvo=;
 b=C3Kd1INWtrUdVp9iLuHEjCM81SjCgtHtIyunmacD7NdCb99bcke2J2mRTzyPgGbKQsfC16g9epcSq4hyMBnfuiH+L8LHnsMTAHgcLeD/v4OrChestebsr58aBd9tkzkDrGeSKLusWmsSZeGlF49MBLXrWiKmd07o43elUmHeeq8=
Received: from BN0PR02CA0025.namprd02.prod.outlook.com (2603:10b6:408:e4::30)
 by DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Thu, 21 Jul
 2022 17:27:55 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::72) by BN0PR02CA0025.outlook.office365.com
 (2603:10b6:408:e4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19 via Frontend
 Transport; Thu, 21 Jul 2022 17:27:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 17:27:53 +0000
Received: from sonny-TP67XE.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 12:27:31 -0500
From: Sonny Jiang <sonny.jiang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amdgpu: fix a vcn4 boot poll bug in emulation mode
Date: Thu, 21 Jul 2022 13:27:08 -0400
Message-ID: <20220721172712.309984-1-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0becc56-3e7b-4867-8d94-08da6b3e584c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4332:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l/uenattkphcJQold0H7+O0gTQR5YnGMMgobIFj+0l8v9duwqLmuvt60M7kwvg7IJweIGv9aREEiskNc6rC50vR0UsjHvU8FzaU9gGp8DeczLiobSasxLt2azAgLY/kQoNTedSGm+7FJDQuGiGfp8xc1A3HDZqWNKZB4Gsw4vXHu7bfv4pW0Rp6pKm9aKmDVaH0PNzZx7TXrOi/ThEcx9q9Z1vetpA7rkoPw65bXd1vFrdTyLuwboPnv9XPPtjnun9nQrUsAHh6uuOTUuAuh7WpalEufUp8qNGVmwYN9oT+oPQZgsR2mmz013rE7X5H5HzvQEgXi4YvvxsX93Q+s+FOKEqGF/aaT8FVhHmYDK1n7Lzxuj8k/y9xbyujf6/QMPDGZt3nyj0tNU6ykx6o0wEwmKHvM/JhRFzckNoN3tOhTaYYW5Xd8feCQzapAF24X93uGBYcLY5PODe9ErN6xRaGDwfiAhwKDdMPjpSWug+dTCDBYhXQJ0HB63+G5uhFY50oMaoCJ4ypF9UNE+oxLmIFRbthb9GDFkPQtoEDCUiofjAsTv8vKa70eoatUNfEVVamvtiUn76mtkWjB7SS18D5Caa5kEe+nyh/Jy8c4je0RaUaHuCyg3vnLI+RbKofPkS0s+OMk2gXc+XEwb87r0sRasNAPbRY/6j6HKUAdTTSG0UhckZgYcvUp+izgzCXfYNq5pRWWATutBaUlECMQcJc8Jok6+X+6DjY79Of38gmYAao3kb3xTYQiAI6u1kjnaHFhS14X4tdB2DmEdX6NUUO3J5UMfpIdox1UUUm9IZrcYLfuTx5d/u/MC8kMHCKzf5urPYBMCCPtCcDFPaCSfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(376002)(39860400002)(396003)(40470700004)(36840700001)(46966006)(426003)(7696005)(4744005)(6916009)(4326008)(2616005)(54906003)(478600001)(41300700001)(6666004)(2906002)(16526019)(316002)(8676002)(82310400005)(40480700001)(44832011)(70206006)(26005)(5660300002)(1076003)(82740400003)(36860700001)(356005)(70586007)(36756003)(47076005)(40460700003)(81166007)(186003)(8936002)(336012)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 17:27:53.9121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0becc56-3e7b-4867-8d94-08da6b3e584c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4332
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
Cc: Sonny Jiang <sonny.jiang@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The return value should be set in vcn4 boot poll.

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index a91ffbf902d4..3a16588024d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1041,6 +1041,7 @@ static int vcn_v4_0_start(struct amdgpu_device *adev)
 			}
 
 			if (amdgpu_emu_mode==1) {
+				r = -1;
 				if (status & 2) {
 					r = 0;
 					break;
-- 
2.36.1

