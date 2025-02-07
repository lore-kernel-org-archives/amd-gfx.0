Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D812FC02196
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 09:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52E8C10E1DC;
	Fri,  7 Feb 2025 09:29:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="utoHkkYN";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0960E10EA81
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 09:25:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euwrI3LajFpOv360kdmq3iy/eHpqHzJhU7r5gvXpt9TM+06f0IluK8hA2ZxtoIckSM4+79WVwlptiIG7R4DOyMm7MnXp9cDRIHN054uAh6GlmcFNgZFEv0/0YcmgMFBhM9D1mD0Ky00NzbzYbsDWkPxMtZ6v5vDBQb+ha4+OhBLF4Gwjgli/+cZhERBsm4iMkOVFxMmk741yPq1Vo6ynxj/ko3KoHpGuNR50M8+fnFW8hfBshKHmfwZh+bMz4o1yIv+WJoQMsFgG9J/LRWw+qqb0hDTRkT/vuKTc/RuWGFDfiYFRTGAPcugFdwkCdsnWcOudupvvqBxlMMKqp/g4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twxLFuZCrzwrW65dwY5DIKUt1WpBs9ap30mzRoX+8r4=;
 b=El25YPfyuJCBDel54pdvcqLvbTYZbGCL20QhnzJnHpNm0JzClxCbtUkw1cSmksnN75AGV/2rRVXGrrc6u5OQEcez7re1BDQe6dz+YEQjZs/gXr2ZWrhkSB06x+/8COWvCzJDgxPXd0MAnKS8yk4yiFJnyE0uHfJM/lLpbSsYlZN0wqZ/ru0zM/URHxL7BA735/ZHpHj9c7/ysiamW50GY4LNPwHNtM2p/u9VHVtsQ9uxT5M74jxBu5ztG+bffM3Qf944VeFxNFnAtY2Ms19O9aIg5tqCBIzZZpZbfer2MYe8UgmGZ3Tdr31Orp+yj1IZ6XIkM9xgraERJntyByoETQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twxLFuZCrzwrW65dwY5DIKUt1WpBs9ap30mzRoX+8r4=;
 b=utoHkkYNDI2y2QUtrjbqzhiSXgMAI3b2AcXomIOlLenwZxlFw75RwGNCNbA5VphT/AByfRr6Y8Er211bH3e/9LlPRk+e9L6WOXIxF2AHuvSZ2olK38Ir5VtWJOlkBVyekeWKdNDTLb31nW3nmYDB9V9OHVw1v+jDMVHqquEaPFA=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SA1PR12MB5640.namprd12.prod.outlook.com (2603:10b6:806:23e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Fri, 7 Feb
 2025 09:25:48 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.8398.021; Fri, 7 Feb 2025
 09:25:47 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "cao, lin"
 <lin.cao@amd.com>, "Chen, JingWen (Wayne)" <JingWen.Chen2@amd.com>, "Liu,
 Shaoyun" <Shaoyun.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu/mes: Add cleaner shader fence address handling
 in MES for GFX11
Thread-Topic: [PATCH] drm/amdgpu/mes: Add cleaner shader fence address
 handling in MES for GFX11
Thread-Index: AQHbeUD4NWXzaWIr90+ZsWWbpxUba7M7kCqw
Date: Fri, 7 Feb 2025 09:25:47 +0000
Message-ID: <PH7PR12MB5997944BE641E92602AD492982F12@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250207091548.1096804-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250207091548.1096804-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b1c705da-0c90-4301-9731-b01820d95136;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-07T09:19:06Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SA1PR12MB5640:EE_
x-ms-office365-filtering-correlation-id: ead828a2-bbe8-4f37-0b32-08dd475967db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?MWp2TllmdWJmUm9kOUw5R0ZGenVRYnNHSlhCeDJvVE1icG1pVXYzMENTMmky?=
 =?utf-8?B?VXFiQ3ZLZC9vdHhjL0xYeUtWeUZJZHJjL2ROOEtGVXJxcE1XcE5VbWhtWFg0?=
 =?utf-8?B?S0RIN05OcWVqZXJLVE9iRnBoTEdhUXFocmVVa1ArUUVjYldqYkF4ZWJPNVBQ?=
 =?utf-8?B?Zm9ZVUVSLzVYVTE4cWtaR2w3T3NkbGwxQXFTZjV4N1UyZm5WZ2s4bmZxWEJW?=
 =?utf-8?B?RmRYYUI2Y0F1TVZjRGx2VTkrbjFXN2o5NkU2eEN5N2c0WkhMMi8xOGZ4ZEhZ?=
 =?utf-8?B?djBkc0lNRjIrZlFCWXd2bWVhQ0NlL2M0d29VTnI5Qm5LT3dHelhlbnhTV0xD?=
 =?utf-8?B?THF5a1U3bWhZVERGUkpCNVloOTZSQzVhL2xEQlQ3NHJ6cDhqclZscnZ3S3Bk?=
 =?utf-8?B?NG9ubjB4N3B4dmgybnlIZkNtRGErME9xR2ZpK1pIb3BnWjV1NWRDNGpZdFhO?=
 =?utf-8?B?L0dzMlU1RjQvVVN4RjhmTGZySFNUOXFUWFowN3RKUDg2cXlCM3FKR1R2MHlk?=
 =?utf-8?B?ZlBFS1dydHgzY2Fta3NxbGlDOHFSaU9yMWMxUEVySDJMd2Z5R1BJV0NkMlNr?=
 =?utf-8?B?ZTJGaVNzZzUwa2dPelRUNVNhYTY1elgwRkp4NFRaWnU3QWJiOTVZNjhOb0Js?=
 =?utf-8?B?Q25mRlVWb1oxZVRmcDFDWnF4NkRnZ3hZU2RsN29rK1VXWkd4MjBJSkp0bktD?=
 =?utf-8?B?NXE0ZzU5Y0xHbnErWGpiYngvWURFMjBTdVpkdC9jNXFZS1JiUmlqOVVDUXUw?=
 =?utf-8?B?dy9VWTBPcTVPSkx1Wm4walAxb1N0dlpIL0RBNXZQT2NlTUJVRklwSEt5N3BG?=
 =?utf-8?B?US9FSXhMQTFvU3U3akNvZFVGYXZXT2VrQmNiL1pDQ2kwNGwya3dORGg1SUxS?=
 =?utf-8?B?SVBZNDNHQjk4dzluUVZiTkNvVmRuTDFHc0RIR3M5elVGMVlIYlJjcTZDVERR?=
 =?utf-8?B?c3B5SlFzbjMrNys5RlFQMXhoOEl0VDYrS0VkZmFBOWtJR21Da091ckYyMXBv?=
 =?utf-8?B?ODM4UFRKajAwMGViOVFVbHUxMXpEby8wSFU4SUZ6WFVpaE9xS21QU0lIcVpH?=
 =?utf-8?B?S1BheVpoMWtVbVNVeXVDeTRzMjQxYTlQZlJIdXhuQVBDZmNxTk5rNzhJRjhK?=
 =?utf-8?B?UHk4L1VwY1NBUTZKZUNPU3hFK3VtOXBIY29MRXhZNWZLN3pXanY2Sm15T3BF?=
 =?utf-8?B?alpmcldMZHBXK2NPT0NSMmsxM1lsdHd0c0xQbXdiYmljRmZOSHQzWWtIWEgy?=
 =?utf-8?B?eXBydnRWTHB4Y0s3dmtvNStETWRlbkVmNTFpU003eUNlWTk0bXJaRitkR2g4?=
 =?utf-8?B?aENpMWcrMmRpTGhocytBSnN6eWxuRXhJaDM4dHMwT0M5a1ZHVXRzRTdPd3E4?=
 =?utf-8?B?akdTN0QySW5mdHY3YUNXekxGMDJUcEJFbWk3eitReUd5eFFkYjBtekxSb1gz?=
 =?utf-8?B?bXZ6eFc3cFdycDJQd09wTDg4ZVVKaHA3VHh4ODFKbGZJMFphLzFDWVMwL1pZ?=
 =?utf-8?B?Q3BjRFFTMTJqR3ZTcE03TzUxRkZnWUM5Z3o0YlVacUpMU282SERqVU9WV1Na?=
 =?utf-8?B?M1lQanR6WlM2ek96bmR2c1N5aVdkRE5YL1FKVEwwczVBVHE2dDhKcXZoU1FR?=
 =?utf-8?B?eXJ6MERoTmtJbVRldmhXQjMyNHVIMFNRcVVXbytyVVQ1VFB4d2pGQy9lUHZY?=
 =?utf-8?B?cGFnNzZFRk51em54MnVMRnk0SWNENkY1R2pKR0hSSG0xQ2pwWmZZejVyYkF1?=
 =?utf-8?B?OUN3ak5ycC9MdG9lWGN1UUNYR2NKUmppUEZsVklkVGU0RitYU01QbkZITVZV?=
 =?utf-8?B?TFRJYjArYkcwMlRyalpXblNkM3VQL2hkc2sxOVpjTUpKcjNUbEY0aUNVTjk4?=
 =?utf-8?B?NklxVzgzRW9PM3VjT2ZOOVI2K2pyaUEzd0pZZElobjhRckFPUDFsZnR4V3R5?=
 =?utf-8?Q?XxoAXWioGNHD7mqlAqe2iuY84FXcA0t7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vi91WG9Ea2N2SnpLUGJ1MDdMMTV6a0ticjI2aVh2ejg2cXRNMThXdFU0ZGpt?=
 =?utf-8?B?V2VXenhSUTNqMTFLeTlVNEYweTcrOXp5bTdZUm1pYkFqY2ptNG1lQVIrNVdK?=
 =?utf-8?B?TDVFcTlNOXZvaXFhNHlISmg4Q0xibEdWV0pFZXMzaURzTzdVbW9GZzdlbjZx?=
 =?utf-8?B?RVNJZEN2NnNYQUtwem5HQkJRdGFIT00vdEdOZUplV0wwdzBZZDNrMHdaY25w?=
 =?utf-8?B?LzkzNjJEekhnYmZoQ3J2UFZ3b2xSQ3RJNXhGY0ZqaGc2OU43a0x5UDNBa0Fw?=
 =?utf-8?B?TTkvdyt4dVNneS9GSXA0Z01ZSjBYMXU3Rmp3K3hhOFJYQUt1OHpTTW4za1Fr?=
 =?utf-8?B?cTFNakpjV0xXZHQ3Tlp3ajc0cTJucTZMMDdvalhETmVuUGNQTmNua01BSmFG?=
 =?utf-8?B?Q2xXWjN2WVFQeWtFQXkzeGl2aWgwSktvckgvazBrcmdsQXY5cFZ5MnZwRDZO?=
 =?utf-8?B?QTJxTCtWWUdpbFlILzltTk41ci9TRDJpeDh0T0t3YzBEYk5WMitqV2NndVMv?=
 =?utf-8?B?QkRjc0duODl0SlZ1TGxwd0NFeXhOeFVmcGswWlRCMVhDd3YxTUlnSjB4RXdP?=
 =?utf-8?B?YlFyRHBxOE9scVlIQXJ6VkRrUzFRUFQ4ODU1RnZlODd5dTlISGpvQnE2V1Js?=
 =?utf-8?B?enFHbU9pMjlLakN1eDhDVnFUSzlqTEcxaEIwaFN4OXVnSUhRWHc3ZTY1YVlE?=
 =?utf-8?B?aFpFOUZtWnVVYTdBOENoQnk3dTBELzJRd3RkZ1QvWmQxL3hIYjl4SjdYa25Q?=
 =?utf-8?B?QmJNdVdhaE9kcThhVC9EbENxSUdDcFpYNFNCSzcxd3NpSE5BVHVURHlKUFlO?=
 =?utf-8?B?UXZyWHFzRWE1eVYxKzlMZWVBQlExa3p1OU5YTGpCN2FFYnFWbE1TVXZXSVdP?=
 =?utf-8?B?TUxIZ29HZDZBa3kxcUVxN1NJN3ErQ2tHdXpRTzdUMTVCdTMvTTJFVlovRVZH?=
 =?utf-8?B?YXhoU2hqTFE5UjNicW5SWW5vNFE4bXV1d0QyNG5TOVNDNm1mVDl4NTdKRll1?=
 =?utf-8?B?amdkcHNabXYyemdLUjZaVEtFR2dqbXhXanlXdy9SV0VFQ1ZrRFBLUm13R3lu?=
 =?utf-8?B?UXR4ZVlDTnBMZklYSGdCSjBEYmI2c001Rkd3Ly9XYWlacGF0czh4Wll2cXVO?=
 =?utf-8?B?VVBpcDdmLzd4YnRieGZzbXg3bVVNbWgxMVVQWG1qZGtwekVGbFBkampBdXlS?=
 =?utf-8?B?cGFMV0kxVHA5YnAzbTkrZ3BNQ0cvRFJ3SnFJclJSYW9FMjQ1NjNYdStJZGUv?=
 =?utf-8?B?dUptbE12UHRqMHJNWWIwbzhSQXZPMDkvaFZ4Tzh2TGtlNGtDN1lUd3MxM1dI?=
 =?utf-8?B?NWNGZWhldFloSkQ1Y05Ma3hIcjB1SDZLd3E4UHQvUHp6UjdmTFV1Y1V2dnpp?=
 =?utf-8?B?eTVCK0JqOVpXa0tRblc0SzBpTjBMYjYwcStLa2ZXaDgxaTNqeFhCdVZocE5y?=
 =?utf-8?B?Q2VtY3ViSjc4d0VjeUhiQ2JHZmhFM3VTNFRneFVCYkN5VTZvdEFBVmNqMXQ2?=
 =?utf-8?B?UC9qVnJkS3J0OHcwaEZVenBtelBCd3FiSENOUUk0WXJNWks3cTUxMFRvdlVn?=
 =?utf-8?B?UksvNlZYOE9lM01PQzRaY0hna25BaTFWK2xiSnROSWlDVnduejRHL0NWalZU?=
 =?utf-8?B?S3V3N09tS3I0V0tnNW1jVWlkbklNdGY3cW5VdWY3SnliQXcvTkEwWE1hOTdJ?=
 =?utf-8?B?Ym52cUtxZFFibFJDWUZVWGFPcGo2bW9aRVZqYm9MOTFBcDVvYjg4RC8vMkZk?=
 =?utf-8?B?MU5udU8wa0dmeU1KajM2NUJvbmc4YUJuVEhXZmt5T3ZsZ1VZcER5VzNEUHBG?=
 =?utf-8?B?VHlBOEpSeXVaeUhTWXcwdHVMT2pNUGsyRjVUckVacVVZNmRqekxJSnQyenll?=
 =?utf-8?B?SHo1ZXplWDZ0dzNidS9TNFl4bFNyUzJNaW1uMkFTV05MV29NV2o3Tm5laHBm?=
 =?utf-8?B?djFWa3l3cDJqK051NTZGTXQyN0xBR3B3M01MV3NtSW5ZS2FDTzNBTEpVSGNK?=
 =?utf-8?B?RXJlMzBPQjV2WmZpdlhoQ3ZKWXFqNVA2L0pKYU5aWU8vdmc3RkdzcS91MGNt?=
 =?utf-8?B?ZjhhcEJ5L0FwNFJ3NEU2WFdrL0RsbWpkWEtqRFRjNXBFaHZkVjRoSUpnVktG?=
 =?utf-8?Q?05E8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead828a2-bbe8-4f37-0b32-08dd475967db
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 09:25:47.5997 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7mdwHuT0XWxS9DWUKE+Oe46lGYRaqbpMPeeYbSaq/EcCPDBjhmfERxiZK4k5pElA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5640
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
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91
bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBTcmluaXZhc2FuIFNoYW5t
dWdhbQ0KU2VudDogRnJpZGF5LCBGZWJydWFyeSA3LCAyMDI1IDE3OjE2DQpUbzogS29lbmlnLCBD
aHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8
QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZzsgU0hBTk1VR0FNLCBTUklOSVZBU0FOIDxTUklOSVZBU0FOLlNIQU5NVUdBTUBhbWQuY29t
PjsgY2FvLCBsaW4gPGxpbi5jYW9AYW1kLmNvbT47IENoZW4sIEppbmdXZW4gKFdheW5lKSA8Smlu
Z1dlbi5DaGVuMkBhbWQuY29tPjsgTGl1LCBTaGFveXVuIDxTaGFveXVuLkxpdUBhbWQuY29tPg0K
U3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1L21lczogQWRkIGNsZWFuZXIgc2hhZGVyIGZlbmNl
IGFkZHJlc3MgaGFuZGxpbmcgaW4gTUVTIGZvciBHRlgxMQ0KDQpUaGlzIGNvbW1pdCBpbnRyb2R1
Y2VzIGVuaGFuY2VtZW50cyB0byB0aGUgaGFuZGxpbmcgb2YgdGhlIGNsZWFuZXIgc2hhZGVyIGZl
bmNlIGluIHRoZSBBTURHUFUgTUVTIGRyaXZlcjoNCg0KLSBUaGUgTUVTIChNaWNyb2NvZGUgRXhl
Y3V0aW9uIFNjaGVkdWxlcikgbm93IHNlbmRzIGEgUE00IHBhY2tldCB0byB0aGUNCiAgS0lRIChL
ZXJuZWwgSW50ZXJmYWNlIFF1ZXVlKSB0byByZXF1ZXN0IHRoZSBjbGVhbmVyIHNoYWRlciwgZW5z
dXJpbmcNCiAgdGhhdCByZXF1ZXN0cyBhcmUgaGFuZGxlZCBpbiBhIGNvbnRyb2xsZWQgbWFubmVy
IGFuZCBhdm9pZGluZyB0aGUNCiAgcmFjZSBjb25kaXRpb25zLg0KLSBUaGUgQ1AgKENvbXB1dGUg
UHJvY2Vzc29yKSBmaXJtd2FyZSBoYXMgYmVlbiB1cGRhdGVkIHRvIHVzZSBhIHByaXZhdGUNCiAg
YnVzIGZvciBhY2Nlc3Npbmcgc3BlY2lmaWMgcmVnaXN0ZXJzLCBhdm9pZGluZyB1bm5lY2Vzc2Fy
eSBvcGVyYXRpb25zDQogIHRoYXQgY291bGQgbGVhZCB0byBpc3N1ZXMgaW4gVkYgKFZpcnR1YWwg
RnVuY3Rpb24pIG1vZGUuDQotIFRoZSBjbGVhbmVyIHNoYWRlciBmZW5jZSBtZW1vcnkgYWRkcmVz
cyBpcyBub3cgc2V0IGNvcnJlY3RseSBpbiB0aGUNCiAgYG1lc19zZXRfaHdfcmVzX3BrdGAgc3Ry
dWN0dXJlLCBhbGxvd2luZyBmb3IgcHJvcGVyIHN5bmNocm9uaXphdGlvbiBvZg0KICB0aGUgY2xl
YW5lciBzaGFkZXIgZXhlY3V0aW9uLiBUaGlzIGlzIGRvbmUgYnkgY2FsY3VsYXRpbmcgdGhlIGFk
ZHJlc3MNCiAgdXNpbmcgdGhlIHdyaXRlLWJhY2sgbWVtb3J5IGJhc2UgYWRkcmVzcyBhbmQgdGhl
IGNsZWFuZXIgZmVuY2Ugb2Zmc2V0Lg0KDQotICoqTWVtb3J5IE9mZnNldCBSZXRyaWV2YWwqKjog
VGhlIGxpbmUgYHJldCA9DQogIGFtZGdwdV9kZXZpY2Vfd2JfZ2V0KGFkZXYsICZjbGVhbmVyX2Zl
bmNlX29mZnNldCk7YCByZXRyaWV2ZXMgdGhlDQogIG9mZnNldCBmb3IgdGhlIGNsZWFuZXIgc2hh
ZGVyIGZlbmNlIGZyb20gdGhlIHdyaXRlLWJhY2sgKFdCKSBtZW1vcnkuDQogIFRoaXMgaXMgaW1w
b3J0YW50IGZvciBlbnN1cmluZyB0aGF0IHRoZSBjbGVhbmVyIHNoYWRlciBjYW4gc3luY2hyb25p
emUNCiAgaXRzIGV4ZWN1dGlvbiBwcm9wZXJseSwgYXMgdGhlIG9mZnNldCBpcyBuZWNlc3Nhcnkg
dG8gY2FsY3VsYXRlIHRoZQ0KICBleGFjdCBtZW1vcnkgYWRkcmVzcyB3aGVyZSB0aGUgZmVuY2Ug
d2lsbCBiZSBsb2NhdGVkLg0KDQotICoqU2V0dGluZyBDbGVhbmVyIFNoYWRlciBGZW5jZSBBZGRy
ZXNzKio6IFRoZSBsaW5lDQogIGBtZXNfc2V0X2h3X3Jlc19wa3QuY2xlYW5lcl9zaGFkZXJfZmVu
Y2VfbWNfYWRkciA9IGFkZXYtPndiLmdwdV9hZGRyICsNCiAgKGNsZWFuZXJfZmVuY2Vfb2Zmc2V0
ICogNCk7YCBzZXRzIHRoZSBtZW1vcnkgYWRkcmVzcyBmb3IgdGhlIGNsZWFuZXINCiAgc2hhZGVy
IGZlbmNlIGluIHRoZSBgbWVzX3NldF9od19yZXNfcGt0YCBzdHJ1Y3R1cmUuIFRoaXMgYWRkcmVz
cyBpcw0KICBjYWxjdWxhdGVkIGJ5IGFkZGluZyB0aGUgYmFzZSBHUFUgYWRkcmVzcyBvZiB0aGUg
d3JpdGUtYmFjayBtZW1vcnkgdG8NCiAgdGhlIGNhbGN1bGF0ZWQgb2Zmc2V0LiBCeSBzZXR0aW5n
IHRoaXMgYWRkcmVzcywgdGhlIE1FUyAoTWljcm9jb2RlDQogIEV4ZWN1dGlvbiBTY2hlZHVsZXIp
IGtub3dzIHdoZXJlIHRvIGNoZWNrIGZvciBzeW5jaHJvbml6YXRpb24gcmVsYXRlZA0KICB0byB0
aGUgY2xlYW5lciBzaGFkZXIsIGVuc3VyaW5nIHRoYXQgaXQgb3BlcmF0ZXMgY29ycmVjdGx5IGFu
ZCB0aGF0DQogIHRoZSBHUFUgaXMgaW4gYSBzdGFibGUgc3RhdGUgYmVmb3JlIGV4ZWN1dGluZyBu
ZXcgdGFza3MuDQoNCkNjOiBsaW4gY2FvIDxsaW4uY2FvQGFtZC5jb20+DQpDYzogSmluZ3dlbiBD
aGVuIDxKaW5nd2VuLkNoZW4yQGFtZC5jb20+DQpDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPg0KQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJA
YW1kLmNvbT4NClN1Z2dlc3RlZC1ieTogU2hhb3l1biBMaXUgPHNoYW95dW4ubGl1QGFtZC5jb20+
DQpTaWduZWQtb2ZmLWJ5OiBTcmluaXZhc2FuIFNoYW5tdWdhbSA8c3Jpbml2YXNhbi5zaGFubXVn
YW1AYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192MTFfMC5j
IHwgNiArKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdjExXzAuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L21lc192MTFfMC5jDQppbmRleCBiZjUxZjNkY2MxMzAuLmQ4ZTk5MmM0
YWRlYiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192MTFfMC5j
DQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdjExXzAuYw0KQEAgLTc0NSwx
NCArNzQ1LDIwIEBAIHN0YXRpYyBpbnQgbWVzX3YxMV8wX3NldF9od19yZXNvdXJjZXNfMShzdHJ1
Y3QgYW1kZ3B1X21lcyAqbWVzKSAgew0KICAgICAgICBpbnQgc2l6ZSA9IDEyOCAqIFBBR0VfU0la
RTsNCiAgICAgICAgaW50IHJldCA9IDA7DQorICAgICAgIHUzMiBjbGVhbmVyX2ZlbmNlX29mZnNl
dDsNCiAgICAgICAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBtZXMtPmFkZXY7DQogICAg
ICAgIHVuaW9uIE1FU0FQSV9TRVRfSFdfUkVTT1VSQ0VTXzEgbWVzX3NldF9od19yZXNfcGt0Ow0K
ICAgICAgICBtZW1zZXQoJm1lc19zZXRfaHdfcmVzX3BrdCwgMCwgc2l6ZW9mKG1lc19zZXRfaHdf
cmVzX3BrdCkpOw0KDQorICAgICAgIHJldCA9IGFtZGdwdV9kZXZpY2Vfd2JfZ2V0KGFkZXYsICZj
bGVhbmVyX2ZlbmNlX29mZnNldCk7DQorICAgICAgIGlmIChyZXQpDQorICAgICAgICAgICAgICAg
cmV0dXJuIHJldDsNCiAgICAgICAgbWVzX3NldF9od19yZXNfcGt0LmhlYWRlci50eXBlID0gTUVT
X0FQSV9UWVBFX1NDSEVEVUxFUjsNCiAgICAgICAgbWVzX3NldF9od19yZXNfcGt0LmhlYWRlci5v
cGNvZGUgPSBNRVNfU0NIX0FQSV9TRVRfSFdfUlNSQ18xOw0KICAgICAgICBtZXNfc2V0X2h3X3Jl
c19wa3QuaGVhZGVyLmR3c2l6ZSA9IEFQSV9GUkFNRV9TSVpFX0lOX0RXT1JEUzsNCiAgICAgICAg
bWVzX3NldF9od19yZXNfcGt0LmVuYWJsZV9tZXNfaW5mb19jdHggPSAxOw0KKyAgICAgICBtZXNf
c2V0X2h3X3Jlc19wa3QuY2xlYW5lcl9zaGFkZXJfZmVuY2VfbWNfYWRkciA9IGFkZXYtPndiLmdw
dV9hZGRyICsNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAoY2xlYW5lcl9mZW5jZV9vZmZzZXQgKiA0KTsNCltrZXZpbl06DQpUaGUgbWVz
X3YxMV8wX3NldF9od19yZXNvdXJjZXNfMSgpIGZ1bmN0aW9uIHdpbGwgYmUgY2FsbGVkIGR1cmlu
ZyBkcml2ZXIgc3VzcGVuZC9yZXN1bWUgc3RhZ2U6IG1lc192MTFfMF9yZXN1bWUoKSAtPiBtZXNf
djExXzBfaHdfaW5pdCgpIC0+IG1lc192MTFfMF9zZXRfaHdfcmVzb3VyY2VzXzEoKS4NCkluIGFi
b3ZlIGNhc2UsIHRoZSBjb2RlIHNlZW1zIGludHJvZHVjZSBhIG5ldyBtZW1vcnkgbGVhayBpc3N1
ZSB3aGVuIGNhbGwgZnVuY3Rpb24gYW1kZ3B1X2RldmljZV93Yl9nZXQoKSwgYW5kIG5vIHBsYWNl
IHRvIGNhbGwgZnVuY3Rpb24gYW1kZ3B1X2RldmljZV93Yl9wdXQoKSB0byByZWxlYXNlIGl0Lg0K
UGxlYXNlIGRvdWJsZSBjaGVjay4NCg0KQmVzdCBSZWdhcmRzLA0KS2V2aW4NCg0KDQogICAgICAg
IHJldCA9IGFtZGdwdV9ib19jcmVhdGVfa2VybmVsKGFkZXYsIHNpemUsIFBBR0VfU0laRSwNCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQU1ER1BVX0dFTV9ET01BSU5fVlJBTSwNCi0t
DQoyLjM0LjENCg0K
