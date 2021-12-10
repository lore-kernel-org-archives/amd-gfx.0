Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBF1C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 09:51:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3400310E228;
	Fri, 10 Dec 2021 09:51:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1057810E228
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 09:51:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1Lk0uQ696qsEaATgcYOU7FNFt+Wer5LdF4e7JPCsALQjr3ahoInjjXk0KmJ8u2FljwroSDZUtCCFiC+CsAMRbM5/X3s3/aJbAUWE6gU6NhgNT6UWxPJTtTSx3ZSzspaMObcPkMdZbYX4Pc8BzKMnt8U8sx36DJF6hYD4B7ZVKWnBfeHcn788xNZEYd86t7igfmdr+HjhsTmSx9hzF+eLSAIryyFMWN7UpuwF0mXD6Gr/nhFLBnBwZlP7vVEXzCXuqC6ZWnGgE0yTTeLZNIiYbaNYepB5CGZ/CkNLnGzaJzq1zhhFvQYpCiJpmBP1aphC6AMlPLf8QKi+xYx7DMhiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GSnk+1ac1q8EQZLTQ2tGowaVOPiej7lTJaXLLX/J/w=;
 b=GkfbWhCftlkOJvQ9A6P4NM70NR1HB2HJOmsA6CDAwATo2D0ndEP3Dtg0FD2AYVJckbe67ifXavfpmhXUSscMgb2qfnyFjyPyA5PqYOao1UOUUYNP0tYACTiAV7OpILiaQ+x0WMfaSv1lXLVUhpkdpngDcxOf/lxcv1Iol/EHto1xFfHdvUV7h80xf+phftd05LE+UW/3+qvNJ7SdB98jxxGA6qItDDMeA6U7Ayn+ngPsWjfJgXDQo2of0jQwgpNlUDT48krLrvrG9cfxeLrUuqVDPUNHIus+FV2KJj8/w3YyWYvenPRyJUNkCu95JmsKb4HCA8Bfi30veeAAhrVILw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GSnk+1ac1q8EQZLTQ2tGowaVOPiej7lTJaXLLX/J/w=;
 b=yCixgV+L41cK0S0Tn1cnEGI5QsNuBRu9jXyfL3Bo+w2tQhDflRJ652yskS0/p18oC+3CBfTvAi2Zd+Fhb53Oqdcvpo77qe17ZKef0MrarmPSpHhPXluHE2dNwqO836vyf2EsX+o9H4ORtrLV7usbcqJHvcfnZaeNqwcEz05KvdI=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2357.namprd12.prod.outlook.com (2603:10b6:4:b7::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.24; Fri, 10 Dec 2021 09:51:32 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4778.015; Fri, 10 Dec 2021
 09:51:32 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V4 11/17] drm/amd/pm: correct the usage for
 amdgpu_dpm_dispatch_task()
Thread-Topic: [PATCH V4 11/17] drm/amd/pm: correct the usage for
 amdgpu_dpm_dispatch_task()
Thread-Index: AQHX5/LCXM/kvUzUqU2Izk2yzEedmKwqIwgAgAFf8jA=
Date: Fri, 10 Dec 2021 09:51:32 +0000
Message-ID: <DM6PR12MB261944A3DD9064E8B5A4E56EE4719@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211203030540.1710564-1-evan.quan@amd.com>
 <20211203030540.1710564-11-evan.quan@amd.com>
 <de6fa79a-9c32-3365-9f8b-7c9fc56d0277@amd.com>
In-Reply-To: <de6fa79a-9c32-3365-9f8b-7c9fc56d0277@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-10T09:51:29Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=c43ca739-8bd0-4c1f-8952-53fa9c1f50f9;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd423ea6-ffb7-43ad-a105-08d9bbc2a5c3
x-ms-traffictypediagnostic: DM5PR12MB2357:EE_
x-microsoft-antispam-prvs: <DM5PR12MB23570DE38A79C739AA325261E4719@DM5PR12MB2357.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T8yEFE8KLjN9hJNp52pH7rTiUpHf/coUF+UK1/zPtVshzBneAjpYZSeL3y+8YzUaNtRVrXFnQzvJlB670uta5xGs4ToV9WsH5KGJ2q1Va/S9NT5rJbLS7TbeCKzxFVtSQZDJ29RZmNuT7zoJVBAQr8u4t74rpYp+lYGvg21qA2e1fTtDcchlTPj5RW/eMYz+/V4iv93xxY9JAlgKfHE2splCJZMMv24GSVmi9ya/yAUDw9aewDx/QV9jLi76FWcFL84LLXM8ChTWLZJ1ED92ge7UTi5/IXD6XBBAw74OZ6NmW4IMqyyUJ1jqrrXJByv9kwVn9agPKucNUvGr3mIGQcOvO8awi1fRaieCtNH+Hn1sJ9KbT4VjVbUh2zUVctHlxUJGOlvD1q2EASxmoXYadthNAss1Esesqk89OXLSxoXL3t/J2hDSHNoEXBvGD6anbv1xydST4zTWcAvzCSSYoxawhLFHQ+7UdO2/n3WIJu+8W4A9EBX8NSJNtyQvcVdqToXvZ4ipQEq9HN3IsKO28JZ4gUt3y+3Yt6L9IPg5cuGnGEUpxneYrai4MGRNSSPxOyiOnJhlv523v2qZIYei7R7Qn32oCJJF7LfC/qEq2+Q4RV9LaODSut1/Qx4KUYJ/o7qqt5WOlFQT45azeUIpx/wixAzpnqOD/f1+iO3WENA2myJm8RE87UpyjSf4ZDDsGfP0t6/eGOQ0ftcupPUToQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(64756008)(38070700005)(8676002)(7696005)(508600001)(33656002)(122000001)(53546011)(76116006)(66476007)(8936002)(4326008)(55016003)(5660300002)(316002)(38100700002)(86362001)(9686003)(71200400001)(26005)(110136005)(83380400001)(2906002)(66946007)(6506007)(54906003)(66556008)(52536014)(66446008)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUoyb0lsL1F3TjduMEJZVFNzUnVUOVRDZTdQSWZVWmduMmplclF2T3lJV3Qv?=
 =?utf-8?B?a2ljOFViZzU0ZG5jb0drNlRnWUVLLytxZkw0WU1BbjBJUFBtam45MTd5VHJE?=
 =?utf-8?B?eWNCSjR6VWN1R2luN2xZYmc0TFRGN2VTVjQrczZwUkwxQ1hOM0VmcXdUSzF5?=
 =?utf-8?B?TDk4WG9iTkxFOUFydGdiMFNvb0VJZ2JxdXFmSVFhS2c2bmFlM3VNUVMxcTUr?=
 =?utf-8?B?RC9HZ2tFYjdzRCtxaHp1OXE1OVNTOU03N3VLUERXR0EvOW9yN29XcDN6eDV0?=
 =?utf-8?B?QTRoWVQxeUNXTDVvZkRGT2ordWYrbTA3SlE0MXh6Zmdva1dJdG1rUExtWlk3?=
 =?utf-8?B?SDg2VWpMd2FuWUw2bkJMajduUWpaWDJ5SUdKc3Q3TURoLzdzWGU4SXUzSkxm?=
 =?utf-8?B?R3dKWHE4UkRLZENJRDJLb1dDbzJ6cTJxVjBXcnlYNjFWVGYydVJqZEN1VER6?=
 =?utf-8?B?YlNoempvMGlmN2Z5cXhHbVZLL0lnVmU0aWRWalZwdEVNeGFiMC9jKzlkcFhR?=
 =?utf-8?B?QmllM21xbnNDUGZISThyRi9ibitvVUcwMVV3Q1BUV3orMzBka2lNeHRPNTVE?=
 =?utf-8?B?ME42SmVuYUZZNWFpbnU4RHVoekp1Y2xsdjE4TGM1RXZMZklndUVjTkJPN3lX?=
 =?utf-8?B?bTdaTzRmOFBsdkR1Y0dRYUJYR2FqMEdUYmxoLzV0S3JmVEZ2elJtbDNsQmZY?=
 =?utf-8?B?T0lIcHpmNXVoa2YzazJlWStlUDhwUEgwMk9HRFUwdzVFS21OMUg4Ni9ZNWQx?=
 =?utf-8?B?VVRwVGl3UWZFSVdobkRwd3VkZExEbzVWZy9FNHdUOGZaMlhJKzg1NmQrRTNK?=
 =?utf-8?B?Um5ld1k1czl6Q2dTUk0wRGpWUGtweW1HcUtRaHc1Yk4rNUcxOVdnZTluRTlW?=
 =?utf-8?B?SzU0dk5UU2JXRVA0WitySXc3SFM3N3hVUWlQdFQ0REJQM1dZK0J3MGdjQ2FL?=
 =?utf-8?B?a2VjZTNpZnQrMURxQUVSd1NWbERqcElXdStmNFVaT25OOHg0d1cvdWxnbVNx?=
 =?utf-8?B?RXFQMmE3ZmlIVnBRZUlIblRhUVk3djNJZkYwcVMwSmU5OXV1cWxDaFpuVTIz?=
 =?utf-8?B?d042bjZqSGxBYitIY2QrSTVsd3FjaTJwZ3o1bm9wY1d2MnJRTVcvdmFRcmpC?=
 =?utf-8?B?eEx6dS9FNXRWdzM3c0ZROG8xcldCVUNNUlQzZkpyNjZWekdKUndPQWo3Q1lP?=
 =?utf-8?B?WDU0SHVGdHZyNXVTWndORDB5Q3BuZFc4eGdXbkZzQXVVcmZBV2ZjVmhRaVM2?=
 =?utf-8?B?MFJSLzVoUzI3NGNXcGNQMDJlVkdHOVYzbHhySkg4QzJqRlZ5ZThYSEJiNmk0?=
 =?utf-8?B?Mkpvci9SOEVUd2htOU8yNU0yNW5HTmJ4Q0hHaUEyY0xFZ1lnUm1yb2s5Mnpm?=
 =?utf-8?B?aEdCWmFEZ2lPc3VSMWRSZlF6ODZsMGJRWlpCdjJFM3BpN0lRUUpwUmNSMVVX?=
 =?utf-8?B?L1RIalBkeUJ6SWNTSlZDN3FTR2VkalplZ1lpNDFlWFZ0VjhhakpmL1B3Q3lq?=
 =?utf-8?B?NFRlUFlsUjFJbnRQQTBaYWU2VGVKdDg1NThXc2Z2eHNWd1p1THNma0FPL2Mw?=
 =?utf-8?B?b3hWckxpN2FnOEhpWGpQaldKQ3R1cmJFQi9XQ3pRdmpJYkNqMFI0WWZuWEE1?=
 =?utf-8?B?WFphMVcxQVB6NnRiL1JtM1RyOFlFOUsvcWdUQjZNYWVZS3BMdzZjWnB1bmpG?=
 =?utf-8?B?MGRYaGZ5U2Q1alJxc1VpUmFQVjhNQmhlanRhMUdXc2JpalVaV0RjYS8wWTdK?=
 =?utf-8?B?bEVNR0Z2ZWdvSWhEOWtUeVVLUEZ4eGIydDVOZVk5RkFjUm5YRkRQRS9DOFM0?=
 =?utf-8?B?UG52UHVLTFVCTld5OEQ5Qjd4T1JMMFY4NFkzYnc0U05jZ2pidEVyM2R3Z29U?=
 =?utf-8?B?M1NxdndreXA5TFNZNE5EZUJGbVdKaEhndjJHMUFqY3ZEVkV2QmRBN2lPV0hV?=
 =?utf-8?B?aTJ5MVRFbkZFdnNqSEx4cDhjS0JZV1l4NDJ0SjAvUmZQMWMwSzVRdjlvUmlE?=
 =?utf-8?B?Z3lkOGkxWVF0VHRlR3F2dlF5RkhYQjA5Z3JGVWcvVWJ5dS9WcjlYR0pwR253?=
 =?utf-8?B?VzQzZ2R2VmhjQ0kyNk9yWXJOaWdDMEVCT2wraGZVNjJtV1g0eG9wVWlMN3Ar?=
 =?utf-8?Q?ioa0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd423ea6-ffb7-43ad-a105-08d9bbc2a5c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 09:51:32.7217 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t6MSreEUkMf8j8dfBU13H+uO6wEYLBFx5vijbOE3kdSQ2WNnmNBhhYR2Myr7ImBP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2357
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIERlY2VtYmVyIDksIDIwMjEgODozNyBQTQ0KPiBUbzogUXVhbiwgRXZhbiA8RXZhbi5R
dWFuQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hl
ciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3Rp
YW4NCj4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IEZlbmcsIEtlbm5ldGggPEtlbm5ldGgu
RmVuZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFY0IDExLzE3XSBkcm0vYW1kL3Bt
OiBjb3JyZWN0IHRoZSB1c2FnZSBmb3INCj4gYW1kZ3B1X2RwbV9kaXNwYXRjaF90YXNrKCkNCj4g
DQo+IA0KPiANCj4gT24gMTIvMy8yMDIxIDg6MzUgQU0sIEV2YW4gUXVhbiB3cm90ZToNCj4gPiBX
ZSBzaG91bGQgYXZvaWQgaGF2aW5nIG11bHRpLWZ1bmN0aW9uIEFQSXMuIEl0IHNob3VsZCBiZSB1
cCB0byB0aGUNCj4gPiBjYWxsZXIgdG8gZGV0ZXJtaW5lIHdoZW4gb3Igd2hldGhlciB0byBjYWxs
IGFtZGdwdV9kcG1fZGlzcGF0Y2hfdGFzaygpLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRXZh
biBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4NCj4gPiBDaGFuZ2UtSWQ6IEk3OGVjNGViOGNlYjZl
NTI2YTQ3MzQxMTNkMjEzZDE1YTVmYmFhOGE0DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL3BtL2FtZGdwdV9kcG0uYyB8IDE4ICsrLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfcG0uYyAgfCAyNg0KPiArKysrKysrKysrKysrKysr
KysrKysrKystLQ0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxOCBk
ZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bt
L2FtZGdwdV9kcG0uYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfZHBtLmMN
Cj4gPiBpbmRleCA2ZDlkYjJlMmNiZDMuLjMyYmYxMjQ3ZmI2MCAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9kcG0uYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG0vYW1kZ3B1X2RwbS5jDQo+ID4gQEAgLTU1NCw4ICs1NTQsNiBAQCB2b2lkIGFt
ZGdwdV9kcG1fc2V0X3Bvd2VyX3N0YXRlKHN0cnVjdA0KPiBhbWRncHVfZGV2aWNlICphZGV2LA0K
PiA+ICAgCQkJCWVudW0gYW1kX3BtX3N0YXRlX3R5cGUgc3RhdGUpDQo+ID4gICB7DQo+ID4gICAJ
YWRldi0+cG0uZHBtLnVzZXJfc3RhdGUgPSBzdGF0ZTsNCj4gPiAtDQo+ID4gLQlhbWRncHVfZHBt
X2Rpc3BhdGNoX3Rhc2soYWRldiwNCj4gQU1EX1BQX1RBU0tfRU5BQkxFX1VTRVJfU1RBVEUsICZz
dGF0ZSk7DQo+ID4gICB9DQo+ID4NCj4gPiAgIGVudW0gYW1kX2RwbV9mb3JjZWRfbGV2ZWwNCj4g
YW1kZ3B1X2RwbV9nZXRfcGVyZm9ybWFuY2VfbGV2ZWwoc3RydWN0DQo+ID4gYW1kZ3B1X2Rldmlj
ZSAqYWRldikgQEAgLTcyMywxMyArNzIxLDcgQEAgaW50DQo+IGFtZGdwdV9kcG1fc2V0X3NjbGtf
b2Qoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90IHZhbHVlKQ0KPiA+ICAgCWlm
ICghcHBfZnVuY3MtPnNldF9zY2xrX29kKQ0KPiA+ICAgCQlyZXR1cm4gLUVPUE5PVFNVUFA7DQo+
ID4NCj4gPiAtCXBwX2Z1bmNzLT5zZXRfc2Nsa19vZChhZGV2LT5wb3dlcnBsYXkucHBfaGFuZGxl
LCB2YWx1ZSk7DQo+ID4gLQ0KPiA+IC0JYW1kZ3B1X2RwbV9kaXNwYXRjaF90YXNrKGFkZXYsDQo+
ID4gLQkJCQkgQU1EX1BQX1RBU0tfUkVBREpVU1RfUE9XRVJfU1RBVEUsDQo+ID4gLQkJCQkgTlVM
TCk7DQo+ID4gLQ0KPiA+IC0JcmV0dXJuIDA7DQo+ID4gKwlyZXR1cm4gcHBfZnVuY3MtPnNldF9z
Y2xrX29kKGFkZXYtPnBvd2VycGxheS5wcF9oYW5kbGUsIHZhbHVlKTsNCj4gPiAgIH0NCj4gPg0K
PiA+ICAgaW50IGFtZGdwdV9kcG1fZ2V0X21jbGtfb2Qoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpIEBAIC0NCj4gNzQ5LDEzDQo+ID4gKzc0MSw3IEBAIGludCBhbWRncHVfZHBtX3NldF9tY2xr
X29kKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiB1aW50MzJfdCB2YWx1ZSkNCj4gPiAg
IAlpZiAoIXBwX2Z1bmNzLT5zZXRfbWNsa19vZCkNCj4gPiAgIAkJcmV0dXJuIC1FT1BOT1RTVVBQ
Ow0KPiA+DQo+ID4gLQlwcF9mdW5jcy0+c2V0X21jbGtfb2QoYWRldi0+cG93ZXJwbGF5LnBwX2hh
bmRsZSwgdmFsdWUpOw0KPiA+IC0NCj4gPiAtCWFtZGdwdV9kcG1fZGlzcGF0Y2hfdGFzayhhZGV2
LA0KPiA+IC0JCQkJIEFNRF9QUF9UQVNLX1JFQURKVVNUX1BPV0VSX1NUQVRFLA0KPiA+IC0JCQkJ
IE5VTEwpOw0KPiA+IC0NCj4gPiAtCXJldHVybiAwOw0KPiA+ICsJcmV0dXJuIHBwX2Z1bmNzLT5z
ZXRfbWNsa19vZChhZGV2LT5wb3dlcnBsYXkucHBfaGFuZGxlLCB2YWx1ZSk7DQo+ID4gICB9DQo+
ID4NCj4gPiAgIGludCBhbWRncHVfZHBtX2dldF9wb3dlcl9wcm9maWxlX21vZGUoc3RydWN0IGFt
ZGdwdV9kZXZpY2UNCj4gKmFkZXYsDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG0vYW1kZ3B1X3BtLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X3Bt
LmMNCj4gPiBpbmRleCBmYTJmNGUxMWU5NGUuLjg5ZTExMzRkNjYwZiAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9wbS5jDQo+ID4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9wbS9hbWRncHVfcG0uYw0KPiA+IEBAIC0xODcsNiArMTg3LDEwIEBAIHN0YXRp
YyBzc2l6ZV90DQo+IGFtZGdwdV9zZXRfcG93ZXJfZHBtX3N0YXRlKHN0cnVjdA0KPiA+IGRldmlj
ZSAqZGV2LA0KPiA+DQo+ID4gICAJYW1kZ3B1X2RwbV9zZXRfcG93ZXJfc3RhdGUoYWRldiwgc3Rh
dGUpOw0KPiA+DQo+ID4gKwlhbWRncHVfZHBtX2Rpc3BhdGNoX3Rhc2soYWRldiwNCj4gPiArCQkJ
CSBBTURfUFBfVEFTS19FTkFCTEVfVVNFUl9TVEFURSwNCj4gPiArCQkJCSAmc3RhdGUpOw0KPiA+
ICsNCj4gPiAgIAlwbV9ydW50aW1lX21hcmtfbGFzdF9idXN5KGRkZXYtPmRldik7DQo+ID4gICAJ
cG1fcnVudGltZV9wdXRfYXV0b3N1c3BlbmQoZGRldi0+ZGV2KTsNCj4gPg0KPiA+IEBAIC0xMjc4
LDcgKzEyODIsMTYgQEAgc3RhdGljIHNzaXplX3QgYW1kZ3B1X3NldF9wcF9zY2xrX29kKHN0cnVj
dA0KPiBkZXZpY2UgKmRldiwNCj4gPiAgIAkJcmV0dXJuIHJldDsNCj4gPiAgIAl9DQo+ID4NCj4g
PiAtCWFtZGdwdV9kcG1fc2V0X3NjbGtfb2QoYWRldiwgKHVpbnQzMl90KXZhbHVlKTsNCj4gPiAr
CXJldCA9IGFtZGdwdV9kcG1fc2V0X3NjbGtfb2QoYWRldiwgKHVpbnQzMl90KXZhbHVlKTsNCj4g
DQo+IGFtZGdwdV9zZXRfcHBfc2Nsa19vZCBoYXMgYSB2ZXJiYXRpbSBBUEkgbGlrZSBhbWRncHVf
ZHBtX3NldF9zY2xrX29kDQo+IGFuZCBvbmUgd291bGQgZXhwZWN0IHRoYXQgdG8gaGFuZGxlIGV2
ZXJ5dGhpbmcgcmVxdWlyZWQgdG8gc2V0IHRoZSBjbG9jay4NCj4gDQo+IElmIGxvY2tpbmcgaXMg
dGhlIHByb2JsZW0sIHRoZW4gaXQgc2hvdWxkIGJlIGhhbmRsZWQgZGlmZmVyZW50bHkuIFRoaXMg
a2luZCBvZg0KPiBtaXhpbmcgaXMgbm90IHRoZSByaWdodCB3YXkuDQpbUXVhbiwgRXZhbl0gV2l0
aCBwYXRjaDIgdXBkYXRlZCwgaXQgd2FzIGZvdW5kIHRoZSB0cmlja3kgc2V0X3BwX3NjbGsvbWNs
a19vZCBpbXBsZW1lbnRhdGlvbiBwcmV2ZW50IGZ1cnRoZXIgb3B0aW1pemF0aW9uLg0KU28sIGxl
dCdzIGp1c3QgZHJvcCB0aGlzIHBhdGNoLg0KDQpCUg0KRXZhbg0KPiANCj4gVGhhbmtzLA0KPiBM
aWpvDQo+IA0KPiA+ICsJaWYgKHJldCkgew0KPiA+ICsJCXBtX3J1bnRpbWVfbWFya19sYXN0X2J1
c3koZGRldi0+ZGV2KTsNCj4gPiArCQlwbV9ydW50aW1lX3B1dF9hdXRvc3VzcGVuZChkZGV2LT5k
ZXYpOw0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJYW1kZ3B1X2Rw
bV9kaXNwYXRjaF90YXNrKGFkZXYsDQo+ID4gKwkJCQkgQU1EX1BQX1RBU0tfUkVBREpVU1RfUE9X
RVJfU1RBVEUsDQo+ID4gKwkJCQkgTlVMTCk7DQo+ID4NCj4gPiAgIAlwbV9ydW50aW1lX21hcmtf
bGFzdF9idXN5KGRkZXYtPmRldik7DQo+ID4gICAJcG1fcnVudGltZV9wdXRfYXV0b3N1c3BlbmQo
ZGRldi0+ZGV2KTsNCj4gPiBAQCAtMTM0MCw3ICsxMzUzLDE2IEBAIHN0YXRpYyBzc2l6ZV90IGFt
ZGdwdV9zZXRfcHBfbWNsa19vZChzdHJ1Y3QNCj4gZGV2aWNlICpkZXYsDQo+ID4gICAJCXJldHVy
biByZXQ7DQo+ID4gICAJfQ0KPiA+DQo+ID4gLQlhbWRncHVfZHBtX3NldF9tY2xrX29kKGFkZXYs
ICh1aW50MzJfdCl2YWx1ZSk7DQo+ID4gKwlyZXQgPSBhbWRncHVfZHBtX3NldF9tY2xrX29kKGFk
ZXYsICh1aW50MzJfdCl2YWx1ZSk7DQo+ID4gKwlpZiAocmV0KSB7DQo+ID4gKwkJcG1fcnVudGlt
ZV9tYXJrX2xhc3RfYnVzeShkZGV2LT5kZXYpOw0KPiA+ICsJCXBtX3J1bnRpbWVfcHV0X2F1dG9z
dXNwZW5kKGRkZXYtPmRldik7DQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArCX0NCj4gPiArDQo+
ID4gKwlhbWRncHVfZHBtX2Rpc3BhdGNoX3Rhc2soYWRldiwNCj4gPiArCQkJCSBBTURfUFBfVEFT
S19SRUFESlVTVF9QT1dFUl9TVEFURSwNCj4gPiArCQkJCSBOVUxMKTsNCj4gPg0KPiA+ICAgCXBt
X3J1bnRpbWVfbWFya19sYXN0X2J1c3koZGRldi0+ZGV2KTsNCj4gPiAgIAlwbV9ydW50aW1lX3B1
dF9hdXRvc3VzcGVuZChkZGV2LT5kZXYpOw0KPiA+DQo=
