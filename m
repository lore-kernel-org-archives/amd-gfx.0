Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC45C02198
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 23:02:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B29F10E105;
	Wed, 12 Feb 2025 23:02:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h8TWB6jQ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 230BE10E0DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 23:02:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5r/l2AQuSNd2gwG+DNrkcBTZad1uQDYzAULNtTceL3jUzH+8gUjE87qLG9tplI8WGJ4QECXl4wCpUI2CjliA9KEqFrcuC0Go5f67/Hx2kzfj1lGw7Lj9d9verjjEj8JQjh4io/39NE5Lb7noFoZFApQPXGajS1WeumA32Upx+/yrdC5jSGHsh3j0jwgq1LIIH1U3h/XW8bV+ivUXJJqgCXaojoSNezgYHROzpX0cqljho9h+B8k6BRcn5j0l/ytbNiGUY5BKY+cJk3n3zg+IUL8L4pSsICID/DmTgZcXArsOJlwfBU2DKmaQdgY4TqaFyKruPhJ9i9L3MiA1sKroQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jo0vpRqjLczrUxT2wPlCQZ7UheQnvj5ZshhTWuuhXdk=;
 b=IK+4wHjFp/QVH8F4COpDvLAVfT3zT1DFFcUZvV+exCGWXCdm/MnBrodgGljnAL7fjtg4q7Of6liXn/K30Si+IcqWcvekisr3JjlHdNR4BLn6xneUQAlU65dlWPH//Cnl7ynM5HCnwg7nJy3ZGEVD0Yxf/2phPLCG4lG2NQbF/v3yj130l4pItJdzRfKRajw02BusjC3TvCSqZ8GzrhEj/9bp1eE1j+o1a+XsXCJCVa+vhgD7uXuswt0oKpbb8T1nIoWZXlgezA+aNCFQFTzESid53cDZL6GJiBz8fscBPc53Han4kr9m/HhuMtKtgC8JupYMKCp44ZKO3srpPN1s+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jo0vpRqjLczrUxT2wPlCQZ7UheQnvj5ZshhTWuuhXdk=;
 b=h8TWB6jQ1O8pxeUl7AdIZT6/ZJfNfRjCCVeVXaDJAy+A4kI1JpeygwfHykqXPAeYGFxZ8GQsRNFMKr+T88gkKgrkLAL4prZUTjETdXU5cC+xH3xgvvvYX9Lr/xXE2YgDz6XAi+VztpaNdbRPhClfYZQUVS6WeA1SuyS+5WkGsVk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by IA1PR12MB8309.namprd12.prod.outlook.com (2603:10b6:208:3fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 23:02:17 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%6]) with mapi id 15.20.8445.008; Wed, 12 Feb 2025
 23:02:17 +0000
Message-ID: <315e27ab-f1d1-a681-a32f-1fc28cd81193@amd.com>
Date: Wed, 12 Feb 2025 18:02:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/9] drm/amdkfd: Validate user queue buffers
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@baylibre.com>,
 Philip Yang <Philip.Yang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Felix.Kuehling@amd.com,
 Alexander.Deucher@amd.com, christian.koenig@amd.com,
 regressions@lists.linux.dev, Dieter Faulbaum <mail@faulbaum.in-berlin.de>
References: <20240718210558.26340-1-Philip.Yang@amd.com>
 <20240718210558.26340-5-Philip.Yang@amd.com>
 <zpzehsckjz2bee6w5bsnfpmkvtlxf6jywijz7iroausghoh43i@nxr644rwjsb3>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <zpzehsckjz2bee6w5bsnfpmkvtlxf6jywijz7iroausghoh43i@nxr644rwjsb3>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::26) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|IA1PR12MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: 63e9e41c-6edb-4ad8-12f6-08dd4bb94c2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UTBQd25PUUwwQXBuT0ZpU283UFR0MGt1Vzd4aWl1Mk15b2djejZoNFNZUGdi?=
 =?utf-8?B?TytDeWlTYk5tbitSWjNVWmVSaVVJQVJrTTRtaDloL1hIQUZVY3dyVFB1S2xy?=
 =?utf-8?B?OVBCc3pRMTlHU0FYaHFhck9GejUweXdHbmtoWklkNjdRMGxrTWZ5aHkwS3J6?=
 =?utf-8?B?VTJIL3V5R253ekN6WmZ0aFVBTGYrS2RwWXBvWnJ4enBoZDh0WGpVSFFFT0tu?=
 =?utf-8?B?ck9waTRrcUpZWDlyS2xsRnlWU3Nmb1drREt3R050bkVRK1BzRkUybWVhWHpB?=
 =?utf-8?B?cnpLSUQyZHB6cFluQlg1M014ZEpRRkgvOEhWR2FCT3MzK1U3a1N0cCtyajdE?=
 =?utf-8?B?bEUvSzNhb29yNHRaTXJpM2EzbjFmalhuQ2d5NnMzZUZDTFZaMGlmc3hOYkYz?=
 =?utf-8?B?RHo0NDhxU1JLMUZ2aXEvMGxOSk9MMGw2Mlk0TXhjQjU5MFpxZE5kV05TRXhQ?=
 =?utf-8?B?Q2QrVDI1OGRWK0E1TnJFaUZoZ1V1ZVBYSDVRRVloTlhqQWFwSUJUY2k2cTVG?=
 =?utf-8?B?Wkg2K1Y3UG9Lc2hoclZPWC9DQVlMeU9mRGJnRFdWTFhjSDgvbUxOOXRFYWN0?=
 =?utf-8?B?RTE4c3p6bXlsQUdtSUFpUHM4V3hkd0Rpa1dCdHVDVE1aWnI2VUJMcU8zdWVI?=
 =?utf-8?B?eFBUTW9KSVNHRHhpckcvRVFOYVliNXV6L2s5MVduNlN1YVpoQ1RGSDBxSzBZ?=
 =?utf-8?B?VDhjNmtwRkVPNmNrTEVMNEJoNW9XSXlmbWt5eStGWllOTmFISEZycEYzT2h2?=
 =?utf-8?B?bWlxeWVic3ZVUWxoSUprQTF5ZFBCMUhvWkpibmtXNGgyeXorcjBWU2dLU0k5?=
 =?utf-8?B?NS9sbjE1cEFKOS91clFIVmNmeGRTWVNxSjZ0RE9YRGhFaHR6R1FJem9TRVJk?=
 =?utf-8?B?YmtZWUpZb2xHK21JSjFQdW40YUJ5WmNwQ3dqKzhMN1Q2c29iWFlSbTJiSVd2?=
 =?utf-8?B?T2pNUnVBOXYycFVnR1Q1RTA0a1ZTM1hGaDViQmw3a1ZFc1FCT1pTRk1oSFJx?=
 =?utf-8?B?YUE1TG1IN3Q1endESVFmRExNNDFyRk1mb09uNlVzV0lYMTB2MzVYcUdjVnZH?=
 =?utf-8?B?ZXUxZ0ROZXRJR0JaSUJ5MVk5SjdaRkNiTzlQOS80aEF6WkhDaWExU1ZaVGJn?=
 =?utf-8?B?YmZOUzdXdUF6UFdNRlpmSXNlL2RwWjBuc0VjNlVGZmhKaS81NGhkdDY1VC9y?=
 =?utf-8?B?dUowYTJRS1NpNUY5QUJDOFBqRWdpd3V1WW9YMCtGdDJyYlpUYlBRSGZQY0ZF?=
 =?utf-8?B?blA2WEFFd3ZlQ0pWVXFDQlZjbUttWXhFQlJzWXZ0OGVhTGpIckhTTmV3cm5R?=
 =?utf-8?B?WFo2VGc3QmI2cGZYV2x3UE8xYXM0YkRpWnFadmJWYmRXZ3NmdkNGWFYyTXBs?=
 =?utf-8?B?UFQycU80aVpxdHVWamx1QTZlTUw5amZUVTZXSWNhbk9NSUtoTFcxdmxYelpq?=
 =?utf-8?B?OHV0UW5EcGNSU3NlNWlkSWxpL3JnUmdPODNoTHFIVmlRTmJYSlovOGpDbWRV?=
 =?utf-8?B?c2ljSkwzQVBmelZseENjZGxyWXpvdTEzUnArdktJS3hkbzJjSnlnRVJGdVBw?=
 =?utf-8?B?eTJweTJYVDRuRWtrRzlJU09lZUIzUVFHdlZCdnFOdVlXai81SDREUjhEemlF?=
 =?utf-8?B?ZGhTQktmalcrYVl6OXd0S01EbUJTZGd4TENOT2F5VEMxazRkSjZZR25aYTBG?=
 =?utf-8?B?TFdwV1k4clZCVVVNTjlpaGNPWHdaclQva1B4ZU4wZXJ0VFBhWjhNZDVGL0px?=
 =?utf-8?B?a05HUW1sdllrMmVPeGFNYUo0djQxOEcwNjh4cmN1OEhDaFBkWWZQbW5WREE5?=
 =?utf-8?B?c3UzVzNmVmw0MmVjdTBQZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmQxcFVxb1BGVmpSa2pVaCs1UnI0QkJ5cWNadjdhK3JIUk93TzkrTk9hOTht?=
 =?utf-8?B?bnV2UW9IaVB0cWNIQkRrVDh3WG1RNUZGUjdBeDBVY01sRWNjdzNVNnJMZUFm?=
 =?utf-8?B?R3VCOUZmOVN2cFIxZ3RwMUFKYjNrUUFUbXZsUE9MTUl5SGk4b2RkOXIvTmN1?=
 =?utf-8?B?N3RsN3JXZll4STVUVHFrZ2F3V0dXS3RTNzJCSzNPcWJERHFMdnVuYys0aGE2?=
 =?utf-8?B?ajltSTdNTTRjYzdrU1dHUnZZYVQ0TnZXTGNBemRiOFhVMHZ1VXlVN0MxRHZM?=
 =?utf-8?B?NlRGOWpldnZtNktRRjQ2MVVCN0RVV01HVllpVHB3TWRXMHdDRTNZbFJCcFQ4?=
 =?utf-8?B?T21SQXIxR01meXRJZk1vOUlYMCtQSFIvR21ZVXBLV0VkTndqOVIwV2JyYnJt?=
 =?utf-8?B?SnIyNk9aTkdrQ3p2WXQ4MW9qUDR5QVlzZTBPS2FlNVNyN05qYzNVT2hYY0Z0?=
 =?utf-8?B?WjBlTTVVNHAycEVOc1RKMUpEODlScENNMmtYS1NoZmVqOW9SK3JveUowTU9a?=
 =?utf-8?B?cnN1bW9RbU96eEtvNEdnNGZMUEhLQ2NwWGJyblZ4azc1d1U0SWFhQ3Q5VTND?=
 =?utf-8?B?ejZZQ2R6S0tLR3BMYmpwdnU3bk9JZGRaMHdZY3FBWXJobHExbnUwWTduQURJ?=
 =?utf-8?B?RkdqUFY1dlV3M1hrcmF4eW94azRyK0J6MU9qWGp6WFpSQWJuc0lOazZEaTJL?=
 =?utf-8?B?VHo5SWQrcHJ4b3J0d0NVVzErL3VxekNJc0NLcW9zdVRlcG5Ucy9uQW5aZFhv?=
 =?utf-8?B?TkdrTndmd2V4RWZPZUloSzNiK3EzU3JHSUt0MTRiMThZUUF5OVdBZEttdERL?=
 =?utf-8?B?OW1Qb3V4MG9uajRCYzNWSzdWbDJTRDM0citGdzFKektyd1VZN3M2em1uWGsv?=
 =?utf-8?B?OXlzbmV3a1ZoOGtsRWdmdXkrc3J6U0VCNUZuY0xRYnFUdUV6UXF2cncyeEl5?=
 =?utf-8?B?dTRyMUxwZHRiYTdZOElJWlZHWGZoOVp2Q0Q0bzUwamdoM214T2cveFc1OHpW?=
 =?utf-8?B?SjJXSzNtNE9PanNRaHoyVVptMnFCcWk4UnB2NEZkeFpiQ1FYMDZWc0JqemlV?=
 =?utf-8?B?MlRybWxOQzNoZStxcjhKZUltS1JZTHpRUXhRWHF0SkR0dEdDU0ZTcThWWmZU?=
 =?utf-8?B?Z1hTenNpeURIMGFpeWJqUWVKVFhRTUNWb1IyV0NCYlhLeWxpOURGTExld3Nq?=
 =?utf-8?B?bjA1Ui9ZNGdENzB2aXBHS1Z0NHVsQkUwWjNQMVA2Lytxc1YwSkhBSCtkd1cr?=
 =?utf-8?B?Mm1ZZlRkaWNNSGFrTlpidTRQWGNqR3UrclFhRXJ5bmJpQWxZMCs4dUJtNDJE?=
 =?utf-8?B?ZEhxTHJVdVN0eG45NGpsZFU5N0pJQWNneEJRYzNFQzJlQldqZ0hoUS94NS9I?=
 =?utf-8?B?SDE1dHArQzc2UWlZTERMbW5XdEFLTk8wdWMrUFBaRldudzNXVmc5ejBkdkky?=
 =?utf-8?B?bFNoY0Q1Q0NCR2FzRXRLZWtiSTlURGRKTkxyOXBMdTJTRjJtUjFIT2ZnVGxo?=
 =?utf-8?B?aU9FdjdHOVNUakNWVVEzK2lmOWp3UDJQZFQ5cDkzMHIrVWdqTzg4TkpxR000?=
 =?utf-8?B?QThyMmVzc3lrSmVOTFEzeUFsVTRDMEdWbFh3Z09FSzVhSlk3dzFLTER5ME1P?=
 =?utf-8?B?S0lQOW9rZVY2c1p4clIyZFB4eGJXbExvSysvdExDQjVVOFNta1Bwa2d2VC9W?=
 =?utf-8?B?bGR2SEV1QlpEUlhQV1g4NlV4cjNkQ3pzZnh4WU5TeURMWk1XT2xUdGNRMkF4?=
 =?utf-8?B?aHN5dWRVUk5BZlZYMGZtWXVCZWc0NnZ3d3l6dG5UblBQVlJnZmtJWjNTeloz?=
 =?utf-8?B?OUUxbkRoS2Z3VWwxc3BtYWpkREhlaXY0dURwNnVPTzJ1emp1aHhUb00zMlkz?=
 =?utf-8?B?TnkxdjNoeHpFUkp6SUFxN1kya1FGTjBNV1NwTUlCQ3JmejFXdkZVWk5ONWxE?=
 =?utf-8?B?M2FNeldRN0ZpU0xnVWtGejZaMi9hWDR1bGQwQXdSdFBDMG9TY2cwcytZbThY?=
 =?utf-8?B?VHZlYWgrZGp4WWNVWmw4ZXJpRUE3dU4vV0xUaGl2UlhhTTBFZHpSQ1pWb2dz?=
 =?utf-8?B?SEdoRUtDak0rb0tOS0Z2WTYySk5wdGVRdXdZWm1nT0w4MFhGUkt4YnpXL1FL?=
 =?utf-8?Q?yQEd90DLgNejsda1KUJ2Wfhvu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e9e41c-6edb-4ad8-12f6-08dd4bb94c2b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 23:02:17.6744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h52EN4x+MbtcZ8HLLQFqa2cRkAgrsvH4cx42RV5JL6qm9XTiMrG7zmgKyGs2EPD5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8309
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
    <div class="moz-cite-prefix">On 2025-02-12 17:42, Uwe Kleine-König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:zpzehsckjz2bee6w5bsnfpmkvtlxf6jywijz7iroausghoh43i@nxr644rwjsb3">
      <pre class="moz-quote-pre" wrap="">#regzbot introduced: 68e599db7a549f010a329515f3508d8a8c3467a4
#regzbot monitor: <a class="moz-txt-link-freetext" href="https://bugs.debian.org/1093124">https://bugs.debian.org/1093124</a>

Hello,

On Thu, Jul 18, 2024 at 05:05:53PM -0400, Philip Yang wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Find user queue rptr, ring buf, eop buffer and cwsr area BOs, and
check BOs are mapped on the GPU with correct size and take the BO
reference.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a>
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
This change made it into v6.12-rc1 as 68e599db7a54 (&quot;drm/amdkfd:
Validate user queue buffers&quot;). A Debian user (Dieter Faulbaum, on Cc)
reported that this change introduced a regression using a gfx803 device
resulting in a HSA exception when e.g. darktable is used. I didn't even
try to understand the problem, but maybe one of you have an idea about
the issue?!
</pre>
    </blockquote>
    <p>Try this patch<br>
    </p>
    <p><a class="moz-txt-link-freetext" href="https://lore.kernel.org/all/20250130000412.29812-1-Philip.Yang@amd.com/T/">https://lore.kernel.org/all/20250130000412.29812-1-Philip.Yang@amd.com/T/</a></p>
    <blockquote type="cite" cite="mid:zpzehsckjz2bee6w5bsnfpmkvtlxf6jywijz7iroausghoh43i@nxr644rwjsb3">
      <pre class="moz-quote-pre" wrap="">
See more details in the Debian bug at <a class="moz-txt-link-freetext" href="https://bugs.debian.org/1093124">https://bugs.debian.org/1093124</a>

Best regards
Uwe
</pre>
    </blockquote>
  </body>
</html>
