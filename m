Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54FCC432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6E0520848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E0520848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 451846E2B4;
	Mon,  2 Dec 2019 17:35:08 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720044.outbound.protection.outlook.com [40.107.72.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DDAE6E2A3
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkZqMFNfhiL4akAd0mLnv1Cf1NYKi9dPyoMoDciHAId4H7CmlG/aefzlSXZ2gtM26hog8Dl0qlA/gTuZFwT2U5U3TR/ZxcXcP6ZC8iNlg337MB2/XU06+FHnX5Cgqo0gXucgijdBdKvNJxw/NXVAGrlhBDzYkYmReKBeItYi87/cxnwm21cFKjIKnawEvfsC+u+OBDhEy71j1DC6/N7UzIxRMexj7CMa/Kj01+GAiheSMNeBivrmJgnF31cbLUQh74H9ODwOh0PkoyPt1rNP72wWe/7NSYN0mUYXDJF5otdQ82y0Ybmx7HhbDKpd+9VUdJHrnXkvG84lY53S1IXwrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQtsceXv4xCpm2/oGHXxr29FnOYDRVsX/XKaOqi3cc0=;
 b=YWwRYklN+BWNgxVpQjNh/tTAmVIeUVNHxRFMDUkJNHcvl3b73a5mB+z7/+MRNal3AB+V1ImqAPKI0+PZV9UouOVTRPgjwU9UiGeaV38KFkdCD5Cc70I+VopjvpPY+VKoHkHjiPOXD4Hw25ZUn64UQM1dYfcWIeoyLFqqdUaYqdORW9knfoJrfmwVlLiokWo9Y5BNmikOY9Oj3JTl+rhRMcfHMcIn2ayFjxjEVcoATNpkMlctaPJ0ddD9344IRWTZrc3ZfqSNmtl7dvA2hrEIQ1wDD+pQgR5K/1qfdOUBhPWA5OyQA0NhNwruE2gFhLVngGAsAQNHotetfd4gwDhv0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2802.namprd12.prod.outlook.com (20.176.27.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:35:02 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:35:02 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/51] drm/amd/display: have two different sr and pstate
 latency tables for renoir
Date: Mon,  2 Dec 2019 12:33:30 -0500
Message-Id: <20191202173405.31582-17-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191202173405.31582-1-sunpeng.li@amd.com>
References: <20191202173405.31582-1-sunpeng.li@amd.com>
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To BN7PR12MB2593.namprd12.prod.outlook.com
 (2603:10b6:408:25::23)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b79bcaee-5c8b-440e-0020-08d7774df5d6
X-MS-TrafficTypeDiagnostic: BN7PR12MB2802:|BN7PR12MB2802:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB280236A7BB9DB43279375A7582430@BN7PR12MB2802.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(189003)(199004)(81166006)(81156014)(86362001)(6486002)(9686003)(6506007)(2870700001)(478600001)(386003)(76176011)(5660300002)(51416003)(186003)(1076003)(52116002)(3846002)(6116002)(47776003)(2616005)(26005)(66946007)(66066001)(25786009)(316002)(446003)(11346002)(14454004)(66476007)(66556008)(48376002)(8676002)(50226002)(305945005)(6512007)(36756003)(2906002)(99286004)(6666004)(7736002)(2351001)(54906003)(4326008)(2361001)(6916009)(6436002)(50466002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2802;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JWG62pNpQ8q3LOuSgDXVNIXWNSbSLZsstB5IKUsD4tzsIbkFMWRnMlilMWmHCztP1p+NYzWFGma1Gs+fnwBXjR2NrFWFT7vhQkETbe3f060lgKowvW7lw7t+pUrfnZnLPQua4ee7Ufr6/uGSCjzAQE1ROh3Jb9grgVSRoUis7o7pEkeHtVfGXDSKnVW+Zfquxy0xICz/UQgJukRnmFubodhNSQuRL5gNujEdeywttkHrv+Rx7OtN3blcamFscElDgTtI7rq+a3vMEwRwVhpLomAva6SyYFS0kAx2p9itxgicDIIX4zQhCgs6B7TCkMcHA/ysNlbhub035IUQbTsAgzNCyaZOBwgy0IioGjJXhCtY+ptwpU7BzaUGBWIIBzGpEh7CuwxYphr5HMQooxAXG4qpsAHkIcnYHL8Dd6hlfjWrxkKLkQZQaVBGhDLbkkYQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b79bcaee-5c8b-440e-0020-08d7774df5d6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:35:01.9472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OeSToM0xWoJhZFzMvMwWhYK3jNP8YSJ9Kz1FSRPpHenQLTldvfWqvwRByQa35S4l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2802
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQtsceXv4xCpm2/oGHXxr29FnOYDRVsX/XKaOqi3cc0=;
 b=xKcA5IHFCfi/+Kv9uZ4m0edJ9RiiwIVFNJkzWcUcTZNaXMTsyVVic8N9ahh9/FBmSFaaLeCuC3A0MEVY2W9WATaIXMYlwB9JSK+GfNFOoS0fgX9TB6dErxcuIH8BpzdwW5VKPCmuNVFoeovtz+85QtDH4zytU8APtkiJtdLbPH4=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sunpeng.Li@amd.com; 
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
Cc: Eric Yang <eric.yang2@amd.com>, Leo Li <sunpeng.li@amd.com>,
 harry.wentland@amd.com, rodrigo.siqueira@amd.com,
 Joseph Gravenor <joseph.gravenor@amd.com>, bhawanpreet.lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogSm9zZXBoIEdyYXZlbm9yIDxqb3NlcGguZ3JhdmVub3JAYW1kLmNvbT4KCltXaHldCm5l
dyBzciBhbmQgcHN0YXRlIGxhdGVuY2llcyBhcmUgb3B0aW1pemVkIGZvciB0aGUgY2FzZSB3aGVu
IHdlIGFyZSBub3QKdXNpbmcgbHBkZHI0IG1lbW9yeQoKW0hvd10KaGF2ZSB0d28gZGlmZmVyZW50
IHdtIHRhYmxlcywgb25lIGZvciB0aGUgbHBkZHIgY2FzZSBhbmQgb25lIGZvcgpub24gbHBkZHIg
Y2FzZQoKU2lnbmVkLW9mZi1ieTogSm9zZXBoIEdyYXZlbm9yIDxqb3NlcGguZ3JhdmVub3JAYW1k
LmNvbT4KUmV2aWV3ZWQtYnk6IEVyaWMgWWFuZyA8ZXJpYy55YW5nMkBhbWQuY29tPgpBY2tlZC1i
eTogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+Ci0tLQogLi4uL2FtZC9kaXNwbGF5L2RjL2Ns
a19tZ3IvZGNuMjEvcm5fY2xrX21nci5jIHwgMTE0ICsrKysrKysrKysrKy0tLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDgwIGluc2VydGlvbnMoKyksIDM0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jbGtfbWdyL2RjbjIxL3JuX2Nsa19tZ3Iu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jbGtfbWdyL2RjbjIxL3JuX2Nsa19t
Z3IuYwppbmRleCA5ZjAzODFjNjg4NDQuLjg5ZWQyMzBjZGIyNiAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Nsa19tZ3IvZGNuMjEvcm5fY2xrX21nci5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jbGtfbWdyL2RjbjIxL3JuX2Nsa19tZ3Iu
YwpAQCAtNTE4LDQ0ICs1MTgsODMgQEAgc3RydWN0IGNsa19id19wYXJhbXMgcm5fYndfcGFyYW1z
ID0gewogCQkubnVtX2VudHJpZXMgPSA0LAogCX0sCiAKLQkud21fdGFibGUgPSB7Ci0JCS5lbnRy
aWVzID0gewotCQkJewotCQkJCS53bV9pbnN0ID0gV01fQSwKLQkJCQkud21fdHlwZSA9IFdNX1RZ
UEVfUFNUQVRFX0NIRywKLQkJCQkucHN0YXRlX2xhdGVuY3lfdXMgPSAxMS43MiwKLQkJCQkuc3Jf
ZXhpdF90aW1lX3VzID0gNi4wOSwKLQkJCQkuc3JfZW50ZXJfcGx1c19leGl0X3RpbWVfdXMgPSA3
LjE0LAotCQkJCS52YWxpZCA9IHRydWUsCi0JCQl9LAotCQkJewotCQkJCS53bV9pbnN0ID0gV01f
QiwKLQkJCQkud21fdHlwZSA9IFdNX1RZUEVfUFNUQVRFX0NIRywKLQkJCQkucHN0YXRlX2xhdGVu
Y3lfdXMgPSAxMS43MiwKLQkJCQkuc3JfZXhpdF90aW1lX3VzID0gMTAuMTIsCi0JCQkJLnNyX2Vu
dGVyX3BsdXNfZXhpdF90aW1lX3VzID0gMTEuNDgsCi0JCQkJLnZhbGlkID0gdHJ1ZSwKLQkJCX0s
Ci0JCQl7Ci0JCQkJLndtX2luc3QgPSBXTV9DLAotCQkJCS53bV90eXBlID0gV01fVFlQRV9QU1RB
VEVfQ0hHLAotCQkJCS5wc3RhdGVfbGF0ZW5jeV91cyA9IDExLjcyLAotCQkJCS5zcl9leGl0X3Rp
bWVfdXMgPSAxMC4xMiwKLQkJCQkuc3JfZW50ZXJfcGx1c19leGl0X3RpbWVfdXMgPSAxMS40OCwK
LQkJCQkudmFsaWQgPSB0cnVlLAotCQkJfSwKLQkJCXsKLQkJCQkud21faW5zdCA9IFdNX0QsCi0J
CQkJLndtX3R5cGUgPSBXTV9UWVBFX1BTVEFURV9DSEcsCi0JCQkJLnBzdGF0ZV9sYXRlbmN5X3Vz
ID0gMTEuNzIsCi0JCQkJLnNyX2V4aXRfdGltZV91cyA9IDEwLjEyLAotCQkJCS5zcl9lbnRlcl9w
bHVzX2V4aXRfdGltZV91cyA9IDExLjQ4LAotCQkJCS52YWxpZCA9IHRydWUsCi0JCQl9LAorfTsK
Kworc3RydWN0IHdtX3RhYmxlIGRkcjRfd21fdGFibGUgPSB7CisJLmVudHJpZXMgPSB7CisJCXsK
KwkJCS53bV9pbnN0ID0gV01fQSwKKwkJCS53bV90eXBlID0gV01fVFlQRV9QU1RBVEVfQ0hHLAor
CQkJLnBzdGF0ZV9sYXRlbmN5X3VzID0gMTEuNzIsCisJCQkuc3JfZXhpdF90aW1lX3VzID0gNi4w
OSwKKwkJCS5zcl9lbnRlcl9wbHVzX2V4aXRfdGltZV91cyA9IDcuMTQsCisJCQkudmFsaWQgPSB0
cnVlLAorCQl9LAorCQl7CisJCQkud21faW5zdCA9IFdNX0IsCisJCQkud21fdHlwZSA9IFdNX1RZ
UEVfUFNUQVRFX0NIRywKKwkJCS5wc3RhdGVfbGF0ZW5jeV91cyA9IDExLjcyLAorCQkJLnNyX2V4
aXRfdGltZV91cyA9IDEwLjEyLAorCQkJLnNyX2VudGVyX3BsdXNfZXhpdF90aW1lX3VzID0gMTEu
NDgsCisJCQkudmFsaWQgPSB0cnVlLAorCQl9LAorCQl7CisJCQkud21faW5zdCA9IFdNX0MsCisJ
CQkud21fdHlwZSA9IFdNX1RZUEVfUFNUQVRFX0NIRywKKwkJCS5wc3RhdGVfbGF0ZW5jeV91cyA9
IDExLjcyLAorCQkJLnNyX2V4aXRfdGltZV91cyA9IDEwLjEyLAorCQkJLnNyX2VudGVyX3BsdXNf
ZXhpdF90aW1lX3VzID0gMTEuNDgsCisJCQkudmFsaWQgPSB0cnVlLAorCQl9LAorCQl7CisJCQku
d21faW5zdCA9IFdNX0QsCisJCQkud21fdHlwZSA9IFdNX1RZUEVfUFNUQVRFX0NIRywKKwkJCS5w
c3RhdGVfbGF0ZW5jeV91cyA9IDExLjcyLAorCQkJLnNyX2V4aXRfdGltZV91cyA9IDEwLjEyLAor
CQkJLnNyX2VudGVyX3BsdXNfZXhpdF90aW1lX3VzID0gMTEuNDgsCisJCQkudmFsaWQgPSB0cnVl
LAogCQl9LAogCX0KIH07CiAKK3N0cnVjdCB3bV90YWJsZSBscGRkcjRfd21fdGFibGUgPSB7CisJ
LmVudHJpZXMgPSB7CisJCXsKKwkJCS53bV9pbnN0ID0gV01fQSwKKwkJCS53bV90eXBlID0gV01f
VFlQRV9QU1RBVEVfQ0hHLAorCQkJLnBzdGF0ZV9sYXRlbmN5X3VzID0gMjMuODQsCisJCQkuc3Jf
ZXhpdF90aW1lX3VzID0gMTIuNSwKKwkJCS5zcl9lbnRlcl9wbHVzX2V4aXRfdGltZV91cyA9IDE3
LjAsCisJCQkudmFsaWQgPSB0cnVlLAorCQl9LAorCQl7CisJCQkud21faW5zdCA9IFdNX0IsCisJ
CQkud21fdHlwZSA9IFdNX1RZUEVfUFNUQVRFX0NIRywKKwkJCS5wc3RhdGVfbGF0ZW5jeV91cyA9
IDIzLjg0LAorCQkJLnNyX2V4aXRfdGltZV91cyA9IDEyLjUsCisJCQkuc3JfZW50ZXJfcGx1c19l
eGl0X3RpbWVfdXMgPSAxNy4wLAorCQkJLnZhbGlkID0gdHJ1ZSwKKwkJfSwKKwkJeworCQkJLndt
X2luc3QgPSBXTV9DLAorCQkJLndtX3R5cGUgPSBXTV9UWVBFX1BTVEFURV9DSEcsCisJCQkucHN0
YXRlX2xhdGVuY3lfdXMgPSAyMy44NCwKKwkJCS5zcl9leGl0X3RpbWVfdXMgPSAxMi41LAorCQkJ
LnNyX2VudGVyX3BsdXNfZXhpdF90aW1lX3VzID0gMTcuMCwKKwkJCS52YWxpZCA9IHRydWUsCisJ
CX0sCisJCXsKKwkJCS53bV9pbnN0ID0gV01fRCwKKwkJCS53bV90eXBlID0gV01fVFlQRV9QU1RB
VEVfQ0hHLAorCQkJLnBzdGF0ZV9sYXRlbmN5X3VzID0gMjMuODQsCisJCQkuc3JfZXhpdF90aW1l
X3VzID0gMTIuNSwKKwkJCS5zcl9lbnRlcl9wbHVzX2V4aXRfdGltZV91cyA9IDE3LjAsCisJCQku
dmFsaWQgPSB0cnVlLAorCQl9LAorCX0KK307CisKKwogc3RhdGljIHVuc2lnbmVkIGludCBmaW5k
X2RjZmNsa19mb3Jfdm9sdGFnZShzdHJ1Y3QgZHBtX2Nsb2NrcyAqY2xvY2tfdGFibGUsIHVuc2ln
bmVkIGludCB2b2x0YWdlKQogewogCWludCBpOwpAQCAtNjc3LDEwICs3MTYsMTcgQEAgdm9pZCBy
bl9jbGtfbWdyX2NvbnN0cnVjdCgKIAkJCUFTU0VSVChjbGtfbWdyLT5iYXNlLmRwcmVmY2xrX2to
eiA9PSA2MDAwMDApOwogCQkJY2xrX21nci0+YmFzZS5kcHJlZmNsa19raHogPSA2MDAwMDA7CiAJ
CX0KKworCQlpZiAoY3R4LT5kY19iaW9zLT5pbnRlZ3JhdGVkX2luZm8tPm1lbW9yeV90eXBlID09
IExwRGRyNE1lbVR5cGUpIHsKKwkJCXJuX2J3X3BhcmFtcy53bV90YWJsZSA9IGxwZGRyNF93bV90
YWJsZTsKKwkJfSBlbHNlIHsKKwkJCXJuX2J3X3BhcmFtcy53bV90YWJsZSA9IGRkcjRfd21fdGFi
bGU7CisJCX0KIAl9CiAKIAlkY2VfY2xvY2tfcmVhZF9zc19pbmZvKGNsa19tZ3IpOwogCisKIAlj
bGtfbWdyLT5iYXNlLmJ3X3BhcmFtcyA9ICZybl9id19wYXJhbXM7CiAKIAlpZiAocHBfc211ICYm
IHBwX3NtdS0+cm5fZnVuY3MuZ2V0X2RwbV9jbG9ja190YWJsZSkgewotLSAKMi4yNC4wCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
