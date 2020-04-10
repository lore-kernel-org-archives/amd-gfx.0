Return-Path: <SRS0=F+/f=52=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C61C2D0EC
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2020 17:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FBC02078E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2020 17:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cfwlhSwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FBC02078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 031776ED1E;
	Fri, 10 Apr 2020 17:29:17 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760049.outbound.protection.outlook.com [40.107.76.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 805706ED1E
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2020 17:29:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3zaERwD2CM0SnS/A4BPVb3DpZGQiwPwVLynnRJf2DRiWugcDAKrD8oC2HAluOYGLH0eGuncg6j4a6MzmqU+ONfpAULBDEHnLHnuVLOrjlueMLub07FqDN7mA0cILI4aN27832iihY58EjNzor4N+8JqtyJH34I+/F5D1sUfZ54R5ZGzxEAkwAKNoLwajsqg/95aQr81bH8dDuJJ2FZNoJAruY0WKqI/eITF7pFg1Tbk3hzhCRjk/Hn6T2mLsao/C8+amz0T1dogfU5zPD+b9uiyXBLYiHw5dlp7VeO+djl1qGwIEm/ucTxJmixlf0Vtp7tvG/+j7BHCvq8a85h8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkDAUXPgQPoevvD9ZH6Bwef3oB2FuAd9gMubHiS5kNU=;
 b=cCNsvmzJLPoq+BhljwBJP9RZrrUGVl5Rdc8CtS4GXlfBafqi8lL0TLk2CRzetQz180bH14MVqgDAzxYihnkysllT98+f5QCRb/vONdjs38B1Z9eGLGsZe/PD9O6T26P3sSzCMgExmjj/dqJ5u5nEBc1IOwtLqLZ71xoKmyC6e9Qp+XYXTbRcXaXXSKKcprE+pam443TdDn9HY/onoUoqdnw4HRBPOZdNlGcuCB81cVvIqZN+CLymH6dASYVkFtJ87FwkL2bKNzQ9OYcw/1TiBeqYRnFbhQddFqcB1LwVqwH3hZTBWUR0tp5eUaFm1N3Qi5ZlVpN9B5E6SDZ/7TxySg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkDAUXPgQPoevvD9ZH6Bwef3oB2FuAd9gMubHiS5kNU=;
 b=cfwlhSwowR+yl3+7PjOYd9SKEoAFoqyiZgI1BhGQlwNQJATwolV24fyM4/+gBRPGUpSsvMVM6hJEQnFwmrb1gpWCE+lPlywDvuyNZtZ2VixcVXf6n9ISo3IfivN3QIDkxcozyvEXncAEixYgeURXPa4qlV+2gI/67mxwSOEcrVQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from DM6PR12MB3418.namprd12.prod.outlook.com (2603:10b6:5:116::31)
 by DM6PR12MB3593.namprd12.prod.outlook.com (2603:10b6:5:11c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Fri, 10 Apr
 2020 17:29:13 +0000
Received: from DM6PR12MB3418.namprd12.prod.outlook.com
 ([fe80::5064:5b9b:a52b:ab69]) by DM6PR12MB3418.namprd12.prod.outlook.com
 ([fe80::5064:5b9b:a52b:ab69%4]) with mapi id 15.20.2878.018; Fri, 10 Apr 2020
 17:29:13 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: pass unlocked flag to params at
 amdgpu_vm_bo_update_mapping
Date: Fri, 10 Apr 2020 12:28:29 -0500
Message-Id: <20200410172829.8481-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: DM5PR21CA0041.namprd21.prod.outlook.com
 (2603:10b6:3:ed::27) To DM6PR12MB3418.namprd12.prod.outlook.com
 (2603:10b6:5:116::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 DM5PR21CA0041.namprd21.prod.outlook.com (2603:10b6:3:ed::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.10 via Frontend Transport; Fri, 10 Apr 2020 17:29:13 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 821d006c-275c-454a-8daa-08d7dd74b006
X-MS-TrafficTypeDiagnostic: DM6PR12MB3593:|DM6PR12MB3593:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB359378808DD34564263A3D70FDDE0@DM6PR12MB3593.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0369E8196C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3418.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(316002)(6916009)(8936002)(1076003)(8676002)(81156014)(36756003)(956004)(44832011)(2616005)(478600001)(66946007)(7696005)(6666004)(186003)(86362001)(5660300002)(66476007)(4326008)(26005)(52116002)(2906002)(6486002)(4744005)(16526019)(66556008);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OEH/Il21pijoRVNFXg37eqgG1Odqim/4vhaYRwDqVgmwk9G82i/iBseXoRbXyBn8z2pzVBPP2H9cZVTatwLvVFDBq3l3nUEGqn8eU+oF0Clq1xV1dmHSis+Eq3/0mt7v2oXNAcyGsxAutC9wcBsrIcz6yW0KwTBxB57G1z7hx/RzhR1cUTq+OvpxKZ79iH8IEScQJ6OJ5KheBnSvvctXkl+07PSRR4y1cOPVLX+oHJwWA2Mcpsqy2hCyu68IvPT5BJGwoueEaRWNGoS4q3Zl+LAZ84js0d6E1UT4ExABd3mgnKTiYatgwvNVRNwPvLMOpLvE9+Ol70KF4tlA7Fr5jJuUfXlXBmZRtVyI6dfITYo/aajMad0n8RIzP2I20qwOkrTLW40fJCOiUHcK/nKeH2lYlzVEVk2tNlJOXTEdjTH6RB4f0Z3GsS8NTyg9dgoZ
X-MS-Exchange-AntiSpam-MessageData: m6kzfeMth2V1x2lGRa2SygIqT9otazjjHj5qe1bw4uyO7fY2HSK9ywAhi+VgMyCv0jIBvv811s8yn+V8M7waDXEeiRQMo6yGRkNJBxYyGPldIHi+mfx6a35GzX12mvyv4ePc8GocfXY152QQJQ/6fg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 821d006c-275c-454a-8daa-08d7dd74b006
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2020 17:29:13.8017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w98kkbE6gEEO/qR6iKjSEZ7viGov7uGAuPE92eV0X2zykdZlspI8xDkRySjDmwNKoXh9yJ20v5FcubQaKCntKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3593
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Pass unlocked flag value to amdgpu_vm_update_params.unlocked
struct member at amdgpu_vm_bo_update_mapping.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 4ca4f61b34ca..accbb34ea670 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1593,6 +1593,7 @@ static int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 	params.vm = vm;
 	params.immediate = immediate;
 	params.pages_addr = pages_addr;
+	params.unlocked = unlocked;
 
 	/* Implicitly sync to command submissions in the same VM before
 	 * unmapping. Sync to moving fences before mapping.
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
