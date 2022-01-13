Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64746C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 14:23:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07EE410E308;
	Thu, 13 Jan 2022 14:23:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42E6510E2B1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 14:23:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c70W5WxMlOzWZmmLN4mtbTyJ7oO8ijQ3P4sWgf5/p6BQ7yxEhaZsOhWFC9+IFNHd6vzv/8iQyahLqimR9kpVLuCazq7TjIM7UYRSUhYasndqnQg/X8eEP4BOHdK9vnoe6aNQ1DYlFyCSawooxBX/ZJhrcRVRsvw5Y+sbBdcoeT4YdnvXfiE+fXZiZJyZAJEqvvYyWjkA17lmAMYWjboiuxi1ijaC0CNuxrJAD4FiICyrawab1markkcEIHFJRXVi5sBVHQ9fxawQWCzR/I6wlBFbO+HWYiER2wDKw9N4MbzUKlawOoZhJ055qM81/+Eq+5X8OHBmXRpxXTdszX6CYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZFDjmeFrgvdS7Mev4+J3tsbG942JWZ9swvaCvxFBug=;
 b=PzYRWalDTRWeJ8U9QVXmYFXxNEA1oKkGAAZn9Oxuuq2D4ADEAmFZAcPg2RODKKO25/1wfxRMTa5zeB3kUHZAmIz0rub8NLbKCB02llTMr1UtC9rR12MYQmiHf/jx+2slbCLmoVPMER578MX7lyppHcyS5LkdT0ol6TA/opoc3uFFqpQsY5c2vMws6BS1HFt/httEvFrtdl7EyDJpr4IBe+4/W0a1LOIzK2Evd8Ny5TDnAqTDYi1RJEL9lSl8ZtzsCgH3Igsl+uLyRE+BZ+n69CHyTc8sQnFRf8ZRVUVrHawD03xKIxgQ9EhLJ4YUSbhQSA1DMKBwycnn3nN4VMtN7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZFDjmeFrgvdS7Mev4+J3tsbG942JWZ9swvaCvxFBug=;
 b=2GODWXcnqYRev2CFBks6wNoAS9AFZuXYkPKvT5GVbaHUvpvyHU55ULayr27d74OIx/qDBjzabwwBeKZdnYjMqSqx4PYfR9bbg+iCktpIpvYzWSZJgK7Qre0pmZxYUaNQDVF1QpIs3xcsjOox+gNFh9d+DEgYP92Lx24Tsx1BdFQ=
Received: from DM6PR12MB2697.namprd12.prod.outlook.com (2603:10b6:5:49::18) by
 CH2PR12MB5001.namprd12.prod.outlook.com (2603:10b6:610:61::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Thu, 13 Jan 2022 14:23:26 +0000
Received: from DM6PR12MB2697.namprd12.prod.outlook.com
 ([fe80::826:6121:7c05:4ba2]) by DM6PR12MB2697.namprd12.prod.outlook.com
 ([fe80::826:6121:7c05:4ba2%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 14:23:25 +0000
From: "Gopalakrishnan, Veerabadhran (Veera)"
 <Veerabadhran.Gopalakrishnan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Chen, Guchun" <Guchun.Chen@amd.com>
Subject: RE: [PATCH] tests/amdgpu: Add VCN test support for Biege Goby
Thread-Topic: [PATCH] tests/amdgpu: Add VCN test support for Biege Goby
Thread-Index: AQHYCIUyJuXEeAjAxkK+1cFu2gcMtqxg/3iAgAABWiA=
Date: Thu, 13 Jan 2022 14:23:25 +0000
Message-ID: <DM6PR12MB2697395C8960E703D53849E4FA539@DM6PR12MB2697.namprd12.prod.outlook.com>
References: <20220113135457.17020-1-guchun.chen@amd.com>
 <CADnq5_Ox2AHL3oTduu59mauQf2aW_MKLfxSfzfcW1bOwUHWWnw@mail.gmail.com>
In-Reply-To: <CADnq5_Ox2AHL3oTduu59mauQf2aW_MKLfxSfzfcW1bOwUHWWnw@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-13T14:22:02Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=2893333e-04b3-4c39-a7f6-09787bf7edde;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-13T14:23:22Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: bedb931d-692d-4284-a15a-5a37090f1dd2
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a0177c1-f72f-4025-5e65-08d9d6a04309
x-ms-traffictypediagnostic: CH2PR12MB5001:EE_
x-microsoft-antispam-prvs: <CH2PR12MB50010C74211DDF6FC3D965ACFA539@CH2PR12MB5001.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:207;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qYtHlXBv/llWmKzAEwDIDjhuSFlJncag27pyKaxf103doHSl12pioCiG1VWOz+fO+Mw6pDI3UehvhIjCJapOByKbsjOLomJDale0kIPrwdqhra+jx47s7MxVyn5FwJCHSH9hv0GegzyE/0+7IZNV0qBiYVTNwy4/0XSKt/PqSR54nsrgeqZ2b8yftOxKVBIaVl74Z7uW9ZqolbFWqmpWQmxnMhIVIFRGIxJKtIOcU3F4oqCMqLK+6tMcvq6axWl9vxnVZ1CqYkLBr2XtcBQLfe0BeyT/GG5WQm5yFc86AP/nFnCB0Cb40DiiHO+yAGzEMX2AsZ5cJOm4PoE/+DbgtM05/blKi/Mqvu+u8uc5m4Tz0KYMMjUM43v+E0Fl0VVBxCZqsxcUN5m30MzhzoZdfCwMIM4d+Erdu9gG826au+NYpEBb6l5TRJ7b8NfkPoxU9CfNMZR50Vv/KvuBV7y2/OfbVnGrkP/yYij9v1xPm0P6tYdAVFyZCTJSfrbXrUyRA1w9AEiZPgAz2laC1KIldSQDxkDICcnNjk1gGNc2oy37CWXXL3q+L6Uli9COx9ZAacAEYEkKyRPHjvG3u8NkIBnJ47A3f27gX3hApbjE+g3b+c2RH0edY6TiSIToryXBE2vuqm1JOiZU1WZ/+EXwcTkBo1mCZplhAwDHBcfVW2GDABqywWP9dIc+HuIX8oJ6hF5z/4Kcu1Sej+yzilP/rA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(508600001)(4326008)(9686003)(64756008)(66946007)(76116006)(66476007)(66556008)(66446008)(52536014)(55016003)(110136005)(122000001)(71200400001)(186003)(54906003)(6636002)(2906002)(83380400001)(26005)(38100700002)(8936002)(8676002)(33656002)(7696005)(86362001)(6506007)(38070700005)(53546011)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bStuY1Jzb2RHallMTTNvSXFpbXhPUUV5eHM1YWdwY1ZSQjA0Y3N5cUdMSmRV?=
 =?utf-8?B?QmF3em1TTis3YjVsdzc4UXRlbTFrWnVyc1JhaDZrOTBFOTFuZXc4UlRjeDBQ?=
 =?utf-8?B?M3RUWExpaTU3U0hqMzAwT1lUQ24yb3FvejRiZHJTRnl0cUlVblN1VUVOdlBn?=
 =?utf-8?B?eExFcnF5aGhWdkpIUjRrY2ZESlArSVVLV2U3WXdKZVRhVzd4ZjltUUcrU2VU?=
 =?utf-8?B?SDU4REcyMHRqblZzR05jRU5kcWJucWJpd3g5VlFHTjhodVIwdE50cEpHeU1m?=
 =?utf-8?B?YTJESElia3Vjd1cyV25xMWlkZkRnZ29DeWp4cHpqdzZxTmVQRlJHMllKNGVM?=
 =?utf-8?B?cytVYmRrUVZsam5TK3hPMitZVkROSkxJM1VORXJGaUg3a0ZWWGZ5a0l6anQ1?=
 =?utf-8?B?dWZYMUJJc3ZGSmVZWnNRQWZ6cHlYWi9EdTAvcmtqUVRCZEpXd0M5MmQ4RXFs?=
 =?utf-8?B?NDAvT0hsU0oyenJaZHpVT2VzTkNOUXpBZlNkcVd2NTBRVStmdVJneCs4Q1Z3?=
 =?utf-8?B?REt6Z2thY2VQRkxwWXVFclZLZCtrcEljdU4wWTFaWVF1b1hYR0dIdFl0UWtr?=
 =?utf-8?B?eDBOVkw4R0pvbWZMZmI2Z1Zwc1BrcTZ4UE50aHU3UytwZy9ZT3lTa3dqMHho?=
 =?utf-8?B?LzBSTDhvbEM4OGRLUDcxYkVVZ2dDVWxxd0RjVThBcUhjNU1jTXRjdDNWMVF6?=
 =?utf-8?B?Qm9WMmZYQkQ2dkkyUExQNzFwalZvU2pGVkVEUVlSeWNiekNkYUdsYkpydmQ3?=
 =?utf-8?B?LzVpdjhBcVBvQms3SXZvSDBUYUdLOGxwcnpvUGR0VmdXNmFhR09INU1VTlRm?=
 =?utf-8?B?T21CdVAvengvY2NJRzlBckI1V3ZtelBzQ3NiL043N3VQcHlqQktPbkFCRDNF?=
 =?utf-8?B?RTJMRWJPVVU5ZVl6V0VoSWMwOUF5M29NTnZlY0FiT2pVSkN6U3RLc0xiYXFR?=
 =?utf-8?B?d05vTGNmMHR0WkhYMTREa2Q2OEV2TlJTK3QxZkFabGtBdVBkMzY1OFFTQTUw?=
 =?utf-8?B?UFZsUDNCeU1SbjRmY0NONVhkcXBTTkhIeVRIL2QzT295bzlBZlYwb1RHRktr?=
 =?utf-8?B?dzk4eEJ5cWtNNE5nRlVTRC85YXN1Y01IaGNURndxWjRJVXpITVpFNkV6WExk?=
 =?utf-8?B?aXZlQ21tMnZ5U1lZdFh5T1VNUWkxUkNaV29mZGFGamF6WEdhRkFXZXBqSUt0?=
 =?utf-8?B?V0RPbXBkdWdNUEF0UThOWHdNRlBhaElDNjZtb1puQ1I1bEtOUk5ReEFxQ3Js?=
 =?utf-8?B?Nk44SUZLTzlTRmM5RlVEZVBDRzRBc2FLYzJRVlZ0aHhkNXVZckp4dkJDQWR5?=
 =?utf-8?B?d0FhM2ZKVDFWdmRIOXEzZVY0RXFJanJZWnVxaUlJTnRQZ2xKUnUxcncrejBz?=
 =?utf-8?B?Y28xVE1XeENMdVBERVVOSWV3REtNamJRaTVhOEVyR3I1R0cyMTNIb0NCZEdF?=
 =?utf-8?B?cVNGem84K3ZpV3dDdTF4dEs2anNqL1pJSXluNElYQXFiYjFOdzNVVFB0cDky?=
 =?utf-8?B?Y25FWmpOUXAxRk96YnJHRzhSVU9oNnNTRFVqS2U0OG1ORmZoTCs3YTcrNUgv?=
 =?utf-8?B?VXdYOE9yZGwzMWxESHhGcHFOMVRjTHV4M29JSkpYRDZWUTB6UUFsdi9FN1Q5?=
 =?utf-8?B?YjFiOU1IUU9SQmZtU3VOUFlNZmlTaXVBTGdiUlNmKzFjaEl3T0phdGNiK1Ir?=
 =?utf-8?B?NkRwN1JlRjdlN3pKKyt3NlZib3hSdnFHZ3JJYktHSGhWZEpSdXh5TDlSSVF0?=
 =?utf-8?B?ZVU4QXc0VnhSUXlvK3I1TVJaVmRlcktwY1lFQ0c3RFlsM0llRHJXbVE0dFA4?=
 =?utf-8?B?ZHZ0QjFMOGJOdW1lU0x6Zklnb0hTVUg0OXZTVUJkSWRQai9Oek9SNEhLSk9k?=
 =?utf-8?B?Z2U4YjdsWmJZUXJyYUJrR0VyaHlhZ0Y0ckFZKzZkNmJiYVA0a0tXK0FFV1dX?=
 =?utf-8?B?aDRnYU8xNFhobElhY1NXYVlLdVRicFJhWit2cml6MkE0VE95ZE9FR0phY2lR?=
 =?utf-8?B?cFQ0elppZVlSRHhPVkxwdTVSVTF1aHdJSnMwRXRCT2xUMnlZUlNWQjZrTFZZ?=
 =?utf-8?B?bFdGN1kyUVRwRmlpZnRKcFdaZFdBMENnV0JCNGVhZWNOUEZObSs0WC81RW9Q?=
 =?utf-8?B?aEdpYW9EY2txMWhQeTRVUjFlOVVVcXpwM1VRZ2U0dEJmelNUcTlqbm9SZDFZ?=
 =?utf-8?B?RlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0177c1-f72f-4025-5e65-08d9d6a04309
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2022 14:23:25.5872 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JpfYiHb2Fifa4LIvjU1EMrGjXcscwMwegZRp41aibrExu1vjDJqaVGwatkfJTPiY4rDgDC2NgIag3vlYSR6yYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5001
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu,
 Leo" <Leo.Liu@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KUmV2aWV3ZWQtQnk6IFZlZXJhYmFkaHJhbiBHb3Bh
bGFrcmlzaG5hbiA8VmVlcmFiYWRocmFuLmdvcGFsYWtyaXNobmFuQGFtZC5jb20+DQoNCi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdt
YWlsLmNvbT4gDQpTZW50OiBUaHVyc2RheSwgSmFudWFyeSAxMywgMjAyMiA3OjQ3IFBNDQpUbzog
Q2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPg0KQ2M6IGFtZC1nZnggbGlzdCA8YW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+OyBHb3BhbGFrcmlzaG5hbiwgVmVlcmFiYWRocmFuIChWZWVyYSkg
PFZlZXJhYmFkaHJhbi5Hb3BhbGFrcmlzaG5hbkBhbWQuY29tPjsgTGl1LCBMZW8gPExlby5MaXVA
YW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIHRlc3RzL2FtZGdwdTogQWRkIFZDTiB0ZXN0
IHN1cHBvcnQgZm9yIEJpZWdlIEdvYnkNCg0KQWNrZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFu
ZGVyLmRldWNoZXJAYW1kLmNvbT4NCg0KT24gVGh1LCBKYW4gMTMsIDIwMjIgYXQgODo1NSBBTSBH
dWNodW4gQ2hlbiA8Z3VjaHVuLmNoZW5AYW1kLmNvbT4gd3JvdGU6DQo+DQo+IEFkZGVkIEJlaWdl
IEdvYnkgY2hpcCBpZCBpbiB2Y24gdGVzdCwgd2lsbCBvcGVuIGEgTVIgdG8gbWVyZ2UgdGhpcyBv
biANCj4gZ2l0bGFiIGFmdGVyIHJldmlldy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogR3VjaHVuIENo
ZW4gPGd1Y2h1bi5jaGVuQGFtZC5jb20+DQo+IC0tLQ0KPiAgdGVzdHMvYW1kZ3B1L3Zjbl90ZXN0
cy5jIHwgMyArKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL2FtZGdwdS92Y25fdGVzdHMuYyBiL3Rlc3Rz
L2FtZGdwdS92Y25fdGVzdHMuYyBpbmRleCANCj4gNjI4YjQ5MTAuLjE1ZDU3M2QzIDEwMDY0NA0K
PiAtLS0gYS90ZXN0cy9hbWRncHUvdmNuX3Rlc3RzLmMNCj4gKysrIGIvdGVzdHMvYW1kZ3B1L3Zj
bl90ZXN0cy5jDQo+IEBAIC0xNDIsNyArMTQyLDggQEAgQ1VfQk9PTCBzdWl0ZV92Y25fdGVzdHNf
ZW5hYmxlKHZvaWQpDQo+ICAgICAgICAgfSBlbHNlIGlmIChmYW1pbHlfaWQgPT0gQU1ER1BVX0ZB
TUlMWV9OVikgew0KPiAgICAgICAgICAgICAgICAgaWYgKGNoaXBfaWQgPT0gKGNoaXBfcmV2ICsg
MHgyOCkgfHwNCj4gICAgICAgICAgICAgICAgICAgICBjaGlwX2lkID09IChjaGlwX3JldiArIDB4
MzIpIHx8DQo+IC0gICAgICAgICAgICAgICAgICAgY2hpcF9pZCA9PSAoY2hpcF9yZXYgKyAweDNj
KSkgew0KPiArICAgICAgICAgICAgICAgICAgIGNoaXBfaWQgPT0gKGNoaXBfcmV2ICsgMHgzYykg
fHwNCj4gKyAgICAgICAgICAgICAgICAgICBjaGlwX2lkID09IChjaGlwX3JldiArIDB4NDYpKSB7
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHJlZy5kYXRhMCA9IDB4MTA7DQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgIHJlZy5kYXRhMSA9IDB4MTE7DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIHJlZy5jbWQgPSAweGY7DQo+IC0tDQo+IDIuMTcuMQ0KPg0K
