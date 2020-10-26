Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DC1C4363A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 12:52:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9F6F22409
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 12:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MEv8ARJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F6F22409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30F156E237;
	Mon, 26 Oct 2020 12:52:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA1AA6E237
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 12:52:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=il1FbG5JkxLExNqNQJsEcGzurez1t7uf/888LGlgkUr2WIr60GG49cSB16IMh8j/HXqjQFJZ7lgP7d4TP8NB8iMUQyq0hdJKMVpxMVJG3sHzhVU+yTWu8fC+kbbL7w469GtIuUuzWGiET9Kj20G/p+oNMWv7lfmgSiUW02FY6hkk2YdV9kc0KZzandOU54Ct+HgGlQMGFSYxbm6YeJ50DC2Tlp5+T+90QnxLVsz5rP9h/6Ucay2wJOFPPzT3qchpjA+kW4Pj37GcE5jg686maGvHX7i0Pu3kbHqmN8EovW1AjU2F6jvQ7cyXihqjL3jggdqTrdrKRgyef4RCoMb7lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfmZuRxthAA3pwJh7yXhaBxRhae8X3FAXS3I4jQjvsc=;
 b=XQeNRnE54ujbyR19t8ZVOMDoVTTb+fi1XtY14Y/eAqRAtFsQzP/+VqQ6/iCT6Y/oTB6bFjWufgIZ2kOzZv6EZtuhxtR+/kyMuJ+bvGyBkdBJUkvG6L7vLqh3vJoCjh7D7YNchHBDzaM1BdsAwo7EKlmHunEQPvh5/IUQiT/awxynrrcjhBeDBmguPmFBS+jH1rSIVFEGXEBa+MyoJSpvbhjM5Bmj5cFQoRNTxpeomWAjViw2sn5Lr085SlFWu/y2RwfDFKdRojP1cGfqx54dUwssGGqU2YN1FHPA43BxOpSUig3UOvlpMILtI2OPSUWhktJVgAq6yVgCLuc8UqlLjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfmZuRxthAA3pwJh7yXhaBxRhae8X3FAXS3I4jQjvsc=;
 b=MEv8ARJO46eTsgtjZD8aeknIjbawhuSiH+tNiocKyvQATmwAtRGmojpDnQ+cptLWXZpdxdivYjGo3fOd0B8Jp26cPkBfi+eKfEUaV9RehfWB3kbY20uDmL4b41IF338EIH2QT02wWmJatg6Mhmk01OTFuTJ/u6/ry9Y++hijRts=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1790.namprd12.prod.outlook.com (2603:10b6:300:109::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Mon, 26 Oct
 2020 12:52:18 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::b885:8b56:a460:4624]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::b885:8b56:a460:4624%11]) with mapi id 15.20.3499.018; Mon, 26 Oct
 2020 12:52:18 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add vangogh apu flag
Date: Mon, 26 Oct 2020 20:51:52 +0800
Message-Id: <20201026125152.460802-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HKAPR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:203:d0::21) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.245) by
 HKAPR04CA0011.apcprd04.prod.outlook.com (2603:1096:203:d0::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Mon, 26 Oct 2020 12:52:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ccc478ea-9fe5-4806-fc9e-08d879adf88e
X-MS-TrafficTypeDiagnostic: MWHPR12MB1790:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1790147710D51366FE7827F4EC190@MWHPR12MB1790.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4u4NLIEgT22i4n2teE3HlVRY+C1CP5XwrRqGPoJN3CmghuiqSlESBXww8H7y6aY7ARIaar2EpiSzIDK9/At4d+fxGAFTxRHKjSwVMpkrzgGR+jk27KjqCqjqMsRY47d7mql+0FLyS712Ln96h+yS/24u9TH+oCS9pum1gjG46FCwHLu3VPrSKRt8YyyQwBp/TSJTFyOULFXWHtjI/W2lY4PzOowVnRPS0wQVRU+5RcFGYOxzFs9ute8sIpNH9bHA3c0hP1YqfDgWx1lobLbyM/JYM6BiRuBCtHC3+8dpLJA/xVbar/aZeBK5gqIBgI0x
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(1076003)(316002)(186003)(2906002)(52116002)(26005)(7696005)(16526019)(6916009)(5660300002)(2616005)(4326008)(8936002)(956004)(66556008)(66476007)(8676002)(86362001)(478600001)(6486002)(6666004)(36756003)(66946007)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: fBSJJuTnZZO1BDrrjA1GaQk8HIKkejaKggkSkJufy2f82Oi88CHcaIYwZpswxknNlo9B14Irn4hkKIxMHyfC9QZzfdM5Yh3xDLKgtk3Nwgdrov99sPhihzxRjJ8TCG29eveKTkwttVtTaR1RsNQfU2AnsYKyMFQVosLcsBjexM0UuEl7ZxgDaHh+aVi1RfJfQt3JQJfJ5AN+cGQIHK0vcI8r6Ax6H6R27ziHDeSDq2Afb7XcEYK2deb+XTLfQIaYW5FBLGBWMSzSw+GC/b9gYZ50PGtUhfuhOieT00IQ9djvmStHgWmjPbk+4gmWokge+pvdcdoG2PC+mWHZlQxZjhUPQRTpfT0onKCjQFX+NRNMTMWSFzr98NkjukIw8AtKqQogxo9AzwDYkpHIiFeMz0hHAG5+NsjY9vAKgQWTwik74rwqzIjXot7SktBBSwlY/dyM0f6l9gcZTbm39f3TE+1V6NZdwX5yEuaVW0VwbvW+7SZK4KnVUb2dze9N8IiwIpfa0qP1rrI2kBygMTBDG2YZUPRg5QG852NOkTFTaL6sjmNVt1O9ecCspCt9NyiMnTmEHaitw78qT2sZRfjIK1hV7JP9cDFaiqkH3GtCHPVpyJM+qWv6opi/pQsBg3UbsiqnnA15ypzOhlheENBzAg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc478ea-9fe5-4806-fc9e-08d879adf88e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 12:52:18.3266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AK0J3AoDRWVp0vGmucq8StOVMYg3cX/o0Ijn6oeE8k5V7btGFgR1AZiVqywCeGuMKIJAmoDWKyGrR2aiMBT4iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1790
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
Cc: Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to add vangogh apu flag to support more kickers that
belongs vangogh series.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c          | 4 +++-
 drivers/gpu/drm/amd/include/amd_shared.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 30ec826c8760..b7fc9ebdf1c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -941,6 +941,7 @@ static int nv_common_early_init(void *handle)
 		break;
 
 	case CHIP_VANGOGH:
+		adev->apu_flags |= AMD_APU_IS_VANGOGH;
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_CGCG |
 			AMD_CG_SUPPORT_GFX_CGLS |
 			AMD_CG_SUPPORT_GFX_3D_CGCG |
@@ -951,7 +952,8 @@ static int nv_common_early_init(void *handle)
 			AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG;
-		adev->external_rev_id = adev->rev_id + 0x01;
+		if (adev->apu_flags & AMD_APU_IS_VANGOGH)
+			adev->external_rev_id = adev->rev_id + 0x01;
 		break;
 	case CHIP_DIMGREY_CAVEFISH:
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 06c1aabf10ce..412602d84f71 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -46,6 +46,7 @@ enum amd_apu_flags {
 	AMD_APU_IS_PICASSO = 0x00000004UL,
 	AMD_APU_IS_RENOIR = 0x00000008UL,
 	AMD_APU_IS_GREEN_SARDINE = 0x00000010UL,
+	AMD_APU_IS_VANGOGH = 0x00000020UL,
 };
 
 /**
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
