Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4483CEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 04:47:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94C0510E103;
	Thu, 29 Jun 2023 04:47:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4391A10E103
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 04:47:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdgvJ8agEBadz/sSYhC4npBPF00Qq5sNMD+c5C7a5i3Q/PU4+KyXYkccxiX5TYCAJDkU7D15X5WJhG1wgP4+TRsOjZHWr3piPwy10Z7F+CgJP20xX0TBmHuGeVyqpfEBZqZsP8CfOrTNsXL6sVJy3gdcg+WAfyoB6CQfMv5gxJNUFaUHrSFBKIpTm6qYakM8Ix+V9RFflgPJTg3MmK+fdzujXW7oor0iI++/efF9APAVYdSDifiX8Ygj1kAU2U1BhEcmqI0ZDy0VtenrefKI7IfDwecx1pKIuhkDTBuj4eEc9SHHbPJEhCyOndbT+3asylz4kdKV1CaFFczQhboMlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1HuTEHWvV1JbAYHzpGf9sy7Q4hiFLXAOn/UBM7gOEE=;
 b=henUn2Hsl7EQ57gHB+UPSrXIFdHhpSgDtjCfJgXwbTOTgSfrc4dcpbcLEl0sYZkofchgknvTS1JIYfTcR+z6CUE5FkfWRBBqSTBNJWMnZkFDn7UST8EIo+NSH+4SFIkRJtjppVk/z7JnVGMAVBC8rQ3N7rAEBUu2FEVKoUuEu8EIPvG209tUFaM8yqYDBYJIXIkkkoL7qZDId87znuPrkgVilE61PfCKxBCQgjZzfqv7eiYWk9IH8HicLHdsyFwlS/1kLJ5nskSJwwK5ioqmcY4lqBlT1BwGaiXAcXsGjr8M3pFACIj8fgkNUMUE7FotRERzw/gGnXvyrIWiBrN8/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1HuTEHWvV1JbAYHzpGf9sy7Q4hiFLXAOn/UBM7gOEE=;
 b=VjAsRkLY/dSv4JTwM4m0Q1eYnKh6+qLyWhhKvAhMHKYOF5CurjARlab3XEu/CiVUkj+2eeI7+s88qDvXBgitiYeGASE8uwt1nD8bt/EzKaFwIeOPGvRGln33cqjvlTeHs91cKJLsccnhLP6+5UO6h/e8KrcCAVZTx8lLNQ8bmeY=
Received: from BN9PR03CA0642.namprd03.prod.outlook.com (2603:10b6:408:13b::17)
 by BL1PR12MB5288.namprd12.prod.outlook.com (2603:10b6:208:314::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 04:46:56 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::3f) by BN9PR03CA0642.outlook.office365.com
 (2603:10b6:408:13b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Thu, 29 Jun 2023 04:46:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Thu, 29 Jun 2023 04:46:56 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 23:46:54 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: Clean up patches in display/amdgpu_dm code
Date: Thu, 29 Jun 2023 10:16:29 +0530
Message-ID: <20230629044635.2266729-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|BL1PR12MB5288:EE_
X-MS-Office365-Filtering-Correlation-Id: 963b619c-2672-428c-5527-08db785bde29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AL3pYhWKwNPnW8L4rd08FnUEzbfb3zpF6Z7r8/uApESYDqabFEQnU6kIZv7qTwlJTIvxVUe6v+h2naEOYiNxH/lr3dirh6O8zUPR0pPMsIlsS0nH5dpLWdRfZc+uF/+534/CViIiAta0L9aWhTjuWZUgicoUM9UUBLZIlk7Ujcc9LtjjtIlZ7OmyXQzbeqv9OXgXCHW3F6ivqCebCp3DvCK2WF3oYC+lDr/zS0FPpFmMdSMcfBQnR9IlsLR85mmm7uJG5oaoIQHgi4kF3sW6jiQp8mbNnRrmhiWdqa6cmA6jt4t5WkFnm36dM9Bl0zvAvoPHQWbdd+BkTLaTn3pyepPdSKmWT27u9VPxlv0jdeA1ydTjIoSS3ollphZ4tHNyqcY/XASMSG/o4G3l23zSdLeto4biDrBbGkJi4dOfKK0LOWx+fqDTkHAZILt6q/DFihfhfUWiLq/+LW3vrOkHYNhGzw6sG6t/T/qp8uv0ea9lnKeHYEoEYsTzN9IaGSVmBTjRppX8ti9QU4LIjXWHBWsSZ+ologra+GQBEeCy6iiTUmfwORCLFRTM2FFp/nmQ4A0FsNGJVQ+WcY/mjHjXSq8JXP4EPTHXSndO18j9g9RAWVKn8gWtsBlao85tk5hl82jZ+7E7v5mY+tNBSypkiNCmZ/vVTuB9at9J5mnvz+q2v/YVV69oDlznILlXudpRfmb4w/2HnyUHYJ5UpaxyGR2kNg5Q7ud2vrQuChLytUzAn7syNWhJuKhLWjYJBsw4W6ej7esEHjN+HGfXyl8l1JOcW+XOj2ivKJctt3c67rU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(36756003)(82310400005)(36860700001)(82740400003)(81166007)(70206006)(40460700003)(44832011)(356005)(86362001)(5660300002)(316002)(4326008)(41300700001)(8936002)(40480700001)(6636002)(8676002)(70586007)(966005)(47076005)(2906002)(7696005)(478600001)(1076003)(186003)(16526019)(426003)(26005)(336012)(83380400001)(110136005)(54906003)(6666004)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 04:46:56.7039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 963b619c-2672-428c-5527-08db785bde29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5288
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
Cc: Fangzhi Zuo <jerry.zuo@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patchset does code clean up in respective
display/amdgpu_dm code.

This Cover letter is enclosed with the below patches:
 
https://patchwork.freedesktop.org/patch/544079/ | drm/amd/display: Clean
up warnings in amdgpu_dm _mst_types, _plane, _psr.c -> Addressed coding
style patches to be put into single cover letter (Harry)
https://patchwork.freedesktop.org/patch/544078/?series=119746&rev=2 |
[v2] drm/amd/display: Remove spaces before tabs in amdgpu_dm_hdcp.c ->
Promoted to kdoc (Rodrigo)
https://patchwork.freedesktop.org/patch/544238/?series=119821&rev=3 |
[v3] drm/amd/display: Remove unnecessary casts in amdgpu_dm_helpers.c ->
Kept same as v1 - so that variable "buf" remains to local to the block,
whereever it is declared, by having just removed the casting.
https://patchwork.freedesktop.org/patch/544080/ | drm/amd/display:
Eliminate warnings in amdgpu_dm_helpers.c
https://patchwork.freedesktop.org/patch/544082/ | drm/amd/display: Fix
warning about msleep in amdgpu_dm_helpers.c -> this is a functional
change - Requested Jerry to take a look at it.
https://patchwork.freedesktop.org/patch/544106/ | [v2] drm/amd/display:
Clean up warnings in amdgpu_dm_pp_smu.c -> fixed code indentation in v2.


Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Fangzhi Zuo <jerry.zuo@amd.com>

Srinivasan Shanmugam (6):
  drm/amd/display: Remove unnecessary casts in amdgpu_dm_helpers.c
  drm/amd/display: Remove spaces before tabs in amdgpu_dm_hdcp.c
  drm/amd/display: Clean up warnings in amdgpu_dm_pp_smu.c
  drm/amd/display: Fix warning about msleep in amdgpu_dm_helpers.c
  drm/amd/display: Clean up warnings in amdgpu_dm _mst_types, _plane,
    _psr.c
  drm/amd/display: Eliminate warnings in amdgpu_dm_helpers.c

 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 50 +++++++++++--------
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 33 ++++++------
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  | 11 ++--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  1 +
 6 files changed, 54 insertions(+), 46 deletions(-)

-- 
2.25.1

