Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77B7CCF9EB
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 01:59:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4996610E087;
	Thu, 26 Sep 2024 01:59:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g4FbCs3f";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 559E210E087
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 01:59:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VX3/R97mrcfsrHWBV1IIPXSLAnkr7Jp2j4RtgRIvcj9oXBlSapyPpYABecoEl6oIWBax6GXylRoYerTjbPUvqspKt3H1RJhsts/J9XeFD7thV/lw9fMZXpyFJNFYI/ml+B1g2AUtkTUlIi56NVSf0s9SurxRS7nsC1DkHb7SqR5osr8sg9L10sg9PFKFUX5xTu4iqjc6L2B6UuxFevhaGBw560oQL8/jzBZMFfKQmf33k3jDBNhXMBh9rEINUjd0/7spgh4GNlDCQACGKZMIHEFCL5F4U713vvAMbzSzHIdgbGzPQhz68kjKr95XDq2O5G40QZDyUCKPdKFiLUThFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Qsaa39nGOUL0357I8xZglu0nYd7MhWn1dgNOUhH++0=;
 b=aBP506LY2pYIzk25itEoFZIz7BGRBytaJ9NzuxKLMkYy+uDZETR+I9TBVlDUDnb5K551S9gps7tj9ImMOoTGWH/CYAK2XJUXrnbelgCqKifcGOAsUGIeVCv/oGPEli4HdB6E6ESloSIHY2hAYhsYMg4AFTBollsFZXjby8nZ6gOpEGkDVA0Vqz9lBVOY9HUHDMP6xnL1yMWbDDnNCYJVPt9aqlPwiweBs3jWuk1VTNhC174rkNJmisgYADnkbs8jPbNzJ0VaVk6g2uiGJUJZsynQ501DkexLRwnmR2tOLs5KmeRpOzmP0reRWr0Nl5ap3ML06sAFrOcwqUxqX1r+yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Qsaa39nGOUL0357I8xZglu0nYd7MhWn1dgNOUhH++0=;
 b=g4FbCs3f7hVt58DGk5XNG8TbymY1dFsEDfu7+/fwbvjy9L8XnkHF8iWH4bVTRla3o4W+EE5kNahdcGb7eAh43sNH1Q6LY0G3VsCt0jem7ymjKfPilvDnyaSg72P9e27IEdcSasSEHo+44kV3VW+fyKBdFrMTUTxq4EYM+zRrDRo=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SN7PR12MB6982.namprd12.prod.outlook.com (2603:10b6:806:262::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Thu, 26 Sep
 2024 01:59:32 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 01:59:31 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix vbios fetching for SR-IOV
Thread-Topic: [PATCH] drm/amdgpu: fix vbios fetching for SR-IOV
Thread-Index: AQHbD3efS5SHJ4zXaEmjnv2g/Mcy0LJpUEVQ
Date: Thu, 26 Sep 2024 01:59:31 +0000
Message-ID: <PH7PR12MB599712C45399908C364F94E2826A2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240925182011.1194698-1-alexander.deucher@amd.com>
In-Reply-To: <20240925182011.1194698-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=afdc1f82-688e-4e05-801e-5d3523a5c08a;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-26T01:58:37Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SN7PR12MB6982:EE_
x-ms-office365-filtering-correlation-id: 255d1288-77c0-4069-d338-08dcddcedcd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?gb2312?B?SE40VldvV3RObVpDMkxDeG1oZEtJbTdvQWpGelk3R2ZWNHU0YUU4UVdRRVNi?=
 =?gb2312?B?bk90TGswdys0ZWZ3Y1JpbkV3SVJEemdQNWgxU2JtR05xRXdtMUpBeEFFdFcx?=
 =?gb2312?B?Z3FHQWZBRzdQem94dTVLNE96SklpWnFzT0NlNUtTdndJY2EyNkRET2ZOQXRG?=
 =?gb2312?B?NTFlWmJEbWFRdWk3OEo4T2g0cUJpS0hGZ3RWZHFlTFUwRlhVMWgrN25maTFS?=
 =?gb2312?B?RXN4OUdOMVNnMWhITmloR1VnWEhNdkVzKzEwc3dzM2lQMzNwTXpPZS9NUUNM?=
 =?gb2312?B?UmU2blh5S0pVZ0R6aWxIeFoxRnN6RjNZUkN4WVYzZXFUMm5CMGxRUlJBbXZ0?=
 =?gb2312?B?WTRkaVUyazVSNjh4TVd6OTNoSHpUK0N3MkdJbTRnQUhOR0pzdVM4UDhmbDNR?=
 =?gb2312?B?YlJZWUw1SWMxNUEyaUUzTXhEcWE2SWl4UU5Eb01jZU1jMFpJSU9yQ3Y2Ykp3?=
 =?gb2312?B?ZmRpcTZzWmxEWU9TMm00OGREdCt6U2JMNThLWlFUM1ZodWhWcUkxOU9IYStu?=
 =?gb2312?B?NkhCVXNWNVdka3dLR1ljOStZaCtZaUNMUU84NzA5WU1DcU8zYmdrYWdQUTY1?=
 =?gb2312?B?aTdndUx4WEozRm90cCt1TlR0YkczNklhV29YN1NOdFVMYlpFUFZPOW1CWnZj?=
 =?gb2312?B?RFdDd21wWmJubjZTQ3pkdndwek5Gblk1VWhTdmVYemJHVUxpTE0vSy92VmRL?=
 =?gb2312?B?TE43UTdEdzFRTUQ2QTVIbVVuUVRkSHY4WmZnT1kvZGRxekl1eTlaS3VKVnAw?=
 =?gb2312?B?MW1PUWNwU3doZTc1OFA5Z0pCWTUzdXYxR1k0SzN4eFNEdTZyeExpTnlNZTlM?=
 =?gb2312?B?VVB2TXVpbzd0eGgrcnNUWlpoQVZVK2NWMEE1U2tpTzlSbCtRYW9pQVhTdWJS?=
 =?gb2312?B?N0xuZU90NW5STlVwY0FGa1E2WHp3Uy9pNEZJdFB6V0xFeERLKzVyemlJM2NS?=
 =?gb2312?B?UDhDdjNWQUxvQkhZenVXeU5zLzY4eCtOU3gzdHROV1VLSlBZUitmWnI5NjNW?=
 =?gb2312?B?R0ZxRUlQc3E1Z0RiY1E1S3RvVHJNdVZ2UGxXc1FMbGQrbUhSMGJJdVp0ZDJx?=
 =?gb2312?B?OHMwS21NamNWQndxVWhvSnR4OFI2UTg5R2cvcU5UQkY3cmI3OHBtZGJyN002?=
 =?gb2312?B?eWE4c3c0L05pWk01MUtkZGhRYklhRDFBemhPVklZbHV3RHRDblhoU3g2NUJW?=
 =?gb2312?B?WFJ2QmdwN2o1UG0zQmlpWnBTWS9WVWs4WWZaUEVpSDdxMDVZOGxLd3JNamUw?=
 =?gb2312?B?aFRoTWN1cCtxcEhXZUJTWkF5ajJReE1RaENkVDJuUENUdnU0dW1Ed1hBemFq?=
 =?gb2312?B?Uk9hMmgvVE9QN1ZKa2FPZXI3c2RKd2s0dGdVU1Fxai9VNXB5N3hSdmozMHlM?=
 =?gb2312?B?UE00R1lsR0h3WDhnVnFXTkhiTFBoZDUzeHNTVUlHOENFV0QvSm14ay91THlO?=
 =?gb2312?B?S2dXcWEwSEVzNFJHeGIvS0cybm5sS2poUDVGWmkzRDlSclczeXlSQ0p2Rmlj?=
 =?gb2312?B?c09NQ1RZVC8vd0ZrakdmNGxXUmp1UVhxdk00Y2I1OGt0UlBzU3pTcW8xWWVC?=
 =?gb2312?B?UWdORXVWZlhCZkI0dGJwd0ZwNU1sWlVmUDc4cDZSL3BEaDJYQnZqbVFDQVdB?=
 =?gb2312?B?L3d3c3owQ2NTSVNxNWJtUFB2MkZNVUVONDhJRGZTYng2QUxRRzVwZzVYeHI0?=
 =?gb2312?B?bDd6LzlidWFkcGtkcG5qRUpMcWJNZVdDSFczTGlPNTQzUDBhdDU3Mjk5Wks0?=
 =?gb2312?B?RTZEQmxNVlR0U1pwUU1pcUhBMW1aU3ZaY0dZdm00SHJ0bmpnL0FxcjNLKyty?=
 =?gb2312?B?T2wwSFI0LzNQcE9yeGJPa3BkcGUwWGFuSkNKWm9URTdxOWV3NlFMMVlLZjJ2?=
 =?gb2312?B?YmI1eWFsZy95aGd6cURUL3NlV2xCY3JhQ2V6b2dlTXkrSGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MVJ3Wng5eFpYY25VdURySHRqa09jQnJHdkFicitGaU9aaGxRS2daS0dGOGpM?=
 =?gb2312?B?RWtZT0M2NlNpTTNLOFdjL1ltNE44R0l5WFpsc1RoU29iSkRlMXkyVU5nV1Q2?=
 =?gb2312?B?OVVDdy9KaU9US3RNTyt2RXhCN2o3dkMrdUNpbi9JWCtZOFRKZkQ0NFlqeGJr?=
 =?gb2312?B?eVEzanZmZ09JZnNpNU1sRGsvME9pMWxoWXNjd1dxTXRrZVhaa3hkbGw3emJ1?=
 =?gb2312?B?YktuQVBMUGdrWWFUNlliS1FQWTFrOGIxWGdtc3lHbUx4by81YkhHaUdmdTdl?=
 =?gb2312?B?dFBYV1ZBQmdCelV4TG1vVURYRnhGVFhRaURsbHdZSS85SVpqUm5mUEVZbUlX?=
 =?gb2312?B?WExsZFBHOUNFMGlHVjQyMWZLYUJ3cWpsa2k2b0R3WmtoMVV0ZlpPd3k4ZmF3?=
 =?gb2312?B?OHlEOUVBZ2hUdVViVUxaeDhZdTN5NDNoRmNxNERHV3pLd1FNQ1pwdmRJRW9Z?=
 =?gb2312?B?VFJ0dkc5YzdFQzFkaUcwWUFIOXh3ZTFtVzhtdTNiYU4xOHNuZDNGQk5mVGpN?=
 =?gb2312?B?dWJ2NWFoWXFsbG1waUlVK1hUYUxSeEsvQ2YrNVJmQ1BRMCthRC9vVTd4Ri9Z?=
 =?gb2312?B?UUoveFgzSkRPd1M0MTVWMmdiL3IwQnNtQ3BOaTJOeXJUWFI5WnNDbjVWTGx2?=
 =?gb2312?B?SlJhaWE0VlJBNlo1S1RLWjdmZmVkQkp1UUk5akxiYSs0NEt2VnRaZzNYRVlv?=
 =?gb2312?B?RUR6L1lmS2ZDWW5iVzVIWUZmQUVyMWV3M3VKMTVkT21wK3psbitrRUh0VkU5?=
 =?gb2312?B?ZW4xMU82VThiNy9nMDJIR2tLSGVNQ25IVEtIankvbTF6eW9KRUtDRDhKSXFm?=
 =?gb2312?B?Q3lDYzVRREIyMkRVZzlnS1hCeTNKRmRmcnBMOElRTXJxWkZxS0Y4VERiZy9h?=
 =?gb2312?B?b1AzWDNnYlRtNno3R0dEKzNOcm9wcjQ0aWVzbEhLS0I1U3BZN2JZU2RTbFlX?=
 =?gb2312?B?cnFuZUtnZVRQMjJXZ2J0NTFoTWtsRzM4M0lBMlIydUs1ZkxZanJLOHNyWVU1?=
 =?gb2312?B?VVdTMHIwRXVLWDFsTC9zMElqWExpYktJSlFySU9OdXVxVVBqVGFFT20yR0VB?=
 =?gb2312?B?L093R2cyTS9mY21EdmpNY3c4cm0zejhyTTJzM0NVRkpwOStSRmdiblpWMjNG?=
 =?gb2312?B?QkllMjJsWitsRHQ1WmlGcFV3QkxBUTlmYlZlVUh5UzhJSjNWV3czL09HazFL?=
 =?gb2312?B?TDFtVVV5WDF0eXI1WGM0WXhqbkZnM3VwYW1qWjJXVHNoa3dDd0dtakd5dXB4?=
 =?gb2312?B?VUxLSlAyQjU2OGVROTh2R0lJTzFLemJteFZJMjV0b3Z5OGxCOUxoeHRKWHUy?=
 =?gb2312?B?K2JENEcvTnFYM3drQkVMY0FGTzloaWhYRk5MOWNBa0hrMDg2Q1JVdVhpRDkz?=
 =?gb2312?B?eS8zZHJsTUpmdStlMENlOVhzQkd3NEZHNHpyQnJTVkN1U2dQUlUvYXBHSnJK?=
 =?gb2312?B?Q3hoeHFPZE5TY3VTRGZWSTgwNDFrNndtRzNxZHFqOXFZcFRxNTh3VWhFVGZs?=
 =?gb2312?B?dVM1c3oyTks4S1V6SDBUUVkycWRYdmZmYy84cXVXS1JqZWg3OE0vanZvcnlM?=
 =?gb2312?B?Yk1keGVaVFozcGxNOUltY1R5WUxrSmlhQlNRcUlUbVJMa0NlNHh3ZS9BMDNs?=
 =?gb2312?B?aWoxWmw3QWE3TlFwTFlaQjFwRUZ0eFdJTXBENGhuV2ZWV0tJanRKbjJaZzJa?=
 =?gb2312?B?TTkxUEYyWDhtM1BWeUJNVFN6UE9GTUpPNUd1NWdpS09EczhCYzIrU05zMTZK?=
 =?gb2312?B?UmFkcUZMd04wVHQvUHdMZWNYMUw0a0hRK0xhZ0lPUWtkMjFMc1dwRHNZNTQx?=
 =?gb2312?B?M0dqdFdpQzBvcEdEYStXSitibkQrYkd5eWtFZm53VnBHbU8xZnRzdVIvUnZJ?=
 =?gb2312?B?bkprd1labUhrTjV0YWZ6RGpUWXlScUw3WnV1VnhVdGJ6c1JOMTRrMmhVT2JM?=
 =?gb2312?B?cmF6cER2bmlBdXpiWjFnc3JnYU91N1IwcUdnZWlqanI1WkxBeExZRGZSamlV?=
 =?gb2312?B?RVV2ekxVSUFDZ2pJaDJpSS95SGIwVERTeVZ4Sy81eUJ1NVIzZGVhUWRLbjJj?=
 =?gb2312?B?c2ZtUjZpWFRxeWRYa050ZUdjWGtzdUtiV0xrR2RVdDgxYVNic09ZUkRkMnk5?=
 =?gb2312?Q?9tMI=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 255d1288-77c0-4069-d338-08dcddcedcd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 01:59:31.7065 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xad80ONc3vKFtu/3eJO2/qe5S/lSmqh9Xlqdj4ers51lTfuUyAcC26do8oJbMGZF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6982
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
Cg0KUmV2aWV3ZWQtYnk6IFlhbmcgV2FuZyA8a2V2aW55YW5nLndhbmdAYW1kLmNvbT4NClRlc3Rl
ZC1ieTogWWFuZyBXYW5nIDxrZXZpbnlhbmcud2FuZ0BhbWQuY29tPg0KDQpCZXN0IFJlZ2FyZHMs
DQpLZXZpbg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1kLWdmeCA8YW1k
LWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEFsZXggRGV1
Y2hlcg0KU2VudDogMjAyNMTqOdTCMjbI1SAyOjIwDQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNCkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+DQpTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IGZpeCB2YmlvcyBmZXRjaGluZyBmb3Ig
U1ItSU9WDQoNClNSLUlPViBmZXRjaGVzIHRoZSB2YmlvcyBmcm9tIFZSQU0gaW4gc29tZSBjYXNl
cy4NClJlLWVuYWJsZSB0aGUgVlJBTSBwYXRoIGZvciBkR1BVcyBhbmQgcmVuYW1lIHRoZSBmdW5j
dGlvbiB0byBtYWtlIGl0IGNsZWFyIHRoYXQgaXQgaXMgbm90IElHUCBzcGVjaWZpYy4NCg0KRml4
ZXM6IDA0MjY1OGQxN2E1NCAoImRybS9hbWRncHU6IGNsZWFuIHVwIHZiaW9zIGZldGNoaW5nIGNv
ZGUiKQ0KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQu
Y29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Jpb3MuYyB8IDEx
ICsrKysrKysrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9i
aW9zLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYmlvcy5jDQppbmRleCA0
NmJmNjIzOTE5ZDdjLi40NWFmZmMwMjU0OGMxIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2Jpb3MuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2Jpb3MuYw0KQEAgLTg3LDggKzg3LDkgQEAgc3RhdGljIGJvb2wgY2hlY2tfYXRv
bV9iaW9zKHVpbnQ4X3QgKmJpb3MsIHNpemVfdCBzaXplKQ0KICAqIHBhcnQgb2YgdGhlIHN5c3Rl
bSBiaW9zLiAgT24gYm9vdCwgdGhlIHN5c3RlbSBiaW9zIHB1dHMgYQ0KICAqIGNvcHkgb2YgdGhl
IGlncCByb20gYXQgdGhlIHN0YXJ0IG9mIHZyYW0gaWYgYSBkaXNjcmV0ZSBjYXJkIGlzDQogICog
cHJlc2VudC4NCisgKiBGb3IgU1ItSU9WLCB0aGUgdmJpb3MgaW1hZ2UgaXMgYWxzbyBwdXQgaW4g
VlJBTSBpbiB0aGUgVkYuDQogICovDQotc3RhdGljIGJvb2wgaWdwX3JlYWRfYmlvc19mcm9tX3Zy
YW0oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQorc3RhdGljIGJvb2wgYW1kZ3B1X3JlYWRf
Ymlvc19mcm9tX3ZyYW0oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQogew0KICAgICAgICB1
aW50OF90IF9faW9tZW0gKmJpb3M7DQogICAgICAgIHJlc291cmNlX3NpemVfdCB2cmFtX2Jhc2U7
DQpAQCAtNDE0LDcgKzQxNSw3IEBAIHN0YXRpYyBib29sIGFtZGdwdV9nZXRfYmlvc19hcHUoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQogICAgICAgICAgICAgICAgZ290byBzdWNjZXNzOw0K
ICAgICAgICB9DQoNCi0gICAgICAgaWYgKGlncF9yZWFkX2Jpb3NfZnJvbV92cmFtKGFkZXYpKSB7
DQorICAgICAgIGlmIChhbWRncHVfcmVhZF9iaW9zX2Zyb21fdnJhbShhZGV2KSkgew0KICAgICAg
ICAgICAgICAgIGRldl9pbmZvKGFkZXYtPmRldiwgIkZldGNoZWQgVkJJT1MgZnJvbSBWUkFNIEJB
UlxuIik7DQogICAgICAgICAgICAgICAgZ290byBzdWNjZXNzOw0KICAgICAgICB9DQpAQCAtNDQ4
LDYgKzQ0OSwxMiBAQCBzdGF0aWMgYm9vbCBhbWRncHVfZ2V0X2Jpb3NfZGdwdShzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldikNCiAgICAgICAgICAgICAgICBnb3RvIHN1Y2Nlc3M7DQogICAgICAg
IH0NCg0KKyAgICAgICAvKiB0aGlzIGlzIHJlcXVpcmVkIGZvciBTUi1JT1YgKi8NCisgICAgICAg
aWYgKGFtZGdwdV9yZWFkX2Jpb3NfZnJvbV92cmFtKGFkZXYpKSB7DQorICAgICAgICAgICAgICAg
ZGV2X2luZm8oYWRldi0+ZGV2LCAiRmV0Y2hlZCBWQklPUyBmcm9tIFZSQU0gQkFSXG4iKTsNCisg
ICAgICAgICAgICAgICBnb3RvIHN1Y2Nlc3M7DQorICAgICAgIH0NCisNCiAgICAgICAgaWYgKGFt
ZGdwdV9yZWFkX3BsYXRmb3JtX2Jpb3MoYWRldikpIHsNCiAgICAgICAgICAgICAgICBkZXZfaW5m
byhhZGV2LT5kZXYsICJGZXRjaGVkIFZCSU9TIGZyb20gcGxhdGZvcm1cbiIpOw0KICAgICAgICAg
ICAgICAgIGdvdG8gc3VjY2VzczsNCi0tDQoyLjQ2LjENCg0K
