Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958CCC678D5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Mar 2023 17:11:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1020B10E11E;
	Tue,  7 Mar 2023 17:11:11 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D36E210E11E
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Mar 2023 17:11:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ch02DO+jH2uiTflqFeGpcLO3gbv+VqZZF84gJh5hlx2N/kurlTci6k6OGWZaduZQkmJFo+vDYNwWgpn6eeG/1EJTc5ZccWXylcT9x1FLHeHnZPmxuIwbX6x7C/eJdoKkYIqDWbujx5pxNkZ+pC8L92+TIvWoviq2wmB1E3miFdBwhBOC3CPPLUB7VLz9ZB+75G9FnGXPGhpY3vdExuMtFoU4H513Sydd7pvW4X7J7xG+U+JrrFFgt+tJmEV/9RLQeWi5m57+DLeznWbXmKIAC59PoHo31kGmWB66oOF3GEfhDm0OFP6436I6BeGiFOeuzwD7rSzkeWhWh77MKyd4uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89ZDXIum6p/s4O+L6SZFEZ/BWFrtAz0iQJ2Wxfvr8gE=;
 b=L5a3/sTHQWnfr68egvzuinzgA4S45+Tw7Xj64WadXl8sUve6BgClPpEqxNsYxrtLGCSaVWnwImUJuUlUk0fhROJfliCPLRRSiTbSi9iLK1yt/SSkuRjMuZuvJ4p2Z9ufz27NJVazz/eTI/nYYt4q9OH3Q71bylBHdZZEor2HwPvjnenSExvoZhbpXTaXU9qp6arQI4rjKuKFy+9dPSHOcYyhzjN1EM5DGWs1Yw6/nLhHG9MuV7vE/UaY2zdOkrABy99PG0E1Rttx4iAG7IBDJ8p4DNkAe2xaBbHSSexGzs8mVp2+5hsrv2tyTr1CY4EtCwTYQEMyKOD3Lej56Tdf1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89ZDXIum6p/s4O+L6SZFEZ/BWFrtAz0iQJ2Wxfvr8gE=;
 b=aTvNnlEXNazpvRYLKdEtGdWz77BM6kq5e8GRljL4ECCjcTSaldYfqXz2BHE1y1fXH9hCnG6P8eeun+2fQ5BDJeQTbw52hRSG4rjZQBynt5K+wXy5CCmsEUuK93wduwjsqPmbJtWwdqlHBkmHHpBahW0SssIrsZY8wbu5Dm4I0O0=
Received: from DM6PR12MB4828.namprd12.prod.outlook.com (2603:10b6:5:1f8::26)
 by CH3PR12MB8879.namprd12.prod.outlook.com (2603:10b6:610:171::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 17:11:05 +0000
Received: from DM6PR12MB4828.namprd12.prod.outlook.com
 ([fe80::e608:9952:5ed1:a1c]) by DM6PR12MB4828.namprd12.prod.outlook.com
 ([fe80::e608:9952:5ed1:a1c%7]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 17:11:05 +0000
From: "Belanger, David" <David.Belanger@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Fixed kfd_process cleanup on module exit.
Thread-Topic: [PATCH] drm/amdkfd: Fixed kfd_process cleanup on module exit.
Thread-Index: AQHZUHbHjo+yZ+OqDUu6+IlHo1ONIK7uaqqAgAEjkvA=
Date: Tue, 7 Mar 2023 17:11:05 +0000
Message-ID: <DM6PR12MB4828BD141FCF58E7FBACA1F899B79@DM6PR12MB4828.namprd12.prod.outlook.com>
References: <20230306215808.2903387-1-david.belanger@amd.com>
 <52720ba5-09be-fafa-efee-33a230aeae07@amd.com>
In-Reply-To: <52720ba5-09be-fafa-efee-33a230aeae07@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-07T17:11:03Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=09f8c4d4-c9b1-4d22-be94-0b5d0e61a965;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-07T17:11:03Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 7c3f222c-bf32-4ee7-89d3-9f6dbb33da97
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4828:EE_|CH3PR12MB8879:EE_
x-ms-office365-filtering-correlation-id: a8bf17e7-2be5-4a0e-17ec-08db1f2eefcb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FFMxg0WcRTKkqMSDQIuGyo8sTDXpvNOWTQ7L7PmbI11BcQg8Z6/jcCcR7FJiAQFN8k1OtwGgaM0675Ju0JR0Hiy5yr/nHZ93c+TtfawqKYwQLyt96GYvzMcmlD0IJp9XEHTfXc+E765mQZzLAysNfzJ9ALKbSsoC7rilV+u7YOHYp4s+kmz71Xf4ucukaa4TPIVrRk1bQcDe+YKsfyVnSgw2h0hN0b+oQ43JHniBTc+MFwnm7v5a/XC0n7gQujku/S+oHIROphQd2UOoaDZVAnLXRW2/WH8ykzhULphNxjtpt1ZDaNspEnLUH0WrNgWVmMkO5CPI0Q8bVtJ9Od89okB48Jgys8muOW5dqhy825GZXUZl9/SPHa2FJG52dDW7RAuF4NZqFDN4Ruqx7XWPhZUn0ZGSDh+6u52c9Che3vtM1dRBORABQBtF3TcmqIIE68Kq6v0Q37xqnPOCO7aI0RKeJDa4sia+ODbKDZLrNR3PXVI1Ykxfo9kb5DQcyFsavMVUNvdGdCmwohuZxsD5LWZXGVAddtwEFDoXvxdsl57t8jbsFeeYQ2s9bKa7UBwG9zGl8QG4VoX+2ml/htteQSPM2PKAlk9OcG9YUwhkUFUEBzKYR5idscUHAplMVU+rXWLq9iyUcVaCc7KZaR1SZGkh80UafdKoW4OgvYdOT+f5xdqaKDrXmTp0/88zZeg/7Z77B1VnrkcJGd/ZgHo8ew==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4828.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199018)(33656002)(5660300002)(66946007)(76116006)(66446008)(8676002)(66476007)(8936002)(41300700001)(2906002)(86362001)(38100700002)(38070700005)(66556008)(64756008)(122000001)(7696005)(71200400001)(55016003)(478600001)(110136005)(316002)(52536014)(83380400001)(26005)(186003)(53546011)(9686003)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWxSQ1M4a0U3Ky9tQWVqRHZ2K0pybWhnWW1ZZFRYMzdUV1ZxOXcvdGJRekFY?=
 =?utf-8?B?OW8xaTVNQXZ3N2R0bFBDTWdRQUJydWV2TUhuSk1tN2NiOW9wQmV1Wlkrelht?=
 =?utf-8?B?a1RrdG5QK2xXWExkRFFmNkk0T25hUjRQazBKZGZET0hnSjl2Vm1kNWVZMGZR?=
 =?utf-8?B?Zk5YbzdQNTNuNDVaLzdDVWh1TUIzZzhETXdWbXBPcFp4UTl6NjRwVGgwZzZX?=
 =?utf-8?B?WlVENEJiQlR4T1RVYmFmQ3crcFhRVUdIcG5SbkdOL05XN3RWeGRHY08yV1dG?=
 =?utf-8?B?RlhsU2ZiTjFheGJGejdJN3pjb2xhUjJYNlpvR0crUDJ3TXF1MTN2aHpHUThH?=
 =?utf-8?B?NW1KY2Z0Mmo5dytUSjJ1WVZNYzQxbWxQUXJEVG5JaWpZWEwxVmVhRUFEZG96?=
 =?utf-8?B?d0puUDZmaVQ0Smg1NnVRSUlXZFBnZmp4SXI4SjZMOFp1VDF5Sjl2NUZzT1h5?=
 =?utf-8?B?aEkzUmlwM2Fmb3F4WEI3ODlmNU1aTEROMmFJQk01aE12ZlRhUjNoY2tNMFNE?=
 =?utf-8?B?RXNpb2ZaTzA2bXk0RTUvNEIvRjRoc016MTNzV285T0hCWlBBcVpyR2xOWFly?=
 =?utf-8?B?c0NiS2Y3emhrTCtsZkx1Tk9JcysxaXhPajF6Uk5yUXZHbzRGUWM1d1lqVHdi?=
 =?utf-8?B?YmZ1d2w1bElnZkJNS1VFWUErNXFSUFVqL05kT0NIKzVUbEljdDZ5UzNtTTlH?=
 =?utf-8?B?S3B1RG1zR0xab0U0TDFZaTh2MFluckN4V1lRMmQ5OEtneW5mWHJrdVlCaS9M?=
 =?utf-8?B?dG5Bb3BzRW0yRSsrU0N2Z1Y4VklwSmExMDU2Yk56TnFRbm41Z1JGUHB4RjFs?=
 =?utf-8?B?M3JFVU5oekdJbFBhV1BSWDZOSkJjVk5YSXdndzB6dFVEaDROaDJSZnlXdGRD?=
 =?utf-8?B?VG8zUlhBL0czWE9PcW9PSi83S0kxK3dENUNhS01rZ3VNaFdobmIzYmwwd0h6?=
 =?utf-8?B?NEtIWnRKTEdOa3pQY3h6a2Z6b0poK3dCdXBXbUErTnhSMjl4RWJKcHhZcVQx?=
 =?utf-8?B?UzNtOThIYjVIekNSNVJWWlB5UlZFME9TcjhrdmJVUkoyUEphNU9aWE1wdy9m?=
 =?utf-8?B?SjVwUGlCNkxTckNCNXFkQjFXM1FDZDR3d1NJbDhaVHRnaXFadEtRK2VDTHE4?=
 =?utf-8?B?ejJ0anRzb1dXcDNrdzc4L3Z6dWlJYzhZM0Mrcmhyc2VMUGRNZ2gwNC9ZWGVq?=
 =?utf-8?B?cFk2eGFtUTJPUm1abDh2ekpCTUQ4OWVFaG90RXI3RVphZWt1V3pFbjBNTXM3?=
 =?utf-8?B?TGlyUnNoTVNTSWRRRjI1TkFURUE1ZFNuOUg2bFN2YjFsSFdSRmVHYzF2STZj?=
 =?utf-8?B?dklDdHBZNXpHRFRDL05SSFdDejhuY3lSczJReVhEV0VXMzFlcWVkTlE5cGpZ?=
 =?utf-8?B?MCt4Z1E0VGF2TXAvNWxqM1dvTjVkaDdqK016b05CbjlXWkd5SUVVR0t1UXM5?=
 =?utf-8?B?Tng0NVF2Q0hIN2Fsb2M3TkZ6eitYR0ZLR0JMTHJGTC93TXcvakJDYU1WSWpw?=
 =?utf-8?B?bDY0c002cUwwWmhIQ21XMGdrdGZEMFBUSGgwbFpkWW9jVFEwYVJjc2NJUzJh?=
 =?utf-8?B?Q0lYU2NQTHVJK3RRR0FyTG43MWpnQ1BLRUpMWWcrbFRpS1pOSW9OL0s1Mm9k?=
 =?utf-8?B?dFBoaUgza1dxaWZOb21YUzJ1K0tJeWxUZ0lGZmlVSGhyTEtUSHVSTFpPRDRp?=
 =?utf-8?B?dllIQmJNU05meGxWaUt5T3o3c010aUZHN2xBbjFVVGMxTVhTOXhpbFpqNmlj?=
 =?utf-8?B?OXl4WHUwTEsyMllySFhsM3lZT09WZXlja3BjSUs2RHhvTnE3RkRRcWZUZmNy?=
 =?utf-8?B?MStoTWFaWXdNZEdicm5HYlZvcHRzTzRSQXVPUzBjZENGVENyTWE0aWdoSGlC?=
 =?utf-8?B?SGFTQ3JIWCtIUnR3N1BxNkUvMGp1UmFwUjVQaTNKaEg5Tk0vRXYyNzM0YlBj?=
 =?utf-8?B?SzJZcUtFUUg3SHVsQ2xZb2tBY3JCVjZDaUtUTGk3MEoveTdyL1R6bkd1dXJy?=
 =?utf-8?B?U082RDV6TkNVZitTMndoMk9HZ1BXU2VpTFRBVWgrL1FhamZQUHVKRVJNVmla?=
 =?utf-8?B?K1UvcWpGVEpBcWlxbVFlRkp5U2VJMjlIWTNJOWNQd29wWU4wcU45K3N0Uk1X?=
 =?utf-8?Q?8tC8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4828.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8bf17e7-2be5-4a0e-17ec-08db1f2eefcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 17:11:05.4922 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tB7DnS/W9xeiPOS0UN0tuD5isx6HCWEwrVzb6pki3hAmQR+/afA8u584kxaGb896ItjRmWtZ8jABE6CeBRERnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8879
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoYW5rcyBGZWxpeCBmb3IgeW91
ciBmZWVkYmFjay4NCkkgd2lsbCB3b3JrIG9uIGFwcGx5aW5nIHlvdXIgc3VnZ2VzdGVkIGFwcHJv
YWNoIGFuZCB1cGxvYWRlZCBhIHNlY29uZCB2ZXJzaW9uIHdoZW4gaXQgaXMgcmVhZHkuDQoNCkRh
dmlkIEIuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3VlaGxpbmcs
IEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDYs
IDIwMjMgNjo0NiBQTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IEJlbGFu
Z2VyLCBEYXZpZA0KPiA8RGF2aWQuQmVsYW5nZXJAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gZHJtL2FtZGtmZDogRml4ZWQga2ZkX3Byb2Nlc3MgY2xlYW51cCBvbiBtb2R1bGUNCj4g
ZXhpdC4NCj4gDQo+IA0KPiBBbSAyMDIzLTAzLTA2IHVtIDE2OjU4IHNjaHJpZWIgRGF2aWQgQmVs
YW5nZXI6DQo+ID4gSGFuZGxlIGNhc2Ugd2hlbiBtb2R1bGUgaXMgdW5sb2FkZWQgKGtmZF9leGl0
KSBiZWZvcmUgYSBwcm9jZXNzIHNwYWNlDQo+ID4gKG1tX3N0cnVjdCkgaXMgcmVsZWFzZWQuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBCZWxhbmdlciA8ZGF2aWQuYmVsYW5nZXJAYW1k
LmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tb2R1
bGUuYyAgfCAgNCArKw0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nl
c3MuYyB8IDU3DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgMiBmaWxlcyBjaGFu
Z2VkLCA2MSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX21vZHVsZS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfbW9kdWxlLmMNCj4gPiBpbmRleCAwOWI5NjZkYzM3NjguLjhlZjRiZDllNGY3ZCAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbW9kdWxlLmMN
Cj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbW9kdWxlLmMNCj4gPiBA
QCAtMjYsNiArMjYsOSBAQA0KPiA+ICAgI2luY2x1ZGUgImtmZF9wcml2LmgiDQo+ID4gICAjaW5j
bHVkZSAiYW1kZ3B1X2FtZGtmZC5oIg0KPiA+DQo+ID4gK3ZvaWQga2ZkX2NsZWFudXBfcHJvY2Vz
c2VzKHZvaWQpOw0KPiA+ICsNCj4gPiArDQo+ID4gICBzdGF0aWMgaW50IGtmZF9pbml0KHZvaWQp
DQo+ID4gICB7DQo+ID4gICAJaW50IGVycjsNCj4gPiBAQCAtNzcsNiArODAsNyBAQCBzdGF0aWMg
aW50IGtmZF9pbml0KHZvaWQpDQo+ID4NCj4gPiAgIHN0YXRpYyB2b2lkIGtmZF9leGl0KHZvaWQp
DQo+ID4gICB7DQo+ID4gKwlrZmRfY2xlYW51cF9wcm9jZXNzZXMoKTsNCj4gPiAgIAlrZmRfZGVi
dWdmc19maW5pKCk7DQo+ID4gICAJa2ZkX3Byb2Nlc3NfZGVzdHJveV93cSgpOw0KPiA+ICAgCWtm
ZF9wcm9jZnNfc2h1dGRvd24oKTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX3Byb2Nlc3MuYw0KPiA+IGluZGV4IGViYWJlOTJmN2VkYi4uYjViMjhhMzI2MzlkIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzLmMNCj4g
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jDQo+ID4gQEAg
LTExODEsNiArMTE4MSwxNyBAQCBzdGF0aWMgdm9pZCBrZmRfcHJvY2Vzc19ub3RpZmllcl9yZWxl
YXNlKHN0cnVjdA0KPiBtbXVfbm90aWZpZXIgKm1uLA0KPiA+ICAgCQlyZXR1cm47DQo+ID4NCj4g
PiAgIAltdXRleF9sb2NrKCZrZmRfcHJvY2Vzc2VzX211dGV4KTsNCj4gPiArCS8qDQo+ID4gKwkg
KiBEbyBlYXJseSByZXR1cm4gaWYgcCBpcyBub3QgaW4gdGhlIHRhYmxlLg0KPiA+ICsJICoNCj4g
PiArCSAqIFRoaXMgY291bGQgcG90ZW50aWFsbHkgaGFwcGVuIGlmIHRoaXMgZnVuY3Rpb24gaXMg
Y2FsbGVkIGNvbmN1cnJlbnRseQ0KPiA+ICsJICogYnkgbW11X25vdGlmaWVyIGFuZCBieSBrZmRf
Y2xlYW51cF9wb2Nlc3Nlcy4NCj4gPiArCSAqDQo+ID4gKwkgKi8NCj4gPiArCWlmICghaGFzaF9o
YXNoZWQoJnAtPmtmZF9wcm9jZXNzZXMpKSB7DQo+ID4gKwkJbXV0ZXhfdW5sb2NrKCZrZmRfcHJv
Y2Vzc2VzX211dGV4KTsNCj4gPiArCQlyZXR1cm47DQo+ID4gKwl9DQo+ID4gICAJaGFzaF9kZWxf
cmN1KCZwLT5rZmRfcHJvY2Vzc2VzKTsNCj4gPiAgIAltdXRleF91bmxvY2soJmtmZF9wcm9jZXNz
ZXNfbXV0ZXgpOw0KPiA+ICAgCXN5bmNocm9uaXplX3NyY3UoJmtmZF9wcm9jZXNzZXNfc3JjdSk7
DQo+ID4gQEAgLTEyMDAsNiArMTIxMSw1MiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG1tdV9ub3Rp
Zmllcl9vcHMNCj4ga2ZkX3Byb2Nlc3NfbW11X25vdGlmaWVyX29wcyA9IHsNCj4gPiAgIAkuZnJl
ZV9ub3RpZmllciA9IGtmZF9wcm9jZXNzX2ZyZWVfbm90aWZpZXIsDQo+ID4gICB9Ow0KPiA+DQo+
ID4gKw0KPiA+ICt2b2lkIGtmZF9jbGVhbnVwX3Byb2Nlc3Nlcyh2b2lkKQ0KPiA+ICt7DQo+ID4g
KwlzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnA7DQo+ID4gKwl1bnNpZ25lZCBpbnQgdGVtcDsNCj4gPiAr
DQo+ID4gKwkvKg0KPiA+ICsJICogSXRlcmF0ZSBvdmVyIHJlbWFpbmluZyBwcm9jZXNzZXMgaW4g
dGFibGUsIGNhbGxpbmcgbm90aWZpZXIgcmVsZWFzZQ0KPiA+ICsJICogdG8gZnJlZSB1cCBub3Rp
ZmllciBhbmQgcHJvY2VzcyByZXNvdXJjZXMuDQo+ID4gKwkgKg0KPiA+ICsJICogVGhpcyBjb2Rl
IGhhbmRsZXMgdGhlIGNhc2Ugd2hlbiBkcml2ZXIgaXMgdW5sb2FkZWQgYmVmb3JlIGFsbA0KPiBt
bV9zdHJ1Y3QNCj4gPiArCSAqIGFyZSByZWxlYXNlZC4NCj4gPiArCSAqLw0KPiA+ICsJaW50IGlk
eCA9IHNyY3VfcmVhZF9sb2NrKCZrZmRfcHJvY2Vzc2VzX3NyY3UpOw0KPiA+ICsNCj4gPiArCWhh
c2hfZm9yX2VhY2hfcmN1KGtmZF9wcm9jZXNzZXNfdGFibGUsIHRlbXAsIHAsIGtmZF9wcm9jZXNz
ZXMpIHsNCj4gPiArCQlpZiAocCkgew0KPiA+ICsJCQkvKg0KPiA+ICsJCQkgKiBPYnRhaW4gYSBy
ZWZlcmVuY2Ugb24gcCB0byBhdm9pZCBhIGxhdGUNCj4gbW11X25vdGlmaWVyIHJlbGVhc2UNCj4g
PiArCQkJICogY2FsbCB0cmlnZ2VyaW5nIGZyZWVpbmcgdGhlIHByb2Nlc3MuDQo+ID4gKwkJCSAq
Lw0KPiA+ICsNCj4gPiArCQkJa3JlZl9nZXQoJnAtPnJlZik7DQo+ID4gKw0KPiA+ICsJCQlzcmN1
X3JlYWRfdW5sb2NrKCZrZmRfcHJvY2Vzc2VzX3NyY3UsIGlkeCk7DQo+IA0KPiBJIGRvbid0IHRo
aW5rIGl0J3MgdmFsaWQgdG8gZHJvcCB0aGUgbG9jayBpbiB0aGUgbWlkZGxlIG9mIHRoZSBsb29w
LiBZb3UgbmVlZCB0bw0KPiBob2xkIHRoZSBsb2NrIHRocm91Z2hvdXQgdGhlIGxvb3AgdG8gcHJv
dGVjdCB0aGUgY29uc2lzdGVuY3kgb2YgdGhlIGRhdGENCj4gc3RydWN0dXJlLiBJIGd1ZXNzIHlv
dSdyZSBkb2luZyB0aGlzIGJlY2F1c2UgeW91IGdvdCBhIGRlYWRsb2NrIGZyb20NCj4gc3luY2hy
b25pemVfc3JjdSBpbiBrZmRfcHJvY2Vzc19ub3RpZmllcl9yZWxlYXNlLg0KPiANCj4gDQo+ID4g
Kw0KPiA+ICsJCQlrZmRfcHJvY2Vzc19ub3RpZmllcl9yZWxlYXNlKCZwLT5tbXVfbm90aWZpZXIs
IHAtDQo+ID5tbSk7DQo+IA0KPiBUaGlzIGNhbGxzIGhhc2hfZGVsX3JjdSB0byByZW1vdmUgdGhl
IHByb2Nlc3MgZnJvbSB0aGUgaGFzaCB0YWJsZS4gVG8gbWFrZQ0KPiB0aGlzIHNhZmUsIHlvdSBu
ZWVkIHRvIGhvbGQgdGhlIGtmZF9wcm9jZXNzZXNfbXV0ZXguDQo+IA0KPiBTaW5jZSB0aGlzIGlz
IG91dHNpZGUgdGhlIFJDVSByZWFkIGxvY2ssIHRoZSBlbnRyeSBpbiB0aGUgaGxpc3QgY2FuIGJl
IGZyZWVkLA0KPiB3aGljaCBjYW4gY2F1c2UgcHJvYmxlbXMgd2hlbiB0aGUgaGFzaF9mb3JfZWFj
aF9yY3UgbG9vcCB0cmllcyB0byBmaW5kIHRoZQ0KPiBuZXh0IGVudHJ5IGluIHRoZSBobGlzdC4N
Cj4gDQo+IA0KPiA+ICsNCj4gPiArCQkJa2ZkX3VucmVmX3Byb2Nlc3MocCk7DQo+IA0KPiBUaGlz
IHNjaGVkdWxlcyBhIHdvcmtlciB0aGF0IGNhbiBmcmVlIHRoZSBwcm9jZXNzIGF0IGFueSB0aW1l
LCB3aGljaCBhbHNvDQo+IGZyZWVzIHRoZSBobGlzdF9ub2RlIHAtPmtmZF9wcm9jZXNzZXMgdGhh
dCBpcyBzdGlsbCBuZWVkZWQgYnkNCj4gaGFzaF9mb3JfZWFjaF9yY3UgdG8gZmluZCB0aGUgbmV4
dCBlbnRyeS4gSWYgeW91J3JlIHVubHVja3ksIHRoZSB3b3JrZXIgd2lsbA0KPiBiZSBzY2hlZHVs
ZWQgYmVmb3JlIHRoZSBuZXh0IGxvb3AgaXRlcmF0aW9uLCBhbmQgeW91IGNhbiBnZXQgYSBrZXJu
ZWwgb29wcy4NCj4gDQo+IEkgc3VnZ2VzdCBhIHNhZmVyIHN0cmF0ZWd5OiBNYWtlIGEgbG9vcCB1
c2luZyBoYXNoX2Zvcl9lYWNoX3NhZmUgdG8gbW92ZSBhbGwNCj4gdGhlIHByb2Nlc3NlcyBpbnRv
IGEgbmV3IGhsaXN0LiBZb3UgY2FuIGRvIHRoYXQgd2hpbGUgaG9sZGluZyB0aGUNCj4ga2ZkX3By
b2Nlc3Nlc19tdXRleCwgc28geW91IGNhbiBzYWZlbHkgcmVtb3ZlIGFsbCBlbnRyaWVzIGZyb20g
dGhlIGhhc2gNCj4gdGFibGUgYW5kIG1vdmUgdGhlbSBpbnRvIHlvdXIgb3duIHByaXZhdGUgaGxp
c3QuDQo+IA0KPiBUaGVuIHlvdSBjYW4gc2FmZWx5IHJlbGVhc2UgYWxsIHRoZSBwcm9jZXNzZXMg
ZnJvbSB5b3VyIHByaXZhdGUgaGxpc3Qgd2l0aG91dA0KPiBoYXZpbmcgdG8gaG9sZCBlaXRoZXIg
dGhlIHNyY3UgcmVhZCBsb2NrIG9yIHRoZSBtdXRleC4NCj4gDQo+IFJlZ2FyZHMsDQo+ICDCoCBG
ZWxpeA0KPiANCj4gDQo+ID4gKw0KPiA+ICsJCQlpZHggPSBzcmN1X3JlYWRfbG9jaygma2ZkX3By
b2Nlc3Nlc19zcmN1KTsNCj4gPiArCQl9DQo+ID4gKwl9DQo+ID4gKwlzcmN1X3JlYWRfdW5sb2Nr
KCZrZmRfcHJvY2Vzc2VzX3NyY3UsIGlkeCk7DQo+ID4gKw0KPiA+ICsJLyoNCj4gPiArCSAqIE11
c3QgYmUgY2FsbGVkIGFmdGVyIGFsbCBtbXVfbm90aWZpZXJfcHV0IGFyZSBkb25lIGFuZCBiZWZv
cmUNCj4gPiArCSAqIGtmZF9wcm9jZXNzX3dxIGlzIHJlbGVhc2VkLg0KPiA+ICsJICoNCj4gPiAr
CSAqIEVuc3VyZXMgdGhhdCBhbGwgb3V0c3RhbmRpbmcgZnJlZV9ub3RpZmllciBnZXRzIGNhbGxl
ZCwgdHJpZ2dlcmluZyB0aGUNCj4gcmVsZWFzZQ0KPiA+ICsJICogb2YgdGhlIHByb2Nlc3MuDQo+
ID4gKwkgKi8NCj4gPiArCW1tdV9ub3RpZmllcl9zeW5jaHJvbml6ZSgpOw0KPiA+ICt9DQo+ID4g
Kw0KPiA+ICsNCj4gPiAgIHN0YXRpYyBpbnQga2ZkX3Byb2Nlc3NfaW5pdF9jd3NyX2FwdShzdHJ1
Y3Qga2ZkX3Byb2Nlc3MgKnAsIHN0cnVjdCBmaWxlDQo+ICpmaWxlcCkNCj4gPiAgIHsNCj4gPiAg
IAl1bnNpZ25lZCBsb25nICBvZmZzZXQ7DQo=
