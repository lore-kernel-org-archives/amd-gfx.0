Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940FAC7EE2D
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 15:52:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3581810E6EC;
	Fri,  3 Mar 2023 15:52:29 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E21910E6E6
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 15:52:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZz0+Qvruk1dmc1uc/lRlwLLCPKAc06HurVufBdDeBTMSLDLIYMY97oYoHO2d0tQ8ufDQYs/TzHZk+JcyXaPE+kdDo8a//Hq+5NtGBkMmSwaTzO6pjPCXpa1t6LHvGowbo3132gEl5EvA4IyHxNvOnIEOFwkLMEovq0h00DjnnVTjPRYjjj00P4Zt2/C8xIz4RwZAipyk4wL4spT6eL0tKezf8LYGjT/WpK4gNhQL3AOEurqPKdl0xk+Be5rJqV6iWgmLGxXNFj1+XsQnT5K+booadmxjS9cBeTJrTQi4m9uQDdM0AyySgIURWoGbPCxueAVbWxpRXikP50H2pyYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58MelooYsjYgRDuzU5zVuGnpmYISD+490wRqv16n1yg=;
 b=QXBG8AzlN/7YFY+1oE5zqFOfnT9aTi5g/bz/1Law55jGWWoethILGFQEbbp56nWFo2zi+078T7yYPFQIkLc+K6mWP2y9RUOiE2FbqHzG2z0ihOmGoQJH8GfWwiJ63KCb6rrPAny5p6jKM9DTP4hagETC5+lXrAcYRjO4QxubGVUWmi2Hx1Iyr5B6taAFrMka2q45WGxgB/TCxQeeza6NgbvTGlqRLMhZVosz31fRYHgO+2jkjQ2sd4dl8KyaHPh/r6d1Ip2wAxiM1xMNwfPGUgY4oFNxgujcBEOBqPDq0EjmMgsnnglS3Qz3lWYBzSQrbIVxASW0YiLLgIMevLf2NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58MelooYsjYgRDuzU5zVuGnpmYISD+490wRqv16n1yg=;
 b=2exCseiZ3ha772tpDt5EbOsv4EtuEK19aym1ZjGdKVxPclC8tlpzL185CSaClNhg87VGPLO3vqS70QoDbSOeaI4/VpB2Bmcm7bFjfTK6iYO201XxEm/UZtpT7t1i99XzTaFcnFdEzFX2aTPXQqw1CVdine1mDCV/IczG9Yd99lo=
Received: from DM6PR02CA0087.namprd02.prod.outlook.com (2603:10b6:5:1f4::28)
 by BL1PR12MB5078.namprd12.prod.outlook.com (2603:10b6:208:313::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22; Fri, 3 Mar
 2023 15:52:23 +0000
Received: from DS1PEPF0000E633.namprd02.prod.outlook.com
 (2603:10b6:5:1f4:cafe::dd) by DM6PR02CA0087.outlook.office365.com
 (2603:10b6:5:1f4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22 via Frontend
 Transport; Fri, 3 Mar 2023 15:52:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E633.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.16 via Frontend Transport; Fri, 3 Mar 2023 15:52:22 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 09:52:12 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 32/33] drm/amd/display: Ensure that planes are in the same
 order
Date: Fri, 3 Mar 2023 10:40:21 -0500
Message-ID: <20230303154022.2667-33-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303154022.2667-1-qingqing.zhuo@amd.com>
References: <20230303154022.2667-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E633:EE_|BL1PR12MB5078:EE_
X-MS-Office365-Filtering-Correlation-Id: aafdd733-7d24-4615-f6e6-08db1bff4758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AH18uUXJMWKu5kZgOHaYuwO+RXDxdnJ597ym7BD9bk27ubZ8Ws2XgNopWjlOQDIkFdzfIVOGAxIQOaO6Yjdv/novi97H4kx+GpCBrpFzIl5fRu8B93XGXW7JGm+5V2IfHVWRaZWu1H7SSlAyICs3lvO115xJkT/tgEMthLcNvcOez66+fMV4BMgW6X+aCFhoO2/PwGKQdyKcEobbhXUBol8/EV2IFB8j1X0kOX+EHWUrpML7GeY4ztXGYBBmwv+YWLuGi2mFG2GDv+wVs08rmPDZeTWvAmFzArK8VsrfcWvLumJ0f6YzpK00rOvVYU4nOakHZfDAEscojjpL/Lj9MeRucmnG+L7jy3bwvrVN2I4RRwG1UVsrGZY6w6Y1W5o2K/we2InM+5qPb6BNKkyk0/5q36kDe2Fr2kzI6TheDDTIzWnciINBP9G2hH566g+AEfy0NA+LAf2tAisYeomn5+CAZ6A7u5Ml3NeISrX+YwbBciDM5wqQFByN6v1YwDcUwu07J/ECO8QqXeTS0LPDxqrEAw0sXrqlNCfrOGfDuYDEH4cxLkRiiDvslqQBfMUaYdzXLRGcC1jrPYVwM/BH4yKq/Ug5tyqUg+qXNQUZYOxJw9RxgbMeclmzeFS+d5YY5xvduLlK8KBy42ICHl4q/Tn/f/8m/yQzfyl4AMIGbvqpmvYoo+bQRYdzh8n2OI25kBYPMIVl5uIKzs1xGJQKAjZzda0eGUv54A37f2ns+aM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199018)(36840700001)(40470700004)(46966006)(70206006)(40460700003)(4326008)(6916009)(316002)(70586007)(8676002)(83380400001)(54906003)(8936002)(5660300002)(36860700001)(41300700001)(6666004)(26005)(2616005)(1076003)(16526019)(478600001)(186003)(47076005)(426003)(336012)(40480700001)(36756003)(86362001)(82310400005)(44832011)(2906002)(82740400003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:52:22.9274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aafdd733-7d24-4615-f6e6-08db1bff4758
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E633.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5078
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
 Melissa Wen <mwen@igalia.com>, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

The function dc_update_planes_and_stream handles multiple cases where DC
needs to remove and add planes in the commit tail phase. After Linux
started to use this function, some of the IGT kms_plane started to fail;
one good example to illustrate why the new sequence regressed IGT is the
subtest plane-position-hole which has the following diagram as a
template:

 +--------------------+        +-----------------------+
 | +-----+            |        | +-----+               |
 | |     |            |        | | +-----+             |
 | |  +--+            | ==>    | | |   | |             |
 | |__|               |        | +-|---+ |             |
 |                    |        |   +-----+             |
 |                    |        |                       |
 +--------------------+        +-----------------------+
   (a) Final image                (b) Composed image

IGT expects image (a) as the final result of two plane compositions as
described in figure (b). After the migration to the new sequence, the
last plane order is changed, and DC generates the following image:

+---------------------+
| +-----+             |
| |     |             |
| |     |             |
| +-----+             |
|                     |
+---------------------+

Notice that the generated image by DC is different because the small
square that should be composed on top of the primary plane is below the
primary plane. For this reason, the CRC will mismatch with the expected
value. Since the function dc_add_all_planes_for_stream re-append all the
new planes back to the dc_validation_set, this commit ensures that the
original sequence is maintained. After this change, all CI tests in all
ASICs start to pass again.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Suggested-by: Melissa Wen <mwen@igalia.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 63d9d7ffb103..b472931cb7ca 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -348,6 +348,19 @@ static inline bool is_dc_timing_adjust_needed(struct dm_crtc_state *old_state,
 		return false;
 }
 
+static inline void reverse_planes_order(struct dc_surface_update *array_of_surface_update,
+					int planes_count)
+{
+	int i, j;
+	struct dc_surface_update surface_updates_temp;
+
+	for (i = 0, j = planes_count - 1; i < j; i++, j--) {
+		surface_updates_temp = array_of_surface_update[i];
+		array_of_surface_update[i] = array_of_surface_update[j];
+		array_of_surface_update[j] = surface_updates_temp;
+	}
+}
+
 /**
  * update_planes_and_stream_adapter() - Send planes to be updated in DC
  *
@@ -364,6 +377,8 @@ static inline bool update_planes_and_stream_adapter(struct dc *dc,
 						    struct dc_stream_update *stream_update,
 						    struct dc_surface_update *array_of_surface_update)
 {
+	reverse_planes_order(array_of_surface_update, planes_count);
+
 	/*
 	 * Previous frame finished and HW is ready for optimization.
 	 */
-- 
2.34.1

