Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63617C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F5420810
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DmHScp4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F5420810
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C608E6E489;
	Mon,  8 Jun 2020 04:59:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 805C06E487
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 04:59:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQC/US3xX3bg7kxavfPphAkp/h96CFMmKuVjb8sVzWTK+yLUeDhl7dtFGVwfbooTp7Z5QGtgB3QivkUGEgzXW9QDcX0kvKUz0nRlbiokylt6MXhjILe2l2yDjWbZgBWOLBneMv4dIYFX5nxHZXc8C89bIP50iGme/JuvqXuvl4k/vsifmlr3kVpVhTM2S6XyoQWvT4apSBY49NSJb/J2AgSTknbS1zwFxJJk0iD0swIzeLw7pHH/35P1MKmHu0qNIQsEnKNVMRVImvRqxnkM+y8k2ERY9mdA4DCuXuwqXAnxrhPgWJOKnAJJwnC0CmRBcMEBWZMZuD2bYQR8Bc6NmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TckJt2mNp14mezSRVGMxccaOEllBjSQZ5z56CmFsrjQ=;
 b=QbOn8ymRgcYFXHRwA5edp3evTB8wdL5sUuD5Ru/DBaMfZPxxNKGDC1LgKKsbCCfgUcTfF8K8taTtAnzD3MdONzmnT6MZAl2FTIfbaDqROiGlH0rZB0+Sa2bBs7mOhdHhnAJTXXMChXmGiw+GHgccqD2e8ChyQFDTwZjPdUX3S9baUFbboEupeBJyP368gBwSmHLS+tzBNWY+ULdduZ+QClb2T4rl4jRlzkVoj8Pi2ymPdm+Sl1oBnwMYTqbYvRSnHzx5soleSZLZsr2zFnF0KtR1I7DwjADcxTT8F56f17oRDZFIZpGYtgeVl2CQfKvXYT+nxbo3WTEiEprUlIIL0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TckJt2mNp14mezSRVGMxccaOEllBjSQZ5z56CmFsrjQ=;
 b=DmHScp4HDM/8agSO1yZSsC8qVueNA4Xkst9ttJfF4+o1W+bcST/1ZWL7p7gx2yUDLu37ad9yx/utkrrZVTfVmcGR9AOX9u8FSyapuQ4erC2yBY+Hu+doD9l4b5Gc4hQbJ7Zc0dRzDUtezx21fJky3seA92wA143wrtgVgNbV22A=
Received: from CO1PR15CA0113.namprd15.prod.outlook.com (2603:10b6:101:21::33)
 by DM5PR12MB2405.namprd12.prod.outlook.com (2603:10b6:4:b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.23; Mon, 8 Jun
 2020 04:59:41 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::ed) by CO1PR15CA0113.outlook.office365.com
 (2603:10b6:101:21::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19 via Frontend
 Transport; Mon, 8 Jun 2020 04:59:40 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 04:59:40 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:37 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:37 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 7 Jun 2020 23:59:36 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/28] drm/amd/display: runtime select dmub emulatior.
Date: Mon, 8 Jun 2020 00:59:13 -0400
Message-ID: <20200608045926.17197-16-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608045926.17197-1-qingqing.zhuo@amd.com>
References: <20200608045926.17197-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(46966005)(70206006)(4326008)(82740400003)(2906002)(47076004)(70586007)(336012)(478600001)(81166007)(6916009)(426003)(44832011)(6666004)(82310400002)(8936002)(5660300002)(8676002)(83380400001)(36756003)(86362001)(316002)(26005)(54906003)(186003)(356005)(1076003)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e91e7a1-e8c0-4519-770c-08d80b68c090
X-MS-TrafficTypeDiagnostic: DM5PR12MB2405:
X-Microsoft-Antispam-PRVS: <DM5PR12MB24058E6689C09BD9E2C55FDEFB850@DM5PR12MB2405.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJHUz4WuZtIpwqUguj7+XEt7kOJT6sMlxnZPN+QEC5DJwMhBAk4SE0lHsnBQ6w0A3ZRuTqH+uQOCM8xFzcqWXais+fMMHtjiINRtf96OCLj3r7D7rDUkXzQLBym/zoPyQDxWiz7p3hs6nlxdRDHox1mPEj5AHcWpqxHNAVm8bsGc2a4HfT3OZvOexvIcJdXPHReaLCCLzWMGAG8wdO2LSSS5uIUuRM0RUA37r7q6ZlVb9aPoqJ/DlaIXYFHTeYcfMKvjznip9H7DWt+zAiOyhYG2JxlRMcbPq4Tn4I9nV6vP0hbrA+lgPHE8IG4vZyyrODmpUBhIh2Yzdw76wURd/cccP9Nwvn92zL+KHvQbETNOyFpW54TmpeS4cuD2Ze4SHQq8V2VX+UV2AkIj/BY6OA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 04:59:40.6523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e91e7a1-e8c0-4519-770c-08d80b68c090
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2405
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Yongqiang Sun <yongqiang.sun@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why & How]
Add emul specific hw function to dmub, in case of
emulator is created, we can runtime switch between
dmub emulator or dmub uC via is_virtual flag in dmub.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h     |  4 ++++
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 16 ++++++++--------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 93d6ff80b248..c6a8d6c54621 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -256,6 +256,10 @@ struct dmub_srv_hw_funcs {
 
 	void (*set_inbox1_wptr)(struct dmub_srv *dmub, uint32_t wptr_offset);
 
+	uint32_t (*emul_get_inbox1_rptr)(struct dmub_srv *dmub);
+
+	void (*emul_set_inbox1_wptr)(struct dmub_srv *dmub, uint32_t wptr_offset);
+
 	bool (*is_supported)(struct dmub_srv *dmub);
 
 	bool (*is_hw_init)(struct dmub_srv *dmub);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 937f6c3c9911..eb51b7920864 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -199,13 +199,13 @@ enum dmub_status dmub_srv_create(struct dmub_srv *dmub,
 
 	/* Override (some) hardware funcs based on user params. */
 	if (params->hw_funcs) {
-		if (params->hw_funcs->get_inbox1_rptr)
-			dmub->hw_funcs.get_inbox1_rptr =
-				params->hw_funcs->get_inbox1_rptr;
+		if (params->hw_funcs->emul_get_inbox1_rptr)
+			dmub->hw_funcs.emul_get_inbox1_rptr =
+				params->hw_funcs->emul_get_inbox1_rptr;
 
-		if (params->hw_funcs->set_inbox1_wptr)
-			dmub->hw_funcs.set_inbox1_wptr =
-				params->hw_funcs->set_inbox1_wptr;
+		if (params->hw_funcs->emul_set_inbox1_wptr)
+			dmub->hw_funcs.emul_set_inbox1_wptr =
+				params->hw_funcs->emul_set_inbox1_wptr;
 
 		if (params->hw_funcs->is_supported)
 			dmub->hw_funcs.is_supported =
@@ -502,7 +502,7 @@ enum dmub_status dmub_srv_cmd_execute(struct dmub_srv *dmub)
 	 */
 	dmub_rb_flush_pending(&dmub->inbox1_rb);
 
-	dmub->hw_funcs.set_inbox1_wptr(dmub, dmub->inbox1_rb.wrpt);
+		dmub->hw_funcs.set_inbox1_wptr(dmub, dmub->inbox1_rb.wrpt);
 	return DMUB_STATUS_OK;
 }
 
@@ -557,7 +557,7 @@ enum dmub_status dmub_srv_wait_for_idle(struct dmub_srv *dmub,
 		return DMUB_STATUS_INVALID;
 
 	for (i = 0; i <= timeout_us; ++i) {
-		dmub->inbox1_rb.rptr = dmub->hw_funcs.get_inbox1_rptr(dmub);
+			dmub->inbox1_rb.rptr = dmub->hw_funcs.get_inbox1_rptr(dmub);
 		if (dmub_rb_empty(&dmub->inbox1_rb))
 			return DMUB_STATUS_OK;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
