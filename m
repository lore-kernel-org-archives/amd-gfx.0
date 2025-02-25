Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D9AC021B6
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 01:08:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C86C10E50B;
	Tue, 25 Feb 2025 01:08:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GqShKf6A";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C612E10E50B
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 01:08:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ssdCqozCsswO3/6OsTo0r7bG1PXrBxNrcGhrIC1x4ntQuJiS7b1NLF6trRa12/rQFHNHzY6Pc3m8b2xCm+1Vm8nnw8t/FoKrtKIZGcgQKKsL2M7roOTWYe5mvEFRSEyjnIZTKkXzy/fsPo8PfX3de+tRoPff7tlAwP6P7Bqo9iyyG5Ois+LtGHbOE9wl8WBdCKlyYEu17ZueQX7fhitQ0Snw6UfC55DykfUV+RmEr9ygtHvoEiYRmSuBHSZjrQNu2Lg8A9blvLbXKpDHSRLzoHhHtC9I75Ae1pXD0QfHBKJ+gaZWHgisCm9k20ZWRgcD3wNzQEZBmGPjIvZiXboZ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zH6VK3QTgwrCTjqqzA/25WbWUPe04qYO6jC+5aAzU8=;
 b=qsQQMT2YO6egMbPTAHZ+SW/IQZcukdjDyTRMjdP0Jp5WkiyWG4zxKjthmL634ShHawje/yInmkpA3XcFQjOBwC1hwFRaZUE/VvX/J3b73msfsTC28Ca3TDHwLBlDtEnRsBf6W+QSiklfzJqxPtuzxtGghnRm8PyNbbYSN0cRjcVxM/FKjuCmXZT3eCSoph1wMJcCP4yqK5fRvKr2ByF7cgw2N6TgN2MWD9hzTPGPgRmTMsUabs0+/IfwUgKOoj6ou7K3+WEEivnAMKqC518FYpt0snLhRZcWtdNQOf4665a2IJStnWERFGLB8tpEmUrIGQdiugSpLlRPMMAXklWLGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zH6VK3QTgwrCTjqqzA/25WbWUPe04qYO6jC+5aAzU8=;
 b=GqShKf6AovC1LCqIrkfcJg3lyDEtAlhmFIetOH4ypL0CAZW5z3h0szV1e/NOvdqYIU/SScmuOpbUit8AinRmDLx9PiZbe9WefJADTJtXJTyfHitBv3jB+XukuVPlUunkNsdUH7ziH2WxeETnXHFZOVRf9JRaYzLq+2FXFRM812I=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by PH7PR12MB7454.namprd12.prod.outlook.com (2603:10b6:510:20d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 01:08:03 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 01:08:03 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Correct the postion of reserve and unreserve
 memory
Thread-Topic: [PATCH] drm/amdkfd: Correct the postion of reserve and unreserve
 memory
Thread-Index: AQHbg476n0zHFimIM0Gnr888ozR8tbNWnbCAgACekKA=
Date: Tue, 25 Feb 2025 01:08:03 +0000
Message-ID: <PH0PR12MB5417F2249FF2F7C5F5FAF5078FC32@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20250220115946.2051216-1-Emily.Deng@amd.com>
 <b74f7a58-7f81-4123-a11d-5a8b2ec4376e@amd.com>
In-Reply-To: <b74f7a58-7f81-4123-a11d-5a8b2ec4376e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c414e5b5-d95a-4c78-b11a-73e849a42dd8;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-25T01:07:47Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|PH7PR12MB7454:EE_
x-ms-office365-filtering-correlation-id: b14e5d94-3267-40a8-bdae-08dd5538da97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?SlZMVVRBc0tEUWs1RW9QWm10YXhVK2xNR1VMZzU3RmlKN2xMTDR1d0oxQitw?=
 =?utf-8?B?TE43cmpReGVnL2VwcDl1UExieDBOWk1xcFdrVktTbWdDbVNxYnNQektIZm80?=
 =?utf-8?B?QlBxM3JlQlVNVEl6cnNKVW9WTnpiTVN0V0FFSU9pVDB0V0xhNGpGWUlTZzNZ?=
 =?utf-8?B?Rm5kQ0JRQmVVM0NTaEhqUkdaSXdwLzEwR0tuNEJzL0VjUU56V1F1aUFvSnNo?=
 =?utf-8?B?RlJXa1IyNDRXcWs1QXBGQUVVNVBzaTVVMkdaYnJReHNhTWo3TnpTQys1YU4z?=
 =?utf-8?B?bjF3QVpFR09JdUZUdFc0RDBqdXFld3BYYmYxNTRVVktIUzAvSjVkc1ZRZnpR?=
 =?utf-8?B?Q3Q5dWhZbU1DbWMwdUJRWVdsL0Mzc2JuMEhnVWFMR3FXNGpvVHpCVk5DaGJr?=
 =?utf-8?B?OXdVS1JPcXBYOVprV3FwOVFEd2QyN1djaXFYbmR5Y0xrRTJCMExBU3V2enVz?=
 =?utf-8?B?QkFKYlpmUnVxejJlTXF4RGxpYTliQjY1VXZ6N1pOZmZFa1N2eFR4VW1wVDN1?=
 =?utf-8?B?T2tyTEx0eHN4NzB6elI2WWNsLzhkaEFORHByZEpTZkd5QTJ1aks2dHk2alFF?=
 =?utf-8?B?SmFDUDNtbC94b2tLeE1Idk9WSzMxSUFWeU1IM0U2bGhJa3lyeHp3cURrYUFB?=
 =?utf-8?B?K2x5SG5RNWx0M1RwN1M5N1h6SEVqUmdNbno4WXFnNFRCRUdtOUMxU3dXdHF5?=
 =?utf-8?B?NndsRGdIZndvbFJUd0ZXRVNuVUgrTlIvbGlrVGpTdGdoL1hxTHpMWmVReTVz?=
 =?utf-8?B?K3pFZFdHZ3prWkgxRmwxQXliYnRlRUx6RHVsRkE4UnlmNC9ubExMQ0YrUkk2?=
 =?utf-8?B?dGlPRDRCaHU0WDMwRWNpaTBGMUt3U0ZIL1kwZHhONGxmSHNpdzBmcFlNdFNF?=
 =?utf-8?B?amZ4MVNIeTRjUzd6eW9KT2I0VW9hREdDMUVlbXZjcWY2VFM4K09xNW9ZdmEz?=
 =?utf-8?B?VlFtU3NYY3dyTE5lWjBFaHdYbUVmYjZVYnE2eG9lWGk5bHNmN0lJakkySVVO?=
 =?utf-8?B?NHlxZGlKVW5abGNrVXB5SU40S3dQQ0p5SFUxbjcwTjNnT3pUSjE5SmNpcVZ3?=
 =?utf-8?B?RklQNFpWQ0tHamUraFRHNTFSVGlMWmtudmIrelp0V2Z4Tnc2QmtobG0yTGZN?=
 =?utf-8?B?dlhlZFcvN2FsR3U3Qk1tNlRWU0dmeHordVJRTlhCdU1hTUV5aEZSbFR6cWI2?=
 =?utf-8?B?eVpxVzRPaWZaTGJEbTFKTVZ2YTdncGRKbXlPejNYTklVUWZMUDFhWlc1Qncz?=
 =?utf-8?B?WjhPM3VQYTNOQjNNSmtkRjhGNThCelhoRUM3ZXVEQ2R5dWV1WVZxNjRMd1dy?=
 =?utf-8?B?M0xhZ3RqQ3FhRUFMck9KSitlNFVuaG9lOVBRd0ltYXB4ZENGMzd2bHBJeXNs?=
 =?utf-8?B?TmpIT0JrTWljMzl0S3JtTW9JUEhlVmN1bkN6ZWw4M3c5N0U5UkZjTGhTeWxm?=
 =?utf-8?B?NjBaR0pBUTdDOGpzdnpDOWhHblBuZzNGQnp1ZEVsZktBSkltdUJReDdaeWFC?=
 =?utf-8?B?UDNTVG4xNWlDTXI2ejJsL3gra3h5WHFNd21TcGxoMVJIa2pmcGl4K3BhZytl?=
 =?utf-8?B?SEtZWUM1RVg2ajlLeHF4cFl0NXMweHhPQlBvNUVWSDNEOUFWaTh2RkxIUE9V?=
 =?utf-8?B?TzloR0NFa1VpTE1LTWFmcWVlRngrVmE3alZwaFBQR2t5MWcwZVBwODNwRHdC?=
 =?utf-8?B?SkI4TlM0bFB3Skh4MzdMVSsrYmhqNFZSb2QxWmlqZW9lSmxWWTlQODUvMGVU?=
 =?utf-8?B?RXpGMUV3K0E3dGVmMHgvak5sOXVZZHk2QWprYm05QzRiZVcwbFRMMklaOFd2?=
 =?utf-8?B?ZHNBMENmbXJMYU96MjQxa1p4a0lCYnFUTkFvbFpYQVdvQW0rcldiK3JBSlN3?=
 =?utf-8?B?YUlvdlVjVFhpaDNrVk9BbTZ0UWl2UmM5NXQ1ek1Nai94MTc1YUJqaXlKTnFt?=
 =?utf-8?Q?vDawHllRdW2R2nrkYrGjlmrE9abAXlLZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NE5HNXgrUmVRbUNQNG9Hczl0NWpBeU1pWnMwQWJqS1cvT0lFWXIrVHUxczky?=
 =?utf-8?B?c3gxV0xWSTVodlFKNnVjMDI3WXg0RVVCdjB3SldnWHZlMWNxdWVyOWVLcFVH?=
 =?utf-8?B?TFY4ais1azNKZFdJakhQM2ZCYUtIQll2S3JDQVQ0dkZyZ1FTWlI4cWNLWmVN?=
 =?utf-8?B?amNtTUl1NEE5ekxuNXhUaEdqZnRMNFVyTjRaT0VrSXBPZkk2ckxESG5rSlpr?=
 =?utf-8?B?b2IyOGxXb1ZQUzJXUmJHcVl1bFM1NGFKc0I3RkhFOWxxWUdOZjU2Yk41QXhK?=
 =?utf-8?B?elcyZWZTcWhxQXlvUGZBSU1KZG9GRFgxMGt1NFAyOXhEZkJrRy9NaCs2SDk3?=
 =?utf-8?B?OEtIYzhZQktiTW4wZVJxNDlsc3d4MGtGOTcyWnd5dmR6aGJDQ1NtYTVhY3VP?=
 =?utf-8?B?Y1lOWXlGZ1VLYml5R0liTXFHMklOdnZ6U2s5VS9uNjRna21BdjNreEwxUmQw?=
 =?utf-8?B?MHAyNUltUEU3WUNYSG55SmxqRDNDbHhURUo4dWd5WEY5THpLMGJ5TWdaNkhr?=
 =?utf-8?B?V0V4dldWeWNaaFBKNjM4Rkp1b3FpSXVGWnlXUC9XRWVncXJ3NXNwOFJ4T1Qz?=
 =?utf-8?B?YVIyRHNRRmc1TDZsNkJpWU5vYkFhSFE0YzhqRExLUytYTWs3SHZwQ3lsWDUy?=
 =?utf-8?B?cjhKT0xyclFRc2RWVmRaUlA4UkFhd1lFcXZ1UUVvcDVRSXdGWjRTUzNPUUsv?=
 =?utf-8?B?VWZNWnFicENQaEVXMUk4RHh3UmVzWUNzQlZvQk85MmUvbC9Bdk5zYWdISmUx?=
 =?utf-8?B?MU8vaEdEby9tT1BISFFVU2pXVm91OHl0djIyemZpR0hDT0VYRXJTR1ByK1dX?=
 =?utf-8?B?b2JyVjQwQThyaXk2R2tjS1M0OGZtd1kvYnBXbjF5NGtHTTI5R3hMLzZxUFdl?=
 =?utf-8?B?UHdEeU1OaE9UUE9USGRjQ0NDWTRsVmFOMERQUy81dUpwZFYyK0sra1Z1RTRq?=
 =?utf-8?B?U3l4UlUvbzk5WU5JNVo3U2F3U0NRM0tIQWRPZ0lJVmxNN2lDdWZWaDFreURu?=
 =?utf-8?B?R1puZlpFR01FRWVRUXMvU0Y3ZHJxcW82eEpLODBXemJ0M2F4M25FMThtZ01r?=
 =?utf-8?B?MW9FK3RnUEQxckZjM1hnZ3F6OXk0UC9KWEFIZWRKd3dkUnkwRGpjTWxxdEM3?=
 =?utf-8?B?N0xSZUFvRmtNeFRQNjJjd2J4bnEwT1RwdGFZU2R4bFRuckVPRVovblQvc3Bp?=
 =?utf-8?B?Ry9LVDhaMkpSdlJvcll0WU5iL0tUQXlZSXZzZTZ1L0dtZWxzZVl2Z21TczZ3?=
 =?utf-8?B?Z0VaSVlLVTlYd2hOVHdrYithSDVMdjZ3VTRFRHFEY1RzMDRYamNHYkQzRnZy?=
 =?utf-8?B?eXQ5enBrdm9XREU2OFB6Sm5wZ2xIcE5YUHNRNGljVys0VWdQUHpySzNucXJJ?=
 =?utf-8?B?SlBHam16cVQ5dXNMUk1ObXFZRjBBcjIzWXJnL242NzNueVBMcTNaUExmaGdw?=
 =?utf-8?B?WGtTaTRvdWtCM0RTaHhvZFBGaTRuSjk1bHA0M2pMeTh5YTY5Tll1aDMzM29q?=
 =?utf-8?B?V3VLaTVUcmhDMkpXajhxTVNCMGkyeHd3dHJ1YkFmVGc2NzFWT2VBRGJrZzdn?=
 =?utf-8?B?TUhWaXg1U0cvSk1VdHpmRFZ2NGhiN3M5ZFdoMWtvT04vYkJMOHRsaUdiKzNJ?=
 =?utf-8?B?WVRwd1lyL0p5cjZDUlNGMzR1Z2YraXVNVmpNbldadm9mMzUyQjl5MitUWVBB?=
 =?utf-8?B?ZzgxZ3ZQTk1CZ3NtUHFtcklTUXhOUHpsdm9LcGJHZkxWOEVoVTZUYTUvK2FE?=
 =?utf-8?B?cStrYUEvcDlmYVcrM2JSaVh0VmhyQ1E0VnoyUndoZHpMcXpCeitQN3d4NXp1?=
 =?utf-8?B?N0NLUUVMdm1sV24vOU0zZVZ5dTFQM3JsbEJwRFJBR1ExY2dVb1ltUWxtMitN?=
 =?utf-8?B?OElLNFpXMXU2VmtBL0ZxWHVXSStQSjExUzFSMTBLZDJhVkZSUEw3SU1GdGF5?=
 =?utf-8?B?SVdkVWVpWENiUkFtY3pKVVNhZTlLSmNTRjFGUk1wdHBUWm5OWjBYUWlQVWxV?=
 =?utf-8?B?M1IyYTZ3VlB4Yk1RbFA0NkszTFZXRjVCZmtQUVUvWGcwbEp6WHdmcVJoNlZZ?=
 =?utf-8?B?SVNxaExUVFVHSHZEMHhnQVo0SXJoOEhWMUJUcDRNVHJxVXdVSUVTL1F3Ull2?=
 =?utf-8?Q?ceIc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b14e5d94-3267-40a8-bdae-08dd5538da97
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 01:08:03.0210 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7K/hkyeIH1QBzfOblUYmiGtPsQEFkg8kfaKhkY68/oIdjjJvUXMg0GJKMvQdTASf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7454
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
Cg0KWWVzLg0KDQpFbWlseSBEZW5nDQpCZXN0IFdpc2hlcw0KDQoNCg0KPi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+RnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIENoZW4sDQo+WGlhb2dhbmcNCj5TZW50OiBNb25kYXks
IEZlYnJ1YXJ5IDI0LCAyMDI1IDExOjQwIFBNDQo+VG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnDQo+U3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGtmZDogQ29ycmVjdCB0aGUgcG9z
dGlvbiBvZiByZXNlcnZlIGFuZCB1bnJlc2VydmUNCj5tZW1vcnkNCj4NCj4NCj5JcyBpdCBmb3Ig
Zml4aW5nIHRoZSBpc3N1ZSB5b3UgbWVudGlvbmVkIHByZXZpb3VzbHkgIiBGaXggdGhlIGRlYWRs
b2NrIGluDQo+c3ZtX3JhbmdlX3Jlc3RvcmVfd29yayI/DQo+DQo+UmVnYXJkcw0KPg0KPlhpYW9n
YW5nDQo+DQo+T24gMi8yMC8yMDI1IDU6NTkgQU0sIEVtaWx5IERlbmcgd3JvdGU6DQo+PiBDYWxs
IGFtZGdwdV9hbWRrZmRfcmVzZXJ2ZV9tZW1fbGltaXQgaW4gc3ZtX3JhbmdlX3ZyYW1fbm9kZV9u
ZXcgd2hlbg0KPj4gY3JlYXRpbmcgYSBuZXcgU1ZNIEJPLiBDYWxsIGFtZGdwdV9hbWRrZmRfdW5y
ZXNlcnZlX21lbV9saW1pdCBpbg0KPj4gc3ZtX3JhbmdlX2JvX3JlbGVhc2Ugd2hlbiB0aGUgU1ZN
IEJPIGlzIGRlbGV0ZWQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogRW1pbHkgRGVuZyA8RW1pbHku
RGVuZ0BhbWQuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9taWdyYXRlLmMgfCAxMyAtLS0tLS0tLS0tLS0tDQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9zdm0uYyAgICAgfCAyMCArKysrKysrKysrKysrKysrKysrKw0KPj4gICAyIGZp
bGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbWlncmF0ZS5jDQo+PiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9taWdyYXRlLmMNCj4+IGluZGV4IDc5MjUx
ZjIyYjcwMi4uM2JiYzY5NzUxZjdlIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX21pZ3JhdGUuYw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX21pZ3JhdGUuYw0KPj4gQEAgLTUxNCwxNSArNTE0LDYgQEAgc3ZtX21pZ3JhdGVfcmFt
X3RvX3ZyYW0oc3RydWN0IHN2bV9yYW5nZSAqcHJhbmdlLA0KPnVpbnQzMl90IGJlc3RfbG9jLA0K
Pj4gICAgICBzdGFydCA9IHN0YXJ0X21nciA8PCBQQUdFX1NISUZUOw0KPj4gICAgICBlbmQgPSAo
bGFzdF9tZ3IgKyAxKSA8PCBQQUdFX1NISUZUOw0KPj4NCj4+IC0gICAgciA9IGFtZGdwdV9hbWRr
ZmRfcmVzZXJ2ZV9tZW1fbGltaXQobm9kZS0+YWRldiwNCj4+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBwcmFuZ2UtPm5wYWdlcyAqIFBBR0VfU0laRSwNCj4+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBLRkRfSU9DX0FMTE9DX01FTV9GTEFHU19WUkFN
LA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG5vZGUtPnhjcCA/IG5v
ZGUtPnhjcC0+aWQgOiAwKTsNCj4+IC0gICAgaWYgKHIpIHsNCj4+IC0gICAgICAgICAgICBkZXZf
ZGJnKG5vZGUtPmFkZXYtPmRldiwgImZhaWxlZCB0byByZXNlcnZlIFZSQU0sIHI6ICVsZFxuIiwg
cik7DQo+PiAtICAgICAgICAgICAgcmV0dXJuIC1FTk9TUEM7DQo+PiAtICAgIH0NCj4+IC0NCj4+
ICAgICAgciA9IHN2bV9yYW5nZV92cmFtX25vZGVfbmV3KG5vZGUsIHByYW5nZSwgdHJ1ZSk7DQo+
PiAgICAgIGlmIChyKSB7DQo+PiAgICAgICAgICAgICAgZGV2X2RiZyhub2RlLT5hZGV2LT5kZXYs
ICJmYWlsICVsZCB0byBhbGxvYyB2cmFtXG4iLCByKTsgQEANCj4+IC01NjAsMTAgKzU1MSw2IEBA
IHN2bV9taWdyYXRlX3JhbV90b192cmFtKHN0cnVjdCBzdm1fcmFuZ2UgKnByYW5nZSwNCj51aW50
MzJfdCBiZXN0X2xvYywNCj4+ICAgICAgfQ0KPj4NCj4+ICAgb3V0Og0KPj4gLSAgICBhbWRncHVf
YW1ka2ZkX3VucmVzZXJ2ZV9tZW1fbGltaXQobm9kZS0+YWRldiwNCj4+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBwcmFuZ2UtPm5wYWdlcyAqIFBBR0VfU0laRSwNCj4+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBLRkRfSU9DX0FMTE9DX01FTV9GTEFH
U19WUkFNLA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG5vZGUtPnhj
cCA/IG5vZGUtPnhjcC0+aWQgOiAwKTsNCj4+ICAgICAgcmV0dXJuIHIgPCAwID8gciA6IDA7DQo+
PiAgIH0NCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X3N2bS5jDQo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uYw0KPj4gaW5k
ZXggZGIzMDM0YjAwZGFjLi5jODYxZDhjOTA0MTkgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9zdm0uYw0KPj4gQEAgLTQzMCw2ICs0MzAsMTAgQEAgc3RhdGljIHZvaWQgc3Zt
X3JhbmdlX2JvX3JlbGVhc2Uoc3RydWN0IGtyZWYgKmtyZWYpDQo+PiAgICAgICAgICAgICAgLyog
V2UncmUgbm90IGluIHRoZSBldmljdGlvbiB3b3JrZXIuIFNpZ25hbCB0aGUgZmVuY2UuICovDQo+
PiAgICAgICAgICAgICAgZG1hX2ZlbmNlX3NpZ25hbCgmc3ZtX2JvLT5ldmljdGlvbl9mZW5jZS0+
YmFzZSk7DQo+PiAgICAgIGRtYV9mZW5jZV9wdXQoJnN2bV9iby0+ZXZpY3Rpb25fZmVuY2UtPmJh
c2UpOw0KPj4gKyAgICBhbWRncHVfYW1ka2ZkX3VucmVzZXJ2ZV9tZW1fbGltaXQoc3ZtX2JvLT5u
b2RlLT5hZGV2LA0KPj4gKyAgICAgICAgICAgIHN2bV9iby0+Ym8tPnRiby5iYXNlLnNpemUsDQo+
PiArICAgICAgICAgICAgS0ZEX0lPQ19BTExPQ19NRU1fRkxBR1NfVlJBTSwNCj4+ICsgICAgICAg
ICAgICBzdm1fYm8tPm5vZGUtPnhjcCA/IHN2bV9iby0+bm9kZS0+eGNwLT5pZCA6IDApOw0KPj4g
ICAgICBhbWRncHVfYm9fdW5yZWYoJnN2bV9iby0+Ym8pOw0KPj4gICAgICBrZnJlZShzdm1fYm8p
Ow0KPj4gICB9DQo+PiBAQCAtNTgxLDYgKzU4NSwxOCBAQCBzdm1fcmFuZ2VfdnJhbV9ub2RlX25l
dyhzdHJ1Y3Qga2ZkX25vZGUgKm5vZGUsDQo+c3RydWN0IHN2bV9yYW5nZSAqcHJhbmdlLA0KPj4g
ICAgICAgICAgICAgIGtmcmVlKHN2bV9ibyk7DQo+PiAgICAgICAgICAgICAgcmV0dXJuIC1FU1JD
SDsNCj4+ICAgICAgfQ0KPj4gKw0KPj4gKyAgICByID0gYW1kZ3B1X2FtZGtmZF9yZXNlcnZlX21l
bV9saW1pdChub2RlLT5hZGV2LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgcHJhbmdlLT5ucGFn
ZXMgKiBQQUdFX1NJWkUsDQo+PiArICAgICAgICAgICAgICAgICAgICBLRkRfSU9DX0FMTE9DX01F
TV9GTEFHU19WUkFNLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgbm9kZS0+eGNwID8gbm9kZS0+
eGNwLT5pZCA6IDApOw0KPj4gKyAgICBpZiAocikgew0KPj4gKyAgICAgICAgICAgIHByX2RlYnVn
KCJmYWlsZWQgdG8gcmVzZXJ2ZSBWUkFNLCByOiAlbGRcbiIsIHIpOw0KPj4gKyAgICAgICAgICAg
IG1tcHV0KG1tKTsNCj4+ICsgICAgICAgICAgICBrZnJlZShzdm1fYm8pOw0KPj4gKyAgICAgICAg
ICAgIHJldHVybiAtRU5PU1BDOw0KPj4gKyAgICB9DQo+PiArDQo+PiAgICAgIHN2bV9iby0+bm9k
ZSA9IG5vZGU7DQo+PiAgICAgIHN2bV9iby0+ZXZpY3Rpb25fZmVuY2UgPQ0KPj4gICAgICAgICAg
ICAgIGFtZGdwdV9hbWRrZmRfZmVuY2VfY3JlYXRlKGRtYV9mZW5jZV9jb250ZXh0X2FsbG9jKDEp
LA0KPj4gQEAgLTY1NSw2ICs2NzEsMTAgQEAgc3ZtX3JhbmdlX3ZyYW1fbm9kZV9uZXcoc3RydWN0
IGtmZF9ub2RlICpub2RlLA0KPnN0cnVjdCBzdm1fcmFuZ2UgKnByYW5nZSwNCj4+ICAgcmVzZXJ2
ZV9ib19mYWlsZWQ6DQo+PiAgICAgIGFtZGdwdV9ib191bnJlZigmYm8pOw0KPj4gICBjcmVhdGVf
Ym9fZmFpbGVkOg0KPj4gKyAgICBhbWRncHVfYW1ka2ZkX3VucmVzZXJ2ZV9tZW1fbGltaXQoc3Zt
X2JvLT5ub2RlLT5hZGV2LA0KPj4gKyAgICAgICAgICAgIHByYW5nZS0+bnBhZ2VzICogUEFHRV9T
SVpFLA0KPj4gKyAgICAgICAgICAgIEtGRF9JT0NfQUxMT0NfTUVNX0ZMQUdTX1ZSQU0sDQo+PiAr
ICAgICAgICAgICAgbm9kZS0+eGNwID8gbm9kZS0+eGNwLT5pZCA6IDApOw0KPj4gICAgICBkbWFf
ZmVuY2VfcHV0KCZzdm1fYm8tPmV2aWN0aW9uX2ZlbmNlLT5iYXNlKTsNCj4+ICAgICAga2ZyZWUo
c3ZtX2JvKTsNCj4+ICAgICAgcHJhbmdlLT50dG1fcmVzID0gTlVMTDsNCg==
