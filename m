Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF34CCF9F8
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 17:02:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28F8D10E2EA;
	Wed,  5 Nov 2025 17:02:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UBmDQZjK";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011059.outbound.protection.outlook.com [52.101.62.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4363510E2EA
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 17:02:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=miW5HEo9DSj28pn13iRMY4U3FIrgIvmsS+odabrx9LKagb3bXS9C2QUwC0q3xeiG54B6U7be1rloEO9QEDiEGLklLN8ppy/fRx1/qxtvqgzzKUeXUH7RTOqm/TkOszuuvxJcPE4v1Bq1gnTnYkn2/j/OI91HH/DWkLiFuXe4uG1o8tVVLxytA4yTebMNvHMnflTp/l/n/BV5rTTzXnZl/xunBr7QgXMIL/OqCe0Qex3np8zCFUuwiL14xtYkmJVviEqR0XDSGDUtwu/+T7ZaseJigj7EcW0LadnuuUPgnD5fKLwG+teSJ2P05dZMBlOSHosxevVJvvXtLdPWUjPXjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MWjolANRa499qhfbUw0n1eNVCikn8IR6UYxHgARF+w=;
 b=f85TiRub/LgBzeqf/YeONXSrCiukwM+rIOdgHTQfxO0rpNIzn5zNA6+QFwCk13sBFfm+pqcA0qWOfUhK3Vc0xEp+ualXZyr/mqSZKG02adO1nR1dX/MEPDLg0lPEhXQbsIeoP0mO6m8ig6fvhxk/SJ2DMmlPCYrG0ueLIkpjHRPEblP9C6VU/4hAmvwlp1DI8T+HT1Sgo/b1/nOnrLd78HhWMGit5h1i9Wf3brYe1ho6EUsilUrJDxaziRTWMeD1z1K9oTbTNvfgQgQyZfMQPHwDfM8LoCpyn5cugKsOz1GXNe9CeJxcyDQ1Kp7fj8LX/kzGPDxu820Xw5dAxalQVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MWjolANRa499qhfbUw0n1eNVCikn8IR6UYxHgARF+w=;
 b=UBmDQZjK7aU+xOmRssgqzCpgYO9LHG6nJ60TtLdpsu23EMMGTkCuBW1DqCXWLHWGD8gOkGquvfFmAEaRPBou2GGijqxgm3Ju+gp/355YuAt5t2PfiS1JXReUCWs6KUYciQgtzv4ae4M7Hzz3ZBUfG0Cp5VFI90HuHUag6h9v9pw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 SJ5PPF4D350AC80.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::993)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 17:02:26 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 17:02:25 +0000
Message-ID: <17b23439-8064-40b5-bf8f-b424bd087e63@amd.com>
Date: Wed, 5 Nov 2025 11:02:23 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: Fix GPU mappings for APU after prefetch
To: Philip Yang <yangp@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Philip Yang <Philip.Yang@amd.com>
References: <20251103222127.3095970-1-Harish.Kasiviswanathan@amd.com>
 <d6a6ae67-6b7b-4cb0-83f2-d1f2624c2f4d@amd.com>
 <81e2acea-f45f-cda8-66a1-3c37f3aa2e9c@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <81e2acea-f45f-cda8-66a1-3c37f3aa2e9c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:806:130::27) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|SJ5PPF4D350AC80:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a47282-e598-4770-83d3-08de1c8d17b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UHBQUy81WU9QY2twV1pYNHJTSWsvTWtEVURGdXNvMUxMSFlPU1ZRSVNPWTNX?=
 =?utf-8?B?WWM0QTF0UTlHRkVPdHEveUhEa0FMMTNad3FMTU9TazQyOE1zbEFlZWVSemp4?=
 =?utf-8?B?VURkeStSeUMvcE5abitiL2pkWTBDbE81d2dlMkVaOWtuU3FEaWU1SlY2Wi9y?=
 =?utf-8?B?UFB5Z09EVEg0ZHdqNnIvY2pJaEZDL2VFUlNqaW9LZHJkTlZFbUY1TG56bmNV?=
 =?utf-8?B?Sm9zM215Q2xoc0JsZWo0dXFjcVFYbGRmN0lTSmpldFYxVGpkRC9hOFlZaExr?=
 =?utf-8?B?UHEvOENKakl5YXRrY0FFdEVqSEUxS3k0RkFobVZvRGNwTzRaM3lyb2tndVhu?=
 =?utf-8?B?QnY2WTVRcklnaTQ5RTJ5MFRvaUx6bmJUendPNjhYVU90dHU5eDRXOEhyRnhQ?=
 =?utf-8?B?KzY3a1lORjhNMHRBa3VPTHpGcENXcDJrYXdMZlVuakhvK2VGc1RWZ3prWG9P?=
 =?utf-8?B?c1FmNUxIS1JWcUE3MDR3TDN5YVBpQXprZm51L0lYTVk3RE1mNU9TZzEwUzVr?=
 =?utf-8?B?RFFtUzlNU3JvSTZLT2NFOHVBL2hsa1dkdVBpUnZZYjRMalM1aUtiYTU4aVdt?=
 =?utf-8?B?cWQxZHBValFYdmxYNTUwWHpWMVR0US9jK01td1didE9HQkRqZzVKaDM2T2hs?=
 =?utf-8?B?NGFLL1FFcEhxOFFwcnBZMHF1WXZrOVNPWXFIcTMrVG5CSlNEb2RJZllzQXB0?=
 =?utf-8?B?azhtSllwK2J2NnRkenAwRk04YzJQNURMMlE5SGNLUVFhVWtURVd6OWNRYW8z?=
 =?utf-8?B?dmJPK2s1c2FsRGsyN3pPck1SNzBhcmNZN1pIVHlyYUNNS0dkWW1UOWMxZ1Ji?=
 =?utf-8?B?eGpCbmJ0V1BERmxjWUl2dzk2UmJHSG1zZG83N0YxdjZmOUYwOUkrZWMxRUtV?=
 =?utf-8?B?VE0wU0FJZ29FcC92aGdNN0FKQ1VoNE1oUFROTnY0QnlHamZrNHM5ak8zaXh6?=
 =?utf-8?B?L2RMcElvTkNyY2xZbkI5OGpNbmV0Y295UXNjSjA2TGFTRzhPUmV4VlhIVXlY?=
 =?utf-8?B?VUZ6QkdYU2dmQm54RFkrdmdWeWdxb25UMWo2elFyUmMraXV5VjU1eUJKQXhP?=
 =?utf-8?B?SU9JcmZ1Y29CVVk0cE1aeHplZjE4S0lqLzJNRnMrNldwbnczL3hTN0J1MnFK?=
 =?utf-8?B?c0VDTnZqRUpwNFg5cTNwb2F3c0l0RXFnREJGbDVvQ1dXc2V2N1ZOMkl4SVR6?=
 =?utf-8?B?U2hJbXI5OUI3OExKV2FrUzdIdW8xOU5PS3Jyc0NJa1pXandycWxUU05tUVRB?=
 =?utf-8?B?THRWQ2hqT3Z6ZkRkN2t6WEdYUFFIb0NTL01nempMd25oOHkwcERTU0llK1J0?=
 =?utf-8?B?cGhPUGh6UUZQTDhiZXNMcmpkRkwvWWlGa1dKRkJMSC9VK1Fud210WTY4ZHRz?=
 =?utf-8?B?aWliWGZCWTdsT1QwWTJnZ0NSZE4rNWZpbEQ1eUZLMjNDSm9BaGJORGZ2cTBp?=
 =?utf-8?B?QXRaTC92UXpFNHBxeE5Md3R2ZEVYYVNCUEYrdE9aZlR4UnNSZTVwdFJtaGU4?=
 =?utf-8?B?MDNHS25EWUhmLzRwTlI4dVREM3FEdjRxLy9ScUJOdzVYMlV3OGphaEN6cFZT?=
 =?utf-8?B?ZG9yUitPbHNFdUwrNEpZRjZXR1I2c2d5SW0vdm5tUGZ1ZEJUMitncU5xSlRY?=
 =?utf-8?B?a2w3WWo1ay9oUURLeTVqdEhQQzJvWGxvRnU5QStQc0hwU2lXMWQwOHl0eWg2?=
 =?utf-8?B?UXpwS2FMdU1abEdUczQwd2poclo0NzhORDhzYkJQZ1A5Z3hhYS9weS95b0xv?=
 =?utf-8?B?Z0hwejlqcC9pczN6VG9haVNFMDZpZk5nc0VGVlB0L2dkT20rdjR6OTlkMGJk?=
 =?utf-8?B?cW1wcXNqSmM2a2UrL0ZiMFpSOCsyTm83UWhWS2JkN3JBdFZKTHpiWlg1WHJt?=
 =?utf-8?B?c3IyS0lmQUJMYjZsTTFGSjdVa1M2bHl0WXRDczVGL0JncWszd1Z0Rm5IZTRP?=
 =?utf-8?Q?+xM0s5uVgXeSJelGZeUj1csTn3QqTm3x?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?em5CWFRPUnJqdkNuSVhXaGJEWXYzTld0cVFvbmdWazJjNk42MTNMTkRhWmRn?=
 =?utf-8?B?S3dCUkV5MVozOHM3dDdKeEx0TjM0SnVHdU84ZStXSy9FMVFsdkk1MUNEektY?=
 =?utf-8?B?WmdzeGZ4KzkxZlZZd0dqRWs4aHVSTDFMOXRkQUFjNFpoeGJNUTVUMUM4bDNM?=
 =?utf-8?B?VUp6TXExY1VUaDJTTFBFcDlxVDlEb251M1k4Ym1uRW9ZL0lwenQ5OWRndURw?=
 =?utf-8?B?cHNhWkhwVDhUUzhXSHZsazZCNjFKMXFiU3g5RTlwWWc3OTJRRFZpMlVTUlpj?=
 =?utf-8?B?aHByUFhSYkQ2NWJWR3krTEoxR0tXRjM1WU43ZHM1Wm9RZFQwZ0MyY2huWjNC?=
 =?utf-8?B?WXZmWWxyekQ1V2VxUU9kNVduNGUyNXJnQWk4eDh4TDNEcEcrdVF4ZjlublFL?=
 =?utf-8?B?SFVBa2VYR1BzRno1dnA1bzJ2MjMyU1IxazEyQW1ETkR0RnB1dVdhYmxyL1ZT?=
 =?utf-8?B?aUFhOVBQNDZycm5vTU9CYTJpSGIxYVJvZFNMaVAvV0VBMWc2SXJUaWwzK2ha?=
 =?utf-8?B?RXRicHdDRGw0UC8rTEtmVjVlMVRuYVkwOTB0WERpZG9BR0ZpV0tzTjRiSjBw?=
 =?utf-8?B?U3ZNb3N3Q3RKV29jVEVCRnFvdTFlQXNsSUZabHRvQU5VKzQyeFpRdDc2anVn?=
 =?utf-8?B?WHFCdGxrQ28rdkc4SVk4b1dhU1JMeU5FWVYyV0ZjUlNnRWNkdVFyeFpKeEVU?=
 =?utf-8?B?V1R6OWRGcE93MXc0YWI0aFBHbXgzWFhhb3lkODZUUEpPdnExb1hLSkJBTnli?=
 =?utf-8?B?cEJZeDYzVzByWVhzS1h1Vm5tRFcybU9oSnBiMGY2Q25BUXZYVUhBQzZoaHY2?=
 =?utf-8?B?LzljV2FHTVMrb2t0Z2lHWXR5WCtqWGxidytLQTM0SVBqVjNLRThNSGlkSUhp?=
 =?utf-8?B?aEtoaUFFNEY3M0cySHJtN0t2L0dzZElDRGZ0MU00VlNnK3YwUWNOY1ZsTlhl?=
 =?utf-8?B?eEtGbFFmR0c4Q2pnZGQ1bzZtaThlQmM1aEFGd0xnS2RncDRiZ1VyNWlXcUV1?=
 =?utf-8?B?anF1NDdIemJHR0VnTFhuY1VFbnh0cmU3U0FyQ0dTeHg2S29FazFEYzF3MThY?=
 =?utf-8?B?Q0ZVTG1TL2k4WkRmUUg5MGZGVkwzSk9SL1E4RFN6SUpPWHE4R1N2Qnpya2ZW?=
 =?utf-8?B?Q2VMNnl3b0VtTkVHc1ZlYSswVkFQMUdzU2dGOXRBUFpieDE3TnY2WlRNRG02?=
 =?utf-8?B?L3BneHVGazlZb1duSGVuTUY0NGJUS0N3eUM2VU5MaHNZK0QwNkhodG5NUXI1?=
 =?utf-8?B?czBSWGJkUC9LZTFCT2RYc2ZucFBKdlJSVHo5K2VYeFROZlpNY2Zva0xpMXg5?=
 =?utf-8?B?OHZCZElTT283RkJVbGZES1pMNmNpUmY1M2FPd2NiSXBGNGc2K1pON2Vob2F5?=
 =?utf-8?B?Sjd2SGFxWEVxZWp6M0tGYnJQVjJXdVJid2sydnR0WmpwU2VuZmozeU5YVVZK?=
 =?utf-8?B?L2poYVVoZUtQbE4xMGZWUjlXRi9PUjZ1aTZpbTZxVFFkVGVqUnBUcFRDMmpV?=
 =?utf-8?B?S3FRQ0JCNXhWeDBzTktDTjBMRGZLc0o2Tzl1b2svZFNuT29RRnpKbTFBNGh2?=
 =?utf-8?B?STNwN1RBbnZuc3lxdW4rZ21vYnMrM0xNTGJCcHFLbHBDTkJhcGdWN1h4bk5D?=
 =?utf-8?B?MFJ4K2RtSy9aVFpicjBobGxGam5leVhQWTAxcWluTGNhU0NJTFlkVGt6MFh2?=
 =?utf-8?B?T21YM3JFZ2E1MldKd1duL3NBUFZHVDNndk1BQ3lJTVZpaXZZVGFaL29VcGZl?=
 =?utf-8?B?L21GN0xaUVQyQXFrVzBQa25sMmttYVh4WVgrR2RVcE5DcGRtTWZKbHBQajJk?=
 =?utf-8?B?aFFGMHFUK2RUcXFiT1JnQVFpSVZJQ0JUc0E2c0hRbGhGTHdaMFhrM202d0VS?=
 =?utf-8?B?WG1SUDNWb3VOc0IyM3VURi9XdDRqQXAzSkczODZhMkY4S0V2d05qYUU4N1Z5?=
 =?utf-8?B?cjJTb2JBOFU0N2hseEpTTWJ5KzhFQ2k3cE9NeXU0NE9oRzdEUFA4eHUwVjdn?=
 =?utf-8?B?ZnlrL1ovbXBhS1owTkY0Y25aNkg0SEF5TjgySG14eTVlOVdmTUpodkhoQlVq?=
 =?utf-8?B?ZjZaRFVPYlk5TFVaQnd3cjZ3V3FvQmh6Zm1OOStmTG5qYmxVMWtJendNdkpP?=
 =?utf-8?Q?GNr4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a47282-e598-4770-83d3-08de1c8d17b8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 17:02:24.9733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6VmIQRbj3t4Uw8INrf3RwjVX0o7WtfGjgink9yKLltNLqSEWgHNEuSkgKBF9g3E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4D350AC80
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


On 11/4/2025 10:35 AM, Philip Yang wrote:
>
> On 2025-11-03 18:25, Chen, Xiaogang wrote:
>>
>>
>> On 11/3/2025 4:21 PM, Harish Kasiviswanathan wrote:
>>> Fix the following corner case:-
>>>   Consider a 2M huge page SVM allocation, followed by prefetch call for
>>> the first 4K page. The whole range is initially mapped with single PTE.
>>> After the prefetch, this range gets split to first page + rest of the
>>> pages. Currently, the first page mapping is not updated on MI300A (APU)
>>> since page hasn't migrated. However, after range split PTE mapping 
>>> it not
>>> valid.
>>>
>>> Fix this by forcing page table update for the whole range when prefetch
>>> is called.  Calling prefetch on APU doesn't improve performance. If all
>>> it deteriotes. However, functionality has to be supported.
>>>
>>> v2: Use apu_prefer_gtt as this issue doesn't apply to APUs with 
>>> carveout
>>> VRAM
>>>
>>> v3: Simplify by setting the flag for all ASICs as it doesn't affect 
>>> dGPU
>>>
>>> Suggested-by: Philip Yang<Philip.Yang@amd.com>
>>> Signed-off-by: Harish Kasiviswanathan<Harish.Kasiviswanathan@amd.com>
>>> Reviewed-by: Philip Yang<Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index c30dfb8ec236..26eac89c90a8 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -768,6 +768,9 @@ svm_range_apply_attrs(struct kfd_process *p, 
>>> struct svm_range *prange,
>>>       int gpuidx;
>>>         for (i = 0; i < nattr; i++) {
>>> +        if (!p->xnack_enabled)
>>> +            *update_mapping = true;
>>
>> If you want always set update_mapping, set it outside loop, not need 
>> set it during each attribution check.
>>
>> And I think the discussion is setting update_mapping when there is 
>> split for prange. If change existing prange attributions without 
>> split, not need update vm for 
>> KFD_IOCTL_SVM_ATTR_PREFERRED_LOC/KFD_IOCTL_SVM_ATTR_PREFETCH_LOC.
>>
> Maybe change like this
>
> @@ -3800,6 +3800,9 @@ svm_range_set_attr(struct kfd_process *p, struct 
> mm_struct *mm,
>                 svm_range_apply_attrs(p, prange, nattr, attrs, 
> &update_mapping);
>                 /* TODO: unmap ranges from GPU that lost access */
>         }
> +
> +       update_mapping |= !p->xnack_enabled && !list_empty(&remap_list);
> +
>         list_for_each_entry_safe(prange, next, &remove_list, 
> update_list) {
>                 pr_debug("unlink old 0x%p prange 0x%p [0x%lx 0x%lx]\n",
>                          prange->svms, prange, prange->start,

When prange got split the overlap sub-range is linked at insert_list, 
not remap_list. Only when overlap sub-rang's start is not aligned with 
prange->granularity it is put at remap_list.

The current logic is assuming overlap sub-range not need remapped since 
it was already mapped. For huge page mapping it is not right. Seems we 
need check insert_list: always map pranges at insert_list, and prange at 
update_list if  insert_list or remap_list is not empty.

Regards

Xiaogang


>
> Regards,
>
> Philip
>
>> Regards
>>
>> Xiaogang
>>
>>> +
>>>           switch (attrs[i].type) {
>>>           case KFD_IOCTL_SVM_ATTR_PREFERRED_LOC:
>>>               prange->preferred_loc = attrs[i].value;
>>> @@ -778,8 +781,6 @@ svm_range_apply_attrs(struct kfd_process *p, 
>>> struct svm_range *prange,
>>>           case KFD_IOCTL_SVM_ATTR_ACCESS:
>>>           case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
>>>           case KFD_IOCTL_SVM_ATTR_NO_ACCESS:
>>> -            if (!p->xnack_enabled)
>>> -                *update_mapping = true;
>>>                 gpuidx = kfd_process_gpuidx_from_gpuid(p,
>>>                                      attrs[i].value);
