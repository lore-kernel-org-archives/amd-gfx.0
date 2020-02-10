Return-Path: <SRS0=VWwp=36=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C94FC35254
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 18:48:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDB1220715
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 18:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wZUr1ogL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB1220715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 941206ED10;
	Mon, 10 Feb 2020 18:48:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 959796ED0E
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2020 18:48:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVn96m2AF0yv5jYZVXzcippjw/ZtfVCLC8UUmgRxi4L/y1JyOsWrpaFpcATleZGvb9oH6FeDIGphKQpsEQznEvBahvKqte5lzYW0MqH9lECs3deUaCIsBmkWjjcSe3i2OCq85rQEOXIPoEUioxDdqY57fcZxaoG8e/pTysLiTjU1lttoRIC8luqTXo9glUJQcJ5oknJwuUY4iUbX3CgL+Wftgy71pEzBywlwQw1qYblGrGpzZjpAw92Ze732+NiAfRNinBRcIVX00KOchf/MJ8hHnRgIoNNALgJnLdH6anjBqDp4Ce4HUeaQ+l2EGqMXLYPcJN1nJ/0N1nKgPyw8AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/yP510cqC5ez/Sr1gCyo5jnG2vKOF2IJhk6GYnUO5o=;
 b=loGbrgbuRGpOZatvgKLOSiUwcCz50vj3LYwiqOIXmQRLcOUDBVFEa3k8/87+ajA8B6Uq1L23glEMRnDExEzEIj90D24dL4m/Xytz5vvcTcSVQa0Ed3cIhAJ0+gd9QGpN3GZ8NtGrj5uOqzZwrWb7TW2dCZDUvWfYzQ7u5YhDpeJUUKJC1b2+LBYQVM513FBqCBBYAzz3poJ78YCcIl0k5ckHoWjON+GPOXQbIfpLg3BB/2EWwHSuMKN6GD0/QJq6A8iegfn/UKXbW5dtDcQqGgDdbvOMZ8fmnjWOwkfcXE2fuwotCJ6AJGmwAA3fRuwY3Usr5QiTrjomm1h6HLRVAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/yP510cqC5ez/Sr1gCyo5jnG2vKOF2IJhk6GYnUO5o=;
 b=wZUr1ogLi7SyOvpihoPN/b8bC1k1tAkJYPQBEvX9wFJliem7ERXCo3g3e/n10fA63g65b1CmN6Cm3b4p4iXrq/H1arI++Ou/733oqXM0g8pnZVdOKykW6/1RDzC79zyE+C8yKwUX2mvLKcL3qAJfZoe478BDSw9sbQ09uum5T1A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rajneesh.Bhardwaj@amd.com; 
Received: from SN1PR12MB2366.namprd12.prod.outlook.com (52.132.194.147) by
 SN1PR12MB2384.namprd12.prod.outlook.com (52.132.194.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.27; Mon, 10 Feb 2020 18:48:21 +0000
Received: from SN1PR12MB2366.namprd12.prod.outlook.com
 ([fe80::c6:3b8f:a441:6bd4]) by SN1PR12MB2366.namprd12.prod.outlook.com
 ([fe80::c6:3b8f:a441:6bd4%7]) with mapi id 15.20.2707.030; Mon, 10 Feb 2020
 18:48:21 +0000
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [Patch v4 1/4] drm/amdgpu: Fix missing error check in suspend
Date: Mon, 10 Feb 2020 13:48:04 -0500
Message-Id: <20200210184807.6271-2-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210184807.6271-1-rajneesh.bhardwaj@amd.com>
References: <20200210184807.6271-1-rajneesh.bhardwaj@amd.com>
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To SN1PR12MB2366.namprd12.prod.outlook.com
 (2603:10b6:802:25::19)
MIME-Version: 1.0
Received: from rajneesh-desk.amd.com (165.204.55.251) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Mon, 10 Feb 2020 18:48:20 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7e82ac59-870e-4bf2-87fa-08d7ae59cd16
X-MS-TrafficTypeDiagnostic: SN1PR12MB2384:|SN1PR12MB2384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB23847C1155E4A8A562F1CE3CFE190@SN1PR12MB2384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 03094A4065
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(199004)(189003)(6666004)(4326008)(16526019)(186003)(26005)(316002)(5660300002)(956004)(2616005)(36756003)(66556008)(66476007)(66946007)(478600001)(8936002)(1076003)(8676002)(81156014)(81166006)(15650500001)(2906002)(44832011)(86362001)(6916009)(7696005)(52116002)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2384;
 H:SN1PR12MB2366.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F1lvTnLreADIjiCgJZwyKPm5mE19hcbtrqAntdL0Rxo9e2Nb7DiiroyNcCgNzolJQG/ci+DHpSMlLRxwruDyC5+fRBH19FsMnyOV7THfB5Q6N8LBmY86bqIUVhWI+d3JM+fmdu5nYXpw+rIZyP+oIUDWgor7CfiRrgFNNcUV+bunyOmQUgTd25V1txOP5QgfvwfkGsw7yUvfRCe5PN3Q4+e6LNUOpxYbVDFFWqNWs7LY2VFqMiIBXh1OpEH//hiA/wF7MJPtbt25/2Ve9yrBNpEA+SBsTM84+NqaezwBCJES65kXywy8tUxEB2wfF3MF9pY000i7kr5VrkRzcbSiF3Z3OLh62wt5hir5SJwpmZsH6EFqx7iIST+CbZQmafFPGt3mNcCwKNtwvIeK9+I7MphdcnnNhBNoPzhZxeHYAbMk9cTGV9JMYAtbsR4E/q6k
X-MS-Exchange-AntiSpam-MessageData: nPIp4Wg7CQ/r94Kg99zfHvMij6nN5JoPtcu1BHyDfEYrtbt50kjW8V+2fDcyyxR1w5LD7uLTWEtRBpkjkH0j98YlMfOJybH7eqMpcEAOvtdGs5UYF9jbOlyQzER1KDYbw9VanWuk//vrRwVrSXn6dQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e82ac59-870e-4bf2-87fa-08d7ae59cd16
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2020 18:48:21.6290 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/8vw3SRUny7oOtwMzDYlHHQ6cV855OVSdi5iv3k6tdUJTS0GqehUfmRJBS4XMYeHZgbPiC2+hATRIvT+689rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2384
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
Cc: alexander.deucher@amd.com, felix.kuehling@amd.com,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_device_suspend might return an error code since it can be called
from both runtime and system suspend flows. Add the missing return code
in case of a failure.

Reviewed-by: Oak Zeng <oak.zeng@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 1a8659efad53..058ad0231f8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1236,6 +1236,9 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	drm_kms_helper_poll_disable(drm_dev);
 
 	ret = amdgpu_device_suspend(drm_dev, false);
+	if (ret)
+		return ret;
+
 	if (amdgpu_device_supports_boco(drm_dev)) {
 		/* Only need to handle PCI state in the driver for ATPX
 		 * PCI core handles it for _PR3.
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
