Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145AAC432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E731F20848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E731F20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 964756E2B6;
	Mon,  2 Dec 2019 17:35:15 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700052.outbound.protection.outlook.com [40.107.70.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B57076E2C7
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cImSExqGi99J4zQeBmfrembe6ZfJplM0F2F9Kei1DGv0oTQ00TOvEeJVmAPqpOq7TEA/v19Ox9hZIdqWISWesWxiSE3jOSqJBNVmza2Tx3ye0UggIKAwuxduKcU4i3PWphxGmIs7wEKKnRRAYe9VEL3VhNUpwgQAg+kUasT+wTBjK3M12EAkIelSV+WP4piqfWZKpGwWciCyVL65WjMTwrJ1XHSrR+MNEETJKbEaCQx6M1dATqDaL4HJAuDyo7AcSoambYzZIutswVoGhoUHtujVyuxCxhdADJ4YmkMBOYOdcJg7no/BYtBTnt6qh/Gxcyc3sSNFG+1KoujUc0WLQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZg1Su/6xS6aHiBEIU3CGIQ7T0ukKQQcOyVouZhKMDU=;
 b=idJxVdM9x9IDhH9UtQ7pv+G9ZU+1qWXxWEjqFw46f0++ZEf2G/z5GetZF0/EA8tr8/TfU28aw8HSDhjxQwvbmeEtpnFQ7Ilsez70pExlqtVc2UL8M5p1QtSKNYkZMPXaQa+RomefEoT8LZtdlkoQPZVuemBz5I9okUVrqvsZfeavzCKMVd8K81sLqGETtkiPnv69u/+ZYqXRoLQSyw+8dhUUBAUNK7ApC9xSTz89CqlLEZt+JDvMVwuGKcXlaMQxgAm1OZkmBMueE0LodAK8LdY7rTvbCE0/ulIrPqS79YTZCSZMz7pFoLZ01Ov2zbzO5qtGE/EQ2LaIqEFqh0WzYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2610.namprd12.prod.outlook.com (20.176.26.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:35:13 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:35:13 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 28/51] drm/amd/display: Save/restore link setting for disable
 phy when link retraining
Date: Mon,  2 Dec 2019 12:33:42 -0500
Message-Id: <20191202173405.31582-29-sunpeng.li@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 45265dfc-ca76-465e-9886-08d7774dfcba
X-MS-TrafficTypeDiagnostic: BN7PR12MB2610:|BN7PR12MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2610556D691FE6C78EA87B5C82430@BN7PR12MB2610.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(189003)(199004)(76176011)(6666004)(51416003)(52116002)(6512007)(66476007)(66556008)(316002)(50226002)(5660300002)(6916009)(81166006)(26005)(2616005)(99286004)(386003)(6506007)(1076003)(8936002)(11346002)(305945005)(446003)(81156014)(186003)(9686003)(6436002)(4326008)(8676002)(6486002)(7736002)(66946007)(54906003)(48376002)(50466002)(86362001)(6116002)(2351001)(3846002)(2906002)(25786009)(36756003)(66066001)(2870700001)(2361001)(14454004)(478600001)(47776003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2610;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K1/ykjUhcympZPnN69As0tOr5WgMY6nJGpJ7OJG6mv4q2j4nr4MdglAfMJch7PFhLGIh3ZoN20m3IEn7cldai87aWDbIeubsCxsjwGbMVu6JQEafs+H3ZevwbGMfA4BeC+i+fr8mWodS+a8AjMb76CS2Fj1rBoYdWheJEQHoUWeSViKqd3U/2t9nPGIe+gmVbozgKbhgiFXkLU/c210XDVL5zidfRMhD1OqjMPcTwwpqZ91r7B4MPWSLFd8XMUw5aOPy3DZ7myxeHdMe2P9gFVy1evU7XXsFEMWsFcgPlVis0L0mHPFfBIhrrX+FUUuXjr+QxKmrvcX2x6LAU42srz27WIFzXCE9lDIHboHk6P8xcOAEa9tECeUvowlpHMrBwC5qzEkWPx2iSWiOd4BQrPlKe+zx6lLGMdmK/vZez7wEsQfqyBhefc4rDy0E69wc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45265dfc-ca76-465e-9886-08d7774dfcba
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:35:13.5047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fgk9K4lZhXVs9im1HEt9u6xP3YUuDV/0DGTienwgMNv7Y3IZxUvsI6Cgp+SbaYT/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2610
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZg1Su/6xS6aHiBEIU3CGIQ7T0ukKQQcOyVouZhKMDU=;
 b=1aRYF55JR1X0a37GyyxInounh4aH7KkvWJvxnO7LbNpWeikE8nJVDslrIXyArmSGRUMu+mzmNDFd/A6W6qtXJq+SsawoYu5aI9c6PQHinkqKojmlLx1Q88CzYeeiNbvwki8wKHfJ2FvuG1wyrPovB/PnE5+Y/xV5kQ2g9XpaV24=
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
Cc: Leo Li <sunpeng.li@amd.com>, harry.wentland@amd.com,
 Hugo Hu <hugo.hu@amd.com>, rodrigo.siqueira@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, bhawanpreet.lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogSHVnbyBIdSA8aHVnby5odUBhbWQuY29tPgoKW1doeV0KVGhlIGxpbmsgc2V0dGluZyB3
aWxsIGJlIG1vZGlmeSBhZnRlciBkaXNhYmxlIHBoeQphbmQgZHVlIHRvIERQIENvbXBsaWFuY2Ug
RmFpbHMuCgpbSG93XQpTYXZlIGFuZCByZXNvdHJlIGxpbmsgc2V0dGluZyBmb3IgZGlzYWJsZSBs
aW5rIHBoeSB3aGVuIGxpbmsgcmV0cmFpbmluZy4KClNpZ25lZC1vZmYtYnk6IEh1Z28gSHUgPGh1
Z28uaHVAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IFdlbmppbmcgTGl1IDxXZW5qaW5nLkxpdUBhbWQu
Y29tPgpBY2tlZC1ieTogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kcC5jIHwgNSArKystLQogMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rX2RwLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rX2RwLmMKaW5kZXggNDg2YzE0ZTBj
ZDQxLi4wMTVmYTBjNTI3NDYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9jb3JlL2RjX2xpbmtfZHAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvY29yZS9kY19saW5rX2RwLmMKQEAgLTI3ODgsOSArMjc4OCw5IEBAIGJvb2wgZGNfbGlua19o
YW5kbGVfaHBkX3J4X2lycShzdHJ1Y3QgZGNfbGluayAqbGluaywgdW5pb24gaHBkX2lycV9kYXRh
ICpvdXRfaHBkCiAJdW5pb24gaHBkX2lycV9kYXRhIGhwZF9pcnFfZHBjZF9kYXRhID0geyB7IHsg
ezB9IH0gfSB9OwogCXVuaW9uIGRldmljZV9zZXJ2aWNlX2lycSBkZXZpY2Vfc2VydmljZV9jbGVh
ciA9IHsgeyAwIH0gfTsKIAllbnVtIGRjX3N0YXR1cyByZXN1bHQ7Ci0KIAlib29sIHN0YXR1cyA9
IGZhbHNlOwogCXN0cnVjdCBwaXBlX2N0eCAqcGlwZV9jdHg7CisJc3RydWN0IGRjX2xpbmtfc2V0
dGluZ3MgcHJldmlvdXNfbGlua19zZXR0aW5nczsKIAlpbnQgaTsKIAogCWlmIChvdXRfbGlua19s
b3NzKQpAQCAtMjg3Myw5ICsyODczLDEwIEBAIGJvb2wgZGNfbGlua19oYW5kbGVfaHBkX3J4X2ly
cShzdHJ1Y3QgZGNfbGluayAqbGluaywgdW5pb24gaHBkX2lycV9kYXRhICpvdXRfaHBkCiAJCWlm
IChwaXBlX2N0eCA9PSBOVUxMIHx8IHBpcGVfY3R4LT5zdHJlYW0gPT0gTlVMTCkKIAkJCXJldHVy
biBmYWxzZTsKIAorCQlwcmV2aW91c19saW5rX3NldHRpbmdzID0gbGluay0+Y3VyX2xpbmtfc2V0
dGluZ3M7CiAJCWRwX2Rpc2FibGVfbGlua19waHkobGluaywgcGlwZV9jdHgtPnN0cmVhbS0+c2ln
bmFsKTsKIAotCQlwZXJmb3JtX2xpbmtfdHJhaW5pbmdfd2l0aF9yZXRyaWVzKCZsaW5rLT5jdXJf
bGlua19zZXR0aW5ncywKKwkJcGVyZm9ybV9saW5rX3RyYWluaW5nX3dpdGhfcmV0cmllcygmcHJl
dmlvdXNfbGlua19zZXR0aW5ncywKIAkJCXRydWUsIExJTktfVFJBSU5JTkdfQVRURU1QVFMsCiAJ
CQlwaXBlX2N0eCwKIAkJCXBpcGVfY3R4LT5zdHJlYW0tPnNpZ25hbCk7Ci0tIAoyLjI0LjAKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
