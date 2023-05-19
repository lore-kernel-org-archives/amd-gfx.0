Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A48C77B7A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 13:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3DC510E05E;
	Fri, 19 May 2023 13:25:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 555FD10E021
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 13:25:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwEe+ZwZOkyBi0/byVy33+Li08/Zy6mRWBi50ikZTkD8wwNyPN/0xAPtWT7L7B1mgwceLvKcAvptQ/y+Ix9aRx7BITuJcIfmUJPjAkXnLiSilVNtbdtNS2QZy6jWrazsLgdfLc90Lad/DWx0P7cgR0zt12GhoWciERom/4YYTQuDaAg6eJbYYoW75KaZJN/jg1sg/SCvLz3/mzrQq7hWcfZltutTXlVlvluZky4vD7m/bnYf7FeY9xIG8EDhVIIE26I8F0fU1TppMHTB2//9nGuZiGse3+p85BUWsv1z4DiJCjutWu62VEaTemJ8Rew/FdgwBUgloY4KBTKugXK8AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2FeINUyDRrJXyO+hSL3QYKWziXCSLvu/Qw/CR2kyXA=;
 b=SLZWBg9NoCIrs3y1n1IwO1VRVvvXwyf5TWs+iF3BNyXyn1RLLzlzckbyGjJVmfdkN50U95QpI6jS3UUjdFYAbv2DsQ/o6Mh+EmeN4ImSyuROvYIxegJQNXgFZk0noeGvB4PK3F53GZNJFAT4eKt604Pih57PAFECJptP22XB5D35RWZPoFKiRe3xAGb2MGC6kgaMkDsDnIaTlwomu17jVE1H1BDFpXr+IUU/lf13hkZOJp6Wsjf4XjhaiONni0QH0gZwByT6D+IwCXv6I87EdvYk4sJMFAJNlJ5Tmmxchzjq4A5G1Q/Ny+3MwML+1bXuK4VJ3cxI2hc4hEBk1O/UhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2FeINUyDRrJXyO+hSL3QYKWziXCSLvu/Qw/CR2kyXA=;
 b=0Q/SYayBHRRX7Ebr/29jSiV/CjM2WenrvUjsoiDQozJ4MS7yzGBuiBSXfdMm/f/F37mD/133NYMUYhhMvr5o1YSLklQpF3LNs+welY6IJ271MJP7vNXg58q436m89H998AIBljPDcq6cVNqK2W4+gOlTx5dT2X5t+V9zReN1JjM=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SN7PR12MB6691.namprd12.prod.outlook.com (2603:10b6:806:271::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 13:25:11 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::db02:3271:73cf:2431]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::db02:3271:73cf:2431%7]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 13:25:11 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Fix unused amdgpu_acpi_get_numa_info
 function in amdgpu_acpi_get_node_id()
Thread-Topic: [PATCH v2] drm/amdgpu: Fix unused amdgpu_acpi_get_numa_info
 function in amdgpu_acpi_get_node_id()
Thread-Index: AQHZilUhpPxG16yedUunXJI3aGxrCq9hleEw
Date: Fri, 19 May 2023 13:25:11 +0000
Message-ID: <BYAPR12MB4614156D9E922F3D9B03553A977C9@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20230519132319.388311-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230519132319.388311-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ec2c705c-97f5-4903-aeaf-e59f26d44a27;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-19T13:24:43Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4614:EE_|SN7PR12MB6691:EE_
x-ms-office365-filtering-correlation-id: df0d46d5-d2e0-44b9-c747-08db586c7946
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HV4HSqJgfE3/9URrU0uiJqYlceXO6eRG6FZwsMKoLXDFJP20eex8XjadWQARa9ImRjdcMBUqya3p+tnURiwK/ts/pNHxjxECv9OK2f37l9jjGxEJd4SGzV0xG909crYz3F2C+qpiG8NQ+bNdKLtINkM2E8K7iYOjM9YXrbanq3O9l+GdEWzsBBrR+tDHAXGV1HKxKkE8U3NE+nihugJ29yG66k0Uv6m+anJUgciO+sbbzUA5eIzzXlyt3sOOGUisfKiGNkw+12x2nM2MacS/1nEoOY/VKEiZMFldDtooYqlMpknUoU7131laGpNl/hNUr05oeC9XWcKF45GeMxmCYeJIcNWTzcV5WqNYVQTtdSIbhVyPQ35Nmtm29rA8tKJbvWeIk1WmTD3bnNyzyaIjOUErDtbb0GtxACCQcSwjStuDRfkh0YbxrPE9mCQZGeraSO8+V3Ki/czPyCthvX15nXWjlIMQucIXZus8kb2XGQK/Esu8tnd/uucgVUpBaGn/YF55vFXg9GhryVFZaTPS+0XHct3K1/CtYtftXI3ThZ4QAuJc4Y0i1lAU1+KG1SC9QeYYySSfWYR7zEfJk+6WYUHFsGtc4uvu3AkWOq6J2NNZ+LyD53STyqg8KvYtU9vD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199021)(71200400001)(41300700001)(7696005)(6506007)(53546011)(9686003)(26005)(38100700002)(52536014)(5660300002)(83380400001)(66574015)(186003)(38070700005)(2906002)(33656002)(86362001)(122000001)(8676002)(8936002)(55016003)(478600001)(66946007)(6636002)(66446008)(64756008)(66556008)(76116006)(66476007)(4326008)(110136005)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0xyWFhrZEJjT3puSGU4K1RrMU5iUGV4SkRDelJySEdCOEJJeE9kQUtEL1Y5?=
 =?utf-8?B?MVBYUVZibUFsYWRvektNeVppWkUvK0Qrc1NDV3lhT293NWFIWS9tMEVoOFN5?=
 =?utf-8?B?eGFjUkhpR0E4eVllRUxXY2JVNHVMdGJjWjBreDA4ZEFyOHpzaG4zN281WWFN?=
 =?utf-8?B?RWQwbWV0VW8wNVJZcXVWRzM1OHVUMVkxaDhIM0pHSnZ1dlRmZkd2VXVyakVL?=
 =?utf-8?B?RjdOWWlhR1huU0sxZzJYN1hRYXlBSmJ1N1FJT1RpTERrVHhia3VBR2Z2VkdZ?=
 =?utf-8?B?Z1hkQ3h1TFY3UDd4L3pnWU1BM1hVUjdOcklCb2pmbmk3Si9NQ3F0K1EvYkxx?=
 =?utf-8?B?QWRZSEFGUk9EVkdPQXBnKzZGS1plZC9ZMkhUdm5JYWxKbWZvNWI4RWY2d3lK?=
 =?utf-8?B?NHVxbEJsdG5CRWthTUprdVoyL3IzUmZnaGxuOU1UNW1QMUN4MzlUMTd4RUsr?=
 =?utf-8?B?SGhmczdLa3VvbXpTL3JXaFFRYm1rSnYrbm9YUWd3Um5jaUY0eXRjQVZzbjdC?=
 =?utf-8?B?am1IcmJwMkdhZTlXVG9XUWpZay9jejluak16eXREOTBSY0lxcFQ4ZDhPcnVX?=
 =?utf-8?B?SXV2T2c2TnhEL3RnTUlCM2x1akJXVWZOdllmNjQ4VUNvcnUyaStjalR0V2Z4?=
 =?utf-8?B?VU5sQzI0aUVaWFhYcmNBWXlEN285UVl1TUE1cXowcGVHOFlURlNjTFU0RjhQ?=
 =?utf-8?B?Nzd0K205Zmp6RFZXeEJjdnJpSVlVdmhZRFV4RndHUUZyTzNBWXpMcTVISm1C?=
 =?utf-8?B?N1BWUHdLdHhuc0NBNEtVTW9PS3cvcCtFN0hXeFhWUGEwdjUzSkswaEtKY0RY?=
 =?utf-8?B?RXN4Skg1eXNJZ21nNnpGR2FLVWZ2SThNQklKUmhhRWxWS3NjTVVTdW9ySmRW?=
 =?utf-8?B?cGJxUXNqT1cvZldTcGJSUXFYdUZMbmhvOXVXeXBBcHhzaGFya082S1NRMG1E?=
 =?utf-8?B?UUlLZW9pTmQwbm9Tc2xxdFUxRFNybDF4Z3YwbTNobk9scVNRWE84ZVg2VEVB?=
 =?utf-8?B?SHVKMjdXRXZRQ0J5Z1VhT0hXbDhpYkk4ei9rZDE5Y1E2TklqVElpUStieGhS?=
 =?utf-8?B?cGFybENQeGxFK3J0OFBaQTg4aEptZDVmeEpuVkk1NEtNMXBmQStpZ29NMVFh?=
 =?utf-8?B?NlN6SUZTa0RqWWRKVDFWNzJkMkplQ0dBSEVvbHdhdWFnQXZOODVyWHE2SjMz?=
 =?utf-8?B?RTBFek9NRGkwa1pyellOMkZweTBJRU5vVm83VFVIWnBMOURvMXN6WENMY0JT?=
 =?utf-8?B?cTBDd3lQZUxERXpSUGFiTERYbytaQ1gyRXdreTVTZldKNi96RjJKWVVOK0Mr?=
 =?utf-8?B?dUFvTzRPSXlCaEdwZ0NRd3ljVzJYeGlBNmc3NVNSTDFPRjM1OWJ0UG5NZ3pF?=
 =?utf-8?B?M05GQk9zQ1gvRUFaalVsSXlmczIydDVSWU8rWU9QYnJYYUpYR0hJRG04aXJD?=
 =?utf-8?B?amQyUEZKcWtUYWFQVktHbDh3NHFEaXBKSS9SVks4dEpMOVFmRW9pcllyVVEr?=
 =?utf-8?B?RDJyQU91Z0dRWGxWTXR1dE1oSHEzYkxGQXhHWWYxTFhaOEJ0RmFjSG5CVlZ4?=
 =?utf-8?B?YnhFNnVtVmc3RmQwL3NlaUtsczIreGluYUtXTVNZWGxFNGgwSzBCY1lOWnpH?=
 =?utf-8?B?T2tHZ1phaVh3aTFPb1BybllNUkxXWkVkL1BITHFlcG02OWNMQ0dxcmNXYkts?=
 =?utf-8?B?MWUwK3hyRVV3UThxOEVGMkwzNjRvU1hjOS9CVlgzU3JLTWg4YkM2TGZxV01G?=
 =?utf-8?B?dDRnekJLekFjV05oVTl0Y1hCM1FMWVlYbzczeEo1cnM4VTBVbzgvRFQ4aURW?=
 =?utf-8?B?dHpWVlNVcWlEYUxNSzB6U2FzRG51NFU2MWd2N1VKT3VDa2V1ZU0vR09MNXhp?=
 =?utf-8?B?cEVicytHRlNuZTR2dllyRVlkaCtHaWlJQm95TTNCOXJoc1dqRHRwajRHOCtD?=
 =?utf-8?B?N09MT0ljbmZoVk1ET2JPUzZCZE9JRk8vOWxHQ2ovYmhTdTFTckV0dmNZUlVO?=
 =?utf-8?B?T08xZGJJSzZiR09qbzlFQmgzWVlXWXEvUTZGWGZodEhVdGtCZ3hBQWpuMnN5?=
 =?utf-8?B?RkR1cHZkeDFLS1lDZHpQS3haZWRXM0V4d09Vc3loelFFSGhGUCtBMEZmK1Az?=
 =?utf-8?Q?nLpE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df0d46d5-d2e0-44b9-c747-08db586c7946
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 13:25:11.7231 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TXuVh+O0+INEXXgqIkOj1pVgyTcQIs8JAc0s2jqJm6Y2MVV2jmvCL0GIuuj8cZbp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6691
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJldmlld2VkLWJ5OiBMaWpvIExh
emFyIDxsaWpvLmxhemFyQGFtZC5jb20+DQoNClRoYW5rcywNCkxpam8NCg0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IFNIQU5NVUdBTSwgU1JJTklWQVNBTiA8U1JJTklWQVNBTi5T
SEFOTVVHQU1AYW1kLmNvbT4NClNlbnQ6IEZyaWRheSwgTWF5IDE5LCAyMDIzIDY6NTMgUE0NClRv
OiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgRGV1Y2hlciwg
QWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgVHVpa292LCBMdWJlbiA8THVi
ZW4uVHVpa292QGFtZC5jb20+OyBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KQ2M6
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNS
SU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0ggdjJdIGRybS9hbWRn
cHU6IEZpeCB1bnVzZWQgYW1kZ3B1X2FjcGlfZ2V0X251bWFfaW5mbyBmdW5jdGlvbiBpbiBhbWRn
cHVfYWNwaV9nZXRfbm9kZV9pZCgpDQoNCkZpeCB0aGUgYmVsb3cgY29tcGlsZXIgY29tcGxhaW5p
bmcgZXJyb3I6DQoNCmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hY3BpLmM6ODYw
OjMzOiBlcnJvcjogdW51c2VkIGZ1bmN0aW9uICdhbWRncHVfYWNwaV9nZXRfbnVtYV9pbmZvJyBb
LVdlcnJvciwtV3VudXNlZC1mdW5jdGlvbl0gc3RhdGljIHN0cnVjdCBhbWRncHVfbnVtYV9pbmZv
ICphbWRncHVfYWNwaV9nZXRfbnVtYV9pbmZvKHVpbnQzMl90IHB4bSkNCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXg0KMSBlcnJvciBnZW5lcmF0ZWQuDQoNCkJ5IGd1YXJkaW5nIGFt
ZGdwdV9hY3BpX2dldF9udW1hX2luZm8gJiBhbWRncHVfYWNwaV9nZXRfbnVtYV9zaXplIGZ1bmN0
aW9uLCBvbmx5IHdoZW4gQ09ORklHX0FDUElfTlVNQSBpcyBlbmFibGVkLg0KDQpTdWdnZXN0ZWQt
Ynk6IExpam8gTGF6YXIgPGxpam8ubGF6YXJAYW1kLmNvbT4NCkNjOiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQpDYzogTGlqbyBMYXphciA8bGlqby5sYXphckBh
bWQuY29tPg0KQ2M6IEx1YmVuIFR1aWtvdiA8bHViZW4udHVpa292QGFtZC5jb20+DQpDYzogQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KU2lnbmVkLW9mZi1ieTogU3Jp
bml2YXNhbiBTaGFubXVnYW0gPHNyaW5pdmFzYW4uc2hhbm11Z2FtQGFtZC5jb20+DQotLS0NCg0K
djI6DQogLSBHdWFyZCBldmVuIGFtZGdwdV9hY3BpX2dldF9udW1hX3NpemUgdW5kZXIgQ09ORklH
X0FDUElfTlVNQSAoTGlqbykNCg0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9h
Y3BpLmMgfCAyICsrDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FjcGkuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hY3BpLmMNCmluZGV4IDcxNTBjMDk5MzNjZi4uMWE2
NmZlYmY2OTgxIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2FjcGkuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FjcGkuYw0K
QEAgLTg0MSw2ICs4NDEsNyBAQCBpbnQgYW1kZ3B1X2FjcGlfc21hcnRfc2hpZnRfdXBkYXRlKHN0
cnVjdCBkcm1fZGV2aWNlICpkZXYsIGVudW0gYW1kZ3B1X3NzIHNzX3N0YQ0KICAgICAgICByZXR1
cm4gcjsNCiB9DQoNCisjaWZkZWYgQ09ORklHX0FDUElfTlVNQQ0KIHN0YXRpYyBpbmxpbmUgdWlu
dDY0X3QgYW1kZ3B1X2FjcGlfZ2V0X251bWFfc2l6ZShpbnQgbmlkKSAgew0KICAgICAgICAvKiBU
aGlzIGlzIGRpcmVjdGx5IHVzaW5nIHNpX21lbWluZm9fbm9kZSBpbXBsZW1lbnRhdGlvbiBhcyB0
aGUgQEAgLTg4Niw2ICs4ODcsNyBAQCBzdGF0aWMgc3RydWN0IGFtZGdwdV9udW1hX2luZm8gKmFt
ZGdwdV9hY3BpX2dldF9udW1hX2luZm8odWludDMyX3QgcHhtKQ0KDQogICAgICAgIHJldHVybiBu
dW1hX2luZm87DQogfQ0KKyNlbmRpZg0KDQogLyoqDQogICogYW1kZ3B1X2FjcGlfZ2V0X25vZGVf
aWQgLSBvYnRhaW4gdGhlIE5VTUEgbm9kZSBpZCBmb3IgY29ycmVzcG9uZGluZyBhbWRncHUNCi0t
DQoyLjI1LjENCg0K
