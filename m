Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7070BC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 01:40:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2CAC10E86A;
	Tue, 14 Dec 2021 01:40:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43B3410E86A
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 01:40:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzXfM6a5FiIBjsggIfzQI3Ic0mBG51uxKq92NdjljqRZrKpQSft4k6I5ffxEu48YgPky1xl5MYdsnKN0jdgEWDEHmmHpNgVuTRCUfLyl3ZK4FDylTJtfyJR+zo3++6w66cXNA19JPsBS4YazJVJF0nD6oMK3J8kmhDwwfaKf6WqRTUGNi9PN1dFU5WKjrPCE1OBzUOXUN+OPeO4SyE73s03gUA+SxUHupnpGmg+VdvaQSE9CUkvSCO3amlMAIWNAusz03OVlVnikMCI15f0s6EDfvCBMP4e6KXzIU3gR7MbfSauD+wg2GlohFvhy9yzwZO1eHbbaM6OJNgpn1uzGvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abCeVrEONHJiqh1fJoHN7IJAJ1I+u3uTN975uXmganY=;
 b=c8UWR5fcJtFA+XLE0KBYXpzBpcYeM2V4Nm8+bGNHssjZpL++9HBa58aQC9ZtGkakHxGe4sqo4dqziJzAYBK5c/LmU7Ucsg9XD/BxAEU4RaJE25ozRk4kPx/5GUTkLmMGFtn19fA01t3byZDO7w6hndhnTM2GAGIXZWD9XLJO99ZlsMLKCUO1WNCEWz7I9a0JJrjtF5bWj+2Pn2HWFb9am/VWx/66SqH6OSdqaftEKWPDva7RQisN8z7AJsMAT4FrVPkS8KjE3bdqoBuz79cC3vmovj+pZihwTpc6qRcDGvPWZCIbIXHfdnMYzNgVo9bhv/38w+yeCNkAlDT1s5k4rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abCeVrEONHJiqh1fJoHN7IJAJ1I+u3uTN975uXmganY=;
 b=cbp20NrxVm23HHTZYsRKKhUyYO+sGfsLRTHdfPHoU6t7u/b2I0x7PrE14uI3zehkOvK1O1KesKpvaK7NWr5p2+1AhHAJhgxmZGMeh6pQ02kNFdz+LaJ9L4ptovzg9xNDSSc7Y4yokEPwny4yLT8Omv0vkfbLAtn7D84vwpZMEEk=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB4631.namprd12.prod.outlook.com (2603:10b6:a03:10d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Tue, 14 Dec
 2021 01:40:18 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::f97d:23d2:78a:2beb]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::f97d:23d2:78a:2beb%6]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 01:40:18 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [v3] drm/amdgpu: reset asic after system-wide suspend aborted (v3)
Thread-Topic: [v3] drm/amdgpu: reset asic after system-wide suspend aborted
 (v3)
Thread-Index: AQHX8GshrTdnD7L5x0CjbByYzDRyAKwxM9hw
Date: Tue, 14 Dec 2021 01:40:18 +0000
Message-ID: <BYAPR12MB323896A08303C2ED3E2821EDFB759@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <1637819291-4159-1-git-send-email-Prike.Liang@amd.com>
 <ff5cbfd0-f5b7-d03f-82ab-dad0b9c50a49@amd.com>
In-Reply-To: <ff5cbfd0-f5b7-d03f-82ab-dad0b9c50a49@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=00d2b149-a983-497d-8060-f3625028e0c0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-14T01:31:48Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4969c153-3b10-4dfc-81a2-08d9bea2af71
x-ms-traffictypediagnostic: BYAPR12MB4631:EE_
x-microsoft-antispam-prvs: <BYAPR12MB463118D31BDF9A8479269BBDFB759@BYAPR12MB4631.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DFEj/NLvNHi0AIVYcaS1Y6w0OFd/Kg8i0QxrU0arDdbEvo8zNK9OpHMjVgE38DV9Z5fEKu8qdDmI0fXzpI5BVmR0OX0UwjAPKWdqWxA5GuiwzV9EGkl1MkXDeGDWgMOM/L4iCT/ML7DgWq/rzCx38jA2dkIC1YG+DfuZAWptQ9j/FIGiDSOU5bFcaQqE0oNz5IItIeNvegwU+o3z87MqAHJqtZKegGKbEYE0s6LJCK1UP21lbjYJz4GdcHT5kDGb4Vn8xbkLBibyIqHJIzRCM3uAbMu7/xQ6AYJKeGk3DmenBqLW9D+4Um11p5AmsRJ9mNefS2eeJBD2YNqJpguj71eXau6b4PLqd3JKnPtSKHzdyd4XSdu/HaiCQUhKwzTFhyMEDzOvVtwNdPJz+0K1VHDbGHRn/5FFvUZoQrBYmlBar5nD6oplHK/WHD2M1zxJkTt9qhJU9O5kVfclpxRxCusRcH3OJMYjE/knzcr8IDTZ82cgZYUJ3Y6ingZqDy1BO02p9067/xa0DCbDkVrBeUjRhPN0qUyVJ+eTrJEiWixSTyg6LtFIYgeprJJ5eBFr40FMZL1Ggf5TRN1/p4e3O8P3UebGkjvDdGBziTZLVgx32JcynRizij7Zswn1OV2jQguLs0XBUdqOjdCz7jUSooojd+FFy//1E0fCghTc5hMwTcQvN1FqglWRJHB6Dfm0LAKHdt4LC+RPpAGHAVmiYvqEydLo/X0nm0vaQJCS+smwIItLovh40vIebQiNqUQ6PYvJ7OtRBk1UxgQHNFa3rEak3nJF2CNLZH+S0gUI+kI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(66476007)(66556008)(64756008)(53546011)(83380400001)(7696005)(4326008)(66946007)(55016003)(86362001)(966005)(66446008)(508600001)(8676002)(38100700002)(52536014)(122000001)(8936002)(54906003)(5660300002)(110136005)(316002)(9686003)(71200400001)(2906002)(15650500001)(186003)(45080400002)(33656002)(76116006)(38070700005)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmtFWHhFUnA2Mk5lK0F0V28zYW5CQlExNWR0UEF6dWZIK0F3NkJ3WHNlc2M0?=
 =?utf-8?B?eHArR2RFM3F6dlorekNpNy9rWTRYT0VhWjByYlA5bHMva2Yyc3J1bmZzdXRI?=
 =?utf-8?B?SnYybHZSL2FVdjluTU9JQzhZL2ZnL1hOYmF6dldocFBlODlOcDkrZW05amcx?=
 =?utf-8?B?RkJCd1NkU2lQSENxNG8vL3ZleUlWNUNRZ2hpNk84THQ1Zm4zeDJkNFg5bU10?=
 =?utf-8?B?NHROcVR4eE5GV1RaOVRESTgrT05MOU00a2d2dDJXb2FGOWRIbHhKY3dwdkVw?=
 =?utf-8?B?cmpMS1NCTW5zM0w3SjVkeEZWR0o5VjdwOWpqcDBJZzBaTno0USt4R3dlbUZn?=
 =?utf-8?B?cWIvQzlWYzhDTFQwNGpTdlFOS1crVk1menBRNll1bGF6SlZyYTlMc2E4anZy?=
 =?utf-8?B?Y09zcTVqa1hnQWZQenc3RmNXY21XQXVHS0RhUHNVcm9PYXpodTI3aVUwUk5n?=
 =?utf-8?B?V0ZmQjU0L1JMOUZKak5RdGkyb1lTbkVsejJ3bE5UeC8zVFAxVVlmYTJ2Z29S?=
 =?utf-8?B?OHZFbEZwamROaUg5U3dOSjJXeVpCSURYczBzQmpXY3FyY255cjF4a0RGYitO?=
 =?utf-8?B?aTd1MWp4bWlLbHdlNU5BYWQ4VG1wbmtNY0w4SXVSVWVDL2lhVkZpbXA0Zm14?=
 =?utf-8?B?MmdIUmt3RVd0OTBwSjA5ZUhXLzZJQVpxYS94VWJ2Uy81UmRBb3psSmltbHdW?=
 =?utf-8?B?bnpUR1pRY1NtMXJuM2lpS2I1a3REeWNxY2YwNW1rR0Myek5wVmxpMmk3RHBV?=
 =?utf-8?B?MWg3c2JDRGIzUWd4aE43NU96U0o2dm5OeFNnUzZPVFQ1eDlpa1JTTGF3VE1n?=
 =?utf-8?B?QmdYdExJSE5oMWp5UnN4WGJ5bkt3T0V2SXBRNmlPaENrRXJLWXFsaUtyK3k2?=
 =?utf-8?B?WEZIVk1MUGFXK3hWSU1RSWNhYTBqc1lMVUNodDJBRFEyVnZEYlQxMGZ3b2FZ?=
 =?utf-8?B?UHh1RnU3ME94SjJKaFQxZkxFb2d3ZkhIUVhaMDRqKzFtMnBHa0xQaTBGcS9m?=
 =?utf-8?B?MUJmeGZyemtDbFFndDVtbytRdU9jdUFRcFIwMUoxRFNoc0Rac0tNbXlJV2RM?=
 =?utf-8?B?K21wUFdPMEszQURqUzdzQzlWRkhuMStmMTJ0YURUT2taTEFVaHhVRlEzVGQv?=
 =?utf-8?B?OFVJMXE3aWdWWFIxS29RN1duY3VBK2ZJYytUc25hYS8xUHl5bzhrdDcxM3Nr?=
 =?utf-8?B?L2ppbmhLblNnaWlJNmpJZkoxNG5KUTBEWmV5SGtjd3dYNldyaDRvbEt3S2pv?=
 =?utf-8?B?azg3ZjcvZ1FZM3NhKzQ4bkQ4Mk5ZQ1R5Q1VQZVdHQnRMM0VQS0NKbXFjdmIx?=
 =?utf-8?B?Tk52aGJCeFhybkVobVRkWHBRb0lNODJMZERuOTJ5YnlwaUtDUkNyUHdnZnY1?=
 =?utf-8?B?Q0tiaXdkSUFvMk1TdzJGWXpIN3hBWVNpc0dlNHhVeHNwajJ0R3pwZE5RQ0tV?=
 =?utf-8?B?dHpXbXJuQlgwZTVuMTRhWGxON3I2d01kejJLYjVpZHpqenQ5WmJRMUxKMTdT?=
 =?utf-8?B?blNaS3pmU3haZTBidklqNWt2ZkhXNHRZcEZHYUJjTnlKSURNMXBKMUxEbStK?=
 =?utf-8?B?b2kzbWVmY1dOT002ckhuZUpOZnNZRGdRQjRCeWMwd3VPTzV6dC9PMGNRa01i?=
 =?utf-8?B?OUI1SmVwOEIrOERtMDZLblhzVUN3cWIySkFibVZac2p4TFFaUlljd0JtbWJz?=
 =?utf-8?B?TS9vNG0rOW0xeHFMQTAySi80R1ZlRlJCZnJBWDdZc2RjbkF2VmVyakQxRERH?=
 =?utf-8?B?ZWw5aU9aVXNMWlh0VDQwV1pHb1c1ZHhWUzJwRGtjdEVoY08wNkZLUTBNZjkz?=
 =?utf-8?B?OWxWL1dPRzYyWU1ITTBhajk5Ty9VRmgvU2V4TG1xbmUxdWgzRG92bjFuU0ti?=
 =?utf-8?B?YlFYdC9hbksyYkh4SmpTOENBU1BZTzV3Z2N1RVBuaHVYM015SDFWbmplcG9t?=
 =?utf-8?B?cFJ0MHM2SCtaZjdpTkVLLzllQWhKWUFUSFUxSlBlK28rZldXeDN1bitYajBs?=
 =?utf-8?B?c0g5aFI3S1FENkUzVFhDeURMdFR3TDJkYUo2bTlYdHpXMTdEM0JNdHZCeDEy?=
 =?utf-8?B?NjlzeDVGM3JEbHdvQXZBVUxoWnZiSG9RMkZYY0M3MGZCcnVOZXc5cWgwditX?=
 =?utf-8?Q?Up3I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4969c153-3b10-4dfc-81a2-08d9bea2af71
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 01:40:18.5797 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UE0Qthc2QprHcaS5EI8leGNJqu9pb2wRAt8R+ljfF0dxur5+JQed5V3A5cgaC6AE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4631
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW1vbmNp
ZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXks
IERlY2VtYmVyIDE0LCAyMDIxIDU6NDggQU0NCj4gVG86IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlh
bmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBEZXVjaGVy
LCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBMYXphciwgTGlqbw0KPiA8
TGlqby5MYXphckBhbWQuY29tPjsgSHVhbmcsIFJheSA8UmF5Lkh1YW5nQGFtZC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbdjNdIGRybS9hbWRncHU6IHJlc2V0IGFzaWMgYWZ0ZXIgc3lzdGVtLXdpZGUg
c3VzcGVuZCBhYm9ydGVkDQo+ICh2MykNCj4NCj4gT24gMTEvMjQvMjAyMSAyMzo0OCwgUHJpa2Ug
TGlhbmcgd3JvdGU6DQo+ID4gRG8gQVNJQyByZXNldCBhdCB0aGUgbW9tZW50IFN4IHN1c3BlbmQg
YWJvcnRlZCBiZWhpbmQgb2YgYW1kZ3B1DQo+ID4gc3VzcGVuZCB0byBrZWVwIEFNREdQVSBpbiBh
IGNsZWFuIHJlc2V0IHN0YXRlIGFuZCB0aGF0IGNhbiBhdm9pZA0KPiA+IHJlLWluaXRpYWxpemUg
ZGV2aWNlIGltcHJvcGVybHkgZXJyb3IuIEN1cnJlbnRseSx3ZSBqdXN0IGFsd2F5cyBkbw0KPiA+
IGFzaWMgcmVzZXQgaW4gdGhlIGFtZGdwdSByZXN1bWUgdW50aWwgc29ydCBvdXQgdGhlIFBNIGFi
b3J0IGNhc2UuDQo+ID4NCj4gPiB2MjogUmVtb3ZlIGluY29tcGxldGUgUE0gYWJvcnQgZmxhZyBh
bmQgYWRkIEdQVSBoaXZlIGNhc2UgY2hlY2sgZm9yDQo+ID4gR1BVIHJlc2V0Lg0KPiA+DQo+ID4g
djM6IFNvbWUgZEdQVSByZXNldCBtZXRob2Qgbm90IHN1cHBvcnQgYXQgdGhlIGVhcmx5IHJlc3Vt
ZSB0aW1lIGFuZA0KPiA+IHRlbXByb3Jhcnkgc2tpcCB0aGUgZEdQVSBjYXNlLg0KPg0KPiBGWUkg
dG8geW91IHRoYXQgdGhpcyB3YXMgdGVzdGVkIG9uIGFuIGlzc3VlIHdpdGggUzMgZXhpdCB0byBz
aG93IHN1Y2Nlc3MgdGhhdA0KPiB5b3Ugd2lsbCB3YW50IHRvIGluY2x1ZGUgaW4gYSBGaXhlcyB0
YWcgZm9yIHY0IHdoZW4geW91IGNoYW5nZSBpdCB0byBqdXN0IHJ1bg0KPiBmb3IgUzMgcGF0aCwg
bm90IFMwaTMgcGF0aC4NCj4NCj4gaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9h
bWQvLS9pc3N1ZXMvMTgyMg0KPg0KWWVhaCB0aGlzIHBhdGNoIG5lZWQgZXhjbHVkZSBmb3IgUzBp
MyBjYXNlLCBpbiB0aGUgUzBpMyBlbnRyeSB3ZSBza2lwIHNvbWUgYmxvY2tzIHN1c3BlbmQgc28g
d2UgbWF5IG5vdCByZXN1bWUgc3VjY2Vzc2Z1bGx5IGFmdGVyIGRvIEdQVSByZXNldCBmb3IgUzBp
MyBjYXNlLiBGdXJ0aGVybW9yZSwgZm9yIFMzIGFib3J0IHJlc3VtZSBpc3N1ZSBhbHNvIGNhbiBm
aW5kIG9uIHRoZSBkR1BVIHNlcmllcyBhbmQgQWxleCdzIGZvbGxvd2luZyBwYXRjaCBtYXkgY2Fu
IGhhbmRsZSB0aGlzIGdlbmVyaWMgaXNzdWUgYmV0dGVyIHdoZW4gd2UgaWdub3JlIHRoZSBQTSBh
Ym9ydCBjaGVjay4NCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL0RNNlBSMTJNQjI2MTk1
RjhFMDk5NDA3QjRCNjk2NkZFQkU0OTk5QERNNlBSMTJNQjI2MTkubmFtcHJkMTIucHJvZC5vdXRs
b29rLmNvbS9ULw0KDQpUaGFua3MsDQpQcmlrZQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUHJp
a2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCA4ICsrKysrKysrDQo+ID4gICAxIGZp
bGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPiBpbmRleCA3ZDQxMTVkLi5mNmUxYTZh
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2Uu
Yw0KPiA+IEBAIC0zOTgzLDYgKzM5ODMsMTQgQEAgaW50IGFtZGdwdV9kZXZpY2VfcmVzdW1lKHN0
cnVjdCBkcm1fZGV2aWNlDQo+ICpkZXYsIGJvb2wgZmJjb24pDQo+ID4gICAgIGlmIChhZGV2LT5p
bl9zMGl4KQ0KPiA+ICAgICAgICAgICAgIGFtZGdwdV9nZnhfc3RhdGVfY2hhbmdlX3NldChhZGV2
LA0KPiBzR3B1Q2hhbmdlU3RhdGVfRDBFbnRyeSk7DQo+ID4NCj4gPiArICAgLypUT0RPOiBJbiBv
cmRlciB0byBub3QgbGV0IGFsbC1hbHdheXMgYXNpYyByZXNldCBhZmZlY3QgcmVzdW1lDQo+IGxh
dGVuY3kNCj4gPiArICAgICogbmVlZCBzb3J0IG91dCB0aGUgY2FzZSB3aGljaCByZWFsbHkgbmVl
ZCBhc2ljIHJlc2V0IGluIHRoZSByZXN1bWUNCj4gcHJvY2Vzcy4NCj4gPiArICAgICogQXMgdG8g
dGhlIGtub3duIGlzc3VlIG9uIHRoZSBzeXN0ZW0gc3VzcGVuZCBhYm9ydCBiZWhpbmQgdGhlDQo+
IEFNREdQVSBzdXNwZW5kLA0KPiA+ICsgICAgKiBtYXkgY2FuIHNvcnQgdGhpcyBjYXNlIGJ5IGNo
ZWNraW5nIHN0cnVjdCBzdXNwZW5kX3N0YXRzIHdoaWNoDQo+IG5lZWQgZXhwb3J0ZWQNCj4gPiAr
ICAgICogZmlyc3RseS4NCj4gPiArICAgICovDQo+ID4gKyAgIGlmIChhZGV2LT5mbGFncyAmIEFN
RF9JU19BUFUpDQo+ID4gKyAgICAgICAgICAgYW1kZ3B1X2FzaWNfcmVzZXQoYWRldik7DQo+ID4g
ICAgIC8qIHBvc3QgY2FyZCAqLw0KPiA+ICAgICBpZiAoYW1kZ3B1X2RldmljZV9uZWVkX3Bvc3Qo
YWRldikpIHsNCj4gPiAgICAgICAgICAgICByID0gYW1kZ3B1X2RldmljZV9hc2ljX2luaXQoYWRl
dik7DQo+ID4NCg0K
