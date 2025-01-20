Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183DAC02181
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 16:13:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA84210E43D;
	Mon, 20 Jan 2025 16:13:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5uQz7dyC";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0744510E43D
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 16:13:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adut+TxEwVltq4lLG4beUq0LQHHNyT24i8mEfBIaC5L888GJtG6UDrWQ3YpGBohtfBUtZycesSD3o5UAOHqNnk4mrVJT1LAXFCk8fmrPga9BPpCbPlYWpa71ZtdSqaBzRrCnJdRmQH/0USUTBqNcElTYctjFUt1JyKgzca28M0ANC0OhoiCGyqZKmuG0vQUR5OQxVV3wRITm0L9wvCeSz82Fu2MYplqmUiNJXAsejf4TKZQzFj+JM/AYq4Qy3MebIs4v51qbUcHK3N2LQV35JU8zQyS6Z8nV7Uqurv8vQcbpcyr72mdEPMYteJGzD8F5iElN3My92H75ulCBW+4Hcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5p+APRi+xPLJCLrsv8SLVBrCFcpaq95yRSlcs2SNHs=;
 b=j2H0Qm3rcSfn0jWbcFJZ6Lm7IyXxLwbQ1xpqyMBOARp3HeMRPvBwibxZ0lQKorXT0sgn+ViwuQdXJWG6qEHD7c6WEykjPrC+0+HAs7aN76fE9sBt0gnigVILEHDJDE5bt3uQOULxpA8rGCopNwm5ub0CMtujN2OaN9OZgCv9fmZw+4r/JLucJV6y0ky1h7HXboe7+wNrd1/X48tiD/JnkfAlmTjLKT+Vwyw1CKjjnTaRPuaHDiVl6UvTue+poy8cTmfIUUcRAe1uqzsK2WrIYRHh0m6RAzeoPR+UEKuc00evqiGNx5Ahw5MWZzCa8ewsiVzAsRMvcra5ZCFZN9L6Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5p+APRi+xPLJCLrsv8SLVBrCFcpaq95yRSlcs2SNHs=;
 b=5uQz7dyCo1CaLkMQMfhrlUmkxv7i5vaWgWTY8MKajn/hIxjhkZrhPbqmy6Rr1/qvAgwlEr+jCp+JOdC3jAY/IWwvDVw1EV8zt+CL5uVwbCnI5M27bvHmf8PIpUQEAhNTexhFR7KuAmSbLYAzd9OV/LLsr0NOvdwQc4NDMWrvbe0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SA3PR12MB7903.namprd12.prod.outlook.com (2603:10b6:806:307::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.19; Mon, 20 Jan
 2025 16:13:33 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%3]) with mapi id 15.20.8356.017; Mon, 20 Jan 2025
 16:13:33 +0000
Message-ID: <8a89c11e-e2d3-acd9-5fe4-22bc3f261d3a@amd.com>
Date: Mon, 20 Jan 2025 11:13:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Change page discontinuity handling at
 svm_migrate_copy_to_vram
Content-Language: en-US
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Philip.Yang@amd.com, Emily.Deng@amd.com, felix.kuehling@amd.com
References: <20250115214001.335607-1-xiaogang.chen@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20250115214001.335607-1-xiaogang.chen@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0218.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::6) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SA3PR12MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e2f647-8324-4671-0275-08dd396d62be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dm56YUpjcEc3RGJKb0prRTIwUExvQ1piTTRkOXZRclVEUjFFeHBrMlhRbW1j?=
 =?utf-8?B?T0pmL21CL1JqV0wwNHBNVFlLYUFoaFNKV3NpN3p5MC96NzhDdEhPUEdtVk10?=
 =?utf-8?B?SFZFTWs4WHJiSlRjL2N1ZkZ6eFNqazFYZkFscGpKR1lvbUE0TmZtWVJhbUlI?=
 =?utf-8?B?UkFtQWVxeUduN0M0ZGNSVnhlbGlhNlk3ajlRVzg4SzY1VjBEUzZBZG9zRm5y?=
 =?utf-8?B?dnY3a0FKUUlDeWh0ZmI2VlZMa2UrcG54VktyK3dLYlROeC8yNVk2enJiNDc3?=
 =?utf-8?B?cHZjSDlXY1NIYmJ6Q3BCY2IzRFhBZHBzNllhK0JsL0o3L3ZGR1pCamorZ054?=
 =?utf-8?B?ckZBNTlVSW1yeCtHb1ZVVHZHOG1zaHJNcmg2cDUraEIwYmV1dW1aZ0NpbGVi?=
 =?utf-8?B?SlNrRzVydGNNbS9tRW85U25QcnE3NFozQlU1VHRyMGNxN2hEaHlXR2lvcTJV?=
 =?utf-8?B?WW1ZVlVHS1dDS0dCWklYRkpWendvSjlsV2QxcTU3UjdLRjZQY3FTM05BOEZZ?=
 =?utf-8?B?cmtXOVpQWlR3SEdEVGxUb1I2ZldkNVRWQXYwWjRPRE0vK1FvQzVIRDd4VVZS?=
 =?utf-8?B?aE9XbERCcmwzWXBndnhHckRhUkxRVmJkendmOGJyZTZKSUJYSlpRUmtySkhm?=
 =?utf-8?B?Ky9Na25DUmZ4ZEhwYVZEYnpOU1BDbSt3MS9JSTYrc0NHU1FjZ0syVC9QdDNk?=
 =?utf-8?B?MmE0UDA5VVp2bkdtZk5jOURhQnE2SHJ3eWgrK2Z5czAvQnJYWmlYM2JSa25S?=
 =?utf-8?B?T0d2UUNYV3cxd3VoZERvYkMvTUVxLzRKeVVXMWNFNlNIOHQycXFiZGxNMEV2?=
 =?utf-8?B?QldJT3BYQmE4aGJzTHYwZ0Z1MFo2cU1JT3llUWtKeHgrQXk0UFZSdlVRRitp?=
 =?utf-8?B?dDZtOWVBOTVCK1E5cGlidTdOSnBZc1o0RVhmK25XU25Kb1RxME5uR2lKbDVY?=
 =?utf-8?B?dU53MWlkZXZ0TkhUZWJKTDFCM0Mvd3dlK24rLzlDTDRYUHd1WEVMOXZ0Skhp?=
 =?utf-8?B?Y3BBcXdIZTNTVXh5eWR1SmZkejNydmQ5WnVSbWVmcXFIOTNGNis5T081USsz?=
 =?utf-8?B?ZFl1NU5TKzAxSitENTRpdVN5WDhndWZhcHgzY1NlY0s0RzNWQjZiSGRLRGs5?=
 =?utf-8?B?YTl6STFhR3k4UnlCY0wxUWtPZ21acmJmdFJ6VXVxZUo3VTY5WGpkU0diS1gw?=
 =?utf-8?B?NlJidFE0eTBkbVE1TldaQlk1ZjJZdmRTZnFKQmxYLytvSisraHFFeDNMc2xL?=
 =?utf-8?B?aTk2c2lFQzVFZDhLN25OVTBaZ3IwTUtEcFp6Smp0NTVTcnNsOFZoTnFsditJ?=
 =?utf-8?B?NXFGZE9WVDRWNjVtbmJBWEd5OXRUL2l0QWpsNXpVL3hSYkxJZnJIdGNtT0R3?=
 =?utf-8?B?YVd5eXpjM1JWaUtUN0tabWJ2UUFPUWJXemxKajJSY3o2MHZWejY3RFlXR0JM?=
 =?utf-8?B?b1RScUQ5WmE3MTFoTEhUNGh1NXpXQzlneWJaSm14QnhCR1ZqV3crdTFGUkth?=
 =?utf-8?B?RzRhTUEzVUtTSkhjVHJ2TzZ5Y2FBejZzc2RKUVRlSWFXUTI0MENJNXpRWTJ1?=
 =?utf-8?B?S01mT0hyM2YvbVRZR3ZpSmtqamlQV0RocEhYV0EzM2ZoWStzYjdKcjRsZzRE?=
 =?utf-8?B?d0l4Y0QwaEpQeTUzVzJpT2ZzbmpiOUVTVTY3SzdmUEpSTWhGeTZFa2ZxVE82?=
 =?utf-8?B?UVVIZnVVM0JvZm02MTJlbzlldk5kempGY2tGbzN0UERELzhrVE1pYzM3emp4?=
 =?utf-8?B?K2w2aTNGLzlmUm9MUFRsR2s5cGM4RE43Y2ZuTzArRm5ITW5NVldReExaemFo?=
 =?utf-8?B?QW9lZ2JRNjJzalZLWGVRdmZDUW9KS2swV0Z3MUhUQzkvNEFudFZmNkN6bDJl?=
 =?utf-8?Q?Npe7p3W49BA+U?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFgwRnhNSGI4UTQ1MzdtKzV2MzdLNlBaVENPM3JVbXhnSlROVGl3M1NPN3Vv?=
 =?utf-8?B?d3RxbmtwdlFRV2xtQW4za0JXVjNDeVJLSXR2NjkySHFXK3htN2NKLzNIWURH?=
 =?utf-8?B?RVhNYldBZmpxdXc1Z1Rmd1NZQWxIeUIxeG14N3VWbzZYZGhmZmhFdWJvMERJ?=
 =?utf-8?B?SVBIT2E0cjZtL1dsMmdnMUR3MFV0SldBclNkbmU3Z3dMY0FzOExUUURkQk9Q?=
 =?utf-8?B?cC84T2R6MjNjQlVIMEo4dHduMWhvei9haCs2elJ6azlTU2JZNUcvRWZENG5L?=
 =?utf-8?B?N2hWM0h3dWxXRVl3TllMTUNVYWxTQjR1RXloTG5IV2J1ZVdaZkxwRVdSMC9k?=
 =?utf-8?B?R01wVjlDODFhdXRON1phOUphQ1Yzc1BPa0tHamwrby9jK0pub2RxbDZKRUVG?=
 =?utf-8?B?ZDlDYWtmZ0Q0cDlOOUdmN1doSkZLRExsMHYxUDJLSHFlanoyMHdsTUozdC9y?=
 =?utf-8?B?c0VsTEw0RTdEdzFPWXNYTnBrYzllRiswS3FXQU15Zm1BUHZaeXZDQVJzYkFx?=
 =?utf-8?B?aXRHTTdLVVd3bWdHeC9iRERaVFMwZmp4QjJkV1dUNmtiRUkxVGdKdFIrazY4?=
 =?utf-8?B?UVJRYnFJUVNHRkxlMGM1OThxekpyNnJsOFkybjYyNldZNHg5eWkxRzVCeHVH?=
 =?utf-8?B?L3NaQTBwenp6WDhDY0VnUFZXRVBwc1lVeDNYOUxaZ05jQVFTZXRENTZDOHE1?=
 =?utf-8?B?VzZSSW9wUENvL2dWVk5QUE5ZdVVGVHdCRHVOQkVkZmM0dGlpbjdvSWpocWhJ?=
 =?utf-8?B?MlJ0a2cva05HUU1EclFFQ1VWOHU5UkplcENQTWhTb2M1VzN1SXhKb1Nlb09z?=
 =?utf-8?B?QTNtN3ZTQ1dPZ2RRSXl4Z1dlSjhPb3dySWZ2Lzl5eUpOZW5GYnpuUXA0NDZp?=
 =?utf-8?B?ekhIVjVtUnIzTGRJVzdvMldYSmlQbjdQV1V2UDFrNTlQM3NsRkZQTHV6ZytZ?=
 =?utf-8?B?L1VqUnZ5eThsbFo4b2NrSGkwNlhtM2d3TVpoWFdnbXd0R2hjS3hIWHE5Umlw?=
 =?utf-8?B?Y0NBbkd3c24zZ3dHRFlpbzlVa242N2hmdHRYQVRxLzd2QzlBejZ3cWwrSmtO?=
 =?utf-8?B?YmpuaVhyanE2dW5BV3NmVTN6bW5hZDY3ZHlKN3ZOZGRrdmJWVE02aU5RYVJR?=
 =?utf-8?B?TCtoN0YyUTQ0TEFrOVh3eFFnVFZQVUtqQXVmaVhBWm4zUVlDMHJ0SXU4akpP?=
 =?utf-8?B?L0VJNjRFbzJvWThzalVSVHFsZWxuWnJwYzVOY3kzaUdKN2FOcTFGWDRUWWx3?=
 =?utf-8?B?MWduSGR5MkVta3JGMG0xTmo1MjlXM0RSNk1hbzNBMXdCdEkxcmhqak1PeFJz?=
 =?utf-8?B?ZUFQOGpRYzVCNFRBZUFIcXJFU2RCZk9yK2VLc29ReUdjRGlicnlXYmVBWFZv?=
 =?utf-8?B?NXM5NHVNenp0YlpmRHBvejlBZFA3NkJTMTVWMW1saDA1V2NSQjlDNlJyS0Ur?=
 =?utf-8?B?RS91ZmZ2dlFxcWNGaHBWUzRWY3I2bzhwUjdnUHdEcHJSMzArQ3JJUHk2ei9O?=
 =?utf-8?B?RC9qcGpyamRubzE5UnZCUjE2dDYrazV3WFhNSTJqL21FVG1TbEtPY2dYYmZ5?=
 =?utf-8?B?WThJYlYzQkk1U1JBRVBSQkxnN0NLRzBlTGxoRFN4dU5aSFFoNmZTaVMzZmZt?=
 =?utf-8?B?dVNsQ3BuSFpjei9GVE9hL2lCbUhMU0ZGS253YWwzRFBHSDlFRTUrYnRpZUJq?=
 =?utf-8?B?WTc2QkplYVBoaFptZG12VTVoSzdhREk1cjRGSDFGc0JpaW5MWU9hQis0UlY0?=
 =?utf-8?B?UDNsUlFQWWwyRjNRanljKzBzSUVhYjc2dkZaZkNNMXpZeFROck9nSWlhSjcv?=
 =?utf-8?B?K2RNMWhjVTdDSnFWQ3l5dDdncjhsQkRpenJFUnFhL2h2UHV2SnIzV3N4RHdF?=
 =?utf-8?B?L0NBeUQ3NWJFS0gzYklNZ0FGTDdPZ0pxRmVhY1phZ3VtVm5mSFJBS0Q2NWcw?=
 =?utf-8?B?SWlnMjRXcmFBaWM0NjhUMGVJQVJPN1dMOTd6akw0RnJyaXBlem1zU2g5MmdJ?=
 =?utf-8?B?dVFoNlN4U2dqWUpoRE4rRlUzeGowcHgzTUI3ck5DWWFDS25IamRxNXZXRmZn?=
 =?utf-8?B?NStjL1BxNmhLcy9uT2lza3dueFJ5akN5Um5SRlh0R1JKdmFhUkJaVzJUNWpv?=
 =?utf-8?Q?Mn0mVXtyRRA2aLt0/gwzklW6/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e2f647-8324-4671-0275-08dd396d62be
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 16:13:32.8720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5tBMbz3Kvp/rY5LXlfLCnjA04XqY9doAJUVlUfs2Ly+6s1exu9GBJcZpfSpRGEqd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7903
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-15 16:40, Xiaogang.Chen
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250115214001.335607-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>

Current svm_migrate_copy_to_vram handles sys pages(src) and dst pages (vram)
discontinuation in different way. When src got discontinuity migrates j pages
that ith page is not migrated; When dst got discontinuity migrates j+1 pages
that ith page is migrated. That cause error path have to iterate all pages to
find which page got migrated before error happened. Also makes code more
difficult to read.</pre>
    </blockquote>
    error handling path loop from 0 -&gt; mpages or i -&gt; 0, to
    rollback migrated pages, I think both way should handle similar
    number of pages.<br>
    <blockquote type="cite" cite="mid:20250115214001.335607-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
This patch handles src and dst page discontinuity in consistent way, has its
logic and error recovery straight forward.</pre>
    </blockquote>
    <p>I feel that svm_migrate_copy_memory_gart move to the beginning of
      the loop is harder to understand.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:20250115214001.335607-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">

Signed-off-by: Xiaogang Chen<a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 68 ++++++++++++------------
 1 file changed, 35 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index d05d199b5e44..2ce78c77f203 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -299,6 +299,19 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 	for (i = j = 0; (i &lt; npages) &amp;&amp; (mpages &lt; migrate-&gt;cpages); i++) {
 		struct page *spage;
 
+		/* accumulated pages more than current cursor's block has */
+		if (j &gt;= (cursor.size &gt;&gt; PAGE_SHIFT)) {
+			r = svm_migrate_copy_memory_gart(adev, src + i - j,
+							 dst + i - j, j,
+							 FROM_RAM_TO_VRAM,
+							 mfence);
+			if (r)
+				goto out_free_vram_pages;
+
+			amdgpu_res_next(&amp;cursor, j * PAGE_SIZE);
+			j = 0;
+		}
+
 		if (migrate-&gt;src[i] &amp; MIGRATE_PFN_MIGRATE) {
 			dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT);
 			migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
@@ -306,17 +319,10 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 			migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);
 			mpages++;
 		}
+
 		spage = migrate_pfn_to_page(migrate-&gt;src[i]);
-		if (spage &amp;&amp; !is_zone_device_page(spage)) {
-			src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
-					      DMA_BIDIRECTIONAL);
-			r = dma_mapping_error(dev, src[i]);
-			if (r) {
-				dev_err(dev, &quot;%s: fail %d dma_map_page\n&quot;,
-					__func__, r);
-				goto out_free_vram_pages;
-			}
-		} else {
+		if (!spage || is_zone_device_page(spage)) {
+			/* sdma accumulated pages before src got gap */
 			if (j) {
 				r = svm_migrate_copy_memory_gart(
 						adev, src + i - j,
@@ -325,29 +331,26 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 						mfence);
 				if (r)
 					goto out_free_vram_pages;
-				amdgpu_res_next(&amp;cursor, (j + 1) &lt;&lt; PAGE_SHIFT);
+
+				amdgpu_res_next(&amp;cursor, (j+1) &lt;&lt; PAGE_SHIFT);
 				j = 0;
-			} else {
+			} else
 				amdgpu_res_next(&amp;cursor, PAGE_SIZE);
-			}
+
 			continue;
 		}
 
-		pr_debug_ratelimited(&quot;dma mapping src to 0x%llx, pfn 0x%lx\n&quot;,
-				     src[i] &gt;&gt; PAGE_SHIFT, page_to_pfn(spage));
-
-		if (j &gt;= (cursor.size &gt;&gt; PAGE_SHIFT) - 1 &amp;&amp; i &lt; npages - 1) {
-			r = svm_migrate_copy_memory_gart(adev, src + i - j,
-							 dst + i - j, j + 1,
-							 FROM_RAM_TO_VRAM,
-							 mfence);
-			if (r)
-				goto out_free_vram_pages;
-			amdgpu_res_next(&amp;cursor, (j + 1) * PAGE_SIZE);
-			j = 0;
-		} else {
-			j++;
+		src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
+				DMA_BIDIRECTIONAL);
+		r = dma_mapping_error(dev, src[i]);
+		if (r) {
+			dev_err(dev, &quot;%s: fail %d dma_map_page\n&quot;, __func__, r);
+			goto out_free_vram_pages;
 		}
+
+		pr_debug_ratelimited(&quot;dma mapping src to 0x%llx, pfn 0x%lx\n&quot;,
+							 src[i] &gt;&gt; PAGE_SHIFT, page_to_pfn(spage));
+		j++;
 	}
 
 	r = svm_migrate_copy_memory_gart(adev, src + i - j, dst + i - j, j,
@@ -356,12 +359,11 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 out_free_vram_pages:
 	if (r) {
 		pr_debug(&quot;failed %d to copy memory to vram\n&quot;, r);
-		for (i = 0; i &lt; npages &amp;&amp; mpages; i++) {
-			if (!dst[i])
-				continue;
-			svm_migrate_put_vram_page(adev, dst[i]);
-			migrate-&gt;dst[i] = 0;
-			mpages--;
+		while (i--) {
+			if (migrate-&gt;dst[i]) {
+				svm_migrate_put_vram_page(adev, dst[i]);
+				migrate-&gt;dst[i] = 0;
+			}
 		}
 	}
 
</pre>
    </blockquote>
  </body>
</html>
