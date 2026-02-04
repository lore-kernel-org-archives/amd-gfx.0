Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB133E8B39D
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 05:21:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53BBE10E0A1;
	Wed,  4 Feb 2026 05:21:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QvjEHC72";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011000.outbound.protection.outlook.com [52.101.52.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DACAA10E0A1
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 05:21:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7kOKx7G8lKyC65rYXHpaAhgmAmuOWwZovRE55vlzSqZST5fCHZrmd/uNcyAZqlaN1yxbuMhLnSzDiIJeIVJBAHCcplzORDLKv9I5gBNqA3a6bCnOVBUsPH6DJd3SkOlggVGRxlQB3bP7Plw9tCFmM1biFP6dPojPR/w9OayIALuujJtkHjZPC7e/yRNBHGhLpq1Ps7uRvzqqjAPPlfwkcqebyej1LNuqzO/DmjouVZKbwSSW1HzTXakQZqi5rCn1pdHZUWcCE1VLAulMy1aZCvcs3yZp3Z5r1QYE91nwYAxWHK1768VF6LYsCDUxX3/QPFXsgNrLTkPxWlzP98glA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQpI0A25i6F8IM0FxhsIydSmtumsWfvIyZmkXaICFxU=;
 b=ErECzw8aXUJ68MyTiNX9weQ7AR66OfsjLaEAvktrX02u9P2bR0TROW8mEzibRePT1KbtOFNxqzGpfqJpLpaSjf3BPoRaj6vLVJBoudmHtxvyyLfWI+373g9DlJfDOugamlCzRb4ogvpEKZBS5QXv7CmceYKza82og8+5vm2EmcIjcKAm54cLm4WYt9p5NOiU5LtF/EAmZzUoprfafCREsuqwGYKz3WW5CP1hpcNFaOZbu7xH5JMnjpX6actkjOvIJAZJv00FwSKtsllST+/NbonIeBthi5fqotxDW0ehAzrjvfgrd+C0AHvM2ozlA/7rZ26kwmPu4+mZ7uSwjjD6dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQpI0A25i6F8IM0FxhsIydSmtumsWfvIyZmkXaICFxU=;
 b=QvjEHC72D/3MJdFWgAdwehhIQHneFqjatkUYLtZ2KNQJoEXwd/dzicTRVlSPyytJDUUUgaS5rTiRdcjUo7+Mx7vaY773ECnqtc5fylupzDQiwxGTcbFeeZsE8ZvE0rB3dAhSo0cH9uNdJb7tQj+CvjSRNs+ArZn/Lb1uJKhDWoA=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SA1PR12MB6727.namprd12.prod.outlook.com (2603:10b6:806:256::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 05:21:01 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%3]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 05:21:01 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix missing handle PERF_DETERMINISM level in
 smu13 & 14 & 15
Thread-Topic: [PATCH] drm/amd/pm: fix missing handle PERF_DETERMINISM level in
 smu13 & 14 & 15
Thread-Index: AQHclYj9SE87hagoR0ivomno8hQ/NbVx6CqAgAAEXQCAAAuGgIAACKUA
Date: Wed, 4 Feb 2026 05:21:01 +0000
Message-ID: <PH7PR12MB5997A2311C5F7B9B62828F428298A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20260204034732.187325-1-kevinyang.wang@amd.com>
 <9f783e4c-9609-48e5-8a11-1c6debcf9916@amd.com>
 <PH7PR12MB59979ADFBC092D6DF4549A228298A@PH7PR12MB5997.namprd12.prod.outlook.com>
 <72777119-86d6-41b6-ac77-3cf02d861273@amd.com>
In-Reply-To: <72777119-86d6-41b6-ac77-3cf02d861273@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-04T05:19:49.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SA1PR12MB6727:EE_
x-ms-office365-filtering-correlation-id: 1ccc9e3a-684f-48e2-0d44-08de63ad2fc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?cVJjYzFnL2hNaVVHbktNclEyNzc0NFVvRVNpUlJxcWFxak9QY1czMGxLTXlP?=
 =?utf-8?B?QjZzZGdMMzI4TUNzTDFtM3VtRm1wbUMyV3JDVGhVSW5pWDZ6Y3ZGL0sxTFFh?=
 =?utf-8?B?TDlQbGFHY0xrSFNWWHNsTkUzMUlNWlUwSE0xMGRxTnpGT1Y1dlpSeHVFRHVo?=
 =?utf-8?B?WitkL1pxZS9tSThyUVBTZk9vbmxkQkR1ZzZ2Y2NlU0JXdVlzRUlnVjkyNnZo?=
 =?utf-8?B?QjZrNmhiNWNvejRyUjlxa0prUUZKNklzQkh3dmR5L3JaM1d5UlgwT29pbyt0?=
 =?utf-8?B?bTdzKytzL1BQWTM3VkFpVzNoM2VSUm9ScDN2Y28xbW1Vc2FmWEFOQ0ZQbjVL?=
 =?utf-8?B?ckFsbW8yS0Vkd2ZXQkV0Z3hZdzFzdXBtaVR2R1BUODR4a1RIMWdhWklRdkRY?=
 =?utf-8?B?RlJMeHB0QkVld05uZ3Z2aGlsaThLQmxvUzdrcVRvbC9zMUgrTkxQS3UrOEdw?=
 =?utf-8?B?WlEwUXVLUXhFdjRkc2VDYUNxb2lJRDFyaktkRzRITEVWUzJSaFp5NW9XWFl0?=
 =?utf-8?B?K2dEejdnRExQc200MThWbWg2clg4SXhBQjhSQytjN1pTaGVCL2FrbVVTT2tW?=
 =?utf-8?B?VzRyOXFpTmJzZ2s0a1JmSzRGMnpkM2U5UUJsd0lpdWV5bW5CSlVnVVFFUVF5?=
 =?utf-8?B?ZWFaMyt3ZGk2QkxvMDE4TTROZTJuTENzWjlXNnVpcitiR2x3eVVDdmpFVFpt?=
 =?utf-8?B?bHR6YzlmQWR1MXNzaXFGenJkT2Fma21CU21aaDdBWkk1YnhQNTBBNlZMQU56?=
 =?utf-8?B?anFrelJTbWlPay85VXAwZXNTWlJoZ0dJNFVpL3A5ZWdHYi9ERjhnTFNUcXNh?=
 =?utf-8?B?UVFuWGlNTW1sTjUzVHB0MHprTXhlQ1psMzZ4dnNNeWluMnhJTXIydzI3bEZ0?=
 =?utf-8?B?cFFCeFVqeEV6Z01tWklJNDZYZGxoQnY1b1NXYkNEU3hzR3dBMHVvWm0rVzRG?=
 =?utf-8?B?Z3gwZWt2V3k0WmY3bnBSVmpCSFlxYmFxbENjUm9rSDdjR2tuUHA2WnNNNk1l?=
 =?utf-8?B?SXM4WHdLSER1c2NiQXY3ODJQNG13eWxJUEptNlZqNWx4clNNdWQzZGUraWNj?=
 =?utf-8?B?M0g5OW5iNHJicUtjaDU2V2VhLzFsb1lYLzFLVVZMT2p2NGxmbDJDTk1WeVc3?=
 =?utf-8?B?K2RCYVdwUHRtWlpMLzJBT2pEYk1vTVpsOXk4anVuTmJwZksweUE2eEhrYzN1?=
 =?utf-8?B?RDViZ0MxMTd4L1gxMmEvbko5MzNsa25GZEtnTEdvL1RYQWk3cktJTDhUemdX?=
 =?utf-8?B?bkFLdXF4VTZrUlc2bTlnMTllanZGL3JhSmlyRVFodFUwdkR2aHl5SnQ1cUE1?=
 =?utf-8?B?Q2FoN0lvMDhzOE8rRnVjN0lyOG5ScEt1TUhoRVJIUG9xSHJLVlBCaVQ1OS85?=
 =?utf-8?B?L2lPVnQ5aHVkSlBycnNITzd0Ly9nRlJXL3dZL2xtSWh4clA5ZG41SXZ3QlZP?=
 =?utf-8?B?T2YxbkVZaERRNi9aYjFGNS8wcWlTTUZyNUFLTXdwR1I4K2daZFVYdjdUcC9z?=
 =?utf-8?B?cVoxZWtkWm9sL0tkNXB4ZUg1Q3ZLUElOMWpvdEdSUlNpMnl6cGpacFhJeDhU?=
 =?utf-8?B?QmtkZVhiRnpKWlYvZHVDMDVSMFV3NGRiMGVIWGJCeUpUbUhXSTV6ZDhYTmxp?=
 =?utf-8?B?RGlBOFZrU2RWZnBYcmFYem5yZ2Y0OU81MWVrQU01bnJQSFFONEhjdkVULzRq?=
 =?utf-8?B?c3dOakN3TUVxTnRGOVM1SjFCUERPbkQ3SFJ0UVdNZzN2UkNpZm5lTXhsaERK?=
 =?utf-8?B?T2JkTTFhOW82ekF4T29LKzhyd0V1RENBeVdqVGgvbm51ZDRqZjVYeTBpL096?=
 =?utf-8?B?RWZ3RzgvdzU2MHBGUDQrU0ZhbHhkRmY3SkZwb2dCaUlmdXROcnpVMkwrY2NB?=
 =?utf-8?B?ZWxmc0E1MzlxYkVBSWZRWlRld3ExUTByRVZVOUxhNkZYVjVaNDBpQnllNk1n?=
 =?utf-8?B?eHRNcHF0STBucFJ5d241aExqRnhVQklZSzR5QjRnQVB3b2F5UkdCa0cvM2ZX?=
 =?utf-8?B?S3NyTkhHbnNncTArbC9rRGFyMVMrZjNyOE1DVFBEQjUyYk1IcWhtTUFZdi9U?=
 =?utf-8?B?S1hGejJzS1dCRS9tbWJXMm0zTSt6N3JKNVJCU3AwaXQvQTBMcGI4S2hsL0R2?=
 =?utf-8?B?TXFBZzZtVWZpaGFrR1NvWkpqTjh5VzNBTCtPaDhEckVPc0NCZUZzOVdSUEZD?=
 =?utf-8?Q?vR/gEFO9f0w8GtfxY//Gjao=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXpIK3FwK0ZFMXduWS9RMkoyUEZxTk44RG1meE1SR3FTZHJkdFhCbUg4Nkhn?=
 =?utf-8?B?YkpjVlkvU3BTdzN2cys1RTUwRCtXTHNIblR3YXhROEgzQmxPeEk3QWdyOGNL?=
 =?utf-8?B?Zkl6ZUVQOHJ2R2Rxd21WdGNuMlcvOWtWdHRuNjRYdWZVR1pXUElnZFdoenE4?=
 =?utf-8?B?NE9pM2ZSOTA0dXprV3VuSXMraFdDMkpRM1hNQUV1M1IreUJueVZUWTVJWFJy?=
 =?utf-8?B?MlU4d1pPUTVwbTJLQTd1WmJKRkljcVpyb3NJWXhWbktVYjlOTnN2OVA5WGpo?=
 =?utf-8?B?Mm5udU9idVJrOGZBNEhiSnRGcWhhQ1VkdmhLS01TM0hEeWFYdm1Na2ducWpU?=
 =?utf-8?B?VWc1QVg3R0FrTjkzQlhnaktycXUzN3NIaUtJTFhyNGJSbkRvWTI5VWJDMERi?=
 =?utf-8?B?TmpvN01hTWJwMlRydHRScTNYU1NrSDdCb0pwU3M3cHpGNFJBL0FUcjVkVmhZ?=
 =?utf-8?B?a2RkVDJIK2d0VlBub2c3MkcvNGhibE5VTFluZHpuK2poakQ2SUVUZ3NaaVY1?=
 =?utf-8?B?cStwOHBMa003Z1pEbyt2N1IwdjFWYlJGK2FLM1VFelFoQWgweXZ2Vlo2cTRZ?=
 =?utf-8?B?ckNPZ2Mwa09iMTgwV2hJVlI1ZUp0R1JIbVJYaG9QUlp1OHJYSzJWME9CUjh3?=
 =?utf-8?B?dERIMTkzd1hGQWFWS0V3QXFvS0xGcTIxczlNcWM3RFQ0akswZG9NZzFCcTJl?=
 =?utf-8?B?TlV0dUpQUnBscWU4RGdNdUFiMTNvakc1dWRmYmErL0plOXFKbFRpaEdOMjh5?=
 =?utf-8?B?VmZwV3JmNThReFZzcnlaUHlqNUhOd2dGZXFRNnlnRXZlOVFhc0o4MGxyajV5?=
 =?utf-8?B?eDlYVU9tTGpxZmhvSGxsRVBsQXIzM0tzOWxvK2pJclN6VXhPOWt3WHF1dTZN?=
 =?utf-8?B?ZnlDWFVabTJSUnhtSDBaSVF3ZnlRMWhqT2h6dXhnK251OFBxWitPdk12aVNG?=
 =?utf-8?B?dnJDMzVnT2lJUlFYTnppb3d6aE1XczRVejNjK0FMWmJQRFYydFJ0UGV1Q2kw?=
 =?utf-8?B?VG9LaGhmdXd2amdLbFNUUTdrWWxhOFVEcWRpSHhiMmY4WnBEVnl5bCt4aFZx?=
 =?utf-8?B?K0EzNDVJS0lNcjNVZG5WaVB6Z0Z6RldFYnVHSkFJTjBhcldpUGdFVXo1bjly?=
 =?utf-8?B?OWIyTVdiTE9WZFIyTStkWUN6ZGhnN1JOd0dxb2lxc2VTOTlJWVF3SFg2TXht?=
 =?utf-8?B?MWs3M3lWMnVOVC9Tc1o2cHE5cm5RYXk4UEhDb0tzalkwcGkyaGViRnNjWnFu?=
 =?utf-8?B?ZmVGR1NZQnFCQkgyQzF1Vk1Jdzd1TktkQWoyMy9TSUVqR3BUdm9ZdWR6KzBl?=
 =?utf-8?B?WXlsSWw0d3Bud2VhWERGNXdUc1Y5SFBxYUhic2tpYzJKWnI2NkZrcVZXL0RO?=
 =?utf-8?B?a1hLcXdZSUVmYVZIc0NsSmw5Um5WTDhzTXFzbHVjMks3RnI0L0tKY2tGaEJu?=
 =?utf-8?B?OEZXNGNVSitBS1BWQjkvaHYzRUtZcXBibmNJdUZDTU0xdzFCQjJwWTFTbjN3?=
 =?utf-8?B?TnF5cnVlb3Y1SnFGN3BmZ2c4cUdjZDZxQllKYWpqUll5RTBvRVY4ZDRVdjRm?=
 =?utf-8?B?RXdkRjVneHhjdk1EVEhMaDJrd2xHOGsvU0lBTitwQWR3dHYzZjVWUUVjWDQ1?=
 =?utf-8?B?TFUxY01KMGlhMEo2NlpWL0lyTVdZSkhIOVRQUitLOW5NT1hHb2hnY0ovZGwx?=
 =?utf-8?B?Sm1yY0pxNk0xYU9SdnlPSThMVXZNa2t0TjNuQjlzL1hYQUh3b1pFNU5GRUVK?=
 =?utf-8?B?OWdVTEhDWnJobnJnVytwbzVsNno0dU00S1locG5uUExDR1Vxc3liZmtXbzZp?=
 =?utf-8?B?aXJrcEl1NnRBRW9vanZVVndFUmo0eGlMdVJIalJYZ01hNjNuTFVpcWlYRGl4?=
 =?utf-8?B?L3l5TUtVTnpZVlpQZWp1TDNDZ1phMUF0Vkl2cjI5TWFBZTdmNHQrN3owU1l4?=
 =?utf-8?B?Rlc4UzJXRGxHajd3d3NmZXJSdEtSWnpTK1hvaW80L090UHJTK1VSSjhUMDQ5?=
 =?utf-8?B?L0NCVFZzS21KUDVRSTVBc1RJM1d5K1VjNThmdFNaQUxNcWFUZmx1cTk4Q0lU?=
 =?utf-8?B?Y1VZNWVJeHdPbVY0OUl6SW1CZmllYW03c3hBWjZMd1BtbTlMNUYxREtnL1c3?=
 =?utf-8?B?MFlxblJWNTZ5RTg2RVFzUXV4aHBRVUprRW1mUTliSXcwN3hhREVSRldTMm85?=
 =?utf-8?B?b24zTWNKaHVxOFJ5emJveWlMUEVaVTJpdHJpNDIrYmJ2cHYzdUYvN0c0MHV4?=
 =?utf-8?B?b0RVc3MwY256eXNIeDhJamNiTGl2UHIxWlRKU2F4aW1DWDVLQWkzTUNTeWZM?=
 =?utf-8?Q?WJxvxM46Wq4da6UuBB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ccc9e3a-684f-48e2-0d44-08de63ad2fc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 05:21:01.4825 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wSBjsIEEVYNDTBZ6o2dHyT80ebB99FbFreeW06+jHy0fNbo7sXe8ZTVOWo9y7Cn/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6727
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
Cg0KSSB0aGluayB5b3UgYXJlIGNvbmZ1c2luZyBjb25jZXB0cy4gSG93IGRvIHlvdSBleHBsYWlu
IHRoZSBFWElUL01BTlVBTCBjYXNlIGFjY29yZGluZyB0byB5b3VyIGxvZ2ljPw0KDQpCZXN0IFJl
Z2FyZHMsDQpLZXZpbg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGF6YXIs
IExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NClNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkgNCwg
MjAyNiAxMjo0OSBQTQ0KVG86IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllhbmcuV2FuZ0BhbWQu
Y29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBEZXVjaGVyLCBBbGV4YW5k
ZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5a
aGFuZ0BhbWQuY29tPjsgRmVuZywgS2VubmV0aCA8S2VubmV0aC5GZW5nQGFtZC5jb20+DQpTdWJq
ZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kL3BtOiBmaXggbWlzc2luZyBoYW5kbGUgUEVSRl9ERVRF
Uk1JTklTTSBsZXZlbCBpbiBzbXUxMyAmIDE0ICYgMTUNCg0KDQoNCk9uIDA0LUZlYi0yNiA5OjM4
IEFNLCBXYW5nLCBZYW5nKEtldmluKSB3cm90ZToNCj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAt
IEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0NCj4NCj4gVGhlIHRlcm0gImludmFsaWQi
IGluIHRoZSBkbWVzZyBsb2cgbWF5IGNhdXNlIGFtYmlndWl0eSBmb3IgY3VzdG9tZXJzLg0KDQpJ
IGRvbid0IHNlZSBhbnl0aGluZyB3cm9uZyB3aXRoIHRoYXQsIGl0IHNheXMgaXQgaXMgbm90IGEg
dmFsaWQgbW9kZSB0aGlzIFNPQy4gU2ltaWxhcmx5LCBtb2RlcyBsaWtlIEFNRF9EUE1fRk9SQ0VE
X0xFVkVMX1BST0ZJTEVfUEVBSywNCkFNRF9EUE1fRk9SQ0VEX0xFVkVMX1BST0ZJTEVfU1RBTkRB
UkQgZXRjLiBhcmUgbm90IHZhbGlkIG9uIEFsZGViYXJhbi4NCg0KPiBUaGUgc29mdHdhcmUtZGVm
aW5lZCBwZXJmb3JtYW5jZSBsZXZlbHMgc2hhbGwgYmUgcHJvcGVybHkgaGFuZGxlZCBieSBhbGwg
cG0gc3dzbXUvcG93ZXJwbGF5IGJhY2tlbmRzLg0KDQpJIGRvbid0IHNlZSBhbnl0aGluZyB3cm9u
ZyBpbiByZXR1cm5pbmcgaW52YWxpZCBmb3Igc29tZXRoaW5nIHdoaWNoIGlzIGRlZmluaXRlbHkg
aW52YWxpZC4NCg0KPiBJbiBhZGRpdGlvbiwgdGhlIGtnZCBpbnRlcmZhY2Ugc2hvdWxkIHByb3Zp
ZGUgYSBjb25zaXN0ZW50IHNldCBvZiBBUElzIHRvIGVuc3VyZSB0aGF0IHVzZXItc3BhY2UgcHJv
Z3JhbXMgKGUuZy4sIGFtZC1zbWkpIGNhbiBpbnZva2UgdGhlc2UgaW50ZXJmYWNlcyB3aXRob3V0
IGlzc3Vlcy4NCj4NCg0KVGhhdCBpcyBtaXNzaW5nIGEgcXVlcnkgaW50ZXJmYWNlIGZvciB2YWxp
ZCBtb2Rlcy4gSXQgZG9lc24ndCBtZWFuIG5vdCByZXR1cm5pbmcgaW52YWxpZCBmb3Igc29tZXRo
aW5nIHRoYXQgaXMgZGVmaW5pdGVseSBpbnZhbGlkLg0KDQpUaGFua3MsDQpMaWpvDQoNCg0KPiBC
ZXN0IFJlZ2FyZHMsDQo+IEtldmluDQo+DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+IFNlbnQ6IFdlZG5lc2Rh
eSwgRmVicnVhcnkgNCwgMjAyNiAxMTo1MiBBTQ0KPiBUbzogV2FuZywgWWFuZyhLZXZpbikgPEtl
dmluWWFuZy5XYW5nQGFtZC5jb20+Ow0KPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K
PiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgWmhh
bmcsIEhhd2tpbmcNCj4gPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IEZlbmcsIEtlbm5ldGggPEtl
bm5ldGguRmVuZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kL3BtOiBm
aXggbWlzc2luZyBoYW5kbGUgUEVSRl9ERVRFUk1JTklTTQ0KPiBsZXZlbCBpbiBzbXUxMyAmIDE0
ICYgMTUNCj4NCj4NCj4NCj4gT24gMDQtRmViLTI2IDk6MTcgQU0sIFlhbmcgV2FuZyB3cm90ZToN
Cj4+IGFkZCBtaXNzaW5nIHBlcmZvcm1hbmNlIGxldmVsIEFNRF9EUE1fRk9SQ0VEX0xFVkVMX1BF
UkZfREVURVJNSU5JU00gaW4gc211MTMsMTQsMTUuDQo+Pg0KPj4ga2VybmVsIGRtZXNnIGxvZzoN
Cj4+IFsxMjE3OTI0LjgxMDUyOF0gYW1kZ3B1IDAwMDA6NDQ6MDAuMDogYW1kZ3B1OiBJbnZhbGlk
IHBlcmZvcm1hbmNlDQo+PiBsZXZlbCA1MTIgWzEyMTc5MjQuODEwNTM3XSBhbWRncHUgMDAwMDo0
NDowMC4wOiBhbWRncHU6IEZhaWxlZCB0byBzZXQNCj4+IHBlcmZvcm1hbmNlIGxldmVsIDUxMg0K
Pj4NCj4+IEZpeGVzOiA2YmU2NDI0Njg0Y2IgKCJkcm0vYW1kL3BtOiBFbmFibGUgcGVyZm9ybWFu
Y2UgZGV0ZXJtaW5pc20gb24NCj4+IGFsZGViYXJhbiIpDQo+Pg0KPg0KPiBEZXRlcm1pbmlzbSBs
ZXZlbCBpcyBvbmx5IGF2YWlsYWJsZSBmb3Igc3BlY2lmaWMgU09Dcywgc28gdGhlIHRoZSBlcnJv
ciBtZXNzYWdlIGlzIHN0aWxsIHZhbGlkLg0KPg0KPiBUaGFua3MsDQo+IExpam8NCj4NCj4+IFNp
Z25lZC1vZmYtYnk6IFlhbmcgV2FuZyA8a2V2aW55YW5nLndhbmdAYW1kLmNvbT4NCj4+IC0tLQ0K
Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzAuYyB8IDEg
Kw0KPj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxNC9zbXVfdjE0XzAuYyB8
IDEgKw0KPj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxNS9zbXVfdjE1XzAu
YyB8IDEgKw0KPj4gICAgMyBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4+DQo+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzAu
Yw0KPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMC5jDQo+
PiBpbmRleCA2M2E2NWVhODAyZmQuLmQxN2Q2Y2Q3MTAyOCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wLmMNCj4+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wLmMNCj4+IEBAIC0xNjU5LDYg
KzE2NTksNyBAQCBpbnQgc211X3YxM18wX3NldF9wZXJmb3JtYW5jZV9sZXZlbChzdHJ1Y3Qgc211
X2NvbnRleHQgKnNtdSwNCj4+ICAgICAgICAgICAgICAgIGJyZWFrOw0KPj4gICAgICAgIGNhc2Ug
QU1EX0RQTV9GT1JDRURfTEVWRUxfTUFOVUFMOg0KPj4gICAgICAgIGNhc2UgQU1EX0RQTV9GT1JD
RURfTEVWRUxfUFJPRklMRV9FWElUOg0KPj4gKyAgICAgY2FzZSBBTURfRFBNX0ZPUkNFRF9MRVZF
TF9QRVJGX0RFVEVSTUlOSVNNOg0KPj4gICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+PiAgICAg
ICAgZGVmYXVsdDoNCj4+ICAgICAgICAgICAgICAgIGRldl9lcnIoYWRldi0+ZGV2LCAiSW52YWxp
ZCBwZXJmb3JtYW5jZSBsZXZlbCAlZFxuIiwNCj4+IGxldmVsKTsgZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTQvc211X3YxNF8wLmMNCj4+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxNC9zbXVfdjE0XzAuYw0KPj4gaW5kZXggN2RjNjY4N2Mz
NjkzLi42OGVjYmEwZDVlMGIgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bt
L3N3c211L3NtdTE0L3NtdV92MTRfMC5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bt
L3N3c211L3NtdTE0L3NtdV92MTRfMC5jDQo+PiBAQCAtMTMyMSw2ICsxMzIxLDcgQEAgaW50IHNt
dV92MTRfMF9zZXRfcGVyZm9ybWFuY2VfbGV2ZWwoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsDQo+
PiAgICAgICAgICAgICAgICBicmVhazsNCj4+ICAgICAgICBjYXNlIEFNRF9EUE1fRk9SQ0VEX0xF
VkVMX01BTlVBTDoNCj4+ICAgICAgICBjYXNlIEFNRF9EUE1fRk9SQ0VEX0xFVkVMX1BST0ZJTEVf
RVhJVDoNCj4+ICsgICAgIGNhc2UgQU1EX0RQTV9GT1JDRURfTEVWRUxfUEVSRl9ERVRFUk1JTklT
TToNCj4+ICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPj4gICAgICAgIGRlZmF1bHQ6DQo+PiAg
ICAgICAgICAgICAgICBkZXZfZXJyKGFkZXYtPmRldiwgIkludmFsaWQgcGVyZm9ybWFuY2UgbGV2
ZWwgJWRcbiIsDQo+PiBsZXZlbCk7IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bt
L3N3c211L3NtdTE1L3NtdV92MTVfMC5jDQo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dz
bXUvc211MTUvc211X3YxNV8wLmMNCj4+IGluZGV4IGEyODU0ZDUyOGJhYi4uMTg2MGJkMGYxMDkx
IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxNS9zbXVf
djE1XzAuYw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxNS9zbXVf
djE1XzAuYw0KPj4gQEAgLTEyMTAsNiArMTIxMCw3IEBAIGludCBzbXVfdjE1XzBfc2V0X3BlcmZv
cm1hbmNlX2xldmVsKHN0cnVjdCBzbXVfY29udGV4dCAqc211LA0KPj4gICAgICAgICAgICAgICAg
YnJlYWs7DQo+PiAgICAgICAgY2FzZSBBTURfRFBNX0ZPUkNFRF9MRVZFTF9NQU5VQUw6DQo+PiAg
ICAgICAgY2FzZSBBTURfRFBNX0ZPUkNFRF9MRVZFTF9QUk9GSUxFX0VYSVQ6DQo+PiArICAgICBj
YXNlIEFNRF9EUE1fRk9SQ0VEX0xFVkVMX1BFUkZfREVURVJNSU5JU006DQo+PiAgICAgICAgICAg
ICAgICByZXR1cm4gMDsNCj4+ICAgICAgICBkZWZhdWx0Og0KPj4gICAgICAgICAgICAgICAgZGV2
X2VycihhZGV2LT5kZXYsICJJbnZhbGlkIHBlcmZvcm1hbmNlIGxldmVsICVkXG4iLA0KPj4gbGV2
ZWwpOw0KPg0KDQo=
