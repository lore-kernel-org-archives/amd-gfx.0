Return-Path: <SRS0=N3S+=3L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA18C2D0CE
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 03:13:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ED0B24655
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 03:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cVK4uoqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED0B24655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAFE06E22F;
	Wed, 22 Jan 2020 03:13:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDF6F6E22F
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 03:13:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijMwYWqA57OD9SS34V/do5ae8lPJakb5G/f3IdpaABFrPsUM38jQ6Kd5TWfjcfgIRp6b6hH+vxnKv+/s/+U566HfcBFb8GmrBi1wxwGXgMRkr+lG46O1coXYoduZ54HVr3NYySn47rf4oq9d1M+vzoUPYzFq//SOqRa34k7U/Bxp0X9v3VYfmCXrYQjVWcOTVklk6OoycS0WO6zgInktjHXbXOB/hffXTmI+iwCU4lzWPyAfUkPajsOXXmAtQcJTFHSvr5gwBA7WgjDNKbqRyyF0XSVOo++T3olXfI1GwHEJKWj0rm0aoOdsW/UK72mjpkqJHR0t3lbyu5uK4qHV3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfDwFit20NIvhRIpVJ6XZJhkSgjaiv2GNEM79tYFxhU=;
 b=ZAGEJxh4qvt37RvxpJ0+QnpVly4WZaJRUVGU28n9sKI5DmreuP3Y54hLrJl9xLie6dvud8SapGIC4aFeM/FjIgh/teuuhsXgq1/hu0IwFXfRA7lf3EeFbZqBseKgzJ74dJlkVTAifRplVuyaT2Ien9KtPqYMdbgipNe+1yGt2X2vcqnp1of9K135e9UYJUlzaBVZu365RtIMtzBzX28FkE2dSt1IgDHBInTTg5E2OElkAsJpV/Vr5U7peWeuIDscOqYxnSRxAZq0jdGRnvjLaYV2hP9PNu9RmXUrfbUevYsTGfYw/S6sqH7ByqG6M89qX2xCLe+WiCbrdkiabDZqEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfDwFit20NIvhRIpVJ6XZJhkSgjaiv2GNEM79tYFxhU=;
 b=cVK4uoqDQ/M332HDjWETlIzftF8FMSfvFchFOetodRYJk82/qTfhAIlgbQrtFfgQc9q0Nm+jUMVZbpkzyXuAtrCDaAIIqMW7qg4biCBlOmffIxz9Cjkg8opjKj2eVO7QF7VfPDQfZ9p2GVl/Nx9B7DYxmlNYM6GW0prmrrje5lU=
Received: from CH2PR12MB3767.namprd12.prod.outlook.com (52.132.244.213) by
 CH2PR12MB3861.namprd12.prod.outlook.com (52.132.245.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.21; Wed, 22 Jan 2020 03:13:25 +0000
Received: from CH2PR12MB3767.namprd12.prod.outlook.com
 ([fe80::703e:37ee:ddb1:d321]) by CH2PR12MB3767.namprd12.prod.outlook.com
 ([fe80::703e:37ee:ddb1:d321%3]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 03:13:25 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: initialize bo_va_list when add gws to process
Thread-Topic: [PATCH] drm/amdgpu: initialize bo_va_list when add gws to process
Thread-Index: AdXQ0VelFRbHEHdaTxecPuaSY75YQQAAHlvQ
Date: Wed, 22 Jan 2020 03:13:24 +0000
Message-ID: <CH2PR12MB3767845E5AD3BD543F620A6DFE0C0@CH2PR12MB3767.namprd12.prod.outlook.com>
References: <SN6PR12MB2800374EE3DA1CBC3C618894870C0@SN6PR12MB2800.namprd12.prod.outlook.com>
In-Reply-To: <SN6PR12MB2800374EE3DA1CBC3C618894870C0@SN6PR12MB2800.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=19101593-1859-480f-8428-000025ba5841;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-22T03:09:00Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-22T03:13:23Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 61fefe43-beb2-4bd0-9ac7-0000b36b3c29
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Feifei.Xu@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5decccfb-cdfa-45f2-c090-08d79ee90b51
x-ms-traffictypediagnostic: CH2PR12MB3861:|CH2PR12MB3861:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB38610385285F0A739C8019C4FE0C0@CH2PR12MB3861.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:341;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(199004)(189003)(966005)(64756008)(86362001)(66556008)(66476007)(66446008)(66946007)(76116006)(26005)(52536014)(4326008)(186003)(33656002)(71200400001)(5660300002)(53546011)(6506007)(9686003)(7696005)(110136005)(316002)(54906003)(8936002)(81156014)(8676002)(81166006)(478600001)(45080400002)(55016002)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3861;
 H:CH2PR12MB3767.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R+kLUwTRMg3msYQrutEgsvFYtAUSZDH1/e1cNx/vucZwyUNn98fHlkotr7C8nI0Sx+rWSEIHrWTTbTuK9zoWMLHWPWMakkxRkcWfTqL0C6wiIcxU9Nl+DF29vlkZy8uhZgetrCGNkxfYvVL3eCcdC3rWkkkxW5nFkWMpGQnwlBDkZUDry60a8y1Ojds1hHp1zew3ySkiwAmDcUxlx9IXW68ZUBy9zHCwnQR3YL4ZfaN9/uNTRC/4gwCcTXOz5WXTZQCfi2QZtSwCh1tYQLXussc+q85d/0voxZGR+CobsGK/jrcQHgRUxlTJiHMDUi6LHQnBmfhl8Qc5a86mNcgAOJ+mJjgFygtzQ5TfJ0loTntPdWBHHb4gwduOfSJG8SkFmHQNubeynerUUP6W/dj+6PcnBR5zuXIFuOA/UFZoOP/QNvpN+ynNanbozuDUTxf40Cl6LgqtT8UKLJ0BwmHlTon3+6Yd1b3+nZ83gYlpRa8=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5decccfb-cdfa-45f2-c090-08d79ee90b51
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 03:13:24.9081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /F04hPO7+OjXbP6ItnSyn2I3wtSzvyZFcHjHsMfPF5vTEqYXybFWudfFEvwZqekF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3861
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zeng,
 Oak" <Oak.Zeng@amd.com>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQoN
Cg0KUmV2aWV3ZWQtYnk6IEZlaWZlaSBYdSA8RmVpZmVpLlh1QGFtZC5jb20+DQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgUGFuLCBYaW5odWkNClNlbnQ6IDIwMjDE6jHU
wjIyyNUgMTE6MTANClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IERldWNo
ZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFplbmcsIE9hayA8T2Fr
LlplbmdAYW1kLmNvbT4NClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogaW5pdGlhbGl6ZSBi
b192YV9saXN0IHdoZW4gYWRkIGd3cyB0byBwcm9jZXNzDQoNCg0KYm9fdmFfbGlzdCBpcyBsaXN0
X2hlYWQsIHNvIGluaXRpYWxpemUgaXQuDQoNClNpZ25lZC1vZmYtYnk6IHhpbmh1aSBwYW4gPHhp
bmh1aS5wYW5AYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hbWRrZmRfZ3B1dm0uYyB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0K
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9n
cHV2bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5j
DQppbmRleCA5ZTc4ODljMjhmM2UuLmVmNzIxY2I2NTg2OCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQpAQCAtMjEyNiw2ICsyMTI2
LDcgQEAgaW50IGFtZGdwdV9hbWRrZmRfYWRkX2d3c190b19wcm9jZXNzKHZvaWQgKmluZm8sIHZv
aWQgKmd3cywgc3RydWN0IGtnZF9tZW0gKiptZW0NCiAJCXJldHVybiAtRU5PTUVNOw0KIA0KIAlt
dXRleF9pbml0KCYoKm1lbSktPmxvY2spOw0KKwlJTklUX0xJU1RfSEVBRCgmKCptZW0pLT5ib192
YV9saXN0KTsNCiAJKCptZW0pLT5ibyA9IGFtZGdwdV9ib19yZWYoZ3dzX2JvKTsNCiAJKCptZW0p
LT5kb21haW4gPSBBTURHUFVfR0VNX0RPTUFJTl9HV1M7DQogCSgqbWVtKS0+cHJvY2Vzc19pbmZv
ID0gcHJvY2Vzc19pbmZvOw0KLS0gDQoyLjE3LjENCg0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18NCmFtZC1nZnggbWFpbGluZyBsaXN0DQphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZw0KaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5v
dXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFp
bG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDRmVpZmVpLlh1JTQw
YW1kLmNvbSU3QzIxMDBkNDlmYjk4MDRjNjQ3OWRlMDhkNzllZTg4YmMxJTdDM2RkODk2MWZlNDg4
NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzE1MjU5MzkzMDU3NzU3NSZhbXA7c2Rh
dGE9VldJY0VaampwRnRXS0ZpMmxtWUZlb0FMYiUyRlVXZW9TZHROUTFoZ2h3aUgwJTNEJmFtcDty
ZXNlcnZlZD0wDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
