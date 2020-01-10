Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C8BC282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:48:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78DC020838
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uPf/LfM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78DC020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5DC96EA57;
	Fri, 10 Jan 2020 14:48:26 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770057.outbound.protection.outlook.com [40.107.77.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E10F6EA4F
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:48:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBK19orhOyHRZTAe/y5UGMHj6nU6FsKvyd/YzhnZLW4gKLZQG/IRDiQtOPzeSb3RAGEpVdThtxVLEDoRO9KKTCbQbqYxclN2DEf0hUWOAo+cx/ycdUoGNb8rfwjPC0bFwZSpgfM2YNlngKy+R/LiWxNGrBP4DnAV9I+/aauFjwIleicNSOKU58DiWEXzKccyFVHYvPLNrqUYpdBbw/H8RYI3F0Be9FUspsk5iFosKzFyBQ3G0blHplWmwg6SUoK9Gtn5ffx+7WTBYLo867mlMbjmIiGl+dFZjXQhzL9qbEr+c+oE5T8cpWkFQkVRbKmt8lus7dyoavZTtJY5XDETqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oOy2lJ0uAeN75THG2531XkaqHunsSlTqFL7PpoJO/U=;
 b=hv6UcLYiu9fBJ/lRiBo3I3zKa5EupoGniQp/AYIptBBqwHdlYCZtVmZIhnPkd0+gxdQk7Gno1VcHvxZniC3VsSkz7lMZjK+NjaOhqFmpzJkOM/Q+7dfc5Bc6l4KK+HPC7RVGcJgWz8XE9sA2yvRYofcs83rBdxSlKRXeRVUfwD965Mh050FMceJ4kzRlv9BQEQ5CzaGZZOLuaHsONA3HPaBf/JXeddFAUzC+HJuC3OM04HPQh/GknmuejkL3zoDmhX6p4W4n0K0CgoV7ehQOe3tuXSEKHGzVfSIDud4c25PoSd5yChDyd0xIeHzWIja2u4c5jI7/WCI0OQ4ZuAMBRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oOy2lJ0uAeN75THG2531XkaqHunsSlTqFL7PpoJO/U=;
 b=uPf/LfM+usuPQxHgmWJvHnjWiv3Q76iGps6qOPC7hUxSe9WrE5sqEYD22kbgNWzx7RhGqiQtZrdWyj2gnQ6csK7kr1mt2WfXcYjZDM5ROqIztWJYmdKwEnUuZ+X4z4LXo1vZp0pdDkBX5FPU5F2VOt+K+gS5fLVUH7WiXGrlLos=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2378.namprd12.prod.outlook.com (52.132.183.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 14:48:23 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:48:23 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 42/43] drm/amd/display: 3.2.68
Date: Fri, 10 Jan 2020 09:46:54 -0500
Message-Id: <20200110144655.55845-43-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
References: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:57 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ca90e56-956b-4d9e-dc63-08d795dc155f
X-MS-TrafficTypeDiagnostic: MW2PR12MB2378:|MW2PR12MB2378:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB23786627475C70BC52489E5098380@MW2PR12MB2378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(199004)(189003)(54906003)(52116002)(8676002)(81166006)(81156014)(86362001)(478600001)(7696005)(6916009)(26005)(2906002)(316002)(8936002)(16526019)(4744005)(186003)(66556008)(4326008)(6666004)(6486002)(36756003)(66476007)(5660300002)(956004)(2616005)(66946007)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2378;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KtNRFgAjm5fK0JDUOOXuh4lonwY8pZzjtNjX6sfJCw5mWYU+zTS8qdK8FbMWcmYgp/9kmb3sHb6qpv9677hczF0rIPR3PxHBqo6EzNH1TaPfAUqif/QFzoXOzYrl30rvYMGSIBp2qVY8EVe4i3Xp0TBfqnaM5MliGx+zspuKJVRnt+JGWayWzk/QBSxD0MeNERjF0sg7suNXP3vVp5mXd9KIwSoQrIHjg+y7x8Wln6mgHoSHUanjc4WqmRmAfJTqDysf0O8b9TSrOkz5ybeGKc3aGbXRScEXcxC4TVJm+e2MU5kJIHpfT4O0vcA9IyD65RM3rjouv94itjBUN475GgRZUHPNCC/dTZM5Z+JuHVLIDXCz3rR9JArJI7f800/wHvwXFCoLpcOiLQz8N6I4MOuEa6A++JVNhKSmTGP7sOhqb88wk0ERsWXaVSuUBQuT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca90e56-956b-4d9e-dc63-08d795dc155f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:58.2520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZVWZ32gfaJhV4LVuMca3xKScsPPk272SoDU33xCzSKbA+YYcEzm8af859L12vtrLY8WpzacLGCHEVTa2PoA5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2378
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7639fa074c6e..3fa85a54360f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -39,7 +39,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.67"
+#define DC_VER "3.2.68"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
