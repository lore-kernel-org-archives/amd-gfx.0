Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02E5C35FFC
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 03:16:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBBC410E043;
	Thu, 20 Mar 2025 03:16:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fwC+7C2b";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D099910E043
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 03:16:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCcsEHgeLqKdlRouFNILmxmuzfFEO5mv50m4YwZhIHUV/49/2PpJ4/WzOG0+6gpKsuuGZGN93tQQfYbEtF6L828sSPRMvq2ZdcOqUZhzkTvCF37u38c3sI+8IU/7el+0L8DWidywXECGKaucmUSoQnS0IZFslGlvlpkXJ+krf5ybaUu0gC3l60nvIdxUyLHS9ed+4WzzCP85e21hlLFfzXKcTPaL443Oab73WmtA/QrjoJ+Pwp3iQS5uNzgm1rwpw4HzJOsQzAuaLsAQcu/uHeoIojFgDMY/GxTXK8CkvZqDlAS4M79F6FRI61VMffFuMxrrv9wa0T+PvtoYF6xxkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SbREX1GaV4l3Np6LVQG+DXZ+dWyNgZg8Zqr+MBkI7Q=;
 b=sTcfn75I5iTSuT3tR/GudPPmLhHHvF/Bq6A0Dn3D8JbcF56BGoNELaRtbrfvlroiPhlSsXuXu3WbUqtMO4zwcOM/A2x5V+6ylaJkEu+/tUNPQLrzscWUiy5Xy4N+uOw77ZkZf6CSx+Oi0TILvwcQ8Suy5FX8/uxu4bylvxuguV4ubufEgoeHms2G6eFH4pzd/5wmx7IAG2yC/jvKAD5vJGmi2NoLwqVbxe8mTDDydls0xxjU6Be9V09GbbPsFa2Vc4BQeJayt0mC+qqQct1nCrc/GkZCOJVxjfT9Bda7HdSinEMILdbWl7sRqbTN+xodgdgsjJuRTXqfEMRSSvMsgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SbREX1GaV4l3Np6LVQG+DXZ+dWyNgZg8Zqr+MBkI7Q=;
 b=fwC+7C2blODin0uzGaIu9VIpIbIUKw3kEcYhMG0UpCxHnF/2dhOLaXj5JVSxquqSpXQZBsGE+LbE86GP9EqNvuzFWSa0wyZIR/A1z9TAwyD3heGhyEt/mGw8Tl+ILOLD+AzSWRGMAwwUN11Tnlf4GOXrY6/02/+pFh1JiIzP2m8=
Received: from DM4PR12MB5118.namprd12.prod.outlook.com (2603:10b6:5:391::12)
 by IA0PR12MB8375.namprd12.prod.outlook.com (2603:10b6:208:3dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 03:16:18 +0000
Received: from DM4PR12MB5118.namprd12.prod.outlook.com
 ([fe80::5f90:4ad9:2842:38eb]) by DM4PR12MB5118.namprd12.prod.outlook.com
 ([fe80::5f90:4ad9:2842:38eb%7]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 03:16:18 +0000
From: "Cui, Flora" <Flora.Cui@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Meng, Li (Jassmine)"
 <Li.Meng@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu/discovery: optionally use fw based ip
 discovery
Thread-Topic: [PATCH 3/3] drm/amdgpu/discovery: optionally use fw based ip
 discovery
Thread-Index: AQHblMcpxq05YEKZ/UeKqvaF/3v2G7NybbmAgAAylYCABFLQkA==
Date: Thu, 20 Mar 2025 03:16:18 +0000
Message-ID: <DM4PR12MB5118A4E5FC41E95C84E42A77FAD82@DM4PR12MB5118.namprd12.prod.outlook.com>
References: <20250314095428.2914973-1-flora.cui@amd.com>
 <20250314095428.2914973-3-flora.cui@amd.com>
 <debc9622-7460-475f-977d-90fbdc89f896@amd.com>
 <CADnq5_M_W0fHsegFhM=M9MmLYziOnKiHN0Xc6ZsRTDhPUc_WjQ@mail.gmail.com>
In-Reply-To: <CADnq5_M_W0fHsegFhM=M9MmLYziOnKiHN0Xc6ZsRTDhPUc_WjQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=db3ba6e2-0b08-45b9-bd4d-a2810ffc6f84;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-17T07:29:36Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5118:EE_|IA0PR12MB8375:EE_
x-ms-office365-filtering-correlation-id: 56c08f5d-c48a-41ed-744b-08dd675d94c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dWpQN1orcDBHcCtSR1hOQnNTQ3Q3YkExOVVxck1Jb1V0VzloR2hNcDJkTG4y?=
 =?utf-8?B?eW9iclBDa0tLUUxKU2lIdHVGdkxoaXRLZ25laEhMSjNBb0c2UEZaNlVSdVlN?=
 =?utf-8?B?UVJ0Z3FxQk5Dem9iM3ZXQmxRdjJsdWxZREZxcitIbEhnL2tlVXJOVFMwY2lO?=
 =?utf-8?B?MCsrV1JtWGpsN2JVM1Z3ZlRYL3g5UHljUXl2YmFjYVprdFVkNTE2N01Vd2RN?=
 =?utf-8?B?cllTTnN1Z3FOUjRLYmw4NU5nZDV6UzFrUWJnRCtyQURRQiszOUZDZCtlYnVx?=
 =?utf-8?B?TDdwQjNNZTU4RThTdnQ1MklSekNPTVhGSGFFODgxNkJ2NFVyYi9QZjZyQnRO?=
 =?utf-8?B?THdGejlKTG9vMlk0YjlvVEZnM0Naczg4UjhFTjU0MThOdWdBWU5kVjIray9O?=
 =?utf-8?B?L0ZUSStMbjdRM09yZnJ1TVhaUklCSHArQ3N5d3pTRHBscUNEWDY5NTFGWkp4?=
 =?utf-8?B?TGNrTEJHQVVWZDRCdDJqNzB1MXNSMlR2TTNoS2Nqc3NJWklhQzloRmNWT1lY?=
 =?utf-8?B?R3RxVDk0TTJYNzRDcEpoNnUrWHZ3cEkwNDVKR0xnTzV1V0d2eGNkRi9Fd09C?=
 =?utf-8?B?QXFSeFVkbVFack0xL0VrYTNlOEdtVXBYcHFQbFB3SWVoY0phOE5uRHdwVitq?=
 =?utf-8?B?MkZLNjFZNXZjUi9mY0gzR1RiZ3RqbEYxRC9WbkRCUXRCR2hQMGJuTEJQMVdy?=
 =?utf-8?B?YXUzRm1pNkNOUm9LcUVlaEZKU2Z1UXBTaDl0b01LbEtpa0tBSlpaWHlKckhP?=
 =?utf-8?B?YlU1emtkQ3l0ZWVhR0wyVDM1NlVndlkvZDZtQVBlRmkxNVVxcFRyTTBEQ2RO?=
 =?utf-8?B?ZGdVMnlQTmNDa252NnRTRG5MU0dFSnJPc0J6RW56YzkrS3JsZE1paWg2VTFJ?=
 =?utf-8?B?emJ2cURJOXB3cVVBVTREZmlIc2lFeTZsUVhhYU5hKzZRNU1qb0RRNzZhR3hX?=
 =?utf-8?B?b3RxWmVQQVRXeVV5N1lVMXdxR3dDOFZXV2k1MitpRVBTQVBSMHg2QXR2RGpj?=
 =?utf-8?B?V01pTVdINk9NVEk1R0w5SWxaSUI4TzJzbloraFpuT2tMOW9vblI5STY2ZTdH?=
 =?utf-8?B?dWdRWk9KTUtuVUFkUC9HMVFVSWc1QjNvNGNXQU4xbFErMms1K0kxcTBCbzRk?=
 =?utf-8?B?QTJyMkFKeGtaV0V2MEVWL0wrZG4vM3pya1hPdWxQbWNEVnUrT2cxNWhRdE52?=
 =?utf-8?B?OUNzZjBiY0J3dEFFNmV5QllhbE5TeDJ0eEsvaWloeEkwZGpBbUVWTXZqM2oy?=
 =?utf-8?B?WWdXLzlGU2NUT2U5dmxIcmxVYWRZV2V3VTd3VFJ4SmdsMFNEYnBtbWU2RE14?=
 =?utf-8?B?aDBuZE9sWVVqempKNjd3ZjdTTU1hM2tJdmNHT2dLdHJKbENMTmQzenVXSmho?=
 =?utf-8?B?Q1NsTW0rSzJRMWlXaHBZU2M2SnhXcURJdG01RERlZnlxb3pWdGdUNWZlbHJ1?=
 =?utf-8?B?SFZFUkxyUDdBWUNXM3FQYURqU2lSSGtXNU84WWlXRUlLMVZCRHFXU09OWkMv?=
 =?utf-8?B?MXZHOWdsbFpsRDJNcTJXampCOGwxUEFpU0YvaUVZWDQzcmlGeTRDODZYdnUx?=
 =?utf-8?B?ZFF0b0Z6SUlleDBMTGNRMXhpNFltVnhlbHlpTzhUK0Zrd0NGVTFHMXRqMXZa?=
 =?utf-8?B?QmFzb2w3UmhVOEpRVmxqR25aRWFCc1Q0b0hTeC9hOVMvZXFiNzI1UGZ4VlFO?=
 =?utf-8?B?NDNqc2E5NGg5OEVFWnlLVG40S0dGeE1wb0s4ZDJpK2R4V3c0L1Q5bjdRdW9a?=
 =?utf-8?B?dUNrVGRiRFFKWWxYcnNQVE9PQlIxd3hIYVFkYlBNZFNzeVZPQkorNjZtd2VJ?=
 =?utf-8?B?NGFINVFXYkk2TTNsamVXaVZWMnVyd0tZL3BBQVhZNGVYVFVIZ1pMTmpORW1J?=
 =?utf-8?B?UW1UcmJIY3U5cXh4WnhMeUJDRHpCQ0RBOGsrT3hqTnFWeTlJdGpicDYzSldp?=
 =?utf-8?Q?Y6xAhml754qz9cp+aomdmP1+Fuvp/vow?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5118.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUkyNmlXVHUrMmh3NVRpOWNYNmJibU54dTlLSWZJNEFQalJSemVFNjdYNXVC?=
 =?utf-8?B?dm41SVYwejFjRHNOK0x6c1VmdFZDRG94eUtYODRrR1Q0amlwRnBXSlAwN0gv?=
 =?utf-8?B?TTB1RzdQK1hCWUVlNlV4RnQ5dkxEdTVCNFZQc2ROWi9FQlA3aERqcnVTbmZN?=
 =?utf-8?B?c0dSdk1KUFdQaWN4ZFVsMWh4Z1duODZQREZ5WWJDSDMyTTdyS2xXc1VwVTk1?=
 =?utf-8?B?aUgzeXR4NXlZNVRVTXBXZkNHVkw1ZEJON2ZacWhvRi9BLzhvVlozWWRMM1hD?=
 =?utf-8?B?aitucW0rc3hmczNRR1VjcXdweTF5V0FaRnBubTdVaFV6ZzR3RFMyZFZoaW1H?=
 =?utf-8?B?bGQ5dXJtN0UvbGNzVUtqRGtBaG5YU01sQm9xOGQxT3RSU3VPcjNvTjdmVnlJ?=
 =?utf-8?B?MmxEeXJtMFVHaHNwWUU4d0dCMThSRHVUMGVXQzJKMkNZYWl0MkUrQ1VZVytk?=
 =?utf-8?B?NVB4VzhGSVlSQnoxOXozTUp3Nkc0ZWZyMklDQk9PSE9ySTVvYkZjSlRpcnlO?=
 =?utf-8?B?UDFzQkY4M0V1SDgxb2NmckpJckc1ZHJLNTh5d2xJYzdiUFZleWxyb3AxS3I1?=
 =?utf-8?B?V1o0Tyt3Nis3OWdvamEvMjRTZnRPYkk0SDN4RFkxZ1JPTXBMSGdtTDRTdnNv?=
 =?utf-8?B?MHlLTHFXMTdWVTRZQVU0TVR2Ym9Fd1hMd25VZ2VuL2VUeEFjT205WHVXQjAz?=
 =?utf-8?B?ZG9kZE5xTUdoZklhK2IyUkJYVkZjSFg3MVhiNDBGZkQrY0RQTTV5NGdpWS91?=
 =?utf-8?B?aExmZFI3ZmkyUm1FRjVac25VWCtoZk1uTjM0azFhdU5uYzBhbjJzdEJBTmI0?=
 =?utf-8?B?Y1oxcU41ZmNuSVF5VFFoVTE3Rkgzcnllekg2UkpiSTZzNktDdmk5WTF1ckVQ?=
 =?utf-8?B?VmpUMC9taEl6NDIxc1hUdFFpRUFhc2R1WkZSeUZ4OHRVTkN0T3VZMElGZ0xL?=
 =?utf-8?B?NXRUNU9SWm5SNUZndG0zbGR3Z2Y2R1FsdngyVUd0eWZ2bjVEeVpzZzR5Y21Y?=
 =?utf-8?B?cUpXdDRpa0VRUzFsTVZHenJFeWxQeG9ZQ09rSVp2WkhXOWdsUnJqMjFUdFFF?=
 =?utf-8?B?M3BtbWdtUjR6VzkrZ2FrQmxhMUU4U2ErL2R0WmtpLzJrdGs0ekR0eWhGMnBn?=
 =?utf-8?B?OHFqcC93QWtnQVpjSUladklON3Vodzg1TENKbXZPdCtrWEltZDNDV3pDdmxJ?=
 =?utf-8?B?WW0zZjMvc25SaFUwWGRST0l2ZTJvQjgyQ2hQeUlpcmRXcWVkTnFBSEdTaG5u?=
 =?utf-8?B?TmllMjhzb2QrQS9rM2V2SG96S0MyZXhjbGhRQmlLa09xaUtRbXVDTmJyd2Zv?=
 =?utf-8?B?SytMTVZ3cTNoZlkwNlFZVXZvc3NhNHZ0YVVtNEREb0dxcHg0KzBFR0QwNEJj?=
 =?utf-8?B?bm9kdTJ6VG16Q0pkbm5hS3lsNEZ3ZzIxYmVRaWVOT2JqWXVOcHpEUUdTdVpX?=
 =?utf-8?B?UnFnbGxKNVBNZ1ZCSitIaFNIM252QlNSazZEWE5ZUFplZEhPUis5L3BNKzZh?=
 =?utf-8?B?NzJXT1dGVEdnNzBFeFVaWXY3WWQ5WVFEam5mNi9vTytCczVYdGlCY2Z5T3Z4?=
 =?utf-8?B?T3YzNTNJYVdsOUtLb2ZaK1NzUmFkZUFMM2ZyNVlPZDZRbTczL0Vqa05sN3N3?=
 =?utf-8?B?T01Lb25XMkxnOXlqR3JKWDQ2clNFdDhWekkvWUtzTjNiWGdDWGd1Zk95MDdv?=
 =?utf-8?B?Vm9GZjg3TkZYVFpHenRBanptQnA0N3VrR1ArK0l4aGY2cU9mMEJuVVk5Rkc3?=
 =?utf-8?B?cjdyaXJzVENLTDhVd3NQNXUzOHlNRnVjQUF0bXd1bXB1OXdGb2JCUEd4L0ZZ?=
 =?utf-8?B?SlNEWm5Gck1jMjVvWmVvT28rZmNQdk1qdU9QS2lkUUl6WDlWckMvRGw0TGp3?=
 =?utf-8?B?NlZUOGVzVHcrKzJ0R3NadE03ZEUxZWwyMjN4ZllnUXUzbCtRRzBETVhVS3ZR?=
 =?utf-8?B?V2Y1UUdrdE1VRjRaOGJkNk9KL3Y5OWJjbUdYVUNZZWRTWU9yUHcrZ2dCRkdr?=
 =?utf-8?B?d3MrTllBQ3l0TXdsWkhNMmFHQkR0ejdIREVTOGZDellDaUJZZEVhTGUxNWxH?=
 =?utf-8?B?ZURuMVI0WkYwTFJLMVhsSSt5UWJTalZ3bnYyWGJFS3llYktUUXNtQzR5ZXZE?=
 =?utf-8?Q?uCJo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5118.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c08f5d-c48a-41ed-744b-08dd675d94c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 03:16:18.1564 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V+yUjxjmG4gF/GF/nh1pxD9e/VrQ5mi4HELX0A5OJetthZk/nXH3OcwFslb7F+X0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8375
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
Cg0KUGluZyBvbiB0aGlzIHNlcmllcy4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZy
b206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPg0KU2VudDogRnJpZGF5LCBN
YXJjaCAxNCwgMjAyNSA5OjI4IFBNDQpUbzogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNv
bT4NCkNjOiBDdWksIEZsb3JhIDxGbG9yYS5DdWlAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+OyBNZW5nLCBMaSAoSmFzc21pbmUpIDxMaS5NZW5nQGFtZC5jb20+DQpTdWJqZWN0OiBSZTog
W1BBVENIIDMvM10gZHJtL2FtZGdwdS9kaXNjb3Zlcnk6IG9wdGlvbmFsbHkgdXNlIGZ3IGJhc2Vk
IGlwIGRpc2NvdmVyeQ0KDQpPbiBGcmksIE1hciAxNCwgMjAyNSBhdCA2OjI44oCvQU0gTGF6YXIs
IExpam8gPGxpam8ubGF6YXJAYW1kLmNvbT4gd3JvdGU6DQo+DQo+DQo+DQo+IE9uIDMvMTQvMjAy
NSAzOjI0IFBNLCBGbG9yYSBDdWkgd3JvdGU6DQo+ID4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4
YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiA+DQo+ID4gT24gY2hpcHMgd2l0aG91dCBuYXRpdmUg
SVAgZGlzY292ZXJ5IHN1cHBvcnQsIHVzZSB0aGUgZncgYmluYXJ5DQo+ID4gaWYgYXZhaWxhYmxl
LCBvdGhlcndpc2Ugd2UgY2FuIGNvbnRpbnVlIHdpdGhvdXQgaXQuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+ID4gLS0t
DQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3ZlcnkuYyB8IDM4
ICsrKysrKysrKysrKysrKy0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMwIGluc2VydGlvbnMo
KyksIDggZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2Rpc2NvdmVyeS5jDQo+ID4gaW5kZXggZmZmNDM4YmFmNjRiLi5jZjI4NmZkZTE4
ZDUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rp
c2NvdmVyeS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rp
c2NvdmVyeS5jDQo+ID4gQEAgLTI1MzYsNiArMjUzNiwzNiBAQCBpbnQgYW1kZ3B1X2Rpc2NvdmVy
eV9zZXRfaXBfYmxvY2tzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiA+ICB7DQo+ID4g
ICAgICAgaW50IHI7DQo+ID4NCj4gPiArICAgICBzd2l0Y2ggKGFkZXYtPmFzaWNfdHlwZSkgew0K
PiA+ICsgICAgIGNhc2UgQ0hJUF9WRUdBMTA6DQo+ID4gKyAgICAgY2FzZSBDSElQX1ZFR0ExMjoN
Cj4gPiArICAgICBjYXNlIENISVBfUkFWRU46DQo+ID4gKyAgICAgY2FzZSBDSElQX1ZFR0EyMDoN
Cj4gPiArICAgICBjYXNlIENISVBfQVJDVFVSVVM6DQo+ID4gKyAgICAgY2FzZSBDSElQX0FMREVC
QVJBTjoNCj4gPiArICAgICAgICAgICAgIC8qIHRoaXMgaXMgbm90IGZhdGFsLiAgV2UgaGF2ZSBh
IGZhbGxiYWNrIGJlbG93DQo+ID4gKyAgICAgICAgICAgICAgKiBpZiB0aGUgbmV3IGZpcm13YXJl
cyBhcmUgbm90IHByZXNlbnQuDQo+ID4gKyAgICAgICAgICAgICAgKi8NCj4gPiArICAgICAgICAg
ICAgIHIgPSBhbWRncHVfZGlzY292ZXJ5X3JlZ19iYXNlX2luaXQoYWRldik7DQo+ID4gKyAgICAg
ICAgICAgICBpZiAoIXIpIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgYW1kZ3B1X2Rpc2Nv
dmVyeV9oYXJ2ZXN0X2lwKGFkZXYpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBhbWRncHVf
ZGlzY292ZXJ5X2dldF9nZnhfaW5mbyhhZGV2KTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
YW1kZ3B1X2Rpc2NvdmVyeV9nZXRfbWFsbF9pbmZvKGFkZXYpOw0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICBhbWRncHVfZGlzY292ZXJ5X2dldF92Y25faW5mbyhhZGV2KTsNCj4gPiArICAgICAg
ICAgICAgIH0NCj4gPiArICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICsgICAgIGRlZmF1bHQ6DQo+
ID4gKyAgICAgICAgICAgICByID0gYW1kZ3B1X2Rpc2NvdmVyeV9yZWdfYmFzZV9pbml0KGFkZXYp
Ow0KPiA+ICsgICAgICAgICAgICAgaWYgKHIpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHJl
dHVybiAtRUlOVkFMOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgIGFtZGdwdV9kaXNjb3Zlcnlf
aGFydmVzdF9pcChhZGV2KTsNCj4gPiArICAgICAgICAgICAgIGFtZGdwdV9kaXNjb3ZlcnlfZ2V0
X2dmeF9pbmZvKGFkZXYpOw0KPiA+ICsgICAgICAgICAgICAgYW1kZ3B1X2Rpc2NvdmVyeV9nZXRf
bWFsbF9pbmZvKGFkZXYpOw0KPiA+ICsgICAgICAgICAgICAgYW1kZ3B1X2Rpc2NvdmVyeV9nZXRf
dmNuX2luZm8oYWRldik7DQo+ID4gKyAgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICB9DQo+
ID4gKw0KPiA+ICAgICAgIHN3aXRjaCAoYWRldi0+YXNpY190eXBlKSB7DQo+DQo+IExvb2tzIGxp
a2UgdGhpcyBmYWxsYmFjayBnZXRzIGV4ZWN1dGVkIHJlZ2FyZGxlc3Mgb2YgdGhlDQo+IHByZXNl
bmNlL2Fic2VuY2Ugb2YgbmV3IGZpcm13YXJlLg0KDQpUaGF0J3MgYnkgZGVzaWduLiAgVGhlIGhh
cmRjb2RlZCBzZXR0aW5ncyB3ZSBoYXZlIHRvZGF5IGFyZSBub3QgcXVpdGUNCnRoZSBzYW1lIGFz
IHdoYXQgdGhlIGlwIGRpc2NvdmVyeSB0YWJsZSBwcm92aWRlcyBzbyB3ZSB3YW50IHRoZW0gdG8N
Cm92ZXJyaWRlIHdoYXQgY29tZXMgZnJvbSB0aGUgZmlybXdhcmUgZWl0aGVyIHdheS4gIFdlIHJl
YWxseSBqdXN0IHdhbnQNCnRoZSBpcCBkaXNjb3ZlcnkgdGFibGUgc28gdGhhdCB3ZSBjYW4gc2V0
dXAgdGhlIHN5c2ZzIGlwIGRpc2NvdmVyeQ0KZmlsZXMgYmVjYXVzZSB0aGUgUk9DbSBwcm9maWxl
ciB1c2VzIHRoZW0gZm9yIGdldHRpbmcgdGhlIEdDIHJlZ2lzdGVyDQpvZmZzZXRzIGFuZCB3YW50
cyB0byBoYXZlIHRoZW0gYXZhaWxhYmxlIGZvciBhbGwgZ2Z4OSsgcGFydHMuDQoNCkFsZXgNCg0K
Pg0KPiBUaGFua3MsDQo+IExpam8NCj4NCj4gPiAgICAgICBjYXNlIENISVBfVkVHQTEwOg0KPiA+
ICAgICAgICAgICAgICAgdmVnYTEwX3JlZ19iYXNlX2luaXQoYWRldik7DQo+ID4gQEAgLTI3MDAs
MTQgKzI3MzAsNiBAQCBpbnQgYW1kZ3B1X2Rpc2NvdmVyeV9zZXRfaXBfYmxvY2tzKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQ0KPiA+ICAgICAgICAgICAgICAgYWRldi0+aXBfdmVyc2lvbnNb
WEdNSV9IV0lQXVswXSA9IElQX1ZFUlNJT04oNiwgMSwgMCk7DQo+ID4gICAgICAgICAgICAgICBi
cmVhazsNCj4gPiAgICAgICBkZWZhdWx0Og0KPiA+IC0gICAgICAgICAgICAgciA9IGFtZGdwdV9k
aXNjb3ZlcnlfcmVnX2Jhc2VfaW5pdChhZGV2KTsNCj4gPiAtICAgICAgICAgICAgIGlmIChyKQ0K
PiA+IC0gICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiAtDQo+ID4gLSAg
ICAgICAgICAgICBhbWRncHVfZGlzY292ZXJ5X2hhcnZlc3RfaXAoYWRldik7DQo+ID4gLSAgICAg
ICAgICAgICBhbWRncHVfZGlzY292ZXJ5X2dldF9nZnhfaW5mbyhhZGV2KTsNCj4gPiAtICAgICAg
ICAgICAgIGFtZGdwdV9kaXNjb3ZlcnlfZ2V0X21hbGxfaW5mbyhhZGV2KTsNCj4gPiAtICAgICAg
ICAgICAgIGFtZGdwdV9kaXNjb3ZlcnlfZ2V0X3Zjbl9pbmZvKGFkZXYpOw0KPiA+ICAgICAgICAg
ICAgICAgYnJlYWs7DQo+ID4gICAgICAgfQ0KPiA+DQo+DQo=
