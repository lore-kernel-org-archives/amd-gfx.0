Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F61C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jul 2022 17:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBC5518B0B9;
	Thu, 21 Jul 2022 17:27:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A10518B09F
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 17:27:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEBVEKQ+ny/0MeDAhz6OjnSHHeRPeHmlf8nI7A2AufOrnHKjT2K+7i0zSnAjNUaRaCoK/PilNJVcBR8YmfoyROt46e9C9Z+W79WHV/miMIbYcHm2PVtvHXDLkRnlytEXCnJJbEzL1+X3dPtCkDd0IVkOwJMB4Et0z5UiOwgWdYn2HHE5HqIcEprSfdBn4X6vAjSuLJwIogLkaBYHZbvcOH8e61r/mv6ZBrDMwoRYfLVywfzw+87ssEGPmR+Y0d1LWCwsR2e2fmG6+ofMlkI/nfHq2i3h5WK3ZHiwAFQ9nOiIT/fvc+MbOGfcwjvSyzI9EdOKmI1X+NJJ7RQEZwt2eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SdTM8BaxjnW9ByZokxckIv94jzDYbj9yVM0IrAHkis=;
 b=I2DrW3eHqxl9XduuqQWWi0oFG5KlFgmROtKALktS1/t6F2FcruYKgvHXip+WJK4mrOSccx8YVaXlkwWVt0dmJVMd/5rnfCvQnLrolbEkeWvtOef0lVESXyQ8PhD6FVYDCiWNgU/symzvdtt5sO2qP+vV5OOqeiOJQa7Av9NLifisHNZfuFFG/G//AURxn3I5iAv8tjIa/OnYujs96Fx5p5y1gdm0syW2iiROGwpc3YCHfPlpi20a6YQFL/d4L1tyl+yCg3QN4wbklxdedDMttqM/L2ZOqUe2vEz2aVUWAC4G49pFWCx+wD7hAxsQ6rvfcuvY6o3tLN7LEMfRQKEUiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SdTM8BaxjnW9ByZokxckIv94jzDYbj9yVM0IrAHkis=;
 b=22vKOFWVAtyfUgcwUECEvRYaXP/f0YGG966y5ZOd3AfYl5bYE/dZUU2afAyE5mupqxkSllX3EcW5f+cJOv9a/B4hvYO3s+UqB/NWRUwMtZEXB+FFBmU20VRkCrnPjvDqYMqG8y4qvre1DXGshtk1Pxo+w+LVyfell/icTsspDHk=
Received: from BN9PR03CA0919.namprd03.prod.outlook.com (2603:10b6:408:107::24)
 by DM5PR12MB2535.namprd12.prod.outlook.com (2603:10b6:4:b5::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Thu, 21 Jul
 2022 17:27:52 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::12) by BN9PR03CA0919.outlook.office365.com
 (2603:10b6:408:107::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19 via Frontend
 Transport; Thu, 21 Jul 2022 17:27:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 17:27:52 +0000
Received: from sonny-TP67XE.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 12:27:51 -0500
From: Sonny Jiang <sonny.jiang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amdgpu: vcn_4_0_2 video codec query
Date: Thu, 21 Jul 2022 13:27:11 -0400
Message-ID: <20220721172712.309984-4-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220721172712.309984-1-sonny.jiang@amd.com>
References: <20220721172712.309984-1-sonny.jiang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af26029d-f390-40fd-aca0-08da6b3e5788
X-MS-TrafficTypeDiagnostic: DM5PR12MB2535:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LIB1qPSSA4foM1dMeos26nWzwnz7BcWfsR5sdAxTnaPTK1cE3pU73Yl3HFRbJ7iJV74rlsT26kA4IartRu7oGsCWPW1d9xfYBIOWvxxVfwfMf/b/lSzso9YoOOe68GibiBIPZnVW/IdxXoLaVRLgOdWDZdTPCDYGeCI59Es97mOIJvxQVwLrEhgTbIay/SbgFWv9eBMjAitSHTb9c3mcq9X8OeB97rni5l6IACU08IdHPxcojVgw6jhGMFe8RzDpkhc7XU/ickrNIFaDzXIaxTKDX+NRZ4LiZUCNtB/1ylOY0PAZNox+bJvMk9zwLhagqSTkB4wMbH6hmWFkELD6gmBUS80qzmS2d0xORSyZ4+j2UZWN2MTnt3XeLp88ehv9wgBsbCw+8fydlueVRacc30xO7LpDs8YGxgVkjTHi1dg6rFVrWI2sUlaDSWbf3PNIBA+V2xVqVF3bznSCbz79Os/xfD1aJCRWF2aKJP57CDJH5Odg/e928GJ4O6tM33bIOuvz0suY41TlD8lsZGd1i7b+wzSTt8Qyl6iGFv5AL/O0GGpgzTgkMBVqp1LrUfihfDte14bXf48BqtofrMJSOz4p8T3j56Oy0c3Q4gXJ7fnu4bsSy937uuAGwq7lVl/IQsppuPwcZFh7zp+ahDFDidD9/60BeSo07N7S9szOyY2YZEZfQfvm6Dv6UTSOpFYYbxTHdce5B4h0mXLZirFhrq/OBviFs2BjMj+lf7zN0/2FbAOgjvL2K0szyjht2MsHYeZjXrIbgioArU/zTb4HR9tHKaANEJvv94PO0qSwq84sCjLbhBWT88gHyDlP/3HhPevounwACRbbG5M+/xGtOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(376002)(39860400002)(396003)(40470700004)(36840700001)(46966006)(426003)(7696005)(4744005)(6916009)(4326008)(2616005)(54906003)(478600001)(41300700001)(6666004)(2906002)(16526019)(316002)(8676002)(82310400005)(40480700001)(44832011)(70206006)(26005)(5660300002)(1076003)(82740400003)(36860700001)(356005)(70586007)(36756003)(47076005)(40460700003)(81166007)(186003)(8936002)(336012)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 17:27:52.6440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af26029d-f390-40fd-aca0-08da6b3e5788
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2535
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

Enable support for vcn_4_0_2 video codec

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 00e9b7089feb..68e78983f956 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -80,6 +80,7 @@ static int soc21_query_video_codecs(struct amdgpu_device *adev, bool encode,
 	switch (adev->ip_versions[UVD_HWIP][0]) {
 
 	case IP_VERSION(4, 0, 0):
+	case IP_VERSION(4, 0, 2):
 		if (encode)
 			*codecs = &vcn_4_0_0_video_codecs_encode;
 		else
-- 
2.36.1

