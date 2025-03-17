Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F871C282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 20:40:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF15C10E17F;
	Mon, 17 Mar 2025 20:40:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fsmRJQMv";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F010D10E17F
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 20:40:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBPbzROSH8ZD2PBDhkJb+vctACqTjRQkOh4lOVuqlqHNGEehFy7lrZDzMuWEBFAvQBvu4z52opp+s/qrMvfqGBX7HbZiEzItRBIqGLJ0yh4ybR21BZPUq3WhyMjVeLiWU9aVXib/z0zhXHMuJ4kZonFbc0XH2e61wT6k3uhGNMkRSs1EswxNUVoCkZwMzFUPo2pFwx0WLAugvmT5nAx+r3SFjUY4IY7HIBE2+2emJY4rcDswExQjBflRqYWBv+HrC4Ehzj6G3mAmQz/RY+RkpxxWyVgmIPFYmVDSHXbadJnjG7ga3Y/J31iBP7xN3RD28nfk/i6/7K91YHPd6sC2Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpI4whaLz/H6aBZC8mZau6MQl1tFlb2CO6BDq+rnmnc=;
 b=kBiCAGrzLib9L1c7A4UjWhlc6jQW2C8xCEqA05S6FLKr5hqvwdv48eTrlVYKUFEA9FKmNX90p5dJITt3dw0y85edg3lambOr1k9Rm8oHntbB1uIMZ7+sQuTxXZyEAOT/9mnkOLj2+Cu7Ne0ORymbYwlDMSEGBTjUAhv8rCLVhdmLKFeDE+RtmdG5qTHYnIYF1z87iFDA7bw5EjwV0OAfTWCaL4aGQuMwso9xlxM2huVD2RTetRYeJz7DiXdEnQGKSMOeNFqqvbMMgNtqoXv09igu6sdeL6YjrY+1H05CVVccs6v2+rSV+F42BGYm/HgTMap7Qm+D4qB0xFuDyU4OPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpI4whaLz/H6aBZC8mZau6MQl1tFlb2CO6BDq+rnmnc=;
 b=fsmRJQMvnPax1pz6A0nmyoOudO7AsXtm14EBUjUcKXpylDYwyd37/0V6TS4j6TOSuO9KOAd9QcKXaHpanVcUga9oI8TTYFwRexjKZ490DVQEqO8EbarOQxTJx+595+tDzXzZONML12Rr5xhKRHIYbdLBM2hhZjTX428++FUNAj0=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 20:40:03 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 20:40:03 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Six, Lancelot" <Lancelot.Six@amd.com>, "Kim, Jonathan"
 <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: set precise mem ops caps to disabled for gfx
 11 and 12
Thread-Topic: [PATCH] drm/amdkfd: set precise mem ops caps to disabled for gfx
 11 and 12
Thread-Index: AQHblPPU54w44Kb1kUaaxEJVOY8f6rN3LhiAgAChWoA=
Date: Mon, 17 Mar 2025 20:40:02 +0000
Message-ID: <CY8PR12MB70994E2BA0EC0ACFF8A5ED908CDF2@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20250314151416.726789-1-jonathan.kim@amd.com>
 <409bc442-cf25-4a5a-862e-6eb8376c0584@amd.com>
In-Reply-To: <409bc442-cf25-4a5a-862e-6eb8376c0584@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=36439725-4f33-419c-b8db-e1367e9e3fa1;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-17T20:39:55Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|CYXPR12MB9320:EE_
x-ms-office365-filtering-correlation-id: 71ae2091-6c14-45d8-3749-08dd6593e4c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?cjdRQlNkK2dLby8wTEJpK3Nrb1Mrem55bHN0Ny83TzErLy9Sb2RmUkh5SlZo?=
 =?utf-8?B?NkN6ZnlHSVdTbTJJVVFCekQ1L1dxQVJzY25mOWNiTlFNR2NSZGl4OFluNmNM?=
 =?utf-8?B?c2w1ZHNGOU5TNko2VDJxZ2pZMnhRN1lJZXV2aHUyZHdKK21FNm83ZVhKbDRa?=
 =?utf-8?B?WnhJUnl2b1lSQ0pYbGxvaFdUc2Y3YmR2WTVIV0x6TUpXcWkxSFlmN09lMS9E?=
 =?utf-8?B?aW5WR3FGczlQNTlxdUlmV0VqOTFCbi9oV0F4SG5zS1lGdnBaY2UzMVEramZF?=
 =?utf-8?B?OTVGald3SGIvV29Pdkpvakx0aEd6V0RiTmFFUktGbEVyMkR0SWtkb0hmTlN6?=
 =?utf-8?B?TW12M3FMdkh0Z0VxeW5uSmxZYUZudVYrdG5ta0hxQlR3YlZwdkRobTRobWlt?=
 =?utf-8?B?TGVrWmlhWGh2eC8yYWZzMXBSWFE3L0dlUDdZejhyQUhRMmV3NkdVRkNyKyt6?=
 =?utf-8?B?RDdJc0J6UmlQeW5pMWJmNG9EeWRaWUhiRERYRVFXMkQ3dnFSUUxZQW15Mnkx?=
 =?utf-8?B?YWs0ZXMwS3p5UzByeUdpTkE3ZU1kR3A1SDFmbWlxOUJJSVc4L2x1cGpoOEQ3?=
 =?utf-8?B?cmVmSnZ6TGtHTG04NWNJUXRPWmxUOVRWVU9GQks2Ym9TZWdmUVlxRHc1dDN0?=
 =?utf-8?B?MFVyZHQyV2xRbHl6S1NjNE9DL29pYWJFbXgwdEdsb3pGMjJaai8wdndUdW1Q?=
 =?utf-8?B?U1ljSlk4L0E3ZnNiL1pFMWtmUW1YSTByQ0pLVFYxUGVNVHNPQkc5VTV6c3E4?=
 =?utf-8?B?L1ZoRFNDdzJUZ3gxb1RaUStpalN6MmY4MXc2SGswT3N2U0c5aklkRElvYWh4?=
 =?utf-8?B?UXpKV0FXRTZDc0UxZDgzaitTRjJYdWtjSXpmaGc0cG8ydzhYd2JXa3Nnckdr?=
 =?utf-8?B?a0xFamZiWHlPaS81L09ETHg5b1lNSGg1MllmeTB2b2xxZlE3R2R4UklZOG93?=
 =?utf-8?B?TzhnS3k1NzhaUjBBelEzcmVQMENkT0NpWkJxSWtYTVd2c0lDQ0tQaGpjSDhk?=
 =?utf-8?B?Skd1WXo3MVBhaVg3a1FFYU5YYUhlUkVZd0dQQ1dsWE1VZExrdmJsV2Yza3ZJ?=
 =?utf-8?B?V0doTTBDeXlIU00xWk53MWhxVXJxREpHdWEySUFEMUM3ZzNLdkdrMVBiQmVY?=
 =?utf-8?B?NTMxUVQxT1FUdmEwTVJUVG03VU5Yb2xzd3ZQdFZoMnFuY0NlNmpISjdkNUNV?=
 =?utf-8?B?VEpheEdiakgyNlIrSWtYY3NQdHVmMDJNRGI0c2FTK3dmaTAxSkRINjRyQnFP?=
 =?utf-8?B?TU41dVg5SGNZTmhHMlNIZlpLa3YxQndUZDVLNHlmSXQ2OVE1elMwVFpOa0xt?=
 =?utf-8?B?NUlRcFRFV0tqS3dMSlZyV0ZCTVlJaTBiLytBUjlTb09zYUlXUW14aTFsSUZN?=
 =?utf-8?B?VTZ3NlVySlB2YkZ0L20xYk1UcEptRzJYQW1PWmdBdEdzUlJBZkU1eTdBOUR6?=
 =?utf-8?B?ejhDbzA1UUVjSlBvUk9NT0hqTDdRM0ozd2gybm4zVndNNTFhS2kvTkRSSXRo?=
 =?utf-8?B?M1pTQjNUc1JKc1Fqczh1ci9DTmpzVVQzOXNLVExrZmNPWmtXMFljcWcvd2dS?=
 =?utf-8?B?Y3lZajBNbU1rNXRyL2xNcWxiYmdTNUFkYzEyQ1puWE5CSlJ2M2gyV3IzdWp1?=
 =?utf-8?B?OVE2Nks1b3d5QW5FZWFRWnI1TlZnVWQ5L1BOd00rWmpJQm91VjJiemMrb3lE?=
 =?utf-8?B?ZVVkWnlHWnJRQ0Yrem1FekhrdWswcmhJUm5ZRDh3ajhmc0lYVXphU2t1U0xL?=
 =?utf-8?B?cG9seXVMQ25RVjFWODEzZHRTQW9PVytMaTBqMDFieVhTYlkvcnR0dVBWY0Uz?=
 =?utf-8?B?T21melMzNCs5VFJ5ZHZrZ0ZydGluKzBRNzJOUmJNb2Fwb0VyYkx0SDJsL0pv?=
 =?utf-8?B?U1ZER29iNHc0ZDZ5alBMKzYvV1BjQitvekZWczluNGxDNWpYck1BS2VEV1l3?=
 =?utf-8?Q?Mju0IVVkANUx6gjAnXF31UcGk8cKFJxj?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cU1oYkhNRlJvaFMxL3JnVkFhbERuSzFKNVdYaXJEK0N5Wi9DOTFkYS9WbUZQ?=
 =?utf-8?B?R2tXVlJQL0xBQ1F3UGE5Sy8wOHU5eXc3N3JvcEJUTHAwOVRvcHlWdUVSc2xy?=
 =?utf-8?B?UzBGVCs5Nyt2dXpLblgzYS8wUTJ1eFVDOGwvbDczWjFFRjJnSlZ6c3RhNHpT?=
 =?utf-8?B?RVNBSFl0eHhwekFwNUFPWndDMjBod2hobTMxcUJDbWNOSXZ0cDUvaS9ZK3hH?=
 =?utf-8?B?aHdybmFPTkJFMlA1Yi9IK0xQaG10cXRCdHdJeEdHd3htTkZLSjhEam5tS3Jz?=
 =?utf-8?B?emFuQVFvVzJCV1NDcG1oQUp3emFVbkRGTW9mRTk1cjNPTUtXL0t3ZlJwRyt3?=
 =?utf-8?B?eVI1OG1QNkgxTXpjYUxDY0RjQXhmSm9vS1BGMVYyRVNNamlTYzRXQjUxbDZI?=
 =?utf-8?B?aFR4aHUrdHlrM2lRNU5ZOThsYlNGemRqeUZBMVJYVllXN3JTVjlMWXhKczJm?=
 =?utf-8?B?VVVLbEZyWld0Q2hXNDN2Rit2K2VGM1lMQ1EzaEVHWC8yM3RTd0twOFBJSGsv?=
 =?utf-8?B?RGtuZURIRFdzOWYvU0p1TkxCM1lhdmV5Nm4yNWNGenZYUGloeEtmdUZUajIz?=
 =?utf-8?B?MHNqVEE3ZzBFaHhZbllFQVVzeHdrMzgxM28wKzQxeWprMTZhVVAvTzdCV3dx?=
 =?utf-8?B?di92eGd5SDRoM0JiWjNVZHNBQ1RuUXdkU3BZMDBBNHhnMjZGMXZEaWJYQVJ1?=
 =?utf-8?B?QlJQRE43dEFjblRsK3hQQVB3ZnlKdjBSRWdMRDVhcFRpOUJhbmNVcEdZSFRk?=
 =?utf-8?B?bGRwYkN1VlQ5aDFyQ1lBRDNSd3ljYjZGL3I4d3VocGk3Z1dJVWdLUFI4cUda?=
 =?utf-8?B?Njl3UUNsUHliMk40dXZ5ZFBQb2laaTc4V001L0lFbDZQL1g4cGJhS0IzcmVk?=
 =?utf-8?B?YkVDZ3VWRlJJbUErUjZVMzlGTHJhQ3lLbnRkNEE1US9LWitKQ3lsUjJwTzc4?=
 =?utf-8?B?OE1TYktrUW1aS0NkdTlmZU9SbENoeDZyKzlDaW5XcGNvTnozdmZKSW94V1JS?=
 =?utf-8?B?SDJHNWhVQWw3QytzL1dERHF2NGpac1cvQWlMTk1nRlZVMEZaYXVNZU9kMDVq?=
 =?utf-8?B?VWE4SUpmTE1RcWxCL3dJWDRIV0I1eGtCZjk0VTZENTh2aWNNaDgwMWdsWjdo?=
 =?utf-8?B?Q1FQQWk5T2ZtTG81VmhEdHJ1eHozcjhoNnYzTlR4Ny80UUtOZUVudlJFeEtu?=
 =?utf-8?B?S1lGbWpGRmliQ1FKSmZNZEpEWEltTkh4L1ZqczlLeDZIUy92N2xJMU5lT0dZ?=
 =?utf-8?B?Zlg1dFBHWFNrUU9aeGVsVHhWczJxVW02Y1d5TENFdm9uNlFENVExTGVWUUl1?=
 =?utf-8?B?STBReU9ERzFQbUFSL3IvT2crMWRJZXNnNmx1RUJRK2IrUFNMcmRHU05qeDZv?=
 =?utf-8?B?V2xTZXlMaWJlbHduUzhqc28zQisxa0xrSnFYOXZvV2lEMHN5aXk2MFMvNlll?=
 =?utf-8?B?QjROWWNTeUpyekhBU3BTdU03aWxoUG85TE5lS1Bsa21aL2ZwVHozTnNmNlky?=
 =?utf-8?B?SWtyQWViczNiV2d4ZTJURDFmK050UTJnVEVSOGs3MFlaSUdOWUUvKzk0TXJo?=
 =?utf-8?B?RjVYQ3VpcUtQL2JhdlNQdlI3WU85UUNHbzU5MjlSeVhnaDA1R1BtUmVsM2ll?=
 =?utf-8?B?cndneTFJTmYwOGk1NkZURVBiekdDWjBHU0YvVU1YK1d2bEgwc0tTVE9PS0Fh?=
 =?utf-8?B?Y2RQQmtkSW4welp3Ly8yY3VqN01IcmVnbmtPaEE5MkhNMGVMd01YaEV3TU5F?=
 =?utf-8?B?Y3lXbTlCMXlCVTJnYUhiaDNyYUZla3o5NTNxei9IWVQzTHVMY2d2YXphZWty?=
 =?utf-8?B?QUdMUEhldTFuVlA0M1pqd2F6S3VKZHZGcTJkeURBSmJVOWZuOFF3T2J5NTlI?=
 =?utf-8?B?bGlQYUliTVpjOXFYbHBBWTBodlpjZFBYVkJ5bGZDRStLNUZRUXlMNkZQbVVY?=
 =?utf-8?B?MmtHYzg5VDhxalE4Rzd2MnVZT0EwY0U3YWF3ZExWTXdzeG01cHczb3NvN2Jp?=
 =?utf-8?B?QWl1VGVvOGlvTFhMZ3VZZk8xWHhTcUx6S0l5Vksrd0dkbE9WZHc3eDVWSWhP?=
 =?utf-8?B?NHczTUZ3dWtyWGF3cEVGVGJtM0I3eXR0dmRmc0dTZlpMM251QU1LcEwxQWZp?=
 =?utf-8?Q?KeiQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ae2091-6c14-45d8-3749-08dd6593e4c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 20:40:02.8985 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NDjVVkQaYcPPGeteq3UzPv5f4vcvMe8MURCCSUG1x5SRXiOkOHuj40484xULU2ToFVT6JPrPLqtG1S0B17M5Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9320
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

W1B1YmxpY10NCg0KUmV2aWV3ZWQtYnk6IEhhcmlzaCBLYXNpdmlzd2FuYXRoYW4gPEhhcmlzaC5L
YXNpdmlzd2FuYXRoYW5AYW1kLmNvbT4NCg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBP
biBCZWhhbGYgT2YgTGFuY2Vsb3QgU0lYDQpTZW50OiBNb25kYXksIE1hcmNoIDE3LCAyMDI1IDc6
MDIgQU0NClRvOiBLaW0sIEpvbmF0aGFuIDxKb25hdGhhbi5LaW1AYW1kLmNvbT47IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1ka2ZkOiBz
ZXQgcHJlY2lzZSBtZW0gb3BzIGNhcHMgdG8gZGlzYWJsZWQgZm9yIGdmeCAxMSBhbmQgMTINCg0K
DQoNCk9uIDE0LzAzLzIwMjUgMTU6MTQsIEpvbmF0aGFuIEtpbSB3cm90ZToNCj4gQ2xhdXNlIGlu
c3RydWN0aW9ucyB3aXRoIHByZWNpc2UgbWVtb3J5IGVuYWJsZWQgY3VycmVudGx5IGhhbmcgdGhl
DQo+IHNoYWRlciBzbyBzZXQgY2FwYWJpbGl0aWVzIGZsYWcgdG8gZGlzYWJsZWQgc2luY2UgaXQn
cyB1bnNhZmUgdG8gdXNlDQo+IGZvciBkZWJ1Z2dpbmcuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEpv
bmF0aGFuIEtpbSA8am9uYXRoYW4ua2ltQGFtZC5jb20+DQoNCkhpLA0KDQpJIGhhdmUgdGVzdGVk
IHRoaXMgZm9yIGdmeDExLg0KRm9yIHdoYXQgaXQgaXMgd29ydGgsIHRoaXMgcGF0Y2ggbG9va3Mg
dG8gbWUuDQoNClRlc3RlZC1ieTogTGFuY2Vsb3QgU2l4IDxsYW5jZWxvdC5zaXhAYW1kLmNvbT4N
Cg0KQmVzdCwNCkxhbmNlbG90Lg0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF90b3BvbG9neS5jIHwgNCAtLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQgZGVsZXRp
b25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
dG9wb2xvZ3kuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jDQo+
IGluZGV4IDI3ZTczNTZlZWQ2Zi4uZTQ3N2Q3NTA5NjQ2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYw0KPiBAQCAtMjAwNiwxMCArMjAwNiw2IEBAIHN0
YXRpYyB2b2lkIGtmZF90b3BvbG9neV9zZXRfY2FwYWJpbGl0aWVzKHN0cnVjdCBrZmRfdG9wb2xv
Z3lfZGV2aWNlICpkZXYpDQo+ICAgICAgICAgICAgICAgZGV2LT5ub2RlX3Byb3BzLmRlYnVnX3By
b3AgfD0gSFNBX0RCR19XQVRDSF9BRERSX01BU0tfTE9fQklUX0dGWDEwIHwNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBIU0FfREJHX1dBVENIX0FERFJfTUFTS19ISV9C
SVQ7DQo+DQo+IC0gICAgICAgICAgICAgaWYgKEtGRF9HQ19WRVJTSU9OKGRldi0+Z3B1KSA+PSBJ
UF9WRVJTSU9OKDExLCAwLCAwKSkNCj4gLSAgICAgICAgICAgICAgICAgICAgIGRldi0+bm9kZV9w
cm9wcy5jYXBhYmlsaXR5IHw9DQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIEhTQV9D
QVBfVFJBUF9ERUJVR19QUkVDSVNFX01FTU9SWV9PUEVSQVRJT05TX1NVUFBPUlRFRDsNCj4gLQ0K
PiAgICAgICAgICAgICAgIGlmIChLRkRfR0NfVkVSU0lPTihkZXYtPmdwdSkgPj0gSVBfVkVSU0lP
TigxMiwgMCwgMCkpDQo+ICAgICAgICAgICAgICAgICAgICAgICBkZXYtPm5vZGVfcHJvcHMuY2Fw
YWJpbGl0eSB8PQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBIU0FfQ0FQX1RSQVBf
REVCVUdfUFJFQ0lTRV9BTFVfT1BFUkFUSU9OU19TVVBQT1JURUQ7DQoNCg==
