Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7ECC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 03:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1037210E375;
	Fri, 21 Jan 2022 03:16:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 006BD10E375
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 03:16:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnGawCz2qU+mv3g0ziUWlzgcraX6Kezdp5ZzM3KrYZLdGbgjuYuuZ4EJa3zrYj2TdceOt5I2GyVbo787Ql/mMh9l4lPJ5C5oRM0dzAzqu1wmgG59Y+lnM2uil71WnJQ/W7h0U4JMZuFsrJToW0yGS4u0L/ice5OTGmOtHiA97f9zUv8Xbqg7UavINjKVN1UBIWRcUAT8mH9NgNgJaG6pTPn+rZba0UGL1AxcsKbf0iuMWlVRZY4o0OixpL4/CopYvldH6Xi58myKHpYnuvv7hihdYl5eTaGe65AWUhvvXlzNogPe/WvRdrm/m+Ta/qw3cSNIsE3G/mv5hBKvqFzlYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ezB0k5lIONx6bUPWGWavgjF3qyJQalKWdOd9XsmrvU=;
 b=Ln6s41gVOFkfDnLMtcERUHUJh7j5WrisAiu/ka0JzFdLuD0l+8DGXnzIZZ8M9591wYG81jbGBTH8LB+ATvIu3xE9+7u1r4aWGHYQhUPP75hgAfq8epBQ3U3d1iXpPNSolwlnxa24Iwxc5jJHTv+6/zV+10cfNdJc5JntHIPLKTvFxHkAtl0GM0aPOawyGuv5BECfByy+JspamuFNuOCOhvd8Z9zTqAfsFQ2vUv3KugdoxTSyEyEQO5b93byp6wQb3crf5xwxs4hl6J/iR1p9X9XwmJeqJ9V8InJolxIxxbcPRP9NUJQfnUUW7+liPBLtaPo76v199LwhP6fnYowRFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ezB0k5lIONx6bUPWGWavgjF3qyJQalKWdOd9XsmrvU=;
 b=O94b7PwJoCc8QcEOgOrAni+jg1sffh5bT/mmrXX6AZClExJzClpSUMNBGSxIOm+d/yFjS2FeYREXhJ5UnyjPmCohFPsxvjn/qbE39iGJoaT2jdUGVKV50eeitLjLAuNeZR1mP81cUHzM3WL7xVqzkTz31tz5JXCzqDOhNiV1l1Y=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by BYAPR12MB2760.namprd12.prod.outlook.com (2603:10b6:a03:72::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Fri, 21 Jan
 2022 03:16:26 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::2dcd:d54f:4409:f1ff]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::2dcd:d54f:4409:f1ff%7]) with mapi id 15.20.4909.008; Fri, 21 Jan 2022
 03:16:26 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix kernel compilation; style
Thread-Topic: [PATCH] drm/amdgpu: Fix kernel compilation; style
Thread-Index: AQHYDljOl+hFpxY5T0CVIHAYdg+4rqxszZBA
Date: Fri, 21 Jan 2022 03:16:26 +0000
Message-ID: <CH0PR12MB53721B0B631F450589BFBE20F45B9@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20220120235227.90683-1-luben.tuikov@amd.com>
In-Reply-To: <20220120235227.90683-1-luben.tuikov@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-21T03:16:24Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=3eab39da-dd30-4651-8754-eda30969e760;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-21T03:16:24Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: e9ffad07-320a-46ac-89a1-63ac009ec04a
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9344cec3-9f13-48c1-5ff9-08d9dc8c6908
x-ms-traffictypediagnostic: BYAPR12MB2760:EE_
x-microsoft-antispam-prvs: <BYAPR12MB276012502FB4917226C92FD9F45B9@BYAPR12MB2760.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hWA3IrHAAy5hQVdT8S00/V5kIY7afmjcg530GFEYjn8UVy+sKaqxdkoTHfYqggRQ/h+TzGpoiw1Ple0LYAGnesDPl31UAvODfcMKrcTPGuiB1m3jJV8KgRYL/H3q1R95pPzAEjKkAkOYaMg7EmRiPJ7v007p6m88n6xSON9Jvn6EoI9kGb27kkj+DMtQZNa1C22kcFGVVcsM+L+42w2xTI85y53xT6lF2zgSkY3+wzf0pKeD9D06uQ0Z6fV9bTj6Lzu7p9mDHEO7VBcVTMJoZ/OLjVE5NXKp+YWRMtq6GkWkJySEq+fK5/NTVHTqtiGNzEyYjao0wP22/x+z6pN+/G/xzYdlxY9o3mNj7P6nqr+pvJBYXMk91QKSbx3KpCAn9Om5WAc/bG2pvilznJYvuD7kyY+1hHg8jx1dH7VdP56YHhK81UeASkyMbpJVW481gqF+zQZ3wROqDI0tR98wLe+RtC5jcYG1biY7/sdTcO4zEzwCbXj5hZ4EyHXOobKVveQ7MScYT1qNERYapER2UP/OICRIaw6iefPhMIyN5it9dWf/aMF76MD6ycIbJtfVDckVDF+jx1cy493lnIp4IczJRgycnXZHVR+XcsEkcfFHpTtzZsRNAgn6XCKfi5XgOit74LBe+jttvxrCHrV8MDYjKDqsz+Gy0Ogw58TqvOm0t12PUqcIDAu4W0OsflTx3TIl3NJuDLnzuEeZmfwBUQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(122000001)(9686003)(55016003)(54906003)(38070700005)(508600001)(4326008)(316002)(110136005)(186003)(26005)(83380400001)(66476007)(66556008)(66446008)(66946007)(7696005)(33656002)(2906002)(8936002)(53546011)(6506007)(71200400001)(64756008)(76116006)(52536014)(38100700002)(5660300002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkZPMnJ3S2dLUVlYZVpQUGdXa3hienpZRm9ja0RvZHhvNGYzY0J6bVJuTlRG?=
 =?utf-8?B?YjlLRTdRY0xRM1dtQTNkQ2NuQVZ3U2ZVYW95RlNFbGtXcnc1eUdWUENRUXl2?=
 =?utf-8?B?QTIyaHB5WVlOczRJM2EvQm9mMVZiWkFaZ2tlcmFGeWwydEdQRE1OenlNWXRN?=
 =?utf-8?B?VGgrNW9pb2hpWFB1cHBHV2hZSDdaTFUwSG10T2dkVjMyTDNLUGZrQ25XR2U4?=
 =?utf-8?B?c0UvUlA4RHVzd0JCbDgxeEhLNTVGSVZveko4THpldGxGckUwSnVMZSs2aXZp?=
 =?utf-8?B?dmtuUzVUZHlVVEovMUNNRStBTUkzREhiaDl5dmoraUgxNUVnL1JNOUFCb2o2?=
 =?utf-8?B?cGNzVDF6djVua3REdHNkWW9jQml1eUxVTkMrdGFxNER6a1NuUDE3dUU2bC9k?=
 =?utf-8?B?MGZMUEZCRjJ2aDcwbkhQekcrcDJ4MEZmcmJQZ3A0QXRUWmpENUlxV2NkR01R?=
 =?utf-8?B?ZHBiemJJUnI3L1VycjhMMU14d2FWMnh5UFZ5RDUxckk0YVFVVXVEQ3NYL0ZK?=
 =?utf-8?B?eEdPYURZS3VvRVhQL3hmckl5aGRPZ3dueFltSEcyK1ZrSXZIei8rVnNPK1hI?=
 =?utf-8?B?SlM2em5manhQRE0vd2dDKzJoM0k4QzdodEJmNktDRUZBY1NOOENSUW5PTExm?=
 =?utf-8?B?cldkdjN4ZXd3cGF3dCtDRDFLVGF3dXZjSTlFeGgzalpDKzM3dElzVEc2bkNG?=
 =?utf-8?B?UmJ0akZRVlZOa0cwUVB1REpvUEw2WXlTbnVWMUNBWlptUFdBdWE4dmVET09D?=
 =?utf-8?B?WmZxb2NVaXZ2N0ZUNjdlWlgrbnR5aFpHTjkydmEwWkxTaHNBZjNoRFZKYjds?=
 =?utf-8?B?S2t3d2VZT21VOURYWnpTWWdyaUVzemNXbHV5MmVlUUxQL1BBajhpWnVyVFUy?=
 =?utf-8?B?SVN5TTlmaFUyWTd0QW5sOGlrTVdOQ1VzKzNPNHhScndvTkFaRG92dDZ1M05h?=
 =?utf-8?B?MExhanp3VDVwY2dpc1ZidlJUWG5US252RHl1Tkk5R2JxQVluRVVZUmhnWEhW?=
 =?utf-8?B?SXBvNmJEN3ZnaU1yRVIwNEtGS2N2ZkdDdXdSS0lVN3FYNWtBZ2w0S0tIQXFT?=
 =?utf-8?B?aGZFVjAzcGhnMFZpeGpISVpsT3ZQWkZIaXNSMG52UkUzUHBCNmgxYWxNZnVX?=
 =?utf-8?B?S3RVQzlZOUdxcnlCdVhpWStIdzluNUw5QVV5aklBcm4ySnd6ZmtOVHFzbVBR?=
 =?utf-8?B?NzJCRVNOaktSWUpOSk9RSms1cVp1ZHFSOUxTMW40a1Fyc1RjWEY0S1J1UFlQ?=
 =?utf-8?B?SXQzRm50Y2Z5Zy83WC9hNVZ4d3dmSlo2cytwdCtvTFU0YzBiUzJRdEk0QnBF?=
 =?utf-8?B?WHltSEtaU0VmOUJId0g1VW00ajUrVlF2MDFydCtlaHVNSSsxT1VEa0hYbE9V?=
 =?utf-8?B?cWxDS29wNDhZdVBienJnVGFtR1l4R1l2Q1puaGs0Y1k4MmxSQWU1QjJTd0lX?=
 =?utf-8?B?cTMzVzJPMURZd0kzVDNwVVA2N3JYcEEvT0dBYm1FSXo1K2tIeFlLTkZRVloz?=
 =?utf-8?B?eXhQNVY1aEk2a05aWjJQenZxcUNBOWk4cDRjUHU5bFZCZ3dmRm5aN1hvRVh0?=
 =?utf-8?B?MkRPaXFvVXJaVUlVYjNXMHZheE5BZ0krNG4xK0plTnUrVk5zOTdqb0NRYnVK?=
 =?utf-8?B?akk4UERHVWpvUlcydW5TZ3prbXM3cUhtcVBDYkZHY01DVXM4N2R4a3d2QThz?=
 =?utf-8?B?OFVDZytVeXIwS1I0RTRlM0hhQ083cENCSmJtaVRBU0F1TzNBSXNUYXJ1NjB6?=
 =?utf-8?B?LzZVbEJnbHVmYm1qU3IveHRNLysrZ0lhb0dadDQ3c09wcHBiSHYwKzZSSTZ0?=
 =?utf-8?B?T2FSV0FXa1ljZUo2aVZFa095SkRHeHlPQXBFZnJIMTBxczU5cjZMWm5hdnBp?=
 =?utf-8?B?MG1zczRiWC8zcCtqTnNRdVc3T0I5WWF6MnJZRDdBU1VPK0Q5R2R3RFZQb0tr?=
 =?utf-8?B?V3JoT2lNaGx4eDJXQmM1endSOTRmME5GWFQ3LzJWYUc4RFlzNXN0a3hWaFdt?=
 =?utf-8?B?Q2ZMSUdFNmRCMDN5bHlYYkNJZDhTQXFDOUdhNHBwMkhpeGIwcTRVVy9OdWdr?=
 =?utf-8?B?cGpYY3R5MXRiTHJyZk9saElzZW9keDc2SjYzSnZNaTBWZzdKVVlaSDF4cjVB?=
 =?utf-8?B?d09rbk9jZ0pCM2x5SzU5L3NOV1VpRE53Y1pOcTlud0ZzUkUvVGNmUnVvUUd3?=
 =?utf-8?Q?RqCIo9a3T/2swtKPL7RJZ48=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9344cec3-9f13-48c1-5ff9-08d9dc8c6908
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 03:16:26.4387 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yh6Wy2+/kh53OAf6n1iUWFzGerYvub846bcTbCBcs65cCko5EpbcPX6IrGZNSKjJ18UC7IoO476GDcymSzPDcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2760
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Russell,
 Kent" <Kent.Russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KR29vZCBjYXRjaCAuICBUaGFua3MgLiANClJldmll
d2VkIGJ5IDogc2hhb3l1bi5saXUgPHNoYXBveXVuLmxpdSBAYW1kLmNvbT4NCg0KLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFR1aWtvdiwgTHViZW4gPEx1YmVuLlR1aWtvdkBhbWQu
Y29tPiANClNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDIwLCAyMDIyIDY6NTIgUE0NClRvOiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IFR1aWtvdiwgTHViZW4gPEx1YmVuLlR1aWtv
dkBhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29t
PjsgTGl1LCBTaGFveXVuIDxTaGFveXVuLkxpdUBhbWQuY29tPjsgUnVzc2VsbCwgS2VudCA8S2Vu
dC5SdXNzZWxsQGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IEZpeCBrZXJu
ZWwgY29tcGlsYXRpb247IHN0eWxlDQoNClByb2JsZW06DQpkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZnJ1X2VlcHJvbS5jOiBJbiBmdW5jdGlvbiDigJhpc19mcnVfZWVwcm9tX3N1
cHBvcnRlZOKAmToNCmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mcnVfZWVwcm9t
LmM6NDc6MzogZXJyb3I6IGV4cGVjdGVkIOKAmCnigJkgYmVmb3JlIOKAmHJldHVybuKAmQ0KICAg
NDcgfCAgIHJldHVybiBmYWxzZTsNCiAgICAgIHwgICBefn5+fn4NCmRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9mcnVfZWVwcm9tLmM6NDY6NTogbm90ZTogdG8gbWF0Y2ggdGhpcyDi
gJgo4oCZDQogICA0NiB8ICBpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpDQogICAgICB8ICAgICBe
DQoNCkZpeCBrZXJuZWwgY29tcGlsYXRpb246DQoJaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KQ0K
CQlyZXR1cm4gZmFsc2U7DQptaXNzaW5nIGNsb3NpbmcgcmlnaHQgcGFyZW50aGVzaXMgZm9yIHRo
ZSAiaWYiLg0KDQpGaXggc3R5bGU6DQoJLyogVGhlIGkyYyBhY2Nlc3MgaXMgYmxvY2tlZCBvbiBW
Rg0KCSAqIFRPRE86IE5lZWQgb3RoZXIgd2F5IHRvIGdldCB0aGUgaW5mbw0KICAgICAgICAgKi8N
CkhhcyB3aGl0ZSBzcGFjZSBhZnRlciB0aGUgY2xvc2luZyAqLy4NCg0KQ2M6IEFsZXggRGV1Y2hl
ciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCkNjOiBzaGFveXVubCA8c2hhb3l1bi5saXVA
YW1kLmNvbT4NCkNjOiBLZW50IFJ1c3NlbGwgPGtlbnQucnVzc2VsbEBhbWQuY29tPg0KRml4ZXM6
IDgyNGMyMDUxMDM5ZGZjICgiZHJtL2FtZGdwdTogRGlzYWJsZSBGUlUgRUVQUk9NIGFjY2VzcyBm
b3IgU1JJT1YiKQ0KU2lnbmVkLW9mZi1ieTogTHViZW4gVHVpa292IDxsdWJlbi50dWlrb3ZAYW1k
LmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mcnVfZWVwcm9t
LmMgfCA0ICsrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Zy
dV9lZXByb20uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mcnVfZWVwcm9t
LmMNCmluZGV4IDA1NDhlMjc5Y2M5ZmM0Li42MGU3ZTYzN2VhYTMzZCAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mcnVfZWVwcm9tLmMNCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mcnVfZWVwcm9tLmMNCkBAIC00Miw4ICs0Miw4
IEBAIHN0YXRpYyBib29sIGlzX2ZydV9lZXByb21fc3VwcG9ydGVkKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2KQ0KIA0KIAkvKiBUaGUgaTJjIGFjY2VzcyBpcyBibG9ja2VkIG9uIFZGDQogCSAq
IFRPRE86IE5lZWQgb3RoZXIgd2F5IHRvIGdldCB0aGUgaW5mbw0KLQkgKi8gIA0KLQlpZiAoYW1k
Z3B1X3NyaW92X3ZmKGFkZXYpDQorCSAqLw0KKwlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQ0K
IAkJcmV0dXJuIGZhbHNlOw0KIA0KIAkvKiBWQklPUyBpcyBvZiB0aGUgZm9ybWF0ICMjIy1EWFhY
WVktIyMuIEZvciBTS1UgaWRlbnRpZmljYXRpb24sDQoNCmJhc2UtY29tbWl0OiAyZThlMTNiMGE2
Nzk0ZjNkZGFlMGRkY2QxM2VlZGI2NGRlOTRmMGZkDQotLSANCjIuMzQuMA0K
