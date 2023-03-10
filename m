Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCB7C61DA4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 03:15:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6703A10E92F;
	Fri, 10 Mar 2023 03:15:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EC5710E92F
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 03:15:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWdCzRhtXQuy2fUE4hepn1btq+T1bo7OLcH+n3pwIBTvhqZdXoPVpod5ljOYp0l1EDnHHtmJTS6ndOMvvNwVpdaWunEypP1m534oKIEW1Y5z53bMwNRmUfa8qVuSOQ9/DpaeYDB2K1YFusobxCXnLzSzlv97YqxgVsdQCIp7C1oaIS70vLLU/f7WmZjADf6vOzTuO8dJb86tFjl/h6G6yu6BLTl0pSY64S8w7u5X/zpNNkcR2n3mOI8d56p1/VN0lBDqDHwsJUzkvL3bearePRVBiO72jy++g1sRBE7RBfNVPHSD1uNacBNCLiJhL+uwBu0qFGinRrz8zd8J6vjIrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kE6eHm7wGyxk91C7AZNkkvFPGwIlX6DwHjM3i8g8t0w=;
 b=PZL9GrDeX2ARuIpa3cjOVVurL3iNSejKQQnjrlCMZ9XKKgqPQ9DExOugkqPu0N+Ts407YKwpJc5pB9RHkI5wd8Yy6Xck5yW0H/056zhOlop4h7W/AM92jqAl7cxV5kJ0DZ9EabpCkYTH7LlYEp7gjBl7ZS3pCKxDEwLx668jCyzCUYw3AUUStSS/q7ggRFtO5fK53eYCs6hHwePZNzo3tkfw1Nt95oq4pz+USEtpUqH7c+yoQ2GnpFfUwOHf1gEOCwptt42zsSF5RgA9WUAvThIgRoOBWP3nUwXdlMr0BEMRl7QOmz9EQ61K6fpoJrhAhbjz0SCXC0Dj13k32++OqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kE6eHm7wGyxk91C7AZNkkvFPGwIlX6DwHjM3i8g8t0w=;
 b=CL0MErOd/wUlEDq9Yc/ZbhE1ah2Q8yFX/F5IEzamI9LGp3H6WiBFv+DqCX3W2ETgPbRDmD2J9qjBe+rEtzhIqeDbAk60qo26wjnZMYHhbAVCHjVNlztgBrlg5GO+j++72L8FFEN1H7uJBqrFy3FidTQ4f4XtAHIg3JIPlRE6Hnw=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19; Fri, 10 Mar 2023 03:15:36 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::5ca6:3a18:d6ee:c103]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::5ca6:3a18:d6ee:c103%7]) with mapi id 15.20.6156.028; Fri, 10 Mar 2023
 03:15:36 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/nv: fix codec array for SR_IOV
Thread-Topic: [PATCH] drm/amdgpu/nv: fix codec array for SR_IOV
Thread-Index: AQHZUjpfwcmmefObKEaBod/KLBwGTa7zWF6AgAAANqA=
Date: Fri, 10 Mar 2023 03:15:36 +0000
Message-ID: <DM5PR12MB2469B31BC80D7806FC265183F1BA9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230309035021.1860501-1-alexander.deucher@amd.com>
 <CADnq5_PLiokwzsa-zUmv-LRHYkCZMCw5odP-21m-d_CXnJcs8g@mail.gmail.com>
In-Reply-To: <CADnq5_PLiokwzsa-zUmv-LRHYkCZMCw5odP-21m-d_CXnJcs8g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|DS7PR12MB8252:EE_
x-ms-office365-filtering-correlation-id: d9d879bc-0094-4ccc-1011-08db2115b7cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iYjrrO4ifLn83PHrjIXXKOTgKaMVyTD1/WRwP4hWXfwAIgqu2rm16SVD0TEQjchkVMD4EqIIaMnnEzClXxy9l6a3tiqCw3jqrpv8vdRYCnFtMmMZtCOlAxuHtpo1joOr2rHdIbpPvCqGJyDTpRN0Q/3rCTQvfeibkTCdvmHWyMeaGiRB6MMyMGQfSIU1lK6UgtwfrjqC26MmPqnQokk/MD62J3aBkkwEU88BsPAGqz1xGLFeQ3dg8jTZfC2Yv8foe0xZkmKwKoyR4tLiZJXY7ch9kyy1ydqHvbxTiudAss3giNbLKCkv+tiJfhcwoJR60cNmkevfNa9tILh8e6+TXSoNyadPPoyrvz73Tqb+nD1BM0B2Bq5bnbRsrqAPtbXqnNUJbAFWxOHep0TWE6F2RESkXOcWY813Ld+Cpghq+W1g8pdXdaOe1XEozK4IHr5Yw0xvLgJreejq2/EnPnj2JFttIu5VWsc7sP+EdKGkZHf/HkSZRGcZZMO6NEeXVomWwo7th/NpMFxoamgMEaduEOAGxgKtkoLTMJY12XBcKGO00+xDXfnNVnjbyOJsa7/MFADOXU65mdJX+sbbVr7fMut0MxKdG+PqGEgpF93H12PjtbIgzqMf/i8sUIi5ismfvYVCX3xFvpehjW1ga9h643ZQV008cp3cO0yz7LmX2R06sWWi/Ph96nWZxBj8H3yC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(451199018)(83380400001)(33656002)(478600001)(110136005)(55016003)(6636002)(54906003)(122000001)(38070700005)(316002)(38100700002)(71200400001)(966005)(52536014)(6506007)(9686003)(7696005)(186003)(26005)(53546011)(2906002)(5660300002)(8676002)(64756008)(66446008)(66476007)(8936002)(66946007)(66556008)(76116006)(41300700001)(4326008)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlArOG9NYU1MUzlhazN4NjJYakVPRHZocjZIMWFJZk1KNjlKRW94MTZybnB1?=
 =?utf-8?B?RW5WdWhwQzNNdlFPMHFxaGxxTUgxWUdDM0luV2tpb1o3MTlRbjNGL2FjU3dt?=
 =?utf-8?B?NW9OTVkwUWNla0NOSkhzd210NldKVnBRKzZSM0xhalhUQmFoemM3TStUd3dp?=
 =?utf-8?B?c3NNdnVmcDEzanpJbnpqYkZZQjVwQ2p5MWRGTlpEQnpqbmkxL2pBUXFSRUpX?=
 =?utf-8?B?S2pVM3ZBWUhpTVoyaG0waitrTHdLVkdLMTBVWm1jQ1JCaHh3bWNmaTc3VTNK?=
 =?utf-8?B?aklUWGhMVTY3NWROdUtCZmJQQjhjRTQ1Yi9paUZmTWFKR0IyZ29UR0UrOHc3?=
 =?utf-8?B?M0NXaWltTzAxdS9CWGdiNGtYVGdzTFV4bTRwNXpRMWxaYVdHUmlEUDFJS2s2?=
 =?utf-8?B?RjJyQnVkdGtDOUFIR08vQ2o5aXhiaTdqanA1YXFaWS9EVGpCSTVneHVQSWpW?=
 =?utf-8?B?UTlMUGJ2TWRyTkdUcFd0MnVDM0dkc05zSmpNdTRQd05XdXNIWmM4Qmk3Tm4y?=
 =?utf-8?B?V1BaaTVQYmEyT3BVNGJvNGlpSWJwSDhWM0NpVzhxOUtobTltWDJsMjN0K3FX?=
 =?utf-8?B?Y1FrRjNSbytmR096N0pCYzE1SXY4RW5CTExhT0VFMUF5WXZWQWpLSTNaQlZw?=
 =?utf-8?B?SnVVTnRVV0hUc1NOckJ4eG9SM0RydFFFK2hWcUsxMTdNUG5ERGVCREsyVjBT?=
 =?utf-8?B?Kzh4L3R6Vnd2NmdYeUlhM1daQ2R1cWQ0YTZKUU1OOThxR2piVjNwZkYwZHgx?=
 =?utf-8?B?YXgxU2ZzWGVxdUhwaEZrY3FzZmpWTDUrdnZGTHFGUExGUld1ZnRsZzZzdmtH?=
 =?utf-8?B?cXlSdlZONGxjYkVMUVpaVzY0aG93elhsN2tXNGJYVXl4S01ZbHNzK2RQMDF5?=
 =?utf-8?B?V2ZnTENtMFhUZmVQNlcvQTgwYzBjWno4aG9aWUZaaE5MVUg3YlE1ZFlMRGMx?=
 =?utf-8?B?enU5c1BERUV4TUFkVEx3ekxSVERUczYrZXY5WmFKNmxMOStOTzFpUjl1aGZY?=
 =?utf-8?B?T1A0VndkK0pMeWVNejltelpQa0RGSy9nR01OWUlkSXdyUDJHRmFxYlBabSta?=
 =?utf-8?B?VHVCclJZTkU0eXVIR0hmYi9oclBuNmhJTy9OMVlmek5nbFc0RDZhekYxVjNw?=
 =?utf-8?B?NWNwM3BHK2I3ZEVBNzk3a3JNTm5UcWkxNkE5anJLMU5kcXpINXJPSzVFR2Y2?=
 =?utf-8?B?THppdHJHczNXbWFHaG9oZEdLdzRNbnRKVUJCUGZJYnZhZDUxaXV0aUhnWTNX?=
 =?utf-8?B?Q3FWMkNPYjVVN2ppU0ZZcXdWa1g3Y0RHTkRhRnJEb0lON2hJb21lQ3E0ZW5W?=
 =?utf-8?B?aGs5U21CUHI5cCtwbzFmWUxUV0lrWS9IMzFVNXlhQjZaNHdqbmFWMk9TOW5H?=
 =?utf-8?B?L1llSnAwekM3K3Q5Q1FZQ08wSkVzL2FockFaOTViT1JUckQ1ci9ETXR1SFEx?=
 =?utf-8?B?WjJQUUlyTXFLeWs1T1ZySmVYaXpGNUVZblhJcStEWUkrc1dGQ01SK29NWEtm?=
 =?utf-8?B?aEV1bVAvUG5CelJxSzRYVlo4U05MQy9vZjZSUE03YldFYzdtT0h4YzZzS1Nz?=
 =?utf-8?B?cTFqSnlPWVptK2tYdWpSUERHOEYyRW5ZSzMzWVR3L1pFNmlaMlRQWnJaZTFU?=
 =?utf-8?B?c1ZVaXQ1R2pKOGVBTjBRMTJtUisyRVh0cVZBOTVuUDd4UEV0aVFiUlB3cWhw?=
 =?utf-8?B?ZTVZdDQvbG53UExyWCtlMVVQRnBhL2g4MnhMOGJoaGNGOXMzZ3lGNlVmL2RE?=
 =?utf-8?B?cXZsUnc2MTN0RUcwcGRZTmdUeHIrV0VqTTdsQUcycFQxdHQvc2ZBckRiTkVl?=
 =?utf-8?B?UEw1bU5zYzljcDJ3eXhkeTlTSThJR3BQcG5KK1BHR1BLUWFaOFBiNkt6SjA5?=
 =?utf-8?B?RVh6ZDB2WUo3bGE3cXV3QTh0NmZvTEJUMkZvcVR1MWlPRW1oNHdScnhWUEtO?=
 =?utf-8?B?MU5kbDhkYXNia0JRT3VOVDRoaTMyd0VWSnB1Y1ZQTkJjSVhZUWJnU2hkSVlK?=
 =?utf-8?B?emF1K3RaYmlRZkI4NnZHd0NVc2FmM1BnLzlNbHdtTE12aEIxRVhJZy9Sb1Vi?=
 =?utf-8?B?OGl3Z3IrY2RORG53bU1xaXphd3RTY0NiQ3haZTFSaW1obVRWQWFYUW9zRUdt?=
 =?utf-8?Q?pxmweYoLUOjBzi919mdaOZn3T?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d879bc-0094-4ccc-1011-08db2115b7cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 03:15:36.4575 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K2AueSP8PG/qY50qntsDRgM/B3gtEF1rU0BCnJDbhKhAkQR8SANS2DQXDQnvpl2dFz6cKtccCy0Ie1MR0R/w7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8252
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
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 Abaci Robot <abaci@linux.alibaba.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QWNrZWQtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPg0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0
cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBBbGV4DQo+IERldWNoZXINCj4gU2VudDog
RnJpZGF5LCBNYXJjaCAxMCwgMjAyMyAxMToxNCBBTQ0KPiBUbzogRGV1Y2hlciwgQWxleGFuZGVy
IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBDYzogSmlhcGVuZyBDaG9uZyA8amlhcGVu
Zy5jaG9uZ0BsaW51eC5hbGliYWJhLmNvbT47IEFiYWNpIFJvYm90DQo+IDxhYmFjaUBsaW51eC5h
bGliYWJhLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0hdIGRybS9hbWRncHUvbnY6IGZpeCBjb2RlYyBhcnJheSBmb3IgU1JfSU9WDQo+IA0K
PiBQaW5nPw0KPiANCj4gT24gV2VkLCBNYXIgOCwgMjAyMyBhdCAxMDo1MSBQTSBBbGV4IERldWNo
ZXINCj4gPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gQ29weSBw
YXN0ZSBlcnJvci4NCj4gPg0KPiA+IEZpeGVzOiAzODQzMzQxMjBiNjYgKCJkcm0vYW1kZ3B1L252
OiBkb24ndCBleHBvc2UgQVYxIGlmIFZDTjAgaXMNCj4gPiBoYXJ2ZXN0ZWQiKQ0KPiA+IFJlcG9y
dGVkLWJ5OiBBYmFjaSBSb2JvdCA8YWJhY2lAbGludXguYWxpYmFiYS5jb20+DQo+ID4gTGluazog
aHR0cHM6Ly9idWd6aWxsYS5vcGVuYW5vbGlzLmNuL3Nob3dfYnVnLmNnaT9pZD00NDU0DQo+ID4g
Q2M6IEppYXBlbmcgQ2hvbmcgPGppYXBlbmcuY2hvbmdAbGludXguYWxpYmFiYS5jb20+DQo+ID4g
U2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0K
PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jIHwgNCArKy0tDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYw0KPiA+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYyBpbmRleCA4NTVkMzkwYzQxZGUuLjIyZTI1
Y2EyODVmOA0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L252LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jDQo+ID4gQEAg
LTEwNTUsOCArMTA1NSw4IEBAIHN0YXRpYyBpbnQgbnZfY29tbW9uX2xhdGVfaW5pdCh2b2lkICpo
YW5kbGUpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgYW1kZ3B1X3ZpcnRfdXBkYXRlX3Ny
aW92X3ZpZGVvX2NvZGVjKGFkZXYsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNyaW92X3NjX3ZpZGVvX2NvZGVjc19lbmNv
ZGVfYXJyYXksDQo+ID4NCj4gQVJSQVlfU0laRShzcmlvdl9zY192aWRlb19jb2RlY3NfZW5jb2Rl
X2FycmF5KSwNCj4gPiAtDQo+IHNyaW92X3NjX3ZpZGVvX2NvZGVjc19kZWNvZGVfYXJyYXlfdmNu
MSwNCj4gPiAtDQo+IEFSUkFZX1NJWkUoc3Jpb3Zfc2NfdmlkZW9fY29kZWNzX2RlY29kZV9hcnJh
eV92Y24xKSk7DQo+ID4gKw0KPiBzcmlvdl9zY192aWRlb19jb2RlY3NfZGVjb2RlX2FycmF5X3Zj
bjAsDQo+ID4gKw0KPiA+ICsgQVJSQVlfU0laRShzcmlvdl9zY192aWRlb19jb2RlY3NfZGVjb2Rl
X2FycmF5X3ZjbjApKTsNCj4gPiAgICAgICAgICAgICAgICAgfQ0KPiA+ICAgICAgICAgfQ0KPiA+
DQo+ID4gLS0NCj4gPiAyLjM5LjINCj4gPg0K
