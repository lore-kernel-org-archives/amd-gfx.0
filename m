Return-Path: <SRS0=UM6f=Z4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D80CC43603
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 04:33:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 599012245C
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 04:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 599012245C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27A666F96C;
	Fri,  6 Dec 2019 04:33:00 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 514326F96C
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2019 04:32:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/MS3v5XvMDUi4mlDFbuvWQHXQ4hckfRpCc+OKOKjQlcI0GvW7oZHwQW2EC2CRxP6muXhrL9qM5lJc1uKZZBSU2j8IifVsAMFqzTr75c82djDChWberfES/b7Vkd5P1+/kQUm6EEJblJa4F5BvG7O4A53k2ege73nWABsE91rsstYoAgcmO7aaztr5YSxWcsAczSvq8wXq3mUZ0bOSfjFJbxT4bea+kBEuj4zJAGQIYF1s8eDbK4Ln49CBwXB9LzIwWatlV0RwyOpkgPYJvVnlIk9TudCMwdSe6l+C9dfnvFGC+39+ahnrC99QecMwGK8msygPKhqKb00FZXilvQJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjoApxiK0QtIoXLDX9K6PoAo09+xGg7nQkiavbkA9HA=;
 b=BctsO2IK8dii7Z2bc3hz9ZFPEBba6xs8IBhY50OKkEp1DtdE1SF4gkh3eg7W9qlhZH9Uv6Q1M1sqSQ6uHRUsZKIUbbmoqFGnp74kjnYIeYRN7tZLIiF3BabozyY0GwlrNVe+yg5kAjRgVIAhPNtYICSNsCohWwGgcDiZeYcvheC+NyBBbnfn0jm1W2i4HGx6rZDVx9yVV9mUeRL1OjgD5Zs+5pKAj+3KvbQ/RJ9lcFW77CWKs8LX0MFUfBABtJrNGgKYQHue5mQdJjGCBttOK7s3ZhGOtXRHAoo5eEbrxfYzD2z45W0YukmLh1Wlvy0FfNLyVZJNEqrVAW4zbSbMSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.29.90) by
 DM6PR12MB3483.namprd12.prod.outlook.com (20.178.31.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Fri, 6 Dec 2019 04:32:57 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::71fe:9848:c834:1cd6]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::71fe:9848:c834:1cd6%3]) with mapi id 15.20.2516.014; Fri, 6 Dec 2019
 04:32:57 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] tests/amdgpu: Fix buffer overflow
Date: Thu,  5 Dec 2019 23:32:18 -0500
Message-Id: <b17f6331d2fba425848a9717d2b8df50ee5e3a81.1575606273.git.luben.tuikov@amd.com>
X-Mailer: git-send-email 2.24.0.155.gd9f6f3b619
In-Reply-To: <f57d33f459df0c733ef108b2beb889e844450542.1575606273.git.luben.tuikov@amd.com>
References: <f57d33f459df0c733ef108b2beb889e844450542.1575606273.git.luben.tuikov@amd.com>
X-ClientProxiedBy: YTOPR0101CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::43) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0.155.gd9f6f3b619
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4e2073e7-ec47-4bc3-1dd1-08d77a055e56
X-MS-TrafficTypeDiagnostic: DM6PR12MB3483:|DM6PR12MB3483:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB348349151829046C4F1ABCD8995F0@DM6PR12MB3483.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:93;
X-Forefront-PRVS: 0243E5FD68
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(189003)(199004)(66946007)(478600001)(316002)(2870700001)(8936002)(86362001)(54906003)(118296001)(36756003)(81166006)(5660300002)(14454004)(81156014)(50226002)(25786009)(305945005)(2906002)(48376002)(6916009)(44832011)(50466002)(8676002)(6486002)(66476007)(51416003)(26005)(11346002)(6666004)(4326008)(14444005)(6512007)(2616005)(76176011)(66556008)(99286004)(186003)(6506007)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3483;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hejc1SgF74DPYZayJ8ACJ9A7JnxAu2ebCTzb/BNmiissJH0haudsIkgFk0Xez8IFUtk8trTF6JasOm7OYSR8rD8TlkKBgPrnLqvLoh6ApE7/6SVutdAesIRFnx90Wn0H9Bb7eD1aauEnv+ewb/ybtSrP2dczkqvcJIXD2VebyfEs6PECAfy3HOM9KdNTuwSGIoihvfsGItCrXTTCWK0TGEdAyWvNPbK2ipZz1hJdIwQ6AqoqMYjqVVWLTvPIL0oO/dO0j3vzOdUk9yXYAZC6Ue4W0eUjdkq3EAuMnTLGSBpBB0D4PtlQ1r4iUccE1f5hqH9WriHB/NZAmHvBTZs6R9KYg5Uq6Nm7mCr/92D7YUQuHHEe6DqH3q5a5aHictxR5h0PiC9zg+8WGBrtWcn7zuMe1DDaPAcJRw8/ElFiJhbpvxET8uUslJalKShOT2DY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2073e7-ec47-4bc3-1dd1-08d77a055e56
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2019 04:32:57.4020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVqe5m6l09AETy1F5sSEPGTNSS4mpInFpE+S+30dCg4Wk/sxiULdxi/58SO0sqzl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3483
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjoApxiK0QtIoXLDX9K6PoAo09+xGg7nQkiavbkA9HA=;
 b=LHtBsuo2Pltohld86SCu0smK//VSyZLDra3KenwlJGNjyTcNyYt63Zu1YyygxyapJb+4PPZKoHcrl+oOt4M4RuWAj/ydWNWDDYhggFI/c21rXnWdM5QOynAz+XH1mdVHk2+X2d/E44PB007CUuLwlN9PpnmtLwjtJY7Lp2ER6Qo=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBwYXRjaCBmaXhlcyB0aGUgZm9sbG93aW5nIHdhcm5pbmc6Ci1XZm9ybWF0LW92ZXJmbG93
PQoKU2lnbmVkLW9mZi1ieTogTHViZW4gVHVpa292IDxsdWJlbi50dWlrb3ZAYW1kLmNvbT4KLS0t
CiB0ZXN0cy9hbWRncHUvbWVzb24uYnVpbGQgfCAgMSArCiB0ZXN0cy9hbWRncHUvcmFzX3Rlc3Rz
LmMgfCA0MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tCiAyIGZpbGVz
IGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L3Rlc3RzL2FtZGdwdS9tZXNvbi5idWlsZCBiL3Rlc3RzL2FtZGdwdS9tZXNvbi5idWlsZAppbmRl
eCAyYTQ4YjQzZi4uZmFhZjBlZTYgMTAwNjQ0Ci0tLSBhL3Rlc3RzL2FtZGdwdS9tZXNvbi5idWls
ZAorKysgYi90ZXN0cy9hbWRncHUvbWVzb24uYnVpbGQKQEAgLTI4LDYgKzI4LDcgQEAgaWYgZGVw
X2N1bml0LmZvdW5kKCkKICAgICApLAogICAgIGRlcGVuZGVuY2llcyA6IFtkZXBfY3VuaXQsIGRl
cF90aHJlYWRzXSwKICAgICBpbmNsdWRlX2RpcmVjdG9yaWVzIDogW2luY19yb290LCBpbmNfZHJt
LCBpbmNsdWRlX2RpcmVjdG9yaWVzKCcuLi8uLi9hbWRncHUnKV0sCisgICAgbGlua19hcmdzIDog
WyctbGJzZCddLAogICAgIGxpbmtfd2l0aCA6IFtsaWJkcm0sIGxpYmRybV9hbWRncHVdLAogICAg
IGluc3RhbGwgOiB3aXRoX2luc3RhbGxfdGVzdHMsCiAgICkKZGlmZiAtLWdpdCBhL3Rlc3RzL2Ft
ZGdwdS9yYXNfdGVzdHMuYyBiL3Rlc3RzL2FtZGdwdS9yYXNfdGVzdHMuYwppbmRleCA0YzM5NTM4
Mi4uOWMyMDZlNDAgMTAwNjQ0Ci0tLSBhL3Rlc3RzL2FtZGdwdS9yYXNfdGVzdHMuYworKysgYi90
ZXN0cy9hbWRncHUvcmFzX3Rlc3RzLmMKQEAgLTMwLDYgKzMwLDEwIEBACiAjaW5jbHVkZSA8ZmNu
dGwuaD4KICNpbmNsdWRlIDxzdGRpby5oPgogI2luY2x1ZGUgInhmODZkcm0uaCIKKyNpbmNsdWRl
IDxic2Qvc3RyaW5nLmg+CisjaW5jbHVkZSA8bGltaXRzLmg+CisKKyNkZWZpbmUgUEFUSF9TSVpF
IFBBVEhfTUFYCiAKICNkZWZpbmUgQVJSQVlfU0laRShhKSAoc2l6ZW9mKGEpIC8gc2l6ZW9mKChh
KVswXSkpCiAKQEAgLTQ5OCw3ICs1MDIsNyBAQCBzdGF0aWMgaW50IGdldF9maWxlX2NvbnRlbnRz
KGNoYXIgKmZpbGUsIGNoYXIgKmJ1ZiwgaW50IHNpemUpOwogCiBzdGF0aWMgaW50IGFtZGdwdV9y
YXNfbG9va3VwX2lkKGRybURldmljZVB0ciBkZXZpY2UpCiB7Ci0JY2hhciBwYXRoWzEwMjRdOwor
CWNoYXIgcGF0aFtQQVRIX1NJWkVdOwogCWNoYXIgc3RyWzEyOF07CiAJZHJtUGNpQnVzSW5mbyBp
bmZvOwogCWludCBpOwpAQCAtNTI1LDggKzUyOSw4IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3Jhc19s
b29rdXBfaWQoZHJtRGV2aWNlUHRyIGRldmljZSkKIC8vaGVscGVycwogCiBzdGF0aWMgaW50IHRl
c3RfY2FyZDsKLXN0YXRpYyBjaGFyIHN5c2ZzX3BhdGhbMTAyNF07Ci1zdGF0aWMgY2hhciBkZWJ1
Z2ZzX3BhdGhbMTAyNF07CitzdGF0aWMgY2hhciBzeXNmc19wYXRoW1BBVEhfU0laRV07CitzdGF0
aWMgY2hhciBkZWJ1Z2ZzX3BhdGhbUEFUSF9TSVpFXTsKIHN0YXRpYyB1aW50MzJfdCByYXNfbWFz
azsKIHN0YXRpYyBhbWRncHVfZGV2aWNlX2hhbmRsZSBkZXZpY2VfaGFuZGxlOwogCkBAIC02MDUs
MTAgKzYwOSwxMSBAQCBzdGF0aWMgaW50IGFtZGdwdV9yYXNfaXNfZmVhdHVyZV9zdXBwb3J0ZWQo
ZW51bSBhbWRncHVfcmFzX2Jsb2NrIGJsb2NrKQogCiBzdGF0aWMgaW50IGFtZGdwdV9yYXNfaW52
b2tlKHN0cnVjdCByYXNfZGVidWdfaWYgKmRhdGEpCiB7Ci0JY2hhciBwYXRoWzEwMjRdOworCWNo
YXIgcGF0aFtQQVRIX1NJWkVdOwogCWludCByZXQ7CiAKLQlzcHJpbnRmKHBhdGgsICIlcyVzIiwg
Z2V0X3Jhc19kZWJ1Z2ZzX3Jvb3QoKSwgInJhc19jdHJsIik7CisJc25wcmludGYocGF0aCwgc2l6
ZW9mKHBhdGgpLCAiJXMiLCBnZXRfcmFzX2RlYnVnZnNfcm9vdCgpKTsKKwlzdHJsY3B5KHBhdGgs
ICJyYXNfY3RybCIsIHNpemVvZihwYXRoKSk7CiAKIAlyZXQgPSBzZXRfZmlsZV9jb250ZW50cyhw
YXRoLCAoY2hhciAqKWRhdGEsIHNpemVvZigqZGF0YSkpCiAJCS0gc2l6ZW9mKCpkYXRhKTsKQEAg
LTYxOSwxNCArNjI0LDE2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3Jhc19xdWVyeV9lcnJfY291bnQo
ZW51bSBhbWRncHVfcmFzX2Jsb2NrIGJsb2NrLAogCQl1bnNpZ25lZCBsb25nICp1ZSwgdW5zaWdu
ZWQgbG9uZyAqY2UpCiB7CiAJY2hhciBidWZbNjRdOwotCWNoYXIgbmFtZVsxMDI0XTsKKwljaGFy
IG5hbWVbUEFUSF9TSVpFXTsKIAogCSp1ZSA9ICpjZSA9IDA7CiAKIAlpZiAoYW1kZ3B1X3Jhc19p
c19mZWF0dXJlX3N1cHBvcnRlZChibG9jaykgPD0gMCkKIAkJcmV0dXJuIC0xOwogCi0Jc3ByaW50
ZihuYW1lLCAiJXMlcyVzIiwgZ2V0X3Jhc19zeXNmc19yb290KCksIHJhc19ibG9ja19zdHIoYmxv
Y2spLCAiX2Vycl9jb3VudCIpOworCXNucHJpbnRmKG5hbWUsIHNpemVvZihuYW1lKSwgIiVzIiwg
Z2V0X3Jhc19zeXNmc19yb290KCkpOworCXN0cmxjcHkobmFtZSwgcmFzX2Jsb2NrX3N0cihibG9j
ayksIHNpemVvZihuYW1lKSk7CisJc3RybGNweShuYW1lLCAiX2Vycl9jb3VudCIsIHNpemVvZihu
YW1lKSk7CiAKIAlpZiAoaXNfZmlsZV9vayhuYW1lLCBPX1JET05MWSkpCiAJCXJldHVybiAwOwpA
QCAtODM5LDcgKzg0Niw3IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9yYXNfYmFzaWNfdGVzdCh2b2lk
KQogCWludCBpOwogCWludCBqOwogCXVpbnQzMl90IGZlYXR1cmVzOwotCWNoYXIgcGF0aFsxMDI0
XTsKKwljaGFyIHBhdGhbUEFUSF9TSVpFXTsKIAogCXJldCA9IGlzX2ZpbGVfb2soIi9zeXMvbW9k
dWxlL2FtZGdwdS9wYXJhbWV0ZXJzL3Jhc19tYXNrIiwgT19SRE9OTFkpOwogCUNVX0FTU0VSVF9F
UVVBTChyZXQsIDApOwpAQCAtODUxLDExICs4NTgsMTUgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3Jh
c19iYXNpY190ZXN0KHZvaWQpCiAJCQkJc2l6ZW9mKGZlYXR1cmVzKSwgJmZlYXR1cmVzKTsKIAkJ
Q1VfQVNTRVJUX0VRVUFMKHJldCwgMCk7CiAKLQkJc3ByaW50ZihwYXRoLCAiJXMlcyIsIGdldF9y
YXNfZGVidWdmc19yb290KCksICJyYXNfY3RybCIpOworCQlzbnByaW50ZihwYXRoLCBzaXplb2Yo
cGF0aCksICIlcyIsIGdldF9yYXNfZGVidWdmc19yb290KCkpOworCQlzdHJsY3B5KHBhdGgsICJy
YXNfY3RybCIsIHNpemVvZihwYXRoKSk7CisKIAkJcmV0ID0gaXNfZmlsZV9vayhwYXRoLCBPX1dS
T05MWSk7CiAJCUNVX0FTU0VSVF9FUVVBTChyZXQsIDApOwogCi0JCXNwcmludGYocGF0aCwgIiVz
JXMiLCBnZXRfcmFzX3N5c2ZzX3Jvb3QoKSwgImZlYXR1cmVzIik7CisJCXNucHJpbnRmKHBhdGgs
IHNpemVvZihwYXRoKSwgIiVzIiwgZ2V0X3Jhc19zeXNmc19yb290KCkpOworCQlzdHJsY3B5KHBh
dGgsICJmZWF0dXJlcyIsIHNpemVvZihwYXRoKSk7CisKIAkJcmV0ID0gaXNfZmlsZV9vayhwYXRo
LCBPX1JET05MWSk7CiAJCUNVX0FTU0VSVF9FUVVBTChyZXQsIDApOwogCkBAIC04NjcsMTEgKzg3
OCwxNyBAQCBzdGF0aWMgdm9pZCBhbWRncHVfcmFzX2Jhc2ljX3Rlc3Qodm9pZCkKIAkJCWlmICgh
KCgxIDw8IGopICYgcmFzX2Jsb2NrX21hc2tfYmFzaWMpKQogCQkJCWNvbnRpbnVlOwogCi0JCQlz
cHJpbnRmKHBhdGgsICIlcyVzJXMiLCBnZXRfcmFzX3N5c2ZzX3Jvb3QoKSwgcmFzX2Jsb2NrX3N0
cihqKSwgIl9lcnJfY291bnQiKTsKKwkJCXNucHJpbnRmKHBhdGgsIHNpemVvZihwYXRoKSwgIiVz
IiwgZ2V0X3Jhc19zeXNmc19yb290KCkpOworCQkJc3RybGNweShwYXRoLCByYXNfYmxvY2tfc3Ry
KGopLCBzaXplb2YocGF0aCkpOworCQkJc3RybGNweShwYXRoLCAiX2Vycl9jb3VudCIsIHNpemVv
ZihwYXRoKSk7CisKIAkJCXJldCA9IGlzX2ZpbGVfb2socGF0aCwgT19SRE9OTFkpOwogCQkJQ1Vf
QVNTRVJUX0VRVUFMKHJldCwgMCk7CiAKLQkJCXNwcmludGYocGF0aCwgIiVzJXMlcyIsIGdldF9y
YXNfZGVidWdmc19yb290KCksIHJhc19ibG9ja19zdHIoaiksICJfZXJyX2luamVjdCIpOworCQkJ
c25wcmludGYocGF0aCwgc2l6ZW9mKHBhdGgpLCAiJXMiLCBnZXRfcmFzX2RlYnVnZnNfcm9vdCgp
KTsKKwkJCXN0cmxjcHkocGF0aCwgcmFzX2Jsb2NrX3N0cihqKSwgc2l6ZW9mKHBhdGgpKTsKKwkJ
CXN0cmxjcHkocGF0aCwgIl9lcnJfaW5qZWN0Iiwgc2l6ZW9mKHBhdGgpKTsKKwogCQkJcmV0ID0g
aXNfZmlsZV9vayhwYXRoLCBPX1dST05MWSk7CiAJCQlDVV9BU1NFUlRfRVFVQUwocmV0LCAwKTsK
IAkJfQotLSAKMi4yNC4wLjE1NS5nZDlmNmYzYjYxOQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4
