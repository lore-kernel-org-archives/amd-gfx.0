Return-Path: <SRS0=jISE=AF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CA5C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 22:53:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB9D2073E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 22:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HEr88VXi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB9D2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44357892C2;
	Wed, 24 Jun 2020 22:53:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EF43890EA
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 22:53:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaHsGws1m6RIDwqQ/vum8tHIWr67B3h5alvKfW/oui4dAYmxoxl6JcdbCsB5pvasuCsWUjZSlhjN4uNZQgsQdUsQXCrd8pVkKWP01dz73oTMmAAQM4GRVum54+pIMpAacowEx70oCBLqPlKcsPLu1aHSIFdvhB17I6q/D7uDU/M/3Skq/X8WvDpmHARpbFjTA/KFBZb/ZiPAJGxUXgz2QNe93GuZcA/NFKhEp3xs+ZRdnpvXphOR9rtO+5q11u7XrEeYyKsN4DehFGlV/3cgSLcY4Gj0sobO0N1yOlEYlZ8zikGoYeUfmqACvPriIiyUkwlM9eAuUyHBUknLhhhbgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKL55PeEYLns2Rvb38T2d4FfOU1LC/wewWg/D1b7BF0=;
 b=T3ZC4zDOsWjUeGsXZ+BsbzrvQbjBNfD+oTie9D5xdF/+2yOyCJT0xrhI3QrRAmEGzh/XAY6s7EErhZPnEpxU2BcOEfJy45KL+V/PO8KgfEvS5fRf7sWdeHkMNDrcf3/BTD2Q/w403Ja9farLOr6uxM8Z9Vv7XISQ58e32OfAwDG31TkETJtU8LNgq8LLPJVe+DGnI9oE8I1epM4cFovJbGLhcmphJ1Fx8lI5sZGKO7zt1ZzOtgprQa7itEA4/cECfZMDb4+TrgSvADzlnJ+yU/2Lr3zKpkNxmgRzlU8Fo2RnXJ9EFzc4DHHz59Oz9SYnFWjIEKjCIk9sjLgpWi3hdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKL55PeEYLns2Rvb38T2d4FfOU1LC/wewWg/D1b7BF0=;
 b=HEr88VXiOtkGTuhfeQhHJCXt2A2ZdYoG8wkLq3ZKtK5rNMMqzRVkUeDMTNAFwDNdRMo1VnDWs5CGUc/nw3nnk3PgmyxQuFIg3sraAfCJbDuOZEj3qXFsk5aw2nBWC9oNalOLgBzsOyFvgtH1OBlUUKXaPuhsO8U1MOUfP/zlWMs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB4280.namprd12.prod.outlook.com (2603:10b6:610:ac::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 24 Jun
 2020 22:52:58 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%9]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 22:52:58 +0000
From: "Wenhui.Sheng" <Wenhui.Sheng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: merge atombios init block
Date: Thu, 25 Jun 2020 06:52:32 +0800
Message-Id: <20200624225232.7616-4-Wenhui.Sheng@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624225232.7616-1-Wenhui.Sheng@amd.com>
References: <20200624225232.7616-1-Wenhui.Sheng@amd.com>
X-ClientProxiedBy: HK2PR02CA0193.apcprd02.prod.outlook.com
 (2603:1096:201:21::29) To CH2PR12MB4101.namprd12.prod.outlook.com
 (2603:10b6:610:a8::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from HUI.amd.com (58.247.170.245) by
 HK2PR02CA0193.apcprd02.prod.outlook.com (2603:1096:201:21::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.24 via Frontend Transport; Wed, 24 Jun 2020 22:52:57 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 73bcecb9-5766-4f73-b4c7-08d818915708
X-MS-TrafficTypeDiagnostic: CH2PR12MB4280:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4280AB4AC3BF0102CBA8F2FC8C950@CH2PR12MB4280.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FB5UAIZygJSwYjPMz1sLzcHozc67Ij/fuZTK5Dp15eJ711hTufAay+8eg/C4Bv4/RZtGueVtFFFGBlcUbxPdSw9qvaXEbVTzxsgjLYpPIv1qntu/AxSgCY6qBpYPrc4W8uNd+TciAvVAtWif1oWKjzmU6m/9JfxPwShgt6ngNIeAPwrVhCht99rejkGauVjidzvF+r0UDrykQTXh43Xg63+JBpOl+4012XAs/sysJ4c6v4ZvGizo6mXCStFUHx5qaPYZ/hBqAh4K3w1/fDbUbHNcoXSmvkBtbX+wLSOSTwb/4BsDCX1FevC0BkcLBIumjbqEI7UNZ9eHlmPzXmvxAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(66556008)(54906003)(83380400001)(66946007)(4326008)(26005)(36756003)(16526019)(478600001)(2906002)(7696005)(186003)(52116002)(6486002)(6916009)(956004)(316002)(2616005)(6666004)(86362001)(8936002)(5660300002)(1076003)(8676002)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: sDRK1diakG9i00CRQP1CvKs+dTU/ikanAi9YT1gCNNyDVKRf6u3ougc/n3PhRPdGkj1BcwnwVhN40Wy6d0560rEnJfm/4XtOkd0lLXw8t7ydF/1/6blI5om7P1NdNbd9acMhAM9g3i404N/S5V52+dK/d+gc2n8WMteL3Jqk8HH1aO7oVQb6iD6z6sZfRtcSidV8x9s9B4TLkRa9fBcRLCBGsLq3E6urfb/fesMhp8YuaQlGgZNjq1yDjizGqqB51mYuzsknC2M5sfYf+XxlcsD1ifhCotkMdTze+jdagY/VBGZ6VtUB6l8srFxOb7dXR+wmnrbpJwR0K5a+cTE6Vxb764OBHEKxdhGuAjHYreOsNI1rUmnxG9TV9seqNAhB4t4i1woRq2nUktvRbru4yrsQjE8KTQK/1Kc8EpXO7aVnmqOB9ON1K5YBAQPV9UKWvTcO5vOE4G6gHwCEB6wP/UUqhicuSNLeKPbILrLxNwySKAgxDIEc58INkiozXe6F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73bcecb9-5766-4f73-b4c7-08d818915708
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 22:52:58.3757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETfDwSZoJ7oamliYZwEH0czM+VYJGwlqQH1A04zsEpjnXUMGzn0KcB9tadoc6CLk8zigVdIHaU80RIxZPaB1mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4280
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
Cc: Wenhui Sheng <Wenhui.Sheng@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenhui Sheng <Wenhui.Sheng@amd.com>

After we move request full access before set
ip blocks, we can merge atombios init block
of SRIOV and baremetal together.

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 23 +---------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 138ace9c28d6..f40bc6b5be82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1723,26 +1723,9 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	amdgpu_device_enable_virtual_display(adev);
 
 	if (amdgpu_sriov_vf(adev)) {
-		/* handle vbios stuff prior full access mode for new handshake */
-		if (adev->virt.req_init_data_ver == 1) {
-			if (!amdgpu_get_bios(adev)) {
-				DRM_ERROR("failed to get vbios\n");
-				return -EINVAL;
-			}
-
-			r = amdgpu_atombios_init(adev);
-			if (r) {
-				dev_err(adev->dev, "amdgpu_atombios_init failed\n");
-				amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL, 0, 0);
-				return r;
-			}
-		}
-
 		r = amdgpu_virt_request_full_gpu(adev, true);
-		if (r) {
-			amdgpu_atombios_fini(adev);
+		if (r)
 			return r;
-		}
 	}
 
 	switch (adev->asic_type) {
@@ -1855,10 +1838,6 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 			if (r)
 				return r;
 
-			/* skip vbios handling for new handshake */
-			if (amdgpu_sriov_vf(adev) && adev->virt.req_init_data_ver == 1)
-				continue;
-
 			/* Read BIOS */
 			if (!amdgpu_get_bios(adev))
 				return -EINVAL;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
