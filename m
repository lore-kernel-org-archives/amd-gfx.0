Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8C9D15D88
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Dec 2025 15:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BBFB10E8C6;
	Wed,  3 Dec 2025 15:54:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3nk1r3Ku";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BACAC10E89E
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Dec 2025 15:54:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JE8ifrFdLiCOIRtSAOAARZ9jftlNxCu/3gV0TLQddkZCxoZYJS/4R7GeOLGoRBC+OOgPFj4EjBuRHO2MKoM/brIvAYR3UsXaq+IOw9IXNXf+7edFCRJ/85T9e7hTiN+VMMNc9Z1aiZBtsKvxy5A6Zq0GxQ53WbXv0WAxoQFVUweQHlV6nnJXDGuf++lDXjVhuscl6mxbUm72CpZ7Ny9633+sGGD1Bn+XymXhLjOG+3Xjt2l8wlOqJlOnBtEFICHM3IU3lRkRiAW1PPnVGeQNXVbCpSmnWi7avnuQTxTFN3Ocq2r9kb8rdS/JUkq1dR810tgVbo2J370ewzErUDRSQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9d9tGyuKDDDBpxjIllEYblAwjkUlZ58ufCY0t8qY6XU=;
 b=IoeKgFZydPw1I2hBgLNDBTD5z/zoroIJvL9v3IAMES53yVYlFHy+Hf0pQMASlf1bt6LfDV83BTtEtMfxMlFAg5JRi3Ek2FlrBpoedPWc+fCndUzUsjY3B3knmqHlULerVw+VGPjoo2jAA0iFGNHgpNvyHaEALi+sRxX/2VYZAyyTPQqgMUGRAgHAJdEVXtLEy4TcQ0rS9JX521rSAL6R2IyFiPNaz7pnUqf8EAEDsZCv1C/fDy0njx203ooQMUb2xhTcf4kMImp07ML3L0qg/I+OrubIoUBrOkXthciWhTsze08LAoIsjvk5mk3K8JXeCfPfR2cn34jCi+o2dG4bcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9d9tGyuKDDDBpxjIllEYblAwjkUlZ58ufCY0t8qY6XU=;
 b=3nk1r3KuosvoId61ohL1R9Fo09bD2J7gW+qQQicVfvGUU/Av3VQr5HavI0o364M8mr32CizVGgPw1Vl9NZtRiFAdGP0iCDqb4Dz2DnaJutH6a38melbzU+kyMRChDnd0xn4n4dehwFOx5EkCKOl03rFM2P2jCmjTlG+hpCPr9A0=
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7)
 by SJ2PR12MB7962.namprd12.prod.outlook.com (2603:10b6:a03:4c2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 15:54:25 +0000
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::633:3c3f:3a9b:993]) by SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::633:3c3f:3a9b:993%4]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 15:54:25 +0000
From: "Martin, Andrew" <Andrew.Martin@amd.com>
To: "Yang, Philip" <Philip.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3] drm/amdkfd: FORWARD NULL
Thread-Topic: [PATCH v3] drm/amdkfd: FORWARD NULL
Thread-Index: AQHcWMrA7ZZ/lLCWvEeS/aHROBooyrUO0IaAgAFVtQA=
Date: Wed, 3 Dec 2025 15:54:25 +0000
Message-ID: <SJ0PR12MB8138AE5740666E75504A12E8F5D9A@SJ0PR12MB8138.namprd12.prod.outlook.com>
References: <20251118203419.2528796-1-andrew.martin@amd.com>
 <cb1faf3c-f06c-45d1-bf33-da0aabc38228@amd.com>
In-Reply-To: <cb1faf3c-f06c-45d1-bf33-da0aabc38228@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-03T15:45:54.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8138:EE_|SJ2PR12MB7962:EE_
x-ms-office365-filtering-correlation-id: 8cecdecf-0677-4cf8-159f-08de32843bbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RzVTNXA1NC92VzZhWEhGYW4xV0h3aVE0S25UOGFqMzdmcFNDQ2FzbWcvSmYr?=
 =?utf-8?B?RHJ5c0hEZEVrQnVTaG9FU08wdmM0S05HeC93VnJHdXB4Mi9RL2pjbm5oVjBk?=
 =?utf-8?B?TGo5Vy9VNTVwYUg0elAyLzVHaTh3dFdYU3hhbHB3WU5vdW5ndVNKRGFnSFQ1?=
 =?utf-8?B?a3E1dXdneHJHQms3aURQNjBpY3ptVzJaSXQzc2JkNWZIWW9yT2NtQkh5ODda?=
 =?utf-8?B?ZmlXKytBUnc1SU1NTTIrSTZEQXdPTHk2TGZPTzdvM2F0QUoyazlKTFlBblRq?=
 =?utf-8?B?NittbzRUZTdOWVRYV2orZFd1SkJZYW1EM0RFcmFQb3BOVG5BbUpFRVpmYUZz?=
 =?utf-8?B?aUlyUmVkLzdsTC9JNVo5N1gzTWtieHlkdmhCWVV2Wmo5Yk1rOGY0cElaQll6?=
 =?utf-8?B?ZHlKK21vNDJkalJVc2tFVmpZQTE2bnFwVEg5TzlrTS9xNE80NmFlR1Myd2sx?=
 =?utf-8?B?cCtIcXhFakhTUUZXb2NaRnpWSjd1RmpGWEJpT3EyV1Y1SDUvdStLU0tsVzI0?=
 =?utf-8?B?UU9ETGNmM0hzUC91K0RvTnBzLzJEdkt1RU05aWZocGl5aUFuSTZ2NGFhZDdS?=
 =?utf-8?B?MktwV25aTWFqVmZtN1o4d2xub05qdCttbVVUYklLbEtBQUhoeS9pNVVBVEFF?=
 =?utf-8?B?SGQyekVYMFc1L0RERk5jNkU1Um9SYk9LZjQ1TDdUTVpITTNxeE5GOGpmQ0dn?=
 =?utf-8?B?ZlFkVmkvM1VOUjdoeitVaUVLeklhNWl6eWFaQVBKWEhzNjhhMTZPTEJPVElF?=
 =?utf-8?B?MmpPRjNVaGpnU0haM2dETXhkOWsyTW51M3JXSXJrS1ZvZVhaa1cxSmN1cDRK?=
 =?utf-8?B?NjFwTjJTTUJTTWpZN0UzNTdmYnJkempISE9kc3VXMks0bC9lNUlGVDFHam9K?=
 =?utf-8?B?c1E4Q2FnWUMzcEtuSGF1ckRvK3A3T1VxenhEejdxOHB4b3dXNjZqaUticG1D?=
 =?utf-8?B?Y3RMeUVvQmZVTEtqWkxtMzhuSXlhZnhlT3I5QUVsZ1M4ajdFRTQvREFaVk5N?=
 =?utf-8?B?c2Rpc3RuVXJ6TzhNUHd4SHN5b2VsMFhzeHEzcFE4dVF3SlRxSjA1Z08vbmhE?=
 =?utf-8?B?eWVYbEV0TmczQzBsakFPd3FuM3Rhb0g2WlRaQkFwMjE0aHFKc2hxa2VnaStp?=
 =?utf-8?B?aGtZT0haalBJVjVmdXk3dmsxeDVMQU5vQkU5a3JQdzRXVEhvamtlYWdOV052?=
 =?utf-8?B?cjRqZkJ2QnlXaUdBemplQjF4NFlleVFyQnNlcnA3S2NTV1kzQ0NFbnRPVDdE?=
 =?utf-8?B?VE91cmhITGdSZUYvWGozS1JyOC8vc1FjQUVkUEVBTmU0NmJBbTU2V0dzRk5j?=
 =?utf-8?B?Tk41SytWZXI2OWk5QmswRW9ETUJ6OEFNZGJkcjBCanJkOThaY1I2c2hUM2tR?=
 =?utf-8?B?TW91SXloUEREMWdIYnd0VWphRUFoOEFxSHAxNXZsSTNrUUNObFRMSU54S212?=
 =?utf-8?B?Nnd0RThQMUpvc254bWtWMUtyNCtGU1R2cC9pdW1SNitkWS8vU1RWUFRFVkFE?=
 =?utf-8?B?YnVHVG5qQzB0MmhyWmZySHFHQnJqaTZjTit0U012cXVjQkpnQ2ZlQzM3S0o5?=
 =?utf-8?B?SjJvaDMxQTlwaEV2UGIyRXZLZmIzcHJUWnozVDlBektuTDQ4QThuQk4xY1Y4?=
 =?utf-8?B?K3pPT2VOTndTek1sUDlDRFNjekxiUHBHd0JWNkpvM2Zvam91NjMxY2ZXd0RJ?=
 =?utf-8?B?SFUzWDNsLy9UemprK0RLOU83WTBXTm9lclRJdnpISFozY2QzRCt0KzJ3Nis2?=
 =?utf-8?B?OGlBUXZQNFVYSDZxeGEzZUNPOXphUzZDNzUzY2dwSXJxaG1yMkJSNXdIRjgz?=
 =?utf-8?B?UHJQTHI0V1hpY3ZZc2xYRjI4NWpUNkJQcFJVaWJ5WFdqQzdISUxYNWkxTGV3?=
 =?utf-8?B?Mm9DUVR4OGdHVFVodXJmUjR3MWRqUm45VURMcUV5eUduUThGVkFQWWFuTnVF?=
 =?utf-8?B?dmdGeElxZHJtS1UxOFhrTkxZajJRdG4vM2Vtb283NW50Zy91dVhXa012V2Ri?=
 =?utf-8?B?NEFCOFlqZ2FKZkdBdUVSRnNnTUVjbHVoWEVDc1h6MDcwNVdhYitsRW1CWGt3?=
 =?utf-8?Q?/qxE6o?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8138.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0swMURlZ0Rob3hPOFdjMFF4MHNGcEUzMWhTd0dDeW1mcUFSb1BSK1Z2bDJB?=
 =?utf-8?B?Q01ZMGd5NFlDQUZjbWxIcUo2VW9URkoxMkZVZmUveEJ6VUpISllSdU91bzhj?=
 =?utf-8?B?bjZ0dnB3SW1ONEF4OU94SndpWkNhMWc3dU1yYlpVbnRDOHZTRnJOWDZRV0g2?=
 =?utf-8?B?NGg3ZytMYjhJczZ4YVNScEE4NXBrRTRrZjFhbFhhWUJLWmlSVU9RNFk3bVM5?=
 =?utf-8?B?V3p6VElZWFVyS3ZQR1RMc0t4aGpiQUpEdjZiNlFvSC8wVEJCa21MS24zL2lh?=
 =?utf-8?B?TENyMS90eFA0WGxFRjlacjlSL2FJcmpWTVd6QmNEUDhZQXJtblpwcjRuWUxw?=
 =?utf-8?B?QitsRzJhMW5FdEpGMDRoZkozeVFnNlNQZE1Jb2pIdGtibXcrNVJzNlNGQVlr?=
 =?utf-8?B?Zno1MFhPWHlVMEJuSmRUcUI4djhkcHJQSjRyZUswT1R0eWx1VGQyVmxuZi9m?=
 =?utf-8?B?N2thWStBeXNtRmszOCtWZzB0Vk91eXRLMTBWTnU1VlAybkt1VlJQdkw0YWZH?=
 =?utf-8?B?cmRHbTZyRmluSWYybXcwVUxyMEtjYUFRUEZydVZWc1lEM2kzWndJd0hjUHVk?=
 =?utf-8?B?OXRpQ3ErZlZUZ3ZNcmN6R0paQkF4YXc2WmlrSkZpWjc0TEl3U2xHUXIvSStE?=
 =?utf-8?B?RW1ldkY5MFVwMVV6SS9KSnluL0tUOXFka3lCZHZnY0xvS1RZVmFBMkJabnNz?=
 =?utf-8?B?SmVPTVNtWDA2NlNIQitUTmp5Z3MvcEtkdUwvVzFsU0paWkVxaTNEUkszVnBU?=
 =?utf-8?B?L1JUeW1Rajc0NzhHaEw5WG1QSXJKaEV0V2hIOUNoY1Z1cUpiQmlkWE9yTVhO?=
 =?utf-8?B?VUpMd1lkVGV2WWtpVmZLdktybDVRZFZlTnZzNUtidmlybzhDZmFuNUl3cG93?=
 =?utf-8?B?ZUkvUjBSTy8rWTVTSzdKdzhyMmo4b0Y4RnVwU1BCMVAwSkdGL0QyR0ppdFRa?=
 =?utf-8?B?ZUxVVnA2Ri93cnRyRTcrbDNqK3prN3VmVHd2a1pnS3ZSd2VWS0EvV2xENUtQ?=
 =?utf-8?B?djVhWXpLeDFWU0JYUEVvRjhuQTR2bm5SVDJwRzlBbzR1ZmJkT1YzVUYvcThn?=
 =?utf-8?B?Vml4R0xRdVlxdHFIUE54eVlwM1NEbzlCa0ZmalN0dS9jMjlRTElaVDE4enBu?=
 =?utf-8?B?Q1FNc1padkNVNm1ONkNjZTFVY0ViQ3dvVm5KVEZ4MHd0Wi9DVG9VMDdEOXhx?=
 =?utf-8?B?OE9PMjBFOUx4aGdCdDUzTzFkU2xDWmR0TjJLZG94R0FnMjBIc1RCNVpWRlp0?=
 =?utf-8?B?WGdlakVpZHhZamt0UGFhMTNaSlpFOUhmVGV5blByVVR6ZjBVcE15cFhXbmI0?=
 =?utf-8?B?anowWWRPS0gwR2JDd0FtWE9vTTA2dlVrWXU0ay93cGNQSjdJeUJvUktyM0dD?=
 =?utf-8?B?NmpoRWZReGZGUUcwcDd1bzllbm1XaWZNVTV2ajZ5cVNhK090aTN2THJuR0hQ?=
 =?utf-8?B?VGxjKzVNajduZTlnSUV3MVJjbXNOM0ZtWXhSaHFMOHZTeXJnTUFoY2p3dUdQ?=
 =?utf-8?B?a1JoVjFxYms3bCtKRGVreG1hcW1kSUFTaml3L3M3L3gvZGVKOTZJdDVwWDdB?=
 =?utf-8?B?RHBJRG04UllsNTBmQnc2LzJuSzZlTjlsc3ZESEJGRWpkUXg3a0pmU0lURWd1?=
 =?utf-8?B?a0RXOXMrbGMvZU9yMGNKZHAzMVFGZm5DSEx2N3hxR1Z4dDF6RjJocG4vbjEy?=
 =?utf-8?B?UmNrZGowUFp2WGwxV0VSMitRSUljWGI0ZUNVN05UYXkrKzB5b29PY1BVZzVp?=
 =?utf-8?B?OTVqbXR3cUNjbWpWWkw4bnA3WDRIVmh0RThVbHlIMCtvMDZGZG9YVU1EeVhK?=
 =?utf-8?B?ZHVRTnc5QWwwa284ckVua0o5QWtweERKNzRSd3FUWGJ2bkxtVHRYMnBKTWV3?=
 =?utf-8?B?aFo3YjQ3VlpiYjBKR3ZNTnFEU21PVHpBL3h5OXhVTUtDOW5uL3pTSlZQczZk?=
 =?utf-8?B?d2RkQWNaZkd0NTZtcUhrMHlpQXdUQXVpRzJId21BbnNhUjJZTm5ZYldFTGt6?=
 =?utf-8?B?WlREY3BIMHZTakdpSExKVTVDbGN4VjVxdE94VVZxb0JLRDg2U0lzbWFqd29r?=
 =?utf-8?B?ZXpjeEtzVURsMHVBTTVBMFRkL012TG5FZ2Z5a0RXSnNyWmlPSFNQazlCZWRL?=
 =?utf-8?Q?njWw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8138.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cecdecf-0677-4cf8-159f-08de32843bbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2025 15:54:25.1900 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yTgZffyc87AT8wf43Nfd+yhDtLvzzTExzuCukh04hc3OQqbWUgsDt/BGwuDpXje1Fu025mmumyIzc5nQqDicPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7962
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
Cg0KR3JlZXRpbmdzIFBoaWxpcCwNCg0KVGhhbmtzLiBBIGZldyBub24tZXNzZW50aWFsIGNvbW1l
bnQgaW5saW5lLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFlhbmcs
IFBoaWxpcCA8UGhpbGlwLllhbmdAYW1kLmNvbT4NCj4gU2VudDogVHVlc2RheSwgRGVjZW1iZXIg
MiwgMjAyNSAyOjIzIFBNDQo+IFRvOiBNYXJ0aW4sIEFuZHJldyA8QW5kcmV3Lk1hcnRpbkBhbWQu
Y29tPjsgYW1kLQ0KPiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjNdIGRybS9hbWRrZmQ6IEZPUldBUkQgTlVMTA0KPg0KPg0KPg0KPiBPbiAyMDI1LTEx
LTE4IDE1OjM0LCBBbmRyZXcgTWFydGluIHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggZml4ZXMgaXNz
dWVzIHdoZW4gdGhlIGNvZGUgbW92ZXMgZm9yd2FyZCB3aXRoIGEgcG90ZW50aWFsDQo+ID4gTlVM
TCBwb2ludGVyLCB3aXRob3V0IGNoZWNraW5nLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5k
cmV3IE1hcnRpbiA8YW5kcmV3Lm1hcnRpbkBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9mZW5jZS5jIHwgMiArLQ0KPiA+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NyYXQuYyAgICAgICAgICAgIHwgMiArKw0K
PiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RlYnVnLmMgICAgICAgICAgIHwg
NyArKysrKystDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5j
ICAgICAgICAgfCAzIC0tLQ0KPiA+ICAgNCBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyks
IDUgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9mZW5jZS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfYW1ka2ZkX2ZlbmNlLmMNCj4gPiBpbmRleCAxZWY3NThhYzUwNzYuLjcz
YzU3NDlkNDI0MyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfYW1ka2ZkX2ZlbmNlLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfYW1ka2ZkX2ZlbmNlLmMNCj4gPiBAQCAtMTA1LDcgKzEwNSw3IEBAIHN0YXRpYyBj
b25zdCBjaGFyDQo+ICphbWRrZmRfZmVuY2VfZ2V0X3RpbWVsaW5lX25hbWUoc3RydWN0IGRtYV9m
ZW5jZSAqZikNCj4gPiAgIHsNCj4gPiAgICAgc3RydWN0IGFtZGdwdV9hbWRrZmRfZmVuY2UgKmZl
bmNlID0gdG9fYW1kZ3B1X2FtZGtmZF9mZW5jZShmKTsNCj4gPg0KPiA+IC0gICByZXR1cm4gZmVu
Y2UtPnRpbWVsaW5lX25hbWU7DQo+ID4gKyAgIHJldHVybiBmZW5jZSA/IGZlbmNlLT50aW1lbGlu
ZV9uYW1lIDogTlVMTDsNCj4gPiAgIH0NCj4gPg0KPiA+ICAgLyoqDQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMNCj4gPiBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMNCj4gPiBpbmRleCA0YTcxODBiNDZiNzEuLmMwODZh
OWVkOGM4OSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
Y3JhdC5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NyYXQuYw0K
PiA+IEBAIC0yMzU3LDYgKzIzNTcsOCBAQCBzdGF0aWMgaW50IGtmZF9jcmVhdGVfdmNyYXRfaW1h
Z2VfZ3B1KHZvaWQNCj4gKnBjcmF0X2ltYWdlLA0KPiA+ICAgICBpZiAoa2Rldi0+a2ZkLT5oaXZl
X2lkKSB7DQo+ID4gICAgICAgICAgICAgZm9yIChuaWQgPSAwOyBuaWQgPCBwcm94aW1pdHlfZG9t
YWluOyArK25pZCkgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgcGVlcl9kZXYgPQ0KPiBrZmRf
dG9wb2xvZ3lfZGV2aWNlX2J5X3Byb3hpbWl0eV9kb21haW5fbm9fbG9jayhuaWQpOw0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgaWYgKCFwZWVyX2RldikNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgY29udGludWU7DQo+ID4gICAgICAgICAgICAgICAgICAgICBpZiAoIXBlZXJfZGV2
LT5ncHUpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiBpZiAo
IXBlZXJfZGV2IHx8ICFwZWVyX2Rldi0+Z3B1KQ0KPiAgICAgIGNvbnRpbnVlOw0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgaWYgKHBlZXJfZGV2LT5ncHUtPmtmZC0+aGl2ZV9pZCAhPSBrZGV2LT5r
ZmQtPmhpdmVfaWQpDQo+IGRpZmYgLS1naXQNCj4gPiBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9kZWJ1Zy5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGVi
dWcuYw0KPiA+IGluZGV4IGJhOTllMGYyNThhZS4uMTFhZjBjMWNkZGNkIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZWJ1Zy5jDQo+ID4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RlYnVnLmMNCj4gPiBAQCAtNTE3LDcgKzUxNywx
MCBAQCBpbnQga2ZkX2RiZ190cmFwX3NldF9mbGFncyhzdHJ1Y3Qga2ZkX3Byb2Nlc3MNCj4gPiAq
dGFyZ2V0LCB1aW50MzJfdCAqZmxhZ3MpDQo+ID4NCj4gPiAgICAgZm9yIChpID0gMDsgaSA8IHRh
cmdldC0+bl9wZGRzOyBpKyspIHsNCj4gPiAgICAgICAgICAgICBzdHJ1Y3Qga2ZkX3RvcG9sb2d5
X2RldmljZSAqdG9wb19kZXYgPQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICBrZmRf
dG9wb2xvZ3lfZGV2aWNlX2J5X2lkKHRhcmdldC0+cGRkc1tpXS0NCj4gPmRldi0+aWQpOw0KPiA+
ICsgICAgICAgICAgICAgICAgICAga2ZkX3RvcG9sb2d5X2RldmljZV9ieV9pZCh0YXJnZXQtPnBk
ZHNbaV0tPmRldi0+aWQpOw0KPiA+ICsgICAgICAgICAgIGlmICghdG9wb19kZXYpDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+IG1vdmUgdGhpcyBhZnRl
ciB2YXJpYWJsZSBjYXBzIGRlZmluaXRpb24NCj4gPiAgICAgICAgICAgICB1aW50MzJfdCBjYXBz
ID0gdG9wb19kZXYtPm5vZGVfcHJvcHMuY2FwYWJpbGl0eTsNCj4gPg0KPiB1aW4zMl90IGNhcHM7
DQo+DQo+IGlmICghdG9wb19kZXYpDQo+ICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+DQo+IGNhcHMg
PSB0b3BvX2Rldi0+bm9kZV9wcm9wcy5jYXBhYmlsaXR5Ow0KDQpUaGFua3MgYWdhaW4sIEkgdGhv
dWdodCB0aGlzIGZsb3cgaXMgc2xpZ2h0bHkgY2xlYW5lciwgYWxyZWFkeSBpbiBQQVRDSCA0Lg0K
Li4uDQogICAgICAgICAgICAgICAgdWludDMyX3QgY2FwczsNCiAgICAgICAgICAgICAgICBzdHJ1
Y3Qga2ZkX3RvcG9sb2d5X2RldmljZSAqdG9wb19kZXYgPQ0KICAgICAgICAgICAgICAgICAgICAg
ICAga2ZkX3RvcG9sb2d5X2RldmljZV9ieV9pZCh0YXJnZXQtPnBkZHNbaV0tPmRldi0+aWQpOw0K
ICAgICAgICAgICAgICAgIGlmICghdG9wb19kZXYpDQogICAgICAgICAgICAgICAgICAgICAgICBy
ZXR1cm4gLUVJTlZBTDsNCiAgICAgICAgICAgICAgICBjYXBzID0gdG9wb19kZXYtPm5vZGVfcHJv
cHMuY2FwYWJpbGl0eTsNCi4uLg0KDQo+ID4gICAgICAgICAgICAgaWYgKCEoY2FwcyAmDQo+ID4g
SFNBX0NBUF9UUkFQX0RFQlVHX1BSRUNJU0VfTUVNT1JZX09QRVJBVElPTlNfU1VQUE9SVEVEKSAm
Jg0KPiBAQCAtMTA3MSw2ICsxMDc0LDggQEAgaW50IGtmZF9kYmdfdHJhcF9kZXZpY2Vfc25hcHNo
b3Qoc3RydWN0DQo+IGtmZF9wcm9jZXNzICp0YXJnZXQsDQo+ID4gICAgIGZvciAoaSA9IDA7IGkg
PCB0bXBfbnVtX2RldmljZXM7IGkrKykgew0KPiA+ICAgICAgICAgICAgIHN0cnVjdCBrZmRfcHJv
Y2Vzc19kZXZpY2UgKnBkZCA9IHRhcmdldC0+cGRkc1tpXTsNCj4gPiAgICAgICAgICAgICBzdHJ1
Y3Qga2ZkX3RvcG9sb2d5X2RldmljZSAqdG9wb19kZXYgPQ0KPiA+IGtmZF90b3BvbG9neV9kZXZp
Y2VfYnlfaWQocGRkLT5kZXYtPmlkKTsNCj4gYWRkIGVtcHR5IGxpbmUgYWZ0ZXIgdmFyaWFibGUu
DQo+ID4gKyAgICAgICAgICAgaWYgKCF0b3BvX2RldikNCj4gPiArICAgICAgICAgICAgICAgICAg
IHJldHVybiAtRUlOVkFMOw0KPiA+DQo+IGJyZWFrIG91dCBvZiB0aGUgbG9vcCB0byBtdXRleF91
bmxvY2sgdGhlbiByZXR1cm4NCg0KR3JhdGVmdWwgZm9yIHRoaXMgbGVzc29uLCBoYWQgeW91IG5v
dCBtZW50aW9uZWQgaXQsIEkgd291bGQgaGF2ZSBub3Qgbm90aWNlIHRoZSB1bmxvY2suDQo+DQo+
IGlmICghdG9wb19kZXYpIHsNCj4gICAgICByID0gLUVJTlZBTDsNCj4gICAgICBicmVhazsNCj4g
fQ0KPg0KPiBSZWdhcmRzLA0KPiBQaGlsaXANCj4gPiAgICAgICAgICAgICBkZXZpY2VfaW5mby5n
cHVfaWQgPSBwZGQtPmRldi0+aWQ7DQo+ID4gICAgICAgICAgICAgZGV2aWNlX2luZm8uZXhjZXB0
aW9uX3N0YXR1cyA9IHBkZC0+ZXhjZXB0aW9uX3N0YXR1czsgZGlmZiAtLWdpdA0KPiA+IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYw0KPiA+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYw0KPiA+IGluZGV4IGY1ZDE3M2YxY2EzYi4uODg4
YjFjMjRjMmE2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9wcm9jZXNzLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJv
Y2Vzcy5jDQo+ID4gQEAgLTE2ODUsOSArMTY4NSw2IEBAIGludCBrZmRfcHJvY2Vzc19kZXZpY2Vf
aW5pdF92bShzdHJ1Y3QNCj4ga2ZkX3Byb2Nlc3NfZGV2aWNlICpwZGQsDQo+ID4gICAgIHN0cnVj
dCBrZmRfbm9kZSAqZGV2Ow0KPiA+ICAgICBpbnQgcmV0Ow0KPiA+DQo+ID4gLSAgIGlmICghZHJt
X2ZpbGUpDQo+ID4gLSAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gLQ0KPiA+ICAgICBp
ZiAocGRkLT5kcm1fcHJpdikNCj4gPiAgICAgICAgICAgICByZXR1cm4gLUVCVVNZOw0KPiA+DQoN
Cg==
