Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EAECA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 11:31:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27DAA20873
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 11:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27DAA20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF52C6E5EE;
	Mon, 28 Oct 2019 11:31:20 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700042.outbound.protection.outlook.com [40.107.70.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53F2D6E5EE
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 11:31:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGnWuhRIj/KUUlM5vQNF4ZFOdWJY5IeIiFQ9Yze520OCDbPOPfFwx/0lgCB7XvACOmYXDYXyuWUibmcLuYdso8Kq9aJqOb3TmJKbwTd2OL45Tg6musZs8yfmohRQoVqZDcTj8Xetp67fC9gEj4uznbrNitCyHcPfyQVGTCQVp9BDY2/J91J6E35y4HOKqFiQztatk6ozv1Q7sivw9UgumaLWMhFcDyW7GCdhtPvVAQpTLKui8H+X5dRkiQEFT9moOJt2kM4EMbJSbxe02OeqXQzgX359/jvFnVFQEAppFHkqdReSqGY3az+sXIr8KKq3eq1gNFACZ8n5bonovg4zAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NU8COQF+RbeygrGM8cKtnFAgSeWHE6RMr/6kFa+CgjQ=;
 b=QveqBpDGrGNC2KrlfT/Mp/mk8KOr9UDaaGr/25wXwJLpbnNFpmJ08ma/xrD4h3y1yZ3xx4OgBKAcF/GlRLAyZMmWf6Jf+Cj132lCVAQ6YnPoEdiJsho5y0KbtoHB4DVsr5nq93Vw1SX/2bE8KybX8VTefm0Al50cotErnWQ6+CjrxC8U+qRjCo58nNNL3GnpcgivQ1QMXB9n3PleYuMusmmq0eks/A5nDfyIRWcXnQGIbcPElM1rERYqh17QpM/7osNVz9JqgiL7jftXHjmQC/Wn7+Rn6Puf23lzwUomEj/WEZu1t7yBl4hJViEX62OLxcxEQhsx7ZJxxjdyw9/owg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from BN4PR12CA0024.namprd12.prod.outlook.com (2603:10b6:403:2::34)
 by CY4PR12MB1766.namprd12.prod.outlook.com (2603:10b6:903:122::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.23; Mon, 28 Oct
 2019 11:31:17 +0000
Received: from BY2NAM03FT021.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e4a::203) by BN4PR12CA0024.outlook.office365.com
 (2603:10b6:403:2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.20 via Frontend
 Transport; Mon, 28 Oct 2019 11:31:17 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BY2NAM03FT021.mail.protection.outlook.com (10.152.84.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Mon, 28 Oct 2019 11:31:16 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 28 Oct
 2019 06:31:16 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 28 Oct 2019 06:31:15 -0500
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: bypass some cleanup work after err_event_athub
Date: Mon, 28 Oct 2019 19:31:08 +0800
Message-ID: <1572262269-14985-3-git-send-email-le.ma@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572262269-14985-1-git-send-email-le.ma@amd.com>
References: <1572262269-14985-1-git-send-email-le.ma@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(39860400002)(396003)(346002)(428003)(199004)(189003)(356004)(126002)(50466002)(446003)(486006)(14444005)(6666004)(44832011)(5660300002)(50226002)(16586007)(478600001)(316002)(2906002)(81156014)(86362001)(48376002)(2616005)(476003)(36756003)(11346002)(81166006)(336012)(4326008)(186003)(426003)(8676002)(2351001)(51416003)(76176011)(47776003)(70206006)(6916009)(26005)(305945005)(70586007)(8936002)(21314003)(309714004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1766; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dafdb908-8bc7-46ea-062d-08d75b9a58e4
X-MS-TrafficTypeDiagnostic: CY4PR12MB1766:
X-Microsoft-Antispam-PRVS: <CY4PR12MB17667CD641FD10EA2EA48F5BF6660@CY4PR12MB1766.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:231;
X-Forefront-PRVS: 0204F0BDE2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K9rwuTeTRGDt3KpcC9yI5xUYoZbCQX3swi4QLKRTc5Zl2w1+L5ld/gE7XDRgI++LpuEmm1h6avM5BlnEyvtrIHVQsi4OYrMkfLiTb3DZrfWDHKcQwoWtG16zJABpaRmLWZvnXaoen4S0qJ8JRUGQEcO/1tVghMoclStFK9vNVVHZUYxlomLqL5Ixb+5klZfpPXFYhPrh9a4eHy3o1O24qa9/IHoNph5zqlNpb/CRsCnn9RZ12w6oyAvMF9cQvlgFN30+FYyn7RZJIh98/pmiimxyGkV5v/pnfQnQCp5a5KyLA0s0tFNX+0mt8ma/Z0xEOxshDKSm87XdKfrfkerz6tGLDehqDeD2ay1cy+SgFM+k+v9Wn9uM2dPSBZjRsBfb1zONBx/3rOxhxYEEzqrKNrNXCcHNeneY3LPfgWpPYAqIqeVlZefhyNHVjSGzk4+M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2019 11:31:16.9333 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dafdb908-8bc7-46ea-062d-08d75b9a58e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1766
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NU8COQF+RbeygrGM8cKtnFAgSeWHE6RMr/6kFa+CgjQ=;
 b=HWYf67w3f+nuCe2HF9Z3rLKDoqHpG6x3We3zOCOVo6E2uST6GoqvdOGinRpyPyfP8xnRkSgizFS583QqGdPilGmZkraWI33KtiUXzieXROkUa5OGORgW8okM1fEtR5/pzw1csj0Uc3jMGVIB3K1K9xPn3MIuuAP16iz7CVmfKAU=
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
Cc: Le Ma <le.ma@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028113108.SEuv1RSW3DxJBqzBRsOa0cs_qrIXsKTuQEPMNcMEuTg@z>

UFNQIGxvc3QgY29ubmVjdGlvbiB3aGVuIGVycl9ldmVudF9hdGh1YiBvY2N1cnMuIFRoZXNlIGNs
ZWFudXAgd29yayBjYW4gYmUKc2tpcHBlZCBpbiBCQUNPIHJlc2V0LgoKQ2hhbmdlLUlkOiBJZjU0
YTM3MzVlZGQ2Y2NiYjU4ZDQwYTVmODgzMzM5Mjk4MWY4Y2UzNwpTaWduZWQtb2ZmLWJ5OiBMZSBN
YSA8bGUubWFAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZGV2aWNlLmMgfCAgNiArKysrKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9w
c3AuYyAgICB8ICA3ICsrKysrKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
YXMuYyAgICB8IDIwICsrKysrKysrKysrLS0tLS0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjlfMC5jICAgICAgfCAgNiArKysrLS0KIDQgZmlsZXMgY2hhbmdlZCwgMjggaW5z
ZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jCmluZGV4IDUxZDc0YmIuLjcyZDk4OTIgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKQEAgLTIyNzQsNiArMjI3NCwxMiBAQCBzdGF0
aWMgaW50IGFtZGdwdV9kZXZpY2VfaXBfc3VzcGVuZF9waGFzZTIoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpCiAJCS8qIGRpc3BsYXlzIGFyZSBoYW5kbGVkIGluIHBoYXNlMSAqLwogCQlpZiAo
YWRldi0+aXBfYmxvY2tzW2ldLnZlcnNpb24tPnR5cGUgPT0gQU1EX0lQX0JMT0NLX1RZUEVfRENF
KQogCQkJY29udGludWU7CisJCS8qIFBTUCBsb3N0IGNvbm5lY3Rpb24gd2hlbiBlcnJfZXZlbnRf
YXRodWIgb2NjdXJzICovCisJCWlmIChhbWRncHVfcmFzX2ludHJfdHJpZ2dlcmVkKCkgJiYKKwkJ
ICAgIGFkZXYtPmlwX2Jsb2Nrc1tpXS52ZXJzaW9uLT50eXBlID09IEFNRF9JUF9CTE9DS19UWVBF
X1BTUCkgeworCQkJYWRldi0+aXBfYmxvY2tzW2ldLnN0YXR1cy5odyA9IGZhbHNlOworCQkJY29u
dGludWU7CisJCX0KIAkJLyogWFhYIGhhbmRsZSBlcnJvcnMgKi8KIAkJciA9IGFkZXYtPmlwX2Js
b2Nrc1tpXS52ZXJzaW9uLT5mdW5jcy0+c3VzcGVuZChhZGV2KTsKIAkJLyogWFhYIGhhbmRsZSBl
cnJvcnMgKi8KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9w
c3AuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwppbmRleCBmZDdh
NzNmLi5mY2UyMDZmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcHNwLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCkBA
IC0xNjcsNiArMTY3LDEzIEBAIHBzcF9jbWRfc3VibWl0X2J1ZihzdHJ1Y3QgcHNwX2NvbnRleHQg
KnBzcCwKIAl3aGlsZSAoKigodW5zaWduZWQgaW50ICopcHNwLT5mZW5jZV9idWYpICE9IGluZGV4
KSB7CiAJCWlmICgtLXRpbWVvdXQgPT0gMCkKIAkJCWJyZWFrOworCQkvKgorCQkgKiBTaG91bGRu
J3Qgd2FpdCBmb3IgdGltZW91dCB3aGVuIGVycl9ldmVudF9hdGh1YiBvY2N1cnMsCisJCSAqIGJl
Y2F1c2UgZ3B1IHJlc2V0IHRocmVhZCB0cmlnZ2VyZWQgYW5kIGxvY2sgcmVzb3VyY2Ugc2hvdWxk
CisJCSAqIGJlIHJlbGVhc2VkIGZvciBwc3AgcmVzdW1lIHNlcXVlbmNlLgorCQkgKi8KKwkJaWYg
KGFtZGdwdV9yYXNfaW50cl90cmlnZ2VyZWQoKSkKKwkJCWJyZWFrOwogCQltc2xlZXAoMSk7CiAJ
CWFtZGdwdV9hc2ljX2ludmFsaWRhdGVfaGRwKHBzcC0+YWRldiwgTlVMTCk7CiAJfQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jCmluZGV4IDc5NjMyNmIuLmRhYjkwYzIgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKQEAgLTU1OCwxNSArNTU4LDE3
IEBAIGludCBhbWRncHVfcmFzX2ZlYXR1cmVfZW5hYmxlKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2LAogCWlmICghKCEhZW5hYmxlIF4gISFhbWRncHVfcmFzX2lzX2ZlYXR1cmVfZW5hYmxlZChh
ZGV2LCBoZWFkKSkpCiAJCXJldHVybiAwOwogCi0JcmV0ID0gcHNwX3Jhc19lbmFibGVfZmVhdHVy
ZXMoJmFkZXYtPnBzcCwgJmluZm8sIGVuYWJsZSk7Ci0JaWYgKHJldCkgewotCQlEUk1fRVJST1Io
IlJBUyBFUlJPUjogJXMgJXMgZmVhdHVyZSBmYWlsZWQgcmV0ICVkXG4iLAotCQkJCWVuYWJsZSA/
ICJlbmFibGUiOiJkaXNhYmxlIiwKLQkJCQlyYXNfYmxvY2tfc3RyKGhlYWQtPmJsb2NrKSwKLQkJ
CQlyZXQpOwotCQlpZiAocmV0ID09IFRBX1JBU19TVEFUVVNfX1JFU0VUX05FRURFRCkKLQkJCXJl
dHVybiAtRUFHQUlOOwotCQlyZXR1cm4gLUVJTlZBTDsKKwlpZiAoIWFtZGdwdV9yYXNfaW50cl90
cmlnZ2VyZWQoKSkgeworCQlyZXQgPSBwc3BfcmFzX2VuYWJsZV9mZWF0dXJlcygmYWRldi0+cHNw
LCAmaW5mbywgZW5hYmxlKTsKKwkJaWYgKHJldCkgeworCQkJRFJNX0VSUk9SKCJSQVMgRVJST1I6
ICVzICVzIGZlYXR1cmUgZmFpbGVkIHJldCAlZFxuIiwKKwkJCQkJZW5hYmxlID8gImVuYWJsZSI6
ImRpc2FibGUiLAorCQkJCQlyYXNfYmxvY2tfc3RyKGhlYWQtPmJsb2NrKSwKKwkJCQkJcmV0KTsK
KwkJCWlmIChyZXQgPT0gVEFfUkFTX1NUQVRVU19fUkVTRVRfTkVFREVEKQorCQkJCXJldHVybiAt
RUFHQUlOOworCQkJcmV0dXJuIC1FSU5WQUw7CisJCX0KIAl9CiAKIAkvKiBzZXR1cCB0aGUgb2Jq
ICovCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwppbmRleCA5ZmU5NWU3Li45YzJk
YmE2MiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCkBAIC0zNzM2LDggKzM3
MzYsMTAgQEAgc3RhdGljIGludCBnZnhfdjlfMF9od19maW5pKHZvaWQgKmhhbmRsZSkKIAlhbWRn
cHVfaXJxX3B1dChhZGV2LCAmYWRldi0+Z2Z4LnByaXZfcmVnX2lycSwgMCk7CiAJYW1kZ3B1X2ly
cV9wdXQoYWRldiwgJmFkZXYtPmdmeC5wcml2X2luc3RfaXJxLCAwKTsKIAotCS8qIGRpc2FibGUg
S0NRIHRvIGF2b2lkIENQQyB0b3VjaCBtZW1vcnkgbm90IHZhbGlkIGFueW1vcmUgKi8KLQlnZnhf
djlfMF9rY3FfZGlzYWJsZShhZGV2KTsKKwkvKiBERiBmcmVlemUgYW5kIGtjcSBkaXNhYmxlIHdp
bGwgZmFpbCAqLworCWlmICghYW1kZ3B1X3Jhc19pbnRyX3RyaWdnZXJlZCgpKQorCQkvKiBkaXNh
YmxlIEtDUSB0byBhdm9pZCBDUEMgdG91Y2ggbWVtb3J5IG5vdCB2YWxpZCBhbnltb3JlICovCisJ
CWdmeF92OV8wX2tjcV9kaXNhYmxlKGFkZXYpOwogCiAJaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2
KSkgewogCQlnZnhfdjlfMF9jcF9nZnhfZW5hYmxlKGFkZXYsIGZhbHNlKTsKLS0gCjIuNy40Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
