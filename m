Return-Path: <SRS0=wW4+=ES=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1477C388F7
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 22:23:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4A74206C0
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 22:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dmYRAsFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A74206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 044DF6E453;
	Thu, 12 Nov 2020 22:23:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E80806E453
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 22:23:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyY/AkWAx52l+xzNrv3ErxfL7cNwpwcLuaHH/qfdCI/3nIuAnCIcz+11YPqcsOioD6+pzZ2PD7j+pnt98vKQ3rdCdlvXZv6iLR8fjsT1QLmWnQ6ApfcbiwWf62Moz82bPZ8rW+juC5I9klivr2y4dr7Bv/ADTSijO9flL8AkUlJqyyrEkmpAp1frL77GAwB2JtJGgiEUE+Zepc7IX0C/9D8DZFb4dc+Rfn8kaeIYx+BSlWTh3PPood955ozuuADrrC2FlmfgigMK2EwUbVohu1xbMOma3aaeN3c4NUPhqWznDs8gx5AYtw5e197gtNCN9YIgfrpH7kcR+jlnYSktqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1nFE0vKs2uNVCKMdA7o32AVYRDdarQh7tb5+yOo/4w=;
 b=F962a9TAtUXC6gLqgKYV79whJr9UnPI/bHFPANwjpwN0xY3lpHiQiXxTmf8HoVtZC3SlRqGmtMqYohULiakfZBg2I1yDwc3hkZ8M0T+TMpJMvPyZZohjdMlw/jrw3wtsrdh/MNRHQfqWXvTDzqPm5YSa0xhx+Rr1qa8GUIonrjyt1IDz4t6Qi0xrzyWYIMegtJOi9Mfu8rjkskUbhNCBfWN4ORfs70t45U3raP98sIDV2W4zBQKBrG3WXtb8p/6h7i3XUHyBGBtzV5xXR+7S1l/tbkEoqKmKHDT1vg+VfJPtOoOQBle36A1fhI3d5HWAgf9fjxUs8hJBQOoBap4sHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1nFE0vKs2uNVCKMdA7o32AVYRDdarQh7tb5+yOo/4w=;
 b=dmYRAsFkX0zpeS7QDXLlDUnFZPeoTLYFd2M0K+gVWqz+zyk1NTkpZGBBYJHVMtk2sj2CuuHoItVN/L4xdYytxSgISzNRKy3gUGruCroOexC4H16ox1znmkWtqKB77Fc3lcNsWb2I9/Tw4+fhuTDq3mrAV79oOFJyaEQ26MVkJkg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3221.namprd12.prod.outlook.com (2603:10b6:a03:135::29)
 by BYAPR12MB3317.namprd12.prod.outlook.com (2603:10b6:a03:d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.24; Thu, 12 Nov
 2020 22:23:10 +0000
Received: from BYAPR12MB3221.namprd12.prod.outlook.com
 ([fe80::1d36:5c37:4322:5876]) by BYAPR12MB3221.namprd12.prod.outlook.com
 ([fe80::1d36:5c37:4322:5876%6]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 22:23:10 +0000
From: Ryan Taylor <Ryan.Taylor@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: fix smu_v11_0_init_power power_context allocation
Date: Thu, 12 Nov 2020 14:22:26 -0800
Message-Id: <20201112222226.41989-1-Ryan.Taylor@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [2600:1700:9260:7260::b]
X-ClientProxiedBy: BN6PR22CA0072.namprd22.prod.outlook.com
 (2603:10b6:404:ca::34) To BYAPR12MB3221.namprd12.prod.outlook.com
 (2603:10b6:a03:135::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Desktop.attlocal.net (2600:1700:9260:7260::b) by
 BN6PR22CA0072.namprd22.prod.outlook.com (2603:10b6:404:ca::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Thu, 12 Nov 2020 22:23:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 02d8a3c0-1488-4e1a-1e42-08d887598991
X-MS-TrafficTypeDiagnostic: BYAPR12MB3317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB33175E44AA3B5677F6A4E583EAE70@BYAPR12MB3317.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:475;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XrLuesdesDd5cb/HJMvOq7+VoJ1+Zh8xl61XDLNnl8EmwZaa4m3p7wJUoidUCbhG5qNtb9cGrrljPA9pbowHGOjJMk6ODJhQFMuaRUTAlm2FN2/EVpWvszreQU+8vklehAzzje7sOVCOeEaIYZ7VEp7U+ROszkuf08gr4+FTe8r/ZzhfXLUHIKRNh7WiQnC/RUUk7CQzd/fmrqB9vFH+TmTLLRs8PlW7zyAIcPZ7XP2ToIEP8k/GWOl8sYp73SFkS0dKXbjlI2c1YnNmFplawaa6Dt5xn2y1NEOAB69yzZQbkLKAVdVnRqDXqKPbK0PB1Ekte2wckiYSbIoXfqmy2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3221.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(5660300002)(2906002)(478600001)(2616005)(66476007)(66556008)(66946007)(1076003)(8936002)(4326008)(36756003)(6512007)(83380400001)(316002)(6486002)(54906003)(86362001)(6916009)(52116002)(8676002)(186003)(16526019)(6666004)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Qci2BtXxeARhdwdIwfDvcJOD6HFZq8O9IF3xyd7GEy0uriBc6G1YgZdYJrlPV+2G5ocWuFvGV40XAg0wcOiJg7SOo50Z3/hcl5yMjTRAl9yRh9l7XDpQ59T+7XCMz9XMDpFi1+xVAcOop7N5cSUH8RzD9D+aXgsBZdDARaoY4+gdNh22F79MDyXPJ+nHzc3IJy/klGmW4rFe9H4MenMf84gINget4/070+TUi0usR26jlBhf63niugt/yRDTyyh6B1qtE4GKjKjdXpIvtBe6YccwQD/UcLsNN8n1TmAA/TTUM70XG7yM22A4ZdPSnugb9bz6iL3pX9t8BTncT9FQTCO6UrM/pVHT5miA+q00scORpvGuctVcQSjyL0+lfu10JiVvB6OL8RD3Q0RTjgKlrSAh/6YFtGV2qN7TXcBuAeVTBx41opIipCvjZZw0dSrLtCL7Z2FGptXlnBflnPMqtsXjvJG3XgO7TGJ8CcouJhV0i3sJazNP/bl2gZgplPXihVZsTSIpAFsdTVjtvcDdtxj61wkwxBOBRlZPNM4bKFzFg+uwPaALoB8zjawp/UawhHVV4qrux6+cEE5JC03Pel6+mamFeQMrRu9eeNMseQw8x/nDt/W6dAbY/hO0LqwtO7sI9TsGpAlLLI07onjGT8Ee5uGylQaygeyX1SXlzBE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d8a3c0-1488-4e1a-1e42-08d887598991
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3221.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2020 22:23:10.5721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOBwKWStngt+Qwq8prfdJ4yA415D8Djtg+VeWFtFxWFgvQ+aWR0zwwniQCcjntOBZ9TiKgws0+ZSNkh36EPalg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3317
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 Ryan Taylor <Ryan.Taylor@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Allocate smu_power->power_context to size of smu_11_0_power_context instead of
smu_11_0_dpm_context.

Signed-off-by: Ryan Taylor <Ryan.Taylor@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index b880c72c322c..9ec5e30edbee 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -469,11 +469,11 @@ int smu_v11_0_init_power(struct smu_context *smu)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 
-	smu_power->power_context = kzalloc(sizeof(struct smu_11_0_dpm_context),
+	smu_power->power_context = kzalloc(sizeof(struct smu_11_0_power_context),
 					   GFP_KERNEL);
 	if (!smu_power->power_context)
 		return -ENOMEM;
-	smu_power->power_context_size = sizeof(struct smu_11_0_dpm_context);
+	smu_power->power_context_size = sizeof(struct smu_11_0_power_context);
 
 	return 0;
 }
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
