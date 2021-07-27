Return-Path: <SRS0=HC41=MT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBC0C4320A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jul 2021 00:53:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8529460F02
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jul 2021 00:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8529460F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33E3673064;
	Tue, 27 Jul 2021 00:53:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 623E86EB88;
 Tue, 27 Jul 2021 00:53:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZdGGOb9nrtbUTc9bYAvUoSDv4bRXRufn2FZRaITD2pIVWeSuGWel3ucy093LuTMV108nlhQEZeSzcuN1eUK+opqSM2Lr6LwfhV8vIhOlE8P+WKyKxl1bZ9iUCGdrbNg9KgwSEXLklS8SXkq8tSKMT3hl69HwdXWX3LnGPBt+724cCd6TuOUgaWclYk05UcW0a2OdMUmWMIFDH7uXr2Y1hwkWjL0VTiXAfG5VClZAdUdrCzmUEJCXt3a3AajLaLZRec0ipCY79e1R5rdqfySAlWQwdfoNfTMBRX9ghSYe9nqMn6g/QW3BGXWixd8Zw/dS4+FrQ6rAio5A/JsbBSNVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9MOcE0oPE/ddmSzhfroN+3RIIDUD0x7k3brGA/WKJI=;
 b=mIidHwV0M2P1sN5YYwD6d4ysE7x4cRyt9KJA8Y0W7b1E8Y8BlMclF3BIuk28kf9LZLIK2gBIZXKkNqX4Uu5xzZEOYztJO6hDSA74gMLpLb36/uk0zD32BbT6CXoAGuHdsalQ9nCJH7PmlAYbYWPINAxAXen2E3vsRqEEhCY+MxINzMvFQ+0s4ywMRvuyi7EIspE0gK1Lv8i2/uYX2/f25D1eYXEy3YSyB2tObwUM138wCFV84pciEQVj4d6iyLA7RZXyRPOzduU0pXy+n7oyo9QQABqcXXQF34T9BQEVO5x4jkGMXJJYDG55AI05pL5E4sbHps6UpD6+odpczwzs0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9MOcE0oPE/ddmSzhfroN+3RIIDUD0x7k3brGA/WKJI=;
 b=nZdEhy6sEF6LAIznIh86U08X+AQce0hsgB1ZILY2h3qEuC4z/JI28PQjjpirPE+kd3HVG7W60eAanC2EmRMvEntTe7sjW3YYP0a44Zl+FtDyUpcFz6L+NrIo6ePfk34tRqK0LJpxila0ls6zBkT9zg53+fgSz4Kp25IFi5YkFRU=
Received: from DM5PR07CA0156.namprd07.prod.outlook.com (2603:10b6:3:ee::22) by
 BN6PR1201MB0179.namprd12.prod.outlook.com (2603:10b6:405:59::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Tue, 27 Jul
 2021 00:53:07 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::db) by DM5PR07CA0156.outlook.office365.com
 (2603:10b6:3:ee::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend
 Transport; Tue, 27 Jul 2021 00:53:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Tue, 27 Jul 2021 00:53:07 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 26 Jul
 2021 19:53:06 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <sunpeng.li@amd.com>, <roman.li@amd.com>
Subject: [PATCH v4 4/4] drm/amd/display: Add DC_FP helper to check FPU state
Date: Mon, 26 Jul 2021 20:52:48 -0400
Message-ID: <20210727005248.1827411-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210727005248.1827411-1-Rodrigo.Siqueira@amd.com>
References: <20210727005248.1827411-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08d5c469-2841-4c23-ba65-08d95098e64a
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0179:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB017916EBE980DF5AB90F695598E99@BN6PR1201MB0179.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CJdJ7KaF5NQjaRxIQWnOiDiA7ah3qTDIx/hPS9LmEbHh6ZzWo3Bd9e8sKCvkik/k2pBvTHK+vQDT0JJUyEHLpYLDTZVb/Ra8yMe3H0szQVDD1FUQ1ytpjdDw8k/r41BPJWHQD3dssDFYZBCsSK/sO19nv9QWTRA9VN9ilooN9XhU4zZCkfQYG3EdHmkLmfVWS4kas1ubYv3x1UxCGj7EMrPudSdhOOXDxs0r5aeWdqCsWX35GqtrJXAADqVliyj1DnIX+6XLnDxxr8Wu/popIfRsqRreDBXqP2WJ5TqUrBFyJfRTuBG6z6SPsIULpVlev9a2d0Ov9fPEan3qfsFtS1A3kA6qJwfv3dcB0vZkzSXRhLfIB1xgUprVKPIg2MSM7jM1Lfs/LIePSoxMG6yrCl/7UOLkNFzsBUlSEHK1LbSKKaX8oUryR+YZcR+gneZtBqzC+echEJOc3P/miH5SChe9ELZb6Fr2QCNqAE6bJSsI/2oe/MudBvaOysCzA3JZO7ArEoU7aiJZF2qEuD9v2cHhOOoe33BoSBN+UboP/D4k7obT50fGTfISo+xzEmB2t2OFwv3+Ao4cpTmwjTwW3GVk5a/nFLyW7YOPkIReMrhNPfVqYGa/Lq2HuUD9aC0z83ZpW233szGWl6ebSDnuOzpwx8DFc/zJ380eRP+w4l9mMOevIs0qkmhqHHYFhU1ZTuIbET6In1EV4NuUgKjKPlVeuCgJ765Xrbh/zp4GMXU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(36840700001)(46966006)(5660300002)(82740400003)(336012)(82310400003)(2906002)(83380400001)(16526019)(26005)(316002)(66574015)(356005)(36756003)(47076005)(186003)(81166007)(54906003)(6666004)(70206006)(478600001)(86362001)(8676002)(8936002)(2616005)(4326008)(6636002)(110136005)(1076003)(70586007)(36860700001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 00:53:07.7574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d5c469-2841-4c23-ba65-08d95098e64a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0179
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
Cc: Aric Cyr <aric.cyr@amd.com>, kernel test robot <lkp@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Qingqing
 Zhuo <qingqing.zhuo@amd.com>, Anson Jacob <Anson.Jacob@amd.com>,
 Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Jun Lei <jun.lei@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VG8gZnVsbHkgaXNvbGF0ZSBGUFUgb3BlcmF0aW9ucyBpbiBhIHNpbmdsZSBwbGFjZSwgd2UgbXVz
dCBhdm9pZApzaXR1YXRpb25zIHdoZXJlIGNvbXBpbGVycyBzcGlsbCBGUCB2YWx1ZXMgdG8gcmVn
aXN0ZXJzIGR1ZSB0byBGUCBlbmFibGUKaW4gYSBzcGVjaWZpYyBDIGZpbGUuIE5vdGUgdGhhdCBl
dmVuIGlmIHdlIGlzb2xhdGUgYWxsIEZQVSBmdW5jdGlvbnMgaW4KYSBzaW5nbGUgZmlsZSBhbmQg
Y2FsbCBpdHMgaW50ZXJmYWNlIGZyb20gb3RoZXIgZmlsZXMsIHRoZSBjb21waWxlcgptaWdodCBl
bmFibGUgdGhlIHVzZSBvZiBGUFUgYmVmb3JlIHdlIGNhbGwgRENfRlBfU1RBUlQuIE5ldmVydGhl
bGVzcywgaXQKaXMgdGhlIHByb2dyYW1tZXIncyByZXNwb25zaWJpbGl0eSB0byBpbnZva2UgRENf
RlBfU1RBUlQvRU5EIGluIHRoZQpjb3JyZWN0IHBsYWNlLiBUbyBoaWdobGlnaHQgc2l0dWF0aW9u
cyB3aGVyZSBkZXZlbG9wZXJzIGZvcmdvdCB0byB1c2UKdGhlIEZQIHByb3RlY3Rpb24gYmVmb3Jl
IGNhbGxpbmcgdGhlIERDIEZQVSBpbnRlcmZhY2UgZnVuY3Rpb25zLCB3ZQppbnRyb2R1Y2UgYSBo
ZWxwZXIgdGhhdCBjaGVja3MgaWYgdGhlIGZ1bmN0aW9uIGlzIGludm9rZWQgdW5kZXIgRlAKcHJv
dGVjdGlvbi4gSWYgbm90LCBpdCB3aWxsIHRyaWdnZXIgYSBrZXJuZWwgd2FybmluZy4KCkNoYW5n
ZXMgY2luY2UgVjM6Ci0gUmViYXNlCgpDaGFuZ2VzIGNpbmNlIFYyIChDaHJpc3RpYW4pOgotIERv
IG5vdCB1c2UgdGhpc19jcHVfKiBiZXR3ZWVuIGdldC9wdXRfY3B1X3B0cigpLgotIEluIHRoZSBr
ZXJuZWwgZG9jdW1lbnRhdGlvbiwgYmV0dGVyIGRlc2NyaWJlIHJlc3RyaWN0aW9ucy4KLSBNYWtl
IGRjX2Fzc2VydF9mcF9lbmFibGVkIHRyaWdnZXIgdGhlIEFTU0VSVCBtZXNzYWdlLgoKQ2hhbmdl
cyBzaW5jZSBWMToKLSBSZW1vdmUgZnBfZW5hYmxlIHZhcmlhYmxlcwotIFJlbmFtZSBkY19pc19m
cF9lbmFibGVkIHRvIGRjX2Fzc2VydF9mcF9lbmFibGVkCi0gUmVwbGFjZSB3cm9uZyB2YXJpYWJs
ZSB0eXBlCgpDYzogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+CkNjOiBB
bnNvbiBKYWNvYiA8QW5zb24uSmFjb2JAYW1kLmNvbT4KQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IEhlcnNlbiBXdSA8aGVyc2VueHMud3VAYW1kLmNv
bT4KQ2M6IEFyaWMgQ3lyIDxhcmljLmN5ckBhbWQuY29tPgpDYzogSnVuIExlaSA8anVuLmxlaUBh
bWQuY29tPgpDYzogRG15dHJvIExha3R5dXNoa2luIDxkbXl0cm8ubGFrdHl1c2hraW5AYW1kLmNv
bT4KQ2M6IFFpbmdxaW5nIFpodW8gPHFpbmdxaW5nLnpodW9AYW1kLmNvbT4KUmVwb3J0ZWQtYnk6
IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBSb2RyaWdv
IFNpcXVlaXJhIDxSb2RyaWdvLlNpcXVlaXJhQGFtZC5jb20+Ci0tLQogLi4uL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvYW1kZ3B1X2RtL2RjX2ZwdS5jICAgIHwgMTkgKysrKysrKysrKysrKysrKysrKwog
Li4uL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2RjX2ZwdS5oICAgIHwgIDEgKwogLi4u
L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5jIHwgIDIgKysKIC4uLi9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtbC9kY24yeC9kY24yeC5jICB8IDE4ICsrKysrKysrKysr
KysrKysrKwogNCBmaWxlcyBjaGFuZ2VkLCA0MCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9kY19mcHUuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vZGNfZnB1LmMKaW5kZXggMzM4MDdkNzQ2ZTc2
Li5jOWY0N2QxNjc0NzIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9h
bWRncHVfZG0vZGNfZnB1LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdw
dV9kbS9kY19mcHUuYwpAQCAtNDYsNiArNDYsMjUgQEAKIAogc3RhdGljIERFRklORV9QRVJfQ1BV
KGludCwgZnB1X3JlY3Vyc2lvbl9kZXB0aCk7CiAKKy8qKgorICogZGNfYXNzZXJ0X2ZwX2VuYWJs
ZWQgLSBDaGVjayBpZiBGUFUgcHJvdGVjdGlvbiBpcyBlbmFibGVkCisgKgorICogVGhpcyBmdW5j
dGlvbiB0ZWxscyBpZiB0aGUgY29kZSBpcyBhbHJlYWR5IHVuZGVyIEZQVSBwcm90ZWN0aW9uIG9y
IG5vdC4gQQorICogZnVuY3Rpb24gdGhhdCB3b3JrcyBhcyBhbiBBUEkgZm9yIGEgc2V0IG9mIEZQ
VSBvcGVyYXRpb25zIGNhbiB1c2UgdGhpcworICogZnVuY3Rpb24gZm9yIGNoZWNraW5nIGlmIHRo
ZSBjYWxsZXIgaW52b2tlZCBpdCBhZnRlciBEQ19GUF9TVEFSVCgpLiBGb3IKKyAqIGV4YW1wbGUs
IHRha2UgYSBsb29rIGF0IGRjbjJ4LmMgZmlsZS4KKyAqLworaW5saW5lIHZvaWQgZGNfYXNzZXJ0
X2ZwX2VuYWJsZWQodm9pZCkKK3sKKwlpbnQgKnBjcHUsIGRlcHRoID0gMDsKKworCXBjcHUgPSBn
ZXRfY3B1X3B0cigmZnB1X3JlY3Vyc2lvbl9kZXB0aCk7CisJZGVwdGggPSAqcGNwdTsKKwlwdXRf
Y3B1X3B0cigmZnB1X3JlY3Vyc2lvbl9kZXB0aCk7CisKKwlBU1NFUlQoZGVwdGggPiAxKTsKK30K
KwogLyoqCiAgKiBkY19mcHVfYmVnaW4gLSBFbmFibGVzIEZQVSBwcm90ZWN0aW9uCiAgKiBAZnVu
Y3Rpb25fbmFtZTogQSBzdHJpbmcgY29udGFpbmluZyB0aGUgZnVuY3Rpb24gbmFtZSBmb3IgZGVi
dWcgcHVycG9zZXMKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRn
cHVfZG0vZGNfZnB1LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2Rj
X2ZwdS5oCmluZGV4IGZiNTQ5ODNjNWM2MC4uYjgyNzViMzk3OTIwIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2RjX2ZwdS5oCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vZGNfZnB1LmgKQEAgLTI3LDYgKzI3LDcgQEAK
ICNpZm5kZWYgX19EQ19GUFVfSF9fCiAjZGVmaW5lIF9fRENfRlBVX0hfXwogCit2b2lkIGRjX2Fz
c2VydF9mcF9lbmFibGVkKHZvaWQpOwogdm9pZCBkY19mcHVfYmVnaW4oY29uc3QgY2hhciAqZnVu
Y3Rpb25fbmFtZSwgY29uc3QgaW50IGxpbmUpOwogdm9pZCBkY19mcHVfZW5kKGNvbnN0IGNoYXIg
KmZ1bmN0aW9uX25hbWUsIGNvbnN0IGludCBsaW5lKTsKIApkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfcmVzb3VyY2UuYwppbmRleCA5ODhkN2Mw
MjE5OWMuLmUzZTAxYjE3YzE2NCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMKQEAgLTIzNTcsNyArMjM1Nyw5IEBAIGlu
dCBkY24yMF9wb3B1bGF0ZV9kbWxfcGlwZXNfZnJvbV9jb250ZXh0KAogCX0KIAogCS8qIHBvcHVs
YXRlIHdyaXRlYmFjayBpbmZvcm1hdGlvbiAqLworCURDX0ZQX1NUQVJUKCk7CiAJZGMtPnJlc19w
b29sLT5mdW5jcy0+cG9wdWxhdGVfZG1sX3dyaXRlYmFja19mcm9tX2NvbnRleHQoZGMsIHJlc19j
dHgsIHBpcGVzKTsKKwlEQ19GUF9FTkQoKTsKIAogCXJldHVybiBwaXBlX2NudDsKIH0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvZGNuMngvZGNuMnguYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvZGNuMngvZGNuMnguYwppbmRleCA4
ZjBmNjIyMDMyN2QuLmM1ODUyMjQzNjI5MSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2RtbC9kY24yeC9kY24yeC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kbWwvZGNuMngvZGNuMnguYwpAQCAtNDMsNiArNDMsMjIgQEAKICAqICAgIHRo
YXQgZGVhbHMgd2l0aCBGUCByZWdpc3RlciBpcyBjb250YWluZWQgd2l0aGluIHRoaXMgY2FsbC4K
ICAqIDMuIEFsbCBmdW5jdGlvbiB0aGF0IG5lZWRzIHRvIGJlIGFjY2Vzc2VkIG91dHNpZGUgdGhp
cyBmaWxlIHJlcXVpcmVzIGEKICAqICAgIHB1YmxpYyBpbnRlcmZhY2UgdGhhdCBub3QgdXNlcyBh
bnkgRlBVIHJlZmVyZW5jZS4KKyAqIDQuIERldmVsb3BlcnMgKiptdXN0IG5vdCoqIHVzZSBEQ19G
UF9TVEFSVC9FTkQgaW4gdGhpcyBmaWxlLCBidXQgdGhleSBuZWVkCisgKiAgICB0byBlbnN1cmUg
dGhhdCB0aGUgY2FsbGVyIGludm9rZXMgaXQgYmVmb3JlIGFjY2VzcyBhbnkgZnVuY3Rpb24gYXZh
aWxhYmxlCisgKiAgICBpbiB0aGlzIGZpbGUuIEZvciB0aGlzIHJlYXNvbiwgcHVibGljIGZ1bmN0
aW9ucyBpbiB0aGlzIGZpbGUgbXVzdCBpbnZva2UKKyAqICAgIGRjX2Fzc2VydF9mcF9lbmFibGVk
KCk7CisgKgorICogTGV0J3MgZXhwYW5kIGEgbGl0dGxlIGJpdCBtb3JlIHRoZSBpZGVhIGluIHRo
ZSBjb2RlIHBhdHRlcm4uIFRvIGZ1bGx5CisgKiBpc29sYXRlIEZQVSBvcGVyYXRpb25zIGluIGEg
c2luZ2xlIHBsYWNlLCB3ZSBtdXN0IGF2b2lkIHNpdHVhdGlvbnMgd2hlcmUKKyAqIGNvbXBpbGVy
cyBzcGlsbCBGUCB2YWx1ZXMgdG8gcmVnaXN0ZXJzIGR1ZSB0byBGUCBlbmFibGUgaW4gYSBzcGVj
aWZpYyBDCisgKiBmaWxlLiBOb3RlIHRoYXQgZXZlbiBpZiB3ZSBpc29sYXRlIGFsbCBGUFUgZnVu
Y3Rpb25zIGluIGEgc2luZ2xlIGZpbGUgYW5kCisgKiBjYWxsIGl0cyBpbnRlcmZhY2UgZnJvbSBv
dGhlciBmaWxlcywgdGhlIGNvbXBpbGVyIG1pZ2h0IGVuYWJsZSB0aGUgdXNlIG9mCisgKiBGUFUg
YmVmb3JlIHdlIGNhbGwgRENfRlBfU1RBUlQuIE5ldmVydGhlbGVzcywgaXQgaXMgdGhlIHByb2dy
YW1tZXIncworICogcmVzcG9uc2liaWxpdHkgdG8gaW52b2tlIERDX0ZQX1NUQVJUL0VORCBpbiB0
aGUgY29ycmVjdCBwbGFjZS4gVG8gaGlnaGxpZ2h0CisgKiBzaXR1YXRpb25zIHdoZXJlIGRldmVs
b3BlcnMgZm9yZ290IHRvIHVzZSB0aGUgRlAgcHJvdGVjdGlvbiBiZWZvcmUgY2FsbGluZworICog
dGhlIERDIEZQVSBpbnRlcmZhY2UgZnVuY3Rpb25zLCB3ZSBpbnRyb2R1Y2UgYSBoZWxwZXIgdGhh
dCBjaGVja3MgaWYgdGhlCisgKiBmdW5jdGlvbiBpcyBpbnZva2VkIHVuZGVyIEZQIHByb3RlY3Rp
b24uIElmIG5vdCwgaXQgd2lsbCB0cmlnZ2VyIGEga2VybmVsCisgKiB3YXJuaW5nLgogICovCiAK
IHZvaWQgZGNuMjBfcG9wdWxhdGVfZG1sX3dyaXRlYmFja19mcm9tX2NvbnRleHQoc3RydWN0IGRj
ICpkYywKQEAgLTUxLDYgKzY3LDggQEAgdm9pZCBkY24yMF9wb3B1bGF0ZV9kbWxfd3JpdGViYWNr
X2Zyb21fY29udGV4dChzdHJ1Y3QgZGMgKmRjLAogewogCWludCBwaXBlX2NudCwgaTsKIAorCWRj
X2Fzc2VydF9mcF9lbmFibGVkKCk7CisKIAlmb3IgKGkgPSAwLCBwaXBlX2NudCA9IDA7IGkgPCBk
Yy0+cmVzX3Bvb2wtPnBpcGVfY291bnQ7IGkrKykgewogCQlzdHJ1Y3QgZGNfd3JpdGViYWNrX2lu
Zm8gKndiX2luZm8gPSAmcmVzX2N0eC0+cGlwZV9jdHhbaV0uc3RyZWFtLT53cml0ZWJhY2tfaW5m
b1swXTsKIAotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
