Return-Path: <SRS0=Kvqq=AK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECF4C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 06:08:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65E3923128
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 06:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xQoXQQ4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E3923128
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1199089DBA;
	Mon, 29 Jun 2020 06:08:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E504489D52
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2020 06:08:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkkJMJL83LSQSvI/+OF6SECJq4+iNp0GrjlWqHNspk+w1CTGo/Kb9/MWSsEll3N1Kqgc6Qu4x+x/kCEq3CvxW7jB9ZFtDRl8NlQOWN/CoNWyGCPao7nv2oKPYehy4pvixKRtltiRnHPzYhTgSBWvmb50PwnaGXxySuka97Oq7Ewvp7qMv+Cx1rPBIcXw6Evndyr8HLgP3Vb3U1Mtqb+KosBJjPMJLbhIi/k5Pc/RLhHRg6BfLZ1sW9EjAs8OQ2FVABeKAVcSz5W9gxt6kmDgdGqtvWpNTd/06s7PkWD5HxAn/GOTGqeg9TGaJOUeIWHVdt1Mys8BZagMcHzkhiTBrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNRjtKqL3vkPnL7qD6EGOVMrzqxWcID0Lunmzdr8UoU=;
 b=SquJdegiV+4qFw/yayHuwuEm3re9XaFADq5A4lM/m1qbQ4CusIaC/ul9qfb7eh238Z0Mfg9G/od+23s1Nfn+igDp4Dyoit8rQdUHh44cAbZcASY55N8fGfhlYxGCU2QriUxgV+1t+UKLKO9IL103uawPGyw36D0kZ5JIDcXsuM+81qnjiAV/8nKPB6ZFfB5toml/Rsz6YyFCZP/ftNL50eKAoMDznnr3pZ7v6h1QetMb4fq2d4Yydri8BoJPDraWE0TKo2OMMb3PmPFa5QX6KJNL1+umRpndDClMebnoIOe+9Q00T1xSB74WMYzPkVunUYK9Mnji5hmIs7MtW+1GSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNRjtKqL3vkPnL7qD6EGOVMrzqxWcID0Lunmzdr8UoU=;
 b=xQoXQQ4m8qYW4FFtSByiLaQBpd+9dMcBqv4PVq6ZnKl6wNMrs8serrTzfEmAzUvjqCoDCc7L/RGlG3niztFfl0p1nJjo8i0EMYs4b/AjLIgTF+2nIdhKqL57Jpte1fF+gW+4Alg/LS5DuL1InL/PV2kKwe5GppmeLzHsbs3JKr8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB3815.namprd12.prod.outlook.com (2603:10b6:610:2e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Mon, 29 Jun
 2020 06:08:01 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%8]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 06:08:01 +0000
From: "Wenhui.Sheng" <Wenhui.Sheng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: correct discovery_tmr_size init val
Date: Mon, 29 Jun 2020 14:07:46 +0800
Message-Id: <20200629060746.21697-1-Wenhui.Sheng@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK0PR01CA0059.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::23) To CH2PR12MB4101.namprd12.prod.outlook.com
 (2603:10b6:610:a8::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from HUI.amd.com (58.247.170.245) by
 HK0PR01CA0059.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend
 Transport; Mon, 29 Jun 2020 06:07:59 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9224e8a0-48df-4124-fe4c-08d81bf2c6f6
X-MS-TrafficTypeDiagnostic: CH2PR12MB3815:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3815D32C50D1159B8D9436C88C6E0@CH2PR12MB3815.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TugIylPnJLsQ0qS+NNy+gz8PyLMPtZy8VN48WUbCbpT0wA2yHjUbl2gk+l860z5slq2ONRo+RtXoExAHg/hrsLKx4PfY3lO/KwcQBDbO4H+Sny30aUbeo2v8PigzIwp2Uh35v1OOmt+pz0oBunkcJiGLM8Qop91yYxylgLtdOthGmfE3ULENrRQ8XSOcyTYQNPmGL5++1D71CcHmwVm6QlPeI+5JjwJLe+8nb8gmsQYq/TVSpivLZCBrISOc89EOUcHFUplt1BJP74x+PNzDEMq1LYFBo7iUC/Ax4kzFoNA2yLhfKE3g9lC92M6ju1ysH5dPJyl+UQPkVxvTyAw1Ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(6486002)(36756003)(83380400001)(86362001)(54906003)(66476007)(66556008)(6916009)(66946007)(5660300002)(316002)(478600001)(2906002)(2616005)(956004)(4326008)(52116002)(7696005)(1076003)(16526019)(26005)(8936002)(186003)(8676002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: UYIwN57dT1GjCRcA8PPrNRZ/v3Ir2DKaIsE3uVizdoJGIvRazlDQF1HimGJ7nJjAQdFXMktZS0VFVhJ1hvX6KI+mnKYXk8lIo2vkM+gwscnsLWW4345hccMuLKunkEugdSGRW5FXpmy9/9H4vngLAFJ4nrsxr5Zyl8dLNk3dPlG+2GVhKQS/W9u771MSphWmrP5ir+1RzLrR7PqjWqUmn69zU2mXVC23j4S8UuTRE+EUa9nTT0Gag/9uxrHIh4dZGX9pnhqg38/B20VAQqit80vnhi/y8d4KO8nQ0NDiS6YZifN/bwrKg1h4j7ApSTR0+5vDi0AffUSXh/nn5+hlablbEbUdRp4peCm7bYPl/E9xoouxNlcoJq/R7tRzbocwM81VKDVxAihhvx6qRRyvKqv09rAgHAgb6Hu1tHHE/Z2IwugUXrnGGtoYrbditOnqUnAMPXIDKkT+bWtiP9RY9dCxXhS+dNm1VZsnIYJOg70=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9224e8a0-48df-4124-fe4c-08d81bf2c6f6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 06:08:01.0401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6uEXT9BoNYvrP4uSqlddtGjjomhpjV/4z+t716/rC/BKT5KLiTcapDB1l5TUQxZIzTouGsuYpSc4hfowGP3UmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3815
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

The legacy way to initialize discovery_tmr_size
is using DISCOVERY_TMR_SIZE, while after we reduce
DISCOVERY_TMR_SIZE from 64KB to 4KB, variable
discovery_tmr_size is also reduced to 4KB, this is not
correct, it still should be 64KB, discovery_tmr_size
will be used to calculate ip_discovery reserved mem's
start address and size.

Using DISCOVERY_TMR_OFFSET to init discovery_tmr_size instead.

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 7d51768684dd..56beafbd3ab9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1872,7 +1872,7 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 	adev->discovery_tmr_size =
 		amdgpu_atomfirmware_get_fw_reserved_fb_size(adev);
 	if (!adev->discovery_tmr_size)
-		adev->discovery_tmr_size = DISCOVERY_TMR_SIZE;
+		adev->discovery_tmr_size = DISCOVERY_TMR_OFFSET;
 
 	if (mem_train_support) {
 		/* reserve vram for mem train according to TMR location */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
