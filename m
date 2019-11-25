Return-Path: <SRS0=lTJr=ZR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D1CC432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 21:28:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 790882071A
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 21:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 790882071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3025589D42;
	Mon, 25 Nov 2019 21:28:37 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760081.outbound.protection.outlook.com [40.107.76.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2BA989D42
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Nov 2019 21:28:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glL20IfP/CP45uk5FFCzgFYkuXKpzHDFOjgaY1R59wkLnsC/wnJD+qMCxmhB/XtRX6Ccc+r6A3NZzpksddrneCKO6eMW2M7tSX84W+BYBFBxrJkM6Du3eW9jXXlMH57GuYT9Ka70TyvcLer8WbOvFBMa4B5Bs09kGE5YtPR/aallrrDfj6mT+BDrKer/WK25XvIbiECOyGzt4WxzprOZRaDSBtJGZIXSwpb0Zm21LXluzCE2rrgmdlL3lx5v8nhLgLASKARtxBC0vNhM7iSa4/BSZ70h6UzzANM7XdFCrM1iyk+gIvDhGs2vlEaE7ESiyFTZKdJCLxey5cJ3i2jh3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYixzyqYmybZjMrABd2cmo/W2vjKkkmmWlNwAwEmrY4=;
 b=HDIFEhh3n8EbCuJmcg+Yth8pkelp24GyaCKnnctJyZbW0EBuGRxdoCa5uFB4xrvN/S+XtJbEMHdZdRlI6UMv4E4suyYwxIof2/3P0UOh+uM9Mj8cjxF5qtF2pEd249sXTNXRFYgh4qcnlc7T7raN2kvyydux6R1PpuRSn6pZg2yEOv+yLEMkIblftT0UqZhoOTHgjWNgrWhhvzib0D6GVr1bCZS2kEdZWLugNizlsD7Y3rTUw5vTKTejqJ6qJZXebAByeF9xhOwawhXl4VGZ37s958WpetUkBTrzcz7iCpKPPV3berYQppKrzN/+wBYi4VbR4Lffw/Tjr7Jl5x9+5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.175.222) by
 DM6PR12MB3561.namprd12.prod.outlook.com (20.178.199.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Mon, 25 Nov 2019 21:28:33 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560%3]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 21:28:33 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: Raise KFD unpinned system memory limit
Date: Mon, 25 Nov 2019 16:28:19 -0500
Message-Id: <20191125212819.21392-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.24.0
X-ClientProxiedBy: YTOPR0101CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::47) To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:148::30)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3e7fde24-ad6e-464a-1be4-08d771ee6c87
X-MS-TrafficTypeDiagnostic: DM6PR12MB3561:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3561C3367BB52BBAB6B1EE9B924A0@DM6PR12MB3561.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:366;
X-Forefront-PRVS: 0232B30BBC
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(199004)(189003)(305945005)(25786009)(316002)(7736002)(2361001)(36756003)(2616005)(14454004)(6916009)(478600001)(186003)(26005)(81156014)(8676002)(8936002)(81166006)(3846002)(50226002)(2870700001)(2906002)(6116002)(14444005)(66476007)(66556008)(48376002)(50466002)(6436002)(51416003)(2351001)(99286004)(52116002)(6512007)(6486002)(47776003)(6666004)(66066001)(386003)(6506007)(5660300002)(86362001)(1076003)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3561;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8wl5v6JfneNeC1rhBr2vh34+O/xDa5i/4EFuKWR0w6WDILh1ZbWLhFs9BSdkMHRTfhnOHuUQ0lAYBg42Mp7+gBcukmQTyqdb28hgvyJbf5zb3OpY0vj+NhVEQlbGWOnUNhjOLWcTWrC9laa7iZ4UB8hlq/f9RiiGH3PZ0QZqRsthnTM4rVIpyQj3gaZkQ+ZL5bCRuHS7fiIxHDskCe/I/2qbHdYLDgTZqpNBj2/lUT+etcCte1xDT1e536BHQvsHAQSDsULArNwdcSb5RkqwZOOglkFJxDiXhHbDlmaF1wnjYL/15bqvzTYvmZdq6Fg//H7MvNF8zxAdt1577c8MD0pKHtBXWwEeGmj1Y4QPwY9W6ytg9014aaYgC+xbuDu+KxWeOKfaJ7fkPQhRrfVs1SYw/WwXy99yLv9aphyVJ3yc1c4q4SU4CRp87TSm7BHl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e7fde24-ad6e-464a-1be4-08d771ee6c87
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2019 21:28:33.5652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G6Q590utkNZIl+0/BIQKk1+oHP930/LwltGMhDwDu/kzl8Mj06MY4iaqsvBLtbS4/vgzVe6l+cMVLuULhyyHXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3561
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYixzyqYmybZjMrABd2cmo/W2vjKkkmmWlNwAwEmrY4=;
 b=1IyZi3yYIv4whBlLLhLT1wP14MpakLYhxajPYNGQqHNZRdLFTFd5NauwX0IVB6npnGP90QKGafu7Dl/HUPYmaD5+/JStmSmiIlS31jvewGl4uWER9hfMVHnYCfKtTE8xHGCyg4sOT6fi8Lkw0nbMq1g67lYF5m1e+6u7zHeSgg8=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191125212819.k6ZtE8h0E2CgG3VdvzClz5D_oftPJdJvidQVCBOdXXE@z>

QWxsb3cgS0ZEIGFwcGxpY2F0aW9ucyB0byB1c2UgbW9yZSB1bnBpbm5lZCBzeXN0ZW0gbWVtb3J5
IHRocm91Z2gKSE1NLgoKU2lnbmVkLW9mZi1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhs
aW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtm
ZF9ncHV2bS5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hbWRrZmRfZ3B1dm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRr
ZmRfZ3B1dm0uYwppbmRleCBlNDNhOTU1MTRiNDEuLmI2ZDE5NThkNTE0ZiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYwpAQCAtODUsNyAr
ODUsNyBAQCBzdGF0aWMgYm9vbCBjaGVja19pZl9hZGRfYm9fdG9fdm0oc3RydWN0IGFtZGdwdV92
bSAqYXZtLAogfQogCiAvKiBTZXQgbWVtb3J5IHVzYWdlIGxpbWl0cy4gQ3VycmVudCwgbGltaXRz
IGFyZQotICogIFN5c3RlbSAoVFRNICsgdXNlcnB0cikgbWVtb3J5IC0gMy80dGggU3lzdGVtIFJB
TQorICogIFN5c3RlbSAoVFRNICsgdXNlcnB0cikgbWVtb3J5IC0gMTUvMTZ0aCBTeXN0ZW0gUkFN
CiAgKiAgVFRNIG1lbW9yeSAtIDMvOHRoIFN5c3RlbSBSQU0KICAqLwogdm9pZCBhbWRncHVfYW1k
a2ZkX2dwdXZtX2luaXRfbWVtX2xpbWl0cyh2b2lkKQpAQCAtOTgsNyArOTgsNyBAQCB2b2lkIGFt
ZGdwdV9hbWRrZmRfZ3B1dm1faW5pdF9tZW1fbGltaXRzKHZvaWQpCiAJbWVtICo9IHNpLm1lbV91
bml0OwogCiAJc3Bpbl9sb2NrX2luaXQoJmtmZF9tZW1fbGltaXQubWVtX2xpbWl0X2xvY2spOwot
CWtmZF9tZW1fbGltaXQubWF4X3N5c3RlbV9tZW1fbGltaXQgPSAobWVtID4+IDEpICsgKG1lbSA+
PiAyKTsKKwlrZmRfbWVtX2xpbWl0Lm1heF9zeXN0ZW1fbWVtX2xpbWl0ID0gbWVtIC0gKG1lbSA+
PiA0KTsKIAlrZmRfbWVtX2xpbWl0Lm1heF90dG1fbWVtX2xpbWl0ID0gKG1lbSA+PiAxKSAtICht
ZW0gPj4gMyk7CiAJcHJfZGVidWcoIktlcm5lbCBtZW1vcnkgbGltaXQgJWxsdU0sIFRUTSBsaW1p
dCAlbGx1TVxuIiwKIAkJKGtmZF9tZW1fbGltaXQubWF4X3N5c3RlbV9tZW1fbGltaXQgPj4gMjAp
LAotLSAKMi4yNC4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
