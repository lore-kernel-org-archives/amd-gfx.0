Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BFBC432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:34:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C74C720848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74C720848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 442E06E29A;
	Mon,  2 Dec 2019 17:34:59 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820081.outbound.protection.outlook.com [40.107.82.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C0976E29E
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:34:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IT81S87m9o4SZQJW6NjqUEpIvNHLoJaWxM52gljMngqEf2Yp7tom1tZnwxIyTKFrxf7bH/QbqTwP8vrGZJMOpxxa9CpQVYbHcKT/ZQsrc/FU7JrbuwDcVGzGdffTBgrZlrVRx/HtvKtV+Q5RngKXcGOcJjoQDDd8gDqaF+PT8FZti8Y3mUS6qb+E8TfAzPJsp8KsA914mkPl59uZeeYc1VtN/ygB+MEPgxvSOQkOkjIh5TEc79DyaoOQ3ZvEvj3EqfZAQkZ4b9eOviF+AIAiT7OK8oVIcpc7iph8qHXi5n/eM+NdbqC3U35KWEr0JDaUeVMOODBfAHeNH9crg5sg+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pWXqtDqUc/KBZo1OO7uxbjK861FNaD4flpSz2QuF5U=;
 b=Gdkh0khrGI7nb3LDgyoPN6ezs045TYhXx5gyF7LXTmZUNe21ZGSfo7NPNgzccXKCBcnyuaXf3NuITPNyU5TK1NTUQOLe+5hdO8ys5lghaJL5ykthni6PoPFL9Xc3dpR2Qp9q9u4KCDMdtKaYQcr43RZjHJiWq+u6To06IZNCvcGhRFg6uL8KMSspZZ3t0jwSeIAuwDHum8vKNIot3EdGUoBJ0l4gn98NegrbF3hgtN1BxczS1Pcd9YeG0QSgxX0T8IAhTcLiKuMUgijrYxt561tMV59FoTFsrEkIY/3aI0QYdt7Dks8RsD+ETnd/agth+rXLO9tFzIm0NHEMSOktjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2802.namprd12.prod.outlook.com (20.176.27.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:34:56 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:34:56 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/51] drm/amd/display: Wrong ifdef guards were used around
 DML validation
Date: Mon,  2 Dec 2019 12:33:21 -0500
Message-Id: <20191202173405.31582-8-sunpeng.li@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 51615ada-3969-4372-27a1-08d7774df0dc
X-MS-TrafficTypeDiagnostic: BN7PR12MB2802:|BN7PR12MB2802:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2802D1E22A275FC5DD884D5982430@BN7PR12MB2802.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:268;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(189003)(199004)(81166006)(81156014)(86362001)(6486002)(9686003)(6506007)(2870700001)(478600001)(386003)(76176011)(5660300002)(51416003)(186003)(1076003)(52116002)(3846002)(6116002)(47776003)(2616005)(26005)(66946007)(66066001)(25786009)(316002)(446003)(11346002)(14454004)(66476007)(66556008)(48376002)(8676002)(50226002)(305945005)(6512007)(36756003)(2906002)(14444005)(99286004)(6666004)(7736002)(2351001)(54906003)(4326008)(2361001)(6916009)(6436002)(50466002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2802;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QaGI2Iig9FaUL1D4zDWMcpQ20Ap/wNXeSUt20WUe8ASHmVWlNdOgVryUCPqQIKxxXupj9v8afRSvpAIzDuD/QIpY6TIU+Fji8pALHd+mLn1yUTAMDLZzXJRb7cN9mF6VQ2ZaF2xqsOBNktj+bZfGsvx6gQQSlc/61V7Mv1U13XDt5QLwwazzYEZCCpnOJqCDnLR4IvmQfkwU0W/tiXZzTcX1Z9SnzjWlbbHAKyq1HC4ew6zu6jmCI8ksLID8kfEVImXzCT/ebU+LFKDKUQwD9KqUrYdXMKMDdoPGRCL8WDeZbRRQxDBv7PhLxbK1baqf7H05/IDiUjAd96OtZcBNwl++p2I63Ut8MJo5/xznfLFKCI7It0m1js2WFTrdSm5m5J/gXsuVdqDHdAGk0ZQgZTJwtDP6bZ8NfEKydih1k2NwiRkKrY67ORuYHch5vwrP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51615ada-3969-4372-27a1-08d7774df0dc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:34:53.5820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /05gs6238NhX/HBlWGw2eGDxzHlArKWkCMewwIouVfX0Y7j0rDiEMP0lLyNiK366
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2802
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pWXqtDqUc/KBZo1OO7uxbjK861FNaD4flpSz2QuF5U=;
 b=meWyyKmMEtm8RhNaTuKPViMDOQveWvZKpem59M7JwUJ2gnGBAOs85tQqGECiqzXbJcvWqljHzVI6bMsY1yeFK1ZjyrP+S0+0odd+Qneig/B410Jg7kCsE4E9ispAILkMJTwZqHTMTAauhyCe2uyx+rg9sfu0lhJfD2LRApupY74=
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
Cc: Leo Li <sunpeng.li@amd.com>, harry.wentland@amd.com,
 rodrigo.siqueira@amd.com, Jaehyun Chung <jaehyun.chung@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, bhawanpreet.lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogSmFlaHl1biBDaHVuZyA8amFlaHl1bi5jaHVuZ0BhbWQuY29tPgoKW1doeV0KV3Jvbmcg
Z3VhcmRzIHdlcmUgY2F1c2luZyB0aGUgZGVidWcgb3B0aW9uIG5vdCB0byBydW4uCgpbSG93XQpD
aGFuZ2VkIHRoZSBndWFyZCB0byB0aGUgY29ycmVjdCBvbmUsIG1hdGNoaW5nIHRoZSBycSwgdHR1
LCBkbGcgcmVncyBzdHJ1Y3QKbWVtYmVycyB0aGF0IG5lZWQgdG8gYmUgZ3VhcmRlZC4gQWxzbyBs
b2cgYSBtZXNzYWdlIHdoZW4gdmFsaWRhdGlvbiBzdGFydHMuCgpTaWduZWQtb2ZmLWJ5OiBKYWVo
eXVuIENodW5nIDxqYWVoeXVuLmNodW5nQGFtZC5jb20+ClJldmlld2VkLWJ5OiBBbHZpbiBMZWUg
PEFsdmluLkxlZTJAYW1kLmNvbT4KQWNrZWQtYnk6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29t
PgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMgICAgICAgICAg
fCAyICstCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfaHVicC5j
IHwgMSArCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfaHVicC5j
IHwgMSArCiAzIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jCmluZGV4IGUzODRjMTQzYmI1
OC4uMDYxZThhZGY3NDc2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvY29yZS9kYy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2Rj
LmMKQEAgLTIxODcsNyArMjE4Nyw3IEBAIHN0YXRpYyB2b2lkIGNvbW1pdF9wbGFuZXNfZm9yX3N0
cmVhbShzdHJ1Y3QgZGMgKmRjLAogCX0KIAlpZiAoZGMtPmh3c3MucHJvZ3JhbV9mcm9udF9lbmRf
Zm9yX2N0eCAmJiB1cGRhdGVfdHlwZSAhPSBVUERBVEVfVFlQRV9GQVNUKSB7CiAJCWRjLT5od3Nz
LnByb2dyYW1fZnJvbnRfZW5kX2Zvcl9jdHgoZGMsIGNvbnRleHQpOwotI2lmZGVmIENPTkZJR19E
Uk1fQU1EX0RDX0RDTjFfMAorI2lmZGVmIENPTkZJR19EUk1fQU1EX0RDX0RDTgogCQlpZiAoZGMt
PmRlYnVnLnZhbGlkYXRlX2RtbF9vdXRwdXQpIHsKIAkJCWZvciAoaSA9IDA7IGkgPCBkYy0+cmVz
X3Bvb2wtPnBpcGVfY291bnQ7IGkrKykgewogCQkJCXN0cnVjdCBwaXBlX2N0eCBjdXJfcGlwZSA9
IGNvbnRleHQtPnJlc19jdHgucGlwZV9jdHhbaV07CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfaHVicC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX2h1YnAuYwppbmRleCAyODIzYmU3NWIwNzEuLjg0ZDdh
YzVkZDIwNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIw
L2RjbjIwX2h1YnAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAv
ZGNuMjBfaHVicC5jCkBAIC0xMjU3LDYgKzEyNTcsNyBAQCB2b2lkIGh1YnAyX3ZhbGlkYXRlX2Rt
bF9vdXRwdXQoc3RydWN0IGh1YnAgKmh1YnAsCiAJc3RydWN0IF92Y3NfZHBpX2Rpc3BsYXlfZGxn
X3JlZ3Nfc3QgZGxnX2F0dHIgPSB7MH07CiAJc3RydWN0IF92Y3NfZHBpX2Rpc3BsYXlfdHR1X3Jl
Z3Nfc3QgdHR1X2F0dHIgPSB7MH07CiAJRENfTE9HR0VSX0lOSVQoY3R4LT5sb2dnZXIpOworCURD
X0xPR19ERUJVRygiRE1MIFZhbGlkYXRpb24gfCBSdW5uaW5nIFZhbGlkYXRpb24iKTsKIAogCS8q
IFJlcXVlc3RvciBSZWdzICovCiAJUkVHX0dFVChIVUJQUkVUX0NPTlRST0wsCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfaHVicC5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX2h1YnAuYwppbmRleCAwYmUx
YzkxN2IyNDIuLjQ0MDhhZWQ1MDg3YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2RjbjIxL2RjbjIxX2h1YnAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvZGNuMjEvZGNuMjFfaHVicC5jCkBAIC0yNjcsNiArMjY3LDcgQEAgdm9pZCBodWJw
MjFfdmFsaWRhdGVfZG1sX291dHB1dChzdHJ1Y3QgaHVicCAqaHVicCwKIAlzdHJ1Y3QgX3Zjc19k
cGlfZGlzcGxheV9kbGdfcmVnc19zdCBkbGdfYXR0ciA9IHswfTsKIAlzdHJ1Y3QgX3Zjc19kcGlf
ZGlzcGxheV90dHVfcmVnc19zdCB0dHVfYXR0ciA9IHswfTsKIAlEQ19MT0dHRVJfSU5JVChjdHgt
PmxvZ2dlcik7CisJRENfTE9HX0RFQlVHKCJETUwgVmFsaWRhdGlvbiB8IFJ1bm5pbmcgVmFsaWRh
dGlvbiIpOwogCiAJLyogUmVxdWVzdGVyIC0gUGVyIGh1YnAgKi8KIAlSRUdfR0VUKEhVQlBSRVRf
Q09OVFJPTCwKLS0gCjIuMjQuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4
