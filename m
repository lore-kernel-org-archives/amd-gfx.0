Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4185BC25B78
	for <amd-gfx@archiver.kernel.org>; Mon, 20 May 2024 08:33:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D055A10E094;
	Mon, 20 May 2024 08:33:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jtaGe2fW";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A33910E094
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 May 2024 08:33:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Is4Op2jTwxwtz8VUlo2Hrv0phtVz73OKSZ3C8lrB9dsF1RrlJvhJYkKxbjqQSdEns4k76M+Bb/AzcF9b2aBVTeQk3u6HCsjIuUiJeRB3/DrJ6lk/6ukv5EYj5yQXvylH6kts2HIQEj4vglRd9mqcoi/G+iIfjk0LEeto0KZVrDH7iSZNzMGW3G1C2wm1a5ltCRHPNGwOKwN+oYa2bJMxWEiVXG43FuF2Pc2ja95RZN9Ry3ldv/2J0Vk7UbQhxzItnqCMG+SB/VZGq9Vu1EQYlu8NHdOK6HHg7Xy+RhwevWOXrYn7PP8nEvBQao10hHm5+RR1+LdpRH8wXakleokpjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/JO8i9LZrDY6gtLdL/BN2fWxuilA6GaonrLyXkcayM=;
 b=cODaqBws2r2tgk2BftLhmZSCqLppUrQZ4d+1jItRPK+2XfGeXqBS0ycUzZjQWkblRl5gmWVHjboZrA426qd4DcCZc0DvmSlZ4FBCe+LwQ1pE99KWxZcm6awuNyMjL/DMXGSrLhkzsS9DSATP/7os/yMgrhnVUy5luyvSnEywhubM+BYXsA79baMzRPfYOo6GQYb4RbkXxQEGmjvhSugTbVBof7gHmkM92Q1EU0FABwPgcvvk7MhJZNh3ImE+OoOkZL8MD9DOjaDw5VCEO7aqKYAtbhyS/Ni2CQFCnPVER0gT1LaemkVjrjYXS1y+KEKpx8GSy+LrBbr7HSqgXU60bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/JO8i9LZrDY6gtLdL/BN2fWxuilA6GaonrLyXkcayM=;
 b=jtaGe2fWYlrqs7TX02Jh0uZwR8+Lt4zas+Ti27cf4kj8qNduKcq9Zf+dxeaZ1YgvfDlcN9zLWTK72jJ0VYjcviXDLGC8rB1vKK3zQLwpzBpTvz4yXsS16bp3rdkfoG4NF5yxtm4lM0mjSBOWSLZ4JazEjRqgo3+80ztOQrJd8mQ=
Received: from DM4PR12MB5261.namprd12.prod.outlook.com (2603:10b6:5:398::22)
 by MN0PR12MB6294.namprd12.prod.outlook.com (2603:10b6:208:3c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 08:33:33 +0000
Received: from DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::e175:f839:8e2e:2885]) by DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::e175:f839:8e2e:2885%7]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 08:33:33 +0000
From: "Xiao, Shane" <shane.xiao@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Somasekharan, Sreekant"
 <Sreekant.Somasekharan@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>, "Yao,
 Longlong" <Longlong.Yao@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Correct the GFX12 memory type setting
Thread-Topic: [PATCH] drm/amdkfd: Correct the GFX12 memory type setting
Thread-Index: AQHaqCfrtG9tU2ZbFEicBZRBnYegQLGbk+QAgAQpzZCAABGwsA==
Date: Mon, 20 May 2024 08:33:33 +0000
Message-ID: <DM4PR12MB526118ABEB9710306379E8809DE92@DM4PR12MB5261.namprd12.prod.outlook.com>
References: <20240517070011.2253488-1-shane.xiao@amd.com>
 <CADnq5_PXY+nx-RVjxmjpjEFSjGSTQpCp0MYJB8yRJwJKx=CNwQ@mail.gmail.com>
 <DM4PR12MB5261E54872648A98A45C9BBE9DE92@DM4PR12MB5261.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5261E54872648A98A45C9BBE9DE92@DM4PR12MB5261.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4a9d73e5-d366-4ef1-a4c3-f3cddf2d9fc4;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-20T07:26:17Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5261:EE_|MN0PR12MB6294:EE_
x-ms-office365-filtering-correlation-id: 6e124bd7-0aa9-4809-3a5b-08dc78a7892f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?NmlhYlZWQmpZQkI2ZzZEUHZ0UmV5a1BLK2t2Z1IvQkxsS1lEOVVsVFpjQk9j?=
 =?utf-8?B?dlUvSHQ1OFl3cnk4UjlKK0V2Wk93SlZoYnhLZi9EZlNIM1RLUUFHcWI1WGFO?=
 =?utf-8?B?WDZwTUxWQnh6S1FuekMvSk9KMHovUkRHeVB6Nk1iLzVzcFU0SEdWdUhaN0dK?=
 =?utf-8?B?eWlrTjhqRHpiOHN4dTE4VjVNTnhJVGo4YnRQMXQ5TWNNVzNwUmZtK3hLVTRu?=
 =?utf-8?B?VzU5dm5OR1pyVjByTSticmdPY2lYa2E2dnVUdHpIckRva292QnEzZGd4MExP?=
 =?utf-8?B?cHBwc2s2NEdIS1MxamFIclBRQ01lakxidnBQUUc5SlU2dW1iY2hLZzhRbzZo?=
 =?utf-8?B?cEF1YkorM1VHRWFCNndnNFNtaWNFaHlROEE1aXl3dkUzdUlNVUU4MWorVi9p?=
 =?utf-8?B?VHZzajNFUlU4aTZpblVCaDgrQmxKS3p4T25OYkU4cTdYZzRuQi9GL3VMbjJi?=
 =?utf-8?B?QXAzMnFtZWJsUUJsWTBxbUloZFAxa2VqUFFsVlErNVRIR0pOZm0xR0pMSy9m?=
 =?utf-8?B?VkpOeWFsd3Q3MlROYjk5cjlpRUlEZDNibXB6QUE4SE96dXhrTFRnUE9uU09X?=
 =?utf-8?B?NWdxc3NVMStBNldGdXNmNjI0YjFaU3FaSHJRVlJzZ05pZ1RFUTNTYU45ZzZL?=
 =?utf-8?B?VGZadDVQd2JCd2p6Yld0NlFWQ2FVR0U3SHNsR2JPQms0dGI4a0g4K00rbnlM?=
 =?utf-8?B?MjNBdDFiQ2RuM254ZmNNSHYxOVZra0tlRWFTb3BTcnAvYjJyNzIzaGI3VUR1?=
 =?utf-8?B?ako3TG5ZU2EyaTVrNXNpMDkzUFpPWHQycEN5LzJwSDRZWWthT25ORmFZWng3?=
 =?utf-8?B?SFdMT05INW9uWGg0RFZFa0locTRUT3FmYVc5eEpFaWFvL2lPNDlnNCtKNDA3?=
 =?utf-8?B?OGM4ckZ6enJwUG1tdTc2ZVZmWHhndEpIRjQrMkNpcDE4ZFRCc1E4eGVhd2tK?=
 =?utf-8?B?NFVXbjNYZG1peEJMeXQ4bUdyWFhPVForcTJEcGJac2JrNmRqTnBIRmhzTktJ?=
 =?utf-8?B?amFaR3YycWMvZVh5SG90eWRlTFNQeEIyeDNNU1JTN2hrRDJHOFZXcjZUMms3?=
 =?utf-8?B?SVdFaEZ4NUQ0aXdmZDNhdzR0a2RYQVNiQ2lNV1Fnd0w3eTZhUUtLOExaNnBa?=
 =?utf-8?B?Nmc5QkFpWlFXU0R3M1FabVZTR3NhMTVGSVBYYlE5TnpVbW0xT3JOdkFITEQ0?=
 =?utf-8?B?UkZnWEhZL25FdnIrL0hiYklCcjZBbWdoOWlpRjcxNUtJRkw1dXhiZVN2VUcz?=
 =?utf-8?B?ckpPRnVoa0UzWUFLYW5HaWh4TlJTTTFOUFIxcFBDMTRuaDRUMXdRYWJoR01m?=
 =?utf-8?B?SEFYeGcyYWdYV3pPN2VUZER4SzRMZEtsZ09DV0crVkI4NXVad0hUTERhQTkx?=
 =?utf-8?B?eWhHYWNUSEQyYzR5aUpXUm0wNldHeUpCZWNSZVg0azlEN3pYQndHT0FTL1oz?=
 =?utf-8?B?REMzWWNPRkpuWlEvTVgwQm8waE9UaWpWdXZjNERrTDNSZklXNXNNWDlHakNn?=
 =?utf-8?B?ZHhRc3hFK0NLbTdXQk5zN3RmVUZSdGZyWnFxNE5oYktjZS9uM3lWM2tzcERQ?=
 =?utf-8?B?UmtyaUthbkRkRzVWYlZ0OGxObWFGb3ZOOVVGR3huektBR0xsT1VUV2k5RXA5?=
 =?utf-8?B?emtLamJQSHBDWUszWkZSZ1BxdUxPUlhSWXRQUVVxTWduOTlrOXdsbGQ2NlQz?=
 =?utf-8?B?em4rbkYxWGFxY3NrbDkwNUswejl5UnhUZTdWYmhua3VOS3Nwbm00aXRuQjVD?=
 =?utf-8?B?R0dRaE9kRVN1bTA1Wnd5WWlnVk5zM0xhU3BYYTV0dDJ0ZVJScHVUWkkwbFdQ?=
 =?utf-8?B?M0dKY2lPQlExSG1TTjV6dz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5261.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NG95amdNdm13cXk0MEcvbGRYZmdhMndKMUlHZXRwRi9SZk85ejVaRnVQRHcz?=
 =?utf-8?B?Mkx5M0FvSm9xdTVML0VpcWFVR1dudHJrMDVFdXBycnN6dS9PVitjUlV3MG5i?=
 =?utf-8?B?VEZQN2cyb3gxTVpDUXVlR0Q2bStzN0RUUUhWS3lGUU45N09UL085c040Rm5m?=
 =?utf-8?B?Z3NHWndLNS9MNk9FU1dUQXQzSzBwUVA4MDBLcWdMbnhRR0p0dVVRTFF5R1pq?=
 =?utf-8?B?NC8ydHNhRlZWQTNwQVlLUXQ5T3lOTnh4SEY5WUt4ZEFDQWRFbGx4TXFxemYx?=
 =?utf-8?B?OENvTE1Ed3RCVlZteEtXSjNER2xsQUxnTzJMV00yeFVQQXVDL2VwdStxNTFq?=
 =?utf-8?B?a0hiVWlqRHRuNmt5VXdvLzdBNkd1YlNRbDdGeVlwNmVrQU1CVkhLS1Z0UjJ0?=
 =?utf-8?B?VzI4S3dDblk4bzllcXdkYm1oWER4bVc2T25LNVR5Sm1XUDlmNlY3WDNoeW5n?=
 =?utf-8?B?U3UzblRwY2RhOE15TERTUkJNSUZMbThkU3hPRUgxMHBpZEF4RGkrenhUbGpy?=
 =?utf-8?B?bE5LWmI0a3ZkNHVGVURtaEdxUmx0eXNwTVVLVlVIQUNxcjRUS0YyYmlhc3N6?=
 =?utf-8?B?R0FqYy9HQ3FZdUxCUEN2UEJROHVYRGNrS3ZwYjVVV3RmU1NJMTV5TE1sQmRI?=
 =?utf-8?B?TnY5SWE3SXRicHRiL1RCUjdwSjN5RnVJaWYrY0l6QlJHb1BKS3pkQVRIOUcr?=
 =?utf-8?B?WEd0Z2NxaStnVk1meXplWWhhTlJvRTRoYktnZ2RWVHFwd1VJelozNWVDVERw?=
 =?utf-8?B?QlFtVVphdXYxcDlHa09LaFFPV2FqUER3Q3ExSmtyNTVQUk9jZjBhRDhtUHlP?=
 =?utf-8?B?bWRjdXZuc0YrK3hkaXlnYjRRbXlkRW8rVjRadFhSWXJnU20wMmhjSWRTb1lt?=
 =?utf-8?B?cHArZWQ0SFJ0VEExWUFyWHpucUZjZUdKNGEwc3NSdVZRcEloK2R0c215V05H?=
 =?utf-8?B?c1p0UGErWlY1Q3g5TEFiUWhBdm5zREVoK3hVVFU5REYxZ3lBdnpwb21TZEVC?=
 =?utf-8?B?QnBEMzNVYlJ5eDZqbXg5bG96dG4xRFNzYTlYSjZLZUZVRklhMldLeGhndTBJ?=
 =?utf-8?B?TVh6Zm5haG9JaGMyTEQ1cGxMNlFCYm5rSWEvdXdqVGd2dC93SGFsVjVNdERq?=
 =?utf-8?B?djFocGt4eE11SHVVUTU2VnlFcnRVMmVSeW5Tdjg5NDcxNjZ3YWlsaXpyOU5S?=
 =?utf-8?B?aldyM2ltN0owai8rckVXeG1zb2p2VkpkRlBUMkxTb1V6OXR4dHhieSs1L3Ir?=
 =?utf-8?B?UUFwdG1DN0RGWlZRL2hBdWpucUlGay9kQ2x5UDFUcHFOeWUwZnNKUUtlRHpM?=
 =?utf-8?B?a2VFdHJLeHQ2VjJ1aU1HU29GSEVxQ1gxMG5NWXI1N2w3bFhZajNkYjdaWDlO?=
 =?utf-8?B?eVdVWTNPOXdEMy9WVHBqVExsaSt3V2RlMVVXOWpjZlUrOW16aEpadXFzeThj?=
 =?utf-8?B?QS8rMTVkWm8xbEFpNzJnMURIZGxuMnZ0U0ZLVzMrd1dqUnFHd1BJZ0xvN0tX?=
 =?utf-8?B?U0xoVlJBZ3ZpZDRQZzIxemRjS2F1S1Z4a1A2N2NqL0k5NHdHS3U0Y1lxaEtW?=
 =?utf-8?B?ZFZic3pXL2krK1lacklSTGFwOUF4OVJIS2Q2emxaaGJWS2p0K3c2dVNyOHRV?=
 =?utf-8?B?ck4vZ3BNa1RRQjNUekthMlRQUkpyRXk3OC9UVzkzRHluQ2tvQ04vTEJoVkhx?=
 =?utf-8?B?Q3dpZXNXajlVWFFxQ0h4MTJZNDV3M2pob3V5ekJkUVdZT1RHeS9IOTlVQnBz?=
 =?utf-8?B?emxxM1RlK0ZKcTdPMjBQVkt2SlFWV3ZWTWdmOTcwc2VzQmd2b3ZmYkxsQXJW?=
 =?utf-8?B?TnhjQUFBUDFJWkFlbWNwS3dhREloOXU3MFVBbnl4bTdRUDRBV3pQditGTnI0?=
 =?utf-8?B?TGc2RElpdm8rRUh6Q0plNENtQXY1bHdLMHVaa25zcUdIbUUrelIydFAxNXRl?=
 =?utf-8?B?RU91a296MEV1UHhUK0I2NFMxeGVHSFU0ZmNBY0hQellpMEgwdnk3NjkzVURB?=
 =?utf-8?B?Zmc3WHJYZldOMm02dmhzRDZoRHVKRVJtdFlBdHZDRWx4T3ljQ3FmZ213YWg2?=
 =?utf-8?B?a0NYMm9SK3lLVHZZbDR6S044eWhHazNUT0h6RFRYcGpLZ3Y2YktvVW9rY05Y?=
 =?utf-8?Q?pcbU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5261.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e124bd7-0aa9-4809-3a5b-08dc78a7892f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 08:33:33.6170 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s9oYUNUWOPJkXbW2z9k6WcRR70Fv3WmdJcG04DAlb39/F5HsTWSbgRRvMQw4leIJsXGn57NLl0rMVdndy5r96g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6294
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBYaWFvLCBTaGFuZQ0KPiBT
ZW50OiBNb25kYXksIE1heSAyMCwgMjAyNCA0OjIxIFBNDQo+IFRvOiBBbGV4IERldWNoZXIgPGFs
ZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
OyBLdWVobGluZywgRmVsaXgNCj4gPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+OyBTb21hc2VraGFy
YW4sIFNyZWVrYW50DQo+IDxTcmVla2FudC5Tb21hc2VraGFyYW5AYW1kLmNvbT47IExpdSwgQWFy
b24gPEFhcm9uLkxpdUBhbWQuY29tPjsNCj4gWWFvLCBMb25nbG9uZyA8TG9uZ2xvbmcuWWFvQGFt
ZC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIGRybS9hbWRrZmQ6IENvcnJlY3QgdGhlIEdG
WDEyIG1lbW9yeSB0eXBlIHNldHRpbmcNCj4NCj4NCj4NCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+IEZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPg0K
PiA+IFNlbnQ6IEZyaWRheSwgTWF5IDE3LCAyMDI0IDExOjUyIFBNDQo+ID4gVG86IFhpYW8sIFNo
YW5lIDxzaGFuZS54aWFvQGFtZC5jb20+DQo+ID4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnOyBLdWVobGluZywgRmVsaXgNCj4gPiA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT47IFNv
bWFzZWtoYXJhbiwgU3JlZWthbnQNCj4gPiA8U3JlZWthbnQuU29tYXNla2hhcmFuQGFtZC5jb20+
OyBMaXUsIEFhcm9uIDxBYXJvbi5MaXVAYW1kLmNvbT47DQo+IFlhbywNCj4gPiBMb25nbG9uZyA8
TG9uZ2xvbmcuWWFvQGFtZC5jb20+DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGtm
ZDogQ29ycmVjdCB0aGUgR0ZYMTIgbWVtb3J5IHR5cGUgc2V0dGluZw0KPiA+DQo+ID4gT24gRnJp
LCBNYXkgMTcsIDIwMjQgYXQgMzowN+KAr0FNIFNoYW5lIFhpYW8gPHNoYW5lLnhpYW9AYW1kLmNv
bT4NCj4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gVGhpcyBwYXRjaCBmaXhlcyB0aGUgR0ZYMTIgbWVt
b3J5IHR5cGUgdG8gTkMuIFNpbmNlIHRoZSBNZW1vcnkgdHlwZQ0KPiA+ID4gY2FuIGJlIG92ZXJ3
cml0dGVuIGJ5IHRoZSBwcmV2aW91cyBvcGVyYXRpb25zLCB0aGUgR0ZYMTIgTVRZUEUgYml0cw0K
PiA+ID4gbmVlZCB0byBiZSBjbGVhciBiZWZvcmUgc2V0dGluZyB0byBOQy4NCj4gPiA+DQo+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBsb25nbHlhbyA8TG9uZ2xvbmcuWWFvQGFtZC5jb20+DQo+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBTaGFuZSBYaWFvIDxzaGFuZS54aWFvQGFtZC5jb20+DQo+ID4gPiAtLS0N
Cj4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEyXzAuYyB8IDMgKystDQo+
ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+
ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEy
XzAuYw0KPiA+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEyXzAuYw0KPiA+
ID4gaW5kZXggZTJjNmVjM2NjNGYzLi42MjQ2ZDFkYzBkMzAgMTAwNjQ0DQo+ID4gPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEyXzAuYw0KPiA+ID4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMl8wLmMNCj4gPiA+IEBAIC01MzQsNyArNTM0LDgg
QEAgc3RhdGljIHZvaWQgZ21jX3YxMl8wX2dldF92bV9wdGUoc3RydWN0DQo+ID4gPiBhbWRncHVf
ZGV2aWNlICphZGV2LA0KPiA+ID4NCj4gPiA+ICAgICAgICAgLyogV0EgZm9yIEhXIGJ1ZyAqLw0K
PiA+ID4gICAgICAgICBpZiAoaXNfc3lzdGVtIHx8ICgoYm9fYWRldiAhPSBhZGV2KSAmJiBjb2hl
cmVudCkpDQo+ID4gPiAtICAgICAgICAgICAgICAgKmZsYWdzIHw9IEFNREdQVV9QVEVfTVRZUEVf
R0ZYMTIoTVRZUEVfTkMpOw0KPiA+ID4gKyAgICAgICAgICAgICAgICpmbGFncyB8PSAoKmZsYWdz
ICYgfkFNREdQVV9QVEVfTVRZUEVfR0ZYMTJfTUFTSykgfA0KPiA+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgQU1ER1BVX1BURV9NVFlQRV9HRlgxMihNVFlQRV9OQyk7DQo+ID4NCj4gPiBNYXli
ZSB3ZSBzaG91bGQgbWFrZSB0aGUgQU1ER1BVX1BURV9NVFlQRV9HRlgxMigpIG1hY3JvIGNsZWFy
IHRoZQ0KPiA+IGN1cnJlbnQgZmllbGQgYmVmb3JlIHNldHRpbmcgdGhlIG5ldyBvbmU/ICBUaGF0
IHdvdWxkIGFsaWduIHdpdGggdGhlDQo+ID4gc2ltaWxhciByZWdpc3RlciBmaWVsZCBtYWNyb3Mu
DQo+DQo+IFRoZSBBTURHUFVfUFRFX01UWVBFX0dGWDEyKCkgbWFjcm8gaXMgdXNlZCBtdHlwZSBh
cyBpbnB1dCwgIGlmIHdlIGFsaWduDQo+IHdpdGggUmVnaXN0ZXIgZmllbGQgc2V0dGluZywgd2Ug
bmVlZCB1c2UgdWludDY0IGZsYWdzIGFzIGlucHV0Lg0KPg0KPiBJZiB3ZSBkbyBsaWtlIGJlbG93
Og0KPg0KPiAtI2RlZmluZSBBTURHUFVfUFRFX01UWVBFX0dGWDEyKGEpICAgKCh1aW50NjRfdCko
YSkgPDwgNTQpDQo+IC0jZGVmaW5lIEFNREdQVV9QVEVfTVRZUEVfR0ZYMTJfTUFTSw0KPiBBTURH
UFVfUFRFX01UWVBFX0dGWDEyKDNVTEwpDQo+ICsjZGVmaW5lIEFNREdQVV9QVEVfTVRZUEVfR0ZY
MTJfU0hJRlQobXR5cGUpICgodWludDY0X3QpKG15dHlwZSkNCj4gPDwgNTQpDQo+ICsjZGVmaW5l
IEFNREdQVV9QVEVfTVRZUEVfR0ZYMTJfTUFTSw0KPiBBTURHUFVfUFRFX01UWVBFX0dGWDEyX1NI
SUZUKDNVTEwpDQo+ICsjZGVmaW5lIEFNREdQVV9QVEVfTVRZUEVfR0ZYMTIoZmxhZ3MpICAgXA0K
PiArICAgICgoZmxhZ3MpICYgKCh+QU1ER1BVX1BURV9NVFlQRV9HRlgxMl9NQVNLKSkgfCAoZmxh
Z3MpKQ0KDQpKdXN0IGlnb3JlIG15IGNvbW1lbnQgYmVmb3JlLiBXZSBuZWVkIGJvdGggZmxhZ3Mg
YW5kIE1UWVBFIGFzIGlucHV0Lg0KDQpJIHdpbGwgc2VuZCBWMiB2ZXJzaW9uIGZvciB0aGlzLg0K
DQo+DQo+IFdlIG5lZWQgdG8gY2hhbmdlIHRoZSBtZW1vcnkgdHlwZSBzZXR0aW5nIGZyb20NCj4g
QU1ER1BVX1BURV9NVFlQRV9HRlgxMihNVFlQRV9OQykgdG8NCj4gQU1ER1BVX1BURV9NVFlQRV9H
RlgxMihBTURHUFVfUFRFX01UWVBFX0dGWDEyX1NISUZUKE1UWVBFXw0KPiBOQykpLg0KPiBUaGlz
IG1ha2VzIHRoZSBjb2RlIGxvb2sgbW9yZSBjb21wbGljYXRlZC4NCj4NCj4NCj4gQW5vdGhlciB3
YXkgaXMgdG8gYWRkIG9uZSBtb3JlIG1hY3JvIEFNREdQVV9VUERBVEUvU0VUX1BURQ0KPiBfTVRZ
UEVfR0ZYMTIuDQo+ICNkZWZpbmUgQU1ER1BVXyBVUERBVEVfUFRFX01UWVBFX0dGWDEyKGZsYWdz
KSBcDQo+ICAgICAgICgoZmxhZ3MpICYgKCh+QU1ER1BVX1BURV9NVFlQRV9HRlgxMl9NQVNLKSkg
fCAoZmxhZ3MpKQ0KPg0KPiBXaGljaCBvZiB0aGUgYWJvdmUgdHdvIG1ldGhvZHMgZG8geW91IHRo
aW5rIGlzIG1vcmUgc3VpdGFibGU/DQo+IElmIG5laXRoZXIgb2YgdGhlc2UgbWV0aG9kcyBhcmUg
c3VpdGFibGUsIGRvIHlvdSBoYXZlIGFueSBvdGhlciBzdWdnZXN0aW9ucz8NCg0KDQoNCg0KPg0K
Pg0KPiBCZXN0IFJlZ2FyZHMsDQo+IFNoYW5lDQo+DQo+ID4NCj4gPiBBbGV4DQo+ID4NCj4gPiA+
DQo+ID4gPiAgfQ0KPiA+ID4NCj4gPiA+IC0tDQo+ID4gPiAyLjI1LjENCj4gPiA+DQo=
