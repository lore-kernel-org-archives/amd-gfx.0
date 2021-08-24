Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9573DC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 18:23:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D00E6128A
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 18:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5D00E6128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E97C36E0B6;
	Tue, 24 Aug 2021 18:23:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98DD089B3C
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 18:23:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/FI4yb+t7Jgx2C3eXK062q24ZwDNGm4BC+LHrII3xjLCU6sMj8+TlpFHzSvR+FAt7dSUpegxd32Y1U1/vyfysM/Eykdw4+GsyUF9GHEg64yWJT3hvYa1ckK0/yqiSZHypI8YBplQy2qoczh7V/HfOTuW2ySPwzlFhgj4xT9vlfqJQ9iH6uYh8XLXgrqmkWz9esRCyiQHUEb+ddWIzjvr8QRNe/qLbW2Inuk+z7uWS6u19ELQn3IGWugCaSPT1uLRpfIQO/DGBkV/rXj+JmMrhReGodutBp8FA8P8xI2qSmpuSuUcKdOAMInlaDEzZQQApOsAjh1uBmcUrLoC4FwYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/r+XBeHe5i1no2+yS9KVzD4qq44cvUBPs72wJg/JPqc=;
 b=hMS65LkhjRzQSqLKg8VyBOQjiyBkq8BpxtsuuUFDVX/EtM9dUtVy75nRHs2cWH/7YbYORzSXzf2pLaooj2o9ClwKK1b0g4jUHLVR6BoAy0Be5bLYX1psbF/9xZmWMjeuxYLrgaMR+uXvNdHNGDmFPrehnrwIlyNIN7AXTE9GGDJ4zSFyM8RxsDCwWC3SA3ryfTTLen4uKNqL06kfCxE++GYPft9XKx4qD/95EkTUDjWO0kQ34STYBGj6Uv9Q/j2zhwd513hdG7owuxjd2vJTMHgsRN8k/uEz/KHWRnuNPgN+J3JfzOr43+/HcSFBHv4J+YUEwUMzyB3mR5UDzkNQQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/r+XBeHe5i1no2+yS9KVzD4qq44cvUBPs72wJg/JPqc=;
 b=bUXsjHguPHAzqHeOFZhz55ZQU0ErViC3tq9vDh6isPWaMlQuqb68Mmi9B/ruIPtKgMRSNzOaLPQQb2/wLlbFsQz72SgpPQGT0KedWKhd+/iQhMiJMaBhv9i6D/52sq5fC6968oL6M0NMACHXdb6tRlZmKea4Y56fa4BGwepO1HY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL0PR12MB5540.namprd12.prod.outlook.com (2603:10b6:208:1cb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 16:51:21 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5%4]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 16:51:21 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/8] drm/amdgpu/display: fix unhandled cases in
 get_phyd32clk_src()
Date: Tue, 24 Aug 2021 12:50:59 -0400
Message-Id: <20210824165105.1913700-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210824165105.1913700-1-alexander.deucher@amd.com>
References: <20210824165105.1913700-1-alexander.deucher@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:208:23a::34) To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR03CA0029.namprd03.prod.outlook.com (2603:10b6:208:23a::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Tue, 24 Aug 2021 16:51:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fda5ea7c-900f-4087-fdf0-08d9671f667d
X-MS-TrafficTypeDiagnostic: BL0PR12MB5540:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB55404587833BFBE4141D7889F7C59@BL0PR12MB5540.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:220;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xyxu5Ra6ceQ8B2lS9qlN18wCYfK0DtcUXy62eHA+tYcgiQ68kwJWaxgJ/qfnwuIv46TPVUIDr/Wi9S1Q0I59wWnbaSIT+cg4jGWKe7/mGX1Yszic+f9jDHh/v0g7f6D9fSAhYK3S++7RzAXwExPWX5JOuOPHDAa8tuUtt9kqaX/BzEOlPejrxABKKjPlsP543VC/ckNuA2xGjdFoPyrxl982zphnImXj34MKERs+Hog3aGiyhr/q5wevFu38ZVaaO077CmKqW1BTTnZaO/UmePnegoUitrMuprLJwesQ2vr+76eVTSDe3TwunHfxc1bXe95tvIU/5MsfdUBYPvIg6JrJsOz/YsknO3OsijgW6+o/dxB9caGzq8RozUcsfbC2S/OJT4AburJN9nBIwQAZdJZlFuwrHQgZTLxPZT9bbt19adT01MQCctqWsDKjBwGHrR1/JCebtlkAEU1b2TYhVlnNkhMX4lAw506ZL56BiVWux9Bm6Qms1BuZqKlo8hC7aVGbgd1S7hWdYhJO4Ycj0HQfffk75UOtD5sNSbBEXNl5r7+z91RhTSmuy/RN2DZaaJDB0ep33yvgtxnV5D3ii50i/TA2UvYPFfUA9SRabPGHfABz5kN938OoRsHIAQj2NwE7T2A/nenAMHg0pSA/6nPv+YLJCuHBnZTZeBxxxdNoReKR2oas8RltJmG11twHBVXRX2XOrZP/WEbpQVPOKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(38100700002)(38350700002)(956004)(83380400001)(2616005)(8936002)(8676002)(26005)(36756003)(6916009)(86362001)(4744005)(1076003)(5660300002)(52116002)(6666004)(7696005)(508600001)(6486002)(66476007)(66556008)(66946007)(316002)(4326008)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XrZx6b/f3VHU68U7t30Zhg9WREs/UnjF71Tf/aGe2o1Fy9W2N6lCfX2sWfAW?=
 =?us-ascii?Q?us7OEEOD3MkloDWp9n6WWeZvPyAeUGpedNWOq2wPfo9eX1Noo0Wn+uY+8Yfm?=
 =?us-ascii?Q?8a1LwxCC04nyt5KgCseACAM0uQk/HauupfhVVDyUNtMIv43z19RPvn3tFQV8?=
 =?us-ascii?Q?O3iQ2gUtE1iUb/P/kWov86Yyaa3RO+hh0wAthr1MgCE6Vmjh40TUpS2pgPwZ?=
 =?us-ascii?Q?0gdLqObxmXss8G4dJ2PWJjr7FTF9Km5Fwlw9Ce7Pw0dDnXUM3U141PCLG9Hw?=
 =?us-ascii?Q?KlfY5Nvm3hxYxXACu64tRX07KhuEimCYGVYSEytd7J5NbscIWd/1+JFPKDB8?=
 =?us-ascii?Q?dbNLq7Y+qzZzPV71oC56dhjrbmEeiFUjp1DZg8SMJTqXHxWL3RPvY4StkcXB?=
 =?us-ascii?Q?8iSA8lNJQyjbEzi+slP6ELzd1aXfkgUiVU5Y+7WH2WWTTyDG3Lui+DWlAval?=
 =?us-ascii?Q?uvodsA+e2eM7jmYaMIddYhGLVD8LBuI80EEPT8cQS1dmdzmbeXSYMTZSUre7?=
 =?us-ascii?Q?2fppImp3oUkUzlzDRujYPl3TtEWUkccbfYjyZimkNtTon3NqktMJT1psupL1?=
 =?us-ascii?Q?8kaRwZjzFnxiFvXyTfrvlBIAg9e+Gag4YVnm3MHZgohEb79NTgHzCWarSmZq?=
 =?us-ascii?Q?weqjVId2/cqQM0bKQwc5YMof8LJD04X51WgRGdiwkkj4vTt80WCBvvTIzX7+?=
 =?us-ascii?Q?A5zD3GK2yVOYd2y8dYQn1X5wsZYYfsWYQCrZhSjyAhi8DrKnXiQ5blFZuZA+?=
 =?us-ascii?Q?HJs/4paWjz/JuFXTgOLS9sdQ0vBDL1vytqlglKj8RpGCnupdrXq6Qv49FsG5?=
 =?us-ascii?Q?mEcDVjco/3S240zbLm6qwkoTSFdSNfMCtNG/G+uEtgTqDF7F8T/IpQfuXnPn?=
 =?us-ascii?Q?C51jiP5sxpWRGvMsDi9FyILf+TeKyipSreWRoveTGamUcaBU0VgrdX4QEyCZ?=
 =?us-ascii?Q?WfASkHPwvogQH/rjVfaQfo5i1J3G0DZ06fQPmFLp+nmAWX3LeemnO8w4cium?=
 =?us-ascii?Q?Nl520YnXXnHs1ugNTbmikcnKGsF9npJp0g9S5Z9ddf64wl8HD/nGlFROtThv?=
 =?us-ascii?Q?y9K6xHSXKcgiJfAi/ncgjt9LQgftcKN00rtLoeIbvSf65WKzTepu+qW9LsBh?=
 =?us-ascii?Q?Px4GcT6hxDv395QR6wq41oQkP7DtJKspyLcIZ5gulVeRHp/LQdALNeBsQo2U?=
 =?us-ascii?Q?ajFE4KBABnYqnmma6Svgd+J5HUcu4Erl74p1HBHheKap+wWHoQTyPJ4wLPB+?=
 =?us-ascii?Q?KTfG8gKZMZPWHlFraZDElwKyxlaRh4PtMCxOqXkxM913g0RY5RJxVKBbdn3Q?=
 =?us-ascii?Q?j6AQue1XpVN6voLpwOcsBAI+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda5ea7c-900f-4087-fdf0-08d9671f667d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 16:51:21.2488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HAiAAiFLS1Q1XCM2CQMv2UTgmCmi+M5Ug9LLRT/WjjYRs0WcMyjxdrH5CLf40O0Kc63LN71WY11QrxU+Fmu17w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5540
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

Fixes an unhandled cases warning and defaults to a more
logical return value.

Fixes: 808a662bb3a8 ("drm/amd/display: Add DP 2.0 SST DC Support")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index 97de1c5ab3a6..29b9c128c87c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -730,10 +730,9 @@ static enum phyd32clk_clock_source get_phyd32clk_src(struct dc_link *link)
 		return PHYD32CLKD;
 	case TRANSMITTER_UNIPHY_E:
 		return PHYD32CLKE;
+	default:
+		return PHYD32CLKA;
 	}
-
-	//BREAK_TO_DEBUGGER();
-	return TRANSMITTER_UNIPHY_A;
 }
 
 void enable_dp_hpo_output(struct dc_link *link, const struct dc_link_settings *link_settings)
-- 
2.31.1

