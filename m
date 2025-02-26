Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484BDC021B8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 21:03:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B787A10E2E1;
	Wed, 26 Feb 2025 21:03:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zs69pMPT";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AC5C10E2E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 21:03:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ugw+XcymTc1zQC1oAaekuToInlmtN7ZlBBEr0JntqYB4xwOTyubYTdvGuxw+48vzw7gzODuAzwpzXaDnq2xavmllQzUn6jL4aG06Em1jRCrRe1N1GDxR8n88izirN2+DG0zPIJP0Ws6P6nqmLRXFQ+06Y35ixCFD+Zo0flnDOnsgk1Zi72eQQ3kwJUR3vPqWPpZi7c27Yo8+FX268tNuaZq+TC7sO2HQpQ3Y+FJxgeiTtKnxmBa0qMt2GtimtHUvMiRu55zdzdC7eCzCixgatmBntSqR6ECE4vt/X3c7/fPhOsuF5eFRyi7bcqTyM8rzv7V1B1Q+IPZBiHQDowTSaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udu1TFj2dd7thMbroyd4hpA+VdtWaupod2aVrTIYnxg=;
 b=bT+HELv4Crvojs9DUXoquxae6O0m2ue5QaPAsMuhu084z5Cm9lQ+2M0JMSQozv4baWF3fQgCa84m1CJJJsiSGckQLkiT07w/WU69eEHUY8sYsgKHQbToQc6K+ZF2/an18jY3P1DVfw7hKLq5qiwpro8wFvSYNwT/0hPbaN32aePCmBbWeP5CUK2ExXcedVijmDzfiPmflCwqH598q2tjgyVOR8Sti8IUR6XOViiy6bIf0uj+FuaP432gZ5ol6cnIBU/zDeO6MlM1+1g4wRsDtxqoJA1aJo0fgpITD+zPP60Cbv3aX9FWjHZW8PnOA3rsWpujThAnrTD+sufJ2aAwyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udu1TFj2dd7thMbroyd4hpA+VdtWaupod2aVrTIYnxg=;
 b=Zs69pMPTReRmsvsYjXynqJCMdrr0SN4efJcdYLYmKR20ZbFOXRliME9sWWbCwvmFt0bC+ad0QV3y3dw0tFCPxChkMkPF2VyuX7cVhp2aVeWB0jLxX7A2/bhbTXs7taXDsTi4nG4Rb7d0nb1+okdNL9s4nLPCPG8sgPuPuSmFxKU=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by LV2PR12MB5824.namprd12.prod.outlook.com (2603:10b6:408:176::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 21:03:11 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%4]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 21:03:11 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Cornwall, Jay" <Jay.Cornwall@amd.com>, "Yat Sin, David"
 <David.YatSin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: clamp queue size to minimum
Thread-Topic: [PATCH] drm/amdkfd: clamp queue size to minimum
Thread-Index: AQHbh/f9/SGGO+4ogUWvOJKjSahJ8LNaEZUAgAAB9nA=
Date: Wed, 26 Feb 2025 21:03:11 +0000
Message-ID: <CY8PR12MB70999F4D2D441BEF6482858C8CC22@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20250226024132.613233-1-David.YatSin@amd.com>
 <8c6e1698-9e10-4db0-ad05-27f9d95eea2e@amd.com>
In-Reply-To: <8c6e1698-9e10-4db0-ad05-27f9d95eea2e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1394d403-1c4d-4ee4-a7e7-1c12b990999a;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-26T21:02:26Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|LV2PR12MB5824:EE_
x-ms-office365-filtering-correlation-id: 69e39ce2-aa2e-48be-de30-08dd56a8fa9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?c1Z5aEdSc3M0WUlCV0k2OHdCdUIvZ3BnMWVpSHlKc3FpL2lMU0pQSmMrSHQ1?=
 =?utf-8?B?bTVKUVpCZm5ralE1dFM1ZlI5enBHVEJ6Wk1rQmRWN2dlYjh3Wkk1SUx6dU1p?=
 =?utf-8?B?Q3ptbGoxYmk1eGNBZktNQTl5cEVJTnNvYXZ0SzZRaEt6ZVY0SWJBTkV5ZC9t?=
 =?utf-8?B?cUE0TEQzeWYzNzBkbFFkNUNNM01FZ3A0dEQyMEJGaW5nTGljSmpoL1BQT0Nt?=
 =?utf-8?B?bW1xRWhMN09zRXlTOUd1Ry9yUzcrWnFYUTY1cEpuZUM0M3ZWVE8vd2ZDWTB6?=
 =?utf-8?B?d2pzS3VPWVBObCt3M1lxV3hMQ3FGTWFaMEJjTzA1Q3ZTVFZjaVNSbVFRSjRq?=
 =?utf-8?B?MklUMUxzbml2bkNuTjRFTXV4eWxFaTdxMlZRQmpsOGk2Sm5sNUZacDZrYmgv?=
 =?utf-8?B?SW5XQWJCSW9oVEdjQnhLMTF4MzZHckdaWjlQNEFrQlNGenExU2pmVG5PMjkw?=
 =?utf-8?B?Y1hVT1pwNjkvbVRHdjh2c0E3OUIyYW43eUEwWHJBOVZGWEJuYWtBYVN1TXZO?=
 =?utf-8?B?c2kzWWVjM1MwazBLUlBlS1hEbjJmZWNDREhnYmlrZmNuVk85d1kwYXdyOWEv?=
 =?utf-8?B?Q2hMbmgyZnc3RW40UmdLZ3hDUjRQQ3gvREZVLzc2a29ieFJyR2t3d0syOG13?=
 =?utf-8?B?b3dnVWN6U0ZzYkFoOU4vU0VkVUNYczNxZnA0WGZkeDNjK0p6QVFoeDhZVDVt?=
 =?utf-8?B?czk3VWtmbTVVT0w3clJDRTVKMnowRUxWNzZWZDhBQnhTbEFTV2t6VGx0MWhJ?=
 =?utf-8?B?SzJZSFQzSlBvV2crajlRclQ0ZVFQdFVsWjlrS2VjSjBmVjBmR052MFpyWkpW?=
 =?utf-8?B?dlNiUEpmdTVCNG9wUVp6N3JMUi9IS2N3SlQ3Yjdmbkt5LzV1R2owUnFpa0cx?=
 =?utf-8?B?OWJ2dWZuTy84VTM4V21oZEh5YzZCQk84RUhRNzA2ai9Vdm1XdzV5TEliUDdz?=
 =?utf-8?B?WHpnUFRSMWlzUng1WW94U2FtV0hRZXVMa1NML2tKRFhQN1dpVUFHTWJEeHlR?=
 =?utf-8?B?RFV3YXVWZ0phZ1Q1eHFPMkt1VDlrc0Y5Y3lLUTBLT1h4Ly9YWEdsNVh4ZXps?=
 =?utf-8?B?SW1SVG5xMFRaZGtUWTZMbTFnRkdicWpyclF3endhODA1QS9rWXVYWVU3MXZC?=
 =?utf-8?B?cFROTlZFUkFBT1p4VEo5TktUTmxoaG5mQ2lCYU85VkMvZXBiTVhQbUpoOHJQ?=
 =?utf-8?B?MlZFMmpFV00rUXlKM2FNUUk1TXVSTDlaMCsvZHhBc0l2SVFXbzk0Y0Z3bnAy?=
 =?utf-8?B?ak5RNDJmVnc2OXc0ZkxDdWdzc2dZNGtPYjcvSmlDOS9jTWRjNWhLaDJCcW9C?=
 =?utf-8?B?ZzVHN0VVWjBaaC9KWVRWZlVJNFVWaUpPSWRJTWN1STVxZnQ2UGlaaHlSM0NG?=
 =?utf-8?B?SHpFM3BETDFuZ3Z2U1A2QUxwTWJhMkgrMVBicC94MENwdXdPcnNTMlIzTjFW?=
 =?utf-8?B?alJ2WVlEanFhcWdrQlMySmdadlQ5NjBDelRMbDllTmJpUXlzMlByclczaU11?=
 =?utf-8?B?azRGd0FHRjlCTkJQNm10d3RDbjg0R0lvNmhNMGd2Y1hnb0x5eElPbEd1TzA1?=
 =?utf-8?B?SGwxNXJkTmsycmZIclNWb3FON3hTYzhHMGU2cDBlTXlGSHJ3LyszM09yQ0pn?=
 =?utf-8?B?NnRTQTJ1WjZ2clJkdjJhdTRPU0xMdXZ4Nit3RFl5K1NtaTFMdW9pTStoa2Ra?=
 =?utf-8?B?TForWjhubXNBZzZsSVZ3S1lVUHdNSEROUHFkcDJoQnZOaHlVdGFEaHdpalM3?=
 =?utf-8?B?d05BM214MFVQbElDb0cyYzlwS01Ja2thTkRlczR1M29SWTBNd3dYUEU5cXVH?=
 =?utf-8?B?NWlGY3FVYWdFVHgvbTJ4cGtSZ1EwWG93TndRK1EvNkxYdU0raEQ1ZERYMlBi?=
 =?utf-8?B?aHI3QjczK1g0Mk0zWFBzcDhYSkhqRjJDb2VFUjhqL1h1RExhaFd5eXROTUh0?=
 =?utf-8?Q?gpiLn1AXtWV78VGrXxLCxYNar/ScXp2Q?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVNRMnhOUUgrM2txeVMrRjYreVRTbmtPeWVIK3BYbjVRbTJDMjAyZEFmSlc1?=
 =?utf-8?B?dU0yMVpvaGFuWGJERTdkUzQzRlMwTEJ4dGR1c0UvWGhPNEZDS3ZwWDhQT0tw?=
 =?utf-8?B?S1VQNnd3UkQxYXhiZHVmQjFDT0lxS3gzVkJTb0xVKzRDZjdMbEczMUlqSUt3?=
 =?utf-8?B?SlFIOXJsMTA3bXlwMFV5bVYxbmd0UkNBZUpmdkxHVE5vNm9sK3NpTVJZSWpJ?=
 =?utf-8?B?K3lNUUxoZllPNnVUaVhrQ0pRS1FzNU1TMHpIbGVGMmR3clVGRXE4dXVoY01S?=
 =?utf-8?B?N3JKd3E2eXJtYVpCcEwwY2ZvN1UvMmhWNWM0THhLVWhLWnZ0Skw1ZFNXTDlk?=
 =?utf-8?B?UVJQcEFMQlduK3IzTVlOR0xBV3ZDdEdUYmFHM1dpUXJhb3BnTTl5VHBrSWFk?=
 =?utf-8?B?QTIwYUppUElJR3Evc2g5ZGduNTFVU0RmaURwTmZRRmtSK3VDV2NPVnNxS3g5?=
 =?utf-8?B?bDVtOVZBZFVmUG42NnN1cTh0NEFNcUtJV1h6ZGZJd2UvNnlJQzBzdWdZUDgy?=
 =?utf-8?B?a0NhWldsbnJoZjVXQlFzQjdEQUo5KzNvbnNCTzJja21DVHd0cWNOa1hmK3pm?=
 =?utf-8?B?VDhJMElWNks0emJid1lybExtejVlcEY0LzRyQW1CcWxDTXhrWVNtb3JxNnhr?=
 =?utf-8?B?eEczUVdNZng4S09JOG85VkUzSUJYWEJJdHpiMlZRQ2FiSit0Z3lPWFNFakli?=
 =?utf-8?B?dDl3Q2EvZ29CWnY0Z2N6QTZuT1dJQWdmYTRXUEQ3QnVEaDlaUlhPcUpoemtk?=
 =?utf-8?B?L2dNaFdwQ0JlUkRrbUVFcXlNaElXZDRwekxid3A2T1NVbmluQzhZWkJRcEEx?=
 =?utf-8?B?MVNEYTJYZTFPdGRCWnFia1hKdlVleFBGbElENTdKK3hoL2Zia09uUmorMFlI?=
 =?utf-8?B?RWROQ0dwNEY5MWhWaTl2aTNidnJ2MGRGMk5VaVFCbWl6Mmx5M2dzSGNISDEr?=
 =?utf-8?B?cjJ2T2tWU3BNQ1hBY1dYL0ljenlvZ20wSXpseFc1OWlVYkhFK05PeFNuRFVX?=
 =?utf-8?B?blBpRkt0OWxXZWhEOVAwakZMeEVIWk96WHhKdzR4QU9DaGw2Z29XZTlFd3pW?=
 =?utf-8?B?U0pMNE14SGF3Qm45TVJXUmV0K2dSVkRDTy9KbitoN2xhZm9sdXl4OG0xQ0ZU?=
 =?utf-8?B?TW1XNHBMK0RKRE9vWGJkMC9EWWN0TUxrRFd0WXJnblgrVXZJWFVEbkRWdjFX?=
 =?utf-8?B?REdQWHdKQ1VQZHU0T0wrT3YveDJlR0hVNlNrT01FMkZ6SHhvbDFJc1ZtcWZi?=
 =?utf-8?B?M2NEVFdmZEhSUDNNSWFkd2djZ3RYbGNNMGVkVVBwbzk5NDh6MlBNZmE4bE5a?=
 =?utf-8?B?OEQ3RXBtZ284MXlwVzYzeTVGWEQxVHRGbWNjbWxOcjQ2OHNEUkw0SUd0MVdN?=
 =?utf-8?B?cU5JSG5MaWd6emt2Wnc5eWRXdmdZL000ekJHL1ZIaGJrNkptMDFLVjdFb1ZV?=
 =?utf-8?B?WjBsMVJzYjFMNlp1Y3Q1TGVwMmZ5QTFqeVZoWWlnTlhvMm9aS2ZLZ092aXhk?=
 =?utf-8?B?SlpPUVcrTVhPNUhzS0xaNVFTUk45aHFGaURHVFpWM2V3VEQ1eUY5R3Z1WkxS?=
 =?utf-8?B?RWVjaGlKVzl3d1V2S3hWNGQ1TTlOYU9xRTR5em52Q0ljWml0MUpDOWxxajhs?=
 =?utf-8?B?Yng5bVZNTXMrUEhNR3paeTJzc3MwbU00azBLelY4UmZBRy9hRzlUOSt0UFBB?=
 =?utf-8?B?MXVUV1RCSzBkcjJHZUI3SndNMUFERG10QW5TTVFtTU1UZTFQQWVLYzZtK2F2?=
 =?utf-8?B?SDFLeVFaTzRJVC9OQTJoeUNZVmEyK3NlRzEwdXlkd1NBaVlZZTEyZXhxQXNH?=
 =?utf-8?B?dG1yS2dkNnZjRW9DVVlSZXJUb1BOTUpwWk95VSttSUYyL2J4OTNaUDhSMVZu?=
 =?utf-8?B?UnlKdTNPRU45VWNWeW8yeUVUWGFoc3d1eVFibW8xVmwvcE5pZUdhZENxTmZU?=
 =?utf-8?B?Uk9pSEpLM3kzelFnU1ZRcGdLa2xiVWNLeUU4bDVGU2xTeGc4Q3FlUFJIeGNI?=
 =?utf-8?B?TjRCSkVCT3RRMDc0TE56VkkxV3pqQmhUajFERlpvQlZxQkVnT3hXdXExNkxN?=
 =?utf-8?B?T0RvbGp6K2F5eTlId0NGK0xWRXNKamtiTEkyZ3R0RnRyZjg0RENDOWQ5ZHhM?=
 =?utf-8?Q?b2UE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e39ce2-aa2e-48be-de30-08dd56a8fa9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 21:03:11.5692 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V+B0s4LqX4/B7jK7hOhsB2MR9oKVEtUMXdHOwAqSsJ7WnARbN50GPC2YP5Hq6bRvCEL7TUGU63M3+eVhI49JpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5824
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
Cg0KQSBtaW5vciBjb21tZW50LiBXaXRoIHRoYXQgUmV2aWV3ZWQtYnk6IEhhcmlzaCBLYXNpdmlz
d2FuYXRoYW4gPEhhcmlzaC5LYXNpdmlzd2FuYXRoYW5AYW1kLmNvbT4NCg0KUGxlYXNlIGFkZCBw
cl9kZWJ1ZygpIGNvbW1lbnQgc3RhdGluZyB0aGF0IHRoZSBzaXplIGlzIGluY29ycmVjdC4NCg0K
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENvcm53YWxsLCBKYXkgPEpheS5Db3Ju
d2FsbEBhbWQuY29tPg0KU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAyNiwgMjAyNSAzOjU1IFBN
DQpUbzogWWF0IFNpbiwgRGF2aWQgPERhdmlkLllhdFNpbkBhbWQuY29tPjsgYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBLYXNpdmlzd2FuYXRoYW4sIEhhcmlzaCA8SGFyaXNoLkth
c2l2aXN3YW5hdGhhbkBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGtmZDog
Y2xhbXAgcXVldWUgc2l6ZSB0byBtaW5pbXVtDQoNCk9uIDIvMjUvMjAyNSAyMDo0MSwgRGF2aWQg
WWF0IFNpbiB3cm90ZToNCg0KPiBJZiBxdWV1ZSBzaXplIGlzIGxlc3MgdGhhbiBtaW5pbXVtLCBj
bGFtcCBpdCB0byBtaW5pbXVtIHRvIHByZXZlbnQNCj4gdW5kZXJmbG93IHdoZW4gd3JpdGluZyBx
dWV1ZSBtcWQuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIFlhdCBTaW4gPERhdmlkLllhdFNp
bkBhbWQuY29tPg0KDQpSZXZpZXdlZC1ieTogSmF5IENvcm53YWxsIDxqYXkuY29ybndhbGxAYW1k
LmNvbT4NCg==
