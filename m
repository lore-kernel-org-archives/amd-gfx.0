Return-Path: <SRS0=U106=CU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC01C43461
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 21:34:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5937221E3
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 21:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ho78zIgU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5937221E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30AA76E0BF;
	Fri, 11 Sep 2020 21:34:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 714856E0BF
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2020 21:34:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kK/46moTc3ohmo6KIKXAgQjBlffNi87a/ygKS48UntFXEHwRg4tk83EIcpAUfIH+bJziPO/S7JP63BqriFe9aBOdqjSPGDvytv0/eVk5mglCFCiwuCsvIbtOH6vpRoibdIL6EqKWp5ItDz7ihZHl8AnblEeK0fgwY5KHp47WyjhQlvqLKWtHalFjJsOO/ine/mwgq+FatTKZFiJq28S2XUzbr7W/eH78p7MyIJswI6/pes+zzXYauN6RUppEnSWvSwyBUI+Eqq/IKRO9qJZD3xE38MlBwcMklrWfPgADT7V1QMgbV7lr81xST7L3yD32F2GiLe9zHrCOUZArGfYtPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAg0yqWhuk+kP4sTezjLvFBl8V8z8fxQknHOmRt6r1I=;
 b=UhEI9BwMaF9PwP83NnPyIGajmz5d+tP2lyq3poQ9CEwhx/jgxxcJPu35aSW4nEK8oy9eSV3DNAROmEmJiuLo9vQbwAh3Gz7FE5yFQSNEm8taMum7MoGoRXndr51lyAmSI9QKkpS+qkOU+7rzCnIvheDdJopuAP1vDs/oImjGMdlxpDtNL7EVnEp8yTflexnOvhD5R0hB/m4pE4rJOBzB8I4nzHiErS4CafxClKlQ8l6/ZJqV+0Gjba37q4vbXSM5l13w+LlFCk+leyY/CHmOVq37+NpC2DcUr8SGtodMMG7PztkXg+SBDpVVJ4Z3NaQyjwkSr01WhUf6XvFnt5id5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAg0yqWhuk+kP4sTezjLvFBl8V8z8fxQknHOmRt6r1I=;
 b=ho78zIgUSyKXymUnkwgwysuJsZ26uZaPxzSM6MJoitwKhr43sJEAFAKLQBDQWqeitc53vyn+fQXrpQcpKu9Ns8noKsaqFwcqTCwuiInUVewjqTnngiAANIxD5DdVixam+OvKn345hnKkUv7AN9otmJ7IK3rv3gSnRXnVHKvgq30=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN7PR12MB2738.namprd12.prod.outlook.com (2603:10b6:408:2d::11)
 by BN6PR12MB1457.namprd12.prod.outlook.com (2603:10b6:405:10::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Fri, 11 Sep
 2020 21:34:09 +0000
Received: from BN7PR12MB2738.namprd12.prod.outlook.com
 ([fe80::91c5:f91a:ee0e:1bfd]) by BN7PR12MB2738.namprd12.prod.outlook.com
 ([fe80::91c5:f91a:ee0e:1bfd%3]) with mapi id 15.20.3370.017; Fri, 11 Sep 2020
 21:34:09 +0000
From: Mukul Joshi <mukul.joshi@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amdgpu: Enable SDMA utilization for Arcturus
Date: Fri, 11 Sep 2020 17:33:57 -0400
Message-Id: <20200911213357.17366-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::23) To BN7PR12MB2738.namprd12.prod.outlook.com
 (2603:10b6:408:2d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Ryzen-3700X.amd.com (165.204.55.251) by
 YT1PR01CA0084.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 21:34:08 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2be27af8-4005-4abc-2db7-08d8569a6ae4
X-MS-TrafficTypeDiagnostic: BN6PR12MB1457:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1457FD4CE73387A96B1E4941EE240@BN6PR12MB1457.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +WS1nuS2VnUQdnSoA1J9orqv6zX7g+6cFKE4xRcMGFMhJ7P+UinXl9kOEjww6Ts8HRJhVBmNu025LGyeaWxiJsSwDkQLJyjB1oCc7Vbax65kowllwiaDuII9iQbTlKdtEqP/ggXeEkJee7JuxM914n+ct3AaNlYHialwQvF870kVHRRGMHoVDOsl9ej8Ld5xPIvgL9BQyG7H1Sie3241qd7/a8O6ospxS/7d3excme4eudkpZSCu9yu+VDnqJugWag3BOoorRkfWbgJi1lCZjCwdeks/6U+I1LAY4JIkLzzk+cg8UIM4q2N6Wl4pCO2d/hGcm2bTY/yuQdT4YgWUYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR12MB2738.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(66946007)(186003)(7696005)(1076003)(956004)(6486002)(2616005)(316002)(83380400001)(52116002)(16526019)(478600001)(26005)(8676002)(4744005)(36756003)(8936002)(44832011)(86362001)(4326008)(2906002)(66556008)(6916009)(66476007)(5660300002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: bRTf7qxmWtnlT2IrUUMqTxVDD8CWOlIskpBet1WAS9Hnw+3JiVdpFOimCGioiQBY5gNssl7eh152zPQu0GM8ICsRlKdYCSzk2wxGRXub/m60plaDJm02TcQc9ETxBMBp8F2f2uqCTBnBKb3LZdAwDMFcx0HIK+e5xc6nGW/8yT5hUnmX+5ZdgJAI1NQa29HYfKByXqPo9daPDr/gBdeItlXW/Okcr+p2BSjjCHljpE4q+2EfMcMkFhQt81aMBR5kwz5tvHUdW2pbnJ02j2ylru+AMigm5oSpT5qGhE17ZefmFASQFD8KWb4OBG2YwYCzQ59c6c11us2ivp0+cwd7G/b24zz9hTg/SNMYXVdXnB65zHm9QJHGEF9Rux4K59wFrIEWBza1SYW8c4G9DgKWMH0RaQUToMEO3+RPsXKguxAaxBRxhJubL7TjW8ucSDVL+zr8LggzMjNI9hVnrk3nAjIFbMmVrW5//e/lX1bdf9ASVDWbTL/W8msTszDBYKEtHAhzp8JSlFXQcC2nPVAiZiRJHovFz6dtPMZ3XrMfROzNom/R7OVNhIGFl82zxvbcVXdXjxS8Jfu7WRnAfU7XFdgqrI4B5ux9/mNdrU82DbAlKbCDgSBzuxj6Uf+LXAyYGkYziFDN1aKQRGA2Mzmu7A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be27af8-4005-4abc-2db7-08d8569a6ae4
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2738.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 21:34:09.5014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EhH0ATywDm0OJYdNfBhpAuvF17lAuhDmBhKpmORjwCJqV2uA/1uWPiTX5KuyqQsoMWnv/jt6m0PrRhq+2S9u0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1457
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SDMA utilization calculations are enabled/disabled by
writing to SDMAx_PUB_DUMMY_REG2 register. Currently,
enable this only for Arcturus.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 856c50386c86..edea8743f26e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1063,6 +1063,15 @@ static void sdma_v4_0_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
 			WREG32_SDMA(i, mmSDMA0_PHASE2_QUANTUM, phase_quantum);
 		}
 		WREG32_SDMA(i, mmSDMA0_CNTL, f32_cntl);
+
+		/*
+		 * Enable SDMA utilization. Its only supported on
+		 * Arcturus for the moment and firmware version 14
+		 * and above.
+		 */
+		if (adev->asic_type == CHIP_ARCTURUS &&
+		    adev->sdma.instance[i].fw_version >= 14)
+			WREG32_SDMA(i, mmSDMA0_PUB_DUMMY_REG2, enable);
 	}
 
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
