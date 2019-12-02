Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CE0C432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:36:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FCD220848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FCD220848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF84F6E2D7;
	Mon,  2 Dec 2019 17:36:02 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800051.outbound.protection.outlook.com [40.107.80.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 908356E2E6
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkIPYlEogFkcsYM0NGjvamwrVA/AvIl2A+k/xPcuzdHpH74EPmeEBtFnv4N8Ja1UkMq/H8+cy4IGo4UJi/vdNfKYD+yBJ6BQewvSYmJlKxh4UjqJtRAvjMFoI8PcOJrZpYfl2y1Fqx/ZkXASA+PKD1egc7UxCcNlfpm6L4MPle2jL5vPDx0K+QdYybYzz4vYntLwAtuPB0PbEf6mRTK5pYPfHl4PFyReEqOvQ2x9waiHXyVUZOj5H87Y6utjb30KvkRgQnAUEPoOoE3tSOtDSUT5Li7Q67KMiYNdY2aq6fdrnooxHP5AasHBzwObjGq8lRQ1C/hjvMnpJdeVrrbW2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkiEPMQ0gzMbGB8ltPhHzg+fF7ZhwMbqUTWxOA/W+Mo=;
 b=boJ43LJKEx/Owkh61ME1gkPKhOn1VXTRziwPXUC3fYfaP2ldCEkihqri2uHDNeokNZ7xK95XhOIq75VRA7fPsU7PoSV+PSEmrf0vuszrULMIuuWAZin34K5yRcK5Kif4AtVYDgROM+jkeeLGTQi7ma62vCnQGqxb4twODujqHpalHNGYZl8S5l2fBys7vTdhmBYMywwMgfX7sAwuMHnYWAJJdvnpSFoInW7o+Wd/T0cKi+KIS3wXcyhA0pyrN80k00UKFaccYgx74VnsKsIS3cD8MPohzgVWjIrgpYH1F2d8G18o0D3qMm0cHFx81OKTdFqoenB9S8oyoCkU/Hg/xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2610.namprd12.prod.outlook.com (20.176.26.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:35:58 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:35:57 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 50/51] drm/amd/display: correct log message for lttpr
Date: Mon,  2 Dec 2019 12:34:04 -0500
Message-Id: <20191202173405.31582-51-sunpeng.li@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 449f3cc3-d7e8-4471-cee9-08d7774e07f2
X-MS-TrafficTypeDiagnostic: BN7PR12MB2610:|BN7PR12MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2610EBCCC6166E7BF93B7E9882430@BN7PR12MB2610.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:233;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(189003)(199004)(76176011)(6666004)(51416003)(52116002)(6512007)(66476007)(66556008)(15650500001)(316002)(50226002)(5660300002)(6916009)(81166006)(26005)(2616005)(99286004)(386003)(6506007)(1076003)(8936002)(11346002)(305945005)(446003)(81156014)(186003)(9686003)(6436002)(4326008)(8676002)(6486002)(7736002)(66946007)(54906003)(14444005)(48376002)(50466002)(86362001)(6116002)(2351001)(3846002)(2906002)(25786009)(36756003)(66066001)(2870700001)(2361001)(14454004)(478600001)(47776003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2610;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lyHNwMgRHlChECy5kT0SPRwNu8zx0GaR155Kvp1ePv0bWdE4JddgzazJFn/vizwDht/rUKSP1dQMNGWld2Op1UNxnirSsL+5SRioUjfoxaTWmd85JrsE70i18aa2FiQ9wIAAAfXOk+EAGkaO4zBnQ9Ryf/v8zUB8HCUkHKz+oOnv57iiRHXYRa1sYDJypXITOizDBO+vtXoSwOM0H5xnRmFJXitAV08AdpU+aECkUAbN9STgoYFVxN+kaNud6GglEZ2x55SVr3wm3Lj+NrSepAkn/bxCQ5iLC32DqdwebtCvYw6UzbWhNxl5TTD1f5UuGbe0neEk1yEriSJPZXqNbgt/ZEE6xUWty4Sn0J663W6yWf7MLy6E4gLCivefjjpeKeylyUHqt9st4TELQmjOAhUX9S/Q+qGHar/Nxd49vb0TkIPDC/B57mRGMneIGyOV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 449f3cc3-d7e8-4471-cee9-08d7774e07f2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:35:32.3050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUPuvfd6XyazzDIdYntI3LKHsI/g/kNrgA4qWZgxX+221SdZX9Ez2StRrZcvC729
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2610
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkiEPMQ0gzMbGB8ltPhHzg+fF7ZhwMbqUTWxOA/W+Mo=;
 b=qcfWJ4o13/IDxNXIe5w5oXxbw1MN6DtcgcewxZQX4C+opKABwQnJnE4eXO6qeabPXjYBEbCYQWYbTmRiooGPnSCPHTnAVD3AmlbzeAJtwbTUafaNQJAz9kbMA3b5T09l3Ltq/MQJ+8rga98UH+lggjPAsWhsD09O0WSLaEngldI=
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
 rodrigo.siqueira@amd.com, abdoulaye berthe <abdoulaye.berthe@amd.com>,
 George Shen <George.Shen@amd.com>, bhawanpreet.lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogYWJkb3VsYXllIGJlcnRoZSA8YWJkb3VsYXllLmJlcnRoZUBhbWQuY29tPgoKW1doeV0K
V2hlbiBzZXR0aW5nIGx0dHByIG1vZGUsIHRoZSBuZXcgbW9kZSB0byBiZXQgaXMgbm90IGxvZ2dl
ZCBwcm9wZXJseS4KCltIb3ddClVwZGF0ZSBsb2cgbWVzc2FnZSB0byBzaG93IHRoZSByaWdodCBt
b2RlLgoKU2lnbmVkLW9mZi1ieTogYWJkb3VsYXllIGJlcnRoZSA8YWJkb3VsYXllLmJlcnRoZUBh
bWQuY29tPgpSZXZpZXdlZC1ieTogR2VvcmdlIFNoZW4gPEdlb3JnZS5TaGVuQGFtZC5jb20+CkFj
a2VkLWJ5OiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rX2RwLmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kcC5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kcC5jCmluZGV4IGRmY2Q2NDIxZWUwMS4uNDJh
YTg4OWZkMGY1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29y
ZS9kY19saW5rX2RwLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUv
ZGNfbGlua19kcC5jCkBAIC0xMjE5LDcgKzEyMTksNyBAQCBzdGF0aWMgdm9pZCBjb25maWd1cmVf
bHR0cHJfbW9kZShzdHJ1Y3QgZGNfbGluayAqbGluaykKIAl1aW50OF90IHJlcGVhdGVyX2lkOwog
CXVpbnQ4X3QgcmVwZWF0ZXJfbW9kZSA9IERQX1BIWV9SRVBFQVRFUl9NT0RFX1RSQU5TUEFSRU5U
OwogCi0JRENfTE9HX0hXX0xJTktfVFJBSU5JTkcoIiVzXG4gU2V0IExUVFBSIHRvIE5vbiBUcmFu
c3BhcmVudCBNb2RlXG4iLCBfX2Z1bmNfXyk7CisJRENfTE9HX0hXX0xJTktfVFJBSU5JTkcoIiVz
XG4gU2V0IExUVFBSIHRvIFRyYW5zcGFyZW50IE1vZGVcbiIsIF9fZnVuY19fKTsKIAljb3JlX2xp
bmtfd3JpdGVfZHBjZChsaW5rLAogCQkJRFBfUEhZX1JFUEVBVEVSX01PREUsCiAJCQkodWludDhf
dCAqKSZyZXBlYXRlcl9tb2RlLApAQCAtMTIyNyw3ICsxMjI3LDcgQEAgc3RhdGljIHZvaWQgY29u
ZmlndXJlX2x0dHByX21vZGUoc3RydWN0IGRjX2xpbmsgKmxpbmspCiAKIAlpZiAoIWxpbmstPmlz
X2x0dHByX21vZGVfdHJhbnNwYXJlbnQpIHsKIAotCQlEQ19MT0dfSFdfTElOS19UUkFJTklORygi
JXNcbiBTZXQgTFRUUFIgdG8gVHJhbnNwYXJlbnQgTW9kZVxuIiwgX19mdW5jX18pOworCQlEQ19M
T0dfSFdfTElOS19UUkFJTklORygiJXNcbiBTZXQgTFRUUFIgdG8gTm9uIFRyYW5zcGFyZW50IE1v
ZGVcbiIsIF9fZnVuY19fKTsKIAogCQlyZXBlYXRlcl9tb2RlID0gRFBfUEhZX1JFUEVBVEVSX01P
REVfTk9OX1RSQU5TUEFSRU5UOwogCQljb3JlX2xpbmtfd3JpdGVfZHBjZChsaW5rLAotLSAKMi4y
NC4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
