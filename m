Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA86CAC5AA
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 06:19:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22BFE10E107;
	Thu, 25 Sep 2025 06:19:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5gdU2vvM";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5075510E107
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 06:19:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpFCrWkbXm5keoYCa29liQKvc3BuN2F1+g3vpdJnA00mUc/sbUwV+mVqu1/hVqSBz37IvV2WBOVYK4MiZkzHr5MKOH3YiwCSAAbzSlpaCVdUoJCadAW2z8ZpU/DfMvUvdxyeGAS2omOFu1l5lzsA7K3sQDhwVsExc7brQuHZuF9p5NAMapACmfKD+iEgd0jdNACJ3wKo8mumC4vlR+6qF99R6Qz3NPEr4CgdyYgw4ZU7B4Uou2YmDvy3GkZmbZn/2ZWkylXNZjz0ZRiQIzwNCV+G+xqmswSIZDh4Zm/wKriGJjy0oUEigwUgUR+FaVsp5LU6HoHAefHnC77nQU0Zig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WycVxeaSEja30g9VbM+eeEFt4BxbOmdagOCJAx8NU9Q=;
 b=vQE9TPmw4WOP6+nI6+7wEic/iM9OU6otLKrM37zmTtObZQUBZKd4/qI9V8LK+V2rfYnPzEkHzx+Xe437J07bXTVIv4YCvNsqX5GSCvPv8qkcoZDgtC/Kw37hC/x1Ogfdf203ujPlXL1ma+YzypB/ucp772oKiiacIHFJKdT/zKdMrlrV5QolUDNtmJ4Mu/b5MVgCyFLjtPIKmng2kPXjPdPh1KUU6m8AShnAJ9im+pTWFWP9c27ni67aDjzANdP7GdTJiH949zqRWCoHeUBtf2zdE9E1K4rVngWx7FPWNP6ZC3pLgzaIvMUd4CkYzsyIQ2Une1VY0pzYZoTOgCCzsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WycVxeaSEja30g9VbM+eeEFt4BxbOmdagOCJAx8NU9Q=;
 b=5gdU2vvMGI85PWx+EIIS1WaNe1dwWzz5Iyk6H+b5WgqxrseBwShKmlQrMileW99Hrurgg8NA3piFMMurDneJclFLZTkIEXCauYR5F3N2zMoeNGvI+lZSGSQnWIw6qWSfhpnpHCQrqSexllB43XltY0F+tXsP30uMW4q7uX68acU=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SN7PR12MB8026.namprd12.prod.outlook.com (2603:10b6:806:34b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 25 Sep
 2025 06:19:04 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 06:19:04 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Yang, Philip" <Philip.Yang@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: RE: [PATCH v4 1/2] amd/amdkfd: resolve a race in
 amdgpu_amdkfd_device_fini_sw
Thread-Topic: [PATCH v4 1/2] amd/amdkfd: resolve a race in
 amdgpu_amdkfd_device_fini_sw
Thread-Index: AQHcLWgTqOzaZJoJTkW89kYWvtfiC7Si7+WAgAB8bAA=
Date: Thu, 25 Sep 2025 06:19:04 +0000
Message-ID: <DS0PR12MB7804DBACD17E1583644F9430971FA@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20250924152929.2234747-1-yifan1.zhang@amd.com>
 <ccc729b8-640e-6e71-3522-7208413990f0@amd.com>
In-Reply-To: <ccc729b8-640e-6e71-3522-7208413990f0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-25T06:18:54.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|SN7PR12MB8026:EE_
x-ms-office365-filtering-correlation-id: b83d142e-17ee-44fe-c59a-08ddfbfb6d33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?eVFwZUpxNXBXNzZoc25QVUQxLy9UTStxRlprbVNRVDlPZ25ubXZiUGpnUmZz?=
 =?utf-8?B?UlBPNmVaUzVsU3l6dHRnUnpUY0dLY2hLcWNKTG96TkU3dGFYbnhPaUltaVIw?=
 =?utf-8?B?ejk5UUFtWmlXaEdYM1pCc3U0TVRkZjlpaVkrQ00xcWJKZjVkRGlPbndzMzkw?=
 =?utf-8?B?SXR1cnk4TExrR0RTRERiTWdoUEwyK0lYQVJMNERkcW1NK3E4RW5qRVozTVhu?=
 =?utf-8?B?ZTBQbm04cHhJQTU3ZitqeW0rME9ZQXFQMjg3UnZzeHI2TDFORzJ0Z2ZRekIw?=
 =?utf-8?B?MnMrTnhBTlQ3ZnhoRDRqM2ZiUGEyTEUyb3F5ME1CM29EMW0zM2U4QXlkZ2Y5?=
 =?utf-8?B?eVo2eXVXdDR0VjBqYVRxY1ErWXg0TXpaZVF0TllvamFKVzdiWFNMWnd5M2dL?=
 =?utf-8?B?SS9mSHExRlBqZERxWjB0eThhOVJPK29GOTVjZXJ4QVlweGVkUWd4WTNnU1pw?=
 =?utf-8?B?V2FWajNoVUg5dDJjVGxWVXB5UjQzVkZUbjFMeHNSN1R4eTJpc0NNL1AxaHF3?=
 =?utf-8?B?Y1dSZG5QbUNYYVp2dmJoZGVCK0t5bzVWVVY2TmJPQlJyR2NoLy8zZWtwVFNY?=
 =?utf-8?B?bUVYZlJjN1N1UldHWU1pR1hiT2hlRHpmZXQxQTVmd1BqUm11ODMrYXJmRVJD?=
 =?utf-8?B?akNyK3pXSS9SUFdFNTdNNDZEOFdieEpaV2NVODFUdlBxU29RK3ZjTjZKcEhT?=
 =?utf-8?B?R2hRR2lGdFdBS2prMVNFM215cVRkSU5sN2tPOEF0MXhQbFc3OVR1Q1RtWVNN?=
 =?utf-8?B?TzdZZEVTWHBud005dW0xYVhycmptZkVUNEkySkFHZE9Wa05kUG1sWElsYVdP?=
 =?utf-8?B?d0dSZVdtb2NtMXdpRHEyNGJMQ2tOUlJnR3Blc1RycHNBRGRaWjRiejBXZ2VL?=
 =?utf-8?B?Q1N2aWswMVRCSmZnNlltVitiK0xjVjFqOXI0UVFwZXZYdjBDbFVqdGFYZEQr?=
 =?utf-8?B?MEdRbDRkbGMyUXpXSjRWNUJTUFBkaEpJYWlFQ2JpbGgyVGUzWVczdzRhMm9l?=
 =?utf-8?B?U3RWdGpud1pMUk1Oc2g3S0lwNTZEMFk1NWJvNGkyZ1hnN1pJdktrSXE0ME9j?=
 =?utf-8?B?VU9ZTVQ0QlRvNVBwK244QU9LS1dSbnVHT3h3Vi9mZ3d2bXFuQXZSb0Q5akVD?=
 =?utf-8?B?dEYwRnQ2MU5QYTBYdjNyN1BHa0hwMlNBSXZ1djNqOGtMWE80Vnhwazd6QkZi?=
 =?utf-8?B?b1hUTHRDMlMyUTRsTVNibjhyV2tHYTVFUWpzVjBxSWVwOHRveVZlM3hNbDBN?=
 =?utf-8?B?RUNaK3FnV0NreVhIcS9YNkp3Uk9jT1lnQk9hQ01OMXkzbW01S2tRUG1CWlFS?=
 =?utf-8?B?ZmtVb0ZyTUViNy83S3YzczZFMm1XRHlRV0E0WTZWVE8xV29XU1grR0doYmtu?=
 =?utf-8?B?dzZRTWN3c0R0czJEQ1JxcWMyeHFia1BzczBtQ0VnRm04cVRpNEtLVGovamw3?=
 =?utf-8?B?d0pHa2xlWmErR25IK1Q2NjN5dURFU1p0QmhGV0pkZi9qTnEwdm80azdOUE9D?=
 =?utf-8?B?ZW9XR2tpbGdIbG95akRkR1Q2NjZRRzA4MG0vKzZLUEdkeWZvYkh1bWpTdXh2?=
 =?utf-8?B?YmRjRjRWMEpTc0lvaFRQR3NvWGVkdlN6OW9XU1U0Zk41SjBlZEdiL2FvTzVB?=
 =?utf-8?B?WWszTG5kRjNQd2xzNkV6V3dnOTlLWi9NNXBUY3RTdWdtZFZDOXZKUS92a2Ro?=
 =?utf-8?B?L0ZGMS9xUHJQSXFaUUVqSmtsK1gvOFdRVmw2Nm9EY2Vya3JjN1UrYTRiMCs4?=
 =?utf-8?B?aXA1Rmp2YzZGYmxXblo0dWg4amdPVE1GVFFBSkFuczNOUkpuaEVCNXI3ZU5v?=
 =?utf-8?B?b0pEd0ZFTjV5Wk1JZytvamtWb3BDWGZQaEVvZzNYZ1BlYmVISHI0cDQ2MVFz?=
 =?utf-8?B?KzZYOC95SGUxR3RJbWp1K2JDVkRoK0JkdFdsSWRMeVczUXhjQTlOUjlOTkdQ?=
 =?utf-8?B?Rm04anhYZTRORDNnbnhoRVRRMEtRZ0tvaHI3ZzNiT0svUm8rTGxNeE1JUnNy?=
 =?utf-8?Q?bKJPTSmRUUpQAdBR+smPb+98MWnXWs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzRqUGdEYmFYTFdWb2IrOU4zL1hZWE1lUWNMM0NZMm5YWGk3OGJUcUN3NVZY?=
 =?utf-8?B?SjlYQnBtMEJnd1dZUjJKYUZkcy9rbVRJWDdqcGNBOVdNRWQ5NER6bXVtY3g0?=
 =?utf-8?B?YVVYSEVIMk5iVHRLU2Y3bkR4MUl3cHU1UnVPemRTeHdHWm84ejdyc3VDYXFJ?=
 =?utf-8?B?NHpBL1Z1US9oTHNXL1FZMFR6cG4zekJLUkREbHRDWlVhNFNoc2daQnB2aXJ1?=
 =?utf-8?B?dEhBUXlzV1E5dENZaE5pOTZTVlpZMXZNcFdVeGJNd3pkRDRCZ3puUys5ZVNG?=
 =?utf-8?B?LzFFMDNzZUZiT1lRNDJCMHBVNlMzQXFoK3lvQnZ3dzM1aGdQZDZWODZKMVQ5?=
 =?utf-8?B?K0tYem14MDF0bjZVL2tBUWduQnNjWnJZYnovTzBxRmtXaUt1d2xVRkZnYzBp?=
 =?utf-8?B?M2hvZkJ4ZUQ2MkRMTEdMWDB5OC9wNnpKODRwNGRTMlUyUGdYQVZaS0djQysr?=
 =?utf-8?B?NlBWNnRSU05jYTExOUJ5SzJtQzJzSmZiQmxVc0lsenkra2Z6U2U3NlBxNGRw?=
 =?utf-8?B?STRSRmRRWmlVaTdoVHRKZGJKYkhHVmsycVcxNklSMU1EeW9RclloaDZFT2Ir?=
 =?utf-8?B?RXdQZHFmbFRHSmprSVo5anQ5Q0owdHNoR1VrdFM4QUcraVFQbVJpWGlwVjVL?=
 =?utf-8?B?SDQ4WVgvcnMvUk5YaTNLOXQ1SXZKU09WclI0c1RVQlQzZ3ZEcVZtdW9xaVBI?=
 =?utf-8?B?MTZ5ZkpoK0ZPSzB5YUw1VldvN1d6Njk4eXdOQ2ZSWjc2Wm1tWG1aTzZ2YU03?=
 =?utf-8?B?czAwOElWRi9sMWVvZmJSd0FoMkZxY0h2OWZhc2hoNHZ5WlpqZk1Cb09OVEQ4?=
 =?utf-8?B?ZTh2V0JKS2tBZEJJbUgweHhqRXNwVlA4UlAvdExRaUlES21IYS9rN0c4NmhG?=
 =?utf-8?B?NFk2UjN2cHk1aExFSGoxVkt1NjRmV2tXOXBoUHlyZUZDR2REaERlMEtZZjBU?=
 =?utf-8?B?ekE2Z3R4cTJJS0owRnR2Z0VycXRkSVFiQlI5WHpvazdPTSszeGc0Lzk5QS95?=
 =?utf-8?B?dU5lUlo0MW1kUUNualZvSlE2MU83MURsVFhJQXlsaDdLdGdydW9JVDE0ZDBq?=
 =?utf-8?B?WnR3NVMvOGkrampxd3FDOHJxZjR6a1dOWnJrVGlIQzM2cGZFb2ptMW9JOEg5?=
 =?utf-8?B?QWRPTDdseW1aMFRSZWFVWDVkVVk2VlFBL0s0Vk45a2pCNk1wb0poaEVsNExF?=
 =?utf-8?B?M2Z6N0IvVjl5YjVpT0xraEhrTVVQVHlJN0pFKzFLd2tIbzZVN1RDeFlHQnZv?=
 =?utf-8?B?Tmpjd0luUkpuQXF5T0YwUkwveHZ4VWxVWnlKcmZTZ1JyYXh2TnU1YTM1MzFU?=
 =?utf-8?B?L2N0R2FpR3ZaS1FrUUlwUVpubGhGbjNUNVN3TEVCMng5ZmRHb0ViTGlzVEpt?=
 =?utf-8?B?cHdLdkdvaFVjaSt0YUZJY24rSEwvcGxWc2ZxSTFseExCYmpnbmh2TEhSMXRZ?=
 =?utf-8?B?cXBienFldDlMV055TkdBbUpUMmlPbnp1Y0NxNU13SnRKOTlvS0psTVM5b1FN?=
 =?utf-8?B?QlBuYU9jbHVjWEZ3dkZlM3UybUZXcFBuNXF1Nk1zQ2k0SDl0K1JYWVd3UDQv?=
 =?utf-8?B?SFhYY0Jnemx2UXVuUGdWY3ZpMHFFQ3YwOG91bXJZTWUvREd4SUcwMVhXZE5V?=
 =?utf-8?B?MDE3UnhUQklseVh3dTBFaUVIN3IxVkk4OWZyeE42eWh5VCtKOUFlUm9lLzUz?=
 =?utf-8?B?amZ2TVI5OFdBeFpXWWthcjJwaE5MQ0NUQ0x4Z29qU2txOEVyRWZHZnlpU1dS?=
 =?utf-8?B?RWI0U0pUTk5BdktQUWpMamVSdEJwRlhFTmRwWFRxYVEvWithZXorVWFUTWVq?=
 =?utf-8?B?NFhMS3R6UVR2N3h6OTNpRmpGZDhxeWRZRWdDVjdXQ2RIYTJYQXR5UXQ1NEpD?=
 =?utf-8?B?OHpXSm9kZjF6MVUyUHRlQ3lvVU1SNkdmdDJud1pISFdTb1NaRVRDZU9XcmRu?=
 =?utf-8?B?VmlIcXZpaURFbXVFVW9rNldXaDhQQ2dJWFIzcjVVTFpJT1FjSkNDUVUzdHZ1?=
 =?utf-8?B?SmxJbVpVWnhXeWgyL1JwMXBHaGZGUlhSQm9oaWU5dEQxTDVySVNZdXFMNjVj?=
 =?utf-8?B?NFpPMVRrYXlWczVWQ25DUEkyaHhCTUNEZjFhT2o2azdSZ05oOFc1WVBxQzdp?=
 =?utf-8?Q?F9Xs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b83d142e-17ee-44fe-c59a-08ddfbfb6d33
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 06:19:04.3809 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lzZtnekcJQCDnAWXOcxGpQBJfcYo2yJFt1Vxjqzn5lb3rvR5QwIskZC7hAVtSdJT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8026
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

W1B1YmxpY10NCg0KPiBSYWNlIGlmIGFub3RoZXIgdGhyZWFkIGluIGIvdyBrZmRfY2xlYW51cF9u
b2Rlcw0KDQpUaGlzIGNvZGUgaXMgdGhlcmUgYmVmb3JlIGNsZWFudXAgb2Ygbm9kZXMuDQogICAg
ICAgIGZsdXNoX3dvcmtxdWV1ZShrZmQtPmloX3dxKTsNCiAgICAgICAgZGVzdHJveV93b3JrcXVl
dWUoa2ZkLT5paF93cSk7DQoNClNob3VsZG4ndCB0aGUgaW50ZXJydXB0IGhhbmRsaW5nIGNvZGUg
Y2hlY2sgaWYgaW50ZXJydXB0IGhhbmRsaW5nIGlzIGVuYWJsZWQgcmF0aGVyIHRoYW4gY2hlY2tp
bmcgaW5kaXZpZHVhbCBub2RlIE5VTEwgcG9pbnRlcnM/DQoNClRoYW5rcywNCkxpam8NCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFlhbmcsIFBoaWxpcCA8UGhpbGlwLllhbmdA
YW1kLmNvbT4NClNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMjUsIDIwMjUgNDoxOSBBTQ0KVG86
IFpoYW5nLCBZaWZhbiA8WWlmYW4xLlpoYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT47IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT47IFlhbmcsIFBo
aWxpcCA8UGhpbGlwLllhbmdAYW1kLmNvbT47IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5j
b20+DQpTdWJqZWN0OiBSZTogW1BBVENIIHY0IDEvMl0gYW1kL2FtZGtmZDogcmVzb2x2ZSBhIHJh
Y2UgaW4gYW1kZ3B1X2FtZGtmZF9kZXZpY2VfZmluaV9zdw0KDQoNCk9uIDIwMjUtMDktMjQgMTE6
MjksIFlpZmFuIFpoYW5nIHdyb3RlOg0KPiBUaGVyZSBpcyByYWNlIGluIGFtZGdwdV9hbWRrZmRf
ZGV2aWNlX2Zpbmlfc3cgYW5kIGludGVycnVwdC4NCj4gaWYgYW1kZ3B1X2FtZGtmZF9kZXZpY2Vf
ZmluaV9zdyBydW4gaW4gYi93IGtmZF9jbGVhbnVwX25vZGVzIGFuZA0KPiAgICBrZnJlZShrZmQp
LCBhbmQgS0dEIGludGVycnVwdCBnZW5lcmF0ZWQuDQo+DQo+IGtlcm5lbCBwYW5pYyBsb2c6DQo+
DQo+IEJVRzoga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSwgYWRkcmVzczogMDAwMDAw
MDAwMDAwMDA5OCBhbWRncHUNCj4gMDAwMDpjODowMC4wOiBhbWRncHU6IFJlcXVlc3RpbmcgNCBw
YXJ0aXRpb25zIHRocm91Z2ggUFNQDQo+DQo+IFBHRCBkNzhjNjgwNjcgUDREIGQ3OGM2ODA2Nw0K
Pg0KPiBrZmQga2ZkOiBhbWRncHU6IEFsbG9jYXRlZCAzOTY5MDU2IGJ5dGVzIG9uIGdhcnQNCj4N
Cj4gUFVEIDE0NjViODA2NyBQTUQgQA0KPg0KPiBPb3BzOiBAMDAyIFsjMV0gU01QIE5PUFRJDQo+
DQo+IGtmZCBrZmQ6IGFtZGdwdTogVG90YWwgbnVtYmVyIG9mIEtGRCBub2RlcyB0byBiZSBjcmVh
dGVkOiA0DQo+IENQVTogMTE1IFBJRDogQCBDb21tOiBzd2FwcGVyLzExNSBLZHVtcDogbG9hZGVk
IFRhaW50ZWQ6IEcgUyBXIE9FIEsNCj4NCj4gUklQOiAwMDEwOl9yYXdfc3Bpbl9sb2NrX2lycXNh
dmUrMHgxMi8weDQwDQo+DQo+IENvZGU6IDg5IGVAIDQxIDVjIGMzIGNjIGNjIGNjIGNjIDY2IDY2
IDJlIE9mIDFmIDg0IDAwIDAwIDAwIDAwIDAwIE9GDQo+IDFmIDQwIDAwIE9mIDFmIDQ0JSAwMCAw
MCA0MSA1NCA5YyA0MSA1YyBmYSAzMSBjTyBiYSAwMSAwMCAwMCAwMCA8Zk8+DQo+IE9GIGIxIDE3
IDc1IEJhIDRjIDg5IGVAIDQxIFNjDQo+DQo+IDg5IGM2IGU4IDA3IDM4IDVkDQo+DQo+IFJTUDog
MDAxODogZmZmZmM5MEAxYTZiMGUyOCBFRkxBR1M6IDAwMDEwMDQ2DQo+DQo+IFJBWDogMDAwMDAw
MDAwMDAwMDAwMCBSQlg6IDAwMDAwMDAwMDAwMDAwMDAgUkNYOiAwMDAwMDAwMDAwMDAwMDE4DQo+
IDAwMDAwMDAwMDAwMDAwMDEgUlNJOiBmZmZmODg4M2JiNjIzZTAwIFJESTogMDAwMDAwMDAwMDAw
MDA5OA0KPiBmZmZmODg4M2JiMDAwMDAwIFJPODogZmZmZjg4ODEwMDA1NTAyMCBST086IGZmZmY4
ODgxMDAwNTUwMjANCj4gMDAwMDAwMDAwMDAwMDAwMCBSMTE6IDAwMDAwMDAwMDAwMDAwMDAgUjEy
OiAwOTAwMDAwMDAwMDAwMDAyDQo+IGZmZmY4ODhGMmI5N2RhMEAgUjE0OiBAMDAwMDAwMDAwMDAw
MDk4IFIxNTogZmZmZjg4ODNiYWJkZm8wMA0KPg0KPiBDUzogMDEwIERTOiAwMDAwIEVTOiAwMDAw
IENSTzogMDAwMDAwMDA4MDA1MDAzMw0KPg0KPiBDUjI6IDAwMDAwMDAwMDAwMDAwOTggQ1IzOiAw
MDAwMDAwZTdjYWUyMDA2IENSNDogMDAwMDAwMDAwMjc3MGNlMA0KPiAwMDAwMDAwMDAwMDAwMDAw
IERSMTogMDAwMDAwMDAwMDAwMDAwMCBEUjI6IDAwMDAwMDAwMDAwMDAwMDANCj4gMDAwMDAwMDAw
MDAwMDAwMCBEUjY6IDAwMDAwMDAwZmZmZU83Rk8gRFI3OiAwMDAwMDAwMDAwMDAwNDAwDQo+DQo+
IFBLUlU6IDU1NTU1NTU0DQo+DQo+IENhbGwgVHJhY2U6DQo+DQo+IDxJUlE+DQo+DQo+IGtnZDJr
ZmRfaW50ZXJydXB0K0B4NmIvMHgxZkAgW2FtZGdwdV0NCj4NCj4gPyBhbWRncHVfZmVuY2VfcHJv
Y2VzcysweGE0LzB4MTUwIFthbWRncHVdDQo+DQo+IGtmZCBrZmQ6IGFtZGdwdTogTm9kZTogMCwg
aW50ZXJydXB0X2JpdG1hcDogMyBZY3B4RmwgUmFudCB0RXJhY2UNCj4NCj4gYW1kZ3B1X2lycV9k
aXNwYXRjaCsweDE2NS8weDIxMCBbYW1kZ3B1XQ0KPg0KPiBhbWRncHVfaWhfcHJvY2VzcysweDgw
LzB4MTAwIFthbWRncHVdDQo+DQo+IGFtZGdwdTogVmlydHVhbCBDUkFUIHRhYmxlIGNyZWF0ZWQg
Zm9yIEdQVQ0KPg0KPiBhbWRncHVfaXJxX2hhbmRsZXIrMHgxZi9AeDYwIFthbWRncHVdDQo+DQo+
IF9faGFuZGxlX2lycV9ldmVudF9wZXJjcHUrMHgzZC8weDE3MA0KPg0KPiBhbWRncHU6IFRvcG9s
b2d5OiBBZGQgZEdQVSBub2RlIFsweDc0YTI6MHgxMDAyXQ0KPg0KPiBoYW5kbGVfaXJxX2V2ZW50
KzB4NWEvQHhjTw0KPg0KPiBoYW5kbGVfZWRnZV9pcnErMHg5My8weDI0MA0KPg0KPiBrZmQga2Zk
OiBhbWRncHU6IEtGRCBub2RlIDEgcGFydGl0aW9uIEAgc2l6ZSA0OTE0OE0NCj4NCj4gYXNtX2Nh
bGxfaXJxX29uX3N0YWNrKzB4Zi9AeDIwDQo+DQo+IDwvSVJRPg0KPg0KPiBjb21tb25faW50ZXJy
dXB0KzB4YjMvMHgxMzANCj4NCj4gYXNtX2NvbW1vbl9pbnRlcnJ1cHQrMHgxbGUvMHg0MA0KPg0K
PiA1LjEwLjEzNC0wMTAuYTFpNTAwMC5hMTgueDg2XzY0ICMxDQo+DQo+IFNpZ25lZC1vZmYtYnk6
IFlpZmFuIFpoYW5nIDx5aWZhbjEuemhhbmdAYW1kLmNvbT4NClJldmlld2VkLWJ5OiBQaGlsaXAg
WWFuZzxQaGlsaXAuWWFuZ0BhbWQuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9rZmRfZGV2aWNlLmMgfCAxMCArKysrKysrKystDQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX2RldmljZS5jDQo+IGluZGV4IDM0OWMzNTFlMjQyYi4uMDUxYTAwMTUyYjA4
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlLmMN
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jDQo+IEBAIC0x
MTMzLDcgKzExMzMsMTUgQEAgdm9pZCBrZ2Qya2ZkX2ludGVycnVwdChzdHJ1Y3Qga2ZkX2RldiAq
a2ZkLCBjb25zdCB2b2lkICppaF9yaW5nX2VudHJ5KQ0KPiAgICAgICB9DQo+DQo+ICAgICAgIGZv
ciAoaSA9IDA7IGkgPCBrZmQtPm51bV9ub2RlczsgaSsrKSB7DQo+IC0gICAgICAgICAgICAgbm9k
ZSA9IGtmZC0+bm9kZXNbaV07DQo+ICsgICAgICAgICAgICAgLyogUmFjZSBpZiBhbm90aGVyIHRo
cmVhZCBpbiBiL3cNCj4gKyAgICAgICAgICAgICAgKiBrZmRfY2xlYW51cF9ub2RlcyBhbmQga2Zy
ZWUoa2ZkKSwNCj4gKyAgICAgICAgICAgICAgKiB3aGVuIGtmZC0+bm9kZXNbaV0gPSBOVUxMDQo+
ICsgICAgICAgICAgICAgICovDQo+ICsgICAgICAgICAgICAgaWYgKGtmZC0+bm9kZXNbaV0pDQo+
ICsgICAgICAgICAgICAgICAgICAgICBub2RlID0ga2ZkLT5ub2Rlc1tpXTsNCj4gKyAgICAgICAg
ICAgICBlbHNlDQo+ICsgICAgICAgICAgICAgICAgICAgICByZXR1cm47DQo+ICsNCj4gICAgICAg
ICAgICAgICBzcGluX2xvY2tfaXJxc2F2ZSgmbm9kZS0+aW50ZXJydXB0X2xvY2ssIGZsYWdzKTsN
Cj4NCj4gICAgICAgICAgICAgICBpZiAobm9kZS0+aW50ZXJydXB0c19hY3RpdmUNCg==
