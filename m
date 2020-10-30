Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B244C56202
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 06:55:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EF7F22203
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 06:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="olujm7CD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF7F22203
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C6206E957;
	Fri, 30 Oct 2020 06:55:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63FE76E957
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 06:55:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDc57e0FGEXznA+HNUtfpaZaAm1UguJtcLyePutio0ZElBYJsNXRZjUoiHZLTpG7OIxOhieUto5pkByax7FPOLuMvyWZyxEcny+l+3/FWjEOjSeQ+Fbw08gd+Djlaht8U3iBPlAmv+wmqoUUljHKXgpjIQTuo4JdbWfQ3bK0nh0TM4VW0PwLS9dSwIJVXSYEY6u0JIMCArt9Ppr0LCPIlV1akYvb9MlsIdkkpN5OYCyUCsckhuArAbMle8B+8RyKqKBS+HDTmHR0M3YI/k1MpHuE9uHC+mUG73W8D0JKK8zfT20aerB3IeF3s17dIzYiW6fG5jNcUpRhKkCTBk3adg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iy7y24k9kAFS6kwqFi9d+lEVp5eISFTa0EclF0/HfRQ=;
 b=Y23ISi4XyLSX7+mHpRQLFnHUDxgivm9taedq9Qdg2zq4bzG9sg8XSQDJvtF1oSWrABDKQOdlPsI3Oo20ZSB4mQCUyZO2F2nr30WzW4GOJ+6lgnSopx28pLU5/jELF+ajXCQuC2oH7Rkm963psOhCxFCtjph/N2Trnl5MENpOS4XanhU0hj0yr2b4jU1nC48mIbGd+1pJtQ8P6T4tklM/VdviSIMDenOsh2+yTARv4eMeJaKgOCkcCCog0IciZQJn6xdOo27Oq/n07U67bpe/bJoA/nMSZGSfYcYS7bw+FwTfA8+b4LAHEx8S+//Y+Qyk7yads8blzAVvUhs+BuEHWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iy7y24k9kAFS6kwqFi9d+lEVp5eISFTa0EclF0/HfRQ=;
 b=olujm7CDVjIZxZ46eGF16j34KPeSFjZqxXOt+sDLJDz5+gL3oe2m/TZDwW8wY/qEiOCxOuKmfAXG7cyfSQ0SyQlwkDIkjGZT27vb4Pjick5Ic+Kc6+Ol5M2G0kKrZZmLQ2/KGXNOaiOLP4xIrXeDD+OhpKoBF9WFL3MgwwDAG3M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3467.namprd12.prod.outlook.com (2603:10b6:5:3c::10) by
 DM6PR12MB2618.namprd12.prod.outlook.com (2603:10b6:5:49::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.19; Fri, 30 Oct 2020 06:55:52 +0000
Received: from DM6PR12MB3467.namprd12.prod.outlook.com
 ([fe80::791c:a3f1:47ad:902e]) by DM6PR12MB3467.namprd12.prod.outlook.com
 ([fe80::791c:a3f1:47ad:902e%4]) with mapi id 15.20.3499.029; Fri, 30 Oct 2020
 06:55:52 +0000
From: "Jinzhou.Su" <Jinzhou.Su@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] amdgpu: Add mmhub MGCG and MGLS for vangogh
Date: Fri, 30 Oct 2020 14:54:56 +0800
Message-Id: <20201030065456.23396-1-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:202:2e::19) To DM6PR12MB3467.namprd12.prod.outlook.com
 (2603:10b6:5:3c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jinzhosu-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR06CA0007.apcprd06.prod.outlook.com (2603:1096:202:2e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Fri, 30 Oct 2020 06:55:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 224bd29c-4644-4840-3768-08d87ca0d754
X-MS-TrafficTypeDiagnostic: DM6PR12MB2618:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB261835ADFF085F217DC73C4790150@DM6PR12MB2618.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EnYZkUdCgOZl0LEUiG+j6M9KVTW4Mg2gB11yxtZCeBMpCZXsvmMB6KGtlLmpI24QnblO9naw1tu3eUo6/TRWobxoxzI8a95EmCpR/DledtMy+8wBDgR6sRukR9vfi/BqSPkJDrgDwxn6NF/nFriltUYU6bklAR6zBqq2xxOzs/OR8F//24wIH+TkDcd+XNZg4VWGYITplA8bW4K74DT2EXNUELJe4yhCb5AF1sGvqSqSodNGDyq7WoeDRhTwgOxGkVV1eeKYoHiVxc8Vnmb5g8PrPfSBQftWU9yl33NsIlwUg0+KBpkAzKuPFywQMkUfhPC/+c+tanqk58O5sYWaVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3467.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(316002)(6486002)(8936002)(478600001)(86362001)(36756003)(4744005)(52116002)(7696005)(66476007)(66946007)(5660300002)(2906002)(66556008)(8676002)(26005)(186003)(1076003)(6916009)(16526019)(4326008)(956004)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: vT7fZgnAzBVRN/lRLtLF/AjK6LEN44jTLISYir2Q08P78LPwqmLGkTKCLMK8UGdVRRPwpOXaQhvDNoMrBYLqxpsqXlMXoPc4aLRMHldgCEUwdYhtEifVJYZ+SyMB1mxv/RXWG/uQwRhjrzz5sl4cU6hsb/CzP3T+xoyNzbxCFfx0CMked300VDmtoJMT1RmfsHhfv0jdxCcwYIcBS2Rw5p1EcbppEUQdM2rm7spWju6U606X2QR8iIe7jh7uAaoKA516Myc0mFFDeEavq8Q+iTBa0HX+H35NZ5k5HWHBfOf855cJNvhN50JCArEqySPQKBtQYUXNvq85VLYWatT6LfRF01shYsRbhHbn8chvVbK6z4lDHy9j6KdYD+D3mUMVS8GdgYZferz7WFL9qFqZFKvzvTP5IpRpbPykP90ZXPQzKYWeHg7EOTEe7ntoXt90we8hjt7vWodMNbSVIjburV3NuPNdl4Bi+K6sbYiuMpk0nmgePmkDdYDbMM9mvB+6ZrJkin4c8ErixuUukIqfrjcKmFrB5S73SbAlAiTSdRtum3fGAy8XqEv1ZEw3vfx+2nwasfDTFnf1h5eSFGzTtXtSXnLqP55eHB6zJ8rlie9fo8ZICtqX6r3kKEQWBjNHkN+wb2k6zgm1i2MHD64I5w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 224bd29c-4644-4840-3768-08d87ca0d754
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3467.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2020 06:55:52.5915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KoS4fEUdssOhT4xeOc40nLUHhzjpAegy9yVEVmOeQ4SJ2pvLIWNDi1sodQOQs30mzgLg90DYrKAgSlUDnw/2xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2618
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
Cc: "Jinzhou.Su" <Jinzhou.Su@amd.com>, ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add AMD_CG_SUPPORT_MC_MGCG and AMD_CG_SUPPORT_MC_LS

Change-Id: If58cc127a5b5b2449253af6d0f7f2522628639a3
Signed-off-by: Jinzhou.Su <Jinzhou.Su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 026e0a8fd526..1f8659a1a4cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -951,6 +951,8 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_GFX_CGLS |
 			AMD_CG_SUPPORT_GFX_3D_CGCG |
 			AMD_CG_SUPPORT_GFX_3D_CGLS |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_MC_LS |
 			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags = AMD_PG_SUPPORT_GFX_PG |
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
