Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149DDC43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 23:25:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFBF321655
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 23:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFBF321655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 742CF6E25D;
	Mon, 11 Nov 2019 23:25:41 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730058.outbound.protection.outlook.com [40.107.73.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7DB76E25D
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 23:25:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxNUZ2am+N80a8SSVAH3+BbNfQ2GwFWu8h7Huz0OqP+Dxt2CjIG6TYJUN0oOM2KmaNnKiB5M+lCJGo0v1qjmSICCtmNm2xmv0OfeIQt7zcyT4NUE7UGqG9jF86+B4kBobhyyMsCNzKCwVBlAQC9s+3MNY5V3QsHlfJZSFMu9k9nu5d9u37Qrc18TWTfHQuagxZLE/67b5SGN6fDfx1a7GVRHduqXCi+nXPgyLjoyjCu2dTjkruZHk2uEKgAWcNY1wQY51leaGLp6EefFp61XiX2KFb+WVdetRmsUfNMWRTkAO9PWHHQWRSyWxuI+XYnRXeJ5pnHQECeohHetB2z36w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWgwX9rMHlBfsp3JkROTKtY/TO7v+9OjIzKbLZZetYc=;
 b=GHqo9jsM1xthq58zZR9p0NEYVnUxHBQUYAssW9s8RqYfdiojWQJ+5g0PSsVF3XRHouooRFkkvpfRVjDcEccrGY3FGXB8jCX1Z5hvyhqBfdVdbmbhs7k35MldiqVB6jiD20ek7ikA3T/AFRLFvodd+ebQ7uGKyqSaBFQiUYqHim5r/2cWzCfbzuCNC9LQ9XkW+l2NHTUMW53dhH8ygO70VfVjYHPhCue/EhsrJ1R5G6iz9zXxWarLoPwXtLQxubOT7M29+QsDnc4foCH2Cr+tKTlRVyZyv1FNMpB0YOYEFzGLU1nnfRARbfeya4SpVhtaJLp7vYOlAFINj8EPzOW37A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB3452.namprd12.prod.outlook.com (20.178.29.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Mon, 11 Nov 2019 23:25:39 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e%6]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 23:25:39 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Jay.Cornwall@amd.com
Subject: [PATCH 2/3] drm/amdkfd: Update get_wave_state() for GFX10
Date: Mon, 11 Nov 2019 18:25:20 -0500
Message-Id: <20191111232521.10528-2-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191111232521.10528-1-Yong.Zhao@amd.com>
References: <20191111232521.10528-1-Yong.Zhao@amd.com>
X-ClientProxiedBy: YT1PR01CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::16)
 To DM6PR12MB2778.namprd12.prod.outlook.com
 (2603:10b6:5:50::17)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c5ec7873-3458-4e79-ea86-08d766fe7655
X-MS-TrafficTypeDiagnostic: DM6PR12MB3452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB345220DF876AC8C3851C8E19F0740@DM6PR12MB3452.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0218A015FA
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(189003)(199004)(6116002)(14454004)(1076003)(6512007)(66476007)(25786009)(7736002)(305945005)(66556008)(66066001)(3846002)(47776003)(4326008)(36756003)(66946007)(50466002)(6486002)(486006)(6636002)(50226002)(48376002)(478600001)(6666004)(81166006)(81156014)(8676002)(99286004)(6436002)(446003)(14444005)(86362001)(11346002)(476003)(8936002)(2616005)(76176011)(316002)(26005)(6506007)(386003)(5660300002)(2906002)(16586007)(51416003)(52116002)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3452;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LNknnLwPlVwJJLsiUexl/ZnsCJ1Q6pqE1Tu57v9Yiy+HVUSkZgRTg2E6ObBNuiFp7y47QwmSDIk06i0kjC/ZtRci1fjd1FwdjrCn6SVtb/9VlEz6YJe+MyKePyKQcHMLXSsXCsSWC1gom1IQvrZ8zT+6KHMaB9uBn+9HfgfnkKB9JY+iBAdrVNEfiwq0F1bGvlrUz+IOxP1jF+rRyA4L0uymfOS5pjQykBxCqQunpsHxUJ/agffM4k13KqFI3elJP4f+e9oY0otgVEiGFQ5wH8N9HlCXU02mDfmqxWw6pqhl/kkuFNt4FKK3utZdn9aJRNmP9G14JpfN3eGLuKzAY1iUwO290OGnGueLyCC+EqHJ3C2mz/xRSAyrSHEf259IOW4pxl48m+eV5h0+86sZ8ogxnPX1WFstd6YAhvsH3hPexQWOXTDvP4yyj/xorPyi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ec7873-3458-4e79-ea86-08d766fe7655
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2019 23:25:39.1111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: su+MVCkoURofLtLaxq4jpfMsxgeD/14p+8DypeYSkJemkGBu8SAqBM01uNEOIj7Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3452
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWgwX9rMHlBfsp3JkROTKtY/TO7v+9OjIzKbLZZetYc=;
 b=o8BsqfQmrR7l/T/kYSiT06mnsFYCKK00VNIdJIafum/X5miHFDB+fYIiuST82PZX5mvvPhIJq/PWbdxbV1n55nkNmH3DvqURiceVl9HuXR6ACi3NMa5Ssyl4Hj5obFWPB4JTy3jN8WzOwqeIC2Z/kCunDN56CbJQUtUvo6yuN0Y=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
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
Cc: Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191111232520.Tym2cB_XcKmNOmpGn4pcixFdd8cMK_vYb4B-RM7NLnY@z>

R2l2ZW4gY29udHJvbCBzdGFjayBpcyBub3cgaW4gdGhlIHVzZXJzcGFjZSBjb250ZXh0IHNhdmUg
cmVzdG9yZSBhcmVhCm9uIEdGWDEwLCB0aGUgc2FtZSBhcyBHRlg4LCBpdCBpcyBub3QgbmVlZGVk
IHRvIGNvcHkgaXQgYmFjayB0byB1c2Vyc3BhY2UuCgpDaGFuZ2UtSWQ6IEkwNjNkZGMzMDI2ZWVm
YTU3NzEzZWM0N2I0NjZhOTBmOWJmOWQ0OWI4ClNpZ25lZC1vZmYtYnk6IFlvbmcgWmhhbyA8WW9u
Zy5aaGFvQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9t
YW5hZ2VyX3YxMC5jIHwgMTQgKysrKysrKysrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2Vy
dGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX21xZF9tYW5hZ2VyX3YxMC5jCmluZGV4IDQ4ODRjZDZjNjVjZS4uOTU0ZGM4YWM0ZmYx
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJf
djEwLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3Yx
MC5jCkBAIC0yNTEsMTggKzI1MSwyMiBAQCBzdGF0aWMgaW50IGdldF93YXZlX3N0YXRlKHN0cnVj
dCBtcWRfbWFuYWdlciAqbW0sIHZvaWQgKm1xZCwKIHsKIAlzdHJ1Y3QgdjEwX2NvbXB1dGVfbXFk
ICptOwogCi0JLyogQ29udHJvbCBzdGFjayBpcyBsb2NhdGVkIG9uZSBwYWdlIGFmdGVyIE1RRC4g
Ki8KLQl2b2lkICptcWRfY3RsX3N0YWNrID0gKHZvaWQgKikoKHVpbnRwdHJfdCltcWQgKyBQQUdF
X1NJWkUpOwotCiAJbSA9IGdldF9tcWQobXFkKTsKIAorCS8qIENvbnRyb2wgc3RhY2sgaXMgd3Jp
dHRlbiBiYWNrd2FyZHMsIHdoaWxlIHdvcmtncm91cCBjb250ZXh0IGRhdGEKKwkgKiBpcyB3cml0
dGVuIGZvcndhcmRzLiBCb3RoIHN0YXJ0cyBmcm9tIG0tPmNwX2hxZF9jbnRsX3N0YWNrX3NpemUu
CisJICogQ3VycmVudCBwb3NpdGlvbiBpcyBhdCBtLT5jcF9ocWRfY250bF9zdGFja19vZmZzZXQg
YW5kCisJICogbS0+Y3BfaHFkX3dnX3N0YXRlX29mZnNldCwgcmVzcGVjdGl2ZWx5LgorCSAqLwog
CSpjdGxfc3RhY2tfdXNlZF9zaXplID0gbS0+Y3BfaHFkX2NudGxfc3RhY2tfc2l6ZSAtCiAJCW0t
PmNwX2hxZF9jbnRsX3N0YWNrX29mZnNldDsKIAkqc2F2ZV9hcmVhX3VzZWRfc2l6ZSA9IG0tPmNw
X2hxZF93Z19zdGF0ZV9vZmZzZXQgLQogCQltLT5jcF9ocWRfY250bF9zdGFja19zaXplOwogCi0J
aWYgKGNvcHlfdG9fdXNlcihjdGxfc3RhY2ssIG1xZF9jdGxfc3RhY2ssIG0tPmNwX2hxZF9jbnRs
X3N0YWNrX3NpemUpKQotCQlyZXR1cm4gLUVGQVVMVDsKKwkvKiBDb250cm9sIHN0YWNrIGlzIG5v
dCBjb3BpZWQgdG8gdXNlciBtb2RlIGZvciBHRlh2MTAgYmVjYXVzZQorCSAqIGl0J3MgcGFydCBv
ZiB0aGUgY29udGV4dCBzYXZlIGFyZWEgdGhhdCBpcyBhbHJlYWR5CisJICogYWNjZXNzaWJsZSB0
byB1c2VyIG1vZGUKKwkgKi8KIAogCXJldHVybiAwOwogfQotLSAKMi4xNy4xCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
