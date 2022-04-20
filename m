Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF7FC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 08:01:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB84B10F22B;
	Wed, 20 Apr 2022 08:01:41 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2079.outbound.protection.outlook.com [40.107.101.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E502410F22B
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 08:01:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebj7qBGfp1GiNVB/PKxQZVcNHC7ISoxW6c7S0hN69VpQhjcQNLiiu1aUEHjfd0KYDcv250XPwbLXdufT9fc+sKSpnOGW0lGSQmkMpTdCtKGZ55vLkr2tgjSMPzL1uvjahaRxP1PZUbWAZ5msbOXdeIng35F4+5fNvFSsJeGwARAfmomq8DelAOQO4++Ttyxbw3v98Scp9aZnoGorxWLQ7gvpJUOV9vudTnzEL1F+zHbBoHntGsJrnO8B/DY/ncxN0TfPxwlaz+8eOWqztZGkZaOqmX0t95zooq2EqZTSIRXyEqBmVY1wx4tBjZladaNuZILRRi866B9928w5hJT3Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+UyLm0fvZMyuJVOTB1qnIi0W1q0ooxZjXa1RYXR9E4=;
 b=GWILA8t0cnDJCDMFC2WzqpTcsxmRL35K2BCdoWoMWUgPHyCsGJzbviwLJtv/FYVNkpLaynDi2FRqD//l5EEeCKZUCUdZE9EEQFg/2Xc63H1+mtFvbn4zGymWDyEOZ7YpILaKEy9hLbTAqUBlLBtdTXTsZVwFZiOSKq+Me1QVZcqtmiUCFjWF+ogF6L4MQo/O2l/p+CNYYMDcTaJB3j+b2OuhkrDHFDxE0Ny8C64kUqmb9wYG/aAERZ5TV6DBYgPSWv1f1rrudzKchQ96Ta5yvH8pVpMKizgwOIGSqWKqN4XZZunxFSkOq4/+U+f7AyP5PXdmMh3EpoVb0u4cn0FVHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+UyLm0fvZMyuJVOTB1qnIi0W1q0ooxZjXa1RYXR9E4=;
 b=w5uYv/5AwtIwjGCyp0yG7xoepjj4o2bJvfKTJ2T/IrYvu/Z1ER8J5QBc516ptNtVPtg5dS0Q8whLM4/Mc6y0LKlwzO1y3o4dnU5aIUQV58zAjrz5Ts7mLOVQO1lxh5TBM++U1AnfMlSVcaUQguc4WMZiCARDgtSnqG1PHdiA36k=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by MWHPR12MB1695.namprd12.prod.outlook.com (2603:10b6:301:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 08:01:38 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::bc5b:45a3:477e:258d]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::bc5b:45a3:477e:258d%3]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 08:01:38 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: keep mmhub clock gating being enabled during
 s2idle suspend
Thread-Topic: [PATCH] drm/amdgpu: keep mmhub clock gating being enabled during
 s2idle suspend
Thread-Index: AQHYVFs0ML5lWqbnMUqFJBua1df+EKz4J5MAgABEGFA=
Date: Wed, 20 Apr 2022 08:01:38 +0000
Message-ID: <BYAPR12MB323809F1889B2ECE48404D53FBF59@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <1650420149-20872-1-git-send-email-Prike.Liang@amd.com>
 <04a8452e-ba8c-92f2-86a9-bee25c658ac7@amd.com>
In-Reply-To: <04a8452e-ba8c-92f2-86a9-bee25c658ac7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=6767a65f-87db-4497-8906-94759e855de4;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-04-20T07:42:57Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62fe2cc5-2071-45b5-0f2c-08da22a3ff25
x-ms-traffictypediagnostic: MWHPR12MB1695:EE_
x-microsoft-antispam-prvs: <MWHPR12MB1695D88EEC2901674E1F1530FBF59@MWHPR12MB1695.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l/cfPm/2MuqCSKAvkWLWKaDDTsE9tdqdHhcW0PVPGkLRXzsm/gFLljxiUKfmWwPEo3h64c9W3n9LEOscQiBIt+AoBqTDugK4CDyYFR8YlSavYEJIYy/Ses6KOabvCxGwnHsc4d5xcAdWOtTmT/471KJ66sawuEuLTEhRc7gPqNKyL+8BBfFhScQy7NjwPamz7UAnGEm/IcTxxk1MdX9BkoJtlHMVhfmDvuRy2PzDvHmfphmulYbsC0kVzq1wXedzW1NkDC1QOHbSqGf76qjqG7J6K5XwuuGkk/Ysb5je1PyHbnnp3rG/pNHLC+TyXmvyxVgME+ii54zOzfSYOgk0qIJ+cgXhVPbC+9Iyxghh5Mp195MpoVUcQKvLmIGoBF3NWHrwqAVu9HJWQ15DHOkmj40rHDnPJ98rcvtPM9kqaOQY/2l1p1rMBCc+m25SlPh8RYxpkry44A2fFllcUS5F88t7/7rP5P2ph0fLtCMIobG7kzW67hr8/cwu9v4gtjGKAWSY7Te8qJxRQNCBuYk/VetYPk8JryHzVOC0Bz4I/MVvU3DpMyclz8tEZ5P8CY5YSlZqO2VZG5Kvtl5b6wqq2OLqd5F/w5xZn+1+uul3ZKuaY8mwx6o93GgrYQT3A/VYj3beMnTASwfvFD7NXobPnYVT+65enu4IzMr0MSt3b8cwwB7K0IO0J3frZgwMeozAIfd/iUGAxfpMXOo8XUlZ2A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(7696005)(6506007)(71200400001)(122000001)(54906003)(110136005)(2906002)(66946007)(76116006)(9686003)(38070700005)(64756008)(66476007)(8676002)(66446008)(66556008)(4326008)(52536014)(5660300002)(55016003)(15650500001)(316002)(508600001)(33656002)(53546011)(83380400001)(38100700002)(186003)(26005)(86362001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmxTbkhZMnhkVmJ4d2tUeFp2eHd6ZUl1VGhZaG5VSGJ0Wk1sNzRBNUkwZVdz?=
 =?utf-8?B?VEQ1Nk43TDdLRXI4bE1UTmwrOHpGSHJEaGFsY3FKbmJ6K3N2c2VRZnRNcUFm?=
 =?utf-8?B?SUhIOEE4R2JPMnFoZE9RK2taU0RkYnlUWVF6czhiRlpJTDNrVXNJZUdKMlhi?=
 =?utf-8?B?alFXUkhlcFpFQWEvYkgvQzcyVW0zeUZxSVYvcnpsaXdVcTNVZ0l0MjJBS2VM?=
 =?utf-8?B?YXA2TmdGbWlUZmVOZFp4RlBGWk9JQW5LRmRRb3RRM2JIaDZiY000QU9CRWdu?=
 =?utf-8?B?V2dZRHA1b3JRU0dmRDNTWnlRc0p4TVhPV1hHcWhXaFFrQStOK3FSNVEycHpF?=
 =?utf-8?B?VjlBMFMxbGN3MTdQK2o5MWdaK0p6RTk3N1hWdnV0ODM3ckRhWTdFOXNuNlc0?=
 =?utf-8?B?bEhJSlZCc1NSNGIrUTNyeURZVTJRZlk2Vm56ZlpINmU2NEVWSHRwMTFkK2FF?=
 =?utf-8?B?R3BFTmc4em92TnVnYXhER1FvL0hSa3ZlZWNFK0JKMFVXcGZ1L2VBM3ZJUHBQ?=
 =?utf-8?B?Wm1qS1J2QytPcnhMWk9zbFdNZjJUWUJHM1RpaUUzSmYrbm9Fa0ZvOFM3cHdx?=
 =?utf-8?B?eVNwUk11bjVPUnNoaWJad3BmVTlkS25hdE9UNEpGTldqYjZpRlBlMlNjOXpr?=
 =?utf-8?B?VlhWdzhlcjZJbUpqQmU3Rk9QUXJJNFI1a3pHZ25XMkdSNTA0LzgwZVR6bU95?=
 =?utf-8?B?blVQK2wxQTZoQmVrSGNkeWU4aW13THEvSTJDSGg3QVRPOGpLT2xiVGVLWmZM?=
 =?utf-8?B?QTFvUEY4WnhnZk9xLysxQnRtZ04xVmwvNVhtbFJXWE5SNm5jTk9uTXhhYW16?=
 =?utf-8?B?UVNkY0RMMUdYdHNIQ0JXK2xOa1ArclFGUEMwWDIxUEY4eGdWVS9uRGNwTmZ5?=
 =?utf-8?B?MXlJMDllVENGbU9tNDZTcmhQSGI2c3NHclJuWU9ma1RWdzZGdWQxeEpic0cx?=
 =?utf-8?B?UFY0d3l5VzhkRFNVczdMZmVhMTNRV2FBUDk2R1QyT2Q4TWZiUVhmNXV0V0Nl?=
 =?utf-8?B?c082dFozYzZTYzBBR0VIdzQxWDhkalZZcys5K1Z0aHV3RVplcnhMSEJpRnRs?=
 =?utf-8?B?TTBITjQ3MGtOSHpyRVAyNFpXQzdWYzJnaVlsNHREUXJCWi9QOThmeVgraEw2?=
 =?utf-8?B?d3VSVXk3Mk9nTDJaMjZXR3ZYR29TbG5QTnFFUWpyL2QvaE1acmU4RGFsNzRv?=
 =?utf-8?B?VWsyYXJweVBWNWNQM3VKZUZrZGFWc2wyOUd3Q1BwVHdaUTc3YThjNnF3OEdG?=
 =?utf-8?B?VitQUERSNVdjeGRweUVyenhoZTJkNmxZQkFzZEJiK0tmTEJicGhsaFNpOXBU?=
 =?utf-8?B?ZFovUDg2SEQzeDFhcWZoMThMSTV1VklSQmxuSmRMMDRZRmNwam9CeEpVNjhU?=
 =?utf-8?B?M3p6WWdlUFk3eE9JVE1mbmtqU2pKbzBSQ3RsenQ3Smp1cHgxNUtDK3ZMeUVQ?=
 =?utf-8?B?RXZhUlVtNVVyVWFmV3BOejY5c2dzWHliV2s0bVdieDVWMkM2RkVuMzlqd3dM?=
 =?utf-8?B?dUpSZTNXWTQ1am9hNmtPcjBxUWRubEE2VndoWjBKSzk5UG1UVnQvck5GNmNZ?=
 =?utf-8?B?ZlBIczZRMll5ODhLaTdqMFkxZWFRdXpvNEZoVjEySEdpZlBiYklkelJvczRa?=
 =?utf-8?B?VFhCSWsvYmtyM014ZzNoRFVrR3NpQlYxcFlCSUY0S0Y2L0p4S1RQUytleHBZ?=
 =?utf-8?B?cll0ekNwQ0N3NlpqU2R4L09TM1Vld3FESVNNR2VsWVZWYVYzSFR2RDV6eGp5?=
 =?utf-8?B?MUR1cy9CTVZIMGxheUhFaitVdk9sbkZiS1pXY1cvSDY1VkkzYWVraHdEaExP?=
 =?utf-8?B?Y2NGcCs3STVKRWFpNFFDeVJPbVd1SEVNVHFzRXlTQzVicVZpazY0SmdEK1JD?=
 =?utf-8?B?VWIrMGJHYUZDN0tGbjlqZXpNdUZ4Y25WdndvR0JOQ2NUNVd0ck5xeit6UjFq?=
 =?utf-8?B?enNuem4vbUhzcE53Rlk1RjJyTkJMZ3l2U1ZtcFNMS1FkRUE2aDlscjJTeW5a?=
 =?utf-8?B?U1pBMVV0VktVYUxQSUE4YWtkQThMbU9KK2laNGRrMGFYU25xY0lEVFZ2V2JG?=
 =?utf-8?B?VmRDOFBnT2xmeFo1MzlNcjZzakFDTm1TbVRqWWVCeVBjMHh1d0dlMHRORXUz?=
 =?utf-8?B?MGJZc1FuaUxWUGl2UVg3MWFjRmx3NTZIRWJlNWwvbS9IdGFHbUtESGRkT0Nx?=
 =?utf-8?B?VGZOOXgxYmQ2c21LL1Zpd05QMUxBenNsTHhaSmpseEgzSGRPOUVoQm9VbHFw?=
 =?utf-8?B?RDBqRjE3d0h4R21WMnkzcjNYTkdCR25CVDRhVHVTc2twUTVkTGZ1cU1YeEFR?=
 =?utf-8?Q?vZz22AYUpwObWnGDHp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62fe2cc5-2071-45b5-0f2c-08da22a3ff25
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 08:01:38.1822 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DquYw5FoagXQ/Da1evDg88mVj9ziEXf70GiHALwLnAGvhOGTj+n5GjxqFOq8N9sc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1695
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXphciwg
TGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDIwLCAy
MDIyIDExOjM5IEFNDQo+IFRvOiBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+OyBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxB
bGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgSHVhbmcsIFJheQ0KPiA8UmF5Lkh1YW5nQGFtZC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGtlZXAgbW1odWIgY2xvY2sg
Z2F0aW5nIGJlaW5nIGVuYWJsZWQNCj4gZHVyaW5nIHMyaWRsZSBzdXNwZW5kDQo+DQo+DQo+DQo+
IE9uIDQvMjAvMjAyMiA3OjMyIEFNLCBQcmlrZSBMaWFuZyB3cm90ZToNCj4gPiBXaXRob3V0IE1N
SFVCIGNsb2NrIGdhdGluZyBiZWluZyBlbmFibGVkIHRoZW4gTU1IVUIgd2lsbCBub3QNCj4gPiBk
aXNjb25uZWN0IGZyb20gREYgYW5kIHdpbGwgcmVzdWx0IGluIERGIEMtc3RhdGUgZW50cnkgY2Fu
J3QgYmUNCj4gPiBhY2Nlc3NlZCBkdXJpbmcgUzJpZGxlIHN1c3BlbmQsIGFuZCBldmVudHVhbGx5
IHMwaXggZW50cnkgd2lsbCBiZSBibG9ja2VkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUHJp
a2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92Ml8zLmMgfCA5ICsrKysrKysrKw0KPiA+ICAgMSBmaWxl
IGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3YyXzMuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvbW1odWJfdjJfMy5jDQo+ID4gaW5kZXggMTk1N2ZiMDk4YzRkLi5jYjNkY2E0ODM0
YjQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjJf
My5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjJfMy5jDQo+
ID4gQEAgLTU2OCw2ICs1NjgsMTUgQEAgc3RhdGljIGludCBtbWh1Yl92Ml8zX3NldF9jbG9ja2dh
dGluZyhzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPiAgIHsNCj4gPiAgICAgaWYg
KGFtZGdwdV9zcmlvdl92ZihhZGV2KSkNCj4gPiAgICAgICAgICAgICByZXR1cm4gMDsNCj4gPiAr
ICAgLyoNCj4gPiArICAgICogVGhlIGlzc3VlIG1taHViIGNhbid0IGRpc2Nvbm5lY3QgZnJvbSBE
RiB3aXRoIGNsb2NrIGdhdGluZyBiZWluZw0KPiBkaXNhYmxlZA0KPiA+ICsgICAgKiBzZWVtcyBv
bmx5IG9ic2VydmVkIGF0IERGIDMuMC4zLCB3aXRoIHRoZSBzYW1lIHN1c3BlbmQgc2VxdWVuY2UN
Cj4gbm90IHNlZW4NCj4gPiArICAgICogYW55IGlzc3VlIG9uIHRoZSBERiAzLjAuMiBzZXJpZXMg
cGxhdGZvcm0uDQo+ID4gKyAgICAqLw0KPiA+ICsgICBpZiAoYWRldi0+aW5fczBpeCkgew0KPiA+
ICsgICAgICAgICAgIGRldl9kYmcoYWRldi0+ZGV2LCAia2VlcCBtbWh1YiBjbG9jayBnYXRpbmcg
YmVpbmcNCj4gZW5hYmxlZCBmb3IgczBpeFxuIik7DQo+ID4gKyAgICAgICAgICAgcmV0dXJuIDA7
DQo+ID4gKyAgIH0NCj4gPg0KPg0KPiBBIGJldHRlciBmaXggd291bGQgYmUgdG8gZXhwbGljaXRs
eSBlbmFibGUgbW1odWIgY2xvY2tnYXRpbmcgZHVyaW5nIHMwaXgNCj4gc3VzcGVuZCBvZiBnbWMg
Zm9yIHRoaXMgSVAgdmVyc2lvbi4NCj4NCj4gVGhhbmtzLA0KPiBMaWpvDQo+DQpZZWFoLCBpdCBs
b29rcyBsaWtlIG1vcmUgc2FmZSB3YXkgdG8gc29ydCBvdXQgdGhlIG1taHViIGNsb2NrIGdhdGlu
ZyBzZXQgZm9yIG5vdCBpbmZsdWVuY2Ugb2xkIHByb2R1Y3QuDQpIb3dldmVyLCBzdGlsbCBub3Qg
c3VyZSB3aGV0aGVyIHJlYWxseSBuZWVkIHNvcnQgb3V0IHRoZSBjYXNlIHdoaWNoIGNhbiBkaXNh
YmxlZCBtbWh1YiBjbG9jayBnYXRpbmcgZm9yIHMwaXgsDQphbmQgaXQgc291bmRzIGxpa2UgdGhl
IGNsb2NrIGdhdGluZyBlbmFibGVkIGlzIGEgY29tbW9uIHJlcXVpcmVtZW50IGZvciBlYWNoIERG
IGNsaWVudCBjYW4gZGlzY29ubmVjdCBmcm9tIERGLg0KDQo+ID4gICAgIG1taHViX3YyXzNfdXBk
YXRlX21lZGl1bV9ncmFpbl9jbG9ja19nYXRpbmcoYWRldiwNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgc3RhdGUgPT0gQU1EX0NHX1NUQVRFX0dBVEUpOw0KPiA+DQo=
