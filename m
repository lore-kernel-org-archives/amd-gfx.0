Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD95DE9B25B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 12:50:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E3E110E575;
	Tue, 24 Feb 2026 12:50:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jHkDt6w6";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013047.outbound.protection.outlook.com
 [40.107.201.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1E1210E575
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 12:50:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JsWQEvESPY3lR68C5kxv/+4hDbqIQqXrvKpNxFldeWKqu8PwqrnqZZYk+vDSyRvVGYlKN7BKHh5SHvnwDVU8+FtZft3ts3LpYqzi9CxDmxi4pGeW5M8iBC972hDp5wJ1es/7jKGAjBDp4s5KsyWHINLwkVK0l4snavkxVG+xWUbxkI6KXrVCP069J/x6BYKlCOZERhIBiT7dlwrj5davALPzLW67f33WS5VrebesJIQI5cWOZoDIaNGTt3/xiIaWzJgaA07286KVEXkjKktjmbFBlT2mtRYnKA+nlHkhjB3cdnEcSCcj3UKX/Wt75uwwinXGmCHfO+WjPTGlME79oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ua3MqO1tJISy9G18h5G9IRAbFU0UVMXdtVQtextKWMM=;
 b=qswwK3bgUu5TH1ssMGPoY5obCf8thHrhIfuQ55cpqEdX6fwE2qw0XjpnWZtM/CYTd0mViGv4c4UdnzRojXRhSeiEd8027iT21QlhhAD4fir3Zk/YQaLQdOFQ3ME58I2xLA12snaKTTYO2vx6LryPsm+9OQzCw83Rm4IcB5rDRTUorVymxY1CfePvKwo0YdPPq88Zf1milZvRHv++W226lbXI1uLv2F//4jJiuNM+8mbrgirysdYRKufdPfe6I4rUj9AX+y+zmYq6DnCX6pdcqx3p/b0/3EiwRl0bKhOYV2//ylt8ifArM0RYeiQAuvpu6PFX6hewRiMS15JsYTEwTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ua3MqO1tJISy9G18h5G9IRAbFU0UVMXdtVQtextKWMM=;
 b=jHkDt6w6j26dPtYsLeJgEdnrVCws5u8oPQKNvhYXLvi3T4uEQlEXfIKr9n/cy0wMwkrORszkIER6yRpaJRLGAPduZDFD/1sOfYhbHjMMA2RvwJbjVukTvvtm+fbaY5yC1MguoCcDF9R2CUqHSXefR14pBmtQjiEMyCiVprFFaKE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CY3PR12MB9630.namprd12.prod.outlook.com (2603:10b6:930:101::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 12:50:34 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 12:50:34 +0000
Message-ID: <3dbe7fa7-e498-4cab-8b96-2cee679e0eb5@amd.com>
Date: Tue, 24 Feb 2026 18:20:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] drm/amdgpu/userq: initialize gobj_read/write in
 amdgpu_userq_signal_ioctl
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260224091118.4017760-1-sunil.khatri@amd.com>
 <20260224091118.4017760-2-sunil.khatri@amd.com>
 <062ce56e-5d80-47c6-88e7-c45f5f72dec9@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <062ce56e-5d80-47c6-88e7-c45f5f72dec9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0229.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::11) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CY3PR12MB9630:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f75e99-6371-4466-3f08-08de73a34cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VnM5UG1KTlEveE1FNWZsSDl1SlJiQkJPZVdHK3RhVTFTY01NdVFQS0N4Z1Z3?=
 =?utf-8?B?YlVDVmRtbTdGRE8xOHpGZWQ0WlFIMlgrMlFydlJPT1UzOS9GaWpvQlBNOTlu?=
 =?utf-8?B?Y25hdTJGaEZsTjFNdktaSVBtME9xT09yOHJ0YlpVQUFNNVkxTklxL20xV1BC?=
 =?utf-8?B?SHNIdnorMUU1MFNzdUVlTmNqa3diS1h5L0pIeE5HSWJlcldCd0huUG1XWHIy?=
 =?utf-8?B?aGtQaGNHYTBBVzRIZkVVNDFodWdWWXdPanhLd3Fma09ZZ0hMREE1d0pzOWhq?=
 =?utf-8?B?bFhtODZUWldkMERDRUZUVGkwdlJVZUdhc2FnTDkwaDNxVUhCbHVRZDNBVmZF?=
 =?utf-8?B?RWRIUy80U0w2VXE3c0hlaTNtbm1aUFZoUittTlR0bEtVVHl0L21pMlAvcGFp?=
 =?utf-8?B?WStxc0lUblVDOW9mS28remxYTFpBaVlQMGZ3T1FGajhyOXREY2FJSmlmL3o1?=
 =?utf-8?B?K3Q4T2VNYm16aTZSM29vM2lqUFJPOG9ha0g1d0U0MUZnWU92VThQRTcyRFln?=
 =?utf-8?B?RFd4aC8yVzdwL3RnL3J3MGxjdVpIczBZbWlsSTZteUY5Q3VjR0JBZnJXQVdw?=
 =?utf-8?B?dlQ1TEh6QS95U2NmajRxeW5Vd1I2a2kxZHZPMUNWN2pHWjVUMEdoRlBxcDcx?=
 =?utf-8?B?dFNHajduVExCVjkwcmhVNUowVVA2TzVRRnNZeVhSdStVc2pMNTB5RWNGcTZr?=
 =?utf-8?B?clVvMGlFYjA2emhYM3o0QlRCUXlhYWlvK3RzM1dESzhQOHdiQlk3cFlEak9N?=
 =?utf-8?B?QXhYSFA3TzdhSDQ5VDVrYnVDZFFqb2JxSzNjNkc1T1h5dENwY25VdkhEcmNV?=
 =?utf-8?B?VmhJcjZvS1pLbVpxTWZkRVR0Nmp0ZExXNGVUV0R6ZkpySzhHcXc2UHJsbHNL?=
 =?utf-8?B?Ynh0by9Sb3lQVTM5aEtabG5rUkYwL0hrUlRKeTg2UUdTV2NzWkZxMWxxaml2?=
 =?utf-8?B?NWVDWTdET05SNlpINGV2cVFZc1dRbi9qRDIrWTc4T0tGaE9razF3bitqUFdP?=
 =?utf-8?B?VFBqeGhTTGtyQnFDWmcrT2xBcDZCYTk2aFZoeFdVZDlydWlKK0p4bGFoM284?=
 =?utf-8?B?TG9MNm5ReFNETU5hUGdwQTBiYTliUmtmRW92NVh4WGdzcjVST0FEWXpxNzh2?=
 =?utf-8?B?UzB6SlhGa092NTVWSVlDNEx6bjd2Z0lIeUttcE1NYU5rRHJTWVFoRFBkWVQx?=
 =?utf-8?B?SXc4YXVaWTUwMGZzVlhMQmd5OTQwaUNjVDN3MzMyYzBkUGY4TTltSWZsaW1M?=
 =?utf-8?B?REkvRFo1eVN2eGhUbHJjV2JQbFozYlJVdXNVMytQbFJncmI0SjJRaEVrbUNt?=
 =?utf-8?B?SXNITnNCbWIwZTc3bGQ5VytLS0IwNm4yZlh5L3VFU1Nwck1XMitTUklEdDA2?=
 =?utf-8?B?T01mU0hoVzcvTFlkcmJQRHBocEVHVEp3Y1hVQmEwd1pUL3Nxbk05dmhGeFRy?=
 =?utf-8?B?T1RKeHo2QWZtaHFMV1BJMHo4M1huc2QxM0dGQWJvL3ZqdlpDWjNFSEJiRExV?=
 =?utf-8?B?WWs0YkNiOHpFOEdpSmhDZzZuR3YvR29GdjU3VUhUbEZsUlhoeWhUOEN5eFAy?=
 =?utf-8?B?NW1EaXJYSUNxMlYxVlovK0NpZENFMktHUkozWFRWMnJ0N2d2dm5yVi9QTmZX?=
 =?utf-8?B?SDIyNVVzT2s1ekRsVllRTzJhMkV2d1YwNjNQczRLVmJzWGtKT1U5dVFySUEx?=
 =?utf-8?B?VitLT3hkRHU3WUVvbStQaXlIVm9ocXpvWkdoUFlKUGhIQXMrMVhQWTZGSUxi?=
 =?utf-8?B?RnVTZHM2bmQ2d3p3bi9pQTBhd2lqRXpadVV0Slk3dm91QnplZGZBUE1BNCt6?=
 =?utf-8?B?SVJYTnYzaXNldmkvZ2RtVVdpZkd3MGMrQ21NaEtKTll1NXgxMThHaUdVK2dp?=
 =?utf-8?B?eEJ5aFd4dUxkVFQ3TWh0Z1NqY1FqWmdEYnlKRGdhcTAyY1RPTURjT0lzVVll?=
 =?utf-8?B?emdoNnBuRW0vVWJYWElWQks4YlRYcWlEcHlRUzFkdWhDZC8wL2oweFJqL1ZR?=
 =?utf-8?B?eVBaQm8yMFFpbjVQTFZKamZROGdSa3l0MlZ6WkhLaVVYZEppVWl0OE8xZVlx?=
 =?utf-8?B?YzNWZzJVbEo3N1R5NDVNQVpLS2U1ME1ha0piQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHhhUkJoVjF2cHdEMGFoOGc3WWtHL1hLNmR2QUJxMHpycCtUNmRwSzlSSGpR?=
 =?utf-8?B?QmpVbE9hYUE5akUwMjVDSFNWOHk5YjEzd1lqWlBoVUxTcjRLT2Z6b2Y1cWg5?=
 =?utf-8?B?c3NKWnpZWkJVTnkwSVlZWVZ5aHJYblZTRjN1VDBabnd3dHNxclg3OFpQVVdz?=
 =?utf-8?B?TE4wc1d6NUsxaWF0bUMvb29SYkRpSGVPMXpFNVdDYUYvMnNhbE1BUU9aaTFH?=
 =?utf-8?B?OWpoQXdnbFNHbVV1SUNJM1VjWDFVd05rc05hL2tNRzg5VWxkNklvYm9IZjBI?=
 =?utf-8?B?QlkycmpWSCtkTWpBVVkxR3Y5MzBHc2RWajlIZUFBZ2pueWZCaTlaenR4WXM4?=
 =?utf-8?B?TzdXVUhHVnJFcTBSanI5aXhydGF2M0VxMENzaEZWTFd6REFOQzQ4Tlk5dlRW?=
 =?utf-8?B?QjdpVUFLM1RISzBnMkFyR3RDWFNsSmZjUkp2cjVYaHp5cnV4SGtoM2VnWVBG?=
 =?utf-8?B?ZkxKeDRMWWVqVEk3UDlCS2doUmRodkUzcUxKTzNZYlowL2FuWEh3cStQVVIx?=
 =?utf-8?B?d2c5V05neDdibXFJT0JMR3Npbk0xTm1XdExXK25ZU1dSZlpNNlUxaFhmb3FO?=
 =?utf-8?B?Wml4R1Q5MmR3Zit3Vzd1YUNJcHY2TFplSHJObVBUWCtsUWRVTU8zSmh2QU9v?=
 =?utf-8?B?bVM1MFF4RnBqWmp0RENkNUZFaUdoYm83dHNTeE1PSDhnb0V6TTRmaEpCWm1o?=
 =?utf-8?B?YUx5MzdYdmxXUlU5M1lvOVc2eGdkc3FudjM4aDdhTGNlUGQvS3ZFR3dNaXl1?=
 =?utf-8?B?ZCtlWWR6aTBBRmt6dkhIY0NJdko2TmRRdmF0SDBhRXpPVU1rT2lpOGJWTTYz?=
 =?utf-8?B?cEEwRlRNejNDM1JESzhOZk5vd1hLK0FEcGNJMlJLREFkSmFmUnZpeEl4Ykxv?=
 =?utf-8?B?ZkNHV1NjRG5VdFJUU3F0MUxXb1VLbENiQnQvOXlTNW54R1pNcm1nZ2JjaVp6?=
 =?utf-8?B?M1lFRURsbXdJbkpaNFNCOEo4RUdhL0xwVGVZUVVaNmxRYzhMWDZxdFRLN3ZU?=
 =?utf-8?B?Wm1TeUcxQUZ2aU1WOEUzVGUwQTl2NGpPT2JEWnY3NFFYdG81ZjhaQ0xuMzJO?=
 =?utf-8?B?aUJicEN0eWpjR0VKSG5WNzIxRlA3MGJUWDI1TTh6cytxRFpzcHhjdHQ3cjRF?=
 =?utf-8?B?R295UTdFTGRjVllRVDFPTjdBUm1xK1JhMnl0TXRZcHlHSm1FM1VpZlpzVHpi?=
 =?utf-8?B?MVovRDFlZFFFdHJpRW4zcGxUNWZuUkZpR1A3UFFYK2VPaGNuNGx5akpmcnIz?=
 =?utf-8?B?c2d0QWYydkc2VmxoSm1JMTZML2J3blpTaERURFNLZUEvS2k5ajZVWDVlODdI?=
 =?utf-8?B?VXYwSmkzNk1makNtQStiMnNhV2VTMTMxZ3pYWmtvTjN4SFE0emZrUGpRVk1Y?=
 =?utf-8?B?dzJTbXE0WFJHa0dMYThMbmxQN2VMUDBtc1EwKzJyVDBPY1FmMFI5S1dLY0JK?=
 =?utf-8?B?RU9Zc3hua1lvWUpxcHg0OWpBWkJWdTZ2TlhWYTk5eE5RUnh0QU9zU1h0N01p?=
 =?utf-8?B?eUo4TFc0K2pCdUVhSjBlY3lKVDV4RnF2N2I2SlBiVy9kV3AweVdIbUhVazdl?=
 =?utf-8?B?SHdJSjR4eHp5QVJxQjFpby83VVQvcU1iOXE1bTZUR1EyUGREcHZhY0lMWllY?=
 =?utf-8?B?bC9kaXpzS204OVlLTWhHMVpQWXVpTmJCdTRIQ1ArTFZ3TlZiOFRRTGpObUVR?=
 =?utf-8?B?NGx1NFQxM1ZpZERzUzlOOFU0MHV1OHJMR0kyaE04UEgvdWhibWhoUjIzUDhu?=
 =?utf-8?B?am0yM1dFRzhmYlg0TWNEbkZQc1dYdlJqbkQvOTZma3pZdVpFT0o1OW1KcXA0?=
 =?utf-8?B?K0lOUllNOXMza29ocWFVRXcyQ2M3a2EwVzl0eE9nMWxWUlVZN2ViSUdlcWxw?=
 =?utf-8?B?OS9GclhFMTRiZlltMXB0eVJjS1Z5ZzBkOVJFcFc1eGVHRWlJM0JWTXBRTWRo?=
 =?utf-8?B?b0I1MGcyWlhiUzk5bzNqNUlETzROd3B1bXVETHVnZVdxTHNnaDhLQlFRSjRn?=
 =?utf-8?B?ejVpS25yRkIyczc0ZG85NUdFRlMrTys5NEk0MnpXTEViaGJzbWU4Y2o0RUpW?=
 =?utf-8?B?cW5rQ1ZFMG0vRm5HZnBuQ0EvQU9FUERyQVBuOUc1K1hqMXBqaFU0b21hU2JD?=
 =?utf-8?B?bFNPQlZaejVLa2VFVTNNQ01GWWova3BZakZGTFVyN0pFQkJoVHJTN3YxVE5y?=
 =?utf-8?B?R2xQZTVFYW1SSTlyWnAreEh5cldnNlF3V1QrUVpVNnp3ZDJ1OGhtS05abWNs?=
 =?utf-8?B?V3ROU3BYVVc3Zm5pZ3JSTkxDT0xtdXorMit5RFlTZE5Oajd4Szc0Snl1V1dI?=
 =?utf-8?B?NGRmVnRFaHZlVWNBZ2d6cFdNRS9QQ2NRdjhDRmtoRWYvSU1Gc1hvUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f75e99-6371-4466-3f08-08de73a34cc9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 12:50:34.5341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kw41+dvW9if2Lb2lGC4SxbJxI/ELQ9Ra8lRlqbWfB2MEsjodyQ5h9RYbide66+glVKmlIg7vi9ht9RzcEbB4Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9630
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


On 24-02-2026 02:58 pm, Christian König wrote:
> On 2/24/26 10:11, Sunil Khatri wrote:
>> In case num_read_bo_handles or num_write_bo_handles is zero the ptrs
>> remain uninitialized and during free cause a fault. So to handle such
>> cases we better set the gobj_read and gobj_write to NULL.
> Yeah that still doesn't looks like a good idea to me.
>
> We intentionally avoid nationalizations like that if they aren't necessary because that allows the compiler to complain about it.
>
> Christian.
Sure Christian.
@Alex, can you pull in the drm-misc-next to have the fixes in ASDN, or 
if it is supposed to take some time then in that case i think we need to 
push the change no 1 and 2 to ASDN as signal/wait IOCTL are broken right 
now.

Regards
Sunil Khatri
>
>> Fixes: 3cf117572294 ("drm/amdgpu/userq: Use drm_gem_objects_lookup in amdgpu_userq_signal_ioctl")
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index 18e77b61b201..e53e14e3bf2d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -465,7 +465,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>   	const unsigned int num_read_bo_handles = args->num_bo_read_handles;
>>   	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>   	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
>> -	struct drm_gem_object **gobj_write, **gobj_read;
>> +	struct drm_gem_object **gobj_write = NULL, **gobj_read = NULL;
>>   	u32 *syncobj_handles, num_syncobj_handles;
>>   	struct amdgpu_userq_fence *userq_fence;
>>   	struct amdgpu_usermode_queue *queue;
