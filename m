Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B27C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 03:37:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8956520756
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 03:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Q5Pqyv4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8956520756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 400BC6E06B;
	Tue, 11 Aug 2020 03:37:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C269B6E06B
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 03:37:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBHkivSx/NGMPl6BWvXD1ujM6uOkF78wHrKtPSbrs96Q/6b+2j5EHpbX2seDMiIO7mBHfCSj/pMNCbPOELAXq0hob3vm7ks29T8oztcZ16kkYLfEHQlN1GBjg7VKAP6IwP52DqQ9VAFJRD2HeevXnqD1JS+H6ycgdD+IWpyRF9GRDWUU61ptPPueTW00xV1xP/ZF5TuvlnEmdRWYhhYb4eeoXFU/m0+d+URXFEmelsIM6y4y+DNXPS+e1dRr9hFF+5sxjqJtrccEekJUi/fc9weByVxAmvHbIjM3CSQ6CiqDUJhuBIYVJqDKXAjQLM3ZzO8YNEHmX6S36sRfR98jYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQfauHC+5n3FYvqtDVlWhzO0etRI4MUroGGfK8rZ2Qg=;
 b=Cz8WCmmsS0jvPY0/sQrySzGXfE7Y4XY0V7e3yybDimubkzHmzfb2iKLVKVPGJrsszhFuNQgO04MZ25nQwPx55t0nb0U/z04xuEAJ8EZgB+bbiORrz3pGcMbYNZFfLORv7tY8FW6SSbzX09F25JJuwXsfoRiYL2v7KlHOcrMrFPELIdDW7yxHx+2DEq1qL71OSClbU7/6deuzVqZ8qJ0jx3KKx87ePIXK/47pcw9PnHFrlS1t4P7A5MeGWR2X6RSu+4yJt0eJy/Hr3Q3MBDQNCsTYYYWR2fnGDYQ2eqUsi+G0GyY8Jgx6+KhHPRqKeZdyEGoew/ZeID9mhX8dykkT+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQfauHC+5n3FYvqtDVlWhzO0etRI4MUroGGfK8rZ2Qg=;
 b=Q5Pqyv4tm9nrbdm3DAYlcqEktLju9VViKNRdFZ9qnurNm54hZjXoevm8zq9vJdU1Ms6MXh7k/i/+47OhNOtY+LxmvPox/GChda+2qJfxMckwd1WFh3xxJI92k9ZLjnTaZ3eZIn1cowePGp4/te/Bro6QpYztCqbK5JnGtnlvIm4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2891.namprd12.prod.outlook.com (2603:10b6:5:188::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.18; Tue, 11 Aug 2020 03:37:34 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3261.022; Tue, 11 Aug 2020
 03:37:34 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: bump NAVI12 driver if version
Date: Tue, 11 Aug 2020 11:37:16 +0800
Message-Id: <20200811033716.1114-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HK2PR04CA0068.apcprd04.prod.outlook.com
 (2603:1096:202:15::12) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR04CA0068.apcprd04.prod.outlook.com (2603:1096:202:15::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19 via Frontend Transport; Tue, 11 Aug 2020 03:37:32 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 655d1caa-81f2-4af7-5ec4-08d83da7e25e
X-MS-TrafficTypeDiagnostic: DM6PR12MB2891:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB28910CF035089E3DDCF1E007E4450@DM6PR12MB2891.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +NgNyL7I8I3nnYFEQbG8YtQBCBUmUbqjAWS2SISy/KRkTVcvTFCdLYJPv1q/NE/yz/8s3iOO4O167XDDST2hA2ANIf7A/8OvHDkxO5yugLGY4esr9tDTdlKcinw/np9o3TMlYyz/oOlzwNWBKLrHlnPwhEHlwblsYQ8hHQsvuEInAiiFx/QofiLEA7jZha8+Yi04LARs8butR6tSroh7HWqEY7TR/lX/9nVNpPdULK+7XJhjDIVdFbkHspTU8FMgwiYJsd5RtYky/9VkpMEGdDUY+tWs7HYoyIciHczGI+o95REbyqunOqt8maf/v3+oWD28VfdPjzw6y9qNVeU5+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(8676002)(16526019)(186003)(26005)(36756003)(478600001)(956004)(83380400001)(5660300002)(2616005)(52116002)(8936002)(7696005)(4326008)(44832011)(6486002)(316002)(1076003)(86362001)(6666004)(66946007)(66556008)(4744005)(66476007)(6916009)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: T3t4XecniTjR/r83+7O7NoEB7E8hZIBP1qYWVgX2Fgo3onSWwNL58pDSsueZe5zeBFRKmyDeDMledVgoRR8p1O0xG/2Wu9e92gvulW7+hxk/c2wKa7UvaEahJ+3YkP6MywSf5b8/6ChNO174bU5I3U1Ssq3cAUYxkgT1dgJOHepqZRBCgcEcjylO23kZL2AU3buE3w02F+S5AUYEZISUbY5fSKmmlEby1SPPLggOfeweuqnY2MF0rwk+aPBY6OgRgroUuD3Uoi4gg9NaO+JKonV+k6haUpJN5Y57wKs40NCyLkrJN5jAdGn6xAaztVI0ZZnw+CCAL5Unsu4MfjsM4GUjQu5loWfz/c94CtwO6dwKZNp126EPb3fRA+oXDbQQUgQ3YqH2ODtHBgbtLNjMOItovk6fYVFsX0DHLKHKbUK4u5FTXVuS3Q+qfGG2xPabX0MtCMg5IzgDx5IBVgLEtPaS9d/vF/oMRmNV8guhSZ7tiKa9xQ5l/ErT4o/tgcrqusdpqMEZbEeZOzac17oyuK+bpFbVTSyB4ujwQrbOKYOTrSV6jMzfUMDYHyRyCadbf7Db7C4MAhrR2j7MkXPe/auwruc0KYGE7kg4X5RyWlshSS1zAw07XBl2RuloOFsPgnhota7k/+v4+8n8oF154Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 655d1caa-81f2-4af7-5ec4-08d83da7e25e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 03:37:34.3811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6vRsjBVTsjlNCsb5/UN45hh1FubCRKYejWB0xWEVJrYo9XdUyfeRWeEy2ION1ye
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2891
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To fit the latest SMU firmware.

Change-Id: Ic9d02de54d20b6b90d18bac8b3fbb356d8fdf3ad
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index ee1506beb0ea..65363d56e3cc 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -28,7 +28,7 @@
 #define SMU11_DRIVER_IF_VERSION_INV 0xFFFFFFFF
 #define SMU11_DRIVER_IF_VERSION_ARCT 0x17
 #define SMU11_DRIVER_IF_VERSION_NV10 0x36
-#define SMU11_DRIVER_IF_VERSION_NV12 0x33
+#define SMU11_DRIVER_IF_VERSION_NV12 0x36
 #define SMU11_DRIVER_IF_VERSION_NV14 0x36
 #define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x35
 #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x3
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
