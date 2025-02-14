Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63E8C02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 06:45:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EEBC10E200;
	Fri, 14 Feb 2025 06:45:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jIiT7pUA";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AB3710E200
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 06:45:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGLCLYZc4SMBC/WN5mTufhEqxtXAMhJQ3J8Fbdh0RosLo6rH+KJ48sOE2/Z4XuNE2Q3C7P5+PAP4DANxE1X02G9YBks0OF22XpyoHz4N3VUO8WENMCjBLKtcvpiLpWUhuAmwsg3KOmObIwhmVSDe/oFc0Psmb1ahLxX0aYJX014oDeJ+v+SLr65pxOBXZmTxqfLG2JRMJTmRatChS23ux7Bp6+tvAKKqJyJa9wk5+OgLGHSvru2T2yGn9An9wQlxsTf93A8CLjDCBIpKf8ueid7PqedoBEzITEb92+exccnz91+/cSddh+FdgmoJSxVO7HSb3o+xALsLe01mIzetrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jayxtn+DV2q3Z9u/L7WSYu5+19s+SSGpQgas1k1oOo4=;
 b=SOG6YqKzN7HRDeI6/dBZ7UAjf08PCovJRUuSSYm5zqFEXmoWpVo3My6LXWYpf1jGbsrmIiFj0jUGxoRbl/7xuGZH/+EsH92bb70Wuoj6RpLjeuWZMvgQgcEcpTkU1xunQ1/ORXL2kJ3ipLRuRLe5AwcUM3zVOpz4zslw1oY6Fu0MMRXoIl0vnHVzpO3X881XE1s+T1+7pV552q1UjetMduJv24Crzw5IQOoUyor8PGXcgCJE1ncRXyEv5mBPcW8DbaOwKl3w3btpuN5x3oDBBmT5A/XdoS4UCayiKHU3I6nkXA121CIcqKN9mdx4fSxUP7F2qt5GfHJe4qx+1s2t8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jayxtn+DV2q3Z9u/L7WSYu5+19s+SSGpQgas1k1oOo4=;
 b=jIiT7pUA/eeT9qT8LlaBFnmXR/0NngLB40BIkgeAE3lhWQNzuN8mtsgcyXVVGGIkCy6YwSUhxYvhtcRolRhOdmmj9LrFXyZ3Vu59TR2TMi5Z1Il5XGn0YGGSLGFCARIW6ZrwS3nA0vghwxjflRp8qN48uRNeZ9ia9WZt2w+My3M=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CH3PR12MB8904.namprd12.prod.outlook.com (2603:10b6:610:167::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 06:44:57 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 06:44:57 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kim, Jonathan"
 <Jonathan.Kim@amd.com>, "Zhu, Jiadong" <Jiadong.Zhu@amd.com>, "Prosyak,
 Vitaly" <Vitaly.Prosyak@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Enable per-queue reset support
Thread-Topic: [PATCH 2/2] drm/amdgpu: Enable per-queue reset support
Thread-Index: AQHbfqUgpac7AJfeDkyfVOHaip6rBLNGUNqAgAAJVVA=
Date: Fri, 14 Feb 2025 06:44:57 +0000
Message-ID: <BL1PR12MB51446E8E4C516978889145F0E3FE2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250214055534.3249909-1-jesse.zhang@amd.com>
 <20250214055534.3249909-2-jesse.zhang@amd.com>
 <989be73f-bc25-46a6-bd28-3a2576fdc73f@amd.com>
In-Reply-To: <989be73f-bc25-46a6-bd28-3a2576fdc73f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=5ef3d85f-488a-404b-913d-62f1f5e477c2;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-14T06:43:20Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CH3PR12MB8904:EE_
x-ms-office365-filtering-correlation-id: 31966e47-948e-4d4e-2778-08dd4cc318f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?ZytkTzhtclN1WDQwRCtFWldQWWw1S21hK0JVR09KQVo2alMvVzd0WTFObmQv?=
 =?utf-8?B?ODZQTU1HRWpRbVByenBKZUFBNFZYdkgyUnB5RGtoN2xuTExIOTd2Z2ZqSHRW?=
 =?utf-8?B?eFQ3Nm9YZ3RFVDJWNEd4aWpmdjZOTkQ4anNNWHpZblNldnMvWjk5QnhyRG1K?=
 =?utf-8?B?QkNveXhlYlJEcDVnd01QOFc0K0lMMnI4ZFZvYi9oYnN0NVp0eGVJdGdudmFz?=
 =?utf-8?B?WXRFWklCVStjNEg0MGN1ZWlzcUFERmIxankxQklxMjdoa1UxL285TytYd1I2?=
 =?utf-8?B?STJvQXpuL1RwY21YMXVETVZkZ0w5Y091SitQWHJ3ZWJqWkcxRmNGeWxDemN4?=
 =?utf-8?B?RjR1bzZiRmJYL21yWHppYUw2dTFOSWlBVG4za3JQcmZ5TENtdjRmUmZ2Qkl3?=
 =?utf-8?B?Z25UT3BhdE5PMEVmcGc4QzRoa3lNNEFaQlJiTElXbTJqUER5RmQ2ajlERzVn?=
 =?utf-8?B?dDJFb2dTbFZPVit6OVc3OHdiZHFSaHhxVGVpYzBNaEw0MTZnMlAxZ1F6MTc5?=
 =?utf-8?B?ZkQ3M3ViQzNEcXZJN1NqSWZUNnBzMlJDbWxtOWhqcHpsSllVWW1qbmZLOHBD?=
 =?utf-8?B?dGNwbi9lYlBrRFREMThEdFdrSnZjZFluQWRzZGVmbk5pNU9EVXE5L2NHSWJw?=
 =?utf-8?B?VGRUeVZBbXN0c2VER1YzUnRxUmZQUnpDVWFaYS83Q1NqZTNzSWc5UnIzUVo5?=
 =?utf-8?B?UGhHc0JEaTU0RGJxTnA4OVkwUzdOM25vZkVJVHpjb2lKSm1ya0t0RXoxQUdZ?=
 =?utf-8?B?b0UyWEZubjN4RmVGbGpkQ1VIdlI1NkZDNFJQWXQ0cjZrREJ0RzdpTTVZM2Jv?=
 =?utf-8?B?N0RCYmFRR21VMnBxZXNyVEtTOXY2aHJzaDJ5N0ZOOURIWGxVeUJaQkd5VDdl?=
 =?utf-8?B?RlZVYlF0TFJacFA2Y05lTE5oenNXbDRmSlhtMmlkeUUxcjhuSmJMeTJjWXpW?=
 =?utf-8?B?VElSelNVOEYxOFZPSm9FUFVDUVVhaXNJVFFuK3U0WmRmZmxNL0JqL1B4anBG?=
 =?utf-8?B?YW1Pa3g5QlZVK3A2T0xEMkgzeVBnRmFPbVo0aFVMQ21pcC9vYkEra3dtYWpK?=
 =?utf-8?B?VDlWek9GWlZhM2YzSTR4bEkzamlEZmhvdjkzVCt6K2VzWGxZWmg0dElnc2xt?=
 =?utf-8?B?VWlXaGtIODJJV1VnT2Z0aDd2OGFtVHFVSHU3TzBGeVBwaUk1bWtvK1BITmtm?=
 =?utf-8?B?dk8xL2lEUFg1WEtrY29yRnpwWGxFNlRqVFhESkcxMzd4M3dKbnUxS1RvV1BG?=
 =?utf-8?B?a2VOYk9oaENEU2J4UTBaQ2llL2pxTlFtMU9iYWl6cTJHNHFrMjdFSmRlblZ0?=
 =?utf-8?B?c3NDZFNpbzJxSDdvOGJsd3BTbXFnRXNNS212SXhOV2tTSk55VkJ2RXJrVElU?=
 =?utf-8?B?VitmeXNURGZyemd6VFM5TG50YXpkcEFMOWsxTm9hZTUyMW5Sd0RTVGpOclM2?=
 =?utf-8?B?aUlJTHl0UnJuSW9lOSs4bTIyN2EvN3dmd0IvOEpwQWd2RGtaZ2puem54Sk1H?=
 =?utf-8?B?czY2REVtb3o0QldodGhuckx5a3hlU1EvS0UxaDhlUnZuNDh2Y2RmVXJPcTFh?=
 =?utf-8?B?OWtYd1JpRFVnVXJIMkJJNU1CYVVZUGd2eUVzdzZDT2dpUksrdkZRSlQrWm4r?=
 =?utf-8?B?d0ZlZCtldjRENkVESDcwUGlMWHNaYnk0R1JZTk10Y3QwQXAzRWNtaENDTEcy?=
 =?utf-8?B?VEhabkswMHNOanZ6VEcveGFqOWhIdnVzYzk2cEgyM3RwVzNHbG1Sc0x5RTNj?=
 =?utf-8?B?cjdzL1JHbW1MOG1CQ1Z4cEFreFF6U2c5U3RCbTRSbU1ZejhRK3ZaU3lXTUV2?=
 =?utf-8?B?YWVvaDBuRXZLVW0vYWYwUnA2Qi8wdEhuZkpnY0l3RzdhNUJYWVNNL0lVYzBG?=
 =?utf-8?B?R0JjdmYvRTNXV2dKMlFlaHFwb2ovQ0hVWlJia2VDem05b3dSb2p6d2lTVE5N?=
 =?utf-8?Q?ySpfRd6qz3IV2D/kAkmEJAoXrY/nfNJt?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVhWWXQrYlRpNnU5emJMRWpINTlRWDIwekxEMWF4eCtVdkFmaERSbkZ4K0g2?=
 =?utf-8?B?dFVodm9lbWU5VERDTlRUcWRDdVpVR01hdzdEWkVPTzIxSEhsUE1kanlNWHhh?=
 =?utf-8?B?UnVTMFhXVEdndnU1eEJEZktlSVMxWHF3aWZiNFU4Qi80eVZ5aEFnd203V1FR?=
 =?utf-8?B?bndLSWo1Ym9uWVI0SWpwekJmNzBnTlZLVjBjM012blJ5UFRBZnhFdmw0V0ZF?=
 =?utf-8?B?T3U0bXVSdWhQcG15UzBnSkcyMHNiSDFhT0M3OXhZa2NtT3FYdERPUUZuTThL?=
 =?utf-8?B?R1NHRTFma0dlVkg3V1hNNTBIeVZwS1FMK0RqY0RWbFJkQ1FLWDUxdGppRFB3?=
 =?utf-8?B?ZThMaWRRRVpVUytqSjJpUkFtZGlLQnNLYzVwZ25OQ1RHTThCMFJzdWlnRy9U?=
 =?utf-8?B?RVZMZHEvYmJrcHNJRWh5eUo0cmNpWnB4UzhVTWlacjQzSVoyOTd0QURpR3Ra?=
 =?utf-8?B?VEFtdzRuL1grdlhEdGVDdnhORTlad01hT3Njek5mbGM4N0NmRWwzcFJaZUlH?=
 =?utf-8?B?YmUzVFBQS1duNXZvTkNXcEFPbVIzRHpUQlRubi9OdEcvNUVCUFdiNWFjeEZ0?=
 =?utf-8?B?aVc3cmQxcWYzZXVvbitUWHFiNmlsTlVFVWd5dy9STkRIbmpKWTE2MklhTU1Z?=
 =?utf-8?B?blp5QmNqbHBlZkJRWElrbjBZZjQzQ0VJa3Azajl0Q2tPamZodDlHWmFXOHlq?=
 =?utf-8?B?aHM4dklDbXU4b1JrRmU3cXpRT1ZydlMxVlJGbm1mZklId051OWJvODVrWTNx?=
 =?utf-8?B?MldUTHNJQTJMY1dIbTlGS2tVWHNZT0JmdVVEMS93R2lna2FXNVBqZk9aL0RL?=
 =?utf-8?B?QUY0Z1FnQjFQYTBuZUVDeDE5NlpSSDRaK2Q2MDJDbDJ5WFc2MitLVmNSaGpq?=
 =?utf-8?B?dkw3dWswaXMvZDV6L1Q4Tk0rcXBUVzg0ZmRCVXBmU0MydCtWRXdycjhOc1pP?=
 =?utf-8?B?OFRncHdyUnl1S0ZTN3lLTS9mRm1OQ1dYeCtwV3dLaGlYRW1rNU5zdGxhOWlo?=
 =?utf-8?B?cHRaSU5YUllXbTRjejFNZjVoOWY2ak9VZFAxcHlNNTArdWxyNVhVelEwQUZC?=
 =?utf-8?B?ei80cXo3Y1BkczM0OVhXaU5hYm5XMDhYc0d3T0lHVytsUnROVVNCcnlBamFr?=
 =?utf-8?B?UkxxRjk2cE5uVHRPNmEwNDJWb09sMERSQ1lYanZqRGNiM3BYTEQvTXYyaVkv?=
 =?utf-8?B?UHJHNWQ3MTFyaysyQlpNa0Iwb0hqY29WaktQR0dHajE0cU1UMk04STI3aFNQ?=
 =?utf-8?B?SDRwMFY0cllOd2F2ekFEczZiL1l6ZE1BQ1NMRXc3U0d0ajlsb1o1c2xENUo1?=
 =?utf-8?B?eGxCVEN3OStWdXJnbHp2RVhwZ2NVTUJ1TEg1c3ZlQTZodXFBZUg1ZytZS1ps?=
 =?utf-8?B?TkVKdGExbjQ2ZGcwamNmVHc1SXIvdzViYlVDQWRpZElGS0N3UmQxN1FKaEdF?=
 =?utf-8?B?c2w5S0dZUWFsVHdjT2l4ZUdzTjQ1Sy82bzNOZFVqaVNOci9nVWdVbU9RTVMw?=
 =?utf-8?B?cmxscUJoSEw3cGlGMXVLeWFITFgwK3hzSnZtaXlVcE9YMDg1cWc3Y2duUWgx?=
 =?utf-8?B?ZDI2cFF1NkZIak5VR1hZRXFWem9Od0VPcnFLS29qOU0vYXNPUmlCTEl2QUMz?=
 =?utf-8?B?NTVEcldFMTdKVXN3b3JuT040dGhaUkFXT1I3YVV2TkxMVFBIZllyNG1lcCth?=
 =?utf-8?B?SXVJTDg5MUxxQ0FReTFtNEwxamNESHRTTjFxV0lWMytjaGo5dVRMTEF0YVBD?=
 =?utf-8?B?OVBPS25LbW1KN0FYYktjRUFmZTk4ZXpqRjJQWkM3U0k4YllIL3NsQ1o5ek5B?=
 =?utf-8?B?aThtbFJpeXZRRW1lL2pQMStmSFVlR3k0MU9PQmJ4TVBwNHY2ZzVNVVZOM1ky?=
 =?utf-8?B?UUpzREpqVTl2d3pUNU5YSEE4eUJkTUh2aVp3Rnp5eG9TNER1bzZsWnRJSlNZ?=
 =?utf-8?B?Zy92TDJSMWE4STJIdnFMdyt3T3BQSW1JME9JcmQyVnhpR3RncUZ6dk1QVmk4?=
 =?utf-8?B?RldEVnJRZ3VPdXJZWWdYU2k2L05ZYTlqWldXQUt4WjNLeFo2TzZnNXpseW5t?=
 =?utf-8?B?V2Q2ZVZPNDhId1VNTGtnamRrVzJmS0l1L1VndTIxME1NQm04Qy82bkxQU3h2?=
 =?utf-8?Q?/tFI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31966e47-948e-4d4e-2778-08dd4cc318f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 06:44:57.7462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cC1Wye8285YvAr52abXG9P44m9Z8JMJDl8k/cNssXIt1VzddOYwrQ3tiplPzjVgC874Yh0rOPOjt2ys1YAjoUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8904
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
Cg0KSGkgTGlqbywNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMYXphciwgTGlq
byA8TGlqby5MYXphckBhbWQuY29tPg0KU2VudDogRnJpZGF5LCBGZWJydWFyeSAxNCwgMjAyNSAy
OjEwIFBNDQpUbzogWmhhbmcsIEplc3NlKEppZSkgPEplc3NlLlpoYW5nQGFtZC5jb20+OyBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFu
ZGVyLkRldWNoZXJAYW1kLmNvbT47IEtpbSwgSm9uYXRoYW4gPEpvbmF0aGFuLktpbUBhbWQuY29t
PjsgWmh1LCBKaWFkb25nIDxKaWFkb25nLlpodUBhbWQuY29tPjsgUHJvc3lhaywgVml0YWx5IDxW
aXRhbHkuUHJvc3lha0BhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGRybS9hbWRn
cHU6IEVuYWJsZSBwZXItcXVldWUgcmVzZXQgc3VwcG9ydA0KDQoNCg0KT24gMi8xNC8yMDI1IDEx
OjI1IEFNLCBqZXNzZS56aGFuZ0BhbWQuY29tIHdyb3RlOg0KPiBGcm9tOiAiSmVzc2UuemhhbmdA
YW1kLmNvbSIgPEplc3NlLnpoYW5nQGFtZC5jb20+DQo+DQo+IFRoaXMgcGF0Y2ggdXBkYXRlcyB0
aGUgU0RNQSB2NC40LjIgc29mdHdhcmUgaW5pdGlhbGl6YXRpb24gdG8gZW5hYmxlDQo+IHBlci1x
dWV1ZSByZXNldCBzdXBwb3J0IHdoZW4gdGhlIE1FQyBmaXJtd2FyZSB2ZXJzaW9uIGlzIDB4YjAg
b3INCj4gaGlnaGVyIGFuZCB0aGUgUE1GVyBzdXBwb3J0cyBTRE1BIHJlc2V0Lg0KPg0KPiBUaGUg
Zm9sbG93aW5nIGNoYW5nZXMgYXJlIGluY2x1ZGVkOg0KPiAtIEFkZGVkIGEgY29uZGl0aW9uIHRv
IGNoZWNrIGlmIHRoZSBNRUMgZmlybXdhcmUgdmVyc2lvbiBpcyBhdCBsZWFzdCAweGIwIGFuZCBp
Zg0KPiAgIHRoZSBQTUZXIHN1cHBvcnRzIFNETUEgcmVzZXQgdXNpbmcgYGFtZGdwdV9kcG1fcmVz
ZXRfc2RtYV9pc19zdXBwb3J0ZWRgLg0KPiAtIElmIGJvdGggY29uZGl0aW9ucyBhcmUgbWV0LCB0
aGUgYEFNREdQVV9SRVNFVF9UWVBFX1BFUl9RVUVVRWAgZmxhZyBpcyBzZXQgaW4NCj4gICBgYWRl
di0+c2RtYS5zdXBwb3J0ZWRfcmVzZXRgLg0KPg0KPiBTdWdnZXN0ZWQtYnk6IEpvbmF0aGFuIEtp
bSA8Sm9uYXRoYW4uS2ltQGFtZC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFZpdGFseSBQcm9zeWFr
IDx2aXRhbHkucHJvc3lha0BhbWQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKZXNzZSBaaGFuZyA8
amVzc2UuemhhbmdAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9zZG1hX3Y0XzRfMi5jIHwgMyArKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3NkbWFfdjRfNF8yLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1h
X3Y0XzRfMi5jDQo+IGluZGV4IGIyNGExZmY1ZDc0My4uZTAxZDk3Yjk2NjU1IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzRfMi5jDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfNF8yLmMNCj4gQEAgLTE0ODEsOSArMTQ4
MSwxMCBAQCBzdGF0aWMgaW50IHNkbWFfdjRfNF8yX3N3X2luaXQoc3RydWN0IGFtZGdwdV9pcF9i
bG9jayAqaXBfYmxvY2spDQo+ICAgICAgICAgICAgICAgfQ0KPiAgICAgICB9DQo+DQo+IC0gICAg
IC8qIFRPRE86IEFkZCBxdWV1ZSByZXNldCBtYXNrIHdoZW4gRlcgZnVsbHkgc3VwcG9ydHMgaXQg
Ki8NCj4gICAgICAgYWRldi0+c2RtYS5zdXBwb3J0ZWRfcmVzZXQgPQ0KPiAgICAgICAgICAgICAg
IGFtZGdwdV9nZXRfc29mdF9mdWxsX3Jlc2V0X21hc2soJmFkZXYtPnNkbWEuaW5zdGFuY2VbMF0u
cmluZyk7DQo+ICsgICAgIGlmIChhZGV2LT5nZngubWVjX2Z3X3ZlcnNpb24gPj0gMHhiMCAmJiBh
bWRncHVfZHBtX3Jlc2V0X3NkbWFfaXNfc3VwcG9ydGVkKGFkZXYpKQ0KPiArICAgICAgICAgICAg
IGFkZXYtPnNkbWEuc3VwcG9ydGVkX3Jlc2V0IHw9IEFNREdQVV9SRVNFVF9UWVBFX1BFUl9RVUVV
RTsNCg0KVGhpcyBmdW5jdGlvbiBpcyByZXVzZWQgYWNyb3NzIG11bHRpcGxlIElQIHZlcnNpb25z
LiBNRUMgZncgdmVyc2lvbnMgYXJlbid0IHRoZSBzYW1lIGFjcm9zcyB0aG9zZSBJUCB2ZXJzaW9u
cy4NCg0KSW4gZmFjdCwgdGhlIHVzZXIgcXVldWUgcmVsaWVzIG9uIE1FQyBmdyBhbmQgcG1mdyB3
aGVuIHRoZSBzZG1hIHF1ZXVlIGRvIHJlc2V0Lg0KU28gd2UgbmVlZCB0byBjaGVjayBib3RoIG9m
IHRoZW0gYXQgaGVyZSAgdG8gc2tpcCBvbGQgbWVjIGFuZCBwbWZ3Lg0KDQpUaGFua3MNCkplc3Nl
DQoNClRoYW5rcywNCkxpam8NCg0KPg0KPiAgICAgICBpZiAoYW1kZ3B1X3NkbWFfcmFzX3N3X2lu
aXQoYWRldikpIHsNCj4gICAgICAgICAgICAgICBkZXZfZXJyKGFkZXYtPmRldiwgImZhaWwgdG8g
aW5pdGlhbGl6ZSBzZG1hIHJhcyBibG9ja1xuIik7DQoNCg==
