Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AA5C3064D
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jul 2024 13:35:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70E7C10E228;
	Tue,  2 Jul 2024 13:35:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A0hss/Dv";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E08D10E228
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jul 2024 13:35:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLmSRgiBqxQUDz9CxwMvzTJEJ981Rs7Mzv9WmQWbGz0bC/V5TmfEBIJ3TCDtYnFLOkHwsh2d0gKRRLvFbBcywMuBGyfPcDqOl4pp1tP5iANbxYhY/oIFm8osjd+OfhSfekovPIpquJ1cyy6ujJU+9CSS5DJzky5FbXFTnAhprOPJAf4S4rC14SDefdB7OJzXgnrIldBalCaIXT+Q3xhxqa1Uuw2hTX6VGbkfbqJOMxWxHLmSTo3BvrK4nlm5QYVvMfXPrKZ0wgqgbQHVD9iHZCYn3HxBRupKjKkpQaCjv2CpzjSJvG4abT/wr6AGxiGsl9ax6If5B63FMzre3l1foQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zP+MpHef9gLG/MF0PSOvJhNOzV10vx1h03Ti40C5xR4=;
 b=KgcV6CdjvBvGjhCvZ9hn9tzPi+/4uL3frg1vMH/mpBQMb6F4F6Eajz3OX6INF9QCTjGraOsYgpwG3sKatXOoloy979/m3it2fszgTIN/YB8ObnEui2Jz8P8OfMgJ/nBzTsg6TRH4/cKjfspbh9+mRkaZGMrQmlNQxf8o/GJCLV08wcjq0KSCld4D9rK028DNy6My71u1dIiesTUiaBCpVm0t1mZnAyw95zreFVE78Q6HN62BVMHHlxv6UnFzDPI4xuY4VfF2wAc6CjAYVrgcSlVz6AMDww2SKRnR11CGP2jBiTm9LcDSJFrUTRTsjNpw+OzCByJeNtG56DQB5kxgKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zP+MpHef9gLG/MF0PSOvJhNOzV10vx1h03Ti40C5xR4=;
 b=A0hss/DvNdIicPkTqDc/AJexMnA4G9TAST6ijQODQQ8jC12L53laMwdsW63lu+42sChuBMeuMbTq+LAEiON4V3UZZlJgAqRqDmCZ8/8xY7EP9jDAGwwL0hQgepg42+M47JCsU/RcrbTheksD1JPEoyv7aGvKr4GbVNeUClow3ss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB6887.namprd12.prod.outlook.com (2603:10b6:806:261::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Tue, 2 Jul
 2024 13:35:07 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%6]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 13:35:07 +0000
Message-ID: <636b7a69-f6e4-41b3-886b-1dbe92d15479@amd.com>
Date: Tue, 2 Jul 2024 15:35:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: disallow multiple BO_HANDLES chunks in one
 submit
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20240702132357.327220-1-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240702132357.327220-1-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB6887:EE_
X-MS-Office365-Filtering-Correlation-Id: e1448c14-f68c-4808-7554-08dc9a9bc992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkN0N0puUXFadWF4RDVuMUlWc1Z2OEVxT3Y3eEs1ZzNXYk91T0tPcklTVEhy?=
 =?utf-8?B?dWc0UW1lcEQxdkhRT0ErWFhZaEwyRGxNWlllZyswa05oSXYwdHF1T1JlQTBX?=
 =?utf-8?B?b0Z6YXAzVGJGNjFETTRYUk9XWVBoUXpxV2kveHNTZmpGSkZTQ1pCWFFTZnVm?=
 =?utf-8?B?cjJaUEp3bHN2Z081Rm4rdGFNNjBRVHZReE5TdXgxQ05RWW83L25KTStDemUw?=
 =?utf-8?B?cUl2ZGkyUzhEN0p1ekd4Y1U5dnVmQWx4cEwxSitvQTJJNWo3Wjk2d1hFdE5P?=
 =?utf-8?B?eEh0NE9KcTFQVVpFT29yTERQem15dEN5Rm1YZEFSOEJXVm4xOTZRTTd0bndh?=
 =?utf-8?B?RDVoOUlxVXJmdTNkbnVBTkJkZEJJZVc2cmo3RXJmSGlkd01qS0dZUllxRkta?=
 =?utf-8?B?b2twdUQyMlZPNnZkMUhkY1RlZWZHNlJiNGZtY3BUcm1Ham9qNDlRWUVWZVJL?=
 =?utf-8?B?MTREVm9sKzlYeFc2RklGeURSSEJWOGxESnY4b253UmxTN0psZ3hSM1FlMmRs?=
 =?utf-8?B?U1VaK0VJamlvMVcxLzhMc2F6ZlBySVZHem5oaGIvMW5wemI3Ykpja1ppN012?=
 =?utf-8?B?WFRvTktmZVJnTDBzWk5QRG9FSUNUdERoQkJyL3VJUUxocW9wUDRhSzdlVDFO?=
 =?utf-8?B?cFhvQ01SSTZhYjlpNFF0MHVnYW9ma0VHZmNDbkZPYXpEUnk4UFNNd1N1U2Rq?=
 =?utf-8?B?aTBkb3A3VUhSTmJYanNLTFNxeG5kSCtBSGJ6VTdJdWFtb0FPT1h6MmtsUGdi?=
 =?utf-8?B?cnZyTzNhY1ZDSXpDeHNBVm1WOUk3RTZJVkh2QzFJdnFCcUlLVWFNcFJweEJX?=
 =?utf-8?B?MXpLWHFBNlYyM2VoaFJoR1JQcElSVGNjQzUyR1ZnaVlja1BPNys0SVp6Q0lh?=
 =?utf-8?B?cE9nelFKWE9PbW1maVllT2FvcXhJTENmU05SM0haZStmdEliSjdmaXBBUWpq?=
 =?utf-8?B?ZjNPRlpOcEY1UUYwcHhhNEpFR0h5VmEwY3RzZkgzTGFaWk8xWmNOYnJGdmJG?=
 =?utf-8?B?SUEraUkxWmdFaGxDMXdSVytoVUVVWW44eGlxT1NMa3Rab21jODZOcE8rTzc4?=
 =?utf-8?B?emtZanY2Y2huNTIzQ0N2YjU0Qi92QXpadTF5bXJOLzNGcFNZdVFIMkFROGQz?=
 =?utf-8?B?M0MzMnc5c0NCNFhuWXRqaTB2Y1N0NE1QRGc4ZVE1dmNCTWc2VWxXa0FXOHVx?=
 =?utf-8?B?LzllNTdJK2lBOENkak5CMjFkUmNJZkg3V1dUcGFGbktBSVdZZ25VUW5mNzkx?=
 =?utf-8?B?NEVkdjdXMmJaeHVSUVFUY0dkS3FIZnAzTlBpd0hicXpmYS9RS3dHQXNJVURU?=
 =?utf-8?B?eXVLa0JVOW02a0VYWHRKcjV1ZGpzVWVadFF2MzRMVmVnMzhzdmNhaUN6dUwy?=
 =?utf-8?B?bWx0dlNyTHM2emNPdDBpUG5ocDdXMzVkVU9BNkJoc0hQQlVrZlNHUUt2L21z?=
 =?utf-8?B?VjE4MjQza0tEUExhcXpCdk9tamZpR3VncVhVUXhIek85RmhkbTZHV1RnOUo3?=
 =?utf-8?B?VElEOEtsbHhwU25hOVpYaFZFbUovekdEanl6RFlOc0lFcnp1R01lYnhUaWls?=
 =?utf-8?B?eXZGL0VGMFlOWlVCMlF3R3ovM1pNak9xVkE0TnJheEVRcHNWak92YUNGY0M5?=
 =?utf-8?B?enNET1AycjlwL1JoajdUYmFITzVtYUhndUljSHVmbm05UUFqYW1nUEJvZDFG?=
 =?utf-8?B?OW4rd1dBZy9PbHVXbW9yYm9CT0l1RXFpZ3dQYnRqdE9EOWNXdUJuVncxRXV2?=
 =?utf-8?B?RzY5RWFab2lmV3N0Uzk1SHRBcHYwMkNHVkVENnA2aThIaDhReHlXc3MzdHAx?=
 =?utf-8?B?aGo1WVVUWmUyeGQ5MjhlZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YityMEZjMmYrblEzL3BnZUFoSHZoV244Mnl1UlliczNhR2hESkRRUU5mdkNW?=
 =?utf-8?B?UXBFb1puSFdGZldmU1M2MEcxWDBDZWFoMk5iZ0FJakZwNEJjQWFEMWg3Z29X?=
 =?utf-8?B?UUhtT1VKWDN5SG5MS0ZRMUhNQ2lXZ0JvamhmdXpISXg4ZUtldXBzMnpqY1BR?=
 =?utf-8?B?a3p2Qm9mTHh3K0hjanN1dmhCVStzNldJTkhmRjJXNFJaZDhhc3Y3QnJiMUtC?=
 =?utf-8?B?MjBKRmhwellzTU5yOS9ocmJKSVZEdGhXMHRTVTVxcDhOZENneGkzUFZpd2RP?=
 =?utf-8?B?V2VwRVVwZTBFOGozZGQwMmlxd01COTl3QXJDT3dmbi9wLzBlSThIUjVwdDdZ?=
 =?utf-8?B?Y0FXV012ZTlvUFpqTUE2ZW44cWEwSmFYYmlBNG40Y2h4YnJ4S213d3N2Q0Nh?=
 =?utf-8?B?bnlmTVd3bWkxTlJsZFJpRGtmQ3d3SHUwZnNsamVWdlg3V1VUdTlCanMvKzhx?=
 =?utf-8?B?Q1BKT3NUaXpiU2hWeC9QekxkbXpCZlVKOVVWaG12Z08rbTJ4NkY3b0NhVmk2?=
 =?utf-8?B?b0RVbElYQU14L0loVmdWZ212elo1VE9VMEg4T3hGUU5FVkt2VlhzL2p5eEJL?=
 =?utf-8?B?ZDFmeENxVU40VEM0bjVCUFhFUFVuaHJQQTBnY2VDWWFYMXR3TXFXNDZHLzRs?=
 =?utf-8?B?byt0Y0doVXlMRFIwdXpEMWppNEJpSURjaUM3eStrZGhvYjNWNGY2OUsvSlVG?=
 =?utf-8?B?SGlETnJhY2tHN1JzT2FaSzROMytQM2Y3Mkh6S3ZRNWpnQ0VMZ1pJczhKWmhD?=
 =?utf-8?B?WUtMTWJBcVp4R2JDbGxvQmRsaFZYK0c3MS9lVkhuQmtiMGVYbHFGQzB1WmQv?=
 =?utf-8?B?WmxIdU5DUlMzamtWVmxhTzhEd2IxaVg3dEZXQkkwT21UVVYyOHUzZHc0WVAz?=
 =?utf-8?B?NldxOGdqSW1sQkdNc3NXSlpBKzAraGZaMnhKcG04bWRsT2I2Q2RhOFkrSzZn?=
 =?utf-8?B?c2dQSUNzVDhhYi9hOWw2NVlIcHRXZDZnTjlYS0d4ZlJUVlVZZzdLL0FTdHFI?=
 =?utf-8?B?elV4MUhBM0JhNHQ2dFo0bkVVL1lWT3o0L1dtWUhZSlFsc1Faa2VIY1J3UHdH?=
 =?utf-8?B?eXRsUHo5S1V5bG5wTkN5SkQxSThEbjFpTjY1aEdYU1o1Sk9FOEZXVkxhYXRQ?=
 =?utf-8?B?eVNRK3Zab05TZm9qSk9yOTlseDlZcVpkYmRpWlVZenhsUkdRS20ybUNSb213?=
 =?utf-8?B?cHpkeEYzaFB5L3ZrMitSMXQ3NDR4em9xRTJ4cG1aemh0aFhxb05DL2Z6RnNz?=
 =?utf-8?B?NWVOaFgrR1EyRUJEcThSZVR4Y2lGT2MzR0JEeTZHYXFYeFU3WTJ0cERaRll2?=
 =?utf-8?B?V1VTY2EwTHlQNTBLVjkxMG9jaXJrL01SbzVFajFUeFAxWVZ0dFB5cFBRZHhQ?=
 =?utf-8?B?VVpacnRwZ0pWOVpncEFNQ3pjVWRGSFZJZXNZRmRYTThvWmlPQ1BPckJOdXhW?=
 =?utf-8?B?anFldG51aU5DcGJpQ1VKVWN0YWhHSkZaUCsvTGtjN0pablp6Z1VqVTJnVnFz?=
 =?utf-8?B?Tm9nd3J6NVRPYnZMVVM2VmQ2UW44YTNEWFFKR0huNG5pMVNFblBTSGlxdGRs?=
 =?utf-8?B?REdQMDhxUVB1NTc3Nyt4aEpjVkxsODFoZTZseE9qRUZzK3pRRXI3UlFQcVQz?=
 =?utf-8?B?ZGVSekorNy9yME5CTEJOYWNlK0kvZDgxN3VjdVI1cUdDQ1hiOEpsd0dlcHYy?=
 =?utf-8?B?OS96U0thL2dianRIVVlydkcrY3JlaU9Mcm9RVjIxMy9DVE5PVTBaeWVPR1k4?=
 =?utf-8?B?Vmp6VE90MzBqU1d5dWpIZE5NbGlkYnFvNFkzcWZQWW5VYitTeFdUVHhrcnVk?=
 =?utf-8?B?RzZJNlkxam1Rd1EvV0JRUlk1S0p6bFQ4czFWaDA2aHJrSWlUN01zRDJIcGwv?=
 =?utf-8?B?dVJjQjJ0Z2tJdHU1RFBZckNmNmlxNGdoclZ2QjJMc2FSdE1BbUp2VmNLeTIz?=
 =?utf-8?B?Y2RaRUp4Q1hnOVBCeks4SitUWHpGSk1YUFVVNnRpSmg4TlZMRWVJUzdQRzN4?=
 =?utf-8?B?c044MzVmeFB6dGRSaURwblF0dndNKzJhaXFZQkR4SkZMc3h4RU9RUEVYazUx?=
 =?utf-8?B?YXc5TFZWWEM4dzV4bDZBSTBQWlp6a2JlanFDajBNZ1Voem5EMTg2QU5DeGRj?=
 =?utf-8?Q?otEu8Ug3tZ3BEbb8DWP8Ngj5u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1448c14-f68c-4808-7554-08dc9a9bc992
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 13:35:07.4939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gsvge+38YestoFaHEuiKJcsHm95DboBu7bIC47cQLF5h9V8t+B7TS9kPAMyG4QAt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6887
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

Am 02.07.24 um 15:23 schrieb Pierre-Eric Pelloux-Prayer:
> Before this commit, only submits with both a BO_HANDLES chunk and a
> 'bo_list_handle' would be rejected (by amdgpu_cs_parser_bos).
>
> But if UMD sent a multiple BO_HANDLES, what would happen is:
> * only the last one would be really used
> * all the others would leak memory as amdgpu_cs_p1_bo_handles would
>    overwrite the previous p->bo_list value
>
> This commit rejects submissions with multiple BO_HANDLES chunks to
> match the implementation of the parser.
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index c08dfffae262..69d168d6f35a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -154,6 +154,10 @@ static int amdgpu_cs_p1_bo_handles(struct amdgpu_cs_parser *p,
>   	struct drm_amdgpu_bo_list_entry *info;
>   	int r;
>   
> +	/* Disallow multiple BO_HANDLES chunks. */

Describe why you do something, instead of what you do since that should 
be obvious from the code.

E.g. something like /* Only allow a single BO list to avoid memory leak. */

With that fixed Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.


> +	if (p->bo_list)
> +		return -EINVAL;
> +
>   	r = amdgpu_bo_create_list_entry_array(data, &info);
>   	if (r)
>   		return r;

