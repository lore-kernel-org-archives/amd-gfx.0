Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C484DC4363A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 11:07:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43011206E3
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 11:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="m277jHzJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43011206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4D9B6EDC3;
	Fri, 30 Oct 2020 11:07:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E8516EDB0
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 11:07:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BI10ytgpcZRw6nvf4q+cbGXP5YrIixR0LdtESxQfcuYtqT34siEgy5T1xymNCD6FsXzViZr9AKyBQfsaHN9xj//47Yvq8cXWxEcn+mhaw1HAYzH0VVWbo1hxBS9+bQLkUTJjZXEwMv3A6kXkFwa0/vLWXcNURplLjWInpy4vt+sTpdOTco+UFd6LqXbSu8GaG7BXGZHWxFtSz4YcMRpdShumKkrOaFWqCZ04EhQssAaYooBqc9LM/tZHbP4F00YD8cOOprt8SJ695YSfgWMYt5kASXTtXmpvcatu9iSm5R0MeWo8tiFdSQY/qY1fje3hUUnakHzXi39kCJHb3arT0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFD0BYsHIsa2QfrsDhWgD3R3r59XM1V95IGcJ3A02+c=;
 b=b4DwXMNptDIgL7O7zHufUbwH8WeyyzLAwHlT10stZBIL4dTYP0+3ABGjVPHehqiZQ/fasJ7x/Lao/vkxYwjWVMV5/9I4DRE6wT1X8Bll+aH7XZh4FdOTwcfDTD7u+TqAKPZojwbivEEiA7UtNSPlJDXafpxAbX+SbvCpuGUaCUsI2APaK1pVlGMCez7KaluzOgjrbvAPvW/e4OfkgTlt6Vd8nasbJln8hkW4gUpOnlwq9+RaxBL1xZo1un+uOJP9LakDC4NbkDaAmaQPpHaNfA1t3KvHLkGZxJr2eYrEcZAG8IPjcXxMn5MKyXOz1gIiAHa630+PqiWlSNwenxkqjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFD0BYsHIsa2QfrsDhWgD3R3r59XM1V95IGcJ3A02+c=;
 b=m277jHzJgCvydDOI5iCBwk7vpnLx/KFwJnyxlAok7OM0G9Jbg4tHG4K3kPcuADj3jJdqq9cXNlmRr50fWNUvrB7acEF35th1egEdUernDopLYaPubT5J//agiw0c6f90Da4NDr1n/a8z4Sg7X9lAO2D+a76WhVMsImWQH63T0lo=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2794.namprd12.prod.outlook.com (2603:10b6:5:48::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.25; Fri, 30 Oct 2020 11:07:31 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3499.028; Fri, 30 Oct 2020
 11:07:31 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: apply dm_pp_notify_wm_clock_changes() for
 Polaris only
Thread-Topic: [PATCH] drm/amdgpu: apply dm_pp_notify_wm_clock_changes() for
 Polaris only
Thread-Index: AQHWrqyLXnDcQFBeykuLLkPQ2Efykamv/AsAgAAANnA=
Date: Fri, 30 Oct 2020 11:07:31 +0000
Message-ID: <DM6PR12MB26196EB75BE3C8DA9BC5B9B1E4150@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201030110445.1662217-1-evan.quan@amd.com>
 <ee27f030-05a6-6a21-94fd-c70e53325de5@amd.com>
In-Reply-To: <ee27f030-05a6-6a21-94fd-c70e53325de5@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=720a4657-41e4-48d4-ab60-95f7cc075a89;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-30T11:07:06Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 38bb1157-a73e-4ff5-3d3d-08d87cc3ff59
x-ms-traffictypediagnostic: DM6PR12MB2794:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB27941CBAF84F379818028B3FE4150@DM6PR12MB2794.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4BANZLfR9Ajdj8PsPjh9WiPrd2f+MIvw3LuUKznf6x23q3yeUp84clXDRsWFxZhogHrXjRl80gTCMd97TavhMuvREpJUqnOCuHd5QBTc2tflsxh6ae0eIgK3RLEPvxWVv64WjuOyz5RKss5uWg545X6ff2NtqnQhab0Ud7/Wb9x37mxwIq1cjvmUSpWL7yDshABLIm3EU2kWGVFnLay6I17sfcwiN0ItSf0MoW8I6H1sNG/0Q8xZYxpf1Jk3tv798SeWXfrYB9GGL7u9wGZOj3KG+GVF1K04Cqwf7ZIjfVb7utDMAv1JZaIrefLhe8decdQ5lPFLJAHy/KVINfXWYg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(7696005)(4326008)(2906002)(6506007)(66946007)(9686003)(76116006)(66574015)(55016002)(83380400001)(478600001)(52536014)(66476007)(66556008)(66446008)(64756008)(33656002)(71200400001)(316002)(8936002)(53546011)(86362001)(5660300002)(110136005)(8676002)(26005)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: CJ8uiQH6ibr21j65EvmKhBrNqu805sJC4IRqNgpPHnX2Brsh+4O880atZmF5vA3zUkHFfbyRHSAon6g92ZUbz4c3RFDhvmsEsPYc4C6mypOF4wfmbW38lmbU4BraepLQPhIyml7yGQJ0cxrldBaqe+K/uXG+SXZTUAe8S4jP1nTcCmnoVkoNP5bDnOvS/7BjWb/zfaj9G5/GhaHIJFa3Tjfl4CN2Sr+ScDP/Uhr5+XSaen0YNqaW2ROqEF4t/awqvmoxjNoe2UUtRFrT7Wo1K4k8dtuAtuKFmxlgoM5+E8ptdMnjOnmPK5jyoOnZ7JY/TgxcGO5G4HJBY7WavaGu3EiU2zbqULYzM6LXEtO4tzBD+qJ5fPEG/tUkKgh7RhQ5LWUfytfxD0Bh9lSD1R4YZlytKaMjoEfM7PgOqFnXVXtpLQKByqInGI6PHQ9Cofwk6gMq4EINd4OU0GdwZ9GdQJfNfCd9TfcV1uJcNtIX9GouE8g03b5VHmI75qd47lgaTqzC3VEzZQ2qzEaTFtzooP4yABjI2PNINTcTZUU9NpTBQIyq3zIM1SLr+ANYGdsYAFtrh8vRkJhiwhu4ISqct/ntEEjqfFDO27VJ+/BQGpOuxn6RUZxWl50I9wsxKL0GQd23x8UbyYkdt7/cOxHXLg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38bb1157-a73e-4ff5-3d3d-08d87cc3ff59
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 11:07:31.6201 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DfuDtEzBRe+kKksjgfzybxcv1QUufUP3laMnST9jhp3Aonxe1LCKs766EsVtRff6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2794
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpZ
ZXMsIGl0IGlzIGludGVuZGVkIGZvciB0aGF0Lg0KDQpCUg0KRXZhbg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFt
ZC5jb20+DQpTZW50OiBGcmlkYXksIE9jdG9iZXIgMzAsIDIwMjAgNzowNiBQTQ0KVG86IFF1YW4s
IEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
CkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpTdWJq
ZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBhcHBseSBkbV9wcF9ub3RpZnlfd21fY2xvY2tf
Y2hhbmdlcygpIGZvciBQb2xhcmlzIG9ubHkNCg0KQW0gMzAuMTAuMjAgdW0gMTI6MDQgc2Nocmll
YiBFdmFuIFF1YW46DQo+IFdpbGwgZXhwYW5kIGl0IHRvIG90aGVyIEFTSUNzIGFmdGVyIHZlcmlm
aWVkLg0KPg0KPiBDaGFuZ2UtSWQ6IEkwM2UwNzRlYTBlOTIxYTk4NGViODE5YjIyMmU0MzRlODg4
ODhlMzc1DQo+IFNpZ25lZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+DQoN
CkFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQoN
CkkgYXNzdW1lIHRoaXMgZml4ZXMgbXkgaXNzdWUgb24gVmVnYTIwPw0KDQpUaGFua3MsDQpDaHJp
c3RpYW4uDQoNCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9k
bS9hbWRncHVfZG1fcHBfc211LmMgfCA3ICsrKysrKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNiBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9wcF9zbXUuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3BwX3NtdS5jDQo+IGluZGV4
IGZkMzlkZDY3YmZhNC4uODQwNjVjMTJkNGI4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9wcF9zbXUuYw0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9wcF9zbXUuYw0KPiBA
QCAtNDYyLDcgKzQ2MiwxMiBAQCBib29sIGRtX3BwX25vdGlmeV93bV9jbG9ja19jaGFuZ2VzKA0K
PiAgIHZvaWQgKnBwX2hhbmRsZSA9IGFkZXYtPnBvd2VycGxheS5wcF9oYW5kbGU7DQo+ICAgY29u
c3Qgc3RydWN0IGFtZF9wbV9mdW5jcyAqcHBfZnVuY3MgPSBhZGV2LT5wb3dlcnBsYXkucHBfZnVu
Y3M7DQo+DQo+IC1pZiAocHBfZnVuY3MgJiYgcHBfZnVuY3MtPnNldF93YXRlcm1hcmtzX2Zvcl9j
bG9ja3NfcmFuZ2VzKSB7DQo+ICsvKg0KPiArICogTGltaXQgdGhpcyB3YXRlcm1hcmsgc2V0dGlu
ZyBmb3IgUG9sYXJpcyBmb3Igbm93DQo+ICsgKiBUT0RPOiBleHBhbmQgdGhpcyB0byBvdGhlciBB
U0lDcw0KPiArICovDQo+ICtpZiAoKGFkZXYtPmFzaWNfdHlwZSA+PSBDSElQX1BPTEFSSVMxMCkg
JiYgKGFkZXYtPmFzaWNfdHlwZSA8PSBDSElQX1ZFR0FNKQ0KPiArICAgICAmJiBwcF9mdW5jcyAm
JiBwcF9mdW5jcy0+c2V0X3dhdGVybWFya3NfZm9yX2Nsb2Nrc19yYW5nZXMpIHsNCj4gICBpZiAo
IXBwX2Z1bmNzLT5zZXRfd2F0ZXJtYXJrc19mb3JfY2xvY2tzX3JhbmdlcyhwcF9oYW5kbGUsDQo+
ICAgKHZvaWQgKil3bV93aXRoX2Nsb2NrX3JhbmdlcykpDQo+ICAgcmV0dXJuIHRydWU7DQoNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
