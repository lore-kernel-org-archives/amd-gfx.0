Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2263CFD313
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Nov 2025 18:45:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 389C610E0BA;
	Mon, 24 Nov 2025 18:45:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JNEFd7Cz";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011022.outbound.protection.outlook.com [40.107.208.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4DE210E0BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Nov 2025 18:45:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5g9WOQXDthXjzFG7Wgh4RgXkWG9LBYwfuq3CrokPAqj6TPhOx7EsXZOUe+ZIFhbTqldp/u35mnn5k/2eX+UX1Oxr+zmmUZL6Tz7Mdc3BS8qts1lM6tDsI9py2MHXKXhD0RRvy2PNmmp0r3X/FMV23eHMz4zTJbHRTEi1BC/DL48S3/7qjvHk3vDeheon1VBunEFUCIzXJWIPIImWGuYWElZNTggLw3//FmX2pi9oROQsJm1UvW58riO161cRovcsyO095814K+gQLbIbTKTsdfi2fubJnmC+Y9/cha3ghd82fUva5GFMh9lF+VyrK3KN/p0vMtH/0E3X9kcdJngFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pt5wKK2abY/6CB7uFQsxDs1pp4nKcOQ4GbyR5LrgXNg=;
 b=wfV5E0qlSOFgaocPA5fxvFKp3M734Sg7Zf+iN77+xeWT18UXnjqbIS05kxfLYdi1T8WaEfW5EyYRB0pMT2lO51A2cfn0dSl7I/LqhnP21dm79vFk1OQo5wHJ8AYi4h0fGf6y0l8hJkCiXixSCBnU+MRdoFdq+WFNnIiyatXaK80oUws1tIeM5d4/MbitiFjSs/RZEAG96m/ZOfSpeHKJlHwRymr4kL4LmL20Euritv589hFhM1cWJOHqEUI2R0GuGgs6Ly+I1tJcTG83nQe+Onx95CWBx7IX7r62yGSVSNdMSYoy7WxzA/psjGVGrsvGCTzI9Bmg6V4L6EvaBOvsWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pt5wKK2abY/6CB7uFQsxDs1pp4nKcOQ4GbyR5LrgXNg=;
 b=JNEFd7CzrQA0CPbxvwU17qUamE362rQ85N3qv1RFj9oLpnOSBDoZnDUvJouK7MeofSFRNA0VTNlNBdX3TzHZVpg6T+ZGDq+1UnxaK8uK870lUsvRiqnKhCJCOAY4KcPvRpP+86w6JxTyp2/bWKcquzO1zg5zAMH6F69aVWDB/OM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SN7PR12MB7251.namprd12.prod.outlook.com (2603:10b6:806:2ab::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Mon, 24 Nov
 2025 18:45:11 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9343.011; Mon, 24 Nov 2025
 18:45:11 +0000
Message-ID: <32ce2b72-aa16-4202-9f99-92e3cd4408bc@amd.com>
Date: Mon, 24 Nov 2025 13:45:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdkfd: Use huge page size to check split svm
 range alignment
To: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20251120155043.2770609-1-xiaogang.chen@amd.com>
 <PH7PR12MB65616F59BBE5CB4A4DCD34A5E3D0A@PH7PR12MB6561.namprd12.prod.outlook.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <PH7PR12MB65616F59BBE5CB4A4DCD34A5E3D0A@PH7PR12MB6561.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0332.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::18) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SN7PR12MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b27f3ab-c3f2-4cc1-4a21-08de2b89994b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjVFWThSWjA0RlNNOEZyWjN0K3A4SDBsUlJXbVhyNGNpdmFueGp4enFpaDZQ?=
 =?utf-8?B?VlhRR1ZqY08rMHNmQ1Q1cjlMcUlOQmtwQlB0Q0NkQTdwTU1zQ1JZTVNwMXRo?=
 =?utf-8?B?c3R3c2w1TU01ZGNCZ3ZGMjJoZjAxTmxTWlZDSmMzaTdUdDNmaVNaZVYvNjZs?=
 =?utf-8?B?OTV4cDdZNzRabndrckRFdUdmZ3VQMWZBZjJEcXl4SndlM3V3Wjhuc3dYemhl?=
 =?utf-8?B?SFgyN2grYlRhZE9EQ0s3SFdJU0VJYmo5T3BPSVVoUWRWcGpQR0t0Z1NZVHlw?=
 =?utf-8?B?cXBWZHEwVDZ5Z2lDNDZQSzJIWWlwOFhEUXVrb0dXOWhnUjhCQzRDUHduSUpq?=
 =?utf-8?B?WFVIRlA2RVRlT2JjMjYrYTRtUXc4dkY3NXhGR3AwMWx5Sk90ZCtMUlIzZ0dy?=
 =?utf-8?B?RFVZWWZTL1M3emE5Vlo5RkhiNHJZUW1hZnRiaTdGdUxtMnkraHU0b0FRdkZx?=
 =?utf-8?B?cFRuV0lCQUVEUTdGUEZjcGZsNXVueWdxNFZBWjlTdUFCZThWbTh6REQyWWVt?=
 =?utf-8?B?MmRmQ0RRektZU2JvbGtNVVhxbk1PVm45Nmp4Y2w3ZzUrUERHeWp3K0FpTm1B?=
 =?utf-8?B?a3Z5V09lSjArRXRaTjFxWW5VakMxMUJ6ZS95dTlneGJsNUE0ZlVQOVVuMWlG?=
 =?utf-8?B?TVhTMUJhaWNTYUg5YUxUUDBFUHhqaVRBVEd0Z2RJUEVOemtYYVNkRVhnWHd0?=
 =?utf-8?B?UUNSTjBKK0E1cGF6OENGbVY1TlBkTlNCRGsxLzFsL0gzV0lTeUlVUEhVWmdu?=
 =?utf-8?B?SGdWT2hyM0JObzFJVjZvQ1p3T1hnTHlxanhVbllFUlFWTVg0TXRQa0RWU3VZ?=
 =?utf-8?B?RkZvb3hGMTdiNHNkL09meGJoQVFSdUFiR1Y1aVJuMHVlVGZhdTRiZDJRcTdh?=
 =?utf-8?B?RzVxNE9DQXFCUXlaZnI3MGptSEJFbTIzUEdsRWJUVU1Bdzh0QXdwTWxMTXl5?=
 =?utf-8?B?OVBxd3hwSXFRU1NPa3orT2tocERtdFJ0Q1Y5R2RxdzFmUkpVS1Z2Q1poWHFp?=
 =?utf-8?B?elpxNWxqRURJdXFJSXMrQVdCaEJpeitnempmcitYWDJoZG4zamQ4b1hDYTFO?=
 =?utf-8?B?blFZUEN4bmxEK05SRHd3M21oUzNkdHk3dVlKdGRxZU9yY09DdWNzQ0Z1WEpR?=
 =?utf-8?B?TjU3bVJvZVdZejFtaGh4dUpKVnlmMmdwZWRqVUlUWGZqN0xaaGtKU3VqbFM4?=
 =?utf-8?B?am1BZmM3OCtCb3kxbnZjeEJ5Nmoxb0c0Q0lyNUtVWDZmRGswK2Z5Vm1peWg5?=
 =?utf-8?B?WFFKUDI2VlkxRkU2ODN4WW9CemJ5cjFUNVlhR2pCOTI3STRzUWRCYlh3dHdU?=
 =?utf-8?B?WDZHWFIrNVRRUnV3MS94MHFEOVVPRTZYTVl5eVdNNWpHTWs2THRvREpZRkFJ?=
 =?utf-8?B?UzVPUHZIWHplUWdLdWJQdEtTSkhSWndSVlRwZnJFeUEvTTk3WFdMTGN5Qnhl?=
 =?utf-8?B?TEp2bDdMNTZ6ZmllTklScFFoUDJVeVd2cUVMN0pxSW5uL1RaWlpTWnRDSjJt?=
 =?utf-8?B?VFNiTzNLU09MYi9LN3hzRk1ZTFJjQXZPREhWQWpHbkVCZ0xOT3BwcHV3TENo?=
 =?utf-8?B?cVoybzRNQStza25rZjJlaEkvWUV3V0dnWm5QQ2I0N1hTd0p6ZFlZZXkwNnYz?=
 =?utf-8?B?WjZtODBQeDRUeU5WTjJNVlBiK3FWQWxIdDdaWXk1NzFuSHpwcnNFTEFDL1pi?=
 =?utf-8?B?bEprMW5GTW80WlM5MTJiS05CUDc5djEva3RUSi9hRGxHaWNOSlZNbUh0V0px?=
 =?utf-8?B?cFJRSjYvN29pMk4wWkZ4RC9ZTy9uekZDVlZoWHk3aUxmN3YxTElmR0pVZ1Qz?=
 =?utf-8?B?VlNwSUlSeEJtcXcyZGQ1NzN4anFrUmpwUGlTM0xMOXYwdkFWdEJpV1ZDT2ZP?=
 =?utf-8?B?enhpRGtpV01VRTBoRmlvNk95Y0pQYUxsUGtQQllMaTN1Ym0zNHp4dTNjdEZF?=
 =?utf-8?Q?9pcUCpKaNyBWoxy0ScDXJLkCxsD6LV0X?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlZzL1laK0l6SC91NVU0amw5eVRxTjA2UDdWczVWa0pFenZENUhjNmt1ZE5H?=
 =?utf-8?B?amVxQ2VkczNmNVVYNFVSeUExZ09HM1hnYk9nN3BoSEx4QkpaVmxkUERoVnRX?=
 =?utf-8?B?NG55U0xneStqVllxM3pxL2lIVjl4Ylp3Z3U2MEdkQWs2emlabW9xSHpld3pm?=
 =?utf-8?B?b0dFR3FwaTRYUWNIYldSK1hsNm51VGJuT3RzL3ZaQlhGbkFCTkZiSEF0S3NP?=
 =?utf-8?B?Yy96clZtNEZvYU8xWGl1SnFybzVCanp3eEluTmREQnJ1T3krcjhuc3UwQWwx?=
 =?utf-8?B?M2hzSFU2aVJxRUhpdXpramxMY0txMGNHeFUrNjlUSE5lT29LYzhiR2tJOG0z?=
 =?utf-8?B?MUY0OVFlWUZWR3I2cHNvRUszMkhzNlR5VmtaNW1oclZmVjZZaE5WcmZGeCtZ?=
 =?utf-8?B?ZExKaUtQQ0R4ZnBsbDV6TENYejY3a01LbU1OUEh0ZmFabFN1K0xUVzBlYWZQ?=
 =?utf-8?B?NStFanl3RGRLNDVsb0FiQUhEVHlCazdkQ3h0aWxvWUFNYi9iRnJvUXRtWjEz?=
 =?utf-8?B?VjRZS3lGQWMwVk9sa3JyTC92OG5DZTNrcnRoeVk4YkJ5ZW16R3F0TkpXMnVD?=
 =?utf-8?B?UW5KZnZ3RHBoWGl2VmQvc21yOW9mYlVHYkRNWVVOSWxLOFhkbkJ1V21QYzBQ?=
 =?utf-8?B?WDc4a3dNL2FJQ3NWcGk3czlSVDJnSnZOa2lRTVRLNlROVXdDQWwwSHZyYStO?=
 =?utf-8?B?Y0V3bEJzcUV2bGVidHRqbnJVY3BiTUxtcjFURHV3djF3d0JrZUIrMUJJeEZx?=
 =?utf-8?B?WU04R3F0NWM1L1J5bHMrQTBMeFlXUjh6ekh5am1RQjNnRE9nd0RMZ0JxVHp0?=
 =?utf-8?B?MEE2TFdGOGduNG5iZjNiMU9kbzFTeE52eXM0dGZQWnRvdC9rbFhnZGN4WVgx?=
 =?utf-8?B?ZzJya3dEVkZBc0FTc2NUdWhzWmxNY2VmS0xqOVN3TU1xZzAxeVc0aTdiQVhB?=
 =?utf-8?B?Ylp0QnpDSnFaTS81MnJXTjZVR3IvdnZFS2kybzlOcGdXWVR6dkk3c1Ryczdo?=
 =?utf-8?B?WkRzbS9ZckxXYjM3VFExMmdxemlzR0pBTVJiNFZsdElmbjlWdDkxMlB2ZFQ4?=
 =?utf-8?B?YXdTZzNHMkVlakE4dE5sVmFiM1BwUlhmMzhsTjVjMUJhbWt5TUUxOVZPYXpU?=
 =?utf-8?B?NG1SY3NwSDhsVFFZY1lEUnVZQ3hiSXNVQ3drQW5pQ1lyMFNPZ3RhSDNqT21T?=
 =?utf-8?B?eEtxUmhZaG1kTm9CS3Q4QWhvc0g0eFR0ZVlzeWsycUNaV2xsMkY5eStjcVBx?=
 =?utf-8?B?VmVFS3N6b0t5Nk1vd1JLRXAvdmdrb0lHcGpKWERkVlFZcTBzUG5DNXhpckdQ?=
 =?utf-8?B?aWFWVjN4eTRQOW5hQzNFNElMb3R6WTFDT0VkTFJmU1hWZ3EyOGpYaFZId01S?=
 =?utf-8?B?R1kzejNTYXpoQkJYUXpLQ1lsRWxCRUliQmFLQlUxTnlrMFBwQWI1ODN1aHBj?=
 =?utf-8?B?QkNjWlM5YlBEMnF4SEY2WXk3RkdkTVh2OC9iUlphMnc1eFRCQ0JGSktVZUgv?=
 =?utf-8?B?eDAzVnBuZ2hxN2VNMllFeDFMQ20veHJvSEhzTE96b2ExSEpLMmkrWjBMWHZq?=
 =?utf-8?B?aUM3MHIrclE5YVl5Y1NNQlo4aC9TRmh0RkdGQTAxckxZaUVKcmxIM3o0cHly?=
 =?utf-8?B?dm5peGk4SWVrNzk1ZVhQajlZSXdlUFZhcy91cXJ6dVhoTUx0emJMY05NVGRo?=
 =?utf-8?B?ZVR2MVBuTks3MlNDNFhoNCtodEd5cmdlY0xzQ01JMHZyaGZEUHcxYnFrdnM4?=
 =?utf-8?B?cXZqSkkwZG5PSDd2NnRNTnFFZHRwK0pFWTBQb2hlTmRkVitibmtvZWRGaVln?=
 =?utf-8?B?THVoRXk0UUZNYkY0TGMxK2NxZXBNTGp6YmRnbXo3U1NVSk9tbk9sbjluSW1y?=
 =?utf-8?B?OGJ0VUNwakJPS2ZPajRWdk1qRDBnNjM4OWxEc1ppYWFBL1ZHZnIxeGpUSEp1?=
 =?utf-8?B?VmFWODcxcDArUSsraTZwbWtZTGdTUVRiTlZkZXlHSVdKYVpkM0FSYjNtcy9u?=
 =?utf-8?B?M2ZJbkFsK3J2ejBXU1p0YU1IdVUzRzZjVVNjdjJDMjhyWVgyV0UyY0Y0eGxh?=
 =?utf-8?B?L3E2STNmQVpiMmhyRi9KWTBRS1BZUmdXdHErc3RVb2ZQaTJ3bk9xdUw3L09I?=
 =?utf-8?Q?rrSA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b27f3ab-c3f2-4cc1-4a21-08de2b89994b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 18:45:11.7648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2KsLx/rmh/x8ut2x2ZTZBFw3j+lYAEpnj9Ujvd4kNqm8JC7+Qtm6k75lSnsSFMjv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7251
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



On 2025-11-24 09:55, Chen, Xiaogang wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> ping
>
> -----Original Message-----
> From: Xiaogang.Chen <xiaogang.chen@amd.com>
> Sent: Thursday, November 20, 2025 9:51 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chen, Xiaogang <Xiaogang.Chen@amd.com>
> Subject: [PATCH v4] drm/amdkfd: Use huge page size to check split svm range alignment
>
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> Fixes: 7ef6b2d4b7e5 (drm/amdkfd: remap unaligned svm ranges that have split)
>
> When split svm ranges that have been mapped using huge page should use huge page size(2MB) to check split range alignment, not prange->granularity that means migration granularity.
>
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 46 +++++++++++++++++++---------
>   1 file changed, 32 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 521c14c7a789..7fe9d569d416 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1144,30 +1144,48 @@ static int
>   svm_range_split_tail(struct svm_range *prange, uint64_t new_last,
>                       struct list_head *insert_list, struct list_head *remap_list)  {
> +       unsigned long last_align_down = ALIGN_DOWN(prange->last, 512);
> +       unsigned long start_align = ALIGN(prange->start, 512);
> +       bool huge_page_mapping = last_align_down > start_align;
>          struct svm_range *tail = NULL;
> -       int r = svm_range_split(prange, prange->start, new_last, &tail);
> +       int r;
>
> -       if (!r) {
> -               list_add(&tail->list, insert_list);
> -               if (!IS_ALIGNED(new_last + 1, 1UL << prange->granularity))
> -                       list_add(&tail->update_list, remap_list);
> -       }
> -       return r;
> +       r = svm_range_split(prange, prange->start, new_last, &tail);
> +
> +       if (r)
> +               return r;
> +
> +       list_add(&tail->list, insert_list);
> +
> +       if (huge_page_mapping && tail->start > start_align &&
> +           tail->start < last_align_down && (!IS_ALIGNED(tail->start, 512)))
> +               list_add(&tail->update_list, remap_list);
> +
> +       return 0;
>   }
>
>   static int
>   svm_range_split_head(struct svm_range *prange, uint64_t new_start,
>                       struct list_head *insert_list, struct list_head *remap_list)  {
> +       unsigned long last_align_down = ALIGN_DOWN(prange->last, 512);
> +       unsigned long start_align = ALIGN(prange->start, 512);
> +       bool huge_page_mapping = last_align_down > start_align;
>          struct svm_range *head = NULL;
> -       int r = svm_range_split(prange, new_start, prange->last, &head);
> +       int r;
>
> -       if (!r) {
> -               list_add(&head->list, insert_list);
> -               if (!IS_ALIGNED(new_start, 1UL << prange->granularity))
> -                       list_add(&head->update_list, remap_list);
> -       }
> -       return r;
> +       r = svm_range_split(prange, new_start, prange->last, &head);
> +
> +       if (r)
> +               return r;
> +
> +       list_add(&head->list, insert_list);
> +
> +       if (huge_page_mapping && head->last > start_align &&
> +           head->last < last_align_down && (!IS_ALIGNED(head->last, 512)))
replace all head->last with head->last + 1 in the if condition, or use 
new_start instead.

With this fixed, this patch is
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
> +               list_add(&head->update_list, remap_list);
> +
> +       return 0;
>   }
>
>   static void
> --
> 2.34.1
>

