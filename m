Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7198C432C0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 11:50:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B80E820722
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 11:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80E820722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63EAD6E2F9;
	Tue, 26 Nov 2019 11:50:39 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720073.outbound.protection.outlook.com [40.107.72.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA0556E2F9
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 11:50:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1R+jtIxx3uzbZxtPV1JCtjSpAUcvpwOIvXqd0he9+pZGciStcBuffQYEOsRMx8zK//XomPyoH8WXo1PeqRAcfvvLKQR897Ncvvn7mbyO6odF0jxwRtS3MEttuDhpZKYhYEfu1wncvhmqgCD835Ft6JcXa6MOzXjlD8mBtfgmoSPbay5Zr79xVxaX/pzV4qSefrfoYOScpYV56ZD3px17KO6+j/ZI0yYT3wkaCWLC7QGYwvmYaSHiRRfdrj9FmC+qhMGISlXSOxIxIJbF0Vnc/rhdbSWeWbqmunvVHDbLCbveKHEA9qSL4duOuB0M5dKrB/NRelY3A0xtpVsV/VMww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8pqqeUGeE5rowjlEzmscePMY6tLUweUH/fDn4FK/bA=;
 b=I4hcXRPe4os+PgA2Ipb+BjcJ4tbW6o9N3tuYrSuyClBlm1+71vpXYbBAl0b8pPFIAiqMALq8+Nu1+Zz1OOkX8t38OvjOiTx/bSk6bsHwhCFf5zl+Uo/cG3Qnfh+cMI30v+o3+Ei5RnrMCDeyB5sTyy0EZ2vawWlYqqt92LXPZWqc2kbnK5fdVvsKYdbjwBZfELGfEMnICoy1AXNythvVYQJMzhpFfPwfpIhukIKvPyb1/+r6gsn4whmbPdEVS0ThmLYQ/VWb+gC1oFOYLg4XwiAqpEvicquXnbsw4ARG8EYMbraMb4vb0joEs/qnv2z3HhOvX2lC9VxxxEHQaAZy8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from SN1PR12CA0055.namprd12.prod.outlook.com (2603:10b6:802:20::26)
 by BY5PR12MB4273.namprd12.prod.outlook.com (2603:10b6:a03:212::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17; Tue, 26 Nov
 2019 11:50:36 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::207) by SN1PR12CA0055.outlook.office365.com
 (2603:10b6:802:20::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2474.17 via Frontend
 Transport; Tue, 26 Nov 2019 11:50:36 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Tue, 26 Nov 2019 11:50:36 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 26 Nov
 2019 05:50:35 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 26 Nov
 2019 05:50:35 -0600
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 26 Nov 2019 05:50:34 -0600
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amdgpu: do autoload right after MEC loaded for SRIOV
 VF
Date: Tue, 26 Nov 2019 19:50:22 +0800
Message-ID: <1574769024-30611-3-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574769024-30611-1-git-send-email-Monk.Liu@amd.com>
References: <1574769024-30611-1-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(396003)(376002)(428003)(199004)(189003)(5660300002)(6666004)(356004)(305945005)(2351001)(478600001)(36756003)(14444005)(316002)(53416004)(50466002)(48376002)(2906002)(4744005)(7696005)(26005)(51416003)(6916009)(186003)(11346002)(81166006)(81156014)(4326008)(8676002)(50226002)(70586007)(446003)(336012)(16586007)(70206006)(86362001)(426003)(8936002)(76176011)(47776003)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB4273; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01f98fbb-f065-4ff4-7de2-08d77266d9b6
X-MS-TrafficTypeDiagnostic: BY5PR12MB4273:
X-Microsoft-Antispam-PRVS: <BY5PR12MB42730CD87845CDD99F1A426784450@BY5PR12MB4273.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-Forefront-PRVS: 0233768B38
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +uW4KEeBQu11p1+DWbs60zwIsDoRL8YmrIWtg1X/yNmnIEEPWfd3vSrjp7P7ZXo2eBQaHZ6Z6XCcUOxUfkS+CVsW9DUC8zqPdrWAzsDCzG05Ll6oi0BtNVbFHsmnlMnSrDFRyRkqBhCzcewPsa23u6P07TBp5mIvvCkzgWKdVxJESsodDDs7VglOLKb+zY0NXfExvmBk1sXv5uCfnzNcZ1b7/Xka0b/DuBzcoIrZTmQj+Xo022DELaFtsHWZHPuYAnfrlxcV1WFLJFbobImBzlVkI3FjqRno689FEa0s9tvI7+78yROQyL6dUh0xyOOWHGg25MsMgE/BWjgoyNKfi+dgJHunGkzQhI75WPQXQT2Uqa935oE31dzJ7QHdqRfTxyF17QDLHLJW6lJqsvF2kXeh5MYKS0UrdpneY41RBCJv+iwvjErr3MEAD+KjmONF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 11:50:36.0180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f98fbb-f065-4ff4-7de2-08d77266d9b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4273
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8pqqeUGeE5rowjlEzmscePMY6tLUweUH/fDn4FK/bA=;
 b=Gmmk1ouEO7GPlg5UnwtE3buxN9+FbWh/TyN9phc6j9x7xLt4euUTvsFfv246u5qw0VYmffj1MfXCRK5tUDeVMU3Ae9aGW3FoYXyoUgcP/Haysw+G83n7ZY+qWeS/iltBYuGIPs6ISKxLIxQEE+4MxGPdaXhiPTCHhm8y7K2QDLk=
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191126115022.ElEVkqkiNtKEqRk0EmyesZPqaiEzhaUw4zXYZikJ3iU@z>

c2luY2Ugd2UgZG9uJ3QgaGF2ZSBSTENHIHVjb2RlIGxvYWRpbmcgYW5kIG5vIFNSbGlzdCBhcyB3
ZWxsCgpTaWduZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgfCAzICstLQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9wc3AuYwppbmRleCA5NmE2YjAwLi5iNjVmZGE5IDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCkBAIC0xNDkwLDggKzE0OTAsNyBAQCBzdGF0aWMgaW50
IHBzcF9ucF9md19sb2FkKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogCQkJcmV0dXJuIHJldDsK
IAogCQkvKiBTdGFydCBybGMgYXV0b2xvYWQgYWZ0ZXIgcHNwIHJlY2lldmVkIGFsbCB0aGUgZ2Z4
IGZpcm13YXJlICovCi0JCWlmIChwc3AtPmF1dG9sb2FkX3N1cHBvcnRlZCAmJiB1Y29kZS0+dWNv
ZGVfaWQgPT0KLQkJCUFNREdQVV9VQ09ERV9JRF9STENfUkVTVE9SRV9MSVNUX1NSTV9NRU0pIHsK
KwkJaWYgKHBzcC0+YXV0b2xvYWRfc3VwcG9ydGVkICYmIHVjb2RlLT51Y29kZV9pZCA9PSAoYW1k
Z3B1X3NyaW92X3ZmKGFkZXYpID8gQU1ER1BVX1VDT0RFX0lEX0NQX01FQzIgOiBBTURHUFVfVUNP
REVfSURfUkxDX1JFU1RPUkVfTElTVF9TUk1fTUVNKSkgewogCQkJcmV0ID0gcHNwX3JsY19hdXRv
bG9hZChwc3ApOwogCQkJaWYgKHJldCkgewogCQkJCURSTV9FUlJPUigiRmFpbGVkIHRvIHN0YXJ0
IHJsYyBhdXRvbG9hZFxuIik7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4
