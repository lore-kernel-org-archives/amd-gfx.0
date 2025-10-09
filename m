Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F1DCCD185
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 13:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A815E10EA5F;
	Thu,  9 Oct 2025 13:55:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qAdb1hHy";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013038.outbound.protection.outlook.com
 [40.93.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87B1610EA5F
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 13:55:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISYYl3MxhizUz9TOLfTdu/BgbsZpX+jXVGcXh8PMAMxDN1a0B8vPdxww0p1nnRju0XtS6mwxlXvoosJ2vLbqRZLzVVhRbA5VLV3UmThMjeVBB3hVGcLa8koWx47k3z7/fFOAXakIiXRCaAfX/zGe/0WUO0ePKaGqe9D2Mzhj2ignIF7EVM2fqfC8+Quvip7wGZUfHca6Q4eDw/FUQFTfgMIxzFwQLe38kKJRJyS/t56EsaEWHvz73Ej+eydjl3dB+rjr+ET4Uwav8+ZUIezP453s+7UVJQ8P7KlGwakji2cYfVgIk1rws4o4DZy+u5lVt0qZ2SVjBSEWJu9JFDkoKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKWFJiXyO4GHOqWD7jSvXqFB1cpZAp2gia3XS3PGUVY=;
 b=aNVnaZ57jkoXE1vca4oGM+Tt9JDdaZhMupG1HzqimLg2zIXYZKwbtmZ9hADEr/bW79CgL4a1SM1EYpvzrGw8AWX9boDBmPWRFb/k5m7BjkI+Fmstqb25vvP3YdwogKbXAUqv2V6+yVQlPjFypi1d2UnFupE53acG6Z4KXS7lULx6J4lgz6gSknEQOIbmL0mHtuPLCd0th1i6ahafgG00v68j7TZ54GVXOMetlGrKCTr6Ur1NbmxjGfVf4kvLYOW5JJ/GTE7ltjK18eiqPZKe9hWbbMR3l4cADUxn8nz+U9K94I5TtVVE5ckvkKZ+LDy+/O3ELrTpmZbyNqs30tWOmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKWFJiXyO4GHOqWD7jSvXqFB1cpZAp2gia3XS3PGUVY=;
 b=qAdb1hHySbMhVB+d9wgqzvngoRCvn8dqfq361F72ReulATI090/y1ezr+TlDRHsnQhAHGv9+n9XS3ej8UOKcukDBsfwqCcHzDN3OVJxRkTEkZie6XafbAUuZIXSaO11eO433Fsp+cuy5RwdHKDXOCqxzfYzNHaDZGiHsDL2zI8E=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by CH2PR12MB9519.namprd12.prod.outlook.com (2603:10b6:610:27c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 13:54:58 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::234c:7f13:920d:3cc8]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::234c:7f13:920d:3cc8%4]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 13:54:58 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Shaoyun" <Shaoyun.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix gfx12 mes packet submission status check
Thread-Topic: [PATCH] drm/amdgpu: fix gfx12 mes packet submission status check
Thread-Index: AQHcOHLJRL0QRFecdkyxa3OjtALBLLS4fGsAgAACRdCAAAccAIAAKFcAgAABvQCAASbUkA==
Date: Thu, 9 Oct 2025 13:54:58 +0000
Message-ID: <CY8PR12MB7435ED1163C7C08FE91D60E985EEA@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20251008164408.850834-1-jonathan.kim@amd.com>
 <CADnq5_M_Rk9KX_5Vw+3pxPfrReKqhtF5rn+1P2LidFSJ5y7Wzw@mail.gmail.com>
 <CY8PR12MB74354BE47029963B8FEDCD4385E1A@CY8PR12MB7435.namprd12.prod.outlook.com>
 <CADnq5_PLCEEVbk4ufSnQyqzmW32iBccpk5EXf7kPwdp5=Lpo-Q@mail.gmail.com>
 <CY8PR12MB74358D5E7438A3FF6F7C873185E1A@CY8PR12MB7435.namprd12.prod.outlook.com>
 <CADnq5_OwEwRhf17gqkpEwoPd_znuuLR3KL+5JqZo8JBxqYAAWg@mail.gmail.com>
In-Reply-To: <CADnq5_OwEwRhf17gqkpEwoPd_znuuLR3KL+5JqZo8JBxqYAAWg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-09T13:51:38.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|CH2PR12MB9519:EE_
x-ms-office365-filtering-correlation-id: 61936bb7-fd8c-4531-9c5c-08de073b6f7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Y3ZFblRrQ3MrZWZiWWhXS2p1K0pKM2JrQkpMSFdBZDVIdUIwT0RXWmRIRGd4?=
 =?utf-8?B?RDNleGxJNi9ZYXEvTjc3WnZYRlRoL0JFcnNiYjMrbk1zN1pzNGlFR3U3T0RS?=
 =?utf-8?B?MnF2V2xwaE1oU2N2WitZY3VKamJ4L2h1T0RUSVF6R2YvbXB1ZENETmhuaXVL?=
 =?utf-8?B?cHJlZHIxZ25zYVVURVFPTTBzUGY0ZkpMd3BBRmxWMVlKdkFnREwwczhTWGhG?=
 =?utf-8?B?Q2szaFU2Vlkyc0cyOWdCL0Z4S3A2bkIxS0puSGhKUTI1SGdURGNPUHl5Nm5h?=
 =?utf-8?B?dnJ1dWdQdHNYV291NEQ5UFhoRDJkZUtFd1JodWhhWWd6REdEaldHaHpRdHJC?=
 =?utf-8?B?M05UYmFRVlJSS0RmMVhpN1ppR0ZCd2JGYWVTVXJIbUlUQU84T0VOMExIRyta?=
 =?utf-8?B?VWdVN3ZMWGFsWkZoSTdLS0NabTVrbjJZdnJ2dExKZFNLbnRobWZVZ2tvL1hn?=
 =?utf-8?B?OXlZdFZPOXNXeHdvakxjM0RZRmkrN25HTWxDb3ZnZDgrdHpVMFBXWFZwa2hI?=
 =?utf-8?B?MmN0a1dzU0VTYVZaZFRCYnlWSjlUenQrU0QzQ08zWk95d1FPLzAzSHMxOFVQ?=
 =?utf-8?B?RTR0N3Y3NjBJWW9NS1JERzh5b2lGQkdEL21nTm1MQ0xGRCtGekl0elVnak1a?=
 =?utf-8?B?ZnB6V2xiSEJUYVp2c29MeUM4cFpnY1Q1TDJtRG9mMUJnTjZzSTU3Q1ltUzAx?=
 =?utf-8?B?dXIvM282S2Jwb0hBeXFiME8xRzlmWDEvbW5rNTNHSElQN2toSzV0WThpSFpX?=
 =?utf-8?B?TkgycHJ1bkd2RFRrWkE0c0Z1RWtxMEdlai9qTGkrU3VCamN5b3FFbjdDdnBP?=
 =?utf-8?B?UDY2WlQ0UVhjbjNncytwOWJYZlQxYjErSUh2VVVzQTBTUC9OVXc3SWpGWlda?=
 =?utf-8?B?UWt4NWpFcjBpSHl0Nm05MEdWUkY1R3hFSEN6bGVvbTNqVXkwRk1udndXQlJr?=
 =?utf-8?B?TmlvV2VUNm0rd1QzSmU1RjRGMVhMcHU1ZmJJdDFsdURwZWdQb0NDeTFUaTMy?=
 =?utf-8?B?YktLK1VXUk50VWJSWUU4QlI3NmpvRzJMNzMxTE9yTGRGb2J1SS93ZEFKTU9t?=
 =?utf-8?B?bThQQ003TWhoNXlUVUVkbytLQWwzeTd0elJSNnpsTjhLdWlubCsvM093ajA5?=
 =?utf-8?B?bWRmcXovb2VMWjFBTXF5OFVTU1g0bHJqR0FOM3V5MVpCUVpQQTdUTENOWTNB?=
 =?utf-8?B?M3RPZXlLV0VacGpSQ3dWbFV5UlRoRnE4cEFBUGlkZVF5b21wYVRKc3U0cjFq?=
 =?utf-8?B?c2YzQWJoeUlLL25LakVRTGRqU0lwSzh5akQ2RGY3UDVjenNwNUZTRkR6Mmwr?=
 =?utf-8?B?eXNkSDZkVkxjRTRYOGFRL1ByYzNzdktpM0NTSWpLeHkxM0xSMmpqNFJHakdE?=
 =?utf-8?B?bmdUVnRiOTM4aDhKekFxeW1sa3c5NFdzS1ZaVWpVcEVUVHFKM3ZqRHJCSWVR?=
 =?utf-8?B?eWQ5SGFKeGJiSXhkOHpXVFhVMUMrVWpRMTBBTUI1RDduVUZuNzFYYm56UFNP?=
 =?utf-8?B?UWh0T0pQTzNYSXNQM2tRVVRMSTVCejBiQ3RXc2sxOG94dms4QkN1bGswRWo1?=
 =?utf-8?B?QXFJS1VKWW5MZHppbGxlT1pNaXhmNmtQc1hwVFJVQi9HZCtuNGp0Q2puZ2p6?=
 =?utf-8?B?dUM4cGI0RUVoT1p3OTU4K0ZOWURKWlQ1UXBTSXhOL1JRV1MxZnJlb1V1blNG?=
 =?utf-8?B?TE1CY09hdlp5bE1vR0JTZENMZjJIQWlHeU52ajBKaWdxQUZmRXV6cTdHRkYv?=
 =?utf-8?B?TlI1UFJUbzF1SVpvcjVTblhFMmZHelp1T2M5akZzVUhoQ3hsUDBDYldXdTJq?=
 =?utf-8?B?NWpQY0p6QzZ4dXhiTUE0cHBPSEdGS25NREF2bW1ZTGVTdUZRSVd1Yk54dmMw?=
 =?utf-8?B?RGF1ZitnNzVhTloxUEdaejlWLzBMMlFOaE54YXdOMEJMeTFNdHlBaThNT3Vh?=
 =?utf-8?B?Z2ExTzNYNUNKZTRyWndkZGozY3RQaFNpMkRlVjQva0RjNlNLbVVSaU4yOWZl?=
 =?utf-8?B?ZnRpZmkzandxQW83VGxFbXRZR28xL3JQaTMxWkttUElnSFNTejFrZTB3dXZX?=
 =?utf-8?Q?/YZfYV?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHdGOVB0eGlmd3VMRnJ3em1JNnJMK3k0M0lUVGlpQ2VVOHhkdlE0SU9xcVRU?=
 =?utf-8?B?OFUxVjhzMWZVeUFUd3FxN29lZlFaVU1La1JJVWpvWkIrQitjQkZuY0ZwVlpi?=
 =?utf-8?B?dnVGN1B3SE0wcFY3Y2Z5YnQ1Ti8xcG0ra3ljRTJZWW9PSmJBVThMVTkvZjVp?=
 =?utf-8?B?VGF2VllnbU44SWtHeEQxanM0M2I4VGRSUWNOc2FsL1RZdytCZUY5a09IYVRT?=
 =?utf-8?B?WHNyUksraEtIS3BRRG90aTN0eUx6THo1eWJsUERlV2pjQUJHYmZBZEE5aWpu?=
 =?utf-8?B?RlZlc0d2N1VUYjNPSXcyQ21XWDZENlVZRTlJbUFQSnlXZGN6Wk5IeGR0U2Zw?=
 =?utf-8?B?dE1NckFGK1NjUnplSUZEbFhUSElJdXJSZFVNVHdXUmd1Vnd2SlBFVDJNSkw0?=
 =?utf-8?B?UHpEdE1vKzZPY1VSQXJ6WW1vSE9yNTFyblh1NTVPakFGb2pMRHpMaktVanpQ?=
 =?utf-8?B?VlU1Wkk0MXF5dTZjSk5yazl1VFRyZHVjZkFiZ3E3UG5OYS81cXc5UXI2YVVm?=
 =?utf-8?B?MmhYMStQSUtHeGE5UHNXNTdlTGtCT25MUkNpWk5hZ00wUUdLYzNYcXFqOWpW?=
 =?utf-8?B?bFdEOWxUaC9PUDBxRGlQR1NaRTNhT2tPdEhxSWN2WTB0SndTT3IybndqR25L?=
 =?utf-8?B?NUtFQmd3WXNaZ1kyeGtCU3duSDZXdmloQi9KeUxoMlltQzc4czVhTW9VdXMr?=
 =?utf-8?B?dDc2dTdRK3N1T0lsMWtiM2JyVWtXbGpqUjdDdGhYMmFBdC9jcmpEaXNXTExN?=
 =?utf-8?B?cFJKQ1lhWFU0R3RjOXJGNHorSlQra2lsV2wyNlZ2UkE4b28wU0xrZ3g2dW0w?=
 =?utf-8?B?ZTJGNDJXZVYveDhjOFBBNkR5UHBqZTZEaEoxY1RnaCtKLytvbk90YlkydWNL?=
 =?utf-8?B?WDhBMW91TTFCVkg4YzAwUDNISWMxRXBZeExKNFlUOXpUNzJLOC95NXFaTC8v?=
 =?utf-8?B?TlBTWUxmb2cvZU1YMFBRcGxHbTM0YmYyQzJtRTlPNktDTm4zOWRFeUJtQW9K?=
 =?utf-8?B?VDUvdmJLYzFjWGwzb0h1SHFnY1cxeWdBdGZicE41eXZsMkpvU0pzVExFaTdy?=
 =?utf-8?B?VmNSMFNNN1lBQlZicDl5dUxKWDV2OGl1a3JMNmxWcU05WGo0Q3ZSWmpRU2I3?=
 =?utf-8?B?ZisxNXFRUHJSYWVBaDBLNXNjZWZrQXZ3b21xNHlwdDFCdUhuMmFuODVmRU5s?=
 =?utf-8?B?S1FjRWxJOVZLOHhXOTdGSzYrRC83QStMYWxCd0RxMHE2SmdOdmRUcFU1TWRj?=
 =?utf-8?B?cnlEMko1Vno4RGZBSU9KOThZNGRSbVBicFZJdzBUL1hiRjB0U0JlUEIyaEM0?=
 =?utf-8?B?UXFOQTFWcnpUaUplbTQwdnhwSVY4alpDaVR2T0Jqc0NTbnZYb2hkazFNd0R6?=
 =?utf-8?B?TkpDTmVJbXEwU3VJbkp4aGpOaFNMY3BrN1R4Zm45Q1Z2MnJXaWh5TjA2L1dZ?=
 =?utf-8?B?OXZoOTVEeEZySlVxdHdEa20zczc3UVFqTXBOeXgrQUUzTHQ4ZFU0d3FJRWsx?=
 =?utf-8?B?dXFvNzNpdU0wVm04T0xub2lxTnNSUDRyRXZMWG4vVUlZRjZIdi95eENhQUN0?=
 =?utf-8?B?akY2SGV0K1NVSzFzN0lGNTBZU1dxbGt2VCtKMDduMURXZE9UT2ZWMmpjUElJ?=
 =?utf-8?B?N2FmenIxZU1GMUVvbVFMZ3ZXWnVtYzR4YVJpeFg5aEhkOGFEMkZ4UkdHZm92?=
 =?utf-8?B?a1RUZ01ValVHSitmVlZ0RnN2SG4vcVlJS3lCbjgra0prU3RGcFNIcDhkdmlT?=
 =?utf-8?B?UktaSmNROHUzYVhKTjJhcFY0eGVPNUpzYXA4ZVAwWG9vZkhlTFVLY1JiOFcw?=
 =?utf-8?B?eE83bDVtd1hVblVwenpuVXU3MDl3M3FkZ05Ccm82N2szU2xLaVNmVW14cXBm?=
 =?utf-8?B?c2oxQ0ttbEtPVUk5RjVjRFg2SjVCT3QvNWdUUGdXQzRjK0NVck1FSDl6SVVY?=
 =?utf-8?B?SzBYWWJBRC9zWGFDR25na1djdVNkTG9aUU1BNzM3UWcwYXNUQ3E4WnF3TWI4?=
 =?utf-8?B?TXJjUSs1S3FaV1d2NlF4UDVHT24wV05EdTNRR1ZuTjFWbFJpdHM4ZXorQzV4?=
 =?utf-8?B?eEI0a25QV2t3TndlTTdENG42UGN1K0NRc3ZhQ1VQSzNvdHAvQTF3UU92akNu?=
 =?utf-8?Q?fA6o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61936bb7-fd8c-4531-9c5c-08de073b6f7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 13:54:58.7642 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sJ+wdk86TZExdvL4buY+GzGf1E+7h9QTCzOApgn7zyuBzak8P8fgeqdAOZ9FhqPr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9519
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4IERl
dWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVy
IDgsIDIwMjUgNDoxNiBQTQ0KPiBUbzogS2ltLCBKb25hdGhhbiA8Sm9uYXRoYW4uS2ltQGFtZC5j
b20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgTGl1LCBTaGFveXVuIDxT
aGFveXVuLkxpdUBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBm
aXggZ2Z4MTIgbWVzIHBhY2tldCBzdWJtaXNzaW9uIHN0YXR1cyBjaGVjaw0KPg0KPiBPbiBXZWQs
IE9jdCA4LCAyMDI1IGF0IDQ6MTLigK9QTSBLaW0sIEpvbmF0aGFuIDxKb25hdGhhbi5LaW1AYW1k
LmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBbUHVibGljXQ0KPiA+DQo+ID4gPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBn
bWFpbC5jb20+DQo+ID4gPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgOCwgMjAyNSAxOjQ2IFBN
DQo+ID4gPiBUbzogS2ltLCBKb25hdGhhbiA8Sm9uYXRoYW4uS2ltQGFtZC5jb20+DQo+ID4gPiBD
YzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IExpdSwgU2hhb3l1biA8U2hhb3l1bi5M
aXVAYW1kLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGZpeCBn
ZngxMiBtZXMgcGFja2V0IHN1Ym1pc3Npb24gc3RhdHVzDQo+IGNoZWNrDQo+ID4gPg0KPiA+ID4g
T24gV2VkLCBPY3QgOCwgMjAyNSBhdCAxOjI34oCvUE0gS2ltLCBKb25hdGhhbiA8Sm9uYXRoYW4u
S2ltQGFtZC5jb20+DQo+ID4gPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gW1B1YmxpY10NCj4g
PiA+ID4NCj4gPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiA+IEZy
b206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPg0KPiA+ID4gPiA+IFNlbnQ6
IFdlZG5lc2RheSwgT2N0b2JlciA4LCAyMDI1IDE6MTIgUE0NCj4gPiA+ID4gPiBUbzogS2ltLCBK
b25hdGhhbiA8Sm9uYXRoYW4uS2ltQGFtZC5jb20+DQo+ID4gPiA+ID4gQ2M6IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnOyBMaXUsIFNoYW95dW4NCj4gPFNoYW95dW4uTGl1QGFtZC5jb20+
DQo+ID4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogZml4IGdmeDEyIG1l
cyBwYWNrZXQgc3VibWlzc2lvbiBzdGF0dXMNCj4gPiA+IGNoZWNrDQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiBPbiBXZWQsIE9jdCA4LCAyMDI1IGF0IDEyOjUx4oCvUE0gSm9uYXRoYW4gS2ltDQo+IDxq
b25hdGhhbi5raW1AYW1kLmNvbT4NCj4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiBUaGUgZHJpdmVyIGN1cnJlbnRseSBvbmx5IGNoZWNrcyB0aGF0IHRoZSBNRVMgcGFj
a2V0IHN1Ym1pc3Npb24gZmVuY2UNCj4gPiA+ID4gPiA+IGRpZCBub3QgdGltZW91dCBidXQgZG9l
cyBub3QgYWN0dWFsbHkgY2hlY2sgaWYgdGhlIGZlbmNlIHJldHVybiBzdGF0dXMNCj4gPiA+ID4g
PiA+IG1hdGNoZXMgdGhlIGV4cGVjdGVkIGNvbXBsZXRpb24gdmFsdWUgaXQgcGFzc2VkIHRvIE1F
UyBwcmlvciB0bw0KPiA+ID4gPiA+ID4gc3VibWlzc2lvbi4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiBGb3IgZXhhbXBsZSwgdGhpcyBjYW4gcmVzdWx0IGluIFJFTU9WRV9RVUVVRSByZXF1ZXN0
cyByZXR1cm5pbmcNCj4gc3VjY2Vzcw0KPiA+ID4gPiA+ID4gdG8gdGhlIGRyaXZlciB3aGVuIHRo
ZSBxdWV1ZSBhY3R1YWxseSBmYWlsZWQgdG8gcHJlZW1wdC4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiBGaXggdGhpcyBieSBoYXZpbmcgdGhlIGRyaXZlciBhY3R1YWxseSBjb21wYXJlIHRoZSBj
b21wbGV0aW9uIHN0YXR1cw0KPiA+ID4gPiA+ID4gdmFsdWUgdG8gdGhlIGV4cGVjdGVkIHN1Y2Nl
c3MgdmFsdWUuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGlzIHNob3VsZCBiZSBjb3JyZWN0IGFz
IGlzOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gKnN0YXR1c19wdHIgPSAwOw0KPiA+ID4gPg0KPiA+
ID4gPiBUaGF0J3Mgbm90IHdoYXQgSSdtIG9ic2VydmluZyBhdCB0aGUgbW9tZW50Lg0KPiA+ID4g
PiBhbWRncHVfZmVuY2Vfd2FpdF9wb2xsaW5nIGNhbiBzdGlsbCByZXR1cm4gZmluZSB3aGVyZSBz
dGF0dXNfcHRyICE9IDAgbm9yIDEuDQo+ID4gPiA+IEZyb20gd2hhdCBJJ3ZlIGJlZW4gdG9sZCwg
b25seSAweDEgPT0gc3VjY2VzcyAodGhlIGNvbXBsZXRpb24gZmVuY2UgdmFsdWUNCj4gPiA+IHBh
c3NlZCB0byBNRVMpLg0KPiA+ID4gPiBTaGFveXVuIGNhbiBwcm9iYWJseSBlbGFib3JhdGUgb3Ig
Y29ycmVjdCBtZSBpZiBJJ20gd3JvbmcuDQo+ID4gPiA+IEl0J3MgcHJldHR5IGVhc3kgZm9yIG1l
IHRvIHB1dCB0aGUgSFcgaW4gYSBiYWQgc3RhdGUgKGRhbmdsaW5nIHF1ZXVlcyBwb3N0DQo+ID4g
PiByZW1vdmUpIHdpdGhvdXQgdGhlIGRyaXZlciBrbm93aW5nIGluIGl0cyBjdXJyZW50IHN0YXRl
Lg0KPiA+ID4NCj4gPiA+IDEgaXMganVzdCB3aGF0IHRoZSBkcml2ZXIgcHV0cyBhcyB0aGUgZmVu
Y2UgdmFsdWUgdG8gd3JpdGU6DQo+ID4gPiBhcGlfc3RhdHVzLT5hcGlfY29tcGxldGlvbl9mZW5j
ZV92YWx1ZSA9IDE7DQo+ID4gPiBhbmQgdGhlIG1lbW9yeSBsb2NhdGlvbiBpcyBpbml0aWFsaXpl
ZCB0byAwOg0KPiA+ID4gKnN0YXR1c19wdHIgPSAwOw0KPiA+ID4gVGhlIGZpcm13YXJlIHNob3Vs
ZCBlaXRoZXIgd3JpdGUgMSBvciBub3RoaW5nLCB3cml0aW5nIGEgcmFuZG9tIHZhbHVlDQo+ID4g
PiBpbiB0aGVyZSBsb29rcyBsaWtlIG1lbW9yeSBjb3JydXB0aW9uIG9yIGEgZmlybXdhcmUgYnVn
LiAgSWYgaXQNCj4gPiA+IGRvZXNuJ3Qgd3JpdGUgdGhlIGZlbmNlLCB0aGUgZHJpdmVyIGNhbiBh
c3N1bWUgdGhlIG9wZXJhdGlvbiBmYWlsZWQuDQo+ID4gPiBJZiBpdCB3cml0ZXMgcmFuZG9tIHZh
bHVlcywgdGhlbiB3ZSBoYXZlIG5vIGlkZWEgd2hhdCdzIGdvaW5nIG9uLg0KPiA+DQo+ID4gRlcg
d3JpdGVzIGhpZ2ggMzIgYml0cyB0byBzdGF0dXNfcHRyIGZvciBkZWJ1ZyBjb2RlcyBpZiBsb3cg
Yml0cyBpcyAwLg0KPiA+IFNvIHdlIHNob3VsZCBwcm9iYWJseSBvbmx5IGNoZWNrIHRoZSAzMiBs
b3dlciBiaXRzIHRoZW4uDQo+DQo+IFRoYW5rcyBmb3IgY2xlYXJpbmcgdGhpcyB1cC4gIFBsZWFz
ZSBjaGVjayBpZiBtZXNfdjExIG5lZWRzIGEgc2ltaWxhciBmaXguDQoNCkxvb2tzIGxpa2UgR0ZY
MTEgaXMgZmluZSB0aGUgd2F5IGl0IGlzLg0KVGhlIGhpL2xvIGJpdCBzcGxpdCBpbiB0aGUgc3Rh
dHVzIHJldHVybiBvbmx5IGFmZmVjdHMgR0ZYMTIuDQoNCkpvbg0KDQo+DQo+IEFsZXgNCj4NCj4g
Pg0KPiA+IEpvbg0KPiA+DQo+ID4gPg0KPiA+ID4gQWxleA0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+
ID4gSm9uDQo+ID4gPiA+DQo+ID4gPiA+ID4gLi4uDQo+ID4gPiA+ID4gYXBpX3N0YXR1cy0+YXBp
X2NvbXBsZXRpb25fZmVuY2VfdmFsdWUgPSAxOw0KPiA+ID4gPiA+IC4uLg0KPiA+ID4gPiA+IGlm
IChyIDwgMSB8fCAhKnN0YXR1c19wdHIpIHsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEFsZXgNCj4g
PiA+ID4gPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFu
IEtpbSA8am9uYXRoYW4ua2ltQGFtZC5jb20+DQo+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdjEyXzAuYyB8IDMgKy0tDQo+ID4gPiA+
ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+
ID4gPiA+ID4NCj4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9tZXNfdjEyXzAuYw0KPiA+ID4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
bWVzX3YxMl8wLmMNCj4gPiA+ID4gPiA+IGluZGV4IGFmZjA2ZjA2YWVlZS4uNThmNjExNzBjZjg1
IDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVz
X3YxMl8wLmMNCj4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21l
c192MTJfMC5jDQo+ID4gPiA+ID4gPiBAQCAtMjI4LDggKzIyOCw3IEBAIHN0YXRpYyBpbnQNCj4g
PiA+ID4gPiBtZXNfdjEyXzBfc3VibWl0X3BrdF9hbmRfcG9sbF9jb21wbGV0aW9uKHN0cnVjdCBh
bWRncHVfbWVzICptZXMsDQo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICBwaXBl
LCB4X3BrdC0+aGVhZGVyLm9wY29kZSk7DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gICAgICAg
ICByID0gYW1kZ3B1X2ZlbmNlX3dhaXRfcG9sbGluZyhyaW5nLCBzZXEsIHRpbWVvdXQpOw0KPiA+
ID4gPiA+ID4gLSAgICAgICBpZiAociA8IDEgfHwgISpzdGF0dXNfcHRyKSB7DQo+ID4gPiA+ID4g
PiAtDQo+ID4gPiA+ID4gPiArICAgICAgIGlmIChyIDwgMSB8fCAqc3RhdHVzX3B0ciAhPSBhcGlf
c3RhdHVzLT5hcGlfY29tcGxldGlvbl9mZW5jZV92YWx1ZSkNCj4gew0KPiA+ID4gPiA+ID4gICAg
ICAgICAgICAgICAgIGlmIChtaXNjX29wX3N0cikNCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgIGRldl9lcnIoYWRldi0+ZGV2LCAiTUVTKCVkKSBmYWlsZWQgdG8gcmVzcG9uZCB0
byBtc2c9JXMNCj4gPiA+ID4gPiAoJXMpXG4iLA0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBwaXBlLCBvcF9zdHIsIG1pc2Nfb3Bfc3RyKTsNCj4gPiA+ID4gPiA+
IC0tDQo+ID4gPiA+ID4gPiAyLjM0LjENCj4gPiA+ID4gPiA+DQo=
