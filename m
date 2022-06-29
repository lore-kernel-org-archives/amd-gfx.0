Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96126C43334
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jun 2022 00:03:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A0A411BAF7;
	Wed, 29 Jun 2022 00:03:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A52B711BAF7
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 00:03:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcCQAv6Q+I3AZ2sGYMZhWcQAG6R2V903/2r7tEWv1hM8z/9lkn7h5FtB7WKpMIyncPhb5kKL2NTu9pXNd63aMkz1m5N04mWX/KV697s/qWAz8e2jvoQa47mDBAE4acqDoL8vsmOFYWuMmU9jnE0javnKDchQxl3bA6IsVx0UgGir0LuleMRutMTATA/zG/oM80P1oF8GF29c8CRJfuY69L98/VxIULQtN3xB758AFrt92MGa0rdeYzN4S60ktWiddSKiirvr2Stk415VIYmN4HGUOoAAUNOH7ABhW5Tu3lZN/Ra8gNtEbS2euMBDYxihMnxNnggC2n3qEWdJwbHflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQcPD6E9cXphWYP4dCOvieGpocwxCua+LEad3xs0GCA=;
 b=mTL0gMHXDqFsUeF9V0ightXix/3DRbKk5VRdDr20tUnxjSROSM9JzzFiSKm+bWl3x3RRsXXijeT5tOPcTk286JtvUa2yADtBZNAvHEpA+6PKupr3mJIQPStupLcXz+APeYdIZuVIKqXiMaQTYJszeV+ZDbM39uIvaQ5p04L3mQ3BYrUv2BJwpKf1IgWGYRLUWhKYe08KyOxnA1tC53Ts6P2yYR7wrR3aM4paCOeY58GFy4SaNuDKNijGJe7XJ/99Kp2VSwGVUweDMlJYw8eRY8J9DXCmWCRTm+oPJielzqGtjsbG1om3vYuS00j67BPBq54fC4AoszTwWndQnKmWdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQcPD6E9cXphWYP4dCOvieGpocwxCua+LEad3xs0GCA=;
 b=THMudp0AiU1T+y54/WiNsSZanxx3jtKr+isDUSJD/bDXfDLkWZ7uuPtun6M7XMSkDiGDSfSBz3p/x2Iaf6hT1lqHN6rj4ad215iaG4jC3inZLx621zdb+kKM8TidEEgELV9RfreiPRB0+gLOnz9Si8ql9gnhCavjWQnwHKUHJNU=
Received: from SN1PR12MB2575.namprd12.prod.outlook.com (2603:10b6:802:25::14)
 by BY5PR12MB4871.namprd12.prod.outlook.com (2603:10b6:a03:1d1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Wed, 29 Jun
 2022 00:03:18 +0000
Received: from SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::fd9e:c9da:16b5:a35b]) by SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::fd9e:c9da:16b5:a35b%5]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 00:03:18 +0000
From: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
Subject: RE: [PATCH] drm/amdkfd: Fix warnings from static analyzer Smatch
Thread-Topic: [PATCH] drm/amdkfd: Fix warnings from static analyzer Smatch
Thread-Index: AQHYi0ZmJwh8SNuw3EmRE3n9zwdWGK1leoiAgAAEZPA=
Date: Wed, 29 Jun 2022 00:03:18 +0000
Message-ID: <SN1PR12MB2575F5E425FB5B43CB1BF119E3BB9@SN1PR12MB2575.namprd12.prod.outlook.com>
References: <20220628232538.1316250-1-Ramesh.Errabolu@amd.com>
 <846ecd13-edaf-c0eb-44a9-5232dca997c7@amd.com>
In-Reply-To: <846ecd13-edaf-c0eb-44a9-5232dca997c7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-29T00:03:14Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e48dbc9e-5c46-4bd2-b06c-14e284cc07a3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-06-29T00:03:14Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: b20144d5-9329-4d0d-8ba5-4920da3be12a
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 785a88d6-539d-4b41-0f28-08da5962c5ba
x-ms-traffictypediagnostic: BY5PR12MB4871:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ndCMUoGwXlpTPvQIGQcgcmtKOQVxl+LbmXGCVkHZuM89MXk6OsUqMRiU0EkLj25Tr/5/9VZmUC8uwtHHOxdPWzEDGkVWi4qj3PggstMu5wMiHMavdbTTUCtgTbx1P0DVXbrg7aK2iY9uULBQ/VBnQLzCBmBCnIewuKZ9n8HW9YykFzr+PPbEM1hC0uLxDA3uOczBgnZMUsj89tLx0t85qkvnhuGCZ3KAvDQGeUpanpgHq8B4+z/be1CN3ggaVHZYDGP4sIQhTgcg0wAqM8R/NR3ZmpVbmqQalRaUMMyDm1wnLli/2Zuhc6FKCN3VhfYINGVHX3HGyAZI6PNwImNSuNQbABh3BWWQMdvMNEvtmREgPQ19E7ThEkumB3yQYdfhEYSbmg7Wxz4fZ7BeWaLcHJ43BwNQclAVi94IPfQ29Fv+PAGptwK9HH3cbcMPPFpe1UGP8GSlOnP/Dx+WwYMlPgXDBmvsXoTNdhcniSh9/GfckTD3TuLbWbG34Iht7t9CjiVuJIvuK5M23nluFqeAbUK6P6eJ2YGTmhmsWoJuw0K8Igd6xzJWzQwStoZ3VXmrMDmFYRlQBmEjnZYWW4fkNAAe99zadzKA5GM49ZywDLstV4y/AKGeQNKGIhuLqf86C+9LjNbJ+3mJMJmOxylGJpcPIjw7lgZr4m9hjyxguBKVjd15z7H/SIyepuoIQ+Kmdw5ASU8uzdffqLlYHkb9dUJ3kfsvTEfz2+LyCmD0V39HqRnePVv6iplLb3PwDgKKOCkM3g3mPXw1bcf0pi5W1WF2IuyYQgWQqJjTU4x1mms=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2575.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(64756008)(55016003)(8676002)(66446008)(110136005)(66556008)(8936002)(26005)(66476007)(66946007)(7696005)(38070700005)(316002)(41300700001)(38100700002)(52536014)(9686003)(71200400001)(478600001)(6506007)(76116006)(83380400001)(2906002)(122000001)(53546011)(33656002)(86362001)(186003)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0p6NzZoNVo4Qzd5ZU5RUlVXdnR4RTNkUEdHUjlXYmRjWkxCWnZmOVc0NHQr?=
 =?utf-8?B?YkFXS1ZjMWNLTzVCN0pRZjBkUVROMVhaYk05bUx0dCtLTnJZaWc0cmc1MElj?=
 =?utf-8?B?REYvZ0pJYm45cG5naTMyL2NYb2pMb3VWSk1MaEhLeTRjdFJzSHhESHRTeGt1?=
 =?utf-8?B?RTRnM00xTDY1N3FaQ1VDZXJiZlRCUmI4ak80ZWlqNHA4U2E1YmhyZklvejlX?=
 =?utf-8?B?ekQxeEkvc1FObTN2Y2VVcVp6NjRkWHZ0MnhLZm13cDNSa3Q5eU8wa3VvbitE?=
 =?utf-8?B?V3RVZTVBK0VYVTRYZXpObDl0NlQrNmNpRzlZWUlkQUw2U083eHJFU1pTak9q?=
 =?utf-8?B?K3EzalBWMER2SHRpY0h5TDU4V1NaMzVNYXFrQmVFS0RrNnRaRmc2dUM3OUVU?=
 =?utf-8?B?cmw0RlhnQVNkdXhpMHFvOFVLK2FhdWtOQlJWVkJVRjRvdWdWdk04RFI5NzNj?=
 =?utf-8?B?L2wrYmdGeDZHMWszSmhMRjZHVEVxQm4yVTJ2bkJYWnRjeUhVYkF1ZHNuZGhh?=
 =?utf-8?B?ZURrbjcvMTFVcHYveVBnT0VrbkM0MjYyV05yaWM3YllJbkx3ejBqb0lkNU9F?=
 =?utf-8?B?bFhidkxKOGhDdkRKUnpPZ2JRTHNBazRMalRrSUJwWXRxVmJVSE1lTWRmcGlo?=
 =?utf-8?B?TUwrVzlkN0t6eGhRUUZ1bjJ6d3hzK0dFT0h2ZW5PM25vWmpVSFZQZktyRlRI?=
 =?utf-8?B?bkljeGpmcU82djkvdU9UTHptNVE5NjBBWUhncFBVYmkwUDIxNHl0VUdabVVt?=
 =?utf-8?B?b1VUdWtXK2VzQm00dG9XV3lNTWM2bTVMam9RNzB3NEN5Qk1wK20xRXBjMWxN?=
 =?utf-8?B?WXdUd0x4c1MvTktnNmlVbW96WWI0cjExRGNVaFFQNTZhb0dKZitBdmw4WlBj?=
 =?utf-8?B?MWZiL2RZaDZBWG9qY3dXTlFOTDRCZmNQM2NYcDlCZXBUNWwveSt4NWp3enRG?=
 =?utf-8?B?bXAyTjZ1R0U4Y0pqR0Uzb1pKUlFQMUlJQ1R2SzdtQnNGbTJwTmJXUXVkU1R0?=
 =?utf-8?B?akRXZEtsUUdrRFdBTHNUNGVybzVPa3BVeVJpWElzS0wrSW9TM0JkTlBGSmhB?=
 =?utf-8?B?WSs5Vm92OVd4Nmg4QU5OYnJ2WWRvWm56OVpxRFFrM0hTTnM1VkRCRVVIcEdH?=
 =?utf-8?B?VXZLU29STjJkRzhjS3VTMStyZUxzcjhtK1R3UWVHeHI1bmt0UnZ2T0pxVGxJ?=
 =?utf-8?B?aXhXamdXaks2U1JoRkRiRDVZOHF6cUV0SExHVlpyRzlWNTN3S044ZU5ONEV3?=
 =?utf-8?B?Zk9GVUZuay9TVVYyTFNyTjI1MUJXV3M1WWlKVWVaWHY3akZqb1A0M3QrQVJq?=
 =?utf-8?B?bmNrZFBTdzRLaW9wRXZLd1FlRWlKRm0zcTFyQlBnWFI3SHJER1lQZU01WExw?=
 =?utf-8?B?eU05OEFTT0w0OTVsRi9TYnU3TUJ1RzZWRHVnSU1mWEpXOVM0MXpFQlhsSUdP?=
 =?utf-8?B?ejFrUHZIdURvTjFScVNheWUzT2lyTG4zSkQvK1RYcURGaTZZTGtnOUlFNXVw?=
 =?utf-8?B?RVZxbVFCWXZxUWJXUGVjTTBGQ0ZOcjZKWTkzZkNZQWRmbjRONmNTcHBSLzgx?=
 =?utf-8?B?cnQ3QzVyZ0lTSjlGcUlIZnk1bmhyOUdEUzFHVU13N1FTZ1BpSERXYmFieWdH?=
 =?utf-8?B?QkVna0VNV1V6RFlpTzFYSi9PT0FVbmpxbG81UFFLbGZ5UjUwRWZTQjBtcUxE?=
 =?utf-8?B?TTd4dXEyMU83Y291UUUrd2xicVRBSHVCVDRlUTBQSFFnaVBuNHFLckVQcWUx?=
 =?utf-8?B?Y3lKa25ONVFZWkIzbVVkVDN2RnpiYVg5Vnh4YjgzS1ZkbmdvQ1hrdlhDYXgx?=
 =?utf-8?B?N3lNQWVJV2FKVUNNQkxhNXp2WFVONEpCeVVhVEo4Y1FMd2l2VWhRazZ4eTd0?=
 =?utf-8?B?R0lvQkJPUDhPYSt0bXJ1Y0dReDR6aHUzdlFzOE1GWHRtWThIVHhWV2p6amRE?=
 =?utf-8?B?Q3FKUjYrOTVFNW1NbytESFFNUVJOT2JueFdWd1dDMW0yT1BpcmEweW9RSnpE?=
 =?utf-8?B?cnBtS3AzbndpQ21JZDFnekNCMUpJWjE5aHIvUml2WUk2TVd2cjhJYi9ibTI0?=
 =?utf-8?B?V0tvV3kvMlZhQS91VDdvUmVMRlBQSm02WFJLRDhEMGN6SzhXdFFROVNMeVhQ?=
 =?utf-8?Q?KfQU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2575.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785a88d6-539d-4b41-0f28-08da5962c5ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 00:03:18.5006 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J3SFnFFxdzaBU/vXwEgqeRS/Ucwn9MLLlZWzAyHXKSAZ5CRUpMJGLqXuzTZtMtJrlytGWA+4aMPZzYwo6PndRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4871
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCk15IHJlc3BvbnNlcyBhcmUgaW5s
aW5lDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLdWVobGluZywgRmVsaXgg
PEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+IA0KU2VudDogVHVlc2RheSwgSnVuZSAyOCwgMjAyMiA2
OjQxIFBNDQpUbzogRXJyYWJvbHUsIFJhbWVzaCA8UmFtZXNoLkVycmFib2x1QGFtZC5jb20+OyBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tDQpT
dWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1ka2ZkOiBGaXggd2FybmluZ3MgZnJvbSBzdGF0aWMg
YW5hbHl6ZXIgU21hdGNoDQoNCg0KQW0gMjAyMi0wNi0yOCB1bSAxOToyNSBzY2hyaWViIFJhbWVz
aCBFcnJhYm9sdToNCj4gVGhlIHBhdGNoIGZpeGVzIGNvdXBsZSBvZiB3YXJuaW5ncywgYXMgcmVw
b3J0ZWQgYnkgU21hdGNoIGEgc3RhdGljIA0KPiBhbmFseXplcg0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBSYW1lc2ggRXJyYWJvbHUgPFJhbWVzaC5FcnJhYm9sdUBhbWQuY29tPg0KPiBSZXBvcnRlZC1i
eTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tPg0KPiAtLS0NCj4gICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYyB8IDM2ICsrKysrKysrKysr
Ky0tLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDE3IGRl
bGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX3RvcG9sb2d5LmMgDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9s
b2d5LmMNCj4gaW5kZXggMjU5OTBiZWM2MDBkLi45ZDdiOWFkNzBiYzggMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jDQo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jDQo+IEBAIC0xNDE3LDE1ICsxNDE3
LDE3IEBAIHN0YXRpYyBpbnQgDQo+IGtmZF9jcmVhdGVfaW5kaXJlY3RfbGlua19wcm9wKHN0cnVj
dCBrZmRfdG9wb2xvZ3lfZGV2aWNlICprZGV2LCBpbnQgZw0KPiAgIA0KPiAgIAkJLyogZmluZCBD
UFUgPC0tPiAgQ1BVIGxpbmtzICovDQo+ICAgCQljcHVfZGV2ID0ga2ZkX3RvcG9sb2d5X2Rldmlj
ZV9ieV9wcm94aW1pdHlfZG9tYWluKGkpOw0KPiAtCQlpZiAoY3B1X2Rldikgew0KPiAtCQkJbGlz
dF9mb3JfZWFjaF9lbnRyeShjcHVfbGluaywNCj4gLQkJCQkJJmNwdV9kZXYtPmlvX2xpbmtfcHJv
cHMsIGxpc3QpIHsNCj4gLQkJCQlpZiAoY3B1X2xpbmstPm5vZGVfdG8gPT0gZ3B1X2xpbmstPm5v
ZGVfdG8pDQo+IC0JCQkJCWJyZWFrOw0KPiAtCQkJfQ0KPiAtCQl9DQo+ICsJCWlmICghY3B1X2Rl
dikNCj4gKwkJCWNvbnRpbnVlOw0KPiArDQo+ICsJCWNwdV9saW5rID0gTlVMTDsNCg0KVGhpcyBp
bml0aWFsaXphdGlvbiBpcyB1bm5lY2Vzc2FyeS4gbGlzdF9mb3JfZWFjaF9lbnRyeSB3aWxsIGFs
d2F5cyBpbml0aWFsaXplIGl0Lg0KDQoNCj4gKwkJbGlzdF9mb3JfZWFjaF9lbnRyeShjcHVfbGlu
aywgJmNwdV9kZXYtPmlvX2xpbmtfcHJvcHMsIGxpc3QpDQo+ICsJCQlpZiAoY3B1X2xpbmstPm5v
ZGVfdG8gPT0gZ3B1X2xpbmstPm5vZGVfdG8pDQo+ICsJCQkJYnJlYWs7DQo+ICAgDQo+IC0JCWlm
IChjcHVfbGluay0+bm9kZV90byAhPSBncHVfbGluay0+bm9kZV90bykNCj4gKwkJLyogRW5zdXJl
cyB3ZSBkaWRuJ3QgZXhpdCBmcm9tIGxpc3Qgc2VhcmNoIHdpdGggbm8gaGl0cyAqLw0KPiArCQlp
ZiAobGlzdF9lbnRyeV9pc19oZWFkKGNwdV9saW5rLCAmY3B1X2Rldi0+aW9fbGlua19wcm9wcywg
bGlzdCkgfHwNCj4gKwkJCShjcHVfbGluay0+bm9kZV90byAhPSBncHVfbGluay0+bm9kZV90bykp
DQoNClRoZSBzZWNvbmQgY29uZGl0aW9uIGlzIHJlZHVuZGFudC4gSWYgdGhlIGxpc3QgZW50cnkg
aXMgbm90IHRoZSBoZWFkLCANCnRoZSBub2RlX3RvIG11c3QgaGF2ZSBhbHJlYWR5IG1hdGNoZWQg
aW4gdGhlIGxvb3AuDQoNClJhbWVzaDogU3ludGFjdGljYWxseSwgaXQgaXMgcG9zc2libGUgdG8g
d2FsayBkb3duIHRoZSBsaXN0IHdpdGhvdXQgaGF2aW5nIHRoZSBoaXQuIFRoZSBjaGVjayBsaXN0
X2VudHJ5X2lzX2hlYWQoKSBpcyBmb3IgdGhhdCBzY2VuYXJpby4NCg0KQnV0IEknbSBubyBzdXJl
IHRoaXMgc29sdXRpb24gaXMgZ29pbmcgdG8gc2F0aXNmeSB0aGUgc3RhdGljIGNoZWNrZXIuIEl0
IA0Kb2JqZWN0cyB0byB1c2luZyB0aGUgaXRlcmF0b3IgKGNwdV9saW5rKSBvdXRzaWRlIHRoZSBs
b29wLiBJIHRoaW5rIGEgDQpwcm9wZXIgc29sdXRpb24sIHRoYXQgZG9lc24ndCBtYWtlIGFueSBh
c3N1bXB0aW9ucyBhYm91dCBob3cgDQpsaXN0X2Zvcl9lYWNoX2VudHJ5IGlzIGltcGxlbWVudGVk
LCB3b3VsZCBiZSB0byBkZWNsYXJlIGEgc2VwYXJhdGUgDQp2YXJpYWJsZSBhcyB0aGUgaXRlcmF0
b3IsIGFuZCBhc3NpZ24gY3B1X2xpbmsgaW4gdGhlIGxvb3Agb25seSBpZiB0aGVyZSANCmlzIGEg
bWF0Y2guDQoNClJhbWVzaDogV2lsbCB3YWl0IGZvciBhIHJlc3BvbnNlIGZyb20gRGFuLg0KDQpS
ZWdhcmRzLA0KIMKgIEZlbGl4DQoNCg0KPiAgIAkJCXJldHVybiAtRU5PTUVNOw0KPiAgIA0KPiAg
IAkJLyogQ1BVIDwtLT4gQ1BVIDwtLT4gR1BVLCBHUFUgbm9kZSovDQo+IEBAIC0xNTEwLDE2ICsx
NTEyLDE2IEBAIHN0YXRpYyBpbnQga2ZkX2FkZF9wZWVyX3Byb3Aoc3RydWN0IGtmZF90b3BvbG9n
eV9kZXZpY2UgKmtkZXYsDQo+ICAgCQljcHVfZGV2ID0ga2ZkX3RvcG9sb2d5X2RldmljZV9ieV9w
cm94aW1pdHlfZG9tYWluKGlvbGluazEtPm5vZGVfdG8pOw0KPiAgIAkJaWYgKGNwdV9kZXYpIHsN
Cj4gICAJCQlsaXN0X2Zvcl9lYWNoX2VudHJ5KGlvbGluazMsICZjcHVfZGV2LT5pb19saW5rX3By
b3BzLCBsaXN0KQ0KPiAtCQkJCWlmIChpb2xpbmszLT5ub2RlX3RvID09IGlvbGluazItPm5vZGVf
dG8pDQo+ICsJCQkJaWYgKGlvbGluazMtPm5vZGVfdG8gPT0gaW9saW5rMi0+bm9kZV90bykgew0K
PiArCQkJCQlwcm9wcy0+d2VpZ2h0ICs9IGlvbGluazMtPndlaWdodDsNCj4gKwkJCQkJcHJvcHMt
Pm1pbl9sYXRlbmN5ICs9IGlvbGluazMtPm1pbl9sYXRlbmN5Ow0KPiArCQkJCQlwcm9wcy0+bWF4
X2xhdGVuY3kgKz0gaW9saW5rMy0+bWF4X2xhdGVuY3k7DQo+ICsJCQkJCXByb3BzLT5taW5fYmFu
ZHdpZHRoID0gbWluKHByb3BzLT5taW5fYmFuZHdpZHRoLA0KPiArCQkJCQkJCQkJaW9saW5rMy0+
bWluX2JhbmR3aWR0aCk7DQo+ICsJCQkJCXByb3BzLT5tYXhfYmFuZHdpZHRoID0gbWluKHByb3Bz
LT5tYXhfYmFuZHdpZHRoLA0KPiArCQkJCQkJCQkJaW9saW5rMy0+bWF4X2JhbmR3aWR0aCk7DQo+
ICAgCQkJCQlicmVhazsNCj4gLQ0KPiAtCQkJcHJvcHMtPndlaWdodCArPSBpb2xpbmszLT53ZWln
aHQ7DQo+IC0JCQlwcm9wcy0+bWluX2xhdGVuY3kgKz0gaW9saW5rMy0+bWluX2xhdGVuY3k7DQo+
IC0JCQlwcm9wcy0+bWF4X2xhdGVuY3kgKz0gaW9saW5rMy0+bWF4X2xhdGVuY3k7DQo+IC0JCQlw
cm9wcy0+bWluX2JhbmR3aWR0aCA9IG1pbihwcm9wcy0+bWluX2JhbmR3aWR0aCwNCj4gLQkJCQkJ
CQlpb2xpbmszLT5taW5fYmFuZHdpZHRoKTsNCj4gLQkJCXByb3BzLT5tYXhfYmFuZHdpZHRoID0g
bWluKHByb3BzLT5tYXhfYmFuZHdpZHRoLA0KPiAtCQkJCQkJCWlvbGluazMtPm1heF9iYW5kd2lk
dGgpOw0KPiArCQkJCX0NCj4gICAJCX0gZWxzZSB7DQo+ICAgCQkJV0FSTigxLCAiQ1BVIG5vZGUg
bm90IGZvdW5kIik7DQo+ICAgCQl9DQo=
