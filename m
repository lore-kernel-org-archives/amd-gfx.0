Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC85FEB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 04:56:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 272FF10E114;
	Wed, 19 Jul 2023 04:56:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ACAF10E114
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 04:56:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWLy+Wglo5qomZOcpXuiGxYDQ5Si/Eqz3Q96RF1Vo9IFV92D2A0z5xa9iBcilvyTmL7QhRU2xUIG1W5K4HlKi3RGGWXRe733gWCCKvWfoAuZl60uTQm9jjWi7XbJ0Q1t2fcbN1byfqF832ku7O9e3epiz1HJsDXNGgNaVrsmEtH70dsn7whe+1PaLkWP3sXuK+3hwLAWFxCon57YXNQ+2WUwAMXLAEvwwpWrVD9PQh0lKj0rY9tatZLc/Dv06K0SOrbWLMuVkustEo+kxPJ/DVqUS/DpOLSyR3dRWS74y2gTtvxmP3nZEUcoWB8Vw2Rd6nlMFCHuiQLOPog1+yKcVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+o/Q9WfZWPApnmitSRpcgL+4UjP21z3fRY1+58nJbk=;
 b=lIzgIJYn5SbHQlZLwSkDE1cQ5hfqp9G+WbMOCrye2lMnSOTQinWR8zmYBo3DLCWhCYt8kuj12d1pfIjHL1ZPjgEK66u5/JAn0LAapEHr2iQY0YDm6hWc7z6+vsfED3Af3K5qNXASbhxuRi+KtxjSsbijhYU8T33aqc/kaGdbq9BwTh2w1Gr5xQytep6pQ40E9vOxfLWMHlY6zuWCnjJjz6cEw+OvyvXanUUotbajgJR5GkU+mJHq4rS4BSxvPbAQaVaUSwHR1+VTOst+IUB07Mk7nwM0e3gdONlJZbCLOlEkawB4soTNuoshD6QZhl8ic2+xRbIXV8B7ViyLU8PHPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+o/Q9WfZWPApnmitSRpcgL+4UjP21z3fRY1+58nJbk=;
 b=HvuWWbQN3bdNsUNfAXu7241MNTgJlFvh5AG6V+iWvJ39yPdD4pZtqlSYqywhEgpiyvfwB0rBFd3qJdB57xmbhqUh02ECb24601pSlqkajks7WQeqKGGk64pDP91vHMe5qlTsWWod/zdvOdLEWFAsX9kukKhbszC7GCGfpKVYnCY=
Received: from BL0PR12MB2465.namprd12.prod.outlook.com (2603:10b6:207:45::18)
 by IA0PR12MB8256.namprd12.prod.outlook.com (2603:10b6:208:407::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 04:56:12 +0000
Received: from BL0PR12MB2465.namprd12.prod.outlook.com
 ([fe80::7794:8bfc:194d:583f]) by BL0PR12MB2465.namprd12.prod.outlook.com
 ([fe80::7794:8bfc:194d:583f%4]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 04:56:12 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Update ring scheduler info as needed
Thread-Topic: [PATCH] drm/amdgpu: Update ring scheduler info as needed
Thread-Index: AQHZuXJrsC8odZOAM02mqmvvZ7/enq+/jWyAgAAFT4CAAA4RAIAADKMAgAAEIwCAAADYgIAAmyrggAA5QoCAAADSwA==
Date: Wed, 19 Jul 2023 04:56:12 +0000
Message-ID: <BL0PR12MB24659AAEA25A059047520DC8F139A@BL0PR12MB2465.namprd12.prod.outlook.com>
References: <20230718122120.2938177-1-lijo.lazar@amd.com>
 <843196d3-fc53-77f3-26c5-8df479539f7e@amd.com>
 <c4ea8242-ff13-f395-2eb4-b15633253dcd@amd.com>
 <5de2cb5b-ccc2-68a6-aacf-f1882885817c@amd.com>
 <23ca1d49-ea6d-0980-1bdc-f24a48a880ab@amd.com>
 <7c6c2699-0732-9e6b-4c5c-f36bcfa83814@amd.com>
 <844c21ed-fdeb-d6d7-f103-c4d0660544ae@amd.com>
 <BL0PR12MB2465A275C88351932936B5FEF139A@BL0PR12MB2465.namprd12.prod.outlook.com>
 <a6778216-9170-120d-eae4-2c8000df35d0@amd.com>
In-Reply-To: <a6778216-9170-120d-eae4-2c8000df35d0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=34f710cb-bb1e-4047-b4c1-0b8a4fe2256d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-19T04:55:48Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB2465:EE_|IA0PR12MB8256:EE_
x-ms-office365-filtering-correlation-id: 3008ca9b-47da-4328-89b1-08db88147984
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /l+/el+y0h3vT76vTZnNLHc9QWyb8TCgLWn4Fq3w2IA4rCmySZVEdZpg7Z4teuUlBh4rqWBzjxyC+mbaiWsaIG9KeDi1KJsJnD6dIIBF0emOGEf+nR3NPagR1DSlPh1d10id/5tDaTjtvJLCXtl2YPT8ojBeBvnSTAQun/vYMuR866TV5Ru9QpBTwX7ua3CjV/9bilPc3OQ1Bn7D8e5qDTR9kWlbUz+2H1lCLtOn3v2ek+eSlzOT7w+PoV2TOCmAcb/hwQ2LD2GS6NTPOq6LJmeRR2YNIPLVmvyXgnngUkRnB6Kzzf4gi8V3GkuELFRFBpxqBd3sPKmh6xwV+T40V6tVTKs0pOxqjez43kMUtvyExsBbwiFqNM9R6KV/hzI5nvPDa40AwUfbmwfUCwy+Q1kHXQmpeGffukoIwV9AT7AR8+1cbSSVCzotPFL4Zl/XXRskglGAaft5hwjvrqs1dm/fRzaSmcdXdzgFPxR2I8+oQh6fIpj4D2jc4m15fYie6WQVo5zZyU7mwep1ATaVTumWsZ64hcZ8WSsC94olrwKwYy0HFvWZJwyvlgiIyEG10ibragmSPzFNRQMY/BQa30iloUj9XkcAIVgZU8a/nn5yKWa+HOGMgGR9DwH7EH5W
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2465.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199021)(7696005)(54906003)(71200400001)(478600001)(110136005)(15650500001)(83380400001)(38070700005)(33656002)(86362001)(55016003)(2906002)(76116006)(6506007)(186003)(53546011)(26005)(9686003)(4326008)(38100700002)(122000001)(66476007)(64756008)(66446008)(41300700001)(66556008)(66946007)(316002)(8676002)(5660300002)(52536014)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YW5iakJ0ZFVYTmt5ckxpeUY1enR3SkI3T3VkQ0s4WmlwajFPUWNSOWIwMHhE?=
 =?utf-8?B?ZlNuSjVmclUvckg0eWVVbmNuYnlsZjJydklza2JLUEpmUjlzdWprUTF1THI2?=
 =?utf-8?B?M0J5Uy81OUpNSnhvelFNQnpCTFJ6WDUrNUNRdCs4OGpNZDZ3ME9MWmJVMXlB?=
 =?utf-8?B?TlpvNFJoQjZDN1grQTJXTFAwbWJ1TDZmVzFNd2xIbGZFVDNVYXlFM1hKdnVk?=
 =?utf-8?B?eXVISFNqckhEc1JhNWhVdmV2ajB3eWx0cGVZd3lCczNhdjVBbUhhekRJeHVC?=
 =?utf-8?B?aGtVRDZ1enZzcmIwZFA5OC9DcjBXQW1vN1d2YWd3Z3orNTl6SG9YSUU3RVVy?=
 =?utf-8?B?MjFBWUIza2pqYlh1cU1KZ3VEL0w2c3lIOCtDY2FOMk1WVUIzMjlsQXJRZHJP?=
 =?utf-8?B?SllEc3FsaWJCNVFRSkpycUxlUFY1Mkhoc3lYT1hjdytRZ2ZUdFRma0VmNkVY?=
 =?utf-8?B?K1ZvMzRPZmhYdmJaaXFZL3VJRWM3N3lrUHA1MUxMam1MQS94bFM1T28rYlJJ?=
 =?utf-8?B?UUIzUTE4WEJXOEEwRGpIOU5JMDFBZS8ydEcwdmt3MkFxVGgrc1V3WFdEVWpn?=
 =?utf-8?B?VTdtbjZ4M0d4RVNzaHNibHFCRnFaanArNTRZZVVtV0t4K0pybnVhOHo3QWZI?=
 =?utf-8?B?Ty9LMThNb3B5bzErWGdPYlVFNTVqa0l5MUxmUkZhSUNXaGs2MTFlQlBMRVlR?=
 =?utf-8?B?UVlYamNFem43NW9oNWRjTXMrR0ZLalJqNWhubEdlUWJ4dEtaTG50WEdlWTFP?=
 =?utf-8?B?dTF2VDhJUUtMaHBNOVluSzBQS1VmUGtOUFNWNzVTcGVJeHhIdkFpNXFGQ0Iz?=
 =?utf-8?B?RlBjTVZFUEFTcDZHVGJwQnc4MGJXcHRRWkRGa29rNzlXcUFnUm1SY1ZQZUpr?=
 =?utf-8?B?WEQ3ejZwN01hQW1zaG9ic2QxNmRIYlcxdEd4NUVweWVQNzMwRklHV1I1N1By?=
 =?utf-8?B?WG9STEV1RzFRVFZTTnJ2UjVUTTdhWEpRRDZhTTRNV3pvbVV5cWdoUHp4UlVC?=
 =?utf-8?B?OEtnc1p5TnpJUjZ0VkhSSFp2ZEZlVk1nYUYwN3M1SEJRb0h0RUMrWlp0eExO?=
 =?utf-8?B?MmJmUWpoTE1oRFBZL29uejZtZjFwSmRrVkRzOHhiWmZid0J6dHRPR0Jmdzl3?=
 =?utf-8?B?bTNWMUtpVW1xQUNkZ3M5akd1OENPWnVlbWtyakpmRGhJVjVzL0VSZVFaei9q?=
 =?utf-8?B?eFF3TitlckxqWEZhcW5pWi83UkUyR3QrVGdQb29rdTEyNnJjR3o3Nk1GZGdh?=
 =?utf-8?B?YlRCdFpOU2dKNk10c3h3Y2VQTlhZZkpscnhQa0ZhRWVXcjVaSWdRK3JWNFRJ?=
 =?utf-8?B?Z2ZTaDlSNjNEV2hIdUdiQWZYUitSRG9PK1JpYmtGb0JIV0ROV2NXRUVKU2hq?=
 =?utf-8?B?U3B5TFBYV1BubWd5dW1SWFBpYmxtOTMxajAyL1V2Rnd0WUswNUVxT1VaS29D?=
 =?utf-8?B?djZsU2Q4dCtHNlhmemQrcUZNanpsOWFWWFJGc1Ayb2VOZ1JXK1hMSElTMVU0?=
 =?utf-8?B?L2pLYXRtcVRCb1NhbG5KaXV1cWtQSTJtRW9SVFFGNm1pM0VaUmpKR1JlUlcw?=
 =?utf-8?B?ZlhwT2ZpVlVRdlg0ajZLNTk3ZkprTzNiNi9ZVi9IbFAzUUI0aVdXUTczU1ZY?=
 =?utf-8?B?RFhIRGZma21IZGFVZWtoY3JJdUJSNEhqSGlVbkc5b2hoaWxUbWFPdFhoaE13?=
 =?utf-8?B?Q3gvQ0svVzRCdHU1dStudFVCaFdkdFc4MFkxK3RoOFBHeVFnMTVtaXMwaXZS?=
 =?utf-8?B?aTR0dFVtUEUrTTV2WGw4Y0pLWFJKNFR6M0IzQTQ1Z2htazdCa2NKYkp0MG9D?=
 =?utf-8?B?R1dQQ0hjeDFCOHErOElFSHViWkE2blc1YmhNWjJJUkhIR1lRU0dVVDZ5dWZC?=
 =?utf-8?B?aVpsQ2xIZ0dPdWZhYUt5U1l2MHJhbm5uUjd5bkV5M0hIaVJtdjVWWk12SDVn?=
 =?utf-8?B?NlNxY2krSFdiS2JuVGVzb0lyVkZJWDdKYlYxQ0M0ZXlvWUVmQ2ZOYXhHVVlL?=
 =?utf-8?B?S1FxeDhrLzFzR2NNdzJuWUFraXlNV2VRS0ZhYWJXREc2Z3BVQkcra3pvRlQx?=
 =?utf-8?B?bE04VTB3amZWOHhia3RjczhhTytuTDd1YWoxSElHUStLZnhlWk9MVmUwTlRV?=
 =?utf-8?Q?X1KM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2465.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3008ca9b-47da-4328-89b1-08db88147984
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 04:56:12.2398 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LtYMQF3NINRId/DSveDEmONA2pdE+4/0inV6riwyIOAFJ5DmjOsgsfch9WiXCOG0cuKnpnYqNOkI5UZUudwURw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8256
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal,
 Asad" <Asad.Kamal@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXphciwg
TGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMTksIDIw
MjMgMTI6NTMgUE0NCj4gVG86IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNvbT47IFpo
dSwgSmFtZXMNCj4gPEphbWVzLlpodUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNv
bT47IEthbWFsLCBBc2FkDQo+IDxBc2FkLkthbWFsQGFtZC5jb20+OyBaaGFuZywgSGF3a2luZyA8
SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1
OiBVcGRhdGUgcmluZyBzY2hlZHVsZXIgaW5mbyBhcyBuZWVkZWQNCj4NCj4NCj4NCj4gT24gNy8x
OS8yMDIzIDEwOjEyIEFNLCBDaGVuLCBHdWNodW4gd3JvdGU6DQo+ID4gW1B1YmxpY10NCj4gPg0K
PiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBhbWQtZ2Z4IDxhbWQt
Z2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YNCj4gPj4gTGF6
YXIsIExpam8NCj4gPj4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDE5LCAyMDIzIDEyOjEzIEFNDQo+
ID4+IFRvOiBaaHUsIEphbWVzIDxKYW1lcy5aaHVAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnDQo+ID4+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVj
aGVyQGFtZC5jb20+OyBaaHUsIEphbWVzDQo+ID4+IDxKYW1lcy5aaHVAYW1kLmNvbT47IEthbWFs
LCBBc2FkIDxBc2FkLkthbWFsQGFtZC5jb20+OyBaaGFuZywNCj4gSGF3a2luZw0KPiA+PiA8SGF3
a2luZy5aaGFuZ0BhbWQuY29tPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1
OiBVcGRhdGUgcmluZyBzY2hlZHVsZXIgaW5mbyBhcyBuZWVkZWQNCj4gPj4NCj4gPj4NCj4gPj4N
Cj4gPj4gT24gNy8xOC8yMDIzIDk6MzkgUE0sIEphbWVzIFpodSB3cm90ZToNCj4gPj4+DQo+ID4+
PiBPbiAyMDIzLTA3LTE4IDExOjU0LCBMYXphciwgTGlqbyB3cm90ZToNCj4gPj4+Pg0KPiA+Pj4+
DQo+ID4+Pj4gT24gNy8xOC8yMDIzIDg6MzkgUE0sIEphbWVzIFpodSB3cm90ZToNCj4gPj4+Pj4N
Cj4gPj4+Pj4gT24gMjAyMy0wNy0xOCAxMDoxOSwgTGF6YXIsIExpam8gd3JvdGU6DQo+ID4+Pj4+
Pg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IE9uIDcvMTgvMjAyMyA3OjMwIFBNLCBKYW1lcyBaaHUgd3Jv
dGU6DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBPbiAyMDIzLTA3LTE4IDA4OjIxLCBMaWpvIExhemFy
IHdyb3RlOg0KPiA+Pj4+Pj4+PiBOb3QgYWxsIHJpbmdzIGhhdmUgc2NoZWR1bGVyIGFzc29jaWF0
ZWQuIE9ubHkgdXBkYXRlIHNjaGVkdWxlcg0KPiA+Pj4+Pj4+PiBkYXRhIGZvciByaW5ncyB3aXRo
IHNjaGVkdWxlci4gSXQgY291bGQgcmVzdWx0IGluIG91dCBvZiBib3VuZA0KPiA+Pj4+Pj4+PiBh
Y2Nlc3MgYXMgdG90YWwgcmluZ3MgYXJlIG1vcmUgdGhhbiB0aG9zZSBhc3NvY2lhdGVkIHdpdGgN
Cj4gPj4+Pj4+Pj4gcGFydGljdWxhciBJUHMuDQo+ID4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+IFNpZ25l
ZC1vZmYtYnk6IExpam8gTGF6YXIgPGxpam8ubGF6YXJAYW1kLmNvbT4NCj4gPj4+Pj4+Pj4gLS0t
DQo+ID4+Pj4+Pj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FxdWFfdmFuamFyYW0u
YyB8IDIgKy0NCj4gPj4+Pj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hcXVhX3ZhbmphcmFtLmMNCj4gPj4+Pj4+Pj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hcXVhX3ZhbmphcmFtLmMNCj4gPj4+Pj4+Pj4gaW5kZXggNzJi
NjI5YTc4YzYyLi5kMGZjNjI3ODRlODIgMTAwNjQ0DQo+ID4+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FxdWFfdmFuamFyYW0uYw0KPiA+Pj4+Pj4+PiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hcXVhX3ZhbmphcmFtLmMNCj4gPj4+Pj4+Pj4gQEAgLTEz
NCw3ICsxMzQsNyBAQCBzdGF0aWMgaW50DQo+ID4+Pj4+Pj4+IGFxdWFfdmFuamFyYW1feGNwX3Nj
aGVkX2xpc3RfdXBkYXRlKA0KPiA+Pj4+Pj4+PiAgICAgICAgZm9yIChpID0gMDsgaSA8IEFNREdQ
VV9NQVhfUklOR1M7IGkrKykgew0KPiA+Pj4+Pj4+PiAgICAgICAgICAgIHJpbmcgPSBhZGV2LT5y
aW5nc1tpXTsNCj4gPj4+Pj4+Pj4gLSAgICAgICAgaWYgKCFyaW5nIHx8ICFyaW5nLT5zY2hlZC5y
ZWFkeSkNCj4gPj4+Pj4+Pj4gKyAgICAgICAgaWYgKCFyaW5nIHx8ICFyaW5nLT5zY2hlZC5yZWFk
eSB8fCByaW5nLT5ub19zY2hlZHVsZXIpDQo+ID4+Pj4+Pj4gW0paXSBhbnkgY2FzZSBmb3Igcmlu
Zy0+bm9fc2NoZWR1bGVyID0gdHJ1ZSwgYnV0DQo+ID4+Pj4+Pj4gcmluZy0+c2NoZWQucmVhZHkg
PSB0cnVlPw0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IGFtZGdwdV9nZnhfa2lxX2luaXRfcmluZyBzZXRz
IG5vX3NjaGVkdWxlciBmbGFnIHRydWUgZm9yIGtpcSByaW5ncy4NCj4gPj4+Pj4+IGFtZGdwdV9k
ZXZpY2VfaW5pdF9zY2hlZHVsZXJzIGluaXRzIHNjaGVkdWxlcnMgb25seSBmb3IgcmluZ3MNCj4g
Pj4+Pj4+IHdoaWNoIGRvZXNuJ3QgaGF2ZSBub19zY2hlZHVsZXIuIEhvd2V2ZXIgaW4NCj4gPj4+
Pj4+IGdmeF92OV80XzNfeGNjX2tpcV9yZXN1bWUsIHRoZSByaW5nIGlzIG1hcmtlZCB3aXRoDQo+
ID4+Pj4+PiByaW5nLT5zY2hlZC5yZWFkeSA9IHRydWU7DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gSSdt
IG5vdCBzdXJlIHdoeSBpdCdzIGRvbmUgdGhpcyB3YXksIGJ1dCB0aGlzIGlzIHRoZSBjYXNlIGV2
ZW4NCj4gPj4+Pj4+IGZvciBnZnh2OS4NCj4gPg0KPiA+IERyaXZlciBzbyBmYXIgc3RpbGwgaGFz
IHNvbWUgY29uY2VwdCBhYnVzZSBvbiBzY2hlZC5yZWFkeS4gSW4NCj4gYW1kZ3B1X2RldmljZV9p
bml0X3NjaGVkdWxlcnMgLCBpdCdzIHNldCB0byBiZSB0cnVlIG9uY2Ugc2V0dGluZyB1cCBzdw0K
PiBzY2hlZHVsZXIgZm9yIHRoZSByaW5nIHJlcXVpcmVtZW50LCBob3dldmVyLCBhZnRlciBkcml2
ZXIgaXMgdXAsIHRoaXMgZmxhZw0KPiB3b3JrcyBsaWtlIGEgaGludCB0byB0ZWxsIHRoZSBjb3Jy
ZXNwb25kaW5nIHJpbmcgaXMgcmVhZHkgZm9yIEhXIHN1Ym1pc3Npb24NCj4gYWZ0ZXIgcmluZyB0
ZXN0IHN1Y2NlZWRzLg0KPiA+DQo+ID4gRm9yIHRoaXMgY2FzZSwgaXQncyBwcm9iYWJseSBjYXVz
ZWQgYnkgYW1kZ3B1X2dmeF9lbmFibGVfa2NxICBjYWxsaW5nDQo+IGFtZGdwdV9yaW5nX3Rlc3Rf
aGVscGVyLCB3aGljaCBzZXRzIHNjaGVkLnJlYWR5IHVuY29uZGl0aW9uYWxseSBiYXNlZCBvbg0K
PiByaW5nIHRlc3QgcmVzdWx0LiBUaGlzIHdpbGwgbGVhZCB2YWx1ZSBtaXNtYXRjaCBiZXR3ZWVu
IHJpbmctPm5vX3NjaGVkdWxlcg0KPiBhbmQgcmluZy0+c2NoZWQucmVhZHkuIElmIG15IHVuZGVy
c3RhbmRpbmcgaXMgY29ycmVjdCwgSSB0aGluayBhZGRpbmcgYSBjaGVjaw0KPiBpbiB0aGlzIGhl
bHBlciBmdW5jdGlvbiB3aGljaCBvbmx5IHNldHMgc2NoZWQucmVhZHkgd2hlbiBub19zY2hlZHVs
ZXIgaXMNCj4gZmFsc2Ugd2lsbCBoZWxwLiAgU28gSSB3aWxsIHByb3ZpZGUgYSBwYXRjaCBzb29u
IHRvIHByZXZlbnQgdGhpcyBtaXNtYXRjaCBpbg0KPiBmdXR1cmUuDQo+ID4NCj4gPiAraWYgKCFy
aW5nLT5ub19zY2hlZHVsZXIpDQo+ID4gKyAgICAgICByaW5nLT5zY2hlZC5yZWFkeSAhPSByOw0K
Pg0KPiBUaGUgcmluZy5yZWFkeShyaW5nLT5zY2hlZC5yZWFkeSkgZmxhZyBpcyB1c2VkIGluIGdt
Y3Y5IGNvZGUgYXMgd2VsbC5UaGlzIHdpbGwNCj4gbmVlZCBtb3JlIHJld29yay4NCg0KRXhhY3Rs
eSwgbGV0IG1lIGRvdWJsZSBjaGVjay4NCg0KUmVnYXJkcywNCkd1Y2h1bg0KDQo+IFRoYW5rcywN
Cj4gTGlqbw0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiBHdWNodW4NCj4gPg0KPiA+Pj4+PiBbSlpd
IEkgdGhpbmsgdGhlIHNjaGVkLnJlYWR5IGNvbmZ1c2VzIHBlb3BsZS4gaGVyZSBqdXN0IG1lYW5z
IHJpbmcNCj4gPj4+Pj4gaXMgcmVhZHkgYmUgdXNlZC4NCj4gPj4+Pg0KPiA+Pj4+IFRoYW5rcyBm
b3IgdGhlIGNsYXJpZmljYXRpb24uIE9uZSBxdWVzdGlvbiBpcyB0aGVuIGRvIHdlIG5lZWQgdG8N
Cj4gPj4+PiBjaGVjayByaW5nIHJlYWR5IHN0YXR1cyBmb3IgYXNzaWduaW5nIHhjcCBpZHMgb3Ig
anVzdCBjaGVjayBpZiB0aGUNCj4gPj4+PiByaW5nIGlzIGFzc29jaWF0ZWQgd2l0aCBhIHNjaGVk
dWxlcj8NCj4gPj4+Pg0KPiA+Pj4+IEtlZXAgb25seSB0aGlzIC0gaWYgKCFyaW5nIHx8IHJpbmct
Pm5vX3NjaGVkdWxlcikgdG8gYXNzaWduIHhjcCBpZHMNCj4gPj4+PiBhbmQgbGVhdmUgdGhlIHJp
bmcgcmVhZHkgc3RhdHVzIHRvIHRoZSBsb2dpYyB3aGljaCByZWFsbHkgYWNjZXB0cw0KPiA+Pj4+
IGpvYnMgb24gdGhlIHJpbmc/DQo+ID4+PiBbSlpdIEkgdGhpbmsga2VlcGluZyByaW5nLT5zY2hl
ZC5yZWFkeSB3aWxsIHJlZHVjZSBzY2hlZHVsZSBsaXN0DQo+ID4+PiB3aGljaCB3aWxsIHNhdmUg
YSBsaXR0bGUgc2NoZWR1bGluZyB0aW1lLg0KPiA+Pg0KPiA+PiBGaW5lLCB3aWxsIGp1c3QgcHVz
aCB0aGlzIG9uZS4NCj4gPj4NCj4gPj4gVGhhbmtzLA0KPiA+PiBMaWpvDQo+ID4+DQo+ID4+Pj4N
Cj4gPj4+PiBUaGFua3MsDQo+ID4+Pj4gTGlqbw0KPiA+Pj4+DQo+ID4+Pj4+PiBUaGlzIHBhdGNo
IGlzIFJldmlld2VkLWJ5OiBKYW1lcyBaaHUgPEphbWVzLlpodUBhbWQuY29tPg0KPiA+Pj4+Pg0K
PiA+Pj4+Pj4gVGhhbmtzLA0KPiA+Pj4+Pj4gTGlqbw0KPiA+Pj4+Pj4NCj4gPj4+Pj4+Pj4gICAg
ICAgICAgICAgICAgY29udGludWU7DQo+ID4+Pj4+Pj4+ICAgICAgICAgICAgYXF1YV92YW5qYXJh
bV94Y3BfZ3B1X3NjaGVkX3VwZGF0ZShhZGV2LCByaW5nLA0KPiA+Pj4+Pj4+PiByaW5nLT54Y3Bf
aWQpOw0K
