Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5ACC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 07:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAFC561883
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 07:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAFC561883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ACB86E86D;
	Tue, 30 Mar 2021 07:41:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FD026E870
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 07:41:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeJU6H33T8brkhijZGfHAGgLjdXXeGTvUOAEdwLuGvCP7JyqZuMpUNdPdak1c98UvkHx3BrbO4eWn0ULojYrSVSOc2LZNpNRd8zB0eKX0/KjB/2W0czeJLjlNe46s8AiWa8D9H3ryTq1yK1Qhp0jc3PGUFQS7WbfQYMoTreH7szCHXpUlYaW4UisT/a3Vj/5GDWcZqstvK3jzQlQ55TUYF0Vk95zQuNOfHeTnH4OM7xOfDUJjS5mvdYqqlPKJU0wbUJHyPbn2N2HjuIBUYn3OMUB027zkGhUApEeIV97Ofn0jHYBUOXy8RIU+VOAP49HMr6yj+BybYnhMTGrt/S/rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjMiJ/lQsctgR4ycCdAbQwFdUQ1h9aAYYj1UPLxpF1I=;
 b=lc/NtbOmjWdN6EYgYb8mVaF5DHzQoPS1anSVslgyxtn1P3BNodEVGMQfDpz/8wOPRDxcya/aT+eDNjRAfM+rcfXYuvNodxpSa/zTwdfoLobiB1wsGlF2jR0kVwOdKs7Y/rsqP4sS22pEEkeZeQ8RrP+ZD8lHmkN9aEH2GW2szo4LiYelQ1p255/wHKKNKRJRBPX3Cinju78omJmRwx+RDq1Me55TXelGBdlsvykSJbV8XqKJZUDdM5iBPQOtN0kIgFXnNKTMqeX40DvaIE+YYv7HYolGPKjz2jYEIzfDghcGlXmCqROjaqWBZf+sBoxMr3uQ74ATxDIAlTc8Bi5b5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjMiJ/lQsctgR4ycCdAbQwFdUQ1h9aAYYj1UPLxpF1I=;
 b=Ys5CvCuOEC8iX4tWoa9em/d46ErvAzUVGPjPWCmZJWuzW/U0uwI7xBxgABOZfqQ5JdWXHK4R/NwZnFXXKleJvBDZgBpdjLWA+y1qiFCz8AavoagtwhFfVUDM7j3QLsnBRu/SaY9370tx0vDFa6UJYIl5Kmq436m7d5WcUvbMkV0=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB3413.namprd12.prod.outlook.com (2603:10b6:a03:ab::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 07:40:58 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::856e:ecb2:3146:132%3]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 07:40:58 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 5/6] drm/amdgpu: Disable RPTR write back for navi12
Thread-Topic: [PATCH 5/6] drm/amdgpu: Disable RPTR write back for navi12
Thread-Index: AQHXJR8JmB0dRodUVkKvlN3EO71MMaqcHfQAgAABt9CAAAF4AIAAA/0g
Date: Tue, 30 Mar 2021 07:40:58 +0000
Message-ID: <BY5PR12MB4115DBE1045BDA817F855CB38F7D9@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210330044147.57802-1-Emily.Deng@amd.com>
 <20210330044147.57802-5-Emily.Deng@amd.com>
 <4ccce70f-bd74-87ab-a280-5c45b74a7d39@gmail.com>
 <BY5PR12MB4115EEED8927FFF414AF966F8F7D9@BY5PR12MB4115.namprd12.prod.outlook.com>
 <c358ac16-166e-ba81-3cfb-b51a4adafb9f@gmail.com>
In-Reply-To: <c358ac16-166e-ba81-3cfb-b51a4adafb9f@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=7515647b-b1b8-4460-9db6-33d66e5872b3;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-30T07:38:32Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fbe2eb60-66c7-458a-51e2-08d8f34f28f0
x-ms-traffictypediagnostic: BYAPR12MB3413:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3413F4CE6DD16DB2EB109C248F7D9@BYAPR12MB3413.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5xb9p75MxGiNGqOM5h6VEqCe7WbpUuDRUtL8DxlX2aeYVHPihvF5ceVpQ7HgSJED/E5GF3/XhpOWB/AZSfauV1qwMy5eXPIGLcG7YVhr5TLZRTJZ/wyJCezzGZFOropd4zgZ22Yb24a3L4GaabZwf2zGs/cMbscYhVWBEniJnIsB+sOjqj2v6RTii8PKF/uzpMKMmBUxQqTTwZ4P6ybr+5obnH68UrVuC4tCodPgDds9gythRYtKQeAAqRQ2IECCKQyMTCYnwcaATMwjrJpUMf+DS/PVxhEazHb/bevSjMHioBQwlpf1xNbh/anaE2UaUXCdXjCjTLdD+DJYvdBY4S93ZNaNh7SSzbcbS/zv6JPMrafHBbomg+Edxal/pe8HrG0bPD5VPuqjVERNHHNCkM0/bfODeu9J5LnBORiv8vhCjCvjzTZxreXmRSMUd0kJTFLmZMHGkp96hLyJWtcxFpIGVi2b9Xwg9xnQBWav4CM3g1efTGCXnIOFHAzMdK1pneDc4Jj5kaOdT9sbKq5KCp6CM2jZJ8uTHvn3vLwwMlWgHStL5qNIDsg/R1yF9oiL/CWYnuMyexKeixF2Pm9OMmV2UhKVwzfzcapkx0hpsRLSPjmZZgUP4YVUqDeFMaPHfAlfQ4UKnyf/bo7M6F/tebJj0WwaUivCjkwzYM4DHqQ4QsDbH3IHfEnK9JnSm3gG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(6506007)(8936002)(53546011)(71200400001)(8676002)(316002)(66556008)(66476007)(55016002)(5660300002)(66574015)(6636002)(83380400001)(33656002)(52536014)(7696005)(66446008)(9686003)(2906002)(110136005)(478600001)(186003)(38100700001)(66946007)(64756008)(86362001)(76116006)(26005)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?b0RTd2ZFek5RY1ViVUJCaklHMzQyVjd1akVyN055VmQrM3VzL21NSGRSeTZF?=
 =?utf-8?B?VEZGemxXSG0xMVUzNUJRT2lodTMyckxCQXk0VU04YUxiNWxGbFlCcWFvV0dp?=
 =?utf-8?B?UmNvZmgrN2pSOTQxWGdQMS9wSzNEN3FKSXdpeG96WmMxSzgxQ0V0djAvWGdj?=
 =?utf-8?B?L1FaRDVxNFhJK25BeVF1b1NzTk1lN3JvNmJiNDY4ZDVLMVU5RFNGMkpGUU1I?=
 =?utf-8?B?ZGJmZ3J1cWpVU2Myc3ZHQlRMN0pCSXExRXdzMWF5RzZTa0FyZGNyVHBCWlVJ?=
 =?utf-8?B?RFpsV3V3UitSOEFkYWU0N2pITjlnb051dTUzT3EzaTV4VnlGb3lZQ3E1TVVM?=
 =?utf-8?B?Tm1kV0JKRnlqUWFUMzF4Slo3WWVDWE5NeDhnaE95SFhpMzRjWk4wNFBTZkh4?=
 =?utf-8?B?ZDdzN3ovaWxLeGIrS01rSHNsQi9IY3I3MlZubE42enN3Tml1UHZFTnZXeklM?=
 =?utf-8?B?T1JYcTc3bXZVbWRuWTY5ck5MaFdKeWZLTmFEbnFLZTVEMnJLRUZRdm1wNXgx?=
 =?utf-8?B?TGkwZ1AvYUZtSTVPWDN1SUdDMU5jUjFtUWU0WlhtNC9nQnB1TjRzdklFZE5o?=
 =?utf-8?B?dkE1WlZNck8rZ296WWNUWlcxYWhiSnNDaTBPdEw4ZXVrTTRkeGRXaFhmdVo5?=
 =?utf-8?B?ZDJmWHlLT1A0NHljMHJVVURVZnNXVVB0UVE3RDluUHNNQkNaOGZkcTZ4WTZu?=
 =?utf-8?B?TGllc3ZyZm9YNTRPZWtBNUlSSXdvNGh5c3RLT0dvTm9Kc2V3WFNlM1ZmQTVl?=
 =?utf-8?B?d1lQOGRKQm1Gb0E2VXJEbS9rRGpreUhMbmJCS2lUV01ZbUNuNFF0VlZ0NHNM?=
 =?utf-8?B?eURLU3VxNWtncnFwLy9vL0MvN2JBcExwRE11Wk5CQzNaR3QrbG1jNndnSm91?=
 =?utf-8?B?VkNGVXRxNXk5RmdqZ0VtU3BQeUpmYW9qY0F4NmQ1YzA3aVVTZCtYcXJRNXdX?=
 =?utf-8?B?d0EwMjRvRE1mckNnbmNBZys0TExRUGEvOW9yRUFNQ09SOXhFSlU1a0o0dWZk?=
 =?utf-8?B?ODEvcndML21BSmVDQkNKK0NRdUNDTHhYU2wvd09LQWJwRmpvN09tZUlrR2lN?=
 =?utf-8?B?S0J3cUhxTjhDSW5JN0tnbzVuR1pWeHdxcHI5dWdPQzJ3QXA3d2VLTXN1L2Ew?=
 =?utf-8?B?WlZiWVphcDZ1STRxbWd0UkJrUU9iM08wN0J5MVlZU0pzblhpTEtpb3BhbkhE?=
 =?utf-8?B?ZWxJMmlpNFFaZ2NPYlNPVndpR3IyL1NOcmIyQ2xRRXJDeEZ5aHJVcXJxbHFB?=
 =?utf-8?B?SktYa255Y3g2bVRjWStlcXdiOEZVVWx2b01KdjhUbWJqZUR5R2p3VXAvUUk4?=
 =?utf-8?B?T0ljMEFjVVVGYnc1cExaZlV6TjJmTFFieVZldXBicENvL0xVUHNIWUdEdWc3?=
 =?utf-8?B?TFczbDFzc2d0cDV3YzFrdjl5cXE0ZDJDVXo3RTVnL0hBaVFvVGpHYUUvNU1K?=
 =?utf-8?B?aCtmN2pGM1dYZEJrakNjTEppOEhxOTluNVU5d1hoamRtUUtxdUhHSGErdWxI?=
 =?utf-8?B?bzNUSDNieXUyZ24zbldYNUk2VGFWZW10QzJkT1M0UWpBSDRIVExleVdJbzYz?=
 =?utf-8?B?SkpNVHE5REdyOFlEVU1EYWxDMWl4aUVKdlNqMC95ekJHaFNGN25LSXpvekZ2?=
 =?utf-8?B?NmQ4L0JUcm5LckZ3c0FZSDJ1cE9JRUQ3TkViTWRtb1FIWGVwV3JFLzVzbUhB?=
 =?utf-8?B?U0dVWk9aaTY1RjZjMmswMW5HamthNmFHRlBrdERrNzU1c1FqNkRvb0cxM3RV?=
 =?utf-8?Q?fm+jmQX01pZ+9j/0RvTmdfAvLQhhlJ3pLjKZPhI?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe2eb60-66c7-458a-51e2-08d8f34f28f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 07:40:58.5499 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I2nWgqx4H3zQyblU8A/KDafUxyeHL0mF3y5zvhaZyyng3LXuz2R176VHsMxHUlHu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3413
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQo+
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29l
bmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4NCj5TZW50OiBUdWVzZGF5LCBNYXJjaCAzMCwg
MjAyMSAzOjI0IFBNDQo+VG86IERlbmcsIEVtaWx5IDxFbWlseS5EZW5nQGFtZC5jb20+OyBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsNCj5EZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRl
ci5EZXVjaGVyQGFtZC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCA1LzZdIGRybS9hbWRncHU6
IERpc2FibGUgUlBUUiB3cml0ZSBiYWNrIGZvciBuYXZpMTINCj4NCj5BbSAzMC4wMy4yMSB1bSAw
OToyMCBzY2hyaWViIERlbmcsIEVtaWx5Og0KPj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIElu
dGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KPj4NCj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPj4+IEZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5A
Z21haWwuY29tPg0KPj4+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDMwLCAyMDIxIDM6MTMgUE0NCj4+
PiBUbzogRGVuZywgRW1pbHkgPEVtaWx5LkRlbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnDQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCA1LzZdIGRybS9hbWRncHU6IERp
c2FibGUgUlBUUiB3cml0ZSBiYWNrIGZvcg0KPj4+IG5hdmkxMg0KPj4+DQo+Pj4NCj4+Pg0KPj4+
IEFtIDMwLjAzLjIxIHVtIDA2OjQxIHNjaHJpZWIgRW1pbHkgRGVuZzoNCj4+Pj4gSXQgd2lsbCBo
aXQgcmFtZG9tbHkgc2RtYSBoYW5nLCBhbmQgcGVuZGluZyBvbiB1dGNsMiBhZGRyZXNzDQo+Pj4+
IHRyYW5zbGF0aW9uIHdoZW4gYWNjZXNzIHRoZSBSUFRSIHBvbGxpbmcgYWRkcmVzcy4NCj4+Pj4N
Cj4+Pj4gQWNjb3JkaW5nIHNkbWEgZmlybXdhcmUgdGVhbSBtZW50aW9uZWQsIHRoZSBSUFRSIHdy
aXRlYmFjayBpcyBkb25lDQo+Pj4+IGJ5IGhhcmR3YXJlIGF1dG9tYXRpY2FsbHksIGFuZCB3aWxs
IGhpdCBpc3N1ZSB3aGVuIGNsb2NrIGdhdGluZyBvY2N1cnMuDQo+Pj4+IFNvIHN0b3AgdXNpbmcg
dGhlIHJwdHIgd3JpdGUgYmFjayBmb3Igc2RtYTUuMC4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1i
eTogRW1pbHkgRGVuZyA8RW1pbHkuRGVuZ0BhbWQuY29tPg0KPj4+PiAtLS0NCj4+Pj4gICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8wLmMgfCAxOCArKysrKysrKysrKystLS0t
LS0NCj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25z
KC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9z
ZG1hX3Y1XzAuYw0KPj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMC5j
DQo+Pj4+IGluZGV4IDkyMGZjNmQ0YTEyNy4uNjNlNGE3ODE4MWI4IDEwMDY0NA0KPj4+PiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzAuYw0KPj4+PiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzAuYw0KPj4+PiBAQCAtMjk4LDEzICsyOTgs
MTkgQEAgc3RhdGljIHZvaWQNCj4+PiBzZG1hX3Y1XzBfcmluZ19wYXRjaF9jb25kX2V4ZWMoc3Ry
dWN0IGFtZGdwdV9yaW5nICpyaW5nLA0KPj4+PiAgICAgKi8NCj4+Pj4gICAgc3RhdGljIHVpbnQ2
NF90IHNkbWFfdjVfMF9yaW5nX2dldF9ycHRyKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykNCj4+
Pj4gICAgew0KPj4+PiAtdTY0ICpycHRyOw0KPj4+PiArc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYgPSByaW5nLT5hZGV2Ow0KPj4+PiArdTY0IHJwdHI7DQo+Pj4+ICt1MzIgbG93Yml0LCBoaWdo
Yml0Ow0KPj4+PiArDQo+Pj4+ICtsb3diaXQgPSBSUkVHMzIoc2RtYV92NV8wX2dldF9yZWdfb2Zm
c2V0KGFkZXYsIHJpbmctPm1lLA0KPj4+IG1tU0RNQTBfR0ZYX1JCX1JQVFIpKTsNCj4+Pj4gK2hp
Z2hiaXQgPSBSUkVHMzIoc2RtYV92NV8wX2dldF9yZWdfb2Zmc2V0KGFkZXYsIHJpbmctPm1lLA0K
Pj4+PiArbW1TRE1BMF9HRlhfUkJfUlBUUl9ISSkpOw0KPj4+IFRoYXQgd29uJ3Qgd29yayBsaWtl
IHRoaXMuDQo+Pj4NCj4+PiBXZSBoYXZlIHRoZSByZWFkcG9pbnRlciB3cml0ZWJhY2sgYmVjYXVz
ZSB3ZSBvdGhlcndpc2UgY2FuJ3QNCj4+PiBndWFyYW50ZWUgdGhhdCB0aGUgdHdvIDMyYml0IHZh
bHVlcyByZWFkIGZyb20gdGhlIHJlZ2lzdGVycyBhcmUgY29oZXJlbnQuDQo+Pj4NCj4+PiBJbiBv
dGhlciB3b3JkcyBpdCBjYW4gYmUgdGhhdCB0aGUgaGkgcnB0ciBpcyBhbHJlYWR5IHdyYXBwZWQg
YXJvdW5kDQo+Pj4gd2hpbGUgdGhlIGxvIGlzIHN0aWxsIHRoZSBvbGQgdmFsdWUuDQo+Pj4NCj4+
PiBXaHkgZXhhY3RseSBkb2Vzbid0IHRoZSB3cml0ZWJhY2sgd29yaz8NCj4+Pg0KPj4+IENocmlz
dGlhbi4NCj4+IElzc3VlIG9jY3Vycywgd2hlbiBvY2N1cnMgY2xvY2tnYXRpbmcsIGF0IHRoZSBz
YW1lIHRpbWUsIHRoZSBycHRyIHdyaXRlIGJhY2sNCj5vY2N1cnMuIEF0IHRoaXMgdGltZSwgdGhl
IHV0Y2wyIHRyYW5zbGF0aW9uIHdpbGwgaGFuZy4NCj4NCj5NaG0sIGNyYXAuIEFsZXggYXJlIHlv
dSB1cCB0byBkYXRlIG9uIHRoaXMgYnVnPw0KPg0KPkknbSBub3QgYW4gZXhwZXJ0IG9uIHRoZSBT
RE1BLCBidXQgbXkgbGFzdCBzdGF0dXMgaXMgdGhhdCB3cml0ZWJhY2sgaXMNCj5tYW5kYXRvcnkg
d2hlbiB3ZSB1c2UgNjRiaXQgcnB0ci93cHRyLg0KPg0KPk90aGVyd2lzZSB3ZSBuZWVkIGEgd29y
a2Fyb3VuZCBob3cgdG8gcmVhZCBhIGNvbnNpc3RlbnQgNjRiaXQgcnB0ciBmcm9tDQo+dHdvIDMy
Yml0IHJlZ2lzdGVycy4NCj4NCj5DYW4geW91IGNoZWNrIHRoZSByZWdpc3RlciBkb2N1bWVudGF0
aW9uIGlmIHRoZXJlIGlzIGFueSBkb3VibGUgYnVmZmVyaW5nIG9yDQo+c3R1ZmYgbGlrZSB0aGF0
Pw0KPg0KPkNocmlzdGlhbi4NCkhpIENocmlzdGlhbiwNCiAgICAgVGhhbmtzIHRvIHBvaW50IG91
dCB0aGUgaW5jb25zaXN0ZW50IGlzc3VlIGZvciA2NCBiaXQgcmVnaXN0ZXIuIFBsZWFzZSBpZ25v
cmUgdGhpcyBwYXRjaC4gV2lsbCB0cnkgdG8gZml4IHRoZSBpc3N1ZSBpbiBzZG1hIGZpcm13YXJl
Lg0KDQpCZXN0IHdpc2hlcw0KRW1pbHkgRGVuZw0KDQoNCj4NCj4+Pj4gLS8qIFhYWCBjaGVjayBp
ZiBzd2FwcGluZyBpcyBuZWNlc3Nhcnkgb24gQkUgKi8gLXJwdHIgPSAoKHU2NA0KPj4+PiAqKSZy
aW5nLT5hZGV2LT53Yi53YltyaW5nLT5ycHRyX29mZnNdKTsNCj4+Pj4gK3JwdHIgPSBoaWdoYml0
Ow0KPj4+PiArcnB0ciA9IHJwdHIgPDwgMzI7DQo+Pj4+ICtycHRyIHw9IGxvd2JpdDsNCj4+Pj4N
Cj4+Pj4gLURSTV9ERUJVRygicnB0ciBiZWZvcmUgc2hpZnQgPT0gMHglMDE2bGx4XG4iLCAqcnB0
cik7IC1yZXR1cm4NCj4+Pj4gKCgqcnB0cikgPj4gMik7DQo+Pj4+ICtEUk1fREVCVUcoInJwdHIg
YmVmb3JlIHNoaWZ0ID09IDB4JTAxNmxseFxuIiwgcnB0cik7IHJldHVybiAocnB0cg0KPj4+PiAr
Pj4gMik7DQo+Pj4+ICAgIH0NCj4+Pj4NCj4+Pj4gICAgLyoqDQo+Pj4+IEBAIC03MDIsNyArNzA4
LDcgQEAgc3RhdGljIGludCBzZG1hX3Y1XzBfZ2Z4X3Jlc3VtZShzdHJ1Y3QNCj4+PiBhbWRncHVf
ZGV2aWNlICphZGV2KQ0KPj4+PiAgICBXUkVHMzIoc2RtYV92NV8wX2dldF9yZWdfb2Zmc2V0KGFk
ZXYsIGksDQo+Pj4gbW1TRE1BMF9HRlhfUkJfUlBUUl9BRERSX0xPKSwNCj4+Pj4gICAgICAgICAg
IGxvd2VyXzMyX2JpdHMoYWRldi0+d2IuZ3B1X2FkZHIgKyB3Yl9vZmZzZXQpICYNCj4+PiAweEZG
RkZGRkZDKTsNCj4+Pj4gLXJiX2NudGwgPSBSRUdfU0VUX0ZJRUxEKHJiX2NudGwsIFNETUEwX0dG
WF9SQl9DTlRMLA0KPj4+IFJQVFJfV1JJVEVCQUNLX0VOQUJMRSwgMSk7DQo+Pj4+ICtyYl9jbnRs
ID0gUkVHX1NFVF9GSUVMRChyYl9jbnRsLCBTRE1BMF9HRlhfUkJfQ05UTCwNCj4+Pj4gK1JQVFJf
V1JJVEVCQUNLX0VOQUJMRSwgMCk7DQo+Pj4+DQo+Pj4+ICAgIFdSRUczMihzZG1hX3Y1XzBfZ2V0
X3JlZ19vZmZzZXQoYWRldiwgaSwNCj4+PiBtbVNETUEwX0dGWF9SQl9CQVNFKSwgcmluZy0+Z3B1
X2FkZHIgPj4gOCk7DQo+Pj4+ICAgIFdSRUczMihzZG1hX3Y1XzBfZ2V0X3JlZ19vZmZzZXQoYWRl
diwgaSwNCj4+PiBtbVNETUEwX0dGWF9SQl9CQVNFX0hJKSwNCj4+Pj4gcmluZy0+Z3B1X2FkZHIg
Pj4gNDApOw0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
