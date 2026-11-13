Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7797606A338
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 15:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kROCNKFA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6152710E534;
	Fri, 13 Nov 2026 15:05:14 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012005.outbound.protection.outlook.com [52.101.48.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 334D310E534
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 15:05:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHpkGjm2tv0gViSgKAyZyz+fibmPIXwfWYkBO4UaSkPR3Imfjc3i1UPs+6xU0L0oW/kZgqQu8cSEkVNpLLgTweuaeiuz4MAlT36d9Nt1+3M9tmPJPbwdZYBlISqgGMY25Xom6rSxYSN2eoYfwp1LIRGDYae+hxMDzn+KD2d/d3xqe5y04md7LUyYncC+D8IDjpeizBFzO679yGWHa31bJXuDQ/EJt4IftadrdrCyE96uJmZEIAD1e0qAZU5dQRFOd6feHdwvPa9GwrvsTaN8GRsWcJk13eXbLw34IDh9WRpD/gHDt0BxITbl7KXRAvcDCbeFoA75MRKvJedLsg8euQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uw2imGAI6ruPstuCGz/oAy8iNSnXX78HWm2CS8d0PPA=;
 b=ZNpJTu2GJLk/w9BG76uLOiNA87o3WDudFBTc/g774I42rNdTzeRG3+luLFSsgXeqI2EL1YWLM1PBrhzlkdzRS8DY3JTZokP5ZUX2Knk4+teR20o7i5bHPpz7Fe6f3dXWRm24cVqjo39/hQEnADDO4Rz2FLbwjyiND3D636QD2cSC3xxvODmUwsqpRFyllfX0nsHpZK1NlK89/Bpt+u2eNtwtuEG+yLrEJNOyFfYy1z7H6+raPxmCMsTl5dx+GR9wjz+P6kEkjTDZbaQcK/+jUMIl/2fxA92Gom9QYjldUyIPFurH3m0Sta9EDWfc/mJ/XGc9/iCBmaXP7VFRgZfsfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uw2imGAI6ruPstuCGz/oAy8iNSnXX78HWm2CS8d0PPA=;
 b=kROCNKFA7T1Z2h4W1EPrkeSUyq/9tZbYmg2RUmy/11NMOLm4hc9uS2iAUw0SYNiiCZOrNpvAVZXqAklp4nqeuYH17APj1MyiMlDif5wdFh7vTFA4fw4i2hr/dEs9LmhrAwpXX996LLTDbBsdss6M/EywOo/7JJSIPw8hqFlyHc0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY3PR12MB9629.namprd12.prod.outlook.com (2603:10b6:930:101::9)
 by CY8PR12MB7732.namprd12.prod.outlook.com (2603:10b6:930:87::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 15:05:02 +0000
Received: from CY3PR12MB9629.namprd12.prod.outlook.com
 ([fe80::3d72:a3a9:e4ab:4afa]) by CY3PR12MB9629.namprd12.prod.outlook.com
 ([fe80::3d72:a3a9:e4ab:4afa%3]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 15:05:02 +0000
Message-ID: <b6ecf2fe-80bc-42f4-9b15-cbc7f2797306@amd.com>
Date: Fri, 13 Nov 2026 09:05:01 -0600
User-Agent: Mozilla Thunderbird
From: Jay Cornwall <jay.cornwall@amd.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: Run shader cleaner on all XCCs on faults
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
Cc: gang.ba@amd.com
References: <20261112134340.4122401-1-kent.russell@amd.com>
Content-Language: en-US
In-Reply-To: <20261112134340.4122401-1-kent.russell@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CYZPR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:930:a1::28) To CY3PR12MB9629.namprd12.prod.outlook.com
 (2603:10b6:930:101::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9629:EE_|CY8PR12MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: 260b809e-8ee3-47cf-c3eb-08df41977e16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|11063799006|56012099006|261028144727099003|261026140227099003|261022075727099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: kJQz4aQzdRBep+Llvu1w9q6qfCuhkihr1LIkHOU9JMJF/qe3WUnkf2LKp3kmGEPahGRAusOAdHiNAYGQCFyA8Ugyugq6UAFmbJufzkgTD8LGBa6BVmarNF9myvVGIWXSeXY34oBvky6OeOFlyLtXzhas+T3JGXW7rOxGbsygZ59hBvhYOMj0zvMD35umetDbVmVQLhO1L0dTU/oVWJqcuPmiPKqLj+kkLeVBM1zNUqhVdcuf61scXtFyDvQgQHIT8BnLLzxcyHY8d/fL3bZvgojeBacLQ0zLPI0rq3mKyUnOj22qVDHlG98/p9yph9hWYphcp5hYUX73v8D+BcbYqU8gN3eDanQmmTmdOMKehmprzdiLhdig+rMYtu2yxnPXUAckcVaqFApHQTjum/p7eM1PJA3yv6eLS2e2CueUiQskmcZihCldCjIjER8DTdiERLBZKcFWZby+WR9vVzeEGANrEwuURYsDVd/1hHtQXwdT3fk9ktPLwm+nZupVFv4F1mQo58q98rFnFD4d00VoftgtHBD/4a/FFty+G8IKtzep6iz3h95BqRc1IZag/slYFOgvF2UEHEc/2LeUU70COjnK5CxWLgjli9h5TSIIdBVavzBtybHutUhElkpttTtOp0+NixP02m508KESvQmFCEsBXrcCeqZVyajQqNvCBr8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9629.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(261028144727099003)(261026140227099003)(261022075727099003)(261022105027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VURqZmVCMm1sUnVaT3lWYW1xWlllZVNtU2RoRUI1MmpwUnRuM2N4cWVGNkIw?=
 =?utf-8?B?NGlZU3BTS0E2aTQ4Vk5yeDNyYmZTUFVySlpqS2wxb1FYSEZLZS9nRkVmVC9C?=
 =?utf-8?B?VU16QkwvK2cwTUtXVDNKaGpIZnFmWnArTVZjNFdFMitVSU5JQk9tTVgzc1Vs?=
 =?utf-8?B?bnpZWXBTY2VjcnI5Q0tBS0xZREtSRE9yL1ZvRzdWaWx6Vk5seFM5VlozbWVq?=
 =?utf-8?B?TkU4cXlvRXpLcmV1ZDhJVU5BOTJNb3R1dENockNZNUlUV1QvY0N3UTFLV2JD?=
 =?utf-8?B?dXVXUG9ONERGMUsvOFl6QjhCRlY5VlBZNGlJV0V0UmNZanNBMDVxckRtS3Iw?=
 =?utf-8?B?ajBxQ1ViVndRREd1ZjBWVWs4WFRkeCtxUjVzckN1UXY4SzcrOTB3V3k0cHc0?=
 =?utf-8?B?UlY3N3hDYWlWK0ZmM1pia01PcXlWUXdPM01xZHBacmpnK0ZNQ1RHd0ZXQW1M?=
 =?utf-8?B?R0xVbnJRNi94N1grTXFIS0lEcmtoOWRhZWNDMzlldVAxbks5d2dieEkwQTkr?=
 =?utf-8?B?VUh0eDBWaXFxS2hoSTRraXR0M3pVOHdTbGVGTEN1cC9FMU4vUkFEai9sQlEz?=
 =?utf-8?B?L1VSTDJWSWxXdkV4NkFZTyt0MWZUU3djeEg4b0ptRzA1YmFmb3dKT2xmeDl6?=
 =?utf-8?B?L05jUVJFZWYrN29BWkxEODdzV1JJNWFWdVlmSG9obWZwd2g1RmI2cEsxQlo1?=
 =?utf-8?B?WmFlSEYwYkZITXdvUVk0bmpLc1dBbFF1cE9vQ09uYVpXSnhVRkltYWl6RUt2?=
 =?utf-8?B?eTdIaFlTVEpoU1MwWmZEZnp0M01TaFZTODRURlFaYnZReGs3WWRXME85a0xV?=
 =?utf-8?B?TExEUlhvWXptVjJ0NDhLMUl1MnJsZGZxcEQzQkIvNFZ4YXZjanNsOXRTQk9W?=
 =?utf-8?B?M1dxQXR4NytreXdHdnhaRXBENXBieFRQWHJsZGFXZjBXYk02YytYMExqblNy?=
 =?utf-8?B?allOclVFa0V2cFd0eGxNUVdTUzFVTzU2bGNJbXM2WTUxMVlQem5YeTlDNjBv?=
 =?utf-8?B?dWhITGJhRGFDMnlDM2Y1WnhORC9RRmQ4WmtXTUJCQ1lXV0UzdTh3cmhTQXRH?=
 =?utf-8?B?SGp0N3NkTjgwQ1J5bGpNUnRQYWw2cHluaTMxcXNMSDJObHJFUXpOUVJKNXdE?=
 =?utf-8?B?YWJGTWR2QWZrU1JMZXpyQmYvYXdua0NrdVBrbVBnTlowZ0dHWEk2Mms1c2Nt?=
 =?utf-8?B?NWI4UzQyMlVvTlJ0L1R5M2ozTkVkQlliaEVBOG5jY1dqeGloWndrK2lqamFL?=
 =?utf-8?B?NzJHUHB0d3Y0dVB2bUdoby9XLzFxcHF0SUhwM2taVGFSbGltTUU4aUVhems2?=
 =?utf-8?B?Z1NJTm5rbDhvRmpHQ2pOR1NRdHJTV1daZVc4Q2NEWTc1SjhJNmFrT3FHTXB0?=
 =?utf-8?B?ZzNwL3JsNGlIb00yQ0lsZ2pUdkVFeGp2ZmtpSTljRWVkK2tBeW82M0h6emJ3?=
 =?utf-8?B?cWUrZTJDMklDVHhmSHp3Y3dDU0srb2EzSU9NV1UzcEZaUUxMdStaZ2hPdFRk?=
 =?utf-8?B?K2k3T01CcVMxblpxMW1FdStyeGJSSFZiQnd4bFRxbzVSdCtOaDFkY0pBcmtS?=
 =?utf-8?B?enYrZGw1WWVEeWkxVDR6cmhXVkJCVjFNVElta2d3RmNtVGNEZU1xMERQc2kv?=
 =?utf-8?B?MHR0VW5UQm52TS9oVzIwRko3Y09ucnF0K1lYVlg4a0hHTll5QmUwbW8zVFdJ?=
 =?utf-8?B?YTJPMU5yMEs5VWVGdnhCdTd1R0ltd2J6ZE1iamRCREJxZDFIbnhLZGFJOWJl?=
 =?utf-8?B?UWVnbFlDSzYxRzNqSHE5Q0FYRCt4T2ZwQlVScVVDK3F6ck5WU1BIYm51QzE1?=
 =?utf-8?B?czIyVGhHZ1NZODBFY0dvQ2pBT2hpMXg2VlVVbkQzbW84SEd6T2tXNE5yb3FE?=
 =?utf-8?B?VWthWkRzYlkrSTlXaFhGYXNFN25jZ0xSbFpUMWRlbVI3NVJPTGlueWZhcHUy?=
 =?utf-8?B?Si92ak5UbnJrekIwb0hyTlNJMGRuNEpleUt0V3RlaVRmakJaZXlWR21wNlh2?=
 =?utf-8?B?RENmVkx2MVJtUTVjek5FMkUyUTkvRlUxRFRLZ3RwbjlIajN3eDI4UDIrVFE5?=
 =?utf-8?B?QmhONVIrRnUzSU41emtUL2QvMzlBeTRibnhKcUxnamdKY0JlN3IzSHpLdFFI?=
 =?utf-8?B?bU1UeEZmUzN4ZS9OU054akdCRlBDUFBGcUJJc2htUnNRaldGNmFvaGpqSFl0?=
 =?utf-8?B?Y3JqdGpMM3Z2QVFESkMrd05yUVI5VDZXSE0wa0RLUUtKRG9FOTRWQjJSVnpF?=
 =?utf-8?B?K3N2eC84NEtzMEkrbDQ5aXJiUy9JRlk1aWFveWQ4M2dzYkJoK0ppbEtJZi9E?=
 =?utf-8?Q?r6tWTrG9NsfRNTLjFV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 260b809e-8ee3-47cf-c3eb-08df41977e16
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9629.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 15:05:02.4177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1J4XnhAs4zIxPG8kevqdTVboAFB5w3QX6rLy03kKFLDiiuADbpR81FR3wObH9HRcek/JjfB9vERODRcbjA/8BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7732
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/2026 07:43, Kent Russell wrote:

Just minor comments on these. Otherwise the series is:

Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>

> +			dev_err(adev->dev, "failed to clear GPR on xcc %d\n", xcc_id);
> +			goto pro_end;
> +		}
> +
> +		/* wait for the GPU to finish processing the IB */
> +		r = dma_fence_wait(fence, false);
> +		if (r)
> +			dev_err(adev->dev, "timeout to clear GPR on xcc %d\n", xcc_id);
>   
>   pro_end:
> -	if (fence)
> -		dma_fence_put(fence);
> -	amdgpu_ib_free(&wb_ib, NULL);
> +		if (fence) {
> +			dma_fence_put(fence);
> +			fence = NULL;
> +		}
> +		amdgpu_ib_free(&wb_ib, NULL);
> +
> +		if (r)
> +			break;
> +	}
>   
>   	if (r)
>   		dev_dbg(adev->dev, "Clean GPR Failed\n");

This logic is not clearing GPRs. It's clearing residual fault state left 
due to a design defect. The error messages could be clearer.
