Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FACC47422
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jan 2024 09:00:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5B3B10F4A3;
	Fri, 26 Jan 2024 09:00:58 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 965FF10F4A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jan 2024 09:00:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/EsNX1mlQHL4ebKTp7cZIVV9DdDN5iZIRPO/DNWjVqdxw6f4CmbeK1K5gHqIrtkAigUsMQ8B1dZs6poXyMANfW73hLDx67Fwk7y+BgZLrCIZKr6F79ivGNAfGMV0qjFIVlS1iC6vtU/EysA0QFbxofz5UewYY6bI7zaqmmERy6Jmb1l83YEvfZ2H/44G6EX66mZGfQuanrmMJJ0QZhCWpKFxAeT161AHQU5o5zFyZdkNEvpqD9mcyu/QvZqktH3rFZsYaS1/KdDLDubIoBVChrGX4DdQuYQhoK7YjjNvaSgAK1DcIL6w5OvHRGdFOh6arpDY2tQjdgwG+3rCUBiQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQ8x2HmlXa8sNHUfGf+n0AbFEFBLRCfIg/rY+zZnYAc=;
 b=fdDdY14jCX169lR0cQgju8tO2O7n/cQUWxEuQcUjIfR8VpKB+VC6OZePbV+Iovxbc8bJLbaIk20L+rqRClfMgyEqA9lpBPJ8gsVYe0nt4dmp2v+cBxtAiiQqSWPNP7rkmXV3OkRiVNbucNglG0cCZgd4pc56uh2H2kU+z2vm4mWaJ6JlctpJ/7ETvkYwLdifyq2ct/8iiiXQhFLosdBSr1IytWvMTksflA6sQHaKO6YwM1MFMM+VX0gDXx7FY1xeEwMoqGU28iKXOT4twUf5t+NVHAEnc7Ao9JjJckObGtQor4IGhSE3V3AdjqRqzTR6koQn9yy5N68rGfTIAtHkEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQ8x2HmlXa8sNHUfGf+n0AbFEFBLRCfIg/rY+zZnYAc=;
 b=rc1TV2CO8FE0VGbCF37gGxaoLeGYciAvKCCVeigM/h0yh1+EGNuFv/eU/CHYGBW+qJXpFMi3DSdDwexBqJmJ/5q9sasKr+7PT3kScaEV/gAc9FOw+bzDKpKbZLjUPjtByfvokKHBB1p5oFB0cvJWhXds4Fzj+XfmNGv3jDLxVKs=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 MW4PR12MB7383.namprd12.prod.outlook.com (2603:10b6:303:219::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.27; Fri, 26 Jan 2024 09:00:53 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::62b1:4407:aa73:333d]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::62b1:4407:aa73:333d%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 09:00:53 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: reset gpu for pm abort case
Thread-Topic: [PATCH 2/2] drm/amdgpu: reset gpu for pm abort case
Thread-Index: AQHaTz3TrRHBNnxGnEmGW4ad3K6E4rDqgXsAgAFCxhA=
Date: Fri, 26 Jan 2024 09:00:53 +0000
Message-ID: <DS7PR12MB600523A9E24397369DFDFDE7FB792@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20240125032255.898308-1-Prike.Liang@amd.com>
 <20240125032255.898308-2-Prike.Liang@amd.com>
 <6faf2c64-fe90-484a-902a-66a59e9c3849@amd.com>
In-Reply-To: <6faf2c64-fe90-484a-902a-66a59e9c3849@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8c276697-9a2a-48f3-b9bf-0eaf6118466a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-26T08:26:32Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|MW4PR12MB7383:EE_
x-ms-office365-filtering-correlation-id: a9c9d160-2425-4fcf-430b-08dc1e4d4cff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jNvowTYB4prM+7PtVuPcpbK0fQnT7W/rmTn2YqDEILfl/ZPCIuq6TpGO8OY3cwBPh8OwjBfVn4jUApclZpPhKkqDR/gxvH/184GymgkMJgf60Fp6+D4K52mM/QTIW39kKZ6RHvKwOCAq/BHDvhoIQwGylqlI6OCXpngYt+D2mUjP+bxZoAU0AeyfMsM3e1ErHTN80/YurDAl7mg3VnJzspJPHhNaAwuiUx+cICaONkp+Fp3PSEaPXo7GzXSQWi0+Syn1WkB66o1TUV7FnMBSAYVYWknKwey5OUgGSv0px/YU9iEYhIQ0PnP4nzw1Bc6PPzl30+5iJjRHow30ohTBI7qlY3KUP3ag40yrqBB9UcHJbUD4t7ANdBl5RbIHn6NW/nSKl6tBbeguI6D18uK5+uV2N9iUF3K9Wq5xEYXUGHdtMBafB0Kc1UL5k0gHp0PAC+HfYdTY0DXySTZshXQShQFncr0NQ3WMwifo0SZKQsHDNKnfmLvR0FavF3uG5/EBI3nnEmwStHGu9wUQGPMcY1yZTyQVEri54D4H86aJG7uO1zdAoHQIH9OFz4E/yt/sS8WO6TaF4oQwy1p2QrI+uh6+JZ1bgji1xmjY4LPkOR5r8f58hhbG55Iwb/ri+6h/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(346002)(366004)(376002)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(55016003)(6506007)(71200400001)(7696005)(53546011)(9686003)(26005)(38100700002)(38070700009)(86362001)(33656002)(83380400001)(41300700001)(122000001)(5660300002)(2906002)(52536014)(66476007)(4326008)(66556008)(8676002)(8936002)(66446008)(54906003)(316002)(478600001)(66946007)(64756008)(76116006)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckUzbHZRZTRSV1NUZ0wycVdtWkorbkoxSjVRZUZpQVdlcW1jYVdPRXM1NlJ6?=
 =?utf-8?B?RTVnZ3Vpd21aN1lQcWJuSHl0NkZtYlhFbHB4em10aTRiL3M2YzJJQ2VOSEpa?=
 =?utf-8?B?d1lSdThoQXdCK0E2NEJVQStZY2dkNmVQbkRaUmlnL0VueEVlUk9yeG5ObkhU?=
 =?utf-8?B?ZUNyOHQ2OTZ4YTRsWmlzS1U5Um80OVNlMjMvbU50M2Jwb1FNaGZiT1dBS053?=
 =?utf-8?B?L05QbXJvdGFVWGJiOXpmMERLaGxqNWFTd1hvZlJGZ3c5NjlUVVIrZk9lSU51?=
 =?utf-8?B?YmtJemVOOGh2dHhNNFF0L0VSWDZjS1pRcTR1N3RIMkdBd1paS3BHU3cvc2t3?=
 =?utf-8?B?VjVwSEpYb2xsTk9TL2RpZTBRVE10OUxlUGIvU3VYSkVlaE9BQmt3MGYzNjE0?=
 =?utf-8?B?ajlZVjJ5U1pnMy9CTVJzSVM4dkhWRW9FQy9Wc3BlUzRneTJLT1NRYkhqTVN1?=
 =?utf-8?B?cm9qSFRWSm5Xb3hndjRqZ0Z5TXhubzRMMmFaL21QOUZLYXRzRHBPWDVHTFJE?=
 =?utf-8?B?cmNsWXBDUWF2WFJoUkk3bks4d29YWG11SzBQZzVoN0JOMnZGSXVKeG8xK0VF?=
 =?utf-8?B?U3ZzOE9kSFd5cVNjeTgrZ2pKakFmSHc4YTdDcW9OZHdoY3FXMzNJT0IwMmlI?=
 =?utf-8?B?di9HOFFPZ2lOcWZYQWtFV2Q2STEzQnBZaVk3M2pUV3NJcWRMNGZ2MVI3YkZz?=
 =?utf-8?B?MkdySjZiYWQrUnBETDlNNkJkUy8zSEovNXFBRGlWMDNvc1VCTTB4cVUwaHB0?=
 =?utf-8?B?ZFg5ZDVKTU9rQ0c5eFZoaXByUllJY3RDKzlCYjRtSWdCb2c4OTVrU0o3MklI?=
 =?utf-8?B?TllBZUlWeDYwOHhVTXZzVmE2RVVIRkxYczk3ekxIS2NXTHlJUGJFS1JsbVJY?=
 =?utf-8?B?djRCN2huMVZrbm5oZ0x1cUY3ckZMM2lEa3p5Zms1YTh4a00zTEo1V3RIc3dZ?=
 =?utf-8?B?UTBzQ2t2RGhaV0Uvd2RBdG9RTW1ZU3dyQitJTFMwUFg0UHVoUkttd2lOTGtk?=
 =?utf-8?B?VVB5aXgzRXdTakdOMXRycmFNd1JzSjVGT1VCMlJLTCtHV241SnRlUWNlK3V6?=
 =?utf-8?B?RVVvM1NtVU1ncnRLOHh3eWIzUWdtZ0JPTmV6cm92cEpJeldGZ3lVeFlNVzFn?=
 =?utf-8?B?V0NKOWNjVTRUdkowbnVKUTZKRDlTNVBFei90dndJeU4zQ2JWUjUzUmdISk8v?=
 =?utf-8?B?SEN5b1N4RUFaQXNjbUtsamlKOHBPM3VSWHE1L1JNSjdKcXhHY3FIQmhXR21o?=
 =?utf-8?B?VkdTa0xHSll0alJIZkNqRm5nNStuQ1JNcU0xaFd6VkFWUVJpVE9VSVA0dEls?=
 =?utf-8?B?SkpRMHNVUzZEVUNYczRmbTM0SmhZazdYaUZsNmkrWW1rbDFRT2U3TkNlRlhI?=
 =?utf-8?B?b0o5bDlId29YNi9KTS9CNFo1RDA2dXZ4LzErUGhEbFM2ZWtweFhTMkVXa3pE?=
 =?utf-8?B?N2gwRFhPV25XVHZDQm1UNHJtUmFESkhnNGVEbTVjajRFTDAxQmVMNWtiRS9N?=
 =?utf-8?B?a2RxNGZlMkhONmRkcUdpU2srNFFuYXFTaVNDYWFrcyt5b2lJMy9FUEQzQ21a?=
 =?utf-8?B?dzd5Sk9velloNDljWEJaYTIwamtWaTBBY3lYNE94RHo0UWhUMXQrS2ViZGFj?=
 =?utf-8?B?Y2lTSlJVTDdQWnE1bTdIMTZLSFFFakJISDZyaTI1VGFDYmlpcUNPc3ZQVjBG?=
 =?utf-8?B?NzNCRnhJOXkyQUhnVDl5dmg2ODcvVXRwMFJZM2N0TFg1aVd5NkdRUkJYYzE4?=
 =?utf-8?B?ZGF1cGRLOEthNmFtb25Bd3NWa2pUYWF3c0JqSC9wMC8wNWZmVlpuZzNaZk52?=
 =?utf-8?B?YWViRSszZy94bi9xbG0yZXdNc3JsSEVzeE1xOEtzVVJxNlRnMEJzQWUrdThG?=
 =?utf-8?B?VHdQU05QbU5VUjZlSURuSGhXYzZ0UDRFVko3Smp4Z1pxVnRjcW5TRnhxQzhW?=
 =?utf-8?B?cGlIR0VQR2w3UG5rYytBUDRaa2hxc3NVS0pSdFV5RkNhTFUzOUhnellmMVMw?=
 =?utf-8?B?SmdoakRtbzl2b0tjT0NLZGdxRVVkN0haRkNXZWlmM1luQ1Fka3RqbTNGQlJo?=
 =?utf-8?B?NnQvQnJ6RWpSRlpRK2htT3UxdTlaVXdxOGlYd2ZnR2JaQWd2OVV2NWxrSVRi?=
 =?utf-8?Q?W3qA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c9d160-2425-4fcf-430b-08dc1e4d4cff
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 09:00:53.2585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ChhCEqrrufUW+EeAZ1Tqj37+c06jzY7unXLQh4bPR6z6gQtnFtAEjA7KbWgUz8Bb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7383
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Sharma,
 Deepak" <Deepak.Sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4NCj4gT24gMS8yNS8yMDI0IDg6
NTIgQU0sIFByaWtlIExpYW5nIHdyb3RlOg0KPiA+IEluIHRoZSBwbSBhYm9ydCBjYXNlIHRoZSBn
ZnggcG93ZXIgcmFpbCBub3QgdHVybiBvZmYgZnJvbSBGQ0ggc2lkZSBhbmQNCj4gPiB0aGlzIHdp
bGwgbGVhZCB0byB0aGUgZ2Z4IHJlaW5pdGlhbGl6ZWQgZmFpbGVkIGJhc2Ugb24gdGhlIHVua25v
d24gZ2Z4DQo+ID4gSFcgc3RhdHVzLCBzbyBsZXQncyByZXNldCB0aGUgZ3B1IHRvIGEga25vd24g
Z29vZCBwb3dlciBzdGF0ZS4NCj4gPg0KPg0KPiBGcm9tIHRoZSBkZXNjcmlwdGlvbiwgdGhpcyBh
biBBUFUgb25seSBwcm9ibGVtIChvciB0aGlzIHBhdGNoIGNvdWxkIG9ubHkNCj4gcmVzb2x2ZSBB
UFUgYWJvcnQgc2VxdWVuY2UpLiBIb3dldmVyLCB0aGVyZSBpcyBubyBjaGVjayBmb3IgQVBVIGlu
IHRoZSBwYXRjaA0KPiBiZWxvdy4NCj4NCltQcmlrZV0gIElJUkMsIHRoZXJlIGFsc28gaGFzIGEg
c2ltaWxhciBwcm9ibGVtIG9uIHRoZSBkR1BVIHNpZGUgd2hlbiBzdXNwZW5kIGFib3J0IGFuZA0K
bm93IHRoaXMgcGF0Y2ggaXMgb25seSBkcmFmdGVkIGZvciBhIGhvdCBpc3N1ZSBvbiB0aGUgUlYg
c2VyaWVzLiBJZiBuZWVkIHdlIGNhbiBhZGQgYSBUT0RPDQppdGVtIGZvciBkcmFmdGluZyBhIG1v
cmUgZ2VuZXJpYyBzb2x1dGlvbi4NCg0KPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFByaWtlIExpYW5n
IDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCA1ICsrKysrDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3NvYzE1LmMgICAgICAgICB8IDggKysrKysrKy0NCj4gPiAgMiBmaWxlcyBjaGFu
Z2VkLCAxMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ID4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPiBpbmRleCA1NmQ5ZGZh
NjEyOTAuLjRjNDBmZmFhYTVjMiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPiBAQCAtNDYyNyw2ICs0NjI3LDExIEBAIGludCBhbWRn
cHVfZGV2aWNlX3Jlc3VtZShzdHJ1Y3QgZHJtX2RldmljZQ0KPiAqZGV2LCBib29sIGZiY29uKQ0K
PiA+ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHI7DQo+ID4gICAgIH0NCj4gPg0KPiA+ICsg
ICBpZihhbWRncHVfYXNpY19uZWVkX3Jlc2V0X29uX2luaXQoYWRldikpIHsNCj4gPiArICAgICAg
ICAgICBEUk1fSU5GTygiUE0gYWJvcnQgY2FzZSBhbmQgbGV0J3MgcmVzZXQgYXNpYyBcbiIpOw0K
PiA+ICsgICAgICAgICAgIGFtZGdwdV9hc2ljX3Jlc2V0KGFkZXYpOw0KPiA+ICsgICB9DQo+ID4g
Kw0KPg0KPiBzdXNwZW5kX25vaXJxIGlzIHNwZWNpZmljIGZvciBzdXNwZW5kIHNjZW5hcmlvcyBh
bmQgbm90IHZhbGlkIGZvciBmcmVlemUvdGhhdy4NCj4gSSBndWVzcyB0aGlzIGNvdWxkIHRyaWdn
ZXIgcmVzZXQgZm9yIHN1Y2Nlc3NmdWwgcmVzdG9yZSBvbiBBUFVzLg0KPg0KW1ByaWtlXSBJZiBk
b2Vzbid0IHJ1biBpbnRvIG5vaXJxX3N1c3BlbmQgdGhlbiBzdGlsbCBuZWVkIGZ1cnRoZXIgY2hl
Y2sgd2hldGhlciB0aGUgUFNQIFRPUyBpcyBzdGlsbCBhbGl2ZSBiZWZvcmUgZ3B1IHJlc2V0Lg0K
DQo+ID4gICAgIGlmIChkZXYtPnN3aXRjaF9wb3dlcl9zdGF0ZSA9PSBEUk1fU1dJVENIX1BPV0VS
X09GRikNCj4gPiAgICAgICAgICAgICByZXR1cm4gMDsNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9zb2MxNS5jDQo+ID4gaW5kZXggMTUwMzNlZmVjMmJhLi45MzI5YTAwYjZhYmMg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMNCj4gPiBAQCAtODA0LDkg
KzgwNCwxNiBAQCBzdGF0aWMgYm9vbCBzb2MxNV9uZWVkX3Jlc2V0X29uX2luaXQoc3RydWN0DQo+
IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4gICAgIGlmIChhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJ
UF9SRU5PSVIpDQo+ID4gICAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+ID4NCj4gPiArICAgc29s
X3JlZyA9IFJSRUczMl9TT0MxNShNUDAsIDAsIG1tTVAwX1NNTl9DMlBNU0dfODEpOw0KPiA+ICsN
Cj4gPiAgICAgLyogSnVzdCByZXR1cm4gZmFsc2UgZm9yIHNvYzE1IEdQVXMuICBSZXNldCBkb2Vz
IG5vdCBzZWVtIHRvDQo+ID4gICAgICAqIGJlIG5lY2Vzc2FyeS4NCj4gPiAgICAgICovDQo+DQo+
IFRoZSBjb21tZW50IG5vdyBkb2Vzbid0IG1ha2Ugc2Vuc2UuDQo+DQo+IFRoYW5rcywNCj4gTGlq
bw0KPg0KPiA+ICsgICBpZiAoYWRldi0+aW5fc3VzcGVuZCAmJiAhYWRldi0+aW5fczBpeCAmJg0K
PiA+ICsgICAgICAgICAgICAgICAgICAgIWFkZXYtPnBtX2NvbXBsZXRlICYmDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICBzb2xfcmVnKQ0KPiA+ICsgICAgICAgICAgIHJldHVybiB0cnVlOw0KPiA+
ICsNCj4gPiAgICAgaWYgKCFhbWRncHVfcGFzc3Rocm91Z2goYWRldikpDQo+ID4gICAgICAgICAg
ICAgcmV0dXJuIGZhbHNlOw0KPiA+DQo+ID4gQEAgLTgxNiw3ICs4MjMsNiBAQCBzdGF0aWMgYm9v
bCBzb2MxNV9uZWVkX3Jlc2V0X29uX2luaXQoc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYp
DQo+ID4gICAgIC8qIENoZWNrIHNPUyBzaWduIG9mIGxpZmUgcmVnaXN0ZXIgdG8gY29uZmlybSBz
eXMgZHJpdmVyIGFuZCBzT1MNCj4gPiAgICAgICogYXJlIGFscmVhZHkgYmVlbiBsb2FkZWQuDQo+
ID4gICAgICAqLw0KPiA+IC0gICBzb2xfcmVnID0gUlJFRzMyX1NPQzE1KE1QMCwgMCwgbW1NUDBf
U01OX0MyUE1TR184MSk7DQo+ID4gICAgIGlmIChzb2xfcmVnKQ0KPiA+ICAgICAgICAgICAgIHJl
dHVybiB0cnVlOw0KPiA+DQo=
