Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CDCC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Oct 2022 18:12:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A66D10E652;
	Tue, 11 Oct 2022 18:12:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24FE210E470
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Oct 2022 18:11:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEJPeHgQhrMywnUb2zonnzIudEhOp+sNK2AvwKF9U76gxfBH5R3jkm/xfx1i6OOOTVfwcYZE+W02dDtQsg4j3m4+BLX8+18W0J4XFvTAK1g8NR75kdo9Ug/b32c8ofJ2vw/I/dy1ZRYi6zOzXJcbBJJT8Ko/GtvJhySKcthS9OnFlHF16Jom8Tw+oIHaMmoL4EKXFTlYFiP2vZZdTOE7G5PEVUvVzzcH6QpBU8ktej61MohS7kPwNjRDlVfohgJF7GQ2OF7zhSciPlmU0wyhkoQELvptstv6WKt0iUQS8eFzrul58freh7zKqANvTYlaVIA3dM1wOsvDmoLgXhrPxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYcahWaDI4AkWMk2UixBV8UD5nZ5/2tXD9DqkiGzm6A=;
 b=fSVyVQGQynLqm2abLjZP+iQRMY+/QYbvA5yaTEWiGYypdXwRVDIHnwzQuJhyTev5omNdpvUHCz7bW77k4pyPOyAWA6Yyxsat6XM/TS9Z1hj3/EfWKD6SfVEmUeKGeScOZpJPWo+HgRpfcnrDtg80LddQv8gjM7/8p/omYD16vOpj4As0uz1JykY/+tO5Lk1UeTipUyAPfW3tSNjNktPmWjZRcAa8YXHVAPov0vz5qWmVGNyMa9eJA6iZ26r9yA35XjeK3EyQEP2LEhfjQRVokRF15P3ExcnUeUbx/PwQTtI0GiQKuvg64qgCyG1Io/7RUtE3x2uFOUszCySHT4I4yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYcahWaDI4AkWMk2UixBV8UD5nZ5/2tXD9DqkiGzm6A=;
 b=iXqG0UNxrqF0kriIiNXVXFtZxhel79vTXZFBoHm1AKvqdpKrWlIY1I6jGcXZJVud2wMY8RTUVhploRxYSVf+QrCuCGDO/fpgVVwv5bBOxSVR5e2GLeHno+UG//i5Qm3wsHMi/NhpSGCH634G9nxyf564DGS0WupWI0hYFITGN/M=
Received: from BN9PR03CA0352.namprd03.prod.outlook.com (2603:10b6:408:f6::27)
 by BL1PR12MB5206.namprd12.prod.outlook.com (2603:10b6:208:31c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19; Tue, 11 Oct
 2022 18:11:52 +0000
Received: from BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::cf) by BN9PR03CA0352.outlook.office365.com
 (2603:10b6:408:f6::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21 via Frontend
 Transport; Tue, 11 Oct 2022 18:11:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT097.mail.protection.outlook.com (10.13.176.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Tue, 11 Oct 2022 18:11:52 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 13:11:51 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/3] Update DC commit sequence
Date: Tue, 11 Oct 2022 14:11:37 -0400
Message-ID: <20221011181140.94595-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT097:EE_|BL1PR12MB5206:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cc65995-9316-4772-5f0d-08daabb412d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FTK5gZpTG5ctyXTaN578e30GpdiSZUm+IS7HwzyV+gsoRhVWiUIdSewZb/KoQuKJ9QmlJ3Tm8xTajneXoD5Tn7F8KQ0Bv4yKCZwWbR2f9fJRMHL+IdBOpGSZae85d4GRJASVnRbFc9ls+nF9KH/Uh42MAUwF5goGYakRPlwUGdX2KMdlKTRjUyq8LcWkZef8bOg+hJKNoLplBV3NaIJJw403eMGZNEpNCGyGt8l4MEZJ5X6pfdg5RBwkR8AYW0ddWI+kY+dU0uQYYgYUlCUkp8HEZMLj6LOxHRqi309B6ZOqkd9PSlfdlYkD6fNPMo43dkW+4IQI+EhT2qNM9Wlhuqlz3U5VBj5zlyaMxW+Dk3u4kNg05LMwMQFzinK6ZA5P36oKC4yDt3sHMEgZA0QuAp6iUPOSTUIirmn13Ff96UNvJLMAcgybn5dgVs0XlSaFONKvBQ/T+AgPkFKHgNMBDCA3ACuhNLqJ4d7Tqjb8GielnftmbCK8eYCiTAIqpzGCNs0j9KFTa6r80Rx4++bGbS5QvBFweXQ3w4RD/LnGaRqzm1+m5PQypCSwnQsEDZgAr2Ou077ic0SvbSr+FpACJNJfMJPPFxSi4Clslk9EgrQOYzgw3p+ZTAPtdyyn6xVpfEv6d1/rIB3WuQ1y2jANjy1rE+WkOYvwyBui0wkt78fJC1nBGaVr+Vfv4cBPhXw1wEJYds73YznSY/hzhZfCXT7FeIgF+nRXAM3ebDztnSDJRrtfZAF4VOTnG8rnFujSIM71UL464mZbPXUQPrpUuYjIQbT6oolVMEX/NVzRLya0v6IRdgVU9rTNX+a8o7p/LW2OM7izdbLPG+zKc8EHnWdw7ny2wOSrFSz3fd9OCH0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(36840700001)(46966006)(40470700004)(478600001)(54906003)(6916009)(316002)(8676002)(4326008)(70206006)(6666004)(41300700001)(26005)(5660300002)(8936002)(36756003)(70586007)(7696005)(15650500001)(2616005)(186003)(1076003)(40460700003)(336012)(426003)(83380400001)(16526019)(2906002)(40480700001)(47076005)(86362001)(36860700001)(81166007)(82740400003)(82310400005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 18:11:52.4051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc65995-9316-4772-5f0d-08daabb412d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5206
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patchset introduces the basic infrastructure to change our display
commit sequence to make it more robust and flexible for handling some
display features. Current, amdgpu_dm tries to commit a validation state
directly into update_planes and commit_streams. However, we want to
avoid committing the state directly into DC; instead, we only want to
pass streams/plane pointers into DC and let it manage the commit state
entirely. This behavior is more future-proof because it keeps the state
manipulation inside DC, which can benefit some specific features that
might want to play with the context state.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>

Aurabindo Pillai (1):
  drm/amd/display: Move dc_state copy in commit_tail after
    dc_commit_state

Rodrigo Siqueira (2):
  drm/amd/display: Add functions for new DC commit sequence
  drm/amd/display: Enable new commit sequence only for DCN32x

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  17 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 108 ++++++++++
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 204 +++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  11 +-
 5 files changed, 333 insertions(+), 13 deletions(-)

-- 
2.35.1

