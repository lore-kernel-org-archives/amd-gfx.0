Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF00C55ABA
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 16:44:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69F1A10EF4B;
	Wed,  5 Aug 2026 16:44:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W0kPTfRP";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010004.outbound.protection.outlook.com
 [52.101.193.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A80A10EF4B
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 16:44:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aORkYzUHunV3d9cJyqtu8aL8oYxhatGzvGCKELgkTtsbIbbd5itU5nWwEtliG6bEIb870J8SYxarxcRfTtjahFPG8yBb1weW/W11z3EKUmBAyozio025yhmzaiCEeWXe7gVCvtP6SjggpR06zi8x2pUkSTmsZOH7U983xNnB+JCnRTGcQzFSjGQQcbnUQbgE87Dx8/MCwArJvibeZfGadUJuqdKOgExCyTq93LdKUdwLgFlSy4AkH8S9+LC5ecUKBwN/vI+hcxoYI5Q+mT4UahrFV4uP1hrbJ7jMyIqfbOf2dYUP6j3cVQ9iN56UHEF805nF77xBYm2NzXwFikYwlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKBYc9q1Q6jUFGMWvRUhDchnE0+H/XgLcrfWlyrtbPA=;
 b=PTVBX7xdQJx2qFdrX3M8Pm4Jmp2Lyqgvp5HG7Aj7KyLnzEORfCQBCQ5lYIxENRSIOrudF8ja+uGhU8EnC4HLZWliOuhxiIuFViX5d4Ij/Ir7S66qdz7YlZ6Tr01xmdvvZTgERSVSBGvMhMss2408ooASmQBQr+NmTa0UujKiaDOqqvS4Nc4+2HCU/yTSspNTCjQncki2S/IQWQb5Lu0EyTx2F4QPVxJqyZmGf5P+QD15cqHrt+0sLFHzESCQL3A0j/Bx0atvFB0Szw7BZKe33o9Pd4XQfr0UEcmeKh28IQGX1m2Iyf4Pruobo+iEOQuZajV8VP4WItI9YiBbN8wFEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKBYc9q1Q6jUFGMWvRUhDchnE0+H/XgLcrfWlyrtbPA=;
 b=W0kPTfRPoNDxrbO14TgTSp2Sgkr13I7mWjWVd2nfyXUw5qvtAL2npnCRAbYkcr7Wd/Ch5wZ3yPM2Uy6e91pVCvCLKonZj6eN2dSaLGZfHoPWC2maY2Lkyd2GiPP0fb7vdm2AmcJRP2Uu4Tiwxk8HLDeRTLkCoiskneNDiAStMow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by SJ2PR12MB8738.namprd12.prod.outlook.com
 (2603:10b6:a03:548::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 16:44:45 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::7111:7e5c:8508:7852]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::7111:7e5c:8508:7852%8]) with mapi id 15.21.0270.016; Wed, 5 Aug 2026
 16:44:45 +0000
Content-Type: multipart/alternative;
 boundary="------------HTfyGF8YPjaPD6lglKbbnLPE"
Message-ID: <3c6d00a0-6eb3-40f1-be8d-941bbd486fea@amd.com>
Date: Wed, 5 Aug 2026 12:44:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdkfd: preserve VRAM MQD across hibernation via
 unpin/repin
To: "Fan, Shikang" <Shikang.Fan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Zhang, Tiantian (Celine)" <Tiantian.Zhang@amd.com>,
 "Zhao, Victor" <Victor.Zhao@amd.com>,
 "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>
References: <20260803100659.469806-1-shikang.fan@amd.com>
 <04fff61d-2749-4f6c-be82-ba4dec9146b2@amd.com>
 <SA1PR12MB73430C264CAE719BA49B61EDEBD32@SA1PR12MB7343.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <SA1PR12MB73430C264CAE719BA49B61EDEBD32@SA1PR12MB7343.namprd12.prod.outlook.com>
X-ClientProxiedBy: YQZPR01CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::29) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|SJ2PR12MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e1c04fb-a9f6-4534-8690-08def310db1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003|8096899003;
X-Microsoft-Antispam-Message-Info: /LjIp6ktVeUYzZG2S2QYHIjNbFMcqR7D6r2efSK3A0tAjkJ6mOfN6OTHe85v4mX/emIEP1YmGqLTrLNkowWdMciiAvG4SBxEZIjFfbDSsjqnFuOLS00b2291+/88BXnJaI+aHaEpncwbxXgd2CnKwVVXLGrwQro0KBh1+uSZNqiXJP4sK1PVEVU/lmvFM3uvApc4HUQbdbzgo/Ds7vSeuXfymrlNV0dgJsapmT48PJ9MHTyEk3jJnogQzgJxDzHZJFA6J0gF+Vs3ea574mUErLw3FpzqGEoQSrGN1KRGWY9uTDlZxWJ92PjWAYU/km0RQWESwfTaYbx9Uvtmi8JPFtN7oe37qrfLuFwGkGZfk1QJOjbdQfXWHSnT0WWApe90ytj+xD31JIeyc77Lre+e6d/JH35ykNSY4YY8l3pY/AhjZi9TtDhJAyswgx+KaY2JTY7UGWH7Nkti3zl+iSt8oz/Rpki1XMfzP4vEI+fVckXI+w5hDGU9lh6WmI80jwy/+k4dBJuHSyYrTDF9xFAb3e17PgslwhVSrYWQNIzszLIBD4rL2Rnb9BTXm7GWRV0Q5RnG+f0iuiHXiepXOz9C6vmUo05A7NFevM4BqgRUMK4fQlF9/irRlELD0xS9R8W5H+1EpcB7JLzHGBKYGHmrxnnkJl0nZyZCV7eupGGUqGU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZndFN0ZZK2U5cHluM0I5VXBZRWV3ME5hUHpVajR3UkZCQUMrRm5qSDNEc1R3?=
 =?utf-8?B?TmE5TXIvNUhaMjk3eHQ1V0o5S095Q1U1R0lIQ1UxS0dERWR2cGxLL09QRGxD?=
 =?utf-8?B?TXlVc3JiZWxoYnM4YThVMXlwNlZleDErTGlJK0RpNTFRbEprelFITG1nRzMy?=
 =?utf-8?B?UUZpQmpNbTFNR2k1N3hIbGFXL1dzdUNWNlpvQlNhTk1HNEtCdmFLMWxQYldn?=
 =?utf-8?B?S1RQMmZrNVZxdDdlRGgwdVM0YVJDMjFtQ0pabGxXaU5iOVdxc2lleUNydjJU?=
 =?utf-8?B?TFd6RE9ScldIbzRCWmx2NkNLN2ttNm9JQm56Q1dyNnptVDgvNERudjl1cnFU?=
 =?utf-8?B?aFlkUVNOWlYyZlBNeS9LYWFGbExlU29XTk03YldwdERuSm83UGVEUi83ajlm?=
 =?utf-8?B?ZGVHb1RiOXpPMzJRZkdRTWFBV0ZUbS9FZU0yeW9QbGtHbHFEOUE1WU1yeDdG?=
 =?utf-8?B?Z21tR1QvUlZaQ1g5dldQVzR0aWFVc2k1aGdKaWR0eWZNR3JBQy9TZ3hpSkh3?=
 =?utf-8?B?QVB4RXdzd291WE9FWW5ldGZaOFY0ZG5PZktWcFo5eEh3ZVlCc25SZHd3U0RY?=
 =?utf-8?B?VElwZTZHcS9IdjdSVm03QTF6MFcwTXZZMU1XczFoSmlYazNjRDRmQStTQjZO?=
 =?utf-8?B?S2JldWpCb0N2V2pmSFI3V0hveUxxanJDRisvcU5QTXIydUhJM2JzUFdqNTdr?=
 =?utf-8?B?OXVUbS9rM3poNlRkbytrR1IraG5LTE1uMFpLcVhtYzNKYWtBbEllSGJMYnRa?=
 =?utf-8?B?NEQ4cjdHVXc4UWVGcWtUZG81TTFMRFFSeUIvMk15SlNXeTh1d3pTckdoQ2c4?=
 =?utf-8?B?QXdCcjhVQnJDN1Y1VnFaandIZ0lHdy9hVlBhbS80MGRYRzBpdS80anBTdTVP?=
 =?utf-8?B?MEsySVdzK0ZsRVRzQUV6bFgzSzA4Y1drNkFERWxHQWVKUFRzRXo4akVrQmZx?=
 =?utf-8?B?amIwdXgvRmlJa2FhdXNUWUo0dmhUcWxTTXBxQW1xVitzRVRQeHJCS2dvUXhO?=
 =?utf-8?B?NHpXNmZrbkFXQ3JOOWhDL0drckhaKy91OUIwL0QvUDJlV3A4am9aUjhHVmFE?=
 =?utf-8?B?MUlNZEFsQ1JzWXBNaS9vNC9JRnY3eTNaM2pXUXNUUGZMK2JRc1FyOVljakxp?=
 =?utf-8?B?Zk1yanBiaC9NNWNocDlQMGVHWGFrSEtrL1BvT3NVZElLTkl3K1U5a05vb3Yx?=
 =?utf-8?B?TDJiSGZYeEhuRDNjREJJTjA5VFhvdWFYaXhYQWsxenpBb3c2YTEzSHlScXdh?=
 =?utf-8?B?azdick56a0lqbCtkdWkzNTAweGUzS3BKaFNCZGxjeENXWlJuRDUwWG5yWDlE?=
 =?utf-8?B?ZENSZWoxT1dsMDlwWjYrNzBSRUxPYjNCd21wUTA0RDA4Q1NzcDhaK3UzV1FF?=
 =?utf-8?B?U1lGZjFXbm43YlZpS3BlRVdiTEwrS2wvWGg5TmdEOG55N2JJNFFRVmV3ZVFM?=
 =?utf-8?B?VDdHK2o2b0tzb0V5VVdMWFpEbHlmM3ZIWGl3OFF6RGRMZEVCSXpuT3g4Y0hE?=
 =?utf-8?B?T1RiREozd0hPTzAwQXRMbVJ1aEVjcVprbG1YenpRZ0cyQnpyQTFuSEd5YVg4?=
 =?utf-8?B?Z1ZOYk9ZaEdXV3h2SjB4RmpqNEluNFZ5T2NZajNwVUZGRUU4UkE4MjlYUU10?=
 =?utf-8?B?WElYdnBoU3BhRFFMWUNsVkNXUFNsL3VVaVRZSitjZStzTStMZ1BYOTFKNzg3?=
 =?utf-8?B?ZE9rQ25GTzRHa203TXdkQnBTanRtN1d1TXJ6dmJGS3pIMHRjMHJDQ1hSR3dY?=
 =?utf-8?B?UldIRE44NW1Uc2lTd0JqSDlkalFWQWRQa001VkdaT0hPVnA4bFkzUzAzNWRH?=
 =?utf-8?B?WVQzYy9sM0ZPV2tEcTZrSkE0ak1YVVJZb1lBWDhDZ2VZbWNnelpvU1RaQlAv?=
 =?utf-8?B?MmdnUVpEN3RpVlpxNktxV2lPTFlSZGZRTXZRUS9rcm1RTThQNG84OWp4QXg3?=
 =?utf-8?B?NGNhd1IrSHZTSzFzUUFMZlVVdldib1FXZ09NWlBDSitFUWd2TWNoZHlYM1BH?=
 =?utf-8?B?clBuVlpweHVxOXNNN2dKM3J4aTM2Z2pWQ3VkUUhRcy9yNTZDN2NkYlppMVBj?=
 =?utf-8?B?VXduWlQ4cHhSb0dzTmVrUktuS0k2K1I3aG5scTRGS1NxcHpOSitpNHdCL3FZ?=
 =?utf-8?B?ekZNcjNBNFNyZmhld25tTVUxY3Q0cjFlaFJoVmEyRXYxOFJXd2RUalZVSjVH?=
 =?utf-8?B?SytxV1Myc1d1WmNwbHBnYVgwbm83UjJjUTV0dzZOdXU0UnlwbUdJNk4rUnQ2?=
 =?utf-8?B?YzZkb0ZKaG15K0F3bFNYNHl1WDNYZHU4SlN1MEg0bGtNSkE2SW5CYWUyTWhO?=
 =?utf-8?B?TjdRajdxL1pwaDdENGFXc083eTJLZFFaTG5lMlhUNitiRk15aXhlUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1c04fb-a9f6-4534-8690-08def310db1e
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 16:44:45.6502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6yTHLL1lvvcp9chsvcD4nxAhOF94cejyN0Jc+YOc4nrovFm9BRdraBLo6wslUBIpBe2M10GhMzBFO06yFuklGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8738
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

--------------HTfyGF8YPjaPD6lglKbbnLPE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-08-04 23:52, Fan, Shikang wrote:
> AMD General
>
> destroy_queue_nocpsch_locked() calls mqd_mgr->destroy_mqd(mqd_mgr, 
> q->mqd, ...), and on gfx9.4.3 destroy_mqd_v9_4_3() reads the MQD 
> through that pointer  (m->cp_mqd_stride_size) — whose kernel mapping 
> is stale until the repin re-kmaps it. That's why I decided to call 
> repin before destroy_queue.

OK, that doesn't just affect GFX 9.4.3. kgd_gfx_v9_hqd_destroy accesses 
the CPU pointer of the MQD for all GFX9 version. You're right, that's 
only valid while the BO is pinned. It would be safer to set q->mqd = 
NULL in dqm_evict_mqd_bo to catch any accidental access while the BO is 
evicted.

And maybe we can simplify this. The nocpsch mode is not supported in 
production. It only exists for debugging or triaging HWS problems. It 
doesn't support CWSR, so it's especially useless for virtualization. We 
can simply avoid the whole unpinning and repinning dance in nocpsch mode 
(dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS).

Regards,
   Felix


>
> Regards,
> Shikang
>
> ------------------------------------------------------------------------
> *From:* Kuehling, Felix <Felix.Kuehling@amd.com>
> *Sent:* Wednesday, August 5, 2026 6:11 AM
> *To:* Fan, Shikang <Shikang.Fan@amd.com>; 
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, 
> Christian <Christian.Koenig@amd.com>; Yang, Philip 
> <Philip.Yang@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>; 
> SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Zhang, Tiantian 
> (Celine) <Tiantian.Zhang@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>; 
> Zhang, GuoQing (Sam) <GuoQing.Zhang@amd.com>
> *Subject:* Re: [PATCH v4] drm/amdkfd: preserve VRAM MQD across 
> hibernation via unpin/repin
>
> On 2026-08-03 06:06, Shikang Fan wrote:
> > On gfx9 ASICs with mqd_on_vram(), a compute queue MQD lives in a pinned
> > VRAM buffer object. Pinned BOs are skipped by the VRAM eviction done 
> at S4
> > suspend, so the MQD contents are lost across hibernation and the first
> > submission after resume page-faults on a stale MQD.
> >
> > Unpin the MQD BO at suspend so the eviction migrates it into the
> > hibernation image, and pin it back to VRAM on resume. The BO may 
> return at
> > a different VRAM address, so refresh the kernel mapping and cached GPU
> > addresses and patch the MQD self-address via a new update_mqd_gpu_addr()
> > mqd_manager op; skip eviction with a warning if that op is not 
> implemented.
> >
> > v3: use unpin/repin instead of shadowing the MQD into a separate buffer.
> >
> > v4: drop the explicit VRAM->GTT placement at evict (a bare unpin is 
> enough
> > for the eviction pass to move the BO out of VRAM), and also repin at 
> queue
> > destroy. KFD queue restore runs late - user processes thaw before 
> it, and
> > under SR-IOV it is deferred until the VF regains full access - so 
> once the
> > VM has resumed an application can destroy a queue before its MQD BO is
> > repinned, which would otherwise unpin an already-unpinned BO and touch a
> > stale q->mqd.
> >
> > Signed-off-by: Shikang Fan <shikang.fan@amd.com>
> > ---
> >   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 123 ++++++++++++++++++
> >   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |   8 ++
> >   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  40 ++++++
> >   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   6 +
> >   4 files changed, 177 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c 
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > index 51ee9c39104b..5ce4d4cb423c 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > @@ -77,6 +77,7 @@ static struct queue 
> *find_queue_by_doorbell_offset(struct device_queue_manager *
> >   static void set_queue_as_reset(struct device_queue_manager *dqm, 
> struct queue *q,
> >                               struct qcm_process_device *qpd);
> >   static int reset_queues_mes(struct device_queue_manager *dqm, 
> struct queue *q);
> > +static int dqm_repin_mqd_bo(struct device_queue_manager *dqm, 
> struct queue *q);
> >
> >   static inline
> >   enum KFD_MQD_TYPE get_mqd_type_from_queue_type(enum kfd_queue_type 
> type)
> > @@ -1048,6 +1049,11 @@ static int destroy_queue_nocpsch(struct 
> device_queue_manager *dqm,
> >                                q->properties.queue_id);
> >        }
> >
> > +     /* Repin the MQD BO if it is still evicted for hibernation, before
> > +      * destroy_queue_nocpsch_locked() dereferences q->mqd or it is 
> freed.
> > +      */
> > +     dqm_repin_mqd_bo(dqm, q);
> > +
> >        dqm_lock(dqm);
> >        retval = destroy_queue_nocpsch_locked(dqm, qpd, q);
> >        if (!retval)
> > @@ -1254,6 +1260,98 @@ static int resume_single_queue(struct 
> device_queue_manager *dqm,
> >        return 0;
> >   }
> >
> > +/* Unpin the MQD BO at S4 suspend so it is evicted into the 
> hibernation image;
> > + * dqm_repin_mqd_bo() pins it back on resume. Gated on adev->in_s4 
> so runtime
> > + * eviction is untouched.
> > + */
> > +static void dqm_evict_mqd_bo(struct device_queue_manager *dqm, 
> struct queue *q)
> > +{
> > +     struct mqd_manager *mqd_mgr;
> > +     struct amdgpu_bo *bo;
> > +
> > +     if (!dqm->dev->adev->in_s4)
> > +             return;
> > +     if (!mqd_on_vram(dqm->dev->adev))
> > +             return;
> > +     if (q->properties.type != KFD_QUEUE_TYPE_COMPUTE)
> > +             return;
> > +     if (!q->mqd_mem_obj || !q->mqd_mem_obj->mem)
> > +             return;
> > +
> > +     /* Without update_mqd_gpu_addr() the MQD self-address cannot 
> be fixed up
> > +      * after a repin, so skip eviction (with a warning) instead of 
> faulting.
> > +      */
> > +     mqd_mgr = 
> dqm->mqd_mgrs[get_mqd_type_from_queue_type(q->properties.type)];
> > +     if (!mqd_mgr->update_mqd_gpu_addr) {
> > +             dev_warn_once(dqm->dev->adev->dev,
> > +                           "MQD is in VRAM but update_mqd_gpu_addr 
> is not implemented; skipping hibernation eviction\n");
> > +             return;
> > +     }
> > +
> > +     bo = q->mqd_mem_obj->mem;
> > +     if (amdgpu_bo_reserve(bo, false))
> > +             return;
> > +
> > +     amdgpu_bo_unpin(bo);
> > +     amdgpu_bo_unreserve(bo);
> > +     q->needs_mqd_repin = true;
> > +}
> > +
> > +/* Repin the MQD BO to VRAM and refresh the cached mapping and GPU 
> addresses.
> > + * Used both on resume and when a queue is destroyed before resume 
> has repinned
> > + * it. A no-op unless a repin is owed (needs_mqd_repin set).
> > + */
> > +static int dqm_repin_mqd_bo(struct device_queue_manager *dqm, 
> struct queue *q)
> > +{
> > +     struct mqd_manager *mqd_mgr;
> > +     struct amdgpu_bo *bo;
> > +     void *cpu_ptr;
> > +     int r;
> > +
> > +     if (!q->needs_mqd_repin)
> > +             return 0;
> > +     if (!q->mqd_mem_obj || !q->mqd_mem_obj->mem)
> > +             return 0;
> > +
> > +     bo = q->mqd_mem_obj->mem;
> > +     r = amdgpu_bo_reserve(bo, false);
> > +     if (r)
> > +             return r;
> > +     r = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_VRAM);
> > +     if (r) {
> > +             amdgpu_bo_unreserve(bo);
> > +             dev_err(dqm->dev->adev->dev,
> > +                     "Failed to repin MQD of queue %d to VRAM: %d\n",
> > +                     q->properties.queue_id, r);
> > +             return r;
> > +     }
> > +     /* The BO may have moved; refresh the kernel mapping and gpu 
> address. */
> > +     amdgpu_bo_kunmap(bo);
> > +     r = amdgpu_bo_kmap(bo, &cpu_ptr);
> > +     amdgpu_bo_unreserve(bo);
> > +     if (r) {
> > +             dev_err(dqm->dev->adev->dev,
> > +                     "Failed to remap MQD of queue %d: %d\n",
> > +                     q->properties.queue_id, r);
> > +             return r;
> > +     }
> > +
> > +     q->mqd_mem_obj->cpu_ptr = cpu_ptr;
> > +     q->mqd_mem_obj->gpu_addr = amdgpu_bo_gpu_offset(bo);
> > +     q->gart_mqd_addr = q->mqd_mem_obj->gpu_addr;
> > +     q->mqd = cpu_ptr;
> > +
> > +     mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
> > +                     q->properties.type)];
> > +     if (mqd_mgr->update_mqd_gpu_addr)
> > +             mqd_mgr->update_mqd_gpu_addr(mqd_mgr, q->mqd,
> > + q->mqd_mem_obj,
> > + &q->properties);
> > +
> > +     q->needs_mqd_repin = false;
> > +     return 0;
> > +}
> > +
> >   static int evict_process_queues_nocpsch(struct 
> device_queue_manager *dqm,
> >                                        struct qcm_process_device *qpd)
> >   {
> > @@ -1297,6 +1395,8 @@ static int evict_process_queues_nocpsch(struct 
> device_queue_manager *dqm,
> >                         * maintain a consistent eviction state
> >                         */
> >                        ret = retval;
> > +
> > +             dqm_evict_mqd_bo(dqm, q);
> >        }
> >
> >   out:
> > @@ -1350,6 +1450,8 @@ static int evict_process_queues_cpsch(struct 
> device_queue_manager *dqm,
> >                                goto out;
> >                        }
> >                }
> > +
> > +             dqm_evict_mqd_bo(dqm, q);
> >        }
> >
> >        if (!dqm->dev->kfd->shared_resources.enable_mes) {
> > @@ -1429,6 +1531,10 @@ static int 
> restore_process_queues_nocpsch(struct device_queue_manager *dqm,
> >                if (WARN_ONCE(!dqm->sched_running, "Restore when 
> stopped\n"))
> >                        continue;
> >
> > +             retval = dqm_repin_mqd_bo(dqm, q);
> > +             if (retval && !ret)
> > +                     ret = retval;
> > +
> >                retval = mqd_mgr->load_mqd(mqd_mgr, q->mqd, q->pipe,
> >                                       q->queue, &q->properties, mm);
> >                if (retval && !ret)
> > @@ -1489,6 +1595,13 @@ static int 
> restore_process_queues_cpsch(struct device_queue_manager *dqm,
> >                q->properties.is_active = true;
> >                increment_queue_count(dqm, &pdd->qpd, q);
> >
> > +             retval = dqm_repin_mqd_bo(dqm, q);
> > +             if (retval) {
> > +                     dev_err(dev, "Failed to repin MQD for queue %d\n",
> > +                             q->properties.queue_id);
> > +                     goto out;
> > +             }
> > +
> >                if (dqm->dev->kfd->shared_resources.enable_mes) {
> >                        retval = add_queue_mes(dqm, q, qpd);
> >                        if (retval) {
> > @@ -2760,6 +2873,8 @@ static int destroy_queue_cpsch(struct 
> device_queue_manager *dqm,
> >                                qpd->pqm->process, q->device,
> >                                -1, false, NULL, 0);
> >
> > +     /* Repin the MQD BO if still evicted for hibernation, before 
> it is freed. */
> > +     dqm_repin_mqd_bo(dqm, q);
> >        mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
> >
> >        return retval;
> > @@ -2827,6 +2942,12 @@ static int process_termination_nocpsch(struct 
> device_queue_manager *dqm,
> >                q = list_first_entry(&qpd->queues_list, struct queue, 
> list);
> >                mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
> >                                q->properties.type)];
> > +             /* Repin the MQD BO before destroy_queue_nocpsch_locked()
> > +              * dereferences q->mqd; drop the DQM lock as reserve 
> may sleep.
> > +              */
> > +             dqm_unlock(dqm);
> > +             dqm_repin_mqd_bo(dqm, q);
> > +             dqm_lock(dqm);
>
> You don't really need to repin before calling destroy_queue. You need it
> before freeing the MQD. That is done a few lines below in another
> section that already drops the DQM lock. You can just move repin into
> that section and avoid some unnecessary churn dropping and re-taking the
> lock repeatedly. I think it's OK to do that after
> destroy_queue_nocpsch_locked, because that function doesn't actually
> free the queue struct.
>
> With that fixed, the patch is
>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
>
>
> >                ret = destroy_queue_nocpsch_locked(dqm, qpd, q);
> >                if (ret)
> >                        retval = ret;
> > @@ -3017,6 +3138,8 @@ static int process_termination_cpsch(struct 
> device_queue_manager *dqm,
> >                list_del(&q->list);
> >                qpd->queue_count--;
> >                dqm_unlock(dqm);
> > +             /* Repin the MQD BO if still evicted for hibernation, 
> before free. */
> > +             dqm_repin_mqd_bo(dqm, q);
> >                mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
> >                dqm_lock(dqm);
> >        }
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h 
> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> > index 59eff3389d39..38b46b696243 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> > @@ -117,6 +117,14 @@ struct mqd_manager {
> >                                const void *ctl_stack_src,
> >                                const u32 ctl_stack_size);
> >
> > +     /* Patch the MQD's cached self GPU address after the MQD BO 
> has moved
> > +      * (e.g. repinned to a new VRAM location on hibernation 
> resume). The MQD
> > +      * contents are otherwise preserved.
> > +      */
> > +     void    (*update_mqd_gpu_addr)(struct mqd_manager *mm, void *mqd,
> > +                                    struct kfd_mem_obj *mqd_mem_obj,
> > +                                    struct queue_properties *p);
> > +
> >   #if defined(CONFIG_DEBUG_FS)
> >        int     (*debugfs_show_mqd)(struct seq_file *m, void *data);
> >   #endif
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c 
> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> > index 75e5a9f67d50..b95720198e28 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> > @@ -476,6 +476,20 @@ static void restore_mqd(struct mqd_manager *mm, 
> void **mqd,
> >        qp->is_active = 0;
> >   }
> >
> > +static void update_mqd_gpu_addr(struct mqd_manager *mm, void *mqd,
> > +                             struct kfd_mem_obj *mqd_mem_obj,
> > +                             struct queue_properties *qp)
> > +{
> > +     struct v9_mqd *m = get_mqd(mqd);
> > +     uint64_t addr = mqd_mem_obj->gpu_addr;
> > +
> > +     m->cp_mqd_base_addr_lo = lower_32_bits(addr);
> > +     m->cp_mqd_base_addr_hi = upper_32_bits(addr);
> > +
> > +     if (mqd_on_vram(mm->dev->adev))
> > +             amdgpu_device_flush_hdp(mm->dev->adev, NULL);
> > +}
> > +
> >   static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
> >                        struct kfd_mem_obj *mqd_mem_obj, uint64_t 
> *gart_addr,
> >                        struct queue_properties *q)
> > @@ -860,6 +874,30 @@ static void restore_mqd_v9_4_3(struct 
> mqd_manager *mm, void **mqd,
> >        if (mqd_on_vram(mm->dev->adev))
> >                amdgpu_device_flush_hdp(mm->dev->adev, NULL);
> >   }
> > +
> > +static void update_mqd_gpu_addr_v9_4_3(struct mqd_manager *mm, void 
> *mqd,
> > +                                    struct kfd_mem_obj *mqd_mem_obj,
> > +                                    struct queue_properties *qp)
> > +{
> > +     struct kfd_mem_obj xcc_mqd_mem_obj;
> > +     uint64_t offset = mm->mqd_stride(mm, qp);
> > +     u32 num_xcc = NUM_XCC(mm->dev->xcc_mask);
> > +     struct v9_mqd *m;
> > +     int xcc;
> > +
> > +     memset(&xcc_mqd_mem_obj, 0x0, sizeof(struct kfd_mem_obj));
> > +
> > +     for (xcc = 0; xcc < num_xcc; xcc++) {
> > +             get_xcc_mqd(mqd_mem_obj, &xcc_mqd_mem_obj, offset * xcc);
> > +             m = get_mqd(mqd + offset * xcc);
> > +             m->cp_mqd_base_addr_lo = 
> lower_32_bits(xcc_mqd_mem_obj.gpu_addr);
> > +             m->cp_mqd_base_addr_hi = 
> upper_32_bits(xcc_mqd_mem_obj.gpu_addr);
> > +     }
> > +
> > +     if (mqd_on_vram(mm->dev->adev))
> > +             amdgpu_device_flush_hdp(mm->dev->adev, NULL);
> > +}
> > +
> >   static int destroy_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
> >                   enum kfd_preempt_type type, unsigned int timeout,
> >                   uint32_t pipe_id, uint32_t queue_id)
> > @@ -1017,6 +1055,7 @@ struct mqd_manager *mqd_manager_init_v9(enum 
> KFD_MQD_TYPE type,
> >                        mqd->get_wave_state = get_wave_state_v9_4_3;
> >                        mqd->checkpoint_mqd = checkpoint_mqd_v9_4_3;
> >                        mqd->restore_mqd = restore_mqd_v9_4_3;
> > +                     mqd->update_mqd_gpu_addr = 
> update_mqd_gpu_addr_v9_4_3;
> >                } else {
> >                        mqd->init_mqd = init_mqd;
> >                        mqd->load_mqd = load_mqd;
> > @@ -1025,6 +1064,7 @@ struct mqd_manager *mqd_manager_init_v9(enum 
> KFD_MQD_TYPE type,
> >                        mqd->get_wave_state = get_wave_state;
> >                        mqd->checkpoint_mqd = checkpoint_mqd;
> >                        mqd->restore_mqd = restore_mqd;
> > +                     mqd->update_mqd_gpu_addr = update_mqd_gpu_addr;
> >                }
> >                break;
> >        case KFD_MQD_TYPE_HIQ:
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > index bcb929002839..0dc4f76a36d4 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > @@ -637,6 +637,12 @@ struct queue {
> >        void *gang_ctx_cpu_ptr;
> >
> >        struct amdgpu_bo *wptr_bo_gart;
> > +
> > +     /* The VRAM-resident MQD BO (mqd_on_vram()) is unpinned at S4 
> suspend so
> > +      * TTM evicts it into the hibernation image, and repinned on 
> resume. Set
> > +      * while the BO is unpinned so the resume path knows to repin it.
> > +      */
> > +     bool needs_mqd_repin;
> >   };
> >
> >   enum KFD_MQD_TYPE {
--------------HTfyGF8YPjaPD6lglKbbnLPE
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2026-08-04 23:52, Fan, Shikang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:SA1PR12MB73430C264CAE719BA49B61EDEBD32@SA1PR12MB7343.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;">@scope { P {margin-top:0;margin-bottom:0;} }</style>
      <div>
        <div style="font-family: Calibri; text-align: left; margin-left: 5pt; font-size: 10pt;">
          AMD General</div>
        <br>
      </div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
        destroy_queue_nocpsch_locked() calls
        mqd_mgr-&gt;destroy_mqd(mqd_mgr, q-&gt;mqd, ...), and on
        gfx9.4.3 destroy_mqd_v9_4_3() reads the MQD through that pointer
        &nbsp;(m-&gt;cp_mqd_stride_size) — whose kernel mapping is stale
        until the repin re-kmaps it. That's why I decided to call repin
        before destroy_queue.</div>
    </blockquote>
    <p>OK, that doesn't just affect GFX 9.4.3. kgd_gfx_v9_hqd_destroy
      accesses the CPU pointer of the MQD for all GFX9 version. You're
      right, that's only valid while the BO is pinned. It would be safer
      to set q-&gt;mqd = NULL in dqm_evict_mqd_bo to catch any
      accidental access while the BO is evicted.</p>
    <p>And maybe we can simplify this. The nocpsch mode is not supported
      in production. It only exists for debugging or triaging HWS
      problems. It doesn't support CWSR, so it's especially useless for
      virtualization. We can simply avoid the whole unpinning and
      repinning dance in nocpsch mode (dqm-&gt;sched_policy ==
      KFD_SCHED_POLICY_NO_HWS).</p>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:SA1PR12MB73430C264CAE719BA49B61EDEBD32@SA1PR12MB7343.namprd12.prod.outlook.com">
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
        <br>
      </div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
        Regards,</div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
        Shikang</div>
      <div style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt;">
        <br>
      </div>
      <hr style="display: inline-block; width: 98%;">
      <div style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt;">
        <b>From:</b> Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a><br>
        <b>Sent:</b> Wednesday, August 5, 2026 6:11 AM<br>
        <b>To:</b> Fan, Shikang <a class="moz-txt-link-rfc2396E" href="mailto:Shikang.Fan@amd.com">&lt;Shikang.Fan@amd.com&gt;</a>;
        <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
        <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
        <b>Cc:</b> Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>;
        Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Yang, Philip
        <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>; Limonciello, Mario
        <a class="moz-txt-link-rfc2396E" href="mailto:Mario.Limonciello@amd.com">&lt;Mario.Limonciello@amd.com&gt;</a>; SHANMUGAM, SRINIVASAN
        <a class="moz-txt-link-rfc2396E" href="mailto:SRINIVASAN.SHANMUGAM@amd.com">&lt;SRINIVASAN.SHANMUGAM@amd.com&gt;</a>; Zhang, Tiantian (Celine)
        <a class="moz-txt-link-rfc2396E" href="mailto:Tiantian.Zhang@amd.com">&lt;Tiantian.Zhang@amd.com&gt;</a>; Zhao, Victor
        <a class="moz-txt-link-rfc2396E" href="mailto:Victor.Zhao@amd.com">&lt;Victor.Zhao@amd.com&gt;</a>; Zhang, GuoQing (Sam)
        <a class="moz-txt-link-rfc2396E" href="mailto:GuoQing.Zhang@amd.com">&lt;GuoQing.Zhang@amd.com&gt;</a><br>
        <b>Subject:</b> Re: [PATCH v4] drm/amdkfd: preserve VRAM MQD
        across hibernation via unpin/repin
      </div>
      <div style="font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 12pt;">
        <br>
      </div>
      <div style="font-size: 11pt;">On 2026-08-03 06:06, Shikang Fan
        wrote:<br>
        &gt; On gfx9 ASICs with mqd_on_vram(), a compute queue MQD lives
        in a pinned<br>
        &gt; VRAM buffer object. Pinned BOs are skipped by the VRAM
        eviction done at S4<br>
        &gt; suspend, so the MQD contents are lost across hibernation
        and the first<br>
        &gt; submission after resume page-faults on a stale MQD.<br>
        &gt;<br>
        &gt; Unpin the MQD BO at suspend so the eviction migrates it
        into the<br>
        &gt; hibernation image, and pin it back to VRAM on resume. The
        BO may return at<br>
        &gt; a different VRAM address, so refresh the kernel mapping and
        cached GPU<br>
        &gt; addresses and patch the MQD self-address via a new
        update_mqd_gpu_addr()<br>
        &gt; mqd_manager op; skip eviction with a warning if that op is
        not implemented.<br>
        &gt;<br>
        &gt; v3: use unpin/repin instead of shadowing the MQD into a
        separate buffer.<br>
        &gt;<br>
        &gt; v4: drop the explicit VRAM-&gt;GTT placement at evict (a
        bare unpin is enough<br>
        &gt; for the eviction pass to move the BO out of VRAM), and also
        repin at queue<br>
        &gt; destroy. KFD queue restore runs late - user processes thaw
        before it, and<br>
        &gt; under SR-IOV it is deferred until the VF regains full
        access - so once the<br>
        &gt; VM has resumed an application can destroy a queue before
        its MQD BO is<br>
        &gt; repinned, which would otherwise unpin an already-unpinned
        BO and touch a<br>
        &gt; stale q-&gt;mqd.<br>
        &gt;<br>
        &gt; Signed-off-by: Shikang Fan <a class="moz-txt-link-rfc2396E" href="mailto:shikang.fan@amd.com">&lt;shikang.fan@amd.com&gt;</a><br>
        &gt; ---<br>
        &gt;&nbsp;&nbsp; .../drm/amd/amdkfd/kfd_device_queue_manager.c | 123
        ++++++++++++++++++<br>
        &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h&nbsp; |&nbsp;&nbsp; 8 ++<br>
        &gt;&nbsp;&nbsp; .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c&nbsp;&nbsp; |&nbsp; 40
        ++++++<br>
        &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 6 +<br>
        &gt;&nbsp;&nbsp; 4 files changed, 177 insertions(+)<br>
        &gt;<br>
        &gt; diff --git
        a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
        &gt; index 51ee9c39104b..5ce4d4cb423c 100644<br>
        &gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
        &gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
        &gt; @@ -77,6 +77,7 @@ static struct queue
        *find_queue_by_doorbell_offset(struct device_queue_manager *<br>
        &gt;&nbsp;&nbsp; static void set_queue_as_reset(struct
        device_queue_manager *dqm, struct queue *q,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct qcm_process_device
        *qpd);<br>
        &gt;&nbsp;&nbsp; static int reset_queues_mes(struct device_queue_manager
        *dqm, struct queue *q);<br>
        &gt; +static int dqm_repin_mqd_bo(struct device_queue_manager
        *dqm, struct queue *q);<br>
        &gt;&nbsp;&nbsp;<br>
        &gt;&nbsp;&nbsp; static inline<br>
        &gt;&nbsp;&nbsp; enum KFD_MQD_TYPE get_mqd_type_from_queue_type(enum
        kfd_queue_type type)<br>
        &gt; @@ -1048,6 +1049,11 @@ static int
        destroy_queue_nocpsch(struct device_queue_manager *dqm,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.queue_id);<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
        &gt;&nbsp;&nbsp;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Repin the MQD BO if it is still evicted for
        hibernation, before<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * destroy_queue_nocpsch_locked() dereferences
        q-&gt;mqd or it is freed.<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; dqm_repin_mqd_bo(dqm, q);<br>
        &gt; +<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_lock(dqm);<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval = destroy_queue_nocpsch_locked(dqm, qpd, q);<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!retval)<br>
        &gt; @@ -1254,6 +1260,98 @@ static int
        resume_single_queue(struct device_queue_manager *dqm,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
        &gt;&nbsp;&nbsp; }<br>
        &gt;&nbsp;&nbsp;<br>
        &gt; +/* Unpin the MQD BO at S4 suspend so it is evicted into
        the hibernation image;<br>
        &gt; + * dqm_repin_mqd_bo() pins it back on resume. Gated on
        adev-&gt;in_s4 so runtime<br>
        &gt; + * eviction is untouched.<br>
        &gt; + */<br>
        &gt; +static void dqm_evict_mqd_bo(struct device_queue_manager
        *dqm, struct queue *q)<br>
        &gt; +{<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct mqd_manager *mqd_mgr;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *bo;<br>
        &gt; +<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!dqm-&gt;dev-&gt;adev-&gt;in_s4)<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!mqd_on_vram(dqm-&gt;dev-&gt;adev))<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.type != KFD_QUEUE_TYPE_COMPUTE)<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_mem_obj || !q-&gt;mqd_mem_obj-&gt;mem)<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
        &gt; +<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Without update_mqd_gpu_addr() the MQD self-address
        cannot be fixed up<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * after a repin, so skip eviction (with a warning)
        instead of faulting.<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =
        dqm-&gt;mqd_mgrs[get_mqd_type_from_queue_type(q-&gt;properties.type)];<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!mqd_mgr-&gt;update_mqd_gpu_addr) {<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn_once(dqm-&gt;dev-&gt;adev-&gt;dev,<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;MQD is in VRAM but
        update_mqd_gpu_addr is not implemented; skipping hibernation
        eviction\n&quot;);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
        &gt; +<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; bo = q-&gt;mqd_mem_obj-&gt;mem;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_bo_reserve(bo, false))<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
        &gt; +<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unpin(bo);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(bo);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;needs_mqd_repin = true;<br>
        &gt; +}<br>
        &gt; +<br>
        &gt; +/* Repin the MQD BO to VRAM and refresh the cached mapping
        and GPU addresses.<br>
        &gt; + * Used both on resume and when a queue is destroyed
        before resume has repinned<br>
        &gt; + * it. A no-op unless a repin is owed (needs_mqd_repin
        set).<br>
        &gt; + */<br>
        &gt; +static int dqm_repin_mqd_bo(struct device_queue_manager
        *dqm, struct queue *q)<br>
        &gt; +{<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct mqd_manager *mqd_mgr;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *bo;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; void *cpu_ptr;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
        &gt; +<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;needs_mqd_repin)<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!q-&gt;mqd_mem_obj || !q-&gt;mqd_mem_obj-&gt;mem)<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
        &gt; +<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; bo = q-&gt;mqd_mem_obj-&gt;mem;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_bo_reserve(bo, false);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_VRAM);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(bo);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(dqm-&gt;dev-&gt;adev-&gt;dev,<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to repin MQD of queue %d to
        VRAM: %d\n&quot;,<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.queue_id, r);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* The BO may have moved; refresh the kernel mapping
        and gpu address. */<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_kunmap(bo);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_bo_kmap(bo, &amp;cpu_ptr);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(bo);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(dqm-&gt;dev-&gt;adev-&gt;dev,<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to remap MQD of queue %d:
        %d\n&quot;,<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.queue_id, r);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
        &gt; +<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_mem_obj-&gt;cpu_ptr = cpu_ptr;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd_mem_obj-&gt;gpu_addr =
        amdgpu_bo_gpu_offset(bo);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;gart_mqd_addr = q-&gt;mqd_mem_obj-&gt;gpu_addr;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;mqd = cpu_ptr;<br>
        &gt; +<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =
        dqm-&gt;mqd_mgrs[get_mqd_type_from_queue_type(<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.type)];<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (mqd_mgr-&gt;update_mqd_gpu_addr)<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;update_mqd_gpu_addr(mqd_mgr,
        q-&gt;mqd,<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        q-&gt;mqd_mem_obj,<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &amp;q-&gt;properties);<br>
        &gt; +<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;needs_mqd_repin = false;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
        &gt; +}<br>
        &gt; +<br>
        &gt;&nbsp;&nbsp; static int evict_process_queues_nocpsch(struct
        device_queue_manager *dqm,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
        qcm_process_device *qpd)<br>
        &gt;&nbsp;&nbsp; {<br>
        &gt; @@ -1297,6 +1395,8 @@ static int
        evict_process_queues_nocpsch(struct device_queue_manager *dqm,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * maintain a consistent eviction
        state<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = retval;<br>
        &gt; +<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_evict_mqd_bo(dqm, q);<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
        &gt;&nbsp;&nbsp;<br>
        &gt;&nbsp;&nbsp; out:<br>
        &gt; @@ -1350,6 +1450,8 @@ static int
        evict_process_queues_cpsch(struct device_queue_manager *dqm,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
        &gt; +<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_evict_mqd_bo(dqm, q);<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
        &gt;&nbsp;&nbsp;<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
        (!dqm-&gt;dev-&gt;kfd-&gt;shared_resources.enable_mes) {<br>
        &gt; @@ -1429,6 +1531,10 @@ static int
        restore_process_queues_nocpsch(struct device_queue_manager *dqm,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (WARN_ONCE(!dqm-&gt;sched_running,
        &quot;Restore when stopped\n&quot;))<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
        &gt;&nbsp;&nbsp;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval = dqm_repin_mqd_bo(dqm, q);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval &amp;&amp; !ret)<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = retval;<br>
        &gt; +<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval = mqd_mgr-&gt;load_mqd(mqd_mgr,
        q-&gt;mqd, q-&gt;pipe,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;queue,
        &amp;q-&gt;properties, mm);<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval &amp;&amp; !ret)<br>
        &gt; @@ -1489,6 +1595,13 @@ static int
        restore_process_queues_cpsch(struct device_queue_manager *dqm,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.is_active = true;<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; increment_queue_count(dqm, &amp;pdd-&gt;qpd,
        q);<br>
        &gt;&nbsp;&nbsp;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval = dqm_repin_mqd_bo(dqm, q);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval) {<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(dev, &quot;Failed to repin MQD for
        queue %d\n&quot;,<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.queue_id);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
        &gt; +<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
        (dqm-&gt;dev-&gt;kfd-&gt;shared_resources.enable_mes) {<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval = add_queue_mes(dqm, q, qpd);<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval) {<br>
        &gt; @@ -2760,6 +2873,8 @@ static int destroy_queue_cpsch(struct
        device_queue_manager *dqm,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;pqm-&gt;process,
        q-&gt;device,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -1, false, NULL, 0);<br>
        &gt;&nbsp;&nbsp;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Repin the MQD BO if still evicted for hibernation,
        before it is freed. */<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; dqm_repin_mqd_bo(dqm, q);<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;free_mqd(mqd_mgr, q-&gt;mqd,
        q-&gt;mqd_mem_obj);<br>
        &gt;&nbsp;&nbsp;<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return retval;<br>
        &gt; @@ -2827,6 +2942,12 @@ static int
        process_termination_nocpsch(struct device_queue_manager *dqm,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q =
        list_first_entry(&amp;qpd-&gt;queues_list, struct queue, list);<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =
        dqm-&gt;mqd_mgrs[get_mqd_type_from_queue_type(<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.type)];<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Repin the MQD BO before
        destroy_queue_nocpsch_locked()<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * dereferences q-&gt;mqd; drop the DQM lock
        as reserve may sleep.<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_unlock(dqm);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_repin_mqd_bo(dqm, q);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_lock(dqm);<br>
        <br>
        You don't really need to repin before calling destroy_queue. You
        need it<br>
        before freeing the MQD. That is done a few lines below in
        another<br>
        section that already drops the DQM lock. You can just move repin
        into<br>
        that section and avoid some unnecessary churn dropping and
        re-taking the<br>
        lock repeatedly. I think it's OK to do that after<br>
        destroy_queue_nocpsch_locked, because that function doesn't
        actually<br>
        free the queue struct.<br>
        <br>
        With that fixed, the patch is<br>
        <br>
        Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a><br>
        <br>
        <br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = destroy_queue_nocpsch_locked(dqm, qpd,
        q);<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval = ret;<br>
        &gt; @@ -3017,6 +3138,8 @@ static int
        process_termination_cpsch(struct device_queue_manager *dqm,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_del(&amp;q-&gt;list);<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;queue_count--;<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_unlock(dqm);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Repin the MQD BO if still evicted for
        hibernation, before free. */<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_repin_mqd_bo(dqm, q);<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr-&gt;free_mqd(mqd_mgr, q-&gt;mqd,
        q-&gt;mqd_mem_obj);<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_lock(dqm);<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
        &gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h<br>
        &gt; index 59eff3389d39..38b46b696243 100644<br>
        &gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h<br>
        &gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h<br>
        &gt; @@ -117,6 +117,14 @@ struct mqd_manager {<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const void *ctl_stack_src,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const u32 ctl_stack_size);<br>
        &gt;&nbsp;&nbsp;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Patch the MQD's cached self GPU address after the
        MQD BO has moved<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * (e.g. repinned to a new VRAM location on
        hibernation resume). The MQD<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * contents are otherwise preserved.<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp; (*update_mqd_gpu_addr)(struct mqd_manager
        *mm, void *mqd,<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_mem_obj
        *mqd_mem_obj,<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
        queue_properties *p);<br>
        &gt; +<br>
        &gt;&nbsp;&nbsp; #if defined(CONFIG_DEBUG_FS)<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp; (*debugfs_show_mqd)(struct seq_file *m, void
        *data);<br>
        &gt;&nbsp;&nbsp; #endif<br>
        &gt; diff --git
        a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c<br>
        &gt; index 75e5a9f67d50..b95720198e28 100644<br>
        &gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c<br>
        &gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c<br>
        &gt; @@ -476,6 +476,20 @@ static void restore_mqd(struct
        mqd_manager *mm, void **mqd,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qp-&gt;is_active = 0;<br>
        &gt;&nbsp;&nbsp; }<br>
        &gt;&nbsp;&nbsp;<br>
        &gt; +static void update_mqd_gpu_addr(struct mqd_manager *mm,
        void *mqd,<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_mem_obj
        *mqd_mem_obj,<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue_properties *qp)<br>
        &gt; +{<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct v9_mqd *m = get_mqd(mqd);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint64_t addr = mqd_mem_obj-&gt;gpu_addr;<br>
        &gt; +<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;cp_mqd_base_addr_lo = lower_32_bits(addr);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;cp_mqd_base_addr_hi = upper_32_bits(addr);<br>
        &gt; +<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (mqd_on_vram(mm-&gt;dev-&gt;adev))<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_flush_hdp(mm-&gt;dev-&gt;adev,
        NULL);<br>
        &gt; +}<br>
        &gt; +<br>
        &gt;&nbsp;&nbsp; static void init_mqd_hiq(struct mqd_manager *mm, void
        **mqd,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_mem_obj *mqd_mem_obj,
        uint64_t *gart_addr,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue_properties *q)<br>
        &gt; @@ -860,6 +874,30 @@ static void restore_mqd_v9_4_3(struct
        mqd_manager *mm, void **mqd,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mqd_on_vram(mm-&gt;dev-&gt;adev))<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_flush_hdp(mm-&gt;dev-&gt;adev,
        NULL);<br>
        &gt;&nbsp;&nbsp; }<br>
        &gt; +<br>
        &gt; +static void update_mqd_gpu_addr_v9_4_3(struct mqd_manager
        *mm, void *mqd,<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_mem_obj
        *mqd_mem_obj,<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
        queue_properties *qp)<br>
        &gt; +{<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_mem_obj xcc_mqd_mem_obj;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint64_t offset = mm-&gt;mqd_stride(mm, qp);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; u32 num_xcc = NUM_XCC(mm-&gt;dev-&gt;xcc_mask);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct v9_mqd *m;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; int xcc;<br>
        &gt; +<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;xcc_mqd_mem_obj, 0x0, sizeof(struct
        kfd_mem_obj));<br>
        &gt; +<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; for (xcc = 0; xcc &lt; num_xcc; xcc++) {<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_xcc_mqd(mqd_mem_obj,
        &amp;xcc_mqd_mem_obj, offset * xcc);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m = get_mqd(mqd + offset * xcc);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;cp_mqd_base_addr_lo =
        lower_32_bits(xcc_mqd_mem_obj.gpu_addr);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m-&gt;cp_mqd_base_addr_hi =
        upper_32_bits(xcc_mqd_mem_obj.gpu_addr);<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
        &gt; +<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (mqd_on_vram(mm-&gt;dev-&gt;adev))<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_flush_hdp(mm-&gt;dev-&gt;adev,
        NULL);<br>
        &gt; +}<br>
        &gt; +<br>
        &gt;&nbsp;&nbsp; static int destroy_mqd_v9_4_3(struct mqd_manager *mm,
        void *mqd,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum kfd_preempt_type type, unsigned int
        timeout,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t pipe_id, uint32_t queue_id)<br>
        &gt; @@ -1017,6 +1055,7 @@ struct mqd_manager
        *mqd_manager_init_v9(enum KFD_MQD_TYPE type,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;get_wave_state =
        get_wave_state_v9_4_3;<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;checkpoint_mqd =
        checkpoint_mqd_v9_4_3;<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;restore_mqd =
        restore_mqd_v9_4_3;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;update_mqd_gpu_addr =
        update_mqd_gpu_addr_v9_4_3;<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;init_mqd = init_mqd;<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;load_mqd = load_mqd;<br>
        &gt; @@ -1025,6 +1064,7 @@ struct mqd_manager
        *mqd_manager_init_v9(enum KFD_MQD_TYPE type,<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;get_wave_state =
        get_wave_state;<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;checkpoint_mqd =
        checkpoint_mqd;<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;restore_mqd = restore_mqd;<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;update_mqd_gpu_addr =
        update_mqd_gpu_addr;<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case KFD_MQD_TYPE_HIQ:<br>
        &gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
        &gt; index bcb929002839..0dc4f76a36d4 100644<br>
        &gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
        &gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
        &gt; @@ -637,6 +637,12 @@ struct queue {<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *gang_ctx_cpu_ptr;<br>
        &gt;&nbsp;&nbsp;<br>
        &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *wptr_bo_gart;<br>
        &gt; +<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* The VRAM-resident MQD BO (mqd_on_vram()) is
        unpinned at S4 suspend so<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * TTM evicts it into the hibernation image, and
        repinned on resume. Set<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * while the BO is unpinned so the resume path knows
        to repin it.<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
        &gt; +&nbsp;&nbsp;&nbsp;&nbsp; bool needs_mqd_repin;<br>
        &gt;&nbsp;&nbsp; };<br>
        &gt;&nbsp;&nbsp;<br>
        &gt;&nbsp;&nbsp; enum KFD_MQD_TYPE {<br>
      </div>
    </blockquote>
  </body>
</html>

--------------HTfyGF8YPjaPD6lglKbbnLPE--
