Return-Path: <SRS0=05a7=CQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BE7C43461
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2020 09:02:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F9EB2145D
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2020 09:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qlYYu9Ni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F9EB2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C71D46E40A;
	Mon,  7 Sep 2020 09:02:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F5DA6E409
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2020 09:02:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5u9zkf6AhuosWABXo+9mBkcF8qmd5+tHOycj6HEMZRrsANjOfj8kM5LqGPmW9EMveX1yX2zT5zr3FUGQks/ztLhenLbWue3t9I3d0ZlRIF2CJ4f51kdkWkOJ677OlzfzrTiqL4M0bSwgTcqUbUh6ygMAZF7rpCwcP3hgBoeQfyOm8godqBwOPi6t3eUQ19IE0AKOyLt7QmW9+jJfgh8BsMgTa5MkkYEgjI2aNh8ZuiWUmxEVqv6ZrNt2KO6wkHciWQyvMP8+sM10VmYt+PvPz21JxxSQmD/MEuEDmnkEhX/ePBzfVhLsmubRcdsB64QHZGvOURkU8oqqfl0dOI1eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4DjiV4AZsCd2+jpQkkWV1f4+LdD6pX8TDw+JUN9SM4=;
 b=W848J641eMDKY0kYUEGUIeuEPfZmnjy8V2Hpx0A0H5snTJH5k/kI7EYc6xLMdN8kT+e1XlB/YSnYRKWjStUluZQ0m/gTKmVQ2sZw2pEWek3j3XfCY2KpysRyEOqxl5NkKRbAR34Kf/zpq4UhjU3OBy46QUcU+ZclQt8xY7oNed47gBG2Rvu5f6bgylojSpu6wk1jgTJGdCW2p4toUpwJ1YG+7gGNAF7tR/moFGS0nU5+wO1BskgQDFiGR4kd8cgA1GOF9c+vThnWIlZlds/ZreqPvJgR0tl8LOuYVqoDIngFQnXVIv8muJLY4/iA1ivmPSYenfTW+duoVL4jSNPoHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4DjiV4AZsCd2+jpQkkWV1f4+LdD6pX8TDw+JUN9SM4=;
 b=qlYYu9NimhfCLGBd3AJvVN1nXuCrwACK+2hxJVUBnumYqVkoSs2O2lNFwxTFhm2q1JsimuA26nqP27dHEvFQcVLChKmJ2BFIirdow0HWMEmjAhL/574UR8AqyiTuc9DRYbvqnvG8LXdrMOuc7lGbAdNRj5zWJzJ3a4Y/w3rHmT0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0026.namprd12.prod.outlook.com (2603:10b6:4:52::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15; Mon, 7 Sep 2020 09:02:04 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 09:02:04 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amd/pm: add Renoir watermak WmType setting
Date: Mon,  7 Sep 2020 17:01:25 +0800
Message-Id: <20200907090126.2542-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200907090126.2542-1-evan.quan@amd.com>
References: <20200907090126.2542-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0155.apcprd02.prod.outlook.com
 (2603:1096:201:1f::15) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0155.apcprd02.prod.outlook.com (2603:1096:201:1f::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Mon, 7 Sep 2020 09:02:01 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7b3b0d2d-603f-4edd-522f-08d8530cb03b
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0026:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0026BEC2C5CD9435A063B11AE4280@DM5PR1201MB0026.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DGpt1aHpoG+iGdLXxFoR9qngZgCfMiObzP1ZSbfJG7aNhbuMq1UIOrEdLl8VMtOcQrAcWus6EIUvCuHA1oYFm+YHo+Q54vThnKwYhM4LwL4fccjYs1dpH5kJM621T107VET2bs5avm4xmthgPzQJiV8c53rKBfjMz/QctftiS8NotUXB/Ooogo4NLDsNI9AbKuqHL7hMKAtnjHCVPev6MfbQt4U768TPD0DSCTOhSKBshiHoqvdnCBl4TGzTJcwISqCzRm7+Fq8H5TIXNnK0k5BgdnNCDMJUsIH6XhLNF7cRilNact079TbEn40iX8y2tVeiFI4ctkNHwvl9bsgO0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(6029001)(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(6666004)(186003)(16526019)(6486002)(26005)(2906002)(6916009)(7696005)(4326008)(36756003)(66476007)(66556008)(8676002)(316002)(66946007)(8936002)(52116002)(54906003)(83380400001)(2616005)(1076003)(956004)(5660300002)(86362001)(478600001)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: pI4QlQLASTN8M+i5+u/9c1OdTiSBCP94/kgEU5zWKYKri0ABFeFNHSqS7jYsG6v91wKCRD8VV+TI3dzSMwgtEyAi210s164m6FCrn4EbwSYAXbJmCUANG+TG9Y9InBPv72GRQeNWteFal5kqjnYPMvgfKOKpJCzCXVGyRdFS5LBJr0ud/bULunozjLQIMhMTewRR97SJb1AKQE1AuodHBvczibuOpfJWXg5tSnhESIYuYZYsw7+47qhbExKtVHHeDdgo+af7gihR61n0MEnThIz85O/tTql5JdFA9KUcxVHeS58xpLDHlSDgDgx0CuEZ2zbXDOT9DZd4+d92nTMM/t4URolIQfu2n12wWIwI8ZFG7YH+YrOSuEkIkymHdoKa4pGWdakwCxD9OEUsbKdNfJAOkgLE57XvzVqJy+nuLIffnBDPfje1JLgg2UUPMHIa/czI2kj7BF+Idn/JTbMz/ur2vYXcyYbrEJnSALfztBK1adr0qMhp19JeciHUdiKOyTTJGHDgULCFV9wiiFOpnal6fXb56T6qg+hAWZ+sAUkuBSkM0yvJSB2RkambB+K4R7sKsuVz4OUwYTRZXQkE8e0xKvsEQ5rimJ/9ygH5gMoJWWLlfelE40MT3NIInjwUB6sRiM1WHR94NOrtfPwR9Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3b0d2d-603f-4edd-522f-08d8530cb03b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2020 09:02:03.9922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1jquNSVkzQ4ScGAKtK+vZnfHonMG4u3guJLqSphPBmYTL0i7knaKJKFy3klznRy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0026
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
Cc: alexander.deucher@amd.com, ray.huang@amd.com, Evan Quan <evan.quan@amd.com>,
 Changfeng Zhu <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Which tells it's a nomral pstate change or memory retraining.

Change-Id: I8619115486021537b52c067c4d0b9bfc1417fc35
Signed-off-by: Evan Quan <evan.quan@amd.com>
Tested-by: Changfeng Zhu <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 53d8beffc74e..63c72e33222e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -887,6 +887,8 @@ static int renoir_set_watermarks_table(
 
 			table->WatermarkRow[WM_DCFCLK][i].WmSetting =
 				clock_ranges->reader_wm_sets[i].wm_inst;
+			table->WatermarkRow[WM_DCFCLK][i].WmType =
+				clock_ranges->reader_wm_sets[i].wm_type;
 		}
 
 		for (i = 0; i < clock_ranges->num_writer_wm_sets; i++) {
@@ -901,6 +903,8 @@ static int renoir_set_watermarks_table(
 
 			table->WatermarkRow[WM_SOCCLK][i].WmSetting =
 				clock_ranges->writer_wm_sets[i].wm_inst;
+			table->WatermarkRow[WM_SOCCLK][i].WmType =
+				clock_ranges->writer_wm_sets[i].wm_type;
 		}
 
 		smu->watermarks_bitmap |= WATERMARKS_EXIST;
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
