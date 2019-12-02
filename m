Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6F7C432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D6BA20848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6BA20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B5C66E2A5;
	Mon,  2 Dec 2019 17:35:06 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720044.outbound.protection.outlook.com [40.107.72.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F1206E290
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T924ml7jzRl3+u+ZOjHiMPgzK2rWyrgggvbcKDWB/wI13xGEUXKVITY5+v6t6W1R3LmXzplGGHtVpORZwAb9ykgOsFoyBfx8R/+cZsiYpLX+fFP47U3gvfXLdz+AybCv8t0+q0XCt8gQN5DqmZnboqLRKplT+3kGQ+5+UWCSVREXIO9ivX3FIYlhrZIPv92n27WoxP2/JFRHaHiz6nILraZAymS2X5aj9ZqmgCKKKOkQRXIHLWvrCFfjOGWf0Ez3FPHGZPS22UrXGptxDr3uwrkG1sHHdylep0mB3JoJ+FRYJPBuqcetQ8aMooKb1RbLz1pV1Y+cQLGnZTROOb92Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxdcSXbNc38V0vIM9G5qGAiHttmVWjROhZP/PKDnJuk=;
 b=XlxbGQe9kuFmt1OHGX8gyjm0KzYRRrtgbdKGvmJBtcJGsA57+2PB76SMF3qu5IcYSo0aAvwXkYeErQuB28hf9Y3lcO18LnueU3dhrUNCt9BCONagXwrdxp2wsMFwVCbiVRqFlawejuTDWy+KFMCeHoK4pYmVu6Eo5KktHjsIHKv6G7ghJqp4pyKKWpg6Gh+MXDLOXIiiCZbFQgP0sWTQ8RGQY4fq+s7Ho904j6y+xVxtirqc5fuB/oO6H4YSvjajPGYjc9QoGXiil0ii9gXK5NrnLgnA7uAIu1bERDjxNbwoMCmghLDHZYYvKxB5ntgmr1c7F6t5ASxHBJC8ttCgmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2802.namprd12.prod.outlook.com (20.176.27.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:35:01 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:35:01 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/51] drm/amd/display: Fixed kernel panic when booting with
 DP-to-HDMI dongle
Date: Mon,  2 Dec 2019 12:33:29 -0500
Message-Id: <20191202173405.31582-16-sunpeng.li@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0cc3395a-b3ae-4c69-6581-08d7774df540
X-MS-TrafficTypeDiagnostic: BN7PR12MB2802:|BN7PR12MB2802:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2802D68148B7ED70E6D441AF82430@BN7PR12MB2802.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:16;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(189003)(199004)(81166006)(81156014)(86362001)(6486002)(9686003)(6506007)(2870700001)(478600001)(386003)(76176011)(5660300002)(51416003)(186003)(1076003)(52116002)(3846002)(6116002)(47776003)(2616005)(26005)(66946007)(66066001)(25786009)(316002)(446003)(11346002)(14454004)(66476007)(66556008)(48376002)(8676002)(50226002)(305945005)(6512007)(36756003)(2906002)(14444005)(99286004)(6666004)(7736002)(2351001)(54906003)(4326008)(2361001)(6916009)(6436002)(50466002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2802;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /1C+FgVVdTyoUO8bnhpSljWJcdb18Teoz/XafaSBcMM26JbnhRbFps+Ed4MTqxkUTnzt/m7TXtPprvcVWv9aaJqFV+qkYYh7g+Sru2fuJIQIGhHSm4dzEXUV/0Nlx6RJve68e/sFZNxlqCySfwuDLwM9jw/824X4Zd/kAdSFlZera0Bbp9hCirncRvfFeDYVObqJEhSHutDoe0emreo+caE3y5AyA2XgVdcbBa4bA0ESKTufZfs6DdU84EXSw2k0HqZR4jEXwIijyKJnHQHTgIWO5saJNFPeriBic8BybHxx6Tvk0biMTaADKpCfUO/ncR68y2VQMgwQD+FMvwB9GnVY6tgIvS3XlHCQT+u/vSZ8TAatAY83pBVCAk18Ioo5Sc3XVDVSbYVB97jAJOoi/eXiERh/WKgqd5Xm+Nd3sbYgKi74nPIT7fTwZ72zIDxh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc3395a-b3ae-4c69-6581-08d7774df540
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:35:01.0597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RgxkPVPxsLGX1vWbMdy7qvevWPOnRX4Et/rBtAa4dPWPD1/LoOoyBC1Nv/MeGthW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2802
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxdcSXbNc38V0vIM9G5qGAiHttmVWjROhZP/PKDnJuk=;
 b=l2lBFJEDrgxf2ChKFt4BOlMDCXPQkOvNgvYvcMOCci88z3cQ25kg8nx1yO2i5rkUFtVkth0NLQ2sVyx/EVpJaliYdS5bYe/TzL14B69uRhZjEsxBKvKb627LVeVG/v2lUQTK9jxuuRLhr27CsBHV6HPwul/tLcd5NcihqC/Z5mY=
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
Cc: David Galiffi <David.Galiffi@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Tony Cheng <Tony.Cheng@amd.com>, rodrigo.siqueira@amd.com,
 harry.wentland@amd.com, bhawanpreet.lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogRGF2aWQgR2FsaWZmaSA8RGF2aWQuR2FsaWZmaUBhbWQuY29tPgoKW1doeV0KSW4gZGNf
bGlua19pc19kcF9zaW5rX3ByZXNlbnQsIGlmIGRhbF9kZGNfb3BlbiBmYWlscywgdGhlbgpkYWxf
Z3Bpb19kZXN0cm95X2RkYyBpcyBjYWxsZWQsIGRlc3Ryb3lpbmcgcGluX2RhdGEgYW5kIHBpbl9j
bG9jay4gVGhleQphcmUgY3JlYXRlZCBvbmx5IG9uIGRjX2NvbnN0cnVjdCwgYW5kIG5leHQgYXV4
IGFjY2VzcyB3aWxsIGNhdXNlIGEgcGFuaWMuCgpbSG93XQpJbnN0ZWFkIG9mIGNhbGxpbmcgZGFs
X2dwaW9fZGVzdHJveV9kZGMsIGNhbGwgZGFsX2RkY19jbG9zZS4KClNpZ25lZC1vZmYtYnk6IERh
dmlkIEdhbGlmZmkgPERhdmlkLkdhbGlmZmlAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IFRvbnkgQ2hl
bmcgPFRvbnkuQ2hlbmdAYW1kLmNvbT4KQWNrZWQtYnk6IExlbyBMaSA8c3VucGVuZy5saUBhbWQu
Y29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYyB8
IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYwppbmRleCA0Njgx
Y2EyMGY2ODMuLmNlZjhjMWJhOTc5NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2NvcmUvZGNfbGluay5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9jb3JlL2RjX2xpbmsuYwpAQCAtMzcyLDcgKzM3Miw3IEBAIGJvb2wgZGNfbGlua19pc19k
cF9zaW5rX3ByZXNlbnQoc3RydWN0IGRjX2xpbmsgKmxpbmspCiAKIAlpZiAoR1BJT19SRVNVTFRf
T0sgIT0gZGFsX2RkY19vcGVuKAogCQlkZGMsIEdQSU9fTU9ERV9JTlBVVCwgR1BJT19ERENfQ09O
RklHX1RZUEVfTU9ERV9JMkMpKSB7Ci0JCWRhbF9ncGlvX2Rlc3Ryb3lfZGRjKCZkZGMpOworCQlk
YWxfZGRjX2Nsb3NlKGRkYyk7CiAKIAkJcmV0dXJuIHByZXNlbnQ7CiAJfQotLSAKMi4yNC4wCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
