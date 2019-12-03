Return-Path: <SRS0=OLW4=ZZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097DEC432C0
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2019 17:49:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD7092080F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2019 17:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7092080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A01206E86C;
	Tue,  3 Dec 2019 17:49:40 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730076.outbound.protection.outlook.com [40.107.73.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F6876E86C
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2019 17:49:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nr3Tc1osRL4DSE2YPwAgua3dFSuohQCocB+MaUfE49mVZHu1bmrdYWqMlPocnb+TKDFE+zeG+KLUJNRJ5Em4WciFZpVWMPUDPRdj/vHVQ4sn7wUUsTED3syHMwCUiF1FYEQN0sTF2p6UWxx879U5Bn3xAqOu3qiJLhvB/MiJdLDoaOw2iLb9oizEgFqGCQnkqB28S3UvUDFaa5wk5mZ6jLKokVfouI8r7Rx8h5ePB+By1bF3We07uBwskAPJRh0nVoGxuDmfZKbBKfWa6mv80uciMPYLhjYvcFkDdOo/8SPGhF74yq8oyRwTe9m3QfB4ylm5JpDxwzdATitPyaRBRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gv7UbEurtFFsE6b0VdDE3Eq9FP9OXl+NFyuRmmA15Ac=;
 b=mHZVojyqcHs6U7ZUIH64yKBSWnMVyVfz2fFjVWifHodFYVYx3KElnx8jhNaJg/aowqN+RfVTjPmISoUyu+sHT4IT+HxPcch3f4hkMcUOxGMVlSx3dY3cNwcmB5XPvcy606TFBwKK2adNSjB8NSZZz6JOn0cZqmcgIoQilWSjCNWntDm5UsUkkFt+pN2SBb6mtdQzfKE3OgQrM/7PSWbvCZixgmSM9DlDDI7emBbPtYFQfUty2S9PLobq7h90aaGTQWMFsSutBwcjID8FvcOZjEwg6TwdQUFwgxS660P8IrNa+cVwBAxDgpwY2H2fpKMm2SawUSpvgLTvre3EiDEPtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3466.namprd12.prod.outlook.com (20.178.198.225) by
 DM6PR12MB3883.namprd12.prod.outlook.com (10.255.174.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Tue, 3 Dec 2019 17:49:37 +0000
Received: from DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::8954:6ba3:6dca:4616]) by DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::8954:6ba3:6dca:4616%7]) with mapi id 15.20.2516.003; Tue, 3 Dec 2019
 17:49:37 +0000
From: Zhan Liu <zhan.liu@amd.com>
To: amd-gfx@lists.freedesktop.org, hersenxs.wu@amd.com,
 Nicholas.Kazlauskas@amd.com
Subject: [PATCH v2] drm/amd/display: Loading NV10/14 Bounding Box Data
 Directly from Code
Date: Tue,  3 Dec 2019 12:49:21 -0500
Message-Id: <20191203174921.9357-1-zhan.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::15) To DM6PR12MB3466.namprd12.prod.outlook.com
 (2603:10b6:5:3b::33)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 329ba6d8-a312-4db8-a6b0-08d778192a4d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3883:|DM6PR12MB3883:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3883926C8F2979911B6F442A9E420@DM6PR12MB3883.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-Forefront-PRVS: 02408926C4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(189003)(199004)(26005)(4326008)(2616005)(44832011)(5660300002)(99286004)(66556008)(6506007)(186003)(50466002)(386003)(305945005)(3846002)(48376002)(6512007)(7736002)(6116002)(6636002)(8936002)(16586007)(316002)(6436002)(1076003)(50226002)(81166006)(66946007)(66476007)(478600001)(2906002)(6486002)(6666004)(36756003)(81156014)(86362001)(51416003)(25786009)(52116002)(8676002)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3883;
 H:DM6PR12MB3466.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p5BNP5cIp8DuI63RaZSQrTjWnrzoL3jT4qfgaeL8AQY4YlFSU5fsKoqd+C9BW040ZmBZBStn38j3c4Kn5b3rJXkSv1RGCf+b/Ysg2Ba0DJRg8ZdsqeXm4WFBPU3u2cKLP1g230dlzYvMP8byypxei3uWqknHEE/ORRSXszpiGXxotFtRG/qiHvEfHlq/WvjBo9sTsIJU7n43u6D/sg8wH6pOrBxpXka3QwDT9JWIv+Dm0H1Zo2kfziOy4pL99GQ7wEm3zlhEpNXLlnzjz6uM02JBjlukSO941X0OXcnclzdU3OjH2FuhqspnJnPPkIbSg9+iHBneBdqyOTs0XnmKb27Eql76mNp/pMg5PQ/7wAsw/3eWBV8Af4Gk8PcT8Bg/oXBDkZ6HDhCp0jiSOM62ciZo445NnmR7Ib8mJyWM0G/RThcs82muc53pqSIZHe07
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 329ba6d8-a312-4db8-a6b0-08d778192a4d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2019 17:49:37.7071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7384HvHvBE14pLl6kdtWGyyx4C5nWUVcdPF4QU0YRIidMJ7OAG0uKBHQL3ASV7OF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3883
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gv7UbEurtFFsE6b0VdDE3Eq9FP9OXl+NFyuRmmA15Ac=;
 b=pprh5G+A8PlieFqroBEpzG7eYBfT82YU1e5stTLgZQgMAWTipazcBe2Xm+agRFhwjuVuORxQi9/NtE/bugGrUQCT1iAEspL7mLvnyqE8gW99DYVXAs75bW+bJErsjdvfY3Mnm7zIDVsuDUqV+8PxhVzg6WTeYhoufHeQki2zPwY=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
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
Cc: Zhan Liu <zhan.liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1doeV0KTlYxMC8xNCBoYXMgcmVsZWFzZWQuIEl0cyB0aW1lIHRvIGdldCBOVjEwLzE0IGJvdW5k
aW5nIGJveApkaXJlY3RseSBmcm9tIGNvZGUuCgpbSG93XQpSZXRyaWV2ZSBOVjEwLzE0IGJvdW5k
aW5nIGJveCBkYXRhIGRpcmVjdGx5IGZyb20gY29kZS4KUmV0cmlldmUgTlYxMiBib3VuZGluZyBi
b3ggZGF0YSBmcm9tIGZpcm13YXJlLgoKU2lnbmVkLW9mZi1ieTogWmhhbiBMaXUgPHpoYW4ubGl1
QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIw
X3Jlc291cmNlLmMgfCA3ICsrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvZGNuMjAvZGNuMjBfcmVzb3VyY2UuYwppbmRleCAyY2NmZDg0YTdkYTQuLjJhMTU4ZmY1ZjBh
NSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIw
X3Jlc291cmNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2Rj
bjIwX3Jlc291cmNlLmMKQEAgLTgzLDggKzgzLDYgQEAKIAogI2luY2x1ZGUgImFtZGdwdV9zb2Ni
Yi5oIgogCi0vKiBOVjEyIFNPQyBCQiBpcyBjdXJyZW50bHkgaW4gRlcsIG1hcmsgU1cgYm91bmRp
bmcgYm94IGludmFsaWQuICovCi0jZGVmaW5lIFNPQ19CT1VORElOR19CT1hfVkFMSUQgZmFsc2UK
ICNkZWZpbmUgRENfTE9HR0VSX0lOSVQobG9nZ2VyKQogCiBzdHJ1Y3QgX3Zjc19kcGlfaXBfcGFy
YW1zX3N0IGRjbjJfMF9pcCA9IHsKQEAgLTMyNzEsMTIgKzMyNjksMTMgQEAgc3RhdGljIGJvb2wg
aW5pdF9zb2NfYm91bmRpbmdfYm94KHN0cnVjdCBkYyAqZGMsCiAKIAlEQ19MT0dHRVJfSU5JVChk
Yy0+Y3R4LT5sb2dnZXIpOwogCi0JaWYgKCFiYiAmJiAhU09DX0JPVU5ESU5HX0JPWF9WQUxJRCkg
eworCS8qIFRPRE86IHVwc3RyZWFtIE5WMTIgYm91bmRpbmcgYm94IHdoZW4gaXRzIGxhdW5jaGVk
ICovCisJaWYgKCFiYiAmJiBBU0lDUkVWX0lTX05BVkkxMl9QKGRjLT5jdHgtPmFzaWNfaWQuaHdf
aW50ZXJuYWxfcmV2KSkgewogCQlEQ19MT0dfRVJST1IoIiVzOiBub3QgdmFsaWQgc29jIGJvdW5k
aW5nIGJveC9uIiwgX19mdW5jX18pOwogCQlyZXR1cm4gZmFsc2U7CiAJfQogCi0JaWYgKGJiICYm
ICFTT0NfQk9VTkRJTkdfQk9YX1ZBTElEKSB7CisJaWYgKGJiICYmIEFTSUNSRVZfSVNfTkFWSTEy
X1AoZGMtPmN0eC0+YXNpY19pZC5od19pbnRlcm5hbF9yZXYpKSB7CiAJCWludCBpOwogCiAJCWRj
bjJfMF9udjEyX3NvYy5zcl9leGl0X3RpbWVfdXMgPQotLSAKMi4xNy4xCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
