Return-Path: <SRS0=4T84=IS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726B0C433C1
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Mar 2021 04:19:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 329E96196F
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Mar 2021 04:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329E96196F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEC086EB2E;
	Sat, 20 Mar 2021 04:19:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89FCF6EB2E
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Mar 2021 04:19:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZW5EiFfivFItO/qTyhBufU5xw9asghVlE/gqtDKZ2ryshd5LlA98ziBkxVCkbmONY5nHmmL0LpuYwXQ3uZUVCuPQddCtzhRAQy3k6C25Xxfe8WBZ3CS+v8M17uGkXaeK9OBVYN7JEyNGolrC7DWag9vdRXsDIM7cBBDt6WB0RA9mc4LfjqSj5PXu1kh7cMBs6LNQUnlPv/1msAs4eQVXqvcoJbbS0wOUoNbyFqNVcvTtXNopyAF2r6vq8jdH9XpOELMU/nYWDj/0u/7wJOt28ozhrxJLhIm4EwIkafMGN6q0yL8+bpSwvyN6AFk/nwmVCEgHnQStBe4IwAJPqXeRUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luG/N+hIAQuyFwPE2Y32cXujpU+Eo/p2FZbsY70B/n0=;
 b=KM4V19XwclgnMxGBTGx7PvOc7jvp0Nm0RoY/rXRCa+HDE6X7rpLp4hmGIYscx9fqeSB8r8/MEYzP3CBtfoSc800N4JUEZz/FrXQNRBd8n1MYS4LSw6IX4tQD4TsYtHWkD+tT10iMbctO0lHbwutW4DQXHCDqyFxtSf5rYE01EHHHG3kbEqsmKo+wLg8uBYChrYU1iqrKVFKer2Vus3MXNAvOCJEPxohx9+/mQYj4Zd0mySBjloXlQHWI98XkaGwYLNiSaMT7PKW4P2ctMWf4fdp2pswN/EqTQoWLXUNc4quvJlsMJ325t6pv5q5ZHXAUrFIB1Muw6YoMDLEWcgfQww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luG/N+hIAQuyFwPE2Y32cXujpU+Eo/p2FZbsY70B/n0=;
 b=e9wzd0hNQqHt0y+ba3DC84+GUW0SUqj8UWuEJp8540GxGIJqV+dzDtOP6SYfgSjJ9y3XqpE+X1dvVs2SwwijTaKLZi9KY06vTztUr2SmTv4Y2NYeoY8v2PoKGpNZSk+wLTd/XAIgZfConDmwSIfYmqWGzoi9gkA1R2f+aL0sl0k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2605.namprd12.prod.outlook.com (2603:10b6:805:6a::11)
 by SN6PR12MB4704.namprd12.prod.outlook.com (2603:10b6:805:e8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Sat, 20 Mar
 2021 04:19:43 +0000
Received: from SN6PR12MB2605.namprd12.prod.outlook.com
 ([fe80::5c4e:1bdd:5eed:b2d1]) by SN6PR12MB2605.namprd12.prod.outlook.com
 ([fe80::5c4e:1bdd:5eed:b2d1%6]) with mapi id 15.20.3955.018; Sat, 20 Mar 2021
 04:19:43 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/14] drm/amd/display: 3.2.128
Date: Sat, 20 Mar 2021 09:46:56 +0800
Message-Id: <20210320014656.23350-15-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210320014656.23350-1-solomon.chiu@amd.com>
References: <20210320014656.23350-1-solomon.chiu@amd.com>
X-Originating-IP: [165.204.134.249]
X-ClientProxiedBy: HKAPR03CA0030.apcprd03.prod.outlook.com
 (2603:1096:203:c9::17) To SN6PR12MB2605.namprd12.prod.outlook.com
 (2603:10b6:805:6a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from LAPTOP-K5LN3AJ2.localdomain (165.204.134.249) by
 HKAPR03CA0030.apcprd03.prod.outlook.com (2603:1096:203:c9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.9 via Frontend Transport; Sat, 20 Mar 2021 04:19:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 63fcf11a-13a6-4f73-fbd5-08d8eb5762a6
X-MS-TrafficTypeDiagnostic: SN6PR12MB4704:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4704088E7A20616470DA0B6597679@SN6PR12MB4704.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e6/TJD8nMlbUcGZ2xJrhJL7wIiAT/yVExGYM2vt87Lri2n0uA6k4hdr6P/nKi5i/EGkuF/BUygDj2TbztonG6H/1nxQf5Iu3JmqKTd1JW4GGZLNkTQ/IoIYoQZoPMkgCr6M2KjVD0E3KvDSca1hiOAm+u0NNJx1JobbUTxdxdvBCW42YCUA31LPoMOaVDHgc0gJWHrebNZJpAL939kFbZk6BUzZFCPzfld00zebds0qma8jvcSH5HbyyokpwqjRcm/amCvZpgxHiakMjbMdGrszfYqU2u6YPB8RbtHxnUBxSYhbxv8OCzPC5r+yPRURAQgjCvCqBw0qFjQPxpeYvdKJPtaQ096e2QCIC8rEy0l1YMpO6sH3WbGjCuokN0ZALeQFtIZjyqUu/tE8PFWlNTMbuc2dxgbeC2+eDfo4Y+0hRy9Kn1OXfZQnDgXL5xJ/EBcCr0xexIlYSIzC6oQcWskgCxs7uOpKwtuQwFuUxkwQR5c00lM+bbooJDwSF4eZR9pv1232ZuYMVz+CgNX1HRQlxC14TEUE8Ns+KLEoSDAnm08OvF9i1PZTr6eftK5MNSDXzUuM/A4KHpitGF9MK2OKXhV1FvRHMw8PIxucdmrzlTQ5fiNh0v6foaDXAL/4NAWgLLxRqEK/o1z2Z7FXYUWDouhrnflQ1opGevMbFoIs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2605.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(8936002)(6512007)(44832011)(6666004)(26005)(478600001)(4326008)(8676002)(52116002)(38100700001)(36756003)(316002)(86362001)(6916009)(6486002)(1076003)(2616005)(54906003)(83380400001)(5660300002)(66556008)(66946007)(186003)(956004)(16526019)(66476007)(2906002)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?m85Ub4L6u43ciwcTgE09BefbdYFh1K16MUCN/SjDuwnw6NKesar4ODr0mNcC?=
 =?us-ascii?Q?gvaKfwzbE2DPgqpvSANItsl78KQ2YWKT+/ivVW076SwX7FQ81Ie0NDNBnOal?=
 =?us-ascii?Q?oshQ1FRFu/02+Mv9tiyVU+SoCZsLP2ueKfOm6GDUVZwnfq6zwT6ajiYS6KRQ?=
 =?us-ascii?Q?ptfZ5J3neBeo/xazFazn/+hcblTJSEGTfG16+Psfmc8RaLE6jf2YEoMxdrag?=
 =?us-ascii?Q?C8W176d8Bmpb+bSubVzUPhCo0Julbc0l8X8wMDTo7BObHMbS7GCwP9wpbWxd?=
 =?us-ascii?Q?M4N7knV5yfzXbz1dcgSyNfQspThM6hMGvFLxw1zlNaEOAP3huF+HINxI5I3V?=
 =?us-ascii?Q?B1WxIoWRir2A7U99HpWOCqoEJqe4j32nldpAj5jkyAcLTcNkxR+BjqeEJkwu?=
 =?us-ascii?Q?2gArmFBS9W4n8BZ6t/5rhurHRLYH9u08LNoaTUstTPgip+phGDzGM5PHrpFS?=
 =?us-ascii?Q?qOVrMAml2v3khB3wnempk8SLnPclJSMvqydSxv3NqR8b0NTfs6n1o1GfGMck?=
 =?us-ascii?Q?xVNtmQEpUIm8oKd07TxoadOHuNCpZWGKYrYg1QUacfU06bMvgc1HCDJF+rt8?=
 =?us-ascii?Q?ZHUBSHVCd6I2799xtoUo9dVSxotesCm8z9drsTWsvWUF5F1VOMhNn9u806y8?=
 =?us-ascii?Q?437JfRKknIsPiBAFRShFBp4ljulp3aRFHdOcjWRfnSBctkKxKYEMxdFr5vrh?=
 =?us-ascii?Q?aLVUWNQ/Ocbiat27wfQNuNGRAzaAWl8Gb0RKeAdTYoOqzcvBW92DkTxw8qE0?=
 =?us-ascii?Q?sVh9FbyNo1WJHRG7KqgomGKrwGfkE7HPXWEG1PETW3tF6oNTg7tnT/cvPAv1?=
 =?us-ascii?Q?BZC/05mAPKIz6fRmyVzjm1GmrFd+nZZdTknmxIjmY5i3y2o+G6iVddCEsfh6?=
 =?us-ascii?Q?vHLU7QMc5DB35100dyeCu672/p7hhe4g9mBuD1eryblZQUSISE/ECokuMbZ9?=
 =?us-ascii?Q?fbBE8qdjQIR4W+H0NhgbiPGxbcEUPhESg2aaajW8ZP7DmapNsD3Vy2bKGR9W?=
 =?us-ascii?Q?f24xG6TRkTf/e8xinTvvf/gkI06c8wDKJs8MXreD+mTpxv99deiopm7g7sqn?=
 =?us-ascii?Q?Ajp7FSpY4f75/Jw7asiOvo2GvhPQ9uubappo81wpEEllOMVshGeTS3j7d2co?=
 =?us-ascii?Q?5+L9hMQ83apDXkr8kVF+Qkf5zQBkiQ3n6Q94TGtQwzlrM1A1FrYvvvMonk6t?=
 =?us-ascii?Q?kAc/Pzd5xgOInVi1GZhN7xfOh1HpbftUUFTFo72XhKGtwZHOsi7fQOl8l5LA?=
 =?us-ascii?Q?T5nGtJAsWkJxd7gt6gZq9hfkJzgn7FOpgdfHMKbFe3gqROa/PerGlz+FlBlE?=
 =?us-ascii?Q?mtJeRudQo3llQB0YMA+6CtPg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63fcf11a-13a6-4f73-fbd5-08d8eb5762a6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2605.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2021 04:19:43.0063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbXOnSzqQ+Ix+3gAlYrLsXELT/nYfjZAmfv+APOsQZriGOf7MtteSlauF0rqhe+aUiY0dN5eJQczAnMIhZDfHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4704
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk.Brol@amd.com,
 Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:

- Populate socclk entries for dcn2.1
- hide VGH asic specific structs
- Add kernel doc to crc_rd_wrk field
- revert max lb lines change
- Log DMCUB trace buffer events
- Fix debugfs link_settings entry
- revert max lb use by default for n10
- Deallocate IRQ handlers on amdgpu_dm_irq_fini
- Fixed Clock Recovery Sequence
- Fix UBSAN: shift-out-of-bounds warning
- [FW Promotion] Release 0.0.57
- Change input parameter for set_drr
- Use pwrseq instance to determine eDP instance

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d163007e057c..55f3c76823d8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@
 /* forward declaration */
 struct aux_payload;
 
-#define DC_VER "3.2.127"
+#define DC_VER "3.2.128"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
