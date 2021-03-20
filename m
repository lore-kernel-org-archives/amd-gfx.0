Return-Path: <SRS0=4T84=IS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2477AC433DB
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Mar 2021 04:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8FF56196F
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Mar 2021 04:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FF56196F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BAAD6EB2C;
	Sat, 20 Mar 2021 04:19:32 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750078.outbound.protection.outlook.com [40.107.75.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8A7A6EB28
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Mar 2021 04:19:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRNjO63DsslaQX+vmj8LD8zoZo3A+GexftZz3HujcwBdA/jqMdz8+ZqENTE+NwrMh+XdGMbPgpcmp91Ip1zYlQApbGMpYIo8kSSCprka6BnYxTzprBfmNCgCq055k6zDVu19ZKSIWkO0WM6ez8j7T3hulOpoOp5KGsYYbObIOEMsuf541aLl71M2uazMrER4IpC2LXY/UcXI5EpOptYVyOoix7Do+ARc3cfiCVQmr/A8ok3AJ17YsBV3N6Q4MfKnO301SRAtv+m3WZsechoy2iIz33f6kYrZM8fYbA5z1jWIoHI7Mc/e9451hXoS+Wn6h3jUi/k7y83pitvT4EXznw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiQun6OR1nYycOcoWx/hfKf12T0b3iGAKbwYalzrmj8=;
 b=f2+wv2qRauRf3AksTSinswY5vYAsIFU3kZhQKXGvn8M23dNyRUuAgTWjerAIpmKBYjmKlFyTxuOQ2SLCYET8vBrnqBW7FQg1YoikT4uhfPlJPvuc/o9oPTOn/+teSOIfyKy1JcOP53unnti9GBNnFllx7oJX/+e1+CNxU2HEl/XNU44wCeTZVIw+pVwSjdI/HlGsxnR/RFTOR/vqLDozsPiccq5pplky3ktkxH/iaYq2yqSm6jUccA2+xnsn/DSR4IXIwUwmUlNvdvqvBParwhkOCHIjjerukYKfc0Q9anNbQaxTmNNlushOUV+r3k78YJW2JoADwjFibvkWv5M8Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiQun6OR1nYycOcoWx/hfKf12T0b3iGAKbwYalzrmj8=;
 b=b0DcYl6h/UkwWjg6hyEgllfYIsOriId6rUQRQ+AZHPc8y3Sz1ryNBwkfRpcpJ0y7iAvEx2TWlsho5B5hzrBejEmAyKzWW6XOzkWf00r1CYQFV7QLw8JzjpBKMfeUYxiy9jqGUuP9731foFHNErLGk0jT44WQm7/FBCi+iPwaK7A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2605.namprd12.prod.outlook.com (2603:10b6:805:6a::11)
 by SN6PR12MB4704.namprd12.prod.outlook.com (2603:10b6:805:e8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Sat, 20 Mar
 2021 04:19:29 +0000
Received: from SN6PR12MB2605.namprd12.prod.outlook.com
 ([fe80::5c4e:1bdd:5eed:b2d1]) by SN6PR12MB2605.namprd12.prod.outlook.com
 ([fe80::5c4e:1bdd:5eed:b2d1%6]) with mapi id 15.20.3955.018; Sat, 20 Mar 2021
 04:19:29 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/14] drm/amd/display: [FW Promotion] Release 0.0.57
Date: Sat, 20 Mar 2021 09:46:53 +0800
Message-Id: <20210320014656.23350-12-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210320014656.23350-1-solomon.chiu@amd.com>
References: <20210320014656.23350-1-solomon.chiu@amd.com>
X-Originating-IP: [165.204.134.249]
X-ClientProxiedBy: HKAPR03CA0030.apcprd03.prod.outlook.com
 (2603:1096:203:c9::17) To SN6PR12MB2605.namprd12.prod.outlook.com
 (2603:10b6:805:6a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from LAPTOP-K5LN3AJ2.localdomain (165.204.134.249) by
 HKAPR03CA0030.apcprd03.prod.outlook.com (2603:1096:203:c9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.9 via Frontend Transport; Sat, 20 Mar 2021 04:19:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b93d4d5e-5f66-472a-d743-08d8eb575a68
X-MS-TrafficTypeDiagnostic: SN6PR12MB4704:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4704C2353E40A12655BA1C1097679@SN6PR12MB4704.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YsEp6KVzUIqy6AqMXTJC7uir4aL8NXJeKDhoX4BxkACN/oP4og2XX3qnaOJKZ06EaWhODO+5hnEBUMw2x7HL24v4olgTXm3vnQ9yX9snB9rsW7994IMlJcQ5hKAyc0g1Lhatyq+AvyHACQkhCPLd9jA7UeXFKN/ZR4QvzfhvNm+ZtzXmAoWTWmYDNznMSMrgyOhdISg97RwWqHaQE4jbUl4GHhwnw1027IaXaXrWHaldjAlopE40wP2KkeR+kyjB6oqNE1IpzZh9HIRi12TxVV8OJ4P1/aIIZWeHUotgQiWI9pgs60yaL4eY/VFiEAMRNRg9dZx1JuZ8xNjEZmTOa3RLzV0TftCz23sow/ZpYIt9Cw2huP9sPH9ZbffREHwF4KWdS/0E+x3geXqERaenSGf5Aq0SB7hlamb2Us5FNvbGhT0G8aBEGkonLRGOpUiLrh3DqYy3SF4i6BSs9OUpX0zeJxR15xZ0UAaICtSkoqirXsdsjufojr7aSAErJ9gHgPHn+54Y4XQTZTKWFtG2g4RD2kLNtYhX4S2psFiAzGCrj0OhHEiGYK8+JxbxM3NHsGN+nvgHRn2pWGDE+A4oPrSj7fToP2FuXEMCJ90HD8X6Q/055hGNNodjIhbpJ2suupNduQ8UnomkVxHBz5dQAfSRBeXgwUNZCQosiHdSDuA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2605.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(8936002)(6512007)(44832011)(6666004)(26005)(478600001)(4326008)(8676002)(52116002)(38100700001)(36756003)(316002)(86362001)(6916009)(6486002)(1076003)(2616005)(54906003)(83380400001)(5660300002)(66556008)(66946007)(186003)(956004)(16526019)(66476007)(2906002)(4744005)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hDRldX/tvqtNkyYBVQpUeeCSuIrAjq740LSj+OcG5wPuHBdWVdXleJJK3z+1?=
 =?us-ascii?Q?FDyndxnp6V/4X1dlHV60B6sDF8W5lMIGPYhyCQzVKdPfbicW9NiY+PhemtsG?=
 =?us-ascii?Q?/pyHB/btLTykTnxnbG5gNUCbv4ahI37efb5V9zSXNlncFhPZtmwGmZJihyYT?=
 =?us-ascii?Q?kzlfz+PFqjOSPxnhWE6UwKgXc5eLcOX96laDANdJK8k2/8GdoXCPbZduNpR1?=
 =?us-ascii?Q?71EnpH5PtJYn5Qpbqkg01uwl3/u4PCkoB0x+SBo3vwpmPvtHxgvLchIozV8N?=
 =?us-ascii?Q?hDOjaPlwwmu2+LMJQdFAb0aGEjR9Vkl7x0Y3YnjEo6O07GMfM5sIlNzuDqfs?=
 =?us-ascii?Q?B7/vmAYtUBdjquh5Z47RLxl5m9rHr2/54MQ7/mAoiyZ11RQ+qoecmMAu76tw?=
 =?us-ascii?Q?9UEBtd4cJXAa4Sh/rDlBRyEHEAQh8G5TTY2rZyIwfJIo+o+2CVJQc1cJB4qr?=
 =?us-ascii?Q?I0IJ2NdmqgwSuuWCXp5o9In2tq7r8H94Ajnb9XUnJ78DoIm+IXajr9vBVF/E?=
 =?us-ascii?Q?k4rVErTiy2DPjTWXQnJwZpPej/3lF70VxsJMRNCNU+bKyDBa0K4YkdtGzZR6?=
 =?us-ascii?Q?iVa9ZabEWFdtj5n/BFOggQhhkmtYcYnEMChZAiVr5X4RRUW2+leG9loC3l0k?=
 =?us-ascii?Q?plzd8u9bbJY8netH9LUiyy6Df9C/tBaaVOBZxu/wX27ss9cqoKNReIOePTrn?=
 =?us-ascii?Q?VeEdevjAv+WU3ZOtpfbPN/4eaIW9ymy60NSK0d8NwCjW+Chph+Gf1S4fgVQx?=
 =?us-ascii?Q?VzbBwE/BEznqWZyz2KYCdvkPjN1R/Rf+OoWmIF/CSXDpnzMzlBueYwYepkJ0?=
 =?us-ascii?Q?Rp0CTWsYcnN3uj8F4VRY04/THf/eWZI9HdN61lhRADAVAdPqKO6ZfkfPmOH7?=
 =?us-ascii?Q?5bzEyrd5HlTG88T92a8JZXcmq3d8almUNPna99qVao2GfI1jr8OHdceE65ge?=
 =?us-ascii?Q?Z/VDNFal/F8rrjMikWWU6p7Lmmh9Nrrfg0h1lwmZqa2toWeiRDndWEg++9Fu?=
 =?us-ascii?Q?haOGgWlMS/be06vSQiWo7lZFkbILzHrbz/njfyNH/wonsINM3DzI9Q39JvZI?=
 =?us-ascii?Q?ko4AbvpxOPM7HzBpyAMp/FXGWAzhcp+Z6n0cRZUn5HYv9NapetF+1eWG6fSD?=
 =?us-ascii?Q?xVIce86HHGQbRMt7Y2p5YtthObM6CkE0m4mYwTegnvnehzULF3RZJ7RS8zfr?=
 =?us-ascii?Q?kFR3DGnoGG3oNAYMctMgxjzgPxvo/Wj0gsyoJ7pTMAgAcvlyZAmhxMRV6QuS?=
 =?us-ascii?Q?H85TlSI3BuVDDexjW722shhNkyAd7C+/vYWUXdeULLEujz+zdd0s9x0yIKlR?=
 =?us-ascii?Q?NB39Kz5oys/I+oGc5bryY+j+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b93d4d5e-5f66-472a-d743-08d8eb575a68
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2605.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2021 04:19:28.8785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BIwXVRHvpIzuDrGYe191Evk1HnEI4rLjLLEJG4d7Jnr56WSy9x4YdBaqtkYcVrVmVI5jMvoZEHLRuGzlgW6aTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4704
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Eryk.Brol@amd.com,
 Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index f07b348f7c29..09c62485a1f1 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xc29b1734b
+#define DMUB_FW_VERSION_GIT_HASH 0x899019e5c
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 56
+#define DMUB_FW_VERSION_REVISION 57
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
