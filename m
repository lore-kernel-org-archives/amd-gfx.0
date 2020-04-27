Return-Path: <SRS0=xwvD=6L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D30C54FCB
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 16:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B732078E
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 16:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zB/DE/qh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B732078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DFAE6E33D;
	Mon, 27 Apr 2020 16:47:48 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E37FF6E33F
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2020 16:47:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfsiLLGYRTE722TalJd/K2KDOGBep+sDrEeeFhp2qIg7H76QavEiARlqak0gN29njNOFfu3qgQtK43UwmOLIQgNzk0MMY2cGb9jCmjykurKn4Dj0Mk01XHx6O16bM+0XH/oL5mSGzO85zENd7d271KyXer7SaaslrY5alEZhjYtuRopvNbSdJa25f8Ppk5ZoBbUSZhlc+Swjomb/9bSO8xekU1FQl8y3LApwT3/2VmQ3w9XAdM4+mHOaHj1R8UCuyDPdgFR1tlpuc6OX8YQTro0We/bV0Ll2TPZLT7bys8AGxAK/cu/RMRC40YaDtplCO3bV3hppQ2HhcJcPPVxLvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znEwycMYS13Rcm3xT/ZjGCLs3p3rIdIx1X/NEMiE2XM=;
 b=OGEKXvNapMKk5mIdf1wCc8+UvF7c5rqcyOLMFLsOvjbObc+5K1lKzZmOT2mGbi7THWJLT6QRosCINIzB5SnFM2CRJeHAFrkj1TT0TCMzJaQcDEug7xUD1GIgfMdnJA6QMwbqvYYDylhcNnfej1LWxtuxvY/QYRn/3WO8ihLKpf8Lst+lapKLnCbyRHLgfiyOqexlsWdaZ9MmiK4T20xIZeM0OiqmdOJ8Tf0/skhK0d8iHDNYNBy9+sCGHN3jawYNOcamT3fB0ISHY6tphvIB9J4B3rPpLTEDCBgWF6Linfuz5zFtOtUSawp60tvbGjQA0f84vvbjyT0gNkfQAhChBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znEwycMYS13Rcm3xT/ZjGCLs3p3rIdIx1X/NEMiE2XM=;
 b=zB/DE/qhxYLxi/apHd3P0GtpA1h4hYppfLV02Rw8i7n18/GPhj5S7BYEWqQjN6ZvXeluX/0a5BlY9Fy2sox1iHpY9yEOQFVS7hxvsxeXcnl9kf/EtAnn+dsssuQPQGR+n7a2NLq4Qj0/7cg4zHnTeb4PA7g4A5mWGfQSFrdPHso=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB3913.namprd12.prod.outlook.com (2603:10b6:5:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 16:47:45 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5%2]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 16:47:45 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: Add ReadSerial defines for Arcturus
Date: Mon, 27 Apr 2020 12:47:34 -0400
Message-Id: <20200427164735.27409-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::39)
 To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YT1PR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 16:47:45 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8554a54a-9c66-4983-1959-08d7eacab61d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3913:|DM6PR12MB3913:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB39135CCB4BDEBB9116217E5285AF0@DM6PR12MB3913.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(956004)(2616005)(44832011)(6666004)(4326008)(6916009)(66946007)(66476007)(66556008)(1076003)(86362001)(316002)(19627235002)(186003)(478600001)(16526019)(8676002)(36756003)(5660300002)(26005)(8936002)(81156014)(6486002)(2906002)(7696005)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fe9+8wB6MaVhupJ1irUAWpNNF1ykroY1FzToKimTsubLHzQJg5+bcmw4rZ/4lcpC3Ye+eLPcS/jyG0xbVz+qHbKsJ7zYNV/Qik55Fw/zY66elCngNImqQPn9j6e09N0S02tX5/SdDTDzjVbFDijDM6QBp7ZuUnaTb9qygGnRUA8Z4OUfXl+LxciLWnWK2YEEy4sJhA46vQ3HWGQFhlTKvJ3nveGG+CjoTgRWfp85Sk2lKq+Cn9nalnnttZcprpT9DmUJbY14lRP6gqf7Ik2GFWBst0HiRQ5lcNY3+Lsk3QIzofln0kJc0kKg5kM0lOygiXlgm9TBvq9Nh1RiVLgyLt2vLIJG+NWNmIB4l9O2r7NczvJGOWtw4xEfBcEwedGYWvN9d5XlmgP0d4ifWHRaqqf6yeSyAbVj1mAVykBbHZ8F74zn0CSvkEuEi/7Ud/Px
X-MS-Exchange-AntiSpam-MessageData: K7b6G+KIegcwC2gKlccKskWf1Bff2jlX4tLm/1hm3LIq9FaHbj/YUVIcRQrNEP14x5gYRBVM9M7yCS8m57I8VE89zpnQu5dsnRAeRkqbV5/t1VLJo4vwewFW5QjF3iZnmhd+GRagseYVAxo6VpNTkU9+XWMvdd3+Cs8O4v0mhFyyOGNTtFIQpkNfQ1zKUScafv0zIVytPMLNdXu6t8A8ckvC6FHB8hEACnWe8e3gcF7dnurYr9AL02PFfkzmJIaRAgkbQF3GwimGqcaKmts8BYx3oVjv8VaLvSlLN4RiiCPN2DR01Cac1DmUnX72R2bX/sokQ36mz/OjRvO988OG5WkppOg0CXTYHgFt95hIQQeJAtFajLf8Z0iSRRl3AYjaua2yIclWWfxQmvXxh124PljbeG3ZhMpi3WGqOGRDnCW67J/qICjj7EenKKuj7QJu8+fqBWd2YEUV3HhHRFuljEv4qq7GWnl9sR8AKqwlC15O3KN/t8Fyx4pAFUcrUXWfloTXjOB1exzU37s3L2DkMezmlx1LXQF7rgVS16w12WeU4Shue4s3qW9Lt6Sif+Y43HtY+1KsbRl0LFgmccSPX7yku2Dqq6qcEn4OPN8mSXD9RKla6CbgIVKm3n0pUE5JZl2dRAwUXSTn7xn7m+NMJTdzomAdysa6L+VHCxCpOUOOVxK+FkmpxhTf6JIL4cRsPXNNzYrPOj4ND3EmOFiMB/0B+9qywLNEzumk0Q+PT68zya9zcRG0r8v8n6tfxh78L0BkCWCGtMNQkzBR2/xyRpxT6c3T3ZfzEMfpWCqZAgE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8554a54a-9c66-4983-1959-08d7eacab61d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 16:47:45.7597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E7JlCTvxQ6rOg+OZzaBwWZTFgkr4FoJ6iUTXCnmjnLMAm48gEpjBYuUQS11ZvFn7xfogPDIGU9FoGEwMW9jxng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3913
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
Cc: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add the ReadSerial definitions for Arcturus to the arcturus_ppsmc.h
header for use with unique_id

Signed-off-by: Kent Russell <kent.russell@amd.com>
Change-Id: I71849ec381730b1803e54cd6040aa3b245b53de8
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       | 2 ++
 drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 1c66b7d7139c..e98d92ec1eac 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -128,6 +128,8 @@ static struct smu_11_0_cmn2aisc_mapping arcturus_message_map[SMU_MSG_MAX_COUNT]
 	MSG_MAP(SetXgmiMode,			     PPSMC_MSG_SetXgmiMode),
 	MSG_MAP(SetMemoryChannelEnable,		     PPSMC_MSG_SetMemoryChannelEnable),
 	MSG_MAP(DFCstateControl,		     PPSMC_MSG_DFCstateControl),
+	MSG_MAP(ReadSerialNumTop32,		     PPSMC_MSG_ReadSerialNumTop32),
+	MSG_MAP(ReadSerialNumBottom32,		     PPSMC_MSG_ReadSerialNumBottom32),
 };
 
 static struct smu_11_0_cmn2aisc_mapping arcturus_clk_map[SMU_CLK_COUNT] = {
diff --git a/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h b/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h
index f736d773f9d6..b426be7c76c6 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/arcturus_ppsmc.h
@@ -116,6 +116,9 @@
 #define PPSMC_MSG_DFCstateControl		 0x3B
 #define PPSMC_Message_Count			 0x3C
 
+#define PPSMC_MSG_ReadSerialNumTop32		 0x49
+#define PPSMC_MSG_ReadSerialNumBottom32		 0x4A
+
 typedef uint32_t PPSMC_Result;
 typedef uint32_t PPSMC_Msg;
 #pragma pack(pop)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
