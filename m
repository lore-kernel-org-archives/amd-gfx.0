Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2782BCCA471
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Oct 2025 22:02:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8640A10E0E2;
	Fri,  3 Oct 2025 22:02:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PFgwsZnA";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013006.outbound.protection.outlook.com
 [40.93.196.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5BAB10E0E2
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Oct 2025 22:02:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNzzM702t0O05rau6hmsWmDOH2XhZHu6fS4kRDI/0jfboZ/wUjDbktR0HVYQtWVssLlA0oUjWbskbolBrOKcRqMctVo4vjp8U87j+9VfjK9Yahl4bHru1GQzmCxU2n02zd1E8kHMAE/KpnZ17N2K9ZictS1z9MFxcoB9SpL3ER2PxA/cx3947Ff5n+5VbkiOOGOPvyN8QxchryDnlrXpMhLXSRwmJs2iBxR6PjO1iKKwdEvGMDm7vMH7WmZXeOfjoW8HT3QTKEKv3FxkJfAzaIA0tCiVWdNOfoclARfuzaJyVENnPK3Isnl5wiRNAd4GjxNP2gC+wovIhVqOPQDDsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cz8nzZzNpYD5o74L82qEoq3Kz+O4DLK7PI03kd29a8c=;
 b=O1rdiHwXHvj42aATAHI8UTnQNQtcr42krG6eHM48rcfgp3PUuTHxN1F5xgsbfzWedc4XcSp+9yCSPoE1xfl9DMxkx6a9GSjryaFtKxAzczIABB80oD4kVbWXDg1Zx7oGjjb52FHNIyjOEVVI6SYDl6rNjlXUin4tczNRr8Hoj2x+CetQ47iyu4aKWClMLTDiatewemLToHt1mht/mS89zfnuZVOftgJckrFHtl5TXHjrEtG0IZfLeP+p3YPJPWBDU25dopEBm0jdYKrS9R6+qWWOgtDijYLo0fHPBtAXe5qyrgF86FPhR2EhKt2BGzVsIf8nIby0A6xuCQPJ6GZsng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cz8nzZzNpYD5o74L82qEoq3Kz+O4DLK7PI03kd29a8c=;
 b=PFgwsZnAIOLrjjTrEemt0j9aYsW+XtDxv8LLT2lrMNkIN42d4kdedof26j0fjr03K5i1QNyfXoagg6R9hGC8Gy3Pl44k0SPPyh1t83bffIhGEXs4ex9+QqAJZWOATtSYKw3U7yweFV8bDADCcTdwJRhENqY2p+o/z92MbKkkxrA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SA0PR12MB4494.namprd12.prod.outlook.com (2603:10b6:806:94::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 22:02:03 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9160.015; Fri, 3 Oct 2025
 22:02:03 +0000
Message-ID: <aa910171-bc96-d8b1-1bee-65f3ef5d1f46@amd.com>
Date: Fri, 3 Oct 2025 18:02:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Fix svm_bo and vram page refcount
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250926210331.17401-1-Philip.Yang@amd.com>
 <87ae1017-5990-4d6e-b42c-7a15f5663281@amd.com>
 <f3349a43-446f-f712-ac61-fa867cd74242@amd.com>
 <674f455e-434d-43d2-8f4f-18f577479ac9@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <674f455e-434d-43d2-8f4f-18f577479ac9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::21) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SA0PR12MB4494:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ca7083c-4a7a-40de-ead2-08de02c87c24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejk1YitMTFBmVnR6MDNyZUhsRmYxQU9Hek90QnlidWkrUmVWMGszSUoyTDU5?=
 =?utf-8?B?eXZRNERKd2h0b045U21QSmp4QU5xS2RJTzdWZi8reXdWVlRuOEJDS1FLS2d2?=
 =?utf-8?B?WDJkcHdJZFBpSXc1RTdQcjVSWUMwNEVjNlVmL01mMy9Kd3NrYlVCODlMOU5E?=
 =?utf-8?B?VDRxNkNZRlNqY1ZhMTVHK3FqSHpWaFZRWGFPNFdERE5FWHNOUGZIZ0Q3N3k4?=
 =?utf-8?B?MGh6R1hNUnhoL1hOZXBPb0VCazJkOFdiQk5ORWw5ck1kNzJ1VDJnR2lpcUl0?=
 =?utf-8?B?QnYwSWhTZCs2dTcyRXAvdWN4RERvYithSVYrWERDYmprSEp0NTM3TGUyRlFw?=
 =?utf-8?B?OEgvcVhsQjNBbmJSOEwxSWdEb2V6TktxQlpRODVsS1R0dVBKQjNiVEg4L0Ft?=
 =?utf-8?B?UlAxanZNU0lzSEJDQnhSejZXbnI4QXdhZ1lST2ZGd2xPUE54c0VnbWEvN3Yz?=
 =?utf-8?B?V1pHcWJGRGJxQzZNTEhGcFlpakUrbklrTHl0cDA2UkhwZ1c1UlBvRXZVdXZX?=
 =?utf-8?B?cUQ2R2dia2U3NjU4Z09HMWJpaE5jTk1lTXI1T2pkZnlLVUFVQmFtbkc3Rzli?=
 =?utf-8?B?Q0UzamZla1lZTmxZYlEwRlU0cTF3Ym5aYWp5QjV2Q2J3TElCTllDQld2cFdh?=
 =?utf-8?B?R1JDR0k3WGlRMjNDc29XellkM0RQYTQ2MmxwaU52c3FWZlJYVnFHNU9udlBx?=
 =?utf-8?B?VkhnamZiYlJZS2NYSmRiN1lsSlRqeVNCSCtmR1FHd0JUTkJscHlpUFkxdVZZ?=
 =?utf-8?B?VEVBUGpXWHNLRHdONUxZUG1abkNtRk9MZEdZay8xWU9oTXAxeG5PUFJDMGtq?=
 =?utf-8?B?RDQrK1VIcStsUnpNYXVQdm04ZzNnWERCNU1JRml5Uklkd2hHSjdhVnFLbHhx?=
 =?utf-8?B?Y21hZ3ZTaFNWbmNTa0QxQTdzdTF6U1BML0V2SzdKeE5RWEViZFBMNjZqOTZP?=
 =?utf-8?B?WGV2ZlpTNFE4cUE1andoTEV1RmxKR0lFc3c1VHBzbW5BZm9Ddm1CWForQlNC?=
 =?utf-8?B?bVNnQzdwOHF1bkxnNjU2Nzh4MkFZTUNUNGVsak52NEFnUWp2NzNkV2dCU3dM?=
 =?utf-8?B?MEllNnZmM2I3bWoyK1Z6OUdMdjNRWE9aS1BjeEZyNUlNZ1F2dXhrSDA4TGJ4?=
 =?utf-8?B?ZDliUHV5UklVKzVMcXB3UTJSTzROVkFLMVRZYkhHT0RGK09pOXd1L2lEckRq?=
 =?utf-8?B?dDl4THh4dDVvY3loTHRiQlVRQXM1YjJGdnZPdEhGUThlU2N2dTE5Y29ITnky?=
 =?utf-8?B?eG9sSnh4M2xadFBUY2dDWGhxQkpESWZ2TGY2OXlKSGJzK1hpNTV5blVMTHNq?=
 =?utf-8?B?TWxFL05mV3pydGFZckhpQnNSNUNlTGNJSmhCbnphTjA2M09TUEV6SU0yeWM3?=
 =?utf-8?B?VjFHREhCQzZSSzlPTUNjSHNHYVlOeElLSXFmU0oyY1RsMWwxaXVsQ0FiTmYz?=
 =?utf-8?B?SnByRnFkMjFvZUxNNWdSNjZQYTBCdGxtNlU3eFMxWUV6SDRqdjlra2YxRm1p?=
 =?utf-8?B?ZUpFYll4VG9SL2Fhbm5ZSzIvZytqUUVDbktpamNOMTh2dzRSVGpwVGpDYTVM?=
 =?utf-8?B?NXFjNU5UeXZwc1pKa1pxQzF6UmtZTldkaG92d1ZWZlhWbzdNcjlYZ2lhWjFw?=
 =?utf-8?B?alVoQVkrVGJoMnhjZGFqeXNoSEswSm0ycC9xM1FLcHp2RlcyYXpxRS9tUzBU?=
 =?utf-8?B?cng2OFU1K3p0OG5MMDhvY2hLd2lwOXB5Ty9jWnhiWWNHcjloZ2d3a1FWampO?=
 =?utf-8?B?QjE5MlIzYVowakRwUXZwQ1JUNllDVG9ZU2RvK3RYM2VXZi94MVEvdHpUdlZy?=
 =?utf-8?B?eUVaK1VxTnIzdkxNM2RFOThjMHh5all6NEl4YXRnU1RJanhqV1dqb3p3S0dE?=
 =?utf-8?B?Zy93Zkh4N21CTmpsMGllTlEraXJwcXRVUW9qeHpIeDVDaVoybURzekE1bEN3?=
 =?utf-8?Q?t+nd18uUBfjNGaigahsW51cWPUsooqnQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2Y2SmxDdm51Tmt1WU4rQmE4WWF6bEN6NS9XcUdManhXcmdjdjRsZGVZQ0Qv?=
 =?utf-8?B?cWV5SG1NcEdYK0lFaDEzVTU2bmt6M2xOUFZkYnd5SUNqWVRlWklldFV0VFcy?=
 =?utf-8?B?bVZRRXhESUpnSldXdUkzakROKzl5SDVad0Y2UzZKQitQdlJXem9mVithYW1q?=
 =?utf-8?B?S3c1VjIwbjZYays1MjFrOXFQT3hTT0dORWRBRnRzK1UrUVNVSDdkSnhlNHpo?=
 =?utf-8?B?RVlaS3p5RzY3OVdFY2hlOXhYZEwvT2ttdkFHcmFCZzNnelROSWVrcFVqWUxQ?=
 =?utf-8?B?UEtoUFpkQktoNXhOK2x3bWYwaG8wbVp4WlpPM2NjLytBWTRqZVNTWXVDakJj?=
 =?utf-8?B?aUE4SW5hSUxzN3h6TjRjOSsvcENQWGFWNkhheXh6cG82ZGVaNWlnSllVVG5F?=
 =?utf-8?B?bVUrWG5CZ1RCeGFuZ1ZWYW5mTHdyM3FvVUw1U0hLcTFnYzNNYnBpNlJ6bXAw?=
 =?utf-8?B?cTdIbkhvSDJOTFhQcXFuS2FWWGN0UFZ6OFhObFhFSEdOelVqTXJTT2hNV3o3?=
 =?utf-8?B?cHN2L2NFUTI5RWcvN290c0hhR2JrYzMyNXROdk9WM2d1YThVRjd1NmlsVFRm?=
 =?utf-8?B?WSt0ejF5bHlKSGRwMWhkcitZYmx4Tm0yTUM1WUdLckU0SnlVYlFpOTVGbTg0?=
 =?utf-8?B?cXRjWUx0UGdXTUtVTWN3QTlSWVZpaFkwKyt3SU9KMW9PODJ5RzhuLzFjZi9a?=
 =?utf-8?B?Q1VqanN0WjE2eisxTHc5ZWFlN1gvNFljZExHZndJem9YTTBiVlBlU3R1KzVj?=
 =?utf-8?B?aUZlUklJdXFtOWs3TEpjSkRoVVZIdUc2Tk5PTTZoNmlnSmI0Wm9qMk91ejdF?=
 =?utf-8?B?R3A5YTZNbTdjVWwwVVBBNGdPRGpHNGdyMG5IWkZlaG1LZjIrbUg0NDRzZVNG?=
 =?utf-8?B?RS9IU3NLeHgwLzFVRTRQdXBSLzBXdEpSQVlJOEpJdDdSQlN1N0VTdFFRNGJ0?=
 =?utf-8?B?cTRheEFkZGpMRDVOZWNiTTVNamxmVHhRa2x5Skc5b0gyMVJseVI1aVlDZG1l?=
 =?utf-8?B?YzdmME90MDZFdnJXaHBMVUszYXMxRU9sdGVwa3NOU2g5TEVaZ0dJYmZLaElS?=
 =?utf-8?B?UWZtOXNTakN0dEhibTJuV0JhUnhOeTNDWUJZbTVoTEU0d0syWnBTTzZLemVG?=
 =?utf-8?B?NllQcUtCeTZRRHJqSDRLVDYwVmZkSDExRjVXQUJvTVN6QjZLK3FKUHNzdFhG?=
 =?utf-8?B?MEdhZ3JMT0FENTQrazErYWQzUVovdkpWbHNTU1UvZms1cElPaE5laC9uSjN5?=
 =?utf-8?B?ejNkT25oa2x3RDR4bVBtM25rendPNVl2OUVqWHFLVFBHbTFVa0dFVTdTSGhz?=
 =?utf-8?B?MTVrSVJyREVDUWY0clVUcDNwc0M1RlpPRkZVYlpibmlCVjRaM3JtWmdxenYr?=
 =?utf-8?B?SWRDR0IzMDZPbG0xUVdZcjNtVDdFbXhrR0pRNGd5a3pmcXlmTnBWR2V2L28r?=
 =?utf-8?B?NjBYNWRRYW9hYXo4NmlDY1FkbDhhMlRqQWQ2THBwZGY4cEVxR3hVcHFZbTBv?=
 =?utf-8?B?ZVdqQmdXcXAwWDFCVlpZekVhL3BpSDdGL3I2OXhnY2ZVa2RJcGUwRVNIZzJr?=
 =?utf-8?B?MkRtZzRrOWZCN0F5MWsrQXhtblJXWmREbTZ6eWl0Vkw3dGFEZEd5RmQrcDZM?=
 =?utf-8?B?TWZLZVBDeWxBajJreVdrSlVJejFkcUVDeHhQamlhMk5KWFdPQ2g4bXZ1enp0?=
 =?utf-8?B?QUhJZlB2Um9EQnNxSFMvTDBLbWZjNzlUWVlBQmd2aDBUZk5UR1lPR2tTOXhD?=
 =?utf-8?B?Z3BPb0xpdlU0M3dCWVZtV3lSemRYM1VNS1FGRW5yWS9XYlNzL3JqdnJjMHdq?=
 =?utf-8?B?ZG9sYXZTRUd2bVJUNU5mRkJkZlh4bCtoSzZISHowVDRvaXIyMUJLUXJ2TjM3?=
 =?utf-8?B?NXI5VStWWlRldjZoZ3p0cU1qZHVOSTBncXdwWHE5Q2tlRHdFM0Vod2NMMkZU?=
 =?utf-8?B?OUVSK1BXTkZXQUtRbFI1aTB6SEp3R1h6VzlUbDkrL0tmVTVDandSMklBS2dH?=
 =?utf-8?B?aTVJd1p3ZDUraHRNRkV1eER4TUlhZ1Rkdm9BQ3UxM3JUeittNDNxcHBIdDdx?=
 =?utf-8?B?bUEySHQwL2dVN1B4NWZLdWtwZHFxbmJUN01MRUJqRUQrTi8rVHVKSXorYzA2?=
 =?utf-8?Q?Pdgg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca7083c-4a7a-40de-ead2-08de02c87c24
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 22:02:03.4319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dKkzBoEDHXsM6XuvwrH22WwEl+WQbjJFpdGpesQHeBUvsiyTTH8G0HGM9Ewzo6CL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4494
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


On 2025-10-03 17:46, Felix Kuehling wrote:
>
> On 2025-10-03 17:18, Philip Yang wrote:
>>
>> On 2025-10-03 17:05, Felix Kuehling wrote:
>>> On 2025-09-26 17:03, Philip Yang wrote:
>>>> zone_device_page_init uses set_page_count to set vram page refcount to
>>>> 1, there is race if step 2 happens between step 1 and 3.
>>>>
>>>> 1. CPU page fault handler get vram page, migrate the vram page to
>>>> system page
>>>> 2. GPU page fault migrate to the vram page, set page refcount to 1
>>>> 3. CPU page fault handler put vram page, the vram page refcount is
>>>> 0 and reduce the vram_bo refcount
>>>> 4. vram_bo refcount is 1 off because the vram page is still used.
>>>>
>>>> Afterwards, this causes use-after-free bug and page refcount warning.
>>>
>>> This implies that migration to RAM and to VRAM of the same range are 
>>> happening at the same time. Isn't that a bigger problem? It means 
>>> someone doing a migration is not holding the prange->migrate_mutex.
>>
>> Migration hold prange->migrate_mutex so we don't have migration to 
>> RAM and VRAM of same range at same time, the issue is in step 3, CPU 
>> page fault handler do_swap_page put_page after 
>> pgmap->ops->migrate_to_ram() returns and during migate_to_vram.
>
> That's the part I don't understand. The CPU page fault handler 
> (svm_migrate_to_ram) is holding prange->migrate_mutex until the very 
> end. Where do we have a put_page for a zone_device page outside the 
> prange->migrate_mutex? Do you have a backtrace?
do_swap_page() {
    .......
         } else if (is_device_private_entry(entry)) {
    ........

             /*
              * Get a page reference while we know the page can't be
              * freed.
              */
             if (trylock_page(vmf->page)) {
                 struct dev_pagemap *pgmap;

                 get_page(vmf->page);
                 pte_unmap_unlock(vmf->pte, vmf->ptl);
                 pgmap = page_pgmap(vmf->page);
                 ret = pgmap->ops->migrate_to_ram(vmf);
                 unlock_page(vmf->page);
                 put_page(vmf->page);

This put_page reduce the vram page refcount to zero if migrate_to_vram 
-> svm_migrate_get_vram_page already call zone_device_page_init set page 
refcount to 1.

put_page must be after unlock_page as put_page may free the page, 
svm_migrate_get_vram_page can lock the page, but page refcount becomes 0.

Regards,

Philip

>
> Regards,
>   Felix
>
>
>>
>> Regards,
>>
>> Philip
>>
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>>
>>>> zone_device_page_init should not use in page migration, change to
>>>> get_page fix the race bug.
>>>>
>>>> Add WARN_ONCE to report this issue early because the refcount bug is
>>>> hard to investigate.
>>>>
>>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 14 +++++++++++++-
>>>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>> index d10c6673f4de..15ab2db4af1d 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>> @@ -217,7 +217,8 @@ svm_migrate_get_vram_page(struct svm_range 
>>>> *prange, unsigned long pfn)
>>>>       page = pfn_to_page(pfn);
>>>>       svm_range_bo_ref(prange->svm_bo);
>>>>       page->zone_device_data = prange->svm_bo;
>>>> -    zone_device_page_init(page);
>>>> +    get_page(page);
>>>> +    lock_page(page);
>>>>   }
>>>>     static void
>>>> @@ -552,6 +553,17 @@ svm_migrate_ram_to_vram(struct svm_range 
>>>> *prange, uint32_t best_loc,
>>>>       if (mpages) {
>>>>           prange->actual_loc = best_loc;
>>>>           prange->vram_pages += mpages;
>>>> +        /*
>>>> +         * To guarent we hold correct page refcount for all prange 
>>>> vram
>>>> +         * pages and svm_bo refcount.
>>>> +         * After prange migrated to VRAM, each vram page refcount 
>>>> hold
>>>> +         * one svm_bo refcount, and vram node hold one refcount.
>>>> +         * After page migrated to system memory, vram page refcount
>>>> +         * reduced to 0, svm_migrate_page_free reduce svm_bo 
>>>> refcount.
>>>> +         * svm_range_vram_node_free will free the svm_bo.
>>>> +         */
>>>> +        WARN_ONCE(prange->vram_pages == 
>>>> kref_read(&prange->svm_bo->kref),
>>>> +              "svm_bo refcount leaking\n");
>>>>       } else if (!prange->actual_loc) {
>>>>           /* if no page migrated and all pages from prange are at
>>>>            * sys ram drop svm_bo got from svm_range_vram_node_new
