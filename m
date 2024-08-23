Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59767C5320E
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Aug 2024 00:15:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0560B10E13A;
	Fri, 23 Aug 2024 00:15:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qe2bCTmy";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0684510EBFB
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 00:15:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqoZm83NZU5alEr0UbnqkFkdZA+brBtpS3HPQrUAXxYwMpp7CyVt9Xk+8RL88JsOAAvXaMOq34hIg1HO5MOzGOYFVFbdHR+LVkqO8x7ij1CtP11pbdKmBEZEoq2GpyAas8tD4nqXortNBNRGT3vVkHUhijgx882iZwc5rwn/uOLvuBT3O5re1T+S4T9rbHYpzLYtj90MhADnViZo0vX3FOPH+D7VDjgJh2tDoxCmtWhv+XbGl8Wcaut/5hxHLx01KAlPEJLFhmpy5ISIouZAsTppgtCtl1oGN3fymMuMADYRbR3dyQL6uE6ML1+kYaLdvc2zR34raOKhyoWapsgKOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+NXhFFaEsed2c3S4CfYd+HxF59PZbV43UYUGpkOicg=;
 b=uCYw9ok50tUngIQeEBcixBHxcjWDoW+IEhkBOhaIm5buH/3wVpy4g7cYJTZ3s3kqvUSgHpBZYetloZO0xUDHHMGxDIHHFtYhuiuH/Fi/S9lkDMYIYDAIFBUf0DwVApVm4CYxMNv3Bh4daZGy0VdUBAsZxBRXSLbhnZr8LZ3Jy+MliD6wBJWHXk4g49/qdOF09tguHDL7e+gr3jJh3k36bmVyMgvsCHhSXoKc9AxTDA2vImfCKnySIPTFxNDUDB/0V/yDHnw9p+vpmDFBVnh7bljrCIJKnEVd6Oc2JxBqtLHJtNxgAS9M577g0y5e0//ympNK5uk1YQe1GftcTeYviA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+NXhFFaEsed2c3S4CfYd+HxF59PZbV43UYUGpkOicg=;
 b=qe2bCTmy5vWntPHUm4Ask7dMnmuXCP1vF0cQ4TLox7/gu8+YayoM9BQBMHv1s8w+nZSe5WDXec5to0xt7Uri89VTpxhRdDJwFwlyw7Z6+f+BDJBU1tt0Lsz4I1X9LIFB7ouuOyDAIl3CwssoTQBGjcApzHrxj2tUJQyUoxYssxc=
Received: from SJ0PR13CA0029.namprd13.prod.outlook.com (2603:10b6:a03:2c0::34)
 by PH8PR12MB6721.namprd12.prod.outlook.com (2603:10b6:510:1cc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 00:15:17 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::b9) by SJ0PR13CA0029.outlook.office365.com
 (2603:10b6:a03:2c0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Fri, 23 Aug 2024 00:15:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 00:15:17 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 19:15:15 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 0/1] DC Patches August 22, 2024
Date: Thu, 22 Aug 2024 20:14:52 -0400
Message-ID: <20240823001453.1845297-1-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|PH8PR12MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: 10bcb5b5-67d7-4402-23ac-08dcc308aaf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pgOCv066386UTZUvkoti1E1JpoSKVom5gOpOf2VmoeEL+o6rjRp7oInehbLk?=
 =?us-ascii?Q?LQlOmqHlTPOB/v+52jdin8QtfbNqFFwMyZzjdspJ7fIRfZesdlr381kBMKQP?=
 =?us-ascii?Q?0PalK+CK0D1/+bYozDE5OFNWxme6PoYQpEXWgWYVq+cXfE/flKZBOcY7h95T?=
 =?us-ascii?Q?O9Mx5Hh0+l8wCrnUEr2Uhg5GF6csRzO0/eVm1OgMNYP1DKrVKWCg0VUhxa8p?=
 =?us-ascii?Q?yGpfha/+3SaL35DuCRIbFG/oS0hdeGyxN/wT5bKDSSuKpYXwwZllzyepOQxx?=
 =?us-ascii?Q?RoQdL/TmC2r63VNZDfaNKkYxMFmVBGO2KN9ISZvZLpt0hPRxq8rKBK05JQFZ?=
 =?us-ascii?Q?730GSP1j01mFSIZbnwvAYLlDU09m2qqnJmaxX1u/sLMq2PywamOvJX1U/lRh?=
 =?us-ascii?Q?ig12ttgp8SXLR65o3Sfrgz/RF/+Yj5IUK3Rb9ZcSAtE3thtfAlzJI55m3Mc6?=
 =?us-ascii?Q?GKtXhEcYkH+I1Qe9cuBU5emqrRxeNFinb/t8rdroh2d9du4f/M95YzXYqpb8?=
 =?us-ascii?Q?68UQAGOYskYdNCpPeUQRXUtSk4FcmGLRFcEcXViD6gptKhPyv3lfHyIs+VaV?=
 =?us-ascii?Q?O4L+tfrCp9KZs84eBfFMcUQZiz83tY+UJmmi+I2h2jMWtIm4OXzv+9tSdJFA?=
 =?us-ascii?Q?6FmyvRwqJqZBMktVnqgpWkLQALoQpQcKpsHCxWrtb4KNHu6i7xa60+kE25P+?=
 =?us-ascii?Q?Apmth6FLvrnYz7W9bGx7PILzg7Ef1bDX5r3k9/x7pnFZZfC4RzMLN0iT/3/Y?=
 =?us-ascii?Q?5+NTHiqZC9gonKYeOcjuEAFhdskk0KtogQhnQUgvak/y910Fx/8AGNO2lGFr?=
 =?us-ascii?Q?+LLCgnrfnD6HDfKoMCkLj8pJa2FYebaH/QEGQLFTHvApy34PwtO1F7TBKezn?=
 =?us-ascii?Q?HzwV/gvBBtWuKVKlJVpgmi3uXfx9DmMUY4Vx1+ORi4MOvpT0m68OD3YkWaP/?=
 =?us-ascii?Q?f3NeQPDV2ASEI7OScjOGfj0iO5AYdguiPFIqAbA5KfwrbPLhmqD7NmPGCCUj?=
 =?us-ascii?Q?AORtArCzfWRoPF73RyYxN5o/uDI4GMLYRVPDd/4tiFZilLlx8kIuCSQMbz2U?=
 =?us-ascii?Q?6rOEvTmFFGY3Vww6PYosGZSP77YODQtqUYpsnTcKLVz0xj8CDx7DjrhID+w4?=
 =?us-ascii?Q?zl6RFy9WHhcNcYf6UhkenNw7BdCucmnKnC/0vu1bP4g+7Gpqeru9hWi8tHc/?=
 =?us-ascii?Q?Rh3mY9svkKqi+KRXus3W0YDMYedlCnHqL22ceYUkK4UqFPNjSqIbA2GWhfSa?=
 =?us-ascii?Q?tGB0C380VCVKn1MSUkTKY3BgJo370a9deAFDqqZaSJasg1zsoCObJdKZR3Rr?=
 =?us-ascii?Q?amSdnFmA57crxclc78hX868MeMG7VcxYvh5xzyK3bzfaLOGhsYr89YiRiU91?=
 =?us-ascii?Q?rDZn9/nyxcDEyWIYDYyOEl1NCkY68kRyLTGvKsEpolBKz09EbS6yZc5uow2a?=
 =?us-ascii?Q?Pol4MZmjm4ngxyJSxEPXc3N1SPZ/Vg4c?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 00:15:17.3824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10bcb5b5-67d7-4402-23ac-08dcc308aaf2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6721
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

This is an additional patch to be included in this week's promotion
series:
* Uses SPDX Copyright for spl_os_types.h

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Zaeem Mohamed (1):
  drm/amdgpu/display: SPDX copyright for spl_os_types.h

 .../gpu/drm/amd/display/dc/spl/spl_os_types.h | 29 +++----------------
 1 file changed, 4 insertions(+), 25 deletions(-)

-- 
2.34.1

