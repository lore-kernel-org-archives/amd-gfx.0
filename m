Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980E3C52D7C
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Aug 2024 13:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4262310E21C;
	Mon, 12 Aug 2024 13:48:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5QiNk4ZO";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5366810E219
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 13:48:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPRmJH2PiVsddKQqoveLb5cWVYjCQ2D8bSzyLWQkTVVGqSSVz+1nkjZa5pJssCk8n0wQJ5qv0AV46r1q+W+Q/Wmvf0XTNTXxDRuzwrQW7MMMIp1ttVG3zsjjYj6S1xh5X1ppMRNcS+2NSqHUI3eGJygFzYXDruJ8WGSKuc5J5RlBixfiM8g/T61TY7mTeRbvFuMqDS+FLPevTChq6iLNS7Wn/0DtwhA336ibrve5zZNYbr03VJKwvudSmrid+2aWG8cxPgG4xywU1NMT/Sl9qyhGVlC95eVa52my4sFaJtrizOizVOAw3cNcmictaDAjfye62n61E0dkzlTkCO9cDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EytTMg/funcZSJxGxOOPbu2tKI2gdcs49syRVJ/fr5A=;
 b=NkeaV7LqEjt7LofJ7QhbZu3qNBEdA/CD29FCgxInDrskSLdPaIYK6Uis5+5sVi8UH+nyqD1p2Kn30EP3M541HK9x/s2tnYkBxwqWra+fGKtOu2apzgUg7ag69ZC9ZbcQm5JvdEvyi/v6sv5Xo1bsiDoeR4laaEN1Gg4mw29jg3IKzNEk/rYIscrn7M7UJzh/uOnbbta5e0fg8SHEDtghaofCg4BEaloftOW0aqOGg7UDELbYyB1TX/hm1df8ylEbjFNITpFHk/mCsGMXnAJSu7tmYP49cZMo7vGe1g0apftTDJAmEdHcYilC1bIIGPYoRUyp+pwJMGA39ox9a1oIxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EytTMg/funcZSJxGxOOPbu2tKI2gdcs49syRVJ/fr5A=;
 b=5QiNk4ZOyDdBAVZVA5rzQ7f19Rf/MDyiTDCUkOewI1I+03cqW5V9kKYZjhetXr0mzlVWbxYD3rw3J/RbnMhOK9wxAUPbf+owFmh3hR1equ4leB6i965dvI/G14pl2up/8hwXDcHvWZ0BmYL71rlJvG16g7hzaYpXqnxE0vN3Tqw=
Received: from SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Mon, 12 Aug
 2024 13:48:45 +0000
Received: from SJ1PR12MB6292.namprd12.prod.outlook.com
 ([fe80::745c:1e06:be67:94af]) by SJ1PR12MB6292.namprd12.prod.outlook.com
 ([fe80::745c:1e06:be67:94af%2]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 13:48:44 +0000
From: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Luo, Zhigang" <Zhigang.Luo@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Disable dpm_enabled flag while VF is in
 reset
Thread-Topic: [PATCH v2] drm/amdgpu: Disable dpm_enabled flag while VF is in
 reset
Thread-Index: AQHa7Lje/tgYN9Oj6kaSzD9wz9uamLIjolsAgAAAwSA=
Date: Mon, 12 Aug 2024 13:48:44 +0000
Message-ID: <SJ1PR12MB62926E0B9A625D6AFF6967A28B852@SJ1PR12MB6292.namprd12.prod.outlook.com>
References: <20240812130909.1011463-1-victor.skvortsov@amd.com>
 <562e12ad-c10c-4b10-bf43-d0dcf82eb823@amd.com>
In-Reply-To: <562e12ad-c10c-4b10-bf43-d0dcf82eb823@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1bf605d2-3b4b-4f14-8021-3075d89fd9a4;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-12T13:48:14Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6292:EE_|MN2PR12MB4470:EE_
x-ms-office365-filtering-correlation-id: f5b7b7f7-060f-416e-6e7a-08dcbad57bd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?L2lEMmJqemxkUDIybTZhcm1TSUR6d2tuZkM4ZTNXVXl6M2pnQWZyVHEreU04?=
 =?utf-8?B?cjE5RENEVFRoSEJ0RCtYa2xZRFV3N2JHU3hIVVFqYjNCcTJ3VHRpdThrbVRW?=
 =?utf-8?B?YnY2WC90SUFwNDdEdnBZdGFHYUs3V2tFbWNueUNPWHlGUXh1YmoyYnY5NW50?=
 =?utf-8?B?ZFFTVlNBNXQrT1NUaTYvVHRkRm9YR1FTK1J4UldtSWZ6TlRwTTFnUG4vNVFy?=
 =?utf-8?B?cjVhYWoyS0hmM0NYM3hGUEpWREM2UkVvYjNOSHBVTXhhck9SNWR4ZWxRNDgr?=
 =?utf-8?B?VytnY1dPUkIzRU9oMjVPMXMvbnVMVlpIWkd3K2sraW5CTU9taTJsSmswVE1L?=
 =?utf-8?B?RDl3N2p6eWgxQUJYeUpXQ0RRQVJlY0Rkc3BxdThrRlJKcGw5bUZGaDFkdzZ2?=
 =?utf-8?B?bFNqVEdpSGV5QkNIRU1sNHFMN1hzNlRKaERmZUFFd0tGM2hrYlBBMHQ3N0t4?=
 =?utf-8?B?bUtac25zNGRmZW04VzF1Q1RQRmRUeDZONkZVQU0zSHU3VTlCb0hTTVl1dW4v?=
 =?utf-8?B?blFmTFlpOS95eEJxVjl1TDVMdk1DcDRZUHNGeDlmbUpJemVqNnM2RE15QzhD?=
 =?utf-8?B?Qkg1cEYzdjJMSjIvL0hCdTBrc09tTmU4Ty9GbFRCUEt6SHlZMVVsNlk3YVFr?=
 =?utf-8?B?a0RLUzdsa25ULzFIc0VMVE1SdGVyS3ludS85R2xhd010VFQ5YTc4NU8xa0Ra?=
 =?utf-8?B?YjkxUkszTFNlVzhJZVlTakdEbGJNSVJnZmFFMlRaZHpmWS9TWlBhNVVMd1py?=
 =?utf-8?B?Qm5FNU5xeEkzTVY3RDRjak5oaEJGMnp6LzBkQ1ZZanUrZWE4ZE5EalVRaUk5?=
 =?utf-8?B?VkZ4UlZ3bmZrblBiTXFaMjV6RlFoTDRKMmFUdDFGMkRoMFVMOTRnaGtQZk1N?=
 =?utf-8?B?OWZZRUZrdnRLSEMxWUVMS29SNjZWWXE5alN0L09sVWhuS3NvVndSKy84RmhV?=
 =?utf-8?B?YlIrQzNaK3liaWdlaWVvZklwc3VHYW5UUXZMN0xlVXFxUDYwNENqcm1NN1dk?=
 =?utf-8?B?UEhveVRxTERGK3A1aENJQ2ZhSjR2VEc4b1lSVlNFNjhTY0hoOXhITVk4cDl5?=
 =?utf-8?B?MHp0WEMyTUZzZVQ3MVZiZElzM29KT3RCZnlpRzFEMUxKc0p6YS9TSUlHMFI3?=
 =?utf-8?B?K1RMZUR4d1c5QWdiQXUrcDdNY2VPZ1VPL2lPSllYVDZ6OTlQaTArNXRoQ3gw?=
 =?utf-8?B?M0VSMUpaQTlqOEVFNjhsL1dFdFhrNVlXejdZY3lQaFRPQmVUTHNleTd0RHJj?=
 =?utf-8?B?dWxvQXViTVQrVGFzYngrRU8vamYyaDl3L0MxNjdKT2RreURHb21qSzhzTEVF?=
 =?utf-8?B?ekNNaDIvNUtHYmpQTVpDc1cwdkpRYnNzVzdhNkFBSjFRV3lONzZ4Q1VqWGxH?=
 =?utf-8?B?SmxyOGFjR3RmaEtiZzRLNSt3NDk2alNnZGdFT2pyTjM5MHN1amYxeVE2TTh6?=
 =?utf-8?B?bHdkeUo4YXhXUXlyMU1VWm5DT2dMUTliV1BNODl5anY1aWczWjN2TWo0eW5C?=
 =?utf-8?B?OVVVOTFJSC80TG8wYUhaWG5XRFFESkMraTAzSWUwU3U3aDh0QlNKSkxQNWVF?=
 =?utf-8?B?TEFvR0h4U2JsTENQZUloNnJJYUhHVlFld2J2d0ZPVzZwUmJ0aTJENnNtOWF6?=
 =?utf-8?B?Wi94ejZvRnNKQ2J3a1F6ZTVJKzgvekhDeUFHdjFmZThhMDcyWDQydmVhd2pQ?=
 =?utf-8?B?TTdjSThtdi9JOVVxd2NmUU5SN3hLV3BQVkpuTTNqUlNyQjlnT1I2RFpEd2tm?=
 =?utf-8?B?QUJNMUVVZTZuQ29GL0psRllQRGlETlJUVlVQeUlYMzJiUFhuOXJRRUNJZXVS?=
 =?utf-8?B?VHNzelNvekx6WkNFTng0Z1lTMDAzdmpwSTYvbmdHbG13WW9wSG5qMlIyNTJ5?=
 =?utf-8?B?UDZpSEJybVE3QUszSkpYNFVyeVhiUDJEaCtmNXVnZUZLZGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6292.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHhqeGdVQlZETWZmTDhLVWIveVZRSkF4UHI3TWJtekJiUjVkSjE0YTJsWnBX?=
 =?utf-8?B?TlBZdjBFTUNVR29jN05pK2E5UUVJaEZaRDFMaUMyR01ZZ0hDYWtHTjE0TGNC?=
 =?utf-8?B?QmlNSlJlSjRwelJKUXRTcEV5Z3NOUjVDSUV0THduY25QaC9NU1ZvNCsyRGJT?=
 =?utf-8?B?eUdlOUtEMFRCT1hxakp0dE9aakFnNVR5MVljd0R6dFMrZVA2cHRkYUU2UjE4?=
 =?utf-8?B?eDJFeTFicHNYWEVweU9MWGVNUCtuL3NGM0pzK051Qnh4NW5hSVAzRUsrSnk1?=
 =?utf-8?B?b2hwNXNsOEd0OFdmODNMT0RUWkY5WUJRUjVCVExONytxZVByY1A0SWFVVmhz?=
 =?utf-8?B?TFR4SFhyRjQ0WGwvcGdTMEY1L2QyUkNDSTRKMHlqTnF4cnA5ZUp1NXgwT3BP?=
 =?utf-8?B?LzZFSHNwOHd2Y25keUcyQjJSaHgxUVh2UWNmYVNra0krSlQ2ZTR0WUtTVTVQ?=
 =?utf-8?B?cnlodXFtYVowN1A2bHZ6MGN1MmozNXFWM25jU2hlamY0ejZzQUFBOUJMbTRR?=
 =?utf-8?B?TWRTV1pEWUNUajI2emNnUGxkeUVRQWpxeDByamIrMHBwNng1RDBmMThCcldH?=
 =?utf-8?B?dTF1eTNRRlFTQlhlR1NFT1NZU2FyMUZJeExiQitscnJ6eGc5Mm9GTUxqMjRy?=
 =?utf-8?B?VGlBeEdxcHJ2ZmlCVDZaZ1pFOVc3VkFNS2MrZXRKazVxelFsTVQzb2ZtQXBF?=
 =?utf-8?B?YlI2QTdhYXVWTEdxamdEWkVJTk90T0NVaVUxdlFvV2srZzUyRXFneCtXNDBM?=
 =?utf-8?B?blVyRUhLM09IcVNYTWRQUXB2Q0lTSktBZDZRNEsyRmwzN2pvYlUxZG1icERt?=
 =?utf-8?B?VlVJajA1ZVBzcGhWcjM2bDFaRjBsUy85a0grZ0ZhMHJ5RVQ1bXJJMkRRQWN5?=
 =?utf-8?B?Q2hCWXZTWXk5TmU3NmxWVGNjbEd5YXluc05XVUtUTWpYZ2RJNzJSUG8vTlFR?=
 =?utf-8?B?NWtwZGsvU0JSby83V2pZcm90M3U0UFVmcmc5cGdYWUkvcHduUW4yRjYxZDJB?=
 =?utf-8?B?bjdTcHBBcXd0ekhzUlg1dS9aSkNGc0p3VVNCTXVFeHRNSU9qSEVXbk1QNUJo?=
 =?utf-8?B?bHhFeDBzYXZweG5wUmRtMFIxY0FIV1FBVS9peXNKRDJSeTA2WXliSE8wS2ZC?=
 =?utf-8?B?MmlGb2hNK1Y5cGl4cUh3OS9zN3k0STZvVWpESXQ0NG80aVlkWktKeWxkelJk?=
 =?utf-8?B?Z2lhOEdIdU5EK3h4ZGlLWXAyeWdYN2kwWStmanMwNWZOSVpiR3A4dUh0Y2oz?=
 =?utf-8?B?WHJBR2VjdFFoQms3ZVViUDlGbW9KaW5VMis1QmV5emk3Q2wvOXNvK3Zja2tS?=
 =?utf-8?B?VjJwMVY5N1UxdW5sWHFmNHBpT0c1M3dBK0dVNEZQbjhwMVQ2eWJ4WGVxOHow?=
 =?utf-8?B?aUt5UU1sRWtKejBpOGhMT2VHSmc2cXBiTVlFSVlLSTBUcTk5NVhuQ3Z4Y1hN?=
 =?utf-8?B?OTM3TVhQUnBIYTdjWUtUditmQjlsbWh2VEM3V0NuTm1xYmxQSDFic004ZW5Q?=
 =?utf-8?B?ZHdjWGt6TEpySE85MExTdUpiY1hzc29Zc0pHVmxhcWNTWmxrS283Tk1tTFV0?=
 =?utf-8?B?SWRTWmR3bTVVaVJCOFNSbkRCc3ZQUDF6OGIrT1dnNUY4cG9KUmxTZm5UQkZk?=
 =?utf-8?B?dzJEMGR3cUdTRnhhSFNJRzNSS2g4STIxdlZrVGNVemNYbE1taEU5TEVQRFRk?=
 =?utf-8?B?SWFkWHI5Mjh6eDEyN3kwdHNzNUx5VDVramd4L05uTFFETURrOUZKRmE5Q1A0?=
 =?utf-8?B?eEFBMzBjL3FxK1d1YVZobDE1Q3p5em5OQjI1bk5NZVloaU5sVTBhMlZyVDJ4?=
 =?utf-8?B?dVdwTXpHS2xBSUhOb1Y5Zm44OGRlRmdqMC9QOWZFYXFSNDRYcWRwQlRXYTZK?=
 =?utf-8?B?VGcvL1QvUlhPd2wvTG9CQktCNFI5NlF4NWRYR1M5OFhhUHBreG9UanVOOFQ3?=
 =?utf-8?B?cHB5RnBlY1pXa2JNdldqRUprK3dBaTRJaERQTFFHT1JjOFVFYTdlTmYwM05F?=
 =?utf-8?B?Qm1UK3I0WU4rQXhLY2NTNXVjSFlDd3cralJ1Skt3N1VBamY3S2dnQlkxRDNU?=
 =?utf-8?B?ZEw2U0NZaE5CUjJNb0FKMWFkVlJ3ZVhJVCszUzEyWDNRanNEaTVVU3IxcnU3?=
 =?utf-8?Q?Pj/w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6292.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b7b7f7-060f-416e-6e7a-08dcbad57bd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 13:48:44.7611 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OHrnC/TGmY/d7AjcU5Ovrp+fwC3B7Eb7AYalq8iPfkJynVTcmTzsxNMS+tBk2451ok3yPaVpdFACzsWsitMQnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXphciwgTGlqbyA8TGlq
by5MYXphckBhbWQuY29tPg0KPiBTZW50OiBNb25kYXksIEF1Z3VzdCAxMiwgMjAyNCA5OjQ2IEFN
DQo+IFRvOiBTa3ZvcnRzb3YsIFZpY3RvciA8VmljdG9yLlNrdm9ydHNvdkBhbWQuY29tPjsgYW1k
LQ0KPiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBMdW8sIFpoaWdhbmcgPFpoaWdhbmcuTHVv
QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIGRybS9hbWRncHU6IERpc2FibGUg
ZHBtX2VuYWJsZWQgZmxhZyB3aGlsZSBWRiBpcyBpbg0KPiByZXNldA0KPg0KPg0KPg0KPiBPbiA4
LzEyLzIwMjQgNjozOSBQTSwgVmljdG9yIFNrdm9ydHNvdiB3cm90ZToNCj4gPiBWRnMgZG8gbm90
IHBlcmZvcm0gSFcgZmluaS9zdXNwZW5kIGluIEZMUiwgc28gdGhlIGRwbV9lbmFibGVkIGlzDQo+
ID4gaW5jb3JyZWN0bHkga2VwdCBlbmFibGVkLiBBZGQgaW50ZXJmYWNlIHRvIGRpc2FibGUgaXQg
aW4NCj4gPiB2aXJ0X3ByZV9yZXNldCBjYWxsLg0KPiA+DQo+ID4gdjI6IE1hZGUgaW1wbGVtZW50
YXRpb24gZ2VuZXJpYyBmb3IgYWxsIGFzaWNzDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBWaWN0
b3IgU2t2b3J0c292IDx2aWN0b3Iuc2t2b3J0c292QGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyAgICAgfCA2ICsrLS0tLQ0K
PiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5jICAgICAgIHwgOCAr
KysrKysrKw0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5oICAg
ICAgIHwgMSArDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9rZ2RfcHBfaW50ZXJm
YWNlLmggfCAxICsNCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfZHBtLmMgICAg
ICAgICAgICB8IDUgKysrKy0NCj4gPiAgNSBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCsp
LCA1IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RldmljZS5jDQo+ID4gaW5kZXggMjlhNGFkZWU5Mjg2Li5hNmI4ZDBiYTQ3NTgg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rldmlj
ZS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5j
DQo+ID4gQEAgLTUyODksMTAgKzUyODksOCBAQCBpbnQgYW1kZ3B1X2RldmljZV9wcmVfYXNpY19y
ZXNldChzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPiAgICAgaWYgKHJlc2V0X2Nv
bnRleHQtPnJlc2V0X3JlcV9kZXYgPT0gYWRldikNCj4gPiAgICAgICAgICAgICBqb2IgPSByZXNl
dF9jb250ZXh0LT5qb2I7DQo+ID4NCj4gPiAtICAgaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkg
ew0KPiA+IC0gICAgICAgICAgIC8qIHN0b3AgdGhlIGRhdGEgZXhjaGFuZ2UgdGhyZWFkICovDQo+
ID4gLSAgICAgICAgICAgYW1kZ3B1X3ZpcnRfZmluaV9kYXRhX2V4Y2hhbmdlKGFkZXYpOw0KPiA+
IC0gICB9DQo+ID4gKyAgIGlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikpDQo+ID4gKyAgICAgICAg
ICAgYW1kZ3B1X3ZpcnRfcHJlX3Jlc2V0KGFkZXYpOw0KPiA+DQo+ID4gICAgIGFtZGdwdV9mZW5j
ZV9kcml2ZXJfaXNyX3RvZ2dsZShhZGV2LCB0cnVlKTsNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5jDQo+ID4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5jDQo+ID4gaW5kZXggYjI4N2E4MmU2MTc3Li5i
NjM5N2QzMjI5ZTEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZpcnQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92aXJ0LmMNCj4gPiBAQCAtMzMsNiArMzMsNyBAQA0KPiA+ICAjaW5jbHVkZSAiYW1kZ3B1Lmgi
DQo+ID4gICNpbmNsdWRlICJhbWRncHVfcmFzLmgiDQo+ID4gICNpbmNsdWRlICJhbWRncHVfcmVz
ZXQuaCINCj4gPiArI2luY2x1ZGUgImFtZGdwdV9kcG0uaCINCj4gPiAgI2luY2x1ZGUgInZpLmgi
DQo+ID4gICNpbmNsdWRlICJzb2MxNS5oIg0KPiA+ICAjaW5jbHVkZSAibnYuaCINCj4gPiBAQCAt
ODQ5LDYgKzg1MCwxMyBAQCBlbnVtIGFtZGdwdV9zcmlvdl92Zl9tb2RlDQo+IGFtZGdwdV92aXJ0
X2dldF9zcmlvdl92Zl9tb2RlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZA0KPiA+ICAgICByZXR1
cm4gbW9kZTsNCj4gPiAgfQ0KPiA+DQo+ID4gK3ZvaWQgYW1kZ3B1X3ZpcnRfcHJlX3Jlc2V0KHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KSB7DQo+ID4gKyAgIC8qIHN0b3AgdGhlIGRhdGEgZXhj
aGFuZ2UgdGhyZWFkICovDQo+ID4gKyAgIGFtZGdwdV92aXJ0X2ZpbmlfZGF0YV9leGNoYW5nZShh
ZGV2KTsNCj4gPiArICAgYW1kZ3B1X2RwbV9zZXRfbXAxX3N0YXRlKGFkZXYsIFBQX01QMV9TVEFU
RV9GTFIpOyB9DQo+ID4gKw0KPiA+ICB2b2lkIGFtZGdwdV92aXJ0X3Bvc3RfcmVzZXQoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpICB7DQo+ID4gICAgIGlmIChhbWRncHVfaXBfdmVyc2lvbihh
ZGV2LCBHQ19IV0lQLCAwKSA9PSBJUF9WRVJTSU9OKDExLCAwLCAzKSkgew0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5oDQo+ID4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5oDQo+ID4gaW5kZXggYjQyYTg4NTRk
Y2EwLi5iNjUwYTIwMzJjNDIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZpcnQuaA0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92aXJ0LmgNCj4gPiBAQCAtMzc2LDYgKzM3Niw3IEBAIHUzMiBhbWRncHVfc3Jpb3Zf
cnJlZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiAqYWRldiwNCj4gPiAgICAgICAgICAgICAgICAg
ICB1MzIgb2Zmc2V0LCB1MzIgYWNjX2ZsYWdzLCB1MzIgaHdpcCwgdTMyIHhjY19pZCk7ICBib29s
DQo+ID4gYW1kZ3B1X3ZpcnRfZndfbG9hZF9za2lwX2NoZWNrKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgdWNvZGVfaWQpOw0KPiA+
ICt2b2lkIGFtZGdwdV92aXJ0X3ByZV9yZXNldChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7
DQo+ID4gIHZvaWQgYW1kZ3B1X3ZpcnRfcG9zdF9yZXNldChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldik7ICBib29sDQo+ID4gYW1kZ3B1X3NyaW92X3huYWNrX3N1cHBvcnQoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpOyAgYm9vbA0KPiA+IGFtZGdwdV92aXJ0X2dldF9ybGNnX3JlZ19hY2Nl
c3NfZmxhZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgZGlmZg0KPiA+IC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2tnZF9wcF9pbnRlcmZhY2UuaA0KPiA+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9pbmNsdWRlL2tnZF9wcF9pbnRlcmZhY2UuaA0KPiA+IGluZGV4IDRiMjBl
MjI3NDMxMy4uMTlhNDhkOTg4MzBhIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvaW5jbHVkZS9rZ2RfcHBfaW50ZXJmYWNlLmgNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2luY2x1ZGUva2dkX3BwX2ludGVyZmFjZS5oDQo+ID4gQEAgLTIxOCw2ICsyMTgsNyBAQCBl
bnVtIHBwX21wMV9zdGF0ZSB7DQo+ID4gICAgIFBQX01QMV9TVEFURV9TSFVURE9XTiwNCj4gPiAg
ICAgUFBfTVAxX1NUQVRFX1VOTE9BRCwNCj4gPiAgICAgUFBfTVAxX1NUQVRFX1JFU0VULA0KPiA+
ICsgICBQUF9NUDFfU1RBVEVfRkxSLA0KPiA+ICB9Ow0KPiA+DQo+ID4gIGVudW0gcHBfZGZfY3N0
YXRlIHsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfZHBt
LmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X2RwbS5jDQo+ID4gaW5kZXgg
OGI3ZDZlZDdlMmVkLi5hZjM5MjA2YTJjNWYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wbS9hbWRncHVfZHBtLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bt
L2FtZGdwdV9kcG0uYw0KPiA+IEBAIC0xNjgsNyArMTY4LDEwIEBAIGludCBhbWRncHVfZHBtX3Nl
dF9tcDFfc3RhdGUoc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ID4gICAgIGludCBy
ZXQgPSAwOw0KPiA+ICAgICBjb25zdCBzdHJ1Y3QgYW1kX3BtX2Z1bmNzICpwcF9mdW5jcyA9IGFk
ZXYtPnBvd2VycGxheS5wcF9mdW5jczsNCj4gPg0KPiA+IC0gICBpZiAocHBfZnVuY3MgJiYgcHBf
ZnVuY3MtPnNldF9tcDFfc3RhdGUpIHsNCj4gPiArICAgaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2
KSAmJiBtcDFfc3RhdGUgPT0gUFBfTVAxX1NUQVRFX0ZMUikgew0KPiA+ICsgICAgICAgICAgIC8q
IFZGIGxvc3QgYWNjZXNzIHRvIFNNVSAqLw0KPiA+ICsgICAgICAgICAgIGFkZXYtPnBtLmRwbV9l
bmFibGVkID0gZmFsc2U7DQo+DQo+IEZvciBub24tVkYgZGV2aWNlcywgUFBfTVAxX1NUQVRFX0ZM
UiBuZWVkcyB0byBiZSBhIGRvbid0IGNhcmUuDQo+IFByZWZlcnJhYmx5LCBzb21ldGhpbmcgbGlr
ZQ0KPg0KPiBpZiAobXAxX3N0YXRlID09IFBQX01QMV9TVEFURV9GTFIpIHsNCj4gICAgICAgaWYg
KGFtZGdwdV9zcmlvdl92ZihhZGV2KSkNCj4gICAgICAgICAgICAgICBhZGV2LT5wbS5kcG1fZW5h
YmxlZCA9IGZhbHNlOw0KPiB9ZWxzZSB7IC4uDQo+IH0NCj4NCj4gVGhhbmtzLA0KPiBMaWpvDQoN
CkkgYWdyZWUgaXQncyBjbGVhbmVyIGxpa2UgdGhhdC4gV2lsbCBzZW5kIG91dCB2My4NCg0KVGhh
bmtzLA0KVmljdG9yDQoNCj4gPiArICAgfSBlbHNlIGlmIChwcF9mdW5jcyAmJiBwcF9mdW5jcy0+
c2V0X21wMV9zdGF0ZSkgew0KPiA+ICAgICAgICAgICAgIG11dGV4X2xvY2soJmFkZXYtPnBtLm11
dGV4KTsNCj4gPg0KPiA+ICAgICAgICAgICAgIHJldCA9IHBwX2Z1bmNzLT5zZXRfbXAxX3N0YXRl
KA0K
