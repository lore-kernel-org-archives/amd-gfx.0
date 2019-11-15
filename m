Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED50C43215
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 03:35:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D03620709
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 03:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D03620709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A41C6F3F2;
	Fri, 15 Nov 2019 03:35:49 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690064.outbound.protection.outlook.com [40.107.69.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DDCE6F3F1
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 03:35:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fY9QfdTdQt+92CVjkCTfT1lCLYlRrrshSwACclRHx/oDOgG3zvrlxJNHVtHIr16CJYrc3hwRH8t06IODLEqBRcL8V/E8U5zZtAdt/HpZeTrbo9zZoBOWuSbsqvBijQE90aoVHbbCHfejwrbvv7bWA9z1jzs0bSFektQq+5WZ6/gMOspDKrdAPWmGrwA33hF7TR5sUMhz4b6hb8bpfHYCHvYW0pJZOYSgHJMZ6Q7WvCyZbfsSM9iERtW+YvQsjGqpo+J0sCu//KTY4yV+7NJ38xxB3OzFXMYHeJax2m45Ntz8wJqPHjA31LxFuH0DHBlN0RzqP4zB87yWxGoL2Lp2iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkqZYmgYVI/P+WEOmw/b19c1GMIcSESLK8MANe5Rsho=;
 b=W7ZR1e+nunhszJx2yBLZJG6cPprcZFkKFBUH6fK5mpvHzc3KkDvZSTaZuF4SSW84gHv3o/T1g+TEf4xQZbvV+1sZamxdDfW2h/0lEle8n1R2LuGf/u0FpwmY9tO3Qqf+NPJZnfWhmLz85NJIX3WXdqYKlE4CxagyA98e8VT877lAFUsfW7cpFxtYQAcCitFFqBmC8s18plvgzzMz3nYKcM4+nDUpRtsFjlYuVyqOmph1JQ591iN/opa9m5vGKOsBjdXUBa0ZNxB3FjyTnDNq/DSd5XMw2wqOlz9DRbFAiPmrMQlOfv7MTY3fQD7l62+5vqPYWXCXqwy+vHHGJopRNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3838.namprd12.prod.outlook.com (10.255.238.203) by
 MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 03:35:46 +0000
Received: from MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4]) by MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4%7]) with mapi id 15.20.2451.027; Fri, 15 Nov 2019
 03:35:46 +0000
From: Aaron Liu <aaron.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/12] tests/amdgpu: add test to submit a gfx command with
 secure context
Date: Fri, 15 Nov 2019 11:34:53 +0800
Message-Id: <1573788895-3936-10-git-send-email-aaron.liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
X-ClientProxiedBy: HK0PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:203:36::18) To MN2PR12MB3838.namprd12.prod.outlook.com
 (2603:10b6:208:16c::11)
MIME-Version: 1.0
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eb3d7e31-c7a6-4894-bf7f-08d7697ce676
X-MS-TrafficTypeDiagnostic: MN2PR12MB3663:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3663FD89531059E3B876FA1BF0700@MN2PR12MB3663.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 02229A4115
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(51416003)(52116002)(6512007)(76176011)(7736002)(386003)(26005)(11346002)(44832011)(486006)(4326008)(2616005)(25786009)(6506007)(6436002)(6486002)(5660300002)(478600001)(66556008)(446003)(186003)(86362001)(3846002)(6116002)(14454004)(48376002)(50466002)(66946007)(8936002)(50226002)(305945005)(66476007)(476003)(81156014)(81166006)(8676002)(2906002)(6916009)(16586007)(66066001)(14444005)(316002)(2351001)(2361001)(47776003)(6666004)(36756003)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3663;
 H:MN2PR12MB3838.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m74Hk/XLF7lMYYYj5EoaTScY07tdwrC2cmqENk3xdp4myiijoA6NqqiDgXYbMFiybBVjXTKplHt9VYns168bQ3LtpgVRukALPMhTsqTa/Kuxc/kV3wHIBANLUrMYTlhQm93mrX6qrtvi78IJOzJnIc3CZH4BCI1b+6PzXp5sudjraRkwkKwL4f3GcvVpX+wc4owCwm2kn+Q3RrUI3vIURDBh3vvA+fvzzT0UKMfBsXf3PgQ06aGnTTreQOEaWQG0QhFonBLyBcNQdzZRERmter9eiR0YhqYUgSSYCQa0RMbzf5hsnQJ0Hy+ULVBBzlrbmkx3Rab4tGMgR9Yqu0pEddUeRECBYZOcPK3It+QDbtHglapuXxNLShBKyjt1e/xOx3rUdif9KXx0jJC8xXJ6csVVHCZdz5aU9dpa5hfbyVL6XEbo7RyHrRfc9DIBTCSW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3d7e31-c7a6-4894-bf7f-08d7697ce676
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 03:35:46.4034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+nb6omhowrvKV6OCs67+tqTsFPBq6Lrl/k7jnlcFNImENmltd0iGAyoKYwf4dLH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3663
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkqZYmgYVI/P+WEOmw/b19c1GMIcSESLK8MANe5Rsho=;
 b=PTR9VhdVp/ceKCEOgamjGjS5TZ1BO/3ZuykIeQTbIOmr1w75atisPJIR1i68imEMGf2j1KGAjrynZwVWXL5MNTB2qO/4NZYkuYedN0IW3BXZUYjRDwScEgiuqCuYssfdZ1lXrnipW2dKh3AYG1ek6P5vI8lCxnRLpd3xcPcDs0c=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Aaron.Liu@amd.com; 
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
Cc: Marek.Olsak@amd.com, Ray.Huang@amd.com, Aaron Liu <aaron.liu@amd.com>,
 Luben.Tuikov@amd.com, Alexander.Deucher@amd.com, Leo.Liu@amd.com,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115033453.qu27BrTvVDAbcnCqiIbsaU85npLfd2XzErZSg210vQo@z>

VGhpcyBwYXRjaCBpcyB0byB0ZXN0IHRoZSBjb21tYW5kIHN1Ym1pc3Npb24gd2l0aCBzZWN1cmUg
Y29udGV4dC4KClNpZ25lZC1vZmYtYnk6IEFhcm9uIExpdSA8YWFyb24ubGl1QGFtZC5jb20+Ci0t
LQogdGVzdHMvYW1kZ3B1L3NlY3VyaXR5X3Rlc3RzLmMgfCA5ICsrKysrKysrKwogMSBmaWxlIGNo
YW5nZWQsIDkgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL2FtZGdwdS9zZWN1cml0
eV90ZXN0cy5jIGIvdGVzdHMvYW1kZ3B1L3NlY3VyaXR5X3Rlc3RzLmMKaW5kZXggYTM4MDdlZS4u
MGJiNGFkMiAxMDA2NDQKLS0tIGEvdGVzdHMvYW1kZ3B1L3NlY3VyaXR5X3Rlc3RzLmMKKysrIGIv
dGVzdHMvYW1kZ3B1L3NlY3VyaXR5X3Rlc3RzLmMKQEAgLTMyLDYgKzMyLDcgQEAgc3RhdGljIHVp
bnQzMl90IG1ham9yX3ZlcnNpb247CiBzdGF0aWMgdWludDMyX3QgbWlub3JfdmVyc2lvbjsKIAog
c3RhdGljIHZvaWQgYW1kZ3B1X3NlY3VyaXR5X2FsbG9jX2J1Zl90ZXN0KHZvaWQpOworc3RhdGlj
IHZvaWQgYW1kZ3B1X3NlY3VyaXR5X2dmeF9zdWJtaXNzaW9uX3Rlc3Qodm9pZCk7CiAKIENVX0JP
T0wgc3VpdGVfc2VjdXJpdHlfdGVzdHNfZW5hYmxlKHZvaWQpCiB7CkBAIC03NSw2ICs3Niw3IEBA
IGludCBzdWl0ZV9zZWN1cml0eV90ZXN0c19jbGVhbih2b2lkKQogCiBDVV9UZXN0SW5mbyBzZWN1
cml0eV90ZXN0c1tdID0gewogCXsgImFsbG9jYXRlIHNlY3VyZSBidWZmZXIgdGVzdCIsIGFtZGdw
dV9zZWN1cml0eV9hbGxvY19idWZfdGVzdCB9LAorCXsgImdyYXBoaWNzIHNlY3VyZSBjb21tYW5k
IHN1Ym1pc3Npb24iLCBhbWRncHVfc2VjdXJpdHlfZ2Z4X3N1Ym1pc3Npb25fdGVzdCB9LAogCUNV
X1RFU1RfSU5GT19OVUxMLAogfTsKIApAQCAtMTEzLDMgKzExNSwxMCBAQCBzdGF0aWMgdm9pZCBh
bWRncHVfc2VjdXJpdHlfYWxsb2NfYnVmX3Rlc3Qodm9pZCkKIAlyID0gZ3B1X21lbV9mcmVlKGJv
LCB2YV9oYW5kbGUsIGJvX21jLCA0MDk2KTsKIAlDVV9BU1NFUlRfRVFVQUwociwgMCk7CiB9CisK
K3N0YXRpYyB2b2lkIGFtZGdwdV9zZWN1cml0eV9nZnhfc3VibWlzc2lvbl90ZXN0KHZvaWQpCit7
CisJYW1kZ3B1X2NvbW1hbmRfc3VibWlzc2lvbl93cml0ZV9saW5lYXJfaGVscGVyX3dpdGhfc2Vj
dXJlKGRldmljZV9oYW5kbGUsCisJCQkJCQkJCSAgQU1ER1BVX0hXX0lQX0dGWCwKKwkJCQkJCQkJ
ICB0cnVlKTsKK30KLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZng=
