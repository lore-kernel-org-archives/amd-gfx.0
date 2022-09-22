Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10840C6FA82
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 09:01:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73AEA10E3D5;
	Thu, 22 Sep 2022 09:01:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F325910E3D6
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 09:00:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkPpOiVDBUcHFCtZPe1bcV9nqSD4Cy1vgsPkoO+ba6IO2sToX4RttGU6wOTpUQOXlI5M+7rqG1SlpTcpFKSW676cFKJSqlY0eU35zgCvEJmkrCbTDXyrnlH+L2dgJlOdYKFNY8l3mKVIbAwPuJu9rYnrH60S9FzKKM8KLkqKbnMGdI5AnfW9SDgCuP47X4I7mKoKwToF277pOeG9DR9U7qS1Tgy+M9IupAH7QNsLkUDy2BrM/w7SUjMz6DUfsHv7OmUgKYZl4Q7bNs1VfEjdrH8yMZbAa5738+gwf6u6zlgFFoN0wUQ3WUGP7Yr2DfiuvGYkDewEbd1IXfMLnujcTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7665tDGcp7MIO9s5D2sgRz1mByrJZlwiCD1B9whRMHk=;
 b=XSXpibqfi4ZoZpAM99vBsjGHg6dS7PBGUPbjYf3SvBK8FKV/aU1WkZOh03F77/2r61v5ZKtesooOdLI9SMPXTs1G0KYAwqtfxa6jn0GdD0EVll5OWz77PS75AXllJ6AElaumGG3LZWC/OQdLLkwG39wcNQ/4htnT8ESrWFZUW68Wx/c+ExMpdPYStzvvRTQ89IMyAFTAT7L9tjd5ZkwmhzasWPAGuEj99kk/C8nlJy3gAJi+Md+SLnaIW0O3Di95IUToqepRtdOoKZhCPT+5gRursv5XlLe3/91AV/KPunz5yzcKAvQ5kv3FPhuF7QRxi0Q5r4O5XiWrUjfIxo/3lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7665tDGcp7MIO9s5D2sgRz1mByrJZlwiCD1B9whRMHk=;
 b=QhF1b0mjwRB6+D+TzgXzPrD9glRh73cSKrBrwL87AnTVn0C0/tZPen9dCaG07DwH4N/PV69BxSV5I2xGFLX3zH4PaulYKgfsiV5OxXbN/aE4F/0rM654v3488kXUZbH+cpzv26MfNwU6GbxHn20Pi4ymJoQvJzhDmkt0+0tFxZY=
Received: from DM4PR12MB5261.namprd12.prod.outlook.com (2603:10b6:5:398::22)
 by PH7PR12MB5653.namprd12.prod.outlook.com (2603:10b6:510:132::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Thu, 22 Sep
 2022 09:00:56 +0000
Received: from DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::b902:2b9d:68d4:d990]) by DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::b902:2b9d:68d4:d990%8]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 09:00:50 +0000
From: "Xiao, Shane" <shane.xiao@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: solve the issue of allocate continuous
 pages under xen dom0
Thread-Topic: [PATCH] drm/amd/amdgpu: solve the issue of allocate continuous
 pages under xen dom0
Thread-Index: AQHYzlKXp2PXFsLLsEuJT9PR3We2JK3rCo6AgAAXMnA=
Date: Thu, 22 Sep 2022 09:00:50 +0000
Message-ID: <DM4PR12MB52619A246EA77D8F92A20D759D4E9@DM4PR12MB5261.namprd12.prod.outlook.com>
References: <20220922071133.927436-1-shane.xiao@amd.com>
 <22bacb5d-6bd1-8c26-71fe-567952f09b11@amd.com>
In-Reply-To: <22bacb5d-6bd1-8c26-71fe-567952f09b11@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-22T09:00:21Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5cbd4d53-17a9-454d-96f9-0a144d022390;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-22T09:00:21Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 8a0b6a39-0fc8-4dc6-9f85-a8a6b987d9f9
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5261:EE_|PH7PR12MB5653:EE_
x-ms-office365-filtering-correlation-id: a72bfbf6-5c3e-4507-51c1-08da9c78f281
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nviy0yhv8Db4P9VMIPyna11iq3YUR6on3icBQntWt43zX5c5SPMjzgLqOEX6a7Z+jV4MLg8uUUNKFPdxies0O6dF61aprB25WBUzM44zG6z0vpDiA8+NDUxlZvy3oXKgO1YQCUVATK2DuyYVPNY3cp1UihJu76Yw263cSveHRfi8/Sqz0XcfTnHx/QIBpm0352Mbpf+FEvnEKxZGlxFyxOvGOyAQFilpyYQc+werz1AHrkkHVrt8DGzkDsS9WxXNH2pMFaSkuOrs5Zc++L4XTXtAzST4b7eJL9MgMKD+DiryhHWDNBDoMMcftSvfWo9fG3Jm9FjsJ6HwZHu5kBxjQ/xYmJZ7wLkHx/JBgUVVA4YPTFSqLz1TglP6Z0xpYNrL92IfxdOQx4uBflHq71fK/BD5s+7YD/aiylodhPC/2piL6nQIurgjgLEvpejgBbH121B/PgJGps/L9s35LIOuRvFIH0XTl/lqE54JG6n9nb46TCZESBSOtm/I/5vjnXudroOGCz/sTsufHM1OeK+JIXCrsqrTCCIp2cR9S6KgGlsDzad2vXei48Q96jAXF3XvOCft//sVMs6Cxv4XwifiodTRJi0DT0l4nrzHY/AviC/0B+yj/cdP1GNvFQ/IAIkUMjwq5zf7d1mwkkitmr+pOqBPwOh9DdmOWorpDfiTnVRhj/LT3hhvKI5vP7XL49J4pqGAXxGZDTwLEwjcBM2s+WqzYNwFOAcli24a8vTekMe+tNki5fx3yGdfkGK1u7nYObyWltqHN4imbx6w5fLvVg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5261.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199015)(53546011)(122000001)(186003)(2906002)(33656002)(8936002)(6506007)(7696005)(52536014)(5660300002)(66476007)(8676002)(64756008)(66446008)(66556008)(26005)(66946007)(41300700001)(9686003)(76116006)(478600001)(38100700002)(38070700005)(83380400001)(55016003)(86362001)(71200400001)(110136005)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXlvSVA5bGZMcE9Ga3pGNk14TFFVdjk0NDdjU0ZpcUpjK0c3VHdoL3JRbzhW?=
 =?utf-8?B?SW0yaFAyOGs0U0ZrdlYzdSsveWJ4cE9mQVpIZlBWK1AyTk4ybHhGL1UyWE9I?=
 =?utf-8?B?WWxuaEJPRVNUL2UvMmh1dTlKN3p5dGM1dUtvcHRuSThmVkFUMEI1bkhvcExm?=
 =?utf-8?B?cXJQZHlHbUtEbGJDMkRId3ZlZTJxS2FQeUVtd2V4N2ZQbXc2RXJKSmQvbWJy?=
 =?utf-8?B?ekgvUjMybXE1dUpwR2FlY0ZTeVg0T2dSb2l4R2NmaVdlbm9jOWNHYWo4Qy9H?=
 =?utf-8?B?YkkzRHBWeDdZRmJkKzFtTlYwa1hpY0tXRmR5bnhRK1BwcTV5M1RValVVM2Zo?=
 =?utf-8?B?eGROeklKbG9qR3pjVkd4cDdDbml4aGRXLy9hTnovQk9BNGJlWWYzMWRraVJO?=
 =?utf-8?B?WFBnZDZaVlZDK3EycVBrTjJYUGJwZEpGVGJWWHR3dEdnRDdVQWI0dmNZOUVz?=
 =?utf-8?B?VjlnRCsvSVlpREZIZjlTaXdVV0FuMlJiRWNpbmdRQ2hTRGxOVVhGMnJZdHZl?=
 =?utf-8?B?UXRPazhyNTgyQ05weDBpenNVbDVBNm4yMTJVUDgwazdab1JWV1l3NWY0WHJn?=
 =?utf-8?B?bGRHdUwwbG5EMk5XS1BpNndSbXJkcE53TG1CdEhhZDB5dmFxUU9UUVNqbG5W?=
 =?utf-8?B?d00wTHBoMzdoZEpOQk9YUWd0clRwT3o4OUkwZ2pWSm04NlpNcFNKWE5vK2Qr?=
 =?utf-8?B?OEs1RVNTWGRnbkRpV0lsOEQvRzFzOG5ZbXhmNVp1VndZRk42QTF2OFduME8x?=
 =?utf-8?B?dXRxWDhnK3RkK085MHg5OWZaQkRTdWlMbk5lNjVwMU5pRGtqZk1HYlR6VFFR?=
 =?utf-8?B?WUQ3NVQ1QzJMcFI2WHA2dE5Ld3dDdmtDUFdVa21SeGQvZXRlZHpOMU5HS0tW?=
 =?utf-8?B?c1NXME8ySjZGVUZheUJNU3g3SWp0Y241anVWdytjT28raEhuRWZEcTBiV1p5?=
 =?utf-8?B?TTVZTGVVQ3MyMTdkbEQvQ2N3eVIxVXh1bGgzYmd6OVVhd055cXlxS29ramRT?=
 =?utf-8?B?dG5HMDVPeWFnNjNmdFk3NDVhaDdRZ1ByOUQ5MUVqM0ZleVFuNVc2eW1mcEJR?=
 =?utf-8?B?VDFKTERpMHhwMmdpM2xUYVZ4N0daY3JKUFpiM3IxYmdZeGxac3NRb1Z4OXBm?=
 =?utf-8?B?b21OUnVMRFpESE5PSXI3ZkNaUzhUK3ZqeFZtWitrV0JZNy9vUWlhYUVzYWdD?=
 =?utf-8?B?R080VVEyaGZnZ2NxM0x1NjZxKzF4TGFkVUl0VVZIU3pLQys4a3dqYnZ6ZWVT?=
 =?utf-8?B?c2ltVlMzWUNia01ha3hEVmMyWnRRby83YmozVi9JRmZMVTBTS0RYT0E2OWlj?=
 =?utf-8?B?Mlp6cUo3d1lVOGJmOHdyVy9ReHpTa1VYUkl4SGEwbkNWUEs2WXZsaDhrL0tq?=
 =?utf-8?B?Wk9QZEJSZTl6VGJ6MmgyNHJkME1qSHNzRmxCZXl1WkYvSTU2KzRDUmdmL3dx?=
 =?utf-8?B?NU9ib0hUNlNHa1NnZy9kUkQ3R043eWozejY1anZob1FhQk1XOUFQUGRTMy9Z?=
 =?utf-8?B?M2NUVkRlbzdsUGljWlB2YVZPWVlMdndmcDdKRk1TOGM2TTY2Q3NDOWpoeU0y?=
 =?utf-8?B?L00wd0VPYXNTL3lTelAvVFM1aFlNcWZjYXl5MG0yYi94MXlJVkRQbTVWTzBy?=
 =?utf-8?B?Tk9Bb0dRZDRqcEZNZDRYdHpBYm90bC9sckgzcUM0eHcvbnNyOHFad1pyNnBh?=
 =?utf-8?B?TXZpblRiZHIrb2dQVDJWVWF6UFNyKzFwSmluMWs1ZXEzeWVRR0h3ZjB6bnZV?=
 =?utf-8?B?SDIwZXRvVlpHdVc0bkNkR0htRXJ4OGdKT3ZNd2E3RnY1aHovNFI5MGZZRE9B?=
 =?utf-8?B?Y1JzVThtVmVTSVJxYXROb1RLdElrUkNxZUhHbFBNZHRBcU8rNWh0dnNJOGcx?=
 =?utf-8?B?OW10QVFVR1NzczlSTWZHdU95TGdjUVc3SWlHWHVGNnRNdU0wek5vY05VbmlF?=
 =?utf-8?B?UHFMMHhiTFptdE81SnZIc1RTdVJ5QVB6NENuU2tUM0xtZnhmTEhjc05XVHEv?=
 =?utf-8?B?bCtMMnkwSkdWQjBDa1p2aHIxL1llck83amFIZ2lBK3d1b0luekxkMzcrd2lJ?=
 =?utf-8?B?N3czemJTbmVzTThwRHlneTBSakYxVkNEWjc2ajNNRWtaa3NESTk4OEhtWFFO?=
 =?utf-8?Q?rLF0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5261.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a72bfbf6-5c3e-4507-51c1-08da9c78f281
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 09:00:50.4760 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: axOSXMVVxh2rgx/aCR79KY2v2yIZgnLwrv/cRaAXbnHl6tSu9pOypc1maq4iB1bi8lZmlNjKHtsOCDAKM1eb6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5653
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIENocmlzdGlhbiwNCg0KV2h5
IHNob3VsZCB0aGUgcmVzdWx0aW5nIHNnIHRhYmxlIGJlIHRvbyBsYXJnZT8NCltTaGFuZV0NCnNn
X2FsbG9jX3RhYmxlX2Zyb21fcGFnZXMgd2lsbCBzZXQgbWF4X3NlZ21lbnQgZmllbGQgYXMgZGVm
YXVsdCB2YWx1ZSBVSU5UX01BWCAgdG8gc2dfYWxsb2NfdGFibGVfZnJvbV9wYWdlc19zZWdtZW50
LiBUaGUgZmlsZWQgbWF4X3NlZ21lbnQgd29ya3MgYXMgZm9sbG93czoNCuKAnENvbnRpZ3VvdXMg
cmFuZ2VzIG9mIHRoZSBwYWdlcyBhcmUgc3F1YXNoZWQgaW50byBhIHNpbmdsZSBzY2F0dGVybGlz
dCBub2RlIHVwIHRvIHRoZSBtYXhpbXVtIHNpemUgc3BlY2lmaWVkIGluIEBtYXhfc2VnbWVudC7i
gJ0NCklmIHdlIGRvbid0IHNldCB0aGUgbWF4X3NlZ21lbnQgZmllbGQsIHRoZSBzZ19hbGxvY190
YWJsZV9mcm9tX3BhZ2VzIG1heSBhbGxvY2F0ZSAyTSBvciBtb3JlIGNvbnRpbnVvdXMgcmFuZ2Vz
IG9mIHBhZ2VzLg0KDQoNCkZvciB3aGF0IHRvbyBsYXJnZT8NCltTaGFuZV0NCkhvd2V2ZXIsIHRo
ZXNlIHBhZ2VzIGFyZSBjYWxsZWQgcHNldWRvLXBoeXNpY2FsIHBhZ2VzIG9uIHhlbiBkb20wLCB3
aGljaCBtZWFucyB0aGF0IHRoZSBhY3R1YWwgbWFjaGluZSBwYWdlcyBhcmUgbm90IG5lY2Vzc2Fy
aWx5IGNvbnRpbnVvdXMuIA0KV2hlbiB0aGlzIGhhcHBlbnMsIHRoZSB4ZW5fc3dpb3RsYiB3aWxs
IHVzZSBib3VuY2UgYnVmZmVyIHRvIGRvIGRtYSBvcGVyYXRpb24gYnkgc3dpb3RsYl90YmxfbWFw
X3NpbmdsZS4gDQpCdXQsIHRoZSB4ZW5fc3dpb3RsYiBvbmx5IGFsbG93cyBJT19UTEJfU0VHU0la
RSpJT19UTEJfU0hJRlQgKDI1NkspIGNvbnRpbnVvdXMgcGFnZXMsIGFuZCB0aGUgYWxsb2NhdGUg
Mk0gb3IgbW9yZSBjb250aW51b3VzIHJhbmdlcyBvZiBwYWdlcyB3aWxsIGNhdXNlIHN1Y2ggZXJy
b3IgInN3aW90bGIgYnVmZmVyIGlzIGZ1bGwiLg0KDQpCVFc6IGludGVsIHVzZXMgdGhlIHNhbWUg
bWV0aG9kIHRvIGFsbG9jYXRlIHBhZ2UgdGFibGVzIGluIGk5MTVfZ2VtX3VzZXJwdHJfZ2V0X3Bh
Z2VzLg0KDQpCZXN0IFJlZ2FyZHMsDQpTaGFuZQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+
DQo+IFNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMjIsIDIwMjIgMzoxOSBQTQ0KPiBUbzogWGlh
bywgU2hhbmUgPHNoYW5lLnhpYW9AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWQvYW1kZ3B1OiBzb2x2ZSB0aGUgaXNz
dWUgb2YgYWxsb2NhdGUNCj4gY29udGludW91cyBwYWdlcyB1bmRlciB4ZW4gZG9tMA0KPiANCj4g
QW0gMjIuMDkuMjIgdW0gMDk6MTEgc2NocmllYiBTaGFuZSBYaWFvOg0KPiA+IFtXaHldDQo+ID4g
c2dfYWxsb2NfdGFibGVfZnJvbV9wYWdlcyBhbGxvYyB0b28gbGFyZ2UgY29udGludW91cyBQRk4g
cGFnZXMgdW5kZXINCj4geGVuIGRvbTAuDQo+IA0KPiBXZWxsIHRoYXQgc2VudGVuY2UgZG9lc24n
dCBtYWtlIG11Y2ggc2Vuc2UuIFdoeSBzaG91bGQgdGhlIHJlc3VsdGluZyBzZw0KPiB0YWJsZSBi
ZSB0byBsYXJnZT8gRm9yIHdoYXQgdG8gbGFyZ2U/DQo+IA0KPiBSZWdhcmRzLA0KPiBDaHJpc3Rp
YW4uDQo+IA0KPiA+IEhvd2V2ZXIsIHhlbiBzaG91bGQgY2hlY2sgY29udGludW91cyBNRk4gcGFn
ZXMgaW4NCj4gcmFuZ2Vfc3RyYWRkbGVzX3BhZ2VfYm91bmRhcnkuDQo+ID4gV2hlbiByYW5nZV9z
dHJhZGRsZXNfcGFnZV9ib3VuZGFyeSByZXR1cm4gZmFsc2UsIHNvbWUgY2FzZXMgZmFsbCBiYWNr
DQo+ID4gaW50byBzd2lvdGxiIHByb2Nlc3MgYW5kIHRoZSBjb250aW51b3VzIGFsbG9jYWJsZSBw
YWdlIGlzIG5vdCBlbm91Z2guDQo+ID4NCj4gPiBbSG93XQ0KPiA+IEluIGZhY3QsIHhlbiBzd2lv
dGxiIHNldCBtYXhfc2VnbWVudCBkZWZhdWx0IHZhbHVlIGFzIFVJTlRfTUFYIGFuZA0KPiA+IHhl
bl9zd2lvdGxiX2luaXRfZWFybHkgYWxyZWFkeSBjaGFuZ2UgdGhlIHZhbHVlIHRvIFBBR0VfU0la
RSB1bmRlciB4ZW4NCj4gZG9tMC4NCj4gPiBIb3dldmVyIGFtZGdwdSBkcml2ZXIgZG9lc24ndCB1
c2UgdGhlIHZhbHVlLCB3aGljaCBtYXkgY2F1c2UgaXNzdWUNCj4gPiBzdWNoIGFzIHN3aW90bGIg
YnVmZmVyIGZ1bGwuIEFkZCBhbWRfc2dfc2VnbWVudF9zaXplIGFjY29yZGluZyB0bw0KPiA+IGlv
bW11IHNldHRpbmcsIHRoZSBkZXRhaWxzIGFyZSBhcyBmb2xsb3dzOg0KPiA+IAlpb21tdSBzZXR0
aW5nCQl8CWFtZF9zZ19zZWdtZW50X3NpemUNCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+
ID4gCWlvbW11PW9uCQl8CVVJTlRfTUFYDQo+ID4gICAgICBpb21tdT1vZmYgJiYgc3dpb3RsYiBv
bgl8CUlPX1RMQl9ERUZBVUxUX1NJWkUoNjRNKQ0KPiA+IAl4ZW5fc3dpb3RsYiBvbgkJfAlQQUdF
X1NJWkUoNEspDQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+IC0tLS0tLS0tLQ0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogU2hhbmUgWGlhbyA8c2hhbmUueGlhb0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIHwgMjINCj4gKysrKysr
KysrKysrKysrKysrKystLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3R0bS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdHRtLmMNCj4gPiBpbmRleCAxMzQ1NzVhMzg5M2MuLmQwODFmY2QyMmQ2YiAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMNCj4gPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMNCj4gPiBAQCAtODAs
NiArODAsMjMgQEAgc3RhdGljIGludCBhbWRncHVfdHRtX2luaXRfb25fY2hpcChzdHJ1Y3QNCj4g
YW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPiAgIAkJCQkgIGZhbHNlLCBzaXplX2luX3BhZ2UpOw0K
PiA+ICAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IGFtZGdwdV9zZ19z
ZWdtZW50X3NpemUodm9pZCkgew0KPiA+ICsJdW5zaWduZWQgaW50IHNpemUgPSBzd2lvdGxiX21h
eF9zZWdtZW50KCk7DQo+ID4gKw0KPiA+ICsJLyogc2l6ZT0wIHdoZW4gYW1kIGlvbW11IGVuYWJs
ZWQgKi8NCj4gPiArCWlmIChzaXplID09IDApDQo+ID4gKwkJc2l6ZSA9IFVJTlRfTUFYOw0KPiA+
ICsNCj4gPiArCXNpemUgPSByb3VuZGRvd24oc2l6ZSwgUEFHRV9TSVpFKTsNCj4gPiArCS8qIHN3
aW90bGJfbWF4X3NlZ21lbnRfc2l6ZSBjYW4gcmV0dXJuIDEgYnl0ZSB3aGVuIGl0IG1lYW5zIG9u
ZQ0KPiBwYWdlLiAqLw0KPiA+ICsJaWYgKHNpemUgPCBQQUdFX1NJWkUpDQo+ID4gKwkJc2l6ZSA9
IFBBR0VfU0laRTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gc2l6ZTsNCj4gPiArfQ0KPiA+ICsNCj4g
PiArDQo+ID4gICAvKioNCj4gPiAgICAqIGFtZGdwdV9ldmljdF9mbGFncyAtIENvbXB1dGUgcGxh
Y2VtZW50IGZsYWdzDQo+ID4gICAgKg0KPiA+IEBAIC03NjAsOSArNzc3LDEwIEBAIHN0YXRpYyBp
bnQgYW1kZ3B1X3R0bV90dF9waW5fdXNlcnB0cihzdHJ1Y3QNCj4gdHRtX2RldmljZSAqYmRldiwN
Cj4gPiAgIAlpbnQgcjsNCj4gPg0KPiA+ICAgCS8qIEFsbG9jYXRlIGFuIFNHIGFycmF5IGFuZCBz
cXVhc2ggcGFnZXMgaW50byBpdCAqLw0KPiA+IC0JciA9IHNnX2FsbG9jX3RhYmxlX2Zyb21fcGFn
ZXModHRtLT5zZywgdHRtLT5wYWdlcywgdHRtLQ0KPiA+bnVtX3BhZ2VzLCAwLA0KPiA+IC0JCQkJ
ICAgICAgKHU2NCl0dG0tPm51bV9wYWdlcyA8PCBQQUdFX1NISUZULA0KPiA+ICsJciA9IHNnX2Fs
bG9jX3RhYmxlX2Zyb21fcGFnZXNfc2VnbWVudCh0dG0tPnNnLCB0dG0tPnBhZ2VzLCB0dG0tDQo+
ID5udW1fcGFnZXMsIDAsDQo+ID4gKwkJCQkgICAgICAodTY0KXR0bS0+bnVtX3BhZ2VzIDw8IFBB
R0VfU0hJRlQsDQo+ID4gK2FtZGdwdV9zZ19zZWdtZW50X3NpemUoKSwNCj4gPiAgIAkJCQkgICAg
ICBHRlBfS0VSTkVMKTsNCj4gPiArDQo+ID4gICAJaWYgKHIpDQo+ID4gICAJCWdvdG8gcmVsZWFz
ZV9zZzsNCj4gPg0K
