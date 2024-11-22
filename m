Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18E9E69173
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2024 16:01:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D4AC10E304;
	Fri, 22 Nov 2024 16:01:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d/3fPbmw";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CB5610E301
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2024 16:01:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NR5TOTHtUSqa0MgwzbW/Wa7nCXw0p6lpbnjqDPwljp4NRx0jYAELGqwOp5A3aLnBRuWHVyEMJo/8B3v6DZng/k+CLyR831F2PW/34JlxLjGEQ0vl7f1qml0AwRRcBqTkbs9pdfeu616gNsLxckmwwrli3611v883T/pJmQ4ApJF4RveuAn7EqeUlg9Vmryj3ghbW/rNY8LYjc6YxQDmjfmTtDXStoa6c10cT7H8vJKuAQ8WTUmKZcNyfoHwPvRuQfgTl8DrOSEBrXpxWjaXHitdaxKjnWaT41BR3MVCyf3LJlLq+YajyBYDqgSvkIWsGEs+uRVDBtlXQlDg7Ih4z6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfuUKaXdwFDNYrunev2qie+nmhfbkdxLBnGeX7g6LHw=;
 b=X65nuC9nTPxhAkkNzdlDYoOTwXFCboA4r2qtP3xNFFRVvrcSi8nCHexvPms/nK1OgWqh7b4mNtxSjlfUaBL7Uf7/+TlcmWoTiUNx21zyvuYUlnl5aeJHoIW5aHrDT4WAJU58v38CI+mxuyrjqibwtDFAlwHag/k0PMX+pCd5yIZAU4OJo9DlsyQ+K3R5qrHAoUjY8cne+hszTXyhTAk+4udJ46vHkiB5QPsrXrBT2kPf5n7v0WWrBaZBVuRddf2/Xm5Tj7KIF4mxLZ7cNTxYzeDqNvkRJyImD95AUHl4W8p+O80BwKH1f4hiiESX5mBAS4Hlhl+jNWln9j7B6KJrrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfuUKaXdwFDNYrunev2qie+nmhfbkdxLBnGeX7g6LHw=;
 b=d/3fPbmwYKgf5Ej2YAmWNUQ2WYRj3RYgXuyTgnGVbVKoBQC6jpiXzo6bxnpm8EQb3/ZWB2aZIIphb8gJA0wzCshBwayhU1ejt6pqJuyoQL9zCucTGdIx72QrS3EMSXDRdaba3/vcRH/lg3u5BmpZ9xgv7xWDQp/El6tCIlPmgis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB6654.namprd12.prod.outlook.com (2603:10b6:8:d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Fri, 22 Nov
 2024 16:00:54 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8158.019; Fri, 22 Nov 2024
 16:00:54 +0000
Message-ID: <792f2f48-2f39-4033-ba57-68838f98e71f@amd.com>
Date: Fri, 22 Nov 2024 10:00:51 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Add Suspend/Hibernate notification callback
 support
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241118200323.16541-1-mario.limonciello@amd.com>
 <10227541-3d1b-4e48-9a17-b9c0dc25a541@amd.com>
 <01b16cb3-71e0-4f8d-b9ce-1c6b261475ce@amd.com>
 <CADnq5_OAxdt6QPn3+2s906iWinCM9--JtAJPnoS3yhSN3K6Eug@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_OAxdt6QPn3+2s906iWinCM9--JtAJPnoS3yhSN3K6Eug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:806:f2::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 05937b2b-4ffc-4b84-e829-08dd0b0ed802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmJnN1h6c2FuK210akNOR1pCZ2FwRDcvbTBVTVBiRExwR0I2cy8rUElJWmlv?=
 =?utf-8?B?MXlieEduWFZCQzJtLzVhTWovWTc4VVlOcTBwMk4wV21XMUlBdVRaY0pHb1V4?=
 =?utf-8?B?N1R1WnlvQ2tSL3k5M3ZjMnR3UG5vNHNrUlhhOWFjZG13QXZRNHRMeTRFM0JT?=
 =?utf-8?B?MjZ1YWRYM2tmK0hla2tLZnBHYVVRM2hzY0s0SmZsQzZpZmZkVjFqdUNFSDh2?=
 =?utf-8?B?N1ZOcW1XTmFYcUV2RVlYVFpxejUzWVR2OTUzaWZXWFpvVlQ1c0toaktkUDFJ?=
 =?utf-8?B?dzk4V3dQbm8zZm8rZ3VLQTFvQlF3MFZnemRsWFd0dG1pRGhaOHd2TGVrU21N?=
 =?utf-8?B?YlhUY3BGSm1ESGhPR3JuM2JITjdyZVRGMFhPQWVMQUx4THIrLzRCUTJMa1A3?=
 =?utf-8?B?enpFN2dXWUhtUnptQWh2VUIvS2hRNVU1ZFkydjhFS0JOMEE2TkZSQng3alox?=
 =?utf-8?B?cDFiYUwvV1dsZ1o2T3ZHVnBlekdYTmdkaFZnYVBIREdlM1ZGK3J4Zlc5SjVG?=
 =?utf-8?B?bm90UkdGNjJzMVBUbmF0T1dYS05zU1BsQ0dWcmVxTUFINTNkRDF6UWdDaWNT?=
 =?utf-8?B?eGltN3UvM1Z2V3A1Q2lGVG1teWNyVUc3dDduYWdOMmJ5UDU2ZXJsM2hGM0lI?=
 =?utf-8?B?Q3BaemFzMmZvRVhpWk1rL2NGSzRpS25keVVkcnd1K3RpSkJqOEd2OXJtajkr?=
 =?utf-8?B?UlZONTlDdU1EaGZ6b0wwWGNHZkt0dnBKcEE5S1A0cks5TzhITzlsWGlZeGFL?=
 =?utf-8?B?cjF5VWkzdXBXcmJVOXlYa1hyWmVzUHV2c2pnSW1uNVRYbjIza2xzSGIxUkUw?=
 =?utf-8?B?MmxvaWRxSW9IOUpzYi9BUi92RFBUNXlzNkI5a3lJUkdEc0ZBdnh5ZlJQbDdh?=
 =?utf-8?B?WHJ1aCtqYXMzYlZ5c3o4MGhaVGlaMmE1YnBHZ0Q3TDF2a2FaZG1IMGgwamlt?=
 =?utf-8?B?cHNCVXZncTFsWWt3RDJ6NTdzZnZHV2JYYUlkMHQ0ZnZUeUJCWGE4VElUczZH?=
 =?utf-8?B?VUg1LzJiNEpDRE5hMHMySU15ckdYZVlwN2dLYjd6TVlQckhSUnFPaGlzRWJW?=
 =?utf-8?B?d1cyNS9XUXFucXd6ZUpmbXpzVzg1cTRBbmh3Wlo0bE01S25NSFhEZitUWDYv?=
 =?utf-8?B?L0xia2tZbE90a2w4VDBsYmhWMTF5S3hDaVZveWNCSmJ0MUhxNmpXbzYwR3BV?=
 =?utf-8?B?QVNIQkg4MldGZDRDT1k5SDg1NzN1YnhnZ0kwaFZiNlFHd0FHQXpPTWFzdkxO?=
 =?utf-8?B?bzNyYTNRY1FtTVN1TmFYRktjWDZVY0MrNUNFOTByK1BUQUZBbjFZQlluRTZo?=
 =?utf-8?B?RkVac2l0SnBmUkxnY2JyWjgwdlg0K3V6bzJGZi9lUVZxWEJXRjBYZWEzZFFH?=
 =?utf-8?B?OTBLYUlLckxYT3BpVE5teVozbHQ2SGt5bnVYS255eGpkUEh0amlXS1hJSjQ4?=
 =?utf-8?B?QXFvL2Zmd1lWSDdMcS9vZW9ZVGNqN1ArQlNZdXlRUmh0YXVVTUwwQ3RPOUQy?=
 =?utf-8?B?TTVoYVllZ3hGa0hwYXBHRGhoY2tJNExscUUxa01WUktrSSs1RnducEhaZmg1?=
 =?utf-8?B?MkovbE8vK05QZUZLOXA5bjhpbVE3T3JKLzA2SDJxNmZVcUphMng5bzZjdmFn?=
 =?utf-8?B?bmVBQW9UdHFQODN2UGNKTWhYQlhmV2JnbEdKeEVYRUF5U0wwK3g4V3M1TnFY?=
 =?utf-8?B?dHl4OUZsQkl2TTkzRHp1U2JGSXZzaXFFbk1wd0hnd3JvWm8yKzN5Yi9RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0hNMHRvNWszRWdLaElSaVcwOXhqV0h0T2JrRnk3UEJ3cTBaMTg3eGJOUVlK?=
 =?utf-8?B?cGozaVl0elNaSFM1TjV3L1pURTNYb2cvNXJraGp3SzllWXRNUURMcnZ3NFk1?=
 =?utf-8?B?SEd2aGgwdlhIUzczcHZxaTkxT1VGblZaNlNYUStPcE9Rb1Z6cE4xNlRFZm5Z?=
 =?utf-8?B?ODJFVzNaSG84QnpJczNoSlFiQitoTmFCM2pBRHJEZzg1MzFURHZMWVNGYzFz?=
 =?utf-8?B?RkZvREo3djRKWWxJdWp2ZFpweHdWOCt0V1VhdmJPZzh0cTBqOWJvTWNiVFBs?=
 =?utf-8?B?UE0rOUV2R1hndTJVaU9zV2swUFlBdkhiMXFIeFlWdTdPVmJ6Vi9sbzFuSXVE?=
 =?utf-8?B?QmRZb3VsbDNObk9GNVkxUnJTWUEwNUkyanZDS2hZa01PdExISzc0QTVuV0RF?=
 =?utf-8?B?YWZaY2dwTzlpdDlNTzhLSTQvNGUzcytpemNFUnIvcG9DWnk4L2RyTTBETnBD?=
 =?utf-8?B?ZlhMbFlXYWFiZ0R6V21VWmVremFqYndKdE9SZkdGRXc2amJiQ01PVWplbFdP?=
 =?utf-8?B?T1RvUDN1amdUR3hVSE1Ob2VIUDBhMS93Q1diSXAyRlh2QUZrM3F5YWxuS01m?=
 =?utf-8?B?RkpxNVdycEZGZUora2RMOGJHTnRRVlhLMExVNWFOcDZQd2Z1Y2dYeUVMVTVm?=
 =?utf-8?B?S2VTcGU5Q1hEZUQ5T3VCeEtBRGhSTEV0a3hLZFJWc2NPVU50NGxpNHY1WVZo?=
 =?utf-8?B?SHVGSUtuZSswb1dXckNQSWlDSUZlc2VPMG43ZmV3cm4wd3NOeDd1Mkg0Y3Bv?=
 =?utf-8?B?eHZpdXV4RVR3SzBGYTlxeG90TkM4QWwyMFRBd3RmOEZRbFFGTUYvZFVhL0d1?=
 =?utf-8?B?eGlkM1BBbVZwQmtZN0pOa2VBVWpMeFpBbFFOUnQ2cHUyN3BDOG9sZ2E3QVhu?=
 =?utf-8?B?cktpQTNsajFkOUNzc093V2dpOHkwZWptY2FiSDhlaDdhelBiK3M0cVhhTWZO?=
 =?utf-8?B?dVc1L0NaQkJvNnlWTHdoQ1BYRnJDRWRzQzVaTTEvb0VwcFVDNDkwT1k2NzZK?=
 =?utf-8?B?RjVZYjhNRjhrQndGOXIwOWtoWHRDVjFXdVhKWFh5WTVnNHc4UkhsSkZBWUg3?=
 =?utf-8?B?V3M0VnN6YUZYckZHUk1vV3owRk9qL29xWmxoZm1GdUtRdWZ6VFgwRGIyL2Vh?=
 =?utf-8?B?dmYxeHYrYnJWQmVHRnpJSUhIazhtL2VaU2wyVjkwZnBLSFUySEJ0M09OZjkw?=
 =?utf-8?B?dklBZTh1OG0rdklVcCthVUtOaGZJMkExaFR1d1d2ejRiajh5MkNCS3A5eFJn?=
 =?utf-8?B?bHNVQXk2M1g2VGdwTVIzWU04OVk2ME1iOG1jdnEzdk1VMG56Q2RMaWUrNGdH?=
 =?utf-8?B?TzVTSTNYS0VXT05XYThkOGY0U09reTJ6dW1HVEo5ZTVnM0ZUelh2UitRWWlR?=
 =?utf-8?B?RlVlaC9qaHc5QXNDWUtEemtCWjdwZzlacHYxbkQ4N2RtWnIrUUV1VDV0RlZO?=
 =?utf-8?B?K3NUcU9XVkM1Z2tDTVVLV2FVZ2pQUUJmKytaQngxSXg3ZnpQclNNbXBuSnIz?=
 =?utf-8?B?d2FMelM4WHZUMHlMYThEek56M0V1TlRLMjB4ZUxaL3ZtZ2JyM1BvTkczenBR?=
 =?utf-8?B?cG5ybWRnaXBTTFJub1pNaVU4OG1Nd2hIRFE5WUMzZ1QwNDVIenMwWCtDRVFH?=
 =?utf-8?B?c3BadnpZNmxKeDYvOHNheGlMZnpNZkFHRDdUM0YxcHhoMVNCS3U1NHQrSTVN?=
 =?utf-8?B?clZlcDRnM20wdmVEa24rMm1ULzZRNFJoc3pBRkpUUVVCeThmem5ielduUnNB?=
 =?utf-8?B?T1dRQ2doR21YSEMvS2R5TDRBclQ5OHkrMHhjUVozTk5LS2k1Nlo4TFliMkdM?=
 =?utf-8?B?MWpOMWcweGV4YVV4OTRBQ09Iem5uMmpYUStwY2JBVDdLd1pJV1ZQSzJKWTlO?=
 =?utf-8?B?VSt5NnU0Vk5lU09ZY0RzT0JNZENmWk95TEZlZVdFUXV6WEJtV1p4RmdDOG4w?=
 =?utf-8?B?Nmp6TGFWdVJaNE9HSDFqMFRFaUpudTgySHZhbnFhVnlFM2dZaWtvNlp0MjE2?=
 =?utf-8?B?N1YwdnBxVC80Q0ZicE5qVzZFb0U1cEdTc2ZiQ2Rza1ZHWkxZakRla3ZUaXFs?=
 =?utf-8?B?TGNST1dvbEpOd2o3NE0ra1RFUnlGWk5wUUVvQ2pmcWR0VkxGTndERHZrNTdw?=
 =?utf-8?Q?s8J03U+hL+NCiaDC7xtXHEcXE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05937b2b-4ffc-4b84-e829-08dd0b0ed802
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 16:00:54.0161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiZW7XBNzlBBGE529/5LExZoX5Z8hBAbiuepWJQHyq+sQ7k9+BVF5v0s1gcL8uQO8lJDIvK8saXBtXEIkYFVFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6654
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

On 11/22/2024 09:59, Alex Deucher wrote:
> On Fri, Nov 22, 2024 at 10:57 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 11/22/2024 08:28, Lazar, Lijo wrote:
>>>
>>>
>>> On 11/19/2024 1:33 AM, Mario Limonciello wrote:
>>>> As part of the suspend sequence VRAM needs to be evicted on dGPUs.
>>>> In order to make suspend/resume more reliable we moved this into
>>>> the pmops prepare() callback so that the suspend sequence would fail
>>>> but the system could remain operational under high memory usage suspend.
>>>>
>>>> Another class of issues exist though where due to memory fragementation
>>>> there isn't a large enough contiguous space and swap isn't accessible.
>>>>
>>>> Add support for a suspend/hibernate notification callback that could
>>>> evict VRAM before tasks are frozen. This should allow paging out to swap
>>>> if necessary.
>>>>
>>>> Link: https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
>>>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3476
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 36 ++++++++++++++++++++++
>>>>    2 files changed, 37 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> index a37e687acbbc5..e70ca85151046 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> @@ -885,6 +885,7 @@ struct amdgpu_device {
>>>>       bool                            need_swiotlb;
>>>>       bool                            accel_working;
>>>>       struct notifier_block           acpi_nb;
>>>> +    struct notifier_block           pm_nb;
>>>>       struct amdgpu_i2c_chan          *i2c_bus[AMDGPU_MAX_I2C_BUS];
>>>>       struct debugfs_blob_wrapper     debugfs_vbios_blob;
>>>>       struct debugfs_blob_wrapper     debugfs_discovery_blob;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index b3ca911e55d61..5a4e9c7daf895 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -190,6 +190,8 @@ void amdgpu_set_init_level(struct amdgpu_device *adev,
>>>>    }
>>>>
>>>>    static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev);
>>>> +static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
>>>> +                                 void *data);
>>>>
>>>>    /**
>>>>     * DOC: pcie_replay_count
>>>> @@ -4582,6 +4584,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>>>
>>>>       amdgpu_device_check_iommu_direct_map(adev);
>>>>
>>>> +    adev->pm_nb.notifier_call = amdgpu_device_pm_notifier;
>>>> +    r = register_pm_notifier(&adev->pm_nb);
>>>> +    if (r)
>>>> +            goto failed;
>>>> +
>>>>       return 0;
>>>>
>>>>    release_ras_con:
>>>> @@ -4646,6 +4653,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>>>>               drain_workqueue(adev->mman.bdev.wq);
>>>>       adev->shutdown = true;
>>>>
>>>> +    unregister_pm_notifier(&adev->pm_nb);
>>>> +
>>>>       /* make sure IB test finished before entering exclusive mode
>>>>        * to avoid preemption on IB test
>>>>        */
>>>> @@ -4777,6 +4786,33 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
>>>>    /*
>>>>     * Suspend & resume.
>>>>     */
>>>> +/**
>>>> + * amdgpu_device_pm_notifier - Notification block for Suspend/Hibernate events
>>>> + * @nb: notifier block
>>>> + * @mode: suspend mode
>>>> + * @data: data
>>>> + *
>>>> + * This function is called when the system is about to suspend or hibernate.
>>>> + * It is used to evict resources from the device before the system goes to
>>>> + * sleep while there is still access to swap.
>>>> + *
>>>> + */
>>>> +static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
>>>> +                                 void *data)
>>>> +{
>>>> +    struct amdgpu_device *adev = container_of(nb, struct amdgpu_device, pm_nb);
>>>> +
>>>> +    switch (mode) {
>>>> +    case PM_HIBERNATION_PREPARE:
>>>> +    case PM_SUSPEND_PREPARE:
>>>> +            if (amdgpu_device_evict_resources(adev))
>>>
>>> This will result in an eviction call on APUs since the flags won't be
>>> set by this time. Is that intended?
>>
>> Very good catch!  I will bump it and modify
>> amdgpu_device_evict_resources() to just skip APUs entirely.
> 
> We can skip for suspend on APUs, but we need to keep it for hibernation.

Right; I realized that when I looked at the code, and that's what I 
ended up doing for v2.

> 
> Alex
> 
>>
>>>
>>> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L4739
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> +                    return NOTIFY_BAD;
>>>> +            break;
>>>> +    }
>>>> +
>>>> +    return NOTIFY_DONE;
>>>> +}
>>>> +
>>>>    /**
>>>>     * amdgpu_device_prepare - prepare for device suspend
>>>>     *
>>>
>>

