Return-Path: <SRS0=0yA7=YY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD543CA9ECB
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 14:42:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 887A220873
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 14:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887A220873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 429346EEBE;
	Thu, 31 Oct 2019 14:42:57 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820079.outbound.protection.outlook.com [40.107.82.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D2AD6EEB0
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2019 14:42:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XoemsoIdpD3Oh9gn6E0cVioX9zmb9dE6kWX1TDTQYxN4731WfpWqObDk5/Mimv+cBvQyUwkkKo8aw5v8rz3bXyqy5OSiu7mClhO3LVI/wMYFPP72vGIbyidNR/WUyf8rpWsBzaHiijzwZWsaU4PeCxrfU8jx7dI0dV8SkbEkLkFw/ZQokZjuIy/vC1nqj1BQVues7wxMTeBz1YG9x3qG5YObcV0dWgRV74OecuGUuJD6kVv/I79ox3MWU8sSeajSUou2KkZaF4bfQj+hx+ak1Dke4RLt4AEJPEtdvbx99oYdZQVqwaofbsqn/QXE1NPx4aokpJlLzjQvQaEMpykpnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TR89/w8JxBkDTLsIiq8qKEDRmcJ4YgkF1EqlPEF9M1o=;
 b=MF6V9crP4woeMjKB+jdDYVby74H8amhAggYZNra1EoroTXR8meXN/8v8JmGJcLo8hideP1ZH+tmeafHyEwEXlx6FLlOEHD0L9HqlyWeoy6qA1MDMD7VUb5H8ykndUzCxvtOGZZwgTQKIppIwAUNMjf6r9fXhqDto8Li2VS9A7SEfkxcEXDn2RB9JObQ0cMgWhGHGe8vYobP4EkNDMNX2rJ+pso0yOe4iJ//9VEjSoS0pjsdoJ5ODL4x+iS8E5hyrV8osj2PAKnxo5DIGAc0uSDNU2RWt0HwyVIrWWNlF1+jm3AtohMwMHyTGp/LLUK5igLMT7T2qF+HWk/AcYnj20w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from CY4PR12CA0033.namprd12.prod.outlook.com (2603:10b6:903:129::19)
 by MN2PR12MB2912.namprd12.prod.outlook.com (2603:10b6:208:ac::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.22; Thu, 31 Oct
 2019 14:42:43 +0000
Received: from CO1NAM03FT024.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::206) by CY4PR12CA0033.outlook.office365.com
 (2603:10b6:903:129::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.17 via Frontend
 Transport; Thu, 31 Oct 2019 14:42:43 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM03FT024.mail.protection.outlook.com (10.152.80.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2387.20 via Frontend Transport; Thu, 31 Oct 2019 14:42:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 31 Oct
 2019 09:42:41 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 31 Oct
 2019 09:42:41 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 31 Oct 2019 09:42:40 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/20] drm/amd/display: initialize lttpr
Date: Thu, 31 Oct 2019 10:42:05 -0400
Message-ID: <20191031144210.24011-16-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191031144210.24011-1-Bhawanpreet.Lakha@amd.com>
References: <20191031144210.24011-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(346002)(136003)(396003)(428003)(199004)(189003)(5660300002)(356004)(336012)(2906002)(53416004)(486006)(2351001)(426003)(6666004)(476003)(2616005)(446003)(126002)(11346002)(4326008)(1076003)(36756003)(305945005)(70586007)(186003)(70206006)(7696005)(26005)(76176011)(47776003)(51416003)(6916009)(14444005)(8936002)(50226002)(478600001)(8676002)(48376002)(50466002)(86362001)(316002)(81156014)(16586007)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2912; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3ddeebd-5e39-4ccb-72dc-08d75e109671
X-MS-TrafficTypeDiagnostic: MN2PR12MB2912:
X-Microsoft-Antispam-PRVS: <MN2PR12MB2912C6A9BA32BF3227325388F9630@MN2PR12MB2912.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 02070414A1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ppeod6qWYucv/bXkTZ0M1NIbPQ7igTwMYDC1Ik4K4Ugic0BxIBSBUBsYLZRnfyexTM+jbvmsUZmN4e24cpWTB7DZl+UAc2tAzTmlX0hJNBKVKPYVep96Ob+vwUFuaVf4uHybVep/DsClt2/NtgZUaLIIkX6MI17bcXa85cx3Alv4J/+PzXSObGtlWzOf0lgKeiLLFnmZ2mOEqnJZtfR0ILIP7q2KCI+oHw/ImIX7QpBHKVNm9RCK9+LYZ6yDfg1h9GhRLGTtrVe5eT9/ticUu13w+WxCC6GxAMRs0ddgemI5GGkKbBm+b1S+mj2Wg2vSQ3jR8zbEL+xQlo9jT/hGllI+eFK4PliVoDiKEVStoX2ZVUEk3ppSwm9Jj99RNcqWTx4YjZKWy7tI3QWOcRaRplGW1a/SwrrSGpGe4KSol+ockmNEjWBxsq6FmTLQdjdI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2019 14:42:43.0958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ddeebd-5e39-4ccb-72dc-08d75e109671
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2912
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TR89/w8JxBkDTLsIiq8qKEDRmcJ4YgkF1EqlPEF9M1o=;
 b=RNRWjkVLiVNQ6DbezMACytoAQxVHcY0DG3lvejUXWltDNKVbDMJsg/WAK9HzYGfZZrgbvOlZDol98mmsoMqfJz+5ir8ljenfuenyQWy5NEQo78WzTymhWfruMOj+DNoe0w28WfsScM07YqyZvq4RdN9o7MhYAdNnfBoqf07jrbg=
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
Cc: abdoulaye berthe <abdoulaye.berthe@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191031144205.cvqQ7Nhjn2vGgtwJEW6VHpHbXmgRba32bp2HXRz5Bik@z>

RnJvbTogYWJkb3VsYXllIGJlcnRoZSA8YWJkb3VsYXllLmJlcnRoZUBhbWQuY29tPgoKW0Rlc2Ny
aXB0aW9uXQpXaGVuIHJlYWRpbmcgbGluaywgdXBkYXRlIHRoZSBwcm9jZWR1cmUgYXMgZm9sbG93
czoKMS1TZXQgYXV4IHRpbWVvdXQgdG8gZXh0ZW5kZWQ6IDMuMm1zCjItU3RhcnQgd2l0aCByZWFk
aW5nIGx0dHByIGNhcHMKMy1EZXRlcm1pbmUgaWYgbHR0cHIgc3VwcG9ydCBzaG91bGQgYmUgZW5h
YmxlZC4gUmVzZXQgYXV4IHRpbWVvdXQgdG8KNDAwdXMgaWYgbm8gcmVwZWF0ZXIgaXMgZm91bmQu
CgpTaWduZWQtb2ZmLWJ5OiBhYmRvdWxheWUgYmVydGhlIDxhYmRvdWxheWUuYmVydGhlQGFtZC5j
b20+ClJldmlld2VkLWJ5OiBBcmljIEN5ciA8QXJpYy5DeXJAYW1kLmNvbT4KLS0tCiAuLi4vZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZHAuYyAgfCA1NiArKysrKysrKysrKysr
KysrKysrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaCAgICAgICAgICAgfCAg
MiArCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfbGluay5oICAgICAgfCAgMSAr
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfdHlwZXMuaCAgICAgfCAzNiArKysr
KysrKysrKysKIDQgZmlsZXMgY2hhbmdlZCwgOTUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZHAuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZHAuYwppbmRleCAwZjU5YjY4
YWE0YzIuLjJhODlmOTBlZjdhNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2NvcmUvZGNfbGlua19kcC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9jb3JlL2RjX2xpbmtfZHAuYwpAQCAtMjEsNiArMjEsOSBAQAogI2RlZmluZSBEQ19MT0dH
RVIgXAogCWxpbmstPmN0eC0+bG9nZ2VyCiAKKworI2RlZmluZSBEUF9SRVBFQVRFUl9DT05GSUdV
UkFUSU9OX0FORF9TVEFUVVNfT0ZGU0VUICAgMHg1MAorCiAvKiBtYXhpbXVtIHByZSBlbXBoYXNp
cyBsZXZlbCBhbGxvd2VkIGZvciBlYWNoIHZvbHRhZ2Ugc3dpbmcgbGV2ZWwqLwogc3RhdGljIGNv
bnN0IGVudW0gZGNfcHJlX2VtcGhhc2lzIHZvbHRhZ2Vfc3dpbmdfdG9fcHJlX2VtcGhhc2lzW10g
PSB7CiAJCVBSRV9FTVBIQVNJU19MRVZFTDMsCkBAIC0yNzUzLDYgKzI3NTYsMTQgQEAgc3RhdGlj
IGJvb2wgcmV0cmlldmVfbGlua19jYXAoc3RydWN0IGRjX2xpbmsgKmxpbmspCiAJaW50IGk7CiAJ
c3RydWN0IGRwX3NpbmtfaHdfZndfcmV2aXNpb24gZHBfaHdfZndfcmV2aXNpb247CiAKKwkvKiBT
ZXQgZGVmYXVsdCB0aW1lb3V0IHRvIDMuMm1zIGFuZCByZWFkIExUVFBSIGNhcGFiaWxpdGllcyAq
LworCWJvb2wgZXh0X3RpbWVvdXRfc3VwcG9ydCA9IGxpbmstPmRjLT5jYXBzLmV4dGVuZGVkX2F1
eF90aW1lb3V0X3N1cHBvcnQgJiYKKwkJCSFsaW5rLT5kYy0+Y29uZmlnLmRpc2FibGVfZXh0ZW5k
ZWRfdGltZW91dF9zdXBwb3J0OworCWlmIChleHRfdGltZW91dF9zdXBwb3J0KSB7CisJCXN0YXR1
cyA9IGRjX2xpbmtfYXV4X2NvbmZpZ3VyZV90aW1lb3V0KGxpbmstPmRkYywgTElOS19BVVhfREVG
QVVMVF9FWFRFTkRFRF9USU1FT1VUX1BFUklPRCk7CisJCWxpbmstPmlzX2x0dHByX21vZGVfdHJh
bnNwYXJlbnQgPSB0cnVlOworCX0KKwogCW1lbXNldChkcGNkX2RhdGEsICdcMCcsIHNpemVvZihk
cGNkX2RhdGEpKTsKIAltZW1zZXQoJmRvd25fc3RybV9wb3J0X2NvdW50LAogCQknXDAnLCBzaXpl
b2YodW5pb24gZG93bl9zdHJlYW1fcG9ydF9jb3VudCkpOwpAQCAtMjc4NSw2ICsyNzk2LDUxIEBA
IHN0YXRpYyBib29sIHJldHJpZXZlX2xpbmtfY2FwKHN0cnVjdCBkY19saW5rICpsaW5rKQogCQly
ZXR1cm4gZmFsc2U7CiAJfQogCisJaWYgKGV4dF90aW1lb3V0X3N1cHBvcnQpIHsKKwkJc3RhdHVz
ID0gY29yZV9saW5rX3JlYWRfZHBjZCgKKwkJCQlsaW5rLAorCQkJCURQX1BIWV9SRVBFQVRFUl9D
TlQsCisJCQkJJmxpbmstPmRwY2RfY2Fwcy5sdHRwcl9jYXBzLnBoeV9yZXBlYXRlcl9jbnQsCisJ
CQkJc2l6ZW9mKGxpbmstPmRwY2RfY2Fwcy5sdHRwcl9jYXBzLnBoeV9yZXBlYXRlcl9jbnQpKTsK
KworCQlpZiAobGluay0+ZHBjZF9jYXBzLmx0dHByX2NhcHMucGh5X3JlcGVhdGVyX2NudCA+IDAp
IHsKKworCQkJbGluay0+aXNfbHR0cHJfbW9kZV90cmFuc3BhcmVudCA9IGZhbHNlOworCisJCQlz
dGF0dXMgPSBjb3JlX2xpbmtfcmVhZF9kcGNkKAorCQkJCQlsaW5rLAorCQkJCQlEUF9MVF9UVU5B
QkxFX1BIWV9SRVBFQVRFUl9GSUVMRF9EQVRBX1NUUlVDVFVSRV9SRVYsCisJCQkJCSh1aW50OF90
ICopJmxpbmstPmRwY2RfY2Fwcy5sdHRwcl9jYXBzLnJldmlzaW9uLAorCQkJCQlzaXplb2YobGlu
ay0+ZHBjZF9jYXBzLmx0dHByX2NhcHMucmV2aXNpb24pKTsKKworCQkJc3RhdHVzID0gY29yZV9s
aW5rX3JlYWRfZHBjZCgKKwkJCQkJbGluaywKKwkJCQkJRFBfTUFYX0xJTktfUkFURV9QSFlfUkVQ
RUFURVIsCisJCQkJCSZsaW5rLT5kcGNkX2NhcHMubHR0cHJfY2Fwcy5tYXhfbGlua19yYXRlLAor
CQkJCQlzaXplb2YobGluay0+ZHBjZF9jYXBzLmx0dHByX2NhcHMubWF4X2xpbmtfcmF0ZSkpOwor
CisJCQlzdGF0dXMgPSBjb3JlX2xpbmtfcmVhZF9kcGNkKAorCQkJCQlsaW5rLAorCQkJCQlEUF9Q
SFlfUkVQRUFURVJfTU9ERSwKKwkJCQkJKHVpbnQ4X3QgKikmbGluay0+ZHBjZF9jYXBzLmx0dHBy
X2NhcHMubW9kZSwKKwkJCQkJc2l6ZW9mKGxpbmstPmRwY2RfY2Fwcy5sdHRwcl9jYXBzLm1vZGUp
KTsKKworCQkJc3RhdHVzID0gY29yZV9saW5rX3JlYWRfZHBjZCgKKwkJCQkJbGluaywKKwkJCQkJ
RFBfTUFYX0xBTkVfQ09VTlRfUEhZX1JFUEVBVEVSLAorCQkJCQkmbGluay0+ZHBjZF9jYXBzLmx0
dHByX2NhcHMubWF4X2xhbmVfY291bnQsCisJCQkJCXNpemVvZihsaW5rLT5kcGNkX2NhcHMubHR0
cHJfY2Fwcy5tYXhfbGFuZV9jb3VudCkpOworCisJCQlzdGF0dXMgPSBjb3JlX2xpbmtfcmVhZF9k
cGNkKAorCQkJCQlsaW5rLAorCQkJCQlEUF9QSFlfUkVQRUFURVJfRVhURU5ERURfV0FJVF9USU1F
T1VULAorCQkJCQkmbGluay0+ZHBjZF9jYXBzLmx0dHByX2NhcHMubWF4X2V4dF90aW1lb3V0LAor
CQkJCQlzaXplb2YobGluay0+ZHBjZF9jYXBzLmx0dHByX2NhcHMubWF4X2V4dF90aW1lb3V0KSk7
CisJCX0gZWxzZSB7CisJCQlkY19saW5rX2F1eF9jb25maWd1cmVfdGltZW91dChsaW5rLT5kZGMs
IExJTktfQVVYX0RFRkFVTFRfVElNRU9VVF9QRVJJT0QpOworCQl9CisJfQorCiAJewogCQl1bmlv
biB0cmFpbmluZ19hdXhfcmRfaW50ZXJ2YWwgYXV4X3JkX2ludGVydmFsOwogCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaCBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9kYy5oCmluZGV4IDMyZWFmZmY2YjA0My4uM2ZhZDE3ZDk2ZmViIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaAorKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaApAQCAtOTg3LDYgKzk4Nyw4IEBAIHN0cnVjdCBk
cGNkX2NhcHMgewogCXVuaW9uIGRwY2RfZmVjX2NhcGFiaWxpdHkgZmVjX2NhcDsKIAlzdHJ1Y3Qg
ZHBjZF9kc2NfY2FwYWJpbGl0aWVzIGRzY19jYXBzOwogI2VuZGlmCisJc3RydWN0IGRjX2x0dHBy
X2NhcHMgbHR0cHJfY2FwczsKKwogfTsKIAogI2luY2x1ZGUgImRjX2xpbmsuaCIKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY19saW5rLmggYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfbGluay5oCmluZGV4IDkyNzBlNDNjZDViYi4uNjdiYTY2
NjZhMzI0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfbGlu
ay5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY19saW5rLmgKQEAgLTg1
LDYgKzg1LDcgQEAgc3RydWN0IGRjX2xpbmsgewogCWJvb2wgbGlua19zdGF0ZV92YWxpZDsKIAli
b29sIGF1eF9hY2Nlc3NfZGlzYWJsZWQ7CiAJYm9vbCBzeW5jX2x0X2luX3Byb2dyZXNzOworCWJv
b2wgaXNfbHR0cHJfbW9kZV90cmFuc3BhcmVudDsKIAogCS8qIGNhcHMgaXMgdGhlIHNhbWUgYXMg
cmVwb3J0ZWRfbGlua19jYXAuIGxpbmtfdHJhaW5nIHVzZQogCSAqIHJlcG9ydGVkX2xpbmtfY2Fw
LiBXaWxsIGNsZWFuIHVwLiAgVE9ETwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2RjX3R5cGVzLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNf
dHlwZXMuaAppbmRleCBkOWJlOGZjMzg4OWYuLjEwNjRhYWQ0NmQ1OSAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjX3R5cGVzLmgKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2RjX3R5cGVzLmgKQEAgLTExOSw2ICsxMTksNyBAQCBzdHJ1Y3Qg
ZGNfY29udGV4dCB7CiAjZGVmaW5lIERDX0VESURfQkxPQ0tfU0laRSAxMjgKICNkZWZpbmUgTUFY
X1NVUkZBQ0VfTlVNIDQKICNkZWZpbmUgTlVNX1BJWEVMX0ZPUk1BVFMgMTAKKyNkZWZpbmUgTUFY
X1JFUEVBVEVSX0NOVCA4CiAKICNpbmNsdWRlICJkY19kZGNfdHlwZXMuaCIKIApAQCAtNDAyLDYg
KzQwMyw0MSBAQCBlbnVtIGRwY2RfZG93bnN0cmVhbV9wb3J0X21heF9icGMgewogCURPV05fU1RS
RUFNX01BWF8xMkJQQywKIAlET1dOX1NUUkVBTV9NQVhfMTZCUEMKIH07CisKKworZW51bSBsaW5r
X3RyYWluaW5nX29mZnNldCB7CisJRFBSWCAgICAgICAgICAgICAgICA9IDAsCisJTFRUUFJfUEhZ
X1JFUEVBVEVSMSA9IDEsCisJTFRUUFJfUEhZX1JFUEVBVEVSMiA9IDIsCisJTFRUUFJfUEhZX1JF
UEVBVEVSMyA9IDMsCisJTFRUUFJfUEhZX1JFUEVBVEVSNCA9IDQsCisJTFRUUFJfUEhZX1JFUEVB
VEVSNSA9IDUsCisJTFRUUFJfUEhZX1JFUEVBVEVSNiA9IDYsCisJTFRUUFJfUEhZX1JFUEVBVEVS
NyA9IDcsCisJTFRUUFJfUEhZX1JFUEVBVEVSOCA9IDgKK307CisKK2VudW0gbHR0cHJfbW9kZSB7
CisJcGh5X3JlcGVhdGVyX21vZGVfdHJhbnNwYXJlbnQJCT0gMHg1NSwKKwlwaHlfcmVwZWF0ZXJf
bW9kZV9ub25fdHJhbnNwYXJlbnQJPSAweEFBCit9OworCitlbnVtIGx0dHByX3JldiB7CisJbHR0
cHJfcmV2X3Vua25vd24JPSAweDAsCisJbHR0cHJfcmV2XzE0CQk9IDB4MTQsCisJbHR0cHJfcmV2
X21heAkJPSAweDIwCit9OworCitzdHJ1Y3QgZGNfbHR0cHJfY2FwcyB7CisJZW51bSBsdHRwcl9y
ZXYgcmV2aXNpb247CisJZW51bSBsdHRwcl9tb2RlIG1vZGU7CisJdWludDhfdCBtYXhfbGFuZV9j
b3VudDsKKwl1aW50OF90IG1heF9saW5rX3JhdGU7CisJdWludDhfdCBwaHlfcmVwZWF0ZXJfY250
OworCXVpbnQ4X3QgbWF4X2V4dF90aW1lb3V0OworCXVpbnQ4X3QgYXV4X3JkX2ludGVydmFsW01B
WF9SRVBFQVRFUl9DTlQgLSAxXTsKK307CisKIHN0cnVjdCBkY19kb25nbGVfY2FwcyB7CiAJLyog
ZG9uZ2xlIHR5cGUgKERQIGNvbnZlcnRlciwgQ1Ygc21hcnQgZG9uZ2xlKSAqLwogCWVudW0gZGlz
cGxheV9kb25nbGVfdHlwZSBkb25nbGVfdHlwZTsKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
