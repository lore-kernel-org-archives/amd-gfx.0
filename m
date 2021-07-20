Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B2FC07E9D
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 00:49:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7330600D1
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 00:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7330600D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5B986E15E;
	Tue, 20 Jul 2021 00:49:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD76C6E0A0;
 Tue, 20 Jul 2021 00:49:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDojE8eog/1Yptlk6nqWS2lNOQEDDsWhm8OxkZ+Z4cfdoICKXolHsNHYO9rQ7kJgf+YoduN6aIpShD3WsQDdN57PqdbK3r2aNT4L/DTji9XzqXNGa58pdl5qGE4TyLv796HDQNoF1eKIluY1X9LIyONeNYA4W5O07KCRCLCS6OUfvhX/l6dzBdgQCdCc/u64E7IGqWvIqBl8Ev8TIBxcw/QI9QLneBdyPqievInz5E/2vhdMkMjFIiaE9/9L/Yw7RAkDV/sd1TzArBdV7NqVXQeuFW/7HehkZnTkuuGXKZWWYxX3oakN/r38B9lDhEhLQk1/lYJIYosPd9PU35AQYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbxQexAp6s8BslCHoQO0OW5MGb+pSV0h8hcm1x7opNk=;
 b=LQYz+5WjezCuKcSdam1d1ujH9l98aG8fs/gDCCLekxtWjum+hSX7E58CU8OLrF7VbKd0IEvdA/RiGiLWdepbKmBJ6GMO+34ZsJO0z6VryQTOjQf+RFhq2Wx1LRI1KBIDo+nfG9la4YW93VK9yFUpk+VVqBwUVQwzSSdIUuPYi8bJxXIItRDB4fKc1vcmf4a8eHpHdI8BtCi3dfBFX4XK2i8RRyV9TP5d+TjSGlOD/nBFIGh67r89bS+cQkhjETUr7cVyaAYr+1HpxfWfhGsAkNW/5txCZipdr3tuqttEvReR4G0BexlSdi5J/LL7aZ4BxQoZYs5xOHbKonb1QvFTsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbxQexAp6s8BslCHoQO0OW5MGb+pSV0h8hcm1x7opNk=;
 b=NzXrtorAs2x+QfG4DjP/fklxivNslAElp8o/0Qw9t8rDW2V/Md/mveRIBBZEudF795eOyL9v/GFFJ4To2tofY+wKUroc2gdVAGl2zwW3U6wXrph9Tr4ZLcxww6t5Rc6w5BbruKdv5P8/caPtyQY5CoGFXKIxIC7pjS6rF40tbMw=
Received: from BN0PR02CA0025.namprd02.prod.outlook.com (2603:10b6:408:e4::30)
 by MW2PR12MB2588.namprd12.prod.outlook.com (2603:10b6:907:a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.31; Tue, 20 Jul
 2021 00:49:31 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::9f) by BN0PR02CA0025.outlook.office365.com
 (2603:10b6:408:e4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Tue, 20 Jul 2021 00:49:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 00:49:30 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Jul
 2021 19:49:29 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Daniel Vetter <daniel@ffwll.ch>,
 <roman.li@amd.com>, <sunpeng.li@amd.com>
Subject: [PATCH v3 3/4] drm/amd/display: Add control mechanism for FPU
 utilization
Date: Mon, 19 Jul 2021 20:49:13 -0400
Message-ID: <20210720004914.3060879-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210720004914.3060879-1-Rodrigo.Siqueira@amd.com>
References: <20210720004914.3060879-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f735936-2d5a-4309-214d-08d94b183c1a
X-MS-TrafficTypeDiagnostic: MW2PR12MB2588:
X-Microsoft-Antispam-PRVS: <MW2PR12MB25882EE378F60FADEB3CAB6798E29@MW2PR12MB2588.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:156;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ftzw7Fh7z4BNYpcVJe4cZEGMvxeKwKz8xUSMnSubmwoKcOrtWpcAUGH/kwbrS2JBb5aYemba8eOjt/SI7t20haSw2y/Lgx8g0NlRzTG5ODGa2+9cnU4TugR1FS9WCTG5Ge/we4NEtYpYv+ieuc8JpoGomyH7aAhPc3leD1ccyngZFAHe6qUpxIzm8cdEM8sf1cIs3idCi6MBqK/1ZAD5RN/kJd61UXD357abkviFkNI0oV3qlvHIDbC32ij8Hk7NX7OgZhCFwW7jeiGxUHvBUZtbQ54jvkc3c8EWTgrcWumSMPqml8R73d7p8tYUJ89pth64fKVFAXaVsv2HNylUP/xIONJd3gHl8RDw66E+axohf+Nwf+hDhGZ3S+8R9Zcky8LvYRQ4EKsnX5jvzeps5Grnd8syV3PVrTi0oyFQtX7eTMinuvG9Ld2t4YH106cMlDdy48yJfulFieG1npSkrTbN2c1qutPslzD9GZDbshTGyu3KxRsYPnlW4AElyrpt5QbAmB2Gak5N+SoQGszJKb0z155WB5yW8qL1QqdTvVkXGzyKilkVyGLdLKVMTwjBdJ3hV0rMKCuRIcstfw+nOj1HrE1YAX1pZ6zksX68FFNQnK9koxbb5CjE9EWRi/MR5Jn/YsZlbfze4OXXow+d2FrilPyplq1bCBDtFbUy84HqNqXD3wbCW0ixyUT/j6vsiYx7wz23AsVPcZIo085be844hmFYD26IKmIaQt8x2sU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(36840700001)(46966006)(47076005)(316002)(26005)(356005)(8676002)(336012)(8936002)(6636002)(86362001)(66574015)(54906003)(2616005)(36756003)(83380400001)(81166007)(82740400003)(82310400003)(2906002)(5660300002)(70206006)(36860700001)(4326008)(478600001)(186003)(426003)(1076003)(110136005)(6666004)(70586007)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 00:49:30.8549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f735936-2d5a-4309-214d-08d94b183c1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2588
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
Cc: Aric Cyr <aric.cyr@amd.com>, Anson Jacob <Anson.Jacob@amd.com>,
 dri-devel@lists.freedesktop.org, Hersen Wu <hersenxs.wu@amd.com>,
 amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

REMgaW52b2tlcyBEQ19GUFVfU1RBUlQvRU5EIGluIG11bHRpcGxlIHBhcnRzIG9mIHRoZSBjb2Rl
OyB0aGlzIGNhbgpjcmVhdGUgYSBzaXR1YXRpb24gd2hlcmUgd2UgaW52b2tlIHRoaXMgRlBVIG9w
ZXJhdGlvbiBpbiBhIG5lc3RlZCB3YXkgb3IKZXhpdCB0b28gZWFybHkuIEZvciBhdm9pZGluZyB0
aGlzIHNpdHVhdGlvbiwgdGhpcyBjb21taXQgYWRkcyBhCm1lY2hhbmlzbSB3aGVyZSBkY19mcHVf
YmVnaW4vZW5kIG1hbmFnZXMgdGhlIGFjY2VzcyB0bwprZXJuZWxfZnB1X2JlZ2luL2VuZC4KCkNo
YW5nZSBzaW5jZSBWMjoKLSBDaHJpc3RpYW46IERvIG5vdCB1c2UgdGhpc19jcHVfKiBiZXR3ZWVu
IGdldC9wdXRfY3B1X3B0cigpLgoKQ2hhbmdlIHNpbmNlIFYxOgotIFVzZSBhIGJldHRlciB2YXJp
YWJsZSBuYW1lcwotIFVzZSBnZXRfY3B1X3B0ciBhbmQgcHV0X2NwdV9wdHIgdG8gYmV0dGVyIGJh
bGFuY2UgcHJlZW1wdGlvbiBlbmFibGUKYW5kIGRpc2FibGUKCkNjOiBIYXJyeSBXZW50bGFuZCA8
aGFycnkud2VudGxhbmRAYW1kLmNvbT4KQ2M6IEFuc29uIEphY29iIDxBbnNvbi5KYWNvYkBhbWQu
Y29tPgpDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzog
SGVyc2VuIFd1IDxoZXJzZW54cy53dUBhbWQuY29tPgpDYzogQXJpYyBDeXIgPGFyaWMuY3lyQGFt
ZC5jb20+ClNpZ25lZC1vZmYtYnk6IFJvZHJpZ28gU2lxdWVpcmEgPFJvZHJpZ28uU2lxdWVpcmFA
YW1kLmNvbT4KLS0tCiAuLi4vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV90cmFjZS5o
ICAgfCAxMyArKysrLS0tCiAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vZGNfZnB1
LmMgICAgfCAzNiArKysrKysrKysrKysrKysrLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvZGNfdHJhY2UuaCAgICAgfCAgNCArLS0KIDMgZmlsZXMgY2hhbmdlZCwgNDIgaW5zZXJ0
aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fdHJhY2UuaCBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3RyYWNlLmgKaW5kZXggMjMwYmIxMmM0MDVl
Li5mZGNhZWEyMmI0NTYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9h
bWRncHVfZG0vYW1kZ3B1X2RtX3RyYWNlLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fdHJhY2UuaApAQCAtNjM4LDIzICs2MzgsMjYgQEAgVFJB
Q0VfRVZFTlQoYW1kZ3B1X3JlZnJlc2hfcmF0ZV90cmFjaywKICk7CiAKIFRSQUNFX0VWRU5UKGRj
bl9mcHUsCi0JICAgIFRQX1BST1RPKGJvb2wgYmVnaW4sIGNvbnN0IGNoYXIgKmZ1bmN0aW9uLCBj
b25zdCBpbnQgbGluZSksCi0JICAgIFRQX0FSR1MoYmVnaW4sIGZ1bmN0aW9uLCBsaW5lKSwKKwkg
ICAgVFBfUFJPVE8oYm9vbCBiZWdpbiwgY29uc3QgY2hhciAqZnVuY3Rpb24sIGNvbnN0IGludCBs
aW5lLCBjb25zdCBpbnQgcmVjdXJzaW9uX2RlcHRoKSwKKwkgICAgVFBfQVJHUyhiZWdpbiwgZnVu
Y3Rpb24sIGxpbmUsIHJlY3Vyc2lvbl9kZXB0aCksCiAKIAkgICAgVFBfU1RSVUNUX19lbnRyeSgK
IAkJCSAgICAgX19maWVsZChib29sLCBiZWdpbikKIAkJCSAgICAgX19maWVsZChjb25zdCBjaGFy
ICosIGZ1bmN0aW9uKQogCQkJICAgICBfX2ZpZWxkKGludCwgbGluZSkKKwkJCSAgICAgX19maWVs
ZChpbnQsIHJlY3Vyc2lvbl9kZXB0aCkKIAkgICAgKSwKIAkgICAgVFBfZmFzdF9hc3NpZ24oCiAJ
CQkgICBfX2VudHJ5LT5iZWdpbiA9IGJlZ2luOwogCQkJICAgX19lbnRyeS0+ZnVuY3Rpb24gPSBm
dW5jdGlvbjsKIAkJCSAgIF9fZW50cnktPmxpbmUgPSBsaW5lOworCQkJICAgX19lbnRyeS0+cmVj
dXJzaW9uX2RlcHRoID0gcmVjdXJzaW9uX2RlcHRoOwogCSAgICApLAotCSAgICBUUF9wcmludGso
IiVzKCkrJWQ6ICVzIiwKKwkgICAgVFBfcHJpbnRrKCIlczogcmVjdXJzaW9uX2RlcHRoOiAlZDog
JXMoKSslZDoiLAorCQkgICAgICBfX2VudHJ5LT5iZWdpbiA/ICJiZWdpbiIgOiAiZW5kIiwKKwkJ
ICAgICAgX19lbnRyeS0+cmVjdXJzaW9uX2RlcHRoLAogCQkgICAgICBfX2VudHJ5LT5mdW5jdGlv
biwKLQkJICAgICAgX19lbnRyeS0+bGluZSwKLQkJICAgICAgX19lbnRyeS0+YmVnaW4gPyAiYmVn
aW4iIDogImVuZCIKKwkJICAgICAgX19lbnRyeS0+bGluZQogCSAgICApCiApOwogCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2RjX2ZwdS5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9kY19mcHUuYwppbmRleCBkNWQxNTZh
NDUxN2UuLmQwZDNlOGEzNGRiNSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2FtZGdwdV9kbS9kY19mcHUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
YW1kZ3B1X2RtL2RjX2ZwdS5jCkBAIC0yOCw2ICsyOCwxOSBAQAogCiAjaW5jbHVkZSA8YXNtL2Zw
dS9hcGkuaD4KIAorLyoqCisgKiBET0M6IERDIEZQVSBtYW5pcHVsYXRpb24gb3ZlcnZpZXcKKyAq
CisgKiBEQyBjb3JlIHVzZXMgRlBVIG9wZXJhdGlvbnMgaW4gbXVsdGlwbGUgcGFydHMgb2YgdGhl
IGNvZGUsIHdoaWNoIHJlcXVpcmVzIGEKKyAqIG1vcmUgc3BlY2lhbGl6ZWQgd2F5IHRvIG1hbmFn
ZSB0aGVzZSBhcmVhcycgZW50cmFuY2UuIFRvIGZ1bGZpbGwgdGhpcworICogcmVxdWlyZW1lbnQs
IHdlIGNyZWF0ZWQgc29tZSB3cmFwcGVyIGZ1bmN0aW9ucyB0aGF0IGVuY2Fwc3VsYXRlCisgKiBr
ZXJuZWxfZnB1X2JlZ2luL2VuZCB0byBiZXR0ZXIgZml0IG91ciBuZWVkIGluIHRoZSBkaXNwbGF5
IGNvbXBvbmVudC4gSW4KKyAqIHN1bW1hcnksIGluIHRoaXMgZmlsZSwgeW91IGNhbiBmaW5kIGZ1
bmN0aW9ucyByZWxhdGVkIHRvIEZQVSBvcGVyYXRpb24KKyAqIG1hbmFnZW1lbnQuCisgKi8KKwor
c3RhdGljIERFRklORV9QRVJfQ1BVKGludCwgZnB1X3JlY3Vyc2lvbl9kZXB0aCk7CisKIC8qKgog
ICogZGNfZnB1X2JlZ2luIC0gRW5hYmxlcyBGUFUgcHJvdGVjdGlvbgogICogQGZ1bmN0aW9uX25h
bWU6IEEgc3RyaW5nIGNvbnRhaW5pbmcgdGhlIGZ1bmN0aW9uIG5hbWUgZm9yIGRlYnVnIHB1cnBv
c2VzCkBAIC00Myw4ICs1NiwxNiBAQAogICovCiB2b2lkIGRjX2ZwdV9iZWdpbihjb25zdCBjaGFy
ICpmdW5jdGlvbl9uYW1lLCBjb25zdCBpbnQgbGluZSkKIHsKLQlUUkFDRV9EQ05fRlBVKHRydWUs
IGZ1bmN0aW9uX25hbWUsIGxpbmUpOwotCWtlcm5lbF9mcHVfYmVnaW4oKTsKKwlpbnQgKnBjcHU7
CisKKwlwY3B1ID0gZ2V0X2NwdV9wdHIoJmZwdV9yZWN1cnNpb25fZGVwdGgpOworCSpwY3B1ICs9
IDE7CisKKwlpZiAoKnBjcHUgPT0gMSkKKwkJa2VybmVsX2ZwdV9iZWdpbigpOworCisJVFJBQ0Vf
RENOX0ZQVSh0cnVlLCBmdW5jdGlvbl9uYW1lLCBsaW5lLCAqcGNwdSk7CisJcHV0X2NwdV9wdHIo
JmZwdV9yZWN1cnNpb25fZGVwdGgpOwogfQogCiAvKioKQEAgLTU5LDYgKzgwLDEzIEBAIHZvaWQg
ZGNfZnB1X2JlZ2luKGNvbnN0IGNoYXIgKmZ1bmN0aW9uX25hbWUsIGNvbnN0IGludCBsaW5lKQog
ICovCiB2b2lkIGRjX2ZwdV9lbmQoY29uc3QgY2hhciAqZnVuY3Rpb25fbmFtZSwgY29uc3QgaW50
IGxpbmUpCiB7Ci0JVFJBQ0VfRENOX0ZQVShmYWxzZSwgZnVuY3Rpb25fbmFtZSwgbGluZSk7Ci0J
a2VybmVsX2ZwdV9lbmQoKTsKKwlpbnQgKnBjcHU7CisKKwlwY3B1ID0gZ2V0X2NwdV9wdHIoJmZw
dV9yZWN1cnNpb25fZGVwdGgpOworCSpwY3B1IC09IDE7CisJaWYgKCpwY3B1IDw9IDApCisJCWtl
cm5lbF9mcHVfZW5kKCk7CisKKwlUUkFDRV9EQ05fRlBVKGZhbHNlLCBmdW5jdGlvbl9uYW1lLCBs
aW5lLCAqcGNwdSk7CisJcHV0X2NwdV9wdHIoJmZwdV9yZWN1cnNpb25fZGVwdGgpOwogfQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjX3RyYWNlLmggYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfdHJhY2UuaAppbmRleCBkNTk4YmE2OTdlNDUu
LmM3MTE3OTdlNWM5ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RjX3RyYWNlLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjX3RyYWNl
LmgKQEAgLTM4LDUgKzM4LDUgQEAKICNkZWZpbmUgVFJBQ0VfRENOX0NMT0NLX1NUQVRFKGRjbl9j
bG9ja3MpIFwKIAl0cmFjZV9hbWRncHVfZG1fZGNfY2xvY2tzX3N0YXRlKGRjbl9jbG9ja3MpCiAK
LSNkZWZpbmUgVFJBQ0VfRENOX0ZQVShiZWdpbiwgZnVuY3Rpb24sIGxpbmUpIFwKLQl0cmFjZV9k
Y25fZnB1KGJlZ2luLCBmdW5jdGlvbiwgbGluZSkKKyNkZWZpbmUgVFJBQ0VfRENOX0ZQVShiZWdp
biwgZnVuY3Rpb24sIGxpbmUsIHJlZl9jb3VudCkgXAorCXRyYWNlX2Rjbl9mcHUoYmVnaW4sIGZ1
bmN0aW9uLCBsaW5lLCByZWZfY291bnQpCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
