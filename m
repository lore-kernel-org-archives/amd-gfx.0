Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60942D26D6F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 16:56:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2E9D10E11E;
	Fri,  9 Jan 2026 16:56:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pVzQ+9M5";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012048.outbound.protection.outlook.com [52.101.53.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F379510E11E
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 16:56:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bSU5MiizqijKs3ShHMj+DTKwuFtlpkGrJpXOTqOosWA6J8bbGn2ZB58ju2Sw970j6tT08krhfWPWFvwZRPf851k82P53xrDvSbVPqsSiOE+sHa9P+hngtNw02eLFYSPEeMerWKayHOYUE7tfQdy1f8aFODva+qZIzNFHJM+WZu0DIPrckOnppZAAUzvq+dToCzHicUQjwQuckxgVQelHKZJiuWKGaC/jQvXE24mWxh/MaGzJOcl021O7e3c1QebJ0SDMV5NcEnIYzu6PCvxCywNXeiRKUpNmhLpAkTwEK0mfXLASZDZT4/yKZohriJloPuVmGzbkq4cDu5i88ATVeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4Zj0WdNeBHvuEcIArg0I4N6BnXmGscxmPpnfbfNkH8=;
 b=HKz6y7DKJIUoaK2ZlB6D3axCGhEBX7s4p9pGqRmHS5DcvUH4K0KByL/vUMBjFIOZI5KQCd+EkvwsmPjZLatY/2pdX+qdHoskP+OjvRqG4PGREYqu8TT8TULL6zwv6Q2uC6Wcx2QCgy0u25lB6/P+/RkH4RSu5WibHlWr+cKCduA85a1xoJXECk84dag2UJl6iI+SCuA8uVCWni/oEsXBhMPB3jHlhZauHVhygFr0aSJnvP93L0eB8wo9biPJkPUdVPt68NMsoBeeVH15yHT/IWM/YVPg0mIOQYQRiqSElU9bzG8rN+SuSNLqdhx7RYkohdGYYvd/2E2pCJ4WFK1aQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4Zj0WdNeBHvuEcIArg0I4N6BnXmGscxmPpnfbfNkH8=;
 b=pVzQ+9M5zhvSKHr/HzvO9kUiXiWfIFKrwUhDdqV/Gt+9BE9y0/nc1Q9Jv/dTBXlGZqa7LjAhkPR2t5CGNCSiIpOcYuoac2As43D8rLTMbDKaJhqJugzQ7Xswc0PCqdkJFOXPYD3rna5lSaPdOx98lefvZx+gU6BN+o1cCFrHiHg=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS0PR12MB6416.namprd12.prod.outlook.com (2603:10b6:8:cb::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.4; Fri, 9 Jan 2026 16:56:18 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.20.9499.004; Fri, 9 Jan 2026
 16:56:17 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Ingyu Jang <ingyujang25@korea.ac.kr>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [Question] Dead code in
 smu7_patch_dependency_tables_with_leakage()?
Thread-Topic: [Question] Dead code in
 smu7_patch_dependency_tables_with_leakage()?
Thread-Index: AQHcgYW275KApxDHDUGv6QO9HjAXdrVKDhbQ
Date: Fri, 9 Jan 2026 16:56:17 +0000
Message-ID: <BL1PR12MB51443B02293AA31A924754C6F782A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20260109163330.3019080-1-ingyujang25@korea.ac.kr>
In-Reply-To: <20260109163330.3019080-1-ingyujang25@korea.ac.kr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-09T16:54:14.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS0PR12MB6416:EE_
x-ms-office365-filtering-correlation-id: 781aaa41-134e-48f3-bb39-08de4fa001e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?NUQd3XXAOh6tgXrMBW4ubwH132DPzk4NsprA0Tlh1D7Ck44YcU2/B0968VHP?=
 =?us-ascii?Q?ZK/ueRKcM2+KxczsySwcz9DWyf/YCln7BlnRT54XAdsYw1wdi9imQLppI0Yc?=
 =?us-ascii?Q?9GdtDJn3rvDVQ1TyftP3a2tHfj6G+tpMajy4I02OX/1rqWl+/0NgJsNebcup?=
 =?us-ascii?Q?Z98JFe62cb2LPFAzkwuWb7Fu1uSuIgwyALIjkorI98FkBZTqlkaXwxgNcMqA?=
 =?us-ascii?Q?wVNPwScGF8rVMMd/iNR9fv7AoxEi0oUhC0s1zEoRZ2rXXliYfbTGvYu/ZCXq?=
 =?us-ascii?Q?5q2CKdH5MMTxLHDpWRx72Of6ZmAtP7RrGid1dWC14OliK2YMhyISUSRvA/7K?=
 =?us-ascii?Q?OqGe8HHkt9q6sxsUr9i8lgwbMvCKCU8emrOXvqukDV9r3ZZ97LNMufg3h+kT?=
 =?us-ascii?Q?CAhgj+SDa3AuV5OprV+35JVWmJlUARPpGJrabp7XqNyCeKFmLWoLAOEARlvy?=
 =?us-ascii?Q?mEE3wMZqBDQ+3PFv72oRIoR4ocGAttqyLCcFXUlVIKJp1tDSgwqLkiUzd2DQ?=
 =?us-ascii?Q?NCEBJ85B9WiK2CrCiwlapUG+Isfq5JAXCOmGmkOPznM2tK5T6GAaBtC7JfXv?=
 =?us-ascii?Q?a7rEJxhXZ4mA5h9HzmFRxT3SAnc/91PKcIuWtO9q1F/3hB2s+GV+do06vmQu?=
 =?us-ascii?Q?ySuNesIVzmMj+3MUIgE/95MJRhndRK+GTnj4FU8QD+g1tW2NS/MHbrklUOIF?=
 =?us-ascii?Q?RFNzNd6AY4VfYKxsW1sySw5cW966X6jvV6VJzMSbGbLIF4pVRNS/7cmB0T7h?=
 =?us-ascii?Q?xmC1wMIOe2VEW4mN2/xMUp7cS7R6i4CbMevMc7ZIoiSFvQGSusKbOvzO//9u?=
 =?us-ascii?Q?kX7ZNlVlhsHj2maZtkiXR/AeWbEa1RxqXJN0oAdNumLerFiOE+xN0gfrU4NS?=
 =?us-ascii?Q?IyfTqdoSNdbqvuEje1HwM3LHZQ1ucX0eokK8m7wayLp/3GGdOOxDv7XB1lWc?=
 =?us-ascii?Q?vn8kALMVAcUDQNvRleVWMORqHVz9RIflQPCN1114IPziBJDQRcUA0X7Gz2sg?=
 =?us-ascii?Q?hLm29s4atpwUoyGPQVvYlJHEmnjVuj98DwG1tZOzMjZyeXUoLpmZ4IOeL/IV?=
 =?us-ascii?Q?df2KGfkTwfOwzKEDWtjh2rzDyhhS6Wumt8rqOP0vCBO6UvSdj+Fo4h57452g?=
 =?us-ascii?Q?HD6wKJ6FhQu3Tk1VCqMVHYMbCmvdybvrn5PhAjMGddtf30uPDshfkFOD7aR6?=
 =?us-ascii?Q?HTUaHfZaJU1ZHj1Ie3DL3lLnt1iR9FK1QpbwrPh0nkLXbUMjNHTzHlv6+lQY?=
 =?us-ascii?Q?5rUeQpDmGpD/bCUafUqQBMhKfXNu3/M4uJqeKSyOZmeDw3G6UxdYWe5CUR9S?=
 =?us-ascii?Q?Roc+XUQ96H+WHv58I7qGvrrQ1rNIZUa5hIrF1e9axZH+XISQrhWUG+glFnpT?=
 =?us-ascii?Q?J8dFH9rl4Zp0b/vQncBDXzGUKgTdFCGPJjO4dPr2JH0j/QwEGTy9z0vfFLkK?=
 =?us-ascii?Q?Q0w09d+6gAu2hcjDO05g0+nUCOeD2ibIPLRpePmYzJWZgqvm/1eKHHRMZxOp?=
 =?us-ascii?Q?tMwrlele5e7R0uJjh2/4RFAzkF0kBpMVtyCW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hz9KSlF0rZ3jTWKOtOYoRQfG/lsKm4f5VxSQxxZAdIWCXijH1lUJ7/pyYEqs?=
 =?us-ascii?Q?BVXtjgHxtQyGEXR8bBC2GtrYx8ugUkNvUmlTL5BVYd/thnM3Exi6hjRsk/ou?=
 =?us-ascii?Q?GH3BTUs8onrLSBnOyhIwiM5jhOvbLGMWcj7MkFyEXFGV3OMD5ec8b9GsVHrg?=
 =?us-ascii?Q?b45gfHMp7BzTM4KVdjPxfZUhVLPwqbkUzO4p5R1w/mCIqHIWX79pp9PVPEXI?=
 =?us-ascii?Q?KqUk4cgWux0itvDp/W/9n6CRaRjFnke5IQ5xLELkZHgk/d/iRtrwNJ3Ji2rY?=
 =?us-ascii?Q?o+R8xNtjQ5xRc8a4vMR8Q3EqQqM+qM3AJ049gJxkwutQOm+h6jzd3iJzTqnp?=
 =?us-ascii?Q?GMftCAr44OrLbz6H0UvNUiGFzZs6wqwwqZGm4As5Py8iy7RLMQtHFVbG5gjv?=
 =?us-ascii?Q?3MJ+2LLbcraHwj5/ObpTkgp7kEQ4FhdYb/jxREssHEU0pKeRqMEjyDNYHhQk?=
 =?us-ascii?Q?D8nthanYd6qMWL+DOXRrPda455N5ltVriEGfihg0718txTCcwDMFk1+KwX6u?=
 =?us-ascii?Q?7dXLqF/b2HVzt/o2DQy76u3RvTw2mpYDewDR/clPIacDkq/YLWV6nQlVJmKT?=
 =?us-ascii?Q?8sWKlBgab823t2i0C0tM5H0Sr2cZAkRJlWvULiuRUH2V9dw8GZcKmGG8PSg9?=
 =?us-ascii?Q?kanF14K3oZeZGiYioQ615r6UdhRARoYAySMeJ+wKO8gFRuSay3VfC2H9bIsW?=
 =?us-ascii?Q?DupZ51XZqK0MXvHxxAZBbCDENzPG+X6BY72XC2sSdKcAgKwRUWVgPN0y9DyF?=
 =?us-ascii?Q?5m15KbI1o1SkonCWbISHlb4U0+QZ6j5d9pKNXWnARtVN6EubtHAMg1seyZpF?=
 =?us-ascii?Q?4ZdwbW5jbFbDVhNbdUyvxWqsBvnRyk10lKZagF5/smbjoWLEUpSFa7ht4M+e?=
 =?us-ascii?Q?yOV2Xz+EbTUhEWMoeTulUaI4+c006cbCiVuTJzMlKucJa7cLKE1bpsUfjrmQ?=
 =?us-ascii?Q?SZgrfElsiUciHS28/OnWu0+rLsB5KjFTeUUnNaKJMcq+wcb1iPI5feeBBfDP?=
 =?us-ascii?Q?nCR4GCQvwdnZ1NE/nRX2FXCYJj8pDxfEqmVrJCw4rxNTWfXXPjG7s4yt9d0d?=
 =?us-ascii?Q?CLDOpGX88Ufmdi3qYKyRndDRZb3yGuQ4EgLyDrpRXQQ+7N7pyiI3K1ptIWxZ?=
 =?us-ascii?Q?BWzFXFCkWMvEdvtTQYAZfpHWJEKLrPBcteELI3qL6JcmY6bC5gA+dylaQ7uO?=
 =?us-ascii?Q?ZpQvOWjmU0no7CqqDf89cOUaw14yQUyyO+ZYWNfEPbwc2KeMyJEoI4ZdCgjm?=
 =?us-ascii?Q?GSKoR4ryDVQznsCVo0Zcbwh0Y9dac3mKJFQkPXGbbY0z49rkV+BUrN7DHfPB?=
 =?us-ascii?Q?Cjk4M+wx6vNlmfltOYTfrB9MvbKKMu5b3/fRBHd/boaRNgqLgBcrYMuThKW8?=
 =?us-ascii?Q?zR4wwRj/UWb7ak71dGDPF8Rvl1b3cIAe2jdP/c41GZET0dL7v4TbLePKEYQx?=
 =?us-ascii?Q?pPR7nlcWEaoq+b0RWruozlmDsYXnf8COZ8q9Hooq0VR/zTTS6GpJbwRMgf04?=
 =?us-ascii?Q?iOZFsYfxXxf3Vi/nFRBrt6QoqFkVFlp11i4QVmG/THRUfXxURmeAS3wX864H?=
 =?us-ascii?Q?opTgfI737LXIS3xNsOPIsho6vYH/yfMqwT9ZAPCHDWdoS0EE4Y2hTBQmj8x3?=
 =?us-ascii?Q?hSOepNRj7Vx4mOPOWJPSjCYdJNV8T0dyCAaYIWJj+A0Rg9YzDKhkj6zFyUrq?=
 =?us-ascii?Q?RHzyqM8zjrhndKdl6nyQBKtipxgSfxsGEFHaQMcv3R2/s4Ze?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 781aaa41-134e-48f3-bb39-08de4fa001e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 16:56:17.8139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0p+rzdXAPdpZhSZGlS20aES8x+GXY6zXwyX2w3KQOUyUhdtzJCoymCdJ22+wUfd7WofC7LNN1EI8sP2ieW9F2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6416
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

[Public]

> -----Original Message-----
> From: Ingyu Jang <ingyujang25@korea.ac.kr>
> Sent: Friday, January 9, 2026 11:34 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Ingyu Jang <ingyujang25@korea.ac.kr>
> Subject: [Question] Dead code in
> smu7_patch_dependency_tables_with_leakage()?
>
> Hi,
>
> I noticed that in
> drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c,
> the function smu7_patch_dependency_tables_with_leakage() checks the
> return values of 12 patch functions:
>
>   - smu7_patch_vddc()
>   - smu7_patch_vddci()
>   - smu7_patch_vce_vddc()
>   - smu7_patch_uvd_vddc()
>   - smu7_patch_vddc_shed_limit()
>   - smu7_patch_samu_vddc()
>   - smu7_patch_acp_vddc()
>   - smu7_patch_limits_vddc() (called twice)
>   - smu7_patch_cac_vddc()
>
> However, all of these functions always return 0. They call
> smu7_patch_ppt_v0_with_vdd_leakage() which is a void function, and there
> are no error paths in any of the patch functions.
>
> Is this intentional defensive coding for potential future changes, or cou=
ld this
> be cleaned up?

I assume it was just there in case one of them could fail, but ultimately, =
they didn't.  smu7 is over 10 years old at this point, so there is no likel=
y to be any changes. If you'd like to clean that up, feel free to send out =
patches.

Alex

