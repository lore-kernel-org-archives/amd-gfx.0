Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA73C3ABCB
	for <amd-gfx@archiver.kernel.org>; Sun, 11 May 2025 23:52:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A27CF10E112;
	Sun, 11 May 2025 23:52:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FAiMh4qn";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ED6210E112
 for <amd-gfx@lists.freedesktop.org>; Sun, 11 May 2025 23:52:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDxOVE+4ewJATt9bz4HTSy57K5iR+oTXj8ErvrcXcMrXEhJ6afR1HNAGqo8PoHcy0yPz+mvNbe5rLuJFYORjctP+mXZ/Q2/DniUr6mip6ee/vil8cAfBDAdr3k3amBjw9DkKVSI2rmQyz+xLPtq8zl1tHdOjq5Ey3/PibRciHRz8sBBmk2jeoCUFbRbgr9CkTZe6/TIXgb3b2ASCS2Zb/wVuEQvfQRlZaUNffbEpQN/y4VVRB7dYowuAmb1Fm3XMB/RdqZmKPjJSc3M/lEi9D0y3569xrXkfz4ptuHbecZYPhBUUQXLV9QSWYTNvRoCODomm/Yk+Ju+dE+DGmrpi5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nn3P79uZ+FTQ+a7NYgzqNafS2hvAmCgnLHWdHAbOnbw=;
 b=WtQvdz9NIDDI6AM1f5P3Dj2wby5V3Hxiyz+OV+k/UrHU9XJbvSuqP5sY7a5cuiVPhne1OeeReJS+8fQM3txKvtytjYN4fWP8Y+mSjCV+TVYFiGsEon3rZqaQML0MZZaHhxS41hvUzGs4f3CZDOHBdA2MWu5yuyYv7AY568FF7mE9XUoBZesidhai7+QjfMWojyzNVZWph+lEyjRNmoyxRA55aSWPtHyXU6wKB3MKrrIeOujslXP3vuPlQh8FJKIyGoNOBqlgVyP9wSeITCeAh6Yp28U91IqIu21rCnaccwz32FHfcdiyf70J2qHPGncKTc4XkpKJgAJ0LHf+Uhq8Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nn3P79uZ+FTQ+a7NYgzqNafS2hvAmCgnLHWdHAbOnbw=;
 b=FAiMh4qnQu96brXvVUM0nE3Jp1Ns0aCbHFIV8sNFf/6MhE+nlo/OT9ObwqgJM4nINw5XdEWRiccuP3BZw8Jlf6hqgdjJV6MfnPz8yu81999mBS49mcRS1Y7HOOy6bop/nTSjtbeeZUqrOw4EFnZ4Sn+8Sz5BIaNLNmBGNOYm+jY=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by LV3PR12MB9329.namprd12.prod.outlook.com (2603:10b6:408:21c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Sun, 11 May
 2025 23:52:04 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.8699.012; Sun, 11 May 2025
 23:52:03 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Log RAS errors during load
Thread-Topic: [PATCH] drm/amdgpu: Log RAS errors during load
Thread-Index: AQHbvngvTl1BHVnXwEGL/sI71ld8RrPKchcAgAOwPXA=
Date: Sun, 11 May 2025 23:52:03 +0000
Message-ID: <BN9PR12MB5257DEE82F09ED091FB67022FC94A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250506111509.54645-1-lijo.lazar@amd.com>
 <d289cc93-1dfb-44e6-b51f-217a4219795f@amd.com>
In-Reply-To: <d289cc93-1dfb-44e6-b51f-217a4219795f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=0c7a3c2e-634b-4140-b30c-d88cbe776938;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-11T23:51:37Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|LV3PR12MB9329:EE_
x-ms-office365-filtering-correlation-id: 5fd08e3b-e305-4b1d-ae68-08dd90e6d46b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?STNEQmRBYmw4OXdINEc4WnRkMWtkVU9lOXA0VndlTFJFb0RCL1F6OTg1S2cv?=
 =?utf-8?B?aWRTL2cxa3pvK1FScFROV29VRkI0T25PUll2WCszRzQ0Tnhua3BOSFFybjVo?=
 =?utf-8?B?WTZsLzRNeFB2VVdEOWZ5S0NCYXdBK2JGOTJjOW9kQWZUdFdMQjduZjI0RHJl?=
 =?utf-8?B?U0R1amNYdUR3Yit5YjdzVWpHME1DWXl4QmQ2cGk1c2wzYk4rMGlqSFJEOUdk?=
 =?utf-8?B?TlpqZktqTlZDQ1FjbHMwRDFoekVkb0piR3ZNd25LOGNFOExPbkk0MFV6eXJv?=
 =?utf-8?B?S0loOFVJRmRaTEh1Z3FRWnlXU2FSK2VRelk0SnFIZlR2NisvS2xDWkM0Wm1O?=
 =?utf-8?B?US9CcStZU1hOcWdlS3lTenNYQ2RJTlBtVC9PTW1mNkJ3aTM1M1l5QmpZM3JG?=
 =?utf-8?B?elcybVBCVUFKSjF6RFpRemNJNmI2Z0tlV2htNzlXUjByR2hGNDg4UHVIVUJ5?=
 =?utf-8?B?cXUrMm5nN0Q4YzFGTkI3M0RoSUNQTkM3U1o1VFg1ZVUxVmlmdlh1VTZZTThz?=
 =?utf-8?B?SDM3WTl2MmpLUDYxVzhjYWk3eW4zVEN0L1Nxa0NHbFpZL3daaXFFV3MzK28y?=
 =?utf-8?B?c1VoOGtpZnZjREFiREFqRzR2eG1QUHZaOFc3RXJWRGRvc0JLdXVLQW1JNmdq?=
 =?utf-8?B?YjFSNldxMlorMVN5UVppTk4xSHRZaWFDd3RPRUZENVVzV1JDNFY1bjcrVEVX?=
 =?utf-8?B?SmtZc1FrTnZNOUU2Z0s5WFlPUEZFNkx2NzN5T0lsYys2ZGtSR1RYbDRCQkNv?=
 =?utf-8?B?Q2k2VnYwTTJUUG8wMUFtTGRqZmJpampZenM2K1psMGw2dktxVDRLR3pDelhJ?=
 =?utf-8?B?bWVlMXFiTkkvQUpCTVUrZDU4WkkvR2poQmVMbHN5OHRwMGZERldZd1JVRDNT?=
 =?utf-8?B?REREK3RTaFc2cVpiK1dkODhIT1RaMHZvTnNqbkIxc2hvOHhEakRVRGNtVXdY?=
 =?utf-8?B?cG9IQVpLY1puM3grTGtYNWhLNm9jU1Jyc29TbVpZTmM3M1Q1Z1duaDRyOFBQ?=
 =?utf-8?B?V2twL3o2dkhXY29udGpvN0RkSGNxcVRRSWxrSG4zOW1QRTFDRHl6TmZiZkRq?=
 =?utf-8?B?TU42bUc4OE0yWkcyWEVrYW1vNmJxVkpVbHBvSUdHYjY3UHFPNHM1V0NOMmZ2?=
 =?utf-8?B?bXlUT2k3QUVXUm1ZZk1xNlVGVTcyRFF2eCt0eng5OGdjUkZiUFBoVVlmWXJZ?=
 =?utf-8?B?REp0aGpOMUVqM0lnaGN0L0lnZkhTSTYvaFhBU2F4YWFmczJMQzFlZUNDVys3?=
 =?utf-8?B?d2dsN0tZYzNnZ3FiMUYvZ0FqTGtmZThzaXRlTnliMDB0VjcyWGZibFBmekdr?=
 =?utf-8?B?WlhEZzlIbnVvcHdKQ096ZW1ZNnBYbGRvN01sWU54N3JabXBOTUNaYU9oT2wy?=
 =?utf-8?B?K2kxYytTUVgxVzFtRG43SUx3L09QZWtrVmRjZVBFZGFyZ1BmUXNveUVySnB6?=
 =?utf-8?B?azJWSGRLbzZZOGNjM2VEMXAvU203a3JPam9tcHhERUw4OXpYYW1ERDcrRTJQ?=
 =?utf-8?B?MzAvMnBqME1ta0dNZklDNlZzMlN5UXY2VFhEbE56aXBSeStiUE4xMlNVdk5I?=
 =?utf-8?B?UDg0K0ZuUjhkTy9wMjUrSEJlbUpBZSs4RkpveHVvN2ltSGoyVUluZHV1aElK?=
 =?utf-8?B?OHpPdC9sRXhsWWNIajIwbzZuT0VHUzhuMUlYS2VCQ3dFZHA1QjhCQTZ6dTNW?=
 =?utf-8?B?bDZjaEN1ZzVJUzBvNFJXSWhkendZL21MV21XZmswcU1oekp2b1BSV05rNUkv?=
 =?utf-8?B?OUNrNk42MXB4OW9IOG5xZTNialh2VGphQ2p5bmo4NVYwaGpCRkVnclAzU2hp?=
 =?utf-8?B?QWFrR2dHcFU5SXg2bFpJc3pYNHV6bjBNcU9lUG96Q3BpU0M1a2NqTXkvcDNp?=
 =?utf-8?B?TU9GL3ZGOVo0TnR6NnR1dFVFS0ZvaVBKVGRBcDhlMTF2OHd0OUFBRy9LZCtj?=
 =?utf-8?B?aEtMM1lnbm1XUDVBc0JBMklsTVFSenJhSFZkUjVHMjFUM0R5YmhvRENCeEVC?=
 =?utf-8?B?RHY3Y1UraEhBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWhlcDgyRlpIT2Q4WDRDZmhBNUwydWJ3YTgyL3RRVEFpbGtJaWRtVEx1TUJ1?=
 =?utf-8?B?YVhDU1dNb2UrM28yUm1wam15Y3hLYUJxT0dxbjVzQ0czZFJicnBVN0lCZGVJ?=
 =?utf-8?B?S3hjck1BRHJJNVJoMk9FRnZ6YVhiM2x2aW15R0R2Y3I0TEgwdE5RQUN5enAw?=
 =?utf-8?B?eFV0c0lNZ0xrdXMzRHkvVDhSOVd5RHN4dlIyWlY5YjBXYThQWkJPOGpXZm13?=
 =?utf-8?B?ZFZ3SFh0NEt0dEZZays1MW9hL2xTcWdFbjVqa1lURktidXl1dmN6SGo0eHQw?=
 =?utf-8?B?OGd6TTRtdDkybzhjNCs3MUZNQm9LT01yUTVQRkZKU3NPVVo3R0NvZWtIYmxW?=
 =?utf-8?B?UjRBR1FOdThFM1g2U2lVeFhWVnp3ZmdCalZnL3dWL1dPdWgzL29XQURnVVdy?=
 =?utf-8?B?dHdtamJNZGN1M2oyMk5BeGNLTTZxaGlYcWJuVzR5c0YxVVdSOGovc3NPSENW?=
 =?utf-8?B?ZXhkdVFEdkU3N3l3UFYzV3phSS9KTXVVQU0vWVBSWEhLUTNzb3BFamVaYng3?=
 =?utf-8?B?a0lRNmlucnAwNFNiV3lWMGpXL2VWVFRDNGdscDZHTndXT1pxVndqSWlVU0tF?=
 =?utf-8?B?M1h5d2M4bGxoZWVuaUFYUEM1NFZjOFlVamd0S1c4ZTVmbFBYRXRHZUdjNklQ?=
 =?utf-8?B?NWJWV2RVSGh1WkxPNXJ1cGxoSURaSEFTcVo2QnJOYm45bnhEUzg0QXBBREZu?=
 =?utf-8?B?SGdlK3VKQ0pIUDJUanNmam1uVFBaemE4b3d6NFpzam1YeE9jdUpGUUgvM1FG?=
 =?utf-8?B?RVp2bkhpMzlVZjFuYkhGU0NuWGxNZ3ltWHZHS1VJOFVVWlQrNjlkVUEwYU5H?=
 =?utf-8?B?V1FhSFF5aFFJazkrSnp2WkNDaWRsb05Ub1pIOUswT0xSVVBONC9iY1FXc29Z?=
 =?utf-8?B?YkRCYWRTQ01Xay9qVjNvQy90VFFrMmJhZ0dHSXVNNGNkVlpkNVBYcUFJRzR5?=
 =?utf-8?B?RlFwNGY5d1g3bTVNM0xtZ0hCdHRZYmZ3NlJKcWdXSEQwMHhtdTM5d2pTNDRk?=
 =?utf-8?B?WGl5Tks0czh2b1p2WUx4V0V2VmtTampVQTAySHBKYXdWR0dleDgycHhhT0l4?=
 =?utf-8?B?clZhaWN6SVdNNGdUUCsreGtTWXFieGlJWFlzUENUWEV1OHRpWGI0QnhUQlM5?=
 =?utf-8?B?RTVoK1llZlA1bWo1T0V2eVJuajUzM00vdnp6NFNNTzBDL3I2UUV5NzMzUXd6?=
 =?utf-8?B?NThicEJ5NWZhYkNjaUNCV20vWEczMFZJbzloNkJ3b0RibVludGdoaXJ0Vzdj?=
 =?utf-8?B?YThIS0hNZmVLRVpEVkxwb21uNTFMdnBZRkhRenFicmRqcE1MOUZrUVBqYXB5?=
 =?utf-8?B?SzFLZkV3Y0NYZFJud1VGcnlrOVJDU2MzNWdEYmpnVDNWUWtjbWJxNmZHQmJx?=
 =?utf-8?B?bmVScm9wU1RLazY2Rk8rZ3lwWVp0Q1JGMmE2azBzc3VoY3JSQ3pPbkhKYUVy?=
 =?utf-8?B?eWJTcHVSREY1TGJuVlRQamxaa3ZrY3MwK2NHWmEvV0ZBWVJ1WDh0am1DZGN0?=
 =?utf-8?B?SVdtL01sem1mVkthdk1WYmh5WWZmNnJSVTVLbFpaZm0xOXVpdlljclJtbjNr?=
 =?utf-8?B?WnZrMGEzQ29nZm0wbXVNTUNpak8rcDcrdURtdUhpZ0xYOWIzemc0UFo3elRL?=
 =?utf-8?B?c3paTENoMm9FQ1FvdGg2RUNVa2xyU2NiaHBTcm10VnlZWmpZaTJEazR6YWdR?=
 =?utf-8?B?WXRsVm5uVlpzVUpFUkQvZUNTelBLZUVJY29ZeC9DdHJXbDcwMVpiZ2JvYU5p?=
 =?utf-8?B?bTlLa3VLbWZGdXEvL0JOMjlWTGY1YVlLa2Q3SExkVjhlcFRhREJ5R2FSdUdJ?=
 =?utf-8?B?UTFlWVF2S1Q2R1RGcG1ZZ3R2aEFGVlAwdHdsN3RKZFpCbFhVeEpTazlkTXRq?=
 =?utf-8?B?VDlmeUExN2U5djBaMDNLNVFHM0MwWlRpdkpDSWdkWG1zWnRDQ3RQZVg5bU5m?=
 =?utf-8?B?SDdSbHNieU8rb3BrUmVsQlBvdUZDM3ROMGp6NkFoVmpPRWZxeE1WU1N5SDNY?=
 =?utf-8?B?c1hTd3JZbEdRRWRycTR6R1dmZjBYQ1FrQ2hxTFVzNUdaRlVJRmg3QytxUWxu?=
 =?utf-8?B?YzM4V2JiOEVhWmlPNHVudEZ4RW0xTVBxVzBLUUNiQUNzVGlxQUtPaGVwRHBm?=
 =?utf-8?Q?sMpA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd08e3b-e305-4b1d-ae68-08dd90e6d46b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2025 23:52:03.6843 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UHMMyCqkPCcaNhPY4ilbeQDF/NOpq49r1FBljGjDUcf4vTCy7rU0K5O/+ZAWXEaZ73godhwN5RvGSGo2bNZq3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329
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
Cg0KUmV2aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCg0K
UmVnYXJkcywNCkhhd2tpbmcNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMYXph
ciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KU2VudDogRnJpZGF5LCBNYXkgOSwgMjAyNSAy
MzozMg0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogWmhhbmcsIEhhd2tp
bmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVy
LkRldWNoZXJAYW1kLmNvbT47IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllhbmcuV2FuZ0BhbWQu
Y29tPjsgWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENI
XSBkcm0vYW1kZ3B1OiBMb2cgUkFTIGVycm9ycyBkdXJpbmcgbG9hZA0KDQo8UGluZz4NCg0KT24g
NS82LzIwMjUgNDo0NSBQTSwgTGlqbyBMYXphciB3cm90ZToNCj4gRHVyaW5nIGRyaXZlciBsb2Fk
LCBSQVMgZXZlbnQgbWFuYWdlciBtYXkgbm90IGJlIGluaXRpYWxpemVkLiBUaGlzDQo+IHdpbGwg
Y2F1c2UgYW55IEFUSFVCIGV2ZW50IGR1cmluZyBkcml2ZXIgbG9hZCB0byBiZSBza2lwcGVkIGlu
IGRtZXNnDQo+IGxvZy4gTG9nIHRoZSBlcnJvciBpbiBkbWVzZyBsb2cgZm9yIGVhc2llciBkaWFn
bm9zaXMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IExpam8gTGF6YXIgPGxpam8ubGF6YXJAYW1kLmNv
bT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMgfCA1
ICsrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFz
LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMNCj4gaW5kZXgg
ODIwMTNiNDk1NDM2Li44NWE3MGI2NDY4NDAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcmFzLmMNCj4gQEAgLTQ0ODUsOCArNDQ4NSwxMSBAQCB2b2lkIGFtZGdwdV9y
YXNfZ2xvYmFsX3Jhc19pc3Ioc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICAgICAgICAg
ICAgICAgZW51bSByYXNfZXZlbnRfdHlwZSB0eXBlID0gUkFTX0VWRU5UX1RZUEVfRkFUQUw7DQo+
ICAgICAgICAgICAgICAgdTY0IGV2ZW50X2lkOw0KPg0KPiAtICAgICAgICAgICAgIGlmIChhbWRn
cHVfcmFzX21hcmtfcmFzX2V2ZW50KGFkZXYsIHR5cGUpKQ0KPiArICAgICAgICAgICAgIGlmIChh
bWRncHVfcmFzX21hcmtfcmFzX2V2ZW50KGFkZXYsIHR5cGUpKSB7DQo+ICsgICAgICAgICAgICAg
ICAgICAgICBkZXZfZXJyKGFkZXYtPmRldiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgInVuY29ycmVjdGFibGUgaGFyZHdhcmUgZXJyb3IgKEVSUkVWRU5UX0FUSFVCX0lOVEVSUlVQ
VCkNCj4gK2RldGVjdGVkIVxuIik7DQo+ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm47DQo+
ICsgICAgICAgICAgICAgfQ0KPg0KPiAgICAgICAgICAgICAgIGV2ZW50X2lkID0gYW1kZ3B1X3Jh
c19hY3F1aXJlX2V2ZW50X2lkKGFkZXYsIHR5cGUpOw0KPg0KDQo=
