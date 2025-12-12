Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF25D4336A
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Dec 2025 09:02:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D66C10E313;
	Fri, 12 Dec 2025 09:02:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z0A628ve";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012051.outbound.protection.outlook.com [52.101.53.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5733F10E313
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Dec 2025 09:02:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OgEXuW9iVTB/xVPEALJ52vpcwH/ZE9yctKOmeu0nEphHnLLvEo91Ere7hvf01JROyMweJSe76g0jbFlIrPb7batun7mTjEHi07dmAHeFp2J/I+XU2/Z39t7kXu3201GeCfs6ONbp8bLK4gVwY/BRRx8oIjG5Ow4qyjoXZift5ZcJid6dXKwTKMfOQ3jEFRnbbolaujzuWiajnFZ4p7vfbOX9HzEtTOQnAebeNWyJDXLxIgJhkbTszZS90bLjKxlo5CALCmsXVdXaHsARahmniC/fdKYzRat4isl1hDKbyzhH5rpfpIItbACRMwQlIX0PPXVyE2bFRJmMR+ECWs7MfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sw3Euvd6u2NmE3aS3nO1ufwy16g58XPpXUJgDqpWcQ4=;
 b=saimfYsg1zWSXPfhOIkvsuY5+stOSSAOKsrpY9ug0XlMC5xZzmpvwJbA/fDVPhAo4TO03fX1NX86gwa/eotWzH53tuTbpn/H3IZrQ2YBRHidyi3SviURppl9va5X/dl6BbL9W4l6+0RDFT7oBsyPO17vXqcfY/E3iJRSENG817ZmUpWchpPlfbK3S/RBYq0iSCebh/q4YQ0lYstm73RDCFeaqAI4K3TbSAUhf/alYG6fdbk+3V44Y8O6KL+eN/5PLxqxvqeilmxvwsKOBIHxdQkMCkJlVyXP8BDJcqjvAVTcbyqp3DeCy0Uc6OAjoTaRCuV1QTgo21A6Dfovbhy+uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sw3Euvd6u2NmE3aS3nO1ufwy16g58XPpXUJgDqpWcQ4=;
 b=Z0A628ve+4mphZg7YZ0PHOSqYFXVQ0pPBRzbjIeBLHvHMwVxnU0BAMqxPJdCkGmxbYGhPwMqzvQjKHT5Lvta2RcB1TghxDcJ9EICsW1ePd+h56HfqVO8I9vAJ7qTO2g1FnYK8AJSCR45HjYpKJaW6qODWNd86nZCmgx4ayGKwkw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Fri, 12 Dec
 2025 09:02:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 09:02:05 +0000
Message-ID: <fbc164ab-964f-464d-b94a-80131016b5b8@amd.com>
Date: Fri, 12 Dec 2025 10:01:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/8] amdgpu/amdkfd: Add support for non-4K page
 size systems
To: Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Kent.Russell@amd.com, Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
References: <cover.1765519875.git.donettom@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <cover.1765519875.git.donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0847.namprd03.prod.outlook.com
 (2603:10b6:408:13d::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cc10003-5715-447f-d5f6-08de395d1f06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?djY3UC9DelhZd1g2aFpvNlhYM2Y1M0E1M0dBS3dQcGZKZWNYUk50VXZkS3Av?=
 =?utf-8?B?d3VJMUpLdFRQN2x3enVvZ09mcDZjS25UUWlSdTZ6UEdOOFM4ejJPbytlR2xr?=
 =?utf-8?B?OTlRQmZSWFlEYVB0cmJKNXN4eUhFcjV4dysxTGpYaVE1SmdBTS9Wclp1Y2pO?=
 =?utf-8?B?alY4TlRlbHlVZ2ZCYmZFVXlBNm9CRURjQ3NUWStIa0hGc3NDNW1iRllGemVr?=
 =?utf-8?B?dlQ4UmhUWUZTR2RCeEYxaFFLU1JJMFNUYml6MExvRm5pTmdRR3MxZVExVURm?=
 =?utf-8?B?TDBMZnZ2cSttbFB4YWFLbjliSDlQZWFtbFpYNEdSenNXbEtqM05VTjY3VTgx?=
 =?utf-8?B?TytKZVRHUTROTUpSUW5TelcrTmJYOVhtazZCTzUycGl5ekIvZ0l4TFpNSFhN?=
 =?utf-8?B?Nmkya0l4ckZVdkJ1OUZidmJjN2RRR2lZcGtsZVpCMXozVkpidjlhQkdFT2Ex?=
 =?utf-8?B?QVBVcURFTmw3OGRaTldrTTJ0NHNTRUZJRjFwMGNZRVFTQi9ZV0xUZ0RuZ0Zt?=
 =?utf-8?B?MC9VUVF4TVNQV1ZuaTF2azByNTkyMWdQRG4yMzVZVnpLOE5qRkdhVStoL2g3?=
 =?utf-8?B?VDVHZ0hTVm9DQndmdGQ2dW5JL3ROdVFmN1JBaEhFWG1xQWN0OVdmaittTlJK?=
 =?utf-8?B?N2dNL21UZUpiWFAwUnF4YWo4TjRENHE1S3dtYUlUREI1NG5JNWJ3TVVkUkpX?=
 =?utf-8?B?blU3OHo5NlJ2UFR0ZkN4cXJlS1hhWDhlbWpEeWd0S08rMm1IdzdLejB1eC90?=
 =?utf-8?B?TnZ2OFhYRVJHV3FsSnhqZmszZkRRZzBaRldHaFNqRHJuYm9venViS2pCTFRD?=
 =?utf-8?B?MFFuYnZVc0wxaHMrd3JoL0xUTXU1dldvd0lpcWxtd1hJQjY4T1NndVE2bFVw?=
 =?utf-8?B?V1E4RHQ3ZFRSajc5RWJtZGJtQ0VKMjBGaUhVd2c2a0RHRnN2STk0dG9NNlox?=
 =?utf-8?B?WUM3R3V0K1diMFNxRG5OZyt0eHpvaUxZSS9pc0VDR1Y3UUxuK2h0eUxWMlF4?=
 =?utf-8?B?ZDF5ZmZvOHdmcnlvWkFrelFWbVlMU1pVNFd2L3JqZHdnMmViR3FIZVdQN0Vh?=
 =?utf-8?B?U3pKV0NIRmhjWXlGdktKWVRka1A0ZDNoVkdwRW95WEJpMUR3N2hFeHBuTWRC?=
 =?utf-8?B?cjBCUXZiMHVPMFFhN0JTaHpmNlFiaUltSG9nczRHSHNTR2tRWXljK2sxemkz?=
 =?utf-8?B?RkdoN2htdVIwcHVmZXBvOGhUYTdNZFNHTmpJNVAwYUZuTDIzQ1NVaEwvbXlt?=
 =?utf-8?B?TTRxQzJDZmdzVitUdS9qSWYyQ1kyTENJaG93WWdnV3NPbWN6ZWx2V3JFOFF4?=
 =?utf-8?B?NW9XbGNkWGRiUGt1S1I4T2k2S0Y4ZHFRYmkxV2wxNWZYNlBXWm53YTRYSHhl?=
 =?utf-8?B?bTVteFZGWDVVRUY5YkEvNkRBTWttakV5eUx6Mjd4dHlFSTZIZ3lUd3hjbjhL?=
 =?utf-8?B?d1Bza2U2aTdWRFJkL0pMakRUU21PRlk5K0NWQWNXRm5kVnBZZXdIQXlwZDBC?=
 =?utf-8?B?Y2Z5UGF2MldXVHZTdFZLUTlSWUtCVEFLc0RCclBXMUhXZ3ZaYUpXSVhFd1l3?=
 =?utf-8?B?ZTgxa1RwZjNoNlAvODdhbTJDSnRlV2YwckFqK2VBcWxCUWpYNlBHYzhlQ1VL?=
 =?utf-8?B?OWlTbmxwMHlHTG5xZ0ZsMXJxbE9PSnJGZUZaWGUzN0ZseXNhMFNraXJlZ0ND?=
 =?utf-8?B?eWdkSDR3b1kzNWZ2Z3lnQkZLZmJHYkI1Q0dQSlFqRVo0TEJZQWZwRmdkRWtX?=
 =?utf-8?B?TDlCY3B0TjdSWTZkVDJWdUpBWjBhTjgzb3psMEpQcG5HSEhRNldsTDRucGhI?=
 =?utf-8?B?VWNrNGNGRi9Nc3pyUEtmQzNTWmoybGU3SUdRcDdoS2NXVnE3YklndUVLMitE?=
 =?utf-8?B?VE9FNjFKUDYrbzI1SHg1dkQ4ZGt0aExMQy9qNXhyZmFDVTgvbHRqcUJLR1o5?=
 =?utf-8?B?cnJQdWNnQkE4dHRHNFQxMXorYlM4VXpWek94dlY5UU1iSDQxVGJ0VFN1SU5Q?=
 =?utf-8?B?RWRPcVhBejZnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjhnMVZGN1VHY3FCa3MyYlRhei8vZXUyZjVESXRoRERvdmZNblZHY0lWS00z?=
 =?utf-8?B?cGJ6WEFwdmxRSGJwWGthK3BaSHduazJlQWJCeEoyT0lQVDAxZk9nVm43UjRG?=
 =?utf-8?B?MEJoRDFXZTFnUVZqMHNWd3F6RlNiTzNqTFJ5NSs3b3hRZ0Y2RHloL29XUVJp?=
 =?utf-8?B?K1RZYWJ0MC9RdnJBNFF3OExMMWJQRHg4dHAydjRxTmNXdVE1UGxWbCs0ZEpw?=
 =?utf-8?B?MnpiTkc0b0pHb2hmMDBtUGFvUUUwVThCdmpIbzQydG5ZazQvRnBtZDB5ek93?=
 =?utf-8?B?OG45N25DMnVYSHgvcTdxckNHd1pvREI3QlhpUHo0M1U0ZXV5WWdPWGNacTc5?=
 =?utf-8?B?L0RRanI5QU9hQ20vcE5EYWNtaGRZL2M0WXZjeEV0WlpBcjNOTldPVmZXSDli?=
 =?utf-8?B?OUQvNnM4SU9mUTA4b2RodW9zZjVmZnhaRzc5clRwY2NrOHk4bnBPQTNLR0Zz?=
 =?utf-8?B?alFzN1U0M2IybHpLRGpYNmRqVnh1cW5FbDRUZFhKeHNCRVZ2aTRkbmFiLzVY?=
 =?utf-8?B?L3BOU3N4T2VlU0tUbmp6WEpWd05HRm4xQWNvS1N3Vy9FQUdTNUgrZzVKWFdP?=
 =?utf-8?B?anM0RWZib0tJb25RWWt2dDNPMElRVEIvSHV6c0JwNTBINnFWNmFKYVBBVmh3?=
 =?utf-8?B?eFl0ZU5WT2duanRhd0grVVN5aWlGWHJLbWZzMk01TVJHd1pYeFZVRStYRjdK?=
 =?utf-8?B?K2R3UG1yOWxjN1o4Q1ZpclFaNjhsNkhjTEtUR2hjSExwTEhxQkVJSko5UXhP?=
 =?utf-8?B?bnRIWWJMQ3NhbXBRdkpTT1RTaWdHZmhYRzZXNmxDR29Sby9xR0IwUTFOM1pS?=
 =?utf-8?B?UGVzVm41ZzA4Vk44MFIzMGRVN3Z1L0Z2VTBvQ0tDRUJQVnIrMnZYRDFJWFFQ?=
 =?utf-8?B?cVc1TFdpek02NVR1OGhjSHVjUXZzTVJxOVFhL3I5dk9oQkJvNjZxd21rakkw?=
 =?utf-8?B?ZWFwK05OSU44aGdXRnU3ejhveElhNXNsVmVjMHZPbkRxT1pXSkI4clFzaDhi?=
 =?utf-8?B?SmVleVYyd080c1ZNVXkxM2U5NXgvUWkwQVd6QVNVOGVsa0NQMzh6VklzU0J5?=
 =?utf-8?B?dU51MFc2TVpYOXFlSGpxZFpvMFFpenYzZGI5MHMyQWpMUm5rZnltbW9ldTlj?=
 =?utf-8?B?bCs0ajUwa1Y5Y0Jid3J4aWZNRndlMmtsTjY0Z1NvanhsbGVGQUw1eDFyalY0?=
 =?utf-8?B?SXZRS3AxaE5sN3lMVFVXZ3dHcHY5OFo5Tmo1aTRtbVBSTU50TmpRdit2Tmhm?=
 =?utf-8?B?TFJpb0VQYks4ZmpJRXljSDI3YUZHWDhYMERod3NWTTMzdlQxdVhBSVhaOW5x?=
 =?utf-8?B?T1FNZUtBWUpZRy9qdVNzRjhSejVjVEt2eE1lcy9MZUc1U3lQOEJBMEozNTI4?=
 =?utf-8?B?YUp6WkhxSENkdUZGS09BaDY3LzNvMk1KbmpiemxUYStnRC9Wb3AxMUtEdFRu?=
 =?utf-8?B?K1JDSm1XZGE5dlBaaXhRMHlLWHZ6WktzN3VMbEQ1QXBCaDhJZ3VLSGJiWWcw?=
 =?utf-8?B?U3I4cjhIckdrU21FZTl4MUhJL3dMMmw5MG5BYXVHUUV3QmVrM0U5Sk5DdmtS?=
 =?utf-8?B?SitFbnV5L0pTU2UzMU1KZnhIb21PNkF3TERhb0RKL0JhU2E3K3UyNWNJWE9R?=
 =?utf-8?B?QUNHMUkxd05ueHd0MmU0d3ZGV3ArdTFJL29FVkNuTVgyQ1Fqd1UrTmRtdWQr?=
 =?utf-8?B?aWRiRE1Pd3B4NjUwaUoyaTJwNkhZcG0wM01zczRBb2c2TnRleisxOUE0djhW?=
 =?utf-8?B?WXRTNm5sc2d2OHE5MTVtdVoxWUlTY1YrUWpDTXc1Rmlkdm95TVZra2h2cDJ4?=
 =?utf-8?B?RHlMR2lVTkZCU2lGeHprNlA1RUZHelZHSDJGZm1hSWNXMlFLK2ZPbnc5VmI2?=
 =?utf-8?B?bkF4SjB3RVJFWFhRM1FlQ1VmTFdYSHpNQXlzNVdXRnBCTHJZRjNhRWFVb0tX?=
 =?utf-8?B?S3VQb0Fpa1g1cjRzYklOUFRUdUwzU09HdEhTTnR4RnF5UERxdnlWSU82WDhz?=
 =?utf-8?B?K2pEeUkrLzR1UVhDSThHejNjVm1CSXROSEZCOE9OdEk3aVFBK3M3bzdZTmYz?=
 =?utf-8?B?UEpoY2ZpWFdxQkNYM1VKd2JaRWk3NlhuVWtpNWdYWFBQYk56VDEvRGxBV2hR?=
 =?utf-8?Q?kV6cNoiZmxdYwevbvUtyaRNPy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc10003-5715-447f-d5f6-08de395d1f06
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 09:02:05.0010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2nEyYCT3mdVC+QKJXNl47hYiCmTHKERzFzOBiidG4ahSxVjKl5vLgiFIBPlMxjta
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7763
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

On 12/12/25 07:40, Donet Tom wrote:
> This patch series addresses few issues which we encountered while running rocr
> debug agent and rccl unit tests with AMD GPU on Power10 (ppc64le), using 64k
> system pagesize.
> 
> Note that we don't observe any of these issues while booting with 4k system
> pagesize on Power. So with the 64K system pagesize what we observed so far is,
> at few of the places, the conversion between gpu pfn to cpu pfn (or vice versa)
> may not be done correctly (due to different page size of AMD GPU (4K)
> v/s cpu pagesize (64K)) which causes issues like gpu page faults or gpu hang
> while running these tests.
> 
> Changes so far in this series:
> =============================
> 1. For now, during kfd queue creation, this patch lifts the restriction on EOP
>    buffer size to be same buffer object mapping size.
> 
> 2. Fix SVM range map/unmap operations to convert CPU page numbers to GPU page
>    numbers before calling amdgpu_vm_update_range(), which expects 4K GPU pages.
>    Without this the rocr-debug-agent tests and rccl unit  tests were failing.
> 
> 3. Fix GART PTE allocation in migration code to account for multiple GPU pages
>    per CPU page. The current code only allocates PTEs based on number of CPU
>    pages, but GART may need one PTE per 4K GPU page.
> 
> 4. Adjust AMDGPU_GTT_MAX_TRANSFER_SIZE to respect the SDMA engine's 4MB hardware
>    limit regardless of CPU page size. The hardcoded 512 pages worked on 4K
>    systems but seems to be exceeding the limit with 64K system page size.
> 
> 5. In the current driver, MMIO remap is supported only when the system page
>    size is 4K. Error messages have been added to indicate that MMIO remap
>    is not supported on systems with a non-4K page size.
> 
> 6. Fix amdgpu page fault handler (for xnack) to pass the corresponding system
>    pfn (instead of gpu pfn) for restoring SVM range mapping.
> 
> 7. Align ctl_stack_size and wg_data_size to GPU page size.
> 
> 8. On systems where the CPU page size is larger than the GPU’s 4K page size,
>    the MQD and control stack are aligned to the CPU PAGE_SIZE, causing
>    multiple GPU pages to inherit the UC attribute incorrectly. This results
>    in the control-stack area being mis-mapped and leads to queue preemption
>    and eviction failures. Aligning both regions to the GPU page size
>    ensures the MQD is mapped UC and the control stack NC, restoring correct
>    behavior.
> 
> 9. Apart from these 8 changes, we also needed this change [1]. Without this change
>    kernel simply crashes when running rocminfo command itself.
>    [1]: https://github.com/greenforce-project/chromeos-kernel-mirror/commit/2b33fad96c3129a2a53a42b9d90fb3b906145b98
> 
> Setup details:
> ============
> System details: Power10 LPAR using 64K pagesize.
> AMD GPU:
>   Name:                    gfx90a
>   Marketing Name:          AMD Instinct MI210
> 
> Queries:
> =======
> 1. We currently ran rocr-debug agent tests [1]  and rccl unit tests [2] to test
>    these changes. Is there anything else that you would suggest us to run to
>    shake out any other page size related issues w.r.t the kernel driver?

The ROCm team needs to answer that.

> 2. Patch 1/8: We have a querry regarding eop buffer size Is this eop ring buffer
>    size HW dependent? Should it be made PAGE_SIZE?

Yes and no.

> 
> 3. Patch 5/8: also have a query w.r.t the error paths when system page size > 4K.
>    Do we need to lift this restriction and add MMIO remap support for systems with
>    non-4K page sizes?

The problem is the HW can't do this.

> 
> [1] ROCr debug agent tests: https://github.com/ROCm/rocr_debug_agent
> [2] RCCL tests: https://github.com/ROCm/rccl/tree/develop/test
> 
> 
> Please note that the changes in this series are on a best effort basis from our
> end. Therefore, requesting the amd-gfx community (who have deeper knowledge of the
> HW & SW stack) to kindly help with the review and provide feedback / comments on
> these patches. The idea here is, to also have non-4K pagesize (e.g. 64K) well
> supported with amd gpu kernel driver.

Well this is generally nice to have, but there are unfortunately some HW limitations which makes ROCm pretty much unusable on non 4k page size systems.

What we can do is to support graphics and MM, but that should already work out of the box.

I need to talk with Alex and the ROCm team about it if workarounds can be implemented for those issues.

Regards,
Christian.

> 
> Donet Tom (7):
>   drm/amdkfd: Relax size checking during queue buffer get
>   amdkfd/kfd_svm: Fix SVM map/unmap address conversion for non-4k page
>     sizes
>   amdkfd/kfd_migrate: Fix GART PTE for non-4K pagesize in
>     svm_migrate_gart_map()
>   amdgpu/amdgpu_ttm: Fix AMDGPU_GTT_MAX_TRANSFER_SIZE for non-4K page
>     size
>   drm/amdgpu: Handle GPU page faults correctly on non-4K page systems
>   amdgpu: Align ctl_stack_size and wg_data_size to GPU page size instead
>     of CPU page size
>   amdgpu: Fix MQD and control stack alignment for non-4K CPU page size
>     systems
> 
> Ritesh Harjani (IBM) (1):
>   amdkfd/kfd_chardev: Add error message for non-4k pagesize failures
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c      | 29 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h      |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 16 ++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  6 ++--
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 10 +++++--
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  2 +-
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 15 +++++-----
>  drivers/gpu/drm/amd/amdkfd/kfd_queue.c        | 17 ++++++-----
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 30 ++++++++++++++-----
>  10 files changed, 86 insertions(+), 43 deletions(-)
> 

