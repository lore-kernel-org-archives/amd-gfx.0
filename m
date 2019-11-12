Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DADEC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:34:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ADF42184C
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ADF42184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 096DD6EA35;
	Tue, 12 Nov 2019 00:34:04 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800087.outbound.protection.outlook.com [40.107.80.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 204826EA38
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 00:34:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjslxshwDsg8qXcxJOXQvys8gmfAYgTuuFXhYU/9OVl4tQGJF0ExAwmKu8F+WjB0PoH0/898Eqvngeyej5bLN3urDOgKzkUYGjIDi6n67gVpIuMqn+QyzObXrlSMOAnVnB/DNaeVZ+pa18It7bI/lVV3sbfsekZXffLXmgpf5j2SAYWi75zaVzqFBP+ZJVoC2wNYhKlvhvRGlamrW5YuGZ+Ke0YESYuTfwzPvGxebap8h/iQT/I5DYBRjoOlVTvbjA42xA4g19ZV05L2/u5whgWJMWf19tqaHzoIjmOlGBBJ4gEZtnelo4E9LGg4Ymc46VhxmGVSio2rvzSEDDTzJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTNZSXaUrVYkECRRI/K7WwiSkLA0NKmsGFX4gvqjy9I=;
 b=b7M7igGt/JljncnxvTqtRvMO8raZ8vpjWK530JiZ8sUjtoG+/JZ1aEqisi2n8F4gOlWf7EVonLkHeEOrucV/oi1zuvmOkp14IaA3h5PZV0zOUJzg0amwNGyPHQb8dibCz5gek2qNchz+tOvj/kYcOrNpVcHn1VQ7xyeRfIrGWIhc5UFkVu1wnl8oLpn3zPfIq9wOtf+hpNa7SNOu3KIpZEwLQkNkZ4A0l/ZzcDd0eUddVu8JcshcZcevYkf+F3t8OK7+GAYJo/y9Wk1VuLmg+XvlL3LsiQNNEGeKahmnJb9R2ut4nVZvwSv657zZ7iTGW65MaYxKylkqjEj7jL7LyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2554.namprd12.prod.outlook.com (52.132.180.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 00:34:00 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 00:34:00 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 22/30] drm/amd/display: add debugfs sdp hook up function for
 Navi
Date: Mon, 11 Nov 2019 19:33:16 -0500
Message-Id: <20191112003324.8419-23-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112003324.8419-1-Rodrigo.Siqueira@amd.com>
References: <20191112003324.8419-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 71a33220-0342-4e07-4cf5-08d7670802fc
X-MS-TrafficTypeDiagnostic: MW2PR12MB2554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB255421A114EA7BB205B3ED0998770@MW2PR12MB2554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(189003)(199004)(76176011)(6916009)(81166006)(81156014)(386003)(8676002)(478600001)(6506007)(51416003)(52116002)(2870700001)(25786009)(14444005)(2906002)(186003)(2361001)(3846002)(316002)(66066001)(47776003)(50466002)(4326008)(26005)(66946007)(6116002)(36756003)(1076003)(8936002)(48376002)(50226002)(54906003)(2616005)(305945005)(486006)(5660300002)(6512007)(14454004)(2351001)(446003)(6486002)(6666004)(99286004)(66556008)(476003)(66476007)(11346002)(86362001)(6436002)(7736002)(52103002)(158003001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2554;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: shV+KTm7ta+6eT8HDZVrkuP7wGwcjwITy6iKCNl87cwKYunLnNVHS78dvJcaj7b9cT/y0doXxFwn0TtsHH2wQNq6W+atZAgyxXxRn+z30IlbYG5xdqqbfX3qzUoQj69t+2SNMOIEJFIaG64ivXFT73VM1RVg1GhHACD39iMEXoIML9uMbfRT3m0xBTVVIBZmdh0yS5pE7PIhwiomPUHxcGczPy3R3BkugU/ytt7f/fheGrof3rlfVpXEkXzB2BPziR0zX1ciDVYgYSeBXp6j609GiuS31TaieZV9VOgCkPWeA5NEP8xsGnfzAJB1dWzB1L0eBT0hmMGJR8kP/xb63HeYMl6edrjs2hmTXVdtyOf42pE2QPUgQWx6Cxc5NOywMatHXu95vgwwFA2kSYF2Nd0LOQ5Aya7CdFuI8OPnS+KWeV+zFG85hVma/A5orE6p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a33220-0342-4e07-4cf5-08d7670802fc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 00:34:00.6471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aq6Wbh22xb8zrr64foyZNCJv/IqITO+QeUYyLIAnF+IXKPGk6+Vnr6ZIPzXLlNhbveDNqqUgWAe77QmmljmnDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2554
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTNZSXaUrVYkECRRI/K7WwiSkLA0NKmsGFX4gvqjy9I=;
 b=nuNfyDq67KbivQtCxsNyUB7WZgL1DwHT1v6DeNKrfbEyWUT+O0OZQRde0Ik0A3nx68EYslfXEskRBxzwDpyvWAz0nVS3CslqPMIdynYl/W6W3ouvr+HizHpj7bUnoHyQ59+SipG9sKqpNopr8TapEE15wtr+jeGGZlYh4mNHOtE=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
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
Cc: Harry Wentland <Harry.Wentland@amd.com>,
 "David \(Dingchen\) Zhang" <dingchen.zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112003316.GlSncnXucbuwuVPTLW_bkCiIZlWqqSe2vYvPcjjCdU8@z>

RnJvbTogIkRhdmlkIChEaW5nY2hlbikgWmhhbmciIDxkaW5nY2hlbi56aGFuZ0BhbWQuY29tPgoK
W3doeV0KbmVlZCB0byBzZW5kIGltbWVkaWF0ZSBTRFAgbWVzc2FnZSB2aWEgZGVidWdmcyBvbiBO
YXZpIGJvYXJkLgoKW2hvd10KaG9vayB1cCB0aGUgRENOMXggZW5jb2RlciBmdW5jdGlvbiBvZiBz
ZW5kaW5nIGltbWVkaWF0ZSBzZHAKbWVzc2FnZSB0byBEQ04yLgoKU2lnbmVkLW9mZi1ieTogRGF2
aWQgKERpbmdjaGVuKSBaaGFuZyA8ZGluZ2NoZW4uemhhbmdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6
IEhhcnJ5IFdlbnRsYW5kIDxIYXJyeS5XZW50bGFuZEBhbWQuY29tPgpBY2tlZC1ieTogUm9kcmln
byBTaXF1ZWlyYSA8Um9kcmlnby5TaXF1ZWlyYUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9zdHJlYW1fZW5jb2Rlci5jIHwgMiArKwogMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9zdHJlYW1fZW5jb2Rlci5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX3N0cmVhbV9lbmNvZGVyLmMKaW5kZXgg
MzNjYzQwZmI5Njg3Li5iZTA5Nzg0MDE0NzYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9zdHJlYW1fZW5jb2Rlci5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9zdHJlYW1fZW5jb2Rlci5jCkBAIC01
NjEsNiArNTYxLDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBzdHJlYW1fZW5jb2Rlcl9mdW5jcyBk
Y24yMF9zdHJfZW5jX2Z1bmNzID0gewogCQllbmMyX3N0cmVhbV9lbmNvZGVyX3N0b3BfaGRtaV9p
bmZvX3BhY2tldHMsCiAJLnVwZGF0ZV9kcF9pbmZvX3BhY2tldHMgPQogCQllbmMyX3N0cmVhbV9l
bmNvZGVyX3VwZGF0ZV9kcF9pbmZvX3BhY2tldHMsCisJLnNlbmRfaW1tZWRpYXRlX3NkcF9tZXNz
YWdlID0KKwkJZW5jMV9zdHJlYW1fZW5jb2Rlcl9zZW5kX2ltbWVkaWF0ZV9zZHBfbWVzc2FnZSwK
IAkuc3RvcF9kcF9pbmZvX3BhY2tldHMgPQogCQllbmMxX3N0cmVhbV9lbmNvZGVyX3N0b3BfZHBf
aW5mb19wYWNrZXRzLAogCS5kcF9ibGFuayA9Ci0tIAoyLjI0LjAKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
