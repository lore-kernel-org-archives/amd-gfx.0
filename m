Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADAAD3748D
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 13:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C115A10E849;
	Thu, 17 Oct 2024 13:22:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PMpotpXX";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7651B10E845
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 13:21:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezc/U167yCP+b78/1k0Y+/naPrv4XJAF8Qk4tGWqOxpb1EDUErbZLcWTvRARnAx+B6yjgCNDE8wflwUVpY+gSKTRm1nxmm41fOV6PNRVm/0LHuH0xOZsZul8kpYOhM3DRv9+12Z6ZS5qTgBtGeVFw2yHj2az+kqC8XCTYtAPIQ8V9v21CdUbzaTdiC3c8sGa08JTXWHetOCQ9cC6yYl6b/XXJwE/8odXzE84zoNJI5zmtJmzo461+jWOVnN/pwEPK+aDGWPkTCnq8CkDEJfBwB8P18pdhAnmQzgw0dS8uMrtBhr/N2BWs/ty1p+OA+PKM+sy7QsYlOPUM2FZa2IMYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sU915tl3PHVwLC57yoNlVIl6npvq+3VKgbP2Bh8PCUE=;
 b=s4FKDG2dYZVXCRImkrud8OVuZ13MezsY2GsUEsqFAtI9y/D7wv5XzCU7Oe9GENkkf55tYv6KhFj2wR9kPFmxgquJn30jKY57OQ9cGqUog9Fg4UXp5W00hrEuYE+8VTiOTmc1vzWs8linVP4NiPe+zFSSg9HT8waCsB9FPh1Y/SSQ+A4aFB1uHsNL8kX11K17KXu1v+Z7llo35YzvlLcTcyjjXMEygwOl+S0bOwNU3BCMI+ty7Ww2YKxOKc83jcS8ouQtgbXUbj/TeYz4CiZghei0V/6V/L5Mn1rHfuxdnNsSOQT/lgO0QOJaPPLagDEp4fDQ+Wrd9XTNM2YM39ozxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sU915tl3PHVwLC57yoNlVIl6npvq+3VKgbP2Bh8PCUE=;
 b=PMpotpXXEu6XmzYStCkwemw6I3w2O10tyGVETPFwxncZHjwWpnRZ3mxIy+CSunFF23b6hgDrWnfCGN8ss+VplAQUxlV4uNrvrEue3kKVFJosAL2mYV+/6ngvOe3x/qLlhsfKiaWWkGK3X6v0OeQeL5EBsYRi5N2IFIZ3kEsDJCs=
Received: from CO6PR12MB5394.namprd12.prod.outlook.com (2603:10b6:5:35f::19)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Thu, 17 Oct
 2024 13:21:56 +0000
Received: from CO6PR12MB5394.namprd12.prod.outlook.com
 ([fe80::641f:33ef:d412:4080]) by CO6PR12MB5394.namprd12.prod.outlook.com
 ([fe80::641f:33ef:d412:4080%4]) with mapi id 15.20.8069.020; Thu, 17 Oct 2024
 13:21:56 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Sundararaju, Sathishkumar"
 <Sathishkumar.Sundararaju@amd.com>, "Jiang, Sonny" <Sonny.Jiang@amd.com>,
 "Zhou, Hao (Claire)" <Hao.Zhou@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Save VCN shared memory with init reset
Thread-Topic: [PATCH] drm/amdgpu: Save VCN shared memory with init reset
Thread-Index: AQHbHsrLxm7tqLwrx0GjESM6xLaItbKJXZSAgAAt32CAAL1tAIAApEQQgAAC24CAAAEmIA==
Date: Thu, 17 Oct 2024 13:21:56 +0000
Message-ID: <CO6PR12MB539460FA525D954E0EFB02AFE5472@CO6PR12MB5394.namprd12.prod.outlook.com>
References: <20241015062316.3050046-1-lijo.lazar@amd.com>
 <7cd47976-10c9-41d1-9e48-8b47617b3d48@amd.com>
 <DM8PR12MB53993F24544631CE138C41EFE5462@DM8PR12MB5399.namprd12.prod.outlook.com>
 <8ede8dfc-1718-416e-96c5-e6033c5bfb87@amd.com>
 <CO6PR12MB5394D8B004517BD13D463C6BE5472@CO6PR12MB5394.namprd12.prod.outlook.com>
 <3f175af5-ab8f-40f0-ae1b-4d3f7ad04e17@amd.com>
In-Reply-To: <3f175af5-ab8f-40f0-ae1b-4d3f7ad04e17@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=eb0bbcc8-f981-4f55-8f97-add4928c95e1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-17T13:20:41Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR12MB5394:EE_|DM6PR12MB4299:EE_
x-ms-office365-filtering-correlation-id: e4ce545a-0a01-4c8c-f2e0-08dceeaeac82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NFQ0eFM1MTZpOXpTQm12Y0dLOWNOTVBrVGtBeld2dndBVHBrUTFsb2l4S2ZY?=
 =?utf-8?B?K2E2THVlcHQ5eHZJQkwrbGpVUW9qR3JXZHdDekovQU5Ec1ZTYmEvcSticU93?=
 =?utf-8?B?Mk5RSHRxQUtnOHhkVHE4K2xiSWsrMTE0emEyU2xCdjBDMlcwTWtpR3BUR2Ur?=
 =?utf-8?B?QVg1ZmdzZWQrcVpjajMxSC9XYVllTUs5VlZRd3lqb1BtWDR4d0w5NTJjWGlk?=
 =?utf-8?B?T2FNZDFRMGN6TzNXL2szWFZDTDh0dlZVUVJjK0FCaU1jVXJHdWYyZVMxQ09D?=
 =?utf-8?B?WE1JdndkL3BvK25EdDdGVTRpdU0xOHdpMmRDRGhTU3E2SlJ1R0w4STY2emdv?=
 =?utf-8?B?TGIzb3RybW82VWpUcVAzcFVHY2hyZnRiaXYyUDdTcU5mNGMwaWIzVmZQbDVR?=
 =?utf-8?B?OU9OSktSY2N6QVgxKzBwbnljd3QvRkcvV0Y3ODVMdkowWGxiWUR6MmVsdnlW?=
 =?utf-8?B?elNQS3pidktHWWxiUWpwVWszTUJsdWIvUmFoVWpwMU5YYUUwUU8zcDBtL2Uv?=
 =?utf-8?B?YVJhVi9vWUkzbC82K1ZOVDUyWTBPR3UvQ3Njb05CTU5KOW9zTHdzSHBQMDlY?=
 =?utf-8?B?MDNRN1dhSVk1YzlqTXZlNVcxdTFkdjFaU2xjZ29manJod0lmVEIzV2hwMVpx?=
 =?utf-8?B?SXBMSkNKZmdCT3lOcnJqcFd3TjJhdU42S1p2V29rc1d6eFJ4bnhnWVhQdjli?=
 =?utf-8?B?TU1EVzM3RVYwUGtNN21TOEE4WlN2a3N6N0MrUjdFaU9scDBJcTJCSjJ6Wlhs?=
 =?utf-8?B?a2tmei9SOEtNOFNaUXlLTUxXc0dQanNzRFlGbit2VE9xZGlFSy9oRE9oZS95?=
 =?utf-8?B?dVBYb09xbFQvUHhKRk9MaDZnaEI3M1ZFY2tsN2xPcG4xbEd6U2tGcktTNXho?=
 =?utf-8?B?QnJacHF6NlBWdGdkMEFNZGpBeTBpVDRWMjNDb1BGMERYSWQxYXduQXN2enhU?=
 =?utf-8?B?NHBtVTZBRkFpSlZNazBzY0J2OW5QOFFweHY4bUhQU1J2K2NmcUFNS01tWlB0?=
 =?utf-8?B?OW9PN1dMZStzdmJjUnpBTElyNmRleENsNVVMZnMrZnVhNTdpSzZ5YjdPV2Ux?=
 =?utf-8?B?TnZ1TWtML1RTc2hyNkdCKzhTdzRHWlhzanF6a0xUTjFyYWkxbEFwMDBJZjdI?=
 =?utf-8?B?VTl3ekZIN2poQjNKWkt0MFI5bkMxVDljRFc5UzE4cENtZVoyemplQ3RLRHdT?=
 =?utf-8?B?NCtYQXVldTZaQmh2cFNvSVdxU3o3SzRBdVNhcStjeStOcXNIUXFkMDJGOVYx?=
 =?utf-8?B?RmhkWXI3MzlLdWVvV3FRcmU3dzNZVFdaUmd6ZWNmSVE5SGVxZ2xMVUxCRkpj?=
 =?utf-8?B?aVhReVpvRHpKdnVnV05uV2ZIUFltZ296cHJXNXd1emd0ckRSUnlGSWR3cmNI?=
 =?utf-8?B?VWw2b3ZLRHc3WGI4M3hUU1ZYZ1o1OHc2dlA4WTVqc1V0OCtrUkRxMWRZbUNt?=
 =?utf-8?B?N2luK1c1UWU3TnVpL3dmdHJSWFdJNCtRNjJkcHp6Z3gyOWR5WXVKTjg2bElD?=
 =?utf-8?B?aTVRUzZuLzZaZzl3ZzFCNmlYTWRjS0VXTnJyMjNjRXphd0V3RzAzSXdBNHBH?=
 =?utf-8?B?RVJHaEdpRExaVWE4MDFWU3FFaTFDSmdKbEpJZ3NtK3EybjlvMFR1cktZV1NN?=
 =?utf-8?B?OTdHVVJtK0xvMnVDcGlIN2JxTnp0RVRtVmVLcUhKQnB0RG1qaXhaT0xGcFpQ?=
 =?utf-8?B?YXhYbExxcHRSMkNBRnVBYkhYNlFITFd2WkxhZmdRK1dwR2k1MFp1T0ZsejdY?=
 =?utf-8?B?aU9hZllHMVBNZkl3Y0NnVzZUZm8yTWJvdllOMnJyUFFRaEN6UmpIbU1HQTRa?=
 =?utf-8?Q?jbfkyV+8XE94NtIxsQBDgalOxsAg15wwz2x5k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5394.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekVFOU9oU3oxOG1qZkpuQkwyMVcxajRqbHBLVGRXSm5yN2hFOHZqYVpTK255?=
 =?utf-8?B?NlhzL3FiMGtoU3ZTMWM0YUNPaVQ1eGoxZEUrVEhOOHVndFVScU10cnkwaHN2?=
 =?utf-8?B?K0xTS1VnWHp2ejZpakVoQzN1bDd0QVd2Mmc1TWY0bm83bFlnanhUemlkWWNT?=
 =?utf-8?B?ZFNWNHp0Z0tWNzBmQzQzUFhYNEdkYUFCOVRIL29LNVZFTy9RcUJxMjFESjJh?=
 =?utf-8?B?Y0xXdWlDWXlnT1FrakI3emJTdmxIOG5xcHc0RkdjaHQxL1FyNzc0MHUvV01P?=
 =?utf-8?B?KzdSc2YyTFZUclBkWllmdGRoL0VNN2RBSDFRUVdaenVUbGN1V204RC9rajNt?=
 =?utf-8?B?TE9VMGt2NjJ0VTE5VVBWYms3YVl3dU91ZXl6VWF4UFFQV2VmeHNtcittb043?=
 =?utf-8?B?U3p2Und5MmZxaUFReXNjUnU3QzZQd1BqMERUL1E5a011NzBFckVVNldoVEM5?=
 =?utf-8?B?OGxPcUd3Tlg4eUN6alZ3b3lwUU9xK3NEN0tzZStqQng0YUxPTzkvTlVrbm1H?=
 =?utf-8?B?TXIwWFNWVExGNzNtNlpzRlNlRkY5bGhqQVNGdXp2dWhscHEwVWZQOXJQbDRq?=
 =?utf-8?B?NEQvKzBIZFpZdlV6Z3lEeXRoRGJ1SG8wSENVeXo1ZHdhc3pwTWRsb3lXNWRs?=
 =?utf-8?B?aHdSV2JiNm1YMHV0S1A3UFBLaTB0RDA3MTl4TDlNS01ySGNEU1ZyZ1NWUDRV?=
 =?utf-8?B?Q1V1MkM1QzdReHNIdC82b3F1b0p0WE9Sai9KQU9PQTFleDZwUDFKV2JXcXlU?=
 =?utf-8?B?TWI4em9NUWlyR1FjcGZUb1R0UHByRFBPOWlwZDJOR2J3Tm93Z2x0RitRejVy?=
 =?utf-8?B?cVFibkJXSkp5MUc4bjMrQmFhWHFlWFdpK0sreUpnNFdPV2dDaXlTeVA3RHFK?=
 =?utf-8?B?cmR3ZzhaZnovMTBZZkVMNnZ3RmVhQjlmZ2tidXZSMFhNQlF1anhoREZiRk1w?=
 =?utf-8?B?NS9KYVJRaXFkUmxjYnU1Wmo2RFRzdUEvUFQvcEt6VTUzdm9BRE5sMFBaSjcz?=
 =?utf-8?B?UTVocHg3eDdvaGJLMzB6MUFuNHNyK0dGSmNoNHp6VmhIaEF3eXVMRW9sNkxq?=
 =?utf-8?B?NHVnaGJkZGxNeDRWSjZ1WFNNNno3L1BZWmc3dVd3K1BDbzRaWFB6NjBzTDYv?=
 =?utf-8?B?d2MwMVNsb2dDdjMwSXZzZWN3eW5qVXFEYVlIbEZVVFphcWh2YkRGbS8va3dI?=
 =?utf-8?B?dm45VWVRVzQrTlFveW9KQ3M2U0tLRFoyS3NhYnFmSXllTUVtN0xwT3R4Vk9v?=
 =?utf-8?B?bnpXcHQ0d3AwbDl3ZGM5NUNhSE54N0I5czdZelNldGdnVnF6QnJYZ2NmblRa?=
 =?utf-8?B?Y3liN2F4N3NDelh3VVNKYXZFQVNISnJOM3daaEZLK05GWWE3UzVEWXg3QWdk?=
 =?utf-8?B?dmI0Z0JXeDA4TldURjhNd00vTlYwc3UxakEyRjliWE5EVEN4WVRmNVhneTFR?=
 =?utf-8?B?RWhwTEFKU1pnZlhHeWNYYXh3aTJyRkQ0TVdiUktJY3p4RnlHMCthK0lQa3Jj?=
 =?utf-8?B?Y1hxU2RHMkxjbU1xSUI0eTlpZW9SODZUOXRUaTRzNDYwMlcybVp1bkpyN2xB?=
 =?utf-8?B?bFRIYzY2Q2cxMFVURHV1Y2lzanI2NWtWM3ZBb2QrQWdVbXhpM2tYOTU4YWFL?=
 =?utf-8?B?a2wwOG9waHJIOUhkMDdnSXdQMUllMG5obnRybXBlSUZyUEdhVm5GeXZwdFlz?=
 =?utf-8?B?Tnl4a2xTM0xnY0prQnVvNkpPREFGYUFPaExlYmUrcXpKb0lrZlExTUJIbGZC?=
 =?utf-8?B?ckh4aDF0UmRmczFHaGpmUkhwV2RaNzVPVHdBZXN0bHUzK016cGRoK1JWNWUw?=
 =?utf-8?B?ZUsvdGZlN1hVem9HYmtWd0JmNWRjNjkvSVQ5dGtEYWZmZFpLVUptNjVUNzJa?=
 =?utf-8?B?aFkzVjRpWnIzZG4wUkZneGsrSUI4Wks3MVpCRUhzWUZBNERSQm5XWDlaeDhs?=
 =?utf-8?B?d1dqT0hkVENSTE9UbGFnb3ZpR0NsWUVuN25YUHZnVzZ1R05URVlTL2JROUc3?=
 =?utf-8?B?U3JiYjUxMlByVXorSmlLTXh1aXhlZTEyMHk3RUhyNHdsREk1OWh2V3FKL1pn?=
 =?utf-8?B?K2VTc3FyaUZ5VVlNMndiWm9qOC9XbVNneEFPMk15L01TQ3NYaG1RRkk5NTNL?=
 =?utf-8?Q?k6GE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5394.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ce545a-0a01-4c8c-f2e0-08dceeaeac82
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 13:21:56.5652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ecEYuVBjlodID9p8WUCfaluTZyw+RNfk9r9CLk1yGC7PRK7mt2FWxd+vcu1D9P3c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXphciwgTGlqbyA8TGlq
by5MYXphckBhbWQuY29tPg0KPiBTZW50OiBPY3RvYmVyIDE3LCAyMDI0IDk6MTcgQU0NCj4gVG86
IExpdSwgTGVvIDxMZW8uTGl1QGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbg0KPiA8Q2hyaXN0
aWFuLktvZW5pZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6
IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5k
ZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBTdW5kYXJhcmFqdSwgU2F0aGlzaGt1
bWFyDQo+IDxTYXRoaXNoa3VtYXIuU3VuZGFyYXJhanVAYW1kLmNvbT47IEppYW5nLCBTb25ueQ0K
PiA8U29ubnkuSmlhbmdAYW1kLmNvbT47IFpob3UsIEhhbyAoQ2xhaXJlKSA8SGFvLlpob3VAYW1k
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogU2F2ZSBWQ04gc2hhcmVk
IG1lbW9yeSB3aXRoIGluaXQgcmVzZXQNCj4NCj4NCj4NCj4gT24gMTAvMTcvMjAyNCA2OjM3IFBN
LCBMaXUsIExlbyB3cm90ZToNCj4gPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIEludGVy
bmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4+IEZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+ID4+IFNl
bnQ6IE9jdG9iZXIgMTYsIDIwMjQgMTE6MTggUE0NCj4gPj4gVG86IExpdSwgTGVvIDxMZW8uTGl1
QGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbg0KPiA+PiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQu
Y29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPj4gQ2M6IFpoYW5nLCBIYXdr
aW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPj4gPEFs
ZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBTdW5kYXJhcmFqdSwgU2F0aGlzaGt1bWFyDQo+ID4+
IDxTYXRoaXNoa3VtYXIuU3VuZGFyYXJhanVAYW1kLmNvbT47IEppYW5nLCBTb25ueQ0KPiA+PiA8
U29ubnkuSmlhbmdAYW1kLmNvbT47IFpob3UsIEhhbyAoQ2xhaXJlKSA8SGFvLlpob3VAYW1kLmNv
bT4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogU2F2ZSBWQ04gc2hhcmVk
IG1lbW9yeSB3aXRoIGluaXQNCj4gPj4gcmVzZXQNCj4gPj4NCj4gPj4NCj4gPj4NCj4gPj4gT24g
MTAvMTYvMjAyNCA5OjM3IFBNLCBMaXUsIExlbyB3cm90ZToNCj4gPj4+IFtBTUQgT2ZmaWNpYWwg
VXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQo+ID4+Pg0KPiA+Pj4+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+Pj4gRnJvbTogS29lbmlnLCBDaHJpc3Rp
YW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NCj4gPj4+PiBTZW50OiBPY3RvYmVyIDE2LCAy
MDI0IDk6MTYgQU0NCj4gPj4+PiBUbzogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT47
DQo+ID4+Pj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IExpdSwgTGVvIDxMZW8uTGl1
QGFtZC5jb20+DQo+ID4+Pj4gQ2M6IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5j
b20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPj4+PiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNv
bT47IFN1bmRhcmFyYWp1LCBTYXRoaXNoa3VtYXINCj4gPj4+PiA8U2F0aGlzaGt1bWFyLlN1bmRh
cmFyYWp1QGFtZC5jb20+OyBKaWFuZywgU29ubnkNCj4gPj4+PiA8U29ubnkuSmlhbmdAYW1kLmNv
bT47IFpob3UsIEhhbyAoQ2xhaXJlKSA8SGFvLlpob3VAYW1kLmNvbT4NCj4gPj4+PiBTdWJqZWN0
OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBTYXZlIFZDTiBzaGFyZWQgbWVtb3J5IHdpdGggaW5p
dA0KPiA+Pj4+IHJlc2V0DQo+ID4+Pj4NCj4gPj4+PiBBbSAxNS4xMC4yNCB1bSAwODoyMyBzY2hy
aWViIExpam8gTGF6YXI6DQo+ID4+Pj4+IFZDTiBzaGFyZWQgbWVtb3J5IGlzIGluIGZyYW1lYnVm
ZmVyIGFuZCB0aGVyZSBhcmUgc29tZSBmbGFncw0KPiA+Pj4+PiBpbml0aWFsaXplZCBkdXJpbmcg
c3dfaW5pdC4gSWRlYWxseSwgc3VjaCBwcm9ncmFtbWluZyBzaG91bGQgYmUNCj4gPj4+Pj4gZHVy
aW5nDQo+ID4+Pj4gaHdfaW5pdC4NCj4gPj4+Pg0KPiA+Pj4+IElJUkMgdGhhdCB3YXMgaW50ZW50
aW9uYWxseSBub3QgZG9uZSBkdXJpbmcgaHdfaW5pdCBmb3Igc29tZSByZWFzb24uDQo+ID4+Pj4g
QExlbyBkbyB5b3UgcmVtZW1iZXIgd2h5Pw0KPiA+Pj4+DQo+ID4+Pg0KPiA+Pj4gV2UgbmVlZCB0
byBrZWVwIHNvbWUgb2YgdGhlIHN0YXR1cyBmcm9tIHNoYXJlIG1lbW9yeShkcml2ZXIgYW5kIEZX
KSwNCj4gPj4gc2luY2Ugc29tZSBvZiB0aGVtIGFyZSBjaGFuZ2VkIGJ5IEZXLCB0aGF0IGlzIHdo
eSB0aGUgaW5pdCBjYW5ub3QgYmUNCj4gPj4gaW4gdGhlIGh3X2luaXQgc3RhZ2Ugd2l0aCBzdXNw
ZW5kL3Jlc3VtZSBjYXNlLg0KPiA+Pj4NCj4gPj4NCj4gPj4gRm9yIHZjbl92NF8wXzMsIHRoZSBm
bGFncyB0aGF0IGFyZSBpbml0aWFsaXplZCBpbiBzd19pbml0IGFyZSB0aGVzZQ0KPiA+Pg0KPiA+
PiAgICAgICAgICAgICAgICAgZndfc2hhcmVkLT5wcmVzZW50X2ZsYWdfMCA9DQo+ID4+IGNwdV90
b19sZTMyKEFNREdQVV9GV19TSEFSRURfRkxBR18wX1VOSUZJRURfUVVFVUUpOw0KPiA+PiAgICAg
ICAgICAgICAgICAgZndfc2hhcmVkLT5zcS5pc19lbmFibGVkID0gdHJ1ZTsNCj4gPj4NCj4gPj4g
ICAgICAgICAgICAgICAgIGlmIChhbWRncHVfdmNuZndfbG9nKQ0KPiA+PiAgICAgICAgICAgICAg
ICAgICAgICAgICBhbWRncHVfdmNuX2Z3bG9nX2luaXQoJmFkZXYtPnZjbi5pbnN0W2ldKTsNCj4g
Pj4NCj4gPj4gSXMgdGhlIGZsYWdzIGluaXRpYWxpemVkIGR1cmluZyBzd19pbml0IHJlcXVpcmVk
IGZvciBGVyBkdXJpbmcgaXRzDQo+ID4+IGluaXRpYWxpemF0aW9uIHN0YWdlPyBJZiBub3QsIGl0
IHdvdWxkIGJlIGJldHRlciB0byBtb3ZlIHRoaXMgdG8gaHdfaW5pdC4NCj4gPj4NCj4gPj4gU29t
ZSBwYXJ0IGFsc28gZ2V0IG1vZGlmaWVkIGR1cmluZyB2Y25fdjRfMF8zX3N0YXJ0ICh3aGljaCBp
cyBhZnRlcg0KPiA+PiBod19pbml0IGR1cmluZyBydW50aW1lKSAtDQo+ID4+DQo+ID4+ICAgICAg
ICAgICAgICAgICBmd19zaGFyZWQtPnNxLnF1ZXVlX21vZGUgJj0NCj4gPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgY3B1X3RvX2xlMzIofihGV19RVUVVRV9SSU5HX1JFU0VUIHwNCj4gPj4gRldf
UVVFVUVfRFBHX0hPTERfT0ZGKSk7DQo+ID4+DQo+ID4+DQo+ID4+IE9uZSByZWFzb24gcHJvYmFi
bHkgaXMgaHdfaW5pdCBpcyBhbHNvIGNhbGxlZCBkdXJpbmcgcmVzdW1lIHdoaWNoDQo+ID4+IHJl
c3RvcmVzIHRoZSBzYXZlZCBibyBkdXJpbmcgc3VzcGVuZC4gU28gdGhpcyBtYXkgYmUgdG8gYXZv
aWQgdGhlIGRvdWJsZQ0KPiB3b3JrLg0KPiA+Pg0KPiA+PiBBbnl3YXksIGlzIHRoZSBwYXRjaCBv
a2F5IHRvIGdvPw0KPiA+Pg0KPiA+IFlvdSBuZWVkIHRvIGZpeCB0aGUgZnVuY3Rpb24gbmFtZSBh
cyBJIGNvbW1lbnRlZCBmcm9tIGxhc3QgZW1haWwuDQo+ID4NCj4NCj4gQW55IHN1Z2dlc3Rpb25z
IC0gYW1kZ3B1X3Zjbl9zYXZlX3ZjcHVfYnVmZmVyL2JvPw0KPg0KImFtZGdwdV92Y25fc2F2ZV92
Y3B1X2JvIiBzaG91bGQgYmUgZ29vZC4NCg0KTGVvDQoNCj4gVGhhbmtzLA0KPiBMaWpvDQo+DQo+
ID4gUmVnYXJkcywNCj4gPiBMZW8NCj4gPg0KPiA+DQo+ID4+IFRoYW5rcywNCj4gPj4gTGlqbw0K
PiA+Pg0KPiA+Pj4gICtpbnQgYW1kZ3B1X3Zjbl9zdXNwZW5kKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KSB7DQo+ID4+PiAgPiArICAgIGJvb2wgaW5fcmFzX2ludHIgPSBhbWRncHVfcmFzX2lu
dHJfdHJpZ2dlcmVkKCk7DQo+ID4+PiAgPiArDQo+ID4+PiAgPiArICAgIGNhbmNlbF9kZWxheWVk
X3dvcmtfc3luYygmYWRldi0+dmNuLmlkbGVfd29yayk7DQo+ID4+PiAgPiArDQo+ID4+PiAgPiAr
ICAgIC8qIGVycl9ldmVudF9hdGh1YiB3aWxsIGNvcnJ1cHQgVkNQVSBidWZmZXIsIHNvIHdlIG5l
ZWQgdG8NCj4gPj4+ICA+ICsgICAgICogcmVzdG9yZSBmdyBkYXRhIGFuZCBjbGVhciBidWZmZXIg
aW4gYW1kZ3B1X3Zjbl9yZXN1bWUoKSAqLw0KPiA+Pj4gID4gKyAgICBpZiAoaW5fcmFzX2ludHIp
DQo+ID4+PiAgPiArICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4+PiAgPiArDQo+ID4+PiAgPiAr
ICAgIHJldHVybiBhbWRncHVfdmNuX3NhdmVfZndfc2hhcmVkX3JlZ2lvbihhZGV2KTsNCj4gPj4+
IFRoZSBzYXZlZCBibyBoZXJlIGlzIG5vdCBvbmx5IGZvciBmdyBzaGFyZWQgbWVtb3J5LCBhbHNv
IGZvciBGVw0KPiA+Pj4gcnVudGltZQ0KPiA+PiBzdGFjay9oZWFwIGFzIHdlbGwuDQo+ID4+Pj4g
UmVnYXJkcywNCj4gPj4+IExlbw0KPiA+Pj4NCj4gPj4+ICA+ICt9DQo+ID4+PiAgPiArDQo=
