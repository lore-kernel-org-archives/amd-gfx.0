Return-Path: <SRS0=G8as=BB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC603C433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 11:40:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F01820729
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jul 2020 11:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YlCDxn/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F01820729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 361A96E10D;
	Wed, 22 Jul 2020 11:40:40 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680088.outbound.protection.outlook.com [40.107.68.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA15C6E10D
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jul 2020 11:40:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLe68pYiVRRK8JKs7MkQ5elbMhy5cfHE8djgwgSdNltbaehNL+bM3q2CS3i8y8sdLuxDIICf0wCMnXye8HC7JD1Nnd/Y0oARXoH5UNgBMR8B5lhXJmZPdwb2vGqvAcf3svcZ8yCU3LF6h7I7HbX2+fdkjcCt81qXe2ohr4hfJW21zWpxuSNkxQpTiLyb8Xv+l9u23ZzdzeE3gjrRQHt8groMefqb9b55sW8utHdOtdjPAN9iI2kCQZ+AxQx76noRDSJTqPd7X0jLHOZ/OcqhLoNJugTX9VGq7XuZoHEwwV8EZBxc6FoJpeEovwKJEQX+/kwVmyHmvlyErHLjkiAShQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSM9ukYrGBoU/InF2iK8L34gkVE4FOZ9HHGy81cnDRI=;
 b=Zf8cJlMiq8kzMFJjj80eMcFxR6ICrsy1Ls+G39iFmlupZb72JiQBOVmqP9Fba815w7ju9YPyvKRL+inNlGPRvyz8L/dQLTqWIddvHiCjBriiS0/w/x1oOh3x5hKuU3pFYXB4N3TGoRFFOoGi3Xsr7bBk/36MB4Sj+k7crbAc11jH4UVLlO8Xn+kCaGeJ3aMM0K34s29OPm2C14Z44lXRtc6InHf4f+Wxsr9KgCgljqTsJ1Us+Yxv6QjWTf+lnesUuOecKIwsLQhFPAyxR6rgBc3pspD9rEUocj9lnPOhtadtmI3SLp9nFs4F2TvpEYGm/K2Y5/PQNHITuDKsyWHTbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSM9ukYrGBoU/InF2iK8L34gkVE4FOZ9HHGy81cnDRI=;
 b=YlCDxn/t23ngSJ28MV8K92BoOoiLQYHgS3iqSjxvJ3FZc2Rjs2ykga5D4/Gd9mjVf7HTfwKAjCx2MKLtrJz2t5aZcACHCtI8LfAd+QJ+AEuAqfdwjazOhwY2AJjI0Yy4MT0Fj+62OKHpNQ/n/pAxtBkmgfxnEtHrdBMLaYixUpc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by DM6PR12MB4515.namprd12.prod.outlook.com (2603:10b6:5:2a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Wed, 22 Jul
 2020 11:40:37 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::446f:752b:f450:e89a]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::446f:752b:f450:e89a%5]) with mapi id 15.20.3195.028; Wed, 22 Jul 2020
 11:40:37 +0000
From: Tom St Denis <tom.stdenis@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: Fix compiler warning in df driver
Date: Wed, 22 Jul 2020 07:40:28 -0400
Message-Id: <20200722114028.1204439-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: BN6PR21CA0018.namprd21.prod.outlook.com
 (2603:10b6:404:8e::28) To DM6PR12MB3547.namprd12.prod.outlook.com
 (2603:10b6:5:18a::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ws.amd.com (165.204.84.11) by
 BN6PR21CA0018.namprd21.prod.outlook.com (2603:10b6:404:8e::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.1 via Frontend Transport; Wed, 22 Jul 2020 11:40:35 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dfb5cd6f-741e-4c5f-eb99-08d82e340cf5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4515:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4515103BB6A0679F20AE9ACFF7790@DM6PR12MB4515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:81;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QEmhgjlDtd/zIZZIWPwCB9Sft9hGyrjHME+l8/2TQ0VCtzVJHlLivV6rf8amy9y/gpfgwE9V9+BDPOJMOTs1ZSMYQkYTcKDDyNevEM1yZtG1Wad2+CXNYR9EBmmIo0Tp4QyTJwPhqKF5A4PwVlzjQNFtl8+XO9dfktlJ7xxWzf84TLDaSZUEZgZpfJNklrJoV9Nu6Cb8tlV80ZDODS/MU2wMpyr/MX02R4+f02UobB5HWFixOekXolR+G76B6ie0eLA9WbMoliYPk2cEYgkr141u5tDU3A6uN/hMWhXueDdr95A5+Jv94mG90dx0ejEBgHya1Euz2aAdYT7s6fAe/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(7696005)(5660300002)(6916009)(8936002)(8676002)(2906002)(52116002)(4326008)(956004)(26005)(6486002)(86362001)(1076003)(186003)(66556008)(478600001)(6666004)(316002)(2616005)(36756003)(83380400001)(66946007)(16526019)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: +o8cQmuVgGXbzpBCWGWh94nMKzDFtnXjnw8CKc7UCqXj2+d+pIi2yzFgt9SkEoFE9y9jlM/vWmpA+5/PwNizhTWIm/saVjSEMmUtuuD2m6IYkRA9dFTjhgk46Uh9gwCxy8AyFdaAJZ9QZxxZqJQRcEh6wX7Pp7uhPVdRPaWrhpMdxjspi0ynumiAtnhelJCVnDixYFpZ3+XZXOobf0Az5t4TooNld3NonH2zcRgMh0eXrjeTapEMPe9VJJDFGo0PEye1SrEbFa4gGIr5hBnib8xaptNMTrooqid+V91alZwMDG0vp/QGqMqiJ1NC/sCySNVc9Jyxt+xoK73mE+1RKsxlwHRVIrVTl/f20G8O5IFCYAfo1Dc2IBvPk9bP/w9oOkQUu1iWLz/BmuZDsd6LBikQ5AACBuazNgQO9FNyIHG+mPM37e1bnZE1aanImY5ZNyk9Y4b5CzpV4B9CY+fGI0c/De8OoLG94UprADAl/g8=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb5cd6f-741e-4c5f-eb99-08d82e340cf5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 11:40:36.8922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0QPLL1D2P8Od7XAUp93Xg74NbEUM8C6Dku092yiggDYWgSKuQk6GVOkutOrXeEOhfZaA1OIlZqgsvjCrarmtCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4515
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Tom St Denis <tom.stdenis@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4IHRoaXMgd2FybmluZzoKCiAgQ0MgW01dICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
ZnhodWJfdjFfMS5vCkluIGZpbGUgaW5jbHVkZWQgZnJvbSBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcmluZy5oOjI5LAogICAgICAgICAgICAgICAgIGZyb20gZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5oOjI2LAogICAgICAgICAgICAgICAgIGZyb20gZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1Lmg6NDMsCiAgICAgICAgICAgICAgICAgZnJv
bSBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9kZl92M182LmM6MjM6CmRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2RmX3YzXzYuYzogSW4gZnVuY3Rpb24g4oCYZGZfdjNfNl9wbWNfZ2V0X2Nv
dW504oCZOgouL2luY2x1ZGUvZHJtL2RybV9wcmludC5oOjQ4NzoyOiB3YXJuaW5nOiDigJhoaV9i
YXNlX2FkZHLigJkgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIFst
V21heWJlLXVuaW5pdGlhbGl6ZWRdCiAgNDg3IHwgIF9fZHJtX2RiZyhEUk1fVVRfRFJJVkVSLCBm
bXQsICMjX19WQV9BUkdTX18pCiAgICAgIHwgIF5+fn5+fn5+fgpkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9kZl92M182LmM6NjQ5OjI1OiBub3RlOiDigJhoaV9iYXNlX2FkZHLigJkgd2FzIGRl
Y2xhcmVkIGhlcmUKICA2NDkgfCAgdWludDMyX3QgbG9fYmFzZV9hZGRyLCBoaV9iYXNlX2FkZHIs
IGxvX3ZhbCA9IDAsIGhpX3ZhbCA9IDA7CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAg
Xn5+fn5+fn5+fn5+CkluIGZpbGUgaW5jbHVkZWQgZnJvbSBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcmluZy5oOjI5LAogICAgICAgICAgICAgICAgIGZyb20gZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5oOjI2LAogICAgICAgICAgICAgICAgIGZyb20gZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1Lmg6NDMsCiAgICAgICAgICAgICAgICAgZnJv
bSBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9kZl92M182LmM6MjM6Ci4vaW5jbHVkZS9kcm0v
ZHJtX3ByaW50Lmg6NDg3OjI6IHdhcm5pbmc6IOKAmGxvX2Jhc2VfYWRkcuKAmSBtYXkgYmUgdXNl
ZCB1bmluaXRpYWxpemVkIGluIHRoaXMgZnVuY3Rpb24gWy1XbWF5YmUtdW5pbml0aWFsaXplZF0K
ICA0ODcgfCAgX19kcm1fZGJnKERSTV9VVF9EUklWRVIsIGZtdCwgIyNfX1ZBX0FSR1NfXykKICAg
ICAgfCAgXn5+fn5+fn5+CmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RmX3YzXzYuYzo2NDk6
MTE6IG5vdGU6IOKAmGxvX2Jhc2VfYWRkcuKAmSB3YXMgZGVjbGFyZWQgaGVyZQogIDY0OSB8ICB1
aW50MzJfdCBsb19iYXNlX2FkZHIsIGhpX2Jhc2VfYWRkciwgbG9fdmFsID0gMCwgaGlfdmFsID0g
MDsKClNpZ25lZC1vZmYtYnk6IFRvbSBTdCBEZW5pcyA8dG9tLnN0ZGVuaXNAYW1kLmNvbT4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9kZl92M182LmMgfCAyICstCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9kZl92M182LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9kZl92M182LmMKaW5kZXggMWFiMjYxODM2OTgzLi4wYWExYWMxYWNjZDYgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RmX3YzXzYuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9kZl92M182LmMKQEAgLTY0Niw3ICs2NDYsNyBAQCBzdGF0aWMgdm9pZCBk
Zl92M182X3BtY19nZXRfY291bnQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQkJICB1
aW50NjRfdCBjb25maWcsCiAJCQkJICB1aW50NjRfdCAqY291bnQpCiB7Ci0JdWludDMyX3QgbG9f
YmFzZV9hZGRyLCBoaV9iYXNlX2FkZHIsIGxvX3ZhbCA9IDAsIGhpX3ZhbCA9IDA7CisJdWludDMy
X3QgbG9fYmFzZV9hZGRyID0gMCwgaGlfYmFzZV9hZGRyID0gMCwgbG9fdmFsID0gMCwgaGlfdmFs
ID0gMDsKIAkqY291bnQgPSAwOwogCiAJc3dpdGNoIChhZGV2LT5hc2ljX3R5cGUpIHsKLS0gCjIu
MjYuMgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
