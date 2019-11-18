Return-Path: <SRS0=5Use=ZK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7FCC432C3
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 05:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 186A720726
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 05:19:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186A720726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A206189C03;
	Mon, 18 Nov 2019 05:19:00 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720054.outbound.protection.outlook.com [40.107.72.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BA6B89C03
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2019 05:18:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/c/7HcBFgL6YJWOUfcfcxcirMLZuFnTH7zIRalYNjCUTYciuDRxl5FdE0qcdJuib+6J9dbIU2GRdrFnMFgsiL9eWCpaC4lyOLNVC7faZhxjid7DjVIyDrEWvS17NVjC5dsMtAWrx8JcupvekL7i26vIzY4liBQocBwGtVvVkzeywryUg2joapm8sNuSoDx6Rk8/KoxFfR+DClp6rNZ7lLwoHN8Ola7U8hmaPcCbuDLDbIvV/chl5Gm4+HOpkinw+smszXPbKISSfotRtq11NRKMrGMT6JKWWTRChDpGunImpggwANGhTmzbj4AF6iCm1QPlEI649IlkHgAUNOvUQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZiQbnpIdmykhw9mBLnaU3OolBoMX35K+ihz49hAIIs=;
 b=Njp4Wq2Jldc35tcaklGdGVHeB6NqiWBtB4pPBh2hXLY2Y+IfP+oZoF1pCR3q+sODgfUgOGGri2L5p6HXw0P3T7/bp3si+JVntgwQZEWyNVxzRR2xCLQxMq4eCs4bXhLrH/wkyLOUJN5hukS5mGPFFTeFEsdKGPVAEFWZqhVLFJpVIIrdgIxn8PzwkQd8wvNGBTycVXfRd5WBbarvhd9TtmrsKXoGCk0seNDqed2eHBA40lEfncczNGf915j+nl/nrkk0dUChioN5mBhDBJSgUMzSfjESRDMvGEebCZC3xWH0WLInNLwFQ7mAosmL3HC6Kq1EkU4kH1Tej+eRfVSQxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3838.namprd12.prod.outlook.com (10.255.238.203) by
 MN2PR12MB3712.namprd12.prod.outlook.com (10.255.236.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Mon, 18 Nov 2019 05:18:58 +0000
Received: from MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4]) by MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4%7]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 05:18:58 +0000
From: Aaron Liu <aaron.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/5] drm/amdgpu: enable TMZ bit in sdma copy pkt for sdma v5
Date: Mon, 18 Nov 2019 13:18:35 +0800
Message-Id: <1574054316-2802-4-git-send-email-aaron.liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574054316-2802-1-git-send-email-aaron.liu@amd.com>
References: <1574054316-2802-1-git-send-email-aaron.liu@amd.com>
X-ClientProxiedBy: HK2PR04CA0059.apcprd04.prod.outlook.com
 (2603:1096:202:14::27) To MN2PR12MB3838.namprd12.prod.outlook.com
 (2603:10b6:208:16c::11)
MIME-Version: 1.0
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6969028d-603e-4143-6f3b-08d76be6d02c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3712:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB37121E8E43C02229496BC050F04D0@MN2PR12MB3712.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 0225B0D5BC
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(199004)(189003)(4744005)(86362001)(486006)(44832011)(2616005)(476003)(2351001)(66476007)(11346002)(25786009)(5660300002)(446003)(386003)(6436002)(66946007)(36756003)(26005)(6512007)(50226002)(8936002)(186003)(81156014)(8676002)(81166006)(66556008)(6486002)(66066001)(478600001)(305945005)(14444005)(6506007)(2361001)(316002)(47776003)(16586007)(6116002)(50466002)(3846002)(52116002)(4326008)(51416003)(2906002)(99286004)(76176011)(6916009)(7736002)(14454004)(48376002)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3712;
 H:MN2PR12MB3838.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RdSKWZmSQ8673Cb0WXJlywfKLbcmrdbhADQYw7OUpXTqJIRzhNiACIeqa7yoaZ+5+k7OV6xl61vFVuwHGVnyTkF/FynfTwUnB0XiXwpswHCchfBpIFC8w+5hL87NH0y5DGPH1KAcVfqN4F8o6uW7UIKoXcryW4wdKJgOH/Ox4bsU7tfHp8tK7geKoz4TpTZXw+o4pktstr6yEw2pJtXoSyL3F8uPB7avXzEKmZGPWx09g53djXh3K4vGWTSxrNadNSdFD7DRhJDVtVNMcAg/9bBgxmW9ZUocRrTlUvn+AGAKE79ps2ZcAvQNOnC9/+lbVpPXProyNOPqZDwJPkYEtEFHF8auvvfhtOuwW2GRFO//+QoEaOqDV1M3FNQ7hDp9uD+QF/cFy/vr46Om28QPvl6J0pgwhkQspaY29Jt1Xo9Z+sT6Rx4cROcGP4itClYC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6969028d-603e-4143-6f3b-08d76be6d02c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2019 05:18:57.9145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yb8fzImi7K6uKXf3KqBo5+3BFHXCs8uOirexAQDBzqB6NkVXLmzOpd8Ok5dB/OMe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3712
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZiQbnpIdmykhw9mBLnaU3OolBoMX35K+ihz49hAIIs=;
 b=qtdqzECHkdJp0o0erc2WKpMwpZItE6bCYZZfPtl4lCcc65kBXmhgklzSuhqPDDQ5safkpqgkkptea3YvWDrJklh0mx6KkbwwHY94+S/993fYg6vkXq1CUDaGVDSwTXIv15EJ1wa+SnuDwHeufCKMWkX3HD7AK3qsgAIniR7JTEg=
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
Cc: Alexander.Deucher@amd.com, Luben.Tuikov@amd.com, Ray.Huang@amd.com,
 Christian.Koenig@amd.com, Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191118051835.ZNiDYtjLUon2uIjhISaT1OA-RH5fitELj3DMcNgGV58@z>

RW5hYmxlIHNkbWEgVE1aIG1vZGUgdmlhIHNldHRpbmcgVE1aIGJpdCBpbiBzZG1hIGNvcHkgcGt0
CmZvciBzZG1hIHY1LgoKU2lnbmVkLW9mZi1ieTogQWFyb24gTGl1IDxhYXJvbi5saXVAYW1kLmNv
bT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzAuYyB8IDMgKystCiAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8wLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzAuYwppbmRleCBiNmE3MWE3Li42NGM1M2VlIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzAuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzAuYwpAQCAtMTY2NCw3ICsxNjY0LDggQEAgc3Rh
dGljIHZvaWQgc2RtYV92NV8wX2VtaXRfY29weV9idWZmZXIoc3RydWN0IGFtZGdwdV9pYiAqaWIs
CiAJCQkJICAgICAgIGJvb2wgdG16KQogewogCWliLT5wdHJbaWItPmxlbmd0aF9kdysrXSA9IFNE
TUFfUEtUX0hFQURFUl9PUChTRE1BX09QX0NPUFkpIHwKLQkJU0RNQV9QS1RfSEVBREVSX1NVQl9P
UChTRE1BX1NVQk9QX0NPUFlfTElORUFSKTsKKwkJU0RNQV9QS1RfSEVBREVSX1NVQl9PUChTRE1B
X1NVQk9QX0NPUFlfTElORUFSKSB8CisJCVNETUFfUEtUX0NPUFlfTElORUFSX0hFQURFUl9UTVoo
dG16ID8gMSA6IDApOwogCWliLT5wdHJbaWItPmxlbmd0aF9kdysrXSA9IGJ5dGVfY291bnQgLSAx
OwogCWliLT5wdHJbaWItPmxlbmd0aF9kdysrXSA9IDA7IC8qIHNyYy9kc3QgZW5kaWFuIHN3YXAg
Ki8KIAlpYi0+cHRyW2liLT5sZW5ndGhfZHcrK10gPSBsb3dlcl8zMl9iaXRzKHNyY19vZmZzZXQp
OwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
