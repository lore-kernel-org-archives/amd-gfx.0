Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E903BC25B75
	for <amd-gfx@archiver.kernel.org>; Mon, 27 May 2024 03:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03F5C10F692;
	Mon, 27 May 2024 03:11:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L+h+SK1x";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6C3A10F692
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 May 2024 03:11:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0JNg0j/9J3QRJoE00+oAx1X20SLe7GIDdh2wyF2RdvfwMb9A7s4NioJdU8kxS2aFVK8+v8y2TNsQASn3Hntw/Ejj9HdVQvdHsvJVyFw2MORPlKcFk//5Hvjz1ydNxzDum2SUbE7L8bv4E5MgwfCXquCUzJ5eFu3FDl7BWVrnK0GQTX9xLfOxNtmC6Y55suOQZLnXUNTZj6dWS2wkYa0fvkRNe2ejwPy+DPS9XtEsSy1gbpxxxjdRw90s+Ya5s8vgIDYJkU0Krn+EepMmoO24vq514i1Sr5ui0tC/PzbV4Ro3EJlP3URpGApkT0zeQ5vtbpdgRp6oXWztNiduccKXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xN118Ryaysa2rzMBDgRT9RrDnN7lxn+Lp/WE1iJgqic=;
 b=Z3npgWoqoeY2b+GkRptgC+ADh+X/p0MMXOtYe5pnMzGqln42RE+PdUvkHYG2TGMgWXfhUtLEO0WnjjlPkxEYkimT3CZdHvQcG7P/vW5PoS5xeFS69MXseV6PF1KnoFVa/tJos2F4KqgOmyPTakM4SClYtcOadO8kWzF8v8uGktO0xVD79BZ4ncEackAHGqtYWQR8Roq9Kdw1Jwyvzmvm1mmm8OQP66r6NJnp+OuJkgC09b3uI9a5oKgU16LER0UEwo4sp7SYv7Y0SiZa1gPgdlRd8eCV3GkLk7945CDEAc7ZLFEss18ORlE8/GDn6/muu1NrCc6Dp7YaCC9IZJ9nNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xN118Ryaysa2rzMBDgRT9RrDnN7lxn+Lp/WE1iJgqic=;
 b=L+h+SK1xPsj26HcIJD6b4YBkb3kKPZxE8JaU05+Jj1MWULnnmDQJkbxPYgyOv/ZlqQlljZk1LsmnCK0553XdAcQQkByUXa6h8n96IIROqsrVYc3ILxXkpfmKHtZvPeJVBg4AzRt/zmEVbZFSbXHHV6/T5dXRf2DZesxN4jZ/w/o=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 03:10:59 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8c7e:a1a7:74ac:29a8]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8c7e:a1a7:74ac:29a8%5]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 03:10:59 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Revert "drm/amdkfd: fix gfx_target_version for certain
 11.0.3 devices"
Thread-Topic: [PATCH] Revert "drm/amdkfd: fix gfx_target_version for certain
 11.0.3 devices"
Thread-Index: AQHaquXz3dcFbdM0yEGUpVHg5Rm2+7GlLKEAgAVEclA=
Date: Mon, 27 May 2024 03:10:59 +0000
Message-ID: <CH2PR12MB4152EB2599D23E9ADD7D6342FEF02@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20240520184538.2711265-1-alexander.deucher@amd.com>
 <CADnq5_PJu4r2yyK5RgUqL9n0W=UnGdmpjj91H_mwGjN+w3zcaA@mail.gmail.com>
In-Reply-To: <CADnq5_PJu4r2yyK5RgUqL9n0W=UnGdmpjj91H_mwGjN+w3zcaA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7c3d6395-7466-4513-9b88-ba934b07ab66;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-27T03:10:32Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|BL3PR12MB6522:EE_
x-ms-office365-filtering-correlation-id: 299d0ff8-faa0-4896-4af0-08dc7dfaa1e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?eG1SRmZoQkxJb0pyWDIyNFltM0MzaWtaNW9COXJHWnBFdjN1YWQ4dGRFc3BO?=
 =?utf-8?B?RExTODNpMU04eDgxcFluZmY3dVV2R3dNRUt5LytGaHVhVjV2ZmZ4eVk3c2Jt?=
 =?utf-8?B?b09pS0tLeDFxWlBCOW8rRTB2WTZjZVRMUWJxb1FMdytTNURLUDk4ajdObnlP?=
 =?utf-8?B?bUtvMGF1SjZoMTV0dmU4RTBlQm0wLzNvY1NWb0VISHV2RDlweHRaYy9QUkVm?=
 =?utf-8?B?dXI4akNTbzFjTDdnUjBuYTY0Z1BoVm1ROEJvQ2tPUmR5elcxSlM5VDJvZnYz?=
 =?utf-8?B?TEdaOGdKZ0tNSEd3alpsS1h6VExQT2VJL3R0N1J1WTJJK0NYUHM1ZUh0bWw4?=
 =?utf-8?B?RytlS1ozRkZKTWw0cG5ES0Zka3RhbnA4WmYrWlgxeEZSVExsZXBTY3V3VU96?=
 =?utf-8?B?ekNyM0UwSlgxeDJhUjRkcW5TWnc5VnNnb0g3TmZ0a0F5UE9kbURpQkg2ajhn?=
 =?utf-8?B?ZURuR0pIYjdMRTkyR3dWTkN1VFJZajdLL3ozK3pGK2QvNXhiQXZZV3ovWGxO?=
 =?utf-8?B?SVE0R0Mzdm40d2lnOWlpS01KRU9zL0k4S01yaHc1Qm51YlU4alloZmNYR21B?=
 =?utf-8?B?V1NIa25BUG9LVDB0ZXd0a3Q0RGhzMUZvdmRjUnVpSFZxeU5WYWQyd2ZHS3gw?=
 =?utf-8?B?Qll0eTFPWS9jSk5sc1lKcWdCV0NUVHUwVUcyWk9RVHZkV1JVdVJKNVVEMzBq?=
 =?utf-8?B?ekR6UFdzWTFKRC9LNHA2dnN2V2xFV3ZXMldMS3ZraEpxUkVtRFFWS1lZL2lU?=
 =?utf-8?B?ZDV3MFUwMjFtcFVHNytmb2wxeEMxQjVMMjNUazRSb0NCZFhJVGpZcmF3dEEx?=
 =?utf-8?B?T2taa0dPTEN4YlZ3SWIwaHR4dVpJZUFpQ3NhUW9QRDBiN2pJekRQZWhtQTY4?=
 =?utf-8?B?Z2NGUjRmL3MrQ1BFZmZsWlhuVWN2MkpiV01TdnlSQU1sb3BOaFJlczZQMGV3?=
 =?utf-8?B?Zk9rRE8rdmVUOHJPYVVhb2pvU1AyeWtiTGh6bkVIc1U4VG5rVUNyekJOYmh2?=
 =?utf-8?B?L0h0TThMcXA4cUhLaGcvTnpUVUE4QThoZnliZXdkQjcvM0F2UGZqVVV4RE1T?=
 =?utf-8?B?T1JlaEl2THBFamhJdWEyakw0TFB5c1Z2cmZaS29UZkNyZFBnZ3ROZHA1STNl?=
 =?utf-8?B?R0tYMzh6SHluZzNWYm9keks0eVNGRm5vcHZkR1E3aTdaQ0pEYVJqSEFXUHR1?=
 =?utf-8?B?NjdXY2VueUlSeWYvdTRDR3IxbzJTSkRJRmI5Wi9zbGlPcFBRV2hmV1RNVVp3?=
 =?utf-8?B?K290MHB0UjgzaG1qZmFHV0dKUXVYcE1mYTY0d0ZzcnJ3anE0VXh3VUUxc1A2?=
 =?utf-8?B?QSsxb1ZmTm10S2txOGNPWmd0bW1xajhicUdYZjZjU20yeHFVUFN5bGVZQ0ZB?=
 =?utf-8?B?c3hKYk91Q1pYcDlLNHVQK3V6emNhcUdRRHhBcEdoL1NCbTRyWVFlWWJhYmlW?=
 =?utf-8?B?N1VGL2w1MFlCeDRZbEcvcC9aWUVmbkYrUUs2UUlBR1hYNlp1eDF0U0ZGUGF0?=
 =?utf-8?B?R00xeVlhT1dqUFR3QXRGcE8wa1NoY0ljVjBVOHh3OEVLdmhRZXRselNEd2xu?=
 =?utf-8?B?TlplY01PeVpSUGtZdS9FZDZMb3dndEhVSGFWUHRGWUN5ME1YdWNkOXJCQUhv?=
 =?utf-8?B?dGlCM0FpVGJxRjJVLzJPTDJyR1luRzhteCtNV1RVYU1sL29ubXRoRHFSQ3hs?=
 =?utf-8?B?d3JCZFg4RDBWTUFGNUtHZE12UkFnVFVQK04wem1vQlVCSWkxT1hiSThFektC?=
 =?utf-8?B?VUZxbzdzTzFIQ2svOU5nU2NXZDV5Zms0ODJUMkg5TUVDWmswVXZnSmQ4dGNL?=
 =?utf-8?B?NFhNOS9LMTFNTWo3ZE5LQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEtQOHNMZm1JZnk2bjIvTFRIWmxCbmJZTEdqS054TjMrNTlOUkRXeS9GN0tK?=
 =?utf-8?B?SzJRNWFMa0tKVWt4OVV5TEhzMWRjMnhabmVoZDlyeHIvVEFMbUVyd3FhcDAr?=
 =?utf-8?B?bVV5bXVialpCMHErT2cxNGhjVlhGR3lXby9jRmU1R3F2QVgxR3BBU0RWNWNE?=
 =?utf-8?B?M3lXZWZ6bnhTUkdQZU5COGdhNTZKQURiYzJlWnB3YVF6SkRnT2ljQ0Y4VmRB?=
 =?utf-8?B?dnJqS0dYZVBnV01NS2xIRE1VeUoxdEVkZmM1eHNWNHVHSGp1WXExZHdjNjRz?=
 =?utf-8?B?RVJVUlFRVHF3bE5KNzkyRkFtVXFmUW5NQU54MDM4THlueE4vQkdWUUNmL2ty?=
 =?utf-8?B?aTZ3aUltNFRBcGQyRS8xUW5HSTVEa1V3bExvSWZGWHpLbTdOREJSRmIzSERG?=
 =?utf-8?B?R08ra3hmUCtqNFZqd2RkNVJScjhxU3pGUG8ybTZwaE9lQ0FjNFRNRjYwS1hD?=
 =?utf-8?B?aXpEZGZiWDVvNXhiWjZIUmJWc2dSQW9zUXZaQkRZaGtidnZOcHV5Q09sNWQr?=
 =?utf-8?B?QU5UeVVsa2NxaG4yKzFsUFZadHZWR1RnMVViY3JSanZxVStHdFNZc3BGT0Zq?=
 =?utf-8?B?KzhKUWoweDJNd1lFWE9UOUdISE1VZWdKck5lK0x6OGY1RWxxdVZtcVlQdGFk?=
 =?utf-8?B?OEVMd0FCdWtyam5GN2F2NzFPclJmc0VrdWNlNWVuYlZIcXliUjM4aEg1VFIr?=
 =?utf-8?B?Z0FrU0RidkEvQ0xyQzZuSmxVY2FEUVN3RURpbDhVcEd2RCtxUFAyaTk2MWxL?=
 =?utf-8?B?S3NGbFA0YlVYWnFmOWtIaXljaVJGeVZVYlc1SmppbVRteGZrN1NvSXJMY1E3?=
 =?utf-8?B?d0tnL2pZOCtBbTZraldrc1ZJcUNQOXFjY09qT3h0bWFNVUFNN281a1VJVUR5?=
 =?utf-8?B?djRLYjF2Y2pCRnNiM0J2L092SGEvQTl3TFYwdE9ER0dDYkRHZGxmM1E5a1Mz?=
 =?utf-8?B?b0hDWk5xb1JBajducjVSQ1B3MWltb1RXbWQ5MUJYaVlHMmhFUGpPdklyTmMw?=
 =?utf-8?B?MTNpQWs3eC92NW14QXRRZlcrUTQ0NFc0R0ZGWU52Ym1xemVudjRWZzZVVEdB?=
 =?utf-8?B?bGdUQ0pDdHV3UnZEQUVWbVVUbmRiekhpd2JuZ0dwcVBOb25RRHduV1RHMUla?=
 =?utf-8?B?cXBjNWdTQllPR0hLdTRCd29nOEFHUDdIM2l0QTBSZ0xPSlZ4Y2hxd0lDeHNJ?=
 =?utf-8?B?dHpwbTlKMUtoRWRiMEFnQXV4MkJ4bUt5T2RnSllUTjVkRmZGNFVKWUhoQ1Bt?=
 =?utf-8?B?WjlqVHo1c2hQL05EVm9sWVVhdWxNMlNMUFZoTEhQUUdNa2dhcjRqak1QZ1lF?=
 =?utf-8?B?OXA1MTY4RzVaS3lkd0NOWWVYKzRZNGRaQ3NSWW1NZG44OGptOHhkLzBHK2tx?=
 =?utf-8?B?R2tZdFhXRkg5SjRId1BZODMwd0NST1FpZE9reVNQM2VzTE5MdjlMWG9PSWJK?=
 =?utf-8?B?b0JiNTlRbHZja2VoKy81S0ZZL0ZIeDdsL0FTbkg2Q0prd25wWHkxMWVxNUM4?=
 =?utf-8?B?elFSRWpZQ09BcEpubE52MTIrSDZvUHBzUTcvcjFWWGxtY0tMZnRuQjBSZmlo?=
 =?utf-8?B?b0dsQ3d2MlA0MWNZb2Q3L0RYRCtUdjlYdEIzcE5NdEp2QnQ3R2IyWUJFTXRC?=
 =?utf-8?B?am9oMWczVFVYK1NFTy9WVEN1NCtWMlE0ZFA1VXd1SGNrL0QyWFFDNUxoVlZM?=
 =?utf-8?B?MjIwZTRYUmxzb2M0dndRQ3kvczhuL240VDAwUnZXQlMrTFVpRnd4RS9FeHNt?=
 =?utf-8?B?Y3hNL2Zxa2dtcGN4Nnh4U05BUnhrSG15dWd5ZWRwSWlNQ2ZPQzBrSEdUeGpa?=
 =?utf-8?B?QlA3ZTU3VTNxL1JsS0FTaEhETmZxMDJRRkp2V2ROem5WZURoM1FXSnpTRTdU?=
 =?utf-8?B?WEo1ZklPdkxyaFZ5dWllVkRPTklPOUtxb2FMaVcrN1BkZUY4OGNSM1JKamJW?=
 =?utf-8?B?aENVdWwyL283YkEzNVlkYjlDVjQwajNaNXQ5dEhhRGlCdGUvNEpZRVdPMnRC?=
 =?utf-8?B?TytxZVdUZXFPU2dXS3g5UlZycFM2WVRqL0h1UWwwR1hSZzNLSXlqZnlnUDQx?=
 =?utf-8?B?VG5ka0tuL3ArNXZIUXFWQWZydzdmRUkwMkVWTEhRbFJmTzNBa3NROU5SSkNv?=
 =?utf-8?Q?ogEI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299d0ff8-faa0-4896-4af0-08dc7dfaa1e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 03:10:59.0981 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yla2lzPpK7DUyUqGswNbEBFw2zUpMBOyTLcfEjLVJ9Mbn6MydPcwTCTmQ5kkOhNK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522
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
Cg0KUmV2aWV3ZWQtYnk6IEZlaWZlaSBYdSA8RmVpZmVpLlh1QGFtZC5jb20+DQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWls
LmNvbT4NClNlbnQ6IEZyaWRheSwgTWF5IDI0LCAyMDI0IDI6NDQgQU0NClRvOiBEZXVjaGVyLCBB
bGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmc7IFh1LCBGZWlmZWkgPEZlaWZlaS5YdUBhbWQuY29tPg0KU3ViamVjdDog
UmU6IFtQQVRDSF0gUmV2ZXJ0ICJkcm0vYW1ka2ZkOiBmaXggZ2Z4X3RhcmdldF92ZXJzaW9uIGZv
ciBjZXJ0YWluIDExLjAuMyBkZXZpY2VzIg0KDQpQaW5nPw0KDQpPbiBNb24sIE1heSAyMCwgMjAy
NCBhdCAyOjUy4oCvUE0gQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPiB3
cm90ZToNCj4NCj4gVGhpcyByZXZlcnRzIGNvbW1pdCAyOGViYmI0OTgxY2IxZmFkMTJlMGIxMjI3
ZGJlY2M4ODgxMGIxZWU4Lg0KPg0KPiBSZXZlcnQgdGhpcyBjb21taXQgYXMgYXBwYXJlbnRseSB0
aGUgTExWTSBjb2RlIHRvIHRha2UgYWR2YW50YWdlIG9mDQo+IHRoaXMgbmV2ZXIgbGFuZGVkLg0K
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+DQo+IENjOiBGZWlmZWkgWHUgPGZlaWZlaS54dUBhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYyB8IDExICsrLS0tLS0tLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jDQo+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jDQo+IGluZGV4IDZiMTVlNTU4MTFi
NjkuLmZiYTliOWEyNThhNTAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9kZXZpY2UuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
ZGV2aWNlLmMNCj4gQEAgLTQyNiwxNSArNDI2LDggQEAgc3RydWN0IGtmZF9kZXYgKmtnZDJrZmRf
cHJvYmUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGJvb2wgdmYpDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIGYyZyA9ICZnZnhfdjExX2tmZDJrZ2Q7DQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgIGJyZWFrOw0KPiAgICAgICAgICAgICAgICAgY2FzZSBJUF9WRVJTSU9OKDExLCAwLCAz
KToNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgaWYgKChhZGV2LT5wZGV2LT5kZXZpY2UgPT0g
MHg3NDYwICYmDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgYWRldi0+cGRldi0+cmV2
aXNpb24gPT0gMHgwMCkgfHwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgIChhZGV2LT5w
ZGV2LT5kZXZpY2UgPT0gMHg3NDYxICYmDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
YWRldi0+cGRldi0+cmV2aXNpb24gPT0gMHgwMCkpDQo+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgLyogTm90ZTogQ29tcGlsZXIgdmVyc2lvbiBpcyAxMS4wLjUgd2hpbGUgSFcgdmVy
c2lvbiBpcyAxMS4wLjMgKi8NCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnZnhf
dGFyZ2V0X3ZlcnNpb24gPSAxMTAwMDU7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIGVsc2UN
Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvKiBOb3RlOiBDb21waWxlciB2ZXJz
aW9uIGlzIDExLjAuMSB3aGlsZSBIVyB2ZXJzaW9uIGlzIDExLjAuMyAqLw0KPiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGdmeF90YXJnZXRfdmVyc2lvbiA9IDExMDAwMTsNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgLyogTm90ZTogQ29tcGlsZXIgdmVyc2lvbiBpcyAxMS4wLjEg
d2hpbGUgSFcgdmVyc2lvbiBpcyAxMS4wLjMgKi8NCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
Z2Z4X3RhcmdldF92ZXJzaW9uID0gMTEwMDAxOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICBm
MmcgPSAmZ2Z4X3YxMV9rZmQya2dkOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsN
Cj4gICAgICAgICAgICAgICAgIGNhc2UgSVBfVkVSU0lPTigxMSwgNSwgMCk6DQo+IC0tDQo+IDIu
NDUuMQ0KPg0K
