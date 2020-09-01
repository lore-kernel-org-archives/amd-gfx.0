Return-Path: <SRS0=dANk=CK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B82BC433E2
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 12:59:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 550F0206CD
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 12:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RiJB0VZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 550F0206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A13A6E146;
	Tue,  1 Sep 2020 12:59:53 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750044.outbound.protection.outlook.com [40.107.75.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 369BE6E443
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2020 12:59:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1mUaSBVrMVMZHIpor7Xt1SIlzLWMKVWzNNJMKGt3EyTyQiJq1S3A882sPy6qvHYubxcLx8cED/P7jwFiUujE0pM9ViRo3WNE9eNctIDoJL0imengGBjUiYn/P7C1pyDZFV9Cfw8eBbwQISXNrKD/RRynuH1KI04DtH0ci/wv/hforeeDbEwwqm8WO6jUQwmIhL23xPsUjL7TQ7Bh13TninCM4yFWrZBbeSZGg0xRu7iTX2ToJ2y2qHIt0wb8ebEsnVpVjckmI9p6/CKG8ogRq+ZmhvBDrg2OxjdDK26N2AHWs5lMM909MwSr/p01BTR22aP7K7jgIxlzQ4gHLYvMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoRF7nhJubEV4T3WctHoir7h2ivFGO3sp9HcklPsQZo=;
 b=EytNCcjCzyUNt85s1+mNoKf4QiwZE41Hki77v5sVWqllrEISXz/KeMq+nQJItIl5BDzbcNqyMP9Qqmti5FryTffTQjlbFfFMdLQL+KDFQsgXoHN/aJVfnxhUuvDs0IvJPU5RaG5XfjH76lvCVGlpJGCkVKr5K7QTcPFdxVPenHH32+uLZB9WO+VofeZSgKm8fA8D7Hh1nu/ACJM+/OybR26Z4TxgqWbxboXW6RV8bJohU/aBuHfHxiyJ0VZBkX0LyzuN35T7lXpvRDuzUkcrQZgOJ3F2gAC1Qpc7Roy/Veaw5y5LNKneJ95my5zU+lFrXnJmcTVwsrDtXCWJJrszzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoRF7nhJubEV4T3WctHoir7h2ivFGO3sp9HcklPsQZo=;
 b=RiJB0VZjbRyo36hdJvY72LUeaGnlSttoeatv4Rd/lC+LHMSMQVdbw2IWjI4Zr8C4kMfjoc6pzNly8s+vJU9JokCOWldxQDpVF4sOYfi4i3AMSLyz26cffGXj0ytGPYqGIhpx18/Xy8nwESSgod0OTarCN8dy1djH3cJYQtv11L8=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR1201MB0122.namprd12.prod.outlook.com (2603:10b6:4:57::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Tue, 1 Sep
 2020 12:59:40 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7865:b161:9dd1:7c5]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7865:b161:9dd1:7c5%10]) with mapi id 15.20.3326.023; Tue, 1 Sep 2020
 12:59:40 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIFYyXSBkcm0vYW1kZ3B1OiBEbyBub3QgbW92ZSByb290?=
 =?gb2312?Q?_PT_bo_to_relocated_list?=
Thread-Topic: [PATCH V2] drm/amdgpu: Do not move root PT bo to relocated list
Thread-Index: AQHV363JPwEEMuSvX0ym5Sus0fH+o6lVAAqg
Date: Tue, 1 Sep 2020 12:59:40 +0000
Message-ID: <DM5PR12MB1708207A4C9E047F17B4DAA5842E0@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <SN6PR12MB28007664AFF433168DF33CC787190@SN6PR12MB2800.namprd12.prod.outlook.com>
In-Reply-To: <SN6PR12MB28007664AFF433168DF33CC787190@SN6PR12MB2800.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-10T01:04:19.977Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [101.87.146.117]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0435b087-11cb-426d-f53f-08d84e76e3c8
x-ms-traffictypediagnostic: DM5PR1201MB0122:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB01228FADFC164A64C852C8FB842E0@DM5PR1201MB0122.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: McOQHIBYWG5Bc4UNIzDlkkqqAZCV2WgMhZklLMq37wmOFJYo0saqdDBWjuvl/tmBIxbDOc5zbJRxwrfawgBjsnNR3MBCFuPUNTEG1ZCLoFGRF0KtuJPHVgnIOB6lainTEOSfrs1JdKBcz0A4tOldda+h/FTVVr6DdNv0A38fcF8RLA2vDg5ziPWpKfw8jreC9ZqOfMzFkhQu8GKZg5gvBMy4h15XJJXcCKyA4XMt72P9hfJuytqH8jBNbE+MXJoXRk3K5URNE71RdafpNgbAc2wPF0GT2rUksPIj2aFREeeh06M6IS26v2AMvayjSoL6pXuC7TgNVN79LBws9ilNMuyilwhvcbyG82uyJsU7ajE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(8936002)(66476007)(66946007)(64756008)(66556008)(71200400001)(186003)(76116006)(66446008)(33656002)(966005)(5660300002)(52536014)(55016002)(83380400001)(4326008)(110136005)(316002)(9686003)(86362001)(45080400002)(478600001)(2906002)(6506007)(224303003)(26005)(7696005)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: RSkPz52jeyYIkFM6/mbQ2+HgAtj4OGij0Z4hQLevgI9qjrSZS/IU3+NpAUDyJZ4fbYkPOzV0IrjaivnAVparw1g1Rsg/D1G4rA3FjQkK6Ocs+5HMqwL+i9GqvRznN5IruGcXWBZnjt2RZGGvT/eTmQMpvY5k5lj/rs43tYL7qTHWjK7g1Qppxm9WuiYW4np+W8r4Rj88i7GkFc6SOyAJP0driFmpB0muQT7VA7FRxQi3QQSTLYSqyFLP5WEERBlqsjAOhvmPeOyGl5EsBIAD2kNQPHMZCVYJxG1ChtUMALvy71FSOMKvxlrLab2/DiEBNvXKIeh/TuQKeT1YU78JGvCw/fJ5s5bx78U+lsfTuwEZAV1J6eZps6n6/7QCCk88V4bikDj99vxaGbsXRCq91LQXpUFcVNoiDt+6BAERd1k6bJ8AtbXjhafyedB+SlDyDXsXBxvYYeGDbE5QfXn44p4/Jzacm7z1o5Q3nZBWFWYRsKtbrVqM3lh+lt3kY5FPKV/I+zVQ5zmkazNnjSmV2wsALbQCsIz52mf7qRKzO8eGifuuxXDvVO0D/MJ0Ue2AiH27OfkMQDqddNf/SqzJTpVvk4RbX1hKqyKGzZCkUyyEXQUAFYuHyl5orepjlVEua0dn8S/BdtgJHZvOJfcoXA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0435b087-11cb-426d-f53f-08d84e76e3c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2020 12:59:40.4572 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FsA4tl126C7mnUmYUi0YCeHRqq1ykSzT2padJpHYitnbq4ooXe4Uw6LnOdzJ7dXj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0122
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpT
ZWUgdGhhdCB3ZSBhbHJlYWR5IGhhdmUgc3VjaCBsb2dpYzoNCg0KMjgyIHN0YXRpYyB2b2lkIGFt
ZGdwdV92bV9ib19yZWxvY2F0ZWQoc3RydWN0IGFtZGdwdV92bV9ib19iYXNlICp2bV9ibykNCiAy
ODMgew0KIDI4NCAgICAgaWYgKHZtX2JvLT5iby0+cGFyZW50KQ0KIDI4NSAgICAgICAgIGxpc3Rf
bW92ZSgmdm1fYm8tPnZtX3N0YXR1cywgJnZtX2JvLT52bS0+cmVsb2NhdGVkKTsNCiAyODYgICAg
IGVsc2UNCiAyODcgICAgICAgICBhbWRncHVfdm1fYm9faWRsZSh2bV9ibyk7DQogMjg4IH0NCg0K
V2h5IHlvdSBuZWVkIHRvIGRvIHRoZSBiby0+cGFyZW50IGNoZWNrIG91dCBzaWRlID8NCg0KLS0t
LS3Tyrz+1K28/i0tLS0tDQq3orz+yMs6IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5m
cmVlZGVza3RvcC5vcmc+ILT6se0gUGFuLCBYaW5odWkNCreiy83KsbzkOiAyMDIwxOoy1MIxMMjV
IDk6MDQNCsrVvP7IyzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCrOty806IERldWNo
ZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0
aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQrW98ziOiBbUEFUQ0ggVjJdIGRybS9hbWRn
cHU6IERvIG5vdCBtb3ZlIHJvb3QgUFQgYm8gdG8gcmVsb2NhdGVkIGxpc3QNCg0KaGl0IHBhbmlj
IHdoZW4gd2UgdXBkYXRlIHRoZSBwYWdlIHRhYmxlcy4NCg0KPDE+WyAgMTIyLjEwMzI5MF0gQlVH
OiBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLCBhZGRyZXNzOiAwMDAwMDAwMDAwMDAw
MDA4IDwxPlsgIDEyMi4xMDMzNDhdICNQRjogc3VwZXJ2aXNvciByZWFkIGFjY2VzcyBpbiBrZXJu
ZWwgbW9kZSA8MT5bICAxMjIuMTAzMzc2XSAjUEY6IGVycm9yX2NvZGUoMHgwMDAwKSAtIG5vdC1w
cmVzZW50IHBhZ2UgPDY+WyAgMTIyLjEwMzQwM10gUEdEIDAgUDREIDAgPDQ+WyAgMTIyLjEwMzQy
MV0gT29wczogMDAwMCBbIzFdIFNNUCBQVEkNCjw0PlsgIDEyMi4xMDM0NDJdIENQVTogMTMgUElE
OiAyMTMzIENvbW06IGtmZHRlc3QgVGFpbnRlZDogRyAgICAgICAgICAgT0UgICAgIDUuNC4wLXJj
NysgIzcNCjw0PlsgIDEyMi4xMDM0ODBdIEhhcmR3YXJlIG5hbWU6IFN1cGVybWljcm8gU1lTLTcw
NDhHUi1UUi9YMTBEUkctUSwgQklPUyAzLjBiIDAzLzA5LzIwMTggPDQ+WyAgMTIyLjEwMzY1N10g
UklQOiAwMDEwOmFtZGdwdV92bV91cGRhdGVfcGRlcysweDE0MC8weDMzMCBbYW1kZ3B1XSA8ND5b
ICAxMjIuMTAzNjg5XSBDb2RlOiAwMyA0YyA4OSA3MyAwOCA0OSA4OSA5ZCBjOCAwMCAwMCAwMCA0
OCA4YiA3YiBmMCBjNiA0MyAxMCAwMCA0NSAzMSBjMCA0OCA4YiA4NyAyOCAwNCAwMCAwMCA0OCA4
NSBjMCA3NCAwNyA0YyA4YiA4MCAyMCAwNCAwMCAwMCA8NGQ+IDhiIDcwIDA4IDMxIGY2IDQ5IDhi
IDg2IDI4IDA0IDAwIDAwIDQ4IDg1IGMwIDc0IDBmIDQ4IDhiIDgwIDI4IDw0PlsgIDEyMi4xMDM3
NjldIFJTUDogMDAxODpmZmZmYjQ5YTBhNmEzYTk4IEVGTEFHUzogMDAwMTAyNDYgPDQ+WyAgMTIy
LjEwMzc5N10gUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJCWDogZmZmZjkwMjBmODIzYzE0OCBSQ1g6
IGRlYWQwMDAwMDAwMDAxMjIgPDQ+WyAgMTIyLjEwMzgzMV0gUkRYOiBmZmZmOTAyMGVjZTcwMDE4
IFJTSTogZmZmZjkwMjBmODIzYzBjOCBSREk6IGZmZmY5MDEwY2EzMWM4MDAgPDQ+WyAgMTIyLjEw
Mzg2NV0gUkJQOiBmZmZmYjQ5YTBhNmEzYjM4IFIwODogMDAwMDAwMDAwMDAwMDAwMCBSMDk6IDAw
MDAwMDAwMDAwMDAwMDEgPDQ+WyAgMTIyLjEwMzg5OV0gUjEwOiAwMDAwMDAwMDYwNDRmOTk0IFIx
MTogMDAwMDAwMDBkZjU3ZmI1OCBSMTI6IGZmZmY5MDIwZjgyM2MwMDAgPDQ+WyAgMTIyLjEwMzkz
M10gUjEzOiBmZmZmOTAyMGY4MjNjMDAwIFIxNDogZmZmZjkwMjBmODIzYzBjOCBSMTU6IGZmZmY5
MDEwZDVkMjAwMDAgPDQ+WyAgMTIyLjEwMzk2OF0gRlM6ICAwMDAwN2YzMmM4M2RjNzgwKDAwMDAp
IEdTOmZmZmY5MDIwZmYzODAwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMCA8ND5bICAx
MjIuMTA0MDA2XSBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUw
MDMzIDw0PlsgIDEyMi4xMDQwMzVdIENSMjogMDAwMDAwMDAwMDAwMDAwOCBDUjM6IDAwMDAwMDIw
MzZiYmEwMDUgQ1I0OiAwMDAwMDAwMDAwMzYwNmUwIDw0PlsgIDEyMi4xMDQwNjldIERSMDogMDAw
MDAwMDAwMDAwMDAwMCBEUjE6IDAwMDAwMDAwMDAwMDAwMDAgRFIyOiAwMDAwMDAwMDAwMDAwMDAw
IDw0PlsgIDEyMi4xMDQxMDNdIERSMzogMDAwMDAwMDAwMDAwMDAwMCBEUjY6IDAwMDAwMDAwZmZm
ZTBmZjAgRFI3OiAwMDAwMDAwMDAwMDAwNDAwIDw0PlsgIDEyMi4xMDQxMzddIENhbGwgVHJhY2U6
DQo8ND5bICAxMjIuMTA0MjQxXSAgdm1fdXBkYXRlX3BkcysweDMxLzB4NTAgW2FtZGdwdV0gPDQ+
WyAgMTIyLjEwNDM0N10gIGFtZGdwdV9hbWRrZmRfZ3B1dm1fbWFwX21lbW9yeV90b19ncHUrMHgy
ZWYvMHg2OTAgW2FtZGdwdV0gPDQ+WyAgMTIyLjEwNDQ2Nl0gIGtmZF9wcm9jZXNzX2FsbG9jX2dw
dXZtKzB4OTgvMHgxOTAgW2FtZGdwdV0gPDQ+WyAgMTIyLjEwNDU3Nl0gIGtmZF9wcm9jZXNzX2Rl
dmljZV9pbml0X3ZtLnBhcnQuOCsweGYzLzB4MWYwIFthbWRncHVdIDw0PlsgIDEyMi4xMDQ2ODhd
ICBrZmRfcHJvY2Vzc19kZXZpY2VfaW5pdF92bSsweDI0LzB4MzAgW2FtZGdwdV0gPDQ+WyAgMTIy
LjEwNDc5NF0gIGtmZF9pb2N0bF9hY3F1aXJlX3ZtKzB4YTQvMHhjMCBbYW1kZ3B1XSA8ND5bICAx
MjIuMTA0OTAwXSAga2ZkX2lvY3RsKzB4Mjc3LzB4NTAwIFthbWRncHVdIDw0PlsgIDEyMi4xMDUw
MDFdICA/IGtmZF9pb2N0bF9mcmVlX21lbW9yeV9vZl9ncHUrMHhjMC8weGMwIFthbWRncHVdIDw0
PlsgIDEyMi4xMDUwMzldICA/IHJjdV9yZWFkX2xvY2tfc2NoZWRfaGVsZCsweDRmLzB4ODANCjw0
PlsgIDEyMi4xMDUwNjhdICA/IGttZW1fY2FjaGVfZnJlZSsweDJiYS8weDMwMCA8ND5bICAxMjIu
MTA1MDkzXSAgPyB2bV9hcmVhX2ZyZWUrMHgxOC8weDIwIDw0PlsgIDEyMi4xMDUxMTddICA/IGZp
bmRfaGVsZF9sb2NrKzB4MzUvMHhhMCA8ND5bICAxMjIuMTA1MTQzXSAgZG9fdmZzX2lvY3RsKzB4
YTkvMHg2ZjAgPDQ+WyAgMTIyLjEwNjAwMV0gIGtzeXNfaW9jdGwrMHg3NS8weDgwIDw0PlsgIDEy
Mi4xMDY4MDJdICA/IGRvX3N5c2NhbGxfNjQrMHgxNy8weDIzMCA8ND5bICAxMjIuMTA3NjA1XSAg
X194NjRfc3lzX2lvY3RsKzB4MWEvMHgyMCA8ND5bICAxMjIuMTA4Mzc4XSAgZG9fc3lzY2FsbF82
NCsweDVmLzB4MjMwIDw0PlsgIDEyMi4xMDkxMThdICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3
ZnJhbWUrMHg0OS8weGJlDQo8ND5bICAxMjIuMTA5ODQyXSBSSVA6IDAwMzM6MHg3ZjMyYzZiNDk1
ZDcNCg0KU2lnbmVkLW9mZi1ieTogeGluaHVpIHBhbiA8eGluaHVpLnBhbkBhbWQuY29tPg0KLS0t
DQpjaGFuZ2UgZnJvbSB2MToNCiAgIG1vdmUgcm9vdCBwdCBibyB0byBpZGxlIHN0YXRlIGluc3Rl
YWQuDQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDkgKysr
KysrLS0tDQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCmluZGV4IDMxOTViYzkuLmMz
ZDFhZjUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0u
Yw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCkBAIC0yNjE5
LDkgKzI2MTksMTIgQEAgdm9pZCBhbWRncHVfdm1fYm9faW52YWxpZGF0ZShzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwNCiBjb250aW51ZTsNCiBib19iYXNlLT5tb3ZlZCA9IHRydWU7DQoNCi1p
ZiAoYm8tPnRiby50eXBlID09IHR0bV9ib190eXBlX2tlcm5lbCkNCi1hbWRncHVfdm1fYm9fcmVs
b2NhdGVkKGJvX2Jhc2UpOw0KLWVsc2UgaWYgKGJvLT50Ym8uYmFzZS5yZXN2ID09IHZtLT5yb290
LmJhc2UuYm8tPnRiby5iYXNlLnJlc3YpDQoraWYgKGJvLT50Ym8udHlwZSA9PSB0dG1fYm9fdHlw
ZV9rZXJuZWwpIHsNCitpZiAoYm8tPnBhcmVudCkNCithbWRncHVfdm1fYm9fcmVsb2NhdGVkKGJv
X2Jhc2UpOw0KK2Vsc2UNCithbWRncHVfdm1fYm9faWRsZShib19iYXNlKTsNCit9IGVsc2UgaWYg
KGJvLT50Ym8uYmFzZS5yZXN2ID09IHZtLT5yb290LmJhc2UuYm8tPnRiby5iYXNlLnJlc3YpDQog
YW1kZ3B1X3ZtX2JvX21vdmVkKGJvX2Jhc2UpOw0KIGVsc2UNCiBhbWRncHVfdm1fYm9faW52YWxp
ZGF0ZWQoYm9fYmFzZSk7DQotLQ0KMi43LjQNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fDQphbWQtZ2Z4IG1haWxpbmcgbGlzdA0KYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcNCmh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9v
ay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4l
MkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q21vbmsubGl1JTQwYW1kLmNv
bSU3QzlmYTY3ZmVmNTM5ZjQ2ZThkOTRmMDhkN2FkYzUyYjVhJTdDM2RkODk2MWZlNDg4NGU2MDhl
MTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzE2ODkzNDY4MzYyNTgzMiZhbXA7c2RhdGE9bllv
ZUJYWE9kZVBuNFE2aHhybFNUelQxUHhUeCUyRlJ3V3FlS1hHbVE1TlBZJTNEJmFtcDtyZXNlcnZl
ZD0wDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
