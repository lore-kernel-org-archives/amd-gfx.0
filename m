Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F84FCCD183
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 14:21:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20F1810E465;
	Mon, 13 Oct 2025 14:21:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ARdZSCHs";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D789F10E45F
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 14:21:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqQH5cnbVPFdxGHf3thCJ/lNtuT4ZkjnHkREic8gTF3xUu0uddwzcL0RfIWOZLnu5x7/BQvjYl/eK3zJUdSFH6kzp+auC7SeSuz/TRMZPyuibx1cEYjDY+DAPK+j4IDzoCFs+agtCfot6nnyYd9nSmGY6Qw2Q6Vojw/e74xF2YlsZ8OlF16LCJY+zFawDcS68U97Lo/ZT2qOwp1g5MBvxFfC24wUxmqOHoOZ43YWGmxRVDewdXNiOZtT6JQfXNJ0X/xirFC5I+BSz1Sug5/13tkyfSqI/e4GWBApREtXOLHAyVmYWhc0mggHgRB+3pdpFXnUBXhZF3U2Vo2e/i4gaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/77OrBtVNBFpJ8ZcFn4ElKJ6OqNdcllm+Hnapse3Rw=;
 b=mvUxTMBLvuA++zhT9eBwR8HfvmTbHSvhXMd3ghu9SQCdowaDDVJrSbvYWAoOShI+YZgNcu+y6Z+0W1tgZ+YLQ5EqihcTKvatexfpyVIKMisLZXz5Pw8urui7u/p/d6Y52Ov1/JLMGY5brOJYjtcDf06zdn9g4u+5klMdJy1PajVyX/sjZg4W81JyCnTgudca3gXaRr1AG+Rx0Qdg6nQFWw7wh2fJw3eoqrYHRa9xCcgaH/NeorptCQElf2G9TSNmDz/dUC5SuEbHqSj15zYLP04UfPwTeez5di8jPquz3UE8pNpFjOoEJlxeUzuMdyxsGqfgQ2Ujc6HkXdJx6Bkl3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/77OrBtVNBFpJ8ZcFn4ElKJ6OqNdcllm+Hnapse3Rw=;
 b=ARdZSCHsFZi+PpwpsDq1evwZV5vqBfcR8IpOTuTzXUX79soKFWVn3JdnJ+wrqnkRum/qzNj/r2WiNC2zJYeHWqc1QxMWW+d2zNUGx/y1rXt9Beun0Jn7edKrVy4h9FCHILQ9Fupv3pmyzkgplhGhowABNIGtwfKly6dyLxbNz6Q=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:21:34 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 14:21:34 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Olsak,
 Marek" <Marek.Olsak@amd.com>, "Mohan Marimuthu, Yogesh"
 <Yogesh.Mohanmarimuthu@amd.com>
Subject: RE: [PATCH 3/7] drm/amdgpu/gfx: add eop size and alignment to shadow
 info
Thread-Topic: [PATCH 3/7] drm/amdgpu/gfx: add eop size and alignment to shadow
 info
Thread-Index: AQHcOisPMXDdFlg2wU2Chk8Ev6rOWrS/yPAwgABRsACAAAlEIA==
Date: Mon, 13 Oct 2025 14:21:34 +0000
Message-ID: <DS7PR12MB600591DF5FF29AB6E2B159A6FBEAA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20251010211510.1528572-1-alexander.deucher@amd.com>
 <20251010211510.1528572-3-alexander.deucher@amd.com>
 <DS7PR12MB6005A47FAE4B2CDE179E0A20FBEAA@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_PvKvj8wnNHuUWcUxGedF71vDjZA9Bq=M+N_c+x-cAXgQ@mail.gmail.com>
In-Reply-To: <CADnq5_PvKvj8wnNHuUWcUxGedF71vDjZA9Bq=M+N_c+x-cAXgQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-13T14:17:39.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|BY5PR12MB4291:EE_
x-ms-office365-filtering-correlation-id: 4c547d86-430a-4887-a9a7-08de0a63d001
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NHphenUwQnNuT0QzT2VlWTJSVTBBRXRIdHR6TysycUVCNTE4OU9nNVl3YUx5?=
 =?utf-8?B?RmQ2UER1MVlBdHJQRUxKa3crcnZuZ3krWTAxNi9TNTRkejdueUZXMTdiSTBL?=
 =?utf-8?B?RGZQK0JwaWFhT0hTM1VwMGxWR0RrYm5LRzA2c0NZc0ZjK2xEV0kxcEtwSjBl?=
 =?utf-8?B?YkxtOFFMLzUvSGsyNmQ5ekFxRlVKVURtVHBZRGRXajlObXBvejVaKy84eWEv?=
 =?utf-8?B?SWQxb2J3eFVwcVdyLzlqSGwwVHNVYjJOaFJqWDRUTmpURUthWTdUNTZvUFhj?=
 =?utf-8?B?OWNyUDZvaDRPWVlTWGhWZ2RxQzA2TVI3MDBHZllEQ3RjdFVuLzFwMGF0TUJE?=
 =?utf-8?B?N2d4Y1JUV1QyeklhMXNZalFBaVYwVTJvSU10czJ4Q2R4Q21ybUx2YkJaR0Fr?=
 =?utf-8?B?NFEyb2tnZVNCeUZxd0VuUWIxeG9TYWVWZXRXcnhHclBVMUgrTjkzbUZtNWpY?=
 =?utf-8?B?MXcvZWhodEdNdFB4Ry93czlFUTF4ZFFrOXlGdTdwZ1JmYnRRVk91R3NYNkpn?=
 =?utf-8?B?N2lIdTkyalVBM2d5Y1JSYkM1MGQ4THYrVWRVSDBFQiszSHlCSjlLVUVNZk1O?=
 =?utf-8?B?Q2dBalp6eVlTdjZWbURoQ2FTV0l0U1F5Y2cvK0xMWjgvTTRtNjdXVFRtL0tj?=
 =?utf-8?B?WVdhQWd4RkRSMURHeEREUmx0N1BPU1ZacHZuZjlzRkxiK0xkMmREVzlQNjNo?=
 =?utf-8?B?dHNEU3VWYUlWVmhQUGk2cjE3MThXUU8wQ2RkcElKMU9TK1hnN2tBZitRbHk2?=
 =?utf-8?B?SnpyUndDbjg2WVhRZVBMNzd3QXV1UEdaRm5LWU1WZ2Z5dWY2STMwWHNPS1pL?=
 =?utf-8?B?MHBZbjNlRFBlMC9hRFVCSElKZHNOUytQZW1KcDE0ZlNDNU9nQkJ6UitrUWxh?=
 =?utf-8?B?YmJGa3hCVUh0ZmZpaWZtVGlpOGVPeUVSa3pOUnU5YUt3WXhTMW4xakNpOTB1?=
 =?utf-8?B?UzFaUlQyNm9CZ2pHNmxjU3MyZlVmeWVGbzVRVDVZdzI4Q3pTK0FIejNZeGdr?=
 =?utf-8?B?dkxkRFRkbmRKTUljMEk5Zi9pY3dvUjVLT0V4cDlkS2VTTkZSWW1JM0pNTTB3?=
 =?utf-8?B?TW5xU2xUUHZpNnIzWFNkZy9VdlQrZm5jYWpIK1RvcC9OUVhaVERURVpzZjVN?=
 =?utf-8?B?V0hZdENLZ1BpMnJEbEh1cmZ3OWg5aVJJd0E2WDMzWDVzREU2TFlkeW1uVTda?=
 =?utf-8?B?ZkZ3RzhyRGJZNHZpY1U5Ui9vaCtZZ05yM0ZlMVp2cTFLY2V2Ylo4a294NjNY?=
 =?utf-8?B?SHRRQUprd1FOa3VQczdYN082ZEZEeFZmYjUrZDNuQzZwZGxyWk9GTUw3SUQx?=
 =?utf-8?B?RUNzTWt1eWZQdlFCeUlhdmxVL3VQV1RoMVhYa2Y0ZUhrd1lwZSthOUVPbXNR?=
 =?utf-8?B?dmVNNjRWVGk4M0hvNXM1Z2t6QnNVcnpmWHRCT2Z2TnFBS2wzelRLK3ZhdzFB?=
 =?utf-8?B?V05Zd1lhUUsxS0F0eWZWZjhoNTMwTDI5bWI3L04wWXhwY2F4Vmh2Y29ib2V1?=
 =?utf-8?B?UG5GMHhhdzdLNFNUSHU5SFJjVUVDNDNjTUtmTGhQblp3emRWUlc5eVNtV29T?=
 =?utf-8?B?cHZJWVg3cXhKQmZpaGwwdTg1UWE2L3lHY2ZLY1p4cHByR0dBN3EvQ2t5Mkdk?=
 =?utf-8?B?UWJmVDIxTU1DbEVoMlFRREptUnlGWHBUaDZYN2E3SnFGdDVOTnRENVZNbUZ5?=
 =?utf-8?B?NjA5KzZHY2pvZGdoWERReHFjeTRyanFyMVFTSjhQWHE5VE9Qc0tDbUZQb3R5?=
 =?utf-8?B?enBxYXRNYXNuaUprVTJMZERpMWRGMXpjUW5tMXhBWmgrV2N0by94Slk5N3Bz?=
 =?utf-8?B?eUhyZDhwUktjTTVHdkZFQk1MdSs2UjJmRGh4VjN1T24vT090ekg2VmRjL3dx?=
 =?utf-8?B?b3ljMXlaTFdXMW8vbElVdmhIOW5UR0gzWTdOQVNMaGlhZ3JmQmQzMUtWLzFn?=
 =?utf-8?B?WTRseG13eXJjRzVnZHpBeWttQmx4dGZrVlNBREtQMmVnZUIzT0xPdUV4UHlO?=
 =?utf-8?B?dHQ2cG01KzJDUVVYMnR0NUhVbkUzRFRESTRaRHJxeDlPYjRmY0RObXpHYUZV?=
 =?utf-8?Q?6pCsda?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NU5OSFJHbUxOMGFzZHVMUDV0aWZtYzdMeW82ei9RNXgvTWxZa1M4YXJSdk5u?=
 =?utf-8?B?TTVPZGVjc2x3MkFCQzNmWjdxamtDb2tGMHNoVWtSY3NQWXhaUFlucmwwUm5S?=
 =?utf-8?B?NncxeXMzUnBxaTNEWFd1Z1B3aWVKWGU2MTc5dnVRY1pUTldWMlpNcEc2Nldp?=
 =?utf-8?B?bkVxbWxtNFF3RWdpUUxDamphS3kwdXRTUXV0TjdTcllSTGVSVjk5dnFNdEFB?=
 =?utf-8?B?eHkzTkM4ZnpwRVgvelI2dkQ4L2JNcTEwbm1tVENLV2N3dHRnaDdsQzlTTENv?=
 =?utf-8?B?elpJM2s2bER3TEdDK0NXTzFrbGwyRm9sYnRnWG52a3R4SzBxQlU2cmZJKzRS?=
 =?utf-8?B?bk5FUC95U20wSE9ENnY4eUcyZHN5eDZwdzdRQ2ZxOEhDY3RXZlFSWS9ZdE5x?=
 =?utf-8?B?YTljZWVUWXJldFpWOXFvVnhzT0lOTzdIbmtRdUpFWFVhbGVSbWwxVWpuWDBS?=
 =?utf-8?B?eGFackhqNVhZYmEwZzJTb0JNTGhZdUZZMlJZQXIvTUlmZlVCUFJpMVVQekJu?=
 =?utf-8?B?UGZpYUhtRVhWU3JOM0c5STE4dWJKOVRjaGl5YmJVMFNTSlZjOGg1UHVLdmhB?=
 =?utf-8?B?cHhRdlJTZHQ5OUluNmV1SjIvTFplZ0hseThRRjZTQkxsanlYSzU1eDZLT3Qz?=
 =?utf-8?B?MkFxU2NNaU5TaTdFbkhaRlBBVXJjeitIc29zRk9yQk54dG1RaTZNUEFzZjc2?=
 =?utf-8?B?UlR1SlhTekFmOStoVjZhcmRia2ZaZU1tY0ZSSVdsQ0FwaUxMcHhkemNWd09w?=
 =?utf-8?B?SWlRUU9WblBDSXpiTm5MTVpMblNlYWFUaVA4cDB4NXlrWFhncGRScW95U2FV?=
 =?utf-8?B?MmR3MW5ZTWN4OHdGWDNiOHJIYjRnMlZpRS9zdDZab0FDUGhXb29mcHRmZWRt?=
 =?utf-8?B?SXM3VHU0M2lxaGtpNjZKc1hNTk5PdDdDc2dUOGpldXhCSGVOek0vcWdlWXU3?=
 =?utf-8?B?aUE5TnVSVHpQS0p1aUZTNXB2OFhFOEpsaXJldFBYTUZ6eUxnL2RadHU4VXho?=
 =?utf-8?B?T1JNYWVQL3VQSzRHWWc5akkyWlhKcjFubDRWSEJOMVZRZHh4L0VBcCtIL0cx?=
 =?utf-8?B?a0lMaWZZcHhrTTEzZDFwRnBXWjh6QnNqNkd3cDlBY1Mvcm4ydXpBb3NtTCsx?=
 =?utf-8?B?OVRqSDFOc0p0N2EzbjVoL1lQUkhkZDNzODB6S3BDL0JZNGRCNnRzSklNVHd2?=
 =?utf-8?B?b3A3N3ZHV2JETFJJakRNY0l3Qkd4WlpYZExid0xlU3ZEU3hSalVCZjlEdWlq?=
 =?utf-8?B?NWVDT3hTU0Rac3pRSFZ5RnliUzA2LzVwalNUTU5OYmkrNHJtMWxQVmNtTThK?=
 =?utf-8?B?eDZOWXhHUnBoOHRpaFBDVnl5VWVJRll6OXM1eVhuaERyL2M4bFNIUnpVek5X?=
 =?utf-8?B?cDZ1RkFITDNYTDBTTlIvM1N4Nm1rVnJwVXZVTUxrdWVORVdzRmMrSXNYQVhr?=
 =?utf-8?B?Z01QTGg1dVRpZ3FITFhCblZEN3NmN1ZId29yblZDWG1YaVhUYldIaUJrbVZa?=
 =?utf-8?B?TXdVV2c2Ky81bkxsVm1rMHFkUXJYekNlMkU4OW41RXhLR1NoSEJiVEl0YjdK?=
 =?utf-8?B?Q2VTekY0R0VIdnZNRFhYaG1vK0o5dW9PbWl5aGtQN3ZnSURjRUNuVC95bWhi?=
 =?utf-8?B?UUhmeFI2R1JWNWJUcmR1T0NwOE1KRzYwYUlBNjV1a0xLSXFYUG1aS3dtUExq?=
 =?utf-8?B?R2k3ZnpORElLQUFlbVZza1I4UEovb1lIQStLVFBwY1Q5WG05dityaUx1T2pw?=
 =?utf-8?B?WVc3TnBHWStJeDcwUjRLakM2UVdWSjBqNmdjNVBmMUNRRkh0bld0NzdZZXVZ?=
 =?utf-8?B?cmR6WHdLV1FTVC9CbVlOcEFadCtlQVdmalErRW1Pc0hyTXRvMVFlaysybTNU?=
 =?utf-8?B?R2xMUE9MZ1M0WGhNeXp0bTMyVGt6bFViZDRmR2NMV04rRmx0TzduaDdyamMr?=
 =?utf-8?B?Vk9aQmhmK0JoMVRYYjE3RDRoa3BicVV1UjVFb3VITDYrcGdvdzYrb2lYaSt3?=
 =?utf-8?B?SlloaWRPSnhTTG1TUktnZ3NITnRFM2FSY0ZuK1VqbFcwSWRERmN0R0krQ3pQ?=
 =?utf-8?B?cXNzVC9neHNQRHBLN3dCK3J5Tzd6TUlsSVpCUUpaOVlBVXdRcVVjTUlibVBp?=
 =?utf-8?Q?05i4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c547d86-430a-4887-a9a7-08de0a63d001
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 14:21:34.0596 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dw6zmNYTpOcl5tPTBHkfSPJDO0viXE3Uvanj9CqNrbOjeTYyMJslkl5mA4DBlpES
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291
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

W1B1YmxpY10NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+
IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAxMywgMjAyNSA5OjQ0IFBNDQo+IFRvOiBMaWFuZywgUHJp
a2UgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+OyBhbWQtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCAzLzddIGRybS9hbWRncHUvZ2Z4OiBhZGQgZW9wIHNpemUg
YW5kIGFsaWdubWVudCB0byBzaGFkb3cNCj4gaW5mbw0KPg0KPiBPbiBNb24sIE9jdCAxMywgMjAy
NSBhdCA0OjU04oCvQU0gTGlhbmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPiB3cm90ZToN
Cj4gPg0KPiA+IFtQdWJsaWNdDQo+ID4NCj4gPiBXZSBtYXkgbmVlZCB0byB1cGRhdGUgdGhlIHVz
ZXJzcGFjZSBFT1AgYnVmZmVyIHJlcXVlc3Q7IG90aGVyd2lzZSwgdGhlIEVPUA0KPiBidWZmZXIg
dmFsaWRhdGlvbiBtYXkgZmFpbC4NCj4NCj4gRXhpc3RpbmcgdXNlcnNwYWNlIHNob3VsZCBiZSBv
ay4gIEl0IGN1cnJlbnRseSB1c2VzIFBBR0VfU0laRSB3aGljaCBpcyBsYXJnZXIgdGhhbg0KPiAy
MDQ4Lg0KVGhlIG1lc2EgdXNlcyB0aGUgRU9QIHNpemUgYXMgbWF4X3QodTMyLCBQQUdFX1NJWkUs
IEFNREdQVV9HUFVfUEFHRV9TSVpFKSB3aGljaCBpcyBzZWVzIGxhcmdlciB0aGFuIDIwNDgsIHNv
IHRoZSBrZXJuZWwgdmFsaWRhdGVzIHRoZSBlb3AgYnVmZmVyIGNhbiBiZSBzdWNjZXNzZnVsIGF0
IHRoaXMgcG9pbnQuDQoNCkJ1dCB0aGUgbWVzYSBtYXkgbmVlZCB0byB1c2UgdGhlIHNoYWRvd19p
bmZvLT5lb3Bfc2l6ZSBhcyB3ZWxsIGluIHRoZSBmdXR1cmU/DQoNCj4gPiBQZXIgdGhpcyBrZXJu
ZWwgY2hhbmdlOiBSZXZpZXdlZC1ieTogUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+
DQo+DQo+IFRoYW5rcyENCj4NCj4gQWxleA0KPg0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiAgICAg
ICBQcmlrZQ0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJv
bTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVo
YWxmIE9mDQo+ID4gPiBBbGV4IERldWNoZXINCj4gPiA+IFNlbnQ6IFNhdHVyZGF5LCBPY3RvYmVy
IDExLCAyMDI1IDU6MTUgQU0NCj4gPiA+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zw0KPiA+ID4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNv
bT4NCj4gPiA+IFN1YmplY3Q6IFtQQVRDSCAzLzddIGRybS9hbWRncHUvZ2Z4OiBhZGQgZW9wIHNp
emUgYW5kIGFsaWdubWVudCB0bw0KPiA+ID4gc2hhZG93IGluZm8NCj4gPiA+DQo+ID4gPiBUaGlz
IGlzIHVzZWQgYnkgZmlybXdhcmUgZm9yIGNvbXB1dGUgdXNlciBxdWV1ZXMuDQo+ID4gPg0KPiA+
ID4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29t
Pg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dm
eC5oIHwgMiArKw0KPiA+ID4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMV8wLmMg
IHwgNCArKysrDQo+ID4gPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEyXzAuYyAg
fCA0ICsrKysNCj4gPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4gPiA+
DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dm
eC5oDQo+ID4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguaA0KPiA+
ID4gaW5kZXggZmI1ZjdhMGVlMDI5Zi4uNzEwOWEyYWQ5ZWMzNiAxMDA2NDQNCj4gPiA+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguaA0KPiA+ID4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5oDQo+ID4gPiBAQCAtMzI4LDYgKzMy
OCw4IEBAIHN0cnVjdCBhbWRncHVfZ2Z4X3NoYWRvd19pbmZvIHsNCj4gPiA+ICAgICAgIHUzMiBz
aGFkb3dfYWxpZ25tZW50Ow0KPiA+ID4gICAgICAgdTMyIGNzYV9zaXplOw0KPiA+ID4gICAgICAg
dTMyIGNzYV9hbGlnbm1lbnQ7DQo+ID4gPiArICAgICB1MzIgZW9wX3NpemU7DQo+ID4gPiArICAg
ICB1MzIgZW9wX2FsaWdubWVudDsNCj4gPiA+ICB9Ow0KPiA+ID4NCj4gPiA+ICBzdHJ1Y3QgYW1k
Z3B1X2dmeF9mdW5jcyB7DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3YxMV8wLmMNCj4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3YxMV8wLmMNCj4gPiA+IGluZGV4IDZmNGMyZTc0NjE2NWUuLjljNzliZmE0ZjFlZjYgMTAwNjQ0
DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjExXzAuYw0KPiA+
ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMV8wLmMNCj4gPiA+IEBA
IC0xMDUyLDEwICsxMDUyLDE0IEBAIHN0YXRpYyB2b2lkDQo+ID4gPiBnZnhfdjExXzBfc2VsZWN0
X21lX3BpcGVfcShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgIHN0YXRpYyB2b2lkDQo+ID4g
PiBnZnhfdjExXzBfZ2V0X2dmeF9zaGFkb3dfaW5mb19ub2NoZWNrKHN0cnVjdA0KPiA+ID4gYW1k
Z3B1X2RldmljZSAqYWRldiwNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHN0cnVjdCBhbWRncHVfZ2Z4X3NoYWRvd19pbmZvDQo+ID4gPiAqc2hhZG93X2luZm8p
ICB7DQo+ID4gPiArICAgICAvKiBmb3IgZ2Z4ICovDQo+ID4gPiAgICAgICBzaGFkb3dfaW5mby0+
c2hhZG93X3NpemUgPSBNUURfU0hBRE9XX0JBU0VfU0laRTsNCj4gPiA+ICAgICAgIHNoYWRvd19p
bmZvLT5zaGFkb3dfYWxpZ25tZW50ID0gTVFEX1NIQURPV19CQVNFX0FMSUdOTUVOVDsNCj4gPiA+
ICAgICAgIHNoYWRvd19pbmZvLT5jc2Ffc2l6ZSA9IE1RRF9GV1dPUktBUkVBX1NJWkU7DQo+ID4g
PiAgICAgICBzaGFkb3dfaW5mby0+Y3NhX2FsaWdubWVudCA9IE1RRF9GV1dPUktBUkVBX0FMSUdO
TUVOVDsNCj4gPiA+ICsgICAgIC8qIGZvciBjb21wdXRlICovDQo+ID4gPiArICAgICBzaGFkb3df
aW5mby0+ZW9wX3NpemUgPSBHRlgxMV9NRUNfSFBEX1NJWkU7DQo+ID4gPiArICAgICBzaGFkb3df
aW5mby0+ZW9wX2FsaWdubWVudCA9IDI1NjsNCj4gPiA+ICB9DQo+ID4gPg0KPiA+ID4gIHN0YXRp
YyBpbnQgZ2Z4X3YxMV8wX2dldF9nZnhfc2hhZG93X2luZm8oc3RydWN0IGFtZGdwdV9kZXZpY2UN
Cj4gPiA+ICphZGV2LCBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3YxMl8wLmMNCj4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMl8wLmMN
Cj4gPiA+IGluZGV4IDQ1M2U0MDM0Mzg5ZjIuLmZkMzdmMjM1NWY4NmUgMTAwNjQ0DQo+ID4gPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEyXzAuYw0KPiA+ID4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMl8wLmMNCj4gPiA+IEBAIC05MDksMTAg
KzkwOSwxNCBAQCBzdGF0aWMgdm9pZCBnZnhfdjEyXzBfc2VsZWN0X21lX3BpcGVfcShzdHJ1Y3QN
Cj4gPiA+IGFtZGdwdV9kZXZpY2UgKmFkZXYsICBzdGF0aWMgdm9pZA0KPiA+ID4gZ2Z4X3YxMl8w
X2dldF9nZnhfc2hhZG93X2luZm9fbm9jaGVjayhzdHJ1Y3QNCj4gPiA+IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzdHJ1Y3QNCj4gPiA+IGFtZGdwdV9nZnhfc2hhZG93X2luZm8NCj4gPiA+ICpzaGFkb3df
aW5mbykgIHsNCj4gPiA+ICsgICAgIC8qIGZvciBnZnggKi8NCj4gPiA+ICAgICAgIHNoYWRvd19p
bmZvLT5zaGFkb3dfc2l6ZSA9IE1RRF9TSEFET1dfQkFTRV9TSVpFOw0KPiA+ID4gICAgICAgc2hh
ZG93X2luZm8tPnNoYWRvd19hbGlnbm1lbnQgPSBNUURfU0hBRE9XX0JBU0VfQUxJR05NRU5UOw0K
PiA+ID4gICAgICAgc2hhZG93X2luZm8tPmNzYV9zaXplID0gTVFEX0ZXV09SS0FSRUFfU0laRTsN
Cj4gPiA+ICAgICAgIHNoYWRvd19pbmZvLT5jc2FfYWxpZ25tZW50ID0gTVFEX0ZXV09SS0FSRUFf
QUxJR05NRU5UOw0KPiA+ID4gKyAgICAgLyogZm9yIGNvbXB1dGUgKi8NCj4gPiA+ICsgICAgIHNo
YWRvd19pbmZvLT5lb3Bfc2l6ZSA9IEdGWDEyX01FQ19IUERfU0laRTsNCj4gPiA+ICsgICAgIHNo
YWRvd19pbmZvLT5lb3BfYWxpZ25tZW50ID0gMjU2Ow0KPiA+ID4gIH0NCj4gPiA+DQo+ID4gPiAg
c3RhdGljIGludCBnZnhfdjEyXzBfZ2V0X2dmeF9zaGFkb3dfaW5mbyhzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZQ0KPiA+ID4gKmFkZXYsDQo+ID4gPiAtLQ0KPiA+ID4gMi41MS4wDQo+ID4NCg==
