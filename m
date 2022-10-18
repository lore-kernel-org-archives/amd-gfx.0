Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F151AC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 12:27:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D56F610E886;
	Tue, 18 Oct 2022 12:27:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 153E910E886
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 12:27:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guZ91H7fiurhMOskKFPs3vtXPadvCKAVMYLRMyKcOHtUvO6F6VZK/ExWSmLwLluhCdY55OD+XuYY/U3bvvw08Mpvl+Hj8E+iHAjavsu3Vwy2CVx2zIZE/yO/iGIMXmeGgVwl5Fk+4h6ILVWZF5nHcroLxrbVk3QlE9tyaMsbnJ6tyxCrcZVFGbmx9NxX6lHxqNoq0jwS3DAqkVs68blY8qiBQe4eeEBK4WgKAnbQ/nthPwYKnof2KGQGQZDBnhUwfRStg0JXPoo9NMox7qJqgHiNFbyE25q9M0TUgiHIAUclwu+Naw8vqdbgO4rvxnBOU48DX0bR2nuHtjUAX178fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVcxn7vcQ/Hchekpj1MpU4nVrd1D02AeB10M938b9pY=;
 b=KUF9+2eUuHzconkzPgpml50X+glE6glDob0DB8DreUNamFEL45X7IN8gU4GILSe8GV7/GB2woQ8BB2niefqvCOFArcQ/1Ait7GQiz72RAT+jazQHLV/7x1/uAKRBFN2d2mJJZyYUoHuj1W2oKP+xwlQoX0Xw8cB3j7NvsquvrPjaQpb+3eJY0QoDFV4VgNljB+D3P95feQg93H0v8Gj20pC036K3QawyIU3A+nvWgR3ztQnmwlCbrtbJ5/b9/NdlndXDWAaeqSsIKYKZvYy1r/9cr0p6dD8s3WYu8XgxsVJr1HLdk1QzjjP8L1+EIrpbkfmUNYG1xLOWZY873v6xeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVcxn7vcQ/Hchekpj1MpU4nVrd1D02AeB10M938b9pY=;
 b=ODV5Sib3dRM1FYSwOJK2tBfkD4sOlV2nj8Tk/IgxIvRnGl+Lv43ZiHHXPdi0Hpnqo0rCGtn/FWHvfWduMelJWGQIuJg0Z4P3P8u4KGCUPrECkDkfkaO6PrghlR3yguuBtv9X4wm3Q/PrpuFizvF62BlrFlVTtbMRqsNCJaPG0XE=
Received: from MW3PR06CA0022.namprd06.prod.outlook.com (2603:10b6:303:2a::27)
 by BN9PR12MB5131.namprd12.prod.outlook.com (2603:10b6:408:118::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 18 Oct
 2022 12:27:48 +0000
Received: from CO1NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::ae) by MW3PR06CA0022.outlook.office365.com
 (2603:10b6:303:2a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33 via Frontend
 Transport; Tue, 18 Oct 2022 12:27:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT102.mail.protection.outlook.com (10.13.175.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 12:27:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 07:27:46 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 07:27:46 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via
 Frontend Transport; Tue, 18 Oct 2022 07:27:45 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 00/12] Update DC commit sequence
Date: Tue, 18 Oct 2022 08:28:14 -0400
Message-ID: <20221018122826.1790114-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT102:EE_|BN9PR12MB5131:EE_
X-MS-Office365-Filtering-Correlation-Id: 05cfec17-c446-4cab-0bd9-08dab1042a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /9xWjxTQw/q63depyJt/6FoazZ+iVsOGw5i4Eg2kE3Wsdqj+PXDcd2X2WFhwTckcLtVR+voHtvhDpq1tFgCNxPzS8UHUyGyFqJW9oS7dvBQ9qy0/PntzmLmvtAlQvOwR3YMgXSgmAK/jVd9ZoetvXeBd0wrfsUHC2dX0u0SSKUJHiu+el7N+d0tVcniP6xkDUvj+MNydjPiVwi8FUKpy6J++Sz2dbYxnkIi2PSCAUjKsXPNmTSO1oNi+v+uZXzS/v2gSfVric3jvabBuXUd4kouPBlpVvwD8riRla2iEVvOO5tZ6q+CMZ2A5sTQainufLw7ivflVZ9IbPKc1PvyWjg2IOaVh7AXLa0yIBFYy2v+SLngAuXPf6iUKN8MyU/Aa+TJSM5LrKbtJsNBAFskLh18wt3OIRJf2mQZ8244TpDNt2gbvNM8g1FUW3jBA2dI2w2xdTsqsbwEZMx/wY4/wIuN0zwSHiWgg2esZ05jgdjND6osT7j1e3/nU2DxlfVVehkMp4yhckwjMQBXxwjNwpG5feSdCCSUwFiCX6Y2lyKMXHG7zuHZykOMe7ovWFHwU0/TR5ocawdTD0gIgCIeOTFITIxyfV0VrwmlNZTnry7xPC0haZibV2l2C1IXT4kzoBYeJdlZUvZfYNQiQAWzriW+vAzraS29JGP8hyEjUQEIzauDN8dfs+tHrL6+dEtp9mK5IQF8E3X4FrDj816lbwXdW/QSQQwU/np+DofUF4gfjBKQLACbCNRBP1bxsbwkdqhOU2/kFNP3eUhDoQmjMBpLUIo5vM0NxHmLX8pReiWpvOObVh1oBXOd1l9sa/Zpp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(46966006)(36840700001)(40470700004)(36756003)(47076005)(8936002)(5660300002)(82740400003)(81166007)(336012)(83380400001)(356005)(86362001)(426003)(36860700001)(26005)(54906003)(6916009)(40460700003)(6666004)(1076003)(2616005)(478600001)(186003)(316002)(40480700001)(70586007)(4326008)(41300700001)(70206006)(8676002)(82310400005)(2906002)(15650500001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 12:27:47.3969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05cfec17-c446-4cab-0bd9-08dab1042a64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5131
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Year after year, DC adds new features and expands its support to
components already available for multiple users. As a result of this
constant growth, we start to see some issues associated with the current
commit state, which is a little bit simplistic for DC needs and lacks
robustness. It is time to expand the current commit state to represent
the DC organization better and make it more robust.

This patchset evolves the function dc_commit_state to a new function
named dc_commit_streams by adding a step-by-step change. Current,
amdgpu_dm tries to commit a validation state directly into update_planes
and commit_streams. However, we want to avoid committing the state
directly into DC; instead, we only want to pass streams/plane pointers
into DC and let it manage the commit state entirely. This behavior is
more future-proof because it keeps the state manipulation inside DC,
which can benefit some specific features that might want to play with
the context state.

This patchset is organized in the following manner:

1. It starts with some adjustments in a generic function to address some
edge cases and a function rework to enable the transition for the new
commit sequence.
2. It adds one commit that duplicates dc_commit_state into a new
function named dc_commit_streams and a code patch change in case of
ASICs based on DCN32x or superior.
3. It added a series of commit that expand the dc_commit_streams to
handing multiple scenarios.
4. Finally, the last part of this series adds patches required to make
SubVP work as expected on DC32x and above

Thanks
Siqueira

Aurabindo Pillai (1):
  drm/amd/display: Move dc_state copy in commit_tail after
    dc_commit_state

Rodrigo Siqueira (11):
  drm/amd/display: Check if link state is valid
  drm/amd/display: Rework context change check
  drm/amd/display: Enable new commit sequence only for DCN32x
  drm/amd/display: Copy DC context in the commit streams
  drm/amd/display: Include surface of unaffected streams
  drm/amd/display: Handle virtual hardware detect
  drm/amd/display: Add function for validate and update new stream
  drm/amd/display: Handle seamless boot stream
  drm/amd/display: Update OTG instance in the commit stream
  drm/amd/display: Avoid ABM when ODM combine is enabled for eDP
  drm/amd/display: Use update plane and stream routine for DCN32x

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  17 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 122 ++++++++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 234 +++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  36 ++-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   4 +
 5 files changed, 384 insertions(+), 29 deletions(-)

-- 
2.38.0

