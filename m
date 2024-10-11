Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8E3D0D7BA
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Oct 2024 15:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E93B10EB0F;
	Fri, 11 Oct 2024 15:17:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rv4AW5iS";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AED110EB0F
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Oct 2024 15:17:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGoTLTGOsrEri1DU0cIFN6JnakfdaafJbajtDBlHShF37PL7hSje7S/AcOwnYWpFKvLLOwa8uf/GqFOTGnQ+YqyE+7qOMr8YnGa0eT422jNrHCQUFeWdbdYcXdu3HZsRxnClcja3ZwI5Dv9WPcwzimAHbHmMkLTIzucp/mQVULLNgcghe4I836zXKB2xQRK8O23i9bFQFZFSuETZOW1hv/1Da2LKVZKGj3ShhSDY/hqqLfkkZCbjzYhpuzHnpYY6T+roHmywKX7QUSWjobHapqm2UC3MF2zR8NwdLf3Px8H+FdgNlAfG+2korZ3y2fSnGAGb6YQLKJsokdatk2v0qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OmEewkc+AjG9kTtkqYIFV39uu/Z9QIEkeQckjP8IK0=;
 b=Tg7F23Fn9RntEbx8mVoKqG4nqfncVTZtLMXE898hawpai5s8XMX4KDG2D9PhJkYAAJR+4mAMQEkte1sIz5EvYMAMRcD0Nj2kTChX9eKMmNOJkWimnRcLNGFmKF32ITSkL33503HilngjQ8qKcayOiw2LtgwL4W/igp8CgLsSi9+EN2IUzGR3u5l8P4wsxpUxNqAVtRWJLCTWLFZ+kUciI2mQJRrE7cgpy2BmohoIKlQ4vhHbqyMU+fV853ofruNP1HwOl9VH8x2BwPDaoijQEu4l2uDhwuF0nabNS7E+Fa2UldgwqHKurlUsG/jIHeIyF0kSTTIR/PmEK/CQLWEYGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OmEewkc+AjG9kTtkqYIFV39uu/Z9QIEkeQckjP8IK0=;
 b=Rv4AW5iSmNs8tNtbp+ZUVpP5wtveYpONH3ojZEIVUUmNqhYF15h0whvvSaQq/MfGakqAC8dI6kYo309h6JTzvRMDBTlHjm8Z4SS6FQvcGV7PJ5KnbGZiI/KxfBKZS+ii0DYsvvsdDrRwbL3P9+S07ARCesrW25abfvihmGXBCCg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 15:17:16 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 15:17:16 +0000
Message-ID: <3d0053a5-efa2-497b-8316-8e0ec571bf2b@amd.com>
Date: Fri, 11 Oct 2024 11:17:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdkfd: pause autosuspend when creating pdd
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>,
 "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Gui, Jack"
 <Jack.Gui@amd.com>
References: <20241010151831.10859-1-Yunxiang.Li@amd.com>
 <20241010161730.13416-1-Yunxiang.Li@amd.com>
 <20241010161730.13416-2-Yunxiang.Li@amd.com>
 <BL3PR12MB642501535A7BEEBBBB32C54DEE792@BL3PR12MB6425.namprd12.prod.outlook.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <BL3PR12MB642501535A7BEEBBBB32C54DEE792@BL3PR12MB6425.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0101.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ2PR12MB8650:EE_
X-MS-Office365-Filtering-Correlation-Id: cda45649-5f19-4bd4-1aa1-08dcea07ca3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGdTRTlmL2YvS04vd2F2UkFCQ1BwNUVBNFpVYkxsREdUa3BRcFpUdTZnVG5L?=
 =?utf-8?B?S1VaSlhUekh6QmcwRFlJZE8xNFl4ODR2T2pSZFJQa1psV0JGWVJ0bzdiRzhP?=
 =?utf-8?B?QzMrRUZJc200NEdueFdDSlFGVGNWaE93ZzhrYzVWOFNSSzQzZWh0eFZSTHM1?=
 =?utf-8?B?YkorYjYrNVU5TlFqRmJxVlhma080UTNsQk8xVE9zZXh5SUdCYll5L1J5ZHl6?=
 =?utf-8?B?UVY3eXBCV0M4L25yWWpFRDBZTHVJSElHKzM0MVBCMEwrS1dTbXlZV3k0K0Ex?=
 =?utf-8?B?SFNLQ2MzMExZdmNvWHZyWGIwbGNvUUQxeDVWbkp2VGh3UFZPSGpPK0hlQ1FK?=
 =?utf-8?B?a0ZhUFpGMlM1VUhKeU5kTHYxRUp1R0QrMEcydW1LYmk5UmZObW4xWXBZdGdq?=
 =?utf-8?B?eDVqNk0xbUM1SFJqQ0FNZTc0NUJSZDJjSU5jMkdyYkZXSXVNWGlTblptZEFF?=
 =?utf-8?B?QkRMdWl2c2syNGdvaHdQY3JMRUFiZ0ZpdFNQWnVPMmFrVDNmNnNVdERNQnFR?=
 =?utf-8?B?VkptR3B1T3NnODNZUWlYcHNUS20zcVR4M1VFYnpsSk9CYzhUQ29jN0FFYnUr?=
 =?utf-8?B?N1lxWFFUQ1JYdnFXK2tTSUg5RTdxNDB5VXptbUMzSTNIOG1qZk9VemRxS0ov?=
 =?utf-8?B?OGJkVlB6KzE3Z3p5VHdzZUprd0ZSdlVjMjVRRXZTMWFBc2tuazcxWDdOOW9V?=
 =?utf-8?B?MFY5R3dLVGZiYTN0d2RNMXB4ZGxwMkdEc1M1RE1DQWJGRWlMcFY0R2NtZThF?=
 =?utf-8?B?UlB0dWlxcE01U0hyN3lnK3dGZG1GMThMUWRyNFE1RHliTzI0S2Q5a05zckx6?=
 =?utf-8?B?TW5ZU3g4M3AxSThsdmcveW9FMjUyYXFwZnc3bThadEpEOE1wSlFFcTNpRjdG?=
 =?utf-8?B?Y3hyeGNkTW55RG5sWHdBeStBQkdtc2F0TmRZcWtWa2tDWVh0MHhEQXNTRE1M?=
 =?utf-8?B?UkNLbGlPWm9xYnBxaGlKZVVBbnRaNHNUUVNzVHpzZmlsU1FaY2ppcEpPOUp6?=
 =?utf-8?B?a1ExN2lHcTlraXVhNkFQUXZIMkhCd2wvVy9YcC9TRi95azMwZUFGN1NsZ3V1?=
 =?utf-8?B?NEhkdnI2alAvSERweW1xQ1c2c3hCWjcreUQycFVicW9SRVhwVzExT0V2MDhL?=
 =?utf-8?B?RmJPWFh1UW5OQTcycXFobVkzZGlEd3pvQnAyak9NNzdZa1AyOHM0Y29HdG84?=
 =?utf-8?B?ZHJqNjYyUDREQ1FMbTl6ejhGaHp1WG9OQXRDSWhzWTJaYUdDakE5VUJyNjd1?=
 =?utf-8?B?NlgxK0YxY2VLZ0krSWlUbnVVQk5zdDN0N3ZWNUdaZkNBT3Nadm1TdVBNTE85?=
 =?utf-8?B?WEY4aFpFUnNHeGQrTDRlaTVyay91QmpldEVvTEM2RU0zUHNJWXJ0bzF5eXRS?=
 =?utf-8?B?RE5yTStCeHVGc2RKYXp2THlCWkZ2eDhYS2hDTERGMkg5djFWV2NOS3Q5VmE4?=
 =?utf-8?B?YUVySjZjaG1CcXBKK1FSb01uOUJMcTl3MjJUM2drOWJMQ1hsSHR3WHRLQysr?=
 =?utf-8?B?bk8rckhmTFpFVFNOYTRDS2RyWWhpTTUwR2RNRW4wbkR0SEhqMWVhdUtTdTYv?=
 =?utf-8?B?b1c1bzdyUk9GbTRQUDZLUlRhSXFuaWs1WUVGM2NuM0hmaC9DdFBHdkExcnM5?=
 =?utf-8?B?UWcvVEFxMHFJdGM3em9TNWduSnczcyt1ZE9sT01SbHROYmxGbGdYUmMxVmhv?=
 =?utf-8?B?UnA4TjNpcjArT3luVTltbEpDaDNPai81alh5NktVTmdIR3dBbldESUhnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2VzcWV5YzBRL1M4NzVVdHJtOFplV0FUc2JicUc0MXBqVmxUd2duWGFLdDAy?=
 =?utf-8?B?QjlUa0x5SDR3Q01DM3RJb25uZmw4T2dSOCtKRGdRbXpoSU1KWnhrQ0hXQlBn?=
 =?utf-8?B?K1ZhOWNHejR5UHVYcTVZekdUZzFUUXhCekVMOXdTa3FUTHdjM3lSUktIbHNY?=
 =?utf-8?B?TUk0am96YW9qQUh2N0Q2Wm5BeDU1cDdabmxRdFpxU2ZBWlp6R0hDZHRUd0Np?=
 =?utf-8?B?NWF3OHlxdXNxVnBqa0hXSHZ0ZWhaRk5tNGd0MmhKbGcxWDIvYzIzUzQvU2lI?=
 =?utf-8?B?Mk1QVUtZelptUVZKazVXbkUrL00wR2laNnFQdUtSM1ZPaWxDbHRXY1pVVmg5?=
 =?utf-8?B?ZGd2cEtidFk2d1FhaWN4cGdkem5MNWkwbFl4UjNOakhkQy9EUFRMczlzV0wz?=
 =?utf-8?B?d1lNL2RTQzB0dEtySmV4Umc3LzB0ZnBCNlZSS2hWbkV3RnhTQXRLT0oxaXBk?=
 =?utf-8?B?Y0dZZFl0M1pRcndOYTBXSWYwbTI0U1lDQUNLQ29lUFJGYVlPYWdLWG1xYTdr?=
 =?utf-8?B?SHRudnlLQUI3SVl5bTFZNTFhQnNQV0JCL2FYYjNxRTRwZEt1Ui80Y3lOeE52?=
 =?utf-8?B?V3pZVWVXamlBWEI2ZFc5ck1CUG45Ykl5bnhpUU9UWWt0VE1yR1hpcklpQlVZ?=
 =?utf-8?B?RHZmbmx5SW0xdGRhak1yTDF6YzJvd29XNG12dEltU3lBYmM5aHVoMXdHeW9j?=
 =?utf-8?B?d01BZGZPQmtPRUJ1NC9vbDZsazlqR0UwVVY0U2xIWTBndXplT0dFVkVmUjZZ?=
 =?utf-8?B?VCtLNC93QmcyUHJCMWk4OWQ0ZGRaNVN3dldRZWFHamF4dVF5SUZ6NGFSNHNI?=
 =?utf-8?B?SDhDWE5jNGxJeWh2bVpzeEwvd1pKSnpvTDk5ZWdKTzZvNGYyUVpwQ2pOdHoy?=
 =?utf-8?B?RzJ1Q3QrRHNNTHAzeWFDOHMrTE1HRGhZTlFtcVdkS2x3V3c0eGhlcitjalZm?=
 =?utf-8?B?eDFRQW1VaThtaGdhdVA0TW4zbDU0U3ZVR3NyRDNnd2Z2UDN2enI0RjlQeWpa?=
 =?utf-8?B?TG9MWTFRelBoNmYxOHc0TEVtYzUybThIVUY5Z1I1cTEyQ3N5emhWZmpSNUJi?=
 =?utf-8?B?eTB5NjV0WWRhMElWS0FaU01GWmZBL3dadHo4ZVZidlloL0dDTDk2SzZxbXdm?=
 =?utf-8?B?ekgrNCtUN0l3ZzdTZk9EYkVZOFJWSEx3MmJGc21odHJZU2JGN0lTYkR4SGxN?=
 =?utf-8?B?VityUEZWcW5MdTBPVG9jSGtVSzRIMC84S3dvUWVtdkJ1NThrL2J5OUpuTWs4?=
 =?utf-8?B?b2ZhRlVFMy9iMnloNUlpM2RCQ3VKazRXR1l2R0JvSzVjelNHRE5oOEM0MTlJ?=
 =?utf-8?B?L0FYMWNoQk04U05DbEJON0pnR2tqdldraXlyQUJpZlRrZGIwa3RRYU9NY3po?=
 =?utf-8?B?MVkxSlZxNTBneWNPVzM0dldYVnJQMVlEV2R1YUxyWXVrTDNKblcrbmlLVmNw?=
 =?utf-8?B?SythK3BjSHU4R2lBUXRWejdMSkVRT25nWkZKWmhBWTNqMXZQNVRRRC9rNndp?=
 =?utf-8?B?ZEtNTFg1dkJrSytHMnN2ZDh2elBkUEpITGxQWEI0WDRtNExOS1c2bFo3OFJ2?=
 =?utf-8?B?Nkk5bS9Ib0Vmekhua0FTSWhnc0l5aDVsbUpkcE9wYmFSSnBjZlNZUkI0aHIy?=
 =?utf-8?B?bjY5Z2llckUyK1ZsM0UwQkRqY2dVZFJEdnRQL0lqVjFjNmcyQ3FTZVpzRHRt?=
 =?utf-8?B?a3owMm41ZVNoMzVwZ0FOMzFGT0xQcXJ3Wk9JSVlhY3FQVHUwZXBmeGNkNGdD?=
 =?utf-8?B?ZU5YN0I0MjJoaXB1T0YrRUhCb1lBRDYvdnl0SkxoRld2VVlGcSswUk10YUFt?=
 =?utf-8?B?VE0waFhiODFmZ0t1ckFKSlVpeXhRT1pFWUhZSFlVTlp3U0pBM1NBVFF6UjZE?=
 =?utf-8?B?YkkvdUZjS1BaZ3ljci95d29HbG1nMElrMXIwT0tiR3k2ZXVxM1pIZVk1Vm8w?=
 =?utf-8?B?dGRYbVJCYmhydXpFZmNReHBNNElNU2N2NTB1ZmRpL2N1TjFwMzBJbk5CaDFY?=
 =?utf-8?B?SWxUSkFTeXlVdy9Sa0JkclQ1QWxiTjZPMmIydmF4NjdVczZVZWtPV1Q4TVRM?=
 =?utf-8?B?QWRpVTl6Zm9EWjVuYWRPU0VjZXlQRHdNd0MrWHhZQ2hnb3A3MjZ6RzJlR0VE?=
 =?utf-8?Q?N+ddxhuoqiJVVC+lljaDCz6N4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda45649-5f19-4bd4-1aa1-08dcea07ca3f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 15:17:15.9752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDNmnmb01nZFaeOdpknIptVbiTOUqKZmjIc7WScLLs1rqv8qZ9MdH56Oxvv5VoI0R1bjkv2GImMNBH+ap0A08w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8650
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


On 2024-10-11 11:07, Joshi, Mukul wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yunxiang
>> Li
>> Sent: Thursday, October 10, 2024 12:18 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Gui, Jack <Jack.Gui@amd.com>; Li, Yunxiang
>> (Teddy) <Yunxiang.Li@amd.com>
>> Subject: [PATCH v2 2/2] drm/amdkfd: pause autosuspend when creating pdd
>>
>> When using MES creating a pdd will require talking to the GPU to setup the relevant
>> context. The code here forgot to wake up the GPU in case it was in suspend, this
>> causes KVM to EFAULT for passthrough GPU for example.
>>
>> Also, change the other place where we pause suspend to use the cleaner
>> pm_runtime_resume_and_get helper.
>>
>> Fixes: cc009e613de6 ("drm/amdkfd: Add KFD support for soc21 v3")
>> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
>> ---
>>
>> It is unclear to me if kfd_process_destroy_pdds also have this problem, or is freeing
>> gtt mem guaranteed to succeed even with the GPU in suspend.
>>
>>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index c9ce95bc3ec8e..c3d510f1dabfa 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -1633,12 +1633,19 @@ struct kfd_process_device
>> *kfd_create_process_device_data(struct kfd_node *dev,
>>       atomic64_set(&pdd->evict_duration_counter, 0);
>>
>>       if (dev->kfd->shared_resources.enable_mes) {
>> +             retval = pm_runtime_resume_and_get(bdev);
>> +             if (retval < 0) {
>> +                     pr_err("failed to stop autosuspend\n");
>> +                     goto err_free_pdd;
>> +             }
> 
> I am not 100% sure if it makes sense to resume here and then put it back on suspend queue after the
> allocation. And then again call pm_runtime_resume in kfd_bind_process_to_device().
> Maybe you can set pdd->runtime_inuse = true here itself and not call the pm_runtime_put_autosuspend here.
> 
> I will probably let @Kuehling, Felix comment on this.

I don't think we want to set pdd->runtime_inuse here. That would make all GPUs like they're always in use, no matter if the application is actually using them. I think this part of the change is OK.

> 
> Regards,
> Mukul
> 
>>               retval = amdgpu_amdkfd_alloc_gtt_mem(adev,
>>                                               AMDGPU_MES_PROC_CTX_SIZE,
>>                                               &pdd->proc_ctx_bo,
>>                                               &pdd->proc_ctx_gpu_addr,
>>                                               &pdd->proc_ctx_cpu_ptr,
>>                                               false);
>> +             pm_runtime_mark_last_busy(bdev);
>> +             pm_runtime_put_autosuspend(bdev);
>>               if (retval) {
>>                       dev_err(bdev,
>>                               "failed to allocate process context bo\n"); @@ -
>> 1768,11 +1775,9 @@ struct kfd_process_device
>> *kfd_bind_process_to_device(struct kfd_node *dev,
>>        * pdd is destroyed.
>>        */
>>       if (!pdd->runtime_inuse) {
>> -             err = pm_runtime_get_sync(bdev);
>> -             if (err < 0) {
>> -                     pm_runtime_put_autosuspend(adev_to_drm(dev->adev)-
>>> dev);
>> +             err = pm_runtime_resume_and_get(bdev);

I got confused here, looking at the number of interfaces available in the pm_runtime header file. There seem to be many ways to do the same thing. There may be subtle difference between them. It's not obvious to me that this change is correct or harmless.

Regards,
  Felix


>> +             if (err < 0)
>>                       return ERR_PTR(err);
>> -             }
>>       }
>>
>>       /*
>> --
>> 2.34.1
> 
