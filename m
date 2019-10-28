Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF76ACA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 14:08:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AA5620873
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 14:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA5620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 549A46E89E;
	Mon, 28 Oct 2019 14:08:50 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720040.outbound.protection.outlook.com [40.107.72.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AD6B6E89E
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 14:08:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQibTfBVSfUG/JULp08nBw5RRWt7CVFaMSMikDChlRPkD9jv754hHiRCyhLicJCXbjdgwDXHxpeuxJ3dSBVUhScl9QkRl9nQwn7r4te04kitF1MPxsKpaV6iaoqxqh5/yKzf7u/pQJM/ruRFXdWgawdZsMuAY0eUJvGTILohl9pCLANFEbq1+Ldzk9nBWF0PApPkAl6w/I5o4IT1GSKJVMlGdd+gixkfM/L+zopXcEF9VZXOwHy2NYaP9KH7GvR6qUuLtsJfaUfD5oJXcaKL7aYJqidOIyTvq5t6asy6By4IBtoZlvLh4p5QFupZe5VKxjZha3a4qquV168w6K4U8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GA5+eNVH7hM6hbd/2Iexd9nfF3xsW4x2xcT3HzGbhWU=;
 b=gN3FkyMn2EX3v2FZcxgAms3i8QQPBqnz+UfE4xG4YYmkm1mWOQ2488EpqpqbQPlwnlQDTpx1XPc92HxxOPLNhJa9Nyh1qGuOykpF/alszyTPqCRA4JUtuPBqv4iVYLESx009zYu/r1RTyamZDY8VH1zc++QLu+juCwm4qJ8SyoCiWEIjF9Vc3YmnDIDuxdkqEO7HDhAhkYYEiTld+JLAnVz5NZJR778zKjLklX98GZrQdoMfVmibOJd7KOcll4GEWjFtwLQjHucoZZEGdMd8zvFhWUGnWe9nykNJouldMf4m5UMVoyPwu6AE6GweeSChWTGZMfJ232JkGxkzoIuW6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM3PR12CA0123.namprd12.prod.outlook.com (2603:10b6:0:51::19) by
 DM5PR12MB1803.namprd12.prod.outlook.com (2603:10b6:3:10d::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Mon, 28 Oct 2019 14:08:47 +0000
Received: from BY2NAM03FT034.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e4a::200) by DM3PR12CA0123.outlook.office365.com
 (2603:10b6:0:51::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.22 via Frontend
 Transport; Mon, 28 Oct 2019 14:08:47 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BY2NAM03FT034.mail.protection.outlook.com (10.152.84.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2387.20 via Frontend Transport; Mon, 28 Oct 2019 14:08:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 28 Oct
 2019 09:08:46 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 28 Oct
 2019 09:08:46 -0500
Received: from kazvm.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 28 Oct 2019 09:08:45 -0500
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/11] Add DMCUB support for Renoir
Date: Mon, 28 Oct 2019 10:08:26 -0400
Message-ID: <20191028140837.7908-1-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(136003)(39860400002)(428003)(199004)(189003)(7696005)(53416004)(81156014)(81166006)(36756003)(4326008)(5660300002)(70586007)(70206006)(50226002)(50466002)(44832011)(48376002)(8936002)(47776003)(54906003)(316002)(478600001)(2351001)(51416003)(426003)(336012)(126002)(6916009)(1076003)(8676002)(186003)(476003)(2616005)(86362001)(2906002)(6666004)(26005)(356004)(305945005)(486006)(2870700001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1803; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b3af3e3-6ab2-4c6f-29a9-08d75bb05971
X-MS-TrafficTypeDiagnostic: DM5PR12MB1803:
X-Microsoft-Antispam-PRVS: <DM5PR12MB18034CBC5597A7657CD917C1EC660@DM5PR12MB1803.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0204F0BDE2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lfu41zfFS47cAl4r59OiWUMJAbW1I5BTUswYVYz5pYgj9vK+5geqo/MWQgp06CU+/3cHwBg1bz5WXJXa3MlWG1HZ9V8KrkWzf959K99ZCkb3tQ/kJr5jA9IB+D/hBwORkXuSzp8feyHxjZ5Pap4PDcqdEafPxnzUczJwcesnJiPUErgJaTGZKfi/ySzBBE8JygUlVykR7RtP1GQcDffLbR2uKPHU9OozWpuleHude+RuDWzqIh1n49AyZtvy6qIGk7JPldh3z1UbvyxQGn6xAYqtIdE9piMJuPwuHcJGFGsjbS/cpU9sMNDOtjwxco84Z/1IK73gGt0NJxgOqbie7fvsbSI9g2ULkMA4zbaVtLku7Gn4YyZL9k8090p32S0uRvCcx3Sc7hsn5ZMbXnpbk01PqJ/I1dNkqBUFs6FgO+Cd4K/DHAI7zW6zTODKJmwa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2019 14:08:46.7903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3af3e3-6ab2-4c6f-29a9-08d75bb05971
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1803
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GA5+eNVH7hM6hbd/2Iexd9nfF3xsW4x2xcT3HzGbhWU=;
 b=Er+DjUFX3c3YgXrLZ/7q4Hg1Vohpa0qQyWRXU9m2VURDNy2ITZh/DE3M+kU0nkSvVvJuzb539I/sQ6xUxu8ivwBOtWR4at88qmNxpKtEMMnDFTAaorPZ06vp1tqAZqBJZBTtZolWmC5q79uG4xygQdLfyXeXcX2InU7fptQqLXM=
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
Cc: Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028140826.myP7giYUgWhfM1BtcN2Y_ob8B3FX1hi3vmkoJ1S0MuQ@z>

VGhlIERNQ1VCIGlzIHRoZSBEaXNwbGF5IE1pY3JvQ29udHJvbGxlciBVbml0IEIsIGEgZGlzcGxh
eSBtaWNyb2NvbnRyb2xsZXIKdGhhdCBpcyByZXF1aXJlZCBmb3IgUmVub2lyIHRvIHN1cHBvcnQg
cmVhbHRpbWUgZGlzcGxheSBmZWF0dXJlcwooQUJNLCBQU1IpIGFuZCBkaXNwbGF5IGhhcmR3YXJl
IGluaXRpYWxpemF0aW9uLgoKVGhpcyBwYXRjaCBzZXJpZXMgYWRkcyB0aGUgcmVxdWlyZWQgZmly
bXdhcmUgbG9hZGluZyBzdXBwb3J0IGluIGFtZGdwdQphbmQgdGhlIERNVUIgc2VydmljZSBzdXBw
b3J0IGZvciBhbWRncHVfZG0gYW5kIGRjIHRvIGludGVyZmFjZSB3aXRoIHRoZQpETUNVQi4KClRo
ZSB0ZXJtIERNQ1VCIHdpbGwgZ2VuZXJhbGx5IHJlZmVyIHRvIHRoZSBhY3R1YWwgbWljcm9jb250
cm9sbGVyIHdoaWxlCkRNVUIgd2lsbCBnZW5lcmFsbHkgcmVmZXIgdG8gdGhlIHNvZnR3YXJlIGlu
dGVyZmFjZS4KCkNjOiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KCk5p
Y2hvbGFzIEthemxhdXNrYXMgKDkpOgogIGRybS9hbWRncHU6IEFkZCB1Y29kZSBzdXBwb3J0IGZv
ciBETUNVQgogIGRybS9hbWRncHU6IEFkZCBQU1AgbG9hZGluZyBzdXBwb3J0IGZvciBETUNVQiB1
Y29kZQogIGRybS9hbWQvZGlzcGxheTogRHJvcCBETUNVQiBmcm9tIERDTjIxIHJlc291cmNlcwog
IGRybS9hbWQvZGlzcGxheTogQWRkIHRoZSBETVVCIHNlcnZpY2UKICBkcm0vYW1kL2Rpc3BsYXk6
IEhvb2sgdXAgdGhlIERNVUIgc2VydmljZSBpbiBETQogIGRybS9hbWRncHU6IEFkZCBETUNVQiB0
byBmaXJtd2FyZSBxdWVyeSBpbnRlcmZhY2UKICBkcm0vYW1kL2Rpc3BsYXk6IEFkZCBETVVCIHN1
cHBvcnQgdG8gREMKICBkcm0vYW1kL2Rpc3BsYXk6IFJlZ2lzdGVyIERNVUIgc2VydmljZSB3aXRo
IERDCiAgZHJtL2FtZC9kaXNwbGF5OiBEcm9wIENPTkZJR19EUk1fQU1EX0RDX0RNVUIgZ3VhcmRz
CgpZb25ncWlhbmcgU3VuICgyKToKICBkcm0vYW1kL2Rpc3BsYXk6IENoYW5nZSBkbWN1IGluaXQg
c2VxdWVuY2UgZm9yIGRtY3ViIGxvYWRpbmcgZG1jdSBGVy4KICBkcm0vYW1kL2Rpc3BsYXk6IEFk
ZCBQU1AgRlcgdmVyc2lvbiBtYXNrLgoKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9rbXMuYyAgICAgICB8ICAxMiArCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cHNwLmMgICAgICAgfCAgIDMgKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vj
b2RlLmMgICAgIHwgIDExICstCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdWNv
ZGUuaCAgICAgfCAgIDkgKwogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L01ha2VmaWxlICAg
ICAgICAgIHwgICA0ICstCiAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1
X2RtLmMgfCAyNjEgKysrKysrKysrCiAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0v
YW1kZ3B1X2RtLmggfCAgNDYgKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9NYWtl
ZmlsZSAgICAgICB8ICAgNSArLQogLi4uL2RybS9hbWQvZGlzcGxheS9kYy9iaW9zL2NvbW1hbmRf
dGFibGUyLmMgIHwgIDgwICsrKwogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUv
ZGMuYyAgICAgIHwgICA0ICsKIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kYy5oICAg
ICAgICAgICB8ICAgNyArCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfZG11Yl9z
cnYuYyAgfCAxMTkgKysrKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY19kbXVi
X3Nydi5oICB8ICA2MCArKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY19oZWxw
ZXIuYyAgICB8IDI1NyArKysrKysrKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9k
Y190eXBlcy5oICAgICB8ICAgMyArCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNl
L2RjZV9kbWN1LmMgfCAgNzkgKysrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNl
L2RjZV9kbWN1LmggfCAgMTMgKwogLi4uL2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24xMF9k
cHBfY20uYyAgIHwgICA1ICsKIC4uLi9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24xMF9od19zZXF1
ZW5jZXIuYyB8ICAgMiArLQogLi4uL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMTAvZGNuMTBf
b3B0Yy5jIHwgICA1ICsKIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX21w
Yy5jICB8ICAgOCArCiAuLi4vZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX3Jlc291cmNl
LmMgfCAgMzYgKy0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbV9zZXJ2aWNlcy5o
ICB8ICAxMCArCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvaW5jL2h3L2RtY3UuaCAg
fCAgIDIgKwogLi4uL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvaW5jL3JlZ19oZWxwZXIuaCAgIHwg
IDE5ICsKIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9vc190eXBlcy5oICAgICB8ICAg
MSArCiAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9kbXViL2luYy9kbXViX2NtZC5oICAgfCAyNTYg
KysrKysrKysrCiAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9kbXViL2luYy9kbXViX3JiLmggICAg
fCAxMjkgKysrKysKIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvaW5jL2RtdWJfc3J2Lmgg
ICB8IDUwNSArKysrKysrKysrKysrKysrKysKIC4uLi9hbWQvZGlzcGxheS9kbXViL2luYy9kbXVi
X3RyYWNlX2J1ZmZlci5oICB8ICA1MSArKwogLi4uL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZG11Yi9p
bmMvZG11Yl90eXBlcy5oIHwgIDY0ICsrKwogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rt
dWIvc3JjL01ha2VmaWxlIHwgIDI3ICsKIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvc3Jj
L2RtdWJfZGNuMjAuYyB8IDEzNyArKysrKwogLi4uL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZG11Yi9z
cmMvZG11Yl9kY24yMC5oIHwgIDYyICsrKwogLi4uL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZG11Yi9z
cmMvZG11Yl9kY24yMS5jIHwgMTI2ICsrKysrCiAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9kbXVi
L3NyYy9kbXViX2RjbjIxLmggfCAgNDUgKysKIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIv
c3JjL2RtdWJfcmVnLmMgICB8IDEwOSArKysrCiAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9kbXVi
L3NyYy9kbXViX3JlZy5oICAgfCAxMjAgKysrKysKIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rt
dWIvc3JjL2RtdWJfc3J2LmMgICB8IDQxNSArKysrKysrKysrKysrKwogaW5jbHVkZS91YXBpL2Ry
bS9hbWRncHVfZHJtLmggICAgICAgICAgICAgICAgIHwgICAzICsKIDQwIGZpbGVzIGNoYW5nZWQs
IDMwNzIgaW5zZXJ0aW9ucygrKSwgMzggZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjX2RtdWJfc3J2LmMKIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfZG11Yl9zcnYuaAogY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kbXViL2luYy9kbXVi
X2NtZC5oCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rt
dWIvaW5jL2RtdWJfcmIuaAogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kbXViL2luYy9kbXViX3Nydi5oCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvaW5jL2RtdWJfdHJhY2VfYnVmZmVyLmgKIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZG11Yi9pbmMvZG11Yl90eXBl
cy5oCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIv
c3JjL01ha2VmaWxlCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RtdWIvc3JjL2RtdWJfZGNuMjAuYwogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kbXViL3NyYy9kbXViX2RjbjIwLmgKIGNyZWF0ZSBtb2RlIDEwMDY0
NCBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZG11Yi9zcmMvZG11Yl9kY24yMS5jCiBjcmVh
dGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvc3JjL2RtdWJf
ZGNuMjEuaAogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
bXViL3NyYy9kbXViX3JlZy5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RtdWIvc3JjL2RtdWJfcmVnLmgKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZG11Yi9zcmMvZG11Yl9zcnYuYwoKLS0gCjIuMjAuMQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
