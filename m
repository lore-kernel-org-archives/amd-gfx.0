Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B10CCCD199
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 13:23:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CD5510EBEC;
	Fri, 17 Oct 2025 13:23:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4bx0dppZ";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010002.outbound.protection.outlook.com [52.101.46.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC88810EBEC
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 13:23:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3iiIpmzr5qDbLStFaEbbxF26FaDxWpOn7kqkiWioNSOtJGwfsy0rjAHMZoQ0IdPp+6cBoDtF+anGHz3cSokmtMJJpDmb7eNQDJbdPZ5lAVeL4IT35O6A1p2h4qvj9ncN4XAhEVVK4D+kruXs589fzA9DXiOM7FMPihQj0ygXeKxF7LgRpUPbppA8V3ihcnnxvHweEYnBw4Y031WhRR4kR76pXUXIt2NXfnjXfRttmxGgOEtZhD8nWicbRtLPFA8YBttwQ86a7uvTcEXWqc1io6qJalMZMW+9/fs3gkUVVmm9WDAQBXUgcWmE+pXPMB30XdonttPM7tKSa0UFjAF4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOo+K8spoF1fXBkgOYPqOQfXb7Gi+L6IVoQhWF1cbD0=;
 b=IGbTnAsa/Zi2+CVHkYFcKbV0v3kBldR3ydRiIl1yWlasbdsuoq1u0A020FDYC9GDvG/HXna/O991uMu/45B1iTk0DGY+UUzmGGYxwOQ0+cDNIJYWUh7tKX3mrXiVE8taa3VhnYKiwfVvdofYcjShIZ4Li95BSVP/sG/y3y/HlvZ6Jjb85kALismD8KZ6TKbMDGT42us3G+XEpSWVfcpZ3TZ3SzXsKgg9w2NNzYIWScRaH2N29Cv6MkZ6RPWAjODdx2CQGz8r6t4Xv4gEjnTIiZVobQSPxApsZ0CPmK00OL0j6+wnnoncqoF5pbRko42bByN7cp+7AU+z5pkoNFoO9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOo+K8spoF1fXBkgOYPqOQfXb7Gi+L6IVoQhWF1cbD0=;
 b=4bx0dppZdbNT/aWdNEbL8JjQYv/sSNUYUJNvUhSPH1w6R3NOB38S+EcGUWr6f8P5kboqKTVCAkPySj7AgWRt8MdB0lVSmaTXtwmoC6iIuiBPFwhjyBXeCB6iHIWE5/pRgbuD4oRM3BkIYRBuBmtgZuuOnrnPi8zd2KAQGMOxWPo=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CH1PR12MB9647.namprd12.prod.outlook.com (2603:10b6:610:2b0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 13:23:05 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%5]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 13:23:04 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: fix missed lock in
 amdgpu_gfx_profile_ring_begin_use()
Thread-Topic: [PATCH] drm/amd/amdgpu: fix missed lock in
 amdgpu_gfx_profile_ring_begin_use()
Thread-Index: AQHcPkXFzdvNztXc40emnzsVvq09T7TFIFGAgAEyeUA=
Date: Fri, 17 Oct 2025 13:23:04 +0000
Message-ID: <PH7PR12MB5997FD7FA4EAC7170FAC368082F6A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20251016023644.3143128-1-kevinyang.wang@amd.com>
 <CADnq5_OaJavuQf=LgBzQKAXmCxoZMnUwXAOgo-NV=toY4qawXw@mail.gmail.com>
In-Reply-To: <CADnq5_OaJavuQf=LgBzQKAXmCxoZMnUwXAOgo-NV=toY4qawXw@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-17T13:12:20.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CH1PR12MB9647:EE_
x-ms-office365-filtering-correlation-id: 1bdfbbf8-a2d5-4a9f-1917-08de0d804db8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?V0xjNGIrajhkZ1BQalRITktnV3Z5Q3ZHZVd4emdsbFpVL2hIR1c1VWhpZFNl?=
 =?utf-8?B?am9HVWgxdU95RDhKUkhsSlQ4VWVmSEZ4RWV1R2pVMkttMjNaVFBQb3Ard1I2?=
 =?utf-8?B?d0kyVWxGaWtIZGpEakVmN2lKbm5BcTBQNVNET1l3b2dFSndicElwMW96S093?=
 =?utf-8?B?VVo4VVRPcTU4b1E3UlBSOHlaWFZPbU1KMWFsaFZQSS9aenkxWE56MTZoSTAx?=
 =?utf-8?B?S3ZsTW8xQ1V3enl4dzFLSlJ4SUxwUVMzek5Gdk5FYXl6b3JXN2V5SHgwVGpn?=
 =?utf-8?B?TElMM2FjRjZrMWMxR1ZRR2ZEbk5DLzFBMS9ZTzNpd0ZUcE82UEVUaDdnaW5H?=
 =?utf-8?B?emJzK0hiaUptR1lNWUxFOWpBeDBvcVRtSDA0U1luT293WFZ6QkNtNDhXK3Ny?=
 =?utf-8?B?YWQwQkt6c1JLcFdrem91cFA2MFdSWUFyYzhTVGk0WWpHS0M1VEdiL2FDV3Jx?=
 =?utf-8?B?V0ZxKzRSTk9POUhWRDNGdGpIYmx2amtkTlgrRDBIWUtBNkNnWXFHRElSR3d5?=
 =?utf-8?B?WkZORGEzYzVDMWoxaGhJZTEydVpaRlc5K0V2MGlDQ3dIZnVTRjBxSUhHT3Vn?=
 =?utf-8?B?RXd4SkwyOWFscGFjTVJpZ3REQmZIa2E1Q00yZmJPUGpTVjEzcnQwREM0M0ZB?=
 =?utf-8?B?dG5HT0FFMjRDNHhKKyt0TWJPSlBhZGY3b0NZTlIvWExKSjJ1TW01N0VHUllr?=
 =?utf-8?B?VXBvek1iOENDYVR0NUVFaTdRa0gzVEUwZHA1dnl6d1ZsSmpIZVUwb0tOWk1h?=
 =?utf-8?B?djIwYmlldzBja1E0RnJEbmN5RnpFaHUzY081cDRGTy9SckhvQUxWR3B2V3ZX?=
 =?utf-8?B?dXJoSVZWMkI2Uk9RTXJzeXFDWWhtR21WdzZOcHQzRkdRM2NtbmJLQ29iMmE2?=
 =?utf-8?B?by9Yc3BmZjZjOXpiLzQvOUFyRytUZ2FiZ2ZlVUJDalBhdG9yNkxLSlA5VVRY?=
 =?utf-8?B?YnkvclRZc3VZZkVhMEYrcVpTeHBjd1FXWjNDYVhmNUYvYjduejQwcjJXVDNX?=
 =?utf-8?B?VEhOWFhjRVptL1Q1dlJTbTFiakhmYmpjaDJ4WWJMMW80aWRQNGVrRm9weU82?=
 =?utf-8?B?YzNoc1F0cXZsdWdXR3lHSmdNWHdkQlZXa2RiR25wQkJ1M1RSYnBYMnlkMmdp?=
 =?utf-8?B?WEg1R1lXSlVVVk1YNWVJRTd5RGRma2thbU1iTEE5OUo4NkpkS016SUMyT2M5?=
 =?utf-8?B?Uk9qQW95Q3duV041eXNxcXdOV3I4MTN3UUdJM0RZR1Z5RXQ5V25kOVFEL0lt?=
 =?utf-8?B?djJ1VEt4REF5V3M4VGZGSFpyeTl6d2lyS3JvbldKMkl2WUhabURiNkg1Vy9Q?=
 =?utf-8?B?UHJITGlCL2xRQmxicHZXNFZNb2U1WTM4N2pkaEd4ZmE0YUpxSkRSSHpLTXkr?=
 =?utf-8?B?T0VUMDVjNU9vMU5DdE81OXN5enl6RGR5Snk5K0Z3aGhkZDlNMnh0RVY5cmNv?=
 =?utf-8?B?eDBUMno0dVMrU2MvODhIRXZGL3RrOEJvcDNtVFZORWRBK1I3TVk0aTEwK0xp?=
 =?utf-8?B?TkRIaGdWOGV0WE9tYmFyUC92MC85TDUrWjZKeFNDdkhGSEFaUkFHWEdGcEk2?=
 =?utf-8?B?ejBlNXlmemJqREQyNHJYcFlrWnRjMGNnOFRmUkRyUGJNWE53Zjhuc3pZbG03?=
 =?utf-8?B?d3ZFT0VMeVF0VVNmcThwbVhSZHpjanNCY2ZscUF0M2lkbnZucUJhNUk1VUlx?=
 =?utf-8?B?TzdKTjlBbHV0MGkxUXZGNUo5OGJkTEZYZ3p4Vk5UeFlHR04vcVM1RVJUSklC?=
 =?utf-8?B?VUo4RGJSUXFHMm13WFZTT0ZScnZ5WnVIUnpvcWpPK3B1ejIyNkRFUk9JUjZL?=
 =?utf-8?B?N2hBOThia2tQOEwrdnJrbExpc1AxVS9pK29LSUo0aVc4elpTQXdwTzdHSW8z?=
 =?utf-8?B?c3VadHhUNVFtLzliQ2JBLzNFcmJpbUFrZFZaQW9CeHRlRkcxVlNLOE95RGRB?=
 =?utf-8?B?aWI1aEQ1RTc4NXpaTjJqM3ZYcFdJRlNmWEpoQjNIQkJFWDNLYk1KY0hNR2Ft?=
 =?utf-8?B?OWxtUVpRbWJiSFRwRURibWNsa1RzR2Rva2xaemk0M1lEaTFwWmNJK1pHcXZY?=
 =?utf-8?Q?zQUdaW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVpvZjRjdktOeTR4RFhFNmk2MjNrdTA1SG5hLytLS1hMV1phK2E2QmJNYXBs?=
 =?utf-8?B?aWwraDJSSzZuME9DOHZoZ1JiVXlXSlhhNHFzUzNXblZhdU5MSmczRWE0WUdB?=
 =?utf-8?B?S0g5YWlzUXlXS3J5T0hPa3JrK0FPVFA2MkNmRWJCelV4Umg2ZVh2cnJZRlB0?=
 =?utf-8?B?bnpheDVVcW5SRnY4ajl0aHMvamxqYWxqcjN5bmcxeEJpVGs1dU5nT044Q1JS?=
 =?utf-8?B?dFZOVEgySzI0Q2VLaHMxWkdEWFlOa1BXYy9TOEhLSHJOVDhZVUc4eEw2cVYw?=
 =?utf-8?B?ZXdzUEtOTG1SdGpmUWhSbHZBYjg3TGtDNjdVdVJYTnJzTUhoTUl0VzduUjA3?=
 =?utf-8?B?Snd4b3pOMHJLYTByMXNyWGsxMVdmUE0wcjNzby8vYUJJa1JvUmdscHI0TXpO?=
 =?utf-8?B?QzNOVU1RcTRmemFBUFgzM3A5amNFb0ROczA5aW11NXNadXhwRUdHT3MzNTBq?=
 =?utf-8?B?OWFnWElic2prSGdhakdJY2tOSThCOGMwSmFNNDgweldtUG9aQ1l3M2JDMnYr?=
 =?utf-8?B?ck1ZWHk4OEc1VXo1WC9OMXJDNTY5MkhXcldBZmprTXZUeUJwSWZJY3dVWUk1?=
 =?utf-8?B?bFJ6ZDFsTEZVbXFjcTVidHpKRktJaXg2RlFWVUNyQ05iT1dDMzhjcUloNlkr?=
 =?utf-8?B?SkxHRDVCcGRnN3lsTGJtNlhGc1RwMGdRSElodG1EdEFiZk41bEhzQWpqZjkr?=
 =?utf-8?B?THV4bDc3VjdmbnE5cEVaamNsZ2NKd1hVLzdWWlYzeER6a0swVTQ2ZytSckdS?=
 =?utf-8?B?TzFCZ2VieTBocEw5NFdGMzVubEtEVFlnbE0zZ0t2UE1QcFRWd1FKVmxZeGNW?=
 =?utf-8?B?aDEzYjhIeVk3b1JEZGw1WGJHd2k5VUUwdjZLYk5XZE5MSi81OXh6ZnROOHZ3?=
 =?utf-8?B?Sjd5c0VrcGd3b21iYnRqMUh2dk9SVURWS3oyRWVZVkRjL05jVisrMTVJTHBs?=
 =?utf-8?B?RG9iQlRQM0pWNGdoaVR4RDBRRldEVFh6Uk0wam84emR1VGk2MTRIU0o1cTNz?=
 =?utf-8?B?ckJQVkYxamQ0SUlSSXdTQ3d3cnpScXc1OENVaG9VMGNFTUZFTFdpZVZJUG9h?=
 =?utf-8?B?YUZWOG55Qlp4VkN1V2ZhZVkzVVhqY0tyblNpSlRJQ0NjRDRUanFPeGhobVdR?=
 =?utf-8?B?T1MvUXAvblE2ZDBEZWVZTkJPSVpJbllRdTYzZEJSOTBWOXlscW80bDZ6R0JG?=
 =?utf-8?B?dkpOdVUrdmxkUTUvWlVLR1dXeXRRRWY4bnRVNmMrR3M4SDlHdzhTWXR0ZHRL?=
 =?utf-8?B?UUlGbFdnNy9MUkkzUldUdnNPYW5nVHZGd1E3a0FURUV0QmwxN29YcG9YYy93?=
 =?utf-8?B?QmM3MHIzbktNV0tERmtSRGViZ2RoQXpscUQ3TTBKUzVJdkxkSzVUaEc0dVhX?=
 =?utf-8?B?RmowSUYzU0lwWWlJQUFBVjd5dDZ0ZDR0SWJVcWY2MUZqL29vbWJFZUNmWXdD?=
 =?utf-8?B?RVpMc0VMM3pIMU9oWlhMc0VhVjlWM3c3NHM5OFpkTHl0RlQyZmNrdGJjRGI3?=
 =?utf-8?B?TXc0SnFYRnk4bjhaajZDeDdkUmFvK2lvVndMVldLODlhQVBLQS8zUmNCUUlJ?=
 =?utf-8?B?U1FYZWNESEVHYzJPamR6akZ1d1BQN2huZkhmRXFDcWZNUFdHSGd2Y2JQQUZp?=
 =?utf-8?B?MUxCbldLanVYRXlyby9aK045TmszTEZWSVAwTnRwdk5OaWZjSDFORmI0Q3Uv?=
 =?utf-8?B?RVMwaXZ3cDd4bTFiTmovRGxJL2ZhQnBrUnc5WGtTSG5sMEpQWjFFc3hyb2JH?=
 =?utf-8?B?ODJwblhjc1E2TTl2Y0dyVzJvdWV3TE55ZlRpanYrMExBWEt4bHZ2NmZRY2FP?=
 =?utf-8?B?TWNmRzc3L2NPYUpFZVZJR1BnVEFTRzg3RUdDWW54V0FlbFc4STJLV3hzK1lY?=
 =?utf-8?B?VDdrbnowZ0NrM3RueXprSlVVRE1CMU1xZUc1OEkrc0pGYlhjR1g0VjljcUFU?=
 =?utf-8?B?bVY1UWhwaEUrYUU4anRTT0NSbU9IcVpxU1h3RG9BaFIrcWNiR3Q4UTZYMzlC?=
 =?utf-8?B?WTczQVN3U0pDMXpCWGNJZ1V0b0hUcVlqdTFjSXlIUFROalhYNWd3SUptSmtJ?=
 =?utf-8?B?V2hQVDhpODkwZkpDUHVGbEhacWllK3g1QU9pRER1ZFB2dVpFWVhXYTU5RVZo?=
 =?utf-8?Q?XvhA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bdfbbf8-a2d5-4a9f-1917-08de0d804db8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 13:23:04.3487 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DBxuia6SvkTZ7wsHPFXFlkObz89RV4TWN1Nt+sB7eILwS7zlhtuvwBeIpYimDiFw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9647
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
dWNoZXJAZ21haWwuY29tPg0KU2VudDogRnJpZGF5LCBPY3RvYmVyIDE3LCAyMDI1IDI6NTUgQU0N
ClRvOiBXYW5nLCBZYW5nKEtldmluKSA8S2V2aW5ZYW5nLldhbmdAYW1kLmNvbT4NCkNjOiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdA
YW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4N
ClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWQvYW1kZ3B1OiBmaXggbWlzc2VkIGxvY2sgaW4g
YW1kZ3B1X2dmeF9wcm9maWxlX3JpbmdfYmVnaW5fdXNlKCkNCg0KT24gV2VkLCBPY3QgMTUsIDIw
MjUgYXQgMTE6MjbigK9QTSBZYW5nIFdhbmcgPGtldmlueWFuZy53YW5nQGFtZC5jb20+IHdyb3Rl
Og0KPg0KPiB0aGUgZ2Z4IGRyaXZlciBuZWVkIHRvIGhvbGQgbG9jayAoYWRldi0+Z2Z4Lndvcmts
b2FkX3Byb2ZpbGVfbXV0ZXgpDQo+IGJlZm9yZSBhY2Nlc3MgImFkZXYtPmdmeC53b3JrbG9hZF9w
cm9maWxlX2FjdGl2ZSIgdmFyaWJsZS4NCj4NCj4gRml4ZXM6IDllMzRkOGQxYTFhYmUgKCJkcm0v
YW1kZ3B1L2dmeDogYWRqdXN0IHdvcmtsb2FkIHByb2ZpbGUNCj4gaGFuZGxpbmciKQ0KPg0KPiBT
aWduZWQtb2ZmLWJ5OiBZYW5nIFdhbmcgPGtldmlueWFuZy53YW5nQGFtZC5jb20+DQo+IC0tLQ0K
PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jIHwgOSArKysrKy0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+DQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMNCj4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMNCj4gaW5kZXggN2YwMmUz
NmNjYzFlLi41OTMyOWU4ZmZiODYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9nZnguYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZ2Z4LmMNCj4gQEAgLTIyNDksMTEgKzIyNDksMTAgQEAgdm9pZCBhbWRncHVfZ2Z4X3By
b2ZpbGVfcmluZ19iZWdpbl91c2Uoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQ0KPiAgICAgICAg
ICAqIHRoZSBkZWxheWVkIHdvcmsgc28gdGhlcmUgaXMgbm8gb25lIGVsc2UgdG8gc2V0IGl0IHRv
IGZhbHNlDQo+ICAgICAgICAgICogYW5kIHdlIGRvbid0IGNhcmUgaWYgc29tZW9uZSBlbHNlIHNl
dHMgaXQgdG8gdHJ1ZS4NCj4gICAgICAgICAgKi8NCj4gLSAgICAgICBpZiAoYWRldi0+Z2Z4Lndv
cmtsb2FkX3Byb2ZpbGVfYWN0aXZlKQ0KPiAtICAgICAgICAgICAgICAgcmV0dXJuOw0KDQpQZXIg
dGhlIGNvbW1lbnQgYWJvdmUsIHRoaXMgc2hvdWxkIGJlIHNhZmUuDQoNCkFsZXgNCg0KW0tldmlu
XToNCkFsbCBnZngvY29tcHV0ZSBrZXJuZWwgcmluZy0+YmVnaW5fdXNlL2VuZF91c2UoKSBjYWxs
YmFjayBmdW5jdGlvbnMgd2lsbCBiZSBjYWxsZWQgYXQgdGhlIHNhbWUgdGltZSBmcm9tIGRpZmZl
cmVudCB0aHJlYWRzIChzdWNoIGFzIGRybSBzY2hlZCB0aHJlYWQgYW5kIGlvY3RsIHVzZXIgdGhy
ZWFkKQ0KdGhlcmUgbWF5IHN0aWxsIGJlIHNvbWUgY29udGVudGlvbiBoZXJlLCBob2xkaW5nIHRo
aXMgbG9jayBjYW4gZW5zdXJlIHNhZmUgYWNjZXNzIGluIGRpZmZlcmVudCBzY2VuYXJpb3MuDQoN
CkJlc3QgUmVnYXJkcywNCktldmluDQoNCj4gLQ0KPiAgICAgICAgIG11dGV4X2xvY2soJmFkZXYt
PmdmeC53b3JrbG9hZF9wcm9maWxlX211dGV4KTsNCj4gLSAgICAgICBpZiAoIWFkZXYtPmdmeC53
b3JrbG9hZF9wcm9maWxlX2FjdGl2ZSkgew0KPiArICAgICAgIGlmIChhZGV2LT5nZngud29ya2xv
YWRfcHJvZmlsZV9hY3RpdmUpIHsNCj4gKyAgICAgICAgICAgICAgIGdvdG8gb3V0X3VubG9jazsN
Cj4gKyAgICAgICB9IGVsc2Ugew0KPiAgICAgICAgICAgICAgICAgciA9IGFtZGdwdV9kcG1fc3dp
dGNoX3Bvd2VyX3Byb2ZpbGUoYWRldiwgcHJvZmlsZSwgdHJ1ZSk7DQo+ICAgICAgICAgICAgICAg
ICBpZiAocikNCj4gICAgICAgICAgICAgICAgICAgICAgICAgZGV2X3dhcm4oYWRldi0+ZGV2LCAi
KCVkKSBmYWlsZWQgdG8gZGlzYWJsZSAlcw0KPiBwb3dlciBwcm9maWxlIG1vZGVcbiIsIHIsIEBA
IC0yMjYxLDYgKzIyNjAsOCBAQCB2b2lkIGFtZGdwdV9nZnhfcHJvZmlsZV9yaW5nX2JlZ2luX3Vz
ZShzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICJmdWxsc2NyZWVuIDNEIiA6ICJjb21wdXRlIik7DQo+ICAgICAgICAgICAgICAgICBh
ZGV2LT5nZngud29ya2xvYWRfcHJvZmlsZV9hY3RpdmUgPSB0cnVlOw0KPiAgICAgICAgIH0NCj4g
Kw0KPiArb3V0X3VubG9jazoNCj4gICAgICAgICBtdXRleF91bmxvY2soJmFkZXYtPmdmeC53b3Jr
bG9hZF9wcm9maWxlX211dGV4KTsNCj4gIH0NCj4NCj4gLS0NCj4gMi4zNC4xDQo+DQo=
