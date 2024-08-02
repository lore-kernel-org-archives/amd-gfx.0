Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5BBC3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Aug 2024 10:10:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9E5510E9D2;
	Fri,  2 Aug 2024 10:10:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K9ofH7LL";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40D8E10E9D2
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Aug 2024 10:10:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h24Kn+6wzaTJTdHmgSLrnU8x7dip6nIy/wFpW0mp2ggv6t+1UvnVQhaQztlRKtAuY8vyg6jGf9nQdHB5+rfuDy9TvOzVk3tNHFSlP9rhFVmoJlnvDzJ0jFCr3vh7ZhhiJ8p/g3fFjtfbFUPIyCe6I3QOsTQtAq2Fg0jVC/Gwlv/xnG+6iQ539rtPwPQ99JfRKI8IU9aP7P8WB7gtmrVQGhMMi0j92PLawb5UEXVwv8q3M9pXGcNNdb4/fJA/4l1BO69KP3YKEfgR6uajAlSGH5T5Di2xAoCirdrSu28ee9r4BLpPOhrKQ7LabhUMWb4Nf5MGTgopRSsOSNnh44Vq5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hDiRd9ALJV51+CIf1KXVnI68AUYArLToavwnJp8vgk=;
 b=x/B6Da0KJuAaxl74nThEZ7xuevzJUZiEzDOA27ef8PDbh7Rlwf/bxsIeBxdVVF+qEwHHC4PFFerd08jD3yFla/pDjp83I9KyfNI0WF4wErFndujpI9ttr+a8Es8SE2fJV2RbfNysIgjAAerdl5Ti19ZfBMvBnm72msEK7Jn/vV6X2V/HX9eNGbBr993LU/kff6+IMuYO1UbDRJiN5A96GaFuangmbExejifktHJIrUzx/ncBMjbpt4oCV5TlZvGltYiJmPPGBiKPQKg2Un7p05jf/uD9uy4B1Ex5k5d8pHWn5D+Kw0cS0yQt7QKe/xrTWsIqa/SvNxu5uG3y7JIewg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hDiRd9ALJV51+CIf1KXVnI68AUYArLToavwnJp8vgk=;
 b=K9ofH7LLA9MMK7l/QeHbAAmmsMHWrslesxcccBIIkpjilvIXKv+nwTnGlhdI45KXMmYKZdAVcrNOYBALJoCJKaXh3+Phv/2yeipG3Ypj8Q4ReaSfVs4tMhHM7KY1R5EH39Qm3aUwprgjf70GS2IwbuKJCKq8Pz8mVtKxaYtrGM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB6740.namprd12.prod.outlook.com (2603:10b6:510:1ab::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7807.28; Fri, 2 Aug 2024 10:10:14 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7807.026; Fri, 2 Aug 2024
 10:10:14 +0000
Message-ID: <e9dac87c-5df7-47ec-8f95-a10792252385@amd.com>
Date: Fri, 2 Aug 2024 15:40:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: optimize the padding with hw optimization
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <marek.olsak@amd.com>
References: <20240730124332.38030-1-sunil.khatri@amd.com>
 <CAAxE2A5hEezckDEk1jJwFdfddpN1VXJtU+Yp5uXfsM2aiV2Cxg@mail.gmail.com>
 <28927b0d-f97f-451b-af03-943f8c85f92d@amd.com>
 <CAAxE2A7C3fuExvvjTytCR7fYNjoDTDzAqK2JroSihcz6EX7X2A@mail.gmail.com>
 <18c7c805-d2ec-4448-bd25-cdb106aeac7e@amd.com>
 <CAAxE2A7XBQfUnYhSg2RS7TP_i6cv775RW0ocdgAyc-F0dsSqmQ@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CAAxE2A7XBQfUnYhSg2RS7TP_i6cv775RW0ocdgAyc-F0dsSqmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: 73586633-435a-45dc-09c3-08dcb2db4cfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YkJocmVTUy80dXgxM3ZUTGR4ZG1FbS9CaFp5WDZuVVFyV08vMDhrWkZHbmpI?=
 =?utf-8?B?OWE2VDJaRnFjRXVpTDA0WVBVTXVBLytiUWJudGI2T0ZhZFFaN0VhRzF0K2hN?=
 =?utf-8?B?aTczS2Q5T1BIYlkyeFQzR0p2bk9TUFZtOGUvOWl0emtVWllrTHlEVkYxeXc0?=
 =?utf-8?B?a2FqTmFVU3A4cHN1RHFabTJCM2wweXFRcDgzTHR3OFkwU0kvd3FUNktoK1kr?=
 =?utf-8?B?MHZlZ1R4cTVvU1h2ek1UWTh1Z2FPTGxmSEtOdEFWZS8wNzA0czRkVDhvV1pV?=
 =?utf-8?B?Rm1HU2UwTU1Zb1dWUlpvTFdrSCt5b0FDczhvR2NSUVFsZWZlZWVhVWZXTHgr?=
 =?utf-8?B?QnF6TXRjT2Z4SFFlQWxWOE9RSzRmNUtRVTJCU2RZU2c4S0kxcGwxUXRrWS9j?=
 =?utf-8?B?d1lPNG9Wc1R1RlFkbGtPaElpbkxlQ09BY2FtYjUwczZybFlaZHpPL2RyU3VN?=
 =?utf-8?B?SDQ1S2hFekJMUUhDT1BjdTJlcS9qclJzMTE0cUJjYVRxTGtJcFRTUTB4NWJw?=
 =?utf-8?B?Q0wwK2NBTnRqWFFBa2hSQXUza2cwZmJpRzg2QkRPK3RjZkFBOHFSM0dQRFQr?=
 =?utf-8?B?WG15S21CcVA1REVlUk83WU1wYS9aNGhJOTN3eGE5VUJLTHQ1ZU51SUJ0RDJ6?=
 =?utf-8?B?cElocVhCeW9zZ3A2L2ZsZWpuSExFdHRaMTIrZWJoWnBYOVNKQ3hzSXhjZXdr?=
 =?utf-8?B?TWt0L1VadlkxdkwyQ2wwOCtVK0syOFpodDFqS3l0bVhNdXlMTC9PKzZNdHd5?=
 =?utf-8?B?a1hOcW02K2l4RUhXSGxDZGRiNmxGZ3NlaTlZdFVNYU55bnQxRE5qT1pxeW1Q?=
 =?utf-8?B?RC8za1RxdkdiQ01BdnV5YmU5YTFHaGMrdGhWOW5wUmVTOC9zWWtuWlc3ejNM?=
 =?utf-8?B?RVZpRTd0WU9WTkUzaVZUcUlmUFM5TXBsdUdadzYybmptdlZsTnJBekZQNXFK?=
 =?utf-8?B?OWdJaXVhTXdTNTVTUTRGclErMC93SldMTnBxa2ZJMHo2bkU4UU1uMHpkMGcr?=
 =?utf-8?B?aS9tc0g2NDRTcTFLNHIxNkJPM201Vm9zWnVIQzZtNjVNTVFNUmN3OG5GOTBs?=
 =?utf-8?B?MDdQbzNSOUY4R0FRcVljOElpbVB5eWM5R0p6SlJBZUsxMzE5U0J5c01UM2Z0?=
 =?utf-8?B?ZDFYb1ZJdTZwY3VJUG1hTEllVG95Znk0M21vOUd3QmdxaE1OZzBMNXZINkNF?=
 =?utf-8?B?Mi8xVEV6dWRkRzhYK1o3UEprM2JVZ2ROcDJmaWZHemEvUkkwOFUzM2N0Y0oy?=
 =?utf-8?B?WFNzMWxrdGx2MG5CeG14dUdaOVJ3QTFIS0R6UnV6YkNWWjdkdUFGQjQrcy9s?=
 =?utf-8?B?MExod0dIRVhwMzhyY2RTL0YrWlAxT0VHUisxTk1GVkU1WVBOVTUrYy9XNDVT?=
 =?utf-8?B?WHp4ekJRNk94R2lnbDRJQ3NCSkFvQW0wRGRVek9pVk41RW9mQWRPSE93alU3?=
 =?utf-8?B?NFlnWXV1aS9lazVzaWliTHoyL2NJS0ludkM4RnNBdCtwMXhSSlFVZ2lJQm84?=
 =?utf-8?B?MlVYV3ZvWEkxaUtBSHl1WDJMbnNxSmlOOXdmMzFISGJyeG50MVBXb0FMQzVv?=
 =?utf-8?B?OHFLVkhReUlkdEhncTRlc2Q3MXBoci9aL3BCeWU1STNnSHNMMzdjcmk2YjRW?=
 =?utf-8?B?WktYUjIxL2pWU00wdmIvNkYwajBWU2VEWi9Ra2gwcS9va3FvS0tKTi9RamV2?=
 =?utf-8?B?aGtRRjB2bXBYUVdzWjBzZlRJTS9JT25UM2p5UndCS2F3TEpWNHNxazJqVTRw?=
 =?utf-8?B?dXd1RWJ6VHNidFdPZ2JCbzh1UldtaW9mSjNQaXg1VXQ4SEtJMlpqdHc1bERh?=
 =?utf-8?B?blFxNGI0TVFBNGR5QUlSUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTA1MENrc0owUkpSMjZ3Z2dkSk9GbXhuYjlOYXpMUWk4VHJ0TGpPdVM4M0Ez?=
 =?utf-8?B?MkRBRUFsUzhvTWNpTEdSSk5KaHRHNUNTYWxSUUZyaWRublBpdzNETEpDUzAz?=
 =?utf-8?B?QWE2cDcvRDFESXJaWWZ6R1VBaDhaRWFqdnNlR3hJNUc2OW1jYkdTUjJYQ25v?=
 =?utf-8?B?ZDNKb0JEd2cwaktMRGdwMmxJNGR5K0hZWEpZZEd0OEc1bEZ5NjhzeHEwUkV3?=
 =?utf-8?B?RE1STElkaDFsTjM4RFhTSlpjZ3FFM2pXT1lJR3lxZFpNbFN0ZEVJT3QrMmlB?=
 =?utf-8?B?Y1AvYi90OGFQbmloVU94TnlTVllUNDVwaTN6ZUlFNXRDb3djRW9CM0ZEOWFo?=
 =?utf-8?B?eEZQQ2M1ZGo2dXlvR0FuQnk1ZEUvNDErNFk4Wnc5Rm5zc3RwYVVtYW9pY3N5?=
 =?utf-8?B?Qy9hRG9vV3YwWTB2ZlYyeU9oSy9XWkZsd1FRTFMwNXdrNFI3b1c2V2huN0Nq?=
 =?utf-8?B?b2xxK0s0aVhPWThxc2lXek9rMisxNVRmVEdhZFdNOCtMOVFGZGRhZWxkKzRQ?=
 =?utf-8?B?M2JjWStoZGp3Q1d6TjB6QXdKU2FLYit4bi9JUzhmTUNWbVliUlEzd04veEJY?=
 =?utf-8?B?aFpkUDR3UnpIdlZWQnEyWFlPQ3NMTDZXRFVROGd0N3ZPNGJWNStFN1JQQmFD?=
 =?utf-8?B?cS90NjlNTUU1bTVma0cxdG1Zb3dnV3h3UnZIaW50dlpqWlk2UEsyRm1pRnEw?=
 =?utf-8?B?b05HK1hvZCszZUx6MjRuV091UnA5R0Y2aWVmSnVQQXQ1YlZpSlQyWm9sMldh?=
 =?utf-8?B?V05pYVpJbG5LTDZBeE5jNW8xZmNIeVhDMEdXNmlURy8zUzEyYit0QmdmTTVX?=
 =?utf-8?B?Rm1PbGpQbEhpTnJra0ppWkdUL0p1M1M0aS9xOW55emFlUWc5RFhRYTc5K2NM?=
 =?utf-8?B?QU9lWTlhbHM2a1VrMzZta0ErS1hDZXJrNjRqYUszUHdaL2twY21VWDY2RDNQ?=
 =?utf-8?B?cndjaUxSeFdES3hmaExQdVJaZ0g4ZXlVeG1OQkYyMVdyNG43STZ6MWtYK08r?=
 =?utf-8?B?RkoyckRGOHNzdnpDZ3VhckhFcjhWV2Nna3R0RWU0OFNZNDY3L1B2TUNUSlht?=
 =?utf-8?B?TDNYQjA2T3FuQkorb0w3ZkE1STFBMk9rTEN6K2NwRzNNRC9aWmwrV2NadmZU?=
 =?utf-8?B?ZThMQXNrblQ5VThoRXFMd1UxcGlxWWJCUTAxWE1DdGd0U1FiNWUwSUhwQWJ3?=
 =?utf-8?B?Zmh4NHRYYnA4K1NrUTRVUHdqc3BKU1h4L01QTXorVkJGT09rYXhZRU9UY1BR?=
 =?utf-8?B?WVM2WkFtSldjUUhXVjRwZDNWWG1vWmtGc1J3UVlRTVRUZ0tvcmVQeDkyMVZP?=
 =?utf-8?B?anNMOERsTVNWc2N5VHA3c1lKSFJWQUx1VXlHdjRVSFdYOWNlNHQwbVAvRlUz?=
 =?utf-8?B?T0ttc0UxTmRhaGhDVkg4OTNzNkE1ajNRZWtGdFF3RllxNEhOSGtubFk0OHBz?=
 =?utf-8?B?dHJiWk1BclduY3k3TVRWWE1KNndGZ0Zua3lBWmJpcGQvQmxWdnV6Q0lUWENZ?=
 =?utf-8?B?V0o5ME5tZ0tBM3ZlTElMcHEvS1duREFqb2c0RWc4ZDhWSVFQa3RzdkRtby9o?=
 =?utf-8?B?eXhwaWxmTWdHdkp4aFJOTnJhck9NWmpnWlowbmt1WUlqbVFkamRGMGl3YVF1?=
 =?utf-8?B?aHNDeWZjM0FXbmhIMnBZTUduWFZBKzdpNVpwY2UvejBIb05NczZPNWszTURO?=
 =?utf-8?B?Z0JZVnBFSWVETC9XR3N4b0JLbUVoM1F0aTBTdEl2YnhLN3VGelkyUTc4czJG?=
 =?utf-8?B?NC8wc1lYOFlHOUtSYlFHVXZwbzN3VnBQb05PUkN6ZmhoMCt5VGpFakxWWjVK?=
 =?utf-8?B?VXZuNE5nVk8wZkpqQUxWcFJiTHZCZkt5VnoxS0hjZndidFJQOVR2NWNQZytz?=
 =?utf-8?B?RHY5TGxGYUMwZkE1QkwyZXQ5UkNUc1laM0xXTDAvR1FPRVJaN09CN2c5cGxs?=
 =?utf-8?B?Tk5IMmFIRDhVZkFqM05Od0hSeUNZdVJIeENoYms2Z2pUc2RhV1ZScFplUDUv?=
 =?utf-8?B?eXhUdEk4VFdFaElKSk1BSHZNNlhVMzJzdUhIdzJyOXhBeWRRSUJSZFI5RFUx?=
 =?utf-8?B?VC9sYXhrSVhRUGFIRVNPRndqTWxaanZ6ZWlvNGVkYnVzcHVUemxmZW44N3pT?=
 =?utf-8?Q?rPMFGEo2o1OtXZSyQGoISruVJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73586633-435a-45dc-09c3-08dcb2db4cfa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 10:10:14.0078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Er9HNrWrvecGXmnBPX+XjnYjHa96dmSPi+E7J3K9WDJ+ckfjn9XmsuBqnJ7p7d/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6740
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



On 8/2/2024 12:25 AM, Marek Olšák wrote:
> On Thu, Aug 1, 2024, 03:37 Christian König <christian.koenig@amd.com
> <mailto:christian.koenig@amd.com>> wrote:
> 
>     __
>     Am 01.08.24 um 08:53 schrieb Marek Olšák:
>>     On Thu, Aug 1, 2024, 00:28 Khatri, Sunil <sukhatri@amd.com
>>     <mailto:sukhatri@amd.com>> wrote:
>>
>>
>>         On 8/1/2024 8:49 AM, Marek Olšák wrote:
>>         >> +       /* Header is at index 0, followed by num_nops - 1
>>         NOP packet's */
>>         >> +       for (i = 1; i < num_nop; i++)
>>         >> +               amdgpu_ring_write(ring, ring->funcs->nop);
>>         > This loop should be removed. It's unnecessary CPU overhead
>>         and we
>>         > should never get more than 0x3fff NOPs (maybe use BUG_ON).
>>         Leaving the
>>         > whole packet body uninitialized is the fastest option.
>>         That was the original intent to just move the WPTR for the no
>>         of nops
>>         and tried too. Based on Christian inputs we should not let the
>>         nops packet
>>
>>         as garbage or whatever was there originally as a threat/safety
>>         measure.
>>
>>
>>     It doesn't help safety. It can only be read by the GPU with
>>     kernel-level permissions.
>>
>>     Initializing the packet body is useless and adds CPU overhead,
>>     especially with the 256 NOPs or so that we use for no reason.
> 
>     Not filling the remaining ring buffers with NOPs is a pretty clear
>     NAK from my side. Leaving garbage in the ring buffer is not even
>     remotely defensive.
> 
> 
> What are you defending against? You know the ring is kernel-owned
> memory, right? 
> 

Aside from that, the true hardware behavior is that CP still fetches the
words and discards them. It's not the same mentioned in the description.
So the only optimization it allows is to move the pointer without
filling/caring about the contents as hardware also doesn't care about
them. The notion of filling those unused region is exactly opposite of
the intention. If that's the case, nothing is gained and just drop these
patches.

Thanks,
Lijo

> Marek
> 
> 
>     What we can do is to optimize filling N DWs into the ring buffer
>     without updating the WPTR each time.
> 
>     Regards,
>     Christian.
> 
>>
>>     Marek
>>
