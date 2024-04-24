Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E48CC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 13:13:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6AE710ED1E;
	Wed, 24 Apr 2024 13:13:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4sV24Nh/";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF30C10ED1E
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 13:13:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qt9wGZJEeuQn/f4guPH0UDUIhx6z8feMfS7dSmeErknRGGpbZSn/LjSTZWtBP265cUPeVlzcKW8MfSHvWPFq+NGpFCz8giapNf9DC5/lPnRNuRDF8+Vgepk1/RCrZg3luFV7KkliTMaimP8G8HySlTIxhaxpQNiweYWwHxRYNj2Lclrk2Qf/UeiaJC6zyOuA4nmM3Q4ZM7zk+CLXajXyH2OwaHLBxjDUl4oVJQHFeEIpMlGlyafmtEMd8JhLT1NbaXbK0LcXTxYxNb5Oiv1zgjJS/JQ4Df/dKnxBeQtcu9R6BNOwhrkT1UpANMJMDv0x2l/AUQWreJUWLHsG/KDwqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLZB4K3yZUlv/eanOySbZS2noWfDdjac8Q+6XjMLnF8=;
 b=NmRBlBnvfXvi6uq+1RkExRBOFdA84IARGRFnIseiJyDsX7KfNeGj4PtD3WwM1FCyk2APP7VkSjJqFNFw2zTKl3dU5uD7nq2RUSNUJx9TeTAaildJFSOHpiKnfXN1nW/rUSmmw7shEQPEJfFmiqEQAO738kpnUV/mb3AqH83YJiLnJFhZrPHLbmLN0+5y4BAQ/RD03mXB3/84dPbdxDibo2K2CkcTWIjjhnX3cxyxRCPQRsyhNl+ohUZ9tduSUBfC2kAbhP8EzdbkD7GTQPdd0EeqNKxC9X5Rj5Hphx34d7T6qOijKeLMfxvRiEOrIeNnQO9VXK2cMdWm+sjgMiUnvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLZB4K3yZUlv/eanOySbZS2noWfDdjac8Q+6XjMLnF8=;
 b=4sV24Nh/iGLJe3lbvskB/Gpdxu9ezyZOazMwlYBwYjuYTX7mYBPfzkjom7S+08cw7p3bQxho11Xnpp2hUrluQVNyWfv8kSvV898GvlgCAQUaPrR/2MqtR7xDXS4DnVVL00swx6dFV0xe8b+OhTw0Om+PAdpQNst8dkStbB6hTsg=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 13:13:28 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b%4]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 13:13:28 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix two reset triggered in a row
Thread-Topic: [PATCH] drm/amdgpu: Fix two reset triggered in a row
Thread-Index: AQHalO23YeZJ9BFN8k+8ihSpKZPttrF1WoMAgADNN4CAAM0KgIAAcuIQ
Date: Wed, 24 Apr 2024 13:13:28 +0000
Message-ID: <SA1PR12MB85997F18F0D3FCBF528AAFA5ED102@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <20240422194550.26148-1-Yunxiang.Li@amd.com>
 <572623ed-f353-46f2-809e-4678b152fa5e@amd.com>
 <eab5193a-7613-4733-a006-9eaf5598647a@amd.com>
 <a9797ada-63b8-4d3b-827e-f8173ae03abb@gmail.com>
In-Reply-To: <a9797ada-63b8-4d3b-827e-f8173ae03abb@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7076fcfa-2f65-45e5-865d-d0e728ef210c;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-24T13:10:50Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|DM4PR12MB6493:EE_
x-ms-office365-filtering-correlation-id: f17d8fb5-4c3c-4443-5de8-08dc646054f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?TEJjSnRvWGZPRTdLQUs0MnVYUFhHUHJxZlc0N2E2cWJ4cUlWQzRJc3QyQzc2?=
 =?utf-8?B?U3FsYnBiU0ZTWTRFQmswMUhtOWtIU01ydkE4K2ljR0h0TnRvaE1kaW9QYnF0?=
 =?utf-8?B?NjUySGZ6WDRSK3QyQUMzZkVWalZpRDdkeU51WU81MU1ycG9INmZSa0crbFRl?=
 =?utf-8?B?eTFORFJFSk9vd3J6dVdkekxtKzdtZVlseTVyK3VhdGNuaWZmYVB0dXIva2xR?=
 =?utf-8?B?Y09TaUorUlVmaHVQU29RNDU4Ym94cG1NOGlLREJuZ1lFMnpkazZiVzhpYk5h?=
 =?utf-8?B?SysxQmx1dHBtbU53WC9VelkyTVc4M3BqcjNWTVk1UEFKVDRic3NXMk5yc3lC?=
 =?utf-8?B?YmdIS1kxRzRGVE52dFJNMTdkQUxQZC9adE5iTWRPKzBWSTMrZ1pWSjZTcTNR?=
 =?utf-8?B?azgvN1ZGekJOYXA1MDNzM0drSEV6Y3d6RS9VWTNVZHg0SDJqR3FsZXBhbFJ1?=
 =?utf-8?B?NnplR2ltOU9oMzVRUmRFQ0p4Y0srdDNIajIyZkVNVEpFdVpWQU84dzY5dERO?=
 =?utf-8?B?RVhJbm5EcXFiM0daME1JN1VrWk5BcXY0dGdxdzAwbjRaMmU5b1VHczBxbE95?=
 =?utf-8?B?WFh1VldvZllOVkVhdHM4VWFIcUljaURMcmI3VFQxVWJJWXNJNU0wcDRPdjRs?=
 =?utf-8?B?T1JBaEc3VFJkZllLTmVJcWs4OVdUbXdvcjdmRXJJdEJIaHZRaExoZnE3Q0hN?=
 =?utf-8?B?bTZwU1lMcjArVDNzRkxpNjVZMGxSWWJmcW9vd1VGRkNUbVdqK0JZOFNhQVdO?=
 =?utf-8?B?SjgxaXRlSjQ2Q2dBUG85MGZveUhvZFFPUWdEcWxQQjJqYmpoT0hiSGZkZ21H?=
 =?utf-8?B?ZzYxQmJZNHkwQTFnNmQ0M0M0b2RXU2Rra2JvU0RrU0R1QW9yUlNrU0szL1ha?=
 =?utf-8?B?L09RVSsvYjR2Q2xmU00zcUEwc0k4WlBoMlpRWExOb2ZMaU9XMGNMVW0zRllO?=
 =?utf-8?B?TllEd2ZtdlFkTUVFQmtwdHVWMmpVQmE3UVBEaDVXbzFOZTFEUFE4cStCVW81?=
 =?utf-8?B?NXF1RHUxVGR2VmlTQ29pTnM2dndFajNDZ0ZCaU1OajVPQnVyZzAzYlpGU3Ux?=
 =?utf-8?B?NUpjUENQVjhRVTY3TUtZZkJGcndFaFFjN0gyZkhzTE5MMXY2aThTWnJFQ01H?=
 =?utf-8?B?RGxLRmxkajhjdHFnVzFoZVY0REtXeXdvK1JoYnVrUTkvMmZTUkI1MGhWVmVq?=
 =?utf-8?B?SzJJSVcwWkc5Yk5xWnVGRE01N2JwZ2loZ1dzWGN5R1JIZnFzalBMeUhEUXBj?=
 =?utf-8?B?N2FYb0pTRkNhUUxjRHE5cnFKRmJQOVJ2SGFvVFhuR3gxZkpaMFQzSG9XTDhN?=
 =?utf-8?B?MFRKclFnczcwUys4czArOHpHY1JGSElaT3lMKzViRFhGdFgrUXdMcGFQWXZG?=
 =?utf-8?B?VTFWNTRCbUMvaGpncWNZOHN3TVB4dlpycGExWUNUY25yc0ZFemRWdDg3cElG?=
 =?utf-8?B?Ukkwalk0RGdMVXdSZzhDODdBcktQeGRqQnh4ZmVGOHZjYThWYW0wd2xqY0Y1?=
 =?utf-8?B?M0djdXU0a05FdFo5Mjd0R0xjY2FyeGJXbmN2dUtuRytiN29sdXc4S0wzRlF3?=
 =?utf-8?B?QUVQdFhvL09JZnNSRWZ1bnJpZGVYRU5CQkRxb1ZEUmpIcTROYWJIbTdxNzhD?=
 =?utf-8?B?NHl2MlhaQkZQeGVUa25jQ1dLckNPQkNiaFBZQTM5SWlPMGxkOEI3UGozbXRX?=
 =?utf-8?B?YklaOG1UcFBMa0FrU0NhS09UMFVNRHRzckVPQjZtQU1YQ2hXU25JVEt0SHV0?=
 =?utf-8?B?cUpBWTRIQ2xuT0F0RU9RTjhvRUI5eFlwckJtQUE5YVlZbm1WRnRRRlczVllk?=
 =?utf-8?B?VnFSRFNERkVjMkRha0QwUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUE1ckJJQzJaRDcyNldwSyt6TUcvMUU0N0dSeUZLRFRyZjBNQzJ0OHN0VXZ1?=
 =?utf-8?B?S0FhWUZaQUVPZXoyYTR0WHpFdjh3d2tLc05Nbk4zMERPWmxrRU9WZ3J1a2xY?=
 =?utf-8?B?UEp1S0orZDFzalNHM1ZPNHl1bVJBVlJuR1hwUEpadFdNSzR6NTl0Yi9JVGt6?=
 =?utf-8?B?bGpzb0VxcjlOUjdLUkYxd2lJZlpyS3FYSFlkcFN2RktFZWtyYUFXMVJzZHdD?=
 =?utf-8?B?OUh3c0ttUWlydk1KT1dmMnRsWlN6dEFSdUlTZHdpbkZEamFKOXcrR1FMT0NM?=
 =?utf-8?B?U3loV2FjRnNFWFhFanJqSUFBT2haWXJGYjA0dEdMZ3MrUnk2MUFqRm9kTFdl?=
 =?utf-8?B?OGpZMTlNNXRzZjJ3dC8xN21JSmNrM1gzMk9XckxMS3V4b0xma1J0cTUrSCtR?=
 =?utf-8?B?SzZpN1lUNVlKZTBhVlN3S2pUdXc5WUt5d2FVVTlmWU5OSlEyS0VBdUNucGpZ?=
 =?utf-8?B?dFFDMXlvVnFzSXcrbjhZUUlFQzhOdGtBOEc5bTlpZ29xM2dNMjZGQWlUdnVo?=
 =?utf-8?B?UExJa0tDYlEvUi94YytxYkRqVUZMcEFtNENuWFg4V0lnRjZQVlpKWUlGR3hX?=
 =?utf-8?B?VVlvL0FOYnpTcHZYcTNUUW5JUnpOYkwyN3ZCeTVmYzNUempjK0poMWlOSFAx?=
 =?utf-8?B?aXByaUFCODYvbzg4R25nZTdjc1hlZmR5bHhsZkYvQmlHTzdwY1VOblpTRGVF?=
 =?utf-8?B?c3l0bTBIZmVFTHgvSjRJYlhaL2paTFI4ODNzT2JBTlJEYlNPNnlhMHBmb1Z6?=
 =?utf-8?B?K0pjdjZ1Mm1jZ3YwZFFOWDRad1kyWVRSMllZVHl1eWtpdUFzVnRYSlNPM0Np?=
 =?utf-8?B?bjZiZ1ZGOEtleXgrYzJJNFlOdEhGWWFyUUErSUM3VDBrN2RxUm1rNS95ckFS?=
 =?utf-8?B?djRhNE1BMHRkRUNTSmMrNUlzTTJUd3pxN3lIdGE1NUZOS2xuaE0waTBlbzAv?=
 =?utf-8?B?QjFTbE9vclN3Q0k0dFZMN1lORkJxc1ZOd21sbzNUc1B5OUNicFVCOHkzalNS?=
 =?utf-8?B?dkZha0x1VjZ4blBaRGgxY0NTamxqUzJ5Y2cxeXJUZy9pK2FFdlVianpad2lH?=
 =?utf-8?B?QUhPazA2dWpWM0puNnhLQ2dlME05MVo0Z1FxQlJCeXpkT2I0QnJmQnUwbFkr?=
 =?utf-8?B?NEs5bC9lU0QwZTFLTUlnNzQxTEtTUC9mU2lEeXgxeGhyZ2FGR2JGY2lLcTlt?=
 =?utf-8?B?dDZxQVJ3Mzh5dk9xU3NNY0NBeHVLMEt5cVhNWURVN0ZTSVlPNm9KY3diUkNR?=
 =?utf-8?B?ZVprNlJkOGRpdGpGT25rVzlPZXVRZnQ1SWs1R2xUMnpuQVlrM1hzWjVraVA1?=
 =?utf-8?B?d3VhZ1drYlRiaGVMVERwUFVxeXdDVmU3eEkzS29IOE41REdHaXlhK3pzdTc2?=
 =?utf-8?B?Vkdkc2IvWVJrWHdWWE1ORVRXVEYwMWFIRTQ4QjQydnZZVTM1QkVmcndVa1g4?=
 =?utf-8?B?WU9WQkt4R2U1Njd6QkVnOW1xNlcvQ3JmOSs1R0hqWk00RjFrazkrWkhNWUIr?=
 =?utf-8?B?cm11Mk5wNHZTS0x0MEw1bzVyNnR5bkx4RFlKaUkyYmpzWVFBRnlRaUdTdVBI?=
 =?utf-8?B?SmVIQ3NSc2VPTVZXOEVaWG9yRm1IcmZqOVFidVE0NVhWSlhNaU0xNHJwY3pk?=
 =?utf-8?B?K1I4VFZ5N0NURGhLeWxyQVdXQk92Nk5PVkYxcXMxSlNoNldiUGpjL2xiZXhi?=
 =?utf-8?B?d1VQOXB6WmpONnh2bWlIVXB6d282YmJNSXUvQ0ZEd2lrMzVGL081ZzN6V05Y?=
 =?utf-8?B?dTZDd040TGk1cXhKYVhJY1MzMWNlT3gzaFF1dGRwcTZadXNZOW1HRXBtclFK?=
 =?utf-8?B?NDVBM0NFaUdQL1Z2djZ2aDRJeEdsNHNlemxaSmZzb1VPOUxQT0NjYS9pZGRY?=
 =?utf-8?B?NjR2ZTJzYVprejFTODNzYU5Jb1I2NkVlTkdrc0xBSlh6dHpHR0tvUmlZTVNv?=
 =?utf-8?B?TzNNUHA3UG54QzREMGV4TFplOUpEbDllNjFpQ2tnTlkyMEhuNFBjam9jRDZJ?=
 =?utf-8?B?SXVteXBlb2pITnJOWW9BejFrRnRha2ZOeFBFNWY4TDlsTVkyc0NJTVB5NDdu?=
 =?utf-8?B?VVZkb3hOc1JOdlRNQzdwUWVGcDM2MlY3KzhOb2IvUjFEZ2xrc3RGV0lOWHlR?=
 =?utf-8?Q?OzrE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f17d8fb5-4c3c-4443-5de8-08dc646054f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 13:13:28.4528 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j5bSyIuvDHgxqPKiWmOHz8ylJH63PiAiONybu8iObKzR8h5xqwqXUR3NOGF0VR5Xj3cIEL2uYVvzdREfmX2bbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
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

W1B1YmxpY10NCg0KPiBXZSBoYXZlIHRoZSBLRkQsIEZMUiwgdGhlIHBlciBlbmdpbmUgb25lIGlu
IHRoZSBzY2hlZHVsZXIgYW5kIElJUkMgb25lIG1vcmUgZm9yIHRoZSBDUCAoaWxsZWdhbCBvcGVy
YXRpb24gYW5kIHJlZ2lzdGVyIHdyaXRlKS4NCj4NCj4gSSdtIG5vdCBzdXJlIGFib3V0IHRoZSBD
UCBvbmUsIGJ1dCBhbGwgb3RoZXJzIHNob3VsZCBiZSBoYW5kbGVkIGNvcnJlY3RseSB3aXRoIHRo
ZSBWMiBwYXRjaCBhcyBmYXIgYXMgSSBjYW4gc2VlLg0KDQpXaGVyZSBjYW4gSSBmaW5kIHRoZSBD
UCBvbmU/IE5vdGhpbmcgY2FtZSB1cCB3aGVuIEkgc2VhcmNoIGZvciBhbWRncHVfZGV2aWNlX2dw
dV9yZWNvdmVyDQo=
