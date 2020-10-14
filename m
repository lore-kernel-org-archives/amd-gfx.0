Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25900C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 07:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF3BD212CC
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 07:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YlZh6Mam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF3BD212CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B4676EA1A;
	Wed, 14 Oct 2020 07:18:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B31EE6EA17
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 07:18:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMHqWY2KZDsuVLnR5XZn//9i+YqBJLUfJhbGy7wz2iqhIJRIvXVmLxqv5weQxeA9WDN7Xkigz5VGkhO4YoU1t4/OgPeXhArxY61Ep/4nf5uS+XUWO+0QP42zHTDK2Olayhabhd+XgqY038EH4NviRL6xCrjNRnC2j5vm7BHv9ga135vfN8h1r6Ro8oz65M5/DmPsnu4LFHZkMLkmhx/ZKkajYJehHJ5N4Itf+vPMRQORJFLP4cxv8kIFDORvs5BUPH45rUuSBwFhEr6Un1ft1ULCEar9ampohafs06JFKVaueO54W/zm4SKir/l9BUiv/5ybp6uHUP3A7unjxOBBFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgWzl3t2EPwpBWeIa/rRyRmt/iUUhf8W3pkHNigGy/A=;
 b=kSITHvBmNVVnlQLXHhVrrrVl6EXe5RIp/EGp2CmB8Qrvv5Z72xW3CsIPxViE86qd/ZqDC/JD6L2F5IhZ3vHcCUJs4HQBS6V54QDCgg0qHQbZ0MqCbqXxbrlXFBaNQXUBQ4lGDt+xJaW11ztyUDUMVEhFWIWNbOY8inJ2ZZ53I23fOh9OxW67T8k5WGJQjNflTZ5+9Ela+ED0tVh6Z4ivFDGRdrvw7Qm2SH4VEqmU2iXsssPUVkbNOWnkc7Ga2zB7f43ngasQCSZxSKegtWsbo7ESY5rDNpFBmmkpQGFIRM75Jr+7WSAJr7/Ki0u2tjcs80iEG6Wi0eIpapjZUfQsKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgWzl3t2EPwpBWeIa/rRyRmt/iUUhf8W3pkHNigGy/A=;
 b=YlZh6MamT+VSMAns14JLdIR2yk4ks4aNvLPOsLp8P6puwBqJTaeZDF/y9uSD0u27IuGaV/2ZQcYrnwWHeSsdlNlQCQcTipFfURgOBEXN4LSQnkqObPjBewoJM+p66lEI0X76ENd+SJrRT/AgJl6D/6E5z7HFpu2i5UQXSidC8LM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2891.namprd12.prod.outlook.com (2603:10b6:5:188::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.27; Wed, 14 Oct 2020 07:18:43 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 07:18:43 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/5] drm/amdgpu: fulfill Navi gfx and pcie settings on umd
 pstate switching(V2)
Date: Wed, 14 Oct 2020 15:18:11 +0800
Message-Id: <20201014071812.8396-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201014071812.8396-1-evan.quan@amd.com>
References: <20201014071812.8396-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0012.apcprd03.prod.outlook.com
 (2603:1096:202::22) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0012.apcprd03.prod.outlook.com (2603:1096:202::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11 via Frontend Transport; Wed, 14 Oct 2020 07:18:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 387b4533-9dd6-4046-fa20-08d8701161f5
X-MS-TrafficTypeDiagnostic: DM6PR12MB2891:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB289125017AAE691602BE5885E4050@DM6PR12MB2891.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y3rSZKyDqzveRFWS/Di26mRyEMandx2RcGrsnEOYmZYyLj8YG30p+2mYysGtkmvpSlaRmEhU6aw50hRS4bSR4EcbNdm4l5p+abpHrRLNwgoXHAWG6i5/LAOQgXJWAjp45X5QDAuGoZkRHKBCzFR4cAUAH6R1UzUs1jUnaoCJIIRCtIMST+s9iAtz170JH6h6yqk+7npw8ccCge5yL3wTzS1WGxkGt6FocSG4iCEAvBAamUeuhBdReI71ZAiNT/NEj2bkDxUgPeGQwTOBYxoQZ+IeoMiLXI8aBrsV/PKf6FRAQqqdzsFQ5uToVK82QMBM8QqsVqVNJzz9+M5Ka4G+Eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(366004)(396003)(376002)(136003)(44832011)(4326008)(7696005)(52116002)(83380400001)(86362001)(66476007)(66556008)(66946007)(6666004)(26005)(16526019)(316002)(5660300002)(8676002)(186003)(8936002)(478600001)(956004)(6916009)(2616005)(2906002)(6486002)(36756003)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: mPKh2j4ushMo2UJ0GHf9F4FlcTsoRtaEGty32bQPp3uRi6+2unmwRrbQrepaObMPS5YDe79L5pvEMW1lTdglBKdiQ5povSHAfTiAufuNSBTU1oMKRE44rOICl31qH1YRPH5EHZuJ30YiY++5p+tBrxzzphnJ9gETNuMW8ZAS3VLL/29KhAXbsoudIjlTPoqS4f0d8OUIiSoDSm3eb2ReREhp4RXZBZsl14kWX1dp/nVSyTEvNgkongdwXcUtxYHq/LFiUvX7iG5nYVZGmficxeme3VlU5Quexksk0Ulqxk6Iinr2dgUOPyrJJyCglyzxHMdWy/tW9VSwjZLV1lXSVryOx7xpwNdNOAo/+UnlgMzco4JpfZ1fTN4r1J2ZowJ3hg4MarKytvFzMkk6MyOA22mZAMu97EKPNuXDWTyY5TwR7EpFlRgB+kmIZCNaV0tD0IvCmPrt1gRKlJnw+8MUlVJ3sQ5aGrrMm7+wXbzxJA7K+/IXDv/uAGgFH/DWgNwLdf3HsqOFmsTX7dIOk++lm/j9se1zFXbj8p19fMQu3lsxyN7Meuozv7m2SSTcWMawTifImnlO69oVBBlkO5ty4+D6XSpm0LTa7hwquSlCGOuq57Xt0+Z28M3R/Q8m9EwjDvjbf/YhlkDA4dBa2LBAXA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 387b4533-9dd6-4046-fa20-08d8701161f5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 07:18:43.5409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKshZWbpzZx1RcNPDwzj7n6v92c7OVWQGlbSLczUe6WG6n+topZa0hcAwOzKZzdi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2891
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fulfill Navi gfx and pcie settings on umd pstate switching.

V2: temporarily skip the pcie ASPM setting considering the ASPM function
    is not fully enabled yet

Change-Id: I8d746d4c25f890665feeffddf64164ed2b1f5ccc
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 47bd79c9e6ea..de0bf92ffa29 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -742,6 +742,29 @@ static void nv_pre_asic_init(struct amdgpu_device *adev)
 {
 }
 
+static int nv_update_umd_stable_pstate(struct amdgpu_device *adev,
+				       bool enter)
+{
+	if (enter)
+		amdgpu_gfx_rlc_enter_safe_mode(adev);
+	else
+		amdgpu_gfx_rlc_exit_safe_mode(adev);
+
+	if (adev->gfx.funcs->update_perfmon_mgcg)
+		adev->gfx.funcs->update_perfmon_mgcg(adev, !enter);
+
+	/*
+	 * The ASPM function is not fully enabled and verified on
+	 * Navi yet. Temporarily skip this until ASPM enabled.
+	 */
+#if 0
+	if (adev->nbio.funcs->enable_aspm)
+		adev->nbio.funcs->enable_aspm(adev, !enter);
+#endif
+
+	return 0;
+}
+
 static const struct amdgpu_asic_funcs nv_asic_funcs =
 {
 	.read_disabled_bios = &nv_read_disabled_bios,
@@ -762,6 +785,7 @@ static const struct amdgpu_asic_funcs nv_asic_funcs =
 	.get_pcie_replay_count = &nv_get_pcie_replay_count,
 	.supports_baco = &nv_asic_supports_baco,
 	.pre_asic_init = &nv_pre_asic_init,
+	.update_umd_stable_pstate = &nv_update_umd_stable_pstate,
 };
 
 static int nv_common_early_init(void *handle)
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
