Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C327C10DCE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 07:44:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63B66206B1
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 07:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aAIKkiMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B66206B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD4AB6EB7E;
	Fri, 13 Mar 2020 07:44:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA6BD6EB7E
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 07:44:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4+5a6pxVtRc8Mgu+XKoFGeF4qJnuR6Ouu5S1PXlMNY4Dl00zCMDBgoBNfPs44pOl8lbG3ISVnWcIHr4rXNAPSNrTey8NFlULpfQ+upu9atddOhc735m7RfhCqBLiYvlHPYzSGYuDJgPIN41WkvUvk7CaV2VMccKqMHa/HtzTPiVg/++eUcH7QzHC9/fDN6tV7NUgv5Tneq5WlVzdyuhqjKcWLeWB5N1InCwIeo683GxGphjMwNwWUKQbEJ5ggBJMJqrsldydWz+mmBTE4agvwGWqskhqaWqW4VeqfvJbcBhFDhJEOOhAA5/v7FdDYSJWYmzUGSik3oXpzeBddMgzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBdsoDHvc5IQA7OsWpibRYUlzDsSS54awF2U7rhzlv0=;
 b=ZPazq6N2Id0qbwNhtsyFCXTKG4oDIKdgKGt6OodwhM00teiN+YcMPplByEfPpMMGx4Y2VbxcSy8J0GlPm5QjFGYaLvOWsLU19vNf095XcPovWqpOXOJOuZuEHX1q5FsS4qkADeUIcNHqkVZ6BSuSitMSGJr1YBdWhZwab7vGaSdw3mcriGK5B1m7ELPyxiC6I1A6uehY1aa7KUyEtq83Oa3r2vnHyPtubo7aPPfhQHHitON6njc0BY6t63yozsdpSJE1q0FB9vFnFAfuP5+/bvhGNJqEMtLxE8S+4efC2QJwK+ekRHqkYY2a8f7j/IxIDqJaA6++joLYHcIQUKBaFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBdsoDHvc5IQA7OsWpibRYUlzDsSS54awF2U7rhzlv0=;
 b=aAIKkiMPWtHXI9RSLwt2aLLX3Tm1L4iQ809MURsQowdCtNZbI99melBDgZlXkzgtj8bNYr5Qcc97Pcwru5i/jYs9bfhJRafc52uDyrVIVcvfGls74Jhr102ehfiTxFHR1lszb0YQoUHJzNjO4ZA8OwlEVFP9uwjYbMdqurqibX0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2781.namprd12.prod.outlook.com (2603:10b6:805:67::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Fri, 13 Mar
 2020 07:44:08 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 07:44:07 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: unref the bo after job submit
Date: Fri, 13 Mar 2020 15:43:36 +0800
Message-Id: <20200313074336.19545-3-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313074336.19545-1-xinhui.pan@amd.com>
References: <20200313074336.19545-1-xinhui.pan@amd.com>
X-ClientProxiedBy: HK2PR03CA0048.apcprd03.prod.outlook.com
 (2603:1096:202:17::18) To SN6PR12MB2800.namprd12.prod.outlook.com
 (2603:10b6:805:6c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (180.167.199.189) by
 HK2PR03CA0048.apcprd03.prod.outlook.com (2603:1096:202:17::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.7 via Frontend Transport; Fri, 13 Mar 2020 07:44:06 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e8fb79e6-9ef9-470b-a0e9-08d7c7224fb2
X-MS-TrafficTypeDiagnostic: SN6PR12MB2781:|SN6PR12MB2781:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27812B4A7FEA2EFAD35D661C87FA0@SN6PR12MB2781.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:378;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(199004)(8676002)(5660300002)(81166006)(81156014)(6486002)(54906003)(52116002)(7696005)(4326008)(66476007)(66946007)(66556008)(8936002)(66574012)(1076003)(186003)(26005)(16526019)(2906002)(6916009)(2616005)(956004)(316002)(86362001)(36756003)(6666004)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2781;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5aaiSeYo0jzEvkz1f2maJxEZkuEjReOwgI9mFvG34ye22T7uUg9wb1qQ2nXrEueGmJOUB8BFfXZ8Y27ROGwh23Ml/agVjmru7BxjRPlXVNeTpLTvxpkeDmmkdtgyxbreRLMdpozD5ujsSb6HMFdYFa4XIQ2PsT454HAnE8M6m2NIXk5ZxmNbhBpUgGuXerYnSYEZx9GDIgWBznmgPgLaqFr8ckJcwR+8y/yFjcOsJiSrsVdkWpD8Buv/PqT0HaJjwIveZBhb+iZpwtkcQUGnUeDnxj/p4PaDCPJ7ueTBqmxfIvB7XJRkbvvbUQxYjKMkjTKitvgSJlYujnkfd96ww5AxAx4H/KxkQkbCFKKJt85P3YO9jbWVLPYd6o3rXzhhc8F54rjbvYwDMMy6x4YwFVu5uGjd0VszFlo38Srp7dKpw9ECclJEdg4zjgY0wawm
X-MS-Exchange-AntiSpam-MessageData: NTmUwWPj1Av24C4c2Ms049ynSbvTpQPZtjZ7llTtqjMP52jg9Hp6KwDWZG6/La3uJamG6VDODYziimHA7JA3KhXBswyVwGdjbM1rOz3bcMt2B9WsjtI//NZWoVU4vyedvUhl1RHMsTvNw4fZrjfoFw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8fb79e6-9ef9-470b-a0e9-08d7c7224fb2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 07:44:07.8145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sk3OkQdUCdYRpJF8x3Zu/BzMTeBPHAcnCLB23tgc6roY4AJSNExNTmf6CyNdRcdI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2781
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, xinhui pan <xinhui.pan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T3RoZXJ3aXNlIHdlIG1pZ2h0IGZyZWUgQk9zIGJlZm9yZSBqb2IgaGFzIGNvbXBsZXRlZC4KV2Ug
YWRkIHRoZSBmZW5jZSB0byBCTyBhZnRlciBjb21taXQsIHNvIGZyZWUgQk9zIGFmdGVyIHRoYXQu
CgpDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogRmVsaXggS3VlaGxpbmcg
PEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IHhpbmh1aSBwYW4gPHhpbmh1
aS5wYW5AYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0u
YyB8IDM3ICsrKysrKysrKysrKysrKysrKystLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjcgaW5z
ZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm0uYwppbmRleCBmNDI0YjU5Njk5MzAuLjUxM2YzYjc3ZDNkYSAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKQEAgLTk0MiwxMyArOTQyLDE3IEBAIHN0YXRpYyBpbnQg
YW1kZ3B1X3ZtX2FsbG9jX3B0cyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKICAqCiAgKiBA
ZW50cnk6IFBERSB0byBmcmVlCiAgKi8KLXN0YXRpYyB2b2lkIGFtZGdwdV92bV9mcmVlX3RhYmxl
KHN0cnVjdCBhbWRncHVfdm1fcHQgKmVudHJ5KQorc3RhdGljIHZvaWQgYW1kZ3B1X3ZtX2ZyZWVf
dGFibGUoc3RydWN0IGFtZGdwdV92bV9wdCAqZW50cnksCisJCQkJCXN0cnVjdCBsaXN0X2hlYWQg
KmhlYWQpCiB7CiAJaWYgKGVudHJ5LT5iYXNlLmJvKSB7CiAJCWVudHJ5LT5iYXNlLmJvLT52bV9i
byA9IE5VTEw7CiAJCWxpc3RfZGVsKCZlbnRyeS0+YmFzZS52bV9zdGF0dXMpOwotCQlhbWRncHVf
Ym9fdW5yZWYoJmVudHJ5LT5iYXNlLmJvLT5zaGFkb3cpOwotCQlhbWRncHVfYm9fdW5yZWYoJmVu
dHJ5LT5iYXNlLmJvKTsKKwkJaWYgKCFoZWFkKSB7CisJCQlhbWRncHVfYm9fdW5yZWYoJmVudHJ5
LT5iYXNlLmJvLT5zaGFkb3cpOworCQkJYW1kZ3B1X2JvX3VucmVmKCZlbnRyeS0+YmFzZS5ibyk7
CisJCX0gZWxzZQorCQkJbGlzdF9hZGQoJmVudHJ5LT5iYXNlLnZtX3N0YXR1cywgaGVhZCk7CiAJ
fQogCWt2ZnJlZShlbnRyeS0+ZW50cmllcyk7CiAJZW50cnktPmVudHJpZXMgPSBOVUxMOwpAQCAt
OTY1LDcgKzk2OSw4IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV92bV9mcmVlX3RhYmxlKHN0cnVjdCBh
bWRncHVfdm1fcHQgKmVudHJ5KQogICovCiBzdGF0aWMgdm9pZCBhbWRncHVfdm1fZnJlZV9wdHMo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQkgICAgICAgc3RydWN0IGFtZGdwdV92bSAq
dm0sCi0JCQkgICAgICAgc3RydWN0IGFtZGdwdV92bV9wdF9jdXJzb3IgKnN0YXJ0KQorCQkJICAg
ICAgIHN0cnVjdCBhbWRncHVfdm1fcHRfY3Vyc29yICpzdGFydCwKKwkJCQkgICBzdHJ1Y3QgbGlz
dF9oZWFkICpoZWFkKQogewogCXN0cnVjdCBhbWRncHVfdm1fcHRfY3Vyc29yIGN1cnNvcjsKIAlz
dHJ1Y3QgYW1kZ3B1X3ZtX3B0ICplbnRyeTsKQEAgLTk3MywxMCArOTc4LDEwIEBAIHN0YXRpYyB2
b2lkIGFtZGdwdV92bV9mcmVlX3B0cyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAl2bS0+
YnVsa19tb3ZlYWJsZSA9IGZhbHNlOwogCiAJZm9yX2VhY2hfYW1kZ3B1X3ZtX3B0X2Rmc19zYWZl
KGFkZXYsIHZtLCBzdGFydCwgY3Vyc29yLCBlbnRyeSkKLQkJYW1kZ3B1X3ZtX2ZyZWVfdGFibGUo
ZW50cnkpOworCQlhbWRncHVfdm1fZnJlZV90YWJsZShlbnRyeSwgaGVhZCk7CiAKIAlpZiAoc3Rh
cnQpCi0JCWFtZGdwdV92bV9mcmVlX3RhYmxlKHN0YXJ0LT5lbnRyeSk7CisJCWFtZGdwdV92bV9m
cmVlX3RhYmxlKHN0YXJ0LT5lbnRyeSwgaGVhZCk7CiB9CiAKIC8qKgpAQCAtMTQyOCw3ICsxNDMz
LDggQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3ZtX2ZyYWdtZW50KHN0cnVjdCBhbWRncHVfdm1fdXBk
YXRlX3BhcmFtcyAqcGFyYW1zLAogICovCiBzdGF0aWMgaW50IGFtZGdwdV92bV91cGRhdGVfcHRl
cyhzdHJ1Y3QgYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgKnBhcmFtcywKIAkJCQkgdWludDY0X3Qg
c3RhcnQsIHVpbnQ2NF90IGVuZCwKLQkJCQkgdWludDY0X3QgZHN0LCB1aW50NjRfdCBmbGFncykK
KwkJCQkgdWludDY0X3QgZHN0LCB1aW50NjRfdCBmbGFncywKKwkJCQkgc3RydWN0IGxpc3RfaGVh
ZCAqaGVhZCkKIHsKIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IHBhcmFtcy0+YWRldjsK
IAlzdHJ1Y3QgYW1kZ3B1X3ZtX3B0X2N1cnNvciBjdXJzb3I7CkBAIC0xNTM5LDcgKzE1NDUsNyBA
QCBzdGF0aWMgaW50IGFtZGdwdV92bV91cGRhdGVfcHRlcyhzdHJ1Y3QgYW1kZ3B1X3ZtX3VwZGF0
ZV9wYXJhbXMgKnBhcmFtcywKIAkJCSAqIGNvbXBsZXRlbHkgY292ZXJlZCBieSB0aGUgcmFuZ2Ug
YW5kIHNvIHBvdGVudGlhbGx5IHN0aWxsIGluIHVzZS4KIAkJCSAqLwogCQkJd2hpbGUgKGN1cnNv
ci5wZm4gPCBmcmFnX3N0YXJ0KSB7Ci0JCQkJYW1kZ3B1X3ZtX2ZyZWVfcHRzKGFkZXYsIHBhcmFt
cy0+dm0sICZjdXJzb3IpOworCQkJCWFtZGdwdV92bV9mcmVlX3B0cyhhZGV2LCBwYXJhbXMtPnZt
LCAmY3Vyc29yLCBoZWFkKTsKIAkJCQlhbWRncHVfdm1fcHRfbmV4dChhZGV2LCAmY3Vyc29yKTsK
IAkJCX0KIApAQCAtMTU4Myw2ICsxNTg5LDcgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYm9fdXBk
YXRlX21hcHBpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJZW51bSBhbWRncHVfc3lu
Y19tb2RlIHN5bmNfbW9kZTsKIAlpbnQgcjsKIAlzdHJ1Y3QgYW1kZ3B1X2JvICpyb290ID0gdm0t
PnJvb3QuYmFzZS5ibzsKKwlzdHJ1Y3QgbGlzdF9oZWFkIGhlYWQ7CiAKIAltZW1zZXQoJnBhcmFt
cywgMCwgc2l6ZW9mKHBhcmFtcykpOwogCXBhcmFtcy5hZGV2ID0gYWRldjsKQEAgLTE1OTAsNiAr
MTU5Nyw4IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX2JvX3VwZGF0ZV9tYXBwaW5nKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LAogCXBhcmFtcy5kaXJlY3QgPSBkaXJlY3Q7CiAJcGFyYW1zLnBh
Z2VzX2FkZHIgPSBwYWdlc19hZGRyOwogCisJSU5JVF9MSVNUX0hFQUQoJmhlYWQpOworCiAJLyog
SW1wbGljaXRseSBzeW5jIHRvIGNvbW1hbmQgc3VibWlzc2lvbnMgaW4gdGhlIHNhbWUgVk0gYmVm
b3JlCiAJICogdW5tYXBwaW5nLiBTeW5jIHRvIG1vdmluZyBmZW5jZXMgYmVmb3JlIG1hcHBpbmcu
CiAJICovCkBAIC0xNjE2LDcgKzE2MjUsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9ib191cGRh
dGVfbWFwcGluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAlpZiAocikKIAkJZ290byBl
cnJvcl91bmxvY2s7CiAKLQlyID0gYW1kZ3B1X3ZtX3VwZGF0ZV9wdGVzKCZwYXJhbXMsIHN0YXJ0
LCBsYXN0ICsgMSwgYWRkciwgZmxhZ3MpOworCXIgPSBhbWRncHVfdm1fdXBkYXRlX3B0ZXMoJnBh
cmFtcywgc3RhcnQsIGxhc3QgKyAxLCBhZGRyLCBmbGFncywgJmhlYWQpOwogCWlmIChyKQogCQln
b3RvIGVycm9yX3VubG9jazsKIApAQCAtMTYyOSw2ICsxNjM4LDE0IEBAIHN0YXRpYyBpbnQgYW1k
Z3B1X3ZtX2JvX3VwZGF0ZV9tYXBwaW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQlh
bWRncHVfYm9fZmVuY2Uocm9vdCwgdm0tPmxhc3RfZGVsYXllZCwgdHJ1ZSk7CiAKIGVycm9yX3Vu
bG9jazoKKwl3aGlsZSAoIWxpc3RfZW1wdHkoJmhlYWQpKSB7CisJCXN0cnVjdCBhbWRncHVfdm1f
cHQgKmVudHJ5ID0gbGlzdF9maXJzdF9lbnRyeSgmaGVhZCwKKwkJCQlzdHJ1Y3QgYW1kZ3B1X3Zt
X3B0LCBiYXNlLnZtX3N0YXR1cyk7CisJCWxpc3RfZGVsKCZlbnRyeS0+YmFzZS52bV9zdGF0dXMp
OworCisJCWFtZGdwdV9ib191bnJlZigmZW50cnktPmJhc2UuYm8tPnNoYWRvdyk7CisJCWFtZGdw
dV9ib191bnJlZigmZW50cnktPmJhc2UuYm8pOworCX0KIAlhbWRncHVfdm1fZXZpY3Rpb25fdW5s
b2NrKHZtKTsKIAlyZXR1cm4gcjsKIH0KQEAgLTMxMjMsNyArMzE0MCw3IEBAIHZvaWQgYW1kZ3B1
X3ZtX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZt
KQogCQlhbWRncHVfdm1fZnJlZV9tYXBwaW5nKGFkZXYsIHZtLCBtYXBwaW5nLCBOVUxMKTsKIAl9
CiAKLQlhbWRncHVfdm1fZnJlZV9wdHMoYWRldiwgdm0sIE5VTEwpOworCWFtZGdwdV92bV9mcmVl
X3B0cyhhZGV2LCB2bSwgTlVMTCwgTlVMTCk7CiAJYW1kZ3B1X2JvX3VucmVzZXJ2ZShyb290KTsK
IAlhbWRncHVfYm9fdW5yZWYoJnJvb3QpOwogCVdBUk5fT04odm0tPnJvb3QuYmFzZS5ibyk7Ci0t
IAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
