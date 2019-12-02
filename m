Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF77C432C3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEEE72084F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEEE72084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D42C36E28B;
	Mon,  2 Dec 2019 17:34:52 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790083.outbound.protection.outlook.com [40.107.79.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF7EC6E28B
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:34:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZ6Obq8xGA/16xtXwCZ41VrPOQt2xrdHuxIzRsrGoOXxfOVsaWbzlnugs4+X+bZHNaZaLqi5vJF1oedeJnp21BJKYmYL/R1Tjj3ylqPTpsG9oxKwM4yUTHfJSJsN9956D0+wtE3QsjnlowaNd3O0HeFDXUs1Wxe6ZAymG69sTarK4sIJsc3UtAhAAdGwLwTs9sfLtmQS9s5z1FALst0L/yzdwgh9QcJiu3xVoGBreGszU+1QQlBvQn8+A1IPSOdzwbgiYCAAnbNk3v/spfmTgxpvzWDHHnMGdA/AOWE8zqEWTBXT507R7ADqIpjcOsttD8wUxHBKZhhMGKSeNgMnaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urkR4xoi4JLyUchhaoa8S5Okz6q74hRfpY3flcvGe0A=;
 b=hEOYp2xK7Mh45NnTm1iuC5flh4vdXVQD7f5ah+AwMmwzT76DvPc4UQeIqVZr7Yd26Ax2J8G2eDMiuSIuZ/2RTsLMNnlwYWIFERnZFOtIMxGknwa1+2oEPmjibUfy2UbSRsXYi9iWqAq11+aRaiDteyCwAVe3q5GLcYIFjUdeU4FJoDJaZhRBnV4nPY+HtSayGHzuO59c275UgffonskJ5WH2pOO6mwF9GcNP4YuqrZgOT2cg7xPdKmW5C76SRQ6Sua5q8COVknqFGQv5Bxg6C8c5kkDoqHOadIscvdkQd8qmbsukKUfeh2aSnj3jVpmShC2Hww1gV8vCVz2/aTx0gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2724.namprd12.prod.outlook.com (20.176.178.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:34:48 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:34:48 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/51] drm/amd/display: update sr and pstate latencies for
 Renoir
Date: Mon,  2 Dec 2019 12:33:15 -0500
Message-Id: <20191202173405.31582-2-sunpeng.li@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3cb04c34-d0f1-4e41-5fb1-08d7774deda9
X-MS-TrafficTypeDiagnostic: BN7PR12MB2724:|BN7PR12MB2724:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2724EE9958BBB495929215EF82430@BN7PR12MB2724.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(189003)(199004)(11346002)(6486002)(14454004)(2351001)(2616005)(6666004)(47776003)(2870700001)(305945005)(7736002)(8936002)(50466002)(2361001)(48376002)(86362001)(50226002)(36756003)(4326008)(9686003)(6512007)(6436002)(6116002)(3846002)(2906002)(6916009)(54906003)(316002)(446003)(81156014)(81166006)(66066001)(8676002)(25786009)(478600001)(5660300002)(66946007)(66556008)(66476007)(99286004)(1076003)(52116002)(51416003)(76176011)(386003)(186003)(26005)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2724;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: prUJVK8GTnBmckctHdG1rlUUQl9QR889Zpe1MlOiqcT9aKPuvk5/3CjRBVjv/LiqiQgxE3MfQ0X3pS7twW04opiHz5NHIqurib1epf+VXYAakhLOlDUhaigFMh15TFI8hSuZ1EF4jnJTUbnysMNl64C12JhSfXFoIYvHIR1AkJqMzwNRq2Hmhw1EMe6eN47uuM3vvrOyaz3xYKdbPkDmNxlFgZcS7jwnAjbSNtMy49HnOyXUNzSjHuBXaYLM16FIOXrNWT/9d7Fz6lqXvMasZNIaBfOEtAGcCREP0VpARl1PzvOsp8t59XtRd6f9SUJ+suO+1/phm9OZIOW4L+yQMRQpsvSo7NQ7gBvyfss73qGvzFo/Co/+9RYyHCNaKb6yQMkOi6ZSvHGUQdVCgM8d7Ip+cGRmff1MMCs7mg3FGsjOXJLN1HlNHaMTDCfROlQH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb04c34-d0f1-4e41-5fb1-08d7774deda9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:34:48.2360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4UkLwI31k4AWlOO5JZljrFNyu31sRqUBqlDS8lvZG1OIQtEK/4GQnRi0EPcDE1DF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2724
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urkR4xoi4JLyUchhaoa8S5Okz6q74hRfpY3flcvGe0A=;
 b=ScrajoBz7eOfcDupltA4g0E2C5HoYsI1Um3Q/K393DWht1OTIONzVxd23S2mcGbLZYmuu1hMqJ/vhvEL8oyMMv/ZIcB9Iv0FApxoL1279TVi1QOSvjPkNIosdNgM5cFMeqDmZPRS47k3iLErg/s+plOhSU8A1UUrwcmH4CB7T30=
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
Cc: Eric Yang <Eric.Yang2@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Tony Cheng <Tony.Cheng@amd.com>, rodrigo.siqueira@amd.com,
 harry.wentland@amd.com, bhawanpreet.lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogRXJpYyBZYW5nIDxFcmljLllhbmcyQGFtZC5jb20+CgpbV2h5XQpERiB0ZWFtIGhhcyBw
cm9kdWNlZCBtb3JlIG9wdGltaXplZCBsYXRlbmN5IG51bWJlcnMuCgpbSG93XQpBZGQgc3IgbGF0
ZW5jaWVzIHRvIHRoZSB3bSB0YWJsZSwgdXNlIGRpZmZlcmVudCBsYXRlbmNpZXMKZm9yIGRpZmZl
cmVudCB3bSBzZXRzLgpBbHNvIGZpeCBiYiBvdmVycmlkZSBmcm9tIHJlZ2lzdGVyeSBrZXkgZm9y
IHRoZXNlIGxhdGVuY2llcy4KClNpZ25lZC1vZmYtYnk6IEVyaWMgWWFuZyA8RXJpYy5ZYW5nMkBh
bWQuY29tPgpSZXZpZXdlZC1ieTogVG9ueSBDaGVuZyA8VG9ueS5DaGVuZ0BhbWQuY29tPgpBY2tl
ZC1ieTogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+Ci0tLQogLi4uL2FtZC9kaXNwbGF5L2Rj
L2Nsa19tZ3IvZGNuMjEvcm5fY2xrX21nci5jICAgIHwgMTYgKysrKysrKysrKysrLS0tLQogLi4u
L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMS9kY24yMV9yZXNvdXJjZS5jICAgIHwgMTUgKysrKysr
KysrKysrLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvaW5jL2h3L2Nsa19tZ3Iu
aCAgfCAgMiArKwogMyBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jbGtfbWdy
L2RjbjIxL3JuX2Nsa19tZ3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jbGtf
bWdyL2RjbjIxL3JuX2Nsa19tZ3IuYwppbmRleCA3OTBhMmQyMTFiZDYuLjg0MTA5NWQwOWQzYyAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Nsa19tZ3IvZGNuMjEv
cm5fY2xrX21nci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jbGtfbWdy
L2RjbjIxL3JuX2Nsa19tZ3IuYwpAQCAtNTIzLDI1ICs1MjMsMzMgQEAgc3RydWN0IGNsa19id19w
YXJhbXMgcm5fYndfcGFyYW1zID0gewogCQkJewogCQkJCS53bV9pbnN0ID0gV01fQSwKIAkJCQku
d21fdHlwZSA9IFdNX1RZUEVfUFNUQVRFX0NIRywKLQkJCQkucHN0YXRlX2xhdGVuY3lfdXMgPSAy
My44NCwKKwkJCQkucHN0YXRlX2xhdGVuY3lfdXMgPSAxMS43MiwKKwkJCQkuc3JfZXhpdF90aW1l
X3VzID0gNi4wOSwKKwkJCQkuc3JfZW50ZXJfcGx1c19leGl0X3RpbWVfdXMgPSA3LjE0LAogCQkJ
CS52YWxpZCA9IHRydWUsCiAJCQl9LAogCQkJewogCQkJCS53bV9pbnN0ID0gV01fQiwKIAkJCQku
d21fdHlwZSA9IFdNX1RZUEVfUFNUQVRFX0NIRywKLQkJCQkucHN0YXRlX2xhdGVuY3lfdXMgPSAy
My44NCwKKwkJCQkucHN0YXRlX2xhdGVuY3lfdXMgPSAxMS43MiwKKwkJCQkuc3JfZXhpdF90aW1l
X3VzID0gMTAuMTIsCisJCQkJLnNyX2VudGVyX3BsdXNfZXhpdF90aW1lX3VzID0gMTEuNDgsCiAJ
CQkJLnZhbGlkID0gdHJ1ZSwKIAkJCX0sCiAJCQl7CiAJCQkJLndtX2luc3QgPSBXTV9DLAogCQkJ
CS53bV90eXBlID0gV01fVFlQRV9QU1RBVEVfQ0hHLAotCQkJCS5wc3RhdGVfbGF0ZW5jeV91cyA9
IDIzLjg0LAorCQkJCS5wc3RhdGVfbGF0ZW5jeV91cyA9IDExLjcyLAorCQkJCS5zcl9leGl0X3Rp
bWVfdXMgPSAxMC4xMiwKKwkJCQkuc3JfZW50ZXJfcGx1c19leGl0X3RpbWVfdXMgPSAxMS40OCwK
IAkJCQkudmFsaWQgPSB0cnVlLAogCQkJfSwKIAkJCXsKIAkJCQkud21faW5zdCA9IFdNX0QsCiAJ
CQkJLndtX3R5cGUgPSBXTV9UWVBFX1BTVEFURV9DSEcsCi0JCQkJLnBzdGF0ZV9sYXRlbmN5X3Vz
ID0gMjMuODQsCisJCQkJLnBzdGF0ZV9sYXRlbmN5X3VzID0gMTEuNzIsCisJCQkJLnNyX2V4aXRf
dGltZV91cyA9IDEwLjEyLAorCQkJCS5zcl9lbnRlcl9wbHVzX2V4aXRfdGltZV91cyA9IDExLjQ4
LAogCQkJCS52YWxpZCA9IHRydWUsCiAJCQl9LAogCQl9LApkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX3Jlc291cmNlLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfcmVzb3VyY2UuYwppbmRleCBkZDNiYzM3
ZDRlYjkuLjgxOGM3YTYyOTQ4NCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2RjbjIxL2RjbjIxX3Jlc291cmNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2RjbjIxL2RjbjIxX3Jlc291cmNlLmMKQEAgLTk3Miw2ICs5NzIsOCBAQCBzdGF0
aWMgdm9pZCBjYWxjdWxhdGVfd21fc2V0X2Zvcl92bGV2ZWwoCiAJcGlwZXNbMF0uY2xrc19jZmcu
c29jY2xrX21oeiA9IGRtbC0+c29jLmNsb2NrX2xpbWl0c1t2bGV2ZWxdLnNvY2Nsa19taHo7CiAK
IAlkbWwtPnNvYy5kcmFtX2Nsb2NrX2NoYW5nZV9sYXRlbmN5X3VzID0gdGFibGVfZW50cnktPnBz
dGF0ZV9sYXRlbmN5X3VzOworCWRtbC0+c29jLnNyX2V4aXRfdGltZV91cyA9IHRhYmxlX2VudHJ5
LT5zcl9leGl0X3RpbWVfdXM7CisJZG1sLT5zb2Muc3JfZW50ZXJfcGx1c19leGl0X3RpbWVfdXMg
PSB0YWJsZV9lbnRyeS0+c3JfZW50ZXJfcGx1c19leGl0X3RpbWVfdXM7CiAKIAl3bV9zZXQtPnVy
Z2VudF9ucyA9IGdldF93bV91cmdlbnQoZG1sLCBwaXBlcywgcGlwZV9jbnQpICogMTAwMDsKIAl3
bV9zZXQtPmNzdGF0ZV9wc3RhdGUuY3N0YXRlX2VudGVyX3BsdXNfZXhpdF9ucyA9IGdldF93bV9z
dHV0dGVyX2VudGVyX2V4aXQoZG1sLCBwaXBlcywgcGlwZV9jbnQpICogMTAwMDsKQEAgLTk4Nywx
NCArOTg5LDIxIEBAIHN0YXRpYyB2b2lkIGNhbGN1bGF0ZV93bV9zZXRfZm9yX3ZsZXZlbCgKIAog
c3RhdGljIHZvaWQgcGF0Y2hfYm91bmRpbmdfYm94KHN0cnVjdCBkYyAqZGMsIHN0cnVjdCBfdmNz
X2RwaV9zb2NfYm91bmRpbmdfYm94X3N0ICpiYikKIHsKKwlpbnQgaTsKKwogCWtlcm5lbF9mcHVf
YmVnaW4oKTsKIAlpZiAoZGMtPmJiX292ZXJyaWRlcy5zcl9leGl0X3RpbWVfbnMpIHsKLQkJYmIt
PnNyX2V4aXRfdGltZV91cyA9IGRjLT5iYl9vdmVycmlkZXMuc3JfZXhpdF90aW1lX25zIC8gMTAw
MC4wOworCQlmb3IgKGkgPSAwOyBpIDwgV01fU0VUX0NPVU5UOyBpKyspIHsKKwkJCSAgZGMtPmNs
a19tZ3ItPmJ3X3BhcmFtcy0+d21fdGFibGUuZW50cmllc1tpXS5zcl9leGl0X3RpbWVfdXMgPQor
CQkJCQkgIGRjLT5iYl9vdmVycmlkZXMuc3JfZXhpdF90aW1lX25zIC8gMTAwMC4wOworCQl9CiAJ
fQogCiAJaWYgKGRjLT5iYl9vdmVycmlkZXMuc3JfZW50ZXJfcGx1c19leGl0X3RpbWVfbnMpIHsK
LQkJYmItPnNyX2VudGVyX3BsdXNfZXhpdF90aW1lX3VzID0KLQkJCQlkYy0+YmJfb3ZlcnJpZGVz
LnNyX2VudGVyX3BsdXNfZXhpdF90aW1lX25zIC8gMTAwMC4wOworCQlmb3IgKGkgPSAwOyBpIDwg
V01fU0VUX0NPVU5UOyBpKyspIHsKKwkJCSAgZGMtPmNsa19tZ3ItPmJ3X3BhcmFtcy0+d21fdGFi
bGUuZW50cmllc1tpXS5zcl9lbnRlcl9wbHVzX2V4aXRfdGltZV91cyA9CisJCQkJCSAgZGMtPmJi
X292ZXJyaWRlcy5zcl9lbnRlcl9wbHVzX2V4aXRfdGltZV9ucyAvIDEwMDAuMDsKKwkJfQogCX0K
IAogCWlmIChkYy0+YmJfb3ZlcnJpZGVzLnVyZ2VudF9sYXRlbmN5X25zKSB7CmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvaW5jL2h3L2Nsa19tZ3IuaCBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9pbmMvaHcvY2xrX21nci5oCmluZGV4IGY1NTIwM2U0
MjdkZS4uNGFhMDlmZTk1NGM1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvaW5jL2h3L2Nsa19tZ3IuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvaW5jL2h3L2Nsa19tZ3IuaApAQCAtNjYsNiArNjYsOCBAQCBzdHJ1Y3Qgd21fcmFuZ2VfdGFi
bGVfZW50cnkgewogCXVuc2lnbmVkIGludCB3bV9pbnN0OwogCXVuc2lnbmVkIGludCB3bV90eXBl
OwogCWRvdWJsZSBwc3RhdGVfbGF0ZW5jeV91czsKKwlkb3VibGUgc3JfZXhpdF90aW1lX3VzOwor
CWRvdWJsZSBzcl9lbnRlcl9wbHVzX2V4aXRfdGltZV91czsKIAlib29sIHZhbGlkOwogfTsKIAot
LSAKMi4yNC4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
