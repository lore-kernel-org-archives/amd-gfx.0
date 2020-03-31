Return-Path: <SRS0=uap9=5Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60EFC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 10:10:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E99D206DB
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 10:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0BbaScwg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E99D206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 597CC6E5CC;
	Tue, 31 Mar 2020 10:10:24 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23F4C6E5CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2020 10:10:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NV5h58mIsj1z7SiEgTNlEhgaRn0h+3PDZdOfbfK9Aw76rEOPJeIDUuFE5oqY/oncecaO8XcxL1oLhiNrZHndfLtPhbpZt7TzS6odqETysyBHzQDet9YWW4HeqhfhSIRchcrZxUmyRWWuvl/OuEIJW6Fo9e+M//S2M/mc0aGwCeZRwuTSpApdZfUqRlVoijoI/5kOkAWb6XKi8R4vhIupdM3IWueoevBM3uYHz70RcWAesgK9n/le/O1rjinMn5QFUFzP4eCAzLjfB24QxVSwkceyAvV9DPKZvKIHKIg+6AqLSs67Fcox5LVVUF2WavvWnPiZzY7JHUGiC2bkwXTlKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWr2a40tg4Fdeh/gCU21FOx/W+NDNY6JIBQbxBHJLhQ=;
 b=Fbxq1LEgXXk0u8EgGULzE1y7zJVe+ksmPK3Wf9fkiqdRwSU9hRwWk41BZEZxIk1Alx0w4zvWEcqq4FTYEIAE+knQs5GCCz2wxnW4K9lbZSrsBYa5EfDcFTPRofhQIF4i58ObDWVZ+8MdaSE59C3leCgHxVlzBYM21nPSNzZiuPdqweAduomRHTuij6jBDposlAtw0hGGg5z6LaBjvCJvzWFG8VIcY1GbEQI4hQiJuOG/sRPD+GzCEdl3Tfa3Z/LWSwf23Ooe5q6ilZWlKLXLg9NJgYhmM5wxnLSA2Zkm25VNAd0+E9WeKAVczt5n+bM+pvR5i4zRbFuynfcaM8NpZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWr2a40tg4Fdeh/gCU21FOx/W+NDNY6JIBQbxBHJLhQ=;
 b=0BbaScwgg4E5aNTK1wCRDKR33nmmhDG2bWBDsJJl6F3yo7Y0fyvPTapd5bZ2RipwYJruOqp9d5yWeCoKPPF8QgV6vzNv/RYs590+EkUclv55N8Gb1bUOaJIwn/mQgZ6xebB6xphi7igsMDyLE15w+pxK7pY8cxfq2qMwZ+NQZeY=
Received: from BN6PR11CA0072.namprd11.prod.outlook.com (2603:10b6:404:f7::34)
 by BN6PR1201MB0067.namprd12.prod.outlook.com (2603:10b6:405:57::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Tue, 31 Mar
 2020 10:10:21 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f7:cafe::cc) by BN6PR11CA0072.outlook.office365.com
 (2603:10b6:404:f7::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Tue, 31 Mar 2020 10:10:21 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2856.19 via Frontend Transport; Tue, 31 Mar 2020 10:10:21 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 31 Mar
 2020 05:10:20 -0500
Received: from jenkins.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 31 Mar 2020 05:10:19 -0500
From: Yuxian Dai <Yuxian.Dai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/powerplay: using the FCLK DPM table to set the
 MCLK for DPM states consist of three entities :FCLK, UCLK,
 MEMCLK all these three clk change together , MEMCLK from FCLK.
Date: Tue, 31 Mar 2020 18:10:16 +0800
Message-ID: <20200331101016.2960-1-Yuxian.Dai@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(376002)(136003)(346002)(39860400002)(428003)(46966005)(54906003)(316002)(426003)(2906002)(336012)(2616005)(4744005)(8936002)(1076003)(81156014)(6916009)(81166006)(478600001)(5660300002)(4326008)(8676002)(26005)(36756003)(356004)(82740400003)(47076004)(7696005)(186003)(86362001)(70206006)(6666004)(70586007)(142933001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c1b262f-a866-42b4-29bf-08d7d55bb8ad
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0067:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB00674243CD9FA638B963A7838DC80@BN6PR1201MB0067.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 0359162B6D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ou0ZNOzitbY3UnW2PvSGTbMnafINjAszcDLa6hCmrV5qZAeJPpnQ6k5juvLXT2IQaAbUVzH2shDL3h+9sY1qRpwpK2AJZDZWC03Ihxh8ArFZymjjggkJqkKEamfdnzBf3VrWfmD7w4/apfxATjmlUa0GFeRZgE8Gr2aGh7jor4mr1ABIIoJfzjsMpsrdeL5HXV+Dqo08nDKl9lYLEsnOBtmHMCirOM4FpI/XX012cfscfsB37QChMO/dXN+FopEHR7dLkCnr0IlQ216joUd3w1UvVY5ONHfqvE7G5NGNe2e34E8zgi0yCu/m311dKSuUducLmqPEGB2jUywQwLKeAHfy6IFABsp/Bd2mcAtKgY2PXXnCVbGyHk36zZziEMAeArgVlWfSDtg7P6UAKOdziUWssYbXIhlWkvx6XuEBoUOvfhSNaECCU9+8oyWkg1O6kEkqNVQojvnXwYB73yX+JWcyAbVqH7wnFV0T1BEBsPKEjSBv+D/BaOvSc6OywTiGcoUp6KxlZEOKnnXdlsdxU1jkcLsATo0WOx5ynFD9f14=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2020 10:10:21.2871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1b262f-a866-42b4-29bf-08d7d55bb8ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0067
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
Cc: "yuxiadai@amd.com" <yuxiadai@amd.com>, Yuxian Dai <Yuxian.Dai@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "yuxiadai@amd.com" <yuxiadai@amd.com>

Change-Id: Ia45f3069fc7ae56db495cb5a3865e2c50c550774
Signed-off-by: Yuxian Dai <Yuxian.Dai@amd.com>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h b/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
index 2a390ddd37dd..89cd6da118a3 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
@@ -37,7 +37,7 @@ extern void renoir_set_ppt_funcs(struct smu_context *smu);
 			freq = table->SocClocks[dpm_level].Freq;	\
 			break;						\
 		case SMU_MCLK:						\
-			freq = table->MemClocks[dpm_level].Freq;	\
+			freq = table->FClocks[dpm_level].Freq;	\
 			break;						\
 		case SMU_DCEFCLK:					\
 			freq = table->DcfClocks[dpm_level].Freq;	\
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
