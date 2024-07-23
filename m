Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1994C3DA63
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jul 2024 21:02:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A65410E645;
	Tue, 23 Jul 2024 21:02:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MQb+JOjy";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F6A810E645
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jul 2024 21:02:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRdoNX7CjwqRU/v39/MLF+4J9CdOrXvjH2G4PyQZ5E+xbJ4h1WMKaZfy2SkJ3uouULlvx3up7yHMcKH8Aii+b5nqwSvsmugqaHFwVhVJkB0P7cLZm4n4akAzxvEL+UerD0wOvqZrAu0nIun23GfUmYwIReAxCftBAKVPwWJYByDHPRuNQg5ek+IiBzaLnajvhtm/72oulmuBSKvycbohvvOosHNY+j3fGvzngvoMZDCFyA9bf88aik6OPNeF9+mF9jOe0137h/9KlJCsZ+aWjimHURdY5LkEXv+lmVHSUh2tQIuxn7bFATT94ZTW6RtPyqBBOnSSBOV5rjtIyeOlfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcf7reWvm3nGk/t6tDlXnos5cxXhcgR8AEN+9gYNjf4=;
 b=BqywlduPfsfn/yVXSI0ZZG6kkhem8Dl1SwNP3StZkxcM+WOnVggSMb91IgYYNLDJ9LY46NOGxZclgubRG9RrmKYZEZWrE0xzeWmId1YIqVE+Qiq4XbINJPB/oC0OF5bY3uo1mXWTjHuzJuJJiwFs/IVmMnNmRDH9wKfGJ2q2rJepD9QQXvNqkNMBpmaeP6RZk2R5qNy/09WUzuAVV0kAQz8gd+XxfIkWEczh2xytqehv96TaLXkxkubaMVKua4Pv8FIe/1TgD0KlsjPQXjxHSZweoHS5JeNdMrs4yrdp9y0rS8j9pvLGCqQI/wr2Lvu9yXe2iOd1Xf8ZhANF+CHsuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcf7reWvm3nGk/t6tDlXnos5cxXhcgR8AEN+9gYNjf4=;
 b=MQb+JOjyxTwdZF/NmoWJ1TfOV2cKiqlbJYf8VLA6rwtc67Voms+e+XM8rJADl+ZxQ3UJIH7GYyKeojfbke/lhcijEhkHU3KlIIWBtELVlD4aDBPgzfLVX9teBrmZ/nKHZRKdsXFoM/cCgnnbop26f0V/huyeBr4ss+xAgRcsrF8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS0PR12MB8017.namprd12.prod.outlook.com (2603:10b6:8:146::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Tue, 23 Jul
 2024 21:02:26 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 21:02:25 +0000
Message-ID: <6b475d85-12ee-3732-4d96-05647374d773@amd.com>
Date: Tue, 23 Jul 2024 17:02:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amdkfd: Change kfd/svm page fault drain handling
Content-Language: en-US
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com, Philip.Yang@amd.com
References: <20240719221738.26840-1-xiaogang.chen@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20240719221738.26840-1-xiaogang.chen@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQ1P288CA0009.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::17) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS0PR12MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: 02f09496-6fc6-413d-b14c-08dcab5ac144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3YyeE5rSG1kaTh1bUxHZ09FQVR2b1c4NHR6TkdmWVJBYTgwakpQZWpoUHNx?=
 =?utf-8?B?c0dTQUN0ek8za3R0UkU3QjFzRUd2clBTclFVSlB6dDVMWTlSZ2JKbXdnN1NL?=
 =?utf-8?B?WWVub00rMEp3WnoyNjlMQStteW1SOEIvOTY5OHdBUUEvZXExUlJCYlFOcWlY?=
 =?utf-8?B?bkx6RG5Bb3EzcHBwNHR3c2JtTVRMZ25XT0lneURSZnVLNnJ3RGhROXpseGpr?=
 =?utf-8?B?R0JQOHFhREo3TW44VUdscXQweStlU2RBMUxXQ21sSTcySlVLU28xVWg1QjB2?=
 =?utf-8?B?c2hreVpQMFJBditTWGZUM2Vrd1R1LzNLb29tMVI2Mk1XbkVhQWlVUGRUSmZH?=
 =?utf-8?B?WlMxbUR0NmZzMnR1d3VwUXFXc1pqak1jcXg4cUE3dmx6Mkx0U1dTbVg4WGp4?=
 =?utf-8?B?QXkwSHRJSGFUMHVidXlMYytFaURGbE9RSHk2Z1gzVGthdmEzQWpKc0t2Y2RQ?=
 =?utf-8?B?dlBud2oxNVhzdXE5dUljd3UxZVNrRHpZZndXMTVQOUZMMDE1WGllSDNzSnpT?=
 =?utf-8?B?ZEhEOHE1MWU0SmFQL3owMmxXZ1REMndNTmxoc2Z6c2h4WVVxOTlRSm16UFJ0?=
 =?utf-8?B?RWF1bGN1SFRhSmswV2dxRFNERmwyMlVpUC8rMk9Xb01hNXNiNjZSZnRxaFNr?=
 =?utf-8?B?MURvWDF0K3l2TGVVOGsxWFhNYlBRUlFKcnNOU1FteXJaNUtrNnp4V2ZaTFMx?=
 =?utf-8?B?RWhFMURlNFQ2WHVpd2FoS2hmNERMb2JKQjR0VFhkQ1FMc3o5cUxHei9wVmJU?=
 =?utf-8?B?SHV6YUlESE5abWsxWDEwYjIzSUE5TVRCUFduczUzb3hZVTE3djlDdHVtK0hh?=
 =?utf-8?B?RmhiQWNEaHpzVWl5ZE9ZTWFVVTJ2TmJIZ0xVVFUzN2VnTHU3SjRjNmhlQnZE?=
 =?utf-8?B?YUtvZ1B4a1ZURTJiTUdzV1huS2piWWZua0lhNjQxSVdQck5HUEdQTUlIMHVj?=
 =?utf-8?B?QnNQQ3pWeHJnay9qblRCUGJSVWJqbjk5L2RjYzZ5NTdEc1RhQjdRK2VrNzBO?=
 =?utf-8?B?cmk4VnR6djEyckJMWDlqTmdLNmVLbldqcjMxZHBSNXBVN3JuVkJSNTRJK09G?=
 =?utf-8?B?YUV0c2o4bEpYU0ozQkV4OEhVV0NseS9jQ3FwdGlVbzU2cHdaVWVjbmJURHl6?=
 =?utf-8?B?Yi8yTDQwWE1UZVJDY0lLcnZzbEgwY21nR3lLWkFHZlBqc1VmVGZBYldKbjAv?=
 =?utf-8?B?UXZrUjMzZSs1bTFHcG02QkpGN1JrVEdOOEtPUDRHdjY4T0NSd1Y4dXB2cHNs?=
 =?utf-8?B?NHhQTFRIcHBmM1hiYWFYU2NGVHFZT2hXQXNyc2I4MXQzMVZmdVZwS2RMQWxi?=
 =?utf-8?B?ZVpoSTVhb09uM0dzT0pkWkZkb2hBS3k4SVIzdTdMMWw4Mi9ML2tZcGpINUJU?=
 =?utf-8?B?QzNmWi9nVTlzaUN3aDBRemlZVGdNK2ZvbHJXdXJJQ1hvaUREM0pnekc5eW5Z?=
 =?utf-8?B?VGhKb3lzNVF1cmxvRnI1L2UwR3Nqb3Ayay9FekdjUHNIbGx3RUxTb0IybWk0?=
 =?utf-8?B?RUladDNtaWxTQWJzaU9Md1hxdE5wZDRoTE9vMXZrNENXa3V1cGMyL1NwTkxW?=
 =?utf-8?B?MWU0MVpJdys3YjZoOVZESVNqdktPd2M2THdieDlsZVhqVFZqbEVJV0twdHpl?=
 =?utf-8?B?RzhzQkw3NGdXVGJ5YmhSVGpBV3U5cExVQ3NocDNJaTNUejFSb0YrTFFWSERv?=
 =?utf-8?B?R3V0YlBvbkFHTTZJN2MwTzVnUWlVTDBEcC9kb3dkdVJiQmwzTGJwbEVBMG5W?=
 =?utf-8?B?T2MyQW9CZzcvVWtjQktIYnVsZmpON29ZK0NQanFLc2JJMEhId01RaDdZTEwy?=
 =?utf-8?B?RXl2bktBV1Q4dVcrS3FRdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmdNUEsxdGxkRmNhMGxDWEs3NUoxRm91ZmxQaXBNRDl2UzcxSkR4VU4vVkcw?=
 =?utf-8?B?UGN1ODdET1FXUkc1R3lwTXBvMXdMSDRZb0RYV2dHZDlBdU45Sk5SbnNiS1FC?=
 =?utf-8?B?K3M5eHh2UjF6VkVmWENSTnpYTVlwM3J4S2NmL25CMm5NYSt1bzlydS9oL2NG?=
 =?utf-8?B?WEhtNFVXeWZ4V2h0ZTJGejh6YzJPN1JPQUdDQjFJVzJ0Zk9vbythWFBEVEZL?=
 =?utf-8?B?SzFDNi9ISGxoNlV5YmpkRnFoZE1mUlF0SmcxT3RZRTZjSmdzTWFzWGlLMUY4?=
 =?utf-8?B?cmx4Nm8rRC9xY09IRUs4RnZIazVGakxOc3FpRzQvMkZrMjFDQjY4VG5KWkZG?=
 =?utf-8?B?OWRJMkxFL25EenJuSk10QzA1aFNiY0NKeXhEOFFqblpFakVOT1VuS0taV2xM?=
 =?utf-8?B?QkJqK1RQbGZTZjVaRmlzMXQ4ZVJEczlxUW4ySG1WRFg3VzRzdk5sb29KZnp5?=
 =?utf-8?B?dHlXNGQ5RlBsQkYwMC93SjJhNVViZ0tjVFdCaklsMW45blh1WFZMQVhseHZG?=
 =?utf-8?B?YkdUY0dSTWhGUDNtQWw0WDFqaEdENHlwU3hrR3lGRUJ2RXF5RG8zQ0U5QkJP?=
 =?utf-8?B?TzRoT0N3RzNYUjhOWDFzZitxeldSVVFHNmZZZnZaS0hpQkZGR0JLVUpTRktW?=
 =?utf-8?B?aVpzQlhHS2JkVFlXcG92QzRIdTF1MmQ0blVhNjRLUC9XMytlQmtLc09la1BW?=
 =?utf-8?B?ZXhhQjNCc0RRZ09YaUNVbTdpUzFvKzl1N2ZnVWpjd0p0NUc1bG1EeVR4RGlh?=
 =?utf-8?B?VmVYSSsrSU1HcGlmOGNHZTVxWGZFVUNoVlRlMitpZk4zUEFydDE5L0VxK0ZS?=
 =?utf-8?B?a2Y5Q0FpZldJTThlNXNxQk91OWhOQnBsSFRVbFRta00xcFlHbTk4YmdOZlYw?=
 =?utf-8?B?TWpYb0Y3VkR6OExtaDFRYlhoWGN3NWhMNjF2anBHeE9LNmdCU1oyTXdsbDhS?=
 =?utf-8?B?QTI5UzgrenBDd3M5b1JKN3loTERXNU92UndGcTNpNVR3U0dibWFKLzBZVzVK?=
 =?utf-8?B?cTNQaldrL3JUNWlWbmhWK2R2bXcrQkhKdFNzaGFJbHBhNmQrZ2ZTODdSMk5W?=
 =?utf-8?B?OGw3UHVQU1NDUERyb1dxR2lYYnEwc2wydmFNUTQ1WnlNYTNuU2E4RThJZXdt?=
 =?utf-8?B?RGhVYzNheTNWN1JFNWo5TmJDcGVtNmxUVUNtWkZzZ3QveWhNTFVQYnlrbElT?=
 =?utf-8?B?QWl1VE5WZVcrZFJSbGNSdWtRYk5iTFBhdGJ4b2xWVmk2QWk3R2x5UC9pZE1t?=
 =?utf-8?B?eWgzT2EzWWlMZ3NpbWdsTTlEQm5wenJUOHVDZUprQ25vSjRLYkxadmZLMUxy?=
 =?utf-8?B?SU04akRMQ0JGeHd1L0RITk03ZFdPNlF6RGdYZ3lBcFBaZ0RFMC9lVnRmd0JT?=
 =?utf-8?B?OTMwbDJiRlZpdWRodlR0bWhTdnBwZkVic01GbytBenJIa1VrRHZkNUQwM3Q0?=
 =?utf-8?B?RStqZGRvNW42S0U1NE83R0c5Z0JqMEJuaGpCamgrYTZXQ1RqRUwyYSs4ODc0?=
 =?utf-8?B?VFBsMVFraS91VG5aMS9wMXI5bTJZT21zVzFWVzQzQTFoWXY1SW9HQ1Z5L1Iv?=
 =?utf-8?B?OFJueU8zS3JZcUlpWmRsNzRRV1A1TTBaR3VOM1MwVkxab053eFJ2MXlNL3JX?=
 =?utf-8?B?NlVCRXZWTkxwVDlzWTZzZkI3NmZidWVDSnp2UGdrRzhkWGRScDhINXo4SkdO?=
 =?utf-8?B?OE9KZ1VvbWRZTk5BN2NycjVqWXd4KzNjVHJyaUlsdjRkU2poYVlYUGh6aThO?=
 =?utf-8?B?cVI5cnRhTExqbnh4M2c3eHRVRzVFU0s4K1RsNThRbDFabWhwb2h1Y2VxUzFP?=
 =?utf-8?B?aWNGZ1V0YUVvZ2JSbjJSdTBxQkUxSzFBUVY5Y3BwRVkwNXlhQkx3YjJGMVF5?=
 =?utf-8?B?d09BTUQxd0tRdnR4QkoxRHFOekpwNnNZZ2ZGcHZDbG1LQ0lnZGxPSzJpL0xN?=
 =?utf-8?B?eEZCQnFlUjlwZS9XVWtENzJraUdRb0hTaXNoUHJ0TG9xWGY4WnZkQXhpRkRJ?=
 =?utf-8?B?aXFCWVplaXNuVkpCRTd3eGJxWHFGWEhLNDBIZytWbDB4eXA4cHF6SHp5Sk1o?=
 =?utf-8?B?Z1IwWmFSREJJTFZmZWpxYTdXaGp5ZmltckVvTkhFbDNnb01VV2l2cVE4NzFr?=
 =?utf-8?Q?9L/E=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f09496-6fc6-413d-b14c-08dcab5ac144
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 21:02:25.9204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HSDpkUXlAwaXNukkGqjPAf6vJ3/gPDAvLGwVONP9pt83n2BLcthELnPQ4Q6GHhXv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8017
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
    <div class="moz-cite-prefix">On 2024-07-19 18:17, Xiaogang.Chen
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>

When app unmap vm ranges(munmap) kfd/svm starts drain pending page fault and
not handle any incoming pages fault of this process until a deferred work item
got executed by default system wq. The time period of &quot;not handle page fault&quot;
can be long and is unpredicable. That is advese to kfd performance on page
faults recovery.

This patch uses time stamp of incoming page page to decide to drop or handle
page fault. When app unmap vm ranges kfd records each gpu device's ih ring
current time stamp. These time stamps are used at kfd page fault recovery
routine.

Any page fault happens on unmapped ranges after unmap events is app bug that
accesses vm range after unmap. It is not driver work to cover that.

By using time stamp of page fault do not need drain page faults at deferred
work. So, the time period that kfd does not handle page faults is reduced
and can be controlled.</pre>
    </blockquote>
    This simplify the retry fault draining and support the multiple
    processes correctly now, some nitpick below.<br>
    <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">

Signed-off-by: Xiaogang.Chen <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |   3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h  |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 111 +++++++++++++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |   2 +-
 7 files changed, 88 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3abfa66d72a2..d90b7ea3f020 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2763,7 +2763,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
  * shouldn't be reported any more.
  */
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
-			    u32 vmid, u32 node_id, uint64_t addr,
+			    u32 vmid, u32 node_id, uint64_t addr, uint64_t ts,
 			    bool write_fault)
 {
 	bool is_compute_context = false;
@@ -2789,7 +2789,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	addr /= AMDGPU_GPU_PAGE_SIZE;
 
 	if (is_compute_context &amp;&amp; !svm_range_restore_pages(adev, pasid, vmid,
-	    node_id, addr, write_fault)) {
+	    node_id, addr, ts, write_fault)) {
 		amdgpu_bo_unref(&amp;root);
 		return true;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 312a408b80d3..1d6a1381ede9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -548,7 +548,7 @@ amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm);
 void amdgpu_vm_put_task_info(struct amdgpu_task_info *task_info);
 
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
-			    u32 vmid, u32 node_id, uint64_t addr,
+			    u32 vmid, u32 node_id, uint64_t addr, uint64_t ts,
 			    bool write_fault);
 
 void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index d933e19e0cf5..5cceaba6e5c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -132,7 +132,8 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 		/* Try to handle the recoverable page faults by filling page
 		 * tables
 		 */
-		if (amdgpu_vm_handle_fault(adev, entry-&gt;pasid, 0, 0, addr, write_fault))
+		if (amdgpu_vm_handle_fault(adev, entry-&gt;pasid, 0, 0, addr,
+								   entry-&gt;timestamp, write_fault))</pre>
    </blockquote>
    indent should align to the start bracket.<br>
    <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
 			return 1;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 350f6b6676f1..ac08d9424feb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -595,7 +595,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 			cam_index = entry-&gt;src_data[2] &amp; 0x3ff;
 
 			ret = amdgpu_vm_handle_fault(adev, entry-&gt;pasid, entry-&gt;vmid, node_id,
-						     addr, write_fault);
+						     addr, entry-&gt;timestamp, write_fault);
 			WDOORBELL32(adev-&gt;irq.retry_cam_doorbell_index, cam_index);
 			if (ret)
 				return 1;
@@ -618,7 +618,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 			 * tables
 			 */
 			if (amdgpu_vm_handle_fault(adev, entry-&gt;pasid, entry-&gt;vmid, node_id,
-						   addr, write_fault))
+						   addr, entry-&gt;timestamp, write_fault))
 				return 1;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index c51e908f6f19..8b8d5ab9da76 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -850,10 +850,13 @@ struct svm_range_list {
 	struct list_head                criu_svm_metadata_list;
 	spinlock_t			deferred_list_lock;
 	atomic_t			evicted_ranges;
-	atomic_t			drain_pagefaults;
+	/* stop page fault recovery for this process */
+	atomic_t			stop_pf_recovery;</pre>
    </blockquote>
    This flag seems redundant, as timestamp is 48bit increasing and
    amdgpu_ih_ts_after handle the wrap around, so always use timestamp
    to drop retry fault. <br>
    <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
 	struct delayed_work		restore_work;
 	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
 	struct task_struct		*faulting_task;
+	/* check point ts decides if page fault recovery need be dropped */
+	uint64_t				checkpoint_ts[MAX_GPU_INSTANCE];</pre>
    </blockquote>
    I think it is safe to not use atomic64_t.<br>
    <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
 };
 
 /* Process data */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 407636a68814..9dd28d06ea2a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2263,16 +2263,10 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 {
 	struct kfd_process_device *pdd;
 	struct kfd_process *p;
-	int drain;
 	uint32_t i;
 
 	p = container_of(svms, struct kfd_process, svms);
 
-restart:
-	drain = atomic_read(&amp;svms-&gt;drain_pagefaults);
-	if (!drain)
-		return;
-
 	for_each_set_bit(i, svms-&gt;bitmap_supported, p-&gt;n_pdds) {
 		pdd = p-&gt;pdds[i];
 		if (!pdd)
@@ -2292,8 +2286,6 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 
 		pr_debug(&quot;drain retry fault gpu %d svms 0x%p done\n&quot;, i, svms);
 	}
-	if (atomic_cmpxchg(&amp;svms-&gt;drain_pagefaults, drain, 0) != drain)
-		goto restart;
 }
 
 static void svm_range_deferred_list_work(struct work_struct *work)
@@ -2315,17 +2307,8 @@ static void svm_range_deferred_list_work(struct work_struct *work)
 			 prange-&gt;start, prange-&gt;last, prange-&gt;work_item.op);
 
 		mm = prange-&gt;work_item.mm;
-retry:
-		mmap_write_lock(mm);
 
-		/* Checking for the need to drain retry faults must be inside
-		 * mmap write lock to serialize with munmap notifiers.
-		 */
-		if (unlikely(atomic_read(&amp;svms-&gt;drain_pagefaults))) {
-			mmap_write_unlock(mm);
-			svm_range_drain_retry_fault(svms);
-			goto retry;
-		}
+		mmap_write_lock(mm);
 
 		/* Remove from deferred_list must be inside mmap write lock, for
 		 * two race cases:
@@ -2446,6 +2429,7 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 	struct kfd_process *p;
 	unsigned long s, l;
 	bool unmap_parent;
+	uint32_t i;
 
 	p = kfd_lookup_process_by_mm(mm);
 	if (!p)
@@ -2455,11 +2439,49 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 	pr_debug(&quot;svms 0x%p prange 0x%p [0x%lx 0x%lx] [0x%lx 0x%lx]\n&quot;, svms,
 		 prange, prange-&gt;start, prange-&gt;last, start, last);
 
-	/* Make sure pending page faults are drained in the deferred worker
-	 * before the range is freed to avoid straggler interrupts on
-	 * unmapped memory causing &quot;phantom faults&quot;.
+	/* first stop kfd page fault handling for this process */
+	atomic_set(&amp;svms-&gt;stop_pf_recovery, 1);</pre>
    </blockquote>
    this flag is not needed.<br>
    <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
+	/* calculate time stamps that are used to decide which page faults need be
+	 * dropped or handled before unmap pages from gpu vm
 	 */
-	atomic_inc(&amp;svms-&gt;drain_pagefaults);
+	for_each_set_bit(i, svms-&gt;bitmap_supported, p-&gt;n_pdds) {
+		struct kfd_process_device *pdd;
+		struct amdgpu_device *adev;
+		struct amdgpu_ih_ring *ih;
+		uint32_t checkpoint_wptr;
+		uint64_t checkpoint_ts = 0;
+
+		svms-&gt;checkpoint_ts[i] = 0;</pre>
    </blockquote>
    don't reset it to zero.<br>
    <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
+		pdd = p-&gt;pdds[i];
+		if (!pdd)
+			continue;
+
+		adev = pdd-&gt;dev-&gt;adev;
+		ih = adev-&gt;irq.retry_cam_enabled ? &amp;adev-&gt;irq.ih : &amp;adev-&gt;irq.ih1;
+		if (!ih-&gt;enabled || adev-&gt;shutdown)
+			continue;
+
+		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+		/* Order wptr with ring data. */
+		rmb();
+		checkpoint_ts = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
+
+		if (adev-&gt;irq.retry_cam_enabled) {
+			ih = &amp;adev-&gt;irq.ih_soft;
+
+			if (!ih-&gt;enabled || adev-&gt;shutdown)
+				continue;</pre>
    </blockquote>
    this check can be removed.<br>
    <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
+
+			checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+			rmb();
+			checkpoint_ts = max(checkpoint_ts,
+						amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1));
+		}
+		svms-&gt;checkpoint_ts[i] = checkpoint_ts;</pre>
    </blockquote>
    <pre class="moz-quote-pre" wrap="">WRITE_ONCE(svms-&gt;checkpoint_ts[i], checkpoint_ts);</pre>
    Use WRITE_ONCE here and restore_page use READ_ONCE to sync up the
    timestamp update. <br>
    <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
+	}
+	/* resume kfd page fault handing with time stamp checking */
+	atomic_set(&amp;svms-&gt;stop_pf_recovery, 0);
 
 	unmap_parent = start &lt;= prange-&gt;start &amp;&amp; last &gt;= prange-&gt;last;
 
@@ -2900,7 +2922,7 @@ svm_fault_allowed(struct vm_area_struct *vma, bool write_fault)
 int
 svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			uint32_t vmid, uint32_t node_id,
-			uint64_t addr, bool write_fault)
+			uint64_t addr, uint64_t ts, bool write_fault)
 {
 	unsigned long start, last, size;
 	struct mm_struct *mm = NULL;
@@ -2910,7 +2932,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	ktime_t timestamp = ktime_get_boottime();
 	struct kfd_node *node;
 	int32_t best_loc;
-	int32_t gpuidx = MAX_GPU_INSTANCE;
+	int32_t gpuid, gpuidx = MAX_GPU_INSTANCE;
 	bool write_locked = false;
 	struct vm_area_struct *vma;
 	bool migration = false;
@@ -2930,7 +2952,29 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	pr_debug(&quot;restoring svms 0x%p fault address 0x%llx\n&quot;, svms, addr);
 
-	if (atomic_read(&amp;svms-&gt;drain_pagefaults)) {
+	/* kfd page fault recovery is disabled */
+	if (atomic_read(&amp;svms-&gt;stop_pf_recovery)) {
+		pr_debug(&quot;page fault handing disabled, drop fault 0x%llx\n&quot;, addr);
+		r = 0;
+		goto out;
+	}
+
+	node = kfd_node_by_irq_ids(adev, node_id, vmid);
+	if (!node) {
+		pr_debug(&quot;kfd node does not exist node_id: %d, vmid: %d\n&quot;, node_id,
+			 vmid);
+		r = -EFAULT;
+		goto out;
+	}
+
+	if (kfd_process_gpuid_from_node(p, node, &amp;gpuid, &amp;gpuidx)) {
+		pr_debug(&quot;failed to get gpuid/gpuidex for node_id: %d \n&quot;, node_id);
+		r = -EFAULT;
+		goto out;
+	}
+
+	/* check if this page fault time stamp is before svms-&gt;checkpoint_ts */
+	if (amdgpu_ih_ts_after(ts, svms-&gt;checkpoint_ts[gpuidx])) {</pre>
    </blockquote>
    <pre class="moz-quote-pre" wrap="">if (amdgpu_ih_ts_after(ts, READ_ONCE(svms-&gt;checkpoint_ts[gpuidx]))) {</pre>
    <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
 		pr_debug(&quot;draining retry fault, drop fault 0x%llx\n&quot;, addr);
 		r = 0;
 		goto out;
@@ -2952,13 +2996,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out;
 	}
 
-	node = kfd_node_by_irq_ids(adev, node_id, vmid);
-	if (!node) {
-		pr_debug(&quot;kfd node does not exist node_id: %d, vmid: %d\n&quot;, node_id,
-			 vmid);
-		r = -EFAULT;
-		goto out;
-	}
 	mmap_read_lock(mm);
 retry_write_locked:
 	mutex_lock(&amp;svms-&gt;lock);
@@ -3173,9 +3210,11 @@ void svm_range_list_fini(struct kfd_process *p)
 	/*
 	 * Ensure no retry fault comes in afterwards, as page fault handler will
 	 * not find kfd process and take mm lock to recover fault.
+	 * stop kfd page fault handing, then wait pending page faults got drained
 	 */
-	atomic_inc(&amp;p-&gt;svms.drain_pagefaults);
+	atomic_set(&amp;p-&gt;svms.stop_pf_recovery, 1);
 	svm_range_drain_retry_fault(&amp;p-&gt;svms);
+	atomic_set(&amp;p-&gt;svms.stop_pf_recovery, 0);
 
 	list_for_each_entry_safe(prange, next, &amp;p-&gt;svms.list, list) {
 		svm_range_unlink(prange);
@@ -3197,16 +3236,18 @@ int svm_range_list_init(struct kfd_process *p)
 	mutex_init(&amp;svms-&gt;lock);
 	INIT_LIST_HEAD(&amp;svms-&gt;list);
 	atomic_set(&amp;svms-&gt;evicted_ranges, 0);
-	atomic_set(&amp;svms-&gt;drain_pagefaults, 0);
+	atomic_set(&amp;svms-&gt;stop_pf_recovery, 0);
 	INIT_DELAYED_WORK(&amp;svms-&gt;restore_work, svm_range_restore_work);
 	INIT_WORK(&amp;svms-&gt;deferred_list_work, svm_range_deferred_list_work);
 	INIT_LIST_HEAD(&amp;svms-&gt;deferred_range_list);
 	INIT_LIST_HEAD(&amp;svms-&gt;criu_svm_metadata_list);
 	spin_lock_init(&amp;svms-&gt;deferred_list_lock);
 
-	for (i = 0; i &lt; p-&gt;n_pdds; i++)
+	for (i = 0; i &lt; p-&gt;n_pdds; i++) {
+		svms-&gt;checkpoint_ts[i] = 0;</pre>
    </blockquote>
    <p>not need to init 0 as kfd_process structure is from kzalloc.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
 		if (KFD_IS_SVM_API_SUPPORTED(p-&gt;pdds[i]-&gt;dev-&gt;adev))
 			bitmap_set(svms-&gt;bitmap_supported, i, 1);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 70c1776611c4..5f447c3642cb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -173,7 +173,7 @@ int svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 			    bool clear);
 void svm_range_vram_node_free(struct svm_range *prange);
 int svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
-			    uint32_t vmid, uint32_t node_id, uint64_t addr,
+			    uint32_t vmid, uint32_t node_id, uint64_t addr, uint64_t ts,
 			    bool write_fault);
 int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence *fence);
 void svm_range_add_list_work(struct svm_range_list *svms,
</pre>
    </blockquote>
  </body>
</html>
