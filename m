Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3625C00140
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Aug 2022 13:30:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10EC4112015;
	Mon,  8 Aug 2022 13:26:39 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C24A69BEE4
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Aug 2022 13:12:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frC6fJCQrSXcZ5nDIoXoVb8QPm1ANBlKLtDfF5T83Y9C0+xBLwlwYDlDR2d//tCEGfJ0U7qp4wVyW1aBBx081sGH1YLQpNMk7L2C6ZrQcJJoVaL9cfu2tibFgbV2rq0CbkrD9UlJWBTw/QOMudSInVa/JBPScnStB5X8xgMvu02HmjzZ8ZPG0HonY2nLXmNdHC54595BosgPVqz7grm30CnI+dveJVVbHrCc8KjgnY0ucdHY0jYEC45smblfSRanBtAlRZGeXI09LjA7rAnpbY5m7WCa2RnofxlRiSdUVSUBLM8h9ptwFb5mY/w2N3AEFIQVN+GWz/TX4HAXSdymTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulk5PoT7nJRuTBmsvLflQ1eLmiiST8xPXSF1yYWB6z0=;
 b=Y9HmnpdXXBJ2XfRcieIP6/d7WCjJe1MuDie0jaO/s1Aw+rmcWGHQMNMZ2Rwk5410dbXp8H8RQ85UQ23/Glco3wD91Zv4H4znWh4phkMyKbSrDGOEijDSRuxffszagzENh+6N8E938ePlA7EZVfFy+OjC+c1YN5S23cbhV/3ImuRc5E/K979hScBS4c85iD0dBlN3PIrIN+vv3fVjZdKsbn5kw66xtNWodlkk2A8bW+9V5aixR/I4l4aZOOtoj2+jNGspnA8jbp5yqBlkNe7fRyG8E6CoDfG8vyT62u8omfCjTMSnI3GmIQ5lgytbePUPBb6muJXAmPG9a/LWXIXN2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulk5PoT7nJRuTBmsvLflQ1eLmiiST8xPXSF1yYWB6z0=;
 b=gLOK55XGfD+r363jchkZv3qOBdedf9C0HaXX6bpmi68BGRP8xLwySpMr1DZUpgQqvo+ky40aeqH24XLIYkxYMOMkclDn+TUbWZvzhCcqaUAEFlwkku/1oO+zkiueXHSfB2arK8wiO3JX3GimyTPlhOMEDKZnGbvqfclMMlFbiIA=
Received: from DM5PR12MB1308.namprd12.prod.outlook.com (2603:10b6:3:76::7) by
 CY4PR12MB1703.namprd12.prod.outlook.com (2603:10b6:903:122::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.17; Mon, 8 Aug 2022 13:12:49 +0000
Received: from DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::5097:87be:3557:c681]) by DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::5097:87be:3557:c681%5]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 13:12:49 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Greathouse, Joseph"
 <Joseph.Greathouse@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Enable translate_further to extend UTCL2 reach
Thread-Topic: [PATCH] drm/amdgpu: Enable translate_further to extend UTCL2
 reach
Thread-Index: AQHYqBujAPl+963e/UaGyikEBcQmUa2fFvqAgAXpx9A=
Date: Mon, 8 Aug 2022 13:12:49 +0000
Message-ID: <DM5PR12MB1308BA3B96EA1B4C0642910A85639@DM5PR12MB1308.namprd12.prod.outlook.com>
References: <20220804160158.937021-1-Joseph.Greathouse@amd.com>
 <7390b455-bd16-c1df-25fa-a1b1e3554a0b@amd.com>
In-Reply-To: <7390b455-bd16-c1df-25fa-a1b1e3554a0b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-08T13:12:47Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a31dd499-02c6-46fe-bbd7-0c05e2317433;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e683830c-eb29-4324-bd74-08da793fb168
x-ms-traffictypediagnostic: CY4PR12MB1703:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zCx9xgB4eUuJRukU9AtrPUT17yulo8Yy4i6CwdIS0aS/lXwtEF45vm/ALxufTuLLYhgpa5yYu0q+dDbIPcRXDIoASyv7AVFw9TbKuANmmV8IjNe+9QWWnW1GRRjf+9mAb4vTfiY8QG5rW3AJACuzttNKPhIr/1121mbqwR10HJfdJDHR4G9X51xEyDIUMtaDWR3M48baaVhw9/vA79IaZHvBdiB8Pu93+cPFeBQtrbfjLmsXdAaocCvXxRjea0M4AW5OfcUemGElXKY7rGeAIMtbKaxyVXizlZaR7w6ZwyJVVLqot9TLteY6RWqS8G9ltRIaH3Ka++J7MLgVM6BLw42/NieED0YkSC1HJiTMzohnNzukZfjhqDocauqTv28525fTE/bYqdFHd7XIvKsOR/vxqXHcPjv7kcXlL9rTIvjGmkPb7Nth4x3g6GiU3mngi5O8CXfkdFHUX6xab53+TkMzpPSVVlwUZSxxbQIxZEjhyo00Awn7ldUAYq4w5sYlDc3DoX24zKHtteo5arfuA+ed8P2UXcZpSSrEGsGg9byYBgr0tTgUBSL12pmSPXq6B7eK6222eUhSAC8MUU796C6yfty5WX5c2zoWqQPSuCz0FAQt2dmz4DZnI5+F5FZxZeufTzAmpz9N/UpKQcFywpqlzSZXXAyRJof0Q82nVoOV8LpqvOtMQ/jYdQJiU5Tru7a1SxRf8VhmTJvKxAMlCRiO9witKnmYpDmq1MAA2/fonlMsQS+J19o153InYK2Xv/YhFVzOUG3rOs84rWIDEvalSoZRLFyJ2zsoUD3htM4PQEvRffnEUiVhrydOJp5v
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1308.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(66476007)(66446008)(38100700002)(66556008)(122000001)(64756008)(71200400001)(66946007)(478600001)(38070700005)(8676002)(8936002)(55016003)(52536014)(5660300002)(110136005)(86362001)(4326008)(76116006)(33656002)(316002)(9686003)(26005)(83380400001)(186003)(53546011)(41300700001)(6506007)(2906002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vi96Z3ZFdlk3bzE5TmVUdk0vNG1YRmZjdmNISG9oSmlEdklEWWE3VU4rSjZ5?=
 =?utf-8?B?M1YreWViMUNqVnN5QWNncS9uUThaV0FpM0s3WW1KMm5yazdianNhOG9CcGtD?=
 =?utf-8?B?d3RGSE1RdHRudXVIbk53TTduYkZHbXUvR1lmZEJTbGV2aXFta2NEUElVaEt3?=
 =?utf-8?B?VlN5SXVhMXpFTVRxWFhjdTNzSmg4QzBteS9iNDBsWWlUSEJUUTU3NEJ5c3dD?=
 =?utf-8?B?UG5WcFFhc2xGWGxxSitGODM0YkNWMkRwUHc1UnZKWlc4Mit3UXlZRjkxQWNL?=
 =?utf-8?B?QWVJVkJmbFVFdVgzcUxpeDhsZ1pRbndyQkdoSU1xdDNoc0NqbHFYTndzamtP?=
 =?utf-8?B?OStTa2tZODlPNFlzeVhJampjWXo3eDNBL1FJbmJ2VW9SZUJ0cXZSclBUc2tL?=
 =?utf-8?B?SnEvZm1jUW5BeWZJOVpSa3YwL2xsbnRtWThNZXViVHd6RHJ4MGZQNmNBa2lq?=
 =?utf-8?B?UWtLbjJBZVFKS1grdFo1UVpLZFlBT0N6RFZrNk94Rmh5clpvd0lCTytEMVZv?=
 =?utf-8?B?L3l6K1ZlYVNPeDRjRWtOc0pWVVoxT3FUS2hOOVR0UEJjaXZKNmpGZDc4Z3Bz?=
 =?utf-8?B?SzUzcGRNNnF3d21KN044NS9TbmZXbEhkenpJU3hHK2ExM0o4Q0wybExiMDFR?=
 =?utf-8?B?WEpBTlExTGZxcDRzUDE2OElBSzYrdDR3bFpYT3U4MnVWclBiZDBjeHJWc1Aw?=
 =?utf-8?B?V2R2VXB4Z0xma1k3L2svSzFHQWE0SGRnWW16OVNEUW1rUi9hNHFPN0VYb0gv?=
 =?utf-8?B?bkE3b211eFR2TytjU3AycENKNG03c0ZWWDMzNXNjT1VLOFdtc0dMSWd5QmVU?=
 =?utf-8?B?dTdxbEE0eFpIOVVqSDlxRTNSaVh3dWtGdjUyYzIzNUd1RWRwUHhsUFpnWHVk?=
 =?utf-8?B?ZmVXU1lnV2FKVUx4Sis3RTBudUxESlpCR0VvNXJqUC9oWXF2U0wvMFIxb3ho?=
 =?utf-8?B?aGJFMEp1Q3RlRkJkY1FNVFFxVnhEUFZtZzVnVjJpUTJmMk8xMUl4ZXMrdmhO?=
 =?utf-8?B?MXFBTkl3QmRiUWVISS80eCs4MmxIMGN3d1BidmoyMVVHTGl2bnNVWitjYWQ4?=
 =?utf-8?B?U2ZpaVNBNThMM2ZSc3M2VnlwaTYvTlJhWUJieFBGa21vdENic29VUk55WS9R?=
 =?utf-8?B?UThycjZkZ3RZOGVsZWZ4VGQwSk5WQi9tcU9mMW9rYU9tTkYydzQrV2lENlB0?=
 =?utf-8?B?OFRMbGpURVlKV0FGNnZsRmNWYUFYbVdUdFVXYWVCSk1SNTh2RGhGN1ZiV0dW?=
 =?utf-8?B?d0xvTzRzVlJneVlWdnpYcGdESGNXcUF6Uzg5ZEFBcktPVnRxQndaL05qT2dw?=
 =?utf-8?B?TU43NVVGenF6YW5VQUxxR3E2T0FrSnA4SThLdHVKN0lmcnBaWE5kbGZkTG5t?=
 =?utf-8?B?S3duNFlNNDNuK0NaSDlhUXIyOW5jYzZDaEdCUGh5SkU1aks5Tk5RdXdSQTNy?=
 =?utf-8?B?ZGJ0dFNPUVN2NVlaZ2RlclhQRTVhRUxlYXlsRUJkcUxlOUhyV0VtUlN5aXNz?=
 =?utf-8?B?USt4cVhCMk1DU3FSNHRWdVM2ZTVYcGdCVmx6Y3EzMk9PQkpWM2pjcGcvMHRB?=
 =?utf-8?B?bEZqQ3NkSDdQL2poNHFXVVd6SU82SFpvdHp2Ny9OQUx4c3lZbWdjVklROWFF?=
 =?utf-8?B?KzZxZmRvK3VjbnJLbXI0SHczd3B1cWtLSitDVE5rMkNENWkxalZGMDlHUTl2?=
 =?utf-8?B?b1dVT3RoVGpHVFM1QUVMRXFzREpTblkwQVpqSWNvSE1mdUhoNnp2ZktNWlFB?=
 =?utf-8?B?MHFFZWV2QldKTktjQkcrZDZ3Qk1NSmUxS1I1aFowZG92Rzg4QUJWdW1BRW41?=
 =?utf-8?B?UU5IRWliODhXblFzVHgyNkJGdEQxYlU2R0hvY1ZYTGtNN1JmVU5OV3g5Sit1?=
 =?utf-8?B?MkVWbXRGWk5lMGI5d1E0dnBpdFhGNTBrdXgxRmFmTUxqZTdMUjVuVkVEcnFO?=
 =?utf-8?B?eW9uOWptNXNONUoyK05VUW9xYnFmb1hHVG5VcjdsdVlJQXUyNis5SThEQ0lk?=
 =?utf-8?B?d0J3SkMzemp5Wk9yaWd4dDJjd2hsazRDOUNqL2xEcXhCWmpPUGpSRDhTdUhE?=
 =?utf-8?B?NGpmWTNGQk1NSHFPekQzK1NIK2VOK1p2cmJmazc1dVo3WHZDNnd1N01ybFU4?=
 =?utf-8?Q?wclk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e683830c-eb29-4324-bd74-08da793fb168
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2022 13:12:49.2366 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1wFbN7AKZKPBGSZXoeqDYABgmpLeMfzT2gPscG8lf6CeSmYZ0/ykIhKbOXMbXfyfPYwODTLkaa85v/VT8S/blQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1703
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCllvdSBjYW4gdGhyb3cgYW4gQWNr
ZWQtYnkgS2VudCBSdXNzZWxsIDxrZW50LnJ1c3NlbGxAYW1kLmNvbT4gYXMgd2VsbCAuIE5vdCBz
dXJlIGlmIHRoZXJlJ3Mgc29tZW9uZSB3aG8gd2FudHMgdG8gcHJvdmlkZSBhIG1vcmUgY29uY3Jl
dGUgUkIuDQoNCiBLZW50DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
S3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KPiBTZW50OiBUaHVyc2Rh
eSwgQXVndXN0IDQsIDIwMjIgMjo1NCBQTQ0KPiBUbzogR3JlYXRob3VzZSwgSm9zZXBoIDxKb3Nl
cGguR3JlYXRob3VzZUBhbWQuY29tPjsgYW1kLQ0KPiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQo+IENjOiBSdXNzZWxsLCBLZW50IDxLZW50LlJ1c3NlbGxAYW1kLmNvbT47IEtvZW5pZywgQ2hy
aXN0aWFuDQo+IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0hdIGRybS9hbWRncHU6IEVuYWJsZSB0cmFuc2xhdGVfZnVydGhlciB0byBleHRlbmQgVVRDTDIN
Cj4gcmVhY2gNCj4gDQo+IE9uIDIwMjItMDgtMDQgMTI6MDEsIEpvc2VwaCBHcmVhdGhvdXNlIHdy
b3RlOg0KPiA+IEVuYWJsZSB0cmFuc2xhdGVfZnVydGhlciBvbiBBcmN0dXJ1cyBhbmQgQWxkZWJh
cmFuIHNlcnZlciBjaGlwcw0KPiA+IGluIG9yZGVyIHRvIGluY3JlYXNlIHRoZSBVVENMMiByZWFj
aCBmcm9tIDggR2lCIHRvIDY0IEdpQiwNCj4gPiB3aGljaCBpcyBtb3JlIGluIGxpbmUgd2l0aCB0
aGUgYW1vdW50IG9mIGZyYW1lYnVmZmVyIERSQU0gaW4NCj4gPiB0aGUgZGV2aWNlcy4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEpvc2VwaCBHcmVhdGhvdXNlIDxKb3NlcGguR3JlYXRob3VzZUBh
bWQuY29tPg0KPiANCj4gQWNrZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0Bh
bWQuY29tPg0KPiANCj4gDQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nbWNfdjlfMC5jIHwgMyArKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNf
djlfMC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYw0KPiA+IGlu
ZGV4IDIyNzYxYTNiYjgxOC4uYWI4OWQ5MTk3NWFiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nbWNfdjlfMC5jDQo+ID4gQEAgLTE2MjQsMTIgKzE2MjQsMTUgQEAgc3RhdGlj
IGludCBnbWNfdjlfMF9zd19pbml0KHZvaWQgKmhhbmRsZSkNCj4gPiAgIAkJCWFtZGdwdV92bV9h
ZGp1c3Rfc2l6ZShhZGV2LCAyNTYgKiAxMDI0LCA5LCAzLCA0Nyk7DQo+ID4gICAJCWVsc2UNCj4g
PiAgIAkJCWFtZGdwdV92bV9hZGp1c3Rfc2l6ZShhZGV2LCAyNTYgKiAxMDI0LCA5LCAzLCA0OCk7
DQo+ID4gKwkJaWYgKGFkZXYtPmlwX3ZlcnNpb25zW0dDX0hXSVBdWzBdID09IElQX1ZFUlNJT04o
OSwgNCwgMikpDQo+ID4gKwkJCWFkZXYtPmdtYy50cmFuc2xhdGVfZnVydGhlciA9IGFkZXYtDQo+
ID52bV9tYW5hZ2VyLm51bV9sZXZlbCA+IDE7DQo+ID4gICAJCWJyZWFrOw0KPiA+ICAgCWNhc2Ug
SVBfVkVSU0lPTig5LCA0LCAxKToNCj4gPiAgIAkJYWRldi0+bnVtX3ZtaHVicyA9IDM7DQo+ID4N
Cj4gPiAgIAkJLyogS2VlcCB0aGUgdm0gc2l6ZSBzYW1lIHdpdGggVmVnYTIwICovDQo+ID4gICAJ
CWFtZGdwdV92bV9hZGp1c3Rfc2l6ZShhZGV2LCAyNTYgKiAxMDI0LCA5LCAzLCA0OCk7DQo+ID4g
KwkJYWRldi0+Z21jLnRyYW5zbGF0ZV9mdXJ0aGVyID0gYWRldi0+dm1fbWFuYWdlci5udW1fbGV2
ZWwgPg0KPiAxOw0KPiA+ICAgCQlicmVhazsNCj4gPiAgIAlkZWZhdWx0Og0KPiA+ICAgCQlicmVh
azsNCg==
