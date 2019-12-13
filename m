Return-Path: <SRS0=wwPX=2D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CE8C341A2
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 20:49:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20927246A0
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 20:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iE9mGhiS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20927246A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EA466EAF5;
	Fri, 13 Dec 2019 16:02:02 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690071.outbound.protection.outlook.com [40.107.69.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 288186EAF5
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2019 16:02:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lpt71XNbfkW2aNqpd1/hdJe6IY3Z4HcJ/fZTGzN00q1+D5351I+l0hvyBRDuimuCTS7DI8sLR/GBgrz5D8Yt7Y8LHQ4XAhrxA0bI5S0Piij9hGihUFqIdTcqDdmtho6p8RFKtq3k5CQkkEuaYIx3aAP24VVKUFFXZrvFEVKTe4vq1Mfv77cMX/Trxq/NOzKDrEMNBaVhBVZTud7WpQGlE9lhqztRnBbYYKHXlHWWjkqkAevjZmpAPzWzt2rHBOaugh0CaonOL1FGldars3RtjO4lAg5Pl4lfzmPEGT4M0wsStP/D4pPbKDvR8MZequYtZZ/7KMfHwIlnk0vwoENZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEWaZYSZB3g0a87gByMax4ivdTZnXikdklTXrna2Agg=;
 b=LR+28TC0TRF4VSHKB9DaQXDJe6BouAKW+qEyOcViGJ9ChdUIAhhvXEndAdqhT3Pc2XBFUW0YvM+qtVzr1fymaSfVYEC8vfismo1NyfJj5iu6O8OSCurrgwvUH7tkUzsZvHuSU896qvCpcEFTBqbU2AwXGeFbb+RO3Y0kM5etWDXqrd1lHTnK74nj/qYzFzms38hbDE2vjhoihnNL7+F6PMaghDKlbQzv6M5yUlPhID02GOmGffsXAMu1slEV9gYJGHRQpk/GrCfRbLuPweuIzcb22zJYkdQXmwn916S4kduCQGDFoINcztItxCRpnUohm4/LNclek4ow+YxooPqKvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEWaZYSZB3g0a87gByMax4ivdTZnXikdklTXrna2Agg=;
 b=iE9mGhiSDEzC2U0s5xZuJYuryuXKUmf8/+WUsAxKpo9mKEtndxXYMlWo7PcPo8XUszB/YUMYOha7Q53VMqZoKyxmGX/9AmHiUHlXBZAzWHcPAk8OrWyu5nVlHnIWEzHhDD1xBFEAzPSlBikk5l0eojgQGVro8EiCVnwCKcIYyw8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
Received: from DM6PR12MB3466.namprd12.prod.outlook.com (20.178.198.225) by
 DM6PR12MB3243.namprd12.prod.outlook.com (20.179.105.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Fri, 13 Dec 2019 16:01:59 +0000
Received: from DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::8954:6ba3:6dca:4616]) by DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::8954:6ba3:6dca:4616%7]) with mapi id 15.20.2516.020; Fri, 13 Dec 2019
 16:01:59 +0000
From: Zhan Liu <zhan.liu@amd.com>
To: amd-gfx@lists.freedesktop.org, hersenxs.wu@amd.com,
 Alexander.Deucher@amd.com, Kevin1.Wang@amd.com, Evan.Quan@amd.com,
 Tianci.Yin@amd.com
Subject: [PATCH v2] drm/amd/powerplay: Copy watermark to SMU
Date: Fri, 13 Dec 2019 11:01:47 -0500
Message-Id: <20191213160147.5396-1-zhan.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::20) To DM6PR12MB3466.namprd12.prod.outlook.com
 (2603:10b6:5:3b::33)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e97cdae2-bcc3-4752-6fa1-08d77fe5c8de
X-MS-TrafficTypeDiagnostic: DM6PR12MB3243:|DM6PR12MB3243:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB324315E99CB0C33F6252DC0A9E540@DM6PR12MB3243.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 0250B840C1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(189003)(199004)(53754006)(52116002)(6506007)(316002)(4326008)(5660300002)(6486002)(86362001)(6636002)(6512007)(44832011)(1076003)(26005)(81156014)(8676002)(36756003)(66556008)(2906002)(2616005)(66476007)(186003)(8936002)(6666004)(81166006)(66946007)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3243;
 H:DM6PR12MB3466.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NW9ockdpG7xl02XJNSOe7q7V1jvu/XzJ8dO0dmf7ZhT3yUP/Mrbf2RY9gEoLYRxfQNTpujGWDxxSNVU4JAH/lyAYI+Q7HfMFQjah1F7ewilmCIHdZf8VGYfTQZ5SrY8DgoiPlTt3UH2Hi0PAXdrW5GoV4g99EyKcZxwzLexeoWIu6lg5yTn0axAAeHKG9G/uAd8kczYXUiDARZLA5eY0Na4WyWHTVClagy+aZLGJiKjSFhPh3t+ijbR2cWc9luFB8CFZ8XtbHe5YPjMTMliu49tt02sZeOv/9zy1CPfQ/IJGyOE+XWz4JN3f9xLEk9NmKgnBgo/G921KIUxWmyNAs19HA51KuFjntkJkKs1LYltcXVVuja3uhJG2CbQT3AcCn70i545usJilCoQclQ4vXmaE17R423za96HNToCU1gT9Xj/VAJzd+6+52H+S/lNqk65nScDDrEcGRqV9W9SkQzwgCZCQKCIfj1NiOqsHjIxr9oTwzfAjUaiIuJLbB5HZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e97cdae2-bcc3-4752-6fa1-08d77fe5c8de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2019 16:01:59.3521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Apx2b8N46krQCgQFcS8It36zCt3JcgIcZ43Ua5FP/yjyKEP9UEZze8bpfporJNv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3243
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
Cc: Zhan Liu <zhan.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Watermark value was expected to copy to SMU
within navi10_display_config_changed(). But
navi10_display_config_changed() is never called.
As a result, the watermark value is never
copied to SMU.

[How]
At end of navi10_set_watermarks_table,
copy watermark to SMU.

Signed-off-by: Zhan Liu <zhan.liu@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 15403b7979d6..ad6775c6839f 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1472,6 +1472,17 @@ static int navi10_set_watermarks_table(struct smu_context *smu,
 				clock_ranges->wm_mcif_clocks_ranges[i].wm_set_id;
 	}
 
+	/* Pass data to smu controller */
+	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
+			!(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
+		ret = smu_write_watermarks_table(smu);
+		if (ret) {
+			pr_err("Failed to update WMTABLE!");
+			return ret;
+		}
+		smu->watermarks_bitmap |= WATERMARKS_LOADED;
+	}
+
 	return 0;
 }
 
-- 
2.17.1

Hi all,

Navi10 has been upstreamed, so I will directly mail v2 patch
to amd-gfx. Please kindly review this patch again.

Thanks,
Zhan
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
