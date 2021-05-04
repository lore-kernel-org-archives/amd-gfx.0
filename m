Return-Path: <SRS0=AKuh=J7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FF7C433B4
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 02:06:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F211611CD
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 02:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F211611CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A8896EA6A;
	Tue,  4 May 2021 02:06:08 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750059.outbound.protection.outlook.com [40.107.75.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6DA66EA68
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 May 2021 02:06:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Flt3F88sflGoAgag0RVbIF1NPmvcALpUSdyj/Gu9mBxrk+p0qY+cVq9jfRxOAkve4IxYbK5JftaAKgAs9wEx+SorfHADm9Z00Znea4dSxZnh1DFFkVaGz/PNy/6sBEiuGZgkzcjPVEWORXXMmGclT/qyf6XKItkRZhTYzFWyIFG6YveB/48VoF8IKi81cOIGh2XokTJPVl2JMNWPCwmL1LuXHDAezU4HAXl1W0eE/8OeFpf1/T1uNf/R8ol686CzA8F2YMUrbjy5yuGat8HSHmV/DTpN3TezjFeDFu4zY71fB6xOyizqIX5XCTLW4oXiV32g7l4bXQdjpskgEL3liw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7i7stIb10I5c6F7zmy9Bj50PmwqGPrlIVroLlLzlz6o=;
 b=m9T5bWGQm1b3IPH1kruzVjOmrGQsIEP1c256/6i4PXjhRwHSgd3ix4ipXhXYeimsCpfg3V8JPlVm7k1Uv5JUqUmduXE6p07jWxw9DUc7cuMoSSlj7Pe+hYxUXSbQxlCKRxB9HSqqyhJASCUHDqvgqPjBeMOcfGwsNqVeVXQ70TdTGQ9nW/IBE/ipnjcoWzXP80KadN+E/mzNYRPG7NGl377TtY5tuZqW+tG4R4mQ0WHn/ZH0EJuGVgtDldBmHffB7gVMU6KF3Jenthtvb0W3PMdYCb673LmOouHkkWO1f3Xj2ceaKJxiVGviEBc0qHw49RYvxteJtAJUmJG11NQaOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7i7stIb10I5c6F7zmy9Bj50PmwqGPrlIVroLlLzlz6o=;
 b=yKOqK9TwkaSWCoSBh7f1BgI8cQ7OHShMsuzUHDj9QlMII0fKqSDqTDYP5Z7cmgH/9TYIVug4SZpbs4lszcfILSe/jYg6gKCTiWEFz3QG4x5V+TIHbyf2vepfPOSFS9dvbWbtjnM/qAxbGEncTN9omtBuxsd2qSgsaJ33ndC78y4=
Received: from DM6PR12MB4732.namprd12.prod.outlook.com (2603:10b6:5:32::25) by
 DM6PR12MB4844.namprd12.prod.outlook.com (2603:10b6:5:1d0::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.41; Tue, 4 May 2021 02:06:04 +0000
Received: from DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4]) by DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4%3]) with mapi id 15.20.4087.041; Tue, 4 May 2021
 02:06:04 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH] drm/amdkfd: fix no atomics settings in the kfd topology
Thread-Topic: [PATCH] drm/amdkfd: fix no atomics settings in the kfd topology
Thread-Index: AQHXQFV7JeFMIHZPF02cE86DGtKrRarSUFiA
Date: Tue, 4 May 2021 02:06:03 +0000
Message-ID: <EA50271A-C23D-4471-8C96-3452089FEB48@amd.com>
References: <20210503194932.121989-1-jonathan.kim@amd.com>
In-Reply-To: <20210503194932.121989-1-jonathan.kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.46.21021202
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39d008bd-9815-4793-f470-08d90ea12c0a
x-ms-traffictypediagnostic: DM6PR12MB4844:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB484474789FAB136A15D3C2BF805A9@DM6PR12MB4844.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ko3S9QroEuP9Wf8wbVBuzAQn8EDopd7HbBuzEd81tgb+F3UJc5rL2CMi8hojC7liLx//m94qVS2LZK9xA2pdT+xqZn6ETf/exWhlEOKjrdQXW14Ao9zGQeelVVSUhHWy/YtCOw/vpalRH5dJFsRog+AWtuL/2rainBe7gHkVD/D7Lmpyye0xI5IPdVC2TdpT9uBdycptByUGHv4o6FSQAEV/4t8mURbTafyOZgEVHWX20fe0fltksvBPs8nUPOKYrF9mJDUak76zDRmWOo9/wB9P8aQ5+2Stj4AilY2747OqO7jLlFkGsjSxRTNqYVeXf9LarLhsVOb/ZNxbKWAtYZ1zcMfaKOPI9pc8oKz+ZpYSyqqLHGQTZ5kysv/ToRxKfOu3yQF9WQy6qn/PLJqI9ftW4eVTFFF1Bl5RJGpgWZrqgkk2ky0UsRCyUjSIVx2c6zVsO6a1hd3O6NTglfn5Xw9IC7wehcBKiDtNMCv966BmdsERikcPVqQOutZ8WYaM1ivXydag5FSg6OUz30Zs8K4Vdfy5qa3MXVE2U9w16Ni59zYoFbE7e71StsSfO3QMtVPj7jcT4sblW3bwcfJzfTaLWilyiW15gB+bX6j7dvW9VS0+GBPAhmkLJDcRlz1QisRfkkCRtlIepb7W4t0jALgbliQhDnMXLLg0AuIG8qWET0oxYVFfN7nTkALK0Cze
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4732.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(5660300002)(110136005)(478600001)(38100700002)(966005)(8676002)(66446008)(6636002)(64756008)(86362001)(66556008)(316002)(83380400001)(2906002)(6486002)(6512007)(66946007)(76116006)(36756003)(8936002)(6506007)(186003)(71200400001)(91956017)(26005)(45080400002)(2616005)(66476007)(122000001)(33656002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?bzczc25iL0wwWjl0UXNGbGszNzIrN1hyeHppL0p5Z3NSQ1J0cFJHUkVuRFlw?=
 =?utf-8?B?VVFvUmRUWmIzNktiR2h0QzllaVEwTU5DZU0rRExQcXp2M1l1QTE1ZnFPM0ps?=
 =?utf-8?B?SHBtU0pQS2JrUzFOU2dtOUthcXJJaFhXaU5mRTZ6WnhMVzFSVGZ0MmRkS0dS?=
 =?utf-8?B?VnlKaXdkc25NdGlJdTBrREZJcmdqY2gxN0djZlhHK21FZ3c3MjNkallud0R3?=
 =?utf-8?B?dC9NMlZrRmprQXlSRUFxNWJFTG5oTTc4d2xqNGJsR1ZIL0JpL293SHZQZzk1?=
 =?utf-8?B?MStpL0p1QUJmL0c5ZkExS3UxZk8rYTU2U1FIb0NEZWF3MW53TmJ4UVRvZzZP?=
 =?utf-8?B?WksvSmxlOGZJTmhnMXJNOUYycUlYY0g1VVgwY3RGL2syM2FwdURrUmZMSnVT?=
 =?utf-8?B?U3NHSG5paCtZTmUrcE04Wm90ODNBeWJYV2crWk8vd1BqZDNtR2w2MmZ6aC9L?=
 =?utf-8?B?Z2lzMFQweml2a3Z5cjdnMjI0YUpucUZpUm5nRyswNVA0RFcyZCs0MDEzNjM3?=
 =?utf-8?B?YWU4WlArR1lLa2ZoeCsrWkhocSs5dEZhcFJXUXZpMzZYTW1HRENSbWN3eEx0?=
 =?utf-8?B?amxOYzhHWS9hVVAvVjNLR0J3ZHhJMGtWREt1V09OdDN3SHN0NVMrNXl0MFpB?=
 =?utf-8?B?UGZNditjc1FGbGN0S05mY3dUdzh0N0hGMFFMZ0FxdHd6NGNPeVYwNHkvMDZO?=
 =?utf-8?B?QzgxSkE1UzkvU3ZIaEs4OW0vMGROakZ0dGFnQjBsSnFyVmg2enl6Qm5VZ2tD?=
 =?utf-8?B?TjBZM0VlSWlWcjZoZGNrdmJBTGZja3V3bjk0T09UZ3lMV0kzSHoyRExIeVh1?=
 =?utf-8?B?NmlDY0tiUmN4NmgxNWJGb1Y2bXZnUi9hbnZWRU91bGFmcWNoa0gzUzN5M1dz?=
 =?utf-8?B?aGgyMVNXZWUwREZCTjBRTnR5ODhUQStHN0FnRU00MmhueVlraHRNK21jZ1lU?=
 =?utf-8?B?c1MxeGxNMkJQSlRZK2d3UktHemdrL2ZHbHlSbTZQdURobWpQLzMzMi85MEtI?=
 =?utf-8?B?ZzZOdlNpTmltWnlybTB5YTI3Y1g2MkZJU3dTSVpHR291Z3hEblB4cDZiWjhC?=
 =?utf-8?B?OTN6d3lRRnRMSG80aVZ4YS9wN1B1M20zOWp5d2RHc0Y0QXVDazgwblcvQWVm?=
 =?utf-8?B?TG53LzhLUllmdGQrRFFJcCtTMnhZOVFuUTNGRmt6Q2dTUzRnVlN1ZVNDTGVB?=
 =?utf-8?B?TWxlY3hsU1RKYjhkVi9lRGU2K0Q2Vk5xR0hVSVJrdXRsZloyRlZUVEw5WTBE?=
 =?utf-8?B?Zm1rbFh6VHNtWHNlQ09GZ3RiaEYrdDlTU1pic3FHUnV5TnEwZ21tZk1pM2Vh?=
 =?utf-8?B?RVQ5YmdXYmpydGdKdTh2dHdFNTF5cG1CUGZQSnB3UkRWS3hZK05Id3E4MmI0?=
 =?utf-8?B?SFBUU0ZKbEYzTkRIK213U3VacUJTaGFCM24rdkp6bm1DdWxUWm5RczgzeWha?=
 =?utf-8?B?MDFycThGVWk2dFlIeVNRRWxLTlBxbGcxdjQ2MjRUTDFFdDNmelRFREpkSmw0?=
 =?utf-8?B?TjdIQ1NacW11R281MnpGTnI5ZVRyanNSMWI0QXZsaWJuenJaQ1VZa0JjN0pl?=
 =?utf-8?B?STY5bXNjeVFPK3NHaVYxblI3bHlDaE9xNklZTm5jTFJOK0FWU3RnOHRYaGhx?=
 =?utf-8?B?ZEpJQ3pyZXNsb3ZMU05DME9GbklFZjVNempYOU9HVk8rVE85WVppRGFodVpr?=
 =?utf-8?B?RWpuVitNd3VJVTNKdnd4OHd5R282OGlSSHdyVk85My9OMHJSeHhkRU5pdTJh?=
 =?utf-8?B?MjNrV0ZpTmttNEh1RGlsRGpZSGd0ejFva1RuclkrRUJ0bDQ1dXFSRGlLdUdm?=
 =?utf-8?B?RlphL3hSYkZ3Tm5sWEN4Zz09?=
Content-ID: <815E924022855C46A7C954CF993055FC@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d008bd-9815-4793-f470-08d90ea12c0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2021 02:06:03.9985 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qvXV0ihACWIB3m46CR9IYsJYIXGFx5SRy6t3DieKB0OofTbTMtmuQb+/8V0TN81m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4844
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmV2aWV3ZWQtYnk6IE9hayBaZW5nIDxPYWsuWmVuZ0BhbWQuY29tPg0KDQpSZWdhcmRzLA0KT2Fr
IA0KDQogDQoNCu+7v09uIDIwMjEtMDUtMDMsIDM6NDkgUE0sICJhbWQtZ2Z4IG9uIGJlaGFsZiBv
ZiBKb25hdGhhbiBLaW0iIDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIG9u
IGJlaGFsZiBvZiBKb25hdGhhbi5LaW1AYW1kLmNvbT4gd3JvdGU6DQoNCiAgICBUbyBhY2NvdW50
IGZvciB2YXJpb3VzIFBDSWUgYW5kIHhHTUkgc2V0dXBzLCBjaGVjayB0aGUgbm8gYXRvbWljcyBz
ZXR0aW5ncw0KICAgIGZvciBhIGRldmljZSBpbiByZWxhdGlvbiB0byBldmVyeSBkaXJlY3QgcGVl
ci4NCg0KICAgIHYyOiBhcHBseSBzdWdnZXN0ZWQgY2xlYW4gdXBzIGluIG1haW4gbG9vcC4NCg0K
ICAgIFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIEtpbSA8am9uYXRoYW4ua2ltQGFtZC5jb20+DQog
ICAgLS0tDQogICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jIHwg
NjEgKysrKysrKysrKysrKystLS0tLS0tLS0NCiAgICAgMSBmaWxlIGNoYW5nZWQsIDM3IGluc2Vy
dGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKQ0KDQogICAgZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX3RvcG9sb2d5LmMNCiAgICBpbmRleCAzMDQzMGFlZmNmYzcuLmZiNGY3MThhMTE0OCAx
MDA2NDQNCiAgICAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3ku
Yw0KICAgICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jDQog
ICAgQEAgLTExOTIsNDcgKzExOTIsNjAgQEAgc3RhdGljIHZvaWQga2ZkX2ZpbGxfbWVtX2Nsa19t
YXhfaW5mbyhzdHJ1Y3Qga2ZkX3RvcG9sb2d5X2RldmljZSAqZGV2KQ0KICAgICAJCW1lbS0+bWVt
X2Nsa19tYXggPSBsb2NhbF9tZW1faW5mby5tZW1fY2xrX21heDsNCiAgICAgfQ0KDQogICAgLXN0
YXRpYyB2b2lkIGtmZF9maWxsX2lvbGlua19ub25fY3JhdF9pbmZvKHN0cnVjdCBrZmRfdG9wb2xv
Z3lfZGV2aWNlICpkZXYpDQogICAgK3N0YXRpYyB2b2lkIGtmZF9zZXRfaW9saW5rX25vX2F0b21p
Y3Moc3RydWN0IGtmZF90b3BvbG9neV9kZXZpY2UgKmRldiwNCiAgICArCQkJCQlzdHJ1Y3Qga2Zk
X3RvcG9sb2d5X2RldmljZSAqdGFyZ2V0X2dwdV9kZXYsDQogICAgKwkJCQkJc3RydWN0IGtmZF9p
b2xpbmtfcHJvcGVydGllcyAqbGluaykNCiAgICAgew0KICAgIC0Jc3RydWN0IGtmZF9pb2xpbmtf
cHJvcGVydGllcyAqbGluaywgKmNwdV9saW5rOw0KICAgIC0Jc3RydWN0IGtmZF90b3BvbG9neV9k
ZXZpY2UgKmNwdV9kZXY7DQogICAgLQlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldjsNCiAgICAt
CXVpbnQzMl90IGNhcDsNCiAgICAtCXVpbnQzMl90IGNwdV9mbGFnID0gQ1JBVF9JT0xJTktfRkxB
R1NfRU5BQkxFRDsNCiAgICAtCXVpbnQzMl90IGZsYWcgPSBDUkFUX0lPTElOS19GTEFHU19FTkFC
TEVEOw0KICAgIC0NCiAgICAtCWlmICghZGV2IHx8ICFkZXYtPmdwdSkNCiAgICArCS8qIHhnbWkg
YWx3YXlzIHN1cHBvcnRzIGF0b21pY3MgYmV0d2VlbiBsaW5rcy4gKi8NCiAgICArCWlmIChsaW5r
LT5pb2xpbmtfdHlwZSA9PSBDUkFUX0lPTElOS19UWVBFX1hHTUkpDQogICAgIAkJcmV0dXJuOw0K
DQogICAgLQlhZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopKGRldi0+Z3B1LT5rZ2QpOw0K
ICAgIC0JaWYgKCFhZGV2LT5nbWMueGdtaS5jb25uZWN0ZWRfdG9fY3B1KSB7DQogICAgLQkJcGNp
ZV9jYXBhYmlsaXR5X3JlYWRfZHdvcmQoZGV2LT5ncHUtPnBkZXYsDQogICAgKwkvKiBjaGVjayBw
Y2llIHN1cHBvcnQgdG8gc2V0IGNwdShkZXYpIGZsYWdzIGZvciB0YXJnZXRfZ3B1X2RldiBsaW5r
LiAqLw0KICAgICsJaWYgKHRhcmdldF9ncHVfZGV2KSB7DQogICAgKwkJdWludDMyX3QgY2FwOw0K
ICAgICsNCiAgICArCQlwY2llX2NhcGFiaWxpdHlfcmVhZF9kd29yZCh0YXJnZXRfZ3B1X2Rldi0+
Z3B1LT5wZGV2LA0KICAgICAJCQkJUENJX0VYUF9ERVZDQVAyLCAmY2FwKTsNCg0KICAgICAJCWlm
ICghKGNhcCAmIChQQ0lfRVhQX0RFVkNBUDJfQVRPTUlDX0NPTVAzMiB8DQogICAgIAkJCSAgICAg
UENJX0VYUF9ERVZDQVAyX0FUT01JQ19DT01QNjQpKSkNCiAgICAtCQkJY3B1X2ZsYWcgfD0gQ1JB
VF9JT0xJTktfRkxBR1NfTk9fQVRPTUlDU18zMl9CSVQgfA0KICAgICsJCQlsaW5rLT5mbGFncyB8
PSBDUkFUX0lPTElOS19GTEFHU19OT19BVE9NSUNTXzMyX0JJVCB8DQogICAgIAkJCQlDUkFUX0lP
TElOS19GTEFHU19OT19BVE9NSUNTXzY0X0JJVDsNCiAgICAtCX0NCiAgICAtDQogICAgLQlpZiAo
IWFkZXYtPmdtYy54Z21pLm51bV9waHlzaWNhbF9ub2Rlcykgew0KICAgICsJLyogc2V0IGdwdSAo
ZGV2KSBmbGFncy4gKi8NCiAgICArCX0gZWxzZSB7DQogICAgIAkJaWYgKCFkZXYtPmdwdS0+cGNp
X2F0b21pY19yZXF1ZXN0ZWQgfHwNCiAgICAgCQkJCWRldi0+Z3B1LT5kZXZpY2VfaW5mby0+YXNp
Y19mYW1pbHkgPT0NCiAgICAgCQkJCQkJCUNISVBfSEFXQUlJKQ0KICAgIC0JCQlmbGFnIHw9IENS
QVRfSU9MSU5LX0ZMQUdTX05PX0FUT01JQ1NfMzJfQklUIHwNCiAgICArCQkJbGluay0+ZmxhZ3Mg
fD0gQ1JBVF9JT0xJTktfRkxBR1NfTk9fQVRPTUlDU18zMl9CSVQgfA0KICAgICAJCQkJQ1JBVF9J
T0xJTktfRkxBR1NfTk9fQVRPTUlDU182NF9CSVQ7DQogICAgIAl9DQogICAgK30NCiAgICArDQog
ICAgK3N0YXRpYyB2b2lkIGtmZF9maWxsX2lvbGlua19ub25fY3JhdF9pbmZvKHN0cnVjdCBrZmRf
dG9wb2xvZ3lfZGV2aWNlICpkZXYpDQogICAgK3sNCiAgICArCXN0cnVjdCBrZmRfaW9saW5rX3By
b3BlcnRpZXMgKmxpbmssICppbmJvdW5kX2xpbms7DQogICAgKwlzdHJ1Y3Qga2ZkX3RvcG9sb2d5
X2RldmljZSAqcGVlcl9kZXY7DQogICAgKw0KICAgICsJaWYgKCFkZXYgfHwgIWRldi0+Z3B1KQ0K
ICAgICsJCXJldHVybjsNCg0KICAgICAJLyogR1BVIG9ubHkgY3JlYXRlcyBkaXJlY3QgbGlua3Mg
c28gYXBwbHkgZmxhZ3Mgc2V0dGluZyB0byBhbGwgKi8NCiAgICAgCWxpc3RfZm9yX2VhY2hfZW50
cnkobGluaywgJmRldi0+aW9fbGlua19wcm9wcywgbGlzdCkgew0KICAgIC0JCWxpbmstPmZsYWdz
ID0gZmxhZzsNCiAgICAtCQljcHVfZGV2ID0ga2ZkX3RvcG9sb2d5X2RldmljZV9ieV9wcm94aW1p
dHlfZG9tYWluKA0KICAgICsJCWxpbmstPmZsYWdzID0gQ1JBVF9JT0xJTktfRkxBR1NfRU5BQkxF
RDsNCiAgICArCQlrZmRfc2V0X2lvbGlua19ub19hdG9taWNzKGRldiwgTlVMTCwgbGluayk7DQog
ICAgKwkJcGVlcl9kZXYgPSBrZmRfdG9wb2xvZ3lfZGV2aWNlX2J5X3Byb3hpbWl0eV9kb21haW4o
DQogICAgIAkJCQlsaW5rLT5ub2RlX3RvKTsNCiAgICAtCQlpZiAoY3B1X2Rldikgew0KICAgIC0J
CQlsaXN0X2Zvcl9lYWNoX2VudHJ5KGNwdV9saW5rLA0KICAgIC0JCQkJCSAgICAmY3B1X2Rldi0+
aW9fbGlua19wcm9wcywgbGlzdCkNCiAgICAtCQkJCWlmIChjcHVfbGluay0+bm9kZV90byA9PSBs
aW5rLT5ub2RlX2Zyb20pDQogICAgLQkJCQkJY3B1X2xpbmstPmZsYWdzID0gY3B1X2ZsYWc7DQog
ICAgKw0KICAgICsJCWlmICghcGVlcl9kZXYpDQogICAgKwkJCWNvbnRpbnVlOw0KICAgICsNCiAg
ICArCQlsaXN0X2Zvcl9lYWNoX2VudHJ5KGluYm91bmRfbGluaywgJnBlZXJfZGV2LT5pb19saW5r
X3Byb3BzLA0KICAgICsJCQkJCQkJCQlsaXN0KSB7DQogICAgKwkJCWlmIChpbmJvdW5kX2xpbmst
Pm5vZGVfdG8gIT0gbGluay0+bm9kZV9mcm9tKQ0KICAgICsJCQkJY29udGludWU7DQogICAgKw0K
ICAgICsJCQlpbmJvdW5kX2xpbmstPmZsYWdzID0gQ1JBVF9JT0xJTktfRkxBR1NfRU5BQkxFRDsN
CiAgICArCQkJa2ZkX3NldF9pb2xpbmtfbm9fYXRvbWljcyhwZWVyX2RldiwgZGV2LCBpbmJvdW5k
X2xpbmspOw0KICAgICAJCX0NCiAgICAgCX0NCiAgICAgfQ0KICAgIC0tIA0KICAgIDIuMTcuMQ0K
DQogICAgX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCiAg
ICBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KICAgIGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQogICAgaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJs
PWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZv
JTJGYW1kLWdmeCZhbXA7ZGF0YT0wNCU3QzAxJTdDb2FrLnplbmclNDBhbWQuY29tJTdDYjAzNGZk
N2JkNWQ3NDlhOTdjZGUwOGQ5MGU2YzliMWYlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRl
MTgzZCU3QzAlN0MwJTdDNjM3NTU2NjgxOTE2NzAyNzgzJTdDVW5rbm93biU3Q1RXRnBiR1pzYjNk
OGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pY
VkNJNk1uMCUzRCU3QzEwMDAmYW1wO3NkYXRhPWtaMTluZzVMUFoxM3FQT3dvcWNucmFEOWxKSG5p
RVd5NDJwUlRXRGY0b28lM0QmYW1wO3Jlc2VydmVkPTANCg0KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
