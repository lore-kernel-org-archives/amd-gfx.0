Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A05C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 03:35:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6E1220709
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 03:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E1220709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B8ED6F3E9;
	Fri, 15 Nov 2019 03:35:39 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690059.outbound.protection.outlook.com [40.107.69.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5868E6F3E9
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 03:35:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBO2YKSCMqY8uWcCKwlFugHa1obCHCvxCvqo5uxiCuoX+PhE6DIOz64E3Z6kMzazPNit4lWuSQnHELk1Ev+T2pZ4gjRf8EcRwHk8JhtlTJP3llbOltk7P8musZj43HTqRuxZNstRw0UrO26IM5xoBELFVJZkETOF10YOhAYTWYq2PNcyBS45oX279g/j+KY/VOTPNJ3sT6liCI5MX7Ab8JAgmz0fJUeG9try+lZjp2CbzaBWmmUQotV8qAOa8SWh+qfPqxQJmUFnygSLMqlJ8p8h5eKkXHDbKPw9tblVr78Ljr1laU+Yq6otlBJbqC8dX9y7tRlq4t50FourLkO+7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OUbQNIIv1FM/KjOTwiA2ZxUV+OFnVU3affKQPIRCrI=;
 b=FaQZNi39T+ZdF05cUN0cdPVnBHkCfj7k4zIQ7u3gGpuvm/K2uWTsFihn30rPrwP4Q7OPdVBvlwC6lb11PQBrXL0gPz6s5Bf2hTMR+Pukk0SRChAbdUkjwD+DijG8cws3WTOnvyzrVaZhcEvYDiscH1rJurOHeDYeTpJsBAo/IT8CiK6yvx8TzwcmEe4ox2f3vNmPGYXT5kR81c6XcUdDneiwWfwZCeeu5d0kGR05ApeJ6STGjmk3AlcPvhDv+WpiIpMY0gqLfJXhZHULUH46cUh726WscjuS23zZJOEFaposVNWrKOpmIHWp0AM8LkwT+WuwIJt9IQlJ4MW/4PXP+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3838.namprd12.prod.outlook.com (10.255.238.203) by
 MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 03:35:36 +0000
Received: from MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4]) by MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4%7]) with mapi id 15.20.2451.027; Fri, 15 Nov 2019
 03:35:36 +0000
From: Aaron Liu <aaron.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/12] amdgpu: using IB flags for TMZ or non-TMZ
Date: Fri, 15 Nov 2019 11:34:50 +0800
Message-Id: <1573788895-3936-7-git-send-email-aaron.liu@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5cd5bedf-070a-4a7d-4493-08d7697ce04d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3663:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB366363C2F5BA80830074259FF0700@MN2PR12MB3663.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 02229A4115
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(51416003)(52116002)(6512007)(76176011)(7736002)(386003)(26005)(11346002)(44832011)(486006)(4326008)(2616005)(25786009)(6506007)(6436002)(6486002)(5660300002)(478600001)(66556008)(446003)(186003)(86362001)(3846002)(6116002)(14454004)(48376002)(50466002)(66946007)(8936002)(50226002)(305945005)(66476007)(476003)(81156014)(81166006)(8676002)(2906002)(6916009)(16586007)(66066001)(14444005)(316002)(2351001)(2361001)(47776003)(6666004)(36756003)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3663;
 H:MN2PR12MB3838.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xqmtx3MJX/kemaI+C5Mudv4/WhY0HKmBFCJVRefyStvnWQnb2EqYPMV/0Rv1YGV7UhMJOeUulsNX79F4Ej221BwfWSMyRHz2y0aYGCZOmIaGyR+lwZaL6l55oCuBokc663egmoS+AVb3ZOm4e6I0BwHRJ0+gGJrCmtNs6gby4smztqBiuQILnWbUwWOr/E/rc7rJIYnxTZU5lhQ1wkXyJu9a3rn1Y6DEkOc4EnFNHqb2kglcMM2VYYfDjXSYAUEP42pySAcyPkdv6P7kSVm751S2taDp4RpiYeGPZhF1QvaIFrkvMHnI1cU/FcF/u0jxtezwiv8pOXp2MgTncjKkV6mZfeLHkqLRFU5XLlEKBOUP+eZ6rpoRUpwBi/1Ikfjt47imZcj8s6QofkqcLuNgtVzBd5ITMhzxTNtlCF/Zn0TSsXiYjFSbqmT0tpAZFfkf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd5bedf-070a-4a7d-4493-08d7697ce04d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 03:35:36.0422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSE6XL6Nvs+OrMxtJ0F8JZlpJ6g8MnZwMEqeXfuxUUav2hFpTVyBLegYpu5FZMzd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3663
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OUbQNIIv1FM/KjOTwiA2ZxUV+OFnVU3affKQPIRCrI=;
 b=JVEcFi/8akZ60KjBbrftIvyWOPzu7pPYgwrKxjBXEPzNscBmLlgMfbA46tM4MNlCcVNBFVK+GCq4I9iTSSSmm+Cv3/xzuvc8WAk/zUv/nDGkA7yAFbym9T/WRD8rAZCjLzQrf3eiTl/fjK0O/5Rxr2GlzgaXbxh10TjQHgv/gfk=
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
Message-ID: <20191115033450.leypXg5oB3fvAPS37b575U7z0HeAnt8vu9TMPOK52gE@z>

SW4ga2VybmVsLCBjcy0+aW4uZmxhZ3MgaXMgdXNlZCBmb3IgVE1aLiBIZW5jZSBsaWJkcm0gc2hv
dWxkIHRyYW5zZmVyCnRoZSBmbGFnIHRvIGtlcm5lbC4KClNpZ25lZC1vZmYtYnk6IEFhcm9uIExp
dSA8YWFyb24ubGl1QGFtZC5jb20+Ci0tLQogYW1kZ3B1L2FtZGdwdS5oICAgIHwgNCArKystCiBh
bWRncHUvYW1kZ3B1X2NzLmMgfCA0ICsrKysKIDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvYW1kZ3B1L2FtZGdwdS5oIGIvYW1kZ3B1
L2FtZGdwdS5oCmluZGV4IGY0NWY5ZjcuLmFlZTNmM2QgMTAwNjQ0Ci0tLSBhL2FtZGdwdS9hbWRn
cHUuaAorKysgYi9hbWRncHUvYW1kZ3B1LmgKQEAgLTM0Miw3ICszNDIsOSBAQCBzdHJ1Y3QgYW1k
Z3B1X2NzX2ZlbmNlX2luZm8gewogICogXHNhIGFtZGdwdV9jc19zdWJtaXQoKQogKi8KIHN0cnVj
dCBhbWRncHVfY3NfcmVxdWVzdCB7Ci0JLyoqIFNwZWNpZnkgZmxhZ3Mgd2l0aCBhZGRpdGlvbmFs
IGluZm9ybWF0aW9uICovCisJLyoqIFNwZWNpZnkgZmxhZ3Mgd2l0aCBhZGRpdGlvbmFsIGluZm9y
bWF0aW9uCisJICogMC1ub3JtYWwsIDEtdG16CisJICovCiAJdWludDY0X3QgZmxhZ3M7CiAKIAkv
KiogU3BlY2lmeSBIVyBJUCBibG9jayB0eXBlIHRvIHdoaWNoIHRvIHNlbmQgdGhlIElCLiAqLwpk
aWZmIC0tZ2l0IGEvYW1kZ3B1L2FtZGdwdV9jcy5jIGIvYW1kZ3B1L2FtZGdwdV9jcy5jCmluZGV4
IDQzN2M0YTQuLjZmNzA3NzEgMTAwNjQ0Ci0tLSBhL2FtZGdwdS9hbWRncHVfY3MuYworKysgYi9h
bWRncHUvYW1kZ3B1X2NzLmMKQEAgLTI1NCw2ICsyNTQsMTAgQEAgc3RhdGljIGludCBhbWRncHVf
Y3Nfc3VibWl0X29uZShhbWRncHVfY29udGV4dF9oYW5kbGUgY29udGV4dCwKIAltZW1zZXQoJmNz
LCAwLCBzaXplb2YoY3MpKTsKIAljcy5pbi5jaHVua3MgPSAodWludDY0X3QpKHVpbnRwdHJfdClj
aHVua19hcnJheTsKIAljcy5pbi5jdHhfaWQgPSBjb250ZXh0LT5pZDsKKwkvKiBpbiBrZXJuZWws
IF9wYWQgaXMgdXNlZCBhcyBmbGFncworCSAqICNkZWZpbmUgQU1ER1BVX0NTX0ZMQUdTX1NFQ1VS
RSAgICAgICAgICAoMSA8PCAwKQorCSAqLworCWNzLmluLl9wYWQgPSAodWludDMyX3QpaWJzX3Jl
cXVlc3QtPmZsYWdzOwogCWlmIChpYnNfcmVxdWVzdC0+cmVzb3VyY2VzKQogCQljcy5pbi5ib19s
aXN0X2hhbmRsZSA9IGlic19yZXF1ZXN0LT5yZXNvdXJjZXMtPmhhbmRsZTsKIAljcy5pbi5udW1f
Y2h1bmtzID0gaWJzX3JlcXVlc3QtPm51bWJlcl9vZl9pYnM7Ci0tIAoyLjcuNAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
