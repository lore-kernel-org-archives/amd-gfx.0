Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B401C282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D64E42082E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uBjh27HB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D64E42082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E58E26EA31;
	Fri, 10 Jan 2020 14:47:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 445896EA3C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:47:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEwHvUIMZLCozkYzGnWCUJzbL7RpBeKpCgfCyFhj/w8cI+MCyCAX1WWteEn6By9Zl0dz416IjVDwul+zyDXuglTfQuW3vBnYpB/aLdq5I3/ToixMb1qwOOuDU13GB9Ky8UuGPOncrHRWasEM6wBZn/Wsp0naZwqPn7H+ZgUHXZa1ceK2NBMM/+zS4CPTqkv8dYjkInUT4Z98DQglOh1xbOO1qnfGXIXqDlKSylv+e6U+ut+bkcMfe0qs/iwsGGoP/nbsSvsvKGovH4SKD4epRvm54IiEGa4YgCdWPy8xqSnFAbLLEj+XwtXCbY7rYOTkqXKioIRz9xdTegogGRuG5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk/C71qdpt97Qs/Bqh0GmVWkQt7aTFED/acVH2sein0=;
 b=MGANU9TL2qvvvou+42KpFSu9bJFKIAo/8o0wUc/n+WmGfokqsSc2bJXW8UOTe8Q3VfdxJRVtMp+yZckV7oReDwJa6R74gFrnLiLp0MxQavIxCtdPa7nwTg3dmARAXyIQYQz56XVyj8kU9Qacn035SfbDtpfqe1Hlx53042nT9Bc0MmgzE577fdwiQglzXOn2QGyNKxnDDEQEEcdA7adxFsxI2pcdKMtf16zpZEsJvfRgddWQl2yQzZK8PCjUvwO2SiEIbxoa8uoGzJd0UvzIxI8cVsVtngrOvIGnwXVHUiqFmmpHQX5iSrBlrj9via9BbCxaqliZCMatT26p8yz5WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk/C71qdpt97Qs/Bqh0GmVWkQt7aTFED/acVH2sein0=;
 b=uBjh27HBV3bfpfAn6Qgh+utUyMzVo5Gz7G3v9AezC1W6wdQ5IXy5yYGIMip9vjYCiV1nLn/F5HqKEaFnnQiTls1crORiZ4taQHpzjLmD4ShXKDb/89FSDsd5BtfPiMsGB6lmlEvb1YaldX3ZhC/eD0n8KX87Qrt8f2Q/l2MPUQo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Fri, 10 Jan 2020 14:47:32 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:47:32 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/43] drm/amd/display: Don't always set pstate true if dummy
 latency = 0
Date: Fri, 10 Jan 2020 09:46:25 -0500
Message-Id: <20200110144655.55845-14-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
References: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:31 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 085ebb89-444c-41cb-a6bf-08d795dc05f2
X-MS-TrafficTypeDiagnostic: MW2PR12MB2524:|MW2PR12MB2524:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25240B27BBAE3199311AAD8198380@MW2PR12MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(189003)(199004)(8936002)(5660300002)(6916009)(54906003)(81156014)(6486002)(81166006)(36756003)(316002)(1076003)(2906002)(6666004)(956004)(7696005)(52116002)(478600001)(186003)(2616005)(86362001)(26005)(16526019)(66556008)(8676002)(66476007)(4326008)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2524;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DKMUBDrACL7UsGeDGxoI5tHnIlX2lLCkQPzbUfkQt2CeT9ZiCHyMvimcfteaBwVgkqm+DeV8ACTDxZ0fWP19vUrf9CjBe6lA6aoJ4sO8f4qrV1/rbV85W7umBIwe73TkTbMF0pHvLAHYUV4UprkY4UjASik05RMr+rYwnCA7yTJAfP4k+MkjgRDu9WX+aAoAcsIDbmZVhf+ZOkpg02Nl/fW/W4mEZ2BPuzhoKhvd7vzyoMuPmnDSKX4ay+OVM8Set0iZW62r/q8lhqCpyoU7gcEwlYgFJiyTNmfo1oIzScqZRtP8PVzhRVYvmSWt1BOAWQJkx9JSieKaYh+lL81xE5At6crA+eQHW5MiydSyY9LBoW0EgJwev9bcYd0NWDHgrzAoILMtZsR3YkAy6yN/13wcyBjhr7Il2fcro05FVZk+x0/tEFQp4u/wNafAR2ge
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 085ebb89-444c-41cb-a6bf-08d795dc05f2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:32.3655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WTkf4MwB9Myx91SeL+4KFeklcR605rs8PP280wj9QzJB3v9u70mYoG74Qa4o7NOoKINPjzuKKEqTV5dN77EMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2524
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Why]
If dummy pstate latency is 0 we should report the actual
pstate support, and not that pstate is always supported.

[How]
Don't always program pstate support true

Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index a05746142ec8..eac4c3cecadf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2918,7 +2918,7 @@ bool dcn20_validate_bandwidth(struct dc *dc, struct dc_state *context,
 
 	if (context->bw_ctx.dml.soc.dummy_pstate_latency_us == 0 ||
 		(voltage_supported && full_pstate_supported)) {
-		context->bw_ctx.bw.dcn.clk.p_state_change_support = true;
+		context->bw_ctx.bw.dcn.clk.p_state_change_support = full_pstate_supported;
 		goto restore_dml_state;
 	}
 
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
