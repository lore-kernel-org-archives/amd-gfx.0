Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E97EC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 06:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75AEC10EEFD;
	Fri, 18 Feb 2022 06:18:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70AA710EEFA
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 06:18:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFV0efPwg/vfP9DGcMh4NoylNJLhafernSONJ6uDGKbt0x0ZpqUJWrBNFlaMU7NCASATIl1uCJApB/6mSIPI56hu0BXlE0b2tGFKrwO2i3uxdv2CTDfRB8h2/5vC2+56kusZz9ovOoG2OHGojplP8ZavYZWu+OX0e13i0ZHsEmeItKkEw/0zQVhs99J11RVGZic6L5gX2nO1oYnn4uyPXnfvdOatUMJBR0leJqZC6G7zAZe/0mdgcEaPSRd1JyA83SN24L9Zs208zJknIbZrxlEYxn1kNWX6c+W/4vH4KGhkh+bxnPMa1NHoux9F4Hvs5KAGcMA0DcSMQtB8o33OCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ehd8VwlFFiiy1Z3gAUs1ed4eKhWl50HJgzhXIk6B/DU=;
 b=lhMnoswN06kjXQ5esgpHyAlCZ6RuOi5KbHW/s6sgmpz5PDHZudL9CdeyCwC454mDz4TA3gJkfE/R0U5fR3rtsTQcBdrBK+LTaZSHA+FkKuBkaRlfBd5dOA+OMpJaCITQpjv/QDaLzn0/qcZtjHDTWvfjcTiPUB4pP83Oh1hY/pkwXFk5ZplPqISK28u2JK/ht2ARbNpxZ1a5m/ueMnr7Dljcm3GVTn3mQRDec203G6bdFRcfbpbasW3IvVUsdysQ6wHy6oibtRwW/I2lpgUOtIFmu/dnDIyB6j99P+pw4KoVHr4IjdiJZEwEv5o4DV+e9/wx4trPyljI4Y178QTC+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ehd8VwlFFiiy1Z3gAUs1ed4eKhWl50HJgzhXIk6B/DU=;
 b=s1FyVqsj9ESlbJClY698u82roSteCYeqF0doMtKE3COY/NPHiNwuZtyWSe4IQW9G3SUS7NxbbJEnd1QEaDyYeO9P1GfdRlHc1scNPp0czxorkeL4DoEA+uwz9q9AEHkEz66vEwsyGn0BDu31OkcLcUgPuEQycztEJolB7uBG3/U=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by CY4PR1201MB0103.namprd12.prod.outlook.com (2603:10b6:910:17::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Fri, 18 Feb
 2022 06:18:39 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::6935:49fb:9f4f:67ba]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::6935:49fb:9f4f:67ba%7]) with mapi id 15.20.4995.014; Fri, 18 Feb 2022
 06:18:39 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: validate SMU feature enable message for
 getting feature enabled mask
Thread-Topic: [PATCH] drm/amd/pm: validate SMU feature enable message for
 getting feature enabled mask
Thread-Index: AQHYJHukXF9TM850b0GuCM8tTPxT8qyYsFYAgAAEFOCAABOUAIAAC4XA
Date: Fri, 18 Feb 2022 06:18:39 +0000
Message-ID: <BYAPR12MB32382508614C8BD8F653FE4AFB379@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <1645156501-18317-1-git-send-email-Prike.Liang@amd.com>
 <5db9229e-52c3-fc4a-f8b5-29a25366208e@amd.com>
 <BYAPR12MB32384F7915C0784BEAAD3223FB379@BYAPR12MB3238.namprd12.prod.outlook.com>
 <24c66104-c0d9-4556-fa8f-61cd45d8a2eb@amd.com>
In-Reply-To: <24c66104-c0d9-4556-fa8f-61cd45d8a2eb@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7a0e0688-3e19-428e-8d9b-d354d747936e;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-18T06:10:44Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 387fafd1-0e24-4b9d-c6aa-08d9f2a68119
x-ms-traffictypediagnostic: CY4PR1201MB0103:EE_
x-microsoft-antispam-prvs: <CY4PR1201MB010346C71D1D5F1ACB694403FB379@CY4PR1201MB0103.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6mkihg6jNsIE/QpQRWZ9rTL/E0K74oUqKb1JvPQqwM20WHZvCC1+JzkcAYhmJXFb/ejaF62yVyRgt0YoLwT6Z9ca06Z1SOBIzpik96Krfq8+0zG9BcEqg1W643Xbslw6xjfDjxQEMbwzikuEKpV4VhIngk+0CFDe79JOZl8Hj2JgvvilUyKHM/aNPCtfiTQ8If4q5ojWTOH0wAx0Of9uBwQswg2dV6DfaIWgy9ZzG1oKN7wlae/LjyW+USuW79brNsipsib99V0ZNXUWF6fabO8/OGktvId9yPx0Vsvn3r4t9WV3Q/x0X6d6j3lJcCUVa85smTmG2DIjfkifVC9AT0cS0/Bh50pANOVkh1/PXuATd3J5SRQ1u/oo6v1JQx/YcgPWgP7D84KWJfL1TU2h+0bvbrJMAixKSrDoKeuH56EQmAU4KVjNLSPEEMagJ4aTAajNVj9puKL0rXlt12zALo3yy0JI/lTmEoF8DwG1ouk4XeTfipEiSUpDHWJSnrzS/QkTXBfIm9YZmhFwiBIALyHPIRcdd/6EMAhToC6LcoWuqQAti1sChFoX0asZfBLhkwupH5fIOICdgvamyVHFlFKJu7XMV7G6ag4ad5HjkPiJXJ1LlELabiwhUaK9pd85H+tLlBNWtm+YQbU4rNhDkH8Y3KPr/fz9kgrcUeiNysbkY4KpoeX1IE6G53s5V10Jn2Hi012YFWIXKGYzW+boIA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(15650500001)(8936002)(9686003)(55016003)(71200400001)(5660300002)(6506007)(86362001)(53546011)(83380400001)(26005)(186003)(52536014)(33656002)(66946007)(7696005)(76116006)(8676002)(66476007)(38070700005)(2906002)(66556008)(64756008)(66446008)(508600001)(4326008)(110136005)(54906003)(316002)(122000001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bk1qVFlaSnBmYUhzYXNpWFlkdVo3ck9sd1NVa0VVaGh0R1RPR21zeVdFNFBv?=
 =?utf-8?B?NWw0UkFXRXRiVWxpUGlhV1hEVjFVT3lKY0lGWnk1N3ZtMTcvMWFCU1VrT2RB?=
 =?utf-8?B?VFVaalNEZFdwY0ZWaUxmQTVFTmRTUndRV0ZiTnBiMi96RE9maHJxZmtpc08x?=
 =?utf-8?B?eVVmUXJtQXBGUmZNUlRUTjhyVHZXUGhwNjRHUjdJSjhWbDV6eXp6ZEFabmwr?=
 =?utf-8?B?bFdhM2RrSXZqSlRHcWozZWxTbGxjUlhBdFY2WE1KVEJJMUpwN3Nyakg4Q3VX?=
 =?utf-8?B?aTA5bnBCQ2NKYy9mU2plYVBzQUc1MUZEbkViY3BXUEhkSkN1SGtlRDVVaytJ?=
 =?utf-8?B?RmY2eTYvMk9UZEVhbzRYTmErRTJyUnhXV2c3bCtnUHpYbHA1Zzk4UFBldmJm?=
 =?utf-8?B?dlRXN05jMkJYVEF2UEFpRndWN2dpSXdXV3pSNzhpMDQyV1JHaEEvaGpicklp?=
 =?utf-8?B?RWdPdlU2b2c0MVdxTXhESEVSUHhyN3dOcjNoMm1xUU1WNVRHaHJtUnQvcWRQ?=
 =?utf-8?B?ZzIvenNNOTBNOTBpUU9Bc0o4YmtXWXBZNGRLUlZKUzZEaHAvTVNEU0ZDRi90?=
 =?utf-8?B?eFk0NVR6TllIVUJoYzl5WTM4R0ZQU2RNY29ZQTNhYkR0RmJrTWVHZ3V5UkQv?=
 =?utf-8?B?L2x4MHdFRE1YVnJKTUNVZDVPVWtIV1NVc3VwNS85c1NRS2s5b2EvMTBYRUg5?=
 =?utf-8?B?QU1aeUlNNWV5SWQ4Nlh1azFTdUNaMFZxSmdBTlY0UDhyWDBMS2xsaFZHL0s0?=
 =?utf-8?B?RmdtbVlrUGFBQnZ2WTJmT0lPdHBWa1RQaGxwUlUyM2FtREhzbVJqdkdTbDlH?=
 =?utf-8?B?cHpBWTAzSXU5U3FXeHZKNGNxYkdWdDZINUZqN0VhNGJwdWVBTVFYdU9ZRGR1?=
 =?utf-8?B?S21UL244dThZVXFPdGtCSVFvQ1RGRGdPRmpPWGVseERDU0pMcEZTV1RxYnRu?=
 =?utf-8?B?ZEZGL3M5bE5BZFdNaW5ZV2NZMTNQMHo2cVZQdGtoRXBUMEZYYVRvWkRGVTFq?=
 =?utf-8?B?VUlFVFB5Wm1ZVlkwU3RWNmVsTzFTSmVjRzhGOTE4aDdWQ2dsa3U1bjVuNjBB?=
 =?utf-8?B?MG0rbGppTFJCb3d2VFByRUpzZG15R2pkWUw3ZFRwVHluWFE2NWNhTXB4QTRy?=
 =?utf-8?B?T3FEQmZSdzcxU3ZualdBYTV5b2MxaGFyY2t6SXFueGtrQXZaWHBjNHVMcElH?=
 =?utf-8?B?QWQzSjI2Znd6UTg5VldqaG5FdzFrbEtxcmxraDkwYmttc0w3WUJRNDZVVWpR?=
 =?utf-8?B?K3h1TkJJZkdtQWNoV1hkQVNlaC81T1dHVjQ4UVd0M0lwSE5lYm9jRFVkaHFS?=
 =?utf-8?B?RStFdEJBZldDaGhkM2xIVWxoNXNVSTlPOTg4OFJJOWFpRDM5QlowUS9NQUFV?=
 =?utf-8?B?Qm81bG80amZ4dmdLMk1wTDFLc2ZVNkdWVitLRTVkNUhyUXlyYm1TcXdTNmxI?=
 =?utf-8?B?V3RGd3VoVEgwNVJRU2xwUFYzMm14WEVPQXhlbmpkeTF5SHJRbE81Y0VneGhx?=
 =?utf-8?B?QXNTRThCbzNtR0VWRmdsL080YWRLa0lDZ2hBTWp1MEhxbkxjd3VTZ3FTRTBU?=
 =?utf-8?B?RU1VdEpBK0xRek04TGU0WHI4cUE5TGFRTUdCdkpocSttYmNrZjIreTV4aWxw?=
 =?utf-8?B?dm9tdDFLU0lCZEYxMllMcnk2MFZGVU81NXAxeWgweTNWTjNoT0JGWGdjSTZ5?=
 =?utf-8?B?R0NUTjF4QksrYXVmM1dublh0c1NyUzZrdU5sczFVVEpsTWFTMFNUVU9Kb0RH?=
 =?utf-8?B?a3hSak9QekdqbGU3dHlWbzRqRGdwZ3pjQmNNWk1oRmRZTzN0bWJrbGhnWHdB?=
 =?utf-8?B?c0xyUmUxUUovRURpbytVU0VZalYvNEpXQ2dUVi9RTElBUWdXcmdyRUdiSEhz?=
 =?utf-8?B?b3JwbGxzcFpvTnhJbloxblZhZ2pvTG5kancxbWRaL3E2YmNibWUrWmpSU0V2?=
 =?utf-8?B?ZXVHL2FOYmthc012VXFOWHBKTkN3MndoUERJK3BHWU8zSDJ6Zkw5eU5PcnF6?=
 =?utf-8?B?emYrL1F3ckZtUVhHNmZvVDF4MUIraEhkdGw1L202SW5raVROQkczNUtBT085?=
 =?utf-8?B?N1d1aHhzRnJjL0Z5cnltUVBHcSt0bW8zeXpvQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 387fafd1-0e24-4b9d-c6aa-08d9f2a68119
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 06:18:39.2047 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oNtei/EF6HAPLjh34/sgdo+28P0nB2xkponBrc6T6UwbYRH8WhWYxUIK4Z5RqF3M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0103
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXphciwg
TGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiBTZW50OiBGcmlkYXksIEZlYnJ1YXJ5IDE4LCAy
MDIyIDE6MjkgUE0NCj4gVG86IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFs
ZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBRdWFuLCBFdmFuDQo+IDxFdmFuLlF1YW5AYW1kLmNv
bT47IEh1YW5nLCBSYXkgPFJheS5IdWFuZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
XSBkcm0vYW1kL3BtOiB2YWxpZGF0ZSBTTVUgZmVhdHVyZSBlbmFibGUgbWVzc2FnZSBmb3INCj4g
Z2V0dGluZyBmZWF0dXJlIGVuYWJsZWQgbWFzaw0KPg0KPg0KPg0KPiBPbiAyLzE4LzIwMjIgOTo1
NyBBTSwgTGlhbmcsIFByaWtlIHdyb3RlOg0KPiA+IFtQdWJsaWNdDQo+ID4NCj4gPj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJA
YW1kLmNvbT4NCj4gPj4gU2VudDogRnJpZGF5LCBGZWJydWFyeSAxOCwgMjAyMiAxMjowNSBQTQ0K
PiA+PiBUbzogTGlhbmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCj4gPj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVy
LkRldWNoZXJAYW1kLmNvbT47IFF1YW4sIEV2YW4NCj4gPj4gPEV2YW4uUXVhbkBhbWQuY29tPjsg
SHVhbmcsIFJheSA8UmF5Lkh1YW5nQGFtZC5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hd
IGRybS9hbWQvcG06IHZhbGlkYXRlIFNNVSBmZWF0dXJlIGVuYWJsZSBtZXNzYWdlDQo+ID4+IGZv
ciBnZXR0aW5nIGZlYXR1cmUgZW5hYmxlZCBtYXNrDQo+ID4+DQo+ID4+DQo+ID4+DQo+ID4+IE9u
IDIvMTgvMjAyMiA5OjI1IEFNLCBQcmlrZSBMaWFuZyB3cm90ZToNCj4gPj4+IFRoZXJlJ3MgYWx3
YXlzIG1pc3MgdGhlIFNNVSBmZWF0dXJlIGVuYWJsZWQgY2hlY2tlZCBpbiB0aGUgTlBJDQo+ID4+
PiBwaGFzZSwgc28gbGV0IHZhbGlkYXRlIHRoZSBTTVUgZmVhdHVyZSBlbmFibGUgbWVzc2FnZSBk
aXJlY3RseQ0KPiA+Pj4gcmF0aGVyIHRoYW4gYWRkIG1vcmUgYW5kIG1vcmUgTVAxIHZlcnNpb24g
Y2hlY2suDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogUHJpa2UgTGlhbmcgPFByaWtlLkxp
YW5nQGFtZC5jb20+DQo+ID4+PiAtLS0NCj4gPj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0v
c3dzbXUvc211X2Ntbi5jIHwgMjgNCj4gPj4+ICsrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0NCj4g
Pj4gLQ0KPiA+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRp
b25zKC0pDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0v
c3dzbXUvc211X2Ntbi5jDQo+ID4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211
X2Ntbi5jDQo+ID4+PiBpbmRleCBmMjQxMTFkMjgyOTAuLmRhMWFjNzBlZDQ1NSAxMDA2NDQNCj4g
Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211X2Ntbi5jDQo+ID4+PiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdV9jbW4uYw0KPiA+Pj4gQEAgLTU1
MiwxMCArNTUyLDkgQEAgYm9vbCBzbXVfY21uX2Nsa19kcG1faXNfZW5hYmxlZChzdHJ1Y3QNCj4g
Pj4gc211X2NvbnRleHQgKnNtdSwNCj4gPj4+ICAgIGludCBzbXVfY21uX2dldF9lbmFibGVkX21h
c2soc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsDQo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHVpbnQ2NF90ICpmZWF0dXJlX21hc2spDQo+ID4+PiAgICB7DQo+ID4+PiAtICAgc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBzbXUtPmFkZXY7DQo+ID4+PiAgICAgIHVpbnQzMl90ICpm
ZWF0dXJlX21hc2tfaGlnaDsNCj4gPj4+ICAgICAgdWludDMyX3QgKmZlYXR1cmVfbWFza19sb3c7
DQo+ID4+PiAtICAgaW50IHJldCA9IDA7DQo+ID4+PiArICAgaW50IHJldCA9IDAsIGluZGV4ID0g
MDsNCj4gPj4+DQo+ID4+PiAgICAgIGlmICghZmVhdHVyZV9tYXNrKQ0KPiA+Pj4gICAgICAgICAg
ICAgIHJldHVybiAtRUlOVkFMOw0KPiA+Pj4gQEAgLTU2MywxMiArNTYyLDEwIEBAIGludCBzbXVf
Y21uX2dldF9lbmFibGVkX21hc2soc3RydWN0DQo+ID4+IHNtdV9jb250ZXh0ICpzbXUsDQo+ID4+
PiAgICAgIGZlYXR1cmVfbWFza19sb3cgPSAmKCh1aW50MzJfdCAqKWZlYXR1cmVfbWFzaylbMF07
DQo+ID4+PiAgICAgIGZlYXR1cmVfbWFza19oaWdoID0gJigodWludDMyX3QgKilmZWF0dXJlX21h
c2spWzFdOw0KPiA+Pj4NCj4gPj4+IC0gICBzd2l0Y2ggKGFkZXYtPmlwX3ZlcnNpb25zW01QMV9I
V0lQXVswXSkgew0KPiA+Pj4gLSAgIC8qIEZvciBWYW5nb2doIGFuZCBZZWxsb3cgQ2FycCAqLw0K
PiA+Pj4gLSAgIGNhc2UgSVBfVkVSU0lPTigxMSwgNSwgMCk6DQo+ID4+PiAtICAgY2FzZSBJUF9W
RVJTSU9OKDEzLCAwLCAxKToNCj4gPj4+IC0gICBjYXNlIElQX1ZFUlNJT04oMTMsIDAsIDMpOg0K
PiA+Pj4gLSAgIGNhc2UgSVBfVkVSU0lPTigxMywgMCwgOCk6DQo+ID4+PiArICAgaW5kZXggPSBz
bXVfY21uX3RvX2FzaWNfc3BlY2lmaWNfaW5kZXgoc211LA0KPiA+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBDTU4yQVNJQ19NQVBQSU5HX01TRywNCj4gPj4+
ICsNCj4gPj4gICAgICAgIFNNVV9NU0dfR2V0RW5hYmxlZFNtdUZlYXR1cmVzKTsNCj4gPj4+ICsg
ICBpZiAoaW5kZXggPiAwKSB7DQo+ID4+PiAgICAgICAgICAgICAgcmV0ID0gc211X2Ntbl9zZW5k
X3NtY19tc2dfd2l0aF9wYXJhbShzbXUsDQo+ID4+Pg0KPiA+PiBTTVVfTVNHX0dldEVuYWJsZWRT
bXVGZWF0dXJlcywNCj4gPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIDAsIEBAIC01ODAsMTkNCj4gPj4+ICs1NzcsNyBAQCBpbnQgc211X2Ntbl9n
ZXRfZW5hYmxlZF9tYXNrKHN0cnVjdA0KPiA+PiBzbXVfY29udGV4dCAqc211LA0KPiA+Pj4NCj4g
Pj4gU01VX01TR19HZXRFbmFibGVkU211RmVhdHVyZXMsDQo+ID4+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAxLA0KPiA+Pj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmVhdHVyZV9tYXNrX2hpZ2gp
Ow0KPiA+Pj4gLSAgICAgICAgICAgYnJlYWs7DQo+ID4+PiAtICAgLyoNCj4gPj4+IC0gICAgKiBG
b3IgQ3lhbiBTa2lsbGZpc2ggYW5kIFJlbm9pciwgdGhlcmUgaXMgbm8gaW50ZXJmYWNlIHByb3Zp
ZGVkIGJ5DQo+ID4+IFBNRlcNCj4gPj4+IC0gICAgKiB0byByZXRyaWV2ZSB0aGUgZW5hYmxlZCBm
ZWF0dXJlcy4gU28sIHdlIGFzc3VtZSBhbGwgZmVhdHVyZXMgYXJlDQo+ID4+IGVuYWJsZWQuDQo+
ID4+PiAtICAgICogVE9ETzogYWRkIG90aGVyIEFQVSBBU0lDcyB3aGljaCBzdWZmZXIgZnJvbSB0
aGUgc2FtZSBpc3N1ZSBoZXJlDQo+ID4+PiAtICAgICovDQo+ID4+PiAtICAgY2FzZSBJUF9WRVJT
SU9OKDExLCAwLCA4KToNCj4gPj4+IC0gICBjYXNlIElQX1ZFUlNJT04oMTIsIDAsIDApOg0KPiA+
Pj4gLSAgIGNhc2UgSVBfVkVSU0lPTigxMiwgMCwgMSk6DQo+ID4+PiAtICAgICAgICAgICBtZW1z
ZXQoZmVhdHVyZV9tYXNrLCAweGZmLCBzaXplb2YoKmZlYXR1cmVfbWFzaykpOw0KPiA+Pj4gLSAg
ICAgICAgICAgYnJlYWs7DQo+ID4+DQo+ID4+IFRoaXMgaXMgYnJva2VuIG5vdyBhcyB0aGVzZSBB
U0lDcyBkb24ndCBzdXBwb3J0IGFueSBtZXNzYWdlLiBJdCBpcw0KPiA+PiBiZXN0IHRvIHRha2Ug
b3V0IHNtdV9jbW5fZ2V0X2VuYWJsZWRfbWFzayBhbHRvZ2V0aGVyIGFuZCBtb3ZlIHRvDQo+ID4+
IHNtdV92Ki5jIG9yICpfcHB0LmMgYXMgdGhpcyBpcyBhIGNhbGxiYWNrIGZ1bmN0aW9uLg0KPiA+
Pg0KPiA+PiBUaGFua3MsDQo+ID4+IExpam8NCj4gPj4NCj4gPiBCZWZvcmUgdGhpcyBzb2x1dGlv
biBJIGFsc28gY29uc2lkZXIgcHV0IHRoZSAgc211X2Ntbl9nZXRfZW5hYmxlZF9tYXNrDQo+IGlt
cGxlbWVudGF0aW9uIGluIGVhY2ggKl9wcHQgZGlyZWN0bHksIGJ1dCBzZWVtcyBuZWVkIHNvbWUg
ZWZmb3J0IGZvcg0KPiBpbXBsZW1lbnRpbmcgb24gZWFjaCAqX3BwdC4gSG93IGFib3V0IHdlIGFs
c28gY2hlY2sgdGhlDQo+IFNNVV9NU0dfR2V0RW5hYmxlZFNtdUZlYXR1cmVzSGlnaCBtYXBwaW5n
IGluZGV4PyBBcyB0byB0aGUgQVNDSSBub3QNCj4gc3VwcG9ydCBuZWl0aGVyICBTTVVfTVNHX0dl
dEVuYWJsZWRTbXVGZWF0dXJlcyBub3INCj4gU01VX01TR19HZXRFbmFibGVkU211RmVhdHVyZXNI
aWdoIHdpbGwgaGFyZCBjb2RlIHRoZSBmZWF0dXJlIG1hc2sgaW4NCj4gdGhpcyBjYXNlLg0KPiA+
DQo+DQo+IFNvbWV0aGluZyBsaWtlIGF0dGFjaGVkIHJlZmFjdG9yaW5nIGFuZCB0aGVuIGZvciB0
aGUgcmVzdCB5b3UgY291bGQgYXBwbHkNCj4geW91ciBwYXRjaC4NCj4NCj4gVGhhbmtzLA0KPiBM
aWpvDQo+DQpXZWxsLCB0aGlzIGFsc28gbG9va3MgZ29vZCBmb3IgaGFuZGxpbmcgdGhlIGZlYXR1
cmUgbWFzayBub3Qgc3VwcG9ydCBzY2VuYXJpbyBjYXNlIGJ5IGNhc2UsIGJlZm9yZSB0aGlzIEkg
d2FudCB0byBoYW5kbGUgZXZlcnl0aGluZyBvbiB0aGUgc211X2Ntbl9nZXRfZW5hYmxlZF9tYXNr
KCkuIFdpbGwgdXBkYXRlIHRoZSBwYXRjaCBiYXNlIG9uIHlvdXIgcHJvcG9zYWwsIHRoYW5rcyEN
Cg0KDQo+ID4+PiAtICAgLyogb3RoZXIgZEdQVSBBU0lDcyAqLw0KPiA+Pj4gLSAgIGRlZmF1bHQ6
DQo+ID4+PiArICAgfSBlbHNlIHsNCj4gPj4+ICAgICAgICAgICAgICByZXQgPSBzbXVfY21uX3Nl
bmRfc21jX21zZyhzbXUsDQo+ID4+Pg0KPiA+PiBTTVVfTVNHX0dldEVuYWJsZWRTbXVGZWF0dXJl
c0hpZ2gsDQo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmVh
dHVyZV9tYXNrX2hpZ2gpOyBAQA0KPiA+Pj4gLTYwMiw3ICs1ODcsNiBAQCBpbnQgc211X2Ntbl9n
ZXRfZW5hYmxlZF9tYXNrKHN0cnVjdA0KPiA+PiBzbXVfY29udGV4dCAqc211LA0KPiA+Pj4gICAg
ICAgICAgICAgIHJldCA9IHNtdV9jbW5fc2VuZF9zbWNfbXNnKHNtdSwNCj4gPj4+DQo+ID4+IFNN
VV9NU0dfR2V0RW5hYmxlZFNtdUZlYXR1cmVzTG93LA0KPiA+Pj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGZlYXR1cmVfbWFza19sb3cpOw0KPiA+Pj4gLSAgICAgICAg
ICAgYnJlYWs7DQo+ID4+PiAgICAgIH0NCj4gPj4+DQo+ID4+PiAgICAgIHJldHVybiByZXQ7DQo+
ID4+Pg0K
