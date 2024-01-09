Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494DBC47073
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jan 2024 22:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B174B10E045;
	Tue,  9 Jan 2024 22:28:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6746510E045
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 22:28:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiJkxiqSW8qvo5DAewKafceRBj7nGvDiBu4bmg9xzm3RjCd+5t+gziRMFaGOiNKaIWV38xb/CSSV4m2wyQkv2NANubMS+ifNHgUSw7TrcVoZinx3dI0nE4xGM8tYhF/eY3jK6GbPyr3LO1HPaecZwt2eJZ0kJIh46y6PWBlBwp5N77Kd/e1qERw1AsqI99Rv2vd88zW96rhgN0mqyEEtzwI9Ssksq3Ow3qjCGE7zUSva3bSwQUdvl832EwAFM6wu7lnSwzJBHdsHocPhBqHQLxiTHm35n7quKQWbnEvKe5ETsy26DE8iV8T2uCIHV9eg1+5E4+EIKfbIpyPrxJKccA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LlbP0a5AVbi+OjZFDxJGdvtSMdHN+mASPOvQy1zNJA=;
 b=I2mdlKtrYrclHKSp4M7ZfuhOM3dnPIOTLMs95kS3I8s0jaG2M1BbqsQLrTm6Y90ycc7jxeVb1aYAOhXA48FF8PMwqt4+cOY3h4bWuMDxNCAJgt/QnVCX6x+N4zmk6BTLIgv3k2USotiB3231PvaV20J4wJZfMbYLN3M9fqPRO8XqhpzgxYUQLL2jNvXIvJ9QOf1Koe3umy+VCpYWyeJwMyfVfnuOXYCeKKe1qBprwtQG2v7crSuilz4+T2bEEpI8piTu+YaHDbEQy2kT+Cc3vhOXgQ0Z4V0Mo4NUxfptNRRYvtpjDQhepQY6IbnIkZDGSD4+K0j861fdxLjdU/iWLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LlbP0a5AVbi+OjZFDxJGdvtSMdHN+mASPOvQy1zNJA=;
 b=48GgNo5mrRd9upJVuwbQWhUPEEkIh6pd3BeDHNNolOS9HQNzEBDEWX0TcUOQtmlgEFuUR0/Mm05FCEbi1tX7JJSphl6hoS/egOa4lhzWPYt0rO2IPIXS5b2sljpKhWffK/wSc4zxoHjqvJROvRnddkYL73UZ7D6S1HgY3yWy0IE=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by IA1PR12MB8312.namprd12.prod.outlook.com (2603:10b6:208:3fc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 22:28:44 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a952:d50:fdc8:fc95]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a952:d50:fdc8:fc95%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 22:28:44 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Alexander Koskovich <AKoskovich@protonmail.com>
Subject: RE: Documentation for RGB strip on RX 7900 XTX (Reference)
Thread-Topic: Documentation for RGB strip on RX 7900 XTX (Reference)
Thread-Index: AQHaQg5xcJeFw0AC60y3NTa3oyYX3rDQfpSAgAAhGwCAAPZNgIAAWl0AgAAXaDCAAAJJgIAABpfA
Date: Tue, 9 Jan 2024 22:28:44 +0000
Message-ID: <BL1PR12MB5144D4968D7C79D30F9D63F1F76A2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <oCYzPIgXFcQ3jdqAKY2upsY5qq23yOba06RkrzD5Bfai97jMWxGvBsaOiKi1k5oZvNg7IoJLE6jAA6BLGFXt08WbBEtdgJA4snn7khZ0JFM=@protonmail.com>
 <BL1PR12MB514454D5E625F71BB0E6A8B6F76B2@BL1PR12MB5144.namprd12.prod.outlook.com>
 <xgXz7D0Xgjysg4ZLJpfd1ryjeEoM2fKFn9W5WIGBGxc6WSxcYxTZPzwKRNbqPYcDIf8P1zuDr5SYqSvl36GqzW8TimxvO7BGDq5S_zv8v3g=@protonmail.com>
 <BL1PR12MB5144D58D8EDA16731BA48102F76A2@BL1PR12MB5144.namprd12.prod.outlook.com>
 <Z8njgokdcTunZi6xnF-M7IGXA4_xj14qJE91X07_kII2oHfXkYWS45kIoKR3en9EIFyylWj5U_VFOjZkqcgbN_14JkeMlNtsRc13Jjvro58=@protonmail.com>
 <BL1PR12MB5144B46479ABF320088A4976F76A2@BL1PR12MB5144.namprd12.prod.outlook.com>
 <q_oRbF5mexY0ttw_MbcyqUd1KQIr1Ny7pg5sCCcIpor4AKUwktVDvuwoUpW0JO-rJXxJnyB5zOQ4JDYGRM2vNWeC2tMAsEto2JHlN6o-4Tk=@protonmail.com>
In-Reply-To: <q_oRbF5mexY0ttw_MbcyqUd1KQIr1Ny7pg5sCCcIpor4AKUwktVDvuwoUpW0JO-rJXxJnyB5zOQ4JDYGRM2vNWeC2tMAsEto2JHlN6o-4Tk=@protonmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=158fc79d-ad45-45df-92b9-d58c410db6a1;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-01-09T22:22:54Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|IA1PR12MB8312:EE_
x-ms-office365-filtering-correlation-id: 0fd3b622-bfbd-4e69-c05e-08dc11625717
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k+MFnwAbGAHqY5aE2a4Pj1s8Tz2a690WQ1tbVWJrjxvnRiKZjd2mGjnvh3EwrzXgJZcF3rDa0yiHrvNTnBIvtcbgaKuEajInGp8iTNWzVL4m/BNfEz64TVwBrLUFemwHGI9PPl5FCW4P3pjfxBgAcgrDqRX3TyBe+w4r0VduA3QeuVhil+IYODOI697KnHLO1MaK02PkyktRifLIVhGMMSkVRKHM24YRMZbWhso6WSSFSMvxJktMWzdpZsExgvsmCAZh/DBFhYjnKr1bDrJVIhrZwayjbv/dpPJqRzqvwENNXioSQgzW9KJqEWzI6aItuEroxe6TSt+J0huy1/fH2uwFFYhkqapVklSWuuORN4rs0E6mx+7BEoC705nDIk0jhAybbEKqg+2EvZGjbKErAvwD72AHs5o45jXgKtKWLd+xzPdDruP3w3WAYJfbfC78VZ7rilsH9GDb4REGr2i+klf0MZJhMqpblGn8JBz59cg7vluUv23YRxX+OASbfIHjxvZYRigID/xM2hRz3SobfUDkHjODA4as64QwE9DhshFlD/J4K5FpPOAPV9PcdWxnBzwAZFVg8WFf1qik+D9ALqeit7U7bU1AghpWtq8cwHA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(396003)(39860400002)(376002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(26005)(5660300002)(52536014)(122000001)(4326008)(6506007)(38100700002)(53546011)(7696005)(9686003)(55016003)(966005)(71200400001)(478600001)(66556008)(64756008)(66476007)(66446008)(6916009)(66946007)(76116006)(316002)(8676002)(8936002)(38070700009)(33656002)(41300700001)(86362001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWFoV3pZUldLazhOUmhoVWpZMmlLMFIvQS9wWExMTzVWV01TcDdNbEhTKzE4?=
 =?utf-8?B?VmdVMEpNSGMwUjJzS3l0S1k4Znl5bEMzV0lZd2ZidUhqOWhhSkdWY1lERVY2?=
 =?utf-8?B?SzZka0FIcGxwZW1qV0ZSaDJhb3IwVmtQemNuMFZmcFBuL1F6dzJOTkhnWjAv?=
 =?utf-8?B?WTV6d0Z2dGRncmttaGlEbkhTZ1JPL2VuSDVqanJWeExWZllzZUE0NllreGNK?=
 =?utf-8?B?R0p5ajFsRzlXaHBDbWJCdWpLT2VTcVlMSVRaQUQvNjRlS2g3MGtPMTkxNThq?=
 =?utf-8?B?OWsvOXR0T2M1TWwvaFFkMmsxeHl0Y0JYUUFOQTNVbWZxcTRJS3lhbFlDUU4x?=
 =?utf-8?B?dFhPNGpkckJ3aGVNWG54bFVrL0FacUVZVzZ2Tno3OFk0aUFTS1FzSjh3NjlT?=
 =?utf-8?B?eTBQMUtTYTY4NSswZ09vdnFxNkhINE5EY3BXMmxqM2xrWGpNdzdUUXoyU3hN?=
 =?utf-8?B?UE5nYWRTS3lnOWxtU0M5bWJwUkttKzlqUW9tN29zMVZmT0FFellGRDBHakhh?=
 =?utf-8?B?aFV1VWlxVGt5cU16UVRYcU90azJvRHN4UkVBclJBNUEwbk5IU3huUTZ3VEhL?=
 =?utf-8?B?c0RUczhWM3Q5RmZDMDNrNzVVQkZmenA3bjRTajZWTjV1YUZhMk9lUzRQaVhJ?=
 =?utf-8?B?UDhwYjh5WHhyWVAyMENPYytwSFNuelhDclZoRThWWFJ6NUwyTHNJaGQ4REIr?=
 =?utf-8?B?c2JBdGJBZ29tRmxjSDc3dFNUdi9oRm10M3hhKzJaSmx5TFNqVWI0VVhjVks4?=
 =?utf-8?B?a3pLcG1wd0N3RjlEMW5FWEw4aFUzVnBhUjdWeGdKeFJWL2NUaktYMWowWG9z?=
 =?utf-8?B?emhVejZiVkhLOG5VS3hMVThRSHlEcXdINE9LVW02ZkNjeERoVzJvMytlNVdv?=
 =?utf-8?B?cU1qN25hQmc0SEZqSGNvU05nMTJnY0NKMGhmUlREbHR3dlRNZHNQTG9CMUhD?=
 =?utf-8?B?dGZCQlpyN2Z1blJsNjdJWWRvOGVOM3hwWlgrdW5lZWpLdHV6aXI1YWRpOUxU?=
 =?utf-8?B?VHNtMHN5dkNJTktXNWdFeEJKdkl3RnhobTBpaEZaZEpuOEFKMUtnSWRRUHVy?=
 =?utf-8?B?QVUySmFtbkk4VE80UWNQaWpHL04vQzBiYndpVFVOdC9qNFNDNHhXVldwVVRD?=
 =?utf-8?B?Y2pVWk9venhrRFh6YWxnSG9jb1ZUWW1wVmp4NnNWMm9jWXZrL1Rrc2c3VWtn?=
 =?utf-8?B?Y2pmT21ldDl0UTNZeDhnMmY2TW9veDlhZnZxZ25Dc3VJbFNDOU9xZFlVbFVO?=
 =?utf-8?B?KytBRjYxenJLNEJnZUZzYjRUTkJPeXZuaCtHa25kVldhdUtMUlNLTmwvYUFZ?=
 =?utf-8?B?a1ZJK0FZY25Yc0ZMVnlISzVUc0VUbndZckgrZFRPYWpGVi9sa2cwVGV5MWNP?=
 =?utf-8?B?aGhiZVRRamFBTExtYnNsVnQ4V1NXeExHd1RqcjVjOU1jOXFlQ2wyTnU3SERB?=
 =?utf-8?B?Nyt1UmF4TitLYmN3aURLYjN5T1Avd1lDYTA2VTRrZ2JEUTZLUWgzR1FTa290?=
 =?utf-8?B?aFZpaTFNVUdnbk9OZVpzNDVYcEp5VS9tdzZISUVROFhYVk5kaVJQczM3eTZI?=
 =?utf-8?B?Q3BSK3I1ZjVIYktrTFhzVkZEK25TMDBBdlVNT2QvbVFMSjJwVjZNcWlGYWxR?=
 =?utf-8?B?Q3A5YkgxbHBLT2VEQVFsWjhrMVhUKzErdnNRNzVNTldhTmc5TUgydVVHajZM?=
 =?utf-8?B?eTZKc0poS0Q5aU5QQWJNRnhSYVdyTEpSSHY4eGczMUlrc1YxWkNPNU54UC9U?=
 =?utf-8?B?YWpKcDZudjRWcDlmcTZqUzNpWmsxVVJrZzFlc0Q1SDZ1RE9yS05ZR0x6cXVj?=
 =?utf-8?B?aW90L1YxUDlOS2FYekMyazRrL3BBSWxqSy91YVdkS1EwKzhtdlpsU2ZYbW5Z?=
 =?utf-8?B?ei9ZWERESHArMmhxWnVMVTAxVjNSODB6S3BhbmlXLzNkNTdqR21DZ0RHdUNJ?=
 =?utf-8?B?M0k0bEVJcFl4OGgyTnF2QXpLOWRuNVREQ0pzbksrSTlWNXllR09wMmY5WjNa?=
 =?utf-8?B?dU1OdmdwcUFiWmM0R0liQWhxZFZNRTN3cXh3NXpJNEd0czVLQWhIUDFFUC9U?=
 =?utf-8?B?enk5aEc1a1pkVUxodTNoM0NGWUxZQ00rZXF2TU9WT2NPNlVwWkxzZTBWQlZk?=
 =?utf-8?Q?iEyY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd3b622-bfbd-4e69-c05e-08dc11625717
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 22:28:44.5057 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iVE/caX40tOBXXla/2KoqNtValjy1XdvYV4oYgReWu7CpLv73vxnGox2wf6loQJOfyk8X0A0fcalcAITdOWtvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8312
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4YW5k
ZXIgS29za292aWNoIDxBS29za292aWNoQHByb3Rvbm1haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5
LCBKYW51YXJ5IDksIDIwMjQgNDo1OSBQTQ0KPiBUbzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4
YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNCj4gU3ViamVjdDogUkU6IERvY3VtZW50YXRpb24gZm9yIFJHQiBzdHJpcCBvbiBSWCA3OTAw
IFhUWCAoUmVmZXJlbmNlKQ0KPg0KPiBJcyB0aGUgQUlCL09FTSBmb3IgdGhpcyBib2FyZCBub3Qg
QU1EPw0KPiBodHRwczovL3d3dy5hbWQuY29tL2VuL3Byb2R1Y3RzL2dyYXBoaWNzL2FtZC1yYWRl
b24tcngtNzkwMHh0eA0KPg0KDQpJJ2xsIGRvdWJsZSBjaGVjayAod2UgdXN1YWxseSBkb24ndCBw
cm9kdWNlIHJlZmVyZW5jZSBib2FyZHMgd2l0aCBSR0IpLCBidXQgbXkgdW5kZXJzdGFuZGluZyBp
cyB0aGF0IGlmIGFueSBvZiB0aGUgYm9hcmRzIGF2YWlsYWJsZSBmb3Igc2FsZSBvbiBhbWQuY29t
IGhhcyBSR0IgY29udHJvbHMsIHRoZSBSR0IgY29udHJvbCBpcyBwcm92aWRlZCBieSBhIHRoaXJk
IHBhcnR5IHZlbmRvci4NCg0KQWxleA0KDQo+DQo+DQo+IE9uIFR1ZXNkYXksIEphbnVhcnkgOXRo
LCAyMDI0IGF0IDQ6NTMgUE0sIERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNo
ZXJAYW1kLmNvbT4gd3JvdGU6DQo+DQo+DQo+ID4NCj4gPg0KPiA+IFtBTUQgT2ZmaWNpYWwgVXNl
IE9ubHkgLSBHZW5lcmFsXQ0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+ID4gRnJvbTogQWxleGFuZGVyIEtvc2tvdmljaCBBS29za292aWNoQHByb3Rvbm1haWwuY29t
DQo+ID4gPiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDksIDIwMjQgMzoyNyBQTQ0KPiA+ID4gVG86
IERldWNoZXIsIEFsZXhhbmRlciBBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tDQo+ID4gPiBDYzog
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPiA+IFN1YmplY3Q6IFJFOiBEb2N1bWVu
dGF0aW9uIGZvciBSR0Igc3RyaXAgb24gUlggNzkwMCBYVFggKFJlZmVyZW5jZSkNCj4gPiA+DQo+
ID4gPiBEb2UgQU1EIGhhdmUgZG9jdW1lbnRhdGlvbiBvbiB0aGUgaTJjIGRhdGEgdGhhdCBnZXRz
IHNlbnQgY3VycmVudGx5DQo+ID4gPiB0aG91Z2g/IEkgd2FzIGhvcGluZyB0byBmaWd1cmUgb3V0
IHdoYXQgeW91IG5lZWQgdG8gY2hhbmdlIGluIHRoZQ0KPiA+ID4gY29tbWFuZCB0aGF0IGdldHMg
c2VudCB0byBjaGFuZ2Ugc3R1ZmYgbGlrZSBicmlnaHRuZXNzLCBjb2xvciAocmVkLA0KPiA+ID4g
Z3JlZW4sIGJsdWUpLCByYWluYm93LCBtb3JzZSBjb2RlLCBldGMuDQo+ID4NCj4gPg0KPiA+IEl0
IGRlcGVuZHMgb24gdGhlIExFRCBjb250cm9sbGVyIHVzZWQgYnkgdGhlIEFJQi9PRU0uIFRoZSBw
cm9ncmFtbWluZw0KPiBzZXF1ZW5jZSBpcyBkZXBlbmRlbnQgb24gdGhlIExFRCBjb250cm9sbGVy
Lg0KPiA+DQo+ID4gQWxleA0KPiA+DQo+ID4gPiBPbiBUdWVzZGF5LCBKYW51YXJ5IDl0aCwgMjAy
NCBhdCAxMDoxMCBBTSwgRGV1Y2hlciwgQWxleGFuZGVyDQo+ID4gPiBBbGV4YW5kZXIuRGV1Y2hl
ckBhbWQuY29tIHdyb3RlOg0KPiA+ID4NCj4gPiA+ID4gW1B1YmxpY10NCj4gPiA+ID4NCj4gPiA+
ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiA+IEZyb206IEFsZXhhbmRl
ciBLb3Nrb3ZpY2ggQUtvc2tvdmljaEBwcm90b25tYWlsLmNvbQ0KPiA+ID4gPiA+IFNlbnQ6IE1v
bmRheSwgSmFudWFyeSA4LCAyMDI0IDc6MjIgUE0NCj4gPiA+ID4gPiBUbzogRGV1Y2hlciwgQWxl
eGFuZGVyIEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20NCj4gPiA+ID4gPiBDYzogYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPiA+ID4gPiBTdWJqZWN0OiBSRTogRG9jdW1lbnRhdGlv
biBmb3IgUkdCIHN0cmlwIG9uIFJYIDc5MDAgWFRYDQo+ID4gPiA+ID4gKFJlZmVyZW5jZSkNCj4g
PiA+ID4gPg0KPiA+ID4gPiA+IEN1cnJlbnRseSB0aGUgcmVmZXJlbmNlIGNvb2xlciBmcm9tIEFN
RCBkb2VzIG5vdCBoYXZlIGFuDQo+ID4gPiA+ID4gZXhpc3RpbmcgUkdCIGNvbnRyb2xsZXIgZm9y
IE9wZW5SR0IsIHRoYXQncyB3aHkgSSB3YXMgbG9va2luZw0KPiA+ID4gPiA+IGZvciBkb2N1bWVu
dGF0aW9uIG9uIHRoZSBJMkMgY29tbWFuZHMgdG8gc2VuZCB0byB0aGUgc2Vjb25kIFNNVSwNCj4g
PiA+ID4gPiBzbyBJIGRvbid0IHJpc2sgYnJpY2tpbmcgbXkgY2FyZCBieSBzZW5kaW5nIHdyb25n
IGNvbW1hbmRzDQo+ID4gPiA+ID4gZHVyaW5nIGRldmVsb3BtZW50IHNvbWVob3cuDQo+ID4gPiA+
ID4NCj4gPiA+ID4gPiB3cml0ZVNldENNRFdpdGhEYXRhOg0KPiA+ID4gPiA+DQo+ICoqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqDQo+
ID4gPiA+ID4gYWRsaTJjLmlTaXplID0gc2l6ZW9mKEFETEkyQykNCj4gPiA+ID4gPiBhZGxpMmMu
aUFjdGlvbiA9IEFETF9ETF9JMkNfQUNUSU9OV1JJVEUgYWRsaTJjLmlBZGRyZXNzID0gMHhiNA0K
PiA+ID4gPiA+IGFkbGkyYy5pU3BlZWQgPSAxMDANCj4gPiA+ID4gPiAwIC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiA+ID4gRGV2IDA6IEFE
TF9EaXNwbGF5X1dyaXRlQW5kUmVhZFNNVUkyQygwLCAmYWRsaTJjKSA9IDANCj4gPiA+ID4gPiBh
ZGxpMmMuaURhdGFTaXplID0NCj4gPiA+ID4gPiAyNCBpMmNEYXRhWzBdflsyNF0NCj4gPiA+ID4g
PiA0MCA1MSAyYyAwMSAwMCAwMCBmZiAwMCBmZiBmZiBmZiBjYyAwMCBjYyAwMCAwMCAwMCBmZiBm
ZiBmZiBmZg0KPiA+ID4gPiA+IGZmIGZmIGZmDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBGcm9tIHRo
ZSBSR0IgYXBwJ3MgbG9ncyB0aGlzIGlzIGFuIGV4YW1wbGUgb2Ygd2hhdCB0aGUgb2ZmaWNpYWwN
Cj4gPiA+ID4gPiBBTUQgYXBwbGljYXRpb24gb24gV2luZG93cyBpcyBzZW5kaW5nIHdoZW4gaXQg
Y2hhbmdlcyBjb2xvcnMgb24gdGhlDQo+IFJHQiBzdHJpcC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+
IEZyb20gdGhpcyBjYW4gaXQgYmUgYXNzdW1lZCB0aGUgQU1EIGNhcmQgaXMgdXNpbmcgdGhlIGxh
dHRlcg0KPiA+ID4gPiA+IG1ldGhvZCB5b3UgbWVudGlvbmVkIHdpdGggdGhlIHNlY29uZCBTTVUg
STJDIGJ1cywgaW4gd2hpY2ggY2FzZQ0KPiA+ID4gPiA+IG5vIGRyaXZlciBjaGFuZ2VzIHdvdWxk
IGJlIG5lZWRlZD8NCj4gPiA+ID4NCj4gPiA+ID4gSUlSQywgZWFjaCBBSUIvT0VNIHVzZXMgaXRz
IG93biBwcmVmZXJyZWQgUkdCIGNvbnRyb2xsZXIuIFRoZQ0KPiA+ID4gPiByZWZlcmVuY2UgYm9h
cmQganVzdCBkZWZpbmVzIHdoaWNoIGkyYyBidXNlcyBjYW4gYmUgdXNlZC4gVGhlIFJHQg0KPiA+
ID4gPiBjb250cm9sIGFwcGxpY2F0aW9uIGlzIGp1c3QgYSB1c2Vyc3BhY2UgYXBwIHByb3ZpZGVk
IGJ5IHRoZQ0KPiA+ID4gPiBBSUIvT0VNIHRoYXQgY2FsbHMgQURMIHRvIHRhbGsgdG8gd2hpY2hl
dmVyIGkyYyBidXMgdGhlIHZlbmRvciBwdXQNCj4gPiA+ID4gdGhlaXIgUkdCIGNvbnRyb2xsZXIg
b24uIE9uIExpbnV4IHlvdSBjYW4gZG8gc29tZXRoaW5nIHNpbWlsYXINCj4gPiA+ID4gdXNpbmcg
dGhlIGkyY19kZXYgbW9kdWxlIHRvIG9wZW4gYSBjb25uZWN0aW9uIHRvIHRoZSBpMmMgYnVzIGRy
aXZlcg0KPiBwcm92aWRlZCBieSB0aGUga2VybmVsLiBJIGJlbGlldmUgdGhhdCBpcyB3aGF0IG9w
ZW5SR0IgZG9lcyB0b2RheS4NCj4gPiA+ID4gSXQgbG9va3MgbGlrZSB5b3UgYWxyZWFkeSBoYXZl
IHRoZSBwcm9ncmFtbWluZyBzZXF1ZW5jZSBhYm92ZS4NCj4gPiA+ID4NCj4gPiA+ID4gQWxleA0K
PiA+ID4gPg0KPiA+ID4gPiA+IE9uIE1vbmRheSwgSmFudWFyeSA4dGgsIDIwMjQgYXQgNTozMiBQ
TSwgRGV1Y2hlciwgQWxleGFuZGVyDQo+ID4gPiA+ID4gQWxleGFuZGVyLkRldWNoZXJAYW1kLmNv
bSB3cm90ZToNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gW1B1YmxpY10NCj4gPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+ID4gPiA+IEZy
b206IGFtZC1nZnggYW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZyBPbg0KPiA+
ID4gPiA+ID4gPiBCZWhhbGYgT2YgQWxleGFuZGVyIEtvc2tvdmljaA0KPiA+ID4gPiA+ID4gPiBT
ZW50OiBTdW5kYXksIEphbnVhcnkgNywgMjAyNCAxMToxOSBQTQ0KPiA+ID4gPiA+ID4gPiBUbzog
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPiA+ID4gPiA+ID4gU3ViamVjdDogRG9j
dW1lbnRhdGlvbiBmb3IgUkdCIHN0cmlwIG9uIFJYIDc5MDAgWFRYDQo+ID4gPiA+ID4gPiA+IChS
ZWZlcmVuY2UpDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IEhlbGxvLA0KPiA+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gPiBJIHdhcyB3b25kZXJpbmcgaWYgQU1EIHdvdWxkIGJlIGFibGUg
cHJvdmlkZSBhbnkNCj4gPiA+ID4gPiA+ID4gZG9jdW1lbnRhdGlvbiBmb3IgdGhlIFJHQiBzdHJp
cCBvbiB0aGUgcmVmZXJlbmNlIGNvb2xlcg0KPiA+ID4gPiA+ID4gPiAoaHR0cHM6Ly93d3cuYW1k
LmNvbS9lbi9wcm9kdWN0cy9ncmFwaGljcy9hbWQtcmFkZW9uLXJ4LQ0KPiA+ID4gPiA+ID4gPiA3
OTAweHR4KT8NCj4gPiA+ID4gPiA+ID4gSXQNCj4gPiA+ID4gPiA+ID4gbG9va3MgdG8gYmUgaGFu
ZGxlZCB2aWEgSTJDIGNvbW1hbmRzIHRvIHRoZSBTTVUsIGJ1dCBoYXZpbmcNCj4gPiA+ID4gPiA+
ID4gcHJvcGVyIGRvY3VtZW50YXRpb24gd291bGQgYmUgZXh0cmVtZWx5IGhlbHBmdWwuDQo+ID4g
PiA+ID4gPg0KPiA+ID4gPiA+ID4gSXQgZGVwZW5kcyBvbiB0aGUgQUlCL09FTSBhbmQgaG93IHRo
ZXkgZGVzaWduZWQgdGhlIHNwZWNpZmljDQo+ID4gPiA+ID4gPiBib2FyZC4gVGhlIFJHQiBjb250
cm9sbGVyIHdpbGwgZWl0aGVyIGJlIGF0dGFjaGVkIHRvIHRoZQ0KPiA+ID4gPiA+ID4gRERDVkdB
IGkyYyBidXMgb24gdGhlIGRpc3BsYXkgaGFyZHdhcmUgb3IgdGhlIHNlY29uZCBTTVUgaTJjDQo+
ID4gPiA+ID4gPiBidXMuIFRoZSBmb3JtZXIgd2lsbCByZXF1aXJlIGNoYW5nZXMgdG8gdGhlIGFt
ZGdwdSBkaXNwbGF5DQo+ID4gPiA+ID4gPiBjb2RlIHRvIHJlZ2lzdGVyIGRpc3BsYXkgaTJjIGJ1
c2VzIHRoYXQgYXJlIG5vdCB1c2VkIGJ5IHRoZQ0KPiA+ID4gPiA+ID4gZGlzcGxheSBjb25uZWN0
b3JzIG9uIHRoZSBib2FyZCBzbyB0aGV5IGNhbiBiZSB1c2VkIGJ5IDNyZCBwYXJ0eQ0KPiBhcHBs
aWNhdGlvbnMuDQo+ID4gPiA+ID4gPiBDdXJyZW50bHkgd2Ugb25seSByZWdpc3RlciBpMmMgYnVz
ZXMgdXNlZCBmb3IgZGlzcGxheSBjb25uZWN0b3JzLg0KPiA+ID4gPiA+ID4gVGhlIGxhdHRlciBi
dXNlcyBhcmUgYWxyZWFkeSByZWdpc3RlcmVkIHdpdGggdGhlIGkyYyBzdWJzeXN0ZW0NCj4gPiA+
ID4gPiA+IHNpbmNlIHRoZXkgYXJlIHVzZWQgZm9yIG90aGVyIHRoaW5ncyBsaWtlIEVFUFJPTXMg
b24gc2VydmVyDQo+ID4gPiA+ID4gPiBhbmQgd29ya3N0YXRpb24gY2FyZHMgYW5kIHNob3VsZCBi
ZSBhdmFpbGFibGUgdmlhIHN0YW5kYXJkDQo+ID4gPiA+ID4gPiBMaW51eCBpMmMgQVBJcy4gSSdt
IG5vdCBzdXJlIHdoYXQgaTJjIExFRCBjb250cm9sbGVycyBlYWNoIEFJQg0KPiA+ID4gPiA+ID4g
dmVuZG9yIHVzZXMgb2ZmIGhhbmQuIGh0dHBzOi8vb3BlbnJnYi5vcmcvaW5kZXguaHRtbCB3b3Vs
ZA0KPiA+ID4gPiA+ID4gcHJvYmFibHkgYmUgYSBnb29kIHJlc291cmNlIGZvciB0aGF0IGluZm9y
bWF0aW9uLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEFsZXgNCg==
