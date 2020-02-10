Return-Path: <SRS0=VWwp=36=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63674C352A3
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 15:35:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3276920715
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 15:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2D6LhTcQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3276920715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA3556EC99;
	Mon, 10 Feb 2020 15:35:41 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750089.outbound.protection.outlook.com [40.107.75.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93EA16EC9A
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2020 15:35:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzFwww2YcnbfWmNtxFG8tzNGFxzX8I8UdEyI/i4hHkmr4JO/yDDXwHXG6oRnjaSLUYapeLQCv883JQtveLaGAXScQQPOMQHvEiuaGXfG0SfxhVIwztIedfgxSK1ZI6LJIMsX4YjNrb6F8/20r3CRYGLN58rUV5th/aH3UBPFpVDNFU2wtLw7q36A2YtLXWzL90+9OoghHNuabki5VEWlwxQHfGcI9mD+XmIx9BcsT0xTbEPTN78lQfnGb4SDqkJbT9F/1siQYS8JW0OLglBzEIWkhfVJtxDOnpH/PGDmgyKqoFoCrF7lJ0d3KB1vMd/4eSbFf4PCdoC0mWDX2+7nig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hc5keUDh2nPBK9HQjiv6z1YulrU7PwdterwTH+DzNwc=;
 b=HDcM+CqCVfaCFt8mlX8DZ+pfQ5qBeqFnYn9gfvjNZQJmx+Qaw16FXLvkQaUnHPmhq6B4PJkxH2tRQv6Fdu9rmzNkjoQpEddJnxjNR+7WGyKympkr5KADKITGeMBVaBG2IkGGcHdAodGf5rlmXc38b+MfbjIC6bpKH4+SmeAGrOGaLm41t0PuMqfgAYyblSxQPos2Pe/qZa6Tx2gfRnHmqzL4dx8WjXaDLmYtEvIeLdrS3oxPgIBjtJtTjjNvNMigV7E0DqEKksDwg/iTtEOM8MG25Fl7alerOd/EOXkBPUsGhZfux5VyHkkuXQKNQI7xF/lg9lEA1s5II7df873sqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hc5keUDh2nPBK9HQjiv6z1YulrU7PwdterwTH+DzNwc=;
 b=2D6LhTcQl5ZtzKDou0qJ6QxM0PKK85OuM7KiZbI9FtJ2wwlT8pojRNo17LMJhLa3VTegdueNW+uogjxJB3kSwW8tcZ1cwhIyEyTAz1jj0yqze4aVzKTNWrgIJwn4a7Ukkm/zPL004qTmtT7A/iHI4A8av8AtIIZ9UxScDk5oTIg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB3144.namprd12.prod.outlook.com (20.178.53.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Mon, 10 Feb 2020 15:35:39 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2707.030; Mon, 10 Feb 2020
 15:35:38 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: enable VCN2.5 DPG mode for Arcturus
Date: Mon, 10 Feb 2020 10:35:30 -0500
Message-Id: <1581348930-25085-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YTXPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::40) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
Received: from work_495456.amd.com (165.204.55.251) by
 YTXPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2707.21 via Frontend Transport; Mon, 10 Feb 2020 15:35:37 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a6277a04-bb24-40c4-1644-08d7ae3ee112
X-MS-TrafficTypeDiagnostic: BYAPR12MB3144:|BYAPR12MB3144:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3144A001786D4B1CA9BCFAB2E4190@BYAPR12MB3144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:612;
X-Forefront-PRVS: 03094A4065
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(199004)(189003)(4744005)(186003)(8936002)(81156014)(6486002)(81166006)(7696005)(6916009)(2906002)(8676002)(26005)(52116002)(16526019)(36756003)(4326008)(478600001)(316002)(66946007)(66476007)(2616005)(956004)(66556008)(86362001)(6666004)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3144;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8MM3tuQ7suzGs0kxSAi6j6yvWmhWzQR3tYu1Zv4FxwdHUOKJO9DLUYwwth40oOq2GC+4hOv4mzkESi18T+AFNBSQo0NX3VTZhqMnOW0eD5PP1d5k36Khdj/LoGXeJ3QuAgKeSkoAyQX3EzKMbh02rv2peNHN3/WS2HyTnlYmkzHUW3R5GFMYgWyyzX5SJlJKMXCuFJafjUmMQXMg/IisNYLXWBOMvDZPr/b82VQ9nv2Otb+NaEVdVyAzh31ypJwLoLKiYxybOzd5mGAXgSYTjDP+74JH4vmIqdRB/9YPyr7oY03UwghTqzF/TbirXnX51pI/Ww/xJb6HzVyaGS0mFkGRdtqKvDSycWwBd+hZCwxNKcX2tOsz0x2/eutFYjwj2wRXw5p96MWxFG/3OM7DrtYG9fpOmeIsRh29wz/ZIjljiMoFrh+NSHB8z3amOrM2
X-MS-Exchange-AntiSpam-MessageData: loucyljESrY6DHg8EQlXdexI+1elEWKA4IJRZ2PCiznrb5zG9LhdzRw+IUctRo8oSCki0yXkEQTW+czutKKsqLPRZTyIfDLIh1u2hW+042yVzqdfYYYwYp1ISoLaDwK0DzJWSgxAyCTXY11FpCZKxA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6277a04-bb24-40c4-1644-08d7ae3ee112
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2020 15:35:38.7666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AeEI3++bQUja8Q3DaHZqq8oDgCYu+4tMzMT0KcWKfUJt1f5eQM07oPHHCZNPi0pT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3144
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

Enable VCN2.5 DPG mode for arcturus after below items are applied.
ASD: 0x21000023
SOS: 0x17003B
VCN firmware Version ENC: 1.1 DEC: 1 VEP: 0 Revision: 16
VBIOS: 23

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 15f3424..4cecd59 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1186,7 +1186,7 @@ static int soc15_common_early_init(void *handle)
 			AMD_CG_SUPPORT_IH_CG |
 			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG;
-		adev->pg_flags = 0;
+		adev->pg_flags = AMD_PG_SUPPORT_VCN | AMD_PG_SUPPORT_VCN_DPG;
 		adev->external_rev_id = adev->rev_id + 0x32;
 		break;
 	case CHIP_RENOIR:
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
