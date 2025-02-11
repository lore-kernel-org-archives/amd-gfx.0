Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F7BC0219E
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 17:02:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7178B10E300;
	Tue, 11 Feb 2025 17:02:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DbU6fjM6";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D9A410E300
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 17:02:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gap+Mt+xlhjjEdOTf9jNJD2td8aaZM3nVkMdUna8sTTdFP9ZR1VcE+8AfvjmCS6M7WbMOlAu6efmeV1q3zI3VAyXpiEvbxZQaoj+986BJ73tcDKx1aybY1q6zTlOs24n1IvSxmdKFd7rtEP0VcHfjwjDvMrV1ZpdtJxhbtNd4jJ8GuCRduIJS+ysQ6Hzi/kzUQKnLDPUuwb1SM+OkvkbW4USih644YDKZY2roHD/M20ESAglWzHaQJ4pchBARphlX61VnxzSodtBpjA18D03CiSHUqgcz/yxh9RDSXJ2strMaudnmm5BV2e9y68qy8gdjGYuhF+f8MO3UWi+Tsysmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbWP1gDdiYTV19CZeJWlznMed0NpD9QBTh+ZUmkY3bA=;
 b=xCDAcxOmg8/+tfUsSXfTcT433QGfvK1rHprz7H7uGXQG8polgxakLPqTE/fjNGsJsaD0RDnrgvKmJCAYus8oghUASZ23KLDGSYYyPNoCcpnRFaID4ZjAYcEYJDVtHGnFnlycktyq7m+w3oAkjIqH7NJvRE54BP0ax4lYBCaIkyX6AlOzoUSM3/+Lmih+GETGEqOIidRxPDmV8zPnRDBIV9560BCz0DrGyxifloUJdmsTsqp3HlmcYdYeb1q0ZoFAvGfwGD9kzT9tFsYiHHDh+s5gKEfd2SSIg97A38DXy1z/lGWYTVH1bkB4OXm2m4khxjp3VIEDkGY6c5CugULAYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbWP1gDdiYTV19CZeJWlznMed0NpD9QBTh+ZUmkY3bA=;
 b=DbU6fjM6f4sSOT1kIKozE7WzHmbnDrYP87TlYjYTcvuOxrajQcu8wqTAOjLLR5oHXAwOqjekq0hEtzGZzpuKYITRteTNgDZZTX2S5YWUKkv9HP23G8WetAhzMjv+fM3VMA2dirO7aaRuoqmhXiGsHuNFb6kYQliU9E30m87mD+I=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by CH2PR12MB4165.namprd12.prod.outlook.com (2603:10b6:610:a4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Tue, 11 Feb
 2025 17:02:12 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%4]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 17:02:12 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "SHANMUGAM, SRINIVASAN"
 <SRINIVASAN.SHANMUGAM@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu/mes: Add cleaner shader fence address
 handling in MES for GFX12
Thread-Topic: [PATCH 2/2] drm/amdgpu/mes: Add cleaner shader fence address
 handling in MES for GFX12
Thread-Index: AQHbfAF26N9VO/kRTECg7936LeDhZrNBTw4wgADqwYCAABrK0A==
Date: Tue, 11 Feb 2025 17:02:12 +0000
Message-ID: <CH0PR12MB537272B6E67A5A283D895EF7F4FD2@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20250210211904.281317-1-alexander.deucher@amd.com>
 <20250210211904.281317-2-alexander.deucher@amd.com>
 <CH0PR12MB53726043385289BEA92AFA2FF4FD2@CH0PR12MB5372.namprd12.prod.outlook.com>
 <CADnq5_MUCe80BCtLmiVoNW+hK55HTr1uzRnWx+XUzgY=gkjaNg@mail.gmail.com>
In-Reply-To: <CADnq5_MUCe80BCtLmiVoNW+hK55HTr1uzRnWx+XUzgY=gkjaNg@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=14080591-0908-4c21-9e3d-ca6032a11735;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-11T16:59:25Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|CH2PR12MB4165:EE_
x-ms-office365-filtering-correlation-id: 1f192af6-ce0b-4049-0084-08dd4abdd44a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YkFTU3c2WE0ra25ORU5JcEM3dm1wR0dPaTM1ZDhTc3MvZGxPeDZMUS9kTkVR?=
 =?utf-8?B?eWVzaWpmQ1FMOEt0L3VrZkEwUk1vQnlxcTRvdGZsSnByU2E3TTRMZFR1OGZr?=
 =?utf-8?B?cG5FVHRzVVpvTzVoeGRva0k0VHp1SGZPR2FtdjU2U3NYbDVyU2Y2dEV3UGY5?=
 =?utf-8?B?WitqRUVBdFRrV1poT051a1ZaSUZxd3I1S1BYR2JvbXAyYXUzUVJCeCtWbXNJ?=
 =?utf-8?B?VGNzSS9YamlQOFJwSXpwS3Erb0kwR0Zjc2lLZ3V4ZHpjZEpDa1VHL0ptMEdh?=
 =?utf-8?B?K2pkUkRxRGNNQWdCY0xVK3pCMkQyRTVVVG9LUStMcTM1UjExOGhpalkzSHFT?=
 =?utf-8?B?b2VvTzJkc0lBTXVGWWlMOWpDS3VaOTVVa0VJcWcwTi9WUGRBNXlobVVpR2I1?=
 =?utf-8?B?UWtNZEFEcDZHYkRRTFpyNUFkY2dOeVpKa25KYVdLMGZRSTZXYmg1QTFCekU5?=
 =?utf-8?B?TEZWUit2RzJOekV4ZnRpZTYvUW9mYndXVWZXbkhHN3M1RC9zMHArajNMUWo3?=
 =?utf-8?B?bVNrRVBNWXR2aWYxbFRYeTNyVGZUMGNDd01pMFhIWWtJd1BhTGt5cWI1V3Ez?=
 =?utf-8?B?eHova004UWlFclY1K2dTREU5cmRTaTVJWnlqY0hHMGRpKzc0RVlKWHZMUUJl?=
 =?utf-8?B?VEpYc2pzbWVnZ2tyZFp5T2gvV1J2ZHl0aVdML0h4aFJwbEh1SURBaHZpNkJ5?=
 =?utf-8?B?VlBaWlpoUzZJVk9wNWI4WWl3WjFkb1NrMlVyb1NzWmRJSkxvRU1zZ3BKTmx1?=
 =?utf-8?B?RmtRRFRnQVBWeUJlOFdaR2lHY2pkSzd2d3NMWkVUYnNnbE9lVDR0VGxaQzNq?=
 =?utf-8?B?aTE3d1N3YWo0VzJmdWlCNG8zaDEvUlh1UHlwVnhvV3doVWNTQ1p0eUdic1Bw?=
 =?utf-8?B?V3VscitndXcyVDB2OGRLUGs2alk3K3MvOWRTQ2djYnpjSWgvOFJtMUNXUFlL?=
 =?utf-8?B?eHMwMVF3ajg3NkRzRWgzQkdBaS9LNWZHeHhVdWFJckdQYUV5NWFGN21aSDVG?=
 =?utf-8?B?dFRibmdXSGxKb3VIV2pqT0xlL0szZ3FoVTJpN0tYREhJdy84MXBCMlFsTHpn?=
 =?utf-8?B?dkxzai9JeFZVY1NrbU9zOWltVDNvTVgvWCtmM2VaVUdJaXZ5RUNlM3hSNWVk?=
 =?utf-8?B?bjUxbEJVd25nSzZ2b2Q5cEFpMStFQ0lwZWpoZ1o5Tkx4dms0bHRKbmVONTJC?=
 =?utf-8?B?alVSaWVQMHZiSWc3NEtNNVlJM0hvNEJZblpMQ0hRR2VNZG9COGI5czdJdUVL?=
 =?utf-8?B?TjUyUitpL2pWNENBQ3d0NjdQSFlhaldCZEhVampaMmtxSmsvSHlaZ2lwdDZa?=
 =?utf-8?B?dDV6TXBjM1dsZHMxVHduQVhqVkdjM1FlT2s2VnY4YkMwa2QwT0YvbTFNcEQ2?=
 =?utf-8?B?Y0l1ZVYrdmh2NUlycTlBVmxPZ3A0d1NHd1Fvd2xTeDhjWTIzUHZCNVRwTEpJ?=
 =?utf-8?B?cXdNRU1SVWhESlN4VTBCM3RKckcyZFB6UzNqRFJXaEhwUjM1ajdvejBYa1dG?=
 =?utf-8?B?MStsaDR5NVFkUnNUaDU1a2JpeFRMeldEUzBVeGVHcXIyRWZYak1nU0lYN2tk?=
 =?utf-8?B?Y2IrTEhSS3IrOFBHWVVmcWlJdFNmdTA3VFUrNjdZTWswNnFKRndnV2hLZG0y?=
 =?utf-8?B?c1lVTFZGZ2lqbEphWWlkZDBrdVFJMVg1ZkV5dVcwTi91QmJrdFc5Zm1rMEVm?=
 =?utf-8?B?UnA1MUExYTVVTGUzQzZHcEJ0TUh3R0tleXdnSENSYW1FampaeVRxc3lQK0xt?=
 =?utf-8?B?MjhURDNnL09wSS8xNUdyQ0pmdG9MbnR3NjZmTEc2ZE1ZajRhZEs1QjF1cGFp?=
 =?utf-8?B?TkZKNlV0Q0RQRm83bm0xUDFzQ0VjdE1RM2VibEZ3NlZacERMV1pEbXhhaXpu?=
 =?utf-8?B?K2xVeVNPbEczV3huS250My9JYmhwZVczWDRFalhHTThHTnBtdy9qWHNnZUZj?=
 =?utf-8?Q?CLHbx3XHtDjoNEsNUcFnqIzwRDyZy+Ha?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N05HREVCd2VlVnFSbUQ0Y1REQ3oyUzhtTWRWc0QxNmRVc1hXSXFuYjNLYnRp?=
 =?utf-8?B?VW13TE1NMXcxVTNBU3JwK0IyV3N2QWxCMGtPdnhnM01JZGhRM08vZ24xMTVS?=
 =?utf-8?B?M0xBU1VMSEpGeUhTcU52TkVXZXJsK1V5YlExdjZRYjBXaDJSa2JUTldwQzZQ?=
 =?utf-8?B?Ui9aaHBqN1FpU3RnOVJ5eUM3TXc4WGNvc3ZHS0xZbkFYMndBNDlaRlJYT21t?=
 =?utf-8?B?ZndxYVRyc3A2Rm1pTy84b0tsbGc5YzJvQ3JWTC9Zb0NKR2pWcWF5dTF2cTdv?=
 =?utf-8?B?TDJDUWNDNzN1d2s2L0VKVFo0NXZ6ZUpkOW9Jc05TNWp1cjBWMnhyL0U1K2Zl?=
 =?utf-8?B?TE9mbG4zeUplWXhIVnNORG5pMnc4VW0zSk1LZEVScUFSeHdiRGdOQnBRZDVu?=
 =?utf-8?B?cUpVKzdiS1VTVWlIOHV0SDNIazVCWlZ1YjdnL0JsbXA1NGJSQU9EbW55S3Za?=
 =?utf-8?B?eHdHdkxQN25vUDBCVDFUaStHeERicXJHRjI4OUhzOFlzbmRjN1M4QSs5bU9M?=
 =?utf-8?B?WHhpTE54b2N1QnQ5cDRpSGFGTmNmd2cyYS9EUW9RcWJpd0dtRkpKL0d6VE9X?=
 =?utf-8?B?RW93ZitXaVF3dVdzUHIyMXVRYThkL0NZMkw3MDJ2VGxHakd3ZXovaGZtclRr?=
 =?utf-8?B?M3FORzY3dzhWU1ZCSy9yVWhnOW5zVlJOYy9xZHUrOEVlM3JaU3lIdDZDdUUw?=
 =?utf-8?B?a3JtS2Nzb21rSjgxNzExc1gzbktIa3d0V2JSdGdVNDNBckxURkI5Tjh1cmdL?=
 =?utf-8?B?UXRYSkUzZ2l0cmpOS1UvQUw4Z2ZGcklNSGE2NGlsQWdOSU9mWmpIMXhyTlp6?=
 =?utf-8?B?TFRFeFFtb0V0VThIbUp2aFNYU0lXUkJZWWlJaUQvMk9yQ3hZQUlBalhUT1k3?=
 =?utf-8?B?MHpMMm9uaG4zT3pyeUZockJ6ZUJEYmNLM0F2YmVGamRkcEpUMk1XMStoTUdS?=
 =?utf-8?B?SXhMRTNFZ243c0tUUEVqdjF4T1FnUUdhZldVSWs0b056TTJuakltL0VOUFpp?=
 =?utf-8?B?VjgwTlgzc3JNRm5LV1RDUHN3RG1qNUdJYXQ2bWhxSDc1UzErY0hjdFFCVDJI?=
 =?utf-8?B?Wk01L0xKOW1kUERHR25xY2NNT3BFdGxuejZCcEFRdWppZnRoNkZYWUVGSVJy?=
 =?utf-8?B?M3EzTGVEdWRwN25wQ2JyYklwM1FwSFp3M0gvRU4zdU9nQk9TTWhGSTF2Ujkz?=
 =?utf-8?B?aE1tVENOZmZCVzhwdUVnb0R6N1BTVjRwamVKbFZSRmcxanZxeWtXbXN3QTkw?=
 =?utf-8?B?MHBob0gzZmdPZDJETDIzZlZJblZKSmRQZDVxOW9mM0F4SmMvSi9HYXBGOEdC?=
 =?utf-8?B?RGc2SXhWcFV5WW5EY1dWOENRWHM0Rno3MFczRDZxNFZjU0FaOEZ0cE0zUVVh?=
 =?utf-8?B?em5GUHVRMWZyTURRRi9nWWEvR2g3YjBid2Q0eVFZbXJYNWhLZDhDTDl3L28v?=
 =?utf-8?B?SUZyWUtPK004MGYvZHNRdDZyOW5tb1lKYmdxRDRiUlpMUlRSRjZpQk8rTHg3?=
 =?utf-8?B?bFpWdjl3dklTK29jckRSYjZYMlBGTWxvbHhycnlid1FUb0pyZmloYTY4dEM5?=
 =?utf-8?B?OENHUnpDSGxsNDVTbzErZjkvZ05scU02NnlnMU0yL2E4Y2V6RFV1eFBXdGtv?=
 =?utf-8?B?aUVDVk1KWEdyZXVTcnJ2MWdSOTBFS3JPVmRRY2RxVk9kK2ljOG51enVnSUFx?=
 =?utf-8?B?TjZXMldMVVJpeDNMQ2IvRXpWem81dmNYNVZ2Z1c1bTIxZ3dXWDZJSkJBOTFu?=
 =?utf-8?B?VG9YWWZUcVBKOUFwR0s3dDlqRjdkd0RRTEkvVkpKSE90c3FPZTM2MHhLV2pB?=
 =?utf-8?B?TUJlWTE3czlFR3pTbUlPRHBXRjdHbEZsUWppT3hNL0FIdlJTM0JnTmRRU2Jl?=
 =?utf-8?B?Q1M0RUJ0bkFySSttZE94bEtyTjZ1eWNnSXFUdnZ6ZnNJZ2hoUGNQRkM2TXVs?=
 =?utf-8?B?QWhKc0ExTTA1QlJvQXBzL3VYZnpRREpTTDRhY2lnY3JjVzRNU3FTVlNoRmVN?=
 =?utf-8?B?VjNNVWExbjQ4eTA0QzZPNjJYcnJxS2M5WkxUN3RaVk8yMk1xeXpQM2txYTRs?=
 =?utf-8?B?QlBvV1plcHk5d2Q5MTZCSlNydHFnUElGblpJREV2YURFU3MzNmdKWUtNNEY4?=
 =?utf-8?Q?3sqc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f192af6-ce0b-4049-0084-08dd4abdd44a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 17:02:12.6972 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lEUFHGV6RkdCDJVqQOWLQxcqk3fngI0RPhYoLN3sFoThA2vFvHzVNJwWWx3itPTM+cq3BFt9waQbWBO4kBbvfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4165
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
Cg0KSSBiZWxpZXZlIHRoaXMgY291bGQgYmUgYSBtaXN0YWtlICwgZnJvbSBNRVMgc2lkZSAsIHRo
ZSBzZXRfaHdfcmVzb3VyY2VfMSAgc2hvdWxkIGFsd2F5cyBiZSBjYWxsZWQgIG5vIG1hdHRlciBp
dCdzIHVuaWZpZWQgb3Igbm9uZS11bmlmaWVkIC4gSSB0aGluayB3ZSBzaG91bGQgcmVtb3ZlIGl0
IGZvciB0aGUgdW5pZmllZCBjaGVjayBhdCBmaXJzdCBwbGFjZSAuDQoNClJlZ2FyZHMNClNoYW95
dW4ubGl1DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBbGV4IERldWNoZXIg
PGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NClNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDExLCAyMDI1
IDEwOjI0IEFNDQpUbzogTGl1LCBTaGFveXVuIDxTaGFveXVuLkxpdUBhbWQuY29tPg0KQ2M6IERl
dWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnOyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0Bh
bWQuY29tPjsgU0hBTk1VR0FNLCBTUklOSVZBU0FOIDxTUklOSVZBU0FOLlNIQU5NVUdBTUBhbWQu
Y29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGRybS9hbWRncHUvbWVzOiBBZGQgY2xlYW5l
ciBzaGFkZXIgZmVuY2UgYWRkcmVzcyBoYW5kbGluZyBpbiBNRVMgZm9yIEdGWDEyDQoNCk9uIE1v
biwgRmViIDEwLCAyMDI1IGF0IDg6NDjigK9QTSBMaXUsIFNoYW95dW4gPFNoYW95dW4uTGl1QGFt
ZC5jb20+IHdyb3RlOg0KPg0KPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIEludGVybmFs
IERpc3RyaWJ1dGlvbiBPbmx5XQ0KPg0KPiBXaHkgb25seSBmcmVlIHRoZSBtZW0gd2hlbiAgdW5p
ZmllZCBtZXMgaXMgZW5hYmxlZCAsIEkgcmVtZW1iZXJlZCB0aGF0IHNldF9od19yZXNvdXJjZV8x
IHdpbGwgYWxzbyBiZSBjYWxsZWQgaW4gbm9uZS11bmlmaWVkIG1lcyBtb2RlIC4NCg0KbWVzX3Yx
Ml8wX3NldF9od19yZXNvdXJjZXNfMSgpIGlzIGN1cnJlbnRseSBvbmx5IGNhbGxlZCB3aGVuIHVu
aWZpZWQgbWVzIG1vZGUgaXMgZW5hYmxlZCBzbyBpdCBtYWtlcyBzZW5zZSB0byBhbGlnbiB0aGUg
ZnJlZSBzaWRlIGFzIHdlbGwuDQoNCj4NCj4gQW5vdGhlciB0aGluZyBpcyBldmVudHVhbGx5IHdl
IHByb2JhYmx5IHNob3VsZCBhbGxvY2F0ZSB0b3RhbCAxMjkgcGFnZXMgdGhlIHNhbWUgYXMgR0ZY
MTEgICgxMjggIGZvciBod19yZXNvdXJjZV8xIGFuZCAgb25lICBleHRyYSBwYWdlIGZvciBNRVMg
aW50ZXJuYWwgdXNhZ2UpIC4gIEJ1dCBzZWVtcyBTUklPViBzdGlsbCBub3QgdXNlIHRoYXQgMTI4
IHBhZ2VzLCBJdCBjYW4gIGJlICB1cGRhdGVkIGxhdGVyIHdoZW4gIEkgdXBkYXRlIHRoZSBBUEkg
Zm9yIGdmeDEyIHRvIGVuYWJsZSB0aGF0IC4NCj4NCg0KeWVhaCwgd2UgY2FuIGFkZCB0aGF0IGxh
dGVyIGlmIHdlIG5lZWQgaXQuICBUaGUgY3VycmVudCBtZXMgMTIgcGFja2V0IGRvZXNuJ3Qgc2Vl
bSB0byBzdXBwb3J0IHRoYXQgZmVhdHVyZSB5ZXQuDQoNCkFsZXgNCg0KPiBSZWdhcmRzDQo+IFNo
YW95dW4ubGl1DQo+DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERldWNo
ZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gU2VudDogTW9uZGF5
LCBGZWJydWFyeSAxMCwgMjAyNSA0OjE5IFBNDQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQu
Y29tPjsgS29lbmlnLCBDaHJpc3RpYW4NCj4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IFNI
QU5NVUdBTSwgU1JJTklWQVNBTg0KPiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47IExp
dSwgU2hhb3l1biA8U2hhb3l1bi5MaXVAYW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIDIvMl0g
ZHJtL2FtZGdwdS9tZXM6IEFkZCBjbGVhbmVyIHNoYWRlciBmZW5jZSBhZGRyZXNzDQo+IGhhbmRs
aW5nIGluIE1FUyBmb3IgR0ZYMTINCj4NCj4gVGhpcyBjb21taXQgaW50cm9kdWNlcyBlbmhhbmNl
bWVudHMgdG8gdGhlIGhhbmRsaW5nIG9mIHRoZSBjbGVhbmVyIHNoYWRlciBmZW5jZSBpbiB0aGUg
QU1ER1BVIE1FUyBkcml2ZXI6DQo+DQo+IC0gVGhlIE1FUyAoTWljcm9jb2RlIEV4ZWN1dGlvbiBT
Y2hlZHVsZXIpIG5vdyBzZW5kcyBhIFBNNCBwYWNrZXQgdG8gdGhlDQo+ICAgS0lRIChLZXJuZWwg
SW50ZXJmYWNlIFF1ZXVlKSB0byByZXF1ZXN0IHRoZSBjbGVhbmVyIHNoYWRlciwgZW5zdXJpbmcN
Cj4gICB0aGF0IHJlcXVlc3RzIGFyZSBoYW5kbGVkIGluIGEgY29udHJvbGxlZCBtYW5uZXIgYW5k
IGF2b2lkaW5nIHRoZQ0KPiAgIHJhY2UgY29uZGl0aW9ucy4NCj4gLSBUaGUgQ1AgKENvbXB1dGUg
UHJvY2Vzc29yKSBmaXJtd2FyZSBoYXMgYmVlbiB1cGRhdGVkIHRvIHVzZSBhIHByaXZhdGUNCj4g
ICBidXMgZm9yIGFjY2Vzc2luZyBzcGVjaWZpYyByZWdpc3RlcnMsIGF2b2lkaW5nIHVubmVjZXNz
YXJ5IG9wZXJhdGlvbnMNCj4gICB0aGF0IGNvdWxkIGxlYWQgdG8gaXNzdWVzIGluIFZGIChWaXJ0
dWFsIEZ1bmN0aW9uKSBtb2RlLg0KPiAtIFRoZSBjbGVhbmVyIHNoYWRlciBmZW5jZSBtZW1vcnkg
YWRkcmVzcyBpcyBub3cgc2V0IGNvcnJlY3RseSBpbiB0aGUNCj4gICBgbWVzX3NldF9od19yZXNf
cGt0YCBzdHJ1Y3R1cmUsIGFsbG93aW5nIGZvciBwcm9wZXIgc3luY2hyb25pemF0aW9uIG9mDQo+
ICAgdGhlIGNsZWFuZXIgc2hhZGVyIGV4ZWN1dGlvbi4NCj4NCj4gQ2M6IENocmlzdGlhbiBLw7Zu
aWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gQ2M6IFNyaW5pdmFzYW4gU2hhbm11Z2Ft
IDxzcmluaXZhc2FuLnNoYW5tdWdhbUBhbWQuY29tPg0KPiBTdWdnZXN0ZWQtYnk6IFNoYW95dW4g
TGl1IDxzaGFveXVuLmxpdUBhbWQuY29tPg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvbWVzX3YxMl8wLmMgfCAyMiArKysrKysrKysrKysrKysrKysrKysrDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMl8wLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9tZXNfdjEyXzAuYw0KPiBpbmRleCBkY2JjMzEyNzlmMjliLi44ZGJhYjM4MzRkODJk
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdjEyXzAuYw0K
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdjEyXzAuYw0KPiBAQCAtNjc4
LDYgKzY3OCw5IEBAIHN0YXRpYyBpbnQgbWVzX3YxMl8wX21pc2Nfb3Aoc3RydWN0IGFtZGdwdV9t
ZXMNCj4gKm1lcywNCj4NCj4gIHN0YXRpYyBpbnQgbWVzX3YxMl8wX3NldF9od19yZXNvdXJjZXNf
MShzdHJ1Y3QgYW1kZ3B1X21lcyAqbWVzLCBpbnQNCj4gcGlwZSkgIHsNCj4gKyAgICAgICB1bnNp
Z25lZCBpbnQgYWxsb2Nfc2l6ZSA9IEFNREdQVV9HUFVfUEFHRV9TSVpFOw0KPiArICAgICAgIGlu
dCByZXQgPSAwOw0KPiArICAgICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gbWVzLT5h
ZGV2Ow0KPiAgICAgICAgIHVuaW9uIE1FU0FQSV9TRVRfSFdfUkVTT1VSQ0VTXzEgbWVzX3NldF9o
d19yZXNfMV9wa3Q7DQo+DQo+ICAgICAgICAgbWVtc2V0KCZtZXNfc2V0X2h3X3Jlc18xX3BrdCwg
MCwgc2l6ZW9mKG1lc19zZXRfaHdfcmVzXzFfcGt0KSk7IEBAIC02ODcsNiArNjkwLDE5IEBAIHN0
YXRpYyBpbnQgbWVzX3YxMl8wX3NldF9od19yZXNvdXJjZXNfMShzdHJ1Y3QgYW1kZ3B1X21lcyAq
bWVzLCBpbnQgcGlwZSkNCj4gICAgICAgICBtZXNfc2V0X2h3X3Jlc18xX3BrdC5oZWFkZXIuZHdz
aXplID0gQVBJX0ZSQU1FX1NJWkVfSU5fRFdPUkRTOw0KPiAgICAgICAgIG1lc19zZXRfaHdfcmVz
XzFfcGt0Lm1lc19raXFfdW5tYXBfdGltZW91dCA9IDB4YTsNCj4NCj4gKyAgICAgICByZXQgPSBh
bWRncHVfYm9fY3JlYXRlX2tlcm5lbChhZGV2LCBhbGxvY19zaXplLCBQQUdFX1NJWkUsDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQU1ER1BVX0dFTV9ET01BSU5fVlJBTSwNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmbWVzLT5yZXNvdXJjZV8xLA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICZtZXMtPnJlc291cmNlXzFfZ3B1X2FkZHIsDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJm1lcy0+cmVzb3VyY2VfMV9hZGRyKTsN
Cj4gKyAgICAgICBpZiAocmV0KSB7DQo+ICsgICAgICAgICAgICAgICBkZXZfZXJyKGFkZXYtPmRl
diwgIiglZCkgZmFpbGVkIHRvIGNyZWF0ZSBtZXMgcmVzb3VyY2VfMSBib1xuIiwgcmV0KTsNCj4g
KyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ICsgICAgICAgfQ0KPiArDQo+ICsgICAgICAg
bWVzX3NldF9od19yZXNfMV9wa3QuY2xlYW5lcl9zaGFkZXJfZmVuY2VfbWNfYWRkciA9DQo+ICsg
ICAgICAgICAgICAgICBtZXMtPnJlc291cmNlXzFfZ3B1X2FkZHI7DQo+ICsNCj4gICAgICAgICBy
ZXR1cm4gbWVzX3YxMl8wX3N1Ym1pdF9wa3RfYW5kX3BvbGxfY29tcGxldGlvbihtZXMsIHBpcGUs
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICZtZXNfc2V0X2h3X3Jlc18xX3BrdCwgc2l6ZW9m
KG1lc19zZXRfaHdfcmVzXzFfcGt0KSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgb2Zmc2V0
b2YodW5pb24gTUVTQVBJX1NFVF9IV19SRVNPVVJDRVNfMSwNCj4gYXBpX3N0YXR1cykpOyBAQCAt
MTc3MCw2ICsxNzg2LDEyIEBAIHN0YXRpYyBpbnQNCj4gbWVzX3YxMl8wX2h3X2luaXQoc3RydWN0
IGFtZGdwdV9pcF9ibG9jayAqaXBfYmxvY2spDQo+DQo+ICBzdGF0aWMgaW50IG1lc192MTJfMF9o
d19maW5pKHN0cnVjdCBhbWRncHVfaXBfYmxvY2sgKmlwX2Jsb2NrKSAgew0KPiArICAgICAgIHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gaXBfYmxvY2stPmFkZXY7DQo+ICsNCj4gKyAgICAg
ICBpZiAoYWRldi0+ZW5hYmxlX3VuaV9tZXMpDQo+ICsgICAgICAgICAgICAgICBhbWRncHVfYm9f
ZnJlZV9rZXJuZWwoJmFkZXYtPm1lcy5yZXNvdXJjZV8xLA0KPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICZhZGV2LT5tZXMucmVzb3VyY2VfMV9ncHVfYWRkciwNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmYWRldi0+bWVzLnJlc291cmNlXzFf
YWRkcik7DQo+ICAgICAgICAgcmV0dXJuIDA7DQo+ICB9DQo+DQo+IC0tDQo+IDIuNDguMQ0KPg0K
