Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4C0C432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 19:08:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0728C206D5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 19:08:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0728C206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 488FD6EE0A;
	Wed, 13 Nov 2019 19:08:13 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe41::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E603F6EE0A
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 19:08:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMmhptQ+HOU1mHTludCpI1UiE/BNQ6Rq+X7Amcsem9zzxyr0i5vvba+I5mTAim3QZFfQGf6BShnhpe2qpwalP6Agi4AEWd4tK2BN+0Oz1EWSNQuwlgljWLrk65suyFaUfTDwNO1qIthmFN6/Z4iSTJsYpemGVy+O1nT12d35pw63ZOy5cj9VmYxmnYb8LLkqSODOvsp6iHMQIdZE+NLXWIJEW1CV7woVTFuR3h1PZ8ATMHxiOiPXnuRo0LFc4TpeRaeIB3dv6d53QClAPhYfVLwjISqyl7tF6nCQwLbtfD4t+4cQTGdykmLkBN4e+2Bd3xB3N70BYbdr9UAgP7awjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1OJ2M/h0UU84VeDd9SQEzWY6vuCVb+YX7SJI1Wzg5c=;
 b=BCRcFh2crgDOOy9PeFcv/o/VicdmwnPPKiMAFGD6tzIteifaQeeBZ1y6osh+X7choeEHN6kHkcs02KAJgH2+kc3ohhqYp5+9oxTRug2KA6ssV2tOlmDCh/uq+mSNHyMz2XeTVXnypnVG0mv+VfLAXPsfEHkbs7JNgcgwyZ5YpDsE7rEup5uqqbp/qvwKObv5B3OgOF41lzVIRBIH/5bntwgwv6zsfodyCP7Hat2Y837HxWc6MrH1d6HLQdwQxOaVlwgQBlORP+mGvniEJozKfmCGWn2Gy3cuk0eaBoE7PzVzGPc/Kti/G53rMXODbsUm1+7pODaLDan7caVeMsNKUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from BN4PR12CA0023.namprd12.prod.outlook.com (2603:10b6:403:2::33)
 by DM5PR12MB2550.namprd12.prod.outlook.com (2603:10b6:4:b8::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.24; Wed, 13 Nov
 2019 19:08:07 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::201) by BN4PR12CA0023.outlook.office365.com
 (2603:10b6:403:2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2451.24 via Frontend
 Transport; Wed, 13 Nov 2019 19:08:07 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Wed, 13 Nov 2019 19:08:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 13 Nov
 2019 13:07:32 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 13 Nov
 2019 13:07:31 -0600
Received: from mlipski-pc.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 13 Nov 2019 13:07:31 -0600
From: <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/dsc: Update drm_dsc to reflect native 4.2.0 DSC spec
Date: Wed, 13 Nov 2019 14:07:27 -0500
Message-ID: <20191113190728.26645-1-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(346002)(136003)(428003)(189003)(199004)(8936002)(26005)(8676002)(6916009)(50226002)(2876002)(81166006)(426003)(336012)(186003)(2906002)(81156014)(4326008)(53416004)(2616005)(476003)(126002)(486006)(36756003)(70586007)(70206006)(305945005)(1076003)(6666004)(478600001)(54906003)(86362001)(7696005)(316002)(356004)(51416003)(16586007)(5660300002)(2351001)(50466002)(48376002)(47776003)(16060500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2550; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c02f77b-951e-4999-1015-08d7686cd153
X-MS-TrafficTypeDiagnostic: DM5PR12MB2550:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2550713F70D8F7E6C159FAFEE4760@DM5PR12MB2550.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0220D4B98D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5jGX2xGHrtAIGtpyHNYFZ5G/YSJ1Z/LYP7jSeXB1JxHIQ5NVDkR+rBmbjriz7nvn8O+l5zsqBzxo4c4Z51eG53E+HmKoZOfvdLh7CF6Zi2U5o6kzaT0C1pJxb92rmeHET3tdiw2kh4jjkQol/uKW96XCtq/fBFAAjBPIV7YJalsJdCBCcEt6Bhmv92S0g73h2G21UN5/Zlb1IbamuRDybiDL6XlDoYT43QicowhlfkHUPo0oDz4rM75cZj/Ba9dLtP7Yy2MmAAY/dRsPke+dxYu7nhBiyx3O0r2H1d/6cmh7j6KlBeIpib3Wg4SK3c3rrUuQr6ufHUD32FmW43IgTrtsK1DXwMBBK2EQjQ4opd3KjoASmM48irdpaeZ2t7vj0bEEAiIGDUg4xCAb4Pn2ezx0ZCxR/Kn59tkvPlOVakc8jqhPmpSTxGGTHzfnajXU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2019 19:08:07.3442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c02f77b-951e-4999-1015-08d7686cd153
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2550
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1OJ2M/h0UU84VeDd9SQEzWY6vuCVb+YX7SJI1Wzg5c=;
 b=WNH5EOGTorPe8gpbk/TToP3W03k46yFtrhJdZmlUGj6g9Dq+saf3rw21Xepora2H2sm37sYD7dgySUFllIZ3PzsuFLLax/4s6vvjhAWPY9xAw16VNwD4sl6L69NnbCkRINATFVmfmFCcMTUllmXapZAxvc3fFUX+1iIKHf2L2+s=
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
Cc: David Francis <David.Francis@amd.com>, nikola.cornij@amd.com,
 manasi.d.navare@intel.com, alexander.deucher@amd.com,
 Mikita Lipski <mikita.lipski@amd.com>, harry.wentland@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191113190727.IxMIUIwMUg95HirCXz46ztH7cwfb9Y0xRIZbX4ZXZg8@z>

RnJvbTogTWlraXRhIExpcHNraSA8bWlraXRhLmxpcHNraUBhbWQuY29tPgoKW1doeV0KU29tZSBw
YXJ0cyBvZiB0aGUgRFNDIHNwZWMgcmVsYXRpbmcgdG8gNC4yLjAgd2VyZSBub3QgcmVmbGVjdGVk
IGluCmRybV9kc2NfY29tcHV0ZV9yY19wYXJhbWV0ZXJzLCBjYXVzaW5nIHVuZXhwZWN0ZWQgY29u
ZmlnIGZhaWx1cmVzCgpbSG93XQpBZGQgbnNsX2JwZ19vZmZzZXQgYW5kIHJic19taW4gY29tcHV0
YXRpb24KClNpZ25lZC1vZmYtYnk6IERhdmlkIEZyYW5jaXMgPERhdmlkLkZyYW5jaXNAYW1kLmNv
bT4KU2lnbmVkLW9mZi1ieTogTWlraXRhIExpcHNraSA8bWlraXRhLmxpcHNraUBhbWQuY29tPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS9kcm1fZHNjLmMgfCA3MiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCA2OCBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZHNjLmMgYi9kcml2
ZXJzL2dwdS9kcm0vZHJtX2RzYy5jCmluZGV4IDc3ZjRlNWFlNDE5Ny4uNzljNzFlM2ZjOTczIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2RzYy5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9kcm1fZHNjLmMKQEAgLTI0NSw2ICsyNDUsMzggQEAgdm9pZCBkcm1fZHNjX3Bwc19wYXlsb2Fk
X3BhY2soc3RydWN0IGRybV9kc2NfcGljdHVyZV9wYXJhbWV0ZXJfc2V0ICpwcHNfcGF5bG9hZCwK
IH0KIEVYUE9SVF9TWU1CT0woZHJtX2RzY19wcHNfcGF5bG9hZF9wYWNrKTsKIAorc3RhdGljIGlu
dCBjb21wdXRlX29mZnNldChzdHJ1Y3QgZHJtX2RzY19jb25maWcgKnZkc2NfY2ZnLCBpbnQgcGl4
ZWxzX3Blcl9ncm91cCwKKwkJCQlpbnQgZ3JvdXBzX3Blcl9saW5lLCBpbnQgZ3JwY250KQorewor
CWludCBvZmZzZXQgPSAwOworCWludCBncnBjbnRfaWQgPSBESVZfUk9VTkRfVVAodmRzY19jZmct
PmluaXRpYWxfeG1pdF9kZWxheSwgcGl4ZWxzX3Blcl9ncm91cCk7CisKKwlpZiAoZ3JwY250IDw9
IGdycGNudF9pZCkKKwkJb2Zmc2V0ID0gRElWX1JPVU5EX1VQKGdycGNudCAqIHBpeGVsc19wZXJf
Z3JvdXAgKiB2ZHNjX2NmZy0+Yml0c19wZXJfcGl4ZWwsIDE2KTsKKwllbHNlCisJCW9mZnNldCA9
IERJVl9ST1VORF9VUChncnBjbnRfaWQgKiBwaXhlbHNfcGVyX2dyb3VwICogdmRzY19jZmctPmJp
dHNfcGVyX3BpeGVsLCAxNikKKwkJCS0gKCgoZ3JwY250IC0gZ3JwY250X2lkKSAqIHZkc2NfY2Zn
LT5zbGljZV9icGdfb2Zmc2V0KSA+PiAxMSk7CisKKwlpZiAoZ3JwY250IDw9IGdyb3Vwc19wZXJf
bGluZSkKKwkJb2Zmc2V0ICs9IGdycGNudCAqIHZkc2NfY2ZnLT5maXJzdF9saW5lX2JwZ19vZmZz
ZXQ7CisJZWxzZQorCQlvZmZzZXQgKz0gZ3JvdXBzX3Blcl9saW5lICogdmRzY19jZmctPmZpcnN0
X2xpbmVfYnBnX29mZnNldAorCQkJLSAoKChncnBjbnQgLSBncm91cHNfcGVyX2xpbmUpICogdmRz
Y19jZmctPm5mbF9icGdfb2Zmc2V0KSA+PiAxMSk7CisKKwlpZiAodmRzY19jZmctPm5hdGl2ZV80
MjApIHsKKwkJaWYgKGdycGNudCA8PSBncm91cHNfcGVyX2xpbmUpCisJCQlvZmZzZXQgLT0gKGdy
cGNudCAqIHZkc2NfY2ZnLT5uc2xfYnBnX29mZnNldCkgPj4gMTE7CisJCWVsc2UgaWYgKGdycGNu
dCA8PSAyICogZ3JvdXBzX3Blcl9saW5lKQorCQkJb2Zmc2V0ICs9IChncnBjbnQgLSBncm91cHNf
cGVyX2xpbmUpICogdmRzY19jZmctPnNlY29uZF9saW5lX2JwZ19vZmZzZXQKKwkJCQktICgoZ3Jv
dXBzX3Blcl9saW5lICogdmRzY19jZmctPm5zbF9icGdfb2Zmc2V0KSA+PiAxMSk7CisJCWVsc2UK
KwkJCW9mZnNldCArPSAoZ3JwY250IC0gZ3JvdXBzX3Blcl9saW5lKSAqIHZkc2NfY2ZnLT5zZWNv
bmRfbGluZV9icGdfb2Zmc2V0CisJCQkJLSAoKChncnBjbnQgLSBncm91cHNfcGVyX2xpbmUpICog
dmRzY19jZmctPm5zbF9icGdfb2Zmc2V0KSA+PiAxMSk7CisJfQorCisJcmV0dXJuIG9mZnNldDsK
K30KKwogLyoqCiAgKiBkcm1fZHNjX2NvbXB1dGVfcmNfcGFyYW1ldGVycygpIC0gV3JpdGUgcmF0
ZSBjb250cm9sCiAgKiBwYXJhbWV0ZXJzIHRvIHRoZSBkc2MgY29uZmlndXJhdGlvbiBkZWZpbmVk
IGluCkBAIC0yNjQsNiArMjk2LDcgQEAgaW50IGRybV9kc2NfY29tcHV0ZV9yY19wYXJhbWV0ZXJz
KHN0cnVjdCBkcm1fZHNjX2NvbmZpZyAqdmRzY19jZmcpCiAJdW5zaWduZWQgbG9uZyBocmRfZGVs
YXkgPSAwOwogCXVuc2lnbmVkIGxvbmcgZmluYWxfc2NhbGUgPSAwOwogCXVuc2lnbmVkIGxvbmcg
cmJzX21pbiA9IDA7CisJdW5zaWduZWQgbG9uZyBtYXhfb2Zmc2V0ID0gMDsKIAogCWlmICh2ZHNj
X2NmZy0+bmF0aXZlXzQyMCB8fCB2ZHNjX2NmZy0+bmF0aXZlXzQyMikgewogCQkvKiBOdW1iZXIg
b2YgZ3JvdXBzIHVzZWQgdG8gY29kZSBlYWNoIGxpbmUgb2YgYSBzbGljZSAqLwpAQCAtMzQyLDYg
KzM3NSwxNyBAQCBpbnQgZHJtX2RzY19jb21wdXRlX3JjX3BhcmFtZXRlcnMoc3RydWN0IGRybV9k
c2NfY29uZmlnICp2ZHNjX2NmZykKIAkJcmV0dXJuIC1FUkFOR0U7CiAJfQogCisJaWYgKHZkc2Nf
Y2ZnLT5zbGljZV9oZWlnaHQgPiAyKQorCQl2ZHNjX2NmZy0+bnNsX2JwZ19vZmZzZXQgPSBESVZf
Uk9VTkRfVVAoKHZkc2NfY2ZnLT5zZWNvbmRfbGluZV9icGdfb2Zmc2V0IDw8IDExKSwKKwkJCQkJ
CQkodmRzY19jZmctPnNsaWNlX2hlaWdodCAtIDEpKTsKKwllbHNlCisJCXZkc2NfY2ZnLT5uc2xf
YnBnX29mZnNldCA9IDA7CisKKwlpZiAodmRzY19jZmctPm5zbF9icGdfb2Zmc2V0ID4gNjU1MzUp
IHsKKwkJRFJNX0RFQlVHX0tNUygiTnNsQnBnT2Zmc2V0IGlzIHRvbyBsYXJnZSBmb3IgdGhpcyBz
bGljZSBoZWlnaHRcbiIpOworCQlyZXR1cm4gLUVSQU5HRTsKKwl9CisKIAkvKiBOdW1iZXIgb2Yg
Z3JvdXBzIHVzZWQgdG8gY29kZSB0aGUgZW50aXJlIHNsaWNlICovCiAJZ3JvdXBzX3RvdGFsID0g
Z3JvdXBzX3Blcl9saW5lICogdmRzY19jZmctPnNsaWNlX2hlaWdodDsKIApAQCAtMzYxLDYgKzQw
NSw3IEBAIGludCBkcm1fZHNjX2NvbXB1dGVfcmNfcGFyYW1ldGVycyhzdHJ1Y3QgZHJtX2RzY19j
b25maWcgKnZkc2NfY2ZnKQogCQl2ZHNjX2NmZy0+c2NhbGVfaW5jcmVtZW50X2ludGVydmFsID0K
IAkJCQkodmRzY19jZmctPmZpbmFsX29mZnNldCAqICgxIDw8IDExKSkgLwogCQkJCSgodmRzY19j
ZmctPm5mbF9icGdfb2Zmc2V0ICsKKwkJCQl2ZHNjX2NmZy0+bnNsX2JwZ19vZmZzZXQgKwogCQkJ
CXZkc2NfY2ZnLT5zbGljZV9icGdfb2Zmc2V0KSAqCiAJCQkJKGZpbmFsX3NjYWxlIC0gOSkpOwog
CX0gZWxzZSB7CkBAIC0zODEsMTAgKzQyNiwyOSBAQCBpbnQgZHJtX2RzY19jb21wdXRlX3JjX3Bh
cmFtZXRlcnMoc3RydWN0IGRybV9kc2NfY29uZmlnICp2ZHNjX2NmZykKIAkgKiBiaXRzL3BpeGVs
IChicHApIHJhdGUgdGhhdCBpcyB1c2VkIGJ5IHRoZSBlbmNvZGVyLAogCSAqIGluIHN0ZXBzIG9m
IDEvMTYgb2YgYSBiaXQgcGVyIHBpeGVsCiAJICovCi0JcmJzX21pbiA9IHZkc2NfY2ZnLT5yY19t
b2RlbF9zaXplIC0gdmRzY19jZmctPmluaXRpYWxfb2Zmc2V0ICsKLQkJRElWX1JPVU5EX1VQKHZk
c2NfY2ZnLT5pbml0aWFsX3htaXRfZGVsYXkgKgotCQkJICAgICB2ZHNjX2NmZy0+Yml0c19wZXJf
cGl4ZWwsIDE2KSArCi0JCWdyb3Vwc19wZXJfbGluZSAqIHZkc2NfY2ZnLT5maXJzdF9saW5lX2Jw
Z19vZmZzZXQ7CisJaWYgKHZkc2NfY2ZnLT5kc2NfdmVyc2lvbl9taW5vciA9PSAyICYmICh2ZHNj
X2NmZy0+bmF0aXZlXzQyMCB8fCB2ZHNjX2NmZy0+bmF0aXZlXzQyMikpIHsKKworCQltYXhfb2Zm
c2V0ID0gY29tcHV0ZV9vZmZzZXQodmRzY19jZmcsIERTQ19SQ19QSVhFTFNfUEVSX0dST1VQLCBn
cm91cHNfcGVyX2xpbmUsCisJCQkJCURJVl9ST1VORF9VUCh2ZHNjX2NmZy0+aW5pdGlhbF94bWl0
X2RlbGF5LAorCQkJCQkJRFNDX1JDX1BJWEVMU19QRVJfR1JPVVApKTsKKworCQltYXhfb2Zmc2V0
ID0gbWF4KG1heF9vZmZzZXQsCisJCQkJY29tcHV0ZV9vZmZzZXQodmRzY19jZmcsIERTQ19SQ19Q
SVhFTFNfUEVSX0dST1VQLCBncm91cHNfcGVyX2xpbmUsCisJCQkJCURJVl9ST1VORF9VUCh2ZHNj
X2NmZy0+aW5pdGlhbF94bWl0X2RlbGF5LAorCQkJCQkJZ3JvdXBzX3Blcl9saW5lKSkpOworCisJ
CW1heF9vZmZzZXQgPSBtYXgobWF4X29mZnNldCwKKwkJCQljb21wdXRlX29mZnNldCh2ZHNjX2Nm
ZywgRFNDX1JDX1BJWEVMU19QRVJfR1JPVVAsIGdyb3Vwc19wZXJfbGluZSwKKwkJCQkJRElWX1JP
VU5EX1VQKHZkc2NfY2ZnLT5pbml0aWFsX3htaXRfZGVsYXksCisJCQkJCQlncm91cHNfcGVyX2xp
bmUgKiAyKSkpOworCisJCXJic19taW4gPSB2ZHNjX2NmZy0+cmNfbW9kZWxfc2l6ZSAtIHZkc2Nf
Y2ZnLT5pbml0aWFsX29mZnNldCArIG1heF9vZmZzZXQ7CisJfSBlbHNlIHsKKwkJcmJzX21pbiA9
IHZkc2NfY2ZnLT5yY19tb2RlbF9zaXplIC0gdmRzY19jZmctPmluaXRpYWxfb2Zmc2V0ICsKKwkJ
CURJVl9ST1VORF9VUCh2ZHNjX2NmZy0+aW5pdGlhbF94bWl0X2RlbGF5ICoKKwkJCQkgICAgIHZk
c2NfY2ZnLT5iaXRzX3Blcl9waXhlbCwgMTYpICsKKwkJCWdyb3Vwc19wZXJfbGluZSAqIHZkc2Nf
Y2ZnLT5maXJzdF9saW5lX2JwZ19vZmZzZXQ7CisJfQogCiAJaHJkX2RlbGF5ID0gRElWX1JPVU5E
X1VQKChyYnNfbWluICogMTYpLCB2ZHNjX2NmZy0+Yml0c19wZXJfcGl4ZWwpOwogCXZkc2NfY2Zn
LT5yY19iaXRzID0gKGhyZF9kZWxheSAqIHZkc2NfY2ZnLT5iaXRzX3Blcl9waXhlbCkgLyAxNjsK
LS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
