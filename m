Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B5EC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECC9112A89D;
	Thu, 30 Jun 2022 19:14:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE68B113B52
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:14:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTeK51kiRn2+BH/0EZ21wG2jGhn0E9MPSq3cRCkZnUi2o2HJoTLLCHHAiNso8eFYsq/+sx2N6+JxQA312u512it6nEkslOcfljBh1uHHxWYZxPRsvl7s67X/c7FJFf7JPbK+/HMSh6n2PUXGWKhpSH3tK/JQT0K+Gn+cHOqzJx9UFFrwgP8VXB1ej3g9ghuu9dvWmrCLp8lCXpU11dHjIoicfNDypebRWpqYfk8AkjcCkxXi0BS4FMcerISQTZDxVK6HkOuNa0xVk0EXFCz/zvGem6zfTZtp+LRJ580bK6VAAVLx3N0Qq9w6CLl/2FGvlVDmRV5yvMplQv8E1qzVlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMceB2Jb13CThfsWJfBDnCnX2W8gGfw60dMUATQTDaU=;
 b=f9BBuBprtOGPMVnnbnwgL/49kw+TGqwJqYdnHCy7pQOdPadnZDG2FibO5HJer2b2Fmp6T2AmlGGJg/25SOXJgL/Xgft2HGRYGtovzkZpmOGDSL9KGNXIqwdV9+nxRDodyHUy+q2jCm4NpIwQNjash38YnB68yLpqW759HNkGhPGi0TZLH6ByMmf5xXcLChwyF3e4C5/AR2JQmx8O75wGlE8rgsWS8S23hboDsVgpUausAC02tpa+MvJy88wflQo56Nrm2s304a4B4oAeh1Z3HQM81XCr6oNmvxwCMkJXYOAOv7PZbal/NjCv/C+IwMw9eQlhRWRG/OCUUmp36X12/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMceB2Jb13CThfsWJfBDnCnX2W8gGfw60dMUATQTDaU=;
 b=D/8a4LBHBnTzkbhIT6BCHOqlsKy9ID9n+oEgMo3sqb7WqRLmc/BvyXzxY0qM0BxW+aBkzs0fHMfNy+th4pfZdliNqnWXJrBKS8SaqCEXh2eTZFZwjZv3yH/FJQxaq5bTpJMEYSTr7SiSZSBZMXA6Z4wtosOP38v86VseaFRPPfg=
Received: from BN0PR04CA0154.namprd04.prod.outlook.com (2603:10b6:408:eb::9)
 by DM4PR12MB5326.namprd12.prod.outlook.com (2603:10b6:5:39a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 19:14:14 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::4e) by BN0PR04CA0154.outlook.office365.com
 (2603:10b6:408:eb::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 19:14:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:14:14 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:14:13 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/40] drm/amd/display: Fix dmub soft hang for PSR 1
Date: Thu, 30 Jun 2022 15:13:07 -0400
Message-ID: <20220630191322.909650-26-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b3ef422-beb7-44d5-c00e-08da5accb8ab
X-MS-TrafficTypeDiagnostic: DM4PR12MB5326:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9nDMfrxXBvxbU6jOpbdOkGNsHTbVuYUlmIYFv+qnDrcDj5J9cmGdG7X3lPixpIw3bf+Khe+cvfnHGRcDbT08JeVY6NGEoTuAnyAjdaGYvf3Fl5HAPb+qXMBrFrO9JtdaF8WNhge7yoKc64IUFdO/38PsuSd/ZDU4bYDjowCrInK9ygdnBIwj4bAjk5joPHz2IkBD/ieZAfjfy0TIjS4ZAhmbvZCvb3oySsOD3TgGs/vHQ7NoxdqDhTs3POD1RW3F4oNwIuF7/FdboVD3T45cl2BRo2PNYFOuahYBd12lHaxfB6Xail5Y0p0xV4LYgnAWksrkEg2r/h0AO379FmnDelf3r0bnEpVM1Ise3/S8HrZgZVW6EssDnsnMFadIGFQ86q+CPStXkxIuQOaKVvs8BQbZD2z4z4ktQCakExV/aT6bDRUTXLtpQBvSGYLEwtTM5lDTr48PgEjqwbhflCNZceZXAKl/VtBx79IvW2D4tw1IILe5GWQAARWQWe/jYgx3X80bqy2LcLvwUKBOVuxta4xD6uHxn5lAWshG31P9ps05nkOYGJPUc2zysapEF2vB+3CqhIJA0HIJRf5Co7wvDcWdWiwsnhtrjDD5lODxgejxQrAEPe4ibK/nwJfQ47sPHqjlIVO27ub84tU97HqNerQ1yt4uhkEOqLT8/UhL1ke/bL41h+ECEXIeZ9RzaJ49uZqohjh70dMKtoQ2CzHIwq8rrbkcbLg4cy+wf1Nd2fwBkZa5Ct5pH+IuD1/NJMmaT7L+i12YfaLNIxrez/0+e5kS8NkBFMlSe7qo0SaN3aFmrDUhen6pRP2FLimh95iS5ZOYoOdReEIIW8qPlIIecgwJ7Eh4MgScRDJlJTkcUnE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(39860400002)(136003)(346002)(40470700004)(46966006)(36840700001)(81166007)(356005)(8676002)(4326008)(82740400003)(54906003)(82310400005)(47076005)(36860700001)(36756003)(316002)(40480700001)(83380400001)(70206006)(70586007)(40460700003)(16526019)(26005)(336012)(41300700001)(1076003)(6666004)(86362001)(5660300002)(2906002)(426003)(2616005)(6916009)(478600001)(8936002)(7696005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:14:14.3813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3ef422-beb7-44d5-c00e-08da5accb8ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5326
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

[Why]
Unexpected change of aux hw mapping causes dmub soft hang when
initiate aux transation at wrong aux channel.

ddc_channel stands for hw dp aux index which is from vbios,
but link_index is pure software concept for link count depending on which link
is probed first. They are not interchangeable.

dmub aux transaction could pass if happens eDP link_index gets
the same value as vbios ddc_channel, e.g., ddc_channel = 1, link_index = 1
if they gets different, e.g., ddc_channel = 2, link_index = 0, overwrite
ddc_channel with link_index will have wrong ddc channel being used for aux
transaction in dmub PSR, cause aux transaction soft hang.

[How]
ddc_channel mapping to each link is determined by vbios and further
parsed in dc. Such info. should not be touched in any kind, otherwise
the mapping is screwed up leading to aux transaction timeout.

Reviewed-by: Aurabindo Jayamohanan Pillai <Aurabindo.Pillai@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d0206d98217b..5d150f85e1d5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8639,7 +8639,7 @@ static int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
 
 	if (dc_submit_i2c(
 			ddc_service->ctx->dc,
-			ddc_service->ddc_pin->hw_info.ddc_channel,
+			ddc_service->link->link_index,
 			&cmd))
 		result = num;
 
@@ -8675,8 +8675,6 @@ create_i2c(struct ddc_service *ddc_service,
 	snprintf(i2c->base.name, sizeof(i2c->base.name), "AMDGPU DM i2c hw bus %d", link_index);
 	i2c_set_adapdata(&i2c->base, i2c);
 	i2c->ddc_service = ddc_service;
-	if (i2c->ddc_service->ddc_pin)
-		i2c->ddc_service->ddc_pin->hw_info.ddc_channel = link_index;
 
 	return i2c;
 }
-- 
2.25.1

