Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09413C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 10:08:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8738B913C1;
	Mon, 25 Jul 2022 10:08:50 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2046.outbound.protection.outlook.com [40.107.212.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34B95913B7
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 10:08:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5UbiqG0DbEiKkmimW1xAQYGEtCJGbWB2osFl45u1FnXmNNOllF2LWQBsgOKptR4FnEAa+5vB8t15vPeErn5ARmfHR5+6CnwPtL0EDl3VX7z48sBfBDBTh1t9RHvzoxvBkOgB4Z5zTsRTteLakofnCJ/I+J/dxbt/8ttVBwiPXcS/pehS/bFt5zZyTaoAkLQw9iDdZ4cdfH1T8fg6l2g1zC6CegkZiIIzpjcwd3Yx6ePWfFLTY+K4OW9rEWP+4Gdcq0eAWgSvF67D5ZF87Mrn92BOvPoaZAh5tT5iF9Eg1fCfayPfoeYzuB/qMz/RIi7WCqx5n57F/y3jSXOMrOihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQEUCcq2/qBMdOeM4z8WYOaTUTKBiSB6bKNHutCK47I=;
 b=bMOrx8sDNNNhkavUE90omHdsFo2GsQARG7XInKyCQHRI0kFuTsdlC/plEllRGYfjv4Nmeq6GI1oO1WmNpWH4pj1Oc9iwuTa/SJzKzvAa9iYrJrD0BzulQ2IBl+yZv97K5z2G4QhTHkD/7HTuDVejJDbgTfzAzFMtt9+CS7ot5KdSZH9IxdzjInf4ZTJ8z/XcKyflIZusm0akzqlsPKoH5VjjRqX+V8ga9gzMwpAgvTnhttKl5DbkH40p0Cl8jhMVsyIicgQah2z9EipyBhFCr0lBp5YAYQVfg4/GYEOxH6eOMNQOUNfxJ9wSJLcU36P3rEiVqqn6EFu3sWIZ11T4vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQEUCcq2/qBMdOeM4z8WYOaTUTKBiSB6bKNHutCK47I=;
 b=xWsFnwAGm3+XQfJUar4xUs8phyuzl/RQ4shwHinynGGeCjyoGEPKsWUXxFIDXA8h8BCyCPzGA4AxB9F0hI9fDNUV0rfOayCRmsCF7dbVGfUv2HtLJuyMuP/TbW+VpUyEasxzb1mCEShxWyabNMvcNJNeFZ1hSLsqirC3owF63bI=
Received: from BN9PR03CA0736.namprd03.prod.outlook.com (2603:10b6:408:110::21)
 by BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:3b3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Mon, 25 Jul
 2022 10:08:43 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::8b) by BN9PR03CA0736.outlook.office365.com
 (2603:10b6:408:110::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23 via Frontend
 Transport; Mon, 25 Jul 2022 10:08:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Mon, 25 Jul 2022 10:08:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 25 Jul
 2022 05:08:42 -0500
Received: from horace-sm-debug2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Mon, 25 Jul 2022 05:08:39 -0500
From: Horace Chen <horace.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/6] drm/amdgpu: add a compute pipe reset for SR-IOV
Date: Mon, 25 Jul 2022 18:08:27 +0800
Message-ID: <20220725100830.9106-3-horace.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfea37cc-9d3c-4c39-a69b-08da6e25a7c9
X-MS-TrafficTypeDiagnostic: BL3PR12MB6380:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /zdQ2Rob7qC/Y18flTap1S02MbNM/dBGn7JHENSGD6zIBwhvdjUAFUYZ9Fu+N4SeNIJJhn8NfenfJ+8BKbj7zDLr6BD1E2v2HtCw0PZKKEUcdbTJNGokKf6KAM4xjsxEOda4oMCQMP1VOi9X56sI1TzjvaTuHGy1w9RRgKU+IRLIwJL3d2leQ4MGR9dagcqmjDnZMwRiMGuD/kQ4ChfYbDBmVTI9UJa1S+JUDpPqZe3yp4hj2zaYCXPlD3yXo5cDGpZpQfwqS6Yq1rTrKjebo0Amd+NPc9xeCJYAmzGdAR9BTsYQYu2Oth7Fh6tnpGBsP9HNFG/B2EASB+4Rkg+fOyKGqLV4A9T5VDUHquxOB/x9uxzY4DZrOB6PfCEtkuq/pZKzd7qjeE+OO9kCyyaqweahqD/XxeLH5n1+EAbVuuAzFsuBtLZE9LBHoZe/Xg4VmHnGqajxG+JwwEmnzTnjDvIYa7IPZMvRpYRYMwPSLAC+xE7j9a1i99Cm5l9v1tvZm2uZ5/pm/yt2Nv1TOOHfqt47qWxN9D6BaxXKWSsgIVK/X0tW0wJu6pOeVeuKb+YelHQTUzrCBNxbgHnqpm/1AF8ERlsBm0MqRKu8d6iWIDgp3amTN37bkgxQ+OeIXGRwOiW04TqaHtLpl4BpoOgXz6LwNo/uBaYZ4NX/ZAWcUsPMe14Yi0emSkrgmRfJFa2ilsdYKhFTgrGFjuBRKRxgDDlHOFu+sQ9IhxaJAjQ3mnLdbIZ6ZD/gHzZwU0xsaSvERX+6yX38KeUbWHhC4uxiawNxwTgGz5PHwxp8VeZ1W4ugDASxcwwfNd5lBXKpvRJpMN8T4oGooIlfI9/6rlgdGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(39860400002)(46966006)(40470700004)(36840700001)(426003)(336012)(70586007)(186003)(41300700001)(47076005)(7696005)(40460700003)(8936002)(2906002)(6666004)(44832011)(5660300002)(2616005)(86362001)(1076003)(26005)(478600001)(54906003)(6916009)(316002)(82740400003)(81166007)(356005)(40480700001)(70206006)(36860700001)(8676002)(4326008)(36756003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 10:08:43.3421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfea37cc-9d3c-4c39-a69b-08da6e25a7c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6380
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Under SR-IOV, we are not sure whether pipe status is
good or not when doing initialization. The compute engine
maybe fail to bringup if pipe status is bad.

[How]
For SR-IOV, disable the compute engine to do a pipe reset
before we do initialization.

Signed-off-by: Horace Chen <horace.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 0d8193b30fc5..75556370028e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -2754,6 +2754,21 @@ static void gfx_v11_0_config_gfx_rs64(struct amdgpu_device *adev)
 					mec_hdr->ucode_start_addr_hi >> 2);
 	}
 	soc21_grbm_select(adev, 0, 0, 0, 0);
+
+	/* reset mec pipe */
+	tmp = RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE0_RESET, 1);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE1_RESET, 1);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE2_RESET, 1);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE3_RESET, 1);
+	WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, tmp);
+
+	/* clear mec pipe reset */
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE0_RESET, 0);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE1_RESET, 0);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE2_RESET, 0);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE3_RESET, 0);
+	WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, tmp);
 }
 
 static int gfx_v11_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
-- 
2.25.1

