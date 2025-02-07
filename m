Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0C8C02196
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 10:17:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9845E10EA95;
	Fri,  7 Feb 2025 10:17:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wSjy8LEX";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9444810EA95
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 10:17:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mExi9QSUSjR6KKuzvI9j/nU9CDY4GdXoX8889vQI3FfI8x3OpDqUtKFO0fM6fL4aCdafuvYUMciruomTVNvU4Iv3UkkrQ21bLDXhu2KUbYPb5gpZ9Pvnkd6/Byi0Tg3lKymSOyucYmxztpQi038MDvfSrcvJVAfOsMshHAfAL71Pabtq8mPN1TY+Z2vCCZQ8AFBrCE2M4Oid3LBOYcs7X3qpp8KAXr8WkvRC9stnt00aRt+BqwhY1bZftriURydEr6eK7vatK2ce3KGc1XFoDs85UUgMYM1+LtH/ixxC3X2/lhVpXukyWkx99tvvBarGmuGptqpCEa9vDMEh9tpJBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8vURqdaWnHTLeqXpOqIzEW5roXDjMIZfKnR1bXXS5M=;
 b=YGybXvVXEtpRO0Kn1ARb2r040ZLEko2VV9KkpjMCh/lz9ZQVKKQdAHzwDw2YDOnAiyAR4oxXPN0CN4HkCGZmuePMx3qdmMstOSRLc/QIIirCt08+YoXlXkBB/UKKljZcP4hvV2KlnSH8PrzKLHe6Nv+e8HApzwRiKmt3ekxRpQsvI11G6aJk7mM+iAyzHPwaY/3uyrtwqeDnyLlUjCnev1yXDqaD9VvQ2+67hVYrPJG981+p7OPCOpw+12reVw15jUFuxtXAc5wqKYb3I81WMtHNTALJM9eQzUVD939I7zjk1a8k+6AhDV4EciCrcOmbFM03r6Ejr6hT/XInNHWZcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8vURqdaWnHTLeqXpOqIzEW5roXDjMIZfKnR1bXXS5M=;
 b=wSjy8LEXjYF6G6KFpJSZTzkcBdqBx1xnDBpPqMfm+6P6H9YiHSOv3WZCnae3ey6BjH6LqMrflghuj38/gaTpSvSWBVbSa9tsdyd/MSxzpaEA8XDuMMnti3V0Vi6CFs9RsGhbKyHVv5C7VauiKzfA2tQ9MZFMIwz6fu+PursJ8Qk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB9070.namprd12.prod.outlook.com (2603:10b6:8:bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Fri, 7 Feb
 2025 10:17:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 10:17:16 +0000
Message-ID: <328ee3fb-ff15-4a79-aedb-376c68df79a0@amd.com>
Date: Fri, 7 Feb 2025 11:17:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Unlocked unmap only clear page table leaves
To: Philip Yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, emily.deng@amd.com
References: <20250123203931.18867-1-Philip.Yang@amd.com>
 <af4ba8cf-b23e-497e-a5ae-2ae4f3aa24f9@amd.com>
 <2cff3ac0-9f56-aaf9-6c6f-59c69606efec@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <2cff3ac0-9f56-aaf9-6c6f-59c69606efec@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB9070:EE_
X-MS-Office365-Filtering-Correlation-Id: 30372ba1-27b5-4146-f0be-08dd476098a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nm9Ya0d3UUd3YzVuVnNJdUtObDljczlQaXMyTmxSblJvd1I0RmZheHlBbHFS?=
 =?utf-8?B?NlM0Uy9OaGkxRlhSbzUrNDNzVGxtUkN5Zml4NUVqbWxPL25QQlNIblRCNVVW?=
 =?utf-8?B?TWxaVzY1YkE0V0dRZVBrNmJSaGdvdmtBTDlqaHJxWU5LY205K0NHZHlTNHoz?=
 =?utf-8?B?TlVuamtCL2lEUkVXaEJid2laZ0hyd0N6cjhaSzlRZGl6L3h6Ly93NnptYTds?=
 =?utf-8?B?QVN5bVdEcDJjRDNFWWtQcmtEQnNnWkgwdUNYT1NwRHhKdHNKNWdITUZ0MG4v?=
 =?utf-8?B?UzlhZnM5ZGliNTZEMzlQWU5ZZmpkSTJwb1N2N0M0U3IrNWNBeWkwak9yTkd5?=
 =?utf-8?B?S2NFWmk3dWtocm5yd2NMQkNTMDBxYm5WREVaa1hYVWZyZGs4b0psOXh1aFhQ?=
 =?utf-8?B?RzEvMTZybzVXOGlmMHZMTW1QdHpHeFlTOU1ITFFrcWlMbWN0RVhvZGtBU05T?=
 =?utf-8?B?eUFsZU5XY2lvaCtRRFdGMFpzYkpFSDdyNURIaWpLbW9DQ0xmSzdYWFVXU2k1?=
 =?utf-8?B?bkFXZ0JVRU1kc1pYeTV1SnVyVXBoWDhSL09EWEp4SENOdHR4djMzMStTSHM0?=
 =?utf-8?B?N01FSXR2RGZUb1lSUDJvU0czblJlQ2RxUjdERS9PQkJlVHNLWlQzNm83b0ZD?=
 =?utf-8?B?RGdkSXVwVTlxemtscndpcmU2eTZjTlZva2hWVXJJTWpwbm1UaGJHVkVGVERo?=
 =?utf-8?B?a2I3bitLQWMxZXRQM2NocTY3Rk56WGUzbWhDYWRKZU5vcHltVGViRUIwZmNq?=
 =?utf-8?B?djQ0TEp2cmE2bGh5WHVXWnpWMVhxcTYyeG5Qb2dqOGZBbmJJYjZ6SHl6OUdr?=
 =?utf-8?B?MlBlbmhCOVB5YlJLTlZaWUhnb21FcmVOV3ZIakJtR3IyWVAzeFB6STkxQnhn?=
 =?utf-8?B?OWRUZHY0UTR0Tk1sSWxrVTJyS09uMUdraStQS1hBb254NnVTR2ZwekRQeG1K?=
 =?utf-8?B?TjB5M3ZTQ1g3ZGxWN0Nhd1lKRVhxbXJsNytKOThpVFVDckY2aE1iYzJiMk53?=
 =?utf-8?B?bFNNaXJYMUpQTGp0NXltY3RVbkI1K2JRWUVPVDNtcjAxOGR4NDc1bUJoRVNN?=
 =?utf-8?B?V1NZaU03ZHFXS05IZFF1NGlJK2ZWMDF3MXB2dHhrNEp0L0ludU1WeXEvUW9E?=
 =?utf-8?B?RUJXUU9uMmFSR1dUaWZlTU56a2czbU9tdmZIZndYbTFLb01BZ3FyaEdrclZW?=
 =?utf-8?B?YmhyU0RQRUhzVmE3SmFoL3ZOd0JRSldhc2xKb1kxT2RreTE4RUVSSEMrRzhx?=
 =?utf-8?B?T0lPTHNkRUxSRTR3N2l4QytscFNPMnRWaFdxNTdEcEthNzZUY3VZQlBMZzRt?=
 =?utf-8?B?RHVJL00vUURnNDJCMHFUeTk4Vm1TWjNFYUdCYmw2NG9FK29QYy9makRMVGkr?=
 =?utf-8?B?bkp3ZVBHcHdFQnVxaVRCcnk2bG9aTkFsWWJ0R1F6QkRrTi94b3VjZU1KQjB2?=
 =?utf-8?B?Q0pTczdEaW5UMWF3S0U1VFllQjMwUkJCZmdOUUZjM3hlTktaVVlxNDBOWkRr?=
 =?utf-8?B?QU81dFJRb3N1N3ZSQWY1bUdpdTBRcWhoVzBnR1dtcjZmK0FUby9KYlM5OTRw?=
 =?utf-8?B?dnBrNWd2alNZc1g2YzZhRE16cis1clJFeXZXTkMzTkdoRzlnWjlHQmRRY2Er?=
 =?utf-8?B?MVJsZGdoTkl3dWJJY2l6QkNRSjQyOWh3eTdEL3FDRmo3eGhDQlIxS25zak90?=
 =?utf-8?B?cWt4T0FybkIzcUtBZnJEVDVkZjJ0UFQ0b3ErM1V5Ly9qd01TTTNaZDNVeVhr?=
 =?utf-8?B?K2owQzc3enhVTk5Ec2RpdEVmbng3a1NpOGllSXVwZWFOR1VLdlc5OEVLaURa?=
 =?utf-8?B?eHRqTW5JWDQ0Z1k1R05ia3IxWjlKYXZZUzFINUFxdk1iUkVxdGZVYnlldDg4?=
 =?utf-8?Q?/BrHHPusLGqYq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blNKalRWUk1VMzJZNDZYZkJ1d1JZaC84Ty9zY3d0NkJkWjlnQ0c1TDVwSStN?=
 =?utf-8?B?NlJJdDFLYkxCcTFZSkFSZEVoSmc4SHVMYWFORExENG1IVWRzSjZ3Y05MakVH?=
 =?utf-8?B?WkNzaG1pdVBEb3R1Nm92Yit4cmprczhDMWFsOG01bFhvWVBOK2hWWDJIWHIw?=
 =?utf-8?B?THYxUEhMTUYybGhSek5JajdKTk9acXhYZ1R2RUdXQlNTc1B3K0d3OFRTaFdj?=
 =?utf-8?B?MldKclZRY05JamRUT0doQytzMFY3K0pHSlZUbkNQdjZHZWR5eE9zd1k2cCtm?=
 =?utf-8?B?R1pKZForeDljSGRKVzFlV1VVc0JMUXA4ODNpd1NZS0NNL0I5OGVDU3llQzNH?=
 =?utf-8?B?NmdRK3dWVkNVS3Q1WGxncE1ST1J0SkFLVHRWZ0dnWVRpOEt5Z2RhcytyYmNV?=
 =?utf-8?B?VU1SckFIem05WDNXckRIS3VPdWZpL0x6bnJQa1ZjVlBTcDQwYkF3RFAvZzY3?=
 =?utf-8?B?ci9yc1JsNCtPbnpqb3BueWQwYVhxNzl1TGsrZGVFU3NRU1ZEelk5STE5UUhk?=
 =?utf-8?B?ejZDa2syWjJuelJ4Ynp5SS9sZ1dQMlFCZFRaWG02Wit6OUsyYWU0RWZZT3o1?=
 =?utf-8?B?eEpvMTJxNGlXQ1hza3ZoL3cwUW1EWWdxMjZKYjAyTHhsdGY5M1JzTHIxRUxs?=
 =?utf-8?B?OUtqQWdXMEF4NjFVSjBJcitXc2xFMysxLzJtS05wWHlvbEZOSERuOTFoT21l?=
 =?utf-8?B?a0FHaGxldDJLT3c3QUp2aDVhSjZ2WnMrbisrK3NPeGRpb0d6RE5OT1E2c29D?=
 =?utf-8?B?cHhucW9OTjJYNHc0T1JxQWV6TjZ2WFBxdTJYa3A4ckF5VG5JTUVzSndTRE9r?=
 =?utf-8?B?Z0ZnWDFWN2NXSnJtTkREL2FZdkF0azFTRk1pUUpJdk1ySWJYUHZUTGl6a2U1?=
 =?utf-8?B?QTlUOXoxTnFHenQraXM5dnBPVVBFS3prd3hMcEZPcW8rbFljVk1zUHA5ajR3?=
 =?utf-8?B?dFEyQndTZ3hFbHUrZE1WUzREVnJOeTNhVmw2TFpKRUZ1TmhMdGJFYmpiK3VH?=
 =?utf-8?B?MTJvTXI4WE01SUM1cWVTQkJZTGo0YlNMcjk4WWRlc1dCYVhKNTdRQjZMOUFz?=
 =?utf-8?B?N04rbnphNnlLUVZuOGkwbFJVN29yU04vM0psUDNXdUphSUJqY1Z0TlNJWXlS?=
 =?utf-8?B?ZC9HdGwrOWkyeXhndnBTM1N6SW9YT2Q5T2htSGhpNndHdjNVVzlMNEh2MjhG?=
 =?utf-8?B?N1ViRFhaQnllSEVWNmZVMVY0d2I0MlZaZHhqT25DeXdpQWhFZEFEN2kvRUpt?=
 =?utf-8?B?L3B3YTA2bXVaMFkvWDJDQ21NQVVCMm9vU0pBVFVmcnl3UE5tUHdFTHI3Y2RV?=
 =?utf-8?B?MmZzdHZOSTJ1N0FaTHhMdFVlRlA3Z25CUFBtVHVGeUNqeGExelp6aFBvZE5J?=
 =?utf-8?B?QmkxV25TQ2NLVUFuSG5nbVNUMzk0cnRMRzQ0c1pYbHdkdEZMOUQwWmtZU1FT?=
 =?utf-8?B?OTVqb3U2Y2xtbHNwTWNrNjI5M1V5NGVEdEE4VnlqY21tTVZhRVBTM0pUNmt6?=
 =?utf-8?B?bjdTUktjOXNqT1RjRzRoR0d3dTFRVGhJVm9udktWWmg1aWc5eGRxa01FOWEz?=
 =?utf-8?B?RE1BLzI5bmt5eW1YdUVIMVhZNXhTQ20zWEQvNmUySU51SG5xTXpFOEd6YzB6?=
 =?utf-8?B?dk1JN1Nlb3Rod2pHMUlZTzlsVzlrN2RGVGdEeUt5ZUpXWityek9iUDVZRWdB?=
 =?utf-8?B?US9tOHgyRFN0VWc5dmdxcEZTWFpqMmpreUZFbmxYbW1SakJHY1FEY000VE44?=
 =?utf-8?B?S2o5TDNQd3g5V0tMWVg2RnlZcGNhcDByQ2xxdXVtbVFDTmRsUis1eXUwRm1s?=
 =?utf-8?B?YnFXWGQyQ2g5bVJWRVc4a1NCaXZ3RW83VWhXMWNuNDhVb25TcGpUTGwvcWF5?=
 =?utf-8?B?ZlZveGFQWk5HREtPTlE3dXI0SHBRbWh0ZWtSa3JsSVdkb2drTjB4VXFNMENM?=
 =?utf-8?B?OHdnSnBac2JFZE5ESGpkeW12VVJnRWVrb3NVb3VZejI1b2IreXBVQ2xVWlV6?=
 =?utf-8?B?dUhCeDEwWkw3clBkdGxmMTJnMTFWZklQWUtFMDZOcjFMUE5pTC82TEdmLytm?=
 =?utf-8?B?NkF6QTcyTmVRTFluSlFsbDY4eGo4TWRodGVQblRmTmF2QWFwOXdpdE5QYzhz?=
 =?utf-8?Q?AAkJEVWZMFveDyCkaLE1DDu2u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30372ba1-27b5-4146-f0be-08dd476098a4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 10:17:16.1016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JL8/IdqF40HNTGuAmHT5gOXv8Z9WYK5ghGwXFKPDsebgpiWM831IxjO0kRUrKv3K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9070
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

Am 30.01.25 um 17:19 schrieb Philip Yang:
> On 2025-01-29 11:40, Christian König wrote:
>> Am 23.01.25 um 21:39 schrieb Philip Yang:
>>> SVM migration unmap pages from GPU and then update mapping to GPU to
>>> recover page fault. Currently unmap clears the PDE entry for range
>>> length >= huge page and may free PTB bo. Then update mapping should
>>> alloc new PT bo, but there is race bug that the freed entry bo maybe
>>> still on the pt_free list, reused when updating mapping and then freed,
>>> leave invalid PDE entry and cause GPU page fault.
>>>
>>> By setting the update fragment size to 2MB or 1GB, update will clear
>>> only one PDE entry or clear PTB, to avoid unmap to free PTE bo. This
>>> fixes the race bug and also improve the unmap and map to GPU
>>> performance. Update mapping to huge page will still free the PTB bo.
>>>
>>> With this change, the vm->pt_freed list and work is not needed. Add
>>> WARN_ON(unlocked) in amdgpu_vm_pt_add_list to catch if unmap to free 
>>> the
>>> PTB.
>>>
>>> v2: Limit update fragment size, not hack entry_end (Christian)
>>>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 --
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  4 --
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 54 
>>> +++++++++--------------
>>>   3 files changed, 21 insertions(+), 41 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index c9c48b782ec1..48b2c0b3b315 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -2440,8 +2440,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, 
>>> struct amdgpu_vm *vm,
>>>       spin_lock_init(&vm->status_lock);
>>>       INIT_LIST_HEAD(&vm->freed);
>>>       INIT_LIST_HEAD(&vm->done);
>>> -    INIT_LIST_HEAD(&vm->pt_freed);
>>> -    INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
>>>       INIT_KFIFO(vm->faults);
>>>         r = amdgpu_vm_init_entities(adev, vm);
>>> @@ -2613,8 +2611,6 @@ void amdgpu_vm_fini(struct amdgpu_device 
>>> *adev, struct amdgpu_vm *vm)
>>>         amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
>>>   -    flush_work(&vm->pt_free_work);
>>> -
>>>       root = amdgpu_bo_ref(vm->root.bo);
>>>       amdgpu_bo_reserve(root, true);
>>>       amdgpu_vm_put_task_info(vm->task_info);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index 5d119ac26c4f..160889e5e64d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -369,10 +369,6 @@ struct amdgpu_vm {
>>>       /* BOs which are invalidated, has been updated in the PTs */
>>>       struct list_head        done;
>>>   -    /* PT BOs scheduled to free and fill with zero if vm_resv is 
>>> not hold */
>>> -    struct list_head    pt_freed;
>>> -    struct work_struct    pt_free_work;
>>> -
>>>       /* contains the page directory */
>>>       struct amdgpu_vm_bo_base     root;
>>>       struct dma_fence    *last_update;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> index f78a0434a48f..063d0e0a9f29 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> @@ -546,27 +546,6 @@ static void amdgpu_vm_pt_free(struct 
>>> amdgpu_vm_bo_base *entry)
>>>       amdgpu_bo_unref(&entry->bo);
>>>   }
>>>   -void amdgpu_vm_pt_free_work(struct work_struct *work)
>>> -{
>>> -    struct amdgpu_vm_bo_base *entry, *next;
>>> -    struct amdgpu_vm *vm;
>>> -    LIST_HEAD(pt_freed);
>>> -
>>> -    vm = container_of(work, struct amdgpu_vm, pt_free_work);
>>> -
>>> -    spin_lock(&vm->status_lock);
>>> -    list_splice_init(&vm->pt_freed, &pt_freed);
>>> -    spin_unlock(&vm->status_lock);
>>> -
>>> -    /* flush_work in amdgpu_vm_fini ensure vm->root.bo is valid. */
>>> -    amdgpu_bo_reserve(vm->root.bo, true);
>>> -
>>> -    list_for_each_entry_safe(entry, next, &pt_freed, vm_status)
>>> -        amdgpu_vm_pt_free(entry);
>>> -
>>> -    amdgpu_bo_unreserve(vm->root.bo);
>>> -}
>>> -
>>>   /**
>>>    * amdgpu_vm_pt_free_list - free PD/PT levels
>>>    *
>>> @@ -579,20 +558,9 @@ void amdgpu_vm_pt_free_list(struct 
>>> amdgpu_device *adev,
>>>                   struct amdgpu_vm_update_params *params)
>>>   {
>>>       struct amdgpu_vm_bo_base *entry, *next;
>>> -    struct amdgpu_vm *vm = params->vm;
>>> -    bool unlocked = params->unlocked;
>>>         if (list_empty(&params->tlb_flush_waitlist))
>>>           return;
>>> -
>>> -    if (unlocked) {
>>> -        spin_lock(&vm->status_lock);
>>> -        list_splice_init(&params->tlb_flush_waitlist, &vm->pt_freed);
>>> -        spin_unlock(&vm->status_lock);
>>> -        schedule_work(&vm->pt_free_work);
>>> -        return;
>>> -    }
>>> -
>>>       list_for_each_entry_safe(entry, next, 
>>> &params->tlb_flush_waitlist, vm_status)
>>>           amdgpu_vm_pt_free(entry);
>>>   }
>>> @@ -611,6 +579,11 @@ static void amdgpu_vm_pt_add_list(struct 
>>> amdgpu_vm_update_params *params,
>>>       struct amdgpu_vm_pt_cursor seek;
>>>       struct amdgpu_vm_bo_base *entry;
>>>   +    /*
>>> +     * unlocked unmap only clear page table leaves, warning to free 
>>> the page table entry.
>>> +     */
>>> +    WARN_ON(params->unlocked);
>>> +
>>>       spin_lock(&params->vm->status_lock);
>>>       for_each_amdgpu_vm_pt_dfs_safe(params->adev, params->vm, 
>>> cursor, seek, entry) {
>>>           if (entry && entry->bo)
>>> @@ -794,6 +767,21 @@ static void amdgpu_vm_pte_fragment(struct 
>>> amdgpu_vm_update_params *params,
>>>         /* This intentionally wraps around if no bit is set */
>>>       *frag = min_t(unsigned int, ffs(start) - 1, fls64(end - start) 
>>> - 1);
>>> +
>>> +    /*
>>> +     * MMU notifier callback unlocked unmap only clear PDE or PTE 
>>> leaves by setting fragment
>>> +     * size to 2MB, 1GB, 512GB. If leave is PDE entry, only clear 
>>> one entry, next fragment entry
>>> +     * will search again for PDE or PTE leaves.
>>> +     */
>>> +    if (params->unlocked) {
>>> +        if (*frag > 9 && *frag < 18)
>>> +            *frag = 9;
>>> +        else if (*frag > 18 && *frag < 27)
>>> +            *frag = 18;
>>> +        else if (*frag > 27)
>>> +            *frag = 27;
>>> +    }
>>> +
>>
>> That here looks unnecessary, the higher level handling is able to 
>> pick the right PD/PT level based on the fragment anyway.
>
> Thanks for the review, it is very hard to image this case, update PDE0 
> entries, then free PTB bos, as this works fine for locked mapping.
>

Yeah, I also need up to an hour to swap that logic back into my head 
every time I need to take a look at it. Understanding the VM stuff in 
both HW and SW is really not easy.

> For unlocked unmapping,  after updating multiple PDE0 entries, it is 
> incorrect to free PTB bo if there is non-huge page mapping,
>
>
> For example, below is debug log to unmap d4000 to d4806, address 
> d4000, d4200 huge page mapping, d4400 not huge page mapping.
>
> If using fragment 11, it trigger the bug. No issue if we limit the 
> fragment to 9
>

Ah! Ok, I see what you try to solve here.

In that case we should probably indeed use a separate function. Since 
using the level to determine where to update stuff is then fundamentally 
wrong.

In other words even if your round down the fragment size to a multiple 
of 9 you can still run into issues when the range which is unmapped is 
larger than 1GiB.

E.g. you then have frag=18, but would eventually need frag=9 to not 
start freeing the 2MiB page tables.

Regards,
Christian.


>
> [  192.084456] amdgpu: 4 cursor pfn 0x7f87d4000 level 3 shift 0 
> frag_start 0x7f87d4000 frag_end 0x7f87d4800 frag 11
>
> move cursor up to walk parent node, as this is huge page mapping, no 
> PTB bo
>
> [  192.084463] amdgpu: 5 cursor pfn 0x7f87d4000 level 2 shift 9 
> frag_start 0x7f87d4000 frag_end 0x7f87d4800 frag 11
>
> clean mapping on PDE0, d4000, d4200, d4400, d4600
>
> [  192.084480] amdgpu: 7 cursor pfn 0x7f87d4000 level 2 shift 9 
> frag_start 0x7f87d4800 frag_end 0x7f87d4804 frag 2
>
> Then if (amdgpu_vm_pt_descendant(adev, &cursor)) is true,
>
> [  192.084487] amdgpu: 8 cursor pfn 0x7f87d4000 level 3 shift 9 
> frag_start 0x7f87d4800 frag_end 0x7f87d4804 frag 2
>
> This is fine, no PTB bo
>
> [  192.084494] amdgpu: 9 cursor pfn 0x7f87d4200 level 3 shift 9 
> frag_start 0x7f87d4800 frag_end 0x7f87d4804 frag 2
>
> This is fine, no PTB bo
>
> [  192.084501] amdgpu: 9 cursor pfn 0x7f87d4400 level 3 shift 9 
> frag_start 0x7f87d4800 frag_end 0x7f87d4804 frag 2
>
> PTB bo found, trigger the WARNING in this patch, to free PTB bo.
>
>
> [  192.084525] ------------[ cut here ]------------
> [  192.084531] WARNING: CPU: 9 PID: 3249 at 
> drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c:585 
> amdgpu_vm_ptes_update+0xa2c/0xbd0 [amdgpu]
> [  192.084854] Modules linked in: nf_tables nfnetlink ast 
> drm_shmem_helper k10temp msr fuse ip_tables x_tables amdgpu amdxcp 
> drm_client_lib drm_ttm_helper ttm drm_exec gpu_sched 
> drm_suballoc_helper video wmi cec drm_buddy drm_display_helper 
> drm_kms_helper drm drm_panel_orientation_quirks i2c_piix4
> [  192.084987] CPU: 9 UID: 1000 PID: 3249 Comm: kfdtest Tainted: 
> G        W          6.12.0-kfd-yangp #146
> [  192.084997] Tainted: [W]=WARN
> [  192.085004] Hardware name: GIGABYTE MZ01-CE0-00/MZ01-CE0-00, BIOS 
> F12 08/05/2019
> [  192.085011] RIP: 0010:amdgpu_vm_ptes_update+0xa2c/0xbd0 [amdgpu]
> [  192.085316] Code: 24 4c 8b 54 24 78 4d 89 f8 48 c7 c7 b0 83 0a c1 
> 4c 8b 4c 24 50 50 8b 4c 24 10 e8 8f bc b9 d2 48 8b 74 24 68 5a e9 70 
> fe ff ff <0f> 0b e9 92 fe ff ff 48 bd 00 00 00 00 01 00 00 00 ba ff ff 
> ff ff
> [  192.085325] RSP: 0018:ffffbed102bf78b8 EFLAGS: 00010202
> [  192.085336] RAX: ffff9f04b654a1f8 RBX: 0000000000000009 RCX: 
> 0000000000000000
> [  192.085344] RDX: 0000000000000002 RSI: 00000007f87d4400 RDI: 
> ffff9f0af6f9cac8
> [  192.085351] RBP: 00000007f87d4806 R08: 0000000000000000 R09: 
> c0000000ff7fffff
> [  192.085357] R10: 0000000000000001 R11: ffffbed102bf76e0 R12: 
> ffff9f046b100000
> [  192.085364] R13: 0000000000bf4000 R14: ffffbed102bf79e0 R15: 
> 00000007f87d4800
> [  192.085371] FS:  00007f87d5a515c0(0000) GS:ffff9f0af6f80000(0000) 
> knlGS:0000000000000000
> [  192.085379] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  192.085386] CR2: 000055a190964b78 CR3: 0000000163fca000 CR4: 
> 00000000003506f0
> [  192.085393] Call Trace:
> [  192.085400]  <TASK>
> [  192.085408]  ? __warn+0x90/0x190
> [  192.085422]  ? amdgpu_vm_ptes_update+0xa2c/0xbd0 [amdgpu]
> [  192.085832]  ? report_bug+0xfc/0x1e0
> [  192.085849]  ? handle_bug+0x55/0x90
> [  192.085860]  ? exc_invalid_op+0x17/0x70
> [  192.085871]  ? asm_exc_invalid_op+0x1a/0x20
> [  192.085892]  ? amdgpu_vm_ptes_update+0xa2c/0xbd0 [amdgpu]
> [  192.086199]  ? srso_return_thunk+0x5/0x5f
> [  192.086216]  amdgpu_vm_update_range+0x242/0x850 [amdgpu]
> [  192.086537]  svm_range_unmap_from_gpus+0x117/0x300 [amdgpu]
> [  192.086906]  svm_range_cpu_invalidate_pagetables+0x426/0x7a0 [amdgpu]
> [  192.087259]  ? lock_release+0xc8/0x290
> [  192.087276] __mmu_notifier_invalidate_range_start+0x233/0x2a0
> [  192.087292]  migrate_vma_setup+0x1a3/0x250
> [  192.087307]  svm_migrate_ram_to_vram+0x260/0x710 [amdgpu]
>
> Regards,
>
> Philip
>
>>
>> Apart from that the patch looks good to me.
>>
>> Regards,
>> Christian.
>>
>>>       if (*frag >= max_frag) {
>>>           *frag = max_frag;
>>>           *frag_end = end & ~((1ULL << max_frag) - 1);
>>> @@ -931,7 +919,7 @@ int amdgpu_vm_ptes_update(struct 
>>> amdgpu_vm_update_params *params,
>>>                   /* figure out the next fragment */
>>>                   amdgpu_vm_pte_fragment(params, frag_start, end,
>>>                                  flags, &frag, &frag_end);
>>> -                if (frag < shift)
>>> +                if (frag < shift || (params->unlocked && shift))
>>>                       break;
>>>               }
>>>           } while (frag_start < entry_end);
>>

