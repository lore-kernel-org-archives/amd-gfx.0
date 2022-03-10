Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F33C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 17:05:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E34B10E836;
	Thu, 10 Mar 2022 17:05:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BE1F10E835
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 17:05:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJ4HgcBs/fXhw5y8ih/r3H9TUAZOMRpV6n3bnmmZRwR6yj7HqOfQ02wGlCVJLBwu9X0AeFUkFApbjH5n5qURL42C98hbEo6hTekYbkLx/gIeYeJfJ0DSam7MeN6EFHSS383joZTkm8U1qHu5LfiBzpcqFSRkqIu0wgBewBnJTvu26ezs5o9v2RWoavFKH8z26ZoPDBlGu7eb0UFH1H69iUtTGoUFo0AY4kDpbAGJVr7oPJeHiWLAMue7PrLlknd8beaOW9/dKW3usUbrEaoc6JBIaLm417jb+ua1pw1UPgsUAlpIdF3CSCjhcU7M2Mc8apuwTWvW75nZ4/PiB41gBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kziCZiCcOZ9Jmryo9iz1sDKB4vxRCVcfV0019GBhmo4=;
 b=DI1PucFdOl26vhyxCpr/A7dSeoyeUpZlaCiAvKrfCiDxTJXjdAfGZ+vH8EOVdNgGy3pmeOeabXpXuAS+ATD4tfx1fQU8UEXfkDFA73KbUWf3D98q2u207Uu4TlkqsY0vJW1T6rEAhw7vrQNudUtLc4E+6zYVBfwB9qGd61E+b0HUQMEZ8FzTDIYyMtTsywpUmz8qhtnqp38MOaY8hSVI5vIBvSBgT+c529F4UmnAxw1mkUScf6FS7aMR/KjLU4lfFK7ro6OtqeMJFOll8p093B6ps20ReImHaPlEBF2UVkaTSwv6UNSJ02lo3sK2JUfpp41r/0JlDOOrYVEEgwJmyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kziCZiCcOZ9Jmryo9iz1sDKB4vxRCVcfV0019GBhmo4=;
 b=pIP10Ydq8LsB6hmEhZjHtp/qBuowxZIBDQ2bXvBnEt8jdaT/17uRrMp6aZeChCqT9E1Gb4Wx8XwT2wEDydUqwaM63cKnBj54QjWWlvt2pKVfEkyAJzpGz5J3Uodc5DHU+jUF4pXGwue45yznbvigCY1LPVuYOVyjcDMd0zQXuxQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 CY4PR12MB1623.namprd12.prod.outlook.com (2603:10b6:910:6::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.19; Thu, 10 Mar 2022 17:05:25 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::b908:1ec9:3e42:ea00]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::b908:1ec9:3e42:ea00%5]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 17:05:24 +0000
Message-ID: <2b8480e8-635c-1d99-bc52-62a587b5a596@amd.com>
Date: Thu, 10 Mar 2022 12:05:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 4/4] umr: Fix unhandled enumeration value in switch
Content-Language: en-CA
To: "StDenis, Tom" <Tom.StDenis@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220310004226.50895-1-luben.tuikov@amd.com>
 <20220310004226.50895-4-luben.tuikov@amd.com>
 <DM6PR12MB35477B7CEF2773983590B5CFF70B9@DM6PR12MB3547.namprd12.prod.outlook.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <DM6PR12MB35477B7CEF2773983590B5CFF70B9@DM6PR12MB3547.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0090.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::30) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fd0871a-6aea-4b5b-71b5-08da02b82aee
X-MS-TrafficTypeDiagnostic: CY4PR12MB1623:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB16236F0E304A9457FB6C5B63990B9@CY4PR12MB1623.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1lOOBnpMSOExXQ4LRb1MpL55Zq5AMaGHJza00ZxLfiSFOVuF5xkdpryo5dclbpDL9KQrJp+oZzRkyNw5C9pzd1olF6e6Z+/ljmhBosP4MYo+iMRF5GDUZhNns/JQHDjqOUdnLZ/XRNbcIgchxnQYTv9hukTk2tab9FEGASdym1j14qfJ29V5NU345qsV0CpIwD20I+GNZ2fFU695RlGexXuFNhJkqLkUKo40+/MukGNnJ0Rrmldq7W4kfRCYAZD11cuKG0Lp1mz834mp+We9o0ZuGfbChCHiiJhgiqExMGM93sUIhKs4RmP+1aGvRZApq+Dz1XXtpKrIGeYlYFYR5puh9JLthN+gqmFh6PCMUxWfO/xeHQN8Atu1RaM3Kud6mN2y3gHzScw/gECOs+7gUw/uzWtrnxXXUTFwp1PfVF0xHvyR4YPSOg1IGvIQS+jphG9OWsu59DClgeuWRsy9eqiuGn292kl24cYUXINCcB3bWqGWa2exq+o/ejMXhtqnMTKUda5YfkihHzJ3MJTST4nX8gYVepei/PV3cZyquCcsanQKr0frPz8YPPzeFXPfveA0CNPBj1h/G+D47c6TQIb0d8owj1YSbzOOTlNU7sL5BqTKXpoiaIuofp0jSGVNbtxQxxgZDP+Xegq19TxzBQDMzYG2I2eU8BljaahTWZqO7iusKGPcFqBU8tnCnO5+ty2xpX4qqLQLQsact3/tB5u1tUq/RhjV+9+i4SzxM+A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(31686004)(2906002)(8936002)(36756003)(316002)(31696002)(6512007)(186003)(83380400001)(2616005)(44832011)(26005)(86362001)(6506007)(53546011)(6486002)(66556008)(66476007)(66946007)(4326008)(8676002)(508600001)(6666004)(38100700002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDA5emM4TUI2eGhORzdLdkJ0M3k0Rk4xbWdmd0Y4MmJCK2FvUC9BdTMvR25j?=
 =?utf-8?B?Mk4vS29taE5vNTU1ODhDUUtsZ3JuZGVoN0w2MlVTdmZpWldLbnlUNExJQ0t5?=
 =?utf-8?B?SnBNY3UvZGtGSllPTG4wQWVUN1c2REcyci93aE9FYlhJTytncHlMOFNobngz?=
 =?utf-8?B?bStNcUZTa1NCek02UmVZUmdqQUJneFdpUGNjSk8wMm81NlhpZE1ub0lQTU5y?=
 =?utf-8?B?cVJtK0EwMHI2WTBZTzlsdmFiR2dyZHM1ZTg1SGtYcy9Ec3pZK2w3VVA4YkZv?=
 =?utf-8?B?QzN6OGdzT3FWcXR4eU9CVENORFBWRkxUdVdoaHFRa253T3k1NGlncU1wTEtQ?=
 =?utf-8?B?OFVjM212RGhZZ0JtY1dQQUFwQllPamRLR2lZUkg3ZEJnSU4vWVlwd202Sngv?=
 =?utf-8?B?MXdtZjU4TDVtUTJ2ZmFXZmVKLzhvSmkwUmRTM1JVZnBlRHJMNFRvQzJMWmFN?=
 =?utf-8?B?czI1ZVVQbFd3YndISktSWEN0RFVuNTNSQjNyS3RGdCtpc0lpYjB6a2w3czNz?=
 =?utf-8?B?M1QzQ2xlZ1o3enQ0QzZFeitzVEdYSVUyZHhFb29ZUlFDREgzNDN4TkRrTVdR?=
 =?utf-8?B?WjZFeHpqN3ZxQmptRWpjSmhiUHo1b3RKSUNrK29DY1hXNWRldGpYTW5ET1hD?=
 =?utf-8?B?NEp0d3JFbDA3d0ptMlpsWlVLT21tbEpjVUNDZGhYMFZYa0xqZVhwdjEycHR3?=
 =?utf-8?B?NkVSSGpNVitoVHdBWFgzQThibDJIaUY3SW5lS3Vkem1NR28xRmdrVnJ2NEVH?=
 =?utf-8?B?ejUyU3pJSTN0M2xTQ0svbXdDbDRsVHl3TFBYNlZvNlFISUdVTWV0RWdVak1u?=
 =?utf-8?B?eWN3WFc2dWtQNkpmbG4rOGphMGhhZUE4QzNXeE1Cd2hEd0wzS0JUL3Z2WmQ2?=
 =?utf-8?B?bnVzZFo0NXZtSmh2WVVoYS94aS9LekxyUGZIVnNlb0IvUThPZU5SZkdlZDhL?=
 =?utf-8?B?TTFFNThIcXlaTUk2ZHBlQ200dHRBMnBIZUcvWnRjR3p6OWNtQVJ6L01jZHpS?=
 =?utf-8?B?RTVwY0szSkZuUXMrL0RRZjZYR0hyQmFORHQ3YlB3U25OS0ZLM0xKa3pGWmQr?=
 =?utf-8?B?MWFPS1JESjd0b0RtVFNUTFJUZ2d5eXVQQkgySkhIMTh6TTJ2WVQzSnVjQTEy?=
 =?utf-8?B?d3BhelQ4azk5MTIxc2p1U1VwY1RtUmJObzVsMHEzWGU5WTNoL2R0OG90Nit0?=
 =?utf-8?B?MzVhT2NIL3hsSHVVdEQ4U0djRHpQL2JnZkU0ZjJZS3dUQmlQSlkvVmVPNTZZ?=
 =?utf-8?B?MzlJcWF1VTZ6ZjZhUXZ3WGJsVks5SWVBemx4N3FiVlk3bjVmSUpoVzZiUmIr?=
 =?utf-8?B?cVdOUzNlSm93M1BhUTNJenlMbW9wTDA3bGNaemhBY00wYnQrWmdFZ2JrVGY3?=
 =?utf-8?B?MGExL20zMEIvZ0dJWTNwZVFzMndtcHNXY3JjYjVycTg2TkhGczJyZlFoL3Jq?=
 =?utf-8?B?eVp6d3ppdjFsVnU1T2ptVWQ4U0dyTit0ZURNRm42eFpwWHM4UCtjRkQ2d1pu?=
 =?utf-8?B?SFVWWTRhK05xUTJtS2tXTHdrUFJDeFdidlZ6WFJuNlRYZ0xRYVV6WEtYc1NC?=
 =?utf-8?B?RTRhd09TZXFZYUZkcGNXWld4UTFESmtIZitsN1VqSDRoZjMwTmwwcVJ1RzRq?=
 =?utf-8?B?TE54eUQ0NmdqVGJhcjRjVmhPaGY0cU55Wis5VVB1ZGQwYlFkZm1ZWDVwV3Nw?=
 =?utf-8?B?cHAxOTloYVZTYktmMDV2dTd6L05aMlpzYkdiN2hIbDg4d3pRaTFiT1dBb2VW?=
 =?utf-8?B?RGJUSGtVZjI0THZvcnpWS2xUWmlLOEFVNmNpWkEvUFFldVprR1l4RHFUeUFD?=
 =?utf-8?B?VVlISy9qQmJHWmdmeXVIUVVQbHJ0TVd2dkc1U0ppODZOekpxK25RSlpnSkEx?=
 =?utf-8?B?citDUmxuOGl6U2g1V1hUL2dwZGExM1NBRW9rYnk5YXdZUE4vRC9SckRTRStU?=
 =?utf-8?B?alM2UjN3ZjNmU3BYQ3gxZk5RM2FYY0dsTnRkeks1aGdHTjNUelM0YTdyeE5m?=
 =?utf-8?B?Vm1GeGNhL1R1UGowTXFJcURqNy9NbmtLLzE3S0wzeDJVMGVpZHBzMTlqZTNI?=
 =?utf-8?B?aGJFZEkxakVRVXdONm5aME43R2k2MlZ1Z0FVdXBKTEp0dktSeVBHQkdRRjgx?=
 =?utf-8?Q?wD4o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd0871a-6aea-4b5b-71b5-08da02b82aee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 17:05:24.7291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LedyhEQ2HpEUrmsrbELLnol0L2RECTsmNq3cMsXryu5fnJlIBcXiWCG/cYxKiYaq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1623
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Okay, I'll rework them and resubmit.

Regards,
Luben

On 2022-03-10 09:22, StDenis, Tom wrote:
> [AMD Official Use Only]
> 
> Patches 2-4 look great.  With #1 swapped out to use asic->errmsg() you can throw my Rb on them.
> 
> Tom
> 
> ________________________________________
> From: Tuikov, Luben <Luben.Tuikov@amd.com>
> Sent: Wednesday, March 9, 2022 19:42
> To: amd-gfx@lists.freedesktop.org
> Cc: Tuikov, Luben; Deucher, Alexander; StDenis, Tom
> Subject: [PATCH 4/4] umr: Fix unhandled enumeration value in switch
> 
> Add a default case in the switch, instead of the last unhandled value,
> FAMILY_CONFIGURE. This solves the case when in the future other families
> are not handled--they'll all fall into the default case.
> 
> Also, in the diagnostic print, print the value of the unhandled
> enumeration--this could help debug easily, as opposed to having to
> reproduce the issue locally.
> 
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Tom StDenis <tom.stdenis@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  src/lib/ih_decode_vectors.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/lib/ih_decode_vectors.c b/src/lib/ih_decode_vectors.c
> index ed5705059c542f..f2057df825f5c0 100644
> --- a/src/lib/ih_decode_vectors.c
> +++ b/src/lib/ih_decode_vectors.c
> @@ -77,11 +77,11 @@ int umr_ih_decode_vectors(struct umr_asic *asic, struct umr_ih_decode_ui *ui, ui
>                 }
>                 return off / 8;
> 
> -       case FAMILY_CONFIGURE:
>         case FAMILY_SI:
>         case FAMILY_CIK:
>         case FAMILY_NPI:
> -               asic->err_msg("[BUG]: unhandled family case in umr_ih_decode_vectors()\n");
> +       default:
> +               asic->err_msg("[BUG]: unhandled family case:%d in umr_ih_decode_vectors()\n", asic->family);
>                 return -1;
>         }
>         return 0;
> --
> 2.35.1.291.gdab1b7905d
> 

Regards,
-- 
Luben
