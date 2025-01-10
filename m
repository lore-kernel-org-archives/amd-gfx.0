Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D61E7719F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 14:46:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 563F910F0E9;
	Fri, 10 Jan 2025 14:46:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bsrh2F9R";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9927010E508
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 14:46:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDerhfJpD2GIk6UK+1TW/dDv5YyBw09qa4dLCFnkHdCiGBA5Id52uSNglcotZz85QFExpO81Jk0KA49du9bhe6msiSz4aCKh1sooPWzAU41TqRt9dMNEqNf18RG28XM0vWJbp6cd3R5bSj7MmwHmXmLn+Xt7io4EF3ie7cXBM7jC3/es/BHc5zKw8ujB4GUDAFtRPzsGzo/WYfieyIFlqnNjlAdU81lsl024rSXuK+KhzS37SnBslSaYfjq71ZjRzIW/w7ZphA2Ix1pJiFmqxawhNrjSE8NAJwBlk3XhpOWlHfyu7WENR0DPl4Q73udP8gIW97EeTgzJ6BVS8hGb5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0Lp4EhHNp0KCevjMGQiMWT4Jk8+sgsxliWXzjwbI7w=;
 b=ieC8Ks1RSxh0u6vV9ISx3aOVzxnue6WA7sdwt6o+vNvm3DSnEog+87HJEuVZo/8anfu5Sh9LzTr6le8UUulPM9SB1gHEQnVlw0ULR6VihroYJKfkpkxA3a2tLWBkYKUkF0oLzl6kU7Nm8gzzwG+7XRFyKYmbMvhYqGRP0egSaNufobL+tjYwONWUGYUjI1qccbbRjvIehvddkiqAZMKQZd4tRREzR+o8HKqN9Ezf97uGMUY6/s0Hy6ChVb+i7kZUsywlZpVSR8h+WHahGI4LyVrmXZxlGkQMJjfbHt/zE2H0Q/voMfgcd3tZJt54kLvpfhC0Ug5MhQnQv/OA+hDxkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0Lp4EhHNp0KCevjMGQiMWT4Jk8+sgsxliWXzjwbI7w=;
 b=Bsrh2F9Rc7mq7VFvdCSWbDGzBcOfWK8dvOFVXgwiUlmlhcVf/sAZLBv6ubQEjCfZouorsgPnXjKuIDumazi/tLujjgQootMwHGz6/Y8CBjlW0MecjdVxW0SW8ufS8s+2DJawZVSKUiOzkVZrlvNDnHNTT7+He2ybC+rXLy5RS4U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS0PR12MB8270.namprd12.prod.outlook.com (2603:10b6:8:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 14:45:50 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%3]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 14:45:50 +0000
Message-ID: <a302ec12-a91f-0d95-6452-ff5abb4acfd4@amd.com>
Date: Fri, 10 Jan 2025 09:45:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5] drm/amdkfd: Fix partial migrate issue
Content-Language: en-US
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250110142511.1442811-1-Emily.Deng@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20250110142511.1442811-1-Emily.Deng@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0198.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::35) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS0PR12MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: 1990bd18-493f-433a-47d6-08dd318579ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDBGYWNBWVpPSDR4TXh4RlRjQk41bmpMNnJLS0JqNmxzS2NDQmJndnFoSjJq?=
 =?utf-8?B?SzdCdUpueThGU3FSRzc5WGJremFYWkxhMytKVEJDakFUcDExMERsKzBQT0Fz?=
 =?utf-8?B?NThKMTJmRlRWSDhOUW1WYVoycmZsU25PdzZnbG1RU3daVlQwdE91VzRQcVpu?=
 =?utf-8?B?WlUvU3Z5dmxBNjVGS0JjWXY4NTRRcHVWR2ZLcis2SjBOTzVnV2FpbFRLRnla?=
 =?utf-8?B?NzZNM21mT0dLRzkxWUdIVnF2WmxVRVAzcHBIS3BpUEtvWXQzeXlMQ1c3UHFX?=
 =?utf-8?B?cDdVOEJqZHN5Y1c3anRoZzNRTXRzam5xSnc2V29sa2UxZGhnNXVLMDFaL2NI?=
 =?utf-8?B?VjdXWG5HSVg5SHJvVjJ6WUtBL0VBa3BDc3YrTE5DOGdnczNZN0lEUWoxUHRU?=
 =?utf-8?B?V3FEVUJXazE3cWdDYzUrY3dtc3crMU8zcWh2QzZncE9mRFo0bERQaTdBOXRI?=
 =?utf-8?B?U29UR0pVQ05XWUR2WUoxbUpDNmMzZjd5Z0RmMnJxWTJaYk5VUklldEJZVnZu?=
 =?utf-8?B?TENvL09UNmpjNEYzZlpXSjFKa1VoMFFYd2x3NDNlUklFZzJOOEE2K1BMVkRk?=
 =?utf-8?B?ZENTd0tKVVRzV05FUDV4d214aURuVW5sOGNFQVlzQXU2RGswV3pRekhSZ1ZH?=
 =?utf-8?B?akluckMrdGtJS2JLdEM0TnQvSHdBa3M2SnF6OHBtRDJoU2VsMFhHcUlSSG1F?=
 =?utf-8?B?NDkwV3c0SkdsZm93L0lkdGsrTUNsZURjTzFjNnVHbEkreHROZ0djUk9iL01N?=
 =?utf-8?B?UFBSUWxTR0JWVmRuT3Y2ejJBQk8xOGFWMHdVdUo2blFFOXV4a2I2eHZBZGJI?=
 =?utf-8?B?aHhnbWVZZHFsemhFVklsYnkyeFUyU04rNmRvZFNIUEVZVEZhUmlrSERVNEZm?=
 =?utf-8?B?dktrY0Izc1BlRmZJMDNwRFJvZlRKUXBiMHBMOVNVdGIxQ0RzbjBmU3NPWTJU?=
 =?utf-8?B?dUZqZSs0eGFIWjRMbEJ5b0VsZnB1bU5RUG9VU0U0VDQxTitsbGM0Sm93MTNt?=
 =?utf-8?B?Q3FkOWxINGFpTnVBaWgyUXpIejF2TnVjQWNMN3FRbCtVYko5ZVZLcW1lV09r?=
 =?utf-8?B?RUNmUGFiTkpBcmJOekRiMi91aitOcEVBUGJQOWR0NVBYOHQ1WXA4aGRoRng1?=
 =?utf-8?B?d3hyVUtjbXJqQnd3MzFpZnl6VzR4c2NPM1FYV2hTQzlmTnF3NUMxSE53a3px?=
 =?utf-8?B?UjdqN1VCM3pDV0pjUEQ3UC9qczZ5bnAzTi9VdmFiemNRcEprUHNlOUVyTUdW?=
 =?utf-8?B?TFRmd0Z0M0QyQnQ0a0RZeXFrYTdmNVh5TVFDL1EwSyt6Mmhib3M5aGhxUkZY?=
 =?utf-8?B?QXV6ckxpWUdzUnd5b1htYk04d2J1OTRUenpvSkVCNXZxakdVTUNEamNneWtl?=
 =?utf-8?B?QTY3NWd4dWVQYmRYZ0Z6TDk2aFdTUHI5OC9VbWNJSjlQN011bVBydXRhMHVu?=
 =?utf-8?B?ZUsweUlYTytjckx0cmZZQm0rWU16U1lYSzJZbHRvbFZMdVc5ampQQ1pOMWEz?=
 =?utf-8?B?R1hscDZNWVhFZHo1TXgyeUtNOWlPcURtYnNBV1FCR1RLTHp1ZktqYTRUTDVS?=
 =?utf-8?B?eXlIc25MbDZDeVluTFovdG1RcWx0Zzc2Si91c210MFNlWVlyNEw2VkFWZHZu?=
 =?utf-8?B?SjFic1hKdVV6cVM1aEllY3VZV1I3dEEwYmdZbHFwd25BVStLR3prbVoxQldr?=
 =?utf-8?B?bzk5OXJXSytEZG5leXREZ1pYcUU3cW5nOUN3RjFPVVhpb2pLOE96bFpEL2th?=
 =?utf-8?B?emFwdkY5aG5jWHF0QlFtdUhGVEZSTTVGalRQWk9iK0tzZG5hZmFBS1pmQmxR?=
 =?utf-8?B?L25XaDYzTVlDMlNxaGJ3a0NoSFE3NjgyeWw1azdrVXFka3I0K0Zjamk3V3o4?=
 =?utf-8?Q?Mzb2pepFos/o2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmJ4ck55aGN1enZTamZvYldBVkpaZnRKQ0V0blFCOWszejBweUdiZzVTQ2th?=
 =?utf-8?B?OVk4Y3BBTEtrUFBnMjF5eUtMMVVNM0pUZ1BWR0xDMHZzZ3FxaUlMMHJhODlL?=
 =?utf-8?B?eXkxaW1DNmpQYnI5dHpwTW9Gc2kyMGhoeWRienVyRS9jNUN6WUNIRDZSL244?=
 =?utf-8?B?SFVSV0tRYjZWRi9SS0RtRWZ3a0dOcUE0UERHSDM4WUc1ODRlbTMvMFNDWmdT?=
 =?utf-8?B?c3dkV1YzZVkxZEhjNkdyT2w2enBQVGJnTnN6cHJNOFNmaHRkYnNNN3pOWSt6?=
 =?utf-8?B?ZW9ldERucEU5TnkwTXpHcG52c244dDVpRklxcmlXUGNETTVZL0RRNG1JYVpw?=
 =?utf-8?B?emMzMTZlVFNuUjJwZjI1UzdqZHJyanhEWkhEVCtnQ043NXRKT2FEQWloY2pX?=
 =?utf-8?B?aVA4ZXpNK2xGYmlLanRsWk9Dc3VQMlEzTG9PYjNkd3RTQjRLNmM2TnQ0THE4?=
 =?utf-8?B?NTFTSDh6alVHV2hEbEtjU0Fod0VzN1ZSRk9sbG02bGpYeDBLVGUzQmMzdGlm?=
 =?utf-8?B?YWpRZU1RMHNPVGRaekIzMEhjVTU4MTkrT3lkbzJ4UUdvcmR2MzNIVTJMRUlB?=
 =?utf-8?B?RzNoY3pOejlNQXdmcTEyK3VsTStaMVNvZEJVM016OXkzUHVjMElYWXAvcnRs?=
 =?utf-8?B?Y0FoZUxlTDV2K2dYT2FRd3JZdFN4T2pZck9CTGppNTNOYitkQlZKN09OcW5q?=
 =?utf-8?B?cnFlK1VRQ2tMTit5Q2hZOUR2YUdOWHoxbUxCM1o2K3V6NVU4eEVwTW5vU25F?=
 =?utf-8?B?RlVoZzRhTGczZTJ3Tm1hWGtodGJMWVN6b3d4RGtxUFZxUzlZSFZuYmR1R3ZI?=
 =?utf-8?B?RFBDT3d5a0s4TVM3Y0U3MlBQZ2hTam1qSmt6Z0tFQ3dYdGpwdXdDZDhjaXhO?=
 =?utf-8?B?WEtOaG1CSzhwalNwaGs1MU9sOWxaTm5qY0lzOUl0SWJuK202b2tnSXV6QUgv?=
 =?utf-8?B?cFZJVTE0YXNYRlpxUGNvTWduenJ0SXdCeklINEp0ZENudzlTYkQvQnc2SHZK?=
 =?utf-8?B?Q2RKQTVHQVZKbmFUSC9ibDRSWjFVd0RRMEt5RUNxKzlsM3ljZVpoODYwMTNH?=
 =?utf-8?B?R09pbjFZRkNvd2tZbEJ1elBicjhCenpqZHpGdWZ0dWsvamtTdTR4ckY3aDRo?=
 =?utf-8?B?STh0MEkrOUt5ODVLcS8vclFlRzJieUx2dndmVHpOcDBWWW9BTnNkMzF3UXJj?=
 =?utf-8?B?WlFKdzRJYzVHMU5aTEVnZW9DR1YwZXhuZFRlZzNTVmwydnBTcjJuYVFROGZ5?=
 =?utf-8?B?b3ppbW12cHdGbTZCRnNnajMwQng2ME9kT0w3NHBKdjFiUnhVOUNiYXZZRVJG?=
 =?utf-8?B?UVl5RDFDaWNWUGo1dXB6Vlpqc3krNTMzRWhiemFBUVMrZXBQK1I0clJlNjEy?=
 =?utf-8?B?NmxkYVFEdCtxdU02d0tVanFReGdPOUJ1ZlB0L0RKRW5FdTJ1cUhlNk5DWGts?=
 =?utf-8?B?cTRMU0xRTkxDUURkb3FkdXh4SjdBL3BUMkM1VzNQVHJIaS9IZFVlVUtoN1hv?=
 =?utf-8?B?SXpwandsTDF3NmxtN2ErK2tWWGFjNk1SempmL2MwR2xNTlo3dWVka3NjVEZa?=
 =?utf-8?B?TjZoNTNYSWFRd3NPMVU4Wm9kUHQxRkI1cm05bnQvNCt3cVZXclY0Q3piL1Ni?=
 =?utf-8?B?YmNNOXFHYXUvR3hMN3ZpWi9OOWdjZE1SMlZpRjd5eHREREFqQmt6aTVpM0gz?=
 =?utf-8?B?cEFXbGNaTHQ0bVdiZ1BHdTZOMUpReUVUMXU3RS96TG55QlhTbjkwNmNhTzFt?=
 =?utf-8?B?Zk9HYzc4blBENXZvWVMwM2xyT21kQkp0SUtCVnFIR1c2cXNUSkVGcVVOTkJw?=
 =?utf-8?B?RldjRkhjRkpxRmNUckk3OWloVmNKdVhIZU1ndk0yUkFDeEpoUVlxK1RDOGYy?=
 =?utf-8?B?OUFLVUx2ay9VOTVNdUZNdFgyZS9qVHMyOVBwS3llUFl5NG1JMGFjZzJlMmQr?=
 =?utf-8?B?YTI4TVBKTDdyakRXZU9kOVRkKy9ScDg5aWsxb2FlSHRwRTJvTTRPMWlOZHN6?=
 =?utf-8?B?NmdwaFhERXFiYjY5YVZ2eVFObDhyeEJJY01YZXd0bjBjYlpJZ0ovYzJ1bDAx?=
 =?utf-8?B?b0ZrLzFaTFA5c0JJb0QweXY2WFdWbCs0NDBXUEc2SEtvUXJ1N2RmeFluWDZm?=
 =?utf-8?Q?ADOecKuJfMTj3/r70hagQXnkd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1990bd18-493f-433a-47d6-08dd318579ef
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 14:45:50.4034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mh5gbu6zOLu9G+ZPUO1LstsSd3896O8uF2agFkxLAXD/S8qtO5nxMapjOQla1wBp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8270
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
    <div class="moz-cite-prefix">On 2025-01-10 09:25, Emily Deng wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250110142511.1442811-1-Emily.Deng@amd.com">
      <pre class="moz-quote-pre" wrap="">For partial migrate from ram to vram, the migrate-&gt;cpages is not
equal to migrate-&gt;npages, should use migrate-&gt;npages to check all needed
migrate pages which could be copied or not.

And only need to set those pages could be migrated to migrate-&gt;dst[i], or
the migrate_vma_pages will migrate the wrong pages based on the migrate-&gt;dst[i].

v2:
Add mpages to break the loop earlier.

v3:
Uses MIGRATE_PFN_MIGRATE to identify whether page could be migrated.

Signed-off-by: Emily Deng <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 4b275937d05e..edff564d6a3c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -278,10 +278,11 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 			 struct migrate_vma *migrate, struct dma_fence **mfence,
 			 dma_addr_t *scratch, uint64_t ttm_res_offset)
 {
-	uint64_t npages = migrate-&gt;cpages;
+	uint64_t npages = migrate-&gt;npages;
 	struct amdgpu_device *adev = node-&gt;adev;
 	struct device *dev = adev-&gt;dev;
 	struct amdgpu_res_cursor cursor;
+	uint64_t mpages = 0;
 	dma_addr_t *src;
 	uint64_t *dst;
 	uint64_t i, j;
@@ -295,14 +296,16 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 
 	amdgpu_res_first(prange-&gt;ttm_res, ttm_res_offset,
 			 npages &lt;&lt; PAGE_SHIFT, &amp;cursor);
-	for (i = j = 0; i &lt; npages; i++) {
+	for (i = j = 0; (i &lt; npages) &amp;&amp; (mpages &lt; migrate-&gt;cpages); i++) {
 		struct page *spage;
 
-		dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT);
-		migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
-		svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]);
-		migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);
-
+		if (migrate-&gt;src[i] &amp; MIGRATE_PFN_MIGRATE) {
+			dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT);
+			migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
+			svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]);
+			migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);
+			mpages++;
+		}
 		spage = migrate_pfn_to_page(migrate-&gt;src[i]);
 		if (spage &amp;&amp; !is_zone_device_page(spage)) {
 			src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
@@ -354,7 +357,8 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 	if (r) {
 		pr_debug(&quot;failed %d to copy memory to vram\n&quot;, r);
 		while (i--) {
-			svm_migrate_put_vram_page(adev, dst[i]);
+			if (dst[i])</pre>
    </blockquote>
    <p>For error case if svm_migrate_copy_memory_gart failed in the
      middle of for loop, i is the last page index, the i-- could miss
      the last page. please use the change in my v4 review.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:20250110142511.1442811-1-Emily.Deng@amd.com">
      <pre class="moz-quote-pre" wrap="">
+				svm_migrate_put_vram_page(adev, dst[i]);
 			migrate-&gt;dst[i] = 0;
 		}
 	}
</pre>
    </blockquote>
  </body>
</html>
