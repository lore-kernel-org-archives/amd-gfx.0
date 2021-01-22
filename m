Return-Path: <SRS0=42b/=GZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB15C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 20:07:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B40623AFC
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 20:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B40623AFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C180C6EA4B;
	Fri, 22 Jan 2021 20:07:10 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680081.outbound.protection.outlook.com [40.107.68.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10FBA6EA4B
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jan 2021 20:07:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3EKdUQJ36M0rA5aF9Pal6GY4IQG28eCF6ubknveHHnrkjs2NrKMW08ur9roqUPL94w8F/xWZJ3reYlJDmWcTG9Z8c2P2uf8v0Hj+GyBM1NdxukTCmAxtbbAUTBNygirs8CiLMjAhjTZcs29jlfgctbjLMTy7kX7E91NF81/kzGozF2k3APVDqVhTzWjCheNbSMuVEiQfSk1FC3/e1a1c2bZmJMFdAK0Wo1uG31hgH7anAhYOrCeKlXUUXbF5CT7/AfLVjtWxBHAddhzFlv0nOjoT+4NudaFyBYyePZ62wqVakm6kc1ARCVmeIyJp5BNVImEkanAPX9cZHUFPjrr+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wx3W3uSsmngHcFH1zPq45pEoYXM/tpzjwj3FH68DQ8A=;
 b=i17XKN9Lk0JFc23IjJ36CRicM6NKRXmxyzOrLZptYCjL8IdMfqlHW+YNNnvFmLSpNgUVJzKkn2l6YJNHxZY8E9I0BZkaWf7c4B0HqNCf/nE/2zNrtUP4VuAh/vDIsvDxO4BKqGdvHiojc3QRHj/Q5Z42uaIhf0j878QyPsruKPMWwKTg7DbybkvyVFAPxypOZsZcZ1Q9tqWK+m4GIwRdc8XwEFMjsgkcDA7DdAz4paHJQXQ0m74RGAu5HwMWi5SWywd5s2LQPkGSWq2KIuDWAY+GRCuk9qseA417mzAFE3cTmOAJx+nUZBGAYL6TMH+s01Q/FyurxSUZES4WjFTePA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wx3W3uSsmngHcFH1zPq45pEoYXM/tpzjwj3FH68DQ8A=;
 b=NwKiM5aZYzf9Dbl8lenikomhKrAu0zVaxKIYOIwT64fXIcVLysZFlxfbuxlMPUnByNIYqXeu/xWBaugUFmZx15Lfu5q5K1y/U+HyBzHvME10Uk0Byxw1EsWpTLO9bstl8BQRuh8n+gfxl07pSmS6/CHcwvJAXOAr3p1l91PRIw8=
Received: from MWHPR1201CA0007.namprd12.prod.outlook.com
 (2603:10b6:301:4a::17) by BY5PR12MB4209.namprd12.prod.outlook.com
 (2603:10b6:a03:20d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Fri, 22 Jan
 2021 20:07:07 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4a:cafe::bd) by MWHPR1201CA0007.outlook.office365.com
 (2603:10b6:301:4a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.14 via Frontend
 Transport; Fri, 22 Jan 2021 20:07:06 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 22 Jan 2021 20:07:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 22 Jan
 2021 14:07:04 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 22 Jan
 2021 14:07:04 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 22 Jan 2021 14:07:03 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/12] drm/amd/display: Set power gated default to true in
 seamless boot pipe
Date: Fri, 22 Jan 2021 15:06:46 -0500
Message-ID: <20210122200652.197934-7-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122200652.197934-1-Anson.Jacob@amd.com>
References: <20210122200652.197934-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 445e6dfa-0ed8-4b01-a1c1-08d8bf114a4b
X-MS-TrafficTypeDiagnostic: BY5PR12MB4209:
X-Microsoft-Antispam-PRVS: <BY5PR12MB42091B024FEBEA7F02444B73EBA09@BY5PR12MB4209.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gcr27ZuAvPeU4IgkePrM73Q20n7/Gt2xRsihoQRMi8hJWKtgeCE5CjKHdOIxts/TIovKXM+TEZybZ9vZuqrvAUMsiYZx27IZhZ9xgt4v3xYiugRUYoNiBPd4vQZmaTWACrTpSSQYb2on6DR9xjDDKZJrT8Nk36dEn5Ey6T48LJ5fTAY08hNQT75vjKaVFSbYe56Z3UG4bEBpPs2I4xAWHsPMeizN4ddJN6rGj+bXJA08pVfD2JBCVEcvASL6nn3jSmseAdc/w3wgvXMnlOv5cWln49kZi6FkQQPfQQBOt3umStnCFxrds5rZijMvof9vCxZiKGEd9akXUX91FQbj364dWngUqceZP/jB9mDJMTjnOMRNGa4fgRDIfBmgAtofWsNj+oEEsX85iodG5bpmJfMdoAd3dd3T7yowvukPE/MmZ3OZJuSxQARqxA2skp4CS6PbkOfF53JybUJmSwyNwB5KoDhQ7oNSWqDp77qJHWMO37oZoh5nb0yuk2Na7HLo
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(46966006)(7696005)(426003)(8936002)(6666004)(2616005)(83380400001)(5660300002)(47076005)(2906002)(316002)(54906003)(6916009)(70206006)(186003)(86362001)(8676002)(1076003)(4326008)(70586007)(36756003)(478600001)(26005)(82740400003)(81166007)(356005)(82310400003)(336012)(36610700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 20:07:05.3056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 445e6dfa-0ed8-4b01-a1c1-08d8bf114a4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4209
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
Cc: Lewis Huang <Lewis.Huang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lewis Huang <Lewis.Huang@amd.com>

[Why]
OS sequence will cause this flag didn't clear.
In seamless boot but without flip case. This flag didn't clear when
reset path mode because the plane_state is null
1. OS call setting with clone/extended
2. Reset path mode to remove edp.

[How]
Set power gated default to true in seamless boot pipe

Signed-off-by: Lewis Huang <Lewis.Huang@amd.com>
Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 7a30d1d9b535..2f315a47b765 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1224,6 +1224,7 @@ void dcn10_init_pipes(struct dc *dc, struct dc_state *context)
 			// signals when OTG blanked. This is to prevent pipe from
 			// requesting data while in PSR.
 			tg->funcs->tg_init(tg);
+			hubp->power_gated = true;
 			continue;
 		}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
