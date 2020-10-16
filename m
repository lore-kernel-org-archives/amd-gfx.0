Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99021C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 12:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0757A207DE
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 12:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mPg1jqw8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0757A207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CAE16EDBA;
	Fri, 16 Oct 2020 12:34:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF4B16EDBA
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 12:34:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGKc8TaXjoqe01LE79s7MeOQoo0XjS1yV3IW9KluiT7u295cpRqAJvZ6rpBFqb2q0yB/3i9vSFQLxG9nsszRV60tRMfEyeszMDypE7zRnF+3FfuFN+6qCwa3SgGBeVkRFX/q/7jzHshGNZrtO3kqVAi8oVvcSV7j/vJJ4/opd/v7acVbWqRHoNbX+wZrI94GsFTPLVLQLXXVAgX5cxpN+FKJ+y4CCu2+NoQNqF4wvaf0divi5G/KLLwQJlghnYpn0RjWp3onFKeXUww9PHJrx5PsqUjie46+oIxpJj8EEZRJah6GJCCB2lGntWyQWNQBa8ed0oeMMYcz4cxSuFztpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIlShyb4DHsR3g3IXMW5KwWjbCqzIYMqJVKKR8fA0EM=;
 b=ikHnWE/+aNW4OHTH5xydw307fhLYjUMTBOTFx3lI/Dui9rHAi/eNUdqxhh0xumCuK08wW23X7Ly4kCSxae1IzJPa1G0AgRvCWBOqsIYv5wKo0cA6ON9sSovHT3hvyAoQMvm3iLBK8daRZbuqxS34uJKcOW30Oqd9pdtp01ndat+RZNsjNkB3L/sRdtr5GJQywUaEjue7XrJXe4MfzqHw5/IUqB2lRRu5jX2knTinM9HCmy+JaHQd17eO+VTVLlDUC/Jxg4if6bb2XpibF25cC79jwuk3gv6TvYYBn46ahDNt3TrmjkECE2ShXums84p36E7ObuHAFOl8ulpL+4FpOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIlShyb4DHsR3g3IXMW5KwWjbCqzIYMqJVKKR8fA0EM=;
 b=mPg1jqw8ekxuzq/dMAfG/EiNvSVr+R2ejsKchXp3G8Dts/Kf5XycVGDhC9C9BAecjaDJekrydVFprpcTGyTkqdgMOM54jq7Z+fb3vpHNA3AXXoe87Zjrz8MrtR3U2qsEhZVhQ+wuhWl5Lkbxi/T30zu7znDDdH9o2WQEoDGC07E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB2433.namprd12.prod.outlook.com (2603:10b6:207:4a::25)
 by MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Fri, 16 Oct
 2020 12:33:59 +0000
Received: from BL0PR12MB2433.namprd12.prod.outlook.com
 ([fe80::bd7a:2354:a2d4:97fe]) by BL0PR12MB2433.namprd12.prod.outlook.com
 ([fe80::bd7a:2354:a2d4:97fe%7]) with mapi id 15.20.3455.035; Fri, 16 Oct 2020
 12:33:59 +0000
From: Madhav Chauhan <madhav.chauhan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: don't map BO in reserved region
Date: Fri, 16 Oct 2020 18:03:07 +0530
Message-Id: <20201016123307.23262-1-madhav.chauhan@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.158.251]
X-ClientProxiedBy: MA1PR01CA0083.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::23)
 To BL0PR12MB2433.namprd12.prod.outlook.com
 (2603:10b6:207:4a::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atg-hyd-lnx01.amd.com (165.204.158.251) by
 MA1PR01CA0083.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21 via Frontend Transport; Fri, 16 Oct 2020 12:33:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 47bf9a3a-f7d1-4547-66fc-08d871cfc139
X-MS-TrafficTypeDiagnostic: MN2PR12MB4272:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4272986FB01A90881302B1829C030@MN2PR12MB4272.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +acKt+qRG+phv8Uy+g1SjzOdWMDACtvYgbleO2of4zz6YOnoyiQPw/KQNroasBRQEmmqjJCijuKE+XpNP03Zu/K3f+kQn9eoHDxjdce6/0azuk8kdE/oli8Yg2UrmNQr04rsXntNT3bhRirTBp1s6eTR4PXD4HuG3skf8ANruvFD4bGBs8vzkbAGxftI0t7iNSbWe6GjffStFSJ3qznmTfUuFI8CNl7sn5ujtn22JKcr6hZyAQuf8Ton98Ioz42YV3Kr3G38cR6fAWKhxbATASCJWvDUJwdiTDuRWIpP+Qpm2lyZcR4P0p1UtXpFDXifWQmr9FwDdiQVyVI2SbmLlgk3VIgw8RnnOuY7F8Bdbi+Ou1CGxOAiP8Kdq1kwoWWL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2433.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(36756003)(6916009)(66556008)(66476007)(8676002)(316002)(8936002)(66946007)(66574015)(2906002)(5660300002)(83380400001)(6666004)(6486002)(478600001)(956004)(44832011)(86362001)(26005)(34490700002)(186003)(16526019)(2616005)(52116002)(4326008)(1076003)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ZgWCvAaTiC2a0YMQG10iDpLG7B4gkfSC87wlmZp441YAU6fXuCvaD7b4dG4TE+CY83ZggbFVxChfrnrrEAW5wTSQ0BF6KIghzDN6dEdXiCazM82C3dWNNESm/24z635UPv/6uzIvCeeJfRGMoRQZ5R2sjllo85GdGtNkFoXyJVkGrlBG4908ctNNPRxmdvHDSbje5MBEOWEFYjDLc26NOms8oPVsgxeSQNQVgz0x1s36R/5nVBlMwc/9jFOhJ87j4u+p5r204iT90puk8G1HXsWJyM+fyTNrN3eUcSSJL9P/14dgyipwQ29P0vedcVBc9hvliVp1Jbl2eEBa4n/QCwS77Quo+8/90logJRRlYPluUG0rnMtTNSdJZxxft7egDP7CE7AzZrPND5AIHSZsZY+tYVsyJHo+zTqyhUc+2FEJS+Q3MjNthDHj6umCOhWS5UOZy7dLFL48t324JdX0WfAvDIabJTGiRn3hG/4J82RNbi4BKfSatvHJ9LLTzam4BBV0DW9+ZW6DRYTK3x5PE27RMkz/mKUKsFCHVzdft17b22dP52floIpUuEbBps09TNnvHUAFa3SMlu7NnPKWdvd7bYJ4Z+pauU4JNS65/I/zwT6D3ApFangapyVG4T/yz1DJApC+xEOwHhzB++ti0g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47bf9a3a-f7d1-4547-66fc-08d871cfc139
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2433.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 12:33:59.1146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQjRGRsJ8z6XSYnap4ji/U9xk2Gyex2eUpw0UgqXHUBqwh3YXembBfAQ6OgTzKS5FWsnvFsD0v/tAmRudTV6KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272
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
Cc: Madhav Chauhan <madhav.chauhan@amd.com>, christian.koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Mk1CIGFyZWEgaXMgcmVzZXJ2ZWQgYXQgdG9wIGluc2lkZSBWTS4KClN1Z2dlc3RlZC1ieTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBN
YWRoYXYgQ2hhdWhhbiA8bWFkaGF2LmNoYXVoYW5AYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMgfCAxMCArKysrKysrKysrCiAxIGZpbGUgY2hhbmdl
ZCwgMTAgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9nZW0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0u
YwppbmRleCA1MDQ3OTg5ZmU5NDEuLjViNTA4NjBlZWNlNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9nZW0uYwpAQCAtNTk2LDYgKzU5Niw3IEBAIGludCBhbWRncHVfZ2VtX3Zh
X2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEsCiAJc3RydWN0IHd3X2Fj
cXVpcmVfY3R4IHRpY2tldDsKIAlzdHJ1Y3QgbGlzdF9oZWFkIGxpc3QsIGR1cGxpY2F0ZXM7CiAJ
dWludDY0X3QgdmFfZmxhZ3M7CisJdWludDY0X3Qgdm1fc2l6ZTsKIAlpbnQgciA9IDA7CiAKIAlp
ZiAoYXJncy0+dmFfYWRkcmVzcyA8IEFNREdQVV9WQV9SRVNFUlZFRF9TSVpFKSB7CkBAIC02MTYs
NiArNjE3LDE1IEBAIGludCBhbWRncHVfZ2VtX3ZhX2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpk
ZXYsIHZvaWQgKmRhdGEsCiAKIAlhcmdzLT52YV9hZGRyZXNzICY9IEFNREdQVV9HTUNfSE9MRV9N
QVNLOwogCisJdm1fc2l6ZSA9IGFkZXYtPnZtX21hbmFnZXIubWF4X3BmbiAqIEFNREdQVV9HUFVf
UEFHRV9TSVpFOworCXZtX3NpemUgLT0gQU1ER1BVX1ZBX1JFU0VSVkVEX1NJWkU7CisJaWYgKGFy
Z3MtPnZhX2FkZHJlc3MgKyBhcmdzLT5tYXBfc2l6ZSA+IHZtX3NpemUpIHsKKwkJZGV2X2RiZygm
ZGV2LT5wZGV2LT5kZXYsCisJCQkidmFfYWRkcmVzcyAweCVsbHggaXMgaW4gdG9wIHJlc2VydmVk
IGFyZWEgMHglbGx4XG4iLAorCQkJYXJncy0+dmFfYWRkcmVzcyArIGFyZ3MtPm1hcF9zaXplLCB2
bV9zaXplKTsKKwkJcmV0dXJuIC1FSU5WQUw7CisJfQorCiAJaWYgKChhcmdzLT5mbGFncyAmIH52
YWxpZF9mbGFncykgJiYgKGFyZ3MtPmZsYWdzICYgfnBydF9mbGFncykpIHsKIAkJZGV2X2RiZygm
ZGV2LT5wZGV2LT5kZXYsICJpbnZhbGlkIGZsYWdzIGNvbWJpbmF0aW9uIDB4JTA4WFxuIiwKIAkJ
CWFyZ3MtPmZsYWdzKTsKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
