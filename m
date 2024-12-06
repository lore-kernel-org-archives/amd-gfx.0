Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3009E77173
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2024 06:15:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FAEB10E31F;
	Fri,  6 Dec 2024 06:15:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U3zXEz6a";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 897CF10E31F
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2024 06:15:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phhtlcHT89POcANdT2kUlQsLrlW3UpCphiWb+p0F2hA3eB4lEr8IIOuIuzHEGeIqj0eEi5d+QcUaP1R1LOfqihQD5LLD4rUa6v53eiW/36ybrbbQHNadsZr2dSJznyFBpzIZqB4Qwcjzl3JNLhKhNtbrkEQ48xnBV+Deu6lQp6+hkFqgEnWALCT+a3yC4yiLskXQooQpIsqV5MjqQ0FecnZ0VNEla0aBSlyC7iKfCb9vb/BZOnSw6k6od9TiRAh8H801xlIKRnfOtvpVt8Fxb8k67ikKKFsFh6YU1cZpGkKkpTFro1OUzkFXrobMM6Kz7WS4UWSeKciKaRtYqyMxKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJMdaDb4S8hQYAY9AJMzpzgQZQq9Z4psS314uyUaGag=;
 b=iRD8GEnOIziV7WgxjTnhSEhEGDGXfDvuyVacqasvrgqIzs9bgoKJY3I6ectLOkIrO6B+pZ7i/5cwZohaLSusQzkcA6gJSPGP1aymhehK6WOrwciFqrVzVHJoTR4YuLGVeAGvpgRW/oQ1M/Sx1vmxxmETQsanAqTPeHYgQ4m60WRFCCDAH2883XRPc0kWj9+TQQROdvh3nXxUobisMRFQX8c8nQUMj/ZoEMBHyBi/b8gxAUk3RDh59sLosjnWoyoyWCOhF85Ep5Dvg+3pbNMmPubwNjrX3sXNqFX9zsaVDegXWsKGQGp0cZJrnzJbokcE7lB5o/AxunKQz2CflN5ByQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJMdaDb4S8hQYAY9AJMzpzgQZQq9Z4psS314uyUaGag=;
 b=U3zXEz6a1rb2GqFkxUdHGs78F23NSEyVL6aM8+RbC4gGihwm09eQ/IakOAoeXUJbUz/QP0fVFzVEgIT+VmBBpNvHTezj08APCCFguo56hf9szKop6E89ljG+lSLZlvhE8NbFT1uuibW8IB3x94pd3jWW5RDUFADqiR+6kdn9uZI=
Received: from DM4PR12MB5373.namprd12.prod.outlook.com (2603:10b6:5:39d::14)
 by CYXPR12MB9385.namprd12.prod.outlook.com (2603:10b6:930:e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Fri, 6 Dec
 2024 06:15:03 +0000
Received: from DM4PR12MB5373.namprd12.prod.outlook.com
 ([fe80::79ae:2610:e503:b15b]) by DM4PR12MB5373.namprd12.prod.outlook.com
 ([fe80::79ae:2610:e503:b15b%6]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 06:15:03 +0000
From: "Feng, Yuan" <Yuan.Feng@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Use MEC FW with SJT on gfx_v9_4_3
Thread-Topic: [PATCH] drm/amdgpu: Use MEC FW with SJT on gfx_v9_4_3
Thread-Index: AQHbR2dgRa29up4wB0q+2OlTMNPATrLYrYeAgAAPzQA=
Date: Fri, 6 Dec 2024 06:15:03 +0000
Message-ID: <DM4PR12MB5373851923CE8D2639B2A45FFA312@DM4PR12MB5373.namprd12.prod.outlook.com>
References: <20241205224507.2272-1-yfeng1@amd.com>
 <6f18e09d-b523-4bdd-b435-8d02f54227fa@amd.com>
In-Reply-To: <6f18e09d-b523-4bdd-b435-8d02f54227fa@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-Mentions: Lijo.Lazar@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1b2aec8c-69a7-4b8f-872e-9e0e349a6aad;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-06T06:14:12Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5373:EE_|CYXPR12MB9385:EE_
x-ms-office365-filtering-correlation-id: 0a0c8990-16a1-4256-de1f-08dd15bd5265
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?KzNiK2FySkIwY2gyWllIbzhKb2ZVZXZRQVprR0dtZlYyU1dRSnVrR3c5bzQ0?=
 =?utf-8?B?ODRlWndXbUhPTWVsQi91L2NYN0FkT0YrZVRWakg3aUkxS2xjK0llTnhBQm5z?=
 =?utf-8?B?OUxTaG5xazhHQlNsaDNJb3ByKzZrdW1iNkNuRE91L2JsWm1yR3NldysvR3Qx?=
 =?utf-8?B?ZXo0Yk1vbytPcFhENFhQVHRNSkh2dFdZNzYvUTNTY3dQdHRDU3d2WEZEcjlu?=
 =?utf-8?B?bjRNQ3dkQURWMkNVbVBTRmUwcE1tSFlPN1M4RGVVMXJFM3BqYmNpMXVqcHRi?=
 =?utf-8?B?bjRhT01odXBnTXc5Qk9xNzVUa0x1dlZhUUVhRkVXL3lxTDVLVzQ4d1lDS3dr?=
 =?utf-8?B?NDBRUHhxVlI2b1dMK0Rua1JiQmtFY2dhaGxmV3A3N0NPWHlHbWNUT3p0dlVW?=
 =?utf-8?B?WXVxTXYrSTIzdnlVQ1lwZzhjNVQzSjdxZUg1UFZONThteTFGT2diMmdoRnoz?=
 =?utf-8?B?ck5hMWJVdjNIMUJEWVZOOXZtYnpyOC94NXBmR2hXNC8rN1dtbWt5cVQxemVv?=
 =?utf-8?B?UThiYzA2QXRZblpnbllaeVVFK1BaT0djdXA4VGRud2RySGhmVDc2RkwxZjBj?=
 =?utf-8?B?a3B6cnFUcFkwczNQRGxNMFdnUFB3L204Nmd3MUk0L3VmZHdNcDM2TkN6bXBU?=
 =?utf-8?B?SS85V2FvOU9BelZYUlpoQjltVk1NQk5VZHpvaUtNWnB1MU95TEN3NEFmZUNE?=
 =?utf-8?B?Q2hEbUVKN0MrUVpwUGh2eGZXb1ZGVVpscWhjZjk3Y2M1V1VlTDhvVlpRTUha?=
 =?utf-8?B?QzlwQ0RoSDQ0QWY2UVhpQkQ0cmhJUmxtQ0tFWGo2MDJVY2sxazRnc0hoWW5W?=
 =?utf-8?B?bk5UU0U0cThzQUNreWR5eEVGZHBYZ3YwRHp2b21FYXB1dnBKdU5SMEJwbnZX?=
 =?utf-8?B?RnBjWmRFbzllTkdMT0N5MTg4VGxnMVY1Uit5WFlZdzg0WlNxM1lsQitFSWJx?=
 =?utf-8?B?amVMUlhVWXlpUVQxMHBJbkF3UnpiQkIvQzgwbGQzU3dEM0F0ZVowS2tZd1lv?=
 =?utf-8?B?U1p0MmFxWndZUzJ6QU9MblBYM1ZIWWYweHhORTJFMkVkRzhxYTcxZklTcW0z?=
 =?utf-8?B?SjFpVGQ5c1pTd3VJbjhjcWV1KzgramZiTGJvcEFiMXJDZUV6VDhCTkVVL0ta?=
 =?utf-8?B?aXQxbEIySDFwUXFaOENhNUZMclY4bm93TExxYnpibHpuZlRFbzNXYU41dzd5?=
 =?utf-8?B?b1hPQ2ZOYys0dVVnemFWL0RnbmRZdTlEMXFLZDdkT2I0ZVNVMlljL1NZMTdt?=
 =?utf-8?B?N2xobHpiNjhRSmVlQ0UyVEJ1MGZQWTlGT0xYbmlpRUtRQlh6QmsyMzkzUzFR?=
 =?utf-8?B?SUVyQkliU0VFKzc2SXpJUllrTkU3TkpCQTd2QVpJRnF4TzNvOE84bCtTNEE2?=
 =?utf-8?B?QnlSZmUzRXRNQ1pBK3dTYTgrVkRSdHhHVHcrck83RGhBa24xTWd6dVZlVU5U?=
 =?utf-8?B?alBjSGVsaWc5L01YUVgyTHN6OU9NWW9hQ1VlUUNndmtSRldWU0tITk5TM1Rk?=
 =?utf-8?B?MWpFRTVPV09HdnRGQUJiaWlSQXd0Z0FxczdMeFI2TTI3Y2tkT242Y25saTFx?=
 =?utf-8?B?WTViekloOWxTRURmYks0d0tWTU5IMG5WV2RML0dUcnhLNVAzKzJSekhDNnBl?=
 =?utf-8?B?b3ZzcWkrZ0w0VFVRbVJYL3Y4b3J1VE9RMTl0b0dMUEw5enlkWW9ieUkreE5M?=
 =?utf-8?B?SXFZeGNHUEVtMWpEU0JxN3hkRmZrTDk2akRUZGVwTXV4YlFaMmVOUUpEK0c1?=
 =?utf-8?B?WFZoWWpBc3N0bzM5eG5KYW9xM1FGa3Z1dUJhNkdYRytENWtoc3BLYVRIOE9n?=
 =?utf-8?Q?E7bejp4kIwB9IPIAZr3BSgI+BD9sPs9FUl8sc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5373.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?by9lTytrSnFWeUMxTzZ4a09DbXJobThheDB5b3JzZFo2QTdFWE5RUDhMZzA1?=
 =?utf-8?B?YWNZREcwczhnY0IrTWFURmMzMkRCRTFxUHB5UXhMNm1KVUxzcFh3SFY0a21O?=
 =?utf-8?B?U25KYnd5aVpVL0dFNHU5ZEZWZHN1L3laVjRWSFhiLzFxNFI1NXJYSnFoVklO?=
 =?utf-8?B?K1JLcU1nbUVCNFNXQWdxL24wZVp5cUhTR1d0R2luRlhIMHRpaGN6WEduNGx6?=
 =?utf-8?B?dGh4Sk9sRUpqWEJBVDRNdWcxd1d1WHJqOFBxelFna3VXa0xMYmpEOVJiL3V3?=
 =?utf-8?B?N3k2UGxsVW5QRFJqeTdGaEpUZmg4Z2thbkorUXZueVlUMVVWLzVVVkVzVmFx?=
 =?utf-8?B?aDUzeFFtMmdhRlhCWnlGcDVXUnlydUluMDBOM21Xc2FRa05Lb3BMU3dhbUI5?=
 =?utf-8?B?ak9SaC9QTU1KUklIRVZNV2E1T05QV21PZmY0bDkvU2UzcEpxNUZoL2RnZElM?=
 =?utf-8?B?MWh0TlpnZnpmVFNtUW5NM2RnUkI5Q2U1TmZNTGFFMWxaUUswMUdUWFArUmtJ?=
 =?utf-8?B?OGIwd3g2czJUR0NpcDVtMmp3ZVl1S2tQNERBY1FxV1ZhTlA3SHFGeFh1UENj?=
 =?utf-8?B?eEc5ZkVhZ1BTZWFvV1BsbmVzdStkd2VWOXczSThIZDhzSWFpNXRrVnBuSzNZ?=
 =?utf-8?B?ZWZuSmswcngyWWRVVEVzQ01TU0V3dkxtUjN4a2d2ejk1VkVaOXZ6eDhDdlVR?=
 =?utf-8?B?Qk1wK1d5UHhNaWlUUW1ITTMzMnh4cEl6YjIyd3I5UUNzdnE2aXdzT1dBUEc5?=
 =?utf-8?B?VTI2aUxWelRTZWxWQ1BsUkZlT2dVUDNCNVBUV0VPc1ZTMlZoTm1SN1FkNUFF?=
 =?utf-8?B?OTIvUVlHdkxORHVxenRYRTIyZzBTeDVZQ1dxaXpxZGlmMVpLR1hsR29NRlBm?=
 =?utf-8?B?QWxtZTZwZ2hSdW90REJ3R2hkRjJNWDRnOERkM0puZWRldlpiZnh2MXpNeWVs?=
 =?utf-8?B?N3Rob2h0V0pGdXlNc1huL1BtY2JUWWF5RnhDa3g1NzRhWnczN0ZuLzFtSlNh?=
 =?utf-8?B?REhRNk9yQ0I4R2IvYXJxSW9qbHowcU1yL2xwaXQ3aWdyVTNaTVBFc1FoOENr?=
 =?utf-8?B?eDVHczVudGwvdFFGa3pGZmwxQ2ZUNDc4TkxmWjRTWDlCOVZYUC9XZC9QQXdV?=
 =?utf-8?B?YnpWYkplUmlPdCtOV3hYeXo5WGgweGxKR2pDUFhmdkpVRjMwVnJaZFFEa1FR?=
 =?utf-8?B?QitsNzBXT2lPeTRkbEhGY2dUY3RHSVJZNFdEa0Z5bmtwVUsrVm80QkQ3bm9H?=
 =?utf-8?B?VlVoTzBtSXpOKzJudUZSc0hMTVZ6YWxVbUdvSHNSTHBLWjNMSytublh3aSsr?=
 =?utf-8?B?RFh6cjdDcnZyU1VzcEhLR0FCN0J1YkdUYnI0M1B2aGxwdTJXbmxYeDdqQjQ4?=
 =?utf-8?B?Zk1PZENwMWJ2MzY4LzZiQzJHaDVBTERJZDJGblR0MFBTanltWVR3dFZYNkNS?=
 =?utf-8?B?MHBwU3V2K1JZdTBWYkpURTh0QWdGWGlZVlppZXJWMkREY1ZsRWVqYUxOVTdr?=
 =?utf-8?B?amFiZG42TEZsS0p4aHA0L2Q3WmRObXc4TmFpTkljQmNWckxhQW1FZXdsR0pB?=
 =?utf-8?B?alFQWjJSMng4bm1JamlweWFNWGpNWVJNdjRFRjdRbnNpdlpZcWFWcFg2Qkl6?=
 =?utf-8?B?ZDE1TEU5MDBEdTVWZUtYVkp5clpmaDZXUVZGZ0R0bXEzWTFBV3NWckNmSStW?=
 =?utf-8?B?Z0xsMHhPRVFhWGYydTRTZlF4eTJSYlU0Mk1sMnBJU0hEWCt6OVJoekpWeUMw?=
 =?utf-8?B?WmR1blk0WU8raVljZWFpRE45R1VET1gyNXJkZWxWU1JnUTZwR2FkMkpTdlA2?=
 =?utf-8?B?UHVFSHdvK0lOb05Md1NzTTYrSkZqRG9GY2JnRk1MbmhKbXVzekhnelJKRjVo?=
 =?utf-8?B?NVM5bEVGUWE3anFJcTV6RC94bTYxZklBN2dWL29hL2FPZ0xiU1RPWGxHa0Jp?=
 =?utf-8?B?Vnl2eFlCNVJQMnpJaG9rQTVQMFdMWnZ6dDlDeUJUeEJORGE0UWxBTCtJMlFX?=
 =?utf-8?B?alN0ajQvYkpLaVphRXh6eDlvZWtnaWU1dXFsYmNISHRvZ2lIZkl2S1lrZSty?=
 =?utf-8?B?OEhLTS8xcHR6OFRLME03cjdQazhtM3cxK2lzdGl6Mi96S25tMTN0MkVGVXhm?=
 =?utf-8?Q?xZeM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0c8990-16a1-4256-de1f-08dd15bd5265
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 06:15:03.1444 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: di+aj2Ji3RAii0wqPXwcmJxxLAUmlWae2QNcVgiSel9skhr3qGR312OxVqsAdbOq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9385
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
Cg0KSGV5IEBMYXphciwgTGlqbywNCg0KWWVzLCBKdXN0IHBpbmdlZCBWaWN0b3IsIFpoYW8uIFN1
cmUsIEkgd2lsbCBtYWtlIGEgY2hhbmdlIGFjY29yZGluZ2x5Lg0KDQpUaGFua3MsDQpZdWFuDQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMYXphciwgTGlqbyA8TGlqby5MYXph
ckBhbWQuY29tPg0KU2VudDogRnJpZGF5LCBEZWNlbWJlciA2LCAyMDI0IDEyOjE4IEFNDQpUbzog
RmVuZywgWXVhbiA8WXVhbi5GZW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogVXNlIE1FQyBGVyB3aXRoIFNK
VCBvbiBnZnhfdjlfNF8zDQoNCg0KDQpPbiAxMi82LzIwMjQgNDoxNSBBTSwgWXVhbiBGZW5nIHdy
b3RlOg0KPiBPbiBTUklPViwgZ3Vlc3QgZHJpdmVyIGFuZCBob3N0IGRyaXZlciBtaWdodCBkZXBs
b3kgZGlmZmVyZW50IHZlcnNpb25zDQo+IG9mIE1FQyBmaXJtd2FyZSBiaW5hcmllcyB0aGF0IGxl
YWQgdG8gcG90ZW50aWFsIGNvbXBhYmlsaXR5IGlzc3Vlcw0KPiBjYXVzZSBzeXN0ZW0gaGFuZy4g
VG8gc29sdmUgdGhpcywgaG9zdCBhbmQgZ3Vlc3QgZGVwbG95IE1FQyBmdyBjb3BpZXMgd2l0aCB0
d28gbGV2ZWwganVtcCB0YWJsZS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogWXVhbiBGZW5nIDx5ZmVu
ZzFAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlf
NF8zLmMgfCAxMiArKysrKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nZnhfdjlfNF8zLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djlfNF8zLmMNCj4gaW5kZXggMDM2NTRiZmRhNThhLi5mMjQ4NDQ5ZTkzYTcgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV80XzMuYw0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfNF8zLmMNCj4gQEAgLTQ1LDYgKzQ1LDcgQEAg
TU9EVUxFX0ZJUk1XQVJFKCJhbWRncHUvZ2NfOV80XzNfbWVjLmJpbiIpOw0KPiAgTU9EVUxFX0ZJ
Uk1XQVJFKCJhbWRncHUvZ2NfOV80XzRfbWVjLmJpbiIpOw0KPiAgTU9EVUxFX0ZJUk1XQVJFKCJh
bWRncHUvZ2NfOV80XzNfcmxjLmJpbiIpOw0KPiAgTU9EVUxFX0ZJUk1XQVJFKCJhbWRncHUvZ2Nf
OV80XzRfcmxjLmJpbiIpOw0KPiArTU9EVUxFX0ZJUk1XQVJFKCJhbWRncHUvZ2NfOV80XzNfc2p0
X21lYy5iaW4iKTsNCj4NCg0KVGhpcyBjaGFuZ2UgbmVlZHMgdG8gYmUgZG9uZSBvbiB0b3Agb2YN
Cmh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9wYXRjaC82MjYwOTcvIGFzIHRoYXQg
b25lIGFkZHMgc3VwcG9ydCBmb3IgR0ZYIDkuNC40IGFsc28uDQoNClRoYW5rcywNCkxpam8NCg0K
PiAgI2RlZmluZSBHRlg5X01FQ19IUERfU0laRSA0MDk2DQo+ICAjZGVmaW5lIFJMQ0dfVUNPREVf
TE9BRElOR19TVEFSVF9BRERSRVNTIDB4MDAwMDIwMDBMIEBAIC01NzQsNw0KPiArNTc1LDE2IEBA
IHN0YXRpYyBpbnQgZ2Z4X3Y5XzRfM19pbml0X2NwX2NvbXB1dGVfbWljcm9jb2RlKHN0cnVjdA0K
PiBhbWRncHVfZGV2aWNlICphZGV2LCAgew0KPiAgICAgICBpbnQgZXJyOw0KPg0KPiAtICAgICBl
cnIgPSBhbWRncHVfdWNvZGVfcmVxdWVzdChhZGV2LCAmYWRldi0+Z2Z4Lm1lY19mdywNCj4gKyAg
ICAgaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkgew0KPiArICAgICAgICAgICAgIGVyciA9IGFt
ZGdwdV91Y29kZV9yZXF1ZXN0KGFkZXYsICZhZGV2LT5nZngubWVjX2Z3LA0KPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAiYW1kZ3B1LyVzX3NqdF9tZWMuYmluIiwgY2hpcF9uYW1l
KTsNCj4gKw0KPiArICAgICAgICAgICAgIGlmIChlcnIpDQo+ICsgICAgICAgICAgICAgICAgICAg
ICBlcnIgPSBhbWRncHVfdWNvZGVfcmVxdWVzdChhZGV2LCAmYWRldi0+Z2Z4Lm1lY19mdywNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJhbWRncHUvJXNf
bWVjLmJpbiIsIGNoaXBfbmFtZSk7DQo+ICsgICAgIH0NCj4gKyAgICAgZWxzZQ0KPiArICAgICAg
ICAgICAgIGVyciA9IGFtZGdwdV91Y29kZV9yZXF1ZXN0KGFkZXYsICZhZGV2LT5nZngubWVjX2Z3
LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiYW1kZ3B1LyVzX21lYy5iaW4i
LCBjaGlwX25hbWUpOw0KPiAgICAgICBpZiAoZXJyKQ0KPiAgICAgICAgICAgICAgIGdvdG8gb3V0
Ow0KDQo=
