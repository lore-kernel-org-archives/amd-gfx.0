Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479E9C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Mar 2022 12:11:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B36DD10E892;
	Tue, 29 Mar 2022 12:11:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BBC510E892
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Mar 2022 12:11:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ze1OwcgFPyC0k3cZ9STevsu00K1zker0qYv9zuP8ZAjl+7V0MvzKFGFemosIns55Sr5c//b+OFC4OK0jlQhjknkCxIu6EatJgFSFn1FMEhRZ9R834m54JXlHiUTBnPcHPPFqOtfPrD15crDfXkLOJiQ7aVPEdLlS0oHsfWClDO3Ujr9howyPUj6+niCiElWkMJZWaVfCIYCBPp1cObiqPQ117oQDmwdNyVOkPj1Jb9Xb9yQbzs/CNOOYMzfDNmLDZ9xTa6aXRKAIHeKaAdPZbrViEeRAyHQcmTnQhWgLXt85ZQgCZIi0qZxlKQm8ijGsXTe4qPL8RpoyE9/dU367tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBt/PYbyf9wlxP387C9JLOcjRHo0KgSyUOBnJkB+OI0=;
 b=PwsTOPGVGXMSjYF0VQ4nEOhl9Mtw0aj9u0vPwt9BS/4oO5Ul5sdZeKW4he8DGmNSJnvTdpg2lc2G26SuNiWfBsT+BOajcR1bScI5bRl9QOHogp0VFX6+EZhEypscz46MBt8D3vR4Ed1Bxc3pdDVsz8drE5osBRPAx7nIToI4osuZ20lRI6SMKtG04ElDXHxTC5po8IN6MP2xx6XuF8Eq8woMVCMVWizGf/amAUeZbaqYduoZtTcrGrLxbjJ1myvPkN0jSbf7YICJ3snQNxggBD56ENNO8G3gYNog0q2fGXDNUJYHMlGo/ANXpDD/gVWzM6Nw3StoE2mquo8OjbYmnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBt/PYbyf9wlxP387C9JLOcjRHo0KgSyUOBnJkB+OI0=;
 b=gFknfK3pmsvQo1TBk0R7xPYbX8aQPDlKidkAc5zlvHCbxdGZTZwxDgd3EFBjSull8XTYbNWF+N/Jp+UmQy4wYYn0xRklUWj+4Aa968htNp6HV/Pm+S/BZPB4X2zTz/lR/uP3z2JxGuiqHvo8nBG4Ye+epuP8ryNUX8o5EA2Wp7c=
Received: from DM5PR12MB1308.namprd12.prod.outlook.com (2603:10b6:3:76::7) by
 CH2PR12MB4053.namprd12.prod.outlook.com (2603:10b6:610:7c::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.17; Tue, 29 Mar 2022 12:10:58 +0000
Received: from DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::e05f:3a9a:b740:aa75]) by DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::e05f:3a9a:b740:aa75%10]) with mapi id 15.20.5102.023; Tue, 29 Mar
 2022 12:10:58 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add unique_id support for sienna cichlid
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add unique_id support for sienna cichlid
Thread-Index: AQHYQsZqeeRMLExPUkm6qTuMml7LGqzVxvqAgAB/XlA=
Date: Tue, 29 Mar 2022 12:10:57 +0000
Message-ID: <DM5PR12MB13089AF7B3F3B4C20FCA5345851E9@DM5PR12MB1308.namprd12.prod.outlook.com>
References: <20220328170759.1267968-1-kent.russell@amd.com>
 <20220328170759.1267968-2-kent.russell@amd.com>
 <414e2374-e0a3-affc-6ec3-931375ef29ac@amd.com>
In-Reply-To: <414e2374-e0a3-affc-6ec3-931375ef29ac@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=c6208075-c383-4420-9469-b9dacd818b3c;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-29T12:10:14Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 091b80c9-099c-4bae-f0e6-08da117d2ee0
x-ms-traffictypediagnostic: CH2PR12MB4053:EE_
x-microsoft-antispam-prvs: <CH2PR12MB4053AA71292C6E6E940A9B2F851E9@CH2PR12MB4053.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sPqxe1WGpkPErOzWNFIY7A/aPajKeyuIk/OKewUkb219zzGpkzXTw8uPPs/BqebCkxCGiYKq7/U2IhHJb+WAkzWO82OJiXoZ1RTBpyaC+bWIUFAc80H5PsbvmgyC6WKwHJLMtNi1CElJvx6fvGJsErYvXFUM5DaYFMp/zNazoG0yMbKYI37dj4xUxdRIg3InssrjqLH/WF71jApW0U9P0miFb1TK4p6MdXtLXJ66W+GMZbBbFxbAdL4y1ketV0657zJsoovkW+dHgAh/2/0h6j91Un5HN7SAJyNoCrmGIVLSLJCAX1Wg3tDneUvH9SHLD0qT8ly2Dy3x6OX+RaGZP5njI708gPPkDLZgSmQXehDBezVeahdOINEIoqOUD3/FLhXMZpUzFaRL+PzFs2WfocDViyCSZw+HVME7CqpA6jrYIIgsbK3KhUDfbHTTqmr+/TdGFIgo6L7nL+mny2Y9Bwu8CnrjrH6jTWU9bnwhcD+qtWFuMcyTc0r6imu/FsGFzg5ifqu6as0rFew/Qx8yvpCuBIkavr2PAt1PMXTT3eedM5t2d8dAVO7wmm2GyPRiJhVNhCW6AVG01LTUxALn0e0Nxph+sALoSzxAF0DUag48j0JcNt+SeAae1Au7f1h0zpFD+fy8+r5bASJVJBICI1eEwpDfsXagH0SzCB9wNSBDqgJF/xbtZzNa/aSMrUvzK1ugxARBZAIIM7kIvO6nEg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1308.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(66946007)(76116006)(66556008)(66476007)(66446008)(64756008)(8676002)(8936002)(52536014)(55016003)(4326008)(83380400001)(122000001)(38100700002)(2906002)(86362001)(33656002)(9686003)(316002)(110136005)(71200400001)(508600001)(186003)(7696005)(53546011)(6506007)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azE1eGQzTnEzNkJtMzJOQ1VKQmNnWDhSOXliYjhUb3lGR0hOak44ZlM3Qktm?=
 =?utf-8?B?SUovYmtoSWRqalhVWnEzMjZNK0FiWFVNRjFJbzZtL2VuOUhGa2NzZWdraHNH?=
 =?utf-8?B?bGtYYXNFd0UrN3I3UlQ2WFpxd3Y3cUgzeEdjaFE4Q01KTTdxS0tHc0VVWjIx?=
 =?utf-8?B?YVlSaXlYR09IOS9kakJXWGlZTUhHWUsrT3RrSEZMT0k0NVludGpmRXI4WlVT?=
 =?utf-8?B?YUtMWGIraEF1dGkzcSt6S2djMHdFZkFSK2NKNFZwVnRKaTVCc1dlVEY2M2hC?=
 =?utf-8?B?WVFGcE15SVMzY3pMVWtPMENNWGIrbkdwNjQ3ZkIwSzVZSzRIbk5ReUQvTnR0?=
 =?utf-8?B?VFpVZ2RiVWhNUmp3c3duT2dHS2kwUDRwbHlVdExmSU1TamR3L000aVlHQTdE?=
 =?utf-8?B?am9mUXh2ZmU4VmpxZ2xuN3lFMW5hK1Zlc291OUZkNnJ6SEdZUEZvNk1zc0tJ?=
 =?utf-8?B?SnpDYWFvMGhNcS85cmNka3NJTTlRNWQ0NlFybFNlc3NtaUpIQWl2K3ZzNUJj?=
 =?utf-8?B?aXNUM3B0WlpUR21EWW1uVU9wK3dTVzdhc1RhRjlxWHlicWVxTy9zZmJsSkEw?=
 =?utf-8?B?L2tSOUt0dUxSN1o2NGFGQWdNRmdvRkMxcktlNXE2YWRZcWptVDUyVDlpRDFK?=
 =?utf-8?B?R280YTVmdEpRTi9NeVlINWZtWit6bjNrRHhrdFpFWjRyTzJBOWRuMmkvZ1N0?=
 =?utf-8?B?NkZrZ3Y3RUZUbTdRVHpCc2xtMnd3OS8zSi85STVHNGw2WVZ4UFhJUWNxNGVp?=
 =?utf-8?B?U3B6ZnpUSldPUlV1ZGErWElFanVNNk1ObEpwcHFVd0NzcXBRb1Rnbm9mMEUx?=
 =?utf-8?B?Vm9KVmJhMGFqRUtFS00zbCtoUXpnKzYrZ2dOL2ZVVFJ1bXo3Q2hSc3dVaFVm?=
 =?utf-8?B?NGlBM2NkbXVzcnFweTMvMmI2TFRuR1BhTWZnbng3cEtiMHJ6MDdONXB2V1Bx?=
 =?utf-8?B?cGo0NlBkcllUSkd1dHdCbnpxRE5lQWtGVzFUTSs2UHBmYlB1RC9acXM5YzYw?=
 =?utf-8?B?NXZ4VzBtTUQ0eGg4Uk50QlVrazZMY1FpNkFwZE8zNWdubjU4WVNQMHlKeks2?=
 =?utf-8?B?TGx1LzVWSis4Q1JpOWJZcncvdVR3aUVIbFpYNFUzWUtRTEdJcDJqaFM1eUVF?=
 =?utf-8?B?b0VtMVo2UGgzdTZFY0RpakYyd3E0bjVJR1UxT3RVUllNMWYrYjJMbWpNQll6?=
 =?utf-8?B?RloxQ3BrWXlZalBldW9ReEptTjQzeFlaY2VUOHRHQTNlVGxyNldVWjQ4a1g4?=
 =?utf-8?B?cmhpQ2NxajFvcFpYQXUwZHkwRTN1dnU1eWgxU2o0YVUxQUw1UnVtWVZBbzFC?=
 =?utf-8?B?OE9lY0o2SE1ENzhyNmdPU3kyWnNZSVEwNzJSUkZKcDBkMmd6RjF2TnVmSDIr?=
 =?utf-8?B?V0Y2Z0RqbnVYa3JQSE54Q2FkQkZ6Ri83U0NKb0dxY1VzcDhrTWtpVzQ2Vm5n?=
 =?utf-8?B?VjJGbjJhdkt4MXVOKzNzQmgvbHBid2JKK1dIcXBPRGlUVGowYytab0l3Tisy?=
 =?utf-8?B?QTk4cTd3SjVveStMVFpuMWU0Qkt4ZGZaMDYwaVNtL0grRlJ2eFVrWURDQVF4?=
 =?utf-8?B?MUVmemNNNjljaTN1WEt1NHlLbkpmbjFweGt4WXVuNURwOFhrL3hjUGhpQmk2?=
 =?utf-8?B?RW5ScXp6dXUxRzRaV0NMczkrZGZRRVZzdlNlYlR2WEwrMFFibzhOZndoTWk0?=
 =?utf-8?B?aHIwS1FGclBrQncwQlEwQ2IyUVpRWVhoRHZCSkJhOS82THIzRElDdmhxbmMx?=
 =?utf-8?B?VlMvd1NLUGJXTHJaRmJNaWtmY3NnNVJVa3ErcFJ4R0J4SEI0NlJPZk16RklT?=
 =?utf-8?B?Mm9ZcmpTVmcwK1lqOXRoa3JPUXpiZzhXbTNvTlduVUh6Q2dmRFpIMFh1T2Y4?=
 =?utf-8?B?cytWWGpPSDJRbUhMU2YzOEZkb2VtNUU2NzV6dStlMEhsanBWanVSZFZXV2I5?=
 =?utf-8?B?eTVialYxNXpmOW84MXFVRG82WjZ5ZVM4T1o1am1FZ0NlNUhYdk1WK1pidXVJ?=
 =?utf-8?B?dG02eTczUXBvZWJrNGhxQ0pnckVYclBnby9INjdCejNneWp4eDNNSUJKb2dI?=
 =?utf-8?B?LzJScHFqZUoySDllcGUrMnZQWmxLRlFkRHVPK0o4SVJzbWxiUXdxUFFCdENx?=
 =?utf-8?B?bDFmWFlKWmROaWNFRmpQMVU2UWhLaFVLY0IwUFYxUTIvVVhvZDB2QndxSi9q?=
 =?utf-8?B?ck9sT3hVWlZ0MVJhRWl0NjNkdHZQb0pnS2pxalYweEl1M2E2ZVM5RHFhY0pG?=
 =?utf-8?B?TjdjSXNOYUxBOFl0L1lCUVlaNHBPQ0NRdWJGY3dNdGZuR01tMXRkSHhjbE9W?=
 =?utf-8?B?MGN2b2M4R01IYlNuV08rbDVVQloraFQvc1J5ajFMMGNLYjVBa1ExWDhSSDht?=
 =?utf-8?Q?aU3AjDkUzlJ+OCDh1lfpWp3g/6TcVkJmDbc+4QuXp3KYX?=
x-ms-exchange-antispam-messagedata-1: WqXWWxFBiV1TOg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 091b80c9-099c-4bae-f0e6-08da117d2ee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 12:10:58.0174 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YZLNPyEFY/YU7aZZdB99ogMd7nhn87HuMpx6XPzh8K2psNwNLWfOcdiOW/LHNmBykUFmg39JkIUizauKUCq01Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4053
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KQWggSSBkaWRu4oCZdCBzZWUgdGhhdCB3ZSBhZGRl
ZCBhIE1ldHJpY3MgdjMgaW4gdGhlcmUgYmV0d2VlbiBub3cgYW5kIHdoZW4gSSBtYWRlIG15IGZp
cnN0IHZlcnNpb24gb2YgdGhpcyBwYXRjaC4gSSdsbCB0ZXN0IGl0IG91dCBhbmQgbWFrZSBzdXJl
IHRoYXQgdGhpbmdzIGFyZSBzdGlsbCBsb29raW5nIGFscmlnaHQuIFRoYW5rcyBMaWpvIQ0KDQog
S2VudA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExhemFyLCBMaWpv
IDxMaWpvLkxhemFyQGFtZC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDI5LCAyMDIyIDEy
OjM0IEFNDQo+IFRvOiBSdXNzZWxsLCBLZW50IDxLZW50LlJ1c3NlbGxAYW1kLmNvbT47IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBkcm0vYW1k
Z3B1OiBBZGQgdW5pcXVlX2lkIHN1cHBvcnQgZm9yIHNpZW5uYSBjaWNobGlkDQo+DQo+DQo+DQo+
IE9uIDMvMjgvMjAyMiAxMDozNyBQTSwgS2VudCBSdXNzZWxsIHdyb3RlOg0KPiA+IFRoaXMgaXMg
YmVpbmcgYWRkZWQgdG8gU01VIE1ldHJpY3MsIHNvIGFkZCB0aGUgcmVxdWlyZWQgdGllLWlucyBp
biB0aGUNCj4gPiBrZXJuZWwuIEFsc28gY3JlYXRlIHRoZSBjb3JyZXNwb25kaW5nIHVuaXF1ZV9p
ZCBzeXNmcyBmaWxlLg0KPiA+DQo+ID4gdjI6IEFkZCBGVyB2ZXJzaW9uIGNoZWNrLCByZW1vdmUg
U01VIG11dGV4DQo+ID4gdjM6IEZpeCBzdHlsZSB3YXJuaW5nDQo+ID4gdjQ6IEFkZCBNUDEgSVBf
VkVSU0lPTiBjaGVjayB0byBGVyB2ZXJzaW9uIGNoZWNrDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBLZW50IFJ1c3NlbGwgPGtlbnQucnVzc2VsbEBhbWQuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gICBk
cml2ZXJzL2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9wbS5jICAgICAgICAgICAgfCAgMSArDQo+ID4g
ICAuLi4vcG1md19pZi9zbXUxMV9kcml2ZXJfaWZfc2llbm5hX2NpY2hsaWQuaCAgfCAxMCArKysr
LQ0KPiA+ICAgLi4uL2FtZC9wbS9zd3NtdS9zbXUxMS9zaWVubmFfY2ljaGxpZF9wcHQuYyAgIHwg
MzcgKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCA0NiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2FtZGdw
dV9wbS5jDQo+ID4gaW5kZXggNDE1MWRiMjY3OGZiLi40YTlhYWJjMTZmYmMgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfcG0uYw0KPiA+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMNCj4gPiBAQCAtMTk5Myw2ICsxOTkzLDcgQEAg
c3RhdGljIGludCBkZWZhdWx0X2F0dHJfdXBkYXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LA0KPiBzdHJ1Y3QgYW1kZ3B1X2RldmljZV8NCj4gPiAgICAgICAgICAgICBjYXNlIElQX1ZFUlNJ
T04oOSwgNCwgMCk6DQo+ID4gICAgICAgICAgICAgY2FzZSBJUF9WRVJTSU9OKDksIDQsIDEpOg0K
PiA+ICAgICAgICAgICAgIGNhc2UgSVBfVkVSU0lPTig5LCA0LCAyKToNCj4gPiArICAgICAgICAg
ICBjYXNlIElQX1ZFUlNJT04oMTAsIDMsIDApOg0KPiA+ICAgICAgICAgICAgICAgICAgICAgKnN0
YXRlcyA9IEFUVFJfU1RBVEVfU1VQUE9SVEVEOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgYnJl
YWs7DQo+ID4gICAgICAgICAgICAgZGVmYXVsdDoNCj4gPiBkaWZmIC0tZ2l0DQo+IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9pbmMvcG1md19pZi9zbXUxMV9kcml2ZXJfaWZfc2llbm5h
X2NpY2hsaWQuaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvaW5jL3BtZndfaWYv
c211MTFfZHJpdmVyX2lmX3NpZW5uYV9jaWNobGlkLmgNCj4gPiBpbmRleCAzZTRhMzE0ZWY5MjUu
LjAzN2YzOGIwZmExNSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3
c211L2luYy9wbWZ3X2lmL3NtdTExX2RyaXZlcl9pZl9zaWVubmFfY2ljaGxpZC5oDQo+ID4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9pbmMvcG1md19pZi9zbXUxMV9kcml2ZXJf
aWZfc2llbm5hX2NpY2hsaWQuaA0KPiA+IEBAIC0xNDE5LDggKzE0MTksMTEgQEAgdHlwZWRlZiBz
dHJ1Y3Qgew0KPiA+ICAgICB1aW50OF90ICBQY2llUmF0ZSAgICAgICAgICAgICAgIDsNCj4gPiAg
ICAgdWludDhfdCAgUGNpZVdpZHRoICAgICAgICAgICAgICA7DQo+ID4gICAgIHVpbnQxNl90IEF2
ZXJhZ2VHZnhjbGtGcmVxdWVuY3lUYXJnZXQ7DQo+ID4gLSAgdWludDE2X3QgUGFkZGluZzE2XzI7
DQo+ID4NCj4gPiArICB1aW50MzJfdCBQdWJsaWNTZXJpYWxOdW1Mb3dlcjMyOw0KPiA+ICsgIHVp
bnQzMl90IFB1YmxpY1NlcmlhbE51bVVwcGVyMzI7DQo+ID4gKw0KPiA+ICsgIHVpbnQxNl90IFBh
ZGRpbmcxNl8yOw0KPiA+ICAgfSBTbXVNZXRyaWNzX3Q7DQo+ID4NCj4gPiAgIHR5cGVkZWYgc3Ry
dWN0IHsNCj4gPiBAQCAtMTQ3Niw4ICsxNDc5LDExIEBAIHR5cGVkZWYgc3RydWN0IHsNCj4gPiAg
ICAgdWludDhfdCAgUGNpZVJhdGUgICAgICAgICAgICAgICA7DQo+ID4gICAgIHVpbnQ4X3QgIFBj
aWVXaWR0aCAgICAgICAgICAgICAgOw0KPiA+ICAgICB1aW50MTZfdCBBdmVyYWdlR2Z4Y2xrRnJl
cXVlbmN5VGFyZ2V0Ow0KPiA+IC0gIHVpbnQxNl90IFBhZGRpbmcxNl8yOw0KPiA+DQo+ID4gKyAg
dWludDMyX3QgUHVibGljU2VyaWFsTnVtTG93ZXIzMjsNCj4gPiArICB1aW50MzJfdCBQdWJsaWNT
ZXJpYWxOdW1VcHBlcjMyOw0KPiA+ICsNCj4gPiArICB1aW50MTZfdCBQYWRkaW5nMTZfMjsNCj4g
PiAgIH0gU211TWV0cmljc19WMl90Ow0KPiA+DQo+DQo+IEhpIEtlbnQsDQo+DQo+IEFyZSB5b3Ug
dXNpbmcgdGhlIGxhdGVzdCBjb2RlPw0KPg0KPiAgICB1aW50OF90ICBQY2llV2lkdGg7DQo+ICAg
IHVpbnQxNl90IEF2ZXJhZ2VHZnhjbGtGcmVxdWVuY3lUYXJnZXQ7DQo+DQo+IH0gU211TWV0cmlj
c19WM190Ow0KPg0KPg0KPiBWMyBpcyB3aGF0IEkgc2VlIGFzIHRoZSBsYXRlc3QgaW4gb3VyIHNv
dXJjZSBhbmQgdGhpcyBzdHJ1Y3QgaXMNCj4gY29uc2lzdGVudCB3aXRoIHRoZSBsYXRlc3QgUE1G
Vy4NCj4NCj4gVGhhbmtzLA0KPiBMaWpvDQo+DQo+ID4gICB0eXBlZGVmIHN0cnVjdCB7DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEvc2llbm5hX2Np
Y2hsaWRfcHB0LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTExL3NpZW5u
YV9jaWNobGlkX3BwdC5jDQo+ID4gaW5kZXggMzhmMDQ4MzZjODJmLi4xNDAwMDViZjZkOWUgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMS9zaWVubmFf
Y2ljaGxpZF9wcHQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211
MTEvc2llbm5hX2NpY2hsaWRfcHB0LmMNCj4gPiBAQCAtNDgxLDYgKzQ4MSw0MiBAQCBzdGF0aWMg
aW50IHNpZW5uYV9jaWNobGlkX3NldHVwX3BwdGFibGUoc3RydWN0IHNtdV9jb250ZXh0DQo+ICpz
bXUpDQo+ID4gICAgIHJldHVybiBzaWVubmFfY2ljaGxpZF9wYXRjaF9wcHRhYmxlX3F1aXJrKHNt
dSk7DQo+ID4gICB9DQo+ID4NCj4gPiArc3RhdGljIHZvaWQgc2llbm5hX2NpY2hsaWRfZ2V0X3Vu
aXF1ZV9pZChzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkNCj4gPiArew0KPiA+ICsgICBzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiA9IHNtdS0+YWRldjsNCj4gPiArICAgc3RydWN0IHNtdV90YWJs
ZV9jb250ZXh0ICpzbXVfdGFibGUgPSAmc211LT5zbXVfdGFibGU7DQo+ID4gKyAgIFNtdU1ldHJp
Y3NfdCAqbWV0cmljcyA9DQo+ID4gKyAgICAgICAgICAgJigoKFNtdU1ldHJpY3NFeHRlcm5hbF90
ICopKHNtdV90YWJsZS0+bWV0cmljc190YWJsZSkpLT5TbXVNZXRyaWNzKTsNCj4gPiArICAgU211
TWV0cmljc19WMl90ICptZXRyaWNzX3YyID0NCj4gPiArICAgICAgICAgICAmKCgoU211TWV0cmlj
c0V4dGVybmFsX3QgKikoc211X3RhYmxlLT5tZXRyaWNzX3RhYmxlKSktPlNtdU1ldHJpY3NfVjIp
Ow0KPiA+ICsgICB1aW50MzJfdCB1cHBlcjMyID0gMCwgbG93ZXIzMiA9IDA7DQo+ID4gKyAgIGJv
b2wgdXNlX21ldHJpY3NfdjI7DQo+ID4gKyAgIGludCByZXQ7DQo+ID4gKw0KPiA+ICsgICAvKiBP
bmx5IHN1cHBvcnRlZCBhcyBvZiB2ZXJzaW9uIDAuNTguODMuMCBhbmQgb25seSBvbiBTaWVubmEg
Q2ljaGxpZCAqLw0KPiA+ICsgICBpZiAoc211LT5zbWNfZndfdmVyc2lvbiA8IDB4M0E1MzAwIHx8
DQo+ID4gKyAgICAgICBzbXUtPmFkZXYtPmlwX3ZlcnNpb25zW01QMV9IV0lQXVswXSAhPSBJUF9W
RVJTSU9OKDExLCAwLCA3KSkNCj4gPiArICAgICAgICAgICByZXR1cm47DQo+ID4gKw0KPiA+ICsg
ICByZXQgPSBzbXVfY21uX2dldF9tZXRyaWNzX3RhYmxlKHNtdSwgTlVMTCwgZmFsc2UpOw0KPiA+
ICsgICBpZiAocmV0KQ0KPiA+ICsgICAgICAgICAgIGdvdG8gb3V0X3VubG9jazsNCj4gPiArDQo+
ID4gKyAgIHVzZV9tZXRyaWNzX3YyID0gKChzbXUtPmFkZXYtPmlwX3ZlcnNpb25zW01QMV9IV0lQ
XVswXSA9PSBJUF9WRVJTSU9OKDExLCAwLA0KPiA3KSkgJiYNCj4gPiArICAgICAgICAgICAoc211
LT5zbWNfZndfdmVyc2lvbiA+PSAweDNBNDMwMCkpID8gdHJ1ZSA6IGZhbHNlOw0KPiA+ICsNCj4g
PiArICAgdXBwZXIzMiA9IHVzZV9tZXRyaWNzX3YyID8gbWV0cmljc192Mi0+UHVibGljU2VyaWFs
TnVtVXBwZXIzMiA6DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1ldHJpY3Mt
PlB1YmxpY1NlcmlhbE51bVVwcGVyMzI7DQo+ID4gKyAgIGxvd2VyMzIgPSB1c2VfbWV0cmljc192
MiA/IG1ldHJpY3NfdjItPlB1YmxpY1NlcmlhbE51bUxvd2VyMzIgOg0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBtZXRyaWNzLT5QdWJsaWNTZXJpYWxOdW1Mb3dlcjMyOw0KPiA+
ICsNCj4gPiArb3V0X3VubG9jazoNCj4gPiArDQo+ID4gKyAgIGFkZXYtPnVuaXF1ZV9pZCA9ICgo
dWludDY0X3QpdXBwZXIzMiA8PCAzMikgfCBsb3dlcjMyOw0KPiA+ICsgICBpZiAoYWRldi0+c2Vy
aWFsWzBdID09ICdcMCcpDQo+ID4gKyAgICAgICAgICAgc3ByaW50ZihhZGV2LT5zZXJpYWwsICIl
MDE2bGx4IiwgYWRldi0+dW5pcXVlX2lkKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgIHN0YXRpYyBp
bnQgc2llbm5hX2NpY2hsaWRfdGFibGVzX2luaXQoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpDQo+
ID4gICB7DQo+ID4gICAgIHN0cnVjdCBzbXVfdGFibGVfY29udGV4dCAqc211X3RhYmxlID0gJnNt
dS0+c211X3RhYmxlOw0KPiA+IEBAIC00MTgyLDYgKzQyMTgsNyBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IHBwdGFibGVfZnVuY3Mgc2llbm5hX2NpY2hsaWRfcHB0X2Z1bmNzID0gew0KPiA+ICAgICAu
Z2V0X2VjY19pbmZvID0gc2llbm5hX2NpY2hsaWRfZ2V0X2VjY19pbmZvLA0KPiA+ICAgICAuZ2V0
X2RlZmF1bHRfY29uZmlnX3RhYmxlX3NldHRpbmdzID0NCj4gc2llbm5hX2NpY2hsaWRfZ2V0X2Rl
ZmF1bHRfY29uZmlnX3RhYmxlX3NldHRpbmdzLA0KPiA+ICAgICAuc2V0X2NvbmZpZ190YWJsZSA9
IHNpZW5uYV9jaWNobGlkX3NldF9jb25maWdfdGFibGUsDQo+ID4gKyAgIC5nZXRfdW5pcXVlX2lk
ID0gc2llbm5hX2NpY2hsaWRfZ2V0X3VuaXF1ZV9pZCwNCj4gPiAgIH07DQo+ID4NCj4gPiAgIHZv
aWQgc2llbm5hX2NpY2hsaWRfc2V0X3BwdF9mdW5jcyhzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkN
Cj4gPg0K
