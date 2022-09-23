Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240CCC6FA82
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Sep 2022 10:08:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18B1810E4C3;
	Fri, 23 Sep 2022 10:08:53 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2042.outbound.protection.outlook.com [40.107.96.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F05110E4FB
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Sep 2022 10:08:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIh7C/duq3LhplipE6BvTa5LIRpW8LkVD5p9IzRLpJ3Qp3EOHOhIQo7sVbhzXY1yA7mXUFvEbgZJr2RjD4PHH9+3i201GucoThxbN0TBmztE2sGHcj8LxHeH9b3PLUQTYlMTNw4CxQvJkGdADQx4rULUPgU8ll6ICwQgAAvo1ce1+nX/7/L7+qm+IDuQg1PMmPYqp4CloTif4MDxIWH5IHtFV7ti4ey8WWvZtjuh6qbN5+pSRzs0JcctNkDjwEp4BaNfkuGh1XJNrsFAyRStnPbR6FFl6qC8tItEMrVggVLq6GdBxy2iYbGoI8VsF/8HlOt2yt8Ih6kNZN4+/X3WZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WPaGVH5N9ays5F8O853iKPCrfZtHRHos54bwwnFr9c=;
 b=I5N1PGxD0bV9+MFmWUUJJWSKbN9rtw1kT1eSLXeX0mHwCuDqMAe6sRD1gmevxz0mukCzkCGXdCEc/jELq5gPg2qd7XdHnfdgRHY6W2KvI8ZxkFtufopFiQJePTmz/MzSN73v/cFITg1nhnXJY4zO467LA8ulpKI/cuKkNT+twkwy4UgQOEo4fYKvZnDrP0DL1L+cm+kJI02MtZ+FExDktxZuRf11RG0gKaUoAJZv7Ay4s/ABrf7asiFKRtx2nLATVGubcYhnT594akaBLaRo0mFDnqRFJv87d7p/SLHfOPHdBty39cwQu836guy7t2KsAZVRwgL5HlFQ3xtQOQTLpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WPaGVH5N9ays5F8O853iKPCrfZtHRHos54bwwnFr9c=;
 b=nIb/CSLyWYxbWV7syXQzbkjdh2vumUEyw6pXtSMPEjGoCPmSPqrgG+Fvzvo+6QeX+IUCG8eJbsqImgd76HfypRy5pnG9SMkmlHdq7jUbT3lbOFg64huatSMffy7QWao9VvxVIZ9cK85/oJwcST6fEgUvndcXEK7x8tJzavWjez8=
Received: from BN9P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::18)
 by SJ0PR12MB5664.namprd12.prod.outlook.com (2603:10b6:a03:42b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 10:08:45 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::b7) by BN9P222CA0013.outlook.office365.com
 (2603:10b6:408:10c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14 via Frontend
 Transport; Fri, 23 Sep 2022 10:08:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 10:08:45 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 23 Sep
 2022 05:08:41 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <monk.liu@amd.com>, <haijun.chang@amd.com>,
 <vignesh.chander@amd.com>
Subject: [PATCH] drm/amdgpu: skip RAS error injection in SRIOV
Date: Fri, 23 Sep 2022 18:08:32 +0800
Message-ID: <20220923100832.21628-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT009:EE_|SJ0PR12MB5664:EE_
X-MS-Office365-Filtering-Correlation-Id: 72baceb4-9714-49c6-2537-08da9d4b99bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iJf6LnIeYIGrB/i9I8FFKGvOKSAcAsr/Foqt9b2qw8JcIBJapmd1jppwlLheO21v74gZQ1VKqqI08/+9DweFVoughaPSXDPfiIm8H1Tes08A2wz5Vk6fFKoT74P2DMnJU38O8AaKe6b3VOnZGKZZKDfPqIs6FY9arxt5IvJhJ26/JlLSlgfKRlRtqXk+RS15AtVsx918BwMqHKwUw8xzakz2Hgao45+x61S/ncrXL8TAcRac2C1Jf4JSz6t2L8/4MS3346a5S6s0eyBXYaDZLOOxYfr7Uxxm5sJreSxDvycdlezBTfvRHqSTQrgxnSDsQtN4B3Iw5IP6ujMddssc76T9azI0JUyOV56toD/quffvru+HLc1g8oIxUXmTuVpUxfmV1NaXFZELxenlP+xHAVXkOUgiT5REYnDZJLMf9hBAUJGsqjh3cX8Ppe5Jj2r0swcm9NOZdjGQi7ymvQyPJOlx4DFzbrjKlYVNZx8IeinhuaK3itzdGn7GGBpcHHh0FwEdp0NcjY117fg5FtlEsC5o9U/JJTOfv6TWQODtoIsBk3rdFVWEGQYa7qs+sdweZbIq2GK7RdQW9oCuc5fl2y3ijdr/I4IGO3owefVX48n0NoR56ndR9lQHQuYiYrRMQI+gzmy6gRNo8h6QU+pbHjxhydL8Z3/vQgAzS/VeK7xG9SSqJ4DwEu3klsHHHD2dpVup3LwYgyPXekCw7FYl+ABqVBrzQW34yKU9/dV9TeaMPdIyQB+ZsNOm3wUlaHoQjCWsTu+D7r0clhs30F7tC4QvyxbNAjOKTAtdK9fQ8GnYAGABJZsZMrtzpdE2Hxsy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(5660300002)(47076005)(86362001)(110136005)(6666004)(41300700001)(316002)(81166007)(6636002)(82310400005)(7696005)(478600001)(36756003)(16526019)(186003)(1076003)(426003)(82740400003)(83380400001)(8936002)(336012)(4326008)(70206006)(70586007)(26005)(8676002)(40460700003)(2616005)(40480700001)(356005)(36860700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 10:08:45.3008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72baceb4-9714-49c6-2537-08da9d4b99bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5664
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

And return successful status.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ae2248340ea4..de19a736dd21 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1103,15 +1103,20 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 							  block_info.address);
 	}
 
-	if (info->head.block == AMDGPU_RAS_BLOCK__GFX) {
-		if (block_obj->hw_ops->ras_error_inject)
-			ret = block_obj->hw_ops->ras_error_inject(adev, info);
+	if (amdgpu_sriov_vf(adev)) {
+		dev_info(adev->dev, "ras injection is skipped in SRIOV\n");
+		ret = 0;
 	} else {
-		/* If defined special ras_error_inject(e.g: xgmi), implement special ras_error_inject */
-		if (block_obj->hw_ops->ras_error_inject)
-			ret = block_obj->hw_ops->ras_error_inject(adev, &block_info);
-		else  /*If not defined .ras_error_inject, use default ras_error_inject*/
-			ret = psp_ras_trigger_error(&adev->psp, &block_info);
+		if (info->head.block == AMDGPU_RAS_BLOCK__GFX) {
+			if (block_obj->hw_ops->ras_error_inject)
+				ret = block_obj->hw_ops->ras_error_inject(adev, info);
+		} else {
+			/* If defined special ras_error_inject(e.g: xgmi), implement special ras_error_inject */
+			if (block_obj->hw_ops->ras_error_inject)
+				ret = block_obj->hw_ops->ras_error_inject(adev, &block_info);
+			else  /*If not defined .ras_error_inject, use default ras_error_inject*/
+				ret = psp_ras_trigger_error(&adev->psp, &block_info);
+		}
 	}
 
 	if (ret)
-- 
2.35.1

