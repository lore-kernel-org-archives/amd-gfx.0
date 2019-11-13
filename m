Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EF4C432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 22:50:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D84E2063A
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 22:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D84E2063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2043A6EE8E;
	Wed, 13 Nov 2019 22:50:24 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820057.outbound.protection.outlook.com [40.107.82.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 653EC6EE8E
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 22:50:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0CpQEKpbl3S0FH3ACrw1ZGo7fNuxyef7X5tlBr4evIMDCIRkoHZFHtEuL0utnIkkK7ylU5dGyDY9Iq2cPUPOduY389sul6nIhNcltzEKDOZHtu7Y2Y0dlc2Xmu5P+PJulAhyEzDDuDsXG073JCgOlPxxaXi5s2H/NCjSzkl3SG6Chp8quOoH4/pxbS9kAmYXNATng8GzdHI/dbSZxVeQ+f2QqnqfPgvYdashRJRM+e2FMFZ8nUg7iNiTxqKRZRT3+mpc4w1HqWlpxYsMCsdSNkg1jq5xABMbih9CqeMiQvJD/rBjp4iwLvCmMclZA5xj01K0zrvn3To4EKxYlnCIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRnh28GdmFClnOtIyN2wwlDuTsHkUSGJ9f6EcQ5XfHE=;
 b=aJdBzwer/WjtS3455IoppXxQs/y4Wqdx+eEDEcXu0wCuZbkeoYdfYFa6gHbM0wOLCYm9P4BRiec4MbisiRvuZlMdDVralnUHFShJex3aGyQ6NPL4LuCvzzt22vFzuLC8XVqmxWdOwPxAdfGC5bmqT/SW8hpCbKSosHEyRM1f1sJHf3BIYu+0Qq+wROfUIFsuUpeFmiZsxd28thcbSzUT5L8DeA9ud1ti+uagM+uMUWuIVWv3hF3LLleZM7qX8ZLxsUXhOObftjic77q4YArdjrmZKb8eEDoKaA2YxA1KsQO7HmTxm+Twh7RMei8ODsC23iMDLmICkarCujqGPtD6jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB3356.namprd12.prod.outlook.com (20.178.198.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 22:50:22 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e%6]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 22:50:22 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Rename kfd_kernel_queue_*.c to
 kfd_packet_manager_*.c
Date: Wed, 13 Nov 2019 17:50:08 -0500
Message-Id: <20191113225008.31160-1-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::49) To DM6PR12MB2778.namprd12.prod.outlook.com
 (2603:10b6:5:50::17)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a0714048-dc55-4e33-ce21-08d7688bdd43
X-MS-TrafficTypeDiagnostic: DM6PR12MB3356:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3356B537BE6198F396CD6463F0760@DM6PR12MB3356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 0220D4B98D
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(66066001)(36756003)(386003)(1076003)(99286004)(6506007)(47776003)(26005)(7736002)(476003)(6916009)(486006)(2361001)(2616005)(25786009)(2906002)(3846002)(50466002)(86362001)(305945005)(4326008)(2351001)(6436002)(6116002)(66476007)(66556008)(186003)(14454004)(478600001)(16586007)(8936002)(316002)(8676002)(81166006)(48376002)(81156014)(5660300002)(66946007)(6512007)(6486002)(6666004)(50226002)(52116002)(51416003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3356;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tJodhx7bF45MnV5/2AbVP7Zmvo2sKdaNziQ6/Lhyf2Zc5MzMHYsTFD3Gzof4Zk2B05Sd3/gPbMFXMH8UzXV3Wu7FmaVwAXfNxWBUDPW5hP4h8ObXGaqBnMBALesdln+ERAzvbeOVz93GLaYkkLv0HEdPx2EsDNIa/6r9QLL1vZ8kLWGFqCLNX6lYZgmFfz74yzH+rfxfc+ILl8UfFa6xcYlXM6rQ1UVMRaYZMVEyYmcePVcJ/4vwE8d+uvEQ6AXk/6fTCGStAP5rOr+3Yva7sVdt2RRfY2rHKmVI/kFCz+vxwl4U2EqgtWhCNTCh6RQ4aYOgb0fnGXX21H7yif2zjREzsMNxdY9S3isL7sDa9zvoW+DlDQlG1uAnXpuhfLpNEXOFbbal9+DaeZ5gQMQUa/fmZeSk7bicqhrSitygkxI8hor8FbHO0G5FQG1NjxeT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0714048-dc55-4e33-ce21-08d7688bdd43
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2019 22:50:21.9794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZr5LfL06MIL8X33JVcK3Xbpf0kdBmAXHA69V8u9CIWLuFaqH2BTl0hFKsj/mQEs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3356
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRnh28GdmFClnOtIyN2wwlDuTsHkUSGJ9f6EcQ5XfHE=;
 b=goXvesQnHGzv68DuBvQsVHWtFOzXTVzHaYMOxVJgoYJNjpkcBuIisWAs6qmyeCge4B4mov0m5gwgZ6ECDb4nYbaxSxrEG0+oMpMKjiHq8FLkwGnRSN9HQ1amYXZoF8y+R48VJm1tosOXedUpUb0S2naqZDCZQJNhtmsb+7FvgSA=
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
Message-ID: <20191113225008.63t3TTPHVNZhavJqmaATSBJ6Ea_7u4zOFvb7Hz7o1Ww@z>

QWZ0ZXIgdGhlIHJlY2VudCBjbGVhbnVwLCB0aGUgZnVuY3Rpb25hbGl0aWVzIHByb3ZpZGVkIGJ5
IHRoZSBwcmV2aW91cwprZmRfa2VybmVsX3F1ZXVlXyouYyBhcmUgYWN0dWFsbHkgYWxsIHBhY2tl
dCBtYW5hZ2VyIHJlbGF0ZWQuIFNvIHJlbmFtZQp0aGVtIHRvIHJlZmxlY3QgdGhhdC4KCkNoYW5n
ZS1JZDogSTY1NDRjY2IzOGRhODI3Yzc0NzU0NGMwNzg3YWE5NDlkZjIwZWRiYjAKU2lnbmVkLW9m
Zi1ieTogWW9uZyBaaGFvIDxZb25nLlpoYW9AYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgNCArKy0tCiAu
Li4vYW1ka2ZkL3trZmRfa2VybmVsX3F1ZXVlX3Y5LmMgPT4ga2ZkX3BhY2tldF9tYW5hZ2VyX3Y5
LmN9IHwgMAogLi4uL2FtZGtmZC97a2ZkX2tlcm5lbF9xdWV1ZV92aS5jID0+IGtmZF9wYWNrZXRf
bWFuYWdlcl92aS5jfSB8IDAKIDMgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQogcmVuYW1lIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL3trZmRfa2VybmVs
X3F1ZXVlX3Y5LmMgPT4ga2ZkX3BhY2tldF9tYW5hZ2VyX3Y5LmN9ICgxMDAlKQogcmVuYW1lIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL3trZmRfa2VybmVsX3F1ZXVlX3ZpLmMgPT4ga2ZkX3Bh
Y2tldF9tYW5hZ2VyX3ZpLmN9ICgxMDAlKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL01ha2VmaWxlIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQvTWFrZWZpbGUK
aW5kZXggZjkzYTE2MzcyMzI1Li42MTQ3NDYyN2EzMmMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL01ha2VmaWxlCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L01ha2VmaWxlCkBAIC0zOCw5ICszOCw5IEBAIEFNREtGRF9GSUxFUwk6PSAkKEFNREtGRF9QQVRI
KS9rZmRfbW9kdWxlLm8gXAogCQkkKEFNREtGRF9QQVRIKS9rZmRfbXFkX21hbmFnZXJfdjkubyBc
CiAJCSQoQU1ES0ZEX1BBVEgpL2tmZF9tcWRfbWFuYWdlcl92MTAubyBcCiAJCSQoQU1ES0ZEX1BB
VEgpL2tmZF9rZXJuZWxfcXVldWUubyBcCi0JCSQoQU1ES0ZEX1BBVEgpL2tmZF9rZXJuZWxfcXVl
dWVfdmkubyBcCi0JCSQoQU1ES0ZEX1BBVEgpL2tmZF9rZXJuZWxfcXVldWVfdjkubyBcCiAJCSQo
QU1ES0ZEX1BBVEgpL2tmZF9wYWNrZXRfbWFuYWdlci5vIFwKKwkJJChBTURLRkRfUEFUSCkva2Zk
X3BhY2tldF9tYW5hZ2VyX3ZpLm8gXAorCQkkKEFNREtGRF9QQVRIKS9rZmRfcGFja2V0X21hbmFn
ZXJfdjkubyBcCiAJCSQoQU1ES0ZEX1BBVEgpL2tmZF9wcm9jZXNzX3F1ZXVlX21hbmFnZXIubyBc
CiAJCSQoQU1ES0ZEX1BBVEgpL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5vIFwKIAkJJChBTURL
RkRfUEFUSCkva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyX2Npay5vIFwKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9rZXJuZWxfcXVldWVfdjkuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wYWNrZXRfbWFuYWdlcl92OS5jCnNpbWlsYXJpdHkgaW5k
ZXggMTAwJQpyZW5hbWUgZnJvbSBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfa2VybmVs
X3F1ZXVlX3Y5LmMKcmVuYW1lIHRvIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wYWNr
ZXRfbWFuYWdlcl92OS5jCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfa2VybmVsX3F1ZXVlX3ZpLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcGFj
a2V0X21hbmFnZXJfdmkuYwpzaW1pbGFyaXR5IGluZGV4IDEwMCUKcmVuYW1lIGZyb20gZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2tlcm5lbF9xdWV1ZV92aS5jCnJlbmFtZSB0byBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcGFja2V0X21hbmFnZXJfdmkuYwotLSAKMi4xNy4x
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
