Return-Path: <SRS0=ENO8=65=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3B6C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:14:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4A6A20657
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vb9kTrTx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A6A20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6810A6ED34;
	Fri, 15 May 2020 18:14:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7AAC6ED32
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2020 18:14:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PR0bHVESpzTvI/yvBs48fggTb29XgRdyWtvRpMumk8KU3WDGP827QzP22QN32+2Me6DIn0gJI6ioZk9uieX5nAHP9S98WsBwIy1wnyZr0OQLC5zfkkgsp1f9MLCnLVG+DIUePr3zLfXBz/XKrF7QnX6tNgM7rlMRSll4wBBG2Ss6cxRUod7XQAI7LECn3bMkk17xMrnY6oNUCjGUnXoq8rQfCq+JTAxtj/TumwuQ6D7Gjx+k9veQQey4EpGJuU9QsVJ8P4uk112wgeGB1XK+ji3b5BVsY7BkyNRZQaEOjTONLI/isvZzLJYZByhrSjB9KgwQj2CDmt1wMUQhfujZbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqAfPrKdQjeg/oTcwC3DsjrI7hapTRlNOf5+tddsmTg=;
 b=cR6rieimIYN32MowZM5qUvVsywlTh2K/z6nxk1lGBnX+0XD/3CiF/J49SJ3XR6GYjvmeEhoiQfWF7gyfI29lT42guRPYTNer3lLZi89Y5aeg9yPn/ZRYb1EPu/dnXElNylmo6pUYNcgCDw9FgHJ0pfJq6jbTQyS7hqpsICB52D1s0KV+eG0CED9WaBkikWwJNrlbx+D51gUnzaVzfVZtKBrTm+QUomz9aqRAFrOsY69wTa6/p9mCZg/ZjliBAwSZbDHs/5hTTygmB7WJsIqTg2fxOShfC+URVikUiNACn08J7+zT6rZZN3DZePxR1HI9Rj0fWR3XaBNr3CAx7CFV4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqAfPrKdQjeg/oTcwC3DsjrI7hapTRlNOf5+tddsmTg=;
 b=vb9kTrTxAJWc4wGK1n2r+nl+gY8hCdLD9odmwkAtcEwVKLlB0zHrMm5vRwbDiFH1VoFgM5oc+XGqXwryDNx4DcwLh8ChXwjtvL2jgu9N+9zap1RE3KevE1CoU4fcJnWLAPzPVDH/atRkHzcFpgvw+MSjcexOY1DOGht7jxw7Zds=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3974.namprd12.prod.outlook.com (2603:10b6:610:2e::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 18:14:05 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%9]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 18:14:05 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 27/27] drm/amd/display: FW Release 1.0.11
Date: Fri, 15 May 2020 14:13:14 -0400
Message-Id: <20200515181315.1237251-28-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
References: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN7PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:408:20::47) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN7PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:20::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 18:14:04 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e53e5964-7a4b-4a1e-d73d-08d7f8fbc0a1
X-MS-TrafficTypeDiagnostic: CH2PR12MB3974:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3974F7BC409B9C85F33F70E098BD0@CH2PR12MB3974.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eUWf2/mdXqmg31S2G/0xOP5Of9kFIrE2Uz2xJdxJnKn7cdyOCF1fEuFQBXEHK2piHiGQSXvo0M1o6SLp7nwZuJoFt0OlDGYMYv0UO51k1DfDWGURBJTjo6kBGwWYxhLxTW0h6gbfN6oFJbdnVw8It4r9Ux8dn0eXA9d4JjTMDiJPYVB7x9/EYqFcCF8OakGpLG+mRLdILiYYwX4MzJH5vacdC4UjvAVCpgrs8CAEePGd9bUNiPvf/7EeTuqa5KWZXIR10LHSx+ys8hKNhPIFAMwISm+QLNefYdBYQBk7LUAnUdhUK15a4aUXoWCfsp//xkgajbjcGt/MbWPcSjyhbHjfPSC2r8toAP6KEN3OHAAxF4AxxkOoQhpd7EJw6XIg/7dFPJhkhqrPVm20rQUf4MK+LQy1+pPBJk4XCBnLqvbj0xnfvkBm/pFspFCaHwzP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(6506007)(316002)(8676002)(8936002)(86362001)(6486002)(6666004)(5660300002)(6916009)(478600001)(6512007)(2906002)(36756003)(66556008)(1076003)(52116002)(16526019)(186003)(2616005)(66476007)(66946007)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: FK0DqbKUTMC9G4jbpsBbkNDA9I3neIDwmpIQ42XfZbSbl84UbVZyIpW+IfSFk6fB5xOQUYxdsnLJ7Cup0pEanDkeVuaW1ggHNTXDhZkGfIywcuHfOxszYKakkvK5N75fIkyzUPcqzB4e3CpLR1kbCJ22oOo7xViBmU1fc5X42n/C/5qTZuQSeZStsKJU8sPsi6D8ogIGhwZ5m47CfGhoYYLpEEstLWP109qjhdTd1sE+kL45yYXtIuovwv/IEk3vE2AlG/FY/zrE9ufC/G79P5h1YfKzifP8+9fkizej4+0fQPWfKc0WHRag14BqoHPI0CLoyUjR5XvZMWiZQSBVLwQGgydCR8AvkQqVF+HT/EXttfLlBzpxU3Mze3RGSlBU5YfyZdF3MwuQmbsrj24JbsNonCRQIWI6lEElEp1JPxkTHYshIToSKF0VbHDywWh10e+Acawcd8fxuvMJWEbtO9YsKUkMjwcV4snE7O7xvbOG/TSfbYmOKABQBA8NvdfL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e53e5964-7a4b-4a1e-d73d-08d7f8fbc0a1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 18:14:05.0387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3m0Jqftu5PtbHCFZNIXtx4/86v9R0MNaItTnlsbEoo3+UU31Tu535gpCzlx7XPshT2wn7A1i/X7dr44E9WKrJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3974
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
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_fw_meta.h | 2 ++
 drivers/gpu/drm/amd/display/dmub/inc/dmub_rb.h      | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_fw_meta.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_fw_meta.h
index 242ec257998c..b657c51c9ac9 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_fw_meta.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_fw_meta.h
@@ -45,11 +45,13 @@
  * @magic_value: magic value identifying DMUB firmware meta info
  * @fw_region_size: size of the firmware state region
  * @trace_buffer_size: size of the tracebuffer region
+ * @fw_version: the firmware version information
  */
 struct dmub_fw_meta_info {
 	uint32_t magic_value;
 	uint32_t fw_region_size;
 	uint32_t trace_buffer_size;
+	uint32_t fw_version;
 };
 
 /* Ensure that the structure remains 64 bytes. */
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_rb.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_rb.h
index 2ae48c18bb5b..31f471f549a6 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_rb.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_rb.h
@@ -37,6 +37,8 @@ struct dmub_rb_init_params {
 	void *ctx;
 	void *base_address;
 	uint32_t capacity;
+	uint32_t read_ptr;
+	uint32_t write_ptr;
 };
 
 struct dmub_rb {
@@ -141,8 +143,8 @@ static inline void dmub_rb_init(struct dmub_rb *rb,
 {
 	rb->base_address = init_params->base_address;
 	rb->capacity = init_params->capacity;
-	rb->rptr = 0;
-	rb->wrpt = 0;
+	rb->rptr = init_params->read_ptr;
+	rb->wrpt = init_params->write_ptr;
 }
 
 #if defined(__cplusplus)
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
