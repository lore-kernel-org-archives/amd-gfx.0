Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E13DC3ABAA
	for <amd-gfx@archiver.kernel.org>; Fri,  2 May 2025 14:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0956F10E945;
	Fri,  2 May 2025 14:47:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0gjD+KAJ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37A9710E945
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 May 2025 14:47:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHsjkAKTAuhqVDySIgjNAkQmXClsGzzDFk8CaGhwXSzSGo7oGpiqH0+zaKyPBUfGQNtQ9G828VbbAu2qhMJEyIST9MDV0aQO8W6+KH0o0U3W4CJLV5lrEPqM62Tn9qqay58zGcCpXO+6MyM0A2W+nWPFOO27/mUnwkNxdS2ytSfqokIHmhClKXq9wmrWpyHah4mcJ4pFqIdXMBCtVl1glGeQugl09LwITjDdqPssQIXZ/5kO3lAgfcKtgeLczYvJC+gJE7jonIkGhTIjNwgmsDqE4CRDA73xIpIBKgyLQD73YdVWkrB3H/D6xIQnWwp4aFkaGzNBshGcpyXP7hprrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+eQWpts/AUvvbSxptD0sLPywDpKsKsCfej+dHuBXNI=;
 b=xm/hwu5Iv8BOTUvp367EJzI2KpyQa5zoLGVzNhsqq7JrPrUCNaYm2OconmNoIiIN5MuwgOGQ0MesCgBDNZ/a2Gx4fnjlUV+COXCrBTlluPB7SP0wEhmTOdEh3wemwEqMdKyBHZ7xqb0VikdirYFRideLvHNA1WwFA1ev4jdUbAuR+KlbvpYrSDjV+gH+cA378mRCKYUKqsWA7dMFRpYOhiMsHygMPBEwDu6BGueHXw9gAOYWULkO59z5PP9auS3LP/VdXqIHd+ecoYm3G5TxVaCTBt6YzbwZ+ylL5THba7ky0wKU95R8mRPQHJpIT1QBJ8RJpD+geG9ZNEvhWejf2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+eQWpts/AUvvbSxptD0sLPywDpKsKsCfej+dHuBXNI=;
 b=0gjD+KAJHhiNeDKZtGnJYKKvhMYpKNKiYWQxQ6z80e7NQZHImxCSDVSGR67qq/EOhm4IZ6tolLO9yIa1ZiakdaEBhRjvatP348+LNvbIBqzvuCh01aYd/It+0TIiMQYtK3GrKyY3Hbf6IZKJ+5nIGjr0+aKGYP+lSx7y3h2ZpVc=
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 by PH0PR12MB7792.namprd12.prod.outlook.com (2603:10b6:510:281::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 2 May
 2025 14:47:27 +0000
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9]) by SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9%4]) with mapi id 15.20.8699.019; Fri, 2 May 2025
 14:47:27 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Jamadar, Saleemkhan" <Saleemkhan.Jamadar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu, Leo"
 <Leo.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu/vcn4.0.5: Fix GFX10_ADDR_CONFIG programming
 for vcn1.
Thread-Topic: [PATCH] drm/amdgpu/vcn4.0.5: Fix GFX10_ADDR_CONFIG programming
 for vcn1.
Thread-Index: AQHbui/eRudIFnNgUkiPZj3aHnNvzbO9ulcAgAGzMOA=
Date: Fri, 2 May 2025 14:47:27 +0000
Message-ID: <SJ1PR12MB61946BE3A0A165CA1A5723CF958D2@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20250501002732.1266299-1-ruijing.dong@amd.com>
 <349c9fb3-e51b-4399-9ac2-fb3553318c9a@amd.com>
In-Reply-To: <349c9fb3-e51b-4399-9ac2-fb3553318c9a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=cdaf5a3c-d32b-4cd1-bdb3-b338aa2831a6;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-02T14:46:13Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6194:EE_|PH0PR12MB7792:EE_
x-ms-office365-filtering-correlation-id: 424bf517-4fd9-4d70-ad83-08dd8988425f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?UStQb1BKWmdBR3BPSVgrazNHSmZ6VXN2bHdDdW1hMjFxcERQbmJocXR6KzR2?=
 =?utf-8?B?RmMwa0ExTTJ5aW9EeW5XZzh2Q3ZWOFUwN0NhZU1DZWxoZU5mNExSY0F0eG5G?=
 =?utf-8?B?VzZzTlh4Uk5VVHF5Z2pibS8zdUZrZHpVVXFPRmdIb1FDcnJiYjhCUWlvSitE?=
 =?utf-8?B?TUdkS0g1L1ZrME9zdXd5OVNxS0R3VENTcms5SGEzYm1YN3pJMk9oOTRtK0Rm?=
 =?utf-8?B?U0NHYkVHK3hzcEExMThhNEV2b29EZSt5K0sxVzdzdng3VEZnMUJWUG16endw?=
 =?utf-8?B?RVB4VXRvaEJiZVg4S2NNSFpHdkorTzNWU1NnOXhlLzg3ckNucHZnTnpFSjNF?=
 =?utf-8?B?ZHpQR2dMRG8xQmhNVlhsVTU5VXFEZG4zaU92dzlPNldsVGVpVmhIU1hoaDJP?=
 =?utf-8?B?eHhvcUFJVTVNUG1reUlJK1ZPN3ZrckZpdVE0WHB2UlFRSGFkZU1sVndHM2lC?=
 =?utf-8?B?Yk9HRGNlbENRSm1CUG1IMXZJa0ZmV1VhZk45UlFqWm5WOVkyUmRQMTA2VnRB?=
 =?utf-8?B?L1Z0Wk5qNWp3UHd5R040TDBsa2xTRjRwUkVTK0tqVm05UjlPeDFOTW1DRWh5?=
 =?utf-8?B?UTRHeldLMzFOWm44ZThpOXpZWHpSUG1nQ3U1V0p1YUp1VEZyQnhKVVVteElv?=
 =?utf-8?B?T0ludkppczdNajJ2NmtyRlViai94alVVL2VBR2hDbEFzOHl5ajZGUGh4aS9z?=
 =?utf-8?B?TXI1MjJEMUphMWFGc1ZWa1k0UTVyK3lOaDJndkdPeHZKUitaS0wzOFlVc3lH?=
 =?utf-8?B?RWY1NitMM0EvQzhyb1JDWUF2ODNGS0dSaWo5K3RlNVhJT1dtMzA0YUtONHJP?=
 =?utf-8?B?aEpmYXdvZmNBQk13aEFIMHF2d0lJVGFaZ2JCSzh4aXJ6Z04xTE9BUEJQY0Iz?=
 =?utf-8?B?WXRWWXUrRVRFTWlTRDdaWWpCSFN2ZkVHMm9rQUQ2WUp0dFBuUmJsTGR1ZWlB?=
 =?utf-8?B?S0RXdDQwSVlXUElzUERJMmN4azdnNHNaOTBMcjB2Z1FUem5HNGRhUldwRWEv?=
 =?utf-8?B?QVBLbnNhOE5LT21QZEY0dFZiYnd1OVFPazhRVVljYVVSVXdKV3FpVisvSHc2?=
 =?utf-8?B?dWhnMkRsMUJyNWxyUDV4MnFtMXdYMmo0RVRMN3lmV2NPS2E3MlRBQjFUZUxy?=
 =?utf-8?B?L1V0TUZYY2laTHdjaGZaTkJRWGdHazNtdWxIeGgvbEdGSXBDRjk0R1J6VE51?=
 =?utf-8?B?YVhUSWlCVytuS3dlNmNlVm9malB0L28yLzF5a2FhVUROQ1UzVzRPY0RYR2NB?=
 =?utf-8?B?cmQ2MG5ZMVJ0ZmYwbzVxd3VhKy9TWnlkallzWDJSL2diTXZ2QlBMaEZ2WWt1?=
 =?utf-8?B?bUNaYkNRalg0aGlmMXFjcXVkejRKM2Jia1Rvei9QQ0FvV0RhZHEyQ2VieHk0?=
 =?utf-8?B?YzFreFNFRzFNeVVFeWY3NkR0NWtUUnV2VEovdEJDVjg5a3dYYW1FaFJudDIx?=
 =?utf-8?B?dTVsQ3N5cGNEdERLbjBUSGcvMlFrWkV3K0xSdmZBSDA1WlFqczMwTFpNeCtN?=
 =?utf-8?B?YTJGWVd3Z3BIQUlUNzJOV2oxM0hHdnlxQUlCS2tBUk0zS2FHUlRRMDVlUlVN?=
 =?utf-8?B?QmZVLzZJbzhCeXJ6eFIyNUNVais2QitDSzB3OFRTRVRhQU1UN3Nud05DTjNx?=
 =?utf-8?B?UnRrRmFxa2J0czBBZFEwYXRzbWFmWTJBQnNIdHR1ZmVtM2hrR1p1ZVNUWE5p?=
 =?utf-8?B?VlJZQU1RRndrdWdjZStHa2JLOXVSVC9qMnR4UDFjblhPUk1ieGVFY24rRTZ3?=
 =?utf-8?B?RUE5UlgrMFdYazFEK0I5V1htS3JuR3lMQVZGWmpxY0h4RzFkbXNCVU9kTnZn?=
 =?utf-8?B?SzJkeFptWGQrNG9vQ21pc3RFQmZsbTIySU45R2E4V2NCcE8zU1ZDRHZJNHJD?=
 =?utf-8?B?NEY3clVEbUlJVm5odUtIN0RQWlFSRmE4RFVycHI4L0RRWlhlTC9DMmY4QS81?=
 =?utf-8?B?YlY2M2RqRGFmQTJ0bjFYSFRaWTdnQUxGZnA3dEtIbnVKRlc0NmNZVWtKdFFF?=
 =?utf-8?Q?vz7hSGD/o/TqGGG2IY0b1DHy8dp88Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUJsWkFsdXZHYUVSUFlpNUw5VVJWM0ZZb1NCa09pcEtRSzdJR2RoVjNNS3d6?=
 =?utf-8?B?TWd3RzBRNCtoaWh4dzRlQnVaQzN0dXVsQXQ4L2ova050TVo1SG5xYlpzSWw3?=
 =?utf-8?B?UHZNeVgzam9kdGtJVVk2WU5jMGl1dmxsVWpyVUtKUWlpZGxLR2xxclEwZ1FC?=
 =?utf-8?B?dFFkMzBURnQzSmZ4WUpIZHM0eTJsSmV6RWRGeE9XekV2ZnFyNnZPVkNCWm9W?=
 =?utf-8?B?Qm9sbVlVdWNDbHFNUUkwbnd1NE9rcmNKWXN3SzEwSTJRQysxUjI5a3FYL28z?=
 =?utf-8?B?R0ZNZ3N1clpjbFNGYndRTkE2eUxLS1ZsNjNTTUplYll4UndGblFzMlpWZTlZ?=
 =?utf-8?B?ZTRjTnBRN09GL2lKL3FyakkxTTM4NjNtUnNjNGN0VHlqbXRWN1FKWkNGb2Ix?=
 =?utf-8?B?U1FuZkJjcGtjcmNsZGk3eEYwVWZFV2JUTjBsMzRiRi9UVlJjLzdQV3J5MDYv?=
 =?utf-8?B?dDFYUWhwc1NSblg4WGpQWi83MmtvZDRGRVpoZUxMaGFNR1MxV1gwR2lQYWQ0?=
 =?utf-8?B?ZlhhaEx0b0NENHltZ1ZQZFRvbVJsaVdiMno5Y2lmN0k1WUZmNC82RU9DOUVQ?=
 =?utf-8?B?Qm13UUVHV2xRQUF0TnBkSllodWsrTjRZL1BQdU8rUXZhSDFHTy9GK1dqcFlM?=
 =?utf-8?B?NHRxbjhBQkp4VVBxb3k0OWxiaXdveStUSHZGcHRPQzhKc2ZnZXRHYVhDajVK?=
 =?utf-8?B?QXhsdVkvSjEySDZoaDRCc2hrVnJFelU1RllaaVNoN3F5SVY3SXJmTTdHbkdK?=
 =?utf-8?B?aGhiLzJ2dzZrb0pXcnFDM2xFbWNnSHh4Tnd2QmU0SXNUc3BpVDg5Zjg2Znlm?=
 =?utf-8?B?S2EwUkdQR3BoM2xDUThtQ2RNUnRBdFdra0NIZXBpZXl6TmJNY2o4MFNEVzd1?=
 =?utf-8?B?WUliU3F2V3FDUmlVaTdFSlFWYmM4Y3FhbkdrTTlteWR1dWIzU1BFbjErQzNS?=
 =?utf-8?B?OVY1RXpvM05FelRocUlMdFR5dDhpWFRkZ1hwMXNobUxxUlV1SGVJbFpia3FO?=
 =?utf-8?B?SnRhQmNFRmV2NDdSc2I4eUIrcFd1aVRBcm9WRHdiOWZJanFKNTllcmNKa1ll?=
 =?utf-8?B?eWFiR3JjTWVxZ2RBd25OQllzUytzNERGcCs4dUYzd2JROXE0dnlFUVowdXZk?=
 =?utf-8?B?WHhIUzVsNGJQNkZWZFNpOXZ2OVZ6dWNaZzJaZHJtenZkKzJ1WXRhd2VIVW9O?=
 =?utf-8?B?amZqUStUdUE0U3pCUFJOcjFXZ3VEVkNDTjRzYUFRdEJkR2xWczA0SVRQV1lO?=
 =?utf-8?B?a0dsdXFHVi85djkxQk1rRkNyQnBxeHJ5M1gzYkxOVWdTZitpV3Bjeng5dEkr?=
 =?utf-8?B?MUFWa290dkFOSlJpQVJWRS9vTzdFUll2NnNDdmpLbiswMUtERFNaTVhIaWE3?=
 =?utf-8?B?M3dmbkdjYXFSZFNyMFEzOE1lZEZVVmVneVYxRVYyR1ZjMlFLMjhOYUFDK1RF?=
 =?utf-8?B?NEMrZDhta2V2U3R0bjR3YzN3aGN4SGs5am80bTZDOEN3MnNYYjRoaTdEZTVx?=
 =?utf-8?B?WXZrdVJENW55L2xIYnFDWEk4cDVHRU5PMlliZ2FsVjR6a0FoNUFsd3Z4NzVP?=
 =?utf-8?B?b0V4TWJ4T05VcUNxUlRBRXJIdG5xS0pUbHhFanFNbEw3VkRMYjJUek1TYm4x?=
 =?utf-8?B?djRKbXpSb1RtdjNvakpGNTdaMDM0MmZwcERhb1ZFK0taNEJwRUFPNlYvdVNv?=
 =?utf-8?B?YW85bmgxRHNWbG9YL0VJTElyYnBZZG1Leis5ZjYrMVd5RmFSekNtMXkxQXg1?=
 =?utf-8?B?VE9LcEdpUnVWZWdkbGRJV3pNQXJnanNWUElpbEVOeG9sZUtuUUIyT0h3Y21X?=
 =?utf-8?B?MkpQUXg2YmhmbHE2MkZPSGc2L21QRU9ITFA2d0o5K2tSbjV1b3RTRmZZUS85?=
 =?utf-8?B?UTRYWUY0dENRa0FEOTNHNVBZSDJSUC9kNUtOVmFtR00rYmVwclJWK0p5Nys4?=
 =?utf-8?B?TzJKL3BsY0ppdFh3d0dBTFlCRXowYzNWWTdwb1UxUlRod0l5SVRBK1VqaVF5?=
 =?utf-8?B?c1BzcG1rZForWkREK2F6TGs5WDFGc01NNlY3N05mRjhVMW5QWU5mNThvK0RE?=
 =?utf-8?B?YmtXT2Z0L1JIcnUvWDB6bHEyNTNobFE0b3FpK2FBdUU4bGwwODhFRjJJYVl6?=
 =?utf-8?Q?vJSw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 424bf517-4fd9-4d70-ad83-08dd8988425f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2025 14:47:27.8066 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NyapC/lbjW3JpEGOAFe6vfa+kI2eq1HAguzVboa8EXgMSaNka/EoZev0wv9eCYko
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7792
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
Cg0KVGhhbmtzIFNhbGVlbSwgSSB3aWxsIHJlZG8gaXQgYXMgdjIsIGluIGZhY3QgdGhlIG9yaWdp
bmFsIGltcGxlbWVudGF0aW9uIGluIHZjbl92NF8wXzUgaXMgY29ycmVjdC4NCkhvd2V2ZXIgaXQg
bWlzc2VkIG90aGVyIHBhcnQuDQoNClJ1aWppbmcNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCkZyb206IEphbWFkYXIsIFNhbGVlbWtoYW4gPFNhbGVlbWtoYW4uSmFtYWRhckBhbWQuY29t
Pg0KU2VudDogVGh1cnNkYXksIE1heSAxLCAyMDI1IDg6NDkgQU0NClRvOiBEb25nLCBSdWlqaW5n
IDxSdWlqaW5nLkRvbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBL
b2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KQ2M6IERldWNoZXIs
IEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IExpdSwgTGVvIDxMZW8uTGl1
QGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1L3ZjbjQuMC41OiBGaXgg
R0ZYMTBfQUREUl9DT05GSUcgcHJvZ3JhbW1pbmcgZm9yIHZjbjEuDQoNCkxvb2tzIGdvb2QgdG8g
bWUuDQpSZXZpZXdlZCBieSA6IFNhbGVlbWtoYW4gSmFtYWRhciA8c2FsZWVta2hhbi5qYW1hZGFy
QGFtZC5jb20+DQoNCk9uIDUvMS8yMDI1IDU6NTcgQU0sIFJ1aWppbmcgRG9uZyB3cm90ZToNCj4g
VGhlIFVWRF9HRlgxMF9BRERSX0NPTkZJRydzIG9mZnNldCBmb3IgdmNuMSB3YXMgcHJvZ3JhbW1l
ZA0KPiBpbmNvcnJlY3RseSwgd2hpY2ggY2F1c2VzIHRoZSBjb3JydXB0ZWQgb3V0cHV0IGZyb20g
VkNOMS4NCj4NCj4gVGhpcyBmaXhlcyB0aGUgaXNzdWUsIGNvcGllZCBmcm9tIFVWRF9HRlgxMF9B
RERSX0NPTkZJRyBwcm9ncmFtbWluZw0KPiBmcm9tIG90aGVyIFZDTiBnZW5lcmF0aW9ucy4NCj4N
Cj4gU2lnbmVkLW9mZi1ieTogUnVpamluZyBEb25nIDxydWlqaW5nLmRvbmdAYW1kLmNvbT4NCj4g
LS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3Y0XzBfNS5jIHwgMiArLQ0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3Y0XzBfNS5jDQo+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3Y0XzBfNS5jDQo+IGluZGV4IGE4Y2ZjNjM3
MTNhZC4uMzFjYjE5ZTE0NGZlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS92Y25fdjRfMF81LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNu
X3Y0XzBfNS5jDQo+IEBAIC01NjMsNyArNTYzLDcgQEAgc3RhdGljIHZvaWQgdmNuX3Y0XzBfNV9t
Y19yZXN1bWVfZHBnX21vZGUoc3RydWN0DQo+IGFtZGdwdV92Y25faW5zdCAqdmluc3QsDQo+DQo+
ICAgICAgIC8qIFZDTiBnbG9iYWwgdGlsaW5nIHJlZ2lzdGVycyAqLw0KPiAgICAgICBXUkVHMzJf
U09DMTVfRFBHX01PREUoaW5zdF9pZHgsIFNPQzE1X0RQR19NT0RFX09GRlNFVCgNCj4gLSAgICAg
ICAgICAgICBWQ04sIGluc3RfaWR4LCByZWdVVkRfR0ZYMTBfQUREUl9DT05GSUcpLA0KPiArICAg
ICAgICAgICAgIFZDTiwgMCwgcmVnVVZEX0dGWDEwX0FERFJfQ09ORklHKSwNCj4gICAgICAgICAg
ICAgICBhZGV2LT5nZnguY29uZmlnLmdiX2FkZHJfY29uZmlnLCAwLCBpbmRpcmVjdCk7DQo+ICAg
fQ0KPg0K
