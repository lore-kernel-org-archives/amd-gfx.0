Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB6DC432C3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77D0F20848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D0F20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B96516E2E4;
	Mon,  2 Dec 2019 17:35:57 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680058.outbound.protection.outlook.com [40.107.68.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F73E6E2DA
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYinmwlSTrUdt61kEv7892NvxAO88vUl2trz06CTav/6eSAtW1Tq37JMk80gz9cs2GR34dgCANYkgodLT9yeE4OqIlWdeZCYYc7unyRc9rxm2gxVXG6zyUinpvaa3G1N2X6PMmEm6VGlMwPy9c719NBT88IrtKgoNSMcyyG47joy60jAR4xZhGogj4lMb3GX9zuFf+PkLR+myqJ0KweKeUIAe8+s+5ATk+EteGJHecx+CoSrMU9MWafDFf9fylECqkdo1d0wX0wubIhJAmR81+znJB4cbTph5CtFHDIRUYAh14xUQ7MQUDVvvrly+qpo6KZ4oRMRIjJCYMd45yNVhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIa5+fb7aDK4u9AEZPKIDD0Gvhb5ev/hxZObQLmIn8w=;
 b=f//oDtAzgyQa64fvTUX5QXcwl62n2mhUwOgD9DKCOZ4aDNpNWx+w5hn2NenBEcNlgWVtX/40Vn9qRTY/EY80sHjAzdjh8xYgy3XbFAZWLMGPVE8CWJ2gYZ8lQc32juDQ5dD4QZZT87CSoCct6aC9Lj3h24IzBhTP+zQ2huzxIUNQslN7t4DqRfS6Vt72id+lSW76L7uV015rvMsHUfIP9efPtEDhZD7VuRUrf6OzsZwoKJFUxUKFRWvwDD1wfzGRztbqOiG3WKTZiyRypPDadX5Mrdum5udlDsnUwl1R78kJ0BE+nGjuHqnE0EmJ38ocl5p7OceTPPoq7xKKUmQ1JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2610.namprd12.prod.outlook.com (20.176.26.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:35:54 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:35:54 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 44/51] drm/amd/display: Implement DePQ for DCN2
Date: Mon,  2 Dec 2019 12:33:58 -0500
Message-Id: <20191202173405.31582-45-sunpeng.li@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: b23be125-983c-4634-b2c7-08d7774e04dc
X-MS-TrafficTypeDiagnostic: BN7PR12MB2610:|BN7PR12MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2610C7917135FDB25CA8647B82430@BN7PR12MB2610.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(189003)(199004)(76176011)(51416003)(52116002)(6512007)(66476007)(66556008)(316002)(50226002)(5660300002)(6916009)(81166006)(26005)(2616005)(99286004)(386003)(6506007)(1076003)(8936002)(11346002)(305945005)(446003)(81156014)(186003)(9686003)(6436002)(4326008)(8676002)(6486002)(7736002)(66946007)(54906003)(14444005)(48376002)(50466002)(86362001)(6116002)(2351001)(3846002)(2906002)(25786009)(36756003)(66066001)(2870700001)(2361001)(14454004)(478600001)(47776003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2610;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q7tk52V2fxrGkogagZ2NvSuwGcBwO/yfLXXDPyfiDdEON2q1TfQ5Xei13dbcOfvHRYGm5k3kAXUaIswsTiHvsauVWsUwIF5uQ/rbL5sCy4Fxj1qLHXleADP1tKd6caWGvAeGoPA+ttp2JEY8mMCXDHWijX2dJf+XHXMnZCbhBnmkBCe/z8UZ0f4XdV91hOfLUc8tqYXcTLRbPBLpCJjAyGQOd/+Rdw5K1l4Hx7fQTJS9yjt8f9Rp+KNlImEcJs7aTzPPYpNZeFfSMyChKT3AH7HdWKrfeSNjgm/fSv1MPutyzS1h/QcyLIu964VJq97tlPNgLmgHBNBY5cEQtJT71GwasSMy4qlS+mfEAQ2g6QqVyllEaIA9LcL2lVRSQPvK1yAaUql7gKa4ihAUhW2dJgQbrwA8PHduBMHxw0oKETsPyklfjedmEhC65lnsC5Ch
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23be125-983c-4634-b2c7-08d7774e04dc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:35:27.2139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XuTk7qA7n7+7mEVkBALDGE+f6VBMSee+3I1fkTIq3OVIPtfhXSR89F1N6BZu2Szb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2610
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIa5+fb7aDK4u9AEZPKIDD0Gvhb5ev/hxZObQLmIn8w=;
 b=UWQ/tPmLy2P5Vexe7tBhifD3KAwCe6e+XHFXG1azhx5qPimTCh1jVmk/HSt6r7hMp/MynAZN3/Cqqs9x8Pukb3zEgGSYCDbKTZw+Wi+Lw19eZ6E4KUwE6MC0IrkPbJbsT/bKtwTo4jQN/HPmiW/JAF5fUiptRmyI1MZg2UMQQbs=
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
Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>, Leo Li <sunpeng.li@amd.com>,
 harry.wentland@amd.com, rodrigo.siqueira@amd.com,
 Reza Amini <Reza.Amini@amd.com>, bhawanpreet.lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogUmV6YSBBbWluaSA8UmV6YS5BbWluaUBhbWQuY29tPgoKW1doeV0KTmVlZCBzdXBwb3J0
IGZvciBtb3JlIGNvbG9yIG1hbmFnZW1lbnQgaW4gMTBiaXQKc3VyZmFjZS4KCltIb3ddClByb3Zp
ZGUgc3VwcG9ydCBmb3IgRGVQUSBmb3IgMTBiaXQgc3VyZmFjZQoKU2lnbmVkLW9mZi1ieTogUmV6
YSBBbWluaSA8UmV6YS5BbWluaUBhbWQuY29tPgpSZXZpZXdlZC1ieTogS3J1bm9zbGF2IEtvdmFj
IDxLcnVub3NsYXYuS292YWNAYW1kLmNvbT4KQWNrZWQtYnk6IExlbyBMaSA8c3VucGVuZy5saUBh
bWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9k
cHBfY20uYyB8IDMgKysrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNu
MjBfaHdzZXEuYyAgfCA1ICsrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9k
cHBfY20uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9kcHBf
Y20uYwppbmRleCAyZDExMmMzMTY0MjQuLjA1YTNlN2Y5N2VmMCAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX2RwcF9jbS5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9kcHBfY20uYwpAQCAtMTQ5LDYg
KzE0OSw5IEBAIHZvaWQgZHBwMl9zZXRfZGVnYW1tYSgKIAljYXNlIElQUF9ERUdBTU1BX01PREVf
SFdfeHZZQ0M6CiAJCVJFR19VUERBVEUoQ01fREdBTV9DT05UUk9MLCBDTV9ER0FNX0xVVF9NT0RF
LCAyKTsKIAkJCWJyZWFrOworCWNhc2UgSVBQX0RFR0FNTUFfTU9ERV9VU0VSX1BXTDoKKwkJUkVH
X1VQREFURShDTV9ER0FNX0NPTlRST0wsIENNX0RHQU1fTFVUX01PREUsIDMpOworCQlicmVhazsK
IAlkZWZhdWx0OgogCQlCUkVBS19UT19ERUJVR0dFUigpOwogCQlicmVhazsKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9od3NlcS5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX2h3c2VxLmMKaW5kZXggMmQw
OTNmZjBhNzZjLi5lYzk4MzhkNmUwZWUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kY24yMC9kY24yMF9od3NlcS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kY24yMC9kY24yMF9od3NlcS5jCkBAIC04NzgsNiArODc4LDExIEBAIGJvb2wg
ZGNuMjBfc2V0X2lucHV0X3RyYW5zZmVyX2Z1bmMoc3RydWN0IGRjICpkYywKIAkJCQkJSVBQX0RF
R0FNTUFfTU9ERV9CWVBBU1MpOwogCQkJYnJlYWs7CiAJCWNhc2UgVFJBTlNGRVJfRlVOQ1RJT05f
UFE6CisJCQlkcHBfYmFzZS0+ZnVuY3MtPmRwcF9zZXRfZGVnYW1tYShkcHBfYmFzZSwgSVBQX0RF
R0FNTUFfTU9ERV9VU0VSX1BXTCk7CisJCQljbV9oZWxwZXJfdHJhbnNsYXRlX2N1cnZlX3RvX2Rl
Z2FtbWFfaHdfZm9ybWF0KHRmLCAmZHBwX2Jhc2UtPmRlZ2FtbWFfcGFyYW1zKTsKKwkJCWRwcF9i
YXNlLT5mdW5jcy0+ZHBwX3Byb2dyYW1fZGVnYW1tYV9wd2woZHBwX2Jhc2UsICZkcHBfYmFzZS0+
ZGVnYW1tYV9wYXJhbXMpOworCQkJcmVzdWx0ID0gdHJ1ZTsKKwkJCWJyZWFrOwogCQlkZWZhdWx0
OgogCQkJcmVzdWx0ID0gZmFsc2U7CiAJCQlicmVhazsKLS0gCjIuMjQuMAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
