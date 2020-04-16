Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F226C2BB55
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 19:33:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11782218AC
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 19:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hBOVy9n/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11782218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE3406EB50;
	Thu, 16 Apr 2020 19:33:45 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680043.outbound.protection.outlook.com [40.107.68.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98CAC6EB50
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 19:33:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geVj3lYGSSP4b3wd+EBJ8mgu9kviZ3dP/HL7ZHDzmEFyFcyXiHLiAPH7f9m1K3dQxECWECF0A1fiUnYRA07rdl3d4TdUg5T6eFyMt81UF+okx0rxqFnwkjNDqcvWvu5oir3mFV+LQkxKPwDHNON6HbZAk1UX7vh6ajrcA6s0gaGWr+ISlWX3u8odU/xI5OjDFTjO5w80tzA0cGGKDD6Il9eQGTxYZjinDq7jORxrOPXQh2qOUx0jrlT8fDw+yVXTcBAQ3AdnhTudFl3M+sCxRU2Uar1XA5LaedqN0keJYMgPE944WS9/A7cEZeOMxaOou9SGxYhDS6tJANskVVjEQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/7H34LK0WWnI620GW6c7hf2Wh5LonX/0njN46rN440=;
 b=D/ZoEX3zB0qwh+O7tsPVoDx8wIGpVXLhgkzMNRHu12YxqvKLzCnRS4giWZXAPp52lt39biIgnbUbqE6/VXk1gKgf5B5c5Xv71CyzZu5scoy69mr0L3ubZMRM0ZOnNYKw2RIowyov/MjW64rFOcQ3iYXE3x590ZdCIafLqZVpmtvJm+8DnwyUdM+Ve9lfLlCJuvYJEmRxn2XPJH4vMG3xFjCvhpjHQ0FNT0SwUXUlP+bdKVTnYjKt+qJT4bNQgFWj2J6a0beO5MtbBGcuSOIjY7WkEK8Fv3cxaKYHp+YTNsfb2AEPXfBOjgSjMoggqNF+FIfkGru4Qc+/gtL+/30Nyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/7H34LK0WWnI620GW6c7hf2Wh5LonX/0njN46rN440=;
 b=hBOVy9n/EVd9qbW08WcKymvdF0bZmI28pMDS8mpmJyvmZSXwOZn/FGHBkMppdyCb6cnT24adkykiPrKAzMN5WtMAO8yyA1TD/VpQli5l883nTZB9UqzWN++lw9gt0ZRPjehiOQg7sgi+2ACz4qwq6yeyU+4/kLUJ+b6hhbWK1hY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Joseph.Greathouse@amd.com; 
Received: from DM6PR12MB4561.namprd12.prod.outlook.com (2603:10b6:5:2ac::8) by
 DM6PR12MB4011.namprd12.prod.outlook.com (2603:10b6:5:1c5::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.17; Thu, 16 Apr 2020 19:33:42 +0000
Received: from DM6PR12MB4561.namprd12.prod.outlook.com
 ([fe80::357d:e89a:42f1:f492]) by DM6PR12MB4561.namprd12.prod.outlook.com
 ([fe80::357d:e89a:42f1:f492%7]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 19:33:42 +0000
From: Joseph Greathouse <Joseph.Greathouse@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: Add KFD interface to get ASIC revision
Date: Thu, 16 Apr 2020 14:33:29 -0500
Message-Id: <20200416193330.417754-1-Joseph.Greathouse@amd.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: DM5PR19CA0028.namprd19.prod.outlook.com
 (2603:10b6:3:9a::14) To DM6PR12MB4561.namprd12.prod.outlook.com
 (2603:10b6:5:2ac::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rocm-perf01.amd.com (165.204.78.2) by
 DM5PR19CA0028.namprd19.prod.outlook.com (2603:10b6:3:9a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.27 via Frontend Transport; Thu, 16 Apr 2020 19:33:42 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f8f07226-18b4-41e5-cb0a-08d7e23d1257
X-MS-TrafficTypeDiagnostic: DM6PR12MB4011:|DM6PR12MB4011:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB401127BDA99F4B142A41F13AF9D80@DM6PR12MB4011.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4561.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(5660300002)(4326008)(66946007)(81156014)(316002)(66556008)(8676002)(26005)(86362001)(66476007)(6486002)(8936002)(16526019)(36756003)(186003)(2906002)(1076003)(6666004)(956004)(2616005)(7696005)(52116002)(6916009)(478600001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lQfSPlmZ4cnr+OJBgb2giNgLu6GNEEhroO8L8N5F6nQYqRyUu7nq1R190+44IR5szmrBGM5NiTlMmAt75bE0WbxD5Aphs5qqS0hMkXCeiIP3dKJjG6zy8x6pnPwExPIQjujyeYf8Sgo/OgzHp7WdPvDA2/Uj8JsEHiWZkbelVZqOPbJtll/FBoVl0gVC5oSTVJS3ws+TwdOS98BrTk5ujL6ztYlvIahxt6Wq5tDYZZi7rM8ECu3W78jvyy/+Sb72A0+kBq4qPQ1LQc4yvQfEm4+48r8JGn98DqHMrrvZao9ZtrMoU720rLid1M3sncCCRoiE6dJo0ucGAtTjYjCJPEbs20RWxhPtOJX5jbYzibJS6lzy0uceN+N/K0ZkSzw1Y1vvVtJoVlUiXLxj5JFhYw0neWgkjZVFezO2tUAOX7TqcKiqLgEivOgYxu1lsItQ
X-MS-Exchange-AntiSpam-MessageData: zH7jp6ila/Ok+ruW65ihF66JWfEjQ5NPuDdP8+dGbIe1iF84cnkyGgQW8JnfsexWO12btSKW+Sm9O13TVQPy9won00FCzF+H6UQB2SaUWZiNsH8WDEd1K596bxhqeWxExqfBEo5E2TOJ3AXb9o9UDQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f07226-18b4-41e5-cb0a-08d7e23d1257
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 19:33:42.6642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVDsKeSxwdEIfiYKTZfkhD97E795GJaEYcigr2P3JugOPLjC89X95MQakEJHRfUh18G2CSSKvkfN1KvYmtzbIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4011
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
Cc: Joseph Greathouse <Joseph.Greathouse@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

KFD need sto surface the ASIC revision in certain circumstances.
amdgpu already has this floating around, so add in an
amdgpu_amdkfd interface function to pull it over to KFD.

Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
Change-Id: I745196129d65e1d0d4349f8d3b3f828df961a603
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index abfbe89e805e..ad59ac4423b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -564,6 +564,13 @@ uint32_t amdgpu_amdkfd_get_num_gws(struct kgd_dev *kgd)
 	return adev->gds.gws_size;
 }
 
+uint32_t amdgpu_amdkfd_get_asic_rev_id(struct kgd_dev *kgd)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
+
+	return adev->rev_id;
+}
+
 int amdgpu_amdkfd_submit_ib(struct kgd_dev *kgd, enum kgd_engine_type engine,
 				uint32_t vmid, uint64_t gpu_addr,
 				uint32_t *ib_cmd, uint32_t ib_len)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 13feb313e9b3..d065c50582eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -175,6 +175,7 @@ uint64_t amdgpu_amdkfd_get_hive_id(struct kgd_dev *kgd);
 uint64_t amdgpu_amdkfd_get_unique_id(struct kgd_dev *kgd);
 uint64_t amdgpu_amdkfd_get_mmio_remap_phys_addr(struct kgd_dev *kgd);
 uint32_t amdgpu_amdkfd_get_num_gws(struct kgd_dev *kgd);
+uint32_t amdgpu_amdkfd_get_asic_rev_id(struct kgd_dev *kgd);
 uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct kgd_dev *dst, struct kgd_dev *src);
 
 /* Read user wptr from a specified user address space with page fault
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
