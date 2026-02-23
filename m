Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1716E98DEC
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 06:44:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9909B10E240;
	Mon, 23 Feb 2026 06:44:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="myf107pL";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011008.outbound.protection.outlook.com
 [40.93.194.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C187610E240
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Feb 2026 06:44:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEspOw2isajPdPGHwKN35N08anIdhhdQK/EB3kEl4RJaLrZKg+lMVpSHFp+U6pNtME1IafpGXDKAHdCAIUrz9rKKRXMN3y0GGE6hQnZ3x2n6APBdEpejyF3uRrd6vhMdkFDGeFLvaQ4B1dtoiq5PsIFS6POFtmRUb5v15mSu4PrBfkViU6cvBRPgAhHC2uQQDiYgScGt2zyWMS2SQjWMsCREgrDU775y6r5fQzR/gbKn9XOcRrZF4ITg/F+AfdmZRYxF5QNse1vhoy7hR7r48ATyXqfOmztbrWP7PQnbMoAH7maaeBBk2BcKQv4XuKrhA28dHXIvRNNSW7NWBrHPSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLzO/Vvprm7Q4ehjzfbBCEoS+AE/HlQGzHviUxCOXDs=;
 b=a5d9QpwFWjKzZajLTn6FM9z/mEfWnbUkQM/rdTlOEzyE5d/nZcB20OZ3+EoOWr1g74Az5BE8iWXV/FMjon2iwROVfL0NSgtxim4yv30DwiSaqQ67K3feNKAVbpLie+QdzZ8CkY5w2T9ES9QaDOtcOiiLpa5HPmBlAPjv+Pb+qb24uSSO8UlXA+Om02YCvFwMlDKm43siwIpdh9j/BqkO8onSMMxeAYMqn8xcHcXQSQS1rvN8tLUkHdZdV060S82eA+RD9psjNgHKw4bipxyeMCT6gTfqcMExosXHA1/lKt0vxLvXv4DqEnaVAj67z/KTAODaI1h4GtqKJTqLEL9VCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLzO/Vvprm7Q4ehjzfbBCEoS+AE/HlQGzHviUxCOXDs=;
 b=myf107pLCWP3+QP2oPVXtLD7C0S5NVmYlJYeOWmDSM0k0XSLQzlY5xr1fFzZTHetcC2x3l4HAPf6VaBhB5CNCmkwkzw0zCFzcjCqYF4TKuA0KkqAdA++YdXcZ/Bjr2qyGKSfdaQec1UJVYUWhrhX33n2Nzd785xZL+OpZmn52fM=
Received: from SJ0PR12MB8165.namprd12.prod.outlook.com (2603:10b6:a03:4e4::6)
 by MW4PR12MB6825.namprd12.prod.outlook.com (2603:10b6:303:20d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 06:44:06 +0000
Received: from SJ0PR12MB8165.namprd12.prod.outlook.com
 ([fe80::1499:6598:d339:f12e]) by SJ0PR12MB8165.namprd12.prod.outlook.com
 ([fe80::1499:6598:d339:f12e%5]) with mapi id 15.20.9632.015; Mon, 23 Feb 2026
 06:44:06 +0000
From: "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>
To: "Guttula, Suresh" <Suresh.Guttula@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Enable DPG support for VCN5
Thread-Topic: [PATCH] drm/amdgpu: Enable DPG support for VCN5
Thread-Index: AQHcovG5bwFyYLo27U2Mb7yHOgmnU7WQNeAA
Date: Mon, 23 Feb 2026 06:44:06 +0000
Message-ID: <SJ0PR12MB8165B90B9AFF78774FD1C2478077A@SJ0PR12MB8165.namprd12.prod.outlook.com>
References: <20260221051929.2176524-1-suresh.guttula@amd.com>
In-Reply-To: <20260221051929.2176524-1-suresh.guttula@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: SJ0PR12MB8165.namprd12.prod.outlook.com
 (15.20.9632.007)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8165:EE_|MW4PR12MB6825:EE_
x-ms-office365-filtering-correlation-id: ce251701-0223-44ab-9fcf-08de72a6f117
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|8096899003; 
x-microsoft-antispam-message-info: =?utf-8?B?NklMMWlvOTVMNTBEUDBLVDNvN2cxYWlCbmI0R0hjcHFGWGN1bUhUV21wN3dN?=
 =?utf-8?B?cHhlRDB3QTltaExjS0tKMWY4aUpZMXI5R2haNGtuamIxMFV1YklUZVI3M2gw?=
 =?utf-8?B?eVF0L1lNRVJpbTBlYkM0cEgvNTFKenZUek0ySC8rKzdJZjc0VnY4K0gwM1dp?=
 =?utf-8?B?ZEJZSEs2OGF0dlJMaEN1ZmlmTkVqTTdRSHBQUU11cjhPWG9GMXJMNGhhVDY2?=
 =?utf-8?B?bGMvNU5ySHAwQ2t5RG1GNjVxaTdBbVlpdVBPZTVDTXJlbHNXamNGb1UwbEZS?=
 =?utf-8?B?aDYxNlpLL2JHaEpKVkJyenJZeUx1YkJ3c1FuaWprZEdmejVFQlBINHZnZEJa?=
 =?utf-8?B?VjdmL2tBYzFTdHorZVFqRFRsSHU2dU45d2txSXFGZVM0MTBzUFEvK1dYQWxs?=
 =?utf-8?B?SGhtaW9qNUh5MXZLTDlnRlErN2pGSVBwam1zZ2QwSlBYT0cxamNjUlNJZTdC?=
 =?utf-8?B?OHVneXltNTQ1SElpdHFZejZLTHBuSFpoaEdtSmtTdWswV2o5cXMvU2t5dEc4?=
 =?utf-8?B?NVEzMDhYS0p2bTc2Ukk0UUNWRzVmRG1JYUdjNUVEUFU4S2pjemh2MzFsckM5?=
 =?utf-8?B?QkprdXpWeTBmMUxuem1TYjFTWlNydjFWQ2VJMXZTQXdiY01yb0tkbUFSYWN5?=
 =?utf-8?B?bVkvWTlJVzBTV0RrbkZ6VFRkSTc4c0xxMjJVYXhKRDhZN2NuelI3d1UzTS8r?=
 =?utf-8?B?eTllQVYwRFVGZDFhTHgwTUE4a1BFTFlncFl3d0lvbFRkR2oyZTh5Tzd3Ukhn?=
 =?utf-8?B?RDdtSzR0bTNBVm51Vk1sYm1zZ3dqWGJ4bVFwYUZIY2REUEJpSTIyd0htWkNR?=
 =?utf-8?B?VENBcWFnQkt2N2JYN2lCNUN6aWNYTGt1cmdlcGRtMllUdDY1ZGUwamNIQ0lx?=
 =?utf-8?B?b0lrak5iQld3OC9zNlNsRHJKQXJtUStsWlRCRUpFei9xWVlMY0hjQVRYMnF6?=
 =?utf-8?B?RmJEaitqMmdzSjVEaHlTTjJhUGxSNlFva1h1UWJ4MFFLOFlVZXd3empqZlkr?=
 =?utf-8?B?TTF4S3d2QmpHYklYRFhHMkNGRC95UmRwSHZWMHFQWnBoRVlIUGpXazdVVUs2?=
 =?utf-8?B?RG9yTm5UdVFWdEsxK2JvZTIrZmZSdWp3VmFIRmtWbDczTVdnWDBxaXpPL2o3?=
 =?utf-8?B?YmYxSEFBUE5GcXFPY0RWRFRINC9iL0s2aHNRSFI1ekZaajM0UTM3UXZzWmk2?=
 =?utf-8?B?SUQ3NlNLb1V4ZlNvdDRqbkgvWGY1WGx1eUVGV1pHR21nbUN4aTNoRGhHTFdq?=
 =?utf-8?B?UFJXTXBTRVYzRk1DNFZNbkN1UVo2c2g0MnNJSjkvZXcrY2xSeHJhNEMrS3Ra?=
 =?utf-8?B?ZGtlN1BGRVVidDdjeVYvL04wdXk3Y1owcFV2MWVFUEVQdTQxQng5OG01NUVr?=
 =?utf-8?B?ejJyR1dkSUlTRnFvUTFnRHRLeFhyNElLZGtGWWw1UWRIeUJkeXlOcnB1d2Zh?=
 =?utf-8?B?TEFUYm9NK0RBUHRxZDlJVDhkb3p4R2xtUUtIM05td0xXTDNpOVJmUXhaeWQ4?=
 =?utf-8?B?TDMzR2h3Yk53YTUvSXp5Rkd6Q1BuZ2tGZjVDbjdYZG50MlBXVERPMGdEWmxy?=
 =?utf-8?B?L1hTSjFCdXQxbHJKQTdMMFlwOXorQXdkQTVheENhVnpTU1FZS1R3M1I4YTZL?=
 =?utf-8?B?b0ZBSTRkVmFMZWdHdFZEK0NycEZCMURGVStCRjVkSDJrRExFdEcxN2Vyc09R?=
 =?utf-8?B?TUtodEpkR2xHTWNyMFkyZWQ5bHlqRDN4SWs2NUxjdmdXOEZaczlocTJWUHBo?=
 =?utf-8?B?QmQvVzBJZWhxK2d2bkF0ZFFRNmcvdDJwRnFFT2dXSzhqNVBqdWNpOVJhWjNG?=
 =?utf-8?B?WGdySWZTNEdNVy95d3RtWEhmekZqeFZJRGtLdURabDVzTmZSejVBY1BRRGtn?=
 =?utf-8?B?K1NHKzhzQzJCVG8xZmtPMlhsOThwUks3YTlUdm4xQkVud29UbXpxT0ZDa2Rs?=
 =?utf-8?B?bGtYZlM3WGdhcmFpcktUQWo3Q0Q3WnVyaWI2a09MZDFMYUwzRU1SbUI3Ujdn?=
 =?utf-8?B?ekJBUCtTRUZsWmFkYnJXaVhYU0g5K2FKRlpnN3dDL2VBV2lpU3QybmI0dERZ?=
 =?utf-8?B?anlTdkVnZkx4Z1BoRm4wdlVrVmNBL3YxQjdmVUl2OEM5MUVtY1NaYk5ZdGF3?=
 =?utf-8?B?ZHNwd1FtNFBuOVlXdFdhNk1kR0NWVGxEYnVFQTBQM2tvejNwT1JyTm8rOUFF?=
 =?utf-8?Q?+vtrlNQ/1gQe2CsgZ2T+f3E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mk9IUnVZejFVbE5rMW1vZVY4akF0TFJsVm1paUljakkvdnZYK3JhKytiaU9y?=
 =?utf-8?B?aHFqczNGNGNSVjVoUW1zNThFSSsvdWc3UThhakc3NVdXWU1FMytuaWdBU1Vs?=
 =?utf-8?B?bnlUU2dEWitXWWx0TFdHZ2U0MGZwc1NpdWZTck5uVStMQXVJN0dRdm5ZTGhS?=
 =?utf-8?B?NlZZSmdpVTJOMW9TWS9kVUhUUXUxVDRmR0RXV2xienJRK1dtNnczeTFvMDB4?=
 =?utf-8?B?Zm8ydExEVjR0L1JOOGdwSGQxR0JQU0o2YkJCUVFaWWN0MEJqL3h1Rk1lYUJF?=
 =?utf-8?B?UEhXRGx3MHVzT0lOdEhCRHFueis3YTZiNjhmdVo5ekJBeXZESVVUbXlKU0Rh?=
 =?utf-8?B?R0pmRG9janIwOS9TU1JoZWoxbEYwZEl1aEgyS081SDNEdnJyc0FYSlI0MFdm?=
 =?utf-8?B?SHloNStZckNkalc2cyt6eDRhUXg1NG9kdnllS0J3MEtPMGo5K1h3Z3d5S3ZQ?=
 =?utf-8?B?eUZuZnpnWUtMNzdHMng1cktwbE5FbnVSMnRtR0crSHM2TjBhNS9KY1BLOUt2?=
 =?utf-8?B?VjJZTjdPUkNQQi9MZ1B0ZUJUZFk2UDV1VjBzNHR2MDV2eTFGMWJSdmFsemIx?=
 =?utf-8?B?dG5pd3dPVGhWR2dFNVY1WnBZNUo4Uk9XT29zTFd0eEZHYm9PRHlkb25SYml2?=
 =?utf-8?B?VkUzWFY1eUtwenpoRlVtdlQveVVkcDRMaE13WUVxRzBUc3pGeW5UL0lyM3Vm?=
 =?utf-8?B?USt0Y3FPUmtSalJUV1ZSSXZyRnZzdkw0QStMSTRFN2I5R0JsK29JL2JTRWFJ?=
 =?utf-8?B?SVZVaHBEc25NWUtMcFIvKzJUQnFveHhFbU53T09MbDdZRituTXVtOTc3V1NE?=
 =?utf-8?B?NWNKVWl4STJBZ1Z2aktWY0RHZHVGamVUbEtaYlU3bnBpQ2Z3NSttc1RCSlhr?=
 =?utf-8?B?c3FpaW9LYU9lZE1IdXY2bnRFd0FremhmcWNmRWZnWWpuRUcrZUI1Wjc5cFly?=
 =?utf-8?B?RG9XMkpQaFRISE1QZmozODhzTTdQRWlOeTU1NEd4TEdvcjAwSXFncy9QQWg1?=
 =?utf-8?B?VnQ5YW1aTTNWcEwydVdnMXhCTWt6RFB1RXNpcTg5TWdqaFd6a1dXKzdtaXBD?=
 =?utf-8?B?UjEyMGhCYWdhK1lmNXl6ZTZWY2oyY2Jnc2VxL0FLUkI3NVh0ZFlaY3lIZVUx?=
 =?utf-8?B?Y2NPbVNBZWw2ZTRLeXdaY1J3cFBLUDRPcjY0RTNzcGFYMWgxblhRdUxFYk9N?=
 =?utf-8?B?SzV1Q0g5eHBzd3I4N1ErS1FHODJKczR3cWtxZDN6WUJLN2hiZW9qT2tQT3gw?=
 =?utf-8?B?NGhDcGpiK281eHpKeEpSY2lJUjJDMTFtMm5nSjhTdytLbCt1bEF0OHEzMHlt?=
 =?utf-8?B?NEhBbFBWTHV4UGFTbGpqTlF6KzlzTDVHbkhkeGo1aUYxSm5yaGhJMzhqelpG?=
 =?utf-8?B?KzREUkZQY1dqTkg2a3A5WVNnbmNiZDJrRVVGblcwemdIYlJHUVNsQkxNVW5n?=
 =?utf-8?B?N0Z0RkZDZFVQaXVPTEdZZjVGSk5kdXRtU0xNVmp0WmJwUmtnTXluRC9GVUxZ?=
 =?utf-8?B?QXl3R3FaaERUdHQ0dm5BZ1BqNFhneVpCb0FtVHhudUVseHBIeFJ1Tk80S0Ez?=
 =?utf-8?B?TzJRNi9xUUpRWEZld05sbFZBQ0F5djlVaDNpTko3VEsrR0RyWUU4NitNWEVZ?=
 =?utf-8?B?OUxkaUtReHFPSmo0SmwvZHpRMllHeXFOL3VxWGxGM0IrWGlyK3VDNVZDRWFR?=
 =?utf-8?B?M2VsbU9YeXQ3Y0g3L2NNMWlmRmhDc1dPUUVocnp0K2tpZC82MXdTbzdSVDUv?=
 =?utf-8?B?RHNFcjAxNWpDZlByOHpCK2g4ejZ3RmNyK1FPOGhoc05sNVF0K2VOZEJ4VE8r?=
 =?utf-8?B?dmNnZjNWMjFMckdnMmJ3OWZMV2hJSE1wQ2J4cFpzOWtwcENHWFZxSTc4M3N4?=
 =?utf-8?B?YkFhR2UxQ0o3SWladmU0d0ZRUmNZVjQxd0hDY2VDQXlvSXZwKzFpeVBqalZs?=
 =?utf-8?B?MUg2YkF4aVlXUitYR1Njei9UbmdHUE9HSk1OemlBWCthdUwvTmkwRGIzbmx0?=
 =?utf-8?B?TDdQa1JkUmZYMmJTa0RkSGhLa25ybFFuODlzNnFZRGJEZmIvYkJRRTF3R2xi?=
 =?utf-8?B?ejZoMkNEd1JFN3IwQ3dRbDlSSWJZeVUrMjZ4SUJ4T0lMRzVzWVRTQ3JtR29T?=
 =?utf-8?B?WU4vSjBzaERWdmhYaUtxL3c3WWhhMDRJSHZFdFAzVU85a0tHcFFMVmgwcXF5?=
 =?utf-8?B?SDQ4VmkvT3IvNVBRbUd6bFk3akNrUDhDOXB5MXB2R2VpQlA0ZWN3SlhHZ0dH?=
 =?utf-8?B?MjVVZENsKzlaWTZVWFRrM0U4aUVpd0dlSHZIRGppKzFXTjJmWHJNZUF3cW5F?=
 =?utf-8?Q?pVfu3UppEu0pjHCLXR?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR12MB8165B90B9AFF78774FD1C2478077ASJ0PR12MB8165namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce251701-0223-44ab-9fcf-08de72a6f117
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 06:44:06.7575 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rjnfM6Xr2XiGTxWsgwpirl0DODu4Fe1l6vxlJYMY5Iv4Mzx3oY3jOSaOPViObmInSjCCKDMoGFOu9buxNLp+cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6825
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

--_000_SJ0PR12MB8165B90B9AFF78774FD1C2478077ASJ0PR12MB8165namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQpPbiAyMS0wMi0yMDI2IDEwOjQ5LCBzZ3V0dHVsYSB3cm90ZToNCg0KVGhpcyB3aWxsIHNldCBE
UEcgZmxhZ3MgZm9yIGVuYWJsaW5nIHBvd2VyIGdhdGluZyBvbiBHRlgxMV81XzQNCg0KDQoNClNp
Z25lZC1vZmYtYnk6IHNndXR0dWxhIDxzdXJlc2guZ3V0dHVsYUBhbWQuY29tPjxtYWlsdG86c3Vy
ZXNoLmd1dHR1bGFAYW1kLmNvbT4NClJldmlld2VkLWJ5OiAgUHJhdGlrIFZpc2h3YWthcm1hIDxQ
cmF0aWsuVmlzaHdha2FybWFAYW1kLmNvbTxtYWlsdG86UHJhdGlrLlZpc2h3YWthcm1hQGFtZC5j
b20+Pg0KDQoNCg0KLS0tDQoNCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MyMS5jIHwg
NCArKystDQoNCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQoNCg0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMjEuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzIxLmMNCg0KaW5kZXggODEyMmE1Y2FjZjA3
Li5hMGFkMWY4YTc2ZjAgMTAwNjQ0DQoNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NvYzIxLmMNCg0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMjEuYw0KDQpA
QCAtODU4LDcgKzg1OCw5IEBAIHN0YXRpYyBpbnQgc29jMjFfY29tbW9uX2Vhcmx5X2luaXQoc3Ry
dWN0IGFtZGdwdV9pcF9ibG9jayAqaXBfYmxvY2spDQoNCiAgICAgICAgICAgICAgICAgQU1EX0NH
X1NVUFBPUlRfSUhfQ0cgfA0KDQogICAgICAgICAgICAgICAgIEFNRF9DR19TVVBQT1JUX0JJRl9N
R0NHIHwNCg0KICAgICAgICAgICAgICAgICBBTURfQ0dfU1VQUE9SVF9CSUZfTFM7DQoNCi0gICAg
ICAgIGFkZXYtPnBnX2ZsYWdzID0gQU1EX1BHX1NVUFBPUlRfVkNOIHwNCg0KKyAgICAgICAgYWRl
di0+cGdfZmxhZ3MgPSBBTURfUEdfU1VQUE9SVF9WQ05fRFBHIHwNCg0KKyAgICAgICAgICAgICAg
ICBBTURfUEdfU1VQUE9SVF9WQ04gfA0KDQorICAgICAgICAgICAgICAgIEFNRF9QR19TVVBQT1JU
X0pQRUdfRFBHIHwNCg0KICAgICAgICAgICAgICAgICBBTURfUEdfU1VQUE9SVF9KUEVHIHwNCg0K
ICAgICAgICAgICAgICAgICBBTURfUEdfU1VQUE9SVF9HRlhfUEc7DQoNCiAgICAgICAgIGFkZXYt
PmV4dGVybmFsX3Jldl9pZCA9IGFkZXYtPnJldl9pZCArIDB4MTsNCg==

--_000_SJ0PR12MB8165B90B9AFF78774FD1C2478077ASJ0PR12MB8165namp_
Content-Type: text/html; charset="utf-8"
Content-ID: <2DE90E2638CE1945BBD5166CE7EBE66D@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64

PGh0bWwgeG1sbnM6bz0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6b2ZmaWNlIiB4
bWxuczp3PSJ1cm46c2NoZW1hcy1taWNyb3NvZnQtY29tOm9mZmljZTp3b3JkIiB4bWxuczptPSJo
dHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL29mZmljZS8yMDA0LzEyL29tbWwiIHhtbG5zPSJo
dHRwOi8vd3d3LnczLm9yZy9UUi9SRUMtaHRtbDQwIj4NCjxoZWFkPg0KPG1ldGEgaHR0cC1lcXVp
dj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9dXRmLTgiPg0KPG1l
dGEgbmFtZT0iR2VuZXJhdG9yIiBjb250ZW50PSJNaWNyb3NvZnQgV29yZCAxNSAoZmlsdGVyZWQg
bWVkaXVtKSI+DQo8c3R5bGU+PCEtLQ0KLyogRm9udCBEZWZpbml0aW9ucyAqLw0KQGZvbnQtZmFj
ZQ0KCXtmb250LWZhbWlseToiQ2FtYnJpYSBNYXRoIjsNCglwYW5vc2UtMToyIDQgNSAzIDUgNCA2
IDMgMiA0O30NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6QXB0b3M7fQ0KQGZvbnQtZmFjZQ0K
CXtmb250LWZhbWlseTpDb25zb2xhczsNCglwYW5vc2UtMToyIDExIDYgOSAyIDIgNCAzIDIgNDt9
DQovKiBTdHlsZSBEZWZpbml0aW9ucyAqLw0KcC5Nc29Ob3JtYWwsIGxpLk1zb05vcm1hbCwgZGl2
Lk1zb05vcm1hbA0KCXttYXJnaW46MGNtOw0KCWZvbnQtc2l6ZToxMi4wcHQ7DQoJZm9udC1mYW1p
bHk6IkFwdG9zIixzYW5zLXNlcmlmO30NCmE6bGluaywgc3Bhbi5Nc29IeXBlcmxpbmsNCgl7bXNv
LXN0eWxlLXByaW9yaXR5Ojk5Ow0KCWNvbG9yOmJsdWU7DQoJdGV4dC1kZWNvcmF0aW9uOnVuZGVy
bGluZTt9DQpwcmUNCgl7bXNvLXN0eWxlLXByaW9yaXR5Ojk5Ow0KCW1zby1zdHlsZS1saW5rOiJI
VE1MIFByZWZvcm1hdHRlZCBDaGFyIjsNCgltYXJnaW46MGNtOw0KCWZvbnQtc2l6ZToxMC4wcHQ7
DQoJZm9udC1mYW1pbHk6IkNvdXJpZXIgTmV3Ijt9DQpzcGFuLkhUTUxQcmVmb3JtYXR0ZWRDaGFy
DQoJe21zby1zdHlsZS1uYW1lOiJIVE1MIFByZWZvcm1hdHRlZCBDaGFyIjsNCgltc28tc3R5bGUt
cHJpb3JpdHk6OTk7DQoJbXNvLXN0eWxlLWxpbms6IkhUTUwgUHJlZm9ybWF0dGVkIjsNCglmb250
LWZhbWlseTpDb25zb2xhczt9DQpzcGFuLkVtYWlsU3R5bGUyMQ0KCXttc28tc3R5bGUtdHlwZTpw
ZXJzb25hbC1jb21wb3NlO30NCi5Nc29DaHBEZWZhdWx0DQoJe21zby1zdHlsZS10eXBlOmV4cG9y
dC1vbmx5Ow0KCWZvbnQtc2l6ZToxMC4wcHQ7DQoJbXNvLWxpZ2F0dXJlczpub25lO30NCkBwYWdl
IFdvcmRTZWN0aW9uMQ0KCXtzaXplOjYxMi4wcHQgNzkyLjBwdDsNCgltYXJnaW46NzIuMHB0IDcy
LjBwdCA3Mi4wcHQgNzIuMHB0O30NCmRpdi5Xb3JkU2VjdGlvbjENCgl7cGFnZTpXb3JkU2VjdGlv
bjE7fQ0KLS0+PC9zdHlsZT4NCjwvaGVhZD4NCjxib2R5IGxhbmc9IkVOLUlOIiBsaW5rPSJibHVl
IiB2bGluaz0icHVycGxlIiBzdHlsZT0id29yZC13cmFwOmJyZWFrLXdvcmQiPg0KPGRpdiBjbGFz
cz0iV29yZFNlY3Rpb24xIj4NCjxwPjxvOnA+Jm5ic3A7PC9vOnA+PC9wPg0KPGRpdj4NCjxwIGNs
YXNzPSJNc29Ob3JtYWwiPk9uIDIxLTAyLTIwMjYgMTA6NDksIHNndXR0dWxhIHdyb3RlOjxvOnA+
PC9vOnA+PC9wPg0KPC9kaXY+DQo8YmxvY2txdW90ZSBzdHlsZT0ibWFyZ2luLXRvcDo1LjBwdDtt
YXJnaW4tYm90dG9tOjUuMHB0Ij4NCjxwcmU+VGhpcyB3aWxsIHNldCBEUEcgZmxhZ3MgZm9yIGVu
YWJsaW5nIHBvd2VyIGdhdGluZyBvbiBHRlgxMV81XzQ8bzpwPjwvbzpwPjwvcHJlPg0KPHByZT48
bzpwPiZuYnNwOzwvbzpwPjwvcHJlPg0KPHByZT5TaWduZWQtb2ZmLWJ5OiBzZ3V0dHVsYSA8YSBo
cmVmPSJtYWlsdG86c3VyZXNoLmd1dHR1bGFAYW1kLmNvbSI+Jmx0O3N1cmVzaC5ndXR0dWxhQGFt
ZC5jb20mZ3Q7PC9hPjxvOnA+PC9vOnA+PC9wcmU+DQo8L2Jsb2NrcXVvdGU+DQo8cCBjbGFzcz0i
TXNvTm9ybWFsIj48c3BhbiBzdHlsZT0ibXNvLWZhcmVhc3QtbGFuZ3VhZ2U6RU4tVVMiPlJldmll
d2VkLWJ5OiZuYnNwOzwvc3Bhbj4NCjxzcGFuIHN0eWxlPSJtc28tZmFyZWFzdC1sYW5ndWFnZTpF
Ti1VUyI+UHJhdGlrIFZpc2h3YWthcm1hICZsdDs8YSBocmVmPSJtYWlsdG86UHJhdGlrLlZpc2h3
YWthcm1hQGFtZC5jb20iPlByYXRpay5WaXNod2FrYXJtYUBhbWQuY29tPC9hPiZndDs8L3NwYW4+
DQo8bzpwPjwvbzpwPjwvcD4NCjxibG9ja3F1b3RlIHN0eWxlPSJtYXJnaW4tdG9wOjUuMHB0O21h
cmdpbi1ib3R0b206NS4wcHQiPg0KPHByZT48bzpwPiZuYnNwOzwvbzpwPjwvcHJlPg0KPHByZT4t
LS08bzpwPjwvbzpwPjwvcHJlPg0KPHByZT4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29j
MjEuYyB8IDQgKysrLTxvOnA+PC9vOnA+PC9wcmU+DQo8cHJlPiAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pPG86cD48L286cD48L3ByZT4NCjxwcmU+PG86cD4m
bmJzcDs8L286cD48L3ByZT4NCjxwcmU+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3NvYzIxLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MyMS5jPG86cD48
L286cD48L3ByZT4NCjxwcmU+aW5kZXggODEyMmE1Y2FjZjA3Li5hMGFkMWY4YTc2ZjAgMTAwNjQ0
PG86cD48L286cD48L3ByZT4NCjxwcmU+LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
c29jMjEuYzxvOnA+PC9vOnA+PC9wcmU+DQo8cHJlPisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3NvYzIxLmM8bzpwPjwvbzpwPjwvcHJlPg0KPHByZT5AQCAtODU4LDcgKzg1OCw5IEBA
IHN0YXRpYyBpbnQgc29jMjFfY29tbW9uX2Vhcmx5X2luaXQoc3RydWN0IGFtZGdwdV9pcF9ibG9j
ayAqaXBfYmxvY2spPG86cD48L286cD48L3ByZT4NCjxwcmU+ICZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyBBTURfQ0dfU1VQUE9SVF9JSF9DRyB8PG86cD48L286cD48L3ByZT4NCjxw
cmU+ICZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBBTURfQ0dfU1VQUE9SVF9CSUZf
TUdDRyB8PG86cD48L286cD48L3ByZT4NCjxwcmU+ICZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyBBTURfQ0dfU1VQUE9SVF9CSUZfTFM7PG86cD48L286cD48L3ByZT4NCjxwcmU+LSZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBhZGV2LSZndDtwZ19mbGFn
cyA9IEFNRF9QR19TVVBQT1JUX1ZDTiB8PG86cD48L286cD48L3ByZT4NCjxwcmU+KyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBhZGV2LSZndDtwZ19mbGFncyA9IEFN
RF9QR19TVVBQT1JUX1ZDTl9EUEcgfDxvOnA+PC9vOnA+PC9wcmU+DQo8cHJlPismbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgQU1EX1BHX1NVUFBPUlRfVkNOIHw8bzpwPjwvbzpwPjwv
cHJlPg0KPHByZT4rJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IEFNRF9QR19TVVBQ
T1JUX0pQRUdfRFBHIHw8bzpwPjwvbzpwPjwvcHJlPg0KPHByZT4gJm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IEFNRF9QR19TVVBQT1JUX0pQRUcgfDxvOnA+PC9vOnA+PC9wcmU+DQo8
cHJlPiAmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgQU1EX1BHX1NVUFBPUlRfR0ZY
X1BHOzxvOnA+PC9vOnA+PC9wcmU+DQo8cHJlPiAmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsgYWRldi0mZ3Q7ZXh0ZXJuYWxfcmV2X2lkID0gYWRldi0mZ3Q7cmV2X2lk
ICsgMHgxOzxvOnA+PC9vOnA+PC9wcmU+DQo8L2Jsb2NrcXVvdGU+DQo8L2Rpdj4NCjwvYm9keT4N
CjwvaHRtbD4NCg==

--_000_SJ0PR12MB8165B90B9AFF78774FD1C2478077ASJ0PR12MB8165namp_--
