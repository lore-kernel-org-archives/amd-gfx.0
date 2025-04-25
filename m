Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160F8C369D1
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 03:32:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B58AE10E281;
	Fri, 25 Apr 2025 03:32:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vX+ZJwBk";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 515E710E27D
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 03:32:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFpIoxV/4jxqbdHJs56lV79bdisTTR05cUI2Yl1Ik5GmU/LQdHCUoHUNPEoBVsW5BcVs+2Su7HMKbJjPjEemXdRuc5KooSbdEiG4NsYm+ej7keLY1GY/RctYdaekUVsQlptaa3SvE9jLMhPJd6w6SN0wobmHI5AifeDEtCE73BHtndtwydzn9DYK+bbBP0iok3CLJ+RzgnYsSl+JGA0it60AUpmujBaHSaGKHA2qzqWIOz/FX+gvBCIwyNG8aGQQ7oD7y0ExRr6ysWhWLbvgnZT3DPt0k/VuZf525Phqq48sIIbhUe514QascKRm+wQ+jtRjwHwR7luJGO3L+4WKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2tMK5aJ+pn/X36wUkqhVrgAsNERSP92pCJ35IZmuCc=;
 b=POIJtoCxR4dBn6G3/OPKy41vsHymQVgb2jnltwvrV1q44rO8ykdPRQ6sui+YHOu2HgN/5cYNn7iG4pojB5i5ThQnb7ejEk40ANtI6cw7a8CXxlA+NAz3+hInRVimZf9ys+WCuv0ejPrR9eYJA8LCuZ9Q6yIZ3gr2L/zLwrlQ4eQ9KOp/k7NjFastD1oeBwGDA9LqNJ3xzqhfcDrCA9XNiYIyAwXcytSHl9gRAWRzJswbVujtRvBHpnyjOv+Fo9tV4JlG/gTy5x+t4wI+VgHyxPtCFfWdmEtIpyxVtH0L5HePB9yF5PphzwHn2C+LidkvtaL3VmVPg5UhK1aBqaMOsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2tMK5aJ+pn/X36wUkqhVrgAsNERSP92pCJ35IZmuCc=;
 b=vX+ZJwBkkAJtg0CMmX8pHxGgGYTMO/b6R4jIFWsjzk1PoQbyWD34e60vORYAfNNA4HEXK+MWsSNnjupszslNP6kjIyBcY3+Wkgf7+e77/ApKzLv4JqhzvYJN95HUTWlOPqeYGKAaQkkDs0UDexMNqLWC4pjUMme6I/IRxDMjNjY=
Received: from DM4PR12MB5261.namprd12.prod.outlook.com (2603:10b6:5:398::22)
 by CH2PR12MB4312.namprd12.prod.outlook.com (2603:10b6:610:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Fri, 25 Apr
 2025 03:32:37 +0000
Received: from DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::e175:f839:8e2e:2885]) by DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::e175:f839:8e2e:2885%5]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 03:32:36 +0000
From: "Xiao, Shane" <shane.xiao@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>
Subject: RE: [PATCH 2/2] amd/amdkfd: Trigger segfault for early userptr
 unmmapping
Thread-Topic: [PATCH 2/2] amd/amdkfd: Trigger segfault for early userptr
 unmmapping
Thread-Index: AQHbtN1hRo2eo1CSh0yfZF/khLjaR7Oy13sAgADjV5A=
Date: Fri, 25 Apr 2025 03:32:36 +0000
Message-ID: <DM4PR12MB5261AF2958CD7A6421FEAB409D842@DM4PR12MB5261.namprd12.prod.outlook.com>
References: <20250424055426.1471075-1-shane.xiao@amd.com>
 <20250424055426.1471075-2-shane.xiao@amd.com>
 <7eac69e0-7392-4d85-bbd2-3cd859120c73@amd.com>
In-Reply-To: <7eac69e0-7392-4d85-bbd2-3cd859120c73@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=e2511559-61da-406d-848a-fd6c59085c78;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-25T03:31:06Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5261:EE_|CH2PR12MB4312:EE_
x-ms-office365-filtering-correlation-id: 65892563-35d6-48aa-352d-08dd83a9d2f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?K0hUWmhSQVQraDN0YlovMFFEQWc4QnFRR0VMRnVsK0JHcUNtd1cya24wczk2?=
 =?utf-8?B?RVlDUVBKTGlNUGJTcUhjL3hXMkVzelVENmdxajdjdDhWenorUkZFQVVyRzQw?=
 =?utf-8?B?TWlGOHJuZTVvamgzYlZyajloR0NsV2E2ZVVpenBiQ0dua3hYOTZoT1dOTUJm?=
 =?utf-8?B?dngxVnovTFhuOExUdmpyNGVGTVdTbTFRUU5iclBVZ3lERFVVMFpWOFRmUUJh?=
 =?utf-8?B?eWhtY3lubWtXZHRFcXM2NHl5VjVNUmtQU3VtMzhzNkp6dTROYUFSRnRJczZl?=
 =?utf-8?B?ZFRhenQyRTRveitLTjZQRU5PaVIyMTZqTm9IQVIyV2M4TGdQemdmOEdNczdI?=
 =?utf-8?B?VVdsS1FqTzV1Qk1HL0lndWVGRlU5Z1hObG9xcHNuM1Zlejl5SUE3SFExSWpR?=
 =?utf-8?B?K3crL0tFaTVmUW8yV1VEVlNoSDAvMWVzYVJnd3FBNFYwMlAzWldMWXgrVk4y?=
 =?utf-8?B?R1NNVXp4dm5PNFdkaGloWk4rSEVoYzVmM3dUM2c2Ujd6YkZpT3BBNzZQL0Jp?=
 =?utf-8?B?RHVZN3ZiK2ErM21zeE1UMnlKd2tFTUMxWmtSblZkdy9lTlNuQlQ0V251L3hN?=
 =?utf-8?B?eExmSjY1aUtLeEVrUWRFWHpFaUI5RUNjOUlkZk1hNWw1aDVTVi9YUEE3T21E?=
 =?utf-8?B?NEZlQ2lxaGFoQko4SkFubkJ0TVkxbWZBb0xMcmwyQm1ROWZTRmt3Yk4yWmxu?=
 =?utf-8?B?V3NSK1RsK0phY29hM1p2WUJ1Wk5hTlc4dVVic0dnMlBLZWVQNnBHSEhlb2hQ?=
 =?utf-8?B?ZndRQlZkM2NRaENwT1BWZ0trbUpsdE01SG94R3FIcmV6N3VlN1FFQWJMTEwr?=
 =?utf-8?B?SXlTdWVMbXhLMGZQeHUrK0ozenMzZDFnQTlibUV4cHpiQkQ1MzB1RUJJd2Vm?=
 =?utf-8?B?aXFKbGZKQmMwMkxFY09tRlpvMjRUU3pWVGxzelIxVW90QmxXcFBEM2JCemw1?=
 =?utf-8?B?U3hnT0hqOVlBUTdITW84VStEdVdmZS9ZSkdYWUNkSjNwNHMwQWlERk0rMzVh?=
 =?utf-8?B?UGVaVjc2MDFKOVVieWc2cDhjamdaR0dkZDhmR2FVRnNZeWNJYmRXT1BweCtR?=
 =?utf-8?B?UGtKRVZ3RjhtelFGeXY5d243WXJ4SWNTeDJSZTFEYlA3RlJTSitwbk5GSEJm?=
 =?utf-8?B?ZVFWK0FjZTRhUUxPVS9aakJCSHVRd1ZuUyt1MzhtSENLYm1yUWlqRGp5YVhM?=
 =?utf-8?B?ZStuR0FLSHZlcEY2Z3RCZnhuNzZ0aXpHYWV4R2wxMGRQMGYwYmNDQWgxUkVD?=
 =?utf-8?B?Q3Z3TDNxeWExSWJzbVd5MDNOUkNzMVVzMURvdWJiS3hsQzhudGJFd2hvd1Ft?=
 =?utf-8?B?dEw2T0lZUjhhQVkvc0t6NURjVUlPN3NISnIwU3FldStBK3Z6UFNUdzdTRWlp?=
 =?utf-8?B?Z1VBUktLNlEwWEh0UUdqMVpjY3ptT0lFZnpmUVZ0c2trTUxiRUxHWEVTTU5n?=
 =?utf-8?B?cEVVQ2MxSE9pR3QxYXNjVi8zaDJVcTlncVo1RDRKcC85VlFMWlJQYWRVZnd6?=
 =?utf-8?B?SjQ5OU8rN010Y0MrdlZLQ3Z4MGpWa2lTTTBLZmZoM052WStrUTVhSWlwV3B1?=
 =?utf-8?B?a09JeXJydkl4RFJMNnlBYlV4RnpZdEdTRXRHVDJ4ZFdRV3JXcGF5djNYdGx0?=
 =?utf-8?B?VWQrQXJQRHJUL2lkN2dabkwvckEvOU5YY1pXRFNkNHROYTAzTW02MjJ0MU1u?=
 =?utf-8?B?ZzVGK1lrRmZRNjUwVXllaUtlUVl2c28vVTFrRDQwcmRrUjRhRzJZNitzeUdW?=
 =?utf-8?B?cndGb0NkZ1Z3dEdicGZad2tCWGd2L2k5YWVBR3d4bFZrUFd5S0NGS2o4MTMy?=
 =?utf-8?B?WEZLMkdyVnp3Yzl2NXFSVjlVVXV2dDRJdlR4QWtoWnljKzRKYSt4K2VzblNk?=
 =?utf-8?B?OFNvZTVBWVhVRGw2ZDc2V1RYbVZzeCtOb01rQjFseXNLNmRzTVhZQjVhUXhi?=
 =?utf-8?B?aEZjUG1ZaXlHa3lwWFRXUmZGVlJrM2tqVDVEL0dtZTVFb1Z1QS9EQlBuWjZ0?=
 =?utf-8?Q?so6hL+dDwWe61hT0AsZFFV7S3c0SFs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5261.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ym9FZ3dlS1R0NUM3SStQYXNtQVVscGJIRjJWR010SGEvZXhEdEpUUGE3VFMy?=
 =?utf-8?B?MTR1TXBMdXVXSU14eHF6ZDBmNlV3anVpWDFtWHp0ODhkZXgrTVdxemZ3WC92?=
 =?utf-8?B?SjlPSy9ER0pjMWtaNllaVUplMDhSWjZHczkxNWQ0UkdNdGloRVcwamNpWHpa?=
 =?utf-8?B?RURrL1JuK3FjbEN2ZHREcEx5aXFLYm5Yd3V0NkFyOU8xN2tHNVhzS1pPSk92?=
 =?utf-8?B?OXNpbjRrV2NZdVNHUllUYjRNbkE0SXcweEZxbzgvSWdCU3RFaVd6bzVCQTlS?=
 =?utf-8?B?byszcXVlU1J3cWhjQmk4U2tRVC9IRjNBNnd4KzhjWTIxYUJ3TldXMGVZTDhO?=
 =?utf-8?B?a3cyZkwwNGd0eHkzYlA5NlprUU1iVXkzVzdXKzRIN09CS1lNRGt3UENzNEJJ?=
 =?utf-8?B?c012ZHJIWTAzUXNsZUN0UzhQSEdubUNZZ0ZoRURreGlUbXRQeE9iMzZ4L2Y4?=
 =?utf-8?B?R1dlc2J2MHVvbVVJcmMxbXhYMmZjTzJneEdxVEZvRG5EVXdXYStQWE5mTkhZ?=
 =?utf-8?B?ME94MjRqLys0a0VJekVXYlUzUVlCbGUrV1NMb1doV0RRcWE5NWpqMWJPeWVN?=
 =?utf-8?B?TnFiaENPcnpkWDZZeXNDWUhFOFEyeGttekZJUmtGRnlyTVJ0L1BuaUdtOHph?=
 =?utf-8?B?bE1tdy9BTTU4RFBTNFliTHZZMWRlczZDZzR0dGFaY2dzdFJWMDBod2QzWGhF?=
 =?utf-8?B?NWcyc1hOUWUzOUV6dVFMMGdzYWYzUG1lSURteGovZHY0WTArajNBVVdRdjJ2?=
 =?utf-8?B?QTJ0WGl3bkxlVS8xWnBsY1h5M05QS2pqNFJIZWF6VXlrVGVkbzlDYTF5R3gz?=
 =?utf-8?B?UTJBd0JFR0FrS0E0OVdiOHh1RjF6dmFrOWIvbUswTUVNdUtDdWNXZ2xTUXgz?=
 =?utf-8?B?UGxmc3JOdGQwYjRmSU82cUtiY3Q0WHRHZS96RVpRNEhmTmFyT29sSVYrbWFv?=
 =?utf-8?B?bVFONFNCT0w4TDRxRnNWb3dGQWhMbnd4VFl3RlZGb0JuNnRuWlFEZW9pVG1G?=
 =?utf-8?B?UExVNU1GWFI5OUJJS2VxQVRlbDZuTjdsaUVKR2NFMzZkbUl3aENSak5wbTdO?=
 =?utf-8?B?ZVJRcUVFd25sSk94TlJkYXBwdElZQWp5QlpjVks0bVZGTFowb1RsTmgyeFBu?=
 =?utf-8?B?ZVNtOEZLM0NTSC91K282djFKbnlsN0pVQXArYUhDRzU5WHBjb2hubEpnN1cz?=
 =?utf-8?B?VHJuWXE3ZkZ0N1BMejd5RWl0MExiWkJSbndzblRVZnNreGtkeHFZRTQ3WWdx?=
 =?utf-8?B?ZkI4dWlvalhjWE42SWp0dmovdVVjNVNwQS85V0FweHFiT3JjMFYvdjR6d2sr?=
 =?utf-8?B?WHdyaFV2N2FZb2p1d0c0b3ZJcXNlV3NIUTFKbjVuTWhENXlGQjN4Ymc2bjhr?=
 =?utf-8?B?THdzZTJQUTJpU2k3dEpDOU1ZZmVJS05jLy91MjlsWTVXSFZGdmxzM3RRZDN4?=
 =?utf-8?B?bzZ0Ri9URW94aWEzdWVIeGYwNUJzRDR6MDMzbW1jd1VzTUFvS0N0bDJpZmgx?=
 =?utf-8?B?Nit0U2p4VFRFc3N6UEtJeFp4VTA1VTluSXhhM2dDQ0lYVVN3UUJYdXZhbG84?=
 =?utf-8?B?WXBUUmtCNGJEQkllU2swNXR0QmdlaDFFTXI2TDUwbTI4dDZUMmRzbEYzR3gw?=
 =?utf-8?B?eGxWUGFiNmZIQUw0djFvSVduNENUWUcrSGw5ZEFYd3phK21nQUVhdUh2cEF3?=
 =?utf-8?B?M05SYW5iZldia2poazRXY2gyMzYyZG9XdVMwSi94Z3dWSXdpMmN3dmpzc2VG?=
 =?utf-8?B?SDVRQjdvbmM1MVgwODF2a2pESk1OeU5WdFBpS2FLSVNBeERUdE1QSi9vaStq?=
 =?utf-8?B?RDVHdjluWDlYRERyUHZDaHBWdnRGdFpjMUs5RHhpdDVxUmNkUkRrV0JwK0Jo?=
 =?utf-8?B?c1lKV0l6RVRxTWVUNlNFcW5MaHhzWW1nSDQrbVdyVUxOazJYZGtRMUwzdk9Y?=
 =?utf-8?B?MndVaVVEY1FrdDBUU3hUWmlYK3luMEIvMWpFQkhUa2xzOWhaSm9NZzA2ZFpW?=
 =?utf-8?B?cnc4WHRaY2lyL2p0SUlWT2dsa1RoRDQ2TlIzaDdCZ0FBTWNuU3BTaUVMVzdl?=
 =?utf-8?B?WHgyaHg4cDM0MUlrTkxJRTBSNGdxK3NjbEg1NEpvbTdLZjYrcjRpcUplM0hk?=
 =?utf-8?Q?p0Iw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5261.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65892563-35d6-48aa-352d-08dd83a9d2f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 03:32:36.8510 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AQH9FxPO8rj428yV5FwwOiGUnaoS2pfkoTZsPs9QZkChtFP7fR/aNW959auVdQlbAGpZTVgqRVj5jWQOGhDATg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4312
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLdWVobGlu
ZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBBcHJp
bCAyNCwgMjAyNSA5OjU2IFBNDQo+IFRvOiBYaWFvLCBTaGFuZSA8c2hhbmUueGlhb0BhbWQuY29t
PjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7DQo+IEtvZW5pZywgQ2hyaXN0aWFuIDxD
aHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBZYW5nLCBQaGlsaXANCj4gPFBoaWxpcC5ZYW5nQGFt
ZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBhbWQvYW1ka2ZkOiBUcmlnZ2VyIHNl
Z2ZhdWx0IGZvciBlYXJseSB1c2VycHRyDQo+IHVubW1hcHBpbmcNCj4NCj4NCj4gT24gMjAyNS0w
NC0yNCAwOjU0LCBTaGFuZSBYaWFvIHdyb3RlOg0KPiA+IElmIGFwcGxpY2F0aW9ucyB1bm1hcCB0
aGUgbWVtb3J5IGJlZm9yZSBkZXN0cm95aW5nIHRoZSB1c2VycHRyLCBpdA0KPiA+IG5lZWRzIHRy
aWdnZXIgYSBzZWdmYXVsdCB0byBub3RpZnkgdXNlciBzcGFjZSB0byBjb3JyZWN0IHRoZSBmcmVl
DQo+ID4gc2VxdWVuY2UgaW4gVk0gZGVidWcgbW9kZS4NCj4gPg0KPiA+IHYyOiBTZW5kIEdQVSBh
Y2Nlc3MgZmF1bHQgdG8gdXNlciBzcGFjZQ0KPg0KPiBTZWUgc29tZSBjb21tZW50cyBpbmxpbmUu
DQo+DQo+DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFuZSBYaWFvIDxzaGFuZS54aWFvQGFt
ZC5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtm
ZF9ncHV2bS5jICB8IDE0ICsrKysrKysrKysrKysNCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX2V2ZW50cy5jICAgICAgIHwgMjAgKysrKysrKysrKysrKysrKysrKw0KPiA+ICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oICAgICAgICAgfCAgMyArKysNCj4g
PiAgMyBmaWxlcyBjaGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+ID4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMNCj4gPiBp
bmRleCBkMmVjNDEzMGEzMTYuLjg3NmU5ZGYzNGFkZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMNCj4gPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMNCj4gPiBAQCAtMjQ5
Niw2ICsyNDk2LDcgQEAgc3RhdGljIGludCB1cGRhdGVfaW52YWxpZF91c2VyX3BhZ2VzKHN0cnVj
dA0KPiBhbWRrZmRfcHJvY2Vzc19pbmZvICpwcm9jZXNzX2luZm8sDQo+ID4gICAgIHN0cnVjdCB0
dG1fb3BlcmF0aW9uX2N0eCBjdHggPSB7IGZhbHNlLCBmYWxzZSB9Ow0KPiA+ICAgICB1aW50MzJf
dCBpbnZhbGlkOw0KPiA+ICAgICBpbnQgcmV0ID0gMDsNCj4gPiArICAgdWludDY0X3QgdXNlcnB0
ciA9IDA7DQo+ID4NCj4gPiAgICAgbXV0ZXhfbG9jaygmcHJvY2Vzc19pbmZvLT5ub3RpZmllcl9s
b2NrKTsNCj4gPg0KPiA+IEBAIC0yNTU5LDYgKzI1NjAsMTkgQEAgc3RhdGljIGludCB1cGRhdGVf
aW52YWxpZF91c2VyX3BhZ2VzKHN0cnVjdA0KPiBhbWRrZmRfcHJvY2Vzc19pbmZvICpwcm9jZXNz
X2luZm8sDQo+ID4gICAgICAgICAgICAgICAgICAgICBpZiAocmV0ICE9IC1FRkFVTFQpDQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4NCj4gPiArICAgICAg
ICAgICAgICAgICAgIC8qIElmIGFwcGxpY2F0aW9ucyB1bm1hcCBtZW1vcnkgYmVmb3JlIGRlc3Ry
b3lpbmcgdGhlDQo+IHVzZXJwdHINCj4gPiArICAgICAgICAgICAgICAgICAgICAqIGZyb20gdGhl
IEtGRCwgdHJpZ2dlciBhIHNlZ21lbnRhdGlvbiBmYXVsdCBpbiBWTQ0KPiBkZWJ1ZyBtb2RlLg0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICovDQo+ID4gKyAgICAgICAgICAgICAgICAgICBpZiAo
YW1kZ3B1X3R0bV9hZGV2KGJvLT50Ym8uYmRldiktDQo+ID5kZWJ1Z192bV91c2VycHRyKSB7DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIGFtZGdwdV90dG1fdHRfZ2V0X3VzZXJwdHIo
JmJvLT50Ym8sDQo+IHVzZXJwdHIpOw0KPg0KPiBJIHRoaW5rIHlvdSBtZWFudCAmdXNlcnB0ci4g
QnV0IHRoaXMgd2lsbCBnZXQgeW91IHRoZSBDUFUgYWRkcmVzcyBvZiB0aGUgdXNlcnB0ciwNCj4g
bm90IHRoZSBHUFUgYWRkcmVzcy4gRm9yIHJlcG9ydGluZyBhIEdQVSBmYXVsdCBpdCB3b3VsZCBt
YWtlIG1vcmUgc2Vuc2UgdG8gdXNlDQo+IHRoZSBHUFUgYWRkcmVzcyBpbiBtZW0tPnZhLg0KDQpZ
ZXMsIHdpbGwgdXNlIGdwdSBhZGRyZXNzIHRvIG5vdGlmeSB1c2VyIHNwYWNlLg0KDQo+DQo+DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIHByX2VycigiVXNlciBzcGFjZSB1bm1hcCBt
ZW1vcnkgYmVmb3JlDQo+IGRlc3Ryb3lpbmcgYSB1c2VycHRyIHRoYXQgcmVmZXJzIHRvIGl0XG4i
KTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgcHJfZXJyKCJUaGUgdW5tYXAgdXNl
cnB0ciBhZGRyZXNzIGlzDQo+IDB4JWxseFxuIiwgdXNlcnB0cik7DQo+ID4gKw0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAvLyBTZW5kIEdQVSBWTSBmYXVsdCB0byB1c2VyIHNwYWNl
DQo+ID4gKw0KPiAgICAgICBrZmRfc2lnbmFsX3ZtX2ZhdWx0X2V2ZW50X3dpdGhfdXNlcnB0cihr
ZmRfbG9va3VwX3Byb2Nlc3NfYnlfcGlkKHByDQo+IG9jZXNzX2luZm8tPnBpZCksDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhbWRncHVfdHRtX2FkZXYo
Ym8tDQo+ID50Ym8uYmRldiktPmtmZC5kZXYsIHVzZXJwdHIpOw0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgfQ0KPiA+ICsNCj4gPiAgICAgICAgICAgICAgICAgICAgIHJldCA9IDA7DQo+ID4gICAg
ICAgICAgICAgfQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9ldmVudHMuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2V2
ZW50cy5jDQo+ID4gaW5kZXggZmVjZGI2Nzk0MDc1Li44OTk0M2QyMTQ2YTQgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2V2ZW50cy5jDQo+ID4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2V2ZW50cy5jDQo+ID4gQEAgLTExNzcsNiAr
MTE3NywyNiBAQCB2b2lkIGtmZF9zaWduYWxfaHdfZXhjZXB0aW9uX2V2ZW50KHUzMiBwYXNpZCkN
Cj4gPiAgICAga2ZkX3VucmVmX3Byb2Nlc3MocCk7DQo+ID4gIH0NCj4gPg0KPiA+ICt2b2lkIGtm
ZF9zaWduYWxfdm1fZmF1bHRfZXZlbnRfd2l0aF91c2VycHRyKHN0cnVjdCBrZmRfcHJvY2VzcyAq
cCwNCj4gPiArICAgICAgICAgICBzdHJ1Y3Qga2ZkX2RldiAqZGV2ICwgdWludDY0X3QgdXNlcnB0
cikNCj4NCj4gZGV2IHNlZW1zIHRvIGJlIHVudXNlZC4gWW91IGNhbiByZW1vdmUgdGhhdCBwYXJh
bWV0ZXIuDQoNClN1cmUsIHdpbGwgdXBkYXRlIGl0IGFjY29yZGluZ2x5Lg0KDQpCZXN0IFJlZ2Fy
ZHMsDQpTaGFuZQ0KDQo+DQo+IFJlZ2FyZHMsDQo+ICAgRmVsaXgNCj4NCj4NCj4gPiArew0KPiA+
ICsgICBzdHJ1Y3Qga2ZkX3Byb2Nlc3NfZGV2aWNlICpwZGQ7DQo+ID4gKyAgIHN0cnVjdCBrZmRf
aHNhX21lbW9yeV9leGNlcHRpb25fZGF0YSBleGNlcHRpb25fZGF0YTsNCj4gPiArICAgaW50IGk7
DQo+ID4gKw0KPiA+ICsgICBtZW1zZXQoJmV4Y2VwdGlvbl9kYXRhLCAwLCBzaXplb2YoZXhjZXB0
aW9uX2RhdGEpKTsNCj4gPiArICAgZXhjZXB0aW9uX2RhdGEudmEgPSB1c2VycHRyOw0KPiA+ICsg
ICBleGNlcHRpb25fZGF0YS5mYWlsdXJlLk5vdFByZXNlbnQgPSAxOw0KPiA+ICsNCj4gPiArICAg
Ly8gU2VuZCBWTSBzZWcgZmF1bHQgdG8gYWxsIGtmZCBwcm9jZXNzIGRldmljZQ0KPiA+ICsgICBm
b3IgKGkgPSAwOyBpIDwgcC0+bl9wZGRzOyBpKyspIHsNCj4gPiArICAgICAgICAgICBwZGQgPSBw
LT5wZGRzW2ldOw0KPiA+ICsgICAgICAgICAgIGV4Y2VwdGlvbl9kYXRhLmdwdV9pZCA9IHBkZC0+
dXNlcl9ncHVfaWQ7DQo+ID4gKyAgICAgICAgICAga2ZkX2V2aWN0X3Byb2Nlc3NfZGV2aWNlKHBk
ZCk7DQo+ID4gKyAgICAgICAgICAga2ZkX3NpZ25hbF92bV9mYXVsdF9ldmVudChwZGQsIE5VTEws
ICZleGNlcHRpb25fZGF0YSk7DQo+ID4gKyAgIH0NCj4gPiArfQ0KPiA+ICsNCj4gPiAgdm9pZCBr
ZmRfc2lnbmFsX3ZtX2ZhdWx0X2V2ZW50KHN0cnVjdCBrZmRfcHJvY2Vzc19kZXZpY2UgKnBkZCwN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGtmZF92bV9mYXVsdF9pbmZv
ICppbmZvLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qga2ZkX2hzYV9t
ZW1vcnlfZXhjZXB0aW9uX2RhdGEgKmRhdGEpDQo+IGRpZmYgLS1naXQNCj4gPiBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmgNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9wcml2LmgNCj4gPiBpbmRleCBmNmFlZGY2OWM2NDQuLjM0ZjQ3ZGMxY2JiZCAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oDQo+
ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYuaA0KPiA+IEBAIC0x
NTA3LDYgKzE1MDcsOSBAQCBpbnQga2ZkX2V2ZW50X2NyZWF0ZShzdHJ1Y3QgZmlsZSAqZGV2a2Zk
LCBzdHJ1Y3QNCj4gPiBrZmRfcHJvY2VzcyAqcCwgIGludCBrZmRfZ2V0X251bV9ldmVudHMoc3Ry
dWN0IGtmZF9wcm9jZXNzICpwKTsgIGludA0KPiA+IGtmZF9ldmVudF9kZXN0cm95KHN0cnVjdCBr
ZmRfcHJvY2VzcyAqcCwgdWludDMyX3QgZXZlbnRfaWQpOw0KPiA+DQo+ID4gK3ZvaWQga2ZkX3Np
Z25hbF92bV9mYXVsdF9ldmVudF93aXRoX3VzZXJwdHIoc3RydWN0IGtmZF9wcm9jZXNzICpwLA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qga2ZkX2RldiAqZGV2ICwgdWlu
dDY0X3QgdXNlcnB0cik7DQo+ID4gKw0KPiA+ICB2b2lkIGtmZF9zaWduYWxfdm1fZmF1bHRfZXZl
bnQoc3RydWN0IGtmZF9wcm9jZXNzX2RldmljZSAqcGRkLA0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzdHJ1Y3Qga2ZkX3ZtX2ZhdWx0X2luZm8gKmluZm8sDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHN0cnVjdCBrZmRfaHNhX21lbW9yeV9leGNlcHRpb25fZGF0YQ0K
PiAqZGF0YSk7DQo=
