Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41937C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 17:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1C9F2072B
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 17:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C9F2072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 945506E9F9;
	Fri, 15 Nov 2019 17:44:16 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam03on0610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe49::610])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54ED66E9F8
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 17:44:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtM2CmxHTwDy2lkXwICYdQ+pEPxEFFfOZg74ZsVwkD8qAV+WMlUAIKtitrWRX7jn6dgAlOrhqjR9YEQ6+OLhADO2WRlCmuNU2Ta7S87F0G2uVCgzDSLZ2GnI+8sL+mDRwWjwLHT1dBTX02EepqHugDzjMNTb35n7nKOSKIedpy00LVy4p3jN9t8La3K8SgkzCNXA77iX/FHzigqcLmtCltDIv42uVjz06+Dxmt3c8lL8tB878j0qZWT90VzI/6+Tswy6BQo72en5s66StSGGIlxAhaFrfotXwbuUnWOLIXNHx4wJONnapGLYWLKV+jW/OuzKgOoL/UpA9ubtKK+lIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EISCHPy0YXCWYRghZnaPHCkR/LLiO00Nb6M5/e+UsxM=;
 b=MplAsa6xICyLP6jPKx4IThT9wKFyZeEcsXcszRbfFyQSOK65S5qUR0p0as3U2rkhJFLGSOGjvXFjHVtPToBt+DSA8pqe6zb+MHIWb5NkaVG7JLkCohfwxcXJcrIQdh6/eXPwUrdhej0VgfhPytm4kI3vLLua3UIoGqJqBXk4m1SCXMcTenMqGoF4go7VgjZZEiNd9WGrxZglJvgTp+X00wroaoyyZRsE9ph6OfK/bu7FngKvuSDaf/ADlu1NJfoijIcYltd6f3nUv8gJ8O9ulD/r1J3wzeWxqbTSHrwVatLsqbGDhE5QaZRNYFy5cWV6fhH7l0Bzwi3MkKlqDGD1RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CH2PR12MB4182.namprd12.prod.outlook.com (20.180.16.11) by
 CH2PR12MB3734.namprd12.prod.outlook.com (52.132.245.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.27; Fri, 15 Nov 2019 17:44:13 +0000
Received: from CH2PR12MB4182.namprd12.prod.outlook.com
 ([fe80::24d1:40a8:f811:6be1]) by CH2PR12MB4182.namprd12.prod.outlook.com
 ([fe80::24d1:40a8:f811:6be1%6]) with mapi id 15.20.2451.027; Fri, 15 Nov 2019
 17:44:13 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] amd/amdgpu: force to trigger a no-retry-fault after a
 retry-fault
Date: Fri, 15 Nov 2019 11:43:14 -0600
Message-Id: <20191115174314.73446-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: SN4PR0501CA0080.namprd05.prod.outlook.com
 (2603:10b6:803:22::18) To CH2PR12MB4182.namprd12.prod.outlook.com
 (2603:10b6:610:ae::11)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 853a4889-8793-489e-4ec8-08d769f36d5d
X-MS-TrafficTypeDiagnostic: CH2PR12MB3734:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB37348390E8F4D3C1B03B658CFD700@CH2PR12MB3734.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-Forefront-PRVS: 02229A4115
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(189003)(199004)(478600001)(52116002)(1076003)(51416003)(48376002)(50466002)(386003)(6506007)(7736002)(4326008)(14444005)(305945005)(99286004)(36756003)(47776003)(16586007)(66066001)(316002)(2616005)(8676002)(44832011)(486006)(25786009)(2906002)(66556008)(66476007)(6116002)(66946007)(14454004)(3846002)(476003)(86362001)(50226002)(6436002)(81166006)(81156014)(5660300002)(26005)(186003)(2351001)(6486002)(2361001)(6916009)(8936002)(6512007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3734;
 H:CH2PR12MB4182.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bd/OWeVexu8Q+WFQSAe2Wx1ZvlPk9eSPltQ4CWfOVhQLwFZnBAw4unM6FNcNBRDG/boJ52A09MCguy5AG1aMvmuzI6wn5njYUMvOoD4xV38q+/3WbE3BS0EjbzxjcheQ1/8juYfHMAEjwyJvkLa/bEX72ZI017q/dZWLyXsECzV0mKuasIYjaLmVDUpsSxtHrG1Z1rcRFoBFO07jBxTq3OEsc15Ztfyctt0om8hyTc/ZHo+MqRQDzfSphmtSpijFpE2Y+tU5ELjrVvmrTnCuLJsys2pWRtneGcCe54KNdP9JFp+VYf8ebFUQfzaaxswx71y+sRCdIuyG0tCB+ZIo93TewBn+xEbapLQAU8FKBpo/QfiTZEVvAdt6t+doP0qYqAI+so5aOQq2lQ0/9Bxlt0T80/i1RLx+e9mN7yVBtr8FC56ZfFxQCJccjraodys5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 853a4889-8793-489e-4ec8-08d769f36d5d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 17:44:13.1753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p0kwjn/2u/Ufhwb2omuOYo8mN4AFmsS1lXw/Wi6i9276KaRy+4+k2EDqRWJQlOxQq/YjoDm/C+PU52wkI3d4gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3734
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EISCHPy0YXCWYRghZnaPHCkR/LLiO00Nb6M5/e+UsxM=;
 b=AwJXHQCtwG6FcQaCcFUMbC2Slf/JCjnud3G880EiNkD1NV2XARBjXr90WQb1VVVQOO9UY2KYSJ4jUgVwQDTlMt1XBHW035V7cCbkQnvM2Ym6/2JX37SaDOGVjv1jyRFCuH+O8y5mI/Vnh5jtmRYZjQDgAnWdgjzC4pM3j3ZEPyo=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115174314.JI20vxiiwQuLZhPsa83zPG2DT0JN22hXVLNrebsxAZ4@z>

QWZ0ZXIgYSByZXRyeS1mYXVsdCBoYXBwZW5zLCB0aGUgZmF1bHQgaGFuZGxlciB3aWxsIG1vZGlm
eSB0aGUgVVRDTDIgdG8Kc2V0IFBURSBiaXRzIHRvIGZvcmNlIGEgbm8tcmV0cnktZmF1bHQuIFRo
aXMgd2lsbCBjYXVzZSB0aGUgd2F2ZSB0bwplbnRlciB0aGUgdHJhcCBoYW5kbGVyLgoKQ2hhbmdl
LUlkOiBJMTc3MTAyODkxZjcxNTA2OGYxNTYwNTk1N2ZmMjNiMGNhYjg2MjYwMwpTaWduZWQtb2Zm
LWJ5OiBBbGV4IFNpZXJyYSA8YWxleC5zaWVycmFAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDEzICsrKysrLS0tLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm0uYwppbmRleCAzYzBiZDY0NzJhNDYuLmU0ZDFhOGZjOTdkNSAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKQEAgLTMxNjcsNyArMzE2Nyw4IEBAIGJv
b2wgYW1kZ3B1X3ZtX2hhbmRsZV9mYXVsdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdW5z
aWduZWQgaW50IHBhc2lkLAogCQkJICAgIHVpbnQ2NF90IGFkZHIpCiB7CiAJc3RydWN0IGFtZGdw
dV9ibyAqcm9vdDsKLQl1aW50NjRfdCB2YWx1ZSwgZmxhZ3M7CisJdWludDY0X3QgdmFsdWUgPSAw
OworCXVpbnQ2NF90IGZsYWdzOwogCXN0cnVjdCBhbWRncHVfdm0gKnZtOwogCWxvbmcgcjsKIApA
QCAtMzIwMCwxMyArMzIwMSw5IEBAIGJvb2wgYW1kZ3B1X3ZtX2hhbmRsZV9mYXVsdChzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwgdW5zaWduZWQgaW50IHBhc2lkLAogCQlBTURHUFVfUFRFX1NZ
U1RFTTsKIAogCWlmIChhbWRncHVfdm1fZmF1bHRfc3RvcCA9PSBBTURHUFVfVk1fRkFVTFRfU1RP
UF9ORVZFUikgewotCQkvKiBSZWRpcmVjdCB0aGUgYWNjZXNzIHRvIHRoZSBkdW1teSBwYWdlICov
Ci0JCXZhbHVlID0gYWRldi0+ZHVtbXlfcGFnZV9hZGRyOwotCQlmbGFncyB8PSBBTURHUFVfUFRF
X0VYRUNVVEFCTEUgfCBBTURHUFVfUFRFX1JFQURBQkxFIHwKLQkJCUFNREdQVV9QVEVfV1JJVEVB
QkxFOwotCX0gZWxzZSB7Ci0JCS8qIExldCB0aGUgaHcgcmV0cnkgc2lsZW50bHkgb24gdGhlIFBU
RSAqLwotCQl2YWx1ZSA9IDA7CisJCS8qIFNldHRpbmcgUFRFIGZsYWdzIHRvIHRyaWdnZXIgYSBu
by1yZXRyeS1mYXVsdCAgKi8KKwkJZmxhZ3MgPSBBTURHUFVfUFRFX0VYRUNVVEFCTEUgfCBBTURH
UFVfUERFX1BURSB8CisJCQlBTURHUFVfUFRFX1RGOwogCX0KIAogCXIgPSBhbWRncHVfdm1fYm9f
dXBkYXRlX21hcHBpbmcoYWRldiwgdm0sIHRydWUsIE5VTEwsIGFkZHIsIGFkZHIgKyAxLAotLSAK
Mi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
