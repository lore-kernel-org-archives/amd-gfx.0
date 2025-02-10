Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38867C02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 22:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA65710E02B;
	Mon, 10 Feb 2025 22:53:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MOYoy/g9";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 819ED10E02B
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 22:53:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xhoVPANsE87ppnhjGtj17ZL0rPTZ/Hao2twxKub6K3HEU5sj4JjfyLWQ+uzI7om/VHToDMCNmwneKpW7+wouCNqQ5dcW5bUODbhBHoQb4w03DkEmMJ4oiey0yKFdIdG9PJAwj/mMZlotwzg20JxvNfCsEwzIOIeLuCRqTZNK0fQZkhS4Ua0H3yjkrMhYJCmYSfHsVIgqjyer60fWAL6OnnmEs4ODP1+4qj3q0ywlNXupJFNy2yvrsuHTCqoVRaYGD7D6QRjGoPQXbhtbYYgzdz9EI7pKPgCUum2qbF1xuVrA6lbXVCRlw7T5jZyFXcBrY72S13Tg5kRrNhF2cAPz4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14ynlzL0G8uehvOaamjKvt/EWeC3GBQe8PocWmU1BjI=;
 b=GdKi4Fv78w996PQE495+GTQb0S1KVTRHj7o8Ow7nWsDTkVN4TGrGdqaIAiY1eJ3I+yQGOv28MzE1YcxwN/KbPoZv4+n+2b/D+5oWyPm4+bKY2qbFw0Yv+yviV0WnV6xjzsDMP2cTP1U4ElhnMI6sOfLsupNStGKUArjZuLvJT+gjIRsz956r46uRBQzglac0MKAiFBRCDaZQd7irKKuneSeWAukbV32mO47+E+z5xAvTObNvwySkehld6vhFd96WnFYWQijwN3cbm+0M1lgUB7l8vXy5xBKnhcs4LgyS04nnS17gd/m3X2C2sUUh1EMKd9uaK10BiKsbGK+Mk1t/BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14ynlzL0G8uehvOaamjKvt/EWeC3GBQe8PocWmU1BjI=;
 b=MOYoy/g9/kZcXM8oAvwErfrlHmeIDTCYKLz3xgFjDVMRRfUY1+PIdVsP/r9fG/EEqff+JHfb+1tF6wF1sxcRiSiwvYbGXVgZsegjy6Mlh6bUi/HWaA2SPYx31wRXNeFA+jSRgTgEvH4rwpAgHwQL6Gzq+6yRX7LgjR3QXbTS0mI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 22:53:47 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 22:53:46 +0000
Message-ID: <6c888bc6-a942-b608-3302-4c37374f76f8@amd.com>
Date: Mon, 10 Feb 2025 17:53:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Fix the deadlock in svm_range_restore_work
Content-Language: en-US
To: "Deng, Emily" <Emily.Deng@amd.com>, "Chen, Xiaogang"
 <Xiaogang.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250207102823.1565467-1-Emily.Deng@amd.com>
 <PH0PR12MB541778A52306F3BF717609018FF02@PH0PR12MB5417.namprd12.prod.outlook.com>
 <841a21b8-b0b6-48a9-af2d-62b51d5d6a1b@amd.com>
 <PH0PR12MB54174DCAA0C2AF44C320C1098FF22@PH0PR12MB5417.namprd12.prod.outlook.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <PH0PR12MB54174DCAA0C2AF44C320C1098FF22@PH0PR12MB5417.namprd12.prod.outlook.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0018.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::21) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SA1PR12MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f67625-4cfd-4f87-0294-08dd4a25c6e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VjNHOEdjRnJJL0RjUDg2S1Z5NVVtYU9sU0ZBbCtUQkI5ampwZ1h3MEs4dFZE?=
 =?utf-8?B?Mll0SzZZSTE4cXZDMTIzNmdjQmoyaWRzMnc4UEpwMGdkd1Z1eGM1SkNUMFRt?=
 =?utf-8?B?TERlTGlEMllvTzJhaEtjaTRCbU5BT29RQU5xUGlLWmVrNUNLeE8zeERGVlpY?=
 =?utf-8?B?SDl1TzJDVXdkNGs2MUNlZ0tsR3Q1QThxRFA3UFBGbkVudWQrd1AwZ3JEbk1n?=
 =?utf-8?B?QVhRQUdwVkYwS2dLL2ZCUUd5TE9ycHhzdnI4ZFRSZnlvcUpNS295Rk8rR2xQ?=
 =?utf-8?B?UnE2S1A4aWlDMjRndk1HNlRuY3IrSnQwbFlnNVY3WEsyNU5yU3NucXovNGYy?=
 =?utf-8?B?QjRvZWlPTTFvaHcreUhNMXV4ejhpQTVIQ3hmSWJkMktFOVFGR2hkaXJ5ZFpU?=
 =?utf-8?B?MGNxUW9EUGVkQnQxM1plK2R1UmVuWDhtei9rZTRsaE9hK3NuUVlqSWJlUUQw?=
 =?utf-8?B?TkNWdXhyUnkvN05OYmxRMUVuUUNKb1JlT0VkYjFTQldOSVRGeVp3RlVqUmk5?=
 =?utf-8?B?Tm9kUFNIM2xVVExjR3FjVmQ0cVFIMTJlMWRabVdjck9weHE5eUxQeVFFSE5x?=
 =?utf-8?B?RVB5bjJESGpkUjJCVGViYU16Z1RhUUFpcjFnYVhlQW9idTY0VlRaNnJvUGtT?=
 =?utf-8?B?S29LODFVTmNoVlBPVExwVG8yLzBkRnBZdjZGYWZON1FFcDVlVFVoOWx3cU9n?=
 =?utf-8?B?Ly9aeFJDVUJ5S0xLQ2VmMzUydzZwaElKRjFWNkVsYnUrcVU2Sk5DRlI2THVJ?=
 =?utf-8?B?QXpRdzhJSmRZVFpMNWsyb0F6N3hzbVFISTJNc1paWlBtejYrYWc4cDF4aWUr?=
 =?utf-8?B?dWVFbGJiVUNlYlFOU0VwYTVpeHl5bVZWYkx3YlIxTklzaGc4d04zMFN4aUJP?=
 =?utf-8?B?azE1MTNvZEtRTi82cDJreS9IbnR5NmN3bUwyQjZpckdLcTdkV0RVemlNV0FM?=
 =?utf-8?B?VEhQUit2NjgxcFBaU2FuVkFUWkFJVjVGdk5ITGxHTVp3T2RzZ282L1BVa0kv?=
 =?utf-8?B?UTJwOStvZkUyeVlWV29PMEtrTG5HOE1zbXlmK0dVa0QwYytHczBmbkxiSTYv?=
 =?utf-8?B?SjdtUkFLOG1Rcm80WlVtaXBIbGRJTTZ2QkJFYThvb2RBLy9JZjlmOHA1ZFpY?=
 =?utf-8?B?S2QwbW45bW5oeWhBNDZUdEhlUWEvOEN3RlNqOXF5YnNRYWw3WEVUczhMUmxF?=
 =?utf-8?B?ZGVRWC82bDdJUDBoanN5WHhlZXBCZFV4QytKTFptcW40NzQ1aFZybmxNSkw0?=
 =?utf-8?B?WXgvYkNLcklBK0UzdUdQZjArRGYrN09XOHNLdElqVVF4dmNzSTF4RnpweXFV?=
 =?utf-8?B?NmpGNVVaTkJhb3RabXhsRGxlcDBpRVFwdHdYVUVxYmVzcGVJWHVzNE5BQmVQ?=
 =?utf-8?B?ais3YnA4ZjNFWFBiTEU5TTBBVkpndVpselJLMWZlbnBudTVZcWQ4SnRDL29F?=
 =?utf-8?B?OWxsam9YUC9xVFhOd3M5SGpTQVpqYjBKaXhhMXprRkxYSU9PSTRlMVhZMHd1?=
 =?utf-8?B?dmxVWkh4Qy9SZEEzYXdobEhrOUFsMVk0OE1RTEs1QytxSnA3WFMvTjNJNjdR?=
 =?utf-8?B?blVuOHJTT0RudVp2Y1lSaVB0R0hvc3B5UkdLVWUrdDJRNktqdE42NkVZYmhm?=
 =?utf-8?B?NUlQaENtZDZUWGtSeUg3QUFjQ2tLV3ZRaW94RHlkYkJOT3c5RUpUNEdjejdp?=
 =?utf-8?B?RnFlTUpOdTQwQUc1TnQrZy9uQm9QczN2TG1Mb1R4WVR0UmdtQUxZOHYvUlBs?=
 =?utf-8?B?UFB2bllGNGpncnJvNkZYLy9xOWZMTWhZS28wNFF5emdzVW55OXNJYXVranNp?=
 =?utf-8?B?Tk9VNDNDWldBcERnWklUQ1E3bU5IalpMUWliU3pJcDFlMUo0TXJydlM0OWdZ?=
 =?utf-8?Q?KC7Xtxafn+qJs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TC9obnVmblRtMnhkZnk5dGhrU3ZrSTVyMkpScGVaMGZRT0JrOU54ZEpzQzFj?=
 =?utf-8?B?NlNmaXlYQ1FiSTlXRVVCa3g0T0JxVzlNRnpka2lYYTVBc3JKcmdqZm44bFlr?=
 =?utf-8?B?R09VcGhkR1hEeS8zRmI0eU9TL0cyVmZZTUxBRittZGxjV3BKS0IzcVFVSU5t?=
 =?utf-8?B?ZVVwZlBtSmdtdzM5NjEzWnVwNmVZWEtqNzU0ckEzWUI2ckkwQWJNR2Mrcnd2?=
 =?utf-8?B?dTkwUTI5dU51NnBaR0hjKys0YkZMY0FKTGx6Y1FxZjRjSUYxbCs4ekVWUU5n?=
 =?utf-8?B?QTQvS0xmZEE1ZEwzNW1nTVNUUks4bDhVOGJ2QnBYRmVQTXI1Q2JSOGhiUDhH?=
 =?utf-8?B?S1gyRE5ENWRpelFOV1Yzd3A4U3ZBZ2tob0NPa3BsVUxVWkUvR1lLRmhRMmVm?=
 =?utf-8?B?U09CUE9aMmdRYjZ5K2ZHMU9JMHBIc2VLdXdNOFdRZ3J4QXpjOXhKcGc2b05C?=
 =?utf-8?B?b1lmdlRaaFRXZEdZbzNWY0hhRlZJVEFjUWI0bWpJUU1qaEFVVFB2RnhubzRS?=
 =?utf-8?B?VFBINFc2MXF4aDc0THBUcEs4Qkpld2IyS1N1eUo4azFYbnphVGdqSXZNL1dW?=
 =?utf-8?B?SjFvaG5LNnR3S0o3MmlvOGFEaEVhc05RalZ1bThEYXRUbnFBekl5M2JjWXZ4?=
 =?utf-8?B?Tk9zM2JHcDlIa3Z6NlVmbmczeUJXLzlRM1JPeXEwTm5hZkRPU08zelNGOUR2?=
 =?utf-8?B?MllDMlZHV2lxMHF5T0dpMmRjODVaWUtGRi9VQUd0bUNDdnAyZnVqQXg0YXM4?=
 =?utf-8?B?bFVaRnZUYmExdk1kLys5NUhtUm1QeUFXWXdMdWg4Y1k2SFhtZzlnblFJT0NL?=
 =?utf-8?B?QjZaTUkxcUtCYXk3bS81RG83c0tTZ2p5MkNjcUxqQm9KbnhqT2lhUnZEb1NK?=
 =?utf-8?B?MU9jNHU1OUNoTlJzRFk0dFhHM0xuWWZ1N3JUV0Rya2JNMFNlNG90VEY1UmU0?=
 =?utf-8?B?eFNoeVR2VDVnL2NzOGVtbitiTzV3QVZTUW1FNER6a3RYQkFrL2VtMHZxQm81?=
 =?utf-8?B?dTd4RVZzcXpDZW84VWJ1WHpZbisrTWxBb0pKVzk0ZmprdE1GM05aUlBXZEFx?=
 =?utf-8?B?UVp3bGhIMVVtbEFNQXYvdzFmYUo2SjdMQ3FsTXFWRnZNeWVqUmxzaWJyMjlt?=
 =?utf-8?B?RVJ0M1NvSWd3Q2YwNjJ2OGxGb016WE4wMUZYSUFrNkZwU3F4TElYK0dtd2VK?=
 =?utf-8?B?YjMzTVRncFZ2WEpsQWlHZ2RiOWRJb3IvbGU2TDVUT1BuYlIxU0Rod2RwU2V2?=
 =?utf-8?B?LzV3NmRac2ViUk4wM1pSeEFyMEY1WHgwMDRDOHFPWjRPVHpGanBhL2M2SWo0?=
 =?utf-8?B?bGluOXZidEp0MEg1cER1Q0VpanMwZk1qZXhpbUVUeERjSW1WTEZtY1l0TGNo?=
 =?utf-8?B?ajV5QS9rUVo4WjZFTWJDejFPUTVEZzRzSzlzNTA5Q2ppdW1kYlJsa2VLYlZJ?=
 =?utf-8?B?dUw1WnBMODl5NmZjQTBCazE3emVvekZNSm5CRHd1d290WHNTOEZwOVFaQ0V6?=
 =?utf-8?B?ekFEU2VibzV6aUJEZTM4cU4ya0x3bTF0dFo3SXRXTTZMazVYUkpIL2FVTXRF?=
 =?utf-8?B?cEJBdTdudk1sYjdHOFBzeWpLTkxsRUJUeTBqbkJBZkU5WEIwMi9hSXdpVDRC?=
 =?utf-8?B?Wmg5SXlESEk5WlU0RkRKUmlCb0s0cS9xV2NlUjhpOTBUUjRnMWdHa0tKOHZR?=
 =?utf-8?B?NEd5Vks5M2Y1MFdjN2lwaHJ2WEx1SkE0TUlKTDlEWVdlNkJ1YTNCOE1hZmly?=
 =?utf-8?B?ZGIyZjhBaHp2Vmtrd0RyQSsvT2tTajRyaXhZdEN0Q29rY3A0RG9kR0lNTHJY?=
 =?utf-8?B?R0dxVjM0YWhnQk9NdkEzTHJJR0pVSFFaRFovNmNydm1Gdkp5WE9heXRVZW9q?=
 =?utf-8?B?a2RTOWVLR3BqNHBoMUx6WFljOGdGZSs3NGxhWVpIK1oyN0wxMlhPMmloNEN2?=
 =?utf-8?B?WmtkVm9FdDVjVUxUMnR4YjRwK3ZpbUEvMEJmRTU4QTBnUWNkLzZ5Y05ITzMz?=
 =?utf-8?B?VTZ1Y1lWN3ErOWx4OWRTekdNZHJNSDF2VmRtSlVyY2JvWVFKYzZFbG1uaS93?=
 =?utf-8?B?Y1lFL3E2QnNVS2FGSnJ5WlF4Rkw5R280WE9NSEVYMEFESytRWHVuNUZTYjcr?=
 =?utf-8?Q?lLbFm/EmReQIlpLQcs+ZqrFxe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f67625-4cfd-4f87-0294-08dd4a25c6e1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 22:53:46.9155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNxOplVM1UQBbUbmMXzOvXAxMoDs0rW9pUCSruis0aned6uetrOgoRI4uByfvesL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7343
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
    <div class="moz-cite-prefix">On 2025-02-10 02:51, Deng, Emily wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:PH0PR12MB54174DCAA0C2AF44C320C1098FF22@PH0PR12MB5417.namprd12.prod.outlook.com">
      
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
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}p.MsoNormal, li.MsoNormal, div.MsoNormal
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
      <p style="font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [AMD Official Use Only - AMD Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <p style="font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
          [AMD Official Use Only - AMD Internal Distribution Only]<br>
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
                      Chen, Xiaogang <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a>
                      <br>
                      <b>Sent:</b> Monday, February 10, 2025 10:18 AM<br>
                      <b>To:</b> Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>;
                      <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                      <b>Subject:</b> Re: [PATCH] drm/amdkfd: Fix the
                      deadlock in svm_range_restore_work<o:p></o:p></span></p>
                </div>
              </div>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
              <p><o:p>&nbsp;</o:p></p>
              <div>
                <p class="MsoNormal">On 2/7/2025 9:02 PM, Deng, Emily
                  wrote:<o:p></o:p></p>
              </div>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <pre>[AMD Official Use Only - AMD Internal Distribution Only]<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre>[AMD Official Use Only - AMD Internal Distribution Only]<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre>Ping.......<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre>Emily Deng<o:p></o:p></pre>
                <pre>Best Wishes<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                  <pre>-----Original Message-----<o:p></o:p></pre>
                  <pre>From: Emily Deng <a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a><o:p></o:p></pre>
                  <pre>Sent: Friday, February 7, 2025 6:28 PM<o:p></o:p></pre>
                  <pre>To: <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a><o:p></o:p></pre>
                  <pre>Cc: Deng, Emily <a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a><o:p></o:p></pre>
                  <pre>Subject: [PATCH] drm/amdkfd: Fix the deadlock in svm_range_restore_work<o:p></o:p></pre>
                  <pre><o:p>&nbsp;</o:p></pre>
                  <pre>It will hit deadlock in svm_range_restore_work ramdonly.<o:p></o:p></pre>
                  <pre>Detail as below:<o:p></o:p></pre>
                  <pre>1.svm_range_restore_work<o:p></o:p></pre>
                  <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;svm_range_list_lock_and_flush_work<o:p></o:p></pre>
                  <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;mmap_write_lock<o:p></o:p></pre>
                  <pre>2.svm_range_restore_work<o:p></o:p></pre>
                  <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;svm_range_validate_and_map<o:p></o:p></pre>
                  <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;amdgpu_vm_update_range<o:p></o:p></pre>
                  <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;amdgpu_vm_ptes_update<o:p></o:p></pre>
                  <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;amdgpu_vm_pt_alloc<o:p></o:p></pre>
                  <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;svm_range_evict_svm_bo_worker<o:p></o:p></pre>
                </blockquote>
              </blockquote>
              <p>svm_range_evict_svm_bo_worker is a function running by
                a kernel task from default system_wq. It is not the task
                that runs svm_range_restore_work which is from
                system_freezable_wq. The second task may need wait the
                first task to release mmap_write_lock, but there is no
                cycle lock dependency.<o:p></o:p></p>
              <p>Can you explain more how deadlock happened? If a
                deadlock exists between two tasks there are should be at
                least two locks used by both tasks.<o:p></o:p></p>
              <p>Regards<o:p></o:p></p>
              <p style="margin-left:11.0pt">Xiaogang <o:p></o:p></p>
              <p style="margin-left:5.5pt">In Step 2, during
                the&nbsp;amdgpu_vm_pt_alloc&nbsp;process, the system encounters
                insufficient memory and triggers an eviction. This
                initiates the&nbsp;svm_range_evict_svm_bo_worker&nbsp;task, and
                waits for the&nbsp;eviction_fence&nbsp;to be signaled. However,
                the&nbsp;svm_range_evict_svm_bo_worker&nbsp;cannot acquire
                the&nbsp;mmap_read_lock(mm), preventing it from signaling
                the&nbsp;eviction_fence. As a
                result,&nbsp;amdgpu_vm_pt_alloc&nbsp;remains incomplete and cannot
                release the&nbsp;mmap_write_lock(mm).
                <o:p></o:p></p>
              <p style="margin-left:5.5pt">Which means
                the&nbsp;svm_range_restore_work&nbsp;task holds
                the&nbsp;mmap_write_lock(mm)&nbsp;and is stuck waiting for
                the&nbsp;eviction_fence&nbsp;to be signaled
                by&nbsp;svm_range_evict_svm_bo_worker.
                However,&nbsp;svm_range_evict_svm_bo_worker&nbsp;is itself
                blocked, unable to acquire the&nbsp;mmap_read_lock(mm). This
                creates a deadlock.</p>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <p>The deadlock situation should not happen as
      svm_range_restore_work is only used for xnack off case, there is
      no VRAM over commitment with KFD amdgpu_amdkfd_reserve_mem_limit.
      We reserved VRAM ESTIMATE_PT_SIZE for page table allocation to
      prevent this situation.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:PH0PR12MB54174DCAA0C2AF44C320C1098FF22@PH0PR12MB5417.namprd12.prod.outlook.com">
      <div>
        <div>
          <div class="WordSection1">
            <div style="border:none;border-left:solid blue
              1.5pt;padding:0in 0in 0in 4.0pt">
              <p style="margin-left:5.5pt"><o:p></o:p></p>
              <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
              <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Emily
                  Deng<o:p></o:p></span></p>
              <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Best
                  Wishes<o:p></o:p></span></p>
            </div>
            <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
            <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;mmap_read_lock(deadlock here, because already get mmap_write_lock)<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre>How to fix?<o:p></o:p></pre>
                <pre>Downgrade the write lock to read lock.<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre>Signed-off-by: Emily Deng <a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a><o:p></o:p></pre>
                <pre>---<o:p></o:p></pre>
                <pre>drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 ++-<o:p></o:p></pre>
                <pre>1 file changed, 2 insertions(+), 1 deletion(-)<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
                <pre>b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
                <pre>index bd3e20d981e0..c907e2de3dde 100644<o:p></o:p></pre>
                <pre>--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
                <pre>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
                <pre>@@ -1841,6 +1841,7 @@ static void svm_range_restore_work(struct work_struct<o:p></o:p></pre>
                <pre>*work)<o:p></o:p></pre>
                <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;process_info-&gt;lock);<o:p></o:p></pre>
                <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_list_lock_and_flush_work(svms, mm);<o:p></o:p></pre>
                <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;svms-&gt;lock);<o:p></o:p></pre>
                <pre>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;mmap_write_downgrade(mm);<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; evicted_ranges = atomic_read(&amp;svms-&gt;evicted_ranges);<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre>@@ -1890,7 +1891,7 @@ static void svm_range_restore_work(struct work_struct<o:p></o:p></pre>
                <pre>*work)<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre>out_reschedule:<o:p></o:p></pre>
                <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;svms-&gt;lock);<o:p></o:p></pre>
                <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_write_unlock(mm);<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_read_unlock(mm);<o:p></o:p></pre>
                <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;process_info-&gt;lock);<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If validation failed, reschedule another attempt */<o:p></o:p></pre>
                <pre>--<o:p></o:p></pre>
                <pre>2.34.1<o:p></o:p></pre>
              </blockquote>
              <pre><o:p>&nbsp;</o:p></pre>
            </blockquote>
          </div>
        </div>
      </div>
    </blockquote>
  </body>
</html>
