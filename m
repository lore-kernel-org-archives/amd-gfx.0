Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1639C36008
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 13:58:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CF9A10E6D5;
	Wed, 26 Mar 2025 13:58:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="twbMeIwJ";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2064.outbound.protection.outlook.com [40.107.212.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4170510E6D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 13:58:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWGhNZOWoB2JZjj7KjZk6qXHnzuX3g/+e6cfW9S2mG0seL6Lv+wOIFQr7gM1mLtzXc4ATriTv+uaunMsk/f78aBopvD7uqoo4MCe3HjsSN1q/43mf4bE9wXIXzR6KnA8dTD/Q/UvMRfDUKOUnpo7YuPDHpMe91a8FOmuSl7OT9mSso8O6aq6Dy4zwmaeTXiq7DEj+esQIUZ4AtAeiWHM0C0JPvMkErnnA7qrJIaZj2YuM9xaqKBbOU1IyWEoMzNTyqKF0W1HQXa/F8ttrnNW5DyEaePNDRe5UP7qp/JVoTQcaWyjcRtCO2gKd0Kj403707H+E4GxFAr7HApI1BHG7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDFDcsmunReNm35XITUA4U/LMRMKJLVVEk0mUpQ23XA=;
 b=bjMvB6LlZpRDKT09U9Ozd4xbCMt+c/FEOZ/Wmq7roHu22pPZBIyZYWutDTnJjrNNGo+LawqfUDxFT3jxWV+qq3sju21lgGcbYbXj1l1tU4ukAg/F0FwIceLasLb5yth7LLSQJ8eq98vJ6rvgE+wmQ9m+2iD7T77E43StI6bdV2mx6Xxa9xdyCnVqbErlvkPG/4vGQYxamuV9KgA56QjU1jqjRmzKRuV65Yjib7khqFqvc2s0k8/8NVHyutjRVe/OL4oUIu5nKzPuVoZ05n8wFKrfV0mbmtNAEs0k5MdxS1CSanpzL5z4461xfjZEgRBt9ITCdC/q2Cma6yk+fWg9XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDFDcsmunReNm35XITUA4U/LMRMKJLVVEk0mUpQ23XA=;
 b=twbMeIwJJHrGuo0EV0jjftkS6Dft9AyYcNmowK4VRvb0ukNds/j9pf5HAWZj86wSWul48/ms6cK+UViR3ZrSY++wnSeriGIWTCzgbNa4l6vVM6WF7uwiLcMzYsRGEpfuZli15+0ZbgtBy/bStQmvO4dUfnCUpfgEQZ1QVPsn++Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB8322.namprd12.prod.outlook.com (2603:10b6:8:ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Wed, 26 Mar
 2025 13:58:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8511.026; Wed, 26 Mar 2025
 13:58:42 +0000
Message-ID: <740940f4-055b-483b-88b7-072907539167@amd.com>
Date: Wed, 26 Mar 2025 14:58:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix Manual Execution of Cleaner Shader in
 Gang Submissions
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250325152407.2543116-1-srinivasan.shanmugam@amd.com>
 <b30810ba-3e16-4f52-8b4a-070bda1bc129@amd.com>
 <CADnq5_PcPDULfTjtkWGXRVpuJ3Wc770Be3QjrxkRDsw1E-VUeQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_PcPDULfTjtkWGXRVpuJ3Wc770Be3QjrxkRDsw1E-VUeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: 7909b46d-e2a1-4f33-7a3e-08dd6c6e5102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDFXUjdLZmo3czhjMktrZ2xDbzNGdEtkY0prRkoveFZBbWpacklBdkNjMlZu?=
 =?utf-8?B?Zk5QaWkwV2xPekVnR2lJWXJCRnlpczEwNERMSm9oNTByWFcyZUsvTkh1Vmsr?=
 =?utf-8?B?Y0tiTmtpY2trRkVrZWN3Z1V2Y01BeTNGU3B2RjJkY096T2o2bXk3MXoyNFBE?=
 =?utf-8?B?aWJCVktjY0JkclRpM0FKdTRRUExWSTJscU8zYm16bzJRbDE3M3pXMDJadUx6?=
 =?utf-8?B?NTU3WFFVRHNwckRjbks5SnA0SzM3RG93NDRyWThxVDVWeVVQaENoYXFVQmZS?=
 =?utf-8?B?allYZ3AwR2UzcWUrNVdQMDdveVB0MFk4Nk1LV0RxbnNlcjlrNm1wWVVNellj?=
 =?utf-8?B?cWZFbGRyc0RsdzRrTEpCVDdSai9NTVNHVXpPNW16MzJzWWkzYy9GM2U3M21j?=
 =?utf-8?B?WGkzaUplSGgyQ1JJaXNBZ1lwZ3c0OW5iN0lrK3ZlUWkwSytGWlpwV0RzSUho?=
 =?utf-8?B?QmltenFoMmFITUVkczA5aitaZGp0VFRheGdaV2pGN3NKZjVTU2tFRWVsMGxr?=
 =?utf-8?B?S3EwOTZ4R1Rmbjd0NFVWTkQvbWsvaFRHcEdlSjVob1JZbHk5dkpBNkp4dGRC?=
 =?utf-8?B?Y05PenN6ZG1WTXZlK2o5UEErNVQwYUxycFBacGhERTBHd0d1a1N6eUNHQ0RQ?=
 =?utf-8?B?QW5kcVpSRDVFKy9NdnVwRDFoM1F2Z2dla2RWc3VrWHR6Ykh4OUVpNTNqUFJk?=
 =?utf-8?B?ZFNIaEJpNGVDMkU1WlBoamFhaExJazFvL0ZHWXhUMUZQNTVWRWxtcGdQa2dv?=
 =?utf-8?B?dTRHbXFJeVMySllqMWFMcnZnZXpJRUt0VjcwR2NVenplMklkaGpPRFNSUWt1?=
 =?utf-8?B?SVgvZEUyaGFXMm9QRjE2UE83SnRhUGQvU25jcGpIUGxGRVZ0dXFUT1RFaXQr?=
 =?utf-8?B?MlZTUEw1UnhnSmdYa1pIWkdxTHRFZG1TWldGaUx5SlJxQk80cCtCejBsNEpY?=
 =?utf-8?B?ejNRSW5NTi9LYXNUZzFRYW9EY0dLSzZ0aDNoRGJzVjhzR01HZjVmaW1OWGZV?=
 =?utf-8?B?T1hKQjNUWVp4MnVWeGNmMUxNMEhYQjhyWjU5NVA2YmhoZjVoNWdUdnNCNUZ0?=
 =?utf-8?B?T0IvUC9rMCtGWFJjZFVOcXZsL0pIc3BySGkvUS9xWjlPTTh0RUM3N0tsaDho?=
 =?utf-8?B?VlpFeENYSDgwY2x0Z3VGeVV3NDRxN3hwVGZlaW9kTDJzeGxBUjBMZlJnS0t3?=
 =?utf-8?B?NjBqVHhqck0yNVJKMUVvazdhOTlic3dNVFhkbUxFenkwWXVjT0JQV1ZmakUr?=
 =?utf-8?B?bmJUcUNUcFkrbUNHbnRYbHU3b0ZUUG54dHlwQVhJQ0Q1WU9STEtwUUNVNkpa?=
 =?utf-8?B?NDJCTTBkOGd1WTJSUDRhOGp4QlFaQlZxN0hyOXhHdCsvd0E0U1J4L0pBSExQ?=
 =?utf-8?B?QlQ1VzcyTGpBSThOclFRd211MlJ4azVaOW1sc2U0cTdieGVhNXk1L0tWZy9i?=
 =?utf-8?B?U3laWDdEdTR6SlRldzdKZ1NhK09qR0JjaVNlNkZKWGdOazFFczg3U1hBNXhB?=
 =?utf-8?B?U1d3bzltZlFnUXpiVW5JWGRORmMvblB0TjJuUm9ndDFuRWhZSjRselh5UGFq?=
 =?utf-8?B?VEErVGhkVG9uOEpWbkFzdDc4OXNzcGp1ZU9EWVlYZ3Vsb1o4YkZURmxOSmNO?=
 =?utf-8?B?V0cxL3FRZ1VOdnYxOXZhbzhqc3Jza2R6Y2RBb3JtRzlnSmhZdjRvVlB2Mk9J?=
 =?utf-8?B?aUpqczB1clAvakluM2ZIaUVSSEozbk5abG9lM20vNEdEVDhWdFljMjJRVW45?=
 =?utf-8?B?T3ZrcEp0SGowZUNMd0I1V0VzdEl3RmpXc3BzcE1ITnorTFZIbGtzRzBHejI0?=
 =?utf-8?B?TlVnZnpHak5vNEIvQ1JKcjhwMGZRNjlON0duTGFaV2h1MXU3R2M0Nk1qbDBJ?=
 =?utf-8?Q?mI03ReGrVlKMW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVZ2cVRkejdEazhWbHBxQ3Y1eDZONm5BdkplWDh0eSsxMGY4cDJoSnR6U0p5?=
 =?utf-8?B?YmdaaElwVEV6NUJUZzFlb1BvRkpzMlBzeUVjMWE4a21lbDFVZUdwa2JJYkJz?=
 =?utf-8?B?QlB4c2UyYS9FRHU3Vnhxa3I5UENzQVFZcmk2aEJzTVZjYW40ZjhJM1hXbEY4?=
 =?utf-8?B?a2ErMlEzM2k3b1liSWhhR2Q0V1dHbU9JWUs2SGJCaVZ4Zk5TRnM3eUR6MjRN?=
 =?utf-8?B?ZStET1hHZzcxSFZHc1ArL1NWOFZGTVFIeGNscDVselJPUnl2SzlSSGJRbE5z?=
 =?utf-8?B?UXFYa3RxQ1UxVVBtNzh1MDBndVZNeTVjT1MxOUhMTnlwK293T1FKbzBGcWV5?=
 =?utf-8?B?SWV6d050S2w0R1ZKTjlRSVh0OTZUTHEzOFd0bHlKLzBycnlnbWxpZGUwanpT?=
 =?utf-8?B?MS84Mnk5cW53SnlrNVZnaVVLNVFuZGkxakxXaWk5UGlXSzE4dW03NWtNNW1U?=
 =?utf-8?B?SFJFZU1GUFZVdGlEc3BuK2MraHJ0aFV2OHNBWk9iejNOQkRZQ25LS0xYUTA3?=
 =?utf-8?B?eUs1S3A1UkY1SEtsU2lYbWxZOVhDNmljUGMvOE5vbnA2MXhKdlMxMzBiL0dC?=
 =?utf-8?B?TjFHMGNKQndoQVozWHpkUmtoMmd0MnBwOHliVlhIZzk2Z3phWkhrQXM4T3hj?=
 =?utf-8?B?R21Ycy9yYnBYdkpNNUFxSnEvWG1DNXlwdy9xRHprMmdCQ3ROc09lQ1ZDVi9O?=
 =?utf-8?B?RW84VW9HdHBLMXBqRFNmdVZ0VnBMQ3dmOGJZeTgxMjlGRmdpdGtVWnQ1OHJU?=
 =?utf-8?B?bERheHMvRnR5ZW9vbnlxZllIL0lUUlJ6VHl3RVBkSXAxQTZwelVxTHk3TmZs?=
 =?utf-8?B?YTJxejVqRGVnTlA4Vk1vd0RYUG02ZWRXNTNySDJ4VFhKbmlKdk4xaWZKUm9K?=
 =?utf-8?B?YjRaaDM5TFpZMWFTdFQ3ak9YZExHNUFtaitWbTZCUzJzTjRKemFxVlJQTXlN?=
 =?utf-8?B?U3hDYUd1L2VjRXcwWDJiUjdOSERPV09QOFRrMWt5Y09GWEV4ZVM4RktFc0VN?=
 =?utf-8?B?Tk9LZ05VNHExbzhzdHRvKzNPMTRYaGdnN2NEQlZXVTJhc1d0elh6YjhnVzVm?=
 =?utf-8?B?ZXQ4azhxTnBIL3NEdW5OUlFvcTIyZ2lBdXhXVDFZVndoSFNpb3I3WS80U1du?=
 =?utf-8?B?U3h4UWlRUkpSOTlxK2E2bzVWTy93dnhlaVF3Q1J3S0F5bGk0YWhaT0EwQnpK?=
 =?utf-8?B?L3IrUGdFdDBxQjNCTUpEdmFUNUsrSXlTRHM2enArRTJOQUh4bjg5NzFsaUNZ?=
 =?utf-8?B?eFBwa0Qra3JFYU5qdUwwdUdiNXR0MDR1eXJ1MS9jQzlMbUozeG9Dbno4ZHBw?=
 =?utf-8?B?UVZnL0QzcVZtWWpWWG5IM3l2blJZdlB0TWhkVXBBZlhXcWRnbEF1R3RpTjBZ?=
 =?utf-8?B?RExaRmVMbXNOZnc3eFVPc3ZjT0JHVDRHbFZ6QjZwd21KWlVTWDBzalRwUDVW?=
 =?utf-8?B?R3RmczV6dFFzMTBTNEpDbHhLVXIzZG9aVVM3VExHbmVJTTVJb0pSZG9HMDRw?=
 =?utf-8?B?MlhCK21Qb3NjaXEvWUZTajRzZVF6M2x5QUVDT1F5bUsrcDdnQVFOL2JBVFo1?=
 =?utf-8?B?K2h0NnEwYVl6OFh3Y0YvdUl6Q2drU0hEUGVneFF1YldzWDI3a3dmNFg2bGNs?=
 =?utf-8?B?YzRoNkZvZG9ZeGJNYXZQTTRwQ0FjcWNuaGhXejFJQm1kejdNSko2VloxR1BV?=
 =?utf-8?B?WTFOQjI4OWJQUkRvK1dGS0RSYXJ4eVJjMkV6NWFKd1lkWndpQkExTTNBTVk2?=
 =?utf-8?B?VXFHZjNzQlJDa0VIZDhIZURlM2hjeUZDeTlpWFM0QmR0dGxSVWdXZW9ndVBv?=
 =?utf-8?B?enpoR1hzdHBORjZ6ODVRam5NQjVJV3ZUUTk0MDBHZnZtYWNUcGZsNlZnWEwx?=
 =?utf-8?B?WDhPTUY5NU5yUE9uY2FTVnA3aW1YcTN2MzVYMlF2S3BZT1pyU2ZSMlF2ZlRC?=
 =?utf-8?B?ZWZPWHNpck5OWVNEanVhSXBBL1gyZEUvV1dkT1NwMDljZFJqaWFtVkhiUmRw?=
 =?utf-8?B?T3NHZHpNdVVyNXE3NllWMGxRZFEyMUwwaUdhS2pMV05FcFhkZjh2Y05nRzV5?=
 =?utf-8?B?dEZLc2VJQ1JXOHllMWx0eDFBZDlwblRVM2VoSkVRd1VnK28wRlM2bFRVQVNu?=
 =?utf-8?Q?/SDp3cg0yXTOw42leoY2YRmLG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7909b46d-e2a1-4f33-7a3e-08dd6c6e5102
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 13:58:41.9306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eilv60EiOCxbfMzil/9obKM3MjBDWBhjnEvKJwaxJbbCMJuZ7rJOnj0NxEolENol
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8322
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

Am 26.03.25 um 14:55 schrieb Alex Deucher:
> On Wed, Mar 26, 2025 at 4:13 AM Christian König
> <christian.koenig@amd.com> wrote:
>> Am 25.03.25 um 16:24 schrieb Srinivasan Shanmugam:
>>> This commit addresses the issue where the cleaner shader was not
>>> correctly executed during gang submissions due to improper handling of
>>> the isolation spearhead.
>>>
>>> - Enhanced the `amdgpu_gfx_run_cleaner_shader_job` function to
>>>   initialize `isolation->spearhead` with the job's scheduled fence for
>>>   cleaner shader calls.
>>> - Updated the `amdgpu_vm_flush` function to properly initialize
>>>   `isolation->spearhead` to the job's scheduled fence when the cleaner
>>>   shader is required.
>>>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 ++++
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 4 +++-
>>>  2 files changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> index 72af5e5a894a..807f17093006 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> @@ -1436,6 +1436,7 @@ static ssize_t amdgpu_gfx_get_available_compute_partition(struct device *dev,
>>>  static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>>>  {
>>>       struct amdgpu_device *adev = ring->adev;
>>> +     struct amdgpu_isolation *isolation = &adev->isolation[ring->xcp_id];
>>>       struct drm_gpu_scheduler *sched = &ring->sched;
>>>       struct drm_sched_entity entity;
>>>       struct dma_fence *f;
>>> @@ -1464,6 +1465,9 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
>>>               ib->ptr[i] = ring->funcs->nop;
>>>       ib->length_dw = ring->funcs->align_mask + 1;
>>>
>>> +     if (job->base.s_fence)
>>> +             isolation->spearhead = dma_fence_get(&job->base.s_fence->scheduled);
>>> +
>> Apart from being very risky because of not grabbing locks that will leak the previous isolation->spearhead fence.
>>
>>>       f = amdgpu_job_submit(job);
>>>
>>>       r = dma_fence_wait(f, false);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index b5ddfcbbc9fc..e23400b53489 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -692,8 +692,10 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>>       if (need_pipe_sync)
>>>               amdgpu_ring_emit_pipeline_sync(ring);
>>>
>>> -     if (cleaner_shader_needed)
>>> +     if (cleaner_shader_needed) {
>>> +             isolation->spearhead = dma_fence_get(&job->base.s_fence->scheduled);
>> Same here.
>>
>> Over all this change doesn't seem to make much sense to me.
>>
>> Why exactly is isolation->spearhead not pointing to the dummy kernel job we submit?
> Does the owner check or gang_submit check in
> amdgpu_device_enforce_isolation() fail to set up the spearhead?

I'm currently debugging exactly that.

Good news is that I can reproduce the problem.

Regards,
Christian.

>
>  if (isolation->owner != owner) {
>                 if (!job->gang_submit) {
>                         dep = amdgpu_device_get_gang(adev);
>                         if (!dma_fence_is_signaled(dep))
>                                 goto out_return_dep;
>             dma_fence_put(dep);
>                 }
>
>
> Alex
>
>> Regards,
>> Christian.
>>
>>>               ring->funcs->emit_cleaner_shader(ring);
>>> +     }
>>>
>>>       if (vm_flush_needed) {
>>>               trace_amdgpu_vm_flush(ring, job->vmid, job->vm_pd_addr);

