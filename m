Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A29DC46CD2
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 02:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98CAC10E129;
	Wed,  3 Jan 2024 02:04:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9640410E129
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 02:04:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtQeg35xYDGs+ZnkJzCxq5c/IWCojvfR6rQAZKefcSsfI57a+UVOM7aaEuqVdbQLLxivyk5MAUwEO0064k6eyOuatmxNEXiCxSTgunetdLZCuO77F+y2eJ4idn0Mr/VlhrssewohjhfHZUrh9qinOWcSjCpe8Wbwc0OeiQWt+R6PvgHjinqqhTmFRC7h+gSNs1dYEyWriqjQL14FmiU8G1t18hx1kCmXr/HPlTrnUqg8kaCffKK6KagXSB6Yj09bCaAwZQLBdfGPvCUgzFOoXZx+zQekhltw2QHP0a2+qmeNjhDsuLjzbo1Byy7aWMJba8iTkHwN66P5Jf+CPlQ7lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPjgPo14qbLSsikFi9oMs8v+YuALeVRlGSwsXUmhYE4=;
 b=iDsjmx/dfQKUtl9f2WXnC182j+CzpcgITMu7P9mfJU4iv3zzbJ5KrUEs+efUbu+jyvnItpn6ImR+LZMZA/eRnJs+fvHhLFEoQ4GhD4rKy62QUuY9dB0VshvyVTl9duEQqdAQ0CBH9WS4Ynd8vbz98SOENyxoq8Gkk4lNWV4Lk7wA/CAyG9jkHg6PEzylWeQKZ4ThtA44oxvCq1Ou4QS+aG59QfvHgE2mf7hNw5xNhO5h1RlET/ooklVRl4jOOQYIuY6aXq9/JpD67fkIRLEi9W8KDPY39HZrJO+A5AMzkhA75TvZFawtC97wKDf4F7nEdpptzWLP/iOk+vi0Kt2VyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPjgPo14qbLSsikFi9oMs8v+YuALeVRlGSwsXUmhYE4=;
 b=ZEKpf2TTqPofmXLqsdCmh+ieU3yViLP6pqBTEcFJfU+iQNCAN+gPvUB8fimcMNkvKUZXvoRcbBIDxQ4gMSBVs/Nmq1sZ8QaMljIGc42s6iBQ8YUEpzVHKejUuvHsdnF+mxxtFzcG06G5mC5uEZdqz5Z++YloBmDeXxxR1Mm6l0Q=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5354.namprd12.prod.outlook.com (2603:10b6:408:103::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 02:04:08 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83%4]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 02:04:08 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, "Wang,
 Yang(Kevin)" <KevinYang.Wang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH 4/5] drm/amdgpu: Query boot status if discovery failed
Thread-Topic: [PATCH 4/5] drm/amdgpu: Query boot status if discovery failed
Thread-Index: AQHaPYUkC1n24zZ62kGyNxGGFQMK1LDGzPOAgACIszA=
Date: Wed, 3 Jan 2024 02:04:08 +0000
Message-ID: <BN9PR12MB5257354171AB889814428E4AFC60A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240102140742.23917-1-Hawking.Zhang@amd.com>
 <20240102140742.23917-4-Hawking.Zhang@amd.com>
 <8b796f04-da75-4ab4-87e9-be9abada93e8@amd.com>
In-Reply-To: <8b796f04-da75-4ab4-87e9-be9abada93e8@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=51ca6c57-3550-4da0-a7d1-0eaa654f38ce;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-03T01:58:28Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BN9PR12MB5354:EE_
x-ms-office365-filtering-correlation-id: 66bbe8b4-e4d5-49c6-2e50-08dc0c00457e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YIBdfERID+3trSUNsIKi1ZmpdJBi2ags7Dt1pwc/3KYOn3wtP6MGxz02EvdKYY0cGzV78fP5nzuQRcRFE7ooTurCveu8b384Hm8biml5e3KCiEGihB9Mu1aZW9+bT0LEsyWE+l46hlPQGNcRAz8+AAJ65ufR7PkWKsZlJMdhCFwNDKX0mMBnrufXE9ZhdkQ8XJUL1j9vzTYBgvIozVnh8/MxC0usYuLnN/qPx/pRAz3ml0fPMwHYb0sQ/BsQTPYruzPfkO/A/eUWcLoCfdsr4047auEAqsowhaPezSSlwp3Vy9I0DutoG09/wP3c7cf4+kTCTXtIJE6ufv+I0CpbktyCiuYoLg25pQzeBSJnly+38z66cjwCa/c0d0KMnKILbe9Au/hSIM+lELJFEIHi1hbImXmzgjYnZjmk3H+/eLRBz0vYdf9ZyrviNWKIUpvWPSp+VGJdp6+NEwqR5iraNrsOBrGyMaGP/4meyh+vQz4WQtnnoOP9cde4N3sG7xC/6hVXVzo6eZ+yUDcQNQBFjbW4+jflMIJYzZ+nCrnaiR68XjfyKfF2M7CqHB8B6f8faCcohksFAjH2tGZIHdg6p+eVGsexSo/IAi/q5o/DQbYVHV6nnKjVMVer7nJ5mRoK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66476007)(66446008)(76116006)(66946007)(64756008)(66556008)(4326008)(6636002)(110136005)(8676002)(8936002)(54906003)(316002)(26005)(83380400001)(71200400001)(478600001)(9686003)(53546011)(7696005)(52536014)(2906002)(5660300002)(41300700001)(6506007)(33656002)(38070700009)(921011)(122000001)(38100700002)(86362001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWVXdHNTK0pNQVUvMTkzcUU2bEZlU01ZakducFg2MnFEbVBZaXl6emlTclhu?=
 =?utf-8?B?eGxhSFpaUE9PdHFDdlVJaVBaVDluekRwVFpDWUV1NlhObTBZODA0ODc0VHRM?=
 =?utf-8?B?emVLT05FM1BsODc4WERybFBjRnJid3lacmpOZ2Q2eVFsRXFpQ21XdCs2ZlNt?=
 =?utf-8?B?NFRpVTRFZU95aFk2TGV2Y1M1VUtoTmxrYUNsUkZJekJTUjJyeEcxSTFEM0hR?=
 =?utf-8?B?cUVTbXIyc2l1RVlYZjdKZk5UZ2ZEYVRRMGcyaXI0M3hEY3phVTFoaTVOOUdv?=
 =?utf-8?B?Q0pXeThVQ1BhVnd1REpzN21meXBDaC80S0lUbmlrYWU4NmpJaEJBbkNVbzJE?=
 =?utf-8?B?K0Z1M0k3QjFOUjF5cy9aaG5GN1phTFhja0JHTXJDZHlKWlFGZk5QYlYwR2Rq?=
 =?utf-8?B?SHBsSUNyelA3SGlmRXI3dmtBK2lDR29FaG5NZ2ZHU2NYQWNjd3hWS3RuZ2dy?=
 =?utf-8?B?bGxiRTFkNXV3M0RDSnF3UExnSzN1YmtTcW9MdTJraG5qeVpaejNCT29lUi96?=
 =?utf-8?B?eklTTUFnVDMxNWFVQjhQLzR6RUNBbFhIUFFnSzRpd0F5eHlkL2QxVVhueTNh?=
 =?utf-8?B?cEVBMjBUeURWeHJnVFdORVJsaFN4bHV6VTl1aVZFcDdNeGM1cTJWOElvYmlZ?=
 =?utf-8?B?bmt1NVpVK0VpbXlrKzI3Sm9xekN4dkFmS3c5VkVRb2htUllLZ1NvRnJGb1pZ?=
 =?utf-8?B?Y2t1TnJvbVBzZW4rMU9KbDdJN2pYQ0J0SDdIUjJjaEp0Z3NTZ2ZDV2ZYeDdo?=
 =?utf-8?B?WjdJayt2MVJFcS9QajQwQXlJYVE1WUJ1NG1GcmZ5bDZjQ0pNMjkycVpRb29x?=
 =?utf-8?B?am9mbFBlOVpLMXgzSW42YmpYRUhiMlJKWjVyckI1Z2ZKZXlmR3U1cGpoeWhk?=
 =?utf-8?B?bksrS2IzbWtid0EvRGd2SitzNXhsQlRybUY5K3YzNmNRZDQ2em13cDBRWjlh?=
 =?utf-8?B?TUUrV0RpbzVnNTRNKzB6cmpkVEZkbEVSSUl6UFlnSUtNME01cGtpUERXYmVq?=
 =?utf-8?B?ZzRSZ0RLeEJyNEdWTytrMFcvaVRjdll2Q1B2M25ZMkgrYXFYRFZCMFZlQlov?=
 =?utf-8?B?OEtpZmV1eDBHQU9CUnN5Q2xkQUdBdnl2MnN2VTdTSkVDRm1pOUVrS0ZXMXhz?=
 =?utf-8?B?a1VlY3pXQi96S3BmdnpjS05MVGlqai9GaFlyYkxlOUJ0SHArdUtMUU14STU2?=
 =?utf-8?B?OHlvMFBmWStxTFA0Q2NmMkJ5WXRSZEZRYmRId0RoUFNnRjhrSksrRWFFUVo5?=
 =?utf-8?B?Ylc2OGFQMzRMaXByRzlUdlJVK2tYTFBpdXVjR0pNNktOSENSOHE0QVBTNU1P?=
 =?utf-8?B?WjBVL2VOOCt4NTFjVjQxY01EUkRMQzd2MjN2RVVTZkNGUEhSVE9GUzVLc2FP?=
 =?utf-8?B?R3dydUVrczgzM0lTbHBvQjlTRldkejFiOGpzdldPZ2w5Q2ZyMER1V2JEZ1pF?=
 =?utf-8?B?aDFNV3p3bU82eVlWWDJIRHd5WGdhMDZFYjdmeWNLMFAwWFNueFN5NGFUaVFs?=
 =?utf-8?B?RGlRanJGTkRRd21HSTdWU2ovQXRBMENoK0xOdnZKSEZmQktHM2RzejRtb04r?=
 =?utf-8?B?OXA4VEJvQUd5T2JQd1RMclYzZU8rckZlSmpvWnN6R2liUlFKOTF2clhMQVpY?=
 =?utf-8?B?NFFycW9yL0cveWpRNWpyeDlFd2V2cFN1eXFLeW00aWdOVkYyaElJVm9LVE4z?=
 =?utf-8?B?VmlGQXNJczUwMFJ5TjJJWXNnd3puM05MeG5Xck1VbFlJMWlNNU1vM0ZrNSsx?=
 =?utf-8?B?SXpYVmcwdXA4Zi9RekZHV3R4Q2h1OVQ4Tk5lVzA5TGJESWVoTjVYYzdEZVB5?=
 =?utf-8?B?dUtxSnQydVREb0JVY2pCMGxGQ1JqUjhyaW9xMGF0a0dOZUVkOTdzZnJlSUVz?=
 =?utf-8?B?djFOcG1FNGc0Mm8yY25IUDAyMzBNVC9JUk8yQ2NaZzFXVlBLdUxERDU1TDcz?=
 =?utf-8?B?RzNtVzJjUmcvRFVncEw3aFc4SndvV0RONm41OFhwVGRRWFhQOXowT00rbVZz?=
 =?utf-8?B?ZUFqVGpEMFVkWk5JRlNDaTBPcVZ4MnBSU3BIVVg5eFJnci8zdWt5SEhhZ21B?=
 =?utf-8?B?T29PaUtUY08zZGkydHdCWmd0QkpyVE9BekhybXAxRk50MVN1cldLUkdnU0pC?=
 =?utf-8?Q?xdAavDp98X70QrzjpYUslKg/y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66bbe8b4-e4d5-49c6-2e50-08dc0c00457e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 02:04:08.4902 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cWBTKAMBNuOr/1CM36W95aLEiEgjyKiqSNlB83Qr6FwY/bfsBnGpC7o2Blmf+9cUrtHHlqyOpIkvZvSvUBsAqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5354
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJFIC0gSSdtIG5vdCBzdXJlIGFi
b3V0IGhhcmQtY29kaW5nIDQgaW5zdGFuY2VzIGhlcmUuIFRoZSBjb2RlIHlvdSBkcm9wcGVkIGlu
IHBhdGNoIDEgd2FzIHVzaW5nIGFkZXYtPmFpZF9tYXNrLiBCdXQgSSBndWVzcyB0aGF0J3Mgbm90
IGV2ZW4gaW5pdGlhbGl6ZWQgY29ycmVjdGx5IGlmIElQIGRpc2NvdmVyeSBmYWlsZWQuIFdpbGwg
dGhpcyB3b3JrIGNvcnJlY3RseSBvbiB0aGUgQVBVIHZlcnNpb24/DQoNClllcyBhaWRfbWFzayBp
cyBub3QgaW5pdGlhbGl6ZWQuIElQX0RJU0NPVkVSWV9WRVJTSU9OIGlzIHRoZSBvbmx5IGF2YWls
YWJsZSBmdXNlIHNldHRpbmcgdGhhdCBjYW4gYmUgdXNlZCB0byBpZGVudGlmeSBvciBlcXVpdmFs
ZW50IHRvIDQgaW5zdGFuY2VzIG9mIGFpZCBpbiBzdWNoIGNhc2UuIFdlIHN3aXRjaGVkIHRvIGEg
Y29tbW9uIG1haWxib3ggcmVnIHRoYXQgd29ya3MgZm9yIGJvdGggQVBVIGFuZCBkR1BVLiBUaGUg
ZXhwZWN0YXRpb24gaXMgZm9yIEFQVSwgZHJpdmVyIHN0aWxsIHJlcG9ydHMgZncgYm9vdCBzdGF0
dXMsIHdoaWxlIGl0IGdpdmVzIG5leHQgbGV2ZWwgaW5mb3JtYXRpb24gb24gdGhlIGZhaWx1cmVz
IGlmIGJvb3QgZmFpbHMgb24gZEdQVS4NCg0KUmVnYXJkcywNCkhhd2tpbmcNCg0KLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdA
YW1kLmNvbT4NClNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAzLCAyMDI0IDAxOjQ5DQpUbzogWmhh
bmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnOyBaaG91MSwgVGFvIDxUYW8uWmhvdTFAYW1kLmNvbT47IFlhbmcsIFN0YW5sZXkg
PFN0YW5sZXkuWWFuZ0BhbWQuY29tPjsgV2FuZywgWWFuZyhLZXZpbikgPEtldmluWWFuZy5XYW5n
QGFtZC5jb20+OyBDaGFpLCBUaG9tYXMgPFlpUGVuZy5DaGFpQGFtZC5jb20+OyBMaSwgQ2FuZGlj
ZSA8Q2FuZGljZS5MaUBhbWQuY29tPg0KQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVy
LkRldWNoZXJAYW1kLmNvbT47IE1hLCBMZSA8TGUuTWFAYW1kLmNvbT47IExhemFyLCBMaWpvIDxM
aWpvLkxhemFyQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIDQvNV0gZHJtL2FtZGdwdTog
UXVlcnkgYm9vdCBzdGF0dXMgaWYgZGlzY292ZXJ5IGZhaWxlZA0KDQoNCk9uIDIwMjQtMDEtMDIg
MDk6MDcsIEhhd2tpbmcgWmhhbmcgd3JvdGU6DQo+IENoZWNrIGFuZCByZXBvcnQgYm9vdCBzdGF0
dXMgaWYgZGlzY292ZXJ5IGZhaWxlZC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogSGF3a2luZyBaaGFu
ZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMgfCA2ICsrKysrLQ0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3ZlcnkuYw0KPiBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3ZlcnkuYw0KPiBpbmRleCBiOGZkZTA4YWVjOGUu
LjMwMmI3MWU5ZjFlMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2Rpc2NvdmVyeS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kaXNjb3ZlcnkuYw0KPiBAQCAtMjcsNiArMjcsNyBAQA0KPiAgICNpbmNsdWRlICJhbWRn
cHVfZGlzY292ZXJ5LmgiDQo+ICAgI2luY2x1ZGUgInNvYzE1X2h3X2lwLmgiDQo+ICAgI2luY2x1
ZGUgImRpc2NvdmVyeS5oIg0KPiArI2luY2x1ZGUgImFtZGdwdV9yYXMuaCINCj4NCj4gICAjaW5j
bHVkZSAic29jMTUuaCINCj4gICAjaW5jbHVkZSAiZ2Z4X3Y5XzAuaCINCj4gQEAgLTk4LDYgKzk5
LDcgQEANCj4gICAjZGVmaW5lIEZJUk1XQVJFX0lQX0RJU0NPVkVSWSAiYW1kZ3B1L2lwX2Rpc2Nv
dmVyeS5iaW4iDQo+ICAgTU9EVUxFX0ZJUk1XQVJFKEZJUk1XQVJFX0lQX0RJU0NPVkVSWSk7DQo+
DQo+ICsjZGVmaW5lIG1tSVBfRElTQ09WRVJZX1ZFUlNJT04gIDB4MTZBMDANCj4gICAjZGVmaW5l
IG1tUkNDX0NPTkZJR19NRU1TSVpFICAgICAgICAweGRlMw0KPiAgICNkZWZpbmUgbW1NUDBfU01O
X0MyUE1TR18zMyAweDE2MDYxDQo+ICAgI2RlZmluZSBtbU1NX0lOREVYICAgICAgICAgIDB4MA0K
PiBAQCAtNTE4LDcgKzUyMCw5IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2Rpc2NvdmVyeV9pbml0KHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgIG91dDoNCj4gICAgICAga2ZyZWUoYWRldi0+
bW1hbi5kaXNjb3ZlcnlfYmluKTsNCj4gICAgICAgYWRldi0+bW1hbi5kaXNjb3ZlcnlfYmluID0g
TlVMTDsNCj4gLQ0KPiArICAgICBpZiAoKGFtZGdwdV9kaXNjb3ZlcnkgIT0gMikgJiYNCj4gKyAg
ICAgICAgIChSUkVHMzIobW1JUF9ESVNDT1ZFUllfVkVSU0lPTikgPT0gNCkpDQo+ICsgICAgICAg
ICAgICAgYW1kZ3B1X3Jhc19xdWVyeV9ib290X3N0YXR1cyhhZGV2LCA0KTsNCkknbSBub3Qgc3Vy
ZSBhYm91dCBoYXJkLWNvZGluZyA0IGluc3RhbmNlcyBoZXJlLiBUaGUgY29kZSB5b3UgZHJvcHBl
ZCBpbiBwYXRjaCAxIHdhcyB1c2luZyBhZGV2LT5haWRfbWFzay4gQnV0IEkgZ3Vlc3MgdGhhdCdz
IG5vdCBldmVuIGluaXRpYWxpemVkIGNvcnJlY3RseSBpZiBJUCBkaXNjb3ZlcnkgZmFpbGVkLiBX
aWxsIHRoaXMgd29yayBjb3JyZWN0bHkgb24gdGhlIEFQVSB2ZXJzaW9uPw0KDQpSZWdhcmRzLA0K
ICAgRmVsaXgNCg0KDQo+ICAgICAgIHJldHVybiByOw0KPiAgIH0NCj4NCg==
