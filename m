Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE50C46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 23:22:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F27B810EA84;
	Wed, 24 Jan 2024 23:22:14 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D236B10E69B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 23:22:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHcx1akqmu/4yt72cM4JJGNNyojiyZVOYIEg6x2AkSK65HtCd9OyDD7Ep/NeZSvGsBhs15qrGYg74piqtNFR8fvfaZsb8jKKNUi7FccHnzxroOdfuq0JDA7LHyhUu1IMgf3ACBU5LWORS+h4swiPWIHZpLqZXoBw2oMB9DVBQkKwUcEEZqDt6jhXkdE9AjH1GIFRcZQu/+E65Pfa5kQi8HsjP8yuzwFgi7uNDQ4YqX2JQ96Ffep/RPzdDxJyfyim0zRZKdDOz+ZZqSFvFhn2C2O+jQtBa4UiChm3q3yfkIT1G0L6PHWeuyiM5xtKqqTF9aMsTO4N8u1G60x823mmiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xE3GDrFQ4y52bZVjCkgqb/dh6mgY/uXGEHmLaT9bfrE=;
 b=ZXqIV+H5JX2G0+246JgjP7VUmI0GVQjRu4XBeQAdHD5TrkRBEZ9A7oUQ8tXKP6ecdd77MaNPGPijrD8A0tG1MRW1cs1xn3/A2J+TJ+wAV7S78tWtJ4I+YYzs4cg7gdfZ8BcSfR5l+jx/vMMNO2swhZ9wmIjhP1ElmTOWJAHJOsGmb7dN3XypC0gn5NhWY70yGUgycD8EusV5kDXvuUJv2fZhTOppPZiSd/2aq73Vw8IDC4UQ5o4savhHOrvsd7YDERcwQcNShY2Lk08llHbart3gdvUVgdI/+KuOVEhBP6+i5104F+bp0lYbldrvnWv5wm4cHDN9NpbHuB49/pTynQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xE3GDrFQ4y52bZVjCkgqb/dh6mgY/uXGEHmLaT9bfrE=;
 b=tBQHq6Gb+mP/jHOKQWUi9LP6GGK/ZCtuvjOYQJh3fPaOQ+u5+jNiWd9c+/A8I39gbfPEPeXpTeEDohh8eu8rD+OgW54Kh2TCvVGXoUPA9xDF6wg/1EUhsnbfGB0QziJLDPeFdz/87moeLK97GYL3rFCg9tQL4h8Hstm/uZpAMyY=
Received: from CH0PR03CA0340.namprd03.prod.outlook.com (2603:10b6:610:11a::28)
 by PH7PR12MB9151.namprd12.prod.outlook.com (2603:10b6:510:2e9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Wed, 24 Jan
 2024 23:22:06 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::f0) by CH0PR03CA0340.outlook.office365.com
 (2603:10b6:610:11a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37 via Frontend
 Transport; Wed, 24 Jan 2024 23:22:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 24 Jan 2024 23:22:05 +0000
Received: from MKM-L1-ZHLUO987.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 17:22:04 -0600
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: Add RAS_POISON_READY host response message
Date: Wed, 24 Jan 2024 18:21:42 -0500
Message-ID: <20240124232143.7201-2-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240124232143.7201-1-Zhigang.Luo@amd.com>
References: <20240124232143.7201-1-Zhigang.Luo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|PH7PR12MB9151:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e1e04ac-9a98-45b1-b069-08dc1d33472b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lyd9hN3VwTQXymfN13z2F5QOWTwso6m6yindES5hUQWXXx2R1wuOJB+o2nK/ZSPpJDwXdmlRipPGEU/WCgpIB6BZGPmSyw349sQaMzEc1QzETT4slcCq2WG1rgNShx24HTPA43q8I2jYHbwv6umtxproeXqwnBt5oUXl5hnF4c0ry5BNL5fG7TuMp0oh/sq9qXj5iDwVAIMTPblV/DQp/Am7ikJyYXhyLHq8OGr4UtGyYXrCbTuvxIrTvIpZzU2D+j/1bPANj5YY+dEJw+Wi1IiRJvkCZaRVk2/PVl5bqdKMWnZ61ZjMZvHZDIW61yTvvysla1LK3Ik4EW17ZJXBFpjpC5LTWXOjWrKO6q4J6FMTIb4bM0PWTq+LlD+oadsH0EOX88OHbKTLnHgfW0PxZflJgd2W4UbWogIvXExqCkxRTrIf8MLjIRA65sP/X6z6v7EpDIfyrRdi1VhpJp5trmS60hWVOfkkYhCeQAjygIDMY2NijmbyDtjcuQ8h7Yp/fZ+t60QY/s1DW2TJck6KRkRjYRSTi4m95sHqn2+uX7yu1K8HrkB3KB8BRK/qj70m9aULH6849MCNQ86AexnRYuuMJaUg5BB42UeZF8J6Aldcari+FTsN4n8SVphG+n4Iuim/pwMqD1/i3Qho0QAHU9fF/uV1jOminiAZqRXRcRE631bpG7utnJLE4UffjWi2+m2jX7crI978cpNl5echbmUEwcYRCpQu2+vQ6d6HKzPm0Kj/dtOaxMi64FkFgMhkg5qpBkPyNrPjuXtsyqeG3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(82310400011)(46966006)(40470700004)(36840700001)(16526019)(36756003)(86362001)(2906002)(81166007)(26005)(6666004)(356005)(7696005)(316002)(2616005)(41300700001)(1076003)(40480700001)(426003)(336012)(478600001)(70206006)(83380400001)(70586007)(5660300002)(54906003)(82740400003)(6916009)(15650500001)(40460700003)(47076005)(4326008)(8676002)(36860700001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 23:22:05.3569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1e04ac-9a98-45b1-b069-08dc1d33472b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9151
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
Cc: YiPeng.Chai@amd.com, Sashank.Saye@amd.com,
 Victor Skvortsov <victor.skvortsov@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Victor Skvortsov <victor.skvortsov@amd.com>

In a non-FLR page avoidance scenario, the host driver will
provide the bad pages in the pf2vf exchange region.

Adding a new host response message to indicate when the
pf2vf exchange region has been updated.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
Change-Id: I58d5d11d959d91ad5723d33fddb93570c259e245
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index d0a018da3c7a..c49bf87d4b0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -170,6 +170,9 @@ static int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
 	case IDH_REQ_GPU_INIT_DATA:
 		event = IDH_REQ_GPU_INIT_DATA_READY;
 		break;
+	case IDH_RAS_POISON:
+		if (data1 != 0)
+			event = IDH_RAS_POISON_READY;
 	default:
 		break;
 	}
@@ -437,8 +440,10 @@ static void xgpu_nv_ras_poison_handler(struct amdgpu_device *adev,
 	if (amdgpu_ip_version(adev, UMC_HWIP, 0) < IP_VERSION(12, 0, 0)) {
 		xgpu_nv_send_access_requests(adev, IDH_RAS_POISON);
 	} else {
+		amdgpu_virt_fini_data_exchange(adev);
 		xgpu_nv_send_access_requests_with_param(adev,
 					IDH_RAS_POISON,	block, 0, 0);
+		amdgpu_virt_init_data_exchange(adev);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
index d0221ce08769..1e8fd90cab43 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
@@ -51,6 +51,7 @@ enum idh_event {
 	IDH_FAIL,
 	IDH_QUERY_ALIVE,
 	IDH_REQ_GPU_INIT_DATA_READY,
+	IDH_RAS_POISON_READY,
 
 	IDH_TEXT_MESSAGE = 255,
 };
-- 
2.25.1

