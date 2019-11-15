Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C04FC432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:09:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2529C2073A
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2529C2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E84D66E928;
	Fri, 15 Nov 2019 16:09:46 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800073.outbound.protection.outlook.com [40.107.80.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F9056E928
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 16:09:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJOc8CKNR996GsdVhyToFXbY75KANJqGPJf4jNHBXjCtCqTrRnEXSBQ87euOkUI8potdU8Q2B7S0uKo5MfZp/0BJWAd1dmDnelK6cXDFLDXcdcwxThrfpMkhqzY7mrF2v4E3Cta5vbvbb9LOtMPThtYdVT8cbcR1PKcxhLkSBWLvt7B4zO4ddCQTOC1ozHz1upsIl34s5WYRGlbOejt3XQJjozK54tNNhFzabkMOXoNjY4aM7X04NTFXBmvMA2YUtD6WSKlqEDa9J6UPgRZNGJA/RSpcjMST+3VtM18LAP/68mXdtYpRmKEHEQNkZLujf31x9rdi5g9SjxSKEOa22A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVrTE0RF5OIgMe0zSiTOmZEEUCRCJSNx+NI4LcpcV3w=;
 b=AaGOB5uEdt/NWNaIoWOrqY7RR+dNrEWexz1s24y4q9RkGvrGOJu8qC8pisdDy3drnU8i1OL+yqMziL2hNrwd6po5lNYqmDWWgLeoaybEIx5qgmpWe0wjqUtDVXwhxyyvareTn5/JQAo91bCrykbSnRYATMmxbff1z7xHnWQYkHlByjSDqrAahW/VKafJ8xXkeIzFUDpfbrR7taljr5fwJgtnYCzeIQ6KdqFOh/cpYgXPw8AGfcCjhfQKbH8BTKwVQ5S7S35AcKxwEzThaHh7lDn4TuzDlpOQeUH0CuoyUYq/pM7lsPe+7LZimku48MmYeelEM1uC/H1+7paPEl3xtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB3356.namprd12.prod.outlook.com (20.178.198.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Fri, 15 Nov 2019 16:09:42 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e%6]) with mapi id 15.20.2430.027; Fri, 15 Nov 2019
 16:09:42 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: DIQ should not use HIQ way to allocate memory
Date: Fri, 15 Nov 2019 11:09:29 -0500
Message-Id: <20191115160929.2017-1-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTBPR01CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::41) To DM6PR12MB2778.namprd12.prod.outlook.com
 (2603:10b6:5:50::17)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6ce3d874-eeb8-4a7d-8dfb-08d769e6398e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3356:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3356994592D0BA43D3E7E1C7F0700@DM6PR12MB3356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-Forefront-PRVS: 02229A4115
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(199004)(189003)(81166006)(47776003)(50466002)(2906002)(48376002)(81156014)(14454004)(16586007)(186003)(8936002)(50226002)(52116002)(51416003)(5660300002)(6512007)(6666004)(66946007)(6486002)(476003)(6916009)(7736002)(26005)(36756003)(1076003)(8676002)(66066001)(478600001)(316002)(99286004)(386003)(6506007)(4326008)(2351001)(86362001)(305945005)(66476007)(66556008)(6116002)(6436002)(25786009)(3846002)(2616005)(2361001)(486006)(43043002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3356;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HbJjQDBQ/ZblYk5NRY9ymoxJ0l3ciQ12yPtEpDj+TKmNzOb6wU4A+TB1LUHYBofpDMtuiOLgZ31Wa2ArgAC7Wz9sMdeuWWDxpfjB1Tf8HAIyDgGv+DkYtlEaT+G0tc/CTiSiQ9OADkX+YaqoqO4ueEUrprPRbAWBVKqlmKwm2z/3O3YzsSDOZjmh3WTUXfRTWyN7DVrCJ1RjZ+TLEaRp8qOaG3cYCqrOsIBPvieztO7hYzpjgO5E3mdXo+j+M1v6KyRFUYz3N1/91c4TQAv8SVkiWSn+JnP+BH21erUgiLrTApwpohG27sK60TixUycB6giOrUr13PvgBz2iVuAFPqeki7dXaeG3Z/tfqUD1nrffulHgrUBgytZKhlUjCH6dR9T6KYlvL/84sTO/EiazgeqoYdJE19pDsiZinPChVf/TLgcz8pILSMYNlQrHNieg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce3d874-eeb8-4a7d-8dfb-08d769e6398e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 16:09:42.7281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OJjGD2q133GmO+y11jbvzh79TI5nYLrzCIbaM5YfiAFe2Z/xPitCcnu4H0fZBfq6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3356
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVrTE0RF5OIgMe0zSiTOmZEEUCRCJSNx+NI4LcpcV3w=;
 b=s19cLJ024BJ8+bo9ubapnIHAYIGrN1Nd8rifGBaGDNsaiMQKsteaLfaAkEc1EcGp3jHMip39bmFTFEyyrK25OBz0SetuP2IzuzBSnhqrIlZvpsg1jHqZUxN4IZ1fOg7ghH4xz4ClZiGitiDSL5M+gSw46HSz0zwXpQPw7NmL3fo=
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
Message-ID: <20191115160929.tDrWdgPjQdZUzacnY5gMvDUVtSOAAsZsx_mtpi-q0-0@z>

SW4gdGhlIG1xZF9kaXFfc2RtYSBidWZmZXIsIHRoZXJlIHNob3VsZCBiZSBvbmx5IG9uZSBISVEg
bXFkLiBBbGwgRElRcwpzaG91bGQgYmUgYWxsb2NhdGUgdXNpbmcgdGhlIHJlZ3VsYXIgd2F5LgoK
Q2hhbmdlLUlkOiBJYmYzZWIzMzYwNGQwZWMzMDUwMWMyNDQyMjhjZGIzYjI0NjE1YjY5OQpTaWdu
ZWQtb2ZmLWJ5OiBZb25nIFpoYW8gPFlvbmcuWmhhb0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl9jaWsuYyB8IDIgKy0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92MTAuYyB8IDIgKy0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92OS5jICB8IDIgKy0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92aS5jICB8IDIgKy0KIDQgZmlsZXMgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl9jaWsuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl9jaWsuYwppbmRleCBiMDg2OTRlYzY1ZDcu
LjE5ZjBmZTU0N2M1NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X21xZF9tYW5hZ2VyX2Npay5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9t
cWRfbWFuYWdlcl9jaWsuYwpAQCAtNDAwLDcgKzQwMCw3IEBAIHN0cnVjdCBtcWRfbWFuYWdlciAq
bXFkX21hbmFnZXJfaW5pdF9jaWsoZW51bSBLRkRfTVFEX1RZUEUgdHlwZSwKICNlbmRpZgogCQli
cmVhazsKIAljYXNlIEtGRF9NUURfVFlQRV9ESVE6Ci0JCW1xZC0+YWxsb2NhdGVfbXFkID0gYWxs
b2NhdGVfaGlxX21xZDsKKwkJbXFkLT5hbGxvY2F0ZV9tcWQgPSBhbGxvY2F0ZV9tcWQ7CiAJCW1x
ZC0+aW5pdF9tcWQgPSBpbml0X21xZF9oaXE7CiAJCW1xZC0+ZnJlZV9tcWQgPSBmcmVlX21xZDsK
IAkJbXFkLT5sb2FkX21xZCA9IGxvYWRfbXFkOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMC5jCmluZGV4IDVhMGUzMDQ0MWJlOC4uOGQyMTMyNWI1
Y2JiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFn
ZXJfdjEwLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2Vy
X3YxMC5jCkBAIC00MzIsNyArNDMyLDcgQEAgc3RydWN0IG1xZF9tYW5hZ2VyICptcWRfbWFuYWdl
cl9pbml0X3YxMChlbnVtIEtGRF9NUURfVFlQRSB0eXBlLAogCQlwcl9kZWJ1ZygiJXNAJWlcbiIs
IF9fZnVuY19fLCBfX0xJTkVfXyk7CiAJCWJyZWFrOwogCWNhc2UgS0ZEX01RRF9UWVBFX0RJUToK
LQkJbXFkLT5hbGxvY2F0ZV9tcWQgPSBhbGxvY2F0ZV9oaXFfbXFkOworCQltcWQtPmFsbG9jYXRl
X21xZCA9IGFsbG9jYXRlX21xZDsKIAkJbXFkLT5pbml0X21xZCA9IGluaXRfbXFkX2hpcTsKIAkJ
bXFkLT5mcmVlX21xZCA9IGZyZWVfbXFkOwogCQltcWQtPmxvYWRfbXFkID0gbG9hZF9tcWQ7CmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjku
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92OS5jCmluZGV4
IGJkYmNlYTIyYWQxMi4uZGY3N2Q2N2VjOWFhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjkuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjkuYwpAQCAtNDcxLDcgKzQ3MSw3IEBAIHN0cnVjdCBt
cWRfbWFuYWdlciAqbXFkX21hbmFnZXJfaW5pdF92OShlbnVtIEtGRF9NUURfVFlQRSB0eXBlLAog
I2VuZGlmCiAJCWJyZWFrOwogCWNhc2UgS0ZEX01RRF9UWVBFX0RJUToKLQkJbXFkLT5hbGxvY2F0
ZV9tcWQgPSBhbGxvY2F0ZV9oaXFfbXFkOworCQltcWQtPmFsbG9jYXRlX21xZCA9IGFsbG9jYXRl
X21xZDsKIAkJbXFkLT5pbml0X21xZCA9IGluaXRfbXFkX2hpcTsKIAkJbXFkLT5mcmVlX21xZCA9
IGZyZWVfbXFkOwogCQltcWQtPmxvYWRfbXFkID0gbG9hZF9tcWQ7CmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdmkuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92aS5jCmluZGV4IGM5ZTExNTFiNWE1Ny4u
M2I2YjU2NzE5NjRjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
bXFkX21hbmFnZXJfdmkuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFk
X21hbmFnZXJfdmkuYwpAQCAtNDUyLDcgKzQ1Miw3IEBAIHN0cnVjdCBtcWRfbWFuYWdlciAqbXFk
X21hbmFnZXJfaW5pdF92aShlbnVtIEtGRF9NUURfVFlQRSB0eXBlLAogI2VuZGlmCiAJCWJyZWFr
OwogCWNhc2UgS0ZEX01RRF9UWVBFX0RJUToKLQkJbXFkLT5hbGxvY2F0ZV9tcWQgPSBhbGxvY2F0
ZV9oaXFfbXFkOworCQltcWQtPmFsbG9jYXRlX21xZCA9IGFsbG9jYXRlX21xZDsKIAkJbXFkLT5p
bml0X21xZCA9IGluaXRfbXFkX2hpcTsKIAkJbXFkLT5mcmVlX21xZCA9IGZyZWVfbXFkOwogCQlt
cWQtPmxvYWRfbXFkID0gbG9hZF9tcWQ7Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeA==
