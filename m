Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9A2606A319
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 19:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=g8HSImG6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60A8E10E27A;
	Tue, 20 Oct 2026 19:31:56 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010059.outbound.protection.outlook.com [52.101.61.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFD8F10E27A
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 19:31:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wd21KhS84F6YfTv0wvapYhBqK4g0KBy7KWlxFJUkDcmsf5QJhuy086+j8U/TMwsW2hCCZBt4VSrOsEpbKvbfF4uvOxZH34NE4BD/FqYKY3acYkX0XzMxW27jhUuLjW/pbzRcKa+7HbBtdM+MiKebz0anCQJZ9xeNplPAxrSgSuMtgG5qMe4NK2vCQlwruNpsr1AOyR/R3S6iXqQQdaCXtrlGmvJwCA8iUcPMJiPzPE73RGXho02SXdL1uH+PFBurZdvx7lSzZ7gRdqQ0ffol7rbVX18hNgeLBYuMSEOhBMcsT2W77PYWstI7Fux1bx0hn4BI33A/itOKsVvwqXvoRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcxABWtLKBzEbctjNWLZR5VKQ5CrUF2mMQrgiXJ+qgw=;
 b=x8rPNfGHLfyxnvawOoa1clqdFi5rdb7S+Dpld5MdPd/1dISxu6BKXV/beUq1jmdA18eVMamW0IPCL9dSW/VBqHqDTFMXwBlimlaY2t/2FBHQ5S0AzGpUKaqvubLpNmGixWaIu8irOrvwH/m9B/5Y2SxrGBRC8UOfrxl5iU/bSpSdRXM8Id0NymcoC11vRyKyxLb2DCQ9xPFIv+a0jvmujuc/TqGXKzinJccWRaYTHCY+h3PgxPAJ4xbm0oxYLHTZI9YLNHAk7KyD6OxB5RLsBZ1WAwcUifFHY+osGN++GjCTSSBjlWvhDLGR0cwtd+zgsK1NA61A9laReGajuIir5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcxABWtLKBzEbctjNWLZR5VKQ5CrUF2mMQrgiXJ+qgw=;
 b=g8HSImG6UijjffX8KVvJ1i54P+r2OvpNxgr1VX6bjWg0fSD0EykqC87xlKXG4IjecvXVpaXolG+hP0eCU7ytRTmPfl7bXUt3XKj+4JIK+BpCN5t4wck/e6wDlxAvlJ+20UOfljLMnpeyAl59fUAou9GF+3DLHO19yXCgN4VFrac=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by IA4PR12MB9763.namprd12.prod.outlook.com
 (2603:10b6:208:55a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 19:31:36 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 19:31:36 +0000
Message-ID: <856f75c9-f54f-423f-a072-81da34b73e65@amd.com>
Date: Tue, 20 Oct 2026 15:31:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] drm/amdkfd: fix wedged teardown on surprise removal
To: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com
References: <20261020112846.89321-1-olivier.kaloudoff@gmail.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261020112846.89321-1-olivier.kaloudoff@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0015.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::15) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|IA4PR12MB9763:EE_
X-MS-Office365-Filtering-Correlation-Id: b9c40dce-9932-4466-1a33-08df2ee0c14a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 48v2aWcoUnEMwBEfsb4PB796G0wctF4i5LOmhRr1CsQFNmTKC08lwY+F0Um5RMyXPSX1CbMJvdosepxjKvuGui4/QfeNfp5XfcnPktfrLAAmBwGMTD57WPGXcDoanyuoP+FzRnu3+/5kA7titRAjjA3gtW0ADzu1l3ee6DJUAdRcP4oSpojWuBcFRxZD8kInlqz16gIffwyRpqUiRX7PfHw/sKdwWPtBdXjTUQOGQ+qXeHQHr0ImKG1yJyYmmtt+QIDYyvrxrMtlhsWsbTKBY+bcrjHZ1Icc+4sF9ByyqmZj8LLtLRrXsvBaMWHqqTELI7aL2kQJKfn/+O+k9GL5mOGDu7F+aEDh47rUCZBOLEZl6+SiZN6KWMKsNsaCZ9gfNymOyzuyf7pFOTQCWE8zmQNGaaQPmWaF5Q8tEyYWrsjeqDBrO2hJesM/OFacccVhqzYNCwdygDlDik12gQoi8kXTjGXPARMbwwfXAMFFU+p9tfxNlD39Z2juX4zPwwJsiX4b5CCmGOzt1mDiAtLaGhsW8h3EtsC5d4/dAOgwW+2XPU80KyiCQ7bSk4Zd5yJ6WogIt+9pi/hXEhfC0U2rU8y7LGGG6PpU6fWg5lfB40R9UQf0k7mQv6HtxGKqn3vuhSae88A8o5PCxwLNxC+u7700BgrRQOfhujzPX8U/Lzs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXBncHI2L1ZLRXcxSjB3dnppTGpHSG5kQnBiVFZxWVNFS2ZMMVJEZ1RzeFVV?=
 =?utf-8?B?SUZVOGU2M2Iwa3U3VUpTTlRnWWZGbStTdGd6MURDRFJOd1RrRDdFZjZpMTFl?=
 =?utf-8?B?VjBuYS94QTExcjVtRzIwUTlrTEVCNDZGeXZpbTZ5c3UxNDNCeVBwWjR3RkZR?=
 =?utf-8?B?a3oxV3FiejI4cFV2SDZTU0w4ejN2amhuU3V1VS9qeVhEVThkdXNuRUo4NS85?=
 =?utf-8?B?WmloeTgvRWp2bDFkYlhJOXlkZm1wcnJibnY0d1o0Z1NYZ2RWNzB0WXY2Qms3?=
 =?utf-8?B?Y3dsYk0ycGZueVI4TStpWnpSWVphVG92YjdsT2RDWlVLL0o4byt4TzdkLy84?=
 =?utf-8?B?eDVmazFDZytjak13RzhjbGpqSmM0TElCS1p0ZCtHdnVTNGFhTFpuV0hxZ1VR?=
 =?utf-8?B?L0ZWSWkvVzFNOXkyMkNOYUFLZTlGem1KK09NQis3OG9RVVVwRVE2bHZVUmp1?=
 =?utf-8?B?QVNURFRzYjdob2gyR1lRZllSSVZpQU94YU9ySlN0M0txV1doUzB0eHVDMVl3?=
 =?utf-8?B?TUYzamRmZytQdlN1N3E1OXVmY1hSSE5MV1psSytWbEJEVUpEbmN5ZFB0eXdo?=
 =?utf-8?B?bXlmdmlzbmtZdzdQS3lOc29EdUpRZjN3SDlnUnpNVmFId2Ftd0doaUhxbmdW?=
 =?utf-8?B?Q1pqR2R2TFR5eEdHbnNiRUszMkVpS0JmUU1LSTRFYmRabXNaRStnWXpGS2J6?=
 =?utf-8?B?bWVtUHl4cW8wUHl1L3JHNVhIMGVCcU1rSUlURnp4TDBLdnNld2JNMTc4b3Q3?=
 =?utf-8?B?N0Jvam14RjY0eUx0QzhBT1JEV0pLU0ppSk5GeE1hTG1xQW1SVUh6OEdQNWxB?=
 =?utf-8?B?WVNEazBDWERVZDZIcG80UW9PeVNSd3hKL2djaWRVbEFlcnEwY3NiK2c4UU41?=
 =?utf-8?B?T25UR2FYSkFoRjhQOXI4bEhPeWd0M1lZZlBURndDV0g2VmpFdW80bUo0NWcz?=
 =?utf-8?B?V0JTYXh5Z292a0xWaUlCeERtN2lMV0JrRWRvZURhWXJjWndHVTRWQ3RKVGZq?=
 =?utf-8?B?S2RLYW1rZEFUR21WbU9KNkRsdHFMVFF0bHNGUU1KeTFLM0wzZjAzWU5Gd1Bs?=
 =?utf-8?B?Q1ZDcDVuWVdkZFZjMU0wcmRTd3VkYmVDWWtlZ3g1TlQxTHk5UEY0LzNIbkR0?=
 =?utf-8?B?Sjk1ZkZPM3RFUFVaN0RtMFV2RGVlYitqem5lbnRGR0hDTXVHbUdiNE4waDQ4?=
 =?utf-8?B?USt6UWJCVjlxRWdoZEVJL2JZSnFJUFVWNFUwdFJhMlhHY29ZdWJlVGxUak8v?=
 =?utf-8?B?anVMTmlyWFhRaUpNYjFzT2hqU2NBRnVpNnp4Wml0Y1NQbys5M3liKzgzcy9q?=
 =?utf-8?B?ampVcWhMeFQwRVlzc1dmRGY0QUlYZEcvamo1WXhjRUsweVR4QXp5SDZxbGxZ?=
 =?utf-8?B?cnlka295c3U3MjFieXpJV1FXaUFSc25sZVBEMy9kTDY3M3BaSlRhdkRQaGxB?=
 =?utf-8?B?aFk0Mlp4YXFpWW5PY1lGYTQwVEQ5T25ubzRLSjZ3TDdiL0FGRkQ1R3NUSEZC?=
 =?utf-8?B?MGRFRXlkSFlZd1NDUHZhUmpuYnRtRnFURWowZmg1dlFLcXhQWDhmeUx1d2t3?=
 =?utf-8?B?VmEvaFQwRkVvYzlTeDAxb09hQVc1YVUweEtudXUyM3hreld0SEFabUNlcXVo?=
 =?utf-8?B?YXNQdkdRUXM1czhpUEVaRXQ5UkVDZjRuQWxVMWcwamoySW1CdUhUMkpqai9r?=
 =?utf-8?B?NHN1ZldvMGZUbFJ3WlZ4N0tlYlFrTCtjSmYwR2pBbktQSkZRU2FXcDNpSzFX?=
 =?utf-8?B?dGtOK2dqcFJhOGlrTmlZTlF5OFd3aVZZRlpZa1B4aThvcFNVUjVTN2xWN2NB?=
 =?utf-8?B?RjhmT3pQMGFRUnhSRkwzdWN1MkF6d2haZDMrSzhxODJIWGV3Q1BpRWdNNTU5?=
 =?utf-8?B?OGlZMHJIUDR2bFNFUG1HZ2d4UkdZYjhPWGpFREM2QXdKNDA0THlBTjdUOUl3?=
 =?utf-8?B?VVBvL0xTYVU3bFgwQkdxM2R2eUlQTXE0R3ovOHpoRWI0MmdkWHluZ0hKRkJP?=
 =?utf-8?B?L1Yzdk1Cd1lBUEw0eGRHSnpOcW43Nyt1T2h1QTN4ck1CUGorYzFnazBiTVpa?=
 =?utf-8?B?M2ZaUzlRK3lLRk0veEVCSWs5S3pTSVptUklPeGZtWWtzdm9lUk45ZmdjNmdz?=
 =?utf-8?B?VDZqdGt5Z1VWUDkwdThUMFhLdWhmYW1zd0RiZnduYUVQcGdRQU96aE5wanlP?=
 =?utf-8?B?QkduT2lpR0lRay80bTY5T2Q1YU02cVJ5OE41cXFBMGxSNkg1VnVMRVhJNGJo?=
 =?utf-8?B?NkRxdldVTjlQeE5lMzF3eDRURXo0TFQyVTJNOGl0ZitaT2g1clVlYlNreVY5?=
 =?utf-8?B?N3NtN1FFYmd4ZGQrQms4OFhXZ1dRbzhwcDI3OUkvb2tjc0dpVlEvQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c40dce-9932-4466-1a33-08df2ee0c14a
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 19:31:36.2495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2SEn1j37rEAGRJXOL9xFY30yXnPcg9AA8cGkaPNAUQsmhDmykcknAsW9Uqc/Ou3BRscISZ53lkUHT7Qt+RBO3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9763
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-20 07:28, Olivier Kaloudoff wrote:
> Hi Felix,
>
>> Patches 1 and 2 are
>>
>> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
> Thank you — yes please, go ahead and take them independently.
> They're the uncontroversial half of the fix and they unblock the
> drain path even without p3.
>
>> For patch 3 I defer to Christian's expertise. That said, if we don't
>> need the dma_fence_wait_timeout there, then we also don't need to
>> complicate the error handling/unwinding in the migration functions.
> On the timeout we agree — it's gone; the wait is unbounded again.
> But I'd argue for keeping the error propagation and migrate->dst
> rollback anyway: with the orphaning fixed, a fence on a killed
> sched entity completes with an error status (-ESRCH) instead of
> never signaling — so the error path is now genuinely reachable,
> and your original concern still applies: a failed copy must not
> complete as a successful migration.

Sure. The error handling you added in v6 looked pretty clean. It's not 
strictly necessary because the process will get killed after the reset 
anyway. But it's nice to have better robustness also in case any other 
error conditions get introduced in the future.


>
> The reworked p3 is: unbounded dma_fence_wait(), return
> dma_fence_error() of the job fence, both callers release dst
> pages and propagate, drm_dev_enter()/exit() still guarding the
> submit window. I'll post it as v7 3/3 once the entity-lifetime
> question Christian raised is settled — separate reply on that
> thread.
Thanks,
   Felix


>
> Regards,
>    Olivier
