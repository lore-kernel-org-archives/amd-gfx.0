Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C79C02194
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 14:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C43F510EB35;
	Fri,  7 Feb 2025 14:58:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Aj4YUnlh";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F91A10EB35
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 14:58:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugkKvL9cm/FytgjyUVmxrY0E3xE6e9GXRtHfNUFldIic/xkkbqxbrUGYhoBn2ZPD2U08DGEmqN9+6zk4NDz3ZxAPdxMQ9KgpmhlODEmcvBAn/no6YBhA0tK/e+us84bnWDR8vk77LU2FgLZN+qt2lkz0rBIMQC6HE2hHJYD2UHXYNYQQ9hZlNumZckK9IrRor3A6MAGP7fbF+jsizGrx9k8gt2NFn0ag8/n2CHdgL7DkCOlH1GfL2h2Y3NBbyALqRZqJzhYORrvt6Nt5eEdkoYpHbMi8U1Q29G+c6zW7VjuB2IWCbcE88Pt96wd4XHTNN1cd7rp3kfGiCZ/9AueO3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cg0+T14pusDjKAZ2wsaM8l/vivaDBtOb1YjlcRSvttM=;
 b=nqh6krVohv2DtP/cDSRCPK0Yt1bit/vlNYRfbo1lD+hywJMvtlnG17+iFgrUDKkIbnBGYeTJ0YaQKbPVUJ4rV5uZEV7BA8zfYf9xcwjqBAwzELEQPgJt0nP/xeMVNhq1v6zVY8Q7kD8sKfc2g2AHkhhuSGarsUBiel8qEwBiDx8wxPLpDTzDBXKLd2UWBG0w6RqfiLiT43Dx5oUkFs3Bu0Yc32ATx1XEYNIsybd3pcEAj+dD9rwm9TaGWtRe+a/Eu9IbDeNKwJj+kJUPH5LC2iYO3dm4U3T91+b+RXMjP1oB05j90pzvRKZH3nVyYTmEGSkLt+6UrGnXJNywUDAeJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cg0+T14pusDjKAZ2wsaM8l/vivaDBtOb1YjlcRSvttM=;
 b=Aj4YUnlhKiNU6x/U3r0V7KJBSjRUnKY3Zn3gV9sH/SHyolsSaxTH7WYtFETqMfaHp8IwpQIzlbEfCapMXE/WghiVWluetqmc3qq/cCg8pi2h1A59HX/OcEHIA8AM5PUpi6kN6cA+rnnC/jqekekeuKFCSSiGN+3CVWucjFpbkBY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 14:58:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 14:58:39 +0000
Message-ID: <e0abcea5-2fc3-4788-a181-463e3fff3729@amd.com>
Date: Fri, 7 Feb 2025 15:58:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Unlocked unmap only clear page table leaves
To: Philip Yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, emily.deng@amd.com
References: <20250123203931.18867-1-Philip.Yang@amd.com>
 <af4ba8cf-b23e-497e-a5ae-2ae4f3aa24f9@amd.com>
 <2cff3ac0-9f56-aaf9-6c6f-59c69606efec@amd.com>
 <328ee3fb-ff15-4a79-aedb-376c68df79a0@amd.com>
 <4b2b5d62-5456-6695-f4a2-4414e6c42458@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <4b2b5d62-5456-6695-f4a2-4414e6c42458@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: 08e60546-bd7d-40cc-6dfb-08dd4787e7da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWFjNndPL2JHUTdzRVlLbVk1RmhBRzNtVEZnV3grTmh0c0wwcXRPTUdzUTUx?=
 =?utf-8?B?NDB6TDdZZ1I4QkpVUjRDdFBSYys3OWU0L095TlZMYk0xT3lCK3FnbzNFSE1l?=
 =?utf-8?B?NEovNHNubWpKbXgyMkFnSTR0dVlyOXNhUFp0dDFJRHpzQU5zbE5ocFF3SHpK?=
 =?utf-8?B?bXY5alNqVzR6SVFwa1hldHZhRGE1OTV5Vzh1d0tyZEFlc0p5RkJZQ0lsdVZh?=
 =?utf-8?B?VHNjNGtQMS9OS05hdVBVYkFBa0VjcUUvb1RqR2pMUlpZYjI1eWxJajRVUEdW?=
 =?utf-8?B?NndIYUFiYlJzNk5ZSUhMZnU4Q05kVGc5dU9KcFgwRCtjemg5MTVxVy8vRVFw?=
 =?utf-8?B?Mk10YS84Y3JWQU5XQnJ4ZmJYc2g0YnZTc0p3Qk5UMWRHOE1ZMTQ5OWFRNWda?=
 =?utf-8?B?RDRTVm5xc1N4NXlucm9mQmd0Q2N3QmRONEwrajNjK2RZV2RhS0l2TVVzaU9q?=
 =?utf-8?B?YmdVWTlVV0EyYUFEOTRuZU1xQ0NBbW5xbWVnc1VRRXg3bFIzeHpmK3E5UmQz?=
 =?utf-8?B?SUJiRXgxb3U5WkFRKzk5UjdKaW5tcll0NkpFQ3RzK2IrQ0hKS0R6Q3JVbm5T?=
 =?utf-8?B?REx4d1ZpMVUxSjN4YTNITGtzVkU4ZUFyQi9PeThqNHdNZkpXSFg4Y2ZCc2xD?=
 =?utf-8?B?VG9EU25DcFNRRkNlaFJEeDFkamI1a3hITE5HUWhUd284WWtTVmhSRGNCbkI3?=
 =?utf-8?B?d2V1N29oQytuWFVHWEZxd0VTeE1QUi9TMW0yYXpvcjZmTUE0M0NUSFF4bURi?=
 =?utf-8?B?QW05UE9ma2NpVk9CZ1NVRUt1a3Z4amNPUk5SR2N1cm1OK1NrNmllbjBoZHhO?=
 =?utf-8?B?UVlXcExPa0d1dEFDSlZKcThPL01SazRwTUszWXlveVh4ZjR3TlVWRW9Mbm5r?=
 =?utf-8?B?emlQZ3ZaalZkZUoxbjlMR29SZ2FKN3R2TmF4T0NlQXY2eDdkUVVPMU9YYVpw?=
 =?utf-8?B?NFFxTnhpK0VIdms4TkgzRStCZjMrTElGVDV6K1p4NVZWMjJZQVV5OSs2YW0r?=
 =?utf-8?B?ZERzOXdTdFFMdDFITnMxb2p4b3UrSzhIejdOd0p1dWkydEV4ejBnb0JGVW10?=
 =?utf-8?B?N0lueDVEbVFWcjA2ZG5tRWhpOFU4bVRmSGJCZlg2SE9LdmZ4NTBaVlZKVGVY?=
 =?utf-8?B?cFA2UlZ5cmdIcjYyOFVCdlJhTEtRSkhXWW9WM2FQRW5DZitZeXNnVzVjRGtp?=
 =?utf-8?B?WVVSMGpINkNYZ0ltZGZRU041ZjkxYll1T1RnaVRLRXFib3VKZzNmZk9YQ3dF?=
 =?utf-8?B?VlZaakNNbitRc2VGSi9XTHJpdXpUSXNxMHNxNy9tUlpjamFJWGNGMkhkaXZk?=
 =?utf-8?B?U0o1aE1YeWxCek1IZzZOTVYyaXQ3dHdVVkxsL0RsUjhRVmM3bnpITys2bjFh?=
 =?utf-8?B?RUMraTRlc0J4aCtkVlI5clgxVVpVd0Z6RjN1ako5NldNZnJSVlVaNXBmWis2?=
 =?utf-8?B?b1JOdHdmTW5FUGFCa3JkZlJTSlh1elRFcmVTc3k3ZWhqU1kxUHFpaDJLcy8x?=
 =?utf-8?B?aWJjNjRHc2JaSVJpZ3ZvVUhpZGJMbjMxcTR3bU5Vdjh1NTNidTN3VEVZZWZ4?=
 =?utf-8?B?b2R3L2hETnlZNDFBbXF3TFF6cm1YSy84L2FVUGE0WFBNWkVzWGE4dGhvSjc3?=
 =?utf-8?B?TDg4QmozT1d2OHM2VktoNytWSk1uSVFSaUhCblhKU0kyb3ZwdVNCSVg3WVQr?=
 =?utf-8?B?NGRhYy85c3ZBQk1lcklBRTFLQWEwcS9MdVZ4WiswRmJ0WEZuejBvUHJSdGpC?=
 =?utf-8?B?d1M5N3AwVTFjeEM2R1hxVUNZZVREbWNwcEZYeU00N1RsUDdvcldHUk9RWXlN?=
 =?utf-8?B?YVQwUk5CenFNN0JDUkg3Q1dGR0FxZ2hEc0UvYzlDdXFTbGRjaGxNdzl0a0hR?=
 =?utf-8?Q?153TQ4+aLlI4j?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0ZhbGlzZVdWc2NqWldrOU9FOVI5Z3E4cjBRM1RnTngrUFFUOXM4MDJCdFhD?=
 =?utf-8?B?cVZuNkxRNVA3dGZuVGo2UnljQjBVaDBQMzNiT2YvVUxMUFZ2cWpMVFdudFBF?=
 =?utf-8?B?eG1rYVpEM3dkenZOYTlyZzhSOGl2eWpHTWprQXVRaVhBMDEzbXRHU0xCc3hB?=
 =?utf-8?B?RjNsZkJXOGZxaEhxemlQNDFBN0dXdnRhaEtoMk9oRk10czVTVkd0WEFoSmd5?=
 =?utf-8?B?ajliUDUxbEpMZnBzMVRmQWdGc0MvL2psd1JmSW9OY1lYNUxYNFB2YTVFbjJ2?=
 =?utf-8?B?aFBZTDQ5bFdWcUNRMVhOejUzTWU2ZFZzVElnUnpsVE9lM2lyK1lKSEZuRlAz?=
 =?utf-8?B?MStjTzU1U0xqZ2xQRElXT1VpK1ErcW1TMkgvN28xekhWR01Cd1kzL1RnZ0lF?=
 =?utf-8?B?T1IwN3JvZExkR3F3QnkwMTdjL0xlQVAzbFlhU1NLaS95azAxSFpmWnNoVmdC?=
 =?utf-8?B?eFRLVFBTbVA1TW5JY1Z4R1d3WHBla29XbW9QRkppaWdyNk93aG90RjNOQlZv?=
 =?utf-8?B?NWFHeVpNaGtZdjNGOFBDNjUwSXJVbUxiVlZKcUlHK1BZNnR2VTBTOW0rUHhV?=
 =?utf-8?B?S0hLU3QxNlZwNUY5dGxvSkFiTWY2QTBVQ28yRE1hWEF1clh3ZHBCcThJWjRo?=
 =?utf-8?B?em9QK2I2L29VazJTeXY3M2xSZ3hsNUlVZUU3MS9LQ1EwVk10b0NFOHppSGNa?=
 =?utf-8?B?MkdFY3kxeGptTnZrMTM0bzFJejNieGNmeGpvd0w3dTVnWmFvME5sWTFXUHA5?=
 =?utf-8?B?eUMxOXdTNXo1RGYxSEsxSzBocnJTRzRZNkxGOUd0YkJNNldhWlhHb0tCK3pB?=
 =?utf-8?B?STBhZTg1SkE0alFMVWN1b2hPZFAzNlBEcDE1Z2xzSms1VENXSmNSUmJRbXdp?=
 =?utf-8?B?SDlDS0pJckFvQjFHZmF5aHBPc2swVGt0dmUvcWRmWE1DS1FUZ2RoWnBPNE8r?=
 =?utf-8?B?emFDOVJGWm1KcWhBQzBYNEhKWXdGS1JGbm5VY1k2OGY4L3FPY2tXL2dBalFk?=
 =?utf-8?B?VGszR3ZiUDhHVkxGT0paY3EwdWpDTWdQRTluK2RiaTB4VEZMay9PNXkzdkVz?=
 =?utf-8?B?R1diQ2dVUnRtZk14WDgzYmFrUjlhU3BhZEZWT1hQa1ZaUnY5TkpHemdkbnVr?=
 =?utf-8?B?MksrcnptSXhybFR0ZTUzZU4zTFE3KzdBdXgxWktYclMxUnJEZ3hDTFQ4ZVpq?=
 =?utf-8?B?SURMdU5TaVgwb2JRNmdHbnFWZk8xZDQwazdScE5QcHZ4bTNuTE9CMkdpbWZR?=
 =?utf-8?B?b3N0aU9BMUNqWW5JSXMyQ01KWmZFcE9lWGs4VnhhZHZoeDBCb2V0Ty8vZXVQ?=
 =?utf-8?B?dG0vL0dZZ09iRnFrYXZSdjdKR0twN2c2bGZlUjBNRHFMTlFHQVFiVHRSdzRM?=
 =?utf-8?B?bVpQL2dEK1VJNExHZE5tcFpBN01icERkdVJ5bTYvN2FZMmZOTXlnaG1LZ2FO?=
 =?utf-8?B?V2NOeFRxbmZCVVJlZ2Z2QVBsaWpwZERMTnBNZEJrQ2pzN2hBQWZObjlGampE?=
 =?utf-8?B?elc5emQ4RFhWeUpYdHVraG90eFNBR3BmalFOVHFsc2Zlbk01NFprQTVRTjI3?=
 =?utf-8?B?bC9GajBkMTRsNDlPb1p2QXE3TXVvN3BoNUY2Q3JUcjlYTkhXSXoxU3dTcm1O?=
 =?utf-8?B?ZWJQRDc5VllYeEtGMDNlR1E4b2VWN0dDSEpEWnNwa2FjK1ZlTUZCZUhxL3pO?=
 =?utf-8?B?ZHM2TXlQcTJPR1g0SHVPOVh5YjljbFJwMlowdEw3VlF1OEFVTW9JU1M0cXZU?=
 =?utf-8?B?Wm1LQjlsdEVOQjZISVVrS0QxV0RsSkQ2VVFtYjdmcHQzREM2aUJnQVpIMitZ?=
 =?utf-8?B?V3BSdjZRYnA2WG1pelRaUy9JTmcxMyt2WjNGanNySWxzUTN3TEFORklKQ0ZF?=
 =?utf-8?B?UmtIZkxTNXFzNS9zYjhPYVQybXl0N0ZnQUtTbDcvMGFkWFJpVTR6OG9yRmdk?=
 =?utf-8?B?eUZzWTRsVmxRamFxZUVPQUFOanVaa09JTThMWGJMdDB1TloyN2ZyNndHRUJr?=
 =?utf-8?B?TEwwYkZBT3VvR1hwSlhTYWM3cHAxaENJaFBGeXNQK0VIdWxrZnI4VllpbnQ0?=
 =?utf-8?B?VGhvcU50UVVMYlptdDhCT0Z5Um95NE9qTlBUeStqQkMzbWNPMGVvMTEyTzdr?=
 =?utf-8?Q?LoonrHjOGKAUD0gyKa2n0KVQE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e60546-bd7d-40cc-6dfb-08dd4787e7da
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 14:58:39.4123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CraKCaM0QD/g1FnxOb347S+oQ2cDf8NWsQf9XveHY24ZXsgRr4o01Wqy5B6rgenE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6363
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

Am 07.02.25 um 15:53 schrieb Philip Yang:
> On 2025-02-07 05:17, Christian König wrote:
>> Am 30.01.25 um 17:19 schrieb Philip Yang:
>>> On 2025-01-29 11:40, Christian König wrote:
>>>> Am 23.01.25 um 21:39 schrieb Philip Yang:
>>>>> SVM migration unmap pages from GPU and then update mapping to GPU to
>>>>> recover page fault. Currently unmap clears the PDE entry for range
>>>>> length >= huge page and may free PTB bo. Then update mapping should
>>>>> alloc new PT bo, but there is race bug that the freed entry bo maybe
>>>>> still on the pt_free list, reused when updating mapping and then 
>>>>> freed,
>>>>> leave invalid PDE entry and cause GPU page fault.
>>>>>
>>>>> By setting the update fragment size to 2MB or 1GB, update will clear
>>>>> only one PDE entry or clear PTB, to avoid unmap to free PTE bo. This
>>>>> fixes the race bug and also improve the unmap and map to GPU
>>>>> performance. Update mapping to huge page will still free the PTB bo.
>>>>>
>>>>> With this change, the vm->pt_freed list and work is not needed. Add
>>>>> WARN_ON(unlocked) in amdgpu_vm_pt_add_list to catch if unmap to 
>>>>> free the
>>>>> PTB.
>>>>>
>>>>> v2: Limit update fragment size, not hack entry_end (Christian)
>>>>>
>>>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 --
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  4 --
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 54 
>>>>> +++++++++--------------
>>>>>   3 files changed, 21 insertions(+), 41 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> index c9c48b782ec1..48b2c0b3b315 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> @@ -2440,8 +2440,6 @@ int amdgpu_vm_init(struct amdgpu_device 
>>>>> *adev, struct amdgpu_vm *vm,
>>>>>       spin_lock_init(&vm->status_lock);
>>>>>       INIT_LIST_HEAD(&vm->freed);
>>>>>       INIT_LIST_HEAD(&vm->done);
>>>>> -    INIT_LIST_HEAD(&vm->pt_freed);
>>>>> -    INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
>>>>>       INIT_KFIFO(vm->faults);
>>>>>         r = amdgpu_vm_init_entities(adev, vm);
>>>>> @@ -2613,8 +2611,6 @@ void amdgpu_vm_fini(struct amdgpu_device 
>>>>> *adev, struct amdgpu_vm *vm)
>>>>>         amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
>>>>>   -    flush_work(&vm->pt_free_work);
>>>>> -
>>>>>       root = amdgpu_bo_ref(vm->root.bo);
>>>>>       amdgpu_bo_reserve(root, true);
>>>>>       amdgpu_vm_put_task_info(vm->task_info);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> index 5d119ac26c4f..160889e5e64d 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> @@ -369,10 +369,6 @@ struct amdgpu_vm {
>>>>>       /* BOs which are invalidated, has been updated in the PTs */
>>>>>       struct list_head        done;
>>>>>   -    /* PT BOs scheduled to free and fill with zero if vm_resv 
>>>>> is not hold */
>>>>> -    struct list_head    pt_freed;
>>>>> -    struct work_struct    pt_free_work;
>>>>> -
>>>>>       /* contains the page directory */
>>>>>       struct amdgpu_vm_bo_base     root;
>>>>>       struct dma_fence    *last_update;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>>> index f78a0434a48f..063d0e0a9f29 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>>>> @@ -546,27 +546,6 @@ static void amdgpu_vm_pt_free(struct 
>>>>> amdgpu_vm_bo_base *entry)
>>>>>       amdgpu_bo_unref(&entry->bo);
>>>>>   }
>>>>>   -void amdgpu_vm_pt_free_work(struct work_struct *work)
>>>>> -{
>>>>> -    struct amdgpu_vm_bo_base *entry, *next;
>>>>> -    struct amdgpu_vm *vm;
>>>>> -    LIST_HEAD(pt_freed);
>>>>> -
>>>>> -    vm = container_of(work, struct amdgpu_vm, pt_free_work);
>>>>> -
>>>>> -    spin_lock(&vm->status_lock);
>>>>> -    list_splice_init(&vm->pt_freed, &pt_freed);
>>>>> -    spin_unlock(&vm->status_lock);
>>>>> -
>>>>> -    /* flush_work in amdgpu_vm_fini ensure vm->root.bo is valid. */
>>>>> -    amdgpu_bo_reserve(vm->root.bo, true);
>>>>> -
>>>>> -    list_for_each_entry_safe(entry, next, &pt_freed, vm_status)
>>>>> -        amdgpu_vm_pt_free(entry);
>>>>> -
>>>>> -    amdgpu_bo_unreserve(vm->root.bo);
>>>>> -}
>>>>> -
>>>>>   /**
>>>>>    * amdgpu_vm_pt_free_list - free PD/PT levels
>>>>>    *
>>>>> @@ -579,20 +558,9 @@ void amdgpu_vm_pt_free_list(struct 
>>>>> amdgpu_device *adev,
>>>>>                   struct amdgpu_vm_update_params *params)
>>>>>   {
>>>>>       struct amdgpu_vm_bo_base *entry, *next;
>>>>> -    struct amdgpu_vm *vm = params->vm;
>>>>> -    bool unlocked = params->unlocked;
>>>>>         if (list_empty(&params->tlb_flush_waitlist))
>>>>>           return;
>>>>> -
>>>>> -    if (unlocked) {
>>>>> -        spin_lock(&vm->status_lock);
>>>>> - list_splice_init(&params->tlb_flush_waitlist, &vm->pt_freed);
>>>>> -        spin_unlock(&vm->status_lock);
>>>>> -        schedule_work(&vm->pt_free_work);
>>>>> -        return;
>>>>> -    }
>>>>> -
>>>>>       list_for_each_entry_safe(entry, next, 
>>>>> &params->tlb_flush_waitlist, vm_status)
>>>>>           amdgpu_vm_pt_free(entry);
>>>>>   }
>>>>> @@ -611,6 +579,11 @@ static void amdgpu_vm_pt_add_list(struct 
>>>>> amdgpu_vm_update_params *params,
>>>>>       struct amdgpu_vm_pt_cursor seek;
>>>>>       struct amdgpu_vm_bo_base *entry;
>>>>>   +    /*
>>>>> +     * unlocked unmap only clear page table leaves, warning to 
>>>>> free the page table entry.
>>>>> +     */
>>>>> +    WARN_ON(params->unlocked);
>>>>> +
>>>>>       spin_lock(&params->vm->status_lock);
>>>>>       for_each_amdgpu_vm_pt_dfs_safe(params->adev, params->vm, 
>>>>> cursor, seek, entry) {
>>>>>           if (entry && entry->bo)
>>>>> @@ -794,6 +767,21 @@ static void amdgpu_vm_pte_fragment(struct 
>>>>> amdgpu_vm_update_params *params,
>>>>>         /* This intentionally wraps around if no bit is set */
>>>>>       *frag = min_t(unsigned int, ffs(start) - 1, fls64(end - 
>>>>> start) - 1);
>>>>> +
>>>>> +    /*
>>>>> +     * MMU notifier callback unlocked unmap only clear PDE or PTE 
>>>>> leaves by setting fragment
>>>>> +     * size to 2MB, 1GB, 512GB. If leave is PDE entry, only clear 
>>>>> one entry, next fragment entry
>>>>> +     * will search again for PDE or PTE leaves.
>>>>> +     */
>>>>> +    if (params->unlocked) {
>>>>> +        if (*frag > 9 && *frag < 18)
>>>>> +            *frag = 9;
>>>>> +        else if (*frag > 18 && *frag < 27)
>>>>> +            *frag = 18;
>>>>> +        else if (*frag > 27)
>>>>> +            *frag = 27;
>>>>> +    }
>>>>> +
>>>>
>>>> That here looks unnecessary, the higher level handling is able to 
>>>> pick the right PD/PT level based on the fragment anyway.
>>>
>>> Thanks for the review, it is very hard to image this case, update 
>>> PDE0 entries, then free PTB bos, as this works fine for locked mapping.
>>>
>>
>> Yeah, I also need up to an hour to swap that logic back into my head 
>> every time I need to take a look at it. Understanding the VM stuff in 
>> both HW and SW is really not easy.
>>
>>> For unlocked unmapping,  after updating multiple PDE0 entries, it is 
>>> incorrect to free PTB bo if there is non-huge page mapping,
>>>
>>>
>>> For example, below is debug log to unmap d4000 to d4806, address 
>>> d4000, d4200 huge page mapping, d4400 not huge page mapping.
>>>
>>> If using fragment 11, it trigger the bug. No issue if we limit the 
>>> fragment to 9
>>>
>>
>> Ah! Ok, I see what you try to solve here.
>>
>> In that case we should probably indeed use a separate function. Since 
>> using the level to determine where to update stuff is then 
>> fundamentally wrong.
>
> yes, fragment size is not needed for unmap, we could optimize the 
> unmap using a separate function for both unlocked unmapping and locked 
> unmapping case, for example 7 pages unmap with address aligned to 4 
> pages, currently we unmap 4 pages, 2 pages, then 1 page, instead we 
> could unmap 7 pages together. But this cannot solve this race 
> condition issue, with unlocked mapping we still need only update leaves.
>
> I think same function for map and unmap is easy to maintain and 
> understand as unmap is just map update with zero PTE.
>
>>
>> In other words even if your round down the fragment size to a 
>> multiple of 9 you can still run into issues when the range which is 
>> unmapped is larger than 1GiB.
>>
>> E.g. you then have frag=18, but would eventually need frag=9 to not 
>> start freeing the 2MiB page tables.
>
> rescan page table after each fragment handling can get correct frag 
> with correct PDE leave or PTB leave, for example, unmap 4GB range, 
> address aligned to 1GB, with first 1GB physical contiguous mapping on 
> PDE1, then 4KB pages on PTE, first we get frag=18 (not frag=20 for 
> 4GB), then the unmap steps:
>
> a. level 1, shift 18, frag 18, update one entry on PDE1
>
> b. rescan and amdgpu_vm_pt_descendant will stop with level 3, shift 0, 
> PTE (frag is still 18, but not used)
>
> c. entry_end is 2MB, clean 512 entries on PTE,
>

Yeah and when one of those 512 entries pointed to a 4k region you end up 
in a messed up state again because you try to free this 4k region after 
the 512 entry update.

This approach here won't work either. You really need a separate 
function which doesn't use the frag size to determine what level of page 
tables to update.

Regards,
Christian.

> d, next frag is updated to 9, and go to step b to rescan, found PDE0 
> entry if huge page 2MB mapping, or PTE for 4KB mapping
>
> Regards,
>
> Philip
>
>
>>
>> Regards,
>> Christian.
>>
>>
>>>
>>> [  192.084456] amdgpu: 4 cursor pfn 0x7f87d4000 level 3 shift 0 
>>> frag_start 0x7f87d4000 frag_end 0x7f87d4800 frag 11
>>>
>>> move cursor up to walk parent node, as this is huge page mapping, no 
>>> PTB bo
>>>
>>> [  192.084463] amdgpu: 5 cursor pfn 0x7f87d4000 level 2 shift 9 
>>> frag_start 0x7f87d4000 frag_end 0x7f87d4800 frag 11
>>>
>>> clean mapping on PDE0, d4000, d4200, d4400, d4600
>>>
>>> [  192.084480] amdgpu: 7 cursor pfn 0x7f87d4000 level 2 shift 9 
>>> frag_start 0x7f87d4800 frag_end 0x7f87d4804 frag 2
>>>
>>> Then if (amdgpu_vm_pt_descendant(adev, &cursor)) is true,
>>>
>>> [  192.084487] amdgpu: 8 cursor pfn 0x7f87d4000 level 3 shift 9 
>>> frag_start 0x7f87d4800 frag_end 0x7f87d4804 frag 2
>>>
>>> This is fine, no PTB bo
>>>
>>> [  192.084494] amdgpu: 9 cursor pfn 0x7f87d4200 level 3 shift 9 
>>> frag_start 0x7f87d4800 frag_end 0x7f87d4804 frag 2
>>>
>>> This is fine, no PTB bo
>>>
>>> [  192.084501] amdgpu: 9 cursor pfn 0x7f87d4400 level 3 shift 9 
>>> frag_start 0x7f87d4800 frag_end 0x7f87d4804 frag 2
>>>
>>> PTB bo found, trigger the WARNING in this patch, to free PTB bo.
>>>
>>>
>>> [  192.084525] ------------[ cut here ]------------
>>> [  192.084531] WARNING: CPU: 9 PID: 3249 at 
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c:585 
>>> amdgpu_vm_ptes_update+0xa2c/0xbd0 [amdgpu]
>>> [  192.084854] Modules linked in: nf_tables nfnetlink ast 
>>> drm_shmem_helper k10temp msr fuse ip_tables x_tables amdgpu amdxcp 
>>> drm_client_lib drm_ttm_helper ttm drm_exec gpu_sched 
>>> drm_suballoc_helper video wmi cec drm_buddy drm_display_helper 
>>> drm_kms_helper drm drm_panel_orientation_quirks i2c_piix4
>>> [  192.084987] CPU: 9 UID: 1000 PID: 3249 Comm: kfdtest Tainted: 
>>> G        W          6.12.0-kfd-yangp #146
>>> [  192.084997] Tainted: [W]=WARN
>>> [  192.085004] Hardware name: GIGABYTE MZ01-CE0-00/MZ01-CE0-00, BIOS 
>>> F12 08/05/2019
>>> [  192.085011] RIP: 0010:amdgpu_vm_ptes_update+0xa2c/0xbd0 [amdgpu]
>>> [  192.085316] Code: 24 4c 8b 54 24 78 4d 89 f8 48 c7 c7 b0 83 0a c1 
>>> 4c 8b 4c 24 50 50 8b 4c 24 10 e8 8f bc b9 d2 48 8b 74 24 68 5a e9 70 
>>> fe ff ff <0f> 0b e9 92 fe ff ff 48 bd 00 00 00 00 01 00 00 00 ba ff 
>>> ff ff ff
>>> [  192.085325] RSP: 0018:ffffbed102bf78b8 EFLAGS: 00010202
>>> [  192.085336] RAX: ffff9f04b654a1f8 RBX: 0000000000000009 RCX: 
>>> 0000000000000000
>>> [  192.085344] RDX: 0000000000000002 RSI: 00000007f87d4400 RDI: 
>>> ffff9f0af6f9cac8
>>> [  192.085351] RBP: 00000007f87d4806 R08: 0000000000000000 R09: 
>>> c0000000ff7fffff
>>> [  192.085357] R10: 0000000000000001 R11: ffffbed102bf76e0 R12: 
>>> ffff9f046b100000
>>> [  192.085364] R13: 0000000000bf4000 R14: ffffbed102bf79e0 R15: 
>>> 00000007f87d4800
>>> [  192.085371] FS:  00007f87d5a515c0(0000) GS:ffff9f0af6f80000(0000) 
>>> knlGS:0000000000000000
>>> [  192.085379] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  192.085386] CR2: 000055a190964b78 CR3: 0000000163fca000 CR4: 
>>> 00000000003506f0
>>> [  192.085393] Call Trace:
>>> [  192.085400]  <TASK>
>>> [  192.085408]  ? __warn+0x90/0x190
>>> [  192.085422]  ? amdgpu_vm_ptes_update+0xa2c/0xbd0 [amdgpu]
>>> [  192.085832]  ? report_bug+0xfc/0x1e0
>>> [  192.085849]  ? handle_bug+0x55/0x90
>>> [  192.085860]  ? exc_invalid_op+0x17/0x70
>>> [  192.085871]  ? asm_exc_invalid_op+0x1a/0x20
>>> [  192.085892]  ? amdgpu_vm_ptes_update+0xa2c/0xbd0 [amdgpu]
>>> [  192.086199]  ? srso_return_thunk+0x5/0x5f
>>> [  192.086216]  amdgpu_vm_update_range+0x242/0x850 [amdgpu]
>>> [  192.086537]  svm_range_unmap_from_gpus+0x117/0x300 [amdgpu]
>>> [  192.086906] svm_range_cpu_invalidate_pagetables+0x426/0x7a0 [amdgpu]
>>> [  192.087259]  ? lock_release+0xc8/0x290
>>> [  192.087276] __mmu_notifier_invalidate_range_start+0x233/0x2a0
>>> [  192.087292]  migrate_vma_setup+0x1a3/0x250
>>> [  192.087307]  svm_migrate_ram_to_vram+0x260/0x710 [amdgpu]
>>>
>>> Regards,
>>>
>>> Philip
>>>
>>>>
>>>> Apart from that the patch looks good to me.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>       if (*frag >= max_frag) {
>>>>>           *frag = max_frag;
>>>>>           *frag_end = end & ~((1ULL << max_frag) - 1);
>>>>> @@ -931,7 +919,7 @@ int amdgpu_vm_ptes_update(struct 
>>>>> amdgpu_vm_update_params *params,
>>>>>                   /* figure out the next fragment */
>>>>>                   amdgpu_vm_pte_fragment(params, frag_start, end,
>>>>>                                  flags, &frag, &frag_end);
>>>>> -                if (frag < shift)
>>>>> +                if (frag < shift || (params->unlocked && shift))
>>>>>                       break;
>>>>>               }
>>>>>           } while (frag_start < entry_end);
>>>>
>>

