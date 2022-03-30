Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5B1C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Mar 2022 02:33:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F21D110F2E0;
	Wed, 30 Mar 2022 02:33:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DFBD10F2E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Mar 2022 02:33:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBPr7nw4QfRQABUK8VwZSjvlw+JmGlgwh/T89Y4N5UNmi+jgiiryoWldnpE8QWnXkEQtIRMs7QmUoo/diUg0HkJ7TgOZjskPZOvGNJFudPyySGa6dFFNql2PTz8XBYVna5yOj9wAjiIUOVkxIzceV4OF4XAE1rUdPPb5jpznzYrb6o7nDO4orkWYXwa5j9F7ElPCxuroxIFWAgAQ3VRrPvQzfnxMdyVT2DaGzxDX3CCRxWxjKKp8BT1zUk+tPehAApb80VW5cLXYhU8nNMVq5UGpNUOl2jbMPVeepg14uyvbwkgQwRKK1ARjga3wlB+bl+ZukZfBGhKb+xCZfCk1ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOdQ84hkIApI9/u7RZTI5le1gF6Eue+z3tP6TrRYHWs=;
 b=Um8vfZvMGBPKi87gH/ZICi7CXHxGzq6l2kKpt/pPhwrh39iV2PcnQquwJ2dacTaD+R+6uFaSZhBWxDQjSXy9dJ86BfwkRuMTE1I9l9N9mnfqyQVK84V2PmGcYeqh6vmwVpcG4Z6rsSgER3vMzHbOCksaN67MgI6+0XpAcBkzEEFKQ0UxJUJKgzLlVnexxSpKb+ZbqumoCrxmpXU80objx4DIJBEbS6SyiYPFXK7Gry3+h3mOnJ9CUdqTwKlg/E7Pex0jFLPLTxGCSvjXQKUtM3Ja8Rkp8gZA8hupzwSFN7YEAR/IVsD+oAp/IzfOhqP77uUUDSXqsq++WPtycOsf8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOdQ84hkIApI9/u7RZTI5le1gF6Eue+z3tP6TrRYHWs=;
 b=WJDc0mvV3CR8QZioDOQYCFQmCdkFZnoX2t+Of+kZNA02JRjc6VFs0P1SzSCY0rsV2t95NDc7BSRKIo0xr8US/+k1Dp08/zDdY5yvLeAFvkkItWaBdj1nQPHyU+TQXMMKF8Qg/c+HMTKG3ElINmlrqFM6fOhovt/83gjm8HzqY7c=
Received: from MW4PR12MB5668.namprd12.prod.outlook.com (2603:10b6:303:16b::13)
 by SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Wed, 30 Mar
 2022 02:33:02 +0000
Received: from MW4PR12MB5668.namprd12.prod.outlook.com
 ([fe80::5d27:53d9:5dbe:49fd]) by MW4PR12MB5668.namprd12.prod.outlook.com
 ([fe80::5d27:53d9:5dbe:49fd%3]) with mapi id 15.20.5102.022; Wed, 30 Mar 2022
 02:33:02 +0000
From: "VURDIGERENATARAJ, CHANDAN" <CHANDAN.VURDIGERENATARAJ@amd.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [PATCH] drm/amd/display: Fix by adding FPU protection for
 dcn30_internal_validate_bw
Thread-Topic: [PATCH] drm/amd/display: Fix by adding FPU protection for
 dcn30_internal_validate_bw
Thread-Index: AQHYQ0dM8k0cKCFOq0GCjxz6e4fUbazWkouAgACdKLA=
Date: Wed, 30 Mar 2022 02:33:02 +0000
Message-ID: <MW4PR12MB5668E0D09D8A0B1D9B7E6EC2961F9@MW4PR12MB5668.namprd12.prod.outlook.com>
References: <20220329082957.1662655-1-chandan.vurdigerenataraj@amd.com>
 <c8c00a40-5f1f-d861-adde-3dc246cd2338@molgen.mpg.de>
In-Reply-To: <c8c00a40-5f1f-d861-adde-3dc246cd2338@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5301e785-95e6-4d92-51ec-08da11f59d15
x-ms-traffictypediagnostic: SN6PR12MB2718:EE_
x-microsoft-antispam-prvs: <SN6PR12MB271826D265824242C388DD5B961F9@SN6PR12MB2718.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ChjinG5bP0dg2+sg14Rndl82fgj9gPGpwruzI4jPQUjIMFj7tYlv2Wjwz+fRhpqN8crkyHffWDGziTkJFRkNkguVKVdWxLqu0D21nJNtMvmVl42DwEUYjtRJuMwKw36N547i8+4M4thKIxJy6qeSovpBVMD4ojDYsLccPpsrbKPMWAtEuJv/q39y0pPfpnVMOONh2bM/64OE6gPZZYI3FMC434xaZB53WY3DGxrVTgWk4gb+7nE8wBYuCkJvqym+A9VBs7hkTYlJBBdMxSXJujbWXzFh1PvkVWbZvmwXbQ1ALQSW7WVz3FLnDWeULFfzY88NtAa+k/nKDI9TbguIuK6MLmp9HkOva+TtNe4QGMVngUeZhvuOYnBgc/k1jXOiYBlvapeJFu67eJMsinKF87RylkleJxI0+fSBho/8mbRbiOq7nlF+nL1AvMk08tL4evPNAANx0djqzXSgCHnPX+MpwH3N/xk+HjKMWnYjqwegZ9DekwWhZapIWXqYthA99QWzpL1i7oyxpcoWuvq2SOmGM01hlQWnLGE2098a/0AqweDD58b621cgPXYjx3NuGWQm1FT/xjuqTLu5qtP23ZWKxW2WRmln0u9P5FfjA31T6jmB8479mB0/Q3M39fsdmJyJZGZUpqx26Vw/oMYBe8JAnix2gs7WnkJf12ct+E52GTFNbFfhr3Q3D3/Pl9Yby6GocffbfRakBzeoxgxyCA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5668.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(7696005)(186003)(83380400001)(55236004)(26005)(86362001)(5660300002)(52536014)(66574015)(9686003)(8936002)(2906002)(38070700005)(54906003)(38100700002)(33656002)(66556008)(66446008)(6916009)(64756008)(122000001)(316002)(71200400001)(508600001)(66476007)(55016003)(66946007)(8676002)(4326008)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFpMcGFCSXo0UTBlV1lwT29vYis2ZER6YVFzeFFYS0l4a1BMc25FOFlPWVRQ?=
 =?utf-8?B?amdwMFZIQ0ROMGNwY0Rqc1ZHWFg0Qy9vQTgzNi82dzhiSFhReUtuRU5aZ2tp?=
 =?utf-8?B?TElYYklid1VJaWtSRHVDdHNhMXNncVYrNzhYMmt0T0tyczNkRHpiK1ZYZWJD?=
 =?utf-8?B?Mzc3c0tjS1RmOGtHZ3diSGFKYzRZZkx2ZDk0dE1vWWZ0TitxRGpUZkhDVTVr?=
 =?utf-8?B?NHBhQ1lHR2pGUGltWW1GdjR1OU9WTzUwNXhwSXp2TnpZSUo2d3ZXdldFalZN?=
 =?utf-8?B?RURWd3dZK0c1WlRSUGF5SjlYNjRTVmpwUUR1TlNQYjdTaVZ5T3FTa3NmOXVT?=
 =?utf-8?B?L01MVEI2UWJ5U2g5Y1JvbmNPMldUSWtkbm91bmkrSkY5VUxwTkk0NFZMK2VX?=
 =?utf-8?B?NVhEamFtdkREL3RoTjVNL1dFbjMxMEdITUJRdWRnNmpsamZWVUtjUVN3YW5a?=
 =?utf-8?B?VEdpQUZva2dnT2RzZUQxUkdNMnV0R2JGU3R1R0JoYU1taTRkTWoyMEZ5S2NC?=
 =?utf-8?B?ZlhXRG04S2t6MEpwSVFaMXQwZWpSQ2NrOFl0WHpFYVpFVURNWFBESTE4a09j?=
 =?utf-8?B?emdHN2UyTGVyUVFNbVJBQ1ZaNEt3L1N2MEdET3RDaXpPQk5ORFBNZjEwcVNy?=
 =?utf-8?B?Sm5PWjgrQmJNbkt1dmF0ZS9oWldHR0lDNXpRUXBBVHUxckJRYm1uaFZxYmMw?=
 =?utf-8?B?Ym45dVJ6T3dydkFrYzlKWkw5NGVYRmtoNTJvQWR1aHBjTkdIZG8vMEZ4N2No?=
 =?utf-8?B?aGh1bHYvZElhZFY1ZEExR3gzc1JNUDNodkFzWVlzN3pROTlZQjFHcEpjTmpt?=
 =?utf-8?B?RW9VMjUvYUlnYXhsVFZjVnYwVzR0Um1WRG0yS3RYUXFSeEtTSm5ES3ZMcnFE?=
 =?utf-8?B?TTkvWEZyL1Q2TUY3Y0IyZW01amltQVlPelRQV3Z3T1A3V3ZuZ2owOHBzOFhz?=
 =?utf-8?B?RGlYRHJzRDFGVEwrZlFnUFl1ZFJMUUp3S2xPTGxEd09XY3U5MHl3d3V1UnA1?=
 =?utf-8?B?cUt1OVZpQjQ5MXVPMVlNVU5ETGQwaFFBMWxnbHZ6TitiOXc5V2RuVHhWSkl3?=
 =?utf-8?B?d0RMYVhCK1ZaSHZsaGsxMC91WG85VUlxMEVWNUhJZHBVZE9YaVJydnAyUGxK?=
 =?utf-8?B?eEpBNlFhV2JNSG10dzhyUEUzR01SN2JVVmxzWFVjVkhveCtNVXovR00vU0x6?=
 =?utf-8?B?UHdXaTBjSmZGODY5elJHMzlCMm9ORjIvZFRwYzFoNS9yWUxySGIzRVJZZmpO?=
 =?utf-8?B?SW5uY3BNRWxIUERXckNER0VDZnZFb3hCWk9qMy9adnZLYnRmdXBhRE83NXRi?=
 =?utf-8?B?ODFwOWdZMEFZYWFCcGxWWnRnTmhvRDllNEVYSnJqSC9vRUJNcko2SitqaHhP?=
 =?utf-8?B?Rnpmd0FDUGM0RmNwRG1HWkIwOXFibG5Ic0FpM2JQNkZRS1FXTHl1cHVPYlVO?=
 =?utf-8?B?QjI5aytWYVFScURKZXJBa2RDZVdBakhobVRqcTRnRzJ2VHB0dlAwaXUzdGtL?=
 =?utf-8?B?cWpMc09TVjBmRTRIRzdGc20ycnU1aDdTR0RyTVJZVXRic3I5cnEwdnRjL3ZD?=
 =?utf-8?B?SUxZc1Vpbmd3bmpLVmVja3ZhS1lSOXo4bk5GcXBxcUpYeTM3OUVvRzBrMTlN?=
 =?utf-8?B?RHNXME85UVFtcUZ1cWFtNlJUekhSbGZWZGlIamNMY3hUNXRzUmtxY01DU0tw?=
 =?utf-8?B?Vi9UM0c0cndkNk42NitCMzNlRDNzYzZGTG9NcGRPeHovcHJTOEtzUDZkUCtZ?=
 =?utf-8?B?V1I1aXJpWTFhNG0ybk5pVXlaUFQweDcrMlkrWlVDeCt5R1lBQlZXdzdkQXNx?=
 =?utf-8?B?cnlVVnJyTmFJWnI4WVpGNmdtOVIvYUhFNmc3WC9ick5yOVVURzUxYkJEbEI2?=
 =?utf-8?B?cGNIZHpUNnVEaytXYzdLYlVMRGZiaVdyZXZHVmhLODJ4U0lFVnBHSDdFZ0ZS?=
 =?utf-8?B?RnkwOGVTd0w5NFRnL1phQWdIT2dBMXFUa2JQdFE3NG83RFp2NkVOeWZtdnJl?=
 =?utf-8?B?THJMZDJSbUY1b1NTbWFXL2wya2V0bXFRUmZVcXpibTZsY0Y2T2h6amxiSXBI?=
 =?utf-8?B?eVNQczdsWVRDR0o1RUFmUUVlTnVMWGVDMS92dHMvMC9mOVEyVlFiUUM5TXlB?=
 =?utf-8?B?akVwbWpGVFV2alFUeUhrK21yOEJ3TVByd1QxeTgrc2tMQ1l0MkEwajVkYUx2?=
 =?utf-8?B?MHhpN1JtSTJhbi9qd3U3clEyajdiNXI2cllLVENsTm1xNEVwdVQ4Z2hySmJt?=
 =?utf-8?B?OUpRVlV1NlBLSVFTZzRGaVIxL2gzYzhPOFhSMDhxWEFQbTgxZUptTG1YV2Jo?=
 =?utf-8?Q?SOR39woYz9kbRgiKB3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5668.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5301e785-95e6-4d92-51ec-08da11f59d15
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2022 02:33:02.5332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zRpvKC0RhwFnL5UrHV+zdvyIgI5y7Qy/lQj/117sJsUxRcjnqbtdFlFbSU2jIVWklAXan/WuFqeEE2J6OoDEZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2718
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgUGF1bCwNCg0KPkFtIDI5LjAzLjIyIHVtIDEwOjI5IHNjaHJpZWIgQ0hBTkRBTiBWVVJESUdF
UkUgTkFUQVJBSjoNCj4NCj5JcyBpdCBjb21tb24gdG8gc3BlbGwgeW91ciBuYW1lIGFsbCB1cHBl
cmNhc2U/IElmIG5vdCwgcGxlYXNlIHVzZSBDaGFuZGFuIG5WdXJkaWdlcmUgTmF0YXJhai4NCj4N
Cj4+IFtXSFldDQo+DQo+VGhlIFtdIGFscmVhZHkgZW1waGFzaXplIHRoZSB3b3JkLCBzbyBXaHkg
Y291bGQgYmUgdXNlZC4NCj4NCj4+IEJlbG93IGdlbmVyYWwgcHJvdGVjdGlvbiBmYXVsdCBvYnNl
cnZlZCB3aGVuIFdlYkdMIEFxdWFyaXVtIGlzIHJ1biBmb3IgDQo+PiBsb25nZXIgZHVyYXRpb24u
IElmIGRybSBkZWJ1ZyBsb2dzIGFyZSBlbmFibGVkIGFuZCBzZXQgdG8gMHgxZiB0aGVuIA0KPj4g
dGhlDQo+DQo+SW4gd2hhdCBicm93c2VyIGFuZCB3aGF0IHZlcnNpb24/DQpUaGUgaXNzdWUgd2Fz
IG9ic2VydmVkIG9uIENocm9taXVtT1MgYW5kIENocm9taXVtIEJyb3dzZXIgdmVyc2lvbiAxMDAu
MC40ODc3LjANCj4NCj4+IGlzc3VlIGlzIG9ic2VydmVkIHdpdGhpbiAxMCBtaW51dGVzIG9mIHJ1
bi4NCj4NCj5XaGVyZSB5b3UgYWJsZSB0byByZXByb2R1Y2UgaXQgd2l0aG91dCBkcm0gZGVidWcg
bG9ncz8NClllcy4gSXQgdG9vayAzNCBob3VycyB0byByZXByb2R1Y2Ugd2l0aG91dCBkcm0gZGVi
dWcgbG9ncy4gVXNpbmcgZHJtIGRlYnVnIGxvZ3Mgd2FzIGEgZmFzdGVyIHdheSB0byByZXByb2R1
Y2UgdGhlIGlzc3VlLg0KPg0KPj4gWyAgMTAwLjcxNzA1Nl0gZ2VuZXJhbCBwcm90ZWN0aW9uIGZh
dWx0LCBwcm9iYWJseSBmb3Igbm9uLWNhbm9uaWNhbCBhZGRyZXNzIDB4MmQzMzMwMmQzMjMyMzAz
MjogMDAwMCBbIzFdIFBSRUVNUFQgU01QIE5PUFRJDQo+PiBbICAxMDAuNzI3OTIxXSBDUFU6IDMg
UElEOiAxOTA2IENvbW06IERybVRocmVhZCBUYWludGVkOiBHICAgICAgICBXICAgICAgICAgNS4x
NS4zMCAjMTIgZDcyNmM2YTJkNmViZTVjZjkyMjM5MzFjYmNhNjg5MmY5MTZmZTE4Yg0KPj4gWyAg
MTAwLjc1NDQxOV0gUklQOiAwMDEwOkNhbGN1bGF0ZVN3YXRoV2lkdGgrMHgxZjcvMHg0NGYNCj4+
IFsgIDEwMC43NjcxMDldIENvZGU6IDAwIDAwIDAwIGYyIDQyIDBmIDExIDA0IGYwIDQ4IDhiIDg1
IDg4IDAwIDAwIDAwIA0KPj4gZjIgNDIgMGYgMTAgMDQgZjAgNDggOGIgODUgOTggMDAgMDAgMDAg
ZjIgNDIgMGYgMTEgMDQgZjAgNDggOGIgNDUgMTAgDQo+PiAwZiA1NyBjMCA8ZjM+IDQyIDBmIDJh
IDA0IGIwIDBmIDU3IGM5IGYzIDQzIDBmIDJhIDBjIGI0IGU4IDhjIGUyIGYzIGZmIA0KPj4gNDgg
OGIgWyAgMTAwLjc4MTI2OV0gUlNQOiAwMDE4OmZmZmZhOTIzMDA3OWVlYjAgRUZMQUdTOiAwMDAx
MDI0NiBbICANCj4+IDEwMC44MTI1MjhdIFJBWDogMmQzMzMwMmQzMjMyMzAzMiBSQlg6IDAwMDAw
MDAwMDAwMDA1MDAgUkNYOiANCj4+IDAwMDAwMDAwMDAwMDAwMDAgWyAgMTAwLjgxOTY1Nl0gUkRY
OiAwMDAwMDAwMDAwMDAwMDAxIFJTSTogDQo+PiBmZmZmOTlkZWI3MTJjNDljIFJESTogMDAwMDAw
MDAwMDAwMDAwMCBbICAxMDAuODI2NzgxXSBSQlA6IA0KPj4gZmZmZmE5MjMwMDc5ZWY1MCBSMDg6
IGZmZmY5OWRlYjcxMjQ2MGMgUjA5OiBmZmZmOTlkZWI3MTI0NjJjIFsgIA0KPj4gMTAwLjgzMzkw
N10gUjEwOiBmZmZmOTlkZWI3MTI0OTQwIFIxMTogZmZmZjk5ZGViNzEyNGQ3MCBSMTI6IA0KPj4g
ZmZmZjk5ZGViNzEyYWU0NCBbICAxMDAuODQxMDMzXSBSMTM6IDAwMDAwMDAwMDAwMDAwMDEgUjE0
OiANCj4+IDAwMDAwMDAwMDAwMDAwMDAgUjE1OiBmZmZmYTkyMzAwNzlmMGEwIFsgIDEwMC44NDgx
NTldIEZTOiAgMDAwMDdhZjEyMTIxMjY0MCgwMDAwKSBHUzpmZmZmOTlkZWJhNzgwMDAwKDAwMDAp
IGtubEdTOjAwMDAwMDAwMDAwMDAwMDAgWyAgMTAwLjg1NjI0MF0gQ1M6ICAwMDEwIERTOiAwMDAw
IEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMyBbICAxMDAuODYxOTgwXSBDUjI6IDAwMDAy
MDkwMDBmZTEwMDAgQ1IzOiA+MDAwMDAwMDExYjE4YzAwMCBDUjQ6IDAwMDAwMDAwMDAzNTBlZTAg
WyAgMTAwLjg2OTEwNl0gQ2FsbCBUcmFjZToNCj4+IFsgIDEwMC44NzE1NTVdICA8VEFTSz4NCj4+
IFsgIDEwMC44NzM2NTVdICA/IGFzbV9zeXN2ZWNfcmVzY2hlZHVsZV9pcGkrMHgxMi8weDIwDQo+
PiBbICAxMDAuODc4NDQ5XSAgQ2FsY3VsYXRlU3dhdGhBbmRERVRDb25maWd1cmF0aW9uKzB4MWEz
LzB4NmRkDQo+PiBbICAxMDAuODgzOTM3XSAgDQo+PiBkbWwzMV9Nb2RlU3VwcG9ydEFuZFN5c3Rl
bUNvbmZpZ3VyYXRpb25GdWxsKzB4MmNlNC8weDc2ZGENCj4+IFsgIDEwMC44OTA0NjddICA/IGth
bGxzeW1zX2xvb2t1cF9idWlsZGlkKzB4YzgvMHgxNjMNCj4+IFsgIDEwMC44OTUxNzNdICA/IGth
bGxzeW1zX2xvb2t1cF9idWlsZGlkKzB4YzgvMHgxNjMNCj4+IFsgIDEwMC44OTk4NzRdICA/IF9f
c3ByaW50X3N5bWJvbCsweDgwLzB4MTM1IFsgIDEwMC45MDM4ODNdICA/IA0KPj4gZG1fdXBkYXRl
X3BsYW5lX3N0YXRlKzB4M2Y5LzB4NGQyIFsgIDEwMC45MDg1MDBdICA/IA0KPj4gc3ltYm9sX3N0
cmluZysweGI3LzB4ZGUgWyAgMTAwLjkxMjI1MF0gID8gbnVtYmVyKzB4MTQ1LzB4MjliIFsgIA0K
Pj4gMTAwLjkxNTU2Nl0gID8gdnNucHJpbnRmKzB4MzQxLzB4NWZmIFsgIDEwMC45MTkxNDFdICA/
IA0KPj4gZGVzY19yZWFkX2ZpbmFsaXplZF9zZXErMHgzOS8weDg3IFsgIDEwMC45MjM3NTVdICA/
IA0KPj4gdXBkYXRlX2xvYWRfYXZnKzB4MWI5LzB4NjA3IFsgIDEwMC45Mjc4NDldICA/IA0KPj4g
Y29tcHV0ZV9tc3RfZHNjX2NvbmZpZ3NfZm9yX3N0YXRlKzB4N2QvMHhkNWINCj4+IFsgIDEwMC45
MzM0MTZdICA/IGZldGNoX3BpcGVfcGFyYW1zKzB4YTRkLzB4ZDBjIFsgIDEwMC45Mzc2ODZdICA/
IA0KPj4gZGNfZnB1X2VuZCsweDNkLzB4YTggWyAgMTAwLjk0MTE3NV0gIGRtbF9nZXRfdm9sdGFn
ZV9sZXZlbCsweDE2Yi8weDE4MCANCj4+IFsgIDEwMC45NDU2MTldICBkY24zMF9pbnRlcm5hbF92
YWxpZGF0ZV9idysweDEwZS8weDg5Yg0KPj4gWyAgMTAwLjk1MDQ5NV0gID8gZGNuMzFfdmFsaWRh
dGVfYmFuZHdpZHRoKzB4NjgvMHgxZmMNCj4+IFsgIDEwMC45NTUyODVdICA/IHJlc291cmNlX2J1
aWxkX3NjYWxpbmdfcGFyYW1zKzB4OThiLzB4YjhjDQo+PiBbICAxMDAuOTYwNTk1XSAgPyBkY24z
MV92YWxpZGF0ZV9iYW5kd2lkdGgrMHg2OC8weDFmYw0KPj4gWyAgMTAwLjk2NTM4NF0gIGRjbjMx
X3ZhbGlkYXRlX2JhbmR3aWR0aCsweDlhLzB4MWZjDQo+PiBbICAxMDAuOTcwMDAxXSAgZGNfdmFs
aWRhdGVfZ2xvYmFsX3N0YXRlKzB4MjM4LzB4Mjk1DQo+PiBbICAxMDAuOTc0NzAzXSAgYW1kZ3B1
X2RtX2F0b21pY19jaGVjaysweDljMS8weGJjZQ0KPj4gWyAgMTAwLjk3OTIzNV0gID8gX3ByaW50
aysweDU5LzB4NzMNCj4+IFsgIDEwMC45ODI0NjddICBkcm1fYXRvbWljX2NoZWNrX29ubHkrMHg0
MDMvMHg3OGIgWyAgMTAwLjk4NjkxMl0gIA0KPj4gZHJtX21vZGVfYXRvbWljX2lvY3RsKzB4NDli
LzB4NTQ2IFsgIDEwMC45OTEzNThdICA/IA0KPj4gZHJtX2lvY3RsKzB4MWMxLzB4M2IzIFsgIDEw
MC45OTQ5MzZdICA/IA0KPj4gZHJtX2F0b21pY19zZXRfcHJvcGVydHkrMHg5MmEvMHg5MmENCj4+
IFsgIDEwMC45OTk3MjVdICBkcm1faW9jdGxfa2VybmVsKzB4ZGMvMHgxNDkgWyAgMTAxLjAwMzY0
OF0gIA0KPj4gZHJtX2lvY3RsKzB4MjdmLzB4M2IzIFsgIDEwMS4wMDcwNTFdICA/IA0KPj4gZHJt
X2F0b21pY19zZXRfcHJvcGVydHkrMHg5MmEvMHg5MmENCj4+IFsgIDEwMS4wMTE4NDJdICBhbWRn
cHVfZHJtX2lvY3RsKzB4NDkvMHg3ZCBbICAxMDEuMDE1Njc5XSAgDQo+PiBfX3NlX3N5c19pb2N0
bCsweDdjLzB4YjggWyAgMTAxLjAxNTY4NV0gIGRvX3N5c2NhbGxfNjQrMHg1Zi8weGI4IFsgIA0K
Pj4gMTAxLjAxNTY5MF0gID8gX19pcnFfZXhpdF9yY3UrMHgzNC8weDk2DQo+PiANCj4+IFtIT1dd
DQo+PiBJdCBjYWxsZXMgcG9wdWxhdGVfZG1sX3BpcGVzIHdoaWNoIHVzZXMgZG91YmxlcyB0byBp
bml0aWFsaXplLg0KPg0KPmNhbGxzDQo+DQo+RXhjdXNlIG15IGlnbm9yYW5jZS4gU28gdXNpbmcg
ZG91YmxlcyBjYXVzZXMgYSBjb250ZXh0IHN3aXRjaD8NCklmIHdlIGRvbuKAmXQgYWRkIEZQVSBw
cm90ZWN0aW9uIHRoZW4gY29udGV4dCBzd2l0Y2ggY2FuIGhhcHBlbi4gRENfRlBfU1RBUlQgd291
bGQgaW4tdHVybiBjYWxsIHByZWVtcHRfZGlzYWJsZS4NCg0KPj4gQWRkaW5nIEZQVSBwcm90ZWN0
aW9uIGF2b2lkcyBjb250ZXh0IHN3aXRjaCBhbmQgcHJvYmFibGUgbG9zcyBvZiB2YmEgDQo+PiBj
b250ZXh0IGFzIHRoZXJlIGlzIHBvdGVudGlhbCBjb250ZW50aW9uIHdoaWxlIGRybSBkZWJ1ZyBs
b2dzIGFyZSBlbmFibGVkLg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBDSEFOREFOIFZVUkRJR0VS
RSBOQVRBUkFKIA0KPj4gPGNoYW5kYW4udnVyZGlnZXJlbmF0YXJhakBhbWQuY29tPg0KPj4gDQo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjMxL2RjbjMx
X3Jlc291cmNlLmMgDQo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24zMS9k
Y24zMV9yZXNvdXJjZS5jDQo+PiBpbmRleCA4MjY5NzBmMmJkMGEuLmYyNzI2MjQxN2FiZSAxMDA2
NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24zMS9kY24zMV9y
ZXNvdXJjZS5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMzEv
ZGNuMzFfcmVzb3VyY2UuYw0KPj4gQEAgLTE3NTAsNyArMTc1MCw5IEBAIGJvb2wgZGNuMzFfdmFs
aWRhdGVfYmFuZHdpZHRoKHN0cnVjdCBkYyAqZGMsDQo+PiAgIA0KPj4gICAJQldfVkFMX1RSQUNF
X0NPVU5UKCk7DQo+PiAgIA0KPj4gKwlEQ19GUF9TVEFSVCgpOw0KPj4gICAJb3V0ID0gZGNuMzBf
aW50ZXJuYWxfdmFsaWRhdGVfYncoZGMsIGNvbnRleHQsIHBpcGVzLCAmcGlwZV9jbnQsIA0KPj4g
JnZsZXZlbCwgZmFzdF92YWxpZGF0ZSk7DQo+PiArCURDX0ZQX0VORCgpOw0KPj4gICANCj4+ICAg
CS8vIERpc2FibGUgZmFzdF92YWxpZGF0ZSB0byBzZXQgbWluIGRjZmNsayBpbiBhbGN1bGF0ZV93
bV9hbmRfZGxnDQo+PiAgIAlpZiAocGlwZV9jbnQgPT0gMCkNCj4NCj4NCj5LaW5kIHJlZ2FyZHMs
DQo+DQo+UGF1bA0K
