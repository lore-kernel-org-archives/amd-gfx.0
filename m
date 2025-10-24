Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5693ECCD1A5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 11:49:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2E6E10EA80;
	Fri, 24 Oct 2025 11:49:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hueiPsvW";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010045.outbound.protection.outlook.com
 [40.93.198.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2225910EA80
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 11:49:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7Rbgf8Jp3JVuXNGRHr17s8Zt6P2Iz74CKSJLajL0zIjXggLcmmrINTcEHa8JKkDNIH9fuS+KwIB4YWreVu98yOqh92scqMsfLaKWAwbgsecGsVlogY4fKkJ0R3CDkYX2fnV1U69fg+qWxkOUUXOtamjE+wAajvf2QjapuWUmICdxDwjI2JBw4LQJpxgALbMTBO8dkWYDSja95yTfvT5DjUuBtyzfX1yChhBLz1d4vJAXvgcJK/XYW8KXQnHx+alylv5/AYLTTn4i+fFkPn2pVg4vSOVSBpNKpG+wk4JW1va8UpXOs0yle8L25R0CX52X1AH+qNes5NRMPh20UNRhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2A0iM1XsSW+bMYoUnx+kHZAzMTn5e6X2AndFqA9bTs=;
 b=p95glC4QcKeLfl36vasbhXmU9PISY/Zzfc9Eg0j5UpQ/yoA66c+f4PiNqGUEWMVjTMZnkU/tUPI7f5uFe8hxjICCaN9bl7NR4ffQX4q/75S2QQYTGH5i6Bu6LPdnI9xKzGwYUhPq3v5eEH2ObZ1+ko8hz+OePme3jzItir5U6NA2KrXdaH009D5FbN4c8spt9Hh3JXuiK1mGnEAbj3Q4rZjduMcISOOaHZa2FGiHNdhmuJTUtWxXnb/n/aQZmtl03dUHlPEjDae75s51zDYCcXbHNVhFSt3QHP+KEWXYYo9tjr6rrUFhpw0d6ZZW9AUMuhA2BhFSoC2fqMkMpLMR1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2A0iM1XsSW+bMYoUnx+kHZAzMTn5e6X2AndFqA9bTs=;
 b=hueiPsvW/nb6YkZI/MgKNj1MyD1aYLL8mYFiQ+zZxjFNAWOEm4pRiw8HWehvPDwkjnU8X/SVZU9uYYsoPQqiD3UIIOi3o6XNw1LurRUQirb5Xc78jDgFh6oFPNaYs3f5QmAVG10th6DYvHKOUm98thdxYe141Dgm4yk0p6VE0F0=
Received: from BL4PR12MB9508.namprd12.prod.outlook.com (2603:10b6:208:58e::22)
 by MN6PR12MB8592.namprd12.prod.outlook.com (2603:10b6:208:478::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 11:49:37 +0000
Received: from BL4PR12MB9508.namprd12.prod.outlook.com
 ([fe80::3b90:fc65:a190:d288]) by BL4PR12MB9508.namprd12.prod.outlook.com
 ([fe80::3b90:fc65:a190:d288%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 11:49:37 +0000
From: "S, Shirish" <Shirish.S@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Paneer Selvam, Arunpravin"
 <Arunpravin.PaneerSelvam@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [Patch v2] drm/amdkfd: add missing return value check for range
Thread-Topic: [Patch v2] drm/amdkfd: add missing return value check for range
Thread-Index: AQHcRNumSseEcthTckKAM0oFb3o/ibTRLhHQ
Date: Fri, 24 Oct 2025 11:49:37 +0000
Message-ID: <BL4PR12MB9508E5B67AE0B49CAE886CE4F2F1A@BL4PR12MB9508.namprd12.prod.outlook.com>
References: <20251024111602.2128436-1-sunil.khatri@amd.com>
 <9e35463a-777e-4b6b-ad31-47cd7f07fe30@amd.com>
In-Reply-To: <9e35463a-777e-4b6b-ad31-47cd7f07fe30@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-24T11:46:53.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR12MB9508:EE_|MN6PR12MB8592:EE_
x-ms-office365-filtering-correlation-id: 26f46ee3-d155-4cc7-00aa-08de12f3688a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|921020|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?ZEx1OEFENnBPcm13Qjk5WlI3MUpOclFiWjNGYXJSWVFRZjZjeUIyQjZRTlZQ?=
 =?utf-8?B?Rm9GaUdGVUdSYlcxeDd6aTVRQWc2aVNCb29RV0RaYzhYNnUxdWNpWGQvTE0z?=
 =?utf-8?B?WGxpZFJpSjF0UG9ZQTEyMTVqM0Z4V09wRFlwOFU4N2ZiZEtyK2ZhRnhKVkQv?=
 =?utf-8?B?SW0yK1ExY0lGTHJ4ZFNvZGo0TzkrYUdKNG9rNTY0U0xLNTNEd3Rvb1Z1VlZo?=
 =?utf-8?B?bTFsRnJySWdCeFZwL2REanFBTlNqbjIvMTZLb2diZzFueDlWUWY4QUlpUGcr?=
 =?utf-8?B?TEtrbEZrVDhINmo4emJUa3g3ZS9BSVJhZUxCYTdid1NMTWhheVl4aHQ0SjE4?=
 =?utf-8?B?TDhuTjdWbEEweWorNzVyeUR1d0YwT054L2h5QTZFVGJSQ3krUGJkbG1zK2xj?=
 =?utf-8?B?VDA5V3E5dmRJR1crckFPdW0yeDdYWnhQZHhBWU96NjUzSFNLMjZFRG5uU0Vl?=
 =?utf-8?B?bEYwY0MzcFkvT3h4VjMwMysxZ3MyY3ZWdks3dnBpVDkwd2JzMWtIVC9rc2pI?=
 =?utf-8?B?bTY2dFBvdE9GTS93Y0U1TjN5citzbUNOeE9VVklkTFFLQWh0OGF5aUVvdE44?=
 =?utf-8?B?ZjlYb3c1RjQ4NFBZa3QyU0h4TW84YlZDUUJaYS9INUo2dUhtdHg5c2hQSU5P?=
 =?utf-8?B?WnJ5U3Znd3h3Umx6bFlMclB0ck1iNDAweFdhTkZjRUFPbUlGWXhyQWNJM2dU?=
 =?utf-8?B?dkJpbzI4Z2JoTGhSaUdkaTJHcVdkZjVUT25PUi9JVWpMemZUZlFVZTM5NjZR?=
 =?utf-8?B?dmxkUWtCVm1makVUaXhmNnlkdDQrMW1VMFNWMzVXZXhvSVlyYXZJUHZkYXQv?=
 =?utf-8?B?djVES3ZmS2RJTkNPN3Z4NzFGbXRDc215QXcyb1Ficy9SRk9WbG5tNGMvdnUr?=
 =?utf-8?B?Tmw3c2dQVVdrMTJDRXdmcFpCREVkVzMrS05WOU5RenV5NldiNEJzdU1WUWFy?=
 =?utf-8?B?MXBZUmE2RXpKMzZNY0psM1VZR0tXdW1MQUNWS2YwK1ZjWUNnU05PTWJVVEta?=
 =?utf-8?B?aXVDOUxGR1B3Y0lKRDBNOFZ5UnBJZXJ4OTZsQ0NNZkpWTDRBdmpnVzZ3aTNY?=
 =?utf-8?B?K1I0ZnFtNVQyYTlSeFZCTk9qMW5Pcnd5L0ttWFE0OHI2ektiNXIwcmFaaC9B?=
 =?utf-8?B?Uis4TTdUYXY5K0IyVzJNR3lpQ2ZKcDFQcUNMamcxUVAyRFFsVExvajNyMVJC?=
 =?utf-8?B?eXhURFU2eWRSMTA4ZUtwaHp0T25Cdlc3K2d5TGpMNWxwdzRDc2tYTTFMblNZ?=
 =?utf-8?B?U043RVVFbm05V2IrSXlqVFBXQ2UwVmFyVk9VWGtzajNHcHhFSXQyQ2IybzBB?=
 =?utf-8?B?TmwveTlYM1dXTnJsV1R4VnBBU1FZNU1qYmFodDBXLzMwd3Vpa24vVDVXaUdh?=
 =?utf-8?B?V0RYUE95Yk1mSGlBby9LR3pVdDgxSTExTkFjVzBONnUyWTh2R0RnTG1Hc01H?=
 =?utf-8?B?YTJpOFVDd2FpK1lRcnJKMkV6ZTZESXhYTG1CQ2JJeThJTTVpMk5UektlWFBl?=
 =?utf-8?B?Q0RRVTZrM2NwS3VSVjZJN0dkTHpXd1FPQmVXanJGMmFLdlZWY2dZeWVYck1Z?=
 =?utf-8?B?cnlZVFBDWFZrSVR5ZGZHcHB1ZU9EMW5sSVJyc243b2pIQXFrSDA2ais1eXIv?=
 =?utf-8?B?Q0tnUEMydTV5N2hHMU41d2hiM29KUUZjQVU3TEtveWFxVGRhb296djliVGpx?=
 =?utf-8?B?cFZpSmloYVh6LzZEZEp5REdaeFh1ZUJicDNQUzRNZ0hnc0xwOWY5U3NTWGdu?=
 =?utf-8?B?SmtSb1lkV0dkbjFxSGF2T0lPVkhjYW5xVGFjSWNCK2VTVzhqaEpKTDFZektQ?=
 =?utf-8?B?M3BJTU9jSFhkaEFpNkxFbnZnTFVnZVNSTVFvU2g2SzlZY3FRQnFJbGZlQUta?=
 =?utf-8?B?NVo3NjMwOTl1WDJKRk5HWmFsTldDZlVvK3BMRzY3L2QzR3B3c0dTbEVmVXcy?=
 =?utf-8?B?enlPK0lydVBGQ3lJYzJKRFNlazJkNGEvWFVOVCtjSmN1R3FySDByaGd3eFZ1?=
 =?utf-8?B?ZVZSSHdlbGE3Uy82QzVwZFlIY2l3Umcya2dsalVNS3V3Ni9BTTVPZ3AxRU54?=
 =?utf-8?B?RmgrTzJRMWNNWlVSUzcyYWE2U0VkTjRDU3FNUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL4PR12MB9508.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(921020)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkN1Tmo2QzhxVWFOZnZxSlBldk53b1Ivd0gwbzN5b0RJME1QQ2cvWmFDbUJP?=
 =?utf-8?B?blg0TUcxNWpTWjR3blRtc3dwNjBkL3E3anp3bDNjMEp1QjRVaEREVG1nK3lQ?=
 =?utf-8?B?SUdKU0ljWm5CMVN1VC9NRWhsQ1Mxd0NTODZlQ3phVU5oYWllMi9ieFJmZFcz?=
 =?utf-8?B?OHNtSCt3TllLWlVoeTd1L1JramFwN2N6YVBBMDhNQUN4b2RHL240bUNEeVlR?=
 =?utf-8?B?RWpjN0pCT1lXcVRvNElMZjNwamVSMEtRdmlrWUdrb3NJeDNBRkhLcVdnTzRK?=
 =?utf-8?B?cXNzOVdMQlV1VGVYNTZaSWdNTGVzMWhjNHRqeVF6cHpESFhadU9GYko4YzFx?=
 =?utf-8?B?dkhOUVk4MUt6cThaaCtIUFJDRE1qdjU5MlRaSnAyM05Zb1dTUnZhdmtVT2J1?=
 =?utf-8?B?STk5a3JVSkJIOHpST3YwV2VaOFgwR1VYOWcvU0c1eGI2RHBxR1k3SGc2S0M3?=
 =?utf-8?B?Z2Fac0FSQzhZbmxKSm9JY1M5MFdRRXdRUHlTcENUZzYrMlNONkRNdzV5UUJV?=
 =?utf-8?B?cG1vL2w1QWY2c3RIbktpdWlqRlZTaHkyYjZnWHA5RlFrSE9Kcm1uYWwyNjIr?=
 =?utf-8?B?Vis1My9KTzQ4Q2xTTTdXSXlmOFRFTnhldzJDWHJSMWQyTlVwcDhFaE10Sm81?=
 =?utf-8?B?bVBiMkNnY1BpYzFxc0hVcTRlbjFDeXhZeUxpMzNnaGN6YkUxbUFYYzczYzk2?=
 =?utf-8?B?VVlmWlhwTy8xYm84WnF2RGpIemZiWDRmRHRmekNNS0JzdStBUkVHQ2YyNVhV?=
 =?utf-8?B?UUZ5YVdpZTZZUEpwZnN5M3grbDlzWWY0dVZ0Qk9OQTlUMW5jV2M3bkJGMlpq?=
 =?utf-8?B?a2pEeTdBQk5YSVp6WWJsU3hVclR6RGlPa1FqUFBBTzd4UmxZL3RMcHJROW5C?=
 =?utf-8?B?YjFwM0ZLb1BlZ2dqOFVhZVAzU2tMcDBNMkpPNGVnSThEdllzZ0FsMFhsWkQ1?=
 =?utf-8?B?Vk55VklPVGJMMjJUSXdBN2t0OEl1QVpPZjRFY3FxekV2OFJ1dnRjUWZ3TW5R?=
 =?utf-8?B?bDdwa2hSbEhGdDBWbGEvVm5wbmVZN3FjUXhKM0ZQaE1rQmpHVUJlOGFyV1FX?=
 =?utf-8?B?Zm9iYXNpK0hZWGdpQ3VmNllGLzFjdjkweXUvR0pHV3RzSU1mc0VyaWxURHMw?=
 =?utf-8?B?SnQvbUpjT204UzI0MmV6QUZBVE1FVTBGczJPVWpaQThVTU9VNGhIY21zUk12?=
 =?utf-8?B?anV6NGdGUlgvRXo2MC91cFZoYTd5enVmalBuM1dsYzY0N1J3WXZMKzNPZnU5?=
 =?utf-8?B?YVM2dVJKQUdOcFJTWWM1TFRUTEVPeHFxS3EyQ0tFRmwyTjVYWFgxOEQ3ejl0?=
 =?utf-8?B?WnRTTzJ0UzdYVmpadjhzam03OWZpY2k1ODBhSjhsU2pzdlZIQ0ZXYk5WdDhD?=
 =?utf-8?B?aWlhYVdSMFlmZzJpSDFpTGdrTllHbzZuWnU1UklsT2oxWDRsUmx4Q2lZUzRO?=
 =?utf-8?B?cllnYnNEUmVCSSt0RWhtUUp0YlpCRkZGaFM3eGx4a3BwRU9Zd21sYkNCRWMw?=
 =?utf-8?B?NXFtdXkxdzkzbGFWU2Vma3hsT0xmdWFEdDkrb1A0dGpwaisvcnF6WTlWUi9K?=
 =?utf-8?B?Rk0yblpKSlFqR2JWUXIxaU5oMStWaEFWV21NZTZyMFVrWThPcHdIT1Brc0Nl?=
 =?utf-8?B?cDBZTnIveDhJS3c0TEh0OU9IbVVXTDNXT1E2T01FaWI0UjUrOHErMytvTFdI?=
 =?utf-8?B?T1JtV1VqUS9FelBCWWdtSTQ0UTV4TDRjMCtQaWh0TGl6UmdPelJ1YUNpWDJ1?=
 =?utf-8?B?Y3NwSFBWVVZMMnR6ZnFLTXNrQ0dWSStTL3JwN1FrUGlVdEJnaXMrcS9tcllD?=
 =?utf-8?B?MEFpWExRbEdUQzdoV0tSNVZaWnhnYUc0bmE2ZFNIcDIvZUZQekNhRWp0aWsz?=
 =?utf-8?B?V2xPeVh6MFJzaGs0ak4wVVphY3F1SUhtSVNqMlNBckYyOXZmaGJCY2xKQkhi?=
 =?utf-8?B?SC9GUjRQRUY4OGg2WDdIeCs2VXdKemxZNDR6eGxrakhNb21VY2d4ZG9ld2M2?=
 =?utf-8?B?WGxpV0VGdVVMMkNaM0VLVjVDZjA5VzFqd0M2R0h1VFBWMWZPaDg2Vm1UaHJw?=
 =?utf-8?B?cndBK0hPc2RRamdhcDVMTXZxMG1LYTRlckhxUXI5NmhPRWxMV0NJR2YrMld6?=
 =?utf-8?Q?gN3g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9508.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f46ee3-d155-4cc7-00aa-08de12f3688a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 11:49:37.3167 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iT+TOlBy2EV6bEmVL8G7sEMYFvSjBZDVyJdmWrhiq22SUwBv3T551Zm5FnShSU92auutxdIuGHX84xWorJLqZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8592
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
Cg0KUmV2aWV3ZWQtYnk6IFNoaXJpc2ggUyA8c2hpcmlzaC5zQGFtZC5jb20+DQoNClJlZ2FyZHMs
DQpTaGlyaXNoDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLaGF0cmksIFN1
bmlsIDxTdW5pbC5LaGF0cmlAYW1kLmNvbT4NClNlbnQ6IEZyaWRheSwgT2N0b2JlciAyNCwgMjAy
NSA1OjE1IFBNDQpUbzogS2hhdHJpLCBTdW5pbCA8U3VuaWwuS2hhdHJpQGFtZC5jb20+OyBLb2Vu
aWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgS3VlaGxpbmcsIEZlbGl4
IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIu
RGV1Y2hlckBhbWQuY29tPjsgUGFuZWVyIFNlbHZhbSwgQXJ1bnByYXZpbiA8QXJ1bnByYXZpbi5Q
YW5lZXJTZWx2YW1AYW1kLmNvbT47IFlhbmcsIFBoaWxpcCA8UGhpbGlwLllhbmdAYW1kLmNvbT47
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBTLCBTaGlyaXNoIDxTaGlyaXNoLlNAYW1k
LmNvbT4NClN1YmplY3Q6IFJlOiBbUGF0Y2ggdjJdIGRybS9hbWRrZmQ6IGFkZCBtaXNzaW5nIHJl
dHVybiB2YWx1ZSBjaGVjayBmb3IgcmFuZ2UNCg0KK3NoaXJpc2gNCg0KT24gMjQtMTAtMjAyNSAw
NDo0NiBwbSwgU3VuaWwgS2hhdHJpIHdyb3RlOg0KPiBhbWRncHVfaG1tX3JhbmdlX2FsbG9jIGNv
dWxkIGZhaWxzIGluIGNhc2Ugb2YgbG93IG1lbW9yeSBjb25kaXRpb24gYW5kDQo+IGhlbmNlIHdl
IHNob3VsZCBoYXZlIGEgY2hlY2sgZm9yIHRoZSByZXR1cm4gdmFsdWUuDQo+DQo+IFNpZ25lZC1v
ZmYtYnk6IFN1bmlsIEtoYXRyaSA8c3VuaWwua2hhdHJpQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uYyB8IDUgKysrKysNCj4gICAxIGZpbGUg
Y2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfc3ZtLmMNCj4gaW5kZXggZjA0MTY0MzMwOGNhLi43ZjBhYjczZTIzOTYgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uYw0KPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMNCj4gQEAgLTE3MzgsNiArMTczOCwxMSBAQCBz
dGF0aWMgaW50IHN2bV9yYW5nZV92YWxpZGF0ZV9hbmRfbWFwKHN0cnVjdA0KPiBtbV9zdHJ1Y3Qg
Km1tLA0KPg0KPiAgICAgICAgICAgICAgICAgICAgICAgV1JJVEVfT05DRShwLT5zdm1zLmZhdWx0
aW5nX3Rhc2ssIGN1cnJlbnQpOw0KPiAgICAgICAgICAgICAgICAgICAgICAgcmFuZ2UgPSBhbWRn
cHVfaG1tX3JhbmdlX2FsbG9jKE5VTEwpOw0KPiArICAgICAgICAgICAgICAgICAgICAgaWYgKHVu
bGlrZWx5KCFyYW5nZSkpIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgciA9IC1F
Tk9NRU07DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZnJlZV9jdHg7DQo+
ICsgICAgICAgICAgICAgICAgICAgICB9DQo+ICsNCj4gICAgICAgICAgICAgICAgICAgICAgIHIg
PSBhbWRncHVfaG1tX3JhbmdlX2dldF9wYWdlcygmcHJhbmdlLT5ub3RpZmllciwgYWRkciwgbnBh
Z2VzLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHJlYWRvbmx5LCBvd25lciwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICByYW5nZSk7DQo=
