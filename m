Return-Path: <SRS0=U5eA=Y5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628F7C49EAD
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 09:34:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36AEC214D8
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2019 09:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36AEC214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 052436E95F;
	Tue,  5 Nov 2019 09:34:28 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760084.outbound.protection.outlook.com [40.107.76.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 745266E95F
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2019 09:34:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKXC2Gu8K3y+z5+MGkKmP5Durd9C31ed1agxc4Dus6dWoAdIn3GWZtOT4ybOwdycRm/G77OSvpa4a3Lcc6lws7yQsrDJJHe3ygP85zoKYQxqSrMa45BTH6FsqMjExqkB+Guwh7fW+Oo67GRIe5+E37Xf5KTpTrmxhaefL225VlZKKWxq0GdFqafpy3GvHKj8bkvzHy/yjEaLrzTVQ3kpGeUo+QxTZFdvHpOiHLe8aWmhEnbNSqvmSKIFKZ6zotfeuZnML4P4t2ZajRRA90kLUbuSkzLYZw04yLsiK5ue1uY6y9sJIHTqSOSoU3Fn+Aa7QFdvv065EjKTZwm0i0L8iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIDftNuVWXYIr5A3O/hM2SaPOQVjZqbapmov1LvxEJs=;
 b=Ex9LeYg7S6JQI4yhI8jDyZZsAvbNflkQuoZ+6AzkvGG8mV65taTHyxVc+EoyBZSCGMfXteO7MmgOUJciNPU0xLBRT3r3ZMyCie1AOVPwajc3wRp+o36H7Xp1qpuLzW42ZRMmgPAqyFcA78GAwKKnWIrp45aMwbFdzZSqIuQrjR5uyoHzgXkKJ0gvU26gBryUiJYBqReJgp68BU3YjxGYBHWyYgIkV1uSz2deE6ZHeLNW6+pc4x3Wv3105eQNZUJl7QOYz2E2EBMhKZqQxzvFfsDuoX4ZTNL5lW21sOGm/pvdIqOeLwLmRmAOl5pQ1P1qFuRyRlFB7A22APqkbatcGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB2863.namprd12.prod.outlook.com (20.179.82.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 09:34:25 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 09:34:25 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: support getting pcie_replay_count on Navi
Thread-Topic: [PATCH] drm/amdgpu: support getting pcie_replay_count on Navi
Thread-Index: AQHVk7w2JVtw2+Ei8U6QU+xewFBUVA==
Date: Tue, 5 Nov 2019 09:34:25 +0000
Message-ID: <20191105093405.13691-1-evan.quan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2P15301CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::15) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9dc94fb0-03d7-4a19-6ff4-08d761d358df
x-ms-traffictypediagnostic: MN2PR12MB2863:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB2863EC8F7DA965A9CDD6D8FBE47E0@MN2PR12MB2863.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(189003)(199004)(6436002)(7736002)(71200400001)(6486002)(71190400001)(1076003)(478600001)(316002)(36756003)(99286004)(2351001)(54906003)(26005)(81166006)(81156014)(50226002)(305945005)(6116002)(2906002)(3846002)(66556008)(6916009)(6512007)(5640700003)(66066001)(66946007)(476003)(6506007)(2501003)(66476007)(8676002)(66446008)(8936002)(64756008)(186003)(5660300002)(256004)(86362001)(386003)(14444005)(14454004)(102836004)(52116002)(25786009)(486006)(4326008)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2863;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lPg8gHFP+FXVeiE5AnzUiwGDCl9f6shKMnKubdgWzjEvRZ+ui+k4yGxWdoeTxhd11MynB1rkpHFBeaRDGAsOdN3IVI+xWU9CM0dW6/B2nFqtgCsOvcCcAJ5RbBwuLdM2Ma60RYC1Kf/HkkRi47Xrd55tT1IbiIie5PdbGeSt62EgtJFNmx//SrpAAmJeLwZHCGYwfgubQDVJYFIjeLApQLP7tPX33016vRyVRtPBUAPDa3z/xC1CJTVKXQPVIkfnQW6cX9jdmRdGq1i/f2zLukiA5Hs58aKF+gzZ5AlQ2p6k6vlO98sEFFD7F7oR9ptHAMIuNUKS3zthgkiqUfPN8FkQjmqJ9tjHUMRTY5pkHOPwtdWLLOWgez62hKPcTraObc8WibpLKNZQ2xRDRG8yWMgx8auH2n56IDyv5IEx65jhwWPgxA1sqWGPze8j6ANQ
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc94fb0-03d7-4a19-6ff4-08d761d358df
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 09:34:25.7653 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YYdXVFX4ptETPnMOqtSGGIRzoWAqRTt7Dbg9jP14pgWnWRKUCfuXhyzRK3ufdgkr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2863
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIDftNuVWXYIr5A3O/hM2SaPOQVjZqbapmov1LvxEJs=;
 b=ooVqIf8mU7s/mxsZQzHAwstoVulcUzDeHIMw4fos7YA4twICeMKWn5k8ToJU9vbcD9hKor++a1WrUMMka2Or+7Arzo1ZtussEwBZGa11QtnwQzi2c/6F0S8PqG6BEB48DEWUwvhQZ/2PINVD4EVpCP2RdyKLFtUEDChGFa+pXBw=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
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
Cc: "Li, Candice" <Candice.Li@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191105093425.1kzBPfWQ_70Y2RomGTV0Zq2hgaJVj4Rte0kVEIw73wk@z>

RW5hYmxlIHBjaWVfcmVwbGF5X2NvdW50IGludGVyZmFjZSBzdXBwb3J0IG9uIE5hdmkuCgpDaGFu
Z2UtSWQ6IElkYzc3MDY2MzQxNmVjZjQ1YWFiOGNhYTE5ZGU5Y2M5OWI2MTlkMmMzClNpZ25lZC1v
ZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvbnYuYyAgICAgICAgICAgICAgIHwgMTQgKysrKysrKysrKwogLi4uL2FtZC9p
bmNsdWRlL2FzaWNfcmVnL25iaW8vbmJpb18yXzNfc21uLmggIHwgMjggKysrKysrKysrKysrKysr
KysrKwogMiBmaWxlcyBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2
NDQgZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FzaWNfcmVnL25iaW8vbmJpb18yXzNfc21u
LmgKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYwppbmRleCA4OGUzNjY1ZjdiMDkuLmM4N2UwMWE3MzZm
MiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jCkBAIC0zOSw2ICszOSw3IEBACiAjaW5jbHVkZSAi
Z2MvZ2NfMTBfMV8wX3NoX21hc2suaCIKICNpbmNsdWRlICJoZHAvaGRwXzVfMF8wX29mZnNldC5o
IgogI2luY2x1ZGUgImhkcC9oZHBfNV8wXzBfc2hfbWFzay5oIgorI2luY2x1ZGUgIm5iaW8vbmJp
b18yXzNfc21uLmgiCiAKICNpbmNsdWRlICJzb2MxNS5oIgogI2luY2x1ZGUgInNvYzE1X2NvbW1v
bi5oIgpAQCAtNTY3LDYgKzU2OCwxOCBAQCBzdGF0aWMgdm9pZCBudl9pbml0X2Rvb3JiZWxsX2lu
ZGV4KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCWFkZXYtPmRvb3JiZWxsX2luZGV4LnNk
bWFfZG9vcmJlbGxfcmFuZ2UgPSAyMDsKIH0KIAorc3RhdGljIHVpbnQ2NF90IG52X2dldF9wY2ll
X3JlcGxheV9jb3VudChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKK3sKKwl1aW50NjRfdCBu
YWtfciwgbmFrX2c7CisKKwkvKiBHZXQgdGhlIG51bWJlciBvZiBOQUtzIHJlY2VpdmVkIGFuZCBn
ZW5lcmF0ZWQgKi8KKwluYWtfciA9IFJSRUczMl9QQ0lFKHNtblBDSUVfUlhfTlVNX05BSyk7CisJ
bmFrX2cgPSBSUkVHMzJfUENJRShzbW5QQ0lFX1JYX05VTV9OQUtfR0VORVJBVEVEKTsKKworCS8q
IEFkZCB0aGUgdG90YWwgbnVtYmVyIG9mIE5BS3MsIGkuZSB0aGUgbnVtYmVyIG9mIHJlcGxheXMg
Ki8KKwlyZXR1cm4gKG5ha19yICsgbmFrX2cpOworfQorCiBzdGF0aWMgY29uc3Qgc3RydWN0IGFt
ZGdwdV9hc2ljX2Z1bmNzIG52X2FzaWNfZnVuY3MgPQogewogCS5yZWFkX2Rpc2FibGVkX2Jpb3Mg
PSAmbnZfcmVhZF9kaXNhYmxlZF9iaW9zLApAQCAtNTg1LDYgKzU5OCw3IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgYW1kZ3B1X2FzaWNfZnVuY3MgbnZfYXNpY19mdW5jcyA9CiAJLm5lZWRfZnVsbF9y
ZXNldCA9ICZudl9uZWVkX2Z1bGxfcmVzZXQsCiAJLmdldF9wY2llX3VzYWdlID0gJm52X2dldF9w
Y2llX3VzYWdlLAogCS5uZWVkX3Jlc2V0X29uX2luaXQgPSAmbnZfbmVlZF9yZXNldF9vbl9pbml0
LAorCS5nZXRfcGNpZV9yZXBsYXlfY291bnQgPSAmbnZfZ2V0X3BjaWVfcmVwbGF5X2NvdW50LAog
fTsKIAogc3RhdGljIGludCBudl9jb21tb25fZWFybHlfaW5pdCh2b2lkICpoYW5kbGUpCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYXNpY19yZWcvbmJpby9uYmlvXzJf
M19zbW4uaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9hc2ljX3JlZy9uYmlvL25iaW9f
Ml8zX3Ntbi5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uYTQwYmE5
OGNjOGJiCi0tLSAvZGV2L251bGwKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2Fz
aWNfcmVnL25iaW8vbmJpb18yXzNfc21uLmgKQEAgLTAsMCArMSwyOCBAQAorLyoKKyAqIENvcHly
aWdodCAoQykgMjAxOSAgQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLgorICoKKyAqIFBlcm1p
c3Npb24gaXMgaGVyZWJ5IGdyYW50ZWQsIGZyZWUgb2YgY2hhcmdlLCB0byBhbnkgcGVyc29uIG9i
dGFpbmluZyBhCisgKiBjb3B5IG9mIHRoaXMgc29mdHdhcmUgYW5kIGFzc29jaWF0ZWQgZG9jdW1l
bnRhdGlvbiBmaWxlcyAodGhlICJTb2Z0d2FyZSIpLAorICogdG8gZGVhbCBpbiB0aGUgU29mdHdh
cmUgd2l0aG91dCByZXN0cmljdGlvbiwgaW5jbHVkaW5nIHdpdGhvdXQgbGltaXRhdGlvbgorICog
dGhlIHJpZ2h0cyB0byB1c2UsIGNvcHksIG1vZGlmeSwgbWVyZ2UsIHB1Ymxpc2gsIGRpc3RyaWJ1
dGUsIHN1YmxpY2Vuc2UsCisgKiBhbmQvb3Igc2VsbCBjb3BpZXMgb2YgdGhlIFNvZnR3YXJlLCBh
bmQgdG8gcGVybWl0IHBlcnNvbnMgdG8gd2hvbSB0aGUKKyAqIFNvZnR3YXJlIGlzIGZ1cm5pc2hl
ZCB0byBkbyBzbywgc3ViamVjdCB0byB0aGUgZm9sbG93aW5nIGNvbmRpdGlvbnM6CisgKgorICog
VGhlIGFib3ZlIGNvcHlyaWdodCBub3RpY2UgYW5kIHRoaXMgcGVybWlzc2lvbiBub3RpY2Ugc2hh
bGwgYmUgaW5jbHVkZWQKKyAqIGluIGFsbCBjb3BpZXMgb3Igc3Vic3RhbnRpYWwgcG9ydGlvbnMg
b2YgdGhlIFNvZnR3YXJlLgorICoKKyAqIFRIRSBTT0ZUV0FSRSBJUyBQUk9WSURFRCAiQVMgSVMi
LCBXSVRIT1VUIFdBUlJBTlRZIE9GIEFOWSBLSU5ELCBFWFBSRVNTCisgKiBPUiBJTVBMSUVELCBJ
TkNMVURJTkcgQlVUIE5PVCBMSU1JVEVEIFRPIFRIRSBXQVJSQU5USUVTIE9GIE1FUkNIQU5UQUJJ
TElUWSwKKyAqIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFIEFORCBOT05JTkZSSU5H
RU1FTlQuICBJTiBOTyBFVkVOVCBTSEFMTAorICogVEhFIENPUFlSSUdIVCBIT0xERVIoUykgQkUg
TElBQkxFIEZPUiBBTlkgQ0xBSU0sIERBTUFHRVMgT1IgT1RIRVIgTElBQklMSVRZLCBXSEVUSEVS
IElOCisgKiBBTiBBQ1RJT04gT0YgQ09OVFJBQ1QsIFRPUlQgT1IgT1RIRVJXSVNFLCBBUklTSU5H
IEZST00sIE9VVCBPRiBPUiBJTgorICogQ09OTkVDVElPTiBXSVRIIFRIRSBTT0ZUV0FSRSBPUiBU
SEUgVVNFIE9SIE9USEVSIERFQUxJTkdTIElOIFRIRSBTT0ZUV0FSRS4KKyAqLworCisjaWZuZGVm
IF9uYmlvXzJfM19TTU5fSEVBREVSCisjZGVmaW5lIF9uYmlvXzJfM19TTU5fSEVBREVSCisKKyNk
ZWZpbmUgc21uUENJRV9SWF9OVU1fTkFLCQkJCTB4MTExODAwMzgKKyNkZWZpbmUgc21uUENJRV9S
WF9OVU1fTkFLX0dFTkVSQVRFRAkJCTB4MTExODAwM2MKKworI2VuZGlmCS8vIF9uYmlvXzJfM19T
TU5fSEVBREVSCi0tIAoyLjIzLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeA==
