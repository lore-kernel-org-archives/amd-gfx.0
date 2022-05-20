Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A5AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 14:12:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10F6A10E2BE;
	Fri, 20 May 2022 14:12:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4031910E1B5
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 14:12:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+pQMUGBdGYlxAwru3dN19tnSGRCL5fh3pHmQQuml0d+hVRQbOiZjAHpxQB9gOesGNRu5243V1qUXEjCbrySHvWNFekHcLLHH8I2gnXh7k0Q0CyfrYex0A8m2nVPSYyVDpRM8O6O20zCiUUC9SV670AhzE6U+ydjYMoH5p70czlmAU0hembGtUgr4ERyW5upbkxZjb0aULBdnQfK8j9TZFgRuz2vshWWxfoDkKKWkB+4FYQQk1IJPK502PIvJF91K3Qqcc5njoUq0FVyRNAb8F+KZlghBaL82QnQ9MsTqMaWkHEeuXtz6CBzPlwKhtJYNEMmC2gLYlEfxWkXyGF8AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owUjdQbsKBpenId6SklpzQDiMX0CQ3EFYo57nbLwL0M=;
 b=oBS9BM4SEewWhkUnLRbEE94Ap66HZKLIzDtsWMhctuYijZhR8kdKLrGX9ax70psvfkaCdKKlRgQU+f5ZO6MSpaa3NzRm5oc/ES6DC9KaX3em9DYIlc8ktvGvCODUht2q3uMow8S/MsAnBTPNvReAfSe3xTgbkg9i72vTOECWvGDHr8BXoKYT+FcvAluNusJONgPabSlarjOhOxGMpMRYQiZWm0vaWqIlk0h3ikQG6yHmvf3rmaMMQ6F1QEuhyFfjM3ui5/Pq6D5qAzCSFOpe/MYwtlFCGp2wzxh0qX4Amp+yv7yVKuEptOqZUSE+3HZW4RVr44D5DcmXGvqoXo9wQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owUjdQbsKBpenId6SklpzQDiMX0CQ3EFYo57nbLwL0M=;
 b=Im9X8mCifsBJxNHiQwR7LM5gHgo6XICMeZT91rjfMAA3iby1qCQ/nlyeKGf9jMMuOn+Un2AscNVB93xrp2rUONhupr0PkxgVMqcDvG0IiNeHcEZRcrd/TCKdzRKYt9KUqNmGfzTRLk0RJr76cO/ZnwE2M32eqWn4wFJMc/qCV/M=
Received: from BYAPR12MB3094.namprd12.prod.outlook.com (2603:10b6:a03:db::23)
 by LV2PR12MB5773.namprd12.prod.outlook.com (2603:10b6:408:17b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Fri, 20 May
 2022 14:12:45 +0000
Received: from BYAPR12MB3094.namprd12.prod.outlook.com
 ([fe80::b08e:4c04:5879:dbf]) by BYAPR12MB3094.namprd12.prod.outlook.com
 ([fe80::b08e:4c04:5879:dbf%4]) with mapi id 15.20.5250.021; Fri, 20 May 2022
 14:12:45 +0000
From: "Slivka, Danijel" <Danijel.Slivka@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: Skip init fbdev if virtual_display is enabled
Thread-Topic: [PATCH] drm/amdgpu: Skip init fbdev if virtual_display is enabled
Thread-Index: AQHYbB+SK0uoad3LWUmZOOWrvQVkA60nwwaAgAAFOeA=
Date: Fri, 20 May 2022 14:12:45 +0000
Message-ID: <BYAPR12MB3094F87BED21F64FE5BD4C4798D39@BYAPR12MB3094.namprd12.prod.outlook.com>
References: <20220520075932.186691-1-danijel.slivka@amd.com>
 <CADnq5_P8p5zKiW20xek0M0DVs+YRDX6qcy+b01NWXP_NUs9O5Q@mail.gmail.com>
In-Reply-To: <CADnq5_P8p5zKiW20xek0M0DVs+YRDX6qcy+b01NWXP_NUs9O5Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9a208fff-1b76-49d0-968e-b57dc926793c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-20T13:48:12Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26106090-4138-4454-f617-08da3a6acffc
x-ms-traffictypediagnostic: LV2PR12MB5773:EE_
x-microsoft-antispam-prvs: <LV2PR12MB57732208893E3E5BE17F5EE298D39@LV2PR12MB5773.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s2IvX+JZDGUnSVJEMruUeXZ5FZuRkNoEKiQoehSpWLIU0Pwk8eQqrwrC4ww2/eLBhzaKqmKKFxzCPoBtrVdxqASz4pTS1JjWibvNa6s3GTAIzQ4PZTIpqnXTwrEPt4IZigy6Cc8dwwO8ciUFFOs/01s1/vryNgcigCR2/gdUmc1Y1qpxNlxRakJDTTy2VP+QlEK6pOWShs5KmD2wsZ99vJSVXsBYPEu+o9lmhVMZGazNfuRVPtNTv5sov/iXRil+EvCFOxuCecDkG3os2rksMPSZHSpbH5RHe0WgqyWRL7+d47RCvXU1dgQo6hb2fPXLSCwUqzqpaIGnBaCUeEZhKb07o3y0PP8pE9mRE4hNHuQCZJKgdEmePRT+8eJCQo0v+Ety0Ac9lB8JOelpqzfh7632AzqyJbQG/a+Dk4BmGoBJQewC4k7pW4fCJKbzIsRPP06whly3rqFoqYsxXYnxw5Okmw0LcY9syaSqap0a2nzU0ulgXtb3idkMDQ4e4tV+DmqYZzQWW2JyNSt5y6M2awRqK6htO7rAUtH/LWUnIvB0QsvxUcOVRH33sOB5aEYNdDQqdY0xzNzZ53xoaoivgOyzlWgXfEoqeh0yO8Ksk+UYrqVfeica/pECJisSueamZ6nbkHLi22Ztqx82pvc6venv8bGKNbxnhhb2d0mTbRzd/7TW7CsVI3b9FjpoNlZmlGizhGpfOlPwXjKouCwfMw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3094.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(508600001)(86362001)(186003)(5660300002)(38070700005)(7696005)(53546011)(8936002)(55016003)(6916009)(9686003)(2906002)(38100700002)(64756008)(83380400001)(33656002)(66946007)(26005)(66446008)(66476007)(76116006)(8676002)(66556008)(4326008)(71200400001)(52536014)(122000001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cCttSFRnUDMwU2U4OW85d0ZFcjhVUmVVdmVGYXdwbmE3SjBxQ295TzRiYUNx?=
 =?utf-8?B?SzVVc0JjWUc3cVdVY3JRclNrYmhFcm1HT2F3KzJxNGxRTE5IV3djK3prTDV2?=
 =?utf-8?B?cGtPVkJKQVVqQm1zR3BEc0xVMDluWGZTRDl0eW00RmZ3Z0pUZDBEZGd0MDlt?=
 =?utf-8?B?OFo4b3pSYmhJRGlDNmJNSmx6MnRpN2lFaCt2ejFKMjF5NmMxK01YV3liUDdF?=
 =?utf-8?B?NHFQNWp5elk1RjJnc3F6SlZ2UHFUSGxnaFRqN1NtNmk3Z3lnTGVmZ3IybEls?=
 =?utf-8?B?VzJ3VkljVE9iajJEN2tvR3JlT1hMVFRwb3h4QmMvTU1kTmlaVXNEaHFTTGkr?=
 =?utf-8?B?YjZVN254Sk1CZXM4MkgwRkdwZWhBYnV3UjBMUTU0RXZmUWZDU1NUbGhUOGw4?=
 =?utf-8?B?aUhaaGNaUk5vVkdFcDVBRGRsYnU2MXJ3TjRtUGhMSGlhQW9oNGl4eU1yQ05S?=
 =?utf-8?B?MURrOWh3MlRyd0JaSjlzeDYvcUh3TkJMdkZVcEZlL2JYNFM5MkpuWUN2Vmto?=
 =?utf-8?B?WDJsWWlsbVhiN3RYZ21OR3AzdHhlS2YxZ1hGdWxKbUl5bTIrcnF1MmNnZG9G?=
 =?utf-8?B?MmFjZlAyM2JRSzBWTlhkenk4bWdncHEzMXoycjBveGhGQzVMRFJaQklvMUFC?=
 =?utf-8?B?ZGVyWldyU3VQQjI2YncyS3lZSG9kWFlqamdLSC94M3d1WUNseGtHOFU0QzJm?=
 =?utf-8?B?ckp0ODFFNmQ5UktsK2V3ZUV2Q3UxWDV5Y0NDc2EyaTVhWmRPRXVNZXdIQVFt?=
 =?utf-8?B?Tkl2cXdjR2NVNXRIMjFaWVcvelh3UU5oMVNZQlR3QkNBSVBtZVZjem96bkNu?=
 =?utf-8?B?dThxakg5RmFqcW5hOVEwZmQzbWhKQW9qMThQKzZ0N0kwdkdVMnFaN2NxNlZo?=
 =?utf-8?B?NFlKRkVjNW1Ybnkyc0VtZzJNMDQrWUpxYmNSMWExclVHMTBRVVFKbzI4VnZl?=
 =?utf-8?B?Mkt2ckVyYUovdTgvVmc5S3VSdGdQazlIdlVwUVEyYm1jRUxRUzZUTWhCN1p2?=
 =?utf-8?B?OGZOQWdlMW5vMjFCUWpVZmJTcHlvSjhNL0RKd09ueVJSQ3AxZDkwM3pPTGxT?=
 =?utf-8?B?WGhQRmF3K3BpOXo1elR5YmpISXY4enpCaWUwWm9rMDFiTFpMS0VJSkhrTm1G?=
 =?utf-8?B?RVJrSk5VK1dxaXV3V2tPYXhKNjVXYTlnZjhrSlA3NG0zSEpvcEUzQUFCdGpE?=
 =?utf-8?B?TnV3djg2QU5jamtVN0FXVnM3UWN1NEVtWlBOc2RmSUoxVk5EcEx4djBGb1ZB?=
 =?utf-8?B?RzN2TzlWNG5KYS9TYlkrem85dGFLRkRweXA3dWt1SG45MFdyd2NFQm51eCt6?=
 =?utf-8?B?VjhUdzE5L0JsVHNWY3cvOUhvMGlXSWJRYkkzZnBkZFVIUVJUYnpMTUN4M2Zi?=
 =?utf-8?B?UVVMajhmVnNDWlF3QjMyVGkvakF5S1lDdXNHckdJYmRuUnpnL21lbE0waEZh?=
 =?utf-8?B?RVJjeHRjVlpsQmVESGI3V2xxZUZ2ZFc2VlZmelE0d01wWEJWRzl5N0toOU9O?=
 =?utf-8?B?VVV1S2h2NURyZVZ6TG81MnlnZU9pZ2JaSjd6RXJpNzhLb0kza2swNWtqY2Ux?=
 =?utf-8?B?dXFsWHJiUFFWRWFhYzFZeHUyczNsQXRFL0lGVkN6cWpHeUZidDN0M2lMSXlK?=
 =?utf-8?B?YldScGVWNjY3MDJQUGlxLzhwSmJCRFc5eFdseXlORVZXdTZEWWRSZ3gyQ25V?=
 =?utf-8?B?THB6TFpWVXV3MjF6N2Fad2drRVRaeWRkWDlJMXJkSmFQWU00S0ZoWThneXlX?=
 =?utf-8?B?MTdXVGI5dGpFcnFlUU5SM0VIaGJZaXdvY3JTTkU2dGZveG44aFFubk5Lam1X?=
 =?utf-8?B?Zm1BL3BUSFhIWUlXSTB2SGIzOWtOUDhqVWZSOE00ekZDMzk4KzI1RWVTS0dh?=
 =?utf-8?B?ZllyVEt4SDViZUpmcGpxblNicXZYUUZ0SGtNQ1BTZVlMcE9SNmVSY1FmMXdZ?=
 =?utf-8?B?Q0NYWWtvbnFWZCtEUGNFRGtrOXo0UGhBUWFCK1M0Mi9wVkY3a2V1Ky96V1FH?=
 =?utf-8?B?bHkvY054QTMwN2lyc1BkTFNWSmp2TVZac2NxdjFoVlAzeEhLMHc0eElCaXpp?=
 =?utf-8?B?UG90dnlFeEJUM0dYMnpmN1RnWVk0dWg3NUlyUlVXNUl4alkxQ2k2cEpFVzhI?=
 =?utf-8?B?bVhqSmR3VDNIZnYwZm5BUmhnWkRDcnNaUnhFKzlUYlRjQjBVM0lHRFQvdWV4?=
 =?utf-8?B?NVpkSHpEZWZwV0dPaXAwN2c3MnlLM3QyeUdJU0FSMjA5RVpYMDFUL2p5MjNI?=
 =?utf-8?B?T0VaTmFaSTdrQnpvMDFVTFFvTnNwV01TMWthSndyb05pN0Y3VGdGL292bnRU?=
 =?utf-8?Q?0iSqmLsrSSzVY7GeOE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3094.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26106090-4138-4454-f617-08da3a6acffc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2022 14:12:45.6127 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AQjeKo7W90DLGCVhRTBN+KhFy0zqpkvarLA4Q62grgZPShprrW6FEZhIaVroCPwXEgAMtfPfEfNLLu+fM4ZMfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5773
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpLA0KDQpCYXNlZCBvbiB0aGUg
Y29kZSB3ZSBzaG91bGRuJ3QgaW5pdCB0aGUgZmJkZXYgb24gaHcgd2l0aG91dCBEQ0U6DQoNCiAg
ICAgICAgLyoNCiAgICAgICAgICogMS4gZG9uJ3QgaW5pdCBmYmRldiBvbiBodyB3aXRob3V0IERD
RQ0KICAgICAgICAgKiAyLiBkb24ndCBpbml0IGZiZGV2IGlmIHRoZXJlIGFyZSBubyBjb25uZWN0
b3JzDQogICAgICAgICAqLw0KICAgICAgICBpZiAoYWRldi0+bW9kZV9pbmZvLm1vZGVfY29uZmln
X2luaXRpYWxpemVkICYmDQogICAgICAgICAgICAhbGlzdF9lbXB0eSgmYWRldl90b19kcm0oYWRl
diktPm1vZGVfY29uZmlnLmNvbm5lY3Rvcl9saXN0KSkgew0KICAgICAgICAgICAgICAgIC8qIHNl
bGVjdCA4IGJwcCBjb25zb2xlIG9uIGxvdyB2cmFtIGNhcmRzICovDQogICAgICAgICAgICAgICAg
aWYgKGFkZXYtPmdtYy5yZWFsX3ZyYW1fc2l6ZSA8PSAoMzIqMTAyNCoxMDI0KSkNCiAgICAgICAg
ICAgICAgICAgICAgICAgIGRybV9mYmRldl9nZW5lcmljX3NldHVwKGFkZXZfdG9fZHJtKGFkZXYp
LCA4KTsNCiAgICAgICAgICAgICAgICBlbHNlDQogICAgICAgICAgICAgICAgICAgICAgICBkcm1f
ZmJkZXZfZ2VuZXJpY19zZXR1cChhZGV2X3RvX2RybShhZGV2KSwgMzIpOw0KICAgICAgICB9DQoN
CkZvciB2aXJ0dWFsaXphdGlvbiB3ZSBhbHdheXMgdXNlIHZpcnR1YWxfZGlzcGxheSBhbmQgZG9l
c27igJl0IGhhdmUgdGhlIGh3IERDRSBmb3IgdGhhdCByZWFzb24gc2V0dGluZyB1cCBmYmRldiBz
aG91bGQgYmUgc2tpcHBlZC4NCg0KDQpCUiwNCkRhbmlqZWwgU2xpdmthDQoNCi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNv
bT4NClNlbnQ6IEZyaWRheSwgTWF5IDIwLCAyMDIyIDM6MzAgUE0NClRvOiBTbGl2a2EsIERhbmlq
ZWwgPERhbmlqZWwuU2xpdmthQGFtZC5jb20+DQpDYzogYW1kLWdmeCBsaXN0IDxhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZz4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IFNr
aXAgaW5pdCBmYmRldiBpZiB2aXJ0dWFsX2Rpc3BsYXkgaXMgZW5hYmxlZA0KDQpPbiBGcmksIE1h
eSAyMCwgMjAyMiBhdCAzOjU5IEFNIERhbmlqZWwgU2xpdmthIDxkYW5pamVsLnNsaXZrYUBhbWQu
Y29tPiB3cm90ZToNCj4NCj4gSW4gY2FzZSB2aXJ0YXVsX2Rpc3BsYXkgaXMgZW5hYmxlZCB0aGVy
ZSBpcyBubyBodyBEQ0Ugc28gbmVlZCB0byBza2lwDQo+IHNldHRpbmcgdXAgZmJkZXYuDQoNCldv
dWxkbid0IHlvdSB0aGVvcmV0aWNhbGx5IHN0aWxsIHdhbnQgZmJkZXYgZXZlbiBpZiBpdCBpcyB2
aXJ0dWFsPw0KDQpBbGV4DQoNCj4NCj4gU2lnbmVkLW9mZi1ieTogRGFuaWplbCBTbGl2a2EgPGRh
bmlqZWwuc2xpdmthQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2Rydi5jIHwgMSArDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykN
Cj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYu
Yw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiBpbmRleCAz
YjlkYzE4MDNiZTkuLjhkMDNlZWM0OWVlZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kcnYuYw0KPiBAQCAtMjA5NSw2ICsyMDk1LDcgQEAgc3RhdGljIGludCBhbWRn
cHVfcGNpX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LA0KPiAgICAgICAgICAqIDIuIGRvbid0
IGluaXQgZmJkZXYgaWYgdGhlcmUgYXJlIG5vIGNvbm5lY3RvcnMNCj4gICAgICAgICAgKi8NCj4g
ICAgICAgICBpZiAoYWRldi0+bW9kZV9pbmZvLm1vZGVfY29uZmlnX2luaXRpYWxpemVkICYmDQo+
ICsgICAgICAgICAgICFhZGV2LT5lbmFibGVfdmlydHVhbF9kaXNwbGF5ICYmDQo+ICAgICAgICAg
ICAgICFsaXN0X2VtcHR5KCZhZGV2X3RvX2RybShhZGV2KS0+bW9kZV9jb25maWcuY29ubmVjdG9y
X2xpc3QpKSB7DQo+ICAgICAgICAgICAgICAgICAvKiBzZWxlY3QgOCBicHAgY29uc29sZSBvbiBs
b3cgdnJhbSBjYXJkcyAqLw0KPiAgICAgICAgICAgICAgICAgaWYgKGFkZXYtPmdtYy5yZWFsX3Zy
YW1fc2l6ZSA8PSAoMzIqMTAyNCoxMDI0KSkNCj4gLS0NCj4gMi4yNS4xDQo+DQo=
