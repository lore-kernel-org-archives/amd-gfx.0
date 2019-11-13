Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAE9C432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 22:10:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B4F8206E3
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 22:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4F8206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 275766E0DC;
	Wed, 13 Nov 2019 22:10:01 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690074.outbound.protection.outlook.com [40.107.69.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 770506E0DC
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 22:09:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxsvjMg4EskZhr92z7WCbx5rqwLAuohgyKeW/QieX34otctKYOVvfdFa0NvxE0Qh+jlj+AxRt9mBXQqltFSP3Qx61O72ppl+V02NkTQ7rN6SWBQZd5oh200utOK6+kNY7uXm7scKapfbJ2CFje1+Mm2OCrb3lqmKIfo8T1xIpg5ZubGu+h2iL0ilzYfiT37T0vwZRQTdRYpvgSYeOS+EGhgmJD3gsLCFDYVoSrI9R34lyR9QF/sIFs1LVD9/HcHvqVq7qhAmMGY5gFmGgATUFxmGuCr2Z/KRHkSH6M8aUMtBgQ2dvjYnnRpW6nLHncCEhGYV2KhTlTYBGHYCmyoN+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCoYxCshaexhseroM0pUpTZWs6JP22UTmWWmrPeGXB4=;
 b=ncV0931MRVtNkEOB4VYxWVh3mr15fgtmBhlGOF2NnJ/DCBsbscr2MXlA14YKWOUZnDPr4xVHgfr6ZXzljMRH5mQO6FQVjqnxpFf0PlwFAIOLi/cc8uH0q++kRFObfZQs+qXaZ/f5fRmjbTSVzZOX5wkyxC2dnC8S3Gccfm92ZZ62k1cu6juoZzPpYI+kBGag8zVj0hKoA6HS5In9L+U14Bf5kdYiUvPcGHSTVdwbyMJ0s/EkTvYo6rCTCWgtzg915aVCWSYWLG+mutNi1kiHmzz6zMbSa0zOp3Xx/76Vm8FWP2MLPg8dFPNJM/ubzujUr4ehrnouRYmb1L8RnX8lfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB3689.namprd12.prod.outlook.com (10.255.76.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 13 Nov 2019 22:09:57 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e%6]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 22:09:57 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Rename kfd_kernel_queue_*.c to
 kfd_packet_manager_*.c
Date: Wed, 13 Nov 2019 17:09:46 -0500
Message-Id: <20191113220946.32529-1-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To DM6PR12MB2778.namprd12.prod.outlook.com
 (2603:10b6:5:50::17)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 09d1ec64-4c81-4b0a-6e1b-08d768863853
X-MS-TrafficTypeDiagnostic: DM6PR12MB3689:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3689E2C8320883354A725311F0760@DM6PR12MB3689.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 0220D4B98D
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(199004)(189003)(3846002)(6116002)(66066001)(16586007)(66476007)(386003)(50466002)(316002)(36756003)(6506007)(86362001)(66556008)(4326008)(186003)(6512007)(6666004)(52116002)(48376002)(2906002)(26005)(47776003)(99286004)(51416003)(66946007)(25786009)(478600001)(6436002)(305945005)(50226002)(2351001)(8936002)(2616005)(2361001)(6486002)(7736002)(6916009)(476003)(81156014)(81166006)(486006)(8676002)(14454004)(5660300002)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3689;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EOIv5guC3e1jkVJ7hIWA7TmhLNEVltS9QOSO/QNbkIxAa2Bf15inXkhKEUWseP3qCuJnRCR+oRdCnxuZvXfAC99WlimpZWW7LcIMY6SoYZe2eVijkeVC8j6Xu2G4Be3z6/bxecuzQdhD+tzW/Yqmvyqng2vua9bF5rbFm4olWFUsyiei9PxeKXVkkskOi12zlS8zoD5RL3iq5MTGweDPHTjAE924jAMlsFPWyPtf02ECcmf7CYCLPrLmlpp6uYz4BhODvwFL9UAszKcdg2DgmFnnwBkbyOcpAWK1Acql4e55CUNsExs11i4gi18disMUA8nIgzXrDVXe/wAmzD/dq82S8FKSoxpKK+bEzBo8CQpo7RyVeAhc+iLT5d6Mp0a4A1pyGu+xn0zEZsK2rcHYlEKRCF6HwIwLCtjYI63IvuGhcYa2doZ8Yf5oyHlNHHQ+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d1ec64-4c81-4b0a-6e1b-08d768863853
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2019 22:09:57.8461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+KxCqKBPh6LekUrz9hpCiN5NAag42cSnpZLMPkF1D8eWaOe8tMVwdajU6JDJt8Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3689
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCoYxCshaexhseroM0pUpTZWs6JP22UTmWWmrPeGXB4=;
 b=3MHNfvQdzue/lesdqvQSb/8OhoR6+QNtKgqe4U2Z+V5d1rfQ/1AXfBshDqzCUdBaXRzrZU4Pvw9Fl/hQoVDYte/OJEHP0Hi+RiTQEqp8NlMIuRMAQBE4Hs7KUXKCcB+7+oOTt40U9vIbKvonCqqqjtKGcrUkQu3eTGZwZ+VWQOM=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
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
Cc: Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191113220946.AfsZgRHhV5z5Mggt-5-nce1xlAKAcC_BZAj5RRwoXmA@z>

QWZ0ZXIgdGhlIHJlY2VudCBjbGVhbnVwLCB0aGUgZnVuY3Rpb25hbGl0aWVzIHByb3ZpZGVkIGJ5
IHRoZSBwcmV2aW91cwprZmRfa2VybmVsX3F1ZXVlXyouYyBhcmUgYWN0dWFsbHkgYWxsIHBhY2tl
dCBtYW5hZ2VyIHJlbGF0ZWQuIFNvIHJlbmFtZQp0aGVtIHRvIHJlZmxlY3QgdGhhdC4KCkNoYW5n
ZS1JZDogSTY1NDRjY2IzOGRhODI3Yzc0NzU0NGMwNzg3YWE5NDlkZjIwZWRiYjAKU2lnbmVkLW9m
Zi1ieTogWW9uZyBaaGFvIDxZb25nLlpoYW9AYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgNCArKy0tCiAu
Li4vYW1ka2ZkL3trZmRfa2VybmVsX3F1ZXVlX3Y5LmMgPT4ga2ZkX3BhY2tldF9tYW5hZ2VyX2Fp
LmN9IHwgMAogLi4uL2FtZGtmZC97a2ZkX2tlcm5lbF9xdWV1ZV92aS5jID0+IGtmZF9wYWNrZXRf
bWFuYWdlcl92aS5jfSB8IDAKIDMgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQogcmVuYW1lIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL3trZmRfa2VybmVs
X3F1ZXVlX3Y5LmMgPT4ga2ZkX3BhY2tldF9tYW5hZ2VyX2FpLmN9ICgxMDAlKQogcmVuYW1lIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL3trZmRfa2VybmVsX3F1ZXVlX3ZpLmMgPT4ga2ZkX3Bh
Y2tldF9tYW5hZ2VyX3ZpLmN9ICgxMDAlKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL01ha2VmaWxlIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQvTWFrZWZpbGUK
aW5kZXggZjkzYTE2MzcyMzI1Li41NWJmZWNmMDQyMzkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL01ha2VmaWxlCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L01ha2VmaWxlCkBAIC0zOCw5ICszOCw5IEBAIEFNREtGRF9GSUxFUwk6PSAkKEFNREtGRF9QQVRI
KS9rZmRfbW9kdWxlLm8gXAogCQkkKEFNREtGRF9QQVRIKS9rZmRfbXFkX21hbmFnZXJfdjkubyBc
CiAJCSQoQU1ES0ZEX1BBVEgpL2tmZF9tcWRfbWFuYWdlcl92MTAubyBcCiAJCSQoQU1ES0ZEX1BB
VEgpL2tmZF9rZXJuZWxfcXVldWUubyBcCi0JCSQoQU1ES0ZEX1BBVEgpL2tmZF9rZXJuZWxfcXVl
dWVfdmkubyBcCi0JCSQoQU1ES0ZEX1BBVEgpL2tmZF9rZXJuZWxfcXVldWVfdjkubyBcCiAJCSQo
QU1ES0ZEX1BBVEgpL2tmZF9wYWNrZXRfbWFuYWdlci5vIFwKKwkJJChBTURLRkRfUEFUSCkva2Zk
X3BhY2tldF9tYW5hZ2VyX3ZpLm8gXAorCQkkKEFNREtGRF9QQVRIKS9rZmRfcGFja2V0X21hbmFn
ZXJfYWkubyBcCiAJCSQoQU1ES0ZEX1BBVEgpL2tmZF9wcm9jZXNzX3F1ZXVlX21hbmFnZXIubyBc
CiAJCSQoQU1ES0ZEX1BBVEgpL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5vIFwKIAkJJChBTURL
RkRfUEFUSCkva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyX2Npay5vIFwKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9rZXJuZWxfcXVldWVfdjkuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wYWNrZXRfbWFuYWdlcl9haS5jCnNpbWlsYXJpdHkgaW5k
ZXggMTAwJQpyZW5hbWUgZnJvbSBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfa2VybmVs
X3F1ZXVlX3Y5LmMKcmVuYW1lIHRvIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wYWNr
ZXRfbWFuYWdlcl9haS5jCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfa2VybmVsX3F1ZXVlX3ZpLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcGFj
a2V0X21hbmFnZXJfdmkuYwpzaW1pbGFyaXR5IGluZGV4IDEwMCUKcmVuYW1lIGZyb20gZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2tlcm5lbF9xdWV1ZV92aS5jCnJlbmFtZSB0byBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcGFja2V0X21hbmFnZXJfdmkuYwotLSAKMi4xNy4x
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
