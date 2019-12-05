Return-Path: <SRS0=ZBu5=Z3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE674C43603
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 11:53:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CD222245C
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 11:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD222245C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 172446E96A;
	Thu,  5 Dec 2019 11:53:11 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93E126E96A
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2019 11:53:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqdqWw9hRXhdEWG0hYGLk/ulPXOHhb1fXtNucLCyrdD8slcxl6i5jENgFQNujmbqYfN+80BgvL1QmFCG5yROzQlR9aax24ODvBpO5nNMNDxlg+XI2sq233thQu3cotj2lu/s/RYnbVsffoEdOdoK0zAAth3Wrxd2RtWMUp2BmxNMIOWoKxHdq/LoVRxT4tZHfOAWIDHi9yH/mUIae7vqrm/ryO4n/N4o09GMwTqUgxzHoFJCOkl65xYgxfTFsLfY77Y0OzDTBkhdWexI4NFrfgYWncB6OJq2J1WuPhk2gl9N36zS8SUBBsPyq+tUCSwY5SD9gfLswF1UaQuTrX52FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXYpjm3EOfu+syJAIXf7Y85yIuPxlnaCE8ASAEsK0LY=;
 b=K4pB0qZWnVaK2Z7ZSnxjWzFqUl02rvj/JZ+2DbI25mvXQiQyztGgprTxL/Lm4ow/18fHhMp07W8V24ISwuE6EgCIQ69oF6w33BiL9G2w/RLuk8pYwJI8YmkUe+d/mSGYOWciJBoq8Uqi8G8sldCQoeTVQAF5MgrNjIcqNhEoqrgybjl5Uovlm6lwCj+zs5HnwDRDTgso831I6KK4heKzck7qDfjof0ERVJcpFxrwSyjpr+GaD4bwf+nO2PvpbbStQqRfdEKlEVQyttqcR5Koa5LNXTz3PybOm7N6SPcus4A2R1Ef3FF5RRqfTmonKGQu6SA3enC2kbLehQT+i/fkQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BY5PR12MB4258.namprd12.prod.outlook.com (52.135.55.74) by
 BY5PR12MB4180.namprd12.prod.outlook.com (10.255.126.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Thu, 5 Dec 2019 11:53:08 +0000
Received: from BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::cd51:d6c0:eba5:4c5e]) by BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::cd51:d6c0:eba5:4c5e%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 11:53:07 +0000
From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amd/powerplay: implement interface to retrieve gpu
 temperature for renoir
Date: Thu,  5 Dec 2019 19:50:28 +0800
Message-Id: <20191205115031.3822-1-Xiaomeng.Hou@amd.com>
X-Mailer: git-send-email 2.24.0
X-ClientProxiedBy: HK0PR01CA0062.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::26) To BY5PR12MB4258.namprd12.prod.outlook.com
 (2603:10b6:a03:20d::10)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f3e89abf-60c1-482d-eb6e-08d77979b1a7
X-MS-TrafficTypeDiagnostic: BY5PR12MB4180:|BY5PR12MB4180:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB418011300F14D0A8B2A415C39F5C0@BY5PR12MB4180.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-Forefront-PRVS: 02426D11FE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(199004)(189003)(50466002)(316002)(478600001)(8676002)(4326008)(48376002)(14454004)(186003)(2870700001)(86362001)(36756003)(1076003)(6666004)(2906002)(81166006)(66946007)(99286004)(6916009)(51416003)(5660300002)(66476007)(6506007)(6486002)(66556008)(25786009)(6512007)(26005)(305945005)(8936002)(81156014)(50226002)(52116002)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB4180;
 H:BY5PR12MB4258.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KqFTym7tO7owVyCCZ0viRrRmzKTFK+loug43dlmTBh81/tMGeMhcKzdoiy93puFtNqRTeogQAkMX7iP8xIFCiWTkrt67tV4sZetfCUSuuPVSsZimdMKBQtYCPb/1jcOFBtrwn4PyrfcoWFByD7lEFRtLmIWM12olQV/TplfqV/8FU3ZZ/6lA0xzXAIx6AZK1Ink2hfzR21eXkF+VRBOHredsJM+rc7eOGD7wt9wq2nf4tw638kffvBi0Ant5FssdNJ6Z3KwezhLYe55fPuZPohzS8UXftttH2v6OrQ+ySWSaiPKO8tkTnyJULzCCthWTNjOSMR1IF79f9g4vW9crkD3MkFk6ET3hqpy/mp8gs275Yg2VhmhctP/J6kWhWk8tDydlRhfgk8CjxWFS2eDGdk0rujybJ+2jk6mvSqkdxQFNNs+KAJ1SOtMp5zr2rRdV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e89abf-60c1-482d-eb6e-08d77979b1a7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 11:53:07.6512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMfP66vFrYHA/gd0pGTmvL9P8/6W+5iJEAj3PpxcGHYpRnQK6u1KkL4XZWyTJFZpIzeEo/ASC33js8rc5xevtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXYpjm3EOfu+syJAIXf7Y85yIuPxlnaCE8ASAEsK0LY=;
 b=io3KtM0TdtPkZTmgqq/YtnJx4XqmnF4Gu73w1zoWnugnCiGxJtbbvdfo/F3c8sftfXSZwVK6wrrHKuvHyUuGn8B+vxBha1+sQwYJfD7Fo1dUsGuIFPoRzHVNuNPa4NNqyIRwxh7HlroOC1YEo3QVouGKa5xW8tes1iw+YFN5DbM=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xiaomeng.Hou@amd.com; 
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
Cc: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

YWRkIHNlbnNvciBpbnRlcmZhY2Ugb2YgZ2V0IGdwdSB0ZW1wZXJhdHVyZSBmb3IgZGVidWdmcy4K
CkNoYW5nZS1JZDogSTI0OTliNjY1MmZhZDZkNWQ3NzZiNmVkNGNkNTE1NzYzNjU4M2VkMzkKU2ln
bmVkLW9mZi1ieTogWGlhb21lbmcgSG91IDxYaWFvbWVuZy5Ib3VAYW1kLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9yZW5vaXJfcHB0LmMgfCAyMiArKysrKysrKysrKysr
KysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3Jlbm9pcl9wcHQuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L3Jlbm9pcl9wcHQuYwppbmRleCAzNzg4MDQ3YmQ3MDQuLjNmNmYw
ZWJmMWZiZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvcmVub2ly
X3BwdC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3Jlbm9pcl9wcHQuYwpA
QCAtNDI5LDYgKzQyOSwyNCBAQCBzdGF0aWMgaW50IHJlbm9pcl9nZXRfZ3B1X3Bvd2VyKHN0cnVj
dCBzbXVfY29udGV4dCAqc211LCB1aW50MzJfdCAqdmFsdWUpCiAJcmV0dXJuIDA7CiB9CiAKK3N0
YXRpYyBpbnQgcmVub2lyX2dldF9ncHVfdGVtcGVyYXR1cmUoc3RydWN0IHNtdV9jb250ZXh0ICpz
bXUsIHVpbnQzMl90ICp2YWx1ZSkKK3sKKwlpbnQgcmV0ID0gMDsKKwlTbXVNZXRyaWNzX3QgbWV0
cmljczsKKworCWlmICghdmFsdWUpCisJCXJldHVybiAtRUlOVkFMOworCisJcmV0ID0gcmVub2ly
X2dldF9tZXRyaWNzX3RhYmxlKHNtdSwgJm1ldHJpY3MpOworCWlmIChyZXQpCisJCXJldHVybiBy
ZXQ7CisKKwkqdmFsdWUgPSAobWV0cmljcy5HZnhUZW1wZXJhdHVyZSAvIDEwMCkgKgorCQlTTVVf
VEVNUEVSQVRVUkVfVU5JVFNfUEVSX0NFTlRJR1JBREVTOworCisJcmV0dXJuIDA7Cit9CisKIHN0
YXRpYyBpbnQgcmVub2lyX2dldF9jdXJyZW50X2FjdGl2aXR5X3BlcmNlbnQoc3RydWN0IHNtdV9j
b250ZXh0ICpzbXUsCiAJCQkJCSAgICAgICBlbnVtIGFtZF9wcF9zZW5zb3JzIHNlbnNvciwKIAkJ
CQkJICAgICAgIHVpbnQzMl90ICp2YWx1ZSkKQEAgLTc4Nyw2ICs4MDUsMTAgQEAgc3RhdGljIGlu
dCByZW5vaXJfcmVhZF9zZW5zb3Ioc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsCiAJCXJldCA9IHJl
bm9pcl9nZXRfZ3B1X3Bvd2VyKHNtdSwgKHVpbnQzMl90ICopZGF0YSk7CiAJCSpzaXplID0gNDsK
IAkJYnJlYWs7CisJY2FzZSBBTURHUFVfUFBfU0VOU09SX0dQVV9URU1QOgorCQlyZXQgPSByZW5v
aXJfZ2V0X2dwdV90ZW1wZXJhdHVyZShzbXUsICh1aW50MzJfdCAqKWRhdGEpOworCQkqc2l6ZSA9
IDQ7CisJCWJyZWFrOwogCWRlZmF1bHQ6CiAJCXJldCA9IHNtdV92MTJfMF9yZWFkX3NlbnNvcihz
bXUsIHNlbnNvciwgZGF0YSwgc2l6ZSk7CiAJfQotLSAKMi4yNC4wCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
