Return-Path: <SRS0=uNvg=ZG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A991C43215
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 09:15:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA2F8206C0
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 09:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2F8206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86BCD6E4FE;
	Thu, 14 Nov 2019 09:15:28 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720079.outbound.protection.outlook.com [40.107.72.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 507E66E4FE
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2019 09:14:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRarqxk/VR8wcWzkrRf2wi3/TR2jf8Voo6/bGJGsaww6VjsbAuLW62w7eIA4LU5EJHVcMkC4JJW6IxpSENki73APGPI+lLClZHMWwCDBOT1hBP6BygpQedXR0HNx2o8g9aKWFtsNcp9+/ZKKwDxyDnoNKAL88LGVLNerp3FGoVsQowaffLinYkEqJGZNyTelklGnu9Xa/4hwbl2YuSkfJrnkeKNGcbpJIPrYfwEKBJIkrhw3PZ82HYG8pseLaCUOLk09xFhB9vKSmEDXRXB9MSgvV57CQvNmuofYSeAu+1PEOCGrgb2D+pwRu16kIpa+DlBWrlaKz5boDLJcgphngw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhWLlV1DFtAkK1ZcLp01z3nrFU/zC0CgvhlSYUrGkxg=;
 b=BsYyI61gXA9Y6Fmkjo5Sh/tuGE+IyNxDQAcUZzUVNouh9Qzn7rWUVz01HiHOj2aqzLABVnc7Vh3MKKGSeKsGVdmw4E2ZNJuXLDYJGkGgzUE9hFrGhaLifXcQKPIjPj+4EzXePCF0mz/NwkTlNCVtlrh1wR/6Ss+juwC8toTlx1AIt54krZ8tTr/rOeW2ziAaJbSAM0aE6Ah6Bjj7ov9dczcI6p6oR+q/B9snIHTtSbmz6xy6JtWk1Kp0LOQq8z3WCbKBVa4tHZh4MfhrQhdxb+ksdDLuzsaFMlElieVqm7//eu/rfGn8GpUYLI4I9saSDZW0H782TCnGPfr95zMSUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3087.namprd12.prod.outlook.com (20.178.244.160) by
 MN2PR12MB3551.namprd12.prod.outlook.com (20.179.83.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Thu, 14 Nov 2019 09:14:20 +0000
Received: from MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::cccb:bf15:7930:7a15]) by MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::cccb:bf15:7930:7a15%5]) with mapi id 15.20.2451.023; Thu, 14 Nov 2019
 09:14:20 +0000
From: Xiaojie Yuan <xiaojie.yuan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/gfx10: explicitly wait for cp idle after
 halt/unhalt
Date: Thu, 14 Nov 2019 17:13:54 +0800
Message-Id: <20191114091354.6414-1-xiaojie.yuan@amd.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: HK0PR04CA0024.apcprd04.prod.outlook.com
 (2603:1096:203:36::36) To MN2PR12MB3087.namprd12.prod.outlook.com
 (2603:10b6:208:d2::32)
MIME-Version: 1.0
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9fb84944-c599-4fa1-4021-08d768e307da
X-MS-TrafficTypeDiagnostic: MN2PR12MB3551:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB355195A73F2B26722636BD1789710@MN2PR12MB3551.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-Forefront-PRVS: 02213C82F8
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(199004)(189003)(66946007)(4326008)(50226002)(2616005)(386003)(305945005)(14454004)(7736002)(47776003)(186003)(26005)(476003)(44832011)(50466002)(86362001)(66066001)(6506007)(486006)(8676002)(48376002)(8936002)(6512007)(6916009)(81156014)(81166006)(6486002)(478600001)(99286004)(66476007)(2870700001)(66556008)(36756003)(2361001)(14444005)(6436002)(3846002)(6116002)(52116002)(51416003)(6666004)(5660300002)(2906002)(1076003)(25786009)(54906003)(2351001)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3551;
 H:MN2PR12MB3087.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YmsWdYnPhUGER9GHZpMpp1mA3jX6uzFqEL249/1dB/yR1fy6plPcd7tv7+bbPbQDRWS971gXf78Y3ycOPT5aSVVrwpb/bpXssOmZMUe3Ej3c6mm+eLPfYX4hllqv09MOY65xelpUkCCJK8C9MgW2135JElQJ6bq2t+YXbSB46g8/Az6FiKzZjZldOczVz+uiOp7t0XXa8VAtFW2HdD3XWZs5LgxxSI8YJKxNofX5WwBdbFVBjsbsXlLXahofvGgo4yeM+wWkJHO9d7UJaxEoN1ymFdG3czmGQK3oaRVPjlTKHheObVZ2s8OEV6e9vcrzBDIMGAyEfOAUMQm6gkZUGzpxvVSte5kqRaoFpN+0Az2XBrCsqugUcEUYqfQhzf5BrkPeDJWQd1Wp78xxr+F8EwttIr/l+OhsLEED61L9dyibJ8XFgsXq5EAXvw8kWVlc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb84944-c599-4fa1-4021-08d768e307da
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2019 09:14:20.3378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKrByIwKKN1Av0EJvl/OepecaVmfemBts4QYiab+NBPZFk1bYKZMPT0LMUTWop/s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3551
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhWLlV1DFtAkK1ZcLp01z3nrFU/zC0CgvhlSYUrGkxg=;
 b=CWBTLpyBbPVrO4RmKGxpNGar+QKa/UXtQ3GOEkKy3gONeZjU02cA/ZHCb/m2Y6KdtFbs4K0gs9Hyz7jfFRQklSBaIw7lYvQFGnJNl3przYpECNe+JnwPS9gwoC1a7UlQEC15IK58+5GPfSOJ9LYTL9SXIxpdlodUM+iYQj9Ry4Q=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xiaojie.Yuan@amd.com; 
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
Cc: gang.long@amd.com, Jack Xiao <Jack.Xiao@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191114091354.-5tAVaSoEzh1DCODSPZbOkSxusmYz7lHGLDwEWcCWL0@z>

NTB1cyBpcyBub3QgZW5vdWdoIHRvIHdhaXQgZm9yIGNwIHJlYWR5IGFmdGVyIGdwdSByZXNldCBv
biBzb21lIG5hdmkgYXNpY3MuCgpTaWduZWQtb2ZmLWJ5OiBYaWFvamllIFl1YW4gPHhpYW9qaWUu
eXVhbkBhbWQuY29tPgpTdWdnZXN0ZWQtYnk6IEphY2sgWGlhbyA8SmFjay5YaWFvQGFtZC5jb20+
Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgfCAxMiArKysrKysr
KysrKy0KIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYwppbmRleCA4NmRiNDA3MTdkMzguLjdk
NDBjNzNhNWFiNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Yx
MF8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKQEAgLTIz
NzEsNyArMjM3MSwxNyBAQCBzdGF0aWMgdm9pZCBnZnhfdjEwXzBfY3BfZ2Z4X2VuYWJsZShzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgYm9vbCBlbmFibGUpCiAJCQlhZGV2LT5nZnguZ2Z4X3Jp
bmdbaV0uc2NoZWQucmVhZHkgPSBmYWxzZTsKIAl9CiAJV1JFRzMyX1NPQzE1KEdDLCAwLCBtbUNQ
X01FX0NOVEwsIHRtcCk7Ci0JdWRlbGF5KDUwKTsKKworCWZvciAoaSA9IDA7IGkgPCBhZGV2LT51
c2VjX3RpbWVvdXQ7IGkrKykgeworCQlpZiAoUlJFRzMyX1NPQzE1KEdDLCAwLCBtbUNQX1NUQVQp
ID09IDApCisJCQlicmVhazsKKwkJdWRlbGF5KDEpOworCX0KKworCWlmIChpID49IGFkZXYtPnVz
ZWNfdGltZW91dCkKKwkJRFJNX0VSUk9SKCJmYWlsZWQgdG8gJXMgY3AgZ2Z4XG4iLCBlbmFibGUg
PyAidW5oYWx0IiA6ICJoYWx0Iik7CisKKwlyZXR1cm4gMDsKIH0KIAogc3RhdGljIGludCBnZnhf
djEwXzBfY3BfZ2Z4X2xvYWRfcGZwX21pY3JvY29kZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dikKLS0gCjIuMjAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
