Return-Path: <SRS0=/bSq=5R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88005C43331
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 12:12:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EEF9206F8
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 12:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XSApi6W7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EEF9206F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C24456E92A;
	Wed,  1 Apr 2020 12:12:50 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750051.outbound.protection.outlook.com [40.107.75.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B56966E92A
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2020 12:12:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aefgJlNU8oeIVyKbTCr0tZD8SHb2xnpnbv2Er9D1pmmkj/5G6l0uu716js22keGmARBffZ1WYN3+8W3IK1FRuW5el7iLeFzfmwM5wgIdsH9p9+A6mrEyNXFCQsmHhIsSHZ6YfuVNysHsb8Z3J8WzuJWHNB2ZynBPzD5Qb4xl1llC5WrbDi3oVrP+dEp4vD/NDTISN/k2vnG+RCFUtg4WNnUkYCyejLpL24R3/ZwrvXktB+d/dyUBwTJNhMD1X8ASyDOcX5J1Qo43aDzbuUXGF8n7/AV8h1Omch7mKGETgi+z/g4OZgb/NfzkbPqV55DS0vzqxoQtBxUd7Rus3EWZfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWbt+JK3JzcHFVx6rJWXPPsyCObus7fqQ6ZzgqQGLpw=;
 b=khWUwtYbHql2L8cFbP/xD383KVkl9jF1TcL9TuWDAPyTD95AkbycajjScGUbkAX5GsGOpAVjYRQNqWcAWKNMc5aySQmS57SzBsHEoe6vHLras9qHtVnMG2mHJkIqZePb7sO76EP4k3NTX1CXJnexzwzWDC2y952vngi+jf9toWln0WxEHYiGmyCYrA3vYYyGBgGrqutFPf5LKtogKOBWaDdnswTdXjRLwX3HN2OArgevFjVmj43Y7DkwiNRqyINTtI9KvCtJt5paqHc4IAVeSdyTmVVJRFvC4KGTCkHpVe9Md60JAxgkLHHNFXLQ6wPs2T6nriDiTdsH/Avcmz+rCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWbt+JK3JzcHFVx6rJWXPPsyCObus7fqQ6ZzgqQGLpw=;
 b=XSApi6W7NNFFuKTg6as8gVY/wnwaQ0OJ6pcHajcAf2NKygaWeteP4E34sPnKqmAk5mkkOZgA5xUAj0c4N4QaEm/wXA82F5uAwwZinCiqPOdWIgBPTCKw+IByyemq14ThtOtdt8kXJD52qjTvY2dw0FGmOzOmQi0ouYCCZ8lBRqI=
Received: from MWHPR13CA0027.namprd13.prod.outlook.com (2603:10b6:300:95::13)
 by BN8PR12MB3572.namprd12.prod.outlook.com (2603:10b6:408:47::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Wed, 1 Apr
 2020 12:12:45 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::bb) by MWHPR13CA0027.outlook.office365.com
 (2603:10b6:300:95::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.12 via Frontend
 Transport; Wed, 1 Apr 2020 12:12:45 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2878.15 via Frontend Transport; Wed, 1 Apr 2020 12:12:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 1 Apr 2020
 07:12:44 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 1 Apr 2020
 07:12:44 -0500
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 1 Apr 2020 07:12:43 -0500
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: kfree the wrong pointer
Date: Wed, 1 Apr 2020 20:12:40 +0800
Message-ID: <1585743160-30110-1-git-send-email-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(39860400002)(376002)(428003)(199004)(46966005)(2906002)(8936002)(478600001)(186003)(70586007)(70206006)(5660300002)(7696005)(81156014)(426003)(4744005)(336012)(2616005)(81166006)(8676002)(47076004)(86362001)(26005)(356004)(4326008)(316002)(6916009)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6df5a011-9ddc-48e5-8968-08d7d635fc99
X-MS-TrafficTypeDiagnostic: BN8PR12MB3572:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3572309A4CAD3538A1C42173BBC90@BN8PR12MB3572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 03607C04F0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: frAeZyvZYR4s9sf56TqutN+n8mTYVRXBKu9L+g+FioSnAVIgPohhwUVQWOe17CIhy3nxFdgEt3DEWjdySF2gXzFoJP37TB7bXi+TQeyc8vDZ7MH2zpGDNvudtKo0p9RsEuljiWU+nM78ScOjxGt7zmTCUN6xvrZYTGqT8FOfJP9q6+AtakOKj85GEGywkZRLCAWBeovkCU7444NDaqsrRUMJ1kdhmNYl5LZSxSM2A26oxClNxbXORozIN8v5gx1De61soHsdvO9XbwQfr/CiKkIU4b+84vm1ffczwOalwlG6XOhwOVYVzKapfoEdZvfPCkIZabeshTNzTHka7Yi7sg9cMAbQl6Z+xrH1Dc6twlQScC1++FfXa681n3fg9IzM1Ux/mCi6+D/tG2jFO8cl+ewccfmZwi3XTR+Yrxd5OxaJ/IksMHQNvayG4HIncPP+jCdZwBewiF7RFKd0vRZpn0rnBVAOwhV1EIlgyujDF4Mf9shB5FegAhxNDpuhPZdErGF6MZgvL3O36qhwGRQdKQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 12:12:45.4116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df5a011-9ddc-48e5-8968-08d7d635fc99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3572
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
Cc: Jack Zhang <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Originally, it kfrees the wrong pointer for mem_obj.
It would cause memory leak under stress test.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 7866cd06..0491ab2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1134,9 +1134,9 @@ int kfd_gtt_sa_allocate(struct kfd_dev *kfd, unsigned int size,
 	return 0;
 
 kfd_gtt_no_free_chunk:
-	pr_debug("Allocation failed with mem_obj = %p\n", mem_obj);
+	pr_debug("Allocation failed with mem_obj = %p\n", *mem_obj);
 	mutex_unlock(&kfd->gtt_sa_lock);
-	kfree(mem_obj);
+	kfree(*mem_obj);
 	return -ENOMEM;
 }
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
