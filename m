Return-Path: <SRS0=LS4N=HH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839CCC433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 22:03:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B2A64EEC
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 22:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B2A64EEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D64B66F4FE;
	Fri,  5 Feb 2021 22:03:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CB366F4FE
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Feb 2021 22:03:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2eEt/+9tyyMDVO703ILbKmmwSHGxtUBwtZkLqkZ3nrnObbnpUWTQ+bUZinLim0lUW3GdsL1OxNUEw7UAzkJY+F2HhT7/OBpDP2wK7c8Dw9QdwE9/fZKjJVznNpYmrT43nh0sD36neHZpJEUjJgvVt9LvCOT7IjnF25kzUP4ZLvvzRh2HR6JWsRb3b19CoeijGxy4JVYyGBYBPEuaeivDmHE7XsmAqytQqaV6ZujNLnfDz7nRfrAznFZVTHfDLFwRKtXrKwowWEWohFGxz9nWcup2tVAf3TfRWYJfu24FAaug23TDQzMwGjAIHDDLO4t0hvtFy2VtdzfxVqyRfFXEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RK7zn6KCH+2lgq+WdeZkFwMSMRs2irIamrINw1eNMNE=;
 b=mfqcF7JxUo1XfumHgeJVPKY0GA1K7KWt3TxHNc0gvQue6fbVxlvOk2Q9IPBrmEcIWvmqjxGB8VAJIMo+4kxZPCzxKbtnHJSiYGr6OhNA5us6DPq+mbh/jYbeNM711Cp/Ly5ArJgDRW0nRK5Ac13+MmzzHvl3uvbirJASkdg5f2wfiV/acMRlAi36KwMtc0pIartrLEHAc7vzsKehMDsrN/gpdOtnBFTJZ2UBeVWb50mOip6otsXkqqK7V10bfICQ2OkKOt4WO4j3F7FUSEOUektZPPqIQY699eCpIVBemV1Z//FfbpOqnRCpKz/szgDYn7SX6M9i53hCpR6zXduqHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RK7zn6KCH+2lgq+WdeZkFwMSMRs2irIamrINw1eNMNE=;
 b=zftULIfyxtzW2sVAl/1TzF6ZTfTWKChWWgWehnAXHEhAs0iXT3xHi7Nl848LTrkWYkXlaJ5O7tq3yMS4PCLA7kXz1L2lGl4psvTdCxfMOFnHOpxyYDYFZRzU6pQCCB7O4MsgXO+zJHkr5g+0VebFbPWOGz7mlphUZPQUFunLmw4=
Received: from MWHPR2001CA0011.namprd20.prod.outlook.com
 (2603:10b6:301:15::21) by MWHPR1201MB0079.namprd12.prod.outlook.com
 (2603:10b6:301:52::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Fri, 5 Feb
 2021 22:03:07 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::21) by MWHPR2001CA0011.outlook.office365.com
 (2603:10b6:301:15::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend
 Transport; Fri, 5 Feb 2021 22:03:07 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 5 Feb 2021 22:03:05 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 5 Feb 2021
 16:03:00 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 5 Feb 2021 16:03:00 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/11] drm/amd/display: Add return code instead of boolean for
 future use
Date: Fri, 5 Feb 2021 17:02:40 -0500
Message-ID: <20210205220250.1871069-2-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210205220250.1871069-1-Anson.Jacob@amd.com>
References: <20210205220250.1871069-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94fa7eba-773f-406f-2386-08d8ca21d0e0
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0079:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0079764EB6C53BEB648E529BEBB29@MWHPR1201MB0079.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8YqQPpoiABmjrZFYiL9FcEB8rlYfPxbeqDsXonZ0FKt1+7RzA/1WPR4o+zY4LJlLE0yEA0S6D03pX0R75ThlX17XekYO15adHfPyaA+TciGBtYPam0QQlwQ0xAIdKhEEQrVHqMuAp93K3XnhfoWkO+pXvgQjM5wLoWQ336gEGn80GC5xjapfqvSxBIzZcQgF0aGKObPeZCmTtW5Vq7yjrDC0vE4Pql6bpidTuE2+IIbU8mVFGeU2iV0sxk7Xc13yGoypWUREES5Qdrrr7OHCEcmnFyxl0QUOuc2nODxb902/EDwsaGTILl+z8+Us2rArPnei76dd1G1l7G1SMORnrAFusNgRuMAPl/wSAHSlh0HbpW2Lu2m3dkwUcQGFTDVc9y1p4qhGKGaK0h80SNhuLp0AC6gvGI7nKCFd4HF89T1CieJjKlYtOzBWQNwEVO7G/nl8IjXG5BC5LlbO2L9S3RcQgBL2hGrA5HcDPDrpuiZEO+i1j8j3r+nsnnvueXOpAtgzf9+MHi/iElXtf8kAbzgbfzXQcrKc0U+Zp2f8oc25N8I0UE5euNoJBSPCuLH5H8x3QTX0uAZxKUvs24a/Sqmkftc3aaz5h8hGu3eDjfP/409FoE6uyyYhHawihHSHEJ7GZGE9McRtl7LvilhjJkJ+W9SOoykCFg7JYuc8wf2itqF6KlxsnWsHj2a0zVZz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(36840700001)(46966006)(70206006)(70586007)(82740400003)(8936002)(54906003)(81166007)(316002)(4326008)(36860700001)(47076005)(86362001)(426003)(6916009)(5660300002)(356005)(478600001)(1076003)(6666004)(336012)(7696005)(2616005)(82310400003)(8676002)(83380400001)(26005)(2906002)(186003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 22:03:05.8387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94fa7eba-773f-406f-2386-08d8ca21d0e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0079
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Aurabindo.Pillai@amd.com,
 Mikita Lipski <Mikita.Lipski@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Reviewed-by: Mikita Lipski <Mikita.Lipski@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 3244a6ea7a65..5159399f8239 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -526,11 +526,11 @@ bool dm_helpers_submit_i2c(
 bool dm_helpers_dp_write_dsc_enable(
 		struct dc_context *ctx,
 		const struct dc_stream_state *stream,
-		bool enable
-)
+		bool enable)
 {
 	uint8_t enable_dsc = enable ? 1 : 0;
 	struct amdgpu_dm_connector *aconnector;
+	uint8_t ret;
 
 	if (!stream)
 		return false;
@@ -541,13 +541,13 @@ bool dm_helpers_dp_write_dsc_enable(
 		if (!aconnector->dsc_aux)
 			return false;
 
-		return (drm_dp_dpcd_write(aconnector->dsc_aux, DP_DSC_ENABLE, &enable_dsc, 1) >= 0);
+		ret = drm_dp_dpcd_write(aconnector->dsc_aux, DP_DSC_ENABLE, &enable_dsc, 1);
 	}
 
 	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT)
 		return dm_helpers_dp_write_dpcd(ctx, stream->link, DP_DSC_ENABLE, &enable_dsc, 1);
 
-	return false;
+	return (ret > 0);
 }
 
 bool dm_helpers_is_dp_sink_present(struct dc_link *link)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
