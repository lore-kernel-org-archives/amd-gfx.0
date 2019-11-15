Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE071C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 03:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B51820709
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 03:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B51820709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F3A16F3F4;
	Fri, 15 Nov 2019 03:35:54 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690081.outbound.protection.outlook.com [40.107.69.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DECB6F3F6
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 03:35:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcTaNT9BY7YNotemL4ygi/I85q5ttcwYMp6jHPJHNa1VJDOv/ZMOkVW9File4vfQQLk64s/h2OE6UELp7Aot9HqlnD/nrHyz17EAxJsi7vvRdzoaxk8RKlHJwbWlxhMEfD7CBIDZ3/QtaVEMkaE2BuaYNcZVuf1ewt4J72oI0oooogMgItehah+sH8gIj5mlGOr0O/GVWgKUJSjj+JfETnUFnswbgXk3yGU7Nis+dqy/Be0j7+yO/I8gvpsgX9ITdEbP3gL7aVa4ZpT+6mk+UuqEGa4Lsj3AV+wT4J85laNap3ctLqDEu1BaRoLlblT+b4Jj3kmJmkbulEKvjh+Xlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hq5vIt69OqFIBAxd5Jic27ttb3LztbkaXRBs7s2zWOY=;
 b=CDD/ugIMzLVL3FUIqnlvnPtoc6kMHDZHvEnYINLXXjYiER908oFWxbTbFL2gGdfnr8dj7JlUGkeP3qG1fluJkbCtNS27TmQsl4AiNDs9sM7X5EomRgoY7CE2B+40F+qRKB6GgnERYwfVfMnuS5O5T1bJIwS2Se4vfutxaIS/xZ5f0/Gvvo27BO7TQP+0MjKxYbX+2MPDd/6wx6h1jelWHvhkBdVrJqBrC4hG9vT2+7qrZfatZRBW/bMcPcPBPhBSI4w7LVzYYUZSVJJSeYQLHk0/9eQy2xIzTveS3/gweL8fUqmB0TuA7irWHbppiUb56ZJvTSJSaWAGn3kNhfZWnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3838.namprd12.prod.outlook.com (10.255.238.203) by
 MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 03:35:49 +0000
Received: from MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4]) by MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4%7]) with mapi id 15.20.2451.027; Fri, 15 Nov 2019
 03:35:49 +0000
From: Aaron Liu <aaron.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/12] tests/amdgpu: add atomic dma command to verify the
 secure buffer
Date: Fri, 15 Nov 2019 11:34:54 +0800
Message-Id: <1573788895-3936-11-git-send-email-aaron.liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
X-ClientProxiedBy: HK0PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:203:36::18) To MN2PR12MB3838.namprd12.prod.outlook.com
 (2603:10b6:208:16c::11)
MIME-Version: 1.0
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8f65afd3-33c9-4ecf-13d8-08d7697ce897
X-MS-TrafficTypeDiagnostic: MN2PR12MB3663:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB36639C0F36A3D4451CB25D5CF0700@MN2PR12MB3663.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 02229A4115
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(51416003)(52116002)(6512007)(76176011)(7736002)(386003)(26005)(11346002)(44832011)(486006)(4326008)(2616005)(25786009)(6506007)(6436002)(6486002)(5660300002)(478600001)(66556008)(446003)(186003)(86362001)(3846002)(6116002)(14454004)(48376002)(50466002)(66946007)(8936002)(50226002)(305945005)(66476007)(476003)(81156014)(81166006)(8676002)(2906002)(15650500001)(6916009)(16586007)(66066001)(14444005)(316002)(2351001)(2361001)(47776003)(6666004)(36756003)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3663;
 H:MN2PR12MB3838.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Zj9iXca6W5IeWsk3PanRUqoy8jDHsngc88LWTTQDf1C8WqtgVBOVpUlnAYoJoQF4t5lMCiwTeIlMBVlxvynUPoOed5GCN2HtstBU9SyCKT5BUmLWkAdA4wcJfKI+LPTu9vGFgfXj/biY0ZAoEzP1BLpZbcGWwhu8nk3CFPp/xnZJMLLdnCpGdQZrGvMeFNRNGfQpfS0dssp+Btg79PYd6TO8XqMKlgGREwdVZO6V3KvCILzwGVqjByxqpHskg6i/k+gdjb77SfT8G7YoQuhg+cbhPqb8P+I2nG0mzID0xgKlBNhEIlnMcnqAP7OcuDJIATWvugeyeU5+jr4fc1tihIat/me3nArnhI+ZbWhy5h4dZXN0eBrgBCBbaD+V8r/mTij5CH4/1hKyF5xRsCiHYqOchPgQkLDnE6ydOltaJCKPpka4MgwcU3nK+UBBocw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f65afd3-33c9-4ecf-13d8-08d7697ce897
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 03:35:49.9387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eb6iKM3b97rC/vIzydW10Dx/vPAyVVygARSb/6CfdXadBoqMZV6b5ypM5IcJr9VD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3663
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hq5vIt69OqFIBAxd5Jic27ttb3LztbkaXRBs7s2zWOY=;
 b=nFkvIugGP0nHJxM/IGHFMkjb+DQI6B26FuhsPpL0ggMG+wf+z5SQMIAf20pqVcMYYGuDlo4N8wd7TEIHbBKNrpKOTvpry5sza89k9IP6uHnnHFosryyM1qt/mqsDsAFmFU+XeTn3pxVf/EIFaP4MrSByGjMl8O8zS2j+1e3/vFU=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Aaron.Liu@amd.com; 
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
Cc: Marek.Olsak@amd.com, Ray.Huang@amd.com, Aaron Liu <aaron.liu@amd.com>,
 Luben.Tuikov@amd.com, Alexander.Deucher@amd.com, Leo.Liu@amd.com,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115033454.T5gibBtIsFO6ACJPKj_bpyjqjvpS2HkM59vSWtSr4As@z>

RE1BJ3MgYXRvbWljIGJlaGF2aXIgaXMgdW5saWtlIEdGWCxJZiB0aGUgY29tcGFyaW5nIGRhdGEg
aXMgbm90CmVxdWFsIHRvIGRlc3RpbmF0aW9uIGRhdGEsCkZvciBHRlgsIGxvb3AgYWdhaW4gdGls
bCBnZnggdGltZW91dChzeXN0ZW0gaGFuZykuCkZvciBETUEsIGxvb3AgYWdhaW4gdGlsbCB0aW1l
ciBleHBpcmVkIGFuZCB0aGVuIHNlbmQgaW50ZXJydXB0LgpTbyB0ZXN0Y2FzZSBjYW4ndCB1c2Ug
aW50ZXJydXB0IG1lY2hhbmlzbS4KV2UgdGFrZSBhbm90aGVyIHdheSB0byB2ZXJpZnkuIFdoZW4g
dGhlIGNvbXBhcmluZyBkYXRhIGlzIG5vdAplcXVhbCB0byBkZXN0aW5hdGlvbiBkYXRhLCBvdmVy
d3JpdGUgdGhlIHNvdXJjZSBkYXRhIHRvIHRoZSBkZXN0aW5hdGlvbgpidWZmZXIuIE90aGVyd2lz
ZSwgb3JpZ2luYWwgZGVzdGluYXRpb24gZGF0YSB1bmNoYW5nZWQuClNvIGlmIHRoZSBib19jcHUg
ZGF0YSBpcyBvdmVyd3JpdHRlbiwgdGhlIHJlc3VsdCBpcyBwYXNzZWQuCgpTdGVwczoKMS4gdXNl
IGxpbmVhciB3cml0ZSBwYWNrZXQgdG8gd3JpdGUgMHhkZWFkYmVhZiB0byBzZWN1cmUgYnVmZmVy
LAoyLiB1c2UgYXRtb2ljIHBhY2tldCBhbmQgQVRPTUlDX0NNUFNXQVBfUlROXzMyIG9wY29kZSB0
byBjb21wYXJlCnRoZSBjbXBfZGF0YSgweGRlYWRiZWFmKSB0byB0aGUgd3JpdHRlbiBkYXRhIHdo
aWNoIGhhcyBiZWVuIGVuY3J5cHRlZC4KClNpZ25lZC1vZmYtYnk6IEFhcm9uIExpdSA8YWFyb24u
bGl1QGFtZC5jb20+Ci0tLQogdGVzdHMvYW1kZ3B1L2Jhc2ljX3Rlc3RzLmMgfCA1NSArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwg
NTMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0cy9hbWRn
cHUvYmFzaWNfdGVzdHMuYyBiL3Rlc3RzL2FtZGdwdS9iYXNpY190ZXN0cy5jCmluZGV4IDkwNzIz
N2UuLjVlNjg3ZTMgMTAwNjQ0Ci0tLSBhL3Rlc3RzL2FtZGdwdS9iYXNpY190ZXN0cy5jCisrKyBi
L3Rlc3RzL2FtZGdwdS9iYXNpY190ZXN0cy5jCkBAIC0xMDksNiArMTA5LDIwIEBAIENVX1Rlc3RJ
bmZvIGJhc2ljX3Rlc3RzW10gPSB7CiAjZGVmaW5lCVNETUFfT1BDT0RFX0NPUFkJCQkJICAxCiAj
ICAgICAgIGRlZmluZSBTRE1BX0NPUFlfU1VCX09QQ09ERV9MSU5FQVIgICAgICAgICAgICAgICAg
MAogCisjZGVmaW5lCVNETUFfT1BDT0RFX0FUT01JQwkJCQkgIDEwCisjCQlkZWZpbmUgU0RNQV9B
VE9NSUNfTE9PUCh4KSAgICAgICAgICAgICAgICgoeCkgPDwgMCkKKyAgICAgICAgLyogMCAtIHNp
bmdsZV9wYXNzX2F0b21pYy4KKyAgICAgICAgICogMSAtIGxvb3BfdW50aWxfY29tcGFyZV9zYXRp
c2ZpZWQuCisgICAgICAgICAqLworIwkJZGVmaW5lIFNETUFfQVRPTUlDX1RNWih4KSAgICAgICAg
ICAgICAgICAoKHgpIDw8IDIpCisJCS8qIDAgLSBub24tVE1aLgorCQkgKiAxIC0gVE1aLgorCSAg
ICAgKi8KKyMJCWRlZmluZSBTRE1BX0FUT01JQ19PUENPREUoeCkgICAgICAgICAgICAgKCh4KSA8
PCA5KQorCQkvKiBUQ19PUF9BVE9NSUNfQ01QU1dBUF9SVE5fMzIgMHgwMDAwMDAwOAorCQkgKiBz
YW1lIGFzIFBhY2tldCAzCisJCSAqLworCiAjZGVmaW5lIEdGWF9DT01QVVRFX05PUCAgMHhmZmZm
MTAwMAogI2RlZmluZSBTRE1BX05PUCAgMHgwCiAKQEAgLTE0MDgsNiArMTQyMiw3IEBAIGFtZGdw
dV9jb21tYW5kX3N1Ym1pc3Npb25fd3JpdGVfbGluZWFyX2hlbHBlcl93aXRoX3NlY3VyZShhbWRn
cHVfZGV2aWNlX2hhbmRsZQogCXN0cnVjdCBhbWRncHVfY3NfcmVxdWVzdCAqaWJzX3JlcXVlc3Q7
CiAJdWludDY0X3QgYm9fbWM7CiAJdm9sYXRpbGUgdWludDMyX3QgKmJvX2NwdTsKKwl1aW50MzJf
dCBib19jcHVfb3JpZ2luOwogCWludCBpLCBqLCByLCBsb29wLCByaW5nX2lkOwogCXVpbnQ2NF90
IGd0dF9mbGFnc1syXSA9IHswLCBBTURHUFVfR0VNX0NSRUFURV9DUFVfR1RUX1VTV0N9OwogCWFt
ZGdwdV92YV9oYW5kbGUgdmFfaGFuZGxlOwpAQCAtMTQ2MCw4ICsxNDc1LDkgQEAgYW1kZ3B1X2Nv
bW1hbmRfc3VibWlzc2lvbl93cml0ZV9saW5lYXJfaGVscGVyX3dpdGhfc2VjdXJlKGFtZGdwdV9k
ZXZpY2VfaGFuZGxlCiAJCQkJCQkJCSAgc2RtYV93cml0ZV9sZW5ndGgpOwogCQkJCWVsc2UKIAkJ
CQkJcG00W2krK10gPSBTRE1BX1BBQ0tFVChTRE1BX09QQ09ERV9XUklURSwKLQkJCQkJCQkgICAg
ICAgU0RNQV9XUklURV9TVUJfT1BDT0RFX0xJTkVBUiwgMCk7Ci0JCQkJcG00W2krK10gPSAweGZm
ZmZmZmZmICYgYm9fbWM7CisJCQkJCQkJICAgICAgIFNETUFfV1JJVEVfU1VCX09QQ09ERV9MSU5F
QVIsCisJCQkJCQkJICAgICAgIHNlY3VyZSA/IFNETUFfQVRPTUlDX1RNWigxKSA6IDApOworCQkJ
CXBtNFtpKytdID0gMHhmZmZmZmZmYyAmIGJvX21jOwogCQkJCXBtNFtpKytdID0gKDB4ZmZmZmZm
ZmYwMDAwMDAwMCAmIGJvX21jKSA+PiAzMjsKIAkJCQlpZiAoZmFtaWx5X2lkID49IEFNREdQVV9G
QU1JTFlfQUkpCiAJCQkJCXBtNFtpKytdID0gc2RtYV93cml0ZV9sZW5ndGggLSAxOwpAQCAtMTUx
Myw2ICsxNTI5LDQxIEBAIGFtZGdwdV9jb21tYW5kX3N1Ym1pc3Npb25fd3JpdGVfbGluZWFyX2hl
bHBlcl93aXRoX3NlY3VyZShhbWRncHVfZGV2aWNlX2hhbmRsZQogCQkJCQkJCWlwX3R5cGUsIHJp
bmdfaWQsIGksIHBtNCwKIAkJCQkJCQkxLCByZXNvdXJjZXMsIGliX2luZm8sCiAJCQkJCQkJaWJz
X3JlcXVlc3QsIHRydWUpOworCQkJfSBlbHNlIGlmIChpcF90eXBlID09IEFNREdQVV9IV19JUF9E
TUEpIHsKKwkJCQkvKiByZXN0b3JlIHRoZSBib19jcHUgdG8gY29tcGFyZSAqLworCQkJCWJvX2Nw
dV9vcmlnaW4gPSBib19jcHVbMF07CisJCQkJbWVtc2V0KCh2b2lkKilwbTQsIDAsIHBtNF9kdyAq
IHNpemVvZih1aW50MzJfdCkpOworCQkJCS8qIGF0b21pYyBvcGNvZGUgZm9yIDMyYiB3LyBSVE4g
YW5kIEFUT01JQ19TV0FQQ01QX1JUTgorCQkJCSAqIGxvb3AsIDEtbG9vcF91bnRpbF9jb21wYXJl
X3NhdGlzZmllZC4KKwkJCQkgKiBzaW5nbGVfcGFzc19hdG9taWMsIDAtbHJ1CisJCQkJICovCisJ
CQkJcG00W2krK10gPSBTRE1BX1BBQ0tFVChTRE1BX09QQ09ERV9BVE9NSUMsCisJCQkJCQkJICAg
ICAgIDAsCisJCQkJCQkJICAgICAgIFNETUFfQVRPTUlDX0xPT1AoMSkgfAorCQkJCQkJCSAgICAg
ICBTRE1BX0FUT01JQ19UTVooMSkgfAorCQkJCQkJCSAgICAgICBTRE1BX0FUT01JQ19PUENPREUo
VENfT1BfQVRPTUlDX0NNUFNXQVBfUlROXzMyKSk7CisJCQkJcG00W2krK10gPSAweGZmZmZmZmZj
ICYgYm9fbWM7CisJCQkJcG00W2krK10gPSAoMHhmZmZmZmZmZjAwMDAwMDAwICYgYm9fbWMpID4+
IDMyOworCQkJCXBtNFtpKytdID0gMHgxMjM0NTY3ODsKKwkJCQlwbTRbaSsrXSA9IDB4MDsKKwkJ
CQlwbTRbaSsrXSA9IDB4ZGVhZGJlYWY7CisJCQkJcG00W2krK10gPSAweDA7CisJCQkJcG00W2kr
K10gPSAweDEwMDsKKwkJCQlhbWRncHVfdGVzdF9leGVjX2NzX2hlbHBlcl9yYXcoZGV2aWNlLCBj
b250ZXh0X2hhbmRsZSwKKwkJCQkJCQlpcF90eXBlLCByaW5nX2lkLCBpLCBwbTQsCisJCQkJCQkJ
MSwgcmVzb3VyY2VzLCBpYl9pbmZvLAorCQkJCQkJCWlic19yZXF1ZXN0LCB0cnVlKTsKKwkJCQkv
KiBETUEncyBhdG9taWMgYmVoYXZpciBpcyB1bmxpa2UgR0ZYCisJCQkJICogSWYgdGhlIGNvbXBh
cmluZyBkYXRhIGlzIG5vdCBlcXVhbCB0byBkZXN0aW5hdGlvbiBkYXRhLAorCQkJCSAqIEZvciBH
RlgsIGxvb3AgYWdhaW4gdGlsbCBnZnggdGltZW91dChzeXN0ZW0gaGFuZykuCisJCQkJICogRm9y
IERNQSwgbG9vcCBhZ2FpbiB0aWxsIHRpbWVyIGV4cGlyZWQgYW5kIHRoZW4gc2VuZCBpbnRlcnJ1
cHQuCisJCQkJICogU28gdGVzdGNhc2UgY2FuJ3QgdXNlIGludGVycnVwdCBtZWNoYW5pc20uCisJ
CQkJICogV2UgdGFrZSBhbm90aGVyIHdheSB0byB2ZXJpZnkuIFdoZW4gdGhlIGNvbXBhcmluZyBk
YXRhIGlzIG5vdAorCQkJCSAqIGVxdWFsIHRvIGRlc3RpbmF0aW9uIGRhdGEsIG92ZXJ3cml0ZSB0
aGUgc291cmNlIGRhdGEgdG8gdGhlIGRlc3RpbmF0aW9uCisJCQkJICogYnVmZmVyLiBPdGhlcndp
c2UsIG9yaWdpbmFsIGRlc3RpbmF0aW9uIGRhdGEgdW5jaGFuZ2VkLgorCQkJCSAqIFNvIGlmIHRo
ZSBib19jcHUgZGF0YSBpcyBvdmVyd3JpdHRlbiwgdGhlIHJlc3VsdCBpcyBwYXNzZWQuCisJCQkJ
ICovCisJCQkJQ1VfQVNTRVJUX05PVF9FUVVBTChib19jcHVbMF0sIGJvX2NwdV9vcmlnaW4pOwog
CQkJfQogCiAJCQlyID0gYW1kZ3B1X2JvX3VubWFwX2FuZF9mcmVlKGJvLCB2YV9oYW5kbGUsIGJv
X21jLAotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
