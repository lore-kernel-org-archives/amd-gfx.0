Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9398D7878C
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 16:29:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FE5D10E1E4;
	Thu, 21 Nov 2024 16:29:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="riWiPp7y";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C238110E1E4
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 16:29:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnrX2XHUvb7al16Iirdr+lyNUA6ShavXyt8ajpHYXUs7k/Bk8OfRVnptUOvJom1t8HZBK8vKgiZO3D9GFov5skIaMHv2juy8P2vpoNpUMBGGXLvnVwXOp2XV/HVRrLqRoAmIP5WNPmCHsu5R/ooujy5PzpwhnwBtOjZKI0DloTLhKL5uvRrN6i2n6KPTO1w6aTfFpUXd3Fp4P2q1CmNDXfA63coXwRAZ4Zuos9wWx/KDUPSZ76mIMZUFAXxsWBTvIQg3nCb4pU3LdrgCuSwfx03jlZSld8GOEudVzWhU7LaNKN/sd+pbVmri2ceH2o+7xc1zhrO37HRfoejOTceBwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qslx78qMDXJphmRMY0CE41SIx/MV6LAQvWk/ManbC1E=;
 b=nr/kAEZq+ez03o/G9bIFN2r90Wje5blzBttOMSSV5dKx7A1A78V3RSHCMnFaBo+iFqaGxEoDTUJ3bCEtTLHtGPVcn+SOKlUE2zqmsDgGKqZyN2HnrsvBVHRZHp4D1eBB7ZzFsqZKK04tZUHmfIFHZwNKJS261NfIeptkO5cs4nuibv84KLr218uvEVmNdgenvedw7Cob2HK/yEzcffIrSnY4Tew6zLmklX3umB/MLR7Z0siOlkacUPzHFZbVz3mPYI4exmpWS98BWwBF7+r7PPSEA+geVnT7+IrituYRDM7AZ4VbOMG3ES27zhe9SUTnM+U2LsDqEDevf81Tj07rBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qslx78qMDXJphmRMY0CE41SIx/MV6LAQvWk/ManbC1E=;
 b=riWiPp7yIVS+pKZRuZ9TNKFwJqKn/o50mxs7tYN1UYqxvB49cpQlIRu8ldQUhN75MSe1M+7c+PC5RIdr0/2+P+PiRgyOxhGBBzWdyxkzniKMJ1kjNgaO8hCOw90LGTCfR81ExybGR8k1NYSN/hugSuMGGN06nzEJPzNlvemSb8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by PH7PR12MB9103.namprd12.prod.outlook.com (2603:10b6:510:2f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Thu, 21 Nov
 2024 16:29:28 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%3]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 16:29:28 +0000
Message-ID: <fcb1617f-9033-4189-b579-5ef658acaad5@amd.com>
Date: Thu, 21 Nov 2024 09:29:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: Vanilla Kernel Build of Recent 6.12.0 Kernel Test Results on
 M18r1 AMD Alienware
To: Gregory Carter <gjcarter2@gmail.com>, amd-gfx@lists.freedesktop.org
References: <CAE4jU7gZPeznzxOZdOqieyH1e-8kD1hKg+NwRGXkTKn4yB_6DQ@mail.gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <CAE4jU7gZPeznzxOZdOqieyH1e-8kD1hKg+NwRGXkTKn4yB_6DQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQ1P288CA0013.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::9) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|PH7PR12MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c97bd83-d795-4186-4b67-08dd0a49ab95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alcxMXlZRUFaYSt0L0lQUkdCNjBMOTB2N1E1MjhXR3BZMnFLL3R4YUZtZkpW?=
 =?utf-8?B?UTZoWkRaTGhKWC9la2V6a1RDejRuU2l1a3VyRTB0dGNKRlBWZGl5M1dOSjkr?=
 =?utf-8?B?ZkVhRERFNC93Z1Jkb3pBTkNjK2JabmFFbmdLa1QyMXk2cnkyY1RXQ2ZxMHgx?=
 =?utf-8?B?QnBYdGIxa0E3NGFxNDFlNUtlQ3Z2MjdXdDZFRGxicERZNHJ5dEZVdC9BUmtP?=
 =?utf-8?B?VUZDTjRrYXBXQVZVeE4zU2kySlM1eTVlRE92TXZUanBYT3RMNU4xQUpXZ1pM?=
 =?utf-8?B?NHl3WlN4QmpBWHA4cndIVFhTQk1NSzBrdG51UkE3ZGxlQUdReGFCakNEUXpS?=
 =?utf-8?B?aENQd1JwV2ZaL2JYSk5qWEpuUEZzZ25WTDhSd2kvaGYvc2Vwb2djaTUxV1c5?=
 =?utf-8?B?Tkc5RWk0OGxUMGQ4Tk53cFJ4OTBGWnNNZ2I1WmZaYTdOY0lkb3d6aGJHclFr?=
 =?utf-8?B?MzJMaTVyZjdmaUVhQ3k4MWNiaU9iSExSQXp2QVIwV1UvRVBQVVgrU3p0S3p1?=
 =?utf-8?B?dldhTlBTdVQ5Wk5td0dlcWQ5alRBLzRpQmFkaFJiM3gwOEhydDc2ZXg4S1JM?=
 =?utf-8?B?Y2E0eXJJQmVuTFBRMEkzQU1GOWJJRnNySGRBZDNSNmdMYS9ZcFdrTjdUeTVH?=
 =?utf-8?B?RVorZDMrUEdaNU5HRUZyOHIxRlpORnlyckJWQVBXeG1mN28zVjZaR0M1WTdj?=
 =?utf-8?B?TTRQRG11WWtTRVVJQjQwUFBDTEJYVlNtMVpaMGJEeWpoVHVGaVg0eEo1Kzln?=
 =?utf-8?B?QU5WU3VFN1FFL0owM09pRDVSMnhEYWtpNXFOYjAwL0FaVDJ3ZFlzN3hmcThE?=
 =?utf-8?B?Q0FUMVdSNjEvamdYS0VROWpGNlhxaXZXYmE1dlp6L1JQUDVmek4vdysrSHR0?=
 =?utf-8?B?YjRWZVdBMU1IdG4yeWlJRHBKR0tHL0hnMWV1bkdJOE5mREQ1TFplRFN1TU5D?=
 =?utf-8?B?NFpBWFZFS2Nyd05KVFoyZ2FlbGJpUGp2L0w1V2VlemhiUDN6MWpLOFp6Z0Nn?=
 =?utf-8?B?cU0wU1JWWlk1blZML1F1ZzIwaDJOaWtYdFZDVlVaUzZSaHZRNUZDVXRCRGpU?=
 =?utf-8?B?cDBRTlFBZzFGOVZwenhwSjBYWTArTUhKdE44aTdLSnJmZGQ4cFlzaHV1andN?=
 =?utf-8?B?ank2OTdzTWdsKytKZFRYNnMzT2xEaEpmRk5UWkN5K1pOQWRYLy9jOFEvOHEr?=
 =?utf-8?B?VWt4VzhXcENMd2pOUmgyTEVhRHJnd1NnOWxXVFI4TXN6Lzl0NHpNYVpYWDFF?=
 =?utf-8?B?U2UxMGhoNnA1d3lGakxZRkhBbG81QmYxVmRtM2RPeXVYNjc0c3pqejNsaWNG?=
 =?utf-8?B?eUdiT2ZtRnJjWS9hWENOYU4vWC82eXNEMjdQQkM4ZHFybGVYaWFiMVkyem9K?=
 =?utf-8?B?cGtBWnFZUjc3THRnR3NpOUdlbTh2clk5cUZvMmdyRUVYdERVeXJpMEFQUGNm?=
 =?utf-8?B?NnhhZHdrR2VzbmpWdSt2WGYrR2JuZTdRYkUyckVDcy9GYUc1S2lTYU56TmhK?=
 =?utf-8?B?ZDJWWk03QzZYNVlGMktMcWNxbXRKb0Zza3JOV0hLTmdldkp3M3VsbmNwSHZ0?=
 =?utf-8?B?WnBoUTluMTUzczJsb1N5NXNLYTJSMENNQWlZK3pnOXUrZjE2SElWVTNVcm9Q?=
 =?utf-8?B?TmxUMXZRV1hUbzBrc1FYbGY1c2NFWmUxR2FKbGFJL3llSjlYU3RkcTBXL3ll?=
 =?utf-8?Q?KSXPMmlVvFbpFuZIb8EH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVNvYmQzeDkyTXdDREVOeHQxUHY2ZGhKY3k1ZW5PZXluNU00SlVVMjRmUlpm?=
 =?utf-8?B?VzZXdDVWRGdkZVdrRFRqZVJaRFFRSElOQTIxcVdoaldIWHBqcTR3enRESkFN?=
 =?utf-8?B?cE1YL050ZVBrOHhaTlVwVGVheXRMQkZUMFdpUUZwYjdwc0ZlMVBrY21hKzNp?=
 =?utf-8?B?ZEZoR0d3d29WZDBGcENwTVNjYTNSNDcrMHhoTzJObFBnbitlbnFzVG1uQWhZ?=
 =?utf-8?B?NU1kSDU2Ny92QjZTdjZkWWZxZEZEVGFBM3hVUzJnSzZ6blVJWG9lUjY3dUxR?=
 =?utf-8?B?aU8xY2duY0hTQ3o0aDc3RWdPZDhNZkxocWNUcFJtSk4rRHlDQlVhNk9PbjRL?=
 =?utf-8?B?bk9aVEdBSy95aUdvdzBObFpYYlRtU1RVM1FCQWZ4c0pyYXFnUEpOT05jOEpI?=
 =?utf-8?B?czJaMCtJOTBGbUZtWlc5YTNYSnVPU0ZGYmR0Q2JJRFNyUnUvVGdUSXNrTVdz?=
 =?utf-8?B?VVNVV1dxbG5VOVloME43WHRyaTRJYnYyRERQbFpCd1RBOHBqZG1sb0dFUXZM?=
 =?utf-8?B?YnFZNE9UTUYwQW9wbmFoaEplYW4yM3lRSjdCU2pub3VnaFU1TE5mRDVBQjlB?=
 =?utf-8?B?TzJDSVQ0ZmFSRWJEMkJXeHhkdjcvWFV6MjFGUEFETUNZVENGNThxdVdzVHA5?=
 =?utf-8?B?eE9GMWQyaWp6VDY0UmpJYWtQdldXQTRMWHVjL1FaTVU4dTdGcFdxTkFRM1RD?=
 =?utf-8?B?d2IySG11NC90RHRNUlhDM3VUQk1sT2NFQ2J6WkVsRk5nVEl6Z2FteGtMdUdM?=
 =?utf-8?B?YmpWM2N4ZmVtZk5DQTNGNkZvNUFqbkd1WnlwWkpkNFJBdHptMFpTZTM2ZllD?=
 =?utf-8?B?R0gyMUxvOHFGbDFLL1hPK0wyWDhGK0k3WjF6TXhWWGRYY3F1aUpxenEvNmRT?=
 =?utf-8?B?MTI1U2owR0xPRm85UGFtQkJwRXRDK1Vlc1c2S1FnMG5JcnJmRE5xV2szdHhN?=
 =?utf-8?B?Vk9zMFRWZGx6K3lUdld1THQ3OGhKZzRXbGEvVXZCNFRySTRYQjhiSjBTcWxv?=
 =?utf-8?B?S3o4amVKRDVoOEY4Z05YaklmTGNlYkRoOTVNTGdmbDhTTUFNYTFqaXNuWDh6?=
 =?utf-8?B?WjdOanZtOFZ0QW14MUEyTDJldnNpdFRERlc4elVsUDJOK2NnKzRDcS8yMVJ3?=
 =?utf-8?B?WGRnb1pxdmI4ekhaK0lhTjFsM0ZUQ2w3R21ZbnR1OWVmRVZmNE5IT1FpR3ZR?=
 =?utf-8?B?L1JIQ1ZZQmVtVnp4YUVtd1YzaTNpYnhmVGNRNWt3UWZ1c2VncTR3RkEyMGV1?=
 =?utf-8?B?b3RWVjJCUnVhb2JOOUxPZllZRnJ0anpYYnZaRXo0WWE0aW5yNGRvNmdiV2Z1?=
 =?utf-8?B?dERTaUJDQmJVRFBsOGJJKzhYeThTNklqK2kzNEN0M1BXWkpzWWZVdWdkcFpU?=
 =?utf-8?B?RFVua2krMU5zdmZjOUM1djNUeWVPaUlzczdJdWhUblVab3JWU0FNdkNIVTdn?=
 =?utf-8?B?UGl1TEZHQkY1amV1YWo5NkdIWldJNUZXQ1A5YnQydlIrcXAzeVh2TVB0VXRF?=
 =?utf-8?B?TnpsNnBIZmEzM1c4YW5OR2FIV1p0azNORFpuaEF5ajBsemVjOGdUaGRtcFNJ?=
 =?utf-8?B?Q0Nxa2tDZlNONkRBVnpacFpIN25PTWtrcGREbU5mRkRzSjBzbzlxVklUclF4?=
 =?utf-8?B?emVub3lFYjYwMVdxYVhGT0Y1MGF6a0FaZGNZbC9OZWZKYWUrcis3cUttVFYy?=
 =?utf-8?B?UGVOcW5YcEVwRzl0dm8wZ21jSXFVbmFQV05YZ1JZa2trWEtuRWlpUkRIOHNB?=
 =?utf-8?B?QTh0V0FHSmZiNTZKU20wZEJCYUlzSWR3VkxyYlArUnVReVh5cU8yeEtYdUxj?=
 =?utf-8?B?QUUrS3JzRXpqaHZiY0JzcmY4eEdBbjlEZXFrMHZPVlNXcG9ZSGxWUjdRcC8x?=
 =?utf-8?B?MWpGelY0SmdlNDFHcFBRekV2MVh5NE81Zk8wQllGTjZsR3BDZ0M2SmdNNkhX?=
 =?utf-8?B?eDRtSHpvbHlua3BzRWgyNTBJc1RTblh2bFdPM0h5SEJkT0x2OWU4cXZmdXha?=
 =?utf-8?B?eWE0VnA1TVFvbm9YMFk3RmxSUk9zaHhudmk5aURtZEZKNUlNTGc1S0pjTktQ?=
 =?utf-8?B?KzVpZEhYOHpkZnhxdFE3alQ0d3J6dmJ4M0wrTVFvcVBFTHlFTUordzNxS0pt?=
 =?utf-8?Q?gxZctvI1HTKXjFaTSadbXpnT4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c97bd83-d795-4186-4b67-08dd0a49ab95
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 16:29:28.6044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4YjrNbDCcSPOILfyvlNGJMqFjmwCDyB/EV6e2eaCsSmK73fOgIX8AgkNMyCObZRH85SSuJAzUBA5AMqKEx5Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9103
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

Hi Gregory,

Please report a bug on https://gitlab.freedesktop.org/drm/amd/, and it 
will ask essential information for debugging when creating bugs. Thanks.

On 11/18/24 21:25, Gregory Carter wrote:
> Nov 18 18:37:33.973691 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel: warning: `QSampleCache::L' uses wireless 
> extensions which will stop working for Wi-Fi 7 hardware; use nl80211
> Nov 18 18:37:35.761857 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel: ------------[ cut here ]------------
> Nov 18 18:37:35.761928 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel: WARNING: CPU: 10 PID: 11 at drivers/gpu/ 
> drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:223 
> dmub_psr_enable+0xfa/0x110 [amdgpu]
> Nov 18 18:37:35.761940 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel: Modules linked in: snd_seq_dummy 
> snd_hrtimer rfcomm nft_masq nft_ct nft_reject_ipv4 nf_reject_ipv4 
> nft_reject nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 
> nf_defrag_ipv4 nf_table>
> Nov 18 18:37:35.761991 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel:  videobuf2_v4l2 btintel videobuf2_common 
> btbcm snd_seq_device libarc4 snd_pcm dell_smbios btmtk videodev spd5118 
> snd_timer snd_pci_acp5x dcdbas bluetooth cfg80211 r8169 mc rapl dell_>
> Nov 18 18:37:35.762015 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel: CPU: 10 UID: 0 PID: 11 Comm: kworker/ 
> u128:0 Not tainted 6.12.0-RX7900M #1
> Nov 18 18:37:35.762024 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel: Hardware name: Alienware Alienware m18 R1 
> AMD/049YP9, BIOS 1.15.0 09/09/2024
> Nov 18 18:37:35.762038 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel: Workqueue: dm_vblank_control_workqueue 
> amdgpu_dm_crtc_vblank_control_worker [amdgpu]
> Nov 18 18:37:35.762047 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel: RIP: 0010:dmub_psr_enable+0xfa/0x110 [amdgpu]
> Nov 18 18:37:35.762056 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel: Code: d1 81 fb e8 03 00 00 74 21 48 8b 44 
> 24 48 65 48 2b 04 25 28 00 00 00 75 15 48 83 c4 50 5b 5d 41 5c 41 5d 41 
> 5e c3 cc cc cc cc <0f> 0b eb db e8 4d 39 27 ee 66 66 2e 0f 1f 84 00 >
> Nov 18 18:37:35.762065 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel: RSP: 0018:ffffad0dc018fd38 EFLAGS: 00010246
> Nov 18 18:37:35.762074 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel: RAX: 0000001cb9fdfc52 RBX: 
> 00000000000003e9 RCX: 000000000000000a
> Nov 18 18:37:35.762082 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel: RDX: 00000000000001f4 RSI: 
> 000000000000004e RDI: 0000001cb9fdfa5e
> Nov 18 18:37:35.762090 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel: RBP: 0000000000000000 R08: 
> ffff9ee0128a6a00 R09: 0000000000001d00
> Nov 18 18:37:35.762098 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel: R10: ffffad0e00af3500 R11: 
> 000000000000001c R12: ffff9ee00cef9c90
> Nov 18 18:37:35.762105 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel: R13: 0000000000000000 R14: 
> ffffad0dc018fd3c R15: ffffad0dc018fe1c
> Nov 18 18:37:35.762114 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel: FS:  0000000000000000(0000) 
> GS:ffff9eeebd300000(0000) knlGS:0000000000000000
> Nov 18 18:37:35.762121 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
> 0000000080050033
> Nov 18 18:37:35.762129 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel: CR2: 00007f0f41031b28 CR3: 
> 0000000abb42a000 CR4: 0000000000f50ef0
> Nov 18 18:37:35.762140 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel: PKRU: 55555554
> Nov 18 18:37:35.762147 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel: Call Trace:
> Nov 18 18:37:35.762155 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel:  <TASK>
> Nov 18 18:37:35.762791 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel:  ? dmub_psr_enable+0xfa/0x110 [amdgpu]
> Nov 18 18:37:35.762811 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel:  ? __warn.cold+0x93/0xfa
> Nov 18 18:37:35.762818 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel:  ? dmub_psr_enable+0xfa/0x110 [amdgpu]
> Nov 18 18:37:35.762823 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel:  ? report_bug+0xff/0x140
> Nov 18 18:37:35.762830 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel:  ? handle_bug+0x58/0x90
> Nov 18 18:37:35.762835 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel:  ? exc_invalid_op+0x17/0x70
> Nov 18 18:37:35.762840 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel:  ? asm_exc_invalid_op+0x1a/0x20
> Nov 18 18:37:35.762847 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel:  ? dmub_psr_enable+0xfa/0x110 [amdgpu]
> Nov 18 18:37:35.762852 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel:  ? dmub_psr_enable+0xaf/0x110 [amdgpu]
> Nov 18 18:37:35.762858 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel:  edp_set_psr_allow_active+0x27d/0x3b0 
> [amdgpu]
> Nov 18 18:37:35.763760 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel:  amdgpu_dm_psr_disable+0x5b/0x80 [amdgpu]
> Nov 18 18:37:35.763807 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel: 
>   amdgpu_dm_crtc_vblank_control_worker+0x257/0x260 [amdgpu]
> Nov 18 18:37:35.763838 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel:  process_one_work+0x178/0x330
> Nov 18 18:37:35.763850 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel:  worker_thread+0x252/0x390
> Nov 18 18:37:35.763861 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel:  ? __pfx_worker_thread+0x10/0x10
> Nov 18 18:37:35.763871 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel:  kthread+0xcf/0x100
> Nov 18 18:37:35.763881 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel:  ? __pfx_kthread+0x10/0x10
> Nov 18 18:37:35.763892 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel:  ret_from_fork+0x31/0x50
> Nov 18 18:37:35.763906 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel:  ? __pfx_kthread+0x10/0x10
> Nov 18 18:37:35.763914 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel:  ret_from_fork_asm+0x1a/0x30
> Nov 18 18:37:35.763921 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel:  </TASK>
> Nov 18 18:37:35.763929 discernment.aesgi.com <http:// 
> discernment.aesgi.com> kernel: ---[ end trace 0000000000000000 ]---

