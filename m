Return-Path: <SRS0=2WS1=EG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F78DC00A89
	for <amd-gfx@archiver.kernel.org>; Sat, 31 Oct 2020 03:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 838A022249
	for <amd-gfx@archiver.kernel.org>; Sat, 31 Oct 2020 03:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0iVpAS26"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 838A022249
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E35716E0DF;
	Sat, 31 Oct 2020 03:06:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D943D6E0DF
 for <amd-gfx@lists.freedesktop.org>; Sat, 31 Oct 2020 03:06:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRPwLemecVi7YTA4PWy+m72lyJNQYrKzkDoyLYTcJqJGYnf7mCDnPzh+678dX+0bl85p+H4gyQ9X05YFVdXBj2mMtVluo9UAVWd1ziAi3I1wb5Wj4qQh6vRT1X0L2m2UI1kD43eYi7IKx1UKC92ykdS1JEFReYrGgwwL8hQ9A+NP5KxYcUixElHkqOgLJ1c6DX8VGtwjmFqYrdgqwGmoMU9pCa5JjFv7MkkfOg1M5O9AT4RQeL0ad209Sdei/IhzA4ejbG71SOByXcIXqi2uYXc29fJPVQ52yMj+Gq8B8a82Didpc5HRsMZQy675KH9ABAef8exZlubRn3+tP5gfBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uK9Q6yiI+Gj9+29fJyuOraxAru6P00YwlRap1K6Os0M=;
 b=WhrBajj4UG3USNW0OfpxUjB54Fy+24A7yUZGbaEP3lsUqXhqUZymnuxJGsx/A58v30MUcxLKh5SnbLWZVjmdT7KiPqKAqiEzizCHppq/S5ejH6Z901BPIEt6+t7G6bJ2y5UlnlABhZ8iPskr6MtAcEheXuoD07Oh4RQ+HtRSM31irWff6AMV8YlKGYLG9CxJilUTolEvheQAEvvCVO6P+Zbu9wfAKVrT4g/yKWO1o0a27D47N+Z4bxg887sewu9YHO4dJXFfZGg08Hy+VYll0QUf55l5gzO34YjyiMew9OWf1on/O2UqF5nSqmVr16/PkapvINXdBmi1NqSEohfFOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uK9Q6yiI+Gj9+29fJyuOraxAru6P00YwlRap1K6Os0M=;
 b=0iVpAS267QfU6arYXtFIgpbi5GXw3DQGkEyBd3EcduRw0A7AUVFxS5Z1vPBYcrVfDz0LgsHn6AUvoc016Fw0iV4I36TyYyd766bqjRmM2ZFdHBXP00GG9JsXpL6pTaFlUyU79twjjFq/pR3QwOOPVk3NQlPgl1mqw/QVAueaMZA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN6PR12MB2784.namprd12.prod.outlook.com (2603:10b6:805:68::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Sat, 31 Oct
 2020 03:06:42 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::d436:e21c:e4e8:7deb]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::d436:e21c:e4e8:7deb%5]) with mapi id 15.20.3499.028; Sat, 31 Oct 2020
 03:06:41 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: replace ih ip block for vega20 and arcturus
Date: Fri, 30 Oct 2020 22:06:19 -0500
Message-Id: <20201031030619.16173-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM5PR1401CA0009.namprd14.prod.outlook.com
 (2603:10b6:4:4a::19) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 DM5PR1401CA0009.namprd14.prod.outlook.com (2603:10b6:4:4a::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.19 via Frontend Transport; Sat, 31 Oct 2020 03:06:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b478d6f1-74f3-4eb1-5d7a-08d87d49fdce
X-MS-TrafficTypeDiagnostic: SN6PR12MB2784:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2784E839543766E6C888E854FD120@SN6PR12MB2784.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QMoTVW51gC5GiBcjgUCfI3ionlJM9nmhjarTxCMiRCzWq2FwY2pLTZCxTRolTbvAC4SOranssWqmaztzYq2hxz1pFwx4f8eNOhni6DE33016WA9a8NUGv2jcy49eMDvrWssh/28cHJg0d843KtqHdbJFGKKYfKLNMbHZ5wHu300lbAguCKvTgiU8yRd7GAwnUovVKBRh2yoIX5/WIEMTujBT5xbDfDqKmf+ZdCfM1EIodLpv+mmFobprvxreYeu0z5su7OeL/7yaHcfkapX2RQ6bgT6E6bsf3+ixJPCjEKTUhJQCH8rvVpy+c4JkrkuQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(5660300002)(1076003)(186003)(36756003)(44832011)(478600001)(4326008)(66476007)(8936002)(52116002)(7696005)(2616005)(16526019)(66556008)(316002)(956004)(66946007)(26005)(8676002)(2906002)(83380400001)(86362001)(6666004)(6486002)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: epJ66HWbtnbG4pjTWXuRps0fqpnV0E94ITbXFywuoUeGLOn2SFpgMdjzQbk0hYDyCxV1/Mkpc8XL3eCdCwLkvnryv5cO35ymnAePGW7Fexwx72tz/kYRyvNKJ6dk5rqJ67RrWce4bjNHorBSsST0EG2Dv1GA5N57Z80A1MghJHUDsX6EXPsQoYngXpnzfERE/1B2bAENPkmn+eNzD2Ev3JRgj3j7o2/HzYCzfjziXw7mA19rEl4JBoCryAnh7k5hYwsOPhmUHRoA/5Sv64wP49/Zqvrx8M/i7klzYzj9KA62nrvwD09bpqy6JGp2wS+IEANA7lF5kF4hQSAh7QGjoG0bZ8Ejy/vMQir+TvLoepEGdrAFtyd+E4o9HjRcj+qTX8OMJkWFAMjIS0l0nlTEXBeotIEQZ7y4Cofofck04kAYGShFXyrp1EaEII2BAJU7kEdw++CtunRcF4WRfCZ//UvK/w9XIZAHvqQmVKOUzy+0NvWnQeg/HSiqSwU67b9lo6tpbGcaSFLg8Ol1iA4ETkiKC899Q5yoV+joc3UfqxQ8hOBB0m47cmix127kQbk7/s1t7kDGBZIYeY6Gu8pZgltnY51rj+tK2XIcc7BuAI3CWy/VTxcxbLiNo1hqdVU9heRlW5XvdUBQn8G5CDg3Wg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b478d6f1-74f3-4eb1-5d7a-08d87d49fdce
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2020 03:06:41.9131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGHgiBiUneqwtq/XRvrcJ5d+2s38X2BX0yJGy15IqvdsSAoMmlvRv/rp0upoVvus4JKX1KFizLUnQbelX6b/oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2784
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Vega20 and Arcturus asics use oss 5.0 version.

[How]
Replace ih ip block by navi10 for vega20 and arcturus.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index f57c5f57efa8..fc5b11752931 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -62,6 +62,7 @@
 #include "nbio_v7_0.h"
 #include "nbio_v7_4.h"
 #include "vega10_ih.h"
+#include "navi10_ih.h"
 #include "sdma_v4_0.h"
 #include "uvd_v7_0.h"
 #include "vce_v4_0.h"
@@ -734,9 +735,15 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 				else
 					amdgpu_device_ip_block_add(adev, &psp_v3_1_ip_block);
 			}
-			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
+			if (adev->asic_type == CHIP_VEGA20)
+				amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
+			else
+				amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
 		} else {
-			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
+			if (adev->asic_type == CHIP_VEGA20)
+				amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
+			else
+				amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
 			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
 				if (adev->asic_type == CHIP_VEGA20)
 					amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
@@ -787,9 +794,9 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 		if (amdgpu_sriov_vf(adev)) {
 			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
 				amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
-			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
+			amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
 		} else {
-			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
+			amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
 			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
 				amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
 		}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
