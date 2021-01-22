Return-Path: <SRS0=42b/=GZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E752C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 20:07:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5D6523AFC
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 20:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D6523AFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 943FB6EA52;
	Fri, 22 Jan 2021 20:07:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A63BD6EA51
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jan 2021 20:07:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXwxd+L8F2PAKKBj0M+p91EqkXcHwvRd9o7i3wIMBWiPmsXBTwLW/CxpM9yToe7/WW96xTpp2710A6Tjs/rDFbLphj+GbS11gz+HxxHImabr1J0GK6hGbZfKyDEFvzTNh/ffyDmiNPckmvtUU/glHlOMFnfSHjHimWMFVwiqrnAMJth2Ly0hG/pVNDD74tpl+j9zLAnJ5qkttTNGHJBU5wGvHgV+W79euU5kcym2hy8ANuaA3q4y49VPPQMe4C/iSlxrJww0zyw/yoNO4OopH7sodgPPDhvPfjRH8qcAXTHyuSz11mIi9FxaVaoCB0NU0SPNGg0IEqrEwym1SwelMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Qra/mniXrA7mIcFaIkahBpFsofkppOp6gELf77dU9o=;
 b=ljctHp2WDyf7svZPwMr2ieV3Xc8giC16tFD4IlOdUxt/JUQlvmTT5wWZ8l6fSr96BbvgS2bMTgqupgikyhEToDBfDLUbyAIcpR7rO1XBFkj/t/euRMzdcm3gOIwl+hUt4SmdcZ6YedoemxUKTror2bINFjbuWQKhv7ZmWEt9P2nNZs/+LjL5djZxhQASGfpGWHf/JL1pPnHa50djpTQr0F9TrJPFii77d30F/3+5jpnr5DgjVJsfBYoNkTakblggMmJOntR+8OpcQXoxekGcrIGDtW6Fg4doUbIMQ7ERyuit8k/WfWqguXYypsxyXYNLXPPjj3mDBa5yrMFPKxwOqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Qra/mniXrA7mIcFaIkahBpFsofkppOp6gELf77dU9o=;
 b=S0EpoW/qysCV7ZdbOxuIu1oH8wTDwVACvGILOuBnnnqdAm7+IPTdhHRWeEeisB+RQTEhNRNCo4CjDdVkDVY/hK4ruOfUl/0271pgp/HAJZA71c3puk4LyDxhlW4D/V9gftUsjfgNNnHyxFmoqaZdFnc+J/aoxo+TGOJyC53EnME=
Received: from BN8PR07CA0016.namprd07.prod.outlook.com (2603:10b6:408:ac::29)
 by MN2PR12MB3151.namprd12.prod.outlook.com (2603:10b6:208:d1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Fri, 22 Jan
 2021 20:07:24 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::45) by BN8PR07CA0016.outlook.office365.com
 (2603:10b6:408:ac::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15 via Frontend
 Transport; Fri, 22 Jan 2021 20:07:24 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 22 Jan 2021 20:07:23 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 22 Jan
 2021 14:07:13 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 22 Jan
 2021 14:07:13 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 22 Jan 2021 14:07:07 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/12] drm/amd/display: 3.2.120
Date: Fri, 22 Jan 2021 15:06:50 -0500
Message-ID: <20210122200652.197934-11-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122200652.197934-1-Anson.Jacob@amd.com>
References: <20210122200652.197934-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e8d2b4e-ec7e-459a-332d-08d8bf1154e5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3151:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3151D97AFB13904C498D8FC3EBA09@MN2PR12MB3151.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2vaRN1Ok5DPkn8xV4J7OowFemhEXJ7vsiVGjEDWPOBzxIyyepJsT/Gx3ei4D+C5sm21xYxwv9/sdSPGnXJu10jFCo2Bze08e0IttWpGo3QkO1Ayc0nS5SqFrBH1k/aiVawouMK+k0UZqmuNzwQTI3JMXZm7teqqSlcUCwnC9Dvlu7R0RgJVyBR+XqcYMkvgQ200SIOQMRO8nvSWslPPVXIsEhbWZ9/441Mg+rJQ5W9rGK9mjEdg1ftUto8msu2jlIXwtF5VvjjQZ0cAKuAlKgUoYGnJiA4HWysqUrYzNByKN2Cf+NzbkIY0mkK/ZskH3AzHdeEW1vZaytOWbHYi/4T6FkmGpIhLuvNKRGGvqL2lK1zvo5JOLHH+JC5g3kR0unVFwiEDbLTV+n5FkHDWIjpUSrjYSArzfofFCagHveBZrqyGxUmu0jwGdJWHL+Bjc0HPW2NsfLJnPtMIzHBfeyJnpf+6GE2g12NMd9eCeUhq4y0qx9omgBchKlOnNGi/h
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(396003)(46966006)(8676002)(1076003)(2906002)(6666004)(82310400003)(5660300002)(86362001)(36756003)(83380400001)(6916009)(47076005)(81166007)(82740400003)(356005)(4744005)(316002)(478600001)(336012)(426003)(70586007)(70206006)(186003)(4326008)(2616005)(54906003)(7696005)(26005)(8936002)(36610700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 20:07:23.2141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8d2b4e-ec7e-459a-332d-08d8bf1154e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3151
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This DC update brings improvements in multiple areas. In summary, we highlight:
 - Fix display detection on HDMI ComboPHY
 - Drop SOC bounding box hookup
 - Fix DPCD values

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a41bd5a1a187..40227e09b6d5 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.119"
+#define DC_VER "3.2.120"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
