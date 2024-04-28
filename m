Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258BCC4345F
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Apr 2024 10:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2AAE10E71C;
	Sun, 28 Apr 2024 10:19:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QG4dlB5O";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 040EA10E71C
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Apr 2024 10:19:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNZmK6HdySMUyDifZsBB94M6ELzmeAxXQ6hXql6wxWeH5nlg8ek1Ip/lZyVKXeVohAGOZMn6vc9b+13VS5aG2NuVn6s0WydGFJFmxdSRzXsZ9BZw1CCIFAPcvrFQPY8eBC4XXSRl01zv507kcWV8JCN7/G57SqknBfB7na6ZSxYI6YuONbyb1Hg6NaPAXHNJYUAiFyVgIA0HWQSaqVMNL93bNE21Y7iVCFLarXDbx2UTkmb90qWccAsq0j07R6fghzqRkJH8a+c9IgFtcRXeSfw9MoBTPkrFhSGLn4WIYuf6rwyHEdf8tJKKJPQM7xmyLOE0df5rWv3XVXzvlGwmmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORNwuKhecqxiy8egAU9D954BY+3Bs8LrbXiOi7T+9kM=;
 b=PXmvhrHNSpyrUYxgZq/Y3kUZEVq+FT1sSaH/OT80XPuHx3nsKERrd1qngFaK3PkmjmecCHklkq6u9Gg04XNoAM6VjJRn1suPYTek9fF3OE9adtAdQi5iBR71QncATtALlOtBo3BC7nLnxcgnPSQyXZnwBLbSvdwj+QgSJ751pr57ni8uHqjv1hnwmWAnQM/bRMM7lmMc5gCZWm8Tvk+izVmq0Po961e2BIPQsZsmXKu9nx8GSp9QkIl3Y7wEC/cPfdd0Q+5VaCPAQT9SkxfE/qocrlxn0nrfrpSyWOWwkgiPzeLp/F38/+FNOMFWPeMWTx6OzeySPITkIdxGIQA/mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORNwuKhecqxiy8egAU9D954BY+3Bs8LrbXiOi7T+9kM=;
 b=QG4dlB5OHZrVUQc2m5FlTvJnXO0Huf1QL1B5WBVZyylkDK0/0GsirqZWEakNG6rwT5GRq9qLMvLURxNlkp01feUC38MbirkoDpJd9z89zg3gjzUDSdSsamaY5l7+7xyj3WU9qhKipTBgAZccPWTVaDb7MlzG8rOc119rg/lGMts=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by DS7PR12MB5838.namprd12.prod.outlook.com (2603:10b6:8:79::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 10:18:59 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 10:18:59 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 3/3] drm/amd/pm: fix the uninitialized scalar variable
 warning
Thread-Topic: [PATCH 3/3] drm/amd/pm: fix the uninitialized scalar variable
 warning
Thread-Index: AQHal6t2a6OEd5aykEmK93+aZh5SorF9eTsA
Date: Sun, 28 Apr 2024 10:18:58 +0000
Message-ID: <CH3PR12MB8074614FD37563EA0B3E0D88F6142@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240426072913.1063000-1-jesse.zhang@amd.com>
In-Reply-To: <20240426072913.1063000-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a83844d6-766c-4967-b675-6668b59de7cb;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-28T10:10:24Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|DS7PR12MB5838:EE_
x-ms-office365-filtering-correlation-id: f23168cd-7959-42ff-bde7-08dc676c9e4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?UDNuejBWVlZQN1FoV1UrRDJVODQyTjB6WXUvMFlKM1ltMlczNTNaS3k4ZnM3?=
 =?utf-8?B?YmZwM1pXNzBvYXRWQ0FaYmJtZXBGT25BQjhXS3JuSTFIUTQyMjR4bnV6OFpK?=
 =?utf-8?B?UWo2ZWZ0Z2ZVblNtL3BSSEMycGRkTzJPVGhqdmszMkp5ZlZYak8zWjJWL1Az?=
 =?utf-8?B?enA3RGtQRHh1VFpSU2hJL1k5ZFdMLys0b1lFemlDc3JGVWlwMk8ySXovOThq?=
 =?utf-8?B?akE3SUVYT0h5NTFNVEVTKzlmRnNpdi9sR2J5WG9NZkk5NmUyVFFkOHdhVjAy?=
 =?utf-8?B?V1AvWDFlV0grb2grMXdKalBaVW5iejkyRGc2S2lpUmpaMTZvVTErd3Z3cytk?=
 =?utf-8?B?M2o2K0JyMnQyZlRkYVc2ZFh0aUJCVjZ5dS9hNFBTazNNVXdDaHFyZ0t6T0x6?=
 =?utf-8?B?K2lRQlhGYm91RllLZzd6cUpzYVJKL3ZPYVZzOUo5N0RQMDNmdWJLVmNwSkRy?=
 =?utf-8?B?NGg5S3ZIa0FYVElJL3MvVmtvQjR1bmZTZ29WWWg3NTFVMTF5UHh0dkZvSUlp?=
 =?utf-8?B?U1NsWkw5cWkzTG5mYUFqK2tBbkkya2dkT2JRVFhUYXl2cUtROHJFU0NhYTI1?=
 =?utf-8?B?TzI3d0hxKzhpRHpFTkRnMVB1RGIyeEtrdTlxa3ZaV0NSc204NnZOUWhmK1ps?=
 =?utf-8?B?ZlZ5Rmczdld6T216RHBMY2FzNUVBREllVFNCMDh0bkNOZjBPK21DNk54SzZB?=
 =?utf-8?B?OFV4L2dBYWNPNkVjUHZMSXV5WmpDaDdQYk9YcGg5eFp3NXVXVHd4TE85QWg3?=
 =?utf-8?B?dFRrN0tUUFJwbHBqRUY0Kzlmd2lpLzRXcmg2Z0hkMG8wbHF5U1pIR2xpZHZF?=
 =?utf-8?B?TDlQMWs5Ly8rL0tTQVRzcGhjL0tKZTkrSEZJSDAxLzNyRGZsL05JVHdRYVI4?=
 =?utf-8?B?am8wRXIzTzRvQjEzMmlqN3NjazBPY1RRUElhK2xZc0lsNXdIQUI1eWNrZDhO?=
 =?utf-8?B?ZUpWU1hkaVNJMTFhUVVNODR5KzgzcDFUYUVmbzJkWUNURVlpYVI0SnBVdlpa?=
 =?utf-8?B?WGljR2w0UFU2MzZsTlBBRWRVbGxJQ1lQZFhsZlNxTktsV2YvWnJjcnExdXhn?=
 =?utf-8?B?QjkvTzdxR3YzZ01pQldDN2IvU1E2czNBTHhZTmNweGZKRFl5aG5tRDJIU0F4?=
 =?utf-8?B?L0xFdlY3ZXMrSDYrS0xUNHhHWm1kVzRYMDNrS0Z6eVdZTE5RSHRNbHZQM254?=
 =?utf-8?B?NHd6VWpZckRSa2tzaVFQRkRDbEIxZnljWlUraVlxUGYySTMwUVRXaDgrRzZu?=
 =?utf-8?B?SXlwRlNrK1lYc0ZYa2hIZjlKeldZNDF6aXdUcDFaTzZZY2k4SlFlWGI5aHZ0?=
 =?utf-8?B?YnRoTjUveTB3bVlxSWRFSHFaNmNWemxQU1NtL082aUo2YkFEQmN1VndvaW5l?=
 =?utf-8?B?bnYxc2s1QTNHTVhibEF3OGVYbW0rYlBjakRTMjZ1bzVzWGlQOXRmRzZRdW1E?=
 =?utf-8?B?YXpsK2RBY0VYK1UrSjFhYW9yUUp4OWJVUmd3ZWhBT3lFamFHZGlGcExRTjh2?=
 =?utf-8?B?TGxPTVdubjZaR2ptUXVOZ0N0UEVCbVJPVEp4TXVVTWdVcGI3UWYwVVA1ZUlZ?=
 =?utf-8?B?NmdHU0lvWXdTTCtSWXNldWRrZXE5Ujkvc00rdEMwalU4MDV3ZEl6YWFVdXBx?=
 =?utf-8?B?UmUvQ2lubE53U1NTT2xBZlpkZ214Yk94Y2E0Rlkwd3FxZ0djYkFmM2RabkZF?=
 =?utf-8?B?T013NkpPRVF1MWtxeUlCcHdsRHR6dy93S3pyK043d1gxdkM2ZmxPMVdYdUJC?=
 =?utf-8?B?ZEJrUURiM2paUTh6Nk9pNDkwVitYVG5pRURDUCtFZjExWGFha3FuY0E5ai93?=
 =?utf-8?B?dVVDRk9BSTdJOU81YzRvZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWRmRzhFUTIzQXkva0F6bHJocWVSY2U2cUtLUkp6dmthcGFReDJKWFYwYXlk?=
 =?utf-8?B?NzZPajFQdGNjMnVnWU1CS0hkZzF4OVBNdklVM3g4bWFnNjNGb0hsV3J1enVF?=
 =?utf-8?B?OURvaU5PQk1NV1JVdzdGMU4zeEpmTEFjYTIzRDNsdHZJTVZnNDRwSkJiSXUw?=
 =?utf-8?B?K1V3Y3Bid0JLTEYrbWNqc0lZcHRoOWVvQzU3N3Q4b1gyVm1kL0d2bHUrM01I?=
 =?utf-8?B?d2N2VU5DYjZkR0wwbzFSajE0VXF1WWVpL2p2RTAzWmZqMm1IV2JDeGJieGtW?=
 =?utf-8?B?THB0SVpzVVRKRDg5NWN0S3VBa2RJdytFbzg1TGlZTHhlSnNMeXRKblVGQWhY?=
 =?utf-8?B?VWJzZWhEQktrd2dIR25DbGRYOUtYejlpaExKY2NIc1R6R0IrbVZFKzhJc1VY?=
 =?utf-8?B?cTFWd0xqcnBrbzFXZG5FZXhJYTdEVXhycFUyTTFINWtvaXNnbytxT2NDUW16?=
 =?utf-8?B?UmFSejJvNmRkUnkwMDdKK01yQUFPOTIycHRha0l3UWNhaUcwaFNKQk90bVdJ?=
 =?utf-8?B?bjBqa1J4QzNiNnRaQktySkVraFdvMVVBTDh3Z0ZKbzdwRG9RaWszcUxWd29J?=
 =?utf-8?B?T2NIaHRiNmdCRzNDaXlEYkJnOFlZY3UyMEkvZVlLTWpqRDZZamFWTGEyYTBl?=
 =?utf-8?B?OUZzdFRoSUdGbGhmc0QzOGp5elFSa1BnTnhIcmorbmtqcjJVS2lvYmZFdWF5?=
 =?utf-8?B?NGljckxPcWx5WnByQjI4ZUp3VU1GUUk4VzVrc2FVczRQZHUxWkhEREdLMjNO?=
 =?utf-8?B?anVlQ1d2aUhJcTJseTdHaURQL00zaEVIS3JpREREbjIzcWg0aE9sOXBBUm9T?=
 =?utf-8?B?UjFwdmNUMkEzcjZCY1RCbWcvYWJFZFJBdmx6Q0xFZ3plNXBKUmVDSEZWSGND?=
 =?utf-8?B?NXBpSEJNQ29IRTlWL2JZWWhzSHYyOER6bXRDczczc1ZWbHovK3d0YVd2Sjkv?=
 =?utf-8?B?Y1lVWFFFRDMvYUlrNE85eXVrOXUvYnRmNkpBY2d3V2o2Qk5naVJMOFBxS2VG?=
 =?utf-8?B?aTFlVlB1Nm5BWFBpblJ1ZHFkbHFqdnpsenptSjMveWF2MnVROXZjLzZJcVc5?=
 =?utf-8?B?dWN3UWVRN2J6RDFycXp3VVhTUlpJa3lKb0lDV05YZjNUZ2pKeCtPUzF1TmNV?=
 =?utf-8?B?a3duNVg1R0FmeHRRaVkyci9PdHJzZUI2eE9aM2cxOEwwMlYyd205aE1QYklN?=
 =?utf-8?B?VXVtdFdyR05RS3NMR0xyRFk1a3hZeS9CTXZ4bGsrZkJmMUhURU00NDNaY1BV?=
 =?utf-8?B?eG1JQzAzTk1GYzVIbWZEcDNUeEtNUDNyZnRBRm1QTVJSUkx6cHZTR1JtN1Rw?=
 =?utf-8?B?M05uSnlMZVE1b1pSRE5GUEtIVDB3VWovT245VVVBLzFRdW1GbjhGLzFaSmNG?=
 =?utf-8?B?QUNncTZyamxCTlpuYmZIeXZzbWxMVWVDQXpwaWhLR3JJb29QRzV4dXpwRTY0?=
 =?utf-8?B?WnV5NkhWUk5US25zcnRoaGxSMGxyTWZ1RjdFalJuZEdVWmxQMFJTSWtVanFi?=
 =?utf-8?B?RWFoL2Y3RjVxNm9YZzBwaEhTaTRYS0xMUHBaUnY1SytQZnNLWDNuWnYyMS80?=
 =?utf-8?B?SGc4azN6dnVJNVdqZ0J1NGF2UDdxaTF0clR2RlVJeHdEUlFlazFQRVZzYVBL?=
 =?utf-8?B?dTNIeFNDWTNxTXRnRDR5SkExQTNpMk5ENXN2RUg5ais1MkkyWm5RTWt0OFd4?=
 =?utf-8?B?RXJKV3owYlBrUzR5VXZuUTNyV3VZdnFROU1DT01wd0ZKZzdMMkY5Q3NScnA5?=
 =?utf-8?B?V1FCUU8xSVlLSzFRSE5UZEtFa2h2TFhiY0xUS0pkenBuYjhJU2lNMjBCeFNj?=
 =?utf-8?B?NVh6azhzV0o5SUQxQlo1QXRCUWdENTVsc0ZNY2svZkxrVFlKZFIvVXh1Ri8v?=
 =?utf-8?B?cFFCMmNBUDdaMEkwR2JybHY2a1ByaFZ2SVg3STlHVmpQa1RmSnNpdXFjaDlM?=
 =?utf-8?B?VXdOMG5hT093TnFSUENTQURYVkQwb1ZTVzNLWTdoRVRWVCtLOFlKUHlSZEty?=
 =?utf-8?B?bVMwdEprTGZpR0FocnpIZU9uZXpWUjJabXRwa0FQQXpYQ2I1ZDZuOEhSTWVD?=
 =?utf-8?B?ZElzRzVqbWFUd3dzN2ZycklRaVQyRlB4dmZUNTJsektaeEhtc3V5a2RHb3VX?=
 =?utf-8?Q?9uaQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f23168cd-7959-42ff-bde7-08dc676c9e4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2024 10:18:58.9266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fKbHKBWODvWZ1nhMR7+Jh8HkJXNjCWh2ZMeucJ4wSFXai2XrSd4dizZLLocIIt70wHIY2tge+hIogeCMM+v6lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5838
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogSmVzc2UgWmhhbmcgPGplc3NlLnpoYW5nQGFtZC5jb20+DQo+IFNl
bnQ6IEZyaWRheSwgQXByaWwgMjYsIDIwMjQgMzoyOSBQTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNo
ZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5j
b20+OyBIdWFuZywgVGltIDxUaW0uSHVhbmdAYW1kLmNvbT47IFpoYW5nLA0KPiBKZXNzZShKaWUp
IDxKZXNzZS5aaGFuZ0BhbWQuY29tPjsgWmhhbmcsIEplc3NlKEppZSkNCj4gPEplc3NlLlpoYW5n
QGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAzLzNdIGRybS9hbWQvcG06IGZpeCB0aGUgdW5p
bml0aWFsaXplZCBzY2FsYXIgdmFyaWFibGUNCj4gd2FybmluZw0KPg0KPiBGaXggd2FybmluZyBm
b3IgdXNpbmcgdW5pbml0aWFsaXplZCB2YWx1ZXMg4oCL4oCLc2Nsa19tYXNrLCBtY2tfbWFzayBh
bmQNCj4gc29jX21hc2suDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEplc3NlIFpoYW5nIDxKZXNzZS5a
aGFuZ0BhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211
MTIvcmVub2lyX3BwdC5jIHwgOCArKysrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG0vc3dzbXUvc211MTIvcmVub2lyX3BwdC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9zd3NtdS9zbXUxMi9yZW5vaXJfcHB0LmMNCj4gaW5kZXggODkwOGJiYjNmZjFmLi4xMGY2
NzNiNjUxYTAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211
MTIvcmVub2lyX3BwdC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211
MTIvcmVub2lyX3BwdC5jDQo+IEBAIC05MzIsNyArOTMyLDcgQEAgc3RhdGljIGludCByZW5vaXJf
c2V0X3BlcmZvcm1hbmNlX2xldmVsKHN0cnVjdA0KPiBzbXVfY29udGV4dCAqc211LA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVudW0gYW1kX2RwbV9mb3JjZWRfbGV2
ZWwgbGV2ZWwpDQo+ICB7DQo+ICAgICAgIGludCByZXQgPSAwOw0KPiAtICAgICB1aW50MzJfdCBz
Y2xrX21hc2ssIG1jbGtfbWFzaywgc29jX21hc2s7DQo+ICsgICAgIHVpbnQzMl90IHNjbGtfbWFz
aywgbWNsa19tYXNrLCBzb2NfbWFzayA9IDA7DQoNCkhpIEplc3NlLA0KDQpXZSBzaG91bGQgbm90
IG5lZWQgdG8gc2V0IGRlZmF1bHQgaGVyZS4gSG93IGFib3V0IHNldCB0aGUgY29ycmVjdCBtYXNr
IGluIHRoZQ0KcmVub2lyX2dldF9wcm9maWxpbmdfY2xrX21hc2sgYWNjb3JkaW5nIHRvIHRoZSBw
cm9maWxlLg0KDQpUaW0NCj4NCj4gICAgICAgc3dpdGNoIChsZXZlbCkgew0KPiAgICAgICBjYXNl
IEFNRF9EUE1fRk9SQ0VEX0xFVkVMX0hJR0g6DQo+IEBAIC0xMDE4LDggKzEwMTgsMTAgQEAgc3Rh
dGljIGludCByZW5vaXJfc2V0X3BlcmZvcm1hbmNlX2xldmVsKHN0cnVjdA0KPiBzbXVfY29udGV4
dCAqc211LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICZzb2NfbWFzayk7DQo+ICAgICAgICAgICAgICAgaWYgKHJldCkNCj4gICAgICAgICAgICAg
ICAgICAgICAgIHJldHVybiByZXQ7DQo+IC0gICAgICAgICAgICAgcmVub2lyX2ZvcmNlX2Nsa19s
ZXZlbHMoc211LCBTTVVfU0NMSywgMSA8PCBzY2xrX21hc2spOw0KPiAtICAgICAgICAgICAgIHJl
bm9pcl9mb3JjZV9jbGtfbGV2ZWxzKHNtdSwgU01VX01DTEssIDEgPDwgbWNsa19tYXNrKTsNCj4g
KyAgICAgICAgICAgICBpZiAobGV2ZWwgPT0gQU1EX0RQTV9GT1JDRURfTEVWRUxfUFJPRklMRV9N
SU5fU0NMSykNCj4gKyAgICAgICAgICAgICAgICAgICAgIHJlbm9pcl9mb3JjZV9jbGtfbGV2ZWxz
KHNtdSwgU01VX1NDTEssIDEgPDwNCj4gc2Nsa19tYXNrKTsNCj4gKyAgICAgICAgICAgICBlbHNl
DQo+ICsgICAgICAgICAgICAgICAgICAgICByZW5vaXJfZm9yY2VfY2xrX2xldmVscyhzbXUsIFNN
VV9NQ0xLLCAxIDw8DQo+IG1jbGtfbWFzayk7DQpXZSBzaG91bGQgbmVlZCB0byBzZXQgYm90aCB0
aGUgY2xvY2sgbGV2ZWxzIGhlcmUsIGp1c3QgbmVlZCB0byBnZXQgdGhlIGNvcnJlY3QgbWFzayBi
ZWZvcmUgc2V0dGluZyB0aGVtLg0KDQpUaW0NCj4gICAgICAgICAgICAgICByZW5vaXJfZm9yY2Vf
Y2xrX2xldmVscyhzbXUsIFNNVV9TT0NDTEssIDEgPDwgc29jX21hc2spOw0KPiAgICAgICAgICAg
ICAgIGJyZWFrOw0KPiAgICAgICBjYXNlIEFNRF9EUE1fRk9SQ0VEX0xFVkVMX1BST0ZJTEVfUEVB
SzoNCj4gLS0NCj4gMi4yNS4xDQoNCg==
