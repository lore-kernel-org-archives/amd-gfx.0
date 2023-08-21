Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA308EE4993
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Aug 2023 07:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B87410E1F9;
	Mon, 21 Aug 2023 07:19:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 839EF10E1F9
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Aug 2023 07:19:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsAxxtrcJ7VDDG6a5Jy8dFtRcD3DYg/y0hFInDykzE42J7dUDKVxnNuh1XdsFBXhcIJzP8bMu01fwtHivGEXgGjs6oMgcd9ep9nfSQhgSvzZIQ2V/aWBh8pp7XxCOr/Rcb1CxhxLIcUecl5yUzPVR7mgyDQhiIjxLBKWIjOpDe2SmZJUTQFaRVJeugVArUfmtz/Cf0DDON2x/S9XWaUX8ym3JTfSjXT7asoWWnjO99DiVLSuAElz5UDpeZlQk0qL5AIS7EKpAxO+prhNTOn+njU7PVtAsKR0yqi04buT3BVSnGTBLijq27yR0ZltBWry9QlDEBE+CDtYMlDyAFLRdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vwti1aLhKqCd76elkEflyAPKw/NyUX6mupgSknPfF0=;
 b=fq2vFOZIXZHYpntlIuGbop3qDt70Hp5g83q4M6pHPAG8lJ+ITHQVX9At79IXvIwySsPvDFMRN3CfU80Af05DiFUF+9yaMrBonr99Ndx0u2egWzI4McWJDXTRM43SOvhC56QS/wD1o1HMZWhr52UYMUWqDzGaDJiDSuTsR1//1rSEMitaMmbucsSWi0/mgxu+QcZ3ncp8q7Gbf0gb2SkTCuBMLixQC9c5JpKoats9vMyqNZd+42R9bcDBeY4bCgrgXfuG9cVXoJc8KJmmsk6u+03iTtKoYTgj1OCwDpkLLDoRsKbHMYODOA7grg1Nc64RiQIlkOBrncjSk4cRRJnGmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vwti1aLhKqCd76elkEflyAPKw/NyUX6mupgSknPfF0=;
 b=BHtlE/vdr+rExDKtiDgMce8V14ke2RI4hrS+uEv0zFGcdEPwdT1vuhceyTEhvN5sspH5hJDuuXA0VULnJBK5A6RbigiMrDyXPBAAS4JCezbBAqx71+4mbiw01Xl5TQqFCkkY17HEjJUV9P6PAKEcptYKtZx8Kf6WqrefxJtT32Q=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 BL1PR12MB5125.namprd12.prod.outlook.com (2603:10b6:208:309::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 07:19:32 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::c363:292a:63cc:ccf4]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::c363:292a:63cc:ccf4%3]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 07:19:31 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Fixes incorrect type in
 'amdgpu_hwmon_show_power_avg() & _input()'
Thread-Topic: [PATCH] drm/amd/pm: Fixes incorrect type in
 'amdgpu_hwmon_show_power_avg() & _input()'
Thread-Index: AQHZ0/WcVLGmwPZM50C9uxp2w+ZiXa/0RtWwgAAEwICAAAumQA==
Date: Mon, 21 Aug 2023 07:19:31 +0000
Message-ID: <DS7PR12MB6071C7E8D56028E8F4AF5A158E1EA@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20230821060556.937890-1-srinivasan.shanmugam@amd.com>
 <DS7PR12MB6071B741DB5AC800FEC35FCD8E1EA@DS7PR12MB6071.namprd12.prod.outlook.com>
 <4390e727-fd8f-40a6-aa46-1216e4ed02d0@amd.com>
In-Reply-To: <4390e727-fd8f-40a6-aa46-1216e4ed02d0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0bcfdef4-689c-449d-a6f1-38b7103a02ab;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-21T07:17:42Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|BL1PR12MB5125:EE_
x-ms-office365-filtering-correlation-id: 3cc39fda-e987-4733-cb0e-08dba216f6d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mf2bpDuF3xmSXoH2CjfL7rvacyk6LAJ5L4tAb0u3lPCIW9mSgaVY6se0IWUYG5sX5PuFBmNMfTfk7Wr6Una6MCfFL+RG+hi0nkgu/1qzfJgliI0Tyjk5SRqDVAiwFuNvbM9PHcoIbHuNc9TY4qnLBlCulOYVnpIs3yqspfsDdTuVEWmOSFAzBvK8Z+HbcKIPsdGo2E1bZ3h6UmtEryNmWlarmwjZRFYiVCabljhYEVWIWaP8ejgEUrLsknZUeGzgtXGLDqVK77Hyo1xgH1M3dJAmbeDRUgppemshpW2ZsV3d21xuAeqJqkoANfvqgSOksqdPnKZ3HOD5TZ7CIHiVt8LVsNELx2Ms9ll9ug5wotOI0PucZewcp/tnX/eyklXnyco6bBJaO+6lpzvM04RDRhtmpfwcfzjoMwUJ0SLWMWM9DhKzzCPR7FHK/xryVm6nLtOO3Zt1yWfR6cTsj7jeHqqyVu9yr0y6ocLMm7GQ5bYqtjrj7P+nWxgrwFVR4/w9RWrmoJw5/7OukYdIQ7daTsNYfPyIbVakjn2qhzM8+EjrCmD2ErYVhVlf2pfyS8uglHCgI2TJ/dESnzB4SHXv0qLlt0T2mexcI90MklcFAN8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199024)(186009)(1800799009)(66574015)(2906002)(83380400001)(53546011)(38070700005)(7696005)(38100700002)(6506007)(5660300002)(52536014)(33656002)(26005)(86362001)(8676002)(8936002)(4326008)(66946007)(316002)(9686003)(64756008)(54906003)(6636002)(66446008)(66556008)(76116006)(66476007)(110136005)(966005)(478600001)(122000001)(55016003)(71200400001)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1R4aTZKOWl0aGIrc0JLWnRMSDRCd3VFdjlCdlVSYTE0eTUxd09WczBrMU9m?=
 =?utf-8?B?eVdReXNTME51Uk9aSk1DM25tNlZHYjZZdldEZEdET3Q5VDlRb3l5czZTQ1di?=
 =?utf-8?B?T2lxVWVRbk1La1VYUzR4aXQ4MDgxOG12R2wrdmthN2VqR05nRVpIcWkySWhU?=
 =?utf-8?B?YjQ5N1d5QitjRjUzWHFhVEZPbGFNc3l4M1lSUHd3RTRQbGtMNjRlUCtuVU1l?=
 =?utf-8?B?NndTZkNJS0YxR29jeUJBK21FRHljL2ZIN1pLbjVDbm1lOEU2dmh0MTBWbEZu?=
 =?utf-8?B?N2dLY1RhTm5jZGp0ZzBWVHkzbEsralA3ZEVUUW5UR3dXR2xjSWQ3ZHFrV1Fm?=
 =?utf-8?B?RGl3UnRUMnZxZUg2K2RPRUtDMTA1Zk9ZUmJpL0hGaHVyL2lLSkRwRExYdWgy?=
 =?utf-8?B?N25xZ0l6UG5saHByVDF6cFZJbFhITmNaUmpuTG9CcmVrb2RKR082aWpyQTJT?=
 =?utf-8?B?S1NiYnlMeVUzdFdmMmEyYUw5ZXNuVU5EVnpZVkoyWitDS2gwZk94TDVtdHJq?=
 =?utf-8?B?b2pRb1VFdDNvSytiellnd1VDZnFJMzVzeFlYUTVCZEt3VlFaWi9EUy9ROFFm?=
 =?utf-8?B?RHNlaERzdnQyUmtZWklEL2ZmdXV1R0R1OWxRUEIxdGVCcXFHMGZPVkVoOGc3?=
 =?utf-8?B?Q0wydUtRK05iT0YvRkk2dm9wY1lnalhyUkhSWTZJRGtmbEI3VGw5TFhzYytz?=
 =?utf-8?B?Z2tWQWlRMS9DRWlxTnhneG1ZN1FGUEsxb1Fzcm80eUg0bnYrcFcwQWZTVU9w?=
 =?utf-8?B?MEpheWhUN1poZksrYTJLaThSZmxEcEVCMEZOa1VUUG9iTTVSMUVwMnZlZzhi?=
 =?utf-8?B?a2sxMnA5V0QrKytWRWFMTE5tTGwxRGxySnA3SHJXRUxqVHVkbmVSajdmek53?=
 =?utf-8?B?Wnhsb1ZLMG9YR1B4SFdaQ0VHVzQ3QUNiSENTVEZ6bjBOSGNzWE1WcHo1cnFn?=
 =?utf-8?B?ekxuQmhwRXpxblplNmhqQVM5OFhlQnUyb2piQ2M5UEJSeC9zd3hQSnZ6NjlF?=
 =?utf-8?B?cnIzaGRtdVV0QmphcGhwV0dvSGlZc2ErUXNhcUN3SFIyWEhsWkFmdGh3NkFp?=
 =?utf-8?B?NnJrKzk5Y2ppcmY2OVB0VUFMcSt5a2tEZHRVUFVlOCt5WkZYM3ZUb25UZkVH?=
 =?utf-8?B?aXhEeXRPblc2eS80aTVKcGlxVHdNalJjR0FicG05Q0F6YmZmTzRQVjV4TzJ4?=
 =?utf-8?B?Qm4wUmZEaURMT2lqdUlaZVZER2hRcXhiRnM0d1ZBLzhtSGp5R1EveWF4Umcz?=
 =?utf-8?B?Q045Ui9oSXo5aWlxQ2hleWcxMnJCYnMxQ2x2OWtUVFdENFVpaW01ZDc2THhF?=
 =?utf-8?B?cGVUejE4OWg2cHhwTkhMNlV0cldCZmVuUHdEVndXcE1ZR09lMEk1RTMrMTFy?=
 =?utf-8?B?c2tTVUVqZ3VIWHdOTEluTFN5NGdHc3BiR2RyQVVCZW9hTFUvT1pnbk5NbDhS?=
 =?utf-8?B?WjUzQVVOMUd3V0YzUHphb05tQ1FqOXhSdGQ2cXBIc0tTVGlvNllLNDMxaFBI?=
 =?utf-8?B?eFp1dW04OElMNkRlRllsZTFpbm1MZGxTMkx6UjVCbXdZR0FHamhoSXc4TGRN?=
 =?utf-8?B?ZkR5VG5idWc0KzV1eG1ub05xWnpxS2NTN3NpcG1Ob0lScFo5NXRsTzJCSVBP?=
 =?utf-8?B?enMzdytzWm1SUjZISExHbitQMzdJK3lxbHUrdUtZRVkvUFNCai9QVGJiTWZj?=
 =?utf-8?B?ZUg4TTJsb1c1c1ppeVVMMWQ4emIzRUovMC9nQXpsQUJmYnBBTVUvTUpQaFM5?=
 =?utf-8?B?QVJYVzMrOEtHWmFpcUlVVGJDdUpQVWN5MHNXTFZZNEk1Nnl4dDQ4L1RYM1Jk?=
 =?utf-8?B?SkNOMEs1RmtQZDY3T3dBTkVsU2x0WU12dFdTd1A3N0dNMU15eGcrS3BZVDZv?=
 =?utf-8?B?QTcza1RHQWsvVForcS9iditvTkxNc25KQXJkR3lmNjNQOVJ2VWttWm1xQ1di?=
 =?utf-8?B?M2NiUHl6ZXRIMW1taTA0cHZUYm8vd3k0aGVKVTI5T21jSkN1ZHV2MWVuR2Jz?=
 =?utf-8?B?QWN2dExYV21JWlVJeWQ0YmxGdXdqQmdWRlVjZWx5ZjVhRG04NXlCc21zaFJX?=
 =?utf-8?B?SzlsdTlZMk9yYkhWaFFadWtmcHNEWUZTZ2FkcXpZS1RrUEJCbGNrbU1meGFR?=
 =?utf-8?Q?vHUU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc39fda-e987-4733-cb0e-08dba216f6d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 07:19:31.7075 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iXyGPzy0FD9wo/6ZxT+AXWWqm0ykDeDGdTzLOmIb5jTa6HEnSKty+i5S/u3hkxDjzsiQntJ867tHsah1D4/Vvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5125
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCldpdGggdGhlIGZvbGxvd2luZyBw
YXRjaCBpbiBwbGFjZQ0KaHR0cHM6Ly9wYXRjaHdvcmsuZnJlZWRlc2t0b3Aub3JnL3BhdGNoLzU1
MzQzMy8/c2VyaWVzPTEyMjY0MCZyZXY9MQ0KDQpSZXZpZXdlZC1ieTogQXNhZCBLYW1hbCA8YXNh
ZC5rYW1hbEBhbWQuY29tPg0KDQpUaGFua3MgJiBSZWdhcmRzDQpBc2FkDQoNCi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4u
U0hBTk1VR0FNQGFtZC5jb20+DQpTZW50OiBNb25kYXksIEF1Z3VzdCAyMSwgMjAyMyAxMjowNiBQ
TQ0KVG86IEthbWFsLCBBc2FkIDxBc2FkLkthbWFsQGFtZC5jb20+OyBTSEFOTVVHQU0sIFNSSU5J
VkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8
Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIu
RGV1Y2hlckBhbWQuY29tPjsgQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPg0KQ2M6
IFBhbiwgWGluaHVpIDxYaW5odWkuUGFuQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZC9wbTogRml4ZXMgaW5jb3JyZWN0
IHR5cGUgaW4gJ2FtZGdwdV9od21vbl9zaG93X3Bvd2VyX2F2ZygpICYgX2lucHV0KCknDQoNCg0K
T24gOC8yMS8yMDIzIDExOjU5IEFNLCBLYW1hbCwgQXNhZCB3cm90ZToNCj4gW0FNRCBPZmZpY2lh
bCBVc2UgT25seSAtIEdlbmVyYWxdDQo+DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9u
IEJlaGFsZiBPZg0KPiBTcmluaXZhc2FuIFNoYW5tdWdhbQ0KPiBTZW50OiBNb25kYXksIEF1Z3Vz
dCAyMSwgMjAyMyAxMTozNiBBTQ0KPiBUbzogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5L
b2VuaWdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJA
YW1kLmNvbT47IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNvbT4NCj4gQ2M6IFBhbiwg
WGluaHVpIDxYaW5odWkuUGFuQGFtZC5jb20+OyBTSEFOTVVHQU0sIFNSSU5JVkFTQU4NCj4gPFNS
SU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zw0KPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWQvcG06IEZpeGVzIGluY29ycmVjdCB0eXBlIGlu
ICdhbWRncHVfaHdtb25fc2hvd19wb3dlcl9hdmcoKSAmIF9pbnB1dCgpJw0KPg0KPiBUaGUgdmFs
IGlzIGRlZmluZWQgYXMgdW5zaWduZWQgaW50IHR5cGUsIGlmKHZhbDwwKSBpcyBpbnZhbGlkLCBo
ZW5jZQ0KPiBtb2RpZmllZCBpdHMgdHlwZSB0byBzc2l6ZV90DQo+DQo+IEZpeGVzIHRoZSBiZWxv
dzoNCj4NCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfcG0uYzoyODAwOjUtODogV0FS
TklORzogVW5zaWduZWQNCj4gZXhwcmVzc2lvbiBjb21wYXJlZCB3aXRoIHplcm86IHZhbCA8IDAN
Cj4gZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfcG0uYzoyODEzOjUtODogV0FSTklORzog
VW5zaWduZWQNCj4gZXhwcmVzc2lvbiBjb21wYXJlZCB3aXRoIHplcm86IHZhbCA8IDANCj4NCj4g
Q2M6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPg0KPiBDYzogQ2hyaXN0aWFuIEvD
tm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4
YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiBDYzogIlBhbiwgWGluaHVpIiA8WGluaHVpLlBhbkBh
bWQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBTcmluaXZhc2FuIFNoYW5tdWdhbSA8c3Jpbml2YXNh
bi5zaGFubXVnYW1AYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9h
bWRncHVfcG0uYyB8IDggKysrKy0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9hbWRncHVfcG0uYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMN
Cj4gaW5kZXggZjAzNjQ3ZmEzZGY2Li5jZGMyOGU0ZGEwYzkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9hbWRncHVfcG0uYw0KPiBAQCAtMjc5NCwyNiArMjc5NCwyNiBAQCBzdGF0aWMgc3NpemVf
dCBhbWRncHVfaHdtb25fc2hvd19wb3dlcl9hdmcoc3RydWN0IGRldmljZSAqZGV2LA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkZXZpY2VfYXR0
cmlidXRlICphdHRyLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGNoYXIgKmJ1ZikNCj4gICB7DQo+IC0gICAgICAgdW5zaWduZWQgaW50IHZhbDsNCj4gKyAg
ICAgICBzc2l6ZV90IHZhbDsNCj4NCj4gICAgICAgICAgdmFsID0gYW1kZ3B1X2h3bW9uX2dldF9w
b3dlcihkZXYsDQo+IEFNREdQVV9QUF9TRU5TT1JfR1BVX0FWR19QT1dFUik7DQo+DQo+IFtLYW1h
bCwgQXNhZF0gYW1kZ3B1X2h3bW9uX2dldF9wb3dlciAtPiBUaGlzIGlzIHJldHVybmluZyB1bnNp
Z25lZCBpbnQgdmFsdWUsIFNoYWxsIHdlIG5vdCBjaGFuZ2UgcmV0dXJuIHR5cGUgZm9yIGFtZGdw
dV9od21vbl9nZXRfcG93ZXI/DQpUaGFua3MhLCBsb29rcyBsaWtlIHRoZXJlIGlzIGFscmVhZHkg
YSBmaXggcG9zdGVkIGhlcmUNCmh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9wYXRj
aC81NTM0MzMvP3Nlcmllcz0xMjI2NDAmcmV2PTEgZm9yICdhbWRncHVfaHdtb25fZ2V0X3Bvd2Vy
Jw0KPiBpZiAodmFsIDwgMCkNCj4gICAgICAgICAgICAgICAgICByZXR1cm4gdmFsOw0KPg0KPiAt
ICAgICAgIHJldHVybiBzeXNmc19lbWl0KGJ1ZiwgIiV1XG4iLCB2YWwpOw0KPiArICAgICAgIHJl
dHVybiBzeXNmc19lbWl0KGJ1ZiwgIiV6ZFxuIiwgdmFsKTsNCj4gICB9DQo+DQo+ICAgc3RhdGlj
IHNzaXplX3QgYW1kZ3B1X2h3bW9uX3Nob3dfcG93ZXJfaW5wdXQoc3RydWN0IGRldmljZSAqZGV2
LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBjaGFyICpidWYpDQo+ICAgew0KPiAtICAgICAgIHVuc2lnbmVkIGlu
dCB2YWw7DQo+ICsgICAgICAgc3NpemVfdCB2YWw7DQo+DQo+ICAgICAgICAgIHZhbCA9IGFtZGdw
dV9od21vbl9nZXRfcG93ZXIoZGV2LCBBTURHUFVfUFBfU0VOU09SX0dQVV9JTlBVVF9QT1dFUik7
DQo+ICAgICAgICAgIGlmICh2YWwgPCAwKQ0KPiAgICAgICAgICAgICAgICAgIHJldHVybiB2YWw7
DQo+DQo+IC0gICAgICAgcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAiJXVcbiIsIHZhbCk7DQo+ICsg
ICAgICAgcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAiJXpkXG4iLCB2YWwpOw0KPiAgIH0NCj4NCj4g
ICBzdGF0aWMgc3NpemVfdCBhbWRncHVfaHdtb25fc2hvd19wb3dlcl9jYXBfbWluKHN0cnVjdCBk
ZXZpY2UgKmRldiwNCj4gLS0NCj4gMi4yNS4xDQo+DQo=
