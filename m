Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF165E810BE
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Sep 2023 10:21:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DD3710E4C4;
	Wed, 27 Sep 2023 10:21:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15AAB10E4C4
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 10:21:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8/gGXiqz+tDiTHftOs7YBm5pEqHnZsYAj8FyiMOvAvW7hCvM06RpMOnqCVAezjIHRxj3yvKlWh8CJTj3hBILOttsXneznCFSCJAJld2j1n/AzOve/Xpuw9DYhg90RwP0YWeEiGJofJn6Xz+rIbOg9Du46/QW5P4lI1yXb6/QR1DjYfnKx0trb3Pnob9Hzf34zVKoqgDpkVq+YkrlDUI2WX3ilp81wN7vwg0C78IH33GAsqANr3K54Ha0hgxX4MeoFhRcmhW6tfZOunVyGzzTtgnLvBx202On+3C0NnOZdEd8fXzCUDZqP3dtVuotQhouIXzUAjiwg0DyQKzBKJPwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3seZAj4SnPCK2VL09qYymUJcVs7LfrweuBWYpse5+fo=;
 b=JzR4/ZxTLPar267geQBEymQp1IlXcWEWqeUF2QuneVxPafe1sCQMsXg/gf3hyBfGnRP+jR67hlRTcFwE9IL0YlLDt1iuucUtEXKmw5iEvLYY02exxno61lDOOYLLiKc0FJLL3Ih4FCJxl9VdDV4MXfLEjIOqzG3jCNpuhL3Iv8WLGEZwoxARMgvh/oX1yy9U7a/EaUVRunNb6x6bqycoimktJ5dE90iAmTJC34NhmsGCGb0DRbHDDFDkj9TZMIo0W0GUvoOyXjzIkWBcjlRV+AgIwEs1kAHP8pAzYcU7C0iA5psMB570Ffo3TbTnqJgDiQ4TzDI0ongmi3Ui5P76ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3seZAj4SnPCK2VL09qYymUJcVs7LfrweuBWYpse5+fo=;
 b=amcj9rIH8C63mdw3SILXp1w72R8Uqm57WjDOIDQNxtzGKJiUwcs7PU6O6caF4UVdzcsPHfCALzlADcpEktdgDXZ2NwMjEPrUlbUabuNFCIWx67CRdr2LsmxS4tyZyuBekxLwzKHSJDE24UWNAcjD8orqQgss+2Y2JP1pCP533zQ=
Received: from MWH0EPF000554DF.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:4) by DM4PR12MB6637.namprd12.prod.outlook.com
 (2603:10b6:8:bb::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 27 Sep
 2023 10:21:19 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2a01:111:f403:f807::1) by MWH0EPF000554DF.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.9 via Frontend
 Transport; Wed, 27 Sep 2023 10:21:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6863.9 via Frontend Transport; Wed, 27 Sep 2023 10:21:19 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 05:21:13 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: exit directly if gpu reset fails
Date: Wed, 27 Sep 2023 18:20:22 +0800
Message-ID: <20230927102023.7736-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|DM4PR12MB6637:EE_
X-MS-Office365-Filtering-Correlation-Id: 55bf5009-b036-4d4d-8d1d-08dbbf437d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 21MCtFSGVLV+KogDqHqUR80gKLooKNdNC/jlU31I4/AsxzNUA4Ux382IcwU99dGwIxK8YXz514lMExRa4z4omr+TMSzszYT9ku2YXExA2tipR8F9KIG3l3zxoJHnCVIY93QhQSrAO8f5NLPomf7W9bWDkgxTAEN6nPDNK1pdZRownrTBPvw0+m5fE69kvmyKGsQv0tzUVa3NcA2uM91e3tKhbCsvNXQ9l+iPr323FhL6yXrxAARXSNNgyIk9xr1/In0DiQjGvd9m3CWuciWonomnmUA772UGQKtxC4/VoKxt5JIrZPyY1qnvnD/hUbBDf1yPsxWcYV0xf9StbbMgf7zErKt3uSazpPHg6Kdq53h8Psn2EqCp4afQCLJKSgriEBN0VlLh28/nUaz+sKTAu6ycv4aEW0ivVumC2rDgtZCggSyLYBjRSNVdINiyhWwmQ2xXtUkhYIr8oM5LD6jBOHwYe9qymGfhgmKoz6QtQyit70qY/YuspN/0ByHBv5Y71foE+Q/BA7/RBapQnzf1IPL/QecAnJ4DtAuW7+8hCIrAah7FfVIM6FKNXy5x783hdKOLBwsfnP2/pbIVObtwMpb93wX+w7fkDBF9RHPCvimtFjYOp3ELI0OqB/pxRjpZ+pblkTy2EtEuTCQ9yUUnKg4ngQIQfoPXIyvm3bCblSUTgSH70rVSklSOK4YgqS90BY2VYrTeluhj6TmxEy1h83PZMQJvOZVVqbk7lPdHkdPuLx/KDLIw5ncTGuvtDUFAPbaF95Y26ZVIGMv3R+scTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(82310400011)(186009)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(82740400003)(7696005)(81166007)(356005)(1076003)(40460700003)(2616005)(26005)(16526019)(5660300002)(8936002)(4326008)(8676002)(86362001)(4744005)(2906002)(70206006)(41300700001)(36756003)(6916009)(70586007)(316002)(6666004)(478600001)(83380400001)(47076005)(36860700001)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 10:21:19.0064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55bf5009-b036-4d4d-8d1d-08dbbf437d75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6637
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No need to perform the full reset operation in case of gpu reset
failure.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5436d7a34014..e4627d92e1d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5075,7 +5075,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 			if (r) {
 				dev_err(tmp_adev->dev, "ASIC reset failed with error, %d for drm dev, %s",
 					 r, adev_to_drm(tmp_adev)->unique);
-				break;
+				goto out;
 			}
 		}
 
-- 
2.35.1

