Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348A8C636C8
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 064E761029
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 15:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064E761029
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0B5389ADC;
	Tue, 20 Jul 2021 15:44:14 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2058.outbound.protection.outlook.com [40.107.95.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85D4B6E430
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 15:44:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifln2wGkiMTBu6XNJPdb0Y6W1DU4Q0dZ4CH8AW9vj4wdzHcG7ENu+tOgPaZYBVo+DS9oMdcCJDAPhcCufYvP6J/mE1s4lSlaIg9Z3zT1QRd9IxSuRD+axy/BSLCIEa+y/mpZ4riw4I6AFQSy88T0RQwnTqsGDa919zmMB258+xpMTkhlknii1U3y6Tmwr3idkHg9mg2Qd8A34Ip5IX/qsLHDo/L5U7J+f+aXQn6M/u7Kc9ECFOuY1hQlg3va5F9siQ4te2fr3PwRJyQ3T7yjEyx40oqVmUluKwUaULz31b0vQ/eL5NfhTJIufBwQ5j9sMY+Cw5DFSgSwAo0N4JTCqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnRQ1CF387rgXv28lt5p8Crn9ScGxtmgU5JbWDjIswQ=;
 b=OWIah3LFMTBi2rZMzchW9aJsV8svNve0vT1KPQudFWzRn5LLiG4AzByAXPWFOqPaHzjzXWc4FRmAOdbdUh1neECfre3hvvwdgdhCyWQuVK+X5qLHNT+RvZkKi8uZnSSishR5OrxhiwMdwOFuxuxYjPzenQAWXFvQYmJt9f3aV6sJNcIZA9zdhZuQohgaY7t5dhh5pq+jw4Bo5WGJOgf7Ra0uFjTarWeQQdMjXKRpbFH+nmGSJYJFs6PFXkrHLXhANnK8EG1MWhrrFkQmc4YGh04rFjiJFM1LCK9/E/723UNpOZBUU+NmUAq268tLOqIVDDXyeWMSeH4169RZdqBYig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnRQ1CF387rgXv28lt5p8Crn9ScGxtmgU5JbWDjIswQ=;
 b=h/wbFThcaZE4zN/CAIlccju/y7m5d/mC5U2XtndgfdqQJgbhR2ikpB0bmh6qirOhyay+peRFGkOefAHzsppyJqC+uvxp73vD0JSG/dJz52zQtF5ArQCP66KlpPd5YYO9xTBtwe+3TC/USOcx2wUwAzEw/qqfWx/i6H3o6/ZjlvI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Tue, 20 Jul
 2021 15:44:11 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 15:44:11 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/29] drm/amdgpu: add sdma fw loading support for
 cyan_skillfish
Date: Tue, 20 Jul 2021 11:43:28 -0400
Message-Id: <20210720154349.1599827-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210720154349.1599827-1-alexander.deucher@amd.com>
References: <20210720154349.1599827-1-alexander.deucher@amd.com>
X-ClientProxiedBy: MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37)
 To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR01CA0024.prod.exchangelabs.com (2603:10b6:208:10c::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22 via Frontend Transport; Tue, 20 Jul 2021 15:44:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0298b29e-1ca7-4ec8-7348-08d94b9537d9
X-MS-TrafficTypeDiagnostic: BL1PR12MB5349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB53493C529D4900067CFAC64BF7E29@BL1PR12MB5349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:328;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O8Eir5aRPIsJBE9kq60x00r9RQn54bs8FSEN7X9E9aQNJXM9mfKU3Pqwvtx4WT766tXSd8jtCf+seqLWGb1FIypIawZ2/jSQVCpzSr3kzUw4NgXGmUyKMB3La57m2OJU4NoIzOo6IWWLYMToAYTl14DdOpuNhRM00J+grpRdi+O4Yc8lioa8WpFvj8hKeQY5XNGv6dlmwABIVYrit1/SrMEWWqBvJBUwGhY+jG8UV7GGx2BCYVTxh2vIGFebevhZZ/IqznNYT9WvJSFUH4i2SRlT1U3I/a29gg7P97Tfj1vKYSyQPb5NEYNWlgupdX4No7z4fEnXq26qb577VtySTQ+8d6rskSGbsZEEsz7VnrgVnlME736yOPcD+T9gC4Ibd4Yxf7evUBAZMP3DHzioN3TDOA9zhEVoJ89VivsgO6lb+0vxUnVJiAwCCMeP6Aex8Kuk52NIdoNAtRF9b1krxIZ/ljcjH89NFVE+jEpQ7fqRf5q7WNrRXC63qceW0RJPFxcJC86SXxlJpMRv5UTptkWZ6BoQWb6oRfCg/xhzS/aYgUaMWjz3GcTla813aD7aeyGrct2Rvbkl7yFBhZTG/O1z+UhkrCmeSMhtwYbO1zRw6/FAtB6TIT0Gb6ZUtVwmexR9ivgR58BUveGGA6O1dGASkemRf3k3CMnfrxJ1I65mOGPPbmJZd9HYd+PZNi3Q+0pkMV87jliL5D9c0NPmvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(2616005)(86362001)(6916009)(38100700002)(6486002)(83380400001)(54906003)(6666004)(956004)(478600001)(316002)(1076003)(4326008)(52116002)(2906002)(66946007)(38350700002)(66476007)(5660300002)(8936002)(36756003)(7696005)(66556008)(8676002)(26005)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YYAfnNZ/QR2RSEbiMeWhAhQNCWdP6C5o1a4LcEE01hkeWVAmzujEeJHK8rka?=
 =?us-ascii?Q?woj3AaeavaH2vNH63xxLKKweQcSlZucVnHSIYAnXfmYkNSADBArL7qjqXZDf?=
 =?us-ascii?Q?Ko/yrSlgZRZqtpC6SddTvBhgENTkypl02KyZjLxh+8iQ4byOtnLRGRW8p3tL?=
 =?us-ascii?Q?S6W0m3bxqkpo/takv88DUtA4UzT9s69N/xFmUHC8Lw2CAornW5rnryU556oK?=
 =?us-ascii?Q?CucQLqS8shiGlzu39U4cIMAhoUjh+UdZ4erQo1af8SEC3L2Jnpa6u2b7FzVB?=
 =?us-ascii?Q?s3Tt2HHPnb/pBFC1iuoyv4ThZYBaulvxX/AOf4Jd2Agfs5/MOtz+lL0OD3mE?=
 =?us-ascii?Q?SwA+10s7QFXOlXbgcCtoiSf0C0JwLDQPj/fxpVAV1LC0cSmfSYeifSVqNrSB?=
 =?us-ascii?Q?nMSWP183r6NM34aq5Tg/dfiYiAJCwAwZG+3bQ1AAaL+UNPVDa/tvbuUJpEkW?=
 =?us-ascii?Q?uwkRcFJ3MjWBktUWZzzczdO3E2ryTiky1V8hxbzd5XoORRf4ZQI1KsE3kUa6?=
 =?us-ascii?Q?o3eAEa0DspAwbzvxgi09AH11TnQZFFgfRswzkqif1DyU4FXSaRd3RfkyK83g?=
 =?us-ascii?Q?D5tvTLMLBJ/ytncKesOLPueZeQ7YWQNSDwr4Q5lSKAgDQd48kx35pGXhQ3qJ?=
 =?us-ascii?Q?D9d+PW0nyz1KyipWuIMASZSflGwZEstOzCwER480riN4ZwPti5brppWsc70B?=
 =?us-ascii?Q?U1vacJXXwXdmqgBrFhlgsBbBS20GREEGbeoerW7QYlolA5EW4XAiv4OR/iD2?=
 =?us-ascii?Q?XurlvlN4ky1a/SjhgbzyY5sSmf4PMQPD3q7M0m2ZGp1jaYfYoKCM3C+r3Koi?=
 =?us-ascii?Q?D7GPL4hR9GR7oSAksn/VjOK4321yk9GNFEGs1a6qNGkYdbj9v8Q7y6nrxxIt?=
 =?us-ascii?Q?dY4aRUiVMFTONC7ZDpIe0qLF/cAdWAnt2LEoVQ5oFXSL/kTXZ7Gj3kUnT1fA?=
 =?us-ascii?Q?XiSR0PJGmmgaAs0Zlwo90VnejnS5G4BIFnwLIjnE05c1pGApGQoutLxgfJuy?=
 =?us-ascii?Q?aZrNN2mMhcpLiBwUMdOyWedJmOuWNGeIEpCrbWHpz+Q2EsrH2jl0rSQUgYnG?=
 =?us-ascii?Q?YfVzA78B/BKSC2PHpaD7joaBarlq6ijg0s+2Gm+MbFzWhRhKw+5+4saDgiDm?=
 =?us-ascii?Q?CB5HJ1da+ha6ePAtlUjev+CMseQNQNpaTnDXhHXo/WVniKIK7J8ugnSWAk5q?=
 =?us-ascii?Q?8TMANoKU2d09KADBU2lgi3NMBHwNQZZXLXlp5UOSJMsRPxeI1E1eKN/qfmkO?=
 =?us-ascii?Q?EPDUzHTI/CJbQHsiCA+F4dI9UAhmaV/+56EMQG+/WtqoZdMVQvL8QH+HvVeA?=
 =?us-ascii?Q?5kLNNJoCv9anK2if2EnjNrV4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0298b29e-1ca7-4ec8-7348-08d94b9537d9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 15:44:11.1153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBVeD9Jo9PoqLXZiMbWiVcPVUlJ7VxTs+0EOLbsDyA2UlO3Wl4Rkthh5yfjD7cTo3jYao5egxp7jkDjqtvw+aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Same as Navi10.

v2: squash in updates (Alex)

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 67f354475d6d..4fe5e02a2a49 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -51,6 +51,12 @@ MODULE_FIRMWARE("amdgpu/navi14_sdma1.bin");
 MODULE_FIRMWARE("amdgpu/navi12_sdma.bin");
 MODULE_FIRMWARE("amdgpu/navi12_sdma1.bin");
 
+MODULE_FIRMWARE("amdgpu/cyan_skillfish_sdma.bin");
+MODULE_FIRMWARE("amdgpu/cyan_skillfish_sdma1.bin");
+
+MODULE_FIRMWARE("amdgpu/cyan_skillfish2_sdma.bin");
+MODULE_FIRMWARE("amdgpu/cyan_skillfish2_sdma1.bin");
+
 #define SDMA1_REG_OFFSET 0x600
 #define SDMA0_HYP_DEC_REG_START 0x5880
 #define SDMA0_HYP_DEC_REG_END 0x5893
@@ -221,6 +227,12 @@ static int sdma_v5_0_init_microcode(struct amdgpu_device *adev)
 	case CHIP_NAVI12:
 		chip_name = "navi12";
 		break;
+	case CHIP_CYAN_SKILLFISH:
+		if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2)
+			chip_name = "cyan_skillfish2";
+		else
+			chip_name = "cyan_skillfish";
+		break;
 	default:
 		BUG();
 	}
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
