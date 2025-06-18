Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5667FC7115B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 08:39:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B185910E7BF;
	Wed, 18 Jun 2025 08:39:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EyoClQFI";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CECD010E7A9
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 08:39:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edReNCGO3K/0stNElHC5mQBDGLE2SNdXIGo9Gx/90n5XjKVrO8joVJJm4Pc8hpWOQRwLAoPP0zbSo9XxdEV0mf99R1J6ovCoo3WWTk0R/7g/wiZAAj4PeeI3aMDydjTSpEl/zBMrMJb03BD0haX35xtRTcDxhEmsQgowVbc8wp0V+Uj7zqPng5NarxxRblGzEdXJNsB2/eeBGuKNcV0GuNdp1PzSS/Vur7x7/Rh++mIisYXLp9P2Ii4QxDARumr/y4tp+tg/N/Qb7v6F5alSE8n1vzXDsgnZQnPm0CkPrxzSWkUc+qgsjOQ8/vMutpdhlbdKktXBBMmAQJnXeUUn+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8rnVSA8HxJmuxKviZ5x2hUC35vb/B+NWPznUAy2wWs=;
 b=v0gKfNAMt2SZAcmlL9qF3582v0BBsLiGkwA5LZnovHeEYtZ/49PB/nWoGrOnkH/+95xwpd4KnFAOVMt/836+iFqHXVvCqb2+9bpmm2ZKsiCLi3SCSMKNDYUboB15VEOvHRbeB321HdYyCOr3AFNt+CGvnNpLR92ELoeTbo/Lk3ZM8gZr5qx3qNPGMZX3K4D/qHF+cfvU2E4J5dHtBSppFAK4rdn+OkV8L2zo4CnlRJoRxwLFxH9HmDJyC+AempKpU/65jZYCSjXLlQxjH4O9S1ZoHZm5+9qWCQcLQiD1CyJ+BQCImaxEZxqolU7PLHbfPy6MRqZFhmTcV/2pOSCvQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8rnVSA8HxJmuxKviZ5x2hUC35vb/B+NWPznUAy2wWs=;
 b=EyoClQFIAN04jELN5rFLuw9ugfwNMJ9dSMAlZsUiT16DUdHgmuS6eEVfzdXdg1uHaLx4V6h5WaE0a4LEStL/9b2yrbC6euOFR04lI/w5UI/u2gQ4uPiV97EdUpaKgmIjIvGB3hnolZ7PoVCiPqxGrec2mQCw37Hvw6gmmwHRWcQ=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DS4PR12MB9748.namprd12.prod.outlook.com (2603:10b6:8:29e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 08:39:48 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%6]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 08:39:47 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [v3 8/9] drm/amdgpu/userq: add a detect and reset callback
Thread-Topic: [v3 8/9] drm/amdgpu/userq: add a detect and reset callback
Thread-Index: AQHb32mCoOTL4+f+A06KTPueZxqdIbQHHWEAgAEYaxCAABpJAIAASFbQ
Date: Wed, 18 Jun 2025 08:39:47 +0000
Message-ID: <DM4PR12MB5152DF1151C8448FF0869800E372A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250617092243.2769580-1-Jesse.Zhang@amd.com>
 <20250617092243.2769580-8-Jesse.Zhang@amd.com>
 <69db08d7-4976-40e8-845e-b125efa9fa9d@amd.com>
 <DM4PR12MB51523E85ACDA7D14C4D12D60E372A@DM4PR12MB5152.namprd12.prod.outlook.com>
 <6b355dd0-f159-4390-b02c-63e793c6fd81@amd.com>
In-Reply-To: <6b355dd0-f159-4390-b02c-63e793c6fd81@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-18T08:33:09.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DS4PR12MB9748:EE_
x-ms-office365-filtering-correlation-id: b99caf07-c630-4cac-372d-08ddae43aed0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZWF6Y0dTRFI3bGhvQnNyaHcvWHZMbkExUk8zcEVQUnhadzFOT3NnNFdOcFZa?=
 =?utf-8?B?SFZkL1hyeEZ0QjlQdVpGV3BtRTFTaGVMbVFlcm00bFdpVlFvWDJuYTR2d2xW?=
 =?utf-8?B?eUhQQjZvM2lxRUdjTkNXUUVBL05TSjdTVkQwOUZlRDAxZzVacHdzWlVYTHc5?=
 =?utf-8?B?Nk4yNDdQVjl4Y2poN094b1g5bmo2VnNSZnpSZlNWV2ZLRGtPL2h0SjAwSTBW?=
 =?utf-8?B?QXNaK1JFdHk5YllmY1NML2N3WVF5OXhFSWdyQU5BVklYYUhUQmZGdTNYYkhP?=
 =?utf-8?B?dkdrVlpSc21maU94VzY5SEJXNTEzQWJBMlpPTCtKUjJsKzZHUkxNTzVmaWQ5?=
 =?utf-8?B?QU9WMzZJanZ5ZjNlai8xbDYyQnZGYWRrOGZRWmUrTHRGMlVnSjBBTWc5aWZM?=
 =?utf-8?B?anA5VEFEU1JIUnFwczF2T3dnTUdZOFd2K0lUcml3VHpjclIraEFFcWZuU3g5?=
 =?utf-8?B?MDVWVkN6UWxnVFBoZFdjMVhNbnpQWjRnUUlTWk5YbCtoem1lekVNalc5bHl6?=
 =?utf-8?B?UDBjQS9iL0RMZTUvM0s5bG5wWjMxTmxpa0ZQazgrVGpuQzJGVU5hSDVmc2pJ?=
 =?utf-8?B?aFNMRmptMDRiLzFDR3ZvTGF1MmxXZ3RyWVQ0eGtySU5PYnBkMjhaenZoVVo2?=
 =?utf-8?B?dVcxWkxydjhlRkxlYTlmNUl3T0I1cGNBcjd4bVJ3TFR1d1d5MFNEQkFMb01E?=
 =?utf-8?B?VzEra1MxcmlaMGUvRHBWcys2ZHdRcndkSXZrV2cvVTB0Qlgydm1HWm1va0hy?=
 =?utf-8?B?L1p0TlVhcUFPUmJFUGpCQTJQMjUxRWtVM3pndGNxQjVPWkk5Y2pYVVdOdzB2?=
 =?utf-8?B?WllLMmN3R2ZmSEQ0Q0R5YUk0aHlxNmgvZmY2c04vVVRoNHBaNE0zN2h4TXJ6?=
 =?utf-8?B?SG85UG5iL0lsbFJTeTlBWitpSXpvY0ZMMTR5dDVJWS9jU1pwZ2xveXhQTHlo?=
 =?utf-8?B?SVpKdmNCZ2pWdUxkcFJQWmF6TUNTVGlhV3dJdlRNWGNWSGxSenhKV1l2Q2Zr?=
 =?utf-8?B?NzBNN2xRNHM1R0ZhVlZUYXZUTzdaQmVsUEhDVFI2S20xSEk4aGZIYVJmVEpD?=
 =?utf-8?B?U2o2L2ZLUTgxZWRya1hjaGczdDhaY0xxVFAxR2NHUVl1bXNiS0tMZDIxYTJP?=
 =?utf-8?B?K1JJU0J3L1JkR3p4VW96eHFXV3dkR1pUSDdtL0xWM0JjeURwVXFoSy9wSGUz?=
 =?utf-8?B?MGRMSUx6c0Y3L0ZYc25BbGIvc08wUmN0KzRNTU04RkF5Rm56dXM1UlRtdVBN?=
 =?utf-8?B?TklKZ0tTSFR5dHhvY1dFNVBVc2Y3QU5CbHR2dFJEMDFoUk1WTmtFaXZacnVJ?=
 =?utf-8?B?eHZ4UlFHVlJJb2JPaXFYYVdxQkpNRzUycVhnRXBPdFJ6THpCeTlrVFRKYWkw?=
 =?utf-8?B?dnJWd1JQUEdZSmRnellEcis1enl2SHlaeUxnRmJJS3pmWjgxMFcxQk4wd2do?=
 =?utf-8?B?ZkMzelMwSVE0YzVqRUR2QmZVNEk4ZFEwN0lkV3FhVi9EUkxXYjZFK21JQXFr?=
 =?utf-8?B?VDJMTFZKYVRUYTF1aldnbzVTUHVZRmpFUlc4YjZvVzhXRDBBS0pxMmNIVmZS?=
 =?utf-8?B?RUU0SkRMMjhtRk03TUwydEowcUVjT0lPNEN4c1d0REJkMHBmQi9oNHp0Y2kx?=
 =?utf-8?B?MDFtMTU4SVAvMXdKK1VlVGZ3VzZrZUR0eHUrNU13WUdyU3VEUUpjTDQ2KzZP?=
 =?utf-8?B?T0RUZmkwd292ek1zdUhVdEJmem5xK2lUMEszUnB0TkVJWHAzUjVoak54ME5x?=
 =?utf-8?B?azRpaHhFa2FJcFlKV0hMTjZicVZuc2ZWbXZVdjlwcTBQWFFXUVhhTy9sQkxa?=
 =?utf-8?B?cm1FcjlNRmVUdk1la1hFVm9OQWVGZjZOS2RicTJmUVZBdk05cDBraUNFV1BU?=
 =?utf-8?B?R2tkT1hkWEFITk5JQlpuV1dCbHVySVIvdkhYS2ZPeERKUVAwRmlhRnRHc1py?=
 =?utf-8?B?VWNSQzV4VHFmVVhHRURweERhZWxjT04vUnRvS3VJaXc4S2U1QjF5dVdjUy9X?=
 =?utf-8?Q?wDXuIyDSDZcNe/9Un10sl8DFnGBFDA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eCtCdzZzY214aHVsOWFyUnZTVnc2MTV3MCtxS2h0Tmx2OXAwZzlnN1V0UEFo?=
 =?utf-8?B?SUlsQW8wUnVLbmNQN00xaTN4TXVjRzMxdHZpdmJHVVZ4YWEzc244YTQwYzM3?=
 =?utf-8?B?YzZ5M0VTVGhwWXEyUC9MdCtaUm4ySytPNVZYYkJoV3lGSlRINlhaNWJwRUdZ?=
 =?utf-8?B?ajFiQ0NlYXIydWwxVElSaVIrcEtQTEdxcWJUays3eVVJMGxWYWNvQUJjQjVJ?=
 =?utf-8?B?UFJvUkhMSFY3dG90R3JHdzU3RTcySSsxV3BZVXdqWjArSVdHcEZHUzhkWnJa?=
 =?utf-8?B?cnRzU0YyY1d3MjBxcVoyUHZjOHVneWU5b05FUk9pQ0VXOFppdUZIOG1aU3dI?=
 =?utf-8?B?Y3cwYzZCQXRqN1A5c2JhSTZPanRBQ1FMS1ZjVnYxemM2MWNla2ZWK1ZQRDZm?=
 =?utf-8?B?d2VLMGlnem5kRXpvaXZHcmJqeGhjYm9XYTlpZ0dyR0llS0NOVktaRzFhKzhC?=
 =?utf-8?B?S250ODZsVERNTHVDYUdZSEJCdzByMUZqaHIvYjhDK0NlaTY1MzBVeklYZ29H?=
 =?utf-8?B?a25rcU9Fc0ZrWldyaGg5aW9KYW5LRlEyUVl6QmltT3JtalJ4NVFrODBZdmNl?=
 =?utf-8?B?Lzl4UGthbnVwMElnYUdKMm1GTlhyTlFzWGIzZ1BueTkyVjVCbHhCYzFjVGZQ?=
 =?utf-8?B?ekJCZml2OU85VnplNmZObzVqV3EyZml6MHI4a2psdnk3eDZwVm52RERkYkk5?=
 =?utf-8?B?WGZUbHBTU2U1N2x1cDJkN2pBRm9uMTRzWDZBeUFqZHN4RU80ZDNvblVneWRL?=
 =?utf-8?B?SDVxc3laNnhXT21EUFdVbkQxNU04aDBDdVVnMWVmZ0x6L2FKaG1VdE9va0Nn?=
 =?utf-8?B?L3cxVXdCbUMwSkU1Z3JkZ1pDWTA1dW8xR3RtYW5RamoxU245Wm9GcjZhbEhI?=
 =?utf-8?B?SG41M3NhaGI4N2RraVhZT2ljL0trQ1FlaktaS2F5TXNIVlVYOUVZREFMYUFt?=
 =?utf-8?B?SEwvd1Vid2dIZWYwVzAzcGV4TE5ZSXRaV240UHZkMFlZcXQ3MjJFclEvNEt5?=
 =?utf-8?B?d0M0WmdIck93c0dqZFFCY2Jlc29hLzdVWGpEM3YzelNGTWQyb29oT1V2R2RY?=
 =?utf-8?B?bG52YUdMOUpRV3VyWGhiSDRNUUNIUkpRc21QV0doY3FhTTRuSVdCNTN1WExt?=
 =?utf-8?B?TEJPMkNsTUp3dHdBNk9TeWZYMVZPYklsSVNLT1JCWFhleEMra09pZGx5bTlT?=
 =?utf-8?B?V2h5Z3QvNUMxR1NKU2FXQmk3dGx5eVUrbW43dDRLNXZ2cTFUMXdWa2JmWHBJ?=
 =?utf-8?B?alU0YmN6WXlqb1NJQXBRcTk1SkRTaGZtenFqcEFLbE85ZFcwajBvRGg0ZUdG?=
 =?utf-8?B?MGw2MVNPWjQweDRmL3FzU1E5VGptM0ZYeXV5Ly9YMzlqb1I4OG5abjZSU0NF?=
 =?utf-8?B?a2wxaCs3dCt3Z2R5akRNTmpoVnNnQWhkdTg2R2RMMVlXZDdnM3NKbWdNbDU2?=
 =?utf-8?B?SFBVeXU5bDEvR1ByM0lmZ3BDbGpPeHd6aVUzenhZSjQxUWZVQ1lZeUNwY2Rx?=
 =?utf-8?B?MCtMaWdrcFNMWVJIRGpMUHFMdlhFZ1lmNnNPZVlzaVloZnBoZmEreTBNcVhB?=
 =?utf-8?B?MEZLckkxaGtNUU9QemN6Znd2N3pmbjFqZjhhaC9sQXljU1NuUCtJR1dxbk5r?=
 =?utf-8?B?bnQ4WDUyS2RBVkZvdEpxWDhNSnp4ZnZremRWdm1CNUg4RFRjSmZEeE53MGdt?=
 =?utf-8?B?ZkgwenRZRkg1cTFGU29zOEVCbEtBd1lNRUk1SWlqbFA1VWd3TjBOT3hGS05B?=
 =?utf-8?B?dUpUWC9ZUEZPVzVTVm1adk16M2FKSHVNa2I1NjNXcTNTUE0wRVRMV0ZHL2RG?=
 =?utf-8?B?R01uMzRxaTRIdjJEOSs4L0N1MjIxYnZPWU9tZVVmdmZKM08yQ2U1QmkrbU4y?=
 =?utf-8?B?eTA1bDBhZ3IySEpzbjNTMWprTFhHNnpEVjFadDhKeS81WHVMdkJ6YURCODNW?=
 =?utf-8?B?QWQvVEo4cEovZG44Wm5GcVR3blNtNkREQjQzdWxzVDcyczVxVXJ4RERiNWJH?=
 =?utf-8?B?WnUrTDZZTXdUTHdHakpka285QllaTWFNa2N2MEdFTDRSR04venBWeTU1Tk5G?=
 =?utf-8?B?N0lab0c2ZnZVSHhNOVdyRWhrTmtDSzYzRlBCcS9yell5SDdJQXpkZ1Jja1hC?=
 =?utf-8?Q?+6QU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99caf07-c630-4cac-372d-08ddae43aed0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 08:39:47.5205 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uvbxfdqaSM5AxUrlYSWqaAuF9qel/7pQ/IG5pBnqpaC19PIJWZen771yIkSgHHrK7H7u9uI4EghTRDW4PFWqpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9748
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
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExhemFyLCBMaWpvIDxMaWpvLkxh
emFyQGFtZC5jb20+DQpTZW50OiBXZWRuZXNkYXksIEp1bmUgMTgsIDIwMjUgMTI6MTQgUE0NClRv
OiBaaGFuZywgSmVzc2UoSmllKSA8SmVzc2UuWmhhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnDQpDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hl
ckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4N
ClN1YmplY3Q6IFJlOiBbdjMgOC85XSBkcm0vYW1kZ3B1L3VzZXJxOiBhZGQgYSBkZXRlY3QgYW5k
IHJlc2V0IGNhbGxiYWNrDQoNCg0KDQpPbiA2LzE4LzIwMjUgODoxNCBBTSwgWmhhbmcsIEplc3Nl
KEppZSkgd3JvdGU6DQo+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwgRGlz
dHJpYnV0aW9uIE9ubHldDQo+DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bmUg
MTcsIDIwMjUgNTo1NyBQTQ0KPiBUbzogWmhhbmcsIEplc3NlKEppZSkgPEplc3NlLlpoYW5nQGFt
ZC5jb20+Ow0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwg
QWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4N
Cj4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFt2MyA4LzldIGRy
bS9hbWRncHUvdXNlcnE6IGFkZCBhIGRldGVjdCBhbmQgcmVzZXQNCj4gY2FsbGJhY2sNCj4NCj4N
Cj4NCj4gT24gNi8xNy8yMDI1IDI6NTAgUE0sIEplc3NlLlpoYW5nIHdyb3RlOg0KPj4gRnJvbTog
QWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPj4NCj4+IEFkZCBhIGRl
dGVjdCBhbmQgcmVzZXQgY2FsbGJhY2sgYW5kIGFkZCB0aGUgaW1wbGVtZW50YXRpb24gZm9yIG1l
cy4NCj4+IFRoZSBjYWxsYmFjayB3aWxsIGRldGVjdCBhbGwgaHVuZyBxdWV1ZXMgb2YgYSBwYXJ0
aWN1bGFyIGlwIHR5cGUNCj4+IChlLmcuLCBHRlggb3IgY29tcHV0ZSBvciBTRE1BKSBhbmQgcmVz
ZXQgdGhlbS4NCj4+DQo+PiB2MjogaW5jcmVhc2UgcmVzZXQgY291bnRlciBhbmQgc2V0IGZlbmNl
IGZvcmNlIGNvbXBsZXRpb24gKEplc3NlKQ0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1
Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5oICB8ICAzICsrDQo+PiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9tZXNfdXNlcnF1ZXVlLmMgfCA1MQ0KPj4gKysrKysrKysrKysrKysrKysr
KysrKw0KPj4gIDIgZmlsZXMgY2hhbmdlZCwgNTQgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuaA0KPj4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuaA0KPj4gaW5kZXggZWMwNDBj
MmZkNmM5Li4wMzM1ZmYwM2Y2NWYgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdXNlcnEuaA0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3VzZXJxLmgNCj4+IEBAIC03Nyw2ICs3Nyw5IEBAIHN0cnVjdCBhbWRncHVfdXNl
cnFfZnVuY3Mgew0KPj4gICAgICAgICAgICAgICAgICAgIHN0cnVjdCBhbWRncHVfdXNlcm1vZGVf
cXVldWUgKnF1ZXVlKTsNCj4+ICAgICAgIGludCAoKm1hcCkoc3RydWN0IGFtZGdwdV91c2VycV9t
Z3IgKnVxX21nciwNCj4+ICAgICAgICAgICAgICAgICAgc3RydWN0IGFtZGdwdV91c2VybW9kZV9x
dWV1ZSAqcXVldWUpOw0KPj4gKyAgICAgaW50ICgqZGV0ZWN0X2FuZF9yZXNldCkoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQg
cXVldWVfdHlwZSk7DQo+PiArDQo+PiAgfTsNCj4+DQo+PiAgLyogVXNlcm1vZGUgcXVldWVzIGZv
ciBnZnggKi8NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNf
dXNlcnF1ZXVlLmMNCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3VzZXJxdWV1
ZS5jDQo+PiBpbmRleCBkNmY1MGIxM2UyYmEuLjUyZDQzOGI1ZGNlZiAxMDA2NDQNCj4+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc191c2VycXVldWUuYw0KPj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3VzZXJxdWV1ZS5jDQo+PiBAQCAtMjEsNiArMjEs
NyBAQA0KPj4gICAqIE9USEVSIERFQUxJTkdTIElOIFRIRSBTT0ZUV0FSRS4NCj4+ICAgKg0KPj4g
ICAqLw0KPj4gKyNpbmNsdWRlIDxkcm0vZHJtX2Rydi5oPg0KPj4gICNpbmNsdWRlICJhbWRncHUu
aCINCj4+ICAjaW5jbHVkZSAiYW1kZ3B1X2dmeC5oIg0KPj4gICNpbmNsdWRlICJtZXNfdXNlcnF1
ZXVlLmgiDQo+PiBAQCAtMTk4LDYgKzE5OSw1NSBAQCBzdGF0aWMgaW50IG1lc191c2VycV9jcmVh
dGVfY3R4X3NwYWNlKHN0cnVjdCBhbWRncHVfdXNlcnFfbWdyICp1cV9tZ3IsDQo+PiAgICAgICBy
ZXR1cm4gMDsNCj4+ICB9DQo+Pg0KPj4gK3N0YXRpYyBpbnQgbWVzX3VzZXJxX2RldGVjdF9hbmRf
cmVzZXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBpbnQgcXVldWVfdHlwZSkgew0KPj4gKyAgICAgaW50IGRiX2FycmF5
X3NpemUgPSBhbWRncHVfbWVzX2dldF9odW5nX3F1ZXVlX2RiX2FycmF5X3NpemUoYWRldik7DQo+
PiArICAgICBzdHJ1Y3QgbWVzX2RldGVjdF9hbmRfcmVzZXRfcXVldWVfaW5wdXQgaW5wdXQ7DQo+
PiArICAgICBzdHJ1Y3QgYW1kZ3B1X3VzZXJtb2RlX3F1ZXVlICpxdWV1ZTsNCj4+ICsgICAgIHN0
cnVjdCBhbWRncHVfdXNlcnFfbWdyICp1cW0sICp0bXA7DQo+PiArICAgICB1bnNpZ25lZCBpbnQg
aHVuZ19kYl9udW0gPSAwOw0KPj4gKyAgICAgaW50IHF1ZXVlX2lkLCByLCBpOw0KPj4gKyAgICAg
dTMyIGRiX2FycmF5WzRdOw0KPj4gKw0KPj4gKyAgICAgaWYgKGRiX2FycmF5X3NpemUgPiA0KSB7
DQo+PiArICAgICAgICAgICAgIGRldl9lcnIoYWRldi0+ZGV2LCAiREIgYXJyYXkgc2l6ZSAoJWQg
dnMgNCkgdG9vIHNtYWxsXG4iLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgIGRiX2FycmF5X3Np
emUpOw0KPj4gKyAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4+ICsgICAgIH0NCj4+ICsN
Cj4+ICsgICAgIG1lbXNldCgmaW5wdXQsIDB4MCwgc2l6ZW9mKHN0cnVjdA0KPj4gK21lc19kZXRl
Y3RfYW5kX3Jlc2V0X3F1ZXVlX2lucHV0KSk7DQo+PiArDQo+PiArICAgICBpbnB1dC5xdWV1ZV90
eXBlID0gcXVldWVfdHlwZTsNCj4+ICsNCj4+ICsgICAgIGFtZGdwdV9tZXNfbG9jaygmYWRldi0+
bWVzKTsNCj4+ICsgICAgIHIgPSBhbWRncHVfbWVzX2RldGVjdF9hbmRfcmVzZXRfaHVuZ19xdWV1
ZXMoYWRldiwgcXVldWVfdHlwZSwgZmFsc2UsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICZodW5nX2RiX251bSwgZGJfYXJyYXkpOw0KPj4gKyAg
ICAgYW1kZ3B1X21lc191bmxvY2soJmFkZXYtPm1lcyk7DQo+PiArICAgICBpZiAocikgew0KPj4g
KyAgICAgICAgICAgICBkZXZfZXJyKGFkZXYtPmRldiwgIkZhaWxlZCB0byBkZXRlY3QgYW5kIHJl
c2V0IHF1ZXVlcywgZXJyICglZClcbiIsIHIpOw0KPj4gKyAgICAgfSBlbHNlIGlmIChodW5nX2Ri
X251bSkgew0KPj4gKyAgICAgICAgICAgICBtdXRleF9sb2NrKCZhZGV2LT51c2VycV9tdXRleCk7
DQo+PiArICAgICAgICAgICAgIGxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZSh1cW0sIHRtcCwgJmFk
ZXYtPnVzZXJxX21ncl9saXN0LCBsaXN0KSB7DQo+PiArICAgICAgICAgICAgICAgICAgICAgaWRy
X2Zvcl9lYWNoX2VudHJ5KCZ1cW0tPnVzZXJxX2lkciwgcXVldWUsIHF1ZXVlX2lkKSB7DQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAocXVldWUtPnF1ZXVlX3R5cGUgPT0gcXVl
dWVfdHlwZSkgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmb3Ig
KGkgPSAwOyBpIDwgaHVuZ19kYl9udW07IGkrKykgew0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChxdWV1ZS0+ZG9vcmJlbGxfaW5kZXggPT0gZGJf
YXJyYXlbaV0pIHsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHF1ZXVlLT5zdGF0ZSA9DQo+PiArIEFNREdQVV9VU0VSUV9TVEFURV9IVU5H
Ow0KPg0KPiBBZnRlciBhIHJlc2V0IGFuZCBmb3JjZSBjb21wbGV0aW9uIG9mIHdvcmssIHdoeSBp
cyB0aGUgcXVldWUgc3RhdGUgbWFpbnRhaW5lZCBhcyBodW5nPyBEb2VzIHRoYXQgbWVhbiBubyBt
b3JlIHdvcmsgY2FuIGJlIHN1Ym1pdHRlZCBldmVuIGFmdGVyIHJlc2V0PyBXaGVyZSBpcyB0aGlz
IHN0YXRlIGNoZWNrZWQ/DQo+ICBEZXRlY3QgYW5kIHJlc2V0IHdpbGwgYmUgY2FsbGVkIGF0IHVt
YXAsIGFuZCBpZiB0aGUgcXVldWUgaXMgaHVuZywgdW1hcCB3aWxsIGJlIHNraXBwZWQuDQoNCk9r
LCB0aGlzIGRvZXNuJ3QgbWF0Y2ggd2l0aCB0aGUgaW5mZXJyZWQgbWVhbmluZyBvZiBhbWRncHVf
bWVzX2RldGVjdF9hbmRfKnJlc2V0X2h1bmdfcXVldWVzKi4gVGhlIEFQSSBuYW1lIGdpdmVzIHRo
ZSBpbXByZXNzaW9uIHRoYXQgcXVldWUgaXMgcmVzZXQgYW5kIG5vdyBpdCBjYW4gYmUgdXNlZCB0
byBzdWJtaXQgb3RoZXIgd29yay4gSWYgdGhlIHF1ZXVlIGlzIG5vdCB1c2VmdWwgYWZ0ZXIgYSBy
ZXNldCwgd2h5IG5vdCByZW1vdmUgaXQgZnJvbSB0aGUgbGlzdCBvZiBhY3RpdmUgcXVldWVzPw0K
DQpUaGlzIEFQSSBkZXRlY3RzIHRoZSBoYW5nIHF1ZXVlcyBhbmQgcmVzZXRzIHRoZW0sIGFuZCBy
ZXR1cm5zIHRoZSBkZXRlY3RlZCBoYW5nIHF1ZXVlcy4NClF1ZXVlIHJlbW92YWwgaXMgZG9uZSB3
aGVuIHRoZSB1c2VyIGNhbGxzIEFNREdQVV9VU0VSUV9PUF9GUkVFLg0KVGhhbmtzDQpKZXNzZQ0K
DQpUaGFua3MsDQpMaWpvDQoNCj4gICBUaGFua3MNCj4gICBKZXNzZQ0KPg0KPiBUaGFua3MsDQo+
IExpam8NCj4NCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGF0b21pY19pbmMoJmFkZXYtPmdwdV9yZXNldF9jb3VudGVyKTsNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFtZGdwdV91
c2VycV9mZW5jZV9kcml2ZXJfZm9yY2VfY29tcGxldGlvbihxdWV1ZSk7DQo+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkcm1fZGV2X3dlZGdl
ZF9ldmVudChhZGV2X3RvX2RybShhZGV2KSwgRFJNX1dFREdFX1JFQ09WRVJZX05PTkUpOw0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0NCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgIH0NCj4+ICsgICAgICAgICAg
ICAgfQ0KPj4gKyAgICAgICAgICAgICBtdXRleF91bmxvY2soJmFkZXYtPnVzZXJxX211dGV4KTsN
Cj4+ICsgICAgIH0NCj4+ICsNCj4+ICsgICAgIHJldHVybiByOw0KPj4gK30NCj4+ICsNCj4+ICBz
dGF0aWMgaW50IG1lc191c2VycV9tcWRfY3JlYXRlKHN0cnVjdCBhbWRncHVfdXNlcnFfbWdyICp1
cV9tZ3IsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZHJtX2FtZGdw
dV91c2VycV9pbiAqYXJnc19pbiwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0
cnVjdCBhbWRncHVfdXNlcm1vZGVfcXVldWUgKnF1ZXVlKSBAQA0KPj4gLTM1Miw0ICs0MDIsNSBA
QCBjb25zdCBzdHJ1Y3QgYW1kZ3B1X3VzZXJxX2Z1bmNzIHVzZXJxX21lc19mdW5jcyA9IHsNCj4+
ICAgICAgIC5tcWRfZGVzdHJveSA9IG1lc191c2VycV9tcWRfZGVzdHJveSwNCj4+ICAgICAgIC51
bm1hcCA9IG1lc191c2VycV91bm1hcCwNCj4+ICAgICAgIC5tYXAgPSBtZXNfdXNlcnFfbWFwLA0K
Pj4gKyAgICAgLmRldGVjdF9hbmRfcmVzZXQgPSBtZXNfdXNlcnFfZGV0ZWN0X2FuZF9yZXNldCwN
Cj4+ICB9Ow0KPg0KDQo=
