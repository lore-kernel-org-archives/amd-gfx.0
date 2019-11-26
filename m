Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22208C432C0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 09:43:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA74020722
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 09:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA74020722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C6966E2A9;
	Tue, 26 Nov 2019 09:43:27 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770048.outbound.protection.outlook.com [40.107.77.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE4976E2A9
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 09:43:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXxPrtV6qVq7hKIsT9EM5RahACR1dXUAVSh3CzFW6SqKNniq7GGzaFDyh8SS1B6m7aE6GyC9XCpqH4lN5W8e9Jtz48ZwKutb7ZoaXtM3hSUy7qne5Fc+IqQT1zklfC0m9XZj1XhFN6b/3V2pkm501KBPcmWQ1CkB62/+0NaWHymRVCcJ2ddw3l30+yaL1fgmrrpllHR1CBpYll4U9kg5op80xR/KIFY4zjP5dJWD2XYz9I/XTgpeGOpriy8HVCYOtVPKkYZp3n9mC5Ixk1KS7cB0NIy+A17K7D9s6Z1AtC9xuqEG5rxwh7jNOKPBHOvOiU2a2aAEzN8B4Yh6kTzC1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsnLrG5PzNCCqGc4bGL/AuuXen7WkXnkTvi3U/x0Yrc=;
 b=WxxA1bKHsixQwtwMov6yQ6Rh4bHQimUxq8M0hvL4ZWDjvJvPEaUMXUoCGj5KToZZHq4zSlvewvIoVEEANOOHDs/sC+Gm2nisHkL5PwP73qqw5bnpfcVYFfEncwetGwAMABUFMz29EWW+Qjdn351v1sx2/0ij4d+8AmkYWsnZOtfN5MRugnN0KcdrhxmptwWEjESM3q7hryBHZs+abLS9+yUhKwFcR8aByQoaENEKFkQzpEhjPHD7XwH9PxLQZmTsCQzdTlpNvYy7YfqZCfafFzGdCMbQyOSsJVN03GmHJti3+4L1ZnmhSl5D0hyWauNRF1LrJovf5tCoczlR/wvttA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3087.namprd12.prod.outlook.com (20.178.244.160) by
 MN2PR12MB4320.namprd12.prod.outlook.com (10.255.224.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Tue, 26 Nov 2019 09:43:20 +0000
Received: from MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::cccb:bf15:7930:7a15]) by MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::cccb:bf15:7930:7a15%5]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 09:43:19 +0000
From: Xiaojie Yuan <xiaojie.yuan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/gfx10: unlock srbm_mutex after queue programming
 finish
Date: Tue, 26 Nov 2019 17:42:51 +0800
Message-Id: <20191126094251.32368-1-xiaojie.yuan@amd.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: HK2P15301CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::14) To MN2PR12MB3087.namprd12.prod.outlook.com
 (2603:10b6:208:d2::32)
MIME-Version: 1.0
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 644836af-67b3-4724-ea0b-08d77255120d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4320:|MN2PR12MB4320:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4320BBAA4933A2B57BE4A3F189450@MN2PR12MB4320.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-Forefront-PRVS: 0233768B38
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(189003)(199004)(36756003)(51416003)(8676002)(14444005)(52116002)(6116002)(316002)(2351001)(6512007)(25786009)(7736002)(99286004)(6916009)(2906002)(26005)(44832011)(6666004)(6506007)(386003)(478600001)(305945005)(4326008)(186003)(66066001)(50226002)(2616005)(8936002)(47776003)(81156014)(6436002)(48376002)(81166006)(14454004)(66946007)(86362001)(2361001)(2870700001)(3846002)(1076003)(6486002)(66476007)(66556008)(5660300002)(50466002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4320;
 H:MN2PR12MB3087.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FYcdtFWNU6VWX0gBOOIY8n3T7Stc54X+KhRjiMPnorGgawuAcenI/SjC+yDR2AqRS3sm9to2/WjbQv0SmTZdtPm5bLbmNcn5uPoutgmJEenVL5fzl+VrMtqFvI0pBTXYJbjsziHdt5qDwegrIfYO8CGpHAp4yjvF9XlmFrVaaQSvYcK3tu6GNuBa7kKrbx7BzEH0Rsf0/3RdLK2tuHbCpF0p2vLSFgtQci3bW376P5YBRDkXYQ1I8bi+hOmxfX3CFYqoa4LCAXMphkHjwMmvWfUG0cD7hWR89I+7d3BkQEAF7rFpiuW3297ZbuKqdf9r+n3Gs8nOT7f858o7bWkFNKloentokjf1UmnQZiacGu14N5qcY5/U8z3RuqqcXDi/O4Slfc/E+o5Ty/iAui4/ZmRXLYabH3BoXCKXHVyoNEwsIocGq4bMkXPpnbWC7jzH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 644836af-67b3-4724-ea0b-08d77255120d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 09:43:19.9171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGDBvXMhy8DfR3V07uNOiOJxsCbsobEv5oeEQ8IoXznF70GxBMvXvmi2UVjI8ORU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsnLrG5PzNCCqGc4bGL/AuuXen7WkXnkTvi3U/x0Yrc=;
 b=jiRywEYjUeyZXncVd0YmC9q0HQzAUmbWovQJvhsL4f9cROBvGzwUbxACIrVwPBPI2pRafmtq2FDeQGOX7bYvTQK2O1ilM0dJvxCduYxKmWzsCWXJ99T1ecBIL7T51FEEFRjUrFfBQtsph4hyE+sF83iFDl8Fbqe8AYxiyq0QebE=
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
Cc: jack.xiao@amd.com, Xiaojie Yuan <xiaojie.yuan@amd.com>,
 hawking.zhang@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191126094251.Kkxz9vSVpA_SH2XxdN-4yTtSEDIK989s3I8ieOMey2U@z>

c3JibV9tdXRleCBpcyB0byBndWFyYW50ZWUgYXRvbWljaXR5IGZvciByL3cgb2YgZ2Z4IGluZGV4
ZWQgcmVnaXN0ZXJzCgpTaWduZWQtb2ZmLWJ5OiBYaWFvamllIFl1YW4gPHhpYW9qaWUueXVhbkBh
bWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIHwgNSAr
KystLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCmluZGV4IDZiZDhkMDZkYmRlOS4uODZk
YjQwNzE3ZDM4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEw
XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYwpAQCAtMjc0
Miw3ICsyNzQyLDcgQEAgc3RhdGljIGludCBnZnhfdjEwXzBfY3BfZ2Z4X3Jlc3VtZShzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldikKIAkvKiBJbml0IGdmeCByaW5nIDAgZm9yIHBpcGUgMCAqLwog
CW11dGV4X2xvY2soJmFkZXYtPnNyYm1fbXV0ZXgpOwogCWdmeF92MTBfMF9jcF9nZnhfc3dpdGNo
X3BpcGUoYWRldiwgUElQRV9JRDApOwotCW11dGV4X3VubG9jaygmYWRldi0+c3JibV9tdXRleCk7
CisKIAkvKiBTZXQgcmluZyBidWZmZXIgc2l6ZSAqLwogCXJpbmcgPSAmYWRldi0+Z2Z4LmdmeF9y
aW5nWzBdOwogCXJiX2J1ZnN6ID0gb3JkZXJfYmFzZV8yKHJpbmctPnJpbmdfc2l6ZSAvIDgpOwpA
QCAtMjc4MCwxMSArMjc4MCwxMSBAQCBzdGF0aWMgaW50IGdmeF92MTBfMF9jcF9nZnhfcmVzdW1l
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCVdSRUczMl9TT0MxNShHQywgMCwgbW1DUF9S
Ql9BQ1RJVkUsIDEpOwogCiAJZ2Z4X3YxMF8wX2NwX2dmeF9zZXRfZG9vcmJlbGwoYWRldiwgcmlu
Zyk7CisJbXV0ZXhfdW5sb2NrKCZhZGV2LT5zcmJtX211dGV4KTsKIAogCS8qIEluaXQgZ2Z4IHJp
bmcgMSBmb3IgcGlwZSAxICovCiAJbXV0ZXhfbG9jaygmYWRldi0+c3JibV9tdXRleCk7CiAJZ2Z4
X3YxMF8wX2NwX2dmeF9zd2l0Y2hfcGlwZShhZGV2LCBQSVBFX0lEMSk7Ci0JbXV0ZXhfdW5sb2Nr
KCZhZGV2LT5zcmJtX211dGV4KTsKIAlyaW5nID0gJmFkZXYtPmdmeC5nZnhfcmluZ1sxXTsKIAly
Yl9idWZzeiA9IG9yZGVyX2Jhc2VfMihyaW5nLT5yaW5nX3NpemUgLyA4KTsKIAl0bXAgPSBSRUdf
U0VUX0ZJRUxEKDAsIENQX1JCMV9DTlRMLCBSQl9CVUZTWiwgcmJfYnVmc3opOwpAQCAtMjgxNCw2
ICsyODE0LDcgQEAgc3RhdGljIGludCBnZnhfdjEwXzBfY3BfZ2Z4X3Jlc3VtZShzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldikKIAlXUkVHMzJfU09DMTUoR0MsIDAsIG1tQ1BfUkIxX0FDVElWRSwg
MSk7CiAKIAlnZnhfdjEwXzBfY3BfZ2Z4X3NldF9kb29yYmVsbChhZGV2LCByaW5nKTsKKwltdXRl
eF91bmxvY2soJmFkZXYtPnNyYm1fbXV0ZXgpOwogCiAJLyogU3dpdGNoIHRvIHBpcGUgMCAqLwog
CW11dGV4X2xvY2soJmFkZXYtPnNyYm1fbXV0ZXgpOwotLSAKMi4yMC4xCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
