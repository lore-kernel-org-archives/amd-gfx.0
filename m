Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91090C55179
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43F0221D24
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EXxLr3Lu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F0221D24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B50B6EC6A;
	Tue, 27 Oct 2020 20:53:09 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700073.outbound.protection.outlook.com [40.107.70.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71E9D6EC63
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 20:53:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F31ahX6xc2ucNbXqTmTdpOzC/kS2EwYEYeOn6ZzAixCR2EJWJyFto6PjANSaXObZDI8XorrIbdI+vvPLrR9MBzKZ8Ab3EyOMGjttaYENTg4k83JBSjLGrp4Jbw/6Ioj64JcJ4fU6WVw2gSpm8XVv6NTh834syLgpo79JBD6wsFnD2vH1X5plpvFPsdIwsyILoto4RyKSQpUe217z57gp/6on+/CBqrGDjH1KeS9uAIagOFTz8C7NhFnr26GUrdnUffEthGjPc7/xQm5xZVTJRXWY9XfOyR83z5x4y2IUwSJDU1P5SfpFQ3b36pkJqxeL/Ybm3xLHlqUF8JzSKIZ+PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YfmhD5OLCcQZAuVowsq8/BFmn9b3aeOsmOPDfP+BzQ=;
 b=ElAs/YILydAtrKQQb7zUvV3y7Eu8NJYs1vXI5qMXAo9cdXpAsg7d/+O21yb/MxQm2RhS3MBghFwf2UE7q9KvjaLmYNE971nr0WMOsrcR8ZXyXNbzWC8C0r5j58DVZFutW4NbmNpLowyZvvH7kQ7xvDGOTXgZe2LEmcHWJCXkfW6W6HcYFKgdZ4PUS6tV5y7vLfamZSHQ9D8zCXtW1t1ITK0lvVuWQwPY5Xw+m0Su6nN3h/tMG2IoAxWTVmwVdst0vKKLwB++2/Bl3GxHfqUuJK6cozpj9zpPWM7KYzHHUwpLU0AvI700laVi2b94/smlvrO/s3XHXqkJCnw1fZXqVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YfmhD5OLCcQZAuVowsq8/BFmn9b3aeOsmOPDfP+BzQ=;
 b=EXxLr3Lu98p3g8hS/EkTLugIQu3XWuHNeIsBoVkEln8Cm12QT8y09Emn5MImUG/L0MmO9leCFuDTtfZJL3l5kSXS6IsjpvXjF2F4uqcJJwcoPeQUlA8jcXUVOzCCnqM9UheE5HJKX22z2S0HelKvTKKl/al+wlmIqdFSuv7mky8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 20:53:06 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7%3]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 20:53:06 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 22/25] drm/amd/display: Add missing pflip irq
Date: Tue, 27 Oct 2020 16:52:31 -0400
Message-Id: <20201027205234.8239-23-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027205234.8239-1-qingqing.zhuo@amd.com>
References: <20201027205234.8239-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::8) To DM5PR12MB1884.namprd12.prod.outlook.com
 (2603:10b6:3:10d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 20:52:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 62657e1f-a118-40c7-3290-08d87aba49e7
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35957C08B25354578C6FC613FB160@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:350;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lwag2MoR2iayPdnEuonSfqz/u7Ep0AEDWAnItW4usoCCvajypZampNtsbWTKGj49AnubjiFvg/erS1T/ZM88JAkggJ/OKnMHrqvT9plNcevYXjDkbGOi8ad5xTa0eg/0DuuwO0v6vxfYkIXBjXDtzWGCJqPkkPtVbQNIbjoGu/lRhCo71OUTbST2NCgzMbTv73pBeQo4uJL/04TDKyzQ7oOTWHWvxKAA7v+w5mAqAVLO35VeiqjtkEQwor0n9tD+BPcHxY82rSEP+S6lQd/OWYn3DgSdgluaPHPsCj6SySJBcvLsO7TTv0ZlH8SnuJop0xudBgdxBSAKnw4Q1kUjKqOPm093VvhrObBMn3qZ8P2INBhsMJRpVzGAb3m6SEbt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(6486002)(6506007)(2906002)(26005)(66556008)(16526019)(186003)(6666004)(2616005)(6916009)(52116002)(956004)(66946007)(316002)(1076003)(69590400008)(44832011)(8676002)(478600001)(66476007)(5660300002)(4326008)(86362001)(36756003)(6512007)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: jHZv3I7b1Pue+wj2IMVdzwEu+nnQNgFYJFxi9fFo0QjD4I+0VpdFMsR268y8BLqkEMfbMkN2iAIsgh3Wf/W6FjJlQ/V7pbXv9xk+9BWOekCX16urybl2J+NqIRiGntx7vBBM1kcjl0zNXoVGrRlMbczpWFjqi09/Jzp9qZ3gHvYho8Sm3MQEfkGI4U+J+OItghyKQ0AEZbGi53ARUBWYeqNGIjEjXY9iSwON5cMInI+6pHHR3vuU2ANTjrfW07ShEJ66eo1fuY7bX/Seq9TfdiDAh3IkmEfeOvgMJMCYn6VWxvIZLZZKVnoSGkEDHMPNRLEWD397IRZzC98m9fT2kbn1xoolf0d8jwr48MqoKYs/W1PZLgm51kedZAw0qX3FjDETxA5DnY1flqWYHtMDDdzxfzIqBIK5XgbU44m+0O9pHtD6vJDNcb5QY8yizwEcdvoU3qMaupctO0Q1fv3YqPdLMqW84fktHBISYvDYfq29DJXVM06+CRBlrAr5GLuOX7ZsHZiX7Mt/xelI5261O4/tTm1+DygWXfk26STsaZPyC5LreOeHNbcverZOMzT80XkxPDYvzPYvejGXMIq+3Rg7JHS5DLs/tDSxrnNhCa9DCsGmVDloSQ+WGvDSQxusEgxvsw7VfhqW1Sd6/3GM7A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62657e1f-a118-40c7-3290-08d87aba49e7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 20:52:59.8488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPq9nF0XTZm8P58bozvRm3WkEe9MJBNbAPuLS6hhLt/TvaKTQi8awwc4R87BpIaU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

If we have more than 4 displays we will run
into dummy irq calls or flip timout issues.

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
index 49689f71f4f1..0effbb2bd74a 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
@@ -306,8 +306,8 @@ irq_source_info_dcn30[DAL_IRQ_SOURCES_NUMBER] = {
 	pflip_int_entry(1),
 	pflip_int_entry(2),
 	pflip_int_entry(3),
-	[DC_IRQ_SOURCE_PFLIP5] = dummy_irq_entry(),
-	[DC_IRQ_SOURCE_PFLIP6] = dummy_irq_entry(),
+	pflip_int_entry(4),
+	pflip_int_entry(5),
 	[DC_IRQ_SOURCE_PFLIP_UNDERLAY0] = dummy_irq_entry(),
 	gpio_pad_int_entry(0),
 	gpio_pad_int_entry(1),
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
