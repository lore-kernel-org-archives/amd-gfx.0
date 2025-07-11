Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28750C83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 07:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B05F510E9BE;
	Fri, 11 Jul 2025 07:46:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bvB/OCzA";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8E9210E9BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 07:46:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzM1PgQbN2DtOMCfq6hAit4vx94GYgZww05QJ1JeaxDXJtJr3ueJNWYFpVW70M2Wp7OgsKwfVtXo5Et47YQp++WcreJbJthlayU48hhLbCbVzKdPvPNHdo41870Ul5HIDR1p9mtWg52oq/tFDSkrRG49g1TrFvTGw7PDc0Ym3QNluNUgqqq8pcBL9rZrS5I9whvziRWtCNtCkO3h6B3JCHjCSK8CH6kImjz08hisAGLPhJR9JdySzwHiUoji6uedcWU9TOKb6zpAhCB/UkfvILNBuQ8Qm2syK3D1vY/IntrvLgfs871Rxaq6ZhIa1F3gojgSnTL+/PalxBTe2lZSpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSqIaKfgqcZQgeZhymN6VymC5s87xjzFFRayCkdXHs4=;
 b=aRWK8W0ENCGEinGtJQFfG5AVuJwBZ3WEHVnzknJWqW+lKHkGrv3GYMynDPBfxIw3yDiVQGQ/nHiSefsu+BY5YLmCx4d+ymlQvpZ3hZWzxyxagBwl/4saLkND2KtXye8AXhKPNACg5+gvZhKuth5aC2ElmIp89OJUiU2K5iSiSSncCSZee64UGdPtAg+GMDoyUEZdcsj03JxFuLxDmhQbEeCVvkKWmCxNF2bJpgg930exAE/2j8fiEF9nI70JQKT9zmDJ/RCsGoQsDGF/JqvCEjnyAvUFdR4t8GdyMkweuqQWRB1p9w9VD1P5J1TH8dNivTiDrwG4qhhJh5xGDP52sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSqIaKfgqcZQgeZhymN6VymC5s87xjzFFRayCkdXHs4=;
 b=bvB/OCzAUyxReCO6Lg7KO8WJEhluUNLYOw2pMpD4x+kZsqb+GEN/0e2672gSDsCzJfj1Pa3V7amw5KFfJtAlCRcJDngNeye3vKGfpB8XeXe3hh2bgtOJ6W3Ss4i9GXPp6bIi10jlbyRGfZ/dfua0gBn8swCqdkOOuuxcZ4r/bDA=
Received: from MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21)
 by SA1PR12MB8597.namprd12.prod.outlook.com (2603:10b6:806:251::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Fri, 11 Jul
 2025 07:46:47 +0000
Received: from MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::9eac:1160:c373:f105]) by MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::9eac:1160:c373:f105%5]) with mapi id 15.20.8922.017; Fri, 11 Jul 2025
 07:46:47 +0000
From: "Xie, Patrick" <Gangliang.Xie@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: refine eeprom data check
Thread-Topic: [PATCH 1/2] drm/amdgpu: refine eeprom data check
Thread-Index: AQHb8g1J7kURjsX+BEaVGNNwC6uSmLQsg30AgAAIMZA=
Date: Fri, 11 Jul 2025 07:46:47 +0000
Message-ID: <MW5PR12MB568466B947006E5AF0E72EB9E54BA@MW5PR12MB5684.namprd12.prod.outlook.com>
References: <20250711024059.25658-1-ganglxie@amd.com>
 <46073fea-6d57-4ad1-a835-6541c4360a78@amd.com>
In-Reply-To: <46073fea-6d57-4ad1-a835-6541c4360a78@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-11T07:46:20.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR12MB5684:EE_|SA1PR12MB8597:EE_
x-ms-office365-filtering-correlation-id: e7bc7d38-976c-4214-4d43-08ddc04f16aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?cy9yVFlyc3drc2diSG56SWVicXF5RWF6dU5Hc3ZXL0VXcmFvME1LQ1VYK0lC?=
 =?utf-8?B?QS83eGVTaitPR3JONVdOZG9LN0FObUhvd2d1aU1kWDZaOWRwWVJ3T3pBeVpx?=
 =?utf-8?B?Uld4UDZEd2wyOStKQmRLMWR0Rm15Yk1HOVM2ZDRJVmM1ZmEwaDNuczQvWTZX?=
 =?utf-8?B?VVBzYmY0bzVqdHByOHgwZEJkZ2tYeXUvdXlaYllWaDZiMnNWMlBBTStwYjZD?=
 =?utf-8?B?Z1picW9TRDhSMUc4K21vRVhIVlFLTm55b01XV0h6NDZPaWd2T014OUh5YkJC?=
 =?utf-8?B?NUxTaFNRZGZvYTM3Nm50RzY4UXhhTit3QnNpWnFtdFBtSUEycnhpUDRqVzYw?=
 =?utf-8?B?NWRCWW40aDYreHowNEFWWUhPTUR1MVlCTW03djc5bXpxY1Vwb255YU1pVVAx?=
 =?utf-8?B?MjFsUjh4SXY2K3RlRVZQbmROdklINHVyd0swVHFURklTRElISUp1Y3pRK2xJ?=
 =?utf-8?B?Z1B4bkhHUG9sdWpaTG9xWnlwZnNMTXhaLzFXRnkwUWdYcWxaSXB1MTFUR1Vr?=
 =?utf-8?B?N0VUQmg5RkNZZE1wQmZtTkppTDA4YTlwNXA4V01Nbjh2YnBtaE82eXUrdXJ2?=
 =?utf-8?B?bDNBVmpWaUNyTEFIU2k2UE5jTnNISEM3K3dCM3Vydk5uTFVvWkpaNTV4SE9p?=
 =?utf-8?B?cU1BSGt3Uk1NbHRNamFQdlpKWDA0c2lLUWg4RzAxa2Y2TitWcHo2dTRIZ2Fi?=
 =?utf-8?B?c3dRN0VOUDJZYVpjQ25OQ0lRTHpGNXlib0doNCtzMVFQU09qeXliY1JVeFFZ?=
 =?utf-8?B?R3A3WTlTakdCQlMycWpRSEpUcnZmSENsb0FnYzY2ZXVwa2o4NE9LZ2VPc2dn?=
 =?utf-8?B?Mk9ZKzFHeTN4eHBEenFZcTJ2TFZ4QjZraEljSUkyWXlvYm1ScUc2KzZwdlhT?=
 =?utf-8?B?VHNIaU0zRHdCWHpQMjJ5Q0xvMndEUnVrLzNqUE9NaTM5Z3dsMXZReTFpbW5k?=
 =?utf-8?B?Z2prd1Rxam9xaUFMUXJWcjQ0NXN6UTlseVBPemRoVHNxVFl2T3VsYnVIWjZp?=
 =?utf-8?B?dThYdEx5ZUlJSEJPYWxyQ3N5WXNPUEhzNFB0RE1uVEQrVWNvWmVzczZoOXBv?=
 =?utf-8?B?VURFZ1pxVzNzanJsQTBOTXRlZkZWaUFnbGZsSmxHRHlHaElXS2RHYmgrQXdY?=
 =?utf-8?B?WXJ5U2pLZEFRWTFlQXJEYUtrUDNwT0dzdWh2Z2tCSHF2YmpqZWxnMGJVVEhD?=
 =?utf-8?B?d0ZSQkx1b0pEYk5QWEExSlZRV0pzejNmNFlyTmhjcDc4djg4K01RbkxLSzVZ?=
 =?utf-8?B?QVZqZ0Iwd3pDdmN4RFBGTWNmQ0JHNTh3U2V4YWYxTHdXTW5PRzZzTXFNQmFn?=
 =?utf-8?B?YWNSYWhGOW9XWGQ0WVVmWFR5eE5Uc296WXoxMWxtYU5zZ3N0VWdvUnVHOWNU?=
 =?utf-8?B?bUY0UWFEN3dGaEtxbkcyVUtha0dFL3VMU3UyRGxERUV1TzR5cWp1aXhaOFQz?=
 =?utf-8?B?NUlIUXRhNzZDZWgrOGZpc0YyQldDVFQ3Qi9Wa2l4akQyQVAvaFRaK3c5VVNW?=
 =?utf-8?B?eW5XaGRaMHRmM3FnOVM0NHdqSGN5VEhoSU5NTGRaYXc5MjFRQzRvMWxQcWxD?=
 =?utf-8?B?RGFablpXcEdXM1NJb1Uybm1vZC9FVTZjSTJLWWYzQ3VRdndpVitvWGVhaysx?=
 =?utf-8?B?T3ZyMVhZVkFjRlZtV2d1dUlJeGNCVVhwa3E4eWF2TFFJSDY3QW84bjA1d3dY?=
 =?utf-8?B?K1V0SkU1dDF5aTJPd3JVTURFNUQ5UVVoS3NTL2dEbmlaNWtPU2FycGNWTTN5?=
 =?utf-8?B?RDRZNktscld6QmphSUFOYzErZmZ6Y1NzMHdSSzBlMlhZOGs5SnhCWXZoMlRr?=
 =?utf-8?B?RHFWdHFWS3VnSVV3Tko0ZStNTHQwNnJISU9ZZ04zZlhWcTlwb1NwSHdwZ2FV?=
 =?utf-8?B?T0pvbUpDK2xyYVBhSVRhYVpQYkNtYThyVG1uOEh0YUlSMlQwWU9qTjFIU2NN?=
 =?utf-8?B?R2ZVWGhpUklqeW04cENZQngzdC9CWHdXOUlQVFpDUCtBcHV4WTJWanFhbTVh?=
 =?utf-8?Q?e7SgKJPSW4oZrgPKawTWMVz49Xq8Ts=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR12MB5684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bW5YWm9iRldodXVVVG5IbGlPTEFMQldURW5EMGVkaDhFZlY3OWFrVUdIVTFQ?=
 =?utf-8?B?N0IrOE9JemtVT2U0ZjVzUERBS3RnUWxIODBSb2lxbkRLeU1FUWFXb05OVmg3?=
 =?utf-8?B?bmJGZlIxNEZUb0dXalNlSXhTWTNwR3M5VnFaTXBVUVJ5bzFvQ2N5OXpDOWRE?=
 =?utf-8?B?ZmdXY052eFNoOGNMekxPVWpoR3hCbHFFWXdod2VERUg0V25EUlZoTis4aExR?=
 =?utf-8?B?dTJEZDdxMDJERzV6aWFyUHlJeXBrM3F2NmVmSzBtWkJ2ZW1vU1hHM0hOb2Iw?=
 =?utf-8?B?cnFwM0hmVzU1NWpvOTg2MDcxZ3NZWldGVFdCUTlZZGNmQlNTdS93V2M4ZFBh?=
 =?utf-8?B?S3p3Q080RU4ydmh1MWxJZXBhKzFEZHpNa1BwYXRiRGo0Rzc0NlZmQ0NjRmxa?=
 =?utf-8?B?aVJ3dWhmYURocmVmcmY0TGZmdTBvRlEzL21jNDRCUUJsazZIakNEcFZrRUhi?=
 =?utf-8?B?TjRKQUtieUY5dWJvNUFiNkNWdk1VYUkzK0Q3UExMNTZNRHl1TjlMNUtUazM4?=
 =?utf-8?B?R3FuZnR3UTUrWGdKUzRpT0lmazFzSUhxekJ4K0NQRml3TS96VzljUEx0ZHV4?=
 =?utf-8?B?bTdZZzVjaUpPOWdZbnd3OXFGZUJpbWNMeFp1ekcwNlZ3R0tOcGl4UXhWbFd1?=
 =?utf-8?B?cmg4d2x2TEo2emhPWnl1dkh5WFYxbFpKS1hhakhrTjNSOVhZYTNCSGROaStz?=
 =?utf-8?B?QmtNeDAvSDJHMHdVd1FZZ2lYZjIxdC8wLzIveVpOVXBObmsxMGdGcFBJZmRG?=
 =?utf-8?B?UXhPUFBLTUhUT3BTaTNIT3Z2TXg2bkp3RFJHWjAvWk9YTVNxSmhOV3NjTXR2?=
 =?utf-8?B?SlVrckVnbml6V3Jjd0VPeHdaTHo0M2xZbU5ieVVaaEFKN3BWUk5iZWZCU3c3?=
 =?utf-8?B?Wi9VUE9kdmtTN3lvUm93NmVLdTl0a1dmcmRDVzJ0WG5EeUhNSklKRE1nUTBX?=
 =?utf-8?B?T2ZVdEFMUWVwZUM0aU5ISTJVOWR2Y1BiRC9CbC9KWitPeVZ6ZXpoU3VDRkZF?=
 =?utf-8?B?UXdSbmhGTjhNdHFodVlNM2NSaDJpSHc2T3poRldkZkxUM0VBTlhBcXBhcDEy?=
 =?utf-8?B?bVNTd0tMV243VmZyWUdybFNBRG15STdGOE93R1NHb3lGQnZpSkRHaVErdVh4?=
 =?utf-8?B?cXN1VWVtVHZhSnNRY3Y1TnN3M01RK1cxU1l1WUhjZ2hjRUxsak84eVpJN2ly?=
 =?utf-8?B?R0R5am5ndU9DbmpIQ1VJWk5UUEoySy90Mm9sTko2S3Q1ZGFNTnV6RklCaU9m?=
 =?utf-8?B?emI2QjZaT0k4bjdTWlRGR0IySHBhc1ZVcjVmdlVWOHIrSWViT0VPVGNabGNz?=
 =?utf-8?B?RmlrL25WaFBreGNtamdha1E4L1kwNDQzdkJiU3RnTm5aV0xPSDdiV1UrNXB1?=
 =?utf-8?B?UXVKQ211MmIwbUx1T0FkOVQ4MWVvVSt1L1dXQlNiQjdaNHdPWmlGZE50azBw?=
 =?utf-8?B?TkUzNHA3ekw2M2JOeTE2SDJ2Zzd0Q01DdEZwZ0VxS1JnVWh2eEU5bTJXSU9i?=
 =?utf-8?B?NkZYMUxzUTMzcXdWWXNKaFh2a3BLVUM4SGt6M21IVlNqUDFWMHE1VVlwa3Fx?=
 =?utf-8?B?Zk9nVTZJZy9VRVJZNU9HeHQzb3hJOUM3M3F1YWg3cnp3MGdjcTFMRGNUdnh6?=
 =?utf-8?B?RW5lTFlJZWNrS012dXgrVUs0dUtsYUhvNGRvdnVwS2k2bGFlQTN2U2VlS3Uw?=
 =?utf-8?B?L005WDIydXRNeHRNK2ErRFhla3NhOUozdWFxU0xUK2xmQ0hoWDZaUGU5UTBI?=
 =?utf-8?B?QlkzZ3ZYWVUxTEVhZDE0cXNrcm1PemZiaGhCWW8zZTgzOWIwYlhoMUdhMjd2?=
 =?utf-8?B?VnE0ZXEzK0V6NyswU0lHSmVjUUt1aFRmR3U1WmFFbDRSMlpHSmpzRXQ5TlRa?=
 =?utf-8?B?V21IZWg0ZEFKak14ZW00d0ptczZRR3RoS1lUdk9xcnBPQVBuYXlBVTY0MldJ?=
 =?utf-8?B?bC9vZS8yZUE1Tks4RnJ6N0cxMkFYeFIwVEFQZ2dNbzg0TjBOU1llY0xkVm9x?=
 =?utf-8?B?NDROdXFTRTZPcTA3WXFWTFl3c0oyZmVQRkhQb1NzMjZIZ1JYZFVXeGExMDA2?=
 =?utf-8?B?K1B2djUvcnAzeXdsRFZTMFJIME9GMndJRDFPSjN6YlJ0WkNmbEFKVXhZc20x?=
 =?utf-8?Q?Z6VM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7bc7d38-976c-4214-4d43-08ddc04f16aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 07:46:47.1141 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L95w96f1cyzlndW4Op66fsuLmgPTKx850Y8zcp8vpk/7vgrx1aEEpfhnh8crPR393VZa8+1E6o9qa0CGz+Oi7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8597
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
Cg0KVGhhbmtzLCB3aWxsIGFkZCB0aGlzIE5VTEwgY2hlY2sNCg0KLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCkZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQpTZW50OiBG
cmlkYXksIEp1bHkgMTEsIDIwMjUgMzoxNyBQTQ0KVG86IFhpZSwgUGF0cmljayA8R2FuZ2xpYW5n
LlhpZUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBaaG91MSwg
VGFvIDxUYW8uWmhvdTFAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBkcm0vYW1k
Z3B1OiByZWZpbmUgZWVwcm9tIGRhdGEgY2hlY2sNCg0KDQoNCk9uIDcvMTEvMjAyNSA4OjEwIEFN
LCBnYW5nbHhpZSB3cm90ZToNCj4gYWRkIGVlcHJvbSBkYXRhIGNoZWNrc3VtIGNoZWNrIGJlZm9y
ZSBkcml2ZXIgdW5sb2FkLiByZXNldCBlZXByb20gYW5kDQo+IHNhdmUgY29ycmVjdCBkYXRhIHRv
IGVlcHJvbSB3aGVuIGNoZWNrIGZhaWxlZA0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBnYW5nbHhpZSA8
Z2FuZ2x4aWVAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZHJ2LmMgICAgICAgfCAgMSArDQo+ICAuLi4vZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9yYXNfZWVwcm9tLmMgICAgfCAyNSArKysrKysrKysrKysrKysrKysrDQo+ICAuLi4vZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXNfZWVwcm9tLmggICAgfCAgMiArKw0KPiAgMyBmaWxlcyBj
aGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZHJ2LmMNCj4gaW5kZXggNTcxYjcwZGE0NTYyLi4xMDA5YjYwZjZhZTQgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gQEAgLTI1NjAsNiAr
MjU2MCw3IEBAIGFtZGdwdV9wY2lfcmVtb3ZlKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQ0KPiAgICAg
ICBzdHJ1Y3QgZHJtX2RldmljZSAqZGV2ID0gcGNpX2dldF9kcnZkYXRhKHBkZXYpOw0KPiAgICAg
ICBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGRybV90b19hZGV2KGRldik7DQo+DQo+ICsg
ICAgIGFtZGdwdV9yYXNfZWVwcm9tX2NoZWNrX2FuZF9yZWNvdmVyKGFkZXYpOw0KPiAgICAgICBh
bWRncHVfeGNwX2Rldl91bnBsdWcoYWRldik7DQo+ICAgICAgIGFtZGdwdV9nbWNfcHJlcGFyZV9u
cHNfbW9kZV9jaGFuZ2UoYWRldik7DQo+ICAgICAgIGRybV9kZXZfdW5wbHVnKGRldik7DQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzX2VlcHJvbS5j
DQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhc19lZXByb20uYw0KPiBp
bmRleCAyYWYxNGMzNjliYjkuLjI0NThjNjc1MjZjOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhc19lZXByb20uYw0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzX2VlcHJvbS5jDQo+IEBAIC0xNTIyLDMgKzE1MjIs
MjggQEAgaW50IGFtZGdwdV9yYXNfZWVwcm9tX2NoZWNrKHN0cnVjdA0KPiBhbWRncHVfcmFzX2Vl
cHJvbV9jb250cm9sICpjb250cm9sKQ0KPg0KPiAgICAgICByZXR1cm4gcmVzIDwgMCA/IHJlcyA6
IDA7DQo+ICB9DQo+ICsNCj4gK3ZvaWQgYW1kZ3B1X3Jhc19lZXByb21fY2hlY2tfYW5kX3JlY292
ZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICt7DQo+ICsgICAgIHN0cnVjdCBhbWRn
cHVfcmFzICpyYXMgPSBhbWRncHVfcmFzX2dldF9jb250ZXh0KGFkZXYpOw0KDQpEb2Vzbid0IHRo
aXMgcmVxdWlyZSBhIE5VTEwgY2hlY2s/DQoNClRoYW5rcywNCkxpam8NCg0KPiArICAgICBzdHJ1
Y3QgYW1kZ3B1X3Jhc19lZXByb21fY29udHJvbCAqY29udHJvbCA9ICZyYXMtPmVlcHJvbV9jb250
cm9sOw0KPiArICAgICBpbnQgcmVzID0gMDsNCj4gKw0KPiArICAgICBpZiAoIWNvbnRyb2wtPmlz
X2VlcHJvbV92YWxpZCkNCj4gKyAgICAgICAgICAgICByZXR1cm47DQo+ICsgICAgIHJlcyA9IF9f
dmVyaWZ5X3Jhc190YWJsZV9jaGVja3N1bShjb250cm9sKTsNCj4gKyAgICAgaWYgKHJlcykgew0K
PiArICAgICAgICAgICAgIGRldl93YXJuKGFkZXYtPmRldiwNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICJSQVMgdGFibGUgaW5jb3JyZWN0IGNoZWNrc3VtIG9yIGVycm9yOiVkLCB0cnkgdG8gcmVj
b3ZlclxuIiwNCj4gKyAgICAgICAgICAgICAgICAgICAgIHJlcyk7DQo+ICsgICAgICAgICAgICAg
aWYgKCFhbWRncHVfcmFzX2VlcHJvbV9yZXNldF90YWJsZShjb250cm9sKSkNCj4gKyAgICAgICAg
ICAgICAgICAgICAgIGlmICghYW1kZ3B1X3Jhc19zYXZlX2JhZF9wYWdlcyhhZGV2LCBOVUxMKSkN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKCFfX3ZlcmlmeV9yYXNfdGFibGVf
Y2hlY2tzdW0oY29udHJvbCkpIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBkZXZfaW5mbyhhZGV2LT5kZXYsICJSQVMgdGFibGUgcmVjb3Zlcnkgc3VjY2VlZFxuIik7
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuOw0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB9DQo+ICsgICAgICAgICAgICAgZGV2X2VycihhZGV2
LT5kZXYsICJSQVMgdGFibGUgcmVjb3ZlcnkgZmFpbGVkXG4iKTsNCj4gKyAgICAgICAgICAgICBj
b250cm9sLT5pc19lZXByb21fdmFsaWQgPSBmYWxzZTsNCj4gKyAgICAgfQ0KPiArICAgICByZXR1
cm47DQo+ICt9DQo+IFwgTm8gbmV3bGluZSBhdCBlbmQgb2YgZmlsZQ0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhc19lZXByb20uaA0KPiBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXNfZWVwcm9tLmgNCj4gaW5kZXggMzVjNjlh
YzNkYmViLi5lYmZjYTRjYjU2ODggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9yYXNfZWVwcm9tLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Jhc19lZXByb20uaA0KPiBAQCAtMTYxLDYgKzE2MSw4IEBAIHZvaWQgYW1k
Z3B1X3Jhc19kZWJ1Z2ZzX3NldF9yZXRfc2l6ZShzdHJ1Y3QNCj4gYW1kZ3B1X3Jhc19lZXByb21f
Y29udHJvbCAqY29udHJvbCk7DQo+DQo+ICBpbnQgYW1kZ3B1X3Jhc19lZXByb21fY2hlY2soc3Ry
dWN0IGFtZGdwdV9yYXNfZWVwcm9tX2NvbnRyb2wNCj4gKmNvbnRyb2wpOw0KPg0KPiArdm9pZCBh
bWRncHVfcmFzX2VlcHJvbV9jaGVja19hbmRfcmVjb3ZlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldik7DQo+ICsNCj4gIGV4dGVybiBjb25zdCBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zDQo+IGFt
ZGdwdV9yYXNfZGVidWdmc19lZXByb21fc2l6ZV9vcHM7DQo+ICBleHRlcm4gY29uc3Qgc3RydWN0
IGZpbGVfb3BlcmF0aW9ucw0KPiBhbWRncHVfcmFzX2RlYnVnZnNfZWVwcm9tX3RhYmxlX29wczsN
Cj4NCg0K
