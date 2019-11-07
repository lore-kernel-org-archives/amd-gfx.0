Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D143AC5DF60
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 15:56:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DB2320663
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 15:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB2320663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EE726F72C;
	Thu,  7 Nov 2019 15:56:45 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700049.outbound.protection.outlook.com [40.107.70.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 274016F72C
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 15:56:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmRXY/gznCgIRWi9jn9JvKVjKsO4V740aQAqGS8tNULqWOKoKWoJ7JyvSUWIkF6go3XahKyoTz5p1OqeGGmye2SgBK60xuDXnmVCGiKz4SJepATBobGULl7OgF4sdg0+Nh73INfocrvDp1/fzUqnP9F4GaBZtkZjPrE3FHtXhTwmjYZqsbsfgxbZByYfntEmhK6FZ3k9yFQBJEb0EaERaEUci33KnoRiHSbRPfRemoY9xvlsbiJ+AJbHaINVpWxyemXkb2GMjCEDzL16Jq6wdx6MjFTBsGSGSKnemIuKT9rhRx9yx8NIPYZds+2Zjg6BCCAXIGZLXG+n76MXjnc+ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdBt7zTLVNi5e+tJyzOXUFrrHaLfsjgfTUE+VgjAgJI=;
 b=B3nFrSE5B/As8YEHkz8OzThOiIrwJ0GXGFboD7aoU9KLgafi6TbIdrfEPi7I50qg1/A9c9XKw1vJyF8KLSdna2BpEhO8kHWFgcrlU7DjbfX6DT1K8CICyv4KGHoMx8egR/nszB+R2TIbkQpnYkF5hsmXrMABg7f7y5K2hIr6No+ajASe1bZed1RFvihSUsyRCcb6KUkUhq5c6kM/GkpmG2QgtoCPEEwtllSIObejmmWi/PbtzSfzmjQG7AODfBo7R/Wsl9tXAY3Ytta7eBghdHV2qPnIs9fbsGSmiXPtBgsXsOhg5go0QmM9LjhX2aQvFSNYbvAClFmx+M7AaOeIlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from BN8PR12CA0016.namprd12.prod.outlook.com (2603:10b6:408:60::29)
 by MW2PR12MB2556.namprd12.prod.outlook.com (2603:10b6:907:a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24; Thu, 7 Nov
 2019 15:56:42 +0000
Received: from DM3NAM03FT025.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::201) by BN8PR12CA0016.outlook.office365.com
 (2603:10b6:408:60::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.24 via Frontend
 Transport; Thu, 7 Nov 2019 15:56:41 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM3NAM03FT025.mail.protection.outlook.com (10.152.82.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2430.20 via Frontend Transport; Thu, 7 Nov 2019 15:56:41 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 7 Nov 2019
 09:56:40 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 7 Nov 2019 09:56:40 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/14] HDCP 2 Content Protection v2
Date: Thu, 7 Nov 2019 10:56:14 -0500
Message-ID: <20191107155628.19446-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(136003)(428003)(199004)(189003)(426003)(476003)(2616005)(2906002)(2351001)(316002)(4326008)(26005)(126002)(36756003)(336012)(70586007)(81156014)(81166006)(6916009)(8936002)(16586007)(54906003)(14444005)(50226002)(86362001)(53416004)(47776003)(186003)(8676002)(478600001)(5660300002)(7696005)(51416003)(70206006)(1076003)(305945005)(48376002)(486006)(6666004)(50466002)(356004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2556; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ca1e22a-f005-4c57-9a10-08d7639b14c6
X-MS-TrafficTypeDiagnostic: MW2PR12MB2556:
X-Microsoft-Antispam-PRVS: <MW2PR12MB255662449FAA8AFE1016CF1FF9780@MW2PR12MB2556.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0214EB3F68
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iHJfUHT2NOCG7JUq//ULUbC9NNtHo74HxXOJ/RnuSGGW7Bky9EML51CpYeIDvTJrG59m/XrqvR7xQx5ZaufIUA9XXlEVUMZd3QPhP3fK2dQg+TtkE/jalbYDr0dcJ29YZAIELBKJMFcc8cd1EjC0FStSbIoTzqhFdbwakIz6IoEqwdydri2fdEX8No6C5Y+HCzNPrAPFAEUU1emPVW971jqkINrvuKWM8d9s+M+maAk1e5zK1HjEj5k8NGobudvs+KdRRsWtLPh04Z000IbqqCYJu8tr9+ObjsiVTJmX9/tbJVHy9zDziRalvQFY9FB4m2BUolaYqKdIGSbYCmb7Fn+VTJi2Jok+Wwm+TPZkdx8NvSSDIdZ2kGDlEwso2I09wj7XyHWlM19RUIuiEk6XWR3yi+yD7ml5G3bsd4EJJtrxhIfXTxNgwiDJvochi4sr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2019 15:56:41.5014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca1e22a-f005-4c57-9a10-08d7639b14c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2556
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdBt7zTLVNi5e+tJyzOXUFrrHaLfsjgfTUE+VgjAgJI=;
 b=BqK7xCxJSKNo9tP7ETHqgmplbo1qECsG8XD/5vvLuDs2c/cDnGpUw4f40UQlZ82pU63geK0qQ1HlMnKyc10nsV6AvBY9Q1MuIk2cPDeVA2nFMXVeIHEjJItNqFw0Z4WNfaycEoEw56jU0Cs3kKRt3lI9lkoADCh49u6zHOJFZXY=
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Wenjing.Liu@amd.com,
 harry.wentland@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107155614.Uxo_JHkc5x1T3z0LDdNlm75i7ir3ED5onsx3bnEL6s8@z>

SnVzdCBsaWtlIHdpdGggdGhlIDEuNCBzZXJpZXMgb2YgcGF0Y2hlcyBUaGlzIG9ubHkgaW50cm9k
dWNlcyB0aGUKYWJpbGl0eSB0byBhdXRoZW50aWNhdGUgYW5kIGVuY3J5cHQgdGhlIGxpbmsuIFRo
ZXNlIHBhdGNoZXMgYnkKdGhlbXNlbHZlcyBkb24ndCBjb25zdGl0dXRlIGEgY29tcGxldGUgYW5k
IGNvbXBsaWFudCBIRENQIGNvbnRlbnQKcHJvdGVjdGlvbiBzb2x1dGlvbiBidXQgYXJlIGEgcmVx
dWlyZW1lbnQgZm9yIHN1Y2ggYSBzb2x1dGlvbi4KClN1bW1hcnkgb2YgdGhlIGNoYW5nZXMKKkFk
ZHMgMi4yIGNvZGUgdG8gdGhlIG1vZHVsZQoqRW5hYmxlZCBIRENQIDIuMiBhdXRoZW50aWNhdGlv
bi9lbmNyeXB0aW9uCipBZGQgdHlwZTAvMSBzZWxlY3Rpb24gZm9yIDIuMgoqQWRkIE1TVCBzdXBw
b3J0IChPbmx5IHRlc3RlZCBzaW5nbGUgZGFpc3kgY2hhaW4gdXNlY2FzZSkKKnVzZSBkcm1faGRj
cC5oIGZvciBtYWNyb3MvZGVmaW5lcwoqZml4IHN0YXRpYyBhbmFseXNpcyBidWcKCnYyOgogIC11
c2UgbWFjcm9zL2RlZmluZXMgZnJvbSBkcm1faGRjcC5oCiAgCWRybS9hbWQvZGlzcGxheTogYWRk
IGFuZCB1c2UgZGVmaW5lcyBmcm9tIGRybV9oZGNwLmgKCWRybS9hbWQvZGlzcGxheTogdXNlIGRy
bSBkZWZpbmVzIGZvciBNQVggQ0FTQ0FERSBNQVNLCglkcm0vYW1kL2Rpc3BsYXk6IHNwbGl0IHJ4
c3RhdHVzIGZvciBoZG1pIGFuZCBkcAogIC1maXggc3RhdGljIGFuYWx5c2lzIGJ1ZwoJZHJtL2Ft
ZC9kaXNwbGF5OiBGaXggc3RhdGljIGFuYWx5c2lzIGJ1ZyBpbiB2YWxpZGF0ZV9ia3N2CgoKQmhh
d2FucHJlZXQgTGFraGEgKDE0KToKICBkcm0vYW1kL2Rpc3BsYXk6IEFkZCBQU1AgYmxvY2sgdG8g
dmVyaWZ5IEhEQ1AyLjIgc3RlcHMKICBkcm0vYW1kL2Rpc3BsYXk6IEFkZCBEREMgaGFuZGxlcyBm
b3IgSERDUDIuMgogIGRybS9hbWQvZGlzcGxheTogQWRkIGV4ZWN1dGlvbiBhbmQgdHJhbnNpdGlv
biBzdGF0ZXMgZm9yIEhEQ1AyLjIKICBkcm0vYW1kL2Rpc3BsYXk6IEFkZCBsb2dnaW5nIGZvciBI
RENQMi4yCiAgZHJtL2FtZC9kaXNwbGF5OiBDaGFuZ2UgRVJST1IgdG8gV0FSTiBmb3IgSERDUCBt
b2R1bGUKICBkcm0vYW1kL2Rpc3BsYXk6IEVuYWJsZSBIRENQIDIuMgogIGRybS9hbWQvZGlzcGxh
eTogSGFuZGxlIGhkY3AyLjIgdHlwZTAvMSBpbiBkbQogIGRybS9hbWQvZGlzcGxheTogUmVmYWN0
b3IgSERDUCB0byBoYW5kbGUgbXVsdGlwbGUgZGlzcGxheXMgcGVyIGxpbmsKICBkcm0vYW1kL2Rp
c3BsYXk6IGFkZCBmb3JjZSBUeXBlMC8xIGZsYWcKICBkcm0vYW1kL2Rpc3BsYXk6IFJlZmFjdG9y
IEhEQ1AgZW5jcnlwdGlvbiBzdGF0dXMgdXBkYXRlCiAgZHJtL2FtZC9kaXNwbGF5OiBhZGQgYW5k
IHVzZSBkZWZpbmVzIGZyb20gZHJtX2hkY3AuaAogIGRybS9hbWQvZGlzcGxheTogdXNlIGRybSBk
ZWZpbmVzIGZvciBNQVggQ0FTQ0FERSBNQVNLCiAgZHJtL2FtZC9kaXNwbGF5OiBzcGxpdCByeHN0
YXR1cyBmb3IgaGRtaSBhbmQgZHAKICBkcm0vYW1kL2Rpc3BsYXk6IEZpeCBzdGF0aWMgYW5hbHlz
aXMgYnVnIGluIHZhbGlkYXRlX2Jrc3YKCiAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVf
ZG0vYW1kZ3B1X2RtLmMgfCAgMjYgKy0KIC4uLi9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1
X2RtX2hkY3AuYyAgICB8ICA2NCArLQogLi4uL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVf
ZG1faGRjcC5oICAgIHwgICA5ICstCiAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9tb2R1bGVzL2hk
Y3AvTWFrZWZpbGUgfCAgIDMgKy0KIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMvaGRj
cC9oZGNwLmMgICB8IDEwMSArLQogLi4uL2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9kdWxlcy9oZGNw
L2hkY3AuaCAgIHwgMTk3ICsrKy0KIC4uLi9kaXNwbGF5L21vZHVsZXMvaGRjcC9oZGNwMV9leGVj
dXRpb24uYyAgICB8ICA0MCArLQogLi4uL2Rpc3BsYXkvbW9kdWxlcy9oZGNwL2hkY3AyX2V4ZWN1
dGlvbi5jICAgIHwgODg0ICsrKysrKysrKysrKysrKysrKwogLi4uL2Rpc3BsYXkvbW9kdWxlcy9o
ZGNwL2hkY3AyX3RyYW5zaXRpb24uYyAgIHwgNjc0ICsrKysrKysrKysrKysKIC4uLi9kcm0vYW1k
L2Rpc3BsYXkvbW9kdWxlcy9oZGNwL2hkY3BfZGRjLmMgICB8IDMyNiArKysrKysrCiAuLi4vZHJt
L2FtZC9kaXNwbGF5L21vZHVsZXMvaGRjcC9oZGNwX2xvZy5jICAgfCAxMTggKysrCiAuLi4vZHJt
L2FtZC9kaXNwbGF5L21vZHVsZXMvaGRjcC9oZGNwX2xvZy5oICAgfCAgOTggKy0KIC4uLi9kcm0v
YW1kL2Rpc3BsYXkvbW9kdWxlcy9oZGNwL2hkY3BfcHNwLmMgICB8IDUxMSArKysrKysrKystCiAu
Li4vZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMvaGRjcC9oZGNwX3BzcC5oICAgfCAxOTQgKysrKwog
Li4uL2RybS9hbWQvZGlzcGxheS9tb2R1bGVzL2luYy9tb2RfaGRjcC5oICAgIHwgIDE1ICstCiAx
NSBmaWxlcyBjaGFuZ2VkLCAzMTM3IGluc2VydGlvbnMoKyksIDEyMyBkZWxldGlvbnMoLSkKIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9kdWxlcy9oZGNw
L2hkY3AyX2V4ZWN1dGlvbi5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L21vZHVsZXMvaGRjcC9oZGNwMl90cmFuc2l0aW9uLmMKCi0tIAoyLjE3LjEKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
