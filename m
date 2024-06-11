Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFC4C27C78
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A4CD10E6DC;
	Tue, 11 Jun 2024 16:52:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Uezab+tl";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE9A610E6DB
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isueLsXHvI5UMGIctk9qJjQzGAKh56lSYMfdUVTFGJZ7kg79WQKXUGvIPZLEaMJQo7qvDjhts90FCxQy4pZTtc+wyKUlszr9Mm+ARzfX89e/Nobuxy4SnqwpD7o1Zbx47kKxz09I5OsqnBCBfdegYQ9XRArwv43IFp07QZpEvx29AILX3B3SxCT4Na6vmtJWiRG44vdsTI+QrzEdr960AuVN/Lla37ueGSye0MYoQQfZQtacNxXYu5GF3jX8Nb6x7oU2HG6NxZjyErsUgzpdrh1Iyc7ZPXGgB8sFXBPMaSjEFFM1gZCIeVETlam3kvGWon2mg8MoeGgbWWZK5eZqPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ah8+xTFnUYD/Mz4K4HBM+yRFojHOi5bx1mkLRcSVTmo=;
 b=IaytrnIaZGYeQN0m552TH8bRnNotHEBoI9U1BWnEasRM1U+IaQagqfrKRwvQSipE8NucF6u8o68U0P+hb7jODnAdVQZutOgGwBAedT3uut1DVXCgdwm18gtJZJ3KWHSbncte+xrZmUaBekp2SBGgIdml2Z5+GW5Eu0C9Nl8Y2iyEwas7APGSo08piWDAXXXqRvEqt1P0QTO7eYWd2VOK3wI+ZNlAJAuo+yDAFpdfccPV2Lvf5Eukfwtd2E9jjtvic8Mvl2xew2NUYlhUIaZIAnroMqlArPkVsVG/kzo0SMddEXECENQWCISH22z2XJ+YwCkHTLzoXFbGYpyGXhU1Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ah8+xTFnUYD/Mz4K4HBM+yRFojHOi5bx1mkLRcSVTmo=;
 b=Uezab+tl5L/+w9EaTOHywGRFTHqE/oSz/0CR3q/Xt7ZDtqQPNEoyZQDuMqpD5NiCdV811rYUYUpWfvhf5y1Ft8fIdIHrR/u2qPontfVSt7CqiFvdoCBVuYOKL0GhYoaSYUiVi4G904rnl8qYJse3Xq+Ok1fAapm5afpQsgRW3n8=
Received: from BLAP220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::25)
 by CYYPR12MB8730.namprd12.prod.outlook.com (2603:10b6:930:c1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.38; Tue, 11 Jun
 2024 16:52:46 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::18) by BLAP220CA0020.outlook.office365.com
 (2603:10b6:208:32c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:46 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:43 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 "Wenjing Liu" <wenjing.liu@amd.com>
Subject: [PATCH 26/36] drm/amd/display: Improve warning log for get OPP for
 OTG master
Date: Tue, 11 Jun 2024 12:51:29 -0400
Message-ID: <20240611165204.195093-27-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|CYYPR12MB8730:EE_
X-MS-Office365-Filtering-Correlation-Id: d8647d24-1894-4332-114a-08dc8a36eb5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8fcJk8oxmlEL1UYauT8eNj2gNzmPTMMHIXkSeUupDKgc7noV9i1ANbjLXh+L?=
 =?us-ascii?Q?QAKjiIe5hVVx197sRf4unYkkuit19njmWSd0yRulfW4wRVX4Z7OZwOPYecNp?=
 =?us-ascii?Q?Rn2UQhdIBtIy6T2Z24rJhSvwIODq5ZwM+6rApOxdLB54bfp7ItjhA+PDtljb?=
 =?us-ascii?Q?W5INfyasYBFHQt+TSY3j1ptmz4UV4ZNYAxieugh23RWkEdKmtLZsnq1Zv3XM?=
 =?us-ascii?Q?aXK7E99CdL9g4l3HTkA+RBNE805uhAnhDC5AXX2LYULAgMRKZi0eK18kEFqF?=
 =?us-ascii?Q?HcwmADxwg/iDKX7Lyqki95QdOMKjfk6WyNqg8YTpYXsXCnnhoLjYDOtpv3Jm?=
 =?us-ascii?Q?x26XkgamqOVtifCAnL9RXv0ktGAa886J/EjjA6UcaoxYheS7PK0LOY+YfsLF?=
 =?us-ascii?Q?voDSfq8qzKV0LMWngCpTs1nj9cXMwpRQpBU+jEcB8MKPQmJ+va6Uo4SXsfn7?=
 =?us-ascii?Q?i/G+SAuOXh6HvjeUmT9v3l1zGhyvAXGGgv1ho7c19y/tbK11BZR+EfZ8u421?=
 =?us-ascii?Q?lFJuyJz+T0UdDVp3ITijLqhvQTX2JfsumvOuy3NYxNLSpbyFUvA9EhpQ5Hfh?=
 =?us-ascii?Q?uGRZarD3fv3s/xEJzoQCJNBFb3V7QnQ7xJudpsp6s+mU1w/aPONslQJY/UWK?=
 =?us-ascii?Q?rOxzQGvDjdQhnB3L2PiCx8XAkSOBLwLCPUorKtmyNdNafXWw45Rl1zYJg5JG?=
 =?us-ascii?Q?QlQmqdBARphdE3h+oMzzfDa35Ql0+ePj9gQetRFR2bmrU9EaTjC47b4SFwdY?=
 =?us-ascii?Q?kV/V13OkFzzoyjj8pOiLj7FFkN41j22j+wqh5mzsSNIonkNj3vMON+fhq96J?=
 =?us-ascii?Q?Mw8e28Ot8kb01vXhvP/FQ6d0MnIKMSGUzqisSlgJB56JyfIkpoRtDdDYQb+X?=
 =?us-ascii?Q?G18JF+rVDid3Dkpv9c0I2KEqIkl9NOr21jGPERHPz8j5WO4DwSDeT+A2APO2?=
 =?us-ascii?Q?M/FLX5gTGPGe+vu1p0o2784bbhFpLtqUrOYmkIdRj60n746gRwAtlSu53zqr?=
 =?us-ascii?Q?jJbEJj3qeG/6Hl7tUbXaIBGv5RBO0S/56XC9qAaHgz0XcKZ1dJzjyVT+0ixw?=
 =?us-ascii?Q?xE+6SnZG9trz5C1VHf8zca35jquy+XbhC3Pcgz0zuQHTaYolI1wJ3OwpAMq7?=
 =?us-ascii?Q?M8skhnVB/CUpe4ntMMN4VaT4xQUmE1GzoU/Rq1Cx5iD2IDFIYnw+TgDWV+wx?=
 =?us-ascii?Q?X4JagX6uqL1FgjlXTkgNrNXL2rWlAeGdrIkMPpfvmdvlP6KydEhZRMxEBzQ8?=
 =?us-ascii?Q?c47+E4vABpbekpBGsHvEBDVJd7jxQf7u9WX2xx04PdzFH2PMtWZzcIrOkTM2?=
 =?us-ascii?Q?touSHVddBx/OUJxfFp/TWqLvowCZmf+PhqfjxEKe8SKZB4LGuzYC8CvtgUw6?=
 =?us-ascii?Q?H2Ge742eRa0e/Cl3BSRTDrJ8Ebm9BhrgNt+iWoivP0cgh+E+Cw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:46.0558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8647d24-1894-4332-114a-08dc8a36eb5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8730
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

From: Rodrigo Siqueira <rodrigo.siqueira@amd.com>

If some part of the driver tries to call
resource_get_opp_heads_for_otg_master in a non-OTG master context, DC
will trigger a dmesg warning since this situation indicates that some
configuration associated with ODM slices might be wrong. This commit
adds an extra log to describe why the warning was triggered to make the
debugging more straightforward.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 87e84b0a3d48..1cba8f58f1e6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1917,9 +1917,15 @@ int resource_get_opp_heads_for_otg_master(const struct pipe_ctx *otg_master,
 		struct pipe_ctx *opp_heads[MAX_PIPES])
 {
 	struct pipe_ctx *opp_head = &res_ctx->pipe_ctx[otg_master->pipe_idx];
+	struct dc *dc = otg_master->stream->ctx->dc;
 	int i = 0;
 
+	DC_LOGGER_INIT(dc->ctx->logger);
+
 	if (!resource_is_pipe_type(otg_master, OTG_MASTER)) {
+		DC_LOG_WARNING("%s called from a non OTG master, something "
+			       "is wrong in the pipe configuration",
+			       __func__);
 		ASSERT(0);
 		return 0;
 	}
-- 
2.45.1

