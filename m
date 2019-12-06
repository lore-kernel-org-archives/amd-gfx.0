Return-Path: <SRS0=UM6f=Z4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE381C43603
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 14:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B98BC20706
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 14:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98BC20706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E4786E098;
	Fri,  6 Dec 2019 14:37:02 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750048.outbound.protection.outlook.com [40.107.75.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38B266E098
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2019 14:37:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTA7jR1Zvvu/+lGeXp2hPSkuXODeRthp5AIfXz/hXHGSao9jbnhItGv7XnTM86RHc0Du3P33OpRFC6FlBHVpfcc2yMWDXSlJxQOL9CZeVtbHyj7WJbJ5VF0ON7NygFufZ1gPtJ9shEytNgdDpZumFUbIZ/0zbpdooFQ8GvOghyxw+78hBtyI+vHEVjV4inDLaSaJ9hC3/8HCJWEjOZlw4bRRUtqEhvipNYjbvuYT6ajGSVJrxAhepr8gWPI5f0PEDk33PBnPdnnx+anjiiaUV+rmaPrLykNSL/Gub8yfjjnzr0r0C3tnfAb9dm6tLhzlUZ+HiRqPUMFNGqiNI64ilA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pv6ArROO2J2/QaSvokJs/LJbs69brTJGo89C2XH/qE4=;
 b=UAo0GD6lnTwUejJvKIKrlgaT0QXh2F7lhkKB4JWe9i06Ek8OETmqZRLBWw9abgfdFC0lFtcAT/2s8OUIW/OuFimZZBjHVhAiHe+4FLFSyGGcDWuz72Cs3ihtzCkqhpK8f2WRTKtgXqlf7THBTkvsfoAlZcCjDFfF6DsXmgRw1+vRiHFu2JHFiDGXPs3K70PK+jmXjxDOw/JJELX3qGEAc2AvZIbUTz1E7eKc9UsKo2oJFK0BLRxrDD1gf8aN154DwTXKoM7eoUjUOW1t6L4L60r9DcbLhGLI9WkS5FbFUrlkmJ1l+lnwcHjP72mkvqWuJ5qgliXR6aNDxzFMTPOULw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3920.namprd12.prod.outlook.com (10.255.237.208) by
 MN2PR12MB3280.namprd12.prod.outlook.com (20.179.81.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Fri, 6 Dec 2019 14:36:58 +0000
Received: from MN2PR12MB3920.namprd12.prod.outlook.com
 ([fe80::cc9a:c53f:1ba8:bde4]) by MN2PR12MB3920.namprd12.prod.outlook.com
 ([fe80::cc9a:c53f:1ba8:bde4%6]) with mapi id 15.20.2516.017; Fri, 6 Dec 2019
 14:36:58 +0000
From: Thong Thai <thong.thai@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/amdgpu: enable VCN DPG on Raven and Raven2"
Date: Fri,  6 Dec 2019 09:36:49 -0500
Message-Id: <20191206143649.10329-1-thong.thai@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::15) To MN2PR12MB3920.namprd12.prod.outlook.com
 (2603:10b6:208:168::16)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3b94edd0-f8cb-4355-23ce-08d77a59bfa9
X-MS-TrafficTypeDiagnostic: MN2PR12MB3280:|MN2PR12MB3280:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3280986DC3176A6330A1FC299D5F0@MN2PR12MB3280.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:89;
X-Forefront-PRVS: 0243E5FD68
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(199004)(189003)(1076003)(51416003)(48376002)(6506007)(99286004)(4326008)(316002)(52116002)(2906002)(81166006)(66946007)(6512007)(5660300002)(50466002)(6486002)(66476007)(478600001)(66556008)(186003)(26005)(86362001)(6916009)(36756003)(81156014)(305945005)(2616005)(44832011)(50226002)(6666004)(8676002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3280;
 H:MN2PR12MB3920.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bcbZkb2tBgCvjATP5GkzLJzU8ZJf/m5hPBxWfDKm5np3sebD9fC0WN19JkZpFCObsKBk76IyYBlDT9IeTkU7cWd+MKCoYaWuSAL1OMCQ1TP79CvKqOnsubVdeixra8fAr9vEa6WE27M34wbWd3sb0bvArENKrOFrU8Ms9aJZYWuUU22VwQo8fuFv5o/TrLW8DDJAe+W8YYgTIE85sHveYvaCitPj/Z0cRAvYZlYHuTcH2DZecmQXgmcMQwds8IT5tBo7REKP7INa0ajxHz726S57DCRUIFfeE/x4ME2GB2Ymq/pxenNcEL7WC3MTslHSnkOdU2+iEI3B856GGBy1GjL8uKiswBb+9wXz/G7ropnIpFSIEjML+Z4sGb8s+NYno0EbgiHYZPp1WZOPqLjTCQ5dJ/mTXhINLGLAvj4OAuRp4D1HCyWGs32uxpF+GaG8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b94edd0-f8cb-4355-23ce-08d77a59bfa9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2019 14:36:58.4624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NzwDTw97liD3x/p+OIH6G2ImDCj+jaE4i3dmlkEWQfvgB528nB4i+4N41q4KB81BYCFRT4j8+pM372ysCF65Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3280
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pv6ArROO2J2/QaSvokJs/LJbs69brTJGo89C2XH/qE4=;
 b=xtKegu1kafFHiOSf69ywNU9+Oq0cRxAeikNuc69Ncle+ze1XICDQlAeXbNBlmoaM4RzRHaM+GBZPZJyca177yoTryMud9/B2sK5ZuZzUfY9AkkSSwv2XafTpSNDqslT+T3CT3dy630l4r50RxCqfJZXNuLv4bSuPgsSdXYGyrSQ=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thong.Thai@amd.com; 
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
Cc: Thong Thai <thong.thai@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyByZXZlcnRzIGNvbW1pdCBhNDg0MGQ5MWM5ODRmOTNiMmFjZGNkNDQ0NDFkNjI0YmJjMWFm
MGQyLgoKUmV2ZXJ0aW5nIGR1ZSB0byBwb3dlciBlZmZpY2llbmN5IGlzc3VlcyBzZWVuIG9uIFJh
dmVuIDEgYW5kIDIKd2hlbiBEUEcgbW9kZSBpcyBlbmFibGVkLgoKU2lnbmVkLW9mZi1ieTogVGhv
bmcgVGhhaSA8dGhvbmcudGhhaUBhbWQuY29tPgpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NvYzE1LmMgfCA4ICsrLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA2
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Nv
YzE1LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCmluZGV4IDQ4NjQ5ZjU1
ZjNiYS4uODYzYzg4YmUwNTVmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9zb2MxNS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMKQEAgLTEx
ODEsOSArMTE4MSw3IEBAIHN0YXRpYyBpbnQgc29jMTVfY29tbW9uX2Vhcmx5X2luaXQodm9pZCAq
aGFuZGxlKQogCQkJCUFNRF9DR19TVVBQT1JUX1NETUFfTFMgfAogCQkJCUFNRF9DR19TVVBQT1JU
X1ZDTl9NR0NHOwogCi0JCQlhZGV2LT5wZ19mbGFncyA9IEFNRF9QR19TVVBQT1JUX1NETUEgfAot
CQkJCUFNRF9QR19TVVBQT1JUX1ZDTiB8Ci0JCQkJQU1EX1BHX1NVUFBPUlRfVkNOX0RQRzsKKwkJ
CWFkZXYtPnBnX2ZsYWdzID0gQU1EX1BHX1NVUFBPUlRfU0RNQSB8IEFNRF9QR19TVVBQT1JUX1ZD
TjsKIAkJfSBlbHNlIGlmIChhZGV2LT5wZGV2LT5kZXZpY2UgPT0gMHgxNWQ4KSB7CiAJCQlhZGV2
LT5jZ19mbGFncyA9IEFNRF9DR19TVVBQT1JUX0dGWF9NR0NHIHwKIAkJCQlBTURfQ0dfU1VQUE9S
VF9HRlhfTUdMUyB8CkBAIC0xMjI2LDkgKzEyMjQsNyBAQCBzdGF0aWMgaW50IHNvYzE1X2NvbW1v
bl9lYXJseV9pbml0KHZvaWQgKmhhbmRsZSkKIAkJCQlBTURfQ0dfU1VQUE9SVF9TRE1BX0xTIHwK
IAkJCQlBTURfQ0dfU1VQUE9SVF9WQ05fTUdDRzsKIAotCQkJYWRldi0+cGdfZmxhZ3MgPSBBTURf
UEdfU1VQUE9SVF9TRE1BIHwKLQkJCQlBTURfUEdfU1VQUE9SVF9WQ04gfAotCQkJCUFNRF9QR19T
VVBQT1JUX1ZDTl9EUEc7CisJCQlhZGV2LT5wZ19mbGFncyA9IEFNRF9QR19TVVBQT1JUX1NETUEg
fCBBTURfUEdfU1VQUE9SVF9WQ047CiAJCX0KIAkJYnJlYWs7CiAJY2FzZSBDSElQX0FSQ1RVUlVT
OgotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
