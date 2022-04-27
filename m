Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F00EC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 02:40:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19E3B10EF76;
	Wed, 27 Apr 2022 02:40:31 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2046.outbound.protection.outlook.com [40.107.102.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E509D10EF75
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 02:40:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLgL/Yk56RUIpyalNu09Z5fobqvGxkJZ8sxUUkSI4g4nG3ecRyhMduEG8C/GFWUNZSfYqwPlM2XCCq24ITLbzVaQVUF15YoWDGpk3B0Bqokcm/78cPA7ocSm+fej7aiuWSOFzwxqJ7op8i2oNcr1oy8hsXl8NtwV5uvLsrjSjCvDVPOf/EDnH42w65gF7X4W5U/XtjbhNGpkZf/a3P+cxdDwqvDP+WYY22wiLD6hli8C3rrzyUU86HqpMGbxgJ5saOgedj5QA/u7/jrHpEI9luN7qX0H3IPzMLFteRB85YXF59ttKUZbXqgnPWOEBT3dnyq0UUPaSb64V8RFXzkSPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cXG0vWEg82jQjoRWipyDuLXY0uuSr5pkIyzq0s6VSk=;
 b=Dc9AIlmcU+ZGnDJ0JW9rHf3c1KJbWdGFsj283A1JL3QRmYq6Dxtlw9gcf7wyYlcZ3HygXRgYv1yOFCR3+NbXIBs1Sp8MJ73olf03qoI9CHRqy+YQKIJnKlx3ANFIetCGHUjMpgV5PRj1WaKaeiG541IIrfL9d7pI9PaiJSywIdzEXMkV6G7IAptgYQHlJ3+sq4PXPVRVIaKPyt9yV136nNIasOK49C2VCbMnD59O/t3oILHFqEQLOS5rxwlf+MQoCqxdaYJEFu+00w9IJvLVO8SFD6H9nhtr/zOB6BJ9SljZezmjJ1wi9Qawuj8yYteTLmapKIWTYDkqE+mixpQuVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cXG0vWEg82jQjoRWipyDuLXY0uuSr5pkIyzq0s6VSk=;
 b=a3JNtTTZOza0Lw6hUYDgHHeXICSQ++xgUiBV9gZgn0uA/+CKCjEDqHXRTE60w6qUMWzdkhOnMuefxZqR86FBAlqmBAIrposJPJBZNLuIAXLeISTeVB7SeP8SqveZLiF9OQtdPGoFvCnHFtswZZTgPW1LtR693+3tsRGv12Nybc4=
Received: from MW4PR04CA0298.namprd04.prod.outlook.com (2603:10b6:303:89::33)
 by CH2PR12MB3766.namprd12.prod.outlook.com (2603:10b6:610:16::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 02:40:27 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::5b) by MW4PR04CA0298.outlook.office365.com
 (2603:10b6:303:89::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Wed, 27 Apr 2022 02:40:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 02:40:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 21:40:25 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.24
 via Frontend Transport; Tue, 26 Apr 2022 21:40:21 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/8] drm/amd/display: Make OPTC3 function accessible to other
 DCN
Date: Wed, 27 Apr 2022 10:39:52 +0800
Message-ID: <20220427023959.1241450-2-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220427023959.1241450-1-Wayne.Lin@amd.com>
References: <20220427023959.1241450-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09aca3fe-661d-4220-941b-08da27f7498a
X-MS-TrafficTypeDiagnostic: CH2PR12MB3766:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3766596741C3EACE11DD0F1FFCFA9@CH2PR12MB3766.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fd/lh+W34CkKkBAEHc+oKzRZU7r9LsFhEGPX4NcntY5KvYmAWeuxffZVy1ODywwPN9mX4spNQMLvJkp2c4Sd/JJv76mw8KNXly5+iC2vAyBBdyNfywkJM1nNWkiUfUsGs/Tc8ok30vHLLMxWP4VxnBvqeZY9NglvY5DHHrc/7zpLqmp5bUqDjLw2YVsF36c96LGydjsvPpXuEJ51tEqeIdjxbtXvx6ykB/HrF1gE/v+Alw9wD8/LhfWrUIsfYm8DKgEdhgE6HEd4YeG8961FT9ajhU+eSexsiDJJmIfLgSHiFsqMwPElq/lUmPHz+X5NjSMUIz179Yb18q+/mzU0PLnjJlQtBFX6x58/CeHZXm8flM/FbTAy13ycIVyzWmnSpePUFwnux2mZ1ePwcJzUOxHkp9G3zvFULbfieiJDWdDnZt6ZryUntNBhUgSWwXC8O8m6n+zIoy/Ahkg7mIJ8HiokFwQq+gzUZnVrRaZeHrr430ncCRKm434lsZRqjA1C+8ZPJs5VitBUoJHtMtTsTr0IF3MOH/M+9wcb1yElWbHhtZ2qtIoUDQ8OVDI4I74/5LvZOY/RdG2rzLwHmK1UHlRgwqEsEGeGXwYn9ojPxK7xvgsMAN8/ZsXUzUrnUd2RI8zcIT/j8Oz98XX3NhkV51KZSgelfwv1v6xyogURjcIL3Q8koeSXmrN76tz6nEuWCmayRRDAw/Syo5PQFUj7ww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(82310400005)(5660300002)(81166007)(36756003)(2906002)(70586007)(6916009)(316002)(54906003)(70206006)(508600001)(8676002)(356005)(86362001)(83380400001)(36860700001)(26005)(6666004)(7696005)(8936002)(40460700003)(4326008)(186003)(336012)(426003)(2616005)(47076005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 02:40:26.8695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09aca3fe-661d-4220-941b-08da27f7498a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3766
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, "Lee,
 Alvin" <Alvin.Lee2@amd.com>, Harry Vanzylldejong <Harry.Vanzylldejong@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Lee, Alvin" <Alvin.Lee2@amd.com>

[Why]
Newer DCN should use optc3

[How]
Declare optc3 vmin/vmax function in header.

Reviewed-by: Harry Vanzylldejong <Harry.Vanzylldejong@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
index 736e63bc80c2..97f11ef6e9f0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
@@ -344,5 +344,5 @@ void optc3_set_timing_db_mode(struct timing_generator *optc, bool enable);
 void optc3_set_odm_bypass(struct timing_generator *optc,
 		const struct dc_crtc_timing *dc_crtc_timing);
 void optc3_tg_init(struct timing_generator *optc);
-
+void optc3_set_vtotal_min_max(struct timing_generator *optc, int vtotal_min, int vtotal_max);
 #endif /* __DC_OPTC_DCN30_H__ */
-- 
2.36.0

