Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F6D606A32D
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RkCA5a09
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97C0A112E16;
	Fri,  6 Nov 2026 14:23:22 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C91210EA4A
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 14:23:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDJPtmkd30NmLNDrU0/5dgDZ6GLXc8POtiga/ajdgDQ3CxxtELjt4sE3BcBCbMCQ2YG2iYCyRrXwT+4OGEI+whCPMl0xDWwQNCjfzDKE6kRbhqOV44cN/Ii01q8wbL+OgaYDKHbnqII8sEa2yRTxrWdicYVMIAaUp7I/A5uUwC7tMj9atHy+TqGawncGwAWdXH5ZHnAd876oV8zC2kr/G2KzQM4z2N2yMdGAlPirM+n/m3NqWRqL/U5QXpXQd5Uhu5XFxf5iubsSpT6fML81SwtC6D4r333++ez8p4sDIYBsZMcEWlrxkqd9UQqjS4guOdajqQdj+MCpi0DdZFSFVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnBtHn6KLp5HrcxyNsnozGRgp0hZvbD6oKWQ+LG3hz0=;
 b=oSP/DM35x066KEOUV7bx5G3IPE5LJ+HAoYPFo9mVIzP97vJl78u2lyGTSiW5gfDJTvdBip3Pgol2/tiJFidliY8FTL7hqucuUCE0yjc62Z+I/L97N2mUeIv84JaZ/91U1KAkIF5w0v9XsFRnK1BvQ1BUrVT1uSBjd31RGp3VsE047MRHkda3/wrFY5vJfe7MLL7EZ9lp/OF3w68ZD8TjVAPwZ+CiscePu5zVqB98iBaWZJw58YYiYk8VZEn645tHDZ2g5nDuOrMP8gv1nXG8vuPwkc+ha5iOZsAie5y1d3uHf5X6HeWGxvExx+x+BHTOAtpmLH35PWiUg3q4klIzhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnBtHn6KLp5HrcxyNsnozGRgp0hZvbD6oKWQ+LG3hz0=;
 b=RkCA5a099IWtdfhewJG0AmVp+sP9ewQtut5q7+h0IiXowSiZrOLbWpehXLsnfQoVuJl02Mv+2+FlUuH9JLWzwAyOrEVaZe22STq0pqeXZsmfqcD4h2+UkQeY0yxSCudDx662RydK4oNjJzRsk7jYVYc2fWuYDz0h5tIlkYwMkXk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6398.namprd12.prod.outlook.com (2603:10b6:8:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 14:22:49 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 14:22:48 +0000
Message-ID: <55da7c06-b53c-49d6-9878-b03f7c339766@amd.com>
Date: Fri, 6 Nov 2026 15:22:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu/vm: free pte update job on error
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Shahyan Soltani <shahyan.soltani@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261105210020.3852328-1-benjamin.cheng@amd.com>
 <20261105210020.3852328-2-benjamin.cheng@amd.com>
 <de2d1b55-bfad-47bd-843d-2ce98006103d@amd.com>
 <76cbeae6-fb4f-4809-bdaf-b7fe5f5bd5a1@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <76cbeae6-fb4f-4809-bdaf-b7fe5f5bd5a1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:208:36e::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: 09ae920c-d25f-4d51-38ba-08df3c116f14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|4143699003|11063799006|56012099006|261026121527099003|261026140227099003|261021123027099003|261102123227099003|261022105027099003|261021121427099003|261009223027099003|261028144727099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: cOs5xXpGKPkiPECsFukp/xr63XfbUPrqzizi8XF94vpIzF/zU1PeOFF83ZqU7qzoQgKkqkDzZEWPgDA1AOyGg6IVxtY+6wEUIazTGfy32qijMilGe5to8R+EXJSeHuoG120m/2b3ifGhcU/8xDo41Yhj7GK5SEOso857bfE6bD2Z6ENNCs0fDA7J0FFdIIPYhzHIayq7bGMXwbBbjmFN6fKdL5nC53kLuK1As14qm5la7RIkUY/JNkXXbWT+Afbm1Kii8yvbh8ufuN8MyWDUQMMqpg+/HR96dEdmuwprUKiVZmUS+u12zGluGGpcd+tOzqN/jjnYf8qgnhsdYjBCeQx43dRHRut474seJrIXv9G6ae50VSa57JSEBc+X6Jxu5D4y3RN7oVX+pphecGV95R5EsTSE+ysGZo+0T3kUjFckjcX2H2F9CZA/LXRYF+nfHF2AvzHV0p0erU7Wup1MYk4wGrKcI9pMupeWj5UncOr6E8jqb6V0cy1eS2g1K7SKrmRqCMMLn8zBztbiy+cHHtoj3sQsRu+oPHfTlNG76uXqoP+fMF90biTRguC59hs1laxB0KO+IqGkfrsJurVITA18YgFaMUrO2NOs4O+KvjJ2INW7xMzOTsdGcXbvDiCwLskQYbZyN4pJtV6xhbVb4Ftnv+WzSHVhyDXuOfVazE0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261021123027099003)(261102123227099003)(261022105027099003)(261021121427099003)(261009223027099003)(261028144727099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aE11VGJFRTZkTjJDMDhRc2JIelpYYUowdWYvNEVaQi9CS1d5c0o5WVd0cFhu?=
 =?utf-8?B?alorUTBxR0k1a0daM1pGZVo3eEUyeC9JT3JKWFBodW9NcHlUa2wxNit5N2Ew?=
 =?utf-8?B?eTZLTUpXNm1YM0htblk2Q0o1NWVybkk1YStvZkcyblExdEVMWnRRUm41cjB6?=
 =?utf-8?B?bjg0ZmJNa1MrTG1vN3h0M0xUT3lTWk4wSGJVZHdIK1E5NW54OTY2QzZDWStQ?=
 =?utf-8?B?ZlR3N3l3VkIrbFZYenVkRWQzdHE2T2FmSkZ3U3c0YkI5TzZRYVVqakxVOWd2?=
 =?utf-8?B?Mm9ETmp1VUYySzdXS2JYTzdMcEE4SVlONjAyeXBLWFpEeHJ1LzRLN3VMcWxD?=
 =?utf-8?B?M2pSdDAwU1dsVjRSN3ZTU2orc0pvRGc2Q1lBS3dYajlFb0JmVnY0UTFTVTg4?=
 =?utf-8?B?M3lRa2tXUW1oVStmc3UvQzhDdkpoT1pnTkFld2RBbFBMcUZrUFd0M0dGb21P?=
 =?utf-8?B?Qkl6L1o2U1pWemlLaXZDdWJxWjIrZ0xXcjlTWkgvbDBMSFlBRnFKZmREU3Fk?=
 =?utf-8?B?YXU4V1hsNDFUQS9TNm9jQ21XU3J0YlBBNHI5VnhDaUV0SmlYRjhkSEJXZXdK?=
 =?utf-8?B?a3lmMVVhSUJsY1N5OTJEMWdlak5YREU5ODdpYk56aHZyMzJjSDJDeXJxUzJS?=
 =?utf-8?B?UStlSWVJei9XQlZpT3JESjBueHc5ekpoUE1uQy9xRXdEQ1E4djlPallESXhL?=
 =?utf-8?B?ZWo5L1dCay9lSGVTbGxrdVhlSmJmanRVUmgzcjJoMFZOMTExNzlvQ1JPUi8r?=
 =?utf-8?B?eCtWb2FyMktqUjdibHdpTzNYeE9zczZDMWhsR2dGR3EvWjRleXNna2lKVW5u?=
 =?utf-8?B?S2JTQVFmK2RKTFFLemhFNW9EWlk5YnlyMTVLeWdvNEgxK0xBQWI1ZkdGRkhQ?=
 =?utf-8?B?UHJSM2FMWHFKaWw1NG9kMk1yREQwMHprRkpNVW9WTThXZjlYRVlpM0JYWnRu?=
 =?utf-8?B?eDNXanpoSEN1eXhPbXV1b0gzN0FTSGxPRWxWSXlpUFZtM3JkWWdwL1Q1b0du?=
 =?utf-8?B?RHRMN3p5NzhMTXVnRTRhWU16THlHb1BoNUg5eE53WUxZR2tzYjJpNXM4Lzdi?=
 =?utf-8?B?OFY4cm43THRIY3I3QWdRbEJEM2pidE9DL0hFakFXallGbUFLOEhpTEg5aDZM?=
 =?utf-8?B?WlFDMC9ScURJd2RyY0QwZnF1S2YvMGsvYXY4aXJYdFdSWFNFMmxMTzdoKzJ0?=
 =?utf-8?B?YVNIYjBlQ0tNTnErZlJyYjNQTWMrQnNQbGtrb0dsUkRZNlpVeVFESUx0U0tq?=
 =?utf-8?B?cGN0Z2kzeWUzZnoxNDNSODZhZmhPK2J5dVVOMERvRVVjbDdoc3M2MWduaGYr?=
 =?utf-8?B?OHRLYWlWVDJObkRCOUVrS2xpY3gzZ3I0TVM5MmtuSHlwWWJ2cGtCbC9oUE9u?=
 =?utf-8?B?VmdrQ2dvUEdqK2xmbVJ6dzJCVUd1NDFRWU5sQ2pYZnFlWkROejREWXJadVZQ?=
 =?utf-8?B?OVdXWnQrclRiVlptV1lVRUpBT1Y0Zk04Yys0c0swNWtxbFB0ZVB0K3FjT00y?=
 =?utf-8?B?bVhka2o5MUlpT2ZRVStTRVV4am13TzkwL2FNRjhPQ1NmSlR3dmlCemdjYkVp?=
 =?utf-8?B?UVFyRlNWREJTenhVc0VsUlh2L3prdWQzRE9pbGI3cmtEOXFsM3pkS3l5RHpv?=
 =?utf-8?B?ODYzN3BZcDJtc1gyZG5ydElLRVZxdURwUWtEbEZPbXhLU0FjTnNobkozRVpO?=
 =?utf-8?B?UkJpR2hTalJSbkFKbUFSZzRHZmtPc3pEZnpwTWljU0dzb0JJZFVwUi9mY2d2?=
 =?utf-8?B?MTNHY1dDRGtYR3c2eW5iS3UvcW96RmMyOUZFVnFrVHV3Q29VNThRZWRLcFIr?=
 =?utf-8?B?TGVwZGVZdlpLRmI2N3M4SHV2bTQwWVpQU0EveXF1OWdYclJ4a1FWcDh4bUt6?=
 =?utf-8?B?dXV1SDdUWWU1OVZMWEdaRGZHTUtjeFp1WGdNTytVMDhFeXp5MFN6YUMxN3lD?=
 =?utf-8?B?VThoRjRsYlBnWFZPZFNLSHZjSWdNeUxmcGNBMDZyOW52Rzkxb0J5QmpMK2l6?=
 =?utf-8?B?V1dqNExCc3lzS3VGdy9QeldYRG1IT1NQME14QytRMCs3QzcraGdIc29sZXlO?=
 =?utf-8?B?bFBmRmdJUDNUVFNaNjQ3NUMwdkFxMzFJMDVpRU5PSHk5QjZJSURvRG02QzBw?=
 =?utf-8?B?VzNDTTRTYkF5dHFvdFBlMURlZGxFd3ljUHNnQUhHTTl4SjBKK2htYndab1Jo?=
 =?utf-8?B?Yi85TFlLUlByV3NHeXZNV1Z3MFc5RzVPQ2ovTHI2amdYVENsLzRWcDVGM3I5?=
 =?utf-8?B?YWxBUjVwdGdzUkRJa1J3MkZoTEdkRVBvcjRJQ1pKTFJzeXg5REp2NDRtbStF?=
 =?utf-8?Q?PqWtIr4/Av5iwCIKnN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ae920c-d25f-4d51-38ba-08df3c116f14
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 14:22:48.7862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w7HORk587HPyIyvTmfbBzrqFTL2p3TUhhvd/wbNU1gU0Gn7yvlS7nxdDO/aMYdnk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6398
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/6/26 15:18, Benjamin Cheng wrote:
> 
> On 2026-11-06 03:55, Christian König wrote:
>> On 11/5/26 22:00, Benjamin Cheng wrote:
>>> In the happy path, the job gets freed when the job is submitted.
>>> However, if amdgpu_vm_ptes_update failed, we don't submit the job, so we
>>> would leak the job.
>> Yeah that was already brought up upstream as well, but that here is the wrong approach to fixing this.
>>
>> Thadeu Lima de Souza Cascardo <cascardo@igalia.com> came up with a few patches on the public mailing list to tackle this as well.
>>
>> Essentially we need to commit PTE updates before we allocate any new PT, background is not only that allocating PTs can fail but also that we need to drop the lock for this and that can make the PTEs we already constructed in the SDMA IB invalid.
>>
>> I wanted to get that fixed for weeks but couldn't find time for it. Can you guys together look into that?
> 
> 
> I see, thanks I'll take a look at the previous patches.
> 
> Should we consider reverting commit 009f401fb98b ("drm/amdgpu: move amdgpu_vm_bo_update() call into correct location") in the meantime then? As I wrote in the cover letter it exposes this issue and can now be detected by IGT tests, which makes our CI flaky.
> 

What is the rational that "drm/amdgpu: move amdgpu_vm_bo_update() call into correct location" should make this flaky?

As far as I can see that is completely unrelated.

Thanks,
Christian.

> 
>> Thanks in advance,
>> Christian.
>>
>>> Fixes: 009f401fb98b ("drm/amdgpu: move amdgpu_vm_bo_update() call into correct location")
>>> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 2ba33212d507..f6cb2b5854dd 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -1274,8 +1274,11 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>  
>>>  		tmp = start + num_entries;
>>>  		r = amdgpu_vm_ptes_update(&params, start, tmp, addr, flags);
>>> -		if (r)
>>> +		if (r) {
>>> +			if (params.job)
>>> +				amdgpu_job_free(params.job);
>>>  			goto error_free;
>>> +		}
>>>  
>>>  		amdgpu_res_next(&cursor, num_entries * AMDGPU_GPU_PAGE_SIZE);
>>>  		start = tmp;

