Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3101C6FA99
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Mar 2023 03:08:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58DB910E00D;
	Wed,  8 Mar 2023 03:08:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3399E10E00D
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Mar 2023 03:08:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzIlDvYu+6K/xvs7GZunos0eADV32KB2H3TDFRPOSnCb/XRCbMAFan7z/DkcHfonytBFgWCLFOqJ5GvF8vUatBNGQaOLVxBx/9yJmPhKzapePNAEHflnAA/xzTg311fPZXuooKqB9ZQr9YSsLBD96+yNYWss3cH1zU52udSTP31r0wc5fkOf1O+PRUZepHEIeVtuGvwemlq37m970v7Qc+kZqvBmz/SBXcynW84fckE8bQd/gnjTyPqKTFXMgt5ONwGdenBXxiQBaqlkqNrnizZREEBBUIHd7marhHKdQ0OCbcGswfKuAOwuKfSxdk07jnuNmEmgGlk1I5A9J88RVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0VjpfJViKBy8App5/9xFK0KUCX0kHo7ecW2nT7IKyw=;
 b=ICZqn4FOKxFi1aftOTFgZWeC4fZhr8aJoqLQCqG5XKT82EJkdLKDIi+P/VrRTdX2kPtCEy/BW9iE8ApAz9fSQGGrm4Y9YbOThoft+M1p4cS21aHzvYt8sZFa4lAyUMoBmuEJJGEZRXEO1IOz31FlfRD0pILxMbtajowcliRYAdC/KXRIZ4viWwR+yw5J5jaTwFKtLnewOXFvBbnqWZ264Wi0wCyiALYELW1aZztKlIae7D0vEn2dCuv1r22mX9ov5DnCnlAvN4NfA+wP5FEAFy5N3luz0cMXql0xVg1DH3B/HB40t1V1rPLWsN/AfC5eXDh2dLl/G635mCr4ASzBXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0VjpfJViKBy8App5/9xFK0KUCX0kHo7ecW2nT7IKyw=;
 b=VJiLi+dge5eBjwpGwFwmV7Gd+Zjcx+4axRYGgxlbDhXuo8U/FkI4QHH6LMZtAUy+oBbBEl6EtYqmiJzc4puhSuIpSqXJEihL18qGSrDFogX5U3RPorDpdmdR7gn82aV2ywPm1NkwyqSP4LPCCN+0ZKbQZkvX/33WZJKU1kqkXmo=
Received: from DM6PR12MB3035.namprd12.prod.outlook.com (2603:10b6:5:3a::24) by
 SN7PR12MB7348.namprd12.prod.outlook.com (2603:10b6:806:29b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 03:08:35 +0000
Received: from DM6PR12MB3035.namprd12.prod.outlook.com
 ([fe80::ed0a:df34:1fa5:b78b]) by DM6PR12MB3035.namprd12.prod.outlook.com
 ([fe80::ed0a:df34:1fa5:b78b%7]) with mapi id 15.20.6156.028; Wed, 8 Mar 2023
 03:08:35 +0000
From: "Wang, YuBiao" <YuBiao.Wang@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Force signal hw_fences that are embedded in
 non-sched jobs
Thread-Topic: [PATCH] drm/amdgpu: Force signal hw_fences that are embedded in
 non-sched jobs
Thread-Index: AQHZUMLdKucQLFC+sU2tq5dSgUnmja7u5ZCAgADh5YCAAC4iAIAAOt3g
Date: Wed, 8 Mar 2023 03:08:34 +0000
Message-ID: <DM6PR12MB3035880648AE01EEE230DA09E5B49@DM6PR12MB3035.namprd12.prod.outlook.com>
References: <20230307070231.3807549-1-YuBiao.Wang@amd.com>
 <a38e637d-2cd8-caa0-e27f-4c9b8dc101d0@amd.com>
 <c01e8d00-0565-0015-0e69-ca22260c70c9@amd.com>
 <f7e279a3-f26b-cdb5-ed5b-8aeb2344ac98@amd.com>
In-Reply-To: <f7e279a3-f26b-cdb5-ed5b-8aeb2344ac98@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3035:EE_|SN7PR12MB7348:EE_
x-ms-office365-filtering-correlation-id: 8d9871c4-4651-4c3c-5905-08db1f826790
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FKiHetwmpEpc1GBjuKx/WxCmbpAdIzAX8tqBbGKccXElc6Urb1gzPaWCcwt6H/Z+E0CC7gTLeOcPtLjYdcAchlMA/mWZ8TnTR+SlETsK9f0U4PKvpZMZQ04j1DH3uL2nbaprAdlOdotvW1ggdo/wx0RvYNTjwpcmdJIB6tqDoP4OlR/iJvaa19c+PePzrHIYyL7aQ/vWTubx2MsgqtEHc0Hk93bhVST0zAOQCPtYo/Z+ykZuXVvT0J8NAwHAPwBNV8KYxqo2TAQF6QpES8oQoDhH4xmDWLmOtMH8eN/XN12o0RBuwrUrpg3eHDZcZWj6hecQZ6WkJgrGoJ7hvgmQ/wz8QRnbZ3CySkJKkA5voiWIUHD/rnyXEi9iSegrjmgiC1mNFesae9mXHklpjge+vgCnX5cQb6CvhL8mUPbhSfx9wSx7MFalRZ51GgKFqk2C4RoM9w4bqJoDuwkCy5hlpDlJahrBxgBfLDXW0I9wMH/PENjcgWe4A2qWnCHYuoGSnq+rzI4scFdKbspLjVlmt+7g+N9DB4T/WpbK3aCx4Om3rB2saFK20q0ZwaxHkThK4ffwHqtxk4hsSnIVNQS9baMorRZPPRw5/tVoNeEAoDBOT9ra2WISj+5paD+wsCD26d/F2TjUtPVLdvCfwkKy3cZljlNwliZP8tW9okQmxrDveTs0YmIpiyGCMU4nNeE8VuyUjHMGw9ZUltn4HPJYcA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3035.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(451199018)(316002)(76116006)(66476007)(8676002)(66556008)(66946007)(4326008)(66446008)(64756008)(83380400001)(186003)(86362001)(9686003)(122000001)(26005)(55016003)(38070700005)(38100700002)(110136005)(54906003)(33656002)(478600001)(53546011)(6506007)(7696005)(71200400001)(2906002)(8936002)(5660300002)(41300700001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0NGMkJzT1doTTZkVmtWWE1pYTRHL3Y0Ykl3V3BQNDJuR2lxSGpmU20wdlBx?=
 =?utf-8?B?RzNjV2dEWmNyV25ua3hGV3ZHU1pxcmpldlFZVWpYWHBJVjZ0WUJNak9TUk9L?=
 =?utf-8?B?RnJ6Sy9KZy9oaEFuTEFpTFFFNHRYVzFvY1I3MUEwNnRBMU5VMmZlQmk1MXEv?=
 =?utf-8?B?WjR4ZzNkTk1laFFUYzQ4NXdWWVFJbW9NYjVIT3RZeEE1VVhpcktvcEpmcDha?=
 =?utf-8?B?RFIvVFhFdTVBenhpSkE4YUJCSmMxMEJrZW9mVnpIMC9JME1HNjdlN05xNThO?=
 =?utf-8?B?SU42QkV1K0pSNllBVDdkVlFpSjFpazJycU9zQUNuU0pacmVLZzF0T3dmbEdD?=
 =?utf-8?B?SGZCVERGMFdINjhpRXZndW5Sa3hqa3VEaWlvQU9YRnk5em9FNkV3dkxMeElR?=
 =?utf-8?B?cUhhZFVZQVdpc1JkUUJQdG1JZS9jU3JadndyTXJYK3BIeGdkeUs1Z3NIVXVH?=
 =?utf-8?B?VWZpdXpxWXUwbGVhRU9ndmpHb0NMaWFFMjBZelZvN281aWppdHgrZVdsSitC?=
 =?utf-8?B?ZUR2ZXFyV1FpSWlhTmRvNE9RT0xUcWpOaEpQdXpIZFF3bktjdUp5UHdqYkQ1?=
 =?utf-8?B?aERUZXpjUnpYVkRJeDloYXA1a21DaGRSNnQrU2F2UEpqNGhnOVdqRW1VQkll?=
 =?utf-8?B?anhiZkR2S3dBVkhNSlVVOXUyQVo2cm02UTlES3A2UnF4aXExYjA5aWZycE56?=
 =?utf-8?B?Rng1Q2krbWc4aExzMzlJSUgyTmlWcTQxUm9Idnlna3V4Yi9EcXFxcGVDVVVo?=
 =?utf-8?B?L2lLaWd1UFMxR3hJaDBmcFhFNDVsU2lsOEtwaTBoVi9CT2FCbG56RXdDaDJZ?=
 =?utf-8?B?TEVpWGVVRG93bGxjRnkya3FBajhyU1RPWWMrY2lUZ3h0eVhaamlZM2p5V0gr?=
 =?utf-8?B?dGRWU3hNR2dOemJBMEpQcTB1dzNpVFVhZFUxLzM3Q3ZKN3ZocUVrZzRsMkp0?=
 =?utf-8?B?VGZObit1S1ltNXhPclZnVmZRdFNIQlRvNGx3MlVDZUpCWmwvejFpMmxyVUJa?=
 =?utf-8?B?ZW9GQkdpeHpzQTNHOXBWdEVLSEtzZmdRY1RRWWdVa01udGNJdzd4eVFueUNC?=
 =?utf-8?B?ZHJFd3I5NVRRWkswazc1d2tWWmZsRVJ1WVQ4M1ZXN1hmdnpFOU1XVjZkbVRN?=
 =?utf-8?B?V2tQWk5BeVltKzZrQy96ZGRVdm1LdUlXbTdRcnhPalVicXQwVDY0SCtsalNW?=
 =?utf-8?B?NWpYY1o0VTBMeHhndjl3Y0RuUUhwbEk4dW5qN3FFVzE3eWN6RCtWU1lzSUM3?=
 =?utf-8?B?RmM4UWhRZGlvc0pHSUlrWUs4OWlNbzFjb0pscDJIbXZZZkFxdmFGR1hGZWx3?=
 =?utf-8?B?d3U4UzJlakJ3QnlUOTJvN3Y3WmVTdElTUVQ4OGtYR2RuQjZUZlFRTTJ5MTZV?=
 =?utf-8?B?d0FrS05yMU5NS3hWZ3c1Wlk3YjRBdmkyalZKd0RMVUhSeGhLM3diRjY3bzZP?=
 =?utf-8?B?WW9zNDlYWGV6TmRxbmJBVWZxSmIwNmxKN1oydll4Q2w1dzhydUdsaXYvWHUv?=
 =?utf-8?B?VUt6dlZIVzI1Y0E2bDJ2QjE0cUVSOFRWYmNrYXJxampYSHZ2OHZGenE4SE1h?=
 =?utf-8?B?WmN6dHlqZjMwbDJwYmlGS2J1NmkxM1p3aHZ0aGoxVkJvblNYMkRBdWNVTzdP?=
 =?utf-8?B?WjA0a2NSV3g3d2FEKy9uQithWWQ1RzZpNnlBSld5RzVsUUZhbHlRMUZoU3cz?=
 =?utf-8?B?aElVVjlUUjBsNGFiQmdpaXYrU0h6SVFRMVJqREMzM2h0VkJPMEc4Nnl2T21R?=
 =?utf-8?B?OUF5ZTBrTEl2aElaTnNUcDBuT3IrbGYzQjRCbjFvYUFIbFRJWjFMcG52T1Fs?=
 =?utf-8?B?eDNyc1c2YjhiU29yZFlSTFdLRC9kSHk1SGhNUm02QXl6dXRVV3ltc25waXlO?=
 =?utf-8?B?cDk1NFZWejZCeSsxRHJYSGIwOTJ4VzJnSnllRHk4Y0ZGZGpEcGxRdVAyaHM5?=
 =?utf-8?B?K3JxOGFnLytvUlZ1dWs4T2RzdnJlS29Rd3lodVZ4ZHM3U0Z3N1hWN01ia2Mw?=
 =?utf-8?B?YkdhczNzMUhYdXMrNFRvV3Q4MU1XN0ZhLzhjNjBZSGpuZkJjWjlEbWsxV3gv?=
 =?utf-8?B?TmdtZEFFdWFiZG9oZ3NnMy9yTVZZNnVJL3FmM1EwTE5jNUdpMHRNT09xeFNB?=
 =?utf-8?Q?0Ny6e+ZYgsuWd9BlTyaVrX2U3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3035.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9871c4-4651-4c3c-5905-08db1f826790
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 03:08:34.6154 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EN5WuLx4SIn5lyXwu0g4l/8fiU445trVRlDGA/2NGPSHPj+QJbsFZXWBmNjOfYyLVaSrKOjJn/3Mqm9+6acY9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7348
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
Cc: "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Chen, Horace" <Horace.Chen@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Liu, 
 Monk" <Monk.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgTHViZW4sDQoNCkkgd2FzIGNvbXBhcmluZyB0aGUgYmFkIGpvYnMgb2YgZmFpbGVkIGliIHRl
c3QgYW5kIHRoZSBvbmVzIHRoYXQgY2F1c2VzIHRoZSBURFIsIGFuZCBJIHRoaW5rIHRoZSBtYWlu
IGRpZmZlcmVuY2UgaXMgd2hldGhlciBpdCBpcyBzdWJtaXR0ZWQgdmlhIGRybV9zY2hlZCBvciBu
b3QuIEluIHNpbXBsZSB0ZXN0IGNhc2VzIGl0IGRvZXNuJ3Qgc2VlbSB0byBpbmNvcnJlY3RseSBz
aWduYWwgdGhlIGZlbmNlcyB0aGF0IHNob3VsZG4ndCBiZSBzaWduYWxlZC4gV2UgaW5kZWVkIG1h
eSBuZWVkIG1vcmUgaGVhdmllciB0ZXN0cyBidXQgc28gZmFyIGJhc2VkIG9uIHN0YXRpYyBhbmFs
eXplIEkgdGhpbmsgSSBkaWRuJ3Qgbm90aWNlIHRoZSBjYXNlIHlvdSBtZW50aW9uZWQuIFRoZXJl
J3MgYW5vdGhlciBjYXNlIHVzaW5nIGRpcmVjdCBqb2Igc3VibWlzc2lvbiBkdXJpbmcgcmVzZXRl
LCBidXQgaXQgaGFwcGVucyBpbiByZWNvdmVyX3ZyYW0gd2hpY2ggaGFwcGVucyBhZnRlciB0aGUg
cHJlX2FzaWMgcmVzZXQgc28gSSB0aGluayBpdCB3b27igJl0IGJlIGFmZmVjdGVkLg0KDQpJJ2xs
IG1vdmUgdGhpcyBsaW5lcyBpbnRvIGEgbmV3IGZ1bmN0aW9uIGFzIHlvdSBzdWdnZXN0ZWQgYW5k
IHJlc2VudCBhIHYyIHBhdGNoLg0KDQpSZWdhcmRzLA0KWXViaWFvIFdhbmcNCg0KLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFR1aWtvdiwgTHViZW4gPEx1YmVuLlR1aWtvdkBhbWQu
Y29tPiANClNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggOCwgMjAyMyA3OjIyIEFNDQpUbzogS29lbmln
LCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IFdhbmcsIFl1QmlhbyA8WXVC
aWFvLldhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogQ2hl
biwgSG9yYWNlIDxIb3JhY2UuQ2hlbkBhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4
YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1k
LmNvbT47IExpdSwgTW9uayA8TW9uay5MaXVAYW1kLmNvbT47IFh1LCBGZWlmZWkgPEZlaWZlaS5Y
dUBhbWQuY29tPjsgV2FuZywgWWFuZyhLZXZpbikgPEtldmluWWFuZy5XYW5nQGFtZC5jb20+DQpT
dWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBGb3JjZSBzaWduYWwgaHdfZmVuY2VzIHRo
YXQgYXJlIGVtYmVkZGVkIGluIG5vbi1zY2hlZCBqb2JzDQoNCk9uIDIwMjMtMDMtMDcgMTU6MzYs
IEx1YmVuIFR1aWtvdiB3cm90ZToNCj4gKwkJCWpvYiA9IGNvbnRhaW5lcl9vZihvbGQsIHN0cnVj
dCBhbWRncHVfam9iLCBod19mZW5jZSk7DQo+ICsJCQlpZiAoIWpvYi0+YmFzZS5zX2ZlbmNlICYm
ICFkbWFfZmVuY2VfaXNfc2lnbmFsZWQob2xkKSkNCj4gKwkJCQlkbWFfZmVuY2Vfc2lnbmFsKG9s
ZCk7DQoNClRoaW5raW5nIGFib3V0IHRoaXMgbW9yZSwgaXMgIWpvYi0+YmFzZS5zX2ZlbmNlIGNv
bmRpdGlvbiBoZXJlIGVub3VnaCB0byBtZWFuICJub24tc2NoZWQgam9icyBsaWtlIGliX3Rlc3Qi
Pw0KDQpJIGZlZWwgdGhhdCBpdCBpcyBhIGJpdCBvdmVybG9hZGVkIGhlcmUtLWNvdWxkIHdlIGhh
dmUgdGhpcyBjb25kaXRpb24gc2F0aXNmaWVkLHlldCB3ZSBjYW4ndCB3aWxseS1uaWxseSBzaWdu
YWwgdGhlIGZlbmNlIGhlcmU/DQotLQ0KUmVnYXJkcywNCkx1YmVuDQoNCg==
