Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F3AC48BDF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2200961263
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2200961263
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFC906ED98;
	Thu, 10 Jun 2021 16:29:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C7176ED98
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 16:29:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRZZLg+fqxX0M0ys8zPTDLwCHPu/k1ajClSSVBEhyaTdpMho6EriqGsw58Ht6um67QkvlmsgNIcKmWt/wWNeGf6y4nF7BafN52DCHHPH35eWFyjJQSZom6/noxkOSEETWOe7wwflNyuASf976Bgaxa0HlQ/FBbBF/N1T8dmF8yubsMou1TpyTkLt0tn0Zl4YirRz3vnHPrlwVhF2yffzkY1sL8x9ApKpOlJNceOFOw3fcUoQZWF8jFrKKM4L0DKep1yhFmEZOmag16zOuMuKny+GjxbyLxPXuMX9kE38LoxRL51xfMlHuq9G1MXq9nhEETLwdt2DgAiVBRQF4KfNbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3w3Cb9GziHTzS0oy8q65LLtUthpMji2F7nZxax4ON0=;
 b=ZJhX7wz5eomSHrz1oWCA9sRk6P970dnDXMncS9NCTT35JxJ0epktbC+gVK7ZWkZffMAGJCMMAnABX2RaY40w+8ohlJXVIsS6mwk0jueCcN0AAzwZlRUHhFPwV4E0Lc3D3BvpSbYt8g7IfguedrI/oh20xyQHnFIulLY99d2UccVp2ytpv0YHKMVHUh8lH0RaKyWTJvWl7calG7Cu4U/MP4vnv7LqJLQXlsKc0BVyrYsxNU5gg34dREYbMDH/zJf0dblqD4PuH5OFhPgFPHqPqxFEkGbpAve1oWblEuX5UZQYEd6CrxpYjaNrRj1tVIh5mjf9FniC+K+krrWuBJ5+Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3w3Cb9GziHTzS0oy8q65LLtUthpMji2F7nZxax4ON0=;
 b=FOZfclIldsSjTOi3eykdqqI2MsfYD2MAL+Z8VZBPVDD9nwk9o/oPAV+lMnDufevmhAPKiuzi81CAlRqRhOf45b6vc89xEjFQbCaFur4g7DV2q99j1rZNK8naGUfeP+WL8bW7laBofbf0k0BuaUkIJNvR9+jWOrhFRV3J4b6gzbY=
Received: from MWHPR22CA0006.namprd22.prod.outlook.com (2603:10b6:300:ef::16)
 by BY5PR12MB4274.namprd12.prod.outlook.com (2603:10b6:a03:206::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Thu, 10 Jun
 2021 16:29:40 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ef:cafe::ac) by MWHPR22CA0006.outlook.office365.com
 (2603:10b6:300:ef::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Thu, 10 Jun 2021 16:29:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 16:29:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 11:29:39 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 10 Jun 2021 11:29:37 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/24] drm/amd/display: Do not count I2C DEFERs with AUX DEFERs
Date: Thu, 10 Jun 2021 12:28:34 -0400
Message-ID: <20210610162838.287723-21-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610162838.287723-1-Anson.Jacob@amd.com>
References: <20210610162838.287723-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f82aba06-29c9-4990-d116-08d92c2cf1df
X-MS-TrafficTypeDiagnostic: BY5PR12MB4274:
X-Microsoft-Antispam-PRVS: <BY5PR12MB42744BBC6A2B42E3A98A4D36EB359@BY5PR12MB4274.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WhdPWeYvldDjaqP9Y1afNhU3XoP3ae5XylywpdUJx41BY3CFz2GXlvNN/Tj6nDSC7f2l9su8jQoImRELHdf+GqNSyW7S4uBEWopDR5D4TldEROaTnjp0IaRXcpfNU7/gyijCdGXSwwN/vvzd4eQifBdQzblEC7GrtR70/hg9P/T8Qa19qgvp5sAJKz8ytL3Wu+SgUnul9BVsxPvIpbhBEwljB66LmIJAAdVIyxjcLiMGE4JNX7uSD5udNqhQisslFKKHPlTe3br1LVx3X/BIyzdn3/GmmnK4mzk2aIjE9Tgc3XuXVcMHCKMRWkCui/wmzyRx68ZkRgUoZcvMxlL/9qJwR3Ij38gHcq5gFRuDmaHDUM/Y+SEp3PySFSypQ5Qj1EeINiQjsdzlljs4t0Z079wqxb3Da033zOR58sKtbENIRlltp1Z3vMz+yYlmJWeDIA35ceGIPndGEE1gRRJK9pUEmwmcMZMRGj/2/fhUXAaRNs6PHhMUC7M3quk0dgOBxqnB7MWjAmK4LtTLNqhKyEfuii8v2lk3H5nNqs6xalzE6AQWrdaSYc7Zg5lDbrIxxzc8O/+oH8HigcQzFPQzQNW5FAdPG26z4qF9P0IZ7rgHp/MQIyt5mJyJ3JpE6YDlX3tBrU2W+MDqJhybMzqLSQrd+RmfqglBo9tyq2ISW7PrLPk2DpxaMY+qzWklYpFz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(46966006)(36840700001)(86362001)(316002)(7696005)(54906003)(5660300002)(82310400003)(1076003)(186003)(47076005)(8676002)(70206006)(83380400001)(70586007)(8936002)(336012)(478600001)(36756003)(356005)(6666004)(6916009)(2616005)(4326008)(36860700001)(81166007)(2906002)(426003)(26005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 16:29:39.6167 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f82aba06-29c9-4990-d116-08d92c2cf1df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4274
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogV2VzbGV5IENoYWxtZXJzIDxXZXNsZXkuQ2hhbG1lcnNAYW1kLmNvbT4KCltXSFldCkRQ
IDIuMCBTQ1Igc3BlY2lmaWVzIHRoYXQKIkEgRFBUWCBzaGFsbCBkaXN0aW5ndWlzaCBJMkNfREVG
RVJ8QVVYX0FDSyBmcm9tIEFVWF9ERUZFUi4gQVVYIHJldHJpZXMKZHVlIHRvCkkyQ19ERUZFUiBh
cmUgbm90IGNvdW50ZWQgYXMgcGFydCBvZiBtaW5pbXVtIDcgcmV0aXJlcyAoc2ljKSB1cG9uCkFV
WF9ERUZFUuKAmXMiCgpTaWduZWQtb2ZmLWJ5OiBXZXNsZXkgQ2hhbG1lcnMgPFdlc2xleS5DaGFs
bWVyc0BhbWQuY29tPgpSZXZpZXdlZC1ieTogSnVuIExlaSA8SnVuLkxlaUBhbWQuY29tPgpBY2tl
ZC1ieTogQW5zb24gSmFjb2IgPEFuc29uLkphY29iQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfYXV4LmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX2F1eC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2RjZS9kY2VfYXV4LmMKaW5kZXggNDljYjRlNmQ2NDExLi4yODYzMTcxNGY2OTcg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX2F1eC5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX2F1eC5jCkBAIC02
NjcsMTIgKzY2NywxMyBAQCBib29sIGRjZV9hdXhfdHJhbnNmZXJfd2l0aF9yZXRyaWVzKHN0cnVj
dCBkZGNfc2VydmljZSAqZGRjLAogCQkJY2FzZSBBVVhfVFJBTlNBQ1RJT05fUkVQTFlfQVVYX0RF
RkVSOgogCQkJCS8qIHBvbGxpbmdfdGltZW91dF9wZXJpb2QgaXMgaW4gdXMgKi8KIAkJCQlkZWZl
cl90aW1lX2luX21zICs9IGF1eDExMC0+cG9sbGluZ190aW1lb3V0X3BlcmlvZCAvIDEwMDA7CisJ
CQkJKythdXhfZGVmZXJfcmV0cmllczsKIAkJCQkvKiBmYWxsIHRocm91Z2ggKi8KIAkJCWNhc2Ug
QVVYX1RSQU5TQUNUSU9OX1JFUExZX0kyQ19PVkVSX0FVWF9ERUZFUjoKIAkJCQlyZXRyeV9vbl9k
ZWZlciA9IHRydWU7CiAJCQkJZmFsbHRocm91Z2g7CiAJCQljYXNlIEFVWF9UUkFOU0FDVElPTl9S
RVBMWV9JMkNfT1ZFUl9BVVhfTkFDSzoKLQkJCQlpZiAoKythdXhfZGVmZXJfcmV0cmllcyA+PSBB
VVhfTUlOX0RFRkVSX1JFVFJJRVMKKwkJCQlpZiAoYXV4X2RlZmVyX3JldHJpZXMgPj0gQVVYX01J
Tl9ERUZFUl9SRVRSSUVTCiAJCQkJCQkmJiBkZWZlcl90aW1lX2luX21zID49IEFVWF9NQVhfREVG
RVJfVElNRU9VVF9NUykgewogCQkJCQlnb3RvIGZhaWw7CiAJCQkJfSBlbHNlIHsKLS0gCjIuMjUu
MQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
