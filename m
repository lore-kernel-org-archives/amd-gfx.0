Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A4C606D828
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tkqxIU/3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 053D110EF8E;
	Mon,  2 Nov 2026 15:12:52 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012059.outbound.protection.outlook.com [52.101.43.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE52F10EFAC
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 15:12:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4ZT7pg3psBt8apa1djg/LdC85yeouu9Yge2e2Bxb8Lz/Dk6CBZyohTU95D00EnQ9spGdw/QSwITEBm00obdpGs8QSnE1jgK3XrXJx/t15TwNGGWttN6AlgubzhYWOpZlQCblFs26DBOGmdBbsS3oznBU0oMIhJJhJipV8kfdd96sstYTiGLSB2U8UNMk8WEvQ3Hvb+ZOSx4w6PM+jlLNUhaYDXDBXa/GY66aQz03B1WVcdCu9OBdrbYZq5jx9qflN4YDk8xot8PuPkLsfrSpPI953igFAHNqDO8u9MA8MLojf1GBtj5nBh+imLV+gLfBTQRdCfH9R4NSRCX/ZewPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yu6bLab8QEX0TTerorCGvWhnaA8aWHZsatmHUbW62l4=;
 b=l3ze3mOdlqvl6IYvou85jUClJYwlWuytK36NzhLCtN+YE6jZz+c6UJXq8hBBGO73cdexJ66myohRNO8pUNnsZph03NUQa+Id6smgNqCsTqg27pphVaAto5zqWzO2E/oc3a/X5RemlWGgOpQZyHeqeYcsTqqdAJKOqDw9ZqL9ix9wsQe2nSIYSi0YVBMPjctT/dXiC41l6fjszHO7t7U4G7KSVPchl6ua6r5t7PY2fVNDtGPMxrcTArKGwNuPrRrwKAtCI7Hz4Joo3b/ljrgDfKkf85z6RjH8C2Bglp+aPcf4XMQRfZ3CbAwFGSjLX+FIq8Q00IDEx0dD9+2eG0KqQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yu6bLab8QEX0TTerorCGvWhnaA8aWHZsatmHUbW62l4=;
 b=tkqxIU/36hEndr1zlN8AanfcryuDR3ZAr20XhvWbgnPyhRO7HRNvh7kt8qCdRaMvP5+p9UV5kv8oPUsczDCklIrqRsMUdBBjXpX3ZvvsMjdRm46v+bXIJ7rrfWMEiG9BANOV0jcNk0XNIHyyrxnOUWl3Xn2MdVDFSZ3DVZxt50U=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by CH8PR12MB999205.namprd12.prod.outlook.com (2603:10b6:610:35a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 15:12:42 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 15:12:42 +0000
Message-ID: <99c5c0cf-fdd4-4bf1-a5fa-a51a8b09db37@amd.com>
Date: Mon, 2 Nov 2026 09:12:39 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] amdgpu: Navi 23 passthrough fails after ef5fcf2a6c32
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Nathan Blomquist <nblomquist@gmail.com>,
 Guangshuo Li <lgs201920130244@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, regressions@lists.linux.dev,
 alexander.deucher@amd.com, christian.koenig@amd.com
References: <CACOV87VBmya0PKjni5xEYxUaEczk9X_UoUHXSR_HDS2kSJnM2g@mail.gmail.com>
 <CADnq5_MzmNYq0WA5HFaOp6E3WO82YqTT5opCgkAbvv=9Q8AQnw@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_MzmNYq0WA5HFaOp6E3WO82YqTT5opCgkAbvv=9Q8AQnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P221CA0020.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::7) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|CH8PR12MB999205:EE_
X-MS-Office365-Filtering-Correlation-Id: fad12291-7be5-41d5-0900-08df38f3bde4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|10067099003|18002099003|22082099003|261102123227099003|56012099006|11063799006|4143699003|261022075727099003|261026140227099003|261022105027099003|261026121527099003|261009223027099003|261028144727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: TEh3/7sPVeH5uwnyF2VaHs7fXrtDuFf4slc78PWxJH1FPpfj36c4MkPUFgirXdN/edj17WGbQjK3H+cLv4Lo+UxwRZ/tHwdjtzLjU3ppWb6XKNL5Cwnk3rC+QtHEUmtx3g41B5QvdJdjaipO/2KhoG0J6C2/PyRRH8qWt220lBKucBMZdGAnW+GKKZCn4xX6P+CkhFW3vtVV09XsQz1t4hKhGB2f2BzIZX0FySJaBcOpg/1jWH5QJkKsYaeu66ALgu/oUCHlqN8kK/V+zdS85K4uN1tY6LHToVFlddY3S8Lf2GCahLmuAnDSO8eiXujRyCnCwIdV2OqIE/DVsEXOir/ynl0k7lQWcqawiL/m0Qn8L9Fa0kZsffpy7UkX/lXfxqnGNvGUCE5Q9KB0eMy+3CVK+VtX+irYmAt3CyAU/NMGuBhtOc0vXJ2aJvXIPaWuoCbYPaZB6nNvUymei2eoFANcUf35xSPxludi86P8t6Bnj+GL6aXQl0M6Gen41X5jWKzD7wSLKhXWgvfQt1ejyQr9IkOAeuQXcMdTicYYo9LgwHCdTJeT21zpMQBKJRDl/CxDsV3lv96AjIaic8V+sWH4HtXc2blsiGQNb35w6/Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9174.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(261102123227099003)(56012099006)(11063799006)(4143699003)(261022075727099003)(261026140227099003)(261022105027099003)(261026121527099003)(261009223027099003)(261028144727099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWZJa1NPc0w5aVoyVTdPang0UlE1V2tYak0zTy9LTFN6M2gzZjk2Zm92U3BT?=
 =?utf-8?B?dUxTUVN5bFI1a2ZzNmxDR3VuQnBwN2RRMEVwNmV6SEtCUnZoay8yY243bk84?=
 =?utf-8?B?R1N4L1Z5SE00SmxzNjF6Zkk1S2FCcUZuN1FJeWpBTldiT1F6UFptd3FoaTVJ?=
 =?utf-8?B?aEw0UEZzMi8zNGh0L2xXYytoZU1jS0dRZzJQeldxdXV6WHNxRlA3VllJZEFz?=
 =?utf-8?B?TVJML0gxa1lZMTNvcHMvdlU1MGFtTVR6STBnMm9QemxWd0VDRTJtRzlBUURJ?=
 =?utf-8?B?aHhYT3p2amlacHZsemM5ZEJ3Z3RPVzhyRDB5L1QveWRwajU3VmVMSHozYm50?=
 =?utf-8?B?QTZSZjhZSVU5N2RPMVlDaXZ5S05Ob0hjQTk4UjJJdEErakk3aThtbUtJclZv?=
 =?utf-8?B?Rmt0bmVlZ1d0RFlsSlQvdlduQmdza3NHemo3UjJJVjhybFB6UEg0SVc0d0xR?=
 =?utf-8?B?TlFjYndsUDVtODVGMFoxdEppS1lDTndlVEZoWGJrd2pmS3VvWWg5ZmFDRFRQ?=
 =?utf-8?B?MGJxNGxwYy9rbTdPQStzT0w4bVVYbnA1aVJFWVNqUk9RYUkybHlWTUUvU0RL?=
 =?utf-8?B?TzZ5U0RMQXZGQ3d0THRoOWRTaVU0VUxXeklNSmpDNVR3RmY5ejBBS2ZhbWNi?=
 =?utf-8?B?QlhYL0Q5RlZWSkYrR2ZoK2Q0S0ZjclhXMDF5MWxwYjRiQUlqSEZTSzI0RTl2?=
 =?utf-8?B?cS9POUZ3c3ArcVc2NlE5WTdjUnA0Yzd0eVBzcDd5anZ3RkVNd2UyaDY2UHhv?=
 =?utf-8?B?RzRpblRjVHhlTXFyanJKNFpiZnJjREd1QUZoUW9ET3ZkRndMZGVvamxZK2FB?=
 =?utf-8?B?N0JQUWFPb0NsZUdIeGo3TUhoTW83eDYyT25JLzJJVUZmTHJPZjZTVTJ1MzJG?=
 =?utf-8?B?a1RKaFV3elhhQnN4RFZrYlV1cWJ4Ujh6VURwWGpyUTZjRWRWYmt1K1o5aHRU?=
 =?utf-8?B?K3RPbE82T2REZkc5NUxhWWdxeDFGREphUTFtK3ZCYWpoUlo1TGhMdHhiVk9T?=
 =?utf-8?B?Qmw0dTNwdlc5K01HTlViV2dEVVFVZTVFaVp4ekR2ZlFGSnFFNnpUWW51TEpx?=
 =?utf-8?B?bzZkakZEZnJqODNvY2ovMUJiN0hiMnFjc2tPK2Y1cnkrNlJVS0dSY0VkQ3FV?=
 =?utf-8?B?UmZZVjU3U3BVS1Nod2FINTdrTWM2aVlhTitmV0pXSkRqVE1Hd3pwNWtsSjJw?=
 =?utf-8?B?SmYyenk4ZlJxZEl0OGRENUJqcitPU0VPNWpQdkNBRHVBdXlkUG1wQkZwWktO?=
 =?utf-8?B?dUdCWjQ3TVdvZGFROFhiWjVLbTJvMFphWVBqUzl2OGgzNmpuOEd0dHova2to?=
 =?utf-8?B?cHRyMzhsUXAvbk54YktkWVBxaXBhL2tuZk5EWTFTNDlRUlBzVXZpbHdTdlJ1?=
 =?utf-8?B?WEhId3loSWpCVGJFaDlhTUZOWjdFYzdKSzRMMU0zeXd0ek5hamhWc2FnU0J0?=
 =?utf-8?B?TkRsSnpYZXpEVjd3TWFMTFc3R05xdk5MN201Vm5YUDlwQndiaWtoVFFDdXBa?=
 =?utf-8?B?V2ZYNldyUFNQRkVLSmtxR2U4dmJTRGZhOWZLL2JwLzluZ2RpcFhVWVVxdVpn?=
 =?utf-8?B?NHowaG5rdHVTK2V2cFNZbFZzQldKYS8yaWVqUHlXSVVrajRqWjhzTlZoNCti?=
 =?utf-8?B?Q1VWbGFrekU1cXZ1YkZxTVpNa1lqd25rMFdOOVhGcklqNko1bnRrS3hhWEJS?=
 =?utf-8?B?K29JalRxTkJveWZJUWxvWllRZFlxSThZUUh1WUcxeTY2OFFvNFFvbjQ3QVdr?=
 =?utf-8?B?Z0QyMmozL20xY0FhT3dBYytuWWNqUGtGZTduT05YYXo3TGRjWjZKcGxlWGVy?=
 =?utf-8?B?SzBKSm9FYnJrK0VoaTlFdmVKdEFuZGUzM2RMMGIzY3ZCRzNCc0VsYUhmZWhE?=
 =?utf-8?B?Z3R3VUVRZTJkdmpiUDJTdUpTS1lPazJ4V29nN2pJL255MVk1bTFDeVNOSFBw?=
 =?utf-8?B?VE1naWZJNlhmM2dFL2pNWWhyNFc2VGlmMUhyY2tVK1JjM3lKRk12eWVuY21L?=
 =?utf-8?B?eWNPRjNYQVJzVnNOT0xUNzlCQTVYcCtQYU1XNFM4VzJNQlJYYUlLZy9pL2J2?=
 =?utf-8?B?U1Yxb3Y4ZDdvL0Q1UGhlMldpa1hYellKTDI5aFU3N3k2TVpYd0VTbGFLTEVz?=
 =?utf-8?B?ck5XWVF3dktUdU5paVBFdmx2bVFTL3JLK3diaWtvbm5rVUo4TnV1a2R5cyt2?=
 =?utf-8?B?K0IyQ0ZQdm9Gb3dYU2pGdDlHNlY3OVlBalpVR0tVeDFwaU13eUE4ZFp5VDBZ?=
 =?utf-8?B?R2N2NTF1Qk5YamNZelBxbGZDZytsUXhTTHVITE80REhNNzNPeW1wOXRtUnRv?=
 =?utf-8?B?Y1RKRHlkTTVOZURqMUdocklhY3BBUGliUmhrZWxuanVScUhaTUlQQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad12291-7be5-41d5-0900-08df38f3bde4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 15:12:42.5545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPPe/VWmXkoXWV8auXK1PkvDSzgKhR9z3Q8TZw1qVsgJKrFwERTdqgP8cbOUjCqSZYwcKQ7C/9iBgIiFELHoiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB999205
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/2/26 08:09, Alex Deucher wrote:
> On Mon, Nov 2, 2026 at 3:16 AM Nathan Blomquist <nblomquist@gmail.com> wrote:
>>
>> Hi,
>>
>> I can reproduce a Navi 23 / RX 6600 (1002:73ff) passthrough failure on
>> unmodified upstream Linux 7.2.10. It happens during the amdgpu-to-VFIO
>> handoff, before any guest code runs.
>>
>> Revert/add-back tests on Proxmox kernels isolate ef5fcf2a6c32
>> ("drm/amdgpu: fix autosuspend cleanup during removal") as the trigger.
>> Removing its added call from -20 works; adding it to working -19 fails.
>>
>> Tracing shows amdgpu_device_baco_exit() returning -ENOTSUPP (-524)
>> during runtime resume: the live BACO feature reports supported but
>> not enabled. The exit sequence is skipped, and a later bus reset
>> leaves both graphics and audio inaccessible.
> 
> Adding a few people.  I'm not quite sure I follow what's happening.
> Can you attach your kernel logs to the bug report?
> 
> Thanks,
> 
> Alex
> 

I think this need to trace a little bit deeper.  It sounds like it's 
likely an issue in the .supports_baco() callback for the ASIC.  These 
capabilities shouldn't be changing at runtime.

>>
>> The candidate below keeps the autosuspend cleanup and allows the exit
>> based on the selected runtime mode. In two clean baseline/candidate
>> build pairs on upstream 7.2.10, the baseline fails and the candidate
>> restores reset recovery and guest graphics/audio initialization.
>> Sustained rendering and repeated-reset stability are not yet tested.
>>
>> Is the selected runtime mode the right condition to use here?
>>
>> Full report:
>> https://gitlab.freedesktop.org/drm/amd/-/work_items/6076
>>
>> #regzbot introduced: ef5fcf2a6c320676bf8be2dadac93d9023b468b7
>>
>> Candidate patch:
>>
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -6412,8 +6412,16 @@
>>   {
>>          struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
>>          int ret = 0;
>> -
>> -       if (!amdgpu_device_supports_baco(adev))
>> +       bool runtime_baco = adev->in_runpm &&
>> +               (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO ||
>> +                adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO);
>> +
>> +       /*
>> +        * Runtime PM selected BACO while the device was active. Firmware can
>> +        * clear the live feature bit during D3, but the matching exit sequence
>> +        * must still run to restore the runtime D3 policy.
>> +        */
>> +       if (!runtime_baco && !amdgpu_device_supports_baco(adev))
>>                  return -ENOTSUPP;
>>
>>          ret = amdgpu_dpm_baco_exit(adev);
>>
>> Thanks,
>> Nathan

