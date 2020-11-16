Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A59C4742C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 07:09:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 159242071E
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 07:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="C4MY/JHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159242071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B95689CE2;
	Mon, 16 Nov 2020 07:09:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6962289CE2
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 07:09:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fq1hkOuImTeSBXQ20Nm/F26TheLHz9AgSYvBZ3oz3y651GWhEzSUkgsBxya+qT4IU0xC0Nn99Yoc6ByFWnno5kqCNngDwQPQ1uUQaXKjbaVPS8bkzMQU3tTOh1bCbiSSqjgBxsKRoGEK4EnFkBQ1q4pIxbxrttC19978ELm4UpGwG+22OS+wSnTwU8QWUZsYqeMQjaiAncR5Pk6mM7IXX8l2U9NUkPkLTVveY1IioXqfBrxM3RTdQFJWgxO4h/jn2u9i7zRTfuAHGWx25YImfC+D4FBlubTj/gsKrwJ6LQi78mPY/eGilFmVeJiVxks3+dCn2vGu5NbqnOccpSOBKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIDgNQhGlFTMol/q3trhEzjUvzeQSsfhAbpDixoSJ5Q=;
 b=H2m4Pcvjus5SV3UvIkAIbJ+G7XRa0r89OAYY3VHu43Ofcxxj7+X+dgUVIB/ih7KoSWIb2tCxq87O3K5r3FwoitT2H9BGiC6cduRwv2vCYa7o9vDXfKua2FaXRjgl32Raf3DM4E8oL6B2ZBzAzYvskLfgRGeu7sbmULbkkqTNtQnHaVndiNZdBI8NS8SrH5vSJpxVVj0YQIHQnDlOjsc9pyh5jDWAQoWPKX8QYCr+sf7y9ftJhgu6oZ0DGatKxJGRP+5i0mjtIHh7c5lImlTwutqtI1Q2z6/Ux+w9s4pYuQCe2J3BFbg/d0Yg+Isv5cLVLNtx6I3NMTpsd+c5U/i1fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIDgNQhGlFTMol/q3trhEzjUvzeQSsfhAbpDixoSJ5Q=;
 b=C4MY/JHmHVaLorPyJ9K0JFC3Lbo3s7UiKJx/Ct3g56X5QJBthtROPRGic0t3Q/8Y7UwLPR8HqBjJ17fDL0iQV9GMt7KAnDFDgFMBZL0E6RTQuSxvCzJMXGEj3f8zQ3dDuTvz3S828/ljPqG5pLjtWbdfQ4vJZtGWGN66gatqWv4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MW2PR12MB2396.namprd12.prod.outlook.com (2603:10b6:907:9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Mon, 16 Nov
 2020 07:09:54 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030%12]) with mapi id 15.20.3564.028; Mon, 16 Nov
 2020 07:09:53 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: update golden setting for sienna_cichlid
Date: Mon, 16 Nov 2020 15:09:33 +0800
Message-Id: <20201116070933.389791-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR02CA0139.apcprd02.prod.outlook.com
 (2603:1096:202:16::23) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HK2PR02CA0139.apcprd02.prod.outlook.com (2603:1096:202:16::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.25 via Frontend Transport; Mon, 16 Nov 2020 07:09:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 500fa914-0654-446f-76e6-08d889fe9dbf
X-MS-TrafficTypeDiagnostic: MW2PR12MB2396:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2396FABA82DDA234FF95F579EFE30@MW2PR12MB2396.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +60gx0K7XICTwrA8812ROpruFuTwuNwLpCZJQvx1tANfzSWoKgWncd1qtyA8cqgjriDNyUao9tXu2csQpTakUHs5QdJI7suejJRcglfffjb5iFxAgMiHmkDMNRZnqp3Sz+xyMCq+0DNortYxjVJo+Q5JrURQo0t0EXlidm26ReSfcMeCSL1BVNT6cmfa+EKKsYulBe9Iu+sy6zSQ5px0dFbzSAY8K6lbL+Fl67OcFSl+7yHXMWRjKRfW0IrdEz1JZdYGodBOaF6xdQaR/kzDPJm1xdKf/WI6OgwbtXexe3oEBofEGhVO+ie4L5Jg8soXD4zgD/g9xCm/L/WPxvQY3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(6666004)(4326008)(86362001)(19627235002)(1076003)(36756003)(7696005)(2616005)(8936002)(478600001)(66476007)(44832011)(66556008)(6916009)(52116002)(66946007)(956004)(5660300002)(6486002)(2906002)(15650500001)(8676002)(186003)(316002)(26005)(54906003)(16526019)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: e6UqFGaNnLHSw8AchEPhQClGY3Ao873y4GJ8DcTjGjFBwC3sUg2VqbrfNvuGOuyrhEFsGp48sG98E05+gc8ElgT7qGOxmlklKKX7upYk8pGmezdzov3wCdXrjhzQDsmE145qjjjzoA8y91s9IzGdJdquMTWaTVkzjpethSO77DIJNErqKgM50wBNKPily6RE8ad7SRf+LJOyFY2nXft/WSeC3SuyeB7VoHJW9rr6yEvsYqedW7IcXFsuwIf+Tet5n4CFIxqxuJxITgbR6k9E1rBivWtBhP/9ZcGKsrKEMnrxO5bkn7eJEZtciz5gNNjwRpnikkJTDYwNVpmuTOGyEPQ3/rhp3L+jS6RDP4bphrOZLXxTfPMEU6hnAc1DNtzo5uwiu7AOW/FlOmdxQc/MURvH8LW+9xFgJxV2JOGHyHqd3odjb2No+/nL1mnHoOeFfpUUhO+FKx4bssolCVxKVbnUxldm3TuoBRk5VV9a1A0P5a6nr58XQw5NbEWzxza8c4FyK5WDUKHI0RdwzfzN5AGQmIejiQas7rMz08WVnKoMfNbclI728/KftCMSz+2yPvSuuOo2CFdBXyZE/1yPme84SVgA/l8gZmEFIQD8NjYfh7Hl94Rfq2nyP+ZMTXMMjSUBpnRrxFES4erjo0UMIWP1aT28bF7rSHi47GkjCdSQhgVfY24VFkF8uGc1HiQOi7I6pB2L4rstmUFuZaXpIE4cpMQMV3p3JHG2I6/LXj/eo5a/5fV5mhPKmiXh+1sqVWuPyZEm8dgEpu1d7HKp1v76miwSAhKdWHn9AovqKw3jFBubDvadsyCBGNPBpnNz+AxYpheS0SdnIGmrfX8Xuf4JqSj3je4x2QRMt2lP1ehX28wZmuLGKtK5V+JyIN0FtLOcwzgkgUEFMcH9VXJT2A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 500fa914-0654-446f-76e6-08d889fe9dbf
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2020 07:09:53.6663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mNVtS0StZAww+cFfPuuUFGtyPsIum5GtJfI6K6I2NB3FhohtZ9e7H2oSqrO5zw5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2396
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
Cc: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Update golden setting for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I968f405a11b640174f5bc03eacc5f4edee47815a
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 270b502f28f2..a6d03931f7fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -155,6 +155,11 @@
 #define mmCGTT_SPI_CS_CLK_CTRL			0x507c
 #define mmCGTT_SPI_CS_CLK_CTRL_BASE_IDX         1
 
+#define mmGCUTCL2_CGTT_CLK_CTRL_Sienna_Cichlid		0x16f3
+#define mmGCUTCL2_CGTT_CLK_CTRL_Sienna_Cichlid_BASE_IDX	0
+#define mmGCVM_L2_CGTT_CLK_CTRL_Sienna_Cichlid          0x15db
+#define mmGCVM_L2_CGTT_CLK_CTRL_Sienna_Cichlid_BASE_IDX	0
+
 MODULE_FIRMWARE("amdgpu/navi10_ce.bin");
 MODULE_FIRMWARE("amdgpu/navi10_pfp.bin");
 MODULE_FIRMWARE("amdgpu/navi10_me.bin");
@@ -3144,6 +3149,8 @@ static const struct soc15_reg_golden golden_settings_gc_10_3[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x00800000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_EXCEPTION_CONTROL, 0x7fff0f1f, 0x00b80000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL_Sienna_Cichlid, 0x1ff1ffff, 0x00000500),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCUTCL2_CGTT_CLK_CTRL_Sienna_Cichlid, 0xff000000, 0xff008080),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCVM_L2_CGTT_CLK_CTRL_Sienna_Cichlid, 0xff000000, 0xff008080),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGE_PC_CNTL, 0x003fffff, 0x00280400),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2A_ADDR_MATCH_MASK, 0xffffffff, 0xffffffcf),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_ADDR_MATCH_MASK, 0xffffffff, 0xffffffcf),
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
