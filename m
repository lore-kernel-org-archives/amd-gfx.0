Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E930CE77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 22:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 962F410E26D;
	Tue,  7 Jan 2025 22:29:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dYs7BPC6";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6203810E26D
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 22:29:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Br9KtisIBXTRrizzYBGsI0hskf7mgvEMt3MLA073DLJD1BrMOeqaV8DTP1djOS3H/ZPWnjAkbBH1UZRxxbTiXmbOP+hQGKyOElH9KEgZ5zw8vJB8eVCseafHqEQy9S2MmZf9EltD3DSdY48AfM38cf0sswqmkiz6ZMz7vbVNICIHGJU69LdBhfFoo6eVbeu3zPLnj6WOKDRIpa6+BFj6vDiE3WMJZHDXr7wtnnI5fCz2Ixi3nzaV3jAHE8uHyIKLFcPNnJYirDSbOUSjw+NP5bqbQTSx4jtha7z1V4u2sCTBPuT4LLzONvFQTWkaHiKTMlgL031+40TVHsb9Ti0L/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jncaR2LLE7gTEsXLwkaAUSZLd8Ap/btj+tA0Y7KGTzs=;
 b=daz8JP+Jw7T0PoDkYfB0WMneIQdyI7+G9/6Q1H/wXH3ACgTB4ieKPVqC2wXRT7iRNw+u1VTSVQfZq2CNQp0P1cKvh8CLyBXfaO6nez1QygQzDec9E+NdJmUclzeGbuo3SDmOsP9nFwFls8hnuEBU07vqCUuCOMteedO/fmI9KuMZU8StwwvWF5MQNomLGA+KnUFfYK/HC7PkO1vc2pqzJYZ7YL9dUKBBoujyG7p42ZZTRrXmx1DjOgRDVmbZONohtNtNWEqz88feLfAK+Kdryzl/QKfjiUSHRu8fk/qqp6inpJIPARjgfm6mXlrVWbesliT3TVVQEvv9YP7wV66OXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jncaR2LLE7gTEsXLwkaAUSZLd8Ap/btj+tA0Y7KGTzs=;
 b=dYs7BPC6jacyG6RZAT4mQWJjuAcm1/LVppSqyilrGpOI72OZu1UipjCuRpkck69ELVZsznryB4ch3zcP4mW9IThC6pFazvR2rDmyvQNaEVVkLqph9Ypde8WAQkvqFU3gqa8ayATQq9YjL3gqtwPae8I4gqHlXILjY1UhYHjuZ9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.17; Tue, 7 Jan 2025 22:29:36 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 22:29:36 +0000
Content-Type: multipart/alternative;
 boundary="------------k2bsbz0EKTxUKZgS131FIMF0"
Message-ID: <879987db-3e59-488e-bcd5-ed844837095e@amd.com>
Date: Tue, 7 Jan 2025 16:29:35 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix partial migrate issue
To: Philip Yang <yangp@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250103000644.1398643-1-Emily.Deng@amd.com>
 <40e6b31e-c77b-4d89-a051-215eb4ddff46@amd.com>
 <PH0PR12MB5417A0CED996D52E33D234B98F112@PH0PR12MB5417.namprd12.prod.outlook.com>
 <19fac85c-0110-4a3d-a3ee-c539afd518c5@amd.com>
 <64af2e0d-c3ee-9a51-70aa-215bc128a55d@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <64af2e0d-c3ee-9a51-70aa-215bc128a55d@amd.com>
X-ClientProxiedBy: SA9PR13CA0165.namprd13.prod.outlook.com
 (2603:10b6:806:28::20) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|DS7PR12MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: 646c3207-ecba-4b6f-3453-08dd2f6ac487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|8096899003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUVVcm1ZRnJoTnN4VzgyVEdFc3JxeVkyODNOazUvZHV4Q2ZObnYrKzR5dDdY?=
 =?utf-8?B?NkhrSEZ1Mmxwb01VY1kzQTFNcUlOZWxJNTVUVHlrVFZNTSsrbllmeENaNUov?=
 =?utf-8?B?ZHBCb2VNS2swWjNVSEF6Z1lyV1dDazI5MFhJaXl3Ym53eGlyOGdkaVhiNCtR?=
 =?utf-8?B?V1lkZUNqdHBMalpwUGZTNWpiV1loVGE3N2hDUk1SNFZOOEpFd2orRzVTdnd0?=
 =?utf-8?B?QzRsWm1tY3d4UFIvUUFhNDEvdUQxYnNlZmlYYVpzdXQ1U0ZWaENxVE51N0Q2?=
 =?utf-8?B?ZEdQaDZPMDdsekxSUTVHQXBjNzRuai9YdEVVS0JkL0RSbVBMdmc3amQ3TTY2?=
 =?utf-8?B?aTQ1M29MQ0YwZSttQkJKemlFMTk5d0tMelhQb3FqTmRMRUF3VzZiZEowdVZU?=
 =?utf-8?B?ZUdzTUNnY21oS0c4a1hQTDhDdUhPOTdyNTl3ZVNNQjU4Z1IySzNPQTJ2cDZu?=
 =?utf-8?B?Q2NFVVUvZFptaGRDRTNaQ01HeE1EM0MvT0wyQkhaaG03eWxPSGp5NmM2RFNt?=
 =?utf-8?B?MHh0N1A3WlZ6bXU1WkNQdGNYRVNOM3VPNkova1Nqa2RGYmxIeGY3L0xQRC9n?=
 =?utf-8?B?MjVwczhiSldseHhreVp5YWxYMjVWc1k4em1GcjB3VzdFT0xnRldBa3BWUW0y?=
 =?utf-8?B?TzYwakVpMVlibkhHRFZKZy9qM0w2THZ1NWtHQlQ3QkFYQ1ErRVhmenVuMUQw?=
 =?utf-8?B?MmRZYzlqWHpBbWt5Z1NIVG5SR1dLb0NhTlIzNG5BN3lvc3hRV21mUDRrWGN2?=
 =?utf-8?B?WTBSdDlrL0VZSkJqOXg2NDl1bDFzKzN6WFhRSUhVRWp0azZlMHdBMS9ybytz?=
 =?utf-8?B?aG8vMWp1Y0pSdTVJdmpqaEExbVZDUGJ0NjZvRVN4d2h3SEMzeVo2R09vRnAy?=
 =?utf-8?B?SFlJR0NmN0RDZ29mYm5wUFN2Y1FEQi9QTE00WW15eTMwK211WEEvOU9MNmtE?=
 =?utf-8?B?b0YwRHBYS3l4dlc0ckFKMjdwZklnR21BTkloYTVhNE0vcUt6WlUzU2RiMkFi?=
 =?utf-8?B?WEZiZXQxVExvOEdjVlZUTlM5L1ZCSnhRbTJYcllvQTUvVmszTnZJTlVEUDF3?=
 =?utf-8?B?Ym14bUY2d3h0cFgzTjR2Yml3MUEwYnJ1OFI1QjVCTkRiTDVSeFY5VXBzU0Js?=
 =?utf-8?B?aXlXSTVLOThuL3JDOXQ3UFVuMVh3OHNSaEtaQmxIRzFmNU5hY1hVcUFtdjQ5?=
 =?utf-8?B?Y2RJaWZDdW0yNmw5am42ZndFQlBkN3lLZkJHZXdXVStiTkRxNGp2M3FkVXBI?=
 =?utf-8?B?VkhkZVpoenp4QWFLNldkWFdUVVZ2TlNoelR2ekcxbzduVDNwTVFxVDlXS3Bk?=
 =?utf-8?B?MURSbGNreXh6bnBFR1RtMm5ZU1FnREJha2NhS21FTjJiQXlVMXJYODA2VkFy?=
 =?utf-8?B?eENvNDZtNFMySWxRenNaWE9vOVY4TFJkaUt2Y0E3NXBua3IvMkY0L1ZYVHJ3?=
 =?utf-8?B?bUJJNGpqUU1jZXQveE9LVWpCQWFtRUhDOXJlRW1aeXgrSlFocWc1YllwaXJy?=
 =?utf-8?B?MzVtR1RPZ1hiWW5uOTFwVXpnb092ZFNoZHNaTVVzODNlbmNnNmtjRzJ1TThU?=
 =?utf-8?B?c2FpSVA1c3hSRnpYQlo0NjJnQjBrUTI2TlpucDREL0YzNFJOUTJMTUNtQm9v?=
 =?utf-8?B?QnVDR1hRWHRURzlYcG9HQXkvWGtXcHRXcndCSkVIZ3N1T2l6alFmcU16Ym1i?=
 =?utf-8?B?a2RFMEJBKzcza01Zc2JUV2QrdjNDdktJUis1bG5RVTVoa1BVbmlycER4Mm53?=
 =?utf-8?B?R0pQZWpvYnJkNDh3Z0pSaGViZGlib0ZLZHVDdys2WHdMZ2p0OW9tbkZUZmhQ?=
 =?utf-8?B?WWdlTzA5UDJ1cjlrU2JiamRha2xtclJmaTkxdEI1WUY2SGRTcUZzZ0puNVF4?=
 =?utf-8?Q?VTkP/WggvoioW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHBZUldNSHBRWERKOWgybE1XZ0tsdnllVzZYL2JZR0t0dVNWL1pnNWxYNklV?=
 =?utf-8?B?UTlkTFk1cTJ3SlNwbC8raXVHOG4yWE55bU1ZZU1GamNNWGNjK2tLa0FBYVd5?=
 =?utf-8?B?NnkxMWVKMGdhTmFXQy9vL1JzSnAxSDd6eDlpUFVGT3cvRDVFUVlLWjdxTjlw?=
 =?utf-8?B?YzROdUpnVTRyS0tGbHJmMFhjSXpadk43c09XUzI1alAxaWlGcE5TajdlV3Ro?=
 =?utf-8?B?b2pSM3NML3ZYdlFka1JheGl4S2ZjcldkdFBKeCtpdG5YZmdET2xwUlU2RFpJ?=
 =?utf-8?B?b1lSekRKd3ViV2hrNHhQWlZ3eWhBdzNvZkI0K2lNakZ0RnQ2aERTQUN1ZEdO?=
 =?utf-8?B?QzFFZFRJOFkvVzl1SGFrSTV5QnE2UUpOSmhHVHB4VEcrQ2JPOUI2TExlRklm?=
 =?utf-8?B?QUFtSkpXQms5NXNQVW02MHVBRll1aWdiTUFvZ09hZjdvK1l1WjlnSjFKNkRZ?=
 =?utf-8?B?V0tFMDRjdG1CM2todStUakpBUWY1ZjJhRDViZ0syR25hVzlDeSsxbE5EeWRB?=
 =?utf-8?B?RkQ1VnRFSHZkV2VCbWZFaVVMdjU4ejk1TGFSaXhkVUswdDFMdjNNNXlOcDRZ?=
 =?utf-8?B?d0FjZzVQWEtZdi8zMWxINmpxbkM3cWVBLzNSdlpxR0UyOHdxU0Y2MlJ3YndP?=
 =?utf-8?B?eTAremwwSDBwVmx5Q29LQmV4cGZSKzJzK0Z5cVFKU3Ezb2dmdlZScFdBcnkx?=
 =?utf-8?B?akNGVTlpRXFaMTVBUzcrTmZIc3IxR3ZWenRWMTRVd3d6Qi9Jc0NxK0JFNGJ0?=
 =?utf-8?B?Sm1GM1I2WWpOQ2Q0ZW5RU2hGbGhwTVVPR3B3Q2w5QlYzbit4cy9XRFJ6S1VO?=
 =?utf-8?B?YWZuYjU3NjhYVFA5Rm9ycjd6djI4QXAwb1RCLzZzcGcrUjJqTlhyTEFkeHha?=
 =?utf-8?B?TFlEeXZla2I4dk5XWVZUY1R6eWtGTFJkdUdJNEJLalhPR3BhN1IyUHZIY0hy?=
 =?utf-8?B?WUlacXArTUx2U28yY1IyS3hzeFNrbjFNaGptK1NwcmNDUGVmQXorVG52YzRx?=
 =?utf-8?B?ZTFvQ2JNNjMrQkhHdE5TTlFQTmlVejNFN1RDRFBGU291VjZ1bDEwOXd3NnVy?=
 =?utf-8?B?dEIzTlloT3crZUNGNXlnQ0k2SlA2Y2VHRVlZT0tLZVJTRDk3ZHdHRHVLZUxo?=
 =?utf-8?B?bjd3bFY1WEZFc2EraWREdVFIVlovRFlJdTZ6ejdRdDFPbjY2Rmh4YlRJeVJD?=
 =?utf-8?B?aGZablNZdVVwamRjRFNxZ1NQM3k0TGh1eThFeE1WUzFsSHVRd2J5SStUQ2R1?=
 =?utf-8?B?MFFPYzB6MzNKb0VrQ2ZaVmgwSXVXSVNVejFEOU5acjI0dnlYNjN5K1V3Vktz?=
 =?utf-8?B?ZUVOQlV4eEpZRWtJT254dHZLeXBkaW9BR1QwUWJ4U0crZXlXSm5hdDBxVGRR?=
 =?utf-8?B?VElaanRxMTN3ZW5MQmk0TE9ralBuM0psM0J2S0g5cHFSWVJHMnhOOHBiVFpI?=
 =?utf-8?B?N2JOSDJFREFqaFhuWERTU2ZQZUpCclhXTDRzdjVJMTRwd1pGUUFyejhIUytK?=
 =?utf-8?B?ZHJJMklpZklrNlZQM0VNUzMrdmVUTlBqekN2UlBrWllRUGh3SkxwcERvWmd6?=
 =?utf-8?B?ZUhrelF5QjFKWVAwb096NFFZUkViL3poTU5NSzdQL1k1UnNhdHpxT28wREcx?=
 =?utf-8?B?NnRtOWtaOStsS2VaU0loZHZNSFJ1K2ZiTi9DSEdjVkZOWkllWklQU1Bkc2lQ?=
 =?utf-8?B?eXlua3hGQjNtUlkyazVReERUbmtBalB2WWhaNDcvUnJqMnpRdnlIanFiYitO?=
 =?utf-8?B?cnlCNWtFZWwvTkk2Z2RkL3dCdmNubHgwQjBwV2NPemRUbnk0SXVMTndvbWpL?=
 =?utf-8?B?VlJuZXM0aVRZczFGdWpES25ZSG5SMU5JLy9xV1RUWXo4cmFzUkZ4UGF1aXlQ?=
 =?utf-8?B?MHU0TkVBdWVkck16UjhFS1hTMTE5WDZmVkFiTXp5S3ZQMXZnTks5L0dOdG1T?=
 =?utf-8?B?ZkNKQlN4KzhZRUZoNzRpbVJJZG55cThYVnIvQnBpR1pZVmY4Rnd2UU5Zd0Y2?=
 =?utf-8?B?dVVjRkk3UEdIbXVEOHhKYjU3aDdWM1hsUHBuaGlxVCtxdmtVQXN4R2Z1Zkp3?=
 =?utf-8?B?RW9sL3JvMDNYOWZaUXd4ZlNSQzN5b0NFMjRpWUtkSzlVdy9rZ1VuTVFDcjd1?=
 =?utf-8?Q?f7aM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 646c3207-ecba-4b6f-3453-08dd2f6ac487
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 22:29:36.8512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzCvXGFADyLRO/lzisGFY/qTaR4tZj98XDa5YWpBtdjV2nKdUutp2VxzkN80zYRv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909
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

--------------k2bsbz0EKTxUKZgS131FIMF0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/7/2025 2:44 PM, Philip Yang wrote:
>
>
> On 2025-01-07 10:50, Chen, Xiaogang wrote:
>>
>>
>> On 1/6/2025 8:02 PM, Deng, Emily wrote:
>>>
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>>
>>> *From:*Chen, Xiaogang <Xiaogang.Chen@amd.com>
>>> *Sent:* Monday, January 6, 2025 11:27 PM
>>> *To:* Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>>> *Subject:* Re: [PATCH] drm/amdkfd: Fix partial migrate issue
>>>
>>> On 1/2/2025 6:06 PM, Emily Deng wrote:
>>>
>>>     For partial migrate from ram to vram, the migrate->cpages is not
>>>
>>>     equal to migrate->npages, should use migrate->npages to check all needed
>>>
>>>     migrate pages which could be copied or not.
>>>
>>>     And only need to set those pages could be migrated to migrate->dst[i], or
>>>
>>>     the migrate_vma_pages will migrate the wrong pages based on the migrate->dst[i].
>>>
>>>     Signed-off-by: Emily Deng<Emily.Deng@amd.com> <mailto:Emily.Deng@amd.com>
>>>
>>>     ---
>>>
>>>       drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 8 ++++----
>>>
>>>       1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>>     diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>
>>>     index 4b275937d05e..5c96c2d425e3 100644
>>>
>>>     --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>
>>>     +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>>
>>>     @@ -278,7 +278,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>>>
>>>                               struct migrate_vma *migrate, struct dma_fence **mfence,
>>>
>>>                               dma_addr_t *scratch, uint64_t ttm_res_offset)
>>>
>>>       {
>>>
>>>     -       uint64_t npages = migrate->cpages;
>>>
>>>     +       uint64_t npages = migrate->npages;
>>>
>>> I agree this part.
>>>
>>>              struct amdgpu_device *adev = node->adev;
>>>
>>>              struct device *dev = adev->dev;
>>>
>>>              struct amdgpu_res_cursor cursor;
>>>
>>>     @@ -299,9 +299,6 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>>>
>>>                      struct page *spage;
>>>
>>>       
>>>
>>>                      dst[i] = cursor.start + (j << PAGE_SHIFT);
>>>
>>>     -               migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
>>>
>>>     -        svm_migrate_get_vram_page(prange, migrate->dst[i]);
>>>
>>>     -               migrate->dst[i] = migrate_pfn(migrate->dst[i]);
>>>
>>>       
>>>
>>>                      spage = migrate_pfn_to_page(migrate->src[i]);
>>>
>>>                      if (spage && !is_zone_device_page(spage)) {
>>>
>>>     @@ -345,6 +342,9 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>>>
>>>                      } else {
>>>
>>>                              j++;
>>>
>>>                      }
>>>
>>>     +               migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
>>>
>>>     +        svm_migrate_get_vram_page(prange, migrate->dst[i]);
>>>
>>>     +               migrate->dst[i] = migrate_pfn(migrate->dst[i]);
>>>
>>> I think what current code misses here is that migrate->dst[i] should 
>>> match migrate->src[i]: migrate->dst[i](vram page) got set for page 
>>> that will be migrated from system ram, otherwise migrate->dst[i] 
>>> should be zero. Your change makes migrates->dst[i] not set though 
>>> its page has been migrated by svm_migrate_copy_memory_gart for the 
>>> case that cpages != npages, because you set migrate->dst[i] at end 
>>> of loop and use 'continue' after migration.
>>>
>>> The page migration happens at svm_migrate_copy_memory_gart, not 
>>> migrate_vma_pages that migrates struct page meta-data from source 
>>> struct page to destination struct page and has mmu notification.
>>>
>>> Regards
>>>
>>> Xiaogang
>>>
>>> The migrate->dst[i] default value is 0. The purpose of the change is 
>>> to match the migrate->dst[i] and migrate->src[i]. And for 
>>> svm_migrate_copy_to_vram, it only will call 
>>> svm_migrate_copy_memory_gart to copy those pages which need to be 
>>> migrated, for those don’t need migrate pages, it won’t call 
>>> svm_migrate_copy_memory_gart.
>>>
>> Yes, the issue here is we need match migrate->dst[i] and 
>> migrate->src[i]: migrate->dst[i] need be set only when its 
>> correspondent migrate->src[i] page will be migrated or the src page 
>> has dma address setup by dma_map_page. Then why not set 
>> migrate->dst[i] at same time when have dma_map_page for src page?
>>
> yes, agree, I will reply the v2 patch with this change.
>>
>> That way will simplify the logic and not need use amdgpu_res_next to 
>> jump vram cursor.
>>
> if spage is not contiguous or dst is the last page of cursor (vram 
> address is not contiguous), we need setup sdma copy and then call 
> amdgpu_res_next to update cursor->start.
>
I think we only need use amdgpu_res_nex at one place where update 
migrate->dst[i] together with dma_map_page for src page, but need to 
remember the jump between two dma_map_page to adapt to cursor->start update.

Regards

Xiaogang

> Regards,
>
> Philip
>
>> Regards
>>
>> Xiaogang
>>
>>>              }
>>>
>>>       
>>>
>>>              r = svm_migrate_copy_memory_gart(adev, src + i - j, dst + i - j, j,
>>>
--------------k2bsbz0EKTxUKZgS131FIMF0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 1/7/2025 2:44 PM, Philip Yang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:64af2e0d-c3ee-9a51-70aa-215bc128a55d@amd.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 2025-01-07 10:50, Chen, Xiaogang
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:19fac85c-0110-4a3d-a3ee-c539afd518c5@amd.com">
        <p><br>
        </p>
        <div class="moz-cite-prefix">On 1/6/2025 8:02 PM, Deng, Emily
          wrote:<br>
        </div>
        <blockquote type="cite" cite="mid:PH0PR12MB5417A0CED996D52E33D234B98F112@PH0PR12MB5417.namprd12.prod.outlook.com">
          <meta name="Generator" content="Microsoft Word 15 (filtered
          medium)">
          <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:Aptos;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	font-size:10.0pt;
	font-family:"Courier New";}span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
          <p style="font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left"> [AMD Official Use Only - AMD Internal
            Distribution Only]<br>
          </p>
          <br>
          <div>
            <div class="WordSection1">
              <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
              <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
              <div style="border:none;border-left:solid blue
              1.5pt;padding:0in 0in 0in 4.0pt">
                <div>
                  <div style="border:none;border-top:solid #E1E1E1
                  1.0pt;padding:3.0pt 0in 0in 0in">
                    <p class="MsoNormal"><b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                        Chen, Xiaogang <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com" moz-do-not-send="true">&lt;Xiaogang.Chen@amd.com&gt;</a>
                        <br>
                        <b>Sent:</b> Monday, January 6, 2025 11:27 PM<br>
                        <b>To:</b> Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a>;
                        <a class="moz-txt-link-abbreviated moz-txt-link-freetext" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                        <b>Subject:</b> Re: [PATCH] drm/amdkfd: Fix
                        partial migrate issue<o:p></o:p></span></p>
                  </div>
                </div>
                <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
                <p><o:p>&nbsp;</o:p></p>
                <div>
                  <p class="MsoNormal">On 1/2/2025 6:06 PM, Emily Deng
                    wrote:<o:p></o:p></p>
                </div>
                <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                  <pre>For partial migrate from ram to vram, the migrate-&gt;cpages is not<o:p></o:p></pre>
                  <pre>equal to migrate-&gt;npages, should use migrate-&gt;npages to check all needed<o:p></o:p></pre>
                  <pre>migrate pages which could be copied or not.<o:p></o:p></pre>
                  <pre><o:p>&nbsp;</o:p></pre>
                  <pre>And only need to set those pages could be migrated to migrate-&gt;dst[i], or<o:p></o:p></pre>
                  <pre>the migrate_vma_pages will migrate the wrong pages based on the migrate-&gt;dst[i].<o:p></o:p></pre>
                  <pre><o:p>&nbsp;</o:p></pre>
                  <pre>Signed-off-by: Emily Deng <a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a><o:p></o:p></pre>
                  <pre>---<o:p></o:p></pre>
                  <pre> drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 8 ++++----<o:p></o:p></pre>
                  <pre> 1 file changed, 4 insertions(+), 4 deletions(-)<o:p></o:p></pre>
                  <pre><o:p>&nbsp;</o:p></pre>
                  <pre>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c<o:p></o:p></pre>
                  <pre>index 4b275937d05e..5c96c2d425e3 100644<o:p></o:p></pre>
                  <pre>--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c<o:p></o:p></pre>
                  <pre>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c<o:p></o:p></pre>
                  <pre>@@ -278,7 +278,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,<o:p></o:p></pre>
                  <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;struct migrate_vma *migrate, struct dma_fence **mfence,<o:p></o:p></pre>
                  <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;dma_addr_t *scratch, uint64_t ttm_res_offset)<o:p></o:p></pre>
                  <pre> {<o:p></o:p></pre>
                  <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t npages = migrate-&gt;cpages;<o:p></o:p></pre>
                  <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t npages = migrate-&gt;npages;<o:p></o:p></pre>
                </blockquote>
                <p class="MsoNormal">I agree this part.<br>
                  <br>
                  <o:p></o:p></p>
                <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                  <pre><o:p>&nbsp;</o:p></pre>
                  <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = node-&gt;adev;<o:p></o:p></pre>
                  <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device *dev = adev-&gt;dev;<o:p></o:p></pre>
                  <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_res_cursor cursor;<o:p></o:p></pre>
                  <pre>@@ -299,9 +299,6 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,<o:p></o:p></pre>
                  <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct page *spage;<o:p></o:p></pre>
                  <pre> <o:p></o:p></pre>
                  <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT);<o:p></o:p></pre>
                  <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);<o:p></o:p></pre>
                  <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]);<o:p></o:p></pre>
                  <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);<o:p></o:p></pre>
                  <pre> <o:p></o:p></pre>
                  <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spage = migrate_pfn_to_page(migrate-&gt;src[i]);<o:p></o:p></pre>
                  <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (spage &amp;&amp; !is_zone_device_page(spage)) {<o:p></o:p></pre>
                  <pre>@@ -345,6 +342,9 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,<o:p></o:p></pre>
                  <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<o:p></o:p></pre>
                  <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j++;<o:p></o:p></pre>
                  <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
                  <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);<o:p></o:p></pre>
                  <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]);<o:p></o:p></pre>
                  <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);<o:p></o:p></pre>
                </blockquote>
                <p>I think what current code misses here is that
                  migrate-&gt;dst[i] should match migrate-&gt;src[i]:
                  migrate-&gt;dst[i](vram page) got set for page that
                  will be migrated from system ram, otherwise
                  migrate-&gt;dst[i] should be zero. Your change makes
                  migrates-&gt;dst[i] not set though its page has been
                  migrated by svm_migrate_copy_memory_gart for the case
                  that cpages != npages, because you set
                  migrate-&gt;dst[i] at end of loop and use 'continue'
                  after migration.<o:p></o:p></p>
                <p>The page migration happens at
                  svm_migrate_copy_memory_gart, not migrate_vma_pages
                  that migrates struct page meta-data from source struct
                  page to destination struct page and has mmu
                  notification.<o:p></o:p></p>
                <p>Regards<o:p></o:p></p>
                <p>Xiaogang<o:p></o:p></p>
                <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">The </span>migrate-&gt;dst[i]
                  default value is 0. The purpose of the change is to
                  match the migrate-&gt;dst[i] and migrate-&gt;src[i].
                  And for svm_migrate_copy_to_vram, it only will call
                  svm_migrate_copy_memory_gart to copy those pages which
                  need to be migrated, for those don’t need migrate
                  pages, it won’t call svm_migrate_copy_memory_gart.</p>
              </div>
            </div>
          </div>
        </blockquote>
        <p>Yes, the issue here is we need match migrate-&gt;dst[i] and
          migrate-&gt;src[i]: migrate-&gt;dst[i] need be set only when
          its correspondent migrate-&gt;src[i] page will be migrated or
          the src page has dma address setup by dma_map_page. Then why
          not set migrate-&gt;dst[i] at same time when have dma_map_page
          for src page?</p>
      </blockquote>
      yes, agree, I will reply the v2 patch with this change.<br>
      <blockquote type="cite" cite="mid:19fac85c-0110-4a3d-a3ee-c539afd518c5@amd.com">
        <p> That way will simplify the logic and not need use
          amdgpu_res_next to jump vram cursor. <br>
        </p>
      </blockquote>
      <p>if spage is not contiguous or dst is the last page of cursor
        (vram address is not contiguous), we need setup sdma copy and
        then call amdgpu_res_next to update cursor-&gt;start.</p>
    </blockquote>
    <p>I think we only need use amdgpu_res_nex at one place where update
      migrate-&gt;dst[i] together with dma_map_page for src page, but
      need to remember the jump between two dma_map_page to adapt to
      cursor-&gt;start update.</p>
    <p>Regards</p>
    <p>Xiaogang<br>
    </p>
    <blockquote type="cite" cite="mid:64af2e0d-c3ee-9a51-70aa-215bc128a55d@amd.com">
      <p>Regards,</p>
      <p>Philip<br>
      </p>
      <blockquote type="cite" cite="mid:19fac85c-0110-4a3d-a3ee-c539afd518c5@amd.com">
        <p> </p>
        <p>Regards</p>
        <p>Xiaogang<br>
        </p>
        <blockquote type="cite" cite="mid:PH0PR12MB5417A0CED996D52E33D234B98F112@PH0PR12MB5417.namprd12.prod.outlook.com">
          <div>
            <div class="WordSection1">
              <div style="border:none;border-left:solid blue
              1.5pt;padding:0in 0in 0in 4.0pt">
                <p><o:p></o:p></p>
                <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                  <pre><o:p>&nbsp;</o:p></pre>
                  <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
                  <pre> <o:p></o:p></pre>
                  <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_migrate_copy_memory_gart(adev, src + i - j, dst + i - j, j,<o:p></o:p></pre>
                </blockquote>
              </div>
            </div>
          </div>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------k2bsbz0EKTxUKZgS131FIMF0--
