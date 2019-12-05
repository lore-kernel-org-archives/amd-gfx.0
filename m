Return-Path: <SRS0=ZBu5=Z3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C1CC43603
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 13:59:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EE9D224F8
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 13:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE9D224F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32E146E096;
	Thu,  5 Dec 2019 13:59:27 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9F296E096
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2019 13:59:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Njv3+xiXeyO6oiHiyu6fKoksYYBCRZmH9j5YYlP/cLbi5jBJVQl1XhRuprsAM21LWNKNgn0CIsl64ubo7BPidYJLO/Pbdm4l3Kg5USYqVboJdTPECJqS7lLtVxwmWQVKlL+/OMeGz5JHLC95+5KRDOOFDTesMftLeyTwD/xQ+by76OEemFpXqKpjkgnmB5Ufyh3fJBtUXLDE/u9coNvGWOZAPPPsUisl8vUu5UwbrEx9Qyy2v+ZHCa9XBeV8B7r7NHX73bCHqyTZjaKoL8mrg8crk/OruaUqxRvZZi3wbtAMNdqmzyWyEIzJYXZAtgSgOf8TpIDypTQv+vAPLEsx9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPSgCF0bDbaGGuDXPkgPrDC/dx5gll6gGJoDCKKUmSE=;
 b=TWNr6rMgpgdlDcFKvNYRch8M8tuuMs1LORv23Mk+8ysPlPLnhfIin6sH/dftA1rM2ouYnk5/vV+qOaYyJlQpvAntg993FYvsLZ22orGPMgzbW0nIfG7W1ykpA5S4pBn8VUKYvEW08hSFPfEIJwnk7IMm5AB487KoCA0R7elMEBXBx/8BYhYWV13LbpBx07O1ZK3iudbqixoDOAn656FPve8jJK3vgvowrdpuCTgmaBnz2KqRbhCUyNys/sapq7Ov5x5N5t9vJli8YYRYvSA2wMexu2JHiJa4Yfs1dIuuPwS0/mk2pnmZ/gNSCHsSM2YipQd15Zh+E/THubWIvRAlGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2412.namprd12.prod.outlook.com (52.132.180.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Thu, 5 Dec 2019 13:59:24 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2495.014; Thu, 5 Dec 2019
 13:59:23 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: =dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm: Add FEC registers for LT-tunable repeaters
Date: Thu,  5 Dec 2019 08:58:56 -0500
Message-Id: <20191205135856.232784-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
X-ClientProxiedBy: YTBPR01CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::14) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5a46d220-c8d3-4674-4103-08d7798b5528
X-MS-TrafficTypeDiagnostic: MW2PR12MB2412:|MW2PR12MB2412:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24122F3B1E7B5B810A66A176985C0@MW2PR12MB2412.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:254;
X-Forefront-PRVS: 02426D11FE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(189003)(199004)(25786009)(66946007)(305945005)(6666004)(99286004)(66556008)(66476007)(1076003)(2906002)(5660300002)(316002)(2870700001)(54906003)(36756003)(50466002)(81156014)(26005)(8936002)(8676002)(2616005)(86362001)(6506007)(81166006)(186003)(14454004)(4326008)(6512007)(50226002)(478600001)(6486002)(52116002)(23676004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2412;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OETMpivXujzxzoLTq5YY7zPUurG+stNSdZID4eY2hq/x/AqMytPgbGC9VhbHy+WDY3hNAHUojexL+Idu/tCVeZUYPZFMWX2zXrYRrFCxxtQFy1Yqo7fVmxLsP6bnJv4fEN9vSoihsMuKydsNTfa4DArZZbmVHK+MqEb6R9OR1Y3s/vevCvHM4EvYbq0eNxIHiQoVFW/I+scr1Jm3/j2zYgOD3QPLnvoIgrub2psRxCNaL1lF8TsRK7MEMmnJMSYFRWbkqd0BGPKz8cGlOOqLJi8Hvup6aErw6kzFQ3YDyidwkQqF7Q4e8opxPf77z1KXrg8OkbpVUMKCvBst8iB2ssOalomkK1EhPgdbq0gcWLR5+Ufo6WOxevodzVAI2bZAVsTOgdEWidMcbLyA3lbNgIZVlIOLNGHYMeRElk7XFfvriLgP9ElwH0oJpX6wAU/Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a46d220-c8d3-4674-4103-08d7798b5528
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 13:59:23.5129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p00bcORxNLVkpIcCplJ6YugNtsqr+RSwBT6e/DoF2QLAcUt0ER7AOUC+UJJp3NQvnWV6MbBGd9BrTaGM/hcpFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2412
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPSgCF0bDbaGGuDXPkgPrDC/dx5gll6gGJoDCKKUmSE=;
 b=xfXtG3R05pImyRFkhgDLpByCS4vAWuQTm4BJAl0w+ay9BZJVw0mjcfY+PYmCn+DE0FrVMGMVg5S89nIgabadgBGZlDMpi9kCNDWZWsJMprbbYvsJwWSMi5v3eiDcZ0r0nHOlu0Hag6dlmqKayKLY+DpM2p9mbZ88Ve1tB9c2Eks=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
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
Cc: Leo Li <sunpeng.li@amd.com>, Abdoulaye Berthe <Abdoulaye.Berthe@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Nikola Cornij <Nikola.Cornij@amd.com>,
 Manasi Navare <manasi.d.navare@intel.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RkVDIGlzIHN1cHBvcnRlZCBzaW5jZSBEUCAxLjQsIGFuZCBpdCB3YXMgZXhwYW5kZWQgZm9yIExU
LXR1bmFibGUgaW4gRFAKMS40YS4gVGhpcyBjb21taXQgYWRkcyB0aGUgYWRkcmVzcyByZWdpc3Rl
cnMgZm9yCkZFQ19FUlJPUl9DT1VOVF9QSFlfUkVQRUFURVIxIGFuZCBGRUNfQ0FQQUJJTElUWV9Q
SFlfUkVQRUFURVIxLgoKQ2M6IEFiZG91bGF5ZSBCZXJ0aGUgPEFiZG91bGF5ZS5CZXJ0aGVAYW1k
LmNvbT4KQ2M6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgpDYzogTGVv
IExpIDxzdW5wZW5nLmxpQGFtZC5jb20+CkNjOiBKYW5pIE5pa3VsYSA8amFuaS5uaWt1bGFAbGlu
dXguaW50ZWwuY29tPgpDYzogTWFuYXNpIE5hdmFyZSA8bWFuYXNpLmQubmF2YXJlQGludGVsLmNv
bT4KQ2M6IFZpbGxlIFN5cmrDpGzDpCA8dmlsbGUuc3lyamFsYUBsaW51eC5pbnRlbC5jb20+ClNp
Z25lZC1vZmYtYnk6IEFiZG91bGF5ZSBCZXJ0aGUgPEFiZG91bGF5ZS5CZXJ0aGVAYW1kLmNvbT4K
U2lnbmVkLW9mZi1ieTogUm9kcmlnbyBTaXF1ZWlyYSA8Um9kcmlnby5TaXF1ZWlyYUBhbWQuY29t
PgotLS0KIGluY2x1ZGUvZHJtL2RybV9kcF9oZWxwZXIuaCB8IDIgKysKIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS9kcm1fZHBfaGVscGVy
LmggYi9pbmNsdWRlL2RybS9kcm1fZHBfaGVscGVyLmgKaW5kZXggNTFlY2I1MTEyZWY4Li5iMjA1
NzAwOWFhYmMgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvZHJtL2RybV9kcF9oZWxwZXIuaAorKysgYi9p
bmNsdWRlL2RybS9kcm1fZHBfaGVscGVyLmgKQEAgLTEwNDIsNiArMTA0Miw4IEBACiAjZGVmaW5l
IERQX1NZTUJPTF9FUlJPUl9DT1VOVF9MQU5FMl9QSFlfUkVQRUFURVIxCSAgICAweGYwMDM5IC8q
IDEuMyAqLwogI2RlZmluZSBEUF9TWU1CT0xfRVJST1JfQ09VTlRfTEFORTNfUEhZX1JFUEVBVEVS
MQkgICAgMHhmMDAzYiAvKiAxLjMgKi8KICNkZWZpbmUgRFBfRkVDX1NUQVRVU19QSFlfUkVQRUFU
RVIxCQkJICAgIDB4ZjAyOTAgLyogMS40ICovCisjZGVmaW5lIERQX0ZFQ19FUlJPUl9DT1VOVF9Q
SFlfUkVQRUFURVIxICAgICAgICAgICAgICAgICAgICAweGYwMjkxIC8qIDEuNCAqLworI2RlZmlu
ZSBEUF9GRUNfQ0FQQUJJTElUWV9QSFlfUkVQRUFURVIxICAgICAgICAgICAgICAgICAgICAgMHhm
MDI5NCAvKiAxLjRhICovCiAKIC8qIFJlcGVhdGVyIG1vZGVzICovCiAjZGVmaW5lIERQX1BIWV9S
RVBFQVRFUl9NT0RFX1RSQU5TUEFSRU5UCQkgICAgMHg1NSAgICAvKiAxLjMgKi8KLS0gCjIuMjQu
MAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
