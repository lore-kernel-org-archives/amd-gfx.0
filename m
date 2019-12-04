Return-Path: <SRS0=SH5p=Z2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E10C43603
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 08:00:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EC302084F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 08:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC302084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 056F06F43D;
	Wed,  4 Dec 2019 08:00:49 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730067.outbound.protection.outlook.com [40.107.73.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C76E6F43D
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2019 08:00:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COgXaAftfZqvN+jfygxMXA8ZN+lVYxAZ5rglEDl11xcIVoM7vX/6OBtrsQWfEmrjQQ4Nsj+W5m3ar0QQx0ZY4shaErW0eRIewQEkyEi0xei+gsTW0PTvkmsQOFUgmKvwYe5A8OoYsNf247kiq4LIMtVb//zwh2jSG6ADl+rcZki1B+uOfU4tseYmkOp0maEAE7pflo5AgVOp2PtxdvmUcSWSQvp1uo1JROffzj+AXwbS/aeTldUwsbGvGeTb9tAmbIKCQNq/s6FeAKgu1r3UC1cxlJSw6ftXJfz1d3jezJAn7UmW/EWi96S1M8Kc3zL3zOYNYEcWHkTzX2c9MAhVWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=py3a/Ho3URIU6rtc7oVfQmGaPsIZqQER+fn/LIw9oxE=;
 b=IIb1GAqwRMAdQSQUQ/+Lsoyvg//jL/ISurhnSr88SAhHDRPgsjTKkINtM/J6o3rJtol8uURapuUiyF/Poi5wC/XhlyLCIQSNgidK4LBIsj9F0+NQov9pxGtnMIn5obaHiM75qc9v3OtSRE2yhOoEOnYha55LJeGgzJODtcVJVsJVy/L/6gjYbHKyOyIe0nbvs61xV3dD+oo+WwNGqN6BSpj1mjku2kLVgVu1GVGU2kTqrOvw0xvm3dx2EHoMrYpifHUmMcFFlzTb4I5NFNVS7gOCKMjN/c1otCDcY7qazbTq7XZOzpOdL3gxxclsaklnQ63tEjwmtDTdUR37yGUy0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (20.176.254.20) by
 BYAPR12MB3271.namprd12.prod.outlook.com (20.179.93.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Wed, 4 Dec 2019 08:00:44 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::e09a:808e:1ea9:db3f]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::e09a:808e:1ea9:db3f%7]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 08:00:44 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com,
 alexander.deucher@amd.com
Subject: [PATCH] drm/amdgpu: add check before enabling/disabling broadcast mode
Date: Wed,  4 Dec 2019 16:00:24 +0800
Message-Id: <20191204080024.7229-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2P15301CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::30) To BYAPR12MB2806.namprd12.prod.outlook.com
 (2603:10b6:a03:70::20)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 51bced8b-3b87-454d-e87b-08d77890101a
X-MS-TrafficTypeDiagnostic: BYAPR12MB3271:|BYAPR12MB3271:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3271CC8BE0B94C8A6D2157E4F15D0@BYAPR12MB3271.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-Forefront-PRVS: 0241D5F98C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(189003)(199004)(15404003)(51416003)(81166006)(6506007)(50226002)(25786009)(1076003)(14444005)(6116002)(8676002)(6512007)(52116002)(3846002)(99286004)(36756003)(66476007)(66946007)(66556008)(5660300002)(386003)(26005)(2906002)(81156014)(6666004)(7736002)(305945005)(8936002)(4326008)(6436002)(86362001)(50466002)(48376002)(498600001)(186003)(6636002)(6486002)(44832011)(16586007)(14454004)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3271;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UYRNk+zjhOXQNbF7ssKPGgl+8mjEy9BwDgMUL0FarTZMcMwY/4RpJJRzO1oXRZtTTQ2yMJAnOFziJD0L9cusMzrwQ8sxPBgP4peJKOJavGOqsvuiwJo+YCzrzm6EEH2hrRRwuuncMq20UaVAOEKYhiFF4P+e4qbX+xEEJAe+Vrw8fbJPm4ZFSjaTdNRI3CTMc2DP3S5V1v4SRZDBRO+H5d/JRbf7gE81P+V5qOCXGWbJzSbX3OUUymLzQiWmWjvzOU+7ml4TiD0c6pq7uUTXTC1NX6hgJY9xZQ9IWgjg90++LIss5PXmFZeCZ/Re2szFWrSAiyIjgUL0V6PEF2wl6sY5WLPd9gPyqf9OiJUYk+poQzXvPiOIegS2ZAFAGOesbSZeGTQlPJo7uNSEABF7C2gT42Geqqx5m67V7cFExTPZCgWLlY9iY431dOBRiIl5GAokBq7pJ2vGA3jRxexq1a0WFXRNmlO+LLjnU0Fvy6k5F+4EqrbtXK7Q41ZtZx8F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51bced8b-3b87-454d-e87b-08d77890101a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 08:00:44.0105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YJZlgrX2d9aZGSgE6DLkZhRDaBZH+CahyvDICteKjkxXFNOqaimWJyT79ZXqCy70sBaI2f4j5suii9fFgkxNLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3271
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=py3a/Ho3URIU6rtc7oVfQmGaPsIZqQER+fn/LIw9oxE=;
 b=W+C1/lR5Fpy4rf0LwsGgu4VvuGecOR/0xmui/WuXwxMVrVrESIuawcH7Oyn0Q0kO/bKnVdG0NPiYwC/JLheFBknOw3PoV1MmbaL03GesHCZGEY3wRBBqW2IeeRKEJTRJTDMlth/f37MhYWdqJ7Z5CZBwqFsnsG/UF7DYkeFwFYM=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RHVlIHRvIG5ldyB2YmlvcyBzZWN1cml0eSBwb2xpY3kgY2hhbmdlIGFuZCBsYWNrIG9mIGJhY2t3
YXJkcwpjb21wYXRpYmlsaXR5IGludGVyZmFjZSwgaGFuZyB3aWxsIGhhcHBlbiB3aGVuIGRhdGEg
ZmFicmljIHVwZGF0ZXMKY2xvY2sgZ2F0aW5nIG9uIHZlZ2EyMC4gU28gYWRkIG9uZSBjaGVjayBi
ZWZvcmUgcHJvY2Vzc2luZyBkYXRhCmZhYnJpYyBicm9hZGNhc3QgbW9kZSB0byBieXBhc3MgdGhp
cyBvbiB2ZWdhMjAuCgpTaWduZWQtb2ZmLWJ5OiBHdWNodW4gQ2hlbiA8Z3VjaHVuLmNoZW5AYW1k
LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9kZl92M182LmMgfCAzOCArKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygr
KSwgMTYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZGZfdjNfNi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGZfdjNfNi5jCmluZGV4
IDcyYmZlZmRiZmE2NS4uOTM5NWFhOGI4ZmQwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9kZl92M182LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGZf
djNfNi5jCkBAIC0yNjgsMjMgKzI2OCwyOSBAQCBzdGF0aWMgdm9pZCBkZl92M182X3VwZGF0ZV9t
ZWRpdW1fZ3JhaW5fY2xvY2tfZ2F0aW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogewog
CXUzMiB0bXA7CiAKLQkvKiBQdXQgREYgb24gYnJvYWRjYXN0IG1vZGUgKi8KLQlhZGV2LT5kZl9m
dW5jcy0+ZW5hYmxlX2Jyb2FkY2FzdF9tb2RlKGFkZXYsIHRydWUpOwotCi0JaWYgKGVuYWJsZSAm
JiAoYWRldi0+Y2dfZmxhZ3MgJiBBTURfQ0dfU1VQUE9SVF9ERl9NR0NHKSkgewotCQl0bXAgPSBS
UkVHMzJfU09DMTUoREYsIDAsIG1tREZfUElFX0FPTjBfRGZHbG9iYWxDbGtHYXRlcik7Ci0JCXRt
cCAmPSB+REZfUElFX0FPTjBfRGZHbG9iYWxDbGtHYXRlcl9fTUdDR01vZGVfTUFTSzsKLQkJdG1w
IHw9IERGX1YzXzZfTUdDR19FTkFCTEVfMTVfQ1lDTEVfREVMQVk7Ci0JCVdSRUczMl9TT0MxNShE
RiwgMCwgbW1ERl9QSUVfQU9OMF9EZkdsb2JhbENsa0dhdGVyLCB0bXApOwotCX0gZWxzZSB7Ci0J
CXRtcCA9IFJSRUczMl9TT0MxNShERiwgMCwgbW1ERl9QSUVfQU9OMF9EZkdsb2JhbENsa0dhdGVy
KTsKLQkJdG1wICY9IH5ERl9QSUVfQU9OMF9EZkdsb2JhbENsa0dhdGVyX19NR0NHTW9kZV9NQVNL
OwotCQl0bXAgfD0gREZfVjNfNl9NR0NHX0RJU0FCTEU7Ci0JCVdSRUczMl9TT0MxNShERiwgMCwg
bW1ERl9QSUVfQU9OMF9EZkdsb2JhbENsa0dhdGVyLCB0bXApOwotCX0KKwlpZiAoYWRldi0+Y2df
ZmxhZ3MgJiBBTURfQ0dfU1VQUE9SVF9ERl9NR0NHKSB7CisJCS8qIFB1dCBERiBvbiBicm9hZGNh
c3QgbW9kZSAqLworCQlhZGV2LT5kZl9mdW5jcy0+ZW5hYmxlX2Jyb2FkY2FzdF9tb2RlKGFkZXYs
IHRydWUpOworCisJCWlmIChlbmFibGUpIHsKKwkJCXRtcCA9IFJSRUczMl9TT0MxNShERiwgMCwK
KwkJCQkJbW1ERl9QSUVfQU9OMF9EZkdsb2JhbENsa0dhdGVyKTsKKwkJCXRtcCAmPSB+REZfUElF
X0FPTjBfRGZHbG9iYWxDbGtHYXRlcl9fTUdDR01vZGVfTUFTSzsKKwkJCXRtcCB8PSBERl9WM182
X01HQ0dfRU5BQkxFXzE1X0NZQ0xFX0RFTEFZOworCQkJV1JFRzMyX1NPQzE1KERGLCAwLAorCQkJ
CQltbURGX1BJRV9BT04wX0RmR2xvYmFsQ2xrR2F0ZXIsIHRtcCk7CisJCX0gZWxzZSB7CisJCQl0
bXAgPSBSUkVHMzJfU09DMTUoREYsIDAsCisJCQkJCW1tREZfUElFX0FPTjBfRGZHbG9iYWxDbGtH
YXRlcik7CisJCQl0bXAgJj0gfkRGX1BJRV9BT04wX0RmR2xvYmFsQ2xrR2F0ZXJfX01HQ0dNb2Rl
X01BU0s7CisJCQl0bXAgfD0gREZfVjNfNl9NR0NHX0RJU0FCTEU7CisJCQlXUkVHMzJfU09DMTUo
REYsIDAsCisJCQkJCW1tREZfUElFX0FPTjBfRGZHbG9iYWxDbGtHYXRlciwgdG1wKTsKKwkJfQog
Ci0JLyogRXhpdCBicm9hZGNhc3QgbW9kZSAqLwotCWFkZXYtPmRmX2Z1bmNzLT5lbmFibGVfYnJv
YWRjYXN0X21vZGUoYWRldiwgZmFsc2UpOworCQkvKiBFeGl0IGJyb2FkY2FzdCBtb2RlICovCisJ
CWFkZXYtPmRmX2Z1bmNzLT5lbmFibGVfYnJvYWRjYXN0X21vZGUoYWRldiwgZmFsc2UpOworCX0K
IH0KIAogc3RhdGljIHZvaWQgZGZfdjNfNl9nZXRfY2xvY2tnYXRpbmdfc3RhdGUoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeA==
