Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D6BC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 15:14:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F94964DF0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 15:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F94964DF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33DC38982C;
	Mon, 15 Mar 2021 15:14:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84D3F8982C
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 15:14:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9I0WHriXZ3Rb6RENKnhl9M0iZIEX9a/kIGtUODT8cf0ciT7igv0l9W2cekhwwRh6i3DiYdbVbVoci48JcOM663Fx6jpilz4HIMbYayQbfcbKJUjmRUifXS22lhnBsOERL7HmtPqGZwZaBJL+vZxH4dvwiO9U4h0K/DAnFSZAE7aJFWeDAl5IF19s04BrQdSKebjtlBon8WBPZK/bNJFgarVNk040f+gZdB0aptB7aOqucT5KjwwSR9njVhO0nDjT1ng9IfX/twCPyh61EkUSFtg+fHuFtdN7vRH3pESy8zuAjmaI5ejQacYHpyktvTCNke4SNngckGu8i2L82obMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dait3AApPWdwF8iD25vOAceJZ+pQLz4Wd3QuEUwZLf8=;
 b=nwGrL4SIzNDim3fCs03fSRxDGfbCVwORHjQAx1Dkf44Iv7AlelJ39D8hXElWCcFMev7kQ+R7CgNEx+wpN5wGigL1/g+TwIQ4QVXvEl5zQGTt6UkFijVyKhR00pA1DMJl1yWbbPnMBpAWXKiW7do0R9AIFZyRCdPRSaqycNV2JDly5jmM2k52EYjamypqQHH2RjUy50eavR6s6qNvxEtfz8qGoHQFytqtoGkzFh9uYVikMl54/wFLNAw5gZ/1/2TPmjt//js/B7l1sg8Wf3ms94ZouH9S3ATGBHEZBkwkEWDGXHYENvZsOY1gykk1Qi8Q2fv6we4NWrzbSxuljK1lTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dait3AApPWdwF8iD25vOAceJZ+pQLz4Wd3QuEUwZLf8=;
 b=gOWo/os2TgtLbstHqWHw8r9S5Q8xnVNTQwEUSXfEk/tzrpEUkqN5SgaLBk8BXDH/PqRxamTvhtabUGT6o0s8JBl9w6fC2wZjkjoV8r8H/QGQknvMyj4S/te5xgGAQgBDZKok+dXPMmxJapgpyGANI6FWym6nEFC8Kn168aHFrvc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR1201MB0056.namprd12.prod.outlook.com (2603:10b6:910:1c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 15:14:29 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 15:14:29 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 1/1] drm/amdgpu: make BO type check less restrictive
Date: Mon, 15 Mar 2021 16:14:14 +0100
Message-Id: <20210315151414.50491-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
X-Originating-IP: [217.86.103.190]
X-ClientProxiedBy: AM0PR03CA0070.eurprd03.prod.outlook.com (2603:10a6:208::47)
 To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.103.190) by
 AM0PR03CA0070.eurprd03.prod.outlook.com (2603:10a6:208::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.31 via Frontend Transport; Mon, 15 Mar 2021 15:14:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0bae7275-60e7-44c6-5ce8-08d8e7c50744
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0056:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0056BC4CE1CE3C9EDEBDA32C8B6C9@CY4PR1201MB0056.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: huZ2SnDnR8pp/M/MAIeCcErjZU2qLpfSoLBCcpdeOL+c8VNLLOXh6d+dx+2UthakP0UuyxvJhoCwCK8sSEpNrxrc6j/l8EUKScb9j3U2j5UHNOxU7sxIEthXmoCuAJ2zk4f1xOJBZkrUDlmarYmaPHJHcDndZlR0XWO/li4ce/JtbnNOjxIRiBu0Tla6DEv1v+ifqqs8St80Rl6WX19LtkJmBXSKqsPSg2qxvWen55YC6/bMdd760W9DiCPlOBBmhoEQ3i1HJvg5RWs6+xDX3jOe2HHrhSZ01xWXDET6DX1e9mvSR71t09wpJhZ67JhoU0F+u3LTa1SM/od5OGLLqkMwqLog5hwZXUJlSO6pf1AxqKduTCJdtqgGy86ePNpmy5RmM3N9AGjhGBDZwB6not9ggIdqK/lyZ16mvq5FbySG7rhOtwOSqfgvTk3GE3Qf8y2LQs3lkJuKAvD+mDqRH8EGijOn6lMX87EJIr7tcEOb5xqkp5zZNeufjxCHwMLfoccOcix3PTHOlBLdolgmd8+wWffPiRfD/W8b+ZQtZjBVzl0dWyOx/FBJFQFxSEt3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(478600001)(8676002)(2616005)(186003)(6486002)(8936002)(956004)(16526019)(66946007)(6666004)(34206002)(5660300002)(44832011)(4326008)(36756003)(6636002)(83380400001)(66556008)(2906002)(86362001)(26005)(37006003)(54906003)(6512007)(6506007)(52116002)(66476007)(316002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?lMwR2rh9qnsjJ7FaoUlJyLlpZQ/2MWASE10WhlbVvmiJ0a0L5iqM7/ljZph2?=
 =?us-ascii?Q?Qp9zYcLGrPzZ6PptDtrRoLhzPYa04h5Rrcgt1ZGxIHbR4mk3gpZ53SU6qZS6?=
 =?us-ascii?Q?58xKI0RsgxVa47BTEjZ3Emu7EFsLdjUERawmq9pSkHPZc4En9chYdbfAkUZ/?=
 =?us-ascii?Q?kPHNioh4nZmMLXE+UXqOxAydPb8zy4WKzmu2uC5YPq75Yn+II5t5hJUs8s79?=
 =?us-ascii?Q?L8qJ35GoGAukVKhTbPqCcTIUtEX2waIVIJDLaI1OxZcRb025NGlHCtcHR/ZH?=
 =?us-ascii?Q?LtQIPSmOynE38Gq3PsBrBL/YboepCxbZAAhZIj2Nlq2rbi6wfwLodz4oVldz?=
 =?us-ascii?Q?/WKKaiWaJDgYuXapzpI7cIDmkhOQB4nAyWueDdk0leRHzDJsaKBTIN85WAHI?=
 =?us-ascii?Q?Toq8qVsq52WniS4dVjipLnTBHeY+SlWEbBWI29KPNJv353AQx2l2U/p/bpst?=
 =?us-ascii?Q?Ywnvm21mhyfD3jfJlFPoLP284HyCsen0o8/b1M+7+0g2GYgTrxKSB3Sy6z0b?=
 =?us-ascii?Q?gLEyXtc3Nw/4B3jor9uoXOslwtx6o6UnpIYvXBBqNBZjTVtnlI4vynAF/kb8?=
 =?us-ascii?Q?12CNC5REUgew+OzNvy61N5mqQN76twPG8E5C8MdKRp06R6MpWdMR920ZqR+C?=
 =?us-ascii?Q?DqC/rVZaCqFQWTiG7YSEbbQxGXVHvFbyip2nkyPPdxjwnWMkcxMB9WIxI8+M?=
 =?us-ascii?Q?jvtFr8kifz2YArOW8erD19V0msaMpuzJ+YyeUdb2mmPeXw5Aw0hL+XSeo72L?=
 =?us-ascii?Q?r0I3kNs6jYd0wycJYffkGb7vAv0cYcfpAAsCjJ1iOnDnodBwuKlRktYKNZ7t?=
 =?us-ascii?Q?u1NoSIMIQlSjcvIti2GmOfhoReaG3VRqj050aDKq9jThN2EsNAwXsMZBYKjI?=
 =?us-ascii?Q?M67zTqd4gWWXZLQF2RLCk8G60wXooLf4/3hgMMBcpYZKi1Gf+08Dtj0WLExI?=
 =?us-ascii?Q?/sdX53AdAfZIFGt5Q9+wbnvdl/nXEd5z3743VQnpnWNs0uV9JZZo61Zju8Pa?=
 =?us-ascii?Q?965kLM7xtCv1wJWkMp45LpbGJaDXwNOkdLDpjSm/EIiNOQA80Ux5/FuKthlH?=
 =?us-ascii?Q?TTwXd2zvnLIMBDkJZSWMYm9wgykh7OWqYn47L7Xn6LHWssDw2pH21mQHyh2k?=
 =?us-ascii?Q?e5CsvjXBHNPXWHLsoh/KdvBYZzw63FHfWchSpLlRC5p+Bx/j/MLmQr6QRkCB?=
 =?us-ascii?Q?vjt5K+l96Tk6KhAclUESLVh4WAs72XkKgxZm4p5PfCMeC94Y51VxMav1dOQ4?=
 =?us-ascii?Q?/l2M8036FpxIjdNyX6oAFRCfdNQZnqzkqBTpXvhPEMAD8MJrDakieFJNKvHw?=
 =?us-ascii?Q?I0zPUjTFHQwBl4OPJVUkGAQJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bae7275-60e7-44c6-5ce8-08d8e7c50744
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 15:14:29.2098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAhsKJNiUqd1QHSTKrfQoCRmR+j7KpjRO3dNap62Jv28JUINbjWaHu2diD8hABOnyMR8yNuWhQFPNObCaGwY5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0056
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
Cc: Tom StDenis <Tom.StDenis@amd.com>, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

BO with ttm_bo_type_sg type can also have tiling_flag and metadata.
So so BO type check for only ttm_bo_type_kernel.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
Reported-by: Tom StDenis <Tom.StDenis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index ac0e1cd83858..fdf23e439b42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1167,7 +1167,7 @@ int amdgpu_bo_set_tiling_flags(struct amdgpu_bo *bo, u64 tiling_flags)
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct amdgpu_bo_user *ubo;
 
-	BUG_ON(bo->tbo.type != ttm_bo_type_device);
+	BUG_ON(bo->tbo.type == ttm_bo_type_kernel);
 	if (adev->family <= AMDGPU_FAMILY_CZ &&
 	    AMDGPU_TILING_GET(tiling_flags, TILE_SPLIT) > 6)
 		return -EINVAL;
@@ -1189,7 +1189,7 @@ void amdgpu_bo_get_tiling_flags(struct amdgpu_bo *bo, u64 *tiling_flags)
 {
 	struct amdgpu_bo_user *ubo;
 
-	BUG_ON(bo->tbo.type != ttm_bo_type_device);
+	BUG_ON(bo->tbo.type == ttm_bo_type_kernel);
 	dma_resv_assert_held(bo->tbo.base.resv);
 	ubo = to_amdgpu_bo_user(bo);
 
@@ -1216,7 +1216,7 @@ int amdgpu_bo_set_metadata (struct amdgpu_bo *bo, void *metadata,
 	struct amdgpu_bo_user *ubo;
 	void *buffer;
 
-	BUG_ON(bo->tbo.type != ttm_bo_type_device);
+	BUG_ON(bo->tbo.type == ttm_bo_type_kernel);
 	ubo = to_amdgpu_bo_user(bo);
 	if (!metadata_size) {
 		if (ubo->metadata_size) {
@@ -1266,7 +1266,7 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
 	if (!buffer && !metadata_size)
 		return -EINVAL;
 
-	BUG_ON(bo->tbo.type != ttm_bo_type_device);
+	BUG_ON(bo->tbo.type == ttm_bo_type_kernel);
 	ubo = to_amdgpu_bo_user(bo);
 	if (buffer) {
 		if (buffer_size < ubo->metadata_size)
-- 
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
