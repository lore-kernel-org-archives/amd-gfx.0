Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E999FCD37B4
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Sep 2023 02:14:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4872710E00E;
	Mon, 18 Sep 2023 02:14:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C2AA10E00E
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Sep 2023 02:14:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWqdn1ubx7BHF4yn9Wo7IghXCJHw9UILvgH9OguzlGwwOtekFtp8NirIoneAOEZmj1y6Dg4bWhN49Xy2hGL7gYi8FneTXNbKDbl4359JqV1T7iKJZ/DPORv/fwQoMOAX8UN788zEdRFRD1GVd8UfrNRzdJpzo+hf4kRbYQoh+GuB45uMYf1ipa3orUfOSRAbPNYlcsgwLMxL1IF/e135+DVqBJoUI23eHzlP2ilG9uQJVAoIm0HrrtbHRiSRYJFfq+7B2Pv3RHOhu2ho68015CppEUIcC/wpeVBkj5xw1UfDuoMIuq6cgrIjQfMIlYhLEp6rXlsso6nnEJ6eBJgJ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCqs+I7HrZjjTl6Q/HDMrRBLqvO8jqX6LKGux4ngcSk=;
 b=TQg7UV3bLBwsSKlOxB6gQZws3FqAgz+Oop5xwAQXKJJRuvrrk2eu8TP7NS3e+qgECgj2ogBC5uRVL+2BP8bezP2Qgs4y9IFBqufBn/V2WnQvW2nD6XgyHOGvw2uLaAKlg/yVUctGKFddhyX7hkaEXvszC1d4c1JUuNIn7SnRSsTdeq27mLtdxTCSVK6FEKy+4XTxKrLjf53XEN8pBo65g0gEPpLl/ACwp77o44CcvlD3pTsRZek0sy6R0yZtR/NFnB2dd7UxOFDaPmO/8glSzILSRXw4igU4I8T3ytyJx5xXzuq8Wpj9fiWm5WuXBMxXVfP7BD2Sbxzo6UzzOlPZBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCqs+I7HrZjjTl6Q/HDMrRBLqvO8jqX6LKGux4ngcSk=;
 b=EYbTXrN2idWOJ+/bQp6YFtJ50x3zUBrJIh1lJ1dfuaS5zaSbuaZNobXbGYCETo733dnW2D/EOaYXIupBwOAMnXelh8ue3yO0D+TAv/zB14L8/v4o9RxxSGrhp2rYeUZceVUwCjiKFc8aE9vzSlLXy6yrN7z+nF6K81qte283PwM=
Received: from DM6PR12MB3035.namprd12.prod.outlook.com (2603:10b6:5:3a::24) by
 CH2PR12MB4972.namprd12.prod.outlook.com (2603:10b6:610:69::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.24; Mon, 18 Sep 2023 02:14:02 +0000
Received: from DM6PR12MB3035.namprd12.prod.outlook.com
 ([fe80::7a4:82ed:2e65:68fc]) by DM6PR12MB3035.namprd12.prod.outlook.com
 ([fe80::7a4:82ed:2e65:68fc%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 02:14:01 +0000
From: "Wang, YuBiao" <YuBiao.Wang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Sharma, Shashank" <Shashank.Sharma@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Use gpu_offset for user queue's wptr
Thread-Topic: [PATCH] drm/amdkfd: Use gpu_offset for user queue's wptr
Thread-Index: AQHZ53+hAU//U79Tsk2u9hZm8ClrR7AbcrOAgACHIoCAA+JmQA==
Date: Mon, 18 Sep 2023 02:14:01 +0000
Message-ID: <DM6PR12MB30353CCF8557B6F8C9A80E87E5FBA@DM6PR12MB3035.namprd12.prod.outlook.com>
References: <20230915025213.2463291-1-YuBiao.Wang@amd.com>
 <81a73442-2d27-eab8-4dec-cb1a6d179ab3@amd.com>
 <f82d33ef-3ace-0b74-04ab-9ce646dfb0bb@amd.com>
In-Reply-To: <f82d33ef-3ace-0b74-04ab-9ce646dfb0bb@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8d7c74b5-91b1-4205-8ac3-574258f498b9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-18T02:12:46Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3035:EE_|CH2PR12MB4972:EE_
x-ms-office365-filtering-correlation-id: 10f3abe2-c752-45f2-46f7-08dbb7ecece3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OtRs3Ef9uEF9x4dATooJmOEzXLaE0u/aJ15MeDfbyEifwJDRvJrOszOMg3D4yIjGeLmQrQXksW1UX4dN6TIHhHWebbMmGzwG3LKi4q6ptrgopeOiULiSWC0YK09O0EKr0Xjk1xh9OCnX4FvlsCENOgJIUjbVFVRkpOQsDPuRRiE2VLDdPU5Prec8tHqxtao+EKKs+fue1niBOiHSNYTg1NFoWWJWYFOkC7OkAiOCOj8wrkOvrtmwao4vI99zh46ZwWpFZ65+wInCiRiakCBTeQVpSmphaYAQq+3TtjWnUgH34d2pKuGNSsPR2OSYWc/GsvFyqggUXy7wZl7EJ4PymxHeqY4g5whnRJoQYMO4e5PkFWa7pnz53sKDBA3elaTP/3nCouvOlqbDaWujACMqJVw//eGdSr5Y+8em7KUUviMFfhTEsFlxzQHYRhmNt+BYhOf8O/WfUHp9brUHI7OtCnpyE9hfZ0vQPLPUOS60dFNd48R9O65vlqWSHQAP3Fb8wOowGFFoxUsc13LVGgns5iLngpS5Gt6f64lmR2Mu/KMFWZZ/xa8RU/TWOa0OtcSHsfSW906pUBJP4S3qAADuQ7lrO0nY191J5sYkHCzG9N3PMqupO4vPgacHL/n0Enkx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3035.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199024)(186009)(1800799009)(76116006)(66946007)(53546011)(7696005)(6506007)(110136005)(66556008)(66476007)(66446008)(64756008)(54906003)(9686003)(316002)(6636002)(41300700001)(478600001)(71200400001)(4326008)(8936002)(8676002)(52536014)(5660300002)(33656002)(38070700005)(38100700002)(122000001)(55016003)(83380400001)(66574015)(2906002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWZZbGgxdEFQSGp0UVE4ZFJPMkc4bU9sUGR0V1d6RFN0TWMrajZzYldPZU1o?=
 =?utf-8?B?V2hNUGdJQTRudi9WdU5pcjMvWk5tZTBTV011MGdxalpDcWlGV2RYRFdCaWdt?=
 =?utf-8?B?ai9wdjRPSkNMZ1V6TGU0QTltejVUMlFaUFVKY3U2aXRRTENtaFNlVzk2OWlR?=
 =?utf-8?B?UFBubytGdkdzbFJ4RlVwQ1R1ZisrOWRtWTV2MEtKUVl4TE9uTHh4eVMrM3cr?=
 =?utf-8?B?YmRxNTdwdms1T2xTU1o1OVU3a3JqRnd4QlNKRnRheDg0VHB6K0VFYVhXTHMr?=
 =?utf-8?B?aTZCZEFmZ3VVWGJ1dUtrS245WU9CSmFjdGlRYmJrNmdzemY1ZHpaemFIajJl?=
 =?utf-8?B?T0RnZkZrVVdlbWRJbHdyU1lPZU01WU5nUkRmWkoveDlZRlJwREdSc05xay9E?=
 =?utf-8?B?RHpSWVdOeVNac2RhT2JJV0FlU1pJYUZQTzE1RWlMbnFCSVBCRXluL25HSldX?=
 =?utf-8?B?OCs0RVU2UHRrOHliM0JNQ3JRc1B1VEY2cmJ2WCttYWVuUGl6WUMxT1VMQmFT?=
 =?utf-8?B?dUV3T1M4SCtBR1N2eFRqRWVIMkZ1YmhNRXRic1ErNHRRS0lXNVRrM3NGZnRI?=
 =?utf-8?B?NlpycjlCTlRkS24vQnF6OWxIcUtZc0ZqazZIaERPVHR2ODlwQysyMEdsYjYr?=
 =?utf-8?B?aXU1V1ZTR09DQnJhdDgrQ3g2U1hHWmx0MDZHNmlYaEFzSHFsdlhGMnc1T3cy?=
 =?utf-8?B?RUw3ZTRlSjNLdjFGVFFHcU80ZElYTXJ4U3dvMUVzMTQ4S3RWWGl6YytoQ1hz?=
 =?utf-8?B?OXBsRUtRdWs5QVd2M0xZMHFkbFM4aC90MXViNlF6NUxMbEZ6S1BBSkxkSWlM?=
 =?utf-8?B?a3pleFNpVHJ2K2pLaTNNT0U2RVduL2VlTmxRbEVpRnVrS3dUMmJOVkdDSTZv?=
 =?utf-8?B?Q1ppRmUybnZpdkdscXB5R0hyU2hmUzhzMjdVa0tNZDVWdUVEblpHNVM0MXBy?=
 =?utf-8?B?UkE1TUM1UHU2Q2lHWnpxdGV0OW9CYjFidmVGendsZ2pCNHVRT1RWbG9tRm1l?=
 =?utf-8?B?U24zZjZMV2RQVVBodzJqRlJLUFR5ZkdWenFUNUZMNVVTbWcrWExXWW0ybC8z?=
 =?utf-8?B?bFRqL0orQUd1ajJvTlk0NmhqRDdrYkV6OUl2U2NlV1VNTHJmZWtrU3ZycHRQ?=
 =?utf-8?B?L0p4aUkxMEl5NDMwK0p5U2ZPOW1HVzhNTVBaUDVtNmNPakJVTytGU0lLMVRz?=
 =?utf-8?B?Z0lXb0NQWGVlbkoxWFA1VjVsdk1tTVVnRkdoZ2JiQVp1eW0zUlVFQXVLdG5I?=
 =?utf-8?B?K0ZOKy9zN0x1anF0RXl0TWRlMjlJTW5MMXQ3WllDTkhTaGc4empZNHY2R1NM?=
 =?utf-8?B?Ym15TTQ0VVN0S3pMbWE3Z3FQN2k3eFlxL0k5TTJXbEpLcTJPT1d2WUZ3N3Yv?=
 =?utf-8?B?M3BRSzYvSjhNMklRaXFGd2JPd3lEcFBKaEhWak1VOFQ3VUR4VDhJcXZjTkNR?=
 =?utf-8?B?RVEvdGxqdG9PemQzY2RONTYzQ1Zaa0pkcFFGN21SYXhKeDQ2WnFRbzI4R3Bq?=
 =?utf-8?B?WmZTM1FpSTZWMVhFbnJhT3llZElVaExyYUdCOHZOTUFPWmVrZkJ1QTZpWU9N?=
 =?utf-8?B?dWlBWGpPT2g1dXdSYi9ET01WN2t1K2Jpd2lla1U3WlZPNjJWS3dOd1RLczJl?=
 =?utf-8?B?T0hmaDV5NlhUWTBEVWU0eGJBY0tqM1RLa0hHeUJneC9DTVgrbGV0bjdDQUo1?=
 =?utf-8?B?T1o5OElzUzVXZDRDSlZhck41ODBQWWlQV1h4aUhJdWROY01JN1A2cGNjM2Zy?=
 =?utf-8?B?NlhMQmlSajJzcUJpL3pJNC9pTWFwZnVnTCtxbXhoSFNVTTRPaHQzQ2tDTzdp?=
 =?utf-8?B?eTlwYUkxTStEaHlLTUlqMGs4QXMxdythblI2b0dRb0owUkJyMG1rbDg5YTVQ?=
 =?utf-8?B?c3NMSGlobE13Ykh6RFhwS3FLcG9KY2lDUXA4WE96YndKVmFnWmlZZjlPS2Qr?=
 =?utf-8?B?ODNOUE1ML0Q5Qzd3M2JNNmNGbmd3UUVHaUk4NnJnODdmcXlQbXhMdkRza1RX?=
 =?utf-8?B?dklXRG1nd1NqYmxNYWdydTVsUnNlU2RFamhGbmlHbWRSMDBOM3VydHQxWmhr?=
 =?utf-8?B?cTdTUUNtQXlzU0NYYjg4R3E2ZGY3aEdBMFhDQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3035.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f3abe2-c752-45f2-46f7-08dbb7ecece3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 02:14:01.7164 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NykxQdtm61x2wq8YJAnZRKC8ddatt4wglttcvvAQhitLGlaACmRCmFJKXiI9M0/FhWTA88TtpQqcq12blOeS2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4972
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu,
 Monk" <Monk.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEZlbGl4LA0KDQpZZWFoLCBJ
IGJlbGlldmUgdGhhdCB3ZSB3ZXJlIGFsd2F5cyBzZXQgZ2FydCBkb21haW4gc3RhcnQgYXMgMCBi
ZWZvcmUuDQoNClJlZ2FyZHMsDQpZdWJpYW8NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NClNlbnQ6IEZy
aWRheSwgU2VwdGVtYmVyIDE1LCAyMDIzIDEwOjU0IFBNDQpUbzogS29lbmlnLCBDaHJpc3RpYW4g
PENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IFdhbmcsIFl1QmlhbyA8WXVCaWFvLldhbmdAYW1k
LmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBTaGFybWEsIFNoYXNoYW5rIDxT
aGFzaGFuay5TaGFybWFAYW1kLmNvbT4NCkNjOiBDaGVuLCBIb3JhY2UgPEhvcmFjZS5DaGVuQGFt
ZC5jb20+OyBUdWlrb3YsIEx1YmVuIDxMdWJlbi5UdWlrb3ZAYW1kLmNvbT47IERldWNoZXIsIEFs
ZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nIDxIYXdr
aW5nLlpoYW5nQGFtZC5jb20+OyBMaXUsIE1vbmsgPE1vbmsuTGl1QGFtZC5jb20+OyBYdSwgRmVp
ZmVpIDxGZWlmZWkuWHVAYW1kLmNvbT47IEtldmluIFdhbmcgPEtldmluMS5XYW5nQGFtZC5jb20+
DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1ka2ZkOiBVc2UgZ3B1X29mZnNldCBmb3IgdXNl
ciBxdWV1ZSdzIHdwdHINCg0KT24gMjAyMy0wOS0xNSAyOjUwLCBDaHJpc3RpYW4gS8O2bmlnIHdy
b3RlOg0KPiBBbSAxNS4wOS4yMyB1bSAwNDo1MiBzY2hyaWViIFl1QmlhbyBXYW5nOg0KPj4gRGly
ZWN0bHkgdXNlIHRibydzIHN0YXJ0IGFkZHJlc3Mgd2lsbCBtaXNzIHRoZSBkb21haW4gc3RhcnQg
b2Zmc2V0Lg0KPj4gTmVlZCB0byB1c2UgZ3B1X29mZnNldCBpbnN0ZWFkLg0KPj4NCj4+IFNpZ25l
ZC1vZmYtYnk6IFl1QmlhbyBXYW5nIDxZdUJpYW8uV2FuZ0BhbWQuY29tPg0KPg0KPiBGZWxpeCBh
bmQvb3IgU2hhc2hhbmsgc2hvdWxkIHByb2JhYmx5IHRha2UgYSBsb29rIGFzIHdlbGwsIGJ1dCBv
ZiBoYW5kDQo+IHRoYXQgbG9va3MgbGlrZSB0aGUgY29ycmVjdCBmaXguDQoNCkxvb2tzIHJlYXNv
bmFibGUgdG8gbWUuIFdoeSBkaWQgdGhpcyBub3QgY2F1c2UgcHJvYmxlbXMgYmVmb3JlPyBBcmUg
d2UganVzdCBsdWNreSB0aGF0IHRoZSBkb21haW4gc3RhcnQgb2Zmc2V0IGlzIDAgb24gdGhlIEdQ
VXMgd2UndmUgdGVzdGVkIHNvIGZhcj8NCg0KUmVnYXJkcywNCiAgIEZlbGl4DQoNCg0KPg0KPiBS
ZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0K
Pg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVl
dWVfbWFuYWdlci5jIHwgMiArLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMNCj4+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMNCj4+IGluZGV4IDc3MTU5YjAzYTQy
Mi4uMzZlNzE3MWFkOWE3IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jDQo+PiBAQCAtMjE2LDcgKzIxNiw3
IEBAIHN0YXRpYyBpbnQgYWRkX3F1ZXVlX21lcyhzdHJ1Y3QNCj4+IGRldmljZV9xdWV1ZV9tYW5h
Z2VyICpkcW0sIHN0cnVjdCBxdWV1ZSAqcSwNCj4+ICAgICAgICAgaWYgKHEtPndwdHJfYm8pIHsN
Cj4+ICAgICAgICAgICB3cHRyX2FkZHJfb2ZmID0gKHVpbnQ2NF90KXEtPnByb3BlcnRpZXMud3Jp
dGVfcHRyICYNCj4+IChQQUdFX1NJWkUgLSAxKTsNCj4+IC0gICAgICAgIHF1ZXVlX2lucHV0Lndw
dHJfbWNfYWRkciA9DQo+PiAoKHVpbnQ2NF90KXEtPndwdHJfYm8tPnRiby5yZXNvdXJjZS0+c3Rh
cnQgPDwgUEFHRV9TSElGVCkgKw0KPj4gd3B0cl9hZGRyX29mZjsNCj4+ICsgICAgICAgIHF1ZXVl
X2lucHV0LndwdHJfbWNfYWRkciA9IGFtZGdwdV9ib19ncHVfb2Zmc2V0KHEtPndwdHJfYm8pDQo+
PiArd3B0cl9hZGRyX29mZjsNCj4+ICAgICAgIH0NCj4+ICAgICAgICAgcXVldWVfaW5wdXQuaXNf
a2ZkX3Byb2Nlc3MgPSAxOw0KPg0K
