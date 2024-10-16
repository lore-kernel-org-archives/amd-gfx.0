Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20BAD2F7D2
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Oct 2024 23:47:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2347D10E089;
	Wed, 16 Oct 2024 23:47:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FDOBJ5tg";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A6DE10E089
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Oct 2024 23:47:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECORaSQxHvo7xUG3BfKFirX2ijA8rkFU5nJOVFjtO4XgKYoK7PF7+XlpiC+GgjcQzd+DHwXQ5Ai2/5dQcMbQm3X4jX2RhH6n9kdvJtB3K6fyzltW6viAJPGvOGVShcsg+HU48hnhYE4C3omKZeJDX2qRSDj4mmDO53VouF6BQ35nnRXfftykPEfeKaJAZFrJr+qmbvtHuM9F2s9BOkJRmgLVrt1PuzfKAamBsx/GozOxbk9TW87iUEsDaCMkaQeVh65nZRZUX7jahafTgJ2PjHw64vbNyl+BTsfr/Gc/z8R93d1Q+lxz+4SjxtgAV8iRWvqJ+JTV9BkiiPaUoBP5ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eRBRh45fyndpmhf2+rrL+OVF6y10bMo/kgbp+fIGGY=;
 b=nVHu0FhVMyGwJD9zIKkoz5foPsv/KCs4ZwT/qzQulsmI6e/I1qgVdbKNZcb7LVQaA8Kre8rHrOVhKgFJpmFxL4e2AGvTWHyYzluaJLRmH0gHWOfRDkGa2j8WjrpxCsgsHNtkIdQjdX6/qR/Zjs/QxK/Qzg4hJsSK6Ut0NojAnCY9ghFtQUz55HOZDFGcL9AouYd70fScSKjAz6g675gscDEB3iVqeXx8xIKXScEx3/uevdqLB18lblbH1Nj5bFkZI/1P6HqZzdh/ObCpg5fuOKlPm+YMGMSqmv663pSmym4+Ik6m6R8axe9D5YqFnq90z1XLCsPKYLnIbtYHPqqFjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eRBRh45fyndpmhf2+rrL+OVF6y10bMo/kgbp+fIGGY=;
 b=FDOBJ5tgttjPoyqYy5/sNcHOX3B41yl+UO7C4gNEvZsgg+4WSPkCCdR68jONe9xAcbe4bMERSeyKg4Mbsv6IEpbJyFKHw3z1Ip92jT9F0uTRhhG+DQn0WxXGUzT2YPn7Gn76Oc+KP/10MncZaWDKilUXlq8xZnqqokplrVclEDw=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 MW3PR12MB4345.namprd12.prod.outlook.com (2603:10b6:303:59::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.18; Wed, 16 Oct 2024 23:46:57 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4%5]) with mapi id 15.20.8069.018; Wed, 16 Oct 2024
 23:46:57 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: update deep sleep status on smu v14.0.2/3
Thread-Topic: [PATCH] drm/amd/pm: update deep sleep status on smu v14.0.2/3
Thread-Index: AQHbH5u7dB7RQcCvUkGaThjKHw+0SrKJUTAAgAC6ZeA=
Date: Wed, 16 Oct 2024 23:46:57 +0000
Message-ID: <DM4PR12MB5165E79EEDD00A4F1DFE25478E462@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20241016071919.2138181-1-kenneth.feng@amd.com>
 <PH7PR12MB59978FA51CE8CF4FE824B9DA82462@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB59978FA51CE8CF4FE824B9DA82462@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=05235d79-50f8-4a4a-9ca6-5d3f42278dc3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-16T12:28:50Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|MW3PR12MB4345:EE_
x-ms-office365-filtering-correlation-id: 32bbe16e-afc2-4a07-8cff-08dcee3cd222
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NXNLS2xFbGpoVzZ6UzFqa05SMVRRbldUb0xQajdRK2d1M3J2U2ZtZFZwYnVs?=
 =?utf-8?B?YUR2MGl6dThYcGZlTFNETDlJUFpSaktGVVRvS3IvL3RZUzNWR1Y3VDBrWU9s?=
 =?utf-8?B?Zm5JcElna0NKSy9PYmhuNStDUm9WVWdyczJuY0FzTktJTGZyTVdWYW9HdklN?=
 =?utf-8?B?QXZOejg4QmVpUFYxRkxCTC80WVNvTWZ2R2ZkbE1aVnJZcnl3dWZrK0oyYzIz?=
 =?utf-8?B?VGhvekE1cnFrTS9HVWdPcjZIdEh5SWRnZ0ZWNTFWYlVjR2pDbWxxUGdZQzB1?=
 =?utf-8?B?bW9OblZCZWxOTmZHeUZrTDJqZk5SalNMT3k5a29nZmFFZDlEYitselZPa3Uw?=
 =?utf-8?B?ZDI4Vm0xN2htZ25HQWo4amJOMTdVaXhSSkVUenFVcHFkVTNlZ2pJcGVvZitE?=
 =?utf-8?B?YmNWaGFxWVhpOXV0Vm0zYWVkc01LRlpjM05wb3dCS25aZlZDS3ZoQzZnK2lw?=
 =?utf-8?B?MENMc1ZVd3FDdCtpSUxNTmxkNkI0ZWFqNnU0eGJ2UXVOSTRVUGRlMS9obDdN?=
 =?utf-8?B?QmtmTGp0MUJjTTNCQ3JKYUNmZ3V5Q2VQYjMwS0NwR3R2V1FHa1pNL203REJj?=
 =?utf-8?B?OVZkcmRMUVlwNVdUbUdNVWcxblRDNmE0azRMRzU5RHpXbk1PdnZGZlpiOHpx?=
 =?utf-8?B?OW5yaXFmL1Y0Ry84eWF5ak55UEpOeG1uZUIvbW9mM3YyRWVkb1VDZjZROHFG?=
 =?utf-8?B?UmFhQkV5ZzRsckhUM29aMWRGK080blB6cHAvTjlORUxaS2RzZmt0bWJUZDdV?=
 =?utf-8?B?dGRTZFdURTNSY01nWE50Q2JyckdzeDJLZUlQdk1LQkNXa0N1T3l5NUJ5SnFs?=
 =?utf-8?B?WFpQN2NKNlBOM2dSTmw5b2dWRFN6RjVoZlh5RTRMUzRPQ2M5OUdMVE9tVEVD?=
 =?utf-8?B?VlN2QzhtU2FRWS9zWDNFQkM3bkNneEN6OWpnVklWWC8yQ1d2d09uVUVrbnlG?=
 =?utf-8?B?cVJ4bTZOVjFFS1VaTXRoWTlqaThGVG1zQ3JtZXhjRlJidXBmN1N4cjVTUitj?=
 =?utf-8?B?Ynk5N0ozZ3BWYjF5QVJiZDdUOXgydHVmTzBqMEUvZ3FtNkVzblFuZmRHWERS?=
 =?utf-8?B?alpxSmVEM2RmSVJaTUx3ODMxcnZlSnZvQWFoeG5GWU1jOFpzejAyeEFzdmUr?=
 =?utf-8?B?KzFPakJYVzdJTnZBNGs0YWRIelVkYTg0UVd6MXNiUjEwRm40czdlaTlrSi9V?=
 =?utf-8?B?c2k1azEvUUdlNGNhSWR2TEVETyswSUx6YXVIUkUwVE1XRzlJcW92TWFMTVJh?=
 =?utf-8?B?QWJvQU9xTkdtSjlxdzd3ZWFPa3NLR01BVHkra0hEeVB5YWNRaTFyZ3cxbzZQ?=
 =?utf-8?B?YmthTTRCN1I1dDgwZ1dyV0o3WnFMelpkOFljNkVZOHBadUl1MExMNUpTaEdJ?=
 =?utf-8?B?K0U3cFVxekdZczVvNy9SVm1yOE9hVGlzaXBYM3VNaDd5MnhMUXA1cjA0NTVl?=
 =?utf-8?B?ZTJ2UkVZYnVjdkhLM25zbXpycTd6OFRYa3grM1JsUXB3Q1NpOXdxTHpyTDNM?=
 =?utf-8?B?YVk5MnRNRWlLWU9DZklKMFAxT20rTVlyY0FhN2VESVJvSmhFa05ZblBJR2xG?=
 =?utf-8?B?dVhPZ05hekdCQ0ZyWWFoejZWNnpnVko5eXdWa2lzNnBETVVMM1VTUEhDT0px?=
 =?utf-8?B?cDVURFpXWTYzK3RYaDFSS3ZuK3NkYnZuR0pVNXMxVUhCdDRPcUlwNlBZMFhP?=
 =?utf-8?B?MGdYQVlncUhFYlFQSFFYMEh2d3NRNVlDYThKeS9adXROMk5jY3dsTWZrdE5K?=
 =?utf-8?B?cCsyenRtMXdsVVVCMmtUbFpadHRXMzZaMHBNVjJFYmlraExPMG8ybm9SUXRQ?=
 =?utf-8?Q?WJFgVFcHgk+PJlFHHQjMGjFDRZ2Aerd7++piA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjNKWVRaUCs2SGZJRCtQclJFTU5FQVN0ZTF5by9lTjJ0M3BlZ0RmbElmSnRL?=
 =?utf-8?B?ODlyQWNZUThPZGlVZ0EyU25NRjJYeUhRd01RVFNvaVJxd005cW5aSXdpYTFm?=
 =?utf-8?B?S0huakppR2JPN0ZVN3lxVG56RlpJa1Y1ZG91M1A4dmpWNHNweFpMOVljSkds?=
 =?utf-8?B?clhRQXNhNEk1N2FTL3JJZnhNVVc1TEpwd3JNYTE2S0NibDgxYWlTbVBzZ2pH?=
 =?utf-8?B?Q213WlBZcEVPWW93SGhoVGN6Ly8wQmM1ZHVPM1FUK0JKa3h3UjVNVUtYNTcy?=
 =?utf-8?B?VG53NVR5QmlPaVY5UCtkRVNQYytycnR3bzlzNTZXYWFmUG5MSWtjTXFvK3I5?=
 =?utf-8?B?bjNrMGtJeTIrRUlSUHlZcnZJZ1h6L253bmk4cFl2ei9WWDcvSGtQR1BXYWl1?=
 =?utf-8?B?VUVMMGRvd3o1Q2pjOFBNeWZTRERsK283YlhYU3VNMDlpVHpkak5XU0NpMisx?=
 =?utf-8?B?b2Qvb3h2ekhDdEtMbVdvVCtuNXhFbzZFRld2b2NZRmRNY3Zmd29ITzM2aVp6?=
 =?utf-8?B?d0d6ak0wcmEwSjEyaDhNc1BHa2FGdU1PR0Jhb0hEazNpU2FzQk9XU1ExSFhq?=
 =?utf-8?B?WEdMcWJaYlZQeVkxVWhPTUgwL0JzMGx4T1ZIYi9jU3JkVDdhOVROdVpXanFE?=
 =?utf-8?B?b2ZrbGE1ZVA5THhjTkcwS1cyekpPcjgzTDNWUFJzdURvNnZmbWM3S2ppd3Ev?=
 =?utf-8?B?RnEzS3N5bjdJRUovOW1OYVJjN0VjM1hEZ09zb05wVnIyUU5aRXBDS2Fueloz?=
 =?utf-8?B?c0tFdFQveTdkejRHalV1M3NyUTZSVHJObFRNcUJxTGpNakROcTV0STJUUGZB?=
 =?utf-8?B?VzVteEhtTDNUVjVRWkQwL25FdDliUEdXc3M1eVN0em9oUFVJTGtkR2ZOVGxq?=
 =?utf-8?B?eVBEWGNmMXkwQXlsZGFRdjZzZzJCZHRLekpkR21oczUwM2JwSkZiY0gxNmFj?=
 =?utf-8?B?eUFlanR2a2ExY2Q5c2pRQWU3bVl4aVdWWko0ZEN4cko3Z2xkajV5ZlJ5U045?=
 =?utf-8?B?UTlUMWhpV3o2TmVLMXBqZGpobEhGTHFadzRRaktBcWpsVHc1a0YyQ1FIT203?=
 =?utf-8?B?bDM0RFVRRFJmT2dBZUZzTVlsN2NtTjRhbWNaSWFsRXBkN3RvcFRHYUpycUov?=
 =?utf-8?B?cHIwaU1uVEk5b2ZoYmc1eW1KUTNYOTMyZUtkb2l0TzBnZVBaVTZ4Wm5NQVRS?=
 =?utf-8?B?SGR5T2x2OS8xRk5jZFRaK3d5blJTbnNmSXVZTlhlWWhXTVFLelNORGV1Mit1?=
 =?utf-8?B?bmVyR3FwV2pzOVVKM1RnTEtCVElmU0JNYzZuL3luQ21XYVdIcEZ5czZibzlD?=
 =?utf-8?B?dUVOY2RvcC90MW0zckNnc0FLQ0Nrbk9OaTA4eGMxY2VMSEt4bWVnU2RQOVQv?=
 =?utf-8?B?ZzRXbVo0RTR6U2FFakxKQWdCNFdyL2dWTWdzdE1GWXg0WEo3UnhIT0pFZTZC?=
 =?utf-8?B?R3dKLy9JdnNwTGdmVEVZM2xRM29PMjNGOE5hSkNjWHd0TnlRZVB2OWEremJX?=
 =?utf-8?B?Yis1bjNUMXV1bXp3cjZqWUpYYXVUTVFiT3drYnVQdW16TjVCTmQwMlIrWTVt?=
 =?utf-8?B?S084TlRxSGdMSCtVVzlYTy9xZDFnYkJjT1BXSHN4bUxnTWxQZlpoVFN0Wjdk?=
 =?utf-8?B?dWVyZnhadWVBUmNZY3diaUJzTFJxTjluMDVMaVpCcmRJeUd2OCtyY0NtbDIv?=
 =?utf-8?B?S21SQVJlbWdObnJMZWJDK0ViQzBSaWtVM2k4Y2QvUGJ6QThxQUNNYmtXcXFx?=
 =?utf-8?B?cUo2bWVrZy9nL1lvaCtMd3lGRVlJRDdYOGZjME4rRVVYY1FjU0Fsd3lCVS9Z?=
 =?utf-8?B?dW1BOW9lV0VjOHZaa3RMamM2cHJUam40SnNGTGEvYTRHQmxoVEdoZmZnanlC?=
 =?utf-8?B?Um82c00zcjBZVHZRaHJmQ2VWcnNOa0FBak9HYTlSL1FGZW5ZMXpuenJSRkd2?=
 =?utf-8?B?RVlmZ1BuRW0xcmM3UFYyRGtLeE1kRndKbWwrNHdXckxQNUY5algrenVHd0Jl?=
 =?utf-8?B?N3ZnOEdBREN2d2VFRG9Udk1MTzIxLzZsMTFRcjhVRUhSTnhQUWNHTG5KMmpn?=
 =?utf-8?B?eStoNzg4aWRLVzZSdkdxMW5lQzIvOUtBbjI3a1lDRnZIQTVlNnFVYnBuWDM1?=
 =?utf-8?Q?67RI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32bbe16e-afc2-4a07-8cff-08dcee3cd222
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 23:46:57.0678 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yY5BQgs5NDZz0/19nGHsdn9Hi6n/DQsDcv0SVBLCrQrGLoioFptU6hujAu8oIKU7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4345
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
Cg0KVGhlIGxvZ2ljIGlzIHRoYXQgd2hlbiBlbnRlcmluZyB0aGUgY29tcHV0ZSB3b3JrbG9hZCwg
ZW5hYmxlIGRlZXAgc2xlZXAuDQpXaGVuIGV4aXRpbmcgdGhlIGNvbXB1dGUgd29ya2xvYWQsIGRp
c2FibGUgZGVlcCBzbGVlcC4NCkl0J3Mgbm90IHJlcXVpcmVkIHRvIGRvIHRoZSBkZWVwIHNsZWVw
IHNldHRpbmcgaW4gb3RoZXIgd29ya2xvYWQgdHlwZS4NClRoYW5rcy4NCg0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogV2FuZywgWWFuZyhLZXZpbikgPEtldmluWWFuZy5XYW5n
QGFtZC5jb20+DQpTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMTYsIDIwMjQgODozOCBQTQ0KVG86
IEZlbmcsIEtlbm5ldGggPEtlbm5ldGguRmVuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcNCkNjOiBGZW5nLCBLZW5uZXRoIDxLZW5uZXRoLkZlbmdAYW1kLmNvbT4NClN1
YmplY3Q6IFJFOiBbUEFUQ0hdIGRybS9hbWQvcG06IHVwZGF0ZSBkZWVwIHNsZWVwIHN0YXR1cyBv
biBzbXUgdjE0LjAuMi8zDQoNCltBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwg
RGlzdHJpYnV0aW9uIE9ubHldDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBL
ZW5uZXRoIEZlbmcgPGtlbm5ldGguZmVuZ0BhbWQuY29tPg0KU2VudDogV2VkbmVzZGF5LCBPY3Rv
YmVyIDE2LCAyMDI0IDM6MTkgUE0NClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K
Q2M6IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllhbmcuV2FuZ0BhbWQuY29tPjsgRmVuZywgS2Vu
bmV0aCA8S2VubmV0aC5GZW5nQGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWQvcG06
IHVwZGF0ZSBkZWVwIHNsZWVwIHN0YXR1cyBvbiBzbXUgdjE0LjAuMi8zDQoNCmRpc2FibGUgZGVl
cCBzbGVlcCBkdXJpbmcgdGhlIGNvbXB1dGUgd29ya2xvYWQgZm9yIHRoZSBwb3RlbnRpYWwgcGVy
Zm9ybWFuY2UgbG9zcyBvbiBzbXUgdjE0LjAuMi8zDQoNClNpZ25lZC1vZmYtYnk6IEtlbm5ldGgg
RmVuZyA8a2VubmV0aC5mZW5nQGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bt
L3N3c211L3NtdTE0L3NtdV92MTRfMF8yX3BwdC5jIHwgNyArKysrKystDQogMSBmaWxlIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxNC9zbXVfdjE0XzBfMl9wcHQuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTQvc211X3YxNF8wXzJfcHB0LmMNCmluZGV4IDI3ZjRl
MGNlNDQ3ZC4uZWNkZDExYTg3MzExIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9w
bS9zd3NtdS9zbXUxNC9zbXVfdjE0XzBfMl9wcHQuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9zd3NtdS9zbXUxNC9zbXVfdjE0XzBfMl9wcHQuYw0KQEAgLTE3ODQsNyArMTc4NCw3IEBA
IHN0YXRpYyBpbnQgc211X3YxNF8wXzJfc2V0X3Bvd2VyX3Byb2ZpbGVfbW9kZShzdHJ1Y3Qgc211
X2NvbnRleHQgKnNtdSwNCiAgICAgICAgRHBtQWN0aXZpdHlNb25pdG9yQ29lZmZJbnRfdCAqYWN0
aXZpdHlfbW9uaXRvciA9DQogICAgICAgICAgICAgICAgJihhY3Rpdml0eV9tb25pdG9yX2V4dGVy
bmFsLkRwbUFjdGl2aXR5TW9uaXRvckNvZWZmSW50KTsNCiAgICAgICAgaW50IHdvcmtsb2FkX3R5
cGUsIHJldCA9IDA7DQotDQorICAgICAgIHVpbnQzMl90IHRlbXBfcHJvZmlsZV9tb2RlID0gc211
LT5wb3dlcl9wcm9maWxlX21vZGU7DQogICAgICAgIHNtdS0+cG93ZXJfcHJvZmlsZV9tb2RlID0g
aW5wdXRbc2l6ZV07DQoNCiAgICAgICAgaWYgKHNtdS0+cG93ZXJfcHJvZmlsZV9tb2RlID49IFBQ
X1NNQ19QT1dFUl9QUk9GSUxFX0NPVU5UKSB7IEBAIC0xODQyLDYgKzE4NDIsMTEgQEAgc3RhdGlj
IGludCBzbXVfdjE0XzBfMl9zZXRfcG93ZXJfcHJvZmlsZV9tb2RlKHN0cnVjdCBzbXVfY29udGV4
dCAqc211LA0KICAgICAgICAgICAgICAgIH0NCiAgICAgICAgfQ0KDQorICAgICAgIGlmIChzbXUt
PnBvd2VyX3Byb2ZpbGVfbW9kZSA9PSBQUF9TTUNfUE9XRVJfUFJPRklMRV9DT01QVVRFKQ0KKyAg
ICAgICAgICAgICAgIHNtdV92MTRfMF9kZWVwX3NsZWVwX2NvbnRyb2woc211LCBmYWxzZSk7DQor
ICAgICAgIGVsc2UgaWYgKHRlbXBfcHJvZmlsZV9tb2RlID09IFBQX1NNQ19QT1dFUl9QUk9GSUxF
X0NPTVBVVEUpDQorICAgICAgICAgICAgICAgc211X3YxNF8wX2RlZXBfc2xlZXBfY29udHJvbChz
bXUsIHRydWUpOw0KW0tldmluXToNCu+7vw0KVGhpcyBjb2RlIGxvZ2ljIGRvZXNuJ3Qgc2VlbSBl
YXN5IHRvIHVuZGVyc3RhbmQsIElmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHksIGNhbiBJIG1vZGlm
eSBpdCB0byB0aGUgZm9sbG93aW5nIHdyaXRpbmcgc3R5bGU6DQrvu78NCklmIChuZXcgcHJvZmls
ZSAhPSBjdXJyZW50IHByb2ZpbGUpIHsNCiAgICAgICAgICAgIHNtdV92MTRfMF9kZWVwX3NsZWVw
X2NvbnRyb2woc211LCBuZXcgcHJvZmlsZSA9PSBjb21wdXRlIHByb2ZpbGUgPyBmYWxzZSA6IHRy
dWUpOw0KICAgICAgICAgICAgc211LT5wb3dlcl9wcm9maWxlX21vZGUgPSBuZXcgcHJvZmlsZS4N
Cn0NCu+7vw0KQmVzdCBSZWdhcmRzLA0KS2V2aW4NCiAgICAgICAgLyogY29udiBQUF9TTUNfUE9X
RVJfUFJPRklMRSogdG8gV09SS0xPQURfUFBMSUJfKl9CSVQgKi8NCiAgICAgICAgd29ya2xvYWRf
dHlwZSA9IHNtdV9jbW5fdG9fYXNpY19zcGVjaWZpY19pbmRleChzbXUsDQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQ01OMkFTSUNfTUFQUElO
R19XT1JLTE9BRCwNCi0tDQoyLjM0LjENCg0KDQo=
