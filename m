Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8BEC678D5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Mar 2023 03:52:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD3EF10E14C;
	Wed,  8 Mar 2023 03:52:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D48B10E14C
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Mar 2023 03:52:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gr2ZkUwWlLh3ZNcNzD97ByZzS0hmDz9ksY2LsemQXdSgume1nWP1ecjx0dN7i4Pen7S5Un1TmQO7FT9zCKyzVrINZNwvxwzcROnz/ZBW0NhGAAMy2sW5fuv2vT6g/yhDgt45KVnmZot4zow4KHxdt/bTX889lNwtF8lz14bIEQiaBgHuAiRR2H0uh5eKj2qu/1cgZLGkwyIhGNWsi1hoPlMnyVf8OlVZBLYhME6APeXymMt8kPoFnIN1IjK0vR3z4gEbUiSXY9tC2BVGtfG/iCqU63SjC1DcQXo0iiwuEfraPbhEG/2lVoOypq8FJHJfnBBcXxihVXz6nVY4UAMB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3THnmT3Ve8NsUEWfWUCNEk6dsH3mYtHmlhQDPqnglM=;
 b=P3CqzRho6hqeYmUPtyCyhIOk1jRB5Z8g07TJe8pfMHEUZno0N7qo6Ap2nq/oABCjSo4iYeOLQvEo4y+X7Dvp5pYYpqyiicYCyYhtodaweZoLOMRxGFedijbTBgAuifg8mQIMkdxNPwgk+TY5ybqB8y2csSfCXC1piipivgi/Yd6qt7F/FPdeHpZWH5bP0t7QcQ3YR6pmgENgtD0lV3uJ2jlYv2yAzH2FrB9p7621xLVWr1icCVAhleDUl6AWqrMl+ml6jO2ZDCg/xZiT41NdHop9x7jWOrllnpEgEOIbIL0hEarMPrN94GAc1t1l+kIOQkFeNdH1IbucCewX5GD+Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3THnmT3Ve8NsUEWfWUCNEk6dsH3mYtHmlhQDPqnglM=;
 b=xVEvRHqaO/9HSEiJLEAl6BWFV88RU8bNKlrXx4wM7S4JudIVU+Ux8AAOXCLhwU/dOjTxnZfR3u+owhFPzrloUYT2aoC3eSoS+TFZuNznYk0iiCy6usNSJqUYdkvedbWO6nhmaARD0VFlR2y5avqyrgEULUiVhNOwPkgqklL8Qow=
Received: from DM6PR12MB3035.namprd12.prod.outlook.com (2603:10b6:5:3a::24) by
 BL3PR12MB6547.namprd12.prod.outlook.com (2603:10b6:208:38e::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.28; Wed, 8 Mar 2023 03:52:12 +0000
Received: from DM6PR12MB3035.namprd12.prod.outlook.com
 ([fe80::ed0a:df34:1fa5:b78b]) by DM6PR12MB3035.namprd12.prod.outlook.com
 ([fe80::ed0a:df34:1fa5:b78b%7]) with mapi id 15.20.6156.028; Wed, 8 Mar 2023
 03:52:11 +0000
From: "Wang, YuBiao" <YuBiao.Wang@amd.com>
To: "Wang, YuBiao" <YuBiao.Wang@amd.com>, "Tuikov, Luben"
 <Luben.Tuikov@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Force signal hw_fences that are embedded in
 non-sched jobs
Thread-Topic: [PATCH] drm/amdgpu: Force signal hw_fences that are embedded in
 non-sched jobs
Thread-Index: AQHZUMLdKucQLFC+sU2tq5dSgUnmja7u5ZCAgADh5YCAAC4iAIAAOt3ggAANSAA=
Date: Wed, 8 Mar 2023 03:52:11 +0000
Message-ID: <DM6PR12MB3035BD165BEF1429BBA808FAE5B49@DM6PR12MB3035.namprd12.prod.outlook.com>
References: <20230307070231.3807549-1-YuBiao.Wang@amd.com>
 <a38e637d-2cd8-caa0-e27f-4c9b8dc101d0@amd.com>
 <c01e8d00-0565-0015-0e69-ca22260c70c9@amd.com>
 <f7e279a3-f26b-cdb5-ed5b-8aeb2344ac98@amd.com>
 <DM6PR12MB3035880648AE01EEE230DA09E5B49@DM6PR12MB3035.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3035880648AE01EEE230DA09E5B49@DM6PR12MB3035.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Luben.Tuikov@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3035:EE_|BL3PR12MB6547:EE_
x-ms-office365-filtering-correlation-id: 0f07fcab-38dc-49ec-1e4f-08db1f887f79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NEQYRPOKcnp6DRtw9PR94ytrU/eKCSzfpUGy9+cOKCFQPZPpfMcPBZeB9O9040hL9UGPRn5fP4naYTLqVGLq9fE9Ytx7c5fbEKfza+GMIN0V0y8CVVRcNF0yk3UnwUaiv8R7Pt91tkpVEfU3OOdllNhS5voL8Lj1s87OajNHssed4mmf1YaaqUn+uAV7H/PmN2ad6E8rAnzTXc1Ym/tANeCSDT4SH3R40Eva/J9om9s2ySOUGvtVGQd19PffNIJnF585GgQ2R14PNlWbpEV9UXbdv/2KvGHGS6ihlYDS4oLOP00GQyuH2KnSkaDwUbQ+vMXFWopgn4GFwmtSWqIiFNOaHNJAI9ndEm4hp/qPcVGWICx1LQ6xPzciWwDC8lIrbYBlrwLwHQd+qZXC5u4uyBooBCJWyfyV95XuIao55Y6kICuZp9zRYwoIWTosPR3sU3kCzfBfhFsL/2cmNbfyo5vyry6GFSBGoKMZZr3cZ++RoSW08ckT+6dU984k40sbxxJWzD+oTP7gsomhXiEKt2lSAif3YuwpBL3bvVPHG/wDMF3CeVXiA8Dwd32Run7Fdkua0XhtNXoIqm825n/+SZHEIWPMCYxR6oMXxlYUmT1zrF0OF58UF+lVXsYk8/GVNoNkOlbiBUt2CgIgbEIJkhhWRBMvHEDvjwEzY8viu8O2r3BWaH0t25kDkckSh5x8NMPBZmwz4RM0MRy/b5ccMQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3035.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199018)(316002)(110136005)(54906003)(55016003)(83380400001)(86362001)(33656002)(2906002)(64756008)(2940100002)(9686003)(186003)(41300700001)(76116006)(53546011)(5660300002)(26005)(478600001)(66556008)(8676002)(66946007)(66476007)(4326008)(6506007)(66446008)(7696005)(8936002)(71200400001)(122000001)(38100700002)(52536014)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3ZhUC9kUnJuSFN0S3hqNVN4VmhNd0ROdlJ6QTlmSmVxRVlFaDlVZGlWTWJ4?=
 =?utf-8?B?dEpNUVoyMUYwMW5EQm1DRjZtc2VuWXpFdjZBTzRkeEt2M01NZXNhOEFjUTlP?=
 =?utf-8?B?bDRSdkM1UXFoZkNLM3ZnamVycnVSdkhJeDIxcjB2OFlTTDQ5U1F4aENOYVVM?=
 =?utf-8?B?M0VsZUg2OWtaVkxJdTBuVmJqeE5takFTZml5TDg5SkJoODhyRnZPUiszOTk0?=
 =?utf-8?B?UkF4SnQxN0RVdFoxaVh2b1FMOUpJcWc2ZzRhZ3Uxa0llMjBUU3ppN3pBOStD?=
 =?utf-8?B?S1k0MlpMYUxuR1FLZ0dBWG8weTdoQWRma1lPNVlza2U0Vlo4UzdZY1c1dDc5?=
 =?utf-8?B?U1loeno0SUd0Z09YQXNrQ0poMzkvWHBRc2JpTUtKbEU2aksyU0YwcWFjeG1N?=
 =?utf-8?B?WGwzYlVienFKa3dpMjJyYS9aa1JkY2ZiY0Z3OGQ5M3BHb3g1VjV2TW9iMmla?=
 =?utf-8?B?R3hHUCs3R25IemRmWjNhU0h5eVE2SnlNYTFVaFVuZE9wbU0vTWtTNGZDSDlB?=
 =?utf-8?B?UXc0SVUxR0VaSDBGSnJPY0VmN2VRME51dHdETW9RRVI3dXZDYWZPU0ZVSDBU?=
 =?utf-8?B?REdtZFdZaDdZNUYyRnAzWnMvVkVJYVdqelNya3lMMW1vck5OTjZIQ2xaeHcz?=
 =?utf-8?B?OHJZUWkwVWhoWUlDQklIcW10STM1Y3Evek5OU2Jvck4xNHR4RHplNHhBeXFD?=
 =?utf-8?B?TGZGeUJ2bjFZVjF6WS84cFdscjYyVTVqU3ZPc3R1MDBJUzZEdTNoWkJCZ0Jz?=
 =?utf-8?B?SDZGQmNXc2pLWnFMWTZLOWFXSDRHTkM2WWlNMm9hVFVJSUN3SWJSTjBzWXJt?=
 =?utf-8?B?Rm1uVlZCNUQyVFdic1FDT3grLytZZ1FGenZOWUR5SmJSRW8vNW9vWFRpdlBM?=
 =?utf-8?B?WFpCd2ptYWNmRSs3Z0dHSlpjMG5hUXBkRzhvQU9admJTWlFkTkd4bGhTYnJ5?=
 =?utf-8?B?bSthU0pBZ1c4cnJRcFpmbU1TUnA4a0tGZnRkczBLdm56cHpoNzdNTDY1WEFw?=
 =?utf-8?B?RFZLOHBVQlRSejVXU2JFck15NFNrTUZycm9vWU9OMi96NVMzRGlrMy9IQmJ4?=
 =?utf-8?B?K0l1SU1nNzFoSXRmYXJmNUxWSVN0cFl6OEZDelYrZUFjeVN4YWlOSVFZZWZP?=
 =?utf-8?B?NTZvQW1iRjAyd05lejdXaFZoTGJZVTRLL1Qvb2JkZ01VdGtBYzJhQWFSS2VJ?=
 =?utf-8?B?aUdNV3ZXTVloTTVGa0ZYN0VrNFovRnlzL1FwU3o5Zkp2aDMvMlZkWU8vQmln?=
 =?utf-8?B?WnRyWEJpWmF3VTN1cVpnUzlMYno0M2k2T0xkWDBFVmJsWDROQVBkMEpRNEhL?=
 =?utf-8?B?aFpLL2h2UUFNbjY0ZjZsK04zOGQ3WTAxWlg1T2VZYk5mendzWWtHQzNxRnlX?=
 =?utf-8?B?d3Zzc2FRaUJwNDBBcU1UOEhEOStWbnMxSVNQY2VWWHJFb1V4S2pobWJkTU5i?=
 =?utf-8?B?MUttMEJ4ZkJzU0FibldZMnNnaFpwUGhwVlVuaUJudWgvZGNEL0VzSVljK3V6?=
 =?utf-8?B?alJZWFh2UlRFcG4xU2RMVnE0NkpxeGMxWUlrRzdobW80a2lySmZIUk5uTzFL?=
 =?utf-8?B?RFFIZGEyTE5qNUFXUDd3dm9ZejYrZWZ4M244MDB3d2JZL0x6Ym43ZjhxaWxV?=
 =?utf-8?B?T2hyTmRuTk84bHc3SlhLS3pJZE9FaVV4RHdlVDJ3clh1WGMrZ29NVlVXdGky?=
 =?utf-8?B?MFpmUnJIcGUvVkRmVEY3RjVsN3RoWHYxQk92dWlFR3N3V2VIakx0b3FyZXVj?=
 =?utf-8?B?QWlJaGtrZklYSXdiYVY3NytzZ0VZUGZONDVHTmFzK242d3hPZlZ0cFlRVG5o?=
 =?utf-8?B?REUvQTczd3BMeHVQdVBYQW1UR2xCMG5NaGtvdFVOblpMbExOS0s5d092Snlu?=
 =?utf-8?B?Z3lpcDBzaVdjeTR6bmhNQXJwbGJNT2JKNW1ncXNqVnExQ0FmRFMwWTlORWt5?=
 =?utf-8?B?UUJpdVN6a1JRb0NtVi9vd2JFUjZ4NXUxaFZUdHVLd3QyK1FlN1lraG1XWUx1?=
 =?utf-8?B?Z2IydnFOS3lDTkE4bm5uNmc1WnVTd3pSSW5hWFFuQ3FvWm1JMmtFbXBPMWg1?=
 =?utf-8?B?K2R0cWQzK3ZCb0ptZjRMRTdrVjJURGk0bmFnc1VaZ0NCdTdDTDhxalppNVFU?=
 =?utf-8?Q?qC9wYvuI5YX37yV9hpSKyVpf8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3035.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f07fcab-38dc-49ec-1e4f-08db1f887f79
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 03:52:11.7245 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6L31cXhe7cN8zrgefYea8IaIzffZOqzrv304ivTQho3FF9SA0X1vENQ9/ycow3MiRy1q59latAx1ZEiXT0vwwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6547
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
Cc: "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgQFR1aWtvdiwgTHViZW4sDQoNCj4+ID4+IHdlIGhhdmUgdG8gZm9yY2Ugc2lnbmFsIHRoZSBu
b25fc2NoZWQgYmFkIGpvYidzIGZlbmNlIGR1cmluZyANCj4+ID4+IHByZV9hc2ljX3Jlc2V0IG9y
IHRoZSBjbGVhciBpcyBub3QgY29tcGxldGUuDQo+PkRvIHlvdSB3YW50IHRvIGFkZCBhIGZ1bmN0
aW9uIHdoaWNoIGRvZXMganVzdCB0aGlzIChzaWduYWxzIG5vbi1zY2hlZHVsZXIgam9iIGZlbmNl
cykgaW4gYW1kZ3B1X2RldmljZV9wcmVfYXNpY19yZXNldCgpLCBhbmQgcmVzdWJtaXQgeW91ciBw
YXRjaD8gKFRoZXJlIHdpbGwgYmUgY29kZSByZWR1bmRhbmN5LCBidXQgbWF5IG1ha2UgdGhlIHBv
aW50IGNsZWFyZXIuKQ0KDQpPbiBzZWNvbmQgdGhvdWdodCwgd2UgY2Fubm90IG1vdmUgdGhpcyBw
YXJ0IG91dCBvZiBhbWRncHVfZmVuY2VfZHJpdmVyX2NsZWFyX2pvYl9mZW5jZXMsIGJlY2F1c2Ug
aXQgY2xlYXJzIHBvaW50ZXIgZnJvbSBSQ1UgYW5kIGFmdGVyIHRoYXQgb25seSBOVUxMIGFuZCB2
bSBmbHVzaCBmZW5jZSBhcmUgbGVmdCBpbiBmZW5jZSBkcnYsIHdoaWNoIGlzIGRlc2lnbmVkIGZv
ciByZWFzb24gSSdtIG5vdCBhd2FyZSBvZi4gVGhpcyBpcyBhbHNvIHdoeSBhbWRncHVfZmVuY2Vf
ZHJpdmVyX2ZvcmNlX2NvbXBsZXRpb24gZG9lc24ndCBoYW5kbGUgdGhlIGliIHRlc3QgYmFkIGpv
YnMgZHVyaW5nIHByZV9hc2ljX3Jlc2V0LiBTbyBldmVuIGlmIEkgYWRkIGEgbmV3IGZ1bmN0aW9u
IEkgY2Fubm90IG1vdmUgaXQgdG8gcHJlX2FzaWNfcmVzZXQgYXMgYSBzaW5nbGUgc3RlcC4gQWxz
byBpdCBtYXkgYmUgY29uZnVzaW5nIHNpbmNlIHRoZSBuYW1lIGFuZCBkZXNjcmlwdGlvbiBjb3Vs
ZCBiZSB2ZXJ5IGNsb3NlZCB0byBhbWRncHVfZmVuY2VfZHJpdmVyX2ZvcmNlX2NvbXBsZXRpb24u
DQpTbyByYXRoZXIgdGhhbiBhZGRpbmcgYSBmdW5jdGlvbiwgaXMgaXQgb2sgdG8ganVzdCBhZGQg
YSBjb21tZW50Pw0KDQpSZWdhcmRzICYgVGhhbmtzLA0KWXViaWFvDQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgV2FuZywgWXVCaWFvDQpTZW50OiBXZWRuZXNkYXksIE1h
cmNoIDgsIDIwMjMgMTE6MDkgQU0NClRvOiBUdWlrb3YsIEx1YmVuIDxMdWJlbi5UdWlrb3ZAYW1k
LmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllh
bmcuV2FuZ0BhbWQuY29tPjsgWHUsIEZlaWZlaSA8RmVpZmVpLlh1QGFtZC5jb20+OyBDaGVuLCBI
b3JhY2UgPEhvcmFjZS5DaGVuQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+OyBMaXUsIE1vbmsgPE1vbmsuTGl1QGFtZC5jb20+OyBaaGFuZywg
SGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KU3ViamVjdDogUkU6IFtQQVRDSF0gZHJt
L2FtZGdwdTogRm9yY2Ugc2lnbmFsIGh3X2ZlbmNlcyB0aGF0IGFyZSBlbWJlZGRlZCBpbiBub24t
c2NoZWQgam9icw0KDQpIaSBMdWJlbiwNCg0KSSB3YXMgY29tcGFyaW5nIHRoZSBiYWQgam9icyBv
ZiBmYWlsZWQgaWIgdGVzdCBhbmQgdGhlIG9uZXMgdGhhdCBjYXVzZXMgdGhlIFREUiwgYW5kIEkg
dGhpbmsgdGhlIG1haW4gZGlmZmVyZW5jZSBpcyB3aGV0aGVyIGl0IGlzIHN1Ym1pdHRlZCB2aWEg
ZHJtX3NjaGVkIG9yIG5vdC4gSW4gc2ltcGxlIHRlc3QgY2FzZXMgaXQgZG9lc24ndCBzZWVtIHRv
IGluY29ycmVjdGx5IHNpZ25hbCB0aGUgZmVuY2VzIHRoYXQgc2hvdWxkbid0IGJlIHNpZ25hbGVk
LiBXZSBpbmRlZWQgbWF5IG5lZWQgbW9yZSBoZWF2aWVyIHRlc3RzIGJ1dCBzbyBmYXIgYmFzZWQg
b24gc3RhdGljIGFuYWx5emUgSSB0aGluayBJIGRpZG4ndCBub3RpY2UgdGhlIGNhc2UgeW91IG1l
bnRpb25lZC4gVGhlcmUncyBhbm90aGVyIGNhc2UgdXNpbmcgZGlyZWN0IGpvYiBzdWJtaXNzaW9u
IGR1cmluZyByZXNldGUsIGJ1dCBpdCBoYXBwZW5zIGluIHJlY292ZXJfdnJhbSB3aGljaCBoYXBw
ZW5zIGFmdGVyIHRoZSBwcmVfYXNpYyByZXNldCBzbyBJIHRoaW5rIGl0IHdvbuKAmXQgYmUgYWZm
ZWN0ZWQuDQoNCkknbGwgbW92ZSB0aGlzIGxpbmVzIGludG8gYSBuZXcgZnVuY3Rpb24gYXMgeW91
IHN1Z2dlc3RlZCBhbmQgcmVzZW50IGEgdjIgcGF0Y2guDQoNClJlZ2FyZHMsDQpZdWJpYW8gV2Fu
Zw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogVHVpa292LCBMdWJlbiA8THVi
ZW4uVHVpa292QGFtZC5jb20+IA0KU2VudDogV2VkbmVzZGF5LCBNYXJjaCA4LCAyMDIzIDc6MjIg
QU0NClRvOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgV2Fu
ZywgWXVCaWFvIDxZdUJpYW8uV2FuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcNCkNjOiBDaGVuLCBIb3JhY2UgPEhvcmFjZS5DaGVuQGFtZC5jb20+OyBEZXVjaGVyLCBB
bGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBaaGFuZywgSGF3a2luZyA8SGF3
a2luZy5aaGFuZ0BhbWQuY29tPjsgTGl1LCBNb25rIDxNb25rLkxpdUBhbWQuY29tPjsgWHUsIEZl
aWZlaSA8RmVpZmVpLlh1QGFtZC5jb20+OyBXYW5nLCBZYW5nKEtldmluKSA8S2V2aW5ZYW5nLldh
bmdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IEZvcmNlIHNpZ25h
bCBod19mZW5jZXMgdGhhdCBhcmUgZW1iZWRkZWQgaW4gbm9uLXNjaGVkIGpvYnMNCg0KT24gMjAy
My0wMy0wNyAxNTozNiwgTHViZW4gVHVpa292IHdyb3RlOg0KPiArCQkJam9iID0gY29udGFpbmVy
X29mKG9sZCwgc3RydWN0IGFtZGdwdV9qb2IsIGh3X2ZlbmNlKTsNCj4gKwkJCWlmICgham9iLT5i
YXNlLnNfZmVuY2UgJiYgIWRtYV9mZW5jZV9pc19zaWduYWxlZChvbGQpKQ0KPiArCQkJCWRtYV9m
ZW5jZV9zaWduYWwob2xkKTsNCg0KVGhpbmtpbmcgYWJvdXQgdGhpcyBtb3JlLCBpcyAham9iLT5i
YXNlLnNfZmVuY2UgY29uZGl0aW9uIGhlcmUgZW5vdWdoIHRvIG1lYW4gIm5vbi1zY2hlZCBqb2Jz
IGxpa2UgaWJfdGVzdCI/DQoNCkkgZmVlbCB0aGF0IGl0IGlzIGEgYml0IG92ZXJsb2FkZWQgaGVy
ZS0tY291bGQgd2UgaGF2ZSB0aGlzIGNvbmRpdGlvbiBzYXRpc2ZpZWQseWV0IHdlIGNhbid0IHdp
bGx5LW5pbGx5IHNpZ25hbCB0aGUgZmVuY2UgaGVyZT8NCi0tDQpSZWdhcmRzLA0KTHViZW4NCg0K
