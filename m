Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15009C432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9C4620848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C4620848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B3F36E290;
	Mon,  2 Dec 2019 17:35:05 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720044.outbound.protection.outlook.com [40.107.72.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 154D26E29D
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odFEbQVPg7TmZIqapyG24nnpHxBIHkA2/6DLQASsPW64VebTZu2FOo8QZIyMrueVQyM3f3WLeMQTKjAx+3/bgNR/bCMqHWm0ASQQOGj1cBrdTo+5Ndcq6ohOpbvGolzrQBVCiLy5pH58pBpou77jebZ6UwyXt9+78sLiFb8j9rdMgSdbWRqMsz1TjtdIeNVvWFiqV5TtQNY6hARFT09UUM70u+sRkOQjN2rqOh0grVMQoGLeQfYzA+nI5p3v0DDpm61EafkWs+YZH8rOqKfOn5UPEeNPeTRevLF0M/vKtutc3Z8MMKInE8rgPWT2RNh3b5gsDMYw0Fz6PkIU9iMJoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYjiYu25IVbPsXFt+ATq3CBV82IFRWI6dZWzsqtCsJo=;
 b=l3kmqVEFoW6srvcmHQttdYuiHIXPfrHWj2PdqtzQqYJcPim2giirEn0YDM3qDkBMjk6BN5B585rdAQtI6E9FqSjCibzSsbKpOJDg5/WpiUqFmu1ylaP9YIJlclLrfDFHIE/Cg9yBMkQV+JBX/YOnd9X4Spsm3gxRkGZEyCYt1BR7H17oU/rccaWwR8obey04qjx70oIKpnenDqGFOHmSzxaPyGp9DVRgSEhhV27oha3xndlZXLa5taHK3HKkfrqUjp03XYADvg3wsdZ6q5ZjdYUDrPE8kUjef4F23zxZ+ildxQBMApCUeV7R3Rcjhq+yLISeZtInKt5go7Al9Fsg6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2802.namprd12.prod.outlook.com (20.176.27.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:34:59 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:34:59 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/51] drm/amd/display: Return DMUB_STATUS_OK when autoload
 unsupported
Date: Mon,  2 Dec 2019 12:33:26 -0500
Message-Id: <20191202173405.31582-13-sunpeng.li@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 179f1698-e4fb-4267-a709-08d7774df3bd
X-MS-TrafficTypeDiagnostic: BN7PR12MB2802:|BN7PR12MB2802:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2802E348C18F591A30D0039F82430@BN7PR12MB2802.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
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
X-Microsoft-Antispam-Message-Info: f8zMTJWebDvaAVCJGrkvrPDfErOzjpho6AQPosU2js/ATbkW4zgHKgWnqOCkCi7vhMHNnx2oPvbSstrzg9vxuJC9jeSuo94eP+0Hu2hjl5ToBGrr4IK67VNytYkTZMxgpaodp5pZaAlyuw2ym0E1OFpiJaeXCvb1vS37UR8eJ5ndhpafKmYeeJ0nR6wEYrlMeDlJ1VaIzgv0qYozA5pueMhrFtAd6nvYgL+2Nh6/EpojQteRzKhhsPOSP+p+5AoLuFg0wZIhZGFbQF6TwbHEeti9Mrw/cIYtV8rBdlhMrsYWU8a8EU/pElHWykvlP4T+aRDMrP5djEoBX8HYmA90TSbt8IA/oU9v4QbwdNc/+bpaFYpaBD68gRzYh6o2uJdOJqfEXj/r8NMnWs6zMTCWI5H7P+4f2CrcnYkgQubUtQptZd0f++hmA4wjwH45dSPg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 179f1698-e4fb-4267-a709-08d7774df3bd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:34:58.4282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xve3GqEEKR/iGzwpMNNHgUt2T+YCLyJdG1Ow/4oP70AzKdCxPpo3Iix5ykziqiG+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2802
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYjiYu25IVbPsXFt+ATq3CBV82IFRWI6dZWzsqtCsJo=;
 b=csGp+/bddN+qKLRJu3D5XlHFDhIHq9kLkYm0OoB5fYNwhPmKngriJMZyK8WXsH0kXv4Uwcw1A0FKrlimTvnMgnAzL8iZqgOkaRcDQKhKtxBSrlXxrjQHoujuPxbHitfdei/KKBp/0a62PCforAUxoJH/lERVztOLY2GSf3H33Lc=
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
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogTmljaG9sYXMgS2F6bGF1c2thcyA8bmljaG9sYXMua2F6bGF1c2thc0BhbWQuY29tPgoK
W1doeV0KTm90IGhhdmluZyBzdXBwb3J0IGZvciBhdXRvbG9hZCBpc24ndCBhbiBlcnJvci4gSWYg
dGhlIERNVUIgZmlybXdhcmUKZG9lc24ndCBzdXBwb3J0IGl0IHRoZW4gZG9uJ3QgcmV0dXJuIERN
VUJfU1RBVFVTX0lOVkFMSUQuCgpbSG93XQpSZXR1cm4gRE1VQl9TVEFUVVNfT0sgd2hlbiAtPmlz
X2F1dG9fbG9hZF9kb25lIGlzIE5VTEwuCgpTaWduZWQtb2ZmLWJ5OiBOaWNob2xhcyBLYXpsYXVz
a2FzIDxuaWNob2xhcy5rYXpsYXVza2FzQGFtZC5jb20+ClJldmlld2VkLWJ5OiBUb255IENoZW5n
IDxUb255LkNoZW5nQGFtZC5jb20+CkFja2VkLWJ5OiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNv
bT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZG11Yi9zcmMvZG11Yl9zcnYuYyB8
IDEwICsrKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvc3Jj
L2RtdWJfc3J2LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZG11Yi9zcmMvZG11Yl9z
cnYuYwppbmRleCAzZWMyNmY2YWYyZTEuLjcwYzdhNGJlOWNjYyAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvc3JjL2RtdWJfc3J2LmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvc3JjL2RtdWJfc3J2LmMKQEAgLTM3OSw5ICszNzksMTIg
QEAgZW51bSBkbXViX3N0YXR1cyBkbXViX3Nydl93YWl0X2Zvcl9hdXRvX2xvYWQoc3RydWN0IGRt
dWJfc3J2ICpkbXViLAogewogCXVpbnQzMl90IGk7CiAKLQlpZiAoIWRtdWItPmh3X2luaXQgfHwg
IWRtdWItPmh3X2Z1bmNzLmlzX2F1dG9fbG9hZF9kb25lKQorCWlmICghZG11Yi0+aHdfaW5pdCkK
IAkJcmV0dXJuIERNVUJfU1RBVFVTX0lOVkFMSUQ7CiAKKwlpZiAoIWRtdWItPmh3X2Z1bmNzLmlz
X2F1dG9fbG9hZF9kb25lKQorCQlyZXR1cm4gRE1VQl9TVEFUVVNfT0s7CisKIAlmb3IgKGkgPSAw
OyBpIDw9IHRpbWVvdXRfdXM7IGkgKz0gMTAwKSB7CiAJCWlmIChkbXViLT5od19mdW5jcy5pc19h
dXRvX2xvYWRfZG9uZShkbXViKSkKIAkJCXJldHVybiBETVVCX1NUQVRVU19PSzsKQEAgLTM5Nyw5
ICs0MDAsMTIgQEAgZW51bSBkbXViX3N0YXR1cyBkbXViX3Nydl93YWl0X2Zvcl9waHlfaW5pdChz
dHJ1Y3QgZG11Yl9zcnYgKmRtdWIsCiB7CiAJdWludDMyX3QgaSA9IDA7CiAKLQlpZiAoIWRtdWIt
Pmh3X2luaXQgfHwgIWRtdWItPmh3X2Z1bmNzLmlzX3BoeV9pbml0KQorCWlmICghZG11Yi0+aHdf
aW5pdCkKIAkJcmV0dXJuIERNVUJfU1RBVFVTX0lOVkFMSUQ7CiAKKwlpZiAoIWRtdWItPmh3X2Z1
bmNzLmlzX3BoeV9pbml0KQorCQlyZXR1cm4gRE1VQl9TVEFUVVNfT0s7CisKIAlmb3IgKGkgPSAw
OyBpIDw9IHRpbWVvdXRfdXM7IGkgKz0gMTApIHsKIAkJaWYgKGRtdWItPmh3X2Z1bmNzLmlzX3Bo
eV9pbml0KGRtdWIpKQogCQkJcmV0dXJuIERNVUJfU1RBVFVTX09LOwotLSAKMi4yNC4wCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
