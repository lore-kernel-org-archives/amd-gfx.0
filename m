Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231E3C432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:36:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0435920848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0435920848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE9C56E2E2;
	Mon,  2 Dec 2019 17:35:58 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720070.outbound.protection.outlook.com [40.107.72.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C8256E2E1
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEzvucO8Ww7yGSeqHzbF8NKZTcfXDDJ2Y6X4m5mJM2CBQ5FmSKk6Ky08r6zKPoTcyL77uophbGS4RAkcvCtfi4zOOW25Pnvv4dVkl1pIJCvomDNQ26bOeENP80xPUjEGXFIykWm1XdyO3lbd4FAZQYYZFk96BKLNSnmfIwqLrEuJbcub1IKNqsU1O1UMcl+OLMhb81Hn04yqOVRBM+7FoDAXqn6oyr4s31OLXSrFqFlrmd2mgsUXQU7xwTlc/n7PUHHBOFeysb3eaBcetApmz8YQ0oruFMIBJCX6dYe03X4v2D4Wxgx7+GWQRjCvOGaGTnIdfQ+BB5OtuobqHxCbIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3PlsmZY+lX2UAmsKbL79MVTU6Ov3jIZul+REnp+tkU=;
 b=h6Iy377U4zBeLrgRA28mwN/iuouYmpRFZtLnZrKOdq4nd98up2fGg51TZCQcf8EHjRwcPiN/nvgh+nnWtmQ3K88Dq/T/41/JL1x1j4gUQ45s6VjmDGk6zImkvXhzrasr7Y9pVnF8KafEoSyf2J2VpzIixuSLbfDtUrXR52Gi8CKxO89SaiRl9LqeELWyrgwaDEbaVTOWCIs9uIqwpGhS9jGHqnBRlDlKw2CqT/sHBjVl2JY/Ib/0iI1p5wDPnb69xDTbfVYsYobNSUDkvNVrhdJb6YfzcSpYWp1QYcQ7UTVM7AH8tFupMW4WFoCSJvqzRX3aFCtnUcHAgGQ0B2tWqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2802.namprd12.prod.outlook.com (20.176.27.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:35:55 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:35:55 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 46/51] drm/amd/display: Change HDR_MULT check
Date: Mon,  2 Dec 2019 12:34:00 -0500
Message-Id: <20191202173405.31582-47-sunpeng.li@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d78483a8-c519-4df1-44bb-08d7774e05f0
X-MS-TrafficTypeDiagnostic: BN7PR12MB2802:|BN7PR12MB2802:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB28020CA808CF9E05863AF77F82430@BN7PR12MB2802.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(189003)(199004)(81166006)(81156014)(86362001)(6486002)(9686003)(6506007)(2870700001)(478600001)(386003)(76176011)(5660300002)(51416003)(186003)(1076003)(52116002)(3846002)(6116002)(47776003)(2616005)(26005)(66946007)(66066001)(25786009)(316002)(446003)(11346002)(14454004)(66476007)(66556008)(48376002)(8676002)(50226002)(305945005)(6512007)(36756003)(2906002)(99286004)(6666004)(7736002)(2351001)(54906003)(4326008)(2361001)(6916009)(6436002)(50466002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2802;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iU39pH3qjst57iOb/1zFWk7o+3YBTQg//om/LKLclGjaKyVkgCHP9gMONYiF4fqLJkXTwLdEzWvSOjPPuhb4qhn+i9CFqWMhMjjKn4REauIgR01OBefE1rZ30htq56+V4RWhoekYyiCud9Iv6Kq3HrTOi7Nh3rdMJYZ58rwmcGdoT++gwKl3yi+E1DQiyr2SPWtSrGWgDhF/SOFMjDJvUV1OJhXzP72Isk1tA+a0JjjUmhFSOX76cBH2C4FQ7dmj9SkmFFrRN7+vxA1VMCkQhqvmruweKxo7bPNLMXgfPF8OFSUFhLzMrpnhBnpq6O7NrTLc8G7nCYHgZm6oh9tI1nUI2lp2F12DM1OTLa6B5b0J+twU2eHkOM63Huz7AWFFWITC5gH4/LmR8+4h7RFifSLkoYxXH/V1cOMrjdukiAYFCXKptUJ+fMpwGtP7Ytxv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d78483a8-c519-4df1-44bb-08d7774e05f0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:35:28.9689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IlJvPQNeuHC1LsZtNeiMGp2fk132DeYlgqBsIttfEPWuC8gHDaFcCkfZU5qAyCyb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2802
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3PlsmZY+lX2UAmsKbL79MVTU6Ov3jIZul+REnp+tkU=;
 b=pA1E65imDOloSoRx7CTSqiTk9lRJq0dHRuGzDqkR50Q8JNQUxJLVoTUKiXdHHXbgbziUFQwE5llDgb3T86x3pAl7Sx4C9ZscKpVM/SLbNSiUzpsuI4ZpWTfmJ7iyHT7/VjEakkzSi6h02+teUXZ6YdPIzosxU9JvNZoX4tl48eY=
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
 Leo Li <sunpeng.li@amd.com>, harry.wentland@amd.com, rodrigo.siqueira@amd.com,
 bhawanpreet.lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogS3J1bm9zbGF2IEtvdmFjIDxLcnVub3NsYXYuS292YWNAYW1kLmNvbT4KCltXaHldCkN1
cnJlbnRseSB3ZSByZXF1aXJlIEhEUl9NVUxUID49IDEuMApUaGVyZSBhcmUgc2NlbmFyaW9zIHdo
ZXJlIHdlIG5lZWQgPCAxLjAKCltIb3ddCk9ubHkgZ3VhcmQgYWdhaW5zdCAwIC0gaXQgd2lsbCBi
bGFjay1zY3JlZW4gaW1hZ2UuCkl0IGlzIHVwIHRvIGhpZ2hlci1sZXZlbCBsb2dpYyB0byBkZWNp
ZGUgd2hhdCBIRFJfTVVMVAp2YWx1ZXMgYXJlIGFsbG93ZWQgaW4gZWFjaCBwYXJ0aWN1bGFyIGNh
c2UuCgpTaWduZWQtb2ZmLWJ5OiBLcnVub3NsYXYgS292YWMgPEtydW5vc2xhdi5Lb3ZhY0BhbWQu
Y29tPgpSZXZpZXdlZC1ieTogQXJpYyBDeXIgPEFyaWMuQ3lyQGFtZC5jb20+CkFja2VkLWJ5OiBM
ZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvZGNuMTAvZGNuMTBfaHdfc2VxdWVuY2VyLmMgfCA2ICstLS0tLQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24xMF9od19zZXF1ZW5jZXIuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24xMF9od19zZXF1ZW5jZXIuYwppbmRl
eCA2MWQyZjEyMzNmOGMuLjM5OTZmZWY1Njk0OCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX2h3X3NlcXVlbmNlci5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24xMF9od19zZXF1ZW5jZXIuYwpAQCAtMjM5
MCwxNyArMjM5MCwxMyBAQCB2b2lkIGRjbjEwX3NldF9oZHJfbXVsdGlwbGllcihzdHJ1Y3QgcGlw
ZV9jdHggKnBpcGVfY3R4KQogCXN0cnVjdCBmaXhlZDMxXzMyIG11bHRpcGxpZXIgPSBwaXBlX2N0
eC0+cGxhbmVfc3RhdGUtPmhkcl9tdWx0OwogCXVpbnQzMl90IGh3X211bHQgPSAweDFmMDAwOyAv
LyAxLjAgZGVmYXVsdCBtdWx0aXBsaWVyCiAJc3RydWN0IGN1c3RvbV9mbG9hdF9mb3JtYXQgZm10
OwotCWJvb2wgbXVsdF9uZWdhdGl2ZTsgLy8gVHJ1ZSBpZiBmaXhlZDMxXzMyIHNpZ24gYml0IGlu
ZGljYXRlcyBuZWdhdGl2ZSB2YWx1ZQotCXVpbnQzMl90IG11bHRfaW50OyAvLyBpbnQgY29tcG9u
ZW50IG9mIGZpeGVkMzFfMzIKIAogCWZtdC5leHBvbmVudGFfYml0cyA9IDY7CiAJZm10Lm1hbnRp
c3NhX2JpdHMgPSAxMjsKIAlmbXQuc2lnbiA9IHRydWU7CiAKLQltdWx0X25lZ2F0aXZlID0gbXVs
dGlwbGllci52YWx1ZSA+PiA2MyAhPSAwOwotCW11bHRfaW50ID0gbXVsdGlwbGllci52YWx1ZSA+
PiAzMjsKIAotCWlmIChtdWx0X2ludCAmJiAhbXVsdF9uZWdhdGl2ZSkgLy8gQ2hlY2sgaWYgZ3Jl
YXRlciB0aGFuIDEKKwlpZiAoIWRjX2ZpeHB0X2VxKG11bHRpcGxpZXIsIGRjX2ZpeHB0X2Zyb21f
aW50KDApKSkgLy8gY2hlY2sgIT0gMAogCQljb252ZXJ0X3RvX2N1c3RvbV9mbG9hdF9mb3JtYXQo
bXVsdGlwbGllciwgJmZtdCwgJmh3X211bHQpOwogCiAJcGlwZV9jdHgtPnBsYW5lX3Jlcy5kcHAt
PmZ1bmNzLT5kcHBfc2V0X2hkcl9tdWx0aXBsaWVyKAotLSAKMi4yNC4wCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
