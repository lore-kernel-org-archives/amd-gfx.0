Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8699CD98E3
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6031210E78B;
	Mon, 15 Jun 2026 23:57:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OSLGzGWw";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011039.outbound.protection.outlook.com [52.101.62.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5077810E77F
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsb3rBdJebhbwKFibiXozansutSVd6TTWhQDGNUB26ZpDd0TIMKRpeiSxxtLkk3pGQ97AQlT1HKoYrKZ2j+lnEXoZwnK1YiaH/aERq0giGqBqKvthT3CsxOo16Wn2RhOLSgJ6YUJpLWbzDPFejRYz5ehPwNp7iSqtscvmwXOeazdca1isyK64m651IAu/1OcCzQVLnXsYQNF3Rxy9NJjP7TWvNVpGNo+JDbC6iQATwemZ/IPPf1EmFfBn10h9fuGP8CAhbsYydlvtLJJpZ/RXvEsL0u0zBeOU6ayRH8iwJxye4H+Zrq4DEgW01Z9cJpZjxte7pC7CcrOiJJt3u6m/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvkB5oxB9XkKiHE3QBMe5pEHY/jYk5By8QbYIgahnn0=;
 b=gnCePN5qAQLv4VzbnhlpAXpWs3PsfKj0zQ6JcATjHsrvUufZYxwEjNQc7K8cu9eVhrmKxmlQdQ4rnzXdbyzP5uuYqf9HoPgH72km74qGPal5bt4f/RbkdHCSflbungm5AbJirvR2BlNnCvsNYiQfbjpRllLtuWZAOWGuk4V6lKDAv6UW1+MaXdgKzXyY/aPmSeNDsfo6V45JvO2mNZonTzt4UFag0IExju9vEBAWyr4qHPsXxvDtGyOg50RfgsCls5v/50Q/HLCzmruwF2glrqzcfhOnyAOw2U/RXgy1JW0xOUCdWSSZYNPCyXYoOPixGie0ri13v5zZeDDm8SCGMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvkB5oxB9XkKiHE3QBMe5pEHY/jYk5By8QbYIgahnn0=;
 b=OSLGzGWwshMrmpnMh1gcmqvqCh6VAeX3N0qp7KA0EmE/tVRpNAMzNqY45du5Cgqi7Q3tuiYfQ2HtVgIY1WCYmvk78azxMGKYyU+ElGZB+XA3gHMSjOX48XD8YJlCAykSMoha+Dw7dw8tS87s6qf0VuuhszhSpfCB4QRTr9gmFk0=
Received: from SA9PR13CA0053.namprd13.prod.outlook.com (2603:10b6:806:22::28)
 by IA0PR12MB8861.namprd12.prod.outlook.com (2603:10b6:208:487::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 23:57:14 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:22:cafe::84) by SA9PR13CA0053.outlook.office365.com
 (2603:10b6:806:22::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.6 via Frontend Transport; Mon, 15
 Jun 2026 23:57:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:57:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:09 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:08 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:57:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 31/43] drm/amdgpu/psp11: replace BUG() with an error
Date: Mon, 15 Jun 2026 19:56:33 -0400
Message-ID: <20260615235645.737189-31-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|IA0PR12MB8861:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f975377-f103-44c6-005f-08decb39d29b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: EBalD2FwXJ8FYs/HNI+dU/8hJf/MZ+2h00KSUVgYSwZ5zpGweNbcxPXsdgersxhwzLFqV+zsc5whlUI3eSMZ84l8KVG8YGgL5RGeveDXNkVr2yyDE8ibaC9gn64ENWEeYySTh4sEIskZzyWiRAHORV0biTdH7Z6GLs/+J9T5WZAtsWm32roYZpT9kONZAAryA9WSwiIwy6K+BHct6ALj713iD7M9viyUrGfGteqcmVSAaazpSXWVmGi/HlHj1ljuxinXv6BKaAFS7Yxw7AOjI1T/ByG0bYGIbSs34vO1CxNSSxskho50B1VpM2BkuBdBG7T1gechIpR9TYGGRVkR1GbfHp0cUg4tLO/X3BWfqOSGRP5NhBGzu3tvRn+hazP498GEoWCocb0H1ccXfPWJty8u6vKRB+skSgngKCntBrecSfYTBADb1F/aTevEYQmwMoabO/xtGklp611dzr+888N1uNLvbpvW5ArWKsJdoNaEdnrAbbstxQuZn6XNrT2o3hgyGHKJ2Wn4KhL+Fn56Ynzia3CavNzhwM6wCLlGvK0BFuVdTSN9kvucj9m2CYUwvj83tyw0BN/Drmb+WM9tniUejPPKM0fba9kur+tNfMhNGz7TP9jJNn8aWxZeC7+NjHg+JBbKcyJI4KxNTDo9GtsBK9Txv9C7MyUH41VUJJOm2RATWZaBGSl0pc+59y9DirR/ogqqNARbY9zgTozbvZoRm/e0THX5Xb9Sko5aq6Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JWmdqL3nZnHKhw5qiE0/rhzHRRDaZpNRcRrW1ErXf6v9GKZYQgLrOwWripBY4UXgVgY/JqXZX/GARXlUFsKxz0vQGRHbMvAUAiNWXwESV7ihXhKgjUoacPhUWUb6sO6bZEWxIz+lh8x+EWO3Mtucv1jx5dK7y+tKTSyJmrTsVPbibHUSpXeK6q6Qsa5QJ5/7lYNl3DBPeTaK5uw9nkWDssKbSp4XvsJk2i2ZlY3/sGB3PxF4v7821ZSQVzAmUlOBtaa4p8h6h65RPKDrFS60Nr2fwI8Kamcm0yKgOky270QHBTlz4lqX1CIiLo8vWIXIsl6RKi98rYL9FK21A0z+afRbaEk9zKz4zGzJosNc4cNWLReLskM+OzGEa/eqC1gotyKC9XzXzhA2i9wKA92uqBV608pbovpWJfwRKjyXjzhI+beAl6Z9AHtaKw2Rnp9/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:57:13.9526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f975377-f103-44c6-005f-08decb39d29b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8861
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

There's no need to crash the kernel for this case.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 479690c44f0d5..ca36d434cfe1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -136,7 +136,7 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 		err = psp_init_toc_microcode(psp, ucode_prefix);
 		break;
 	default:
-		BUG();
+		return -EINVAL;
 	}
 
 	return err;
-- 
2.54.0

