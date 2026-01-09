Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89217D1A62D
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 14:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1626D10E8DA;
	Fri,  9 Jan 2026 14:27:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v9A4RzP1";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010039.outbound.protection.outlook.com [52.101.46.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7083B10E8DA
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 14:27:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7vwMndBaZxqp8Ng2tmr8qaiWJi2WjKJBn2gj99wJJsOMIkaLNs7t+iaymoz6VIAwA5oue8kxsBkdXSKslupUovtrNjiIIkYuvxlc42PnxsgYtGEav1cDzMhW0ERUatCrId6IgJfea0SsZddubE/JSjFu1yN0kiy8ckwpePOhDKuwcB67D5So1O1vjQgbPi4V/ctzMNmXsnPkh/9uOL+5G4EZdfdAlSn/CsQv/ZKHTa0GHFxlhRmv32MdDGeqnKdMVnWszR8DVTBvvyZzD2s2AgrTNWUDVD0eLe94HMNe/3FB41XmrpWHJENKckpPDjKL17L18xINImXTFRL7c0yYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhLgdtHjcStwPzUUpmuUK2nn8+J5E166LFA3qktHEgA=;
 b=k41t58rBbqb3SoyQdUBfx1H4302ATn+5aBn2FCjCNWz8dpy1w79OtQsIUn4ywEPYkQUvqN/F+/t9JaPi6DeeNk8vA/J3PSC0xCFJ8Vv+eGHRR9h11kZpRGYRHSPli0FdRS9K8MZEIVFLNTNhUZ8HMydK1zlRih9ry6aUxL3u3tga9frCcMECDG249jKl0X7B5nBSIt0vHLG+6Ab1yEoPznitWbwtJsTH5P9Xi4FSgtRAy6pl2mOYDP5DjkoJ3xty5VlcubIlJnWNDtffVVnF69GCBzJYW/6OHgunwGEjCXga7DGxGcG3rSxdKNp2Ql+BsoNJ9HsI7IdIzya96qAOhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhLgdtHjcStwPzUUpmuUK2nn8+J5E166LFA3qktHEgA=;
 b=v9A4RzP1uusoS2VePzN4n2Lwg3B7QDpvDE1DMEjmE5GUcDSywHtPsiEZF66u4ntENmkTwZOxXK9QnMw8hi+zBBf8oxQsId40YU1IaLH20T8aKE5YBTiEhEG0gAGAsNEntI7P4ufk7769DRmCNjzcdQ2Kv/zgG/NiAcrsAqeZ3bc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6138.namprd12.prod.outlook.com (2603:10b6:208:3ea::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 14:27:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 14:27:24 +0000
Message-ID: <abd57d1d-9408-4249-ab45-1898611ada7a@amd.com>
Date: Fri, 9 Jan 2026 15:27:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/12] drm/amdgpu: Remove output parameter in bo list
 handling
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20260109133314.88548-1-tvrtko.ursulin@igalia.com>
 <20260109133314.88548-12-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260109133314.88548-12-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR02CA0056.namprd02.prod.outlook.com
 (2603:10b6:408:e5::31) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: bd9b8347-c670-49ea-d475-08de4f8b34af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUlUZHRCQktSRDdqcy8xeTdjN1RhaENETFlWQkhmNXhqWFNoakFDbkFxd295?=
 =?utf-8?B?bnVtK0xNRVBqdEVHVGFtQnUvTmtWTHZYWXE2SXA0S2JTSzQ3dWl4K3ZzT3ZR?=
 =?utf-8?B?M1o0VTMwRUcxaEpBVWwvR205TXk0enN4Zzlib2tOUVkzSE5Mc05QdkZKd1Bi?=
 =?utf-8?B?RkFRL3hXbTVEczJuWldaSmFoNE03UjJkMkVGajhXTzV1V1h4TDFMK3QxR29H?=
 =?utf-8?B?aU1obTJEMDQ4c2pZWTlvWWhJVmc2VDBYRmRZZTJPTnFxSmZ2SkNreVhNTVNX?=
 =?utf-8?B?NEhCck44SWJ5RjROUGJqSmFHL0x1WjZNMFdwWlRuNTEvbnZDbmZZR3hBR1lE?=
 =?utf-8?B?U1d0anZEMUsvZ3FxOHVNa3lWNGVLYWI5eUxUbmN5aDdZZi9PNTgxMUEzNVo3?=
 =?utf-8?B?alIrbFlGVndJeXkybDhNb0kva2xmMG43cFJKSE41VjRGcEVUNGwzbk9DeFJ1?=
 =?utf-8?B?STZDeS9hWDU3M1FmWWZoc1cxcm5TR3hEbjdZbjU0K01MNU1SUWNiMG0zNkdH?=
 =?utf-8?B?Qy9sdjVpQm85NUp0YTdvM0hmd3d6NjVXK0NZZ0NLWkZKc1dleEFnQWRVdFBR?=
 =?utf-8?B?YUFrck5jUWYvdGtPMUI2Y0h1N0lCT0RadFh0T09YMG02UHJzNkpKMjJnWEVp?=
 =?utf-8?B?Z3lLV2h1TnBFeXRJUENFZEcwZlNQZFM3V2JyVmd4bWVmcmNDVjZ5YkJtdXA5?=
 =?utf-8?B?empIQXVvQzVZZFZCRU56a204MXE1eDhtUytweDRaTFFwNmFtcGptZUtWL2pp?=
 =?utf-8?B?KzVTVW5kcGdaaTEydGVsR3NLRXIyQkJUWHdSeVBta0VMUjYwWEVQWkJ5ZW1j?=
 =?utf-8?B?REFuUFg4TndCd29NY096bFpWLzNoMFBNVDh3WXBxWWVDZ3hFaEU0UE5ZRnFF?=
 =?utf-8?B?VzJ4c0NVNzh2RENuYnIzeFU2S2Z3SThuQjVBZzZUTnllTWVURy9CanBsdm9y?=
 =?utf-8?B?REF2S0xwNGFoS0dpQXo2L08xTlNMdERsaVRLbi82anh3T1ZKcjZJWkczRXV6?=
 =?utf-8?B?bUozMWVRZkNLdE1Dc0Q2azFSWHRjUklsUXl6Y01VaTk3bTY5T0NYcmpCTEgr?=
 =?utf-8?B?U29VM1ZPQk9xSE5EZUp6ZDA2WVpjaE5nQVdIUW9LTFNwZFVDRTZuVUQzNzAr?=
 =?utf-8?B?TnpEdm1xVXM4WnNwZkh3aW02dnFUWU1LdjltUFRRd2paNmhXbFBycVhzc3JC?=
 =?utf-8?B?SFhITXpwMnRBekhTZVozY3pyMXJyUWNIQlYvMnVQOHdwRHNzRWR0U3FKRi9X?=
 =?utf-8?B?TWQ5ak1MbmVXM2FINkdta0dWVy9zNGkzY29UTXpEd3FwaGxzODNFdUxGU20v?=
 =?utf-8?B?Q2s3UWxCb0Vmc3FTNzIwK0pNRWxBQnRHTzdwSnRNZzlGMkV5cHQ3Y0xuVEJT?=
 =?utf-8?B?cEo5aGJyZXFRZXU2Y2xEcVl4TjA3WjdSRXlXQVc3dGJZdjNZT21VdWNWdzZ1?=
 =?utf-8?B?eTgzVGV3MUF3VW9yUlJCZG90VnBaSG0ySkVkdFg4czd2ZzRhK21malFDeWZ1?=
 =?utf-8?B?RmdUbzBYemlyR3VmK0dKYVdibVAzTUxXVVp5U3lHcDhWMjIxbktLb0o0ek9V?=
 =?utf-8?B?VHJ4dnZ3MWgwNHFSOEExTjJqQTBvUDFZR2xKd3hCYWw5ck9PR2E5U1hoMWhS?=
 =?utf-8?B?UDFtY3BiNlRzRVpRRlA0NE96RnRSbldYYW56SW1yV2ZMS3FRR2E1ZVE2NW1H?=
 =?utf-8?B?aFArVkczSW1QSk45VnhveW9OclFmOUgrRHczZXFuaTRxZGY2bUtNQTMxQXYx?=
 =?utf-8?B?UTdtZmxpTk90Q3dYR0VLMlJESlRUZnRFYU9NejFsUkVNSnB4MGVmbEQ4RjRm?=
 =?utf-8?B?a2FuQzc4cncxNUF0di9LRmIvSGE1K3ZPZVZMQkFwRjlQMDNLT1BRajQ3MXMw?=
 =?utf-8?B?aFFsTGphWUtpeExqa2RzWWNQVGZXc2l4QklCaml4M3hvaXM1N1N6eUo2NXhs?=
 =?utf-8?Q?INqCRaeJV1f0eXev9/o8zhLGn1K4FplN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDNqVzE5TUFmNTRBR2FZdHp0VU1BTFVNUmRmY0VTWVhVRGR5YjFjRnEraEJ3?=
 =?utf-8?B?eVlOR05EYkFKb0IyNHE5SnFoQmRXQmZ6T0ZBMmtiZW1MK3pwVFNBTkQzL2dK?=
 =?utf-8?B?b0xRWkNQcEJnTGNFaGlOY1UxUllNRW8wV1BJV2dpdFpPRHh2d2Q1V3QxME9L?=
 =?utf-8?B?WmYzVDZPN0pSWEQ0RFdIMXN1NDhjWjlRNFI4SCs2SDY4bEZNNDR2TGNmMWgv?=
 =?utf-8?B?eUZ6bHpTTWtiZ2Z3WWQ2QVlhaUV2cFZkK3U0czVuWStxb3dsdDRRcDRpT1hu?=
 =?utf-8?B?VUhUUGd1amZJQUlLRG4xa3BxSjR6NFpvVTJmQ3Jpb1Z5NUJOWkJnSnBYRTQ3?=
 =?utf-8?B?Ry8xdGdOQ1JYTUpGZmhFbDQ3cklWR0pSY0JhZU90ZE9CUWd6RmIwTWJVQndB?=
 =?utf-8?B?Y28yMnNDSDFlRm5haTdmTEJIZ0NZNW5nVXNBUkJkSk5LNktzVUV2QU43WFZr?=
 =?utf-8?B?TitwMFZIWmFSKzRTU05RVk00UmJmcmNLVittQTIxVjlyS24zbHJUN2dqamt6?=
 =?utf-8?B?TUZQU2VIZmlZZWI0ZnNPVTB6ZEFaM24xdDZoQ2pCNVRtSTMvSWZCWlpzOGZM?=
 =?utf-8?B?QTh6UkxPZlRsQlhkVi9pRXJzWVA2WkVZSWdsOWR1eFVvdDd0UGJJc2cvdUs3?=
 =?utf-8?B?TmRYTmZxR0xEVGdjRVFkb3hBekszbGczc0tENnRmRGJHMTZETnFYbm1IRzZp?=
 =?utf-8?B?dHNRcjNtV3grV1J1R1F4NGEwT0o0RU1HeHBHcHVnZ3FCbjNKRWhwV2R4Zm1I?=
 =?utf-8?B?WFRVcEllSHhlSW9wTW4zTGUwajllb3lkak5xVWRZeUV4RVdvZzZQM203ejlX?=
 =?utf-8?B?Q0NiMG9rL2M1Y0VFMTJFSVcwcndCa01uQVlHUUlLa1JJS3lBb0hnZWpwcVNp?=
 =?utf-8?B?L2Jka1RUamVBM3cwVUlYaktrRXMwbXk4SjhKaFRJWFFZMXlyejVDNDRkSjNq?=
 =?utf-8?B?V0lpUGJvNWNia0R4aVEyOVUrQ3RGS3BucjFlMHQzL09hbzJKMVRwRG1XZlp3?=
 =?utf-8?B?QUhkcmx3K0Y1Z2FsK2xqTVZybit5N1hYNGNKSm9pUlVlWFZJV0U1VEU0ZElh?=
 =?utf-8?B?N2lXL0FISWtJejM5YWRGNVVaWUdqenNTUk9xYy9ndTVQSWtJcWtyN0JPWWdk?=
 =?utf-8?B?NUdVTUxCTi9rUXI0VURabUF5em9YVklXM0NWV3ZldFpBRjZjTlFpbmR5WDgy?=
 =?utf-8?B?aU9NdmdWaVNuOGY0Y3BjeW9qZmRQOG45YktuUzBQbzBKeDMwcXRQV215K0xu?=
 =?utf-8?B?dTYrRGZsSFB2UjZ6QW93ekNWbnl4TWlUbTFuZGZZNmZOY2hUMmZxeCticXZj?=
 =?utf-8?B?d21wcW5FQlhpS2pNODlxeWtqV2xGd3FPbk9YZVVHK1dydzluS0JGcVlXTnhI?=
 =?utf-8?B?TDUvdWxld0RtR2ZiemZTQXJxWk1vTGpCYU9nMW5mNm1OdHNFNVl4T1B5UEl0?=
 =?utf-8?B?Q1liYTdDa0FOazBMc1c4RHNBOVlaRkNRN0UvMEJPZFZ0R1QyOWduMFRkdzh1?=
 =?utf-8?B?QWFXalJ3WEIwR3AxZGtseThicXdPTmVJVWEwNDAyMVBUOU5BckZVZ0tTTUg1?=
 =?utf-8?B?d2I3aFVMejUyMnlLaGVuZmtDclVBdEgxMkNhdkpFalEvb2xLNldkdHoxZTBn?=
 =?utf-8?B?NTU1SVdPazJlM3d4MVMwT2tZZ0pyd3FQaGx6SlpjS2UybmZNTC82cWJMQTM4?=
 =?utf-8?B?eENOMmZxMzFqSWJPWUY0ZjRWTXpnODFMb2JKYi91UG5yNXA0YWh3TndBcis4?=
 =?utf-8?B?MmxqZ1J4OG5nZ1YvZkQwbTZPdGR4UFRlUXp0YjUzcTgvRllVVmNzTGxBeHNk?=
 =?utf-8?B?NG4xVERPNi9kQTR2eTZwQXp6VEFGSjRxeTN2aGFobUgreGxmMmlnaFM1STdX?=
 =?utf-8?B?eU8yWTRQa0NJaVplN0hsTVpkQVJVNkd0WDNaSDRNK2RVcmM2bTh3amtYWXpP?=
 =?utf-8?B?bkxnakxuR2lnc3FMZFFXV1NjQ29pcVFpVWR2ZW4xR2lZUGdyZjR3aVBqWThF?=
 =?utf-8?B?RVNkRVhuNC9aTGZMVVhwZUpZRjc2UnFhRTByUy9jMWlIMk5vSWQwanFTY3RW?=
 =?utf-8?B?bTNVbGp1R1ZwR09DLy96MGRUaXBlT1JFbldIWnAwL1ZqL0hmSkNNYmdGUkl1?=
 =?utf-8?B?dndTU0gzdk9CcDZpcjJuK05WTHRPR2lFa1NKNS9JV3NwdmNDN0lxeDNiN29H?=
 =?utf-8?B?TUhaZEkvMXRvZ3NJU09EcUpNa2dZWnIwTGJtV2pGZW12emRrRktvaG44YTkv?=
 =?utf-8?B?RVhZM0pRZGROOStiWWlYSHpFMk04SzhLOUh4M0V2NFlXdHFERkRjY29oclZL?=
 =?utf-8?Q?wBiLWD/9mMrx4x4WU4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9b8347-c670-49ea-d475-08de4f8b34af
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 14:27:23.9543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6eINYuAhc+qr1fC2TlQvXXbfDh/MWE/5rDQdWh2kVq9NoPn4/GUtDBzgUMBMQ+59
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6138
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

On 1/9/26 14:33, Tvrtko Ursulin wrote:
> Removing the output parameter from a few functions should result in more
> readable code and also enables us to save some lines.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 84 ++++++++++-----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h | 17 ++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 54 ++++++-------
>  3 files changed, 71 insertions(+), 84 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> index 62336890ed40..825ecde6a95f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> @@ -58,9 +58,9 @@ static int amdgpu_bo_list_entry_cmp(const void *_a, const void *_b)
>  	return (int)a->priority - (int)b->priority;
>  }
>  
> -int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
> -			  struct drm_amdgpu_bo_list_entry *info,
> -			  size_t num_entries, struct amdgpu_bo_list **result)
> +struct amdgpu_bo_list *
> +amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
> +		      struct drm_amdgpu_bo_list_entry *info, size_t num_entries)
>  {
>  	unsigned last_entry = 0, first_userptr = num_entries;
>  	struct amdgpu_bo_list_entry *array;
> @@ -71,7 +71,7 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
>  
>  	list = kvzalloc(struct_size(list, entries, num_entries), GFP_KERNEL);
>  	if (!list)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>  
>  	kref_init(&list->refcount);
>  
> @@ -126,8 +126,7 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
>  
>  	trace_amdgpu_cs_bo_status(list->num_entries, total_size);
>  
> -	*result = list;
> -	return 0;
> +	return list;
>  
>  error_free:
>  	for (i = 0; i < last_entry; ++i)
> @@ -135,12 +134,11 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
>  	for (i = first_userptr; i < num_entries; ++i)
>  		amdgpu_bo_unref(&array[i].bo);
>  	kvfree(list);
> -	return r;
> +	return ERR_PTR(r);
>  
>  }
>  
> -int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id,
> -		       struct amdgpu_bo_list **result)
> +struct amdgpu_bo_list *amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id)
>  {
>  	struct amdgpu_bo_list *list;
>  
> @@ -148,11 +146,11 @@ int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id,
>  	list = xa_load(&fpriv->bo_list_handles, id);
>  	if (list)
>  		kref_get(&list->refcount);
> +	else
> +		list = ERR_PTR(-ENOENT);
>  	xa_unlock(&fpriv->bo_list_handles);
>  
> -	*result = list;
> -
> -	return list ? 0 : -ENOENT;
> +	return list;
>  }
>  
>  void amdgpu_bo_list_put(struct amdgpu_bo_list *list)
> @@ -161,22 +159,15 @@ void amdgpu_bo_list_put(struct amdgpu_bo_list *list)
>  		kref_put(&list->refcount, amdgpu_bo_list_free);
>  }
>  
> -int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
> -				      struct drm_amdgpu_bo_list_entry **info_param)
> +struct drm_amdgpu_bo_list_entry *
> +amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in)
>  {
> -	struct drm_amdgpu_bo_list_entry *info;
> -
>  	if (in->bo_info_size != sizeof(struct drm_amdgpu_bo_list_entry))
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
>  
> -	info = vmemdup_array_user(u64_to_user_ptr(in->bo_info_ptr),
> +	return vmemdup_array_user(u64_to_user_ptr(in->bo_info_ptr),
>  				  in->bo_number,
>  				  sizeof(struct drm_amdgpu_bo_list_entry));
> -	if (IS_ERR(info))
> -		return PTR_ERR(info);
> -
> -	*info_param = info;
> -	return 0;
>  }
>  
>  int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
> @@ -184,27 +175,24 @@ int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
>  {
>  	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>  	struct amdgpu_device *adev = drm_to_adev(dev);
> -	struct drm_amdgpu_bo_list_entry *info = NULL;
>  	struct amdgpu_bo_list *list, *prev, *curr;
>  	union drm_amdgpu_bo_list *args = data;
>  	uint32_t handle = args->in.list_handle;
> +	struct drm_amdgpu_bo_list_entry *info;
>  	int r;
>  
> -	r = amdgpu_bo_create_list_entry_array(&args->in, &info);
> -	if (r)
> -		return r;
> -
>  	switch (args->in.operation) {
>  	case AMDGPU_BO_LIST_OP_CREATE:
> -		r = amdgpu_bo_list_create(adev, filp, info, args->in.bo_number,
> -					  &list);
> -		if (r)
> -			goto error_free;
> +	case AMDGPU_BO_LIST_OP_UPDATE:
> +		info = amdgpu_bo_create_list_entry_array(&args->in);
> +		if (IS_ERR(info))
> +			return PTR_ERR(info);
>  
> -		r = xa_alloc(&fpriv->bo_list_handles, &handle, list,
> -			     xa_limit_32b, GFP_KERNEL);
> -		if (r)
> -			goto error_put_list;
> +		list = amdgpu_bo_list_create(adev, filp, info,
> +					     args->in.bo_number);
> +		kvfree(info);
> +		if (IS_ERR(list))
> +			return PTR_ERR(list);
>  
>  		break;
>  
> @@ -215,12 +203,20 @@ int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
>  
>  		break;
>  
> -	case AMDGPU_BO_LIST_OP_UPDATE:
> -		r = amdgpu_bo_list_create(adev, filp, info, args->in.bo_number,
> -					  &list);
> +	default:
> +		return -EINVAL;
> +	};
> +
> +	switch (args->in.operation) {
> +	case AMDGPU_BO_LIST_OP_CREATE:
> +		r = xa_alloc(&fpriv->bo_list_handles, &handle, list,
> +			     xa_limit_32b, GFP_KERNEL);
>  		if (r)
> -			goto error_free;
> +			goto error_put_list;
>  
> +		break;
> +
> +	case AMDGPU_BO_LIST_OP_UPDATE:
>  		curr = xa_load(&fpriv->bo_list_handles, handle);
>  		if (!curr) {
>  			r = -ENOENT;
> @@ -240,21 +236,17 @@ int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
>  		amdgpu_bo_list_put(curr);
>  		break;
>  
> +	case AMDGPU_BO_LIST_OP_DESTROY:
>  	default:
> -		r = -EINVAL;
> -		goto error_free;
> +		/* Handled above. */
>  	}
>  
>  	memset(args, 0, sizeof(*args));
>  	args->out.list_handle = handle;
> -	kvfree(info);
>  
>  	return 0;
>  
>  error_put_list:
>  	amdgpu_bo_list_put(list);
> -
> -error_free:
> -	kvfree(info);
>  	return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> index cf127bc66f53..bde912150824 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> @@ -53,17 +53,16 @@ struct amdgpu_bo_list {
>  	struct amdgpu_bo_list_entry entries[] __counted_by(num_entries);
>  };
>  
> -int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id,
> -		       struct amdgpu_bo_list **result);
> +struct amdgpu_bo_list *amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id);
>  void amdgpu_bo_list_put(struct amdgpu_bo_list *list);
> -int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
> -				      struct drm_amdgpu_bo_list_entry **info_param);
> +struct drm_amdgpu_bo_list_entry *
> +amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in);
>  
> -int amdgpu_bo_list_create(struct amdgpu_device *adev,
> -				 struct drm_file *filp,
> -				 struct drm_amdgpu_bo_list_entry *info,
> -				 size_t num_entries,
> -				 struct amdgpu_bo_list **list);
> +struct amdgpu_bo_list *
> +amdgpu_bo_list_create(struct amdgpu_device *adev,
> +		      struct drm_file *filp,
> +		      struct drm_amdgpu_bo_list_entry *info,
> +		      size_t num_entries);
>  
>  #define amdgpu_bo_list_for_each_entry(e, list) \
>  	for (e = list->entries; \
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 5d53767aa941..8a6536994da1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -145,24 +145,19 @@ static int amdgpu_cs_p1_bo_handles(struct amdgpu_cs_parser *p,
>  				   struct drm_amdgpu_bo_list_in *data)
>  {
>  	struct drm_amdgpu_bo_list_entry *info;
> -	int r;
> +	struct amdgpu_bo_list *list;
>  
> -	r = amdgpu_bo_create_list_entry_array(data, &info);
> -	if (r)
> -		return r;
> -
> -	r = amdgpu_bo_list_create(p->adev, p->filp, info, data->bo_number,
> -				  &p->bo_list);
> -	if (r)
> -		goto error_free;
> +	info = amdgpu_bo_create_list_entry_array(data);
> +	if (IS_ERR(info))
> +		return PTR_ERR(info);
>  
> +	list = amdgpu_bo_list_create(p->adev, p->filp, info, data->bo_number);
>  	kvfree(info);
> +	if (IS_ERR(list))
> +		return PTR_ERR(list);
> +
> +	p->bo_list = list;
>  	return 0;
> -
> -error_free:
> -	kvfree(info);
> -
> -	return r;
>  }
>  
>  /* Copy the data from userspace and go over it the first time */
> @@ -850,6 +845,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  {
>  	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
>  	struct ttm_operation_ctx ctx = { true, false };
> +	struct amdgpu_bo_list *list = NULL;
>  	struct amdgpu_vm *vm = &fpriv->vm;
>  	struct amdgpu_bo_list_entry *e;
>  	struct drm_gem_object *obj;
> @@ -862,23 +858,24 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  		if (p->bo_list)
>  			return -EINVAL;
>  
> -		r = amdgpu_bo_list_get(fpriv, cs->in.bo_list_handle,
> -				       &p->bo_list);
> -		if (r)
> -			return r;
> +		list = amdgpu_bo_list_get(fpriv, cs->in.bo_list_handle);
>  	} else if (!p->bo_list) {
>  		/* Create a empty bo_list when no handle is provided */
> -		r = amdgpu_bo_list_create(p->adev, p->filp, NULL, 0,
> -					  &p->bo_list);
> -		if (r)
> -			return r;
> +		list = amdgpu_bo_list_create(p->adev, p->filp, NULL, 0);
>  	}
>  
> +	if (IS_ERR(list))
> +		return PTR_ERR(list);
> +	else if (list)
> +		p->bo_list = list;
> +	else
> +		list = p->bo_list;
> +
>  	/* Get userptr backing pages. If pages are updated after registered
>  	 * in amdgpu_gem_userptr_ioctl(), amdgpu_cs_list_validate() will do
>  	 * amdgpu_ttm_backend_bind() to flush and invalidate new pages
>  	 */
> -	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
> +	amdgpu_bo_list_for_each_userptr_entry(e, list) {
>  		bool userpage_invalidated = false;
>  		struct amdgpu_bo *bo = e->bo;
>  
> @@ -906,7 +903,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  		if (unlikely(r))
>  			goto out_free_user_pages;
>  
> -		amdgpu_bo_list_for_each_entry(e, p->bo_list) {
> +		amdgpu_bo_list_for_each_entry(e, list) {
>  			/* One fence for TTM and one for each CS job */
>  			r = drm_exec_prepare_obj(&p->exec, &e->bo->tbo.base,
>  						 1 + p->gang_size);
> @@ -926,7 +923,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  		}
>  	}
>  
> -	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
> +	amdgpu_bo_list_for_each_userptr_entry(e, list) {
>  		struct mm_struct *usermm;
>  
>  		usermm = amdgpu_ttm_tt_get_usermm(e->bo->tbo.ttm);
> @@ -979,13 +976,12 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  				     p->bytes_moved_vis);
>  
>  	for (i = 0; i < p->gang_size; ++i)
> -		amdgpu_job_set_resources(p->jobs[i], p->bo_list->gds_obj,
> -					 p->bo_list->gws_obj,
> -					 p->bo_list->oa_obj);
> +		amdgpu_job_set_resources(p->jobs[i], list->gds_obj,
> +					 list->gws_obj, list->oa_obj);
>  	return 0;
>  
>  out_free_user_pages:
> -	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
> +	amdgpu_bo_list_for_each_userptr_entry(e, list) {
>  		amdgpu_hmm_range_free(e->range);
>  		e->range = NULL;
>  	}

