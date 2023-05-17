Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E113FC77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 21:10:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C75910E48A;
	Wed, 17 May 2023 21:10:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E042A10E48A
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 21:10:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HA93wEpyzfBYpaF95xpp7Oo1v8trFtCZojAYt3uAQdp1hdb/18A/aieP80a3cEa1OFl7i2jl/OE63BxBMgTCQthH0mBL8WhO47xhNE9fsMFf7KsEunKeDeCXLH64NH5ntAlp2GZwSluyRdcK58lPK99K/bbCN3JCqRgWA4Ktcfy3u/nY7W5hARF9za1XFZ2K8fTnd3Y2raMTG8FHP08kG9NA5PRcTRh9KNlxKhmeKUW0ILIya4sf/TnT8O0VyDAGhMTOfQ6pXNtH2fWIZ/e5UsPiiEgB+EnP+q1/b/+rb8UwhgEeP/Ppsh+VVvDM6wx0uxprT7N9X8DDWoTLa6AyoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiSVqsm9aqn7OiPD5goOw8dtyigmCy92jqoaZ9jyxiU=;
 b=kpyoZ+r7633qq2UDOZrFUBWMTixUstVXCsDexF2Cv+g3G23dAJWtWfiPbauylTXVppvBUEqgJVls/yFm5RyE9heXhEjU6xoMSYgDDcD8tCDNIA8wb85n6tfe2u6cRYT77MTt1MUhg/LGY8D8CF5HOlgKQdrfGcjp+evpF7g/Q6PuX8bYB+EGPjOrZ9EEMYFBkRDXPS8qQwIRy+C65NIsg7Y2rvoR2XKPJ+voEJIagQSfuiXKsKox8/g++DhYIzcndGRYNFZU9u9DEQcoHMgz8gON+UJwUmetRR7vUGukLL6DU149/KboHPQjErOufFBFoiXBq2BpgKvx645xY/iECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hiSVqsm9aqn7OiPD5goOw8dtyigmCy92jqoaZ9jyxiU=;
 b=lJeQGN0eiJBixvclAmseQ9KBWsqY6GZvY753BK/MZ8sLuN+C4F7oP/nKZfOCOif9cTpe4eQEl/BRj4MNnXSjl7DUP6LWCtwn7i4YMtJF2QQMZfe5rH2GachFkaoNDMRY84Rqx1edmhRpNVuIRvdC98ANHKdQ10TQgq1a5C/+wXY=
Received: from MW3PR06CA0014.namprd06.prod.outlook.com (2603:10b6:303:2a::19)
 by PH8PR12MB7133.namprd12.prod.outlook.com (2603:10b6:510:22e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 21:10:07 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::bc) by MW3PR06CA0014.outlook.office365.com
 (2603:10b6:303:2a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Wed, 17 May 2023 21:10:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 21:10:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 16:10:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 16:10:06 -0500
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 17 May 2023 16:10:06 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Fix artifacting on eDP panels when engaging
 freesync video mode
Date: Wed, 17 May 2023 17:10:06 -0400
Message-ID: <20230517211006.311990-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT026:EE_|PH8PR12MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: fec7c6ab-f2b6-4d0c-dcdc-08db571b17a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tvJ6HQ0sr0/urYCzvAj8RWGoP0Jw6pILCBu1Jwoy6wnTJpRlnwky8MhkYqYXIXKuDo21HL0vs7FPMbgNBRD54cDFmIEUrmcOFYWNE4jIzKasNwnRsGDzYS6HMTdCRVJSAwfYmrfldi85EjE3sGbt7dij95Vg/p5M0FcUTgZn8AF+Ewg06NSIni51swwfMfOFsCb4GGmbOuJZduiLkRkJ6HDsRM8DBwW2QdK6/5vZ94pbTzcACXvSM2WbzIKXO+mYwerDmYUwAsjluEN1lBan70BRsMq5cDU+qdLifVnYGDkJlv0J9Z2FFjBJ+FB5sx56lmM7KOr8tJSLEQnsCXWazli5WHhtWz8mYvrS5Toh7reBgQrU8dRW9JK99O8E0lreOPbJ0SGzZaw/29UAFFpwodT4VGx1Zw5pOcXPGwCT6v6lBpDsjQlE1by+08p47o5k0cGiuK9nppz3qgczCUvmMPSXXg9l5F/nOLoldSuxkJ7tIXEnblsw21QZmBP1+4sGClpjaSV/18nFjpqlY/DrMHj4M1W1fbOONpDg2pG5IMD1mI1ewBwKG/t1A4M1MHNYJ3kHu73XJeCiFjaZBrUaUcqbJ757AnvzBsCeLT+L6gs4U3x89iuZrqcm0ET2+oXyZniIs9RU/C3fVb5Iyhk61fEQtzsR5xkAgh50jFIh+pCZmU8j3AGSlE9FHpMpNJLhWiYugCy9A+FvS2lZHRWx39ESoyb7u0RpNGxcc313egs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(7696005)(83380400001)(36860700001)(47076005)(426003)(966005)(336012)(478600001)(54906003)(2616005)(26005)(186003)(44832011)(1076003)(8936002)(5660300002)(8676002)(36756003)(40460700003)(41300700001)(82740400003)(356005)(6916009)(81166007)(4326008)(70206006)(40480700001)(82310400005)(2906002)(70586007)(316002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 21:10:07.3802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fec7c6ab-f2b6-4d0c-dcdc-08db571b17a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7133
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
Cc: alexander.deucher@amd.com, aurabindo.pillai@amd.com,
 rodrigo.siqueira@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Additional checks are necessary related to stream and scaling changes
before setting freesync video mode when an eDP panel is in use,
otherwise it can create artifacts on the panel.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2162
Fixes: 541d54055b75 ("drm/amd/display: Fix hang when skipping modeset")
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 14b296e1d0f6..7f322b18eda6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9285,6 +9285,8 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 
 		/* Now check if we should set freesync video mode */
 		if (amdgpu_freesync_vid_mode && dm_new_crtc_state->stream &&
+		    dc_is_stream_unchanged(new_stream, dm_old_crtc_state->stream) &&
+		    dc_is_stream_scaling_unchanged(new_stream, dm_old_crtc_state->stream) &&
 		    is_timing_unchanged_for_freesync(new_crtc_state,
 						     old_crtc_state)) {
 			new_crtc_state->mode_changed = false;
-- 
2.40.1

