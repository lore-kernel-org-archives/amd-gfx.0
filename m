Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CCCC43334
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:36:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DC8410F48A;
	Fri, 17 Jun 2022 19:36:16 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2059.outbound.protection.outlook.com [40.107.96.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36C9C10F3F7
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:36:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQ5ECg2OYfUiUwmaUDf9oWKAougKeGemkVL02rWCMPXCRnYZto4oG8P0F13C2+l/xxdt68rhHEhO19MmGu+g28Q3HU60qaaoyORfyto9RBwtw1/hK/jbhkI+2VuFEouHrhY80X47Zn941q363xbQlPWfhJTg/X25rg0HOlcWK9rOdvoDOXT5updywFBFNZVroyJlqG4M15GGhwfsS6YFHhP70KWM96K7thgq1vzBWhcqdhedJFAlYJk3AReYc0HG+xnozo4eWnhZ8kSdR/XkctF+7F0uhJzNKp/QYSDp7B9wT1Gon8BWHo2eO6gw9OB195rGQKKaHSnyIZDBgPjsHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELYHG9JawC+qgjvz7V95U/x/r9SU1nlXxK0iivfpTfw=;
 b=UFjXJlb9HIY9i7p99IdidYsPIGfWOaqA79lWVXrM/+WqrF7NbJHLmTfrF97UUyzR7d0dIa9c1c+FACUWSph6+6uxDHheg3y7NjXrRHsUMx1wmvGLrTaLcr4UWbAG88QoGHuIL/pBUcP5eEmOYmbU3kYl4+tdLNyqVZU/+8Uecx615cN0xTGL3Z//aoSRlBH/b8n6SxyrJ9BEBKvvfZA3a4NliG8BmtVj4Zz4ZPXcaOaQ+X09nbyqIHzkz3z/pcGYAjhNiJuLpM1HYX4Rf7bRkA2H2G5XR1MV1Cy2jeCqm3kcrWHF7Lvamhjs2pmQVdMTJ34FPnZYr1JzzUtxkdQCGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELYHG9JawC+qgjvz7V95U/x/r9SU1nlXxK0iivfpTfw=;
 b=EP//tlvtUs7FfVOerxHTpZ6O1a7veuKN65ZlpwP3PiIkQohD0KR122ILQZMjpvmNLnoQEmxb/LKzu0I9XcS3SPzWZPo9QI1VJ6pc37NsB4JiYSLrOcff7ivEuRiFTFS/ZHLBO2d7E6Lj3RhDASZdFBt7EUrLamtRO8NQ+ux1v8Q=
Received: from BN9PR03CA0765.namprd03.prod.outlook.com (2603:10b6:408:13a::20)
 by DM4PR12MB5119.namprd12.prod.outlook.com (2603:10b6:5:392::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 19:36:10 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::c7) by BN9PR03CA0765.outlook.office365.com
 (2603:10b6:408:13a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16 via Frontend
 Transport; Fri, 17 Jun 2022 19:36:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:36:09 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:36:06 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 31/31] drm/amd/display: 3.2.191
Date: Fri, 17 Jun 2022 15:35:12 -0400
Message-ID: <20220617193512.3471076-32-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
References: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5f0484f-2f92-48de-ba11-08da5098a150
X-MS-TrafficTypeDiagnostic: DM4PR12MB5119:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5119D611FA2AC95FFC55AE5698AF9@DM4PR12MB5119.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RPWYIIB18bdMEsQpoQd5KGWPMyG3XKt8qAS3ulkruPDis28tisi/iyzx3dRZ0joOHHyD+OOwaQ5n8pGwwPYjnlKaCSxEMtKQk3JGqL5InvQpJW1Z2ibE41a5+GK7Flgszw+Q5BduyDkGghl38dNs7mTnYMUjthxaYE9w2f3+Vozyz7T2hgFjwiCrA0WHHbsmFNeYt9WVnMbl/je1LP/ejSrfct72Ye77Su4LO6x2wJNpa6Be8+9SOmmu2L/rWGClgXemln4/8UfJy+Il5GcDY3ODap1kWDhhmTt4qwcORtvSv6cD/9jyv8uMeWCgSzJYyZDnxMsiCPcNznHLdrJK5YimzO9UgSh4N0UFbTWYM87bRp0ry5kzd/ubwubDl19zt1i072mxqJc6z+rFi+V46sCNW7jDpeWzK//wcLRN5SQsOcbzaT848B8aAyAwgNh/PYPTuFu7nZSopOonK68KG9uWJbaY9N3gC8Eq905N5nmQsJ/K5c8Dif8T/DadjFNGY6gROuShRZ1GgOAfQ/SZMYmbPJHYjdrN+nb+F3b6qsxsfnpQkT3x5Ehd0gbqgi/1klp6r4snZkV7QN6ggd06iEfqslkJp+fSmoOqq5FMdDwT10VUSdi68JUKQSkN3xyl0uae66T7NB+xf9Tdsv8VdDRUZSnr3ONqK8pc91uCkDmSUjFUGPpSymIEhnvchjQUxkUTWffdgPIQiTjjlLwUwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(498600001)(4744005)(5660300002)(36756003)(7696005)(86362001)(6666004)(2906002)(26005)(8936002)(81166007)(36860700001)(356005)(40460700003)(82310400005)(70206006)(426003)(2616005)(336012)(47076005)(16526019)(186003)(1076003)(83380400001)(54906003)(70586007)(8676002)(316002)(6916009)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:36:09.7238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f0484f-2f92-48de-ba11-08da5098a150
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5119
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

- Remove unnecessary code;
- Small fixes (compilation warnings, typos, etc);
- Improvements in the DPMS code;
- Fix eDP issues
- Improvements in the MST code

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 81e308d59a97..8292f27c1516 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.190"
+#define DC_VER "3.2.191"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

