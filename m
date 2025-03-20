Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A53C28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 12:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9350110E605;
	Thu, 20 Mar 2025 12:14:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V7+BYwxI";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AD6610E605
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 12:14:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bf+kTnrP2Sxtg3OQxCEZzwheDynRX7+9YW6XWwSH+A6rJL0hYrFueedobggm2Hl/JZYDgIptLB23vFqVMpfXw5FOhQ4MpJ75/FkTQXOxme2OOcIyXog05PI9YH4doekDj5BSUv/kHAqFdM237iNtdmJg5MdTBW5D5klGVAKpLK4WczQotRbc+KioxzIpYyWcAwHryPIiY7pU8zA/VukjfiCKQ8pPu9w3Zt2amAXAlaPFLWZfnqTLThgPaeYaNyBdwRss4ft90sX3H22nD235g3WiHjAIJ+MfTtXKXEz4AhSDt3em0W9ZoEg4uyf24TkMAPtcAdZGUCDVbGplktzvbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8N+bAMfTxCNJbAen11U3SynBWAp3cvKIGKZmKSo0FXU=;
 b=UKMWQJc5NtNKZ7NQ/BZRDo1gFZEm2qERysbbBRnN4unZESW0B0faEbGmgIpEa00/B6M8DNimdT4TONEG1cp6C0mN2WlCIFt/Xc9Be7sBvMcO33MF06G0ZCrNSrYcbvtv1y+kuPHLupGjulcEGGiFyD3f2YjpHrpOaauXT9yh0J3nCZ20o/J1cTF+w27XO32J432SQIMau9mRlQ9h+JiGSNtC+2SGuyP4i1izHcm6iS0rJcBzaoCJhwgUvayann9rW+L5+Y25zKLvlt3ywZTO7NiOagMC1rAEabWEoSU/1cnDjWRpuEnTmhR1Z5S1M9ZfywfNJ3sFV5gmC22qin0/Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8N+bAMfTxCNJbAen11U3SynBWAp3cvKIGKZmKSo0FXU=;
 b=V7+BYwxIe0tE3AadXvuKxYkjOC1sFEcQjcASM6eOl0fP9Ox28LSPWorXZqIhS/4cYr7AKRSMwHk3C1j+YiEms5ff4zDEVys29GUMvDOmgtGk5TADXVhEfUQ6XWqE6yRJB6rmf5avheM/HOdVrZyTe4aC90iI96b9UGyBxwVotyk=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 PH7PR12MB6834.namprd12.prod.outlook.com (2603:10b6:510:1b4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 12:13:57 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 12:13:57 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Subject: RE: [PATCH 1/4] drm/amdgpu/mes: optimize compute loop handling
Thread-Topic: [PATCH 1/4] drm/amdgpu/mes: optimize compute loop handling
Thread-Index: AQHbmQJsamM4FgkSRkGX+LYQv+vO+LN74F+AgAAO7UA=
Date: Thu, 20 Mar 2025 12:13:56 +0000
Message-ID: <DS7PR12MB6005CDA1102F3D0280C7CDA6FBD82@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250319190850.3899718-1-alexander.deucher@amd.com>
 <d2af32a9-f7e7-4530-93b0-c5d015e41c5e@amd.com>
In-Reply-To: <d2af32a9-f7e7-4530-93b0-c5d015e41c5e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=5d921688-17a9-4da3-84d5-875652311e15;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-20T12:07:42Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|PH7PR12MB6834:EE_
x-ms-office365-filtering-correlation-id: acf265e8-00b3-4e9d-0b34-08dd67a8b07e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M045TElPWDNKT2FzeWxRR3hFTTdSK0t4RHcyNVVkSXowNkIyVmZ2RGNzNGlK?=
 =?utf-8?B?VUcvaGRNT1JoUm9wNFZWSmI4VWc0bmZnVjNLM3ZobEV4WEd5Z3hUWFRWM1ZL?=
 =?utf-8?B?RlorVi9ia1BuM3Y2aXN2S3FIb1JVcFh3ejIzZWdGTlBTZ24zZFA5ZUszVERa?=
 =?utf-8?B?WkdjSkMrUW85VW5NWUR1SW53Z1hyRVRjVmRaSEtUR0xIN080ZVEvdnNSSlBz?=
 =?utf-8?B?UGhLWktwWmtGL2RMWHN4OHB3YlNvK0IvQStMbUpuQ0RWRktMQlBFWjZEWTQ2?=
 =?utf-8?B?WE94YzlSZTlpR0JCQ1cxdHRrWWJ1WjBRYk4yMTNWUkQyMy9tTkx5ME1NSTRn?=
 =?utf-8?B?T0piaFV0L2lHS2JxR2psOUtsc0RSMld0a1lheDFXaVNhMDdMamg2djQxK3JR?=
 =?utf-8?B?eXFkZ3hJK0tOTS9hcDl1U3VXQjlhUXN1U2NpZTNnTThZTmRMdEhhaGxCaDVp?=
 =?utf-8?B?cGdXN3VjWmhxZEF0REZYdHBKU1Q0YUx1NHU4RGZVaHBmeHVLYjlmMkErdity?=
 =?utf-8?B?NjlrbmNHLzh5QU10eWRuMXkrMzhVR1oyZjVDRjI5bGdGY0hhVDhhWklDeXVF?=
 =?utf-8?B?Mll4TW1RT0dmbjVwc3g0QWNsN3BHb3BSVGsrL3hZYnNSS2dMV1gvYStkL3Bu?=
 =?utf-8?B?MTZoM0tQeEpBOGUwL1JkTjJMR3N0eE9UT3U2RkxFclBuU1JjcmtYcisyb0Fx?=
 =?utf-8?B?OXBmd05rM2xJNmd1bTBndGpoV1ByVTVKWnQvWVlKRlV2NHR4OFl3TjhRb3Rt?=
 =?utf-8?B?cWx0ajJTcWdBUFZ5Qnp2K0JTNzJzSXd1a3UyNTR2SDBTcDA2Zkx4dEI3R2Vy?=
 =?utf-8?B?RHU4UTZnNDB5K0xQK0xCZjFLZ3laSDAzRmhqZHBRUmpDREljam01TkVmSDM3?=
 =?utf-8?B?RzVUUFViTzk1VHFrN0dyQWhKUzFCUVFVSHh0WFgwQ2U1em5ETnBPTDhlWmJ0?=
 =?utf-8?B?M1hHVm12eU1RcHUrQUJSQWdQUFhXc013T0ExNDRrdG1zWEFjRTI5SW1wT09h?=
 =?utf-8?B?WFk1WjF0RUF2azhSZ0t2WHI3YzBFWXlxUStSeUkwUFdqdi8zSVZSaXU2ZVJL?=
 =?utf-8?B?N1dCbjdZanFmdzFXbVEzNEpHL0RscXp3YVYydlIwTEhrQmRTSWtKNTBwRmV0?=
 =?utf-8?B?cWJuMERJTGswdk9BMkZWdHJybnE2TVkzRzJPTjc5ZW1oL09qTTVQMGxkZU4x?=
 =?utf-8?B?bGkrSGp3T3J2SGIwYzc3Wmo3VVYrTXVubTRYSEZlOGZsU2Q2UXQ0RDY2WFBh?=
 =?utf-8?B?Nng4WlAzU2gyOGQ1dTYwZWZiUk1MbjJZYnY2K3RVTmN2bGNhOU92VW50LzJX?=
 =?utf-8?B?RDNPUmRKUmpndE1qK2wvakpPU0F6ZHl2UkdESitIc1VRRENNTFdSdldpcHpM?=
 =?utf-8?B?bnJhTkJvQVhYN2dQZk9GaXVtWHFGWE9ySmQ5UFcyc2Zqak5ZVkhwQzlpc1E4?=
 =?utf-8?B?Vno3UVR2ZHdtcTNvbldjZlVyQzRPOWNYd04vK0tNYzFXc1VuUmFXWHYrSHAy?=
 =?utf-8?B?a2VHSy9kckh3dHJ2MVo0L0pZbnlFQy9vUXJqSjNqQ254N05ERC95NTZYSnBF?=
 =?utf-8?B?SDZlSU1jQzBMNTVaMlk2ZUhiR0h2Qnlzckh0ZUp2bVU2VXBaSldLTWFvTnpa?=
 =?utf-8?B?T3lHVVBVYUh5TEFvam9jaDdPRGFrc0NUV1hoM0VtTXFQTy8wWWt3RUdrbEwr?=
 =?utf-8?B?bThuVlFDUWxLd2ROMjVyR3FJdFViU3EvVGQrQzN5Mkkxc0xVOTJwWkRLbUpw?=
 =?utf-8?B?bzJHa0swLzFoQkdNZ1FBMlMvZ2FUMldTZEhCNkhVZE5JbGJHa0N0OUZybW1K?=
 =?utf-8?B?SXM5VUkwK0tJRGJPSHc1N3haaDdvQTdQc1NpZWorRG05SXFOdXJGM2phWElw?=
 =?utf-8?B?OHdLeUFpOXdTazZobnhVanRERnBKdlV2WkpvQUVaZTlOQjAzQXVtcWQva3Fo?=
 =?utf-8?Q?4CJt+3DNDZyrap8iC8xGcNDQ/4UbdWm2?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2wyMTVWUGw0ZE0vNmtnMXEvQUdCS2h5Y1VVV1VRREZvVFZMMTMva28rMzBr?=
 =?utf-8?B?MUU0TWU1ZDdaVUlZdTNUU1Q3Z09JdHo4UjFuWU0wV3VTa2NFbDJFYXJyMTkw?=
 =?utf-8?B?MWhjMllWRzdVVWhsZ1ZBTStvWWZGdE9KVVpKaCtTMjQrcG94OVNXVkdsWG5o?=
 =?utf-8?B?RVBWazArdXhyOEZQeXFQRzNJa1diOGd0NC9sbEVtRmhMK01SYnRwM2dsdFp6?=
 =?utf-8?B?dE1FZmk1Q3VFTjNKdFB6b0sxTklISGxyMnVFeEI4M3hBbkYyVW9vMUUwUGtO?=
 =?utf-8?B?NTZhL1ZCazB0bkg2aytKOUhhT3c1M0Q1aElTQnh0elROWGgrbExXWmVzR1Mx?=
 =?utf-8?B?K1RGZmg5TXlOdzg4aG0vdXQxLzZGTHpldW1ObDMzSVBZZVlSZ3R0SFlkMCtB?=
 =?utf-8?B?Nkd6SExEazA1VDNVUnltVVE3cW1DRXZUMzdGTFlra01rOEZ3T2o3Z0RrN1l0?=
 =?utf-8?B?NUVyblk5WkpkZktyMmF1MFp4SmRoekFFMXlTNlMxRTJEOERrSGswR2c2QjhM?=
 =?utf-8?B?azdvYnF3QmtyK2gyWU9YRU9pU0RCZ29nZUd6UlZGQUdaWktWNzVMalFXU0tk?=
 =?utf-8?B?WEMzNHExalVjMUNFa2lVMWxHaEFFRkl0Wk82Y3hqc2hrNmRMNmN5MWJzYWt5?=
 =?utf-8?B?dFhPRzJIeng0TnJEanc4blU2TG9ia2xhbVpoNCtFQmdCOHZzOXhXZWxCbzNk?=
 =?utf-8?B?T1Z1UWZRS2JHQVg5UDRWTDU0Mkw2cVZVME12Z0prck04SUFIcFJrWjdhZ3dy?=
 =?utf-8?B?dCtvMWQ5cWl3Q08zSnhRMm1KN2JWQmZ4M0VURGh6OGtVdzlueCtYOXRNc0l3?=
 =?utf-8?B?UGpQeE1FNVZScTFRblBSalJoeVFNRUZrMnRINDlFNk1xUXRYTTdSckE2RFcy?=
 =?utf-8?B?NVFRTU5GemZ0Z0J2My9pam12bm5xNzlBc1RUQmszandvZHRuQ3RVQ3I0NUgw?=
 =?utf-8?B?cHA5M2szOHd2UG5rbmJqRDZuRjFjSGFDSGlRY1VKcEVjYWdGSWx5aUQ4T0xq?=
 =?utf-8?B?ZE42RGJncWVBc3pRdFRFVElnMzU5UWRSV1lydmhXOXVkclpjYzdNMVZkSXdJ?=
 =?utf-8?B?dHg0cUJoNWd2dVNPZXlFcEVjTGVWZVlyTkE3WmxzS0FhTFhmQVdET1Exd0hT?=
 =?utf-8?B?YWFDemRiZ0g5K3N6L3FyZDdRVWFuNnp0Y0kvYlFUTWhYT2diQytzM0dicVdT?=
 =?utf-8?B?QmNLV0I2Y2Y1NkNtbEN1cXU1QlQvT0dOaVB3Wk1yaGhjMVlyQWFWV1o2emRu?=
 =?utf-8?B?QVNmKy9SSzJJU3dPc2c1Vk5ZelFEUEtiaUtrbTRoaW9JZG5DOXFtaThtN2FJ?=
 =?utf-8?B?ekRHWDlHQmVnR3NndXZqczhsQUlITWlnMXM0cTYyZmRoQjlaSTMvemx4bWlJ?=
 =?utf-8?B?cCt6UmJ0YXgrT3Rzb0pCUHYrREJaL0RkOU8raWdqSklBQ1Y2aFJ3b2xOWVAw?=
 =?utf-8?B?blV4WTJTZ3FnUWRkRTVyVW11SkRjTzI2QUtHY3VSbDNMa2lOVmcvRmovSHNa?=
 =?utf-8?B?ZkR2U05IbXZwTHZsZnU5eHBpRElxK25ZbnZlYTBNRUJ5UTl6WFR5Q0hIaEd2?=
 =?utf-8?B?RjhmK2pqMFZGa2ZUdDN5ZXRTUkxOOGhCQ2JFNmhaQVdySEZ5RmYxUk1HaDhs?=
 =?utf-8?B?anBiZmc4SVZyVzBUbXFKQjNneUVzV3hPcjVZZVdFejhOTHNiNkM3NW5aL0V0?=
 =?utf-8?B?S1lLRmloUnlaY2lVU2Mwa2FxNjVIb3NFWjlXSU5nLys5TkNiVzZaandJcjhB?=
 =?utf-8?B?WkQvbzV3SEJKTWxUYTI2SFczRTZHS1BGd041UWlYY25EWGlDZWlBb1FWQ25Q?=
 =?utf-8?B?Zmk2VlRKMnY5NUZrQ1pCa0hsMGlVdHhsRU1jNUdrdmZIa3EzS3hyd1cwaHRs?=
 =?utf-8?B?WDFESnNETk5zZVQycyt6VmpQVFhjWjBNZmtiWUExbUx1L29Nd1U0ZDI4RzRy?=
 =?utf-8?B?YjlzRXh5bWZQaU1nSDA2Zm42ZitnOG9BQUc4ODl3MzVzM0RKUDc4ZWg5Z25S?=
 =?utf-8?B?dEI5dlB5cDVJK3NWamEzZmYyYTlaT2E5M2crWHB2eGhkbXBwdkZQb3pEUUNJ?=
 =?utf-8?B?bGtqTXRCUTMzaFRvS1h2RUVsUGJBandOS0FNaGtqRXlzZUMyZjNKdnQwbEU3?=
 =?utf-8?Q?8R/U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acf265e8-00b3-4e9d-0b34-08dd67a8b07e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 12:13:56.9004 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QNzdq7SqVb65j3r+a1V/EgXzEVcOcUQ5PpGtIWclkZgEU+APcf9uECyV1o1ol3+M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6834
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

W1B1YmxpY10NCg0KPiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgTGF6YXIsDQo+IExpam8NCj4gU2VudDogVGh1cnNkYXks
IE1hcmNoIDIwLCAyMDI1IDc6MTQgUE0NCj4gVG86IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFu
ZGVyLkRldWNoZXJAYW1kLmNvbT47IGFtZC0NCj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K
PiBDYzogTGl1LCBTaGFveXVuIDxTaGFveXVuLkxpdUBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIDEvNF0gZHJtL2FtZGdwdS9tZXM6IG9wdGltaXplIGNvbXB1dGUgbG9vcCBoYW5kbGlu
Zw0KPg0KPg0KPg0KPiBPbiAzLzIwLzIwMjUgMTI6MzggQU0sIEFsZXggRGV1Y2hlciB3cm90ZToN
Cj4gPiBCcmVhayB3aGVuIHdlIGdldCB0byB0aGUgZW5kIG9mIHRoZSBzdXBwb3J0ZWQgcGlwZXMg
cmF0aGVyIHRoYW4NCj4gPiBjb250aW51aW5nIHRoZSBsb29wLg0KPiA+DQo+ID4gUmV2aWV3ZWQt
Ynk6IFNoYW95dW4ubGl1IDxTaGFveXVuLmxpdUBhbWQuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21lcy5jIHwgMiArLQ0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbWVzLmMNCj4gPiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tZXMuYw0KPiA+IGluZGV4IDNiODM4ODBm
OWUyY2MuLjEwZjE0YmY5MjU3NzggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X21lcy5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X21lcy5jDQo+ID4gQEAgLTEzMiw3ICsxMzIsNyBAQCBpbnQgYW1kZ3B1X21lc19p
bml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiA+ICAgICBmb3IgKGkgPSAwOyBpIDwg
QU1ER1BVX01FU19NQVhfQ09NUFVURV9QSVBFUzsgaSsrKSB7DQo+DQo+IFVubGVzcyBJJ20gbm90
IHNlZWluZyBzb21ldGhpbmcsIHdoeSBub3QganVzdCBrZWVwIGl0IGkgPA0KPiBhZGV2LT5nZngu
bWVjLm51bV9waXBlX3Blcl9tZWM/DQo+DQo+IFRoYW5rcywNCj4gTGlqbw0KPg0KVGhpcyBjaGVj
ayB3YXkgbWF5IGJlbmVmaXQgd2hlbiB0aGUgY2hlY2sgY2FzZSBpcyBhZGV2LT5nZngubWVjLm51
bV9waXBlX3Blcl9tZWMgPCBBTURHUFVfTUVTX01BWF9DT01QVVRFX1BJUEVTOyBpbiB0aGlzIHdh
eSBpdCB3aWxsIHJlZHVjZSB0aGUgbGF0ZXIgdW51c2VkIGxvb3AgY2hlY2suDQoNClRoYW5rcywN
ClByaWtlDQoNCj4gPiAgICAgICAgICAgICAvKiB1c2Ugb25seSAxc3QgTUVDIHBpcGVzICovDQo+
ID4gICAgICAgICAgICAgaWYgKGkgPj0gYWRldi0+Z2Z4Lm1lYy5udW1fcGlwZV9wZXJfbWVjKQ0K
PiA+IC0gICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+ID4gKyAgICAgICAgICAgICAgICAg
ICBicmVhazsNCj4gPiAgICAgICAgICAgICBhZGV2LT5tZXMuY29tcHV0ZV9ocWRfbWFza1tpXSA9
IDB4YzsNCj4gPiAgICAgfQ0KPiA+DQoNCg==
