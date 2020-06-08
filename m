Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D038DC433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 07:34:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EE432064C
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 07:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tA+fLRZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE432064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 350436E0E1;
	Mon,  8 Jun 2020 07:34:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE0EC6E0E1
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 07:34:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFaXaHHHj7Klrvfq2qnMJGbl73MaGzxTYjcxW2JubjNMH8+3a1R9xe+qoQZyv4cdedkQFf0uk7hRFIrtlW2Hou3pSqyaN7UcYcYrgKnjDemIx4WBeA149vdfAZP5Vz+/+dv7OPC5p7631WmChBUNg7EN7x+3j4sbRP4nXVrv32PVhzf3eE7LR/wX6R9UxLuNsC6rvvR4GVkVs18xJcai80muwXazWYLubwq375P4L8g3ngvWqTbt2XgY2aRSGSUwSFU9eAD/glE+dUTy/kcGEX0rKepIZDqwEst6bt9WHfqtPnWB1py6ng0IoA7lI9YDDI/wW5G9dDE4h+fFTDAivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rw6qrkSIWrRL9VC6+mBufRHWPpetENRSmqAHEOiZw1A=;
 b=WA/blALzWDKM+vqgK2GHmD7+U6c/bS5lN8iDJmqXmljCYaZHff4Rp8vzNOIUTOpNPEy2g8pESVjFJarNp39wWEKR2NPFL836yUpuGmOK1SVDylYyusZtCorAJf99xGs/2i5uqnlhcQ0jSymFDteyswsJDSWfpTT1lWIu8CS1l5Dn00a5FrzTjbS4yYdMWoyQA4Pmduijj6v568KSMsIABrTxRJrZVAVuAohMM/I3OY6ntzcgzBHghgR5VBO+4mbRF8ubWB1fS9tFk5pSYz8k1OOVft50tcWHG9rGh4dXyLKGhAXleERquLQsskRiXNKqzB8yucHZOILIYTUmh0drmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rw6qrkSIWrRL9VC6+mBufRHWPpetENRSmqAHEOiZw1A=;
 b=tA+fLRZVGPZab5mRHMANwvBstD4iLj+QVE0M9EBnkQTRso66922YnoVrJFmyvj5GJcF4RV6u4kPeA5Iy0UmoSUpeNx5NdyhPoiCLqbOLMq2F/+zyTWnJP/ZLapgd6s/BANfDWn6V5vfnOFtoBU3uxzOrOdz/i2yKaGOgxqAoWM0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16)
 by BY5PR12MB3924.namprd12.prod.outlook.com (2603:10b6:a03:1af::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Mon, 8 Jun
 2020 07:34:18 +0000
Received: from BY5PR12MB4307.namprd12.prod.outlook.com
 ([fe80::2c8e:6202:8066:9e8]) by BY5PR12MB4307.namprd12.prod.outlook.com
 ([fe80::2c8e:6202:8066:9e8%7]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 07:34:18 +0000
From: "Prike.Liang" <Prike.Liang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/soc15: fix nullptr issue in soc15_read_register()
 for reg base accessing
Date: Mon,  8 Jun 2020 15:34:08 +0800
Message-Id: <1591601648-32141-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK0PR01CA0069.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::33) To BY5PR12MB4307.namprd12.prod.outlook.com
 (2603:10b6:a03:20c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (58.247.170.242) by
 HK0PR01CA0069.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.18 via Frontend
 Transport; Mon, 8 Jun 2020 07:34:17 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d0c4727f-8c4b-493e-7a06-08d80b7e5a4e
X-MS-TrafficTypeDiagnostic: BY5PR12MB3924:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB3924D09986548F7B8037922BFB850@BY5PR12MB3924.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZMwtUkdEPhKxI9ENmQEgDAmy2QZV7227B3zD3Q9qAsEDMTootSvZ0yqX1A9Mik4Vz9M2s441DEqFgd5uOgCGIdtq7w6cykZQFb09dWw5DAVgKL6OAQcRTjnfqvla08BcN+DYJgyknm7wtsU4lJPWjssw0sJRW3C+ygJSppDbdXPxTOFfevaoQL3mkf0RoHE9FmAaj+ull4rop4opb0robK5ua8M6MRaawq97+c1YudtQHgbPTjmYl94HBlK0bO4d6tBVNML1IzghWjm+EG068/ncdxfbK4mgUs0NI8hpvBQMpsI+SuhVMst6RWt5l4q7ZJKGU1ZxBg6+o79Iy40hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4307.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(478600001)(8936002)(316002)(6916009)(2616005)(956004)(8676002)(52116002)(7696005)(86362001)(83380400001)(4744005)(26005)(6486002)(66476007)(66946007)(66556008)(5660300002)(2906002)(4326008)(186003)(16526019)(36756003)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 5Bu47oZN2I+9qvsfebvCRUIsx8uk/WD3J4U0GXRJQPhY282lyEhTprpwp/1LJFFN/SJyGs0Gbe8d7bXt/eCetbwH3M+rnrQx2Y7SHusFLc2CTjWvdKj0Nk5ffpjPcBymhUDAjF5E3rEM7NCVz/baV5nebc2c4L/ffkiZ1WGmP/I5moEaAGAzB+30bmuNtc/nY85hvhzqP27cv/1xnZVv94moMUb206Hl8wbxjwkLZJcsbb8nU9p6x//zR+0+TWUMGCvmuigEj5hYENHXkdIERyuKemJGQSydRI+YcT4Su0/2NhXP3nZyqXobF2psXI3JV2Fl8bBne01+wUe6GY5HCymY6XHxhziBxs6o/ewuQMWJPcT5ZxbSfkI7ZhbRwkDTzyTRp978Zw0yC+x45m6zeKGYqZ8UaBlf4RJbdFC/09IpTI1FyzcyN+AOnv19T+ky25dgroAIyfUoS9zu9+78fIwOtZ4iu8kNLet/5a3nOZ1wZGTpj9th4J9NaPrdPz+/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c4727f-8c4b-493e-7a06-08d80b7e5a4e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 07:34:18.4351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BArlyn9zUBQGVoQmvKU+LsaBqGvQg30syIPOKQ/OxieMXja+RpAlun6rmtGgBKB9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3924
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
Cc: Alexander.Deucher@amd.com, "Prike.Liang" <Prike.Liang@amd.com>,
 ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The failed case is no SDMA1 IP for Renoir discovery table while in accessing SDMA1 reg base,
thus need have nullptr test for soc15_read_register invoked in MMR addres space inqure opt.

Signed-off-by: Prike.Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 623745b..3e406ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -415,7 +415,8 @@ static int soc15_read_register(struct amdgpu_device *adev, u32 se_num,
 	*value = 0;
 	for (i = 0; i < ARRAY_SIZE(soc15_allowed_read_registers); i++) {
 		en = &soc15_allowed_read_registers[i];
-		if (reg_offset != (adev->reg_offset[en->hwip][en->inst][en->seg]
+		if (adev->reg_offset[en->hwip][en->inst] &&
+			reg_offset != (adev->reg_offset[en->hwip][en->inst][en->seg]
 					+ en->reg_offset))
 			continue;
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
