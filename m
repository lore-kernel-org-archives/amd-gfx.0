Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041AAC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Mar 2022 17:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8987510E01F;
	Thu, 24 Mar 2022 17:25:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C43710E01F
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Mar 2022 17:25:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1+bDAycYysb6lqbJS9B/auBCbs5+0OX3HaJu5LveiKzn4aEAcue2NDLhoyxvlMF/C9pqxF+9xL6mWFqNopByiSyoVWXXJBhfKxnjydqynsQb7wIPHSSWgZ+YcVpvUwhTFQJ5AOhZ0bmMvmvjI5Xf2f+UKmYnDkY2KB/eqHV6D2/tLEWg3KUWwAYzJ9B0OWzdVu78+ISBGFqPRLlNgTD4MO7O93XBVkIxhOKl/y3F+rs91ekj+um0KDYJ6EEhMcghp9c/2FCV0M9t+0r4+dXJ2C8+01avBNknq03Gz4SCH6ePlmdZthjIi4xdxpKHo4A1FJf8Sq1wugA2huLhhjS4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIBtdBSxQgcK3KfCpkesYdMAO3ySStF5brdB9dUCMzA=;
 b=mD96wiI5/dsMR/W9nKoIOzWzY2wtyKMEL6J03D2Ufi27F2Jzbu/4WGR8dTfFh0/XV5EDLSj3dQAEocvJlYVDZ6fw7zl/xdNQCI4NWo/7XWtkiY2dAgtB4ZbhNpeM6xe/7rRfsZJbdGQw/rqsILZkfbIOG2B8bAGRM8kZywALeq8oQOSwYtnv0S9SxJfAy3a0RAUlt1JdD997eHqGL3uWyBV2pNWaU8fJoOeHjnJ8o/KnQHA2OYzAaQ8Reysuq50DtXI817xxFG/6E76cilj2QfyIGC4U/FHRNhUaNdCzCRnWzUbF2+B9/aWxcVb7QafgBv1NdWtdiMy9Hug32n7XoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIBtdBSxQgcK3KfCpkesYdMAO3ySStF5brdB9dUCMzA=;
 b=ko2SZKdRWDNSb8zKiDJ9trCEBVvcx62XJ3i24/p5Ef4M5GGrbwcbfsztq5YHEuiwaVPj4Xd8iHSm1C+h8Wo9nNfVuj3CgOhgUpLYjKXrnU07CkgIZIZGXO0RyqGki72vMsW2syHsXCHv8CWucXD2QGju1RDlIrKwxGUSYR6/h0I=
Received: from DM6PR12MB4843.namprd12.prod.outlook.com (2603:10b6:5:1d1::16)
 by BL0PR12MB4883.namprd12.prod.outlook.com (2603:10b6:208:1c6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 24 Mar
 2022 17:25:28 +0000
Received: from DM6PR12MB4843.namprd12.prod.outlook.com
 ([fe80::e1be:20a2:8b06:2366]) by DM6PR12MB4843.namprd12.prod.outlook.com
 ([fe80::e1be:20a2:8b06:2366%5]) with mapi id 15.20.5081.023; Thu, 24 Mar 2022
 17:25:27 +0000
From: "Zhang, Boyuan" <Boyuan.Zhang@amd.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [PATCH] drm/amdgpu/vcn3: send smu interface type
Thread-Topic: [PATCH] drm/amdgpu/vcn3: send smu interface type
Thread-Index: AQHYPytWfeOru7iEvEysGt3V8dFBUazOCTkAgAC+ORA=
Date: Thu, 24 Mar 2022 17:25:27 +0000
Message-ID: <DM6PR12MB48430AF058836E21C14D663E87199@DM6PR12MB4843.namprd12.prod.outlook.com>
References: <20220324025914.718674-1-yifan1.zhang@amd.com>
 <803cd706-a162-9dc7-1e9f-7e72ad70d0f3@molgen.mpg.de>
In-Reply-To: <803cd706-a162-9dc7-1e9f-7e72ad70d0f3@molgen.mpg.de>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f3fbe587-91f0-4421-b64e-ea4e12cd137d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-24T17:16:25Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-bromium-msgid: f788acad-ebf6-464b-bfc2-f2b479658318
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 305faf47-5a4c-4110-0788-08da0dbb4a1d
x-ms-traffictypediagnostic: BL0PR12MB4883:EE_
x-microsoft-antispam-prvs: <BL0PR12MB48831633C26AA95D5746AD3787199@BL0PR12MB4883.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oiwph9OEvuU5HjMA7CtScvLh5WIfMcdZdpwgV9tOkFic2HR09+M3LWXPdVKLSORMhCTx5tgi3VmjqCeFY9ogIs+IYCey15EVD+JXZI2MC7ZONca8U3fRZkVEvqYhXc1lL6XmdIR4IdaQPbLtnIPPttqRIdOC8jZ3/vDUbFvqEQqwCTxyuOhU88uxz+booOt5KiANac7OmPzfiIu6eHnsBolSUm2CaL09Pf0Ni57R54nYD4nsTqyNUUOU9ZD1vXSMOkxeAeAOHCd13pmyVFBuofUuvM6F4qTPD+CGBJ/yQfi6aqvgsQtbI8AwWVpfpSQsTOgwCjerUFP3L30cMHTiOPSmev06fNHZGaaKPqrLCeCoiW8aCAdCMsbBUlvpgyDwNg6Yf0LZd2nczsqAvXiFFl+aCBqJO2I1f9abukVzXemj0PH6sxysuVs0SPt5kAcSGNckNZWEAfsmlWCbAKbnKVDGq5WuxAZIxZJDO8ojRPGUKsfqGEIa7fa8n8JW3nB6bboAtPKnCUSHZgbwwJK9fHXRjRBnHkI1U1kqlcz/bVnOpKJwP06+wGaMf+py+8X22BxKDeXj5qQSlb9s6UD/cmjMwDBl48fqns3bfNPP219Fu9JENHFMpmYvjBnoQxjM7RqBhID91HqcXVhv3fWqb892K66it7eUDSUEUEHaP7hhoVvN/L+CVoOKlhlosHTVEgjWiTogCXuaczHD9zIL+Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4843.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(33656002)(8676002)(64756008)(66446008)(6916009)(76116006)(316002)(66946007)(66556008)(66476007)(54906003)(38100700002)(38070700005)(55016003)(508600001)(4326008)(71200400001)(86362001)(52536014)(2906002)(122000001)(8936002)(186003)(5660300002)(26005)(83380400001)(9686003)(7696005)(6506007)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHhZNjE0eUt4NDJaZzV2L0t4bTlmUG14SVJXb1gvME55WUNNMXdjVkEzZ28y?=
 =?utf-8?B?U3BNamtJbTN1MFN3NUUxZmdrVXIyR1p1L2hEZXFHVEVzbzZ3TGVYaDRVbXk0?=
 =?utf-8?B?UGVVRXZ3S25sb3BXS0FkWXhldkFmVnR3dGRydG1PTWF6SHlHRWhZaGFNTHNk?=
 =?utf-8?B?bUxaNVYxeDkrb0lqZEgxOG53aEpmUGlMYUpQS2ZsNXZ1Tk5zdHd0dkdEbTZs?=
 =?utf-8?B?NzdUdmFCN1NzUHVOUjMyRTNzMTdmdHdPcmdaRXdwU0wwK0ovRmozVkd3cnBF?=
 =?utf-8?B?OGhyYzI1L0NHaHA2NUt6azlmekY0NFZmcU1pREJraVVsUXZZcXBhY0tZQm5Z?=
 =?utf-8?B?cERhVHh2UFlTQkNqRzg4ZTR2RmVYVTcxd2R0aTNxR0RsbTk4M3c3bVZHaGI2?=
 =?utf-8?B?dkNoajZ4NzExbzNDNXk3dzdvZFk0TjVqdmg3NDBtY2lneFg5WCtzMUVjSTIw?=
 =?utf-8?B?QmlhQmRKeCsySy94S3RWaURjWWV0Tk9Uc0wvbjE1cUNEVVRFdmhzSEZheklO?=
 =?utf-8?B?Qm1mTVpqdlNuSzJmTjFoeTRwRVJCWTk0U1FQS1FhZDJybi9sKytOcElpUXJC?=
 =?utf-8?B?bkdUdEpKRVRWU3ZrZXVJdmpUMDV6akhGS1A3TG9xeUZhU3F6WEF1SVhWTWRp?=
 =?utf-8?B?Z3RENVBiMUhmVnlld3NXQVBvYnJrT1lkbEhldDY0TG1YdHltYklFN01yWCs1?=
 =?utf-8?B?MFZtTWIyVmFKclFKTCtVVzdBby9WNjJpWitIUTVLK0hxMy9abkk0VHIwdlFN?=
 =?utf-8?B?VkJzRDlIdllDRWJnNmRFTUwzSjc4bzJ0U0M2emRWRnlBSENZYjBiRlVjS1py?=
 =?utf-8?B?TVFpM1VyYzlCMFg5a3lQYjhXVlpDaUFMSk9tV3hhemRZRzRpSnlKa05UYnJz?=
 =?utf-8?B?M2JZdml4eVJjdHU3Z0ZSbXZzVEROR2xXTXBUbndUQVRqQ0pMTExoUWFtNVZR?=
 =?utf-8?B?N2EzOFNkUnN3WEdKK1dMVG01cDRyYjBneVo2a3VoZFBadXBMM1ZSVEZibU5E?=
 =?utf-8?B?ZW5zdEU2bTNtRm1YdXY1RXl4b1ZONjhxQU0vUmxJeENHbWoxV0pKKzZMcm12?=
 =?utf-8?B?WGt6ZHRUTkNYcnprUFRaeE9jVWJPOGhjWUJZQnBtTWNablZOK2M1Tm9iemps?=
 =?utf-8?B?UVRySFZockxZdXY5TEEvU2tBdnpRS1NRN0tNckw3WUpQdVpvbm5jMk9zaVdJ?=
 =?utf-8?B?ZGVYREJPTjFqNDdnQmtKSnA3M1psSXlMOXFFeVdaejZQcFVTMnJyU1RUeXRh?=
 =?utf-8?B?TFYzK25lTExycW01SW9EUkRFSUM2bzEzdkROb1VvWmhlRmdmcWxPUVpTYkVB?=
 =?utf-8?B?MWVEQ2hHS1VwSThLT1gwMWVYcE53NnF3azJuQk1TTXgzTnduTWZFTjRDcGFh?=
 =?utf-8?B?eVk1T2ZMekRvVXNUem10OGlhcFVwTGpJeTdFRmc2d0JPQmdFSXl4RHdQVHZx?=
 =?utf-8?B?VGgwQjBieWFVeDZKY2Q5V2g4WkV4ODBaTlF4S1JiQU05MW8yWXV4NTUzd0Iw?=
 =?utf-8?B?ek5IekhFbjdGVTBEMXFUalRiT096dG43RC9IbXFDbThZeVpoMHBzdGNDdkJU?=
 =?utf-8?B?cXR0U0xNNDFWNjJvVzA1bWxONjRSb0d5YXZhV05uQ0NoYXo4NXNZdFF6YnBH?=
 =?utf-8?B?c1kvNlB6Rk4veEZTN0dVSG1Ga0VZSndOQUloZ1ZBN1c5ckFvN1NJazdXYUpo?=
 =?utf-8?B?WFQzWVFzd3ovOG5YYVluMDhMckxwMGtTS1lyWGFCLzJobGNQdFhxVVRZdFA5?=
 =?utf-8?B?ZEdGU291a0p0TzJUdjhEUC9SVmRDYVFmZzZpM3FURDdvUHBwMkNRZVc1YWNK?=
 =?utf-8?B?Z2pzVzlzQWFjTXFhZWRVcEtrWHJxREFNMGJDV3Q3NytoUllZZlVJTDdKYUdP?=
 =?utf-8?B?VXM4T3hnWU9nSnZkY2hNOGFaUVNhUUp2WWlWcTdUSEUvWUppZURtWFJBcExt?=
 =?utf-8?Q?CNCBbEaDGuQe8TG4e706VRjR3GkzZ852?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 305faf47-5a4c-4110-0788-08da0dbb4a1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 17:25:27.8402 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zF2eHe5kU5NhFyabjVXXTm2Q4rLaLzpbNNgLmybaBlfkBjAub90ddVHOYjuc/MwGIXy02YaTN7cHSs+Y2iPQxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4883
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
Cc: "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "Huang, Ray" <Ray.Huang@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSGkgUGF1bCwNCg0KVGhpcyBjaGFuZ2UgaXMgdG8g
ZGlmZmVyZW50aWF0ZSBkZXZpY2UgKElQX1ZFUlNJT04oMywgMSwgMikpIGFuZCBkZXZpY2UgKElQ
X1ZFUlNJT04oMywgMSwgMSkpLCBzaW5jZSB0aGV5IGFyZSB1c2luZyBkaWZmZXJlbnQgbWFpbGJv
eCByZWdpc3RlcnMgZm9yIFZDTiBEUE0uIFRoZXJlIGlzIG5vIG90aGVyIGltcGFjdCBmb3IgVkNO
Lg0KDQpBbmQgdGhhbmsgZm9yIHBvaW50aW5nIG91dCB0aGUgZm9ybWF0IGlzc3VlLiBJIGp1c3Qg
c2VudCBvdXQgVjIuIFBsZWFzZSBoYXZlIGEgbG9vay4NCg0KUmVnYXJkcywNCkJveXVhbg0KDQot
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogUGF1bCBNZW56ZWwgPHBtZW56ZWxAbW9s
Z2VuLm1wZy5kZT4NClNlbnQ6IE1hcmNoIDI0LCAyMDIyIDE6NTYgQU0NClRvOiBaaGFuZywgWWlm
YW4gPFlpZmFuMS5aaGFuZ0BhbWQuY29tPjsgWmhhbmcsIEJveXVhbiA8Qm95dWFuLlpoYW5nQGFt
ZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhh
bmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEh1YW5nLCBSYXkgPFJheS5IdWFuZ0Bh
bWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdS92Y24zOiBzZW5kIHNtdSBp
bnRlcmZhY2UgdHlwZQ0KDQpEZWFyIFlpZmFuLCBkZWFyIEJveXVhbiwNCg0KDQpBbSAyNC4wMy4y
MiB1bSAwMzo1OSBzY2hyaWViIFlpZmFuIFpoYW5nOg0KPiBGcm9tOiBCb3l1YW4gWmhhbmcgPGJv
eXVhbi56aGFuZ0BhbWQuY29tPg0KPg0KPiBGb3IgVkNOIEZXIHRvIGRldGVjdCBBU0lDIHR5cGUN
Cg0KV2hhdCBhZmZlY3QgZG9lcyB0aGlzIGhhdmU/IEhvdyBkb2VzIFZDTiBGVyBiZWhhdmUgZGlm
ZmVyZW50IG5vdz8NCg0KPiBTaWduZWQtb2ZmLWJ5OiBCb3l1YW4gWmhhbmcgPGJveXVhbi56aGFu
Z0BhbWQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBZaWZhbiBaaGFuZyA8eWlmYW4xLnpoYW5nQGFt
ZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24u
aCB8IDcgKysrKysrKw0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92M18wLmMg
ICB8IDcgKysrKysrKw0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0KPg0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oDQo+IGluZGV4IGUyZmRlODhh
YWY1ZS4uZjA2ZmI3Zjg4MmUyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdmNuLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3Zjbi5oDQo+IEBAIC0xNTksNiArMTU5LDcgQEANCj4gICAjZGVmaW5lIEFNREdQVV9WQ05f
TVVMVElfUVVFVUVfRkxBRyAoMSA8PCA4KQ0KPiAgICNkZWZpbmUgQU1ER1BVX1ZDTl9TV19SSU5H
X0ZMQUcgICAgICAgICAgICAgKDEgPDwgOSkNCj4gICAjZGVmaW5lIEFNREdQVV9WQ05fRldfTE9H
R0lOR19GTEFHICAoMSA8PCAxMCkNCj4gKyNkZWZpbmUgQU1ER1BVX1ZDTl9TTVVfVkVSU0lPTl9J
TkZPX0ZMQUcgKDEgPDwgMTEpDQo+DQo+ICAgI2RlZmluZSBBTURHUFVfVkNOX0lCX0ZMQUdfREVD
T0RFX0JVRkZFUiAgICAweDAwMDAwMDAxDQo+ICAgI2RlZmluZSBBTURHUFVfVkNOX0NNRF9GTEFH
X01TR19CVUZGRVIgICAgICAgICAgICAgIDB4MDAwMDAwMDENCj4gQEAgLTI3OSw2ICsyODAsMTEg
QEAgc3RydWN0IGFtZGdwdV9md19zaGFyZWRfZndfbG9nZ2luZyB7DQo+ICAgICAgIHVpbnQzMl90
IHNpemU7DQo+ICAgfTsNCj4NCj4gK3N0cnVjdCBhbWRncHVfZndfc2hhcmVkX3NtdV9pbnRlcmZh
Y2VfaW5mbyB7DQo+ICsgICAgIHVpbnQ4X3Qgc211X2ludGVyZmFjZV90eXBlOw0KPiArICAgICB1
aW50OF90IHBhZGRpbmdbM107DQo+ICt9Ow0KPiArDQo+ICAgc3RydWN0IGFtZGdwdV9md19zaGFy
ZWQgew0KPiAgICAgICB1aW50MzJfdCBwcmVzZW50X2ZsYWdfMDsNCj4gICAgICAgdWludDhfdCBw
YWRbNDRdOw0KPiBAQCAtMjg3LDYgKzI5Myw3IEBAIHN0cnVjdCBhbWRncHVfZndfc2hhcmVkIHsN
Cj4gICAgICAgc3RydWN0IGFtZGdwdV9md19zaGFyZWRfbXVsdGlfcXVldWUgbXVsdGlfcXVldWU7
DQo+ICAgICAgIHN0cnVjdCBhbWRncHVfZndfc2hhcmVkX3N3X3Jpbmcgc3dfcmluZzsNCj4gICAg
ICAgc3RydWN0IGFtZGdwdV9md19zaGFyZWRfZndfbG9nZ2luZyBmd19sb2c7DQo+ICsgICAgIHN0
cnVjdCBhbWRncHVfZndfc2hhcmVkX3NtdV9pbnRlcmZhY2VfaW5mbyBzbXVfaW50ZXJmYWNlX2lu
Zm87DQo+ICAgfTsNCj4NCj4gICBzdHJ1Y3QgYW1kZ3B1X3Zjbl9md2xvZyB7DQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjNfMC5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvdmNuX3YzXzAuYw0KPiBpbmRleCBiMTZjNTZhYTJkMjIuLmM1YmY3Y2Jm
YTgyYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YzXzAu
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjNfMC5jDQo+IEBAIC0y
MTksNiArMjE5LDEzIEBAIHN0YXRpYyBpbnQgdmNuX3YzXzBfc3dfaW5pdCh2b2lkICpoYW5kbGUp
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjcHVfdG9fbGUz
MihBTURHUFVfVkNOX01VTFRJX1FVRVVFX0ZMQUcpIHwNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGNwdV90b19sZTMyKEFNREdQVV9WQ05fRldfU0hBUkVEX0ZM
QUdfMF9SQik7DQo+ICAgICAgICAgICAgICAgZndfc2hhcmVkLT5zd19yaW5nLmlzX2VuYWJsZWQg
PSBjcHVfdG9fbGUzMihERUNfU1dfUklOR19FTkFCTEVEKTsNCj4gKyAgICAgICAgICAgICBpZiAo
YWRldi0+aXBfdmVyc2lvbnNbVVZEX0hXSVBdWzBdID09IElQX1ZFUlNJT04oMywgMSwgMikpIHsN
Cj4gKyAgICAgICAgICAgICAgICAgICAgIGZ3X3NoYXJlZC0+cHJlc2VudF9mbGFnXzAgfD0gQU1E
R1BVX1ZDTl9TTVVfVkVSU0lPTl9JTkZPX0ZMQUc7DQo+ICsgICAgICAgICAgICAgICAgICAgICBm
d19zaGFyZWQtPnNtdV9pbnRlcmZhY2VfaW5mby5zbXVfaW50ZXJmYWNlX3R5cGUgPSAyOw0KPiAr
ICAgICAgICAgICAgIH0gZWxzZSBpZihhZGV2LT5pcF92ZXJzaW9uc1tVVkRfSFdJUF1bMF0gPT0g
SVBfVkVSU0lPTigzLCAxLCAxKSkgew0KDQpQbGVhc2UgYWRkIGEgc3BhY2UgYmVmb3JlIHRoZSAo
LCB3aGljaCBgY2hlY2twYXRjaC5wbGAgYWxzbyB3b3VsZCBoYXZlDQpmb3VuZDoNCg0KICAgICAk
IHNjcmlwdHMvY2hlY2twYXRjaC5wbA0KL2Rldi9zaG0vMDAwMS1kcm0tYW1kZ3B1LXZjbjMtc2Vu
ZC1zbXUtaW50ZXJmYWNlLXR5cGUucGF0Y2gNCiAgICAgRVJST1I6IHNwYWNlIHJlcXVpcmVkIGJl
Zm9yZSB0aGUgb3BlbiBwYXJlbnRoZXNpcyAnKCcNCiAgICAgIzU4OiBGSUxFOiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS92Y25fdjNfMC5jOjIyNToNCisgICAgICAgICAgICAgICB9IGVsc2Ug
aWYoYWRldi0+aXBfdmVyc2lvbnNbVVZEX0hXSVBdWzBdID09DQpJUF9WRVJTSU9OKDMsIDEsIDEp
KSB7DQoNCkFsc28gd2h5IG5vdCBvcmRlciBpdCBzbWFsbGVzdCB2ZXJzaW9uIGZpcnN0PyBXaWxs
IHRoZXJlIGV2ZXIgYmUgb3RoZXINCklQIHZlcnNpb25zIGZvciBWQ04gMy4wPw0KDQo+ICsgICAg
ICAgICAgICAgICAgICAgICBmd19zaGFyZWQtPnByZXNlbnRfZmxhZ18wIHw9IEFNREdQVV9WQ05f
U01VX1ZFUlNJT05fSU5GT19GTEFHOw0KPiArICAgICAgICAgICAgICAgICAgICAgZndfc2hhcmVk
LT5zbXVfaW50ZXJmYWNlX2luZm8uc211X2ludGVyZmFjZV90eXBlID0gMTsNCj4gKyAgICAgICAg
ICAgICB9DQo+DQo+ICAgICAgICAgICAgICAgaWYgKGFtZGdwdV92Y25md19sb2cpDQo+ICAgICAg
ICAgICAgICAgICAgICAgICBhbWRncHVfdmNuX2Z3bG9nX2luaXQoJmFkZXYtPnZjbi5pbnN0W2ld
KTsNCg0KDQpLaW5kIHJlZ2FyZHMsDQoNClBhdWwNCg==
