Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB448EB64DD
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 20:05:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4841610E10B;
	Mon, 24 Jul 2023 20:05:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A02B610E10B
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 20:05:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6jGIVXPsRb1q2T4hRy2PfVsraL3dplEdP0cyRmIyvPbnTkuHXNDkdzeJwf/powNghXDdeJOhnkfeNAAT0YnIwFBI3rdIijC72EddNuY6mVKrSQ3CRnJ1Mrt2M0EBCViufxmlYPidSuhGrKAdnjIOUP54C4FjyLqpHskFSnFI5OX47iz0IDie+vPeHl8wuvMhORWmtR/9DNrKesc1GdMNQrgMx5uD4Btngg9RfnlFVVwZGd/640o0hm7crZeV9MLMTxnrjosLkQGe6bQosK6Uf7A8RZmTf0op8/8sj8/t5JHk4f/EzFc7epNxBlduzUD9su7GIrCblXqXggP3+45xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5c+z5R78xYQcBC4o6NtHwYWWV/wYA0f3v3JnpYj0ck=;
 b=Utz821c0gobsdSOkVZ/hIVqmctkyNWb0kEzWgdVWJcmaj7AmAbARLZyV1zHMRCVlW48kYlEzsD7v17KHhC9kaeiMDFRcZPzowfjOJw/NUqEFeTR81PxmnWpfHYmpXtNJylKrcUwxfQXATK8rpJAdjb2ZR2tOrcx73HXiklUYjltHr54Y9GKPhDdcq4TkJ6ffBXmslqDwNDGCjk2xLYTYZ+MndV4QQfiQt0Ajut2y05Q2PPJoU1oxeTUtdpTJZGAbItwZ3cPX91Z5vvGHV31R/CL+rk/wE/mjng+qOBGHwTfcrRLEahSVYcTgZCnVIvZ4Ey+bfTx7d/AWe61y8E91Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5c+z5R78xYQcBC4o6NtHwYWWV/wYA0f3v3JnpYj0ck=;
 b=Jtd2V4oGyTmBRk0dtdWtfRWkhJjVuxLjDqdSh/ecmfy4Pu1rO/LxkGpvUsy64/bNYKpsxMwZVc6wVnulV/yLw+pwFmjw3pvaRac799jWOyWoePbj4OWgTeo+CTdS25ioEw7OtB2ae7Q2I1cdHteeiyHSAHgfYoVtaRm2UEr7Zv4=
Received: from DS7P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::33) by
 DM3PR12MB9351.namprd12.prod.outlook.com (2603:10b6:8:1ac::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.32; Mon, 24 Jul 2023 20:05:29 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::b5) by DS7P222CA0018.outlook.office365.com
 (2603:10b6:8:2e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Mon, 24 Jul 2023 20:05:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Mon, 24 Jul 2023 20:05:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 15:05:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu/discovery: add ih 6.1.0 support
Date: Mon, 24 Jul 2023 16:05:13 -0400
Message-ID: <20230724200513.764387-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724200513.764387-1-alexander.deucher@amd.com>
References: <20230724200513.764387-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT046:EE_|DM3PR12MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: abf8509f-b523-4d76-49cf-08db8c81545c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ihObGyFzFx8N3L15JT43Fe8NHhsNA+bIubPYwi2dhcrzg+o4NKayPI3AIUpykgoQpcNf7Ikhqum3iKiCSeEXZdrHaA87yjD76Zs7DXF1Y2YaghyLCOxELxl0ZuIsS0pHrM735WHa26t7kTMI4Y2JxlTTcvkzjPWIP7oNGnyDfjggytc69jrZyBv6lYL5ix/DWQ/leUrRf0kWdLfJor7E8SZx3X8ojXYr54em32TDF5Gj7NAhWFrEVy+a+ej1mkwjaMc4HqTN6qf3iLob8ZVsm6f35RC6IukUpyrTgFKRKp0FOf5BegsZiamTolXBsQD1BZl2lzFnaPin0CDlm7tHWqOHRUzBKDY2vbRsrdvcXx+G7QckQuyUREn2Z0+9FcvAxTHQ10TtvqD83a8J1Ldz7xc1IVVV4QsHwM+oNUZF7dJgloyn9LEce+lPtJ53vI+yMHgTjRfnB1kIpcfRpsgV7GAMdFAcloiL5+dGyq53139AZUlBaa/wpH2O9DGZaaTSoMlzgg3vpcoKbJQU1hzCm53Z2/Jw+QA0T0jiWr9sT25+hkjQes6l3m24KBgTw+4ALk+bTiHBwFgNeLLowEx+SF9t6aTkNyTWv8pHpOrjv0VKxkPF4tdtpICk/5ByB71gzOKZC9nBFNz0hr5Rtw6tCPe6I+1uQ/PEP7UVSKHIcmla7O+HV9sH8n6ReJd7426crSboSGXkLDrU/Z/OZ3KISB+Zo7u0JpInR4NJdcBHyWgtmB4IAHIl/7PFdHQngDaL6uHaamL8snUWfWd/TLcM5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(81166007)(40460700003)(356005)(40480700001)(36860700001)(36756003)(426003)(2616005)(47076005)(83380400001)(8676002)(8936002)(16526019)(5660300002)(6916009)(478600001)(54906003)(4326008)(316002)(70206006)(70586007)(41300700001)(336012)(26005)(1076003)(186003)(6666004)(7696005)(2906002)(86362001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 20:05:29.6280 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abf8509f-b523-4d76-49cf-08db8c81545c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9351
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Prike Liang <Prike.Liang@amd.com>

Add to IP discovery table.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 59ed6d4ebfed0..9d8d08daca57a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -65,6 +65,7 @@
 #include "soc21.h"
 #include "navi10_ih.h"
 #include "ih_v6_0.h"
+#include "ih_v6_1.h"
 #include "gfx_v10_0.h"
 #include "gfx_v11_0.h"
 #include "sdma_v5_0.h"
@@ -1702,6 +1703,9 @@ static int amdgpu_discovery_set_ih_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(6, 0, 2):
 		amdgpu_device_ip_block_add(adev, &ih_v6_0_ip_block);
 		break;
+	case IP_VERSION(6, 1, 0):
+		amdgpu_device_ip_block_add(adev, &ih_v6_1_ip_block);
+		break;
 	default:
 		dev_err(adev->dev,
 			"Failed to add ih ip block(OSSSYS_HWIP:0x%x)\n",
-- 
2.41.0

