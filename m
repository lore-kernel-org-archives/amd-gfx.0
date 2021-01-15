Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFF8C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:30:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75C85206D4
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 17:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C85206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F28E894C1;
	Fri, 15 Jan 2021 17:30:57 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34E46894C1
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 17:30:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlBeh6w6qH9N6XWkEbbktvj/aNv+OFTAb4lYE0LCEz80qm5HbtHJfNeSgXFs9Q++1Le1OJ65JxhnoqcXQMZoBzvwBGBKAFBFkUrp2xRBH69x7UI0xoT3O+BlEypf4+I6XovrxVhqdnLkz+W78FAXIs7XcqWU5TIISnzouhsblACEdgmut9TKvnVxjvJbtiD++lj6+vLo+npRNbxAVWtndGYgFqYkaS85AsV4yCCw/mZToF0A47WOcwEoKT8NJek5noMeoizKrQZx8bS7dBVnFqP+TH46EGw+2ZMKNFzDMgsg+niF1EHnoxdhKdYX7dzEo5zE04rtJpNzo6ItrzDUbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEfIxy3lzdkVRCRnGTAIeHdNBbNb24muCdzAoGN6TVQ=;
 b=XeEGrBJHxL3cSVDjHuyRIA/RgPjk11ACKinkpXTx5j2VwS08KCuQqmwqN9LSUqz3pRT2NFxF55NtcIICZBNb5B7n2vA+Uw9PIRwFHdXYyoHXuOEjTzWkDtCo4cd6ICd9bCIrldKJ+yQPyAoqQPokc3+BZAZepdirKBdKP9a4m9wLs0afcYUG9AKHV+U/L0p70jUnEIqSiMLrDmabbjLSj7ziv2zecjYiIzP7gbi7/9r/XYljHYDC2hAim1OjQcTwY8MCLrC2R8cKtfmscsMqx5Oan5texU4dncyS0XMsGzn6yKv4A9lGpZCL4fPBm96Ldk0wfa9hsekJecG6lWfyBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEfIxy3lzdkVRCRnGTAIeHdNBbNb24muCdzAoGN6TVQ=;
 b=M+iqtk1cHzKPlaOaJBIs79wQkaDgvmk69NjepmPQnakWXw65Os77rRuONLmLiyhqoSdJzDizI9OgcwvaHbOysBDGjZ83MzJKIlunwiNegnrWRlGf1EOq4BzMadv/M84Z+oinUd5RqM78scZ2o53CTlRORzCe/POJA2ilLTW/g18=
Received: from DM6PR02CA0076.namprd02.prod.outlook.com (2603:10b6:5:1f4::17)
 by MWHPR12MB1167.namprd12.prod.outlook.com (2603:10b6:300:8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Fri, 15 Jan
 2021 17:30:54 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::e5) by DM6PR02CA0076.outlook.office365.com
 (2603:10b6:5:1f4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend
 Transport; Fri, 15 Jan 2021 17:30:53 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3763.12 via Frontend Transport; Fri, 15 Jan 2021 17:30:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 15 Jan
 2021 11:30:49 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 15 Jan
 2021 11:30:49 -0600
Received: from ajacob-ThinkPad-X250.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 15 Jan 2021 11:30:43 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/16] drm/amd/display: Report Freesync to vrr_range debugfs
 entry in DRM
Date: Fri, 15 Jan 2021 12:27:07 -0500
Message-ID: <20210115172714.126866-6-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115172714.126866-1-Anson.Jacob@amd.com>
References: <20210115172714.126866-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa4a26cd-ccac-4445-7502-08d8b97b4f0f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1167:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1167FC6EB3BB504A4FE3E99DEBA70@MWHPR12MB1167.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1SOYN33wqDGRMtw+Mn8EQ6Oq/xaS+UCvKRDa9h6xQJrwObEK/ZX7wwGb2XtlPzfJbmvEcHFlfCDAspJ5vBSAk7aRPFsrqERWfc/h2X++eqIPrUu1spUwei/x+oUlXNAKXfcpwa1RppQbztfen3S0NJVkcknwbs95dnGM8Zi5CR2fZMSK82RGx1xVIG+UHhZbl58OpQG/s6kDUTZyIx6J0iEQUVXcHx6YezSRyhAFyNW8TseElQUKMm44nkL6w/TTgCIvD5iOP8yyjkzXGP/50kFlykhUZU6Oo50rGEHYcnLK9WOaDC/gbKOm7twJlsl0eSAThvFsaqV2vCiJxvrUJFg6CNBmH/Xp1PtNzP9UMxq8ZuB6uI5UbRryUZssTOUwR7xH8Iq8VLzlZ/7Vw2FN8XmHafsr1rFfyYMkhGxcSpc2ta+xS08M9JhDsui3yoXrHIExWbkcFekWcym0D20U6fzTyLhix9R2yVvktpn++tZ9Q/lV3Odh80KlDfF1LEgh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(46966006)(478600001)(356005)(82310400003)(1076003)(2906002)(83380400001)(47076005)(34020700004)(70206006)(7696005)(81166007)(4326008)(6916009)(70586007)(82740400003)(6666004)(336012)(186003)(36756003)(5660300002)(26005)(54906003)(426003)(316002)(86362001)(8676002)(8936002)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 17:30:53.0454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4a26cd-ccac-4445-7502-08d8b97b4f0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1167
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson Jacob <anson.jacob@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stylon Wang <stylon.wang@amd.com>

[Why]
Since Linux 5.9.0, DRM has provided vrr_range debugfs for
all connectors. Reporting Freesync capability to vrr_range
debugfs entry registered in Linux DM no longer works.

[How]
Report min/max vertical frequency to vrr_range debugfs entrry
created by DRM connectors. Remove vrr_range debugfs entry from
Linux DM.

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Anson Jacob <anson.jacob@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index de71b6c21590..b75b5d8acc13 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9890,6 +9890,10 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 			amdgpu_dm_connector->max_vfreq = range->max_vfreq;
 			amdgpu_dm_connector->pixel_clock_mhz =
 				range->pixel_clock_mhz * 10;
+
+			connector->display_info.monitor_range.min_vfreq = range->min_vfreq;
+			connector->display_info.monitor_range.max_vfreq = range->max_vfreq;
+
 			break;
 		}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
