Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73634EB64DD
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 04:42:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ABAC10E078;
	Thu, 29 Jun 2023 04:42:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5D4A10E071
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 04:42:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USb/pzd78apyV3QWanlptzlfWqaEKERALkTAZ3//BAIP8+aSA/IA0odLIkNfl3EiY9VWu5az8G1/ht/qwQsdEsZtHntUba8vvIx+Le3FU91x6BqbfKR9l8EQbsER+gpPugK+yL5N28qR00zFq0fcNyEDGQe3tzrLkOuTbQdLUd3yoF6dw/t5AmEqmA2G8z4E/PzuclVrsu4ocWe/rMpXcO8SQF4w1Uix5Z5GgPrVt1vyFaQF2TOu+qYaf7VFFcYMjZKqYdyvRZxQ1HC1ucUKsdW9cBKiUjaJNoO5Se/6mnQFJ2Gd5osuHPNdBnjLhHKRhPpVhKgzfHFCb8Au+28WEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1HuTEHWvV1JbAYHzpGf9sy7Q4hiFLXAOn/UBM7gOEE=;
 b=VFRSBKtVNmsF+ZlcP+xY1k3atrLSQjY4AxnLkvroneANqjhpgl6oLlopP7uSlwduX6S5yktpYvk5/Ek9eD2/upGm/W8DITGIYPIy1KfA9G/RoDRt4wSE7h8CUo0kM+j2NxwF2fJkMbeOfjbRtCNZJXcQdiu7Y6HBW/affJj0pDt9qjUuekaoG9HfOmBhTdbV44+/5ZQ0BTeweroQXuuLu14CBqaBVU11A7XMNDMIf4pYj1aics1HD/QgPM8uiOeZunM1y4MnYx73znCfA3g5MM+ISRSJpR7draUB0H57/6UBo37XNEzOVWFPWGXLCp9zW8s9qwItSug42/kcHQlPPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1HuTEHWvV1JbAYHzpGf9sy7Q4hiFLXAOn/UBM7gOEE=;
 b=IcwHiz+tMwNR8zw8Dk7DhJNBJi7ljpqUOzqhkxGgdXKMcTpH3EkkO7aNdK2M8RDj8Atb8T80npeuJNpBBwwKSuj2lGOzXEyP9CprTsnrYe1tcC/oIb0MuAF3+5esoFjlRj9zSAyUWm4waEuATwgotRYPaOZnIXpSLN3ZgXLop2c=
Received: from BN9PR03CA0289.namprd03.prod.outlook.com (2603:10b6:408:f5::24)
 by DM4PR12MB5817.namprd12.prod.outlook.com (2603:10b6:8:60::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 04:42:33 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::47) by BN9PR03CA0289.outlook.office365.com
 (2603:10b6:408:f5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Thu, 29 Jun 2023 04:42:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Thu, 29 Jun 2023 04:42:32 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 23:42:28 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: Clean up patches in display/amdgpu_dm code
Date: Thu, 29 Jun 2023 10:12:02 +0530
Message-ID: <20230629044208.2266584-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT067:EE_|DM4PR12MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc228a8-55ad-48cc-c5b2-08db785b409b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VvCXvhjM7EoUtiyOygUmsnZygesnGFVppaT1q5YbcxcCkrDLjqOkM1RECHQSdSY9ltLNf46HFkHH0EVW8Heb7syPepph0NYhjYycbCkkePd2pObUrjm0Prlt7Qc4m+1uFqOwYTX3wHBpPC4sEkFlZvPzsQkbI9fmOkhYvjAsU2gcaDf2SY0UVRn4wjkMLmMYARMRg28I34fIHaEc9OZ3pCqlPdGs/zah9Eb8ykJsV/y9RbjXteTmz0ga+uiD25qc1S/o+Yqq2edDp8eViFjPHPQkB5J+YJja/6wYL4r8i8txUyqCsOPRvtYt7UKG5tOkoUP9E8e+KV3R70pm/czxB2WMpV8nYsw/lJlw5wEhljWhCntWM8LsGF+AVxyAZz4q8PRtNA4kqGx4/8rtYzycuu+qu+Nk4fZIcIdd0/CHFHIePd3Dx4ocnv51UNDNeJKPQGk1CWhuHx3DshNJ4B6J7GbaPwM9dRFtpB0XD/3SAT5AQFbQyAiQ+d/Uz/Xc2qlgz3rapexPz5byUCwfK5KzsMwPAweILBSB2NixZcxiiuAjf86zHkPTZ/jIHY/Tb6FQFlsOOgp3DKROF0HJ3dw95rS+xrSMUL8mwuGrpIo6WXgp4zFWIdrbyx7USyKTdA8KjYa+47SWiWzYeFS8X1HE9hHFWkIDVeOI12GfCZuA49hSDZZJcaQyGJPdpYhCWUCQ8vzMrkkNdcYlRTRT7+Panxzzi+RkRWZKSewypsQXeEmphcql/Vn5F+aEVdMJzkMw/Encb2XDJuZ95uKuQKPcUnXjWv7wb/UVsE5JBCrfF6o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(5660300002)(1076003)(44832011)(70586007)(316002)(478600001)(36756003)(4326008)(70206006)(6636002)(8936002)(8676002)(86362001)(2906002)(26005)(110136005)(966005)(54906003)(36860700001)(40460700003)(41300700001)(40480700001)(82310400005)(6666004)(7696005)(356005)(16526019)(186003)(82740400003)(336012)(426003)(47076005)(83380400001)(81166007)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 04:42:32.3896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc228a8-55ad-48cc-c5b2-08db785b409b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5817
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

