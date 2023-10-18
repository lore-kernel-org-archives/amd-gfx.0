Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DDBCDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 17:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC4C310E44D;
	Wed, 18 Oct 2023 17:44:08 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2081.outbound.protection.outlook.com [40.107.96.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 065D410E44A
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 17:44:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvO3az4wTt3uTipL+SzJt4kGSBjn98BQ3i5HqKYtDZhfFskGIqOtEcVTjKkQTiJ1efG5bTyl9Xjge0QBcU3miFGoOVgUDQngLY983LHnmecILxVsRjh/IHAkg4EjoX/ELQ561ZA4GBTgepHWCUn3FOK+9IMvnOZ4vUbwrEpHNUlZRsOhf9qb16N1oOg8oKc0YK/f48VKpsvJBb1upqkNEVVawJV+orTfdaU4mp7uiqYzKmxWC7ebe5DZLexV6sk56DeaQ+kk4w8UF73T90kaBBMDGKVAq6PtmaTmszjTVYplBvdgX2SjhJ+stbgwvvOYRAVyaVJSS+QJzJdee+jL4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45M512ZGIZhuazxyKKbV931WbaT2hC9s4mD7E4/rtIo=;
 b=CJxjLcErH70TtvogtK+xGMQsjl/xwpVmBH6wFPEx4N13x9FARs+OfbmiD+pRmbj86Do1HK6J8Xqnikfk/uLr3f7dBAYlq6G9L6kWsKf9wFKwZq3A70fJtZwaCb+3+Uy5RUuSvErJNlYvZPI4hz6YWS3DTpl7J7VopiPwNvjGRTME9/WOvdP5is7RQYuBlqP4Hzg20XEeAb31woQ+m/maOPRENw4ef5rZEPx58A7ZWY+nOaesaxj92juNYRQgpzZnMQEhvhM34Y1Iykwg0D/LYZJ7G0FGAcFcyoTaHNfId9f9eK4z/TXgktEjpIE7YiydG4wDl7rJH9YDoVB8S7J2yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45M512ZGIZhuazxyKKbV931WbaT2hC9s4mD7E4/rtIo=;
 b=S8QbifhjqCAofey316jE4SWz6dacOLtSOw2lfuni9ZQCfEdeCBbNFcb/3B2cGpGjr1sH/lCDl7Ef+KRmNy+HFZO4vCqiUeBBUlV0jVZTixyIkV/rv4knERdgSh13l0lm32RchbRCmJ28pWAepxuq78h23TASHb9Pmueg9siH1nM=
Received: from SJ0PR05CA0122.namprd05.prod.outlook.com (2603:10b6:a03:33d::7)
 by DM3PR12MB9433.namprd12.prod.outlook.com (2603:10b6:0:47::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 17:44:03 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::8) by SJ0PR05CA0122.outlook.office365.com
 (2603:10b6:a03:33d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Wed, 18 Oct 2023 17:44:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 17:44:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:43:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:43:11 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 18 Oct 2023 12:43:10 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/26] drm/amd/display: 3.2.256
Date: Wed, 18 Oct 2023 13:41:29 -0400
Message-ID: <20231018174133.1613439-23-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018174133.1613439-1-Roman.Li@amd.com>
References: <20231018174133.1613439-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|DM3PR12MB9433:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a54a3c-8b50-4fb0-3068-08dbd001d13b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CqlEFYFx62kgbLd9+Ad0hN4Vkss/WmW7oB8oshRjBePtbjT/IrA5NaTRMTXpB4Y2W0pfOVGDkmEnhImiG+RMSqwn8xNKp5IC6ArU9lBznHpaaxvDeGMIJbegNsNYU4bXaE0eu7mfb1bkh/B6/czbq7A8bd7+F6nc79F340Jnm+zT4mPhoSY5qZrQJUI76g6jBwjjej4k4sJOPGJ5MM+JLT3iFxR28rHiEkKmpmXRRiAULiYqVmO/N8pvppHN/BOgelmlwksEAmjmZZxX0HFTvwXHqmz8gwyG9hqr5HfO7Gi5GQK6c2WIOMwfTztBzLOB0iUey149fFDQS6HPCBO9mYJnQ6VBAzQ3TacPsdnnXNqcEDw7rOuXwrYfWQ3u0QAz4BqnhdRlCbX0H4rxN+PZlPWq0XBow5svFhR347fXocOLc+Y3lyGSqn+lGd1j6IedxfNM3/o6FA2rGzzYRrmSHSMQ2lTuFnaOQF1A5qX7DRA7/XWTUJaM6YGPvVN8jQGR0uixSXr0DBCJIxmiKXiaxfsTAuzoKV2iucmVmZA5a5+pLkMkGtyLUsb1ACV61+GidxxvjgtKGN4eplh11D6Sa6J+FGSfFJp7hzDliDnqwJRms6XPptFqO77cuvLWjlbcpSr7kf8DX+vYZXYreoiXTJKOSSTygWE3FXardK0LLD1KB8ua9Y0scuGGEb+SCJuvqlUxmlCYMxr/AvNpc2y2OiEeephAZq3sioODDo1NkKnYZ3AzM/rAefDoFrSG0/GZTP6XQdVeBw8M8h+nJ8z+vA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(1076003)(40460700003)(6916009)(316002)(8936002)(2616005)(26005)(36860700001)(4326008)(70586007)(83380400001)(8676002)(54906003)(70206006)(47076005)(6666004)(2906002)(82740400003)(478600001)(7696005)(5660300002)(41300700001)(81166007)(356005)(40480700001)(2876002)(36756003)(86362001)(426003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:44:02.6294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a54a3c-8b50-4fb0-3068-08dbd001d13b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9433
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com,
 kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

DC v3.2.256
Summary:
* Fixes null-deref regression after
  "drm/amd/display: Update OPP counter from new interface"
* Fixes display flashing when VSR and HDR enabled on dcn32
* Fixes dcn3x intermittent hangs due to FPO
* Fixes MST Multi-Stream light up on dcn35
* Fixes green screen on DCN31x when DVI and HDMI monitors attached
* Adds DML2 improvements
* Adds idle power optimization improvements
* Accommodates panels with lower nit backlight
* Updates SDP VSC colorimetry from DP test automation request
* Reverts "drm/amd/display: allow edp updates for virtual signal"
* Removes duplicated edp relink to fastboot

Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 47b767fb1ee8..aa4684be1d62 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -49,7 +49,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.255"
+#define DC_VER "3.2.256"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

