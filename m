Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F83BC17443
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 09:25:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E40AE214DB
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 09:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E40AE214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 773426E86C;
	Mon, 11 Nov 2019 09:25:35 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770047.outbound.protection.outlook.com [40.107.77.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3750D6E86D
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 09:25:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSyF8BPA5O5jcZtSaq6ALWynhQBpAW30Ynb6tLVOF6w6sYWdmW+F0I6atCwXdj7DFsJRsDubr8lC6U0kX9bk3THhXUd7BGbRZ644kFf580TzKzAEvxEEWVq9XaxsEoYdcqauNqR9kws5ySlQe9i48yd+OhxUiQkNJdZ6ZfSF4bZM85EjEzj52rWMibCwYTm7PdiHSm9RLLTbYYoKlx16V0TtfpHoQJmq3GhvcqJONXoZGH0W+ruA4TVj7V1MSc++qTqcfLnQdxz7Mi47Citrh2anaPNvxhXU7HePZsrRDLl3izg+wXHXvUmbAKZvPTypwJjIYU4HtYHYKMeDTqAhTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdSnJZqjGzAywNOXIbPZGi6Xipscgu+1TbTIbemyq9M=;
 b=Qbx2E6Am2ZA02B7OFR/oh3xP3NaowTNVLbl/MQ13oc0RkRmTXCiZG7q6TvclO8vWanEvyusBV2HOTX50o0pPtQ3b58MseAJ3WlP2XT0+42fzcrQGnJjFfiDoOxf+S041TJNwr7CGv1FxS2t6KxMXeLh+ck2//NgKaNcJI1NER7dfs9j3JiegXVwuWT1P5FCtfoHEH+Xvq5wniBvs7Qsxio03AUUzvhHPHnxMdwPpgSiVC5EeRGawYOpLD9fUmgwueAZs+gkUL0kDz1uZT5hnfyZsXoFWbAZZZOXZVcHICMiz1MCO20HRUHbolhB2wLc2W3glqI62v51v8GS943WccQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB2928.namprd12.prod.outlook.com (20.179.83.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Mon, 11 Nov 2019 09:25:30 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2430.023; Mon, 11 Nov 2019
 09:25:30 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: avoid DPM reenable process on Navi1x ASICs
Date: Mon, 11 Nov 2019 17:25:06 +0800
Message-Id: <20191111092506.18913-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.0
X-ClientProxiedBy: HK0PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:203:b0::36) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d2caa139-3ab8-4704-08a1-08d766891894
X-MS-TrafficTypeDiagnostic: MN2PR12MB2928:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB292898D497D3073FED572B42E4740@MN2PR12MB2928.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:51;
X-Forefront-PRVS: 0218A015FA
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(199004)(189003)(186003)(2906002)(81156014)(81166006)(8936002)(316002)(486006)(44832011)(25786009)(305945005)(50226002)(7736002)(6916009)(2361001)(52116002)(51416003)(26005)(2351001)(66066001)(2870700001)(36756003)(6666004)(8676002)(386003)(6506007)(14454004)(1076003)(5660300002)(99286004)(6116002)(47776003)(66556008)(66946007)(6486002)(66476007)(48376002)(3846002)(478600001)(4326008)(50466002)(86362001)(6512007)(2616005)(6436002)(476003)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2928;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gUAr7oLIifxB4GGhqNZ2RGcxb/iGjGo2cjyKCJW7FgCO9b6nVAgIdJ1qGRFgxd74NTT5XvvsxpwtuOLFQf1zs9giEAzHnBr0BCON/eZKkO2RE5GCdjCImqy8+9eqrpCksowzNOdEOY0bTg9sKorpeOVEvT1GFxDIIp+i0cGhKpnFMAkmDPrKFbUTZJgjEBCjabOTCWRFFK79aCBV6G93lsaOzcHrQOucveYJ0SaMDwBPJDdhkQXTfzK2i3Ccwv4OgY9bi5HGRoe8m2+jS9nQuHrRbmLy+56WQdbPr5C5Wctfcl5sne42JR4ocemBB937woWQKbkQ0/RaxFuHIeyVvrZQzvauuWH/PloHgi8SnVf9Yb9UCvyZljt9LPLZzT/rfUQDJHdinWvwS6mChZXqqWCJM+xOJ9BVR7Mp2bl48kDTnow7r6XZN6nUjQ8y05OA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2caa139-3ab8-4704-08a1-08d766891894
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2019 09:25:30.7050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xfa1wBNZ6YgZ7T4056DeBN75o0XQL4XjaYJBhBxCo4jTCsesQR+8OuQ42C4jOv4c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2928
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdSnJZqjGzAywNOXIbPZGi6Xipscgu+1TbTIbemyq9M=;
 b=qPVdzYrHEi1Grt8TiTDmKba+T1lfn9FSN5EDjipR1FbESIDn79PKWV03cx30UTdttilHq0kHS5p15DRjHT4qbCr2WdyuxYPZ/ApRsDO2xyF1OJ5gsK/TRK+CzzN9vT85Dh/tR9iO67Igdx0U2UnYWDeC44K3Wr9deW22wQvYIc8=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191111092506.fqUVhx_MRKUOntnuJ4FTBw8ZHMXW4Kh3RhivVA3Jzbw@z>

T3RoZXJ3aXNlLCB3aXRob3V0IFJMQyByZWluaXRpYWxpemF0aW9uLCB0aGUgRFBNIHJlZW5hYmxl
bWVudAp3aWxsIGZhaWwuIFRoYXQgYWZmZWN0cyB0aGUgY3VzdG9tIHBwdGFibGUgdXBsb2FkaW5n
LgoKQ2hhbmdlLUlkOiBJNmZlMmVkNWNlMjNmMmE1YjY2ZjM3MWMwYjZkMWY5MjQ4MzdlNWFmNgpT
aWduZWQtb2ZmLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgotLS0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYyAgICB8IDMyICsrKysrKysrKysrKysr
Ky0tLS0KIC4uLi9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL2FtZGdwdV9zbXUuaCAgICB8ICAx
ICsKIDIgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRncHVfc211LmMKaW5kZXggNzZhNDE1NGIz
YmUyLi5hNGQ2N2IzMGZkNzIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJw
bGF5L2FtZGdwdV9zbXUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hbWRn
cHVfc211LmMKQEAgLTEyOTMsMTAgKzEyOTMsMjUgQEAgc3RhdGljIGludCBzbXVfaHdfZmluaSh2
b2lkICpoYW5kbGUpCiAJCXJldHVybiByZXQ7CiAJfQogCi0JcmV0ID0gc211X3N0b3BfZHBtcyhz
bXUpOwotCWlmIChyZXQpIHsKLQkJcHJfd2FybigiRmFpbCB0byBzdG9wIERwbXMhXG4iKTsKLQkJ
cmV0dXJuIHJldDsKKwkvKgorCSAqIEZvciBjdXN0b20gcHB0YWJsZSB1cGxvYWRpbmcsIHNraXAg
dGhlIERQTSBmZWF0dXJlcworCSAqIGRpc2FibGUgcHJvY2VzcyBvbiBOYXZpMXggQVNJQ3MuCisJ
ICogICAtIEFzIHRoZSBnZnggcmVsYXRlZCBmZWF0dXJlcyBhcmUgdW5kZXIgY29udHJvbCBvZgor
CSAqICAgICBSTEMgb24gdGhvc2UgQVNJQ3MuIFJMQyByZWluaXRpYWxpemF0aW9uIHdpbGwgYmUK
KwkgKiAgICAgbmVlZGVkIHRvIHJlZW5hYmxlIHRoZW0uIFRoYXQgd2lsbCBjb3N0IG11Y2ggbW9y
ZQorCSAqICAgICBlZmZvcnRzLgorCSAqCisJICogICAtIFNNVSBmaXJtd2FyZSBjYW4gaGFuZGxl
IHRoZSBEUE0gcmVlbmFibGVtZW50CisJICogICAgIHByb3Blcmx5LgorCSAqLworCWlmICghc211
LT51cGxvYWRpbmdfY3VzdG9tX3BwX3RhYmxlIHx8CisJICAgICEoKGFkZXYtPmFzaWNfdHlwZSA+
PSBDSElQX05BVkkxMCkgJiYKKwkgICAgICAoYWRldi0+YXNpY190eXBlIDw9IENISVBfTkFWSTEy
KSkpIHsKKwkJcmV0ID0gc211X3N0b3BfZHBtcyhzbXUpOworCQlpZiAocmV0KSB7CisJCQlwcl93
YXJuKCJGYWlsIHRvIHN0b3AgRHBtcyFcbiIpOworCQkJcmV0dXJuIHJldDsKKwkJfQogCX0KIAog
CWtmcmVlKHRhYmxlX2NvbnRleHQtPmRyaXZlcl9wcHRhYmxlKTsKQEAgLTEzMjQsMTMgKzEzMzks
MTYgQEAgaW50IHNtdV9yZXNldChzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkKIAlzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiA9IHNtdS0+YWRldjsKIAlpbnQgcmV0ID0gMDsKIAorCXNtdS0+dXBs
b2FkaW5nX2N1c3RvbV9wcF90YWJsZSA9IHRydWU7CisKIAlyZXQgPSBzbXVfaHdfZmluaShhZGV2
KTsKIAlpZiAocmV0KQotCQlyZXR1cm4gcmV0OworCQlnb3RvIG91dDsKIAogCXJldCA9IHNtdV9o
d19pbml0KGFkZXYpOwotCWlmIChyZXQpCi0JCXJldHVybiByZXQ7CisKK291dDoKKwlzbXUtPnVw
bG9hZGluZ19jdXN0b21fcHBfdGFibGUgPSBmYWxzZTsKIAogCXJldHVybiByZXQ7CiB9CmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvYW1kZ3B1X3NtdS5oIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL2FtZGdwdV9zbXUuaAppbmRleCA4MTIw
ZTc1ODc1ODUuLjIxNTg0MWY1ZmI5MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvaW5jL2FtZGdwdV9zbXUuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS9pbmMvYW1kZ3B1X3NtdS5oCkBAIC0zOTEsNiArMzkxLDcgQEAgc3RydWN0IHNtdV9jb250
ZXh0CiAKIAl1aW50MzJfdCBzbWNfaWZfdmVyc2lvbjsKIAorCWJvb2wgdXBsb2FkaW5nX2N1c3Rv
bV9wcF90YWJsZTsKIH07CiAKIHN0cnVjdCBpMmNfYWRhcHRlcjsKLS0gCjIuMjQuMAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
