Return-Path: <SRS0=EQAg=5D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4A4C4332D
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 21:15:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 407EB20772
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 21:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="faH3XnUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 407EB20772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF79C6E58E;
	Wed, 18 Mar 2020 21:14:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFA976E1F3
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 21:14:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gdg7AzM/WZqI0nLUNYGFVqpWAu+bmDpCiRWMzMZPNK2n5s6DTBd9k0g258WmceUVgNxFJr475WenPTLltUOZoI8jEiyxAi/pPRekyTUy4LJlOeReUZoVDY2ENr7UIXhvuzI9nBPU3d894e8HXvFiE4KGpTIxNsTPqLwMe5RaItfLYcCJ7JXzszS0nRkVKVcctFJK9INA1vkXKwLDfvjlXcouU8PXG9SYK0cea/88w7/zyqJIw+2e97tI6ntXjFWQlLxzMIUKGi/PzWcefwHlp8PUSZvp/My4OEVJimFjWVEmMrMDMI7LpabbScmD1h8wtvTJR1Lnc+gM0kjP9I3ghQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2hlmF8upSWthcs0NCEbkGO5CBa8BMu6nf77TSlJXvc=;
 b=UL0DGxdhQUfhZ8vZ7FLpmZX7bu8s9e4UXZww3H2oK0fgjXjx39PYNOSyUvNeXRoDXuy6ektwo2BT5ft2H/vGIGeczExCnIrj6zDkgYHsSlpN/1UygZgyVH6FsRaVnM+HTRTlnmqyHb+Ze0TlN2/TAzGxztmxRKcFdnvvDgSNh9V9i2qGtlfdmrXDurKvinEi9q98EPkyIQJhqpRzw+iMw6InJBoVAE8qRBRuaaOGJZPL/rMyiP//g56pcYt/CQvk7/WSmuedfU7LrDDbyY8JGEYPeJhwJ1/LJdjBfWzc6RwzUO61V2HwqVC8rzpceyFD0iZ/lmZYEPzDIngSyEcrBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2hlmF8upSWthcs0NCEbkGO5CBa8BMu6nf77TSlJXvc=;
 b=faH3XnUJTiLdpeT7DS9+5SIUwgRbbdGwSgljcGYyejxa9mhBiTBBCjQFmc+BKQ+LYc2Z/nsX9sBenWRPdMND+AWjvdnDHmXacwJw6T/BKmCP7caaqTDITRrxugsqivBbnjWIkiw2V/ZRAReu5kE+UFZvanT4dRE6Otw05BYntk0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14)
 by BYAPR12MB2998.namprd12.prod.outlook.com (2603:10b6:a03:dd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18; Wed, 18 Mar
 2020 21:14:52 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b%7]) with mapi id 15.20.2835.017; Wed, 18 Mar 2020
 21:14:52 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: fix typo for vcn1 idle check
Date: Wed, 18 Mar 2020 17:14:42 -0400
Message-Id: <1584566084-23428-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YT1PR01CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::40)
 To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YT1PR01CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2835.19 via Frontend Transport; Wed, 18 Mar 2020 21:14:51 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 68c48539-def4-4f09-ab43-08d7cb816638
X-MS-TrafficTypeDiagnostic: BYAPR12MB2998:|BYAPR12MB2998:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2998D60A9D68A88C31AB837AE4F70@BYAPR12MB2998.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(199004)(186003)(7696005)(66476007)(52116002)(26005)(66946007)(316002)(66556008)(4744005)(5660300002)(6486002)(2906002)(6916009)(6666004)(16526019)(478600001)(36756003)(4326008)(8676002)(86362001)(81166006)(956004)(8936002)(2616005)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2998;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lVWFeJPyZOEXBYqYEOF/ho3LtSujkbzKgceaqY016m7gHqU+rkeVZ328tJNU8uVzBpKO5E4ZDSen31t2dPxrWgTuQv0yLdBqm6QbaSgQ2LMD3zcYluAEt3Q5ivGJUfIJPH4bF2/arJ9oXW+coZ127x24i/dwhIShfuiWy1YG8OhDm3+hfzlQHAbF0WY1I5mTZcNN7d3F6hqS0L89+PJOG4bCSf2nlDKvEVxBngOn17Y4KxrBHwwpIIZbFD80ssJQhtc9gWmp8bU3bk85CLaZrmKIdBf3f20ub2SJpuUv0V2HtBGFAlvuXLsyGkMEUdnXXQJmRPn03BbPYxLQTxH1TbCOuzRHS3rOk0wxGOxECPYksoenC2D6XWFSXKrU7aAzAa389Wbs9+YWJIZbZ8QwK/w2VuJq5OVj+pKTdlSni4IT0PejZFwbtAInGLFLWr7i
X-MS-Exchange-AntiSpam-MessageData: Ut3S6muMuMU5mXvYQTLAJfKCslZHOxVCIn3L2TCFqckyJpKbohwDTGAorvwIHulqQAVd8A+PlFkgHOnU4TAT2Ciuru4s0S5sZCGIVMBfxMhHmYwJBdiUsJ1q7+/UN0ZDKONXCiKoVyY9O5chGqOisA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c48539-def4-4f09-ab43-08d7cb816638
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 21:14:52.4872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bhr4T9xbZ6ZzuNA562n/xol0znvVAiaadap2BL08/g8qXdaFl0Iy1J9+eMpKsC2c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2998
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

fix typo for vcn1 idle check

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 71f61af..09b0572 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1352,7 +1352,7 @@ static int vcn_v1_0_set_clockgating_state(void *handle,
 
 	if (enable) {
 		/* wait for STATUS to clear */
-		if (vcn_v1_0_is_idle(handle))
+		if (!vcn_v1_0_is_idle(handle))
 			return -EBUSY;
 		vcn_v1_0_enable_clock_gating(adev);
 	} else {
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
