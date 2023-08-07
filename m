Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E395FEB64DD
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Aug 2023 08:37:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3A3410E051;
	Mon,  7 Aug 2023 08:37:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 320CF10E051
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Aug 2023 08:37:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwuFTyJ6YvP4XWkakeItkjATM/G9iDIK0dmk9qSk1B9D2EVmsgfVEmqdwLbXfy078RUF89klu6GZcOeRvmlbTlIK8jJYbFyOv5EAWgAolvi6EJFm0uJbr8NUZ20Gtl1uUJsr+EeOOJXakvYwAncG4QfmDV5zDAI0owYKp14z9+bnGxYyZSprZl+M8bUVghvZFv3vDg57pEeU+YQ7qCTLoKbVmFVZgnCp/OKL6/PkeEcbmEvDsGSKlGp0N1ngevcCfbzB2q4qZigZJihx5C3IZooGR3eyGoMmtRhA1fG/Tszocq4mSDdsA8z3VoTuOXhotmptZzAM780vYagk5+SIVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGup40ajg1hB0PZmFcsov0RwvRIbfz64KKF8GKlqQGs=;
 b=KqLtXkpYjvMc7PEBdqWvl1+wVOEtaHvdif4rr0YSRkvWsZSGRXeddwBpKeQa9KADj91O2emLE3I41oUkCyl7o+YagLzBdgDPQ18wLtqJLTwtkM6hVStpqQieKOgis/fWa1ntDK8M31YGdAKqHcnZ8dP+ucuRYW7bdoYH0sEyl2G8w5cFfPf68L2el4ywcphosxcHorX49xMu6SL41/WPkVth+zzpfDDoVEsHNPXt1oz5Wtu2xWQdX+Id++Eg+mnT/fNouB6Bsvypv3PTKG/kHI5nZImrfXoGGAzJwq0/JCf+tdIygzNa5RdgrGRsXGaKJxMJS7rdT68VFRGC22kR1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGup40ajg1hB0PZmFcsov0RwvRIbfz64KKF8GKlqQGs=;
 b=PLPhpEk0KsTL/O7bAT3Cyv6wk+ya2du2WBRqOZ8bDK5tVPU7iBnJ5sNzOBU6/hROfhvVtwHihEdQZSs3Wyb+lG7/IXx/CS4BOz8/JqZXvmzd+YMQVy4bkYk57fpP5ienJxWm7vJVjXRIKZXuexgPYNA1288pJ7vRyYQ8yo+f+b4=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 08:37:05 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225%3]) with mapi id 15.20.6652.022; Mon, 7 Aug 2023
 08:37:05 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix identifier names to function definition
 arguments in atom.h
Thread-Topic: [PATCH] drm/amdgpu: Fix identifier names to function definition
 arguments in atom.h
Thread-Index: AQHZyQjwwXwgX1tXW0OZf9tCff6cHa/egl3Q
Date: Mon, 7 Aug 2023 08:37:04 +0000
Message-ID: <DM5PR12MB24691F99C43C56880C6FD03FF10CA@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230807082639.135375-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230807082639.135375-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=94054d06-1dde-4d8a-8cd0-7ecb6cd01282;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-08-07T08:36:14Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|PH7PR12MB5656:EE_
x-ms-office365-filtering-correlation-id: 57ae1aae-0e8d-4501-8c4a-08db97217a83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ug+gduyc12BedtJzdZwpwcHfHxma1vePbqAJNCgaxvtmIX0Jfus+y5XQ1CijjnspnjVXo0n6rTqiUfsN2nAjP3KTgNUi/hNJNGdivFfJTHNeQZBY5aOCXcTK1ZHc0kVkN52st4otYJnJhit1+sKXKSznVvl360AWmd2tOMm3zTdd+DONNMM9zSFPYe0ypKhSBRyy+xCyK3cHMsH+DQk1mY4/S0DfdtMarbCrOk8oyVZJFk9KfBtIP67Ksow/mToN2nyN3X8TMIL4BaRUHFUbZYRF67wAKerESU8zD8GQy+lDXXPzpS/rx6eLlUVdMdk5ive9Xx0dHjCBvC8IYsO0gdR8KMsMgC7hp/QSj1IXMhvUIupTit39FJXEysL7GeireLFqtvp0mNLiqyDQBxM28SXI116ahvbqn3/zcvA+nW0/5agOXGRUBgsWhohnYfG2S6bON+y+/GlQgokadhvw5uF/lsPmKxV1PyQ5rrXpsK5m9qlWix6ogBHIurWPdUQeXz1lOgvq+R7ki+2MdKF8mgNIr2spdKQ6gERTFoVw5B/poiQFBTLqxx9ZOqHwl9ug1CfhTauowbvDL+GQz7YAlq6BW/kGQScmztO/DlCpaxqoeX3gLEr3RBzRywvutlt1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199021)(186006)(1800799003)(55016003)(9686003)(4326008)(6636002)(316002)(86362001)(478600001)(122000001)(110136005)(38100700002)(76116006)(71200400001)(66946007)(66446008)(64756008)(66556008)(66476007)(33656002)(53546011)(7696005)(6506007)(41300700001)(26005)(52536014)(38070700005)(66574015)(8676002)(8936002)(2906002)(83380400001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFpnQ0M0UHdVemdHMi91c2pnSzhLUS9OM1l2QmxhdURtTE9GMTFwbHdYaXdT?=
 =?utf-8?B?Syt3Qno2L213b1p1UUtkeEVOUThzemVmNWN5RE5ITVRFM24rMnU3TGFtVmRZ?=
 =?utf-8?B?SzNLdnNNQmhOSU5DVzBMdmJuL2IwUG5hQ0pwb1IxeElqU01KUVR4Z3Vyd0ZM?=
 =?utf-8?B?bGpmRzJlVnUvMHBENCtMV3k2NlBvbllxWlJIQ2hlUTBXSFlvN0NLYW9HZHhD?=
 =?utf-8?B?TWFCYzlCUk9Gdy95VG1iSGJpczEvZGV2RVlCczBjLzF0Vm91OVNQajBob2NG?=
 =?utf-8?B?bU5UQzEyeXVaTGY3OFcwc282Tm84RU01SjFybDkyU0ZFalFPWncyY2lQSkRY?=
 =?utf-8?B?UXpaMHF6NElpQ3pFU2QrODlYQXhqWkd2TXBLNVZUcFl3NURNQnBFV1Bxa3Z1?=
 =?utf-8?B?Y2MyY0VzTFdnMEI3Yjg3aEtIU1h3Vm1yZDVMeTNIdXBnd0s4L1FZaHVTQzF1?=
 =?utf-8?B?ZmtJTExxZ013Ni9BR2NocktYdkYzYkZ5Lyt3T2ZQZXlkWWJNdjBaNTV1TGlT?=
 =?utf-8?B?NFdwNXJlQldzQmMydmtVUktsMHdiQ2xvNHVxOTZvVU1XQjZuamxaZHorS3kr?=
 =?utf-8?B?U2RaMHlORk9OUitLbCtXelVLYU42Z3ZaMzZRbWtuNVdveXppQnVVRVVsQW9m?=
 =?utf-8?B?QUU2Z0dKeERSQ1l5OU5iM0tXd1RXdFNEb0xEUFdNUTlBakpsbW55RGwvRm9D?=
 =?utf-8?B?amt5eTJhMlozc2NBdHh0bGxtSjRlWldVSHJaQ0xVbEdvb3RENDNjTFJaS001?=
 =?utf-8?B?NG9tUjVGdXhNT0t3S0E3OHBqREZFVkxyMm5QWVU1L2psbzF1VW1GYUg5ZnFx?=
 =?utf-8?B?V0dnVGRmblJvUU9wMmhyYTdkRG96RmMrNG52RGU5LytQQW4raE1JRlNOMWdB?=
 =?utf-8?B?R2ZiZ0JGeXZJaEgwWk44eUVDcmZXQ24zNHR5UFBGazlWL01HWFh6T0w5ZGcr?=
 =?utf-8?B?TmhVaXBwem02dmNDZ1hnTkZQcFRnR0VqN0dwdjkvL1NaMGZoMVNJZXIyY2li?=
 =?utf-8?B?U2RyWlA2bzU2bnluKzZWalZhRjFJTFJXMW9BYUJZZVFwejFFdTExTGRKRHV2?=
 =?utf-8?B?YVpOY05ZMlg2aGJ4VnhXVkVUNlhGZUhkR3hXbzJYM1pNVUNaeWppVnZSTjd5?=
 =?utf-8?B?L0ZGd2k1UCtScytuOUJVczlLZWtqbkRHNUQwaUVsa0tVa0g0NWxnTnJzdkh6?=
 =?utf-8?B?UVVMdmE0NTNhbVAyNCt6Y1dob3l6V3V1VHZlMEh6TnhxMkFLMHhCSVNQQVFB?=
 =?utf-8?B?UXlGem5vWGxmSGlwNDJzR1o1RlRyMXN1S0w1bVdEZHZRenhGRmh1bWM3bjdX?=
 =?utf-8?B?Q2lWMWx2c3RsWUoxLzJnbUFWVmVFS01zdmtqelBjTUc4NUNzU3ZQN3lKOTVG?=
 =?utf-8?B?QmY2Q1plb1VxSEtDNzNlUUJ3S1F0bmNhVjFQNHYxQVZaM1lEVkt2QXl0VXM2?=
 =?utf-8?B?bFIzU1pPRDB6aHUzVE9EV0YwNVk1UWFzbS9qMjVDZGFyOGxXSlVyRXVrQnhx?=
 =?utf-8?B?VHFGUXNsK1NaRGNITGVKdkFTdHhxOHJXZWJUcnhxRW9oa01UTEpaWkZvbENK?=
 =?utf-8?B?R2NUM3RQN2t5WTljZmFmT2pFVjh4ZlpRK1Z3WGhkNkZuUzc1eHBUenJhZkVq?=
 =?utf-8?B?UUJ0ZEt1Q0xrSjlPWTc1Q2xSRVpuaDhIWkkwRTFvUmY2RXZrTHE4V0VhQXdv?=
 =?utf-8?B?amlyU2ltNDdyb2llL29lYlU2NjI5T0xFQzNneDg2Q2NTYWxxMHJjZ0ZiYmc5?=
 =?utf-8?B?R3ROWEdLK2ZHMlNUSGNHeTJYTG9RZ1VXd2V1N2dGV1R0UjNRUlI1dDJ3aU5I?=
 =?utf-8?B?KzMyQWN1alhUQmNaSk00TEs2MHJLa2RCM1pwOFhxR1ByMm43K05lSU1kRy92?=
 =?utf-8?B?QnVkdVgyQkxZQXBHSVlpTnA4ZlI1TFR2ajZYb294NmtrOVdGMUR0b0pSejFw?=
 =?utf-8?B?UTh6NjNSbGNpTEs5L3BGOEs2dWloTFdBbjBFZExWSUpLYVdGblFMWEZFdzBE?=
 =?utf-8?B?SE9hUE1mRkt0V2VDL1ZzRXFaVHRBanRra0lCQ01iL0xLTTFpdktkV2hDY0NO?=
 =?utf-8?B?OG5sT1NFNTNGVW1pMldhOEtEbTI5TWwzMncvTVFYc2x6TGF4RTlhaExKK0Nt?=
 =?utf-8?Q?DS/g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ae1aae-0e8d-4501-8c4a-08db97217a83
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 08:37:04.7731 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5+IeIbYYNKHEsjJubx7bJiaUWfTXVPQdQUKpGTHaLVcildCf6xbtTK9lve2Y1k+hTmTN6dK3L5xnh4jCidgxGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTSEFOTVVH
QU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQo+IFNlbnQ6IE1v
bmRheSwgQXVndXN0IDcsIDIwMjMgNDoyNyBQTQ0KPiBUbzogS29lbmlnLCBDaHJpc3RpYW4gPENo
cmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVy
LkRldWNoZXJAYW1kLmNvbT47IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNvbT47DQo+
IFBhbiwgWGluaHVpIDxYaW5odWkuUGFuQGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZzsgU0hBTk1VR0FNLCBTUklOSVZBU0FODQo+IDxTUklOSVZBU0FOLlNIQU5N
VUdBTUBhbWQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IEZpeCBpZGVudGlm
aWVyIG5hbWVzIHRvIGZ1bmN0aW9uIGRlZmluaXRpb24NCj4gYXJndW1lbnRzIGluIGF0b20uaA0K
Pg0KPiBGaXhlcyB0aGUgZm9sbG93aW5nOg0KPg0KPiBXQVJOSU5HOiBmdW5jdGlvbiBkZWZpbml0
aW9uIGFyZ3VtZW50ICdzdHJ1Y3QgY2FyZF9pbmZvIConIHNob3VsZCBhbHNvIGhhdmUNCj4gYW4g
aWRlbnRpZmllciBuYW1lDQo+IFdBUk5JTkc6IGZ1bmN0aW9uIGRlZmluaXRpb24gYXJndW1lbnQg
J3VpbnQzMl90JyBzaG91bGQgYWxzbyBoYXZlIGFuDQo+IGlkZW50aWZpZXIgbmFtZQ0KPiBXQVJO
SU5HOiBmdW5jdGlvbiBkZWZpbml0aW9uIGFyZ3VtZW50ICd2b2lkIConIHNob3VsZCBhbHNvIGhh
dmUgYW4NCj4gaWRlbnRpZmllciBuYW1lDQo+IFdBUk5JTkc6IGZ1bmN0aW9uIGRlZmluaXRpb24g
YXJndW1lbnQgJ3N0cnVjdCBhdG9tX2NvbnRleHQgKicgc2hvdWxkIGFsc28NCj4gaGF2ZSBhbiBp
ZGVudGlmaWVyIG5hbWUNCj4gV0FSTklORzogZnVuY3Rpb24gZGVmaW5pdGlvbiBhcmd1bWVudCAn
aW50JyBzaG91bGQgYWxzbyBoYXZlIGFuIGlkZW50aWZpZXINCj4gbmFtZQ0KPiBXQVJOSU5HOiBm
dW5jdGlvbiBkZWZpbml0aW9uIGFyZ3VtZW50ICd1aW50MzJfdCAqJyBzaG91bGQgYWxzbyBoYXZl
IGFuDQo+IGlkZW50aWZpZXIgbmFtZQ0KPiBXQVJOSU5HOiBVbm5lY2Vzc2FyeSBzcGFjZSBiZWZv
cmUgZnVuY3Rpb24gcG9pbnRlciBuYW1lDQo+IEVSUk9SOiBzcGFjZSBwcm9oaWJpdGVkIGFmdGVy
IHRoYXQgJyonIChjdHg6QnhXKQ0KPiBDSEVDSzogUHJlZmVyIGtlcm5lbCB0eXBlICd1MzInIG92
ZXIgJ3VpbnQzMl90Jw0KPg0KPiBDYzogR3VjaHVuIENoZW4gPGd1Y2h1bi5jaGVuQGFtZC5jb20+
DQo+IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+IENj
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IENjOiAiUGFuLCBY
aW5odWkiIDxYaW5odWkuUGFuQGFtZC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFNyaW5pdmFzYW4g
U2hhbm11Z2FtIDxzcmluaXZhc2FuLnNoYW5tdWdhbUBhbWQuY29tPg0KDQpSZXZpZXdlZC1ieTog
R3VjaHVuIENoZW4gPGd1Y2h1bi5jaGVuQGFtZC5jb20+DQoNClJlZ2FyZHMsDQpHdWNodW4NCg0K
PiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2F0b20uaCB8IDIzICsrKysrKysr
KysrKystLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMTAg
ZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hdG9tLmgNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hdG9tLmgNCj4gaW5kZXgg
NTViZjk5ZDUyODhkLi5jMTFjZjE4YTBmMTggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2F0b20uaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
dG9tLmgNCj4gQEAgLTExNywxMiArMTE3LDE1IEBAIHN0cnVjdCBkcm1fZGV2aWNlOw0KPg0KPiAg
c3RydWN0IGNhcmRfaW5mbyB7DQo+ICAgICAgIHN0cnVjdCBkcm1fZGV2aWNlICpkZXY7DQo+IC0g
ICAgIHZvaWQgKCogcmVnX3dyaXRlKShzdHJ1Y3QgY2FyZF9pbmZvICosIHVpbnQzMl90LCB1aW50
MzJfdCk7ICAgLyogIGZpbGxlZCBieQ0KPiBkcml2ZXIgKi8NCj4gLSAgICAgdWludDMyX3QgKCog
cmVnX3JlYWQpKHN0cnVjdCBjYXJkX2luZm8gKiwgdWludDMyX3QpOyAgICAgICAgICAvKiAgZmls
bGVkIGJ5DQo+IGRyaXZlciAqLw0KPiAtICAgICB2b2lkICgqIG1jX3dyaXRlKShzdHJ1Y3QgY2Fy
ZF9pbmZvICosIHVpbnQzMl90LCB1aW50MzJfdCk7ICAgLyogIGZpbGxlZCBieQ0KPiBkcml2ZXIg
Ki8NCj4gLSAgICAgdWludDMyX3QgKCogbWNfcmVhZCkoc3RydWN0IGNhcmRfaW5mbyAqLCB1aW50
MzJfdCk7ICAgICAgICAgIC8qICBmaWxsZWQgYnkNCj4gZHJpdmVyICovDQo+IC0gICAgIHZvaWQg
KCogcGxsX3dyaXRlKShzdHJ1Y3QgY2FyZF9pbmZvICosIHVpbnQzMl90LCB1aW50MzJfdCk7ICAg
LyogIGZpbGxlZCBieQ0KPiBkcml2ZXIgKi8NCj4gLSAgICAgdWludDMyX3QgKCogcGxsX3JlYWQp
KHN0cnVjdCBjYXJkX2luZm8gKiwgdWludDMyX3QpOyAgICAgICAgICAvKiAgZmlsbGVkIGJ5DQo+
IGRyaXZlciAqLw0KPiArICAgICB2b2lkICgqcmVnX3dyaXRlKShzdHJ1Y3QgY2FyZF9pbmZvICpp
bmZvLA0KPiArICAgICAgICAgICAgICAgICAgICAgICB1MzIgcmVnLCB1aW50MzJfdCB2YWwpOyAg
IC8qICBmaWxsZWQgYnkgZHJpdmVyICovDQo+ICsgICAgIHVpbnQzMl90ICgqcmVnX3JlYWQpKHN0
cnVjdCBjYXJkX2luZm8gKmluZm8sIHVpbnQzMl90IHJlZyk7ICAgICAgICAgIC8qDQo+IGZpbGxl
ZCBieSBkcml2ZXIgKi8NCj4gKyAgICAgdm9pZCAoKm1jX3dyaXRlKShzdHJ1Y3QgY2FyZF9pbmZv
ICppbmZvLA0KPiArICAgICAgICAgICAgICAgICAgICAgIHUzMiByZWcsIHVpbnQzMl90IHZhbCk7
ICAgLyogIGZpbGxlZCBieSBkcml2ZXIgKi8NCj4gKyAgICAgdWludDMyX3QgKCptY19yZWFkKShz
dHJ1Y3QgY2FyZF9pbmZvICppbmZvLCB1aW50MzJfdCByZWcpOyAgICAgICAgICAvKg0KPiBmaWxs
ZWQgYnkgZHJpdmVyICovDQo+ICsgICAgIHZvaWQgKCpwbGxfd3JpdGUpKHN0cnVjdCBjYXJkX2lu
Zm8gKmluZm8sDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHUzMiByZWcsIHVpbnQzMl90IHZh
bCk7ICAgLyogIGZpbGxlZCBieSBkcml2ZXIgKi8NCj4gKyAgICAgdWludDMyX3QgKCpwbGxfcmVh
ZCkoc3RydWN0IGNhcmRfaW5mbyAqaW5mbywgdWludDMyX3QgcmVnKTsgICAgICAgICAgLyoNCj4g
ZmlsbGVkIGJ5IGRyaXZlciAqLw0KPiAgfTsNCj4NCj4gIHN0cnVjdCBhdG9tX2NvbnRleHQgew0K
PiBAQCAtMTUyLDEwICsxNTUsMTAgQEAgc3RydWN0IGF0b21fY29udGV4dCB7DQo+DQo+ICBleHRl
cm4gaW50IGFtZGdwdV9hdG9tX2RlYnVnOw0KPg0KPiAtc3RydWN0IGF0b21fY29udGV4dCAqYW1k
Z3B1X2F0b21fcGFyc2Uoc3RydWN0IGNhcmRfaW5mbyAqLCB2b2lkICopOyAtaW50DQo+IGFtZGdw
dV9hdG9tX2V4ZWN1dGVfdGFibGUoc3RydWN0IGF0b21fY29udGV4dCAqLCBpbnQsIHVpbnQzMl90
ICopOyAtaW50DQo+IGFtZGdwdV9hdG9tX2FzaWNfaW5pdChzdHJ1Y3QgYXRvbV9jb250ZXh0ICop
OyAtdm9pZA0KPiBhbWRncHVfYXRvbV9kZXN0cm95KHN0cnVjdCBhdG9tX2NvbnRleHQgKik7DQo+
ICtzdHJ1Y3QgYXRvbV9jb250ZXh0ICphbWRncHVfYXRvbV9wYXJzZShzdHJ1Y3QgY2FyZF9pbmZv
ICpjYXJkLCB2b2lkDQo+ICsqYmlvcyk7IGludCBhbWRncHVfYXRvbV9leGVjdXRlX3RhYmxlKHN0
cnVjdCBhdG9tX2NvbnRleHQgKmN0eCwgaW50DQo+ICtpbmRleCwgdWludDMyX3QgKnBhcmFtcyk7
IGludCBhbWRncHVfYXRvbV9hc2ljX2luaXQoc3RydWN0IGF0b21fY29udGV4dA0KPiArKmN0eCk7
IHZvaWQgYW1kZ3B1X2F0b21fZGVzdHJveShzdHJ1Y3QgYXRvbV9jb250ZXh0ICpjdHgpOw0KPiAg
Ym9vbCBhbWRncHVfYXRvbV9wYXJzZV9kYXRhX2hlYWRlcihzdHJ1Y3QgYXRvbV9jb250ZXh0ICpj
dHgsIGludCBpbmRleCwNCj4gdWludDE2X3QgKnNpemUsDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdWludDhfdCAqZnJldiwgdWludDhfdCAqY3JldiwgdWludDE2X3QgKmRhdGFfc3RhcnQp
Ow0KPiBib29sIGFtZGdwdV9hdG9tX3BhcnNlX2NtZF9oZWFkZXIoc3RydWN0IGF0b21fY29udGV4
dCAqY3R4LCBpbnQgaW5kZXgsDQo+IC0tDQo+IDIuMjUuMQ0KDQo=
