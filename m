Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054D2C28D13
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Aug 2022 19:39:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4009EA133F;
	Mon, 22 Aug 2022 19:39:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEC57A1320
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Aug 2022 19:38:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDW3DvtDMqGU5KVakBapa3PuXwTzKSRlbX8Zg1qVWx3bsJFCR+2kh2n7hRb8okkbeehPvOJQqKEoWA/N0ZfMFRmL765aFndmEIlnaI6IiBAfk0EWGhghKLfmSdISgCL9bmkOKtnaAm/a0BlkFCmN+k/m1TfRUXsUoVTnM/8KKaqhBy4yXilhfxJvHgN8vIlDnoJRvZ95Ji9BnvJWIfOzd8N7MiaDbhO6O+ZIoZbADag9S744j68MZqE81t8gO5XDYW2ikFgAKOWEBcGOCxlwRNfz15czAWZfELV3cYg8r3OobqmYqtTHBVlVo9TstmohMzjJgw0n40DBBpnrDfRbtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdevJhSdEIRGtIuEtfE0LNYXcOq1D9qahLMbxAfsKDA=;
 b=bcfnA7T5GQoJkzZU2HprTkrpu2JwiyeRr6t5hOUsOgSkryUb45AZsfHZsRFRVogC+GzOJAJ12W7pcq/H6xISRhj4pVfMuWKbaezGHreF8YIYyIRg85YvdewPbj4R6aVCf2TRdR41bbivx1NOPNol4glI968TeA7VRPJnl2xIu4/rBEQo9yQt717NM72BE0GD9aQ9oNhjA60ucOIIAO8brtjfmK2EIoUgCya1dIK43huPn5q+NMs3Nd/BR3ioCeeyff+fiiR8OUhSWZkfmBfU0hYWSh7Df68kq4YO2zo7H/jkNv84cNsvPztG+OIgXaI1rx88/O/BSb5Adzp1Kg6q8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdevJhSdEIRGtIuEtfE0LNYXcOq1D9qahLMbxAfsKDA=;
 b=1+RMgWaQhTbwCiqf20AZJlU5PIoCDctMfKWaJnLFTefBC/6wBEDqN1lgFJW0Z/h8W1VQ26fzOpePlaZE1XNMivPLZFB/KLWw5a2yoRvi+Ax/gOPYdVclcyv3CFsXN2Xyexd6jUS7Qd/OJypvUtC4GguHa7oeqKny/bvBsU7madE=
Received: from DM6PR14CA0065.namprd14.prod.outlook.com (2603:10b6:5:18f::42)
 by DM4PR12MB5213.namprd12.prod.outlook.com (2603:10b6:5:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Mon, 22 Aug
 2022 19:38:36 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::fc) by DM6PR14CA0065.outlook.office365.com
 (2603:10b6:5:18f::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21 via Frontend
 Transport; Mon, 22 Aug 2022 19:38:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Mon, 22 Aug 2022 19:38:36 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 14:38:35 -0500
Received: from roma-vbox.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 22 Aug 2022 14:38:35 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <harry.wentland@amd.com>, <hamza.mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: enable PCON support for dcn314
Date: Mon, 22 Aug 2022 15:38:16 -0400
Message-ID: <20220822193816.22943-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb1f0446-d11c-4613-424b-08da8475e800
X-MS-TrafficTypeDiagnostic: DM4PR12MB5213:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I5TcprRuUFM8FBucg2rSDoB20qmrVJTrIJuzeaxfUGP5HR/rw+rGwvQo48CbYY9gJtTgBJ1mzzKPj9Uh0JTpmMd/psb01NSLLLWMbUA8YRZ2DacRW6iNvZG4HJMRuFDyA/Ge5fgNxIZx6vRpGimKdG7MRcmH69T+jn4dufV3HLfprbg0BPugAS22OiY27ZJU6/fqEf0aDW6rzkoZ3VYpcd3x+jxFYsx/B18T4/8kifUgKEJAL2V3lTbv4SYE0mkGLwnMRIS8eDRSPST7Ac7Fhqnr9677XK9YSZrDyZlo5odPXpE2Rca/bgzz9Xup6GJ23h0PttHeV2IV3clyJMuoDWH5CDIwuVp+IhxDEqezgt7u8VilRSdwTqg8/MpNzW/khtokwSqB5hqCVJ/oKwIqgnMmPgweJJZv+hfnNHO+B0QqihVIpnkeJmsnkKJqwVvMAVRYuOxz4ds/kkCP6R6yjhzf4kfi/a+lZYARfVyZoLiX8SXk4SyEKFIYR7kgaqMG0SPDVIkJVtgEgZLNzF25+0QMkIJ92rl0EOT+SqefUcbuJRvoWHQVtcnbtdTIV4gilbj5M1PnuuHHPp1gmaoSrf3lkwsbR5E4MMjOMafcNg6hPA59y5FEoScsDy2aZRyx8WhZIW1nNdnH3t+XJgvqyP0CzkBJ0Ig34z+LAhwfZ3u4m4v0N9FYFtNhD67ftWtgW/iku3HEjKoG4OlBBwYANoDuVw8//62Dq3CrlkPcqnhReuTaKdlPzn8wwVrLMxPMeTcJ17gB9l3ZC5aKhIOO9F/W992qamOZmxZR58yVHP8TQb2FhZ21LznlAGUM/EcgP4m7H1WSXVhR7CDyu1Y1tQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(396003)(136003)(376002)(36840700001)(46966006)(40470700004)(2616005)(186003)(426003)(47076005)(1076003)(336012)(81166007)(356005)(86362001)(82740400003)(40460700003)(4326008)(70586007)(6636002)(8676002)(110136005)(2906002)(36860700001)(316002)(36756003)(40480700001)(4744005)(2876002)(478600001)(8936002)(5660300002)(7696005)(26005)(70206006)(6666004)(41300700001)(82310400005)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 19:38:36.3777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1f0446-d11c-4613-424b-08da8475e800
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5213
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
Cc: Roman Li <roman.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
DCN314 supports PCON.

[How]
Explicitly enable it in dcn314 resources.

Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 85f32206a766..3a9e3870b3a9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -1750,6 +1750,7 @@ static bool dcn314_resource_construct(
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.dp_hpo = true;
+	dc->caps.dp_hdmi21_pcon_support = true;
 	dc->caps.edp_dsc_support = true;
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
-- 
2.17.1

