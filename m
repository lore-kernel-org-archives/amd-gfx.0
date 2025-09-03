Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E4FCA1009
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 18:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D796E10E943;
	Wed,  3 Sep 2025 18:42:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ljpwPEIG";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD3EF10E92A
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 18:42:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huWpBXQ23Jmncy2KHHBEjsdk9LDB09tktifRoz8qjxlPSJHrXipS/8ilDUar+BvwFvWMjJJP4Pc6Xh4EM9A3ajWWtB2URjwR2Xb9aUnY9dSYylsv4W5qKcfBuW7pO7WfLsB26s3LJ8VfQUG/iVUWGKQrjoKB6CddPPQ9E2rKlq/qesN2PhO6cE+laHnbgq3FN0yevVPO4lEbzQafDwh27rCTA8hacj82J5j+dcnbugajxU+N3HimHLDwe2NqT1BnhsnEVSImG8dasbheFlwjVcStbYqpClN2a8jpasOotiydw9xTdtPXftVlPhhqzAM83OrMl/UntVS7TAWoYGq7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eo3mDY2vnx/scLivI64JjAkXekEzSUWTSkh+V0m4oMk=;
 b=BFlXti8uv0qYUtKPjQ36t13VNF5+ZCUhDW6FqrWz9B1yVw1OFQXY4m83FJevhn+eyOkp/JUkrVrYaz7grJhVacTppXmiXF8SeoWQJ7GLcul2FKEJpmLFDyW95f1Y8XCAx4BAz0nPSrQIAMLLiBapllVIcxx+LeimiUd1dA+Oe8r0Z0O7MfmeZsJ2v31IpZ+K5qWxnFr6R2n2M4M9BDHPKIOY7txy/hwoVwEREIX8BnTkKvTjeDNy5Ad2vZ8raw4W4ixS6n+haJ7HpvwQKaMlb4JFYHN7fEeE33wFDMlfExSVjDGmm5bsi1FVw7ueoWXxz3OxSFUljerWWb6nkIPDOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eo3mDY2vnx/scLivI64JjAkXekEzSUWTSkh+V0m4oMk=;
 b=ljpwPEIGxM9fY4FIEoMqGg3mGVPsEauI4Pci7Z34Ubsj9s9qW4rnm4pDkZFnvcLGRabM85RqRlBwZLCG4Qg3uBzmJx7gvHyB63qiUQHS61XsCqCEDZthePtePdWTk9saoICKY20MWMXOOOOFoBjgxxytyb8vnw42C41dqxMbRzI=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB9522.namprd12.prod.outlook.com (2603:10b6:208:594::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 18:42:35 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 18:42:35 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Nirujogi, Pratap" <Pratap.Nirujogi@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>
CC: "Chan, Benjamin (Koon Pan)" <Benjamin.Chan@amd.com>, "Du, Bin"
 <Bin.Du@amd.com>, "Rosikopulos, Gjorgji" <Gjorgji.Rosikopulos@amd.com>, "Li,
 King" <King.Li@amd.com>, "Antony, Dominic" <Dominic.Antony@amd.com>, "Jawich, 
 Phil" <Phil.Jawich@amd.com>, Alexey Zagorodnikov <xglooom@gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Declare isp firmware binary file
Thread-Topic: [PATCH] drm/amd/amdgpu: Declare isp firmware binary file
Thread-Index: AQHcHQFPBRI1D4eJyEi/wLubI934X7SBywMA
Date: Wed, 3 Sep 2025 18:42:34 +0000
Message-ID: <e5fa9fe8-6152-481d-947e-714aba216a61@amd.com>
References: <20250903183333.529150-1-pratap.nirujogi@amd.com>
In-Reply-To: <20250903183333.529150-1-pratap.nirujogi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|IA1PR12MB9522:EE_
x-ms-office365-filtering-correlation-id: e229167b-d94e-4de2-72cd-08ddeb19a610
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WEY5RVlMb3NGNkxyVDJIT3NLOXBGcWQzekJwMTY2alNMbHN5NlU2ZTZBb3pq?=
 =?utf-8?B?TWRHMnIvUXF0cFI1dGZDTUVMeFNla25yNU1qcUVjSDh5TE5RR045TG9YOU44?=
 =?utf-8?B?RVBJOFlIZy9FcEM1cmljWkRmK0JmMHREaTJGOUlTdFc2akZFSWJ6TW52QTIv?=
 =?utf-8?B?K2U0eFJjUEJNUUpEYnUvWDlkWlVaMGEvcnMveGc3YXFjUVM3YWJCVEFuVlgz?=
 =?utf-8?B?MExZSXpadkJPWG9pVHNJMGdGS0Z6VFpWa2NkOFFFTUQwMHVMTlBkcGR2L0Nr?=
 =?utf-8?B?blFjN3NiVERmclRvaXlmNkRkK3Rld0FaRG9naHZTbC9HdE02dzAxOVZISmZP?=
 =?utf-8?B?MjRKREdlOSt6dG4zV3VyV25yb0w2eWpaWkhabndzY044ZzRrenp5eHV0K0dw?=
 =?utf-8?B?USt6T0VxWW5RWTYyVnFMY3J4ck1ZcU1tZVBhdDRrdHJQTDZDd1VrMVhzeWVT?=
 =?utf-8?B?Yzc3Z2dkcGVidDhFY0dicW1rRVRhaDlua2pqTHVtTEV6bzdKTmV5TlllVjM0?=
 =?utf-8?B?eW1UYkQwTFNnZklJeHZLRk5BYlVZeHY4ZDR2Wi9mWnZnaTlsQkJodkV3dTcv?=
 =?utf-8?B?UUdYbWQvSWFDMjcrdVUreE01bWwrZDJqaHc1c2M0L1FzM0pybXZ4dTdXb2d3?=
 =?utf-8?B?cThnOUNDU1ZDSXVmdVRORkRmVWUzREpkRldpd2hlS2ZJU3hqUld4QVhvcVlH?=
 =?utf-8?B?K3N5MzNrVGZFZm4xZ21yelpsMmxwd05iZ1FjTkZXNFdweW43Vk52OEFEbHYv?=
 =?utf-8?B?V1JxRmpnN1ZNVWdXbFhLK3RobkhYcVMvWEJTL25QZFBYWVY1UnowOENGaTdw?=
 =?utf-8?B?ODRjMGg0ZTdPYjR5RDJFODRIemxQTlZFRW5EQzVuNkgyNE82SHpwalNQa2ZX?=
 =?utf-8?B?ejRCdmJJQlRhQzVFZHFMeVU3MlFsR3FJY2h5Sk5iRGNsWWRuSklvK0hzTGhJ?=
 =?utf-8?B?aDVEbGlqNnVxUmhzY3dPeXo4b2dlQUp3eVlWbU50Y2ZwWjR3NDhFc25rSVJl?=
 =?utf-8?B?VVFTQThvbGs4REo2Z1VnQlJzZjlSRi9HYXR3cjNaSVBGcVF0MlZtTFZoalph?=
 =?utf-8?B?cStMaHNKZ2hrS3hzNWdnS2NLS09HNndGMEFiR0FsZmRmcndsd0RnUFE2Vmx0?=
 =?utf-8?B?K2o4U1l5bVB1akZiZDlDVUpBZ2RRK1pRTlR2MlNIdzRScTlrTVFBMFhrS2xO?=
 =?utf-8?B?Z1dFcWprZXN5YkNmRUtKN2FUUW16RXRzMmVZNEU2SlFyNStnYW5lVVk2U0NE?=
 =?utf-8?B?OHNxazdQQjRDU1gxV3VPc2JZWS9Zd3d6RDRySlJHVUNJSEJnRUJOQ21OT0ts?=
 =?utf-8?B?ODkxdlBsbXExS3g2SUo1MElOV2txOWp5cm1FTUdYS1RnUVpJYVYvTmNWTGJp?=
 =?utf-8?B?TEU5ZStmNk5zMnhORklPZW9zNWl4RjNwVW80K1B5QXlPRXhOSTZMRERCVjNB?=
 =?utf-8?B?WENaakpVYkNiZHhyRGJna2d4QStQbGlKZXByTHkyUEtSRThPZ05CZVBnMnV3?=
 =?utf-8?B?UEJTdFBaRnlCTEE5QlBzVHdDUnJmVFo0YmVyRzBoTkhFd1piMzFwWjlJbVYw?=
 =?utf-8?B?QU9tczYvU0xybldIZHNOaEJvVlNqZGZnV2pxUTdGQTBsaityVktrZFcrSzJ0?=
 =?utf-8?B?ZEVtaVQyRWJQU2JBY0YyRUhuRzA4UnY3WTI1SER5eEtjVExCblJ5bldUblVt?=
 =?utf-8?B?dURYM1JZVWM2VVBBenBuakxza3hlSS9obUN4Rldqbi82L3YvNUhMbWt3em1K?=
 =?utf-8?B?NHY4dUNsLzNGbzNZdnNPWjZBeUxWY2RyeHB2cURteEpRc2RITWpxYi94MzlR?=
 =?utf-8?B?cHlKYjExS2kzZ291ZFhuVG94NlllbjRIZzQ1T0swNWR5b2JQUkxlT1BaQWFq?=
 =?utf-8?B?ZkdTK2VrVnh3OFpRemZscVBHQWVQem50UnFaOTA3U3J0eDBxQ2Mvb0hkMXI5?=
 =?utf-8?B?djRlTjBDcjNqVjlFeElFRjcrZmovWUlKSGh6UzV2TkpwVGJLY2M4dXQ2Tmdp?=
 =?utf-8?Q?frV/5uxiptMJGzvTfOjhHX2AqiR8RE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUMrQVRwM1NLdFJPeDNkOXRNeWRmUUhjcjdQdEZkYkFCdVBsU2JsWVJzOUZo?=
 =?utf-8?B?SkkvUWs3NTR3MDhOK2ZRRE1Oc25jRlV1eXZyb1V6VW9FNnptTm1vZi9oSlBJ?=
 =?utf-8?B?cGZVSkgzQVlHUmpNRElKNktNdXV5azAxTmZPaW5xUFp4bVRWc09iU2ZnUklr?=
 =?utf-8?B?a0V1VjFUZmIwbE5uTjdMNlhkaEtUaVU0T00xaGJxcWxjZU5GZTZOeVpNSksv?=
 =?utf-8?B?azJubEREaHQrRmlldm1uYUE4QWxIZWlEWHN0SDZmdWpHWDhNMk96WTZ0VzRy?=
 =?utf-8?B?K2ZaZXJvVC9GWkhTU3hBbHljRERNRHlZQVFTTVdqeDNmZDJCUE1uNnRPeGRM?=
 =?utf-8?B?TEdKYlFGRFdlZkZjVTNVc1hLT1pTSUNUMnF2bDZKTVo0QjEweE13TEhmNHA3?=
 =?utf-8?B?VkU3Ri91RXFlTkxHQ2I4NkJjVE1jaFlMQUZzcFRiRVdubmNyeUcvRlU2aU9Z?=
 =?utf-8?B?Z2V2YnBiQ05IcVFSVmtJblc2NTJvTGdQQy9ZSEJVblFRM2FGU0tKZFBta1dH?=
 =?utf-8?B?RkhjclExMXk3dmY2cHVCakptcVpHOWhzeHVuRE1XQWRpL3p6MWh1cmRCOFN2?=
 =?utf-8?B?VUVFT3NPOXZrYk5HZkFsSmU1MEU1QXhiaXVlZ1RiQkMxS0lCQ0ZDK2cvVnRt?=
 =?utf-8?B?ZE5JaS9vQStZQ0dQQ213Ylo1QlZ3TUlERWQxbHBpRDl6VTBCcXFmalBNTWt3?=
 =?utf-8?B?cjY3aHBCbjQ0UjFoT0RHdFpKaHhYc2F5NTNvRHJJY3FicHdzWGJFRmx2TFhY?=
 =?utf-8?B?Rkp2L2ZtUkhhMXhaZzMzUVdjcjRFcllpQ2dhNHRycmVMRncvWDZ6UVFQd0Fy?=
 =?utf-8?B?ZW1NakNOb21Idm41M2F3UEdUMUs5UmJjeUM1d01adGZjMnRqcTdFSmdqblJz?=
 =?utf-8?B?aEhhL3pNOXd2azlSOFo3dkVmcVdkQUJZSHlDU1p1eWk0WkxuUzdnVUVhN0Jq?=
 =?utf-8?B?L0U2RlpvWTFhNVdEcDVWV0NXNEJnTXVERmtibTB4VG1ZbVh5Qzh3K1R3UFl6?=
 =?utf-8?B?N2t4QlNzL1VobmN0THE1VHhOaWhiN010YSt2YkpGNnh0YmlnOTJFZkgzTW5z?=
 =?utf-8?B?Slh3OG9SQWtkTWxEWlQ2RlRrZTNuWTRFV2lEWXBBNmhFZ2pFS1JEdHEyejlh?=
 =?utf-8?B?NWIzSmIyTEFJWlhpWnNVWW9LR09INVhUSUtWWlFwNXNiMENXNjk1RmZpc05D?=
 =?utf-8?B?M2dJZytxenNFaEtSWUJOTDlHN3Z4UWdtbTN0ZzhuZ3I1eW91aWFEcG9COEVX?=
 =?utf-8?B?MnhtRzNFdk84Wlp3ZVA4aEdhUjN2cEJ2YzhQbXBrR3V3QVVsclhwVzA5OHl3?=
 =?utf-8?B?bEs3Sk1TVEpnUmhqVWhNNHNzc2FpVjZMWUd6eThFV3AvQWd0eHFZQjNvcDVo?=
 =?utf-8?B?ZUtWSmw3cTJjMklYMzg1a25NWDU5U1RJY0tUdUhXeXhHMHVyanRwWGFYQU5w?=
 =?utf-8?B?NSs0eW8zcjJuWVhRT2tlY3poUHpuMDJVeHBTZVlYR2E1TFhLSGdDbjRaNFow?=
 =?utf-8?B?TGhtZ3lsbnY2cWVtWi9wWDkxeXhnd1JCRzJnelppUXZQenhadjR4MUV5WFMw?=
 =?utf-8?B?dFBQZFc1VW94VnlpRnNCNXNScng4dTk5SWd4MlVUcXl3SUQya3lZTUFWUG1W?=
 =?utf-8?B?ZTIwL3d3ZGs3ajhqZlN3WkZSQ2MrNXdxSURHeTBoV1Vpbk52T2htL1REUVdk?=
 =?utf-8?B?YUNUb0xGdEZjL2dQN2o2YndmcWpDdXpOeWtLQjRpK2xzNzlqWG9keWswOXdX?=
 =?utf-8?B?dkdVQ1BuR1RzZjdFa1dRWVFZc0NTTFJpNVpMSW1OVXYzOVNUYUhqUHRmYVFj?=
 =?utf-8?B?RzZTSXdJbmlXMk44VlZOOEV6bllzTDZOOWI2b0N2RENINU1iRE44azJQK1hE?=
 =?utf-8?B?VExsK3E2T0dLbHlJenVCbjVBd0FSRXBmVXNvT1psU0NuRytNazczUllYeGc4?=
 =?utf-8?B?dXRTN3BRSzJEYlRyYjdXUEdtOUxxNDZ1NWNldWxmOHROcGFjQ3ZkcXlrWFNO?=
 =?utf-8?B?SHdsRWRyR1hqSTBMZ0ZTeS9kWUdiaUxJRDVGeVE3MkxRNU9KdzZXTEd3elA3?=
 =?utf-8?B?RTNrNHp6WDVHMGhmRUs2VXdQYVFuYWp1NTZoUDJvSjBiQStFNzdhcFNuYjNy?=
 =?utf-8?Q?dJuc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF6D490E7A310C46AAF695C201EE9952@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e229167b-d94e-4de2-72cd-08ddeb19a610
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 18:42:34.9237 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nLWWzIkufkarXpcqVSUSIFpu896BfWePA85ZsodMNPZg25oQTM8jdwnRpmtCgeMMylDOTi7cSngDCS+6dQSVEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9522
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

T24gOS8zLzI1IDE6MzMgUE0sIE5pcnVqb2dpLCBQcmF0YXAgd3JvdGU6DQo+IERlY2xhcmUgaXNw
IGZpcm13YXJlIGZpbGUgaXNwXzRfMV8xLmJpbiByZXF1aXJlZCBieSBpc3A0LjEuMSBkZXZpY2Uu
DQo+IA0KPiBTdWdnZXN0ZWQtYnk6IEFsZXhleSBaYWdvcm9kbmlrb3YgPHhnbG9vb21AZ21haWwu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQcmF0YXAgTmlydWpvZ2kgPHByYXRhcC5uaXJ1am9naUBh
bWQuY29tPg0KDQpJIHRoaW5rIHlvdSBzaG91bGQgc3BsaXQgdGhpcyBpbnRvIG11bHRpcGxlIHBh
dGNoZXMuICBKdXN0IG9uZSBwYXRjaCB0byANCmFkZCB0aGUgZGVjbGFyYXRpb24sIGFuZCBhbm90
aGVyIHBhdGNoIHRvIGNoYW5nZSB0aGUgZXJyb3IgaGFuZGxpbmcuDQoNCj4gLS0tDQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lzcC5jIHwgMjIgKysrKysrKysrLS0tLS0t
LS0tLS0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pc3AuaCB8ICAy
ICsrDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaXNwX3Y0XzFfMC5jIHwgMTIgKysr
KysrKysrKystDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaXNwX3Y0XzFfMC5oIHwg
IDIgKy0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9pc3BfdjRfMV8xLmMgfCAxNCAr
KysrKysrKysrKysrLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2lzcF92NF8xXzEu
aCB8ICAyICstDQo+ICAgNiBmaWxlcyBjaGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspLCAxNyBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfaXNwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXNwLmMNCj4g
aW5kZXggOWNkZGJmNTA0NDJhLi45MGFmMzVlZThmNmUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pc3AuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfaXNwLmMNCj4gQEAgLTY4LDcgKzY4LDcgQEAgc3RhdGljIGludCBp
c3BfaHdfZmluaShzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrICppcF9ibG9jaykNCj4gICAJcmV0dXJu
IC1FTk9ERVY7DQo+ICAgfQ0KPiAgIA0KPiAtc3RhdGljIGludCBpc3BfbG9hZF9md19ieV9wc3Ao
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICtpbnQgaXNwX2xvYWRfZndfYnlfcHNwKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgIHsNCj4gICAJY29uc3Qgc3RydWN0IGNvbW1v
bl9maXJtd2FyZV9oZWFkZXIgKmhkcjsNCj4gICAJY2hhciB1Y29kZV9wcmVmaXhbMTBdOw0KPiBA
QCAtODAsNyArODAsNyBAQCBzdGF0aWMgaW50IGlzcF9sb2FkX2Z3X2J5X3BzcChzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldikNCj4gICANCj4gICAJLyogcmVhZCBpc3AgZncgKi8NCj4gICAJciA9
IGFtZGdwdV91Y29kZV9yZXF1ZXN0KGFkZXYsICZhZGV2LT5pc3AuZncsIEFNREdQVV9VQ09ERV9P
UFRJT05BTCwNCj4gLQkJCQkiYW1kZ3B1LyVzLmJpbiIsIHVjb2RlX3ByZWZpeCk7DQo+ICsJCQkJ
ICJhbWRncHUvJXMuYmluIiwgdWNvZGVfcHJlZml4KTsNCj4gICAJaWYgKHIpIHsNCj4gICAJCWFt
ZGdwdV91Y29kZV9yZWxlYXNlKCZhZGV2LT5pc3AuZncpOw0KPiAgIAkJcmV0dXJuIHI7DQo+IEBA
IC0xMDMsMjcgKzEwMywyMyBAQCBzdGF0aWMgaW50IGlzcF9lYXJseV9pbml0KHN0cnVjdCBhbWRn
cHVfaXBfYmxvY2sgKmlwX2Jsb2NrKQ0KPiAgIA0KPiAgIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiA9IGlwX2Jsb2NrLT5hZGV2Ow0KPiAgIAlzdHJ1Y3QgYW1kZ3B1X2lzcCAqaXNwID0gJmFk
ZXYtPmlzcDsNCj4gKwlpbnQgcjsNCj4gKw0KPiArCWlzcC0+YWRldiA9IGFkZXY7DQo+ICsJaXNw
LT5wYXJlbnQgPSBhZGV2LT5kZXY7DQo+ICAgDQo+ICAgCXN3aXRjaCAoYW1kZ3B1X2lwX3ZlcnNp
b24oYWRldiwgSVNQX0hXSVAsIDApKSB7DQo+ICAgCWNhc2UgSVBfVkVSU0lPTig0LCAxLCAwKToN
Cj4gLQkJaXNwX3Y0XzFfMF9zZXRfaXNwX2Z1bmNzKGlzcCk7DQo+ICsJCXIgPSBpc3BfdjRfMV8w
X3NldF9pc3BfZnVuY3MoaXNwKTsNCj4gICAJCWJyZWFrOw0KPiAgIAljYXNlIElQX1ZFUlNJT04o
NCwgMSwgMSk6DQo+IC0JCWlzcF92NF8xXzFfc2V0X2lzcF9mdW5jcyhpc3ApOw0KPiArCQlyID0g
aXNwX3Y0XzFfMV9zZXRfaXNwX2Z1bmNzKGlzcCk7DQo+ICAgCQlicmVhazsNCj4gICAJZGVmYXVs
dDoNCj4gICAJCXJldHVybiAtRUlOVkFMOw0KPiAgIAl9DQo+ICAgDQo+IC0JaXNwLT5hZGV2ID0g
YWRldjsNCj4gLQlpc3AtPnBhcmVudCA9IGFkZXYtPmRldjsNCj4gLQ0KPiAtCWlmIChpc3BfbG9h
ZF9md19ieV9wc3AoYWRldikpIHsNCj4gLQkJRFJNX0RFQlVHX0RSSVZFUigiJXM6IGlzcCBmdyBs
b2FkIGZhaWxlZFxuIiwgX19mdW5jX18pOw0KPiAtCQlyZXR1cm4gLUVOT0VOVDsNCj4gLQl9DQo+
IC0NCj4gLQlyZXR1cm4gMDsNCj4gKwlyZXR1cm4gcjsNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGlj
IGJvb2wgaXNwX2lzX2lkbGUoc3RydWN0IGFtZGdwdV9pcF9ibG9jayAqaXBfYmxvY2spDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXNwLmggYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXNwLmgNCj4gaW5kZXggZDZmNGZmYTRjOTdj
Li4zNjc1MDEyM2VkNDYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9pc3AuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
aXNwLmgNCj4gQEAgLTU3LDQgKzU3LDYgQEAgc3RydWN0IGFtZGdwdV9pc3Agew0KPiAgIGV4dGVy
biBjb25zdCBzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrX3ZlcnNpb24gaXNwX3Y0XzFfMF9pcF9ibG9j
azsNCj4gICBleHRlcm4gY29uc3Qgc3RydWN0IGFtZGdwdV9pcF9ibG9ja192ZXJzaW9uIGlzcF92
NF8xXzFfaXBfYmxvY2s7DQo+ICAgDQo+ICtpbnQgaXNwX2xvYWRfZndfYnlfcHNwKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KTsNCj4gKw0KPiAgICNlbmRpZiAvKiBfX0FNREdQVV9JU1BfSF9f
ICovDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9pc3BfdjRfMV8w
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9pc3BfdjRfMV8wLmMNCj4gaW5kZXggMDAy
N2E2MzljN2U2Li45MjY5NDdhNjEyYTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2lzcF92NF8xXzAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9pc3BfdjRfMV8wLmMNCj4gQEAgLTE4NSw3ICsxODUsMTcgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBpc3BfZnVuY3MgaXNwX3Y0XzFfMF9mdW5jcyA9IHsNCj4gICAJLmh3X2ZpbmkgPSBpc3BfdjRf
MV8wX2h3X2ZpbmksDQo+ICAgfTsNCj4gICANCj4gLXZvaWQgaXNwX3Y0XzFfMF9zZXRfaXNwX2Z1
bmNzKHN0cnVjdCBhbWRncHVfaXNwICppc3ApDQo+ICtpbnQgaXNwX3Y0XzFfMF9zZXRfaXNwX2Z1
bmNzKHN0cnVjdCBhbWRncHVfaXNwICppc3ApDQo+ICAgew0KPiArCXN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2ID0gaXNwLT5hZGV2Ow0KPiArDQo+ICAgCWlzcC0+ZnVuY3MgPSAmaXNwX3Y0XzFf
MF9mdW5jczsNCj4gKw0KPiArCS8qIGxvYWQgaXNwIGZpcm13YXJlICovDQo+ICsJaWYgKGlzcF9s
b2FkX2Z3X2J5X3BzcChhZGV2KSkgew0KPiArCQlkcm1fZXJyKCZhZGV2LT5kZGV2LCAiaXNwIGZ3
IGxvYWQgZmFpbGVkXG4iKTsNCj4gKwkJcmV0dXJuIC1FTk9FTlQ7DQo+ICsJfQ0KPiArDQo+ICsJ
cmV0dXJuIDA7DQo+ICAgfQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvaXNwX3Y0XzFfMC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaXNwX3Y0XzFfMC5o
DQo+IGluZGV4IDRkMjM5MTk4ZWRkMC4uNWU0M2JhMDY0NzA4IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9pc3BfdjRfMV8wLmgNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvaXNwX3Y0XzFfMC5oDQo+IEBAIC00NSw2ICs0NSw2IEBADQo+ICAgI2Rl
ZmluZSBJU1A0MTBfR1BJT19TRU5TT1JfT0ZGU0VUIDB4NjYxM0MNCj4gICAjZGVmaW5lIElTUDQx
MF9HUElPX1NFTlNPUl9TSVpFIDB4NTQNCj4gICANCj4gLXZvaWQgaXNwX3Y0XzFfMF9zZXRfaXNw
X2Z1bmNzKHN0cnVjdCBhbWRncHVfaXNwICppc3ApOw0KPiAraW50IGlzcF92NF8xXzBfc2V0X2lz
cF9mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2lzcCAqaXNwKTsNCj4gICANCj4gICAjZW5kaWYNCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2lzcF92NF8xXzEuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2lzcF92NF8xXzEuYw0KPiBpbmRleCBhODg3ZGY1MjA0MTQu
LjFlNDhkOTRlODcwNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
aXNwX3Y0XzFfMS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2lzcF92NF8x
XzEuYw0KPiBAQCAtMjksNiArMjksOCBAQA0KPiAgICNpbmNsdWRlICJhbWRncHUuaCINCj4gICAj
aW5jbHVkZSAiaXNwX3Y0XzFfMS5oIg0KPiAgIA0KPiArTU9EVUxFX0ZJUk1XQVJFKCJhbWRncHUv
aXNwXzRfMV8xLmJpbiIpOw0KPiArDQo+ICAgI2RlZmluZSBJU1BfUEVSRk9STUFOQ0VfU1RBVEVf
TE9XIDANCj4gICAjZGVmaW5lIElTUF9QRVJGT1JNQU5DRV9TVEFURV9ISUdIIDENCj4gICANCj4g
QEAgLTM2OSw3ICszNzEsMTcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpc3BfZnVuY3MgaXNwX3Y0
XzFfMV9mdW5jcyA9IHsNCj4gICAJLmh3X2ZpbmkgPSBpc3BfdjRfMV8xX2h3X2ZpbmksDQo+ICAg
fTsNCj4gICANCj4gLXZvaWQgaXNwX3Y0XzFfMV9zZXRfaXNwX2Z1bmNzKHN0cnVjdCBhbWRncHVf
aXNwICppc3ApDQo+ICtpbnQgaXNwX3Y0XzFfMV9zZXRfaXNwX2Z1bmNzKHN0cnVjdCBhbWRncHVf
aXNwICppc3ApDQo+ICAgew0KPiArCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gaXNwLT5h
ZGV2Ow0KPiArDQo+ICAgCWlzcC0+ZnVuY3MgPSAmaXNwX3Y0XzFfMV9mdW5jczsNCj4gKw0KPiAr
CS8qIGxvYWQgaXNwIGZpcm13YXJlICovDQo+ICsJaWYgKGlzcF9sb2FkX2Z3X2J5X3BzcChhZGV2
KSkgew0KPiArCQlkcm1fZXJyKCZhZGV2LT5kZGV2LCAiaXNwIGZ3IGxvYWQgZmFpbGVkXG4iKTsN
Cj4gKwkJcmV0dXJuIC1FTk9FTlQ7DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICAgfQ0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaXNwX3Y0XzFfMS5oIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaXNwX3Y0XzFfMS5oDQo+IGluZGV4IGZlNDVkNzBk
ODdmMS4uYjIyMWQ4YjgxOTgzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9pc3BfdjRfMV8xLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaXNw
X3Y0XzFfMS5oDQo+IEBAIC00NCw2ICs0NCw2IEBADQo+ICAgI2RlZmluZSBJU1A0MTFfR1BJT19T
RU5TT1JfT0ZGU0VUIDB4NjYxM0MNCj4gICAjZGVmaW5lIElTUDQxMV9HUElPX1NFTlNPUl9TSVpF
IDB4NTQNCj4gICANCj4gLXZvaWQgaXNwX3Y0XzFfMV9zZXRfaXNwX2Z1bmNzKHN0cnVjdCBhbWRn
cHVfaXNwICppc3ApOw0KPiAraW50IGlzcF92NF8xXzFfc2V0X2lzcF9mdW5jcyhzdHJ1Y3QgYW1k
Z3B1X2lzcCAqaXNwKTsNCj4gICANCj4gICAjZW5kaWYNCg0K
