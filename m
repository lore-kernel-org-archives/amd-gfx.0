Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8AFC76196
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 09:33:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9162F10E4BC;
	Tue, 11 Apr 2023 09:32:59 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C99F10E4BC
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 09:32:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMde3D0okNI/6eXTDcY8C+X5APXqoRkxA+GR+NfoBbGXIcKem9CqCZoOwcUnW9f7ZNL/le/je1SahubBh0RL3IqtxBf50fQf0QzN1Wu3LsNu7DTIc5si/bM7pNyehIHKAQ6E70iEi3NBXF2NMEO1gxw9CkWWpXNoogUk4XcEP1uoE0S+KdLekL2uO4g0H1E+dDMZOx4KeENanJTGCSQykDLczFO8tlU7HwvuM0W7+ysYyAsmIGP75pXabEXVLz5Yj1LOW7pzibrGw8qCrLqbgoX9ZQHEy/YwscJMDItKLNAR1kgeXBupak6o+h/07PpXGnLnxfXQNKJgyuKm0EXAcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAwLGr2QcUuPmvoBUOztroKmf5VMAzR92MxqpdSZEW0=;
 b=i09AT7VKKGkFYsyPpOE+3Y23d2IK3ohdyQzzjFPmaBCEtlK5WqMfvu69ISeHgBk0Ez8vPrPaa0jJuCZC/dyCgSTPfBlJsy4EFnbExLNsqmpOUtFyy93UHT6C39vmg1GwlEMuL5c+NrvV6ZQYR63xQXrBRAZobGF9olAbc56EylxMCKQrp+UB1RopGuHDIYj3Xpqd98+RZsTW2oGKebPxmMvJYgiEhLDGtJBjChf3VAR5Y2s05tpRDJkjJVe+qaKP929QHgi6YL3IwMdeP4HCNtWdvwahtYcMmDC55fN1J1FmxtszMugHULeuSiklo1GerEjb/GRRHZtbNPqYChmCOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAwLGr2QcUuPmvoBUOztroKmf5VMAzR92MxqpdSZEW0=;
 b=YVg7g1HsS0YFbdkC+6cD6vdAuAlK4HEZWSuGN4JgSAZPxhZ2rfS2oVnN7Uq0TyAyp5LogxWDcV6G/IVHLvJSgq9Nd9KKTfT2hZCmWVjPbmsZbQR+Vf0IcqaVZPW1zmyxhisDO0q4BwhdLnuMrRYa78a5ungA0N8EXwFSmSLGN+w=
Received: from DM6PR06CA0003.namprd06.prod.outlook.com (2603:10b6:5:120::16)
 by PH7PR12MB5904.namprd12.prod.outlook.com (2603:10b6:510:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 09:32:52 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::11) by DM6PR06CA0003.outlook.office365.com
 (2603:10b6:5:120::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.40 via Frontend
 Transport; Tue, 11 Apr 2023 09:32:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.28 via Frontend Transport; Tue, 11 Apr 2023 09:32:51 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 11 Apr
 2023 04:32:51 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 11 Apr 2023 04:32:50 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Tao.Zhou1@amd.com>, <Guchun.Chen@amd.com>
Subject: [PATCH Review V2 2/2] drm/amdgpu: correct ras enabled flag
Date: Tue, 11 Apr 2023 17:32:41 +0800
Message-ID: <20230411093241.4644-2-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230411093241.4644-1-Stanley.Yang@amd.com>
References: <20230411093241.4644-1-Stanley.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT034:EE_|PH7PR12MB5904:EE_
X-MS-Office365-Filtering-Correlation-Id: 5109471c-6654-4a6f-b4d1-08db3a6fb8df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wGDXHOCa2qY4KsKl/O1/OSXQDv0W10nYXI+cjgyQC7Bc4rSW/Tjbh7DUcLxZs3P8c0bEzPLtdFNb4EP/e40NEWoPxRNt7FdB1t7oRLbn15ayol7I3tqVHfWV3g6Bc4KqdEg+OzURLStNo2FEJ5ONwxXiDaOUTNKpJIsbKZjJVa9Jz+xDiCWWWmkRiEFy7YBd/3uEWtVEWkkF0M89hrUFpefl/hp7QtKPOvCNIvDxyVzU+FMcU8UiihvfgFHapjxV4emBG/t050DW2tVRpUKWn+JpCwQqlKcr2YXTuNDHD5AH4Ers3IKdjfjLtSgxfmz2tge4rBuqVsWFVzjzd7QDSlFqmjLq/E8pHhHchLWasyR3HgGmX0muGrG4DacuGtBH++eSuNRGVbVKkjFsWTEzH/0lduQbJuUSgZ7WYrmUU/UYYdUzIGP6qWr+cH8FqmtI58UlM+e7m7X0ZfJ5MsT/wI7LjnwKJU/7ec0INOe6Y70+ZeiylAg7n74FRD7zfsO9hEf5iqdtXnsgHGpHz67J0TOMkfqqftsE3jMhKUe5uRu+4PV74ibvdKZYw3Qyw4aJIusXA8J4a53sonpOWaVN4pDiUcaEYa5sTcwZLPCvMhMYp561tR5id/cYIOTk6KJVrDZj1sm39oEZnuwMC7CmJJJhkw2GGeM2/TT267odMOxJEVzjfL2nMBxuT8srdZRhQi09bAbcESz8/zKAs83Fsz/cbS/1/Db+c1f4E5cwDNU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(36840700001)(46966006)(40470700004)(6666004)(478600001)(7696005)(1076003)(110136005)(316002)(26005)(186003)(6636002)(2906002)(4744005)(336012)(5660300002)(70586007)(70206006)(41300700001)(8676002)(4326008)(8936002)(82310400005)(356005)(82740400003)(81166007)(40480700001)(86362001)(40460700003)(36756003)(47076005)(83380400001)(36860700001)(2616005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 09:32:51.9725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5109471c-6654-4a6f-b4d1-08db3a6fb8df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5904
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

XGMI RAS should be according to the gmc xgmi physical nodes number,
XGMI RAS should not be enabled if xgmi num_physical_nodes is zero.

Change-Id: Idf3600b30584b10b528e7237d103d84d5097b7e0
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 4069bce9479f..c2c4d978896c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2430,6 +2430,13 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 			else
 				adev->ras_hw_enabled &= ~(1 << AMDGPU_RAS_BLOCK__VCN |
 							1 << AMDGPU_RAS_BLOCK__JPEG);
+
+			/*
+			 * XGMI RAS is not supported if xgmi num physical nodes
+			 * is zero
+			 */
+			if (adev->gmc.xmgi.num_physical_nodes == 0)
+				adev->ras_hw_enabled &= ~(1 << AMDGPU_RAS_BLOCK__XGMI_WAFL);
 		} else {
 			dev_info(adev->dev, "SRAM ECC is not presented.\n");
 		}
-- 
2.17.1

