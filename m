Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B23FC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:33:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB7312184C
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7312184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DC106EA25;
	Tue, 12 Nov 2019 00:33:51 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800083.outbound.protection.outlook.com [40.107.80.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 854E86EA24
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 00:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFtok8TMkMkxwgGEn3EAQan5LXjSpjD0p2NQM0jZNcfTbJMCOORNWqjE6UeFVrekXepppBlQ3sP0GW4BjN90vPKyyFH+MqD5KM0C52QTizdW+unY7za5Kw/mEkTvjxNrW8PoBiaEh3J/HZjwuXKWvcelcIlmiOjmTTSYV0D/mpfHepO4LQieb86N+sf43zLF8u75Q5uSEOoMbHXaJSpx2qzd7y7vtkTkXAujPtNLFebcQeyM+sAf90abH21uwxUy0ZTiRdinS/r3Rw0OwAd8sIT/euQmCUk2wB4WKM1qo1cMzrV1Os8OB6VKYd6stFBK4vieOMSSmHibd5OAJCgscQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6izQO24lSD3CY7Scyeh2lhidkXI5ebUYEm5HPyVCuM=;
 b=dQ4U03TmwfVOG/7bzEGpXpdPeKKOzgfL6cBj9jUMB8cljF0CmOBaBvHgVtcAHRh/ZhvJX/ZvotjJnoSRT4+KwdQbSOJ/jhJdp/Q8sIj3gMo4js3m0zT+1znYOFv8M8kOSkuM4l1+mpjGW6YUgZhi/4Oz3eatQfv59evTHNMPRUDrTnsDBc/dFrOdt0Ji1JARkE2DpxpvloDtHNAggRygt9kzBLDl3IObW/dGJ5Qev9ZIlHiOUWd3bM4ofTsdLXcOurclxEbrSmBewElM2I/jdXQBk6CCILENL8qrRJyrHsFbZNRqE08G8nqeq32hnvOYH+djITs6wMFs+Bz1B7b18Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2554.namprd12.prod.outlook.com (52.132.180.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 00:33:48 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 00:33:48 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/30] drm/amd/display: Add hubp clock status in DTN log for
 Navi
Date: Mon, 11 Nov 2019 19:32:58 -0500
Message-Id: <20191112003324.8419-5-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: a3801fbe-0a85-4b13-028b-08d76707fbb9
X-MS-TrafficTypeDiagnostic: MW2PR12MB2554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25540ADEBBE6A7E4E463AF6D98770@MW2PR12MB2554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:147;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(189003)(199004)(76176011)(6916009)(81166006)(81156014)(386003)(8676002)(478600001)(6506007)(51416003)(52116002)(2870700001)(25786009)(2906002)(186003)(2361001)(3846002)(316002)(66066001)(47776003)(50466002)(4326008)(26005)(66946007)(6116002)(36756003)(1076003)(8936002)(48376002)(50226002)(54906003)(2616005)(305945005)(486006)(5660300002)(6512007)(14454004)(2351001)(446003)(6486002)(6666004)(99286004)(66556008)(476003)(66476007)(11346002)(86362001)(4744005)(6436002)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2554;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9d+qTzGKD3fJ8+I4EqOdYpsp8GOoyiJpU6e7DYKfS7vy3Cg6bInDXzPWqqkpkDmtjM0xC34PIqbYwHi7sjrl3gj7M0VpgSgSf24MhI8dGjXtCq/HMt0mnxNEYFQF6XbjN0tqr3kFYINXFwQoMjCc91N5QXbK5thxnRpAFdsdeh3MTE8CDvEDXSPK7OWCRBkxkP0c6QYjSmyHJgca5DEB/9f+YVx3fvSJlOEK1IKmsv2JxzDBplMm1JlN9OWTRlSv41RbOTIcVkxafJg1a69OBdoKAV6oF63cUTqh4LrU/Fsr7TI2e0edCY9muUb8NBiWYDi3jL6hY03EgNaeyldWpOTpb7xRK/7qIq+xs/GRHKwP/C8mQ0vsliZK2dOYsEjS4n+znglzl4E8sSlNZYB/DUnqmn1JNzhc3BivJqk+duk06xNljxMIJHnxK5VJQFHN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3801fbe-0a85-4b13-028b-08d76707fbb9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 00:33:48.4600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUHfBwPMkI8l3i/Db5CxeojyX/+q0ABUEut8nFdovvoaAa5ec8KaB6tF+vVFjRHWi1S59f2bzFlbp3CbJum1Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2554
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6izQO24lSD3CY7Scyeh2lhidkXI5ebUYEm5HPyVCuM=;
 b=t4trVVlcs4xN9BdSrglZsvy1zBVbmZgwxnyt5zuTqM+6Or6K9FbSqqgvCgQFgjQbrnMhZbKPQsnCVXONqa6Dfcbin23b8qCAoey5epYbVG3DG4FlP5fxTZEDp/PidCXg3NosWodwlR97ziXRbAPVPaW16z+R58tKLx7D6WQrtJE=
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
Cc: "Leo \(Hanghong\) Ma" <hanghong.ma@amd.com>,
 Harry Wentland <Harry.Wentland@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112003258.aI_y-aTK9dalrLXxfLs1vJ9Xuz5jmQ4B9qbd5Pg2BmQ@z>

RnJvbTogIkxlbyAoSGFuZ2hvbmcpIE1hIiA8aGFuZ2hvbmcubWFAYW1kLmNvbT4KCltXaHldCkZv
ciBkZWJ1ZyBwdXJwb3NlLCB3ZSBuZWVkIHRvIGNoZWNrIEhVQlBfQ0xPQ0tfRU5BQkxFIGluIERU
Tgpsb2cgZGVidWdmcyBvbiBOYXZpLgoKW0hvd10KQWRkIHJlbGF0ZWQgcmVnaXN0ZXIgcmVhZCBp
biBkY24yMF9odWJwLmMuCgpTaWduZWQtb2ZmLWJ5OiBMZW8gKEhhbmdob25nKSBNYSA8aGFuZ2hv
bmcubWFAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxIYXJyeS5XZW50bGFu
ZEBhbWQuY29tPgpBY2tlZC1ieTogUm9kcmlnbyBTaXF1ZWlyYSA8Um9kcmlnby5TaXF1ZWlyYUBh
bWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9o
dWJwLmMgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9odWJwLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfaHVicC5jCmluZGV4IGYw
NDMyNTYwNGY2Yy4uN2Q5ZmZiODE1ODRhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfaHVicC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kY24yMC9kY24yMF9odWJwLmMKQEAgLTEyMDIsNiArMTIwMiw5IEBAIHZvaWQg
aHVicDJfcmVhZF9zdGF0ZV9jb21tb24oc3RydWN0IGh1YnAgKmh1YnApCiAJCQlIVUJQX1RUVV9E
SVNBQkxFLCAmcy0+dHR1X2Rpc2FibGUsCiAJCQlIVUJQX1VOREVSRkxPV19TVEFUVVMsICZzLT51
bmRlcmZsb3dfc3RhdHVzKTsKIAorCVJFR19HRVQoSFVCUF9DTEtfQ05UTCwKKwkJCUhVQlBfQ0xP
Q0tfRU5BQkxFLCAmcy0+Y2xvY2tfZW4pOworCiAJUkVHX0dFVChEQ05fR0xPQkFMX1RUVV9DTlRM
LAogCQkJTUlOX1RUVV9WQkxBTkssICZzLT5taW5fdHR1X3ZibGFuayk7CiAKLS0gCjIuMjQuMAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
