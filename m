Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17FB0C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 17:34:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B84D710ED64;
	Wed,  1 Jun 2022 17:34:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA95F10ED64
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 17:34:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A63840IJq9Z1pPhM1R634RINb/r6OovzaVKwO55dXKw25QWRTy5bpmdK/FAAJEf952T9hDHIOP/TIN2f9ZEb/bj6TMZ8X4EM3tuM2guCetEvzHSy7HNL/ePZPJTFih592GnAJ8gzlltlfxFl9rcuaqJy90ajMMoOsY/x93c9OUME5GfL8hprCkPvFqxR7Lymy1Kq39wrN+x16Z+Xb6QDujmj6vMNAmWB4F3nqEFE4O6nQIu1f3tjziqaQAH9R7VvCUC5CVohTkj3knT47fSg0fujWPIJYu4zyE0YsWPT4v0LPQfZUgiaL/wsJEN4meWs+MZNP+F2S1hRLerUVJWJbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NujIR2LVl7g1A5To50zmPFFlclYSv4yjhXTBjk5mbY=;
 b=IK3zeXR+uKhGVtA8aEUS3R3/1Waa3r8UBasTwGe7vVQmGsqDsvP45wXlUxQo6DmGYL25IsReGcTHGCO946MjLRE5y+HOLSz4+vh4/y+28BwcpY/KUp8P9ULTemERS4QYYt454gBSES04FXnD84SZ3GDS4A2uKHZKak5KdFOqbKLgyCgZoax3oPn90GrLygrPiGkREYOuVKirpfJt4b4q/nVVllKXAG91uNUdWlcfLJz42ed9MycYUBhCXDG8xwb9gofwSUVZmSh+N2GnBHnkXUw8KzKg+nv+VWafjUUsL4/hA9NxPUG7WAviKdVby+EcSj6OHzMAEmGqFZDX3FP/zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NujIR2LVl7g1A5To50zmPFFlclYSv4yjhXTBjk5mbY=;
 b=cUFvQoHiY9+HVnKiw8yvOtx+u+rIlQfUKeJ0dpvQQ2v3k3m/CwERU6QHn8asgj9/N/fXxS7CnRV7DKKN9yH9688B4Ty1m8LPc5fnQw4KFSLF0POl6L3DT4JP5h97+izFxSVovJcKx3fnS1WxNmAJfwvu2R6RB36kviiUUtbslqA=
Received: from CY4PR12MB1496.namprd12.prod.outlook.com (2603:10b6:910:10::8)
 by BY5PR12MB4257.namprd12.prod.outlook.com (2603:10b6:a03:20f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 17:34:16 +0000
Received: from CY4PR12MB1496.namprd12.prod.outlook.com
 ([fe80::b802:f477:9024:61a2]) by CY4PR12MB1496.namprd12.prod.outlook.com
 ([fe80::b802:f477:9024:61a2%9]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 17:34:16 +0000
From: "Li, Candice" <Candice.Li@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: Resolve RAS GFX error count issue v2
Thread-Topic: [PATCH] drm/amdgpu: Resolve RAS GFX error count issue v2
Thread-Index: AQHYddp/5O/FRCX1XUSVRPPNtm3Xxq06y7GAgAABunA=
Date: Wed, 1 Jun 2022 17:34:15 +0000
Message-ID: <CY4PR12MB1496B50F75CCA5863716129F91DF9@CY4PR12MB1496.namprd12.prod.outlook.com>
References: <20220601171005.27106-1-candice.li@amd.com>
 <CADnq5_O5kGgiK2tRKNLE7YGB-OAGjt9ud4A=13JkVO2_kLObaA@mail.gmail.com>
In-Reply-To: <CADnq5_O5kGgiK2tRKNLE7YGB-OAGjt9ud4A=13JkVO2_kLObaA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-06-01T17:26:49Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=4b865ce8-7ab0-4993-a935-fcc25811696d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-06-01T17:34:13Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: f104fab8-b523-44dd-986d-8260da38366e
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34dda348-e8ba-405a-f55e-08da43f4f34a
x-ms-traffictypediagnostic: BY5PR12MB4257:EE_
x-microsoft-antispam-prvs: <BY5PR12MB425768877AC8D16B4FE42DDB91DF9@BY5PR12MB4257.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ppx66RttHILWdciXS7cokCOOVwe5GzX5LNOpqTyULfsQ3nwIY/I7wSVpKp1i/TUyZkmrAK89mS1xbWSh/1C4ZYl3wnWxcSk9kPbRrTmFwVYzbAi4QVewmLq/LZBygp5FRpS24bQG/KHKBC4P6gsMugdP86QVt33PiqQhQWm3wG6jFHOpAxAGghD0AxTr9tu4l0S3wiT20FM5vdRK+TPi+a4AOWigIuMRQVGqmGhX8TtdosrtsQbtcCtyMCZuuqPMeTxkNR2TOw/8YtNuBuVGqQlKUy11nnyvywkpsvYHOlYRI1lfRq2KsLf1NaObW5A6oIxcjqIJIbNndH/flSp9kRDTHZmKgXGMTTPRnKJ2goFsBmbrHEDBbfwSdQ04D2xEPFtUP7UDhEMPNuNF2TfVeyEs49CI7+0EC2OeObwb8IAhZZktTdQH+V2hCtFC/P/Dx6T1mrPM8xtzFqX80z5zCNyDZrPsQJFfN4lt64NiHB3E08cOOxoKJE5MoHEa4lCmtXI0La1PPpQW7ef0o6L/5ybwg6Fpkv2QNFcX3H/t5MafknwKA7FI6yCt8qvhKr0fCbf3F+NhHJI2h15s5yXlb2qjeGm8M3xDJwR/1x9dlNPB+mgr7yT7ciNqwdK/lPpnWqOiQGVEQSkwKOCB34ZqFo3oFO3AcSKfhzms3S+J1aoXzhVhDm3/e0W3n3E/iXhkwmXd7H2+/Q3DDTeNrg/E9Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1496.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(52536014)(9686003)(7696005)(8936002)(53546011)(6506007)(38070700005)(4326008)(66556008)(66476007)(316002)(122000001)(64756008)(76116006)(66446008)(8676002)(66946007)(71200400001)(5660300002)(6916009)(508600001)(38100700002)(33656002)(2906002)(86362001)(55016003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmZFaVVEbUZldEtldVg1K2Z0clVKb3UxZ0trMmZSYUVDcFZNMmdzaHBOTVV3?=
 =?utf-8?B?Z2ZWZVBSbkVUblRlS05nM1pGdDVnRE9YMTIxTVBjSG9CZVhFTStTdFE5cnBZ?=
 =?utf-8?B?MDB6b1huckVXc3UzQjV4VkdLWXhzVVd6Z29XemFSaFZvcGFGL0h2OEloQ2lJ?=
 =?utf-8?B?R1g0VTMxWEZpZ0x3VHpTNHExcmp0bE93MUFidmg0amNzNklkbVZOcDNOajJY?=
 =?utf-8?B?YWZTaFNQQ0hWb0s5VS80UE10KzdRVVlqdnkrUGlxeENhNHpSU0JGeWtWMzFn?=
 =?utf-8?B?ZWFQdkVua0lKYVY4b2lvMUR4WFJldk1DOVh5Uk1xb0ZnQWs4dmlrbnM5WE93?=
 =?utf-8?B?d3V4RkdadHNjall6WE9QTlh4NjM1UVY1SDBMVjkzdEhITUU5MmhuZDdITlJQ?=
 =?utf-8?B?a2xTU21iZUhjelpUdmNsRWh5SzZ3YjBxODdlK1NyMlNEWkhUYVNWa3R4aTht?=
 =?utf-8?B?Mm1tcnBYaFlGTlhlSzlmU0FXUzdMd0NBWEVvc1JSUGllcU1yUW1sRHBETUtr?=
 =?utf-8?B?WGxZVXY0ektxRVQ3UnZrU2dyWkJnaTdjMVl0bVBBalQ0WlFJd1ZsSkJiMVdF?=
 =?utf-8?B?dHlBZVdFZHFLN1QreC9lSU5Lb0ovUTczUUVFenpCcHlBelR2MG8yZkl3UUty?=
 =?utf-8?B?bWxXWWpod2IwVW8vMXpIeVV5ZXlLRmluaUVPMEJPNW0rckdqeGY3MG1Ycm93?=
 =?utf-8?B?U3FtMnFWUFJYYlNuU0VQUU5zK28rb1dmTnFnU1ZRWWVHaUM1dzlUSm5VME9y?=
 =?utf-8?B?MnViZm1KdW5kMXJZbW1NWmlqUkFrYUJPOEZ6N25KM1JjU3dGQkwwSGoremg1?=
 =?utf-8?B?WHBGRU5TMkZINDhCSDFHYzJUOTM1bjJKblJ4SFIyS1RjK1h5LzhNd3FPOGRW?=
 =?utf-8?B?cDNqY1g3QWtrRkJPVnJlM2E2OVprNE9RZmMvRHpZc0JYekJTdHVVcVJFZVhO?=
 =?utf-8?B?N2JnNkUwblZwcTh2TXhYdEEvRXljWGdIaXlJS096NHBRNXF0MGlsRWUwWGxI?=
 =?utf-8?B?NDlLa1NDVWNxRTlzNnVTSUVTdlFsQlVUSkd6Zk5lWEhuTXBHamdqWEJkaith?=
 =?utf-8?B?V2ZVRnh5d2hWSkFTRG9ObFVvdTcwQ0RuMWdQZFhjalIyR1pHQzZyMm9Id2M0?=
 =?utf-8?B?UW93cDc1eGJmQnphSWd2SFVlcmZOMkxqV2xGK3VZNU9RTG5jcWpyNEM2bzN6?=
 =?utf-8?B?aGJUUnNRa1VWSUZxQ0xIRXNmeklsRDNxWHhkMkx3enAxVDYzeDlHMkVZZUNh?=
 =?utf-8?B?QnZ2MkZiQ3FnQzVINlNJbHNzNzZiYWNiTDN5dyt2dUJOWWR4Y1ZsOFlYNkd4?=
 =?utf-8?B?OXBCWXNMU25ZZDN0R2JVMy8vL01ocC9JUkJDYXA2T2FTU0tDYXM0WFRDOVhV?=
 =?utf-8?B?NmRXdVpSMXNCN1U0UzRoaE4vTDFyc2N2M2o4VzNGQmg2Z3IxYU41d1ZzSU1I?=
 =?utf-8?B?WW1mNFo5V2wySm9udWlJNUgzNk5YRW1XaU9qNVdlcExjdkhJSFlEc0RwWjho?=
 =?utf-8?B?UG1kbzdtRmVDK1AzeUR5WmVuR2lPNFY2THFQZVI4MjhEVis0ZVhDQkU2OGJy?=
 =?utf-8?B?ZnBsSGtuQWpPQUpoTHhtZ2xDM3dSZGM4OWg4UWEwRGkybEgzQWgrRStaNHlB?=
 =?utf-8?B?eC9IRDZkTzJJTjk3UmFLSjgxNm9iZFJuYWdoOE42bC9ob3k5dG5tMzVUTU5R?=
 =?utf-8?B?UzFLTUd4aHM1WVdobFNXdWVjQlE0NVBLV2FBRFc1ZG1jNUJWaHpSYkNUREVY?=
 =?utf-8?B?UXFhL3NGREVqMm4rWlRNbzFtRzEzTnR3WTJEMXNnUjVSWG0wZ1RGTzRvZkZT?=
 =?utf-8?B?bjF1TnR5aUxGYktucUNuQThXUHJPTWZ3L3JlT0I5RmlpektYRkNlUHM1emdw?=
 =?utf-8?B?TEdOZnZSRjF5dmJQQytiQ0tLZUpPaEw1dUEzK2pUMm53VnQvVEVQR2htSUdE?=
 =?utf-8?B?NWhkSHV2N3dBekw3TDBQZEFFd2hRMU5oUDh4emZJNlZoTEhTcFdzOWNUYktr?=
 =?utf-8?B?ay94N1RRU1E2NWc5czgxczFJMThnMDVEVi9iWkZRYVh5Rm4yYWRMSGo1TXJ3?=
 =?utf-8?B?eW02YzcwR004QlZZeHFYV3ZLV0Z6TlJVVGNoOFRTbTgzRk1KZUlmbHh6em9q?=
 =?utf-8?B?NTlkUUpGM3NidE5Rb2VZSHUvMk5Xbm1idlBySHk4d05KWVU3OENLM1kvTCtN?=
 =?utf-8?B?VWdMMkxUalUreHUyQTY0U2QrNVlTR0hpdjBlYjNLOEh3NHZjaFBCenMyVTdM?=
 =?utf-8?B?d1BuenVsS2hlbE1mV3Q2ellkUS9KcTdaS0lWN1Ivc0NZZWFEWmNNRlVFd29j?=
 =?utf-8?B?SSsxSnVYMC9aNUdyR1JGU3h2TE4rTy9qY2F0TE1oa1JWcEVlQnVuZzQzMmYz?=
 =?utf-8?Q?FLJhENBteKNZlD+6ee17sAza0Q9WzyY5QhW/V?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1496.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34dda348-e8ba-405a-f55e-08da43f4f34a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 17:34:15.8734 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GzVQKWa9y9HEtad+qr2yb/QUJsWJvnEaXwTZ1np2QURHdQoryYTTLJwJd8AvBLOX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4257
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3LiANClRvIGZpeCB0aGUgaW5kZW50YXRp
b24gd2lsbCByZXF1aXJlIHRoZSBlbHNlIGNhc2UgdG8gbGV0IGFtZGdwdV9yYXNfYmxvY2tfbGF0
ZV9pbml0IGNhbiBnbyB0byByYXMgdW5zdXBwb3J0ZWQgY29kZSBwYXRoLg0KVGhhdCdzIHdoeSBJ
IHdhbnQgdG8ga2VlcCB0aGVtIGluIG9uZSBwYXRjaC4NCkkgd2lsbCB1cGRhdGUgdGhlIGNvbW1p
dCBtZXNzYWdlIGFuZCBjb2Rpbmcgc3R5bGUgYXMgeW91IHN1Z2dlc3RlZC4NCg0KDQoNClRoYW5r
cywNCkNhbmRpY2UNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFsZXggRGV1
Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPiANClNlbnQ6IFRodXJzZGF5LCBKdW5lIDIsIDIw
MjIgMToxOSBBTQ0KVG86IExpLCBDYW5kaWNlIDxDYW5kaWNlLkxpQGFtZC5jb20+DQpDYzogYW1k
LWdmeCBsaXN0IDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4NClN1YmplY3Q6IFJlOiBb
UEFUQ0hdIGRybS9hbWRncHU6IFJlc29sdmUgUkFTIEdGWCBlcnJvciBjb3VudCBpc3N1ZSB2Mg0K
DQpPbiBXZWQsIEp1biAxLCAyMDIyIGF0IDE6MTAgUE0gQ2FuZGljZSBMaSA8Y2FuZGljZS5saUBh
bWQuY29tPiB3cm90ZToNCj4NCj4gRml4IG1pc2xlYWRpbmcgaW5kZW50YXRpb24NCj4NCg0KTWln
aHQgd2FudCB0byBzcGxpdCB0aGlzIGludG8gdHdvIHBhdGNoZXMsIG9uZSB0byBmaXggdGhlIGlu
ZGVudGF0aW9uDQphbmQgb25lIHRvIGZpeCB0aGUgbWlzc2luZyBmdW5jdGlvbiBjYWxsLiAgQWxz
byB5b3Ugc2hvdWxkIG1lbnRpb24gdGhlDQptaXNzaW5nIGZ1bmN0aW9uIGNhbGwgaW4gdGhlIGVs
c2UgY2FzZS4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBDYW5kaWNlIExpIDxjYW5kaWNlLmxpQGFtZC5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jIHwg
OSArKysrKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZ2Z4LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMNCj4gaW5k
ZXggOTljMWEyZDNkYWU4NGQuLjQyNDk5MGUxYmVjMTBjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jDQo+IEBAIC01OTksMTQgKzU5OSwxNSBAQCBpbnQgYW1k
Z3B1X2dmeF9yYXNfbGF0ZV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3Qg
cmFzX2NvbW1vbl9pZiAqcg0KPiAgICAgICAgICAgICAgICAgaWYgKCFhbWRncHVfcGVyc2lzdGVu
dF9lZGNfaGFydmVzdGluZ19zdXBwb3J0ZWQoYWRldikpDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIGFtZGdwdV9yYXNfcmVzZXRfZXJyb3Jfc3RhdHVzKGFkZXYsIEFNREdQVV9SQVNfQkxPQ0tf
X0dGWCk7DQo+DQo+IC0gICAgICAgciA9IGFtZGdwdV9yYXNfYmxvY2tfbGF0ZV9pbml0KGFkZXYs
IHJhc19ibG9jayk7DQo+IC0gICAgICAgaWYgKHIpDQo+IC0gICAgICAgICAgICAgICByZXR1cm4g
cjsNCj4gKyAgICAgICAgICAgICAgIHIgPSBhbWRncHVfcmFzX2Jsb2NrX2xhdGVfaW5pdChhZGV2
LCByYXNfYmxvY2spOw0KPiArICAgICAgICAgICAgICAgaWYgKHIpDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIHJldHVybiByOw0KPg0KPiAgICAgICAgICAgICAgICAgciA9IGFtZGdwdV9pcnFf
Z2V0KGFkZXYsICZhZGV2LT5nZnguY3BfZWNjX2Vycm9yX2lycSwgMCk7DQo+ICAgICAgICAgICAg
ICAgICBpZiAocikNCj4gICAgICAgICAgICAgICAgICAgICAgICAgZ290byBsYXRlX2Zpbmk7DQo+
IC0gICAgICAgfQ0KPiArICAgICAgIH0gZWxzZQ0KPiArICAgICAgICAgICAgICAgYW1kZ3B1X3Jh
c19mZWF0dXJlX2VuYWJsZV9vbl9ib290KGFkZXYsIHJhc19ibG9jaywgMCk7DQoNCkNvZGluZyBz
dHlsZS4gIFRoZSBlbHNlIGNhc2UgbmVlZHMgeyB9IGFzIHdlbGwgdG8gbWF0Y2gga2VybmVsIGNv
ZGluZw0Kc3R5bGUgZ3VpZGVsaW5lcy4NCg0KQWxleA0KDQoNCj4NCj4gICAgICAgICByZXR1cm4g
MDsNCj4gIGxhdGVfZmluaToNCj4gLS0NCj4gMi4xNy4xDQo+DQo=
