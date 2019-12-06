Return-Path: <SRS0=UM6f=Z4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B582BC2D0B1
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 04:32:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9069021823
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 04:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9069021823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EEC76F95C;
	Fri,  6 Dec 2019 04:32:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A01FD6F96D
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2019 04:32:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVQz2bNq7HEBEDdnRBd7C3reB/jfX9+G6DxC2yCQi5QPTHRmREOLqneTmpzEUC6M/4qPw0fNSQ2W18DW5zsis5vFHNs78WIt+62N3HT5hafSTUEuR3O6HCst0mBRsn7TgjtQlN25txtVlFxcdhIhUzFpQ5OQmqZbQxN/K/XA58ffSvIR+Brh+tVbmBVp7wXYo81pbCjEVXcxEgl/I8hjfcE1cO47wmFEgCZa6ycfEb8BG8sQW4nxHWurBRltuHmUAvKsbPRv8z0yb6uBsyGNCPJsITmIS6guawcu54Fb5fTwwfovVZ16kwPLDw15X1I8IcXUmbam5FrKhtlrRKLYYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gjuw+5S0ciLDUrzeZoTXxbxS3M7e1J8uaXpQM46F5AY=;
 b=lMAhcFl1boJtaOqtfyc8GwjMnvscGOoj51DUyTVYiEEqMlXbmk+fHG+wgQU6ZSgGbUXLTJN6fDdE3sYKhIOavc8Xa3HLDS8H+iQMxlKive5EYai/DooKXp1UTHDMNRR77YBdV6c+QUiQMWUT7ZiA2Yi8sj1fs1cKZeWOTsaXRXqy2jY0xr2z54NxTRBRk8HK8KS0HybDJ9XeRKzwvjglC/HNs7w95xd+4fhkMKQmJnfOKVm0d7N3eiGoxFjWPRtCXOem0aqQxZBL4JRLU9G5pAcz6hn0iYUjn2g4E/kzECc6oEAFEaCZeTwQgINhbThYjCbrzHM56foodpiim6aq/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.29.90) by
 DM6PR12MB3483.namprd12.prod.outlook.com (20.178.31.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Fri, 6 Dec 2019 04:32:37 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::71fe:9848:c834:1cd6]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::71fe:9848:c834:1cd6%3]) with mapi id 15.20.2516.014; Fri, 6 Dec 2019
 04:32:37 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] tests/amdgpu: Fix unused function warning
Date: Thu,  5 Dec 2019 23:32:17 -0500
Message-Id: <ef63cf555221724a49c7f926c57786cae559fe77.1575606273.git.luben.tuikov@amd.com>
X-Mailer: git-send-email 2.24.0.155.gd9f6f3b619
In-Reply-To: <f57d33f459df0c733ef108b2beb889e844450542.1575606273.git.luben.tuikov@amd.com>
References: <f57d33f459df0c733ef108b2beb889e844450542.1575606273.git.luben.tuikov@amd.com>
X-ClientProxiedBy: YTOPR0101CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::43) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0.155.gd9f6f3b619
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 44d13e24-9f86-4fc1-74f3-08d77a055264
X-MS-TrafficTypeDiagnostic: DM6PR12MB3483:|DM6PR12MB3483:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB348357A57A77036B8BE4398C995F0@DM6PR12MB3483.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-Forefront-PRVS: 0243E5FD68
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(189003)(199004)(66946007)(478600001)(316002)(2870700001)(8936002)(86362001)(54906003)(118296001)(4744005)(36756003)(81166006)(5660300002)(14454004)(81156014)(50226002)(25786009)(305945005)(2906002)(48376002)(6916009)(44832011)(50466002)(8676002)(6486002)(66476007)(51416003)(26005)(11346002)(6666004)(4326008)(14444005)(6512007)(2616005)(76176011)(66556008)(99286004)(186003)(6506007)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3483;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 54jCRVpLtFtCAjfUuI1FXXOGGct3ugG9dHa1ejuH9xQKhDQ60PCF1XdplJgjPYn/oONKJJGPCUcedTqyptoDmZgIVrY8aKTStRI5IQPf6+vlltsmWXcWpf0NrCisJwx39ZrGVTzP+SLGq7QspckkA7R/HW9G07fMGR45YnsCkWhLagocYSCwPXrkCiXfSRsjon+DUFMO7sr0RSJaFYjuyyS8c4RZBNIivP0/AWqqyumQ1LBqxxuAocHB1glQazM1n2IJFTsUfeQ9RfqSDht9uP/6sBMTmw4cE9haBjCAkDhRR/hziO+7rRkb9MresbxVcV18MZM7gio0QtVNdH21sT+iu5OTnPdM37xRiyY0EGn1lEAYPb6kmChj3GKeVPPhcVd1CLegQEtte61N0ExF3Q1n3CNmyiBjXea96a4BaqRFeKlFO7rItRpc89E4LkJg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d13e24-9f86-4fc1-74f3-08d77a055264
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2019 04:32:37.4013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCa1evi3IeDeV+/o+/o3nzQQtrg93P+ngptpJS2nVbw5Ht3MnuT1fx7Avzc0LGWw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3483
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gjuw+5S0ciLDUrzeZoTXxbxS3M7e1J8uaXpQM46F5AY=;
 b=2gEoFL2pBSXhP23bS4iIuKMXSrjQBD2XPagcbPnbsHXttEXgC1Bik7Q0nEq4MC+ypLTV6fR4fBY37tZ6VBJtdNroZXNOcATXKad6hhctUkT63OlHja4dAMjE15o2zIR6uehn+GM1Myso20GbxFEE88Pzu/1L4RS+Iog8nS8+cuI=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBwYXRjaCBmaXhlczoKLVd1bnVzZWQtZnVuY3Rpb24KClNpZ25lZC1vZmYtYnk6IEx1YmVu
IFR1aWtvdiA8bHViZW4udHVpa292QGFtZC5jb20+Ci0tLQogdGVzdHMvYW1kZ3B1L3Jhc190ZXN0
cy5jIHwgNCArKystCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvdGVzdHMvYW1kZ3B1L3Jhc190ZXN0cy5jIGIvdGVzdHMvYW1kZ3B1
L3Jhc190ZXN0cy5jCmluZGV4IGQ3MTRiZTczLi40YzM5NTM4MiAxMDA2NDQKLS0tIGEvdGVzdHMv
YW1kZ3B1L3Jhc190ZXN0cy5jCisrKyBiL3Rlc3RzL2FtZGdwdS9yYXNfdGVzdHMuYwpAQCAtNzA5
LDYgKzcwOSw3IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9yYXNfZGlzYWJsZV90ZXN0KHZvaWQpCiAJ
fQogfQogCisjaWZkZWYgQU1ER1BVX1JBU19URVNUCiBzdGF0aWMgdm9pZCBhbWRncHVfcmFzX2Vu
YWJsZV90ZXN0KHZvaWQpCiB7CiAJaW50IGk7CkBAIC03MTcsNiArNzE4LDcgQEAgc3RhdGljIHZv
aWQgYW1kZ3B1X3Jhc19lbmFibGVfdGVzdCh2b2lkKQogCQlhbWRncHVfcmFzX2ZlYXR1cmVzX3Rl
c3QoMSk7CiAJfQogfQorI2VuZGlmCiAKIHN0YXRpYyB2b2lkIF9fYW1kZ3B1X3Jhc19pcF9pbmpl
Y3RfdGVzdChjb25zdCBzdHJ1Y3QgcmFzX2luamVjdF90ZXN0X2NvbmZpZyAqaXBfdGVzdCwKIAkJ
CQkJdWludDMyX3Qgc2l6ZSkKQEAgLTg4MSw3ICs4ODMsNyBAQCBDVV9UZXN0SW5mbyByYXNfdGVz
dHNbXSA9IHsKIAl7ICJyYXMgcXVlcnkgdGVzdCIsCWFtZGdwdV9yYXNfcXVlcnlfdGVzdCB9LAog
CXsgInJhcyBpbmplY3QgdGVzdCIsCWFtZGdwdV9yYXNfaW5qZWN0X3Rlc3QgfSwKIAl7ICJyYXMg
ZGlzYWJsZSB0ZXN0IiwJYW1kZ3B1X3Jhc19kaXNhYmxlX3Rlc3QgfSwKLSNpZiAwCisjaWZkZWYg
QU1ER1BVX1JBU19URVNUCiAJeyAicmFzIGVuYWJsZSB0ZXN0IiwJYW1kZ3B1X3Jhc19lbmFibGVf
dGVzdCB9LAogI2VuZGlmCiAJQ1VfVEVTVF9JTkZPX05VTEwsCi0tIAoyLjI0LjAuMTU1LmdkOWY2
ZjNiNjE5CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
