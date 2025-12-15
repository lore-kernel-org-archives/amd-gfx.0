Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9A8D41D74
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 09:47:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06B5710E3D6;
	Mon, 15 Dec 2025 09:47:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fcy0nKI2";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012000.outbound.protection.outlook.com [52.101.48.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21BB710E3C4
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 09:47:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdhtZg3Qemjk6pUsdPxFGvz/yjvOL7YHUnldp5UnBi4o8NaaIVvkzf6ibNXV3KY6BBMycCDH4U4uW7W6U2y7/c+U2UUahMe6a35/zgXPRd/csI37l+3jzuwS6+U9ohxZpPg6zJQBBb8J/Ll+Hi7fb2ILJMBsXsECWl4gaJaST1jOPjZoN++55xf50Bxx6YS74TC3Q2sRJZAJTDrzsS/NGMJRcNxQPqdN8C0TPmbls/u9YYS9CuZiM9Kn5HYgmx/5vTWxAbvvh537dZjDS6luvSIXUi+1pGGYP57toZM/OuMA+AMqQ+o7C3+P7Cr6fOpK/wOkYxIyxrf00pwk7glj3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNKOnlT3j4kdacfpgpSQDjuWGkCd3zlKpDBfMVxHem4=;
 b=Qq21TN2H/s7tU/BmsUEubIp0NehPvVSyLHPOQBqwP+v9STU1HJTFk9IW46vZJQApGhNFtEDLjzJP1ujaS/LAX4SaSSM+hPhbBue0u2n2/UpRlBKp9nBB5U/dmOqD3fVa0nrukWNp+Oi57S1AWMXD5WC5pxBc0e0K46VhfTJG2NAi/RPaUAtdXVH3Se/TBBlzhjD7BMIFRomLab2nDfi390nGFJRihH0zvMs2DoAL88cVGDzn+fQBwydPFL6IZyfjhUdOfSq1YmTxiwSfDpzYo3tkdTNzDbOk+q8OfaN6OOwCCy0/SeYdb5lDpsijl173a0m85n09biNGOtwRl4SaXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNKOnlT3j4kdacfpgpSQDjuWGkCd3zlKpDBfMVxHem4=;
 b=Fcy0nKI2IAMVMJ8d3PElYzOKhW72M4a9+veixx3Npv4WtgqKnO8vl+diXkbxMPjfzexKXCty/OdZp5sCNAaEwZryFA57ysY2EYDcXPeNPjDAUcLFqAM6xmVCph+goCYp+1dhc3tyGSh36HOcyOwmhsrYFhDeIj9kC4Ek0o2GmCc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8041.namprd12.prod.outlook.com (2603:10b6:8:147::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 09:47:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 09:47:52 +0000
Message-ID: <996ef75a-71b3-4ba7-a255-40516c5e9acd@amd.com>
Date: Mon, 15 Dec 2025 10:47:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/8] amdgpu/amdkfd: Add support for non-4K page
 size systems
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Kent.Russell@amd.com,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
References: <cover.1765519875.git.donettom@linux.ibm.com>
 <fbc164ab-964f-464d-b94a-80131016b5b8@amd.com>
 <871pl0567w.ritesh.list@gmail.com>
 <1f10b67a-ffdc-4962-af52-758247569e09@amd.com>
 <CADnq5_NbDzqucujDyW009+55mLXZz2PiyaSd9PKXXeXv4pYn0Q@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_NbDzqucujDyW009+55mLXZz2PiyaSd9PKXXeXv4pYn0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0362.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: fb8895f4-601a-40e5-0737-08de3bbf03a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmZkQ2Fhb004ZjJOUDJlbnhGQVVDZ01OUzJid1d1VjhETEZKaTcyanJkeTVP?=
 =?utf-8?B?bGYwQStPMy83aFN4RGR4b1h2T1BpME9MZVJKQ1EvNTlLRlV1d2xkVm9sTnpa?=
 =?utf-8?B?Y2wwbmFMcDgyUFh4RUtjT09YRGttQjV4RTZXNnBkcWt6Y01SYVdsaTRHbENh?=
 =?utf-8?B?ako3OXdhbUdFMG1scmFHVlVwR0Z4U3dXeTFkZjBhVEtEci9HNDJuSkdDZ2ZF?=
 =?utf-8?B?UW9GVGFDQm9wMDlxbWtXQXBWZUk3ZzMyMS9ydUJPcWJ5UEZjZkt5TnhDY3BF?=
 =?utf-8?B?SmpGZ0JRNjFhUTBmdG9qLzNTL2FIaisyb3BKRWNDUWFvUmQyY3RnV2FwWHJT?=
 =?utf-8?B?YnBVWUlwZ3A0ajF0eG1aK1NoTHIzZmtPc0IwOGtZRDNTRlNMdytyWVpJbWJX?=
 =?utf-8?B?cEc0SUIyYVcyME9JZWM0WkZWRG93OG1lUm5vM0M4TnpnSEJxL2JFODhqelJQ?=
 =?utf-8?B?SUx4ZjNHYWo5aHhZRFNXR2hBbzdlZFFWcERobEcrcElmVVpRb3FEWCtCTW5O?=
 =?utf-8?B?Ulo2d1cvS083L3dWMmJJbWdUSTV0c3RSMXl3WHUwVk4rS1NNTWJvWlljVXUr?=
 =?utf-8?B?ejNnQVQ0cVhGTEpSbll0V0c3alJmckJ5a3B1MTA1ZDI1ZWNJS0l0OHArSlBS?=
 =?utf-8?B?eW5Cc3pGMzlCUGZSUkFhSzlMcHRqOUZTU1FjKzFqVExMdlVlZWVNcDF4eVBO?=
 =?utf-8?B?TmdmTWRxV2liWndyaXVaVHRBLzRYUnNDN2d0T3JlUHpiUGNHaWxxYWVYSWkr?=
 =?utf-8?B?czVkYXRraFQ3ODdETmJlMkVHK1NJSElwK0JwQ01zeS9YMUZNbWdKdnpSdUhO?=
 =?utf-8?B?OXY4dXIvb1BtYS9rNTJ6Z3hGVHR6bUJ4OFhvTUVVNUlUVm9vb0RSSFJMWDd4?=
 =?utf-8?B?SGJFTit1R2J2TGY5Z1F2Ui9hSEROU3FhYVRtMjZJcTZEaVl6Tm9jeW9ialFF?=
 =?utf-8?B?UExiSWVsM3F0eUdMMGY1dWxFVWxveVIxc0FQTFo0Z1hNV3dQT1VXY1dDS1Z4?=
 =?utf-8?B?cjE4RUcxNi93WGZXM21KMjNVWVpFVTlnNndUa2R6L01ET2lhaFhPSmROM0Y5?=
 =?utf-8?B?ODFWNmRESWlzL1k4ci96YnFlam1TV01sdXJpNjNlWURKZkFyb0NRR3JNTnBN?=
 =?utf-8?B?WGgvRGJxMEJBSllNR0J6aTJPd3F3OEpzNjNLNzhZcjRhUy90KzJxQzJWY3o2?=
 =?utf-8?B?Ny9jSGVIT05yNTNONkFPSW9hOGdpVXhMZVVJcGNFTndvMHAzOWNtVTNhYVlU?=
 =?utf-8?B?NmVJTkoraWNlSHRwOEQvZFJsb2MzNlIyVHA3L0RteGhxN1I3RVBVR1RGV3Zz?=
 =?utf-8?B?TlQyOUdQM2tpbHo0clFZU3ZKS1MvUnp3My9kcGM4ZTNDeW0zOExrWGxHYm8v?=
 =?utf-8?B?TWVWUVROT2pRaVJka0NMRFFhOVRHSkc1ekFQWnA3Z2UzWTlyblY2TWxxWUZV?=
 =?utf-8?B?Y3lXN1k0dVFqTEh5bXJIYzluL0NWTWxmNVZqajc3Uzlmcnp1SmFheVNjNU9T?=
 =?utf-8?B?S2o0MEdvbVo0WmVjcjBmaVBGajFsV2N3eUU1UXdMMUVIZGNBMWRPZ0huUnUz?=
 =?utf-8?B?d3hSTXk2VjFtVmVocHFCdFZEdThiS2gyY1g2dnBSemJBc3lMRVFlTjJmdUIx?=
 =?utf-8?B?UUlQVzhVRzJJRGdac2FmbktHMEk2cll6cEczcXBMVklKVXMraUZBODRMT25u?=
 =?utf-8?B?OUx0bHhpMElTTUg0Wm5zQXZzdHgvQmhNMkFUeDRqTWNvRmE0VitMWGxOWTZU?=
 =?utf-8?B?bFk2eTV2alFSL1BIcWwxOUV4dTc2SEVpUzhUenFZaG0rSkdCcm9QeU1CTVVW?=
 =?utf-8?B?L2tFdFd6elZQM1NGdTY1MjdWMW5wdlM4RHNKRjN4Rys4NmNOVjdNTi9QK0kw?=
 =?utf-8?B?bWpVYzVwVks1MDZ2NmhKU2dDMXBnaXhHTEZoYkdwZjJvSDIxaHQvZUN4MUdo?=
 =?utf-8?B?NENQK2MzTGI4WGRseHhmbVdUZ2FTMldjZ2hNQmNUMFJhbjQrZ0h5NXk4M3hL?=
 =?utf-8?B?dEM3bUhXajBBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUs0UVA3WDFjOHMyRVBWdkR2K1hTRHJocWd3UlVlQitFYlB0Y1dPeEQyNUQ1?=
 =?utf-8?B?UmN4QmxZaVZPQm9JUVZYQ1ZzVWlYRHR3WkJzZENqUEFLaFIzUVpVRWpYc1FD?=
 =?utf-8?B?eVNjdk9WZ2k1cnR1ZkZNZGpibUM0Tzd5WU4vR2ZORis4QlZVVE94cnQ2emJX?=
 =?utf-8?B?RCtzaksxVTQrdkRPKzRpVy8yYWpyVGVHMkdQbktKNzd5S2U1SFVubE10Y3pj?=
 =?utf-8?B?ODIwTjhJVnk1anVnRytROVpwQ2p2N1lETzFST3dLZnNiZVphbXhTaVNpR1h4?=
 =?utf-8?B?Mkp4eWtRWUhXMTRPb3hWdlpqbzBOWFpyZ0pCakgzOG10RGdhajQwN0d4aVJ3?=
 =?utf-8?B?emhKSnN6V1JXREZ3VWlVOWtVR1JZWDl2NnlNTjRMUEZzZU1SUFdzVklocEJI?=
 =?utf-8?B?QkF6YVd5QXM5em01VzJqTVo2dXVSNkVvNDZiWjhqNHp4TTJlbjdzMFFYYmxD?=
 =?utf-8?B?TkZNU093NmRXUXVWNjdzRThGTFBtTFU2SG9XMzFHb3JhVGEvTk1HTFJzeGxa?=
 =?utf-8?B?RGJPSXl0MnZCaUoyUHJpWmU1S0dyZzRRZjBQOXNHVTJHN1ZrQXR0UkZpUWZ5?=
 =?utf-8?B?akp4SDkvUUNzNUhlY3VPVEllQjRpYVJFWXdxQVZSUTQzTnNOUUxqdVdsR0lF?=
 =?utf-8?B?QjdRNjBjdG9IVnZXTHVlc1h3N3BRUWJidmJ1emNYemxGTUtHUWRuVUVJcWsy?=
 =?utf-8?B?NmtMY0hpL3pON05MOGkwVVpEWFRmeWlXN2ZjcEZ2enBndDNjSHJPM3ByK3ov?=
 =?utf-8?B?U3ljL1krMS9qRE5tdG9FNWsxZFRvTUl3YkJ0ckRncTU3S3pFSStaR2ZJSnV4?=
 =?utf-8?B?Vi9HL2ZCYTlkQ3Y5MzIza0RwVWNsZThySWJyVEJsKzhPOFJxOVRtOEVLblY4?=
 =?utf-8?B?RE4zWktSSlFwdXN5S1ZpajVYZ0hKMnE4RS9qMEdia1RrTmo5VVFRZ0MwU0Ew?=
 =?utf-8?B?c3dGbCtheEMwZ1lEcXN6TVVhYUxFaDlSZkk1czRLd1JHcmlOeG9hdmQ3M3dD?=
 =?utf-8?B?MHpiT0dsWEZoNUR6U29seS9WRjNkRW53aUQ0YWw2bmZjbmkvcm01ZDZXMEZR?=
 =?utf-8?B?L0JqQW91YlZIUDhmSUdoZXU5ZVh0TWo1d205WU00c1dFTUsrSkVpUnk5Wm5a?=
 =?utf-8?B?eUQvamlnS2xDaEpLTno3TnFObGJGRHAxd3ZjWGhlaHU1c3Q2YWg4OVl4SlBE?=
 =?utf-8?B?UzVhajFBeUVXd0oybTVkeW8rdkROYjdGSW9pZkorOUN2bkZDb2tNd1hrQ1c2?=
 =?utf-8?B?dDhlbjFJV1k5TkZGRjFmUkd2ZHRranJlWk9Fb0dQNWQ0UmplU2picmNraUdq?=
 =?utf-8?B?Si8zTVVBMDYrN2NuRkxYa0I1ekdhNERnSW5ZT1dHRDZubnpWbUZyWVYwYjE1?=
 =?utf-8?B?LzkxVE1DQkNRbnFDSFBya0FJVWwvaExOd1NyR3E4MzZ2eEluQVQ3bVhNc09V?=
 =?utf-8?B?c2VpQmE2TEtOeERzelJBeFFCZWd3SkZwTlY0NVdaMk96YmxXcCtUT1NqQ29o?=
 =?utf-8?B?Q1pnc3c5SmNwRnl2eGNZdjFtSDVRYjRZM1o0dkQzeE1mdEk4QTZOQWpLZEs3?=
 =?utf-8?B?YWQ1UDNiT0h6d04xZ053RjVOcmk5bGhSNkEzOTEyUURiVGNRUEJ6cS9sSHM2?=
 =?utf-8?B?QXduNGlLMkpQWXNlMWVDdzZuWXVYRnRrWjRCVjY4ZmhnbmljZXVuM3dlaDA5?=
 =?utf-8?B?YUFLNmJ0c2I0SWRIVW9aMDN2SWU1bEVVZXp3anpoaFR1cXk2ZngxT1FFL0ZS?=
 =?utf-8?B?Ylo3b0l3YjFGZmI0RHdES1Nsc1QyRWcvQTJibnROdUhZWmZHUEJiRWtnd1lp?=
 =?utf-8?B?UmpDTjRkS1B1Y0pQc0N3cFZuVDZtZzd0bE9vVzVqV3BoWnpZR29XcEhYTk0r?=
 =?utf-8?B?ZjBHdDk4WkRMMDRnZURXMkFtdVFGNGJqL04yT1VRM2VIZWZBOFowWjFiaHRI?=
 =?utf-8?B?YUFyWTdkeExqVTg2R2FjR1Z6eFdzS1ZRZkdhd1Q3ZHEwR3p2N1J1azhjenZM?=
 =?utf-8?B?OEptanhEWkhIVldkQ2RzNmM1N3hrbXBHSFQxTVQ4dlhIV3duaUI0VUpOYmlC?=
 =?utf-8?B?djVnakczNW9aYU5jWk1mTjhTT1BJb2lpUFVMbTZEb292ckozOStnaUFYRjVj?=
 =?utf-8?Q?b4j4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8895f4-601a-40e5-0737-08de3bbf03a4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 09:47:52.2182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6o2vZV2dsVnf0Z5AxPhOtM/3ZYK2ICaUIKo6r50EzmVx4medk5X7ZqBwMqHc11dC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8041
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

On 12/12/25 18:24, Alex Deucher wrote:
> On Fri, Dec 12, 2025 at 8:19 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> On 12/12/25 11:45, Ritesh Harjani (IBM) wrote:
>>> Christian König <christian.koenig@amd.com> writes:
>>>>> Setup details:
>>>>> ============
>>>>> System details: Power10 LPAR using 64K pagesize.
>>>>> AMD GPU:
>>>>>   Name:                    gfx90a
>>>>>   Marketing Name:          AMD Instinct MI210
>>>>>
>>>>> Queries:
>>>>> =======
>>>>> 1. We currently ran rocr-debug agent tests [1]  and rccl unit tests [2] to test
>>>>>    these changes. Is there anything else that you would suggest us to run to
>>>>>    shake out any other page size related issues w.r.t the kernel driver?
>>>>
>>>> The ROCm team needs to answer that.
>>>>
>>>
>>> Is there any separate mailing list or list of people whom we can cc
>>> then?
>>
>> With Felix on CC you already got the right person, but he's on vacation and will not be back before the end of the year.
>>
>> I can check on Monday if some people are still around which could answer a couple of questions, but in general don't expect a quick response.
>>
>>>>> 2. Patch 1/8: We have a querry regarding eop buffer size Is this eop ring buffer
>>>>>    size HW dependent? Should it be made PAGE_SIZE?
>>>>
>>>> Yes and no.
>>>>
>>>
>>> If you could more elaborate on this please? I am assuming you would
>>> anyway respond with more context / details on Patch-1 itself. If yes,
>>> that would be great!
>>
>> Well, in general the EOP (End of Pipe) buffer contains in a ring buffer of all the events and actions the CP should execute when shaders and cache flushes finish.
>>
>> The size depends on the HW generation and configuration of the GPU etc..., but don't ask me for details how that is calculated.
>>
>> The point is that the size is completely unrelated to the CPU, so using PAGE_SIZE is clearly incorrect.
>>
>>>>>
>>>>> 3. Patch 5/8: also have a query w.r.t the error paths when system page size > 4K.
>>>>>    Do we need to lift this restriction and add MMIO remap support for systems with
>>>>>    non-4K page sizes?
>>>>
>>>> The problem is the HW can't do this.
>>>>
>>>
>>> We aren't that familiar with the HW / SW stack here. Wanted to understand
>>> what functionality will be unsupported due to this HW limitation then?
>>
>> The problem is that the CPU must map some of the registers/resources of the GPU into the address space of the application and you run into security issues when you map more than 4k at a time.
> 
> Right.  There are some 4K pages with the MMIO register BAR which are
> empty and registers can be remapped into them.  In this case we remap
> the HDP flush registers into one of those register pages.  This allows
> applications to flush the HDP write FIFO from either the CPU or
> another device.  This is needed to flush data written by the CPU or
> another device to the VRAM BAR out to VRAM (i.e., so the GPU can see
> it).  This is flushed internally as part of the shader dispatch
> packets,

As far as I know this is only done for graphics shader submissions to the classic CS interface, but not for compute dispatches through ROCm queues.

That's the reason why ROCm needs the remapped MMIO register BAR.

> but there are certain cases where an application may want
> more control.  This is probably not a showstopper for most ROCm apps.

Well the problem is that you absolutely need the HDP flush/invalidation for 100% correctness. It does work most of the time without it, but you then risk data corruption.

Apart from making the flush/invalidate an IOCTL I think we could also just use a global dummy page in VRAM.

If you make two 32bit writes which are apart from each other and then a read back a 32bit value from VRAM that should invalidate the HDP as well. It's less efficient than the MMIO BAR remap but still much better than going though an IOCTL.

The only tricky part is that you need to get the HW barriers with the doorbell write right.....

> That said, the region is only 4K so if you allow applications to map a
> larger region they would get access to GPU register pages which they
> shouldn't have access to.

But don't we also have problems with the doorbell? E.g. the global aggregated one needs to be 4k as well, or is it ok to over allocate there?

Thinking more about it there is also a major problem with page tables. Those are 4k by default on modern systems as well and while over allocating them to 64k is possible that not only wastes some VRAM but can also result in OOM situations because we can't allocate the necessary page tables to switch from 2MiB to 4k pages in some cases.

Christian.

> 
> Alex
> 
>>
>>>>>
>>>>> [1] ROCr debug agent tests: https://github.com/ROCm/rocr_debug_agent
>>>>> [2] RCCL tests: https://github.com/ROCm/rccl/tree/develop/test
>>>>>
>>>>>
>>>>> Please note that the changes in this series are on a best effort basis from our
>>>>> end. Therefore, requesting the amd-gfx community (who have deeper knowledge of the
>>>>> HW & SW stack) to kindly help with the review and provide feedback / comments on
>>>>> these patches. The idea here is, to also have non-4K pagesize (e.g. 64K) well
>>>>> supported with amd gpu kernel driver.
>>>>
>>>> Well this is generally nice to have, but there are unfortunately some HW limitations which makes ROCm pretty much unusable on non 4k page size systems.
>>>
>>> That's a bummer :(
>>> - Do we have some HW documentation around what are these limitations around non-4K pagesize? Any links to such please?
>>
>> You already mentioned MMIO remap which obviously has that problem, but if I'm not completely mistaken the PCIe doorbell BAR and some global seq counter resources will also cause problems here.
>>
>> This can all be worked around by delegating those MMIO accesses into the kernel, but that means tons of extra IOCTL overhead.
>>
>> Especially the cache flushes which are necessary to avoid corruption are really bad for performance in such an approach.
>>
>>> - Are there any latest AMD GPU versions which maybe lifts such restrictions?
>>
>> Not that I know off any.
>>
>>>> What we can do is to support graphics and MM, but that should already work out of the box.
>>>>
>>>
>>> - Maybe we should also document, what will work and what won't work due to these HW limitations.
>>
>> Well pretty much everything, I need to double check how ROCm does HDP flushing/invalidating when the MMIO remap isn't available.
>>
>> Could be that there is already a fallback path and that's the reason why this approach actually works at all.
>>
>>>> What we can do is to support graphics and MM, but that should already work out of the box.>
>>> So these patches helped us resolve most of the issues like SDMA hangs
>>> and GPU kernel page faults which we saw with rocr and rccl tests with
>>> 64K pagesize. Meaning, we didn't see this working out of box perhaps
>>> due to 64K pagesize.
>>
>> Yeah, but this is all for ROCm and not the graphics side.
>>
>> To be honest I'm not sure how ROCm even works when you have 64k pages at the moment. I would expect much more issue lurking in the kernel driver.
>>
>>> AFAIU, some of these patches may require re-work based on reviews, but
>>> at least with these changes, we were able to see all the tests passing.
>>>
>>>> I need to talk with Alex and the ROCm team about it if workarounds can be implemented for those issues.
>>>>
>>>
>>> Thanks a lot! That would be super helpful!
>>>
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>
>>> Thanks again for the quick response on the patch series.
>>
>> You are welcome, but since it's so near to the end of the year not all people are available any more.
>>
>> Regards,
>> Christian.
>>
>>>
>>> -ritesh
>>

