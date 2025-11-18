Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5050FCEE338
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 16:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E02F310E054;
	Tue, 18 Nov 2025 16:23:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N8jrvac7";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012062.outbound.protection.outlook.com
 [40.107.200.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32C4F10E054
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 16:23:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PW2Z2R0Ph/onZPsb7MG1Ua8f5dlHwqY1F5QBRtsBXLMjMY6ZOgJs9QffATtbE/IGvK/1e2UX/6Yl/TUmyJrcvqqTLdqlhtRGepMeqXyNu2TpCtdGJDSAXB9aU6QGBimxtAgikRoQIXSxbCu0xYBdxfNnebpNdS5VokGW1m26viv1Rqs7F+hX8fcdNwUKf65zcMdlV2aA0+mTlPxk2E16my50X+pdpTYu4nl9IrKgblKjL7yy7wE49JG3BFRxnBd5pv9GqywPy47vc7qnz6VWuLJNTFyx4Dv66HVxJ3nSHrebrkLcWMEb77RmD5f3/3NNPRH9LV5zaA8G0os+pGkVYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIUQlxPIo6LoRArO9PYdPl/imuySpxvwZQYAq2w7Ry4=;
 b=lW2diNQJOhLNSo52esGALkovjW4deeVC155Uhe2DwTXSaakjns/UcwD3mjPJMgC9FiRTVcr7PR1FQn7WXlWh4/KQmu/CVuncRc3rGeRHU+TAQNyv1zKvnKPZxTOUnfR2MSuka+8UMbRWnLl3NabjhY8jKxIWitYh5FXgimOQYnuE6XvJTjzeRiqzT3BrBqjXjumu1ZpM8iqBQaKol/uqbyLTLpePCC2SYn5CHLReB1gIe54+7AiOIWUlXggjApMaA9D6omcw2IY8mwlcQKGlwqx/Z4Hj5Cb7Em9AcpJfuYKyW0U4Fvy/Hi+AnicqVgkspwGACY7hYp0DEcxCKzbLDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIUQlxPIo6LoRArO9PYdPl/imuySpxvwZQYAq2w7Ry4=;
 b=N8jrvac7egfWRvPdSnCBYr7uOIXWHuPsvEN95GQkX/uFp/QISNK1/iju45TOka/IvFijuVHa21QPqHv2f74t8ZhDSteCxIYccx8EiuSMuTmlwHcXw7DeTaklk4DdNsb5++knYqUBhxUkgX8WmxN4yDDVg2b5La8dhyaVKdqDd9U=
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7)
 by MN0PR12MB5787.namprd12.prod.outlook.com (2603:10b6:208:376::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Tue, 18 Nov
 2025 16:23:11 +0000
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::633:3c3f:3a9b:993]) by SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::633:3c3f:3a9b:993%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 16:23:11 +0000
From: "Martin, Andrew" <Andrew.Martin@amd.com>
To: "Yang, Philip" <Philip.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdkfd: Uninitialized and Unused variables
Thread-Topic: [PATCH v2] drm/amdkfd: Uninitialized and Unused variables
Thread-Index: AQHcWAXAzxUk3QIdyUWGapwXfxDM2LT4lT6AgAAH/qA=
Date: Tue, 18 Nov 2025 16:23:11 +0000
Message-ID: <SJ0PR12MB81388904A944EEDCDC41668FF5D6A@SJ0PR12MB8138.namprd12.prod.outlook.com>
References: <20251117210402.2213429-1-andrew.martin@amd.com>
 <49df5d58-1482-f6e1-3b5e-3b8e785ea2bf@amd.com>
In-Reply-To: <49df5d58-1482-f6e1-3b5e-3b8e785ea2bf@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-18T16:16:05.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8138:EE_|MN0PR12MB5787:EE_
x-ms-office365-filtering-correlation-id: 037bee8d-dcc2-4b84-2fcd-08de26bec446
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?QzhmSEh0SnVQei9sWE9xUFZOTjV2WjFkdkRWWERaQUtZQVBLeGtoaTBieGtt?=
 =?utf-8?B?VGJKWjlpYnYvMUNnc214YzlpakE3Y3ZJQWVyOFdna1JDU2czeHZVTytOV2xD?=
 =?utf-8?B?ZnFaamVpZG9aVWxqa2hPSWVua1NwVmdyck4yS2g1c0dqL0M2emJRYzA2T21X?=
 =?utf-8?B?czF3M3JQQSsvc0Ztd21nZUZiVkRGV3FvdmkwOGJPeDU2UHpBUGtFWUlTdUhz?=
 =?utf-8?B?UVRlRW1Xenc0WnNOSzc4TG1SUGFXK2ZmTTlSRlZpdG44L2pYNTk4MkFrOUNS?=
 =?utf-8?B?OG5acGZEU1VUZkN3YU9LSWRpR2pGVVk2TTNUNFduMy9kZGE5eVpSTjc2T0ZG?=
 =?utf-8?B?enVVaXZXODlwcEIrdFVxWnNMT2gwbE1ZNHp0NWpNWmJHL254ZHpBRmJZZkxo?=
 =?utf-8?B?ejhydTNiaEd0MERUM3crNXZaM0l1NDVGa2hOeXYyTWN1UHNVM1dwUGx0UVln?=
 =?utf-8?B?Kzlxby8yQ1FQRExUdkVOUkY5ZnEwc1Bvc2hJdXYxWXBMKzlOVTB0bDRRTFpP?=
 =?utf-8?B?OWY2WmtnVmdjNUNOaTZMM3BPOGp6SmlDWkNkbmYxRnRqZkdPaDBpVXRiYTVz?=
 =?utf-8?B?QzN1aW5HSlRCSUlOck1idW1QeG1GdWRhWTQ5R2ZJdC9vN1VMOTk5a1l4b0d6?=
 =?utf-8?B?WWRub0tYTWpvdkVlR2VoNkJFYlBna2pLcVpjcUgvNFhEMXlha29ialE2dm9M?=
 =?utf-8?B?emxueExTelYzMlo4R21idEttb1BPSU5oMEFHVVUvTXc0T1B4WlpIeUFGR1hB?=
 =?utf-8?B?ZG9KcnJnZDFiYnoyTmxJUU5xbmVDd01qZVRQai95VW1Ea2xKbDlKVkZ5WnFK?=
 =?utf-8?B?Z09BQ3BEd3VSblNPamI3VnVsRy84QTVDb294Q0xxNVE5QWJmQk1rOVR5ZE14?=
 =?utf-8?B?ckdOQXQxZ3dnTU5rSU15TTcyTFQ1OC9PeUtNQzJtS2NIU0lNNjlJU21WT09i?=
 =?utf-8?B?VHdPb1hPY01kbE1CY05SaEd5RGo5RVZ4YTJQYXpkWStJdzVpQytkQmlsc0Rm?=
 =?utf-8?B?azdEYWV6SUJPVXNLenBVa2FwRzF1b2NZKzhEYk1ubjNjOXhHUUNGN05uUEEy?=
 =?utf-8?B?d2p3UGVuVUJVNUNhL2NmTlpEd3FwNy9LZ3B4TFZhNFk1ckMzN0FGWDEvM0Va?=
 =?utf-8?B?OUpFYVU1dUZEWUN6TitGeUR4by9QdTA0cjEySkNJb3Fxa0ZJQkE4Zy9ObTE4?=
 =?utf-8?B?VlAwTVdqTXF0cWt1L0ZGMElDa2tUZWVPblU4cTVOeFNJRTlqNC91OTRMaVo1?=
 =?utf-8?B?K3pFdm1aV2EyQmUxWTVDZGJzbFJoeVBPelNseFczWFQrb0c0QnVGc2ZYOGgz?=
 =?utf-8?B?N0dsTmh5ekEwUm9vWWFEMUJCOFdWN0QvaEp5OU1peFZuWW9YVkdIc2RWREQ3?=
 =?utf-8?B?ZzhiY0U0Z3hnKzNpODdrTnN6OUxsc3FXbjlBWERQLzlyRVN4aENsR0JGbnJR?=
 =?utf-8?B?dUhYOG1OZnIvdnJqa1NGRlIxR010QWd5Mi92ajRmRDFhTHZxRE9UY1djZGFp?=
 =?utf-8?B?WDBQaG1QTElGM0g5b3dETDR3OFlQSmxLUTNibXMxZC9hZ2pLS085MVRsUmk4?=
 =?utf-8?B?eFhSKy8xVmNEd29wdlh0SmptVDdYS1BqUWhIaW1rODc4ZFhiaE9aUlRzUlBq?=
 =?utf-8?B?Z1B2eTFzNkQ3aEZEcVZEK3MvZExBZ0RPVEcybFprdEt5SVRzU0xUN1dRWE5P?=
 =?utf-8?B?MnU0UjluZlJReEVlcjNSYTFRaWFBaEg2TWV5L012V1V4R3hNR0tTYXpxaTNP?=
 =?utf-8?B?aHZmc2xZYlcyY3NaR1RtTVBXbk5pWHFyMWJrVlhpeHVNa2lnSGJKbWZDWS9q?=
 =?utf-8?B?VDkzZXpnZnJaZGVFTnBVRy9tcVRrSVZLTXBmdzV6RzJzNjk5SWtFY0FybnQv?=
 =?utf-8?B?Ri9LeHg3dGlqeWxSUmViTnpjaDJabTVhMVY0SkNLQ1dVaHluc1dwNHYvaFhi?=
 =?utf-8?B?amc4U2ZSanpwR3FqTFRrMGdzaThQTUszYmdScHpmclRZay9PakFxYnBjSC9p?=
 =?utf-8?B?Y2E2UGhPQzhWaVlyRC9OSm1pZStTcUwxdGxSaWV2ZjdqZ1VXYTRNdXlqM1RF?=
 =?utf-8?Q?j3BRjF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8138.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWUvc0RXbEZ5cXBwWkYrR3ZiK09OUHF5MlpycGVtcUF0RWNxanl6ZHNUQXlL?=
 =?utf-8?B?WUVPWFZiTUtCbHVTV0RmZm9wS2dITE5Gb1lFamRGeXNpS1lTTmhFM2xwUE9k?=
 =?utf-8?B?RnptNnlZWkViQWNZZnBUdkt0U0ZBaTJZdHlrSkhYa0VUdHVSYVE5OGRGTytO?=
 =?utf-8?B?TDJ3Y01tL2pHTzhYTkJPdDF5OGRiVDNvS0F2T0FoZDBqbkpoeTY3Q2Z0aEcy?=
 =?utf-8?B?S3hPdG45WE1yV2JENmFOLzQwN2NYUTRBODlJeXhKdmxCQVV3NWcwYitSaWlw?=
 =?utf-8?B?TGpxWDlvZWw1TUlCZjNxMzc4N3NXVEc5UkhWWWM5WWRrdWFnSzFpL0hsa0Iy?=
 =?utf-8?B?bUY5MWFYT0lZc0Nqd3FFbEpHbDAzNS84WjNCOUgzMjNCbGlEbDBUWDZDQjhE?=
 =?utf-8?B?R0REUWtsd0lBK0I2SW9jQTdUOTdTKzRQam4rUWp5SDFBNHFIQWQ0VnVHYjkr?=
 =?utf-8?B?VitXNkpJVVhDSzYwTjV0aVBFTy9pOE54UFFlM2RscVZ6WVU3QnhqdlRveGtV?=
 =?utf-8?B?RlBSRXFlRFRCOWRqOU54TW8rekZTSCt6ZDlvNUlObFBHNUV1bVRwdnZiRnpx?=
 =?utf-8?B?UmlhN2Y1OTJjWlhYd3Bsa3RKbFBrZ1haNCtEVEg1Qi9CejB2bGZtNjdmMGV3?=
 =?utf-8?B?OHBiYW1KYlRWTmlLaDBRbGtvRVJyUjM4bmxjVHVuTWM3THdnTkU2Q3RycHJM?=
 =?utf-8?B?YXVUZ0lucStTV0h3VEUyNzllY0JaRmg1bmp5YTdOTFFHc3Nxcm9iVDQyWmhQ?=
 =?utf-8?B?N2oremtCdUppUzNMMVVsZUVUS01Dd0NiV1BncFMrNXNEQW1GRUxzV1Q5Snpz?=
 =?utf-8?B?dGJUQzhtdUV5U0IvTWIzcjI4VU1zVjZxL3ArSUNVVmlNU0dNYlMzZml2bkxi?=
 =?utf-8?B?VlVOeGo4VkpIalJnQnB4VGxJRVE1NWFvRGs3S21KQ3ZneWd4dndxWG9WVDNs?=
 =?utf-8?B?ODFrQnRQOEVyK1kyTWZuQmp3UlQzNVBtbE1zbzlmNzlZcXRPR00xTVRXQmth?=
 =?utf-8?B?R241eStYYTdDS3pYZDlVWnZhRStic3NLRFUzWnA1V2xPRlN0cjA0QXlNc2Fz?=
 =?utf-8?B?bjRhT0RUODlrdVkxQXIxaHNvNnN1WWw3eWdwVEdUTlpnWmMwRUd0bVpHckFU?=
 =?utf-8?B?VkRvdGpqTU10ZDdSZWRrMzZTdHNPQlJtVUpkS3VMVTd6SUpUUkhPZTVzMTZP?=
 =?utf-8?B?a2JlZXFFNGJ2cHhGTXVKYXJ6dGdWL2lEcG4zZEd5bzBTaXl2RHpzZGZneEJQ?=
 =?utf-8?B?RjEyQktySHYzbDBEK1pWNkppYzhDOVR5aGRMRXJVRUpDdUJxOE9oaUE2T1Na?=
 =?utf-8?B?NHVUWXZ0WkZ6RlFuSWZwUHdlcHU1YTFLVStMRFlQT1lTdSt3V09VN0Y3aWZ6?=
 =?utf-8?B?dTJWNVZzRFVsUmpJM1lmQ25ia1hWMFJYVisrTS9HQnY3N1dESTh0QjE4S2p6?=
 =?utf-8?B?NXZ1dGRoMnl2Q1h2c0pIYWFmKzQ5OVFuaW1KOU83dlNlQUdsS1A2REh3MW0r?=
 =?utf-8?B?ZThzbHZ0TjlFc1FoeCtiWVdjNklCQUlBZVRNTjA3S09pTmQ5Ryt3THRtdUdl?=
 =?utf-8?B?eUVXRENueUpvU0t1eHA3V2QwZ3RSaVRDVkFhcysrQXkwTzJzam92ZUw5YXQ5?=
 =?utf-8?B?ejJzY3RjanNzTEEzVHBxR1ZxRHVBekpzaGo2ei9aV2g2NW10OWNMVC83TGg2?=
 =?utf-8?B?SWhnVkczSktzNmkvR1pPVWI0WjlkaDdJN2NzVkVRTzZIT1JZelpBSTFMVkRk?=
 =?utf-8?B?K1l3MEFhdHhLb2ZqTjdUUFA0SjBJNjRMcnBoUjZwNXU4cTlBY25yVkRNRmhq?=
 =?utf-8?B?QldpOURyZ2VtZDExdFNQTXNEd0VqaXFiY3VjWU4va2RzMUNNbFk0WEIxNjNk?=
 =?utf-8?B?NFUwWVlJckRSa3RhZEx2Qyt1RERrTHB0RnRJODBSSERqby9WVkRIMkNuUVh4?=
 =?utf-8?B?ZGkvSTFYZ1FkN1YvaEg4ZGNWWTVBTTM5akJuQW1YQ0RzdURNNkdmUEJUWTBD?=
 =?utf-8?B?TWt3ZjRzeGp2QWp1NXc2QiszZ254V3pLcXlXZmhLZzhCVUczMmhISVdWWWV2?=
 =?utf-8?B?YjZOUzBJSGh5dFRVbHhnaStSVmxNU0VSUWwya0FMTkxYSWxjajIrNis3YnRp?=
 =?utf-8?Q?7MHE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8138.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 037bee8d-dcc2-4b84-2fcd-08de26bec446
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 16:23:11.1694 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OFeSpa5AUItLZtoptSFur+nl7GIwcyzGUhuwHTKGYtFrIgwCYyW/Nw04/Y+R61+myHPJqH/Dsmy8TULgssoRHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5787
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
Cg0KR3JlZXRpbmdzIFBoaWxpcA0KDQo+IEFsbCBvdGhlciBjaGFuZ2VzIGxvb2sgZ29vZCB0byBt
ZSwgd2l0aCB0aG9zZSAyIGNoYW5nZXMgZml4ZWQsIHRoaXMgcGF0Y2ggaXMNCj4NCj4gUmV2aWV3
ZWQtYnk6IFBoaWxpcCBZYW5nIDxQaGlsaXAuWWFuZ0BhbWQuY29tPg0KDQoNClRoYW5rcywgSSBh
bSBub3Qgc3VyZSB3aHkgdGhlIGVtYWlsIGBnaXQgc2VuZC1lbWFpbGAgZGlkIG5vdCBwaWNrZWQg
dXAgdGhvc2UgMiBvdXRzdGFuZGluZyBjaGFuZ2VzLCBiL2MgSSBkaWQgbWFrZSB0aGVtIChBbmQg
YGdpdCBzaG93YCwgY29uZmlybXMgdGhleSBhcmUgZG9uZSkuICBBbnlob3csIEkgd2lsbCBtYWtl
IHRoZXkgYXJlIHByZXNlbnQgYmVmb3JlIHB1c2hpbmcuDQoNCg0K
