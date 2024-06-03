Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6ABC25B76
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 08:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65DD510E324;
	Mon,  3 Jun 2024 08:47:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wLtOxgFx";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83E7210E324
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 08:47:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Of01yecbaR+y3oqILJX+3vsdlRm89T75ZgpctPo5uA/+wbgCUc9MTPkrgowvT4wFk4SuH2enKwPyX44Erf+grsrPM+efVO2oQwlh5bZVCv6hEV2UIVoN/FCgI2szY6HSvyqWJ1PzT5DVCEez9Rx4QnRV60vZV/YGfhhJ319/OrG93YcTnS9eqdg7U3YxKsa+j7Npge0ix/6OHnpNEFN4wZrH4/4wHekUKDgTZuoMz8bB0wO8gOhau4O7jdx9ilRjf+fZQsw09ZX7ZwDpQ9fesar14mrfaqYCGhzTDsjKeJUHUmXiJ29GvZkCI+MHToUi04hD0E2c3WIiVvQGnP8rHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogSzcjCyyc69s0dcwlJ6RCmxSPpkfND4shuaXuuxAUE=;
 b=NReUwd/MqNzFCVxoFkOz/46BQRDC2SpYH6FvYoMWWGqwkpZKAJqgg37+lbjxfd+Hz1fEYFNtnxBDM2+SZHKw1b0OA/3tCzTL0UeNZxtNbnaK29BxV4GxyLP4Fw7KbSpwxcD0/dgBELn1nnZdwnnvKj4oTrjwP2yrY89QsGwnFBjatOOnmJkGtd1VVOItL76MuuPcuQBjKchvvOmAHk7uys+pdLUOxoIJSdva5bemQAQKGN5FVRvd6N9QOAuRVw2n/9WpsYPn0Ph6DbB1mV/VGAxmbClonPdv6lsNhiuXMBn3T20ATuDtzkiiSpbtFbD2gUAyP/mywi8Mo1mzQ+Pa0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogSzcjCyyc69s0dcwlJ6RCmxSPpkfND4shuaXuuxAUE=;
 b=wLtOxgFxB/eDsrpu5Y2PdAa/sWe8VrXI2ShQznzKu0+xRnkEZVoCQWpw3LnUj7hfqx2kWqZTNTWU7QztcYh5oA4wnxr2+m9keNB5AjhaGDRpkesTvdiupdjlkNTG9i/Hv5oZ3oM2uGeMRF26K28teFsBMMkiDbHju4I7l29fcWo=
Received: from CH2PR17CA0009.namprd17.prod.outlook.com (2603:10b6:610:53::19)
 by PH7PR12MB7966.namprd12.prod.outlook.com (2603:10b6:510:274::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Mon, 3 Jun
 2024 08:47:21 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::ab) by CH2PR17CA0009.outlook.office365.com
 (2603:10b6:610:53::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.28 via Frontend
 Transport; Mon, 3 Jun 2024 08:47:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 3 Jun 2024 08:47:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 03:47:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 03:47:18 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 3 Jun 2024 03:47:11 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, <Tim.Huang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 04/12] drm/amdgpu: remove dead code in atom_get_src_int
Date: Mon, 3 Jun 2024 16:47:11 +0800
Message-ID: <20240603084711.2569917-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|PH7PR12MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: cfbfef69-eb9d-4201-ba0f-08dc83a9c7f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3ZMX0PoKSkMogmG0Va0LSnydP0NyasKoRM3i09aqO23So/C9PLzUzM5HBshb?=
 =?us-ascii?Q?aa89xfKJx5EzDKnQrwWuzEEIsWpvwQNByCr/xDFbf9CpWvzBMlKoAkod2it6?=
 =?us-ascii?Q?2GcML1FX5bbUVJFXG5QPzCBBUYD4sYSSeCiqEM1lOkoDdN0FfnTOFHg5TUlc?=
 =?us-ascii?Q?cO+oQqHLTiGZUi2mBMJEfVUbxv0ljLfIfWEIZEueVsTvFkKexdamtLJO+P62?=
 =?us-ascii?Q?ljzm371S59xfXLb+SbVxAaPrhJPZa1jBwlYvDX35FE1aECxrCgxD4YKm4VO2?=
 =?us-ascii?Q?V0zAGH/NQYzl414WOtaU8BM3ulHE8EVoGGDWJv3EZglV9AHx0rYoszZb6t6v?=
 =?us-ascii?Q?oY17+JrwTmDVarxSRMrNgI82lRDnPmZNgnqR8eWCpOmOuu8u3eOR1LQFQkMU?=
 =?us-ascii?Q?kUXfiVff2WHdv9WWMz598dSbxhsVwT0Ne19vAY9AE716HdkRsZMFIYNxfr3Z?=
 =?us-ascii?Q?ggiUz9iB+fGOggFwKMwfBO8lvGelsCDqKhYe062yVsn8OTWp/1BfCmgZl5M/?=
 =?us-ascii?Q?JbOW5mITroFqpu2CLQpIt7wWYDEDekFL0gJPJDKo8EkIDhn3LDst1FNJBeKx?=
 =?us-ascii?Q?Mkbo4zdypic/Jw+Cz+fK++2dbLV2rt+cfAOOG5oRvGBXhF/GvQnU71lQXzZE?=
 =?us-ascii?Q?TmwAR0zVpqt2AXeC9p6PuN7FpMZGXG9jnx5e2Nrv5w2jOu5JHw9VDztCfuC+?=
 =?us-ascii?Q?m3yG/8E0phVVH033pdaiStCfw2qBhuiZ8+jFAOZ/BUG4XnBluooBguotw9tY?=
 =?us-ascii?Q?3liy12MDZnnDyaYKq2esMIM8PFH91IDFGTwryQwQ/1drMWz5dEsehHLpunal?=
 =?us-ascii?Q?8WFQbBsc60kcHmT4hnavySXc9wAYYwTsYBQo+TK9f8dfpCqIVQKe4jMQc43p?=
 =?us-ascii?Q?LIFVR0VNDSMabJfQarD99LAHbF9zz/9UbiIk6/tOF0FIQE4f0VQO0MBJMZto?=
 =?us-ascii?Q?Vi5We1YVKLAM5CiiFcKfTzUwQutPCqdIF103918N6xzrht22Nl6gKRYMsU7u?=
 =?us-ascii?Q?JZKqR6isj6oBAtmKu7rwarkKc8AXlta/cT3dgXegIfA5+lUj8QUztrTEpXR1?=
 =?us-ascii?Q?TvlkueUOSynk84VPdCtIbF5tyWCmmDI5xjdCnPiJD1TdwKtZZ7+K2/1L1Ks3?=
 =?us-ascii?Q?WZVJs9XuRTtcUEd72j2Vr8hYgO6Zaa2Jc6mzXIHbo/h+bXAVXF9rrxj0Fkow?=
 =?us-ascii?Q?MWIk4PQ/LBDN79mcBBSdds2bSlLIqF0Yyl+l7kbhLlvm4NWBRh8SpJAfVZl9?=
 =?us-ascii?Q?Oy736lBKBWtKveZAuYPVcJtA0RFlHpPewuXPhv7yCaOwrUcrPbU7zg8VtSSP?=
 =?us-ascii?Q?dPtJG9JQRrLVgb45NV18UndKvYfNQhBGqVAbmnsqIC/dtThILWi9XgcK9NmD?=
 =?us-ascii?Q?HbeRTY60xECz3doK62/urTYRQfKK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 08:47:20.6624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbfef69-eb9d-4201-ba0f-08dc83a9c7f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7966
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

Since the range of align is 0~7, the expression is: align = (attr >> 3) & 7.
In the case of ATOM_ARG_IMM, the code cannot reach the default case.
So there is no need for "break".

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index d552e013354c..c660e4a663ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -320,7 +320,6 @@ static uint32_t atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
 				DEBUG("IMM 0x%02X\n", val);
 			return val;
 		}
-		break;
 	case ATOM_ARG_PLL:
 		idx = U8(*ptr);
 		(*ptr)++;
-- 
2.25.1

