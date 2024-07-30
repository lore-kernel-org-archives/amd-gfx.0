Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195D4C3DA61
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 07:21:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B301610E4C0;
	Tue, 30 Jul 2024 07:21:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kZ6lyyF8";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27C6F10E4C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 07:21:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYu3wJ8M39vEMR3HByNKgbHjMbUbtxMrXT5qhNZOQd8aVnboIOBvIecYvpnYc0VuOmrU3kVVN+LPtH9Bpl62jk9hjL3AAhHnApOsvcNvFfwG287yd67Iie5VShBS5r3vuOkGhSTAcIOqMcAi6/CYfdhR/xiA0PZEXYz5L8UImgID7KdJcLEwlRYMloCfu4VetxrfJC3vswYhFhrYPMd1ESpBzjIWIFaXlNQLuSO/gP+V/WQTjfwYNfmvto1cCV2w1qXjxcxHQu30CWD0LQDk350sauapxy8kYxCzhnL+hGsUsaIgTrOS+/jfkjSIGN6jUkLv8GfB8U37SGAH+Qqtgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUlhH/O99v3NNOf4ylHHhG6618PKzkTay5HHxUalHOo=;
 b=cI1ZKJ3SiGdyRCtddXzaiDEej2sC7e65NWyUts24u6nyAIRdWLNrjZqL42XjG2alVA2pOvT19V/LHg7ZNttfJnVaM+VdatE6qpHdkAEZmKmS8SrbTfqFVB7js8X/8md0eRzsUnaZ3DHBJ91rHlijomqej9tpRW171Hj1dpsDnyfAou+InYisoCXPZNS9piXxIl4wqHb6mMvVV2oVhzv+LgTemSE7Wq+LXOB5UB2b1nqzHgUH34PIbEaKOhF83KOKGcUtg99LlmKc5NQKTVuqpq6Sq7syCyxlD+ebZ4KyILK3/gABenSXhvSzWAq+IK1wXxEdgsg5RqKsKkluZZvIGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUlhH/O99v3NNOf4ylHHhG6618PKzkTay5HHxUalHOo=;
 b=kZ6lyyF8mM5B+SXLcUHdaVrkkNijgFIOYW17MQD0+xkS25Di5GYY82QhCOraZ5PES6zXwH4ucBlTUVXDGSxjtbWntrSqIqPZYMm9KHF8ntbaULl9LjXrjTtSBEgfbv99k+MVA7gW/e+ZKGexee8vCNhAzJ/WAijJ/r32Aw1WBgI=
Received: from BN9PR03CA0313.namprd03.prod.outlook.com (2603:10b6:408:112::18)
 by SA1PR12MB8743.namprd12.prod.outlook.com (2603:10b6:806:37c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 07:20:58 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:112:cafe::b5) by BN9PR03CA0313.outlook.office365.com
 (2603:10b6:408:112::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 07:20:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 07:20:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:20:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:20:56 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 30 Jul 2024 02:20:50 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Austin Zheng
 <Austin.Zheng@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 11/22] drm/amd/display: Disable SubVP if Hardware Rotation is
 Used
Date: Tue, 30 Jul 2024 15:18:32 +0800
Message-ID: <20240730071843.880430-12-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240730071843.880430-1-Wayne.Lin@amd.com>
References: <20240730071843.880430-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|SA1PR12MB8743:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a249253-2a10-4578-f4fe-08dcb0682843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fww5NKTMO2ArcyrQ0S58CF8ivmR6EirNPBKIer57fGU4UjYx0Xna0VDdMyhW?=
 =?us-ascii?Q?Wf3G0u/5rYyb68rGPHDu00Y4F+wfKPSJ4pVVjJXGjGjcJYVyIKMYEAu7tInj?=
 =?us-ascii?Q?34AW/C0wuA3+BfA3rVqTsm+PFbIGVQiFUWt+fg4+q58pYPPGfB7Y2T3dOCUo?=
 =?us-ascii?Q?fpppfP9PjEMawhhuyAk9fhEmyQispK0iM5rkv6JZJQbjTxsG7/5vvsve7k5b?=
 =?us-ascii?Q?CX57S7OO184+x590Ojo0m7ixfMAilCTotZlxfKDTBihzT6GdZrxPIPtJMKyQ?=
 =?us-ascii?Q?S1ptmeJFyUw8UZPTtCQgFDaXEIHmlXulPkFD/+vY3wU9sqzhIa54qGoIU6LZ?=
 =?us-ascii?Q?defQkNAXmp7yUGLm06ChAFtfEV14GHnBTLi4MPg9Je7Ptaq+x6p9p/EawwVF?=
 =?us-ascii?Q?VhjOUE5gORekZC7yucyFeCqzuN5z+UYtlVEjig2YjCsGopTB3Q/EOSz5goaH?=
 =?us-ascii?Q?rMX0wlFXpd4mR5Je/G+cgAB7cC4jiTsnMzQKKp0cu+mOiscJ+nFOZ/RRypzw?=
 =?us-ascii?Q?IgebS4oV30SYuP2NXT1YeWRU+Q6AMI6rgOwGvFoIqy/J4ZG/mR8Qmi/Szwzh?=
 =?us-ascii?Q?8KpwEDnLA7nkccBecu2vI1ykAtJs5pdKWyq780H8VS9txb0657N0CBwo73/6?=
 =?us-ascii?Q?foL/EaVkEeRMRuqjO9VfMfHSuC+jgK5AjbCFxHW9NtMlwbK3q4FM2eKRQf6M?=
 =?us-ascii?Q?SZEUE6P4QFF+c6jcVuGxq4E9NPa5w6VyNNXLMi7IXr8LK79rgANFRqkCb6+W?=
 =?us-ascii?Q?3RFoYv9TXVl9nRKvBD067cznf8fbcedtB8z4u0KH6+KenLrWsB8voNUrTbNk?=
 =?us-ascii?Q?huw4th7CZRS/apFtWmOm8956Wxj92zKkIs0i9tUXV0CjSjK4WLqRwDtwH9xf?=
 =?us-ascii?Q?b/LjCNXEkpQIuMxvC3tTh5jcL4grecxtevdj28eiBLgP99uic1QZ/Oxk9EjF?=
 =?us-ascii?Q?Bnauc8sv/VKT12D390MQBsP8/XKpzdtqyG+4xmWDxNgVrq5LdUcOCFUugRgm?=
 =?us-ascii?Q?x2Hq3D+S87MTIDMcBvXT2lXP+KgQV23oGRCMTFkveZP8hrp5GckHW3A/K4Yd?=
 =?us-ascii?Q?+r81mcTdqXOnpOoI7lWN8Y5OeIfAWLAZT+CxYwVd/JIoAxnMMkf5y31J9jwF?=
 =?us-ascii?Q?3Gb0dN+CTtYhbV7NamHxUvfR5RsvOXTT0OcHkfpcAKm0sKl/fzWyTzo9n8bu?=
 =?us-ascii?Q?1IuvJayItOKzzlpLSV8mK5C0TUaBeHfYo7kUwlHmmdUEPY2Yxwk70JH6tixF?=
 =?us-ascii?Q?mtjph5olG/6cxBnXVE4JlEzsxPm9mblxxGYrQuKZdE0HJiB1Vzb+Gnq7TuTd?=
 =?us-ascii?Q?tvOrQdXzYmblmpkh4yhg5qK+DsM7cK46petvdNNilpnJiFlNSbeTvLAs3Vfb?=
 =?us-ascii?Q?qJcJL13Ew2RuPsL+fqhTmI2F79oiYee1y02BX8N4xCBankr3JspwVpw+4vfB?=
 =?us-ascii?Q?NIHZNXAKVQwxpV/CvzwVtdFRV8JbYA+0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 07:20:57.7616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a249253-2a10-4578-f4fe-08dcb0682843
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8743
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Austin Zheng <Austin.Zheng@amd.com>

[Why and How]
SubVP is not supported when hardware rotation is being used

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c   | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index 9331a8fe77c9..9c6397aafd38 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -1058,7 +1058,8 @@ static bool all_timings_support_svp(const struct dml2_pmo_instance *pmo,
 
 			/* check recout height covers entire otg vactive, and single plane */
 			if (num_planes_per_stream[plane_descriptor->stream_index] > 1 ||
-					!plane_descriptor->composition.rect_out_height_spans_vactive) {
+					!plane_descriptor->composition.rect_out_height_spans_vactive ||
+					plane_descriptor->composition.rotation_angle != dml2_rotation_0) {
 				return false;
 			}
 		}
-- 
2.37.3

