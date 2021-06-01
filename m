Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C08C47080
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 03:18:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEDFC61186
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 03:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEDFC61186
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A87B6E12D;
	Tue,  1 Jun 2021 03:18:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BE136E12D
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 03:18:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AL/LNS1ol5IGL64ibR3EnzNuOQ8QKy+N+w/E4AOBU95ijaDG/6y6LJ6rRpNGxLbg4sLkXdJzEfBWYEkRMQIsSBbnfhtzf/oS74vedPGGhH5eixad4RXGn/+HJd61k6G8h1aIXFoL87fZDZCfuNYxeE2Gu3IYbs5/iS6+s3hGGx7xOK4ilHLOG4CLDy3PT0qz1cV9VVDFr2vLvjM0vbvEPj4yCeSSKZXX18dkbU7iZUR2JVbp+7YJ23i9M7yMGdDrwmA5kkirKN1XjwkoLbPcvfauSKDHChimIfUHjLchdF6cPZOVI6UqYtBDQyFt2wSwTTalpYesKUOl2XvJyn4xKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufRndp8hValY1JCl7G7LVjuEIfxMGp7osbfxGeMQXn8=;
 b=GwZNQ55R4a3iW1GjeJ0eNxX8OuuWi2wA8ZBI8odLWXkeB+Xf+9gHUrfMqEkVT3BcFqqDNa+j/W8JqG6y3NrnZdaMt/GEaJWy0MaoznutUM0dUr2/yobviMcJXg7awKYswzFvxLpbTTqUZOE4H4UOG3XeJuy2F1G205L2Q6vzxys7mXowlzpxKXJ+PicaWjr5STmnUi2w8OLDnbkhONU6pHbLSCvDW9G8KBcEHm1TUvmJDS4c62j0SD81nl6BKWS5RUXpGNYAv7M6yliCJZZz99LTDHZptbJBWf4hi3Jyyb9H2Mbg8c+Ms585jo1oF3CZD7Dn986QFwW7PPkuM4O+Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufRndp8hValY1JCl7G7LVjuEIfxMGp7osbfxGeMQXn8=;
 b=YxBi8dNJX0QX1gwyBox//YuubukayZ0JmDJNkqw8tR9S272Vx5TVLViEi0bb3U/Km4PjfqugkemZ1knvKwPl/wUdtBlS1/b2W+5iajfDt9MlKBDAVNNX9j9Slt/bM2E9kuO7XkGD+manJUeoC/QNFBgR8/LQRxB1GxSD99ItvhY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1247.namprd12.prod.outlook.com (2603:10b6:300:10::7)
 by MWHPR12MB1309.namprd12.prod.outlook.com (2603:10b6:300:10::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Tue, 1 Jun
 2021 03:18:04 +0000
Received: from MWHPR12MB1247.namprd12.prod.outlook.com
 ([fe80::6c4c:39f3:3898:27fc]) by MWHPR12MB1247.namprd12.prod.outlook.com
 ([fe80::6c4c:39f3:3898:27fc%12]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 03:18:03 +0000
From: Leslie Shi <Yuliang.Shi@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 guchun.chen@amd.com
Subject: [PATCH] drm/amd/display: Fix uninitialized field when expanding macro
 MI_DCE12_MASK_SH_LIST
Date: Tue,  1 Jun 2021 11:17:39 +0800
Message-Id: <20210601031739.262322-1-Yuliang.Shi@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.134.244]
X-ClientProxiedBy: HK2PR02CA0218.apcprd02.prod.outlook.com
 (2603:1096:201:20::30) To MWHPR12MB1247.namprd12.prod.outlook.com
 (2603:10b6:300:10::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from syl-dev-machine.amd.com (165.204.134.244) by
 HK2PR02CA0218.apcprd02.prod.outlook.com (2603:1096:201:20::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Tue, 1 Jun 2021 03:18:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0b0ab47-1157-480c-8702-08d924abde2f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1309:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB13094F1BEB32AAF2BDBBB58BE03E9@MWHPR12MB1309.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qo28F5BNM2IhYFfl4TJ0T4sJw+1lsoysy8q9BqCSGFJxPyqKfbmXhKePtclAJgToarjdLNXVmi6K7Ww1fllbO2KhLdgra2+ZkjKbW5IPc6rD7xjoJPTykPslkEtig2/NA3hK/EQBTzgZGK1AcL5yYQeqomEELc6+dm7bI8SXEvKstzEtQ0Uk0345shwqZXxM2aDv2TaGivmGoVzFBg5HaiGl+oKDQ2zvYY8S2VkyWS7GP90jRcL6JrFvZxf0QTSnbI07Uy705VAo1QQQhunSMZjTGenLsSfGhWwzOpVuO+tB56LHzVbTYejK9Pj6VgspgFcfIIrDTN3okGs/smOI11Q0m8b532GDJOvtKIkKUuq4ogMj7koOJpuzS+P/NzDdiUH6MX+KPEKQpsE9xzYbv5f6JS73j9mrSqyAfjqdBISqegmg+Voy/SLSABZDSQX+fjVih2yrnrdKUhJ9ZqaIVtFmPYpy7WpcYFOpyxh8wVT+5aXIaesae+BuORPKDdTGJaVmW1SeR+4oeVrHgBDtTfQRYfP5y64MP4g+i3YsW+jHfz/CtWSQqOK51kPZVvHM4H1QRedCYMUltBdhuafj7w5Uj+c7KnRjOazRqtBee6iVaKbEApJgA9oiEuS0Nef3JPS2nR0u1X5XzefR3k7aN3sZ48eOImv48WetUrqyvNI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1247.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(26005)(66476007)(478600001)(66556008)(2906002)(5660300002)(83380400001)(6666004)(7696005)(8936002)(38350700002)(38100700002)(8676002)(4744005)(1076003)(86362001)(186003)(6486002)(16526019)(6636002)(36756003)(2616005)(52116002)(316002)(66946007)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Hii4DIJsZ+W4PXOzk9/kCZHFbdshwsH30cT20zhTDIL49GbhjoPb2JQmNz7+?=
 =?us-ascii?Q?feVjuzUCYzxnwHF2+9Zvsim1nHNgd9kQQXfSAfJ5LLBUaLX0b4Udv56ScitK?=
 =?us-ascii?Q?s10FWcR4MQ+ePWoiixD4zqGyZRLrTq7UUBKwGVPVH45LmkkABnZqCfLGj8wi?=
 =?us-ascii?Q?+SwA1DFdvLjjO/NbN+kwNIFBYRS2okmEsRk95cH6E+ZUOcFxOtY10UpWAb7u?=
 =?us-ascii?Q?XSK4dHr9f/LCSJ+wZUMwsOhlDYVCH634WWd7sHAdcnX3usOCUltlgcjpXVoz?=
 =?us-ascii?Q?ifmmKn0cge0pd0+dAIQRXGZNsPdwsFUOA4kjOjJYgZKEM5R2hsna4CE/3ByN?=
 =?us-ascii?Q?xUkl5a4/ydZd3POTLCFQh/xetBiMBVbQ8PMIC9Tf+OrU55TEWpQMzQI96TSD?=
 =?us-ascii?Q?VTx5awCLcrhxnkZoRerVqznP+IOAoIQ/NzYXZVSbUNz3qT+LadlTOA9DxvR/?=
 =?us-ascii?Q?NpnBBwXoCSNZG0Vht+HNDqy/caNHaA6sOQpV3UJ1ncXJWOuCSi0vwCX9V7Yd?=
 =?us-ascii?Q?EOw+CoHTHvsCQdnNPCw5OO5ZE9ggQ/206LAHDvvzGGRjxvsQJw9stpf27dM3?=
 =?us-ascii?Q?swTmcnSPS2NaR9dd0RcsWXsQJwaad2iFw5LEcIAuWiRVpNUSilk69a+PYeCM?=
 =?us-ascii?Q?5Ru22N0FJ1ngu9O/f5noaO418pnU/qjbS2SbKKr3jHRgoENw34U0XeC53qtE?=
 =?us-ascii?Q?aduvqJTeD8ufFcHffPCndJtrw1z0ij1O89Matvggdmc0LhnhCmkpNY09LMYu?=
 =?us-ascii?Q?JsqIv/sb2UQAHioQmNM4iouQrfrYTFFxPh4POl1TMc5wTbAgaBLWyw+8XH0A?=
 =?us-ascii?Q?i4AT1Vn7lSTSJp4/hvK6ksn9N2PYZNG5FKCOHHxYZZCPrVF8Kvn17cnz3IfW?=
 =?us-ascii?Q?RBDYIgFFl/P9395gfS7HAwx+ZMct1kG87qrjBcE6AmzA5M9I4s1w6SnBc/m1?=
 =?us-ascii?Q?sRImdBdUi7fh5wuIVgzmOD4m6oXM3LhoCUTXrbZ9rEpEQADY+3OEJKaGwU8W?=
 =?us-ascii?Q?WTdW87tTMc9SZSnMUTtny/kfho1+ZICyvnQjOkuTfhLw35F4yleYQ+oCiDSk?=
 =?us-ascii?Q?gklxiNMfuoRchsmYOvvdiYr64zPpxbDMxllPJiKGB8tL3foGjsRvIWlgLkud?=
 =?us-ascii?Q?/avka+WBgQw7VJXRbmYl42EXsQr93zrzFuhlMfK9Hp9jxbKS+KgPfhJE/9Mj?=
 =?us-ascii?Q?FBTWIWj9vq+me0IxhhXT17fwQt+wW4LOCJrmvHBijt6wxAWv4qy2Z0g0DwT9?=
 =?us-ascii?Q?j3XMOxHVa9YL5WIGVkLuHF09YT7Wz6zQnYmzV1nvlChtuAT6uHiqO4S3PTvW?=
 =?us-ascii?Q?6yoQbh2wzJOhr8dOzkUE026L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b0ab47-1157-480c-8702-08d924abde2f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1247.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 03:18:03.7059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1suqLITmoz56cmSpJu7btD0MsQEuySAQCg0Jq8tOMJX6tRdaHgizaUcLmEle/BEK0B847CUi37s52E1nPZYIQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1309
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is caused by 63213103 "drm/amd/display/dc/dce/dce_mem_input: Remove duplicate initialisation of GRPH_CONTROL__GRPH_NUM_BANKS_{SHIFT, MASK}"

Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h
index 08a4c8d029d9..f98400efdd9b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h
@@ -297,6 +297,7 @@ struct dce_mem_input_registers {
 	MI_DCP_PTE_MASK_SH_LIST(mask_sh, )
 
 #define MI_GFX9_TILE_MASK_SH_LIST(mask_sh, blk)\
+	SFB(blk, GRPH_CONTROL, GRPH_NUM_BANKS, mask_sh),\
 	SFB(blk, GRPH_CONTROL, GRPH_SW_MODE, mask_sh),\
 	SFB(blk, GRPH_CONTROL, GRPH_SE_ENABLE, mask_sh),\
 	SFB(blk, GRPH_CONTROL, GRPH_NUM_SHADER_ENGINES, mask_sh),\
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
