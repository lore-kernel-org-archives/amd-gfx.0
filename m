Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22FFC3DA41
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jul 2024 14:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65EA810E573;
	Tue,  9 Jul 2024 14:03:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pOgisdrw";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 417BF10E575
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jul 2024 14:03:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kir27szuRtiXCN7Lkth6gzRSpPFKDRLkuNAL/YS6VqjCjKGJ3LSR4WfD+VbWGBkvnLtvq4OJiRubMP7qLcG/onLNZLuRXQPN+R7YQJhRzdU3Jj9oK/RLwXwqkh1ALxw5srmEo+atFjU1MMOT+IvNfC/CaS/lImw6EVfW19v/+ktycSWH0qdOyh7MLJGFuVJFs4xTZ+6+5caCvQbL2V8jYVAHsQnzvmtu8Bj6jk3frf6uT4+TEMjh4I4/7NO/5CUZYje+WRs1HZIb+WyK5vtbsGw7K/XLL8Qs2b/D0E4bO7uwawao5dlCSkGzxqCJQZx/36N8o7AiY6lCeHOYtnwJTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kni1kzNeq6dopNp7kYMiKf8RJQPHJGsXrE/aP4eiGHQ=;
 b=QGWznzPevaIljllb3YUkNIMMj+jfQL7st1mTPHiwgIZlAKsGu+Z5ekbHVQna1MhlBttF5PkLBbMv16p3hgiYj0NQcF3ryw7Kb2nwEtnnDbEtbeBAG2nIYgVE+sqfCnYYRt+BmW+5jnQZPCt2mkQy8YL1B00b6iG9R2WHlvHl0ItA0jzE8u6Q71OngFxKRXF+6VKJS5ktiwBCf8Z30HcLZoES2sUeC9q9WOGzm7JiHRvw8e5ebgoHidycmy3imAEhq04OMnupxjQgTcPp3M/9lp7ZSmk/0qkTMRETgGU9J11UY8GyQUfBOngAOuuo2PwG7Q+C+y+8BxSZkIAazCcsIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kni1kzNeq6dopNp7kYMiKf8RJQPHJGsXrE/aP4eiGHQ=;
 b=pOgisdrwiJjPTXnBIMnJp7hxyfx4bSPjJwg3Mv4IZ8geDggmjbzYtkySOomwwkR4F44WsiZkAMnk58WdqIwPSpgN3sVEXyc/62Z/Jso+nQaK5CNO0FgnthRU844yDm5qQRLEeC4rrMOdsI9xXhzTP78PgJ8QvlsRX/GuI+gCqoQ=
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by SJ1PR12MB6267.namprd12.prod.outlook.com (2603:10b6:a03:456::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 14:03:11 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b%7]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 14:03:11 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v1 3/3] drm/amdgpu: select compute ME engines dynamically
Thread-Topic: [PATCH v1 3/3] drm/amdgpu: select compute ME engines dynamically
Thread-Index: AQHa0cZLOJgaq1WDv0CVdEurgUCeprHubEMAgAABX+A=
Date: Tue, 9 Jul 2024 14:03:11 +0000
Message-ID: <PH7PR12MB559608B736B8A919016F9FE393DB2@PH7PR12MB5596.namprd12.prod.outlook.com>
References: <20240709060723.1568284-1-sunil.khatri@amd.com>
 <20240709060723.1568284-4-sunil.khatri@amd.com>
 <CADnq5_MjruP+4kkzH3RNUTYKqVVTU-YtdMBSyPjT6TNLgEZBpA@mail.gmail.com>
In-Reply-To: <CADnq5_MjruP+4kkzH3RNUTYKqVVTU-YtdMBSyPjT6TNLgEZBpA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7460284e-5335-4750-8898-1cfc917e9192;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-09T14:02:10Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5596:EE_|SJ1PR12MB6267:EE_
x-ms-office365-filtering-correlation-id: ccbf42a6-0e25-4d56-a7eb-08dca01fde46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RVVkNm5pRVRta1FtbS84OGxEVUlMSk1CSkVBM3dlcmFWTXh0Z0lFdEVmalJS?=
 =?utf-8?B?RHJuUWYycDB6Y3FmcUNUbXgrakdDT0hrZUR6Z0VoeitXT2cveU5mNFpqeEhB?=
 =?utf-8?B?Ym93TzVRUWhDQ0xwSFlOamhaSWp2VlNnN2tOOTdDZXBnRVhKMTBsU1d1MFh0?=
 =?utf-8?B?ZmN3OXlEVFJsejZkRktvM2JMaEhKK1hvUmxncmRSaUN3KzdkM1l6ZXpzVC9K?=
 =?utf-8?B?L0VJQWc5dVk1L2xWNzlXUmU1aVFuK1FEY3lNRFBJWXV6dWQ0OVNpazYwbk1C?=
 =?utf-8?B?SUJicDlJMGxhcm4rOGNqS2RBeDJicDlDQ2pIaE54QXpzNGlxUjBJdm53RDZm?=
 =?utf-8?B?ZXhkSXR6THR3Mlc0TXptWUJNWTNXYkVGNUduY2ZUekxJYjZMZzZPL0QxOGZI?=
 =?utf-8?B?OVNURm9xTzlhd1M3L1JXOGRPRjdNa2lrY1dMOEV4cUdLUFFzZk5CaDVlZEQ1?=
 =?utf-8?B?a3A4eExEQlhpdGp0YlAvOExVRkVxcmlHZFFKaFNiMnZHNmxNb2ZxQll4aHBP?=
 =?utf-8?B?K1VWYVVOMFJtQi9zcCtkQjgreGhRN3oyZE05bTFjT3ZBemxWL1NDTVUya0p5?=
 =?utf-8?B?Z2pYVkNLeXJDNzdyejYySFplRDN3QWpYVXBWZ2Y1cEZTd29rdkVZY2F6cDUv?=
 =?utf-8?B?Z2lJUVBvckpUM3VWSm80QjRrUDlHN0hVVWNOdGM4RzZSUk9GRk5ETGJPZTdx?=
 =?utf-8?B?dk5pVWhCanQzYitxQURKbUpqQzZTc0xxOCtIalYyUE5xNlJtamNkUThldVpz?=
 =?utf-8?B?aGlteGxGdGUrbVRVS1RRaXdJbWxJL0lYTzQ0TDRNaU5tMFUwZUcrci9GemRw?=
 =?utf-8?B?dzV5VHB3NFRURHU3WVNHRXdnTUIwSXk0My9ESHA5ZkI3aG8yT1BSWllZd0dy?=
 =?utf-8?B?NkRTZkJnRmUwbkp2UUdJR3BqbEVPRjhxYXFHdkF1dnBkS2t2U0E5bGdsYk5U?=
 =?utf-8?B?MmhycnZ5SUp0YXhwTlE0TXZveWR3aHMybjEwNThQZ0tqc1pCeWNEaGZ4QWVu?=
 =?utf-8?B?NTU1NmwyL3VielE5RzVJaWxKb1ZRV0V3UnJlNWdTcXk0MzV6dU9OT3dQemI3?=
 =?utf-8?B?Y3RyZkVWdURqNUV3ZGQxTTlMOWNld1g2MlpsUjBMV2pPb09SWnRXcG9rcm9q?=
 =?utf-8?B?b2hwOVB3RWtjUXZyQ2ozK3BIeHM1dUNKSGVuamNUaDRJZ1hWVlRLZVNPUkZY?=
 =?utf-8?B?VitucjdZZlliWEd3NlpScmorM3RzYnVET0VKN0o4aTc4TjhiTGhQSGh2bTlR?=
 =?utf-8?B?OWV6VTdHNHE5QzdVU2wyUkF1QmNkeEVUc0hJc1l4ZWZ5LzZxOWxYSWdDY3F3?=
 =?utf-8?B?bTAxelNML2lpYktzcmpVeWEwZ3BidGVMZWszUDlDNzlGb3JYaDdieTdDWGpX?=
 =?utf-8?B?NHp1eCt5a2Vrc0N2bUpXNkpMdUppR01wT2MxVFlGWjg2ZWNTeVFBNU9PbE5U?=
 =?utf-8?B?eG1mQ0lRdit6cGRRUXlNOXFiQ0RLaWsvR0VHcDk2a09BcUl1UXFneWt2bWQ0?=
 =?utf-8?B?YUtBV3c3SDBNS1hSTXVCcFVnL1VxTHFyVHV4bEZJMDAvNmJaSXF1Y3FsNWU2?=
 =?utf-8?B?N0Z2VWttd0JiYVpCdTR0UWpkK0xLaXR5Q1o4SEtSWjdyam1GM1FWamZPK1BD?=
 =?utf-8?B?SWZha29TbTd3Ri9hdG0yaVFjQmo5RHJnTlR2aXBnYjlVZnppTHBsRXNrQUZC?=
 =?utf-8?B?enZsODRXYWJMRFk5a0VHbGwvOWN2M2FIeW5uRFI1bnJ5N3FiK0FodWJ0SlVS?=
 =?utf-8?B?cU16WWErWDNiOTdEOUVxc2hObHBiWWpCSldBbWN6V05TWWd4QmdzOWlNdVJv?=
 =?utf-8?B?VEdDVE5rb05SbGNITmpDNjVCc3hLTUlhc3dZMSs2K1hYSTFuWk5SdzJNbkdy?=
 =?utf-8?B?MGpURXdKT2UyUjBVaVpiLzBaS2c2SU1OcGl4SnhLM0xzemc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVJwYm5EdHp6NHl5R25tZjBBRzBhc29TOXVVbU5YMFJiNjNvOWlYNFNRNGVa?=
 =?utf-8?B?MzdHZWlueTlzV1ZxZFhzNWkrMGFoQkRJdkZ4RS9Lb3luaHdFbWExSUhEQUtw?=
 =?utf-8?B?RDVjNUFoUzVac29XZXVzUG5wdVdzcWM4ZkVlSjFqeDVSRks0OUNUSW9BT2hB?=
 =?utf-8?B?eVlhMitSTmVzZXppYXBGeGlmVnpINTNBV2ZFRDNTUVRWSjFpYlN6eDVwL3Vs?=
 =?utf-8?B?Ym55ZEZXRk5tcWpHN3N0K215d252VVpxWjhoNFBlTHRpUFlOTE9VUWhtdXZX?=
 =?utf-8?B?RUs2blJnUFBMTXZxbnA3cW5SaXlBZ00yUHlCRWErTVRGTFRWS0ZkK3B4QUxV?=
 =?utf-8?B?bEVvUUZiekpTUEk5eW1vc3YyNTNUNHpwWjQ2Q0ZSY0RCcjFjaWVhdEpHK2Np?=
 =?utf-8?B?WE4ybXdBQUhLR3ZTckt5RXFWeXQrcHdDR2VVZXM3OTkrYTBNWHVZdDRSRnhT?=
 =?utf-8?B?RklxTWUyeTN2cjBjSkprQ2ErZ3ZJNFBoWTNzVlBpdVNOTWhGYnBIS3FqWi9u?=
 =?utf-8?B?MGVQZjRpbENmQ21ESlA4Q1lkak0zcTF4Ti96U29EK29TOTNtL3BvK2ppZlBZ?=
 =?utf-8?B?U0hnMm5pOVR4TWJUZ0ZOZ0hiMUdVZTlOeTZRczFpSFFSYm40bERYZ25ZMGpZ?=
 =?utf-8?B?ZHBEWGVQcFpZVjU1S2U5MDZ6akRjSkQydStKTmxXVHZnbzBFR21NSW9iWVU1?=
 =?utf-8?B?V2tpeHllOXZabURxWjd5UWdGay8wQTQ1bHkyVGo0OU9abGNwNWlUZHZXQ0t0?=
 =?utf-8?B?MVZ3QThrRjdKMlhaczdjajB4N3FINUhQNmFJM09PREM4eEdielBzUWhRYUxo?=
 =?utf-8?B?dXRlcThUL09qditodko1aFphUU1xWGJpYzA4R2xOeFNleFhqWkFBc0hpQWtn?=
 =?utf-8?B?dHR3SW53VWkyM3pZbjNoaFgzbUp5RGhGTnBraXhUU1ZqWTF2MkdrOWFGSHU5?=
 =?utf-8?B?UFpZd1Z3YS9iTzRndVVxRXVzWmNVd0ZOczc2b2I4T2QxanhYMFZYZElrRVo0?=
 =?utf-8?B?YUJYOHJRV2d3OW9jRW10Y2puMTIrQk45UlNNNXZWaDN5eHBPRFZ2R0tVayt6?=
 =?utf-8?B?RzhNM3RpQUtTTVFtRGhmbzgrZWVXM0FHMU9WUU9iRmZjVWdHajJZaW1lZFZ5?=
 =?utf-8?B?NkYzcnFQaWRCQkRZMXNRQ0t6L2NnanhGQ09mVHh3NnMyYUxOQkFzT2MraUlH?=
 =?utf-8?B?V3NJTGRKYWh0U2ZEOUdiWmQreEdvNVMrdzMrSlpYaVRpQ2RSU1JvcGo5S3JG?=
 =?utf-8?B?OCtydzJsdldabVc3WWg3dDdBRFA5QmJ3cW91QU1ZR3ErNjd2cEJzTGlTbWFC?=
 =?utf-8?B?b1hwOUlqZFlCbTBqWExlbXNkOUdTSTh0Q3dib1FGUElDVEV0cEpkeWlxclNL?=
 =?utf-8?B?dDJ2cGJteXkvTVBBQlg5YTRla2xraHJjczUra0ZqK2M3amZqWWdOWVBwUi9X?=
 =?utf-8?B?VTZaRUdTb2V2Y2crUkpjZ0JsSGZnVVgvMUxibTVDZWxXb1BEUjRVcEdNZkpu?=
 =?utf-8?B?ekUydVBPTGFqeHd3OXBoU05JemFnaXNzNC9aR2tvSXJXLzNVUDNnL2JpelJa?=
 =?utf-8?B?MkdpOGM4Uzl6QzFrZ3Ziak91ay9FNmpLcE40bmo2QndKZDkwQTBhcDRJRDJS?=
 =?utf-8?B?RW9wVE02eW9GZ1N6VkxZVjVIREl5TDFSVnhHWkRkeVlPUDcwSEtIVzVIcEtu?=
 =?utf-8?B?Y3JuY0tqYTRQMDBLVGR2VTcydlJqQU1YMTNYVFZ0eXlJbUNhWG0ySHFNdm5F?=
 =?utf-8?B?d0FJSzUwemxQYXZ5eCtJbmljM0RvV1Fkd01CZEU4ek0vUTJsNlB1TWRaTlp3?=
 =?utf-8?B?ejFLUFVNa2dqcEo2bEJkalRNNzQvQTJvSnNmK0R6ZTVTSDdNMVJZTi9yMm03?=
 =?utf-8?B?RWlHOENKeEpDZElqS2EvcUV6dThJUThaa01FREVaMVplREIrZmVURWlxWndX?=
 =?utf-8?B?L3A4UmNyaTFoOW9JOGtIOTU1eGtBNmthNzl3YldOaE82RStqSkVpcCtrUndo?=
 =?utf-8?B?TVJSRHNzWVY3Mjk3SU5jOGgxSHFCd1FtQXFoZnBjZ2tJTmpXZkpDcVFxU3Jo?=
 =?utf-8?B?cVhNSU1CcThpSFdiTldCNzRwOVVNTFplQU9WZFZqSXdidStUaStVd3FMZFpN?=
 =?utf-8?Q?e45Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbf42a6-0e25-4d56-a7eb-08dca01fde46
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 14:03:11.3294 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tYXhtXIUTZwsUoQ3FA8gbwmewKuHrmaKgBgifMT5IhM9Ncbj2bpgkFBPSRDlOH2aJuVzNZJ/IPGaNt1ERZ4F+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6267
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KVGhhbmtzIEFsZXgNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFsZXgg
RGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPg0KU2VudDogVHVlc2RheSwgSnVseSA5LCAy
MDI0IDc6MjcgUE0NClRvOiBLaGF0cmksIFN1bmlsIDxTdW5pbC5LaGF0cmlAYW1kLmNvbT4NCkNj
OiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcs
IENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMy8zXSBkcm0vYW1kZ3B1OiBzZWxl
Y3QgY29tcHV0ZSBNRSBlbmdpbmVzIGR5bmFtaWNhbGx5DQoNCk1ha2VzIHNlbnNlLCBhbHRob3Vn
aCB0aGUgcGF0dGVybiBlbHNld2hlcmUgaXMgdG8ganVzdCBzdGFydCBhdCAxIGZvciBtZWMuICBO
b3Qgc3VyZSBpZiBpdCdzIHdvcnRoIHRoZSBlZmZvcnQgdG8gZml4IGFsbCBvZiB0aG9zZSBjYXNl
cyB1cCB0b28uDQpUcnVlLCBidXQgd2lsbCBrZWVwIGEgY2hlY2sgb24gZ2Z4MTMgYW5kIG9ud2Fy
ZHMgYW5kIG1heSBiZSB3ZSB3b3VsZCBoYXZlIGEgbW9yZSB0aGFuIG9uZSBNRSBmb3IgZ2Z4IGlu
IHNvbWUgY2hpcCBhbmQgdGhlbiB3ZSBoYXZlIHRvIHRha2UgY2FyZSBvZiBpdCBleHBsaWNpdGx5
Lg0KDQpTZXJpZXMgaXM6DQpBY2tlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hl
ckBhbWQuY29tPg0KDQpPbiBUdWUsIEp1bCA5LCAyMDI0IGF0IDI6MDfigK9BTSBTdW5pbCBLaGF0
cmkgPHN1bmlsLmtoYXRyaUBhbWQuY29tPiB3cm90ZToNCj4NCj4gR0ZYIE1FIHJpZ2h0IG5vdyBp
cyBvbmUgYnV0IHRoaXMgY291bGQgY2hhbmdlIGluIGZ1dHVyZSBTT0Mncy4gVXNlIG5vDQo+IG9m
IE1FIGZvciBHRlggYXMgc3RhcnQgcG9pbnQgZm9yIE1FIGZvciBjb21wdXRlIGZvciBHRlgxMi4N
Cj4NCj4gU2lnbmVkLW9mZi1ieTogU3VuaWwgS2hhdHJpIDxzdW5pbC5raGF0cmlAYW1kLmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEyXzAuYyB8IDIgKy0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMl8wLmMNCj4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEyXzAuYw0KPiBpbmRleCAwODRiMDM5ZWI3
NjUuLmYzODRiZTBkMTgwMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3YxMl8wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Yx
Ml8wLmMNCj4gQEAgLTQ5NDYsNyArNDk0Niw3IEBAIHN0YXRpYyB2b2lkIGdmeF92MTJfaXBfZHVt
cCh2b2lkICpoYW5kbGUpDQo+ICAgICAgICAgICAgICAgICBmb3IgKGogPSAwOyBqIDwgYWRldi0+
Z2Z4Lm1lYy5udW1fcGlwZV9wZXJfbWVjOyBqKyspIHsNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgZm9yIChrID0gMDsgayA8IGFkZXYtPmdmeC5tZWMubnVtX3F1ZXVlX3Blcl9waXBlOyBrKysp
IHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvKiBNRTAgaXMgZm9yIEdGWCBz
byBzdGFydCBmcm9tIDEgZm9yIENQICovDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc29jMjRfZ3JibV9zZWxlY3QoYWRldiwgMStpLCBqLCBrLCAwKTsNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzb2MyNF9ncmJtX3NlbGVjdChhZGV2LA0KPiArIGFkZXYtPmdm
eC5tZS5udW1fbWUgKyBpLCBqLCBrLCAwKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBmb3IgKHJlZyA9IDA7IHJlZyA8IHJlZ19jb3VudDsgcmVnKyspIHsNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFkZXYtPmdmeC5pcF9kdW1wX2NvbXB1dGVf
cXVldWVzW2luZGV4ICsgcmVnXSA9DQo+DQo+IFJSRUczMihTT0MxNV9SRUdfRU5UUllfT0ZGU0VU
KA0KPiAtLQ0KPiAyLjM0LjENCj4NCg==
