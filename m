Return-Path: <SRS0=iyzK=O7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53486C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 06:37:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0675D608FB
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 06:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0675D608FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77A9D89F0A;
	Mon, 11 Oct 2021 06:37:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C019389F0A
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 06:37:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+JHzSmUa95A0fb9TGHgrEyFh7dI/JIsK0CoMbviGPdI64+uHYZgKSFopgTFgl4Z7da+wj6riKdfKQTbnRpDeKI2HE5AOPt9jD/AqNczX3mnKr8zDwz2ahkmQjOoaeSesd+eBScut58gkI/G9wtnlXBhL4+MB3Lmxt+2WqPE+fRNUKR3S6o+nmJGT7WA3l2UBIza3apd7/yUYPEsu4XQ6Q5PmA9ceX6lz0yyTEg/qPv/6jKs+Mr/t/Xqb4NcpzjslR+fUei5rCen8YMP20opoaDbo1F5E4ANBPTpm5bsd2JuZm+cyDVD1ylOHSmusjo8dOVlkN6BeD0jpFE3RGljhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOjdxMiLsngmpmNuweNZMZFqBDdLIdgSl2iKnDTDlNs=;
 b=PEndN4/U5Mc8soEzbeyA8GV7wewJQ5jnYqcyBLgt+SqQroZQ5aHVTDHNH5uo2fHpA622hWgkyhlWd0b3p81bP7UIXZcd1+aWWEWRA4u/yqmvSOIGGXgcEYzBHVIxgsIq88ou5+tQ2zKn1Hmea4pFaRcx1y76pbW5jru+xEPYx0YKbH6Ajs2Oc305nQD/FRKr2smz6J0m5mEJE2YgvfXPQ8BMY4XqFKGYXc0kaR4i03sBXUCBjgKnlVKm5oyAIUUqqFH2+pHhs57bJ1NNERhx3+Dr5Iymitpm12XZlaWltqK46K1gI8wCzrfB15CK2RVaTSlNalJUYEPIj5Tmmms8AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOjdxMiLsngmpmNuweNZMZFqBDdLIdgSl2iKnDTDlNs=;
 b=eezgC42nQ58J8XIdS4lrfg9SnlThXe275SqwGo0wpWC/mPmXxBkWswtJfPA3gtJJc70F+3fHZi4fCaAsbPa2JDu9IfY/OnLhptvn+xLuTfbfVMq7brPYar884aFFCdsCNJXjGFZi250QYeK3MT6uef+CvYaUIJIwdXUPLDxOakA=
Received: from BN6PR12MB1187.namprd12.prod.outlook.com (2603:10b6:404:1b::19)
 by BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Mon, 11 Oct
 2021 06:37:19 +0000
Received: from BN6PR12MB1187.namprd12.prod.outlook.com
 ([fe80::84b6:69c0:9fb7:cd1d]) by BN6PR12MB1187.namprd12.prod.outlook.com
 ([fe80::84b6:69c0:9fb7:cd1d%5]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 06:37:19 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: youling 257 <youling257@gmail.com>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device init
Thread-Topic: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device init
Thread-Index: AQHXtELZo07wLtaE6kqRLoUB3h9VLqvNZa4AgAABQ4CAAAPHMA==
Date: Mon, 11 Oct 2021 06:37:19 +0000
Message-ID: <BN6PR12MB1187C0DF06EF236EC7BD5A08C1B59@BN6PR12MB1187.namprd12.prod.outlook.com>
References: <20210928082819.205231-2-yifan1.zhang@amd.com>
 <20211011061326.13718-1-youling257@gmail.com>
 <CAOzgRdaG2Zo-_kDGo2d-AZ0zoSHHW5T_dh9HFrk46i3kXiMitg@mail.gmail.com>
In-Reply-To: <CAOzgRdaG2Zo-_kDGo2d-AZ0zoSHHW5T_dh9HFrk46i3kXiMitg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-11T06:37:16Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=0d2c9afb-cdce-4e45-92fc-f0accb4c304a;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 078b75f1-6f42-42e9-4e9b-08d98c8192df
x-ms-traffictypediagnostic: BN8PR12MB3108:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR12MB3108EBE88C0F3F1D0F7332DAC1B59@BN8PR12MB3108.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q2BtzVH3aua5nzWvzrBhftGzb3SxHL1RjDXjPO9+AmkvLotrwHjZUhC1UXe8Fui1E+vRt47g+Tl9WfJWwUrCBzjrpe61xgjTEedfbOVFNoKFbeCWsa4V86MYghsF1Td9OcNT+luWkbs3yFvAi0B/xzDv98jD39aakcdMlwFKhZ9Pg+f60sYDF6+az2qFpCCt5mCDLvc14SSz3Xyd3ELxkMYe4EtspKqwC4Vj8gKVckTKzG7sKK0TUSHpiDR/YYQ7DJEUX83b3if7UMOL0iA7QjNY3n3/J0dPeVTgwaF4S6EPVmAcRrzAkugoSNjNjyNksKhXaOK6gvbEi0635KIhzPcYrRMB6AgXrnDS3r2fvjU9lnrlHOoV8QyAykOZ25L1nPuf6cozXM/6MuGxgMKQC17wIDWgcBfTx8brSQMSSebH9GE5C2xH774OuEcFWUIlIzQwbLhzTLL19wIXZW4arid7ILNDnNZB2xn0I6zcZJBvZajdjUHtSbj65Xb3fw13LFBtmlP4jfw7gKt0hiZ8SKRvNaO1sD5dQI/aXZLjjs7Jo9/PSxkEQjZVllhp8QN/B+ku2fK1vEOo9PReQl/lFZIz2sREu/HoFafbajAFIEGXExf2x+gji4xdA7xLnwMmFW1O9x0aNMWi05J44Xmqg423WrEjtONV5oGLb8I8FOKebbB0jj+n1eqZN+F4d60h58oaDQgXAnmHYFdiAeN1FA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1187.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(7696005)(508600001)(76116006)(66476007)(66556008)(64756008)(53546011)(8676002)(186003)(71200400001)(66446008)(9686003)(122000001)(6506007)(4001150100001)(26005)(8936002)(66946007)(55016002)(6916009)(52536014)(4326008)(54906003)(2906002)(83380400001)(38070700005)(38100700002)(86362001)(316002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDE0cm9ud2hGT3hRSkdMb0VicE5oVzZ1bmZMWk1oSkZWbytLUFV6WW1uSGFI?=
 =?utf-8?B?TjBXeUZzWXMvVDZBeDRQTEN2M3V3VE9SaTdMc3pVVEhoNjExekpjOTI1QWd3?=
 =?utf-8?B?SW8xSlhKNkQ3aTBZYmlpRDQ2bGtIVTdTRHlyOExBYVkzVTZzT0wvQ2RwL3M0?=
 =?utf-8?B?cGZjMEI1cmFid0M0V2F2SVhEK0FtYUNoQVFMNG5SQWJBdEN5RUc1czdVd2sx?=
 =?utf-8?B?Q0ttc0p4bFA0cnZGb05pZkc3SVpJMjQ2aWU0dnJGZ09PTVlTS0ZrNE50UFNF?=
 =?utf-8?B?OG56b2VjQ3o1VHgvM1VQY0pEL0Z3dyswZEs1bVgzLzhERld5by9pQm5sdHVY?=
 =?utf-8?B?cWl2NFZOMkowTFhpbFdJK3NaWjdiZ0xDUkZFUjlDNWdmcis3bkNwcWZ1SHg4?=
 =?utf-8?B?ZFZaWTd5MGd4bmlYVTVvVjRGTG9XQkwvNW1mOHdldktlSmZyNmxDNG1NOGtT?=
 =?utf-8?B?S2lLaE9RWVJRL2U2ZktiTlR1ZmpwTVRPYUFDSUVWOVhlaWVPVmNjdVQvMDA3?=
 =?utf-8?B?bU5LV0NXYThiOU5YL2lQQUNXb3Bocm04U0QxKzh5MmFzeXNNM2JtRWp0N0xp?=
 =?utf-8?B?b3hZbHRUSFlwMXZDaEVFRXhGMTBxUVQyYkJUNHNoMUNKTnVBd0FqT1dUUHhL?=
 =?utf-8?B?R0JMWkpEMEg1MzZDMXJTZUpnK2ltcERDaHNmb1BxR0N1NFdLUVV3VXBFUHpQ?=
 =?utf-8?B?ZWF1RmV3ZXQvU1VWOUFMZWEzMHpVVkNHeCtFdUxQSkxHNFVEeWh6TFpJUmpH?=
 =?utf-8?B?aUprNk1kNWszRXFhVGFiZXR2UHJWeXJ6Q0dsS3phSGE3ckpvdDVnVlYrbW04?=
 =?utf-8?B?K1hDTTIrSUJOSGE0SytUb3VLcm9uLzRmVzBiMVh2WmdVMUNDbVFXTitwRXph?=
 =?utf-8?B?ZmZwdllYSUVRWU95b1FGRGRxSGVSRU9Qc0MzUnE3dlFZa3JOWm1veTEvTjU2?=
 =?utf-8?B?dmdWRjhpb0F1MlViTXJrREdoNFF0TEtZM0tURFBHTTdFM0FaU0pQSEtpaSsv?=
 =?utf-8?B?b1JwSEdlRE4rSEFUeG45VEpST0tRa2FrMlJBdjdHeGZyczljRFVLV252ekxK?=
 =?utf-8?B?UnlNdzIyNEpFNi95dzE0aWNRMHZLMmxFWGdsQ3I2eFA0QUhkTjA0RFlxalYz?=
 =?utf-8?B?TDJzN0JGZHpKeXY0NWlnK0piUnZhYzFVRTZVL2tWK0JhNXdUT0hJajcrNk1Q?=
 =?utf-8?B?akxiWk9TaW1PZG5rUVljMHhWcFBoUjJoZ0I2YVVaekIvQUpzN004Q001Vml1?=
 =?utf-8?B?Z2EzTXB0aWxicFJmNEpCdmZtZmI1d0FpRUlwNUhKQmw1ZWVsSndiWGtVTXJt?=
 =?utf-8?B?L2FRTnVKVmM3WHhvbm9YVm9uZm9RSGxvTTltV3pFeUc0Q0dMK1RabkVjMUFv?=
 =?utf-8?B?Tmg5UGpxbzd0aEV5MHlCcyszMll5eStUcXRPNitFNEM3WEVNTkUyVFdJZFpQ?=
 =?utf-8?B?ellKK0UvT0c2UEhkbjkrUTM5dWRoejJ2OUxjRE5BTkRITGVhckhvTG13WVhR?=
 =?utf-8?B?NmNaTUNuMVg1NElKdDZNV3JBNlZIQXRNdGc4MVQwcG5UbDd3SEFyTTl5Yjlr?=
 =?utf-8?B?L1VwVktRTERSWmtydHg4MUtnaTZVY2p6Z3FwdFI2TUhHdDFhcW4vZFMvVjNn?=
 =?utf-8?B?N1FKWElGeGdJb2dYd1hRSVZ6YmRGcVdsN3I4WXBaaVZkQ3A4ZUNqQTE2SW9Z?=
 =?utf-8?B?bjVXODMyVjN6WmFQamIyNEJBc05ZWjhtYzYxM3NodGxQZlpybktLTUxucVFh?=
 =?utf-8?Q?5ka0eKOJ/E9xUbqZe3TJSpxDHLbewvahL9FL/+g?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1187.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078b75f1-6f42-42e9-4e9b-08d98c8192df
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2021 06:37:19.1384 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oO3/a2C743hrJQzzFOsUzPuWIr2QydKc+MzZDL7b9UgT7+CtqRot+Ce3Y3jsVW09
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3108
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSGkgeW91bGluZywNCg0KV291bGQgeW91IHBsZWFz
ZSBzZW5kIG91dCB0aGUgZnVsbCBkbWVzZyA/IA0KDQpCUnMsDQpZaWZhbg0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogeW91bGluZyAyNTcgPHlvdWxpbmcyNTdAZ21haWwuY29t
PiANClNlbnQ6IE1vbmRheSwgT2N0b2JlciAxMSwgMjAyMSAyOjE4IFBNDQpUbzogWmhhbmcsIFlp
ZmFuIDxZaWZhbjEuWmhhbmdAYW1kLmNvbT4NCkNjOiBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1
ZWhsaW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVjdDog
UmU6IFtQQVRDSCAyLzJdIGRybS9hbWRncHU6IGluaXQgaW9tbXUgYWZ0ZXIgYW1ka2ZkIGRldmlj
ZSBpbml0DQoNCmRybS9hbWRncHU6IGluaXQgaW9tbXUgYWZ0ZXIgYW1ka2ZkIGRldmljZSBpbml0
IGJ1dCBDT05GSUdfQU1EX0lPTU1VPXkgQ09ORklHX0FNRF9JT01NVV9WMj15DQpbICAgIDAuMjAz
Mzg2XSBBTUQtVmk6IEFNRCBJT01NVXYyIGRyaXZlciBieSBKb2VyZyBSb2VkZWwgPGpyb2VkZWxA
c3VzZS5kZT4NClsgICAgMC4yMDMzODddIEFNRC1WaTogQU1EIElPTU1VdjIgZnVuY3Rpb25hbGl0
eSBub3QgYXZhaWxhYmxlIG9uIHRoaXMgc3lzdGVtDQpbICAgIDcuNjIyMDUyXSBrZmQga2ZkOiBh
bWRncHU6IEFsbG9jYXRlZCAzOTY5MDU2IGJ5dGVzIG9uIGdhcnQNClsgICAgNy42MjIxMjhdIGtm
ZCBrZmQ6IGFtZGdwdTogZXJyb3IgZ2V0dGluZyBpb21tdSBpbmZvLiBpcyB0aGUgaW9tbXUgZW5h
YmxlZD8NClsgICAgNy42MjIxMjldIGtmZCBrZmQ6IGFtZGdwdTogRXJyb3IgaW5pdGlhbGl6aW5n
IGlvbW11djINClsgICAgNy42MjI0MzBdIGtmZCBrZmQ6IGFtZGdwdTogZGV2aWNlIDEwMDI6MTVk
OCBOT1QgYWRkZWQgZHVlIHRvIGVycm9ycw0KDQoyMDIxLTEwLTExIDE0OjEzIEdNVCswODowMCwg
eW91bGluZzI1NyA8eW91bGluZzI1N0BnbWFpbC5jb20+Og0KPiBteSBrZXJuZWwgY29uZmlnIENP
TkZJR19BTURfSU9NTVU9eSBDT05GSUdfQU1EX0lPTU1VX1YyPXkuDQo+IGxpbnV4IGtlcm5lbCA1
LjE1cmMyICJkcm0vYW1kZ3B1OiBtb3ZlIGlvbW11X3Jlc3VtZSBiZWZvcmUgaXAgaW5pdC9yZXN1
bWUiDQo+IGNhdXNlIG15IGFtZCAzNDAwZyBzdXNwZW5kIHRvIGRpc2sgcmVzdW1lIGZhaWxlZCwg
aGF2ZSB0byBwcmVzcyBwb3dlciANCj4gYnV0dG9uIHRvIGZvcmNlIHNodXRkb3duLg0KPiBsaW51
eCBrZXJuZWwgNS4xNXJjNSAiZHJtL2FtZGdwdTogaW5pdCBpb21tdSBhZnRlciBhbWRrZmQgZGV2
aWNlIGluaXQiIA0KPiBjYXVzZSBteSBhbWQgMzQwMGcgYmxhY2tzY3JlZW4gd2hlbiBib290IGVu
dGVyIG15IHVzZXJzcGFjZS4NCj4gaSBuZWVkIHJldmVydCAiZHJtL2FtZGdwdTogaW5pdCBpb21t
dSBhZnRlciBhbWRrZmQgZGV2aWNlIGluaXQiIGFuZA0KPiAiZHJtL2FtZGdwdTogbW92ZSBpb21t
dV9yZXN1bWUgYmVmb3JlIGlwIGluaXQvcmVzdW1lIiBmb3IgbXkgDQo+IHVzZXJzcGFjZSwgcnVu
bmluZyBhbmRyb2lkeDg2IHdpdGggbWVzYTIxLjMgb24gYW1kZ3B1Lg0KPg0K
