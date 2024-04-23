Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409C3C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 03:13:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CEB910EEBD;
	Tue, 23 Apr 2024 03:13:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1qmot54u";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3EF210EEBD
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 03:13:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzQagWT2E8Zi5OQ6CyxU+ZnZzD5WR87cA7KIIVGx4qa2VqbN1UQCHfVPdl0wO25vl6FtF8SNfbTAdFm2yFhpiW1nZlvksMw9UY+Z+sJzABSpm2SZ3wFZr/umYPo54YALKeJr3CU5nG6EdopnQumvy6h8R1BxaGKOJ6Za63EGQH8KumcCq/tHwKDPFMaeT9ZoVuHjy8jiveYDM/vj3QXvGwVHkN20oexDMGydN9rCnNVAwhEo5/nEOJRZ2hMSuOhqVHjPe/BIOSu8F5P41octjAYk5AFWoGrLj4Nsv+JSWI3755lxIi+y3NzUn5lHuoyp4iZNf8Jb4xN+GUFCgxlZDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMo85Hj03s0RdYQLA8/8b6WbAZKWvEBLo7ofbtqyZUw=;
 b=LPtKQmy4F85n1CWxEwH9msbxlL0d72mX5FmKzMpyQrTALRG061Qegp+uB/9Lde2rLliIF5W1fwJABNmcYuYkNJU3VCa13P0nLPk61K7R/qydeKaqBgroDLQeZK5PEJEMGwBmu2eLSwLFnjON4Kq/vBt1uvYbvMtASXFDxiWoVAgVMBGIb7ToHA7VDFbDzbDMSVogJu5Ed8U0ExY/92Xj05QRom9O1PKvcNWbtnbrtVLqiMhFSsbduMrt2jyS6oXkFzPJyj9ME6PXDXGYgheNlN7wwlnHMFzvCa3L3tRXaAjjRobfTqmQhJ++qV8nE2e0O3H1l3cYI4xvlc+Ndf4MyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMo85Hj03s0RdYQLA8/8b6WbAZKWvEBLo7ofbtqyZUw=;
 b=1qmot54uSWuRJslY7Huj5tvop+iNWkE5+XBBOkmUHF+kOQ61blTfTvpRZGCUzqlUTZSZwuXEYzYnT7BTkoN9jp2xGlG0f6JTz3CWsBzG4/UYH3f5ycZeMe5DspXm6wW6KYuQz75aWSYaMSX6h15bZVFkLWt3Nx44UbZSFJ/lli0=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by IA0PR12MB8087.namprd12.prod.outlook.com (2603:10b6:208:401::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 03:13:26 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 03:13:26 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix two reset triggered in a row
Thread-Topic: [PATCH] drm/amdgpu: Fix two reset triggered in a row
Thread-Index: AQHalO23YeZJ9BFN8k+8ihSpKZPttrF1LH0AgAAA1lA=
Date: Tue, 23 Apr 2024 03:13:26 +0000
Message-ID: <SA1PR12MB8599D7D541AFC7840BC7B090ED112@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <20240422194550.26148-1-Yunxiang.Li@amd.com>
 <f9eb9cc2-4e95-4bf9-b2db-a459eca10686@amd.com>
In-Reply-To: <f9eb9cc2-4e95-4bf9-b2db-a459eca10686@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=302ad1aa-4a10-4476-909b-fae8c4562dd8;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-23T03:09:21Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|IA0PR12MB8087:EE_
x-ms-office365-filtering-correlation-id: b3833d31-8210-4913-d757-08dc63435782
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?cTkxNzg0cVJ0T1pJeE9udWNlRjJEazU4RlI5Y2dwYUxrVmhVR2syeTl3dk9R?=
 =?utf-8?B?M05DbDkyYXZYUTl2N3cweDVrRHRmQkdDQkRDUzBQRUZmL1NFMTh1SjVITWFa?=
 =?utf-8?B?YXkyS2RIVHUrTHVudXQ0Y3djR1laTGUrY05wZ251QzN2QnBjUzh3SUhaelQ0?=
 =?utf-8?B?OVQwYytnSnYvUEU1eHExSGV4ZURHeUhLdnp1QTlxZTkwUjhyQWFrcTI5ZnRR?=
 =?utf-8?B?Qm1oT3FHT3gycXBKNmw5b1ZkOFFvTnR3bkVvSE9VaE9XUFViR3dyR3Z0WG4z?=
 =?utf-8?B?SE4wa08yNUVEdHRBOE1kVWFHK1V6NDZocDNSb0NpSGhralk4QWJ6RnkxUjJF?=
 =?utf-8?B?anVyNFhuNURZNFRHTElOTW8yTnR5VWszdW9iUElMNU5ubkFxQnBqL0s3QTJi?=
 =?utf-8?B?cDZqbCtENXZINlRDa2o0K1hjd0tOTmJocTRyWE1TRXNxdVNwUEU4bElLR0RD?=
 =?utf-8?B?dlgvUU84THNWQmIvVjZhakEzRkkxQnVhZ2R0aDNxazd6bXFKMWZnNWVKSkZG?=
 =?utf-8?B?OUVFaElpMzd0QXo4OGxKVnRBaGpEYmVKak1xRXJaWEZCM05iQ0pwNlRpVHNn?=
 =?utf-8?B?SllDUHIxV00vQUt3TVNXVjFReUI0WWozaXpPNUszM3Rwa0RISkRiRmdLNFFu?=
 =?utf-8?B?bEVZaXI0d3pzR0dYOVRYK1BuZEdxZEVTQ1BVT2N5YzRvMFVPdkN5OFhpaUtm?=
 =?utf-8?B?MTBZTWdnQW9GQW1HZUIzTjVjenlQNndScUNnUWpra21pbWtTRHRDblpVQmRn?=
 =?utf-8?B?Mmc5UU5WcGNRUkNDM09JaXkwOW83dlp1R0JKYnVEM3BVUWlsWU02RUNPU2pa?=
 =?utf-8?B?SEp0TmFrcDk2QUtIdERHUTRxdDV2QitSdjZ3R01TeStnTVhZejhVZkZVUlhK?=
 =?utf-8?B?dlFmbXZCUE9RVmdxQ1N2aDd3bFdOTXVqZU50N3EyMUtucllPcWRxYS9pRHBL?=
 =?utf-8?B?WHJTSnFQU2U5ZU5OUU04SWc3bUYxVkhCOHFkTWgwcXNTYTQxN0VTRmxMQUx3?=
 =?utf-8?B?RmhUOTZCdEN5V2dMWFU0a2ROVHl5R0FnMXFabzhGa25tWXdJL2lMZTQ5ajds?=
 =?utf-8?B?bC9RTnUyc3FPTlVXT2oyK3VnZjZFY3orU3d0RUFMeHZORW5McDNlSC85bXlM?=
 =?utf-8?B?QkxzajFsMlQxbFZVK0tuMUlXdzRaU0o5M3FYc2ZxQ3Jvd1NXSG1YNjJIYmxu?=
 =?utf-8?B?S2EwWGtzT3l1QTJIbW1XNno4Z0NBU2dld0w0Rkw1NDY4SE8xWHRpL2NPT2Ex?=
 =?utf-8?B?VDA5RldzVGhxbkl1M1J5SndSWlEvUWFJVWJSc3JXUWV1Uk9WblNRUUZVbTgv?=
 =?utf-8?B?cC85dG9DSUE3ZXA0a0pZMWk0RjB0NWRHc1JXRnZMNWRlOFFiTUQ1QjdYLzBn?=
 =?utf-8?B?KzlKd1d0dUxNdlEzcnBnbDJtY1QzRlRlYy9DdkUvWXdQZ0loamxQQXNaaWZk?=
 =?utf-8?B?VHdBejhkMStNdGJpcjM5bG95NGt6Tmg1amk4aElzWXloSUZqRXBWekxBU0Z4?=
 =?utf-8?B?UUxaTmpGOVN1ZTVVUDhBTi9lc0J4a2JORytHeExrRmdvRHBvTUNWK3U5eElK?=
 =?utf-8?B?dHcyTGltVFVXeWd3Vy9BY0F4OEFib1ByV1prbUJuMU56ajJMWUtPaUd6ZzZS?=
 =?utf-8?B?RFNqdStidUYzaEt4N3AyM2VoK3k2endnMnFVSFRYUlQvb2xBNEJTRVNzSU4v?=
 =?utf-8?B?Y3RINzArRVVMRnpoV0l1eUZJdUpmcVhqcE9ONktrc2FhVm90TlRyZnJKcWR0?=
 =?utf-8?B?UkhGdEVRMDFJMHpDR20xQlZ5T1F4YUJxMzAyVnZIZzFkcFd1b0RzbFE4c0pR?=
 =?utf-8?B?ZkFaMFNSbXRpTEV1WVUyZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clFPM0lTeGJndjNDeTRqM2xkUk5ablMxTXdSeXFjU3VTQ2xXV2lHb0FMU2hO?=
 =?utf-8?B?endMTDFnQ2hvYjl4S0FKaHEyU2F3UEFubmR1UVhFcGpoYTQ3d0R3WmJsNnBQ?=
 =?utf-8?B?K2p2Z0lzR3UxTExOanRNQndpTEtHRVM1a0dMM1VEQm01Nkp3R2p5bFNCYnBY?=
 =?utf-8?B?ZnNwVEtXcXRlQi9CcHAzSmhDVEhvK0FLUWRlR3BHSW5xYk9sdDVxZ3huem9C?=
 =?utf-8?B?OTZYK0NGcmxZRXM5RzhGOS92OG9MV3pDRUNMSWJDQ0xTbnFsanhFQmo4c0M4?=
 =?utf-8?B?S2E2aHB2RUU4YWhnOVhEWjVlNzBuRUpBbFN1a2kzVWZ2elQvNTM3WGFqSklq?=
 =?utf-8?B?OFNxcThTL3lpZWtHQnBDRGJOODZqZml2eVVCTUQ2NHJJNXhpTDhJcCtHa2Fk?=
 =?utf-8?B?dTRKaHJCNGgxU1RldE1odWZ6OGRSZS80ekxIMUg5bUVML0VmV05hOFArZDl0?=
 =?utf-8?B?YklaVEtrVk05SFJ5Q2NJSUk2TFBsUUVLdTB4bkRXYUpXSkNYU1p2Q0JCdXl6?=
 =?utf-8?B?MEtrMnBSR0gwelh6Qk8xTWVXakQ1OWs3RHNpZmxNeW5kYmtLeitXSkJRT3Nt?=
 =?utf-8?B?Y2NGRVdMQTdidjgvNkNYTjVpVGhUcm9MU1Bad2tWeGpZbmluVGZMcnRtSGgy?=
 =?utf-8?B?M3hzUDVnQlhsZkkybEZMYk9Jc2Rwb1FLZjR2bENxYkhYbU9ISlM5NjZDT0Vz?=
 =?utf-8?B?M0xCVGw5NWJ2TnFjdlE1VHZFUkF4ZzcvVzdJc1F5bnlsOU1tYjVuZ1hzNHpr?=
 =?utf-8?B?RDlSMk1Xbm0wakNiSVU2a05zdEF6TVBXWVQzWlRuUXZZWVdaeENlM1MvL3Uv?=
 =?utf-8?B?NDRMUy9RTEZSNUEyNlc0Y0ZQWnlwT1Z1UGNjY2g2b1p2aE5YMmtWRFlYNFpi?=
 =?utf-8?B?RWFqQkp5bzFEY3FIZ2NaYlMzbnVBZ0tkc1RSQWFnQnY3K1A5YUhqQW9YK1pK?=
 =?utf-8?B?aXRZOFVRWFZ1aUxpQnZYMmpxY3hFTWw0UzRaMW1EUUREc3NQckN6OEQ0eTd4?=
 =?utf-8?B?QXB6czVXQURQbmE4RnlVS05aSXo1aVdOOFdsNEdqVUxLOGk3Z2lnZkpmcnNR?=
 =?utf-8?B?K0NwZDlESHZsRmwxd1QxZVZ1Ly83d3g4eWJ3aHdtd3lCeGF4OFBSWU11Q1Bx?=
 =?utf-8?B?dnEyYUZTWUx2RnVDR05zMmlLZlRyN2RYbDNrVlNXZGlXeWlFWGFqU2VMOCsv?=
 =?utf-8?B?M0VVNm1QajB4OHN2RnYrQ29mWmtzQmwrVXA0UEJIckxnS3NOWktKOXRESW9H?=
 =?utf-8?B?SXNabW5MNllJUG9KbXFKZDA5R2hBcHN1cUQ1RlB1VTI3NmJncWFMVStmTWhC?=
 =?utf-8?B?MzF2YllrNHVVS1c1Y2syNGFXSUVZTDlQWFlGNkM5bHZMN0tFcXcxeEZzODdG?=
 =?utf-8?B?MDNwODRlK0tiai8rZkVtb1dFRksrTTF5T01oZEJjaVFQT1dySUxxRWpjZVhV?=
 =?utf-8?B?NXlGRHZBdFlBc3d4Y0ZTaWlQKzJDakZLaTN4MU9FWU1DQ1l3MWtyWlNOUk9q?=
 =?utf-8?B?NFhGQXB3NVQwVXQ4Mm5mNGovSXdHdUhLTytDaGF5alRxRHd3RVJrcnpuVEE4?=
 =?utf-8?B?T2JTczd5U09hZkc3czZWd1pjc1o5WG9LemhraUp1cTg3VnhjRS9jUnpJWmdR?=
 =?utf-8?B?eVViS0VEa2RhL0MrKzJLWWhWMzY2WCtjUFZsaDRmY0EwN2VDNHkvajFTSndI?=
 =?utf-8?B?S3pCaVQ2Yk9ic1lESW1jMGJTQTk2OEpWTGFTNEtPQ2swa041Z3pqWENyTkdS?=
 =?utf-8?B?M25yaHVKbVUyRDlHbVJlTGJuZVZrZllMYmVWWVh3TGdyejRSczBrNS9lWm0y?=
 =?utf-8?B?OHg5REMvOFpEZWhyMDFzSUxTUkhZSjhEUmdLbjBScmJCNk5jNTBDNVp5amdO?=
 =?utf-8?B?Zi9IbStGc05zUTlDVmUza1U1a1VUYUpmenJlbUg5VXBqTy9helI1T0VVZlEy?=
 =?utf-8?B?UlhFWm96bEFxOTFmd09tcjY3cVRaUmdnVFRNbmJFU25SWDBVYlBGY2ErVnJK?=
 =?utf-8?B?Ylg0ZkVOOUgyMDk5ditBdWpRcHA2cUZYTWtjYW55SXRLdlAzOGJHdmRHRDF2?=
 =?utf-8?B?dTBQNFM4NkVqSGlReUFsb1dETE5mc2dydUI5cm9SRElBb0NOMjZFdVpJbHdM?=
 =?utf-8?Q?kw40=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3833d31-8210-4913-d757-08dc63435782
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 03:13:26.1748 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eCOVrjBCSi/oPiKMNF9kEQyQkfE22k5U1T4k24nJx42jcQjQiboY2GcgteGuNmyw/FYTu7FXoeVY915/p4GkKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8087
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

W1B1YmxpY10NCg0KPiBXZSBjYW4ndCBkbyB0aGlzIHRlY2huaWNhbGx5IGFzIHRoZXJlIGFyZSBj
YXNlcyB3aGVyZSB3ZSBza2lwIGZ1bGwgZGV2aWNlIHJlc2V0IChldmVuIHRoZW4gYW1kZ3B1X2lu
X3Jlc2V0IHdpbGwgcmV0dXJuIHRydWUpLiBUaGUgYmV0dGVyIHRoaW5nIHRvIGRvIGlzIHRvIG1v
dmUgYW1kZ3B1X2RldmljZV9zdG9wX3BlbmRpbmdfcmVzZXRzKCkgbGF0ZXIgaW4NCj4gZ3B1X3Jl
Y292ZXIoKS0gaWYgYSBkZXZpY2UgaGFzIHVuZGVyZ29uZSBmdWxsIHJlc2V0LCB0aGVuIGNhbmNl
bCBhbGwgcGVuZGluZyByZXNldHMuIFByZXNlbnRseSBpdCdzIGhhcHBlbmluZyBlYXJsaWVyIHdo
aWNoIGNvdWxkIGJlIHdoeSB0aGlzIGlzc3VlIGlzIHNlZW4uDQoNClRoaXMgc291bmRzIGxpa2Ug
aXQgaXMgYSBkZXNpZ24gaXNzdWUgdGhlbiwgaWYgZGlmZmVyZW50IHJlc2V0IHdvcmtlcnMgZXhw
ZWN0IGRpZmZlcmVudCByZXNldHMgdG8gYmUgdHJpZ2dlcmVkIGJ1dCB0aGV5IGFsbCB1c2UgdGhl
IHNhbWUgZmxhZy4gSSB3b25kZXIgaWYgdGhlIG90aGVyIHBsYWNlcyB0aGF0IGNoZWNrIHRoaXMg
ZmxhZ3MgYXJlIGNvcnJlY3QuIEZXSVcgSSB3YXMgdGVzdGluZyB3aXRoIFNSSU9WIHdoZXJlIGl0
IGFsd2F5cyBkb2VzIGZ1bGwgcmVzZXQgYW5kIHJhbiBpbnRvIHRoaXMgaXNzdWUuDQo=
