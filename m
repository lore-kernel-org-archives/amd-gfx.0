Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6800C34022
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 04:05:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D849208E4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 04:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CnCmg5fV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D849208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFBC76EB08;
	Wed, 19 Feb 2020 04:05:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD2796EB17
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 04:05:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQ8PkYL6sZbR3MoE2kmOiVozv1pZ04rOdVtYdRbIve03lUDYye2R5VSvAP96TFyhmqDZnjEoKzgqEXgYYyJtlGmxHv56sQSFodAJEqyV0CDFlZYHQz7TxfOjdBzqXtboWLec3gJnwFd7NxmgquoWD0szuQuDN5Tne7ss48WUg1//GLVb7KEBtv+PaC6hwU4bcMYvi+O8oBb5KgYagg84rJAv2XxZub7v5Jkr2fM/hTeijuGIhnyF41OC+yLyR6oGfRPtMRJ337BmwCVL8bCM/hXW/4G+OS3aMLVH1agpcSChynst1XJpXQ62Bz4eb5aR02NBwkzC0HjO5Uhai9bAuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWrjMNXeDDBq10GhC+cJynNLyOZHzYUFUi3cs98whcg=;
 b=l70olBx/bshQpesOx58jKe6YCPHn2G0ESFRxut/brl9NDgJlA2OvnkNh5McfzH6pc9UJ9L9lSMW4+n0DEjomZCB4733HT7oCTu2jjwIjOpgeYr+zJVUl3APUnwKe8u5OiL6ke4fk2DlGmeetiT4vM26MJHwhn9mLAquEO9XsiAQzfjEQLyqiuHWf4E8wGFKJGePhiXFwoQW5cdvpOJgjPoHpjS2NDeuno8lLms8W4LzJpYnU0tv5KYUO10eekUaCIe/hqhGq2q8dniJukzZd9z3iOPmEkdtEsNSnRciZRxjRTbMuv5z3KN0mY9WkPilO54vJbb4UEwTqmXBcD6NC1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWrjMNXeDDBq10GhC+cJynNLyOZHzYUFUi3cs98whcg=;
 b=CnCmg5fVZDDIkVoYw/D355rnyzgp0w9E6vHmw5s7VAAtM7+rm6MUFrQkeIzVG1SM4j7djbhUYZHeKeaAYIAfq2fjXaeiO7C/7XHKNGIuoClsYO0r2sdTGoOp+foKqwffgWWKajO9oXtjNpjiUyPQTVguyBh/Rv6YKqjiY4HiTrA=
Received: from BN6PR12CA0031.namprd12.prod.outlook.com (2603:10b6:405:70::17)
 by DM5PR12MB2502.namprd12.prod.outlook.com (2603:10b6:4:af::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.23; Wed, 19 Feb
 2020 04:04:58 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::205) by BN6PR12CA0031.outlook.office365.com
 (2603:10b6:405:70::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend
 Transport; Wed, 19 Feb 2020 04:04:58 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2729.22 via Frontend Transport; Wed, 19 Feb 2020 04:04:58 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 18 Feb
 2020 22:04:57 -0600
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 18 Feb 2020 22:04:56 -0600
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Tao.Zhou1@amd.com>, <Hawking.Zhang@amd.com>, <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: fix a bug NULL pointer dereference
Date: Wed, 19 Feb 2020 12:04:45 +0800
Message-ID: <20200219040445.11112-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(39860400002)(428003)(189003)(199004)(81156014)(6666004)(5660300002)(110136005)(316002)(478600001)(81166006)(4326008)(8676002)(1076003)(336012)(356004)(426003)(8936002)(2616005)(186003)(36756003)(2906002)(86362001)(6636002)(4744005)(70586007)(26005)(70206006)(7696005)(2101003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2502; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b748ceb-7b81-4889-d0c4-08d7b4f0e2bc
X-MS-TrafficTypeDiagnostic: DM5PR12MB2502:
X-Microsoft-Antispam-PRVS: <DM5PR12MB25024C2460B1BED92EFB30CCED100@DM5PR12MB2502.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:154;
X-Forefront-PRVS: 0318501FAE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kVa7lKiqPJjWXz1cbORpdPPy759sYCwgwqeHmUtHmv81tTOeLqcxwU3dV+m7pBSHqNRRtSHlOY2AwsEsKEYwAV4ME1lmSUhRUnXOuEJ7SEngMOJbnE8fNqtICYT4pYQRP3xTGSXpPf21CLjTj9T+7tz6abkXofRl2jJPjlFcJtTzGA4ZH3p9gT2Q4waVunGNiMOTGQkruei6kDGFUavvrbKVsgUnl+AL/Ci2XWf5RiMwpuMmWHyKpTDCco3ZWbmwlzKXOaDdOHuPiEChcWwN6PWlJ4cf6rL9yZCiY+khy2VplRjJ6bK4nW08y5TRMhR3Ojf4sd+SSnE84Njs8G92LCPR0slsCTap1byLvczfCtW8rrtJvm5CAk7x0+lPl2qBHLQLN3tO/vXi6/YtuFeurUtKOhAo48bYoS66Z7BW5mzNDXSiIe/EZVnNUr67sHRXRTiqB83s8YbrTyRZaFdk98g2kbWy94Jedb1C6/CmTCM=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 04:04:58.4479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b748ceb-7b81-4889-d0c4-08d7b4f0e2bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2502
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

check whether the queue of entity is null to avoid null
pointer dereference.

Change-Id: I08d56774012cf229ba2fe7a011c1359e8d1e2781
Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 4cc7881f438c..67cca463ddcc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -95,6 +95,9 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
 	int r;
 
 	entity = p->direct ? &p->vm->direct : &p->vm->delayed;
+	if (!entity->rq)
+		return 0;
+
 	ring = container_of(entity->rq->sched, struct amdgpu_ring, sched);
 
 	WARN_ON(ib->length_dw == 0);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
