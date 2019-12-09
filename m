Return-Path: <SRS0=Fyns=Z7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10DFC04E30
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2019 21:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE299206D5
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2019 21:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE299206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 826EB6E53C;
	Mon,  9 Dec 2019 21:11:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F41AF6E52F
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Dec 2019 21:11:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUww/qUouANZbBEyts0d53VTwuw5F77FTi7o3mMdh7w9xJhj+Q34JCwIJM5Zs0dWM6EoRdTbhTLruDAIPl/F0y1CxbeHysvppLKOeQ3jgVSNI9BMYZRnUypdEYr0CNBJ6dbgW+iDiPA/tCZ9duhOgIFTnN6tSddJ9nA58aN0G5AzIRBuNeCopFoXcYLAkYRexAljxVMgt/1AfasVn54s4eyBKbRRbRcVlbSfrpY75fzah1ul7I0g54tjttPjq512UCbpP9BFipHbaI2g8BGmj88O7zBAC53YXa/LqkM38MLPAxlGJHKOjHJtO45CeuQJQG9GL0/iKxfcIIEZfO7aww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJ5Y/Q/KuLCdj15dxMM62ySwlWYH0hwfwuyEozOhrTQ=;
 b=CfV8STZIYQYWRgJO0PVRooY3YwbUIwcHacsjS9lkYcpeItpBO37DgvtD3xme9yD8mE0gEfLBTtNLM7QfP1dtYDGVpeCuw3+at1VgpG2aUqQXCqDUqmlTiM8WHAhJUIZvkw9Gq+hPQwE5EAYanZHHnBFq03Ntsv1cp9ASR7Ef+k+/lZDhXCp2E6wope2B+2JVTl9WN1piUXXt+sithQ1rCgL6j3bx1hHnsANU8EPPoswQW0Vqzwk5lMAdrfJkj9mVJGk+rKrRi315vwZfFDX7CkIYYJg1m1e1ROjPnre5FMMWQN7z8/U2Ln56eqzoD3kGEa0HDgHK3+r6unVX8yW+Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB1754.namprd12.prod.outlook.com (10.175.89.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Mon, 9 Dec 2019 21:11:10 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::5c07:10f2:d913:b03f]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::5c07:10f2:d913:b03f%3]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 21:11:10 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: fix VCN2.x number of irq types
Date: Mon,  9 Dec 2019 16:10:47 -0500
Message-Id: <20191209211048.6937-1-leo.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::28) To DM5PR12MB2456.namprd12.prod.outlook.com
 (2603:10b6:4:b4::37)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 69e92a4a-8c8d-4715-1ff8-08d77cec5087
X-MS-TrafficTypeDiagnostic: DM5PR12MB1754:|DM5PR12MB1754:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1754E0CB837F993A59A14208E5580@DM5PR12MB1754.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 02462830BE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(189003)(199004)(305945005)(52116002)(186003)(26005)(44832011)(2616005)(36756003)(6506007)(6916009)(2906002)(498600001)(66946007)(6512007)(8676002)(81166006)(6666004)(66556008)(5660300002)(81156014)(1076003)(66476007)(8936002)(4326008)(6486002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1754;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CtFY51AIwfaP/VLbP5VXE8igtr3V5fV9visNLyMA9Zo9jKOtrd681cJdob77N50kwr/P3b7TYw74ptvprLdLg1NnoglBYZlJovnciV7p7U9QVoHL4wQW1s2oiAWar4Qq1n7L1+XmeMQR10CCcoU/6P17/vKoD9XU8Im2oyjDFdKyRADNyhHe5ZwZ6xustDwAdQRdw59h4wKcGgIuJtAzmAGM3uFev+/P0gFJfscP5ytXN0uQP4nCdJwlA2rCLXHGNWCKneSluRXYM6spFxqgZfhTyivK1vlk8VDYsP3f+eNMY3PN0kP6VTFg5S1OSAhETxg7eLaaSrDFkYtYiJNpod05GwRSUdFB1phHkLBDxlYTYQl0DaRQfvglq7ztrfzD/BhMh7n1uKaXQ2Ed8WXV/2NuCr2vL9ejddX7lbPxEFNWmAJsrhGu3+kfB7iTo3g9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e92a4a-8c8d-4715-1ff8-08d77cec5087
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2019 21:11:10.3112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCis759trKIgiDU2HKwwyZA1HwFuuPv+yu5K7yGT/AJNuolKk6ZlRiAgg0mC8Buo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1754
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJ5Y/Q/KuLCdj15dxMM62ySwlWYH0hwfwuyEozOhrTQ=;
 b=VWpCmicqr3X34udUnsHIX88Jr7HfaUwViEtUZ3IqQbmF2CtUje/3vrmSrvFmB68RHApuUYVTfBMZ2NPXTtKAmBTRSREKf/OKK1kTrSx8edk68lzKonWWlMJ9oyaYUWMHt/8mBbxbigqaOfnxVVfM90YgPBvflc6y7ojlSAw0p5E=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
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
Cc: Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhlIEpQRUcgaXJxIHR5cGUgaGFzIGJlZW4gbW92ZWQgdG8gaXRzIG93biBzdHJ1Y3R1cmUKClNp
Z25lZC1vZmYtYnk6IExlbyBMaXUgPGxlby5saXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS92Y25fdjJfMC5jIHwgMiArLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvdmNuX3YyXzUuYyB8IDIgKy0KIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zj
bl92Ml8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjJfMC5jCmluZGV4IDU2
NDkxOTBjYjYyOS4uZDc2ZWNlMzhjOTdiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS92Y25fdjJfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92
Ml8wLmMKQEAgLTE3ODgsNyArMTc4OCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X2ly
cV9zcmNfZnVuY3MgdmNuX3YyXzBfaXJxX2Z1bmNzID0gewogCiBzdGF0aWMgdm9pZCB2Y25fdjJf
MF9zZXRfaXJxX2Z1bmNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogewotCWFkZXYtPnZj
bi5pbnN0LT5pcnEubnVtX3R5cGVzID0gYWRldi0+dmNuLm51bV9lbmNfcmluZ3MgKyAyOworCWFk
ZXYtPnZjbi5pbnN0LT5pcnEubnVtX3R5cGVzID0gYWRldi0+dmNuLm51bV9lbmNfcmluZ3MgKyAx
OwogCWFkZXYtPnZjbi5pbnN0LT5pcnEuZnVuY3MgPSAmdmNuX3YyXzBfaXJxX2Z1bmNzOwogfQog
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjJfNS5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YyXzUuYwppbmRleCA0MmQ2YjlmMDU1M2IuLmY2
N2ZjYTM4YzFhOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3Yy
XzUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjJfNS5jCkBAIC0xMTM4
LDcgKzExMzgsNyBAQCBzdGF0aWMgdm9pZCB2Y25fdjJfNV9zZXRfaXJxX2Z1bmNzKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQogCWZvciAoaSA9IDA7IGkgPCBhZGV2LT52Y24ubnVtX3Zjbl9p
bnN0OyArK2kpIHsKIAkJaWYgKGFkZXYtPnZjbi5oYXJ2ZXN0X2NvbmZpZyAmICgxIDw8IGkpKQog
CQkJY29udGludWU7Ci0JCWFkZXYtPnZjbi5pbnN0W2ldLmlycS5udW1fdHlwZXMgPSBhZGV2LT52
Y24ubnVtX2VuY19yaW5ncyArIDI7CisJCWFkZXYtPnZjbi5pbnN0W2ldLmlycS5udW1fdHlwZXMg
PSBhZGV2LT52Y24ubnVtX2VuY19yaW5ncyArIDE7CiAJCWFkZXYtPnZjbi5pbnN0W2ldLmlycS5m
dW5jcyA9ICZ2Y25fdjJfNV9pcnFfZnVuY3M7CiAJfQogfQotLSAKMi4xNy4xCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
