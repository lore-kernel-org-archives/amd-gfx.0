Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6FFC17441
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C44A2184C
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C44A2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 204676EA37;
	Tue, 12 Nov 2019 00:34:02 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800044.outbound.protection.outlook.com [40.107.80.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4120F6EA2E
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 00:33:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvKBpfvQ81QhkumYFHkGlFCz5oTa+Jb1TBJe6JQdWVsd5vzo857ItdRyX+f0gki7N7PFhbMsp8GTCHUz8SWh2L5IXIn7fMQ5ruujx8/OUgb2GAnp1AwwZW9yE3JpqxR+Aj+b2GvQbz/cM1bE0RwSiWpkh/szmYOv29bcvgsz2qwexP54V3POJGWdWv0DM65nm5h1+1bgHOGwT7Yc/6yWLV8jpp9JT+2fD3WPBKK6o4s/6wxbt5cizqld06+ie7noz7I4ezgwBjrNMtI42w7oaxOvTsGWVH721iujhL3Gf4XOpbmVDyMn4ldJ94bYSh5PrBHlxzMhI6O7HdtSpquw2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MY67WqoAbo5w4eZjxRJl5J5zC3Fu5LepK56qOkXY3zo=;
 b=cGTdSq0tabvk5WbMfsbwnU7Y4rjHFV1OiQyrZ+cVIJrA9ZvAVuEx9mXDbPdwzKjBsCFgq0QHeUnLmg/YYTcG0YqxHZK0IEWTI0xtPmfZND1UCPLbmn9nQpFT1vgj2o/zuaVSgBNBcRUEeBJRWbGYhIqtvNntf7XSeizH+LBa+cwpTHc5vqQFpUD/FnV0OSOK+Hj1oLHPU5FJL4AE39GgFP/Y2GfVGzooCUX0B4/k53BF/NueL7ba8tf7WLp5pba1k00sTyxoacoUqsOKEBkAB97rXRAFc37hXaKyJG/ZrW/Di4V/cAOKf0pz1zpKCT3iOtBVPDV96HBwP8OBiFlCmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2554.namprd12.prod.outlook.com (52.132.180.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 00:33:53 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 00:33:53 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/30] drm/amd/display: Add debugfs initalization on mst
 connectors
Date: Mon, 11 Nov 2019 19:33:06 -0500
Message-Id: <20191112003324.8419-13-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 191216da-c92d-4ab6-e1c6-08d76707fec6
X-MS-TrafficTypeDiagnostic: MW2PR12MB2554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25544434DEB6E06D068DCE4898770@MW2PR12MB2554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(189003)(199004)(76176011)(6916009)(81166006)(81156014)(386003)(8676002)(478600001)(6506007)(51416003)(52116002)(2870700001)(25786009)(5024004)(2906002)(186003)(2361001)(3846002)(316002)(66066001)(47776003)(50466002)(4326008)(26005)(66946007)(6116002)(36756003)(1076003)(8936002)(48376002)(50226002)(54906003)(2616005)(305945005)(486006)(5660300002)(6512007)(14454004)(2351001)(446003)(6486002)(6666004)(99286004)(66556008)(476003)(66476007)(11346002)(86362001)(6436002)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2554;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ywz5py1MPXB0Xq4r36GDFNIm9y1wpStqTPpn5pnlt0IU1REzbepvigQsLiK2CxNzN1+tBtun9yHyIY8lpsxLAU+InGoJnijQPlA4BxENY4AK88oWBjNLbjsf1YXmuk5MmDwd5VkMfvzueD8z2bItHSZ68YlfLvNmAeBA+LCPb86QbXdPRrvR2YRZCUo2/XcJo6GU+37pppccefOd/zVEhkxqzqDg18L7/x8P3qTKSHcbOQbb4/fvthPVhL5e+dh/QD1TDJdptS0il8kSGSl6/Z0Z3M2Yq/oVyQiIyMx6L0qAaW1TS1EC12HU4Le7YUJg7n4AjUV+q/MSERxuyWvuuvnSassxZFRxS+me0SXShF9j0/yVFDhJGlfsfg3V9vXjBlgfpyihH7+ZBq4jh5GhzUr7qBzBF+LBc8vFoDIe0Lwac3bMWdspeQascYTL5FRd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 191216da-c92d-4ab6-e1c6-08d76707fec6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 00:33:53.4872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +golN2uB5wbrLT3ZMADrx8Mu3bRTDzTM7qEvQX2uJS7S54AopvCNIukSnoh3/gxnPPiCk06a5Ug2EjlNqqhkFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2554
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MY67WqoAbo5w4eZjxRJl5J5zC3Fu5LepK56qOkXY3zo=;
 b=AvoTj0Oy0SmoDKVcfwX+bqTMzgrlqLQ357CsF51BczGCITtHY3BEs71a6DiSYXtm52X1Y3QPoaHBqeVcLNi2EHLFoop4DDouQkA//af6EYN8c7u2CaaehLesPAtvxk8uVvint/mISh5ORPmkUaL5f8DW98bH7XBG+70C/g/usos=
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
Cc: Mikita Lipski <mikita.lipski@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112003306.ApCVGao6g0vpus1A1AFjrfDU1KYH_GA7n-Cjx3hLtjY@z>

RnJvbTogTWlraXRhIExpcHNraSA8bWlraXRhLmxpcHNraUBhbWQuY29tPgoKW3doeV0KV2Ugd2Vy
ZSBtaXNzaW5nIGRlYnVnZnMgZmlsZXMgb24gTVNUIGNvbm5lY3RvcnMgYXMgdGhlIGZpbGVzCndl
cmVuJ3QgaW5pdGlhbGl6ZWQuCgpbaG93XQpNb3ZlIGNvbm5lY3RvciBkZWJ1Z2ZzIGluaXRpYWxp
emF0aW9uIGludG8gY29ubm9jdG9yJ3MKaW5pdCBoZWxwZXIgZnVuY3Rpb24gc28gaXQgd2lsbCBi
ZSBjYWxsZWQgYnkgYm90aCBTU1QgYW5kIE1TVApjb25uZWN0b3JzLiBBbHNvIG1vdmUgY29ubmVj
dG9yIHJlZ2lzdHJhdGlvbiBzbyBpdCB3aWxsIGJlCnJlZ2lzdGVyZWQgYmVmb3JlIHdlIGNyZWF0
ZSB0aGUgZW50cmllcy4KClNpZ25lZC1vZmYtYnk6IE1pa2l0YSBMaXBza2kgPG1pa2l0YS5saXBz
a2lAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IE5pY2hvbGFzIEthemxhdXNrYXMgPE5pY2hvbGFzLkth
emxhdXNrYXNAYW1kLmNvbT4KQWNrZWQtYnk6IFJvZHJpZ28gU2lxdWVpcmEgPFJvZHJpZ28uU2lx
dWVpcmFAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2Rt
L2FtZGdwdV9kbS5jIHwgMTUgKysrKysrKystLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNl
cnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCmluZGV4IDU1NzNjNWQ5YjMyOC4uMDVlMDE5NWQw
MDA1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2Ft
ZGdwdV9kbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1k
Z3B1X2RtLmMKQEAgLTU2NjEsNiArNTY2MSwxMiBAQCB2b2lkIGFtZGdwdV9kbV9jb25uZWN0b3Jf
aW5pdF9oZWxwZXIoc3RydWN0IGFtZGdwdV9kaXNwbGF5X21hbmFnZXIgKmRtLAogCQlkcm1fb2Jq
ZWN0X2F0dGFjaF9wcm9wZXJ0eSgmYWNvbm5lY3Rvci0+YmFzZS5iYXNlLAogCQkJCWFkZXYtPm1v
ZGVfaW5mby5mcmVlc3luY19jYXBhYmxlX3Byb3BlcnR5LCAwKTsKIAl9CisKKyNpZiBkZWZpbmVk
KENPTkZJR19ERUJVR19GUykKKwljb25uZWN0b3JfZGVidWdmc19pbml0KGFjb25uZWN0b3IpOwor
CWFjb25uZWN0b3ItPmRlYnVnZnNfZHBjZF9hZGRyZXNzID0gMDsKKwlhY29ubmVjdG9yLT5kZWJ1
Z2ZzX2RwY2Rfc2l6ZSA9IDA7CisjZW5kaWYKIH0KIAogc3RhdGljIGludCBhbWRncHVfZG1faTJj
X3hmZXIoc3RydWN0IGkyY19hZGFwdGVyICppMmNfYWRhcCwKQEAgLTU3ODMsNiArNTc4OSw4IEBA
IHN0YXRpYyBpbnQgYW1kZ3B1X2RtX2Nvbm5lY3Rvcl9pbml0KHN0cnVjdCBhbWRncHVfZGlzcGxh
eV9tYW5hZ2VyICpkbSwKIAkJCSZhY29ubmVjdG9yLT5iYXNlLAogCQkJJmFtZGdwdV9kbV9jb25u
ZWN0b3JfaGVscGVyX2Z1bmNzKTsKIAorCWRybV9jb25uZWN0b3JfcmVnaXN0ZXIoJmFjb25uZWN0
b3ItPmJhc2UpOworCiAJYW1kZ3B1X2RtX2Nvbm5lY3Rvcl9pbml0X2hlbHBlcigKIAkJZG0sCiAJ
CWFjb25uZWN0b3IsCkBAIC01NzkzLDEzICs1ODAxLDYgQEAgc3RhdGljIGludCBhbWRncHVfZG1f
Y29ubmVjdG9yX2luaXQoc3RydWN0IGFtZGdwdV9kaXNwbGF5X21hbmFnZXIgKmRtLAogCWRybV9j
b25uZWN0b3JfYXR0YWNoX2VuY29kZXIoCiAJCSZhY29ubmVjdG9yLT5iYXNlLCAmYWVuY29kZXIt
PmJhc2UpOwogCi0JZHJtX2Nvbm5lY3Rvcl9yZWdpc3RlcigmYWNvbm5lY3Rvci0+YmFzZSk7Ci0j
aWYgZGVmaW5lZChDT05GSUdfREVCVUdfRlMpCi0JY29ubmVjdG9yX2RlYnVnZnNfaW5pdChhY29u
bmVjdG9yKTsKLQlhY29ubmVjdG9yLT5kZWJ1Z2ZzX2RwY2RfYWRkcmVzcyA9IDA7Ci0JYWNvbm5l
Y3Rvci0+ZGVidWdmc19kcGNkX3NpemUgPSAwOwotI2VuZGlmCi0KIAlpZiAoY29ubmVjdG9yX3R5
cGUgPT0gRFJNX01PREVfQ09OTkVDVE9SX0Rpc3BsYXlQb3J0CiAJCXx8IGNvbm5lY3Rvcl90eXBl
ID09IERSTV9NT0RFX0NPTk5FQ1RPUl9lRFApCiAJCWFtZGdwdV9kbV9pbml0aWFsaXplX2RwX2Nv
bm5lY3RvcihkbSwgYWNvbm5lY3Rvcik7Ci0tIAoyLjI0LjAKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeA==
