Return-Path: <SRS0=0yA7=YY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BEDCA9ECB
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 14:42:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0AF720873
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 14:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0AF720873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72DE06EEAA;
	Thu, 31 Oct 2019 14:42:35 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820051.outbound.protection.outlook.com [40.107.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CDB96EEA8
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2019 14:42:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBFQTqBogoAgI+E4mXndznuIDw1rqdrJLseLLhmxYmmWQTCn9458c72doGwBT9IlWiP4bwjKUdL6zPppc3SALvYROcZIQ5YsQQZmXf4tx0H3eRlteQFiqhDtf0py4b9hsRfRVUSVjwvuTQWINiL81I/8zHU44Le8sSQhES1DvH6lnZLAjgin78kReZ1wfD97+e92w+m/8qBCTpvtwKth/usjxDsAwOXdQUTAuixYTL3b/f8MVKtvOfGUaiBTBEQcHx3nDY97IYRnrpYN4DRw/4NkqXokW5FfYJzPSlZPbiBnpRYRwmPa43P4X43TvIR01hdLCiN7RVC+HbCf53cEhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEguTslJdQoFHdCudiTH9Jc1JP9/Hl0xj/7Dhn9gc5U=;
 b=X1bj+4Zt0TteCuFbiQuS3pDrb3m/w4HzS5GnUk0LTRtgpDRLZhOfmy1Yx/EA0VXxfaQYgi3o9RkkjRUtlQGAhSDu9HVw5/voZ3UXQjoYPz+4Fh/iwLtw5lj6rwx8saIYDac93RCEbzxYerbET118nNMSNrlKEn9YY2Zy56rl9yCCzeEi2GNhkBgsF0yTYiyUW1n4L6/4HirEGrxZ0C0oTRPwXD89RdO9QcMk7+jcrOQGPeMXhB6IbLZP0hdKvNPMePOu39BpwjvYlcvbikfzdTbrfupK0kxYWEComHRmJ3t+9Yd6t98yDhQ2FP7L5a3Atv4Y7rcL+GFMhWxyKhsKPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from MWHPR12CA0053.namprd12.prod.outlook.com (2603:10b6:300:103::15)
 by BN7PR12MB2594.namprd12.prod.outlook.com (2603:10b6:408:28::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.25; Thu, 31 Oct
 2019 14:42:31 +0000
Received: from DM3NAM03FT043.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::204) by MWHPR12CA0053.outlook.office365.com
 (2603:10b6:300:103::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.20 via Frontend
 Transport; Thu, 31 Oct 2019 14:42:31 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM3NAM03FT043.mail.protection.outlook.com (10.152.83.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Thu, 31 Oct 2019 14:42:31 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 31 Oct
 2019 09:42:30 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 31 Oct 2019 09:42:29 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/20] drm/amd/display: Use SIGNAL_TYPE_NONE in disable_output
 unless eDP
Date: Thu, 31 Oct 2019 10:41:55 -0400
Message-ID: <20191031144210.24011-6-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191031144210.24011-1-Bhawanpreet.Lakha@amd.com>
References: <20191031144210.24011-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(346002)(428003)(199004)(189003)(7696005)(2351001)(76176011)(186003)(81156014)(86362001)(70586007)(26005)(70206006)(81166006)(53416004)(8936002)(305945005)(51416003)(8676002)(6916009)(16586007)(316002)(476003)(50466002)(486006)(336012)(356004)(126002)(47776003)(426003)(50226002)(48376002)(5660300002)(6666004)(446003)(2616005)(36756003)(2906002)(1076003)(4326008)(11346002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2594; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9148f86d-0b7c-4002-814a-08d75e108f71
X-MS-TrafficTypeDiagnostic: BN7PR12MB2594:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2594ABCAE27575BCEB07918BF9630@BN7PR12MB2594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 02070414A1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: chYZxX0gPdwgXildnfkyeAHGWKHEUmFdBakXnI4hmVl1ZaJeFa9pM5y6m+Khm/HnNc53XlM0rSVrxMaI1X1gi0AycpmqsOcOuxLnROr42JMxkd/YACl30UbMNoM0dfBnJ8+UYgEQbM5htrcVJ8In3tRX0yhseTNkAK3SLI7cbjSdid3PWEA5fnjKVdOrsKQqMevjzV+ddyFxYH7VZwIykaKqRnZz2ULrCf/hrrYdoncErP5S8ql127PI41EzBYXkHeTorq99nbLTyhh+8HgkmlZxGYMXaRCBJaOI6RF0U+dIy2FS0JEnoAn7ThmO45cq2NNrJrmEpfII7XYk9TYiqWamVdLsEH+XZ4POcqwSx/NxD7ADiSyzlYftRTFpKiOtgDYPtnM3Fotbi0TV+G1K64V/aqP2CRPviWqloxfbVOb/xAl2p9MvKUrDPnsStFtt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2019 14:42:31.4352 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9148f86d-0b7c-4002-814a-08d75e108f71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2594
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEguTslJdQoFHdCudiTH9Jc1JP9/Hl0xj/7Dhn9gc5U=;
 b=K3v1KhRn7zsI3SkJXdrvrtfNvVY9MfEiosLaAj3WGOz2IHhTSsPB7xBy4tHSis8eFQ6gctwTn2/aQiPs2we2Ahd38bI4uWqo35eXq/Q/bWU00gzMaq8/8uMFzjFHsSoCxKskVxYIEMJq0J1BoI8+P4eyg5mgbMsS0T12ZgIq4EU=
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
Cc: Sung Lee <sung.lee@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191031144155.Kv9AEdQ2evXzIeOtY_SeWeH46zb0jv_tvwPQI47b68I@z>

RnJvbTogU3VuZyBMZWUgPHN1bmcubGVlQGFtZC5jb20+CgpbV0hZXQpDdXJyZW50bHkgbWFkZSBh
IGNoYW5nZSB3aGVyZSBkaXNhYmxlX291dHB1dCBpcyBjYWxsZWQgdXNpbmcgc2lnbmFsX3R5cGUu
ClVzaW5nIGFjdHVhbCBzaWduYWxfdHlwZSB3aGVuIGNhbGlsbmcgZGlzYWJsZV9vdXRwdXQgaW4g
cG93ZXJfZG93bl9lbmNvZGVycwp3b3VsZCBtYWtlIERQIHRvIEhETUkgZG9uZ2xlIG5vdCBsaWdo
dCB1cCBvbiBib290LiBBcyBpdCB3b3VsZCBoYXZlIHNpZ25hbF90eXBlClNJR05BTF9UWVBFX0RJ
U1BMQVlfUE9SVC4KCltIT1ddClNldCBzaWduYWxfdHlwZSB0byBTSUdOQUxfVFlQRV9OT05FIHVu
bGVzcyBpdCBpcyBlRFAuCgpTaWduZWQtb2ZmLWJ5OiBTdW5nIExlZSA8c3VuZy5sZWVAYW1kLmNv
bT4KUmV2aWV3ZWQtYnk6IFlvbmdxaWFuZyBTdW4gPHlvbmdxaWFuZy5zdW5AYW1kLmNvbT4KQWNr
ZWQtYnk6IEJoYXdhbnByZWV0IExha2hhIDxCaGF3YW5wcmVldC5MYWtoYUBhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX2h3X3NlcXVlbmNl
ci5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEwL2RjZTExMF9od19zZXF1ZW5j
ZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX2h3X3Nl
cXVlbmNlci5jCmluZGV4IGYwZTgzN2QxNDAwMC4uMzdmNWJiY2JhMTU1IDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEwL2RjZTExMF9od19zZXF1ZW5jZXIu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEwL2RjZTExMF9od19z
ZXF1ZW5jZXIuYwpAQCAtMTQzOCw2ICsxNDM4LDkgQEAgc3RhdGljIHZvaWQgcG93ZXJfZG93bl9l
bmNvZGVycyhzdHJ1Y3QgZGMgKmRjKQogCQkJaWYgKCFkYy0+bGlua3NbaV0tPndhX2ZsYWdzLmRw
X2tlZXBfcmVjZWl2ZXJfcG93ZXJlZCkKIAkJCQlkcF9yZWNlaXZlcl9wb3dlcl9jdHJsKGRjLT5s
aW5rc1tpXSwgZmFsc2UpOwogCisJCWlmIChzaWduYWwgIT0gU0lHTkFMX1RZUEVfRURQKQorCQkJ
c2lnbmFsID0gU0lHTkFMX1RZUEVfTk9ORTsKKwogCQlkYy0+bGlua3NbaV0tPmxpbmtfZW5jLT5m
dW5jcy0+ZGlzYWJsZV9vdXRwdXQoCiAJCQkJZGMtPmxpbmtzW2ldLT5saW5rX2VuYywgc2lnbmFs
KTsKIAl9Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eA==
