Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE984CA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 01:46:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6884F10E2BB;
	Thu, 21 Aug 2025 01:46:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IiplrDcc";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AEAD10E2BB
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 01:46:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WowguO+diC1jhvyrJ/xoeWIswIh2S6xD/XdH0Rez6wbbzxx67OvoYQjsVEfsOgMsDlohFF387/Ab06c8YHgSEC+hJuUubG3GdrB0mEpKC1YAS4aHXxScwEpSfpaaK4iX/UCn7lEH75x5KHx4tu5BYnnvTKCOr4OVDoNoITVSZeq2UBbSrqvbqXim1NqmPde3nL5GUk96Wn98FmqUdo1FXOtkENK9VHe6Tygbm1+F2J+weAzIemjnjzMdA5TRtDIsQVWwpt98eWu7/RwjbMw18xSnsdE9NZtOGU0i4VUftTB7qOSoPM9SvRm+C/E16G9uhWP3t9P239TgLzz7kFsfsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+2XR+caXKJ82ZeXHknU3N3LPLHCa84KUzL5qTxhf6Y=;
 b=HTg1dtwmjao/hIolsRYTK1kOUExsZAak9KDopzurVsba3Ykig1Of3NY7V3BHIifoQ6p1L0gCBKnKYX5CvECrDzWFQ+5kaA6YBLzx+nA/6TeksazM8R1dg7W2SsQ8l6ZlGY7h2Rl/1kfiNn6lWPatNF6wVNX7giG3fBzcH9uVZODARVK5Pby8eFi7ksyb591Z0q1zpoUT/jAY31lO9oVWUav06FtaV5VUNuxiQYdOQ7nqnWpsvRxpa8rLV9QvkEevDFrpsgsghvbVCqeNYRCLqYPs7tx9S25k//B0hkxLK9UrlVWt/ZsGYSfKRm5DioDJ3IpJ9lxD7pYwJPmPQGtAMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+2XR+caXKJ82ZeXHknU3N3LPLHCa84KUzL5qTxhf6Y=;
 b=IiplrDccMv8f1gWTYR8FthXb1nc37xW40QoUD7uA2J0l4LpJv60DpjWQZlGkqdRXexSXh2gzO9hgPVWykkvmpBktGgpJ9AJwIRtFQCWTsjoMPWyW/Fs+AKQ3dvjIRwKAsfLnyUiXykrosFdmCWe421zSZy66m1hN390XDHLyTSs=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by CY1PR12MB9675.namprd12.prod.outlook.com (2603:10b6:930:105::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Thu, 21 Aug
 2025 01:46:12 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.9031.024; Thu, 21 Aug 2025
 01:46:11 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: replace AMDGPU_HAS_VRAM with is_app_apu
Thread-Topic: [PATCH] drm/amdgpu: replace AMDGPU_HAS_VRAM with is_app_apu
Thread-Index: AQHcEaSOfGOqVXxPOUe2eTGHxBHAabRrMWSAgAAVORCAAAJzgIABDjzQ
Date: Thu, 21 Aug 2025 01:46:11 +0000
Message-ID: <CY5PR12MB636948A4BDAF864FBE240C6BC132A@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20250820073100.3500205-1-yifan1.zhang@amd.com>
 <274e7416-371f-464d-8d66-f9d81414bd4f@amd.com>
 <CY5PR12MB6369AF40DA64EB5477D24A49C133A@CY5PR12MB6369.namprd12.prod.outlook.com>
 <6d499dcb-e88c-492a-9194-dca18a0f4528@amd.com>
In-Reply-To: <6d499dcb-e88c-492a-9194-dca18a0f4528@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-21T01:45:36.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|CY1PR12MB9675:EE_
x-ms-office365-filtering-correlation-id: 022dafa0-b467-4e59-8d29-08dde05481fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?TWtZMFYyOFVhNThRUmw0QThVWVFaR3dVYXI2SWE5NU5HTEoySUd6c3ZpMGVp?=
 =?utf-8?B?a2pLcXUvRUJTd3Q3R0FqVWlodUVOazB1dndNTUtpZ3J0RDd1SFZFaXdacjhx?=
 =?utf-8?B?RjA2NUV6em9tMm1MOHdXMFN6NHNPT0lpSWhLTVZ0R2Q3SUxXNytuQXcxYlZN?=
 =?utf-8?B?ZHNPVUx0UHpXY1NIQnVpcE5yNEF5aHpLVU81VUhkMjdjYnduemlOTW5aNnd0?=
 =?utf-8?B?ZVBOckxjK0oyMEtnU2ZBN2N0eVRldFUwbE1VWE1yVm9MV1cvTkg0OVZrQmJD?=
 =?utf-8?B?SncwWm1SYVRQc0hpbVZ0SGJLSXM1WUl2TzFsUUF2N09PQXhLTXN0b0dNMSsv?=
 =?utf-8?B?d3BMVkV2eW1FWll1L0dlNVZ5ZDJ5V3JySjdQcTdDVzNLeE1vR1M5M3lON01W?=
 =?utf-8?B?bjA0MERqZnFhYktJcUFFRXl3bmFGUHJJOGc3SWYzZ0w4WmtBWVFYVlM0VzV5?=
 =?utf-8?B?aE5VQmMxRW1ha3oxWHJaRU0yMWQzNjZVaXVPeC83bDFoLzBTY2kxL3RRRU1J?=
 =?utf-8?B?YUl5WUljVlMvNkRLN3NNZzhzV2w1Z2llWm5LUW5jcTl0UWthOHBCcm5LRUY0?=
 =?utf-8?B?bnNzdzhqaHJVSkdiSk9RWUVRYm9OZmd1WnFtR1FkQ0ltR1V3Ly9nWlRDVVNC?=
 =?utf-8?B?ZTJPL1hpbEIrRGUrVmpTMW9LWVVJOW03aE1CT2dDekc3STVFN252VVBxMml4?=
 =?utf-8?B?aEl5djczb2daTnFkK3graXN1R2ZFR3hWSkRoN29SVVdVaWxoempaNy9DU3lU?=
 =?utf-8?B?bTFMNFpqQmdwRElYbTRmaDhXQ1VXeCsraG43MEliOWQvYkFxWStaaUNueWVH?=
 =?utf-8?B?WHUxdzlYU1E0WmhMK0x2VENrdnJaNWpkanVVQWRYV0xkTUI2aTZjUmNtSDZa?=
 =?utf-8?B?SXZUVnZiOWRBZTR0R1BzMzZnSThmMXFRdUtiN3E0NzRQNktKMk5pZGdJdll5?=
 =?utf-8?B?RHcxc09Jc0VybVlDU3JnMjhZS1J4VHZFajJxcTNlcmlTT3Rxc1dDSDhVSkNa?=
 =?utf-8?B?c2laaHZjbVFOTEhINVRieW1hK0tDWVJ0MHhiSWsvV2tva0E3RmhmaUVBeVdo?=
 =?utf-8?B?TjQ0TEkwRjZtNDV4WDdlTnVuVWZjZVZJRXpNQ0lFa1dZZUtWQlJ0UGF2SHR1?=
 =?utf-8?B?MDFWTm5qQ0c4bG5aSnpIUXNTZ0x0Rk1LS1Z5SEhsQVg2R0NmWFhSZzRLQ3Za?=
 =?utf-8?B?TlFKazRlUEgySXZTL2JnRmJJU2xaT1IvdHBFSkMyeGhuL1lFWXczYzdUTWtr?=
 =?utf-8?B?OTZsTlpZbXZFMkJqanluVHlic3hocm9MNXA2OVpMNSt1aE1LU2hiSFcwRDhD?=
 =?utf-8?B?bGFkREFOb0Y3MjFkUjB2UEVmZzEwN0IwK1RiRmRNRE5kQzI5c2ZBMExkQmRr?=
 =?utf-8?B?Sk43NGpBS2JWbUR5SlM0aytyS0t6OElxSCt1c3VTQ0czUjdVSHVxMGExaVBz?=
 =?utf-8?B?OWZuMm9nV05qOXdlcjZWYjE4M1R3Z3ZqYjBwdElqMlBmTFh4NVZYVkNOd0tQ?=
 =?utf-8?B?eXdPVlRsMldDV3dXaHo5YjdqVVM5c2FGL3BEMkZhaExuZ1hqb04wYUl3cERr?=
 =?utf-8?B?ZHVKQVVPRlFZNG9iSTVKQ0FGSWdHZVcrN01Ic3RzYWZTdXhRWEo0ZzJia2xZ?=
 =?utf-8?B?bjcxOWpwK1VSSEpsK091NDJiNmRmK1hvMGhKTU5iZ092ZEwxNEJDQUV3eFpi?=
 =?utf-8?B?SGtpVnBuS0RHZmFLYnlvQ3VuelRTNmNYa2JxVUM3cmxjbjE2ZGNNNTgzQnJv?=
 =?utf-8?B?TkVUR3BLUTJHVHlJWG1Caitra3UwM2Y5bm1tSzBlVk55UkRaQ1puczlMU1Bw?=
 =?utf-8?B?OUNwYzQ4Q1paTFI4VUl1d1NwcnBpV3Y4RGpiaHZ6b0dzdEw1QUUwZHh1RitN?=
 =?utf-8?B?NEVGcnVxNUV4YVFxdnJWeUhVN3pFSXRqK090eUhpQXZBdzdRb3huZFo5NjBN?=
 =?utf-8?B?Z2lUVms5em1FYUhYYWYrN3FjR3hYekovNjJTcXl1bGxzV0g0K1JQcGNwajZK?=
 =?utf-8?Q?oC9NUf3Qy+S9q9b15mA9yQ+Rjom8XM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TW1kajZwRlVtMFpYZDNFY2didTA0ZHhKVVZwWHBLeGFiWnp3VVd1TjNVaTFV?=
 =?utf-8?B?bERMV01NNWo2MGN1OUZRZnlSaWsvczdzTkRybzhsM2wxc3NiOG9jWTU4QTFi?=
 =?utf-8?B?ZTZUUVhkbzE0c3hoMTVFTzJVeWNMSk5pRkNCdGp2eXZEUWxpRGFuQWdpK0Ir?=
 =?utf-8?B?b1R5NHBvR3A1eUdBc2V0ODhIODI3djhhaVllNWNNN1huTkFmT1ZaNzBxeDRw?=
 =?utf-8?B?U2RFUFBuK3Z2TjFSUHRVWG1lYUdoRFBlbFRyN1ZuTVdEbE9uaEFBaUxmMGUy?=
 =?utf-8?B?ckZBUXhadVltdHVWWk9hbXV0QlZVL2lad01xTUJHaHJhZHJkQk9HL3ZyRCtH?=
 =?utf-8?B?dnozQzFReFplOHFSSFBIMWtPNGczcnNWcWN2b3p6dTdsODlvdmVMcC9iTXg3?=
 =?utf-8?B?MDR2NWl5eG9QV3BYNVlEekZTRHBkY3JwaFhNWXBmZTBtY05hazFOTlBVeHNr?=
 =?utf-8?B?bXdvOXhtK0lIRHNQa2hPVVdKTEt4Z2hjd3M5cjdqa2FPcXpvcjFpN3VjazN6?=
 =?utf-8?B?aGYxOE4zVzhTWW82d3VtbkxZaENKK0ZNM0pNNmZwOGV0cjRtMkZGaXVVR0Nr?=
 =?utf-8?B?RHhjcmgxT0NxNWZTNDJmUWs4bGExd09zWVp5QlNYVHoxeTFSVTEyVTV4Rllq?=
 =?utf-8?B?WTMxTU1GSnJnaDB5TGhEZDVmR2MyTlVLZGpBWEtqODBqRTQzS0Uvbm5qL1Jx?=
 =?utf-8?B?eFhWSThmUW9lY1UyQmxod1l5OW9nZFhTeWMySkRrejhROEFmcHRmK2FnNjdl?=
 =?utf-8?B?RWdqVWU4Z3BITVYybERYUjIwbm5ZajRBU2ltWVRaUE9IMXNrQmlnd1JkUHVm?=
 =?utf-8?B?azJKSWtVc2RiNVBxcG9JbXdCYjY0RGN0N0Q2QVpIM2FDQzVTU1JWQ1l3Kzdu?=
 =?utf-8?B?ZnVxWWZiSDZSaTN6MmgvWkhpSjJGaTBTN3lrUzl0Q1hCaHI0aXBRdmRBbnlV?=
 =?utf-8?B?REQ4MUNKcllINjhoL0NXS1NaTUpEbTFVcSthaWdsLy9xeGRKMUhjaFowcHJK?=
 =?utf-8?B?YklsTkR3cXRNUHc2d1VZV0k2Q0ZqL0JkWGl4cXVYOElzU3VJcFZ1c0xqZ0hs?=
 =?utf-8?B?enJ4akN4VlBQZEFUSW9hQjlEQVJjRUFXRC9HQTNVTVI2MmdFajU5cHBsVEhQ?=
 =?utf-8?B?Kzg4eHdYR1hDOG5XV1pXNjBnQlVvc3JjTHRaNE5TcjRXT0U3dWtYdUQyRHd0?=
 =?utf-8?B?aFN1L2p3OWF4K0dLWi91MVFQWEh4NWozNnMyeHJONGJXTEJhaXpCTWFySVJH?=
 =?utf-8?B?emVCWmowc2h6VDRmYlY0RmdGQVJsbnZGUDdtL01JZnVCMm5MVW1YYlg5WVJE?=
 =?utf-8?B?dG42dFR2SU43bFBsaURacWlVNDEyU3ZPR1FHaEhWamhrYVhDanBNOUk4eVdS?=
 =?utf-8?B?WStiV1R2b0YyY1U5VjVmR05iaWZHWUNQRlVSMW9Kdnd3SUxVdVpVd0tnMDh5?=
 =?utf-8?B?dWgyOW9WdWliVm5TdGs2RjAwYS9GS0s2R0JWMy9tTkF2SU1Wd1FyaWdzU3M4?=
 =?utf-8?B?cDJETXVFVE9jSEFlYlBHWG54MzdrK202cHI4MXZuT0RsMStLL3krQjhpL0JL?=
 =?utf-8?B?ODU5blZlSHB4WUxqL2s2VUdhcG1wcitiUkROeDNiNWhUUlJlcGJRSjNpb2V1?=
 =?utf-8?B?RW1oaFFSWEhzVWFjVG55V29NSm1CLzNmdlArZHhVbTJPZDhjUTBPR2JUUUVP?=
 =?utf-8?B?Z040TC8wT2Q1YmF4NlNLSE9KS1NRL3VORDdvdTRUdmZaMWJvdk8yMUgzUGJv?=
 =?utf-8?B?MnpOMU5oZWxnbk5lY0gxTE4yeWZyTUhHaDdFRDA2aisxL2ZQTEZSSWY3QUww?=
 =?utf-8?B?NGpTb2ZNaC9CSEh0UUNRR1BwN2l2ZlZJYU14cnVpamd2SXordWU3OUM1TVNX?=
 =?utf-8?B?VDBTaHJIczQxWUFPQy8vYno1UDVQd2UzMWxCdjhudVlndUZrVkdzRFZHdjJu?=
 =?utf-8?B?emx5VGlIQkNNZG5sL09SWTJtekg1bHk1akhtSk5JR1dIRmVNTVkwM3YrUmFz?=
 =?utf-8?B?NW9WNVlRMzBnZjNpaHRuNGlES0xsTzdZOTZwTENwOUdlS0R6ZjRDdFg4VVdh?=
 =?utf-8?B?a1dsdlhRQmFWQnRxdnRCbEhqaFZjSDV4WVh2WE5EODVhV2lCQSt3N3dscnhq?=
 =?utf-8?Q?EXbU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022dafa0-b467-4e59-8d29-08dde05481fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 01:46:11.8782 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a1EJPMfPiuFR72GR3gdcy6iMMSJ24La1FQ+Nkun29pPMJ3P4kiG+ZJ4H1C1LsXkt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9675
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
Cg0KU3VyZS4gV2lsbCBjaGFuZ2UgdG8gQU1ER1BVX0dFTV9ET01BSU5fVlJBTSB8IEFNREdQVV9H
RU1fRE9NQUlOX0dUVC4NCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS29l
bmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NClNlbnQ6IFdlZG5lc2Rh
eSwgQXVndXN0IDIwLCAyMDI1IDU6MzggUE0NClRvOiBaaGFuZywgWWlmYW4gPFlpZmFuMS5aaGFu
Z0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBEZXVjaGVyLCBB
bGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENI
XSBkcm0vYW1kZ3B1OiByZXBsYWNlIEFNREdQVV9IQVNfVlJBTSB3aXRoIGlzX2FwcF9hcHUNCg0K
T24gMjAuMDguMjUgMTE6MzYsIFpoYW5nLCBZaWZhbiB3cm90ZToNCj4gW0FNRCBPZmZpY2lhbCBV
c2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0NCj4NCj4gUkUNCj4gIlRo
ZSBvbmx5IHJlYXNvbiBJIGNvdWxkIGNvbWUgdXAgd2l0aCB3aHkgd2Ugd291bGQgbmVlZCBpdCBp
cyB0byBoYXZlIGVycm9yIGhhbmRsaW5nIGlmIG5vdCBlbm91Z2ggVlJBTSBpcyBhdmFpbGFibGUg
Zm9yIHRoZSBUTVIsIGJ1dCBmYWxsaW5nIGJhY2sgdG8gR1RUIGlzIHRoZW4gcHJvYmFibHkgc3Rp
bGwgYSBnb29kIGlkZWEuIg0KPg0KPiBUTVIgYWxsb2NhdGlvbiBvbmx5IGhhcHBlbnMgaW4gcHNw
X2h3X2luaXQsIHN1cHBvc2UgdGhlcmUgaXMgZW5vdWdoIFZSQU0gZm9yIFRNUiBhdCB0aGF0IG1v
bWVudC4gUmlnaHQgPw0KDQpZZWFoLCB0aGF0J3MgZXhhY3RseSBteSB0aGlua2luZyBhcyB3ZWxs
LiBUaGVyZSBpcyBtb3N0IGxpa2VseSBlbm91Z2ggVlJBTSBpbiB0aGF0IHNpdHVhdGlvbi4NCg0K
UmVnYXJkcywNCkNocmlzdGlhbi4NCg0KPg0KPg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0K
PiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAyMCwgMjAyNSA0OjE0IFBNDQo+IFRvOiBaaGFuZywg
WWlmYW4gPFlpZmFuMS5aaGFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogcmVwbGFjZSBBTURHUFVfSEFTX1ZS
QU0gd2l0aA0KPiBpc19hcHBfYXB1DQo+DQo+IE9uIDIwLjA4LjI1IDA5OjMxLCBZaWZhbiBaaGFu
ZyB3cm90ZToNCj4+IEFNREdQVV9IQVNfVlJBTSBpcyByZWR1bmRhbnQgd2l0aCBpc19hcHBfYXB1
LCBhcyBib3RoIHJlZmVyIHRvIEFQVXMNCj4+IHdpdGggbm8gY2FydmUtb3V0LiBTaW5jZSBBTURH
UFVfSEFTX1ZSQU0gb25seSBvY2N1cnMgb25jZSwgcmVwbGFjZQ0KPj4gQU1ER1BVX0hBU19WUkFN
IHdpdGggaXNfYXBwX2FwdS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZaWZhbiBaaGFuZyA8eWlm
YW4xLnpoYW5nQGFtZC5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHUuaCAgICAgfCA2IC0tLS0tLQ0KPj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9wc3AuYyB8IDYgKysrLS0tDQo+PiAgMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKyksIDkgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdS5oDQo+PiBpbmRleCBkZGQ0NzJlNTZmNjkuLjAxZjUzNzAwNjk0YiAxMDA2NDQNCj4+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+PiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KPj4gQEAgLTk0NiwxMiArOTQ2LDYgQEAgZW51
bSBhbWRncHVfZW5mb3JjZV9pc29sYXRpb25fbW9kZSB7DQo+PiAgICAgICBBTURHUFVfRU5GT1JD
RV9JU09MQVRJT05fTk9fQ0xFQU5FUl9TSEFERVIgPSAzLCAgfTsNCj4+DQo+PiAtDQo+PiAtLyoN
Cj4+IC0gKiBOb24temVybyAodHJ1ZSkgaWYgdGhlIEdQVSBoYXMgVlJBTS4gWmVybyAoZmFsc2Up
IG90aGVyd2lzZS4NCj4+IC0gKi8NCj4+IC0jZGVmaW5lIEFNREdQVV9IQVNfVlJBTShfYWRldikg
KChfYWRldiktPmdtYy5yZWFsX3ZyYW1fc2l6ZSkNCj4+IC0NCj4+ICBzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSB7DQo+PiAgICAgICBzdHJ1Y3QgZGV2aWNlICAgICAgICAgICAgICAgICAgICpkZXY7DQo+
PiAgICAgICBzdHJ1Y3QgcGNpX2RldiAgICAgICAgICAgICAgICAgICpwZGV2Ow0KPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYw0KPj4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCj4+IGluZGV4IGZhM2U1NTcwMGFk
Ni4uNDEyNWU3M2EwNjQ3IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3BzcC5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcHNwLmMNCj4+IEBAIC04ODAsOSArODgwLDkgQEAgc3RhdGljIGludCBwc3BfdG1yX2luaXQo
c3RydWN0IHBzcF9jb250ZXh0ICpwc3ApDQo+PiAgICAgICAgICAgICAgIHBwdHIgPSBhbWRncHVf
c3Jpb3ZfdmYocHNwLT5hZGV2KSA/ICZ0bXJfYnVmIDogTlVMTDsNCj4+ICAgICAgICAgICAgICAg
cmV0ID0gYW1kZ3B1X2JvX2NyZWF0ZV9rZXJuZWwocHNwLT5hZGV2LCB0bXJfc2l6ZSwNCj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUFNQX1RNUl9BTElHTk1F
TlQsDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFNREdQ
VV9IQVNfVlJBTShwc3AtPmFkZXYpID8NCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgQU1ER1BVX0dFTV9ET01BSU5fVlJBTSA6DQo+PiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFNREdQVV9HRU1fRE9NQUlOX0dUVCwNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcHNwLT5hZGV2LT5n
bWMuaXNfYXBwX2FwdSA/DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIEFNREdQVV9HRU1fRE9NQUlOX0dUVCA6DQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIEFNREdQVV9HRU1fRE9NQUlOX1ZSQU0sDQo+DQo+IE1obSB0
aGUgbG9naWMgaGVyZSBpcyBhY3R1YWxseSBjb21wbGV0ZWx5IHVubmVjZXNzYXJ5LiBZb3UgY2Fu
IGp1c3Qgc3BlY2lmeSBBTURHUFVfR0VNX0RPTUFJTl9WUkFNIHwgQU1ER1BVX0dFTV9ET01BSU5f
R1RUIGFuZCBnZXQgVlJBTSBpZiBhdmFpbGFibGUgYW5kIEdUVCBvdGhlcndpc2UuDQo+DQo+IFRo
ZSBvbmx5IHJlYXNvbiBJIGNvdWxkIGNvbWUgdXAgd2l0aCB3aHkgd2Ugd291bGQgbmVlZCBpdCBp
cyB0byBoYXZlIGVycm9yIGhhbmRsaW5nIGlmIG5vdCBlbm91Z2ggVlJBTSBpcyBhdmFpbGFibGUg
Zm9yIHRoZSBUTVIsIGJ1dCBmYWxsaW5nIGJhY2sgdG8gR1RUIGlzIHRoZW4gcHJvYmFibHkgc3Rp
bGwgYSBnb29kIGlkZWEuDQo+DQo+IFJlZ2FyZHMsDQo+IENocmlzdGlhbi4NCj4NCj4NCj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnBzcC0+dG1yX2JvLCAm
cHNwLT50bXJfbWNfYWRkciwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgcHB0cik7DQo+PiAgICAgICB9DQo+DQoNCg==
