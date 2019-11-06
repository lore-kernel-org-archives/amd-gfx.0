Return-Path: <SRS0=nD/m=Y6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295BCC5DF62
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 06:24:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0D20206DF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2019 06:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D20206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B37696E17E;
	Wed,  6 Nov 2019 06:24:44 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760051.outbound.protection.outlook.com [40.107.76.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 606A76E17E
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2019 06:24:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iq7K1DssIEZuQxJcUdZegRKqPn/klXmAIQ7xFXWJ1v6OdLC4rkGscrXN34rmqswHeRueFfFziD6wPmtg+lzOx1yq0RrFzBs0o6UoF1kyBJbwiP6HJNrHtUSuyvJ3XCb5E2agGUTpvfbFjmf6q/RouOBQp9+VcoreVBz781dNttryvufvlDuPnKENTLjXw7xE4/tOL/SExFw6izijpVm8j6tmfmvDWllsOJKJQQfuu/iXlfkcJESad9CjthdH+rdQ8AXXaS/J/YybY5rBB3eLSopdl8Ruim4U8WjGMYtCx3RbbJXh+ikfv4pL+pZg4utNAGL2sDyPdqCb1b9gLk7KNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWpi6ZUC+yupXVszIbTnWd625vcX62YEWs5dvMX+ap0=;
 b=UIu8GwcUCO4pPgR8+NyYFfcsOEwEMawk4aermFWRUt/dF+1C0cu89/tm7lIn9hU7rg3StOTEzni+1/uT7CYa1ubf1By4QiCRnNP/13bo70bQAqpxnQZeR0inktlxv0CU+jLTmgbxTTEMm2dQPzkQu8CaqX3iwb+yJg8LGXKUwIRTH8kAbkTMm9IyZe6n9CDATtk9Q6hDSi9E+ZsACkw6GsUXSptAL9QtrnKqeRtCJBVU4cLaWt0265J2Orv7jlgzjGYqoOl2Lleu1cznROQfee3uZYltIkt3N7OvfPXtDABOmb/2bkzGuRX1/Jq6c/DwPJV/dD+YLHyEOLph+Y9HbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB2975.namprd12.prod.outlook.com (20.178.243.142) by
 MN2PR12MB3088.namprd12.prod.outlook.com (20.178.241.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 06:24:41 +0000
Received: from MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::49e3:7f2c:931c:36e7]) by MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::49e3:7f2c:931c:36e7%7]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 06:24:41 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Need to disable msix when unloading driver
Thread-Topic: [PATCH] drm/amdgpu: Need to disable msix when unloading driver
Thread-Index: AQHVlGoBiY9La5+loEaAbCXyiRsv2Kd9rNMg
Date: Wed, 6 Nov 2019 06:24:41 +0000
Message-ID:
 <MN2PR12MB29759A675C5D0C677ABCBE5C8F790@MN2PR12MB2975.namprd12.prod.outlook.com>
References: <1573021089-14955-1-git-send-email-Emily.Deng@amd.com>
In-Reply-To: <1573021089-14955-1-git-send-email-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6b8c0fad-6620-4f2d-585c-08d762820236
x-ms-traffictypediagnostic: MN2PR12MB3088:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB30883196D89662C3864F7A808F790@MN2PR12MB3088.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(13464003)(199004)(189003)(256004)(66556008)(110136005)(66446008)(66476007)(64756008)(33656002)(76116006)(316002)(6116002)(6246003)(6506007)(2906002)(26005)(229853002)(2501003)(76176011)(66946007)(102836004)(8676002)(52536014)(5660300002)(55016002)(3846002)(6436002)(9686003)(7696005)(14454004)(186003)(8936002)(476003)(11346002)(446003)(486006)(71200400001)(25786009)(478600001)(74316002)(81156014)(66066001)(81166006)(7736002)(86362001)(305945005)(99286004)(71190400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3088;
 H:MN2PR12MB2975.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mws8J1oGOxLbsNFT8Leudw5zNa3r0f+/nAH1MBcYcazUcjTHymVFugX8o5JguYKIP4cZhV4vHNOXgEb86gYAOP5En682I9GOSiDMjwrzPzF7fYgQt5hhvAf+zgK1ixMPCV6ZMhkIfhsfibYO6unpzXsd0StTlsJDymd9bwokzas6TZRXHiAQRTre+CU5Zyjo/9Z/LgfzIt2PwJTDxyeHI1QlGFSATZJ4m2BR9GUgBimOsWglk624kboVOsrpegmuLL5WwzPQccrpMY9qur1h1EDf5IiraJMXauuQeeEyiVbErulXZQjLUo3Na7OgH29Nma/KV6rvyowStXkZqS8YDf2TE0FsPdgRL/W2xkaezGhEO0ukCzX+Cm/TvrJV3NxbZK8rpG3YHnpZM2R6N61j0vpdftuAlXBYdbfomHkfcFAh3wpXdtWDQfSgCkObMUSj
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8c0fad-6620-4f2d-585c-08d762820236
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 06:24:41.6981 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NTu2Xfdc6PxnmFaOqnBC2nXzysN9kP8BcRxgeBv/Q9GhYi4eMiSOvVww9tfVaCOF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3088
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWpi6ZUC+yupXVszIbTnWd625vcX62YEWs5dvMX+ap0=;
 b=fNrNVbY1HISntuerJsR8j0CFYwEsaraL1FNYHEPYLvFiSVkIuTurmfYb9ImT8eKlslGVMniENlT/d9/6Gi764bxpZorH0PyBIGCPbC4mQ1uPK+alcfxCH3XUNExwC3pxN2hoJ8se6eBPY5gIsmWF+Nt3KrPslLWVF1HNl70KJCI=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Emily.Deng@amd.com; 
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191106062441.Q1jx9zbXfcMB-xBDuXoZrjGTICgZ9xwo6nIo85BALoc@z>

U29ycnksIHBsZWFzZSBpZ25vcmUgdGhpcywgd2lsbCBzZW5kIGFub3RoZXIgcGF0Y2ggbGF0ZXIu
CgpCZXN0IHdpc2hlcwpFbWlseSBEZW5nCgoKCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+
RnJvbTogRW1pbHkgRGVuZyA8RW1pbHkuRGVuZ0BhbWQuY29tPgo+U2VudDogV2VkbmVzZGF5LCBO
b3ZlbWJlciA2LCAyMDE5IDI6MTggUE0KPlRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zwo+Q2M6IERlbmcsIEVtaWx5IDxFbWlseS5EZW5nQGFtZC5jb20+Cj5TdWJqZWN0OiBbUEFUQ0hd
IGRybS9hbWRncHU6IE5lZWQgdG8gZGlzYWJsZSBtc2l4IHdoZW4gdW5sb2FkaW5nIGRyaXZlcgo+
Cj5Gb3IgZHJpdmVyIHJlbG9hZCB0ZXN0LCBpdCB3aWxsIHJlcG9ydCAiY2FuJ3QgZW5hYmxlIE1T
SSAoTVNJLVggYWxyZWFkeSBlbmFibGVkKSIuCj4KPlNpZ25lZC1vZmYtYnk6IEVtaWx5IERlbmcg
PEVtaWx5LkRlbmdAYW1kLmNvbT4KPi0tLQo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9pcnEuYyB8IDQgKysrKwo+IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKPgo+
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pcnEuYwo+Yi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXJxLmMKPmluZGV4IDYwNDBlYjMuLjQ4
ZDljZjBkIDEwMDY0NAo+LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ly
cS5jCj4rKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXJxLmMKPkBAIC0z
MjUsNyArMzI1LDExIEBAIHZvaWQgYW1kZ3B1X2lycV9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KQo+IAkJZHJtX2lycV91bmluc3RhbGwoYWRldi0+ZGRldik7Cj4gCQlhZGV2LT5pcnEu
aW5zdGFsbGVkID0gZmFsc2U7Cj4gCQlpZiAoYWRldi0+aXJxLm1zaV9lbmFibGVkKQo+KyNpZmRl
ZiBQQ0lfSVJRX01TSQo+KwkJCXBjaV9mcmVlX2lycV92ZWN0b3JzKGFkZXYtPnBkZXYpOwo+KyNl
bHNlCj4gCQkJcGNpX2Rpc2FibGVfbXNpKGFkZXYtPnBkZXYpOwo+KyNlbmRpZgo+IAkJaWYgKCFh
bWRncHVfZGV2aWNlX2hhc19kY19zdXBwb3J0KGFkZXYpKQo+IAkJCWZsdXNoX3dvcmsoJmFkZXYt
PmhvdHBsdWdfd29yayk7Cj4gCX0KPi0tCj4yLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4
