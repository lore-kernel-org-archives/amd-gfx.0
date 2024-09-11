Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E0BEE49BC
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 15:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0477D10EA34;
	Wed, 11 Sep 2024 15:46:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hwiJjyRw";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 610F310E8A9
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 15:46:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XL5Xwuh7I1tq8a/PRsYa2/x+q5VlZSedDZ5gEcDhgbiv813z11pbgK8ZbAVZ2OMXxEyDA5Bv1mk0jNEKBTILJr3So/XXYz3RYkA4fE1VjWTc4U7TGP2zTKjtjZ0PQG9PaDqPNdGjjGfv+E/pGosShv8C9t5O3WECtVt+RM0S6F+l00So9gr0zY2LCv6XbLouGMyWKEHSAy8Lt/oBeKb8vRw0ZG5xJFfK2i8qPdqiOi9/m+yOtr4VfWwyDoI0e2FY/NGO+/yuqL65KqU9lG26vUX5QX4zPPF+KeC+Pl2LRCkNyl5lfMBBSU3i2y2s5OiiiZS3pwTIUni5sMZZ95WAsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7d3Hid9qp07CHgsOGK0e4zhVM5BVUtTleOlGxWJ0JE=;
 b=deqUkG/grw0/7QJIBlPVAS/Q6IjyCLgp/YpYfpjFuaG4IsNJXyGmcElKxgEbrokTAOngYETHNOEnS/BB3yj+HWixOltWEClZGrwcnwhv+E2n1CAxHh5tYke83yzxIEmW3msotKy1aMFUWDwhujbpF44VUQ5RYWONXYYzMb3MKxqHrR6P6RovrEYiuI2+5JNTSUTBZ7XlvezkraI/4rEDdgU5vGVqBJK5LgB+4qGZa87D3XK4MJghW01oECK1cs9mHBu+jgvhM9aXbN5r5RZp0q0A6zHJ9yJt0NJaTMNyCbxYiER4E0o6kVS0Kmq8ZJO1ylOGJo6oeJoSn4Hin9Ey1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7d3Hid9qp07CHgsOGK0e4zhVM5BVUtTleOlGxWJ0JE=;
 b=hwiJjyRwSMMOLz5x2ZlY9z59WJhDQF+1/M9Xl8p96TlleSVrtxjkCsxuJxcLsFPlktO2Xg5vQDocLv/EcgJ0fL4Cu3fnzM5g7admac3piTAiHQV5rXDL5Sz0JVi6QVCXRpJmY5zM36rYAjtUS+vwUM8Ps2kH9NjykgIzOE4voAc=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 MN2PR12MB4424.namprd12.prod.outlook.com (2603:10b6:208:26a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.17; Wed, 11 Sep 2024 15:46:04 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563%7]) with mapi id 15.20.7962.017; Wed, 11 Sep 2024
 15:46:04 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add amdgpu_jpeg_sched_mask debugfs
Thread-Topic: [PATCH] drm/amdgpu: add amdgpu_jpeg_sched_mask debugfs
Thread-Index: AQHbA444sSveWSMwaUCO4apueTWcL7JSvDHQ
Date: Wed, 11 Sep 2024 15:46:03 +0000
Message-ID: <DM8PR12MB53997EB26CD77B99075CE616E59B2@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20240910143146.1942083-1-sathishkumar.sundararaju@amd.com>
In-Reply-To: <20240910143146.1942083-1-sathishkumar.sundararaju@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=655dc656-5c65-4630-b84a-71c74c0dafc2;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-11T15:45:39Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|MN2PR12MB4424:EE_
x-ms-office365-filtering-correlation-id: ecf437a3-d202-4edb-5b4a-08dcd278d7e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eWVyN1dMS25ZZll3UWQ1Tk1ZZTZjK2ZGR2tPcGNvMFhIQWhrMVUzQngzRmdh?=
 =?utf-8?B?anF1dW5nYnVSOXNjTTN6a3cyb3ZOK25jTUMxQmlmVFZFRkNTZEJIMGRscjZH?=
 =?utf-8?B?ZFRjWGxwRWFYZHlBekl3cmlMNW5OazZZQi83RW9pS3FuNmdzLytXWjBOcTJn?=
 =?utf-8?B?aHErbGxlRmNRQnhrMzJveGdLZkd4S2FXVXFvUCtsbGpHUHlVLzZKWUF1WTNP?=
 =?utf-8?B?dnMrNXVjMTdNWnRFcFZGdHdBNW9yaXNzSGFNcmxKSTJpd2JYZ0xMTjNLdzNJ?=
 =?utf-8?B?c1h6SU12TjZmK0ZlMGg2T2lIVmpEU3dxR0ZydmVSbUthMnRqWU5Lb1U2VE5C?=
 =?utf-8?B?YWRoeEM3bjlMdVVwNWxhWlU0bDRRZW4rZzgwa3VESFJGSzFzcGlzQmc5OVlx?=
 =?utf-8?B?WXFDeDlpOWRMdEVyRXpydTArNE41Y1YxR3ZrYkc3ZW9JNktCOXY3aUxIN1JM?=
 =?utf-8?B?WGJjN1NnMU03dEtWWHFHZWZNUFBFR2ZHOXFOWUhKVUhmVUsyejk4dkNRUGJq?=
 =?utf-8?B?WEtDd0xYQStvcjhWdkZDdGxCQXYyd09FTW1CdmdRNjd3Rmh2R3ZZN2J3WU05?=
 =?utf-8?B?K3IzZzhacjhvTThTa1F0M1E3aGt6K2dBNkVqdnV3VURqdkpzYVFtQW44L0FZ?=
 =?utf-8?B?TjN1RkdEQ0xJek1IWkFwMmlISXp1YkZWUUJxQW5jK3NMUHVSVG5aQlVTVUVT?=
 =?utf-8?B?YzFTOGJVZ2YrYzRHd3I5eXA3SWREZGtTZnhxKzZPUzEvSDVEOHM3eTlzZzFq?=
 =?utf-8?B?ZTJzcVRsaitTTk80akNOYVlQbjRGUzdMc3UxTHdMSEhmUzhkRlpGdGhNSXgz?=
 =?utf-8?B?aEhCZ2psUTlnWG5jZnFpSnFGSm9VcEUxQkcrRnlGc2JobmZYQkkzWEt3S0p0?=
 =?utf-8?B?bmIyMVpuZ0RUUlVKcXF1aU9CVm9VSjc4a3NDWVd3Z3ZDMml1Mi9BQ3MyOTdT?=
 =?utf-8?B?VGZsNHZyaWRzVVFpTytFaiswYTVSVW5HbUJVUjh4UE5uL2Z1ZUIraEFkbjZk?=
 =?utf-8?B?VlpaQ1VtczJHZmxyR1duclJWQWN3Z0JsdWZIaURVYURsUzd1SHc5eGQ0b1ND?=
 =?utf-8?B?dk1haGh6Sk9OWFpxekU1UjcxaHFFY1BXK3Fvajdrd1VJcFlMRDk4M2tzbzJI?=
 =?utf-8?B?dTlnMXRqMEV6WENJQndMM0pWMGlvQVZCbHZKNVBQRDZYZkIvWHgzTzkwL3hl?=
 =?utf-8?B?WDN5QTNBclFoOWc4REY1WWhQdFBhejVRd2hMNWVkY0o1akpkQ0JENGY5Qjht?=
 =?utf-8?B?Y3lxRWc0dVp3WEs5eDIraDFudzNTYzc1MHFYYmhqaW1pSi9uL2p4cm9icmlr?=
 =?utf-8?B?RFNPY3prT0VFSUhjTlI5cWtjTklzYXgreGJjU2RaL01YK1lHelVNeHZhT2x6?=
 =?utf-8?B?U3prMG5MMUt4ZnBzdU5rdzhzWHMwNUF2K1ZOVDEvVWlYR0x0QXl6WitQSHY4?=
 =?utf-8?B?WFFheDdaMmduT3E1N1hIWGtxamJETnl2YmxmMmtGSnNUcVlYa3FsWDhwYXBC?=
 =?utf-8?B?ZjNCbDBBcWVwMTZab2ZPU1RXOW01c0J6Y1ZIOUlDMVdZQk1qZlpYbG1iNndF?=
 =?utf-8?B?Q1M1SVNjQktDaDJJMEVwMnhRdXNiR2t2ZjY1V2p1VWM3VDFhRHdjcG1ZTFlp?=
 =?utf-8?B?aHBKTUo3cmdyd3lLY2sySUNPaThVZldjc1QrSm5kalhOU2E5L1lxR05RaGxa?=
 =?utf-8?B?VFdkb1B0Nk0wN0tTWWpWdzRFcDUvc2lSVDVKeXhIUEkxMFkwOStoeFlUSXNp?=
 =?utf-8?B?R084OHBHMzZocWkwWGdYMU1YSFkwVitIdjdhWi81SGJreTIzQTFWdUplOHl5?=
 =?utf-8?B?YkpRQVBUZkZqSEVoY1AwS0xrWWJZSVc4alBvZ2UyTzUwR0tmV3B4MVBHdy96?=
 =?utf-8?B?cXdtdFFzQzh3NFl0NlBkWTAwSXJDZGRmTEUxR2tOb2VFSGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mm8rc3ZyN2RJaUVaazFod0hMbi9GenN5M1I5RlFqbEdhcmFCbUx3NkxTbHBU?=
 =?utf-8?B?VUJlaGY5TjdTVXAwSzFiQVVrWkZwNWwwbXE1cTZSZFNZUXVleS9pVXRSSnlw?=
 =?utf-8?B?Rk1CWnhBOXV1ZXpRd3E4NVRkWUFVTUFLVjllb2Y1NXQrSWRZWmwwYksrMkk2?=
 =?utf-8?B?VTlJbkhUUWQzS3NPK0VaU1U4ckJ3KzlGKzFORGpQSVlQZnhnbEcvUDA4RTZy?=
 =?utf-8?B?MklZbTM5WVVxK0psMXB5NDBGV3doQ05WQVhlTXBXK1ZnQ1Z2WS9BWlpIY0N6?=
 =?utf-8?B?MnVIY2hkQ2FoNVNkZVdMcVZzQ0hEenBVSC9ZTzFrMHcyMkUwWDVCTWJXR2Fj?=
 =?utf-8?B?RDNyUFJpOUFiMFVFcTFtMHhGaXVPWVR6NVVTUERoNnY4YzlGV1U3enBkZzB4?=
 =?utf-8?B?VnM5VFNCNDJ4Z0l4YklFVVJHNGFCTXl2U0dyRXpZY2pDM2FEVWhwdURQeXhh?=
 =?utf-8?B?Q0p1QUtMODNvcTBGbmdrNkR3eVpGckc4OG00TlpMZHA3SXdqVDZqbUVOZnZr?=
 =?utf-8?B?Q2xrYmNWSTV5V21xeEhGZGtXWUxRWFloSkpVLzlDb2x0aU1ndmFiNEZyWGhP?=
 =?utf-8?B?bXNBVDNxSWRNWTB6R3dyY295RHByd3Jiank4aVBTTVpKdUlpd09JM2VLcDFK?=
 =?utf-8?B?Rzg1RCtQMkpRU1hXOVVBWU9FdCtGWG9iVk1NV2VrN2lBMHVaSmdDMkloTS9w?=
 =?utf-8?B?bEZ3bEhnbEFYdEVpZTQ1dTJMZzZZSlV6bitRNWJpT0NobDF2Smc3dkNOYzZZ?=
 =?utf-8?B?RU1wZ1ZremVaRWtKOHhrZVBmcXhHMGxZTUEwY2JMbkVYQlRvR1dsamVOTDRS?=
 =?utf-8?B?cG5wZzFBa2FuR0tkcHM1SjRQeHFBSFJ6WS8rOUNra0tCanZ1ZDZYWTBwUjd2?=
 =?utf-8?B?RVlvbnMvY3JLQXVvWm1QNVZVVWVDNWhlZ1pQd1poSXc4bzBZbG5LNnA1ZVRj?=
 =?utf-8?B?bStnWC8zbXQxczVxcUlJNzZaUTZnZ0w3KzE0TXV6ai9uQ28vdHlsSFNmbDEx?=
 =?utf-8?B?bExwYVcxeGE1VVh6OGwwbkhxaHRZMG1pYXBvdlJYRFBmWXF2aE1hOFJFQlNr?=
 =?utf-8?B?ZnBFWFQzN3ZmeTBaOHNCZkhWa2hFZ1JRTTEzdG54eTlPVHJKYVpqUzFGbllp?=
 =?utf-8?B?dHloZFc0NkovUkVQZ0N0WFpUSlk3OTdnbHh2RmNBYUxKZ2RVT2c0T3k5NURn?=
 =?utf-8?B?TWNnK1Fxd1IveTZ6ZWRLaDJyUTBPMGFHMk9nbjd2Y3MwczVtRGgvaStkeTdr?=
 =?utf-8?B?U1dFUkhCQk4wM3lCZlplK1NRQlk3dWVTWXliRThnc3RYYWtwY3p0OS9TSk9W?=
 =?utf-8?B?bDNWTGJ4a3JCdXBZcG5CNHRjWXY3MCtLNll1Z2J0bmx5czQ5ajZUVEt0eFdE?=
 =?utf-8?B?VHpDeEtiY3JJMzVpcERmdGI2dEFhNzd2MXpqMDVDaExVZFByRnBoUk9RYUlR?=
 =?utf-8?B?L1BzUFE5Vjl0bnVxeWllY0JGa01SSWJvYmh4WXJUb1huaGhHUjdhL0h6WHJl?=
 =?utf-8?B?OUpmSCsvL3QvUzNGcWVaVXQvMUIrZUFWenI3eHBCdVpRNytzY3p6UDI1aVVi?=
 =?utf-8?B?cnhZQWd3c3VUWEpUcnJhdlJTWEpQU29jQng5bUJvNG1wVUNKM0V6bGt0UG1R?=
 =?utf-8?B?bDFHUzJXN2FTVnE5MmM0VEpKbWpPUllvaFpPaVl6ZTlxWk5PUVZYVmZUZlBo?=
 =?utf-8?B?a2lJN2NicGNwdVp2ZmJNTGNKQU5zRU1sallaUk9xdEI1Y2loN3hVdk9zdnJB?=
 =?utf-8?B?K0pXR0grL3FHcWxUc2JGbGpIWk9qVSs1VUhxSVAraEd5WkZhTk0ySnVnUHc4?=
 =?utf-8?B?b2hpempUSldZdVUyUWIxWFZKMk5ZR1Y1bk5XbUdJdnk1TXdZb2FIbmRyMEIw?=
 =?utf-8?B?ZWtZWWRCSzFTUnR2QUx4QmFCaFlmZ0t0NWxQYmMyOFpJSExqU3dac2U4dWdz?=
 =?utf-8?B?d00wZmRRQ0RBVUZMTitMMkpoK3lRQTVZSHN5Y01qTi9ERkxSTVoyQ3JxRVFJ?=
 =?utf-8?B?aldkZEtNYzBvcDF4TVFqaWZWTFBnV0RXbnJ2NENoUTFTNnQyWC9ZT3gwQ0FE?=
 =?utf-8?B?VllLbFFDZ2dXUEdORlBCWmN5WTJuTmp6ZVhqS1FYZVVGcUN5NWFrdlpZejNk?=
 =?utf-8?Q?bViQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf437a3-d202-4edb-5b4a-08dcd278d7e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 15:46:03.9726 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uyx2GIwWo5g2x0hflXEsazPVjxCJcul5e3I6RQgf/gOiBV09FibAandj7z2HNvTa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4424
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
Cg0KUmV2aWV3ZWQtYnk6IExlbyBMaXUgPGxlby5saXVAYW1kLmNvbT4NCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdW5kYXJhcmFqdSwgU2F0aGlzaGt1bWFyIDxTYXRo
aXNoa3VtYXIuU3VuZGFyYXJhanVAYW1kLmNvbT4NCj4gU2VudDogU2VwdGVtYmVyIDEwLCAyMDI0
IDEwOjMyIEFNDQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogTGl1
LCBMZW8gPExlby5MaXVAYW1kLmNvbT47IFN1bmRhcmFyYWp1LCBTYXRoaXNoa3VtYXINCj4gPFNh
dGhpc2hrdW1hci5TdW5kYXJhcmFqdUBhbWQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9h
bWRncHU6IGFkZCBhbWRncHVfanBlZ19zY2hlZF9tYXNrIGRlYnVnZnMNCj4NCj4gSlBFR180XzBf
MyBoYXMgdXAgdG8gMzIganBlZyBjb3JlcyBhbmQgYSBzaW5nbGUgbWpwZWcgdmlkZW8gZGVjb2Rl
IHdpbGwgdXNlDQo+IGFsbCBhdmFpbGFibGUgY29yZXMgb24gdGhlIGhhcmR3YXJlLiBUaGlzIGRl
YnVnZnMgZW50cnkgaGVscHMgdG8gZGlzYWJsZSBvcg0KPiBlbmFibGUgam9iIHN1Ym1pc3Npb24g
dG8gYSBjbHVzdGVyIG9mIGNvcmVzIG9yIG9uZSBzcGVjaWZpYyBjb3JlIGluIHRoZSBpcCBmb3IN
Cj4gZGVidWdnaW5nLiBUaGUgZW50cnkgaXMgcG9wdWxhdGVkIG9ubHkgaWYgdGhlcmUgaXMgYXQg
bGVhc3QgdHdvIG9yIG1vcmUgY29yZXMgaW4NCj4gdGhlIGpwZWcgaXAuDQo+DQo+IFNpZ25lZC1v
ZmYtYnk6IFNhdGhpc2hrdW1hciBTIDxzYXRoaXNoa3VtYXIuc3VuZGFyYXJhanVAYW1kLmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jIHwg
IDIgKw0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pwZWcuYyAgICB8IDcx
DQo+ICsrKysrKysrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2pwZWcuaCAgICB8ICAxICsNCj4gIDMgZmlsZXMgY2hhbmdlZCwgNzQgaW5zZXJ0aW9u
cygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RlYnVnZnMuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2Zz
LmMNCj4gaW5kZXggY2JlZjcyMGRlNzc5Li4zN2Q4NjU3ZjA3NzYgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYw0KPiBAQCAtMjA5NSw2ICsyMDk1
LDggQEAgaW50IGFtZGdwdV9kZWJ1Z2ZzX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UNCj4gKmFk
ZXYpDQo+ICAgICAgIGlmIChhbWRncHVfdW1zY2hfbW0gJiBhbWRncHVfdW1zY2hfbW1fZndsb2cp
DQo+ICAgICAgICAgICAgICAgYW1kZ3B1X2RlYnVnZnNfdW1zY2hfZndsb2dfaW5pdChhZGV2LCAm
YWRldi0NCj4gPnVtc2NoX21tKTsNCj4NCj4gKyAgICAgYW1kZ3B1X2RlYnVnZnNfanBlZ19zY2hl
ZF9tYXNrX2luaXQoYWRldik7DQo+ICsNCj4gICAgICAgYW1kZ3B1X3Jhc19kZWJ1Z2ZzX2NyZWF0
ZV9hbGwoYWRldik7DQo+ICAgICAgIGFtZGdwdV9yYXBfZGVidWdmc19pbml0KGFkZXYpOw0KPiAg
ICAgICBhbWRncHVfc2VjdXJlZGlzcGxheV9kZWJ1Z2ZzX2luaXQoYWRldik7DQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfanBlZy5jDQo+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pwZWcuYw0KPiBpbmRleCA2ZGY5OWNiMDBkOWEu
LmVkZjBhNTBkZDM0NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2pwZWcuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
anBlZy5jDQo+IEBAIC0zNDIsMyArMzQyLDc0IEBAIGludCBhbWRncHVfanBlZ19wc3BfdXBkYXRl
X3NyYW0oc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGludCBpbnN0X2lkeCwNCj4NCj4g
ICAgICAgcmV0dXJuIHBzcF9leGVjdXRlX2lwX2Z3X2xvYWQoJmFkZXYtPnBzcCwgJnVjb2RlKTsg
IH0NCj4gKw0KPiArLyoNCj4gKyAqIGRlYnVnZnMgZm9yIHRvIGVuYWJsZS9kaXNhYmxlIGpwZWcg
am9iIHN1Ym1pc3Npb24gdG8gc3BlY2lmaWMgY29yZS4NCj4gKyAqLw0KPiArI2lmIGRlZmluZWQo
Q09ORklHX0RFQlVHX0ZTKQ0KPiArc3RhdGljIGludCBhbWRncHVfZGVidWdmc19qcGVnX3NjaGVk
X21hc2tfc2V0KHZvaWQgKmRhdGEsIHU2NCB2YWwpIHsNCj4gKyAgICAgc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKikgZGF0YTsNCj4gKyAgICAgdWlu
dDMyX3QgaSwgajsNCj4gKyAgICAgdWludDY0X3QgbWFzayA9IDA7DQo+ICsgICAgIHN0cnVjdCBh
bWRncHVfcmluZyAqcmluZzsNCj4gKw0KPiArICAgICBpZiAoIWFkZXYpDQo+ICsgICAgICAgICAg
ICAgcmV0dXJuIC1FTk9ERVY7DQo+ICsNCj4gKyAgICAgbWFzayA9ICgxIDw8IChhZGV2LT5qcGVn
Lm51bV9qcGVnX2luc3QgKiBhZGV2LQ0KPiA+anBlZy5udW1fanBlZ19yaW5ncykpIC0gMTsNCj4g
KyAgICAgaWYgKCh2YWwgJiBtYXNrKSA9PSAwKQ0KPiArICAgICAgICAgICAgIHJldHVybiAtRUlO
VkFMOw0KPiArDQo+ICsgICAgIGZvciAoaSA9IDA7IGkgPCBhZGV2LT5qcGVnLm51bV9qcGVnX2lu
c3Q7ICsraSkgew0KPiArICAgICAgICAgICAgIGZvciAoaiA9IDA7IGogPCBhZGV2LT5qcGVnLm51
bV9qcGVnX3JpbmdzOyArK2opIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgIHJpbmcgPSAmYWRl
di0+anBlZy5pbnN0W2ldLnJpbmdfZGVjW2pdOw0KPiArICAgICAgICAgICAgICAgICAgICAgaWYg
KHZhbCAmICgxIDw8ICgoaSAqIGFkZXYtPmpwZWcubnVtX2pwZWdfcmluZ3MpICsgaikpKQ0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICByaW5nLT5zY2hlZC5yZWFkeSA9IHRydWU7DQo+
ICsgICAgICAgICAgICAgICAgICAgICBlbHNlDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHJpbmctPnNjaGVkLnJlYWR5ID0gZmFsc2U7DQo+ICsgICAgICAgICAgICAgfQ0KPiArICAg
ICB9DQo+ICsgICAgIC8qIHB1Ymxpc2ggc2NoZWQucmVhZHkgZmxhZyB1cGRhdGUgZWZmZWN0aXZl
IGltbWVkaWF0ZWx5IGFjcm9zcyBzbXANCj4gKi8NCj4gKyAgICAgc21wX3JtYigpOw0KPiArICAg
ICByZXR1cm4gMDsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCBhbWRncHVfZGVidWdmc19qcGVn
X3NjaGVkX21hc2tfZ2V0KHZvaWQgKmRhdGEsIHU2NCAqdmFsKSB7DQo+ICsgICAgIHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopIGRhdGE7DQo+ICsg
ICAgIHVpbnQzMl90IGksIGo7DQo+ICsgICAgIHVpbnQ2NF90IG1hc2sgPSAwOw0KPiArICAgICBz
dHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmc7DQo+ICsNCj4gKyAgICAgaWYgKCFhZGV2KQ0KPiArICAg
ICAgICAgICAgIHJldHVybiAtRU5PREVWOw0KPiArICAgICBmb3IgKGkgPSAwOyBpIDwgYWRldi0+
anBlZy5udW1fanBlZ19pbnN0OyArK2kpIHsNCj4gKyAgICAgICAgICAgICBmb3IgKGogPSAwOyBq
IDwgYWRldi0+anBlZy5udW1fanBlZ19yaW5nczsgKytqKSB7DQo+ICsgICAgICAgICAgICAgICAg
ICAgICByaW5nID0gJmFkZXYtPmpwZWcuaW5zdFtpXS5yaW5nX2RlY1tqXTsNCj4gKyAgICAgICAg
ICAgICAgICAgICAgIGlmIChyaW5nLT5zY2hlZC5yZWFkeSkNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgbWFzayB8PSAxIDw8ICgoaSAqIGFkZXYtDQo+ID5qcGVnLm51bV9qcGVnX3Jp
bmdzKSArIGopOw0KPiArICAgICAgICAgICAgIH0NCj4gKyAgICAgfQ0KPiArICAgICAqdmFsID0g
bWFzazsNCj4gKyAgICAgcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK0RFRklORV9ERUJVR0ZTX0FU
VFJJQlVURShhbWRncHVfZGVidWdmc19qcGVnX3NjaGVkX21hc2tfZm9wcywNCj4gKyAgICAgYW1k
Z3B1X2RlYnVnZnNfanBlZ19zY2hlZF9tYXNrX2dldCwNCj4gK2FtZGdwdV9kZWJ1Z2ZzX2pwZWdf
c2NoZWRfbWFza19zZXQsICIlbGx4XG4iKTsgI2VuZGlmDQo+ICsNCj4gK3ZvaWQgYW1kZ3B1X2Rl
YnVnZnNfanBlZ19zY2hlZF9tYXNrX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+
IHsNCj4gKyNpZiBkZWZpbmVkKENPTkZJR19ERUJVR19GUykNCj4gKyAgICAgc3RydWN0IGRybV9t
aW5vciAqbWlub3IgPSBhZGV2X3RvX2RybShhZGV2KS0+cHJpbWFyeTsNCj4gKyAgICAgc3RydWN0
IGRlbnRyeSAqcm9vdCA9IG1pbm9yLT5kZWJ1Z2ZzX3Jvb3Q7DQo+ICsgICAgIGNoYXIgbmFtZVsz
Ml07DQo+ICsNCj4gKyAgICAgaWYgKCEoYWRldi0+anBlZy5udW1fanBlZ19pbnN0ID4gMSkgJiYg
IShhZGV2LT5qcGVnLm51bV9qcGVnX3JpbmdzDQo+ID4gMSkpDQo+ICsgICAgICAgICAgICAgcmV0
dXJuOw0KPiArICAgICBzcHJpbnRmKG5hbWUsICJhbWRncHVfanBlZ19zY2hlZF9tYXNrIik7DQo+
ICsgICAgIGRlYnVnZnNfY3JlYXRlX2ZpbGUobmFtZSwgMDYwMCwgcm9vdCwgYWRldiwNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICZhbWRncHVfZGVidWdmc19qcGVnX3NjaGVkX21h
c2tfZm9wcyk7DQo+ICsjZW5kaWYNCj4gK30NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9qcGVnLmgNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfanBlZy5oDQo+IGluZGV4IGY5Y2RkODczYWM5Yi4uODE5ZGM3YTBhZjk5IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfanBlZy5oDQo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qcGVnLmgNCj4gQEAgLTE0OSw1
ICsxNDksNiBAQCBpbnQgYW1kZ3B1X2pwZWdfcmFzX2xhdGVfaW5pdChzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZQ0KPiAqYWRldiwgIGludCBhbWRncHVfanBlZ19yYXNfc3dfaW5pdChzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldik7ICBpbnQNCj4gYW1kZ3B1X2pwZWdfcHNwX3VwZGF0ZV9zcmFtKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LCBpbnQgaW5zdF9pZHgsDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZW51bSBBTURHUFVfVUNPREVfSUQgdWNvZGVfaWQpOw0KPiArdm9pZCBhbWRn
cHVfZGVidWdmc19qcGVnX3NjaGVkX21hc2tfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dik7DQo+DQo+ICAjZW5kaWYgLypfX0FNREdQVV9KUEVHX0hfXyovDQo+IC0tDQo+IDIuMjUuMQ0K
DQo=
