Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9331C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Apr 2022 18:34:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5494510E1DC;
	Thu, 14 Apr 2022 18:34:15 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2081.outbound.protection.outlook.com [40.107.100.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE23C10E1DC
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Apr 2022 18:34:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yo42NapwqXYwWPtv+fgStkKkRmb1kBg581TbWqi28Kx5xBTRsklCIPPrSQqkeg4mdUjgIeHF44ZJEykXGkHvSNx90eyx4wweMRsOl3g4qwnHVkSBOvgQBlb55oS2LgNZI1KEP1K5ctMxU722PfhKsrjYlekArqHdrzrK1QjjpWDoJaBSKFpqjutPvmLhYY4TQn4Fi1VmRGazMC+mvpE0uZQX0BQy6P6yivSBuJeDaGjIys0THnZmwB9krssM2sCQ13JZIb714OK1QQVpUsevdCaJgAyzMmmGR7Q6IpQ9JVG6rCRMt9kMVsVUT6nLG/8AIhaurwhfyE4GNz2uZRHN8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tYYszzmGeiPKnEtKTZJWg2Zcp7IIDdEDGkq8U2wBRI=;
 b=dWQFZsfK2wpF7/3ffnLYiRbh6MvHoJ3yRaGM4vKTBaSSsdsUrn3ckucAEy/S9EiT3eJEr8V9rtDbKuwW6W38OvoArsoKVwr6Dh9xoIKCAjSzL3IKdJeCpfJtq6z3J18M+oIjpyka00h4lqC/T9pxtODpWDb0tDaZVIfbJFMJ2lN5MAVowjLUs8wEjOcD9ySwnpd9DXKC23BbQvKjCbv6kHXmi5PCv7D24Pr3LvqE2R/T2DjNDFlw2HNxlJLiQ3/VWMo3OvXTNeKqo1B9b6DV9B1qXT2gIEiTXBz/J2vNFii/ZCwkA7r52eenTwIJGNulk0DXfXspInJyjWy3HdToXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tYYszzmGeiPKnEtKTZJWg2Zcp7IIDdEDGkq8U2wBRI=;
 b=1d1tkPu5GqBYS1krkGHraFwZe0C1yrBg38nbYzPCPzdMeRl3bsP5Y4sKz92Zj4kfeuB8jIuVi193bCnaqMVpPI/6yovxZnls+hmZKl4LD2gSL4OFz22Mu1p4cci4ojRJAtkKmuoL4It6hoLijnX+OWNbk1AsxTjUz5N7J4Cez9U=
Received: from DM4PR12MB5230.namprd12.prod.outlook.com (2603:10b6:5:399::11)
 by CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 18:34:11 +0000
Received: from DM4PR12MB5230.namprd12.prod.outlook.com
 ([fe80::8d6f:13f6:b12:7b0c]) by DM4PR12MB5230.namprd12.prod.outlook.com
 ([fe80::8d6f:13f6:b12:7b0c%7]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 18:34:11 +0000
From: "Wan, Gavin" <Gavin.Wan@amd.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [PATCH] drm/amd/amdgpu: Remove static from variable in RLCG Reg
 RW.
Thread-Topic: [PATCH] drm/amd/amdgpu: Remove static from variable in RLCG Reg
 RW.
Thread-Index: AQHYT0rzGsqQFDffV0G3U/Uuk0lPl6zvtAMAgAAJUbA=
Date: Thu, 14 Apr 2022 18:34:11 +0000
Message-ID: <DM4PR12MB5230E0150C91342C5F66B611FCEF9@DM4PR12MB5230.namprd12.prod.outlook.com>
References: <20220413152641.830023-1-Gavin.Wan@amd.com>
 <9d77bd3d-782b-7866-7ae2-c2f88f1e1002@molgen.mpg.de>
In-Reply-To: <9d77bd3d-782b-7866-7ae2-c2f88f1e1002@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=c6145f42-f076-4faa-9888-73fcf4a1be99;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-14T18:32:12Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a2ce8ec-b6bb-4a04-56bd-08da1e455e88
x-ms-traffictypediagnostic: CH0PR12MB5388:EE_
x-microsoft-antispam-prvs: <CH0PR12MB5388CBF632A9F44C4C54415DFCEF9@CH0PR12MB5388.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZtlDHK+a5AAMTuY7htICjVvMB36SxclO2RmGqpfawVHFF7EMmwzA687AhpY9nGGxYV5UYG6lTRFeoyE7WJsBi6KyiouTFmBkPBbA1nZWM0kmJiW2NsEQt0+h1sNkpoX3eQ155yFoVz5FZOHSoG4B5ntVe1JzgN7L/27H9gOdDsi7mk1fEAvCrlt6e562YT8s6c7P9rx2QpsAOK2XvymB3EK7ivz+pDnnB677pa7VjHCCJWE8x4340EVsGgc2umBpGXmAkyrjxwKloxxeM9JWxjnTAbFk+ZwIhL+I8vnwYugzh4d376ovW5yMMxXFKrSWDwNI92S2aTGfJIgK0OGCpi4sRerS2yINEc03h0sAdnd4HjrypqEQ3OYVvAxLFOkJgR/nvq5nYD40kL0rlrqn6Gno+msKXFBnfg+ObzrNlfbxXEZHuIrkAtjsSS97CzWN70AcSQ0ChehDzG4BFC3/uKcBp9Ggo3lXoewf6rEvFnaIHGD1xuYgB8TLlVzOnYWkC7o9dxgswmmIBivAj4qSn+nYV/0lmPtXDXz7FoTTwplNa3xY1HpUCg2iD3/ku4NPOXUoMRfokeY8lPFAqdsBmcPbdJMX4z/eUCLzf9h6LPHpT87fqCj3dUuNbq8RUuQ4lPBVObSDcCwGIBBM5LwjPMU5O1BOF80AVycPuCS+pSldonGQlGzAYDf8ZDrFq1py+tsBWsEWz7JyLnY0D3Jw2w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5230.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(8936002)(4326008)(122000001)(186003)(66946007)(55016003)(66446008)(66476007)(38100700002)(66556008)(64756008)(8676002)(52536014)(26005)(5660300002)(76116006)(9686003)(38070700005)(7696005)(33656002)(508600001)(2906002)(86362001)(6506007)(53546011)(6916009)(71200400001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akNxbW90RndWRm4vVnZDbkd4OVB0Q0I3bW9Ib0ZZQk5HVTVLMUFNT3dQT1RJ?=
 =?utf-8?B?R2I5TVdkRTVabjI3aWlseWJidkNneXNhbXpUMFBHM3lZRVEzeUYya0dhTGR3?=
 =?utf-8?B?RkZwWENtR2xEZXlHQmp3N1R2RXZNTE5LbXJkR1lXZU9QaFl3TEh1ZnVZNmkz?=
 =?utf-8?B?L1FzK3QxODFWSWZmdkMwcUtMcXlxQXArSEV2Vms3V1dHdTJWd0gwS3I1RDI2?=
 =?utf-8?B?LzI5RlFjYmJJVE15UTF1RXZlck5IdFpoSWF5clZseEg2eVRsQlZpK2o2VWZ4?=
 =?utf-8?B?V055c2c1cHo3aHNCTkQ1VEZwdm9XSmhhV1BNVkU3NHlGeVlMeG8vVUs0eHpv?=
 =?utf-8?B?NHZoUDVvQ3ljd0dPRkI5cE45d0ZsMm1zbnRxQkJONFI5VENCM0tLbmFVWlZZ?=
 =?utf-8?B?WjlVcXFKRWRYZDk3MkJsbWFLcEpmNWluZ1BjRzVJOGJUMEdGa0xzQlRvZ0sw?=
 =?utf-8?B?V3g3VmFFc3BXUG51Tnl4c0xQdHFxSE9DdmZ2TzB3ZmQ2dXNZbVNSQngvVFFq?=
 =?utf-8?B?TExjN3hnVGluRGtmN1BMZGV3Q091cDBOR1NHazh4b25DcSt0blIwMVRWbVF2?=
 =?utf-8?B?QmxLTmdaVlk1eGxWOHdXZS96eGlSR2ZqZ2RUUUJEZ1YwR0xmdEFVdHg2OTFm?=
 =?utf-8?B?UlFiT1ZyUUJBR1dDdjJHeUFRcU1rRlJpQ3B5bG5xd3dmQWVRT05OZVREYnZU?=
 =?utf-8?B?YzVSZ3pmRWc1VFZEVjdURUZ1aVBLTnd3UmhGSW9TVjlHT3U2cXJXOUxTYnEy?=
 =?utf-8?B?WGJWdEppclRLaFpIVTVScUMyQmNqQjQzU2tjZzhtZGYzZlp5UXdBV05sTGZP?=
 =?utf-8?B?YkN1Um1IbWtGZHN1Q3lFZUhzRnhwbUNnWE5hMWprQm5Tck5xZ1VhL2cvRElt?=
 =?utf-8?B?M3dKTVlYMUtVTGlCQWl4THkzTnFpelhyZ1BDdU43b1lYMkwwWjlBdlpLdjkr?=
 =?utf-8?B?czBicHJQdUxVL3hTc1l2ZjRBVXVMNVRsT0FxTFgvcnE3Vm9PZGNiMzJYSW81?=
 =?utf-8?B?ckdiazZ6dktZQWFvUm5jaThkRHZ6WkhsRmEvYktVYzJ3QmZVSU9Sa2tzQUhs?=
 =?utf-8?B?dGpDNWx2YjFyWXZaMk5QdXVRWHcvamlkaVA0emFROStkRDVFbmpMVlVZL0dG?=
 =?utf-8?B?WFdiaHFINUZjTVc4SjhnUVVJZ2JpeGZySWZTMWF2cGl0TWxjNlU0T0JIbDZv?=
 =?utf-8?B?V1Q5WTJZb2JIc3hSTjhobnc4WG92RXk2N0tXK0o3TVpFaUZ1azZQQ1NteDFx?=
 =?utf-8?B?Q0NJeEtDOTlwSmthdFhmaThnY3QvRmVNeExIMHVHYU8yUGpPenRqQ29qNkZl?=
 =?utf-8?B?QjdTeFQ3T29nWTdSRHJYYy9RcExuZDdQcXRtQVNxRnJySXRZanJBcnFZZUdz?=
 =?utf-8?B?SXF5L2N3NTRWNWxQbVRhU1BESmtiN1pVR2RCampyYzBBd0tVVHc0UThqblpD?=
 =?utf-8?B?T3BlN1d5eEpCcHQ1cHRNL3VtL3pYaGFUM0V3RUNQMUllczRpUnpTS082NzBG?=
 =?utf-8?B?eGlERkFpZlRZSys3TitQOTE4eVMwNXlld2ViMk91c0crbVk0UmtlUXpFdlI1?=
 =?utf-8?B?UTZhdU9TdUFrOEIwSk1MVjNuS1RBZ2VBMEVyc2xVbHBzU1JXQy9INjZ2aXA4?=
 =?utf-8?B?WHp5UCt2WHhFeTlFRm9mbVVjWnRYcGZyMnd1SHFPdUZhVzBUOFdtVitod2E4?=
 =?utf-8?B?d1VXMHVKS2VsREliTjZXTkM3VDR1UjFsTHB0WU5NNXZqMVJDOTByeHFrTFRM?=
 =?utf-8?B?YW5paUNCckV5R29ZUm11Ym5xSG5SUzVDL3RZNS9WRnRHN1V0elRVNkRPU1Zu?=
 =?utf-8?B?U1VpUmNSNXJhQmlGdWhhakUvWm5VZ0xzT1VtdDAxMHhyOGZVbUMrZjdYajk2?=
 =?utf-8?B?QktoMXkwUU43VjZRNmRPQVV2S2l3NlU2S1BJSy9Ea0orcm5OVFNReFljZW1o?=
 =?utf-8?B?RlJjUzhFdld0TlFZYXE5S3UxbEkyUENJMXNGUm5LOHpjOFhVVk1pRzBtSEZ6?=
 =?utf-8?B?eTlCbk5aZUVtZDVLSElSU2orYlBOQytBNWF0eWdzN2xoWE1DNG93TC96T2tQ?=
 =?utf-8?B?N1ZjdFc5VDFIdWU5UzNjVFVtbFRNdE1KTTIrKy80Q3JwUlZma3hFeUMwR0dY?=
 =?utf-8?B?emJMYTFkQ1Fyc0Zha25QRWFIbVdoaHQrYWc5Q0ZNL2psS1lxa0VxZGJaL3pD?=
 =?utf-8?B?MHRxRFM2SUQwZHkvOG5NMlVicXg0alZnSWx3bVZVK1JCZWtXTDBkaVhMS2tB?=
 =?utf-8?B?NVNXeXVsNDZDd2dXZ3BUdGh0ckdSZXhCeWZCeS9VeHlqNGRrNkh0NnRQODUr?=
 =?utf-8?Q?sRE1q9vxYnVCPLaZF9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5230.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2ce8ec-b6bb-4a04-56bd-08da1e455e88
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 18:34:11.3291 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sFp9RR+j9rqxNK1GnKJm9AZpGv1Cdvhj4TN1WG2CQa+fYnFSCqKoFQ7DmY8slOOD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5388
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KRGVhciBQYXVsLA0KDQpUaGFua3MgZm9yIHlvdSBj
b21tZW50cy4gTGV0IG1lIGRvIGl0Lg0KDQpUaGFua3MsDQpHYXZpbg0KDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KRnJvbTogUGF1bCBNZW56ZWwgPHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4N
ClNlbnQ6IFRodXJzZGF5LCBBcHJpbCAxNCwgMjAyMiAxOjU5IFBNDQpUbzogV2FuLCBHYXZpbiA8
R2F2aW4uV2FuQGFtZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNClN1
YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWQvYW1kZ3B1OiBSZW1vdmUgc3RhdGljIGZyb20gdmFy
aWFibGUgaW4gUkxDRyBSZWcgUlcuDQoNCkRlYXIgR2F2aW4sDQoNCg0KVGhhbmsgeW91IGZvciB5
b3VyIHBhdGNoLg0KDQpBbSAxMy4wNC4yMiB1bSAxNzoyNiBzY2hyaWViIEdhdmluIFdhbjoNCg0K
U2hvdWxkIHlvdSByZS1yb2xsIHlvdXIgcGF0Y2ggKHYyKSwgcGxlYXNlIHJlbW92ZSB0aGUgZG90
L3BlcmlvZCBmcm9tIHRoZSBlbmQgb2YgdGhlIGdpdCBjb21taXQgbWVzc2FnZSBzdW1tYXJ5IChz
dWJqZWN0KS4NCg0KPiBbd2h5XSBUaGVzZSBzdGF0aWMgdmFyaWFibGVzIHNhdmVzIHRoZSBSTEMg
U2NyYXRjaCByZWdpc3RlcnMgYWRkcmVzcy4NCg0Kcy9zYXZlcy9zYXZlLw0KDQo+ICAgICAgICBX
aGVuIHdlIGluc3RhbGxlZCBtdWx0aXBsZSBHUFVzIChmb3IgZXhhbXBsZTogWEdNSSBzZXR0aW5n
KSBhbmQNCg0Kcy9pbnN0YWxsZWQvaW5zdGFsbC8NCg0KPiAgICAgICAgbXVsdGlwbGUgR1BVcyBj
YWxsIHRoZSBmdW5jdGlvbiBhdCBzYW1lIHRpbWUuIFRoZSBSTEMgU2NyYXRjaA0KDQrigKYgc2Ft
ZSB0aW1lLCB0aGUgUkxDIOKApg0KDQo+ICAgICAgICByZWdpc3RlcnMgYWRkcmVzcyBhcmUgY2hh
bmdlZCBlYWNoIG90aGVyLiBUaGVuIGl0IGNhdXNlZA0KDQpzL2NhdXNlZC9jYXVzZXMvDQoNCj4g
ICAgICAgIHJlYWRpbmcvd3JpdGluZyB0byB3cm9uZyBHUFUuDQoNCkkgc2VlIGZyb20gb3RoZXIg
cGF0Y2hlcyBwb3N0ZWQgaGVyZSwgdGhhdCBbd2h5XSBpcyBwdXQgb24gYSBzZXBhcmF0ZSBsaW5l
LCBzbyB5b3UgZG8gbm90IG5lZWQgdG8gaW5kZW50IHRoZSB0ZXh0Lg0KDQpbd2h5XQ0KDQpUaGVz
ZSBzdGF0aWMg4oCmDQoNCj4NCj4gW2ZpeF0gUmVtb3ZlZCB0aGUgc3RhdGljIGZyb20gdGhlIHZh
cmlhYmxlcy4gVGhlIHZhcmlhYmxlcyBhcmUNCj4gICAgICAgIGluIHN0YWNrLg0KDQpTYW1lIGhl
cmUsIHRob3VnaCAqaG93KiBpbnN0ZWFkIG9mICpmaXgqIHNlZW1zIG1vcmUgY29tbW9uLg0KDQpz
L1JlbW92ZWQvUmVtb3ZlLw0Kcy9pbiBzdGFjay9vbiB0aGUgc3RhY2svDQoNCj4NCj4gU2lnbmVk
LW9mZi1ieTogR2F2aW4gV2FuIDxHYXZpbi5XYW5AYW1kLmNvbT4NCj4gQ2hhbmdlLUlkOiBJZWU3
ODg0OTI5MWQ0ZjdhOTY4OGVjYzUxNjViZWM3MGVlODVjZGZiZQ0KDQpXaXRob3V0IHRoZSBHZXJy
aXQgVVJMIHRoYXQgbGluZSBpcyB1c2VsZXNzLg0KDQoNCktpbmQgcmVnYXJkcy4NCg0KUGF1bA0K
DQoNCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuYyB8
IDEwICsrKysrLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRl
bGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZpcnQuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0
LmMNCj4gaW5kZXggZDVlZWEwMzFjM2UzLi5kMThhMDVhMjA1NjYgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0LmMNCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuYw0KPiBAQCAtODY4LDExICs4NjgsMTEgQEAg
c3RhdGljIHUzMiBhbWRncHVfdmlydF9ybGNnX3JlZ19ydyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwgdTMyIG9mZnNldCwgdTMyIHYNCj4gICAgICAgdWludDMyX3QgdGltZW91dCA9IDUwMDAw
Ow0KPiAgICAgICB1aW50MzJfdCBpLCB0bXA7DQo+ICAgICAgIHVpbnQzMl90IHJldCA9IDA7DQo+
IC0gICAgIHN0YXRpYyB2b2lkICpzY3JhdGNoX3JlZzA7DQo+IC0gICAgIHN0YXRpYyB2b2lkICpz
Y3JhdGNoX3JlZzE7DQo+IC0gICAgIHN0YXRpYyB2b2lkICpzY3JhdGNoX3JlZzI7DQo+IC0gICAg
IHN0YXRpYyB2b2lkICpzY3JhdGNoX3JlZzM7DQo+IC0gICAgIHN0YXRpYyB2b2lkICpzcGFyZV9p
bnQ7DQo+ICsgICAgIHZvaWQgKnNjcmF0Y2hfcmVnMDsNCj4gKyAgICAgdm9pZCAqc2NyYXRjaF9y
ZWcxOw0KPiArICAgICB2b2lkICpzY3JhdGNoX3JlZzI7DQo+ICsgICAgIHZvaWQgKnNjcmF0Y2hf
cmVnMzsNCj4gKyAgICAgdm9pZCAqc3BhcmVfaW50Ow0KPg0KPiAgICAgICBpZiAoIWFkZXYtPmdm
eC5ybGMucmxjZ19yZWdfYWNjZXNzX3N1cHBvcnRlZCkgew0KPiAgICAgICAgICAgICAgIGRldl9l
cnIoYWRldi0+ZGV2LA0K
