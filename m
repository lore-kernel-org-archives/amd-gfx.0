Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B65C17441
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:33:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4AE82184C
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4AE82184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CCEF6EA2A;
	Tue, 12 Nov 2019 00:33:52 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800051.outbound.protection.outlook.com [40.107.80.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33E346EA21
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 00:33:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfHnj9aMlkbQqsV0rLHj0xgpGI9Lqp+QsxwjPj7waj9z1QOa0s8+Z+W4kG8AcabTx6uab1pbZ81sHpqT9nngVpZBvpzFmFOloQJ5L0pcS72KWTx9uUhGIR+kJQsl+9gaORmBJiAAhenTdn+ipyVHxeJqFJfDX6uq7jdwkU1+OcAgDfJk9YxQKHtGPqi4Zl9WaZfa14OywUrCKXphsaxBEUk/nfvEZdcwdrt6habIeSwyYT+azLgPSzPz3kJnBPLAO6KDhatIKRSv4EgDZVE8z/Rkbt+fphavaX8GCMLih44bO3McXtNgxkwg8XRsM+mpVdyHFmapuuu15GKuPF2M9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQSvQc2+07nnj19C0sT/VlWs167HN70IKH2TFVY8yGc=;
 b=nR9gtN+emufxmKpqvbsuymtMkya5Po7doUI8s5Ya6GcBHpZ7maiFmL9EOCMO79ym8AULsjsreyZneuT90F7vOvbxGDsdYHK5BarWQ8hV5RMAYumnfmkHlf1DBfbFpRdkoER5pPpooVLLrj1RpQ4pzIzukrfMhiIwvUaCbY3FP6yJan6gRIoAQC9dB59+xD5J/Ms/3/nxLTtzhRe8c2u9jYUjEYml6UwUzPu+k4ULDs/fPxKGDc5AD1vI1QSU1OF/L+bRr8B5uvfkSnK/pa0tLM2GUGia7VHNjEE1g6Cf2SfHMUeyhtzuyg7zkGKht1ahwSwfDd4jU9IM49wC4Y6oIw==
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
Subject: [PATCH 02/30] drm/amd/display: Renoir chroma viewport WA change
 formula
Date: Mon, 11 Nov 2019 19:32:56 -0500
Message-Id: <20191112003324.8419-3-Rodrigo.Siqueira@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c67e55a6-224e-41c5-0050-08d76707fae0
X-MS-TrafficTypeDiagnostic: MW2PR12MB2554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB255455AB26D6567C10199F4298770@MW2PR12MB2554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
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
X-Microsoft-Antispam-Message-Info: F7egobonkyUHVpEi02eVw9b1IACk77Y/WerUJfve4DiBeRpqA/KApRQGCLgEC+sR4nROzwnRUc84+yLVcCrevBCpBBQBKdw/dBytS7DoM59V54Zr+jqtzgfPAZuZ11o01+yF5VOMWNijqppqYYYanv3/5kEuaAHAtUNVYhkzWcYl9rTYg06IjvkxUs2Gn4weX5swZ6JKMcgBTgmISINt/4GqILBV+AI/jX3hnSpZPmhEyBAVWmHhgdLYubkW+2rj9PN5J1RJ7rLzS/UT3AyqF4S/MxP/+RZs4cQ4maCafLT0hG624H5wpUfcXiALV0wZwIx5brpRFOPszPXVQLKyCYFUJnpY21EekJAkUCvuHbm7k3A8kGt701kylvXwQTZS4LeSo68jxfesh3fcDAFOT1vO1kxqNqL8kxirxtMenouHUwHsH4b+R94nePlbM0gd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c67e55a6-224e-41c5-0050-08d76707fae0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 00:33:47.0259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRRpa0Z6KNiWYHMC8c2zt0JAdkT6MCMiuezhtujApBB6BLOKlu7fAT/gzIuEEpeoW6mIUzrkYYKgw59cOFOugg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2554
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQSvQc2+07nnj19C0sT/VlWs167HN70IKH2TFVY8yGc=;
 b=MG70W7M03aT/OskhWYasaRe5nactnipxbVtajmjFbXFheWyyUTGb3w7huxXSA4yj9exVlzEzRbwNVBU/BmnCy/AQhUw9fGs9iWJDoKfmEPiZItuthxie6ZCaGx/zNege5cRvRTNa973Mr4BOUCx07YxvYC6ARRLRF5QptCTaGQw=
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
Message-ID: <20191112003256.0wtUh410W_ubeMH9GCWrGjjbKHvSMY_QbJVvz0p6p5A@z>

RnJvbTogSm9zZXBoIEdyYXZlbm9yIDxqb3NlcGguZ3JhdmVub3JAYW1kLmNvbT4KClt3aHldCndl
IHdhbnQgdG8gaW5jcmVhc2UgdGhlIHB0ZSByb3cgcGx1cyAxIGxpbmUgaWYgY2hyb21hIHZpZXdw
b3J0CmhlaWdodCBpcyBpbnRlZ2VyIG11bHRpcGxlIG9mIHRoZSBwdGUgcm93IGhlaWdodAoKW2hv
d10KaW5zdGVhZCBvZiBjZWlsaW5nIHZpZXdwb3J0IGhlaWdodCwgd2UgZmxvb3IgaXQuIHRoaXMg
YWxsb3dzCnVzIHRvIGFjY29tbW9kYXRlIGJvdGggY2FzZXM6IHRob3NlIHdoZXJlIHRoZSBjaHJv
bWEgdmlld3BvcnQKaGVpZ2h0IGlzIGludGVnZXIgbXVsdGlwbGUgb2YgdGhlIHB0ZSByb3cgaGVp
Z2h0IGFuZCB0aG9zZSB3aGVyZQppdCBpcyBub3QKClNpZ25lZC1vZmYtYnk6IEpvc2VwaCBHcmF2
ZW5vciA8am9zZXBoLmdyYXZlbm9yQGFtZC5jb20+ClJldmlld2VkLWJ5OiBUb255IENoZW5nIDxU
b255LkNoZW5nQGFtZC5jb20+CkFja2VkLWJ5OiBSb2RyaWdvIFNpcXVlaXJhIDxSb2RyaWdvLlNp
cXVlaXJhQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIx
L2RjbjIxX2h1YnAuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvZGNuMjEvZGNuMjFfaHVicC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Rj
bjIxL2RjbjIxX2h1YnAuYwppbmRleCAxZGRkNmFlMjIxNTUuLmQ4NmI2YjYyMTFiYyAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX2h1YnAuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfaHVicC5jCkBA
IC0yMDQsOCArMjA0LDggQEAgdm9pZCBodWJwMjFfc2V0X3ZpZXdwb3J0KAogCQkJUFRFX1JPV19I
RUlHSFRfTElORUFSLCAmcHRlX3Jvd19oZWlnaHQpOwogCiAJCXB0ZV9yb3dfaGVpZ2h0ID0gMSA8
PCAocHRlX3Jvd19oZWlnaHQgKyAzKTsKLQkJcHRlX3Jvd3MgPSAodmlld3BvcnRfYy0+aGVpZ2h0
ICsgcHRlX3Jvd19oZWlnaHQgLSAxKSAvIHB0ZV9yb3dfaGVpZ2h0OwotCQlwYXRjaGVkX3ZpZXdw
b3J0X2hlaWdodCA9IHB0ZV9yb3dzICogcHRlX3Jvd19oZWlnaHQgKyAzOworCQlwdGVfcm93cyA9
ICh2aWV3cG9ydF9jLT5oZWlnaHQgLyBwdGVfcm93X2hlaWdodCkgKyAxOworCQlwYXRjaGVkX3Zp
ZXdwb3J0X2hlaWdodCA9IHB0ZV9yb3dzICogcHRlX3Jvd19oZWlnaHQgKyAxOwogCX0KIAogCi0t
IAoyLjI0LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
