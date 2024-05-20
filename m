Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F00C04FFE
	for <amd-gfx@archiver.kernel.org>; Mon, 20 May 2024 08:21:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDA5C10E4BA;
	Mon, 20 May 2024 08:21:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YpN53NL5";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8F7C10E4BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 May 2024 08:21:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6X1A6RVQj/1tr4ZO5UgEvzdzSt93Yfz0l/7pubbDWBPX1xoYB9AI/Pg70E+FN80iqApQBFu3/yJDG9QI6BaG3uElBblA7ntyvAhiePTefo9uFlFBtJU9+o1nTAwHCd4JcSbBh9SccinzcvMaD3+4bF6Rq51M7M85yHyoV62NehlonXeUHOzvAt8kdmQw68G8UQ9hOdHGyGJ1mqqiIfx+FGeS9YS6chXACMdTB4fHKYI9Y2K/N1Bs1gO6oaeHOHqh1Rv2S9uSS6v0B3yv43eMyjxE+ErNxdn5/bKlyOyiMCu9h5M/KyYqokvGYpaq29aAK5N4QvUCK0z3P+dPWNCYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkcsQHjWJavUjLxK/1O1sS/RIeXlJ3Kq7jQfmkq+CzM=;
 b=kvWjfG7POAXVGauUD+XQBtoNFCp3n4nn9QAVT0ezmA2R9OQF0UiS1ohvexeyRr/urAN8Zn79FJzwBXTqM12ZRD8/ViIarePBBbt4CleTAiKSs1MyuOK09sliy9fH8j9R6LYfmnva6oUWMl2F390PaDL4OrMNBFPK8AvXN4cElSet++V21vKa7I4e3oS8iROVSGg+HIMnrr+6ux6fGDoplf6Wy6/gcRoOjNeXVq1Mxu+BkH3VPy1uM9LSVC8ppXexa4o672q9pMiJgo+FXeBJHdYh5ImbpU77vHnZXhq8Pu7oQW0idrZTIo/8PpdDtctg+r2mwZni/gjEZRxeyfpw5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkcsQHjWJavUjLxK/1O1sS/RIeXlJ3Kq7jQfmkq+CzM=;
 b=YpN53NL55GOyLetG4nThBLlaNH/4iDImbu2PegcGgu7ZE86k+WrNc6wJimrLxJVU9BZCJPOVVZ8Kurs8TkSTfeCSyz6yJRyQwYTVl+P4KsEeiwEF3ckvAHIbBykE/hHMa4dhvDkVQBL4dLys5oyUtscoR+5zYBX7AN2xq0clp8M=
Received: from DM4PR12MB5261.namprd12.prod.outlook.com (2603:10b6:5:398::22)
 by SA0PR12MB7004.namprd12.prod.outlook.com (2603:10b6:806:2c0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 08:21:14 +0000
Received: from DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::e175:f839:8e2e:2885]) by DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::e175:f839:8e2e:2885%7]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 08:21:14 +0000
From: "Xiao, Shane" <shane.xiao@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Somasekharan, Sreekant"
 <Sreekant.Somasekharan@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>, "Yao,
 Longlong" <Longlong.Yao@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Correct the GFX12 memory type setting
Thread-Topic: [PATCH] drm/amdkfd: Correct the GFX12 memory type setting
Thread-Index: AQHaqCfrtG9tU2ZbFEicBZRBnYegQLGbk+QAgAQpzZA=
Date: Mon, 20 May 2024 08:21:14 +0000
Message-ID: <DM4PR12MB5261E54872648A98A45C9BBE9DE92@DM4PR12MB5261.namprd12.prod.outlook.com>
References: <20240517070011.2253488-1-shane.xiao@amd.com>
 <CADnq5_PXY+nx-RVjxmjpjEFSjGSTQpCp0MYJB8yRJwJKx=CNwQ@mail.gmail.com>
In-Reply-To: <CADnq5_PXY+nx-RVjxmjpjEFSjGSTQpCp0MYJB8yRJwJKx=CNwQ@mail.gmail.com>
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
x-ms-traffictypediagnostic: DM4PR12MB5261:EE_|SA0PR12MB7004:EE_
x-ms-office365-filtering-correlation-id: a97154c0-789c-4ac9-39f0-08dc78a5d08e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?eDlTK0RmektiR3hoYVlHaUlXQXZJenNZbUJLRG9pNFZJUFhkMU1hZjVieXVo?=
 =?utf-8?B?QUNuZFRSUTZIYUgwNmlXeUxORktNOGFnbU5SOU9IVUVmd3RhbG1LM3Rlc0xT?=
 =?utf-8?B?Rm8xNU90d3BvSUtzaTVNTDY2RUo3b2hTZWY4TkNDbklBNHV0dnZSVy9GNEVK?=
 =?utf-8?B?V0dOc0FscEVFY2JYSGdLd0RkVjBxSXBGQnczbDcrdTR6UDFXLzJPUUtmS1hO?=
 =?utf-8?B?TEF1R0k0Njd4SHhGZWRHb29DeUJ2MWRIMk5TYkpYQitiM1owYTdUNGJKWHBp?=
 =?utf-8?B?T05BY0luYnE1ZVMyaXEyS0ROeGVtRS9NVk5tMy9qa2NweElmRHpCOEpQdmVx?=
 =?utf-8?B?dTZKUTR0VUZPNnIzcXlsUXZZV1dYd29jdFQvYk1UbmZiRHpqWFJ4bGFyS3ls?=
 =?utf-8?B?bGZXT3pLUEJQRkNKbU5PYVJoenBpVzZETzIrS2ZXaXR6aWhONEhyL0dZb1dQ?=
 =?utf-8?B?Mk0ybTZmZTFmTTN6VGVBWWNnNkkzM1hxSlh6VU9BeVVFcExFNUh0Lzc0NnRE?=
 =?utf-8?B?bEh3ekNjYVpqUkFWTTFteGVVaWg4dTF4T0RCZk4vUzh6TUdQMVhUbFlLYzRk?=
 =?utf-8?B?eGVVOVdZZ1g4bWQvbWJpWFUyN2ticFpkb0xmc3RnWXJPZVZDZG5RaVM1eGZD?=
 =?utf-8?B?Z0REZFNDNm1NM0FVY1BkejRHbDMzcDFsQWRYcVdmMEVFTnBxRUt2c3JnQ3ZF?=
 =?utf-8?B?ZnphNklGTU1tdUhmZGkzdGp6aDZReVJ2QUl1anBuOE1wNEFITUo2d2NPaHhZ?=
 =?utf-8?B?MzhFSlFZeC9heHBod1IxQUloaDcrcmlsaTFTbkRmMW8vSmlIRzVhRU1YYW9M?=
 =?utf-8?B?S20xY0FpVWZMYVZRcDNOcGRQZVRtYmlhb1U3Q2dJOVVTOGNVN0s4VGNPNXdL?=
 =?utf-8?B?aXZ4OEkyUnFqMTEvSjliSmQ5Sk0zaEd5Q2t3TEtncktlUXZaNEZBelZDNzFi?=
 =?utf-8?B?eE9Sbmh3TlpRYis2cmhyTzhSS2Q5bXZ6VS83L3JmcVBUWGZ5V2k4UkJhaEFP?=
 =?utf-8?B?eFVWYWFjdy9pOE1tUEcvb0ZEVVprdlg5TDFkeG0vdjJJY1RiK3ROZXVyOVI4?=
 =?utf-8?B?ZWRDV1hiVnI5L3lESVFoVXV1Z055cEZ4bzlzcXIrZWRyazlIb1BTOUx5aHpW?=
 =?utf-8?B?WFFRRmtHUDFRUmg1RlBpV0FNMFROa2xiVkZKQVFad1p1LzRHWmFtRFl1c0l5?=
 =?utf-8?B?TTF5a0NBakptdkdBUXlibndxSGJRbFB0YzdBZVpDdnhJOER1MFFmbllrbHhH?=
 =?utf-8?B?UGk1SllFKzBnSFdub3Q5YmpIZE9kTG5nQXcrTEs2cUlsdWU0UW5XL3BjTWZw?=
 =?utf-8?B?NlRwLzlhRHd6djh1ajhLNkpBK0cwQjJISnZHTkxUNGg4bGFPUk5CYThCVTV0?=
 =?utf-8?B?dGt6U0pJSVNFWElVekg5QnIvVldTSlQrd3VVMkw2SU15cG13dG00clVBUzFZ?=
 =?utf-8?B?Yis3aVU2S0dYN0dKUHMxaEVFa2EzUnpqdG42U3NHT0UvVTVNa0RnOUQ2c09j?=
 =?utf-8?B?RVloTW9GSVBwNHZJR0tMU1VUQmRUam11QUNlVEhXOEtOZHdSdG5DZEM4ODJH?=
 =?utf-8?B?OFlOekNrQlNuclkzUEdybEFhL2Q0ZWNYN0tNOFNkSEJxL2N3ek5KMWNCNWNG?=
 =?utf-8?B?NEY2M3A1cG1ZbUVySHNvdjFLM0E2dFhvcWtGM29RaG9vRnMyNnZEK1dTaXdJ?=
 =?utf-8?B?NlNPQ2pzaUUrdDZXcXZyVVBDQ1RQY0d4REwwelRndGthM0Y5bDlFNnRPaTcr?=
 =?utf-8?B?U0lwNGwwRGxBeW9UTnl6c0Y1ZS9wNlR3TUxFZFdVaG0yT0x6TzducTFPblI5?=
 =?utf-8?B?WkpNazl1amFzZHM5RWtoQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5261.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3RiMEZGV0JZRXZmMm1YL3BGbmZxMEl1WWRBSnlJdkxOcmtSdDkrNkdocmhs?=
 =?utf-8?B?TytsYkdBN2gveUF2NWhDR3NPWUpYQVQyeTBrOVhPa3ZaZ0RlcGRHOUx1M3Ir?=
 =?utf-8?B?NUhEdVM5b2M0eFhaZ2gydEJXOGErK3hWb3E5d1QyUlBZY1ppS05GWWRBRXY0?=
 =?utf-8?B?V2pFRk1DZFY4OTVTc0J3aE9DWjIxeTgzaWNsK0ZlbDJYQ1dpYTNURGI3eHNG?=
 =?utf-8?B?NzIyNnA1cmdPZkcxQ01NMFl2ODRVeDAvRCtrSWxPMWJYVFl4cmJwd1BqN25k?=
 =?utf-8?B?Q213MFg3OGFQYW5xTWNoSTJUU2ZVWWVtcU9KN2VEcjlqamtxYUc2Ymx3V2Qw?=
 =?utf-8?B?OFhIa1RoeWFlazlYZUs4cVJqRmpOdEsreFg5UmtxMmQ5d3E0SmhzNVlhNG4r?=
 =?utf-8?B?UDM5VXdZb2pkNi9NRTFaenJTZ2RJOEYxS2tMSFNwTzR2RlF5b2VIR3NYclNG?=
 =?utf-8?B?VFJ6N3lHUUgyU2RiSjRnNHozbGdSZU5EVDFvR0cwMmh6SGJRSFhYVkF6bHJI?=
 =?utf-8?B?Uzkva3ZBdHFYVStzb2hCNjR4MjlIYzdSTW1XRG14Z1dIMjJ0N2dOQitHVjM1?=
 =?utf-8?B?VUd3cGlmY1p0YVV3SU9abmR5QnZyZ0YzbUh1Z3ptd1U1RlVMNHF3bEQwV0Jj?=
 =?utf-8?B?am5CeEt1Z1Vxd2QvQVlRWVNaTVRwVm9rYkwzUHM5VkZhV2ttYWI3cDNDcUxD?=
 =?utf-8?B?bjVUa3JXSVQ4VVpNVG9uSzhIQUNSeVB2THkxKysraWREQmo1WGx6S05oVEc3?=
 =?utf-8?B?WEdia2ErYzRhSHZYcm1TM25obEI0dUdVVS9hMlliRENXQTEzU0ZWVHR1YStK?=
 =?utf-8?B?UVdjeVNBQnA2emxOakhTTTBFeW0wZDRjNmdjZWVoNytvMlp6ZDBWWkxIOXFk?=
 =?utf-8?B?ZXNKRzdxYzdZZnRHaysxVHhlMDFDWGFlQXRHT1BZY2N5bXlmcU03QlhjY2h0?=
 =?utf-8?B?OGhQVlg5NFlyTWU1OXhnZk1QZ3Q3dEl5aWtQMnlrQ3hza2VrUDNwN0xJUzly?=
 =?utf-8?B?VWRRR3VIQzBIRzRxS3RUeTBIS25qbURDM0RpTmZPSUxHd2ZhUzdJYXVaYnpS?=
 =?utf-8?B?UE1qaWdQMWNocXA2Q2xyakNQUzNVd2JKeC9vS3BoV09PMXdoTTdoNGQ4WmJt?=
 =?utf-8?B?T2R1c1FEWmt3UWphL2owcU9UODgwU21SckRrY0xVbE1XcGFoWkJpazF6UWJj?=
 =?utf-8?B?MEVQM1ZzaEJwRzFISFQ5T2twUjRsK0tvNlM4UnUxNTI1Q29zT285UUhsU1Ez?=
 =?utf-8?B?b081dWlzVEFHS3lFTEFwdTd6K3hTSHo2alJFK2QvbnRmSzR6RC8yN05OMEE1?=
 =?utf-8?B?UlFzVndJdnppZWd1T0pRMERYU3JlR2Iwd283a2pUL3IzSEdKdmMxY0VBYmhn?=
 =?utf-8?B?NkVMdVYvVFBiSzYxbHdPVzVIQUZyQ29oZjl6NUdlMWNNanVIaW85MEpadjd4?=
 =?utf-8?B?dzBBWEd1K0g4RDduL3dxNU1LVlBMOHAwOEdDd2tEalNKWit0ZFJBdDRONHll?=
 =?utf-8?B?R1NiaFpFM1lmWUZFUUk4RFZiRHQ0VWwwZXJFNjY2L29IaytWSzgrbEZLemQ1?=
 =?utf-8?B?YnpMZEVHdGNaMjFxSGRwWTNpUDdFUUsxc29YMDRrQnJEWWViU2NnaGE2OTNW?=
 =?utf-8?B?TnhaaXE0ZVRSRllMajY1bkxiSTJpYm9GNVdybkFYM2pubWNNSW16eFZGUTJ2?=
 =?utf-8?B?ZytyeklFNFg4NDJrSW9wcWNwZU9UOWpyUDQ0b0VmVW91bDZzRXNxRURWQWZo?=
 =?utf-8?B?d3l0MGhVMmRrY3lmb0NVUkkvZUdONmhBVzU2MVJkYm1TeDhpL091d3l3TGJl?=
 =?utf-8?B?RFU1Q29VVmV1b1NQcm5qK2tTZTlwcVViMG1WUVhFMmNhUDNjMVRHZWlUM2pK?=
 =?utf-8?B?Mmo2d1FJQ0VxVGd0R1lCR1JpUVZBUjBPdWNiSHdFUGFRZVJTaHNhWlBzR1pk?=
 =?utf-8?B?U3EyR08zRVFUVFNrVjJQVk1wdnkrM08yY3ZndElsUFJPbmZCUjRsSGhsRjda?=
 =?utf-8?B?ZVlobW5DdENqcE1jUnpTMVJqK0grTW9jNWE1NzFVTDNTaG51dE1Db3cxcmpz?=
 =?utf-8?B?bGZwOFY3ODkrRC81NnpYZTk2dmhlbC9lcjAycjJiZTRWQTRtMXZIb3dSbWRP?=
 =?utf-8?Q?3fFQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5261.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a97154c0-789c-4ac9-39f0-08dc78a5d08e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 08:21:14.3259 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I1WPZbFSs3W/MmoZ62N4eek2luiNCDNnG/87TgGEoRetddKdSYqiRQkhNgYEa7GW62BfkmEidvoJTBhxc/wIyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7004
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4IERldWNoZXIgPGFs
ZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBNYXkgMTcsIDIwMjQgMTE6NTIg
UE0NCj4gVG86IFhpYW8sIFNoYW5lIDxzaGFuZS54aWFvQGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgS3VlaGxpbmcsIEZlbGl4DQo+IDxGZWxpeC5LdWVobGlu
Z0BhbWQuY29tPjsgU29tYXNla2hhcmFuLCBTcmVla2FudA0KPiA8U3JlZWthbnQuU29tYXNla2hh
cmFuQGFtZC5jb20+OyBMaXUsIEFhcm9uIDxBYXJvbi5MaXVAYW1kLmNvbT47DQo+IFlhbywgTG9u
Z2xvbmcgPExvbmdsb25nLllhb0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0v
YW1ka2ZkOiBDb3JyZWN0IHRoZSBHRlgxMiBtZW1vcnkgdHlwZSBzZXR0aW5nDQo+DQo+IE9uIEZy
aSwgTWF5IDE3LCAyMDI0IGF0IDM6MDfigK9BTSBTaGFuZSBYaWFvIDxzaGFuZS54aWFvQGFtZC5j
b20+IHdyb3RlOg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBmaXhlcyB0aGUgR0ZYMTIgbWVtb3J5IHR5
cGUgdG8gTkMuIFNpbmNlIHRoZSBNZW1vcnkgdHlwZQ0KPiA+IGNhbiBiZSBvdmVyd3JpdHRlbiBi
eSB0aGUgcHJldmlvdXMgb3BlcmF0aW9ucywgdGhlIEdGWDEyIE1UWVBFIGJpdHMNCj4gPiBuZWVk
IHRvIGJlIGNsZWFyIGJlZm9yZSBzZXR0aW5nIHRvIE5DLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogbG9uZ2x5YW8gPExvbmdsb25nLllhb0BhbWQuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNo
YW5lIFhpYW8gPHNoYW5lLnhpYW9AYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ21jX3YxMl8wLmMgfCAzICsrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMl8wLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dtY192MTJfMC5jDQo+ID4gaW5kZXggZTJjNmVjM2NjNGYzLi42MjQ2ZDFk
YzBkMzAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Yx
Ml8wLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEyXzAuYw0K
PiA+IEBAIC01MzQsNyArNTM0LDggQEAgc3RhdGljIHZvaWQgZ21jX3YxMl8wX2dldF92bV9wdGUo
c3RydWN0DQo+ID4gYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPg0KPiA+ICAgICAgICAgLyogV0Eg
Zm9yIEhXIGJ1ZyAqLw0KPiA+ICAgICAgICAgaWYgKGlzX3N5c3RlbSB8fCAoKGJvX2FkZXYgIT0g
YWRldikgJiYgY29oZXJlbnQpKQ0KPiA+IC0gICAgICAgICAgICAgICAqZmxhZ3MgfD0gQU1ER1BV
X1BURV9NVFlQRV9HRlgxMihNVFlQRV9OQyk7DQo+ID4gKyAgICAgICAgICAgICAgICpmbGFncyB8
PSAoKmZsYWdzICYgfkFNREdQVV9QVEVfTVRZUEVfR0ZYMTJfTUFTSykgfA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIEFNREdQVV9QVEVfTVRZUEVfR0ZYMTIoTVRZUEVfTkMpOw0KPg0KPiBN
YXliZSB3ZSBzaG91bGQgbWFrZSB0aGUgQU1ER1BVX1BURV9NVFlQRV9HRlgxMigpIG1hY3JvIGNs
ZWFyIHRoZQ0KPiBjdXJyZW50IGZpZWxkIGJlZm9yZSBzZXR0aW5nIHRoZSBuZXcgb25lPyAgVGhh
dCB3b3VsZCBhbGlnbiB3aXRoIHRoZSBzaW1pbGFyDQo+IHJlZ2lzdGVyIGZpZWxkIG1hY3Jvcy4N
Cg0KVGhlIEFNREdQVV9QVEVfTVRZUEVfR0ZYMTIoKSBtYWNybyBpcyB1c2VkIG10eXBlIGFzIGlu
cHV0LCAgaWYgd2UgYWxpZ24gd2l0aA0KUmVnaXN0ZXIgZmllbGQgc2V0dGluZywgd2UgbmVlZCB1
c2UgdWludDY0IGZsYWdzIGFzIGlucHV0Lg0KDQpJZiB3ZSBkbyBsaWtlIGJlbG93Og0KDQotI2Rl
ZmluZSBBTURHUFVfUFRFX01UWVBFX0dGWDEyKGEpICAgKCh1aW50NjRfdCkoYSkgPDwgNTQpDQot
I2RlZmluZSBBTURHUFVfUFRFX01UWVBFX0dGWDEyX01BU0sgQU1ER1BVX1BURV9NVFlQRV9HRlgx
MigzVUxMKQ0KKyNkZWZpbmUgQU1ER1BVX1BURV9NVFlQRV9HRlgxMl9TSElGVChtdHlwZSkgKCh1
aW50NjRfdCkobXl0eXBlKSA8PCA1NCkNCisjZGVmaW5lIEFNREdQVV9QVEVfTVRZUEVfR0ZYMTJf
TUFTSyBBTURHUFVfUFRFX01UWVBFX0dGWDEyX1NISUZUKDNVTEwpDQorI2RlZmluZSBBTURHUFVf
UFRFX01UWVBFX0dGWDEyKGZsYWdzKSAgIFwNCisgICAgKChmbGFncykgJiAoKH5BTURHUFVfUFRF
X01UWVBFX0dGWDEyX01BU0spKSB8IChmbGFncykpDQoNCldlIG5lZWQgdG8gY2hhbmdlIHRoZSBt
ZW1vcnkgdHlwZSBzZXR0aW5nIGZyb20gQU1ER1BVX1BURV9NVFlQRV9HRlgxMihNVFlQRV9OQykg
dG8NCkFNREdQVV9QVEVfTVRZUEVfR0ZYMTIoQU1ER1BVX1BURV9NVFlQRV9HRlgxMl9TSElGVChN
VFlQRV9OQykpLg0KVGhpcyBtYWtlcyB0aGUgY29kZSBsb29rIG1vcmUgY29tcGxpY2F0ZWQuDQoN
Cg0KQW5vdGhlciB3YXkgaXMgdG8gYWRkIG9uZSBtb3JlIG1hY3JvIEFNREdQVV9VUERBVEUvU0VU
X1BURSBfTVRZUEVfR0ZYMTIuDQojZGVmaW5lIEFNREdQVV8gVVBEQVRFX1BURV9NVFlQRV9HRlgx
MihmbGFncykgICBcDQogICAgICAgICgoZmxhZ3MpICYgKCh+QU1ER1BVX1BURV9NVFlQRV9HRlgx
Ml9NQVNLKSkgfCAoZmxhZ3MpKQ0KDQpXaGljaCBvZiB0aGUgYWJvdmUgdHdvIG1ldGhvZHMgZG8g
eW91IHRoaW5rIGlzIG1vcmUgc3VpdGFibGU/DQpJZiBuZWl0aGVyIG9mIHRoZXNlIG1ldGhvZHMg
YXJlIHN1aXRhYmxlLCBkbyB5b3UgaGF2ZSBhbnkgb3RoZXIgc3VnZ2VzdGlvbnM/DQoNCg0KQmVz
dCBSZWdhcmRzLA0KU2hhbmUNCg0KPg0KPiBBbGV4DQo+DQo+ID4NCj4gPiAgfQ0KPiA+DQo+ID4g
LS0NCj4gPiAyLjI1LjENCj4gPg0K
