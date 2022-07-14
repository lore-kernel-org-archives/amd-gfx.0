Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F8CCCA486
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 04:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ABB0A18D5;
	Thu, 14 Jul 2022 04:29:45 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BE24A18B5
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 04:29:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bceoX3huOfHsty80JuyJKX/rmx+kRyJBbfDFGJDGNYY2srgqxy6ihhb9rMmbKnNEbisNSHawp3ja0HmG2Jwxd/xG2ETeSEsAsWRKWtVD0QxcfDEO0mlSeCmT7n74GFfLHj554ayBnRI/KAHZqgNXNY7sFtvqX5VWUX/+8DQTg7Hk60y9sqOjOAdgdyQWUQjzUo9ueHbCYoexIZxXeU1lrLmLvN36+SQFWCTEdluL8G/dHWHSZLqDDDLdj0h0gCgxRdMCHCynHNUgiK1sVAisoPDmh68FqIpZKAnk2CpmAy/PZuN4bKE3T/6+kgT/PCARKXWAEhIdP3RR/0r23L6GKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hv2nTF/WM6bAg6L5i/YSjQPtn/6P+V8w8wD2ucAS+R4=;
 b=krV3d+959qWJVsNyXcmIQhpmwwev1R3l7Lv9QOKR9erBWwQe1bAPkECbsqiTGI99hmn/UVCv+N8fsI07eulep6nrvMeuDyyTdrNtEpBkSC20+qEMKb14NtiJQwf+TIPqW2Bmn/N2DsrK/+44H3p7hEGCPmyQdZMncRMbCJfYdneWC37Rrg5OoLePG7HMBXu7fH8CUiqw6ONTHmkqnC2w8NyONz3aMJmg4EP6fS51RktJ736j3JICBLDR64uuN9ZzqHGL0ZCqCGH/CMiJfHEFteFyYx6LeY8H6EmEkQfyf9n7IX6RpFrOKtPVLOhBstz7/YfVw/iw+sGiL03rwpxrzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hv2nTF/WM6bAg6L5i/YSjQPtn/6P+V8w8wD2ucAS+R4=;
 b=cvdS2jC7Mx4dmzjyK5GorU3KsSRddMx3n8tqM0Pd46svXSIKOdnJD7MjpsygvO9fLjZVVdT+sfbODhdkDS0dDHHn2yAp6c0zq6hchHfYDAJVQ/B79Bv9wptGKbLIOOJdwzZjAR9sZkTj8fiwC8kob/pG4SZAT+6wBkUTzDc04Jc=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BN6PR1201MB0227.namprd12.prod.outlook.com (2603:10b6:405:4e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Thu, 14 Jul
 2022 04:29:39 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::589b:a1f6:9c87:a8ba]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::589b:a1f6:9c87:a8ba%6]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 04:29:39 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: skip SMU FW reloading in runpm BACO case
 (v2)
Thread-Topic: [PATCH 1/2] drm/amdgpu: skip SMU FW reloading in runpm BACO case
 (v2)
Thread-Index: AQHYlmcaBWHJb/ssB0eJbFUIJjipm618bl4AgADEqYCAAAf0gIAAApYAgAAKJgA=
Date: Thu, 14 Jul 2022 04:29:39 +0000
Message-ID: <BL1PR12MB51444FD31359E01F55A6D59CF7889@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220713031704.2004-1-guchun.chen@amd.com>
 <CADnq5_PzunYt9CBWF5Z4s2EERe2WBDmpREnfDD48KYNPkeS95g@mail.gmail.com>
 <BL0PR12MB2465F64BAEAED76DD32EE204F1889@BL0PR12MB2465.namprd12.prod.outlook.com>
 <CADnq5_P-o2Ut_V5JM=w4XMHDtDYvyU7Ub8dwbHJcTNQW+ko9=A@mail.gmail.com>
 <DM5PR12MB2469359739E1B0D88FB994D9F1889@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469359739E1B0D88FB994D9F1889@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-14T04:29:09Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d3f62ede-1d63-4c4d-a5ae-7aa4d7afb79b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-07-14T04:29:38Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 84f168f7-b24c-4e0f-bcd1-00ce27985335
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd704b72-7b39-4497-7d05-08da65517745
x-ms-traffictypediagnostic: BN6PR1201MB0227:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O1eIBjw4fLzOp22VO2tHKUEmziqIik6PZLTF/MwZdiUeoaiIFd5fOORN/HGki8T2ypnT3nWrIPeEDukW7U/BtlUe6JMrASrJ5i0BEwIJvG0+DU6m2CZ7qxv9JLBCkA0B+pTJH4NHgn8ZVqqytZ+52XV3905jpMcwd0c0+st8BNb+fy+VZeVXs75315meegtkgJNR3ZcshO2XwdjOJHPVy9S43CDn3icBhX85HiVGRTrpNiRzFUgLqFiz68ud1t9tb4qRarqfgmOpQ1cbfaavPSfoAOD8gPe9Ofupa+nOYXVN++Fe3bXMAJxyCZeykqHzWJG6N9BsW4GhzXmXIappAYqCFsBgWY875hIZmWpEy8EDPU98G0IVoAyZkOXPQ7HmaiWxanZq1nl8UtZSfRnpRhOJPeV5KPz2LByCopLmYzlaPBrd+B3i7TL4hqHwr45IEVk+6jstjRsHVIzmBriVNAlLcMlqP0LDVDBH833J/Pqmm19sF/gBHB6PauVsTT2mS/WKl8zSrOywKP3HV+Um93WfG56ISwdmRJkKSWmDkdS9brYRGjh8OfIJ62qftHQl7HAwTT0H5qCEb/ggtMepmtf0MGgV35lzUXsBpQQ3T0GtArZs6B/l/dtni/h/oflc2NEfcNFnDrxv8KCxKKEq4f6NPfSP1i2QQPeUKqUOl7Ib31h1frKesCs9NuGmLeaIuCQUvOeB9MbAsgoqRCm1dU06wxhYJZojbCYnRtQXsFjr2+n+jvm026QFx7fuGFbcfJBaOoCqxKdayHjNitD7BND2oY+AsGkPPIPlxTZytvdFzlnTk5GJaIei1JOl53Qs
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(2906002)(186003)(33656002)(83380400001)(55016003)(6506007)(26005)(66446008)(8676002)(66946007)(76116006)(53546011)(86362001)(66476007)(478600001)(64756008)(66556008)(71200400001)(122000001)(54906003)(7696005)(38100700002)(38070700005)(5660300002)(52536014)(316002)(4326008)(110136005)(9686003)(41300700001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2dOeWdzUjhRcDNLQ1RHazhXQ2ZMTXBIZG9xSWRhUkxvU29UWGRzdlhub0hK?=
 =?utf-8?B?TGYxd3ZWUlE1MVg0T2tHVnRTWkJGcVA5S1Y2ODdmbjNWVzFIZ1BGOHM4Z3I5?=
 =?utf-8?B?Y1dlL3h0OEwxMTlyYWx3L003KzUxY1hpd3IvQ1A2bTNLcDA4UkpZT0k0OTVs?=
 =?utf-8?B?S2dDRlFiKy9HZUxwTDVmeE9JTHl2Rld6aEZrL2JZVVJBYkJqV2IzcDIyVnFy?=
 =?utf-8?B?dkRvdXNMUThDVm5VcG9QdmZXSnZudUJhUXp1b0VCK04rZjZOK1k5dDhpTkNm?=
 =?utf-8?B?cW9LWjlqWTE3NDRMQjVpdDhYQ0lndTc5Wm9XQUoyZXdjY3dITnBjWVRhTmhk?=
 =?utf-8?B?RHdwcGFMZjJDL3FVbWx6WmprWTB4V2xrUUNDNEVqUUd6bDJFRFN4REx6OW94?=
 =?utf-8?B?L3BQRHVPMmhaOVUxU1pWZkw4aXJhZXFzUzNwMVFGeDFlUG4vR1hHVlcvMTBm?=
 =?utf-8?B?WGU0ZlNvWkVsUC9oVWFIZ0ZHM2h2SWRKekVhajdFTDFIYWxXaTMxQVFDaXp3?=
 =?utf-8?B?THRUWS9LSlVYcW9sMnVLWXdWS1lQV1NzNjNuMEorZFV1UWhidHFJdjB3RjJJ?=
 =?utf-8?B?VktBMUJKbmZqZmU0cWVaUmlybXVFYTJncndwVjYrci9lZS9tZSszbGVFNTZh?=
 =?utf-8?B?Y2ovMHFQd01iVXFNVVhrN05SRVA4aUpnS3c5ZUZ5STZ6d2tqWTNnRU5EOVBK?=
 =?utf-8?B?Q3phR0YyR1ZYVVZSL3EySllLMk1CS2cwZk9CZFVjdjhOSVJaeFRXYStzSEtY?=
 =?utf-8?B?dk5BbVdJbzR6RVg5WGUzbFR3Q0k0RnROdERjRENnSENqY0NXMVVPNEV1R2Ns?=
 =?utf-8?B?ay9OSDF5bjdwUE5DT3c1Y0Y4VWxkTWRBZmRWeGJqSjhSdEVlVjBYM1JDbmNz?=
 =?utf-8?B?NWgxdTNUVHdld3ZHVW1pVFlsTlBRK1FWK3hNcUpHTXhXMjZ5dE1lZG5TK2wx?=
 =?utf-8?B?WVEybmRMUUovN1VZUE9ZdCtFYk1JZisxTTNpQ29FWUk4RWFOYmhBMEdKU3pp?=
 =?utf-8?B?cXJVYU0zWXZOZE5FVUd0TDI3MEN5TnlBQlBYQy9pVEpXV09rd25ud3g3SWp2?=
 =?utf-8?B?VUxrN0RPZXpJL3FwKy9XSngxWXhsWUNSN1NMQnlXMXBrQkhrZ0RtMHRsOG5w?=
 =?utf-8?B?SFRNaFFFMit4ZnRwbmdpVEZSUVR6MnBIcEdKWlZSVEE0ZUEybWVKR0FKVWV0?=
 =?utf-8?B?U0c5RmJDamk2NHdGYlVhYllZV2xUMWlIL2FEVWVUN0FFT0sxcHhrTlNjNldH?=
 =?utf-8?B?MU8vMjEwTnF1NDByOWt2THhIZEgzNlBKeVREM09pc0FjNEJjSDJUMkoyZmlx?=
 =?utf-8?B?cGdBOUxLSDY1Wjk2SEZVaXRYOGJPTmlKOXZWc094SnFtY1VpNHdKRlNraDFj?=
 =?utf-8?B?SDNiZXR2d010MW9EUDdmenUxdVpyZ3Q1RjN3bXVmcG1kakRvMWVLd2tvV1JV?=
 =?utf-8?B?dHdCdkRYcDAzMlNWWXdzeG5sOU5GUk5XSmg0TE9OT2ZNcDIvRHhFYXpLczcy?=
 =?utf-8?B?TzNCenBWQW9UNkdWWjhqbEpHZHRLMlEwTVJOS0JVRmQ5cGZXc3BESU9ydGtV?=
 =?utf-8?B?eis3YnlhMDF6ZW5IODFla3NmYjdPdjR1eVN0cVNmbE5pRXR1TXFSZWk2Z0Nm?=
 =?utf-8?B?cHNUb3RZRHBYdGlhSkwra3BIeWcwLzJWUXFneE5keVpLWXRNbCtmbEt5NURk?=
 =?utf-8?B?S01WWUxWZ2hqME9oMjRCYm5nQm93d05TMTZzSGlLUU9sc1pzSWVlYUhwZ2ht?=
 =?utf-8?B?ekxMRDhjMmNGNlcvb0I3S2lFUjdJZTduc1R1T0hZa05zNHVZaUJhUE5OQjRo?=
 =?utf-8?B?YjhEeVF3Y0VWNDRLRDlFTGtnaGp0OXo1eGc4aFJHUG5qLzhPVHpQZ096ZVV2?=
 =?utf-8?B?WEIrOE1Vem56QVI1QTc3aDFQMTEwSXZxV3NFeVFqS0xUOG1vQlpqMjVWbFFU?=
 =?utf-8?B?bTBkdVNlbmE5eTF5NWprdTMrY3R0WW5uZ2hxNU9wVmJOTXRjZnRSUnVUTHJv?=
 =?utf-8?B?L1RxdTN5THR5TDE0blFDNzgyeUtyaG9hcHRkMlVERk5nSHNuVVJsY2FmQ01L?=
 =?utf-8?B?dnBqNkMvYjdoNDM5UmthZ1dRdW0wQjZrbGJMMW43U0N1VnNaMmVIRnB0TGEv?=
 =?utf-8?Q?isMc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd704b72-7b39-4497-7d05-08da65517745
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 04:29:39.3677 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C7r3E5Ke6Yf0ChcbEX4jEH8ojaNXU10Yg1Z9drRwurNVjRkQFC8dgU+Ra0q7Eu+FlsP/t8bzXISe0eKeCIQ8WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0227
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPg0KPiBT
ZW50OiBXZWRuZXNkYXksIEp1bHkgMTMsIDIwMjIgMTE6NTMgUE0NCj4gVG86IEFsZXggRGV1Y2hl
ciA8YWxleGRldWNoZXJAZ21haWwuY29tPg0KPiBDYzogYW1kLWdmeCBsaXN0IDxhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZz47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRl
dWNoZXJAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nDQo+IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+
OyBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPjsgUXVhbiwgRXZhbg0KPiA8RXZhbi5R
dWFuQGFtZC5jb20+OyBGZW5nLCBLZW5uZXRoIDxLZW5uZXRoLkZlbmdAYW1kLmNvbT4NCj4gU3Vi
amVjdDogUkU6IFtQQVRDSCAxLzJdIGRybS9hbWRncHU6IHNraXAgU01VIEZXIHJlbG9hZGluZyBp
biBydW5wbQ0KPiBCQUNPIGNhc2UgKHYyKQ0KPiANCj4gU291bmRzIGdvb2QsIEFsZXguIExldCBt
ZSB1cGRhdGUgaXQgc29vbi4NCj4gDQo+IEFsc28sIGFmdGVyIGEgZGlzY3Vzc2lvbiB3aXRoIExp
am8sIG9uY2Ugd2UgaW50cm9kdWNlIHJwbSBtb2RlLCB3ZSB0aGluayBpdCdzDQo+IGZpbmUgdG8g
ZHJvcCBhZGV2LT5ydW5wbSBpbmRpY2F0b3IgYnkgcnBtIG1vZGUsIGFzIGl0J3MgYSBiaXQgb3Zl
cmxhcHBlZCB3aXRoDQo+IGxhdHRlciBvbmUuDQo+IFNvIGZvciB0aGUgY2hlY2sgbGlrZSBhZGV2
LT5ydW5wbSwgd2UgY2FuIHVzZSAncnBtX21vZGUgIT0NCj4gQU1ER1BVX1JVTlBNX05PTkUnIGlu
c3RlYWQuDQo+IElmIGl0IG1ha2VzIHNlbnNlLCBJIHdpbGwgcHJvdmlkZSBhIGZvbGxvdyB1cCBw
YXRjaCBhcyB3ZWxsIHRvIG9wdGltaXplIGl0Lg0KDQpTdXJlLiAgU291bmRzIGdvb2QuDQoNCkFs
ZXgNCg0KPiANCj4gUmVnYXJkcywNCj4gR3VjaHVuDQo+IA0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4g
U2VudDogVGh1cnNkYXksIEp1bHkgMTQsIDIwMjIgMTE6NDQgQU0NCj4gVG86IENoZW4sIEd1Y2h1
biA8R3VjaHVuLkNoZW5AYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnggbGlzdCA8YW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmc+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVj
aGVyQGFtZC5jb20+OyBaaGFuZywgSGF3a2luZw0KPiA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsg
TGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT47IFF1YW4sIEV2YW4NCj4gPEV2YW4uUXVh
bkBhbWQuY29tPjsgRmVuZywgS2VubmV0aCA8S2VubmV0aC5GZW5nQGFtZC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggMS8yXSBkcm0vYW1kZ3B1OiBza2lwIFNNVSBGVyByZWxvYWRpbmcgaW4g
cnVucG0NCj4gQkFDTyBjYXNlICh2MikNCj4gDQo+IE9uIFdlZCwgSnVsIDEzLCAyMDIyIGF0IDEx
OjE1IFBNIENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNvbT4NCj4gd3JvdGU6DQo+ID4N
Cj4gPiBSZTogSSB0aGluayB0aGlzIHdvdWxkIGJlIGJldHRlciBhczoNCj4gPiBpZiAoYWRldi0+
aW5fcnVucG0gJiYgKGFkZXYtPnBtLnJwbV9tb2RlICE9IEFNREdQVV9SVU5QTV9CT0NPKSkNCj4g
b3Igc29tZXRoaW5nIGxpa2UgdGhhdC4NCj4gPg0KPiA+IFllcywgcGF0Y2ggMiBpbiB0aGlzIHNl
cmllcyBhZGRyZXNzZXMgaXQuIFBhdGNoIDEgaW50ZW5kcyB0byBmaXggU01VIHJlbG9hZGluZywN
Cj4gd2hpbGUgcGF0Y2ggMiBmb2N1cyBvbiBmaXhpbmcgcmFjZSBpc3N1ZSB3aGVuIGdldHRpbmcg
ZmVhdHVyZSBtYXNrIGR1cmluZw0KPiBydW50aW1lIGN5Y2xlLg0KPiANCj4gSSBnZXQgdGhhdCwg
YnV0IEkgdGhpbmsgaXQgd291bGQgYmUgYmV0dGVyIHRvIHN3aXRjaCB0aGUgb3JkZXIgb2YgdGhl
IHBhdGNoZXMgYW5kDQo+IHRoZW4gdXNlIHRoZSBycG1fbW9kZSBpbiB0aGlzIHBhdGNoIGFzIHdl
bGwuICBUaGF0IHdheSB3ZSBhcmUgY29uc2lzdGVudCBhbmQNCj4gd2UgZG9uJ3QgbWlzcyBzb21l
IGNhc2UgaWYgd2UgY2hhbmdlIHRoZSBCQUNPIG9yIEJPQ08gbG9naWMgaW4gdGhlIGZ1dHVyZS4N
Cj4gDQo+IEFsZXgNCj4gDQo+ID4NCj4gPiBSZWdhcmRzLA0KPiA+IEd1Y2h1bg0KPiA+DQo+ID4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhk
ZXVjaGVyQGdtYWlsLmNvbT4NCj4gPiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMTMsIDIwMjIgMTE6
MzEgUE0NCj4gPiBUbzogQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPg0KPiA+IENj
OiBhbWQtZ2Z4IGxpc3QgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPjsgRGV1Y2hlciwg
QWxleGFuZGVyDQo+ID4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBaaGFuZywgSGF3a2lu
Zw0KPiA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsNCj4gPiBMYXphciwgTGlqbyA8TGlqby5MYXph
ckBhbWQuY29tPjsgUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+Ow0KPiA+IEZlbmcsIEtl
bm5ldGggPEtlbm5ldGguRmVuZ0BhbWQuY29tPg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8y
XSBkcm0vYW1kZ3B1OiBza2lwIFNNVSBGVyByZWxvYWRpbmcgaW4gcnVucG0NCj4gPiBCQUNPIGNh
c2UgKHYyKQ0KPiA+DQo+ID4gT24gVHVlLCBKdWwgMTIsIDIwMjIgYXQgMTE6MTggUE0gR3VjaHVu
IENoZW4gPGd1Y2h1bi5jaGVuQGFtZC5jb20+DQo+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IFNNVSBp
cyBhbHdheXMgYWxpdmUsIHNvIGl0J3MgZmluZSB0byBza2lwIFNNVSBGVyByZWxvYWRpbmcgd2hl
bg0KPiA+ID4gcnVucG0gcmVzdW1lZCBmcm9tIEJBQ08sIHRoaXMgY2FuIGF2b2lkIHNvbWUgcmFj
ZSBpc3N1ZXMgd2hlbg0KPiA+ID4gcmVzdW1pbmcgU01VIEZXLg0KPiA+ID4NCj4gPiA+IHYyOiBF
eGNsdWRlIGJvY28gY2FzZSBpZiBhbiBBU0lDIHN1cHBvcnRzIGJvdGggYm9jbyBhbmQgYmFjbw0K
PiA+ID4NCj4gPiA+IFN1Z2dlc3RlZC1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4N
Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPg0K
PiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5j
IHwgOCArKysrKysrKw0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4g
PiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3BzcC5jDQo+ID4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYw0K
PiA+ID4gaW5kZXggZTk0MTFjMjhkODhiLi5kZTU5ZGMwNTEzNDAgMTAwNjQ0DQo+ID4gPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCj4gPiA+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYw0KPiA+ID4gQEAgLTIzNDgsNiAr
MjM0OCwxNCBAQCBzdGF0aWMgaW50IHBzcF9sb2FkX3NtdV9mdyhzdHJ1Y3QNCj4gcHNwX2NvbnRl
eHQgKnBzcCkNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICZhZGV2LT5maXJtd2FyZS51
Y29kZVtBTURHUFVfVUNPREVfSURfU01DXTsNCj4gPiA+ICAgICAgICAgc3RydWN0IGFtZGdwdV9y
YXMgKnJhcyA9IHBzcC0+cmFzX2NvbnRleHQucmFzOw0KPiA+ID4NCj4gPiA+ICsgICAgICAgLyog
U2tpcCBTTVUgRlcgcmVsb2FkaW5nIGluIGNhc2Ugb2YgdXNpbmcgQkFDTyBmb3IgcnVucG0gb25s
eSwNCj4gPiA+ICsgICAgICAgICogYXMgU01VIGlzIGFsd2F5cyBhbGl2ZS4NCj4gPiA+ICsgICAg
ICAgICovDQo+ID4gPiArICAgICAgIGlmIChhZGV2LT5pbl9ydW5wbSAmJg0KPiA+ID4gKyAgICAg
ICAgICAgIWFtZGdwdV9kZXZpY2Vfc3VwcG9ydHNfYm9jbyhhZGV2X3RvX2RybShhZGV2KSkgJiYN
Cj4gPiA+ICsgICAgICAgICAgIGFtZGdwdV9kZXZpY2Vfc3VwcG9ydHNfYmFjbyhhZGV2X3RvX2Ry
bShhZGV2KSkpDQo+ID4NCj4gPiBJIHRoaW5rIHRoaXMgd291bGQgYmUgYmV0dGVyIGFzOg0KPiA+
IGlmIChhZGV2LT5pbl9ydW5wbSAmJiAoYWRldi0+cG0ucnBtX21vZGUgIT0gQU1ER1BVX1JVTlBN
X0JPQ08pKQ0KPiBvciBzb21ldGhpbmcgbGlrZSB0aGF0Lg0KPiA+DQo+ID4gQWxleA0KPiA+DQo+
ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4gPiArDQo+ID4gPiAgICAgICAgIGlm
ICghdWNvZGUtPmZ3IHx8IGFtZGdwdV9zcmlvdl92Zihwc3AtPmFkZXYpKQ0KPiA+ID4gICAgICAg
ICAgICAgICAgIHJldHVybiAwOw0KPiA+ID4NCj4gPiA+IC0tDQo+ID4gPiAyLjE3LjENCj4gPiA+
DQo=
