Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76830C47BC8
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 08:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE86C10E3EC;
	Tue,  6 Jan 2026 08:51:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E8s0ynlp";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013023.outbound.protection.outlook.com
 [40.93.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A97010E3EC
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 08:51:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYfjPW2ZPaiN/T+Eoj0vepHV9HMUQ7yEcjg5Nyhr/RGQFwOEgK2A4A4tCgvGzP94AuZizCS4Zx/8MkmpHarLCmOrXaZLy/zYiFyIJLrM27iwpvgn6B6BdLNMYrtRFLhV0tMB2+hgIWBozlI6x2ldWfVZ9jG0lAjef4H5d1MPicUAQJwszUj68CEMiv06D6VdsKx863RB4PgRpLv3OKK1iT/Pvtuant92Fbse/0VsaFRMZ1+OqNOv45kycYjwHh34i5G8KlezYIHvlW/ksbUiRde2ByBlby9GVGidLvCaYcy3pzYBYzf3vOLohnkpnvbVNFYNpG5RA5PPMhBK8Qo7dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yHqb44xDnX7G7LBtTfSdl501ijQRTNVR2d7cKD22fo=;
 b=W0v3AGJ8ZmNt7Vyw2M8WuLgDcBMlY01Dqomd/cwg0BJ+EBCZR4JqXs9cHyj4b504zYBNSYTCTCTKhTqC9K8cO78EtZB9wCF2i1SzEfLBy6kFrCNitFs8MMPXK4/HSJqz2+QcNsncYEOzEVl/0/XHfRaVhq3Qqe5MPzhsENud3ZbPrMU9jzsn9PtEBGZa4QLm8OfnnhVTpV2W6zSZw4DlL6wxegUsZjGgkyH2/5GDhmcZbFKI2SRKsldc2gCQWCJGet/CcpC2DVoC9r8TvXl32VQ7WQdItKgzpgsTuMNwbfzlZ1VxQ/v4GdEGGVNwr5ZaYzZh5fFfzV60V9Fe6GQGMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yHqb44xDnX7G7LBtTfSdl501ijQRTNVR2d7cKD22fo=;
 b=E8s0ynlp6xypE+xBSvJgxgD4XVjZIY4QiA9o5toqE2VYpH230ZdsMR4cIV/5q0A48bBrlaUer9+RhbA2jfRH96yQqKrJGqlIH7Og9Ys3RWO8nDUl6j/DjcGLy0FLCPG832oVEZuYnfuk1sfLqAn4y3JtZNAlu9ZBOwFHAzShCRM=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DS4PR12MB999101.namprd12.prod.outlook.com (2603:10b6:8:2fb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 6 Jan
 2026 08:51:37 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%6]) with mapi id 15.20.9499.002; Tue, 6 Jan 2026
 08:51:37 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, Jean Philippe EIMER
 <phil@jpmr.org>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Skip TLB flush for devices predating the SI
 series
Thread-Topic: [PATCH] drm/amdgpu: Skip TLB flush for devices predating the SI
 series
Thread-Index: AQHceGrxY3pv+IOQ4kSzjq6Ot3v2Z7U4YRAAgAEEgsCAAOUgAIAKlXPg
Date: Tue, 6 Jan 2026 08:51:37 +0000
Message-ID: <DS7PR12MB6005D76668B338B16D68C0A1FB87A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20251229022909.777645-1-Prike.Liang@amd.com>
 <e5967879-9d64-468e-ac85-e0dfb5136d45@jpmr.org>
 <DS7PR12MB6005B8971C288DFBA90C85D9FBBCA@DS7PR12MB6005.namprd12.prod.outlook.com>
 <585583fc-ab78-46fb-a1f7-8dd2dfe791a0@amd.com>
In-Reply-To: <585583fc-ab78-46fb-a1f7-8dd2dfe791a0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-06T08:44:27.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DS4PR12MB999101:EE_
x-ms-office365-filtering-correlation-id: 9cd7df04-0c82-4c3f-e1b9-08de4d00cd75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?eWMxRHlJWFpMaE5UR0RVck9GZGI3TEVrOUxacmdtVXZDQ1I1MDhaUW1WOGhE?=
 =?utf-8?B?a01DMit3bktaQnhNbFFTQklmcU9wU29seDY3aFliV2dBU0YybDFrODVGb1ov?=
 =?utf-8?B?RlIxaWtaOWM3cDVDNGhSZGlmaHZVYjYyQUVXZVJqRk50czRleW5wcWVIeG11?=
 =?utf-8?B?T1owRFJmNXQ1ZnhoVHpIZ1pkcDlxQjdnLzVDbXdVNEgrZWthYk9BREZVdHZV?=
 =?utf-8?B?UmNLbnUzeVJzTW1Db2FzVm5IcTJ4WUFZR29PdHpTM1hCcXZ6Zk5lNXZzeS96?=
 =?utf-8?B?dVk0bnhLdC9hWHlmTlZLcXBXYUNWSXlPbmdzK1NTblptSXM0Q29LZHFJQlZL?=
 =?utf-8?B?RlJ6YzNiYkR3WU9ZLytuZ0VIK29GTkxlUlUxTER3Si9VQnJWMzYxUGpGeGtz?=
 =?utf-8?B?cDcwR3kwWlg2bVVCWHdyaWVBNkx5SS9HWlk0c29VOFpCaXd5WHVoby8wRGR1?=
 =?utf-8?B?WTBXTDBUYlo2MEtLa2IyV2pwbW1UZ0RneUxBaG5aZTBpcitNNGpkZXpqTm9I?=
 =?utf-8?B?SUMrOG9RRnZzcXVpVTlvYSsvd2NkTjdabGxadXdKN2JYcml4VlU0SVJ0OW11?=
 =?utf-8?B?VUJuc3FyNmxGT1c3akc3Rnl1ZVhkRkxsOE5tVGRFc2FzT0J0aFNnUjQ3YVhS?=
 =?utf-8?B?NVZNNW4xaEpFRHF3OFdRREM1QWNpRm5nNnFHSjVEMFZnc3JCRFVPdmZxVEd6?=
 =?utf-8?B?am53aUNjQ09vUm1zMnhUVW12eXJxdERveDVHbEFBNC9XZmE5NjM2MWJ4SVYr?=
 =?utf-8?B?KzMvTzJ6Wk5uVmxvdEZpQWw2emd3SFhSOCtldUs3TDd1TDYwZGdsMkEvb3JD?=
 =?utf-8?B?d042QzFpK3lCSkd4a2VpSitOOTk0VWFzYWl6YW1tV2xraUl1Y2M1eGJLSlZq?=
 =?utf-8?B?MXV3SDRUbkxFSTFEalc4NnBrTnVMNDd1dTcrSmc0TmpWZUkvTmNyeGlLSWtl?=
 =?utf-8?B?YzZFL25EZFlQcmUvVzhTTG5BM1c0N2dOK2Z1OHlYbXdsMUljNXFZUjJacjRr?=
 =?utf-8?B?elh2YU5GMCtJM043VS9nZzBxd0tRV0lCdXpIN3o3dE1vSHUydHl1eFhNSHlv?=
 =?utf-8?B?ZlBDdlZDcTlwdDlnVmZlUkNxTjk1MkdTUVMvbXRYaHJlSVBHTWdtOTUxM3F0?=
 =?utf-8?B?NnRveVFYQlhTK0U3TzBlK2lrMGY3dFk4U1Q2cEt1dHArQ3FzUkJiS2RtbHdF?=
 =?utf-8?B?VWxkZk5CdVphOUM0UUxFZXVSUHBkbzdwemVSN1lmaXluQUx2K2xxY0t5T1dM?=
 =?utf-8?B?a24wemYzM2lObFZMa3orcjJnMlVCeUw4NmVaNC9VM1N0MDZ1MWwwVEpldUUy?=
 =?utf-8?B?VjhTSVkzZUt6Qk1NWXlxRVBFbDBPd1E0ZTlYYkJ1bnNQTmI4TDhhUy9tclJj?=
 =?utf-8?B?cjM5NldtVHhaYmxBVmpBVGY1VVYzWlZJQ0R1M09kUGY1bEFyQ3A5OGJ2WGcz?=
 =?utf-8?B?Ymx0SWk2d3QySlpGOFRYSnEzOEJTQVZKMmhlSHJCQ1RrM2FLY2lBQ0VZVndz?=
 =?utf-8?B?ZHJaWS8ybTdramxjNEc2Nm1Ca1pMdTNFcmVWM3ZGZUpYS3NTVDNGalVNSnBX?=
 =?utf-8?B?N0VJOVpsS09MbTBEa1JWTWttd0JmRkMwRW9HazdLVHR0c3BWbVpsTElQVS85?=
 =?utf-8?B?dnhoQnhQMnRWZWUyNWVzbnNCNnl4U0NTNFROM05SV2hkR1FXUWhBYWZRS1NV?=
 =?utf-8?B?MURKTzg5MCtXSzVrUjZJaE1Lam5ES2NWeVRuYTZnTnpLUGVsZHhuL0ZkUzkr?=
 =?utf-8?B?U1QyOWFEU2g3M0UrUy94ZnpnVDBiWFNkK3VHc2VmTm84aEp3Wks1L0FLMlEw?=
 =?utf-8?B?VjJkcnhJSzk2TzZTcC84cHdXbG1ad2pYRXF3VDBFSmxqeTNDdHdVUkUrSjk1?=
 =?utf-8?B?K1pGQndVWU91TVowMzNUTkVyKzRjb1lLV1c1ejkvbjFFdmNmWHN1Mk9KdUJS?=
 =?utf-8?B?U0h0dVBMQUU5UzVkbmFSRzVlRnBkWVJHRXlNTHdQMUpxRHhhTTRLbzJSb2lC?=
 =?utf-8?B?YjNXczZ5V09GY3JUT0tjcWFzajZwV0gxTlRqMWxXYU54aTJrWUE2dzRpUWR4?=
 =?utf-8?Q?nT80UK?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qk9DSy9WM05ZZGJsSVdDZzQ1Y3pseUZrLzRyY2FYbHFiMnV5ditPNm45SnI2?=
 =?utf-8?B?dXIrQWhhTlRFVWdUOEVJTmR1L2ZEaVRIYUYxWitwY09JNGhnMjF2dllVa3Rw?=
 =?utf-8?B?eGlGdzZkQTB1eDBTOWtRV0xTZjlVTHRnOHlOOSsrZU95UGJhdEJYSjFyTUV3?=
 =?utf-8?B?MEZiaHgzcmFXYjNXYlo4dTk1ZzlIdW5qbUlVNHJ5RnRHL003ZVVQM0NvUHZV?=
 =?utf-8?B?aXNwaGlIcVZINlBJRHVKdUticEZHSExmMkpua1FobENHK1Q2d1pTYkdvb2dP?=
 =?utf-8?B?TDN5OXcxd1h6UElkUnZFMi9vMHUreG1SbHhva2lMdVoxZ29tSkVyZk9SZEMx?=
 =?utf-8?B?a1Ayc0ZZaXplK2s5OW9SbkkxRVlwZjRmOGt1TkMzM1ZXaWhacExNUlJWY25F?=
 =?utf-8?B?TzU0MTJFWVkyQmFGVHNHeU1OempNMnBuR2tqVERBUWF1alE1OWp0ZUZQWVdl?=
 =?utf-8?B?VkkvcTRNaXlhRkY2NDVXVytoREZUZ28xMzRJWjhIWEZIMEdHWnVxMWZJMWVp?=
 =?utf-8?B?SHJWMGJlRmwzR2thdlU4eG1iQmcyOXRDT1hwdm44T3lLWTREdVB4M2RnMDli?=
 =?utf-8?B?VlJ3VFNDK1pLT1Q5U3czUWRsOWhPTmJHY2IyTEpQMG1hZnIySnlsQ3JHRlpm?=
 =?utf-8?B?bURVOGdVZ0pTb0Zsb2ZOeDFPdm05enRieGNEb2lVVXpVcFdqUGw1UXIxczI3?=
 =?utf-8?B?d3pRUHVkT2VCZ3FCY3hKblRCTlRxbTFLOVBDbjl2cFhha2JOQk0xVUEvUFdV?=
 =?utf-8?B?VExRejBveG5tU08zaXJoSEdpMnpNL2k1bVhDeWlSdk1jRFY0WkQxUVV1VFU2?=
 =?utf-8?B?a01TZS9wVHoramZwZmxpekpEREVyTmpTWkNZL1pwQWJYSHIyNGZGdUpVNjRp?=
 =?utf-8?B?SXJlVGhRMFVRUnlVVGdKak9oK3FHL0F4VFNmMS9GSmpsWGtuL0FpalpoQUti?=
 =?utf-8?B?UnpSRFBKd3ZvQmtHMnFWd0trQ3A2SlFQYllrZUdaYXQzWmpZMmE5Ynlwa0RN?=
 =?utf-8?B?elpveTExSGYvbWlyRlV2b3JJY2ZlL01za0ZrZytQUHFqVkoyaDVUOWtSWm4x?=
 =?utf-8?B?YlUzeFZkRng3VlU2UTNQZDJvOFE5VFk1S0hkNGFkaDN0c1d6S2w1NXNQNzg3?=
 =?utf-8?B?NEV3MC9jaWpvVWIwRXNETW55R3FyT0R3VFo4bmZsVHZhNXVFSWFIWjB5SUZ5?=
 =?utf-8?B?Zk5tYThUQWlkMlhmVVVRQ0VvYzM0UmdXZDlWMDVKeDJneGRrOGptMitxZ0g4?=
 =?utf-8?B?M3pXMlA0UzhCejNiMWFsZ2w2OVpQaVRHYXNYa0p6bEU5Qk9NRmFMWXJLSXVl?=
 =?utf-8?B?VzdHMjc3NmdLbTFkSmUyT3c4ell1ckFxckdQK1dwTDRMNUx6bzIxTU9DSnc1?=
 =?utf-8?B?RjRqQnlMeVBxcnQzSUo4SUdmMXkwL2FvVlFjWjE2SzNSUzY1UWN4djA0NWdi?=
 =?utf-8?B?UmpDcWNMZ0I4QkJtcnR1V04zcWh4UUl1Z1VXdk51S1RIaFV2UFYrK04wQ2VF?=
 =?utf-8?B?cDRFT3pJUHQvdzJxbmdZb0JXQkFISW90MkkzMzc4b0dhc2lyRmhrZ0FFZm51?=
 =?utf-8?B?eHlnelpWcmpGTEcrTlEvdnJuYjV3aVR6MGN0Tlp5T3MxbWUxTVZISnozaDR0?=
 =?utf-8?B?MlpQNDFCc1JEcjlkWFJadVNRN2J2cElLWitSaGxVRitrU2dtdFRtTEh3Q2hL?=
 =?utf-8?B?QUR2cHpmQ2JUWmJ6TWR1VjIwU0dYS3ZIclBwMUVhZERLandqaWs4Tk91aHZz?=
 =?utf-8?B?WUtkMVExSkZSTEZDbzFBNnRsRFZwbml3TXdjK3J1L0xQY0VHUC90VmxBSTNG?=
 =?utf-8?B?TXg0WTE3TktxUTZhampYT1pNbWxrbGxjRDJsbnlJTmtUTWc2UEg0VW1MRFp1?=
 =?utf-8?B?cy9mbUhoRytFdzV5MVFLTHJ3SlZ0azJGU2JMQjRFdHVMN3VUbmczWnhEdHFP?=
 =?utf-8?B?cStuV2l1K3QwQkRBd3ZVWkZuc3pDWGZvVjRta2xjWG1kRGhRc3hweEEyK0Zm?=
 =?utf-8?B?MkVYc1ZNd0ZKMi93OFV2bjZIVktiTG5zUVhNTkdUYjRsZVZzdE9lZkd0Ym82?=
 =?utf-8?B?WnM3dXdBcEJWNzhTYTlYcllkMVN2R0tuSW15ekJTejVhRDBpcDBaTHNEUFRl?=
 =?utf-8?B?MVNhS1Q4VnpoNVRkbU9kNlM4SzlORkNmV2hNV0NaeHc0aFdQdUtiMUhMYWhi?=
 =?utf-8?B?d0xjc2wxMEdCZVdHanplN0RxNGY4ZHNlTU5teXhLQjNtVHpSTkdZaHdyRHI3?=
 =?utf-8?B?TE9hSlo1Z045TW4zR2t4RFp6bzRKd2pEd2tIQlhkNTFIbG11OFdlMHUvc29U?=
 =?utf-8?Q?7TSfs7OI+KdidzMZQp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd7df04-0c82-4c3f-e1b9-08de4d00cd75
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 08:51:37.5108 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bfvSoYlilSP3b1eASaAhoC49DB9Llt6bCCoh8aRInC+R09DXbDdqS6XIVpmmFprj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999101
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

W1B1YmxpY10NCg0KWWVzLCB0aGUgcGF0Y2ggaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
YXJjaGl2ZXMvYW1kLWdmeC8yMDI1LURlY2VtYmVyLzEzNDkzMy5odG1sIGNhbiBmaXggdGhpcyBp
c3N1ZS4NCg0KVGhpbmtpbmcgYWJvdXQgaXQgbW9yZSwgaGFuZGxpbmcgVk0gZmx1c2hlcyBwZXIt
QVNJQyBtYXkgYmUgdW5uZWNlc3NhcnkuIEluc3RlYWQsIHdlIGNhbiBkZXRlcm1pbmUgVExCIGZs
dXNoIHN1cHBvcnQgYnkgY2hlY2tpbmcgZm9yIHRoZSBmbHVzaF9ncHVfdGxiX3Bhc2lkIGNhbGxi
YWNrIGluc2lkZSBhbWRncHVfZ21jX2ZsdXNoX2dwdV90bGJfcGFzaWQoKS4NCg0KUmVnYXJkcywN
CiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS29l
bmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NCj4gU2VudDogVHVlc2Rh
eSwgRGVjZW1iZXIgMzAsIDIwMjUgMTE6MDYgUE0NCj4gVG86IExpYW5nLCBQcmlrZSA8UHJpa2Uu
TGlhbmdAYW1kLmNvbT47IEplYW4gUGhpbGlwcGUgRUlNRVIgPHBoaWxAanBtci5vcmc+Ow0KPiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxB
bGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1k
Z3B1OiBTa2lwIFRMQiBmbHVzaCBmb3IgZGV2aWNlcyBwcmVkYXRpbmcgdGhlIFNJDQo+IHNlcmll
cw0KPg0KPiBJIG5lZWQgdG8gZG91YmxlIGNoZWNrLCBidXQgSSB0aGluayBBbGV4IGFscmVhZHkg
Zml4ZWQgdGhhdC4NCj4NCj4gQnV0IGZpeGluZyB0aGF0IGNhbiB3YWl0IHRpbGwgYWZ0ZXIgdGhl
IGhvbGlkYXlzLg0KPg0KPiBSZWdhcmRzLA0KPiBDaHJpc3RpYW4uDQo+DQo+IE9uIDEyLzMwLzI1
IDAyOjI2LCBMaWFuZywgUHJpa2Ugd3JvdGU6DQo+ID4gW1B1YmxpY10NCj4gPg0KPiA+IFRoYW5r
IHlvdSBmb3IgdGhlIGZlZWRiYWNrLCBJIHdpbGwgcmV3b3JrIHRoZSBwYXRjaCBhIGJpdCBhbmQg
c2VuZCBpdCBmb3IgdGhlIHRlc3QuDQo+ID4NCj4gPiBSZWdhcmRzLA0KPiA+ICAgICAgIFByaWtl
DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogSmVhbiBQ
aGlsaXBwZSBFSU1FUiA8cGhpbEBqcG1yLm9yZz4NCj4gPj4gU2VudDogTW9uZGF5LCBEZWNlbWJl
ciAyOSwgMjAyNSA1OjUzIFBNDQo+ID4+IFRvOiBMaWFuZywgUHJpa2UgPFByaWtlLkxpYW5nQGFt
ZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+PiBDYzogRGV1Y2hlciwg
QWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4N
Cj4gPj4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRD
SF0gZHJtL2FtZGdwdTogU2tpcCBUTEIgZmx1c2ggZm9yIGRldmljZXMgcHJlZGF0aW5nDQo+ID4+
IHRoZSBTSSBzZXJpZXMNCj4gPj4NCj4gPj4gVW5mb3J0dW5hdGVseSB0aGlzIHBhdGNoIGRvZXNu
J3Qgc29sdmUgdGhlIGhhbmcgSSByZXBvcnRlZC4NCj4gPj4NCj4gPj4gUGxlYXNlIGZpbmQgYXR0
YWNoZWQgMiBsb2dzIG9idGFpbmVkIHdpdGggdGhlIHBhdGNoIGFwcGxpZWQsIG9uZSBvZg0KPiA+
PiB0aGVtIGJlaW5nIGZyb20gYSBkZWJ1ZyBzZXJpYWwgY29uc29sZS4NCj4gPj4NCj4gPj4NCj4g
Pj4gTGUgMjkvMTIvMjAyNSDDoCAwMzoyOSwgUHJpa2UgTGlhbmcgYSDDqWNyaXQgOg0KPiA+Pj4g
U0kgZG9lcyBub3Qgc3VwcG9ydCBQQVNJRCBvciBLSVEvTUVTLCBzbyB0aGVyZSBpcyBubyB2YWxp
ZCBUTEIgZmVuY2UNCj4gPj4+IGVudGl0eSBhdmFpbGFibGUgdG8gcGVyZm9ybSB0aGUgVExCIGZs
dXNoLiBXaXRob3V0IGEgZmFsbGJhY2sNCj4gPj4+IHJldHVybiwgdGhpcyB3aWxsIHJlc3VsdCBp
biBhIE5VTEwgcG9pbnRlciBpc3N1ZSBkdWUgdG8gdGhlIGludmFsaWQNCj4gPj4+IFRMQiBmbHVz
aCBkZXZpY2UgZW50aXR5DQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogUHJpa2UgTGlhbmcg
PFByaWtlLkxpYW5nQGFtZC5jb20+DQo+ID4+PiBSZXBvcnRlZC1ieTogSmVhbiBQaGlsaXBwZSBF
SU1FUiA8cGhpbEBqcG1yLm9yZz4NCj4gPj4+IC0tLQ0KPiA+Pj4gICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZ21jLmMgfCA2ICsrKysrKw0KPiA+Pj4gICAxIGZpbGUgY2hhbmdl
ZCwgNiBpbnNlcnRpb25zKCspDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYw0KPiA+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9nbWMuYw0KPiA+Pj4gaW5kZXggY2Q0YWNjNmFkYzllLi45NjVhZTAyMjMy
ZTAgMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Z21jLmMNCj4gPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMu
Yw0KPiA+Pj4gQEAgLTc3Miw2ICs3NzIsMTIgQEAgaW50IGFtZGdwdV9nbWNfZmx1c2hfZ3B1X3Rs
Yl9wYXNpZChzdHJ1Y3QNCj4gPj4gYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDE2X3QgcGFzaWQs
DQo+ID4+PiAgICAgaW50IHIsIGNudCA9IDA7DQo+ID4+PiAgICAgdWludDMyX3Qgc2VxOw0KPiA+
Pj4NCj4gPj4+ICsgICAvKiBTSSBkb2VzIG5vdCBzdXBwb3J0IFBBU0lEIG9yIEtJUS9NRVMsIGFu
ZCB0aGVyZSBpcyBubyB2YWxpZA0KPiA+Pj4gKyAgICAqIFRMQiBmZW5jZSBlbnRpdHkgYXZhaWxh
YmxlIHRvIHBlcmZvcm0gdGhlIFRMQiBmbHVzaC4NCj4gPj4+ICsgICAgKi8NCj4gPj4+ICsgICBp
ZighYWRldikNCj4gPj4+ICsgICAgICAgICAgIHJldHVybiAwOw0KPiA+Pj4gKw0KPiA+Pj4gICAg
IC8qDQo+ID4+PiAgICAgICogQSBHUFUgcmVzZXQgc2hvdWxkIGZsdXNoIGFsbCBUTEJzIGFueXdh
eSwgc28gbm8gbmVlZCB0byBkbw0KPiA+Pj4gICAgICAqIHRoaXMgd2hpbGUgb25lIGlzIG9uZ29p
bmcuDQoNCg==
