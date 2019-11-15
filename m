Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E492C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 03:35:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F8B720709
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 03:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8B720709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D601A6F3EA;
	Fri, 15 Nov 2019 03:35:32 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690087.outbound.protection.outlook.com [40.107.69.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16B2A6F3E4
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 03:35:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXztClEqTSsqfFYPpN5dOrdp9PEyhF7g39SQz0fyxwRHyw6OnOFHjJyWwHL9cF+5aO2ghRVCK35ToBV1l9zd84gBbB+v9NxcksPrCHCE9FOrL1qNeQH4Rkn9WT4x9LxI8VNvjaT1IYMOtyoD0yreDD0Yx+vUaVX0kxnG/MaA+q4GcsSMS/U+CpO99cvp9Lki1dvZqc9Ca92Is/F37b3vAQqHDpbX2d1Lp9xhp2F/ZAcB0diivh5W2uGJehTv4XcZdV4PwekJYEBrdPDkQRTDv2xq2zPJciPsphbVasRltz9rOy60BiQzcsvRaaSIdbki3C2hGUNaomQlv5tCezrXDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yn3zw0B3t3ZJua17rsSmA6/3vXaTEUvMcIdvdjQhbWA=;
 b=bVUb0rwsNA6NjSF8IEfMQs0KqUKxImU022oSvKXsqTGnMV3kZw7kq+BErIlAnJdVYCsW5cVB73j+KZHvOIqVQX2UjZuNEqRzXia/PsvG49oH8jI3tF3gy7iUJjGEQ0iyXjLLgVvHNJgyijtgEssS77ry/QVls/rDT3+1JZ8GC9rOE5NImjFo+sj1f/iUb5kTDm9xBRmQzNZRboaFI1xQ2LKuEnmLoHFBHkJGcuD8k5b5N2GUJIivlw9PCvMgHOhjl59CUwFSh7PxChwP25kuHZRlx6xNWbSuAfLRp/c72+8wyd17WM0qHuhBzlC2DWcVvy29MW6jbZETQ/ZqKCExwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3838.namprd12.prod.outlook.com (10.255.238.203) by
 MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 03:35:28 +0000
Received: from MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4]) by MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4%7]) with mapi id 15.20.2451.027; Fri, 15 Nov 2019
 03:35:28 +0000
From: Aaron Liu <aaron.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/12] tests/amdgpu: expand write linear helper for security
 (v3)
Date: Fri, 15 Nov 2019 11:34:48 +0800
Message-Id: <1573788895-3936-5-git-send-email-aaron.liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
X-ClientProxiedBy: HK0PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:203:36::18) To MN2PR12MB3838.namprd12.prod.outlook.com
 (2603:10b6:208:16c::11)
MIME-Version: 1.0
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 21e21d3e-cd69-46d7-3da1-08d7697cdc1d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3663:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3663DF5549518112B0A7C400F0700@MN2PR12MB3663.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 02229A4115
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(51416003)(52116002)(6512007)(76176011)(7736002)(386003)(26005)(11346002)(44832011)(486006)(4326008)(2616005)(25786009)(6506007)(6436002)(6486002)(5660300002)(478600001)(66556008)(446003)(186003)(86362001)(3846002)(6116002)(14454004)(48376002)(50466002)(66946007)(8936002)(50226002)(305945005)(66476007)(476003)(81156014)(81166006)(8676002)(2906002)(15650500001)(6916009)(16586007)(66066001)(14444005)(316002)(54906003)(2351001)(2361001)(47776003)(6666004)(36756003)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3663;
 H:MN2PR12MB3838.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FKyDIaA9x/GUKPmBSjSCzMry3258x4lqmInDWKXAR45LnocPthOErrhq6FOJ0DbzKo1oHY1HGOUBSA0wUTMXbkA4FClmgenZxUp16+L9b3LTvBDoWqZPmvH0oon/ScsmICwqAbjZzv3hni4NGAVIRXMk5gwLZsyxX2hSRpU8+b4taATT624zBYoe+I3fdYXDg6HO1+bt0aknu/fXIDVqcPBrdMX6GW1B6AjWBQPB649R+HlZMI3gaj5+RMNAc8TM+/R3bdtIrj5Pk+HTLzElkktqckqcFTpDbSinAww6CLdL3OvqPyy5+DhZF5cqR9VIeRXsiNrTLEB4G3XdlnvCxFbOaP/98j9RAGK+MJkYHCalYiWAxS+SfsXO1FlsC6t9PRE/2x1uhhX5Nue7IffVqldEARAi3Gdp9UO51so866kuxJR9djsesIZ5IgeY3vRc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e21d3e-cd69-46d7-3da1-08d7697cdc1d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 03:35:28.8647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9T+oB15Z8K+jSlnpfRb/vHGTc0o1hC8kD8PqIAd/f2Ds3RdQpA+hVUyDX/UnyhQH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3663
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yn3zw0B3t3ZJua17rsSmA6/3vXaTEUvMcIdvdjQhbWA=;
 b=jjs1Rm/LRfL2NavOBUzYSi2zy7juukeNF4irFSzBcvxEoSxSVT20hwW3OQJ2n5I21WTevUOXhyJkcyUfF5CVjJnl3CeFAh+RIcP45cVHz+bxwLPnQmVWsMSH7fw0vX70imCB1RnMWf1Kru6LBv1rq0NuCi4JgO1m7gF9eHolDcI=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Aaron.Liu@amd.com; 
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
Cc: Marek.Olsak@amd.com, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>, Luben.Tuikov@amd.com, Alexander.Deucher@amd.com,
 Leo.Liu@amd.com, Christian.Koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115033448.Nar6251DOyz_SJdn6z_4w-uP_wHWuOKLKeTdCb_v_b8@z>

RnJvbTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KClRoaXMgcGF0Y2ggZXhwYW5kIHdy
aXRlIGxpbmVhciBoZWxwZXIgZm9yIHNlY3VyaXR5IHRvIHN1Ym1pdCB0aGUgY29tbWFuZAp3aXRo
IHNlY3VyZSBjb250ZXh0LgoKdjI6IHJlZmluZSB0aGUgZnVuY3Rpb24gaW1wbGVtZW50YXRpb24u
CnYzOiByZW1vdmUgYW1kZ3B1X2NzX2N0eF9jcmVhdGUzLgoKU2lnbmVkLW9mZi1ieTogSHVhbmcg
UnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWFyb24gTGl1IDxhYXJvbi5s
aXVAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJA
YW1kLmNvbT4KLS0tCiB0ZXN0cy9hbWRncHUvYW1kZ3B1X3Rlc3QuaCB8ICA0ICsrKysKIHRlc3Rz
L2FtZGdwdS9iYXNpY190ZXN0cy5jIHwgMTUgKysrKysrKysrKysrKy0tCiAyIGZpbGVzIGNoYW5n
ZWQsIDE3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdHMv
YW1kZ3B1L2FtZGdwdV90ZXN0LmggYi90ZXN0cy9hbWRncHUvYW1kZ3B1X3Rlc3QuaAppbmRleCBi
N2Y4ZGUyLi42N2JlNDM3IDEwMDY0NAotLS0gYS90ZXN0cy9hbWRncHUvYW1kZ3B1X3Rlc3QuaAor
KysgYi90ZXN0cy9hbWRncHUvYW1kZ3B1X3Rlc3QuaApAQCAtMjYyLDYgKzI2Miw5IEBAIENVX0JP
T0wgc3VpdGVfc2VjdXJpdHlfdGVzdHNfZW5hYmxlKHZvaWQpOwogICovCiBleHRlcm4gQ1VfVGVz
dEluZm8gc2VjdXJpdHlfdGVzdHNbXTsKIAorZXh0ZXJuIHZvaWQKK2FtZGdwdV9jb21tYW5kX3N1
Ym1pc3Npb25fd3JpdGVfbGluZWFyX2hlbHBlcl93aXRoX3NlY3VyZSh1bnNpZ25lZCBpcF90eXBl
LAorCQkJCQkJCSAgYm9vbCBzZWN1cmUpOwogCiAvKioKICAqIEhlbHBlciBmdW5jdGlvbnMKQEAg
LTQ1Miw0ICs0NTUsNSBAQCBzdGF0aWMgaW5saW5lIGJvb2wgYXNpY19pc19hcmN0dXJ1cyh1aW50
MzJfdCBhc2ljX2lkKQogCX0KIH0KIAorCiAjZW5kaWYgIC8qICNpZmRlZiBfQU1ER1BVX1RFU1Rf
SF8gKi8KZGlmZiAtLWdpdCBhL3Rlc3RzL2FtZGdwdS9iYXNpY190ZXN0cy5jIGIvdGVzdHMvYW1k
Z3B1L2Jhc2ljX3Rlc3RzLmMKaW5kZXggYTU3ZGNiYi4uMzFjOWE1NCAxMDA2NDQKLS0tIGEvdGVz
dHMvYW1kZ3B1L2Jhc2ljX3Rlc3RzLmMKKysrIGIvdGVzdHMvYW1kZ3B1L2Jhc2ljX3Rlc3RzLmMK
QEAgLTcxLDcgKzcxLDcgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3Rlc3RfZXhlY19jc19oZWxwZXIo
YW1kZ3B1X2NvbnRleHRfaGFuZGxlIGNvbnRleHRfaGFuZGxlLAogCQkJCSAgICAgICBpbnQgcmVz
X2NudCwgYW1kZ3B1X2JvX2hhbmRsZSAqcmVzb3VyY2VzLAogCQkJCSAgICAgICBzdHJ1Y3QgYW1k
Z3B1X2NzX2liX2luZm8gKmliX2luZm8sCiAJCQkJICAgICAgIHN0cnVjdCBhbWRncHVfY3NfcmVx
dWVzdCAqaWJzX3JlcXVlc3QpOwotIAorCiBDVV9UZXN0SW5mbyBiYXNpY190ZXN0c1tdID0gewog
CXsgIlF1ZXJ5IEluZm8gVGVzdCIsICBhbWRncHVfcXVlcnlfaW5mb190ZXN0IH0sCiAJeyAiVXNl
cnB0ciBUZXN0IiwgIGFtZGdwdV91c2VycHRyX3Rlc3QgfSwKQEAgLTEzNjEsNyArMTM2MSw4IEBA
IHN0YXRpYyB2b2lkIGFtZGdwdV90ZXN0X2V4ZWNfY3NfaGVscGVyKGFtZGdwdV9jb250ZXh0X2hh
bmRsZSBjb250ZXh0X2hhbmRsZSwKIAlDVV9BU1NFUlRfRVFVQUwociwgMCk7CiB9CiAKLXN0YXRp
YyB2b2lkIGFtZGdwdV9jb21tYW5kX3N1Ym1pc3Npb25fd3JpdGVfbGluZWFyX2hlbHBlcih1bnNp
Z25lZCBpcF90eXBlKQordm9pZCBhbWRncHVfY29tbWFuZF9zdWJtaXNzaW9uX3dyaXRlX2xpbmVh
cl9oZWxwZXJfd2l0aF9zZWN1cmUodW5zaWduZWQgaXBfdHlwZSwKKwkJCQkJCQkgICAgICAgYm9v
bCBzZWN1cmUpCiB7CiAJY29uc3QgaW50IHNkbWFfd3JpdGVfbGVuZ3RoID0gMTI4OwogCWNvbnN0
IGludCBwbTRfZHcgPSAyNTY7CkBAIC0xMzkwLDcgKzEzOTEsMTEgQEAgc3RhdGljIHZvaWQgYW1k
Z3B1X2NvbW1hbmRfc3VibWlzc2lvbl93cml0ZV9saW5lYXJfaGVscGVyKHVuc2lnbmVkIGlwX3R5
cGUpCiAJciA9IGFtZGdwdV9xdWVyeV9od19pcF9pbmZvKGRldmljZV9oYW5kbGUsIGlwX3R5cGUs
IDAsICZod19pcF9pbmZvKTsKIAlDVV9BU1NFUlRfRVFVQUwociwgMCk7CiAKKwlmb3IgKGkgPSAw
OyBzZWN1cmUgJiYgKGkgPCAyKTsgaSsrKQorCQlndHRfZmxhZ3NbaV0gfD0gQU1ER1BVX0dFTV9D
UkVBVEVfRU5DUllQVEVEOworCiAJciA9IGFtZGdwdV9jc19jdHhfY3JlYXRlKGRldmljZV9oYW5k
bGUsICZjb250ZXh0X2hhbmRsZSk7CisKIAlDVV9BU1NFUlRfRVFVQUwociwgMCk7CiAKIAkvKiBw
cmVwYXJlIHJlc291cmNlICovCkBAIC0xNDY5LDYgKzE0NzQsMTIgQEAgc3RhdGljIHZvaWQgYW1k
Z3B1X2NvbW1hbmRfc3VibWlzc2lvbl93cml0ZV9saW5lYXJfaGVscGVyKHVuc2lnbmVkIGlwX3R5
cGUpCiAJQ1VfQVNTRVJUX0VRVUFMKHIsIDApOwogfQogCitzdGF0aWMgdm9pZCBhbWRncHVfY29t
bWFuZF9zdWJtaXNzaW9uX3dyaXRlX2xpbmVhcl9oZWxwZXIodW5zaWduZWQgaXBfdHlwZSkKK3sK
KwlhbWRncHVfY29tbWFuZF9zdWJtaXNzaW9uX3dyaXRlX2xpbmVhcl9oZWxwZXJfd2l0aF9zZWN1
cmUoaXBfdHlwZSwKKwkJCQkJCQkJICBmYWxzZSk7Cit9CisKIHN0YXRpYyB2b2lkIGFtZGdwdV9j
b21tYW5kX3N1Ym1pc3Npb25fc2RtYV93cml0ZV9saW5lYXIodm9pZCkKIHsKIAlhbWRncHVfY29t
bWFuZF9zdWJtaXNzaW9uX3dyaXRlX2xpbmVhcl9oZWxwZXIoQU1ER1BVX0hXX0lQX0RNQSk7Ci0t
IAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
