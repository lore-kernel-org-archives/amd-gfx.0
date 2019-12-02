Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAEDC432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:36:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD13520848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD13520848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9024D6E2E5;
	Mon,  2 Dec 2019 17:36:00 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800050.outbound.protection.outlook.com [40.107.80.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4632F6E2DA
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3JVRhgbywqgCsLgVoFxE5SiziAbGtkdkYmkweft9j52vZ4rfbg5YLRsQ8MAcaHJIG7sl8OdMPIBFO8ixlPKRQ+5ALS8Zl+fTVrB6GkI6/m+lZKQ5VNJ7NfNs+VJy/F9IlnXwRJY237Y40LjaDTGlVGL8rjoBMxSlikV3+iMEgz7idJrz5m8ZaulS9MZtj8u1yHkvLGQGoWAtHlZkeRv4gWIGvRS8RCZUTM9/ay9XElu7LtzW3oPkBcno/Z+Fck3xHk8eA2JrIv/Dt827BUYFklfCneC2e6otyzy36SVKepLDZP6Wnp4Syty0i9kN+rheJD2vx3pNmaI5qBAnP4ZyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hp7G4cuwYSffgvK+ylIDoXWiITD+SOcR4TSg4dASBKo=;
 b=ZjoOQX1O6jmqWVxN0JqorpheePsIy7tCLYDBEH1sbJKMJvLysyNPi7I1XbXhjIQv+lOx23lyOhPsdjuXfzrnze150VWtRt1AXc/HWjaAEuRAGRbcHqpVzw6zXRFEsHEs7hxlsByIS44mJ9vZy3/TcjUyV7mZ1hFfBD/+XuiX1SOfO7jVBBgcZvrxqHebEw/2/IWj0UWkBkguUpQ8544ThjmVLrWGGGcwF9EXJRl+r6E5rdxadEYXStT/pAxPeXHVGcSNQP58NwuHiGBgmvu8bInek40qenbOp99XUaPHEbMn/wX7ZUSlbTQzMXYXVOW6AdzXIE+ga/zK4BZIdb6p6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2610.namprd12.prod.outlook.com (20.176.26.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:35:56 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:35:56 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 47/51] drm/amd/display: Increase the number of retries after
 AUX DEFER
Date: Mon,  2 Dec 2019 12:34:01 -0500
Message-Id: <20191202173405.31582-48-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191202173405.31582-1-sunpeng.li@amd.com>
References: <20191202173405.31582-1-sunpeng.li@amd.com>
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To BN7PR12MB2593.namprd12.prod.outlook.com
 (2603:10b6:408:25::23)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bf1acd57-f18f-472a-3ad2-08d7774e0680
X-MS-TrafficTypeDiagnostic: BN7PR12MB2610:|BN7PR12MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB26102CFE3754CF56282CCCAB82430@BN7PR12MB2610.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(189003)(199004)(76176011)(6666004)(51416003)(52116002)(6512007)(66476007)(66556008)(316002)(50226002)(5660300002)(6916009)(81166006)(26005)(2616005)(99286004)(386003)(6506007)(1076003)(8936002)(11346002)(305945005)(446003)(81156014)(186003)(9686003)(6436002)(4326008)(8676002)(6486002)(7736002)(66946007)(54906003)(48376002)(50466002)(86362001)(6116002)(2351001)(3846002)(2906002)(25786009)(36756003)(66066001)(2870700001)(2361001)(14454004)(478600001)(47776003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2610;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oYzIOG3k7k3lVJJtXvuVRjhlsNtbVIvU4En0oZ0vfWyjjB+CgaICmIseYeafz5OUJp8ot352pFHNL1WJZdzHF6aWedD4RdjZREQrkIfGMMTdSKyi814Au/dgxa1VkM1hu4nI/B/Z39x+UHcQQNRpc9WPEtmzhqH2X7ZgCIan/+KVWtPoPiO4VnxZYlXtNnFOBNveWarm9rA7RnXDcpz8a6y1k8GNaaufFhDKHxI5yoXgG/mP06Q0e1jnKXiGnaC6ypWNKM8Yo7bp7dnFnTfIuAWfdan9KhuKva/gPOoBJ3IWFED9hTrgw8kdETQMrOYm8cS/V7uKXS4PDNV4W4lI3hmMFhrBXVcm9kkhOJJoS5IJTQdBeaTMmR+NPQaK5BRJZb2FLpzMaQ32D8HWzTzWR9ihgL57pjT+bxjttMc4RowKDvZLfyk0rWdWVxxTgoAz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1acd57-f18f-472a-3ad2-08d7774e0680
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:35:29.8814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rOs/QHaEcBzuHbWQpfNtkxBOn3d8OdQuY2WIMoQPxvcN3y0C85CNg/dOaCg+fJ2S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2610
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hp7G4cuwYSffgvK+ylIDoXWiITD+SOcR4TSg4dASBKo=;
 b=sUgX7l6cmWtuyHjl/8JSlpRmHXtjC5dQ5zZBIlcWcBrpHk05Z3znJvXYF8UxzDNAuurMtLMwhMpN8JkNzE3YxOiFod6PPF0lzghAwQfO52JmTO7uj6Oiy3KW3+BTeT1HX+tWtDJUH72pkg4onM6uT85CwrZPgvWhG5NPX0STDF4=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sunpeng.Li@amd.com; 
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
Cc: Leo Li <sunpeng.li@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 George Shen <george.shen@amd.com>, rodrigo.siqueira@amd.com,
 Abdoulaye Berthe <Abdoulaye.Berthe@amd.com>, harry.wentland@amd.com,
 bhawanpreet.lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogR2VvcmdlIFNoZW4gPGdlb3JnZS5zaGVuQGFtZC5jb20+CgpbV2h5XQpXaGVuIGEgdGlt
ZW91dCBvY2N1cnMgYWZ0ZXIgYSBERUZFUiwgc29tZSBkZXZpY2VzIHJlcXVpcmUgbW9yZSByZXRy
aWVzCnRoYW4gaW4gdGhlIGNhc2Ugb2YgYSByZWd1bGFyIHRpbWVvdXQuCgpbSG93XQpJbiBhIHRp
bWVvdXQgb2NjdXJyZW5jZSwgY2hlY2sgd2hldGhlciBhIERFRkVSIGhhcyBvY2N1cnJlZCBiZWZv
cmUgdGhlCnRpbWVvdXQgYW5kIHJldHJ5IE1BWF9ERUZFUl9SRVRSSUVTIHJldHJpZXMgdGltZXMg
aW5zdGVhZCBvZgpNQVhfVElNRU9VVF9SRVRSSUVTLgoKU2lnbmVkLW9mZi1ieTogR2VvcmdlIFNo
ZW4gPGdlb3JnZS5zaGVuQGFtZC5jb20+ClJldmlld2VkLWJ5OiBUb255IENoZW5nIDxUb255LkNo
ZW5nQGFtZC5jb20+CkFja2VkLWJ5OiBBYmRvdWxheWUgQmVydGhlIDxBYmRvdWxheWUuQmVydGhl
QGFtZC5jb20+CkFja2VkLWJ5OiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9hdXguYyB8IDMyICsrKysrKysrKysr
KysrLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2Vf
YXV4LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9hdXguYwppbmRl
eCBmNzYyNmNkNzBlYzguLjE5MWI2OGI4MTYzYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfYXV4LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2RjZS9kY2VfYXV4LmMKQEAgLTYxMSw2ICs2MTEsOCBAQCBib29sIGRjZV9hdXhf
dHJhbnNmZXJfd2l0aF9yZXRyaWVzKHN0cnVjdCBkZGNfc2VydmljZSAqZGRjLAogCXVpbnQ4X3Qg
cmVwbHk7CiAJYm9vbCBwYXlsb2FkX3JlcGx5ID0gdHJ1ZTsKIAllbnVtIGF1eF9jaGFubmVsX29w
ZXJhdGlvbl9yZXN1bHQgb3BlcmF0aW9uX3Jlc3VsdDsKKwlib29sIHJldHJ5X29uX2RlZmVyID0g
ZmFsc2U7CisKIAlpbnQgYXV4X2Fja19yZXRyaWVzID0gMCwKIAkJYXV4X2RlZmVyX3JldHJpZXMg
PSAwLAogCQlhdXhfaTJjX2RlZmVyX3JldHJpZXMgPSAwLApAQCAtNjQxLDggKzY0Myw5IEBAIGJv
b2wgZGNlX2F1eF90cmFuc2Zlcl93aXRoX3JldHJpZXMoc3RydWN0IGRkY19zZXJ2aWNlICpkZGMs
CiAJCQlicmVhazsKIAogCQkJY2FzZSBBVVhfVFJBTlNBQ1RJT05fUkVQTFlfQVVYX0RFRkVSOgot
CQkJY2FzZSBBVVhfVFJBTlNBQ1RJT05fUkVQTFlfSTJDX09WRVJfQVVYX05BQ0s6CiAJCQljYXNl
IEFVWF9UUkFOU0FDVElPTl9SRVBMWV9JMkNfT1ZFUl9BVVhfREVGRVI6CisJCQkJcmV0cnlfb25f
ZGVmZXIgPSB0cnVlOworCQkJY2FzZSBBVVhfVFJBTlNBQ1RJT05fUkVQTFlfSTJDX09WRVJfQVVY
X05BQ0s6CiAJCQkJaWYgKCsrYXV4X2RlZmVyX3JldHJpZXMgPj0gQVVYX01BWF9ERUZFUl9SRVRS
SUVTKSB7CiAJCQkJCWdvdG8gZmFpbDsKIAkJCQl9IGVsc2UgewpAQCAtNjc1LDE1ICs2NzgsMjQg
QEAgYm9vbCBkY2VfYXV4X3RyYW5zZmVyX3dpdGhfcmV0cmllcyhzdHJ1Y3QgZGRjX3NlcnZpY2Ug
KmRkYywKIAkJCWJyZWFrOwogCiAJCWNhc2UgQVVYX0NIQU5ORUxfT1BFUkFUSU9OX0ZBSUxFRF9U
SU1FT1VUOgotCQkJaWYgKCsrYXV4X3RpbWVvdXRfcmV0cmllcyA+PSBBVVhfTUFYX1RJTUVPVVRf
UkVUUklFUykKLQkJCQlnb3RvIGZhaWw7Ci0JCQllbHNlIHsKLQkJCQkvKgotCQkJCSAqIERQIDEu
NCwgMi44LjI6ICBBVVggVHJhbnNhY3Rpb24gUmVzcG9uc2UvUmVwbHkgVGltZW91dHMKLQkJCQkg
KiBBY2NvcmRpbmcgdG8gdGhlIERQIHNwZWMgdGhlcmUgc2hvdWxkIGJlIDMgcmV0cmllcyB0b3Rh
bAotCQkJCSAqIHdpdGggYSA0MDB1cyB3YWl0IGluYmV0d2VlbiBlYWNoLiBIYXJkd2FyZSBhbHJl
YWR5IHdhaXRzCi0JCQkJICogZm9yIDU1MHVzIHRoZXJlZm9yZSBubyB3YWl0IGlzIHJlcXVpcmVk
IGhlcmUuCi0JCQkJICovCisJCQkvLyBDaGVjayB3aGV0aGVyIGEgREVGRVIgaGFkIG9jY3VycmVk
IGJlZm9yZSB0aGUgdGltZW91dC4KKwkJCS8vIElmIHNvLCB0cmVhdCB0aW1lb3V0IGFzIGEgREVG
RVIuCisJCQlpZiAocmV0cnlfb25fZGVmZXIpIHsKKwkJCQlpZiAoKythdXhfZGVmZXJfcmV0cmll
cyA+PSBBVVhfTUFYX0RFRkVSX1JFVFJJRVMpCisJCQkJCWdvdG8gZmFpbDsKKwkJCQllbHNlIGlm
IChwYXlsb2FkLT5kZWZlcl9kZWxheSA+IDApCisJCQkJCW1zbGVlcChwYXlsb2FkLT5kZWZlcl9k
ZWxheSk7CisJCQl9IGVsc2UgeworCQkJCWlmICgrK2F1eF90aW1lb3V0X3JldHJpZXMgPj0gQVVY
X01BWF9USU1FT1VUX1JFVFJJRVMpCisJCQkJCWdvdG8gZmFpbDsKKwkJCQllbHNlIHsKKwkJCQkJ
LyoKKwkJCQkJICogRFAgMS40LCAyLjguMjogIEFVWCBUcmFuc2FjdGlvbiBSZXNwb25zZS9SZXBs
eSBUaW1lb3V0cworCQkJCQkgKiBBY2NvcmRpbmcgdG8gdGhlIERQIHNwZWMgdGhlcmUgc2hvdWxk
IGJlIDMgcmV0cmllcyB0b3RhbAorCQkJCQkgKiB3aXRoIGEgNDAwdXMgd2FpdCBpbmJldHdlZW4g
ZWFjaC4gSGFyZHdhcmUgYWxyZWFkeSB3YWl0cworCQkJCQkgKiBmb3IgNTUwdXMgdGhlcmVmb3Jl
IG5vIHdhaXQgaXMgcmVxdWlyZWQgaGVyZS4KKwkJCQkJICovCisJCQkJfQogCQkJfQogCQkJYnJl
YWs7CiAKLS0gCjIuMjQuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
