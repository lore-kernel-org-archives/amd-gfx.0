Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD635C5DF63
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 06:23:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A543206DF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 06:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A543206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1F166E180;
	Wed,  6 Nov 2019 06:23:52 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720070.outbound.protection.outlook.com [40.107.72.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5E236E17E
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2019 06:23:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItgAdf9jUbSi3MSdSNPJTB6gEuj+twHKOLfSWXMVS5f4q8VPcTioilmInnOAn+il0qaRMcrwPZVv66stpUOOj9oAIQ85M2DHGuXFJUOatFrTMkmkCndH5SH222N427l+wESgdNeAY7N+3V4hyNkYh9XCEcJMH/dfHJL08mbPmHo2u8y/hB/fggcFypPcW+5z8xCLGcUwtcrVlic7LyDEmEPvF2lDeouRkXXv+SQGYat9+dfPXGFXit/kAIcQduPaQsO+H0Uzf0Ld8JjHfk+rw5va8usGTzCjx4ybE2YaClPMVG115q8gxnmtmZlbnU1S1B4POaWg7jwqsvYpaHx/sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GG9qvRdwLrAiArS9O3kSCxbgbF7AZrQ5MIxu3bb1x0=;
 b=L7lA3Jo96mlnpfr4RYF8HlD5/k+xt5vCdLyl0UEfL6jFp670FIhWSgI0WJEGjekdxNgXP6QGwDCvssZBRBQY8o90S1zEhlQ7thioIDfkl81yZDaPQzamdTDH8tWABOsZxZQ1ndKgKhGRJ38qoSH4adEEkoKGQKzTqG9AlbgO2f+vmstrZNTlYVy50x+VKzchhjNEXNPNFuLNRrjBj0v+PECH78OX6XoNMQTdoPGp2GlaNPJ9B6/MdLOpYG3Ppt5gDzZq+y7iPtuWc5TwcEl86Mwx7Iu1cntIsLPOTJOAT9NZOkAvFNCJFCNY9gXLWBt7/3f8PcAiytan8f0gky6mLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM6PR12CA0025.namprd12.prod.outlook.com (2603:10b6:5:1c0::38)
 by MN2PR12MB2927.namprd12.prod.outlook.com (2603:10b6:208:103::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24; Wed, 6 Nov
 2019 06:23:48 +0000
Received: from DM3NAM03FT041.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::203) by DM6PR12CA0025.outlook.office365.com
 (2603:10b6:5:1c0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20 via Frontend
 Transport; Wed, 6 Nov 2019 06:23:48 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM3NAM03FT041.mail.protection.outlook.com (10.152.83.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2387.20 via Frontend Transport; Wed, 6 Nov 2019 06:23:47 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 6 Nov 2019
 00:23:47 -0600
Received: from emily-build-machine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 6 Nov 2019 00:23:46 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Need to disable msix when unloading driver
Date: Wed, 6 Nov 2019 14:23:39 +0800
Message-ID: <1573021419-15518-1-git-send-email-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(346002)(376002)(396003)(428003)(199004)(189003)(51416003)(47776003)(86362001)(2906002)(305945005)(8936002)(7696005)(81166006)(81156014)(50226002)(6916009)(336012)(5660300002)(486006)(8676002)(6666004)(4744005)(14444005)(356004)(26005)(70206006)(70586007)(2616005)(36756003)(2351001)(4326008)(50466002)(48376002)(16586007)(478600001)(53416004)(476003)(126002)(426003)(316002)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2927; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 061cb0ed-d3ab-49c8-3fda-08d76281e228
X-MS-TrafficTypeDiagnostic: MN2PR12MB2927:
X-Microsoft-Antispam-PRVS: <MN2PR12MB2927DDA3E3F2BEF7D1D1A8848F790@MN2PR12MB2927.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:530;
X-Forefront-PRVS: 02135EB356
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SN0GelVq0ufb78xYi2vrkrXg41VnIGkmpll3g437zqjYN+Y01E/pM76aE0sBnGwb+46ne4sDbM0/Iik4gtjjNwSEl7qpTNeUjZ7Q6xVCCPhcpaTq92wsDvtpm35w9KkAnjNl40Rwgo+5ZOXmDvxAemCfUn6loCZq8raq9AOHbup6UFVmbwDYXThW73tmI0Y/VCDJN3b4fehARA+PRUbPs6XmYkd8iy9HL4p3R7fgIpCxUBCf1jVU8ixA2K/GwSJifbFjCCq4kmUd+cGMGmfQYXOk2Nfd4DZhJc4zjTCnq3eddTV2Wb+eokAkdzVZzo0512jj6tBgADceJBk0CUXZGGFZl16ARYgKE1F2Uce727V/PCX2wr/HCap6vhoLIgyM7nlvwQq3jxA60celxU0nsyl3ArPGkhsyrDt+3RNIfTcxMX78JBBka6LqrN+t+U4v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2019 06:23:47.9965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 061cb0ed-d3ab-49c8-3fda-08d76281e228
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2927
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GG9qvRdwLrAiArS9O3kSCxbgbF7AZrQ5MIxu3bb1x0=;
 b=0qQm+QTu+W1dgJ36iuNAi/8OACsytkeUz63d9WIFdfPJVimp2s1GgWwdg2L/mtPAD7JsfHfp9llyJYlKblo5TQOx/2mAGMWAJmnq2v+KnAODahAhK2z1xY7nwYcNNf9rJJIiGxwj7jIlboiJ+ErKntysiP490+DnSd/hsAYUgEE=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is
 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Emily Deng <Emily.Deng@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191106062339.5soknk9NKwmjZj4eW86DQ_8KouKr2mBF_9pCqeoTEg4@z>

Rm9yIGRyaXZlciByZWxvYWQgdGVzdCwgaXQgd2lsbCByZXBvcnQgImNhbid0IGVuYWJsZQpNU0kg
KE1TSS1YIGFscmVhZHkgZW5hYmxlZCkiLgoKU2lnbmVkLW9mZi1ieTogRW1pbHkgRGVuZyA8RW1p
bHkuRGVuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9p
cnEuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pcnEuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pcnEuYwppbmRleCA2ZjNiMDNmLi4z
MGQ1NDBkIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXJx
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5jCkBAIC0zMTEs
NyArMzExLDcgQEAgdm9pZCBhbWRncHVfaXJxX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpCiAJCWRybV9pcnFfdW5pbnN0YWxsKGFkZXYtPmRkZXYpOwogCQlhZGV2LT5pcnEuaW5zdGFs
bGVkID0gZmFsc2U7CiAJCWlmIChhZGV2LT5pcnEubXNpX2VuYWJsZWQpCi0JCQlwY2lfZGlzYWJs
ZV9tc2koYWRldi0+cGRldik7CisJCQlwY2lfZnJlZV9pcnFfdmVjdG9ycyhhZGV2LT5wZGV2KTsK
IAkJaWYgKCFhbWRncHVfZGV2aWNlX2hhc19kY19zdXBwb3J0KGFkZXYpKQogCQkJZmx1c2hfd29y
aygmYWRldi0+aG90cGx1Z193b3JrKTsKIAl9Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
