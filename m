Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213F6C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 13:21:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 855B910E831;
	Wed,  1 Jun 2022 13:21:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ABA410E826
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 13:21:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXcx/mu7XgTYLe626jjnelmer4gopcuKVFSVu8F2KYghjipEY0WDFO12O3+VYuZDq6CdTWDhlq1RQtcXI4amNTFgF9N5jDxhKowsI77VIc3Jm1gx7yI9oKDB2xcIgjr+RN/Sd4bP36cpW1c9a7irt0CAdmEAU9cJNF7xS/lbGpD8XlohLXp4dEZ11zgfcM62PiIuSTSI1rSXw7W+giXDszmJXMhcMn+xzCW5hKZHCvmIvJSPBi4mGppW8Nq0AbMel09R5LPEK6UdyveY2ZIrlqvKRC7S/bM0nBSt1vylYcQ+wUKvScN4Gpr6MrDjKXb3JgB5Vdgj8DLF6Lm5XP8zWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyndWdRMKR047geZ3EnanYdzdl28YSNjsMxS64LK4cY=;
 b=NDUsID8HRH5oqrkDMN2EgmcBhG2y2P+Tci3AqNPdBChUJQhq9heS8FiqYhzyQ2zfNPQGo4ktXPzj3qfo+f4e2+Hg91UrAZct53Q+o7Z434xr4YJJMkMX1quz77rucNnYo2m0lMrPQ0xr4dRgyjDT+UDsB2bcBCl7jo+1/oH/98Ut0COL5gYmpZabDQb9QeGmuJl0C8/553jSiy6dm6NnlUZEoZMLgFLf8FF4PxXZVJfVBc0R4D2MivLypxA+W6jaClpVCdF7/fyMxU+gG6nbI4jCYvjFicxteWJ7dK8zS+lpvgV4mDVc0CMSSnoS5rrXvc3MiX/6vtfdCggsEcetlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyndWdRMKR047geZ3EnanYdzdl28YSNjsMxS64LK4cY=;
 b=gRtsFtKfERHp3R14wh2KS4MHPrLz3rPd/b6HuG0vLgoOIwsqqc5JYjUgym+asadoqUHW/RxBQP3v/05nrBFd7ug8LuSim+VnncxUYSMuZwhcDt2lODM4O9gYsZ/JBYcbf3bayJftbwxNX2PJtYRygDOSlQeQaLczp4XLD1YDq40=
Received: from PH7PR12MB6633.namprd12.prod.outlook.com (2603:10b6:510:1ff::20)
 by MWHPR1201MB0110.namprd12.prod.outlook.com (2603:10b6:301:56::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 1 Jun
 2022 13:21:02 +0000
Received: from PH7PR12MB6633.namprd12.prod.outlook.com
 ([fe80::44d5:bc9f:a222:1aeb]) by PH7PR12MB6633.namprd12.prod.outlook.com
 ([fe80::44d5:bc9f:a222:1aeb%9]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 13:21:01 +0000
From: "Mohan Marimuthu, Yogesh" <Yogesh.Mohanmarimuthu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Olsak,
 Marek" <Marek.Olsak@amd.com>
Subject: RE: [PATCH 10/10] drm/amdgpu: add gang submit frontend
Thread-Topic: [PATCH 10/10] drm/amdgpu: add gang submit frontend
Thread-Index: AQHYLtf2HQTmabF910u+d8CEcSHOAK07AhsQgAABuwCAABGU4A==
Date: Wed, 1 Jun 2022 13:21:00 +0000
Message-ID: <PH7PR12MB663392CB5CBB0EEC710D6926FFDF9@PH7PR12MB6633.namprd12.prod.outlook.com>
References: <20220303082308.38217-1-christian.koenig@amd.com>
 <20220303082308.38217-11-christian.koenig@amd.com>
 <BL3PR12MB66193C104060707AE4900848FFDF9@BL3PR12MB6619.namprd12.prod.outlook.com>
 <04063003-02f6-3ca3-49ba-51406c22d19e@amd.com>
In-Reply-To: <04063003-02f6-3ca3-49ba-51406c22d19e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-06-01T13:17:19Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=8e3abfa7-7ee7-4fda-84c6-7b01e9db8c16;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-06-01T13:20:54Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 68537a8b-6a8e-4b3d-a6ae-3f195164586f
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b62f5ec5-384e-4b31-4dc4-08da43d19261
x-ms-traffictypediagnostic: MWHPR1201MB0110:EE_
x-microsoft-antispam-prvs: <MWHPR1201MB0110CB49B19EB4F0A9A7F33DFFDF9@MWHPR1201MB0110.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Te0SET2qZPmIM8A5NWzkiaOrSWCx8W90IfmRnwZCdn6z/K1TlcLa1nbgO7WTtVyT4mf1ZVI/fy3gEFJRHwLBYk0+5BC2LHEs3HELFmUHr1ZmmfbY4JIawUDWzn0YtxdVLp2cpPFgyMFZMphRgGatJRVWMKVAmWr6IKP9Tga5y+GzA+03REHvHiNRjwl7V2Emm5LUTUILJW9Pilgo8hb7PHGTqIX0Tb03Gdfi8tLd0ShYcn566ij+e8sfQ7QB6e5EUdOSEDU9R1csXyQNhwv0yTGKQoRUxWurGnA5w8nL6g93w/sG440x6P25GpQaItCmLCReDaKD1i1n5e+o+elgsWJQlYVKc9dNFQ7SOuDebs0+0KbM5CM9E8TUsfHATUDdP3HQYNdI23sgTSpBRWG7Yrz1XnNTmsmogOCyaToUZuDLhR8POQzTV+OtJ7VCkYupIlBebRNeAMKQX/Sux4IbL492Feq88q2NDmrCJRpQoCvfgAR8izeAGR9WIwNHuajU8BEmcCFpliBJhzE97izWxxKtt5xQ9lM4r5Hk0no3mFVe+FzPpOEdfNWJHBykcAzBHIkcDq137OL6HyxoFvvs9GOvNUAWk4jPdyK3HrcZzSIPHta1WzTxnmNuLOrv5DI9+oGidGJZbo4kHRiy4eYP3WJXgxx+wfnzgTgdMe0R793J4nEEetFoqWXVBKEthQhVlZvLFmsRLS9LeKPrUssNPQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6633.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6636002)(110136005)(2906002)(316002)(26005)(6506007)(7696005)(53546011)(9686003)(122000001)(38070700005)(83380400001)(55016003)(66574015)(52536014)(66946007)(38100700002)(5660300002)(86362001)(64756008)(66476007)(66446008)(66556008)(8676002)(76116006)(508600001)(33656002)(71200400001)(186003)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUp3YStoT0dJMFFJUWJtVWRpTW5IamFNV1U2bkZ0amt2eXVNTG13TVJoei9M?=
 =?utf-8?B?RkszQVo2MEdLRjM0Q0JYTTZWYU12NVFmN3FFZ29MOHhYYWYvMEV3SnFtM3gv?=
 =?utf-8?B?VFI4ZUhQMkxwUnZyd292R2VkSGZnbFVENHBleU9IVHljYURMT3IyWDR1V2Fy?=
 =?utf-8?B?RWZYMTVrM0RaUyt6TXJoWE4zU25rekJZYzRIdVduOHI5VEtoVWh5S2lCM0Z1?=
 =?utf-8?B?SmxLK2ZwNDRBRysvc2VCeFlnbDVQdWlaYWplQ0tnNEZpRFEzWDc2NVI5ZnZN?=
 =?utf-8?B?N09OZUR0Ui9PemJsVXo1UnBUV2VyMnBYWWVoUDJyTFo4bnVxK01HK1FuTVFS?=
 =?utf-8?B?Q1YxMWdIdWRqSXN6bllZUm01Q3ExYWRaTlFXR2dkeURVcTgvaTdhNi9SdUVP?=
 =?utf-8?B?TTJFVjhLOVB1Mno3My9pTFJMbVFFdkNGeHdKR3BsODI2WklKd3VqRmRqMXZj?=
 =?utf-8?B?NFhmRjdqT2w1dzZQQmRYWVZ6QkxpRVJCSUgvb3N6OWRDc3hwUE5wbWNzZHVh?=
 =?utf-8?B?MlVnTUwzdG9OL25LcXZlbmRJczBudzNOWGIyUk43aHI2TmFwVEhISENjWFY1?=
 =?utf-8?B?MkovSW5QR01Cc2hMNzVueTE5dW1JLzNTYWp0ZWRsdlgwdS9CUVQ2M3lmRUp4?=
 =?utf-8?B?Ujh2amRvc3k4RmVSdnlpZFpzZkNoZGtBcncrU05PRURBM3NDbUtvSGpJZFVB?=
 =?utf-8?B?eDJUT1dWVDBXRzZkakJ6cEU0RWZtbS83ajZJOER0QS8wQ2xNZThZNFo1OE9z?=
 =?utf-8?B?YmZFcVNjeFo2NWhCYmsxNGxydkFZTVorSS8rSVFmeUUzK3NXeWowRjBSQVk0?=
 =?utf-8?B?UUN4UjVVWnlxN3VkNHhzSFlBdVUyR1BWQnlRd0kzeEpkRFZHRVZCcmRod0xS?=
 =?utf-8?B?ZU1zM1VKR1NEamVSRHpGb2RldFlqUzJ4dkI4WVR2RHFmdGcwdHhhRGk1aXVP?=
 =?utf-8?B?M3l3Q2ZTckIva2xHU2hoL1pwYWNuYTRaOEQ5a0ZUVk5LUE1xK1dzL2h3dTAv?=
 =?utf-8?B?Q1dQM0doRDBBSnFIYW5iMUNwaGZ4bmtuZ3hsQ2VkcER5SUZJaWJ5dTNOVzlq?=
 =?utf-8?B?cHQvam9QbENsTElhMHFGQndhV3E1dGpOS2MreWNqZXRWejRRMHlFK1hpTE56?=
 =?utf-8?B?NU5lNldDWGpUU2NLOStlQnprWXh2TTZqNUp2RmNNVVR2ZzhTdFBUVzJMcG9U?=
 =?utf-8?B?dWs3STd3MlRXYXcvQnZJK3JUbi9oVmh6bnNsZTkvVE5wZXFFMGtyRDBaYmk5?=
 =?utf-8?B?aFBCdDNISjBnVVhINnl1RzZFMGgrdzlJUGNLeDVWeTBEYlpCeFhoWWtaYmE4?=
 =?utf-8?B?bS9TSXdnTlJVa0JYMVNJTVVnclB6dFRVbU5WVFFZQXdwbmp4cTRIWk9tMy90?=
 =?utf-8?B?cDVOcnB3WGtqVzVwemExbVZYdFdiU084OFhFV3g2T2EwdUtBczhlMkgvVGxV?=
 =?utf-8?B?d1FCTDI2NzZYOGlnWXdtVkpBN2w4NXVRVWd2dkFaR3piREIzcVBRdTRRYnFU?=
 =?utf-8?B?VUpTK1dnNkdqTndvblI1WlI2d1ZZVFBpWHdkMWpoWUR1SHA5dVNhOTNGK1pS?=
 =?utf-8?B?TlREMUVpT0FBL1FrRUw0dGtFVkVwUE1XTFMySktLQUMxaUllZXBCRVhSbHcv?=
 =?utf-8?B?bDQvemNncWxHd0IwVXZzZHlERnhWRWtmSGlrWHFrdml0Y09JUHVmRitaRjRN?=
 =?utf-8?B?VmZzeG55ZkpGd09PVVh3UWxqWXR0TzJKZ0JXY1pNUDVYYWN1NmFtZlkrek84?=
 =?utf-8?B?SStCRG1DU2wvNDgyM2ZkNHlWUHpiMkg4MjM2MkdNVkw1cnAwdnZLbFFORjBX?=
 =?utf-8?B?YWxjdnBlSklmaFAxdTVnN1hYQmZIU1JOSVJRSEk3dnNFVnY2RExvd3RPVm1M?=
 =?utf-8?B?ZnM1THpSVnIzQ2hYRy9VblZZUkJOZzV5NVVKMVhqb2tpNlJhRU1iRWtaTC93?=
 =?utf-8?B?cWpVV1lEd1hFMnIzV1NFOWN5SnpLMWtveDZSTG5Md3ZJQjE0VnhZUDh2aEFk?=
 =?utf-8?B?Z2k4NHkwT0ZvaFhaZVNUK1E1c2J5UEhqYTIwYk1zL3VFeGIyVEVZbzJ1ZWRm?=
 =?utf-8?B?RFovRXRzSUVKd2Y5SHY3VkU4NXAvSjkwREVZRUhJNDhpMys4VEhlNWlDZHdG?=
 =?utf-8?B?RVB0VHFKUHpZemw3b2Q1d0tHbkdSclJYZlJFdmdBZGk1OGRIRU9mVktrd2lM?=
 =?utf-8?B?MDl5Z1NSTnJIaUxxM0lLdHJ5ZkZVaUJ4SjRNMkFucmxyMmpaMVNuTlNHM3FZ?=
 =?utf-8?B?Z01zdWNUbEo5clJJVTFMQjJVOStQVlUrQWl5dGJFNE9FWkkvdkhIblVXZnZP?=
 =?utf-8?B?RW84QXJqZ0dTdUVQNWRIbXMzUHpIU2kwelRORTNISWYvWHV4RFNpdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6633.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b62f5ec5-384e-4b31-4dc4-08da43d19261
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 13:21:00.8797 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EbyJHbM0rKPeMeH6KunYIJ3aaxnr6gVNnuo2uBWpzztnK2p1LgYBtjxA2zLrGIIS9gnCyhm+FW1KLeCykDzFMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0110
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

W1B1YmxpY10NCg0KSGkgQ2hyaXN0aWFuLA0KDQpObyBvdGhlciBjb21tZW50cy4gV2l0aCBwLT5q
b2JzW2ldIGZpeGVkLCB0aGUgdGVzdCBjYXNlIHdvcmtlZC4gSSBoYXZlIHRvIGNsZWFuIHVwIHRo
ZSBjb2RlIGFuZCBzZW5kIGl0IGZvciByZXZpZXcuDQpJIHdhbnRlZCB0byBhZGQgY29tcGFyaW5n
IHRoZSB0aW1lIHdpdGggYW5kIHdpdGhvdXQgZ2FuZyBzdWJtaXNzaW9uIGFuZCBmYWlsIHRlc3Qg
Y2FzZSBpZiBmb3JtZXIgaXMgc2xvdy4gSSB3aWxsIGRvIHRoaXMgbGF0ZXIuIEkgd2lsbCBzZW5k
IHRoZSB0ZXN0IGNhc2UgZm9yIHJldmlldyBmaXJzdC4NCg0KVGhhbmsgeW91LA0KWW9nZXNoDQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hy
aXN0aWFuLktvZW5pZ0BhbWQuY29tPiANClNlbnQ6IFdlZG5lc2RheSwgSnVuZSAxLCAyMDIyIDU6
NDIgUE0NClRvOiBNb2hhbiBNYXJpbXV0aHUsIFlvZ2VzaCA8WW9nZXNoLk1vaGFubWFyaW11dGh1
QGFtZC5jb20+OyBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWls
LmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBPbHNhaywgTWFyZWsgPE1hcmVr
Lk9sc2FrQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIDEwLzEwXSBkcm0vYW1kZ3B1OiBh
ZGQgZ2FuZyBzdWJtaXQgZnJvbnRlbmQNCg0KDQoNCkFtIDAxLjA2LjIyIHVtIDE0OjA5IHNjaHJp
ZWIgTW9oYW4gTWFyaW11dGh1LCBZb2dlc2g6DQo+IFtTTklQXQ0KPiAtCS8qIE1ha2Ugc3VyZSBh
bGwgQk9zIGFyZSByZW1lbWJlcmVkIGFzIHdyaXRlcnMgKi8NCj4gLQlhbWRncHVfYm9fbGlzdF9m
b3JfZWFjaF9lbnRyeShlLCBwLT5ib19saXN0KQ0KPiArCWxpc3RfZm9yX2VhY2hfZW50cnkoZSwg
JnAtPnZhbGlkYXRlZCwgdHYuaGVhZCkgew0KPiArDQo+ICsJCS8qIEV2ZXJ5Ym9keSBleGNlcHQg
Zm9yIHRoZSBnYW5nIGxlYWRlciB1c2VzIEJPT0tLRUVQICovDQo+ICsJCWZvciAoaSA9IDA7IGkg
PCAocC0+Z2FuZ19zaXplIC0gMSk7ICsraSkgew0KPiArCQkJZG1hX3Jlc3ZfYWRkX2ZlbmNlKGUt
PnR2LmJvLT5iYXNlLnJlc3YsDQo+ICsJCQkJCSAgICZwLT5qb2JzW2ldLT5iYXNlLnNfZmVuY2Ut
PmZpbmlzaGVkLA0KPiArCQkJCQkgICBETUFfUkVTVl9VU0FHRV9CT09LS0VFUCk7DQo+ICsJCX0N
Cj4gKw0KPiArCQkvKiBUaGUgZ2FuZyBsZWFkZXIgYXMgcmVtZW1iZXJlZCBhcyB3cml0ZXIgKi8N
Cj4gICAJCWUtPnR2Lm51bV9zaGFyZWQgPSAwOw0KPiArCX0NCj4NCj4NCj4gcC0+am9ic1tpXSA9
IE5VTEwgaXMgZG9uZSBpbiBwcmV2aW91cyBsb29wLiBOb3cgd2hlbiBydW5uaW5nICZwLT5qb2Jz
W2ldLT5iYXNlLnNfZmVuY2UtPmZpbmlzaGVkIHRoZXJlIGlzIE5VTEwgcG9pbnRlciBjcmFzaC4N
Cg0KQWgsIHllcyBnb29kIHBvaW50LiBHb2luZyB0byBmaXggdGhhdC4NCg0KQW55IG1vcmUgY29t
bWVudHMgb24gdGhpcz8gRGlkIHlvdSBmaW5pc2hlZCB0aGUgdGVzdCBjYXNlcz8NCg0KVGhhbmtz
LA0KQ2hyaXN0aWFuLg0K
