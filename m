Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E75C32771
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 02:34:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2F082073A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 02:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NGb4civy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F082073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E2E16E98B;
	Fri, 10 Jan 2020 02:34:26 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C4FE6E98B
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 02:34:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFliDGTW444IG8O5iJyU4e+xzRBEiyR7zX2wqGs2pI9Tm3XT0kh/3WUqq+CF7cUIIjcrzBHcJV0vV6fgp/2tbXAJstaVGxjQrQKAc2Ty+/lWkSjd92meXAdpCzwAyC6RKc+mLamkKA71IM5J4s3MfCGs5eAcp93iGI3vpdBfzIUP0mW+mz6KhKn4tTh73qi2Uors5CE3XUr9HgqZ20byDp8GpK9JMNSkOxgNcBhBA+d0Ewi2t6q1WQNCwvMDfPB/jSAXZy6bubuHmVq7sGfTj4ks65WjepsS6vRDsuBAlK5J+FCbzr/LEM9TAK/kz+kJJYvQ/QIuSEfFvTQ4cISbfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMxvmfXMbPbKam/vRO+ZN7qNOlhyj1g3dSbjrTGZe/I=;
 b=I/DDbsJvUKsvJResxOx7FUSzaplnOiMzisEIQxqIlJQhKVjrmI02W+t/S0uJo0x9/BtJA42Ke9Y1NY9fzR50OlRWpjmHHYaQtCk4nVuVel3c/b/PEAl/3IeAtUWRr4KqpM6C7iUQ6BFWU8wVnzmWiNIEP0qmZbIv9dam4J1R+1KB8byVlrnv4XKLhQLm0ziRUiisUg5piLluebKfhldlm4722CnXC+QsGia52zbknyN28SZKWgvHAGK6lZg7KLQuYxv+PVij5euXgOuh1W80KtEuusINSjYgg80MCWdyXg48uZAPtCzpW1Z0qHLqp6b9ONpvhITBtClgym/PPLs/xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMxvmfXMbPbKam/vRO+ZN7qNOlhyj1g3dSbjrTGZe/I=;
 b=NGb4civyah4laYXwFO+01L4eVY6mIeN+xmryFb0H3mPp5wcadtSKVOmogGW1n4LBVGgd/5LZFdOJ+iHyljsfF6BlNN1J7/Vn7yLc+hSOoqXHlpIsx+srpZiYeZc7/eKHYgm0LXsEokQSZPVIjzeS2uY89HfK9TJrBBuHIu0zsgc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Joseph.Greathouse@amd.com; 
Received: from DM5PR1201MB2472.namprd12.prod.outlook.com (10.172.86.151) by
 DM5PR1201MB0089.namprd12.prod.outlook.com (10.174.104.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Fri, 10 Jan 2020 02:34:23 +0000
Received: from DM5PR1201MB2472.namprd12.prod.outlook.com
 ([fe80::7c50:5e2f:e0a:3721]) by DM5PR1201MB2472.namprd12.prod.outlook.com
 ([fe80::7c50:5e2f:e0a:3721%6]) with mapi id 15.20.2623.010; Fri, 10 Jan 2020
 02:34:23 +0000
From: Joseph Greathouse <Joseph.Greathouse@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: Match TC hash settings to DF settings
Date: Thu,  9 Jan 2020 20:02:06 -0600
Message-Id: <20200110020206.676605-4-Joseph.Greathouse@amd.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200110020206.676605-1-Joseph.Greathouse@amd.com>
References: <20200110020206.676605-1-Joseph.Greathouse@amd.com>
X-ClientProxiedBy: SN4PR0601CA0008.namprd06.prod.outlook.com
 (2603:10b6:803:2f::18) To DM5PR1201MB2472.namprd12.prod.outlook.com
 (2603:10b6:3:e1::23)
MIME-Version: 1.0
Received: from rocm-perf01.amd.com (165.204.78.2) by
 SN4PR0601CA0008.namprd06.prod.outlook.com (2603:10b6:803:2f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.13 via Frontend
 Transport; Fri, 10 Jan 2020 02:34:22 +0000
X-Mailer: git-send-email 2.19.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 69082471-0daa-405a-ba40-08d795759a47
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0089:|DM5PR1201MB0089:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB008910EE55D125AD981CB07AF9380@DM5PR1201MB0089.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(199004)(189003)(8676002)(6666004)(3450700001)(81156014)(81166006)(1076003)(316002)(86362001)(66556008)(66476007)(66946007)(4326008)(6916009)(52116002)(7696005)(5660300002)(956004)(478600001)(2616005)(186003)(6486002)(8936002)(16526019)(36756003)(26005)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0089;
 H:DM5PR1201MB2472.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d1IE1b5OfL8ZxE6qOtKrbvZVxrKDnRwvFXfDjd3xJofTtwwde5lLPv/Eit2xBQQthL1M7x4buZ2LTAOaNnsX6MzzuW4BB4Z7DHfDA0brDpoMfXXTnW3JqVP32FtLp0PR6eo6GusB/esz3vncyeFicDz88TKFqpySoPNvRH8Vy0lLBDATSeln1UoQE4I5FYpLZAxnvMUdU3cKetrk5FHUns5pxjkc07K+ehhiecgV5M531eu8I/REhifSZVy/2seA6pSutozBwS2Q7RB4vrOIZoXRUJj8PDgH6Cl4aNG3nM6auoD99H/2mUrvkfIHpZ7pml2WKDJQjByCgnnYG8l+yI63E7pvDvN6RF/FwzJYc69nYx2X2vJd5TvchJdnVbejqkBI8qBLQPrppnwejOQaxfSTpGhIUM3uZDVuOiLl9XJNXRX8CLlJP2X0LuKHX8bJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69082471-0daa-405a-ba40-08d795759a47
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 02:34:22.9788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t3bR1RJjIBceyM1UmTXfFScNHHIs8HBrcZ/k8ghf+s40EmURFrDTPcVGxO1Izpwju8hNPsvq570TEXNeHw0tvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0089
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
Reply-To: Joseph Greathouse <Joseph.Greathouse@amd.com>
Cc: Joseph Greathouse <Joseph.Greathouse@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Arcturus, data fabric hashing is set by the VBIOS, and
affects which addresses map to which memory channels. The
gfx core's caches also need to know this mapping, but the
hash settings for these these caches is set by the driver.

This change queries the DF to understand how the VBIOS
configured DF, then matches the TC hash configuration bits
to do the same thing.

Change-Id: I01e9e73ce6c89ea340925b4a1b895889ac152ec3
Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/df_v1_7.c  |  3 +++
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c  | 28 +++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 19 ++++++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/df_v1_7.c b/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
index 03fdeef568d9..d6aca1c08068 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
@@ -31,6 +31,9 @@ static u32 df_v1_7_channel_number[] = {1, 2, 0, 4, 0, 8, 0, 16, 2};
 
 static void df_v1_7_sw_init(struct amdgpu_device *adev)
 {
+	adev->df.hash_status.hash_64k = false;
+	adev->df.hash_status.hash_2m = false;
+	adev->df.hash_status.hash_1g = false;
 }
 
 static void df_v1_7_sw_fini(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 7bd29d97adfe..3761c8cc1156 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -262,6 +262,32 @@ static ssize_t df_v3_6_get_df_cntr_avail(struct device *dev,
 /* device attr for available perfmon counters */
 static DEVICE_ATTR(df_cntr_avail, S_IRUGO, df_v3_6_get_df_cntr_avail, NULL);
 
+static void df_v3_6_query_hashes(struct amdgpu_device *adev)
+{
+	u32 chan_cfg, tmp;
+
+	adev->df.hash_status.hash_64k = false;
+	adev->df.hash_status.hash_2m = false;
+	adev->df.hash_status.hash_1g = false;
+
+	if (adev->asic_type != CHIP_ARCTURUS)
+		return;
+
+	/* encoding for hash-enabled on Arcturus */
+	if (adev->df.funcs->get_fb_channel_number(adev) == 0xe) {
+		tmp = RREG32_SOC15(DF, 0, mmDF_CS_UMC_AON0_DfGlobalCtrl);
+		adev->df.hash_status.hash_64k = REG_GET_FIELD(tmp,
+						DF_CS_UMC_AON0_DfGlobalCtrl,
+						GlbHashIntlvCtl64K);
+		adev->df.hash_status.hash_2m = REG_GET_FIELD(tmp,
+						DF_CS_UMC_AON0_DfGlobalCtrl,
+						GlbHashIntlvCtl2M);
+		adev->df.hash_status.hash_1g = REG_GET_FIELD(tmp,
+						DF_CS_UMC_AON0_DfGlobalCtrl,
+						GlbHashIntlvCtl1G);
+	}
+}
+
 /* init perfmons */
 static void df_v3_6_sw_init(struct amdgpu_device *adev)
 {
@@ -273,6 +299,8 @@ static void df_v3_6_sw_init(struct amdgpu_device *adev)
 
 	for (i = 0; i < AMDGPU_MAX_DF_PERFMONS; i++)
 		adev->df_perfmon_config_assign_mask[i] = 0;
+
+	df_v3_6_query_hashes(adev);
 }
 
 static void df_v3_6_sw_fini(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index ce2b02dc7b64..e3d466bd5c4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3637,6 +3637,23 @@ static int gfx_v9_0_cp_resume(struct amdgpu_device *adev)
 	return 0;
 }
 
+static void gfx_v9_0_init_tcp_config(struct amdgpu_device *adev)
+{
+	u32 tmp;
+
+	if (adev->asic_type != CHIP_ARCTURUS)
+		return;
+
+	tmp = RREG32_SOC15(GC, 0, mmTCP_ADDR_CONFIG);
+	tmp = REG_SET_FIELD(tmp, TCP_ADDR_CONFIG, ENABLE64KHASH,
+				adev->df.hash_status.hash_64k);
+	tmp = REG_SET_FIELD(tmp, TCP_ADDR_CONFIG, ENABLE2MHASH,
+				adev->df.hash_status.hash_2m);
+	tmp = REG_SET_FIELD(tmp, TCP_ADDR_CONFIG, ENABLE1GHASH,
+				adev->df.hash_status.hash_1g);
+	WREG32_SOC15(GC, 0, mmTCP_ADDR_CONFIG, tmp);
+}
+
 static void gfx_v9_0_cp_enable(struct amdgpu_device *adev, bool enable)
 {
 	if (adev->asic_type != CHIP_ARCTURUS)
@@ -3654,6 +3671,8 @@ static int gfx_v9_0_hw_init(void *handle)
 
 	gfx_v9_0_constants_init(adev);
 
+	gfx_v9_0_init_tcp_config(adev);
+
 	r = adev->gfx.rlc.funcs->resume(adev);
 	if (r)
 		return r;
-- 
2.19.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
