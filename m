Return-Path: <SRS0=Fyns=Z7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A67C43603
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2019 18:58:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E41D206D3
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2019 18:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E41D206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24BA16E50B;
	Mon,  9 Dec 2019 18:58:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 248716E50D
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Dec 2019 18:58:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4OfqLlWSQ5gZqur4U9HLZ0IT5ngR6wO3PDHFQUxo+G1GHo+Gd5ohIftWbzjk/zZgB35xNnoYeS/tSpifWe3szIVtVWcw7G1FGtIUB2t97iTWoOJm9lOo2Lnb6Cj6+4tXNTT63Tx0On2P3Y7Zl8qnadmCR+0QkwXNsWzA2CghKrgw5GmvRtET59rcB3XkvO/BKgzUgL1TxjdB9gwJKXBE750ArfzM0yp9jaT8/wiX3LjMFrP4HNGXpEZB++lab2GvFgkNvwtXmJxyItqSnzZx2+uvB7ps4Bn0qITM0AhmSIi38lvpy9EJYSxS7VYLwJTFzJEEYkx/ZnXEHKTz2iVLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=es+tVo5aFLH8iQe0FQqZElIE96UX4m9k4ElzU3Jyrro=;
 b=UM4TvWSQKHm3c4zNB2fXCQzBJDRva/v3+kskIkpiOxRApu+g8PGFQNFDGxOcqLqJYRZjM9H4dXD/ccgoR0i6mH5i49EHwpvqY+tD6AO9VUloOcPvOtqoqnlMkP2BTN1dr40Kyoj3N95t206cTnLMoggZVPWCMuEumLJmUIf0lc0AQjqkm6O3EfeLYDqpb+htiYJnSiFRjfxXL/HnRPmdXajNLDaBKztFuwXvb8B1AUq7PwiFi5Z5zAmE6vKR/gizK2SBNWj0N894Nby1OR8/CU0K7LOZW838Z3zXZ6EKXRSFq/6mf6S8l4OVtxsfptK80IZXxjlq/NaSP2NpegpT6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.29.90) by
 DM6PR12MB3612.namprd12.prod.outlook.com (20.178.30.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Mon, 9 Dec 2019 18:58:32 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::71fe:9848:c834:1cd6]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::71fe:9848:c834:1cd6%3]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 18:58:32 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] tests/amdgpu: Fix buffer overflow
Date: Mon,  9 Dec 2019 13:58:01 -0500
Message-Id: <b03af1d731acd9bf554eb38e1d20c68240108db0.1575917839.git.luben.tuikov@amd.com>
X-Mailer: git-send-email 2.24.0.390.g083378cc35
In-Reply-To: <f57d33f459df0c733ef108b2beb889e844450542.1575917839.git.luben.tuikov@amd.com>
References: <f57d33f459df0c733ef108b2beb889e844450542.1575917839.git.luben.tuikov@amd.com>
X-ClientProxiedBy: YTOPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::20) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0.390.g083378cc35
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2316f362-ad9c-4b1e-7fe9-08d77cd9c962
X-MS-TrafficTypeDiagnostic: DM6PR12MB3612:|DM6PR12MB3612:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3612FDC850429AC142CD7B5F99580@DM6PR12MB3612.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:93;
X-Forefront-PRVS: 02462830BE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(199004)(189003)(2616005)(66946007)(36756003)(118296001)(66556008)(66476007)(86362001)(44832011)(316002)(54906003)(6506007)(52116002)(6486002)(4326008)(26005)(186003)(6512007)(2906002)(8676002)(81166006)(81156014)(2870700001)(305945005)(8936002)(6916009)(478600001)(6666004)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3612;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BztCuagwpUCSEpIMUeBqHDmeZQHY77jDRZldyxzwBepwqmph5iiXMRMxJ7uz7ULGpJIhNPAA6Wzo0ZhECpJdD+om+c1/qRWEoIM1ZBNcO6BIU9KyPej1wiLcYFYWxIN1XtTu29gyVqXgIiDs422IVJQxFwvi+CiOb3kWw2ebpbcpxuVc60aoK75hxe1sa9plfW58FhV9kBCpPp//VwJXxVQs8DYj5hzFgUag/0h62iRPsGWWh6wxBIb5SSxPNTxTqEsX7kPyNP/5MbLtGjIh2e2lAbxq361vEnxzHKMeQvCD0mOTvsqtzS/Vr/JMFlwopVLa8WxC8yXOIl5uXi9NV4CUEP60aMS4P5QEv4EjDOGQMCLUP6EaR9MOdZph8NtSPvPDWTaA7W/7TAfRZuTkfKQmc+VVqveLkJMxph5XoEqX5eDFp8FWmM2mPYt/ZZQw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2316f362-ad9c-4b1e-7fe9-08d77cd9c962
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2019 18:58:32.7246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ySNghoOlqr+2l2DCwaMn4KvBvPuPOA6UZG5NyLNqqHN0wBrN+8TLQRiJrPQK9S8I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3612
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=es+tVo5aFLH8iQe0FQqZElIE96UX4m9k4ElzU3Jyrro=;
 b=hkH+YGGtpzv00ACZi7PR2wLE+RiaeRZX/2y2/jifWQaJivzBGY+sdyUdNRnRCT35LwcD0il9LdcnlgkKAP/sTkpuBxQcODB0232uHCRgcnEAY2CWVX7lb8e2+Cf+q2TuoBk+kdsSI/DASwWocsInG3ekTcRzi6pj77PeZf4icZQ=
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
ZGdwdS9yYXNfdGVzdHMuYyBiL3Rlc3RzL2FtZGdwdS9yYXNfdGVzdHMuYwppbmRleCBmNzQ1MTY2
Yi4uYzk2Y2RlNDUgMTAwNjQ0Ci0tLSBhL3Rlc3RzL2FtZGdwdS9yYXNfdGVzdHMuYworKysgYi90
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
QCAtODM3LDcgKzg0NCw3IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9yYXNfYmFzaWNfdGVzdCh2b2lk
KQogCWludCBpOwogCWludCBqOwogCXVpbnQzMl90IGZlYXR1cmVzOwotCWNoYXIgcGF0aFsxMDI0
XTsKKwljaGFyIHBhdGhbUEFUSF9TSVpFXTsKIAogCXJldCA9IGlzX2ZpbGVfb2soIi9zeXMvbW9k
dWxlL2FtZGdwdS9wYXJhbWV0ZXJzL3Jhc19tYXNrIiwgT19SRE9OTFkpOwogCUNVX0FTU0VSVF9F
UVVBTChyZXQsIDApOwpAQCAtODQ5LDExICs4NTYsMTUgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3Jh
c19iYXNpY190ZXN0KHZvaWQpCiAJCQkJc2l6ZW9mKGZlYXR1cmVzKSwgJmZlYXR1cmVzKTsKIAkJ
Q1VfQVNTRVJUX0VRVUFMKHJldCwgMCk7CiAKLQkJc3ByaW50ZihwYXRoLCAiJXMlcyIsIGdldF9y
YXNfZGVidWdmc19yb290KCksICJyYXNfY3RybCIpOworCQlzbnByaW50ZihwYXRoLCBzaXplb2Yo
cGF0aCksICIlcyIsIGdldF9yYXNfZGVidWdmc19yb290KCkpOworCQlzdHJsY3B5KHBhdGgsICJy
YXNfY3RybCIsIHNpemVvZihwYXRoKSk7CisKIAkJcmV0ID0gaXNfZmlsZV9vayhwYXRoLCBPX1dS
T05MWSk7CiAJCUNVX0FTU0VSVF9FUVVBTChyZXQsIDApOwogCi0JCXNwcmludGYocGF0aCwgIiVz
JXMiLCBnZXRfcmFzX3N5c2ZzX3Jvb3QoKSwgImZlYXR1cmVzIik7CisJCXNucHJpbnRmKHBhdGgs
IHNpemVvZihwYXRoKSwgIiVzIiwgZ2V0X3Jhc19zeXNmc19yb290KCkpOworCQlzdHJsY3B5KHBh
dGgsICJmZWF0dXJlcyIsIHNpemVvZihwYXRoKSk7CisKIAkJcmV0ID0gaXNfZmlsZV9vayhwYXRo
LCBPX1JET05MWSk7CiAJCUNVX0FTU0VSVF9FUVVBTChyZXQsIDApOwogCkBAIC04NjUsMTEgKzg3
NiwxNyBAQCBzdGF0aWMgdm9pZCBhbWRncHVfcmFzX2Jhc2ljX3Rlc3Qodm9pZCkKIAkJCWlmICgh
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
IAkJfQotLSAKMi4yNC4wLjM5MC5nMDgzMzc4Y2MzNQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4
