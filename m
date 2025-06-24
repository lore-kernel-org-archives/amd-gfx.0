Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1896FC77B7F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 09:18:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADB8910E548;
	Tue, 24 Jun 2025 09:18:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VQiqtXiM";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7387610E548
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 09:18:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdODKv2kbeV9oC4RYvB3yMfPweYnb15oPikXO5LKrApVx6K/NQDONBcUV6rtDO+1Ru2/AdfbYdoP4VGPj0UGjvyj8x/x2GzIpXcc9ObXS3CRTyEqpNHTbovU02isJz/DX/SXfN2LzSVIc6Kn4b/P/v9Zyy9z642yQprVizFiqvaPaiR0azAxfxn4Ey6rZMuk6Kdp7CTJMNrtoQY3N67xKncNLW5/jIX0FIoYBKckdgAEYsXAZxw35K5o+86GfssasPraM2UKJfoCpQb8EkA4b6EG626DsG6vbckAEekN6ONqNCUPNLsoHoIhQv3Vf0k/X2H0mzfCVkS3PJvkcK59BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0D3kM2dzqEyhXreToXKfhL2PbimBf+XOwNsB2SSepc=;
 b=Vt9tSNLf6puEWYOksRjjgrQPxsSlOMMhS54xWE0mKMHx15jipj3KJMC5vq938EwSD6SfItoiXkuKAXtZtDoLUfeqV6IK0ZQsGxTHWR7zYodV1mcwLNykznw5BRhHqB8bsegrv+kepd8+FxvDLON6mxbTcTJWosPBzCWffLN/lun5Momy0zYGaxSRkplek5k1BX63tWVQchgdvMgnd4t+8B3jvgnSL8Xr6CkX7adXu+JEbgqJPI/oru37cI+KEnAwlx8IC7KjjZw0Q0sV8RNo7xYISvZSMuI4zc+MtbpV3lu29RMDubF7Rv8Zlto5hC55SBw/Z51P6TJpNvXVJM3g7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0D3kM2dzqEyhXreToXKfhL2PbimBf+XOwNsB2SSepc=;
 b=VQiqtXiMgE/F91ebKw0yMucaWz0MvWDdbXCunDFZrhqII7h1WBRPwjehnxqrYfw+shnjJ4bjQhZY+5HzZk6JCZcsvFFgNN98c3zx5WqnQDuTNeUGtXFDNfKbO3XVEDuihq9QSH81vnZkacA9i6krsyPo/eosTiABwc6AV9qZsR0=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by MN0PR12MB5763.namprd12.prod.outlook.com (2603:10b6:208:376::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 24 Jun
 2025 09:17:57 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%6]) with mapi id 15.20.8857.019; Tue, 24 Jun 2025
 09:17:57 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Add user queue instance count reporting
 for gfx12
Thread-Topic: [PATCH 1/2] drm/amdgpu: Add user queue instance count reporting
 for gfx12
Thread-Index: AQHb5B3mmHBCVZSpW0+JqkBBeseytbQQ5R+AgAEhu+A=
Date: Tue, 24 Jun 2025 09:17:56 +0000
Message-ID: <DM4PR12MB51521682D8D73D21A0CDF636E378A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250623090439.3811614-1-jesse.zhang@amd.com>
 <CADnq5_OZt-6DYOyNXE2JfexmznBqxbNuEdgeHYOK++OMGF6ZGw@mail.gmail.com>
In-Reply-To: <CADnq5_OZt-6DYOyNXE2JfexmznBqxbNuEdgeHYOK++OMGF6ZGw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-24T09:08:26.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|MN0PR12MB5763:EE_
x-ms-office365-filtering-correlation-id: 9238b771-730d-40fa-ead7-08ddb30001eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZGlkWmNIZE8xbERLTmpzTjlmdXhYb0dIWFNQdnFvZ1pHMldiWVVRdTRGQ2ZB?=
 =?utf-8?B?M0VjMkloaVF4bHVCQmlHZlJpM0wzQWpPNXZEeGk3SXBhNDZHWGluZE5ZQzB5?=
 =?utf-8?B?c1RNZDdqQ3NDQkRiTGhmclE2dTFYVUtUZHpJeXlmVUltOURsT3hKclV3Ujc4?=
 =?utf-8?B?cmt1bWZvNzJGWVBwdXR5Wm9JMk92RWEzd0R4Z2RqQ2Vpd3R1Z3dkU0lhTHRv?=
 =?utf-8?B?MldCdGpLMGRWbE1EeFVNQ1ExczFZU2lPZzV5b0J6SWxyMlM2c29ZdTQ2c0lq?=
 =?utf-8?B?MDM0c2JKZklodVprR1JqT0luS093N0gxNkFCdVp2bmJ1SWR6R1dxT0FjSXU4?=
 =?utf-8?B?Y3VJOG00Z3pPcEVZaW9oWS9Pa1BhekVsQXRhWlIwVUhScTlldXBMS1h2eDVp?=
 =?utf-8?B?bDUyakF6YkVmN0RWWk56SlFXSnkwUFNFTFcvV0pWRmhiY3o5a2xQZW1icDZW?=
 =?utf-8?B?OU9wNE9BQ0JTLzlVRXE2U2RVY1AxOWNDQ2xURDRZTC9mbjRSQno0SWJlbGtV?=
 =?utf-8?B?WkNkR1VycVA4aWJ5bVJ5MENhUzV0amtsTlRuZU52MTNIbk9TRGdOYWEwWU5K?=
 =?utf-8?B?R01vVSthTm5zdVFtbkxSblh3djRNRXREenlZZXRMOE5oN1JPelhEd1dKVi9P?=
 =?utf-8?B?WUZhL0t1bnJ6SkVNNHh2T2liVmZmUmc2Ym1lSGVQOWV6SWZHN3J5TDBtUjY4?=
 =?utf-8?B?MXBnWmd2SUx6elR2UVVBTE1WWTFPaHpZNGJ4RDFCbFFkYmVlVU4wb2tMbUdx?=
 =?utf-8?B?bWZQNFhNMnZ1cDUvVUNuY2JnUko2SEl3d29pZ09XRWd0aXBaZy9nMnJidEtn?=
 =?utf-8?B?SDErcFhCREZJSWZvVWpUVXh5Y1ZlemJ1Y0NUTHFiZVhxQkhhc0lZWlJBUEY5?=
 =?utf-8?B?TmZpcGcrMmZCZFAxc2czS0pBcnJrYXlRVUFGNkx2akUxMUt0T0k3K1ArN25T?=
 =?utf-8?B?Yzh1TzlDYXVQTk5IQkR2bXZKK05qVnhwR2VwOWhLeXljd3RDcWVjMTYxdkJL?=
 =?utf-8?B?V0ZBQ2hsWS9WUEc4YU8xMHlKUEFYTjdrV1hUSWpscjVQd3h3WVpmTXBnVkJI?=
 =?utf-8?B?T3BsVDFHVkdKbGRoM2ZOWlBTbFRQR2s2V3RYWVdmbSttT0dPNzlVVDdseWhC?=
 =?utf-8?B?Um5oTVVVSTI3SGNQaXJxalQyN0hRSTlIeG54bzVJL285SFMvSS9DT0JOOFFB?=
 =?utf-8?B?TWVVQzFGTjIrNHlQbzhOeWZ2UWl4dlZXZUlJMVlzbUhnMHdVT1Q3WXRNanJU?=
 =?utf-8?B?YlU4Qm1hRDBXVVYySFgydnNpencxTlFmWm1qZ3JkSHFTb0dPcnFoUXJmOXdJ?=
 =?utf-8?B?bVJlT3dQZ25jRG9CVVp3YkRLZkhDSlRvSW8yMnVyWDJzUTBxRjRZRnNOUm5o?=
 =?utf-8?B?UE9qTC82KzhlUkRlZmg3elFxTUFRSTZJcGZXdDQvREFGalBMaFdqTnJLQ1Ni?=
 =?utf-8?B?aHJYWDZhaEZDejJCN0VlNG1ZcGpUZ2FxZ2owSXEyZHZWZHl0bnZ5L3NhNldJ?=
 =?utf-8?B?V05SZVNMS3cweENFNVNBbmlFMHk5Q1pjZXZSaWNYSS8xWmVDeDhCQWNWZlJt?=
 =?utf-8?B?eDN4cUplcU9abUE4WC9YU1BsWjgvcVgwVTk2V2dEMit2MXZMclBGTXVuQ3Fm?=
 =?utf-8?B?ZFg0VFZ1VVdLT0tyTDFmOWp3akVFaEFYQitPNHd5aXpsbFNhc3BUR2NEbnhl?=
 =?utf-8?B?M3Rpc1BkNG10TlN3bWF4NGxyYlBlTGw3MDFMYkowRDdlcEpiRHhGbzNzMWJ0?=
 =?utf-8?B?QnVITmlKOGRVRmJEZWJjcVVxWURwRk9iREg3a3pnOHFvckg4L2JHKzhiT1ZK?=
 =?utf-8?B?UkdrbmZ6bnA1RGpCZVpXVDBocGxpeTBFR0VnaWpnRHFVcXNIVzlYeFRJMkM3?=
 =?utf-8?B?NStiZ3FIVjdjM3JuSmwzcEl5RjVuQVpSSlA1ODRPcjRoNE8yZ0NUcnlTWmE5?=
 =?utf-8?B?NTdOY0E1TWpXVDF4aU8zZklCVFRQa1c1dUhMTythcVdjZDY5N3JPYVlNZk1W?=
 =?utf-8?Q?CSawuVpdEOyZrvEeQRrVUCQpBs0ehA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTRESTczcWNEQ0syR3YwRENnWlpEcVZCVkliU1NXTmtFeTdVcDdqYXZjTm02?=
 =?utf-8?B?UFlBbWZuVzMwZGZYMElWV2w4SEk2SVZKYnN6M3l2OFo2SkkvRWNMVWpsSjgy?=
 =?utf-8?B?anJxN3Jla3AwUmtrZ3dXZzNvZ2NaMG5YeGQ4QzN1R2VrSHNXZkticFM0dFB2?=
 =?utf-8?B?cm44Mng3cUJrWVRhTFViM3h0MEl3U05pODVnRDhOQndnaGloY2hKMWxxNlNY?=
 =?utf-8?B?TjNJZStrYXd5RUUvdHVQZUdTc1lWV0h3SElTelVoNzh5YzJxSXo3d2x3cXJn?=
 =?utf-8?B?RE9SK1phbEZLZDNUZytmSURtczBIb1JmM1JHU254TkxOVElraG13TkF4RUNv?=
 =?utf-8?B?NmcycnM1UXQ0S0g3aVRKWDdQVktqeGNxWmgwY2FZR1ZwL1IvVVhNdkFyRVpt?=
 =?utf-8?B?Ri9kOTZoRDZjWk9XcnA4WHdxb0VyL01FOWI0QkRJS3ZtVyszSHhXTGZGb0py?=
 =?utf-8?B?M1pmNmJiZUh4N3d4N0I2c0p4bGdZdldLK0Q5TXY4WURCT3pCblBjbkNFUVNV?=
 =?utf-8?B?WERoWFpySWxPRHF1N1lKb0dOL002by8rSmxJYXdSajMyci9sbHNUTzdUY0Yr?=
 =?utf-8?B?Z0NKSmlZclBMNmRmNkFvL0RGMS8xNmRCVGRKNnI0d3o2dzlPbVJNRXJGSmZH?=
 =?utf-8?B?anZWMjV6RXBvRit0Z0p0T2VWekdnQXkzRmZDUXI1bFl4N2gvV0dtQ1lMQVYx?=
 =?utf-8?B?M3FVRUNXbHBobzVMSytPRm1MaUxMVks4V1k5ZGVLcjJwb0xUVHZkZVRxS1Rv?=
 =?utf-8?B?em1kWmVJZFNlL2l3ODdyMEZlSDN0SzUrZFRjdllWS1p5WURXUG14VHhVTDY5?=
 =?utf-8?B?ckVEdGhNMU0yTFpHWEhrMXJLaXY5WVNqc3ZyZVJMSzl6U21MWFpDVDNJOUs0?=
 =?utf-8?B?MDdmVXFYalBXd3pMeEhkajhqcjRJNE5nWElzcXJHM3l2TE5HSzMzT1B2RGxN?=
 =?utf-8?B?b2ZQdUpSNnZZWWp3NlpEL09aU2F1QUh5VTZiK25Xa25iYkNuYUlMb0VDZkdn?=
 =?utf-8?B?ZVdEQmRvUkgxTXNsZWJSUWhFMDMxaHBKRlpha2lFeCtzdENYQ21NeTI1LzNQ?=
 =?utf-8?B?WVJFZTBqclFlTFJqSTlDMzFndjhRWmVpZCtSNVNJZGtPNUNoSnMwSTgxdDVC?=
 =?utf-8?B?M0dSUUt4OXhEQ3E0c3VkVHBiaHdSM3czUU42ZTFGZzF5SllsSU56Q010QWZz?=
 =?utf-8?B?ZkVaYlNBVXo3aENnZXE4WlJycDBMVUNXSjZWcGd3bzBQamNuaVkrL21vVVJs?=
 =?utf-8?B?RlNWWU5nc3dsWEFxOE93YnVJUU80Qk8zdi9waGJjQkVCVW9GT01Sd3RiYlI4?=
 =?utf-8?B?eU1sbml0NVBOSjZwWHhMM1YyV1hOWEJlV2ZERXFrOEd4WTdNNk0zdGNQQXFj?=
 =?utf-8?B?aDd2dTd4NVk4ZjY3SW5kME5xNmxsOGc5cjRmK3FlZU1rRUNka01ESTgvT0dR?=
 =?utf-8?B?NitVMHlYTGg3OFk2RXFpSjFONW5XaVNUUUZjUXZNMXIxTHpJdko5aHFnSXlh?=
 =?utf-8?B?Q2Nkczg3UHJNQmo1SUViN2tWV2ZUTko2a3FqblZDUkhiaVFoNjY2d0dJdUFV?=
 =?utf-8?B?WXdQdDMvak1KWlY0L2VRQ04vdlNqeUk0cll3YldSRVB4SjBmbTd3QmxiUEZI?=
 =?utf-8?B?a3Z5aTU2cy9RZFQwZGIza3dTVmNncnRnNFFUR3Ria1VUa2d5WE5MS0xWVEtN?=
 =?utf-8?B?MUQ2aW5VNlh2aC9iVlpQL1VJelRRb3FCUU5IM1cza0dsYnlKckF2MjRtNXVm?=
 =?utf-8?B?NnNsQjhlV1VJMVN0c0IwRVkvMjA1d1FZZFZ1bm5NWDVMU21IRVlnSDg2S08z?=
 =?utf-8?B?RmNDVmJXRzUreEFpNXd5MVh0d05ZOUVyazBQZisrZmhQNHBvT1NvblhTbGFK?=
 =?utf-8?B?RitnS1pjNUlGakgva3poc2hJUWZmMEE1aUtiSjdLZGlIMG5oV0RaMHlIN1l1?=
 =?utf-8?B?Tmh6UUZOMjFEc0gvTnBlZi9oL3R1aVpUVjFhSytuM2VUTEViUG1oUXBveTVF?=
 =?utf-8?B?RHBGZEFUdlJTVk1HWENNYks0STFjMy9KekFxcVpHR0NheGY0ZHgzU2RGdzdi?=
 =?utf-8?B?V0pUWkpVaFpCZTBNaGx1VnpVbk55TmN6RmNVME1peGtmdU9lVnlRdkFuZkd5?=
 =?utf-8?Q?D6tQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9238b771-730d-40fa-ead7-08ddb30001eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 09:17:56.9988 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K/JFgXRpakVsWLcBCmAPvB/96oM19LUwfBx5LWd+5LoC+wMhOJsCSFznJ/8+4mlAuD/esx7O2DoGXD6cp3fEYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5763
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
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFsZXggRGV1Y2hlciA8YWxleGRl
dWNoZXJAZ21haWwuY29tPg0KU2VudDogTW9uZGF5LCBKdW5lIDIzLCAyMDI1IDExOjUxIFBNDQpU
bzogWmhhbmcsIEplc3NlKEppZSkgPEplc3NlLlpoYW5nQGFtZC5jb20+DQpDYzogYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNo
ZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+
DQpTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gZHJtL2FtZGdwdTogQWRkIHVzZXIgcXVldWUgaW5z
dGFuY2UgY291bnQgcmVwb3J0aW5nIGZvciBnZngxMg0KDQpPbiBNb24sIEp1biAyMywgMjAyNSBh
dCA1OjEz4oCvQU0gSmVzc2UgWmhhbmcgPGplc3NlLnpoYW5nQGFtZC5jb20+IHdyb3RlOg0KPg0K
PiBUaGlzIGNoYW5nZSBleHBvc2VzIHRoZSBudW1iZXIgb2YgYXZhaWxhYmxlIHVzZXIgcXVldWUg
aW5zdGFuY2VzDQo+IHRocm91Z2ggdGhlIEhXIElQIGluZm8gcXVlcnkgaW50ZXJmYWNlLiBUaGUg
aW5mb3JtYXRpb24gaGVscHMgdXNlcg0KPiBtb2RlIGRyaXZlcnMgcHJvcGVybHkgYWxsb2NhdGUg
YW5kIG1hbmFnZSBxdWV1ZSByZXNvdXJjZXMuDQo+DQo+IEtleSBjaGFuZ2VzOg0KPiAxLiBBZGRl
ZCB1c2VycV9nZnhfaW5zdGFuY2VzIGFuZCB1c2VycV9jb21wdXRlX2luc3RhbmNlcyBmaWVsZHMN
Cj4gICAgdG8gYW1kZ3B1X2dmeCBzdHJ1Y3R1cmUNCj4gMi4gSW5pdGlhbGl6ZWQgdGhlIHZhbHVl
cyBkdXJpbmcgR0ZYIElQIGVhcmx5IGluaXQgZm9yIHYxMg0KPiAgICAob25seSB3aGVuIHVzZXIg
cXVldWVzIGFyZSBub3QgZGlzYWJsZWQgdmlhIGRpc2FibGVfdXEpIDMuIEV4cG9zZWQNCj4gdGhl
IHZhbHVlcyB0aHJvdWdoIGRybV9hbWRncHVfaW5mb19od19pcCBzdHJ1Y3R1cmUNCj4gICAgdmlh
IGFtZGdwdV9od19pcF9pbmZvKCkNCj4NCj4gVGhlIHZhbHVlcyByZXByZXNlbnQ6DQo+IC0gdXNl
cnFfZ2Z4X2luc3RhbmNlczogTnVtYmVyIG9mIEdGWCByaW5nIGluc3RhbmNlcyBhdmFpbGFibGUN
Cj4gLSB1c2VycV9jb21wdXRlX2luc3RhbmNlczogTnVtYmVyIG9mIGNvbXB1dGUgcmluZyBpbnN0
YW5jZXMgYXZhaWxhYmxlDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEplc3NlIFpoYW5nIDxKZXNzZS5a
aGFuZ0BhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9nZnguaCB8IDIgKysNCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5j
IHwgNCArKysrDQo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTJfMC5jICB8IDUg
KysrKysNCj4gIGluY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oICAgICAgICAgICB8IDIgKysN
Cj4gIDQgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5oDQo+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5oDQo+IGluZGV4IDA4ZjI2OGRhYjhmNS4uNjNhN2Yw
ZTBkYjViIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Z2Z4LmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5oDQo+
IEBAIC00NTIsNiArNDUyLDggQEAgc3RydWN0IGFtZGdwdV9nZnggew0KPiAgICAgICAgIHVuc2ln
bmVkICAgICAgICAgICAgICAgICAgICAgICAgbnVtX2dmeF9yaW5nczsNCj4gICAgICAgICBzdHJ1
Y3QgYW1kZ3B1X3JpbmcgICAgICAgICAgICAgIGNvbXB1dGVfcmluZ1tBTURHUFVfTUFYX0NPTVBV
VEVfUklOR1MgKiBBTURHUFVfTUFYX0dDX0lOU1RBTkNFU107DQo+ICAgICAgICAgdW5zaWduZWQg
ICAgICAgICAgICAgICAgICAgICAgICBudW1fY29tcHV0ZV9yaW5nczsNCj4gKyAgICAgICB1bnNp
Z25lZCAgICAgICAgICAgICAgICAgICAgICAgIHVzZXJxX2dmeF9pbnN0YW5jZXM7DQo+ICsgICAg
ICAgdW5zaWduZWQgICAgICAgICAgICAgICAgICAgICAgICB1c2VycV9jb21wdXRlX2luc3RhbmNl
czsNCj4gICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2lycV9zcmMgICAgICAgICAgIGVvcF9pcnE7DQo+
ICAgICAgICAgc3RydWN0IGFtZGdwdV9pcnFfc3JjICAgICAgICAgICBwcml2X3JlZ19pcnE7DQo+
ICAgICAgICAgc3RydWN0IGFtZGdwdV9pcnFfc3JjICAgICAgICAgICBwcml2X2luc3RfaXJxOw0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jDQo+
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jDQo+IGluZGV4IDE5NWVk
ODFkMzlmZi4uZmYwNWM4MmEzZGZmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfa21zLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2ttcy5jDQo+IEBAIC00MTEsNiArNDExLDggQEAgc3RhdGljIGludCBhbWRncHVfaHdf
aXBfaW5mbyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgaWYgKGFkZXYtPmdmeC5nZnhfcmluZ1tpXS5zY2hlZC5yZWFkeSAmJg0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIWFkZXYtPmdmeC5nZnhfcmluZ1tpXS5ub191c2VyX3N1Ym1p
c3Npb24pDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKytudW1fcmluZ3M7DQo+
ICsNCj4gKyAgICAgICAgICAgICAgIHJlc3VsdC0+dXNlcnFfbnVtX2luc3RhbmNlID0NCj4gKyBh
ZGV2LT5nZngudXNlcnFfZ2Z4X2luc3RhbmNlczsNCj4gICAgICAgICAgICAgICAgIGliX3N0YXJ0
X2FsaWdubWVudCA9IDMyOw0KPiAgICAgICAgICAgICAgICAgaWJfc2l6ZV9hbGlnbm1lbnQgPSAz
MjsNCj4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiBAQCAtNDIwLDYgKzQyMiw4IEBAIHN0YXRp
YyBpbnQgYW1kZ3B1X2h3X2lwX2luZm8oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgIGlmIChhZGV2LT5nZnguY29tcHV0ZV9yaW5nW2ldLnNjaGVk
LnJlYWR5ICYmDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAhYWRldi0+Z2Z4LmNvbXB1
dGVfcmluZ1tpXS5ub191c2VyX3N1Ym1pc3Npb24pDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKytudW1fcmluZ3M7DQo+ICsNCj4gKyAgICAgICAgICAgICAgIHJlc3VsdC0+dXNl
cnFfbnVtX2luc3RhbmNlID0NCj4gKyBhZGV2LT5nZngudXNlcnFfY29tcHV0ZV9pbnN0YW5jZXM7
DQo+ICAgICAgICAgICAgICAgICBpYl9zdGFydF9hbGlnbm1lbnQgPSAzMjsNCj4gICAgICAgICAg
ICAgICAgIGliX3NpemVfYWxpZ25tZW50ID0gMzI7DQo+ICAgICAgICAgICAgICAgICBicmVhazsN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTJfMC5jDQo+
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMl8wLmMNCj4gaW5kZXggMTIzNGM4
ZDY0ZTIwLi40ODI0OTA3ODNhMGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92MTJfMC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eF92MTJfMC5jDQo+IEBAIC0zODUyLDYgKzM4NTIsMTEgQEAgc3RhdGljIGludCBnZnhfdjEyXzBf
ZWFybHlfaW5pdChzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrICppcF9ibG9jaykNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBTURHUFVfTUFYX0NPTVBV
VEVfUklOR1MpOw0KPiAgICAgICAgIH0NCj4NCj4gKyAgICAgICBpZiAoIWFkZXYtPmdmeC5kaXNh
YmxlX3VxKSB7DQo+ICsgICAgICAgICAgICAgICBhZGV2LT5nZngudXNlcnFfZ2Z4X2luc3RhbmNl
cyA9IEdGWDEyX05VTV9HRlhfUklOR1M7DQo+ICsgICAgICAgICAgICAgICBhZGV2LT5nZngudXNl
cnFfY29tcHV0ZV9pbnN0YW5jZXMgPQ0KPiArIEFNREdQVV9NQVhfQ09NUFVURV9SSU5HUzsNCg0K
VGhlc2UgYXJlIGtlcm5lbCBxdWV1ZSB2YWx1ZXMuICBJZiB5b3Ugd2FudCB0byBleHBvc2Ugc29t
ZXRoaW5nIGxpa2UgdGhpcywgaXQgc2hvdWxkIGJlIHNvbWV0aGluZyBsaWtlIHRoZSBudW1iZXIg
b2YgSFFEIHNsb3RzIGF2YWlsYWJsZSBmb3IgdXNlciBxdWV1ZXMgZm9yIGVhY2ggcXVldWUgdHlw
ZS4gIFRoYXQgc2FpZCwgd2hhdCdzIHRoZSB1c2UgY2FzZSBmb3IgdGhpcz8gIEFwcGxpY2F0aW9u
cyBkb24ndCBrbm93IHdoYXQgb3RoZXIgYXBwbGljYXRpb25zIGFyZSBkb2luZy4NCg0KSXQgaXMg
dXNlZCB0byB1bmlmeSBrZmR0ZXN0IGFuZCBJR1QgdGVzdHMuDQpVc2Vyc3BhY2UgbmVlZHMgdG8g
Z2V0IHRoZSBudW1iZXIgb2YgaW5zdGFuY2Ugb2YgZWFjaCB0eXBlIGFuZCB0aGVuIHBlcmZvcm0g
Y29uY3VycmVudCB0ZXN0cywganVzdCBsaWtlIEtGRFFNVGVzdC5BbGxDcFF1ZXVlcy4NCg0KVGhh
bmtzDQpKZXNzZQ0KDQpBbGV4DQoNCj4gKyAgICAgICB9DQo+ICsNCj4gICAgICAgICBnZnhfdjEy
XzBfc2V0X2tpcV9wbTRfZnVuY3MoYWRldik7DQo+ICAgICAgICAgZ2Z4X3YxMl8wX3NldF9yaW5n
X2Z1bmNzKGFkZXYpOw0KPiAgICAgICAgIGdmeF92MTJfMF9zZXRfaXJxX2Z1bmNzKGFkZXYpOyBk
aWZmIC0tZ2l0DQo+IGEvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmggYi9pbmNsdWRlL3Vh
cGkvZHJtL2FtZGdwdV9kcm0uaCBpbmRleA0KPiA0NWM0ZmExMzQ5OWMuLjgwODIyNzBhN2NlYiAx
MDA2NDQNCj4gLS0tIGEvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgNCj4gKysrIGIvaW5j
bHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgNCj4gQEAgLTE0OTMsNiArMTQ5Myw4IEBAIHN0cnVj
dCBkcm1fYW1kZ3B1X2luZm9faHdfaXAgew0KPiAgICAgICAgIF9fdTMyICBhdmFpbGFibGVfcmlu
Z3M7DQo+ICAgICAgICAgLyoqIHZlcnNpb24gaW5mbzogYml0cyAyMzoxNiBtYWpvciwgMTU6OCBt
aW5vciwgNzowIHJldmlzaW9uICovDQo+ICAgICAgICAgX191MzIgIGlwX2Rpc2NvdmVyeV92ZXJz
aW9uOw0KPiArICAgICAgIC8qIFVzZXJxIGF2YWlsYWJsZSBpbnN0YW5jZSAqLw0KPiArICAgICAg
IF9fdTMyICB1c2VycV9udW1faW5zdGFuY2U7DQo+ICB9Ow0KPg0KPiAgLyogR0ZYIG1ldGFkYXRh
IEJPIHNpemVzIGFuZCBhbGlnbm1lbnQgaW5mbyAoaW4gYnl0ZXMpICovDQo+IC0tDQo+IDIuMzQu
MQ0KPg0K
