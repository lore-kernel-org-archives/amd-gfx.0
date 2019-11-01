Return-Path: <SRS0=MAwf=YZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D9BCA9ECF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 09:07:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 756FF2080F
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 09:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 756FF2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16FEC6F797;
	Fri,  1 Nov 2019 09:07:48 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740089.outbound.protection.outlook.com [40.107.74.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C6ED6F798
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2019 09:07:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMeHvWiTxIM7QHEvpH79frugjJLJvSDdtAQPEEshaaHtSN3Iw1WLkqXIMkXAFpKtJhltgu4YFkNIoYrJTbJiDmR7jPUXyNGE0pzCzHiLXclWVMn8HJmjw3dG6fYFdx7hgDYB++Ed2T+GddEG0qtPVpEaAr68luknNmMPxcGjRMLjIjZrcENdil1JE3xZm7m0FvuT7//PcWsG7CfcdeTOaTkl8A6joTX0fsM3a1jcp/Q3WcHQEjrF05EY7IMMSkHKNwXAS1zH0q5VwIcO68gTGUNTaYG1CIR3xesNXzOVdhl4OMYXETmbdb/V0iX5B2YZBrVwnCCLPWYouCK0cManSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Z8YDzRiPdwB4q+Qtu/H9UTGqpluMKBFkpGVdVQDVkg=;
 b=MCOgDtQQf8hn4q+2bOdyjAs+YRItEm5gFpiQ4oPFF0etK0bBWQGxKUnMQF/i0ZdrSSHnfg+SKRVbz3lgpcHZBmKZnCiVTkz7yadbPUMya9YVRzA8zpW9i429HwBmhUfTDEHOMzFgPRxGsHdfeBm8jZ1v5ELJ3/rW2lFQAYcwlPGpFwopRFL1N/AkE/eoW0gdPtZm5WhIs6RLWdIHw8CbiK6IMWOLHCfMFmGqW2daCJJcP5rtg9WdEi9bmdMc3pNicAu9Lj1YPkgJGPbp05AuyE+8/jqYFdzU0ly3TV8VR/CfcDN2cEAr2F9i+zghsVyaawWumUDmkSGexK3GBwDwZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from BN4PR12CA0012.namprd12.prod.outlook.com (2603:10b6:403:2::22)
 by BN6PR1201MB0212.namprd12.prod.outlook.com (2603:10b6:405:56::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.23; Fri, 1 Nov
 2019 09:07:41 +0000
Received: from DM3NAM03FT006.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::202) by BN4PR12CA0012.outlook.office365.com
 (2603:10b6:403:2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.17 via Frontend
 Transport; Fri, 1 Nov 2019 09:07:41 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM3NAM03FT006.mail.protection.outlook.com (10.152.82.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Fri, 1 Nov 2019 09:07:41 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 1 Nov 2019
 04:07:40 -0500
Received: from emily-build-machine.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Fri, 1 Nov 2019 04:07:39 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Need to free discovery memory
Date: Fri, 1 Nov 2019 17:07:36 +0800
Message-ID: <1572599256-24993-1-git-send-email-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(346002)(396003)(39860400002)(428003)(199004)(189003)(305945005)(4326008)(81166006)(81156014)(50466002)(14444005)(16586007)(316002)(476003)(53416004)(47776003)(4744005)(5660300002)(186003)(8676002)(26005)(478600001)(6666004)(8936002)(6916009)(7696005)(336012)(70206006)(2906002)(426003)(70586007)(36756003)(2616005)(48376002)(50226002)(486006)(356004)(126002)(86362001)(51416003)(2351001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1201MB0212; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dce4aa2e-8017-4c90-7588-08d75eaaf30f
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0212:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0212E6F330B99A7820DAB6BB8F620@BN6PR1201MB0212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:165;
X-Forefront-PRVS: 020877E0CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uwbjq1na3kYWLyB1P2nYujux/dyys03Zy5HMoUTj5Cc7FwkTc5VKscc/R4HIsTuFKQAeGT/hF7DDGZu66lly+ythkXRroYN7w0AWRYnKxO7+os2Rw8VaIYXhAEklhODlHnofmh3kmuq0o+s3QJYYt0rIQbAKBv4H5wQd1PvA4E1bVP0MDbACqsppv7hRXk8Fs4qpYjkS3fDeO500kSurEfCXr0BtSdmvpXq9ZeZ8W/AujxmXspNvDeVz5V9fFRYnYUjjb8mJCpRa29xGUuGHX2QjWY6XbsV9rqK2ETiiCzzjKKO/2RXP261ITPiwag++zGRZ3fn7n88wEfqbr2ibupBgl6yAnncvDd11cd3bQbavWxlZKeFOOlagh7CNVsvQv79Jkp0B0HQ3o6gC9b02Xpb9wJJBr/WP5MRl56GW4S57N6WES0xJUtghauSDiH76
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2019 09:07:41.0691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dce4aa2e-8017-4c90-7588-08d75eaaf30f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0212
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Z8YDzRiPdwB4q+Qtu/H9UTGqpluMKBFkpGVdVQDVkg=;
 b=uu2fe9mdoRa6wgOl4EOSYrDSiSDytItVk5n74bBLuupIQCTntsi801zK6PwH0UlX1gMx/jKzfWBsTeYDRBiVuRES9gwI8tmOiDn+w68O1CgKPqPOU3SzpnvtI4i/LzmICEroH200jeu8N8WuSw5l8cwhD7GUIBKl8HC4hL0KGMs=
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
Message-ID: <20191101090736.cdzO0THntMgB5SDoUCjwtFBDHjgniT1ySCNYILQotgU@z>

V2hlbiB1bmxvYWRpbmcgZHJpdmVyLCBuZWVkIHRvIGZyZWUgZGlzY292ZXJ5IG1lbW9yeS4KClNp
Z25lZC1vZmYtYnk6IEVtaWx5IERlbmcgPEVtaWx5LkRlbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIHwgNSArKysrLQogMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
bWNfdjlfMC5jCmluZGV4IDlmMmE4OTMuLjUwZDZlZDIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ21jX3Y5XzAuYwpAQCAtMTA5MSw4ICsxMDkxLDExIEBAIHN0YXRpYyBpbnQgZ21jX3Y5XzBf
c3dfZmluaSh2b2lkICpoYW5kbGUpCiAJYW1kZ3B1X2dlbV9mb3JjZV9yZWxlYXNlKGFkZXYpOwog
CWFtZGdwdV92bV9tYW5hZ2VyX2ZpbmkoYWRldik7CiAKLQlpZiAoZ21jX3Y5XzBfa2VlcF9zdG9s
ZW5fbWVtb3J5KGFkZXYpKQorCWlmIChnbWNfdjlfMF9rZWVwX3N0b2xlbl9tZW1vcnkoYWRldikp
IHsKIAkJYW1kZ3B1X2JvX2ZyZWVfa2VybmVsKCZhZGV2LT5zdG9sZW5fdmdhX21lbW9yeSwgTlVM
TCwgJnN0b2xlbl92Z2FfYnVmKTsKKwkJLyogcmV0dXJuIHRoZSBJUCBEaXNjb3ZlcnkgVE1SIG1l
bW9yeSBiYWNrIHRvIFZSQU0gKi8KKwkJYW1kZ3B1X2JvX2ZyZWVfa2VybmVsKCZhZGV2LT5kaXNj
b3ZlcnlfbWVtb3J5LCBOVUxMLCBOVUxMKTsKKwl9CiAKIAlhbWRncHVfZ2FydF90YWJsZV92cmFt
X2ZyZWUoYWRldik7CiAJYW1kZ3B1X2JvX2ZpbmkoYWRldik7Ci0tIAoyLjcuNAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
