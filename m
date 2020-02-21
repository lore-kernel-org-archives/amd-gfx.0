Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC656C35656
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1AA32067D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="G3Vzv4dh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1AA32067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 467156F4A3;
	Fri, 21 Feb 2020 16:03:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A137E6F4A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:03:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2IiQd1PWnNMSrHgqd2Um19N3kpOLU/hTU4KxbfUvSJXkqf8LnEGTpp5+kXZoqFqghRcW+ae5Tpbph+oGXZTEgFRe791347cJ3w13dHi0tGZjk52ubveN1R1ME48ctv4ttCNd/tauu3ZDPqdtX7m8lH6Y32gdkcD7ZgAWZwRZ6zY8qCm1jE+k1Ei3TFGF4SERyTL6P/MuC0z/yebae+tnNEUscIGTTgEYf4ytk/qwms3Z82gGJ75UBnqPKxyvVm7z4TUkCx81hf5GVo5aR9REZOXZNqUwshigkY3nPbktMQflZTaovHaJyjNf1XkvVrMCtYzM0LE9QEqf7tFeqb7NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlxhLaQgdro+luY2KCljZ36S02jMtLSqMmQlX3/Meqo=;
 b=RuJ28IgwjhmTw4wUelafgfaCB74wldTr2E1MS/qe3o0fL2XdlL8YzjQ3TeFfrfFwx+fccJHlhUjadmX1mXqvgrnV/A5M8QVXVuEYm1D6pDCfSJcTAP1MJlrR8J61BQV0fWkU5JQ3js5dtpfsAKKHbmmbc8ufM6KMt4sSF/DVLz2vtVOx4a3e7QbyNPb+yvUKIcIbIL6Tn3ouijvHhIYgoD7X/RAPBxf1Bkk/r/u//GPGodmAa+2MzC1nxNkhuTzSyBVvbasolidJTALxlS+dvweoMt5bFY3JFCAfr+B1UcCTzaVEDTdWPdXQNugC6E10tL7j+/3TSmwhWsRnos0sCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlxhLaQgdro+luY2KCljZ36S02jMtLSqMmQlX3/Meqo=;
 b=G3Vzv4dhICvzZ2/HXs8WiQ9vEc+FLdhWDpSkuYct225GDCMiR7cmYHB5pgOvmFGxhn9MLyQXVGNPzomzr85cKA9vDp9wnXFN1zJtHU617bVgPOElEyotYRRLjVSl1zW8j+sWYnWSYognXqUM7s1z45Mns05rK14g3kyBApQHXcg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:03:56 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:03:56 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/35] drm/amd/display: Only round InfoFrame refresh rates
Date: Fri, 21 Feb 2020 11:03:01 -0500
Message-Id: <20200221160324.2969975-13-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
References: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 16:03:54 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2377096a-cd71-43d8-fe39-08d7b6e7a6cc
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:|MW2PR12MB2572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2572CEA368F768E9E4D3C68798120@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(1076003)(5660300002)(36756003)(2906002)(8936002)(86362001)(8676002)(6486002)(81156014)(81166006)(7696005)(52116002)(4326008)(6666004)(316002)(186003)(26005)(6916009)(16526019)(54906003)(2616005)(66476007)(66556008)(66946007)(956004)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5bsnoOFnaJwFvwDhWnenufLsnZcROhqsXxCUuDzShVso+F7tD5Qpn+fE1zLcAkKKE4uSxc26dwJLKHGHN4zl40K4DurCdIQZE6MPLWUaEo7aubhMdZk0wDRqEn5Xe6Vp9Cd3od4f0vTZpGn0QPa/5EjK+/J/I/LZ5EJ3MeTv1OibIWNj043buO2q51Km7FFo5sUVCQ3CCZGAxTVqH+jUl7PEMRVhwlwW3qnOOB673NFCUNOwDXs5oF/C6vMoz5nGWPmwQGi32FL39sNVgEOwdvRFg4RKcDbf72XjnJOjur8dq4oEaqGgPuZ2zM4bVdJQx5XXfE2P2k0n2iwziyEHWKmGScZhwdvhji5uJohRX6jxcSdETBZlWMK25ySZ9/YaT65H8dZ1gf3l2WRtab0r6AK9GaCT2GiCiZsTtHGV4WsrW/QAskBlTJECOpo6gglz
X-MS-Exchange-AntiSpam-MessageData: DGg2Ocrl15w0u2TgciWN8OGsFt7QRvnH1hivfxQ6vdzS07LWcvYa7Ktq+ss+/yYdgULJZHg2R6zxN3r5oIG5AVtrOVYHThH+lGB9DfQbP8HAoChVv/zGFLsuoLjhutalZAz9qq9XgOVXN8N4hfNDsQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2377096a-cd71-43d8-fe39-08d7b6e7a6cc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:03:55.0236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kYkxpl9Wt7OXLfuqDYiDDmgDjIrh62kWqJtbLbj661Tc8IdfnrzH3egJp86auuxAgRQrLKT4R+C5HSxw8Ixz/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
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
Cc: Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, Rodrigo.Siqueira@amd.com,
 Bhawanpreet.Lakha@amd.com, Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
When calculating nominal refresh rates, don't round.
Only the VSIF needs to be rounded.

[How]
Revert rounding change for nominal and just round when forming the
FreeSync VSIF.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index b9992ebf77a6..4e542826cd26 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -524,12 +524,12 @@ static void build_vrr_infopacket_data(const struct mod_vrr_params *vrr,
 		infopacket->sb[6] |= 0x04;
 
 	/* PB7 = FreeSync Minimum refresh rate (Hz) */
-	infopacket->sb[7] = (unsigned char)(vrr->min_refresh_in_uhz / 1000000);
+	infopacket->sb[7] = (unsigned char)((vrr->min_refresh_in_uhz + 500000) / 1000000);
 
 	/* PB8 = FreeSync Maximum refresh rate (Hz)
 	 * Note: We should never go above the field rate of the mode timing set.
 	 */
-	infopacket->sb[8] = (unsigned char)(vrr->max_refresh_in_uhz / 1000000);
+	infopacket->sb[8] = (unsigned char)((vrr->max_refresh_in_uhz + 500000) / 1000000);
 
 
 	//FreeSync HDR
@@ -747,10 +747,6 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 	nominal_field_rate_in_uhz =
 			mod_freesync_calc_nominal_field_rate(stream);
 
-	/* Rounded to the nearest Hz */
-	nominal_field_rate_in_uhz = 1000000ULL *
-			div_u64(nominal_field_rate_in_uhz + 500000, 1000000);
-
 	min_refresh_in_uhz = in_config->min_refresh_in_uhz;
 	max_refresh_in_uhz = in_config->max_refresh_in_uhz;
 
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
