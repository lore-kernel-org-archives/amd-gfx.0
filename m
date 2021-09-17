Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94631C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:26:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41E0660F6C
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 41E0660F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AF8D6EE7A;
	Fri, 17 Sep 2021 19:25:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25D386EE7A
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 19:25:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0eUxRl2ulMme7zigQKlknWUy2FhyblHtksVQAw/361o/OQkjdc19vK0HsdqDb9MpVvV606U1hHwohSUHe8U4i0WCrwZXMLKn6RDPg/R5Z//shH7MxPBja7V4c5CYpkXYJUL6Zb40A3B4J3UnizMOQXyG/82ug0+CEYUkuph9NrGrkfLvDx/EdDB1GTg+qXQra0mjePLYy1FsZ1wI4dLS8iQ9q+Z4GXBO0qkIptRhTbKwaIpulSy1hmuVW84Vwqm0rpcjhAw9g4t5mzZI8hxjmL90qazbO68VenrAlGa6PnCl2BammOADeL/KA+baNNtPvSdnV//pYKJv/vCXtH6lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=j6CJpfq4yFeAHozcaIK2hiO9Fpydxvo8RKnvCQ0SIcg=;
 b=TKqu73ZgkMtatmhqukneKBIKI84P34jeUG8YPVSdKFLzj2zKszFPEysf3hWNhBWwLkSppxH5cxmPnpBsL5mZuJ4kOjkensMkZ/2Hm+Tux3MdyxDU13P2GLtMFoHxDOgYC/KEHwPC25yD58YBAgRghrh2vPeH+zcgVa6eZKpGmegpn0BCdzI3+y+lmgUpw0At8i1LI5JOBT/40mL4bG1e06I1j5NLknbKCDH94fC1x7t2/xcOkwhmHYc3EwKxMa0dK1e7pz5XFap7D0pDoyQ2wiV50bH52ENjbSDrJm28Wus78GsK96BnRKGcsl3zY0uH9TZe0GqxlhibS+vlkZLoQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6CJpfq4yFeAHozcaIK2hiO9Fpydxvo8RKnvCQ0SIcg=;
 b=VqQFhay17WwCIgPFWa9L4F1w7BSl87FgpKVCgd8aiSDAKMSxzTFIKJ15NQhk2683tcGWEOzbweyMpVo4MFXAhQeJrEaqAaSjN5DAwVSF2KFuEYpZdVPg81riRW+VO9GmH/rx9dp/T7/NNhScBo5QgK7MFzLdZnlfoDN+oVtM+bE=
Received: from BN9PR03CA0238.namprd03.prod.outlook.com (2603:10b6:408:f8::33)
 by BN7PR12MB2644.namprd12.prod.outlook.com (2603:10b6:408:2d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Fri, 17 Sep
 2021 19:25:54 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8::4) by BN9PR03CA0238.outlook.office365.com
 (2603:10b6:408:f8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 19:25:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 19:25:54 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 17 Sep
 2021 14:25:52 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, "Lai, Derek"
 <Derek.Lai@amd.com>, Anthony Koo <anthony.koo@amd.com>
Subject: [PATCH 08/18] drm/amd/display: Added power down on boot for DCN3
Date: Fri, 17 Sep 2021 15:25:14 -0400
Message-ID: <20210917192524.3020276-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
References: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef009241-8e57-4097-04aa-08d97a10f7b4
X-MS-TrafficTypeDiagnostic: BN7PR12MB2644:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2644482336BFAC11939BA95798DD9@BN7PR12MB2644.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hs8dVOu9vUROmBmKLOBVin9ZqA+Z5uuKAHuDFZeT54VQ8eZrbgjfKZug/fmaPj7Z60vNAMa0YQlFUgSWlVF1et+Gf9Oq4V2XZXTc9JLQogJZR2V8MQ5kyxgIWho/fJyZk3A8hYxACX3OuKBO5yV5BxNELDn3LvoKCSbKsQSOscIDAs4UWhclQbt7KohsXRn1yKOPJ0izDuXOAAPKVZNCAlOMLL9nCEyQlboCwNtqno6whL8MWj0vBEDDQ8XdMOhr+GrgI6amKxTUsRNXrgG8BpLg21neK9lR6GraXGFzUvnSnEmZ79Jjy17qZqUwuNeNpCO/YD/3bj9U/k47yW7yqurKp336MHBxQ8JCPTkmbHjwkc196xckVVWZ/0DXVfLUtvQLkxlJ9r1EO+FF0Od5OlTWM1B0g4U18n7EBzBsLZTdqH+zb4/kBI9g7U6TESf4dIy35jiq3gR1DHi+cc9W8YzTZ+5Uxjh3VBFV2KgJNv7ZadToGnETqUUJASfoBbC2LMvWrKNBB4UpUzYuQRBjNwDohBo7pAf9mZH230ML86NDtjoyeEJFAhGdTsjUxE54ZFEb55BFY/UdWSipNePo+RueDUniqEh1p0C6LVAObvPZe4YlPaKTJAdMhnJBm7NnF0x/YIqWUNgmItLeEgWiHWdKidqlwnYu082Km0E854aWtgNhfaVNJ2TiVICtgaJUvcRAWODquctcRP2OpeBqYgMh6Zu26u9X7qf5IvTIwC4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(36840700001)(46966006)(8936002)(1076003)(26005)(8676002)(478600001)(6666004)(2906002)(336012)(4326008)(426003)(70206006)(82310400003)(70586007)(16526019)(186003)(5660300002)(83380400001)(2616005)(54906003)(316002)(36860700001)(47076005)(6916009)(356005)(81166007)(36756003)(82740400003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 19:25:54.3022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef009241-8e57-4097-04aa-08d97a10f7b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2644
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

From: "Lai, Derek" <Derek.Lai@amd.com>

[Why]
The change of setting a timer callback on boot for 10 seconds is still
working, just lost power down on boot and power down for DCN3.

[How]
Added power down on boot and power down for DCN3.

Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Derek Lai <Derek.Lai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
index 10c83f4083b5..c6a737781ad1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
@@ -34,6 +34,7 @@
 static const struct hw_sequencer_funcs dcn31_funcs = {
 	.program_gamut_remap = dcn10_program_gamut_remap,
 	.init_hw = dcn31_init_hw,
+	.power_down_on_boot = dcn10_power_down_on_boot,
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
@@ -93,6 +94,7 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
+	.power_down = dce110_power_down,
 	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
-- 
2.25.1

