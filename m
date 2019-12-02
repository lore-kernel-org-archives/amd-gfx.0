Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D565C432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4956820848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4956820848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06ADB6E2A9;
	Mon,  2 Dec 2019 17:35:01 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800040.outbound.protection.outlook.com [40.107.80.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF42E6E2A0
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:34:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9dJKgkFmDPtrJYTAejl30fgu+7smMJej2qHEIZPJlumWLUd2peiugq1bLzJ0kmw3aqT4luf4urwNnx21wX//AqoxZnDj8jlFiaqbXjjX3PWfQCvMCeFQExdUAnXxubvlCSeqjTunmYGcXt+f/sfFquO/2WXE7nuf7/2CsksZxgZGkRY0WRajpwajVerfeV8xqnSa1T3mqeqMaBD0WSz5zIXukwvQs5UVS4BTQ0OoK98G7U03WFGaD4MoJv55AXWbydKdAz54ies1qFuA06PcyKwXuuskLNlOC7YOQ9Cjn72CHeWcnvqFqrq4HBB+IVMXa5/F7meOYwxkKbqcfcCyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDY5NKgKKFS3sxL+kY628qiuKxdqdNI+dND1+9sAziY=;
 b=i3oowSV4ncSc/lOleoD5t2g+0UkZMMwNJ56bdG61AUnNG4MWBJLt1/v39+hjW6kTzm9R26uaKWBSSeul+5BUNkiy68v5WgU604CxRR+oT3psBkUOODvmVKffzQq+batgQxA705vo2FhzYVZLASIhSbQAUtrLq/mHcwMHNd4ulr+NIAMGzNDnOmv2J4OTgYDH55YlIOPBZ4HIs1cHbX0HKGo95jF3zerH4MvtlB8rAvZnN7QQQt5QnjDAzVCfvv7JCA1I+/fbFVHov6mJSGsonT8Ow1WsUEpYv6yku/OKCikg2yI1K+Vrtpj6JQFSqLVvHUhWLEaYcb4FHkuG4+gwsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2610.namprd12.prod.outlook.com (20.176.26.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:34:57 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:34:57 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/51] drm/amd/display: Disable link before reenable
Date: Mon,  2 Dec 2019 12:33:23 -0500
Message-Id: <20191202173405.31582-10-sunpeng.li@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 55178b1c-8f3e-4160-b668-08d7774df1df
X-MS-TrafficTypeDiagnostic: BN7PR12MB2610:|BN7PR12MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB26103C09DF55CDB79164572082430@BN7PR12MB2610.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(189003)(199004)(76176011)(6666004)(51416003)(52116002)(6512007)(66476007)(66556008)(316002)(50226002)(5660300002)(6916009)(81166006)(26005)(2616005)(99286004)(386003)(6506007)(1076003)(8936002)(11346002)(305945005)(446003)(81156014)(186003)(9686003)(6436002)(4326008)(8676002)(6486002)(7736002)(66946007)(54906003)(14444005)(48376002)(50466002)(86362001)(6116002)(2351001)(3846002)(2906002)(25786009)(36756003)(66066001)(2870700001)(2361001)(14454004)(478600001)(47776003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2610;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IRIX+ohldoxUXzVKaank5uOOZLcCpoI/+L2cesVawzSIKvdVtV97UFfTI+bGRKflmMv7B/jj1+tyauCuRcTB2kgcmT5jLIpet2F+dGrfwMOSqzy6cKV+tfp+8xTieBtF6lryhb8XGq/Jg5YZLHPiHEBGCO5D5jCSiEFGp004KjTLtpmY515zJOiruHlIpYE4vj8TRA5OfkbgtdH+m7aXDpiKXzV42NCLEPEawCHnhYcZVbHrJOBV07dUmF2y9JFpphpieQjCswRHHVTlG+OoZCZTI87t502lrk7LI0DGdhaENzpWtSPYjjDQnqy25GqAeu/YH9qJldJbGHxtuB9j35Pp4u77UqD8DrH3u7DZOi7KyIjvbcKimzjMBtWjVfashUiFo78hH69Skrucu32rgsZuyPDBunjgRZzJ4CBbhL8stOrU66zizvqAzydo8JNQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55178b1c-8f3e-4160-b668-08d7774df1df
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:34:55.4359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +NkDFdMIk0D0FS3Ma77mtpc/EWHmDyIb8bdXoTJwSKuhL9Jh7aKu+Zq/Ox2U14Rl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2610
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDY5NKgKKFS3sxL+kY628qiuKxdqdNI+dND1+9sAziY=;
 b=KzeOFvFTj+3evxu1ZVrTY+bekgwqdY6tYZDsz/FYhQlJ0ibGK73bmaBYJR1s2rctC8LRg4peZD3gzLAmRuy1dTnO7/ljvdtzgVuzfiJo5akPUOsIp8TkBolesD/2WEryFTWh2cZKg2NnEKngPs3MtSjbZvbv6mnx9AEfrzqbLHY=
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
 rodrigo.siqueira@amd.com, Lucy Li <lucy.li@amd.com>, bhawanpreet.lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogTHVjeSBMaSA8bHVjeS5saUBhbWQuY29tPgoKW1doeV0KQmxhY2sgc2NyZWVuIHNlZW4g
YWZ0ZXIgZGlzcGxheSBpcyBkaXNhYmxlZCB0aGVuIHJlLWVuYWJsZWQuCkNhdXNlZCBieSBkaWZm
ZXJlbmNlIGluIGxpbmsgc2V0dGluZ3Mgd2hlbgpzd2l0Y2hpbmcgYmV0d2VlbiBkaWZmZXJlbnQg
cmVzb2x1dGlvbnMuCgpbSG93XQpJbiBQblAgY2FzZSwgb3Igd2hlbmV2ZXIgdGhlIGRpc3BsYXkg
aXMKc3RpbGwgZW5hYmxlZCBidXQgdGhlIGRyaXZlciBpcyB1bmxvYWRlZCwKZGlzYWJsZSBsaW5r
IGJlZm9yZSByZS1lbmFibGluZyB3aXRoIG5ldyBsaW5rIHNldHRpbmdzLgoKU2lnbmVkLW9mZi1i
eTogTHVjeSBMaSA8bHVjeS5saUBhbWQuY29tPgpSZXZpZXdlZC1ieTogQW50aG9ueSBLb28gPEFu
dGhvbnkuS29vQGFtZC5jb20+CkFja2VkLWJ5OiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMgfCA5OSAr
KysrKysrKysrLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKSwgNDcg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2NvcmUvZGNfbGluay5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNf
bGluay5jCmluZGV4IDVhMzUzOTVlNjA2MC4uNDY4MWNhMjBmNjgzIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGluay5jCkBAIC0xNTExLDE1ICsxNTExLDYg
QEAgc3RhdGljIGVudW0gZGNfc3RhdHVzIGVuYWJsZV9saW5rX2RwKAogCWRlY2lkZV9saW5rX3Nl
dHRpbmdzKHN0cmVhbSwgJmxpbmtfc2V0dGluZ3MpOwogCiAJaWYgKHBpcGVfY3R4LT5zdHJlYW0t
PnNpZ25hbCA9PSBTSUdOQUxfVFlQRV9FRFApIHsKLQkJLyogSWYgbGluayBzZXR0aW5ncyBhcmUg
ZGlmZmVyZW50IHRoYW4gY3VycmVudCBhbmQgbGluayBhbHJlYWR5IGVuYWJsZWQKLQkJICogdGhl
biBuZWVkIHRvIGRpc2FibGUgYmVmb3JlIHByb2dyYW1taW5nIHRvIG5ldyByYXRlLgotCQkgKi8K
LQkJaWYgKGxpbmstPmxpbmtfc3RhdHVzLmxpbmtfYWN0aXZlICYmCi0JCQkobGluay0+Y3VyX2xp
bmtfc2V0dGluZ3MubGFuZV9jb3VudCAhPSBsaW5rX3NldHRpbmdzLmxhbmVfY291bnQgfHwKLQkJ
CSBsaW5rLT5jdXJfbGlua19zZXR0aW5ncy5saW5rX3JhdGUgIT0gbGlua19zZXR0aW5ncy5saW5r
X3JhdGUpKSB7Ci0JCQlkcF9kaXNhYmxlX2xpbmtfcGh5KGxpbmssIHBpcGVfY3R4LT5zdHJlYW0t
PnNpZ25hbCk7Ci0JCX0KLQogCQkvKmluIGNhc2UgaXQgaXMgbm90IG9uKi8KIAkJbGluay0+ZGMt
Pmh3c3MuZWRwX3Bvd2VyX2NvbnRyb2wobGluaywgdHJ1ZSk7CiAJCWxpbmstPmRjLT5od3NzLmVk
cF93YWl0X2Zvcl9ocGRfcmVhZHkobGluaywgdHJ1ZSk7CkBAIC0yMDM5LDYgKzIwMzAsNDUgQEAg
c3RhdGljIHZvaWQgd3JpdGVfaTJjX3JlZHJpdmVyX3NldHRpbmcoCiAJCUFTU0VSVChpMmNfc3Vj
Y2Vzcyk7CiB9CiAKK3N0YXRpYyB2b2lkIGRpc2FibGVfbGluayhzdHJ1Y3QgZGNfbGluayAqbGlu
aywgZW51bSBzaWduYWxfdHlwZSBzaWduYWwpCit7CisJLyoKKwkgKiBUT0RPOiBpbXBsZW1lbnQg
Y2FsbCBmb3IgZHBfc2V0X2h3X3Rlc3RfcGF0dGVybgorCSAqIGl0IGlzIG5lZWRlZCBmb3IgY29t
cGxpYW5jZSB0ZXN0aW5nCisJICovCisKKwkvKiBIZXJlIHdlIG5lZWQgdG8gc3BlY2lmeSB0aGF0
IGVuY29kZXIgb3V0cHV0IHNldHRpbmdzCisJICogbmVlZCB0byBiZSBjYWxjdWxhdGVkIGFzIGZv
ciB0aGUgc2V0IG1vZGUsCisJICogaXQgd2lsbCBsZWFkIHRvIHF1ZXJ5aW5nIGR5bmFtaWMgbGlu
ayBjYXBhYmlsaXRpZXMKKwkgKiB3aGljaCBzaG91bGQgYmUgZG9uZSBiZWZvcmUgZW5hYmxlIG91
dHB1dAorCSAqLworCisJaWYgKGRjX2lzX2RwX3NpZ25hbChzaWduYWwpKSB7CisJCS8qIFNTVCBE
UCwgZURQICovCisJCWlmIChkY19pc19kcF9zc3Rfc2lnbmFsKHNpZ25hbCkpCisJCQlkcF9kaXNh
YmxlX2xpbmtfcGh5KGxpbmssIHNpZ25hbCk7CisJCWVsc2UKKwkJCWRwX2Rpc2FibGVfbGlua19w
aHlfbXN0KGxpbmssIHNpZ25hbCk7CisKKwkJaWYgKGRjX2lzX2RwX3NzdF9zaWduYWwoc2lnbmFs
KSB8fAorCQkJCWxpbmstPm1zdF9zdHJlYW1fYWxsb2NfdGFibGUuc3RyZWFtX2NvdW50ID09IDAp
IHsKKwkJCWRwX3NldF9mZWNfZW5hYmxlKGxpbmssIGZhbHNlKTsKKwkJCWRwX3NldF9mZWNfcmVh
ZHkobGluaywgZmFsc2UpOworCQl9CisJfSBlbHNlIHsKKwkJaWYgKHNpZ25hbCAhPSBTSUdOQUxf
VFlQRV9WSVJUVUFMKQorCQkJbGluay0+bGlua19lbmMtPmZ1bmNzLT5kaXNhYmxlX291dHB1dChs
aW5rLT5saW5rX2VuYywgc2lnbmFsKTsKKwl9CisKKwlpZiAoc2lnbmFsID09IFNJR05BTF9UWVBF
X0RJU1BMQVlfUE9SVF9NU1QpIHsKKwkJLyogTVNUIGRpc2FibGUgbGluayBvbmx5IHdoZW4gbm8g
c3RyZWFtIHVzZSB0aGUgbGluayAqLworCQlpZiAobGluay0+bXN0X3N0cmVhbV9hbGxvY190YWJs
ZS5zdHJlYW1fY291bnQgPD0gMCkKKwkJCWxpbmstPmxpbmtfc3RhdHVzLmxpbmtfYWN0aXZlID0g
ZmFsc2U7CisJfSBlbHNlIHsKKwkJbGluay0+bGlua19zdGF0dXMubGlua19hY3RpdmUgPSBmYWxz
ZTsKKwl9Cit9CisKIHN0YXRpYyB2b2lkIGVuYWJsZV9saW5rX2hkbWkoc3RydWN0IHBpcGVfY3R4
ICpwaXBlX2N0eCkKIHsKIAlzdHJ1Y3QgZGNfc3RyZWFtX3N0YXRlICpzdHJlYW0gPSBwaXBlX2N0
eC0+c3RyZWFtOwpAQCAtMjEyMyw2ICsyMTUzLDE5IEBAIHN0YXRpYyBlbnVtIGRjX3N0YXR1cyBl
bmFibGVfbGluaygKIAkJc3RydWN0IHBpcGVfY3R4ICpwaXBlX2N0eCkKIHsKIAllbnVtIGRjX3N0
YXR1cyBzdGF0dXMgPSBEQ19FUlJPUl9VTkVYUEVDVEVEOworCXN0cnVjdCBkY19zdHJlYW1fc3Rh
dGUgKnN0cmVhbSA9IHBpcGVfY3R4LT5zdHJlYW07CisJc3RydWN0IGRjX2xpbmsgKmxpbmsgPSBz
dHJlYW0tPmxpbms7CisKKwkvKiBUaGVyZSdzIHNvbWUgc2NlbmFyaW9zIHdoZXJlIGRyaXZlciBp
cyB1bmxvYWRlZCB3aXRoIGRpc3BsYXkKKwkgKiBzdGlsbCBlbmFibGVkLiBXaGVuIGRyaXZlciBp
cyByZWxvYWRlZCwgaXQgbWF5IGNhdXNlIGEgZGlzcGxheQorCSAqIHRvIG5vdCBsaWdodCB1cCBp
ZiB0aGVyZSBpcyBhIG1pc21hdGNoIGJldHdlZW4gb2xkIGFuZCBuZXcKKwkgKiBsaW5rIHNldHRp
bmdzLiBOZWVkIHRvIGNhbGwgZGlzYWJsZSBmaXJzdCBiZWZvcmUgZW5hYmxpbmcgYXQKKwkgKiBu
ZXcgbGluayBzZXR0aW5ncy4KKwkgKi8KKwlpZiAobGluay0+bGlua19zdGF0dXMubGlua19hY3Rp
dmUpIHsKKwkJZGlzYWJsZV9saW5rKGxpbmssIHBpcGVfY3R4LT5zdHJlYW0tPnNpZ25hbCk7CisJ
fQorCiAJc3dpdGNoIChwaXBlX2N0eC0+c3RyZWFtLT5zaWduYWwpIHsKIAljYXNlIFNJR05BTF9U
WVBFX0RJU1BMQVlfUE9SVDoKIAkJc3RhdHVzID0gZW5hYmxlX2xpbmtfZHAoc3RhdGUsIHBpcGVf
Y3R4KTsKQEAgLTIxNTcsNDQgKzIyMDAsNiBAQCBzdGF0aWMgZW51bSBkY19zdGF0dXMgZW5hYmxl
X2xpbmsoCiAJcmV0dXJuIHN0YXR1czsKIH0KIAotc3RhdGljIHZvaWQgZGlzYWJsZV9saW5rKHN0
cnVjdCBkY19saW5rICpsaW5rLCBlbnVtIHNpZ25hbF90eXBlIHNpZ25hbCkKLXsKLQkvKgotCSAq
IFRPRE86IGltcGxlbWVudCBjYWxsIGZvciBkcF9zZXRfaHdfdGVzdF9wYXR0ZXJuCi0JICogaXQg
aXMgbmVlZGVkIGZvciBjb21wbGlhbmNlIHRlc3RpbmcKLQkgKi8KLQotCS8qIGhlcmUgd2UgbmVl
ZCB0byBzcGVjaWZ5IHRoYXQgZW5jb2RlciBvdXRwdXQgc2V0dGluZ3MKLQkgKiBuZWVkIHRvIGJl
IGNhbGN1bGF0ZWQgYXMgZm9yIHRoZSBzZXQgbW9kZSwKLQkgKiBpdCB3aWxsIGxlYWQgdG8gcXVl
cnlpbmcgZHluYW1pYyBsaW5rIGNhcGFiaWxpdGllcwotCSAqIHdoaWNoIHNob3VsZCBiZSBkb25l
IGJlZm9yZSBlbmFibGUgb3V0cHV0ICovCi0KLQlpZiAoZGNfaXNfZHBfc2lnbmFsKHNpZ25hbCkp
IHsKLQkJLyogU1NUIERQLCBlRFAgKi8KLQkJaWYgKGRjX2lzX2RwX3NzdF9zaWduYWwoc2lnbmFs
KSkKLQkJCWRwX2Rpc2FibGVfbGlua19waHkobGluaywgc2lnbmFsKTsKLQkJZWxzZQotCQkJZHBf
ZGlzYWJsZV9saW5rX3BoeV9tc3QobGluaywgc2lnbmFsKTsKLQotCQlpZiAoZGNfaXNfZHBfc3N0
X3NpZ25hbChzaWduYWwpIHx8Ci0JCQkJbGluay0+bXN0X3N0cmVhbV9hbGxvY190YWJsZS5zdHJl
YW1fY291bnQgPT0gMCkgewotCQkJZHBfc2V0X2ZlY19lbmFibGUobGluaywgZmFsc2UpOwotCQkJ
ZHBfc2V0X2ZlY19yZWFkeShsaW5rLCBmYWxzZSk7Ci0JCX0KLQl9IGVsc2UgewotCQlpZiAoc2ln
bmFsICE9IFNJR05BTF9UWVBFX1ZJUlRVQUwpCi0JCQlsaW5rLT5saW5rX2VuYy0+ZnVuY3MtPmRp
c2FibGVfb3V0cHV0KGxpbmstPmxpbmtfZW5jLCBzaWduYWwpOwotCX0KLQotCWlmIChzaWduYWwg
PT0gU0lHTkFMX1RZUEVfRElTUExBWV9QT1JUX01TVCkgewotCQkvKiBNU1QgZGlzYWJsZSBsaW5r
IG9ubHkgd2hlbiBubyBzdHJlYW0gdXNlIHRoZSBsaW5rICovCi0JCWlmIChsaW5rLT5tc3Rfc3Ry
ZWFtX2FsbG9jX3RhYmxlLnN0cmVhbV9jb3VudCA8PSAwKQotCQkJbGluay0+bGlua19zdGF0dXMu
bGlua19hY3RpdmUgPSBmYWxzZTsKLQl9IGVsc2UgewotCQlsaW5rLT5saW5rX3N0YXR1cy5saW5r
X2FjdGl2ZSA9IGZhbHNlOwotCX0KLX0KLQogc3RhdGljIHVpbnQzMl90IGdldF90aW1pbmdfcGl4
ZWxfY2xvY2tfMTAwaHooY29uc3Qgc3RydWN0IGRjX2NydGNfdGltaW5nICp0aW1pbmcpCiB7CiAK
LS0gCjIuMjQuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
