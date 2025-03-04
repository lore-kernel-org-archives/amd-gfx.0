Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21261C021B8
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 18:03:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C10C710E65E;
	Tue,  4 Mar 2025 18:03:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KCSL9YBh";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4926110E652
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 18:03:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfO82wWsIZF5Xvj4e2s/pUYmLlD88hnM8ixceiisTeVyvASiqSd7GiHXB8ap0TwdI91gXXRz2x8s2FGHhJNrP05BnZRnqPpvce1+jjNmT+bg6bGkAi+ivvuoUNCY4sCt6W7JW6EN6ZJ4+cTRgU1q8z7sdJo8up2Iu2J60NzOnM5vwFSpOikzI6/4EQ2GbgRji2Ck/3HE0oREsVH+s6GvBCCjtWGAV2zp1h+rQ2afntkKgzGGiJglfC17NJnNNt60QkTfrsjpNrF0PXN0+Fqo/JSplJaBxaLRnhL7VLsakca7UMS4PIM56ZbGfwCQKuEqXu6NcKWfCIXxgxxOe0q+9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=by3zic5YNgZLNfKFwWUtq0IGEPBfK5+bot6h9816ZRg=;
 b=lotFh5pVIdzN/2thrsOm82rP38GlhdI58V/XVNI/t8N//xI1ekiU59WiMdoNLSIR7EsTU9lOeBKtRui01HgpBcg/xcb55IU/W194XDnR/WYdEYdcAcHlYR1pzO8yQA5pjTs/dyaTUaJTw1psgYJ3TDNaZKSk67A+813Df9HUXgl40aUD03SN/j6FBf6S3FnhNOAhK5PGDwY6+ZyPzhtwazpamZjP4gtE+9z9b9NQHPQ3J4REaacGQ1h5x+brM645Eib99gQXPiQt06P2YUgRFWuhK2iBLXJIl8fqcnw/mD64mc2yhR07/rNZKxhqNt+YbW9dyAqxDLOxdQnAtrSCbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=by3zic5YNgZLNfKFwWUtq0IGEPBfK5+bot6h9816ZRg=;
 b=KCSL9YBhHX7garicwVGBw8XsgIenq38dvIwYZxt6N+TXkNxBYAz5qAAszTht4qftJxeT945iMbat5X2XAVHTyMXRUE+Euw+IcJioSPgf4l0lI+Oosh0k7WTeHBATKqzTguU4tyL/ff0SywM7KYsnBPb/pKa2EwyJeTIV1n27hZo=
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by LV3PR12MB9403.namprd12.prod.outlook.com (2603:10b6:408:217::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 18:03:19 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%7]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 18:03:19 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Validate return value of pm_runtime_get_sync
Thread-Topic: [PATCH] drm/amdgpu: Validate return value of pm_runtime_get_sync
Thread-Index: AQHbjS4SXCBO8YIANUmuxAyi45VKsLNjQ0sAgAABWCA=
Date: Tue, 4 Mar 2025 18:03:19 +0000
Message-ID: <BL1PR12MB57530EA7AEF0BE777E39B93793C82@BL1PR12MB5753.namprd12.prod.outlook.com>
References: <20250304175128.368511-1-sunil.khatri@amd.com>
 <52638c55-ba64-4cf0-9bf3-8b7935e42f3e@amd.com>
In-Reply-To: <52638c55-ba64-4cf0-9bf3-8b7935e42f3e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=87597799-72bc-4f99-94fd-d1d9e145b2bd;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-04T18:01:48Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5753:EE_|LV3PR12MB9403:EE_
x-ms-office365-filtering-correlation-id: 6067c4eb-4965-4dbb-4f57-08dd5b46d881
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?VXJmVXJuS0ZiS3BteU5wU3NjdjYvdjJLaEJCZCtpZ1FWTURTYnAxb2pSV05N?=
 =?utf-8?B?dzVZWGk0RzRGMkVIbTlWZ2FGTlBDcmt0cWFoQndnSUJ6SGl1R1hZWTJOQ0ZZ?=
 =?utf-8?B?RUw2OWtheWhRVUFzVkZqalBCM0ZJaEZRbWNrV2xwL29KQzNHa01IclhDMEkr?=
 =?utf-8?B?Wml2REdaNnNWVXd4Q3p0VThwakhWTzBIMmdOaVUxV0N2cFhOV2ROeFAvNzdG?=
 =?utf-8?B?bXVwRndFNFM5TExlTWNwNHkxK2ZVNDR5K0hOcVRJVkRPZU1LcWg2RGQ3WGdJ?=
 =?utf-8?B?dVFjbWIwWXNMa2c3WE1ncVBET1RaQ1VjRW03L2wwVVpXdzFjTmhUcHNzQTlP?=
 =?utf-8?B?N3JjTmJoRm9XblNxNlhNeHlOaEd0SHJPN1FHVkxnK0k0VFQxQjB5NEtkdkZ0?=
 =?utf-8?B?RDByTlpmVzVpS2pMalVTZXFZanU0VlZ1cXBXMURsQ2djQWliZWRkeHVoYmlT?=
 =?utf-8?B?RXVmYnVKMG5qYXhlbDl0S1lwWkhVSFhaWlQzNzQvTGFjcGxlMHNjbnU5UXlu?=
 =?utf-8?B?ckc4TTJIQ0NMYXUwN1pERnB4MWZ3aFdwS1IwNXhyMi9yb1JEN0hZQ0MxTytY?=
 =?utf-8?B?VUVsMWpBNHlwd2JOajBoRFFhVDlCWGt5WERuWmtSdFdnbmlmWWtDVkNkVVZr?=
 =?utf-8?B?TGVkZFpHVXZmNElnU2lCcUNqN0FGZ1Bzd3M4TDJrUmI0cW9hbEcrZFkwbk5y?=
 =?utf-8?B?SFQzcURjNkxyUHUvYXE3ekhKNVpZZDBuc3hjTTRZMFQ4blFmdDFJK210amFz?=
 =?utf-8?B?YzYzZFdDTEp4aTU2T0JZazlHcHJ3VHZ2R3FONWJVc0VFS2NuL1F2ZDhxQS9l?=
 =?utf-8?B?czNmTWdibDRQT1FsRS8wOVVPa0dMdldqN2pUZ0tTTHFBL3QzUmlpbkxjNkE3?=
 =?utf-8?B?Z3ZiWTh2b2E5RW9jVXlRc0NMZFpLQVoyN2pLQmNESE1sMldtWjNaMmNEZG9j?=
 =?utf-8?B?Y0k2SEc0cVl1MitSU0JheDdIZ2VQc0xCUWRaWmpBNzFiMU1pOUhNZEd0a1ZJ?=
 =?utf-8?B?SmpQTEo1ZHpVdkxBT3pwREp6UHJSMVJHZkVJeXdKMHJXRTZEcWVpK1hzNHlY?=
 =?utf-8?B?OTFyQjIxRmdPNUYrNjdoL21EcnkyKzBxaXkzSDFHdlVlZ0VHSXQzVG0rR1Fy?=
 =?utf-8?B?U0VNRVk1YlJEQUk1TW84SUJHa2JzNlRoOWRrUHJ0dmQwVHhXUDRnam01VkZu?=
 =?utf-8?B?MzFWYzIzYzBkTDcxWGlCMkpORk14bG9KWlJzOWNicEJGbm9qeHRZUm9yNlhi?=
 =?utf-8?B?U1FnVzVMVFl0SHUwU09XVzRXY0pnN0VqV0hwOGF3ZWplVzUvQXJYbXZlSU9V?=
 =?utf-8?B?OEYrSVYyM2VYM1VnZitiUU9GSXNDampaQ25xdVJ1bWMwNjFwT2dBN2tXaHJQ?=
 =?utf-8?B?N1kzOGpYbDF0d3hYTzQ0a0ZGOEo5S3owUGRGTFcwUTYxODNjNklQTE10Sjdy?=
 =?utf-8?B?Ym0zUy9aem9NamNTSVdDZFNLQjlrZTVRWHFNNm40L1JqYVJmVE8zejVXNE50?=
 =?utf-8?B?WjFSeXBqb2pWc1lDSmE3d3RsSjAycENpQ05BNXdWUDMrWGFvU0tCV056bWlT?=
 =?utf-8?B?SDYxa09XZXhZUWEyd09XbVlhUnhUN2tMSVRoV2dkRVUrb3A2ZFFmS3VMcGdh?=
 =?utf-8?B?NHE4Vkprakp5M0lmR3cxc0t5ZFVhdkFVNVl0dGN0YmlIQThEKy95amZhSDdp?=
 =?utf-8?B?dVlnamQyWGI3aGVNQzBPZkdxSldCWDg3SjJTZWcyb0plMUFVTXRZakFTOG1h?=
 =?utf-8?B?VzMwdHMwS1o1WndiczgxODVMdERVOXpVNHF5K3VHNFNTWENXSGRjYkdvZFlZ?=
 =?utf-8?B?OWh1dWJXTklLTDc2SVdrdmZxY0tROFN1NnNjdm1nZjNUS1ZlSkhTTTA2UHor?=
 =?utf-8?B?NEw2VnhjYXRzM2tKZksxc1J1V29jZG5DUG9wZE4zL1cwcnpPYzREakJ4S09N?=
 =?utf-8?Q?IjFGLtMrUaauRAvCr2CFZfTV6mrpLYZz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3N1anRSTU95ZHNyZytramxnMU1VVGJQaTc0aDhLRzlZTVF0dnBWTjJmcXMx?=
 =?utf-8?B?SDNWZ3RKaVZOT0ltVDRyUlJTNk16ODB6WXhEY0prdnhBK0hibXgzRHdPN1o5?=
 =?utf-8?B?QTFEZWlUQzgvTHB5QnJac1FMcEJGN0lyVWJ1SkhibXRYdHIzZTZ2Y3V5YUpF?=
 =?utf-8?B?REZSYWZLV0RtdmsrYVl0NW1JK0tDbGZ6eG12U2tPRnBINXA3K2lDSXgxeURT?=
 =?utf-8?B?WG1EaTJqc0F5WUthejBZa1FYRHhRYVBYSFU1N2k5UFcxSVRBdlFGSU9QTGd5?=
 =?utf-8?B?RmdUUWZsbkdNcmhnK2Q1Tkd4a3ZRVU52bVJpM0Jod3hrUmtCN2VwYnREUFJQ?=
 =?utf-8?B?ZTZhOTBSVldrTEJWbjJQUzNSMm5OdlYrd0YyVWtPTnRKbWlvNWh4TkcrRmlj?=
 =?utf-8?B?c1RZOTI3YW5tUHZ2RTZTbmVlMUY2ZDZrWkI1RDhSdkJrN2RCSFltUFZxNDRr?=
 =?utf-8?B?aTRXMmtRak8xZFRlTERURHljczBMQWNWSHhCV25UWjhFZ0pBSWt5Ukt6K2Yv?=
 =?utf-8?B?U1ljRGhmU2Y4UVIwdndjNUNDbU5LYkJ0Q0hhdDBwbGdjcEozWjZxeUp0d2d1?=
 =?utf-8?B?cmRQcVFtbnVsQzc0NE8rZlo1c05yWklnN1JNYlhSZjdNd05qVmRUcUkwV1E1?=
 =?utf-8?B?OTAyV2FRQW1BcVpVejdCUFdiOThiaCtxSzgwZVc2dHBaK0ptQmEzTlExK1Ar?=
 =?utf-8?B?cHJDNndNMUVLVkM2TG80bTlpdTQxWmd1MHk1WWJqalkxWHZsMG9VdUx0bG1C?=
 =?utf-8?B?c0hDZGtEVzdILzlSWmp1Nk5XbllJVWVjUFBrRVRYS20xL1lrY1hCSi92ZjNy?=
 =?utf-8?B?MWtKTTFxQ3haZjJCYm5YNE5OdHlYVklyWDBDRGVDSVRkNGVZN1ViZEdoOGVx?=
 =?utf-8?B?UTRVQkQ2ZWREYkhEWHFLbXRLaWJ0cU1kUFhMUTB0a3MxcW41M1dhN0xwc1c5?=
 =?utf-8?B?VHh0Y1BPTUJRYzVtbm0vMVljSklQMWMvcW1SdXc1bjBSekVIa0pldzM1UVFx?=
 =?utf-8?B?ci9kNUNkR3VUVkZaWXdHTTZwUHNSdU1CaitHODVlcXEzTDR0VWJLdmthdmlp?=
 =?utf-8?B?Qy9NcUFvUWNFOVNTa1ErVGhIeEV5d21uNEFoQWQ2bW1Uc21ub29kdmJvSHJH?=
 =?utf-8?B?ekN5ek9tcUJtellBT1ZLZmhrSGR6SFNKOW14MEhUNG1GQ2FDK0xtN0xmNlFr?=
 =?utf-8?B?WE1aTUx3WXZTT1VEU3dud0UrZ2liNHUrM0lxMGl6V3dYOG1tWEloaVRnNTc3?=
 =?utf-8?B?M0xyRDVWV21OMFUwV05pUWEvb2NOQkVFL1ZObkw5S25kQUZ2OVBtVUZRZVZn?=
 =?utf-8?B?SVhhejd4c0NuczdVay9YMkxHb2lHRkJzbFdnVDR1THZJNjdmaDRMdlZOcEhJ?=
 =?utf-8?B?NTg4bXVIZTdxRTVHSWRSNUJIVWdKamtGQXFRWEM3SjI1bHN4K1FQS2ZPMGM5?=
 =?utf-8?B?dkF6ZG9wNDFrV25nNzJGemFLZXl3WVdvTkdVTzRoczIyUXh4dDBNUDIrVzZF?=
 =?utf-8?B?cUdvK0RzUmgva2pBUGZMek5LMGJKRWl2S21JODlNNWYxcm5KdTRpWkpRVjA2?=
 =?utf-8?B?cG5CUTFjTGhCVW10Q1FYQ0g0NUk0UlA4OFpGZmxnS056bTNSeUtvMTR4RUdj?=
 =?utf-8?B?MW1ubFZxOFhWVVNDb3NyVExHQk56RjRzU0o3YWYxR0Joa3A0d1ZiY0xQbDVn?=
 =?utf-8?B?bmlMTjMxcG5Oc3h4aWdxLy9YZTlTOUsvQy9Ib2JnNmQ5cTNINUlNd0NOSHF0?=
 =?utf-8?B?a1BnZkg4OERkVTdFYlVaQ1pldUw1VmV3OWRWSVFLZmQzRkxRL1diTDVmS1Uv?=
 =?utf-8?B?VHVORFhLakNKUWNvaFlKSWJSWGNId1lOd1FFeFllM2Q0SmtDUmt4eXh2THhT?=
 =?utf-8?B?bWU1WlFhRjVmUmN4RHkxc2lpUnJVWkUvWk85WWhsWlVOck13dWRvbWdwelRD?=
 =?utf-8?B?OXFUQjZIUzk4SUlDU05vd2JpUm1TaVZyZ1l6eU9FdVRFK3BCK0Y4MThheEZ5?=
 =?utf-8?B?NUM3ZUNURnRJZ1YveFlwanB1RlhwN3IwblQxVEVhNmdQWTh1M1FkQm9XU2Nm?=
 =?utf-8?B?VExhZEwzZFJUV1pqWUllbEZwTDQrQ2VqSThkbmVwa0dwSlVjR3JkTmlINkx6?=
 =?utf-8?Q?bg9E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6067c4eb-4965-4dbb-4f57-08dd5b46d881
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 18:03:19.4269 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G62NIqFQcK3lCIhJl5N7U1PStdSd/1lFwA13K8jXFs9QlVMrdQTg2Qz6BvIbS7M6jnX+Z8n2SkPfqiuCsYRmRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9403
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
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExpbW9uY2llbGxvLCBNYXJpbyA8
TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT4NClNlbnQ6IFR1ZXNkYXksIE1hcmNoIDQsIDIwMjUg
MTE6MjcgUE0NClRvOiBLaGF0cmksIFN1bmlsIDxTdW5pbC5LaGF0cmlAYW1kLmNvbT47IERldWNo
ZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0
aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IFZhbGlkYXRlIHJldHVy
biB2YWx1ZSBvZiBwbV9ydW50aW1lX2dldF9zeW5jDQoNCk9uIDMvNC8yMDI1IDExOjUxLCBTdW5p
bCBLaGF0cmkgd3JvdGU6DQo+IEFuIGludmFsaWQgcmV0dXJuIHZhbHVlICdyJyBvZiB0aGUgcG1f
cnVudGltZV9nZXRfc3luYyBpcyByIDwgMCBzbyBmaXgNCj4gdGhlIHJldHVybiB2YWx1ZSBhbmQg
YWRkIHByb3BlciBsb2dnaW5nIG9mIGZhaWx1cmUgIGFuZCBleGl0IGNsZWFubHkuDQoNCllvdSBo
YXZlIGFuIGV4dHJhIHNwYWNlIGJldHdlZW4gImZhaWx1cmUiIGFuZCAiYW5kIi4NCk5vdGVkLg0K
DQo+DQo+IFNpZ25lZC1vZmYtYnk6IFN1bmlsIEtoYXRyaSA8c3VuaWwua2hhdHJpQGFtZC5jb20+
DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc191c2VycXVldWUuYyB8
IDUgKysrKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdXNl
cnF1ZXVlLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdXNlcnF1ZXVlLmMN
Cj4gaW5kZXggM2E3MWQwMWI1NGM5Li42YmFiYWRlZWMyNjggMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc191c2VycXVldWUuYw0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9tZXNfdXNlcnF1ZXVlLmMNCj4gQEAgLTI4OSw4ICsyODksMTEgQEAg
c3RhdGljIGludCBtZXNfdXNlcnFfbXFkX2NyZWF0ZShzdHJ1Y3QgYW1kZ3B1X3VzZXJxX21nciAq
dXFfbWdyLA0KPiAgICAgICBxdWV1ZS0+dXNlcnFfcHJvcCA9IHVzZXJxX3Byb3BzOw0KPg0KPiAg
ICAgICByID0gcG1fcnVudGltZV9nZXRfc3luYyhhZGV2X3RvX2RybShhZGV2KS0+ZGV2KTsNCj4g
LSAgICAgaWYgKHIpDQo+ICsgICAgIGlmIChyIDwgMCkgew0KPiArICAgICAgICAgICAgIERSTV9F
UlJPUigiRmFpbGVkIHRvIGluY3JlbWVudCByZWYgY291bnQgb2YgZGV2aWNlIHBtX3J1bnRpbWUg
XG4iKTsNCg0KRm9yIG5ldyBjb2RlIGNhbiB5b3UgcGxlYXNlIHVzZSBkcm1fZXJyKCkgaW5zdGVh
ZCBvZiBEUk1fRVJST1IoKT8NCkkgc2VlIGRybV9lcnIgaXMgbm90IHVzZWQgYW55d2hlcmUgaW4g
YW1kZ3B1IGRyaXZlciBidXQgZGlzcGxheSBpcyB1c2luZyBpdC4gSSB0aGluayBpdCB3b3VsZCBi
ZSBiZXR0ZXIgaWYgSSB0YWtlIGl0IGluIGEgZGlmZmVyZW50IHBhdGNoIHRvIGNoYW5nZSBpbnN0
ZWFkLiBEb2VzIHRoYXQgc291bmRzIG9rID8NCg0KUmVnYXJkcw0KU3VuaWwgS2hhdHJpDQoNCj4g
KyAgICAgICAgICAgICBwbV9ydW50aW1lX3B1dF9hdXRvc3VzcGVuZChhZGV2X3RvX2RybShhZGV2
KS0+ZGV2KTsNCj4gICAgICAgICAgICAgICBnb3RvIGZyZWVfbXFkOw0KPiArICAgICB9DQo+DQo+
ICAgICAgIHIgPSBtcWRfaHdfZGVmYXVsdC0+aW5pdF9tcWQoYWRldiwgKHZvaWQgKilxdWV1ZS0+
bXFkLmNwdV9wdHIsIHVzZXJxX3Byb3BzKTsNCj4gICAgICAgaWYgKHIpIHsNCg0K
