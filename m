Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE428C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:33:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A93FE2184C
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A93FE2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BA216EA23;
	Tue, 12 Nov 2019 00:33:51 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800083.outbound.protection.outlook.com [40.107.80.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E29B6EA23
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 00:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VV3hkIPKSX6y7jqlyTqRwEfDkUq8YIn+LH3kZ4qmijOJwRD3Tobxz21WivrKtj7xrsr7U5G/GDx0mvpNZ7ZxdWBxH4fwmQZdEOT7+36pHMeUNyZcQMvFnWcYk9ioOobXRo5fKc2TM0r3AlJK8F5mwURcfoEgNCgPxrW20+6aJrp6OxGkyiFRTFFayzJ12AkPwjFcfGU3mxHBa+xIKeTkuUd+eUs5TX+bso2Si0+3WKt3rpCjBz7OdPQUj8OVtMYwcJ+eSM8e7UHbjOuBIvexdCc4P08WDHnDzpp3JiL7FDerhXw38F5eVGxcbJezg3/g3oTTJv3iOLVNXtPfmsr/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16S48d+S9pkNo8AlDM3Yzhhl/y9Kv6eqN9WkhGjzCp0=;
 b=glrk7xpO6IW8A/mPaEkDcrRbnkRK1Yw7jCEiYiXQL4fn8/k3PB6nwGO/22uFWyg6IHZ7/4EdhjblRxUbfHAwtVEmnpA2EtnVrJB5YhRXL634krj4kuaArFW31xJBT0uh6oUZOiwW65qH8A9fD8dNBUiO8Ztx7s2XPLexbfQYCckEWcqAgLEpr5z33u0jYHq8kTB89AmPWFEMUrBoELDvirP40H/SV9Xg8kkp69gAuqWMyYWbyGZTJkU2/ssIDObTQTsnPhqFr2b6JIpZooAu62ms3SvaWLUV9Ool/41dEBhkNrVOxDvXFZalyQ6Xoj6qIiJyPzIfpmtIFLyEHaBt9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2554.namprd12.prod.outlook.com (52.132.180.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 00:33:47 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 00:33:47 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/30] drm/amd/display: Renoir chroma viewport WA Read the
 correct register
Date: Mon, 11 Nov 2019 19:32:57 -0500
Message-Id: <20191112003324.8419-4-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: a782c447-7ba2-4ea7-8bff-08d76707fb50
X-MS-TrafficTypeDiagnostic: MW2PR12MB2554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25543A3013C2B941ED25BF6B98770@MW2PR12MB2554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(189003)(199004)(76176011)(6916009)(81166006)(81156014)(386003)(8676002)(478600001)(6506007)(51416003)(52116002)(2870700001)(25786009)(2906002)(186003)(2361001)(3846002)(316002)(66066001)(47776003)(50466002)(4326008)(26005)(66946007)(6116002)(36756003)(1076003)(8936002)(48376002)(50226002)(54906003)(2616005)(305945005)(486006)(5660300002)(6512007)(14454004)(2351001)(446003)(6486002)(6666004)(99286004)(66556008)(476003)(66476007)(11346002)(86362001)(6436002)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2554;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ZaNWnpUQzyoMvWmrJGahATdfy3pjRBQcvTtlkr7NnHidvAyNFB23YhK0rZjfoWh1LQWcK+PoCUey66Q/0qpKCmdp1Hvv2KAO+MgCgiJMIjZg48rX1WYyy6yWUheu+3FcOFkVzg3FGSK8RhYgsKDeoxgmmWt1rQ97yEwTn6yg5ETCSsFL4EZzCZhd5TykkEKKpOCodsB1DjUzCp0lvF1V2BheRlMhY74IU+aGZex5v26a9V1JT1PHPgidufB1DSog/JlVaD5w1JTWNimvs2J+UiC3PKb6eBYUAZYIQX7RCM89ZjLott3TxL5dg6x2auwzN+n+rlWx2xnOIzzfeJbsRwfYfIvbaC97Uxdu+lpfBaRKWSzLGe6EHZ13ZmjY1U8Cd1WXzJn++v9NVBcaFTvFZ8y+1kRvks3l6PCDKqJU7H7v6Q81EkA2uTSDlLJazg9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a782c447-7ba2-4ea7-8bff-08d76707fb50
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 00:33:47.7644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfWA7NIPga2asWVTqHkfSCoz+AmKDr4fuI20b0M2MjjxV0/9l493Qcw5/wm+jMtkXi8BoHCBaP229phAGHy0Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2554
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16S48d+S9pkNo8AlDM3Yzhhl/y9Kv6eqN9WkhGjzCp0=;
 b=ZsMVaWdAiVLWkTantMzIMkAOVt7t51ZBiN5mevZKh17AWaQ8stGjPej6O67U/wDKhDfNt1syBMtUsoD8iDuHCW6gKXLNmyQfvm6by9PkmqSONTkiC6CN6iJnfEIq85O5VL4z0tXiL4Eep9pgBjuX7NvwcX++A2+Shpq2d3enr6g=
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
Cc: Joseph Gravenor <joseph.gravenor@amd.com>, Tony Cheng <Tony.Cheng@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112003257.SQFifCufQe3QpaavgsPbnqzbP1d0y3w0Nc9wgMkP2Jg@z>

RnJvbTogSm9zZXBoIEdyYXZlbm9yIDxqb3NlcGguZ3JhdmVub3JAYW1kLmNvbT4KClt3aHldCkJl
Zm9yZSB3ZSB3ZXJlIHJlYWRpbmcgcmVnaXN0ZXJzIHNwZWNpZmljIHRvIGx1bWEgc2l6ZSwgd2hp
Y2ggY2F1c2VkIGEgYmxhY2sgbGluZQp0byBhcHBlYXIgb24gdGhlIHNjcmVlbiBmcm9tIHRpbWUg
dG8gdGltZSwgYXMgYWx0aG91Z2ggdGhlIGx1bWEgcm93IGhlaWdodAppcyBnZW5lcmFsbHkgdGhl
IHNhbWUgYXMgdGhlIGNocm9tYSByb3cgaGVpZ2h0IGZvciB0aGUgdmlkZW8gY2FzZSwgaXQgd2ls
bCBzb21ldGltZXMKYmUgb25lIG1vcmUKCltob3ddClJlYWQgdGhlIHJlZ2lzdGVyIHNwZWNpZmlj
IGZvciB0aGUgY2hyb21hIHNpemUKClNpZ25lZC1vZmYtYnk6IEpvc2VwaCBHcmF2ZW5vciA8am9z
ZXBoLmdyYXZlbm9yQGFtZC5jb20+ClJldmlld2VkLWJ5OiBUb255IENoZW5nIDxUb255LkNoZW5n
QGFtZC5jb20+CkFja2VkLWJ5OiBSb2RyaWdvIFNpcXVlaXJhIDxSb2RyaWdvLlNpcXVlaXJhQGFt
ZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX2h1
YnAuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEv
ZGNuMjFfaHVicC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIx
X2h1YnAuYwppbmRleCBkODZiNmI2MjExYmMuLjMyZThiNTg5YWViNSAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX2h1YnAuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfaHVicC5jCkBAIC0yMDAsOCAr
MjAwLDggQEAgdm9pZCBodWJwMjFfc2V0X3ZpZXdwb3J0KAogCQlpbnQgcHRlX3Jvd19oZWlnaHQg
PSAwOwogCQlpbnQgcHRlX3Jvd3MgPSAwOwogCi0JCVJFR19HRVQoRENIVUJQX1JFUV9TSVpFX0NP
TkZJRywKLQkJCVBURV9ST1dfSEVJR0hUX0xJTkVBUiwgJnB0ZV9yb3dfaGVpZ2h0KTsKKwkJUkVH
X0dFVChEQ0hVQlBfUkVRX1NJWkVfQ09ORklHX0MsCisJCQlQVEVfUk9XX0hFSUdIVF9MSU5FQVJf
QywgJnB0ZV9yb3dfaGVpZ2h0KTsKIAogCQlwdGVfcm93X2hlaWdodCA9IDEgPDwgKHB0ZV9yb3df
aGVpZ2h0ICsgMyk7CiAJCXB0ZV9yb3dzID0gKHZpZXdwb3J0X2MtPmhlaWdodCAvIHB0ZV9yb3df
aGVpZ2h0KSArIDE7Ci0tIAoyLjI0LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeA==
