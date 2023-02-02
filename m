Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B716FC61DA4
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Feb 2023 16:50:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 260CB10E21D;
	Thu,  2 Feb 2023 16:50:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0A9710E21D
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Feb 2023 16:50:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5nSBacLqB084eFXb8tsDgKgnZir1BeYybBQxMpPBewKnP+NupAj5GSWen9j05AS0AWSWhUDllTEFCDD/Vz4FoNvKwjVwSvVG3eQAF5KUVxNzE0mXmOLumI5im3xJOw1lrum1yuYkMuRVB3ibWdLQv0Ib5vba2WlJx+Sy4Bu7kCpGCkR407KpoiIHcSagqYuvg5KsQrnN19kBzyb6MAtWSLHriWGJCXvWu83cd9Dq7qBkLHDzCaD0c6HiXpNooZ0QWTCGxvXQgc4tu6olgoxoWenCrLo9HC/FOtG7SS7OTg1QVg6Ycw5rWTg+dKqOCJ3JH1W2yVhkPzL9s4KDHndXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EvzcvEkaRDeStJrTaO3xm026Vom1Prv39NKs9asL8k=;
 b=luEdQDO7Pypgfla1wNWDU3EyrbxO/CHBpxArMX6QZk3jcZuBHiB9K9QwEvKJ56TFM3qZnQM9+WCe8baPI4WV7JKhk5Lh7zEFlLTFunNkaYBRqHW3Dnj3QQ+Y1nG6QzjT9FigIJl6gcc0UOYog+NasiGYRINFkwFbXlft1LzQQNqSBeRl1G5u0M0cotkkjSkpOiRE/YEzzl33ovwwgela1xJ+xO9OlWkYfQaqZbnmcU4vWPXwnI8GXRmJGR4qUOXgpmghKJm+PPrRCwSZtB7T6nRtITzhNDUCoyNJH3/A5E5iHJEOA+WXi8qH8TeYLxDYTC4EJfJ2qi8uiMZ/JKBb9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EvzcvEkaRDeStJrTaO3xm026Vom1Prv39NKs9asL8k=;
 b=k3ELm5ZMsE8UEyBwOuLUZWt/43pdH6VTH01TJmKLErt0rR+Tv5xROHbLcI1kNMXvQbKdjiJs5ZPulo/LBocEkswAPt8T65MTZd7TsMsDko2SLr/xLLjE2kd/wSIwTr6YDhf2dtbxon2gFXpxa+TcvFpNUiFpqQavm98L6dd3m4o=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL3PR12MB6642.namprd12.prod.outlook.com (2603:10b6:208:38e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.23; Thu, 2 Feb
 2023 16:49:59 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%6]) with mapi id 15.20.6064.027; Thu, 2 Feb 2023
 16:49:58 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amd: Allow s0ix without BIOS support
Thread-Topic: [PATCH] drm/amd: Allow s0ix without BIOS support
Thread-Index: AQHZMOuL9X1oXh+7yEKLTRPXAMqCHa67EMgAgADZl7A=
Date: Thu, 2 Feb 2023 16:49:58 +0000
Message-ID: <MN0PR12MB6101B5B0F3C6AB96167E9926E2D69@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230125183339.15664-1-mario.limonciello@amd.com>
 <CADnq5_NvUVJG8k_VPrm6N48ZUhnJTDBBB3WUrpCpeBTuq8YP8w@mail.gmail.com>
In-Reply-To: <CADnq5_NvUVJG8k_VPrm6N48ZUhnJTDBBB3WUrpCpeBTuq8YP8w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-02T16:48:45Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2863f412-301e-4b67-8566-4cba15b1ad5a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-02-02T16:48:45Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 4cb7ed7a-bd7f-4b45-8d4b-d15216ef0f93
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|BL3PR12MB6642:EE_
x-ms-office365-filtering-correlation-id: 0a20729a-e167-486b-be96-08db053d8537
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pVrSWDq9/nfnnteXckrHMaTgiKWo7WcU7QR/VLMQSwndOsRkmtxRebX4+paKaO3nKhs0zeeG4KfiyskFptI4iCNHRX8t6L8h8dMGh+8EfelqcDdr7TaJThN2sduuUcB7rMmOlgM2LfXCyAwCstBwMGRyPwsvA6yXlA3+ArnvFeDbLFBsjgZwQJvtLfnmV0Yqo+pr1t76egMGluGpClaCfSC1KIGi5FlKxp3SxkkT1XPrur4vxPkkVkK4tkGomtlKi5jbend++pMyPkEecy1xgUbHVdhiSx+Cz8+IaPUhHoJnHXDh4MJCvX8cX5Fm/kgnXJ0FCiN8k24mZqWpOakrKd45LKgLuauYRy6TLZV7xdc7l9UlzXb9d67SyizyVCGc9WF6K9lCpt55I6VdN0ngNmlTPk/hH4pJcNWyitBRwks5iByl8DIv0GLqWFFae86V5AK0QspH27dvknTHGkAyCuUg1vNUj4o10Awh+l068pDay6Aj0LTae4sjP3eDpyq4Snl0Z98hL54FRFJAY6OTyAscPc+VLdtlYsMnlVCgrSIl/h/WvIVTlWUiwFpzC4L9IfgLoW+tIjb0qrLGsJ9m1rM6Ial3uUisyveigqtOl3RgYiT7QY5edMuhOYxs7SK+qblQWttNVqmzlYc8zzPRKyUwwdr4y7cCyybsQXdT+WY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199018)(54906003)(5660300002)(316002)(38100700002)(55016003)(8676002)(64756008)(66946007)(76116006)(122000001)(66476007)(66556008)(4326008)(66446008)(66899018)(6916009)(52536014)(8936002)(38070700005)(41300700001)(478600001)(186003)(6506007)(966005)(9686003)(33656002)(53546011)(86362001)(7696005)(66574015)(2906002)(83380400001)(71200400001)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1hlandRZjl1bEVEWUpOU1M3WDgvaFB4U0JlcWVsL0JNTHE3MGUzQktiUlYx?=
 =?utf-8?B?VXVvZ1VoSUxtTGEwTmhHMTYvTjk5VDBsUVZURjNqUkNKcFhRQnFBWjdSaDcw?=
 =?utf-8?B?dzF1UWs0cCs3MWNiZnlEQmRXR1M4RE8xNk90ZlZ0WHU3WTNlZldnaGtLcE1y?=
 =?utf-8?B?R1RlSEFOWUhSZEdNdHllN1EzaDByVmxMd0g1K3ZZQmdtRHdLWlJBWEQ4TCs4?=
 =?utf-8?B?MTNIN0w2ZDRhU0lBZDdOMndZakY5UTYyandmdVA1cUZUb3NmalJpWDVNbHJ1?=
 =?utf-8?B?WXI3UDNOdlhzWGlscUkydWgwZHlSQ0wxNmIzMmlHVmJtTk9BK0RrYjJ0ei93?=
 =?utf-8?B?QnRJaWM2cWQvU0l4V3ZUZDVhNytoczRLSGhWTmR6Mllmek92cjhoV2MvNE9D?=
 =?utf-8?B?eHhHV1BLMG1FT05MajVQNnJ6UlN1b3VBUCtvMHdXQldPYVVWTk9oQzBlVUZQ?=
 =?utf-8?B?RzNtUWdQbzN6VU1sa1l1TDlrK0pGN0FnNTllTFF6Wlp5NnRnZXFyQUo2U1lS?=
 =?utf-8?B?Q05sWld3TUQyMVdRcWJRODRQVEJVUHJOWGFHL0VkTGcvckhJNU1LVE4rL0JM?=
 =?utf-8?B?ckx2NEJjSk1qQlZnUy94SlIzY0hRUnNjZWhRcTJtYlNVdFRCNVltRFJlTzBl?=
 =?utf-8?B?eVdXYldUb2l4Z2k0bVdhN0IxQ1AwU3RJaFhuU2s5WlkybmVMTUNJS1JQRkRw?=
 =?utf-8?B?dzVha3d4WDdGU2M3dmJnS1NML3g1MzlFaUYyWWIrMTZyblB3REZ3Wm9qaVpG?=
 =?utf-8?B?Q29Vb1RSbGFPdC8xeUZSaW5zeWRTYjRmT0s2c1Brc1ZkRmc2S0NjU1lQZFd5?=
 =?utf-8?B?Zm9TNDl0RlN5aGJlL2puUmJaUTc4bWk4TkJiWUszSkFCY04xMUVGclk3a3gz?=
 =?utf-8?B?Y3J2Tkp5TEdGcWlsckFTNENxREJHMFpUSHZZMEZGYStwR3JxdVhFV1NWUVpm?=
 =?utf-8?B?bCtnN1JnVjA1RE5uU1BaWVZBTmlKT0VXblVzYWVkR2d1YTMrbmtXNE5wY0px?=
 =?utf-8?B?UlRtMzBPWlBBTTM1OGtnSHNnaEZ5cEJkZTF4SG9qVEsvd1hadnhNT1dxczlY?=
 =?utf-8?B?S2hmcXZyTVc4aURDSkY2bWp1UkZUUWY2RVpWMWo5dEhEWE1YUDFwSDdTYVQy?=
 =?utf-8?B?VGpJQ2RVSWNySUMyTVp6amdIWFZ2NTUwMW1wVUhnZVA1c0lKeWpnUHhTeG1W?=
 =?utf-8?B?YzV0SFFwdXVHakl5N0dBWUxkbk1sdVFjSExDUWFDT01XaTNiSThMZjE4ZnhQ?=
 =?utf-8?B?d0MwUDZBTjZubDVTdjRqWC8vYk1OcDBLYm9lSUtkdlk4OW4rZENWQVZVOHNy?=
 =?utf-8?B?ZnlEZmlBNXdJZ1RyRHd6ZGNXU0xSVVRYK0oyeTg5RjdlTW84dGk1QUNGTnc4?=
 =?utf-8?B?OEx2elRnRFhFaXRZR3FzNjdONm9FdDRkSVR6T29IR0VLUVlWY3ZNWVBKQUdC?=
 =?utf-8?B?dmFRVXRNcmdCWXJNbloyVHhJMVZma21xQ3dFaW40eHNNZjRKYjBxbytCZnYz?=
 =?utf-8?B?V2ViSmV3VlJYZGhtNGV3YldJS1ZVeWsyc0ZCbWdXbCtEdm13MzJlMmdSR2VM?=
 =?utf-8?B?WEdKMkNXWGErSGcvNlhSdnA1aHZaRk9KZEVDekZwMEpuWkk1dXFXQWxpeEd3?=
 =?utf-8?B?YlF2WVBBcTYrM1NMVS9mSVAxaGpEYWRlRnloY1dmS0s3alJPRDM0cjNrTmY5?=
 =?utf-8?B?OWpiYW9pOTdTTFJBUWU4VG40dkU5dDF5VnpiMWVnRVBsalRNMVZqaGg4aSs1?=
 =?utf-8?B?ZS9sWDBQclJhMWpmMkd3RS94WlBmVFVzcnU4Y0Y2VGNUd1ZwVjVXUi9td2pa?=
 =?utf-8?B?emY4YUM3RU9Sa1pmQ1pJY2xSckJQZWRxYnBnMGlHL0xrSUs0WXFEaTh2K1Zs?=
 =?utf-8?B?eEdvZGdVZHF5N25oWER5VkZNK1ZVeC9ORlNYNHNJZDhjN1ZkQ0pTNTJRRDNz?=
 =?utf-8?B?WGxmcitSRlR6elFBQVNSeXBmeGR1UFRzQUkvM3pDbWRtY0VpVDNYSHNoaE82?=
 =?utf-8?B?Q0JJcnJRT1BuaE50ZVAvU2JvWHBaZmZUOUkyVTNSbVBsS0FiRHdzalNJZXBT?=
 =?utf-8?B?Z1RFOGduSll4L2xRZGVHV20vcExlbTEyRXlSZ0pCbytFd01qVVFGOXp6YkNv?=
 =?utf-8?B?ZW9jNFBJeHo0dmtZNExnODQrdkVIYk1GT2puSGNHbHFPSkxLVzRnekJ5OU9S?=
 =?utf-8?Q?s1PHTiYiFKHM/MjGMJ8YVnkpe/ozZj84+HPRe/zwsreZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a20729a-e167-486b-be96-08db053d8537
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 16:49:58.8755 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u9dCOwzdSdSxZ0jfRoGTjGP3tsyPXBe+W2u8GQVRNBwH5XOwjsXCLtCJQzSkZMjQfImtP76qWm84ICaVScZrlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6642
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
Cc: =?utf-8?B?UmFmYWVsIMOBdmlsYSBkZSBFc3DDrW5kb2xh?= <rafael@espindo.la>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29t
Pg0KPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDEsIDIwMjMgMjE6NDkNCj4gVG86IExpbW9u
Y2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBSYWZhZWwgw4F2aWxhIGRlIEVzcMOtbmRvbGENCj4gPHJh
ZmFlbEBlc3BpbmRvLmxhPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kOiBBbGxvdyBz
MGl4IHdpdGhvdXQgQklPUyBzdXBwb3J0DQo+IA0KPiBPbiBXZWQsIEphbiAyNSwgMjAyMyBhdCAx
OjMzIFBNIE1hcmlvIExpbW9uY2llbGxvDQo+IDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPiB3
cm90ZToNCj4gPg0KPiA+IFdlIGd1YXJkIHRoZSBzdXNwZW5kIGVudHJ5IGNvZGUgZnJvbSBydW5u
aW5nIHVubGVzcyB3ZSBoYXZlIHByb3Blcg0KPiA+IEJJT1Mgc3VwcG9ydCBmb3IgZWl0aGVyIFMz
IG1vZGUgb3IgczBpeCBtb2RlLg0KPiA+DQo+ID4gSWYgYSB1c2VyJ3Mgc3lzdGVtIGRvZXNuJ3Qg
c3VwcG9ydCBlaXRoZXIgb2YgdGhlc2UgbW9kZXMgdGhlIGtlcm5lbA0KPiA+IHN0aWxsIGRvZXMg
b2ZmZXIgczJpZGxlIGluIGAvc3lzL3Bvd2VyL21lbV9zbGVlcGAgc28gdGhlcmUgaXMgYW4NCj4g
PiBleHBlY3RhdGlvbiBmcm9tIHVzZXJzIHRoYXQgaXQgd29ya3MgZXZlbiBpZiB0aGUgcG93ZXIg
Y29uc3VtcHRpb24NCj4gPiByZW1haW5zIHZlcnkgaGlnaC4NCj4gPg0KPiA+IFJhZmFlbCDDgXZp
bGEgZGUgRXNww61uZG9sYSByZXBvcnRzIHRoYXQgYSBzeXN0ZW0gb2YgaGlzIGhhcyBhDQo+ID4g
bm9uLWZ1bmN0aW9uYWwgZ3JhcGhpY3Mgc3RhY2sgYWZ0ZXIgcmVzdW1pbmcuICBUaGF0IHN5c3Rl
bSBkb2Vzbid0DQo+ID4gc3VwcG9ydCBTMyBhbmQgdGhlIEZBRFQgZG9lc24ndCBpbmRpY2F0ZSBz
dXBwb3J0IGZvciBsb3cgcG93ZXIgaWRsZS4NCj4gPg0KPiA+IFRocm91Z2ggc29tZSBleHBlcmlt
ZW50YXRpb24gaXQgd2FzIGNvbmNsdWRlZCB0aGF0IGV2ZW4gd2l0aG91dCB0aGUNCj4gPiBoYXJk
d2FyZSBzMGkzIHN1cHBvcnQgcHJvdmlkZWQgYnkgdGhlIGFtZF9wbWMgZHJpdmVyIHRoZSBwb3dl
cg0KPiA+IGNvbnN1bXB0aW9uIG92ZXIgc3VzcGVuZCBpcyBkZWNyZWFzZWQgYnkgcnVubmluZyBh
bWRncHUncyBzMGl4DQo+ID4gc3VzcGVuZCByb3V0aW5lLg0KPiA+DQo+ID4gVGhlIG51bWJlcnMg
b3ZlciBzdXNwZW5kIHNob3dlZDoNCj4gPiAqIE5vIHBhdGNoOiA5LjJXDQo+ID4gKiBTa2lwIGFt
ZGdwdSBzdXNwZW5kIGVudGlyZWx5OiAxMC41Vw0KPiA+ICogUnVuIGFtZGdwdSBzMGl4IHJvdXRp
bmU6IDcuN1cNCj4gPg0KPiA+IEFzIHRoaXMgZG9lcyBpbXByb3ZlIHRoZSBwb3dlciwgcmVtb3Zl
IHNvbWUgb2YgdGhlIGd1YXJkIHJhaWxzIGluDQo+ID4gYGFtZGdwdV9hY3BpLmNgIGZvciBvbmx5
IHJ1bm5pbmcgczBpeCBzdXNwZW5kIHJvdXRpbmVzIGluIHRoZSByaWdodA0KPiA+IGNpcmN1bXN0
YW5jZXMuDQo+ID4NCj4gPiBIb3dldmVyIGlmIHRoaXMgdHVybnMgb3V0IHRvIGNhdXNlIHJlZ3Jl
c3Npb25zIGZvciBhbnlvbmUsIHdlIHNob3VsZA0KPiA+IHJldmVydCB0aGlzIGNoYW5nZSBhbmQg
aW5zdGVhZCBvcHQgZm9yIHNraXBwaW5nIHN1c3BlbmQvcmVzdW1lIHJvdXRpbmVzDQo+ID4gZW50
aXJlbHkgb3IgdHJ5IHRvIGZpeCB0aGUgdW5kZXJseWluZyBiZWhhdmlvciB0aGF0IG1ha2VzIGdy
YXBoaWNzIGZhaWwNCj4gPiBhZnRlciByZXN1bWUgd2l0aG91dCB1bmRlcmx5aW5nIHBsYXRmb3Jt
IHN1cHBvcnQuDQo+ID4NCj4gPiBSZXBvcnRlZC1ieTogUmFmYWVsIMOBdmlsYSBkZSBFc3DDrW5k
b2xhIDxyYWZhZWxAZXNwaW5kby5sYT4NCj4gPiBMaW5rOiBodHRwczovL2dpdGxhYi5mcmVlZGVz
a3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vlcy8yMzY0DQo+ID4gU2lnbmVkLW9mZi1ieTogTWFyaW8g
TGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hY3BpLmMgfCA4ICsrLS0tLS0tDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FjcGkuYw0K
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hY3BpLmMNCj4gPiBpbmRleCA1
N2I1ZTExNDQ2YzY1Li5mYTczNzViOTdmZDQ3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hY3BpLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfYWNwaS5jDQo+ID4gQEAgLTEwNzksMjAgKzEwNzksMTYgQEAgYm9v
bCBhbWRncHVfYWNwaV9pc19zMGl4X2FjdGl2ZShzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRl
dikNCj4gPiAgICAgICAgICAqIFMwaXggZXZlbiB0aG91Z2ggdGhlIHN5c3RlbSBpcyBzdXNwZW5k
aW5nIHRvIGlkbGUsIHNvIHJldHVybiBmYWxzZQ0KPiA+ICAgICAgICAgICogaW4gdGhhdCBjYXNl
Lg0KPiA+ICAgICAgICAgICovDQo+ID4gLSAgICAgICBpZiAoIShhY3BpX2dibF9GQURULmZsYWdz
ICYgQUNQSV9GQURUX0xPV19QT1dFUl9TMCkpIHsNCj4gPiArICAgICAgIGlmICghKGFjcGlfZ2Js
X0ZBRFQuZmxhZ3MgJiBBQ1BJX0ZBRFRfTE9XX1BPV0VSX1MwKSkNCj4gPiAgICAgICAgICAgICAg
ICAgZGV2X3dhcm5fb25jZShhZGV2LT5kZXYsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIlBvd2VyIGNvbnN1bXB0aW9uIHdpbGwgYmUgaGlnaGVyIGFzIEJJT1MgaGFzIG5vdCBi
ZWVuDQo+IGNvbmZpZ3VyZWQgZm9yIHN1c3BlbmQtdG8taWRsZS5cbiINCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAiVG8gdXNlIHN1c3BlbmQtdG8taWRsZSBjaGFuZ2UgdGhlIHNs
ZWVwIG1vZGUgaW4gQklPUw0KPiBzZXR1cC5cbiIpOw0KPiA+IC0gICAgICAgICAgICAgICByZXR1
cm4gZmFsc2U7DQo+IA0KPiBUaGlua2luZyBhYm91dCB0aGlzIG1vcmUsIEkgdGhpbmsgd2UgbWF5
IG5lZWQgdG8gY2hlY2sgdGhlIGFzaWMgdHlwZQ0KPiBoZXJlLiAgUHJlLVJhdmVuIEFQVXMgZGlk
bid0IHN1cHBvcnQgUzBpeCBhdCBhbGwgc28gdGhpcyBtYXkgYnJlYWsNCj4gdGhlbSBpZiB0aGV5
IGhhdmUgYW55IGNoZWNrcyB0aGF0IHVzZSBhbWRncHVfYWNwaV9pc19zMGl4X2FjdGl2ZSgpIGlu
DQo+IHRoZWlyIGNvZGUgcGF0aHMuDQoNCkZvciB0aGVtIHdoYXQgc2hvdWxkIHdlIGJlIGRvaW5n
IHdoZW4gdGhleSB0cnkgdG8gZG8gczJpZGxlIHRob3VnaD8NClMzIHBhdGg/ICBPciBub3RoaW5n
Pw0KDQo+IA0KPiBBbGV4DQo+IA0KPiANCj4gPiAtICAgICAgIH0NCj4gPg0KPiA+ICAjaWYgIUlT
X0VOQUJMRUQoQ09ORklHX0FNRF9QTUMpDQo+ID4gICAgICAgICBkZXZfd2Fybl9vbmNlKGFkZXYt
PmRldiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgIlBvd2VyIGNvbnN1bXB0aW9uIHdpbGwg
YmUgaGlnaGVyIGFzIHRoZSBrZXJuZWwgaGFzIG5vdCBiZWVuDQo+IGNvbXBpbGVkIHdpdGggQ09O
RklHX0FNRF9QTUMuXG4iKTsNCj4gPiAtICAgICAgIHJldHVybiBmYWxzZTsNCj4gPiAtI2Vsc2UN
Cj4gPiAtICAgICAgIHJldHVybiB0cnVlOw0KPiA+ICAjZW5kaWYgLyogQ09ORklHX0FNRF9QTUMg
Ki8NCj4gPiArICAgICAgIHJldHVybiB0cnVlOw0KPiA+ICB9DQo+ID4NCj4gPiAgI2VuZGlmIC8q
IENPTkZJR19TVVNQRU5EICovDQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gPg0K
