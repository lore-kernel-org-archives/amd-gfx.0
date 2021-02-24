Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA94C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADF1164E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF1164E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 656266EB3C;
	Wed, 24 Feb 2021 22:20:24 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC2C16EB3C
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:20:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ld7e7gzsKL0kkX0BFXf3wFgosynEJ1Uv4pTOLexZGwY5n5tcCU44DF7zNBH9GHVPywV7EI3uJ2aJFlZIefBQHGqhVIaA3iOSgPWT0JdOjpZNS0dNctslkOAC5icwJYtd/r+Fgt+IIm2XEGOv9eu67WHc00Dq7/MOQQHVIgn7Qac0ndjhyKbjiaTte4Bcp5wuegGbpy0AiWjk69ufSuuJYB0sdNAWz3ZRRUsrYQJ0v7e+xSOe/Xfp7do4mE5gcMvwV1XyQfsr8p97Un6XwuwTE3sRHMnSkQTAR/0Iad6J5bspWeP/WNStVmpLs1RpY+/74zoxp4D8kyXSJ8SlSZGzQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHZZ+3tzNU7kex5AllcD2aedefhwW2evRMsAKOGHavI=;
 b=C6/NefsXwB69qpmaJfsJ0xi6W+bDXjBGQZYTf75+Ye1ceqo5/DO5Mv3BSkaV0bkF1LQ2t9WvgByxbTMDxyLEuEF869QBjQqjQhjb+cxwu3X1K+VpeuRurOgfe34w5pD70eAgTnpasNqUlLB5lZ3uR4DqM/D+9YBbqEO1c6sdhqN7kEEcL1SAT/e14TDqzSUxM7jYnHhmKzltRdYE7WZz+zVT23R4r5mdAWXepExxkqvc7wCM4OtlKJmmnWnz0wnAj5bCPh9NsXA5QUkWM7eggYLVqlC0s9vFGm1cAdOLfVdXH89n4b45wDMxz7AZ+VW5fhqii8EimIee5k3DdMgoew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHZZ+3tzNU7kex5AllcD2aedefhwW2evRMsAKOGHavI=;
 b=lmhVxgnPwuwRkFt/bXBMdr4jn2ElabpxM1huCTGhoM9hMoJhNjoWib/gdFsebMHVjAzhO2Xj7I2Z3ESF7mvsivnAsN/Ga12BQeHNQgSHTb+STzNyIuKaFv4DsoK4znvpF9f6uyXYm3dM5NZTWb4pxNSoX1JAJp9Qi1NTHAU2WEg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:20:22 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:20:22 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 052/159] drm/amdgpu/nbio: add aldebaran support
Date: Wed, 24 Feb 2021 17:17:12 -0500
Message-Id: <20210224221859.3068810-45-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:19:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 382dace0-e4ee-4cf7-ed05-08d8d9125091
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4175A50D82029859792A4A25F79F9@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DDhxpUG1CDpyzosbeZi2BSR5rp3hG3Mv2c9iNOgPRgb0iCZpThYjKkaDnrjQjMe65zX38xX3AL0XlFXtfBXX2VKcBrsSkyNvIzZP59+/03LK10+NRWt7tw3I+0SiGFSFu7mk5L4S2UP9wFJdhiEm2ZFc3U+JiLh/38K8QV7MBtH8KmXWxO2nx8Wm9DTr1g2jE52ss7DtN2GXiDm/f+1Jwi/PB0jadjQHMLS6YVRDiP92bEtZCMVTnx38IczukmGzA6sVyP9F1ky87E9rCqjdG7MLJFKx3qwP6AVLkVCC8b0hqzsnAKMRl6DkQn+ku012PguoEojbiAxjhMDqtkuexljWkcHIc1iC/bZ4OmUMs4oJKldjJ3EYHuQOno8nMGwutyJWNLL0WIgtk92jIIC28zsxvexHcto+l3t1ukyUfeEJKbP/0GQNIkhDWTchcpjoG5KC0snpC4F4LDP8xU9uc5wibjiApFSdyjmXACw0SGvB+fJVXi5iblpl/luBX+rKzhWGzbz6lhAO/i/jxMG/KWAkriAroNI16oZRjMinoTKlQnrk/7KmJub/oucQQgY9mSSRtMCuMsTi8sbX/nRhYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66946007)(5660300002)(4326008)(6512007)(66476007)(6916009)(26005)(36756003)(66556008)(2616005)(186003)(956004)(16526019)(478600001)(8936002)(6506007)(2906002)(69590400012)(86362001)(1076003)(54906003)(6666004)(83380400001)(52116002)(8676002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Zi4HBqI/I/0znEDDNpCHXL4HaUybhJqxm4fRKtbTRgO0lqSGZAQWXxdwQ2zX?=
 =?us-ascii?Q?u1tHV77sp7BneSJLELo9OTSzELnQf/rVt48GySfVUlUs5S0xguRrjZI7PaWS?=
 =?us-ascii?Q?Jy7a9t2wncZBXgpVItShnUvYkuZPvJzE6ZDFhAgVozf44c0+HwBnifTu9Jlc?=
 =?us-ascii?Q?rSRURAgd5jktM0xoVt2vxVHEo8z+g5gV3fowLSPewnxetbGqWHKVADuEErTV?=
 =?us-ascii?Q?4u5mgvoM0nWJt1Qe8woqlB40F7JAX3dtZWsqWxCfcOOG7zS4khw+gz+yNYeD?=
 =?us-ascii?Q?vHO7gJllBDqACUcbW+jW5OHkpB8zZRpc5ztqa/9EJINP4GAnnNedDUAzhppp?=
 =?us-ascii?Q?bDGUtraJffwqdxhypCP2CSvKqCzbebIFmhggHCjIpIL2mh1Ikfh7JQXxSKrN?=
 =?us-ascii?Q?3gb/CCBbEGN4t/AM6i/iPgPMUJ2ravi8A85nQsCNugddXi6yi8gHaEYO6Dwi?=
 =?us-ascii?Q?EPipvqFtRw0uv8kbni9ORBp3JQ+ekvvj3qrZnr0J8kblmS/z1vCM3a/61fgc?=
 =?us-ascii?Q?lwv3TY5/Y1ZwjM3sKLuEC6rPTahRP1RV7PDtVFVU3MraR+DA8Esd41doyQkR?=
 =?us-ascii?Q?h3303oDvdHePHnaZeLl0cN0x+gMFRI236WmPK1DZA2ETOlbubXEGDISejaNv?=
 =?us-ascii?Q?cT1SfmHUhCN+UrkF5nWCRnGfn9mO4BGD1nguqfPX5Vn6EMaXKKw7VWZ/Yx/3?=
 =?us-ascii?Q?5kDi180uhjR1Fki0fOjW0JB3QHbRrpXqpm2S0fbQBkVxPBsBi/WPc0C+iT8j?=
 =?us-ascii?Q?N5GpzNzi2pg2iExclCVcEQ6/OMrVTQSvncVjKkXT40OwvKOUYPoPFH81yDG3?=
 =?us-ascii?Q?t3DZQArEELq3nZyXtwjkWvaOs0jqlw7ZOyFD/plNRuXSsG1rroeU2bLJrX7D?=
 =?us-ascii?Q?oNafhoSdx/HVyPoiv3P3/WuOCxW4RuP3f8BJ50KWFq6McLIVHOpItJHaUupn?=
 =?us-ascii?Q?Qr4zq9Rxk1LQKWHcTnZB4M5iL7+GzBDkEKVz8e4auSxa3a/QBLanMQ9wUJd6?=
 =?us-ascii?Q?gYO9Dk1zaCbbWkHeOYoplQ1MEwvV2iUfoebYzYL8hRLvdSSsv7HX/0SD54C4?=
 =?us-ascii?Q?X4Lo7vRQ6GevBIfBmLLTrRbLjbowF0HuIHnmNpYzX0eHRmReDdtAGx4ISPvt?=
 =?us-ascii?Q?J1MoC8EhwgWueVLAgpbMXOcpvkzhbjZ+4onzWU3RtZJ7LGASzwSbw+VAz2zK?=
 =?us-ascii?Q?/1JPJb61XadWJaRkUT4VCE8Wc0HNgIgFCQ1SXEKtA70woRcvXEOK+plAzn1S?=
 =?us-ascii?Q?NWawsSL1zEeItXQTb9AOubg0rT3DPu/1IM6sILhsoqrJAWPmIjo8AUyI6cA3?=
 =?us-ascii?Q?7xkogNjhRkeo9AVr5UTKMRBd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 382dace0-e4ee-4cf7-ed05-08d8d9125091
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:55.9644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8LFe5tGzCw6puhNBwvZqicrXIvn9VDkrl1KqDU0i4yWfDsOHcg1TlKhapPelkm4WPTuj6d3Ar0WP1Dk06UesQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Aldebaran has a new mmBIF_MMSCH1_DOORBELL_RANGE setting.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 5dbe03d3b0dd..c477f8972d5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -52,6 +52,17 @@
 #define BIF_MMSCH1_DOORBELL_RANGE__OFFSET_MASK          0x00000FFCL
 #define BIF_MMSCH1_DOORBELL_RANGE__SIZE_MASK            0x001F0000L
 
+#define BIF_MMSCH1_DOORBELL_RANGE__OFFSET_MASK          0x00000FFCL
+#define BIF_MMSCH1_DOORBELL_RANGE__SIZE_MASK            0x001F0000L
+
+#define mmBIF_MMSCH1_DOORBELL_RANGE_ALDE                0x01d8
+#define mmBIF_MMSCH1_DOORBELL_RANGE_ALDE_BASE_IDX       2
+//BIF_MMSCH1_DOORBELL_ALDE_RANGE
+#define BIF_MMSCH1_DOORBELL_RANGE_ALDE__OFFSET__SHIFT   0x2
+#define BIF_MMSCH1_DOORBELL_RANGE_ALDE__SIZE__SHIFT     0x10
+#define BIF_MMSCH1_DOORBELL_RANGE_ALDE__OFFSET_MASK     0x00000FFCL
+#define BIF_MMSCH1_DOORBELL_RANGE_ALDE__SIZE_MASK       0x001F0000L
+
 #define mmRCC_DEV0_EPF0_STRAP0_ALDE			0x0015
 #define mmRCC_DEV0_EPF0_STRAP0_ALDE_BASE_IDX		2
 
@@ -142,9 +153,12 @@ static void nbio_v7_4_vcn_doorbell_range(struct amdgpu_device *adev, bool use_do
 	u32 reg;
 	u32 doorbell_range;
 
-	if (instance)
-		reg = SOC15_REG_OFFSET(NBIO, 0, mmBIF_MMSCH1_DOORBELL_RANGE);
-	else
+	if (instance) {
+		if (adev->asic_type == CHIP_ALDEBARAN)
+			reg = SOC15_REG_OFFSET(NBIO, 0, mmBIF_MMSCH1_DOORBELL_RANGE_ALDE);
+		else
+			reg = SOC15_REG_OFFSET(NBIO, 0, mmBIF_MMSCH1_DOORBELL_RANGE);
+	} else
 		reg = SOC15_REG_OFFSET(NBIO, 0, mmBIF_MMSCH0_DOORBELL_RANGE);
 
 	doorbell_range = RREG32(reg);
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
