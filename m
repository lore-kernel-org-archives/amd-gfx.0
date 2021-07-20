Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF79C07E9B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 00:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B0B0600D1
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 00:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0B0600D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 127486E1A4;
	Tue, 20 Jul 2021 00:49:36 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 076A36E15E;
 Tue, 20 Jul 2021 00:49:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=La25EDrUvJJYQzSFPEQaxzuAquoCNJPCY1hFsY1DTTVdUu85fsuCo/gu5NWRpnKVD3oyGuzu4z478zLbJV3z0RwaIa37AsLT7uvw3Hzj17I84tzucO1Pi9jn8sE5bax0JHjI/q7fc6kSSndUvo7eVFIyz3004VqCKejlD7pMVgJVVYF1hF9KaqY9qC0G7z4Mw0JDDlwnQQ5PDyISnYSQwghzhTXQxPGesrznvePczWBB8u4unsilHbSdsrkaysdWL5A3DXqzT8rFpz8P1n3ji4+NdnWSv9oE7JYn69M2qY+UR2iS3yfKxjuirO6/9K3HNfVp6RI5fHgJpaxctGsBlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dBt126uCiBnN2jSieRkteK5vnQEkFdUDmJ4eVv1nv4=;
 b=R0YeQsFoWMkXc9VFT9MXbxvzccQkSJ/zybS4u7HIdGZrpkkJCukYASjzCGbr04pkUw8k/hHMnbBFvp+kyKXQNGp9Z0EnbtMrnr6MannB/WTmfSRtgJi+Thk8sp82xTsiiaNpmONX8ZZMAqbyjqfZBFB99xjJGbIZudsFKPvIQ11JM2w2FSgYwMgSzdfII9SLPCqWP1C5Z0fgZLMdyNDj81GVscqZ1mkLQ5AZcWjp1lBf/c1pk5CUGcyMIs54/QDGfhsz7CfVLQQYNAMxG+BaeRNgd4TfNB/B9lRwyF1+7z3KwU6ICPiUPpp1+JdlUck1iP9jRMxFZ5SQFUmhDvEAkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dBt126uCiBnN2jSieRkteK5vnQEkFdUDmJ4eVv1nv4=;
 b=a+qWKG5fC3tu4ue6WDx4A17GdgK09hvME2TyldayNenZprPxt0k4fJ6eWL8CgVFPcZao3Ric5dc2tgozn6Zo/DT0/Ow5+cP8tQBjKhNRepgSPFbvkTButUoTAy5iuz/MeEaDxMcc9s2EUF5DS0tjERvqaBS7djPCTXfo+p/rmgc=
Received: from BN9P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::25)
 by DM5PR12MB2534.namprd12.prod.outlook.com (2603:10b6:4:b4::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Tue, 20 Jul
 2021 00:49:32 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::d5) by BN9P223CA0020.outlook.office365.com
 (2603:10b6:408:10b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Tue, 20 Jul 2021 00:49:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 00:49:31 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Jul
 2021 19:49:30 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Daniel Vetter <daniel@ffwll.ch>,
 <roman.li@amd.com>, <sunpeng.li@amd.com>
Subject: [PATCH v3 4/4] drm/amd/display: Add DC_FP helper to check FPU state
Date: Mon, 19 Jul 2021 20:49:14 -0400
Message-ID: <20210720004914.3060879-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210720004914.3060879-1-Rodrigo.Siqueira@amd.com>
References: <20210720004914.3060879-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17383591-646b-4e89-c404-08d94b183ca2
X-MS-TrafficTypeDiagnostic: DM5PR12MB2534:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2534349504AC330764F480F198E29@DM5PR12MB2534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tXbKHiAmBBCdfYSrvQIkZe4bzoK+Zwcw8YQC3xguwitYCfFbXfuMscsGZh8EkspZxV+zCWcag8iva39XaU7hCzMcOiW8IRa5U8YVWSIYZHk6rE9yYuguX7WsxlCro3lNxiMzQRmmdXGS/yRLEdKeZm5hB5A1Opqkp5PbwZrB8NmtMgIpGsJhRAmvNicckPS7zvsSMF49fsHNgKtmAvvdGeWRdWUhR0TErpOGqd+r8PT9D729E1T1jxmLoPlsWjscNMeK035sSwcyKsbCaA1CNAO+++n20apXKm6MT2YaMTmeXjAZsZpiLPN7hu5as/+HarPo5Ymwhfux7glDq7L54PMuvr+5kLtME5QhlTs72vI467j97+HuQutD/WnQzsienlI0kqgGi8sza65W7sOnx0yu9exQA/soR2KZPBrXSdIuUrQX5+suwPyWqGqnnzuxY6FusvXIpOjUOGz40pj4DCq86jNg6TBEWrMvuILKfxJhUT3t0FaiUHnbr10XyXUZ4vJExiPXXlT3xFSn75i89JC3vA5OnAyd6M+hTLQRi/EBzWbmVRYiKF+SDTsiddF4X9UoOOL9qEuSrq6/tGAx3pPcO4VPgpeYjzj2cBYnrPeZ/Uk54ghY9YCNC2Lxgh04udwSTqHwr5h5Dn1WBEBJpV241T6deWZxWPhJEusBS+MT9LHAxIKXcGA9FppDzgk3rEDKixFuHJa7uf03dhMOCDf+g6R/lLTAKTZbb95VeLo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(316002)(5660300002)(6636002)(2906002)(54906003)(4326008)(508600001)(110136005)(336012)(1076003)(83380400001)(82310400003)(66574015)(426003)(81166007)(6666004)(47076005)(86362001)(2616005)(70586007)(70206006)(8936002)(186003)(36756003)(356005)(8676002)(16526019)(36860700001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 00:49:31.7724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17383591-646b-4e89-c404-08d94b183ca2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2534
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
ZXMgY2luY2UgVjIgKENocmlzdGlhbik6Ci0gRG8gbm90IHVzZSB0aGlzX2NwdV8qIGJldHdlZW4g
Z2V0L3B1dF9jcHVfcHRyKCkuCi0gSW4gdGhlIGtlcm5lbCBkb2N1bWVudGF0aW9uLCBiZXR0ZXIg
ZGVzY3JpYmUgcmVzdHJpY3Rpb25zLgotIE1ha2UgZGNfYXNzZXJ0X2ZwX2VuYWJsZWQgdHJpZ2dl
ciB0aGUgQVNTRVJUIG1lc3NhZ2UuCgpDaGFuZ2VzIHNpbmNlIFYxOgotIFJlbW92ZSBmcF9lbmFi
bGUgdmFyaWFibGVzCi0gUmVuYW1lIGRjX2lzX2ZwX2VuYWJsZWQgdG8gZGNfYXNzZXJ0X2ZwX2Vu
YWJsZWQKLSBSZXBsYWNlIHdyb25nIHZhcmlhYmxlIHR5cGUKCkNjOiBIYXJyeSBXZW50bGFuZCA8
aGFycnkud2VudGxhbmRAYW1kLmNvbT4KQ2M6IEFuc29uIEphY29iIDxBbnNvbi5KYWNvYkBhbWQu
Y29tPgpDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzog
SGVyc2VuIFd1IDxoZXJzZW54cy53dUBhbWQuY29tPgpDYzogQXJpYyBDeXIgPGFyaWMuY3lyQGFt
ZC5jb20+ClNpZ25lZC1vZmYtYnk6IFJvZHJpZ28gU2lxdWVpcmEgPFJvZHJpZ28uU2lxdWVpcmFA
YW1kLmNvbT4KLS0tCiAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vZGNfZnB1LmMg
ICAgfCAxOSArKysrKysrKysrKysrKysrKysrCiAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRn
cHVfZG0vZGNfZnB1LmggICAgfCAgMSArCiAuLi4vZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2Rj
bjIwX3Jlc291cmNlLmMgfCAgMiArKwogLi4uL2RybS9hbWQvZGlzcGxheS9kYy9mcHVfb3BlcmF0
aW9ucy9kY24yeC5jIHwgMTggKysrKysrKysrKysrKysrKysrCiA0IGZpbGVzIGNoYW5nZWQsIDQw
IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
YW1kZ3B1X2RtL2RjX2ZwdS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9k
bS9kY19mcHUuYwppbmRleCBkMGQzZThhMzRkYjUuLjEwN2UxYzUwNTc2ZSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9kY19mcHUuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2RjX2ZwdS5jCkBAIC00MSw2ICs0MSwy
NSBAQAogCiBzdGF0aWMgREVGSU5FX1BFUl9DUFUoaW50LCBmcHVfcmVjdXJzaW9uX2RlcHRoKTsK
IAorLyoqCisgKiBkY19hc3NlcnRfZnBfZW5hYmxlZCAtIENoZWNrIGlmIEZQVSBwcm90ZWN0aW9u
IGlzIGVuYWJsZWQKKyAqCisgKiBUaGlzIGZ1bmN0aW9uIHRlbGxzIGlmIHRoZSBjb2RlIGlzIGFs
cmVhZHkgdW5kZXIgRlBVIHByb3RlY3Rpb24gb3Igbm90LiBBCisgKiBmdW5jdGlvbiB0aGF0IHdv
cmtzIGFzIGFuIEFQSSBmb3IgYSBzZXQgb2YgRlBVIG9wZXJhdGlvbnMgY2FuIHVzZSB0aGlzCisg
KiBmdW5jdGlvbiBmb3IgY2hlY2tpbmcgaWYgdGhlIGNhbGxlciBpbnZva2VkIGl0IGFmdGVyIERD
X0ZQX1NUQVJUKCkuIEZvcgorICogZXhhbXBsZSwgdGFrZSBhIGxvb2sgYXQgZGNuMnguYyBmaWxl
LgorICovCitpbmxpbmUgdm9pZCBkY19hc3NlcnRfZnBfZW5hYmxlZCh2b2lkKQoreworCWludCAq
cGNwdSwgZGVwdGggPSAwOworCisJcGNwdSA9IGdldF9jcHVfcHRyKCZmcHVfcmVjdXJzaW9uX2Rl
cHRoKTsKKwlkZXB0aCA9ICpwY3B1OworCXB1dF9jcHVfcHRyKCZmcHVfcmVjdXJzaW9uX2RlcHRo
KTsKKworCUFTU0VSVChkZXB0aCA+IDEpOworfQorCiAvKioKICAqIGRjX2ZwdV9iZWdpbiAtIEVu
YWJsZXMgRlBVIHByb3RlY3Rpb24KICAqIEBmdW5jdGlvbl9uYW1lOiBBIHN0cmluZyBjb250YWlu
aW5nIHRoZSBmdW5jdGlvbiBuYW1lIGZvciBkZWJ1ZyBwdXJwb3NlcwpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9kY19mcHUuaCBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vZGNfZnB1LmgKaW5kZXggZmI1NDk4M2M1YzYwLi5i
ODI3NWIzOTc5MjAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRn
cHVfZG0vZGNfZnB1LmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9k
bS9kY19mcHUuaApAQCAtMjcsNiArMjcsNyBAQAogI2lmbmRlZiBfX0RDX0ZQVV9IX18KICNkZWZp
bmUgX19EQ19GUFVfSF9fCiAKK3ZvaWQgZGNfYXNzZXJ0X2ZwX2VuYWJsZWQodm9pZCk7CiB2b2lk
IGRjX2ZwdV9iZWdpbihjb25zdCBjaGFyICpmdW5jdGlvbl9uYW1lLCBjb25zdCBpbnQgbGluZSk7
CiB2b2lkIGRjX2ZwdV9lbmQoY29uc3QgY2hhciAqZnVuY3Rpb25fbmFtZSwgY29uc3QgaW50IGxp
bmUpOwogCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAv
ZGNuMjBfcmVzb3VyY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9k
Y24yMF9yZXNvdXJjZS5jCmluZGV4IGY5OWIwOTY0M2E1Mi4uZDBiMzRjN2Y5OWRjIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfcmVzb3VyY2Uu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfcmVzb3Vy
Y2UuYwpAQCAtMjM1NSw3ICsyMzU1LDkgQEAgaW50IGRjbjIwX3BvcHVsYXRlX2RtbF9waXBlc19m
cm9tX2NvbnRleHQoCiAJfQogCiAJLyogcG9wdWxhdGUgd3JpdGViYWNrIGluZm9ybWF0aW9uICov
CisJRENfRlBfU1RBUlQoKTsKIAlkYy0+cmVzX3Bvb2wtPmZ1bmNzLT5wb3B1bGF0ZV9kbWxfd3Jp
dGViYWNrX2Zyb21fY29udGV4dChkYywgcmVzX2N0eCwgcGlwZXMpOworCURDX0ZQX0VORCgpOwog
CiAJcmV0dXJuIHBpcGVfY250OwogfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2ZwdV9vcGVyYXRpb25zL2RjbjJ4LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvZnB1X29wZXJhdGlvbnMvZGNuMnguYwppbmRleCA5NWEwYjg5MzAyYTkuLjNlYTkw
MDkwMjY0YyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2ZwdV9v
cGVyYXRpb25zL2RjbjJ4LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Zw
dV9vcGVyYXRpb25zL2RjbjJ4LmMKQEAgLTQzLDYgKzQzLDIyIEBACiAgKiAgICB0aGF0IGRlYWxz
IHdpdGggRlAgcmVnaXN0ZXIgaXMgY29udGFpbmVkIHdpdGhpbiB0aGlzIGNhbGwuCiAgKiAzLiBB
bGwgZnVuY3Rpb24gdGhhdCBuZWVkcyB0byBiZSBhY2Nlc3NlZCBvdXRzaWRlIHRoaXMgZmlsZSBy
ZXF1aXJlcyBhCiAgKiAgICBwdWJsaWMgaW50ZXJmYWNlIHRoYXQgbm90IHVzZXMgYW55IEZQVSBy
ZWZlcmVuY2UuCisgKiA0LiBEZXZlbG9wZXJzICoqbXVzdCBub3QqKiB1c2UgRENfRlBfU1RBUlQv
RU5EIGluIHRoaXMgZmlsZSwgYnV0IHRoZXkgbmVlZAorICogICAgdG8gZW5zdXJlIHRoYXQgdGhl
IGNhbGxlciBpbnZva2VzIGl0IGJlZm9yZSBhY2Nlc3MgYW55IGZ1bmN0aW9uIGF2YWlsYWJsZQor
ICogICAgaW4gdGhpcyBmaWxlLiBGb3IgdGhpcyByZWFzb24sIHB1YmxpYyBmdW5jdGlvbnMgaW4g
dGhpcyBmaWxlIG11c3QgaW52b2tlCisgKiAgICBkY19hc3NlcnRfZnBfZW5hYmxlZCgpOworICoK
KyAqIExldCdzIGV4cGFuZCBhIGxpdHRsZSBiaXQgbW9yZSB0aGUgaWRlYSBpbiB0aGUgY29kZSBw
YXR0ZXJuLiBUbyBmdWxseQorICogaXNvbGF0ZSBGUFUgb3BlcmF0aW9ucyBpbiBhIHNpbmdsZSBw
bGFjZSwgd2UgbXVzdCBhdm9pZCBzaXR1YXRpb25zIHdoZXJlCisgKiBjb21waWxlcnMgc3BpbGwg
RlAgdmFsdWVzIHRvIHJlZ2lzdGVycyBkdWUgdG8gRlAgZW5hYmxlIGluIGEgc3BlY2lmaWMgQwor
ICogZmlsZS4gTm90ZSB0aGF0IGV2ZW4gaWYgd2UgaXNvbGF0ZSBhbGwgRlBVIGZ1bmN0aW9ucyBp
biBhIHNpbmdsZSBmaWxlIGFuZAorICogY2FsbCBpdHMgaW50ZXJmYWNlIGZyb20gb3RoZXIgZmls
ZXMsIHRoZSBjb21waWxlciBtaWdodCBlbmFibGUgdGhlIHVzZSBvZgorICogRlBVIGJlZm9yZSB3
ZSBjYWxsIERDX0ZQX1NUQVJULiBOZXZlcnRoZWxlc3MsIGl0IGlzIHRoZSBwcm9ncmFtbWVyJ3MK
KyAqIHJlc3BvbnNpYmlsaXR5IHRvIGludm9rZSBEQ19GUF9TVEFSVC9FTkQgaW4gdGhlIGNvcnJl
Y3QgcGxhY2UuIFRvIGhpZ2hsaWdodAorICogc2l0dWF0aW9ucyB3aGVyZSBkZXZlbG9wZXJzIGZv
cmdvdCB0byB1c2UgdGhlIEZQIHByb3RlY3Rpb24gYmVmb3JlIGNhbGxpbmcKKyAqIHRoZSBEQyBG
UFUgaW50ZXJmYWNlIGZ1bmN0aW9ucywgd2UgaW50cm9kdWNlIGEgaGVscGVyIHRoYXQgY2hlY2tz
IGlmIHRoZQorICogZnVuY3Rpb24gaXMgaW52b2tlZCB1bmRlciBGUCBwcm90ZWN0aW9uLiBJZiBu
b3QsIGl0IHdpbGwgdHJpZ2dlciBhIGtlcm5lbAorICogd2FybmluZy4KICAqLwogCiB2b2lkIGRj
bjIwX3BvcHVsYXRlX2RtbF93cml0ZWJhY2tfZnJvbV9jb250ZXh0KHN0cnVjdCBkYyAqZGMsCkBA
IC01MSw2ICs2Nyw4IEBAIHZvaWQgZGNuMjBfcG9wdWxhdGVfZG1sX3dyaXRlYmFja19mcm9tX2Nv
bnRleHQoc3RydWN0IGRjICpkYywKIHsKIAlpbnQgcGlwZV9jbnQsIGk7CiAKKwlkY19hc3NlcnRf
ZnBfZW5hYmxlZCgpOworCiAJZm9yIChpID0gMCwgcGlwZV9jbnQgPSAwOyBpIDwgZGMtPnJlc19w
b29sLT5waXBlX2NvdW50OyBpKyspIHsKIAkJc3RydWN0IGRjX3dyaXRlYmFja19pbmZvICp3Yl9p
bmZvID0gJnJlc19jdHgtPnBpcGVfY3R4W2ldLnN0cmVhbS0+d3JpdGViYWNrX2luZm9bMF07CiAK
LS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
