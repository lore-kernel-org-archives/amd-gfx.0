Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DF8C4708F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 22:59:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51A856100B
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 22:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A856100B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D0C789CA2;
	Tue,  1 Jun 2021 22:59:27 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F80289CA2
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 22:59:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFMurWVVGXqGPdbjF2u0fO5cDZbmnMHdJMHDJz46Eev6VKPXZdHkz1o7APa+s593knmDiNqEFVQZOaPkHe6ZxvnhgQIJ+oqfxcKgxtdifKoFAtCbESjU10Mp46vW8m4tu/41cCJSev69YoDiPjmfXd4YBYm4AMEB4p+Jd3MHRBoN0EVDwh08NgzS9rW9+8gQJPbo65c+Nvl1tq96jY2DZwqV8ZGaedZlSvUYoJ5gmvUUCx3L96YkRKTw9gzPDobuL/5h/7Rc2Bzrp4GLBC/bT+7dY3z+GrY6uxUmMSLRFN8cYoAMnsRL1eouTXWOsGYOAGSbsoDHqnyCyng5BavoyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EId41Q+7cycxv0pu1T6Wyh3yLWO9w+ukFy4KrVhLzTk=;
 b=QQ6sfJE3hcPV02gyXj5owAEwjZGwhGxNH1Fsx/VHWDt+ftSkmS1WHNS/ybRQpjmatnodV/JPkd/iTVuKfSVO8Rolb/p0sPYY2vknMvA12Y7va79PuVrgHnIUkNQMr+LPF2UPmgxxhM4aWqs1j2Ho3gpNPzTYFe4fldFu9WOG2lm2fF7456rg1XpmN2Qh6DizU2m3oAGE1G4DyS+q5EWnnr0fkvc1iGJ17y8TFGK4pgcoJVcH5EqNB113Qu6Rz82Y55t224t0vYfRp6RtTmw8gBlKl7HBoIYaZmmKLxckz7MWyue+xDXSc7UvexEYDuDzLU0Ba0npcAve8iEbYbtZSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EId41Q+7cycxv0pu1T6Wyh3yLWO9w+ukFy4KrVhLzTk=;
 b=T58SusMgESKhmnD2YK468Q8oB0nZoctUrpT7C7IfZOmSn5H+ikCVwftQYaq5tJCD3melAUbMT/ePWrVDMnSJwpthi4HD1hCGodQ40MUi0Qrai2tvJT5g31/lJpDoVODV69vlZ834jz6KP7vvi7yEtZQY4G2o4OPIOWck+8BEeR4=
Received: from BN9PR03CA0247.namprd03.prod.outlook.com (2603:10b6:408:ff::12)
 by MWHPR12MB1885.namprd12.prod.outlook.com (2603:10b6:300:114::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Tue, 1 Jun
 2021 22:59:24 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::d4) by BN9PR03CA0247.outlook.office365.com
 (2603:10b6:408:ff::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 1 Jun 2021 22:59:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 22:59:23 +0000
Received: from eric-HP-EliteBook-745-G4.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 1 Jun 2021 17:59:23 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdkfd: Add heavy-weight TLB flush after unmapping
Date: Tue, 1 Jun 2021 18:59:05 -0400
Message-ID: <20210601225907.749049-2-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210601225907.749049-1-jinhuieric.huang@amd.com>
References: <20210601225907.749049-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 208e4133-cf88-4c62-e031-08d92550e628
X-MS-TrafficTypeDiagnostic: MWHPR12MB1885:
X-Microsoft-Antispam-PRVS: <MWHPR12MB188556732231FE953C778EB5823E9@MWHPR12MB1885.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:302;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ja+TIHBtnHMPjf54OX7YZ81WqcKAjx6ndtLbPGh/t1emPR0aT4nx64NrNM4qdd8yBdKtRUDiff81O3o/pIj0rLE+TT3ARz8p7NbL2wTm1lg+TALfSl4hZyvHZVMxsIpk1OhDD67OgWqVuBwr5vRSJ23ns7+P7VRqjVXzrZ3hNnknMZzDrmdlkMJkCoYwmjhdsaWrmN91BHMU6FymJVQNRWgNzsCUWOngJAk1XC3tOT2wTdTfz5Ld6W3eLBf37epdJRQf0Iz7dkRil80lvhE3tt0mqu7nIJr+vMG8ipQzM+xNElivYgqu1bz1g8+AqxbR4n5y/by8M+fjuDimfZKs2FSzxrZRWt0FKLkHmnfzY9r9jhKJXALZZPkNk6Avhj2iJGukbbaRNzuNRa3SqfF/OnN6anDhn0wIPWH2tuTB6uqDZZWWxHYYJE9DzdGeAIgaytXIvZt7wHLDpUgoMoUgdvS9KT/YwI8MwT1d/m/IWpUbe4wVHrxK4bf30Fcg9UpxeVsg8USBXEUfcN4K0tfWoQyE2SIGc4z/GIVeQAMdyNZF0B7XZ1N7vLv8vFA7OUq2V1X/ZIMZ1U3GwDQgdW2ZhqATXHrQidj1Ja0Gt5iz/lVoHQbYerXCTFfqMTjaHS5iW5j2hHH7udDEOkXwH8Ph+546+JsXmf6EY1RJSSkLxegjDH6AKSzJKIvIFLG95h+QIdjIlexz3DdXm/eDFscVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39850400004)(136003)(376002)(36840700001)(46966006)(5660300002)(2906002)(86362001)(6916009)(82310400003)(336012)(26005)(70586007)(8676002)(478600001)(186003)(82740400003)(316002)(36860700001)(1076003)(8936002)(47076005)(2616005)(6666004)(7696005)(83380400001)(81166007)(426003)(36756003)(4326008)(356005)(4744005)(70206006)(16526019)(16393002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 22:59:23.8251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 208e4133-cf88-4c62-e031-08d92550e628
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1885
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
Cc: Eric Huang <jinhuieric.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is a part of memory mapping optimization.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 4da8aff3df27..98f1d2b586c5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1766,6 +1766,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 			amdgpu_read_unlock(peer->ddev);
 			goto unmap_memory_from_gpu_failed;
 		}
+		kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
 		amdgpu_read_unlock(peer->ddev);
 		args->n_success = i+1;
 	}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
