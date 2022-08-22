Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73B7C28D13
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Aug 2022 14:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CD758F627;
	Mon, 22 Aug 2022 14:01:47 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2081.outbound.protection.outlook.com [40.107.212.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA8D38F55F
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Aug 2022 14:01:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnrZvC/ij4z8UI943OZI8gGP345VPlu5zMhpAr1Lru+nuQkvAwT5ShEd/X18549en9HXzKQedbxsLDJQSdWzvSH1j/9vINKpCX4ZeJAxYXMa9gZOH4XPV78fwARLDol2eROTgi5lE+y431lbV9gJMAJ1SvgtkqBNTbJTm9ZFbZVDCz4HSvs+/nKS9II5gYL2B/jSZO3/bGFvJlybLBLr/H8ivRi9Bp1f4uA8vXlhqTLRq3E18KTtx+kcVZdmbwFal6JG/lJInhF+1GEVQAX1zMBOmpR6GTxcXtTj9KYydj9M+AZJ3vhEAAyyp9qAVxY6UpwWeaJcsIylrAm8u9n5+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=niX4iweywIzeOW10ye5qEREuFHuVwjHsn3POigdtxC0=;
 b=mr1HB5Lgwc/Ad8wJjb0c0dyPdiqk5aZJx+p4wGn7P7SMwSF6os1zBB4VgpFraMvCAosRAEd4LgHYimLK45m/fb8FQJHMRE/MS+keBCNVd9J6O70BOVrorVJ76fqrdNB1Gh0IfZX7Kpwe8BFtQ0H318RFBwNax5BAinZi8Jf67m7eeLYo+2vV7PQJkcdkkiKMJT5vXGuXmjFm2omWdvVwSwb627CbNx9UVzWhfhWjxBwXWkiVcORBnGdeF7WRXhSvX+mF7JjFnAKTuezsgOYzMuy8D6jQtFkDwKCOg+XpqXJpVipFZLeQaxZy/Ej4Fw4G9/jcuwdCyw0ZcnrnNqL3Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niX4iweywIzeOW10ye5qEREuFHuVwjHsn3POigdtxC0=;
 b=AOG10xtdT3ezvj02rlv0Bras06YoDhsWnpgalGWz+b6cRnroIztIxFRVuHr5bshaeCU78QXDTBrxtl8sKk1rqn896IAgV6scGGEKYAxe/PmuV7Jue86Ff9CzdcOLy0gq7E47eJ6m2DM0gbNV5rg6e5CKU/hH2PM8AQ9igW8zxu4=
Received: from MW4PR03CA0321.namprd03.prod.outlook.com (2603:10b6:303:dd::26)
 by BL3PR12MB6403.namprd12.prod.outlook.com (2603:10b6:208:3b3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 14:01:20 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::5c) by MW4PR03CA0321.outlook.office365.com
 (2603:10b6:303:dd::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.17 via Frontend
 Transport; Mon, 22 Aug 2022 14:01:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Mon, 22 Aug 2022 14:01:20 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 09:01:19 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Mon, 22 Aug 2022 09:01:15
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/14] drm/amd/display: Remove redundant check in atomic_check
Date: Mon, 22 Aug 2022 17:57:52 +0800
Message-ID: <20220822095752.3750614-15-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220822095752.3750614-1-Brian.Chang@amd.com>
References: <20220822095752.3750614-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ee422c3-c7cd-41f7-a139-08da8446ca7f
X-MS-TrafficTypeDiagnostic: BL3PR12MB6403:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GDq1ZTMb4Dln9uCIU5WTiP64EwqLrJzTGruPwTG2A3DXJE9c9afc2sNBZyh8zFVtS8RmJql9N02/SZIczngqDxp8+ZY1EUFR/o72A0lSWXg/v+De7jr0gK/Jx+Z2+VCgKhhOwBmLE2jRiG/VLanY6jaqdpUEx6XqqZYyAs32LvW/hQMb0d6gioROLJvBgu+p1yP1M+4TtbOYxeJaeey3v4urkTM6diF60QgoCivxiqeDczomj9GN7Qtngb0aJSw/mbedCLWwfM8VOWokMG5rpqrU9qQjrifg4aGemri4QSTUS32DXI14keQ5kZ989Zb/WlHEhblbRzz2lFvV8a1pL6CeL2/SNofI0LaI2HhQbk5uwzJyxiItgMrOZ57RD3OSAlP4UyvuNtcdRoiD4108X9uDHkRRDMKiaeWVYRAa3PoYhyDvI+ReurFI1ehVnnpX2iHFqWWFMdi0yLCKodreZDJlFaY2CMHXAjPwdPJx2Qq/NXdnY+hHitmKuiwLbJO2cfZptoMyw1TfQmlHNIzl1kdiFR3MbdYPKQ54kkKU8eK+56JewFZGLqSdrl5r1nHM7l8FYHsaZOkREmhpVxfvJHZEU3xUV38v81REuGxMkinYpiDHXz1DtfsttYAIlu29zlRO3XdOZmOBz0y0yGwyN2F3jnNa/+OeWbYz4plKF2dM6OyylneBcpcpHIDIiLydF37VcQmMO8EfxJIW/Y8Dv3AFu436VoXloEmQOCTfF36kO2Qatc0YmFkch5kfC408C8RRZciu8lYoYxf2qtTCC0D0IaefHKLdHpurld2As2qkVbX5adtaMnf8CKM9+78Om37+o0B9aVsB2A+xVXny6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(39860400002)(376002)(136003)(40470700004)(46966006)(36840700001)(82740400003)(41300700001)(81166007)(356005)(478600001)(7696005)(6666004)(26005)(47076005)(2616005)(186003)(426003)(1076003)(5660300002)(4326008)(336012)(4744005)(36756003)(8936002)(2906002)(54906003)(70206006)(86362001)(82310400005)(6916009)(40460700003)(70586007)(8676002)(83380400001)(316002)(36860700001)(40480700001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 14:01:20.4254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee422c3-c7cd-41f7-a139-08da8446ca7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6403
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Hersen Wu <hersenxs.wu@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
We have 2 back-to-back checks for skipping connectors.
Logically one of them will do the job.

[How]
Remove redundant check.

Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bc2493a2a90e..35b0d6a28726 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9388,9 +9388,6 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		struct dm_connector_state *dm_new_con_state = to_dm_connector_state(new_con_state);
 
 		/* Skip connectors that are disabled or part of modeset already. */
-		if (!old_con_state->crtc && !new_con_state->crtc)
-			continue;
-
 		if (!new_con_state->crtc)
 			continue;
 
-- 
2.25.1

