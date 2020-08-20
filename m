Return-Path: <SRS0=nMzJ=B6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E275EC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 05:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFEFD207BB
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 05:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rpDJdbca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFEFD207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38A686E8A4;
	Thu, 20 Aug 2020 05:27:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 861996E8A4
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2020 05:27:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSuQjldAPzTxA0yhtplmS8JBxxgGvUk45C2z0dOoc0Bd5qjEdR6jwqRnva6TxS+Y4dFPQlMLPmfiEhKVIAumPRD+F78pDD5aGEe9gWVWCCWlL6wqO3RpAIdrwDeZj9kONv+qi5v/k/jDOq/LbwGovTVa5MhaZlqxe1Af+QA57QHZJHgQH7LOkhSIBeX/OHGG0bYQmc7I9gu3FMRSosjbtZy/Iu68JvfFwpxnXsnjArcxs+kktJLwlSlMOW68m8c9dM2rh2MJemB+KSnqijMqXz7BRiEOvDzvTq74mBTWnCpO0vwubuw9qmcoZ1PvP8WOhT110nR7LGtUcxutGbcIXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rt4GDwX0uSJA1Mt1O70aYfrl0FxaEVau1g2D5Gedf3c=;
 b=jJo9vcJqwEl64aQWbC148InEW/LWxKVI8fH9RyhWS8RGmGw0gwg++DcZSOjczCSktdcqXtJmPiPp9TgsQEAdNas9h761vG1lI7Kja0AmywYv98XWAZ41bcIsJX31w/YstFkBDbzl8xbDpTZYcFFG1LOjRzhGqrRU1/nQVPoCAAzjcUrDC0DUTk2MDryfghk3dM643ewmIUuKQVzW/F9q9u4CdAUbaa7h/s8bBevw8qPcuuEt5UyJSjwq6Q3kiTy7OeFAcobyEhQmQCMfPpytigISH8uRBpjvNpfQK9AdPNRn8P5tN34nAAN7jaNa4blQr7U2Adj4m45O0TztGpTnVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rt4GDwX0uSJA1Mt1O70aYfrl0FxaEVau1g2D5Gedf3c=;
 b=rpDJdbcaz6ADXChZauVkNcaI1UaijGgelbHLjNqvxoVorE/wLtubHUtvK8mqDui/WCQxqT7Fyeo+zQl4wmgObFrRFZ5iTNisKdJoy7OA1tyYB/8l87iI0P3BXDtxCj2msdiWfnW2+S6R2Kmccgtx466Chw0UahzFb+wx6ubBd8w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 by BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 05:27:26 +0000
Received: from BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::1852:d129:e9ca:ebd4]) by BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::1852:d129:e9ca:ebd4%5]) with mapi id 15.20.3305.025; Thu, 20 Aug 2020
 05:27:26 +0000
From: Shashank Sharma <shashank.sharma@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v5] drm/amdgpu: add new trace event for page table update
Date: Thu, 20 Aug 2020 10:57:04 +0530
Message-Id: <20200820052705.14468-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: MA1PR01CA0158.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::28) To BYAPR12MB3126.namprd12.prod.outlook.com
 (2603:10b6:a03:df::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 MA1PR01CA0158.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 05:27:24 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [106.51.110.102]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 11f11408-f6d7-4e26-de5a-08d844c9b934
X-MS-TrafficTypeDiagnostic: BY5PR12MB4146:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB41467DC71C5CD16801B2014CF25A0@BY5PR12MB4146.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j0Ck/TSI+y3es/VXO7pyg1KHCYvUi/fjd/l5CW3r5+qzlq2R35f44AYpEP1cMOe99RB21gR+4QRxe5zwY+7hfyf9KB0WrgbtRi5lOfBGMmcOYS4iOUlL2cjPOckzGt0bhAyAbCsSFN3b0eCCYDu+zYzgLEcDWvz8KQPicFjgU6vw2SSQINzAWFFxPeXxaO4+ztBXXLyRSnXMFs95RF09LqEhUW3ECqgOwtBSpVVaf3CPatE7cymhJDrgX00TAmKhRv74ryhaxuJ0rmnPUNOYU/NWn1HTpjdj0cspxW21NdBc7S5aWr6IWi88k9rKPzpWjBqlVptl2lFITRNs6nvTNubCiUBcjXqMy+Jxf5tELKfoaWbWsKT7YicbxooK0fBx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(8936002)(316002)(55236004)(36756003)(66574015)(2616005)(83380400001)(26005)(52116002)(6916009)(110011004)(16576012)(44832011)(186003)(956004)(4326008)(54906003)(15650500001)(6486002)(2906002)(66556008)(8676002)(66946007)(478600001)(66476007)(86362001)(1076003)(6666004)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: a60Ezn2R8z8YHv2/YjCoCbpxiX0tbjKZ4esmrp6EL/KUOC/2wdzuqRl9U+Ybd6mObtsGhp3Wxmp3rku2sFruY38PKz5ADNBpwAsewgHHvUK1akVPzeq42Ed6eTOW1XDVLv8hXNWxvuqX2NF+qJYcRdPSZxn9DVnq4nqmrXDe4PP+5TSwwRsrN8FbTUOUifGAwqlB+NTxST0InMhRrNVcaMQPt+C5OxF7S+jJ3+lO7cmxEf4Kw76UuiiYXL8533q6TSDCyrYS82GHcuzmPIqe+kWG2S65RDzHns8pxRpkoD2QG9e7X7nqyvGVeO+j0vQpSjdYjhlSXP+XXpzUNuMl/B7G7rhIp4JpaaNceO1qGKaITEugxNT79kK2FNUcdWDJtAAKyC/eEFP0WOZg1excmFdnHPMvC8taXjAAVTcDb7O55WjsycpdOzSa3eOt5B9d4b5E/Sn6EefYhI9MgdgUV9jLZ7DB8qG/BsycQiI5honqeyZ8Tj0AIj2OzFAD2flyCr7gzeqYGdas77TWv+7N1uWFeY07+RzsM6QV6lJF0TPKRkWtCWHSc5OlbTp7BUjYP2hHslVjKMYqUwhy6lQqTNDQvy81c5fhqNpVMDaAI9OaeCCD84UOHlvlB6isAaug45F10Ke42CJptl1GWP7kmg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f11408-f6d7-4e26-de5a-08d844c9b934
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 05:27:26.2878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ESHoCGANrWrUSdwcJvzC50TWwf4Z8wJ1/YFv+QwC50OfuRNnJ0BJtkK5/gaNWZpJ1ev0KHmZQab1rhx38YQXSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146
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
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBwYXRjaCBhZGRzIGEgbmV3IHRyYWNlIGV2ZW50IHRvIHRyYWNrIHRoZSBQVEUgdXBkYXRl
CmV2ZW50cy4gVGhpcyBzcGVjaWZpYyBldmVudCB3aWxsIHByb3ZpZGUgaW5mb3JtYXRpb24gbGlr
ZToKLSBzdGFydCBhbmQgZW5kIG9mIHZpcnR1YWwgbWVtb3J5IG1hcHBpbmcKLSBIVyBlbmdpbmUg
ZmxhZ3MgZm9yIHRoZSBtYXAKLSBwaHlzaWNhbCBhZGRyZXNzIGZvciBtYXBwaW5nCgpUaGlzIHdp
bGwgYmUgcGFydGljdWxhcmx5IHVzZWZ1bCBmb3IgbWVtb3J5IHByb2ZpbGluZyB0b29scwoobGlr
ZSBSTVYpIHdoaWNoIGFyZSBtb25pdG9yaW5nIHRoZSBwYWdlIHRhYmxlIHVwZGF0ZSBldmVudHMu
CgpWMjogQWRkZWQgcGh5c2ljYWwgYWRkcmVzcyBsb29rdXAgbG9naWMgaW4gdHJhY2UgcG9pbnQK
VjM6IHN3aXRjaCB0byB1c2UgX19keW5hbWljX2FycmF5CiAgICBhZGRlZCBucHRlcyBpbnQgdGhl
IFRQcHJpbnQgYXJndW1lbnRzIGxpc3QKICAgIGFkZGVkIHBhZ2Ugc2l6ZSBpbiB0aGUgYXJnIGxp
c3QKVjQ6IEFkZHJlc3NlZCBDaHJpc3RpYW4ncyByZXZpZXcgY29tbWVudHMKICAgIGFkZCBzdGFy
dC9lbmQgaW5zdGVhZCBvZiBzZWcKICAgIHVzZSBpbmNyIGluc3RlYWQgb2YgcGFnZV9zeiB0byBi
ZSBhY2N1cmF0ZQpWNTogQWRkcmVzc2VkIENocmlzdGlhbidzIHJldmlldyBjb21tZW50czoKICAg
IGFkZCBwaWQgYW5kIHZtIGNvbnRleHQgaW5mb3JtYXRpb24gaW4gdGhlIGV2ZW50CgpDYzogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogQWxleCBEZXVjaGVy
IDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IFNoYXNoYW5rIFNo
YXJtYSA8c2hhc2hhbmsuc2hhcm1hQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3RyYWNlLmggfCA0MyArKysrKysrKysrKysrKysrKysrKysrKwogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgICAgfCAxMSArKysrLS0KIDIgZmlsZXMg
Y2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHJhY2UuaCBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oCmluZGV4IDYzZTczNGExMjVmYi4uMDI0MDZmYzZk
YjBmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHJhY2Uu
aAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHJhY2UuaApAQCAtMzIx
LDYgKzMyMSw0OSBAQCBERUZJTkVfRVZFTlQoYW1kZ3B1X3ZtX21hcHBpbmcsIGFtZGdwdV92bV9i
b19jcywKIAkgICAgVFBfQVJHUyhtYXBwaW5nKQogKTsKIAorVFJBQ0VfRVZFTlQoYW1kZ3B1X3Zt
X3VwZGF0ZV9wdGVzLAorCSAgICBUUF9QUk9UTyhzdHJ1Y3QgYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJh
bXMgKnAsCisJCSAgICAgdWludDY0X3Qgc3RhcnQsIHVpbnQ2NF90IGVuZCwKKwkJICAgICB1bnNp
Z25lZCBpbnQgbnB0ZXMsIHVpbnQ2NF90IGRzdCwKKwkJICAgICB1aW50NjRfdCBpbmNyLCB1aW50
NjRfdCBmbGFncywKKwkJICAgICB1aW50NjRfdCBwaWQsIHVpbnQ2NF90IHZtX2N0eCksCisJVFBf
QVJHUyhwLCBzdGFydCwgZW5kLCBucHRlcywgZHN0LCBpbmNyLCBmbGFncywgcGlkLCB2bV9jdHgp
LAorCVRQX1NUUlVDVF9fZW50cnkoCisJCQkgX19maWVsZCh1NjQsIHN0YXJ0KQorCQkJIF9fZmll
bGQodTY0LCBlbmQpCisJCQkgX19maWVsZCh1NjQsIGZsYWdzKQorCQkJIF9fZmllbGQodW5zaWdu
ZWQgaW50LCBucHRlcykKKwkJCSBfX2ZpZWxkKHU2NCwgaW5jcikKKwkJCSBfX2ZpZWxkKHU2NCwg
cGlkKQorCQkJIF9fZmllbGQodTY0LCB2bV9jdHgpCisJCQkgX19keW5hbWljX2FycmF5KHU2NCwg
ZHN0LCBucHRlcykKKwkpLAorCisJVFBfZmFzdF9hc3NpZ24oCisJCQl1bnNpZ25lZCBpbnQgaTsK
KworCQkJX19lbnRyeS0+c3RhcnQgPSBzdGFydDsKKwkJCV9fZW50cnktPmVuZCA9IGVuZDsKKwkJ
CV9fZW50cnktPmZsYWdzID0gZmxhZ3M7CisJCQlfX2VudHJ5LT5pbmNyID0gaW5jcjsKKwkJCV9f
ZW50cnktPm5wdGVzID0gbnB0ZXM7CisJCQlfX2VudHJ5LT5waWQgPSBwaWQ7CisJCQlfX2VudHJ5
LT52bV9jdHggPSB2bV9jdHg7CisJCQlmb3IgKGkgPSAwOyBpIDwgbnB0ZXM7ICsraSkgeworCQkJ
CXU2NCBhZGRyID0gcC0+cGFnZXNfYWRkciA/IGFtZGdwdV92bV9tYXBfZ2FydCgKKwkJCQkJcC0+
cGFnZXNfYWRkciwgZHN0KSA6IGRzdDsKKworCQkJCSgodTY0ICopX19nZXRfZHluYW1pY19hcnJh
eShkc3QpKVtpXSA9IGFkZHI7CisJCQkJZHN0ICs9IGluY3I7CisJCQl9CisJKSwKKwlUUF9wcmlu
dGsoInN0YXJ0OjB4JTAxMGxseCBlbmQ6MHglMDEwbGx4LCBmbGFnczoweCVsbHgsIGluY3I6JWxs
dSwiCisJCSAgIiBwaWQ6JWxsZCB2bV9jdHg6MHglbGx4IGRzdDpcbiVzIiwgX19lbnRyeS0+c3Rh
cnQsCisJCSAgX19lbnRyeS0+ZW5kLCBfX2VudHJ5LT5mbGFncywgX19lbnRyeS0+aW5jciwgX19l
bnRyeS0+cGlkLAorCQkgIF9fZW50cnktPnZtX2N0eCwgX19wcmludF9hcnJheShfX2dldF9keW5h
bWljX2FycmF5KGRzdCksCisJCSAgX19lbnRyeS0+bnB0ZXMsIDgpKQorKTsKKwogVFJBQ0VfRVZF
TlQoYW1kZ3B1X3ZtX3NldF9wdGVzLAogCSAgICBUUF9QUk9UTyh1aW50NjRfdCBwZSwgdWludDY0
X3QgYWRkciwgdW5zaWduZWQgY291bnQsCiAJCSAgICAgdWludDMyX3QgaW5jciwgdWludDY0X3Qg
ZmxhZ3MsIGJvb2wgZGlyZWN0KSwKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMK
aW5kZXggOGJjMjI1MzkzOWJlLi4zZDI1NzM5YjQxNTggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jCkBAIC0xNTExLDE5ICsxNTExLDI2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1
X3ZtX3VwZGF0ZV9wdGVzKHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcGFyYW1zLAog
CQllbnRyeV9lbmQgPSBtaW4oZW50cnlfZW5kLCBlbmQpOwogCiAJCWRvIHsKKwkJCXN0cnVjdCBh
bWRncHVfdm0gKnZtID0gcGFyYW1zLT52bTsKIAkJCXVpbnQ2NF90IHVwZF9lbmQgPSBtaW4oZW50
cnlfZW5kLCBmcmFnX2VuZCk7CiAJCQl1bnNpZ25lZCBucHRlcyA9ICh1cGRfZW5kIC0gZnJhZ19z
dGFydCkgPj4gc2hpZnQ7CisJCQl1aW50NjRfdCB1cGRfZmxhZ3MgPSBmbGFncyB8IEFNREdQVV9Q
VEVfRlJBRyhmcmFnKTsKIAogCQkJLyogVGhpcyBjYW4gaGFwcGVuIHdoZW4gd2Ugc2V0IGhpZ2hl
ciBsZXZlbCBQRHMgdG8KIAkJCSAqIHNpbGVudCB0byBzdG9wIGZhdWx0IGZsb29kcy4KIAkJCSAq
LwogCQkJbnB0ZXMgPSBtYXgobnB0ZXMsIDF1KTsKKworCQkJdHJhY2VfYW1kZ3B1X3ZtX3VwZGF0
ZV9wdGVzKHBhcmFtcywgZnJhZ19zdGFydCwgdXBkX2VuZCwKKwkJCQkJCSAgICBucHRlcywgZHN0
LCBpbmNyLCB1cGRfZmxhZ3MsCisJCQkJCQkgICAgdm0tPnRhc2tfaW5mby5waWQsCisJCQkJCQkg
ICAgdm0tPmltbWVkaWF0ZS5mZW5jZV9jb250ZXh0KTsKIAkJCWFtZGdwdV92bV91cGRhdGVfZmxh
Z3MocGFyYW1zLCBwdCwgY3Vyc29yLmxldmVsLAogCQkJCQkgICAgICAgcGVfc3RhcnQsIGRzdCwg
bnB0ZXMsIGluY3IsCi0JCQkJCSAgICAgICBmbGFncyB8IEFNREdQVV9QVEVfRlJBRyhmcmFnKSk7
CisJCQkJCSAgICAgICB1cGRfZmxhZ3MpOwogCiAJCQlwZV9zdGFydCArPSBucHRlcyAqIDg7Ci0J
CQlkc3QgKz0gKHVpbnQ2NF90KW5wdGVzICogQU1ER1BVX0dQVV9QQUdFX1NJWkUgPDwgc2hpZnQ7
CisJCQlkc3QgKz0gbnB0ZXMgKiBpbmNyOwogCiAJCQlmcmFnX3N0YXJ0ID0gdXBkX2VuZDsKIAkJ
CWlmIChmcmFnX3N0YXJ0ID49IGZyYWdfZW5kKSB7Ci0tIAoyLjI1LjEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
