Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23379C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Mar 2022 02:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5605110E4F8;
	Tue, 22 Mar 2022 02:57:21 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2063.outbound.protection.outlook.com [40.107.96.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B096910E4F8
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Mar 2022 02:57:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqPSrdFXcEEqD7OWVx566xgpZPKIOLNu+rOJ3SyeUBR/MUCt1TMoDGYvFKFfCUsHpeWzB2tQKGOw83FCiJ+yVCTikzlUnhJgkwb4dJnV56S62iyGM5pvyKZ+xu6hzGvEG28+HT1eExrNGdESuqWQ6Ex0e/8RvsR00ItsVitjgR1z3Fa7aV0o75NwJBxmPD/qBTaEiqo2tjvNW1fmOQnwAv4Kae+S6iapq8FLXzmD0ir33jbF39e1g57Rs3qoN6ZcS3Z/e3OrqdaEBrdcfUx3pwqdttMIs77Lt16fOjUpz2nvfGlnUh3TeZiDewfALgj4kmqqqmwvNoiQBnmKrkqQCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T40qs8MmmmJ+P83YKiNzIlLSDL8Vak+1z7gINswo2hE=;
 b=PLQUplLHiMKgdTXA1iK5fHZDtxQQ+LpPD8l6Rv1XXvfZJKqsR7+mZCvfWM1UtubB2tMbEbUlZ3fSgAEZvQifd2U35+Qu+Rn32AE3xPH8VX4i1gUz7EyH0T/fKex6IBDEIpSut2xXQvE1g+Qe0d1cvS4fYtU6jzWs+ullvTWyE6ye7PkfJuGO7N+dZTY0m9B7Kb0i2GH7W83pM5KK3gWjGaMi2vbPUd+6/no2wvx/NipPjOlneqC+EYr0uLHAtE2GEZNhsvaw2oBPw92ZvierKLwv4tiitlZV2TScgxdh8ajX22QXAHykZirgc13QRSi5Qzen8azaHhO4h/dbdGf/JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T40qs8MmmmJ+P83YKiNzIlLSDL8Vak+1z7gINswo2hE=;
 b=jH7gMHpKxb5AJ2uCVKWpxBK3TMSgTC0Xxgrbj1mtDiPRIOKsIHQv7bsTv/LqBChOUefC2fsAgz9VVGJtec3OxDhMLMXCS8im4lNlvsRNWwbzSYfx/YKH5munVDu1DZKfZi1gV5IQBueARi5gxKn/x1zhNOldOnO9CkdH+tNMQOY=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by DM4PR12MB5151.namprd12.prod.outlook.com (2603:10b6:5:392::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Tue, 22 Mar
 2022 02:57:17 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f%3]) with mapi id 15.20.5081.019; Tue, 22 Mar 2022
 02:57:17 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [PATCH] drm/amdkfd: print unmap queue status for RAS poison
 consumption (v2)
Thread-Topic: [PATCH] drm/amdkfd: print unmap queue status for RAS poison
 consumption (v2)
Thread-Index: AQHYPQduuVaBtZt7+kyIHY5y8KDziqzJp+8AgAELlBA=
Date: Tue, 22 Mar 2022 02:57:17 +0000
Message-ID: <DM5PR12MB1770E56F3E2A5171EE11D05AB0179@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220321093818.24270-1-tao.zhou1@amd.com>
 <14f7d9cc-e0e2-260f-0073-dde2d40a44f1@molgen.mpg.de>
In-Reply-To: <14f7d9cc-e0e2-260f-0073-dde2d40a44f1@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-22T02:44:44Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d3d33097-b983-4f6a-a74c-4a46b7f24aea;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-22T02:57:13Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 88123d7d-a4a7-460f-8974-33a740c08752
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd114fe1-2785-4c6a-54fe-08da0bafacda
x-ms-traffictypediagnostic: DM4PR12MB5151:EE_
x-microsoft-antispam-prvs: <DM4PR12MB5151C34D831FECC99615E707B0179@DM4PR12MB5151.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l8gE+whWzNP6Xh0BtIhU4ZnNqlspV9M8eYz6N3rf7f8FwXMAASZOKfOdlwzULN925RsAmcNmXfkO6dyQ65WLKSrdT7OoPIU9LFDurNro/e6jH+/R1zVfaWok3WcFlua2XpXAZRdzwY59pA0Nz3J4zwgCtoxzdzCCihHvJNc+PemYfyc3QtAUcOMeky+yCrXS6IvmmWjzVu5S33CC61DRocxXZffDH6uYCFpAs8+L1UTfjjYKaLxfIIfFUkPJGP5vyBTPbXpsjaHYRlkyPqDOYBjwrYT/NzJ3NOLLTsSOwGkke6wi5wC0qz0JKEF8/l97ihq5Lfc0iE8w+rneTo0+Jp83cAug5Rr9uQN0M3cBveGk88RhgN6kRnJKfrQeyGSH4ThNRmKTNB4RGj63gdrrsr31oTK+29ihMgO0vk1jBZMn1S0pwUyBBjJ5AI5EOBrEvZiVJHDcRMbGAAYbEbMO7Yw6zSaXuKSJJmoraURyJPon+Ph/jLcnWG0yDaF3XFaG7I6PMMhEhof2I6ym3FwJXnfk4lVyF3nzt76NpKfbRq+iED1v+Oret85yUo1bnS20UwO+jkJZj3jCkgGjJ0Et7rvGg3M5O2C7u5kJ+uF9vNriAV/v3uYiKOZeoLl1U2xr0udJfDo0HeaP3K1FGQ4FcEAoePw8E1Q9twwcDKrbqSheaCNy/PVoFLNHnWHKliuC4dJdYC0xMWfBBNQEje7Ccg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(508600001)(86362001)(186003)(26005)(66476007)(6506007)(33656002)(66556008)(64756008)(66446008)(83380400001)(2906002)(38070700005)(8936002)(71200400001)(7696005)(53546011)(54906003)(6916009)(52536014)(9686003)(55016003)(76116006)(8676002)(4326008)(66946007)(122000001)(316002)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vk0zNXpmM2dvTGtGZW81ZmY5M0J2V1ZLcFZ1QVdyZVA5RWNRd3hLVW10ZEFx?=
 =?utf-8?B?dGlGTTczK21jaDU2elRvRWQyY1pVcUkzb01DTWMwUFJlMUdWM0NQd01vdDFs?=
 =?utf-8?B?bUxaaGpoa2o1aXc4bWs0N0p6YWtkdGI3RGpLckwvQzdmZkMyR0FINDRWcitN?=
 =?utf-8?B?RUxhbjdoRG1PK2NLY1JzYW82aWozOTZFMkZSamRqNWszZ0NSZDBaZHFIek5y?=
 =?utf-8?B?dkZYWE5VTm9XaWF2NU51M1JoakRYamt5Z1Z6b1FmQXN2OCtpY3phajBkTC8z?=
 =?utf-8?B?WHB2YnVjeVpQYml6cHg1VDRManMxREhxUGdlaExEQTBCWnZaZGtQOEpoVExR?=
 =?utf-8?B?WGNoQkFnK3BqUmRWUXFEQlRRRjFkY2xqdGNHY2tMbXN5WmpYMzBiV3ZLTUNh?=
 =?utf-8?B?U2doWHBFME0zaUFackhaYnRHRGpKaFRSbUtQaXFjZVE1bWpZOGFON1BVM0lq?=
 =?utf-8?B?bmpnM1ZMcFdaN3JYQkVpaEMzSm5BNG1rV25ZOEttT0NHdHhXRXp3d29mMi9F?=
 =?utf-8?B?bHdLSXUyVk9DQ2pDR3lQQWlmVkdtbnRoUHBvcTBVMVB3dUJWZU84emdjbmk1?=
 =?utf-8?B?Z2kvKzVqaE1BWWI4WlFiTmFvcjRnbHByRENkZnY2MzBYOWVFaEtiNzY4V2Zi?=
 =?utf-8?B?Qk9QQ21yNEdONlRQNkxWT0ozUGhoS3gyZVJaTE5SdWVXSXZhNUZBZlJ5dGVw?=
 =?utf-8?B?L0IyWWRtSjFaVzNkb291bHdvQzBGVVZtOFIzMGIrMEpJWnpwTWFDaXRkQ3NY?=
 =?utf-8?B?TVpDQUF3VnBRYTkrM3BlUGlmTXFmQjVDZllCU0NJUFRBb1lxNW9rcjBWbmZK?=
 =?utf-8?B?eVhjZUNreU9SQUNtK0JUVXgyMGpCaldWZVJqNDhPZUthbUFONUZsbTdVM2pu?=
 =?utf-8?B?NGhZSmIrbVRoMkU3SENLNnpDTTFvVzg5RjJ0Vmk4bkZQY0Y0SmVmczlyNGgr?=
 =?utf-8?B?bkJ3bUo2S0VDNVdDcGVEV3kvU2drQ0c3aTRJYnVQSmhQSnpTdHUyMmNwSHBJ?=
 =?utf-8?B?Vzd5NEI3MzhKdFFKTmdrYzVmWGlhenpvSVVYUldEUDVhVHd2YnZnWVpTWUR5?=
 =?utf-8?B?OGl6WlMyMWRLc3VKZy9XalN3SWNOTWQwTVhMeForQXA2Q2F3Q3NhVW1BYTFk?=
 =?utf-8?B?N3puTXBHV2xvSHFlTXBNSUhxa2gvVWE0UkZvOWFnK1B1c3Q1bDkvUTdsMHR6?=
 =?utf-8?B?bmVTU0dmOGlaM3VUcTFsbE4ybU14dFkyN2F0SjZaQ25tTzVPellLNE54MWha?=
 =?utf-8?B?eUJHQXYzOE5ES3V4VGhRem5yRUl2WlZRdVVvcDJvREZpTGVhZGZCRW9QQkZT?=
 =?utf-8?B?c2FUZHY4UXRPcUoyUXFyVldRYm1xbXFKcnNXaGpQd3pDOHgwUDVCb3dxdG5a?=
 =?utf-8?B?bFUzWjRhNGx0ZmV1cm80TldRcVkxdFdhWGpydjRiVEVVUW1CeXVZemwyWUR4?=
 =?utf-8?B?YjRGL0hLNDI4ZUtKbGphbndTeUdtWlduM2hGQXVpMFdYbDBGWE9RbVQ3ci9O?=
 =?utf-8?B?VHNGTzVGT0U3R0tZeFNlUzBzdTNtQjMrR0hBaUViYytXY0F2NDErR3FSMlRy?=
 =?utf-8?B?SEJ1Vk1FSGlKMDR4V3doaGh0SVZpbjV6SDMwaXN0dDhWd0dGbkRQSW9qVnk4?=
 =?utf-8?B?M1BJQk5hQW02QzFzcnlCU25uNlpHNzlaaFBJL1NLK0dkN2t2dVo4dnplWVRx?=
 =?utf-8?B?N2xQUWFYb1RxN3RVQnhKdnd0R21teVhnb0RnVU5FRHhPeWdlRTExbndkT3pu?=
 =?utf-8?B?c2d1aTM4Vko0akJncTMwT2E2N3dqVmladzFjczZhSi9GZzNhalRmR2NmR0RE?=
 =?utf-8?B?ZjRWVDJxWm5EVnF3TDBZQU5qdmltZDZyVWRrNXQ5L3lMSWp6ZU5NZkR4QXdx?=
 =?utf-8?B?aDErRUhWeTMyekoxRm43Q2U0STdpZVgrT1ZobVZIanhtZHhmaG00ck9scW52?=
 =?utf-8?Q?S+iWBAEBdVQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd114fe1-2785-4c6a-54fe-08da0bafacda
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 02:57:17.2112 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wokMgKwgnO6Z/4JXq4wWEiyNzMnhTc2d2rEB7Yxhn/0lAIm/Ly6m9ri+MWWJYP3L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5151
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Chai,
 Thomas" <YiPeng.Chai@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang, 
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogUGF1bCBNZW56ZWwgPHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4NCj4gU2VudDog
TW9uZGF5LCBNYXJjaCAyMSwgMjAyMiA2OjQ3IFBNDQo+IFRvOiBaaG91MSwgVGFvIDxUYW8uWmhv
dTFAYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBaaGFuZywg
SGF3a2luZw0KPiA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgS3VlaGxpbmcsIEZlbGl4IDxGZWxp
eC5LdWVobGluZ0BhbWQuY29tPjsgWWFuZywNCj4gU3RhbmxleSA8U3RhbmxleS5ZYW5nQGFtZC5j
b20+OyBDaGFpLCBUaG9tYXMgPFlpUGVuZy5DaGFpQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIGRybS9hbWRrZmQ6IHByaW50IHVubWFwIHF1ZXVlIHN0YXR1cyBmb3IgUkFTIHBvaXNv
bg0KPiBjb25zdW1wdGlvbiAodjIpDQo+IA0KPiBEZWFyIFRhbywNCj4gDQo+IA0KPiBUaGFuayB5
b3UgZm9yIHRoZSBwYXRjaC4NCj4gDQo+IA0KPiBBbSAyMS4wMy4yMiB1bSAxMDozOCBzY2hyaWVi
IFRhbyBaaG91Og0KPiA+IFByaW50IHRoZSBzdGF0dXMgb3V0IHdoZW4gaXQgcGFzc2VzLCBhbmQg
YWxzbyB0ZWxsIHVzZXIgZ3B1IHJlc2V0IGlzDQo+ID4gdHJpZ2dlcmVkIHdoZW4gd2UgZmFsbGJh
Y2sgdG8gbGVnYWN5IHdheS4NCj4gPg0KPiA+IHYyOiBtYWtlIHRoZSBtZXNzYWdlIG1vcmUgZXhw
bGljaXRseS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRhbyBaaG91IDx0YW8uemhvdTFAYW1k
LmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9pbnRf
cHJvY2Vzc192OS5jIHwgMTEgKysrKysrKy0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2ludF9wcm9jZXNzX3Y5LmMNCj4gPiBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9pbnRfcHJvY2Vzc192OS5jDQo+ID4gaW5kZXggNTY5MDJi
NWJiN2I2Li4zMmM0NTFmMjFkYjcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX2ludF9wcm9jZXNzX3Y5LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfaW50X3Byb2Nlc3NfdjkuYw0KPiA+IEBAIC0xMDUsOCArMTA1LDYgQEAg
c3RhdGljIHZvaWQNCj4gZXZlbnRfaW50ZXJydXB0X3BvaXNvbl9jb25zdW1wdGlvbihzdHJ1Y3Qg
a2ZkX2RldiAqZGV2LA0KPiA+ICAgCWlmIChvbGRfcG9pc29uKQ0KPiA+ICAgCQlyZXR1cm47DQo+
ID4NCj4gPiAtCXByX3dhcm4oIlJBUyBwb2lzb24gY29uc3VtcHRpb24gaGFuZGxpbmc6IGNsaWVu
dCBpZCAlZFxuIiwgY2xpZW50X2lkKTsNCj4gPiAtDQo+ID4gICAJc3dpdGNoIChjbGllbnRfaWQp
IHsNCj4gPiAgIAljYXNlIFNPQzE1X0lIX0NMSUVOVElEX1NFMFNIOg0KPiA+ICAgCWNhc2UgU09D
MTVfSUhfQ0xJRU5USURfU0UxU0g6DQo+ID4gQEAgLTEzMCwxMCArMTI4LDE1IEBAIHN0YXRpYyB2
b2lkDQo+IGV2ZW50X2ludGVycnVwdF9wb2lzb25fY29uc3VtcHRpb24oc3RydWN0IGtmZF9kZXYg
KmRldiwNCj4gPiAgIAkvKiByZXNldHRpbmcgcXVldWUgcGFzc2VzLCBkbyBwYWdlIHJldGlyZW1l
bnQgd2l0aG91dCBncHUgcmVzZXQNCj4gPiAgIAkgKiByZXNldHRpbmcgcXVldWUgZmFpbHMsIGZh
bGxiYWNrIHRvIGdwdSByZXNldCBzb2x1dGlvbg0KPiA+ICAgCSAqLw0KPiA+IC0JaWYgKCFyZXQp
DQo+ID4gKwlpZiAoIXJldCkgew0KPiA+ICsJCXByX3dhcm4oIlJBUyBwb2lzb24gY29uc3VtcHRp
b24sIHVubWFwIHF1ZXVlIGZsb3cgc3VjY2VlZHM6DQo+IGNsaWVudCBpZCAlZFxuIiwNCj4gPiAr
CQkJCWNsaWVudF9pZCk7DQo+IA0KPiBzdWNjZWVkZWQ/IEFzIGl04oCZcyBhIHN1Y2Nlc3MgbWVz
c2FnZSwgc2hvdWxkIGl0IGJlIGFuIGluZm9ybWF0aW9uYWwgbWVzc2FnZT8NCg0KW1Rhb10gdGhh
bmtzLCB3aWxsIGNoYW5nZSB0byB1c2Ugc3VjY2VlZGVkIGJlZm9yZSBwdXNoLiBBbHRob3VnaCBp
dCByZXBvcnRzIHN1Y2Nlc3MsIHBvaXNvbiBjb25zdW1wdGlvbiBpcyBub3QgYSB1c3VhbCBldmVu
dC4NCg0KPiANCj4gPiAgIAkJYW1kZ3B1X2FtZGtmZF9yYXNfcG9pc29uX2NvbnN1bXB0aW9uX2hh
bmRsZXIoZGV2LT5hZGV2LA0KPiBmYWxzZSk7DQo+ID4gLQllbHNlDQo+ID4gKwl9IGVsc2Ugew0K
PiA+ICsJCXByX3dhcm4oIlJBUyBwb2lzb24gY29uc3VtcHRpb24sIGZhbGxiYWNrIHRvIGdwdSBy
ZXNldCBmbG93Og0KPiBjbGllbnQNCj4gPiAraWQgJWRcbiIsDQo+IA0KPiBGYWxsIGJhY2suDQo+
IA0KPiA+ICsJCQkJY2xpZW50X2lkKTsNCj4gPiAgIAkJYW1kZ3B1X2FtZGtmZF9yYXNfcG9pc29u
X2NvbnN1bXB0aW9uX2hhbmRsZXIoZGV2LT5hZGV2LA0KPiB0cnVlKTsNCj4gDQo+IENvdWxkIHRo
ZSBsb2cgYmUgbW92ZWQgc29tZWhvdyB0byB0aGUgaGFuZGxlcj8NCg0KW1Rhb10gQ291bGQgbm90
LiBVbm1hcCBxdWV1ZSBpc27igJl0IGNhbGxlZCBpbiB0aGUgaGFuZGxlciBhbmQgY2xpZW50X2lk
IGlzbid0IHRyYW5zZmVycmVkIHRvIHRoZSBoYW5kbGVyLg0KDQo+IA0KPiA+ICsJfQ0KPiA+ICAg
fQ0KPiA+DQo+ID4gICBzdGF0aWMgYm9vbCBldmVudF9pbnRlcnJ1cHRfaXNyX3Y5KHN0cnVjdCBr
ZmRfZGV2ICpkZXYsDQo+IA0KPiBVbnJlbGF0ZWQgdG8gdGhlIHBhdGNoLCBhdCBsZWFzdCBJIGFz
IHVzZXIsIHdvdWxkIHdpc2ggdGhlc2Ugd2FybmluZ3MgdG8gYmUgbW9yZQ0KPiBlbGFib3JhdGUs
IHRlbGxpbmcgbWUsIHdoYXQgdGhlIHByb2JsZW0gaXMsIHdoYXQgZWZmZWN0cyBpdCBoYXMsIGFu
ZCB3aGF0IHRvIGRvDQo+IHRvIGZpeCBpdC4NCg0KW1Rhb10gSXQncyBkaWZmaWN1bHQuIFlvdSBu
ZWVkIGEgZG9jdW1lbnQgaW5zdGVhZCBvZiBkbWVzZyBsb2cgdG8gdGVsbCB5b3UgYWxsIHRoZSBk
ZXRhaWxzLg0KDQo+IA0KPiANCj4gS2luZCByZWdhcmRzLA0KPiANCj4gUGF1bA0K
