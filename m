Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC7AC282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 14:07:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 539D910E31F;
	Mon, 17 Mar 2025 14:07:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k6G7IXVI";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3902B10E31F
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 14:07:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKBQ8jKWgRg19WkXAwyST44V9u/RFy9Gpc9SDYrpqhW4CxtyICfqq//PXpI2B/HOPdzAlrZoxeOorcv+FPY9JtWyWZLM+KMFZhJTKIOF6o0SPML2Syn4ZkbzlVcpe3H0Et3N5gxSCnCSWMQaBCmuIhP1N+wMeofwksgegjK/pMlkcmWr7hAEAjh4PjIVyeMet8iBrtRLAHzPuvOJwaxL0l/dhOv0PmoRjNK6zwBYsfyGZXZEpAtFLqbKzwPLeLXzEq5s1jynltdpkJUO2wnikzmqjZ1ZyharzUukPt3mkxqdhulYPHFvELqzaHPGpHAJvgnYTGdlBAA2JufNh+Sdug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gjkr+S8aTA7K+emC7UrY6I8BATbO5oclkF3W15oN4ow=;
 b=HP0kFEUHiQYlDYZLeP7xLP5g4iHRItNgM1qXrEnfG86+kCkaesOVO68yqoFxNTs3g+HfxjNsHX176qteodpk6sXgGHtwz5QqaEG7VilcOenXcQWEydwN5TO0ylapGyiY5JEqaq7+0IzU0M15Nwd+eDLXkkZdN15RYkj/aVluskC8s244Oz/IF+WP3a3wXnvM0IqICSaX68mwSDX2jyYsCI/7luziPf8c6n/O/0plGwECyNOlBCbt3umt5D1d31/vi74dtHnlxUBYte7WRNXNIjQ4+jt9BJZ9h9rQWevgo643nziTkKQ4fod9/lmJ2+/6Y4PXEtb6fNEmoAhhdsKjMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gjkr+S8aTA7K+emC7UrY6I8BATbO5oclkF3W15oN4ow=;
 b=k6G7IXVIfLQ6d2iVTcNQt43AJh2Va9LjdbXkcaBSS6wl+bj+53cL1kTfoBtUB5Xi7BZ5kKntCyLQqtJvGgPMrj2e30fIVYakc5W/FjFD+erejtqIEEGj0wZmt+S4uW0qpaayBW+UGJvy0Sv6em/3enuv9vNoKO1uUjN22ogDX6g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB8005.namprd12.prod.outlook.com (2603:10b6:510:26c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 14:07:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8511.026; Mon, 17 Mar 2025
 14:07:05 +0000
Message-ID: <f1e231e7-2d41-4635-90bc-1bb09cc348d7@amd.com>
Date: Mon, 17 Mar 2025 15:06:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Implement WQ_MEM_RECLAIM workqueue for
 Process Isolation
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250317012205.2304294-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250317012205.2304294-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: cccb82f2-688b-4cea-b4de-08dd655cff54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDdhbnhtYVhlYWM1eW9MM1hXRDNpeEtVdWxDb2VRSUpScHBVOXZldEhTZGdX?=
 =?utf-8?B?QndGNCtTdVVUZkJtZnZXM3AwMmZURHl4VDk0bmgzZURpYlpnd0laSk5LRWZp?=
 =?utf-8?B?NGUyR0RQWjJXck5EM2R2WFFoS1dhQ05sc1dZaUs3RzZUZUxkWWl6bnhqUkdK?=
 =?utf-8?B?azBxYi9IcjlJYUdJT05mc2psbS8wVjBheW02bXdKQmFtZGZ6U1k2ci9BTTgw?=
 =?utf-8?B?N1ZDU3kzQmZlWFcrN3N2bjJtaW51YTRlMGpnQkZDako3cXBncjJGR0JPZ080?=
 =?utf-8?B?WnNSZGJtclFRVGozOVNSRmNtb1dmMG9zZEN6S2ZnM0tmYlR6ZGhvL2prUEhr?=
 =?utf-8?B?NkhQOW1iQkNtT0lnR3RQWVFzbElDMHgrTjZ2TGJBQ1YzRWEvcEpzSTRDZ0Er?=
 =?utf-8?B?N2FEOXdLNVpIN2RmMzlxVk9Bclh5bmlDVnFWcW5tdWxubEhUWDArUHA2c2dv?=
 =?utf-8?B?SzMrYS9pN2o2NnRBb01QSHBNblQ3TDhJM0pXRjBuQUpFU0VjRXNpQ2VYRTg2?=
 =?utf-8?B?MkdjY3Y2V0pyQ1VRRVFHOVhtRW1DV2ZQMTlIZTBSZTIxY21PLzI0L0MycmRm?=
 =?utf-8?B?d3NlZFNFRTZGcFk2bHhqM2lCODdrUmRiejVTOWQ3THpFR1NOOHZ0Skh0Ulpo?=
 =?utf-8?B?N0ttRHVlYkdoNitjakpXTlJBZXExaUNqdENuUE5DMVlJQ2htbTVIdFAwd01P?=
 =?utf-8?B?WE5mUWxUWWhKdlgzRjNWS0k4MkRaVERmVisvbDFjTFJDOExRS3NxN2FpY09F?=
 =?utf-8?B?TVExQmh3VnRjQzZhaHI2YmNJSjlHNnlQamNwa3ZuM2VSRU1vYW9CbHFvekpS?=
 =?utf-8?B?U2FhWVRrTFRzODNrN1JMdHAxRWk5V2VmclYzZ3FkVSttbit3bGhxTFpvb1di?=
 =?utf-8?B?VlpONFdzb01WUFEzeGllQUJxb29NaHdLVk00dm9xdzErRGprektxcU55Zlor?=
 =?utf-8?B?L0UwVTg0N2ZDU1ZvMml1UTliZmptWnJZcit1b0UyeXA3ditjYytTc2JQaUls?=
 =?utf-8?B?dU1DL0RvWlBxM01oYWJHemExQ09rK280TTdTSnFPNXE1QVpQQ01WaUNJOWtS?=
 =?utf-8?B?UGlOY3J1NHkwSTljYU50eUlTWTBQNXozU1FFTVlBZ2Z2aGNsd3cxZXhiUy9J?=
 =?utf-8?B?SU5pOFBBdU12Nlh5a3ZhYzRaRDNOQzVYOW0wY0VuQVQxdWNJUGR3ZWpBWm41?=
 =?utf-8?B?akZ2MDdwbEFtdDc5YVMyL2FBd2VSdVEyOUFIRHQ5c3A4N0FZY25LM25ZWm5O?=
 =?utf-8?B?d29LVm4raGg0YzhKUnkvaHo4Y0hpdXJLdnlWMFVQM0p2SkVadDFkSzhBZ3l0?=
 =?utf-8?B?Q2RHTVVLMDcvc2Z1R1o2MnNVc0RiWVZ0bWNzMCtLcEtjd2F3aFdraFBzMElK?=
 =?utf-8?B?Si8xTUZGQnVQQXM2S2RaNmx6RGZuYlB4ZG9QT2creERrRG5qbXViVElRUUNL?=
 =?utf-8?B?YitkYjJ3aFc0MC9BTU1XcEhFRkUraDRiV2EvYmlhVTdzdUQwQUNpTFlBNjVW?=
 =?utf-8?B?b0lpN3l2UUtXUGY5NWtoV2JGU280YXhZU2YxY20yQ1g5VVlZdVExYVB3MnQx?=
 =?utf-8?B?WUdvamJZaFBQZEJFeFhsdG5RWTF3eWJISjcxQmpiVEVLTG84aWxCcFdiRW1v?=
 =?utf-8?B?Qi9aYXQybnV5R09FWnZ5UDQ1V0JwZ0Q4azM1YUo1cjlKWDA1WkpDOGJGTHlm?=
 =?utf-8?B?MFZZck52cTVrdXBLN3lsa29pT0oyejg0aUd5cEh6R0Q3OFd6N3kvOTZoZjNN?=
 =?utf-8?B?RUgyT1RWMEhWYksrSUVJTVRGL2plNUdLakRxUkphSWdsQndvancrVjlzZGE4?=
 =?utf-8?B?dlBpelJsQTd2aWQxVXlNcEJ5MVdUMndsUXdyZzVaR256Ym1xOU02WkZUejJo?=
 =?utf-8?Q?7+BVcY/bU+tuy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTFLZ3RQRm92ZGV0aUVsdmFGdTNhaGpBL2FhcUU1amlhUlp5d3VmQ3BKNUFI?=
 =?utf-8?B?MnNmY3pxS0FVbGlJMGdVR0NGd3MxK214d25idk5BVjEwVlRHdkdNbG1ObGRv?=
 =?utf-8?B?WDM3VjRnT0dIbmg3TExSQVZPZ3lLaGtOZGdKQmNVdHkwaXAzSjFjZllnQ1V0?=
 =?utf-8?B?OENmN2d0THo4QzM1aTl0US9kRGJQeFZBOUVZSzRHZEN3ckdPRzdCRlJOMGtU?=
 =?utf-8?B?OXZXVzQ5cjQ5MVhUK09oVm9QaHlFUXZsTzFLZm80K1VYeU9Nam1KdFd1UWNs?=
 =?utf-8?B?WkJQYzRwaFhvM3pOMUR0bE9YRVVTVDNHN0FKTXpGUXFMK21GSDZrSUtjQzlF?=
 =?utf-8?B?eUZwT2RhRWdtTnRweVVLOFY2ekxzeHBIbVNlc2N3MExlKzByMG9JektJN0Zt?=
 =?utf-8?B?dUlnNHg4eUxFUjBucHY3ZHZFUWtlR3hXUW40cURUSzhnVkhmMFA4QVQydEFh?=
 =?utf-8?B?SWxvRmhvR0UyZjJsOEVVNWtIN1V2K080Yk1TZmZiN2UxTm9yRStqZGcyOFVp?=
 =?utf-8?B?SWcybElSMEErbVROSEFkRzBVT2JkNjNPdGVjMXc3aElsT1B3QUxwQUl4SENh?=
 =?utf-8?B?QzBhTk40Yi9uYUxLZnM3VHpmdDZ0OGtNeDBRQlRUclBLVDlEam5KQjQwWC9J?=
 =?utf-8?B?ZmxvbjFLM1RFWlhSWGNZNDUwTElaMFhDTVNIcHdJTWZKZlI1UTFRTEpjeUpZ?=
 =?utf-8?B?Y21XL1R2OTg0WWdhMHZ0UjkzK2tidXczc1VkUWwyZXd0bFMzcSt2cmhicjFZ?=
 =?utf-8?B?MExSelVtK2RmYVZYNmJJUzNlTkNDcll4TE5tczIzVDM0TmtPYnRyVWdNNXJp?=
 =?utf-8?B?QVI3REczR2syZGlCMnFwTXpEWHNLci9rQ1VKa0x2WjBZZUtPQlJsc3B0Vzda?=
 =?utf-8?B?Mlp3d0FwOXBDU1JhWXdIa0MwL1JITGh0Ums3ZFgzcXI1L0xCVjFzVHpHQWZI?=
 =?utf-8?B?dm51WmhUMkxrMXRpWlI1YUxCS0R5QnZoOUFHVDVOVXFHM0NIM3VobElzUFgy?=
 =?utf-8?B?ZmFrckt1aXFDaEZEL0FNR0hLbUd5bEx2YURVRGxGMjV5WXMvbGJEYlMvdTAw?=
 =?utf-8?B?M1RIdUMxRXhYaGE4RVZtUmVpUVBORjVFNHJITXRoU0R5VXRkSmMxMW15eHd5?=
 =?utf-8?B?R2RhMURhRFVpeGtmcU9jMDZDSEFUcEpTOUt6a0J6aENYNVR5Y2VkTVp0bDhp?=
 =?utf-8?B?VU1NTU1xSHNoSVlBTVhtaEhDVm9wTGk4aEVyNFVvQmFkME9SWDhIcyt0YURE?=
 =?utf-8?B?aTVheTN3RnJaYm5UVHBpN1ZabmxtVmJCMFRZZU1pN3RkbzNMMmJpVldVb213?=
 =?utf-8?B?MkFEbFFoTHlUeTkxZ0lQNTFjZFRaMXoxcVZwcmtLQUZ1TUgrL3RZcE0rVUhw?=
 =?utf-8?B?YkhYamJSeUhLRENtakdGTkRoWWZ4OVBuYmEzU3A4VFIxYWZpWVpObS9NdnFa?=
 =?utf-8?B?Y0hpb3dmVXpFVVRtbDZ6MFNLVDVEQnFkbHlaVTJpNmhLNWU3akpsMWxlWEMy?=
 =?utf-8?B?cTRrZXFVWGUvcXVRcUdwTGdTRGtjT2ZTSFIrRUcwMGk1dXBjREVPandSUjFz?=
 =?utf-8?B?SGd5YmZocGhKWDZVT3E0NldIY3pjQUltOGExL1k2dGYzKy9vbElsQjVlU2hQ?=
 =?utf-8?B?c2tQaDVJUG9Wb2hxb3BjY1ZweVJIeVlmNThyREo0N0lnSFdRK2N4aGxVQmIw?=
 =?utf-8?B?aXc2TTdqNVMra0NNSHhWM2Y2NjN6UnVjdFVPbzVueDVaQWVJOVpZQmtTVENK?=
 =?utf-8?B?SjQrbDg2QmFwZWduenRFTFNBaEYyaE01ZFY2Z0dxQ2FaSkM5K2FaRm1sVmRl?=
 =?utf-8?B?Zk1TYUdxZDhiRGVhQjAxRTVjR0tGSS8zRlIybUxnNFpETmtBVkNNR1IydTBx?=
 =?utf-8?B?aVpOY1E0cjZ6UysvNFBYemdDa05KY2E0cXlUZzNWU2xEazdpbjh3UmQ4b2tm?=
 =?utf-8?B?YXkrUlBUNnYwV25GajZGV0VxYVRDWU5BM2xaMHdWWG9Ibk9ONFJyS00wRUpn?=
 =?utf-8?B?L1h5VmVmN3JPVkUwVlp3QjVDZW1ucndVRWtaREY4VzJwZ1V0WnlwY1hKb0Nh?=
 =?utf-8?B?N1ZQZzlwYWh4UkNLWmRTYktYblVlMGdIeE85NjMyclZReGo1Q1V1dU5YMW8y?=
 =?utf-8?Q?dvdvtK6ftuiBU646OSZHzkWYB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cccb82f2-688b-4cea-b4de-08dd655cff54
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 14:07:05.3509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+hU4690J+NpJ7E6O3thDZQfHYebTEXwnxgXitIYWibTYNVkriksK+TqaEfVvsfS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8005
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

Am 17.03.25 um 02:22 schrieb Srinivasan Shanmugam:
> The `amdgpu_enforce_isolation_wq` is allocated with the WQ_MEM_RECLAIM
> flag to mitigate workqueue flushing related to memory reclamation & to
> ensure proper memory handling during deferred work execution.
>
> Fixes the below:
>
> [ 2333.852549] workqueue: WQ_MEM_RECLAIM gfx_0.0.0:drm_sched_run_job_work=
 [gpu_sched] is flushing !WQ_MEM_RECLAIM events:amdgpu_gfx_enforce_isolatio=
n_handler [amdgpu]
> [ 2333.853008] WARNING: CPU: 10 PID: 6250 at kernel/workqueue.c:3704 chec=
k_flush_dependency+0x124/0x130
> [ 2333.853020] Modules linked in: amdgpu(OE) amdxcp drm_exec gpu_sched dr=
m_buddy drm_ttm_helper ttm drm_suballoc_helper drm_client_lib drm_display_h=
elper cec rc_core drm_kms_helper rfcomm nf_conntrack_netlink xfrm_user xfrm=
_algo xt_addrtype br_netfilter xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_R=
EJECT nf_reject_ipv4 xt_tcpudp nft_compat nft_chain_nat nf_nat nf_conntrack=
 nf_defrag_ipv6 nf_defrag_ipv4 nf_tables libcrc32c nfnetlink bridge stp llc=
 overlay cmac algif_hash algif_skcipher af_alg bnep intel_rapl_msr amd_atl =
intel_rapl_common snd_hda_codec_realtek binfmt_misc snd_hda_codec_generic s=
nd_hda_scodec_component snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg s=
nd_intel_sdw_acpi edac_mce_amd snd_hda_codec snd_hda_core snd_hwdep kvm_amd=
 snd_pcm kvm iwlmvm crct10dif_pclmul snd_seq_midi polyval_clmulni nls_iso88=
59_1 snd_seq_midi_event mac80211 polyval_generic snd_rawmidi ghash_clmulni_=
intel libarc4 sha512_ssse3 joydev sha256_ssse3 snd_seq btusb sha1_ssse3 snd=
_seq_device aesni_intel input_leds btrtl crypto_simd cryptd
> [ 2333.853178]  btintel snd_timer iwlwifi rapl btbcm btmtk gigabyte_wmi m=
xm_wmi snd wmi_bmof k10temp bluetooth ccp cfg80211 soundcore mac_hid sch_fq=
_codel msr parport_pc nfsd ppdev lp parport auth_rpcgss nfs_acl drm lockd g=
race efi_pstore sunrpc ip_tables x_tables autofs4 hid_generic crc32_pclmul =
nvme i2c_piix4 usbhid i2c_smbus hid nvme_core ahci igb libahci dca i2c_algo=
_bit video wmi
> [ 2333.853274] CPU: 10 UID: 0 PID: 6250 Comm: kworker/u48:2 Tainted: G   =
  U  W  OE      6.12.0-amdrelease6dot4forleftoverlocals #27
> [ 2333.853282] Tainted: [U]=3DUSER, [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DU=
NSIGNED_MODULE
> [ 2333.853286] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS PR=
O WIFI/X570 AORUS PRO WIFI, BIOS F36a 02/16/2022
> [ 2333.853291] Workqueue: gfx_0.0.0 drm_sched_run_job_work [gpu_sched]
> [ 2333.853302] RIP: 0010:check_flush_dependency+0x124/0x130
> [ 2333.853307] Code: 55 18 4d 89 e0 48 8d 8b 90 01 00 00 48 c7 c7 10 98 3=
e 8e c6 05 9e 30 7b 02 01 48 8b 70 08 48 81 c6 90 01 00 00 e8 9c 21 fd ff <=
0f> 0b e9 ff fe ff ff e9 98 d9 0c 01 90 90 90 90 90 90 90 90 90 90
> [ 2333.853313] RSP: 0018:ffff9fdd82c07ac0 EFLAGS: 00010086
> [ 2333.853319] RAX: 0000000000000000 RBX: ffff89b840050e00 RCX: 000000000=
0000027
> [ 2333.853323] RDX: ffff89bb6dbf1a88 RSI: 0000000000000001 RDI: ffff89bb6=
dbf1a80
> [ 2333.853327] RBP: ffff9fdd82c07ae8 R08: 0000000000000003 R09: 000000000=
0000001
> [ 2333.853331] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffc=
1864470
> [ 2333.853335] R13: ffff89b856e58d80 R14: 0000000000000000 R15: ffff89bb6=
d808900
> [ 2333.853340] FS:  0000000000000000(0000) GS:ffff89bb6da00000(0000) knlG=
S:0000000000000000
> [ 2333.853344] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2333.853348] CR2: 00005613aff86098 CR3: 0000000337e5c000 CR4: 000000000=
0350ef0
> [ 2333.853353] Call Trace:
> [ 2333.853358]  <TASK>
> [ 2333.853365]  ? show_regs+0x69/0x80
> [ 2333.853373]  ? __warn+0x93/0x1a0
> [ 2333.853382]  ? check_flush_dependency+0x124/0x130
> [ 2333.853389]  ? report_bug+0x18f/0x1a0
> [ 2333.853399]  ? handle_bug+0x63/0xa0
> [ 2333.853407]  ? exc_invalid_op+0x19/0x70
> [ 2333.853414]  ? asm_exc_invalid_op+0x1b/0x20
> [ 2333.853422]  ? __pfx_amdgpu_gfx_enforce_isolation_handler+0x10/0x10 [a=
mdgpu]
> [ 2333.853749]  ? check_flush_dependency+0x124/0x130
> [ 2333.853759]  __flush_work+0xee/0x600
> [ 2333.853766]  ? srso_return_thunk+0x5/0x5f
> [ 2333.853778]  ? srso_return_thunk+0x5/0x5f
> [ 2333.853783]  ? __mutex_lock+0xc08/0xe20
> [ 2333.853792]  ? srso_return_thunk+0x5/0x5f
> [ 2333.853798]  ? trace_hardirqs_on+0x1e/0xd0
> [ 2333.853804]  ? srso_return_thunk+0x5/0x5f
> [ 2333.853815]  cancel_delayed_work_sync+0x71/0x80

That cancel_delayed_work_sync is triggering this warning was a bug in the u=
pstream code.

Question is if we ever call flush_work() on the work item?

Regards,
Christian.

> [ 2333.853823]  amdgpu_gfx_kfd_sch_ctrl+0x14f/0x290 [amdgpu]
> [ 2333.854090]  amdgpu_gfx_enforce_isolation_ring_begin_use+0x1d4/0x3e0 [=
amdgpu]
> [ 2333.854347]  ? cancel_delayed_work_sync+0x4f/0x80
> [ 2333.854356]  gfx_v12_0_ring_begin_use+0x1b/0x30 [amdgpu]
> [ 2333.854618]  amdgpu_ring_alloc+0x48/0x70 [amdgpu]
> [ 2333.854854]  amdgpu_ib_schedule+0x16f/0x8a0 [amdgpu]
> [ 2333.855098]  ? srso_return_thunk+0x5/0x5f
> [ 2333.855105]  amdgpu_job_run+0xad/0x260 [amdgpu]
> [ 2333.855405]  drm_sched_run_job_work+0x258/0x440 [gpu_sched]
> [ 2333.855415]  process_one_work+0x21e/0x680
> [ 2333.855427]  worker_thread+0x190/0x330
> [ 2333.855434]  ? __pfx_worker_thread+0x10/0x10
> [ 2333.855439]  kthread+0xe7/0x120
> [ 2333.855444]  ? __pfx_kthread+0x10/0x10
> [ 2333.855450]  ret_from_fork+0x3c/0x60
> [ 2333.855455]  ? __pfx_kthread+0x10/0x10
> [ 2333.855460]  ret_from_fork_asm+0x1a/0x30
> [ 2333.855474]  </TASK>
> [ 2333.855477] irq event stamp: 103430
> [ 2333.855480] hardirqs last  enabled at (103429): [<ffffffff8da9237a>] i=
rqentry_exit+0x3a/0x90
> [ 2333.855486] hardirqs last disabled at (103430): [<ffffffff8da99e54>] _=
_schedule+0xf84/0x1b00
> [ 2333.855490] softirqs last  enabled at (85926): [<ffffffff8c8fdabd>] __=
irq_exit_rcu+0x7d/0xa0
> [ 2333.855495] softirqs last disabled at (85919): [<ffffffff8c8fdabd>] __=
irq_exit_rcu+0x7d/0xa0
>
> Fixes: afefd6f24502 ("drm/amdgpu: Implement Enforce Isolation Handler for=
 KGD/KFD serialization")
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 +++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 10 ++++++----
>  3 files changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 87062c1adcdf..cbd31c164f9f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -123,6 +123,8 @@
> =20
>  #define GFX_SLICE_PERIOD_MS		250
> =20
> +extern struct workqueue_struct *amdgpu_enforce_isolation_wq;
> +
>  struct amdgpu_gpu_instance {
>  	struct amdgpu_device		*adev;
>  	int				mgpu_fan_enabled;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 7ca2ebdd3c95..562304d703a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -105,6 +105,8 @@ MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
>  #define AMDGPU_VBIOS_SKIP (1U << 0)
>  #define AMDGPU_VBIOS_OPTIONAL (1U << 1)
> =20
> +struct workqueue_struct *amdgpu_enforce_isolation_wq;
> +
>  static const struct drm_driver amdgpu_kms_driver;
> =20
>  const char *amdgpu_asic_name[] =3D {
> @@ -4323,6 +4325,14 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  		adev->gfx.enforce_isolation[i].xcp_id =3D i;
>  	}
> =20
> +	/* Allocate the enforce isolation workqueue with WQ_MEM_RECLAIM */
> +	amdgpu_enforce_isolation_wq =3D alloc_workqueue("amdgpu_enforce_isolati=
on_wq",
> +						      WQ_MEM_RECLAIM, 0);
> +	if (!amdgpu_enforce_isolation_wq) {
> +		dev_err(adev->dev, "Failed to allocate enforcement isolation workqueue=
\n");
> +		return -ENOMEM;
> +	}
> +
>  	INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
> =20
>  	adev->gfx.gfx_off_req_count =3D 1;
> @@ -4821,6 +4831,13 @@ void amdgpu_device_fini_sw(struct amdgpu_device *a=
dev)
>  	if (adev->mman.discovery_bin)
>  		amdgpu_discovery_fini(adev);
> =20
> +	/* Clean up the enforcement isolation workqueue */
> +	if (amdgpu_enforce_isolation_wq) {
> +		flush_workqueue(amdgpu_enforce_isolation_wq);
> +		destroy_workqueue(amdgpu_enforce_isolation_wq);
> +		amdgpu_enforce_isolation_wq =3D NULL;
> +	}
> +
>  	amdgpu_reset_put_reset_domain(adev->reset_domain);
>  	adev->reset_domain =3D NULL;
> =20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 984e6ff6e463..0dabffe395bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1938,8 +1938,9 @@ static void amdgpu_gfx_kfd_sch_ctrl(struct amdgpu_d=
evice *adev, u32 idx,
> =20
>  		if (adev->gfx.kfd_sch_req_count[idx] =3D=3D 0 &&
>  		    adev->gfx.kfd_sch_inactive[idx]) {
> -			schedule_delayed_work(&adev->gfx.enforce_isolation[idx].work,
> -					      msecs_to_jiffies(adev->gfx.enforce_isolation_time[idx]));
> +			queue_delayed_work(amdgpu_enforce_isolation_wq,
> +					   &adev->gfx.enforce_isolation[idx].work,
> +					   msecs_to_jiffies(adev->gfx.enforce_isolation_time[idx]));
>  		}
>  	} else {
>  		if (adev->gfx.kfd_sch_req_count[idx] =3D=3D 0) {
> @@ -1995,8 +1996,9 @@ void amdgpu_gfx_enforce_isolation_handler(struct wo=
rk_struct *work)
>  	}
>  	if (fences) {
>  		/* we've already had our timeslice, so let's wrap this up */
> -		schedule_delayed_work(&adev->gfx.enforce_isolation[idx].work,
> -				      msecs_to_jiffies(1));
> +		queue_delayed_work(amdgpu_enforce_isolation_wq,
> +				   &adev->gfx.enforce_isolation[idx].work,
> +				   msecs_to_jiffies(1));
>  	} else {
>  		/* Tell KFD to resume the runqueue */
>  		if (adev->kfd.init_complete) {

