Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41B2C433E6
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 15:06:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A3FF65013
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 15:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3FF65013
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09B296EB9F;
	Fri,  5 Mar 2021 15:06:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB0EF6EB97
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 15:06:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ma7uWl6mDo9tom48YXYf1skfjbQ7Fm3+eAlwV83wTirQFdjp60M42JMHt8qPzJ3ClGmb0WY4pSpqDNTXw6a432nu4A6DWlGZsoYfOrPxtzTuBhOzDpPXRs5cMb1HFKMXgLFj+EkgoLj/FCK4y9LIzJ4WwQR6XQ0BgJOlF1KN7sTdT118s4LkanL3bZFa+YvoExqEU9F5+pYJtL+MN2i6HrbzySxUoXTODzO1/CuSs7vbUfx2UhtXkRr9AeQZwAHlvh1R8d1spya8aXuIvayb3hfQ6nS9xBkRP1MBx0LqozZn3SEMQBz1B2E5+LFIN8BdRuG8j3MLznqn0tcfbR+rfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90ycKuKEsdwgNFQnQsCNGNZsvc7Yr9HMh2zVdj/59vQ=;
 b=A513YdI3gB5DVyKQAoGBKhwoXX+dCMWCY2nEbaT5xvYdjd6PHY+hMIET/ZQKm6qNs9hewae1dyMsRBsQ3Tnd0zNqaf71EMGhBqIj/6SGktE7YYmvzZ46co0sW8IuPDulPwFqcZaQ9jTn+sgDfa5yNVnM5WVzV/KblNxeQeAqw2aBodvsznXXfOc5/yuSAGcl+X1IFHAJnlVewd0mTAELo5jraIDAona8wfXbC7pU8xA7UFqBDJnRG8PnGQy/ixI/X7ShNjRiNBujEhXfYA613kf5T6KlAAsm0i/gbCn5WRvc3jBlPCOuUJZpeZ5iqXOrVHc7nJ74j7jyRD+PjnHlGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90ycKuKEsdwgNFQnQsCNGNZsvc7Yr9HMh2zVdj/59vQ=;
 b=wvxi+/Qa6CDSZrCnuW5Zuqy+8KwFel4O/k9sqyturdlpHMcXWxlZwyE7xzEmbd/ixL1N67lfKmsXAu/NhtuWa6cSI7Ab14/gYdstRBiBOlpZQzXMRYPR5sSR38/Ct0jzJt8wM9vPl9wO85aUTplEOtpaPgVRhD+p2pL/yZTd94M=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1208.namprd12.prod.outlook.com (2603:10b6:903:3d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 5 Mar
 2021 15:06:32 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3890.030; Fri, 5 Mar 2021
 15:06:32 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 3/5] drm/amdgpu: use amdgpu_bo_create_user() for gem object
Date: Fri,  5 Mar 2021 16:06:15 +0100
Message-Id: <20210305150617.20144-3-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210305150617.20144-1-nirmoy.das@amd.com>
References: <20210305150617.20144-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.122.77]
X-ClientProxiedBy: FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::9) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.122.77) by
 FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.14 via Frontend Transport; Fri, 5 Mar 2021 15:06:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6a9acadf-4b2c-40c3-72e2-08d8dfe8430e
X-MS-TrafficTypeDiagnostic: CY4PR12MB1208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1208C1CCE18EBDD228920E508B969@CY4PR12MB1208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /2LOE7C+XD+Jak6thCPjum6jldvKc3SHHL2cgz8EUsf8KG/5SoRtUIsyFEPMD8uCf57374Y8dblzSNTu61Blm2lXJiiaTILDGh3u9pd+2GJRMSHsjuY+xliw/FIhnwkZtE64Jxl88q80CSegprCAyjREmB4FTJmImZo7eMeeC5Ng8itJULxhgCEpKJzDSdOAMWlWQm9BySAtzytpueNTEQjtEa/XiOa1XjHQzyJVgLrS80t7U1B8H8WhrCIQbRIqI6+EbEGRkZjgLYrZCjTmojVpS8KQL4RbHIOfge6lErBvTa4VNW1X0AvDnBInodPZGFJ5voU8eF+VyS+YtUwZ5iLAATvmYxWOHtoz6y5V7d20dLJMKjmyPC2F0Ar40Od8pV+1WaoZjl1ebG2RlAWE4odzhHSMwiKQGsh7uiYPlD+iZqZzyMw7naNQBxRw8rfgRpeHA+NPKNGHMbO3CpyMLW8Id8OlmMyrYh4SeA64AWTZPiQSu1yaJTDKC3sHobaWDKjtDGoEqI4ZKZE3TZqR2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(6486002)(5660300002)(6512007)(52116002)(6666004)(8676002)(1076003)(6636002)(37006003)(66946007)(316002)(66556008)(66476007)(478600001)(956004)(2616005)(186003)(36756003)(26005)(4326008)(83380400001)(44832011)(86362001)(2906002)(8936002)(6506007)(34206002)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bPLCLBQvmC9IY8aSnukqyYqgG/SYJ19mJ/396ivoLw5qY6/6+GyMN65xF0eq?=
 =?us-ascii?Q?61w6zLBKv/FwxWkI0gwUKaJ5JognZxHLArUailkprdwwsA+y//4NK8ZimqDo?=
 =?us-ascii?Q?5GYJypFEa+iHeVjKCZYYqWPz9vOZVXxjo5SY+m+dB/gUBDjDs2vfT+begvnT?=
 =?us-ascii?Q?7Efhkw5vsmgUNUU5qhXw1r+fHNZYMk1DMhFbbvG6ACJewbIYzFfBPcQ2AGSk?=
 =?us-ascii?Q?kkKUi1J9a4MspZb0Ql1Gdb24BTS/eLmQYu/2r2HYRNySgMoXmariQtXlKFme?=
 =?us-ascii?Q?zBr4a46XvbcK79zfWwIPAAYeNfzEpv9NNCUW/xq3G4IUJLo9BfUOoEmjNNaz?=
 =?us-ascii?Q?gbVmE4TuCsyIHmfQpIqWnML9QMUhroC2gFI70CDhgpjKGY149ckE9RhntMy9?=
 =?us-ascii?Q?Jn5G4aZYm6NVEVBkObMpsclq4Li2g6v3gXgETlQEK0Rw6wi9ySjk58+kmIEv?=
 =?us-ascii?Q?dgL8C3730EZjgATxBkxMte1vyg1vaZOznQ85bQMi+/098sKUvPsXLj3NqrNt?=
 =?us-ascii?Q?FGoOll17+HzFB1C/k7AYGRmIM11m9sqGqXv7JvdW97b5hGslim33ULXXVZDi?=
 =?us-ascii?Q?l+WAEpDSDMVIL3ZVXsC/+lkfcBwt8lzMrW0VxGT5Tbx2kM/CbBi+lL7GSz8V?=
 =?us-ascii?Q?g0r2Xn9MDUwseyo0fX5bri439AoMDDME6I/B0ryI6gonL33Z5Z9HeRnn3ODO?=
 =?us-ascii?Q?SvRNQ5MciV6TygGl3DRX7M42VPFytYPa4OOYFwMwCpnLyvlvJ639kxWj63QW?=
 =?us-ascii?Q?AKX/0KOvjQvUGd66eF5xPPFb1IuONtR6HWFaJZ3DL/F/uNqVdlUN7DFfVy6/?=
 =?us-ascii?Q?QYUr4/8hrlWU9HaRVimrzkaCdTyrEmPnvtIpPcZ+IWEC5bMhB0etIEy9m3OU?=
 =?us-ascii?Q?yYXPhn6LsiPImxB5bVVOfhlNagSw+xl0AwXFfs5dIaJmfE60sBPDC1k/ThZo?=
 =?us-ascii?Q?H38CMKQzePo2WnwsjuatAFFUypdtjk291nGsFo2GPDRi2WLRaBJOvZWXYERe?=
 =?us-ascii?Q?mMRCYtdaZ3eNQjFUUxoinvd0JNalcg4Z02TbS1xLfMhfJAKuI4ZEPMa9lns6?=
 =?us-ascii?Q?diUGJeicfPIkO96xhnB3Rt95g1sgqQXcXQ+Y1Lt772t66xRxMyXP8mPcjwMt?=
 =?us-ascii?Q?ZdH3/e41wuyuK9vSeHIUWrSboysShCQwhRF0B7xuQ2lDy87lf4V29UfE9lIy?=
 =?us-ascii?Q?414QRCPWJr03B+OAhFwYtIUEjbuRwrbt/WY6S7Tgn42ZFdQODXdhts0rcIGd?=
 =?us-ascii?Q?DXZzQ973YgkXNWHr/GeshU8F84w2EuCJIGPa4OFdV3YzoILavvIkDJU3qG5H?=
 =?us-ascii?Q?/chFzoz4ElxrxKysKly40IKd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9acadf-4b2c-40c3-72e2-08d8dfe8430e
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 15:06:32.6510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: csgNERCYMg/AtrKnCrTm2SUyGaxoSLfgFb0pRHa6I8OjtNhsI8sfSJJ2h7+V6q/DNUCN/p/iF65QuHZX33qHJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1208
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GEM objects encapsulate amdgpu_bo for userspace applications.
Now that we have a new amdgpu_bo_user subclass for that purpose,
let's use that instead.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 8e9b8a6e6ef0..9d2b55eb31c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -54,6 +54,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
 			     struct drm_gem_object **obj)
 {
 	struct amdgpu_bo *bo;
+	struct amdgpu_bo_user *ubo;
 	struct amdgpu_bo_param bp;
 	int r;
 
@@ -68,7 +69,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
 retry:
 	bp.flags = flags;
 	bp.domain = initial_domain;
-	r = amdgpu_bo_create(adev, &bp, &bo);
+	r = amdgpu_bo_create_user(adev, &bp, &ubo);
 	if (r) {
 		if (r != -ERESTARTSYS) {
 			if (flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED) {
@@ -85,6 +86,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
 		}
 		return r;
 	}
+	bo = &ubo->bo;
 	*obj = &bo->tbo.base;
 
 	return 0;
-- 
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
