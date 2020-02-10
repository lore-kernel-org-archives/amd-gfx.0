Return-Path: <SRS0=VWwp=36=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D493C352A3
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 15:17:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01AE7206ED
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 15:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bp4qnYhk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01AE7206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3AFD893A2;
	Mon, 10 Feb 2020 15:17:41 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760088.outbound.protection.outlook.com [40.107.76.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49E76893A2
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2020 15:17:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDcmiHF9aJ3cGRplRixu5GHu3hj/mTawvKewxCarp9z2HFcwRfWtM6kjFH2up12K7R+mEBVPbOfeEDPFpXPZGV0tGc3mOQnrKI17c3NMfLmj5YqI5XnZ3vMlnFCMcfKQtx/he8gnd6bsyDp2owAhbFgJi6Fd3QEsEPdmKPUW256rSJ8GAE8VLzY91aZU69xy3pGH5UebWNvo9B+R6u8MuYd4/0gEtWmOWTCGlk5m4x35bVyQHqLnCaC7Tt3qoI76ocftKJtISp3G7n/uXe+3A7w7COtmYurUkelBWvWFcTDZfQ/lzy4Bfzb4mYA/liaLY7GdZ4iRFq1zx7g2MJz7fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Aj9z7rx3nSnomu9UqRJSp9G4R7n46Y2QY0LIe8YRqI=;
 b=YcAgcDFdnXIiv7+ZO6dRoOWw7aCrwdJa85Tt55iOqck+742/mnUbmyxJm7PQvJWrkoV02DSLhOse/hcdCDQzlZ9qrhYs8IryXgPGtJmrtTJ0vJzpS6yWvA01a9eZ8KdVY6BX39ADXwgpolw5xleULwzrBgWUzd3zH9lldy6VFtSFJ1ZaEUgqM90xRFvPhac91lXnNeTGWfLAYU/sbK6iOww54hewkCeC19Ws2CgH/yZp5InY+mIL2GSufKimjUcnK6pw/mXPKxxUJBLKAJ349+Idsed39MAvL3MMigbj1GDpe5Xv8sRycshsUyksEkPmz7YNXskM7o5Jt9EpDoaFYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Aj9z7rx3nSnomu9UqRJSp9G4R7n46Y2QY0LIe8YRqI=;
 b=bp4qnYhkzg34q2RhTVE+rvUuWXZLtl400J1tEhlv+Us/sBRkq3TPgLTTe4iritJ2Kk0mGZsInfEgSsk98U6QYYFKgpINykxIlspAlu6okXrj1llw3wlPv3Qn2yXo3gLvdABHY1jzMuc3G/HhmgwzzT2K78aMgLOWAYbr0zjqUDM=
Received: from DM3PR12CA0074.namprd12.prod.outlook.com (2603:10b6:0:57::18) by
 DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.28; Mon, 10 Feb 2020 15:17:39 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::207) by DM3PR12CA0074.outlook.office365.com
 (2603:10b6:0:57::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Mon, 10 Feb 2020 15:17:39 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2707.21 via Frontend Transport; Mon, 10 Feb 2020 15:17:38 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 10 Feb
 2020 09:17:38 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 10 Feb
 2020 09:17:38 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 10 Feb 2020 09:17:37 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: fix dtm unloading
Date: Mon, 10 Feb 2020 10:17:33 -0500
Message-ID: <20200210151733.6861-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(396003)(376002)(136003)(428003)(199004)(189003)(316002)(36756003)(426003)(6916009)(2616005)(6666004)(54906003)(1076003)(4326008)(7696005)(356004)(86362001)(8936002)(186003)(26005)(336012)(5660300002)(81156014)(2906002)(81166006)(8676002)(70586007)(478600001)(70206006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3212; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47e636df-3305-497e-380a-08d7ae3c5d97
X-MS-TrafficTypeDiagnostic: DM6PR12MB3212:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3212945518F87C0DF6C3E8ECF9190@DM6PR12MB3212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 03094A4065
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2mo2vERnE9qLFXx9yEQS6yxZHbAbBCr7kEQXTLAJ9M7EIVorIu7WqkPfSC+UyvMwI0MKazw2zsktShSzqA7bvH+gVlJAZ+L/nkJo5HEnZPqoxxGFlxoAcfG59MmCsVOXuVLG+djKecuLpQHPsk0ZmK3p2dyutSkbHiQegDM/Mnpx3f74apkY25ZMfTovCQYKb8XwgMVuGJzbIp2wkiTxG2PgBX7B+dnlCy6DIoUJtsDeKvUBWPSILYX+6Odffz4AjPOJhV3C/ZFDVEZqVPztDF59m9QnbTkzY86KigbXIcrqoeBFRAs1mmo1KDzRu5yAHH1btjxo801oeJSNGgcSQWyGtGUqpVgmOFaHdAVS2guoOAclUXyidODxd7wGxoJgaLGvp1dcwzs15D0SZFuWllEagOIeHy5193AHNhF6nQRkvS/xyCVlzSRtdC9VQ8IT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2020 15:17:38.7226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e636df-3305-497e-380a-08d7ae3c5d97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3212
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
Cc: alexander.deucher@amd.com, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 harry.wentland@amd.com, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

there was a type in the terminate command.

We should be calling psp_dtm_unload() instead of psp_hdcp_unload()

Fixes: 143f23053333 ("drm/amdgpu: psp DTM init"
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 26 ++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 939a114605c0..a16c8101e250 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1013,6 +1013,30 @@ static int psp_dtm_initialize(struct psp_context *psp)
 	return 0;
 }
 
+static int psp_dtm_unload(struct psp_context *psp)
+{
+	int ret;
+	struct psp_gfx_cmd_resp *cmd;
+
+	/*
+	 * TODO: bypass the unloading in sriov for now
+	 */
+	if (amdgpu_sriov_vf(psp->adev))
+		return 0;
+
+	cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	psp_prep_ta_unload_cmd_buf(cmd, psp->dtm_context.session_id);
+
+	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
+
+	kfree(cmd);
+
+	return ret;
+}
+
 int psp_dtm_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 {
 	/*
@@ -1037,7 +1061,7 @@ static int psp_dtm_terminate(struct psp_context *psp)
 	if (!psp->dtm_context.dtm_initialized)
 		return 0;
 
-	ret = psp_hdcp_unload(psp);
+	ret = psp_dtm_unload(psp);
 	if (ret)
 		return ret;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
