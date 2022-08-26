Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5300DECAAD6
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Aug 2022 18:45:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B6F510E1C7;
	Fri, 26 Aug 2022 18:45:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E88A10E1C7
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Aug 2022 18:45:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvjOq957FZlODpYbNsW7OXhniRMHJue7147YUU+wRQ7VXQcUWh1PeAFaJjAtXME8ctRdelLiW//zUfq1I00mDaujQLS++SaEs/GvnPjTgdzKBWowM9p9Qa6kxH5YYKFnJ4IBeOH60bV5rQ4wVWCBCpB4kuynuAoX8I0a8PhMke/W3vupz48yGQc0al+nVDMo36isxzR8/CzwTCvbLGHzjoNij3u05bD30kqvXVBHMdQX3slzdnof/3tPEtNpQgvD39BtOnpTL771rmsztOm7FSi/Z/Xugggpl7KtbP5I3nxp8w5xzw7Fg+EI9Xwpuqe5naUiH91Um8ZckJt8h/TKsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXGdXPcQXesKbf4ivkTloNHRdcsascxy1xZEt1aJ5hY=;
 b=lq1maMS4Hw+27tcDOg5lGxqGEBhBryxhEKUcCsNm57JabDoz3d4vz/0fyjZ8gv3jW3UY4WMmecz2NBezKIB+qt98TlXMfcUzE8XyFvU9fo9w8uLBXy+E2VCWRfFMBMN5ecGvDEn11vHUb/I2Fp9oJlQWuujTKEqmeIYDyZ3uysM9Y84t9BvMWIC6vb0AzX4C0zAArhAI3u/7rhfSZbamTJOOqv0Zlmff5nQvUyWgA4BSIwSg1Gg5LVZCRfbFrwKsowpxQGSkK+fhTbYs/UzZTPG83N8UVd3tNJmbRadbHcWdCUZKkGp/MGe5k/F7mlue003J/2C/DpA9LiT36JFn2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXGdXPcQXesKbf4ivkTloNHRdcsascxy1xZEt1aJ5hY=;
 b=0zqGxl3YfNOlWjaVfneYQZCKMqCchV9B3Nm4mxmVW0xUPHqelB2qkv/F7En4R98YJ8pGl9V3wwx1KJOErvUML7CvpmrJNHDk8jBI8SVbGoNfKpdO0/b39oXeHpLiFUzIxEOwYj++AsRoFATOo6kpokeXtGE4NwBg79JOw11CoPM=
Received: from BN9PR03CA0988.namprd03.prod.outlook.com (2603:10b6:408:109::33)
 by MWHPR1201MB2559.namprd12.prod.outlook.com (2603:10b6:300:e0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Fri, 26 Aug
 2022 18:44:58 +0000
Received: from BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::d) by BN9PR03CA0988.outlook.office365.com
 (2603:10b6:408:109::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Fri, 26 Aug 2022 18:44:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT082.mail.protection.outlook.com (10.13.176.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Fri, 26 Aug 2022 18:44:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 13:44:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: added supported smu 13.0.10 sw pptable
Date: Fri, 26 Aug 2022 14:44:39 -0400
Message-ID: <20220826184440.855532-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220826184440.855532-1-alexander.deucher@amd.com>
References: <20220826184440.855532-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1694b4cb-7dd8-4145-1488-08da8793133a
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2559:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o8moixI3SjwzdAxEwGeTFEpozp9VvPhLuRmw4PyAG/sKiqBOpAEF6Vw7EzxpAzhDilxQw7CS4djq4EBd8bNN+sOGr3nTlbXWvyl4qauxHhul1mia4gY75UytYu0uyazN/hJQtNdTHYe0Hwthu3mtjFqdhdvJO4A7oPDVjlNnULA6BK/vTQ+tEIb+PR28Gn9wT6hbbo7MvvhWmG8DRPwM4wNOQbdswiZsj+Jy/tbnAwQjSQX5ix/N3ag3B3k5nR+XKUqbhOtF+0zvLTN3/3Bk7kwRRUKWQ3BkdppM4o2JSkiQhrde7OSs+kzhdQdxMQttByJfMdalH6YfUKYojbouvlIqpqRhVBWf0h0GueDvvm6fcaACQHqMKnpFcs4MosxQc32sDukNyEEgb+fuyclZvkVONw/xXmnlh+1hDvK6JLhFTfF8e/iNJCarf/YsBgRUFVXKDIDtPg01lXDV8+D9hDx3qDT4KzvBvix6G16VQx4jwv8Z0r1vm63iTqqm8Ajbk5IhYQnc6O7pGCrZiZ9aUsLyuOPJbQspWZdMjP/r2LTVVh25kBFyRSB8XXbXh2KiimnzkVQCJoZiFUvw7nXKmNLnrFcDV3h5OPeEq0qSK5euSLixvhTGSDGZNep9VR8NHWNgGjDS4KouKyGPFx1eLsWOJdH3tgzVI0Vgol0GdPHIMs6RU1bBIBGbvIMzSpz0cNKCEBhMmBWhQl9+pZxhv2aooYuqXLV34lAyaCV9ddgqW4YTSXhcesuQnVTS89FGiLcNr51rErOmW175hOSAomH41wQNAP+laW91Pjz4KB4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(346002)(376002)(396003)(36840700001)(46966006)(40470700004)(4744005)(5660300002)(70586007)(70206006)(8936002)(54906003)(478600001)(36756003)(4326008)(6666004)(8676002)(426003)(41300700001)(6916009)(82310400005)(7696005)(1076003)(36860700001)(16526019)(2616005)(186003)(82740400003)(316002)(2906002)(26005)(47076005)(336012)(356005)(86362001)(40480700001)(40460700003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 18:44:57.8237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1694b4cb-7dd8-4145-1488-08da8793133a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2559
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 John Clements <john.clements@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: John Clements <john.clements@amd.com>

added sw pptable id 6666 for smu 13.0.10

Signed-off-by: John Clements <john.clements@amd.com>
Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 8e17bd5b52ab..94a2826236eb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -500,6 +500,8 @@ int smu_v13_0_setup_pptable(struct smu_context *smu)
 				return -EINVAL;
 			}
 		}
+		else if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 10))
+			pptable_id = 6666;
 	}
 
 	/* force using vbios pptable in sriov mode */
-- 
2.37.1

