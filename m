Return-Path: <SRS0=5Use=ZK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17095C432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 12:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7B3D20730
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 12:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B3D20730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A35089E7B;
	Mon, 18 Nov 2019 12:28:11 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680050.outbound.protection.outlook.com [40.107.68.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E8D289E7B
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2019 12:28:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUgypmU47iCTtm1H3tRPmoPofe684xlVJCh1E/HRJa4MV9CYlTz/o+8ZYvUrp9/gnHNgqFVOTYd5lIoyC80Ru2EgzsNztGsCAfe9+8zHsxVDWgZvmZolSxxA1T+1oMlAwYwqM0S8ydJJoNdp3AA+YjRIEU8usDw7OCZwBM9yUiv60hCPS3qnzXJljz2ve0C9tPEt6VMQrkOCiADf0N6mRmlcirc7j07nedOYSI98wtK7yUM4r9me/stZczIB7obYfokdzFxyeAXM9ntKrt/TznOEkeocfiRK2wGKdOL98GI1ETQCB5xODyafx7mT80CqZvxhTk4WKr0h4BvjpRYA7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtajV1RxVjpQ0q+2ifGqqNDPXC+e8sgLYRWkIYZS0x4=;
 b=oNyL2GUr3reOBfXNLT7wx71dFS2zVbequzpZPxnkpoJc885ScuSNyBm7C8aJ8Gxqbc0IErFfxzxo+SzaK1/5Jo8wgXb28UZc7JPDDHoxEXOEfdQ6yPj+CxMyntnbZs9zetod8HAXmbHnhipDxifnygjLmUtFzYfJbkEkOsMeLkpS0kJnloYFcuR0KoYjFwOtBHSf6RmPo7YmTqYMg1TIshI3HwzOPE98p3nOz8onZYgusYhSm1iIFT05bfNuidNted18/lc1thb24zY37D0TMec4mj63RahPEfKSR3hlz1+85Yib23nkonel6uLSKWBScB8UH9Cm5OJeHp5RR04fug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from SN1PR12CA0107.namprd12.prod.outlook.com (2603:10b6:802:21::42)
 by DM6PR12MB3513.namprd12.prod.outlook.com (2603:10b6:5:18a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.29; Mon, 18 Nov
 2019 12:28:07 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::202) by SN1PR12CA0107.outlook.office365.com
 (2603:10b6:802:21::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2451.23 via Frontend
 Transport; Mon, 18 Nov 2019 12:28:07 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Mon, 18 Nov 2019 12:28:07 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 18 Nov
 2019 06:28:02 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 18 Nov
 2019 06:28:02 -0600
Received: from yttao-code-machine.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 18 Nov 2019 06:28:01 -0600
From: Yintian Tao <yttao@amd.com>
To: <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: put flush_dealyed_work at first
Date: Mon, 18 Nov 2019 20:27:59 +0800
Message-ID: <20191118122759.15654-1-yttao@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(428003)(189003)(199004)(2616005)(53416004)(2906002)(1076003)(356004)(6636002)(6862004)(70206006)(316002)(2351001)(16586007)(305945005)(36756003)(70586007)(5660300002)(47776003)(54906003)(51416003)(7696005)(186003)(336012)(426003)(476003)(26005)(50226002)(8936002)(48376002)(14444005)(126002)(486006)(37006003)(81166006)(478600001)(4326008)(8676002)(50466002)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3513; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38a011b7-3bff-4f57-4244-08d76c22c41d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3513:
X-Microsoft-Antispam-PRVS: <DM6PR12MB35134FD21EFE6D71B4DB58F4E54D0@DM6PR12MB3513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0225B0D5BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WCJKMGtrfseoxClFh6pLW8GfhZZvK3BDTLqfwTPjpusWzyRM15Rw4ppryTx7BVRnDo0HEZp4vs6nRfV84k+GDrZSGiJHF4tYxEB6xRGr3J/xaIwsxnoYl4oDXEbfWlEj/EQ0z5ZKFiHw5QDGGzvO81LjDW85cZ3J4RHfNKR/ZipdnGT0oMa6V1j1dILtdzQ0fAEzckhYh9quN87/fRykRgBzHRaamd6pw3lc1Ttq3AafpaURkalW80iRbXM84i1N/ZYgFxkYstf9091Or67Y95SIo8bouxXwkH3ha2YWKqoNTXgntXPOpe0F5f6J/lUy0l9NMfx+YPHj8Wk2jHdt94UBu1F/8OAdzdzYoebaZcKr5DQ9b8k/zLaM3ibdmqsJLNOanAFG+VrlnMQdEoGBU/nTA15eMDLE5J1X1oopu10hym5BldqFKxKC6pEnQqAE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2019 12:28:07.0313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a011b7-3bff-4f57-4244-08d76c22c41d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3513
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtajV1RxVjpQ0q+2ifGqqNDPXC+e8sgLYRWkIYZS0x4=;
 b=hnpnJkRgNDLzeHsDhguxuMgb85JbMJ1BGfBg7af15luq39qWH0uLJ+6H7r/B2VG+mRRsAI19wblKilTSrCouSS2DA+LeBgQZcu0fMSKq28lbCZHVgp4NZ8DPY5dCcS/QjQu9xtAYPjzToP103vLo2OQrEjT4S/mmAkkYUwkMsFI=
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
Cc: amd-gfx@lists.freedesktop.org, Yintian Tao <yttao@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191118122759.eTdmLbt05NUNqG-Vhmt4ds3LhjsuShz-6DLq2csm5rU@z>

VGhlcmUgaXMgb25lIHJlZ3Jlc3Npb24gZnJvbSAwNDJmM2Q3Yjc0NWNkNzZhYQpUbyBwdXQgZmx1
c2hfZGVsYXllZF93b3JrIGFmdGVyIGFkZXYtPnNodXRkb3duID0gdHJ1ZQp3aGljaCB3aWxsIG1h
a2UgYW1kZ3B1X2loX3Byb2Nlc3Mgbm90IHJlc3BvbnNlIHRoZSBpcnEKQXQgbGFzdCwgYWxsIGli
IHJpbmcgdGVzdHMgd2lsbCBiZSBmYWlsZWQganVzdCBsaWtlIGJlbG93CgpbZHJtXSBhbWRncHU6
IGZpbmlzaGluZyBkZXZpY2UuCltkcm1dIEZlbmNlIGZhbGxiYWNrIHRpbWVyIGV4cGlyZWQgb24g
cmluZyBnZngKW2RybV0gRmVuY2UgZmFsbGJhY2sgdGltZXIgZXhwaXJlZCBvbiByaW5nIGNvbXBf
MS4wLjAKW2RybV0gRmVuY2UgZmFsbGJhY2sgdGltZXIgZXhwaXJlZCBvbiByaW5nIGNvbXBfMS4x
LjAKW2RybV0gRmVuY2UgZmFsbGJhY2sgdGltZXIgZXhwaXJlZCBvbiByaW5nIGNvbXBfMS4yLjAK
W2RybV0gRmVuY2UgZmFsbGJhY2sgdGltZXIgZXhwaXJlZCBvbiByaW5nIGNvbXBfMS4zLjAKW2Ry
bV0gRmVuY2UgZmFsbGJhY2sgdGltZXIgZXhwaXJlZCBvbiByaW5nIGNvbXBfMS4wLjEKYW1kZ3B1
IDAwMDA6MDA6MDcuMDogW2RybTphbWRncHVfaWJfcmluZ190ZXN0cyBbYW1kZ3B1XV0gKkVSUk9S
KiBJQiB0ZXN0IGZhaWxlZCBvbiBjb21wXzEuMS4xICgtMTEwKS4KYW1kZ3B1IDAwMDA6MDA6MDcu
MDogW2RybTphbWRncHVfaWJfcmluZ190ZXN0cyBbYW1kZ3B1XV0gKkVSUk9SKiBJQiB0ZXN0IGZh
aWxlZCBvbiBjb21wXzEuMi4xICgtMTEwKS4KYW1kZ3B1IDAwMDA6MDA6MDcuMDogW2RybTphbWRn
cHVfaWJfcmluZ190ZXN0cyBbYW1kZ3B1XV0gKkVSUk9SKiBJQiB0ZXN0IGZhaWxlZCBvbiBjb21w
XzEuMy4xICgtMTEwKS4KYW1kZ3B1IDAwMDA6MDA6MDcuMDogW2RybTphbWRncHVfaWJfcmluZ190
ZXN0cyBbYW1kZ3B1XV0gKkVSUk9SKiBJQiB0ZXN0IGZhaWxlZCBvbiBzZG1hMCAoLTExMCkuCmFt
ZGdwdSAwMDAwOjAwOjA3LjA6IFtkcm06YW1kZ3B1X2liX3JpbmdfdGVzdHMgW2FtZGdwdV1dICpF
UlJPUiogSUIgdGVzdCBmYWlsZWQgb24gc2RtYTEgKC0xMTApLgphbWRncHUgMDAwMDowMDowNy4w
OiBbZHJtOmFtZGdwdV9pYl9yaW5nX3Rlc3RzIFthbWRncHVdXSAqRVJST1IqIElCIHRlc3QgZmFp
bGVkIG9uIHV2ZF9lbmNfMC4wICgtMTEwKS4KYW1kZ3B1IDAwMDA6MDA6MDcuMDogW2RybTphbWRn
cHVfaWJfcmluZ190ZXN0cyBbYW1kZ3B1XV0gKkVSUk9SKiBJQiB0ZXN0IGZhaWxlZCBvbiB2Y2Uw
ICgtMTEwKS4KW2RybTphbWRncHVfZGV2aWNlX2RlbGF5ZWRfaW5pdF93b3JrX2hhbmRsZXIgW2Ft
ZGdwdV1dICpFUlJPUiogaWIgcmluZyB0ZXN0IGZhaWxlZCAoLTExMCkuCgp2MjogcmVwbGFjZSBj
YW5jZWxfZGVsYXllZF93b3JrX3N5bmMoKSB3aXRoIGZsdXNoX2RlbGF5ZWRfd29yaygpCgpTaWdu
ZWQtb2ZmLWJ5OiBZaW50aWFuIFRhbyA8eXR0YW9AYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCA0ICstLS0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGV2aWNlLmMKaW5kZXggMTdiZTYzODlhZGY3Li5iN2FiNTIyNGFlMjMgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKQEAgLTMxMDksOSArMzEw
OSw4IEBAIHZvaWQgYW1kZ3B1X2RldmljZV9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KQogCWludCByOwogCiAJRFJNX0lORk8oImFtZGdwdTogZmluaXNoaW5nIGRldmljZS5cbiIpOwot
CWFkZXYtPnNodXRkb3duID0gdHJ1ZTsKLQogCWZsdXNoX2RlbGF5ZWRfd29yaygmYWRldi0+ZGVs
YXllZF9pbml0X3dvcmspOworCWFkZXYtPnNodXRkb3duID0gdHJ1ZTsKIAogCS8qIGRpc2FibGUg
YWxsIGludGVycnVwdHMgKi8KIAlhbWRncHVfaXJxX2Rpc2FibGVfYWxsKGFkZXYpOwpAQCAtMzEz
MCw3ICszMTI5LDYgQEAgdm9pZCBhbWRncHVfZGV2aWNlX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpCiAJCWFkZXYtPmZpcm13YXJlLmdwdV9pbmZvX2Z3ID0gTlVMTDsKIAl9CiAJYWRl
di0+YWNjZWxfd29ya2luZyA9IGZhbHNlOwotCWNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmYWRl
di0+ZGVsYXllZF9pbml0X3dvcmspOwogCS8qIGZyZWUgaTJjIGJ1c2VzICovCiAJaWYgKCFhbWRn
cHVfZGV2aWNlX2hhc19kY19zdXBwb3J0KGFkZXYpKQogCQlhbWRncHVfaTJjX2ZpbmkoYWRldik7
Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
