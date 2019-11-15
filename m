Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1041C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:08:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDFF22053B
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDFF22053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 600036E925;
	Fri, 15 Nov 2019 16:08:04 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680043.outbound.protection.outlook.com [40.107.68.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5E046E925
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 16:08:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROMtM9vvw8/OUgq/poi2a9H63QF8dipv8RHj4+3+Z8FenE41PSI1+SRuy1WCgTWG1FrdWawV1QxR7jzXw0+eslWzd4uXrY6HKIYJv7MWpXbDK9PfjqWSZH8g/1VWqE73ju8NfxbPBkrik2Xk59pw+D9GUGayScd8yTpdMt06DZzWW+Wuvk4qNB1gS/qzaZ8lek8ChdNwcPTCPQBZ/04wAgUHDKaOryO0vjMRU9KNndiCKBcqBM/rexHXcdr0fh2eGW7ulNQQIpwJf+3VrF7tAONYJeaZXhFf7olbVV21K1Ha8xqJzp2nnlCoPdOYtP4lxOlw0ME20gMbqLpEGNlkpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqPPN7OXwoYyE/lm7YfTJCCeOjMjzf7dy8NCykLp5is=;
 b=e4MLXaNiKJ67alUqyT01c00Fy7SootiSiOf7qkpWJHJ0T9btqHtTN7GewYiOeMOTSUffF1ShBqjnMxN6SfUAeV/n7cQrFvdgB5eQFM/l6OtzhZILVGST2YkNYJLlaUSQgk8cxZrmU59oN5fytl8uZUpEkus3kRyW1Rd8QfMuZSURyf3JUuND2/ErzprScFWauinFrIlpypyiLS2+SRuiH/5+3n5JbOmo55H6KqMFQbwLOneBCYkCQx7BbF3nh98Gq+64IRve69d1BsWJ5osg7/xoMIThzbpU97s7NGp2b0oHDv+TQQs5w1xFf+BGtQmzQ7BgWxh6nsas60pg9j/1NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB2668.namprd12.prod.outlook.com (20.176.116.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.26; Fri, 15 Nov 2019 16:08:00 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e%6]) with mapi id 15.20.2430.027; Fri, 15 Nov 2019
 16:08:00 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Delete KFD_MQD_TYPE_COMPUTE
Date: Fri, 15 Nov 2019 11:07:47 -0500
Message-Id: <20191115160747.1827-1-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::25)
 To DM6PR12MB2778.namprd12.prod.outlook.com
 (2603:10b6:5:50::17)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4287cf03-f4db-4278-350e-08d769e5fc76
X-MS-TrafficTypeDiagnostic: DM6PR12MB2668:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2668421C8BD1F186612A423AF0700@DM6PR12MB2668.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 02229A4115
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(189003)(199004)(486006)(476003)(316002)(2616005)(26005)(66556008)(6916009)(6666004)(5660300002)(16586007)(25786009)(48376002)(478600001)(86362001)(8676002)(386003)(81166006)(50226002)(81156014)(6506007)(7736002)(1076003)(50466002)(8936002)(6512007)(6436002)(2361001)(14444005)(36756003)(99286004)(47776003)(6486002)(66476007)(6116002)(66066001)(51416003)(14454004)(2351001)(3846002)(4326008)(305945005)(186003)(52116002)(66946007)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2668;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BuNEwzsuaNuH/w3JeJejMiMrKJLV2ZQRS3yiIceSapp0swx93bJz3kXU9uvrUUx27tornDNJ8km/0o8SQYMhCs+m/frlNKG9ANhCypG1D5GYHgvJfJmjEyWRaqx55+oMbRS1/zWxjGSJI11o7vwCnk1yIZmXLrwwFEE3qlbmnHrAD3uxKA+f+bq6QGCUdTOF1zwD2pAugnvsU8mQOSFMNYaiunLGzDMAx89OSYPc5giSj1/fSf2uXplU7lPsTJH8ZO7/Y3usEMwwh6+Gp61qnNd+mPU+1W1px3p8ynb3ZZ8WBgPJZy3wwPH9+1+cP8QqPq9EF7pNmlzjtO7c/xQZ3Eob5Ag4CcsGy1fEM4jaTkrF+nx9BaImeijx7TaeJjeAGK5QNGr/3oHX9qiUBGfdbMK0o1uj/cOEt2KEOW07JFr23SwHcQDvJKJwUZ4WWGIS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4287cf03-f4db-4278-350e-08d769e5fc76
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 16:08:00.3085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yA0qjvFLMOByEkNl1EsSSH5SQvIC/4Db5dfY/17ik6hEyqUobtyKEDOUdJqGebKB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2668
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqPPN7OXwoYyE/lm7YfTJCCeOjMjzf7dy8NCykLp5is=;
 b=MEfCjpEr1pdyLZ1g+rAoD6SDlZAMkMzUs3Nq/i9Uv3J880dN+EGhLAv49f0rZsQn6Zi3AE9XgG3MHm9l+F8Atp1YQ9LRSWyj9MpZn3CgSQxHafj+GxmT/4wfDRj/ufEZpYJlh/nRAhOGXObrlUWLBXdmHIL2Hht5WKbNunnj6ME=
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
Message-ID: <20191115160747.UIr-HHvD6PUgavOEI-to4yo-U3tBDxlMklJH-2BphKU@z>

SXQgaXMgdGhlIHNhbWUgYXMgS0ZEX01RRF9UWVBFX0NQLCBzbyBkZWxldGUgaXQuIEFzIGEgcmVz
dWx0LCB3ZSB3aWxsCmhhdmUgb25lIGxlc3MgbXFkIG1hbmFuZ2VyIHBlciBkZXZpY2UuCgpDaGFu
Z2UtSWQ6IElhYTk4ZmMxN2JlMDZiMjE2ZGU3YTgyNmMzNTc3ZjQ0YmMwNTM2YjRjClNpZ25lZC1v
ZmYtYnk6IFlvbmcgWmhhbyA8WW9uZy5aaGFvQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMgfCAyICstCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfY2lrLmMgICAgICB8IDMgKy0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjEwLmMgICAgICB8IDEgLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3Y5LmMgICAgICAgfCAx
IC0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92aS5jICAgICAg
IHwgMyArLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmggICAgICAgICAg
ICAgICAgIHwgMyArLS0KIDYgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA5IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZp
Y2VfcXVldWVfbWFuYWdlci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2Rldmlj
ZV9xdWV1ZV9tYW5hZ2VyLmMKaW5kZXggYjQyZjM0ZWYyYjVjLi5mN2Y2ZGY0MDg3NWUgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdl
ci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFu
YWdlci5jCkBAIC0xNTk1LDcgKzE1OTUsNyBAQCBzdGF0aWMgaW50IGdldF93YXZlX3N0YXRlKHN0
cnVjdCBkZXZpY2VfcXVldWVfbWFuYWdlciAqZHFtLAogCQlnb3RvIGRxbV91bmxvY2s7CiAJfQog
Ci0JbXFkX21nciA9IGRxbS0+bXFkX21ncnNbS0ZEX01RRF9UWVBFX0NPTVBVVEVdOworCW1xZF9t
Z3IgPSBkcW0tPm1xZF9tZ3JzW0tGRF9NUURfVFlQRV9DUF07CiAKIAlpZiAoIW1xZF9tZ3ItPmdl
dF93YXZlX3N0YXRlKSB7CiAJCXIgPSAtRUlOVkFMOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX2Npay5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX2Npay5jCmluZGV4IDI4ODc2YWNlYjE0Yi4uYjA4Njk0
ZWM2NWQ3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21h
bmFnZXJfY2lrLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5h
Z2VyX2Npay5jCkBAIC0zNzQsNyArMzc0LDYgQEAgc3RydWN0IG1xZF9tYW5hZ2VyICptcWRfbWFu
YWdlcl9pbml0X2NpayhlbnVtIEtGRF9NUURfVFlQRSB0eXBlLAogCiAJc3dpdGNoICh0eXBlKSB7
CiAJY2FzZSBLRkRfTVFEX1RZUEVfQ1A6Ci0JY2FzZSBLRkRfTVFEX1RZUEVfQ09NUFVURToKIAkJ
bXFkLT5hbGxvY2F0ZV9tcWQgPSBhbGxvY2F0ZV9tcWQ7CiAJCW1xZC0+aW5pdF9tcWQgPSBpbml0
X21xZDsKIAkJbXFkLT5mcmVlX21xZCA9IGZyZWVfbXFkOwpAQCAtNDQyLDcgKzQ0MSw3IEBAIHN0
cnVjdCBtcWRfbWFuYWdlciAqbXFkX21hbmFnZXJfaW5pdF9jaWtfaGF3YWlpKGVudW0gS0ZEX01R
RF9UWVBFIHR5cGUsCiAJbXFkID0gbXFkX21hbmFnZXJfaW5pdF9jaWsodHlwZSwgZGV2KTsKIAlp
ZiAoIW1xZCkKIAkJcmV0dXJuIE5VTEw7Ci0JaWYgKCh0eXBlID09IEtGRF9NUURfVFlQRV9DUCkg
fHwgKHR5cGUgPT0gS0ZEX01RRF9UWVBFX0NPTVBVVEUpKQorCWlmICh0eXBlID09IEtGRF9NUURf
VFlQRV9DUCkKIAkJbXFkLT51cGRhdGVfbXFkID0gdXBkYXRlX21xZF9oYXdhaWk7CiAJcmV0dXJu
IG1xZDsKIH0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRf
bWFuYWdlcl92MTAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdl
cl92MTAuYwppbmRleCA1NzljNWZmY2ZhNzkuLjVhMGUzMDQ0MWJlOCAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMC5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92MTAuYwpAQCAtNDAxLDcgKzQw
MSw2IEBAIHN0cnVjdCBtcWRfbWFuYWdlciAqbXFkX21hbmFnZXJfaW5pdF92MTAoZW51bSBLRkRf
TVFEX1RZUEUgdHlwZSwKIAogCXN3aXRjaCAodHlwZSkgewogCWNhc2UgS0ZEX01RRF9UWVBFX0NQ
OgotCWNhc2UgS0ZEX01RRF9UWVBFX0NPTVBVVEU6CiAJCXByX2RlYnVnKCIlc0AlaVxuIiwgX19m
dW5jX18sIF9fTElORV9fKTsKIAkJbXFkLT5hbGxvY2F0ZV9tcWQgPSBhbGxvY2F0ZV9tcWQ7CiAJ
CW1xZC0+aW5pdF9tcWQgPSBpbml0X21xZDsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92OS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX21xZF9tYW5hZ2VyX3Y5LmMKaW5kZXggMjJhODE5Yzg4OGQ4Li5iZGJjZWEyMmFkMTIg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92
OS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92OS5j
CkBAIC00NDQsNyArNDQ0LDYgQEAgc3RydWN0IG1xZF9tYW5hZ2VyICptcWRfbWFuYWdlcl9pbml0
X3Y5KGVudW0gS0ZEX01RRF9UWVBFIHR5cGUsCiAKIAlzd2l0Y2ggKHR5cGUpIHsKIAljYXNlIEtG
RF9NUURfVFlQRV9DUDoKLQljYXNlIEtGRF9NUURfVFlQRV9DT01QVVRFOgogCQltcWQtPmFsbG9j
YXRlX21xZCA9IGFsbG9jYXRlX21xZDsKIAkJbXFkLT5pbml0X21xZCA9IGluaXRfbXFkOwogCQlt
cWQtPmZyZWVfbXFkID0gZnJlZV9tcWQ7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdmkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9tcWRfbWFuYWdlcl92aS5jCmluZGV4IDdkMTQ0ZjU2ZjQyMS4uYzllMTE1MWI1YTU3IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdmku
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdmkuYwpA
QCAtNDI1LDcgKzQyNSw2IEBAIHN0cnVjdCBtcWRfbWFuYWdlciAqbXFkX21hbmFnZXJfaW5pdF92
aShlbnVtIEtGRF9NUURfVFlQRSB0eXBlLAogCiAJc3dpdGNoICh0eXBlKSB7CiAJY2FzZSBLRkRf
TVFEX1RZUEVfQ1A6Ci0JY2FzZSBLRkRfTVFEX1RZUEVfQ09NUFVURToKIAkJbXFkLT5hbGxvY2F0
ZV9tcWQgPSBhbGxvY2F0ZV9tcWQ7CiAJCW1xZC0+aW5pdF9tcWQgPSBpbml0X21xZDsKIAkJbXFk
LT5mcmVlX21xZCA9IGZyZWVfbXFkOwpAQCAtNDk0LDcgKzQ5Myw3IEBAIHN0cnVjdCBtcWRfbWFu
YWdlciAqbXFkX21hbmFnZXJfaW5pdF92aV90b25nYShlbnVtIEtGRF9NUURfVFlQRSB0eXBlLAog
CW1xZCA9IG1xZF9tYW5hZ2VyX2luaXRfdmkodHlwZSwgZGV2KTsKIAlpZiAoIW1xZCkKIAkJcmV0
dXJuIE5VTEw7Ci0JaWYgKCh0eXBlID09IEtGRF9NUURfVFlQRV9DUCkgfHwgKHR5cGUgPT0gS0ZE
X01RRF9UWVBFX0NPTVBVVEUpKQorCWlmICh0eXBlID09IEtGRF9NUURfVFlQRV9DUCkKIAkJbXFk
LT51cGRhdGVfbXFkID0gdXBkYXRlX21xZF90b25nYTsKIAlyZXR1cm4gbXFkOwogfQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYuaCBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmgKaW5kZXggMTA0OTc1OWRjNmJiLi41MTQ4OTZiZWY5
OWEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmgKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYuaApAQCAtNTA4LDggKzUwOCw3
IEBAIHN0cnVjdCBxdWV1ZSB7CiAgKiBQbGVhc2UgcmVhZCB0aGUga2ZkX21xZF9tYW5hZ2VyLmgg
ZGVzY3JpcHRpb24uCiAgKi8KIGVudW0gS0ZEX01RRF9UWVBFIHsKLQlLRkRfTVFEX1RZUEVfQ09N
UFVURSA9IDAsCS8qIGZvciBubyBjcCBzY2hlZHVsaW5nICovCi0JS0ZEX01RRF9UWVBFX0hJUSwJ
CS8qIGZvciBoaXEgKi8KKwlLRkRfTVFEX1RZUEVfSElRID0gMCwJCS8qIGZvciBoaXEgKi8KIAlL
RkRfTVFEX1RZUEVfQ1AsCQkvKiBmb3IgY3AgcXVldWVzIGFuZCBkaXEgKi8KIAlLRkRfTVFEX1RZ
UEVfU0RNQSwJCS8qIGZvciBzZG1hIHF1ZXVlcyAqLwogCUtGRF9NUURfVFlQRV9ESVEsCQkvKiBm
b3IgZGlxICovCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeA==
