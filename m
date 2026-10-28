Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D139606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 19:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DyQ8HZhQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B014310E149;
	Wed, 28 Oct 2026 19:33:12 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E73F10E149
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 19:33:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HN0JMEc9zFTNgsbTiyvZZA+O6ycDO4nkLJ5hy3Ddlh3HljKI+CyjwyL6CqjyQQ/tbuw0ifgbqYQA6nQVylZxr9wTrBp+hOCl1VtsEcPuHTNkPCZeGOSvr0Q1M1ctyEwx7D3qfKGvg+ORXQAkKChrQ2WCboR65jYD3ki/9jMGZW2kVp8DXkupf6O2F+UAVP8eZ6qbXI2BD7jPKTliBvVJkaQ75ifPYy69BPxwMaXEG41WqdjrhWdEdqAKJ/yloCQDN+lD5gvzhtC/Z1UewSqGXGQlegD+R+nZRhxjZe1Wdt2TBIh9FGJMV8Kh01sy0EDBBUpHs/lK/4+bdMSOpepKag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoT88PKty/+LTbuL5M1f+cLLRy5t6kZpOb0MRkZvRYc=;
 b=SqXrezxrbWAUXpwfziMuJxGexLU/D+V/hkBQCvpWJrN5zLScgLkosgYyOfQLuCoUPmhQxBe1ZgbDUz+RgRCS0Tx50X99L5XPvArcR3STQPhpYDTNdyMTaerBTiRHz3ReRr675hgaoFcVBqZx0loGbmJwcy2YYfLTnrdAuOkYY2Mdqmmyw8DoH7RemFnLP74cnajWpSho8aA6uNI0tq0x8AfyoUwXGfEvTzw4JuUYrrl2pakh9sL25Ye9M2NSIpTONtaTtNSnN6cqt5eSKQl3rg8hhcD/oytB4J2hKfOFWmZK5skW2Pb3CWQDenX+Wethx2Y846Jag7RvhrF2LT25mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoT88PKty/+LTbuL5M1f+cLLRy5t6kZpOb0MRkZvRYc=;
 b=DyQ8HZhQe+P1JIluXlPkwEDXMS6GE6DrfoUUbvYLhT7fVBS3ZEI5hJj4jXhSv5p82BKOqcU8K97RJWqJWaM8fAgopWCELJBH8tt0o8n1q62nQ9Y1JUpPVvqq3Q2VAH5VCxcaXJ6yZt0hRwGXwIjMAHdCtC7kx4fSaY+VOUA37ho=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY3PR12MB9629.namprd12.prod.outlook.com (2603:10b6:930:101::9)
 by LV1PR12MB365848.namprd12.prod.outlook.com (2603:10b6:408:50d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 19:33:03 +0000
Received: from CY3PR12MB9629.namprd12.prod.outlook.com
 ([fe80::3d72:a3a9:e4ab:4afa]) by CY3PR12MB9629.namprd12.prod.outlook.com
 ([fe80::3d72:a3a9:e4ab:4afa%3]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 19:33:02 +0000
Message-ID: <51ec8731-bdd2-4191-9058-650a268800f4@amd.com>
Date: Wed, 28 Oct 2026 14:33:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Scope VOP3PX trap workaround to revision 0
To: Lancelot SIX <Lancelot.Six@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Vladimir Indic <vladimir.indic@amd.com>
References: <20261022204858.4143484-1-jay.cornwall@amd.com>
 <68d321fc-1a2e-4de4-8dd5-b7171a319a5f@amd.com>
Content-Language: en-US
From: Jay Cornwall <jay.cornwall@amd.com>
In-Reply-To: <68d321fc-1a2e-4de4-8dd5-b7171a319a5f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0089.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::19) To CY3PR12MB9629.namprd12.prod.outlook.com
 (2603:10b6:930:101::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9629:EE_|LV1PR12MB365848:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b821f98-59f8-40fc-ae98-08df352a4845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|261021121427099003|11063799006|4143699003|261022075727099003|56012099006|18002099003|22082099003|261026121527099003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: 9p3Z/Qr3dtwE/mH5OJ7GA+JSE1UQRTARX0g612x/rIVe3TY5v+T50cdPu7o0baz3/X1+JWGC7HW+qk01bUc4iVVizWhLluo+jeHikpK3lDXhntGSPj3xnNNB4XQaMQ/pQrFPzARUIF+e7AM10Z1QT5m42/v5bOxVj75zONwf6IHhzhbpfHI1zqhiDwiZtKP+tEDPBUlFXVPEP+K05ORV3wsVuzFPLpTp++Tsl69qWfaNBmsaAfnLOi/V5y3eSksv7tgML/IvCawoblX0gyKQDRZh4/g5JYqWYqrNj0ido8PewlGRA96D4I6sYgPGvOgGpq8VYQYiMKWpgRCzziEeBO4dnD3sPaU6rgghs2cZruNP8iAkHUK8FsaIN/PJoTzcC3hiZk71bpXNn7v7KeiYgm5qp4pgs6oyStzTyrk44oVcX+tOv8TPCHXxvh9ONecRjQlhJZso7+yiMgDAiI/Q5gyBO2MgryMJNk5tXJAYQZkbQ+0fCMESz9hN4QkXlBhGiL96yVWQ0+YZrlayg6+8JiYjxVW4jcnOYKSOo3IABck/AXrF/tsV1Ni/l8W84OgyvKIq8TQQ9GWc+uE2Y6oLImNY5T/ZBB1YMjFcqQhOvgOCQED7nmXMsyNw9PYWVczBWRBdAvqrpBpyiuy7Bl3HumKfA6tX0Wra3w9yi9NgfBE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9629.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261021121427099003)(11063799006)(4143699003)(261022075727099003)(56012099006)(18002099003)(22082099003)(261026121527099003)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzRLT29ILzVpbU5pR3ZxYmFKejdIUkRjamEvaHQwZzcwTlhZdjNvN3A3V0ZU?=
 =?utf-8?B?YXNrWHBxZ3NiWmRBVTlYUXJ6TlMzODlGRWRyNjFhd3RCeE11TFlOcVJ5cFF0?=
 =?utf-8?B?dFoyM3hoYUx6c0NOUktwaWxoenlLTFJkK2Z2OUxzZG9FN1N6Ryt2QmdkTlds?=
 =?utf-8?B?WlJMaU8zdVROSmtpZWtyd1ZTQ0FOSE5jYi8xTkdwYjJxNU5LZlpTR09PZGZn?=
 =?utf-8?B?bGg4bU94K2pHS1R5VElYOURrSDRaODgvWkpSNmpGaGNieitWdklnY1VUNkNM?=
 =?utf-8?B?M0hkODBneXlSaU4xTWN1ekRqNGNiVzRkQzY3Vmp3d3g4NDI1ZFZKNUp4M2hx?=
 =?utf-8?B?SjJYVkkyK2xrQ2Q1LzVaY0RKZmdSNmpUUVg3YmE2SzZXeEJTaWlObHN5N3c0?=
 =?utf-8?B?STA5RzYzdndBS0YxVzVqVGlUanRoMWdvTnRvSEIrdEI0Yk9vTXhXNWJRTDJx?=
 =?utf-8?B?Rk40dVZUY1BWb3RUUzdLQkM5aEkzTk8wTW5vV2M1L1RzVUViYktRR2ljVHUv?=
 =?utf-8?B?OFdjTDBLeGtIczNZSys4OWFPckp4UThVbGRFd2R3dkNsalVvaHpkMHdwZkhL?=
 =?utf-8?B?ZVAyRFVvdzljLzV0aENZYzU3SEhkTUNTZnRHTUVHYWc3ZTcwSVNiVXBLbDJV?=
 =?utf-8?B?VUEvdnR1N0czZEVWeis3OER3VVg3elRQRXlidGQwM21kNG8xM0lvMjkxSzQ2?=
 =?utf-8?B?UVVyNE05NnNkelFaT1Y5Uk9jbWdiTmh1NkVndnJzdDhTamNSeUhoL3dkYXVQ?=
 =?utf-8?B?elJ1endXbHF6aEtmRG9RNGc1QnZzbVpnd1A0Qm11Qm1YMmNkVkxkKzJDWFBS?=
 =?utf-8?B?ejZxVE1qb3JPUGdQRHk0dHY1NTNkUjE5NFk1elJwSDROQmVqMFZYTHMrYkd5?=
 =?utf-8?B?ZW96eXc4N0hucXJLYVZPcXRncDZvazNVd294SEFBbjMzaUt2blZHeS9EVTV3?=
 =?utf-8?B?VXRmR1lFbFFyV2JaU2NTaWFNWElWdlBveXBtdkVMSEVhQ1QyemVyQWsxdkly?=
 =?utf-8?B?NzEzMlB0K0lEQlNlT29JNUNHQlJOVzlmeTJDaUo0aHMzMG5hcFNDQ3QzZ1RN?=
 =?utf-8?B?c1ByYzNtcDJxV0pVUlBRdXlsMWtnVi83dCtuRGRCdGtZc3J3VHlQQ0JIQ0Jt?=
 =?utf-8?B?YStVOWl5cUsyWjFLdFlqTmJicGhXcFBKblBIY1R1cDUwTEVwN1BGMTBiQllO?=
 =?utf-8?B?WGk2aDBaRzhjZDY4clBXMGl5U0w5dU1jaEJEaHY1dWtkMnNVYmd2eXVMd29z?=
 =?utf-8?B?bEZ2SEF2Q3NuaDh2aGs1VXNZa0NjS1JyaWJBbXN6TDlicmx1YjQxTXUvNmJH?=
 =?utf-8?B?NjMrWkh4Y1EyTHpacHJtd1Vrdjh0VFoyOXNaZmVSblExbTBuSFZKUXJzYTFt?=
 =?utf-8?B?V3NPakVPQnEyaDR1bXpqS290NTN5NmFOcVVIVVQzNUZJMjlLZ21uMkY1ZnVM?=
 =?utf-8?B?NGtacFA0M3hpYlF1SnIrVWcwTHBHamR0dUJVWitBK1piMEpiR3lxVTY0N3o4?=
 =?utf-8?B?QXM3UUN1VjZ5Z1k3NmluMytDV2hyTTBTQmp3dDRZS0dlUUdYQmdOVGh4ZnF4?=
 =?utf-8?B?QnArb012RGVGQkhjTXpMYS9rYnJRTFRQNXk4VGxDcnJzbE5vWXptbUFma09y?=
 =?utf-8?B?WW9ZUnJzWlhLZnFsUGZZVXpUS00ydnZCM2Z2UkU0QVc1RVdDQzNmWXJNakYz?=
 =?utf-8?B?VUNmbjFTRG5rbDRiOGJNSEwwRWl1VlpoQ0JickhwSkJDK0tJOUcrQlkwc3V0?=
 =?utf-8?B?cndDYUFFRWtQRWppeEQrdnU3VGhPYk91S3VSclNPNU90dTR2Q1F4VkhMTEQz?=
 =?utf-8?B?b3JadUw4VkcyOUNuMWhXSVRyV0lJdmJxWTkwLzlkZHZaYmd4UEx6cG5IZ0w1?=
 =?utf-8?B?dUV3bmhBbWRFeENJc1p6dGdJdm1BakdXOTlEaFNZMU5iSHA4TGVHc0hwd1ND?=
 =?utf-8?B?ekIrS29SM2dIeDA1TFg1MWxkMWErYzJhc25VN2lWSjhtWkFiVzA2ZUVOZ3BQ?=
 =?utf-8?B?OExxTDBmRnR0d3JJbDFGV1RpblFnOE9HUlBMWUZMd0xlRm8yWExhRURIbEZI?=
 =?utf-8?B?b0FNTU9IKzlsT3BVT05LL1djUVRjdGNxbEJKd1UvbHlRK0FvdUZpN3ZyOWZN?=
 =?utf-8?B?bFBldytlSStaWVdEbCtuZERjRHc3anBZdHZESk9qaU9GMjRZZmUrVzk4blgz?=
 =?utf-8?B?d2Z3SFovSElKVms0SGNScjQ0aGczR0w3QzhvdVJiY09weHFYOG1ZNmlHdVRj?=
 =?utf-8?B?SHdzc1pPdlV0aGI2VHVqaHFZZitDdkVkSXEzZk9LNXZvQ3ZpcGVHVEd1TFFa?=
 =?utf-8?Q?PwWaDj4VMr2sMmIY3T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b821f98-59f8-40fc-ae98-08df352a4845
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9629.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 19:33:02.8802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6TYR6OS6cjMHW9IkTV9b+IaDEECgnra+P1OuhttHJta7AGFmXT2O63dK1HN+y9nzAbHJLGgCOVG/fC/dKsb9QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB365848
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/2026 12:50, Lancelot SIX wrote:

>> -#define HAVE_INSTRUCTION_FIXUP (ASIC_FAMILY == CHIP_GC_12_0_3)
>> +#define HAVE_VOP3PX_FIXUP (ASIC_FAMILY == CHIP_GC_12_0_3_REV_0)
>> +#define HAVE_VGPR_MSB_FIXUP (ASIC_FAMILY >= CHIP_GC_12_0_3_REV_0)
>> +#define HAVE_INSTRUCTION_FIXUP (HAVE_VOP3PX_FIXUP || 
>> HAVE_VGPR_MSB_FIXUP)
> 
> The instruction fixup seems to be doing more than either VOP3PX_FIXUP or 
> VGPR_MSB_FIXUP.  The fixup_instruction function is more than the union 
> of the code enabled by those two flags.
> 
> Would seem more consistent to just define this as "ASIC_FAMILY >= 
> CHIP_GC_12_0_3_REV_0".  WDYT?

To my knowledge the fixup code exists for only these two cases.

Some of the instruction decode logic is redundant if only VGPR_MSB_FIXUP 
is applied. Building a separate path for this case would add significant 
complexity to an already complex function.
