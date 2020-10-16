Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59534C433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:27:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7437206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="q6divAvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7437206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA35B6E1A3;
	Fri, 16 Oct 2020 03:27:20 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DC4C6E1A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:27:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGfhcNqnrVYh8BVgK1MAMenaiuMr0v6FofQmExUVRUrzSuE6YrC15LlZ3bDeKJFVp9EO8W7H2TYF12V6mojF2MCCDzAU72d73CGr6J5NSrNfrCDaqWe1W6p6yoUR5Dg4+GwwXIm9c5iFcXNKcQGhatZmESgLVh4D6fGjIheWeuH6+NY32/06gKXXDS0shXkpR2SBR18nyPjVr2VB6LkH+jbuggul3n73RuEHu7uq+RTIaZMxP/hATVniDjKCma8mAdvydT6gNs4HRYKshQG9xzfPcE4fw71OYkYpesD2F9dmr53EsIWOwgNXALzKZV98ka6uJgKPI4rkv1ZYuNRFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMatBhXKi04Nc7XQSIL29MVd+teGZgxVBT4UWgv/L4k=;
 b=nKAp8ar3VFGS9h6wViGKOcEi2B/rH9kHd4zIG8IvNtkql54dUxiZC4x1060cGSu5TVQhtqCqxY9fptwaZ9oD0RZK5GdhsPbrmnyPuLSIMtdSnK3brvrYw59yHmMYNSh3u6JStIemF2DEP+xAVJVoel+ub7wa0TSNohHubO371wP19ZDWIdBdFYyufHCkNag2pMwqSuxMm3s7SDRUC5qkX2wPlBC4nkucKilqbpkb1Z+6QANq6sR6VfEN3n+DxnIeoZOFoi20DZOtoGIuBWEgMNaxmJeplaTLD77vP9yHwhmbnWLKhL+TarUOQvG6MrUIocSxi8KboQAUCUR89Sn91A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMatBhXKi04Nc7XQSIL29MVd+teGZgxVBT4UWgv/L4k=;
 b=q6divAvRJ/U1wrQYGf8Oi7Lr0ejPtNW2WUpvvb5btm6xxNTGkQUlcqgYP3c7gfX5a9rkMlLstseXCxuFOKjLHDC73IVmvNlhjUncEZ6cNArRTVlyHrf+GHH3aMQ8y91uQsZz3Rlpg3kU/JDXLVKL0bA4bLK0MkPgEAS0k1lxjWg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:27:17 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:27:17 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/40] Various Polaris fixes and optimizations
Date: Fri, 16 Oct 2020 11:26:12 +0800
Message-Id: <20201016032652.507-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:27:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5bd63756-db53-414f-0103-08d871836228
X-MS-TrafficTypeDiagnostic: DM5PR12MB4680:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB4680F3C13AEC6F54F4421E8DE4030@DM5PR12MB4680.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Czm1IHDw6WyNAAC+dvP4ALUFIzXS3M54VufQ/B++lFRLn+VSR/eG+N1ko2HapyQwTaqS+Wc61erERtBX82x2+K9wGt1L9+/AtBcxHqn/6qY5uTCCwZhjfMvZYVbI8sbQ8bFfMVbZ2lCXreN8zSS1tnAis1AeD27W1ar+FPkL48pi3vf6J0rtn8gdlZZZ53x0uBgwrjWxxNoaLgY+3e1iJ92TynFrSUc8n7hGOF+7jScCzwSlapPucWniSTrtCPQZYDz5JwacPNgyuQPC6Z3beBw5KLMRy7ajSx7SDeJVYwQeKzLF2C1og3wM/gbzt9Bnamm5Gk4VCA8ItkT1fy3hOfUFRPHKHlMH/xw7IGSoynuMS1+kOnIigt8cIsv8OAQa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(478600001)(4326008)(83380400001)(6666004)(36756003)(316002)(34490700002)(66946007)(6916009)(5660300002)(956004)(66556008)(66476007)(2616005)(44832011)(186003)(52116002)(7696005)(86362001)(8676002)(2906002)(6486002)(26005)(16526019)(1076003)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: /ChqUT4S16xn5ZgB9YXAE1WsxhnaMX2MEt91TtOXfV2WmQY+rm+a5l6ry44KPMGrbap1ub4DVdMZ/Lj1clxKv88qoby6VNyXCBNzsnv16NN1VJSfcgVwbauD001AayUWVUHApKUFxbl+obAAF3q3pLuJOqG2ccYnxhwerBX2mxP2EcSRcLwTXQHpEubEhYqYvcGBg7nVjrTyhQi+WA8xAUodnPUrffWZZDXoQDIH0l33WVTv4dvvP3nhgshKfwa0ObmqtatNieHFRCa8dX/BJqpEBMwU84M7U4w7oGzcM1AZ2h51cqO9f9nA/0w9ZIMr27renfjmLiVE9KIjkRrSqQHJ/BiXvM/IzTglgO3RIjXefQHx9vr/uwttTP6BlhnbZqM7tJMP3sZAXEWJBwDoPt29I1T1OYLIUAB3H6MrJcAAhxAh3lWBDDoLHc4Zz1gYJSgyD489eHSaAPwgzUi6aOnHZF58T5DIn18+Lr3Ed0QskRgtQJVlylAu+smO1SbYtsCFg8i/y54LCPAY4bosDq+WxQal0zjqCggisWUE49iUNi0k5HIabQb4KHfRHR7crydXBjL1HL3qFVufdl2x45hHoIV1DYx7Sqc3DK24T/7PpPn/LdkRhpL0u6okCBy8BTD7ebECY1qDaAcQrXR4Ew==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd63756-db53-414f-0103-08d871836228
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:27:17.7216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ob1unsXmVBG/Lu1epbPMF0KKL77BkTxCibSsn8IE6YGbDVukkJcs+V3eXEDfDuh8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4680
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The fixes and optimizations include:
- Enable zero rpm fan feature
- Reduce the idle power for multiple displays setup
- Fix screen flicker issue seen on some mutiple displays setup
- Enable mclk switch for multiple synced displays
- Other alignments with Windows

Evan Quan (40):
  drm/amd/pm: correct the checks for polaris kickers
  drm/amd/pm: populate smc vddc table
  drm/amd/pm: populate smc samu table
  drm/amd/pm: correct vddci table setup
  drm/amd/pm: correct sclk table setup
  drm/amd/pm: correct mclk table setup
  drm/amd/pm: correct the ACPI table setup V2
  drm/amd/pm: correct the BootLinkLevel setup
  drm/amd/pm: add pptable VRHotLevel setting
  drm/amd/pm: drop arb table first byte workaround
  drm/amdgpu: correct CG_ACLK_CNTL setting
  drm/amd/pm: add PWR_CKS_CNTL setting
  drm/amd/powerplay: separate Polaris fan table setup from Tonga
  drm/amd/pm: optimize AC timing programming
  drm/amd/pm: drop redundant efuse mask calculations
  drm/amd/pm: correct the settings for ro range minimum and maximum
  drm/amd/pm: correct polaris10 clock stretcher data table setting
  drm/amd/pm: setup zero rpm parameters for polaris10
  drm/amd/pm: add edc leakage controller setting
  drm/amd/pm: add mc register table initialization
  drm/amd/pm: correct VR shared rail info
  drm/amd/pm: correct the checks for sclk/mclk SS support
  drm/amd/pm: correct Polaris powertune table setup
  drm/amd/pm: correct Polaris DIDT configurations
  drm/amd/pm: correct avfs fuse settings
  drm/amd/pm: correct vddc phase control setting
  drm/amd/pm: correct VRconfig setting
  drm/amd/pm: correct platformcaps setup
  drm/amd/pm: correct smc voltage controller setup
  drm/amd/pm: correct sclk/mclk dpm enablement
  drm/amd/pm: correct the way to get the highest vddc
  drm/amd/pm: correct clk/voltage dependence setup
  drm/amd/pm: correct pcie spc cap setup
  drm/amd/pm: correct SMC sclk/mclk boot level setup
  drm/amd/pm: correct vddc_dep_on_dal_pwrl setup
  drm/amd/pm: fulfill the Polaris implementation for
    get_clock_by_type_with_latency()
  drm/amd/pm: enable Polaris watermark table setting
  drm/amd/pm: correct the mclk switching setting
  drm/amd/pm: reconfigure smc on display vbitimeout setting change
  drm/amd/pm: drop redundant display setting

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  39 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c       |  34 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |  14 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |  24 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |  11 +-
 drivers/gpu/drm/amd/include/atombios.h        |  20 +-
 drivers/gpu/drm/amd/pm/inc/hwmgr.h            |   1 +
 drivers/gpu/drm/amd/pm/inc/smu74_discrete.h   |   3 +-
 drivers/gpu/drm/amd/pm/inc/smu7_ppsmc.h       |   6 +
 .../gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c    |  10 +-
 .../drm/amd/pm/powerplay/hwmgr/ppatomctrl.c   | 125 +++-
 .../drm/amd/pm/powerplay/hwmgr/ppatomctrl.h   |  28 +-
 .../drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h |  66 ++
 .../powerplay/hwmgr/process_pptables_v1_0.c   | 107 +++-
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 572 ++++++++++++++++--
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.h   |  20 +
 .../amd/pm/powerplay/hwmgr/smu7_powertune.c   |  34 +-
 .../drm/amd/pm/powerplay/hwmgr/smu7_thermal.c |  11 +
 .../drm/amd/pm/powerplay/hwmgr/smu_helper.c   |  18 +-
 .../drm/amd/pm/powerplay/smumgr/fiji_smumgr.c |   3 +-
 .../pm/powerplay/smumgr/polaris10_smumgr.c    | 356 +++++++----
 .../pm/powerplay/smumgr/polaris10_smumgr.h    |   1 +
 .../amd/pm/powerplay/smumgr/vegam_smumgr.c    |   3 +-
 23 files changed, 1266 insertions(+), 240 deletions(-)

-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
