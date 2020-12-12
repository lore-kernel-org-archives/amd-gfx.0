Return-Path: <SRS0=w48p=FQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D88C4167B
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:47:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB0F422AED
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0F422AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D55E6E894;
	Sat, 12 Dec 2020 15:47:40 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2068.outbound.protection.outlook.com [40.107.102.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFB246E894
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Dec 2020 15:47:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDWFi9Mncmmv3/0f/QOLkgOG/QUeh3NMoTTkQIIEg1OdxChgu/+0QESoCJ0vQbbz6R2ENkX7X6zF47YQI68GEC2IpixIWFuUOVHrdghCCry+ca9lUxJCZ/yS+AlT+Af7Ti9WJmMA9cNLFLE/C9dgdtGoalrjM1DKoJ7GH2P3AQDrF6srmffCnIGlZ4hjepQYGm3f/znJzLfvpzqk4H0vALXjA8cY+1WBwSjidisSUMf1SpRfGg3uSwleAkB7SL4kae+DgKN45UZwtoAxD4Kzn41oz3ZRdnb+qAkyAp93oEl6q6kRdJ55mK2xgJTi1WlAFGJvJmvkOC8qfTQFSuJZDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6I6ZfzhW9U1B1sIccL930VzXC/EFcaXKic7bgSV064Q=;
 b=GHItQC3euDNXuyLU2hFR29G6Dt1GtrqGpOz44AdMYgo/j0fPWc5/DiWuYD6N4Br6dQmPb5rMu12Oi6+VcCl+e1jf0fl5Sriak7o5gYnpRI+yXGlm7Nejet5s0gRC2WxNKjohAIooYSOHh7BzJ15VMzV8hJjpm+tcJy7146ZK2eGo9a26X1oPot2aIqPXq2YL5vLHUwrBOSFotnDVkJRM2LwVogqS6RlIDLBDWqcWZSH2sUjcWopoua1oKH1ebHpcKnAiqqU8XE7oe4LXpBzopZCFJzyJZUjLNM2Qyhgp0WImsCrhBmogMjqqYyTHEekKCc7dqzMH1g2TdVMNTI400w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6I6ZfzhW9U1B1sIccL930VzXC/EFcaXKic7bgSV064Q=;
 b=LyzxSVqPL+danQIS34FxHrJL70mIpmi8j2jOHVm/xf4vjVx+QzkD5tZ1ZmRQLrb65q2hn7+o5A2Rfvyqfv89w4gBR8YnxB0tZDldpEdqtdst2b5UHzVxL8wOFTTw8nk5oNBS0VL+GL247pIQ+iWD8tIfEzz9PKPen2grwajcRQ0=
Received: from BN0PR03CA0029.namprd03.prod.outlook.com (2603:10b6:408:e6::34)
 by BN6PR1201MB2514.namprd12.prod.outlook.com (2603:10b6:404:b0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.14; Sat, 12 Dec
 2020 15:47:35 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::1c) by BN0PR03CA0029.outlook.office365.com
 (2603:10b6:408:e6::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Sat, 12 Dec 2020 15:47:35 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.20 via Frontend Transport; Sat, 12 Dec 2020 15:47:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:47:34 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:47:34 -0600
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Sat, 12 Dec 2020 09:47:32 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Dennis Li <Dennis.Li@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 24/27] drm/amdgpu: correct ih_chicken programming for
 vega10/vega20 ih blocks
Date: Sat, 12 Dec 2020 23:45:57 +0800
Message-ID: <20201212154600.21618-24-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201212154600.21618-1-Hawking.Zhang@amd.com>
References: <20201212154600.21618-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 824b28b0-e38b-4819-71eb-08d89eb53ed9
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2514:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB251468F20D3DB1ABAFD33242FCC90@BN6PR1201MB2514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sB0+nvcRnXfgMuSsWpt5IOyqPJ3po1i5OWMyCguGS5biUEmh2ck8WW+bHvwmXvp1aj9LL0BlOKNLExMuedRnG3/yTbjPdxKJRtu8gyDqohTjscnsY5aDH87QnMCQDSqIIJ+ul6x4Aq3s8ks1xALW0J0EBdc08aBmoDgO7igzf58OB7wkycxDPfQJuG9TVrr/4TcdMviJCgcH98YUk2ypG8lNoFZyQi4br3OO9AQpUSa9I9vBLKT+jEi/yyPrr03ZP3Kyw4nzwP6BY/O18TGhOW5EDkEAV18bHf11CF/9OkfVLT28bBfoDr2UrM5/qzMj9iBG4rwpuWQLSSrBJLCwoWDc69soWLXtvovCYLOabBF9ZX6D+pgnEA5D4t5LJY9nD1K0p3h4VGQOJCDJQzA0fQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(46966005)(6636002)(47076004)(356005)(426003)(110136005)(8936002)(26005)(83380400001)(86362001)(5660300002)(4326008)(81166007)(8676002)(336012)(2616005)(1076003)(508600001)(70206006)(70586007)(186003)(6666004)(36756003)(2906002)(7696005)(82310400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2020 15:47:35.3122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 824b28b0-e38b-4819-71eb-08d89eb53ed9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2514
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SUhfQ0hJQ0tFTi5NQ19TUEFDRV9GQlBBX0VOQUJMRSBmaWVsZCBpcyBvbmx5CnZhbGlkIHdoZW4g
SUhfUkJfQ05UTC5NQ19TUEFDRSBpcyBwcm9ncmFtZWQgdG8gMHgzLApmcmFtZSBidWZmZXIgcGh5
c2ljYWwgYWRkcmVzcy4gRm9yIGJvdGggYnVzIGFkZHJlc3MKYW5kIGdwdSB2aXJ0dWFsIGFkZHJl
c3MsIGRvbid0IHByb2dyYW0gTUNfU1BBQ0VfRkJQQV9FTkFCTEUKZmllbGQKClNpZ25lZC1vZmYt
Ynk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KQWNrZWQtYnk6IENocmlz
dGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQWNrZWQtYnk6IEZlbGl4IEt1
ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgpSZXZpZXdlZC1ieTogRGVubmlzIExpIDxE
ZW5uaXMuTGlAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEZlaWZlaSBYdSA8RmVpZmVpLlh1QGFtZC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTEwX2loLmMgfCAzIC0tLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTIwX2loLmMgfCAzIC0tLQogMiBmaWxlcyBj
aGFuZ2VkLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3ZlZ2ExMF9paC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTEwX2lo
LmMKaW5kZXggNjY5NGRmNzFmNTQ1Li4xN2MwYTA3Yzg4M2IgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2ExMF9paC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3ZlZ2ExMF9paC5jCkBAIC0yODEsOSArMjgxLDYgQEAgc3RhdGljIGludCB2ZWdhMTBf
aWhfaXJxX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJCWlmIChhZGV2LT5pcnEu
aWgudXNlX2J1c19hZGRyKSB7CiAJCQlpaF9jaGlja2VuID0gUkVHX1NFVF9GSUVMRChpaF9jaGlj
a2VuLCBJSF9DSElDS0VOLAogCQkJCQkJICAgTUNfU1BBQ0VfR1BBX0VOQUJMRSwgMSk7Ci0JCX0g
ZWxzZSB7Ci0JCQlpaF9jaGlja2VuID0gUkVHX1NFVF9GSUVMRChpaF9jaGlja2VuLCBJSF9DSElD
S0VOLAotCQkJCQkJICAgTUNfU1BBQ0VfRkJQQV9FTkFCTEUsIDEpOwogCQl9CiAJCVdSRUczMl9T
T0MxNShPU1NTWVMsIDAsIG1tSUhfQ0hJQ0tFTiwgaWhfY2hpY2tlbik7CiAJfQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTIwX2loLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS92ZWdhMjBfaWguYwppbmRleCBjNDgxZmYwMDE1MmMuLjVmY2I0ODY2NDA5
YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTIwX2loLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTIwX2loLmMKQEAgLTMxMiw5ICszMTIs
NiBAQCBzdGF0aWMgaW50IHZlZ2EyMF9paF9pcnFfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikKIAkJaWYgKGFkZXYtPmlycS5paC51c2VfYnVzX2FkZHIpIHsKIAkJCWloX2NoaWNrZW4g
PSBSRUdfU0VUX0ZJRUxEKGloX2NoaWNrZW4sIElIX0NISUNLRU4sCiAJCQkJCQkgICBNQ19TUEFD
RV9HUEFfRU5BQkxFLCAxKTsKLQkJfSBlbHNlIHsKLQkJCWloX2NoaWNrZW4gPSBSRUdfU0VUX0ZJ
RUxEKGloX2NoaWNrZW4sIElIX0NISUNLRU4sCi0JCQkJCQkgICBNQ19TUEFDRV9GQlBBX0VOQUJM
RSwgMSk7CiAJCX0KIAkJV1JFRzMyX1NPQzE1KE9TU1NZUywgMCwgbW1JSF9DSElDS0VOLCBpaF9j
aGlja2VuKTsKIAl9Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
