Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9182AC432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 22:15:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6707D2073A
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 22:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6707D2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2575C6EB28;
	Fri, 15 Nov 2019 22:15:38 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690049.outbound.protection.outlook.com [40.107.69.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 056F06EB28
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 22:15:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfvsLf7OgToI+qPBHcHkbKEZnMrVcpSXsbewx8qZ5IYS/vp46S3Xi7zDCDdcR5HnS2YIdexfXlVq4LgIhIts4LvZz3GAflLi3OqN331Gf7ZfYOzxJv4X0uaghceUEyT7cD0foqElfm+bjr4GGgTY/xiR2VnE0LqkzmuUdU7LAH2IdAEGlwXazN9sCDghVaGgdzKarrdNJ3J4VCzs+Lib88aNif79mL3nLVYBmp0WZYESLard63NOZsPFLFpZeAX+YnC/AAUdV18zc9TvgJ7yhF++yUr8WiyUABIckjIzLLq1p5poFw8YyyU2cQp9tdnsebEMwuQyXdTCQCN9hD6Xkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Urj20mgL7ajrpXk9Yzk2DLVGd0Bo7CTqYEGJ1029mbQ=;
 b=Lc8C7dd6a9hM6O2SaYASza0YMKEzriyUKrQaQsxcAMLDLYF9tcQl1al6hcdAQVThhqTaYgt3/UncUh8KyPfgojwBLQSxW3d/l9Ra9FEGs1rs95C4h6uKqeQ6LWO+eWqxEX5f8nHaHJvi244z9BQJkHlny95RsFmejWiU2ELN6DqCnMBt1obW0weVDBI8I5E+O5Fv2zRoMoDZKMqaeN6lfzWqMZFB0XrT0XXVEe2ict4y8TmnmTiSWNs+jUOXFtFHeKCzNfDs7I3BjufYoCmKTV/dxKz4Sk6iPa9rxdqCsb/8+IAkwTBoYnvj47ZhUR08WcwbRfygSZDaQeZxwACESQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MW2PR12MB2457.namprd12.prod.outlook.com (52.132.180.32) by
 MW2PR12MB2475.namprd12.prod.outlook.com (52.132.180.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 22:15:34 +0000
Received: from MW2PR12MB2457.namprd12.prod.outlook.com
 ([fe80::4556:b416:d7e0:d83b]) by MW2PR12MB2457.namprd12.prod.outlook.com
 ([fe80::4556:b416:d7e0:d83b%7]) with mapi id 15.20.2451.027; Fri, 15 Nov 2019
 22:15:34 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/vcn2.5: fix the enc loop with hw fini
Date: Fri, 15 Nov 2019 17:15:08 -0500
Message-Id: <20191115221508.4900-1-leo.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::16) To MW2PR12MB2457.namprd12.prod.outlook.com
 (2603:10b6:907:8::32)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 018716ce-250e-47d7-16b2-08d76a1955e4
X-MS-TrafficTypeDiagnostic: MW2PR12MB2475:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB247513922945521EF8E80393E5700@MW2PR12MB2475.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-Forefront-PRVS: 02229A4115
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(189003)(199004)(6916009)(50226002)(478600001)(8936002)(48376002)(25786009)(50466002)(81166006)(81156014)(8676002)(86362001)(7736002)(99286004)(66476007)(66556008)(66946007)(14454004)(305945005)(52116002)(6512007)(66066001)(47776003)(1076003)(2361001)(6436002)(36756003)(6486002)(186003)(6666004)(4326008)(2351001)(486006)(44832011)(2616005)(6116002)(51416003)(2906002)(386003)(6506007)(3846002)(5660300002)(4744005)(316002)(16586007)(476003)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2475;
 H:MW2PR12MB2457.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qAfSAriqNXSXuV6W8Nxuo3knWcZStssqhIKjDrzN5FWRERukBqleZA9GeNH3USeE1pCHZnIulDhxg7w7pAxBQftCbffIEp2Ul9NbhALRuzOs5MXM41cKvHhel2tcc0ItfYuOr7geHdltyv2lA1A4gTw950gtaZTOYY09pgYpS/9Dp7MkoFyGZktymfyhx2JI+pFs18KR4GexVrdiFcKlWBc6ML6ONtCKkUatMPFE9m/1qxlfDj7MYAbUAuswhVHodNI1MOqRp32o4TfC9NxaumuzqC/2GnGVjWakri41JYmdhFfFh8uFXlP6jQ7ZpXN8zV+qcbVjtfVZKj0BrcIRZF7WdUAxq9ci0MJnE77xknempd4D+u/PiOvP3Arcku3zrIe8jIKcke464HfvrIUNBKDdYxbB975r2moXBUX+YbZ3Z3dH7g1h4XDt4C5fPGMc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 018716ce-250e-47d7-16b2-08d76a1955e4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 22:15:34.6730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehD71Ppt2EPHB0/1TB68WWi0BUZD40VUoSCoIhrVbWgMrTm28UxQp8eBtwRGZcmY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2475
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Urj20mgL7ajrpXk9Yzk2DLVGd0Bo7CTqYEGJ1029mbQ=;
 b=Ee43kvoos2CrkL7Zyj8jIsRaVo/co75+MxiqfNdbCc08QY0sTPPxs7W64xvNOKkOqY5cHnZN85dhwcIJ8eTK7ti0sISapFfSC/lLameX/6fIjzMKuHhgBsnGoO3+iruKCmt7gNHG99qw1W7VNQWrGQyCjNOR73mVNgqHWrqWCYI=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
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
Cc: Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115221508.ZGO3de3pTrCzF4mQ7220XQnj_R5eWQPnIpCB-WOs2js@z>

Rml4ZXM6IDkwNzJjNTg0IChkcm0vYW1kZ3B1OiBtb3ZlIEpQRUcyLjUgb3V0IGZyb20gVkNOMi41
KQoKU2lnbmVkLW9mZi1ieTogTGVvIExpdSA8bGVvLmxpdUBhbWQuY29tPgotLS0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml81LmMgfCA2ICsrKy0tLQogMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS92Y25fdjJfNS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
dmNuX3YyXzUuYwppbmRleCA0NTFkYzgxNGQ4NDUuLjQyZDZiOWYwNTUzYiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YyXzUuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS92Y25fdjJfNS5jCkBAIC0yNjgsNyArMjY4LDcgQEAgc3RhdGljIGludCB2
Y25fdjJfNV9od19maW5pKHZvaWQgKmhhbmRsZSkKIHsKIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWhhbmRsZTsKIAlzdHJ1Y3QgYW1kZ3B1X3Jp
bmcgKnJpbmc7Ci0JaW50IGk7CisJaW50IGksIGo7CiAKIAlmb3IgKGkgPSAwOyBpIDwgYWRldi0+
dmNuLm51bV92Y25faW5zdDsgKytpKSB7CiAJCWlmIChhZGV2LT52Y24uaGFydmVzdF9jb25maWcg
JiAoMSA8PCBpKSkKQEAgLTI4MCw4ICsyODAsOCBAQCBzdGF0aWMgaW50IHZjbl92Ml81X2h3X2Zp
bmkodm9pZCAqaGFuZGxlKQogCiAJCXJpbmctPnNjaGVkLnJlYWR5ID0gZmFsc2U7CiAKLQkJZm9y
IChpID0gMDsgaSA8IGFkZXYtPnZjbi5udW1fZW5jX3JpbmdzOyArK2kpIHsKLQkJCXJpbmcgPSAm
YWRldi0+dmNuLmluc3RbaV0ucmluZ19lbmNbaV07CisJCWZvciAoaiA9IDA7IGogPCBhZGV2LT52
Y24ubnVtX2VuY19yaW5nczsgKytqKSB7CisJCQlyaW5nID0gJmFkZXYtPnZjbi5pbnN0W2ldLnJp
bmdfZW5jW2pdOwogCQkJcmluZy0+c2NoZWQucmVhZHkgPSBmYWxzZTsKIAkJfQogCX0KLS0gCjIu
MTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
