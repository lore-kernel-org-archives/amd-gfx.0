Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D29D66BBB
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 22:45:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0C5D10E075;
	Wed, 17 Dec 2025 22:45:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="axjmNWom";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012029.outbound.protection.outlook.com [40.107.209.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B438E10E075
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 22:45:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5Tnhxa8G8cbl5BSQvRHHL+rj4tmqufVB3NXTue8LFKZIyMEk4ft3GfSkRQlDd0IwrHBRgBy10gHwulIAQjcEguODyCH1k5YcvQIBNRCzv7D126iHBJW+yscxeMe9tc8hmd+lT8CUeYu77bpV3DQiKCJrm7qHzaq7wzZWTMmz2iyjRCFABiZ912Qc/o+6sXNRFL+nOHv7tKIzVqNDitoiLwOtIfX51E/OVdJuJas7xsfC0/lPKjBCW1WgNn5uQ+Ko0bN5MFeVn6WWIo5uJFZBpjLQZWsMBBkru2vEMi/1xOW9/NKgS0MSAbeRFqJK9nHmgFLb58oZykSrgonVCZTcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWsq44fg/Pi6LFBQPGP7l7MYnjqkjsW5lCygsIq5dmk=;
 b=jyd9FL6haaXuatG+b2dUrGsczi+awb7z9KVhISPHqt3UTcwNCMmcpICilqSof8BdNFNLFRvG/6eY3On3xCaxt4FHcipaLgiO5F0vfjcbM56aKIHzqHPRnn+YsM9/7JlmDxBal9f+/xjwx5QahL4T+vIDUTWFn9dN+UYY4I6prwrjU4U5pciDXu2Cf8VikAANkCpyFdXo+pRSPJxufXW5J9qveXS9fjIEPgXlXDHHW59fjDshzYixNTGnRqIDBgiCfaCeD1mNL+Aej73ubXr95/Al4kOWii6fMUflTDVx615a6Wg0ZPCLDx+0PoEL6IzetxKofr5dPQv5QGqdkUcBtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWsq44fg/Pi6LFBQPGP7l7MYnjqkjsW5lCygsIq5dmk=;
 b=axjmNWomWoiMyplbvU3lzx+tupBxo0kE60q4J6nEW3U+Zieq9frLosDGxuc3LxJaa7yqMb8G6+vJy+3eCROa7i1KR1pQjzsel0OHT9vgjyfBfbTl3ezhrxUbOgEBnGdZ3+FhQUSxJKYfrFZ4BtKPP79AcDHZ6pz6xJo0AjXqlkc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 SA1PR12MB8843.namprd12.prod.outlook.com (2603:10b6:806:379::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.7; Wed, 17 Dec 2025 22:45:05 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 22:45:05 +0000
Content-Type: multipart/alternative;
 boundary="------------ZsqQU4gGC1DU9EFogU7Pgr7Z"
Message-ID: <91cfe4b3-6246-4e07-9a68-77dcd639124f@amd.com>
Date: Wed, 17 Dec 2025 16:45:02 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] drm/amdkfd: Map VRAM MQD on GART
To: Philip Yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com, david.yatsin@amd.com,
 pierre-eric.pelloux-prayer@amd.com, kent.russell@amd.com
References: <20251215165630.1172383-1-Philip.Yang@amd.com>
 <20251215165630.1172383-7-Philip.Yang@amd.com>
 <c3415b20-da51-4aac-acf7-841fe9621b3d@amd.com>
 <84a6dc2d-45bb-4f9f-a84d-47b8727485de@amd.com>
 <85112e20-9a07-4537-ae1d-044179248758@amd.com>
 <03ff096c-87cb-4a11-9a14-155cd5b150b7@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <03ff096c-87cb-4a11-9a14-155cd5b150b7@amd.com>
X-ClientProxiedBy: SA0PR11CA0174.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::29) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|SA1PR12MB8843:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bfb6e9f-75ca-4185-1597-08de3dbdebf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVNyNGhHdVkwVmJXUktWVGx4alJpK3c5NE5sUlZ3NjRJRjhvMWM1ZGxFSU0y?=
 =?utf-8?B?RFVsWHBJZG5iWXJOb3RiSmFldGxqU1NNdEhVZDlUN0dFcXFITWdwQ2Jqai9L?=
 =?utf-8?B?aWkrNUJXemlNVGtUMVBNSWErSG9TRFhId2Q5QTRSWmdCanBuSmY0a2VMQSt3?=
 =?utf-8?B?NVU2eVNmRmJUai8wdjZmL2ROU1Fob2w1U3JWME9ZNDdicVAvT1RZUVl5RWVi?=
 =?utf-8?B?dTkzaVJkQmhWZGpiNXF0aklFMEJ6S282aGNxcEpWeWwvSS9vZlF0bG9lZzZn?=
 =?utf-8?B?WGpDZWVqT2JZNVBoRGRHb2dyRloxRkdwN1p6TnFIVDQ1djZDR0JLTXlXTVFQ?=
 =?utf-8?B?eUp1VzBYanF4SjVJOGd5MjcyamZzWmF4L3dCaktJOEhDeU1pUjNlVTJxWVBX?=
 =?utf-8?B?QS95QlpLeWtnZ2tPdjBKdHlwM3h3K2tzRytGdkJDWU1vMFU5UXRISFFTUHlB?=
 =?utf-8?B?cDFLRDZKbkUraGgrK1ZsUUkyMHFmZVkrSkJPZHhTR3plRHNQM1FBL0U0bEFV?=
 =?utf-8?B?VnFjN3VQd1FsYlRGWVcvaDJ2dzZxSS82S1JweEU5Vm4remNJUzI5M2k4M2ZC?=
 =?utf-8?B?SW52STVxOHp1bGwwRzNSU0QxOWJOaDF2cGlTQ2ZGQWFqbjhGRStUQTlzKzJx?=
 =?utf-8?B?NjdkdXhCT1BTbHhBUHpIZElFdkFkb3FuNWZOTVNjRUlPVDNiTGN3WjlRbTNt?=
 =?utf-8?B?YW1EVTQ2M0tUK25zU2diRWVvRFNPV1M0V3dPZFFZS1pPMEgvY1R1eW5YNzJI?=
 =?utf-8?B?N1h0ZituMis1U2JERFZlR3FCeDFQaDJpeDBTVGE1ZVhzdjFUNmY0cGVyWmVJ?=
 =?utf-8?B?ZzNic2orV2FmZS9KQ05TelhUZFpxWHNqRmRzdFI5WHRPWmk2WlVmMTZiUU9l?=
 =?utf-8?B?WGtrUUUwVVVUY2cwWDB4TkdSUlRUQ2ZTRFY5R0l1WTRrTlZQZ1dpdHhRVktp?=
 =?utf-8?B?dFJ2RzVnSkMrZTdFOSsvcVBBYVZwSU54T2ZreFFjeXgzYlB5cjNEZEtPakhp?=
 =?utf-8?B?bU1rdm45dEdtb2daQ1NCenNYQnlEMG9oY2VGL3Bab0UxMzUxUjNkdTNyTjQw?=
 =?utf-8?B?dkhudVRsUUVlM3h2amNNM1ZZYXZRTW9BNzQ4czFvZE45R3h2dk0zTGJFeitB?=
 =?utf-8?B?cUNPZGl3Qi9FMW5CZ0hteTlmVitJRkpFSTFCaGZHRlowYkI5SFlKekVnWmkz?=
 =?utf-8?B?bDk2R0dvVFJBWkFqdEo4MzZ3L0ZQaDZQbnJuQVpRcmJUbDZaOHFhaHBLckVw?=
 =?utf-8?B?L0RScTNzUnZ3UFNpbGIxWW4raG05em1qNzh0Mk1nY0wrY3F5MWJXUW1WQ1Mw?=
 =?utf-8?B?bDZZbmFvM0ZVNDFWdlBNbFBPaEd3Y2V5UG4ySUZTOCtONVNZMWpDZWRkTnZY?=
 =?utf-8?B?alQzWGJhWW02NGF0dVJGSjMyN0hkQkNmdHJVTmMxM0haNUwzQTJIWmdwYzVF?=
 =?utf-8?B?THU1L1VCZE8rbnoyV1J2MlVZenc0OElVM3QwMnJEYk1uaUdQRXFKWFNlRjBV?=
 =?utf-8?B?cnB3NGNWdHN5bFE1NkN3VEhaSHpMREwxNzlCNHdvUnJ1Z1dOOVRQRFhzejhQ?=
 =?utf-8?B?VXh1d2g0ZmNCZU1ocWVKNzZBOXMwblMxMlV3dUJUZ2RyY1Njbmg1NGhESW9h?=
 =?utf-8?B?QWJPZnhac2tFZXdJcVVxRXRlc1d3WG9RTGxDQTlpZlNSakdKREpaOW41aDNs?=
 =?utf-8?B?Rit3MTF2Q01QeFJxQk1lSzYxdHFjNXFtNVdLNEdJcjg3TGcvbzZRVHVsRzBS?=
 =?utf-8?B?VTZCUmhyd2Iva095TFBEbTE2UWNHd09VTno2eUNkUDVjWUphRllRVllxa0tN?=
 =?utf-8?B?WG81alVhN3dhS1FJZVlyRitFdXFGcnVJeklKZVRrZGEvWE9FVEhLeFV4K3hl?=
 =?utf-8?B?R1FoTWpwd1NOeDVEbFRoWVRCdkF0b0o1SDY5N0FwNmxVL3NadjR5SHB4TkFq?=
 =?utf-8?Q?OFpMdVBBe1NezmxNvq6Ys4iS+5Qwdbpx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVRod2I4azEwb0hBTkdtMUY1bE5JTFhaKzBKeHlHUFJLQzVpdkFrYTRlbWVO?=
 =?utf-8?B?bWJXcmVpOHJCNzhSbFVwTmo4RFpYMWZCRmVkeC95a2xtdmN0RXFUeTFpUHdn?=
 =?utf-8?B?VEVBVUlwVXVLMjRUbU40dkFwbXU3TndTM0puZmlSQWdBYWpKY2tDaFprVDFF?=
 =?utf-8?B?dkFuU1dCMEZ6TlFsTmExODZzT2NmaGNtdmZKbFhJMkFEdHRLZGE0UFhrV1FK?=
 =?utf-8?B?elFneUwrL09uOWZhZFNrNjcwamNYUU8rNkJJZytScFBBQ2dKOFFXaFlhd2NE?=
 =?utf-8?B?cmQzbllYTGtYcmlISXNjY244MDlMVVYySUFVcGNtYVgvWTVOc005TE1QSDFB?=
 =?utf-8?B?K0RZTHArUzh5OUtwUTBqSWttT2I2OTlKbit0Y0c3Vmh1ZFVvQ2ZRajZIS3hy?=
 =?utf-8?B?cVlwTHJTbkRnWDFiSVZUZ2F6VlVoaStrZkFNV3BndkQwSWFOWFpKTVZNNW9I?=
 =?utf-8?B?N0wzVHhzMUtndnNnTDlSTHZQMktqN2trRmxISjQxLzJRYmFZZXJMZWxId3FL?=
 =?utf-8?B?TDh5aE0yQnhNcmsvZ0FFM1EyUzFTazBLSExSR2FXcmcyamYraG51b0FqTXBx?=
 =?utf-8?B?QTZEU0p2VGVkMnNEQk9LRytYazJ2ZmV3c3dadllSWXA0VFU3bmNGVmh6eVgr?=
 =?utf-8?B?WnZZc09XUVJxVkFvTzRuaklqc3dKN2Jra1FSNkM1Si9YejQ5UFVCVC94Mll3?=
 =?utf-8?B?SExFZWs3WFYvazFPbitaVE1MZUJzZUJOajFWS0RiNWZxUStyMHBienMxNC8y?=
 =?utf-8?B?SlRhOTlBZCtQVkIzeE8xOVNFUXd3NXUyVFgxa3BYSGNBUStKYU5Qb21Pa2Np?=
 =?utf-8?B?RW5aQmZvY2kwbFBnazdrZ0c2M0FrTS9YSDVjM3g4UkZQRUErWE9MYlEwMmZN?=
 =?utf-8?B?Z3gwUnl3aFdNYXZNc2ZNR0Ntd0x0enJPalB6a3VLY011MU5hN2cvVnZEdWpX?=
 =?utf-8?B?OHM1WGd1RzgrMHFicEZjbGJCTzVXK2U0TU94c08xSkF6Z25KRDlDeHNTT1RV?=
 =?utf-8?B?RmZGaEVLQ1B0Zld5cWhxYnhpTENaVHdKSkhPa1pKdEZjbzlIdUFCeHJhRUhQ?=
 =?utf-8?B?Zk1EdS9OYnl6akMyYks4YW1VUFFsZVIxZlNNMWQzUElkY3JuQkFuZzZ2YlBU?=
 =?utf-8?B?T1lMVmltY0ZPQ2tVRHI2ejFsOHhzM3ZzOWttRzUvZ2I5UC84NFVIblo2R2xI?=
 =?utf-8?B?QzFJL0V2QWtPbzFrcmVrS0taM3R2TmZYOEkyUVFnN3Q3Nm9iNzQvemFWNXVM?=
 =?utf-8?B?Z2JkMEU3M29oNHEyd0tSOFRuNlk1aElVM2Z6bGlDQTdzbVRSNlpPVjEvcEcx?=
 =?utf-8?B?eVArR1ZCRmFjS1AzRzhTTWZhcEUycUY3QS8ydmd0dGJweEdDZlFjUWdMOHl2?=
 =?utf-8?B?clI2K3BTVEZWWVE4RUJMVmJiTWx3NWxsQi9WUzRLeHdLb0ozSTdQOEJCNjFJ?=
 =?utf-8?B?UkFybGY5SmV5ZXZSRVZFUjhNVCtETEdhSUhDWVBRclFURVorbzJHaHZ4OE1w?=
 =?utf-8?B?dVQrMDB5ZHdmdEl4bEpGT21Xdm1LSGxYVWMvUVZiK2NHK3FTVVdxVDhBQnY3?=
 =?utf-8?B?cTJ4djhmOXNIY1hDOFZtdm9uQzBJL2thMjIyU2pwV21IMFVBMk1Tc1c5VUVF?=
 =?utf-8?B?Ykoyck5KQ1l1eXJFUVZlSkNud3VuOXNQbjhkNVlIWE12cmExQzF3MHNBN2xN?=
 =?utf-8?B?ZU1QdERtMkNKNEl5SU1XRCt1ZW9KMEl0c0hhM3laT3QvVE5NVEJsTmx1aHI4?=
 =?utf-8?B?c0xPelhtNDhRUUxYMmtSeHJUZWt3QmNZZHQrTWhKTFlUS2Jva3BKdUl0b3l6?=
 =?utf-8?B?ZWRzMjF4ZEJtUERCUUJBc0FBVXBmb3hWTHBoall1WTNIMFkzK3FaY1liYmsx?=
 =?utf-8?B?QnQySDhRU2IvSGhQOUt3dHlxZ2RoRXBkUDhib1ZFSVZZY0g5aDFNdW1ROHI0?=
 =?utf-8?B?V3RZZjkvTjQzcU55SjYxa2VUQS9sTXlsdXBPMzc5bzBBZFlWR3dCK01xa2Vk?=
 =?utf-8?B?OEpYb0dQY2ZyMFZGZnF5aXVkdDVaQ1gvK29tZmhweUQyQURUaGZFcnRpT21x?=
 =?utf-8?B?Y3FyVEhNa0k2SWV6SndzRTdjb2p0dEtDUDlWMitFNDhYeDJqc21KL01LZUFa?=
 =?utf-8?Q?6DM0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bfb6e9f-75ca-4185-1597-08de3dbdebf3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 22:45:05.1996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9wCxkYy49m3iRkYNyHR4aYphzeNoYYQo6upK3rQUR7dE1KS5mAGLWcVI3ZnXrSnq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8843
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

--------------ZsqQU4gGC1DU9EFogU7Pgr7Z
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/17/2025 4:24 PM, Philip Yang wrote:
>
>
> On 2025-12-17 11:37, Chen, Xiaogang wrote:
>>
>> On 12/17/2025 9:06 AM, Philip Yang wrote:
>>>
>>>
>>> On 2025-12-16 17:35, Chen, Xiaogang wrote:
>>>>
>>>>
>>>> On 12/15/2025 10:56 AM, Philip Yang wrote:
>>>>> MQD BO on VRAM access via FB aperture is mtype UC uncaching, map
>>>>> to GART as mtype RW caching, to reduce queue switch latency
>>>>>
>>>>> Add GART mm_node to kfd mem obj to free the GART entries after
>>>>> MQD mem obj is freed.
>>>>>
>>>>> Use resource cursor to handle VRAM resource which maybe on multiple
>>>>> blocks and use cursor_gart to handle GART entries.
>>>>>
>>>>> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 94 
>>>>> +++++++++++++++++++
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  4 +-
>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  2 +
>>>>>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  9 ++
>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
>>>>>   5 files changed, 109 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> index 4f8bc7f35cdc..d7bf96a7b6b2 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>>> @@ -880,6 +880,67 @@ static void 
>>>>> amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
>>>>>       }
>>>>>   }
>>>>>   +/*
>>>>> + * Same function and MQD description from 
>>>>> amdgpu_ttm_gart_bind_gfx9_mqd,
>>>>> + * except this is for MQD on VRAM BO and use dynamic alloc GART 
>>>>> entries.
>>>>> + */
>>>>> +static void amdgpu_ttm_gart_bind_gfx9_mqd_vram(struct 
>>>>> amdgpu_device *adev,
>>>>> +                struct ttm_buffer_object *tbo,
>>>>> +                struct drm_mm_node *mm_node,
>>>>> +                uint64_t flags)
>>>>> +{
>>>>> +    uint64_t total_pages;
>>>>> +    int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
>>>>> +    uint64_t page_idx, pages_per_xcc;
>>>>> +    struct amdgpu_res_cursor cursor_gart;
>>>>> +    struct amdgpu_res_cursor cursor;
>>>>> +    uint64_t ctrl_flags = flags;
>>>>> +    int i;
>>>>> +
>>>>> +    total_pages = tbo->base.size >> PAGE_SHIFT;
>>>>> +
>>>>> +    amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_NC, 
>>>>> &ctrl_flags);
>>>>> +
>>>>> +    if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 3))
>>>>> +        amdgpu_gmc_get_vm_pte(adev, NULL, NULL, 
>>>>> AMDGPU_VM_MTYPE_RW, &flags);
>>>>> +
>>>>> +    pages_per_xcc = total_pages;
>>>>> +    do_div(pages_per_xcc, num_xcc);
>>>>> +
>>>>> +    amdgpu_res_first(NULL, mm_node->start, total_pages, 
>>>>> &cursor_gart);
>>>> no need use cursor_gar. mm_node->start + n indicates where to 
>>>> update gart page table.
>>> yes, that is the last version, change to use resource cursor for 
>>> both gart entries and VRAM pages
>>>>> + amdgpu_res_first(tbo->resource, 0, tbo->resource->size, &cursor);
>>>>> +
>>>>> +    for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += 
>>>>> pages_per_xcc) {
>>>>> +        u64 start_page;
>>>>> +        u64 npages, n;
>>>>> +        u64 pa;
>>>>> +
>>>>> +        start_page = cursor_gart.start;
>>>>> +        pa = cursor.start + adev->vm_manager.vram_base_offset;
>>>>> +        n = 1;
>>>>> +        amdgpu_gart_map_vram_range(adev, pa, start_page, n,
>>>>> +                       flags, NULL);
>>>>> +
>>>>> +        npages = pages_per_xcc - 1;
>>>>> +        while (npages) {
>>>>> +            amdgpu_res_next(&cursor_gart, n);
>>>>> +            amdgpu_res_next(&cursor, n * PAGE_SIZE);
>>>>> +
>>>>> +            start_page = cursor_gart.start;
>>>>> +            pa = cursor.start + adev->vm_manager.vram_base_offset;
>>>>> +            n = min3(cursor.size / PAGE_SIZE, cursor_gart.size, 
>>>>> npages);
>>>>> +
>>>>> +            amdgpu_gart_map_vram_range(adev, pa, start_page, n,
>>>>> +                           ctrl_flags, NULL);
>>>>> +
>>>>> +            npages -= n;
>>>>> +        }
>>>>> +
>>>>> +        amdgpu_res_next(&cursor_gart, n);
>>>>> +        amdgpu_res_next(&cursor, n * PAGE_SIZE);
>>>>> +    }
>>>>> +}
>>>>> +
>>>>>   static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>>>>>                    struct ttm_buffer_object *tbo,
>>>>>                    uint64_t flags)
>>>>> @@ -1017,6 +1078,39 @@ int amdgpu_ttm_alloc_gart(struct 
>>>>> ttm_buffer_object *bo)
>>>>>       return 0;
>>>>>   }
>>>>>   +/*
>>>>> + * amdgpu_ttm_alloc_gart_vram_bo - Bind VRAM pages to GART mapping
>>>>> + *
>>>>> + * call amdgpu_ttm_alloc_gart_entries to alloc GART dynamically
>>>>> + */
>>>>> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
>>>>> +                  struct drm_mm_node *mm_node,
>>>>> +                  u64 *gpu_addr)
>>>>> +{
>>>>> +    struct ttm_buffer_object *bo = &abo->tbo;
>>>>> +    struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>>>>> +    uint64_t flags;
>>>>> +    int r;
>>>>> +
>>>>> +    /* Only for valid VRAM bo resource */
>>>>> +    if (amdgpu_mem_type_to_domain(bo->resource->mem_type) !=
>>>>> +        AMDGPU_GEM_DOMAIN_VRAM)
>>>>> +        return 0;
>>>>> +
>>>>> +    r = amdgpu_gtt_mgr_alloc_entries(&adev->mman.gtt_mgr, mm_node,
>>>>> +                     amdgpu_bo_ngpu_pages(abo), 0);
>>>>> +    if (r)
>>>>> +        return r;
>>>>> +
>>>>> +    /* compute PTE flags for this buffer object */
>>>>> +    flags = amdgpu_ttm_tt_pte_flags(adev, NULL, bo->resource);
>>>>> +    amdgpu_ttm_gart_bind_gfx9_mqd_vram(adev, bo, mm_node, flags);
>>>>> +    amdgpu_gart_invalidate_tlb(adev);
>>>>> +
>>>>> +    *gpu_addr = mm_node->start << PAGE_SHIFT;
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>>   /*
>>>>>    * amdgpu_ttm_recover_gart - Rebind GTT pages
>>>>>    *
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>>> index 25640bed7dc9..9f07856433fd 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>>> @@ -140,7 +140,6 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device 
>>>>> *adev);
>>>>>     bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
>>>>>   void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
>>>>> -
>>>>>   int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
>>>>>                    struct drm_mm_node *node,
>>>>>                    u64 num_pages,
>>>>> @@ -191,6 +190,9 @@ int amdgpu_fill_buffer(struct 
>>>>> amdgpu_ttm_buffer_entity *entity,
>>>>>                  u64 k_job_id);
>>>>>     int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
>>>>> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
>>>>> +                  struct drm_mm_node *mm_node,
>>>>> +                  u64 *gpu_addr);
>>>>>   void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>>>>>   uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, 
>>>>> uint32_t type);
>>>>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c 
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>>>>> index f78b249e1a41..edb72f4ef82d 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>>>>> @@ -225,6 +225,8 @@ void kfd_free_mqd_cp(struct mqd_manager *mm, 
>>>>> void *mqd,
>>>>>             struct kfd_mem_obj *mqd_mem_obj)
>>>>>   {
>>>>>       if (mqd_mem_obj->mem) {
>>>>> + amdgpu_gtt_mgr_free_entries(&mm->dev->adev->mman.gtt_mgr,
>>>>> +                        &mqd_mem_obj->mm_node);
>>>>> amdgpu_amdkfd_free_kernel_mem(mm->dev->adev, &mqd_mem_obj->mem);
>>>>>           kfree(mqd_mem_obj);
>>>>>       } else {
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c 
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>>>> index 14123e1a9716..5828220056bd 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>>>> @@ -148,6 +148,15 @@ static struct kfd_mem_obj 
>>>>> *allocate_mqd(struct kfd_node *node,
>>>>>               kfree(mqd_mem_obj);
>>>>>               return NULL;
>>>>>           }
>>>>> +
>>>>> +        retval = amdgpu_ttm_alloc_gart_vram_bo(mqd_mem_obj->mem,
>>>>> + &mqd_mem_obj->mm_node,
>>>>> + &(mqd_mem_obj->gpu_addr));
>>>>
>>>> Here you create new drm_mm_node for gart page table entries. Before 
>>>> that amdgpu_amdkfd_alloc_kernel_mem also creates gart page table 
>>>> entries and drm_mm_node. Is there duplication or how do you handle 
>>>> the entries/drm_mm_node from amdgpu_amdkfd_alloc_kernel_mem?
>>>>
>>> amdgpu_ttm_alloc_gart allocate GART entries for GTT domain only.
>>
>> Why still need keep GART entries for GTT domain if use vram bo 
>> through GART here?
> If MQD allocated on VRAM, amdgpu_ttm_alloc_gart will not alloc GART 
> entries because this check
>
>     if (bo->resource->start != AMDGPU_BO_INVALID_OFFSET)
>         return 0;
>
> bo->resource->start is AMDGPU_BO_INVALID_OFFSET only for GTT bo 
> resource, VRAM bo->resource->start has valid value.

Ok, thanks for pointing it. Then at amdgpu_amdkfd_alloc_kernel_mem we do 
not need call amdgpu_ttm_alloc_gart for AMDGPU_GEM_DOMAIN_VRAM domain. 
That made me think a GART range/drm_mm_node is created.

This using vram for MQD is not asic specific and use same logic. Can we 
make it a general method for all asic?

Regards

Xiaogang

>
> Regards,
> Philip
>
>>
>> Regards
>>
>> Xiaogang
>>
>>>
>>> Regards,
>>> Philip
>>>>
>>>> Regards
>>>>
>>>> Xiaogang
>>>>
>>>>> +        if (retval) {
>>>>> +            amdgpu_amdkfd_free_kernel_mem(node->adev, 
>>>>> &(mqd_mem_obj->mem));
>>>>> +            kfree(mqd_mem_obj);
>>>>> +            return NULL;
>>>>> +        }
>>>>>       } else {
>>>>>           retval = kfd_gtt_sa_allocate(node, sizeof(struct v9_mqd),
>>>>>                   &mqd_mem_obj);
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> index 06cd675c9e74..55738b30c2ec 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> @@ -253,6 +253,7 @@ struct kfd_mem_obj {
>>>>>       uint64_t gpu_addr;
>>>>>       uint32_t *cpu_ptr;
>>>>>       void *mem;
>>>>> +    struct drm_mm_node mm_node;
>>>>>   };
>>>>>     struct kfd_vmid_info {
>>>
>
--------------ZsqQU4gGC1DU9EFogU7Pgr7Z
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 12/17/2025 4:24 PM, Philip Yang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:03ff096c-87cb-4a11-9a14-155cd5b150b7@amd.com">
      <br>
      <br>
      On 2025-12-17 11:37, Chen, Xiaogang wrote:
      <br>
      <blockquote type="cite">
        <br>
        On 12/17/2025 9:06 AM, Philip Yang wrote:
        <br>
        <blockquote type="cite">
          <br>
          <br>
          On 2025-12-16 17:35, Chen, Xiaogang wrote:
          <br>
          <blockquote type="cite">
            <br>
            <br>
            On 12/15/2025 10:56 AM, Philip Yang wrote:
            <br>
            <blockquote type="cite">MQD BO on VRAM access via FB
              aperture is mtype UC uncaching, map
              <br>
              to GART as mtype RW caching, to reduce queue switch
              latency
              <br>
              <br>
              Add GART mm_node to kfd mem obj to free the GART entries
              after
              <br>
              MQD mem obj is freed.
              <br>
              <br>
              Use resource cursor to handle VRAM resource which maybe on
              multiple
              <br>
              blocks and use cursor_gart to handle GART entries.
              <br>
              <br>
              Signed-off-by: Philip Yang<a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
              <br>
              ---
              <br>
              &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 94
              +++++++++++++++++++
              <br>
              &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 +-
              <br>
              &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c&nbsp; |&nbsp; 2 +
              <br>
              &nbsp; .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c&nbsp;&nbsp; |&nbsp; 9 ++
              <br>
              &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 +
              <br>
              &nbsp; 5 files changed, 109 insertions(+), 1 deletion(-)
              <br>
              <br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
              <br>
              index 4f8bc7f35cdc..d7bf96a7b6b2 100644
              <br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
              <br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
              <br>
              @@ -880,6 +880,67 @@ static void
              amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
              <br>
              &nbsp; }
              <br>
              &nbsp; +/*
              <br>
              + * Same function and MQD description from
              amdgpu_ttm_gart_bind_gfx9_mqd,
              <br>
              + * except this is for MQD on VRAM BO and use dynamic
              alloc GART entries.
              <br>
              + */
              <br>
              +static void amdgpu_ttm_gart_bind_gfx9_mqd_vram(struct
              amdgpu_device *adev,
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_buffer_object *tbo,
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_mm_node *mm_node,
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t flags)
              <br>
              +{
              <br>
              +&nbsp;&nbsp;&nbsp; uint64_t total_pages;
              <br>
              +&nbsp;&nbsp;&nbsp; int num_xcc = max(1U, adev-&gt;gfx.num_xcc_per_xcp);
              <br>
              +&nbsp;&nbsp;&nbsp; uint64_t page_idx, pages_per_xcc;
              <br>
              +&nbsp;&nbsp;&nbsp; struct amdgpu_res_cursor cursor_gart;
              <br>
              +&nbsp;&nbsp;&nbsp; struct amdgpu_res_cursor cursor;
              <br>
              +&nbsp;&nbsp;&nbsp; uint64_t ctrl_flags = flags;
              <br>
              +&nbsp;&nbsp;&nbsp; int i;
              <br>
              +
              <br>
              +&nbsp;&nbsp;&nbsp; total_pages = tbo-&gt;base.size &gt;&gt; PAGE_SHIFT;
              <br>
              +
              <br>
              +&nbsp;&nbsp;&nbsp; amdgpu_gmc_get_vm_pte(adev, NULL, NULL,
              AMDGPU_VM_MTYPE_NC, &amp;ctrl_flags);
              <br>
              +
              <br>
              +&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWIP, 0) &gt;=
              IP_VERSION(9, 4, 3))
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_get_vm_pte(adev, NULL, NULL,
              AMDGPU_VM_MTYPE_RW, &amp;flags);
              <br>
              +
              <br>
              +&nbsp;&nbsp;&nbsp; pages_per_xcc = total_pages;
              <br>
              +&nbsp;&nbsp;&nbsp; do_div(pages_per_xcc, num_xcc);
              <br>
              +
              <br>
              +&nbsp;&nbsp;&nbsp; amdgpu_res_first(NULL, mm_node-&gt;start,
              total_pages, &amp;cursor_gart);
              <br>
            </blockquote>
            no need use cursor_gar. mm_node-&gt;start + n indicates
            where to update gart page table.
            <br>
          </blockquote>
          yes, that is the last version, change to use resource cursor
          for both gart entries and VRAM pages
          <br>
          <blockquote type="cite">
            <blockquote type="cite">+ amdgpu_res_first(tbo-&gt;resource,
              0, tbo-&gt;resource-&gt;size, &amp;cursor);
              <br>
              +
              <br>
              +&nbsp;&nbsp;&nbsp; for (i = 0, page_idx = 0; i &lt; num_xcc; i++,
              page_idx += pages_per_xcc) {
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 start_page;
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 npages, n;
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 pa;
              <br>
              +
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start_page = cursor_gart.start;
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pa = cursor.start +
              adev-&gt;vm_manager.vram_base_offset;
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n = 1;
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gart_map_vram_range(adev, pa, start_page,
              n,
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags, NULL);
              <br>
              +
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; npages = pages_per_xcc - 1;
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (npages) {
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_next(&amp;cursor_gart, n);
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_next(&amp;cursor, n * PAGE_SIZE);
              <br>
              +
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start_page = cursor_gart.start;
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pa = cursor.start +
              adev-&gt;vm_manager.vram_base_offset;
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n = min3(cursor.size / PAGE_SIZE,
              cursor_gart.size, npages);
              <br>
              +
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gart_map_vram_range(adev, pa,
              start_page, n,
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctrl_flags, NULL);
              <br>
              +
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; npages -= n;
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
              <br>
              +
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_next(&amp;cursor_gart, n);
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_next(&amp;cursor, n * PAGE_SIZE);
              <br>
              +&nbsp;&nbsp;&nbsp; }
              <br>
              +}
              <br>
              +
              <br>
              &nbsp; static void amdgpu_ttm_gart_bind(struct amdgpu_device
              *adev,
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_buffer_object *tbo,
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t flags)
              <br>
              @@ -1017,6 +1078,39 @@ int amdgpu_ttm_alloc_gart(struct
              ttm_buffer_object *bo)
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
              <br>
              &nbsp; }
              <br>
              &nbsp; +/*
              <br>
              + * amdgpu_ttm_alloc_gart_vram_bo - Bind VRAM pages to
              GART mapping
              <br>
              + *
              <br>
              + * call amdgpu_ttm_alloc_gart_entries to alloc GART
              dynamically
              <br>
              + */
              <br>
              +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_mm_node *mm_node,
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 *gpu_addr)
              <br>
              +{
              <br>
              +&nbsp;&nbsp;&nbsp; struct ttm_buffer_object *bo = &amp;abo-&gt;tbo;
              <br>
              +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
              amdgpu_ttm_adev(bo-&gt;bdev);
              <br>
              +&nbsp;&nbsp;&nbsp; uint64_t flags;
              <br>
              +&nbsp;&nbsp;&nbsp; int r;
              <br>
              +
              <br>
              +&nbsp;&nbsp;&nbsp; /* Only for valid VRAM bo resource */
              <br>
              +&nbsp;&nbsp;&nbsp; if
              (amdgpu_mem_type_to_domain(bo-&gt;resource-&gt;mem_type)
              !=
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_VRAM)
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
              <br>
              +
              <br>
              +&nbsp;&nbsp;&nbsp; r =
              amdgpu_gtt_mgr_alloc_entries(&amp;adev-&gt;mman.gtt_mgr,
              mm_node,
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_ngpu_pages(abo), 0);
              <br>
              +&nbsp;&nbsp;&nbsp; if (r)
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
              <br>
              +
              <br>
              +&nbsp;&nbsp;&nbsp; /* compute PTE flags for this buffer object */
              <br>
              +&nbsp;&nbsp;&nbsp; flags = amdgpu_ttm_tt_pte_flags(adev, NULL,
              bo-&gt;resource);
              <br>
              +&nbsp;&nbsp;&nbsp; amdgpu_ttm_gart_bind_gfx9_mqd_vram(adev, bo, mm_node,
              flags);
              <br>
              +&nbsp;&nbsp;&nbsp; amdgpu_gart_invalidate_tlb(adev);
              <br>
              +
              <br>
              +&nbsp;&nbsp;&nbsp; *gpu_addr = mm_node-&gt;start &lt;&lt; PAGE_SHIFT;
              <br>
              +&nbsp;&nbsp;&nbsp; return 0;
              <br>
              +}
              <br>
              +
              <br>
              &nbsp; /*
              <br>
              &nbsp;&nbsp; * amdgpu_ttm_recover_gart - Rebind GTT pages
              <br>
              &nbsp;&nbsp; *
              <br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
              <br>
              index 25640bed7dc9..9f07856433fd 100644
              <br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
              <br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
              <br>
              @@ -140,7 +140,6 @@ void amdgpu_vram_mgr_fini(struct
              amdgpu_device *adev);
              <br>
              &nbsp; &nbsp; bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource
              *mem);
              <br>
              &nbsp; void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
              <br>
              -
              <br>
              &nbsp; int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr
              *mgr,
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_mm_node *node,
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 num_pages,
              <br>
              @@ -191,6 +190,9 @@ int amdgpu_fill_buffer(struct
              amdgpu_ttm_buffer_entity *entity,
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 k_job_id);
              <br>
              &nbsp; &nbsp; int amdgpu_ttm_alloc_gart(struct ttm_buffer_object
              *bo);
              <br>
              +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_mm_node *mm_node,
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 *gpu_addr);
              <br>
              &nbsp; void amdgpu_ttm_recover_gart(struct ttm_buffer_object
              *tbo);
              <br>
              &nbsp; uint64_t amdgpu_ttm_domain_start(struct amdgpu_device
              *adev, uint32_t type);
              <br>
              &nbsp; diff --git
              a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
              b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
              <br>
              index f78b249e1a41..edb72f4ef82d 100644
              <br>
              --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
              <br>
              +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
              <br>
              @@ -225,6 +225,8 @@ void kfd_free_mqd_cp(struct
              mqd_manager *mm, void *mqd,
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_mem_obj *mqd_mem_obj)
              <br>
              &nbsp; {
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mqd_mem_obj-&gt;mem) {
              <br>
              +
              amdgpu_gtt_mgr_free_entries(&amp;mm-&gt;dev-&gt;adev-&gt;mman.gtt_mgr,
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mqd_mem_obj-&gt;mm_node);
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              amdgpu_amdkfd_free_kernel_mem(mm-&gt;dev-&gt;adev,
              &amp;mqd_mem_obj-&gt;mem);
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(mqd_mem_obj);
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {
              <br>
              diff --git
              a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
              b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
              <br>
              index 14123e1a9716..5828220056bd 100644
              <br>
              --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
              <br>
              +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
              <br>
              @@ -148,6 +148,15 @@ static struct kfd_mem_obj
              *allocate_mqd(struct kfd_node *node,
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(mqd_mem_obj);
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
              <br>
              +
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =
              amdgpu_ttm_alloc_gart_vram_bo(mqd_mem_obj-&gt;mem,
              <br>
              + &amp;mqd_mem_obj-&gt;mm_node,
              <br>
              + &amp;(mqd_mem_obj-&gt;gpu_addr));
              <br>
            </blockquote>
            <br>
            Here you create new drm_mm_node for gart page table entries.
            Before that amdgpu_amdkfd_alloc_kernel_mem also creates gart
            page table entries and drm_mm_node. Is there duplication or
            how do you handle the entries/drm_mm_node from
            amdgpu_amdkfd_alloc_kernel_mem?
            <br>
            <br>
          </blockquote>
          amdgpu_ttm_alloc_gart allocate GART entries for GTT domain
          only.
          <br>
        </blockquote>
        <br>
        Why still need keep GART entries for GTT domain if use vram bo
        through GART here?
        <br>
      </blockquote>
      If MQD allocated on VRAM, amdgpu_ttm_alloc_gart will not alloc
      GART entries because this check
      <br>
      <br>
      &nbsp;&nbsp;&nbsp; if (bo-&gt;resource-&gt;start != AMDGPU_BO_INVALID_OFFSET)
      <br>
      &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; return 0;
      <br>
      <br>
      bo-&gt;resource-&gt;start is&nbsp;AMDGPU_BO_INVALID_OFFSET only for GTT
      bo resource, VRAM bo-&gt;resource-&gt;start has valid value.&nbsp;<br>
    </blockquote>
    <p>Ok, thanks for pointing it. Then at&nbsp;<span style="white-space: pre-wrap">amdgpu_amdkfd_alloc_kernel_mem we do not need call amdgpu_ttm_alloc_gart for AMDGPU_GEM_DOMAIN_VRAM domain. That made me think a GART range/drm_mm_node is created.</span></p>
    <p>This using vram for MQD is not asic specific and use same logic.
      Can we make it a general method for all asic?</p>
    <p>Regards</p>
    <p>Xiaogang</p>
    <blockquote type="cite" cite="mid:03ff096c-87cb-4a11-9a14-155cd5b150b7@amd.com"><br>
      Regards,
      <br>
      Philip
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Regards
        <br>
        <br>
        Xiaogang
        <br>
        <br>
        <blockquote type="cite">
          <br>
          Regards,
          <br>
          Philip
          <br>
          <blockquote type="cite">
            <br>
            Regards
            <br>
            <br>
            Xiaogang
            <br>
            <br>
            <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval) {
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_free_kernel_mem(node-&gt;adev,
              &amp;(mqd_mem_obj-&gt;mem));
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(mqd_mem_obj);
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;
              <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval = kfd_gtt_sa_allocate(node, sizeof(struct
              v9_mqd),
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mqd_mem_obj);
              <br>
              diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
              b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
              <br>
              index 06cd675c9e74..55738b30c2ec 100644
              <br>
              --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
              <br>
              +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
              <br>
              @@ -253,6 +253,7 @@ struct kfd_mem_obj {
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t gpu_addr;
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *cpu_ptr;
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *mem;
              <br>
              +&nbsp;&nbsp;&nbsp; struct drm_mm_node mm_node;
              <br>
              &nbsp; };
              <br>
              &nbsp; &nbsp; struct kfd_vmid_info {
              <br>
            </blockquote>
          </blockquote>
          <br>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------ZsqQU4gGC1DU9EFogU7Pgr7Z--
