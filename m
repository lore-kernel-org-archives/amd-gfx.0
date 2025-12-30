Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0515E92FE3
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Dec 2025 01:26:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D66510E025;
	Tue, 30 Dec 2025 01:26:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JZl4KYb9";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013055.outbound.protection.outlook.com
 [40.107.201.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95C5410E025
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Dec 2025 01:26:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BuausRzrhr3ehHdHWDHVQaoZf2v/bU/GoEnyUA8UryLwJlFZN8ixSY8qJ4+rfSOmvbdli1rJE3yCni4KRbYM23y/CIFR941kdQvgGlK77Q71eY9FqNaeszM+I4FdBbq4ELGfQYt/leY6avM5x03KHUeoRvm/YUexKNRxAU3s9GNhL73I8AQBcZ6KTdMmQCIzc6rQCnz9y4jh5XzCdaPW52wfAqWzlEAbD8jOKawyup2nIUDB5WzBjzAx7vicTsIXEbHo7rxMG4v0uX1JOXbAC80C3q8TENaRpRNszf3snyiKhfLBbkis+xtADxdrsrTZD1bCkOoPIHXX/yXTqv1rCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69aUXOzZ62fuj+cylslVvJBmUjFrZ9ZpIiFzJgrA4UQ=;
 b=VTLoy0IaS5BUNrWJbzlI6f39x1Z5yLquhSfTrUVWw1rXPw98sJsemuLwS7Y+tlhvvjhPpzPK4H3UNErfUuZ1PaxWfmoJCnuu49lMj6BFitwvm/9CInVf/oZBTKhHXoidzJS1e2wZwBk+oWJO0uLACJOH9xsAubI3r7wNTHmSkJfhNc0yUQZYrU6Y7FT2i4hvSQal1RfaiSfQ42hFambgsLWk+IJ4UORY90OHETvIwUnLNvuKr7rfPy3xS1PclQurj9SaITtnZfDKH0LqiK/tU5zzfpnCRcg0NjYlnuhjv0LNrUTp4TH2qgEuZzTn/gRTRqgDA59JBBcwV7ArJ8ok0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69aUXOzZ62fuj+cylslVvJBmUjFrZ9ZpIiFzJgrA4UQ=;
 b=JZl4KYb9n1CL2IajkdKb7K7RAWlSFQ7I/8rxbi7yzouO6oTQDBAY6PLlFjSWyqL+Gf4xksjjYxMdUyxqrB2tC9Vfg99V19pT8PJPAcES/lbrSDzq40ULwT0ZX+tQ5jt4zkFUiNCu+FoJuLDGN6pEWhR4dsYSwIhv3QlyMWW9A1Y=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 PH7PR12MB7844.namprd12.prod.outlook.com (2603:10b6:510:27b::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.14; Tue, 30 Dec 2025 01:26:40 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 01:26:40 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Jean Philippe EIMER <phil@jpmr.org>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Skip TLB flush for devices predating the SI
 series
Thread-Topic: [PATCH] drm/amdgpu: Skip TLB flush for devices predating the SI
 series
Thread-Index: AQHceGrxY3pv+IOQ4kSzjq6Ot3v2Z7U4YRAAgAEEgsA=
Date: Tue, 30 Dec 2025 01:26:40 +0000
Message-ID: <DS7PR12MB6005B8971C288DFBA90C85D9FBBCA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20251229022909.777645-1-Prike.Liang@amd.com>
 <e5967879-9d64-468e-ac85-e0dfb5136d45@jpmr.org>
In-Reply-To: <e5967879-9d64-468e-ac85-e0dfb5136d45@jpmr.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-12-30T01:26:08.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|PH7PR12MB7844:EE_
x-ms-office365-filtering-correlation-id: b294501d-290a-49fe-f6ff-08de47427bd1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MDNZMW56Y0dLU2JHSklsSHFUSUU3RitUQTQxR2RSY3gvbEg4OUc5OXAxZ3BG?=
 =?utf-8?B?RVdhUXJpUTRtRm5YdlcxU1VZak82S2t6TDQxSlN2T1pFRWQ0Y0RwYURmT2w5?=
 =?utf-8?B?SFdpejR3MmNkTy9vZWN2Y3YrSnNvSjlpVHhpNlBPOUxodnNhY1Qrd3crbVpN?=
 =?utf-8?B?VnorVlFZTlJMWGVIS2FIcXFZcUM5cExqZDQxVkhVTXB5YXVlOVlJeDZNNEdE?=
 =?utf-8?B?MERlVUNJUUQxRFBCUS9udEUrL3dJSWg4ak9Td0xZR3FuQStLdnFJZDIrUUxy?=
 =?utf-8?B?bzZMREc2Y25xM3BTNytjM0pueHkxS1JQY3M1enFFQjhKUlhLR2FoaUE0cEdJ?=
 =?utf-8?B?LzJwOGQybGQvMU5Na3lnTnIxWmN3ZjhzSWtrVVduV2JkVGw4OS9KKzN5VTJC?=
 =?utf-8?B?S1V5Vis0L1lqZ1NBQWduSGpKSTl5TjRXMXk1b3Zhc21yZjk5My9RcnBTQm1h?=
 =?utf-8?B?U3VxM2xsbGUrVEtoMTRyOHZ5MDdhVUxkemUvWHkvM2hiK3pHMW9jMGxCdmwr?=
 =?utf-8?B?OUE0OEsyVmFTSDBySkxLQTRyOVF4R0V2dkpteGR4c2hZcXVUQzRJY1Bjd2FX?=
 =?utf-8?B?Z0p1QXl3ZGgwUHNXdWpXQzJQOEQ2S3hwWmdGbG8xN09VZUFGRVpWUitpYkgv?=
 =?utf-8?B?MFQrN3dMRHZ6L05hUzd5SHRTSW04ZTRsMFhvM3lwSEd3eENJVldTZnF6bXh1?=
 =?utf-8?B?bHNla2QzNXNnTDMwUWY0b25OakZ6VnJZSDFrRlZYb1ZZc3dpTGJnblp1dnpi?=
 =?utf-8?B?dGFldDB0bmxCbTB2YWxQcWVMWCtBdHoyV3NNNCtJMitCS2VRTFhDam5wS2pz?=
 =?utf-8?B?N0pEOFVXbnlWRDhYdXNuNnZaY0lyczMyWE5jeVprQy8xWk8xQ1YvWmRGck1v?=
 =?utf-8?B?eW5RZWNLT2hncU5LMmdBUEdZNXFLUG1yTXUvclYxcWFsaTh0ajBLeFZOUG8y?=
 =?utf-8?B?bmZhMXRsQnIzK1ZpWi9KR3dabDhFWVB2QkNSbVBSNlVGRTZoQzNoVlIyS2tn?=
 =?utf-8?B?dHNoRFcrZnA2bzc3RkNQbUYzeXdLVThJYWdWNmdLTDY0aUdnaDYyd0Yxb053?=
 =?utf-8?B?aGltcXFZVDN5MzdMT0lDVVpGTVcxMFhlYTFBMDlYVEFXY1FqQUZ0VWE1YXN6?=
 =?utf-8?B?bWNVcmdoanFETlh6akovWGNJZEJzUUk0UDhHWkpzM0J0a0h1OWNSQzROeFdP?=
 =?utf-8?B?UmFkZFk4eWJKZEVqYTJQY2R4LzB6MmtmNmh3dGk5aXNLeVlsdFh0MlBwN3Yv?=
 =?utf-8?B?blJFbFdibHBnSXZOS1AwYjN4S1FYeEorYjM5aXFBVU54L0dZTVNIdG1RMWpL?=
 =?utf-8?B?eDlVVVdsZnZFaW5ra05rOGRmUTZyWmV1REpvSzZQZ010S0x3WlBFVCt1UHlC?=
 =?utf-8?B?VFlhdEI5SHJ0RS83eSs0N3JsUGJoUHJBV2pDOXR4UXFzYmlvL3lrRkN6QkVv?=
 =?utf-8?B?OFUwQURoZzF1enRzTmwzQit5eGp4TTVkcFh5TXMwN3Bkd0tEVTRrNTBaRWx6?=
 =?utf-8?B?MmRIK3ZkdlZqMEZNWVJrWG1mRDNVZDZ3VWRqZTUxSDd0UWNrekRlanByL0ZY?=
 =?utf-8?B?aXRYK3AzWDFwalZMYVc5TnFnaERtOGRFbzFyTTFOQnhvVWp5VFBhQUZUWDhN?=
 =?utf-8?B?NjhzbWY3VnVWcDRmUmxXR1ppV3NFeC9hOFpTRi9LNFBkSS9WYUVYRjYxbElE?=
 =?utf-8?B?dGQrT2Jld0ZKVzd6YjNEUzcwQW5iVXA3VDU0U00rRVBxRTBrVW9veU5HT2F2?=
 =?utf-8?B?bS81NTVOaUFneVNHTWVqZDAxbklHc0lIVXBrMkwxeU5uOUJ5ZTFUU2txaHY3?=
 =?utf-8?B?RGVMM0ZVK3JtRnBoaVlrOUpralRiMlo5VkEvZzV0a2xtV1MrbWVvRGZ5WTJ4?=
 =?utf-8?B?bUR3emowQXdzZUZVaEI3MzVCRTl2ZlJid0JuYXhEc011WVFpVkhaV2ZwSDVw?=
 =?utf-8?B?NGkzaGtpL3hPeEdNczZBQklGU1pYZzduaHdXQnJKS2hiWE5TTjF4TWE1ZUpQ?=
 =?utf-8?B?MU4yUTlEVWpEYW0vSEZmVkppeUxHaUVBSmNJejJmcDVLdHhiOXY3VWxCUHpT?=
 =?utf-8?Q?/B8aPA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YU5lV2RqenNKK1NoOWMyMitMT3BqdU9FM1EwQ05SZlBMekZ6emkrZkpYbm5F?=
 =?utf-8?B?UUtHOGNONkdXS2xNOEFLazRYYjNwSmVqV24rWXlvZVhOaG52QlNPL1VTcHhx?=
 =?utf-8?B?SEJjdEhRcDBGSUdya2d3WTdVMlNtMGpnUE1nRUQwUmt3RmpvUWNBbDVkSXJX?=
 =?utf-8?B?ck5FbXN6VHBKQW1hYVNuSW50d3U2UzhhNFlIcWZseExvb2dJNEtDdXJzU1ND?=
 =?utf-8?B?aVBXQkUyWnQxT0s4c3ZBUXAxNGhqM1M0K0NtSVFSTFMrNTBlU0MyQXRvMDlM?=
 =?utf-8?B?T2UyZ1BGL0lnKzFaN09sRTR6aVBsNWoyNzY4ZVk3QzBSVGt1NkJ4SXVrUXhM?=
 =?utf-8?B?VjF1UHdwV3JOcG0vMGJQaUZNYXU1Z0xxZEEyb3R5MlMya1Z4TGFEbUxhSSs2?=
 =?utf-8?B?TVUxb3ZBR1kyaGdNcDhMTHRYak5IbE16blVoSjJGNHZHNHNSbGlCRzR2NHQx?=
 =?utf-8?B?OC9JSjJoUnErb3Nwb3d4SitBeC91bk5PMXBVMHdFWG9rQlFLaVJ2d1FmYzZT?=
 =?utf-8?B?QTF5U0prRDZicjdPeVAzMFVQSnFxaVdGSjhYOGk0d1JFZlRTTEluMDUxR1Az?=
 =?utf-8?B?dmNMalduenRhbEcwQXpNdFdXdjE3MDdHUjViQWJOaVpkZ1NEY0dRcTZQOFk0?=
 =?utf-8?B?V2hzRzJvRDgwZ05UQWRRRkNEb0NQL3NrWmY5cUUyUnVhODJQWWFrMmN3SzI1?=
 =?utf-8?B?eTNxYW9OQ1FpOEdlV2pFYXB3ajVFSjc4OXk3dDZ2aEV3M3pzMXMyM0UxcGVq?=
 =?utf-8?B?dWV2M1BWVUpPdldyRFJHVCtsQTZwKzV6ZE9ZajhuNitLS3FIMXErQ2J6dW1H?=
 =?utf-8?B?eXpTZFRxdUVnK01Bei9oMDhTSTNHaCtTNWpzRWhHMkRrcUtuc2lqWUZlRTda?=
 =?utf-8?B?MTFhcnpUb21UOXg4ZGd5OEx3L2VzUkMwb211UEphamVBclFVTVYwSFJWMlV0?=
 =?utf-8?B?Tmx5NG5hRFBtd2pBcWNTSkV6aURtREZNdUoxaXFzODQ2MlpPRzhWSjhKSGhH?=
 =?utf-8?B?ZUQ5dGlFV1g3RzJYK0lxSzVDa3hIeWRkbDNFK25rYnpTVnZKUmdWb3RzMHp2?=
 =?utf-8?B?OFRDclo1elRHeTNCeGpqbW1QU29VWmxhMWU2TTZqRlRVQXg3b01qWlROWGlj?=
 =?utf-8?B?Z0dERkVkemNDNnZRZlllUHhVcU1JK0ZYTzUrcVdJcHJhLzdjenpySWN4eVls?=
 =?utf-8?B?TUlycWRscXZhZ3Z2Q2pyaGVXaGpPUW1vR3V3dE4xWHgzNzlSUUdMTXhmTEg2?=
 =?utf-8?B?ZHdFQ2pJUDlqMDZXWVVxOGhGQ2VLVUkvQUlzOCtEU0VJS0RwU3luSGVyUlVj?=
 =?utf-8?B?eGJ2MGoybTFxWDM0VUFOQityZHNRYzBra2JrbFB2Y1hQVnk3TUY5VzVwQVJv?=
 =?utf-8?B?OE0zOTBXNnV5enRTOWRwRVBSU2FqTWpFbVdiakdWVTZDck5LUDJUQzhoNmQz?=
 =?utf-8?B?dkxJWDZWWWxrTE5IbUJ5WFRrVEJpZTRjdTgwWW11eDRHdUdwOTdwQjRqRFg0?=
 =?utf-8?B?TmFtVVo3Zi9jdkIvZmNSb0dWOHlKSy9XSW5Ya0RjUXE3bUY2VUJ3RHovbGQ3?=
 =?utf-8?B?cWNUb05oMWYvTXpzQmptcm5hNmpZYmtoeVBSNGxZbkU2aXBGTHpyZThmT0Ur?=
 =?utf-8?B?M054Yit0OG5zQVd1eHRPVEwvSFFkQmEwdHEvaUNZWlNRSUxpVElWbUxpcTlZ?=
 =?utf-8?B?cjFEbTY1ODl6YzRhNTlhL01NSFZXV2hPVzJwa3FLNjE0Ri95U1hFcmlsMkls?=
 =?utf-8?B?U3pUbGYwa01ISm5mVzNXWUhKQlZLV01VSng4S1dwelh3cWxUNEl0MzRJdUxv?=
 =?utf-8?B?T01pcU94S3oxWDI5bU1EZ2g5cWxwNDhzdDVob1hHSlV3V3RVQ0xSUDNBTC9F?=
 =?utf-8?B?UjhmdlJUOHRjTjEybWlxdmdWWG1NTzlqUEpkelEzeHpPUVAwWnB4R3JBZnNY?=
 =?utf-8?B?OG9manVOZnErcVB4bVczYXRUbklLQk9qN1BYMmVnaFJMMVdpQnBhdkF5ZWNq?=
 =?utf-8?B?K3QvQ1pMNlVhN0RKUUt5OEZVWXdiRDdhNCtvRGQyd0RweDhWOS82R3lwTW8w?=
 =?utf-8?B?cTFQYkh4ckx2TVV0Ymg1R2t3TkIvazNTcmRwVVlRV0pIdm5qcGJoYzVYaS9B?=
 =?utf-8?B?MXBidVBoVmtMcENlZVFIZERJY29VWCszREZNa3phdUt4VjNRa3pHQjkyQkND?=
 =?utf-8?B?YUU0Rytta2ZTNVZndU9NcExsSGVpNEprMkZCNVBKVGlCcjFsNUdPMWNxcmxx?=
 =?utf-8?B?MWNVSExXd0QzcUc4Z3J2Y1A3bFE3RHUwT1N0N3dzWjhnaHN3YWo4aDJKaEU3?=
 =?utf-8?Q?fvjDpYc3RLenakJ4sn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b294501d-290a-49fe-f6ff-08de47427bd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2025 01:26:40.3423 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: czpJnWufrCi/FPQGlW1A4vNe82Q2owkIOHpL7bc6c1df6g3Cx3D8OkXZ/GhG4yio
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7844
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

W1B1YmxpY10NCg0KVGhhbmsgeW91IGZvciB0aGUgZmVlZGJhY2ssIEkgd2lsbCByZXdvcmsgdGhl
IHBhdGNoIGEgYml0IGFuZCBzZW5kIGl0IGZvciB0aGUgdGVzdC4NCg0KUmVnYXJkcywNCiAgICAg
IFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVhbiBQaGls
aXBwZSBFSU1FUiA8cGhpbEBqcG1yLm9yZz4NCj4gU2VudDogTW9uZGF5LCBEZWNlbWJlciAyOSwg
MjAyNSA1OjUzIFBNDQo+IFRvOiBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+OyBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxB
bGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4NCj4gPENocmlzdGlh
bi5Lb2VuaWdAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogU2tp
cCBUTEIgZmx1c2ggZm9yIGRldmljZXMgcHJlZGF0aW5nIHRoZSBTSQ0KPiBzZXJpZXMNCj4NCj4g
VW5mb3J0dW5hdGVseSB0aGlzIHBhdGNoIGRvZXNuJ3Qgc29sdmUgdGhlIGhhbmcgSSByZXBvcnRl
ZC4NCj4NCj4gUGxlYXNlIGZpbmQgYXR0YWNoZWQgMiBsb2dzIG9idGFpbmVkIHdpdGggdGhlIHBh
dGNoIGFwcGxpZWQsIG9uZSBvZiB0aGVtIGJlaW5nIGZyb20NCj4gYSBkZWJ1ZyBzZXJpYWwgY29u
c29sZS4NCj4NCj4NCj4gTGUgMjkvMTIvMjAyNSDDoCAwMzoyOSwgUHJpa2UgTGlhbmcgYSDDqWNy
aXQgOg0KPiA+IFNJIGRvZXMgbm90IHN1cHBvcnQgUEFTSUQgb3IgS0lRL01FUywgc28gdGhlcmUg
aXMgbm8gdmFsaWQgVExCDQo+ID4gZmVuY2UgZW50aXR5IGF2YWlsYWJsZSB0byBwZXJmb3JtIHRo
ZSBUTEIgZmx1c2guIFdpdGhvdXQgYSBmYWxsYmFjaw0KPiA+IHJldHVybiwgdGhpcyB3aWxsIHJl
c3VsdCBpbiBhIE5VTEwgcG9pbnRlciBpc3N1ZSBkdWUgdG8gdGhlIGludmFsaWQNCj4gPiBUTEIg
Zmx1c2ggZGV2aWNlIGVudGl0eQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUHJpa2UgTGlhbmcg
PFByaWtlLkxpYW5nQGFtZC5jb20+DQo+ID4gUmVwb3J0ZWQtYnk6IEplYW4gUGhpbGlwcGUgRUlN
RVIgPHBoaWxAanBtci5vcmc+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZ21jLmMgfCA2ICsrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9nbWMuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9n
bWMuYw0KPiA+IGluZGV4IGNkNGFjYzZhZGM5ZS4uOTY1YWUwMjIzMmUwIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYw0KPiA+IEBAIC03NzIsNiArNzcy
LDEyIEBAIGludCBhbWRncHVfZ21jX2ZsdXNoX2dwdV90bGJfcGFzaWQoc3RydWN0DQo+IGFtZGdw
dV9kZXZpY2UgKmFkZXYsIHVpbnQxNl90IHBhc2lkLA0KPiA+ICAgICBpbnQgciwgY250ID0gMDsN
Cj4gPiAgICAgdWludDMyX3Qgc2VxOw0KPiA+DQo+ID4gKyAgIC8qIFNJIGRvZXMgbm90IHN1cHBv
cnQgUEFTSUQgb3IgS0lRL01FUywgYW5kIHRoZXJlIGlzIG5vIHZhbGlkDQo+ID4gKyAgICAqIFRM
QiBmZW5jZSBlbnRpdHkgYXZhaWxhYmxlIHRvIHBlcmZvcm0gdGhlIFRMQiBmbHVzaC4NCj4gPiAr
ICAgICovDQo+ID4gKyAgIGlmKCFhZGV2KQ0KPiA+ICsgICAgICAgICAgIHJldHVybiAwOw0KPiA+
ICsNCj4gPiAgICAgLyoNCj4gPiAgICAgICogQSBHUFUgcmVzZXQgc2hvdWxkIGZsdXNoIGFsbCBU
TEJzIGFueXdheSwgc28gbm8gbmVlZCB0byBkbw0KPiA+ICAgICAgKiB0aGlzIHdoaWxlIG9uZSBp
cyBvbmdvaW5nLg0K
