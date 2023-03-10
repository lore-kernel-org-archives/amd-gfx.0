Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42047C64EC4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 09:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65BF910E9B1;
	Fri, 10 Mar 2023 09:33:28 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4EA310E998
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 09:33:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DO9Wt+cBN1iLUyaKvss+D5dhmv057II5f7sFqW04iqs1LEHbSQ5m7cnrb5+3vctTXK5HWwOewZHoKuqFnibfKH10FFSQn4eG7+0aExdWz/GdGzZq/KDd/OVQkUbrUCYraYOY8fLq+SSBe80WRZcAdHCHIVmo84v7DYgrhAPXE2Lfo3J9sVVf+T+MDDDbH0x6LNRJvQPFiMcyT4u2tLcbDl4ahx2ecBgXSz2rjfsOMuBEzmeEov69h7xetTXbFXVRKChs/37idD8GY/ea6KvEWmeyZJUKpGSady7HFXXW07WT9mzTOjjUACpjPIIjjmHm3nG55r9UXNDmJBGcQcAMRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4U394imRqHwwNVzM9oKsPwjfET0LIzgDfPJ9Ayvxz1I=;
 b=h2dfi73qhjegc0hqd3JntPNLh26z4xHBcZgVQIH5BxYchexw98zIkh/FbibwEaV38rqRu/VZmzV1iRQdVtULa5MxhosVT+yWUs/HXsxkQbZLE36+61prnh0wMkCKe8qNiXbQxUoIesJPdCmnQfu5/adTleBlyuakquGDsap+/BVMrJJGznI7jTdHr9SsBeedZMri0B83k/8/ft7Frme00lxyGtmAf9/n6VWgRPQdIirojQt7LdN3XKAbCC2972Af45F39CZbEsRnzleu/fg9X/HmuzBj6Yetsae8E2H52v2k3yDeqnvWaazM3Mat/m/jpHynIkWxLILyvr8H8+jowA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4U394imRqHwwNVzM9oKsPwjfET0LIzgDfPJ9Ayvxz1I=;
 b=ggOgvdrnY9ygbvEk/dfhYjqYXq5wc0154y6KSw2IbipiOAEE91HDc8pBaNKJF6zBOJRB4ITeKbwKNz6gqP71AqD50khdH6xHiOEwvHOZA471KozR9hc+DwQ/RtOZa8KqGE8zp5mZon2oPGaRV8XrlzqxPr5rZ++rEM5o4zlYYuk=
Received: from BYAPR11CA0056.namprd11.prod.outlook.com (2603:10b6:a03:80::33)
 by CY8PR12MB8313.namprd12.prod.outlook.com (2603:10b6:930:7d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 09:33:19 +0000
Received: from CO1PEPF00001A5E.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::fa) by BYAPR11CA0056.outlook.office365.com
 (2603:10b6:a03:80::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 09:33:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5E.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.13 via Frontend Transport; Fri, 10 Mar 2023 09:33:19 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 03:33:11 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/19] drm/amd/display: Clearly states if long or short HPD
 event in dmesg logs
Date: Fri, 10 Mar 2023 04:31:14 -0500
Message-ID: <20230310093117.3030-17-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310093117.3030-1-qingqing.zhuo@amd.com>
References: <20230310093117.3030-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5E:EE_|CY8PR12MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: b5df23db-2375-4e1c-515c-08db214a7bf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OBSuKOBo6Pfco/G0kwcPdOgib0+bfBKcTdPlovWq4bzIUsAFO4Yh4EYVU4z1VgcH+lA2YY5ZBrnOe6eWSiovaC5Y2V9CmWajuRoRWodPkV/G1IHjNRkhntYq0rOFyxOYbmCR3FEgaR5YUQqYe2zfbXi+FF8+dOHMxck5K3fwtfc6lFDbdf78GP6ry9XPG3axwGFc4/iHX9xRFfpFQAi9cfGBFUJWHryxhGeS2zb4jABbUBcRt+8ynNqwwKo+J6TxXOPXCIBSWjERq7WPzE3Pt9+gdy2cTRsZIXZEyioo8uHTvb3em8TX3T7UyKMCPr0lqG2jju93U4rnfaimihbNvhxM5eTLJ48O2DtrDS+HRx7tqE3orJf2p+ilqfqVgGMNMQ62Zhhc75PqbLrEK8isVvsQBXJjcHukr2xbArBoSET6ow98Fw4QPLGixRRnEmnDIUg2xP/NB6MszXZqFuioGV7g3dWpWV0f/9e1WogHV6SE+7TxgZL6v9ffp4yJgpF5ZuXXQ6JXx+IG3l3KO5XGYAWeMcd21YxMCjKk03zHtgeU1Z0T+4LnxtxBOoYGOnywdMexJiud0vNcYVwFxV8Om/iyVaJA/IpVINQZHBHTjtO2/ZIlMS52Y0yhsBienVDaJQeT6IFdMn6Rc2footDCrCnjSFhg5Aqv66Kbew33t+97PzkVzfKEuTZRTIfzf6KpgUFSlWF7g1p7g+kgO5DpZj9igZTqFXdpsLAHRySp0DA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(2906002)(44832011)(5660300002)(26005)(8936002)(36756003)(41300700001)(4326008)(70206006)(6916009)(40460700003)(70586007)(86362001)(8676002)(316002)(54906003)(40480700001)(478600001)(356005)(36860700001)(1076003)(82740400003)(186003)(81166007)(16526019)(2616005)(82310400005)(336012)(83380400001)(47076005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 09:33:19.2727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5df23db-2375-4e1c-515c-08db214a7bf9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8313
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Hamza Mahfooz <Hamza.Mahfooz@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stylon Wang <stylon.wang@amd.com>

[Why]
The log "DMUB HPD callback" is crucial to identify when DP tunneling
is been established and driver is notified of this event from DMUB.
Same log is shared for long and short hotplug event and we need to
check trailing DC debug log to distinguish between them two, making
debugging on DPIA related issues a bit more troublesome.

[How]
Clearly states in dmesg logs whether this is a long or short hotplug
event.

Reviewed-by: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7b5c32f52cc7..997cfa98319f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -717,7 +717,14 @@ static void dmub_hpd_callback(struct amdgpu_device *adev,
 	drm_for_each_connector_iter(connector, &iter) {
 		aconnector = to_amdgpu_dm_connector(connector);
 		if (link && aconnector->dc_link == link) {
-			DRM_INFO("DMUB HPD callback: link_index=%u\n", link_index);
+			if (notify->type == DMUB_NOTIFICATION_HPD)
+				DRM_INFO("DMUB HPD callback: link_index=%u\n", link_index);
+			else if (notify->type == DMUB_NOTIFICATION_HPD_IRQ)
+				DRM_INFO("DMUB HPD IRQ callback: link_index=%u\n", link_index);
+			else
+				DRM_WARN("DMUB Unknown HPD callback type %d, link_index=%u\n",
+						notify->type, link_index);
+
 			hpd_aconnector = aconnector;
 			break;
 		}
-- 
2.34.1

