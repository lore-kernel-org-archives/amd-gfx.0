Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B6EC433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 557046138E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557046138E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF5E86ECE0;
	Thu,  1 Apr 2021 16:46:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1B666ECD7
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 16:45:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fD0WB0R84nunlx61/QcxDWgNG0xFL+vnmNHpo8uB/TKz+vvQHnmyJDbPGWiXbDQOLJeI95b9oCDVZgZcD0rUD7Steu22ESktpCetp7/rDj8GYUt4brOnTcvS0d8A17iwrmJ8o7eAGIJbLOi/o21gQnx+blaor8oZiTGsEZZLdR+1rNyM01gIqoeYYzs0LbPG34qvBuD/b2Mu/8+eW9jYBI5Pc99JNzh/0cZHCHacvw9jDIr3nHU8/kOWGzhW3eD+AWPQVLxRUaemuFGjvCAwdmY1uTNSrccCkWIHcD3NmG6bigrtc+dsORZvFofDgUacwsr1U4MGPckvZcU79sOmig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZjmtYOa6cymD7FEpeuTqr1V6QCvph6Sf7/zxaKqX9k=;
 b=lp/2zeXCMCIaQqvc2MS2R5TROfwZemAP4TDPmAcOY7sS1HoVNAkpYrY7uBE+mGPpNt2n0OYV2tvO1+uyYh0tNfcdkIcYrjMt7o9vrhW7x1SJIwO4pyanlgkrjxW2lCO/VUcKDQGyO3C/Ah3bFfM4rKITqpPFHw+2FHCh8HvlGMiYCojMwlSfsKisDFD0O0CNzFg133s3Owy24AkxZemwkfRAODOypfFCBOnn/Wp3xsNu6fN0ErOqn6Msm/vVaW5QzTqQmr+yijtCW4Cfvzdpw3NQ9OyMB5kMUQ1KgLw0dzsh4RPRbr9AjkNyLklbLQZmb5SV2XVu0+DdEJigc+uoNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZjmtYOa6cymD7FEpeuTqr1V6QCvph6Sf7/zxaKqX9k=;
 b=bAhQMx2OnraRpkG/HqgxJPHF3r+p/yKVZMcxyJ26pZmbW6ncxqdbDpTSCSAIM5m6RQdpeLyp2HeXdZlwnQpo4NJ3BZCHBI6DGIL63kcicFTDBSp6h/2hfNGE0M6tX4hFVfR8wJPVGYssI+P2hN/XrUWOmYVDOrOJ4501koXX0d4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM5PR12MB1514.namprd12.prod.outlook.com (2603:10b6:4:f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.33; Thu, 1 Apr 2021 16:45:57 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1%5]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 16:45:57 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/21] drm/amd/display: Add delay in
 dmub_srv_send_gpint_command
Date: Thu,  1 Apr 2021 12:45:09 -0400
Message-Id: <20210401164527.26603-4-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210401164527.26603-1-qingqing.zhuo@amd.com>
References: <20210401164527.26603-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::19) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.32 via Frontend Transport; Thu, 1 Apr 2021 16:45:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ea2f12b-e884-4419-ff5d-08d8f52d9f89
X-MS-TrafficTypeDiagnostic: DM5PR12MB1514:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB15144A24BF6B80119F1EC921FB7B9@DM5PR12MB1514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gv3jbWIOaYvZSJarJmCd4iQKpumqry8Pr08FhFB0Gzu9Eno4+HHx8Wz+SzuwJP7XwbB/TEyq+7WGGMeylA7xVs4LC0oe3+Y0WA69Vh7tErQirFPKW5NgCHvEejYr7I9fcAnKPajTEL2pZ8rVGnOAi9ABF/+2wtjd0TIDRqsBmtxgiCsVdf/TLV+EHFEgOdhC2Dq458lNbGl3GP8ZqHS9TwDUpYd3t1vZBiQRjoEJbZVN86ycvdwU07G04G98ZfLZmoyo//fAYhV+I4UHtAzPZIaJwVd+ZtGkSuREVnB2VRISBHjzqfO+X0RNAdxniz4RG0HFZncl8GfM9xhtKRc3ziKKQKKp2Ap11IVsWOVklTMmxER7w4eD75deguOBX9zNMoSe+CdA2v95EqutmcIRdcgKc5FvSBVrgKe6kbh2vnckTawwsSb939Aul5lumk+NLV1YWpN36yQBoFW6sEbR43FlC4g0azH4qtOOWSH8kpYjueB04JMDlyrjJ3AjGBTx9FAx6Dce2LinoK/BychLV1RAXE0nW7Nr7u++VGPf6a/NVgTqO+CdTu9WqHm4a+qRUM4HovXrLjEEMK65EeWaLs0zbJgXscTcfq3ebBMclbWzcrd1CMNRBEUm+1qkJlWES5eB/P3FSWz6WDExZC0EMGKXXrAtKM31rXZteOg6DBnvHKdbujXJwDKup8/YjwVf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(8936002)(86362001)(69590400012)(478600001)(44832011)(8676002)(1076003)(6512007)(956004)(16526019)(38100700001)(6486002)(6506007)(2906002)(6916009)(52116002)(5660300002)(186003)(66476007)(4326008)(66556008)(26005)(66946007)(6666004)(316002)(36756003)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MPDeHvhl2gq3QsQZqBbCgbUomx7AbMVOcVfVQGldDg+ls+L/Q/FVDpWwAJlL?=
 =?us-ascii?Q?0n9DTy69d8X0Ojla9ltxT8bp9MR6jyrXhdLVtSMDIQ33VQX3fJ0zwb2WK1oL?=
 =?us-ascii?Q?ZyAKncZJbeyiOdCLCS+lyYWfXlYGDOK59dfODXIec11OVaW/ImfrNKntfCZe?=
 =?us-ascii?Q?LA3dWXNk+o3dG00CAG1pH3CI7EycGkglqKqYuHPlk83CRL0nugMSsVtUuFk+?=
 =?us-ascii?Q?CgErO35S72aZ1XnsuohY/u/ZJfhpVA9f2UlKf6tLlGDak4KsMFys40tf3ZCM?=
 =?us-ascii?Q?elp2pZHjz7ayzFEEShmifCwgK4NCEko7Idvv0kPT/ve41QFbHUrIl15vkAWN?=
 =?us-ascii?Q?6CiwS1+obBCyZY3x78VXXdx0zl+AX/YkehteVUYkgxqmtHQiHQvx1EbTzsTW?=
 =?us-ascii?Q?L6khhrj/xDHk8bqO47y5l2iDIlp3KxcN7pyw6hr2ydmCFTyJ8ddvcvzmxzSr?=
 =?us-ascii?Q?wIC3cG0/67XBrHCkU8oBnvAfaZaeyLUPazhXy7YmYt5/YhoxbAngCNFME7HT?=
 =?us-ascii?Q?3UnYDvxchLH9T8vJtkUx7m3hNDb2LNGOF6BX2kPx5IbKazp5O8+l91pW9mRp?=
 =?us-ascii?Q?Ll05Ay5siZQX919KvqqJDChexmUhFdoOY7bCLzmoqJGyMy69ytL0o0OBOGHO?=
 =?us-ascii?Q?fNVPP96b3PBkXGUgSiXBmmIUGuPX/Qmz4gQrVxZ+pfZL4GfIW3D4pmAs2zBb?=
 =?us-ascii?Q?3q5b2nD/JhQuyLdD7iYCWVwQI3K+k025UCk4VQcsjdYMA12XoQrdL9/0rNYW?=
 =?us-ascii?Q?Sf+nMZe1R6wpUEyLyBr0gvc4r8MH8DxUVGhCRA5hHTlruwac3u/eH6W8QWhn?=
 =?us-ascii?Q?l8SzTaLbyJQzJzXl4NyiJWLHrA3UZNvpIfCkK8mwke61+dy+Lvvpw4Pnezqn?=
 =?us-ascii?Q?M60KFBc4NhII7CkYNpOSbIwDHuogzzPSFFBLOKfIpRs0k0tainh+rTrKfhJ9?=
 =?us-ascii?Q?vFj1p29GbtoSkokumtj7qYH8ursvJkErBXnV0+knxfA5IDozdCtcoA0fgX5/?=
 =?us-ascii?Q?YLt0yCUyrma1TGzq0kZanhhXJYU0V+74LDq5aCrBF1wkLO+vGbEVZkQRLI5E?=
 =?us-ascii?Q?AVrcVNaibQ6h1gj4BOWG2HEwhMQStonE4cM72m/jTFDCTuQHIOx1T1Wea9az?=
 =?us-ascii?Q?kd+DJxp7waiUFcdTOgipHkcGZqn9eTfVLRI3wI+OsIbqNlDcg07DaPOdS4wR?=
 =?us-ascii?Q?6Q/f0o3GQVis+aUtBt6sGEXLi9e4SOU4IslRyLCkFL2ug0Tj4j5fiQd5J2Qp?=
 =?us-ascii?Q?VioEGsgN65GmGXxnFW6y4NMfBGVm1a/gPBNP/3Q4LHBEp1+/DUiEnN6yEp+y?=
 =?us-ascii?Q?3BbopRU6eOp8UZyYoHZgKbyO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea2f12b-e884-4419-ff5d-08d8f52d9f89
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 16:45:57.3498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+dEvy7YP3hwnmOUg180tajdEvggy1sEcoEctBTjVk2DqGJAeISQoLXVIy27xiWY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1514
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Wyatt Wood <wyatt.wood@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
Today a parameter is passed to dmub_srv_send_gpint_command
which specifies the max amount of time to wait for the command
to be acked.
This parameter instead specifies the number of times to check if
the command was acked.
We wish to add a lower bound to the timeout, which can be
accomplished by using a delay or a timestamp.
It has been decided to use udelay instead of a timestamp simply
because we don't want to expose a high precision counter if it
doesn't yield large benefits.

[How]
Add udelay(1) between each for loop iteration.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index e36e89157703..1cbb125b4063 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -647,6 +647,8 @@ dmub_srv_send_gpint_command(struct dmub_srv *dmub,
 	dmub->hw_funcs.set_gpint(dmub, reg);
 
 	for (i = 0; i < timeout_us; ++i) {
+		udelay(1);
+
 		if (dmub->hw_funcs.is_gpint_acked(dmub, reg))
 			return DMUB_STATUS_OK;
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
