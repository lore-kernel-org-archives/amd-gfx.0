Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CBDC28B2F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 04:24:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 724D510E1FA;
	Fri, 14 Mar 2025 04:24:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="se1M0THF";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6017E10E1FA
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 04:24:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACFw9yFqTqFv+tAR0vIS7laGIQKobwimoyP0hIUClytlaUVBA51xD2WhXWwOdefFjtpJcZw2zxekfU/SbPVYIjdK1u3rZDf79qgF1sh83BlgC4sctWuXWfuSWA/3fe8fwPuCV2xHh2zIUlDZB85Bv661gELJzGM6EhfIZBbs/iKTOyi2PXu6cFehp2nFsp+g2UV1srsjhadicJoeq2HDAZZyQmStthXR5r4+/OmnYV9e6sey5iZTPC4oKquWu2JCwbq4WQlrdXIZVGtZmZe3ySzkTMshDHOX5FGREbXy2a8nUXcI7YfxwtyDGUYbRCUpPHKgV+uc1b8McfG7nXLZ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0jWlQpHUfoozvj5mF/AdUyYYnt+QpVf+J12lnKeMF4=;
 b=zTkHANcxAxC+bRg8zkJT2xuZOE3HBfg1RYH66AoCkybo7ZvqhTiVe5mlzmbM9tTJtBjsxnx6HexcKPXbtGuDeFh2YSIl6rx8Fz1EgAVMN+CsxNJkPcnYMlY4LegcBK4X47+VY3JBF42ZqXNBP216fVdl3nxaDiUXIsrxSGrQNy/pKoeSpi2BnqpBsTXy+muB5aq+k0vHLJ8270Lirv25zbqrCPHoCXpBpYZWsvJhw9W4tUMPSc2bUeGnV5DfVATDw8oU2a3VpSmhGuRCYTwDJOXXDXowkMS8/VhBwtpJAkbF4AebULDZzrUfTvM2U6Oe/V55zXajXATBFxcCyO7fHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0jWlQpHUfoozvj5mF/AdUyYYnt+QpVf+J12lnKeMF4=;
 b=se1M0THFdCKA33hbehkSC2Xdn8b2fI2yf0bH0VSKgkJ45XYRgd6HEco2PQPm563Lt8XOEEdoHRurr2Qh1DKTjcRljoLCiXfiodLuTluCeZusKWHLGEP1gA4d0pbw+zcRPflXJvA0bsrdMQjYoafOxegQH6T85PftTbyqydp+2gA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by PH7PR12MB7330.namprd12.prod.outlook.com (2603:10b6:510:20d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 04:24:19 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%5]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 04:24:19 +0000
Content-Type: multipart/alternative;
 boundary="------------UOwuZiz48ynTSsjnSTwj0HL8"
Message-ID: <efd0f03f-0261-4f57-96db-4dea2063b329@amd.com>
Date: Fri, 14 Mar 2025 09:54:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] drm/amdgpu: rework how the cleaner shader is emitted
 v3
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20250307134816.1422-1-christian.koenig@amd.com>
 <20250307134816.1422-5-christian.koenig@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20250307134816.1422-5-christian.koenig@amd.com>
X-ClientProxiedBy: SG2PR06CA0181.apcprd06.prod.outlook.com (2603:1096:4:1::13)
 To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|PH7PR12MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d4946e4-1401-4bf3-6e3b-08dd62b0168c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3V4dVZGdk40a1kzbHpmVWQ5QmsrcUszeThJMTBSd05ROU0wamNQZytjNzhO?=
 =?utf-8?B?eG5BT0UzL1hoTVlhR2wrMTB0QVFLZDd1U2xscXd0V2kxUjdPc0cvbzVtdU5W?=
 =?utf-8?B?OVZ0SGgzMVJmdUVQOC9RSGllU3NFUU5vU3AyZUhwWndDR0RZcDBHTnh0M1Vh?=
 =?utf-8?B?YVkzcTZMSE9tREQzbDdubkdwNGFINnExNm00ZnJ2R1ZIeWE2R1RITVNMaTNK?=
 =?utf-8?B?ZHc0UE9EWi9xOVNMV2dPZ2MzZVc3dHdXSnVmc0Rob2dKUkhXMUxWVjRlOFNZ?=
 =?utf-8?B?blRiWDQ4eThESDBQbnRhekNpaTdLeldrenBlNXlsdERaRTN2dDl2d3ZrTFZ5?=
 =?utf-8?B?UXpFYjVoOE9mbnNoQ3YyYktFS1RPcUx4M1BmaS9SYXR0WDloVHNKNzVBcXZk?=
 =?utf-8?B?NDVoS3FtbHlkc3dSUm9oTG0vRVNKcFhKT0hpYnFkQSs0TmNyNGdBM2xmM2lJ?=
 =?utf-8?B?cEp6MG5Gbmc4MGFDcEtRQklFQyticFM1amRROTFCS05pMlFiZ2hTYXZicDlC?=
 =?utf-8?B?MnZtY214c1hLSXFGdUhmK2lEMkdHenZSTXZscjdRcHNnUW9WTElhcS9yOVFZ?=
 =?utf-8?B?bFpkbkdvTVc1WXI0OUlBMGpCZzZuWGExdFJBQXV1VDVPc2pCR1hGNU9QbUgv?=
 =?utf-8?B?Zi92dzlkWVNSREVHZ3l5ckxDSWwyRXRoRXJIUnlZUmdKbGgvMSsxc2x2eGhK?=
 =?utf-8?B?dTM1TmRESTlEaHpZM2YxdE9NZFZtc1Q5REpSd2pCcUN3V1l5NURiV1lYQXFL?=
 =?utf-8?B?WGE2enh6cHVSaFAvTXI5cDUySEI3SlJSTlF3RmZBMGhtbzUvWHo0MVJlOWtT?=
 =?utf-8?B?R0pWWVRXRTkwZHA1cjA1NTMwMG1uaUJrb1lGaEUrZU8rQmlLSVpVMytUY3BM?=
 =?utf-8?B?c2pIUTZMRlcwUnp6RDE2eGFUNGZZTkg1NFl3SGhwVXpZbENoRnpRWjlzWVRj?=
 =?utf-8?B?ZGwrTGROZlVObkFMZUVkVTJUbFV2VUhPeHRvUTlQR29lSmczWVZ5SE4rMXBh?=
 =?utf-8?B?ZWUrYjA4K1dqN0JpMjl2ZERZeTJWdGJQRzNaQXZjaFhxbkJFTFphOWU5NWpq?=
 =?utf-8?B?T0VCV3ZlQ0dFVGw2Yk5qaWFHUnVxOVlzNWpha0NidlZ4VEFGL3lGdHg2cjY3?=
 =?utf-8?B?Zm8zcVRWbmVwSG51YzYvU2taYWtYTFJzcUgxWnQwZGhIN3JIMDJCS2dkYnVw?=
 =?utf-8?B?OE9zSEMwOTZuNVlqcEJBaXVKbnQrL2xOeDQ2NFVGQkRGYzNPa2V4dG5raGNX?=
 =?utf-8?B?aERlY2c4c3h6UnF5bjJXNTc0dGVOeE9wY1JpLzNOL2kwMGxoQWVsMERNNk9C?=
 =?utf-8?B?ejUybnhRMFBiUjc5ZlNqc3hlQTZQTUZicC9EbllOTkZ2SjJ6a0VmS0g3UmZs?=
 =?utf-8?B?NXkxSG92NFRMV1I5RU0wbG9WRTBnRGZZQW04NEsyRXJqVzFBYlFyL2xYM3JP?=
 =?utf-8?B?WWVZQk03MEQzWExyczljdWtETzl2RXpoeFk4RGJqbEVxRnRjVC8rYmxoOXNp?=
 =?utf-8?B?SUVxMTBkbG55elNLbnNzdlZaai9WM1FnOVVJZDNaOW4wdnRxRTd1MTVrbVZn?=
 =?utf-8?B?N09XZ2dad1o0Wm9YZG8rQSs0UzRsaDZwcDRSVjRodXd6UkFaYncxVzUwRCtv?=
 =?utf-8?B?UEdXbkd4SWRybDZBck04V2FsMzJIZnRPbjJSNkJxRnlGMzFwcEpnMkhYV0tG?=
 =?utf-8?B?a2Y0RXRXWGh6Z3hYNm5xbXFYZHpMaFhackl4SnpSQVhPMUNTUWhTbVlyVFNT?=
 =?utf-8?B?M2FDdXFXYVB1RGJ6Ymg3dDZBZFZPRCt3RzA0WC8rbVVoM0VTai9iTHVUL1k0?=
 =?utf-8?B?UVRwSXlsUGZORmhuM3JoamlaMEFpM1lYR3ZmT0RqZ3ZMRGZ6QTBma2tISThB?=
 =?utf-8?Q?ls1xpDQnnA9Cr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUpnaks1elMveFpZZG1ibmdrU1BvbEd0VDhRem5XbWt0bEJRYVZJLzF3VGFM?=
 =?utf-8?B?SysyQXo4QVZCZUQ0WUowOUVnRTNFME9sMW4zL2N3Q1hza0dPNVFFdm9Qajlh?=
 =?utf-8?B?bGVNeDhzK1VMS3YxKzlBSXlkc1RCRmRUVFdtMmVlaFRDMnBUTUdPNCt0TXpw?=
 =?utf-8?B?b25JMnBPWFgyTXg1L0FCQlpodjJNS0poMlVldzEvb0N1TEMybFB6S1JQQTd0?=
 =?utf-8?B?QW1mWi9yLzhCMHRpMW4zQzF3ZW1jQ0E3ZnpnakdnUjB1UVdsa01tOGFTRkFB?=
 =?utf-8?B?ZW9hTEx2cU9iWERWMHVYVTZ5dHJGRGJNQVB6V3Z1eDZ2dzN2NnlHNFdRR0d2?=
 =?utf-8?B?TmwyQWhlT3kxakp2UW1MK083OFhrQzlSNzRUaGdZVGtYTW9FNFZaRGE5MzRw?=
 =?utf-8?B?Z1VKVjhTV2JGclFEOUZNOUQ4SVVxelpkRDMxUzQ3TDFnSWErcWE3T3h1bXhh?=
 =?utf-8?B?b3hsZzl4R0hEY095a01DbGl5SEFXK0lSTVFJUmZFQVZ3dHc5SkljdVlsZzA3?=
 =?utf-8?B?MmFEVUczQkNRUlk3Z0RCWWpZRUlDZ0VpMG96amtLcG9mSlVQR2dJQ1A4VXVV?=
 =?utf-8?B?WXE0aUY2elhQdEpVbVhpdTRKbVBjR0lhTkpHTTBHOUt0TkR5eFBQd3dibkpS?=
 =?utf-8?B?bzdMc01VbVlHbkpxNWxLYzlUVnNyaUI3cTdJQkhxZEY1Q0NqcWRFd1RERTcy?=
 =?utf-8?B?MWJqVFZSdTAvY1BaUEp4dk0venZLYWRVY0Y3M3UxUDdLN0pOSVJSZXB1ZUMv?=
 =?utf-8?B?Z0o2YVJMb3Jqck94dnRiMlNRVXE2WVdrOW11ZzhhQU1FUThvbnhIUHdvYVNh?=
 =?utf-8?B?T1pxSThLRWl5ZDVqTTA1MStvWFhHejZoSHdaK2N6dzJ3M24xMnpUOUNtNXMy?=
 =?utf-8?B?VVYyVXVsU0w3cUU4ckRpbVM5cFBYYnV2LzhDVlpENFBVOEhmYWRRbzRWUXJU?=
 =?utf-8?B?ZE1ENkVJYkhjMVdxZUh3QVpwdnk0czdyM3pYcHNKWXp3WldJaU9EUUk5elJQ?=
 =?utf-8?B?eDd2aWs4eWpwanI4QVR2enNhUlVMZStmQ0ZYbFMzblpjWVVHRlB1ZnhOejFM?=
 =?utf-8?B?MzhUUmpYblNOMGY1cEpiRmZnVyt3TkV5OGZ6UGlJM1FzMWxBOW9tWllmRUNR?=
 =?utf-8?B?eGFZQ25NVlRQVEtQMDBkTmUzMC9DS0gxRjFDRjlQMkwxRFV5aHBYRXkxMEpX?=
 =?utf-8?B?KzhtTzMySTkzRTBGcW1OUGo1a1E3YWVBT0t6c0xpc3YwQUpvY2VKcXlCYVpH?=
 =?utf-8?B?UkdOa0FvNEVYWXNIdUtCaTN0aU5mblFXWVgyc2xRTnlsQWswanRGMHU2TVFR?=
 =?utf-8?B?UEJabk94bmVuWVNwYWFJWmxTbFBCQXdFWFFNbkhnbHJ0SWxNL3I0T3lGU3Fq?=
 =?utf-8?B?SUFCK0poTkphdmJnQmFUZStEUHhVc21NNURZSDNSS082RW00SzJHa1ZZWnNS?=
 =?utf-8?B?MWkvVlMrMFVaT21FR0NrSVZ2SWdVUVNjZHV0aGlraUVVQmRieVdKMURxUEpp?=
 =?utf-8?B?OTB4bG5YdXo0UFcxR2J4eGU3YWRlM1JwU3Z0MEFhN1J0R3JrU2JOdkdMVVhS?=
 =?utf-8?B?N0lNVzVBcFNEc05ja2xEVm9jWUhab2lCQitmdm0vbTRCZ1AzT2oyR2JUOG5K?=
 =?utf-8?B?cUlhSThncHgwSVlCbi9pOENWRTBkUEd1amliK0pDK3Z4UHNLSmRnVVBVLzFD?=
 =?utf-8?B?K21XZlZoSExiOFoyTitkVlFPN2VEL21aZkhtNTd5R2xJYUJtVHJrbDhJK3Js?=
 =?utf-8?B?alhzNmVoaFdKeEk0N0IxMnBVM3laNjBEalpVbmI5ajhXR2hnbUk3MWdVSFp5?=
 =?utf-8?B?OGVwT3gyczg0Yjh1eXpiaVZ4dGpSdWhnQjRmMElmT2ZUNHlBZmt3MWZmWThG?=
 =?utf-8?B?R2FYTzJ0dHd4Z1h4QldlWWQvclpKejlIVmQyUkNpU1hmbnVYcGNrNzlhNmt0?=
 =?utf-8?B?UGlBWFpBbHZuY0RKTk1jdFN2cW14SmdyQmJkTmZUWGRQcTkvODFGMXIvekdZ?=
 =?utf-8?B?QXhOWWxqQWRkS0RVRzhZRDdOZGloMXhZdDhHN3B0bTA1cDFOWmtoaHpnL3gr?=
 =?utf-8?B?QVF4YkNZcnJFNldlK09PejMwbE9Lem4wRHVnTDRpTlU3dmJVK3VhSkRzTENS?=
 =?utf-8?Q?kZbrwAqTdXdObqmEW+A0emT8S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4946e4-1401-4bf3-6e3b-08dd62b0168c
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 04:24:19.2900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOBTve5iYYRIZxo3PuIcI/HL7V0Go5gVvS7TZslPu+e0slkifGTSxQo0WqDH2EIgoQ6ZoJIcU3EExB5vx3X09w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7330
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

--------------UOwuZiz48ynTSsjnSTwj0HL8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/7/2025 7:18 PM, Christian König wrote:
> Instead of emitting the cleaner shader for every job which has the
> enforce_isolation flag set only emit it for the first submission from
> every client.
>
> v2: add missing NULL check
> v3: fix another NULL pointer deref
>
> Signed-off-by: Christian König<christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 27 ++++++++++++++++++++------
>   1 file changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index ef4fe2df8398..dc10bea836db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -643,6 +643,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   		    bool need_pipe_sync)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_isolation *isolation = &adev->isolation[ring->xcp_id];
>   	unsigned vmhub = ring->vm_hub;
>   	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>   	struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
> @@ -650,8 +651,9 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	bool gds_switch_needed = ring->funcs->emit_gds_switch &&
>   		job->gds_switch_needed;
>   	bool vm_flush_needed = job->vm_needs_flush;
> -	struct dma_fence *fence = NULL;
> +	bool cleaner_shader_needed = false;
>   	bool pasid_mapping_needed = false;
> +	struct dma_fence *fence = NULL;
>   	unsigned int patch;
>   	int r;
>   
> @@ -674,8 +676,12 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
>   		ring->funcs->emit_wreg;
>   
> +	cleaner_shader_needed = adev->gfx.enable_cleaner_shader &&
> +		ring->funcs->emit_cleaner_shader && job->base.s_fence &&
> +		&job->base.s_fence->scheduled == isolation->spearhead;
> +
>   	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
> -	    !(job->enforce_isolation && !job->vmid))
> +	    !cleaner_shader_needed)
>   		return 0;
>   
>   	amdgpu_ring_ib_begin(ring);
> @@ -686,9 +692,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	if (need_pipe_sync)
>   		amdgpu_ring_emit_pipeline_sync(ring);
>   
> -	if (adev->gfx.enable_cleaner_shader &&
> -	    ring->funcs->emit_cleaner_shader &&
> -	    job->enforce_isolation)
> +	if (cleaner_shader_needed)

Here should we also need to check, for ring->funcs->emit_cleaner_shader?

if (cleaner_shader_needed && ring->funcs->emit_cleaner_shader)

>   		ring->funcs->emit_cleaner_shader(ring);
>   
>   	if (vm_flush_needed) {
> @@ -710,7 +714,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   					    job->oa_size);
>   	}
>   
> -	if (vm_flush_needed || pasid_mapping_needed) {
> +	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
>   		r = amdgpu_fence_emit(ring, &fence, NULL, 0);
>   		if (r)
>   			return r;
> @@ -732,6 +736,17 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   		id->pasid_mapping = dma_fence_get(fence);
>   		mutex_unlock(&id_mgr->lock);
>   	}
> +
> +	/*
> +	 * Make sure that all other submissions wait for the cleaner shader to
> +	 * finish before we push them to the HW.
> +	 */
> +	if (cleaner_shader_needed) {
> +		mutex_lock(&adev->enforce_isolation_mutex);
> +		dma_fence_put(isolation->spearhead);
> +		isolation->spearhead = dma_fence_get(fence);
> +		mutex_unlock(&adev->enforce_isolation_mutex);
> +	}
>   	dma_fence_put(fence);
>   
>   	amdgpu_ring_patch_cond_exec(ring, patch);
--------------UOwuZiz48ynTSsjnSTwj0HL8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 3/7/2025 7:18 PM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250307134816.1422-5-christian.koenig@amd.com">
      <pre wrap="" class="moz-quote-pre">Instead of emitting the cleaner shader for every job which has the
enforce_isolation flag set only emit it for the first submission from
every client.

v2: add missing NULL check
v3: fix another NULL pointer deref

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 27 ++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index ef4fe2df8398..dc10bea836db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -643,6 +643,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		    bool need_pipe_sync)
 {
 	struct amdgpu_device *adev = ring-&gt;adev;
+	struct amdgpu_isolation *isolation = &amp;adev-&gt;isolation[ring-&gt;xcp_id];
 	unsigned vmhub = ring-&gt;vm_hub;
 	struct amdgpu_vmid_mgr *id_mgr = &amp;adev-&gt;vm_manager.id_mgr[vmhub];
 	struct amdgpu_vmid *id = &amp;id_mgr-&gt;ids[job-&gt;vmid];
@@ -650,8 +651,9 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	bool gds_switch_needed = ring-&gt;funcs-&gt;emit_gds_switch &amp;&amp;
 		job-&gt;gds_switch_needed;
 	bool vm_flush_needed = job-&gt;vm_needs_flush;
-	struct dma_fence *fence = NULL;
+	bool cleaner_shader_needed = false;
 	bool pasid_mapping_needed = false;
+	struct dma_fence *fence = NULL;
 	unsigned int patch;
 	int r;
 
@@ -674,8 +676,12 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	pasid_mapping_needed &amp;= adev-&gt;gmc.gmc_funcs-&gt;emit_pasid_mapping &amp;&amp;
 		ring-&gt;funcs-&gt;emit_wreg;
 
+	cleaner_shader_needed = adev-&gt;gfx.enable_cleaner_shader &amp;&amp;
+		ring-&gt;funcs-&gt;emit_cleaner_shader &amp;&amp; job-&gt;base.s_fence &amp;&amp;
+		&amp;job-&gt;base.s_fence-&gt;scheduled == isolation-&gt;spearhead;
+
 	if (!vm_flush_needed &amp;&amp; !gds_switch_needed &amp;&amp; !need_pipe_sync &amp;&amp;
-	    !(job-&gt;enforce_isolation &amp;&amp; !job-&gt;vmid))
+	    !cleaner_shader_needed)
 		return 0;
 
 	amdgpu_ring_ib_begin(ring);
@@ -686,9 +692,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	if (need_pipe_sync)
 		amdgpu_ring_emit_pipeline_sync(ring);
 
-	if (adev-&gt;gfx.enable_cleaner_shader &amp;&amp;
-	    ring-&gt;funcs-&gt;emit_cleaner_shader &amp;&amp;
-	    job-&gt;enforce_isolation)
+	if (cleaner_shader_needed)</pre>
    </blockquote>
    <p>Here should we also need to check, for <span style="white-space: pre-wrap">ring-&gt;funcs-&gt;emit_cleaner_shader?</span></p>
    <p><span style="white-space: pre-wrap">if (cleaner_shader_needed &amp;&amp; </span><span style="white-space: pre-wrap">ring-&gt;funcs-&gt;emit_cleaner_shader)</span></p>
    <blockquote type="cite" cite="mid:20250307134816.1422-5-christian.koenig@amd.com">
      <pre wrap="" class="moz-quote-pre">
 		ring-&gt;funcs-&gt;emit_cleaner_shader(ring);
 
 	if (vm_flush_needed) {
@@ -710,7 +714,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 					    job-&gt;oa_size);
 	}
 
-	if (vm_flush_needed || pasid_mapping_needed) {
+	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
 		r = amdgpu_fence_emit(ring, &amp;fence, NULL, 0);
 		if (r)
 			return r;
@@ -732,6 +736,17 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		id-&gt;pasid_mapping = dma_fence_get(fence);
 		mutex_unlock(&amp;id_mgr-&gt;lock);
 	}
+
+	/*
+	 * Make sure that all other submissions wait for the cleaner shader to
+	 * finish before we push them to the HW.
+	 */
+	if (cleaner_shader_needed) {
+		mutex_lock(&amp;adev-&gt;enforce_isolation_mutex);
+		dma_fence_put(isolation-&gt;spearhead);
+		isolation-&gt;spearhead = dma_fence_get(fence);
+		mutex_unlock(&amp;adev-&gt;enforce_isolation_mutex);
+	}
 	dma_fence_put(fence);
 
 	amdgpu_ring_patch_cond_exec(ring, patch);
</pre>
    </blockquote>
  </body>
</html>

--------------UOwuZiz48ynTSsjnSTwj0HL8--
