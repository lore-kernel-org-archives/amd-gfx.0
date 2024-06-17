Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867A0C27C77
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jun 2024 03:35:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A441E10E145;
	Mon, 17 Jun 2024 03:35:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OL41rPQI";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCE0210E145
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jun 2024 03:35:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChW5xUSzbHwTTXKkxgYbV4bucWTXAP1dORltIPxK/4wsGE+dTNgnmv3pyFGI40xjZxKoZrR+dNpcTUQH3h2g+h/eb6c+vpsXSrU0wDuzR1ZNxrD5bYu7XKYJ6sEDPdX8V8fAIqlAn9KvLdMJINr3HAVdF4oUsEDVsoPig1rccIb10r44ZQbo4Js4gm9F6/9yFQS5MfeM7YipAmRwN8VMxDZilcLpjQJcBo0Q/P0NIJaj+KUUYCHC0Ld0ncHpmua9XSNIZyVDyBOmgglnIVwIfJRQydlkdDMJ3c7RfLnOKupo82j+zIAxtlNXzQQKo4DFml5PgcWB6rVkijOLKWyyhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J65oFjy8Fm7mYzpkksk8jXyq3gE9CKlVZzrYtdh4BvQ=;
 b=CyKdC+Pqj3zmhIUMlJJfG+ltUaSFN1/nTrIl5dlzToO0h4E1uFNoxJUdZv5dVeqZusbM/Bbv2jw7lmxZkV/WX6ZIl2WYp8l46qHInvUupaGAZpGJlwDuFXSWfwpdXsO1ecP8yq6YsfAZx0SXjFyMKZumI3/CBNLwSL9r5PNTq5MEZJ81Fw2Uwrzq2caCX2CJculgHa87hfTFLhMHeKdQ1ghQTSfOU3tHS56Xjq2Qq9lMS5TP4dV8dxXPZpTdmv+5C8G9EKhavPIi7/5HDxH5o/LPEKJgqJ0/DnQRYIoX3dR4BJdAtvTEvVdaM9UPROIx91BICT1hffsAbSneXkdmwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J65oFjy8Fm7mYzpkksk8jXyq3gE9CKlVZzrYtdh4BvQ=;
 b=OL41rPQISSc/aQPeQKEfqFmJUHbcrkyEBQq0syf9Kb3emALkZMrHOLH6UKV7/v/iJHDq6tvxthjM5kKzplxg2wrN67DHCKCPb9vWdHUsIW/KPiweoI4KxSZ2Sggv0XwHfbAGoY0vTwIcuecCUQDQggpf/zezrWnjNutc5SN6A/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA0PR12MB7650.namprd12.prod.outlook.com (2603:10b6:208:436::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 03:35:35 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 03:35:35 +0000
Message-ID: <80e5c672-8815-4a46-9fe7-406ddc0ab391@amd.com>
Date: Mon, 17 Jun 2024 09:05:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: keep init xcc0 for all xccs under sriov
To: "Chang, HaiJun" <HaiJun.Chang@amd.com>, "Jian, Jane" <Jane.Jian@amd.com>, 
 "Zhao, Victor" <Victor.Zhao@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240614111022.236072-1-Jane.Jian@amd.com>
 <2bf881e2-9db1-47f8-b8ec-dee5dd7a295e@amd.com>
 <DS0PR12MB780478C3B4C8DBC2E973191497C32@DS0PR12MB7804.namprd12.prod.outlook.com>
 <DM6PR12MB4958A0DA8096B0AA8AC10A9B81CD2@DM6PR12MB4958.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB4958A0DA8096B0AA8AC10A9B81CD2@DM6PR12MB4958.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::25) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA0PR12MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: 13690c52-97b1-4b07-bca0-08dc8e7e8c25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TkIzdzk3SlZlYmZad29EUCtpT0hmWjVvY3I1ZTBpN0dkcTJOdU9jRlBxZ2dY?=
 =?utf-8?B?bU1nK1p0Vkx1eGlVc0xnaDhXMW9RUGo0c3JKd2JMVGtmS1B0TmlIRS81Nisz?=
 =?utf-8?B?cDdIVnhUY3NmemNSaEhrVWpwRFozQThrMzNSOXFCUDVSVjRIc1ZWaDhVd2dh?=
 =?utf-8?B?QmgrODYybXd6dG9wamw3Vjg5Vjc3U1RvV2MrbGZqSGZ4ZU52Mk5Mb1pyVzBM?=
 =?utf-8?B?ZVN6NGtwWGlIV29aRHpNcnkxWkZlSm9uTk14WXdURllVR1J5RjNBVWc2OW1n?=
 =?utf-8?B?RlpGQ0VaTmFvMmJsYzBZZFZta2V1bHk1Q0JxTldsZXIrQUp1c1B3WVQ3R051?=
 =?utf-8?B?UTVmZjJYTU9PSGhpQlQwU3phVHNlK0cwcDBxWjB6TzNEYUJjMU1JUXdkR05H?=
 =?utf-8?B?YzlLVDlVdWVyTkxjL2I3NGZpV3Aza0pBeXJjbnYyd1hZNjkrcTVKZTdQd1JB?=
 =?utf-8?B?QlJBWEZydjBzMUxrUUlHemJHeEpBazFJZzBRWldBNUxCMjYzQTVyN1UydVFx?=
 =?utf-8?B?MEdPdlJjUHVMbEhZdUlIVGlpKzlBMW1UZjc5dnladFh3bDd4bHRSUi9mVWNP?=
 =?utf-8?B?akRjQjJ3YytEeVVURXdQSXJlZHBWSFU3bXgzZzR3TW95TllwTmN1bTUrVEVR?=
 =?utf-8?B?MjVQdWdmUkRTWlRiZzl2cEdZYzdFbkZpbkNnRnUxUE95eVFYRFloT2xiOGg4?=
 =?utf-8?B?YUhISHJLci9ET2dkV2NKSWN4Q0dzUWtaZ1gwSHFLR3cySU1IL01kOXY4cnN4?=
 =?utf-8?B?N253SDZuak5MZngyWG5GQ1FzUi9LMHo0RXNoamlWOHptT0FPQmJoQTdZNjhE?=
 =?utf-8?B?MmJ5QnpWRitzejViNm5hSUlzMk9MYk5YVXpiMXFNdXJJaEI5d2wvZmswdysr?=
 =?utf-8?B?b3BzMEZLemFRVGpkWWtZVmwrRWxRTExHYUpKWVlzN2ZEV2x3OU1aMkd1SWZY?=
 =?utf-8?B?bXcxc1JFZkNwcE9MaGxWQWVMZE02TWRQVmNNWWV5bXc3clpEd0p0ZTFaNjVT?=
 =?utf-8?B?UWdiRTBPOVlhc3JEMkdlZ21Pc2toSEF5TFNTbkkxVVl5V1ZFM1ZmSjlQeDFJ?=
 =?utf-8?B?V0VBeW5pNjdTV1FleUJCUFI5eFdqUjFMSGdRWkFJalMwSE9YNE9QRFlnTjh4?=
 =?utf-8?B?Q040b0NCNXE3eHBrRFJGaXdXdXlza1pyL3Y0aG1FbjNkMFpmVnN2a3RsWUx0?=
 =?utf-8?B?T3BGaStCcXdhaEJMT0RQUVppbWVWMEJZalQvcHUyTHpnaHh2OElQc05Rby9Q?=
 =?utf-8?B?WCtSOUhNR3U5RDZkajZlM01ZNDhYa2hKcldCNFNubjkwM3ZYRDM5YjVJQktC?=
 =?utf-8?B?NEZ3TXgzTmlrWjRUSDBrc05JQUhnTUs3NTdpakRRM1pnSFg2Z3dBOXhsWm1n?=
 =?utf-8?B?MnkraU9oMlZQZ3p4TjhnY295OG9QSDdNWmw4T0VTeTZrellqQmMrQVEyYTlU?=
 =?utf-8?B?eHNlcjIxT0Z2dFkwa3pEUzN4bjZocXB3UE11OG14NmVENjNOTXBQNVZ2OGw1?=
 =?utf-8?B?dExRRkhWWStEVmVsVU93WFJEakt0WUg0ZkZIeXBub1ZGaFJ0dTNjTkwwR2ow?=
 =?utf-8?B?bXBlSFg2ZnFpZVgzZWI3OUpLYkN5cEN5OWN3N3Mvd0I0MWs5cGlwR01Vekk2?=
 =?utf-8?B?UHZVLzRVNitjWDUxZHdEa1IzWEJkeFgyMXZ6YlNqSFZ3Ny84UWcxaWthVWhk?=
 =?utf-8?B?YlRLT3pYempUcFBEL3dzYXRMRGwzTUM5MnhkMUsxQkhuSzlmd3pXclpHNHFl?=
 =?utf-8?Q?/Cr3UIfc47tUCn9jTS3iai2zHQD19Naj7cl2ltY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlRuWHV3UHhUOUwrVXhYdHN4NGhmT05UY1Vhb01YTXJaWDZhZjdNa28vbVF2?=
 =?utf-8?B?aHFuQ3Z6ZFlHcUM0TU1Ld0VKRVVWSXJFNEFNQVRmcjdDamloaUpZUGZiOVN5?=
 =?utf-8?B?am9HQnVEcVlweCsyUHc5V1kwMGZGbythUVZLL01nMFJSZXNCdld6T080dENw?=
 =?utf-8?B?WTdUdHZqcGIwOFdhdjZtblNYYys2am10ZUZpelF5NHhvVkFISmlVKzBBQ3Nk?=
 =?utf-8?B?OHpTMWxOT3l6cTNQczlGVU56a1VINldvMjhhMUs3cE15aXJrL25FMDJva0tR?=
 =?utf-8?B?a0ROdzlOc0MzSVQ5d3ZoK0g1MXdLR05sdDZaakVqREJ3YTB1ejFCdGkyaURa?=
 =?utf-8?B?Z2x4YlRwNTdnZy94TlBOdXplc3dKN0xjSkZKdVQ1ZEIxa0h2U3NuR1pGMC8r?=
 =?utf-8?B?RDBZNWdPNWJQNXlLNU1SLzJKWXlERisxQkwwd1IvSG45Ni9Ob2FTckdYdURM?=
 =?utf-8?B?dEJtZkc1QnNRcWY5VVBXcEFBR0RZSC84UWRLdEpxT2c3OURwSWZPeDYwQUZu?=
 =?utf-8?B?dUFpaXozVFVERW1mWDdyL1lIcUF0dkVJQ0NuSnI1K0VQRGF2ZlNJUWdsRzJa?=
 =?utf-8?B?OS8rWU9RTjR1dWZHN25mTlN6KzZ5NG0zK0RPREFLVi9ycWFtbDJNZnpVK3Yw?=
 =?utf-8?B?U3p1ZkoxaDV3SUxDb0NvUzE3QURiRGdQL3ltVlN6MGtjWFFlWWwvTlhGVU44?=
 =?utf-8?B?RFBnU1p4ZmpLYXpTdjMrZ1BlUk1odDg1QjdnbnEyN1ptZEpFQ3FHWVllRDJj?=
 =?utf-8?B?RTlyRHBwdk0xdlZOMGhmZmU0bFFUMGlNNURpTk9ZckhNSGRZQjVJOVpsWVc0?=
 =?utf-8?B?c0RLUEdOemVsblhpL3ZGWVMxMWVzSzFIZmxsTkVYSGZ3eWZmQ1lGOGtzcFdH?=
 =?utf-8?B?RnlEYlBic1lMQktIUGFkMGJ0UTlYb1pLSnRwdEFteHhQMnJDTEY4UEFGMDU5?=
 =?utf-8?B?aHlzT0ZwM216OGtkalNlVGJmeFBkT09aOW1acXF2dTVKSzdoSEx3TmRVUVlS?=
 =?utf-8?B?clNqZCtnc25CdG81Z3hCN1lHRUI1bmc3Rmx1Wnh4ejVaQ1Z4M2c2S3lYNDFS?=
 =?utf-8?B?RHYyTldSc3k4OUlzVTkxNjJSZEp2L0d4U2FWR0t0TmZveDhGOHpseGlBY29U?=
 =?utf-8?B?a3dPVUFZc1lmRDR2SWNyU24xWmh2OURpYnJwSDBXVEpMbk9yUmd1TjNLNG4x?=
 =?utf-8?B?anJNMXhNaGRjM0pndk9tK1pncXFTY2xFOFZuWGsyMkx3cHVwSWNFMGJTOXhi?=
 =?utf-8?B?aGtLbVhScnBEUFNsays3TVpBdks5TjB5UzhkODhRNllRbEo2T0Y0TmMxR0Y0?=
 =?utf-8?B?NXNPWkozNnM2SjBkRXlSYTZKYVhHMng3dHdUS3Nwd1BmVDhyOXBNeTUvWVd4?=
 =?utf-8?B?Mi92V0NzVUdTdTUrU2pjWTkyNmR6d0RYM090blBjczUvRDBSRHVvQ3Fhb1RT?=
 =?utf-8?B?eTFXMGFndWxhclR2ZnNHRWQyQWZqUU56bUEzdHI1eHYyVDBWbW5EN2tOd3RD?=
 =?utf-8?B?Q1ZSWm80Skl3N1JDZGMxTHU5Uzg3Kyt6TU9lc3NKblRvUU9jV3FqM2x4Q1Yw?=
 =?utf-8?B?bDdvRmt3ZVVnVEF1dDZDYzRCTmozUXVLNEdpVDNHckxQalFDZ05HRzNLeWZU?=
 =?utf-8?B?Sml3bVRsTWhrZ1FQdkpTK3JBR1hkV1pGS1JyaHZzSU9UVnZhc0pLVWlmWXZX?=
 =?utf-8?B?eUxsMWdTdExSOHUvWEROSWlpcG9LYlQ5QXQzZCtKeW5VRlNBN3ZBbStPSkJq?=
 =?utf-8?B?QzBOV2VpZUN2TFVpQUhkWkFhT2RHMnlkcEs3ckgxR3hnd1dVeTBtQ0Q5Tmd0?=
 =?utf-8?B?bzJTdnZxM0k2TWE1ZUQ0cmNTTHk2SG5vc1dJajdqL3VjTmJBS0pQQWJJOEZY?=
 =?utf-8?B?UExBSE1FQjd2ZlIyd1RGT2ZGYW9jVXZLbnFWTVJuNXViS0NkTW5KNG1QZ2lx?=
 =?utf-8?B?MEdTODU1NFVMRlpnendaRnpKRjl4MDFjZlRTdjY5L3RGSDA3MGVqSDJJaS9R?=
 =?utf-8?B?bGwvWE9GSzZFb2FOdkZRVTFTM1l5dDNOZmNzQmVEdXlrbzJPUVFaUnV2T2x1?=
 =?utf-8?B?aStJc0pDajMvUmc3b3MrUWJvcVQvMzlFeUpqbDgwQ0FHMHZBMkNzZm5XUEcx?=
 =?utf-8?Q?9AvDyhdbCUeM+sdR/Areph/qX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13690c52-97b1-4b07-bca0-08dc8e7e8c25
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 03:35:35.1239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EijqDzUWbU/GgiehtpS68LFiG1oPikJbeJ9Um6E/57OIeE8D8jcfEgTQtdMC5mO4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7650
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



On 6/17/2024 8:58 AM, Chang, HaiJun wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> 
> Hi Lijo,
> 
>  
> 
> Right, 18bits are byte aligned range of local XCC register, 16bites are
> dword aligned offset range
> 
>  
> 
> We find the normalization needs to be applied to many functions, like
> 
>   * KIQ: amdgpu_kiq_r/wreg/
>   * RLC: amdgpu_virt_rlcg_reg_rw
>   * KIQ: amdgpu_gmc_fw_reg_write_reg_wait
>   * KIQ:
>     amdgpu_ring_emit_reg_write_reg_wait/amdgpu_ring_emit_reg_wait/amdgpu_ring_emit_wreg
> 
>  
> 
> For sriov gfx register access, it only has 2 ways: rlc or kiq.  Both of
> the ways can use local xcc offset,  so we think it’s simpler change to
> init the gfx register offsets with local xcc offset only.
>

Ok, is this the only place? What about other calls in gfx_v9_4_3 like
WREG32_SOC15_RLC/WREG32_SOC15 etc.?

Thanks,
Lijo

>  
> 
> Thanks,
> 
> HaiJun
> 
>  
> 
> *From:*Lazar, Lijo <Lijo.Lazar@amd.com>
> *Sent:* Saturday, June 15, 2024 10:09 AM
> *To:* Jian, Jane <Jane.Jian@amd.com>; Chang, HaiJun
> <HaiJun.Chang@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>
> *Cc:* amd-gfx@lists.freedesktop.org
> *Subject:* Re: [PATCH] drm/amdgpu: keep init xcc0 for all xccs under sriov
> 
>  
> 
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>  
> 
> Never mind, bit 16 and above is probably because of dword aligned offset.
> 
>  
> 
> Any reason not to do this in kiq/rlc based writes to normalise all?
> 
>  
> 
> Thanks,
> 
> Lijo
> 
> ------------------------------------------------------------------------
> 
> *From:*Lazar, Lijo
> *Sent:* Friday, June 14, 2024 5:20:30 PM
> *To:* Jian, Jane <Jane.Jian@amd.com <mailto:Jane.Jian@amd.com>>; Chang,
> HaiJun <HaiJun.Chang@amd.com <mailto:HaiJun.Chang@amd.com>>; Zhao,
> Victor <Victor.Zhao@amd.com <mailto:Victor.Zhao@amd.com>>
> *Cc:* amd-gfx@lists.freedesktop.org
> <mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freedesktop.org
> <mailto:amd-gfx@lists.freedesktop.org>>
> *Subject:* Re: [PATCH] drm/amdgpu: keep init xcc0 for all xccs under sriov
> 
>  
> 
> 
> 
> On 6/14/2024 4:40 PM, Jane Jian wrote:
>> [WHY]
>> sriov has the higher bit violation when flushing tlb
>> 
>> [HOW]
>> for sriov only init XCC0(lower 16-bit) for all XCCs to avoid higher bit violation
>> since kiq ring is always local, local address without XCC ID is enough to be sent to the XCC KIQ
>> 
> 
> The description is incorrect.
> 
> Bits 18:20 represent xcc id. To guarantee all paths pass a local
> address, you should just strip bits 18:20 in kiq/rlcg read/write
> functions rather than here.
> 
> Thanks,
> Lijo
> 
>> Signed-off-by: Jane Jian <Jane.Jian@amd.com <mailto:Jane.Jian@amd.com>>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 23 +++++++++++++++--------
>>  1 file changed, 15 insertions(+), 8 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
>> index e14acab5cceb..4e38a66a52f4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
>> @@ -537,29 +537,36 @@ static void gfxhub_v1_2_xcc_init(struct amdgpu_device *adev, uint32_t xcc_mask)
>>  {
>>        struct amdgpu_vmhub *hub;
>>        int i;
>> +     uint32_t gc_index;
>>  
>>        for_each_inst(i, xcc_mask) {
>>                hub = &adev->vmhub[AMDGPU_GFXHUB(i)];
>>  
>> +             /* for sriov only init XCC0(lower 16-bit) to avoid higher bit violation */
>> +             if (amdgpu_sriov_vf(adev))
>> +                     gc_index = 0;
>> +             else
>> +                     gc_index = GET_INST(GC, i);
>> +
>>                hub->ctx0_ptb_addr_lo32 =
>> -                     SOC15_REG_OFFSET(GC, GET_INST(GC, i),
>> +                     SOC15_REG_OFFSET(GC, gc_index,
>>                                regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32);
>>                hub->ctx0_ptb_addr_hi32 =
>> -                     SOC15_REG_OFFSET(GC, GET_INST(GC, i),
>> +                     SOC15_REG_OFFSET(GC, gc_index,
>>                                regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32);
>>                hub->vm_inv_eng0_sem =
>> -                     SOC15_REG_OFFSET(GC, GET_INST(GC, i), regVM_INVALIDATE_ENG0_SEM);
>> +                     SOC15_REG_OFFSET(GC, gc_index, regVM_INVALIDATE_ENG0_SEM);
>>                hub->vm_inv_eng0_req =
>> -                     SOC15_REG_OFFSET(GC, GET_INST(GC, i), regVM_INVALIDATE_ENG0_REQ);
>> +                     SOC15_REG_OFFSET(GC, gc_index, regVM_INVALIDATE_ENG0_REQ);
>>                hub->vm_inv_eng0_ack =
>> -                     SOC15_REG_OFFSET(GC, GET_INST(GC, i), regVM_INVALIDATE_ENG0_ACK);
>> +                     SOC15_REG_OFFSET(GC, gc_index, regVM_INVALIDATE_ENG0_ACK);
>>                hub->vm_context0_cntl =
>> -                     SOC15_REG_OFFSET(GC, GET_INST(GC, i), regVM_CONTEXT0_CNTL);
>> +                     SOC15_REG_OFFSET(GC, gc_index, regVM_CONTEXT0_CNTL);
>>                hub->vm_l2_pro_fault_status =
>> -                     SOC15_REG_OFFSET(GC, GET_INST(GC, i),
>> +                     SOC15_REG_OFFSET(GC, gc_index,
>>                                regVM_L2_PROTECTION_FAULT_STATUS);
>>                hub->vm_l2_pro_fault_cntl =
>> -                     SOC15_REG_OFFSET(GC, GET_INST(GC, i), regVM_L2_PROTECTION_FAULT_CNTL);
>> +                     SOC15_REG_OFFSET(GC, gc_index, regVM_L2_PROTECTION_FAULT_CNTL);
>>  
>>                hub->ctx_distance = regVM_CONTEXT1_CNTL -
>>                                regVM_CONTEXT0_CNTL;
> 
