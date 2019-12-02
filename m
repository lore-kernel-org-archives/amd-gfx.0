Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F036C432C3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D40E20848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D40E20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A903A6E29D;
	Mon,  2 Dec 2019 17:35:04 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720044.outbound.protection.outlook.com [40.107.72.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B41EA6E290
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiUZKejc18Wm0MvB//OX8OUBSHSBlAk3dAsYdphPcqOU4ydY5pQrJzethr/kiJGcpXuSzopihcLGW4T6NCgHUKjPZgiDy1hqNcNwK14FnJ0XwBfW+0UgdYSaJk0zGQrn808tcTobVWHpxMuaxZWQW463eK15GfmvljZBIHTK6xXyYxA0DMGuH5Z+42QlWFvXaXvIRIXKih++bONryHIkpHCUpz+TP4qpVJebQT+HGYbuRLfpqLAx6zrdYwB//r0PKbf3k43ZUC9ScKH41BWYGS0Lbeq7kMgVB/Uz9I8Ob7pKXZjBp5iE8pSSXKa5v5E7D5BSkk0RRPtX/Vjz/MQ2yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKotybLWYTb6XMNTlMx8xwmAltKvZqtJ+bDw+AUzE5g=;
 b=mMe3LbzUF08J5++GzLTm0KeuPHqroYZino8KpQ9qNavcSr1NMjqjlKaXNdiNzmsR7kOXmtxRDFsGV7WaiTvp+2JSqAnlZWsnnK69+DWyMDqgSMpnoeauZTlQodCztIVdhbelIuZaJWX0wVDhzMa6GJY2IA2vduLEZBET9BsnSIznJD2Ssd0UuXy4f8XnDIT03Mco8X6HyD6hjTSVi7f5gswQ+NR7EzdlP4Nf8J3axdDQLPTCmGTOxftpvZOjT8mr7qZHWtd481tA7/GGCWC7XhKgz6Wg0BTwBjX40ew8QdjiN1UdaeFEzsRo61JKShBFeYKfQHqv8K1MhjgIrLDglQ==
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
Subject: [PATCH 11/51] drm/amd/display: Only wait for DMUB phy init on dcn21
Date: Mon,  2 Dec 2019 12:33:25 -0500
Message-Id: <20191202173405.31582-12-sunpeng.li@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f248eb2f-c10a-40c3-f9ea-08d7774df338
X-MS-TrafficTypeDiagnostic: BN7PR12MB2802:|BN7PR12MB2802:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB28021D79C632032B30CCED2082430@BN7PR12MB2802.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
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
X-Microsoft-Antispam-Message-Info: XLhwOPDbWQpOGh4PzuGESiZrf1aK/eYsNFGY2h1+MXGPYb6DqG1LMJe8a7Sz1++ccjQDhFMGJ1UuKDSd1aEWjVA+KxqYd3fFyuVUUafVPDo0CpAf1D1KoMofaMingbeNvEdOHiOsUh4jRX+Y1dqwnnQFMV/pKzaHDHmmTQO3PKzqv+LiFPx7JYe3zhJ768/U9y7OMuEzYelUvkmbKhUJ2nVDRQBCnZPEKXmzNv029BnVpe0NgrqbNjjJkXok6d7fpWY2bMbP9MbF44edGeM9cPKg0b7zxvcs4FLj54+QK1W1QfCmbFO5mPYOubMPFFPXyqubDP/RQCJXhErSPU+P1/4F/AFcyw6tc324XaHzToz1bs7iBAQwwyp5SawU+Wa81mSC6nzd3GoAXMDfofrkuGiv76ZXWqILPo/5SyFZxwOMTTlIEssvlpcNn70Rmulz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f248eb2f-c10a-40c3-f9ea-08d7774df338
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:34:57.5597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yd87sflDAgBAogg74w/sgBuIASOBj4i8pJMjqjqBZ9tfzcr1eRhhqTkUQyhD37Al
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2802
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKotybLWYTb6XMNTlMx8xwmAltKvZqtJ+bDw+AUzE5g=;
 b=lT6WkZbDgnYKHJDrtIoLvX6DLylFv40dVJgLcHd48jJGOwhjImP0Jz1qt1DgY9OdY+rGIFTmjE7yst8IiG1JQdC0MKF9UdMT1x/7xVIgY/XW+lMxpk6NwXwKN8SM4RaahMj3jE2dTMCpk8YACwMGxN3i8d8bcQpr7lFk00Kewpo=
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
W1doeV0KVGhlIHdhaXQgZm9yIFBIWSBpbml0IHdvbid0IGZpbmlzaCBpZiB0aGUgZmlybXdhcmUg
ZG9lc24ndCBzdXBwb3J0IGl0LgoKW0hvd10KT25seSBob29rIHRoaXMgZnVuY3Rpb25hbGl0eSB1
cCBvbiBEQ04yMSBhbmQgbW92ZSBpdCBvdXQgb2YgRENOMjAuCgpGb3IgQVNJQyB3aXRob3V0IHN1
cHBvcnQgdGhlbiB0aGlzIHNob3VsZCByZXR1cm4gT0sgc28gd2UgZG9uJ3QgaGFuZwp3aGlsZSB3
YWl0aW5nIGluIERDLgoKU2lnbmVkLW9mZi1ieTogTmljaG9sYXMgS2F6bGF1c2thcyA8bmljaG9s
YXMua2F6bGF1c2thc0BhbWQuY29tPgpSZXZpZXdlZC1ieTogVG9ueSBDaGVuZyA8VG9ueS5DaGVu
Z0BhbWQuY29tPgpBY2tlZC1ieTogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+Ci0tLQogZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvc3JjL2RtdWJfZGNuMjAuYyB8IDUgLS0tLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kbXViL3NyYy9kbXViX2RjbjIwLmggfCAyIC0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZG11Yi9zcmMvZG11Yl9kY24yMS5jIHwgNSAr
KysrKwogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvc3JjL2RtdWJfZGNuMjEuaCB8
IDIgKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kbXViL3NyYy9kbXViX3Nydi5jICAg
fCAyICstCiA1IGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZG11Yi9zcmMvZG11Yl9k
Y24yMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvc3JjL2RtdWJfZGNuMjAu
YwppbmRleCBlMmIyY2YyZTAxZmQuLjZiN2Q1NDU3MmFhMyAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvc3JjL2RtdWJfZGNuMjAuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZG11Yi9zcmMvZG11Yl9kY24yMC5jCkBAIC0xMzUsOCArMTM1LDMg
QEAgYm9vbCBkbXViX2RjbjIwX2lzX3N1cHBvcnRlZChzdHJ1Y3QgZG11Yl9zcnYgKmRtdWIpCiAK
IAlyZXR1cm4gc3VwcG9ydGVkOwogfQotCi1ib29sIGRtdWJfZGNuMjBfaXNfcGh5X2luaXQoc3Ry
dWN0IGRtdWJfc3J2ICpkbXViKQotewotCXJldHVybiBSRUdfUkVBRChETUNVQl9TQ1JBVENIMTAp
ID09IDA7Ci19CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZG11Yi9z
cmMvZG11Yl9kY24yMC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvc3JjL2Rt
dWJfZGNuMjAuaAppbmRleCBlMWJhNzQ4Y2E1OTQuLmNhN2RiMDNiOTRmNyAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvc3JjL2RtdWJfZGNuMjAuaAorKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZG11Yi9zcmMvZG11Yl9kY24yMC5oCkBAIC01OSw2
ICs1OSw0IEBAIGJvb2wgZG11Yl9kY24yMF9pc19od19pbml0KHN0cnVjdCBkbXViX3NydiAqZG11
Yik7CiAKIGJvb2wgZG11Yl9kY24yMF9pc19zdXBwb3J0ZWQoc3RydWN0IGRtdWJfc3J2ICpkbXVi
KTsKIAotYm9vbCBkbXViX2RjbjIwX2lzX3BoeV9pbml0KHN0cnVjdCBkbXViX3NydiAqZG11Yik7
Ci0KICNlbmRpZiAvKiBfRE1VQl9EQ04yMF9IXyAqLwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RtdWIvc3JjL2RtdWJfZGNuMjEuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kbXViL3NyYy9kbXViX2RjbjIxLmMKaW5kZXggZDQwYTgwODExMmU3Li5iOWRj
MmRkNjQ1ZWIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kbXViL3Ny
Yy9kbXViX2RjbjIxLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvc3Jj
L2RtdWJfZGNuMjEuYwpAQCAtMTI0LDMgKzEyNCw4IEBAIGJvb2wgZG11Yl9kY24yMV9pc19hdXRv
X2xvYWRfZG9uZShzdHJ1Y3QgZG11Yl9zcnYgKmRtdWIpCiB7CiAJcmV0dXJuIChSRUdfUkVBRChE
TUNVQl9TQ1JBVENIMCkgPT0gMyk7CiB9CisKK2Jvb2wgZG11Yl9kY24yMV9pc19waHlfaW5pdChz
dHJ1Y3QgZG11Yl9zcnYgKmRtdWIpCit7CisJcmV0dXJuIFJFR19SRUFEKERNQ1VCX1NDUkFUQ0gx
MCkgPT0gMDsKK30KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kbXVi
L3NyYy9kbXViX2RjbjIxLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZG11Yi9zcmMv
ZG11Yl9kY24yMS5oCmluZGV4IGY1Nzk2OWQ4ZDU2Zi4uOWU1ZjE5NWUyODhmIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZG11Yi9zcmMvZG11Yl9kY24yMS5oCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kbXViL3NyYy9kbXViX2RjbjIxLmgKQEAgLTQy
LDQgKzQyLDYgQEAgdm9pZCBkbXViX2RjbjIxX3NldHVwX3dpbmRvd3Moc3RydWN0IGRtdWJfc3J2
ICpkbXViLAogCiBib29sIGRtdWJfZGNuMjFfaXNfYXV0b19sb2FkX2RvbmUoc3RydWN0IGRtdWJf
c3J2ICpkbXViKTsKIAorYm9vbCBkbXViX2RjbjIxX2lzX3BoeV9pbml0KHN0cnVjdCBkbXViX3Ny
diAqZG11Yik7CisKICNlbmRpZiAvKiBfRE1VQl9EQ04yMV9IXyAqLwpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvc3JjL2RtdWJfc3J2LmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZG11Yi9zcmMvZG11Yl9zcnYuYwppbmRleCA2MGM1NzRhMzljNmEu
LjNlYzI2ZjZhZjJlMSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rt
dWIvc3JjL2RtdWJfc3J2LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIv
c3JjL2RtdWJfc3J2LmMKQEAgLTc2LDEzICs3NiwxMyBAQCBzdGF0aWMgYm9vbCBkbXViX3Nydl9o
d19zZXR1cChzdHJ1Y3QgZG11Yl9zcnYgKmRtdWIsIGVudW0gZG11Yl9hc2ljIGFzaWMpCiAJCWZ1
bmNzLT5nZXRfaW5ib3gxX3JwdHIgPSBkbXViX2RjbjIwX2dldF9pbmJveDFfcnB0cjsKIAkJZnVu
Y3MtPnNldF9pbmJveDFfd3B0ciA9IGRtdWJfZGNuMjBfc2V0X2luYm94MV93cHRyOwogCQlmdW5j
cy0+aXNfc3VwcG9ydGVkID0gZG11Yl9kY24yMF9pc19zdXBwb3J0ZWQ7Ci0JCWZ1bmNzLT5pc19w
aHlfaW5pdCA9IGRtdWJfZGNuMjBfaXNfcGh5X2luaXQ7CiAJCWZ1bmNzLT5pc19od19pbml0ID0g
ZG11Yl9kY24yMF9pc19od19pbml0OwogCiAJCWlmIChhc2ljID09IERNVUJfQVNJQ19EQ04yMSkg
ewogCQkJZnVuY3MtPmJhY2tkb29yX2xvYWQgPSBkbXViX2RjbjIxX2JhY2tkb29yX2xvYWQ7CiAJ
CQlmdW5jcy0+c2V0dXBfd2luZG93cyA9IGRtdWJfZGNuMjFfc2V0dXBfd2luZG93czsKIAkJCWZ1
bmNzLT5pc19hdXRvX2xvYWRfZG9uZSA9IGRtdWJfZGNuMjFfaXNfYXV0b19sb2FkX2RvbmU7CisJ
CQlmdW5jcy0+aXNfcGh5X2luaXQgPSBkbXViX2RjbjIxX2lzX3BoeV9pbml0OwogCQl9CiAJCWJy
ZWFrOwogCi0tIAoyLjI0LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eA==
