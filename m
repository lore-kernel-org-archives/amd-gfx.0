Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF85BC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Dec 2023 21:57:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44A9910E28B;
	Thu, 14 Dec 2023 21:57:46 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1211510E28B
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Dec 2023 21:57:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lG0KrMuCvGiWCqs65K9SlU5yv0zzbeHxuwjbtrSqhl/0st8osuxi6gj+emOtB+2k6L+zdIgrwMAFtYFUkIC8FWq1B7+G0/LZFLjLniSwx1U52b7ONtjpPEARj6P3qSQ7Naseehec961dEQlIQqB1BEIifJPzHb/Qpywa/NSN6BfAGHts91EN5AaZ2fa1LRmXNdEVV3xS/EA1YPvxILer6jYSTqEB1yqtDhtrk+LNQa3GuCFoyVds1kp2eSLGBl7hsWj+VfvQX2/wBG4SCMpNOCuiMwSzghzDf6jPhA17tKzvhL/ockMiAyLUSafCjLbs/PsmbErnSU4OIQZXYBZkJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYUaGYWZCPuCW9NahN7/L4s5A7J8EN/6O3pOWe5up1k=;
 b=c48nXBFNHL7kPCHmUFHKwJEtDY8c0aUqXoDrKF06Xth1RdlkUR3auow32wsI0j1hE5BiQBgStZXQOkwc1hEjMdiMK3TyxSBS9sw0ecX9QtdPBrBRpTqVnhklME56VOVD+0a9hANud0Npr6Ws4Xyw4TDBfgjaBMu3m9R0H9xgR//o9LKCfmdrhrLGWYPZ9Eye47mshdXhg8V4iWsbFCnJSZW9UlDwfzNq4YVmDaXbMg7meiVGOjXLyQyMuNNbWfKCUvf2aiXphuFoSXzrtOyCWCXF1ngx1TioEo+t+ix25NRoK2K1KSv+lwpMYemv9NVrZ+AqcjJbdH8+YNie8m2aow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYUaGYWZCPuCW9NahN7/L4s5A7J8EN/6O3pOWe5up1k=;
 b=aFjXXJxIplH2E3dIyv+O9j84OFFLxwxPClELHfPrTHO0Uv6l21Lgzx+3iGHbiECgTTTGuxgrGIBif73ua3vjnCn5LOnQZP08SBN/g0lkSnga+5RKHrgx5kNPz7m4rZjEbaQYG3rtzPfEsq3F0d2tpw7XTFaq6shLAjaucNwDEXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 21:57:39 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 21:57:39 +0000
Message-ID: <8eea46bf-99e9-46d1-87ae-649a5457e135@amd.com>
Date: Thu, 14 Dec 2023 16:57:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu: Auto-validate DMABuf imports in
 compute VMs
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231206214413.2440998-1-Felix.Kuehling@amd.com>
 <88e15819-885e-45f6-8f31-1df647383195@amd.com>
 <74c4c1ea-c621-46de-8810-eae7af5a360f@amd.com>
Organization: AMD Inc.
In-Reply-To: <74c4c1ea-c621-46de-8810-eae7af5a360f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0049.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY5PR12MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b775332-63df-4972-7e6b-08dbfcefb0c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wdHmVE45IMU5JrCPwsjNkf8FZwRhBRTbY1ZIpVPtaEPCsPJEf7AeDMk29kJAsICoq1p+ASSkb4EURTjdHRoMXyR6VcurwHxQIi61u45eeRDFNidl/6wXB5h2nkWHdyNtkdLtzOMdFy+KpjS/8Ap/xEQT+EFZm8ma0oZpIF7SccIN3PT+z4ge1aXLZYIRQf5bXax23hKmKG15KOkdwYT2cFZrSFH/shKU0uih53O2BlrPpbjhOLE4jYSfr290K4qapF9gz5XA01v3DVn4pkh+337gu89oW9jQV/RsiDTGluwhYBlbiDz0kG0+l9dhYJV0HsZKaORvs7cZ7xR0pggBo21PwLFRKRWm3M4C60N6EhRGq9ufxpiqePMZzUef7v6LG3eMb6uUO4MnIq0hUqzjiO4NaPNb19ILjeQ2lyujbdBX7uFE0j72zTmJPCxjVYjtDG3aGkQw5itcxp7EMJiY5Iipgrv4UkoEn86p2cKneRdwgzSXacnkdx8HbzQ0JmWLProQosGjGaEi16jcVXD6cJQsqzNL+3f17elYCSrzQVc3E5B4zeN9Z8fKL4l21tOKCaNOl1SIKiJ4MS/LwLK0Azu0kkyyQlJ6whVunRrTELi4mta+bJ7YGvho4PgVDYE6obVgFHYFEEPj/3gXVzj1Gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(376002)(366004)(136003)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(44832011)(5660300002)(15650500001)(478600001)(4001150100001)(2906002)(6512007)(6486002)(6506007)(36916002)(26005)(31696002)(2616005)(86362001)(36756003)(316002)(66556008)(31686004)(66476007)(4326008)(66946007)(8676002)(8936002)(41300700001)(83380400001)(53546011)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWc3N0pxa2JHeE1RUURuRUNKUkVQUmdPb2MrM3d2NDFORnBpanpyVXZ3clBG?=
 =?utf-8?B?anpVaGlBaFliVGFMZFQ4NG1rMWtaTkNnSVZ6NkwwZ091K0JrZm9xWUlPRHFl?=
 =?utf-8?B?L1g4VFUxQUEzaUZJUlpmTFZlZHF4OHJPRTdTNXhmVTlaa3Q2a2NJUzZUWE9h?=
 =?utf-8?B?OHpObTVPU0NNTE9uazRJeGhJSDlZM1ZKWkJPTVF6Rkg4cHpxSHhjTE1ZRlZX?=
 =?utf-8?B?dk1CMDZVd083QVdwMVV6MTFMSXhTTTNZWFZXVXVDQjFaOVBTUE0yNXVZREQ2?=
 =?utf-8?B?bGtqUjc3L3ozdkVraXJaZ2JOd3IzdWd1RHdtKzhsYW1Ubk0rbG9ZRTI4UlRN?=
 =?utf-8?B?NkZ1TmVFMDBJZXJCQVgydll2ODFGamFyKzZ6ZVZaY21TZU82d0s5UUI5Qmxr?=
 =?utf-8?B?NVJtMDVCaDRlYzN0eURhMVhEcVRvT2RFNTBkUDAwazJPQ0lqR2l3TnJGcDND?=
 =?utf-8?B?bU1vczRVZGJ3VEduT3duV0JFclZTdFlEbWRhYjM3RVRTZk1qRG5oMEcwRSsw?=
 =?utf-8?B?RTk1QUwrTXlkUzlqZkl2VEFTQnhMRVY5Nk1QalJ5NTF3ZjhWTkxvNUdNc0da?=
 =?utf-8?B?bTY1MTg5YWdIY0lmaXRzSkhrUUZxbmpNcGh0NENTTUQyN0oxVkVjNlFIYlMv?=
 =?utf-8?B?ZkdESWNzZVNpM0Q5c2wzZkU3eUFUVzlUTHpvMmo5ME9RREtTVnNsMjdiQkRG?=
 =?utf-8?B?alZQVy9VcnF3SDVGRDZJUE9QdjJVdGE5WVpyaUVxMExjSi9tOGNYZDhBWVYy?=
 =?utf-8?B?QjRTUDhab3N1NCtPTENrclpqN0xteWQ1VXZrUk9zaGdtTUpBMTB0T1RuVzE5?=
 =?utf-8?B?WnNCQ0JxcXlPV3VGTHdCRjVuWVltRjgyenZDbzE0RkJLM1BaZ1pLQ2pTWWkz?=
 =?utf-8?B?a0hTVFZRRGpEMzhZeWhrQUhFTncyMFI0WEpPQytxUGRpVk1YdGU1bndVTmlZ?=
 =?utf-8?B?VnMzSnNNamI3amtuSnRRYTFlT0llU1UxdVZEYW1weEFXdWFmVytxeUhwWVNw?=
 =?utf-8?B?eXR5VmFQVitzZVFDN3V4eHhyc2Q5d1UxK01YR040K2tQRWxiWGdMamkrVk5V?=
 =?utf-8?B?V3Z5bFBNUkt4MUJzUFgraUpBZDBKTjZHSXdHd3lsRlhUY0VRRC9YNFFMYUVD?=
 =?utf-8?B?anFsYmtxY2Jtby9zRFNEOGNGY0k5V2N4bFczZXdJMW9zZEhlNm1UT2lReHNw?=
 =?utf-8?B?Y1dtS0ZEL04vem1mVHpzbVlxMWZDY0NLVGIzMCsvTHd1ZTAvbEcveW91Umt2?=
 =?utf-8?B?WGVpU21BbFBDMHpRSUgreWpmTm1TNXY2dE0yRjNCdTZSbk5qN2p2MkV2MnZM?=
 =?utf-8?B?S0xmdEFmOERzUEhFV3ovUjVIM3dWREJYZ0RlblR3QVZIZEUxQWpzWURDdDNJ?=
 =?utf-8?B?cWh1OFFmRDZLVjU3RlQ5NndZUlh3OUJBcjQ0SlZyc3RZRjRrMWd1akMwdUJJ?=
 =?utf-8?B?OWhhNzIyeDBwa0ZLQVpKVEE0MGViOEc1ZlhGRXI0YXdXK2lvMDNNcS9rdHd3?=
 =?utf-8?B?dmpLQmZIMVNwZnRRdEY5d3l5cDlOU1VCNFJvbkFMSkVub0c0am01ZTgxM0Ur?=
 =?utf-8?B?NDUrTXdRcE5KY0xqaDlUVitUdytyQk4yTXQ4SitkV3RneHRodGtFUXo4bXJG?=
 =?utf-8?B?VXNuWTlnWjVHaEl4aFdWTWc5ai91bVArS1RrSVk2UEhQLy9yMzY3Nk5VRUhs?=
 =?utf-8?B?RmM3ZFhDeTBsVER6a2NMckd1aVF1SG1RNlNUTklhTzIraFJXMVNzYUVHWTZ6?=
 =?utf-8?B?b21DaGQzQ1l1bVVTaUhTQWk3M3NXczlzMmFjK3l1NXZQNG5vOWpJV3AwRmYv?=
 =?utf-8?B?Zi9sYmk5TFRkdGpBMHRZNmxINjlsTDlEZ1pRT2hCZithM3ZGekNVelBCTXhI?=
 =?utf-8?B?T1pGSlYrQitiMjZKeTJhdElScFhmb1lLR3dVcC9Hakc5c3pNNHF2cGkreGl6?=
 =?utf-8?B?a0RuR21rblU4VVBVY0ZQOTRKSkhyQWlhdS85SE5oTEozbklzWi9HYW1MbTJr?=
 =?utf-8?B?SjJNRFVIaWQzZVNBT05oeFYzUjJuMlVtNHpQWGlTdUpKckVmNzhPWkNzQmhW?=
 =?utf-8?B?aS8vTU1rZlk4UFIzcVNCZU83RkJRTTI5VTdKbUp3YkNEYWxLN1BOcEE1aUVJ?=
 =?utf-8?Q?RNB5UNwG1UuLv53oYjYNxW+aw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b775332-63df-4972-7e6b-08dbfcefb0c6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 21:57:39.7779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTwXdXJw61ZB4hTNRq+MnxH6vz9m4druPq7Ow+8rzqIiu2oFGZnSt77y9aAd4HHxsx6/r/ydYLUtAMpaXP1y1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6132
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
Cc: xiaogang.chen@amd.com, mukul.joshi@amd.com, ramesh.errabolu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-12-14 16:40, Felix Kuehling wrote:
>> Fence slot reservation should bet done by the caller and not here.
>
> The caller doesn't necessarily have the BO list to create all those 
> fences. The whole point of doing this in the VM code was, to use the 
> "BO lists" maintained by the VM state machine. Having to find all the 
> BOs in the caller to add these fences kind of defeats the purpose. 
> Then I can do the validation there too, and I don't need to do the 
> validation in the VM code at all.
>
> The idea here is, that I reserve the fence slots in amdgpu_vm_validate 
> and use the fence slots in amdgpu_vm_fence_imports. Conceptually, 
> amdgpu_vm_validate is where we enumerate and validate BOs before 
> command submission. This is a convenient place because I already 
> require that the BOs must be reserved. amdgpu_vm_fence_imports is 
> where we add the fences after command submission. At that point the 
> BOs are not reserved any more, and I cannot reserve them without 
> risking race conditions, because I'm holding the VM state spinlock.
>
OK, I rethought this. The imports share the reservation (and all the 
fences) with the exported BOs. If I have the exported BOs reserved and 
in a DRM exec context, I don't even need amdgpu_vm_fence_imports at all. 
So I don't need the extra fence slots either. I'll simplify this.

If I add support later for dynamically reserving imports of things that 
aren't in the drm_exec context yet, then I will need to add back code to 
reserve and add fences in the VM code again.

Regards,
   Felix

