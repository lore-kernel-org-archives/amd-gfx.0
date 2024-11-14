Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31CDD65C46
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2024 06:34:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F92F10E13C;
	Thu, 14 Nov 2024 06:34:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bF5VOvYp";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43EDC10E13C
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2024 06:34:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jpy0HALiSC2wVGlYRCmLN+NRslEPoY5poE887B1B3JRZxwFSUWBocC3CS0pYH03+L/1ylcV3F9hJ+fA5RhWHSYoJnbf8Ug/m7YYEYIPjMo5qZbNKDpbITKBuA1uqpmHJBPVm4NQrcGzZWVzlPSd6TSADa91Qq/1TTUJDD8LYbDPcuBil1Y940iDzKqaZDVPcYrpBEpQCzd8Jj7Lxz6/F0Wcr3PVB/I+XVjpcf77V18OAjo4tQtr/PCYw1047tC1G9U0/HTtvnlG6fC0yBK/GogvFIz8hd98OGIvRVoi7sQ+ibZgb0H1NcPlZX0FzKX97mEFd/Mgi10OQcyG7GE0ltQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDZKUMW8mg74jvsTZrgYFaq010W/Tomd6f4bsEefKOc=;
 b=AeD3WYeUgYTga/ZLwRQVz3+L5ijgMar6bbpK1GUQqWO12voIoJGlVTgNvX+EhxqEUJoPg0L+f9QLeyibrxcun122SkS79ZU4E2UjGryINW+Pr+/9enaoA646k3r1fny/UPlEnBJoOzMJ4YoFbdGkrdx5oYk/PmrvVGfLChpi1MdUDDe9DbNiEHelF7ljOqU+xPjryWzpIcDqv58mmb/0D/TY3x3BotymjJjamLB98B/y2Iv31lYkN01z9bRPw36PtqdqrbbkDBfHiyWlWzEkMDf2WKKuzJYXFh3aTxSARc0WaVHfVFYS4mnwRfeVNvfNN3WAt5sM2Dk72nbMOoIKZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDZKUMW8mg74jvsTZrgYFaq010W/Tomd6f4bsEefKOc=;
 b=bF5VOvYpi0xFiLg2Sy+EZW13EhGYNn805arUhIMXqaqB6K0ngOuAnKKEmZOrPuYZLkPBkJrbVm/W1dhweQKS66r3prWUKJhKMQzleSF1JJ69N0/n5LDLgSHGQPZXM6V6HHBtBGQ/pPckVZkNazQAAOqtWKz+PD2ltQ1biaz4GJM=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by SA1PR12MB7318.namprd12.prod.outlook.com (2603:10b6:806:2b3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Thu, 14 Nov
 2024 06:34:15 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%5]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 06:34:15 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: Add missing kdoc 'inst' parameter in
 'amdgpu_device_ip_set_powergating_state'
Thread-Topic: [PATCH] drm/amd/amdgpu: Add missing kdoc 'inst' parameter in
 'amdgpu_device_ip_set_powergating_state'
Thread-Index: AQHbM+OtCt/YkZ2zwk+XdCCGrX0M4LK2VqMg
Date: Thu, 14 Nov 2024 06:34:15 +0000
Message-ID: <IA0PR12MB8208EA2FB6311968DF1E9A03905B2@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20241111024436.1881300-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20241111024436.1881300-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=78214b06-5f60-488f-8486-f4659bdef2da;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-14T06:34:08Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|SA1PR12MB7318:EE_
x-ms-office365-filtering-correlation-id: a8291221-2365-424e-8274-08dd04765c3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?STRqa25jZnZOdlp4TFcwUC8zV0JicVhCVlgyLzBwWU9mUG53aEhWdE90QlVN?=
 =?utf-8?B?NFBVbXY0dEwyZ2J4b2wzQndGbmExeWlkSy93YllFMy8rWG55K3ptcUJMQkYz?=
 =?utf-8?B?Qmk3Yng2OGNycjdvai9pTm56RmIybGhmcjlqOVBZc09Gb0tzTnFpVU9vdndV?=
 =?utf-8?B?c3Ird1E3aG1TdnMvbFJobzVyZXZtaW5qRkduemlkOUs0c3FBTXliazJBOEpG?=
 =?utf-8?B?NVFsTHZlL25KWGdKSGY0d2wrb1hrT0NGY1VYNnJwZVBZNHZCdnY3SkdMTFdW?=
 =?utf-8?B?Z1ExREY4eUVQYTlFVjJMdjZqSDBtUHBmNERPNHR0NmR1NU01TkpmaTQ3SEI4?=
 =?utf-8?B?NU5SYmpiZmtXNzh5eDAxSThUSzNMTjlZMWhPUm1JVFJvMlM4Nm52ZWFnTEYy?=
 =?utf-8?B?NlU0b0N0UkU1a2g5bmh6Y0pHbmRRVFBZenVFK3hIZVRwSE9RbENSNUViRDY5?=
 =?utf-8?B?b2krcTVvODFEUDQ5NkRMcVNzdEtNS1dLeElRUXNGajM1azNzTE9oc0wvVko2?=
 =?utf-8?B?SkdJalIxK1pROENLTXk0dW55MVpzQ3VsTmdIYklueUtRcHNGTUFKMUNNbEFD?=
 =?utf-8?B?ZVJnRnZnamdsK090WFBkZm80cU5FOHluRVk5U1hpcTlFSkltUndRQzdmRnBt?=
 =?utf-8?B?OENsMlduUktMT3lFWkUxSkRNZExkOGhwTTZ2UTdGcDBZWENvTC9FT1RWb0Zt?=
 =?utf-8?B?M3JoNHdSWE0rVmVhbDZlY0ZraDdRTE8za091dXBZNzBXZVY1ZHFYUXlpdmhW?=
 =?utf-8?B?ZEViRGVFQ2NVaFJGdjVlaXBDR2FqNmhFUDVVSC85K2ZrcHdOOVEyVXJnZ3dz?=
 =?utf-8?B?NUVVaTJjbGY2TWZFQWQzM3g0dFFBOGw0eU5SRkVNYTg3UGpFZGlVbUtoU0ZZ?=
 =?utf-8?B?SlpHUFJDeEcwaWZJOFU5Z1krMzY4dnNnZ3phVHdxT2FPK2M2UDFhK2xNOGdI?=
 =?utf-8?B?Tk5lQUR5Ukc1Vnc4eS9jOXdnaGhmK25NSERHZXU1L0FHc1JrdzdMR0kzVkNs?=
 =?utf-8?B?Q0tuTVRSOXhGeUplL3Y5VitNOWZKTVhQNGc4Y0I2ekRBNHVJSHEvdkRnbUdL?=
 =?utf-8?B?SGJZdnlrdkRHdHdSN0NKcklkZHl0bkdkUnFzdWdEY1pNb2F3NCtJa2h1czcy?=
 =?utf-8?B?RDZpWjB2dTlnUEcxV3oydysrUVlGNUoxR2JJbU85MkhEamxCamtGemlHZjQ4?=
 =?utf-8?B?KzlzY0RCMHlOZi9EbE8rWmtUVlAvaHVzSVgzWGsvQkxlOEs2WUFrcFE4d1Ax?=
 =?utf-8?B?NDdQdVdjRmpTd3ByYjZENi8zOEY3NEZHS2l3UWNRTlNqK091N2xGd0pKdDlZ?=
 =?utf-8?B?UXBFT0NENVhYMWRpOEtJeHhjcmk0NHJnRTdEOXhVNjFIZVh0bFdFdDNwKzZi?=
 =?utf-8?B?d0NibHJKcnloOVhjVC96RVUxcG1jVnZZU2hBZVp2M2xta240eVptNzd4MEJy?=
 =?utf-8?B?ZVZ5QnVwbi9lTEM1TzNTcHAyUkcrYjRhZklEenV5dlBtbmJLdURmV3dKOEVG?=
 =?utf-8?B?OCtrTGxIN0YxOXptOVUzbmNJRG42SzB1NEpJMDJOc2YxZ0EwLzNZZDZ4M3Nt?=
 =?utf-8?B?K1h3WEdQK0VTdng2bjZDU2twZUFLTSsrNkJRc2RRb1o5dDlQZXV4Z2FoSWFl?=
 =?utf-8?B?MmFZamlKWGFBb0lZNW43Uk1oRmxFOW91NFZTb3lCUjVWcmordzJNZXVYb0F4?=
 =?utf-8?B?NExhZUhmVTl5WUl5SmhWblJkVWFZNVJOSHZibDNwWlhLVUVKUlVvSnVKRGF5?=
 =?utf-8?B?UXZNVzlRM0VwNUg2OFFmTmwwRmMxaEdSRkJtQ1RiNWdFSkg3cVh3bm54bGV1?=
 =?utf-8?Q?5pBdaEPaJzrCSn++8/DJruu2ZdnA3C4swVf3c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0JDZkJ0dmYwQjQ4UGNmaFQ5N0ZPMHlkeGh6T2xkNDhDa09nM2tLVHgwcWhk?=
 =?utf-8?B?bU56ZmpJdTdpYXgrYnpwTFZiTU8zMnYyVzVTQ3JETDYyZmRkbHErSU9WcVZv?=
 =?utf-8?B?eVM3S0VCYlhhSGdqYzJLSnpDaDlyblZoaklaYkNRL2lqa0huUGNaTmdBeVBV?=
 =?utf-8?B?UzA5MjlBMmVQNEZyWkhQYi9vSHVSelhuUmRpU0RZK2hxV1k1bHRLWGNWajh0?=
 =?utf-8?B?bkxhUkdUaU9KUjNoR0cvcnl1ZXo5emJ5ejBqRjUrR0d1d1k0TDJjMkZTMEZY?=
 =?utf-8?B?MjVoeWZJb0FKYndJR0dkV2JFVzZZakpxdllMR2k4R0NreTZzaHp0RGsvZUlG?=
 =?utf-8?B?WXVwcEMydThsZTVlRlJ6QnJpTy9SWUtCTzZvWDJwQ2ZSKzRiMUJvWGlIMVpm?=
 =?utf-8?B?WFdCNVZUSHVqTDhXNCt6ZnVVbTAyRDVZWmFreElNZFYzcmw3a3kxd3N5NE5p?=
 =?utf-8?B?bmRyTTFwRzg1M2Q4NThramtXSXN6OU5LUGhTSHJ4RUxPZjUrTXRYYzRURTNP?=
 =?utf-8?B?VUxoaExXUzNuUVgxZjZhVHhQTzBST0luelEwdi9mVTBMc2lWNnZkdDVQZ2hh?=
 =?utf-8?B?LzVUNDV6cUJaM2lqQ0tYNEpkeFd5ZGlsUmhBWVFReG5Gak9YYTgzNy9XN1Iv?=
 =?utf-8?B?Q3RVWGtPaTZUQTlKMVFwR1RKWEt1Rk9leWNPSHhxcTJmNXpKR2VjMWpPTU5B?=
 =?utf-8?B?L0RlSTI2WkxsODh6enJXcFl5VlFuK0tLK3lWeWxYQTNDajZmdmdhZkV3OEFB?=
 =?utf-8?B?T0RmUHRnRG1LUSttcys3Y2lSMFdwZ1BDQ3B0ZW9QVXRLbEM1WmluSnpDNGdJ?=
 =?utf-8?B?alpkN0RDWWNYa3lzRkp1SEtHeFhDbzZIY2NsNWlCdXF2WXQyclhTTVNrZ1BQ?=
 =?utf-8?B?YzBVYXFzcmFPOG5iY0hRY2xlYVZSbmJkeHBaOTJwVTZhL2xrRGRHSlhGeXhp?=
 =?utf-8?B?eUF2M0p4SHhlV2R5VW9uT0dBZHNTUndrWEhxY08xbmRwdE5yTzRnUkVSQnRM?=
 =?utf-8?B?V3Fpd1MySkhQak14OHMrQ1dZbWNEczBvWkM0WHlGN285ZjdoZDdYWVplTTRP?=
 =?utf-8?B?VWtSTlIzeGg0eVBvcGpWWTNTM1Q0M0JwQUt0TXJwbUM1ZFNyaHlKdW5HcnV5?=
 =?utf-8?B?Zlpnc3lHZ3VSd2hBaWZWVXB1Lzc5am1SZmMrYUFaVXNkc3JSc3ErdGsvNWhD?=
 =?utf-8?B?NldTamhEVUdobk1ibXM3RVVaaXlEYW9BLzMwTHZ3RCs1Wlc4aW1UdnVaL0tK?=
 =?utf-8?B?Y0JsNDVDaUk0dGM5bm1sN3p5ZUhFdTFiZG1PcXQ4NkQzQldHcmIyQUNGWkRK?=
 =?utf-8?B?NDBEMDN5QjFsM0c0VTdnYWlTMlN5T3dqVmZ2cW1hN2tRTnM5T3gxRGdXUy9i?=
 =?utf-8?B?aWpON1gyYUhaVnhMTnNDa3huRy9meW1JcmhvMFpibTVPOHpRV3BzRDdlUVUr?=
 =?utf-8?B?QjRjY09EeEVmL29xZ3QyMW10RFFvZUFPa3VuRlF4bzBVYklXZ3Jrb05wQ3hC?=
 =?utf-8?B?QUUxWlBuaTNNTFVWSEM2SmtOaThseXBOZFNCM0MwcDFwUCt3SE5yc2xLODh2?=
 =?utf-8?B?akZ2eDg0ZktkTUkvZTRDOHNwbmsrYXFSUlFtZ01wVG1xeERPRzZDZUNkR3pv?=
 =?utf-8?B?eDVORkRaNGFqc1RxLzNsTGRnbktqSDV1N2tiYmRWMVI4RmxUT0Y1bnIzM3hm?=
 =?utf-8?B?YnVFSzA4QkxKaGJ4Tlkrc2loYitFT2xyM0JPQUh1N0FLS29ab2xjbmF4bDJr?=
 =?utf-8?B?bTliVk1PZHlic0l1U2xXcUMzN2dBQldUeG53YUNFc3FJRnNodUJkL0JZbnJF?=
 =?utf-8?B?T1BLRllleG5XMFBCcXAya1FuZ1grQ00rR1lHTFZoSDhja3FPbWZqQitHbXR6?=
 =?utf-8?B?eFBlYmJNakczbTBmT3lKR0I0WkkzOVgwMHJia24rcmhEWXNQUkpMeC9NV3Ri?=
 =?utf-8?B?YVhzZThHU3A4M1lmWDArbENYTUFXWTVaMExIcWk2S0ZUYStJZWUrREg1eGNO?=
 =?utf-8?B?N21wWGwvby9TTnMxaUVKdGdDTGxmL296L2tHTTEwSkNCbllqWFdPbmw1OEpE?=
 =?utf-8?B?MStQRHd2cjdQOU8yMEVtRnkra3paUHhvKzlqbVpiWnppSzZPVUJ2V1lPell0?=
 =?utf-8?Q?2gfw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8291221-2365-424e-8274-08dd04765c3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 06:34:15.6085 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WunaMm2lbQRcXJWc+2BML31QeJ5xqhDfJXVBisIny8ndUnXN43TT36Ge9rymSS0iEvU1x7AMHCW6SlxEy4E1gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7318
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
Cg0KUGluZyE/DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBTSEFOTVVHQU0s
IFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQpTZW50OiBNb25kYXks
IE5vdmVtYmVyIDExLCAyMDI0IDg6MTUgQU0NClRvOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0
aWFuLktvZW5pZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hl
ckBhbWQuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBTSEFOTVVHQU0s
IFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQpTdWJqZWN0OiBbUEFU
Q0hdIGRybS9hbWQvYW1kZ3B1OiBBZGQgbWlzc2luZyBrZG9jICdpbnN0JyBwYXJhbWV0ZXIgaW4g
J2FtZGdwdV9kZXZpY2VfaXBfc2V0X3Bvd2VyZ2F0aW5nX3N0YXRlJw0KDQpGaXhlcyB0aGUgYmVs
b3cgd2l0aCBnY2MgVz0xOg0KZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rldmlj
ZS5jOjIxODI6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBzdHJ1Y3QgbWVtYmVyICdp
bnN0JyBub3QgZGVzY3JpYmVkIGluICdhbWRncHVfZGV2aWNlX2lwX3NldF9wb3dlcmdhdGluZ19z
dGF0ZScNCg0KQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4N
CkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQpTaWduZWQtb2Zm
LWJ5OiBTcmluaXZhc2FuIFNoYW5tdWdhbSA8c3Jpbml2YXNhbi5zaGFubXVnYW1AYW1kLmNvbT4N
Ci0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDUgKysr
LS0NCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQppbmRleCBiYjUzMGRk
MmIzZTMuLjg0Y2RhNDgzNDQ1YiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jDQpAQCAtMjE2Nyw5ICsyMTY3LDEwIEBAIGludCBhbWRncHVfZGV2aWNlX2lw
X3NldF9jbG9ja2dhdGluZ19zdGF0ZSh2b2lkICpkZXYsDQogLyoqDQogICogYW1kZ3B1X2Rldmlj
ZV9pcF9zZXRfcG93ZXJnYXRpbmdfc3RhdGUgLSBzZXQgdGhlIFBHIHN0YXRlDQogICoNCi0gKiBA
ZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50ZXINCisgKiBAZGV2OiAgICAgICAgYW1kZ3B1X2Rldmlj
ZSBwb2ludGVyDQogICogQGJsb2NrX3R5cGU6IFR5cGUgb2YgaGFyZHdhcmUgSVAgKFNNVSwgR0ZY
LCBVVkQsIGV0Yy4pDQotICogQHN0YXRlOiBwb3dlcmdhdGluZyBzdGF0ZSAoZ2F0ZSBvciB1bmdh
dGUpDQorICogQHN0YXRlOiAgICAgIHBvd2VyZ2F0aW5nIHN0YXRlIChnYXRlIG9yIHVuZ2F0ZSkN
CisgKiBAaW5zdDogICAgICAgaW5zdGFuY2Ugb2YgdGhlIGhhcmR3YXJlIElQIGJsb2NrDQogICoN
CiAgKiBTZXRzIHRoZSByZXF1ZXN0ZWQgcG93ZXJnYXRpbmcgc3RhdGUgZm9yIGFsbCBpbnN0YW5j
ZXMgb2YNCiAgKiB0aGUgaGFyZHdhcmUgSVAgc3BlY2lmaWVkLg0KLS0NCjIuMzQuMQ0KDQo=
