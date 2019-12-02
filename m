Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345ADC432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1540420848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1540420848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F00906E2CD;
	Mon,  2 Dec 2019 17:35:55 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720041.outbound.protection.outlook.com [40.107.72.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A650F6E28A
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyEY7rIOuQsHRcC4JvxxZsC7yD7IZ2jRQow/3pPhSSpcZQ9vsMhOCEbfNJy/WSulMPa0kmTOSu/kMtegOY/Cz1wFpII8OE5YaeTA+4awKr902Fftk38XKnazrBVycdQ9pQ6cjhdJ74MP3TaXtczGbr9V4C/Gn3vHgBUMijFzc5/7Y509GUVMKWOQVTah2rG+XIORi57+ACtr07FKlpFvXbPb6r534Srg2a0ek+JfRUhmezq1L9cUzf5FljH8dgGvCi8m99oThky2jgqQUZYY0XcKSU5xAz2L8HXdG0U28CgaurKcgWuDQGb8QASdT3zG/yZZ1OqwyW8bBHB2SNNyBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otdzTf1wczuKZSkYO9aI/MBouTD1j3Q8D2IQ+0yLFIc=;
 b=KdoWXs9zdZISZqBNOvkWlgbxRgHyvXBElPfMJKmuNxIFt2/RpJX5qO499rntUtEYEQ0G1vKA+JPmRo4pBT025OYWv324Vo6eEVMscVTqdLkHfGT/nn1l8/mh6GHsQqa8ShAz6wtnKZd47YuAADMtt2VkGuUQWc/mbLjvNkLN5HfyT8YGxsGUEY0hEwOelm23LLsqxaz0O2hQULI5ISdgrBqJujB6aA3Tn+uTcsbYUXVyj7VCXLKX8KcuBph6HVTLAd8bVVP+M9zFIEpSwq64UCdwFEfihsMJOd4XBq+DsKxV64UPx4fCxUSm237WMoFR78L9gBNeoaEFe42A44TliQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2802.namprd12.prod.outlook.com (20.176.27.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:35:51 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:35:51 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 40/51] drm/amd/display: Limit NV12 chroma workaround
Date: Mon,  2 Dec 2019 12:33:54 -0500
Message-Id: <20191202173405.31582-41-sunpeng.li@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 130d15c9-456b-4779-94bd-08d7774e02de
X-MS-TrafficTypeDiagnostic: BN7PR12MB2802:|BN7PR12MB2802:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB28027731C7EC5D546022BFE182430@BN7PR12MB2802.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(189003)(199004)(81166006)(81156014)(86362001)(6486002)(9686003)(6506007)(2870700001)(478600001)(386003)(76176011)(5660300002)(51416003)(186003)(1076003)(52116002)(3846002)(6116002)(47776003)(2616005)(26005)(66946007)(66066001)(25786009)(316002)(446003)(11346002)(14454004)(66476007)(66556008)(48376002)(8676002)(50226002)(305945005)(6512007)(36756003)(2906002)(14444005)(99286004)(7736002)(2351001)(54906003)(4326008)(2361001)(6916009)(6436002)(50466002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2802;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y+L6HFICG/vx0DmabDZVpJqQtLlmg9KLOjpM4KAuoNtxFIJ9B3Ct0TpCudPacwxDANjdA4gIm6l2RQI4anDZAHjNUQ15XEIWtCH/5jFbkae7rU+mVw0hEeqdkg8Vsks8b5i+kDvb2BT5SLJrTinnb3dISw7FaJVv1kz7nPUwlHCmYJ2PFxvGbEr7imkHkI7ChgkJxPBPN2N5w/6kKbunyahTi3eimmVKo8AOUvMaa5TIePs8n5AJjwHHmJEzTNiF1PpA1cY+r1QIUraOBs6bv0ZDvgtpILyvQqVnLG2OBOsmsuCz7hM2mHd4bZiHtQZCzBWq6HArrXMnFyMHW+SSjnQxFb7XVIfl5NPgBXPHs1FT0CTRtdOCKN6L9AKut3jQ/5UCOqTiUTKB4bPYI8CVvZu30e476FTC2W/KOwg8wBsWFOtIzx9n/Mr7h5JIe85b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 130d15c9-456b-4779-94bd-08d7774e02de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:35:23.8498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ni2/e2LGtJheVy04fSF3t5LBqFsc1GbeiF8eRgwST3M8tEfv//Uamx/kF1tdq2sA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2802
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otdzTf1wczuKZSkYO9aI/MBouTD1j3Q8D2IQ+0yLFIc=;
 b=lRHG9jY6add9biILu/NpDSgviqyILdyHp9ect82bYSsW2V0ePdkPa1s2UvudcmmltQenWvxO0NM4q54a7PL06MgGxcmuUfZTr3MF9fDn6B4Q4rSAfDX83FxlrATlQKVo+JkKUlToccOfZvH4o2ZZH7DIV3n9qaot0tpLPUEPU8w=
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
Cc: Leo Li <sunpeng.li@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 rodrigo.siqueira@amd.com, harry.wentland@amd.com, bhawanpreet.lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogQW50aG9ueSBLb28gPEFudGhvbnkuS29vQGFtZC5jb20+CgpbV2h5XQpJdCBpcyBjYXVz
aW5nIGdyZWVuIExpbmUgYXQgdGhlIGJvdHRvbSBvZiBTRFIgNDgwcApNUE8gcGxheWJhY2sKCltI
b3ddCkxpbWl0IHdvcmthcm91bmQgdG8gdmVydGljYWwgPiA1MTIKClNpZ25lZC1vZmYtYnk6IEFu
dGhvbnkgS29vIDxBbnRob255Lktvb0BhbWQuY29tPgpSZXZpZXdlZC1ieTogVG9ueSBDaGVuZyA8
VG9ueS5DaGVuZ0BhbWQuY29tPgpBY2tlZC1ieTogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+
Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX2h1YnAuYyB8
IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMS9kY24yMV9odWJw
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfaHVicC5jCmlu
ZGV4IDM4NjYxYjljNjFmOC4uMzMyYmYzZDNhNjY0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfaHVicC5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9kY24yMS9kY24yMV9odWJwLmMKQEAgLTIwMCw3ICsyMDAsNyBAQCB2
b2lkIGh1YnAyMV9zZXRfdmlld3BvcnQoCiAJICoJRGlzYWJsZSB3L2Egd2hlbiByb3RhdGVkIDE4
MCBkZWdyZWVzLCBjYXVzZXMgdmVydGljYWwgY2hyb21hIG9mZnNldAogCSAqLwogCXBhdGNoZWRf
dmlld3BvcnRfaGVpZ2h0ID0gdmlld3BvcnRfYy0+aGVpZ2h0OwotCWlmICh2aWV3cG9ydF9jLT5o
ZWlnaHQgIT0gMCAmJiBkZWJ1Zy0+bnYxMl9pZmxpcF92bV93YSAmJgorCWlmIChkZWJ1Zy0+bnYx
Ml9pZmxpcF92bV93YSAmJiB2aWV3cG9ydF9jLT5oZWlnaHQgPiA1MTIgJiYKIAkJCXJvdGF0aW9u
ICE9IFJPVEFUSU9OX0FOR0xFXzE4MCkgewogCQlpbnQgcHRlX3Jvd19oZWlnaHQgPSAwOwogCQlp
bnQgcHRlX3Jvd3MgPSAwOwotLSAKMi4yNC4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZng=
