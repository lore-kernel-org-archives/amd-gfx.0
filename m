Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43EE1CCD1AB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 06:57:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF83410E6C0;
	Wed, 22 Oct 2025 06:57:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TXZEy/LO";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012068.outbound.protection.outlook.com [52.101.48.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D120810E6C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 06:57:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ge01y6Fdiy/ZPaEengiVx6H28sDrtFyaL/UMW1TAiOiDESn+lRfjYy2Ftgpq9r/U22bYM7sH5iLtGjrjqZDbwcRnmy+qFyQYwvVjRlX+O7xt65WGZEES0OT4g2zZvGJ3eXdH56XRDEDSMYOdrtfVLPsfLRIkN4XQ7F7NTHG2JY+Y6yogWB/lrv3m++dz883hUMx9UVS59FoXXGIJcot+hwoBAU3dyyhVOsFmHPAQ/9gg/Ms9yd0hCGGwhBaD1FV+wrCXp3HCXRmjqruKz5RBNB7kjzjxwkCNsOOH+rvf9R5eobNxHlk2DDkr5TE2YEoHD8PMsnOs7gDKq5wljyxr0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNbjf1/mSYg+Nh7jyWZpk+ktek3XgJ5fd1YbCgtnGx8=;
 b=uiDjxHN60p1s7qDWFBbiPEpgjLcEEyftXP+Mk0PIxo8vMwJnDYZFSGxLtZc11h44rH2avXmY9l/58rTZR6rPqXPO6/CT+6Q0ASktN9BfPvJfdeWBvz5G8y802Bs0iaGTUSyRsszUivpAi2Rs7U0ZChemUAUJxiKq3RYmVaycuKL14JJkMBKrHj/NrA963li+67o+5vmb6vAjR+MKMsmmmRPV+hKWNV/CJ0NEO8HDx+WpYjBJVDd1VhgbbYHMPXauBgHHXI/zkpxjiuboiLiq2SZ396ifhdagKdZgPdxphDbPjYo2yXXpKPJKXIdpMCC49RkVSpnAqX/dzWDgkzRggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNbjf1/mSYg+Nh7jyWZpk+ktek3XgJ5fd1YbCgtnGx8=;
 b=TXZEy/LO1/JHY3p3lJ+3+5czoGLQ7TYhfecoLd9J4aIx0dugS2jsAiM89ITrY0VpHVwZ/qLdaMWZ9pX0qqDjfIvX6nb34qIt3DlG9ss0OjhEqsxFeT63KuOChZZaJRQiRHG4FPxNngqbMQKbUZG0Q0tZb4DSIFlEqCcNKGbfYMQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by DM4PR12MB7671.namprd12.prod.outlook.com (2603:10b6:8:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 06:57:02 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%7]) with mapi id 15.20.9228.015; Wed, 22 Oct 2025
 06:57:02 +0000
Content-Type: multipart/alternative;
 boundary="------------Z3LPK00Wv5F9ZIv65MSaZWiQ"
Message-ID: <9039675e-d0c2-418e-bbd2-f2884ef34285@amd.com>
Date: Wed, 22 Oct 2025 14:56:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 08/18] amdkfd: identify a secondary kfd process by its
 id
To: Felix Kuehling <felix.kuehling@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20251017084222.54721-1-lingshan.zhu@amd.com>
 <20251017084222.54721-9-lingshan.zhu@amd.com>
 <1a34e488-72b3-4974-8807-e10d8170b1de@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <1a34e488-72b3-4974-8807-e10d8170b1de@amd.com>
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|DM4PR12MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: 563269fa-f755-47f6-1780-08de11383407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cTRKU2IwMTRZNnNpbHdrZjZVVWRjMi9XOGFhR1dvalRhekFjMWJQZ0VRQ2JC?=
 =?utf-8?B?Rko5Q2MxWEFocThjTGJ1bTdnRk01Q2dRcjhKWStxekF6aWYrMFNmRzFMalcw?=
 =?utf-8?B?NUxqc2p1T3dNSWEvZWJRMEY2YWhrSDVPaUtNbkh5VlJQU1VuM1p1Y1NSTXk2?=
 =?utf-8?B?dlNMRmUwZUNQRURlaTE2VzFZN1JWLzVvZmQ3aXByREx5U1Q2czNQTnAxOTFx?=
 =?utf-8?B?b0ZMMENyY2ZjS29KK092L2U5b0ZqY3BLUkZNT0h2L20zamNzSXVBZGlSTHhw?=
 =?utf-8?B?Nm84TlFjR096MWZjTmNTY1lZcGpFelZzblhFUUlWbmNYZzJBSHdZa3JVajZr?=
 =?utf-8?B?RVBoZXRzS2xOQjZ3dG95UjAvTkxLaEplMVcxRkIrUFRINkp2WFpOMTFUVjZZ?=
 =?utf-8?B?ZWV3VW9MYVp6U1ZpQ1QrSmtlV0xCdkNnNEljSHVjRkFNdTNuUXZxNlpxSUNh?=
 =?utf-8?B?c2d0NDVxSDNZaEJYM0lydU91eVBUZWpPQ1FWL285MHljbFFBVERWSXk4UU5D?=
 =?utf-8?B?a0NweWpZd2M0M09GdUtZbDQwdUVaUDZkUFArWm8wUjdKMzJNam5xWlhrZDFh?=
 =?utf-8?B?eWMvUXdIclBwYzNTTEJ4QzYyWGtEbzFZWlprRWhWTU55UkxIZ0wyT21wSWlZ?=
 =?utf-8?B?NkVFSklINHBwUUtxOHk5M0RLSGpkY2Y5Ny95YW5LRHVNdFZWTk5GalhSMkpo?=
 =?utf-8?B?NjZIQXhXQ21NaVV6amprbzZ1SjFnL1FWV1RqSG41ZCtNc00yWm5WcGk5ZkFZ?=
 =?utf-8?B?OFR0ZkRYTndZeEJNejhQR1ZmN05DSUluNTg1d3VjYTZnN1FiMXNIUUJCaG9X?=
 =?utf-8?B?Q0dmYld3TXU0VjJ2bWkzWW9pUHNLZjNpSWN3a2RvTVIrMWI2ckFWVGlwTUNn?=
 =?utf-8?B?UndEQ3hHOUVLUFk4OHZJUm5CUVdtbUhlc05FcDlGQStMUDVVNzhuRVcvQkNE?=
 =?utf-8?B?TVRzOG9EQ0ZXa1FVblJFRFhVREdyOHRTdFdpcUlMMGtmVm9EN3RkeXJHc1Ni?=
 =?utf-8?B?VVlRSnZYalJWVXM0aUllQ3ZJUEx6eWFTbksxanVPcUE4ZFE4b2xheWFLTXd3?=
 =?utf-8?B?YU9nNXpnc3RmUnFrbDR1UStjd2FXenIvZTZaVzNEc3kxeU1vR2tqUlBiRUVL?=
 =?utf-8?B?L3crZkZ1bk9FdGo4Zk41NnVDU3NKQTA4UTNTMG5TZnE0cXB6OUpoVmFTbVJz?=
 =?utf-8?B?WE5SMVRpUldCT0diemFraU9SZlRjb2lRbHk5V0tpWk9HSmZuS0psOG1kUXQ4?=
 =?utf-8?B?S0w5K0k3QTEvTVYrclBESWFnWWtUQmVUVkxobXFacE9BMVZicVJmWFUvNmFN?=
 =?utf-8?B?NWswa1VUdVRoRUJNN3VCOWRVM0RCN2hQdnNoTlMweXJYWlZYRk5RRUNTY05E?=
 =?utf-8?B?S1lTT0Nldjdza3h5ZlFqanhrWmMzK2VxWTg1YXJCY2JhM0Qzd1JKR3crWWVm?=
 =?utf-8?B?QTZ4d3NCakhSL2krcE9RYitQbW1FcklkVTNsNUFCdXMxRitLN3BlTkhPZ3Yr?=
 =?utf-8?B?V253UVBGWWdZbEttcW9zcnNRYktTMmlRNzNPTlNLRFA3a2xBMDBSMTRaT0Fo?=
 =?utf-8?B?dTZvQUZvUzllTTR1YjRJTFBiOW1hd1J5SWdhMm5GS1BCUUwxY09IYnBNK0JK?=
 =?utf-8?B?WnYyMjFGN3o4eDg3aG9LSGhFb2d4MURTSGdaeVRhWTZpUkc1Z1g1aC8zWktr?=
 =?utf-8?B?ckxsRDAwWjJjYzcyanlWdjk2M2tzYzZFbU5JenFKeEhSangyYmtWVU8yQUpC?=
 =?utf-8?B?bnFXeHpCTUdZbFozdEh4OFkwWEdMZ2h2SzZkdHRVc05mNUJxZnpSbFNDWXJX?=
 =?utf-8?B?ZS81bnVhWHMya2lwNmxjdHFqODJ5RW0rRmRXL3pKNGVGci91Mlh1WDJNQ1lT?=
 =?utf-8?B?M01HN2pzTWp0TDF0MXRrbjBwczdOR3FURlVZMXFpbVlNeUhhZ0VaTjZNQm8x?=
 =?utf-8?Q?7LDDi+B/sUaBpQqCwdsm7hheQgpZO43m?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDA2b2wxN2dBa0VTTFVwdHhFbkRmQi9kSzRBTmN2a2J4NWQyVTVsOGQ0U2ho?=
 =?utf-8?B?WWRGcU1vVUFtbWtXdjQyaWlwclNKNnJGWk43cndxeTdnK2ptdWp3dG1RRGpp?=
 =?utf-8?B?a1hTazlHalR6L0xJZUo0VGxGbG9mSElTTEV4anAxWUpSUjJzTnZLaWV6b01U?=
 =?utf-8?B?ZGhFMW1uOS9FVzQ5a1RkMldSVFRrWEw3bTdxNm1tSmRINVo5VFBiRUliVm5i?=
 =?utf-8?B?WGlnd2d1ZFpzQS9ROXRwcnpxK0lIaEZ6T2hVTWVvNHR3N3NRdEdZcEJHbzJE?=
 =?utf-8?B?TlpYQ0VmeWFwWUZNS01vWUxRS2VZUWdwaVdjQ0kxNktCTkpMbjVPOTkwWEZi?=
 =?utf-8?B?dDcvTUJ4eE84RUtVK3hpd0dseUx1WEpBSTIzbVJoZSsrZkRJZ3lnZ1dEdzFH?=
 =?utf-8?B?SUVxRVRFbnRONURBcGpHUE9mN0VubC9JeEFyNEVjZDdmRXFIUTg4V2J4ZlVk?=
 =?utf-8?B?SkR5V08zYzNQOWcrVjJndTFydDRHRWdZMUJoei91TC9ZdmpVVGwxTHJrcEtm?=
 =?utf-8?B?bEdCYnFialR3TDNVOGdQNmUyL0R0dWVFNTZ6dDRyd2FlUHk5WVdMUEVUL0JT?=
 =?utf-8?B?RDhza3hlSjJjMnVwVVZGUjkranNHN1cxek9WcG95dlhBdWVhQW15WXNPeHZu?=
 =?utf-8?B?S0xmOTkyOVRmdkpxUkErMFZuYUxyWWkwMTJlTmRudERSOXVMZnZJZm16VmUx?=
 =?utf-8?B?TkpxVVp0bEwyR3pxbkFaYWlBU2FTaHdxYjg5QTcxYlk1QmNDMXZzVmY5MHlL?=
 =?utf-8?B?VXlpdHFrTGNxZG5jR1k1clNRc2JlZEgzOURTdnR0OE0rdDQ3eThmOGlTYjU0?=
 =?utf-8?B?UlJIY21yRkN6MklESHZyNXZIRi9ZaXRNbWp5MEtqaTQ4c1BkZ00xaG5pS0hD?=
 =?utf-8?B?NTVDNTdxbVc4Y2FnNWc5ck1yakhCV1BrVkJ0a1lNK1c0dTVVTmQ5MkhDcm5t?=
 =?utf-8?B?alR3RDBNVDhXaytCdjh4R0wrejBtL01aRzFMTDZQMG1LaU9DTFpJWHNBRHNs?=
 =?utf-8?B?ZndNTEtpaWtvT0FhazU3ZTEwV05YbGN0bmlENmV4M09sN3doQ0xYOCsrTnlF?=
 =?utf-8?B?RU9UTmtxZXphSTRJODBtbFZFVUgxMXQ0S29ZWTJlRTI4WUZVbCs1Q1k4R3Nl?=
 =?utf-8?B?d2IxOTIrd1VVQlJZN1A4ZGRnMDF0d2laMFBHU0RrSno4MklhYXl4a28yd1dx?=
 =?utf-8?B?MFpHZUE5bzM5Z3NyQkUweUc4aWdnZFZCMFlkMmF4TXFqRTRUaGlLczgxQWJk?=
 =?utf-8?B?eFJGS044cHVIdE5PMFZ6bUk2cUlKbHhpMWEyODVPOFNkUHVtTXRMRStPbkQ4?=
 =?utf-8?B?ektRWnc0TWtZRGdJWkU5QmwyL2JQRUp5cWR2amFFRFhVZGhSR2V0VU9yRDlm?=
 =?utf-8?B?aXRGeDZNYWxUVXJqMEVnZmFNU0dNUE1GeThoQituSDdhUExEQlBnYXl0TnNO?=
 =?utf-8?B?aE1mMWpVSzhGQ1VKWU5DOEVsTFo1c0lLdjdTblIwamdkMlhhRU5UYjlhUkh3?=
 =?utf-8?B?dm1tMTBLSXZCYlM0QWR6V3lpbW52ZG40Q01DVGlLNGh1Z05yVGV2UkdGU3gv?=
 =?utf-8?B?OExYUEM0TFh0dXJPMW1WT044VkZnQUhTNFNDNkxjWVpGS1NIaWtnYXZKZnhj?=
 =?utf-8?B?YnBQTjBvSWo0blArSGdlQ1JjS2ZvV3l6ODFoTlF2N010UDlEMXdhRmVxdm5X?=
 =?utf-8?B?eFVXcllQc2dvMk1nUE83SDNyb1pXd2lLWHBiZ1lSYkdvaWhCQ09HTENrK05a?=
 =?utf-8?B?am9qb1pKYzVKT1NaaWdzeFVXMHJSaUZVZGRkalc2ekwwUnFFS1ZMaEhIa2JS?=
 =?utf-8?B?RzFNbFZQalkwY21jKzIrZmRyU3ZpTkNuaVJmSzFPcTQrSkFtejg1M1AxQVdB?=
 =?utf-8?B?aytpalE0S28zWHl3N2lrMzREdFBEaHk1VmZlSUhldzUxbDYzc202eGpEVzRj?=
 =?utf-8?B?TkZVdXo3QVpjdnJLM3ZoV1F0aTU4UUlFaEs2dXZlSExJYXFLcEFGaThsWDdX?=
 =?utf-8?B?d3dmU0d4NzIwVUxsNmtSOVZiY1kvdzVXT1dBN1hLUGhwMTBnWlRnTXR0TzF0?=
 =?utf-8?B?dk5VS3dMcS9pNCsrSWlzRWpTdHdsc3RnRUIyS0tabW0rZ0lkemJmMWJzRm42?=
 =?utf-8?Q?DEHTIDujccciRz3Z+K3PIviEN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 563269fa-f755-47f6-1780-08de11383407
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 06:57:02.3678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NQYA8o0CKiWljqe3NdVQxJrxCu+Ay8OHV8M2+3EhDUbba8eCII7zbmUNv5h6VD6v7hELemEJ7KjCmStH793hqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7671
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

--------------Z3LPK00Wv5F9ZIv65MSaZWiQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/18/2025 7:16 AM, Felix Kuehling wrote:
> On 2025-10-17 04:42, Zhu Lingshan wrote:
>> This commit introduces a new id field for
>> struct kfd process, which helps identify
>> a kfd process among multiple contexts that
>> all belong to a single user space program.
>>
>> The sysfs entry of a secondary kfd process
>> is placed under the sysfs entry folder of
>> its primary kfd process.
>>
>> The naming format of the sysfs entry of a secondary
>> kfd process is "context_%u" where %u is the process id.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  6 ++
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 78 +++++++++++++++++++++++-
>>   2 files changed, 81 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 919510f18249..9de658119cd9 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -1021,10 +1021,16 @@ struct kfd_process {
>>         /*kfd context id */
>>       u16 context_id;
>> +
>> +    /* The primary kfd_process allocating IDs for its secondary
>> kfd_process, 0 for primary kfd_process */
>> +    struct ida id_table;
>> +
>>   };
>>     #define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
>>   #define KFD_CONTEXT_ID_PRIMARY    0xFFFF
>> +#define KFD_CONTEXT_ID_MIN 0
>> +#define KFD_CONTEXT_ID_WIDTH 16
>>     extern DECLARE_HASHTABLE(kfd_processes_table,
>> KFD_PROCESS_TABLE_SIZE);
>>   extern struct srcu_struct kfd_processes_srcu;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index 995d27be06e3..157145c94314 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -827,6 +827,7 @@ static void
>> kfd_process_device_destroy_ib_mem(struct kfd_process_device *pdd)
>>     int kfd_create_process_sysfs(struct kfd_process *process)
>>   {
>> +    struct kfd_process *primary_process;
>>       int ret;
>>         if (process->kobj) {
>> @@ -839,9 +840,22 @@ int kfd_create_process_sysfs(struct kfd_process
>> *process)
>>           pr_warn("Creating procfs kobject failed");
>>           return -ENOMEM;
>>       }
>> -    ret = kobject_init_and_add(process->kobj, &procfs_type,
>> -                   procfs.kobj, "%d",
>> -                   (int)process->lead_thread->pid);
>> +
>> +    if (process->context_id == KFD_CONTEXT_ID_PRIMARY)
>> +        ret = kobject_init_and_add(process->kobj, &procfs_type,
>> +                       procfs.kobj, "%d",
>> +                       (int)process->lead_thread->pid);
>> +    else {
>> +        primary_process =
>> kfd_lookup_process_by_mm(process->lead_thread->mm);
>> +        if (!primary_process)
>> +            return -ESRCH;
>> +
>> +        ret = kobject_init_and_add(process->kobj, &procfs_type,
>> +                       primary_process->kobj, "context_%u",
>> +                       process->context_id);
>> +        kfd_unref_process(primary_process);
>> +    }
>> +
>>       if (ret) {
>>           pr_warn("Creating procfs pid directory failed");
>>           kobject_put(process->kobj);
>> @@ -863,6 +877,50 @@ int kfd_create_process_sysfs(struct kfd_process
>> *process)
>>       return 0;
>>   }
>>   +static int kfd_process_alloc_id(struct kfd_process *process)
>> +{
>> +    int ret;
>> +    struct kfd_process *primary_process;
>> +
>> +    /* already assign 0xFFFF when create */
>> +    if (process->context_id == KFD_CONTEXT_ID_PRIMARY)
>> +        return 0;
>> +
>> +    primary_process =
>> kfd_lookup_process_by_mm(process->lead_thread->mm);
>> +    if (!primary_process)
>> +        return -ESRCH;
>> +
>> +    /* id range: KFD_CONTEXT_ID_MIN to 0xFFFE */
>> +    ret = ida_alloc_range(&primary_process->id_table,
>> KFD_CONTEXT_ID_MIN,
>> +         (1 << KFD_CONTEXT_ID_WIDTH) - 2, GFP_KERNEL);
>
> This would be safer and more obvious if you just set the upper limit
> as KFD_CONTEXT_ID_PRIMARY - 1. Then you don't need
> KFD_CONTEXT_ID_WIDTH at all. 

will fix in V6, thanks!

>
> Regards,
>   Felix
>
>
>> +    if (ret < 0)
>> +        goto out;
>> +
>> +    process->context_id = ret;
>> +    ret = 0;
>> +
>> +out:
>> +    kfd_unref_process(primary_process);
>> +
>> +    return ret;
>> +}
>> +
>> +static void kfd_process_free_id(struct kfd_process *process)
>> +{
>> +    struct kfd_process *primary_process;
>> +
>> +    if (process->context_id != KFD_CONTEXT_ID_PRIMARY)
>> +        return;
>> +
>> +    primary_process =
>> kfd_lookup_process_by_mm(process->lead_thread->mm);
>> +    if (!primary_process)
>> +        return;
>> +
>> +    ida_free(&primary_process->id_table, process->context_id);
>> +
>> +    kfd_unref_process(primary_process);
>> +}
>> +
>>   struct kfd_process *kfd_create_process(struct task_struct *thread)
>>   {
>>       struct kfd_process *process;
>> @@ -1195,6 +1253,11 @@ static void kfd_process_wq_release(struct
>> work_struct *work)
>>       if (ef)
>>           dma_fence_signal(ef);
>>   +    if (p->context_id != KFD_CONTEXT_ID_PRIMARY)
>> +        kfd_process_free_id(p);
>> +    else
>> +        ida_destroy(&p->id_table);
>> +
>>       kfd_process_remove_sysfs(p);
>>       kfd_debugfs_remove_process(p);
>>   @@ -1601,6 +1664,13 @@ static struct kfd_process
>> *create_process(const struct task_struct *thread, bool
>>               goto err_register_notifier;
>>           }
>>           BUG_ON(mn != &process->mmu_notifier);
>> +        ida_init(&process->id_table);
>> +    }
>> +
>> +    err = kfd_process_alloc_id(process);
>> +    if (err) {
>> +        pr_err("Creating kfd process: failed to alloc an id\n");
>> +        goto err_alloc_id;
>>       }
>>         kfd_unref_process(process);
>> @@ -1610,6 +1680,8 @@ static struct kfd_process *create_process(const
>> struct task_struct *thread, bool
>>         return process;
>>   +err_alloc_id:
>> +    kfd_process_free_id(process);
>>   err_register_notifier:
>>       hash_del_rcu(&process->kfd_processes);
>>       svm_range_list_fini(process);
--------------Z3LPK00Wv5F9ZIv65MSaZWiQ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    On 10/18/2025 7:16 AM, Felix Kuehling wrote:
    <blockquote type="cite" cite="mid:1a34e488-72b3-4974-8807-e10d8170b1de@amd.com">On
      2025-10-17 04:42, Zhu Lingshan wrote:
      <br>
      <blockquote type="cite">This commit introduces a new id field for
        <br>
        struct kfd process, which helps identify
        <br>
        a kfd process among multiple contexts that
        <br>
        all belong to a single user space program.
        <br>
        <br>
        The sysfs entry of a secondary kfd process
        <br>
        is placed under the sysfs entry folder of
        <br>
        its primary kfd process.
        <br>
        <br>
        The naming format of the sysfs entry of a secondary
        <br>
        kfd process is &quot;context_%u&quot; where %u is the process id.
        <br>
        <br>
        Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp; |&nbsp; 6 ++
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c | 78
        +++++++++++++++++++++++-
        <br>
        &nbsp; 2 files changed, 81 insertions(+), 3 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        index 919510f18249..9de658119cd9 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        @@ -1021,10 +1021,16 @@ struct kfd_process {
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*kfd context id */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u16 context_id;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* The primary kfd_process allocating IDs for its secondary
        kfd_process, 0 for primary kfd_process */
        <br>
        +&nbsp;&nbsp;&nbsp; struct ida id_table;
        <br>
        +
        <br>
        &nbsp; };
        <br>
        &nbsp; &nbsp; #define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
        <br>
        &nbsp; #define KFD_CONTEXT_ID_PRIMARY&nbsp;&nbsp;&nbsp; 0xFFFF
        <br>
        +#define KFD_CONTEXT_ID_MIN 0
        <br>
        +#define KFD_CONTEXT_ID_WIDTH 16
        <br>
        &nbsp; &nbsp; extern DECLARE_HASHTABLE(kfd_processes_table,
        KFD_PROCESS_TABLE_SIZE);
        <br>
        &nbsp; extern struct srcu_struct kfd_processes_srcu;
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        index 995d27be06e3..157145c94314 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        @@ -827,6 +827,7 @@ static void
        kfd_process_device_destroy_ib_mem(struct kfd_process_device
        *pdd)
        <br>
        &nbsp; &nbsp; int kfd_create_process_sysfs(struct kfd_process *process)
        <br>
        &nbsp; {
        <br>
        +&nbsp;&nbsp;&nbsp; struct kfd_process *primary_process;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (process-&gt;kobj) {
        <br>
        @@ -839,9 +840,22 @@ int kfd_create_process_sysfs(struct
        kfd_process *process)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_warn(&quot;Creating procfs kobject failed&quot;);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        -&nbsp;&nbsp;&nbsp; ret = kobject_init_and_add(process-&gt;kobj,
        &amp;procfs_type,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; procfs.kobj, &quot;%d&quot;,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (int)process-&gt;lead_thread-&gt;pid);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (process-&gt;context_id == KFD_CONTEXT_ID_PRIMARY)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = kobject_init_and_add(process-&gt;kobj,
        &amp;procfs_type,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; procfs.kobj, &quot;%d&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (int)process-&gt;lead_thread-&gt;pid);
        <br>
        +&nbsp;&nbsp;&nbsp; else {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; primary_process =
        kfd_lookup_process_by_mm(process-&gt;lead_thread-&gt;mm);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!primary_process)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ESRCH;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = kobject_init_and_add(process-&gt;kobj,
        &amp;procfs_type,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; primary_process-&gt;kobj, &quot;context_%u&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process-&gt;context_id);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_unref_process(primary_process);
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_warn(&quot;Creating procfs pid directory failed&quot;);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kobject_put(process-&gt;kobj);
        <br>
        @@ -863,6 +877,50 @@ int kfd_create_process_sysfs(struct
        kfd_process *process)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        &nbsp; }
        <br>
        &nbsp; +static int kfd_process_alloc_id(struct kfd_process *process)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; int ret;
        <br>
        +&nbsp;&nbsp;&nbsp; struct kfd_process *primary_process;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* already assign 0xFFFF when create */
        <br>
        +&nbsp;&nbsp;&nbsp; if (process-&gt;context_id == KFD_CONTEXT_ID_PRIMARY)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; primary_process =
        kfd_lookup_process_by_mm(process-&gt;lead_thread-&gt;mm);
        <br>
        +&nbsp;&nbsp;&nbsp; if (!primary_process)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ESRCH;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* id range: KFD_CONTEXT_ID_MIN to 0xFFFE */
        <br>
        +&nbsp;&nbsp;&nbsp; ret = ida_alloc_range(&amp;primary_process-&gt;id_table,
        KFD_CONTEXT_ID_MIN,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1 &lt;&lt; KFD_CONTEXT_ID_WIDTH) - 2, GFP_KERNEL);
        <br>
      </blockquote>
      <br>
      This would be safer and more obvious if you just set the upper
      limit as KFD_CONTEXT_ID_PRIMARY - 1. Then you don't need
      KFD_CONTEXT_ID_WIDTH at all.&nbsp;<br>
    </blockquote>
    <pre>will fix in V6, thanks!</pre>
    <blockquote type="cite" cite="mid:1a34e488-72b3-4974-8807-e10d8170b1de@amd.com"><br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">+&nbsp;&nbsp;&nbsp; if (ret &lt; 0)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; process-&gt;context_id = ret;
        <br>
        +&nbsp;&nbsp;&nbsp; ret = 0;
        <br>
        +
        <br>
        +out:
        <br>
        +&nbsp;&nbsp;&nbsp; kfd_unref_process(primary_process);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; return ret;
        <br>
        +}
        <br>
        +
        <br>
        +static void kfd_process_free_id(struct kfd_process *process)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; struct kfd_process *primary_process;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (process-&gt;context_id != KFD_CONTEXT_ID_PRIMARY)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; primary_process =
        kfd_lookup_process_by_mm(process-&gt;lead_thread-&gt;mm);
        <br>
        +&nbsp;&nbsp;&nbsp; if (!primary_process)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; ida_free(&amp;primary_process-&gt;id_table,
        process-&gt;context_id);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; kfd_unref_process(primary_process);
        <br>
        +}
        <br>
        +
        <br>
        &nbsp; struct kfd_process *kfd_create_process(struct task_struct
        *thread)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *process;
        <br>
        @@ -1195,6 +1253,11 @@ static void kfd_process_wq_release(struct
        work_struct *work)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ef)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_signal(ef);
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; if (p-&gt;context_id != KFD_CONTEXT_ID_PRIMARY)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_process_free_id(p);
        <br>
        +&nbsp;&nbsp;&nbsp; else
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ida_destroy(&amp;p-&gt;id_table);
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_process_remove_sysfs(p);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_debugfs_remove_process(p);
        <br>
        &nbsp; @@ -1601,6 +1664,13 @@ static struct kfd_process
        *create_process(const struct task_struct *thread, bool
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_register_notifier;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(mn != &amp;process-&gt;mmu_notifier);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ida_init(&amp;process-&gt;id_table);
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; err = kfd_process_alloc_id(process);
        <br>
        +&nbsp;&nbsp;&nbsp; if (err) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Creating kfd process: failed to alloc an
        id\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_alloc_id;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_unref_process(process);
        <br>
        @@ -1610,6 +1680,8 @@ static struct kfd_process
        *create_process(const struct task_struct *thread, bool
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return process;
        <br>
        &nbsp; +err_alloc_id:
        <br>
        +&nbsp;&nbsp;&nbsp; kfd_process_free_id(process);
        <br>
        &nbsp; err_register_notifier:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hash_del_rcu(&amp;process-&gt;kfd_processes);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_list_fini(process);
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------Z3LPK00Wv5F9ZIv65MSaZWiQ--
