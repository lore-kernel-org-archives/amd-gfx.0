Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0196C54F30
	for <amd-gfx@archiver.kernel.org>; Tue, 27 May 2025 12:23:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A1A210E49F;
	Tue, 27 May 2025 12:23:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BeIxSDN0";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF4FF10E3E3
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 May 2025 12:23:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mc7RtebnSa1Ir96RdCTk2SsclcPqB9rSdBunhoyaPgwV0l6PGqzUIWRPVt5ax0U834nR+Wt09V6yuF8Yl1TS26UOzKI1fRklEfccU/W/lLG1/VpXdZQwHp/JZn2zmgXMkCoDeEbd5F8wK588aKw2KU9HoYII1H6kws0hgGIYrME/9dts1Blm9fRzwuco3RbEluJKJe94c242Q/mgrwahVAJlK14qGeb4GVr/3BA9G0Y9Jqbc8tsKOqkbA4/AEBiKmMTvGIT/h/xUTVhOYuGU1bTBrqOZsorMVJaInrCnKtB+BhHrdLnpFoBoeXlXuG/sr5bjH4/EGhXImCgsqYCQng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAiZbnkNs8GlchgQKnYakn8gTI9ZNz794gjpRFUIvKU=;
 b=EmdE48SCdJofhMYUIxOdpCrHb+9bbyakfGI++JRReDMNa7JaWnDSlg8MF2v4/EUUm24HPVZ/Xcz7Wys98eQD4vYU7ch0ajOt6nngFYf6/YHO5cZIUMSTea8BxEqK2jSL+eBQZuvcXBBPA9Uxp8i51clNquQTdnBkgywxsPJhEk7tQ7xeisK6m5vpocRGM9A3NGlym7m1UXWUADTuKCLcot2JHbaYiXNy0JzX+uK1uYWb0tbGjP3uPCBx0n/XvCyvFrg9qTOSyJd1jD++IhZWaysLKMQp63GJaKtrvmx+icTACu5LACyOwlShvuxn5FX5+B1OZgq+gTjEN22OcZqFpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAiZbnkNs8GlchgQKnYakn8gTI9ZNz794gjpRFUIvKU=;
 b=BeIxSDN0idFVG3TDI1/IyzRd55BmV2fUDSupGO6VVIotm7QRWJDRET/FzSiYiPGKVdOU8LGGTnPzebSJDPJ9UrwgNH5gLuXQ4HDonjhsijVrxJpseEVxW2PtAhb/lU2aG3/S+IoZbJlsIPrd4grX10iR7atS9jVEvsZCeb1H6/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6177.namprd12.prod.outlook.com (2603:10b6:930:26::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Tue, 27 May
 2025 12:23:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Tue, 27 May 2025
 12:23:38 +0000
Message-ID: <626b28e9-275f-48e0-b209-9c3497f27249@amd.com>
Date: Tue, 27 May 2025 14:23:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amdgpu: promote the implicit sync to the
 dependent read fences"
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250527085814.3853953-1-sunil.khatri@amd.com>
 <6316cfc5-5b63-4a0b-b290-087c19f68790@amd.com>
 <BL1PR12MB5753D89DC58DD90E37F22D159364A@BL1PR12MB5753.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <BL1PR12MB5753D89DC58DD90E37F22D159364A@BL1PR12MB5753.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:207:3c::35) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: fda2b35f-f34c-4062-c6b2-08dd9d194f11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFJweHBpd0NZQTB3cEdNM3lkMTdlWFgyWG1nM254WXBVeXoxdyswVDNVTDE3?=
 =?utf-8?B?TkxISTlaTmxCbzFPM3ZOb3YyZjcyanpPYmFCSTVUaklEMlByNkpHcmxoNGRG?=
 =?utf-8?B?U2VYc20rTlZ0MndEck0yRWdhbENpbmJUMnFBYWFnUmFtRnJQYWp2N1VvbFNl?=
 =?utf-8?B?aFN0alJHazkwME9nSDZsQ2FWODIxb2RBVERXcUtMMnM2QWlZRWlsNmQ2Qjds?=
 =?utf-8?B?R2xEekYyOFM1aDdWSVgvbUxGYXFiQ3VIRER5SnlkNVRkV245NWJndkJyOGp5?=
 =?utf-8?B?SE1Jb3l3VVpJclljbjJsMERMb2dnZEQvaVZVQTZaU0VBTVAxOHNTNlBaaExp?=
 =?utf-8?B?K3hRMlpFMWpkdUsxMDQraWFLMFFxN3FlUHFzNlhGcTYwNUVSUEUxdUh4ek5j?=
 =?utf-8?B?MnJqWm9zMDAxUUd3WUoxQWcvSytEZzdaVFNUeGhUSUhEQUNucVI5clFFOW13?=
 =?utf-8?B?WnYyK2lUdzZVeXhIQm1TcUZpb0VKSll6d3p6Tzhpc1ZnYldIdjQ1Z29Jc0Ev?=
 =?utf-8?B?dmFiNDNaREMwVzRoblR6cW5ESnVMYlhVekhQakdDQXlBeG1oeXEwUGtPWTcy?=
 =?utf-8?B?dElpa1hXWmNZWG8zZHROSWtLS1R6UjNBZnRoYmdiS21yVjNBZmpyUXh3NENE?=
 =?utf-8?B?R29yb2xQMFU5YVQ2YU9NeURyZUc4ZmVyNC9SOVJ0TkoyakVraTRMWkI0andu?=
 =?utf-8?B?VlBqazJoMnZPUFRWVnI3ODIvc1pVSmFtOWc5cU5HV3FGMDQxcW03bUtxeDlD?=
 =?utf-8?B?LzlCTFl3VnluL2UvRGFwd3F6M2FoM2p1ZHo3Wm5tWkZPVmN5VnR0bEFKbklw?=
 =?utf-8?B?L3dyM2Y0azlmSUI2UHlpR1Y2amM1anFvOFUxRE1NVk9wR3lXNERMak5EdlR3?=
 =?utf-8?B?MWg1bDhoQVNrT0F2Nis0L0p4SW1wdjJZSCtJS3U1WGhhM3AxTGVwSU5JVHIx?=
 =?utf-8?B?WlZvcHFUUmxuZjlXV1VXQ1dFbXk2NWQ1Y0RoOVpEcEViM1IwMStBTWVCMlBT?=
 =?utf-8?B?bWQ5bDlhZHc5ZEIyVWd2WTRaVFBhQjRoN1BaMmZMaUhCNDF0MERtTUdqTjBF?=
 =?utf-8?B?WXVlVUgwSmgvQ1BHdUt3a0VLRzRpYnJPZC9NeEJ5TnFHSHRNSmQzZFRtNXVx?=
 =?utf-8?B?cVQ0ODJ5MjR4ZENuSWlLZ1ovWEdQbG5TQStqVEN1bU40bGk0K3lmanAxRTVU?=
 =?utf-8?B?NGFiVXVDdDlmMHF3dzhSQS9Ebmk1cjJPNVVDUmZvVjEwRjJ0QWxjT3RSbkVC?=
 =?utf-8?B?ZDZKbE83Y09sOGlYRkI3WEgvNVJPUGZwQndPdlZTRUE2Y3J4RHZ5UnZSUmF4?=
 =?utf-8?B?c0ZsaTlqODIzL0RwQVk0bU5ONlFpaXAyWEs4V2wvM28zV3R1S3Ewa1EvRUZp?=
 =?utf-8?B?RXNFSmt6YjVZNWJ4eWlTd1ZDeDVMTDRrYks4VnpJS29jaFZzZmxJVTFVMlVY?=
 =?utf-8?B?K0NMcm1vZmZGakJQS3d0Sm1pR2lYSGVRcDJYZm1YeUV2cW8vNXFBdkpFUit5?=
 =?utf-8?B?aTVRSXJZb0lOTkxLK0M5c2M1TGpvZmhnT0pHQ2Y3UG8vR1p2eGNzUjRsVlo4?=
 =?utf-8?B?ZlNZdXZqYzhVSk5RMjB1VlJEYTZEdUV0RnpvM0xqRnE0OFhUMExZOFNMSHFJ?=
 =?utf-8?B?dTdiU3M0ODhESEt5OEErc3lES2xZSC9idjNabUk2ZjJ0SENJY3g2c3Y4dEhY?=
 =?utf-8?B?R3ROdzMzdEMwQXBNQ2VmTkJ4K1hCalFkUFAvT0NnbUEveTI2VFB0NldUa2Rh?=
 =?utf-8?B?SXZqWnRERzZkUTFjWStLN0hXcll1Uk5Qa0xac2ZpdmlVVjJuRXJGVElld0hr?=
 =?utf-8?B?NjI3MTBscEZMbStJbndEczVBL01ubWpIeGQ4Q0hyVmNtL1QxR1hyQldsaVhw?=
 =?utf-8?B?VTZIUms2NWFqZXJ1QzNRTG11ZEJVVTlEYThOQ0FRS0gzWVNzejFZZ0czdG9H?=
 =?utf-8?Q?ENrxfkTlTyY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekdwK2ZERTJQUHFNT01qUy94V1JaUUJLVTIwK0VGRmdiZnZ6UzVlem81Y1Z5?=
 =?utf-8?B?K3h4MWowY3AzZUU2bkFwS2hpREhrSEtnNUJPRU1JYjVKS1JkUTdNSFJNL054?=
 =?utf-8?B?ak1SMUk4RThVdUxxeG1wVHVFa2dUZkluYmozSWxMNFRmZk1YQkdqS3VxVFh6?=
 =?utf-8?B?cGUvR203dU1td2NHMUNFZmJqTjEzZ0l4cE1BWm5Mbm12MlE5cGJrK0oyckNo?=
 =?utf-8?B?czJ2WGVnNEJGcTZCeU96K1N3NzlZNnVsZDJDQ1ZsWEorWmplWmYxejg3VmRU?=
 =?utf-8?B?WW8vbjhiZEJVbng1c094dEVnSVpVbXR3OWlwS3dTd1liTTgxZnVuOHFkY0ll?=
 =?utf-8?B?Wm40bGRoWk5DN0dxamRkRDcyZEtwRldOWXFBVmxEdGkyN0ZlUUE5OFBIRDF0?=
 =?utf-8?B?NzI5REJEd1dqenFyWFRrWm5HVFdvSmNNTkNydUlLNXgyT05aNFc4bStTaEZB?=
 =?utf-8?B?ZktwWjBWTFhCS3Q1dmlERVl4U0dUNVI0c1E3OG5VWEdDZThkMEdaTnl6ZzRH?=
 =?utf-8?B?TWVTQ0xtTldXandCNXh3U2tLQ1lkdDdKVnZPUjVBazBXOXJnZXpONGRkb2oz?=
 =?utf-8?B?UWhpdWg2QUFsMlRZMWtOVFdMQWZRY1pYZEE4ME9FbVdUbGRhbENFUlpoVlFK?=
 =?utf-8?B?d3JZdHltcXhqTGF1OEhYN2wzN2twLzFGS3lyakNRRjVha1hoMGVrRUt0MlRk?=
 =?utf-8?B?SysxNGNHbUtWZVJLR3pLanVFYWNYWFhjSDdoSUdtaFpEd0YrbjMxcWtuNHFU?=
 =?utf-8?B?eUdYbENoTDQ1R1huQ2tNamhVd24wTmRNa3krRE5oY2loR1E4SDl0YWU5bm9E?=
 =?utf-8?B?VUdQbzU3MVBwQkx6RTk2WlY1b2cvQm41aXRnZDI2Qmt3Sk9hbjZJWTRYYll2?=
 =?utf-8?B?aDFpVGgxNStSUTFGYkw2RWZxS0xWcFVyNytrTDlCeitSWFQ3aHNwYzhqMUZG?=
 =?utf-8?B?bWI3TlNpMmpEdmxsTVM1OFJKa2tQbXJxTGNPanl4RTlqK2pMWFhHbS9IUzhz?=
 =?utf-8?B?VTJuOTlBYkJtbTNNalRJa2E5NVAzMnh5WjdIZnFrUncwWTI2SEtRaHJTdDlR?=
 =?utf-8?B?M0ozVURUTTZneE40NU9vcDJ6MTRiMUhFMGY1T1JwblIwenRaekVGUzcvUUxV?=
 =?utf-8?B?MzdBaVliWEZHYzNJWmJacTkxWDU5WTJMUDVEaThqeUVJQjk2dmNwbEpBVThE?=
 =?utf-8?B?K1ZyOThLRFRUWXhKb29BS085bDlNbVVNRG1oZlBEcTUvS3dDbWtVNzRlWUh4?=
 =?utf-8?B?NzlHSkdRM01oV1RTRGRCdHZEbU5kYTdrL3AwQkR2emxRclQxMkpzcS93Z3hz?=
 =?utf-8?B?QUlRak9EUzJxdFc0WEpTL0cvL0Z2dndCVHZYSXBiWXhiVEEvazNqbmdiVlRO?=
 =?utf-8?B?RkwxakdpK0hNbmhJWTE1NE9jQlJOWFdXcExoSWV0MUdqSy9xYTlvbnZJeGIw?=
 =?utf-8?B?WW10MnBreUlqS3E2RTBIdVkwZitmL2NOenhlaG1IR0p6SmpoUTZCdHlmeGxz?=
 =?utf-8?B?U0JWVGxORmF5aEdPdHJyK21UL0FPSTBaR0N1QzFoUzVuMlF1b2g4SXBRNGh4?=
 =?utf-8?B?bVV4NnBDc0xhTm5oZGtkVzVObVVBVDVYOHRkdlZmYTV0Z3V4SjNkUlFnNXoz?=
 =?utf-8?B?cDAxMXcybGpJdnlqWlBxZTdYZEhySVJVSllYb0pzdnNwaFlreUtOSmNqUEhP?=
 =?utf-8?B?cU83TUxtelRleEtRNjJ0VWNPcVJMdGpYNEV2Y2lrODM5T0ZwL0NDRGdoT1VM?=
 =?utf-8?B?dmZ1bXFDK2xVeXFnbExEZGhxaHpRdDdkK2p0MEpzWmo1cnlFeGhnZEU5OE9S?=
 =?utf-8?B?VnZ0OVVFUGpQVnhjZ29oZTljTmJmTE5WdVBaY0xsYlprdkxlMGVrbVFNbUZ0?=
 =?utf-8?B?UUNFNjlHaFpqYXZ6ZG1xYVdTK0dUN3RMVWJGMy9oS3JaZkZscHZ2VEc3MVB6?=
 =?utf-8?B?TGpsWDhmaEhFREJFZjVzNk9yQjBMbWpDNU5hRGxlM0VHZXh1M2VSeDBCb2Qv?=
 =?utf-8?B?akMrZzNhMWRnK2NwRlM5UXpDMXRhc3MwbktoTWZQdHdQMVRxYWd1djE1djIy?=
 =?utf-8?B?L0JWblJvUmFFYVgwc1pQS01SSlZNbGk1ZEdsZnlYeDdQUlRFK3ZEdHRjSzVx?=
 =?utf-8?Q?fWwU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda2b35f-f34c-4062-c6b2-08dd9d194f11
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 12:23:38.4591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XY6ZlPy9CNej74jO3Ri583YERf09VrXhfOwu3Nq4ufL5ZwcTBb4oJiD9P1pd8eAf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6177
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

On 5/27/25 13:27, Khatri, Sunil wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Tuesday, May 27, 2025 2:32 PM
> To: Khatri, Sunil <Sunil.Khatri@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] Revert "drm/amdgpu: promote the implicit sync to the dependent read fences"
> 
> On 5/27/25 10:58, Sunil Khatri wrote:
>> This reverts commit 714bbbf20a7266e48632fab466563e695af9acb5.
>> bisected to this change which is causing the flikering issue in the UI
>> for various apps like glxgears and unigen heaven.
> 
> Is that flickering also there when using kernel queues?
> 
> If not then without an explanation where that flickering is coming from for user queues I have to reject that.
> 
> There is more to just flickering here. We are planning to use amdgpu.user_queue=1 in our CI testing.  That means both kernel and user submission are enabled. When I ran the testing amdgpu_basic tests which runs both kernel and user submissions, all the user queue tests are consistently failing. With this revert change in place all those issues are fixed, Both user and kernel queue tests pass consistently without any artifacts.

That sounds like we are missing some dependency and that works only by coincident.

> The reason of why this is helping is I am not sure of but it’s the observation which was observed earlier by Arvind too. We could investigate the probable reason of it infact Arvind is checking that but to enable CI we could revert this if you agree.

I think figuring out what is missing here is more important than enabling CI.

We most likely incorrectly sync to TLB flush fences on the kernel queues now and that could not only have negative performance side effects but also hide real bugs we need to fix ASAP.

Regards,
Christian.

> 
> Regards
> Sunil Khatri
> 
> It seems to be the right thing TODO and we are still in the process of hammering out all the bugs for user queues.
> 
> Regards,
> Christian.
> 
>> Also when we set user_queue=1, which enable both user and kernel
>> submissions the userqueue tests in IGT also fail.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>> index d6ae9974c952..5576ed0b508f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>> @@ -249,8 +249,9 @@ int amdgpu_sync_resv(struct amdgpu_device *adev,
>> struct amdgpu_sync *sync,
>>
>>       if (resv == NULL)
>>               return -EINVAL;
>> -     /* Implicitly sync only to KERNEL, WRITE and READ */
>> -     dma_resv_for_each_fence(&cursor, resv, DMA_RESV_USAGE_READ, f) {
>> +
>> +     /* TODO: Use DMA_RESV_USAGE_READ here */
>> +     dma_resv_for_each_fence(&cursor, resv, DMA_RESV_USAGE_BOOKKEEP, f) {
>>               dma_fence_chain_for_each(f, f) {
>>                       struct dma_fence *tmp = dma_fence_chain_contained(f);
>>
> 

