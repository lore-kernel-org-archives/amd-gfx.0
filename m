Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5305DCED265
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 10:08:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D153610E478;
	Tue, 18 Nov 2025 10:08:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FKfKx3A+";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013000.outbound.protection.outlook.com
 [40.107.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 226F110E478
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 10:08:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6UqrD0pvh3MtIZwW6tZr+lys2LhVaB3xp9MX5fHOFgxxy1ZR0Rncp6ZQFrZGJ4cz/8izx0+uuWRgEQl+Eg1cnOOkDFNDuPsPwKwOYgBpXj0ytBesLTTfm4M9+wXWE+sDPNRNNaHYSHwXbX2clnVOd6FSaBGTDdZvbMH1f/LZexFSmmaLSLTqJWdgm1UQbxPUy/kFvlSMffXT73/hzLi7uvUhuk3XlABXXJXRQbQYgggRkK1sM4sBFMEZ3YybeB3SLlWH7bNC6Zzj2ftzdMhNcJHLAuFbOPaAh5xU1gmpe1w2tkhwpXrRTsFbfUwTSADs2R9grbX3OURht+Q78SEKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2md+hRwpxj3R0bgc2ZY2UT6t8AKzbtW4zfOw6YyzG4=;
 b=tZRA5hzJFmOzheKSvoB25U4knvAOGZdzrkwf3pSn5JHZ1tuJLB/LlY6NNiFg92pWU7sn7NL2C/FJiW8B3Qc/lX/ILV7t/Qkt2lkAnOcyRAWBD2frnowDQ17ZNWPpip5Cb71GBXZwIgoYeimH8Xum1/jK9K29MChx9W4/irR4AAe1S7dSp09oph/VBB+qxrEkl8mFA1JM3ew2ds522wWciyF1P1uSepoU2PXldKFkaA3y37VdeptsN+oEnQy0xKwx3WIynQdUt/g4G0qt6DKq79RzjhFUp0/fvRZE/XMvXfYChxW4iLHS2hrBz/kt3cgQDaTFwYBro9+abHs+hD5NmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2md+hRwpxj3R0bgc2ZY2UT6t8AKzbtW4zfOw6YyzG4=;
 b=FKfKx3A+K60q0KkdK9k9RKJ8ZAuR5ur+fPBJWdi5sFqaL1N0BooR4wM/hbn17J9hY7G0pESkEw3CmOAEv5DaJCGPPCTscCsfGbSZGP6ETWRx/l1sjP/q3XT/md+Ki18WmqpRxkzBf1StybmiBtWoKyGgEEPxm5mISrRt1FPU4pI=
Received: from DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) by
 MW4PR12MB5628.namprd12.prod.outlook.com (2603:10b6:303:185::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.22; Tue, 18 Nov 2025 10:08:43 +0000
Received: from DS7PR12MB5768.namprd12.prod.outlook.com
 ([fe80::ae90:ca3:5db2:1a78]) by DS7PR12MB5768.namprd12.prod.outlook.com
 ([fe80::ae90:ca3:5db2:1a78%4]) with mapi id 15.20.9298.010; Tue, 18 Nov 2025
 10:08:43 +0000
From: "Li, Chong(Alan)" <Chong.Li@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Chen, Horace" <Horace.Chen@amd.com>
Subject: RE: [PATCH] drm/amdgpu: in sriov multiple vf mode, 2 seconds timeout
 is not enough for sdma job
Thread-Topic: [PATCH] drm/amdgpu: in sriov multiple vf mode, 2 seconds timeout
 is not enough for sdma job
Thread-Index: AQHcV47vUkrpw2rZtE+NUSf+0yNb2LT4HO6AgAAG4lCAAAk6AIAAAJdw
Date: Tue, 18 Nov 2025 10:08:43 +0000
Message-ID: <DS7PR12MB57682BD7E22D58475BC395F19BD6A@DS7PR12MB5768.namprd12.prod.outlook.com>
References: <20251117065323.3435034-1-chongli2@amd.com>
 <cde95388-b48c-4310-b5e5-bcff56a31744@amd.com>
 <DS7PR12MB576863BD7C14E3671B31EC0E9BD6A@DS7PR12MB5768.namprd12.prod.outlook.com>
 <b6c09fdc-168c-4489-9a20-d20c472b16ff@amd.com>
In-Reply-To: <b6c09fdc-168c-4489-9a20-d20c472b16ff@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-18T09:33:18.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5768:EE_|MW4PR12MB5628:EE_
x-ms-office365-filtering-correlation-id: 377887e1-ce52-4d36-9fbc-08de268a7483
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?WGo0OWM2Y1NONmkvdndXZlRnRGRTRVJiUnNYMzcrdXh3YXBqZWNpbWtXbFNC?=
 =?utf-8?B?NG9TRGlFWHFBTkJKMmlTaTE2eUZzR0dlU2NqTElRNjZ3M3BQMGFoN2MyNXF3?=
 =?utf-8?B?aCtpY3RhYUxpbWJ6S0Vkb0tTYU9KMUpVSENoR2FKbG1yajgwby9xTVRkUWZP?=
 =?utf-8?B?V0QwMThUQ3NHUzAvbzgzSDU0LzJoNEw2SUo4ZllhUHRVbXRZQnJac05kVGNN?=
 =?utf-8?B?UFZrZUJVTXNueTYrMTBjayt2QVBhQ3JxMzVVeDRXbmMxc2JhNzdrczZOL2Fh?=
 =?utf-8?B?ZWZnekw3LzF6WldqRWpOaEVIdmt0QUd2TGNIOFVwU0xzWWhMR1VwVnhZWXF6?=
 =?utf-8?B?RlBGUkVOOWRSZTArMm5rcGl0QWtJcllDVmtnWnQ5clRXVWlyNWx3b1ZmTGh1?=
 =?utf-8?B?U3pXS0JJQ2hPenpoL2lHZk5zVDBMNXVNbjQxRU1IMVg5aUhtYmNoQzJRV2VW?=
 =?utf-8?B?bDZIMUVuSWxudnZQQlRQOHpmcjlCQjhpaWRiWUlxSWdmNWZhc2V2RjJtVTFG?=
 =?utf-8?B?VzJsUFM4MWpFWmg0UW9TOEpTZmpZVFlwZVpXcE9vRHZaSzY5cTlwQ25UeW9K?=
 =?utf-8?B?dnNBZFlXTkF0L0ZzeDI5OVpoeEFJZjRpRTBCdzkzRG1uNmdWKy93WUR1SnpY?=
 =?utf-8?B?ZXMvZThVd1E3aTUzcVRzdUJwTFAyYWU5TEdQdXQySDFIc0hLQWFHQjNYSGtv?=
 =?utf-8?B?ZEVkM1FZM2t3K1BwaW40NGRBaXg3SjB6NHhqMk13Zy9UalVncjVHZWdxUVc2?=
 =?utf-8?B?blZTb05ZU1EwaUlzR3N5clpjTndDZWFWTWczVVdCcmRVampORG1sdk8rMklN?=
 =?utf-8?B?cWExWW11UW5JeGI1aUVJelUzcWZRbkhIOTBPTCtkUFpydnpDRzhiaFNkRDZB?=
 =?utf-8?B?TGZBckdaL1ZoSVdaZnRKeFZMQWNsVEtuVHNIaUprWEJ3Mld0QTRRcjI1ckRv?=
 =?utf-8?B?TXFvdmkwNnZxOFJVMHQ0eXd1eGJnbjVmNm5QNWU3UG5hR3ZwdFAwZHJIeTNm?=
 =?utf-8?B?TWU5UXRrcjVkSHRnN0JjcVd6SVBuWW82dFlQZWRiVEFlTUp2NWUyZGwySTFE?=
 =?utf-8?B?Q0dIbXNRajRIYVlXTnA1VmxvZC9JWHpZalFVZnRJSmkxM3NSM0hZVEtvN1Fo?=
 =?utf-8?B?bEtuTHJuc0UrakJzWFdKaThWNGkxWmFWYVFZOXNqenlyV2dMc0hDUkhpbVB0?=
 =?utf-8?B?RmpjMnhNaWg3ZldSU2xZYU5MQnB2a2pJKzVwcXo3Q3JiRkdWbnRCWjRKYmNY?=
 =?utf-8?B?cnhRTUh1amg5Nzl3ZXJYNGRPNjlRdFlFZHE0MU50bkg2WDk4UlIzbElLRytZ?=
 =?utf-8?B?OXAxN3BuNVIyN2ZoazcxVGVJdXk2aW5sbWIxNVVYQk9nRmozS3NrbUdSVDNG?=
 =?utf-8?B?ZEF6UEJTbjFpbWthZWg0cmR2aVRYajVZRDhlYTZKQ0dJRVlJaklPb0w4QXF3?=
 =?utf-8?B?OGlWVGtLaFhiZE0vbkUvcC90bGc0TW1Tem53d0JVMGZmdlFJVzhJdGdCNWJU?=
 =?utf-8?B?U01KZUN6bmVRMmVXY092MzlaMUphU3dNbEorWW9Sb1BCcFhqb2tEaHJ2VUVs?=
 =?utf-8?B?MTVKa09haTJ0SmFjVW4vZW8rM2V2ZkZUOHV1OVZvdnVpeGlWVmJVTjJaZnNX?=
 =?utf-8?B?bllpUmpmZjIvMGJPVndTcVZQcDJtSzlVVkh2Y2dFVzlBeWVvcm53WGRhRjRR?=
 =?utf-8?B?QVBhS3QxNmtJMHNFWm9ONjR2ZWIrVUN6TmZLNGpjT3VRdlNKL0xaZDh0NWQx?=
 =?utf-8?B?WDZzak5lR0FFaERFR29NRnVXR1JnNW5PZERNeGpBN0N3M3pGeDFwMmhLbStx?=
 =?utf-8?B?NWJCMk4ycDcwSVRVam1qZThqNE51d2d1RkxCR3hYN0kzSEZzalM4enlVWG9L?=
 =?utf-8?B?RExZV2tpUzhJb2ZWdG5raTMvN2hZOG5jK2xXS3FrK3Y5dWhpdXVXdEpZN3Ni?=
 =?utf-8?B?SzIvSWNvRHdCdzBQcmp0cTBPVzVZWG5UbFl3ZXgwQlAxWW1Sb2JOcGp0cktn?=
 =?utf-8?B?QWJuSXE1NzdUNVdzVGdSODEvYVRTRWRBRjIzWUhJQlV4OTFYcjk1aEdDd1hJ?=
 =?utf-8?Q?p/j1DX?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5768.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0VqNGFQdVhuM2lVekpiRUl0c0dDdkF2cWVaYndXNDNrWGVGbUhhaHlmcEZF?=
 =?utf-8?B?YXl5bTNreFRncEgrRThLQWNNa0JKZmpEWXFuMjZMdXJvQ3VMOXNaSW56UzZQ?=
 =?utf-8?B?cDBvMGk1S2pjc1VEY2tkUnZ1eVRRNHR3Q3Ixa1NUeUdvK2V5WHJYMUNDeldW?=
 =?utf-8?B?VDJUN0kvK1QzZWpPUFNUNjduTkFWM2U1NjRHMzJpa3JyZncyOVhYK1k0bStY?=
 =?utf-8?B?bHdTMFlLdit1Qmk3M3FXOFV4QTBjckJUQ3VMKzgxUktSU2xkV2dxSVZKNGZ3?=
 =?utf-8?B?VWUzM3VaOFlZZ0s0eUczV2QvL1VWcXRiRlNIbG0wYzZRWndrcU5hOGZaSE56?=
 =?utf-8?B?M0Y4UDNlc0RTeVhFRWhZUUZ3OFcrNFpOV2NveitzK2MzWUs2NW1xVDhNUmt2?=
 =?utf-8?B?c0xLN3IvL1F4RG03QlNGam4zeENseitFZGtpa093UDUyU05pWUU5c2h1cXZz?=
 =?utf-8?B?azZsdDNrZUJnUzh6Nlo5dXZ2OFdkdTNzVFFUNVZacDVOWlhSbmo2ZzlxY1k1?=
 =?utf-8?B?eThNMkFSazJxVjZRR0VBUE96d1U4cmgyaEU1QmdQQ0I4aXY5RUF3SlRFbzk5?=
 =?utf-8?B?Ry9NeitiS1J2N0gzTTEvWGhlTmFQRVdLRWxpK1ZGclFnVWhZQTljN0JKUGhl?=
 =?utf-8?B?ZmppZlQ1MGtrODF1aS9xYUFOMkNqbGxzYm41YTJPazYwcG0zMXRJMG4vMkxV?=
 =?utf-8?B?MTNBdEh3dW04dWUwdW1OdjFzakx0SkVBWXIwb3I5TytoWUgydjVaOW1lckhK?=
 =?utf-8?B?TThNS1ZPbkZrUnVXRjNydFd0L1pLSUVwOE1lUGg2YVFjSG4vT2xQMTFZMWUx?=
 =?utf-8?B?bDdNZXdZWElWUkdpSnd0SDBqS1QvcU04Wlh3Wi9ubGh3NTdrZDVxOUpBRk01?=
 =?utf-8?B?VnRzQ2IwZy9EczVENjFFNENVMVY2aFhUSmp3Q0pxTG4ydmdvTEcvL2U0aXRE?=
 =?utf-8?B?eDk2T08yVmRQQ2MxbVBnRk44WmNkckxJUFB5a1RKdVMwYThReXdBSWhadUNv?=
 =?utf-8?B?S3JKT3JvbG14RGtFRnlXY2VqU1B5ZnFPRUNwM3NiOG9RUFhGOC9jakNYc0hT?=
 =?utf-8?B?TjNEZy9vVGhOL0QvbVpwWmlpMERYWGNnZENlTEF1Y2MwL1dyNktIYnEvV2xm?=
 =?utf-8?B?ZDJ0aGhsZ0ZZbU5nYnA0WDQzRUR3dnVWbG92cDNaUDNaeEx0RUJWM3JIaWRC?=
 =?utf-8?B?ZlpZKy9lU053QUkyK1VUc0N2MDF3RE52QnFqUENCcEl1OTZ4c3NxbVIwYkl3?=
 =?utf-8?B?c2ozRWVmY3NabkFQSHZjc3Y2Rmk5NC9kam9CRXZwczJpTEVYVzRvQ0R3Q25N?=
 =?utf-8?B?MnduQ2Q5MGFQejNvK05sSjA3TWpEdWxDbkRIamZvb3Rmb0ZhN1ZPRUZyWE1l?=
 =?utf-8?B?L1VUb2s2ZjkwdVQ2VFZyOGY1RGlwNWROZFo0c252OThwR1dZMzhtL3BpTk90?=
 =?utf-8?B?SzE3akEzSlUwTm9mU3lvVlNiQzJJbWpqQXdLWTl6b0Nac0JEVVR0QURkWTFW?=
 =?utf-8?B?T2lyREN6L3llYy9kbFR0eFg1NnpuSUp1bzlwOFdubzZWekJWWWJwalBZTXM2?=
 =?utf-8?B?aUJxV3J0SHBLMitnSm1KL1BlVEgyaktpRnRTMnlaTko4Ylg3YThxVm5kNDY5?=
 =?utf-8?B?NnJGbnZ4K3FtSXFGVTFpN1NLTGVkWFBxdUFEV3l2NkJjeFVmS2hmVGRzdnFK?=
 =?utf-8?B?YWpycExQNUY5MGQzcHVBNjlNcU5ubE40eU9lbllnYXJ6VXVNQ3pZS2lwbG9o?=
 =?utf-8?B?cVZab3dPamJhVTRQeDQyZ3JjZVlOY0NOUnpyb2lQQ0t6ZWNyNHFQbXUvbGVE?=
 =?utf-8?B?MU1WMWdtWUJYdU8veGhaWTVvQnBYZkxRQUxReGsvUHBRUllVTzFjMG1KVFdy?=
 =?utf-8?B?dWNWQTNXWU8yTGhBeGxIYzFDQkwwS0lISm44ZC8yU0o2dkZKK1BUbUlON3c2?=
 =?utf-8?B?aHNiMmhsbXh3VVd0TXN4LzhhOUVXN3MzajcxRUtIZ2h5VnlQejl3OExZOWM0?=
 =?utf-8?B?eHZ4MkZKTjFnV0RiOU40eGRaQkRWQUxBUGd5V040aVZhZW9GVnNCZFA3NkdM?=
 =?utf-8?B?bk9sYzNXVXlzekJPR2U0TVhrZzk1REJSaFIyc3hZdlRZZ3pkY2IzbU94SUFX?=
 =?utf-8?Q?PnkY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5768.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377887e1-ce52-4d36-9fbc-08de268a7483
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 10:08:43.5168 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KC5LEr3g6cjdifb7wR4R5fMelKU9FNUScQaBT1w9cdw+phYCa5bAWOvJLgQA6j+Aqk4hbC+NjK+UJGm1/4vJeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5628
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
Cg0KSGksIENocmlzdGlhbi4NCg0Kd2hhdCBJIG1lYW4gaXM6DQppbiBzcmlvdiBtb2RlLCB3aGVu
IGN1c3RvbWVyIG5lZWQgbGltaXQgdGltZW91dCB2YWx1ZSAsDQp0aGV5IHNob3VsZCBzZXQgdGhl
ICJsb2NrdXBfdGltZW91dCIgYWNjb3JkaW5nIHRvIHRoZSB2ZiBudW1iZXIgdGhleSBsb2FkLg0K
DQoNCldoeToNCg0KVGhlIHJlYWwgdGltZW91dCB2YWx1ZSBpbiBzcmlvdiBmb3IgZWFjaCB2ZiBp
cyAiIGxvY2t1cF90aW1lb3V0IC8gdmZfbnVtYmVyIiwNCg0KQXMgeW91IHNhaWQgdGhleSB3YW50
IHRvIGxpbWl0IHRoZSB0aW1lb3V0IHRvIDJzLA0Kd2hlbiBjdXN0b21lciBsb2FkIDh2ZiwgdGhl
eSBzaG91bGQgc2V0IHRoZSAibG9ja3VwX3RpbWVvdXQiIHRvIDE2cywgIDR2ZiBuZWVkIHNldCAi
bG9ja3VwX3RpbWVvdXQiIHRvIDhzLg0KDQoNCihBZnRlciB3ZSB0ZXN0LCB3aGVuIHZhbHVlICJs
b2NrdXBfdGltZW91dCIgc2V0IHRvIDJzLCB0aGUgNHZmIG1vZGUgY2FuJ3Qgd29yayBhcyBlYWNo
IHZmIG9ubHkgZ2V0IDAuNXMpDQoNCg0KDQoNCg0KVGhhbmtzLA0KQ2hvbmcuDQoNCg0KDQotLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlh
bi5Lb2VuaWdAYW1kLmNvbT4NClNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDE4LCAyMDI1IDU6MzEg
UE0NClRvOiBMaSwgQ2hvbmcoQWxhbikgPENob25nLkxpQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZw0KQ2M6IENoZW4sIEhvcmFjZSA8SG9yYWNlLkNoZW5AYW1kLmNvbT4N
ClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGluIHNyaW92IG11bHRpcGxlIHZmIG1v
ZGUsIDIgc2Vjb25kcyB0aW1lb3V0IGlzIG5vdCBlbm91Z2ggZm9yIHNkbWEgam9iDQoNCkhpIENo
b25nLA0KDQp0aGF0IGlzIG5vdCBhIHZhbGlkIGp1c3RpZmljYXRpb24uDQoNCldoYXQgY3VzdG9t
ZXIgcmVxdWlyZW1lbnQgaXMgY2F1c2luZyB0aGlzIFNETUEgdGltZW91dD8NCg0KV2hlbiBpdCBp
cyBqdXN0IHlvdXIgQ0kgc3lzdGVtIHRoZW4gY2hhbmdlIHRoZSBDSSBzeXN0ZW0uDQoNCkFzIGxv
bmcgYXMgeW91IGNhbid0IGNvbWUgdXAgd2l0aCBhIGN1c3RvbWVyIHJlcXVpcmVtZW50IHRoaXMg
Y2hhbmdlIGlzIHJlamVjdGVkLg0KDQpSZWdhcmRzLA0KQ2hyaXN0aWFuLg0KDQpPbiAxMS8xOC8y
NSAxMDoyOSwgTGksIENob25nKEFsYW4pIHdyb3RlOg0KPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5
IC0gQU1EIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KPg0KPiBIaSwgQ2hyaXN0aWFuLg0K
Pg0KPiBJbiBtdWx0aXBsZSB2ZiBtb2RlKCBpbiBvdXIgQ0kgZW52aXJvbm1lbnQgdGhlIHZmIG51
bWJlciBpcyA0KSwgdGhlIHRpbWVvdXQgdmFsdWUgaXMgc2hhcmVkIGFjcm9zcyBhbGwgdmZzLg0K
PiBBZnRlciB0aW1lb3V0IHZhbHVlIGNoYW5nZSB0byAycywgZWFjaCB2ZiBvbmx5IGdldCAwLjVz
LCBjYXVzZSBzZG1hIHJpbmcgdGltZW91dCBhbmQgdHJpZ2dlciBncHUgcmVzZXQuDQo+DQo+DQo+
IFRoYW5rcywNCj4gQ2hvbmcuDQo+DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+IFNlbnQ6
IFR1ZXNkYXksIE5vdmVtYmVyIDE4LCAyMDI1IDQ6MzQgUE0NCj4gVG86IExpLCBDaG9uZyhBbGFu
KSA8Q2hvbmcuTGlAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGluIHNyaW92IG11bHRpcGxlIHZmIG1vZGUs
IDIgc2Vjb25kcyB0aW1lb3V0IGlzIG5vdCBlbm91Z2ggZm9yIHNkbWEgam9iDQo+DQo+IENsZWFy
IE5BSyB0byB0aGlzIHBhdGNoLg0KPg0KPiBJdCBpcyBleHBsaWNpdGVseSByZXF1ZXN0ZWQgYnkg
Y3VzdG9tZXJzIHRoYXQgd2Ugb25seSBoYXZlIGEgMiBzZWNvbmQgdGltZW91dC4NCj4NCj4gU28g
eW91IG5lZWQgYSB2ZXJ5IGdvb2QgZXhwbGFuYXRpb24gdG8gaGF2ZSB0aGF0IGNoYW5nZWQgZm9y
IFNSSU9WLg0KPg0KPiBSZWdhcmRzLA0KPiBDaHJpc3RpYW4uDQo+DQo+IE9uIDExLzE3LzI1IDA3
OjUzLCBjaG9uZyBsaSB3cm90ZToNCj4+IFNpZ25lZC1vZmYtYnk6IGNob25nIGxpIDxjaG9uZ2xp
MkBhbWQuY29tPg0KPj4gLS0tDQo+PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RldmljZS5jIHwgOSArKysrKysrLS0NCj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZHJ2LmMgICAgfCA0ICsrLS0NCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jDQo+PiBpbmRleCA2OWMyOWY0NzIxMmQuLjRhYjc1NWViNWVjMSAxMDA2
NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0K
Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+PiBA
QCAtNDM0MSwxMCArNDM0MSwxNSBAQCBzdGF0aWMgaW50IGFtZGdwdV9kZXZpY2VfZ2V0X2pvYl90
aW1lb3V0X3NldHRpbmdzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPj4gICAgICAgaW50
IGluZGV4ID0gMDsNCj4+ICAgICAgIGxvbmcgdGltZW91dDsNCj4+ICAgICAgIGludCByZXQgPSAw
Ow0KPj4gKyAgICAgbG9uZyB0aW1lb3V0X2RlZmF1bHQ7DQo+Pg0KPj4gLSAgICAgLyogQnkgZGVm
YXVsdCB0aW1lb3V0IGZvciBhbGwgcXVldWVzIGlzIDIgc2VjICovDQo+PiArICAgICBpZiAoYW1k
Z3B1X3NyaW92X3ZmKGFkZXYpKQ0KPj4gKyAgICAgICAgICAgICB0aW1lb3V0X2RlZmF1bHQgPSBt
c2Vjc190b19qaWZmaWVzKDEwMDAwKTsNCj4+ICsgICAgIGVsc2UNCj4+ICsgICAgICAgICAgICAg
dGltZW91dF9kZWZhdWx0ID0gbXNlY3NfdG9famlmZmllcygyMDAwKTsNCj4+ICsgICAgIC8qIEJ5
IGRlZmF1bHQgdGltZW91dCBmb3IgYWxsIHF1ZXVlcyBpcyAxMCBzZWMgaW4gc3Jpb3YsIDIgc2Vj
IG5vdCBpbiBzcmlvdiovDQo+PiAgICAgICBhZGV2LT5nZnhfdGltZW91dCA9IGFkZXYtPmNvbXB1
dGVfdGltZW91dCA9IGFkZXYtPnNkbWFfdGltZW91dCA9DQo+PiAtICAgICAgICAgICAgIGFkZXYt
PnZpZGVvX3RpbWVvdXQgPSBtc2Vjc190b19qaWZmaWVzKDIwMDApOw0KPj4gKyAgICAgICAgICAg
ICBhZGV2LT52aWRlb190aW1lb3V0ID0gdGltZW91dF9kZWZhdWx0Ow0KPj4NCj4+ICAgICAgIGlm
ICghc3RybmxlbihpbnB1dCwgQU1ER1BVX01BWF9USU1FT1VUX1BBUkFNX0xFTkdUSCkpDQo+PiAg
ICAgICAgICAgICAgIHJldHVybiAwOw0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kcnYuYw0KPj4gaW5kZXggZjUwOGMxYTlmYTJjLi40M2JkZDZjMWJlYzIgMTAwNjQ0DQo+PiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPj4gQEAgLTM1OCwxMCArMzU4
LDEwIEBAIG1vZHVsZV9wYXJhbV9uYW1lZChzdm1fZGVmYXVsdF9ncmFudWxhcml0eSwgYW1kZ3B1
X3N2bV9kZWZhdWx0X2dyYW51bGFyaXR5LCB1aW50DQo+PiAgICogW0dGWCxDb21wdXRlLFNETUEs
VmlkZW9dIHRvIHNldCBpbmRpdmlkdWFsIHRpbWVvdXRzLg0KPj4gICAqIE5lZ2F0aXZlIHZhbHVl
cyBtZWFuIGluZmluaXR5Lg0KPj4gICAqDQo+PiAtICogQnkgZGVmYXVsdCh3aXRoIG5vIGxvY2t1
cF90aW1lb3V0IHNldHRpbmdzKSwgdGhlIHRpbWVvdXQgZm9yIGFsbCBxdWV1ZXMgaXMgMjAwMC4N
Cj4+ICsgKiBCeSBkZWZhdWx0KHdpdGggbm8gbG9ja3VwX3RpbWVvdXQgc2V0dGluZ3MpLCB0aGUg
dGltZW91dCBmb3IgYWxsIHF1ZXVlcyBpcyAxMDAwMCBpbiBzcmlvdiwgMjAwMCBub3QgaW4gc3Jp
b3YuDQo+PiAgICovDQo+PiAgTU9EVUxFX1BBUk1fREVTQyhsb2NrdXBfdGltZW91dCwNCj4+IC0g
ICAgICAgICAgICAgICJHUFUgbG9ja3VwIHRpbWVvdXQgaW4gbXMgKGRlZmF1bHQ6IDIwMDAuIDA6
IGtlZXAgZGVmYXVsdCB2YWx1ZS4gbmVnYXRpdmU6IGluZmluaXR5IHRpbWVvdXQpLCBmb3JtYXQ6
IFtzaW5nbGUgdmFsdWUgZm9yIGFsbF0gb3IgW0dGWCxDb21wdXRlLFNETUEsVmlkZW9dLiIpOw0K
Pj4gKyAgICAgICAgICAgICAgIkdQVSBsb2NrdXAgdGltZW91dCBpbiBtcyAoZGVmYXVsdDogMTAw
MDAgaW4gc3Jpb3YsIDIwMDAgbm90IGluIHNyaW92LiAwOiBrZWVwIGRlZmF1bHQgdmFsdWUuIG5l
Z2F0aXZlOiBpbmZpbml0eSB0aW1lb3V0KSwgZm9ybWF0OiBbc2luZ2xlIHZhbHVlIGZvciBhbGxd
IG9yIFtHRlgsQ29tcHV0ZSxTRE1BLFZpZGVvXS4iKTsNCj4+ICBtb2R1bGVfcGFyYW1fc3RyaW5n
KGxvY2t1cF90aW1lb3V0LCBhbWRncHVfbG9ja3VwX3RpbWVvdXQsDQo+PiAgICAgICAgICAgICAg
ICAgICBzaXplb2YoYW1kZ3B1X2xvY2t1cF90aW1lb3V0KSwgMDQ0NCk7DQo+Pg0KPg0KDQo=
