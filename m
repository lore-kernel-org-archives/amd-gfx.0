Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DF3C27C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 10:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6977189A88;
	Wed, 26 Jun 2024 10:54:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gr9vHJ9b";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0488A89A88
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 10:54:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gro/e0op2DbOfNF53pzy6a/Ks7GJMaXN26QqeChkdWe0eiSAIyXOaklDRu/Q95IZmyvpPBv9ZcL6Jt+33XJhTs7bR65TJcDhGlzPdjJzgR/Y6MFaZJ1j9Ui7PpSCpKYlb5h/zoa7XigJRJPoCreKvZrmZ5WUUV/oKBtYQ3OYlVTq4uBkowkCXxoF+a46kksHcIdQaxoV9mild9WeVi1dbfk3PfldE6pAzPaEFrWUJg3yaE7p83bIHNcHdIJwN6jmskjQ1ib8XGsAMZzt0NBS2ohJaBfLF/TbF5pSDJhSUo8vabAbh+JNqBdC2wUKSI2zYnx9PBUX6SxSAaVvXEy32Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DOaohE6Ci2P2t7/xmuFEcrIQwRRVrERZQdq4n8hjcg=;
 b=JL6VmOv4iSWdM83zNI400fCX9kCt6wHziQhC15LdhXktPrvCTUULCIP2SxZtfeQFFuobDkUCU83xjviGiQJH0GF50/xEd2QztIlHUtm7/mwqtxn6FsQRPiLaDpKf8PG0rZPxOtwpfP2zJdZtwU+drW95UDC/Mmqtuz2nIR0FwgdikLD+pn6e5jAOw3G1SkJcaL0dKW/u3d4mtLz0YwTJ1vzkTaeKcq2ehG0igD+a32nilPvPnaR0KjRdBspxFlqBoZgodf73RyqtGr3P6NVSLj75nEBNg9QqAhMOOLFCT1D8rbzSI2RSEZy2/PFV3p/8f/I/mz8KtqZiuykEuexNEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DOaohE6Ci2P2t7/xmuFEcrIQwRRVrERZQdq4n8hjcg=;
 b=Gr9vHJ9bMGYCeJUR8s1LKlcT8NhrJB4pNhwLJOhjtLqO6IgYBdjzritea43M0mCC9vGYas9g0aTly7sNrd+Wd09Tk3ay+r0KCc91qlLL+Cey9quUxP/LKxYkmHKOLQKoxfdcSYSKx33OOY3T50kbXSUsfEDCWTzsBhOWGKEZk+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW6PR12MB8661.namprd12.prod.outlook.com (2603:10b6:303:23f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 10:54:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 10:54:26 +0000
Message-ID: <e18a1ebd-1c19-4dd0-aa59-1e6dee593db1@amd.com>
Date: Wed, 26 Jun 2024 12:54:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/radeon: check bo_va->bo is non-NULL before using it
To: Alex Deucher <alexdeucher@gmail.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 alexander.deucher@amd.com
References: <20240625142418.156810-1-pierre-eric.pelloux-prayer@amd.com>
 <CADnq5_N+ofUFOWhDvKkWSy2zXYMHaHHD0m63hAPLs4EG6mTVzw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_N+ofUFOWhDvKkWSy2zXYMHaHHD0m63hAPLs4EG6mTVzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW6PR12MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e71bd62-53e1-4b31-ed78-08dc95ce58e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|376012|366014|1800799022;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzJSeHNWb0E4d3J5bTZlWDBqa0tSZGdjRloyMjJVQVF6TDNkbjZVeGhTRW9R?=
 =?utf-8?B?Y3hqUVlRd1kzSnhNU3BPcGNTQkQwOEYvcm0ydlJwY09BM1V3T1NNZEFWeVpU?=
 =?utf-8?B?VXk3MnM5aFF5WkFZUzhueVcyTjZzeVJsb1pYcVdYYmtqUFNvWWRtdTBabzZ6?=
 =?utf-8?B?YVBEMFhraXUvWmIxRDNzT1FsS2t3bzJuclhCbXhlc25JRk9aREQ1WnBhMTho?=
 =?utf-8?B?NGd1bUhERTF2c01aYk8rM25BcmFZVXAvVUNrUnFVY0lxYmFxMXZwOGxteTl2?=
 =?utf-8?B?R1VseXUvWE5QN2xvLzZEMG5PcE0rVktMN3dWMXdiWmFzWUJud1ZuSUIxN0o1?=
 =?utf-8?B?QjdIZmJzY1hrOU92K1lkaDFNK291UFpzWUJvVEt1azFRU0FVY3hjVUZCeUxO?=
 =?utf-8?B?VlNlUTJ5bG9pZlRGaVBNZXc3SzIxZk5OUmpFUEV5OTd2MTc2c044TjhXR0dp?=
 =?utf-8?B?azloeFFZMVI1YTFsTGovVGdiQVQySlovTFROQkF6cVYxcCtRSUtNYUEvNVBt?=
 =?utf-8?B?NEVNZlFCd0tVOXRmYjJJT3kwM1QzRHB3eFgzbXNkVjQ5S01EL0NHeXhpekNI?=
 =?utf-8?B?dWVYMDdNV3RXNkZ4aXdHN2IreTBFOE1KaVpRbVFIdjRKQWphNis5ZHVFMjkr?=
 =?utf-8?B?T0dnSzZqSEtzQmlTdDRDWnpXQkdEbzErRWNmZGhoaENEYWhMWU05Ykd0endr?=
 =?utf-8?B?VHpRUDR2Q1h2b1pXV0Y3Q1VkaXc3QUpKbVRpS3FqakVMaCtyczZLUVI3aTdy?=
 =?utf-8?B?U2RyWlZaUUFPdFVDK0ZmREMyRmxCYWhuM1RHdGl0R0tCVGg2dFNuMSthOGM1?=
 =?utf-8?B?b1ZaSVg0djcvQnhvNm9neW8zOEpLYXFmMUJXa2JmcStKNEZrNlgyTXVpQk1K?=
 =?utf-8?B?YzVtamxTNnJ0L25FOEFIOGtKUDZicENUc0grVUF6cHB0YUFsMzcremN5TzhD?=
 =?utf-8?B?MWR0YWVTQ2dRdjA3Uko1aGNBeDRlSTFTZ2M3NVh4d1lQOFpXbmJhQkN2TnUr?=
 =?utf-8?B?bm5oZ1pnRllyMGc4R0VOeUIrTnhESlpWM1ZxNEZuSStOT1hLblV6SkhScWxv?=
 =?utf-8?B?OHR6QUhpU3V2cXBaeFlRcUgxVUEzVkNXRnlMZUcxYzQrYUNHYzQ1YzVGN3Az?=
 =?utf-8?B?Y2IyZEJ1T1JhMGJKcTAxRG8zb1A0emxSK1VyTXNjb1h5M1FQZzZtUGFxeHcx?=
 =?utf-8?B?bHJ0dG91eWlOSVlyY2lnRnNlNTdwN0doQVRsQVA4SHNySGMwZ3FLOFVTdm5w?=
 =?utf-8?B?THY2QURlRXdDOHdyWTR0K2ZaQ1lkUTg2ZXdLcVVnSEozNVJaL0t2dHJaYVpY?=
 =?utf-8?B?TldUb3JOQ2J0N0R5QmZLOUVzek9PMVJzTnQxdzRpOHFERldFRU9ad0pyclQx?=
 =?utf-8?B?Skp6VlFOTmlZMVZpaTREcStpRzFQcmhnZ3ZKY3BRaFRLcnlucXEzeXpwOGtG?=
 =?utf-8?B?bE1wUlNUTEd1cGxRMTRqZGorWEMweVlkNm4vV1RubWxOZE8wZFhRUDBOMTlz?=
 =?utf-8?B?d2tBZWtTNmtQOXJnUDlpMkw0aEN6VWU5VHZjTUg4RkY5Mm8yQVlDYjg2Q0F2?=
 =?utf-8?B?dGkrTUEwcEJEaVBDcEc3dWcrNG1aMWRkVGdGeUtTU2ZkSCtiRWtPQWVRcWRY?=
 =?utf-8?B?czRqT2lWK0NzSWdJY3lPM28wZmUzZEdRcVVKMFdDcFpRbzlPSDBmVzNNSXhL?=
 =?utf-8?B?L0xzNUNHbHg0WU84Q0FxVHNXb1N1bE9jTDN3ZldKaUJMT3FXZ2JqNCtvOEY3?=
 =?utf-8?Q?EpfQEz6v+trPVvxPMVTYXwnngLCxkWufZIe106J?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230038)(376012)(366014)(1800799022); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3VVOEpsNC91Y2xyQnNCWmJHV0hsckRjNzdVbVFiTERtSGo5NkJ3TTQyMlZ0?=
 =?utf-8?B?bnRQZitNV2lRTFJzaWQvbU1ZTkwwZjhicVNHZVNZQWFjNnpMbkY4dVY1aU1Q?=
 =?utf-8?B?a0ZPTnByTmxBNExKaXYxa0o3VW1WYmdTNXVXN2lOZndISlZZUVpsczhxenlX?=
 =?utf-8?B?L2I4ZkNVcjhLMVlNTTVOT21BWG5aZWFtU1pzdEYrd2NHWm51WDV4eFk3dlZ3?=
 =?utf-8?B?Qm0vWDNTNTNqbVVlT01KYWN6K2hGSXlLem9zT2dLRHI0OFl2dms3VXZlY01K?=
 =?utf-8?B?UG1pVk1Wa2xxU09wOVRQMDM3WkNSTXVqUnR6dnAyVGQ5NURaSmExbzdkVm5O?=
 =?utf-8?B?TFNaZWhNYklRLy9hMjQzcDRaUGNEWThvK2tCeWpwY0g1UGFaWVA0SUs5Qmpx?=
 =?utf-8?B?cU5ycks3djh2UTlyUWJPa3VFNFpKVHJsOThrajh6NVptSitTS2tHNlpiSVBY?=
 =?utf-8?B?ZHI1VjJ6d3B2Mmc2RU02QkNKSndCUHVSWlFPbndPN3l1YWFBYjM5RXBkVG9R?=
 =?utf-8?B?cUp2MFczL2YvU3h1dEJIU0RoTUcwcTdMYkxMRGVtNVVqaVhOTjMrbGcrakhq?=
 =?utf-8?B?MDZzTlVMWGVSdTBsY25KWkZ0cWVpZStTcUhBOXd1Um9QSjlzdHRLTVJUdUYx?=
 =?utf-8?B?MW9jRkRiVyswS0pPbG5YYmFSREZnejVVck54anFVaysrcm5iQzdHUHppaWZs?=
 =?utf-8?B?blZDUGlHRUl6TnRUUXRKejhNbCs0UGdoZVQ3aHlvYm1JRU55ZHREL1BYd2hp?=
 =?utf-8?B?N0dsUENlTTAzTVdIZEdOSklmTmtzbnNPa1ZhVDI1NWdFdm1Vd01jbUQwdlJm?=
 =?utf-8?B?Qm0vUHNXci9wMlNtN2svSkhaaXJiWkttSk9jUnRTZURuZitaU0xJcithWWxv?=
 =?utf-8?B?dk1lVDlOMzVwdkZsVy9KSnIzS0JKd3pSaE9hbWNSS0hsRmRGY0VpMW85L1A1?=
 =?utf-8?B?dzNlVzd1YjFGc0FHUWtpMmJVNVVkZzNaRFN5aW9qY2prRjZNNytPL3BscjVj?=
 =?utf-8?B?NHphYVFlcEV1clI0eklmbUJMcHVpckI0U0p6MEkzOTlHRi8wdXU5Nk1SZjFD?=
 =?utf-8?B?Z0NOaWFpWHZOVXIxbTd0OWJ6aVFsVlJ4RHloWE55RmVIaFdTOFZuc0ZGVytK?=
 =?utf-8?B?NFVMNktaMGRWZlRwVlNDSHl3YzRoUUptdTVna3dVTmJxWG9yYWx6L1k5RTE1?=
 =?utf-8?B?c1oySFJ5VEl6SXpwZjdKbXFHc1lIbmFBTVR2OUMyWSsybXJtemZpV0FPdjQ2?=
 =?utf-8?B?Z2hjRHh2NTBZb2xhS2Rrb3d2VkR3WTVaYURyVzVwNWFZanlDMkNmSnFNYUd2?=
 =?utf-8?B?ZTlLbDVnQlZCd0Y0QlNBeitVbXFqYVp5Y0RqUFBiMHl6cG5vUnVISlRrS05o?=
 =?utf-8?B?bld5a2tmd2tQcTJpdGVBZG1YbDJJQmR2NGROUXd4LzEzS0tiYjFwMmRyV3Vn?=
 =?utf-8?B?VWxvTnBZb1N0aTlwTkFHMkVpaE9RZzI1eU5YSi9LWHRSZWpybEFnSCtYcEI1?=
 =?utf-8?B?QnpXU3hVVGNTd3BJWlg1ejJvMjBKK1htYUtUTU9KNzkydGN4WEJkRTNHeUQz?=
 =?utf-8?B?cDZTdUZ0bVNMZXVpMUl0c3JGejZnVFFUeW5NSHV6bThGMnBNY0k0cUlBY2p0?=
 =?utf-8?B?VFhKUVJIcnlTdGlLZWdYSzFGbng2RGJGNEVIRllhNGhJMzZZRmtBeXloRmQ3?=
 =?utf-8?B?bFJoTzdkR2pxazBaaWtuYnE4d0xLc2NxazF5elJqZ3M0SUhrMEwrc0ZqSXc0?=
 =?utf-8?B?c3Y4ZHVzbWpVeW8zdjIyWUxnWWloc1JjblVVQ3REekFuYUtIYWlLK0t2ZHNp?=
 =?utf-8?B?bWovclZTRUpNK0lCZCt5enVBNEVsanUxekNSZ0ZHM0NqTTNXTm5VR0tGWTVw?=
 =?utf-8?B?aDdqZzJ0ZXhjYmdmeUdESUxTN0dENTVEazljVjJ6djJ6S01QWFp3b2x4Vzdi?=
 =?utf-8?B?blFqeG02enljZlRqTE1Kd01lQlp4MVdnM1MyYW9sck44T1A4cXlWQk9GaG5Z?=
 =?utf-8?B?WGRVUzk3ZnBpTFdkOUlvYmZUUDZLT0hDdlBsNGRlTUNVQWxhdEhyQkMxK014?=
 =?utf-8?B?U1VYRWV2WUdwdGxzM3RaT0x4UnkvUFgrN0dGQWx6cG1Xa3BkdE03NG1DSFdT?=
 =?utf-8?Q?wj8mix2wq2ijuq0XUGQIoNCH4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e71bd62-53e1-4b31-ed78-08dc95ce58e0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:54:26.8992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LoGup1mZSJS8C9GuxonUE6BQdoJrzWDSyvMSzmjmYsU0f0UnCSWItsYmxORC8ul+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8661
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

Am 25.06.24 um 19:44 schrieb Alex Deucher:
> On Tue, Jun 25, 2024 at 10:32 AM Pierre-Eric Pelloux-Prayer
> <pierre-eric.pelloux-prayer@amd.com> wrote:
>> The call to radeon_vm_clear_freed might clear bo_va->bo, so
>> we have to check it before dereferencing it.
>>
>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Should I push this to drm-misc-fixes or should Pierre push it to 
amd-staging-drm-next?

Might take some minor work from you when you start to handle radeon 
change as well.

Regards,
Christian.

>
>> ---
>>   drivers/gpu/drm/radeon/radeon_gem.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
>> index 3fec3acdaf28..27225d1fe8d2 100644
>> --- a/drivers/gpu/drm/radeon/radeon_gem.c
>> +++ b/drivers/gpu/drm/radeon/radeon_gem.c
>> @@ -641,7 +641,7 @@ static void radeon_gem_va_update_vm(struct radeon_device *rdev,
>>          if (r)
>>                  goto error_unlock;
>>
>> -       if (bo_va->it.start)
>> +       if (bo_va->it.start && bo_va->bo)
>>                  r = radeon_vm_bo_update(rdev, bo_va, bo_va->bo->tbo.resource);
>>
>>   error_unlock:
>> --
>> 2.45.2
>>

