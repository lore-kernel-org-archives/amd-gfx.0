Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC4EC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:34:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D5D72184C
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5D72184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C36C6EA41;
	Tue, 12 Nov 2019 00:34:10 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730089.outbound.protection.outlook.com [40.107.73.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 886C36EA41
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 00:34:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCsN5d6Ow8DNJqauJNARWpDIznFh9f/aw6aiilmA8nJy9kQ8UayyLd8QHiICCTk6lZ7aTqVow4agiABjNXauEFA3jKKjHxGuwRVpzzjtBg+4LAWBzdlFij6vzZV/2bNHKtqGfpcgXkYshZozBGtUrb8IfIYeMg3iz2ykQzd5U6Nnc/iK9OVizxnOZNfNfRodLmhETI2mE8go+q11pWaC4dZ3mWJVABwwF08O4sZAWWXyCIzjA3I9xcvyC0mIjSIJyotyS7syw4o0oLnzp5v3spVwBXQ9gzCh0C989yGclhJYSRt4Nzu4rFjZsG0NsutLTtvxhTQcEJKW0KB5QGdYEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=my/oCr9j5bYSWGN43P1ohOd3/hBE8mDhdl04usJpjpU=;
 b=HPj6p/vXRA3rMWpxJRfvJ8xh8ZdcJLJaWnfuXlhrgVHxTEJUYy0Dxtrv/xSugosKXn6WTQuBb65kxI/KZXicGughOuTeAfWQh091U8eCqX0LNLobrtmLD2hDW7fbhNaHNM/nHZKHhwIyRutc/KyAO7/O5GbYhETh4kaHsAB3lsHQj9KvvFmXYBxNHoO4M25kY1NlVH/j7lSAJLg4eIdaKymTBNXDIvHmL10QhwHNC9MzR02NF7r5AZlU7Yt5cEjisthHBVuSzaKGiT2dPwpmck01G23utndteEfrFB/XxU4LtVu950KnAgUzZtd00a1LybkzO8MLO0awhwD/BHwZ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2554.namprd12.prod.outlook.com (52.132.180.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 00:34:05 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 00:34:04 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 28/30] drm/amd/display: Use a temporary copy of the current
 state when updating DSC config
Date: Mon, 11 Nov 2019 19:33:22 -0500
Message-Id: <20191112003324.8419-29-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 17462416-ecea-47eb-b314-08d767080588
X-MS-TrafficTypeDiagnostic: MW2PR12MB2554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2554E6AABABFB56CF1A2B1D798770@MW2PR12MB2554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(1496009)(136003)(366004)(396003)(346002)(39860400002)(376002)(189003)(199004)(76176011)(6916009)(81166006)(81156014)(386003)(8676002)(478600001)(6506007)(51416003)(52116002)(2870700001)(25786009)(14444005)(2906002)(186003)(2361001)(3846002)(316002)(66066001)(47776003)(50466002)(4326008)(26005)(66946007)(6116002)(36756003)(1076003)(8936002)(48376002)(50226002)(54906003)(2616005)(305945005)(486006)(5660300002)(6512007)(14454004)(2351001)(446003)(6486002)(6666004)(99286004)(66556008)(476003)(66476007)(11346002)(86362001)(6436002)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2554;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /v1J4em8dtr2i8xhmuqvu35UstgJdYtthdSjUtn+YCN3dji4EmCFCGaRuveE8yE9rWxDxXi/16EihPHMxv3fwa7nda42EcIZGeFJ/KUxj3zCdLTCp7q+anuNKkvPMReOAxV+ASyjmuLfJrbzWKwQVN4ePC+uitwxkdt3wENQOybBC0etBfNdlPyEuLPzSWC9dBfe/jBLiS8+mU/wWkVYFtIub9i2SA6t4LJhHvbzAT3ylkGy806GtxAIeIFv556gNfYeyLUkH10wkzAfjPRP+XjQ3ZcthNieW/xCInKA2Tr90Wcd1HE5YWmqrpbWEhosfKKQbAfAFkCKy+vAa3X+oJh7atFvE0t0oAcM/2vwzP0Ja/EEYoxLOkRKZs/ljCpdbwDhBuqX5byrqs/CQHMzJS6DEPXD6olJnW/xfO92MR856tkwUqhXs8hXD8NXdwvJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17462416-ecea-47eb-b314-08d767080588
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 00:34:04.8757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vu5q1WvKQbUO0Q9XVsbfOXKeM/oCgnxaw80IuhZIgXgP4uOTrkJUDX6Pa2cTP3m2buctnezOtJzlCkloZoSmiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2554
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=my/oCr9j5bYSWGN43P1ohOd3/hBE8mDhdl04usJpjpU=;
 b=Ow0xevxpM50174X1Gu+6t9XvpoL2ys2CxQtu6thsUSfnTAEB2fRDP5y8c9lk4CJdA0uBCk/XQ5PqDtsiq3fdjRBixsIgk6w9Wl8Yv+QHsbOnINEILarByaT5fKLpI3dHNZcInbDbj8Fn0Nd5y6522aN5nm/U1mcetiPqtZU0gig=
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Nikola Cornij <nikola.cornij@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112003322.IREttufJK6WdGvCjYm_T3VqpEM0WzLIamhrJQjNrCfQ@z>

RnJvbTogTmlrb2xhIENvcm5paiA8bmlrb2xhLmNvcm5pakBhbWQuY29tPgoKW3doeV0KV2hlbiB1
cGRhdGluZyBEU0MgY29uZmlnLCBhIG5ldyBjb25maWcgaGFzIHRvIGJlIHZhbGlkYXRlZCBiZWZv
cmUgcHJvY2VlZGluZwp3aXRoIGFwcGx5aW5nIHRoZSB1cGRhdGUuIFZhbGlkYXRpb24sIGhvd2V2
ZXIsIG1vZGlmaWVzIHRoZSBjdXJyZW50IHN0YXRlLgpUaGlzIG1lYW5zIERTQyBjb25maWcgdmFs
aWRhdGlvbiB3b3VsZCBhZmZlY3QgcGlwZSByZS1hc3NpZ25tZW50LCBjYXVzaW5nCmludGVybWl0
dGVudCBzY3JlZW4gY29ycnVwdGlvbiBpc3N1ZXMgd2hlbiBPRE0gaXMgcmVxdWlyZWQgZm9yIERT
Qy4KCltob3ddCi0gVXNlIGEgY29weSBvZiB0aGUgY3VycmVudCBzdGF0ZSBmb3IgbW9kaWZpZWQg
RFNDIGNvbmZpZyB2YWxpZGF0aW9uCi0gU2V0IHRoZSB1cGRhdGUgdHlwZSB0byBGVUxMX1VQREFU
RSB0byBjb3JyZWN0bHkgdmFsaWRhdGUgYW5kIHNldCB0aGUKICBhY3R1YWwgc3RhdGUgdXNlZCBm
b3IgY29tbWl0dGluZyB0aGUgc3RyZWFtcwoKU2lnbmVkLW9mZi1ieTogTmlrb2xhIENvcm5paiA8
bmlrb2xhLmNvcm5pakBhbWQuY29tPgpSZXZpZXdlZC1ieTogRG15dHJvIExha3R5dXNoa2luIDxE
bXl0cm8uTGFrdHl1c2hraW5AYW1kLmNvbT4KQWNrZWQtYnk6IFJvZHJpZ28gU2lxdWVpcmEgPFJv
ZHJpZ28uU2lxdWVpcmFAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvY29yZS9kYy5jIHwgMzEgKysrKysrKysrKysrKysrKysrLS0tLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgMjQgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2NvcmUvZGMuYwppbmRleCA2MGJjNGMzYTUxOGUuLmVkM2ZkNDFjMDg3OSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jCkBAIC0xNjc4LDYgKzE2Nzgs
OSBAQCBzdGF0aWMgZW51bSBzdXJmYWNlX3VwZGF0ZV90eXBlIGNoZWNrX3VwZGF0ZV9zdXJmYWNl
c19mb3Jfc3RyZWFtKAogCiAJCWlmIChzdHJlYW1fdXBkYXRlLT5vdXRwdXRfY3NjX3RyYW5zZm9y
bSB8fCBzdHJlYW1fdXBkYXRlLT5vdXRwdXRfY29sb3Jfc3BhY2UpCiAJCQlzdV9mbGFncy0+Yml0
cy5vdXRfY3NjID0gMTsKKworCQlpZiAoc3RyZWFtX3VwZGF0ZS0+ZHNjX2NvbmZpZykKKwkJCW92
ZXJhbGxfdHlwZSA9IFVQREFURV9UWVBFX0ZVTEw7CiAJfQogCiAJZm9yIChpID0gMCA7IGkgPCBz
dXJmYWNlX2NvdW50OyBpKyspIHsKQEAgLTE4NjksOCArMTg3MiwxMCBAQCBzdGF0aWMgdm9pZCBj
b3B5X3N1cmZhY2VfdXBkYXRlX3RvX3BsYW5lKAogc3RhdGljIHZvaWQgY29weV9zdHJlYW1fdXBk
YXRlX3RvX3N0cmVhbShzdHJ1Y3QgZGMgKmRjLAogCQkJCQkgc3RydWN0IGRjX3N0YXRlICpjb250
ZXh0LAogCQkJCQkgc3RydWN0IGRjX3N0cmVhbV9zdGF0ZSAqc3RyZWFtLAotCQkJCQkgY29uc3Qg
c3RydWN0IGRjX3N0cmVhbV91cGRhdGUgKnVwZGF0ZSkKKwkJCQkJIHN0cnVjdCBkY19zdHJlYW1f
dXBkYXRlICp1cGRhdGUpCiB7CisJc3RydWN0IGRjX2NvbnRleHQgKmRjX2N0eCA9IGRjLT5jdHg7
CisKIAlpZiAodXBkYXRlID09IE5VTEwgfHwgc3RyZWFtID09IE5VTEwpCiAJCXJldHVybjsKIApA
QCAtMTk0NywxMiArMTk1MiwyNCBAQCBzdGF0aWMgdm9pZCBjb3B5X3N0cmVhbV91cGRhdGVfdG9f
c3RyZWFtKHN0cnVjdCBkYyAqZGMsCiAJCXVpbnQzMl90IGVuYWJsZV9kc2MgPSAodXBkYXRlLT5k
c2NfY29uZmlnLT5udW1fc2xpY2VzX2ggIT0gMCAmJgogCQkJCSAgICAgICB1cGRhdGUtPmRzY19j
b25maWctPm51bV9zbGljZXNfdiAhPSAwKTsKIAotCQlzdHJlYW0tPnRpbWluZy5kc2NfY2ZnID0g
KnVwZGF0ZS0+ZHNjX2NvbmZpZzsKLQkJc3RyZWFtLT50aW1pbmcuZmxhZ3MuRFNDID0gZW5hYmxl
X2RzYzsKLQkJaWYgKCFkYy0+cmVzX3Bvb2wtPmZ1bmNzLT52YWxpZGF0ZV9iYW5kd2lkdGgoZGMs
IGNvbnRleHQsCi0JCQkJCQkJICAgICB0cnVlKSkgewotCQkJc3RyZWFtLT50aW1pbmcuZHNjX2Nm
ZyA9IG9sZF9kc2NfY2ZnOwotCQkJc3RyZWFtLT50aW1pbmcuZmxhZ3MuRFNDID0gb2xkX2RzY19l
bmFibGVkOworCQkvKiBVc2UgdGVtcG9yYXJyeSBjb250ZXh0IGZvciB2YWxpZGF0aW5nIG5ldyBE
U0MgY29uZmlnICovCisJCXN0cnVjdCBkY19zdGF0ZSAqZHNjX3ZhbGlkYXRlX2NvbnRleHQgPSBk
Y19jcmVhdGVfc3RhdGUoZGMpOworCisJCWlmIChkc2NfdmFsaWRhdGVfY29udGV4dCkgeworCQkJ
ZGNfcmVzb3VyY2Vfc3RhdGVfY29weV9jb25zdHJ1Y3QoZGMtPmN1cnJlbnRfc3RhdGUsIGRzY192
YWxpZGF0ZV9jb250ZXh0KTsKKworCQkJc3RyZWFtLT50aW1pbmcuZHNjX2NmZyA9ICp1cGRhdGUt
PmRzY19jb25maWc7CisJCQlzdHJlYW0tPnRpbWluZy5mbGFncy5EU0MgPSBlbmFibGVfZHNjOwor
CQkJaWYgKCFkYy0+cmVzX3Bvb2wtPmZ1bmNzLT52YWxpZGF0ZV9iYW5kd2lkdGgoZGMsIGRzY192
YWxpZGF0ZV9jb250ZXh0LCB0cnVlKSkgeworCQkJCXN0cmVhbS0+dGltaW5nLmRzY19jZmcgPSBv
bGRfZHNjX2NmZzsKKwkJCQlzdHJlYW0tPnRpbWluZy5mbGFncy5EU0MgPSBvbGRfZHNjX2VuYWJs
ZWQ7CisJCQkJdXBkYXRlLT5kc2NfY29uZmlnID0gZmFsc2U7CisJCQl9CisKKwkJCWRjX3JlbGVh
c2Vfc3RhdGUoZHNjX3ZhbGlkYXRlX2NvbnRleHQpOworCQl9IGVsc2UgeworCQkJRENfRVJST1Io
IkZhaWxlZCB0byBhbGxvY2F0ZSBuZXcgdmFsaWRhdGUgY29udGV4dCBmb3IgRFNDIGNoYW5nZVxu
Iik7CisJCQl1cGRhdGUtPmRzY19jb25maWcgPSBmYWxzZTsKIAkJfQogCX0KIH0KLS0gCjIuMjQu
MAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
