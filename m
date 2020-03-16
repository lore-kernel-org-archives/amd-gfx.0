Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283CCC18E5B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1D102051A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QpX2iFrW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D102051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A68A56E478;
	Mon, 16 Mar 2020 13:50:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 815176E462
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 13:50:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4EbK7PGW0K3plQWmM8uP9Ge+XRcVeA6/uy6E8KF7/ZXvxJXezYyFOFydcihtI2r0t+5gDSHm0p1S4Wzfy+5oLeaB2jPREklO3gEaIaiQPLYIA2Mqzhr8mRsqtH08/ZiRj8B8sNKD1X2BF/VYNlvr2/tFmT+xwAm9HR1kkBlT/sAPl3sS0TVdHzVFCjNzdxO0C+fjIHHlQzsQAzNR0IcFiMoUSjxgLYmZwnwz3nQTgAkDe1+sAWhd6y5cypBdskkJzy02f20S9rMd2zYBfrGTFUSAPuiGN5kR3wD41zB9ntyIEL710INcrWoZw3BeTTwbO2U/TaLnCVXSj2MaJL2RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uov8jeQcNxbpTH6GfWLh68i1QtwslCxUooeM2hEQBAY=;
 b=DyFOho6OYbik+F8Cqb2TQb9UWm/02z2PJ6O5qWmPneMemy6LyFwxj+/GNW4wMoEBpuATmIIxY2EpxUWCh/V1Y4FMA0fJ/XbiR99uMeb0kw/2JahBFK5EikiFEbdB30Lhhqqb+L4UhLnTV4mAEiYbnjiiO93wl6USPhTo++ti0X/Js4LapRIIFoGTAui7ddxi7L6HoJsF961tXjdnhuj225zkqmTJoC56bWzDohTW7+tjg6814gisMuOBN95tT7TgPoOeH+kxazdtXq8SVL82273s45jVGmYrikXZrt89AV+wEu0mrbXUJj5i4WojevfHLxgG4jNuGhInXfg1Gd43hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uov8jeQcNxbpTH6GfWLh68i1QtwslCxUooeM2hEQBAY=;
 b=QpX2iFrW9KoRVcOM6iNdB+Ty/5kCFv0SQt15viOhcCWplsXUt2SB2J7EIYWc+6A2qxn/okbInToNN72G2wieu4pK3AXt1aRs5mT4l14qgjfj9vasJ3lnLjnuoZ0qCMk+wyFvVv5YzSgSCQw2jJYDD8dmw+Q+WvvtZo+IQH6alak=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2396.namprd12.prod.outlook.com (2603:10b6:907:9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Mon, 16 Mar
 2020 13:50:06 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 13:50:06 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/19] drm/amd/display: Program self refresh control register
 on boot
Date: Mon, 16 Mar 2020 09:49:13 -0400
Message-Id: <20200316134920.2526155-13-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
References: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Mon, 16 Mar 2020 13:50:04 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 220ac846-7213-4ccb-8c52-08d7c9b0ee96
X-MS-TrafficTypeDiagnostic: MW2PR12MB2396:|MW2PR12MB2396:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2396D42805E72FF2F2C4948998F90@MW2PR12MB2396.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(199004)(7696005)(6916009)(5660300002)(54906003)(26005)(36756003)(52116002)(1076003)(86362001)(66556008)(66946007)(66476007)(8936002)(6666004)(81166006)(81156014)(316002)(478600001)(2616005)(16526019)(2906002)(956004)(4326008)(8676002)(186003)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2396;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aOs47t/qgkh5Jdwy66dme86yqDy59Z610baiZtGJwSI+m/JopaltY/Jxt7Je+2reV4getzlCts6lhUQUOWlr/daCbuw2vbZoQywi4XyO4IfoDAEgskhwYl4mrI+s/UnvRajudau0JdZ6uV8I+nN26euiixiXjA7vZ19UE1IDMBjQopMJeMq+hklVom+M9IkBIgKsG1Z0666WAKLGhVzQHIphLxmJk0o8u/j0nOJdir+xkIKFisFAFzYFXrS+L8JjDyGmX+mzsu9sWIWUqc83CyqJIDQneh6WXFH8o9LNzOEJXwhBxPPghi8pKmzCIKGnBbHn1OaFltRLzFBYsChw1LQouU81yQHvUxrnI2L+rLGi+XDHAjtXTCeVVetTynJC7K0fv8SpdDddEQ+ADuVrNMpwHtIncy5UNQeU1cw6i8W7MQO08ySyX2wnsJC9N/N9
X-MS-Exchange-AntiSpam-MessageData: MTyF19faCAUmzCP/8IJkgqu8b0zdCn9nA/tZ/8ET7CmlErIo/xwEQjyv9BJW6V0m14tkq5awdi/f9wT06PKn0rcW/5XvqgQNZrcbIOJ3+liZACIef4n+YSLAenKSOOp+FmWKF9ZEgvgyqEC5ysFC4Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 220ac846-7213-4ccb-8c52-08d7c9b0ee96
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 13:50:05.6182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61i/yZdM4DL8eJIw/Rv2dNkuj2QUyzzRPgpz9kLGY11+Hd7RZhEf2vgXFTrCsM5pVrU93OybdK2SBhW3BnSjEg==
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
Cc: Sung Lee <sung.lee@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[WHY]
In headless boot cases, self refresh control registers are not
programmed on boot. In certain hybrid graphics cases this may cause
cstate entering to get blocked causing a hang.

[HOW]
Program self refresh control register on boot.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 21c7c1b010ec..dad732bb34d5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1356,6 +1356,9 @@ void dcn10_init_hw(struct dc *dc)
 	 */
 	if (dcb->funcs->is_accelerated_mode(dcb) || dc->config.power_down_display_on_boot) {
 		hws->funcs.init_pipes(dc, dc->current_state);
+		if (dc->res_pool->hubbub->funcs->allow_self_refresh_control)
+			dc->res_pool->hubbub->funcs->allow_self_refresh_control(dc->res_pool->hubbub,
+					!dc->res_pool->hubbub->ctx->dc->debug.disable_stutter);
 	}
 
 	for (i = 0; i < res_pool->audio_count; i++) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
