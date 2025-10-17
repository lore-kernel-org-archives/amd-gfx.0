Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36565CCD184
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 23:58:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0DE410E1CC;
	Fri, 17 Oct 2025 23:58:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n/zQODcM";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010001.outbound.protection.outlook.com [52.101.201.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 143A410E1CC
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 23:58:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzUUtg4rF/UPH6i7npMcRU69DNd39BvyxrlQWOlNGZcXJnDxJsEqRQrkkZB7NSZqrePe/rnvxng160ZJHwUpiMaSgx7FOXec86X07LK5mHXpV6WlocwgBTSzX09rumrh8FDD7j1Tk8kotlnwi68sH8nfT8wuw81m11cpJkOYG8gspKr2hkl2Bgk4VaLtXzo558zflEhsCSjpSLV7EZq4ZuVO1HuMgJH+Xo/uRbV1a5VLU9lgy80rmhvuOTBw2Roq+P6i4lDJ6cCkD7h728LhiLTPJ3asssE2ur5TC7k8RzgfEf2H+z6Rfa9mBs+fMBg7PPrlsDA8BY5uqIq5YvYvlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1anY4IonPXKxUKoWQsv+xGa3++3ZrarnzMiPEcvXCs=;
 b=WZNjs9UAsrGD5MmAGz5Aem/3M9zZee+k7lh84evayXfzUFDEsg4sHDJAzoVsEfnLXUWnQ6GxNO+MOSz+0R0UTAa0Lm/sqhYNvz3C+JhoKhfmX/LoqyyqEu4Ux0g0+rK+LxjCJz3CUkO8rqlEmrH0MWpH3QKmOYPgM53Q8RspXYeG/AzUyE9JQvUKkDwDR8P38pCXqRShqHFqMADgTaIl3EG24tpFsVIQuxtt5yjCNum5IVV0XUkHp44blM4IqCpnRkE/e/odqumGxJ3qgbkeGVDDvvdfKMNw4CE5FUhWff7hzc1d9bA6Flj5HQBByjWXnZQFErdwLS5CAAF4G6k1Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1anY4IonPXKxUKoWQsv+xGa3++3ZrarnzMiPEcvXCs=;
 b=n/zQODcMUqwfCBY5fV+frbnuxzXgLwuvyJtgplpqqzIL3bP0Dqk+CD/wPsDyiRQw7/V/1rqLzNbUgrLeqjWankrl2NXaJNVFPrzdS8t+9TTshSjel8UyfaT6YjmLX5Uw6x3U+IRIACN8PaUkUp8EwfBVDZGnGsH0cFv6LOb+F0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB6990.namprd12.prod.outlook.com (2603:10b6:a03:449::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 23:58:31 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9228.005; Fri, 17 Oct 2025
 23:58:31 +0000
Message-ID: <41489a22-d687-4ccf-a3e2-d1126bb79ebd@amd.com>
Date: Fri, 17 Oct 2025 19:58:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 00/18] [PATCH V4 00/18] amdkfd: Implement kfd multiple
 contexts
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20251017084222.54721-1-lingshan.zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20251017084222.54721-1-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0045.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::7) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a09364c-4d33-49a8-77c4-08de0dd912d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTZmNEprTlVMWEt1OUxjNUZjdjZoamN6RURsRzlnZ085SzlhbnNhQkFaU0hp?=
 =?utf-8?B?UkN3cUZ6cE1NS2dhbWE5aHM0aUZNK01RWXE2aWM3YkUyeXkvVG5oL2lBbk1I?=
 =?utf-8?B?ZzlJSkxXOTZlN3dNMFZSUksrK3cya0orVldTZTVQT0djK1hiOWw2K3VoVzZ6?=
 =?utf-8?B?RkllRmI2V0RhaUdXS2dQcmZib29zbG5FdjlwWWJCUitiRjhiWHV1NjZIVU9z?=
 =?utf-8?B?WHpRaFpJVW55c1QvT2tqLytwNFovRzkrTVgzbU5vS1NIWWJFZzE4SldUNGYr?=
 =?utf-8?B?Z1VsRFhPMi8zNlQxM0xzWC9PMnlwK1k1ZlBIZkhXU0Y2eHFpUHZZbUJYeDU3?=
 =?utf-8?B?N2Q1K0U1ekhpcWdLaEczVXAvUzIwcUlleTVjdWVtdWpnZnY2WVJuK0JveTds?=
 =?utf-8?B?WTdJMVpiOTl3a3VTYWlTQWNKaHhaTUxvQ29sNGJqSlYzN292V0hlcERlRGMr?=
 =?utf-8?B?a1JETGh3VElXMjFxNmljNSt2MXp6NUwvbHpIS0RmSGR5UFJaVmpVUnJCbGtl?=
 =?utf-8?B?L0hsNHFCZW9TWSs2Zzk2VEpmM1NjUFptWVdxWll4SGUrUnpuQ3pRTnVBTDdZ?=
 =?utf-8?B?NWVMRDVBODBJREFlY05UbGhOdjdDYXBweFVrVUFnOWdVZ21KdWduMS94ZWts?=
 =?utf-8?B?d2NPSVNiaHg3OXlSNy9hODRlTE51TEFFNS9vU1Z1aTBRK1d1SzBWR1JQUS9P?=
 =?utf-8?B?RTN1dG56WmtUODhKcEdYTG54dDJURjgrQS9SUjc3UWtna2M3NmM5Q1lJVnFw?=
 =?utf-8?B?SHF1djVacyt4V2NKOXZBTm1udHh3cDRiZXRIRHgvOHdDZFM5UThjQTlmTUFl?=
 =?utf-8?B?dHFpVkxWYUZwU0FReHFaRUZiWUJaS1E3bXAzQWZYQTRwZHAyNnd6bHgrSkg1?=
 =?utf-8?B?TDZrY1o4OVNHSHVLenBrZ3UvSzcxdG55eG9ZNzFBTXFXdStGdGx0ZU05TDN0?=
 =?utf-8?B?UWVpMVljTWhydGd2RUNSQ0xtT3FvWmRWUSt4Q0RrMVV2TkgxRFZEb1AzaWpK?=
 =?utf-8?B?b0gyTDVtQXhkZGtEUzBDMnRzRTJXY1c5TVhSYnhleHQ1aVBHNUk4MUs2MjFK?=
 =?utf-8?B?b2FqWHZGanFtaU1hUWtLTUxsOEsyaC9aZDNjMDdHdklpVlBCaW1LMzZ1R252?=
 =?utf-8?B?NlNBeDVMS3U5TUREREg4MUVFUmJXZTZmNDk0RUJjKyt4WVIyL2RzaTkzaWlJ?=
 =?utf-8?B?dURKZWNsSllCSndMdXB0TlNVMkxLYjg3czB3V1pqZEQwMXRHODdIVWJaamVB?=
 =?utf-8?B?TTlEcUhWd1U1Ym1qYWR1VldhampoOTI4OFRyNlhlSjZMSzlodTBVd25vdzIz?=
 =?utf-8?B?SGhFZ3BPc0dvV3M0N0RWaGVaaEI1WDM2L05QUFdNTkFlOTZuQXNLQUdTdkdp?=
 =?utf-8?B?NUZqd0lEWitvTlZ2TnpWVklvYnVMbFhib3Fkc1Y4djloUzJjQ1YrMXBqZzla?=
 =?utf-8?B?bGk0cXc3R21CdGR5M2dCMFByVjBON1JTck8ra3BiYjc5eFVuTVZObk9qdEYr?=
 =?utf-8?B?R3FLZlRGRXY0SW1YZ2hhVDkzcXpUS3dZNzRhdzVjeWg3QTlKelRlVGZZM25i?=
 =?utf-8?B?UEREMnFMOGlnTGJlOU1sN3ZmZFQvbjN5elNTbDFSSFVUR2JsWTRVZkhyMHJ4?=
 =?utf-8?B?YlB2aGQwQXVBZDFhZW5sUDZHWW5tbE4waGx1YnRSSFVkUzVDZHY1UjhaZUVs?=
 =?utf-8?B?Y1A1U0srTEFkamFacmZWZXQ2eUpHdlFhc2FkT25VUTdHQ21FZkh0eXZUSVdl?=
 =?utf-8?B?ckp2anJFeTVFNm1yM3RDQnM2N1Q0TDhwVEN5Wm1rQWlBcFZwRzhsaTc4Rm5R?=
 =?utf-8?B?WkR3YU1jcmJMVnRkUk5ORVJLOVpYRldCamFoWW80cnE5SWM4RGdnU3VMZ3Ny?=
 =?utf-8?B?amlVb3FrUGxCeVVteXlTWldoNHJkZVVGZkova2F2eFNyRDVZRzZhSmJNdGhr?=
 =?utf-8?B?cEVycDZGOVBtaWp5ZnhnT095Q2EwK3lQNGZFU2c1VEdCSG9keVBMaWZxNVBW?=
 =?utf-8?B?NDlCT2N4U2RnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkhTbnBHd29GUDQ1NTYwdXJ6TnNlVW1tNEgzQjdMbzlRTTVZL3BFcmZPSU92?=
 =?utf-8?B?ejJXd0h5Tlp6Mm41L1VpVFBGWWFLcU5CdmZnbDQ5Tks0S0FpZUpabTd3cXY3?=
 =?utf-8?B?bVhrNWNkQTNBK0dETm9BMUdUY282R2ZzYjRtdDFJMUlRektER00rUlJrbDhS?=
 =?utf-8?B?bHRMR2Z3NStFWFgrbTRCTU9xeXBjZ0ZCMDlZbUV5c3FmbVJIZVJad0U2Y1NB?=
 =?utf-8?B?WUlDK2JtUzhTY2FmNVRiYjB3Q2ZLdDNKckZjYmYrZndFODVROXBHVVJJK3I0?=
 =?utf-8?B?Zm9FaHY1end4dmx3VGhLWjVIVG5idUJXWTZ5N05uTXhaTWVUZlhqN0ZpclFP?=
 =?utf-8?B?ZU5iRkdON0NhR1lCQWhTMDI1K3ducGRDb05WL0R1aml0bUc3UHdjck1kODFu?=
 =?utf-8?B?NWVnazc4MFVDdGJMN3lRbVp6SUk0SzN4VGE3M29PK0czYm5vZnprS2tCNldz?=
 =?utf-8?B?Wld5QkkrbXQ5dGZxc1hObTNNa095aDdkWUMvOEhLMjNXajlqdXpkZWlhMlhU?=
 =?utf-8?B?bEh5TmpFeXB1bjJZZlo4SGJMbVFaMjZwcEZOZjNGRC9SZ2V5Tmx5U3UyaWJO?=
 =?utf-8?B?Mm1MQ1gxMzdWR0RMZHNObEZvd0tIVEphQ3E2Z2QxN3JmcEJOU1doZWFRaHZH?=
 =?utf-8?B?bkJNSU9yYkFuWnhNMmN6M3cxRHNobDllb2JXNzlxZUVqUXZJZ2Zmb0RXM0Uv?=
 =?utf-8?B?ZmVoWHNJd2RpVk5hNHpyczNwTG56Q3Zqc2dXMkdtZHQreHdxUTFMS2xkRnRu?=
 =?utf-8?B?ek9JVFlKL3dmZWRqNWhIZHZzZ1ljaVNFOGRkUDE4TC9FNGlpWTI2bUxJLy9W?=
 =?utf-8?B?eWZaY013UzJIR1g5Znh0b2l2R2xHZWxIcmtOSUxDR0ZibENuUGRXUXFMbXJF?=
 =?utf-8?B?Y2VVbndsYzNkalQwNmxZQ1lQL3RpS2N3MjAzalB1MkxMV2hnN2tXMGVuSmti?=
 =?utf-8?B?ZWFvY3I1OGxYZ2tJalBBdjRLNjdNajRCcGpMRkUrRXZNVHNsRVNCZjM3Z3FF?=
 =?utf-8?B?VUREUHdsNStPckJNK3lNbi9mTnlwaVhSL242MkJJK25DU1dMOU1aWk8vOGlN?=
 =?utf-8?B?N1JBZlQ4QTZ6UkNHV3c4VXF3YS90T1Y1MHBtQzlIZ2dzdkcwMjk5OXhrMktH?=
 =?utf-8?B?a25qUnNwYjBDZFI2a0RaMVVjU2gxQ1hPUFVFbFBrTk9vVTFCd1NwbGtmM3ln?=
 =?utf-8?B?UFhzYVo5cnVLUUxHeitEREJjOWc3REZpeWNYckFmdTA2cTJvaTh6U1hiQm0r?=
 =?utf-8?B?S1VRRzdaR3FFMkVJUjcyTnErd3NtWXN3aWQ2bnpya09oNTFGbVFkdFBDZEs3?=
 =?utf-8?B?aU1VWEViaXNNYkJ4blJCYUR4b2JEWUF6c3lwdTNVcGpiUUJvQW05UDJ0YWRu?=
 =?utf-8?B?YmhiK3NyT2RjSlBQTCtsZHlTK0Y4UmQrczBrODhDblNhenpHVzBUcEdiNUht?=
 =?utf-8?B?NElaVEw3cUlYTkhIUTYzS1ZZYTZNQmZndVpNOXlzaWxnTUVNZFRBMWRRL3dX?=
 =?utf-8?B?ck13ZGNvb2F2Sk4zU3ArQTNiRVdzSXFOYVB5RWhOeXVmb01aNlZicHJmTWN2?=
 =?utf-8?B?Qk5Ya1VlbG1KdzBzU3FwZ0xtb1l5eHREWWZIamp0TWwzcy90VFFtYXVIOUxQ?=
 =?utf-8?B?WTRBMjgxT09lbmcvR0Z5VDQzcnM3V0ZOd1NZdGZ5MDFMcUxFV0Ywek5HU3Rw?=
 =?utf-8?B?QnpUdDhnaHRXK2VyeUpCbUtOZGtvK0xlaUIxc3JqdHdRMlZ4MjRXOXdGdEg4?=
 =?utf-8?B?cGRYdXBJZW1sVWR6QUNuenNhWVljSElRK1JPbXROcFhwTzA0Q1lnZGZBYjV1?=
 =?utf-8?B?cHcrVTJYZHdIOUVlTFdZelBEOWFDNDl3TEIzS2tacjNrU3lzeHo5M0l4SWJy?=
 =?utf-8?B?eXJCdTNFT3FBWmhJUThSazAxd2RGek9UaFA5QnVnUnY3b2VPakpiNnJISnRE?=
 =?utf-8?B?SUFWeDJoblFSazFOWWw1bmlJamRUL1FhL1o2S2ROc2lxREhGblJNbUJaUW5o?=
 =?utf-8?B?RWxCUWpWYkZNRzhRU1NqSHNEa2dyL01wb3hXRVM4Q0lCaXliQ24yNUZKcHc1?=
 =?utf-8?B?R0pLZHRqa3Q1M21sbTNJYmlDUWo1OGN0a3ZjT0tjN0ljWjZwSTRWdGRJRmdh?=
 =?utf-8?Q?VAiLL+JEJLNkz9cV2WK4Pp/Sf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a09364c-4d33-49a8-77c4-08de0dd912d1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 23:58:30.9987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHbYdWwgx5RyuG13s5ijhCkdUkFp9a7d3CSkL5OkKw3ArgTCS/vTOlVhmf4Kid1RMXN6080y92lGz0f02pClkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6990
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

See my comments on patches 8, 17 and 18. The remaining patches look good 
and are

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

I think this patch series is nearly ready, pending actual user mode code 
that uses it.

Regards,
   Felix


On 2025-10-17 04:42, Zhu Lingshan wrote:
> Currently kfd manages kfd_process in a one context (kfd_process)
> per program manner, thus each user space program
> only onws one kfd context (kfd_process).
>
> This model works fine for most of the programs, but imperfect
> for a hypervisor like QEMU. Because all programs in the guest
> user space share the same only one kfd context, which is
> problematic, including but not limited to:
>
> As illustrated in Figure 1, all guest user space programs share the same fd of /dev/kfd
> and the same kfd_process, and the same PASID leading to the same
> GPU_VM address space. Therefore the IOVA range of each
> guest user space programs are not isolated,
> they can attack each other through GPU DMA.
>
>
>   +----------------------------------------------------------------------------------+
>   |                                                                                  |
>   |  +-----------+      +-----------+      +------------+      +------------+        |
>   |  |           |      |           |      |            |      |            |        |
>   |  | Program 1 |      | Program 2 |      | Program 3  |      | Program N  |        |
>   |  |           |      |           |      |            |      |            |        |
>   |  +----+------+      +--------+--+      +--+---------+      +-----+------+        |
>   |       |                      |            |                      |               |
>   |       |                      |            |                      |        Guest  |
>   |       |                      |            |                      |               |
>   +-------+----------------------+------------+----------------------+---------------+
>           |                      |            |                      |
>           |                      |            |                      |
>           |                      |            |                      |
>           |                      |            |                      |
>           |                   +--+------------+---+                  |
>           |                   | file descriptor   |                  |
>           +-------------------+ of /dev/kfd       +------------------+
>                               | opened by QEMU    |
>                               |                   |
>                               +---------+---------+                   User Space
>                                         |                             QEMU
>                                         |
> ---------------------------------------+-----------------------------------------------------
>                                         |                             Kernel Space
>                                         |                             KFD Module
>                                         |
>                                +--------+--------+
>                                |                 |
>                                |   kfd_process   |<------------------The only one KFD context
>                                |                 |
>                                +--------+--------+
>                                         |
>                                +--------+--------+
>                                |     PASID       |
>                                +--------+--------+
>                                         |
>                                +--------+--------+
>                                |      GPU_VM     |
>                                +-----------------+
>
>                                   Fiture 1
>
>
> This series implements a multiple contexts solution:
> - Allow each program to create and hold multiple contexts (kfd processes)
> - Each context has its own fd of /dev/kfd and an exclusive kfd_process,
>    which is a secondary kfd context. So that PASID/GPU VM isolates their IOVA address spaces.
>    Therefore, they can not attack each other through GPU DMA.
>
> The design is illustrated in Figure 2 below:
>
>     +---------------------------------------------------------------------------------------------------------+
>     |                                                                                                         |
>     |                                                                                                         |
>     |                                                                                                         |
>     |       +----------------------------------------------------------------------------------+              |
>     |       |                                                                                  |              |
>     |       | +-----------+      +-----------+     +-----------+    +-----------+              |              |
>     |       | |           |      |           |     |           |    |           |              |              |
>     |       | | Program 1 |      | Program 2 |     | Program 3 |    | Program N |              |              |
>     |       | |           |      |           |     |           |    |           |              |              |
>     |       | +-----+-----+      +-----+-----+     +-----+-----+    +-----+-----+              |              |
>     |       |       |                  |                 |                |                    |              |
>     |       |       |                  |                 |                |        Guest       |              |
>     |       |       |                  |                 |                |                    |              |
>     |       +-------+------------------+-----------------+----------------+--------------------+              |
>     |               |                  |                 |                |                            QEMU   |
>     |               |                  |                 |                |                                   |
>     +---------------+------------------+-----------------+----------------+--------------------------+--------+
>                     |                  |                 |                |                          |
>                     |                  |                 |                |                          |
>                     |                  |                 |                |                          |
>                 +---+----+         +---+----+        +---+----+       +---+----+                 +---+-----+
>                 |        |         |        |        |        |       |        |                 | Primary |
>                 |  FD 1  |         |  FD 2  |        |  FD 3  |       |  FD 4  |                 |   FD    |
>                 |        |         |        |        |        |       |        |                 |         |
>                 +---+----+         +---+----+        +---+----+       +----+---+                 +----+----+
>                     |                  |                 |                 |                          |             User Space
>                     |                  |                 |                 |                          |
> -------------------+------------------+-----------------+-----------------+--------------------------+----------------------------
>                     |                  |                 |                 |                          |             Kernel SPace
>                     |                  |                 |                 |                          |
>                     |                  |                 |                 |                          |
>     +--------------------------------------------------------------------------------------------------------------------------+
>     |        +------+------+    +------+------+   +------+------+   +------+------+            +------+------+                 |
>     |        | Secondary   |    | Secondary   |   | Secondary   |   | Secondary   |            |  Primary    |   KFD Module    |
>     |        |kfd_process 1|    |kfd_process 2|   |kfd_process 3|   |kfd_process 4|            | kfd_process |                 |
>     |        |             |    |             |   |             |   |             |            |             |                 |
>     |        +------+------+    +------+------+   +------+------+   +------+------+            +------+------+                 |
>     |               |                  |                 |                 |                          |                        |
>     |        +------+------+    +------+------+   +------+------+   +------+------+            +------+------+                 |
>     |        |   PASID     |    |   PASID     |   |   PASID     |   |   PASID     |            |   PASID     |                 |
>     |        +------+------+    +------+------+   +------+------+   +------+------+            +------+------+                 |
>     |               |                  |                 |                 |                          |                        |
>     |               |                  |                 |                 |                          |                        |
>     |        +------+------+    +------+------+   +------+------+   +------+------+            +------+------+                 |
>     |        |   GPU_VM    |    |   GPU_VM    |   |   GPU_VM    |   |   GPU_VM    |            |   GPU_VM    |                 |
>     |        +-------------+    +-------------+   +-------------+   +-------------+            +-------------+                 |
>     |                                                                                                                          |
>     +--------------------------------------------------------------------------------------------------------------------------+
>                                                                                                                                    
>                                                    Figure 2
>
> The relevant reference user space rocm changes could be found at:
> https://github.com/AMD-ROCm-Internal/rocm-systems/pull/78
> https://github.com/AMD-ROCm-Internal/rocm-systems/pull/110
>
> Changes from V4:
> 1) rename process_id to context_id in struct kfd_process
> 2) remove primary flag in struct kfd_process
> 3) reject set_debug_trap ioctl request when
> the target kfd_process is non-primary
> 4) other than default 0, assign context_id 0xFFFF to the primary kfd process
>
> Most of the patches have been changed, so I removed
> their signed-off-by tag.
>
> Please help review
>
> Thanks!
>
> Zhu Lingshan (18):
>    amdkfd: enlarge the hashtable of kfd_process
>    amdkfd: mark the first kfd_process as the primary one
>    amdkfd: find_process_by_mm always return the primary context
>    amdkfd: Introduce kfd_create_process_sysfs as a separate function
>    amdkfd: destroy kfd secondary contexts through fd close
>    amdkfd: process svm ioctl only on the primary kfd process
>    amdkfd: process USERPTR allocation only on the primary kfd process
>    amdkfd: identify a secondary kfd process by its id
>    amdkfd: find kfd_process by filep->private_data in kfd_mmap
>    amdkfd: remove DIQ support
>    amdkfd: process pointer of a HIQ should be NULL
>    amdkfd: remove test_kq
>    amdkfd: introduce new helper kfd_lookup_process_by_id
>    amdkfd: record kfd context id into kfd process_info
>    amdkfd: record kfd context id in amdkfd_fence
>    amdkfd: fence handler evict and restore a kfd process by its context
>      id
>    amdkfd: process debug trap ioctl only on a primary context
>    amdkfd: introduce new ioctl AMDKFD_IOC_CREATE_PROCESS
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   8 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c  |  10 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |   8 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  79 +++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   7 +-
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |   6 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |  61 +----
>   .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |   4 -
>   .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |   4 -
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  19 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 239 +++++++++++++-----
>   .../amd/amdkfd/kfd_process_queue_manager.c    |  39 +--
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |   2 +-
>   include/uapi/linux/kfd_ioctl.h                |   8 +-
>   14 files changed, 294 insertions(+), 200 deletions(-)
>
